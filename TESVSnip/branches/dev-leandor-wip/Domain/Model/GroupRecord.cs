namespace TESVSnip.Domain.Model
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Runtime.InteropServices;
    using System.Runtime.Serialization;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework.Persistence;
    using TESVSnip.Framework.Services;

    [Persistable(Flags = PersistType.DeclaredOnly)]
    [Serializable]
    public sealed class GroupRecord : Rec, IDeserializationCallback, IGroupRecord
    {
        [Persistable]
        public uint dateStamp;

        [Persistable]
        public uint flags;

        [Persistable]
        public uint groupType;

        [Persistable]
        private readonly byte[] data;

        [Persistable]
        private readonly List<Rec> records = new List<Rec>(1);

        public GroupRecord(string data)
        {
            Name = "GRUP";
            this.data = new byte[4];
            for (int i = 0; i < 4; i++)
            {
                this.data[i] = (byte)data[i];
            }

            this.UpdateShortDescription();
        }

        internal GroupRecord(uint Size, BinaryReader br, bool Oblivion, string[] recFilter, bool filterAll)
        {
            Name = "GRUP";
            this.data = br.ReadBytes(4);
            this.groupType = br.ReadUInt32();
            this.dateStamp = br.ReadUInt32();
            string contentType = this.groupType == 0 ? Encoding.Instance.GetString(this.data) : string.Empty;
            if (!Oblivion)
            {
                this.flags = br.ReadUInt32();
            }

            uint amountRead = 0;
            while (amountRead < Size - (Oblivion ? 20 : 24))
            {
                string s = ReadRecName(br);
                uint recsize = br.ReadUInt32();
                if (s == "GRUP")
                {
                    try
                    {
                        bool skip = filterAll || (recFilter != null && Array.IndexOf(recFilter, contentType) >= 0);
                        var gr = new GroupRecord(recsize, br, Oblivion, recFilter, skip);
                        if (!filterAll)
                        {
                            this.AddRecord(gr);
                        }
                    }
                    catch (Exception e)
                    {
                        MessageBox.Show(e.Message);
                    }
                    finally
                    {
                        amountRead += recsize;
                    }
                }
                else
                {
                    bool skip = filterAll || (recFilter != null && Array.IndexOf(recFilter, s) >= 0);
                    if (skip)
                    {
                        long size = recsize + (Oblivion ? 12 : 16);

                        // if ((br.ReadUInt32() & 0x00040000) > 0) size += 4;
                        br.BaseStream.Position += size; // just read past the data
                        amountRead += (uint)(recsize + (Oblivion ? 20 : 24));
                    }
                    else
                    {
                        try
                        {
                            var r = new Record(s, recsize, br, Oblivion);
                            this.AddRecord(r);
                        }
                        catch (Exception e)
                        {
                            MessageBox.Show(e.Message);
                        }
                        finally
                        {
                            amountRead += (uint)(recsize + (Oblivion ? 20 : 24));
                        }
                    }
                }
            }

            this.UpdateShortDescription();
            if (amountRead != (Size - (Oblivion ? 20 : 24)))
            {
                throw new TESParserException(
                    string.Format("Record block did not match the size specified in the group header! Header Size={0:D} Group Size={1:D}", Size - (Oblivion ? 20 : 24), amountRead));
            }
        }

        private GroupRecord(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

        private GroupRecord(GroupRecord gr, bool recursive)
        {
            Name = "GRUP";
            this.data = (byte[])gr.data.Clone();
            this.groupType = gr.groupType;
            this.dateStamp = gr.dateStamp;
            this.flags = gr.flags;
            if (recursive)
            {
                this.records = new List<Rec>(gr.records.Count);
                for (int i = 0; i < gr.records.Count; i++)
                {
                    this.AddRecord(gr.records[i].Clone());
                }
            }

            Name = gr.Name;
            this.UpdateShortDescription();
        }

        public string ContentsType
        {
            get
            {
                return this.groupType == 0 ? Encoding.Instance.GetString(this.data, 0, 4) : string.Empty;
            }
        }

        public uint GroupType
        {
            get
            {
                return this.groupType;
            }
        }

        public override IList Records
        {
            get
            {
                return this.records;
            }
        }

        public override long Size
        {
            get
            {
                long size = 24;
                foreach (Rec rec in this.Records)
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
                return this.Size;
            }
        }

        public override void AddRecord(BaseRecord br)
        {
            var r = br as Rec;
            if (r == null)
            {
                throw new TESParserException("Record to add was not of the correct type." + Environment.NewLine + "Groups can only hold records or other groups.");
            }

            r.Parent = this;
            this.records.Add(r);
            FireRecordListUpdate(this, this);
        }

        public override void AddRecords(IEnumerable<BaseRecord> br)
        {
            if (br.Count(r => !(r is Record || r is GroupRecord)) > 0)
            {
                throw new TESParserException("Record to add was not of the correct type.\nGroups can only hold records or other groups.");
            }

            foreach (var r in br)
            {
                r.Parent = this;
            }

            this.records.AddRange(br.OfType<Rec>());
            FireRecordListUpdate(this, this);
        }

        public void Clear()
        {
            foreach (var r in this.records)
            {
                r.Parent = null;
            }

            this.records.Clear();
        }

        public override BaseRecord Clone()
        {
            return new GroupRecord(this, recursive: true);
        }

        public override BaseRecord Clone(bool recursive)
        {
            return new GroupRecord(this, recursive);
        }

        public override bool DeleteRecord(BaseRecord br)
        {
            var r = br as Rec;
            if (r == null)
            {
                return false;
            }

            bool ok = this.records.Remove(r);
            if (ok)
            {
                r.Parent = null;
            }

            FireRecordListUpdate(this, this);
            FireRecordDeleted(this, r);
            return ok;
        }

        public override bool DeleteRecords(IEnumerable<BaseRecord> br)
        {
            if (br.Count(r => !(r is Record || r is GroupRecord)) > 0)
            {
                throw new TESParserException("Record to delete was not of the correct type.\nGroups can only hold records or other groups.");
            }

            var ok = false;
            foreach (Rec r in from Rec r in br where this.records.Remove(r) select r)
            {
                ok = true;
                r.Parent = null;
                FireRecordDeleted(this, r);
            }

            FireRecordListUpdate(this, this);
            return ok;
        }

        public override IEnumerable<BaseRecord> Enumerate(Predicate<BaseRecord> match)
        {
            if (!match(this))
            {
                yield break;
            }

            foreach (BaseRecord r in this.Records)
            {
                foreach (var itm in r.Enumerate(match))
                {
                    yield return itm;
                }
            }
        }

        public override void ForEach(Action<BaseRecord> action)
        {
            base.ForEach(action);
            foreach (BaseRecord r in this.Records)
            {
                r.ForEach(action);
            }
        }

        public byte[] GetData()
        {
            return (byte[])this.data.Clone();
        }

        public override string GetDesc()
        {
            string desc = "[Record group]" + Environment.NewLine + "Record type: ";
            switch (this.groupType)
            {
                case 0:
                    desc += "Top " + this.GetSubDesc();
                    break;
                case 1:
                    desc += "World children " + this.GetSubDesc();
                    break;
                case 2:
                    desc += "Interior Cell Block " + this.GetSubDesc();
                    break;
                case 3:
                    desc += "Interior Cell Sub-Block " + this.GetSubDesc();
                    break;
                case 4:
                    desc += "Exterior Cell Block " + this.GetSubDesc();
                    break;
                case 5:
                    desc += "Exterior Cell Sub-Block " + this.GetSubDesc();
                    break;
                case 6:
                    desc += "Cell Children " + this.GetSubDesc();
                    break;
                case 7:
                    desc += "Topic Children " + this.GetSubDesc();
                    break;
                case 8:
                    desc += "Cell Persistent Children " + this.GetSubDesc();
                    break;
                case 9:
                    desc += "Cell Temporary Children " + this.GetSubDesc();
                    break;
                case 10:
                    desc += "Cell Visible Distant Children " + this.GetSubDesc();
                    break;
                default:
                    desc += "Unknown";
                    break;
            }

            return desc + Environment.NewLine + "Records: " + this.records.Count.ToString() + Environment.NewLine + "Size: " + this.Size.ToString() + " bytes (including header)";
        }

        public override int IndexOf(BaseRecord br)
        {
            return this.records.IndexOf(br as Rec);
        }

        public override void InsertRecord(int idx, BaseRecord br)
        {
            var r = br as Rec;
            if (r == null)
            {
                throw new TESParserException("Record to add was not of the correct type." + Environment.NewLine + "Groups can only hold records or other groups.");
            }

            r.Parent = this;
            if (idx < 0 || idx > this.records.Count)
            {
                idx = this.records.Count;
            }

            this.records.Insert(idx, r);
            FireRecordListUpdate(this, this);
        }

        public override void InsertRecords(int index, IEnumerable<BaseRecord> br)
        {
            if (br.Count(r => !(r is Record || r is GroupRecord)) > 0)
            {
                throw new TESParserException("Record to add was not of the correct type.\nGroups can only hold records or other groups.");
            }

            this.records.InsertRange(index, br.OfType<Rec>());
            FireRecordListUpdate(this, this);
        }

        public bool IsEquivalent(GroupRecord other)
        {
            return this.GroupType == other.GroupType && ByteArrayCompare(this.GetReadonlyData(), other.GetReadonlyData());
        }

        public void SetData(byte[] data)
        {
            if (data.Length != 4)
            {
                throw new ArgumentException("data length must be 4");
            }

            for (int i = 0; i < 4; i++)
            {
                this.data[i] = data[i];
            }
        }

        public override void UpdateShortDescription()
        {
            if (this.groupType == 0)
            {
                string data = Encoding.Instance.GetString(this.data);
                string desc = string.Format(" ({0})", data);
                if (this.groupType == 0)
                {
                    RecordStructure rec;
                    if (RecordStructure.Records.TryGetValue(data, out rec))
                    {
                        if (rec.description != data)
                        {
                            desc += " - " + rec.description;
                        }
                    }
                }

                descriptiveName = desc;
            }
            else
            {
                descriptiveName = string.Empty;
            }
        }

        public override bool While(Predicate<BaseRecord> action)
        {
            if (!base.While(action))
            {
                return false;
            }

            return this.Records.Cast<BaseRecord>().All(r => r.While(action));
        }

        void IDeserializationCallback.OnDeserialization(object sender)
        {
            foreach (BaseRecord rec in this.Records)
            {
                rec.Parent = this;
            }
        }

        internal override List<string> GetIDs(bool lower)
        {
            var list = new List<string>();
            foreach (Record r in this.Records)
            {
                list.AddRange(r.GetIDs(lower));
            }

            return list;
        }

        internal byte[] GetReadonlyData()
        {
            return this.data;
        }

        internal override void SaveData(BinaryWriter writer)
        {
            long startpos = writer.BaseStream.Position;
            var svSize = (uint)this.Size;
            var svSize2 = (uint)this.Size2;
            WriteString(writer, "GRUP");
            writer.Write(svSize); // Write uncompressed size for now
            writer.Write(this.data);
            writer.Write(this.groupType);
            writer.Write(this.dateStamp);
            writer.Write(this.flags); // should this check for oblivion?
            foreach (Rec r in this.Records)
            {
                r.SaveData(writer);
            }

            writer.Flush();
            long curpos = writer.BaseStream.Position;
            var wrSize = (uint)(curpos - startpos);
            if (wrSize != svSize2)
            {
                // fix size due to compression
                writer.BaseStream.Position = startpos + 4;
                writer.Write(wrSize); // Write the actuall compressed group size
                writer.BaseStream.Position = curpos;
            }
        }

        private static bool ByteArrayCompare(byte[] b1, byte[] b2)
        {
            // Validate buffers are the same length.
            // This also ensures that the count does not exceed the length of either buffer.  
            return b1.Length == b2.Length && memcmp(b1, b2, b1.Length) == 0;
        }

        [DllImport("msvcrt.dll")]
        private static extern int memcmp(byte[] b1, byte[] b2, long count);

        private string GetSubDesc()
        {
            switch (this.groupType)
            {
                case 0:
                    return "(Contains: " + (char)this.data[0] + (char)this.data[1] + (char)this.data[2] + (char)this.data[3] + ")";
                case 2:
                case 3:
                    return "(Block number: " + (this.data[0] + this.data[1] * 256 + this.data[2] * 256 * 256 + this.data[3] * 256 * 256 * 256).ToString() + ")";
                case 4:
                case 5:
                    return "(Coordinates: [" + (this.data[0] + this.data[1] * 256) + ", " + this.data[2] + this.data[3] * 256 + "])";
                case 1:
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                    return "(Parent FormID: 0x" + this.data[3].ToString("x2") + this.data[2].ToString("x2") + this.data[1].ToString("x2") + this.data[0].ToString("x2") + ")";
            }

            return null;
        }
    }
}
