namespace TESVSnip.Model
{
    using System.Collections.Generic;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Main;

    internal class ColumnSubrecord : ColumnCriteria
    {
        public ICollection<ColumnElement> Children { get; set; }

        public SubrecordStructure Record { get; set; }
    }
}