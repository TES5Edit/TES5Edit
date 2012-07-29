using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using BrightIdeasSoftware;
using OC.Windows.Forms;
using TESVSnip.Docking;
using TESVSnip.Forms;
using TESVSnip.Properties;
using WeifenLuo.WinFormsUI.Docking;

namespace TESVSnip.ObjectControls
{
    public partial class PluginTreeView : UserControl, ISupportInitialize
    {
        private History<BaseRecord> _historyHandler;
        private OLVColumn _olvColumnName;

        public event EventHandler OnSelectionUpdated;

        public PluginTreeView()
        {
            InitializeComponent();
        }

        public void BeginInit()
        {
        }

        public void EndInit()
        {
            if (DesignMode) return;
            InitializeToolStripRecords();
            InitializeTreeList();
            UpdateToolStripSelection();

            PluginTree.OnContextMenuKey += PluginTree_OnContextMenuKey;

            Disposed += PluginTreeView_Disposed;
            MainView.ClipboardChanged += MainView_ClipboardChanged;

            BaseRecord.RecordDescChanged += BaseRecord_RecordDescChanged;
            BaseRecord.ChildListChanged += BaseRecord_ChildListChanged;
            BaseRecord.RecordDeleted += BaseRecord_RecordDeleted;
        }

        public BaseRecord TopRecord
        {
            get { return PluginList.All.Records.OfType<BaseRecord>().FirstOrDefault(); }
        }

        public BaseRecord SelectedRecord
        {
            get { return PluginTree.SelectedRecord; }
            set { PluginTree.SelectedRecord = value; }
        }
        public IEnumerable<BaseRecord> SelectedRecords
        {
            get { return PluginTree.SelectedRecords; }
            set { PluginTree.SelectedRecords = value; }            
        }

        public event EventHandler SelectionChanged;

        private void InitializeTreeList()
        {
            PluginTree.MultiSelect = true;
            PluginTree.CanExpandGetter = x => (x is IGroupRecord);
            PluginTree.ChildrenGetter = x =>
                                            {
                                                var r = x as IGroupRecord;
                                                return (r != null) ? r.Records : null;
                                            };

            _olvColumnName = new OLVColumn("Name", "Name");
            PluginTree.Columns.Add(_olvColumnName);

            _olvColumnName.AspectGetter = x =>
                                              {
                                                  var r = x as IRecord;
                                                  return (r != null) ? r.DescriptiveName : x;
                                              };
            var sink1 = (SimpleDropSink) PluginTree.DropSink;
            sink1.AcceptExternal = false;
            sink1.CanDropBetween = true;
            sink1.CanDropOnBackground = false;
            sink1.CanDropOnSubItem = false;

            UpdateRoots();
        }

        public void UpdateRoots()
        {
            PluginTree.Roots = PluginList.All.Records;
        }

        public void SetSelectedRecords(IEnumerable<BaseRecord> records)
        {
            this.PluginTree.SelectedRecords = records;
        }

        private void FireSelectionUpdated()
        {
            if (OnSelectionUpdated != null)
                OnSelectionUpdated(this, EventArgs.Empty);
        }

        private void PluginTree_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            EditSelectedHeader();
        }

        public void EditSelectedHeader()
        {
            if (PluginTree.SelectedRecord == null) return;
            if (PluginTree.SelectedRecord is Record)
            {
                var r = (Record) PluginTree.SelectedRecord;
                if (DialogResult.OK == HeaderEditor.Display(r))
                {
                    GetPluginFromNode(PluginTree.SelectedRecord).InvalidateCache();
                    FireSelectionUpdated();
                }
            }
            else if (PluginTree.SelectedRecord is GroupRecord)
            {
                var gr = (GroupRecord) PluginTree.SelectedRecord;
                if (DialogResult.OK == GroupEditor.Display(gr))
                {
                    GetPluginFromNode(PluginTree.SelectedRecord).InvalidateCache();
                    FireSelectionUpdated();
                }
            }
        }


        private void PluginTree_Enter(object sender, EventArgs e)
        {
            //PluginTree_AfterSelect(sender, null);
        }

        private void PluginTree_OnContextMenuKey(object sender, EventArgs e)
        {
            contextMenuRecord.Show(PluginTree.PointToScreen(new Point(PluginTree.Width/4, PluginTree.Height/4)));
        }

        private void RebuildSelection()
        {
        }

        private void toolStripRecordCopy_Click(object sender, EventArgs e)
        {
            CopySelectedRecord();
        }

        private void toolStripRecordPaste_Click(object sender, EventArgs e)
        {
            PasteFromClipboard(true);
        }

        internal void CopySelectedRecord()
        {
            IEnumerable<BaseRecord> records = PluginTree.SelectedRecords;
            if (records.Count() == 1)
            {
                MainView.Clipboard = PluginTree.SelectedRecord.Clone();
            }
            else
            {
                int parents = records.Select(x => x.Parent).Distinct().Count();
                if (parents > 1)
                {
                    MainView.PostStatusWarning(Resources.CannotCopyNodesFromDifferentParents);
                }
                else
                {
                    MainView.Clipboard = records.ToArray();
                }
            }
        }

        internal void PasteFromClipboard(bool recordOnly)
        {
            if (!MainView.HasClipboardData())
            {
                MainView.PostStatusWarning(Resources.TheClipboardIsEmpty);
                return;
            }
            var clipboardObject = MainView.Clipboard;

            bool isRec = clipboardObject is Record || clipboardObject is GroupRecord;
            bool isRecList = clipboardObject is BaseRecord[];


            if (recordOnly && !(isRec || isRecList))
                return;
            if (isRec)
            {
                BaseRecord node = PluginTree.SelectedRecord;
                try
                {
                    var dstNode = PluginTree.SelectedRecord;
                    var br = ((BaseRecord) clipboardObject).Clone();
                    node.AddRecord(br);
                    RebuildSelection();
                }
                catch (TESParserException ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else if (isRecList)
            {
                var gr = PluginTree.SelectedRecord as IGroupRecord;
                if (gr != null)
                {
                    foreach (var rec in (BaseRecord[]) clipboardObject)
                        gr.AddRecord(rec);
                    RefreshObject(gr as BaseRecord);
                }
            }
        }

        private void UpdateToolStripSelection()
        {
            var rec = PluginTree.SelectedRecord;
            var recs = PluginTree.SelectedRecords;
            bool oneSel = (recs.Count() == 1);
            bool isRecord = rec is Record;
            bool isGroup = rec is GroupRecord;
            bool isPlugin = rec is Plugin;

            toolStripRecordCopy.Enabled = isRecord || isGroup;
            toolStripRecordPaste.Enabled = oneSel && (isPlugin || isGroup) && MainView.HasClipboardData();
        }

        #region ToolStrip Record Handlers

        private void InitializeToolStripRecords()
        {
            _historyHandler = new History<BaseRecord>(
                toolStripRecordBack, toolStripRecordNext
                , Properties.Settings.Default.MaxHistoryItem);
            _historyHandler.AllowDuplicates = true;
            _historyHandler.GotoItem += historyHandler_GotoItem;
        }

        private void PluginTreeView_Disposed(object sender, EventArgs e)
        {
            MainView.ClipboardChanged -= MainView_ClipboardChanged;
            BaseRecord.RecordDescChanged -= BaseRecord_RecordDescChanged;
            BaseRecord.ChildListChanged -= BaseRecord_ChildListChanged;
        }

        private void MainView_ClipboardChanged(object sender, EventArgs e)
        {
            UpdateToolStripSelection();
        }

        private void historyHandler_GotoItem(object sender, HistoryEventArgs<BaseRecord> e)
        {
            PluginTree.SelectedRecord = e.Item;
        }

        #endregion

        private Plugin GetPluginFromNode(BaseRecord node)
        {
            var tn = node;
            var pluginFromNode = tn as Plugin;
            if (pluginFromNode != null) return pluginFromNode;
            while (!(tn is Plugin) && tn != null) tn = tn.Parent;
            if (tn != null) return tn as Plugin;
            return null;
        }

        private void CopySelectedTreeNode()
        {
            if (PluginTree.SelectedRecord is Plugin)
                MainView.PostStatusWarning(Resources.CannotCopyPlugin);
            else
                CopySelectedRecord();
        }

        #region Context Menu Record Handling

        private void contextMenuRecord_Opening(object sender, CancelEventArgs e)
        {
            var records = PluginTree.SelectedRecords;
            int nrecords = records.Count();
            if (nrecords == 0)
            {
                e.Cancel = true;
                return;
            }

            int nparents = records.Select(x => x.Parent).Distinct().Count();
            bool anyPlugins = records.Any(x => x is Plugin);
            if (nparents > 1)
            {
                contextMenuRecordEdit.Visible = false;
                contextMenuRecordCopy.Enabled = false;
                contextMenuRecordCopy.ToolTipText = Resources.CannotCopyNodesFromDifferentParents;
                contextMenuRecordCopyTo.Enabled = false;
                contextMenuRecordCopyTo.ToolTipText = Resources.CannotCopyNodesFromDifferentParents;
            }
            else if (anyPlugins)
            {
                contextMenuRecordEdit.Visible = false;
                contextMenuRecordCopy.Enabled = false;
                contextMenuRecordCopy.ToolTipText = Resources.CannotCopyPlugin;
                contextMenuRecordCopyTo.Enabled = false;
                contextMenuRecordCopyTo.ToolTipText = Resources.CannotCopyPlugin;
            }
            else
            {
                contextMenuRecordEdit.Visible = (nrecords == 1);
                contextMenuRecordCopy.Enabled = true;
                contextMenuRecordCopy.ToolTipText = Resources.Copy_Record_to_Clipboard;
                contextMenuRecordCopyTo.Enabled = (PluginTree.SelectedObjects.Count > 0);
                contextMenuRecordCopyTo.ToolTipText = null;
            }
            contextMenuRecordAddMaster.Visible = false;
            contextMenuRecordCopyTo.DropDownItems.Clear();

            if (nparents != 1) return;

            var srcRecord = records.First();
            var srcPlugin = GetPluginFromNode(srcRecord);
            if (contextMenuRecordCopyTo.Enabled)
            {
                foreach (Plugin plugin in PluginList.All.Records)
                {
                    if (plugin == null) continue;
                    if (srcPlugin.Equals(plugin)) continue;

                    var tsi = new ToolStripButton(plugin.Name);
                    tsi.Tag = new object[] {records.ToArray(), plugin};
                    var sz = TextRenderer.MeasureText(plugin.Name, contextMenuRecordCopyTo.Font);
                    if (sz.Width > tsi.Width)
                        tsi.Width = sz.Width;
                    tsi.AutoSize = true;
                    contextMenuRecordCopyTo.DropDownItems.Add(tsi);
                }
            }
            // only allow master selectio when single plugin is selected
            if (nrecords == 1 && srcRecord is Plugin)
            {
                string[] masters = srcPlugin.GetMasters();
                Array.Sort(masters, StringComparer.InvariantCultureIgnoreCase);

                foreach (
                    var item in
                        contextMenuRecordAddMaster.DropDownItems.OfType<ToolStripButton>().Where(
                            x => !x.Equals(browseToolStripMenuItem)).ToArray())
                    contextMenuRecordAddMaster.DropDownItems.Remove(item);

                foreach (Plugin plugin in PluginList.All.Records)
                {
                    if (plugin == null) continue;
                    if (srcPlugin.Equals(plugin)) continue; // ignore self
                    if (Array.BinarySearch(masters, plugin.Name, StringComparer.InvariantCultureIgnoreCase) >= 0)
                        // ignore masters
                        continue;

                    var tsi = new ToolStripButton(plugin.Name);
                    tsi.Tag = new object[] { srcRecord, plugin };
                    var sz = TextRenderer.MeasureText(plugin.Name, contextMenuRecordCopyTo.Font);
                    if (sz.Width > tsi.Width)
                        tsi.Width = sz.Width;
                    tsi.AutoSize = true;
                    contextMenuRecordAddMaster.DropDownItems.Add(tsi);
                }
                contextMenuRecordAddMaster.Visible = true;
            }
        }

        private void contextMenuRecordCopyTo_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            try
            {
                var nodes = e.ClickedItem.Tag as object[];
                if (nodes != null)
                {
                    var src = nodes[0] as BaseRecord[];
                    var dst = nodes[1] as IGroupRecord;
                    Spells.CopyRecordsTo(src, dst);
                }
            }
            catch
            {
            }
        }

        

        private void contextMenuRecordAddMaster_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            if (e.ClickedItem.Tag == null)
                return;

            try
            {
                var nodes = e.ClickedItem.Tag as object[];
                var src = nodes[0] as Plugin;
                var dst = nodes[1] as Plugin;
                if (src != null && dst != null)
                {
                    if (src.AddMaster(dst.Name))
                        PluginList.FixMasters();
                }
            }
            catch
            {
            }
        }

        private void contextMenuRecordDelete_Click(object sender, EventArgs e)
        {
            DeleteSelection();
        }

        public void DeleteSelection()
        {
            if (DialogResult.Yes !=
                MessageBox.Show(Resources.AreYouSureInquiry, Resources.DeleteNode, MessageBoxButtons.YesNo,
                                MessageBoxIcon.Question, MessageBoxDefaultButton.Button1))
                return;

            foreach (var node in PluginTree.SelectedRecords)
            {
                GetPluginFromNode(node).InvalidateCache();
                if (node.Parent != null)
                {
                    var parent = node.Parent;
                    parent.DeleteRecord(node);
                }
            }
        }

        private void contexMenuRecordCopy_Click(object sender, EventArgs e)
        {
            CopySelectedTreeNode();
        }

        private void contextMenuRecord_Closing(object sender, ToolStripDropDownClosingEventArgs e)
        {
            contextMenuRecordCopyTo.DropDownItems.Clear();
            foreach (var item in contextMenuRecordAddMaster.DropDownItems.OfType<ToolStripButton>()
                .Where(x => !x.Equals(browseToolStripMenuItem)).ToArray())
                contextMenuRecordAddMaster.DropDownItems.Remove(item);
        }

        private void addMasterToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (var amfNewMaster = new AddMasterForm())
            {
                if (amfNewMaster.ShowDialog(this) == DialogResult.OK)
                {
                    Plugin plugin = GetPluginFromNode(PluginTree.SelectedRecord);
                    if (plugin == null)
                    {
                        MainView.PostStatusWarning(Resources.NoPluginSelectedCannotContinue);
                        return;
                    }
                    try
                    {
                        if (plugin.AddMaster(amfNewMaster.MasterName))
                        {
                            PluginList.FixMasters();
                            RebuildSelection();
                        }
                    }
                    catch (ApplicationException ex)
                    {
                        MessageBox.Show(this, ex.Message, Resources.Missing_Record, MessageBoxButtons.OK,
                                        MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void expandAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PluginTree.ExpandAll();
        }

        private void collapseAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PluginTree.CollapseAll();
        }

        private void expandBranchToolStripMenuItem_Click(object sender, EventArgs e)
        {
            foreach (var o in PluginTree.SelectedObjects) ExpandAll(o);
        }

        private void collapseBranchToolStripMenuItem_Click(object sender, EventArgs e)
        {
            foreach (var o in PluginTree.SelectedObjects) CollapseAll(o);
        }

        #endregion

        private void PluginTree_SizeChanged(object sender, EventArgs e)
        {
            try
            {
                if (_olvColumnName != null)
                    _olvColumnName.Width = Width - SystemInformation.VerticalScrollBarWidth -
                                           SystemInformation.FrameBorderSize.Width;
            }
            catch
            {
            }
        }

        private void PluginTree_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (PluginTree.SelectedRecord != null)
            {
                if (_historyHandler.CurrentItem == null && !PluginTree.SelectedRecord.Equals(_historyHandler.CurrentItem))
                {
                    _historyHandler.CurrentItem = PluginTree.SelectedRecord;
                }
            }
            RebuildSelection();
        }

        private void PluginTree_ModelCanDrop(object sender, ModelDropEventArgs e)
        {
            e.Effect = DragDropEffects.None;
            if (e.DropTargetLocation == DropTargetLocation.Background)
                return;
            if (e.SourceModels.OfType<Plugin>().Any())
            {
                e.InfoMessage = "Cannot drag plugins";
                return;
            }
            if (e.TargetModel != null)
            {
                var rec = e.TargetModel as BaseRecord;
                var targetPlugin = GetPluginFromNode(rec);
                var targetParent = rec.Parent;
                if (e.SourceModels.Contains(e.TargetModel))
                {
                    //e.InfoMessage = "Cannot drop on self";
                }
                else
                {
                    var parents = e.SourceModels.OfType<BaseRecord>().Select(x => x.Parent).Distinct();
                    if (parents.Count() != 1)
                    {
                        e.InfoMessage = Resources.CannotDragNodesWithDifferentParents;
                        return;
                    }
                    var srcParent = parents.FirstOrDefault();
                    if (e.DropTargetLocation == DropTargetLocation.Item && srcParent.Equals(targetParent))
                        return;
                    Plugin srcPlugin = GetPluginFromNode(srcParent);
                    foreach (BaseRecord r in e.SourceModels)
                    {
                        foreach (var r2 in r.Enumerate(x => x is IGroupRecord || x.Equals(rec)))
                        {
                            if (r2.Equals(rec))
                            {
                                e.InfoMessage = Resources.CannotDropOnDescendent;
                                return;
                            }
                        }
                    }
                    if (e.DropTargetLocation == DropTargetLocation.Item && !(e.TargetModel is IGroupRecord))
                    {
                        //e.InfoMessage = "Can only drop on groups or plugins";
                    }
                    else
                    {
                        if (srcPlugin.Equals(targetPlugin))
                        {
                            // same plugin defaults to move unless ctrl down
                            e.Effect = (e.DropSink.IsControlDown) ? DragDropEffects.Copy : DragDropEffects.Move;
                        }
                        else
                        {
                            // same plugin defaults to copy unless shift down
                            e.Effect = (!e.DropSink.IsControlDown && e.DropSink.IsShiftDown)
                                           ? DragDropEffects.Move
                                           : DragDropEffects.Copy;
                        }
                    }
                }
            }
        }

        private void PluginTree_ModelDropped(object sender, ModelDropEventArgs e)
        {
            if (e.DropTargetLocation == DropTargetLocation.Item)
            {
                var group = e.TargetModel as IGroupRecord;
                if (group == null) return;
                var objects = new List<BaseRecord>();
                foreach (IRecord record in e.SourceModels)
                {
                    if (e.Effect == DragDropEffects.Copy)
                    {
                        var r = record.Clone() as BaseRecord;
                        group.AddRecord(r);
                        objects.Add(r);
                    }
                    else if (e.Effect == DragDropEffects.Move)
                    {
                        var r = record as BaseRecord;
                        if (r != null && r.Parent.DeleteRecord(r))
                        {
                            group.AddRecord(r);
                            objects.Add(r);
                        }
                    }
                }
                e.RefreshObjects();
                PluginTree.SelectObject(objects);
                PluginTree.RefreshObject(group);
                PluginTree.RefreshObjects(objects);
            }
            else if (e.DropTargetLocation == DropTargetLocation.AboveItem ||
                     e.DropTargetLocation == DropTargetLocation.BelowItem)
            {
                int offset = e.DropTargetLocation == DropTargetLocation.BelowItem ? +1 : 0;
                var rec = (e.TargetModel as IRecord);
                if (rec == null) return;
                var group = rec.Parent as IGroupRecord;
                if (group == null) return;
                int idx = group.IndexOf(rec as BaseRecord) + offset;
                var refreshObjects = new List<BaseRecord>();
                var selObjects = new List<BaseRecord>();
                IEnumerable<IRecord> itr = e.SourceModels.OfType<IRecord>();
                if (e.DropTargetLocation == DropTargetLocation.BelowItem)
                    itr = itr.Reverse();
                foreach (IRecord record in itr)
                {
                    if (e.Effect == DragDropEffects.Copy)
                    {
                        var r = record.Clone() as BaseRecord;
                        group.InsertRecord(idx, r);
                        selObjects.Add(r);
                    }
                    else if (e.Effect == DragDropEffects.Move)
                    {
                        var r = record as BaseRecord;
                        var p = r.Parent;
                        if (r.Parent.DeleteRecord(r))
                        {
                            idx = group.IndexOf(rec as BaseRecord) + offset;
                            group.InsertRecord(idx, r);
                            selObjects.Add(r);
                        }
                    }
                }
                e.RefreshObjects();
                PluginTree.SelectObject(selObjects);
                PluginTree.RefreshObject(group);
                PluginTree.RefreshObjects(selObjects);
            }
        }

        private void PluginTree_SelectionChanged(object sender, EventArgs e)
        {
            if (_historyHandler.CurrentItem != PluginTree.SelectedRecord)
                _historyHandler.CurrentItem = PluginTree.SelectedRecord;

            foreach (var sel in PluginTree.SelectedRecords.OfType<Record>())
            {
                sel.MatchRecordStructureToRecord();
                sel.UpdateShortDescription();
            }

            UpdateToolStripSelection();
            if (SelectionChanged != null)
                SelectionChanged(this, EventArgs.Empty);
        }

        public void RebuildObjects()
        {
            PluginTree.RebuildAll(true);
        }

        public void RefreshObject(BaseRecord record)
        {
            PluginTree.RefreshObject(record);
        }

        public void RefreshObject(IList records)
        {
            PluginTree.RefreshObjects(records);
        }


        private void BaseRecord_RecordDescChanged(object sender, RecordChangeEventArgs e)
        {
            PluginTree.RefreshObject(e.Record);
        }

        private void BaseRecord_ChildListChanged(object sender, RecordChangeEventArgs e)
        {
            if (e.Record == null || e.Record == PluginList.All) // use null record as hint to reset the roots
            {
                UpdateRoots();
                //PluginTree.RebuildAll(true);
                GC.Collect(); // clean up memory after releasing plugins
            }
            else
            {
                PluginTree.RefreshObject(e.Record);
            }
        }

        private void BaseRecord_RecordDeleted(object sender, RecordChangeEventArgs e)
        {
            _historyHandler.Remove(e.Record);
        }

        public void CollapseAll()
        {
            PluginTree.CollapseAll();
        }

        public void ExpandAll()
        {
            PluginTree.ExpandAll();
        }

        public void CollapseAll(object item)
        {
            PluginTree.BeginUpdate();
            try
            {
                InternalCollapse(item);
            }
            finally
            {
                PluginTree.EndUpdate();
            }
        }

        private void InternalCollapse(object item)
        {
            foreach (var child in PluginTree.GetChildren(item))
                InternalCollapse(child);
            PluginTree.Collapse(item);
        }

        public void ExpandAll(object item)
        {
            PluginTree.BeginUpdate();
            try
            {
                InternalExpand(item);
            }
            finally
            {
                PluginTree.EndUpdate();
            }
        }

        private void InternalExpand(object item)
        {
            PluginTree.Expand(item);
            foreach (var child in PluginTree.GetChildren(item))
                InternalExpand(child);
        }

        private void editToolStripMenuItem_Click(object sender, EventArgs e)
        {
            EditSelectedRecord();
        }

        public void EditSelectedRecord()
        {
            var selRecord = PluginTree.SelectedRecord;
            if (selRecord is GroupRecord)
            {
                var gr = selRecord as GroupRecord;
                if (DialogResult.OK == GroupEditor.Display(gr))
                {
                    GetPluginFromNode(PluginTree.SelectedRecord).InvalidateCache();
                    FireSelectionUpdated();
                }
            }
            else if (selRecord is Record)
            {
                
                var r = selRecord as Record;
                var form = new FullRecordEditor(r);
                form.StartPosition = FormStartPosition.CenterScreen;

                var dockParent = FindDockContent(this);
                if (dockParent != null)
                {
                    var sz = form.Size;
                    form.Show(dockParent.DockHandler.DockPanel, DockState.Float);
                    form.Pane.FloatWindow.Size = sz;
                }
                else
                    form.Show(this);
            }
        }

        IDockContent FindDockContent(Control c)
        {
            if (c is IDockContent)
                return c as IDockContent;
            else if (c.Parent != null)
                return FindDockContent(c.Parent);
            return null;
        }

        private void PluginTree_KeyDown(object sender, KeyEventArgs e)
        {
            if (!e.Control && !e.Alt && !e.Shift)
            {
                switch (e.KeyCode)
                {
                    case Keys.Delete:
                        DeleteSelection();
                        break;
                    case Keys.Divide:
                        CollapseAll();
                        break;
                    case Keys.Multiply:
                        ExpandAll();
                        break;
                    case Keys.Add:
                        foreach ( var item in PluginTree.SelectedRecords )
                            this.PluginTree.Expand(item);
                        break;
                    case Keys.Subtract:
                        foreach (var item in PluginTree.SelectedRecords)
                            this.PluginTree.Collapse(item);
                        break;
                }                
            }
            else if (e.Shift && !e.Control && !e.Alt)
            {
                switch (e.KeyCode)
                {
                    case Keys.Divide:
                        foreach (var item in PluginTree.SelectedRecords)
                            CollapseAll(item);
                        break;
                    case Keys.Multiply:
                        foreach (var item in PluginTree.SelectedRecords)
                            ExpandAll(item);
                        break;
                    case Keys.Add:
                        foreach (var item in PluginTree.SelectedRecords)
                            this.PluginTree.Expand(item);
                        break;
                    case Keys.Subtract:
                        foreach (var item in PluginTree.SelectedRecords)
                            this.PluginTree.Collapse(item);
                        break;
                }
            }
        }

        private void reportToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var selRecord = PluginTree.SelectedRecord;

            var r = selRecord as Record;
            var form = new RichTextContent();
            form.UpdateRecord(selRecord);
            form.StartPosition = FormStartPosition.CenterScreen;

            var dockParent = FindDockContent(this);
            if (dockParent != null)
            {
                var sz = form.Size;
                form.Show(dockParent.DockHandler.DockPanel, DockState.Float);
                form.Pane.FloatWindow.Size = sz;
            }
            else
            {
                form.Show(this);
            }

        }

        private void referenceSearchToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var rec = this.PluginTree.SelectedRecords.OfType<Record>().FirstOrDefault();
            if (rec != null)
            {
                MainView.PostReferenceSearch(rec.FormID);
            }
        }
    }
}