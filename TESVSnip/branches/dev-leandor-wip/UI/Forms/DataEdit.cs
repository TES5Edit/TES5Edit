namespace TESVSnip.UI.Forms
{
    using System;
    using System.Windows.Forms;

    using TESVSnip.Properties;

    internal partial class DataEdit : Form
    {
        public static bool Canceled;

        public static byte[] result;

        public static string resultName;

        public DataEdit(string RecName, byte[] data)
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
            Text += RecName;
            this.tbName.Text = RecName;
            Text += " (string mode)";
            string s = string.Empty;
            foreach (byte b in data)
            {
                s += (char)b;
            }

            this.tbEdit.Text = s;
            Canceled = true;
        }

        private void bCancel_Click(object sender, EventArgs e)
        {
            Canceled = true;
            Close();
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            Canceled = false;
            result = new byte[this.tbEdit.Text.Length + 1];
            for (int i = 0; i < this.tbEdit.Text.Length; i++)
            {
                result[i] = (byte)this.tbEdit.Text[i];
            }

            result[this.tbEdit.Text.Length] = 0;
            resultName = this.tbName.Text;
            Close();
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
