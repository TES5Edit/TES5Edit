namespace TESVSnip.UI.Docking
{
    using TESVSnip.UI.ObjectControls;

    partial class SubrecordListContent
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SubrecordListContent));
            this.subrecordPanel = new SubrecordListEditor();
            ((System.ComponentModel.ISupportInitialize)(this.subrecordPanel)).BeginInit();
            this.SuspendLayout();
            // 
            // subrecordPanel
            // 
            resources.ApplyResources(this.subrecordPanel, "subrecordPanel");
            this.subrecordPanel.MinimumSize = new System.Drawing.Size(192, 120);
            this.subrecordPanel.Name = "subrecordPanel";
            this.subrecordPanel.SubRecords = null;
            // 
            // SubrecordListContent
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CloseButton = false;
            this.CloseButtonVisible = false;
            this.Controls.Add(this.subrecordPanel);
            this.DockAreas = ((WeifenLuo.WinFormsUI.Docking.DockAreas)(((((WeifenLuo.WinFormsUI.Docking.DockAreas.Float | WeifenLuo.WinFormsUI.Docking.DockAreas.DockLeft) 
            | WeifenLuo.WinFormsUI.Docking.DockAreas.DockRight) 
            | WeifenLuo.WinFormsUI.Docking.DockAreas.DockTop) 
            | WeifenLuo.WinFormsUI.Docking.DockAreas.DockBottom)));
            this.HideOnClose = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "SubrecordListContent";
            this.ShowHint = WeifenLuo.WinFormsUI.Docking.DockState.DockLeft;
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            ((System.ComponentModel.ISupportInitialize)(this.subrecordPanel)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private SubrecordListEditor subrecordPanel;
    }
}