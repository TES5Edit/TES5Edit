namespace TESVSnip.UI.Docking
{
    using System;
    using System.ComponentModel;

    using WeifenLuo.WinFormsUI.Docking;

    public partial class BaseDockContent : DockContent
    {
        public BaseDockContent()
        {
            this.InitializeComponent();
        }

        private void closeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void closeToolStripMenuItem_DropDownOpening(object sender, EventArgs e)
        {
        }

        private void dockAsTabbedDocumentToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DockState = DockState.Document;
        }

        private void dockingMenuStrip_Opening(object sender, CancelEventArgs e)
        {
            this.closeToolStripMenuItem.Enabled = CloseButton;
            this.floatToolStripMenuItem.Enabled = DockState != DockState.Float && IsDockStateValid(DockState.Float);
            this.dockAsTabbedDocumentToolStripMenuItem.Enabled = DockState == DockState.Float && IsDockStateValid(DockState.Document);
        }

        private void floatToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DockState = DockState.Float;
        }
    }
}
