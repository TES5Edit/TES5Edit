namespace TESVSnip.UI.Forms
{
    partial class RecordColumnSelect
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
            this.bCancel = new System.Windows.Forms.Button();
            this.imageListSmallTree = new System.Windows.Forms.ImageList(this.components);
            this.imageListFilter = new System.Windows.Forms.ImageList(this.components);
            this.filterTree = new BrightIdeasSoftware.TreeListView();
            this.bApply = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.filterTree)).BeginInit();
            this.SuspendLayout();
            // 
            // bCancel
            // 
            this.bCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.bCancel.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.bCancel.Location = new System.Drawing.Point(303, 343);
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
            this.filterTree.Location = new System.Drawing.Point(12, 12);
            this.filterTree.Name = "filterTree";
            this.filterTree.OwnerDraw = true;
            this.filterTree.SelectAllOnControlA = false;
            this.filterTree.SelectColumnsOnRightClickBehaviour = BrightIdeasSoftware.ObjectListView.ColumnSelectBehaviour.Submenu;
            this.filterTree.SelectedColumnTint = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))), ((int)(((byte)(245)))));
            this.filterTree.ShowFilterMenuOnRightClick = false;
            this.filterTree.ShowGroups = false;
            this.filterTree.ShowImagesOnSubItems = true;
            this.filterTree.ShowItemToolTips = true;
            this.filterTree.Size = new System.Drawing.Size(366, 319);
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
            // 
            // bApply
            // 
            this.bApply.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.bApply.DialogResult = System.Windows.Forms.DialogResult.No;
            this.bApply.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.bApply.Location = new System.Drawing.Point(222, 343);
            this.bApply.Name = "bApply";
            this.bApply.Size = new System.Drawing.Size(75, 23);
            this.bApply.TabIndex = 18;
            this.bApply.Text = "&Apply";
            this.bApply.UseVisualStyleBackColor = true;
            this.bApply.Click += new System.EventHandler(this.bApply_Click);
            // 
            // RecordColumnSelect
            // 
            this.AcceptButton = this.bApply;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.bCancel;
            this.ClientSize = new System.Drawing.Size(389, 378);
            this.Controls.Add(this.filterTree);
            this.Controls.Add(this.bApply);
            this.Controls.Add(this.bCancel);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "RecordColumnSelect";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Column Selector";
            this.Load += new System.EventHandler(this.ColumnFilter_Load);
            ((System.ComponentModel.ISupportInitialize)(this.filterTree)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button bCancel;
        private BrightIdeasSoftware.TreeListView filterTree;
        private System.Windows.Forms.ImageList imageListSmallTree;
        private System.Windows.Forms.ImageList imageListFilter;
        private System.Windows.Forms.Button bApply;
    }
}