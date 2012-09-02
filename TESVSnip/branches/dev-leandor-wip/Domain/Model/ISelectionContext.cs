namespace TESVSnip.Domain.Model
{
    using TESVSnip.Framework;

    public interface ISelectionContext : ICloneable<ISelectionContext>
    {
        Rec Record { get; set; }

        SubRecord SubRecord { get; set; }

        void Reset();
    }
}