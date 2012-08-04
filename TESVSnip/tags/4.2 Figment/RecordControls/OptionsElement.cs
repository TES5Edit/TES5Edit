using System;
using System.Windows.Forms;

namespace TESVSnip.RecordControls
{
    internal partial class OptionsElement : TextElement
    {
        private class comboBoxItem
        {
            public readonly string name;
            public readonly int value;

            public comboBoxItem(string name, int value)
            {
                this.name = name;
                this.value = value;
            }

            public override string ToString()
            {
                return name;
            }
        }


        public OptionsElement()
        {
            InitializeComponent();
        }

        protected override void UpdateElement()
        {
            base.UpdateElement();
        }

        protected override void UpdateLabel()
        {
            base.UpdateLabel();
        }

        protected override void UpdateAllControls()
        {
            base.UpdateAllControls();
            var data = GetCurrentData();
            if (element.options != null)
            {
                var value = TypeConverter.h2si(data);
                cboOptions.Items.Clear();
                int idx = -1;
                for (int j = 0; j < element.options.Length; j += 2)
                {
                    int cbVal;
                    if (int.TryParse(element.options[j + 1], out cbVal))
                    {
                        cboOptions.Items.Add(new comboBoxItem(element.options[j], cbVal));
                        if (cbVal == value)
                            idx = cboOptions.Items.Count - 1;
                    }
                }
                if (idx < cboOptions.Items.Count)
                    cboOptions.SelectedIndex = idx;
                else
                    cboOptions.SelectedIndex = -1;
            }
        }

        private void cboOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            var data = GetCurrentData();
            int oldIndex = TypeConverter.h2si(data);
            var cbi = cboOptions.SelectedItem as comboBoxItem;
            if (cbi != null)
            {
                int newIndex = cbi.value;
                if (oldIndex != newIndex && newIndex != -1)
                {
                    oldIndex = newIndex;
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.si2h(newIndex)));
                    Changed = true;
                    UpdateText();
                }
            }
        }

        private void cboOptions_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }
    }
}