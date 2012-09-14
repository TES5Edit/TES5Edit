namespace TESVSnip.UI.Forms
{
    using System;
    using System.Windows.Forms;

    public partial class MultilineStringEditor : Form
    {
        public MultilineStringEditor()
        {
            this.InitializeComponent();
        }

        public MultilineStringEditor(string text)
        {
            this.Text = text;
            this.InitializeComponent();
        }

        public new string Text { get; set; }

        private void MultilineStringEditor_Load(object sender, EventArgs e)
        {
            this.textBox1.Text = this.Text;
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            this.Text = this.textBox1.Text;
            DialogResult = DialogResult.OK;
            Close();
        }
    }
}
