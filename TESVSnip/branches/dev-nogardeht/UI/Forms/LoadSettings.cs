namespace TESVSnip.UI.Forms
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Windows.Forms;

    using TESVSnip.Framework.Services;
    using TESVSnip.Properties;

    public partial class LoadSettings : Form
    {
        public LoadSettings()
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
        }

        private void LoadSettings_Load(object sender, EventArgs e)
        {
            // clear the first time check if set as user has visited this form
            Settings.Default.IsFirstTimeOpeningSkyrimESM = false;

            this.chkApplyToAllESM.Checked = Settings.Default.ApplyFilterToAllESM;
            this.chkDontAskAboutFiltering.Checked = Settings.Default.DontAskUserAboutFiltering;
            this.checkBox1.Checked = Settings.Default.EnableESMFilter;

            // this.rtfWarning = TESsnip.Properties.Resources.
            using (var s = new MemoryStream())
            {
                byte[] bytes = Encoding.Instance.GetBytes(Resources.LoadWarning);
                s.Write(bytes, 0, bytes.Length);
                s.Position = 0;
                this.rtfWarning.LoadFile(s, RichTextBoxStreamType.RichText);
            }

            // Groups
            var records = Settings.Default.FilteredESMRecords != null ? Settings.Default.FilteredESMRecords.Trim().Split(new[] { ';', ',' }, StringSplitOptions.RemoveEmptyEntries) : new string[0];
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
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            Settings.Default.ApplyFilterToAllESM = this.chkApplyToAllESM.Checked;
            Settings.Default.DontAskUserAboutFiltering = this.chkDontAskAboutFiltering.Checked;
            Settings.Default.EnableESMFilter = this.checkBox1.Checked;

            Settings.Default.FilteredESMRecords = string.Join(";", this.listRecordFilter.CheckedItems.Cast<string>().ToArray());
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

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            this.listRecordFilter.Enabled = this.checkBox1.Checked;
        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {
        }
    }
}
