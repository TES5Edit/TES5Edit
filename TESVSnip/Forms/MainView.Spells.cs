using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.AccessControl;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Serialization;
using TESVSnip.Data;
using TESVSnip.Properties;
using System.Drawing;

namespace TESVSnip
{
    /// <summary>
    /// This file contains the miscellaneous spells for the main form
    /// </summary>
    internal partial class MainView
    {
        private void sanitizeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (PluginTree.SelectedRecord == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }
            try
            {
                var rec = PluginTree.SelectedRecord as Record;
                var p = rec != null ? rec.GetPlugin() : null;
                TESVSnip.Spells.SanitizePlugin(p);
            }
            catch (ApplicationException ex)
            {
                MessageBox.Show(ex.Message, Resources.ErrorText);
            }
            catch
            {
                MessageBox.Show("Unknown Exception", Resources.ErrorText);
            }
            finally
            {
                PluginTree.RebuildObjects();
                SendStatusText("Sanitization Complete", SystemColors.ControlText);
            }
        }

        private void stripEDIDsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (PluginTree.SelectedRecord == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }
            if (MessageBox.Show(Resources.GeneralSpellWarningInquiry, Resources.WarningText, MessageBoxButtons.YesNo) !=
                DialogResult.Yes)
                return;
            var p = GetPluginFromNode(PluginTree.SelectedRecord);
            TESVSnip.Spells.StripEDIDs(p);
            PluginTree.RebuildObjects();
        }

        private bool findDuplicateFormIDs(BaseRecord tn, Dictionary<uint, Record> ids)
        {
            if (tn is Record)
            {
                var r2 = (Record)tn;
                if (ids.ContainsKey(r2.FormID))
                {
                    PluginTree.SelectedRecord = tn;
                    MessageBox.Show("Record duplicates " + (ids[r2.FormID]).DescriptiveName);
                    ids.Clear();
                    return true;
                }
                else
                {
                    ids.Add(r2.FormID, r2);
                }
            }
            else
            {
                foreach (BaseRecord tn2 in tn.Records) findDuplicateFormIDs(tn2, ids);
            }
            return false;
        }

        private void findDuplicatedFormIDToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Plugin plugin = GetPluginFromNode(PluginTree.SelectedRecord);
            var ids = new Dictionary<uint, Record>();
            foreach (var record in plugin.Enumerate().OfType<Record>())
            {
                if (ids.ContainsKey(record.FormID))
                {
                    if (record.FormID == 0 && record.Name == "COBJ")
                        continue; // FormID = 0 is valid for all COBJ records
                    PluginTree.SelectedRecord = record;
                    MessageBox.Show("Record duplicates " + (ids[record.FormID]).DescriptiveName);
                    SendStatusText(string.Format("Record FormID duplicates {0}", (ids[record.FormID]).DescriptiveName), Color.OrangeRed);
                    return;
                }
                else
                    ids.Add(record.FormID, record);
            }
            ids.Clear();
            SendStatusText("No duplicate FormID's found", SystemColors.ControlText);
        }

        private void DumpEdidsInternal(Rec r, StreamWriter sw)
        {
            if (r is Record)
            {
                var r2 = (Record)r;
                if (r2.SubRecords.Count > 0 && r2.SubRecords[0].Name == "EDID")
                    sw.WriteLine(r2.FormID.ToString("x8") + " : " + r2.SubRecords[0].GetStrData());
            }
            else
            {
                foreach (Rec r2 in (r).Records) DumpEdidsInternal(r2, sw);
            }
        }

        private void dumpEDIDListToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (PluginTree.SelectedRecord == null) return;
            if (PluginTree.SelectedRecord is Record)
            {
                MessageBox.Show("Spell works only on plugins or record groups", "Error");
                return;
            }
            if (SaveEdidListDialog.ShowDialog() != DialogResult.OK) return;
            var sw = new StreamWriter(SaveEdidListDialog.FileName);
            if (PluginTree.SelectedRecord is Plugin)
            {
                foreach (Rec r in (PluginTree.SelectedRecord).Records)
                {
                    DumpEdidsInternal(r, sw);
                }
            }
            else
            {
                DumpEdidsInternal((GroupRecord)PluginTree.SelectedRecord, sw);
            }
            sw.Close();
        }

        private void cleanRecurse(Rec r, uint match, uint mask, Dictionary<uint, Record> lookup)
        {
            var r2 = r as Record;
            if (r2 != null)
            {
                if ((r2.FormID & 0xff000000) == match)
                {
                    if (r2.Name != "REFR" && r2.Name != "ACHR" && r2.Name != "NAVM" && r2.Name != "INFO")
                        lookup[(r2.FormID & 0xffffff) | mask] = r2;
                }
            }
            else
            {
                foreach (Rec r3 in (r).Records)
                {
                    cleanRecurse(r3, match, mask, lookup);
                }
            }
        }

        private bool cleanRecurse2(Rec r, ref int count, Dictionary<uint, Record> lookup)
        {
            var r2 = r as Record;
            if (r2 != null)
            {
                if (lookup.ContainsKey(r2.FormID))
                {
                    Record r3 = lookup[r2.FormID];
                    if (r2.Name == r3.Name && r2.Size == r3.Size && r2.SubRecords.Count == r3.SubRecords.Count &&
                        r2.Flags1 == r3.Flags1 &&
                        r2.Flags2 == r3.Flags2 && r2.Flags3 == r3.Flags3)
                    {
                        for (int i = 0; i < r2.SubRecords.Count; i++)
                        {
                            if (r2.SubRecords[i].Name != r3.SubRecords[i].Name ||
                                r2.SubRecords[i].Size != r3.SubRecords[i].Size) return false;
                            byte[] data1 = r2.SubRecords[i].GetReadonlyData(),
                                   data2 = r3.SubRecords[i].GetReadonlyData();
                            for (int j = 0; j < data1.Length; j++) if (data1[j] != data2[j]) return false;
                        }
                        return true;
                    }
                }
            }
            else
            {
                var gr = (GroupRecord)r;
                for (int i = 0; i < gr.Records.Count; i++)
                {
                    if (cleanRecurse2(gr.Records[i] as Rec, ref count, lookup))
                    {
                        count++;
                        gr.Records.RemoveAt(i--);
                    }
                }
            }
            return false;
        }

        private void cleanEspToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (PluginTree.SelectedRecord == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, "Error");
                return;
            }
            if (
                MessageBox.Show("This may delete records from the esp.\nAre you sure you wish to continue?", "Warning",
                                MessageBoxButtons.YesNo) != DialogResult.Yes) return;
            FixMasters();
            var plugin = GetPluginFromNode(PluginTree.SelectedRecord);

            var lookup = new Dictionary<uint, Record>();
            bool missingMasters = false;
            for (int i = 0; i < plugin.Masters.Length - 1; i++)
            {
                if (plugin.Masters[i] == null)
                {
                    missingMasters = true;
                    continue;
                }
                var tes4 = plugin.Records.OfType<Record>().FirstOrDefault(x => x.Name == "TES4");
                if (plugin.Masters[i].Records.Count < 2 || tes4 == null) continue;
                var match = (uint)plugin.Masters.Count(x => x.Name == "MAST");
                match <<= 24;
                uint mask = (uint)i << 24;
                for (int j = 1; j < plugin.Masters[i].Records.Count; j++)
                    cleanRecurse(plugin.Masters[i].Records[j] as Rec, match, mask, lookup);
            }

            if (missingMasters)
            {
                MessageBox.Show("One or more dependencies are not loaded, and will be ignored.", "Warning");
            }

            int count = 0;
            for (int j = 1; j < plugin.Masters[plugin.Masters.Length - 1].Records.Count; j++)
                cleanRecurse2(plugin.Masters[plugin.Masters.Length - 1].Records[j] as Rec, ref count, lookup);
            if (count == 0) MessageBox.Show("No records removed");
            else MessageBox.Show("" + count + " records removed");


            PluginTree.Refresh();
        }


        private void compileScriptToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FixMasters();
            var r = PluginTree.SelectedRecord as Record;
            var plugin = GetPluginFromNode(r);
            if (plugin == null || plugin.Parent == null) return;

            string errors;
            if (Selection.SelectedSubrecord && Selection.Record.Name != "SCPT")
            {
                var sr = SubrecordList.SubRecord;
                if (sr == null) return;
                if (sr.Name != "SCTX")
                {
                    MessageBox.Show("You need to select a SCPT record or SCTX subrecord to compile", "Error");
                    return;
                }
                ScriptCompiler.ScriptCompiler.Setup(plugin.Masters);
                Record r2;
                if (!ScriptCompiler.ScriptCompiler.CompileResultScript(sr, out r2, out errors))
                {
                    MessageBox.Show("There were compilation errors:\n" + errors);
                }
                else
                {
                    var srs = r.SubRecords;
                    int i = srs.IndexOf(sr);
                    if (i >= 0)
                    {
                        while (i > 0 && (srs[i - 1].Name == "SCDA" || srs[i - 1].Name == "SCHR"))
                            srs.RemoveAt(--i);
                        while (i < srs.Count &&
                               (srs[i].Name == "SCTX" || srs[i].Name == "SLSD" || srs[i].Name == "SCVR" ||
                                srs[i].Name == "SCRO" || srs[i].Name == "SCRV"))
                            srs.RemoveAt(i);
                        srs.InsertRange(i, r2.SubRecords);
                        RebuildSelection();
                        PluginTree.RefreshObject(r);
                    }
                }
                return;
            }
            if (r == null || (r.Name != "SCPT"))
            {
                MessageBox.Show("You need to select a SCPT record or SCTX subrecord to compile", "Error");
                return;
            }

            ScriptCompiler.ScriptCompiler.Setup(plugin.Masters);
            if (!ScriptCompiler.ScriptCompiler.Compile(r, out errors))
            {
                MessageBox.Show("There were compilation errors:\n" + errors);
            }
            else
            {
                RebuildSelection();
                PluginTree.RebuildObjects();
            }
        }

        private void compileAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string errors;
            string thingy = "";
            int count = 0, failed = 0, failed2 = 0;
            int size;

            FixMasters();
            var plugin = GetPluginFromNode(PluginTree.SelectedRecord);
            if (plugin == null) return;

            ScriptCompiler.ScriptCompiler.Setup(plugin.Masters);
            foreach (Rec rec in plugin.Records)
            {
                var gr = rec as GroupRecord;
                if (gr == null) continue;
                if (gr.ContentsType == "SCPT")
                {
                    foreach (Record r in gr.Records)
                    {
                        count++;
                        size = 0;
                        foreach (SubRecord sr in r.SubRecords)
                        {
                            if (sr.Name == "SCDA")
                            {
                                size = (int)sr.Size;
                                break;
                            }
                        }
                        if (!ScriptCompiler.ScriptCompiler.Compile(r, out errors))
                        {
                            failed++;
                            thingy += r.DescriptiveName + Environment.NewLine + errors + Environment.NewLine +
                                      Environment.NewLine;
                        }
                        else
                        {
                            foreach (SubRecord sr in r.SubRecords)
                            {
                                if (sr.Name == "SCDA")
                                {
                                    if (sr.Size != size)
                                    {
                                        failed2++;
                                        thingy += r.DescriptiveName + Environment.NewLine + "Size changed from " + size +
                                                  " to " + sr.Size + Environment.NewLine + Environment.NewLine;
                                    }
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            thingy += Environment.NewLine + Environment.NewLine + "Final results: " + count + "/" + failed + "/" +
                      failed2;
            File.WriteAllText("script results.txt", thingy);
        }

        private void generateLLXmlToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FixMasters();
            var plugin = GetPluginFromNode(PluginTree.SelectedRecord);
            if (plugin == null) return;
            var p = plugin;

            {
                Record r;
                if (p.Records.Count > 0) r = p.Records[0] as Record;
                else r = null;
                bool firstwasfallout = false;
                if (r != null && r.Name == "TES4")
                {
                    foreach (SubRecord sr in r.SubRecords)
                    {
                        if (sr.Name == "MAST")
                        {
                            if (sr.GetStrData().ToLowerInvariant() == "skyrim.esm") firstwasfallout = true;
                            break;
                        }
                    }
                }
                if (!firstwasfallout)
                {
                    MessageBox.Show("Only works on plugin's whose first master is Skyrim.esm", "Error");
                    return;
                }
            }

            uint mask = (uint)(plugin.Masters.Length - 1) << 24;
            var recs = new Queue<Rec>(p.Records.OfType<Rec>());

            var sb2 = new StringBuilder();
            var sb3 = new StringBuilder();
            while (recs.Count > 0)
            {
                Rec rec = recs.Dequeue();
                if (rec is GroupRecord)
                {
                    var gr = (GroupRecord)rec;
                    if (gr.ContentsType == "LVLI" || gr.ContentsType == "LVLN" || gr.ContentsType == "LVLC")
                    {
                        for (int i = 0; i < gr.Records.Count; i++) recs.Enqueue(gr.Records[i] as Rec);
                    }
                }
                else
                {
                    var r = (Record)rec;
                    String edid = "";
                    byte chance = 0;
                    byte flags = 0;
                    if ((r.FormID & 0xff000000) != 0) continue;
                    switch (r.Name)
                    {
                        case "LVLI":
                            for (int i = 0; i < r.SubRecords.Count; i++)
                            {
                                if (r.SubRecords[i].Name == "EDID")
                                {
                                    edid = r.SubRecords[i].GetStrData();
                                }
                                else if (r.SubRecords[i].Name == "LVLD")
                                {
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    chance = data[0];
                                }
                                else if (r.SubRecords[i].Name == "LVLF")
                                {
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    flags = data[0];
                                }
                                else if (r.SubRecords[i].Name == "LVLO")
                                {
                                    if (r.SubRecords[i].Size != 12) continue;
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    uint formid = TypeConverter.h2i(data[4], data[5], data[6], data[7]);
                                    // if ((formid & 0xff000000) != mask) continue;
                                    sb3.AppendLine("      <LVLO level=\"" + TypeConverter.h2ss(data[0], data[1]) +
                                               "\" formid=\"" + (formid & 0xffffff).ToString("X6") + 
                                               "\" count=\"" + TypeConverter.h2ss(data[8], data[9]) + "\" />");
                                }
                            }
                            if (sb3.Length > 0)
                            {
                                sb2.AppendLine("    <LVLI formid=\"" + r.FormID.ToString("X6") + "\" edid=\"" + edid + "\">");
                                sb2.AppendLine("      <LVLF flags=\"" + flags + "\"/>");
                                sb2.AppendLine("      <LVLD chance=\"" + chance + "\"/>");
                                sb2.Append(sb3.ToString());
                                sb2.AppendLine("    </LVLI>");
                            }
                            sb3.Length = 0;
                            break;
                        case "LVLN":
                            for (int i = 0; i < r.SubRecords.Count; i++)
                            {
                                if (r.SubRecords[i].Name == "EDID")
                                {
                                    edid = r.SubRecords[i].GetStrData();
                                }
                                else if (r.SubRecords[i].Name == "LVLD")
                                {
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    chance = data[0];
                                }
                                else if (r.SubRecords[i].Name == "LVLF")
                                {
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    flags = data[0];
                                }
                                else if (r.SubRecords[i].Name == "LVLO")
                                {
                                    if (r.SubRecords[i].Size != 12) continue;
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    uint formid = TypeConverter.h2i(data[4], data[5], data[6], data[7]);
//                                    if ((formid & 0xff000000) != mask) continue;
                                    sb3.AppendLine("      <LVLO level=\"" + TypeConverter.h2ss(data[0], data[1]) +
                                                   "\" formid=\"" + (formid & 0xffffff).ToString("X6") + 
                                                   "\" count=\"" + TypeConverter.h2ss(data[8], data[9]) + "\" />");
                                }
                            }
                            if (sb3.Length > 0)
                            {
                                sb2.AppendLine("    <LVLN formid=\"" + r.FormID.ToString("X6") + "\" edid=\"" + edid + "\">");
                                sb2.AppendLine("      <LVLF flags=\"" + flags + "\"/>");
                                sb2.AppendLine("      <LVLD chance=\"" + chance + "\"/>");
                                sb2.Append(sb3.ToString());
                                sb2.AppendLine("    </LVLN>");
                            }
                            sb3.Length = 0;
                            break;
                        case "LVSP":
                            for (int i = 0; i < r.SubRecords.Count; i++)
                            {
                                if (r.SubRecords[i].Name == "EDID")
                                {
                                    edid = r.SubRecords[i].GetStrData();
                                }
                                else if (r.SubRecords[i].Name == "LVLD")
                                {
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    chance = data[0];
                                }
                                else if (r.SubRecords[i].Name == "LVLF")
                                {
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    flags = data[0];
                                }
                                else if (r.SubRecords[i].Name == "LVLO")
                                {
                                    if (r.SubRecords[i].Size != 12) continue;
                                    byte[] data = r.SubRecords[i].GetReadonlyData();
                                    uint formid = TypeConverter.h2i(data[4], data[5], data[6], data[7]);
//                                    if ((formid & 0xff000000) != mask) continue;
                                    sb3.AppendLine("      <LVLO level=\"" + TypeConverter.h2ss(data[0], data[1]) +
                                                   "\" formid=\"" + (formid & 0xffffff).ToString("X6") + 
                                                   "\" count=\"" + TypeConverter.h2ss(data[8], data[9]) + "\" />");
                                }
                            }
                            if (sb3.Length > 0)
                            {
                                sb2.AppendLine("    <LVSP formid=\"" + r.FormID.ToString("X6") + "\" edid=\"" + edid + "\">");
                                sb2.AppendLine("      <LVLF flags=\"" + flags + "\"/>");
                                sb2.AppendLine("      <LVLD chance=\"" + chance + "\"/>");
                                sb2.Append(sb3.ToString());
                                sb2.AppendLine("    </LVLC>");
                            }
                            sb3.Length = 0;
                            break;
                    }
                }
            }
            if (sb2.Length > 0)
            {
                var sb1 = new StringBuilder();
                sb1.AppendLine("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
                sb1.AppendLine("<Plugin>");
                sb1.AppendLine("  <MergedLists>");
                sb1.Append(sb2);
                sb1.AppendLine("  </MergedLists>");
                sb1.AppendLine("</Plugin>");
                File.WriteAllText(Path.ChangeExtension(p.Name, ".xml"), sb1.ToString());
            }
            else MessageBox.Show("No compatible leveled lists found");
        }

        private void makeEsmToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (PluginTree.SelectedRecord == null) return;

            var p = GetPluginFromNode(PluginTree.SelectedRecord);
            var tes4 = p.Records.OfType<Record>().FirstOrDefault(x => x.Name == "TES4");
            if (tes4 == null)
            {
                MessageBox.Show("Plugin has no TES4 record");
                return;
            }
            if ((tes4.Flags1 & 1) == 1)
            {
                MessageBox.Show("Plugin is already a master file");
                return;
            }
            tes4.Flags1 |= 1;
            p.Name = Path.ChangeExtension(p.Name, ".esm");
            SaveModDialog.FileName = p.Name;
            if (SaveModDialog.ShowDialog() == DialogResult.OK)
            {
                p.Save(SaveModDialog.FileName);
            }
        }

        private void martigensToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (PluginTree.SelectedRecord == null) return;

            var p = GetPluginFromNode(PluginTree.SelectedRecord);

            var f = new Form();
            f.Text = "Replace";
            var tb = new TextBox();
            f.Controls.Add(tb);
            tb.Dock = DockStyle.Fill;
            tb.AcceptsReturn = true;
            tb.Multiline = true;
            tb.ScrollBars = ScrollBars.Vertical;
            f.ShowDialog();

            string replace = tb.Text;
            f.Text = "Replace with";
            tb.Text = "";
            f.ShowDialog();
            string with = tb.Text;

            var recs = new Queue<Rec>(p.Records.OfType<Rec>());
            while (recs.Count > 0)
            {
                if (recs.Peek() is GroupRecord)
                {
                    var gr = (GroupRecord)recs.Dequeue();
                    for (int i = 0; i < gr.Records.Count; i++) recs.Enqueue(gr.Records[i] as Rec);
                }
                else
                {
                    var r = (Record)recs.Dequeue();
                    foreach (SubRecord sr in r.SubRecords)
                    {
                        if (sr.Name != "SCTX") continue;
                        string text = sr.GetStrData();
                        int upto = 0;
                        bool replaced = false;
                        while (true)
                        {
                            int i = text.IndexOf(replace, upto, StringComparison.InvariantCultureIgnoreCase);
                            if (i == -1) break;
                            text = text.Remove(i, replace.Length).Insert(i, with);
                            upto = i + with.Length;
                            replaced = true;
                        }
                        if (replaced)
                        {
                            sr.SetStrData(text, false);
                        }
                    }
                }
            }
        }

        #region Reorder Subrecords

        // try to reorder subrecords to match the structure file.
        private void reorderSubrecordsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var records = PluginTree.SelectedRecords.SelectMany(rec => rec.Enumerate(x => true).OfType<Record>().Distinct()).ToList();
            bool oldHoldUpdates = BaseRecord.HoldUpdates;
            try
            {
                foreach (var rec in records)
                    TESVSnip.Spells.ReorderSubrecords(rec);
            }
            finally
            {
                BaseRecord.HoldUpdates = oldHoldUpdates;
                RebuildSelection();
                SendStatusText(string.Format("Reordered SubRecords on {0} records", records.Count), SystemColors.ControlText);
            }
        }

        #endregion

        #region Create Record Structure XML

        private void createRecordStructureXmlToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var p = GetPluginFromNode(PluginTree.SelectedRecord);

            var builder = new RecordBuilder();
            builder.FormLookup = GetRecordByID;
            builder.StringLookup = LookupFormStrings;
            builder.CancelAction = () => { return backgroundWorker1.CancellationPending; };
            builder.UpdateProgressAction = UpdateBackgroundProgress;

            StartBackgroundWork(
                () => { builder.Start(p); },
                () =>
                {
                    if (!IsBackroundProcessCanceled())
                    {
                        using (var dlg = new SaveFileDialog())
                        {
                            dlg.InitialDirectory = Path.GetTempPath();
                            dlg.FileName = "RecordStructure.xml";
                            dlg.OverwritePrompt = false;
                            if (dlg.ShowDialog() == DialogResult.OK)
                            {
                                var xs = new XmlSerializer(typeof(Records));
                                using (StreamWriter fs = File.CreateText(dlg.FileName))
                                {
                                    xs.Serialize(fs, builder.Complete());
                                }
                            }
                        }
                    }
                }
                );
        }

        #endregion

        private void extractInternalStringsToTableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }
            int count = Spells.ExtractInternalStrings(plugin);
            if (count > 0)
                SendStatusText(string.Format("Copied {0} strings to table", count), SystemColors.ControlText);
            else
                SendStatusText("No strings to copied to table", Color.OrangeRed);
        }


        private void copyReferencedStringsFromMastersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }
            if (plugin.Masters.Length <= 1)
            {
                MessageBox.Show("Plugin does not have any Masters. Use 'Add Masters...' to add references before running.", Resources.ErrorText);
                return;
            }
            int count = Spells.CopyMasterStringReferences(plugin);
            if (count > 0)
                SendStatusText(string.Format("Copied {0} strings from master", count), SystemColors.ControlText);
            else
                SendStatusText("No strings to copy from master", Color.OrangeRed);
        }

        private void cleanUnusedStringsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }
            int count = Spells.CleanUnusedStrings(plugin);
            if (count > 0)
                SendStatusText(string.Format("Cleaned {0} unused strings from table", count), SystemColors.ControlText);
            else
                SendStatusText("No unused strings to clean", Color.OrangeRed);
        }

        private void createStubsForMissingStringsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }
            int count = Spells.CreateStringStubs(plugin);
            if (count > 0)
                SendStatusText(string.Format("Created {0} strings stubs", count), SystemColors.ControlText);
            else
                SendStatusText("No strings needed stubs", Color.OrangeRed);
        }

        private void saveStringsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }

            using (var dlg = new System.Windows.Forms.SaveFileDialog())
            {
                if (string.IsNullOrEmpty(Properties.Settings.Default.DefaultSaveFolder)
                    || !Directory.Exists(Properties.Settings.Default.DefaultSaveFolder))
                    dlg.InitialDirectory = Path.Combine(Program.gameDataDir, "Strings");
                else
                    dlg.InitialDirectory = Path.Combine(Properties.Settings.Default.DefaultSaveFolder, "Strings");

                dlg.DefaultExt = ".STRINGS";
                dlg.Filter = "String Table|*.STRINGS";
                dlg.CheckPathExists = true;
                dlg.AddExtension = true;
                dlg.OverwritePrompt = true;
                dlg.FileName = string.Format("{0}_{1}.STRINGS"
                    , Path.GetFileNameWithoutExtension(plugin.Name)
                    , Properties.Settings.Default.LocalizationName);
                if (dlg.ShowDialog(this) == DialogResult.OK)
                {
                    plugin.SaveStrings(Path.Combine(Path.GetDirectoryName(dlg.FileName),
                                                    Path.GetFileNameWithoutExtension(dlg.FileName)));
                }
            }
        }

        private void exportStringsToFileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }

            var lstrings = new LocalizedStrings
            {
                Strings = plugin.Strings.Select(x => new LocalizedString { ID = x.Key, Type = LocalizedStringFormat.Base, Value = x.Value })
                .Union(plugin.DLStrings.Select(x => new LocalizedString { ID = x.Key, Type = LocalizedStringFormat.DL, Value = x.Value }))
                .Union(plugin.ILStrings.Select(x => new LocalizedString { ID = x.Key, Type = LocalizedStringFormat.IL, Value = x.Value }))
                .ToArray()
            };
            if ( lstrings.Strings.Length == 0 )
            {
                MessageBox.Show("No strings available to export.", Resources.ErrorText);
                return;                
            }

            using (var dlg = new System.Windows.Forms.SaveFileDialog())
            {
                if (string.IsNullOrEmpty(Properties.Settings.Default.DefaultSaveFolder)
                    || !Directory.Exists(Properties.Settings.Default.DefaultSaveFolder))
                    dlg.InitialDirectory = Path.Combine(Program.gameDataDir, "Strings");
                else
                    dlg.InitialDirectory = Path.Combine(Properties.Settings.Default.DefaultSaveFolder, "Strings");
                dlg.DefaultExt = ".xml";
                dlg.Filter = "String Table|*.xml";
                dlg.CheckPathExists = true;
                dlg.AddExtension = true;
                dlg.OverwritePrompt = true;
                dlg.FileName = string.Format("{0}_{1}.xml"
                    , Path.GetFileNameWithoutExtension(plugin.Name)
                    , Properties.Settings.Default.LocalizationName);
                if (dlg.ShowDialog(this) == DialogResult.OK)
                {
                    var xs = new XmlSerializer(typeof (LocalizedStrings));
                    using ( var tw = new XmlTextWriter(dlg.FileName, System.Text.Encoding.Unicode))
                    {
                        tw.Formatting = Formatting.Indented;
                        xs.Serialize(tw, lstrings);
                    }
                }
            }
        }

        private void importStringsToFileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }

            try
            {
                using (var dlg = new System.Windows.Forms.OpenFileDialog())
                {
                    if (string.IsNullOrEmpty(Properties.Settings.Default.DefaultSaveFolder)
                        || !Directory.Exists(Properties.Settings.Default.DefaultSaveFolder))
                        dlg.InitialDirectory = Path.Combine(Program.gameDataDir, "Strings");
                    else
                        dlg.InitialDirectory = Path.Combine(Properties.Settings.Default.DefaultSaveFolder, "Strings");
                    dlg.DefaultExt = ".xml";
                    dlg.Filter = "String Table|*.xml";
                    dlg.CheckPathExists = true;
                    dlg.CheckFileExists = true;
                    dlg.AddExtension = true;
                    dlg.FileName = string.Format("{0}_{1}.xml"
                        , Path.GetFileNameWithoutExtension(plugin.Name)
                        , Properties.Settings.Default.LocalizationName);
                    if (dlg.ShowDialog(this) == DialogResult.OK)
                    {
                        var xs = new XmlSerializer(typeof(LocalizedStrings));
                        using (var fs = new FileStream(dlg.FileName, FileMode.Open, FileAccess.Read))
                        {
                            var lstrings = xs.Deserialize(fs) as LocalizedStrings;
                            if (lstrings != null && lstrings.Strings != null && lstrings.Strings.Length > 0)
                            {
                                foreach (var lstring in lstrings.Strings)
                                {
                                    if (lstring.ID == 0 || string.IsNullOrEmpty(lstring.Value))
                                        continue;
                                    switch (lstring.Type)
                                    {
                                        case LocalizedStringFormat.Base: plugin.Strings[lstring.ID] = lstring.Value; break;
                                        case LocalizedStringFormat.DL: plugin.DLStrings[lstring.ID] = lstring.Value; break;
                                        case LocalizedStringFormat.IL: plugin.ILStrings[lstring.ID] = lstring.Value; break;
                                    }
                                }
                                SendStatusText(string.Format("Imported {0} strings", lstrings.Strings.Length), SystemColors.ControlText);
                            }
                            else
                            {
                                SendStatusText("No strings internalized", Color.OrangeRed);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error while reading string table:\n" + ex.Message, Resources.ErrorText);
            }
        }

        private void internalizeStringReferencesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Find all lstring that are internalized and rewrite to 
            var plugin = GetPluginFromNode(this.PluginTree.SelectedRecord);
            if (plugin == null)
            {
                MessageBox.Show(Resources.NoPluginSelected, Resources.ErrorText);
                return;
            }
            if (plugin.Masters.Length <= 1)
            {
                MessageBox.Show("Plugin does not have any Masters. Use 'Add Masters...' to add references before running.", Resources.ErrorText);
                return;
            }
            int count = Spells.InternalizeStrings(plugin);
            if (count > 0)
                SendStatusText(string.Format("Internalized {0} strings", count), SystemColors.ControlText);
            else
                SendStatusText("No strings internalized", Color.OrangeRed);

        }

        public void giveSelectionNewFormID(bool updateReference)
        {
            var recs = this.PluginTree.SelectedRecords;
            uint formCount = 0, refCount = 0;
            try
            {
                foreach (var rec in recs)
                {
                    Spells.giveBaseRecordNewFormID(rec, updateReference, ref formCount, ref refCount);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, Resources.ErrorText);
            }
            RebuildSelection();
            if (formCount > 0)
                SendStatusText(string.Format("Changed {0} FormID's and updated {1} references", formCount, refCount), SystemColors.ControlText);
            else
                SendStatusText("No FormID's changed", Color.OrangeRed);
        }

    }
}