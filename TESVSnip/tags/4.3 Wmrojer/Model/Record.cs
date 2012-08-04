using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using RTF;
using TESVSnip.Collections.Generic;
using TESVSnip.Data;

namespace TESVSnip
{
    [Persistable(Flags = PersistType.DeclaredOnly), Serializable]
    public sealed class Record : Rec, ISerializable, IDeserializationCallback
    {
        public readonly AdvancedList<SubRecord> SubRecords;
        [Persistable] public uint Flags1;
        [Persistable] public uint Flags2;
        [Persistable] public uint Flags3;
        [Persistable] public uint FormID;

        private static Dictionary<string, Func<string>> overrideFunctionsByType = new Dictionary<string, Func<string>>();
        private readonly Func<string> descNameOverride;

        public override long Size
        {
            get
            {
                long size = 0;
                foreach (SubRecord rec in SubRecords) size += rec.Size2;
                return size;
            }
        }

        public override long Size2
        {
            get
            {
                long size = 24;
                foreach (SubRecord rec in SubRecords) size += rec.Size2;
                return size;
            }
        }

        public override bool DeleteRecord(BaseRecord br)
        {
            var sr = br as SubRecord;
            if (sr == null) return false;
            return SubRecords.Remove(sr);
        }

        public override void AddRecord(BaseRecord br)
        {
            var sr = br as SubRecord;
            if (sr == null)
                throw new TESParserException("Record to add was not of the correct type." +
                                             Environment.NewLine + "Records can only hold Subrecords.");
            sr.Parent = this;
            SubRecords.Add(sr);
        }

        public override void InsertRecord(int idx, BaseRecord br)
        {
            var sr = br as SubRecord;
            if (sr == null)
                throw new TESParserException("Record to add was not of the correct type." +
                                             Environment.NewLine + "Records can only hold Subrecords.");
            sr.Parent = this;
            SubRecords.Insert(idx, sr);
        }

        // due to weird 'bug' in serialization of arrays we do not have access to children yet.
        private static Dictionary<Record, SubRecord[]> serializationItems;

        private Record(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
            if (serializationItems == null)
                serializationItems = new Dictionary<Record, SubRecord[]>();
            serializationItems[this] = info.GetValue("SubRecords", typeof (SubRecord[])) as SubRecord[];
            SubRecords = new AdvancedList<SubRecord>(1);
            descNameOverride = DefaultDescriptiveName;
            UpdateShortDescription();
        }

        void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
        {
            info.AddValue("SubRecords", SubRecords.ToArray());
            PersistAssist.Serialize(this, info, context);
        }

        void IDeserializationCallback.OnDeserialization(object sender)
        {
            if (serializationItems != null)
            {
                SubRecord[] items;
                if (serializationItems.TryGetValue(this, out items))
                {
                    serializationItems.Remove(this);
                    SubRecords.AddRange(items.OfType<SubRecord>().ToList());
                    FixSubrecordOwner();
                }
                if (serializationItems.Count == 0)
                    serializationItems = null;
            }
        }

        internal Record(string name, uint Size, BinaryReader br, bool Oblivion)
        {
            SubRecords = new AdvancedList<SubRecord>(1);
            SubRecords.AllowSorting = false;
            Name = name;
            Flags1 = br.ReadUInt32();
            FormID = br.ReadUInt32();
            Flags2 = br.ReadUInt32();
            if (!Oblivion) Flags3 = br.ReadUInt32();
            if ((Flags1 & 0x00040000) > 0)
            {
                //Flags1 ^= 0x00040000;
                uint newSize = br.ReadUInt32();
                br = Decompressor.Decompress(br, (int) (Size - 4), (int) newSize);
                Size = newSize;
            }
            uint AmountRead = 0;
            while (AmountRead < Size)
            {
                string s = ReadRecName(br);
                uint i = 0;
                if (s == "XXXX")
                {
                    br.ReadUInt16();
                    i = br.ReadUInt32();
                    s = ReadRecName(br);
                }
                var r = new SubRecord(this, s, br, i);
                AmountRead += (uint) (r.Size2);
                SubRecords.Add(r);
            }
            if (AmountRead > Size)
            {
                throw new TESParserException("Subrecord block did not match the size specified in the record header");
            }
            descNameOverride = DefaultDescriptiveName;
            UpdateShortDescription();
            //br.BaseStream.Position+=Size;
        }

        private Record(Record r)
        {
            SubRecords = new AdvancedList<SubRecord>(r.SubRecords.Count);
            SubRecords.AllowSorting = false;
            foreach (var sr in r.SubRecords.OfType<SubRecord>())
                SubRecords.Add((SubRecord) sr.Clone());
            Flags1 = r.Flags1;
            Flags2 = r.Flags2;
            Flags3 = r.Flags3;
            FormID = r.FormID;
            Name = r.Name;
            descNameOverride = DefaultDescriptiveName;
            UpdateShortDescription();
            FixSubrecordOwner();
        }

        public Record()
        {
            Name = "NEW_";
            SubRecords = new AdvancedList<SubRecord>();
            descNameOverride = DefaultDescriptiveName;
            UpdateShortDescription();
            FixSubrecordOwner();
        }

        private void FixSubrecordOwner()
        {
            foreach (var sr in SubRecords)
                sr.Parent = this;
        }

        public Plugin GetPlugin()
        {
            BaseRecord tn = this.Parent;
            while (!(tn is Plugin) && tn != null) tn = tn.Parent;
            if (tn != null) return tn as Plugin;
            return null;
        }


        public override BaseRecord Clone()
        {
            return new Record(this);
        }

        private string DefaultDescriptiveName()
        {
            return base.DescriptiveName;
        }

        public override string DescriptiveName
        {
            get { return descNameOverride(); }
            //set { base.DescriptiveName = value; }
        }

        public override void UpdateShortDescription()
        {
            if (Name == "REFR") // temporary hack for references
            {
                var edid = SubRecords.FirstOrDefault(x => x.Name == "EDID");
                string desc = (edid != null) ? string.Format(" ({0})", edid.GetStrData()) : "";
                //var name = SubRecords.FirstOrDefault( x => x.Name == "NAME" );
                var data = SubRecords.FirstOrDefault(x => x.Name == "DATA");
                if (data != null)
                {
                    desc = string.Format(" [{1},{2}]\t{0}",
                                         desc, (int) (data.GetValue<float>(0)/4096.0f),
                                         (int) (data.GetValue<float>(4)/4096.0f)
                        );
                }
                descriptiveName = desc;
            }
            else if (Name == "ACHR") // temporary hack for references
            {
                var edid = SubRecords.FirstOrDefault(x => x.Name == "EDID");
                string desc = (edid != null) ? string.Format(" ({0})", edid.GetStrData()) : "";
                var data = SubRecords.FirstOrDefault(x => x.Name == "DATA");
                if (data != null)
                {
                    desc = string.Format(" [{1},{2}]\t{0}",
                                         desc, (int) (data.GetValue<float>(0)/4096.0f),
                                         (int) (data.GetValue<float>(4)/4096.0f)
                        );
                }
                descriptiveName = desc;
            }
            else if (Name == "CELL")
            {
                var edid = SubRecords.FirstOrDefault(x => x.Name == "EDID");
                string desc = (edid != null) ? desc = " (" + edid.GetStrData() + ")" : "";

                var xclc = SubRecords.FirstOrDefault(x => x.Name == "XCLC");
                if (xclc != null)
                {
                    desc = string.Format(" [{1:F0},{2:F0}]\t{0}",
                                         desc, xclc.GetValue<int>(0), xclc.GetValue<int>(4)
                        );
                }
                else
                {
                    desc = string.Format(" [Intr]\t{0}", desc);
                }
                descriptiveName = desc;
            }
            else
            {
                var edid = SubRecords.FirstOrDefault(x => x.Name == "EDID");
                if (edid != null) descriptiveName = " (" + edid.GetStrData() + ")";
                else descriptiveName = "";
            }
        }

        private string GetBaseDesc()
        {
            return "Type: " + Name + Environment.NewLine +
                   "FormID: " + FormID.ToString("x8") + Environment.NewLine +
                   "Flags 1: " + Flags1.ToString("x8") +
                   (Flags1 == 0 ? "" : " (" + FlagDefs.GetRecFlags1Desc(Flags1) + ")") +
                   Environment.NewLine +
                   "Flags 2: " + Flags2.ToString("x8") + Environment.NewLine +
                   "Flags 3: " + Flags3.ToString("x8") + Environment.NewLine +
                   "Subrecords: " + SubRecords.Count.ToString() + Environment.NewLine +
                   "Size: " + Size.ToString() + " bytes (excluding header)";
        }

        private string GetLocalizedString(dLStringLookup strLookup)
        {
            return default(string);
        }

        public override string GetDesc()
        {
            return "[Record]" + Environment.NewLine + GetBaseDesc();
        }

        public override void GetFormattedHeader(RTFBuilder rb)
        {
            rb.FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize + 4).ForeColor(KnownColor.DarkGray).AppendLine(
                "[Record]");


            rb.Append("Type: \t").FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize + 2).AppendFormat("{0}", Name).
                AppendLine();
            rb.Append("FormID: \t").FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize + 2).ForeColor(
                KnownColor.DarkRed).AppendFormat("{0:X8}", FormID).AppendLine();
            rb.AppendLineFormat("Flags 1: \t{0:X8}", Flags1);
            if (Flags1 != 0) rb.AppendLineFormat(" ({0})", FlagDefs.GetRecFlags1Desc(Flags1));
            rb.AppendLineFormat("Flags 2: \t{0:X8}", Flags2);
            rb.AppendLineFormat("Flags 3: \t{0:X8}", Flags3);
            rb.AppendLineFormat("Size: \t{0:N0}", Size);
            rb.AppendLineFormat("Subrecords:\t{0}", SubRecords.Count);
            rb.AppendPara();
        }

        public override void GetFormattedData(RTFBuilder rb)
        {
            try
            {
                rb.FontStyle(FontStyle.Bold).FontSize(rb.DefaultFontSize).ForeColor(KnownColor.DarkGray).AppendLine(
                    "[Formatted information]");
                rb.Reset();

                RecordStructure rec;
                if (!RecordStructure.Records.TryGetValue(Name, out rec))
                    return;
                rb.FontStyle(FontStyle.Bold).ForeColor(KnownColor.DarkBlue).FontSize(rb.DefaultFontSize + 4).AppendLine(
                    rec.description);
                foreach (var subrec in SubRecords)
                {
                    if (subrec.Structure == null || subrec.Structure.elements == null || subrec.Structure.notininfo)
                        continue;
                    rb.AppendLine();
                    subrec.GetFormattedData(rb);
                }
            }
            catch
            {
                rb.ForeColor(KnownColor.Red).Append(
                    "Warning: An error occurred while processing the record. It may not conform to the structure defined in RecordStructure.xml");
            }
        }

        internal string GetDesc(SelectionContext context)
        {
            string start = "[Record]" + Environment.NewLine + GetBaseDesc();
            string end;
            try
            {
                end = GetExtendedDesc(context);
            }
            catch
            {
                end =
                    "Warning: An error occurred while processing the record. It may not conform to the structure defined in RecordStructure.xml";
            }
            if (end == null) return start;
            else
                return start + Environment.NewLine + Environment.NewLine + "[Formatted information]" +
                       Environment.NewLine + end;
        }

        #region Extended Description

        private string GetExtendedDesc(SelectionContext selectContext)
        {
            var context = selectContext.Clone();
            try
            {
                context.Record = this;
                RecordStructure rec;
                if (!RecordStructure.Records.TryGetValue(Name, out rec))
                    return "";
                var s = new StringBuilder();
                s.AppendLine(rec.description);
                foreach (var subrec in SubRecords)
                {
                    if (subrec.Structure == null)
                        continue;
                    if (subrec.Structure.elements == null)
                        return s.ToString();
                    if (subrec.Structure.notininfo)
                        continue;
                    s.AppendLine();
                    s.Append(subrec.GetFormattedData());
                }
                return s.ToString();
            }
            finally
            {
                context.Record = null;
                context.SubRecord = null;
                context.Conditions.Clear();
            }
        }

        #endregion

        internal override void SaveData(BinaryWriter bw)
        {
            WriteString(bw, Name);
            var srSize = (uint) Size;

            bool bCompress = false;
            if (Properties.Settings.Default.UseDefaultRecordCompression)
            {
                bCompress = ((Flags1 & 0x00040000) != 0)
                            || (Properties.Settings.Default.EnableAutoCompress && Compressor.CompressRecord(Name))
                            || (Properties.Settings.Default.EnableCompressionLimit &&
                                (srSize >= Properties.Settings.Default.CompressionLimit));
            }
            if (bCompress) // compressed
            {
                var stream = Compressor.GetSharedStream();
                using (var writer = Compressor.AllocWriter(stream))
                    foreach (SubRecord sr in SubRecords) sr.SaveData(writer);

                bw.Write((uint) stream.Length + 4); // Size of compressed section + length
                bw.Write((Flags1 | 0x00040000));
                bw.Write(FormID);
                bw.Write(Flags2);
                bw.Write(Flags3);

                stream.Position = 0;
                bw.Write(srSize); //ideally use writer bytes written but should be same
                Compressor.CopyTo(bw, stream);
            }
            else
            {
                bw.Write(srSize);
                bw.Write((uint) (Flags1 & ~0x00040000));
                bw.Write(FormID);
                bw.Write(Flags2);
                bw.Write(Flags3);
                foreach (SubRecord sr in SubRecords) sr.SaveData(bw);
            }
        }

        internal override List<string> GetIDs(bool lower)
        {
            var list = new List<string>();
            foreach (SubRecord sr in SubRecords) list.AddRange(sr.GetIDs(lower));
            return list;
        }

        #region Match subrecords

        private class LoopContext
        {
            public enum LoopEvalResult
            {
                Failed, // no matches
                Success, // some matched
            }

            public int idx;
            public int matches;

            public int ssidx;
            public readonly SubrecordBase[] sss;

            public LoopContext(int start, SubrecordBase[] sss)
            {
                idx = start;
                ssidx = 0;
                this.sss = sss;
                matches = 0;
            }
        }


        private LoopContext.LoopEvalResult InnerLoop(SubRecord[] subs, Dictionary<int, Conditional> conditions,
                                                     LoopContext context)
        {
            while (true)
            {
                if (context.idx >= subs.Length || context.ssidx >= context.sss.Length)
                    return LoopContext.LoopEvalResult.Success;

                var ssb = context.sss[context.ssidx];
                var sb = subs[context.idx];
                if (ssb is SubrecordGroup)
                {
                    var sg = ssb as SubrecordGroup;
                    var newcontext = new LoopContext(context.idx, sg.elements);
                    LoopContext.LoopEvalResult result = InnerLoop(subs, conditions, newcontext);
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
                            ++context.ssidx;
                        else
                            ++context.matches;
                        context.idx = newcontext.idx;
                        continue;
                    }
                    break;
                }
                else if (ssb is SubrecordStructure)
                {
                    var ss = (SubrecordStructure) ssb;
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
                            foreach (var elem in EnumerateElements(sb))
                            {
                                if (elem != null && elem.Structure != null)
                                {
                                    var es = elem.Structure;
                                    if (es.CondID != 0)
                                        conditions[es.CondID] = new Conditional(elem.Type, elem.Value);
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

        private static bool MatchRecordCheckCondition(Dictionary<int, Conditional> conditions, SubrecordStructure ss)
        {
            if (ss.Condition == CondType.Exists)
            {
                if (conditions.ContainsKey(ss.CondID)) return true;
                else return false;
            }
            else if (ss.Condition == CondType.Missing)
            {
                if (conditions.ContainsKey(ss.CondID)) return false;
                else return true;
            }
            Conditional cond;
            if (!conditions.TryGetValue(ss.CondID, out cond))
                return false;
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
                        if (!int.TryParse(ss.CondOperand, out i2)) return false;
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
                        float i = (float) cond.value, i2;
                        if (!float.TryParse(ss.CondOperand, out i2)) return false;
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
                        var s = (string) cond.value;
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
                        int i = (int) cond.value, i2;
                        if (!int.TryParse(ss.CondOperand, out i2)) return false;
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

        /// <summary>
        /// Routine to match subrecord definitions to subrecord instances
        /// </summary>
        /// <returns></returns>
        public bool MatchRecordStructureToRecord()
        {
            var subs = SubRecords.ToArray();
            return MatchRecordStructureToRecord(subs);
        }

        public bool MatchRecordStructureToRecord(SubRecord[] subs)
        {
            try
            {
                if (RecordStructure.Records == null) return false;
                RecordStructure rs;
                if (!RecordStructure.Records.TryGetValue(Name, out rs))
                    return false;
                var subrecords = new List<SubrecordStructure>();
                var sss = rs.subrecordTree;
                foreach (var sub in subs) sub.DetachStructure();
                var conditions = new Dictionary<int, Conditional>();
                var context = new LoopContext(0, sss);
                var result = InnerLoop(subs, conditions, context);
                if (result == LoopContext.LoopEvalResult.Success && context.idx == subs.Length)
                    return true;
            }
            catch
            {
            }
            return false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sr"></param>
        /// <param name="rawData">Retain raw data instead of converting to more usuable form</param>
        /// <returns></returns>
        internal IEnumerable<Element> EnumerateElements(SubRecord sr, bool rawData)
        {
            if (sr == null) return new Element[0];
            return sr.EnumerateElements(rawData);
        }

        internal IEnumerable<Element> EnumerateElements(SubRecord sr)
        {
            return EnumerateElements(sr, false);
        }

        internal IEnumerable<Element> EnumerateElements(SubRecord sr, Dictionary<int, Conditional> conditions)
        {
            if (sr == null) return new Element[0];
            return sr.EnumerateElements(conditions);
        }

        #endregion


        /// <summary>
        /// Generate hyperlink for a given identifier of form [plugin]@[type]:[recid]
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public string GetLink()
        {
            var p = GetPlugin();
            //uint pidx = value >> 24;
            if (p != null)
            {
                return string.Format("{0}@{1}:{2:X8}", p.Name, this.Name, this.FormID);
            }
            return string.Format("{0}:{1:X8}", this.Name, this.FormID);
        }
    }
}