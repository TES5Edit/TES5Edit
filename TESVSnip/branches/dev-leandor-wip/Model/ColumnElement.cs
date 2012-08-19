namespace TESVSnip.Model
{
    internal class ColumnElement : ColumnCriteria
    {
        public ColumnSubrecord Parent { get; set; }

        public ElementStructure Record { get; set; }
    }
}
