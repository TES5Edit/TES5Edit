namespace TESVSnip.UI.Forms
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Windows.Forms;

    using TESVSnip.Properties;

    public partial class CompressSettings : Form
    {
        public CompressSettings()
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
        }

        private void LoadSettings_Load(object sender, EventArgs e)
        {
            this.rdoDefaultCompressRecords.Checked = Settings.Default.UseDefaultRecordCompression;
            this.rdoNeverCompressRecords.Checked = !Settings.Default.UseDefaultRecordCompression;
            this.chkEnableAutoCompress.Checked = Settings.Default.EnableAutoCompress;
            this.chkEnableCompressLimit.Checked = Settings.Default.EnableCompressionLimit;
            this.txtCompressLimit.Text = Settings.Default.CompressionLimit.ToString();

            // Groups
            var records = Settings.Default.AutoCompressRecords != null ? Settings.Default.AutoCompressRecords.Trim().Split(new[] { ';', ',' }, StringSplitOptions.RemoveEmptyEntries) : new string[0];
            var allGroups = Settings.Default.AllESMRecords != null
                                ? Settings.Default.AllESMRecords.Trim().Split(new[] { ';', ',' }, StringSplitOptions.RemoveEmptyEntries).ToList()
                                : new List<string>();
            foreach (var str in records)
            {
                this.listRecordFilter.Items.Add(str, CheckState.Checked);
                allGroups.Remove(str);
            }

            allGroups.Sort();
            foreach (var str in allGroups)
            {
                this.listRecordFilter.Items.Add(str, CheckState.Unchecked);
            }

            this.UpdateState();
        }

        private void UpdateState()
        {
            this.grpCompSettings.Enabled = this.rdoDefaultCompressRecords.Checked;
            this.listRecordFilter.Enabled = this.chkEnableAutoCompress.Checked;
            this.txtCompressLimit.Enabled = this.chkEnableCompressLimit.Checked;
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            Settings.Default.UseDefaultRecordCompression = this.rdoDefaultCompressRecords.Checked;
            Settings.Default.EnableCompressionLimit = this.chkEnableCompressLimit.Checked;
            Settings.Default.CompressionLimit = uint.Parse(this.txtCompressLimit.Text);
            Settings.Default.EnableAutoCompress = this.chkEnableAutoCompress.Checked;
            Settings.Default.AutoCompressRecords = string.Join(";", this.listRecordFilter.CheckedItems.Cast<string>().ToArray());
            Settings.Default.Save();
        }

        private void btnToggleAll_Click(object sender, EventArgs e)
        {
            bool anyChecked = this.listRecordFilter.CheckedItems.Count > 0;
            for (int i = 0, n = this.listRecordFilter.Items.Count; i < n; ++i)
            {
                this.listRecordFilter.SetItemChecked(i, !anyChecked);
            }
        }

        private void chkEnableAutoCompress_CheckedChanged(object sender, EventArgs e)
        {
            this.UpdateState();
        }

        private void chkEnableCompressLimit_CheckedChanged(object sender, EventArgs e)
        {
            this.UpdateState();
        }

        private void rdoNeverCompressRecords_CheckedChanged(object sender, EventArgs e)
        {
            this.UpdateState();
        }
    }
}
