using System;
using System.Windows.Forms;

namespace TESVSnip.Forms
{
    public partial class MultilineStringEditor : Form
    {
        public MultilineStringEditor()
        {
            InitializeComponent();
        }

        public MultilineStringEditor(string text)
        {
            Text = text;
            InitializeComponent();
        }

        public new String Text { get; set; }

        private void btnOK_Click(object sender, EventArgs e)
        {
            Text = textBox1.Text;
            DialogResult = DialogResult.OK;
            Close();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }

        private void MultilineStringEditor_Load(object sender, EventArgs e)
        {
            textBox1.Text = Text;
        }
    }
}