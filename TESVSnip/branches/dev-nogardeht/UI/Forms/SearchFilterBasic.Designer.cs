namespace TESVSnip.UI.Forms
{
    partial class SearchFilterBasic
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.bSave = new System.Windows.Forms.Button();
            this.bCancel = new System.Windows.Forms.Button();
            this.imageListSmallTree = new System.Windows.Forms.ImageList(this.components);
            this.imageListFilter = new System.Windows.Forms.ImageList(this.components);
            this.cboRecordType = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.bApply = new System.Windows.Forms.Button();
            this.cboSavedSearches = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btnRemoveSearch = new System.Windows.Forms.Button();
            this.btnAddSearch = new System.Windows.Forms.Button();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.filterTree = new BrightIdeasSoftware.TreeListView();
            ((System.ComponentModel.ISupportInitialize)(this.filterTree)).BeginInit();
            this.SuspendLayout();
            // 
            // bSave
            // 
            this.bSave.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.bSave.DialogResult = System.Windows.Forms.DialogResult.Yes;
            this.bSave.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.bSave.Location = new System.Drawing.Point(124, 329);
            this.bSave.Name = "bSave";
            this.bSave.Size = new System.Drawing.Size(75, 23);
            this.bSave.TabIndex = 18;
            this.bSave.Text = "&Find All";
            this.bSave.UseVisualStyleBackColor = true;
            this.bSave.Click += new System.EventHandler(this.bSave_Click);
            // 
            // bCancel
            // 
            this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.bCancel.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.bCancel.Location = new System.Drawing.Point(286, 329);
            this.bCancel.Name = "bCancel";
            this.bCancel.Size = new System.Drawing.Size(75, 23);
            this.bCancel.TabIndex = 17;
            this.bCancel.Text = "&Cancel";
            this.bCancel.UseVisualStyleBackColor = true;
            // 
            // imageListSmallTree
            // 
            this.imageListSmallTree.ColorDepth = System.Windows.Forms.ColorDepth.Depth8Bit;
            this.imageListSmallTree.ImageSize = new System.Drawing.Size(16, 16);
            this.imageListSmallTree.TransparentColor = System.Drawing.Color.Transparent;
            // 
            // imageListFilter
            // 
            this.imageListFilter.ColorDepth = System.Windows.Forms.ColorDepth.Depth8Bit;
            this.imageListFilter.ImageSize = new System.Drawing.Size(16, 16);
            this.imageListFilter.TransparentColor = System.Drawing.Color.Transparent;
            // 
            // cboRecordType
            // 
            this.cboRecordType.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cboRecordType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboRecordType.Font = new System.Drawing.Font("Lucida Console", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cboRecordType.FormattingEnabled = true;
            this.cboRecordType.Location = new System.Drawing.Point(86, 44);
            this.cboRecordType.Name = "cboRecordType";
            this.cboRecordType.Size = new System.Drawing.Size(275, 19);
            this.cboRecordType.TabIndex = 20;
            this.cboRecordType.SelectedIndexChanged += new System.EventHandler(this.cboRecordType_SelectedIndexChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(8, 47);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(72, 13);
            this.label1.TabIndex = 21;
            this.label1.Text = "Record Type:";
            // 
            // bApply
            // 
            this.bApply.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.bApply.DialogResult = System.Windows.Forms.DialogResult.No;
            this.bApply.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.bApply.Location = new System.Drawing.Point(205, 329);
            this.bApply.Name = "bApply";
            this.bApply.Size = new System.Drawing.Size(75, 23);
            this.bApply.TabIndex = 18;
            this.bApply.Text = "&Apply";
            this.bApply.UseVisualStyleBackColor = true;
            this.bApply.Click += new System.EventHandler(this.bApply_Click);
            // 
            // cboSavedSearches
            // 
            this.cboSavedSearches.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cboSavedSearches.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboSavedSearches.FormattingEnabled = true;
            this.cboSavedSearches.Location = new System.Drawing.Point(86, 12);
            this.cboSavedSearches.Name = "cboSavedSearches";
            this.cboSavedSearches.Size = new System.Drawing.Size(230, 21);
            this.cboSavedSearches.TabIndex = 22;
            this.cboSavedSearches.SelectedIndexChanged += new System.EventHandler(this.cboSavedSearches_SelectedIndexChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(8, 15);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 13);
            this.label2.TabIndex = 23;
            this.label2.Text = "Favorites:";
            // 
            // btnRemoveSearch
            // 
            this.btnRemoveSearch.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnRemoveSearch.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRemoveSearch.Image = global::TESVSnip.Properties.Resources._14_layer_deletelayer;
            this.btnRemoveSearch.Location = new System.Drawing.Point(340, 11);
            this.btnRemoveSearch.Margin = new System.Windows.Forms.Padding(0);
            this.btnRemoveSearch.Name = "btnRemoveSearch";
            this.btnRemoveSearch.Size = new System.Drawing.Size(21, 21);
            this.btnRemoveSearch.TabIndex = 24;
            this.toolTip1.SetToolTip(this.btnRemoveSearch, "Remove Current Search");
            this.btnRemoveSearch.UseVisualStyleBackColor = true;
            this.btnRemoveSearch.Click += new System.EventHandler(this.btnRemoveSearch_Click);
            // 
            // btnAddSearch
            // 
            this.btnAddSearch.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnAddSearch.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddSearch.Image = global::TESVSnip.Properties.Resources.bookmark_add;
            this.btnAddSearch.Location = new System.Drawing.Point(320, 11);
            this.btnAddSearch.Margin = new System.Windows.Forms.Padding(0);
            this.btnAddSearch.Name = "btnAddSearch";
            this.btnAddSearch.Size = new System.Drawing.Size(21, 21);
            this.btnAddSearch.TabIndex = 26;
            this.toolTip1.SetToolTip(this.btnAddSearch, "Add Search To Favorites");
            this.btnAddSearch.UseVisualStyleBackColor = true;
            this.btnAddSearch.Click += new System.EventHandler(this.btnAddSearch_Click);
            // 
            // filterTree
            // 
            this.filterTree.AllowColumnReorder = true;
            this.filterTree.AlternateRowBackColor = System.Drawing.Color.WhiteSmoke;
            this.filterTree.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.filterTree.CheckedAspectName = "Checked";
            this.filterTree.EmptyListMsg = "No Subrecords Found";
            this.filterTree.EmptyListMsgFont = new System.Drawing.Font("Comic Sans MS", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.filterTree.IsSearchOnSortColumn = true;
            this.filterTree.GridLines = true;
            this.filterTree.HideSelection = false;
            this.filterTree.HighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.filterTree.HighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.filterTree.LargeImageList = this.imageListSmallTree;
            this.filterTree.Location = new System.Drawing.Point(5, 68);
            this.filterTree.Margin = new System.Windows.Forms.Padding(0);
            this.filterTree.Name = "filterTree";
            this.filterTree.OwnerDraw = true;
            this.filterTree.SelectAllOnControlA = false;
            this.filterTree.SelectColumnsOnRightClickBehaviour = BrightIdeasSoftware.ObjectListView.ColumnSelectBehaviour.Submenu;
            this.filterTree.SelectedColumnTint = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))));
            this.filterTree.ShowFilterMenuOnRightClick = false;
            this.filterTree.ShowGroups = false;
            this.filterTree.ShowImagesOnSubItems = true;
            this.filterTree.ShowItemToolTips = true;
            this.filterTree.Size = new System.Drawing.Size(358, 258);
            this.filterTree.SmallImageList = this.imageListSmallTree;
            this.filterTree.TabIndex = 19;
            this.filterTree.TriStateCheckBoxes = true;
            this.filterTree.UnfocusedHighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.filterTree.UnfocusedHighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.filterTree.UseCompatibleStateImageBehavior = false;
            this.filterTree.UseCustomSelectionColors = true;
            this.filterTree.UseExplorerTheme = true;
            this.filterTree.UseHotItem = true;
            this.filterTree.View = System.Windows.Forms.View.Details;
            this.filterTree.VirtualMode = true;
            this.filterTree.CellEditValidating += new BrightIdeasSoftware.CellEditEventHandler(this.filterTree_CellEditValidating);
            this.filterTree.ItemsChanging += new System.EventHandler<BrightIdeasSoftware.ItemsChangingEventArgs>(this.filterTree_ItemsChanging);
            // 
            // SearchFilterBasic
            // 
            this.AcceptButton = this.bApply;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.bCancel;
            this.ClientSize = new System.Drawing.Size(372, 364);
            this.Controls.Add(this.btnAddSearch);
            this.Controls.Add(this.btnRemoveSearch);
            this.Controls.Add(this.cboSavedSearches);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cboRecordType);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.filterTree);
            this.Controls.Add(this.bApply);
            this.Controls.Add(this.bSave);
            this.Controls.Add(this.bCancel);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(373, 250);
            this.Name = "SearchFilterBasic";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Basic Search Filter";
            this.Load += new System.EventHandler(this.SearchFilter_Load);
            this.Shown += new System.EventHandler(this.SearchFilterBasic_Shown);
            ((System.ComponentModel.ISupportInitialize)(this.filterTree)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button bSave;
        private System.Windows.Forms.Button bCancel;
        private BrightIdeasSoftware.TreeListView filterTree;
        private System.Windows.Forms.ImageList imageListSmallTree;
        private System.Windows.Forms.ImageList imageListFilter;
        private System.Windows.Forms.ComboBox cboRecordType;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button bApply;
        private System.Windows.Forms.ComboBox cboSavedSearches;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnRemoveSearch;
        private System.Windows.Forms.Button btnAddSearch;
        private System.Windows.Forms.ToolTip toolTip1;
    }
}