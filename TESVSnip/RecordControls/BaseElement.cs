using System;
using System.Windows.Forms;

namespace TESVSnip.RecordControls
{
    internal partial class BaseElement : UserControl, IElementControl
    {
        private ArraySegment<byte> data;
        protected ElementStructure element;

        public BaseElement()
        {
            InitializeComponent();
        }

        #region IElementControl Members

        public dFormIDLookupR formIDLookup { get; set; }
        public dFormIDScanRec formIDScan { get; set; }
        public dLStringLookup strIDLookup { get; set; }

        public bool Changed { get; set; }

        public ElementStructure Element
        {
            get { return element; }
            set
            {
                element = value;
                UpdateElement();
            }
        }

        public virtual ArraySegment<byte> Data
        {
            get { return GetCurrentData(); }
            set { SetCurrentData(value); }
        }

        protected virtual ArraySegment<byte> GetCurrentData()
        {
            return data;
        }

        public virtual void CommitChanges()
        {
        }

        protected virtual void SetCurrentData(ArraySegment<byte> value)
        {
            var data = GetCurrentData();
            if (!EqualsArraySegment(data, value))
            {
                if (data != null && data.Array != null)
                {
                    Changed = true;
                    // important to clone the data as TypeConverter uses a shared byte array for many operations
                    var blob = new byte[value.Count];
                    if (value.Count > 0)
                        Array.Copy(value.Array, value.Offset, blob, 0, value.Count);
                    this.data = new ArraySegment<byte>(blob);
                }
                else
                {
                    this.data = value;
                }
                UpdateAllControls();
                if (DataChanged != null)
                {
                    DataChanged(this, EventArgs.Empty);
                }
            }
        }

        public event EventHandler DataChanged;

        private bool EqualsArraySegment<T>(ArraySegment<T> first, ArraySegment<T> second)
        {
            if (first.Count != second.Count) return false;
            for (int i = 0; i < first.Count; ++i)
                if (!first.Array[first.Offset + i].Equals(second.Array[second.Offset + i]))
                    return false;
            return true;
        }

        protected virtual void UpdateElement()
        {
        }

        protected virtual void UpdateAllControls()
        {
        }

        #endregion

        private void BaseElement_Enter(object sender, EventArgs e)
        {
            // forward focus to first child control
            foreach (Control c in Controls)
            {
                if (c.CanFocus)
                    c.Focus();
            }
        }
    }
}