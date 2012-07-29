using System;
using System.Drawing;
using System.Windows.Forms;

namespace TESVSnip.RecordControls
{
    internal partial class OptionalElement : BaseElement, IOuterElementControl
    {
        private IElementControl innerControl;

        public OptionalElement()
        {
            InitializeComponent();
            chkUseValue.Checked = false;
            UpdateStatus();
        }

        public override ArraySegment<byte> Data
        {
            get
            {
                return chkUseValue.Checked && innerControl != null
                           ? innerControl.Data
                           : default(ArraySegment<byte>);
            }
            set
            {
                if (InnerControl != null)
                {
                    InnerControl.Data = value;
                    chkUseValue.Checked = innerControl != null && innerControl.Data.Count > 0;
                }
                UpdateAllControls();
            }
        }

        public IElementControl InnerControl
        {
            get { return innerControl; }
            set
            {
                if (innerControl != value)
                {
                    innerControl = value;
                    controlPanel.Controls.Clear();
                    var c = innerControl as Control;
                    SuspendLayout();
                    if (c != null)
                    {
                        c.Dock = DockStyle.Fill;
                        controlPanel.MinimumSize = c.MinimumSize;
                        controlPanel.Controls.Add(c);
                        MinimumSize = controlPanel.MinimumSize + new Size(0, chkUseValue.Height);
                    }
                    ResumeLayout();
                    UpdateStatus();
                }
            }
        }

        private void chkUseValue_CheckedChanged(object sender, EventArgs e)
        {
            UpdateStatus();
        }

        private void UpdateStatus()
        {
            if (innerControl == null)
                controlPanel.Enabled = false;
            else
                controlPanel.Enabled = chkUseValue.Checked;
        }

        protected override void UpdateAllControls()
        {
            base.UpdateAllControls();
            UpdateStatus();
        }
    }
}