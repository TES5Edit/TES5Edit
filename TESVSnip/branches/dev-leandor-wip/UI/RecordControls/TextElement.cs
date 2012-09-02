namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Globalization;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Framework;
    using TESVSnip.Framework.Services;

    internal partial class TextElement : BaseElement, ITextElementControl
    {
        public TextElement()
        {
            this.InitializeComponent();
        }

        public Label Label
        {
            get
            {
                return this.lblText;
            }
        }

        public Label LabelType
        {
            get
            {
                return this.lblType;
            }
        }

        public TextBoxBase TextBox
        {
            get
            {
                return this.textBox;
            }
        }

        public override void CommitChanges()
        {
            this.SaveText();
        }

        protected virtual void SaveText()
        {
            if (element == null)
            {
                return;
            }

            var es = element;
            var tb = this.textBox;

            string tbText = this.textBox.Text;
            var numStyle = NumberStyles.Any;
            if (tbText.StartsWith("0x"))
            {
                numStyle = NumberStyles.HexNumber;
                tbText = tbText.Substring(2);
            }

            bool hasFlags = es.options.Length == 0 && es.flags.Length > 1;
            switch (element.type)
            {
                case ElementValueType.UInt:
                case ElementValueType.FormID:
                    {
                        uint i;
                        if (element.type == ElementValueType.FormID)
                        {
                            numStyle = NumberStyles.HexNumber;
                        }

                        if (!uint.TryParse(tbText, numStyle, null, out i))
                        {
                            Error.SetError(this.TextBox, string.Format("Invalid {0} Format", element.type));
                        }
                        else
                        {
                            Error.SetError(this.TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.i2h(i)));
                        }
                    }

                    break;
                case ElementValueType.Int:
                    {
                        int i;
                        if (!int.TryParse(tbText, numStyle, null, out i))
                        {
                            Error.SetError(this.TextBox, string.Format("Invalid {0} Format", element.type));
                        }
                        else
                        {
                            Error.SetError(this.TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.si2h(i)));
                        }
                    }

                    break;

                case ElementValueType.Float:
                    {
                        float i;
                        if (!float.TryParse(tbText, numStyle, null, out i))
                        {
                            Error.SetError(this.TextBox, string.Format("Invalid {0} Format", element.type));
                        }
                        else
                        {
                            Error.SetError(this.TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.f2h(i)));
                        }
                    }

                    break;
                case ElementValueType.UShort:
                    {
                        ushort i;
                        if (!ushort.TryParse(tbText, numStyle, null, out i))
                        {
                            Error.SetError(this.TextBox, string.Format("Invalid {0} Format", element.type));
                        }
                        else
                        {
                            Error.SetError(this.TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.s2h(i)));
                        }
                    }

                    break;
                case ElementValueType.Short:
                    {
                        short i;
                        if (!short.TryParse(tbText, numStyle, null, out i))
                        {
                            Error.SetError(this.TextBox, string.Format("Invalid {0} Format", element.type));
                        }
                        else
                        {
                            Error.SetError(this.TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.ss2h(i)));
                        }
                    }

                    break;
                case ElementValueType.Byte:
                    {
                        byte i;
                        if (!byte.TryParse(tbText, numStyle, null, out i))
                        {
                            Error.SetError(this.TextBox, string.Format("Invalid {0} Format", element.type));
                        }
                        else
                        {
                            Error.SetError(this.TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.b2h(i)));
                        }
                    }

                    break;
                case ElementValueType.SByte:
                    {
                        sbyte i;
                        if (!sbyte.TryParse(tbText, numStyle, null, out i))
                        {
                            Error.SetError(this.TextBox, string.Format("Invalid {0} Format", element.type));
                        }
                        else
                        {
                            Error.SetError(this.TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.sb2h(i)));
                        }
                    }

                    break;
                case ElementValueType.String:
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.str2h(this.textBox.Text)));
                    break;
                case ElementValueType.BString:
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.bstr2h(this.textBox.Text)));
                    break;
                case ElementValueType.IString:
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.istr2h(this.textBox.Text)));
                    break;
                case ElementValueType.LString:
                    {
                        // not handled
                    }

                    break;
                case ElementValueType.Str4:
                    {
                        var txtbytes = new byte[] { 0x32, 0x32, 0x32, 0x32 };
                        System.Text.Encoding.Default.GetBytes(tbText, 0, Math.Min(4, tbText.Length), txtbytes, 0);
                        SetCurrentData(new ArraySegment<byte>(txtbytes));
                    }

                    break;
            }
        }

        protected override void UpdateAllControls()
        {
            this.UpdateText();
        }

        protected override void UpdateElement()
        {
            this.UpdateLabel();
        }

        protected virtual void UpdateLabel()
        {
            if (element != null && !string.IsNullOrEmpty(element.name))
            {
                this.lblType.Text = element.type.ToString();
                this.lblText.Text = element.name + (!string.IsNullOrEmpty(element.desc) ? (" (" + element.desc + ")") : string.Empty);
                if (element.multiline)
                {
                    this.textBox.AcceptsReturn = true;
                    this.textBox.Multiline = true;
                    this.textBox.Height = 120;
                    this.textBox.ScrollBars = ScrollBars.Vertical;
                    Height = 120;
                }
            }
        }

        protected virtual void UpdateText()
        {
            var data = GetCurrentData();
            if (element == null || data == null || data.Array == null)
            {
                this.textBox.Text = "<error>";
            }
            else
            {
                bool fitTextBoxToWidth = false;
                var es = element;
                var tb = this.textBox;
                bool hasFlags = es.options.Length == 0 && es.flags.Length > 1;
                switch (element.type)
                {
                    case ElementValueType.UInt:
                        {
                            var v = TypeConverter.h2i(data);
                            this.textBox.Text = element.hexview ? "0x" + v.ToString("X8") : v.ToString();
                        }

                        break;
                    case ElementValueType.Int:
                        {
                            var v = TypeConverter.h2si(data);
                            this.textBox.Text = hasFlags || es.hexview ? "0x" + v.ToString("X8") : v.ToString();
                        }

                        break;
                    case ElementValueType.FormID:
                        this.textBox.Text = TypeConverter.h2i(data).ToString("X8");
                        break;
                    case ElementValueType.Float:
                        this.textBox.Text = TypeConverter.h2f(data).ToString();
                        break;
                    case ElementValueType.UShort:
                        {
                            var v = TypeConverter.h2s(data);
                            this.textBox.Text = hasFlags || es.hexview ? "0x" + v.ToString("X4") : v.ToString();
                        }

                        break;
                    case ElementValueType.Short:
                        {
                            var v = TypeConverter.h2ss(data);
                            tb.Text = hasFlags || es.hexview ? "0x" + v.ToString("X4") : v.ToString();
                        }

                        break;
                    case ElementValueType.Byte:
                        {
                            var v = TypeConverter.h2b(data);
                            tb.Text = hasFlags || es.hexview ? "0x" + v.ToString("X2") : v.ToString();
                        }

                        break;
                    case ElementValueType.SByte:
                        {
                            var v = TypeConverter.h2sb(data);
                            tb.Text = hasFlags || es.hexview ? "0x" + v.ToString("X2") : v.ToString();
                        }

                        break;
                    case ElementValueType.String:
                        tb.Text = TypeConverter.GetZString(data);
                        fitTextBoxToWidth = true;
                        break;
                    case ElementValueType.BString:
                        tb.Text = TypeConverter.GetBString(data);
                        fitTextBoxToWidth = true;
                        break;
                    case ElementValueType.IString:
                        tb.Text = TypeConverter.GetIString(data);
                        fitTextBoxToWidth = true;
                        break;
                    case ElementValueType.LString:
                        {
                            uint id = TypeConverter.IsLikelyString(data) ? 0 : TypeConverter.h2i(data);
                            tb.Text = id.ToString("X8");
                        }

                        break;
                    case ElementValueType.Str4:
                        {
                            tb.Text = (data.Count >= 4) ? Encoding.Instance.GetString(data.Array, data.Offset, 4) : string.Empty;
                            tb.MaxLength = 4;
                        }

                        break;
                    default:
                        {
                            tb.Text = "<Error>";
                            tb.Enabled = false;
                        }

                        break;
                }

                if (fitTextBoxToWidth)
                {
                    this.lblText.Left = ((Width - this.lblText.Width - 50) / 50) * 50;
                    this.lblText.Anchor = AnchorStyles.Right | AnchorStyles.Top;
                    this.textBox.Width = this.lblText.Left - 20 - this.textBox.Left;
                    this.textBox.Anchor = AnchorStyles.Left | AnchorStyles.Right | AnchorStyles.Top;
                }
            }
        }

        private void TextElement_Load(object sender, EventArgs e)
        {
        }

        private void textBox_Validated(object sender, EventArgs e)
        {
            this.SaveText();
        }
    }
}
