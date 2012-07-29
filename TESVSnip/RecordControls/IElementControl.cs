using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace TESVSnip.RecordControls
{
    internal interface IElementControl
    {
        ElementStructure Element { get; set; }
        ArraySegment<byte> Data { get; set; }
        dFormIDLookupR formIDLookup { get; set; }
        dFormIDScanRec formIDScan { get; set; }
        dLStringLookup strIDLookup { get; set; }
        bool Changed { get; set; }

        void CommitChanges();
        event EventHandler DataChanged;
    }

    internal interface IOuterElementControl : IElementControl
    {
        IElementControl InnerControl { get; set; }
    }

    internal interface ITextElementControl : IElementControl
    {
        Label LabelType { get; }
        Label Label { get; }
        TextBoxBase TextBox { get; }
    }

    internal interface IGroupedElementControl : IElementControl
    {
        IList<ArraySegment<byte>> Elements { get; }
    }
}