using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using TESVSnip.Data;

namespace TESVSnip
{
    [Persistable(Flags = PersistType.DeclaredOnly), Serializable]
    public sealed class GroupRecord : Rec, IDeserializationCallback, IGroupRecord
    {
        [Persistable] private readonly List<Rec> records = new List<Rec>(1);

        public override IList Records
        {
            get { return records; }
        }

        [Persistable] private readonly byte[] data;
        [Persistable] public uint groupType;
        [Persistable] public uint dateStamp;
        [Persistable] public uint flags;

        public string ContentsType
        {
            get { return groupType == 0 ? Encoding.CP1252.GetString(data, 0, 4) : ""; }
        }

        public override long Size
        {
            get
            {
                long size = 24;
                foreach (Rec rec in Records) size += rec.Size2;
                return size;
            }
        }

        public override long Size2
        {
            get { return Size; }
        }

        public override void AddRecord(BaseRecord br)
        {
            var r = br as Rec;
            if (r == null)
                throw new TESParserException("Record to add was not of the correct type." +
                                             Environment.NewLine + "Groups can only hold records or other groups.");
            r.Parent = this;
            records.Add(r);
            FireRecordListUpdate(this, this);
        }

        public override void InsertRecord(int idx, BaseRecord br)
        {
            var r = br as Rec;
            if (r == null)
                throw new TESParserException("Record to add was not of the correct type." +
                                             Environment.NewLine + "Groups can only hold records or other groups.");
            r.Parent = this;
            if (idx < 0 || idx > records.Count)
                idx = records.Count;

            records.Insert(idx, r);
            FireRecordListUpdate(this, this);
        }

        public override bool DeleteRecord(BaseRecord br)
        {
            var r = br as Rec;
            if (r == null) return false;
            bool ok = records.Remove(r);
            if (ok) r.Parent = null;
            FireRecordListUpdate(this, this);
            FireRecordDeleted(this, r);
            return ok;
        }

        public override int IndexOf(BaseRecord br)
        {
            return records.IndexOf(br as Rec);
        }


        public override void AddRecords(IEnumerable<BaseRecord> br)
        {
            if (br.Count(r => !(r is Record || r is GroupRecord)) > 0)
            {
                throw new TESParserException(
                    "Record to add was not of the correct type.\nGroups can only hold records or other groups.");
            }
            foreach (var r in br) r.Parent = this;
            records.AddRange(br.OfType<Rec>());
            FireRecordListUpdate(this, this);
        }

        public override bool DeleteRecords(IEnumerable<BaseRecord> br)
        {
            if (br.Count(r => !(r is Record || r is GroupRecord)) > 0)
                throw new TESParserException(
                    "Record to delete was not of the correct type.\nGroups can only hold records or other groups.");
            var ok = false;
            foreach (Rec r in from Rec r in br where records.Remove(r) select r)
            {
                ok = true;
                r.Parent = null;
                FireRecordDeleted(this, r);
            }
            FireRecordListUpdate(this, this);
            return ok;
        }

        public override void InsertRecords(int index, IEnumerable<BaseRecord> br)
        {
            if (br.Count(r => !(r is Record || r is GroupRecord)) > 0)
                throw new TESParserException(
                    "Record to add was not of the correct type.\nGroups can only hold records or other groups.");
            records.InsertRange(index, br.OfType<Rec>());
            FireRecordListUpdate(this, this);
        }


        public void Clear()
        {
            foreach (var r in records)
                r.Parent = null;
            records.Clear();
        }

        public override IEnumerable<BaseRecord> Enumerate(Predicate<BaseRecord> match)
        {
            if (!match(this)) yield break;
            foreach (BaseRecord r in Records)
                foreach (var itm in r.Enumerate(match))
                    yield return itm;
        }

        public override bool While(Predicate<BaseRecord> action)
        {
            if (!base.While(action))
                return false;
            return Records.Cast<BaseRecord>().All(r => r.While(action));
        }

        public override void ForEach(Action<BaseRecord> action)
        {
            base.ForEach(action);
            foreach (BaseRecord r in Records) r.ForEach(action);
        }

        private GroupRecord(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }


        internal GroupRecord(uint Size, BinaryReader br, bool Oblivion, string[] recFilter, bool filterAll)
        {
            Name = "GRUP";
            data = br.ReadBytes(4);
            groupType = br.ReadUInt32();
            dateStamp = br.ReadUInt32();
            string contentType = groupType == 0 ? Encoding.CP1252.GetString(data) : "";
            if (!Oblivion) flags = br.ReadUInt32();
            uint amountRead = 0;
            while (amountRead < Size - (Oblivion ? 20 : 24))
            {
                string s = ReadRecName(br);
                uint recsize = br.ReadUInt32();
                if (s == "GRUP")
                {
                    bool skip = filterAll || (recFilter != null && Array.IndexOf(recFilter, contentType) >= 0);
                    var gr = new GroupRecord(recsize, br, Oblivion, recFilter, skip);
                    amountRead += recsize;

                    if (!filterAll) AddRecord(gr);
                }
                else
                {
                    bool skip = filterAll || (recFilter != null && Array.IndexOf(recFilter, s) >= 0);
                    if (skip)
                    {
                        long size = (recsize + (Oblivion ? 12 : 16));
                        //if ((br.ReadUInt32() & 0x00040000) > 0) size += 4;
                        br.BaseStream.Position += size; // just read past the data
                        amountRead += (uint) (recsize + (Oblivion ? 20 : 24));
                    }
                    else
                    {
                        var r = new Record(s, recsize, br, Oblivion);
                        amountRead += (uint) (recsize + (Oblivion ? 20 : 24));
                        AddRecord(r);
                    }
                }
            }
            if (amountRead > (Size - (Oblivion ? 20 : 24)))
            {
                throw new TESParserException("Record block did not match the size specified in the group header");
            }
            UpdateShortDescription();
        }

        public GroupRecord(string data)
        {
            Name = "GRUP";
            this.data = new byte[4];
            for (int i = 0; i < 4; i++) this.data[i] = (byte) data[i];
            UpdateShortDescription();
        }

        private GroupRecord(GroupRecord gr, bool recursive)
        {
            Name = "GRUP";
            data = (byte[]) gr.data.Clone();
            groupType = gr.groupType;
            dateStamp = gr.dateStamp;
            flags = gr.flags;
            if (recursive)
            {
                records = new List<Rec>(gr.records.Count);
                for (int i = 0; i < gr.records.Count; i++) AddRecord(gr.records[i].Clone());                
            }
            Name = gr.Name;
            UpdateShortDescription();
        }

        private string GetSubDesc()
        {
            switch (groupType)
            {
                case 0:
                    return "(Contains: " + (char) data[0] + (char) data[1] + (char) data[2] + (char) data[3] + ")";
                case 2:
                case 3:
                    return "(Block number: " +
                           (data[0] + data[1]*256 + data[2]*256*256 + data[3]*256*256*256).ToString() + ")";
                case 4:
                case 5:
                    return "(Coordinates: [" + (data[0] + data[1]*256) + ", " + data[2] + data[3]*256 + "])";
                case 1:
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                    return "(Parent FormID: 0x" + data[3].ToString("x2") + data[2].ToString("x2") +
                           data[1].ToString("x2") + data[0].ToString("x2") + ")";
            }
            return null;
        }

        public override string GetDesc()
        {
            string desc = "[Record group]" + Environment.NewLine + "Record type: ";
            switch (groupType)
            {
                case 0:
                    desc += "Top " + GetSubDesc();
                    break;
                case 1:
                    desc += "World children " + GetSubDesc();
                    break;
                case 2:
                    desc += "Interior Cell Block " + GetSubDesc();
                    break;
                case 3:
                    desc += "Interior Cell Sub-Block " + GetSubDesc();
                    break;
                case 4:
                    desc += "Exterior Cell Block " + GetSubDesc();
                    break;
                case 5:
                    desc += "Exterior Cell Sub-Block " + GetSubDesc();
                    break;
                case 6:
                    desc += "Cell Children " + GetSubDesc();
                    break;
                case 7:
                    desc += "Topic Children " + GetSubDesc();
                    break;
                case 8:
                    desc += "Cell Persistent Children " + GetSubDesc();
                    break;
                case 9:
                    desc += "Cell Temporary Children " + GetSubDesc();
                    break;
                case 10:
                    desc += "Cell Visible Distant Children " + GetSubDesc();
                    break;
                default:
                    desc += "Unknown";
                    break;
            }
            return desc + Environment.NewLine +
                   "Records: " + records.Count.ToString() + Environment.NewLine +
                   "Size: " + Size.ToString() + " bytes (including header)";
        }

        internal override void SaveData(BinaryWriter bw)
        {
            long startpos = bw.BaseStream.Position;
            var svSize = (uint) Size;
            var svSize2 = (uint) Size2;
            WriteString(bw, "GRUP");
            bw.Write(svSize);
            bw.Write(data);
            bw.Write(groupType);
            bw.Write(dateStamp);
            bw.Write(flags); // should this check for oblivion?
            foreach (Rec r in Records) r.SaveData(bw);
            bw.Flush();
            long curpos = bw.BaseStream.Position;
            var wrSize = (uint) (curpos - startpos);
            if (wrSize != svSize2) // fix size probably due to compression
            {
                bw.BaseStream.Position = startpos + 4;
                bw.Write(wrSize);
                bw.BaseStream.Position = curpos;
            }
        }

        internal override List<string> GetIDs(bool lower)
        {
            var list = new List<string>();
            foreach (Record r in Records) list.AddRange(r.GetIDs(lower));
            return list;
        }

        public override BaseRecord Clone()
        {
            return new GroupRecord(this, recursive: true);
        }

        public byte[] GetData()
        {
            return (byte[]) data.Clone();
        }

        internal byte[] GetReadonlyData()
        {
            return data;
        }

        public void SetData(byte[] data)
        {
            if (data.Length != 4) throw new ArgumentException("data length must be 4");
            for (int i = 0; i < 4; i++) this.data[i] = data[i];
        }

        public override void UpdateShortDescription()
        {
            if (groupType == 0)
            {
                string data = Encoding.CP1252.GetString(this.data);
                string desc = string.Format(" ({0})", data);
                if (groupType == 0)
                {
                    RecordStructure rec;
                    if (RecordStructure.Records.TryGetValue(data, out rec))
                    {
                        if (rec.description != data)
                            desc += " - " + rec.description;
                    }
                }
                descriptiveName = desc;
            }
            else
            {
                descriptiveName = "";
            }
        }

        public uint GroupType
        {
            get { return this.groupType; }
        }

        #region IDeserializationCallback Members

        void IDeserializationCallback.OnDeserialization(object sender)
        {
            foreach (BaseRecord rec in Records)
                rec.Parent = this;
        }

        #endregion

        public override BaseRecord Clone(bool recursive)
        {
            return new GroupRecord(this, recursive);
        }

        public bool IsEquivalent(GroupRecord other)
        {
            return this.GroupType == other.GroupType && ByteArrayCompare(this.GetReadonlyData(), other.GetReadonlyData());
        }

        [DllImport("msvcrt.dll")]
        private static extern int memcmp(byte[] b1, byte[] b2, long count);
        private static bool ByteArrayCompare(byte[] b1, byte[] b2)
        {
            // Validate buffers are the same length.
            // This also ensures that the count does not exceed the length of either buffer.  
            return b1.Length == b2.Length && memcmp(b1, b2, b1.Length) == 0;
        }

    }
}