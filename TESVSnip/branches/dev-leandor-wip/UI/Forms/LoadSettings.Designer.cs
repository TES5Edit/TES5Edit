namespace TESVSnip.UI.Forms
{
    partial class LoadSettings
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LoadSettings));
            this.btnOk = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.rtfWarning = new System.Windows.Forms.RichTextBox();
            this.chkApplyToAllESM = new System.Windows.Forms.CheckBox();
            this.chkDontAskAboutFiltering = new System.Windows.Forms.CheckBox();
            this.checkBox1 = new System.Windows.Forms.CheckBox();
            this.listRecordFilter = new System.Windows.Forms.CheckedListBox();
            this.btnToggleAll = new System.Windows.Forms.Button();
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
            // rtfWarning
            // 
            resources.ApplyResources(this.rtfWarning, "rtfWarning");
            this.rtfWarning.Name = "rtfWarning";
            this.rtfWarning.ReadOnly = true;
            this.rtfWarning.TextChanged += new System.EventHandler(this.richTextBox1_TextChanged);
            // 
            // chkApplyToAllESM
            // 
            resources.ApplyResources(this.chkApplyToAllESM, "chkApplyToAllESM");
            this.chkApplyToAllESM.Name = "chkApplyToAllESM";
            this.chkApplyToAllESM.UseVisualStyleBackColor = true;
            // 
            // chkDontAskAboutFiltering
            // 
            resources.ApplyResources(this.chkDontAskAboutFiltering, "chkDontAskAboutFiltering");
            this.chkDontAskAboutFiltering.Checked = true;
            this.chkDontAskAboutFiltering.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkDontAskAboutFiltering.Name = "chkDontAskAboutFiltering";
            this.chkDontAskAboutFiltering.UseVisualStyleBackColor = true;
            // 
            // checkBox1
            // 
            resources.ApplyResources(this.checkBox1, "checkBox1");
            this.checkBox1.Name = "checkBox1";
            this.checkBox1.UseVisualStyleBackColor = true;
            this.checkBox1.CheckedChanged += new System.EventHandler(this.checkBox1_CheckedChanged);
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
            // LoadSettings
            // 
            this.AcceptButton = this.btnOk;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.Controls.Add(this.btnToggleAll);
            this.Controls.Add(this.listRecordFilter);
            this.Controls.Add(this.checkBox1);
            this.Controls.Add(this.chkDontAskAboutFiltering);
            this.Controls.Add(this.chkApplyToAllESM);
            this.Controls.Add(this.rtfWarning);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnOk);
            this.Name = "LoadSettings";
            this.ShowInTaskbar = false;
            this.Load += new System.EventHandler(this.LoadSettings_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnOk;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.RichTextBox rtfWarning;
        private System.Windows.Forms.CheckBox chkApplyToAllESM;
        private System.Windows.Forms.CheckBox chkDontAskAboutFiltering;
        private System.Windows.Forms.CheckBox checkBox1;
        private System.Windows.Forms.CheckedListBox listRecordFilter;
        private System.Windows.Forms.Button btnToggleAll;

    }
}