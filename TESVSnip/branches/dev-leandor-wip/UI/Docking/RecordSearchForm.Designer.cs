namespace TESVSnip.UI.Docking
{
    using TESVSnip.UI.ObjectControls;

    partial class RecordSearchForm
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
            this.subrecordPanel = new RecordSearch();
            ((System.ComponentModel.ISupportInitialize)(this.subrecordPanel)).BeginInit();
            this.SuspendLayout();
            // 
            // subrecordPanel
            // 
            this.subrecordPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.subrecordPanel.Location = new System.Drawing.Point(0, 0);
            this.subrecordPanel.MinimumSize = new System.Drawing.Size(200, 120);
            this.subrecordPanel.Name = "subrecordPanel";
            this.subrecordPanel.Size = new System.Drawing.Size(633, 282);
            this.subrecordPanel.TabIndex = 107;
            // 
            // RecordSearchForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(633, 282);
            this.Controls.Add(this.subrecordPanel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
            this.Name = "RecordSearchForm";
            this.ShowHint = WeifenLuo.WinFormsUI.Docking.DockState.DockBottomAutoHide;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Search Records";
            this.Load += new System.EventHandler(this.RecordSearchForm_Load);
            this.Shown += new System.EventHandler(this.RecordSearchForm_Shown);
            ((System.ComponentModel.ISupportInitialize)(this.subrecordPanel)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private RecordSearch subrecordPanel;
    }
}