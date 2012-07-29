using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using TESVSnip.Properties;

namespace TESVSnip.Forms
{
    public partial class CompressSettings : Form
    {
        public CompressSettings()
        {
            InitializeComponent();
            Icon = Resources.tesv_ico;
        }

        private void LoadSettings_Load(object sender, EventArgs e)
        {
            rdoDefaultCompressRecords.Checked = Properties.Settings.Default.UseDefaultRecordCompression;
            rdoNeverCompressRecords.Checked = !Properties.Settings.Default.UseDefaultRecordCompression;
            chkEnableAutoCompress.Checked = Properties.Settings.Default.EnableAutoCompress;
            chkEnableCompressLimit.Checked = Properties.Settings.Default.EnableCompressionLimit;
            txtCompressLimit.Text = Properties.Settings.Default.CompressionLimit.ToString();

            // Groups
            var records = Properties.Settings.Default.AutoCompressRecords != null
                              ? Properties.Settings.Default.AutoCompressRecords.Trim().Split(new[] {';', ','},
                                                                                             StringSplitOptions.
                                                                                                 RemoveEmptyEntries)
                              : new string[0];
            var allGroups = Properties.Settings.Default.AllESMRecords != null
                                ? Properties.Settings.Default.AllESMRecords.Trim().Split(new[] {';', ','},
                                                                                         StringSplitOptions.
                                                                                             RemoveEmptyEntries).ToList()
                                : new List<string>();
            foreach (var str in records)
            {
                listRecordFilter.Items.Add(str, CheckState.Checked);
                allGroups.Remove(str);
            }
            allGroups.Sort();
            foreach (var str in allGroups)
            {
                listRecordFilter.Items.Add(str, CheckState.Unchecked);
            }
            UpdateState();
        }

        private void chkEnableAutoCompress_CheckedChanged(object sender, EventArgs e)
        {
            UpdateState();
        }

        private void rdoNeverCompressRecords_CheckedChanged(object sender, EventArgs e)
        {
            UpdateState();
        }

        private void UpdateState()
        {
            grpCompSettings.Enabled = rdoDefaultCompressRecords.Checked;
            listRecordFilter.Enabled = chkEnableAutoCompress.Checked;
            txtCompressLimit.Enabled = chkEnableCompressLimit.Checked;
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            Properties.Settings.Default.UseDefaultRecordCompression = rdoDefaultCompressRecords.Checked;
            Properties.Settings.Default.EnableCompressionLimit = chkEnableCompressLimit.Checked;
            Properties.Settings.Default.CompressionLimit = uint.Parse(txtCompressLimit.Text);
            Properties.Settings.Default.EnableAutoCompress = chkEnableAutoCompress.Checked;
            Properties.Settings.Default.AutoCompressRecords = string.Join(";",
                                                                          listRecordFilter.CheckedItems.Cast<string>().
                                                                              ToArray());
            Properties.Settings.Default.Save();
        }

        private void btnToggleAll_Click(object sender, EventArgs e)
        {
            bool anyChecked = listRecordFilter.CheckedItems.Count > 0;
            for (int i = 0, n = listRecordFilter.Items.Count; i < n; ++i)
                listRecordFilter.SetItemChecked(i, !anyChecked);
        }

        private void chkEnableCompressLimit_CheckedChanged(object sender, EventArgs e)
        {
            UpdateState();
        }
    }
}