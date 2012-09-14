namespace TESVSnip.Domain.Model
{
    using System.Collections.Generic;
    using System.Linq;

    using TESVSnip.Domain.Data.RecordStructure;

    internal class SearchSubrecord : SearchCriteria
    {
        public ICollection<SearchElement> Children { get; set; }

        public SubrecordStructure Record { get; set; }

        public SearchCondRecordType Type { get; set; }

        public override bool Match(Record r)
        {
            var sr = r.SubRecords.FirstOrDefault(x => x.Name == this.Record.name);
            return this.Match(r, sr);
        }

        public override bool Match(Record r, SubRecord sr)
        {
            return this.Type == SearchCondRecordType.Exists ^ sr == null;
        }

        public override bool Match(Record r, SubRecord sr, Element se)
        {
            return false;
        }
    }
}