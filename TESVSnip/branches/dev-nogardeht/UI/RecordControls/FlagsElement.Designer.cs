namespace TESVSnip.UI.RecordControls
{
    using TESVSnip.Windows.Controls;

    partial class FlagsElement
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FlagsElement));
            this.cboFlags = new TESVSnip.Windows.Controls.FlagComboBox();
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // cboFlags
            // 
            this.cboFlags.AllowResizeDropDown = true;
            resources.ApplyResources(this.cboFlags, "cboFlags");
            this.cboFlags.CheckOnClick = true;
            this.cboFlags.ControlSize = new System.Drawing.Size(47, 16);
            this.cboFlags.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawVariable;
            this.cboFlags.DropDownSizeMode = TESVSnip.Windows.Controls.CustomComboBox.SizeMode.UseDropDownSize;
            this.cboFlags.DropSize = new System.Drawing.Size(121, 106);
            this.cboFlags.FormattingEnabled = true;
            this.cboFlags.Name = "cboFlags";
            this.cboFlags.ValueSeparator = ",";
            this.cboFlags.ItemCheck += new System.Windows.Forms.ItemCheckEventHandler(this.cboFlags_ItemCheck);
            // 
            // FlagsElement
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.cboFlags);
            this.MinimumSize = new System.Drawing.Size(200, 48);
            this.Name = "FlagsElement";
            this.Controls.SetChildIndex(this.cboFlags, 0);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private FlagComboBox cboFlags;


    }
}
