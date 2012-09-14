namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework;

    internal partial class OptionsElement : TextElement
    {
        public OptionsElement()
        {
            this.InitializeComponent();
        }

        protected override void UpdateAllControls()
        {
            base.UpdateAllControls();
            var data = GetCurrentData();
            if (element.options != null)
            {
                int value;
                switch (element.type)
                {
                    case ElementValueType.SByte:
                    case ElementValueType.Byte:
                        value = (int)TypeConverter.h2sb(data);
                        break;
                    case ElementValueType.Short:
                    case ElementValueType.UShort:
                        value = (int)TypeConverter.h2ss(data);
                        break;
                    case ElementValueType.Int:
                    case ElementValueType.UInt:
                        value = TypeConverter.h2si(data);
                        break;
                    default:
                        value = 0;
                        break;
                }

                this.cboOptions.Items.Clear();
                int idx = -1;
                for (int j = 0; j < element.options.Length; j += 2)
                {
                    int cbVal;
                    if (int.TryParse(element.options[j + 1], out cbVal))
                    {
                        this.cboOptions.Items.Add(new comboBoxItem(element.options[j], cbVal));
                        if (cbVal == value)
                        {
                            idx = this.cboOptions.Items.Count - 1;
                        }
                    }
                }

                if (idx < this.cboOptions.Items.Count)
                {
                    this.cboOptions.SelectedIndex = idx;
                }
                else
                {
                    this.cboOptions.SelectedIndex = -1;
                }
            }
        }

        protected override void UpdateElement()
        {
            base.UpdateElement();
        }

        protected override void UpdateLabel()
        {
            base.UpdateLabel();
        }

        private void cboOptions_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }

        private void cboOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            var data = GetCurrentData();
            int oldIndex = TypeConverter.h2si(data);
            switch (element.type)
            {
                case ElementValueType.SByte:
                case ElementValueType.Byte:
                    oldIndex = (int)TypeConverter.h2sb(data);
                    break;
                case ElementValueType.Short:
                case ElementValueType.UShort:
                    oldIndex = (int)TypeConverter.h2ss(data);
                    break;
                case ElementValueType.Int:
                case ElementValueType.UInt:
                    oldIndex = TypeConverter.h2si(data);
                    break;
                default:
                    oldIndex = -1;
                    break;
            }

            var cbi = this.cboOptions.SelectedItem as comboBoxItem;
            if (cbi != null)
            {
                int newIndex = cbi.value;
                if (oldIndex != newIndex && newIndex != -1)
                {
                    oldIndex = newIndex;
                    switch (element.type)
                    {
                        case ElementValueType.SByte:
                        case ElementValueType.Byte:
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.sb2h((sbyte)newIndex)));
                            break;

                        case ElementValueType.Short:
                        case ElementValueType.UShort:
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.ss2h((short)newIndex)));
                            break;

                        case ElementValueType.Int:
                        case ElementValueType.UInt:
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.si2h(newIndex)));
                            break;
                    }

                    Changed = true;
                    UpdateText();
                }
            }
        }

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
                return this.name;
            }
        }
    }
}
