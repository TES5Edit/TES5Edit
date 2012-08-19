namespace TESVSnip.UI.Forms
{
    using System.Collections.Generic;

    using TESVSnip.Model;

    internal delegate IEnumerable<KeyValuePair<uint, Record>> dFormIDScanRec(string type);
}