namespace TESVSnip.Main
{
    using TESVSnip.Framework;
    using TESVSnip.Model;

    public interface ISelectionContext : ICloneable<ISelectionContext>
    {
        Rec Record { get; set; }

        SubRecord SubRecord { get; set; }

        void Reset();
    }
}