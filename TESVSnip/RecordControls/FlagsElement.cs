using System;
using System.Windows.Forms;

namespace TESVSnip.RecordControls
{
    internal partial class FlagsElement : TextElement
    {
        public FlagsElement()
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
            if (element.flags != null)
            {
                uint value = TypeConverter.h2i(Data);
                cboFlags.SetItems(element.flags);
                cboFlags.SetState(value);
            }
        }

        private void cboFlags_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            uint value = cboFlags.GetState();
            uint oldValue = TypeConverter.h2i(Data);
            if (value != oldValue)
            {
                byte[] data = TypeConverter.i2h(value);
                SetCurrentData(new ArraySegment<byte>(data, 0, data.Length));
                TextBox.Text = "0x" + value.ToString("X");
                Changed = true;
            }
        }
    }
}