using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WeifenLuo.WinFormsUI.Docking;

namespace TESVSnip.Docking
{
    public partial class BaseDockContent : DockContent
    {
        public BaseDockContent()
        {
            InitializeComponent();
        }

        private void closeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void floatToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.DockState = DockState.Float;
        }

        private void dockAsTabbedDocumentToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.DockState = DockState.Document;
        }

        private void closeToolStripMenuItem_DropDownOpening(object sender, EventArgs e)
        {
        }

        private void dockingMenuStrip_Opening(object sender, CancelEventArgs e)
        {
            this.closeToolStripMenuItem.Enabled = this.CloseButton;
            this.floatToolStripMenuItem.Enabled = this.DockState != DockState.Float && this.IsDockStateValid(DockState.Float);
            this.dockAsTabbedDocumentToolStripMenuItem.Enabled = this.DockState == DockState.Float && this.IsDockStateValid(DockState.Document);
        }
    }
}
