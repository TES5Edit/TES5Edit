namespace TESVSnip.Forms
{
    partial class CompressSettings
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CompressSettings));
            this.btnOk = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.listRecordFilter = new System.Windows.Forms.CheckedListBox();
            this.btnToggleAll = new System.Windows.Forms.Button();
            this.rdoNeverCompressRecords = new System.Windows.Forms.RadioButton();
            this.rdoDefaultCompressRecords = new System.Windows.Forms.RadioButton();
            this.label1 = new System.Windows.Forms.Label();
            this.chkEnableAutoCompress = new System.Windows.Forms.CheckBox();
            this.grpCompSettings = new System.Windows.Forms.GroupBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtCompressLimit = new System.Windows.Forms.MaskedTextBox();
            this.chkEnableCompressLimit = new System.Windows.Forms.CheckBox();
            this.grpCompSettings.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnOk
            // 
            resources.ApplyResources(this.btnOk, "btnOk");
            this.btnOk.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.btnOk.Image = global::TESVSnip.Properties.Resources.fileexport;
            this.btnOk.Name = "btnOk";
            this.btnOk.UseVisualStyleBackColor = true;
            this.btnOk.Click += new System.EventHandler(this.btnOk_Click);
            // 
            // btnCancel
            // 
            resources.ApplyResources(this.btnCancel, "btnCancel");
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Image = global::TESVSnip.Properties.Resources.cancel;
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            // 
            // listRecordFilter
            // 
            resources.ApplyResources(this.listRecordFilter, "listRecordFilter");
            this.listRecordFilter.CheckOnClick = true;
            this.listRecordFilter.MultiColumn = true;
            this.listRecordFilter.Name = "listRecordFilter";
            // 
            // btnToggleAll
            // 
            resources.ApplyResources(this.btnToggleAll, "btnToggleAll");
            this.btnToggleAll.Name = "btnToggleAll";
            this.btnToggleAll.UseVisualStyleBackColor = true;
            this.btnToggleAll.Click += new System.EventHandler(this.btnToggleAll_Click);
            // 
            // rdoNeverCompressRecords
            // 
            resources.ApplyResources(this.rdoNeverCompressRecords, "rdoNeverCompressRecords");
            this.rdoNeverCompressRecords.Name = "rdoNeverCompressRecords";
            this.rdoNeverCompressRecords.TabStop = true;
            this.rdoNeverCompressRecords.UseVisualStyleBackColor = true;
            this.rdoNeverCompressRecords.CheckedChanged += new System.EventHandler(this.rdoNeverCompressRecords_CheckedChanged);
            // 
            // rdoDefaultCompressRecords
            // 
            resources.ApplyResources(this.rdoDefaultCompressRecords, "rdoDefaultCompressRecords");
            this.rdoDefaultCompressRecords.Name = "rdoDefaultCompressRecords";
            this.rdoDefaultCompressRecords.TabStop = true;
            this.rdoDefaultCompressRecords.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // chkEnableAutoCompress
            // 
            resources.ApplyResources(this.chkEnableAutoCompress, "chkEnableAutoCompress");
            this.chkEnableAutoCompress.Name = "chkEnableAutoCompress";
            this.chkEnableAutoCompress.UseVisualStyleBackColor = true;
            this.chkEnableAutoCompress.CheckedChanged += new System.EventHandler(this.chkEnableAutoCompress_CheckedChanged);
            // 
            // grpCompSettings
            // 
            resources.ApplyResources(this.grpCompSettings, "grpCompSettings");
            this.grpCompSettings.Controls.Add(this.label2);
            this.grpCompSettings.Controls.Add(this.txtCompressLimit);
            this.grpCompSettings.Controls.Add(this.listRecordFilter);
            this.grpCompSettings.Controls.Add(this.chkEnableCompressLimit);
            this.grpCompSettings.Controls.Add(this.chkEnableAutoCompress);
            this.grpCompSettings.Controls.Add(this.btnToggleAll);
            this.grpCompSettings.Name = "grpCompSettings";
            this.grpCompSettings.TabStop = false;
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // txtCompressLimit
            // 
            resources.ApplyResources(this.txtCompressLimit, "txtCompressLimit");
            this.txtCompressLimit.Name = "txtCompressLimit";
            // 
            // chkEnableCompressLimit
            // 
            resources.ApplyResources(this.chkEnableCompressLimit, "chkEnableCompressLimit");
            this.chkEnableCompressLimit.Name = "chkEnableCompressLimit";
            this.chkEnableCompressLimit.UseVisualStyleBackColor = true;
            this.chkEnableCompressLimit.CheckedChanged += new System.EventHandler(this.chkEnableCompressLimit_CheckedChanged);
            // 
            // CompressSettings
            // 
            this.AcceptButton = this.btnOk;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.Controls.Add(this.grpCompSettings);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.rdoDefaultCompressRecords);
            this.Controls.Add(this.rdoNeverCompressRecords);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnOk);
            this.Name = "CompressSettings";
            this.ShowInTaskbar = false;
            this.Load += new System.EventHandler(this.LoadSettings_Load);
            this.grpCompSettings.ResumeLayout(false);
            this.grpCompSettings.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnOk;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.CheckedListBox listRecordFilter;
        private System.Windows.Forms.Button btnToggleAll;
        private System.Windows.Forms.RadioButton rdoNeverCompressRecords;
        private System.Windows.Forms.RadioButton rdoDefaultCompressRecords;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.CheckBox chkEnableAutoCompress;
        private System.Windows.Forms.GroupBox grpCompSettings;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.MaskedTextBox txtCompressLimit;
        private System.Windows.Forms.CheckBox chkEnableCompressLimit;

    }
}