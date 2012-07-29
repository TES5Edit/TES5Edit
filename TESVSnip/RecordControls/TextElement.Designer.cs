namespace TESVSnip.RecordControls
{
    partial class TextElement
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(TextElement));
            this.textBox = new System.Windows.Forms.TextBox();
            this.lblText = new System.Windows.Forms.Label();
            this.lblType = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // Error
            // 
            resources.ApplyResources(this.Error, "Error");
            // 
            // textBox
            // 
            resources.ApplyResources(this.textBox, "textBox");
            this.Error.SetError(this.textBox, resources.GetString("textBox.Error"));
            this.Error.SetIconAlignment(this.textBox, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("textBox.IconAlignment"))));
            this.Error.SetIconPadding(this.textBox, ((int)(resources.GetObject("textBox.IconPadding"))));
            this.textBox.Name = "textBox";
            this.textBox.Validated += new System.EventHandler(this.textBox_Validated);
            // 
            // lblText
            // 
            resources.ApplyResources(this.lblText, "lblText");
            this.Error.SetError(this.lblText, resources.GetString("lblText.Error"));
            this.Error.SetIconAlignment(this.lblText, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("lblText.IconAlignment"))));
            this.Error.SetIconPadding(this.lblText, ((int)(resources.GetObject("lblText.IconPadding"))));
            this.lblText.Name = "lblText";
            // 
            // lblType
            // 
            resources.ApplyResources(this.lblType, "lblType");
            this.Error.SetError(this.lblType, resources.GetString("lblType.Error"));
            this.Error.SetIconAlignment(this.lblType, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("lblType.IconAlignment"))));
            this.Error.SetIconPadding(this.lblType, ((int)(resources.GetObject("lblType.IconPadding"))));
            this.lblType.Name = "lblType";
            // 
            // TextElement
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.lblType);
            this.Controls.Add(this.lblText);
            this.Controls.Add(this.textBox);
            this.Error.SetError(this, resources.GetString("$this.Error"));
            this.Error.SetIconAlignment(this, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("$this.IconAlignment"))));
            this.Error.SetIconPadding(this, ((int)(resources.GetObject("$this.IconPadding"))));
            this.Name = "TextElement";
            this.Load += new System.EventHandler(this.TextElement_Load);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox;
        private System.Windows.Forms.Label lblText;
        private System.Windows.Forms.Label lblType;
    }
}
