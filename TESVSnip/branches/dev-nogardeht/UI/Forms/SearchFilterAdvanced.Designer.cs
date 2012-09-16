namespace TESVSnip.UI.Forms
{
    partial class SearchFilterAdvanced
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
            this.filterTree = new BrightIdeasSoftware.TreeListView();
            this.imageListSmallTree = new System.Windows.Forms.ImageList(this.components);
            this.imageListFilter = new System.Windows.Forms.ImageList(this.components);
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnMoveRight = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.treeListView1 = new BrightIdeasSoftware.TreeListView();
            ((System.ComponentModel.ISupportInitialize)(this.filterTree)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.treeListView1)).BeginInit();
            this.SuspendLayout();
            // 
            // bSave
            // 
            this.bSave.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.bSave.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.bSave.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.bSave.Location = new System.Drawing.Point(483, 417);
            this.bSave.Name = "bSave";
            this.bSave.Size = new System.Drawing.Size(75, 23);
            this.bSave.TabIndex = 18;
            this.bSave.Text = "Save";
            this.bSave.UseVisualStyleBackColor = true;
            // 
            // bCancel
            // 
            this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.bCancel.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.bCancel.Location = new System.Drawing.Point(564, 417);
            this.bCancel.Name = "bCancel";
            this.bCancel.Size = new System.Drawing.Size(75, 23);
            this.bCancel.TabIndex = 17;
            this.bCancel.Text = "Cancel";
            this.bCancel.UseVisualStyleBackColor = true;
            // 
            // filterTree
            // 
            this.filterTree.AllowColumnReorder = true;
            this.filterTree.AllowDrop = true;
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
            this.filterTree.IsSimpleDragSource = true;
            this.filterTree.IsSimpleDropSink = true;
            this.filterTree.LargeImageList = this.imageListSmallTree;
            this.filterTree.Location = new System.Drawing.Point(3, 3);
            this.filterTree.Name = "filterTree";
            this.filterTree.OwnerDraw = true;
            this.tableLayoutPanel1.SetRowSpan(this.filterTree, 3);
            this.filterTree.SelectAllOnControlA = false;
            this.filterTree.SelectColumnsOnRightClickBehaviour = BrightIdeasSoftware.ObjectListView.ColumnSelectBehaviour.Submenu;
            this.filterTree.SelectedColumnTint = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))));
            this.filterTree.ShowFilterMenuOnRightClick = false;
            this.filterTree.ShowGroups = false;
            this.filterTree.ShowImagesOnSubItems = true;
            this.filterTree.ShowItemToolTips = true;
            this.filterTree.Size = new System.Drawing.Size(268, 393);
            this.filterTree.SmallImageList = this.imageListSmallTree;
            this.filterTree.TabIndex = 19;
            this.filterTree.TriStateCheckBoxes = true;
            this.filterTree.UnfocusedHighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.filterTree.UnfocusedHighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.filterTree.UseCompatibleStateImageBehavior = false;
            this.filterTree.UseCustomSelectionColors = true;
            this.filterTree.UseExplorerTheme = true;
            this.filterTree.UseFiltering = true;
            this.filterTree.UseHotItem = true;
            this.filterTree.View = System.Windows.Forms.View.Details;
            this.filterTree.VirtualMode = true;
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
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 3;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 77F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Controls.Add(this.filterTree, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.panel1, 1, 1);
            this.tableLayoutPanel1.Controls.Add(this.treeListView1, 2, 0);
            this.tableLayoutPanel1.Location = new System.Drawing.Point(12, 12);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 77F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(626, 399);
            this.tableLayoutPanel1.TabIndex = 20;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.button1);
            this.panel1.Controls.Add(this.btnMoveRight);
            this.panel1.Location = new System.Drawing.Point(277, 164);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(71, 69);
            this.panel1.TabIndex = 20;
            // 
            // btnMoveRight
            // 
            this.btnMoveRight.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.btnMoveRight.Location = new System.Drawing.Point(15, 10);
            this.btnMoveRight.Name = "btnMoveRight";
            this.btnMoveRight.Size = new System.Drawing.Size(41, 23);
            this.btnMoveRight.TabIndex = 0;
            this.btnMoveRight.Text = ">";
            this.btnMoveRight.UseVisualStyleBackColor = true;
            // 
            // button1
            // 
            this.button1.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.button1.Location = new System.Drawing.Point(15, 39);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(41, 23);
            this.button1.TabIndex = 0;
            this.button1.Text = "<";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // treeListView1
            // 
            this.treeListView1.AllowColumnReorder = true;
            this.treeListView1.AllowDrop = true;
            this.treeListView1.AlternateRowBackColor = System.Drawing.Color.WhiteSmoke;
            this.treeListView1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.treeListView1.CheckedAspectName = "Checked";
            this.treeListView1.EmptyListMsg = "No Search Items";
            this.treeListView1.EmptyListMsgFont = new System.Drawing.Font("Comic Sans MS", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.treeListView1.IsSearchOnSortColumn = true;
            this.treeListView1.GridLines = true;
            this.treeListView1.HideSelection = false;
            this.treeListView1.HighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.treeListView1.HighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.treeListView1.IsSimpleDragSource = true;
            this.treeListView1.IsSimpleDropSink = true;
            this.treeListView1.Location = new System.Drawing.Point(354, 3);
            this.treeListView1.Name = "treeListView1";
            this.treeListView1.OwnerDraw = true;
            this.tableLayoutPanel1.SetRowSpan(this.treeListView1, 3);
            this.treeListView1.SelectAllOnControlA = false;
            this.treeListView1.SelectColumnsOnRightClickBehaviour = BrightIdeasSoftware.ObjectListView.ColumnSelectBehaviour.Submenu;
            this.treeListView1.SelectedColumnTint = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))));
            this.treeListView1.ShowFilterMenuOnRightClick = false;
            this.treeListView1.ShowGroups = false;
            this.treeListView1.ShowImagesOnSubItems = true;
            this.treeListView1.ShowItemToolTips = true;
            this.treeListView1.Size = new System.Drawing.Size(269, 393);
            this.treeListView1.TabIndex = 19;
            this.treeListView1.TriStateCheckBoxes = true;
            this.treeListView1.UnfocusedHighlightBackgroundColor = System.Drawing.SystemColors.Highlight;
            this.treeListView1.UnfocusedHighlightForegroundColor = System.Drawing.SystemColors.HighlightText;
            this.treeListView1.UseCompatibleStateImageBehavior = false;
            this.treeListView1.UseCustomSelectionColors = true;
            this.treeListView1.UseExplorerTheme = true;
            this.treeListView1.UseFiltering = true;
            this.treeListView1.UseHotItem = true;
            this.treeListView1.View = System.Windows.Forms.View.Details;
            this.treeListView1.VirtualMode = true;
            // 
            // SearchFilter
            // 
            this.AcceptButton = this.bSave;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.bCancel;
            this.ClientSize = new System.Drawing.Size(650, 452);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.bSave);
            this.Controls.Add(this.bCancel);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "SearchFilter";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Search Filter";
            this.Load += new System.EventHandler(this.SearchFilter_Load);
            ((System.ComponentModel.ISupportInitialize)(this.filterTree)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.treeListView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button bSave;
        private System.Windows.Forms.Button bCancel;
        private BrightIdeasSoftware.TreeListView filterTree;
        private System.Windows.Forms.ImageList imageListSmallTree;
        private System.Windows.Forms.ImageList imageListFilter;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button btnMoveRight;
        private BrightIdeasSoftware.TreeListView treeListView1;
    }
}