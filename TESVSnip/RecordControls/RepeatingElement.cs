using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using TESVSnip.Collections.Generic;

namespace TESVSnip.RecordControls
{
    internal partial class RepeatingElement : BaseElement, IOuterElementControl, IGroupedElementControl
    {
        private IElementControl innerControl;
        private readonly AdvancedList<ArraySegment<byte>> elements = new AdvancedList<ArraySegment<byte>>();
        private readonly BindingSource bs = new BindingSource();
        private bool inUpdatePosition;

        public RepeatingElement()
        {
            InitializeComponent();
            bs.DataSource = elements;
            bindingNavigator.BindingSource = bs;
            bs.CurrentChanged += bs_CurrentChanged;
        }

        private void bs_CurrentChanged(object sender, EventArgs e)
        {
            if (innerControl != null)
            {
                if (bs.Current != null)
                {
                    var data = (ArraySegment<byte>) bs.Current;
                    innerControl.Data = data;
                }
                else
                {
                    innerControl.Data = default(ArraySegment<byte>);
                }
            }
        }

        #region IGroupedElementControl Members

        public IList<ArraySegment<byte>> Elements
        {
            get { return elements; }
        }


        /// <summary>
        /// Data for overall points at 
        /// </summary>
        public override ArraySegment<byte> Data
        {
            get { throw new ApplicationException("Data not valid"); }
            set { throw new ApplicationException("Data not valid"); }
        }

        #endregion

        protected override ArraySegment<byte> GetCurrentData()
        {
            if (bs.Count > 0 && bs.Position >= 0 && bs.Position < bs.Count)
                return elements[bs.Position];
            return default(ArraySegment<byte>);
        }

        /// <summary>
        /// set data for currently selected element
        /// </summary>
        /// <param name="value"></param>
        protected override void SetCurrentData(ArraySegment<byte> value)
        {
            if (!inUpdatePosition)
            {
                if (bs.Count > 0 && bs.Position >= 0 && bs.Position < bs.Count)
                {
                    elements[bs.Position] = value;
                }
            }
        }

        protected override void UpdateElement()
        {
            if (Element != null && !string.IsNullOrEmpty(Element.name))
            {
                groupBox1.Text = string.Format("{0}: {1}", Element.type, Element.name)
                                 + (!string.IsNullOrEmpty(Element.desc) ? (" (" + Element.desc + ")") : "");
            }
        }

        public IElementControl InnerControl
        {
            get { return innerControl; }
            set
            {
                if (innerControl != value)
                {
                    if (innerControl != null)
                        innerControl.DataChanged -= innerControl_DataChanged;

                    innerControl = value;
                    controlPanel.Controls.Clear();
                    var c = innerControl as Control;
                    SuspendLayout();
                    if (c != null)
                    {
                        c.Dock = DockStyle.Fill;
                        c.MinimumSize = new Size(Width - c.Left - 24,
                                                 c.Height - controlPanel.Height + c.MinimumSize.Height + 8);
                        MinimumSize = new Size(Width, Size.Height - controlPanel.Height + c.MinimumSize.Height + 16);
                        controlPanel.MinimumSize = new Size(c.MinimumSize.Width, c.MinimumSize.Height + 8);
                        controlPanel.Controls.Add(c);
                        //this.Size = this.MinimumSize;
                    }
                    ResumeLayout();
                    if (innerControl != null)
                        innerControl.DataChanged += innerControl_DataChanged;
                }
            }
        }

        private void innerControl_DataChanged(object sender, EventArgs e)
        {
            SetCurrentData(innerControl.Data);
        }

        private void RepeatingElement_Resize(object sender, EventArgs e)
        {
            if (innerControl != null)
            {
                var c = innerControl as Control;
                //c.MinimumSize = new Size(this.Width - c.Left - 24, this.MinimumSize.Height);
            }
        }

        private void bindingNavigatorPositionItem_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                e.Handled = true;
            }
        }

        private void bindingNavigatorAddNewItem2_Click(object sender, EventArgs e)
        {
            // save current changes prior to adding new elements
            if (innerControl != null)
                innerControl.CommitChanges();
            if (Element != null)
            {
                var bytes = new byte[0];
                switch (Element.type)
                {
                    case ElementValueType.SByte:
                    case ElementValueType.Byte:
                    case ElementValueType.String:
                    case ElementValueType.LString:
                        bytes = new byte[1];
                        break;
                    case ElementValueType.Float:
                    case ElementValueType.Str4:
                    case ElementValueType.FormID:
                    case ElementValueType.UInt:
                    case ElementValueType.Int:
                    case ElementValueType.IString:
                        bytes = new byte[4];
                        break;
                    case ElementValueType.Short:
                    case ElementValueType.UShort:
                    case ElementValueType.BString:
                        bytes = new byte[2];
                        break;
                }
                elements.Add(new ArraySegment<byte>(bytes));
            }
            else
            {
                elements.Add(default(ArraySegment<byte>));
            }
            try
            {
                inUpdatePosition = true;
                bs.MoveLast();
            }
            finally
            {
                inUpdatePosition = false;
            }
        }
    }
}