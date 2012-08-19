namespace TESVSnip.UI.RecordControls
{
    using System;
    using System.Globalization;
    using System.IO;
    using System.Windows.Forms;

    using Be.Windows.Forms;

    using TESVSnip.Framework;
    using TESVSnip.UI.Forms;

    internal partial class HexElement : BaseElement
    {
        private readonly ByteCollection bytes;

        private readonly DynamicByteProvider dbytes;

        public HexElement()
        {
            this.InitializeComponent();
            this.dbytes = new DynamicByteProvider(new byte[0]);
            this.bytes = this.dbytes.Bytes;
            this.hexBox1.ByteProvider = this.dbytes;
            this.dbytes.LengthChanged += this.dbytes_LengthChanged;
            this.dbytes.Changed += this.dbytes_Changed;
        }

        protected override void SetCurrentData(ArraySegment<byte> value)
        {
            try
            {
                this.dbytes.LengthChanged -= this.dbytes_LengthChanged;
                this.dbytes.Changed -= this.dbytes_Changed;

                this.dbytes.Bytes.Clear();
                if (value.Count > 0)
                {
                    if (value.Offset == 0 && value.Array.Length == value.Count)
                    {
                        this.dbytes.InsertBytes(0, value.Array);
                    }
                    else
                    {
                        var bytes = new byte[value.Count];
                        Array.Copy(value.Array, value.Offset, bytes, 0, value.Count);
                        this.dbytes.InsertBytes(0, bytes);
                    }
                }

                base.SetCurrentData(value);
            }
            finally
            {
                this.dbytes.LengthChanged += this.dbytes_LengthChanged;
                this.dbytes.Changed += this.dbytes_Changed;
            }
        }

        private void HexElement_Load(object sender, EventArgs e)
        {
        }

        private void bCFloat_Click(object sender, EventArgs e)
        {
            float f;
            if (!float.TryParse(this.tbFloat.Text, out f))
            {
                MainView.PostStatusWarning("Invalid float");
                return;
            }

            byte[] b = TypeConverter.f2h(f);
            var pos = (int)this.hexBox1.SelectionStart;
            this.bytes[pos + 0] = b[0];
            this.bytes[pos + 1] = b[1];
            this.bytes[pos + 2] = b[2];
            this.bytes[pos + 3] = b[3];
            this.hexBox1.Refresh();
        }

        private void bCFormID_Click(object sender, EventArgs e)
        {
            uint i;
            if (!uint.TryParse(this.tbFormID.Text, NumberStyles.AllowHexSpecifier, null, out i))
            {
                MainView.PostStatusWarning("Invalid form ID");
                return;
            }

            byte[] b = TypeConverter.i2h(i);
            var pos = (int)this.hexBox1.SelectionStart;
            this.bytes[pos + 0] = b[0];
            this.bytes[pos + 1] = b[1];
            this.bytes[pos + 2] = b[2];
            this.bytes[pos + 3] = b[3];
            this.hexBox1.Refresh();
        }

        private void bCInt_Click(object sender, EventArgs e)
        {
            int i;
            if (!int.TryParse(this.tbInt.Text, out i))
            {
                MainView.PostStatusWarning("Invalid int");
                return;
            }

            byte[] b = TypeConverter.si2h(i);
            var pos = (int)this.hexBox1.SelectionStart;
            this.bytes[pos + 0] = b[0];
            this.bytes[pos + 1] = b[1];
            this.bytes[pos + 2] = b[2];
            this.bytes[pos + 3] = b[3];
            this.hexBox1.Refresh();
        }

        private void bCShort_Click(object sender, EventArgs e)
        {
            short s;
            if (!short.TryParse(this.tbFloat.Text, out s))
            {
                MainView.PostStatusWarning("Invalid word");
                return;
            }

            byte[] b = TypeConverter.ss2h(s);
            var pos = (int)this.hexBox1.SelectionStart;
            this.bytes[pos + 0] = b[0];
            this.bytes[pos + 1] = b[1];
            this.hexBox1.Refresh();
        }

        private void bFromFile_Click(object sender, EventArgs e)
        {
            if (this.openFileDialog1.ShowDialog() != DialogResult.OK)
            {
                return;
            }

            byte[] newdata = File.ReadAllBytes(this.openFileDialog1.FileName);
            this.bytes.Clear();
            this.bytes.AddRange(newdata);
            this.hexBox1.Refresh();
        }

        private void bLookup_Click(object sender, EventArgs e)
        {
            uint value;
            this.tbEDID.Text = string.Empty;
            if (uint.TryParse(this.tbFormID.Text, NumberStyles.HexNumber, null, out value))
            {
                var rec = formIDLookup(value);
                if (rec != null)
                {
                    this.tbEDID.Text = rec.DescriptiveName;
                }
            }
        }

        private void cbInsert_CheckedChanged(object sender, EventArgs e)
        {
            this.hexBox1.InsertActive = this.cbInsert.Checked;
        }

        private void dbytes_Changed(object sender, EventArgs e)
        {
            Data = new ArraySegment<byte>(this.dbytes.Bytes.GetBytes());
        }

        private void dbytes_LengthChanged(object sender, EventArgs e)
        {
            Data = new ArraySegment<byte>(this.dbytes.Bytes.GetBytes());
        }

        private void hexBox1_InsertActiveChanged(object sender, EventArgs e)
        {
            if (this.cbInsert.Checked != this.hexBox1.InsertActive)
            {
                this.cbInsert.Checked = this.hexBox1.InsertActive;
            }
        }

        private void hexBox1_SelectionStartChanged(object sender, EventArgs e)
        {
            var pos = (int)this.hexBox1.SelectionStart;
            if (this.bytes.Count >= pos + 4)
            {
                this.tbFloat.Text = TypeConverter.h2f(this.bytes[pos], this.bytes[pos + 1], this.bytes[pos + 2], this.bytes[pos + 3]).ToString();
                this.tbFloat.Enabled = true;
                this.tbInt.Text = TypeConverter.h2si(this.bytes[pos], this.bytes[pos + 1], this.bytes[pos + 2], this.bytes[pos + 3]).ToString();
                this.tbInt.Enabled = true;
                this.bCFloat.Enabled = true;
                this.bCInt.Enabled = true;
                this.tbFormID.Text = TypeConverter.h2i(this.bytes[pos], this.bytes[pos + 1], this.bytes[pos + 2], this.bytes[pos + 3]).ToString("X8");
                this.tbFormID.Enabled = true;
                this.bCFormID.Enabled = true;
                this.bLookup.Enabled = true;
            }
            else
            {
                this.tbFloat.Enabled = false;
                this.tbInt.Enabled = false;
                this.bCFloat.Enabled = false;
                this.bCInt.Enabled = false;
                this.tbFormID.Enabled = false;
                this.bCFormID.Enabled = false;
                this.bLookup.Enabled = false;
            }

            if (this.bytes.Count >= pos + 2)
            {
                this.tbWord.Text = TypeConverter.h2ss(this.bytes[pos], this.bytes[pos + 1]).ToString();
                this.tbWord.Enabled = true;
                this.bCWord.Enabled = true;
            }
            else
            {
                this.tbWord.Enabled = false;
                this.bCWord.Enabled = false;
            }
        }

        private void tbName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && !char.IsLetter(e.KeyChar) && e.KeyChar != '_')
            {
                e.Handled = true;
            }
        }
    }
}
