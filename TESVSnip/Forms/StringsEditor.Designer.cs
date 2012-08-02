namespace TESVSnip.Forms
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
            if (disposing && (components != null))
            {
                components.Dispose();
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
            this.error = new System.Windows.Forms.ErrorProvider(this.components);
            this.label3 = new System.Windows.Forms.Label();
            this.cboPlugins = new System.Windows.Forms.ComboBox();
            this.btnClose = new System.Windows.Forms.Button();
            this.cboType = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.btnNewItem = new System.Windows.Forms.Button();
            this.listStrings = new TESVSnip.Windows.Controls.BindingListView();
            this.btnApply = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.error)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.error.SetError(this.label1, resources.GetString("label1.Error"));
            this.error.SetIconAlignment(this.label1, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("label1.IconAlignment"))));
            this.error.SetIconPadding(this.label1, ((int)(resources.GetObject("label1.IconPadding"))));
            this.label1.Name = "label1";
            this.tip.SetToolTip(this.label1, resources.GetString("label1.ToolTip"));
            // 
            // btnAddString
            // 
            resources.ApplyResources(this.btnAddString, "btnAddString");
            this.error.SetError(this.btnAddString, resources.GetString("btnAddString.Error"));
            this.error.SetIconAlignment(this.btnAddString, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("btnAddString.IconAlignment"))));
            this.error.SetIconPadding(this.btnAddString, ((int)(resources.GetObject("btnAddString.IconPadding"))));
            this.btnAddString.Image = global::TESVSnip.Properties.Resources.edit_add;
            this.btnAddString.Name = "btnAddString";
            this.tip.SetToolTip(this.btnAddString, resources.GetString("btnAddString.ToolTip"));
            this.btnAddString.UseVisualStyleBackColor = true;
            this.btnAddString.Click += new System.EventHandler(this.btnAddString_Click);
            // 
            // txtID
            // 
            resources.ApplyResources(this.txtID, "txtID");
            this.error.SetError(this.txtID, resources.GetString("txtID.Error"));
            this.error.SetIconAlignment(this.txtID, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("txtID.IconAlignment"))));
            this.error.SetIconPadding(this.txtID, ((int)(resources.GetObject("txtID.IconPadding"))));
            this.txtID.Name = "txtID";
            this.tip.SetToolTip(this.txtID, resources.GetString("txtID.ToolTip"));
            this.txtID.TextChanged += new System.EventHandler(this.txtID_TextChanged);
            this.txtID.Validating += new System.ComponentModel.CancelEventHandler(this.txtID_Validating);
            // 
            // txtString
            // 
            resources.ApplyResources(this.txtString, "txtString");
            this.error.SetError(this.txtString, resources.GetString("txtString.Error"));
            this.error.SetIconAlignment(this.txtString, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("txtString.IconAlignment"))));
            this.error.SetIconPadding(this.txtString, ((int)(resources.GetObject("txtString.IconPadding"))));
            this.txtString.Name = "txtString";
            this.tip.SetToolTip(this.txtString, resources.GetString("txtString.ToolTip"));
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.error.SetError(this.label2, resources.GetString("label2.Error"));
            this.error.SetIconAlignment(this.label2, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("label2.IconAlignment"))));
            this.error.SetIconPadding(this.label2, ((int)(resources.GetObject("label2.IconPadding"))));
            this.label2.Name = "label2";
            this.tip.SetToolTip(this.label2, resources.GetString("label2.ToolTip"));
            // 
            // btnEditString
            // 
            resources.ApplyResources(this.btnEditString, "btnEditString");
            this.error.SetError(this.btnEditString, resources.GetString("btnEditString.Error"));
            this.error.SetIconAlignment(this.btnEditString, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("btnEditString.IconAlignment"))));
            this.error.SetIconPadding(this.btnEditString, ((int)(resources.GetObject("btnEditString.IconPadding"))));
            this.btnEditString.Name = "btnEditString";
            this.tip.SetToolTip(this.btnEditString, resources.GetString("btnEditString.ToolTip"));
            this.btnEditString.UseVisualStyleBackColor = true;
            this.btnEditString.Click += new System.EventHandler(this.btnEditString_Click);
            // 
            // btnLookup
            // 
            resources.ApplyResources(this.btnLookup, "btnLookup");
            this.error.SetError(this.btnLookup, resources.GetString("btnLookup.Error"));
            this.error.SetIconAlignment(this.btnLookup, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("btnLookup.IconAlignment"))));
            this.error.SetIconPadding(this.btnLookup, ((int)(resources.GetObject("btnLookup.IconPadding"))));
            this.btnLookup.Image = global::TESVSnip.Properties.Resources.find;
            this.btnLookup.Name = "btnLookup";
            this.tip.SetToolTip(this.btnLookup, resources.GetString("btnLookup.ToolTip"));
            this.btnLookup.UseVisualStyleBackColor = true;
            this.btnLookup.Click += new System.EventHandler(this.btnLookup_Click);
            // 
            // btnDeleteString
            // 
            resources.ApplyResources(this.btnDeleteString, "btnDeleteString");
            this.error.SetError(this.btnDeleteString, resources.GetString("btnDeleteString.Error"));
            this.error.SetIconAlignment(this.btnDeleteString, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("btnDeleteString.IconAlignment"))));
            this.error.SetIconPadding(this.btnDeleteString, ((int)(resources.GetObject("btnDeleteString.IconPadding"))));
            this.btnDeleteString.Image = global::TESVSnip.Properties.Resources.edit_remove;
            this.btnDeleteString.Name = "btnDeleteString";
            this.tip.SetToolTip(this.btnDeleteString, resources.GetString("btnDeleteString.ToolTip"));
            this.btnDeleteString.UseVisualStyleBackColor = true;
            this.btnDeleteString.Click += new System.EventHandler(this.btnDeleteString_Click);
            // 
            // error
            // 
            this.error.ContainerControl = this;
            resources.ApplyResources(this.error, "error");
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.error.SetError(this.label3, resources.GetString("label3.Error"));
            this.error.SetIconAlignment(this.label3, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("label3.IconAlignment"))));
            this.error.SetIconPadding(this.label3, ((int)(resources.GetObject("label3.IconPadding"))));
            this.label3.Name = "label3";
            this.tip.SetToolTip(this.label3, resources.GetString("label3.ToolTip"));
            // 
            // cboPlugins
            // 
            resources.ApplyResources(this.cboPlugins, "cboPlugins");
            this.cboPlugins.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.error.SetError(this.cboPlugins, resources.GetString("cboPlugins.Error"));
            this.cboPlugins.FormattingEnabled = true;
            this.error.SetIconAlignment(this.cboPlugins, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("cboPlugins.IconAlignment"))));
            this.error.SetIconPadding(this.cboPlugins, ((int)(resources.GetObject("cboPlugins.IconPadding"))));
            this.cboPlugins.Name = "cboPlugins";
            this.tip.SetToolTip(this.cboPlugins, resources.GetString("cboPlugins.ToolTip"));
            // 
            // btnClose
            // 
            resources.ApplyResources(this.btnClose, "btnClose");
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.error.SetError(this.btnClose, resources.GetString("btnClose.Error"));
            this.error.SetIconAlignment(this.btnClose, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("btnClose.IconAlignment"))));
            this.error.SetIconPadding(this.btnClose, ((int)(resources.GetObject("btnClose.IconPadding"))));
            this.btnClose.Name = "btnClose";
            this.tip.SetToolTip(this.btnClose, resources.GetString("btnClose.ToolTip"));
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.button1_Click);
            // 
            // cboType
            // 
            resources.ApplyResources(this.cboType, "cboType");
            this.cboType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.error.SetError(this.cboType, resources.GetString("cboType.Error"));
            this.cboType.FormattingEnabled = true;
            this.error.SetIconAlignment(this.cboType, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("cboType.IconAlignment"))));
            this.error.SetIconPadding(this.cboType, ((int)(resources.GetObject("cboType.IconPadding"))));
            this.cboType.Name = "cboType";
            this.tip.SetToolTip(this.cboType, resources.GetString("cboType.ToolTip"));
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.error.SetError(this.label4, resources.GetString("label4.Error"));
            this.error.SetIconAlignment(this.label4, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("label4.IconAlignment"))));
            this.error.SetIconPadding(this.label4, ((int)(resources.GetObject("label4.IconPadding"))));
            this.label4.Name = "label4";
            this.tip.SetToolTip(this.label4, resources.GetString("label4.ToolTip"));
            // 
            // btnNewItem
            // 
            resources.ApplyResources(this.btnNewItem, "btnNewItem");
            this.error.SetError(this.btnNewItem, resources.GetString("btnNewItem.Error"));
            this.error.SetIconAlignment(this.btnNewItem, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("btnNewItem.IconAlignment"))));
            this.error.SetIconPadding(this.btnNewItem, ((int)(resources.GetObject("btnNewItem.IconPadding"))));
            this.btnNewItem.Image = global::TESVSnip.Properties.Resources.insertcell;
            this.btnNewItem.Name = "btnNewItem";
            this.tip.SetToolTip(this.btnNewItem, resources.GetString("btnNewItem.ToolTip"));
            this.btnNewItem.UseVisualStyleBackColor = true;
            this.btnNewItem.Click += new System.EventHandler(this.btnNewItem_Click);
            // 
            // listStrings
            // 
            resources.ApplyResources(this.listStrings, "listStrings");
            this.listStrings.AutoScroll = false;
            this.listStrings.DataSource = null;
            this.error.SetError(this.listStrings, resources.GetString("listStrings.Error"));
            this.listStrings.FullRowSelect = true;
            this.listStrings.GridLines = true;
            this.listStrings.HideSelection = false;
            this.error.SetIconAlignment(this.listStrings, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("listStrings.IconAlignment"))));
            this.error.SetIconPadding(this.listStrings, ((int)(resources.GetObject("listStrings.IconPadding"))));
            this.listStrings.ItemCount = 0;
            this.listStrings.Name = "listStrings";
            this.tip.SetToolTip(this.listStrings, resources.GetString("listStrings.ToolTip"));
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
            this.error.SetError(this.btnApply, resources.GetString("btnApply.Error"));
            this.error.SetIconAlignment(this.btnApply, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("btnApply.IconAlignment"))));
            this.error.SetIconPadding(this.btnApply, ((int)(resources.GetObject("btnApply.IconPadding"))));
            this.btnApply.Name = "btnApply";
            this.tip.SetToolTip(this.btnApply, resources.GetString("btnApply.ToolTip"));
            this.btnApply.UseVisualStyleBackColor = true;
            this.btnApply.Click += new System.EventHandler(this.btnApply_Click);
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
            this.tip.SetToolTip(this, resources.GetString("$this.ToolTip"));
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