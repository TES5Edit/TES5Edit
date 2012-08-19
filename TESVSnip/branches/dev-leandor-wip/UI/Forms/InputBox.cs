namespace TESVSnip.UI.Forms
{
    using System.Windows.Forms;

    public partial class InputBox : Form
    {
        public InputBox()
        {
            this.InitializeComponent();
        }

        public InputBox(string label)
            : this()
        {
            this.Label = label;
        }

        public InputBox(string label, string caption)
            : this(label)
        {
            Text = caption;
        }

        public InputBox(string label, string value, string caption)
            : this(label, caption)
        {
            this.Value = value;
        }

        public string Caption
        {
            get
            {
                return Text;
            }

            set
            {
                Text = value;
            }
        }

        public string Label
        {
            get
            {
                return this.label1.Text;
            }

            set
            {
                this.label1.Text = value;
            }
        }

        public string Value
        {
            get
            {
                return this.textBox1.Text;
            }

            set
            {
                this.textBox1.Text = value;
            }
        }
    }
}
