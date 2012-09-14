namespace TESVSnip.UI.ObjectControls
{
    using System;
    using System.Collections.Generic;
    using System.Collections.Specialized;
    using System.ComponentModel;
    using System.Drawing;
    using System.Linq;
    using System.Windows.Forms;

    using BrightIdeasSoftware;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework.Collections;
    using TESVSnip.Properties;
    using TESVSnip.UI.Forms;

    using Settings = TESVSnip.Properties.Settings;

    public partial class SubrecordListEditor : UserControl, ISupportInitialize
    {
        private bool DragDropInProgress;

        private SelectionContext context;

        private AdvancedList<SubRecord> subrecords;

        public SubrecordListEditor()
        {
            this.InitializeComponent();
        }

        public delegate void EditSubrecordHandler(SubRecord sr, bool hexView);

        public event EventHandler DataChanged;

        public event EditSubrecordHandler OnEditSubrecord;

        public event EventHandler SelectionChanged;

        internal event EventHandler<RecordChangeEventArgs> OnSubrecordChanged;

        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public Record Record
        {
            get
            {
                return this.context.Record as Record;
            }

            set
            {
                this.context.Record = value;
            }
        }

        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public SubRecord SubRecord
        {
            get
            {
                return this.context.SubRecord;
            }

            set
            {
                this.context.SubRecord = value;
            }
        }

        public AdvancedList<SubRecord> SubRecords
        {
            get
            {
                return this.subrecords;
            }

            set
            {
                this.subrecords = value;
                this.listSubrecord.DataSource = this.subrecords;
            }
        }

        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        protected SelectionContext Selection
        {
            get
            {
                return this.context;
            }
        }

        public void BeginInit()
        {
        }

        public void DeleteSelection()
        {
            int idx = this.listSubrecord.SelectedIndices[0];
            var objects = this.GetSelectedSubrecords();
            if (!objects.Any())
            {
                return;
            }

            this.subrecords.RemoveRange(objects);
            this.FireSelectionChanged();

            if (idx > this.listSubrecord.Items.Count - 1)
            {
                idx = this.listSubrecord.Items.Count - 1;
            }

            if (idx > 0)
            {
                this.SelectIndex(idx);
            }

            this.UpdateToolStripSelection();
            foreach (var sr in objects.Where(sr => sr.Parent is Record).Select(sr => sr.Parent).Distinct())
            {
                sr.UpdateShortDescription();
            }

            this.listSubrecord.Refresh();
        }

        public void EditSelectedSubrecord()
        {
            var context = this.Selection;
            var rec = this.Selection.Record as Record;
            if (rec == null)
            {
                return;
            }

            var p = this.GetPluginFromNode(rec);
            if (p == null)
            {
                return;
            }

            var sr = this.GetSelectedSubrecord();
            if (sr == null)
            {
                return;
            }

            if (this.OnEditSubrecord != null)
            {
                this.OnEditSubrecord(sr, false);
                return;
            }

            if (Settings.Default.UseOldSubRecordEditor)
            {
                new DataEdit(sr.Name, sr.GetData()).ShowDialog();
                if (!DataEdit.Canceled)
                {
                    sr.SetData(DataEdit.result);
                    sr.Name = DataEdit.resultName;
                }
            }
            else if (!Settings.Default.UseHexSubRecordEditor && sr.Structure != null && sr.Structure.elements != null && sr.Structure.elements.Length > 0
                     && sr.Structure.elements[0].type != ElementValueType.Blob && !sr.Structure.UseHexEditor)
            {
                Form re;
                try
                {
                    if (Settings.Default.UseOldSubRecordEditor)
                    {
                        var r = context.Record;
                        var formIDLookup = new dFormIDLookupS(p.LookupFormIDS);
                        var formIDScan = new dFormIDScan(this.FormIDScan);
                        var strIDLookup = new dLStringLookup(p.LookupFormStrings);
                        re = new MediumLevelRecordEditor(sr, sr.Structure, formIDLookup, formIDScan, strIDLookup);
                    }
                    else
                    {
                        re = new NewMediumLevelRecordEditor(p, rec, sr, sr.Structure);
                    }
                }
                catch
                {
                    MessageBox.Show("Subrecord doesn't seem to conform to the expected structure.", Resources.ErrorText);
                    re = null;
                }

                if (re != null)
                {
                    if (DialogResult.OK == re.ShowDialog(this))
                    {
                        if (sr.Parent is Record)
                        {
                            sr.Parent.UpdateShortDescription();
                        }

                        this.listSubrecord.Refresh();
                        this.FireSubrecordChanged(sr);
                        this.FireDataChanged();
                    }

                    return;
                }
            }
            else
            {
                this.EditSelectedSubrecordHex();
            }
        }

        public void EndInit()
        {
            if (DesignMode)
            {
                return;
            }

            this.InitializeSubrecordForm();
            this.SetContext(new SelectionContext());
        }

        public void PasteFromClipboard()
        {
            this.PasteSubRecord();
        }

        public void RefreshObject(object model)
        {
            // this.listSubrecord.RefreshObject(model);
            this.listSubrecord.Refresh();
        }

        public void SetContext(SelectionContext context)
        {
            // this.context = context.Clone();
            if (this.context != context)
            {
                if (this.context != null)
                {
                    this.context.RecordChanged -= this.context_RecordChanged;
                    this.context.SubRecordChanged -= this.context_SubRecordChanged;
                }

                this.context = context;
                if (this.context != null)
                {
                    this.context.SubRecordChanged += this.context_SubRecordChanged;
                    this.context.RecordChanged += this.context_RecordChanged;
                }
            }
        }

        internal void EditSelectedSubrecordHex()
        {
            try
            {
                var rec = this.Selection.Record as Record;
                if (rec == null)
                {
                    return;
                }

                var p = this.GetPluginFromNode(rec);
                if (p == null)
                {
                    return;
                }

                var sr = this.GetSelectedSubrecord();
                if (sr == null)
                {
                    return;
                }

                if (this.OnEditSubrecord != null)
                {
                    this.OnEditSubrecord(sr, true);
                    return;
                }

                using (var form = new HexDataEdit(sr.Name, sr.GetData(), p.LookupFormIDS))
                {
                    DialogResult result = form.ShowDialog(this);
                    if (result == DialogResult.OK)
                    {
                        sr.SetData(HexDataEdit.result);
                        sr.Name = HexDataEdit.resultName;
                        rec.MatchRecordStructureToRecord(this.SubRecords.ToArray());

                        if (sr.Parent is Record)
                        {
                            sr.Parent.UpdateShortDescription();
                        }

                        this.listSubrecord.Refresh();
                        this.FireSubrecordChanged(sr);
                        this.FireDataChanged();
                    }
                }
            }
            catch
            {
            }
        }

        internal SubRecord GetSelectedSubrecord()
        {
            int idx = this.listSubrecord.GetFocusedItem();
            if (this.listSubrecord.DataSource != null)
            {
                if (idx >= 0 && idx < this.listSubrecord.DataSource.Count)
                {
                    return this.listSubrecord.DataSource[idx] as SubRecord;
                }
            }

            return null;
        }

        internal List<SubRecord> GetSelectedSubrecords()
        {
            if (this.listSubrecord.SelectedIndices.Count < 1)
            {
                return null;
            }

            var recs = new List<SubRecord>();
            foreach (int idx in this.listSubrecord.SelectedIndices)
            {
                var sr = this.listSubrecord.DataSource[idx] as SubRecord;
                if (sr != null)
                {
                    recs.Add(sr);
                }
            }

            return recs;
        }

        protected void FireDataChanged()
        {
            if (this.DataChanged != null)
            {
                this.DataChanged(this, EventArgs.Empty);
            }
        }

        protected void FireSelectionChanged()
        {
            if (this.SelectionChanged != null)
            {
                this.SelectionChanged(this, EventArgs.Empty);
            }
        }

        private void CopySelectedSubRecord()
        {
            var sr = this.GetSelectedSubrecords();
            if (sr == null)
            {
                return;
            }

            MainView.Clipboard = sr.Select(ss => { return (SubRecord)ss.Clone(); }).ToArray();
            this.UpdateToolStripSelection();
        }

        private void FireSubrecordChanged(SubRecord sr)
        {
            if (this.OnSubrecordChanged != null)
            {
                this.OnSubrecordChanged(this, new RecordChangeEventArgs(sr));
            }
        }

        private string[] FormIDScan(string type)
        {
            var ret = new List<string>();
            if (this.Selection != null && this.Selection.Record != null)
            {
                var p = this.GetPluginFromNode(this.Selection.Record);
                if (p != null)
                {
                    foreach (var pair in p.EnumerateRecords(type))
                    {
                        ret.Add(pair.Value.DescriptiveName);
                        ret.Add(pair.Key.ToString("X8"));
                    }
                }
            }

            return ret.ToArray();
        }

        private Plugin GetPluginFromNode(BaseRecord node)
        {
            BaseRecord tn = node;
            var pluginFromNode = tn as Plugin;
            if (pluginFromNode != null)
            {
                return pluginFromNode;
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

        private void HandleSubrecordChanged()
        {
            var selection = this.GetSelectedSubrecord();
            if (selection != null)
            {
                if (selection.Equals(this.context.SubRecord))
                {
                    return;
                }
            }

            this.listSubrecord.ClearSelection();
            var list = this.listSubrecord.DataSource as IList<SubRecord>;
            if (list != null)
            {
                int idx = list.IndexOf(selection);
                if (idx >= 0)
                {
                    this.listSubrecord.SelectItem(idx);
                }
            }

            this.listSubrecord.Refresh();
        }

        private void InitializeSubrecordForm()
        {
            this.listSubrecord.Columns.Clear();
            this.listSubrecord.AddBindingColumn("Name", "Name", 50);
            this.listSubrecord.AddBindingColumn("Size", "Size", 40);
            this.listSubrecord.AddBindingColumn("IsValid", "*", 20, new Func<SubRecord, string>(a => a.IsValid ? "*" : string.Empty));
            this.listSubrecord.AddBindingColumn("Description", "Description", 100);
        }

        private void OnRecordChanged()
        {
            this.context.SubRecord = null;
            var r = this.context.Record as Record;
            this.subrecords = r != null ? r.SubRecords : null;
            this.listSubrecord.DataSource = this.subrecords;
            this.listSubrecord.Refresh();
        }

        private void PasteSubRecord()
        {
            if (!this.ValidateMakeChange())
            {
                return;
            }

            if (!MainView.HasClipboardData<SubRecord[]>())
            {
                return;
            }

            try
            {
                BaseRecord br = this.Selection.Record;

                int insertIdx = this.listSubrecord.SelectedIndices.Count == 0 ? -1 : this.listSubrecord.GetFocusedItem();
                var nodes = MainView.GetClipboardData<SubRecord[]>();
                foreach (var clipSr in insertIdx < 0 ? nodes : nodes.Reverse())
                {
                    // insert in revers
                    var sr = clipSr.Clone() as SubRecord;
                    if (sr == null)
                    {
                        return;
                    }

                    if (br is Record)
                    {
                        try
                        {
                            if (insertIdx >= 0 && insertIdx < this.listSubrecord.Items.Count)
                            {
                                br.InsertRecord(insertIdx, sr);
                            }
                            else
                            {
                                br.AddRecord(sr);
                            }
                        }
                        catch (TESParserException ex)
                        {
                            MessageBox.Show(ex.Message);
                        }
                    }
                }

                this.RebuildSelection();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), Resources.ErrorText, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void RebuildSelection()
        {
            if (this.Selection == null || this.Selection.Record == null)
            {
                return;
            }

            this.UpdateToolStripSelection();
            this.listSubrecord.Refresh();
        }

        private void SelectIndex(int idx)
        {
            this.listSubrecord.ClearSelection();
            this.listSubrecord.SelectItem(idx);
            this.listSubrecord.FocusItem(idx);
            this.listSubrecord.EnsureVisible(idx);
            this.listSubrecord.Refresh();
        }

        private void SubrecordListEditor_SizeChanged(object sender, EventArgs e)
        {
            int totalWidth = this.listSubrecord.Columns.OfType<OLVColumn>().Sum(column => column.Width);
            var descColumn = this.listSubrecord.Columns.OfType<OLVColumn>().LastOrDefault();
            if (descColumn != null)
            {
                totalWidth -= descColumn.Width;
                descColumn.Width = Width - totalWidth - SystemInformation.VerticalScrollBarWidth - SystemInformation.FrameBorderSize.Width;
            }
        }

        private void UpdateSubRecordSelection(ListViewVirtualItemsSelectionRangeChangedEventArgs e)
        {
            var n = this.listSubrecord.SelectedIndices.Count;
            var oldSel = this.Selection.SubRecord;
            var newSel = this.GetSelectedSubrecord();
            if (oldSel == newSel)
            {
                return;
            }

            // Update the current selection
            this.Selection.SubRecord = newSel;
            this.FireSelectionChanged();
            this.UpdateToolStripSelection();
        }

        private void UpdateToolStripSelection()
        {
            if (this.Selection.Record != null)
            {
                this.toolStripInsertRecord.Enabled = true;
                this.toolStripPasteSubrecord.Enabled = MainView.HasClipboardData<SubRecord[]>();
            }
            else
            {
                this.toolStripInsertRecord.Enabled = false;
                this.toolStripPasteSubrecord.Enabled = false;
            }

            if (this.Selection.SubRecord != null)
            {
                this.toolStripEditSubrecordHex.Enabled = true;
                this.toolStripEditSubrecord.Enabled = true;
                this.toolStripCopySubrecord.Enabled = true;
                this.toolStripMoveRecordDown.Enabled = true;
                this.toolStripMoveRecordUp.Enabled = true;
                this.toolStripDeleteRecord.Enabled = true;
            }
            else
            {
                this.toolStripEditSubrecordHex.Enabled = false;
                this.toolStripEditSubrecord.Enabled = false;
                this.toolStripCopySubrecord.Enabled = false;
                this.toolStripMoveRecordDown.Enabled = false;
                this.toolStripMoveRecordUp.Enabled = false;
                this.toolStripDeleteRecord.Enabled = false;
            }

            int idx = this.listSubrecord.GetFocusedItem();
            if (idx <= 0)
            {
                this.toolStripMoveRecordUp.Enabled = false;
            }

            if (this.listSubrecord.ItemCount != 0)
            {
                if (idx == this.listSubrecord.DataSource.Count - 1)
                {
                    this.toolStripMoveRecordDown.Enabled = false;
                }
            }
        }

        private bool ValidateMakeChange()
        {
            return true;
        }

        private void context_RecordChanged(object sender, EventArgs e)
        {
            this.OnRecordChanged();
        }

        private void context_SubRecordChanged(object sender, EventArgs e)
        {
            this.HandleSubrecordChanged();
        }

        private void listSubrecord_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.C && e.Control && !e.Alt && !e.Shift)
            {
                this.CopySelectedSubRecord();
                e.Handled = true;
            }
            else if (e.KeyCode == Keys.V && e.Control && !e.Alt && !e.Shift)
            {
                this.PasteSubRecord();
                e.Handled = true;
            }
            else if (e.KeyCode == Keys.Delete && !e.Control && !e.Alt && !e.Shift)
            {
                this.DeleteSelection();
            }
        }

        private void listSubrecord_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            this.EditSelectedSubrecord();
        }

        private void listSubrecord_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.UpdateSubRecordSelection(null);
        }

        private void listView1_DragDrop(object sender, DragEventArgs e)
        {
            int toswap = (int)e.Data.GetData(typeof(int)) - 1;
            if (toswap == -1)
            {
                return;
            }

            var rec = this.Selection.Record as Record;
            SubRecord sr = this.subrecords[toswap];
            if (this.listSubrecord.SelectedIndices.Count == 0)
            {
                this.subrecords.RemoveAt(toswap);
                this.subrecords.Add(sr);
            }
            else if (this.listSubrecord.SelectedIndices.Count >= 1)
            {
                int moveto = this.listSubrecord.SelectedIndices[0];
                if (toswap == moveto)
                {
                    return;
                }

                this.subrecords.RemoveAt(toswap);
                this.subrecords.Insert(moveto, sr);
            }
            else
            {
                return;
            }

            this.RebuildSelection();
            return;
        }

        private void listView1_DragEnter(object sender, DragEventArgs e)
        {
            if (!this.DragDropInProgress)
            {
                return;
            }

            e.Effect = DragDropEffects.Move;
            this.DragDropInProgress = false;
        }

        private void listView1_GiveFeedback(object sender, GiveFeedbackEventArgs e)
        {
            Point p = this.listSubrecord.PointToClient(MousePosition);
            ListViewItem lvi = this.listSubrecord.GetItemAt(p.X, p.Y);
            if (lvi == null)
            {
                this.listSubrecord.SelectedIndices.Clear();
            }
            else
            {
                lvi.Selected = true;
            }
        }

        private void listView1_ItemActivate(object sender, EventArgs e)
        {
            this.UpdateSubRecordSelection(null);

            // EditSelectedSubrecord();
        }

        private void listView1_ItemDrag(object sender, ItemDragEventArgs e)
        {
            if (this.listSubrecord.SelectedIndices.Count < 1 || e.Button != MouseButtons.Left)
            {
                return;
            }

            this.DragDropInProgress = true;
            this.listSubrecord.DoDragDrop(this.listSubrecord.SelectedIndices[0] + 1, DragDropEffects.Move);
        }

        private void toolStripCopySubrecord_Click(object sender, EventArgs e)
        {
            this.CopySelectedSubRecord();
        }

        private void toolStripDeleteRecord_Click(object sender, EventArgs e)
        {
            if (!this.ValidateMakeChange())
            {
                return;
            }

            this.DeleteSelection();

            /*
            var rec = Selection.Record as Record;
            if (rec != null)
            {
                if (listSubrecord.SelectedIndices.Count < 1) return;
                subrecords.RemoveAt(listSubrecord.SelectedIndices[0]);
                rec.MatchRecordStructureToRecord(SubRecords.ToArray());
            }
            Selection.SubRecord = GetSelectedSubrecord();
            FireDataChanged();
 */
        }

        private void toolStripEditSubrecordHex_Click(object sender, EventArgs e)
        {
            this.EditSelectedSubrecordHex();
        }

        private void toolStripEditSubrecord_Click(object sender, EventArgs e)
        {
            this.EditSelectedSubrecord();
        }

        private void toolStripInsertRecord_Click(object sender, EventArgs e)
        {
            if (!this.ValidateMakeChange())
            {
                return;
            }

            var tsMenuItem = sender as ToolStripMenuItem;
            try
            {
                var br = this.Selection.Record;
                var srs = tsMenuItem != null ? tsMenuItem.Tag as SubrecordStructure : null;
                if (br is Record)
                {
                    if (this.listSubrecord.SelectedIndices.Count == 1)
                    {
                        int idx = this.listSubrecord.SelectedIndices[0];
                        if (idx < 0 || idx >= (this.listSubrecord.Items.Count - 1))
                        {
                            var p = new SubRecord(srs);
                            br.AddRecord(p);
                        }
                        else
                        {
                            var r = (Record)br;
                            var p = new SubRecord(srs);
                            r.InsertRecord(idx, p);
                        }
                    }
                    else
                    {
                        var p = new SubRecord(srs);
                        br.AddRecord(p);
                    }
                }

                this.FireDataChanged();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripInsertRecord_DropDownClosed(object sender, EventArgs e)
        {
            this.toolStripInsertRecord.DropDownItems.Clear();
        }

        private void toolStripInsertRecord_DropDownOpening(object sender, EventArgs e)
        {
            // find current subrecord and guess likely candidates
            // this could be much smarter
            try
            {
                this.toolStripInsertRecord.DropDownItems.Clear();

                var br = this.Selection.Record as Record;
                var sr = this.Selection.SubRecord;
                if (br != null)
                {
                    RecordStructure rs;
                    if (RecordStructure.Records.TryGetValue(br.Name, out rs))
                    {
                        var usedNames = new StringDictionary();
                        var delayedAddItems = new List<ToolStripMenuItem>();
                        var srs = (sr != null) ? sr.Structure : null;
                        bool found = srs == null;

                        int idx = this.listSubrecord.GetFocusedItem();
                        if (idx < 0)
                        {
                            var indicies = this.listSubrecord.GetSelectionIndices();
                            idx = indicies != null && indicies.Length > 0 ? indicies[0] : -1;
                        }

                        foreach (var s in rs.subrecords)
                        {
                            if (!found && sr.Structure.Equals(s))
                            {
                                found = true;
                            }

                            if (usedNames.ContainsKey(s.name))
                            {
                                continue;
                            }

                            usedNames.Add(s.name, s.name);
                            var callback = new CallbackAction<SubrecordStructure>(
                                s, 
                                subItem => {
                                    var srnew = new SubRecord(subItem);
                                    if (idx == -1)
                                    {
                                        br.AddRecord(srnew);
                                        idx = br.SubRecords.Count - 1;
                                    }
                                    else
                                    {
                                        br.InsertRecord(idx + 1, srnew);
                                        idx = idx + 1;
                                    }

                                    br.MatchRecordStructureToRecord(this.SubRecords.ToArray());
                                    this.FireDataChanged();
                                    this.SelectIndex(idx);
                                });
                            var item = new ToolStripMenuItem(s.name, null, callback.ExecuteEvent);
                            item.Tag = s;
                            if (found)
                            {
                                this.toolStripInsertRecord.DropDownItems.Add(item);
                            }
                            else
                            {
                                delayedAddItems.Add(item);
                            }
                        }

                        if (delayedAddItems.Count > 0)
                        {
                            if (this.toolStripInsertRecord.DropDownItems.Count > 0)
                            {
                                this.toolStripInsertRecord.DropDownItems.Add("-");
                            }

                            this.toolStripInsertRecord.DropDownItems.AddRange(delayedAddItems.ToArray());
                        }
                    }
                }
                else
                {
                    this.toolStripInsertRecord.DropDownItems.Add("NEW_");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripMoveRecordDown_Click(object sender, EventArgs e)
        {
            if (this.listSubrecord.SelectedIndices.Count < 1)
            {
                return;
            }

            int idx = this.listSubrecord.SelectedIndices[0];
            if (idx < 0 || idx >= (this.listSubrecord.Items.Count - 1))
            {
                return;
            }

            var rec = this.Selection.Record as Record;
            SubRecord sr = this.subrecords[idx];
            this.subrecords.RemoveAt(idx);
            this.subrecords.Insert(idx + 1, sr);
            this.SelectIndex(idx + 1);
            this.Selection.SubRecord = this.GetSelectedSubrecord();
            rec.MatchRecordStructureToRecord(this.SubRecords.ToArray());
            this.FireDataChanged();
        }

        private void toolStripMoveRecordUp_Click(object sender, EventArgs e)
        {
            if (this.listSubrecord.SelectedIndices.Count < 1)
            {
                return;
            }

            int idx = this.listSubrecord.SelectedIndices[0];
            if (idx < 1 || idx >= this.listSubrecord.Items.Count)
            {
                return;
            }

            var rec = this.Selection.Record as Record;
            if (rec != null)
            {
                SubRecord sr = this.subrecords[idx];
                this.SelectIndex(idx - 1);
                this.subrecords.RemoveAt(idx);
                this.subrecords.Insert(idx - 1, sr);

                this.Selection.SubRecord = this.GetSelectedSubrecord();
                rec.MatchRecordStructureToRecord(this.SubRecords.ToArray());
                this.FireDataChanged();
            }
        }

        private void toolStripPasteSubrecord_Click(object sender, EventArgs e)
        {
            this.PasteSubRecord();
        }

        private class CallbackAction<T>
        {
            private readonly Action<T> callback;

            private readonly T item;

            public CallbackAction(T item, Action<T> callback)
            {
                this.item = item;
                this.callback = callback;
            }

            public void Execute()
            {
                this.callback(this.item);
            }

            public void ExecuteEvent(object sender, EventArgs e)
            {
                this.Execute();
            }
        }
    }
}
