namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Collections.Generic;

    internal interface IGroupedElementControl : IElementControl
    {
        IList<ArraySegment<byte>> Elements { get; }
    }
}