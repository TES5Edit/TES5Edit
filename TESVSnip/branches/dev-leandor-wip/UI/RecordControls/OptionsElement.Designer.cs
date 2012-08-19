namespace TESVSnip.UI.RecordControls
{
    partial class OptionsElement
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(OptionsElement));
            this.cboOptions = new System.Windows.Forms.ComboBox();
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // Error
            // 
            resources.ApplyResources(this.Error, "Error");
            // 
            // cboOptions
            // 
            resources.ApplyResources(this.cboOptions, "cboOptions");
            this.cboOptions.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.Error.SetError(this.cboOptions, resources.GetString("cboOptions.Error"));
            this.cboOptions.FormattingEnabled = true;
            this.Error.SetIconAlignment(this.cboOptions, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("cboOptions.IconAlignment"))));
            this.Error.SetIconPadding(this.cboOptions, ((int)(resources.GetObject("cboOptions.IconPadding"))));
            this.cboOptions.Name = "cboOptions";
            this.cboOptions.SelectedIndexChanged += new System.EventHandler(this.cboOptions_SelectedIndexChanged);
            this.cboOptions.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.cboOptions_KeyPress);
            // 
            // OptionsElement
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.cboOptions);
            this.Error.SetError(this, resources.GetString("$this.Error"));
            this.Error.SetIconAlignment(this, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("$this.IconAlignment"))));
            this.Error.SetIconPadding(this, ((int)(resources.GetObject("$this.IconPadding"))));
            this.MinimumSize = new System.Drawing.Size(200, 48);
            this.Name = "OptionsElement";
            this.Controls.SetChildIndex(this.cboOptions, 0);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cboOptions;


    }
}
