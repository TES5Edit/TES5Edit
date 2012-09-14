namespace TESVSnip.Domain.Model
{
    using System.Collections.Generic;

    internal class ColumnSettings
    {
        public IEnumerable<ColumnCriteria> Items;

        public string Type;
    }
}