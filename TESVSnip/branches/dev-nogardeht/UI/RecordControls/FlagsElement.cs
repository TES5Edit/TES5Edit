namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework;

    internal partial class FlagsElement : TextElement
    {
        public FlagsElement()
        {
            this.InitializeComponent();
        }

        protected override void UpdateAllControls()
        {
            base.UpdateAllControls();
            if (element.flags != null)
            {
                uint value;
                byte flagSize = 0;
                switch (element.type)
                {
                    case ElementValueType.SByte:
                    case ElementValueType.Byte:
                        value = (uint)TypeConverter.h2b(Data);
                        flagSize = 4;
                        break;
                    case ElementValueType.Short:
                    case ElementValueType.UShort:
                        value = (uint)TypeConverter.h2s(Data);
                        flagSize = 2;
                        break;
                    case ElementValueType.Int:
                    case ElementValueType.UInt:
                        value = TypeConverter.h2i(Data);
                        flagSize = 1;
                        break;
                    default:
                        value = 0;
                        break;
                }

                this.cboFlags.SetItems(element.flags, flagSize);
                this.cboFlags.SetState(value);
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

        private void cboFlags_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            uint value = this.cboFlags.GetState();
            uint oldValue = TypeConverter.h2i(Data);
            switch (element.type)
            {
                case ElementValueType.SByte:
                case ElementValueType.Byte:
                    oldValue = (uint)TypeConverter.h2b(Data);
                    break;
                case ElementValueType.Short:
                case ElementValueType.UShort:
                    oldValue = (uint)TypeConverter.h2s(Data);
                    break;
                case ElementValueType.Int:
                case ElementValueType.UInt:
                    oldValue = TypeConverter.h2i(Data);
                    break;
                default:
                    oldValue = 0;
                    break;
            }

            if (value != oldValue)
            {
                switch (element.type)
                {
                    case ElementValueType.SByte:
                    case ElementValueType.Byte:
                        SetCurrentData(new ArraySegment<byte>(TypeConverter.b2h((byte)value)));
                        break;

                    case ElementValueType.Short:
                    case ElementValueType.UShort:
                        SetCurrentData(new ArraySegment<byte>(TypeConverter.s2h((ushort)value)));
                        break;

                    case ElementValueType.Int:
                    case ElementValueType.UInt:
                        SetCurrentData(new ArraySegment<byte>(TypeConverter.i2h(value)));
                        break;
                }

                TextBox.Text = "0x" + value.ToString("X");
                Changed = true;
            }
        }
    }
}
