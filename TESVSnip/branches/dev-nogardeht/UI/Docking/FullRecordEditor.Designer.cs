namespace TESVSnip.UI.Docking
{
    using TESVSnip.UI.ObjectControls;

    partial class FullRecordEditor
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
            this.panelRecordEditor = new RecordEditor();
            this.SuspendLayout();
            // 
            // panelRecordEditor
            // 
            this.panelRecordEditor.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelRecordEditor.Location = new System.Drawing.Point(0, 0);
            this.panelRecordEditor.Name = "panelRecordEditor";
            this.panelRecordEditor.Record = null;
            this.panelRecordEditor.Size = new System.Drawing.Size(692, 384);
            this.panelRecordEditor.TabIndex = 0;
            // 
            // FullRecordEditor
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(692, 384);
            this.Controls.Add(this.panelRecordEditor);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
            this.Name = "FullRecordEditor";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Full Record Editor";
            this.DockStateChanged += new System.EventHandler(this.FullRecordEditor_DockStateChanged);
            this.ResumeLayout(false);

        }

        #endregion

        private RecordEditor panelRecordEditor;
    }
}