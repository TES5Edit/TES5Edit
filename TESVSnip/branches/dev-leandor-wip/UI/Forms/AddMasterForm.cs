namespace TESVSnip.UI.Forms
{
    using System;
    using System.IO;
    using System.Windows.Forms;

    public partial class AddMasterForm : Form
    {
        public AddMasterForm()
        {
            this.InitializeComponent();
            this.ofdChooseMaster.InitialDirectory = Path.GetFullPath("data");
            this.ofdChooseMaster.FileName = "skyrim.esm";
            this.ofdChooseMaster.Filter = "Masters or Plugins (*.esm,*.esp)|*.esm;*.esp|Masters(*.esm)|*.esm|Plugins (*.esp)|*.esp";
        }

        public string MasterName
        {
            get
            {
                return this.tbxMaster.Text;
            }
        }

        private void butChooseMaster_Click(object sender, EventArgs e)
        {
            if (this.ofdChooseMaster.ShowDialog() == DialogResult.OK)
            {
                this.tbxMaster.Text = Path.GetFileName(this.ofdChooseMaster.FileName);
            }
        }

        private void butOK_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.OK;
        }
    }
}
