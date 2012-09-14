namespace TESVSnip.UI
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework;

    internal class RecordBuilder
    {
        private readonly Dictionary<string, RecordsRecord> rdict = new Dictionary<string, RecordsRecord>();

        public dFormIDLookupR FormLookup = DefaultLookupR;

        public dLStringLookup StringLookup = DefaultLookupS;

        public Func<bool> CancelAction = DefaultCancel;

        public Action<int> UpdateProgressAction = DefaultUpdate;

        public static Record DefaultLookupR(uint idx)
        {
            return null;
        }

        public static string DefaultLookupS(uint idx)
        {
            return null;
        }

        public static bool DefaultCancel()
        {
            return false;
        }

        public static void DefaultUpdate(int value)
        {
        }

        private bool IsCanceled
        {
            get
            {
                return this.CancelAction();
            }
        }

        private int totalRecordCount;

        private int currentRecordIndex;

        private int progressCount;

        public void UpdateSize(Subrecord sr)
        {
            sr.size = 0;
            foreach (var sre in sr.Elements)
            {
                sr.size += sre.size;
            }
        }

        public static bool IsLikelyFloat(float value)
        {
            value = Math.Abs(value);
            return value != 0.0f && value >= 0.001f && value < 100000.0f;
        }

        private static bool IsLikelyString(byte[] data)
        {
            return IsLikelyString(new ArraySegment<byte>(data));
        }

        private static bool IsLikelyString(ArraySegment<byte> data)
        {
            bool isAscii = true;
            for (int i = 0; i < data.Count - 1 && isAscii; ++i)
            {
                isAscii = !char.IsControl((char)data.Array[data.Offset + i]);
            }

            return isAscii && data.Array[data.Count - 1] == 0;
        }

        private static uint GetUInt32(byte[] data, int offset)
        {
            if (offset < 0 || offset + 4 > data.Length)
            {
                return 0;
            }

            return TypeConverter.h2i(data[offset], data[offset + 1], data[offset + 2], data[offset + 3]);
        }

        public SubrecordElement CreateType(int index, string type)
        {
            return this.CreateType((index > 0) ? "Unknown " + index.ToString() : null, type);
        }

        public SubrecordElement CreateType(string name, string type)
        {
            var elem = new SubrecordElement();
            elem.name = string.IsNullOrEmpty(name) ? "Unknown" : name;
            elem.type = type;
            return elem;
        }

        public SubrecordElement CreateType(string type)
        {
            return this.CreateType(null, type);
        }

        public SubrecordElement CreateBlob()
        {
            return this.CreateType("blob");
        }

        public void Start(Plugin p)
        {
            // p.ForEach(r => { if (r is Record) ++totalRecordCount; });
            // p.While(r => { if (r is Record) { UpdateProgress(); return Process((Record)r); } });
            var recordList = new List<Record>();
            p.ForEach(
                r => {
                    if (r is Record)
                    {
                        recordList.Add((Record)r);
                    }
                });
            this.totalRecordCount = recordList.Count;

            foreach (var kvp in recordList.ToLookup((a) => a.Name))
            {
                if (!this.Process(kvp.Key, kvp.ToArray()))
                {
                    return;
                }
            }
        }

        public bool Process(string name, Record[] records)
        {
            RecordsRecord rr;
            if (!this.rdict.TryGetValue(name, out rr))
            {
                rr = new RecordsRecord();
                rr.name = name;
                rr.desc = name;
                this.rdict.Add(name, rr);
            }

            foreach (var r in records)
            {
                this.UpdateProgress();
                if (!this.CreateSubrecords(rr, r))
                {
                    return false;
                }
            }

            // now that we have subrecords, go back through all records
            foreach (var sr in rr.Items.OfType<Subrecord>())
            {
                // list of all subrecords matching the given name
                var ss = (from r in records from s in r.SubRecords where s.Name == sr.name select s).ToArray();

                this.ProcessSubRecord(sr, ss);
            }

            // Post Process
            IEnumerable<Subrecord> srs = rr.Subrecords;
            var itr = srs.GetEnumerator();
            for (bool atEnd = itr.MoveNext(); !atEnd;)
            {
                var sr = itr.Current;
                if (sr.repeat > 1)
                {
                    if (sr.size < 0)
                    {
                        sr.size = 0;
                        continue;
                    }

                    int count = sr.repeat;
                    for (int j = 1; j < count; ++j)
                    {
                        atEnd = itr.MoveNext();
                        if (atEnd)
                        {
                            sr = itr.Current;
                            if (sr.repeat == count)
                            {
                                sr.repeat = sr.optional = 0;
                            }
                            else
                            {
                                // Should be a group??
                            }
                        }
                        else
                        {
                            sr.repeat = sr.optional = 1;
                        }
                    }
                }
                else
                {
                    atEnd = itr.MoveNext();
                }
            }

            // sub records have been updated
            long minSize = records.Min(a => a.Size);
            long maxSize = records.Max(a => a.Size);
            if (maxSize == minSize)
            {
                // Uniform record size
            }
            else
            {
            }

            return true;
        }

        private void ProcessSubRecord(Subrecord sr, SubRecord[] srs)
        {
            long minSize = srs.Min(a => a.Size);
            long maxSize = srs.Max(a => a.Size);
            if (maxSize == 0)
            {
                // likely a group start
                sr.size = -1;
                return;
            }

            int szCount = 0;
            foreach (var ss in srs)
            {
                if (ss.Size == 0)
                {
                    continue;
                }

                byte[] data = ss.GetReadonlyData();
                if (IsLikelyString(new ArraySegment<byte>(data, 0, (int)ss.Size)))
                {
                    if (++szCount > 10)
                    {
                        SubrecordElement elem = this.CreateType(null, "string");
                        sr.Elements.Add(elem);
                        break;
                    }
                }
                else
                {
                    break;
                }
            }

            if (sr.Elements.Count > 0)
            {
                return; // found string
            }

            if (minSize == maxSize && maxSize < 256)
            {
                sr.size = (int)maxSize;
                int index = 0;

                // Walk through each element guessing the data type
                for (int offset = 0, elemSize = 4; offset < maxSize; offset += elemSize)
                {
                    int numZero = 0;
                    int numFloat = 0;
                    int num2Short = 0;
                    int isFormID = 0;
                    int numTotal = 0;
                    int isLString = 0;
                    string reftype = null;

                    if (maxSize - offset < 4)
                    {
                        if (maxSize >= 2)
                        {
                            var elem = this.CreateType(index++, "short");
                            elem.size = 2;
                            sr.Elements.Add(elem);
                            elemSize = 2;
                            continue;
                        }
                        else
                        {
                            var elem = this.CreateType(index++, "byte");
                            elem.size = 1;
                            sr.Elements.Add(elem);
                            elemSize = 1;
                            continue;
                        }
                    }

                    foreach (var ss in srs)
                    {
                        // .Random(srs.Length < 10 ? 0 : srs.Length / 10)
                        ++numTotal;
                        byte[] data = ss.GetReadonlyData();
                        uint ui4 = TypeConverter.h2i(data[offset], data[offset + 1], data[offset + 2], data[offset + 3]);
                        if (ui4 == 0)
                        {
                            ++numZero;
                            continue;
                        }

                        ushort lhs = TypeConverter.h2s(data[offset], data[offset + 1]);
                        ushort uhs = TypeConverter.h2s(data[offset + 2], data[offset + 3]);
                        float flt = TypeConverter.h2f(data[offset], data[offset + 1], data[offset + 2], data[offset + 3]);
                        if (IsLikelyFloat(flt))
                        {
                            ++numFloat;
                        }

                        if (lhs > 0 && lhs < 255 && uhs > 0 && uhs < 255)
                        {
                            ++num2Short;
                        }

                        if (ui4 > 100)
                        {
                            Record r = this.FormLookup(ui4);
                            if (r != null)
                            {
                                if (string.IsNullOrEmpty(reftype))
                                {
                                    reftype = r.Name;
                                    isFormID++;
                                }
                                else if (reftype == r.Name)
                                {
                                    isFormID++;
                                }
                            }

                            if (!string.IsNullOrEmpty(this.StringLookup(ui4)))
                            {
                                ++isLString;
                            }
                        }
                    }

                    if (numTotal > 0)
                    {
                        float floatPct = (numFloat + numZero) / (float)numTotal;
                        float shortPct = (num2Short + numZero) / (float)numTotal;
                        float formPct = (isFormID + numZero) / (float)numTotal;
                        float lstrPct = (isLString + numZero) / (float)numTotal;

                        if (numFloat > 0 && floatPct > 0.5f)
                        {
                            var elem = this.CreateType(index++, "float");
                            elem.size = 4;
                            sr.Elements.Add(elem);
                        }
                        else if (num2Short > 0 && shortPct > 0.5f)
                        {
                            var elem = this.CreateType(index++, "short");
                            elem.size = 2;
                            sr.Elements.Add(elem);
                            sr.Elements.Add(elem);
                            this.UpdateSize(sr);
                        }
                        else if (isFormID > 0 && formPct > 0.5f)
                        {
                            var elem = this.CreateType(index++, "formid");
                            elem.reftype = reftype;
                            elem.size = 4;
                            sr.Elements.Add(elem);
                        }
                        else if (isLString > 0 && lstrPct > 0.5f)
                        {
                            var elem = this.CreateType(index++, "lstring");
                            elem.size = 4;
                            sr.Elements.Add(elem);
                        }
                        else
                        {
                            var elem = this.CreateType(index++, "int");
                            elem.size = 4;
                            sr.Elements.Add(elem);
                        }
                    }
                }
            }
            else
            {
                // guess dynamically sized object... default to blob
                if (sr.Elements.Count == 0)
                {
                    long modSum = srs.Sum(a => a.Size % 4); // useful if we suspect this is an array of integers
                    if (modSum == 0)
                    {
                        int count = 0;
                        string reftype = null;
                        foreach (var ss in srs)
                        {
                            byte[] data = ss.GetReadonlyData();
                            int offset = 0;
                            uint ui4 = GetUInt32(data, offset);
                            if (ui4 < 100)
                            {
                                continue;
                            }

                            Record r = this.FormLookup(ui4);
                            if (r != null)
                            {
                                if (string.IsNullOrEmpty(reftype))
                                {
                                    reftype = r.Name;
                                }
                                else if (reftype == r.Name)
                                {
                                    if (++count > 10)
                                    {
                                        break;
                                    }
                                }
                            }
                            else
                            {
                                break;
                            }
                        }

                        if (count > 0)
                        {
                            var elem = this.CreateType("ID", "formid");
                            elem.reftype = reftype;
                            elem.size = 4;
                            elem.repeat = 1;
                            elem.optional = 1;
                            sr.Elements.Add(elem);
                        }
                    }
                }

                // check if it is a string else make it a blob
                sr.size = 0;

                if (sr.Elements.Count == 0)
                {
                    sr.Elements.Add(this.CreateBlob());
                }
            }
        }

        private bool CreateSubrecords(RecordsRecord rr, Record r)
        {
            // int srIdx = 0;
            var groups = from psr in r.SubRecords group psr by psr.Name into g select new { Name = g.Key, Records = g.ToArray() };

            int lastIndex = 0;
            var dict = new Dictionary<string, Subrecord>();
            foreach (var kvp in groups)
            {
                if (this.IsCanceled)
                {
                    return false;
                }

                // if (kvp.Name.Count(a => !Char.IsLetterOrDigit(a)) > 0) continue;
                int n = kvp.Records.Length;

                Subrecord sr = rr.Subrecords.FirstOrDefault(x => x.name == kvp.Name);
                if (sr == null)
                {
                    sr = new Subrecord();
                    sr.name = sr.desc = kvp.Name;
                    sr.optional = 1;
                    if (lastIndex + 1 <= rr.Items.Count)
                    {
                        rr.Items.Insert(++lastIndex, sr);
                    }
                    else
                    {
                        rr.Items.Add(sr);
                    }
                }
                else
                {
                    lastIndex = rr.Items.IndexOf(sr, (lastIndex < 0) ? lastIndex : 0);
                    if (lastIndex < 0)
                    {
                        // out of order
                        lastIndex = rr.Items.IndexOf(sr);
                    }
                }

                // Group Detection
                if (n > 0)
                {
                    int idx1 = r.SubRecords.IndexOf(kvp.Records[0]);
                    int idx2 = idx1;
                    for (int i = 1; i < n; ++i, idx1 = idx2)
                    {
                        idx2 = r.SubRecords.IndexOf(kvp.Records[i]);
                        int diff = r.SubRecords.Skip(idx1).Take(idx2 - idx1).Select((a) => a.Name).Distinct().Count();
                        if (diff > sr.repeat)
                        {
                            sr.optional = sr.repeat = diff;
                        }
                    }

                    if (sr.repeat == 0 && n > 1)
                    {
                        sr.optional = sr.repeat = 1;
                    }
                }
            }

            return true;
        }

        private void UpdateProgress()
        {
            var counter = (int)(++this.currentRecordIndex / (float)this.totalRecordCount * 100.0f);
            if (counter != this.progressCount)
            {
                this.progressCount = counter;
                this.UpdateProgressAction(this.progressCount);
            }
        }

#if false
        public TESVSnip.Data.RecordsRecord ProcessBase(Record r)
        {
            TESVSnip.Data.RecordsRecord rr;
            if (!rdict.TryGetValue(r.Name, out rr))
            {
                rr = new TESVSnip.Data.RecordsRecord();
                rr.name = r.Name;
                rr.desc = r.Name;
                rdict.Add(r.Name, rr);
            }
            return rr;
        }

        public bool Process(Record p)
        {
            TESVSnip.Data.RecordsRecord rr = ProcessBase(p);

            // int srIdx = 0;
            var groups = from psr in p.SubRecords
                         group psr by psr.Name into g
                         select new { Name = g.Key, Records = g.ToArray() };

            int lastIndex = 0;
            Dictionary<string, TESVSnip.Data.Subrecord> dict = new Dictionary<string, TESVSnip.Data.Subrecord>();
            foreach (var kvp in groups)
            {
                if (IsCanceled) return false;

                TESVSnip.Data.Subrecord sr = rr.Subrecords.FirstOrDefault(x => x.name == kvp.Name);
                if (sr == null)
                {
                    sr = new TESVSnip.Data.Subrecord();
                    sr.name = sr.desc = kvp.Name;
                    sr.optional = 1;
                    if (lastIndex + 1 <= rr.Items.Count)
                    {
                        rr.Items.Insert(++lastIndex, sr);
                    }
                    else
                    {
                        rr.Items.Add(sr);
                    }
                }
                else
                {
                    lastIndex = rr.Items.IndexOf(sr, lastIndex);
                    if (lastIndex < 0)  // out of order
                        lastIndex = rr.Items.IndexOf(sr);
                }
                int n = kvp.Records.Length;
                if (n > 0)
                {
                    if (sr.repeat == 0 && n > 1)
                        sr.optional = sr.repeat = 1;
                    int idx1 = p.SubRecords.IndexOf(kvp.Records[0]);
                    int idx2 = idx1;
                    for (int i = 1; i < n; ++i, idx1 = idx2)
                    {
                        idx2 = p.SubRecords.IndexOf(kvp.Records[i]);
                        int diff = (idx2 - idx1);
                        if (diff > sr.repeat)
                        {
                            if (diff < 10)
                            {
                                sr.optional = sr.repeat = diff;
                            }
                            else
                            {
                                sr.optional = sr.repeat;
                            }
                        }
                    }
                }
                foreach (var subrec in kvp.Records)
                {
                    if (IsCanceled) break;
                    Process(sr, subrec);
                }
            }
            return true;
        }


        public void Process(TESVSnip.Data.Subrecord sr, SubRecord subrec)
        {
            TESVSnip.Data.SubrecordElement expectedElement = (sr.Elements.Count >= 1) ? sr.Elements[0] : null;
            if (expectedElement != null && expectedElement.type == "blob")
                return;

            byte[] data = subrec.GetReadonlyData();
            if (data.Length == 0)
            {
                if (sr.Elements.Count == 0)
                    sr.Elements.Add(CreateBlob());
                return;
            }
            if (data.Length == 2)            {

// common scenarios
                if (expectedElement != null && expectedElement.size == 2)
                    return;

                TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                elem.name = "Unknown";
                elem.type = "short";
                elem.size = 2;
                sr.Elements.Add(elem);
                UpdateSize(sr);
                return;
            }

            if (data.Length > 0)
            {
                bool isAscii = true;
                for (int i = 0; i < data.Length - 1 && isAscii; ++i)
                    isAscii = !Char.IsControl((char)data[i]);
                isAscii = (isAscii && data[data.Length - 1] == 0);
                if (isAscii)
                {
                    // test if its a string
                    if (expectedElement == null)
                    {
                        TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                        elem.name = "Unknown";
                        elem.type = "string";
                        sr.Elements.Add(elem);
                    }
                    else if (expectedElement.type != "string")
                    {
                        sr.Elements.Clear();
                        sr.Elements.Add(CreateBlob());
                    }
                    return;
                }
            }
            for (int offset = 0, elemSize = 4; offset < data.Length; offset += elemSize)
            {
                if (IsCanceled) return;

                int left = data.Length - offset;
                if (left >= 4)                {

// common scenarios
                    if (expectedElement != null && expectedElement.size == 4)
                        continue;

                    ushort lhs = TypeConverter.h2s(data[offset], data[offset + 1]);
                    ushort uhs = TypeConverter.h2s(data[offset + 2], data[offset + 3]);
                    uint ui4 = TypeConverter.h2i(data[offset], data[offset + 1], data[offset + 2], data[offset + 3]);
                    if (ui4 == 0)
                    {
                        if (expectedElement == null)
                        {
                            TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                            elem.name = "Unknown";
                            elem.type = "int";
                            elem.size = 4;
                            sr.Elements.Add(elem);
                            UpdateSize(sr);
                            continue;
                        }
                    }
                    else
                    {
                        float flt = TypeConverter.h2f(data[offset], data[offset + 1], data[offset + 2], data[offset + 3]);
                        if (IsLikelyFloat(flt))                        {

// replace element which is int with float
                            if (expectedElement == null)
                            {
                                TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                                elem.name = "Unknown";
                                elem.type = "float";
                                elem.size = 4;
                                sr.Elements.Add(elem);
                            }
                            else
                            {
                                if (expectedElement.type == "int")
                                    expectedElement.type = "float";
                            }
                            continue;
                        }
                        else
                        {
                            Record r = this.FormLookup(ui4);
                            if (r != null)
                            {
                                string reftype = r.DescriptiveName.Substring(0, 4); // ???
                                if (expectedElement == null)
                                {
                                    TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                                    elem.name = "ID";
                                    elem.type = "formid";
                                    elem.reftype = reftype;
                                    elem.size = 4;
                                    sr.Elements.Add(elem);
                                }
                                else
                                {
                                    if (expectedElement.type == "formid")
                                    {
                                        if (expectedElement.reftype != reftype)
                                            expectedElement.reftype = string.Empty;
                                    }
                                }
                                continue;
                            }
                            else
                            {
                                string s = this.StringLookup(ui4);
                                if (!string.IsNullOrEmpty(s))
                                {
                                    if (expectedElement == null)
                                    {
                                        TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                                        elem.name = "Unknown";
                                        elem.type = "string";
                                        sr.Elements.Add(elem);
                                    }
                                    continue;
                                }
                            }
                            if (expectedElement == null)
                            {
                                if (lhs > 0 && lhs < 255 && uhs > 0 && uhs < 255)
                                {
                                    TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                                    elem.name = "Unknown";
                                    elem.type = "short";
                                    elem.size = 2;
                                    sr.Elements.Add(elem);
                                    sr.Elements.Add(elem);
                                }
                                else
                                {
                                    TESVSnip.Data.SubrecordElement elem = new TESVSnip.Data.SubrecordElement();
                                    elem.name = "Unknown";
                                    elem.type = "int";
                                    elem.size = 4;
                                    sr.Elements.Add(elem);
                                    UpdateSize(sr);
                                }
                            }
                        }
                    }
                }
            }


            if (sr.Elements.Count == 0)
            {
                sr.Elements.Add(CreateBlob());
            }
            UpdateSize(sr);
        }
#endif

        public Records Complete()
        {
            var records = new Records();
            foreach (var rr in this.rdict.Values)
            {
                var itr = rr.Subrecords.GetEnumerator();
                for (bool atEnd = itr.MoveNext(); !atEnd;)
                {
                    var sr = itr.Current;
                    if (sr.repeat > 1)
                    {
                        int count = sr.repeat;
                        for (int j = 1; j < count; ++j)
                        {
                            atEnd = itr.MoveNext();
                            if (!atEnd)
                            {
                                sr = itr.Current;
                                if (sr.repeat == count)
                                {
                                    sr.repeat = sr.optional = 0;
                                }
                                else
                                {
                                    // Should be a group??
                                }
                            }
                            else
                            {
                                sr.repeat = sr.optional = 1;
                            }
                        }
                    }
                    else
                    {
                        atEnd = itr.MoveNext();
                    }
                }
            }

            records.Items.AddRange(this.rdict.Values);
            return records;
        }

        /// <summary>
        /// Update records using another record list.
        /// </summary>
        /// <param name="baseRecords">
        /// Records to use as base records. 
        /// </param>
        /// <param name="updateRecords">
        /// Inplace records to update. 
        /// </param>
        internal void MergeRecords(IEnumerable<RecordsRecord> baseRecords, IEnumerable<RecordsRecord> updateRecords)
        {
            foreach (var r in updateRecords)
            {
                this.MergeRecord(baseRecords.FirstOrDefault(a => a.name == r.name), r);
            }
        }

        /// <summary>
        /// Update records using another record list.
        /// </summary>
        /// <param name="baseRecord">
        /// The base Record.
        /// </param>
        /// <param name="updateRecord">
        /// The update Record.
        /// </param>
        internal void MergeRecord(RecordsRecord baseRecord, RecordsRecord updateRecord)
        {
            if (baseRecord == null)
            {
                return;
            }

            if (!string.IsNullOrEmpty(baseRecord.desc) || updateRecord.desc != baseRecord.desc)
            {
                updateRecord.desc = baseRecord.desc;
            }

            foreach (var sr in updateRecord.AllSubrecords)
            {
                this.MergeRecord(baseRecord.AllSubrecords.FirstOrDefault(a => a.name == sr.name), sr);
            }
        }

        internal void MergeRecord(Subrecord baseRecord, Subrecord updateRecord)
        {
            if (baseRecord == null)
            {
                return;
            }

            if (updateRecord.desc == updateRecord.name && !string.IsNullOrEmpty(baseRecord.desc))
            {
                updateRecord.desc = baseRecord.desc;
            }

            var baseItr = baseRecord.Elements.GetEnumerator();
            var updateItr = updateRecord.Elements.GetEnumerator();
            bool baseOk = baseItr.MoveNext();
            bool updateOk = updateItr.MoveNext();
            while (baseOk && updateOk)
            {
                var bse = baseItr.Current;
                var use = updateItr.Current;
                if (bse == null && use == null)
                {
                    break;
                }

                if (use.name.StartsWith("Unknown", StringComparison.InvariantCultureIgnoreCase))
                {
                    use.name = bse.name;

                    if (bse.type == use.type)
                    {
                        use.notininfo = bse.notininfo;
                        use.options = bse.options;
                        use.flags = bse.flags;
                        use.hexview = bse.hexview;
                        use.multiline = bse.multiline;
                    }

                    if (bse.type == "string" && use.type == "int")
                    {
                        // likely an lstring
                        use.type = "lstring";
                        use.notininfo = bse.notininfo;
                        use.options = bse.options;
                        use.flags = bse.flags;
                        use.hexview = bse.hexview;
                        use.multiline = bse.multiline;
                    }
                }

                baseOk = baseItr.MoveNext();
                updateOk = updateItr.MoveNext();
            }
        }
    }
}
