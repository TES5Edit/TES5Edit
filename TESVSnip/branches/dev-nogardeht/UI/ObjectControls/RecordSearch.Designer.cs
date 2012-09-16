namespace TESVSnip.UI.ObjectControls
{
    using BrightIdeasSoftware;

    partial class RecordSearch
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(RecordSearch));
            this.toolStripIncrFind = new System.Windows.Forms.ToolStrip();
            this.toolStripSearchLabel = new System.Windows.Forms.ToolStripLabel();
            this.toolStripIncrFindText = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripIncrSelectCriteria = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindTypeFilter = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripIncrFindGo = new System.Windows.Forms.ToolStripButton();
            this.toolStripSynchronize = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindCancel = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindClear = new System.Windows.Forms.ToolStripButton();
            this.toolStripSelectColumns = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindType = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripIncrFindMatch = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindExact = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator7 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripIncrFindStatus = new System.Windows.Forms.ToolStripLabel();
            this.contextMenuStripList = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.synchronizeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.batchEditToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.resetToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.copyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.copyToToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.listSearchView = new BrightIdeasSoftware.ObjectListView();
            this.reportToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripIncrFind.SuspendLayout();
            this.contextMenuStripList.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.listSearchView)).BeginInit();
            this.SuspendLayout();
            // 
            // toolStripIncrFind
            // 
            resources.ApplyResources(this.toolStripIncrFind, "toolStripIncrFind");
            this.toolStripIncrFind.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStripIncrFind.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripSearchLabel,
            this.toolStripIncrFindText,
            this.toolStripIncrSelectCriteria,
            this.toolStripIncrFindTypeFilter,
            this.toolStripIncrFindGo,
            this.toolStripSynchronize,
            this.toolStripIncrFindCancel,
            this.toolStripIncrFindClear,
            this.toolStripSelectColumns,
            this.toolStripIncrFindType,
            this.toolStripIncrFindMatch,
            this.toolStripIncrFindExact,
            this.toolStripSeparator7,
            this.toolStripIncrFindStatus});
            this.toolStripIncrFind.Name = "toolStripIncrFind";
            this.toolStripIncrFind.TabStop = true;
            // 
            // toolStripSearchLabel
            // 
            this.toolStripSearchLabel.Name = "toolStripSearchLabel";
            resources.ApplyResources(this.toolStripSearchLabel, "toolStripSearchLabel");
            // 
            // toolStripIncrFindText
            // 
            resources.ApplyResources(this.toolStripIncrFindText, "toolStripIncrFindText");
            this.toolStripIncrFindText.Name = "toolStripIncrFindText";
            this.toolStripIncrFindText.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            this.toolStripIncrFindText.KeyDown += new System.Windows.Forms.KeyEventHandler(this.toolStripIncrFindText_KeyDown);
            this.toolStripIncrFindText.TextChanged += new System.EventHandler(this.toolStripIncrFindText_TextChanged);
            // 
            // toolStripIncrSelectCriteria
            // 
            this.toolStripIncrSelectCriteria.Image = global::TESVSnip.Properties.Resources.configure_toolbars;
            resources.ApplyResources(this.toolStripIncrSelectCriteria, "toolStripIncrSelectCriteria");
            this.toolStripIncrSelectCriteria.Name = "toolStripIncrSelectCriteria";
            this.toolStripIncrSelectCriteria.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            this.toolStripIncrSelectCriteria.Click += new System.EventHandler(this.toolStripIncrSelectCriteria_Click);
            // 
            // toolStripIncrFindTypeFilter
            // 
            this.toolStripIncrFindTypeFilter.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.toolStripIncrFindTypeFilter.Items.AddRange(new object[] {
            resources.GetString("toolStripIncrFindTypeFilter.Items"),
            resources.GetString("toolStripIncrFindTypeFilter.Items1")});
            this.toolStripIncrFindTypeFilter.Name = "toolStripIncrFindTypeFilter";
            this.toolStripIncrFindTypeFilter.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripIncrFindTypeFilter, "toolStripIncrFindTypeFilter");
            this.toolStripIncrFindTypeFilter.SelectedIndexChanged += new System.EventHandler(this.toolStripIncrFindTypeFilter_SelectedIndexChanged);
            // 
            // toolStripIncrFindGo
            // 
            this.toolStripIncrFindGo.Image = global::TESVSnip.Properties.Resources.find;
            resources.ApplyResources(this.toolStripIncrFindGo, "toolStripIncrFindGo");
            this.toolStripIncrFindGo.Name = "toolStripIncrFindGo";
            this.toolStripIncrFindGo.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            this.toolStripIncrFindGo.Click += new System.EventHandler(this.toolStripIncrFindGo_Click);
            // 
            // toolStripSynchronize
            // 
            this.toolStripSynchronize.AutoToolTip = false;
            this.toolStripSynchronize.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripSynchronize.Image = global::TESVSnip.Properties.Resources.reload_all_tabs;
            resources.ApplyResources(this.toolStripSynchronize, "toolStripSynchronize");
            this.toolStripSynchronize.Name = "toolStripSynchronize";
            this.toolStripSynchronize.Click += new System.EventHandler(this.toolStripSynchronize_Click);
            // 
            // toolStripIncrFindCancel
            // 
            this.toolStripIncrFindCancel.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripIncrFindCancel.Image = global::TESVSnip.Properties.Resources.agt_stop;
            resources.ApplyResources(this.toolStripIncrFindCancel, "toolStripIncrFindCancel");
            this.toolStripIncrFindCancel.Name = "toolStripIncrFindCancel";
            this.toolStripIncrFindCancel.Click += new System.EventHandler(this.toolStripIncrFindCancel_Click);
            // 
            // toolStripIncrFindClear
            // 
            this.toolStripIncrFindClear.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripIncrFindClear.Image = global::TESVSnip.Properties.Resources.RolledBack;
            resources.ApplyResources(this.toolStripIncrFindClear, "toolStripIncrFindClear");
            this.toolStripIncrFindClear.Name = "toolStripIncrFindClear";
            this.toolStripIncrFindClear.Click += new System.EventHandler(this.toolStripIncrFindClear_Click);
            // 
            // toolStripSelectColumns
            // 
            this.toolStripSelectColumns.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripSelectColumns.Image = global::TESVSnip.Properties.Resources.EditTable;
            resources.ApplyResources(this.toolStripSelectColumns, "toolStripSelectColumns");
            this.toolStripSelectColumns.Name = "toolStripSelectColumns";
            this.toolStripSelectColumns.Click += new System.EventHandler(this.toolStripSelectColumns_Click);
            // 
            // toolStripIncrFindType
            // 
            this.toolStripIncrFindType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.toolStripIncrFindType.Items.AddRange(new object[] {
            resources.GetString("toolStripIncrFindType.Items"),
            resources.GetString("toolStripIncrFindType.Items1")});
            this.toolStripIncrFindType.Name = "toolStripIncrFindType";
            this.toolStripIncrFindType.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripIncrFindType, "toolStripIncrFindType");
            this.toolStripIncrFindType.SelectedIndexChanged += new System.EventHandler(this.toolStripIncrFindType_SelectedIndexChanged);
            // 
            // toolStripIncrFindMatch
            // 
            this.toolStripIncrFindMatch.CheckOnClick = true;
            this.toolStripIncrFindMatch.Image = global::TESVSnip.Properties.Resources.emptybox;
            resources.ApplyResources(this.toolStripIncrFindMatch, "toolStripIncrFindMatch");
            this.toolStripIncrFindMatch.Name = "toolStripIncrFindMatch";
            this.toolStripIncrFindMatch.CheckStateChanged += new System.EventHandler(this.toolStripCheck_CheckStateChanged);
            // 
            // toolStripIncrFindExact
            // 
            this.toolStripIncrFindExact.CheckOnClick = true;
            this.toolStripIncrFindExact.Image = global::TESVSnip.Properties.Resources.emptybox;
            resources.ApplyResources(this.toolStripIncrFindExact, "toolStripIncrFindExact");
            this.toolStripIncrFindExact.Name = "toolStripIncrFindExact";
            this.toolStripIncrFindExact.CheckStateChanged += new System.EventHandler(this.toolStripCheck_CheckStateChanged);
            // 
            // toolStripSeparator7
            // 
            this.toolStripSeparator7.Name = "toolStripSeparator7";
            this.toolStripSeparator7.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripSeparator7, "toolStripSeparator7");
            // 
            // toolStripIncrFindStatus
            // 
            this.toolStripIncrFindStatus.ForeColor = System.Drawing.Color.Maroon;
            this.toolStripIncrFindStatus.Name = "toolStripIncrFindStatus";
            this.toolStripIncrFindStatus.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripIncrFindStatus, "toolStripIncrFindStatus");
            // 
            // contextMenuStripList
            // 
            this.contextMenuStripList.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.synchronizeToolStripMenuItem,
            this.editToolStripMenuItem,
            this.batchEditToolStripMenuItem,
            this.resetToolStripMenuItem,
            this.reportToolStripMenuItem,
            this.copyToolStripMenuItem,
            this.copyToToolStripMenuItem});
            this.contextMenuStripList.Name = "contextMenuStripList";
            resources.ApplyResources(this.contextMenuStripList, "contextMenuStripList");
            this.contextMenuStripList.Closing += new System.Windows.Forms.ToolStripDropDownClosingEventHandler(this.contextMenuStripList_Closing);
            this.contextMenuStripList.Opening += new System.ComponentModel.CancelEventHandler(this.contextMenuStripList_Opening);
            // 
            // synchronizeToolStripMenuItem
            // 
            this.synchronizeToolStripMenuItem.Name = "synchronizeToolStripMenuItem";
            resources.ApplyResources(this.synchronizeToolStripMenuItem, "synchronizeToolStripMenuItem");
            this.synchronizeToolStripMenuItem.Click += new System.EventHandler(this.synchronizeToolStripMenuItem_Click);
            // 
            // editToolStripMenuItem
            // 
            this.editToolStripMenuItem.Name = "editToolStripMenuItem";
            resources.ApplyResources(this.editToolStripMenuItem, "editToolStripMenuItem");
            this.editToolStripMenuItem.Click += new System.EventHandler(this.editToolStripMenuItem_Click);
            // 
            // batchEditToolStripMenuItem
            // 
            this.batchEditToolStripMenuItem.Name = "batchEditToolStripMenuItem";
            resources.ApplyResources(this.batchEditToolStripMenuItem, "batchEditToolStripMenuItem");
            this.batchEditToolStripMenuItem.Click += new System.EventHandler(this.batchEditToolStripMenuItem_Click);
            // 
            // resetToolStripMenuItem
            // 
            this.resetToolStripMenuItem.Name = "resetToolStripMenuItem";
            resources.ApplyResources(this.resetToolStripMenuItem, "resetToolStripMenuItem");
            this.resetToolStripMenuItem.Click += new System.EventHandler(this.resetToolStripMenuItem_Click);
            // 
            // copyToolStripMenuItem
            // 
            this.copyToolStripMenuItem.Name = "copyToolStripMenuItem";
            resources.ApplyResources(this.copyToolStripMenuItem, "copyToolStripMenuItem");
            this.copyToolStripMenuItem.Click += new System.EventHandler(this.copyToolStripMenuItem_Click);
            // 
            // copyToToolStripMenuItem
            // 
            this.copyToToolStripMenuItem.Name = "copyToToolStripMenuItem";
            resources.ApplyResources(this.copyToToolStripMenuItem, "copyToToolStripMenuItem");
            this.copyToToolStripMenuItem.DropDownItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.copyToToolStripMenuItem_DropDownItemClicked);
            // 
            // backgroundWorker1
            // 
            this.backgroundWorker1.WorkerReportsProgress = true;
            this.backgroundWorker1.WorkerSupportsCancellation = true;
            // 
            // listSearchView
            // 
            this.listSearchView.AlternateRowBackColor = System.Drawing.Color.WhiteSmoke;
            this.listSearchView.ContextMenuStrip = this.contextMenuStripList;
            resources.ApplyResources(this.listSearchView, "listSearchView");
            this.listSearchView.EmptyListMsgFont = new System.Drawing.Font("Comic Sans MS", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.listSearchView.IsSearchOnSortColumn = true;
            this.listSearchView.FullRowSelect = true;
            this.listSearchView.GridLines = true;
            this.listSearchView.HideSelection = false;
            this.listSearchView.HighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.listSearchView.HighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.listSearchView.Name = "listSearchView";
            this.listSearchView.OwnerDraw = true;
            this.listSearchView.UnfocusedHighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.listSearchView.UnfocusedHighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.listSearchView.UseAlternatingBackColors = true;
            this.listSearchView.UseCompatibleStateImageBehavior = false;
            this.listSearchView.View = System.Windows.Forms.View.Details;
            this.listSearchView.BeforeSorting += new System.EventHandler<BrightIdeasSoftware.BeforeSortingEventArgs>(this.listSearchView_BeforeSorting);
            this.listSearchView.BeforeCreatingGroups += new System.EventHandler<BrightIdeasSoftware.CreateGroupsEventArgs>(this.listSearchView_BeforeCreatingGroups);
            this.listSearchView.CellClick += new System.EventHandler<BrightIdeasSoftware.CellClickEventArgs>(this.listSearchView_CellClick);
            this.listSearchView.KeyDown += new System.Windows.Forms.KeyEventHandler(this.listSearchView_KeyDown);
            // 
            // reportToolStripMenuItem
            // 
            this.reportToolStripMenuItem.Name = "reportToolStripMenuItem";
            resources.ApplyResources(this.reportToolStripMenuItem, "reportToolStripMenuItem");
            this.reportToolStripMenuItem.Click += new System.EventHandler(this.reportToolStripMenuItem_Click);
            // 
            // RecordSearch
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.listSearchView);
            this.Controls.Add(this.toolStripIncrFind);
            this.Name = "RecordSearch";
            this.Load += new System.EventHandler(this.RecordSearch_Load);
            this.toolStripIncrFind.ResumeLayout(false);
            this.toolStripIncrFind.PerformLayout();
            this.contextMenuStripList.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.listSearchView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ToolStrip toolStripIncrFind;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindCancel;
        private System.Windows.Forms.ToolStripComboBox toolStripIncrFindTypeFilter;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindGo;
        private System.Windows.Forms.ToolStripComboBox toolStripIncrFindType;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindMatch;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindExact;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator7;
        private System.Windows.Forms.ToolStripLabel toolStripIncrFindStatus;
        private ObjectListView listSearchView;
        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private System.Windows.Forms.ContextMenuStrip contextMenuStripList;
        private System.Windows.Forms.ToolStripComboBox toolStripIncrFindText;
        private System.Windows.Forms.ToolStripLabel toolStripSearchLabel;
        private System.Windows.Forms.ToolStripButton toolStripSynchronize;
        private System.Windows.Forms.ToolStripButton toolStripIncrSelectCriteria;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindClear;
        private System.Windows.Forms.ToolStripButton toolStripSelectColumns;
        private System.Windows.Forms.ToolStripMenuItem synchronizeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem batchEditToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem resetToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem copyToToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem copyToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem reportToolStripMenuItem;
    }
}
