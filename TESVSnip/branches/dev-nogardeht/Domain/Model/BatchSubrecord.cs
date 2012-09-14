namespace TESVSnip.Domain.Model
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    using TESVSnip.Domain.Data.RecordStructure;

    internal class BatchSubrecord : BatchCriteria
    {
        public ICollection<BatchElement> Children { get; set; }

        public SubrecordStructure Record { get; set; }

        public BatchCondRecordType Type { get; set; }

        public override bool Evaluate(Record r)
        {
            var sr = r.SubRecords.FirstOrDefault(x => x.Name == this.Record.name);
            return this.Evaluate(r, sr);
        }

        public override bool Evaluate(Record r, SubRecord sr)
        {
            if (this.Type == BatchCondRecordType.Create)
            {
                if (sr == null)
                {
                    // guess the best insert location
                    int idx = -1;
                    RecordStructure rs;
                    if (RecordStructure.Records.TryGetValue(r.Name, out rs))
                    {
                        for (int i = Array.FindIndex(rs.subrecords, structure => structure.name == this.Record.name) - 1; i >= 0; --i)
                        {
                            var srsname = rs.subrecords[i].name;
                            idx = r.SubRecords.IndexOf(r.SubRecords.FirstOrDefault(x => x.Name == srsname));
                        }
                    }

                    sr = new SubRecord(this.Record);
                    if (idx < 0)
                    {
                        r.SubRecords.Add(sr);
                    }
                    else
                    {
                        r.SubRecords.Insert(idx + 1, sr);
                    }
                }
            }
            else if (this.Type == BatchCondRecordType.Delete)
            {
                while (sr != null)
                {
                    r.SubRecords.Remove(sr);
                    sr = r.SubRecords.FirstOrDefault(x => x.Name == this.Record.name);
                }
            }

            return true;
        }
    }
}