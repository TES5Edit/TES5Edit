namespace TESVSnip.Model
{
    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Main;

    internal class ColumnElement : ColumnCriteria
    {
        public ColumnSubrecord Parent { get; set; }

        public ElementStructure Record { get; set; }
    }
}
