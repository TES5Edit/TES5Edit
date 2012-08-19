namespace TESVSnip.UI.RecordControls
{
    using System.Windows.Forms;

    internal interface ITextElementControl : IElementControl
    {
        Label Label { get; }

        Label LabelType { get; }

        TextBoxBase TextBox { get; }
    }
}