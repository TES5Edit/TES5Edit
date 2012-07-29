using System;
using System.Globalization;
using System.Windows.Forms;

namespace TESVSnip.RecordControls
{
    internal partial class TextElement : BaseElement, ITextElementControl
    {
        public TextElement()
        {
            InitializeComponent();
        }

        #region ITextElementControl Members

        public Label LabelType
        {
            get { return lblType; }
        }

        public Label Label
        {
            get { return lblText; }
        }

        public TextBoxBase TextBox
        {
            get { return textBox; }
        }

        #endregion

        protected override void UpdateElement()
        {
            UpdateLabel();
        }

        protected virtual void UpdateLabel()
        {
            if (element != null && !string.IsNullOrEmpty(element.name))
            {
                lblType.Text = element.type.ToString();
                lblText.Text = element.name
                               + (!string.IsNullOrEmpty(element.desc) ? (" (" + element.desc + ")") : "");
            }
        }

        protected virtual void UpdateText()
        {
            var data = GetCurrentData();
            if (element == null || data == null || data.Array == null)
            {
                textBox.Text = "<error>";
            }
            else
            {
                bool fitTextBoxToWidth = false;
                var es = element;
                var tb = textBox;
                bool hasFlags = (es.options.Length == 0 && es.flags.Length > 1);
                switch (element.type)
                {
                    case ElementValueType.UInt:
                        {
                            var v = TypeConverter.h2i(data);
                            textBox.Text = element.hexview ? "0x" + v.ToString("X8") : v.ToString();
                        }
                        break;
                    case ElementValueType.Int:
                        {
                            var v = TypeConverter.h2si(data);
                            textBox.Text = hasFlags || es.hexview ? "0x" + v.ToString("X8") : v.ToString();
                        }
                        break;
                    case ElementValueType.FormID:
                        textBox.Text = TypeConverter.h2i(data).ToString("X8");
                        break;
                    case ElementValueType.Float:
                        textBox.Text = TypeConverter.h2f(data).ToString();
                        break;
                    case ElementValueType.UShort:
                        {
                            var v = TypeConverter.h2s(data);
                            textBox.Text = hasFlags || es.hexview ? "0x" + v.ToString("X4") : v.ToString();
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
                    case ElementValueType.LString:
                        {
                            uint id = TypeConverter.IsLikelyString(data) ? 0 : TypeConverter.h2i(data);
                            tb.Text = id.ToString("X8");
                        }
                        break;
                    case ElementValueType.Str4:
                        {
                            tb.Text = (data.Count >= 4) ? Encoding.CP1252.GetString(data.Array, data.Offset, 4) : "";
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
                    lblText.Left = ((Width - lblText.Width - 50)/50)*50;
                    lblText.Anchor = AnchorStyles.Right | AnchorStyles.Top;
                    textBox.Width = (lblText.Left - 20 - textBox.Left);
                    textBox.Anchor = AnchorStyles.Left | AnchorStyles.Right | AnchorStyles.Top;
                }
            }
        }

        protected override void UpdateAllControls()
        {
            UpdateText();
        }

        private void textBox_Validated(object sender, EventArgs e)
        {
            SaveText();
        }

        public override void CommitChanges()
        {
            SaveText();
        }

        protected virtual void SaveText()
        {
            if (element == null)
                return;
            var es = element;
            var tb = textBox;

            string tbText = textBox.Text;
            NumberStyles numStyle = NumberStyles.Any;
            if (tbText.StartsWith("0x"))
            {
                numStyle = NumberStyles.HexNumber;
                tbText = tbText.Substring(2);
            }

            bool hasFlags = (es.options.Length == 0 && es.flags.Length > 1);
            switch (element.type)
            {
                case ElementValueType.UInt:
                case ElementValueType.FormID:
                    {
                        uint i;
                        if (element.type == ElementValueType.FormID)
                            numStyle = NumberStyles.HexNumber;
                        if (!uint.TryParse(tbText, numStyle, null, out i))
                            Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                        else
                        {
                            Error.SetError(TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.i2h(i)));
                        }
                    }
                    break;
                case ElementValueType.Int:
                    {
                        int i;
                        if (!int.TryParse(tbText, numStyle, null, out i))
                            Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                        else
                        {
                            Error.SetError(TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.si2h(i)));
                        }
                    }
                    break;

                case ElementValueType.Float:
                    {
                        float i;
                        if (!float.TryParse(tbText, numStyle, null, out i))
                            Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                        else
                        {
                            Error.SetError(TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.f2h(i)));
                        }
                    }
                    break;
                case ElementValueType.UShort:
                    {
                        ushort i;
                        if (!ushort.TryParse(tbText, numStyle, null, out i))
                            Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                        else
                        {
                            Error.SetError(TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.s2h(i)));
                        }
                    }
                    break;
                case ElementValueType.Short:
                    {
                        short i;
                        if (!short.TryParse(tbText, numStyle, null, out i))
                            Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                        else
                        {
                            Error.SetError(TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.ss2h(i)));
                        }
                    }
                    break;
                case ElementValueType.Byte:
                    {
                        byte i;
                        if (!byte.TryParse(tbText, numStyle, null, out i))
                            Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                        else
                        {
                            Error.SetError(TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.b2h(i)));
                        }
                    }
                    break;
                case ElementValueType.SByte:
                    {
                        sbyte i;
                        if (!sbyte.TryParse(tbText, numStyle, null, out i))
                            Error.SetError(TextBox, string.Format("Invalid {0} Format", element.type));
                        else
                        {
                            Error.SetError(TextBox, null);
                            SetCurrentData(new ArraySegment<byte>(TypeConverter.sb2h(i)));
                        }
                    }
                    break;
                case ElementValueType.String:
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.str2h(textBox.Text)));
                    break;
                case ElementValueType.BString:
                    SetCurrentData(new ArraySegment<byte>(TypeConverter.bstr2h(textBox.Text)));
                    break;
                case ElementValueType.LString:
                    {
                        // not handled
                    }
                    break;
                case ElementValueType.Str4:
                    {
                        var txtbytes = new byte[] {0x32, 0x32, 0x32, 0x32};
                        System.Text.Encoding.Default.GetBytes(tbText, 0, Math.Min(4, tbText.Length), txtbytes, 0);
                        SetCurrentData(new ArraySegment<byte>(txtbytes));
                    }
                    break;
            }
        }

        private void TextElement_Load(object sender, EventArgs e)
        {
        }
    }
}