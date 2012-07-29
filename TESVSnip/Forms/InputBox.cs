using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace TESVSnip.Forms
{
    public partial class InputBox : Form
    {
        public InputBox()
        {
            InitializeComponent();
        }

        public InputBox(string label) : this()
        {
            this.Label = label;
        }
        
        public InputBox(string label, string caption) : this(label)
        {
            this.Text = caption;
        }

        public InputBox(string label, string value, string caption):this(label, caption)
        {
            this.Value = value;
        }

        public string Label
        {
            get { return this.label1.Text; }
            set { this.label1.Text = value; }
        }
        
        public string Caption
        {
            get { return this.Text; }
            set { this.Text = value; }
        }

        public string Value
        {
            get { return this.textBox1.Text; }
            set { this.textBox1.Text = value; }
        }

    }
}
