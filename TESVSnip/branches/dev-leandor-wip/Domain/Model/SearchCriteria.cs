namespace TESVSnip.Domain.Model
{
    internal abstract class SearchCriteria
    {
        public bool Checked { get; set; }

        public string Name { get; set; }

        public abstract bool Match(Record r);

        public abstract bool Match(Record r, SubRecord sr);

        public abstract bool Match(Record r, SubRecord sr, Element se);
    }
}