namespace TESVSnip.UI.ObjectControls
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Drawing;
    using System.Linq;
    using System.Windows.Forms;

    using BrightIdeasSoftware;

    using OC.Windows.Forms;

    using TESVSnip.Domain.Model;
    using TESVSnip.Properties;
    using TESVSnip.UI.Docking;
    using TESVSnip.UI.Forms;

    using WeifenLuo.WinFormsUI.Docking;

    using Settings = TESVSnip.Properties.Settings;

    public partial class PluginTreeView : UserControl, ISupportInitialize
    {
        private History<BaseRecord> _historyHandler;

        private OLVColumn _olvColumnName;

        public PluginTreeView()
        {
            this.InitializeComponent();
        }

        public event EventHandler OnSelectionUpdated;

        public event EventHandler SelectionChanged;

        public BaseRecord SelectedRecord
        {
            get
            {
                return this.PluginTree.SelectedRecord;
            }

            set
            {
                this.PluginTree.SelectedRecord = value;
            }
        }

        public IEnumerable<BaseRecord> SelectedRecords
        {
            get
            {
                return this.PluginTree.SelectedRecords;
            }

            set
            {
                this.PluginTree.SelectedRecords = value;
            }
        }

        public BaseRecord TopRecord
        {
            get
            {
                return PluginList.All.Records.OfType<BaseRecord>().FirstOrDefault();
            }
        }

        public void BeginInit()
        {
        }

        public void CollapseAll()
        {
            this.PluginTree.CollapseAll();
        }

        public void CollapseAll(object item)
        {
            this.PluginTree.BeginUpdate();
            try
            {
                this.InternalCollapse(item);
            }
            finally
            {
                this.PluginTree.EndUpdate();
            }
        }

        public void DeleteSelection()
        {
            if (DialogResult.Yes != MessageBox.Show(Resources.AreYouSureInquiry, Resources.DeleteNode, MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1))
            {
                return;
            }

            foreach (var node in this.PluginTree.SelectedRecords)
            {
                this.GetPluginFromNode(node).InvalidateCache();
                if (node.Parent != null)
                {
                    var parent = node.Parent;
                    parent.DeleteRecord(node);
                }
            }
        }

        public void EditSelectedHeader()
        {
            if (this.PluginTree.SelectedRecord == null)
            {
                return;
            }

            if (this.PluginTree.SelectedRecord is Record)
            {
                var r = (Record)this.PluginTree.SelectedRecord;
                if (DialogResult.OK == HeaderEditor.Display(r))
                {
                    this.GetPluginFromNode(this.PluginTree.SelectedRecord).InvalidateCache();
                    this.FireSelectionUpdated();
                }
            }
            else if (this.PluginTree.SelectedRecord is GroupRecord)
            {
                var gr = (GroupRecord)this.PluginTree.SelectedRecord;
                if (DialogResult.OK == GroupEditor.Display(gr))
                {
                    this.GetPluginFromNode(this.PluginTree.SelectedRecord).InvalidateCache();
                    this.FireSelectionUpdated();
                }
            }
        }

        public void EditSelectedRecord()
        {
            var selRecord = this.PluginTree.SelectedRecord;
            if (selRecord is GroupRecord)
            {
                var gr = selRecord as GroupRecord;
                if (DialogResult.OK == GroupEditor.Display(gr))
                {
                    this.GetPluginFromNode(this.PluginTree.SelectedRecord).InvalidateCache();
                    this.FireSelectionUpdated();
                }
            }
            else if (selRecord is Record)
            {
                var r = selRecord as Record;
                var form = new FullRecordEditor(r);
                form.StartPosition = FormStartPosition.CenterScreen;

                var dockParent = this.FindDockContent(this);
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
        }

        public void EndInit()
        {
            if (DesignMode)
            {
                return;
            }

            this.InitializeToolStripRecords();
            this.InitializeTreeList();
            this.UpdateToolStripSelection();

            this.PluginTree.OnContextMenuKey += this.PluginTree_OnContextMenuKey;

            Disposed += this.PluginTreeView_Disposed;
            MainView.ClipboardChanged += this.MainView_ClipboardChanged;

            BaseRecord.RecordDescChanged += this.BaseRecord_RecordDescChanged;
            BaseRecord.ChildListChanged += this.BaseRecord_ChildListChanged;
            BaseRecord.RecordDeleted += this.BaseRecord_RecordDeleted;
        }

        public void ExpandAll()
        {
            this.PluginTree.ExpandAll();
        }

        public void ExpandAll(object item)
        {
            this.PluginTree.BeginUpdate();
            try
            {
                this.InternalExpand(item);
            }
            finally
            {
                this.PluginTree.EndUpdate();
            }
        }

        public void RebuildDisplayNode()
        {
          this.PluginTree.SetObjects(this.PluginTree.SelectedRecords);
        }

        public void RebuildObjects()
        {
            this.PluginTree.RebuildAll(true);
        }

        public void RefreshObject(BaseRecord record)
        {
            this.PluginTree.RefreshObject(record);
        }

        public void RefreshObject(IList records)
        {
            this.PluginTree.RefreshObjects(records);
        }

        public void SetSelectedRecords(IEnumerable<BaseRecord> records)
        {
            this.PluginTree.SelectedRecords = records;
        }

        public void UpdateRoots()
        {
            this.PluginTree.Roots = PluginList.All.Records;
        }

        internal void CopySelectedRecord()
        {
            IEnumerable<BaseRecord> records = this.PluginTree.SelectedRecords;
            if (records.Count() == 1)
            {
                MainView.Clipboard = this.PluginTree.SelectedRecord.Clone();
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

        internal void PasteFromClipboard(bool recordOnly, bool asNew)
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
            {
                return;
            }

            if (isRec)
            {
                BaseRecord node = this.PluginTree.SelectedRecord;
                try
                {
                    var dstNode = this.PluginTree.SelectedRecord;
                    if (dstNode is Record && (dstNode.Parent is GroupRecord || dstNode.Parent is Plugin))
                    {
                        dstNode = dstNode.Parent;
                    }

                    var br = ((BaseRecord)clipboardObject).Clone();
                    dstNode.AddRecord(br);
                    if (asNew)
                    {
                        Spells.giveRecordNewFormID((Record)br, false);
                    }

                    this.RebuildSelection();
                }
                catch (TESParserException ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else if (isRecList)
            {
                var node = this.PluginTree.SelectedRecord;
                try
                {
                    if (node is Record && (node.Parent is GroupRecord))
                    {
                        node = node.Parent;
                    }

                    foreach (var rec in (BaseRecord[])clipboardObject)
                    {
                        var br = rec.Clone();
                        node.AddRecord(br);
                        if (asNew)
                        {
                            Spells.giveRecordNewFormID((Record)br, false);
                        }
                    }

                    this.RefreshObject(node as BaseRecord);

                    /* var gr = node as IGroupRecord;
                    if (gr != null)
                    {
                        foreach (var rec in (BaseRecord[]) clipboardObject)
                            gr.AddRecord(rec);
                        RefreshObject(gr as BaseRecord);
                    } */
                }
                catch (TESParserException ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        private void BaseRecord_ChildListChanged(object sender, RecordChangeEventArgs e)
        {
            if (e.Record == null || e.Record == PluginList.All)
            {
                // use null record as hint to reset the roots
                this.UpdateRoots();

                // PluginTree.RebuildAll(true);
                GC.Collect(); // clean up memory after releasing plugins
            }
            else
            {
                this.PluginTree.RefreshObject(e.Record);
            }
        }

        private void BaseRecord_RecordDeleted(object sender, RecordChangeEventArgs e)
        {
            this._historyHandler.Remove(e.Record);
        }

        private void BaseRecord_RecordDescChanged(object sender, RecordChangeEventArgs e)
        {
            this.PluginTree.RefreshObject(e.Record);
        }

        private void CopySelectedTreeNode()
        {
            if (this.PluginTree.SelectedRecord is Plugin)
            {
                MainView.PostStatusWarning(Resources.CannotCopyPlugin);
            }
            else
            {
                this.CopySelectedRecord();
            }
        }

        private IDockContent FindDockContent(Control c)
        {
            if (c is IDockContent)
            {
                return c as IDockContent;
            }
            else if (c.Parent != null)
            {
                return this.FindDockContent(c.Parent);
            }

            return null;
        }

        private void FireSelectionUpdated()
        {
            if (this.OnSelectionUpdated != null)
            {
                this.OnSelectionUpdated(this, EventArgs.Empty);
            }
        }

        private Plugin GetPluginFromNode(BaseRecord node)
        {
            var tn = node;
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

        private void InitializeToolStripRecords()
        {
            this._historyHandler = new History<BaseRecord>(this.toolStripRecordBack, this.toolStripRecordNext, Settings.Default.MaxHistoryItem);
            this._historyHandler.AllowDuplicates = true;
            this._historyHandler.GotoItem += this.historyHandler_GotoItem;
        }

        private void InitializeTreeList()
        {
            this.PluginTree.MultiSelect = true;
            this.PluginTree.CanExpandGetter = x => (x is IGroupRecord);
            this.PluginTree.ChildrenGetter = x => {
                var r = x as IGroupRecord;
                return (r != null) ? r.Records : null;
            };

            this._olvColumnName = new OLVColumn("Name", "Name");
            this.PluginTree.Columns.Add(this._olvColumnName);

            this._olvColumnName.AspectGetter = x => {
                var r = x as IRecord;
                return (r != null) ? r.DescriptiveName : x;
            };
            var sink1 = (SimpleDropSink)this.PluginTree.DropSink;
            sink1.AcceptExternal = false;
            sink1.CanDropBetween = true;
            sink1.CanDropOnBackground = false;
            sink1.CanDropOnSubItem = false;

            this.UpdateRoots();
        }

        private void InternalCollapse(object item)
        {
            foreach (var child in this.PluginTree.GetChildren(item))
            {
                this.InternalCollapse(child);
            }

            this.PluginTree.Collapse(item);
        }

        private void InternalExpand(object item)
        {
            this.PluginTree.Expand(item);
            foreach (var child in this.PluginTree.GetChildren(item))
            {
                this.InternalExpand(child);
            }
        }

        private void MainView_ClipboardChanged(object sender, EventArgs e)
        {
            this.UpdateToolStripSelection();
        }

        private void PluginTreeView_Disposed(object sender, EventArgs e)
        {
            MainView.ClipboardChanged -= this.MainView_ClipboardChanged;
            BaseRecord.RecordDescChanged -= this.BaseRecord_RecordDescChanged;
            BaseRecord.ChildListChanged -= this.BaseRecord_ChildListChanged;
        }

        private void PluginTree_Enter(object sender, EventArgs e)
        {
            // PluginTree_AfterSelect(sender, null);
        }

        private void PluginTree_KeyDown(object sender, KeyEventArgs e)
        {
            if (!e.Control && !e.Alt && !e.Shift)
            {
                switch (e.KeyCode)
                {
                    case Keys.Delete:
                        this.DeleteSelection();
                        break;
                    case Keys.Divide:
                        this.CollapseAll();
                        break;
                    case Keys.Multiply:
                        this.ExpandAll();
                        break;
                    case Keys.Add:
                        foreach (var item in this.PluginTree.SelectedRecords)
                        {
                            this.PluginTree.Expand(item);
                        }

                        break;
                    case Keys.Subtract:
                        foreach (var item in this.PluginTree.SelectedRecords)
                        {
                            this.PluginTree.Collapse(item);
                        }

                        break;
                }
            }
            else if (e.Shift && !e.Control && !e.Alt)
            {
                switch (e.KeyCode)
                {
                    case Keys.Divide:
                        foreach (var item in this.PluginTree.SelectedRecords)
                        {
                            this.CollapseAll(item);
                        }

                        break;
                    case Keys.Multiply:
                        foreach (var item in this.PluginTree.SelectedRecords)
                        {
                            this.ExpandAll(item);
                        }

                        break;
                    case Keys.Add:
                        foreach (var item in this.PluginTree.SelectedRecords)
                        {
                            this.PluginTree.Expand(item);
                        }

                        break;
                    case Keys.Subtract:
                        foreach (var item in this.PluginTree.SelectedRecords)
                        {
                            this.PluginTree.Collapse(item);
                        }

                        break;
                }
            }
        }

        private void PluginTree_ModelCanDrop(object sender, ModelDropEventArgs e)
        {
            e.Effect = DragDropEffects.None;
            if (e.DropTargetLocation == DropTargetLocation.Background)
            {
                return;
            }

            if (e.SourceModels.OfType<Plugin>().Any())
            {
                e.InfoMessage = "Cannot drag plugins";
                return;
            }

            if (e.TargetModel != null)
            {
                var rec = e.TargetModel as BaseRecord;
                var targetPlugin = this.GetPluginFromNode(rec);
                var targetParent = rec.Parent;
                if (e.SourceModels.Contains(e.TargetModel))
                {
                    // e.InfoMessage = "Cannot drop on self";
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
                    {
                        return;
                    }

                    Plugin srcPlugin = this.GetPluginFromNode(srcParent);
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
                        // e.InfoMessage = "Can only drop on groups or plugins";
                    }
                    else
                    {
                        if (srcPlugin.Equals(targetPlugin))
                        {
                            // same plugin defaults to move unless ctrl down
                            e.Effect = e.DropSink.IsControlDown ? DragDropEffects.Copy : DragDropEffects.Move;
                        }
                        else
                        {
                            // same plugin defaults to copy unless shift down
                            e.Effect = (!e.DropSink.IsControlDown && e.DropSink.IsShiftDown) ? DragDropEffects.Move : DragDropEffects.Copy;
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
                if (group == null)
                {
                    return;
                }

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
                this.PluginTree.SelectObject(objects);
                this.PluginTree.RefreshObject(group);
                this.PluginTree.RefreshObjects(objects);
            }
            else if (e.DropTargetLocation == DropTargetLocation.AboveItem || e.DropTargetLocation == DropTargetLocation.BelowItem)
            {
                int offset = e.DropTargetLocation == DropTargetLocation.BelowItem ? +1 : 0;
                var rec = e.TargetModel as IRecord;
                if (rec == null)
                {
                    return;
                }

                var group = rec.Parent as IGroupRecord;
                if (group == null)
                {
                    return;
                }

                int idx = group.IndexOf(rec as BaseRecord) + offset;
                var refreshObjects = new List<BaseRecord>();
                var selObjects = new List<BaseRecord>();
                IEnumerable<IRecord> itr = e.SourceModels.OfType<IRecord>();
                if (e.DropTargetLocation == DropTargetLocation.BelowItem)
                {
                    itr = itr.Reverse();
                }

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
                this.PluginTree.SelectObject(selObjects);
                this.PluginTree.RefreshObject(group);
                this.PluginTree.RefreshObjects(selObjects);
            }
        }

        private void PluginTree_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            this.EditSelectedHeader();
        }

        private void PluginTree_OnContextMenuKey(object sender, EventArgs e)
        {
            this.contextMenuRecord.Show(this.PluginTree.PointToScreen(new Point(this.PluginTree.Width / 4, this.PluginTree.Height / 4)));
        }

        private void PluginTree_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.PluginTree.SelectedRecord != null)
            {
                if (this._historyHandler.CurrentItem == null && !this.PluginTree.SelectedRecord.Equals(this._historyHandler.CurrentItem))
                {
                    this._historyHandler.CurrentItem = this.PluginTree.SelectedRecord;
                }
            }

            this.RebuildSelection();
        }

        private void PluginTree_SelectionChanged(object sender, EventArgs e)
        {
            if (this._historyHandler.CurrentItem != this.PluginTree.SelectedRecord)
            {
                this._historyHandler.CurrentItem = this.PluginTree.SelectedRecord;
            }

            foreach (var sel in this.PluginTree.SelectedRecords.OfType<Record>())
            {
                sel.MatchRecordStructureToRecord();
                sel.UpdateShortDescription();
            }

            this.UpdateToolStripSelection();
            if (this.SelectionChanged != null)
            {
                this.SelectionChanged(this, EventArgs.Empty);
            }
        }

        private void PluginTree_SizeChanged(object sender, EventArgs e)
        {
            try
            {
                if (this._olvColumnName != null)
                {
                    this._olvColumnName.Width = Width - SystemInformation.VerticalScrollBarWidth - SystemInformation.FrameBorderSize.Width;
                }
            }
            catch
            {
            }
        }

        private void RebuildSelection()
        {
        }

        private void UpdateToolStripSelection()
        {
            var rec = this.PluginTree.SelectedRecord;
            var recs = this.PluginTree.SelectedRecords;
            bool oneSel = recs.Count() == 1;
            bool isRecord = rec is Record;
            bool isGroup = rec is GroupRecord;
            bool isPlugin = rec is Plugin;
            bool isParentPluginOrGroup = isRecord && rec.Parent != null && (rec.Parent is Plugin || rec.Parent is GroupRecord);
            bool enablePaste = oneSel && (isPlugin || isGroup || isParentPluginOrGroup) && MainView.HasClipboardData();

            this.toolStripRecordDelete.Enabled = isRecord || isGroup;
            this.contextMenuRecordDelete.Enabled = isRecord || isGroup;
            this.toolStripRecordCopy.Enabled = isRecord || isGroup;
            this.contextMenuRecordCopy.Enabled = isRecord || isGroup;
            this.contextMenuRecordCopyTo.Enabled = isRecord || isGroup;
            this.toolStripRecordPaste.Enabled = enablePaste;
            this.toolStripRecordPasteNew.Enabled = enablePaste;
            this.contextMenuRecordPaste.Enabled = enablePaste;
            this.contextMenuRecordPasteNew.Enabled = enablePaste;
        }

        private void addMasterToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (var amfNewMaster = new AddMasterForm())
            {
                if (amfNewMaster.ShowDialog(this) == DialogResult.OK)
                {
                    Plugin plugin = this.GetPluginFromNode(this.PluginTree.SelectedRecord);
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
                            this.RebuildSelection();
                        }
                    }
                    catch (ApplicationException ex)
                    {
                        MessageBox.Show(this, ex.Message, Resources.Missing_Record, MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void collapseAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.PluginTree.CollapseAll();
        }

        private void collapseBranchToolStripMenuItem_Click(object sender, EventArgs e)
        {
            foreach (var o in this.PluginTree.SelectedObjects)
            {
                this.CollapseAll(o);
            }
        }

        private void contexMenuRecordCopy_Click(object sender, EventArgs e)
        {
            this.CopySelectedTreeNode();
        }

        private void contextMenuRecordAddMaster_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            if (e.ClickedItem.Tag == null)
            {
                return;
            }

            try
            {
                var nodes = e.ClickedItem.Tag as object[];
                var src = nodes[0] as Plugin;
                var dst = nodes[1] as Plugin;
                if (src != null && dst != null)
                {
                    if (src.AddMaster(dst.Name))
                    {
                        PluginList.FixMasters();
                    }
                }
            }
            catch
            {
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

        private void contextMenuRecordDelete_Click(object sender, EventArgs e)
        {
            this.DeleteSelection();
        }

        private void contextMenuRecordPasteNew_Click(object sender, EventArgs e)
        {
            this.PasteFromClipboard(true, true);
        }

        private void contextMenuRecordPaste_Click(object sender, EventArgs e)
        {
            this.PasteFromClipboard(true, false);
        }

        private void contextMenuRecordReport_Click(object sender, EventArgs e)
        {
            var dockParent = this.FindDockContent(this);
            foreach (BaseRecord r in this.PluginTree.SelectedRecords.OfType<BaseRecord>())
            {
                var form = new RichTextContent();
                form.UpdateRecord(r);
                form.StartPosition = FormStartPosition.CenterScreen;

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
        }

        private void contextMenuRecord_Closing(object sender, ToolStripDropDownClosingEventArgs e)
        {
            this.contextMenuRecordCopyTo.DropDownItems.Clear();
            foreach (var item in this.contextMenuRecordAddMaster.DropDownItems.OfType<ToolStripButton>().Where(x => !x.Equals(this.browseToolStripMenuItem)).ToArray())
            {
                this.contextMenuRecordAddMaster.DropDownItems.Remove(item);
            }
        }

        private void contextMenuRecord_Opening(object sender, CancelEventArgs e)
        {
            var records = this.PluginTree.SelectedRecords;
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
                this.contextMenuRecordEdit.Visible = false;
                this.contextMenuRecordCopy.Enabled = false;
                this.contextMenuRecordCopy.ToolTipText = Resources.CannotCopyNodesFromDifferentParents;
                this.contextMenuRecordCopyTo.Enabled = false;
                this.contextMenuRecordCopyTo.ToolTipText = Resources.CannotCopyNodesFromDifferentParents;
            }
            else if (anyPlugins)
            {
                this.contextMenuRecordEdit.Visible = false;
                this.contextMenuRecordCopy.Enabled = false;
                this.contextMenuRecordCopy.ToolTipText = Resources.CannotCopyPlugin;
                this.contextMenuRecordCopyTo.Enabled = false;
                this.contextMenuRecordCopyTo.ToolTipText = Resources.CannotCopyPlugin;
            }
            else
            {
                this.contextMenuRecordEdit.Visible = nrecords == 1;
                this.contextMenuRecordCopy.Enabled = true;
                this.contextMenuRecordCopy.ToolTipText = Resources.Copy_Record_to_Clipboard;
                this.contextMenuRecordCopyTo.Enabled = this.PluginTree.SelectedObjects.Count > 0;
                this.contextMenuRecordCopyTo.ToolTipText = null;
            }

            this.contextMenuRecordAddMaster.Visible = false;
            this.contextMenuRecordCopyTo.DropDownItems.Clear();

            if (nparents != 1)
            {
                return;
            }

            var srcRecord = records.First();
            var srcPlugin = this.GetPluginFromNode(srcRecord);
            if (this.contextMenuRecordCopyTo.Enabled)
            {
                foreach (Plugin plugin in PluginList.All.Records)
                {
                    if (plugin == null)
                    {
                        continue;
                    }

                    if (srcPlugin.Equals(plugin))
                    {
                        continue;
                    }

                    var tsi = new ToolStripButton(plugin.Name);
                    tsi.Tag = new object[] { records.ToArray(), plugin };
                    var sz = TextRenderer.MeasureText(plugin.Name, this.contextMenuRecordCopyTo.Font);
                    if (sz.Width > tsi.Width)
                    {
                        tsi.Width = sz.Width;
                    }

                    tsi.AutoSize = true;
                    this.contextMenuRecordCopyTo.DropDownItems.Add(tsi);
                }
            }

            // only allow master selectio when single plugin is selected
            if (nrecords == 1 && srcRecord is Plugin)
            {
                string[] masters = srcPlugin.GetMasters();
                Array.Sort(masters, StringComparer.InvariantCultureIgnoreCase);

                foreach (var item in
                    this.contextMenuRecordAddMaster.DropDownItems.OfType<ToolStripButton>().Where(x => !x.Equals(this.browseToolStripMenuItem)).ToArray())
                {
                    this.contextMenuRecordAddMaster.DropDownItems.Remove(item);
                }

                foreach (Plugin plugin in PluginList.All.Records)
                {
                    if (plugin == null)
                    {
                        continue;
                    }

                    if (srcPlugin.Equals(plugin))
                    {
                        continue; // ignore self
                    }

                    if (Array.BinarySearch(masters, plugin.Name, StringComparer.InvariantCultureIgnoreCase) >= 0)
                    {
                        // ignore masters
                        continue;
                    }

                    var tsi = new ToolStripButton(plugin.Name);
                    tsi.Tag = new object[] { srcRecord, plugin };
                    var sz = TextRenderer.MeasureText(plugin.Name, this.contextMenuRecordCopyTo.Font);
                    if (sz.Width > tsi.Width)
                    {
                        tsi.Width = sz.Width;
                    }

                    tsi.AutoSize = true;
                    this.contextMenuRecordAddMaster.DropDownItems.Add(tsi);
                }

                this.contextMenuRecordAddMaster.Visible = true;
            }
        }

        private void editToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.EditSelectedRecord();
        }

        private void expandAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.PluginTree.ExpandAll();
        }

        private void expandBranchToolStripMenuItem_Click(object sender, EventArgs e)
        {
            foreach (var o in this.PluginTree.SelectedObjects)
            {
                this.ExpandAll(o);
            }
        }

        private void historyHandler_GotoItem(object sender, HistoryEventArgs<BaseRecord> e)
        {
            this.PluginTree.SelectedRecord = e.Item;
        }

        private void referenceSearchToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var rec = this.PluginTree.SelectedRecords.OfType<Record>().FirstOrDefault();
            if (rec != null)
            {
                MainView.PostReferenceSearch(rec.FormID);
            }
        }

        private void toolStripRecordCopy_Click(object sender, EventArgs e)
        {
            this.CopySelectedRecord();
        }

        private void toolStripRecordDelete_Click(object sender, EventArgs e)
        {
            this.DeleteSelection();
        }

        private void toolStripRecordPasteNew_Click(object sender, EventArgs e)
        {
            this.PasteFromClipboard(true, true);
        }

        private void toolStripRecordPaste_Click(object sender, EventArgs e)
        {
            this.PasteFromClipboard(true, false);
        }
    }
}
