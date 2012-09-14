namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;

    internal partial class BaseElement : UserControl, IElementControl
    {
        protected ElementStructure element;

        private ArraySegment<byte> data;

        public BaseElement()
        {
            this.InitializeComponent();
        }

        public event EventHandler DataChanged;

        public bool Changed { get; set; }

        public virtual ArraySegment<byte> Data
        {
            get
            {
                return this.GetCurrentData();
            }

            set
            {
                this.SetCurrentData(value);
            }
        }

        public ElementStructure Element
        {
            get
            {
                return this.element;
            }

            set
            {
                this.element = value;
                this.UpdateElement();
            }
        }

        public dFormIDLookupR formIDLookup { get; set; }

        public dFormIDScanRec formIDScan { get; set; }

        public dLStringLookup strIDLookup { get; set; }

        public virtual void CommitChanges()
        {
        }

        protected virtual ArraySegment<byte> GetCurrentData()
        {
            return this.data;
        }

        protected virtual void SetCurrentData(ArraySegment<byte> value)
        {
            var data = this.GetCurrentData();
            if (!this.EqualsArraySegment(data, value))
            {
                if (data != null && data.Array != null)
                {
                    this.Changed = true;

                    // important to clone the data as TypeConverter uses a shared byte array for many operations
                    var blob = new byte[value.Count];
                    if (value.Count > 0)
                    {
                        Array.Copy(value.Array, value.Offset, blob, 0, value.Count);
                    }

                    this.data = new ArraySegment<byte>(blob);
                }
                else
                {
                    this.data = value;
                }

                this.UpdateAllControls();
                if (this.DataChanged != null)
                {
                    this.DataChanged(this, EventArgs.Empty);
                }
            }
        }

        protected virtual void UpdateAllControls()
        {
        }

        protected virtual void UpdateElement()
        {
        }

        private void BaseElement_Enter(object sender, EventArgs e)
        {
            // forward focus to first child control
            foreach (Control c in Controls)
            {
                if (c.CanFocus)
                {
                    c.Focus();
                }
            }
        }

        private bool EqualsArraySegment<T>(ArraySegment<T> first, ArraySegment<T> second)
        {
            if (first.Count != second.Count)
            {
                return false;
            }

            for (int i = 0; i < first.Count; ++i)
            {
                if (!first.Array[first.Offset + i].Equals(second.Array[second.Offset + i]))
                {
                    return false;
                }
            }

            return true;
        }
    }
}
