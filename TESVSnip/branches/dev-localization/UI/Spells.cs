namespace TESVSnip.UI
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Data.Strings;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework;
    using TESVSnip.Properties;

    /// <summary>
    /// This file contains the miscellaneous spells for the main form.
    /// </summary>
    internal static class Spells
    {
        private static readonly string[] LooseGroups = new[] { "CELL", "WRLD", "REFR", "ACRE", "ACHR", "NAVM", "DIAL", "INFO" };

        /// <summary>
        /// The sanitize order.
        /// </summary>
        /// HAZD appears twice in Skyrim.esm.  2nd entry is empty.
        private static readonly string[] SanitizeOrder = new[]
            {
                "GMST", "KYWD", "LCRT", "AACT", "TXST", "GLOB", "CLAS", "FACT", "HDPT", "HAIR", "EYES", "RACE", "SOUN", "ASPC", "MGEF", "SCPT", "LTEX", "ENCH", "SPEL", "SCRL", "ACTI", "TACT", "ARMO", 
                "BOOK", "CONT", "DOOR", "INGR", "LIGH", "MISC", "APPA", "STAT", "SCOL", "MSTT", "PWAT", "GRAS", "TREE", "CLDC", "FLOR", "FURN", "WEAP", "AMMO", "NPC_", "LVLN", "KEYM", "ALCH", "IDLM", 
                "COBJ", "PROJ", "HAZD", "SLGM", "LVLI", "WTHR", "CLMT", "SPGD", "RFCT", "REGN", "NAVI", "CELL", "WRLD", "DIAL", "QUST", "IDLE", "PACK", "CSTY", "LSCR", "LVSP", "ANIO", "WATR", "EFSH", 
                "EXPL", "DEBR", "IMGS", "IMAD", "FLST", "PERK", "BPTD", "ADDN", "AVIF", "CAMS", "CPTH", "VTYP", "MATT", "IPCT", "IPDS", "ARMA", "ECZN", "LCTN", "MESG", "RGDL", "DOBJ", "LGTM", "MUSC", 
                "FSTP", "FSTS", "SMBN", "SMQN", "SMEN", "DLBR", "MUST", "DLVW", "WOOP", "SHOU", "EQUP", "RELA", "SCEN", "ASTP", "OTFT", "ARTO", "MATO", "MOVT", "HAZD", "SNDR", "DUAL", "SNCT", "SOPM", 
                "COLL", "CLFM", "REVB"
            };

        public static int CopyRecordsTo(BaseRecord[] src, IGroupRecord dst)
        {
            int count = 0;
            if (src != null && dst != null)
            {
                if (dst is Plugin)
                {
                    var dstRec = src.Where(x => !LooseGroups.Contains(x.Name)).Select(x => x.Clone()).ToArray();
                    if (dstRec.All(x => x is Record))
                    {
                        // put records into appropriate groups
                        var groups = dst.Records.OfType<GroupRecord>();
                        var lookup = dstRec.GroupBy(r => r.Name).Select(g => new { key = g.Key, value = g.ToArray() }).ToLookup(k => k.key, v => v.value);
                        foreach (var kvp in lookup)
                        {
                            if (LooseGroups.Contains(kvp.Key))
                            {
                                dst.AddRecords(dstRec);
                            }
                            else
                            {
                                var gr = groups.FirstOrDefault(x => x.ContentsType == kvp.Key);
                                if (gr == null)
                                {
                                    gr = new GroupRecord(kvp.Key);
                                    dst.AddRecord(gr);
                                }

                                foreach (var list in kvp)
                                {
                                    gr.AddRecords(list);
                                }
                            }
                        }
                    }
                    else
                    {
                        dst.AddRecords(dstRec);
                    }

                    // handle loose groups by creating copy of parent groups
                    foreach (var srcRec in src.Where(x => LooseGroups.Contains(x.Name)))
                    {
                        var dstnodes = new Stack<BaseRecord>();
                        dstnodes.Push(srcRec.Clone(recursive: true));
                        for (var n = srcRec.Parent; n is GroupRecord; n = n.Parent)
                        {
                            dstnodes.Push(n.Clone(recursive: false));
                        }

                        var par = dst as IGroupRecord;
                        foreach (var baseRecord in dstnodes)
                        {
                            if (par == null)
                            {
                                break;
                            }

                            if (baseRecord is GroupRecord)
                            {
                                var gr = baseRecord as GroupRecord;
                                var pargr = par.Records.OfType<GroupRecord>().FirstOrDefault(x => x.IsEquivalent(gr));
                                if (pargr != null)
                                {
                                    par = pargr;
                                    continue;
                                }
                            }

                            par.AddRecord(baseRecord);
                            par = baseRecord as IGroupRecord;
                        }

                        count += dstnodes.Count;
                    }
                }
                else
                {
                    var dstRec = src.Select(x => x.Clone()).ToArray();
                    dst.AddRecords(dstRec);
                    count += dstRec.Count();
                }
            }

            return count;
        }

        /// <summary>
        /// Extract any internalized strings and put in string table.
        /// </summary>
        /// <param name="plugin">
        /// </param>
        /// <returns>
        /// The System.Int32.
        /// </returns>
        public static int ExtractInternalStrings(Plugin plugin)
        {
            int count = 0;

            // uint maxid = plugin.Masters.Max(x=>x.Strings.Count > 0 ? x.Strings.Keys.Max() : 0); // No need to check the masters string since the numbers are unique for every plugin
            bool anyModified = false;
            foreach (var record in plugin.Enumerate().OfType<Record>())
            {
                record.MatchRecordStructureToRecord();
                foreach (var sr in record.SubRecords)
                {
                    var elements = record.EnumerateElements(sr, rawData: true).ToList();
                    foreach (var elem in elements)
                    {
                        if (elem.Structure != null && elem.Structure.type == ElementValueType.LString)
                        {
                            var data = elem.Data;
                            uint id = TypeConverter.h2i(data);
                            if (id == 0)
                            {
                                continue;
                            }

                            if (data.Count == 4 && TypeConverter.IsLikelyString(data))
                            {
                                string str;
                                if (plugin.Strings.TryGetValue(id, out str))
                                {
                                    continue;
                                }
                            }

                            if (data.Count != 4 || TypeConverter.IsLikelyString(data))
                            {
                                string value = TypeConverter.GetString(data);
                                if (!string.IsNullOrEmpty(value))
                                {
                                    // uint nextid = Math.Max(maxid, plugin.Strings.Count == 0 ? 0 : plugin.Strings.Keys.Max()) + 1; // No need to check the masters strings since the numbers are unique for every plugin
                                    uint nextid = (plugin.Strings.Count == 0 ? 0 : plugin.Strings.Keys.Max()) + 1;
                                    int idx = plugin.Strings.FindValue(value);
                                    if (idx >= 0)
                                    {
                                        nextid = plugin.Strings.ElementAt(idx).Key;
                                    }
                                    else
                                    {
                                        plugin.Strings[nextid] = value;
                                    }

                                    elem.AssignValue<ArraySegment<byte>>(new ArraySegment<byte>((byte[])TypeConverter.i2h(nextid).Clone()));
                                    ++count;
                                }
                            }
                        }
                    }

                    if (elements.Any(x => x.Changed))
                    {
                        // need to repack the structure
                        using (var ms = new MemoryStream(sr.GetReadonlyData().Length))
                        {
                            foreach (var seg in elements.Select(elem => elem.Data))
                            {
                                ms.Write(seg.Array, seg.Offset, seg.Count);
                            }

                            sr.SetData(ms.ToArray());
                        }

                        anyModified = true;
                    }
                }
            }

            if (anyModified)
            {
                var tes4 = plugin.Records.OfType<Record>().FirstOrDefault(x => x.Name == "TES4");
                if (tes4 != null)
                {
                    tes4.Flags1 |= 0x00000080U;
                }
            }

            return count;
        }

        public static Plugin GetPluginFromNode(BaseRecord node)
        {
            BaseRecord tn = node;
            if (tn is Plugin)
            {
                return (Plugin)tn;
            }

            while (!(tn is Plugin) && tn != null)
            {
                tn = tn.Parent;
            }

            if (tn != null)
            {
                return tn as Plugin;
            }

            return null;
        }

        public static void ReorderSubrecords(Record rec)
        {
            if (rec == null || RecordStructure.Records == null)
            {
                return;
            }

            if (!RecordStructure.Records.ContainsKey(rec.Name))
            {
                return;
            }

            SubrecordStructure[] sss = RecordStructure.Records[rec.Name].subrecords;

            var subs = new List<SubRecord>(rec.SubRecords);
            foreach (var sub in subs)
            {
                sub.DetachStructure();
            }

            var newsubs = new List<SubRecord>();
            for (int ssidx = 0, sslen = 0; ssidx < sss.Length; ssidx += sslen)
            {
                SubrecordStructure ss = sss[ssidx];
                bool repeat = ss.repeat > 0;
                sslen = Math.Max(1, ss.repeat);

                bool found = false;
                do
                {
                    found = false;
                    for (int ssoff = 0; ssoff < sslen; ++ssoff)
                    {
                        ss = sss[ssidx + ssoff];
                        for (int i = 0; i < subs.Count; ++i)
                        {
                            var sr = subs[i];
                            if (sr.Name == ss.name)
                            {
                                newsubs.Add(sr);
                                subs.RemoveAt(i);
                                found = true;
                                break;
                            }
                        }
                    }
                }
                while (found && repeat);
            }

            newsubs.AddRange(subs);
            rec.SubRecords.Clear();
            rec.SubRecords.AddRange(newsubs);
        }

        public static void SanitizePlugin(Plugin plugin)
        {
            // performance update to prevent lists from updating currently selected record
            bool oldHoldUpdates = BaseRecord.HoldUpdates;
            try
            {
                BaseRecord.HoldUpdates = true;
                if (plugin == null)
                {
                    throw new ApplicationException("Cannot select plugin");
                }

                var hdr = plugin.Records.OfType<Rec>().FirstOrDefault(x => x.Name == "TES4");
                if (hdr == null)
                {
                    throw new ApplicationException(Resources.PluginLacksAValidTes4RecordCannotContinue);
                }

                var toParse = new Queue<BaseRecord>(plugin.Records.OfType<BaseRecord>().Where(x => !x.Equals(hdr)));
                plugin.Clear();
                plugin.AddRecord(hdr);

                var groups = new Dictionary<string, GroupRecord>();

                foreach (string s in SanitizeOrder)
                {
                    var gr = new GroupRecord(s);
                    plugin.AddRecord(gr);
                    groups[s] = gr;
                }

                bool looseGroupsWarning = false;
                bool unknownRecordsWarning = false;
                while (toParse.Count > 0)
                {
                    var r = toParse.Dequeue();
                    if (r is GroupRecord)
                    {
                        var gr = (GroupRecord)r;
                        if (gr.ContentsType == "CELL" || gr.ContentsType == "WRLD" || gr.ContentsType == "DIAL")
                        {
                            var gr2 = groups[gr.ContentsType];
                            foreach (BaseRecord r2 in gr.Records)
                            {
                                gr2.AddRecord(r2);
                            }

                            gr.Clear();
                        }
                        else
                        {
                            foreach (BaseRecord r2 in gr.Records)
                            {
                                toParse.Enqueue(r2);
                            }

                            gr.Clear();
                        }
                    }
                    else if (r is Record)
                    {
                        var r2 = (Record)r;
                        if (LooseGroups.Contains(r2.Name))
                        {
                            looseGroupsWarning = true;
                            plugin.AddRecord(r2);
                        }
                        else
                        {
                            if (groups.ContainsKey(r2.Name))
                            {
                                groups[r2.Name].AddRecord(r2);
                            }
                            else
                            {
                                unknownRecordsWarning = true;
                                plugin.AddRecord(r2);
                            }
                        }
                    }
                }

                foreach (GroupRecord gr2 in groups.Values)
                {
                    if (gr2.Records.Count == 0)
                    {
                        plugin.DeleteRecord(gr2);
                    }
                }

                if (looseGroupsWarning)
                {
                    MessageBox.Show(Resources.CannotSanitizeLooseGroups, Resources.WarningText);
                }

                if (unknownRecordsWarning)
                {
                    MessageBox.Show(Resources.CannotSanitizeUnknownRecords, Resources.WarningText);
                }

                plugin.InvalidateCache();

                plugin.UpdateRecordCount();

                /* int reccount = -1 + plugin.Records.Cast<Rec>().Sum(r => sanitizeCountRecords(r));
                var tes4 = plugin.Records.OfType<Record>().FirstOrDefault(x => x.Name == "TES4");
                if (tes4 != null)
                {
                    if (tes4.SubRecords.Count > 0 && tes4.SubRecords[0].Name == "HEDR" && tes4.SubRecords[0].Size >= 8)
                    {
                        byte[] data = tes4.SubRecords[0].GetData();
                        byte[] reccountbytes = TypeConverter.si2h(reccount);
                        for (int i = 0; i < 4; i++) data[4 + i] = reccountbytes[i];
                        tes4.SubRecords[0].SetData(data);
                    }
                } */
            }
            finally
            {
                BaseRecord.HoldUpdates = oldHoldUpdates;
            }
        }

        public static void StripEDIDs(Plugin p)
        {
            foreach (Rec r in p.Records)
            {
                StripEDIDsInternal(r);
            }
        }

        public static uint getNextFormID(Plugin plugin)
        {
            var tes4 = plugin.Records.OfType<Record>().FirstOrDefault(x => x.Name == "TES4");
            if (tes4 != null && tes4.SubRecords.Count > 0 && tes4.SubRecords[0].Name == "HEDR" && tes4.SubRecords[0].Size >= 8)
            {
                byte[] data = tes4.SubRecords[0].GetData();
                var formid = (uint)TypeConverter.GetObject<uint>(data, 8);
                TypeConverter.i2h(formid + 1, data, 8);
                tes4.SubRecords[0].SetData(data);
                return formid;
            }

            throw new ApplicationException(Resources.PluginLacksAValidTes4RecordCannotContinue);
        }

        public static void giveBaseRecordNewFormID(BaseRecord rec, bool updateReference)
        {
            uint formCount = 0, refCount = 0;
            giveBaseRecordNewFormID(rec, updateReference, ref formCount, ref refCount);
        }

        public static void giveBaseRecordNewFormID(BaseRecord rec, bool updateReference, ref uint formCount, ref uint refCount)
        {
            if (rec is Record)
            {
                giveRecordNewFormID((Record)rec, updateReference, ref formCount, ref refCount);
            }
            else if (rec is GroupRecord)
            {
                foreach (BaseRecord rec2 in ((GroupRecord)rec).Records)
                {
                    giveBaseRecordNewFormID(rec2, updateReference, ref formCount, ref refCount);
                }
            }
        }

        public static void giveRecordNewFormID(Record rec, bool updateReference)
        {
            uint formCount = 0, refCount = 0;
            giveRecordNewFormID(rec, updateReference, ref formCount, ref refCount);
        }

        public static void giveRecordNewFormID(Record rec, bool updateReference, ref uint formCount, ref uint refCount)
        {
            var plugin = GetPluginFromNode(rec);
            if (plugin == null)
            {
                throw new ApplicationException("Cannot select plugin");
            }

            uint newFormID = getNextFormID(plugin);
            uint oldFormID = rec.FormID;
            rec.FormID = newFormID;
            formCount++;
            if (oldFormID != 0 && updateReference)
            {
                updateFormIDReference(plugin, oldFormID, newFormID, ref refCount);
            }

            plugin.InvalidateCache();
        }

        public static void updateFormIDReference(Plugin plugin, uint oldFormID, uint newFormID)
        {
            uint refCount = 0;
            updateFormIDReference(plugin, oldFormID, newFormID, ref refCount);
        }

        public static void updateFormIDReference(Plugin plugin, uint oldFormID, uint newFormID, ref uint refCount)
        {
            foreach (Record record in plugin.Enumerate().OfType<Record>())
            {
                record.MatchRecordStructureToRecord();
                foreach (SubRecord sr in record.SubRecords)
                {
                    var elements = sr.EnumerateElements(true).ToList();
                    foreach (Element e in elements)
                    {
                        if (e.Structure != null && e.Structure.type == ElementValueType.FormID)
                        {
                            if ((uint)e.Value == oldFormID)
                            {
                                e.AssignValue<uint>((object)newFormID);
                                refCount++;
                            }
                        }
                    }
                }
            }
        }

        internal static int CleanUnusedStrings(Plugin plugin)
        {
            if (plugin == null)
            {
                return -1;
            }

            var masters = plugin.Masters;
            if (masters == null || masters.Length == 0)
            {
                return -1;
            }

            LocalizedStringDict oldStrings = plugin.Strings;
            plugin.Strings = new LocalizedStringDict();
            foreach (var record in plugin.Enumerate().OfType<Record>())
            {
                record.MatchRecordStructureToRecord();
                foreach (var sr in record.SubRecords)
                {
                    var elements = record.EnumerateElements(sr, rawData: true).ToList();
                    foreach (var elem in elements)
                    {
                        if (elem.Structure != null && elem.Structure.type == ElementValueType.LString)
                        {
                            var data = elem.Data;
                            if (data.Count == 4)
                            {
                                string value;
                                uint id = TypeConverter.h2i(data);
                                if (id == 0)
                                {
                                    continue;
                                }

                                if (oldStrings.TryGetValue(id, out value))
                                {
                                    oldStrings.Remove(id);
                                    plugin.Strings[id] = value;
                                }
                            }
                        }
                    }
                }
            }

            return oldStrings.Count;
        }

        /// <summary>
        /// Copy any strings references from master not currently in current plugin.
        /// </summary>
        /// <param name="plugin">
        /// </param>
        /// <returns>
        /// The System.Int32.
        /// </returns>
        internal static int CopyMasterStringReferences(Plugin plugin)
        {
            if (plugin == null)
            {
                return -1;
            }

            var masters = plugin.Masters;
            if (masters == null || masters.Length == 0)
            {
                return -1;
            }

            int count = 0;

            foreach (var record in plugin.Enumerate().OfType<Record>())
            {
                record.MatchRecordStructureToRecord();
                foreach (var sr in record.SubRecords)
                {
                    var elements = record.EnumerateElements(sr, rawData: true).ToList();
                    foreach (var elem in elements)
                    {
                        if (elem.Structure != null && elem.Structure.type == ElementValueType.LString)
                        {
                            var data = elem.Data;
                            if (data.Count == 4)
                            {
                                string value;
                                uint id = TypeConverter.h2i(data);
                                if (id == 0)
                                {
                                    continue;
                                }

                                if (!plugin.Strings.TryGetValue(id, out value))
                                {
                                    foreach (var master in masters.Reverse())
                                    {
                                        if (master.Strings.TryGetValue(id, out value))
                                        {
                                            ++count;
                                            plugin.Strings[id] = value;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            return count;
        }

        internal static int CreateStringStubs(Plugin plugin)
        {
            if (plugin == null)
            {
                return -1;
            }

            var masters = plugin.Masters;
            if (masters == null || masters.Length == 0)
            {
                return -1;
            }

            int count = 0;
            foreach (var record in plugin.Enumerate().OfType<Record>())
            {
                record.MatchRecordStructureToRecord();
                foreach (var sr in record.SubRecords)
                {
                    var elements = record.EnumerateElements(sr, rawData: true).ToList();
                    foreach (var elem in elements)
                    {
                        if (elem.Structure != null && elem.Structure.type == ElementValueType.LString)
                        {
                            var data = elem.Data;
                            if (data.Count == 4)
                            {
                                string value;
                                uint id = TypeConverter.h2i(data);
                                if (id == 0)
                                {
                                    continue;
                                }

                                if (!plugin.Strings.TryGetValue(id, out value))
                                {
                                    value = string.Format("STUB: {0} {1}", record.DescriptiveName, sr.DescriptiveName);
                                    plugin.Strings[id] = value;
                                    ++count;
                                }
                            }
                        }
                    }
                }
            }

            return count;
        }

        internal static int InternalizeStrings(Plugin plugin)
        {
            bool anyModified = false;
            int count = 0;
            foreach (var record in plugin.Enumerate().OfType<Record>())
            {
                record.MatchRecordStructureToRecord();
                foreach (var sr in record.SubRecords)
                {
                    var elements = record.EnumerateElements(sr, rawData: true).ToList();
                    foreach (var elem in elements)
                    {
                        if (elem.Structure != null && elem.Structure.type == ElementValueType.LString)
                        {
                            var data = elem.Data;
                            uint id = TypeConverter.h2i(data);
                            if (id == 0)
                            {
                                continue;
                            }

                            if (data.Count == 4)
                            {
                                var str = plugin.LookupFormStrings(id);
                                if (!string.IsNullOrEmpty(str))
                                {
                                    elem.AssignValue<ArraySegment<byte>>(new ArraySegment<byte>(TypeConverter.str2h(str)));
                                    ++count;
                                }
                            }
                        }
                    }

                    if (elements.Any(x => x.Changed))
                    {
                        // need to repack the structure
                        using (var ms = new MemoryStream(sr.GetReadonlyData().Length))
                        {
                            foreach (var seg in elements.Select(elem => elem.Data))
                            {
                                ms.Write(seg.Array, seg.Offset, seg.Count);
                            }

                            sr.SetData(ms.ToArray());
                        }

                        anyModified = true;
                    }
                }
            }

            if (anyModified)
            {
                var tes4 = plugin.Records.OfType<Record>().FirstOrDefault(x => x.Name == "TES4");
                if (tes4 != null)
                {
                    tes4.Flags1 &= ~0x00000080U;
                }
            }

            return count;
        }

        private static void StripEDIDsInternal(Rec r)
        {
            if (r is Record)
            {
                var r2 = (Record)r;
                if (r2.Name != "GMST" && r2.SubRecords.Count > 0 && r2.SubRecords[0].Name == "EDID")
                {
                    r2.DeleteRecord(r2.SubRecords[0]);
                }

                for (int i = 0; i < r2.SubRecords.Count; i++)
                {
                    if (r2.SubRecords[i].Name == "SCTX")
                    {
                        r2.SubRecords.RemoveAt(i--);
                    }
                }
            }
            else
            {
                foreach (Rec r2 in r.Records)
                {
                    StripEDIDsInternal(r2);
                }
            }
        }
    }

    // class Spells
}

//namespace TESVSnip
