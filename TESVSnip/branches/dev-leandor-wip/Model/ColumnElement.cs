namespace TESVSnip.Model
{
    using System.Collections.Generic;

    internal class ColumnSettings
    {
        public IEnumerable<ColumnCriteria> Items;

        public string Type;
    }

    internal abstract class ColumnCriteria
    {
        public bool Checked { get; set; }

        public string Name { get; set; }
    }

    internal class ColumnSubrecord : ColumnCriteria
    {
        public ICollection<ColumnElement> Children { get; set; }

        public SubrecordStructure Record { get; set; }
    }

    internal class ColumnElement : ColumnCriteria
    {
        public ColumnSubrecord Parent { get; set; }

        public ElementStructure Record { get; set; }
    }
}
