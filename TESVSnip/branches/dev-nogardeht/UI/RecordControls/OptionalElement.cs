namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Drawing;
    using System.Windows.Forms;

    internal partial class OptionalElement : BaseElement, IOuterElementControl
    {
        private IElementControl innerControl;

        public OptionalElement()
        {
            this.InitializeComponent();
            this.chkUseValue.Checked = false;
            this.UpdateStatus();
        }

        public override ArraySegment<byte> Data
        {
            get
            {
                return this.chkUseValue.Checked && this.innerControl != null ? this.innerControl.Data : default(ArraySegment<byte>);
            }

            set
            {
                if (this.InnerControl != null)
                {
                    this.InnerControl.Data = value;
                    this.chkUseValue.Checked = this.innerControl != null && this.innerControl.Data.Count > 0;
                }

                this.UpdateAllControls();
            }
        }

        public IElementControl InnerControl
        {
            get
            {
                return this.innerControl;
            }

            set
            {
                if (this.innerControl != value)
                {
                    this.innerControl = value;
                    this.controlPanel.Controls.Clear();
                    var c = this.innerControl as Control;
                    SuspendLayout();
                    if (c != null)
                    {
                        c.Dock = DockStyle.Fill;
                        this.controlPanel.MinimumSize = c.MinimumSize;
                        this.controlPanel.Controls.Add(c);
                        MinimumSize = this.controlPanel.MinimumSize + new Size(0, this.chkUseValue.Height);
                    }

                    ResumeLayout();
                    this.UpdateStatus();
                }
            }
        }

        protected override void UpdateAllControls()
        {
            base.UpdateAllControls();
            this.UpdateStatus();
        }

        private void UpdateStatus()
        {
            if (this.innerControl == null)
            {
                this.controlPanel.Enabled = false;
            }
            else
            {
                this.controlPanel.Enabled = this.chkUseValue.Checked;
            }
        }

        private void chkUseValue_CheckedChanged(object sender, EventArgs e)
        {
            this.UpdateStatus();
        }
    }
}
