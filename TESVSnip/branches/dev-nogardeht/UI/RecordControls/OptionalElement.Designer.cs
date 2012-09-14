namespace TESVSnip.UI.RecordControls
{
    partial class OptionalElement
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(OptionalElement));
            this.chkUseValue = new System.Windows.Forms.CheckBox();
            this.controlPanel = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // Error
            // 
            resources.ApplyResources(this.Error, "Error");
            // 
            // chkUseValue
            // 
            resources.ApplyResources(this.chkUseValue, "chkUseValue");
            this.Error.SetError(this.chkUseValue, resources.GetString("chkUseValue.Error"));
            this.Error.SetIconAlignment(this.chkUseValue, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("chkUseValue.IconAlignment"))));
            this.Error.SetIconPadding(this.chkUseValue, ((int)(resources.GetObject("chkUseValue.IconPadding"))));
            this.chkUseValue.Name = "chkUseValue";
            this.chkUseValue.UseVisualStyleBackColor = true;
            this.chkUseValue.CheckedChanged += new System.EventHandler(this.chkUseValue_CheckedChanged);
            // 
            // controlPanel
            // 
            resources.ApplyResources(this.controlPanel, "controlPanel");
            this.Error.SetError(this.controlPanel, resources.GetString("controlPanel.Error"));
            this.Error.SetIconAlignment(this.controlPanel, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("controlPanel.IconAlignment"))));
            this.Error.SetIconPadding(this.controlPanel, ((int)(resources.GetObject("controlPanel.IconPadding"))));
            this.controlPanel.Name = "controlPanel";
            // 
            // OptionalElement
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.controlPanel);
            this.Controls.Add(this.chkUseValue);
            this.Error.SetError(this, resources.GetString("$this.Error"));
            this.Error.SetIconAlignment(this, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("$this.IconAlignment"))));
            this.Error.SetIconPadding(this, ((int)(resources.GetObject("$this.IconPadding"))));
            this.MinimumSize = new System.Drawing.Size(250, 46);
            this.Name = "OptionalElement";
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.CheckBox chkUseValue;
        private System.Windows.Forms.Panel controlPanel;
    }
}
