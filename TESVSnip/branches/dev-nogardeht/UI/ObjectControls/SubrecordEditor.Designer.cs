namespace TESVSnip.UI.ObjectControls
{
    partial class SubrecordEditor
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SubrecordEditor));
            this.fpanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.Error = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).BeginInit();
            this.SuspendLayout();
            // 
            // fpanel1
            // 
            resources.ApplyResources(this.fpanel1, "fpanel1");
            this.fpanel1.Name = "fpanel1";
            this.fpanel1.Resize += new System.EventHandler(this.fpanel1_Resize);
            // 
            // Error
            // 
            this.Error.ContainerControl = this;
            resources.ApplyResources(this.Error, "Error");
            // 
            // SubrecordEditor
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.fpanel1);
            this.MinimumSize = new System.Drawing.Size(300, 200);
            this.Name = "SubrecordEditor";
            this.Load += new System.EventHandler(this.NewMediumLevelRecordEditor_Load);
            ((System.ComponentModel.ISupportInitialize)(this.Error)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.FlowLayoutPanel fpanel1;
        private System.Windows.Forms.ErrorProvider Error;
    }
}
