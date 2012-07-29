using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using TESVSnip.Collections.Generic;
using TESVSnip.Properties;

namespace TESVSnip.Forms
{
    public partial class StringsEditor : Form
    {
        private class StringHolder
        {
            public Plugin Plugin { get; set; }
            public uint ID { get; set; }
            public string Value { get; set; }
            public LocalizedStringFormat Format { get; set; }
        }

        private readonly AdvancedList<StringHolder> strings = new AdvancedList<StringHolder>();
        private readonly List<StringHolder> addStrings = new List<StringHolder>();
        private readonly List<StringHolder> remStrings = new List<StringHolder>();
        private readonly List<StringHolder> updateStrings = new List<StringHolder>();

        public Plugin[] Plugins { get; set; }

        public StringsEditor()
        {
            InitializeComponent();
            Icon = Resources.tesv_ico;

            cboType.DataSource = Enum.GetNames(typeof (LocalizedStringFormat));
            cboType.SelectedItem = LocalizedStringFormat.Base.ToString();

            listStrings.DataSource = strings;
            listStrings.AddBindingColumn("ID", "ID", 80, new Func<StringHolder, string>(a => a.ID.ToString("X8")));
            listStrings.AddBindingColumn("Plugin", "Source", 80, new Func<StringHolder, string>(a => a.Plugin.Name));
            listStrings.AddBindingColumn("Format", "Format", 50, HorizontalAlignment.Center);
            listStrings.AddBindingColumn("Value", "Value", 500);
        }


        private void PopulateStrings()
        {
            if (Plugins == null)
                return;
            foreach (var plugin in Plugins)
            {
                foreach (var kvp in plugin.Strings)
                {
                    strings.Add(new StringHolder
                                    {
                                        ID = kvp.Key,
                                        Plugin = plugin,
                                        Value = kvp.Value,
                                        Format = LocalizedStringFormat.Base
                                    }
                        );
                }
                foreach (var kvp in plugin.ILStrings)
                {
                    strings.Add(new StringHolder
                                    {
                                        ID = kvp.Key,
                                        Plugin = plugin,
                                        Value = kvp.Value,
                                        Format = LocalizedStringFormat.IL
                                    }
                        );
                }
                foreach (var kvp in plugin.DLStrings)
                {
                    strings.Add(new StringHolder
                                    {
                                        ID = kvp.Key,
                                        Plugin = plugin,
                                        Value = kvp.Value,
                                        Format = LocalizedStringFormat.DL
                                    }
                        );
                }
            }
        }

        private void txtID_Validating(object sender, CancelEventArgs e)
        {
            string strID = txtID.Text;
            if (string.IsNullOrEmpty(strID))
                return;
            uint uiID;
            if (!uint.TryParse(strID, NumberStyles.HexNumber, null, out uiID))
            {
                error.SetError(txtID, "Invalid String ID");
                txtString.Enabled = false;
                btnEditString.Enabled = false;
                btnAddString.Enabled = false;
                btnDeleteString.Enabled = false;
            }
            else
            {
                error.SetError(txtID, null);
                txtString.Enabled = true;
                btnEditString.Enabled = true;
                btnAddString.Enabled = true;
                btnDeleteString.Enabled = true;
            }
        }

        private void txtID_TextChanged(object sender, EventArgs e)
        {
        }

        private void btnEditString_Click(object sender, EventArgs e)
        {
            using (var editor = new MultilineStringEditor())
            {
                editor.Text = txtString.Text;
                DialogResult result = editor.ShowDialog(this);
                if (result == DialogResult.OK)
                {
                    txtString.Text = editor.Text;
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.OK;
            Close();
        }

        private void StringsEditor_Load(object sender, EventArgs e)
        {
            Settings.GetWindowPosition("StringEditor", this);

            Reload(Plugins);
        }

        private void listStrings_DoubleClick(object sender, EventArgs e)
        {
        }

        private void listStrings_Click(object sender, EventArgs e)
        {
            var indices = listStrings.SelectedIndices;
            if (indices.Count > 0)
            {
                int idx = indices[0];
                var str = strings[idx];
                SetSelectedItem(str);
            }
        }

        private void SetSelectedItem(StringHolder str)
        {
            str.ID = str.ID;
            txtID.Text = str.ID.ToString("X8");
            txtString.Text = str.Value;
            cboPlugins.SelectedItem = str.Plugin.Name;
            cboType.SelectedItem = str.Format.ToString();
        }

        private void StringsEditor_ResizeEnd(object sender, EventArgs e)
        {
            listStrings.AutoFitColumnHeaders();
        }

        public void Reload(Plugin[] plugins)
        {
            Plugins = plugins;
            listStrings.DataSource = null;
            strings.Clear();
            addStrings.Clear();
            remStrings.Clear();
            updateStrings.Clear();

            var strPlugins = new List<string>();
            foreach (var plugin in Plugins)
                strPlugins.Add(plugin.Name);
            cboPlugins.DataSource = strPlugins;
            cboPlugins.SelectedIndex = 0;
            PopulateStrings();
            listStrings.DataSource = strings;
            FitColumns();
            UpdateStatusBar();
        }

        private void btnLookup_Click(object sender, EventArgs e)
        {
            string strID = txtID.Text;
            if (string.IsNullOrEmpty(strID))
            {
                MessageBox.Show(this, "ID Field is empty.  Please specify a string ID to find.", "Error",
                                MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            uint uiID;
            if (!uint.TryParse(strID, NumberStyles.HexNumber, null, out uiID))
            {
                MessageBox.Show(this, "Unable to parse string id", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                StringHolder holder = strings.FirstOrDefault(a => a.ID == uiID);
                if (holder != null)
                    SetSelectedItem(holder);
            }
        }

        private void btnNewItem_Click(object sender, EventArgs e)
        {
            ResetEntry();
        }


        private bool TryGetCurrentID(out uint uiID)
        {
            uiID = 0;

            string strID = txtID.Text;
            if (string.IsNullOrEmpty(strID))
                return false;
            return uint.TryParse(strID, NumberStyles.HexNumber, null, out uiID);
        }

        private bool TryGetCurrentFormat(out LocalizedStringFormat format)
        {
            format =
                (LocalizedStringFormat)
                Enum.Parse(typeof (LocalizedStringFormat), cboType.SelectedItem.ToString(), true);
            return true;
        }

        private bool TryGetCurrentPlugin(out Plugin plugin)
        {
            string pluginName = cboPlugins.SelectedItem.ToString();
            plugin = Plugins.FirstOrDefault(a => a.Name == pluginName);
            return (plugin != null);
        }

        private void btnAddString_Click(object sender, EventArgs e)
        {
            uint uiID;
            LocalizedStringFormat format;
            Plugin plugin;
            string text = txtString.Text;
            if (!TryGetCurrentID(out uiID))
            {
                MessageBox.Show(this, "ID Field is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (!TryGetCurrentFormat(out format))
            {
                MessageBox.Show(this, "Format is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (!TryGetCurrentPlugin(out plugin))
            {
                MessageBox.Show(this, "Plugin is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            bool doResize = strings.Count == 0;

            StringHolder str = strings.FirstOrDefault(
                a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (str == null)
            {
                str = new StringHolder
                          {
                              ID = uiID,
                              Plugin = plugin,
                              Value = text,
                              Format = format
                          };
                strings.Add(str);
            }

            StringHolder addStr = addStrings.FirstOrDefault(
                a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (addStr == null)
                addStrings.Add(str);

            if (doResize)
                FitColumns();

            UpdateStatusBar();
        }

        private void btnDeleteString_Click(object sender, EventArgs e)
        {
            uint uiID;
            LocalizedStringFormat format;
            Plugin plugin;
            string text = txtString.Text;
            if (!TryGetCurrentID(out uiID))
            {
                MessageBox.Show(this, "ID Field is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (!TryGetCurrentFormat(out format))
            {
                MessageBox.Show(this, "Format is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (!TryGetCurrentPlugin(out plugin))
            {
                MessageBox.Show(this, "Plugin is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            bool doResize = strings.Count == 0;

            StringHolder str = strings.FirstOrDefault(
                a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (str != null)
                strings.Remove(str);

            StringHolder remStr = remStrings.FirstOrDefault(
                a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (remStr == null)
                remStrings.Add(str);

            if (doResize)
                FitColumns();

            UpdateStatusBar();
        }


        private void FitColumns()
        {
            Application.DoEvents(); // handle outstanding events then do column sizing
            listStrings.AutoFitColumnHeaders();
        }

        private LocalizedStringDict GetStringDict(Plugin plugin, LocalizedStringFormat format)
        {
            LocalizedStringDict strings = null;
            switch (format)
            {
                case LocalizedStringFormat.Base:
                    strings = plugin.Strings;
                    break;
                case LocalizedStringFormat.DL:
                    strings = plugin.DLStrings;
                    break;
                case LocalizedStringFormat.IL:
                    strings = plugin.ILStrings;
                    break;
            }
            return strings;
        }

        private void ResetEntry()
        {
            Plugin plugin;
            if (!TryGetCurrentPlugin(out plugin))
            {
                txtID.Text = "";
                txtString.Text = "";
            }
            else
            {
                LocalizedStringFormat format;
                if (!TryGetCurrentFormat(out format))
                {
                    txtID.Text = "";
                    txtString.Text = "";
                }
                else
                {
                    LocalizedStringDict strings = GetStringDict(plugin, format);
                    if (strings != null)
                    {
                        if (strings.Count == 0)
                        {
                            txtID.Text = 1.ToString("X8");
                            txtString.Text = "";
                        }
                        else
                        {
                            uint max = strings.Max(a => a.Key);
                            txtID.Text = (max + 1).ToString("X8");
                            txtString.Text = "";
                        }
                    }
                }
            }
        }

        private void StringsEditor_FormClosing(object sender, FormClosingEventArgs e)
        {
            Settings.SetWindowPosition("StringEditor", this);
        }

        private void UpdateStatusBar()
        {
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            ApplyChanges();
        }

        private void ApplyChanges()
        {
            foreach (var change in remStrings)
            {
                LocalizedStringDict dict = GetStringDict(change.Plugin, change.Format);
                if (dict != null)
                {
                    dict.Remove(change.ID);
                    change.Plugin.StringsDirty = true;
                }
            }
            foreach (var change in addStrings)
            {
                LocalizedStringDict dict = GetStringDict(change.Plugin, change.Format);
                if (dict != null)
                {
                    dict[change.ID] = change.Value;
                    change.Plugin.StringsDirty = true;
                }
            }
            foreach (var change in updateStrings)
            {
                LocalizedStringDict dict = GetStringDict(change.Plugin, change.Format);
                if (dict != null)
                {
                    dict[change.ID] = change.Value;
                    change.Plugin.StringsDirty = true;
                }
            }
            UpdateStatusBar();
        }
    }
}