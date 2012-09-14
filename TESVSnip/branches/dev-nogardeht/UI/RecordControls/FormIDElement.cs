namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Linq;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework;

    internal partial class FormIDElement : TextElement
    {
        private bool inSelChange;

        private bool inUpdateText;

        public FormIDElement()
        {
            this.InitializeComponent();

            var recitems = RecordStructure.Records.Keys.OfType<object>().ToArray();
            this.cboRecType.Sorted = true;
            this.cboRecType.Items.Clear();
            this.cboRecType.Items.Add("<All>");
            this.cboRecType.Items.AddRange(recitems);
            this.cboRecType.SelectedIndex = 0;
        }

        protected override void UpdateAllControls()
        {
            base.UpdateAllControls();
        }

        protected override void UpdateElement()
        {
            base.UpdateElement();
            if (!string.IsNullOrEmpty(element.FormIDType))
            {
                this.cboRecType.SelectedIndex = this.cboRecType.FindStringExact(element.FormIDType);
            }
            else
            {
                this.cboRecType.SelectedIndex = 0;
            }

            this.UpdateRecordList();
        }

        protected override void UpdateLabel()
        {
            base.UpdateLabel();
        }

        protected virtual void UpdateRecordList()
        {
            // Enumerate all known records.
            this.cboFormID.Items.Clear();
            var data = GetCurrentData();
            if (formIDScan != null)
            {
                var str = this.cboRecType.Text;
                if (str == "<All>")
                {
                    str = null;
                }

                var options = formIDScan(str);
                if (options == null)
                {
                    this.cboFormID.SelectedIndex = -1;
                }
                else
                {
                    var value = TypeConverter.h2si(data);
                    this.cboFormID.Items.Clear();
                    int idx = -1;
                    foreach (var cbVal in options.OrderBy(x => x.Value.DescriptiveName))
                    {
                        this.cboFormID.Items.Add(new comboBoxItem(cbVal.Value.DescriptiveName, cbVal.Key));
                        if (cbVal.Key == value)
                        {
                            idx = this.cboFormID.Items.Count - 1;
                        }
                    }

                    if (idx < this.cboFormID.Items.Count)
                    {
                        this.cboFormID.SelectedIndex = idx;
                    }
                    else
                    {
                        this.cboFormID.SelectedIndex = -1;
                    }
                }
            }
        }

        protected override void UpdateText()
        {
            if (this.inUpdateText)
            {
                return;
            }

            try
            {
                this.inUpdateText = true;
                base.UpdateText();
                this.UpdateRecordList();
            }
            finally
            {
                this.inUpdateText = false;
            }
        }

        private void FormIDElement_SizeChanged(object sender, EventArgs e)
        {
            this.cboFormID.Width = Width - this.cboFormID.Left - 8;
        }

        private void cboFormID_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.inSelChange)
            {
                return;
            }

            try
            {
                this.inSelChange = true;

                var data = GetCurrentData();
                uint oldIndex = TypeConverter.h2i(data);
                var cbi = this.cboFormID.SelectedItem as comboBoxItem;
                if (cbi != null)
                {
                    uint newIndex = cbi.value;
                    if (oldIndex != newIndex)
                    {
                        oldIndex = newIndex;
                        SetCurrentData(new ArraySegment<byte>(TypeConverter.i2h(newIndex)));
                        Changed = true;
                        this.UpdateText();
                    }
                }
            }
            finally
            {
                this.inSelChange = false;
            }
        }

        private void cboRecType_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.UpdateRecordList();
        }

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
                return this.name;
            }
        }
    }
}
