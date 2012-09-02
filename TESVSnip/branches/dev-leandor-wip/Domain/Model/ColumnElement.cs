namespace TESVSnip.Domain.Model
{
    using TESVSnip.Domain.Data.RecordStructure;

    internal class ColumnElement : ColumnCriteria
    {
        public ColumnSubrecord Parent { get; set; }

        public ElementStructure Record { get; set; }
    }
}
