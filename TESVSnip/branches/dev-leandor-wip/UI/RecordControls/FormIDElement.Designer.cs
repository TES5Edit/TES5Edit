namespace TESVSnip.UI.RecordControls
{
    partial class FormIDElement
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormIDElement));
            this.cboFormID = new System.Windows.Forms.ComboBox();
            this.cboRecType = new System.Windows.Forms.ComboBox();
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // Error
            // 
            resources.ApplyResources(this.Error, "Error");
            // 
            // cboFormID
            // 
            resources.ApplyResources(this.cboFormID, "cboFormID");
            this.cboFormID.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.Error.SetError(this.cboFormID, resources.GetString("cboFormID.Error"));
            this.Error.SetIconAlignment(this.cboFormID, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("cboFormID.IconAlignment"))));
            this.Error.SetIconPadding(this.cboFormID, ((int)(resources.GetObject("cboFormID.IconPadding"))));
            this.cboFormID.Name = "cboFormID";
            this.cboFormID.SelectedIndexChanged += new System.EventHandler(this.cboFormID_SelectedIndexChanged);
            // 
            // cboRecType
            // 
            resources.ApplyResources(this.cboRecType, "cboRecType");
            this.cboRecType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.Error.SetError(this.cboRecType, resources.GetString("cboRecType.Error"));
            this.cboRecType.FormattingEnabled = true;
            this.Error.SetIconAlignment(this.cboRecType, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("cboRecType.IconAlignment"))));
            this.Error.SetIconPadding(this.cboRecType, ((int)(resources.GetObject("cboRecType.IconPadding"))));
            this.cboRecType.Name = "cboRecType";
            this.cboRecType.SelectedIndexChanged += new System.EventHandler(this.cboRecType_SelectedIndexChanged);
            // 
            // FormIDElement
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.cboFormID);
            this.Controls.Add(this.cboRecType);
            this.Error.SetError(this, resources.GetString("$this.Error"));
            this.Error.SetIconAlignment(this, ((System.Windows.Forms.ErrorIconAlignment)(resources.GetObject("$this.IconAlignment"))));
            this.Error.SetIconPadding(this, ((int)(resources.GetObject("$this.IconPadding"))));
            this.MinimumSize = new System.Drawing.Size(200, 48);
            this.Name = "FormIDElement";
            this.SizeChanged += new System.EventHandler(this.FormIDElement_SizeChanged);
            this.Controls.SetChildIndex(this.cboRecType, 0);
            this.Controls.SetChildIndex(this.cboFormID, 0);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cboFormID;
        private System.Windows.Forms.ComboBox cboRecType;
    }
}
