namespace TESVSnip.UI.RecordControls
{
    using System;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;

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
}
