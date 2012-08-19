namespace TESVSnip.UI.RecordControls
{
    internal interface IOuterElementControl : IElementControl
    {
        IElementControl InnerControl { get; set; }
    }
}