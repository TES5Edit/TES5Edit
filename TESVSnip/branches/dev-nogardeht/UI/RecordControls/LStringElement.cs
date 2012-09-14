namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Globalization;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework;
    using TESVSnip.Properties;
    using TESVSnip.UI.Forms;

    internal partial class LStringElement : TextElement
    {
        public LStringElement()
        {
            this.InitializeComponent();
        }

        protected override void SaveText()
        {
            if (this.chkUseText.Checked)
            {
                SetCurrentData(new ArraySegment<byte>(TypeConverter.str2h(this.txtString.Text)));
                Error.SetError(TextBox, null);
            }
            else
            {
                string tbText = TextBox.Text;
                var numStyle = NumberStyles.HexNumber;
                uint i;
                if (!uint.TryParse(tbText, numStyle, null, out i))
                {
                    Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                }
                else
                {
                    Error.SetError(TextBox, null);
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.i2h(i)));
                }
            }
        }

        protected override void UpdateAllControls()
        {
            try
            {
                this.chkUseText.CheckedChanged -= this.chkUseText_CheckedChanged;
                var data = GetCurrentData();
                switch (Element.type)
                {
                    case ElementValueType.UInt:
                        this.SetTextByID();
                        break;

                    case ElementValueType.String:
                        this.SetTextAsString();
                        break;

                    case ElementValueType.LString: // can be either
                        bool isString = TypeConverter.IsLikelyString(data);
                        if (isString)
                        {
                            this.SetTextAsString();
                        }
                        else
                        {
                            this.SetTextByID();
                        }

                        break;
                }
            }
            finally
            {
                this.chkUseText.CheckedChanged += this.chkUseText_CheckedChanged;
            }
        }

        protected override void UpdateElement()
        {
            base.UpdateElement();
        }

        protected override void UpdateLabel()
        {
            if (element != null && !string.IsNullOrEmpty(element.name))
            {
                lblType.Text = element.type.ToString();
                lblText.Text = element.name + (!string.IsNullOrEmpty(element.desc) ? (" (" + element.desc + ")") : string.Empty);
                if (element.multiline)
                {
                    this.txtString.AcceptsReturn = true;
                    this.txtString.Multiline = true;
                    this.txtString.Height = 120;
                    this.txtString.ScrollBars = ScrollBars.Vertical;
                    Height = 148;
                }
            }
        }

        protected override void UpdateText()
        {
        }

        private void SetTextAsString()
        {
            var data = GetCurrentData();
            TextBox.ReadOnly = false;
            this.txtString.ReadOnly = false;
            this.txtString.Text = TypeConverter.GetString(data);
            Error.SetError(this.txtString, null);
            TextBox.Text = 0.ToString("X8");
            this.chkUseText.Checked = true;
            TextBox.ReadOnly = true;
        }

        private void SetTextByID()
        {
            var data = GetCurrentData();
            this.txtString.ReadOnly = false;
            uint id = TypeConverter.h2i(data);
            string s = string.Empty;
            TextBox.Text = id.ToString("X8");
            if (strIDLookup != null)
            {
                s = strIDLookup(id);
            }

            if (s != null)
            {
                this.txtString.Text = s;
                Error.SetError(this.txtString, null);
            }
            else
            {
                // dont override text as user could just be toggling checkbox
                Error.SetError(this.txtString, "Could not locate string");
                Error.SetIconAlignment(this.txtString, ErrorIconAlignment.MiddleLeft);
                Error.Icon = Resources.Warning;
            }

            this.txtString.ReadOnly = true;
            this.chkUseText.Checked = false;
        }

        private void chkUseText_CheckedChanged(object sender, EventArgs e)
        {
            this.SaveText();
            this.txtString.ReadOnly = !this.chkUseText.Checked;
            TextBox.ReadOnly = this.chkUseText.Checked;
        }

        private void textBox_Enter(object sender, EventArgs e)
        {
            if (textBox.ReadOnly)
            {
                this.txtString.Focus();
            }
        }

        private void txtString_DoubleClick(object sender, EventArgs e)
        {
            using (var editor = new MultilineStringEditor())
            {
                editor.Text = this.txtString.Text;
                DialogResult result = editor.ShowDialog(this);
                if (result == DialogResult.OK)
                {
                    this.txtString.Text = editor.Text;
                }
            }
        }

        private void txtString_Validated(object sender, EventArgs e)
        {
            this.SaveText();
        }
    }
}
