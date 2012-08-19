namespace TESVSnip.Model
{
    using System.Collections.Generic;

    internal class ColumnSubrecord : ColumnCriteria
    {
        public ICollection<ColumnElement> Children { get; set; }

        public SubrecordStructure Record { get; set; }
    }
}