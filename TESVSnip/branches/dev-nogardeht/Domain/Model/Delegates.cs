namespace TESVSnip.Domain.Model
{
    using System.Collections.Generic;

    internal delegate string dFormIDLookupI(uint id);

    internal delegate string dLStringLookup(uint id);

    internal delegate Record dFormIDLookupR(uint id);

    internal delegate string dFormIDLookupS(string id);

    internal delegate string[] dFormIDScan(string type);

    internal delegate Record[] dFormIDScanR(string type);

    internal delegate IEnumerable<KeyValuePair<uint, Record>> dFormIDScanRec(string type);
}