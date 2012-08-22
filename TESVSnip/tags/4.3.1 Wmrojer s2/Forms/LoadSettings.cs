using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using TESVSnip.Properties;

namespace TESVSnip.Forms
{
    public partial class LoadSettings : Form
    {
        public LoadSettings()
        {
            InitializeComponent();
            Icon = Resources.tesv_ico;
        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {
        }

        private void LoadSettings_Load(object sender, EventArgs e)
        {
            // clear the first time check if set as user has visited this form
            Properties.Settings.Default.IsFirstTimeOpeningSkyrimESM = false;

            chkApplyToAllESM.Checked = Properties.Settings.Default.ApplyFilterToAllESM;
            chkDontAskAboutFiltering.Checked = Properties.Settings.Default.DontAskUserAboutFiltering;
            checkBox1.Checked = Properties.Settings.Default.EnableESMFilter;
            //this.rtfWarning = TESsnip.Properties.Resources.
            using (var s = new MemoryStream())
            {
                byte[] bytes = Encoding.CP1252.GetBytes(Resources.LoadWarning);
                s.Write(bytes, 0, bytes.Length);
                s.Position = 0;
                rtfWarning.LoadFile(s, RichTextBoxStreamType.RichText);
            }


            // Groups
            var records = Properties.Settings.Default.FilteredESMRecords != null
                              ? Properties.Settings.Default.FilteredESMRecords.Trim().Split(new[] {';', ','},
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
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            listRecordFilter.Enabled = checkBox1.Checked;
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            Properties.Settings.Default.ApplyFilterToAllESM = chkApplyToAllESM.Checked;
            Properties.Settings.Default.DontAskUserAboutFiltering = chkDontAskAboutFiltering.Checked;
            Properties.Settings.Default.EnableESMFilter = checkBox1.Checked;

            Properties.Settings.Default.FilteredESMRecords = string.Join(";",
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
    }
}