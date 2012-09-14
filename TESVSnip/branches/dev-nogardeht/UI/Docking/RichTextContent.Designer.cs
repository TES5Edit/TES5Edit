namespace TESVSnip.UI.Docking
{
    partial class RichTextContent
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
            this.rtfInfo = new RichTextBoxLinks.RichTextBoxEx();
            this.SuspendLayout();
            // 
            // rtfInfo
            // 
            this.rtfInfo.AutoWordSelection = true;
            this.rtfInfo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.rtfInfo.Location = new System.Drawing.Point(0, 0);
            this.rtfInfo.Name = "rtfInfo";
            this.rtfInfo.ReadOnly = true;
            this.rtfInfo.ShortcutsEnabled = false;
            this.rtfInfo.Size = new System.Drawing.Size(376, 504);
            this.rtfInfo.TabIndex = 4;
            this.rtfInfo.Text = "";
            // 
            // RichTextContent
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(376, 504);
            this.ControlBox = false;
            this.Controls.Add(this.rtfInfo);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "RichTextContent";
            this.ShowHint = WeifenLuo.WinFormsUI.Docking.DockState.Document;
            this.ShowInTaskbar = false;
            this.Text = "Report";
            this.ResumeLayout(false);

        }

        #endregion

        private RichTextBoxLinks.RichTextBoxEx rtfInfo;
    }
}