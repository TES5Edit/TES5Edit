namespace TESVSnip.Domain.Model
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Drawing;
    using System.IO;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Text;

    using RTF;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Services;
    using TESVSnip.Framework.Collections;
    using TESVSnip.Framework.Persistence;

    [Persistable(Flags = PersistType.DeclaredOnly)]
    [Serializable]
    public sealed class Record : Rec, ISerializable, IDeserializationCallback
    {
        private static Dictionary<string, Func<string>> overrideFunctionsByType = new Dictionary<string, Func<string>>();

        private static Dictionary<Record, SubRecord[]> serializationItems;

        public readonly AdvancedList<SubRecord> SubRecords;

        [Persistable]
        public uint Flags1;

        [Persistable]
        public uint Flags2;

        [Persistable]
        public uint Flags3;

        [Persistable]
        public uint FormID;

        private readonly uint dataSize;

        private readonly Func<string> descNameOverride;

        public Record()
        {
            Name = "NEW_";
            this.SubRecords = new AdvancedList<SubRecord>();
            this.descNameOverride = this.DefaultDescriptiveName;
            this.UpdateShortDescription();
            this.FixSubrecordOwner();
        }

        internal Record(string name, uint dataSize, BinaryReader recordReader, bool oblivion)
        {
            this.dataSize = dataSize;

            this.SubRecords = new AdvancedList<SubRecord>(1) { AllowSorting = false };
            Name = name;
            this.Flags1 = recordReader.ReadUInt32();
            this.FormID = recordReader.ReadUInt32();
            this.Flags2 = recordReader.ReadUInt32();
            if (!oblivion)
            {
                this.Flags3 = recordReader.ReadUInt32();
            }

            var compressed = (this.Flags1 & 0x00040000) != 0;
            uint amountRead = 0;

            var realSize = dataSize;
            if (compressed)
            {
                realSize = recordReader.ReadUInt32();
                dataSize -= 4;
            }

            using (var stream = new MemoryStream(recordReader.ReadBytes((int)dataSize)))
            {
                using (var dataReader = compressed ? ZLib.Decompress(stream, (int)realSize) : new BinaryReader(stream))
                {
                    while (dataReader.BaseStream.Position < dataReader.BaseStream.Length)
                    {
                        var type = ReadRecName(dataReader);
                        uint size;
                        if (type == "XXXX")
                        {
                            dataReader.ReadUInt16();
                            size = dataReader.ReadUInt32();
                            type = ReadRecName(dataReader);
                            dataReader.ReadUInt16();
                        }
                        else
                        {
                            size = dataReader.ReadUInt16();
                        }

                        var record = new SubRecord(this, type, dataReader, size);
                        this.SubRecords.Add(record);
                        amountRead += (uint)record.Size2;
                    }
                }
            }

            if (amountRead > realSize)
            {
                Debug.Print(" * ERROR: SUB-RECORD {0} DATA DOESN'T MATCH THE SIZE SPECIFIED IN THE HEADER: DATA-SIZE={1} REAL-SIZE={2} AMOUNT-READ={3}", name, dataSize, realSize, amountRead);
                throw new TESParserException(
                    string.Format("Subrecord block did not match the size specified in the record header: ExpectedSize={0} ReadSize={1} DataSize={2}", realSize, amountRead, dataSize));
            }

            this.descNameOverride = this.DefaultDescriptiveName;
            this.UpdateShortDescription();

            // br.BaseStream.Position+=Size;
        }

        private Record(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
            if (serializationItems == null)
            {
                serializationItems = new Dictionary<Record, SubRecord[]>();
            }

            serializationItems[this] = info.GetValue("SubRecords", typeof(SubRecord[])) as SubRecord[];
            this.SubRecords = new AdvancedList<SubRecord>(1);
            this.descNameOverride = this.DefaultDescriptiveName;
            this.UpdateShortDescription();
        }

        private Record(Record r)
        {
            this.SubRecords = new AdvancedList<SubRecord>(r.SubRecords.Count);
            this.SubRecords.AllowSorting = false;
            foreach (var sr in r.SubRecords.OfType<SubRecord>())
            {
                this.SubRecords.Add((SubRecord)sr.Clone());
            }

            this.Flags1 = r.Flags1;
            this.Flags2 = r.Flags2;
            this.Flags3 = r.Flags3;
            this.FormID = r.FormID;
            Name = r.Name;
            this.descNameOverride = this.DefaultDescriptiveName;
            this.UpdateShortDescription();
            this.FixSubrecordOwner();
        }

        public override string DescriptiveName
        {
            get
            {
                return this.descNameOverride();
            }

            // set { base.DescriptiveName = value; }
        }

        public override long Size
        {
            get
            {
                long size = 0;
                foreach (SubRecord rec in this.SubRecords)
                {
                    size += rec.Size2;
                }

                return size;
            }
        }

        public override long Size2
        {
            get
            {
                long size = 24;
                foreach (SubRecord rec in this.SubRecords)
                {
                    size += rec.Size2;
                }

                return size;
            }
        }

        public override void AddRecord(BaseRecord br)
        {
            var sr = br as SubRecord;
            if (sr == null)
            {
                throw new TESParserException("Record to add was not of the correct type." + Environment.NewLine + "Records can only hold Subrecords.");
            }

            sr.Parent = this;
            this.SubRecords.Add(sr);
        }

        public override BaseRecord Clone()
        {
            return new Record(this);
        }

        public override bool DeleteRecord(BaseRecord br)
        {
            var sr = br as SubRecord;
            if (sr == null)
            {
                return false;
            }

            return this.SubRecords.Remove(sr);
        }

        public override string GetDesc()
        {
            return "[Record]" + Environment.NewLine + this.GetBaseDesc();
        }

        public override void GetFormattedData(RTFBuilder rb)
        {
            try
            {
                rb.FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize).ForeColor(KnownColor.DarkGray).AppendLine("[Formatted information]");
                rb.Reset();

                RecordStructure rec;
                if (!RecordStructure.Records.TryGetValue(Name, out rec))
                {
                    return;
                }

                rb.FontStyle(FontStyle.Bold).ForeColor(KnownColor.DarkBlue).FontSize(rb.DefaultFontSize + 4).AppendLine(rec.description);
                foreach (var subrec in this.SubRecords)
                {
                    if (subrec.Structure == null || subrec.Structure.elements == null || subrec.Structure.notininfo)
                    {
                        continue;
                    }

                    rb.AppendLine();
                    subrec.GetFormattedData(rb);
                }
            }
            catch
            {
                rb.ForeColor(KnownColor.Red).Append("Warning: An error occurred while processing the record. It may not conform to the structure defined in RecordStructure.xml");
            }
        }

        public override void GetFormattedHeader(RTFBuilder rb)
        {
            rb.FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize + 4).ForeColor(KnownColor.DarkGray).AppendLine("[Record]");

            rb.Append("Type: \t").FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize + 2).AppendFormat("{0}", Name).AppendLine();
            rb.Append("FormID: \t").FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize + 2).ForeColor(KnownColor.DarkRed).AppendFormat("{0:X8}", this.FormID).AppendLine();
            rb.AppendLineFormat("Flags 1: \t{0:X8}", this.Flags1);
            if (this.Flags1 != 0)
            {
                rb.AppendLineFormat(" ({0})", FlagDefs.GetRecFlags1Desc(this.Flags1));
            }

            rb.AppendLineFormat("Flags 2: \t{0:X8}", this.Flags2);
            rb.AppendLineFormat("Flags 3: \t{0:X8}", this.Flags3);
            rb.AppendLineFormat("Size: \t{0:N0}", this.Size);
            rb.AppendLineFormat("Subrecords:\t{0}", this.SubRecords.Count);
            rb.AppendPara();
        }

        /// <summary>
        /// Generate hyperlink for a given identifier of form [plugin]@[type]:[recid]
        /// </summary>
        /// <param name="value">
        /// </param>
        /// <returns>
        /// The System.String.
        /// </returns>
        public string GetLink()
        {
            var p = this.GetPlugin();

            // uint pidx = value >> 24;
            if (p != null)
            {
                return string.Format("{0}@{1}:{2:X8}", p.Name, Name, this.FormID);
            }

            return string.Format("{0}:{1:X8}", Name, this.FormID);
        }

        public Plugin GetPlugin()
        {
            BaseRecord tn = Parent;
            while (!(tn is Plugin) && tn != null)
            {
                tn = tn.Parent;
            }

            if (tn != null)
            {
                return tn as Plugin;
            }

            return null;
        }

        public override void InsertRecord(int idx, BaseRecord br)
        {
            var sr = br as SubRecord;
            if (sr == null)
            {
                throw new TESParserException("Record to add was not of the correct type." + Environment.NewLine + "Records can only hold Subrecords.");
            }

            sr.Parent = this;
            this.SubRecords.Insert(idx, sr);
        }

        /// <summary>
        /// Routine to match subrecord definitions to subrecord instances
        /// </summary>
        /// <returns>
        /// The System.Boolean.
        /// </returns>
        public bool MatchRecordStructureToRecord()
        {
            var subs = this.SubRecords.ToArray();
            return this.MatchRecordStructureToRecord(subs);
        }

        public bool MatchRecordStructureToRecord(SubRecord[] subs)
        {
            try
            {
                if (RecordStructure.Records == null)
                {
                    return false;
                }

                RecordStructure rs;
                if (!RecordStructure.Records.TryGetValue(Name, out rs))
                {
                    return false;
                }

                var subrecords = new List<SubrecordStructure>();
                var sss = rs.subrecordTree;
                foreach (var sub in subs)
                {
                    sub.DetachStructure();
                }

                var conditions = new Dictionary<int, Conditional>();
                var context = new LoopContext(0, sss);
                var result = this.InnerLoop(subs, conditions, context);
                if (result == LoopContext.LoopEvalResult.Success && context.idx == subs.Length)
                {
                    return true;
                }
            }
            catch
            {
            }

            return false;
        }

        public override void UpdateShortDescription()
        {
            if (Name == "REFR")
            {
                // temporary hack for references
                var edid = this.SubRecords.FirstOrDefault(x => x.Name == "EDID");
                string desc = (edid != null) ? string.Format(" ({0})", edid.GetStrData()) : string.Empty;

                // var name = SubRecords.FirstOrDefault( x => x.Name == "NAME" );
                var data = this.SubRecords.FirstOrDefault(x => x.Name == "DATA");
                if (data != null)
                {
                    desc = string.Format(" [{1},{2}]\t{0}", desc, (int)(data.GetValue<float>(0) / 4096.0f), (int)(data.GetValue<float>(4) / 4096.0f));
                }

                descriptiveName = desc;
            }
            else if (Name == "ACHR")
            {
                // temporary hack for references
                var edid = this.SubRecords.FirstOrDefault(x => x.Name == "EDID");
                string desc = (edid != null) ? string.Format(" ({0})", edid.GetStrData()) : string.Empty;
                var data = this.SubRecords.FirstOrDefault(x => x.Name == "DATA");
                if (data != null)
                {
                    desc = string.Format(" [{1},{2}]\t{0}", desc, (int)(data.GetValue<float>(0) / 4096.0f), (int)(data.GetValue<float>(4) / 4096.0f));
                }

                descriptiveName = desc;
            }
            else if (Name == "CELL")
            {
                var edid = this.SubRecords.FirstOrDefault(x => x.Name == "EDID");
                string desc = (edid != null) ? desc = " (" + edid.GetStrData() + ")" : string.Empty;

                var xclc = this.SubRecords.FirstOrDefault(x => x.Name == "XCLC");
                if (xclc != null)
                {
                    desc = string.Format(" [{1:F0},{2:F0}]\t{0}", desc, xclc.GetValue<int>(0), xclc.GetValue<int>(4));
                }
                else
                {
                    desc = string.Format(" [Intr]\t{0}", desc);
                }

                descriptiveName = desc;
            }
            else
            {
                var edid = this.SubRecords.FirstOrDefault(x => x.Name == "EDID");
                if (edid != null)
                {
                    descriptiveName = " (" + edid.GetStrData() + ")";
                }
                else
                {
                    descriptiveName = string.Empty;
                }
            }
        }

        void IDeserializationCallback.OnDeserialization(object sender)
        {
            if (serializationItems != null)
            {
                SubRecord[] items;
                if (serializationItems.TryGetValue(this, out items))
                {
                    serializationItems.Remove(this);
                    this.SubRecords.AddRange(items.OfType<SubRecord>().ToList());
                    this.FixSubrecordOwner();
                }

                if (serializationItems.Count == 0)
                {
                    serializationItems = null;
                }
            }
        }

        void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
        {
            info.AddValue("SubRecords", this.SubRecords.ToArray());
            PersistAssist.Serialize(this, info, context);
        }

        /// <summary>
        /// </summary>
        /// <param name="sr">
        /// </param>
        /// <param name="rawData">
        /// Retain raw data instead of converting to more usuable form 
        /// </param>
        /// <returns>
        /// The System.Collections.Generic.IEnumerable`1[T -&gt; TESVSnip.Element].
        /// </returns>
        internal IEnumerable<Element> EnumerateElements(SubRecord sr, bool rawData)
        {
            if (sr == null)
            {
                return new Element[0];
            }

            return sr.EnumerateElements(rawData);
        }

        internal IEnumerable<Element> EnumerateElements(SubRecord sr)
        {
            return this.EnumerateElements(sr, false);
        }

        internal IEnumerable<Element> EnumerateElements(SubRecord sr, Dictionary<int, Conditional> conditions)
        {
            if (sr == null)
            {
                return new Element[0];
            }

            return sr.EnumerateElements(conditions);
        }

        internal string GetDesc(ISelectionContext context)
        {
            string start = "[Record]" + Environment.NewLine + this.GetBaseDesc();
            string end;
            try
            {
                end = this.GetExtendedDesc(context);
            }
            catch
            {
                end = "Warning: An error occurred while processing the record. It may not conform to the structure defined in RecordStructure.xml";
            }

            if (end == null)
            {
                return start;
            }
            else
            {
                return start + Environment.NewLine + Environment.NewLine + "[Formatted information]" + Environment.NewLine + end;
            }
        }

        internal override List<string> GetIDs(bool lower)
        {
            var list = new List<string>();
            foreach (SubRecord sr in this.SubRecords)
            {
                list.AddRange(sr.GetIDs(lower));
            }

            return list;
        }

        internal override void SaveData(BinaryWriter writer)
        {
            var position = writer.BaseStream.Position;
            WriteString(writer, Name);

            uint realSize;
            var compressed = false;
            byte[] data;
            using (var stream = new MemoryStream())
            {
                var dataWriter = new BinaryWriter(stream);
                foreach (var subRecord in this.SubRecords)
                {
                    subRecord.SaveData(dataWriter);
                }

                realSize = (uint)stream.Length;

                if (Properties.Settings.Default.UseDefaultRecordCompression)
                {
                    compressed = ((this.Flags1 & 0x00040000) != 0) || (Properties.Settings.Default.EnableAutoCompress && Compressor.CompressRecord(Name))
                                 || (Properties.Settings.Default.EnableCompressionLimit && (realSize >= Properties.Settings.Default.CompressionLimit));
                }

                data = stream.ToArray();
                if (compressed)
                {
                    data = ZLib.Compress(data);
                }
            }

            var dataSize = (uint)data.Length;
            var flags = this.Flags1 & ~0x00040000U;
            if (compressed)
            {
                dataSize += 4;
                flags |= 0x00040000;

                Debug.WriteLineIf(
                    this.dataSize != dataSize, 
                    string.Format(
                        "COMPRESSED RECORD [NAME={0} AT POSITION={1}] SIZE DIFFERS FROM ORIGINAL: ORIGINAL={2} ACTUAL={3}, RAW RECORD SIZE={4}", Name, position, this.dataSize, dataSize, realSize));
            }

            writer.Write(dataSize); // Size of compressed section + length
            writer.Write(flags);
            writer.Write(this.FormID);
            writer.Write(this.Flags2);
            writer.Write(this.Flags3);
            if (compressed)
            {
                writer.Write(realSize);
            }

            writer.Write(data, 0, data.Length);
        }

        private static bool MatchRecordCheckCondition(Dictionary<int, Conditional> conditions, SubrecordStructure ss)
        {
            if (ss.Condition == CondType.Exists)
            {
                if (conditions.ContainsKey(ss.CondID))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else if (ss.Condition == CondType.Missing)
            {
                if (conditions.ContainsKey(ss.CondID))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }

            Conditional cond;
            if (!conditions.TryGetValue(ss.CondID, out cond))
            {
                return false;
            }

            switch (cond.type)
            {
                case ElementValueType.SByte:
                case ElementValueType.Byte:
                case ElementValueType.UShort:
                case ElementValueType.Short:
                case ElementValueType.Int:
                case ElementValueType.UInt:
                case ElementValueType.FormID:
                    {
                        int i = Convert.ToInt32(cond.value), i2;
                        if (!int.TryParse(ss.CondOperand, out i2))
                        {
                            return false;
                        }

                        switch (ss.Condition)
                        {
                            case CondType.Equal:
                                return i == i2;
                            case CondType.Not:
                                return i != i2;
                            case CondType.Less:
                                return i < i2;
                            case CondType.Greater:
                                return i > i2;
                            case CondType.GreaterEqual:
                                return i >= i2;
                            case CondType.LessEqual:
                                return i <= i2;
                            default:
                                return false;
                        }
                    }

                case ElementValueType.Float:
                    {
                        float i = (float)cond.value, i2;
                        if (!float.TryParse(ss.CondOperand, out i2))
                        {
                            return false;
                        }

                        switch (ss.Condition)
                        {
                            case CondType.Equal:
                                return i == i2;
                            case CondType.Not:
                                return i != i2;
                            case CondType.Less:
                                return i < i2;
                            case CondType.Greater:
                                return i > i2;
                            case CondType.GreaterEqual:
                                return i >= i2;
                            case CondType.LessEqual:
                                return i <= i2;
                            default:
                                return false;
                        }
                    }

                case ElementValueType.Str4:
                case ElementValueType.BString:
                case ElementValueType.IString:
                case ElementValueType.String:
                    {
                        var s = (string)cond.value;
                        switch (ss.Condition)
                        {
                            case CondType.Equal:
                                return s == ss.CondOperand;
                            case CondType.Not:
                                return s != ss.CondOperand;
                            case CondType.StartsWith:
                                return s.StartsWith(ss.CondOperand);
                            case CondType.EndsWith:
                                return s.EndsWith(ss.CondOperand);
                            case CondType.Contains:
                                return s.Contains(ss.CondOperand);
                            default:
                                return false;
                        }
                    }

                case ElementValueType.LString:
                    {
                        int i = (int)cond.value, i2;
                        if (!int.TryParse(ss.CondOperand, out i2))
                        {
                            return false;
                        }

                        switch (ss.Condition)
                        {
                            case CondType.Equal:
                                return i == i2;
                            case CondType.Not:
                                return i != i2;
                            case CondType.Less:
                                return i < i2;
                            case CondType.Greater:
                                return i > i2;
                            case CondType.GreaterEqual:
                                return i >= i2;
                            case CondType.LessEqual:
                                return i <= i2;
                            default:
                                return false;
                        }
                    }

                default:
                    return false;
            }
        }

        private string DefaultDescriptiveName()
        {
            return base.DescriptiveName;
        }

        private void FixSubrecordOwner()
        {
            foreach (var sr in this.SubRecords)
            {
                sr.Parent = this;
            }
        }

        private string GetBaseDesc()
        {
            return "Type: " + Name + Environment.NewLine + "FormID: " + this.FormID.ToString("x8") + Environment.NewLine + "Flags 1: " + this.Flags1.ToString("x8")
                   + (this.Flags1 == 0 ? string.Empty : " (" + FlagDefs.GetRecFlags1Desc(this.Flags1) + ")") + Environment.NewLine + "Flags 2: " + this.Flags2.ToString("x8") + Environment.NewLine + "Flags 3: "
                   + this.Flags3.ToString("x8") + Environment.NewLine + "Subrecords: " + this.SubRecords.Count.ToString() + Environment.NewLine + "Size: " + this.Size.ToString()
                   + " bytes (excluding header)";
        }

        private string GetExtendedDesc(ISelectionContext selectContext)
        {
            var context = selectContext.Clone();
            try
            {
                context.Record = this;
                RecordStructure rec;
                if (!RecordStructure.Records.TryGetValue(Name, out rec))
                {
                    return string.Empty;
                }

                var s = new StringBuilder();
                s.AppendLine(rec.description);
                foreach (var subrec in this.SubRecords)
                {
                    if (subrec.Structure == null)
                    {
                        continue;
                    }

                    if (subrec.Structure.elements == null)
                    {
                        return s.ToString();
                    }

                    if (subrec.Structure.notininfo)
                    {
                        continue;
                    }

                    s.AppendLine();
                    s.Append(subrec.GetFormattedData());
                }

                return s.ToString();
            }
            finally
            {
                context.Reset();
            }
        }

        private string GetLocalizedString(dLStringLookup strLookup)
        {
            return default(string);
        }

        private LoopContext.LoopEvalResult InnerLoop(SubRecord[] subs, Dictionary<int, Conditional> conditions, LoopContext context)
        {
            while (true)
            {
                if (context.idx >= subs.Length || context.ssidx >= context.sss.Length)
                {
                    return LoopContext.LoopEvalResult.Success;
                }

                var ssb = context.sss[context.ssidx];
                var sb = subs[context.idx];
                if (ssb is SubrecordGroup)
                {
                    var sg = ssb as SubrecordGroup;
                    var newcontext = new LoopContext(context.idx, sg.elements);
                    LoopContext.LoopEvalResult result = this.InnerLoop(subs, conditions, newcontext);
                    if (context.idx == newcontext.idx)
                    {
                        if (ssb.optional > 0 || (ssb.repeat > 0 && context.matches > 0))
                        {
                            ++context.ssidx;
                            context.matches = 0;
                            continue;
                        }
                    }
                    else if (result == LoopContext.LoopEvalResult.Success)
                    {
                        if (ssb.repeat == 0)
                        {
                            ++context.ssidx;
                        }
                        else
                        {
                            ++context.matches;
                        }

                        context.idx = newcontext.idx;
                        continue;
                    }

                    break;
                }
                else if (ssb is SubrecordStructure)
                {
                    var ss = (SubrecordStructure)ssb;
                    if (ss.Condition != CondType.None && !MatchRecordCheckCondition(conditions, ss))
                    {
                        ++context.ssidx;
                        continue;
                    }

                    if (sb.Name == ss.name && (ss.size == 0 || ss.size == sb.Size))
                    {
                        sb.AttachStructure(ss);
                        if (ss.ContainsConditionals)
                        {
                            foreach (var elem in this.EnumerateElements(sb))
                            {
                                if (elem != null && elem.Structure != null)
                                {
                                    var es = elem.Structure;
                                    if (es.CondID != 0)
                                    {
                                        conditions[es.CondID] = new Conditional(elem.Type, elem.Value);
                                    }
                                }
                            }
                        }

                        ++context.idx;
                        if (ss.repeat == 0)
                        {
                            ++context.ssidx;
                            context.matches = 0;
                        }
                        else
                        {
                            // keep ss context and try again
                            ++context.matches;
                        }

                        continue;
                    }
                    else
                    {
                        if (ss.optional > 0 || (ss.repeat > 0 && context.matches > 0))
                        {
                            ++context.ssidx;
                            context.matches = 0;
                            continue;
                        }
                        else
                        {
                            // true failure
                            break;
                        }
                    }
                }
            }

            return LoopContext.LoopEvalResult.Failed;
        }

        private class LoopContext
        {
            public readonly SubrecordBase[] sss;

            public int idx;

            public int matches;

            public int ssidx;

            public LoopContext(int start, SubrecordBase[] sss)
            {
                this.idx = start;
                this.ssidx = 0;
                this.sss = sss;
                this.matches = 0;
            }

            public enum LoopEvalResult
            {
                Failed, // no matches
                Success, // some matched
            }
        }
    }
}
