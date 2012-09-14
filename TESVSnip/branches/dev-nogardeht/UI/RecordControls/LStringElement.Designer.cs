namespace TESVSnip.UI.RecordControls
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LStringElement));
            this.chkUseText = new System.Windows.Forms.CheckBox();
            this.txtString = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // textBox
            // 
            this.textBox.Enter += new System.EventHandler(this.textBox_Enter);
            // 
            // chkUseText
            // 
            resources.ApplyResources(this.chkUseText, "chkUseText");
            this.chkUseText.Name = "chkUseText";
            this.chkUseText.UseVisualStyleBackColor = true;
            // 
            // txtString
            // 
            resources.ApplyResources(this.txtString, "txtString");
            this.txtString.Name = "txtString";
            this.txtString.DoubleClick += new System.EventHandler(this.txtString_DoubleClick);
            this.txtString.Validated += new System.EventHandler(this.txtString_Validated);
            // 
            // LStringElement
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.txtString);
            this.Controls.Add(this.chkUseText);
            this.MinimumSize = new System.Drawing.Size(200, 48);
            this.Name = "LStringElement";
            this.Controls.SetChildIndex(this.textBox, 0);
            this.Controls.SetChildIndex(this.lblText, 0);
            this.Controls.SetChildIndex(this.lblType, 0);
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
