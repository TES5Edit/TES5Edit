namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Collections.Generic;
    using System.Windows.Forms;

    using TESVSnip.Main;

    internal interface IElementControl
    {
        event EventHandler DataChanged;

        bool Changed { get; set; }

        ArraySegment<byte> Data { get; set; }

        ElementStructure Element { get; set; }

        dFormIDLookupR formIDLookup { get; set; }

        dFormIDScanRec formIDScan { get; set; }

        dLStringLookup strIDLookup { get; set; }

        void CommitChanges();
    }

    internal interface IOuterElementControl : IElementControl
    {
        IElementControl InnerControl { get; set; }
    }

    internal interface ITextElementControl : IElementControl
    {
        Label Label { get; }

        Label LabelType { get; }

        TextBoxBase TextBox { get; }
    }

    internal interface IGroupedElementControl : IElementControl
    {
        IList<ArraySegment<byte>> Elements { get; }
    }
}
