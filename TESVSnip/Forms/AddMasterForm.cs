using System;
using System.IO;
using System.Windows.Forms;

namespace TESVSnip
{
    public partial class AddMasterForm : Form
    {
        public string MasterName
        {
            get { return tbxMaster.Text; }
        }

        public AddMasterForm()
        {
            InitializeComponent();
            ofdChooseMaster.InitialDirectory = Path.GetFullPath("data");
            ofdChooseMaster.FileName = "skyrim.esm";
            ofdChooseMaster.Filter =
                "Masters or Plugins (*.esm,*.esp)|*.esm;*.esp|Masters(*.esm)|*.esm|Plugins (*.esp)|*.esp";
        }

        private void butOK_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.OK;
        }

        private void butChooseMaster_Click(object sender, EventArgs e)
        {
            if (ofdChooseMaster.ShowDialog() == DialogResult.OK)
                tbxMaster.Text = Path.GetFileName(ofdChooseMaster.FileName);
        }
    }
}