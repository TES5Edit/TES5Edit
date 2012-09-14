namespace TESVSnip.UI.Forms
{
    using System;
    using System.Globalization;
    using System.Windows.Forms;

    using TESVSnip.Domain.Model;
    using TESVSnip.Properties;

    internal partial class HeaderEditor : Form
    {
        private readonly Record R;

        private uint Flags1;

        private uint Flags2;

        private uint Flags3;

        private uint FormID;

        private HeaderEditor(Record r)
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
            this.R = r;
            this.tbName.Text = r.Name;
            this.Flags1 = r.Flags1;
            this.Flags2 = r.Flags2;
            this.Flags3 = r.Flags3;
            this.FormID = r.FormID;
            this.tbFormID.Text = this.FormID.ToString("x8");
            this.tbFlags2.Text = this.Flags2.ToString("x8");
            this.tbFlags3.Text = this.Flags3.ToString("x8");
            foreach (Control c in Controls)
            {
                if (c is CheckBox)
                {
                    c.Tag = int.Parse((string)c.Tag);
                    if ((this.Flags1 & GetInt(c.Tag)) > 0)
                    {
                        ((CheckBox)c).Checked = true;
                    }
                }
            }

            // cb18.Checked=false; // Allow compression
        }

        public static DialogResult Display(Record r)
        {
            var hr = new HeaderEditor(r);
            return hr.ShowDialog();
        }

        private static uint GetInt(object i)
        {
            return (uint)(1 << (int)i);
        }

        private void HexOnlyKeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                char c = char.ToLowerInvariant(e.KeyChar);
                if (c != 'a' && c != 'b' && c != 'c' && c != 'd' && c != 'e' && c != 'f')
                {
                    e.Handled = true;
                }
            }
        }

        private void HexValidCheck(object sender, EventArgs e)
        {
            var tb = (TextBox)sender;
            if (tb.Text.Length < 8)
            {
                tb.Text = tb.Text.PadLeft(8, '0');
            }

            uint i;
            if (!uint.TryParse(tb.Text, NumberStyles.AllowHexSpecifier, null, out i))
            {
                MessageBox.Show("Invalid hex value", "Error");
                if (tb == this.tbFormID)
                {
                    tb.Text = this.FormID.ToString("x8");
                }
                else if (tb == this.tbFlags2)
                {
                    tb.Text = this.Flags2.ToString("x8");
                }
                else if (tb == this.tbFlags3)
                {
                    tb.Text = this.Flags3.ToString("x8");
                }
            }
            else
            {
                if (tb == this.tbFormID)
                {
                    this.FormID = i;
                }
                else if (tb == this.tbFlags2)
                {
                    this.Flags2 = i;
                }
                else if (tb == this.tbFlags3)
                {
                    this.Flags3 = i;
                }
            }
        }

        private void Save()
        {
            this.Flags1 = 0;
            foreach (Control c in Controls)
            {
                if (c is CheckBox && ((CheckBox)c).Checked)
                {
                    this.Flags1 |= GetInt(c.Tag);
                }
            }
        }

        private void bCancel_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            this.Save();
            if (this.checkHexValue(this.tbFlags2) && this.checkHexValue(this.tbFlags3) && this.checkHexValue(this.tbFormID))
            {
                this.R.Flags1 = this.Flags1;
                this.R.Flags2 = this.Flags2;
                this.R.Flags3 = this.Flags3;
                this.R.FormID = this.FormID;
                if (this.tbName.Text.Length < 4)
                {
                    this.tbName.Text = this.tbName.Text.PadRight(4, '_');
                }

                this.R.Name = this.tbName.Text;
                DialogResult = DialogResult.OK;
                Close();
            }
        }

        private bool checkHexValue(TextBox t)
        {
            uint i;
            if (uint.TryParse(t.Text, NumberStyles.AllowHexSpecifier, null, out i))
            {
                if (t == this.tbFlags2)
                {
                    this.Flags2 = i;
                }
                else if (t == this.tbFlags3)
                {
                    this.Flags3 = i;
                }
                else if (t == this.tbFormID)
                {
                    this.FormID = i;
                }
            }
            else
            {
                MessageBox.Show("Invalid hex value", "Error");
                t.Focus();
                return false;
            }

            return true;
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
