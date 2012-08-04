using System;
using System.Linq;

namespace TESVSnip.RecordControls
{
    internal partial class FormIDElement : TextElement
    {
        private class comboBoxItem
        {
            public readonly string name;
            public readonly uint value;

            public comboBoxItem(string name, uint value)
            {
                this.name = name;
                this.value = value;
            }

            public override string ToString()
            {
                return name;
            }
        }

        private bool inSelChange;
        private bool inUpdateText;

        public FormIDElement()
        {
            InitializeComponent();

            var recitems = RecordStructure.Records.Keys.OfType<object>().ToArray();
            cboRecType.Sorted = true;
            cboRecType.Items.Clear();
            cboRecType.Items.Add("<All>");
            cboRecType.Items.AddRange(recitems);
            cboRecType.SelectedIndex = 0;
        }

        protected override void UpdateText()
        {
            if (inUpdateText) return;
            try
            {
                inUpdateText = true;
                base.UpdateText();
                UpdateRecordList();
            }
            finally
            {
                inUpdateText = false;
            }
        }

        protected override void UpdateElement()
        {
            base.UpdateElement();
            if (!string.IsNullOrEmpty(element.FormIDType))
            {
                cboRecType.SelectedIndex = cboRecType.FindStringExact(element.FormIDType);
            }
            else
                cboRecType.SelectedIndex = 0;
            UpdateRecordList();
        }

        protected override void UpdateLabel()
        {
            base.UpdateLabel();
        }

        protected override void UpdateAllControls()
        {
            base.UpdateAllControls();
        }

        protected virtual void UpdateRecordList()
        {
            // Enumerate all known records.
            cboFormID.Items.Clear();
            var data = GetCurrentData();
            if (formIDScan != null)
            {
                var str = cboRecType.Text;
                if (str == "<All>") str = null;
                var options = formIDScan(str);
                if (options == null)
                {
                    cboFormID.SelectedIndex = -1;
                }
                else
                {
                    var value = TypeConverter.h2si(data);
                    cboFormID.Items.Clear();
                    int idx = -1;
                    foreach (var cbVal in options.OrderBy(x => x.Value.DescriptiveName))
                    {
                        cboFormID.Items.Add(new comboBoxItem(cbVal.Value.DescriptiveName, cbVal.Key));
                        if (cbVal.Key == value)
                            idx = cboFormID.Items.Count - 1;
                    }
                    if (idx < cboFormID.Items.Count)
                        cboFormID.SelectedIndex = idx;
                    else
                        cboFormID.SelectedIndex = -1;
                }
            }
        }

        private void cboRecType_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateRecordList();
        }

        private void cboFormID_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (inSelChange) return;
            try
            {
                inSelChange = true;

                var data = GetCurrentData();
                uint oldIndex = TypeConverter.h2i(data);
                var cbi = cboFormID.SelectedItem as comboBoxItem;
                if (cbi != null)
                {
                    uint newIndex = cbi.value;
                    if (oldIndex != newIndex)
                    {
                        oldIndex = newIndex;
                        SetCurrentData(new ArraySegment<byte>(TypeConverter.i2h(newIndex)));
                        Changed = true;
                        UpdateText();
                    }
                }
            }
            finally
            {
                inSelChange = false;
            }
        }

        private void FormIDElement_SizeChanged(object sender, EventArgs e)
        {
            cboFormID.Width = Width - cboFormID.Left - 8;
        }
    }
}