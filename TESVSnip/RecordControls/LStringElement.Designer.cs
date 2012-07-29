namespace TESVSnip.RecordControls
{
    partial class LStringElement
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LStringElement));
            this.chkUseText = new System.Windows.Forms.CheckBox();
            this.txtString = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // Error
            // 
            resources.ApplyResources(this.Error, "Error");
            // 
            // chkUseText
            // 
            resources.ApplyResources(this.chkUseText, "chkUseText");
            this.Error.SetError(this.chkUseText, resources.GetString("chkUseText.Error"));
            this.Error.SetIconAlignment(this.chkUseText, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("chkUseText.IconAlignment"))));
            this.Error.SetIconPadding(this.chkUseText, ((int)(resources.GetObject("chkUseText.IconPadding"))));
            this.chkUseText.Name = "chkUseText";
            this.chkUseText.UseVisualStyleBackColor = true;
            // 
            // txtString
            // 
            resources.ApplyResources(this.txtString, "txtString");
            this.Error.SetError(this.txtString, resources.GetString("txtString.Error"));
            this.Error.SetIconAlignment(this.txtString, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("txtString.IconAlignment"))));
            this.Error.SetIconPadding(this.txtString, ((int)(resources.GetObject("txtString.IconPadding"))));
            this.txtString.Name = "txtString";
            this.txtString.Validated += new System.EventHandler(this.txtString_Validated);
            // 
            // LStringElement
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.txtString);
            this.Controls.Add(this.chkUseText);
            this.Error.SetError(this, resources.GetString("$this.Error"));
            this.Error.SetIconAlignment(this, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("$this.IconAlignment"))));
            this.Error.SetIconPadding(this, ((int)(resources.GetObject("$this.IconPadding"))));
            this.MinimumSize = new System.Drawing.Size(200, 48);
            this.Name = "LStringElement";
            this.Controls.SetChildIndex(this.chkUseText, 0);
            this.Controls.SetChildIndex(this.txtString, 0);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.CheckBox chkUseText;
        private System.Windows.Forms.TextBox txtString;

    }
}
