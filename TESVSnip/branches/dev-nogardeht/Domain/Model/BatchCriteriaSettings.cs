namespace TESVSnip.Domain.Model
{
    using System.Collections.Generic;

    internal class BatchCriteriaSettings
    {
        public IEnumerable<BatchCriteria> Items;

        public string Type;
    }
}