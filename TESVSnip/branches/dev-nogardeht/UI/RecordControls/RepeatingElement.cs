namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Collections.Generic;
    using System.Drawing;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework.Collections;

    internal partial class RepeatingElement : BaseElement, IOuterElementControl, IGroupedElementControl
    {
        private readonly BindingSource bs = new BindingSource();

        private readonly AdvancedList<ArraySegment<byte>> elements = new AdvancedList<ArraySegment<byte>>();

        private bool inUpdatePosition;

        private IElementControl innerControl;

        public RepeatingElement()
        {
            this.InitializeComponent();
            this.bs.DataSource = this.elements;
            this.bindingNavigator.BindingSource = this.bs;
            this.bs.CurrentChanged += this.bs_CurrentChanged;
        }

        /// <summary>
        /// Data for overall points at.
        /// </summary>
        /// <value>
        /// The data.
        /// </value>
        public override ArraySegment<byte> Data
        {
            get
            {
                throw new ApplicationException("Data not valid");
            }

            set
            {
                throw new ApplicationException("Data not valid");
            }
        }

        public IList<ArraySegment<byte>> Elements
        {
            get
            {
                return this.elements;
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
                    if (this.innerControl != null)
                    {
                        this.innerControl.DataChanged -= this.innerControl_DataChanged;
                    }

                    this.innerControl = value;
                    this.controlPanel.Controls.Clear();
                    var c = this.innerControl as Control;
                    SuspendLayout();
                    if (c != null)
                    {
                        c.Dock = DockStyle.Fill;
                        c.MinimumSize = new Size(Width - c.Left - 24, c.Height - this.controlPanel.Height + c.MinimumSize.Height + 8);
                        MinimumSize = new Size(Width, Size.Height - this.controlPanel.Height + c.MinimumSize.Height + 16);
                        this.controlPanel.MinimumSize = new Size(c.MinimumSize.Width, c.MinimumSize.Height + 8);
                        this.controlPanel.Controls.Add(c);

                        // this.Size = this.MinimumSize;
                    }

                    ResumeLayout();
                    if (this.innerControl != null)
                    {
                        this.innerControl.DataChanged += this.innerControl_DataChanged;
                    }
                }
            }
        }

        protected override ArraySegment<byte> GetCurrentData()
        {
            if (this.bs.Count > 0 && this.bs.Position >= 0 && this.bs.Position < this.bs.Count)
            {
                return this.elements[this.bs.Position];
            }

            return default(ArraySegment<byte>);
        }

        /// <summary>
        /// Set data for currently selected element.
        /// </summary>
        /// <param name="value">
        /// </param>
        protected override void SetCurrentData(ArraySegment<byte> value)
        {
            if (!this.inUpdatePosition)
            {
                if (this.bs.Count > 0 && this.bs.Position >= 0 && this.bs.Position < this.bs.Count)
                {
                    this.elements[this.bs.Position] = value;
                }
            }
        }

        protected override void UpdateElement()
        {
            if (Element != null && !string.IsNullOrEmpty(Element.name))
            {
                this.groupBox1.Text = string.Format("{0}: {1}", Element.type, Element.name) + (!string.IsNullOrEmpty(Element.desc) ? (" (" + Element.desc + ")") : string.Empty);
            }
        }

        private void RepeatingElement_Resize(object sender, EventArgs e)
        {
            if (this.innerControl != null)
            {
                var c = this.innerControl as Control;

                // c.MinimumSize = new Size(this.Width - c.Left - 24, this.MinimumSize.Height);
            }
        }

        private void bindingNavigatorAddNewItem2_Click(object sender, EventArgs e)
        {
            // save current changes prior to adding new elements
            if (this.innerControl != null)
            {
                this.innerControl.CommitChanges();
            }

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

                this.elements.Add(new ArraySegment<byte>(bytes));
            }
            else
            {
                this.elements.Add(default(ArraySegment<byte>));
            }

            try
            {
                this.inUpdatePosition = true;
                this.bs.MoveLast();
            }
            finally
            {
                this.inUpdatePosition = false;
            }
        }

        private void bindingNavigatorPositionItem_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                e.Handled = true;
            }
        }

        private void bs_CurrentChanged(object sender, EventArgs e)
        {
            if (this.innerControl != null)
            {
                if (this.bs.Current != null)
                {
                    var data = (ArraySegment<byte>)this.bs.Current;
                    this.innerControl.Data = data;
                }
                else
                {
                    this.innerControl.Data = default(ArraySegment<byte>);
                }
            }
        }

        private void innerControl_DataChanged(object sender, EventArgs e)
        {
            this.SetCurrentData(this.innerControl.Data);
        }
    }
}
