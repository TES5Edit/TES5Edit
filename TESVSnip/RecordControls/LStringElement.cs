using System;
using System.Globalization;
using System.Windows.Forms;
using TESVSnip.Forms;
using TESVSnip.Properties;

namespace TESVSnip.RecordControls
{
    internal partial class LStringElement : TextElement
    {
        public LStringElement()
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

        protected override void UpdateText()
        {
        }

        protected override void UpdateAllControls()
        {
            try
            {
                chkUseText.CheckedChanged -= chkUseText_CheckedChanged;
                var data = GetCurrentData();
                switch (Element.type)
                {
                    case ElementValueType.UInt:
                        SetTextByID();
                        break;

                    case ElementValueType.String:
                        SetTextAsString();
                        break;

                    case ElementValueType.LString: // can be either
                        bool isString = TypeConverter.IsLikelyString(data);
                        if (isString)
                            SetTextAsString();
                        else
                            SetTextByID();
                        break;
                }
            }
            finally
            {
                chkUseText.CheckedChanged += chkUseText_CheckedChanged;
            }
        }

        private void SetTextAsString()
        {
            var data = GetCurrentData();
            TextBox.ReadOnly = false;
            txtString.ReadOnly = false;
            txtString.Text = TypeConverter.GetString(data);
            Error.SetError(txtString, null);
            TextBox.Text = 0.ToString("X8");
            chkUseText.Checked = true;
            TextBox.ReadOnly = true;
        }

        private void SetTextByID()
        {
            var data = GetCurrentData();
            txtString.ReadOnly = false;
            uint id = TypeConverter.h2i(data);
            string s = "";
            TextBox.Text = id.ToString("X8");
            if (strIDLookup != null)
                s = strIDLookup(id);
            if (s != null)
            {
                txtString.Text = s;
                Error.SetError(txtString, null);
            }
            else
            {
                // dont override text as user could just be toggling checkbox
                Error.SetError(txtString, "Could not locate string");
                Error.SetIconAlignment(txtString, ErrorIconAlignment.MiddleLeft);
                Error.Icon = Resources.Warning;
            }
            txtString.ReadOnly = true;
            chkUseText.Checked = false;
        }

        private void chkUseText_CheckedChanged(object sender, EventArgs e)
        {
            SaveText();
            txtString.ReadOnly = !chkUseText.Checked;
            TextBox.ReadOnly = chkUseText.Checked;
        }

        protected override void SaveText()
        {
            if (chkUseText.Checked)
            {
                SetCurrentData(new ArraySegment<byte>(TypeConverter.str2h(txtString.Text)));
                Error.SetError(TextBox, null);
            }
            else
            {
                string tbText = TextBox.Text;
                NumberStyles numStyle = NumberStyles.HexNumber;
                uint i;
                if (!uint.TryParse(tbText, numStyle, null, out i))
                    Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                else
                {
                    Error.SetError(TextBox, null);
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.i2h(i)));
                }
            }
        }

        private void txtString_Validated(object sender, EventArgs e)
        {
            SaveText();
        }

        private void txtString_DoubleClick(object sender, EventArgs e)
        {
            using (var editor = new MultilineStringEditor())
            {
                editor.Text = txtString.Text;
                DialogResult result = editor.ShowDialog(this);
                if (result == DialogResult.OK)
                {
                    txtString.Text = editor.Text;
                }
            }
        }
    }
}