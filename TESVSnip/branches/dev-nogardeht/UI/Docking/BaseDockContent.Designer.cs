namespace TESVSnip.UI.Docking
{
    partial class BaseDockContent
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(BaseDockContent));
            this.dockingMenuStrip = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.closeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.floatToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dockAsTabbedDocumentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.dockingMenuStrip.SuspendLayout();
            this.SuspendLayout();
            // 
            // dockingMenuStrip
            // 
            this.dockingMenuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.closeToolStripMenuItem,
            this.toolStripMenuItem1,
            this.floatToolStripMenuItem,
            this.dockAsTabbedDocumentToolStripMenuItem});
            this.dockingMenuStrip.Name = "dockingMenuStrip";
            this.dockingMenuStrip.Size = new System.Drawing.Size(218, 98);
            this.dockingMenuStrip.Opening += new System.ComponentModel.CancelEventHandler(this.dockingMenuStrip_Opening);
            // 
            // closeToolStripMenuItem
            // 
            this.closeToolStripMenuItem.Name = "closeToolStripMenuItem";
            this.closeToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.F4)));
            this.closeToolStripMenuItem.Size = new System.Drawing.Size(217, 22);
            this.closeToolStripMenuItem.Text = "&Close";
            this.closeToolStripMenuItem.DropDownOpening += new System.EventHandler(this.closeToolStripMenuItem_DropDownOpening);
            this.closeToolStripMenuItem.Click += new System.EventHandler(this.closeToolStripMenuItem_Click);
            // 
            // floatToolStripMenuItem
            // 
            this.floatToolStripMenuItem.Name = "floatToolStripMenuItem";
            this.floatToolStripMenuItem.Size = new System.Drawing.Size(217, 22);
            this.floatToolStripMenuItem.Text = "Float";
            this.floatToolStripMenuItem.Click += new System.EventHandler(this.floatToolStripMenuItem_Click);
            // 
            // dockAsTabbedDocumentToolStripMenuItem
            // 
            this.dockAsTabbedDocumentToolStripMenuItem.Name = "dockAsTabbedDocumentToolStripMenuItem";
            this.dockAsTabbedDocumentToolStripMenuItem.Size = new System.Drawing.Size(217, 22);
            this.dockAsTabbedDocumentToolStripMenuItem.Text = "Dock as Tabbed Document";
            this.dockAsTabbedDocumentToolStripMenuItem.Click += new System.EventHandler(this.dockAsTabbedDocumentToolStripMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(214, 6);
            // 
            // BaseDockContent
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(337, 242);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "BaseDockContent";
            this.TabPageContextMenuStrip = this.dockingMenuStrip;
            this.Text = "BaseDockContent";
            this.dockingMenuStrip.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        protected System.Windows.Forms.ContextMenuStrip dockingMenuStrip;
        private System.Windows.Forms.ToolStripMenuItem closeToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem floatToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dockAsTabbedDocumentToolStripMenuItem;
    }
}