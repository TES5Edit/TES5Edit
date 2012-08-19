namespace TESVSnip.UI.Docking
{
    using TESVSnip.UI.ObjectControls;

    partial class PluginTreeContent
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PluginTreeContent));
            this.pluginTreeControl = new PluginTreeView();
            ((System.ComponentModel.ISupportInitialize)(this.pluginTreeControl)).BeginInit();
            this.SuspendLayout();
            // 
            // pluginTreeControl
            // 
            resources.ApplyResources(this.pluginTreeControl, "pluginTreeControl");
            this.pluginTreeControl.Name = "pluginTreeControl";
            this.pluginTreeControl.SelectedRecord = null;
            // 
            // PluginTreeContent
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CloseButton = false;
            this.CloseButtonVisible = false;
            this.Controls.Add(this.pluginTreeControl);
            this.DockAreas = ((WeifenLuo.WinFormsUI.Docking.DockAreas)(((((WeifenLuo.WinFormsUI.Docking.DockAreas.Float | WeifenLuo.WinFormsUI.Docking.DockAreas.DockLeft) 
            | WeifenLuo.WinFormsUI.Docking.DockAreas.DockRight) 
            | WeifenLuo.WinFormsUI.Docking.DockAreas.DockTop) 
            | WeifenLuo.WinFormsUI.Docking.DockAreas.DockBottom)));
            this.HideOnClose = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "PluginTreeContent";
            this.ShowHint = WeifenLuo.WinFormsUI.Docking.DockState.DockLeft;
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            ((System.ComponentModel.ISupportInitialize)(this.pluginTreeControl)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private PluginTreeView pluginTreeControl;
    }
}