namespace TESVSnip.UI.Forms
{
    using System;
    using System.Globalization;
    using System.IO;
    using System.Windows.Forms;

    using Be.Windows.Forms;

    using TESVSnip.Domain.Model;
    using TESVSnip.Framework;
    using TESVSnip.Properties;

    internal partial class HexDataEdit : Form
    {
        public static bool Canceled;

        public static byte[] result;

        public static string resultName;

        private readonly ByteCollection bytes;

        private readonly DynamicByteProvider dbytes;

        private readonly dFormIDLookupS formIDLookup;

        public HexDataEdit(string RecName, byte[] data, dFormIDLookupS formIDLookup)
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
            this.formIDLookup = formIDLookup;
            Text += RecName;
            this.tbName.Text = RecName;
            Text += " (hex mode)";
            this.dbytes = new DynamicByteProvider(data);
            this.bytes = this.dbytes.Bytes;
            this.hexBox1.ByteProvider = this.dbytes;
            Canceled = true;
        }

        private void bCFloat_Click(object sender, EventArgs e)
        {
            float f;
            if (!float.TryParse(this.tbFloat.Text, out f))
            {
                MessageBox.Show("Invalid float");
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
                MessageBox.Show("Invalid form ID");
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
                MessageBox.Show("Invalid int");
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
                MessageBox.Show("Invalid word");
                return;
            }

            byte[] b = TypeConverter.ss2h(s);
            var pos = (int)this.hexBox1.SelectionStart;
            this.bytes[pos + 0] = b[0];
            this.bytes[pos + 1] = b[1];
            this.hexBox1.Refresh();
        }

        private void bCancel_Click(object sender, EventArgs e)
        {
            Canceled = true;
            Close();
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
            this.tbEDID.Text = this.formIDLookup(this.tbFormID.Text);
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            Canceled = false;
            result = this.bytes.GetBytes();
            resultName = this.tbName.Text;
            Close();
        }

        private void cbInsert_CheckedChanged(object sender, EventArgs e)
        {
            this.hexBox1.InsertActive = this.cbInsert.Checked;
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
                this.bCFloat.Enabled = true;
                this.tbInt.Text = TypeConverter.h2si(this.bytes[pos], this.bytes[pos + 1], this.bytes[pos + 2], this.bytes[pos + 3]).ToString();
                this.tbInt.Enabled = true;
                this.bCInt.Enabled = true;
                this.tbFormID.Text = TypeConverter.h2i(this.bytes[pos], this.bytes[pos + 1], this.bytes[pos + 2], this.bytes[pos + 3]).ToString("X8");
                this.tbFormID.Enabled = true;
                this.bCFormID.Enabled = true;
                this.bLookup.Enabled = true;
            }
            else
            {
                this.tbFloat.Enabled = false;
                this.bCFloat.Enabled = false;
                this.tbInt.Enabled = false;
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

        private void tbFloat_TextChanged(object sender, EventArgs e)
        {
        }

        private void tbName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && !char.IsLetter(e.KeyChar) && e.KeyChar != '_')
            {
                e.Handled = true;
            }
        }

        private void tbName_Leave(object sender, EventArgs e)
        {
            if (this.tbName.Text.Length < 4)
            {
                this.tbName.Text = this.tbName.Text.PadRight(4, '_');
            }
        }
    }
}
