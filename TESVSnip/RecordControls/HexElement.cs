using System;
using System.Globalization;
using System.IO;
using System.Windows.Forms;
using Be.Windows.Forms;

namespace TESVSnip.RecordControls
{
    internal partial class HexElement : BaseElement
    {
        private readonly DynamicByteProvider dbytes;
        private readonly ByteCollection bytes;

        public HexElement()
        {
            InitializeComponent();
            dbytes = new DynamicByteProvider(new byte[0]);
            bytes = dbytes.Bytes;
            hexBox1.ByteProvider = dbytes;
            dbytes.LengthChanged += dbytes_LengthChanged;
            dbytes.Changed += dbytes_Changed;
        }

        protected override void SetCurrentData(ArraySegment<byte> value)
        {
            try
            {
                dbytes.LengthChanged -= dbytes_LengthChanged;
                dbytes.Changed -= dbytes_Changed;

                dbytes.Bytes.Clear();
                if (value.Count > 0)
                {
                    if (value.Offset == 0 && value.Array.Length == value.Count)
                    {
                        dbytes.InsertBytes(0, value.Array);
                    }
                    else
                    {
                        var bytes = new byte[value.Count];
                        Array.Copy(value.Array, value.Offset, bytes, 0, value.Count);
                        dbytes.InsertBytes(0, bytes);
                    }
                }
                base.SetCurrentData(value);
            }
            finally
            {
                dbytes.LengthChanged += dbytes_LengthChanged;
                dbytes.Changed += dbytes_Changed;
            }
        }

        private void dbytes_Changed(object sender, EventArgs e)
        {
            Data = new ArraySegment<byte>(dbytes.Bytes.GetBytes());
        }

        private void dbytes_LengthChanged(object sender, EventArgs e)
        {
            Data = new ArraySegment<byte>(dbytes.Bytes.GetBytes());
        }

        private void cbInsert_CheckedChanged(object sender, EventArgs e)
        {
            hexBox1.InsertActive = cbInsert.Checked;
        }

        private void tbName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && !char.IsLetter(e.KeyChar) && e.KeyChar != '_')
                e.Handled = true;
        }

        private void hexBox1_SelectionStartChanged(object sender, EventArgs e)
        {
            var pos = (int) hexBox1.SelectionStart;
            if (bytes.Count >= pos + 4)
            {
                tbFloat.Text = TypeConverter.h2f(bytes[pos], bytes[pos + 1], bytes[pos + 2], bytes[pos + 3]).ToString();
                tbFloat.Enabled = true;
                tbInt.Text = TypeConverter.h2si(bytes[pos], bytes[pos + 1], bytes[pos + 2], bytes[pos + 3]).ToString();
                tbInt.Enabled = true;
                bCFloat.Enabled = true;
                bCInt.Enabled = true;
                tbFormID.Text =
                    TypeConverter.h2i(bytes[pos], bytes[pos + 1], bytes[pos + 2], bytes[pos + 3]).ToString("X8");
                tbFormID.Enabled = true;
                bCFormID.Enabled = true;
                bLookup.Enabled = true;
            }
            else
            {
                tbFloat.Enabled = false;
                tbInt.Enabled = false;
                bCFloat.Enabled = false;
                bCInt.Enabled = false;
                tbFormID.Enabled = false;
                bCFormID.Enabled = false;
                bLookup.Enabled = false;
            }
            if (bytes.Count >= pos + 2)
            {
                tbWord.Text = TypeConverter.h2ss(bytes[pos], bytes[pos + 1]).ToString();
                tbWord.Enabled = true;
                bCWord.Enabled = true;
            }
            else
            {
                tbWord.Enabled = false;
                bCWord.Enabled = false;
            }
        }

        private void bCFloat_Click(object sender, EventArgs e)
        {
            float f;
            if (!float.TryParse(tbFloat.Text, out f))
            {
                MainView.PostStatusWarning("Invalid float");
                return;
            }
            byte[] b = TypeConverter.f2h(f);
            var pos = (int) hexBox1.SelectionStart;
            bytes[pos + 0] = b[0];
            bytes[pos + 1] = b[1];
            bytes[pos + 2] = b[2];
            bytes[pos + 3] = b[3];
            hexBox1.Refresh();
        }

        private void bCInt_Click(object sender, EventArgs e)
        {
            int i;
            if (!int.TryParse(tbInt.Text, out i))
            {
                MainView.PostStatusWarning("Invalid int");
                return;
            }
            byte[] b = TypeConverter.si2h(i);
            var pos = (int) hexBox1.SelectionStart;
            bytes[pos + 0] = b[0];
            bytes[pos + 1] = b[1];
            bytes[pos + 2] = b[2];
            bytes[pos + 3] = b[3];
            hexBox1.Refresh();
        }

        private void bCShort_Click(object sender, EventArgs e)
        {
            short s;
            if (!short.TryParse(tbFloat.Text, out s))
            {
                MainView.PostStatusWarning("Invalid word");
                return;
            }
            byte[] b = TypeConverter.ss2h(s);
            var pos = (int) hexBox1.SelectionStart;
            bytes[pos + 0] = b[0];
            bytes[pos + 1] = b[1];
            hexBox1.Refresh();
        }

        private void hexBox1_InsertActiveChanged(object sender, EventArgs e)
        {
            if (cbInsert.Checked != hexBox1.InsertActive) cbInsert.Checked = hexBox1.InsertActive;
        }

        private void bCFormID_Click(object sender, EventArgs e)
        {
            uint i;
            if (!uint.TryParse(tbFormID.Text, NumberStyles.AllowHexSpecifier, null, out i))
            {
                MainView.PostStatusWarning("Invalid form ID");
                return;
            }
            byte[] b = TypeConverter.i2h(i);
            var pos = (int) hexBox1.SelectionStart;
            bytes[pos + 0] = b[0];
            bytes[pos + 1] = b[1];
            bytes[pos + 2] = b[2];
            bytes[pos + 3] = b[3];
            hexBox1.Refresh();
        }

        private void bLookup_Click(object sender, EventArgs e)
        {
            uint value;
            tbEDID.Text = "";
            if (uint.TryParse(tbFormID.Text, NumberStyles.HexNumber, null, out value))
            {
                var rec = formIDLookup(value);
                if (rec != null) tbEDID.Text = rec.DescriptiveName;
            }
        }

        private void bFromFile_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() != DialogResult.OK) return;
            byte[] newdata = File.ReadAllBytes(openFileDialog1.FileName);
            bytes.Clear();
            bytes.AddRange(newdata);
            hexBox1.Refresh();
        }

        private void HexElement_Load(object sender, EventArgs e)
        {
        }
    }
}