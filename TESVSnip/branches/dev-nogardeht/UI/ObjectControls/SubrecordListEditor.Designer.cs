namespace TESVSnip.UI.ObjectControls
{
    partial class SubrecordListEditor
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (this.components != null))
            {
                this.components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SubrecordListEditor));
            this.subrecordPanel = new System.Windows.Forms.Panel();
            this.listSubrecord = new TESVSnip.Windows.Controls.ObjectBindingListView();
            this.toolStripSubRecord = new System.Windows.Forms.ToolStrip();
            this.toolStripInsertRecord = new System.Windows.Forms.ToolStripDropDownButton();
            this.toolStripDeleteRecord = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripMoveRecordUp = new System.Windows.Forms.ToolStripButton();
            this.toolStripMoveRecordDown = new System.Windows.Forms.ToolStripButton();
            this.toolStripButton1 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripEditSubrecord = new System.Windows.Forms.ToolStripButton();
            this.toolStripEditSubrecordHex = new System.Windows.Forms.ToolStripButton();
            this.toolStripPasteSubrecord = new System.Windows.Forms.ToolStripButton();
            this.toolStripCopySubrecord = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.subrecordPanel.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.listSubrecord)).BeginInit();
            this.toolStripSubRecord.SuspendLayout();
            this.SuspendLayout();
            // 
            // subrecordPanel
            // 
            this.subrecordPanel.Controls.Add(this.listSubrecord);
            this.subrecordPanel.Controls.Add(this.toolStripSubRecord);
            resources.ApplyResources(this.subrecordPanel, "subrecordPanel");
            this.subrecordPanel.Name = "subrecordPanel";
            // 
            // listSubrecord
            // 
            this.listSubrecord.Activation = System.Windows.Forms.ItemActivation.OneClick;
            this.listSubrecord.AllowDrop = true;
            this.listSubrecord.DataSource = null;
            resources.ApplyResources(this.listSubrecord, "listSubrecord");
            this.listSubrecord.IsSearchOnSortColumn = false;
            this.listSubrecord.FullRowSelect = true;
            this.listSubrecord.GridLines = true;
            this.listSubrecord.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
            this.listSubrecord.HideSelection = false;
            this.listSubrecord.HighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.listSubrecord.HighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.listSubrecord.ItemCount = 0;
            this.listSubrecord.Name = "listSubrecord";
            this.listSubrecord.OwnerDraw = true;
            this.listSubrecord.ShowItemToolTips = true;
            this.listSubrecord.UnfocusedHighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.listSubrecord.UnfocusedHighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.listSubrecord.UseCompatibleStateImageBehavior = false;
            this.listSubrecord.View = System.Windows.Forms.View.Details;
            this.listSubrecord.VirtualMode = true;
            this.listSubrecord.ItemActivate += new System.EventHandler(this.listView1_ItemActivate);
            this.listSubrecord.ItemDrag += new System.Windows.Forms.ItemDragEventHandler(this.listView1_ItemDrag);
            this.listSubrecord.SelectedIndexChanged += new System.EventHandler(this.listSubrecord_SelectedIndexChanged);
            this.listSubrecord.DragDrop += new System.Windows.Forms.DragEventHandler(this.listView1_DragDrop);
            this.listSubrecord.DragEnter += new System.Windows.Forms.DragEventHandler(this.listView1_DragEnter);
            this.listSubrecord.GiveFeedback += new System.Windows.Forms.GiveFeedbackEventHandler(this.listView1_GiveFeedback);
            this.listSubrecord.KeyDown += new System.Windows.Forms.KeyEventHandler(this.listSubrecord_KeyDown);
            this.listSubrecord.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.listSubrecord_MouseDoubleClick);
            // 
            // toolStripSubRecord
            // 
            this.toolStripSubRecord.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStripSubRecord.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripInsertRecord,
            this.toolStripDeleteRecord,
            this.toolStripSeparator1,
            this.toolStripMoveRecordUp,
            this.toolStripMoveRecordDown,
            this.toolStripButton1,
            this.toolStripEditSubrecord,
            this.toolStripEditSubrecordHex,
            this.toolStripPasteSubrecord,
            this.toolStripCopySubrecord,
            this.toolStripSeparator2});
            resources.ApplyResources(this.toolStripSubRecord, "toolStripSubRecord");
            this.toolStripSubRecord.Name = "toolStripSubRecord";
            this.toolStripSubRecord.TabStop = true;
            // 
            // toolStripInsertRecord
            // 
            this.toolStripInsertRecord.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripInsertRecord.Image = global::TESVSnip.Properties.Resources.insertcell1;
            resources.ApplyResources(this.toolStripInsertRecord, "toolStripInsertRecord");
            this.toolStripInsertRecord.Name = "toolStripInsertRecord";
            this.toolStripInsertRecord.Padding = new System.Windows.Forms.Padding(0, 0, 1, 0);
            this.toolStripInsertRecord.DropDownClosed += new System.EventHandler(this.toolStripInsertRecord_DropDownClosed);
            this.toolStripInsertRecord.DropDownOpening += new System.EventHandler(this.toolStripInsertRecord_DropDownOpening);
            // 
            // toolStripDeleteRecord
            // 
            this.toolStripDeleteRecord.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripDeleteRecord.Image = global::TESVSnip.Properties.Resources.deletecell;
            resources.ApplyResources(this.toolStripDeleteRecord, "toolStripDeleteRecord");
            this.toolStripDeleteRecord.Name = "toolStripDeleteRecord";
            this.toolStripDeleteRecord.Click += new System.EventHandler(this.toolStripDeleteRecord_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            resources.ApplyResources(this.toolStripSeparator1, "toolStripSeparator1");
            // 
            // toolStripMoveRecordUp
            // 
            this.toolStripMoveRecordUp.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripMoveRecordUp.Image = global::TESVSnip.Properties.Resources.move_task_up;
            resources.ApplyResources(this.toolStripMoveRecordUp, "toolStripMoveRecordUp");
            this.toolStripMoveRecordUp.Name = "toolStripMoveRecordUp";
            this.toolStripMoveRecordUp.Click += new System.EventHandler(this.toolStripMoveRecordUp_Click);
            // 
            // toolStripMoveRecordDown
            // 
            this.toolStripMoveRecordDown.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripMoveRecordDown.Image = global::TESVSnip.Properties.Resources.move_task_down;
            resources.ApplyResources(this.toolStripMoveRecordDown, "toolStripMoveRecordDown");
            this.toolStripMoveRecordDown.Name = "toolStripMoveRecordDown";
            this.toolStripMoveRecordDown.Click += new System.EventHandler(this.toolStripMoveRecordDown_Click);
            // 
            // toolStripButton1
            // 
            this.toolStripButton1.Name = "toolStripButton1";
            resources.ApplyResources(this.toolStripButton1, "toolStripButton1");
            // 
            // toolStripEditSubrecord
            // 
            this.toolStripEditSubrecord.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripEditSubrecord.Image = global::TESVSnip.Properties.Resources.editclear;
            resources.ApplyResources(this.toolStripEditSubrecord, "toolStripEditSubrecord");
            this.toolStripEditSubrecord.Name = "toolStripEditSubrecord";
            this.toolStripEditSubrecord.Padding = new System.Windows.Forms.Padding(2, 0, 0, 0);
            this.toolStripEditSubrecord.Click += new System.EventHandler(this.toolStripEditSubrecord_Click);
            // 
            // toolStripEditSubrecordHex
            // 
            this.toolStripEditSubrecordHex.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripEditSubrecordHex.Image = global::TESVSnip.Properties.Resources.xdays;
            resources.ApplyResources(this.toolStripEditSubrecordHex, "toolStripEditSubrecordHex");
            this.toolStripEditSubrecordHex.Name = "toolStripEditSubrecordHex";
            this.toolStripEditSubrecordHex.Click += new System.EventHandler(this.toolStripEditSubrecordHex_Click);
            // 
            // toolStripPasteSubrecord
            // 
            this.toolStripPasteSubrecord.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.toolStripPasteSubrecord.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripPasteSubrecord.Image = global::TESVSnip.Properties.Resources.Paste;
            resources.ApplyResources(this.toolStripPasteSubrecord, "toolStripPasteSubrecord");
            this.toolStripPasteSubrecord.Name = "toolStripPasteSubrecord";
            this.toolStripPasteSubrecord.Click += new System.EventHandler(this.toolStripPasteSubrecord_Click);
            // 
            // toolStripCopySubrecord
            // 
            this.toolStripCopySubrecord.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.toolStripCopySubrecord.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripCopySubrecord.Image = global::TESVSnip.Properties.Resources.Copy;
            resources.ApplyResources(this.toolStripCopySubrecord, "toolStripCopySubrecord");
            this.toolStripCopySubrecord.Name = "toolStripCopySubrecord";
            this.toolStripCopySubrecord.Click += new System.EventHandler(this.toolStripCopySubrecord_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            resources.ApplyResources(this.toolStripSeparator2, "toolStripSeparator2");
            // 
            // SubrecordListEditor
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.subrecordPanel);
            this.MinimumSize = new System.Drawing.Size(192, 120);
            this.Name = "SubrecordListEditor";
            this.SizeChanged += new System.EventHandler(this.SubrecordListEditor_SizeChanged);
            this.subrecordPanel.ResumeLayout(false);
            this.subrecordPanel.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.listSubrecord)).EndInit();
            this.toolStripSubRecord.ResumeLayout(false);
            this.toolStripSubRecord.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel subrecordPanel;
        private Windows.Controls.ObjectBindingListView listSubrecord;
        private System.Windows.Forms.ToolStrip toolStripSubRecord;
        private System.Windows.Forms.ToolStripDropDownButton toolStripInsertRecord;
        private System.Windows.Forms.ToolStripButton toolStripDeleteRecord;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton toolStripMoveRecordUp;
        private System.Windows.Forms.ToolStripButton toolStripMoveRecordDown;
        private System.Windows.Forms.ToolStripSeparator toolStripButton1;
        private System.Windows.Forms.ToolStripButton toolStripEditSubrecord;
        private System.Windows.Forms.ToolStripButton toolStripEditSubrecordHex;
        private System.Windows.Forms.ToolStripButton toolStripPasteSubrecord;
        private System.Windows.Forms.ToolStripButton toolStripCopySubrecord;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
    }
}
