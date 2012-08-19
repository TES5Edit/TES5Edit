namespace TESVSnip.Main
{
    using TESVSnip.Data;

    internal class SubrecordGroup : SubrecordBase
    {
        public readonly SubrecordBase[] elements;

        public SubrecordGroup(Group node, SubrecordBase[] items)
            : base(node)
        {
            this.elements = items;
        }

        public override bool IsGroup
        {
            get
            {
                return true;
            }
        }
    }
}