namespace TESVSnip.UI.Forms
{
    partial class StringsEditor
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StringsEditor));
            this.label1 = new System.Windows.Forms.Label();
            this.btnAddString = new System.Windows.Forms.Button();
            this.txtID = new System.Windows.Forms.TextBox();
            this.txtString = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btnEditString = new System.Windows.Forms.Button();
            this.tip = new System.Windows.Forms.ToolTip(this.components);
            this.btnLookup = new System.Windows.Forms.Button();
            this.btnDeleteString = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.cboPlugins = new System.Windows.Forms.ComboBox();
            this.btnClose = new System.Windows.Forms.Button();
            this.cboType = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.btnNewItem = new System.Windows.Forms.Button();
            this.listStrings = new TESVSnip.Windows.Controls.BindingListView();
            this.btnApply = new System.Windows.Forms.Button();
            this.error = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.error)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // btnAddString
            // 
            resources.ApplyResources(this.btnAddString, "btnAddString");
            this.btnAddString.Image = global::TESVSnip.Properties.Resources.edit_add;
            this.btnAddString.Name = "btnAddString";
            this.tip.SetToolTip(this.btnAddString, resources.GetString("btnAddString.ToolTip"));
            this.btnAddString.UseVisualStyleBackColor = true;
            this.btnAddString.Click += new System.EventHandler(this.btnAddString_Click);
            // 
            // txtID
            // 
            resources.ApplyResources(this.txtID, "txtID");
            this.txtID.Name = "txtID";
            this.txtID.TextChanged += new System.EventHandler(this.txtID_TextChanged);
            this.txtID.Validating += new System.ComponentModel.CancelEventHandler(this.txtID_Validating);
            // 
            // txtString
            // 
            resources.ApplyResources(this.txtString, "txtString");
            this.txtString.Name = "txtString";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // btnEditString
            // 
            resources.ApplyResources(this.btnEditString, "btnEditString");
            this.btnEditString.Name = "btnEditString";
            this.tip.SetToolTip(this.btnEditString, resources.GetString("btnEditString.ToolTip"));
            this.btnEditString.UseVisualStyleBackColor = true;
            this.btnEditString.Click += new System.EventHandler(this.btnEditString_Click);
            // 
            // btnLookup
            // 
            resources.ApplyResources(this.btnLookup, "btnLookup");
            this.btnLookup.Image = global::TESVSnip.Properties.Resources.find;
            this.btnLookup.Name = "btnLookup";
            this.tip.SetToolTip(this.btnLookup, resources.GetString("btnLookup.ToolTip"));
            this.btnLookup.UseVisualStyleBackColor = true;
            this.btnLookup.Click += new System.EventHandler(this.btnLookup_Click);
            // 
            // btnDeleteString
            // 
            resources.ApplyResources(this.btnDeleteString, "btnDeleteString");
            this.btnDeleteString.Image = global::TESVSnip.Properties.Resources.edit_remove;
            this.btnDeleteString.Name = "btnDeleteString";
            this.tip.SetToolTip(this.btnDeleteString, resources.GetString("btnDeleteString.ToolTip"));
            this.btnDeleteString.UseVisualStyleBackColor = true;
            this.btnDeleteString.Click += new System.EventHandler(this.btnDeleteString_Click);
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // cboPlugins
            // 
            resources.ApplyResources(this.cboPlugins, "cboPlugins");
            this.cboPlugins.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboPlugins.FormattingEnabled = true;
            this.cboPlugins.Name = "cboPlugins";
            // 
            // btnClose
            // 
            resources.ApplyResources(this.btnClose, "btnClose");
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.Name = "btnClose";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.button1_Click);
            // 
            // cboType
            // 
            resources.ApplyResources(this.cboType, "cboType");
            this.cboType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboType.FormattingEnabled = true;
            this.cboType.Name = "cboType";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // btnNewItem
            // 
            resources.ApplyResources(this.btnNewItem, "btnNewItem");
            this.btnNewItem.Image = global::TESVSnip.Properties.Resources.insertcell;
            this.btnNewItem.Name = "btnNewItem";
            this.btnNewItem.UseVisualStyleBackColor = true;
            this.btnNewItem.Click += new System.EventHandler(this.btnNewItem_Click);
            // 
            // listStrings
            // 
            resources.ApplyResources(this.listStrings, "listStrings");
            this.listStrings.AutoScroll = false;
            this.listStrings.DataSource = null;
            this.listStrings.FullRowSelect = true;
            this.listStrings.GridLines = true;
            this.listStrings.HideSelection = false;
            this.listStrings.ItemCount = 0;
            this.listStrings.Name = "listStrings";
            this.listStrings.UseCompatibleStateImageBehavior = false;
            this.listStrings.View = System.Windows.Forms.View.Details;
            this.listStrings.VirtualMode = true;
            this.listStrings.Click += new System.EventHandler(this.listStrings_Click);
            this.listStrings.DoubleClick += new System.EventHandler(this.listStrings_DoubleClick);
            // 
            // btnApply
            // 
            resources.ApplyResources(this.btnApply, "btnApply");
            this.btnApply.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.btnApply.Name = "btnApply";
            this.btnApply.UseVisualStyleBackColor = true;
            this.btnApply.Click += new System.EventHandler(this.btnApply_Click);
            // 
            // error
            // 
            this.error.ContainerControl = this;
            // 
            // StringsEditor
            // 
            this.AcceptButton = this.btnApply;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnClose;
            this.Controls.Add(this.cboType);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.cboPlugins);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnLookup);
            this.Controls.Add(this.txtString);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtID);
            this.Controls.Add(this.btnEditString);
            this.Controls.Add(this.btnApply);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnDeleteString);
            this.Controls.Add(this.btnNewItem);
            this.Controls.Add(this.btnAddString);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.listStrings);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "StringsEditor";
            this.ShowInTaskbar = false;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.StringsEditor_FormClosing);
            this.Load += new System.EventHandler(this.StringsEditor_Load);
            this.ResizeEnd += new System.EventHandler(this.StringsEditor_ResizeEnd);
            ((System.ComponentModel.ISupportInitialize)(this.error)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Windows.Controls.BindingListView listStrings;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnAddString;
        private System.Windows.Forms.TextBox txtID;
        private System.Windows.Forms.TextBox txtString;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnEditString;
        private System.Windows.Forms.ToolTip tip;
        private System.Windows.Forms.ErrorProvider error;
        private System.Windows.Forms.Button btnLookup;
        private System.Windows.Forms.Button btnDeleteString;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox cboPlugins;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.ComboBox cboType;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btnNewItem;
        private System.Windows.Forms.Button btnApply;
    }
}