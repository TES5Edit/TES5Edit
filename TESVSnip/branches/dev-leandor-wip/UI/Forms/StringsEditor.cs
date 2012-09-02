namespace TESVSnip.UI.Forms
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Globalization;
    using System.Linq;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.Strings;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework.Collections;
    using TESVSnip.Properties;

    using Settings = TESVSnip.Domain.Services.Settings;

    public partial class StringsEditor : Form
    {
        private readonly List<StringHolder> addStrings = new List<StringHolder>();

        private readonly List<StringHolder> remStrings = new List<StringHolder>();

        private readonly AdvancedList<StringHolder> strings = new AdvancedList<StringHolder>();

        private readonly List<StringHolder> updateStrings = new List<StringHolder>();

        public StringsEditor()
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;

            this.cboType.DataSource = Enum.GetNames(typeof(LocalizedStringFormat));
            this.cboType.SelectedItem = LocalizedStringFormat.Base.ToString();

            this.listStrings.DataSource = this.strings;
            this.listStrings.AddBindingColumn("ID", "ID", 80, new Func<StringHolder, string>(a => a.ID.ToString("X8")));
            this.listStrings.AddBindingColumn("Plugin", "Source", 80, new Func<StringHolder, string>(a => a.Plugin.Name));
            this.listStrings.AddBindingColumn("Format", "Format", 50, HorizontalAlignment.Center);
            this.listStrings.AddBindingColumn("Value", "Value", 500);
        }

        public Plugin[] Plugins { get; set; }

        public void Reload(Plugin[] plugins)
        {
            this.Plugins = plugins;
            this.listStrings.DataSource = null;
            this.strings.Clear();
            this.addStrings.Clear();
            this.remStrings.Clear();
            this.updateStrings.Clear();

            var strPlugins = new List<string>();
            foreach (var plugin in this.Plugins)
            {
                strPlugins.Add(plugin.Name);
            }

            this.cboPlugins.DataSource = strPlugins;
            this.cboPlugins.SelectedIndex = 0;
            this.PopulateStrings();
            this.listStrings.DataSource = this.strings;
            this.FitColumns();
            this.UpdateStatusBar();
        }

        private void ApplyChanges()
        {
            foreach (var change in this.remStrings)
            {
                LocalizedStringDict dict = this.GetStringDict(change.Plugin, change.Format);
                if (dict != null)
                {
                    dict.Remove(change.ID);
                    change.Plugin.StringsDirty = true;
                }
            }

            foreach (var change in this.addStrings)
            {
                LocalizedStringDict dict = this.GetStringDict(change.Plugin, change.Format);
                if (dict != null)
                {
                    dict[change.ID] = change.Value;
                    change.Plugin.StringsDirty = true;
                }
            }

            foreach (var change in this.updateStrings)
            {
                LocalizedStringDict dict = this.GetStringDict(change.Plugin, change.Format);
                if (dict != null)
                {
                    dict[change.ID] = change.Value;
                    change.Plugin.StringsDirty = true;
                }
            }

            this.UpdateStatusBar();
        }

        private void FitColumns()
        {
            Application.DoEvents(); // handle outstanding events then do column sizing
            this.listStrings.AutoFitColumnHeaders();
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

        private void PopulateStrings()
        {
            if (this.Plugins == null)
            {
                return;
            }

            foreach (var plugin in this.Plugins)
            {
                foreach (var kvp in plugin.Strings)
                {
                    this.strings.Add(new StringHolder { ID = kvp.Key, Plugin = plugin, Value = kvp.Value, Format = LocalizedStringFormat.Base });
                }

                foreach (var kvp in plugin.ILStrings)
                {
                    this.strings.Add(new StringHolder { ID = kvp.Key, Plugin = plugin, Value = kvp.Value, Format = LocalizedStringFormat.IL });
                }

                foreach (var kvp in plugin.DLStrings)
                {
                    this.strings.Add(new StringHolder { ID = kvp.Key, Plugin = plugin, Value = kvp.Value, Format = LocalizedStringFormat.DL });
                }
            }
        }

        private void ResetEntry()
        {
            Plugin plugin;
            if (!this.TryGetCurrentPlugin(out plugin))
            {
                this.txtID.Text = string.Empty;
                this.txtString.Text = string.Empty;
            }
            else
            {
                LocalizedStringFormat format;
                if (!this.TryGetCurrentFormat(out format))
                {
                    this.txtID.Text = string.Empty;
                    this.txtString.Text = string.Empty;
                }
                else
                {
                    LocalizedStringDict strings = this.GetStringDict(plugin, format);
                    if (strings != null)
                    {
                        if (strings.Count == 0)
                        {
                            this.txtID.Text = 1.ToString("X8");
                            this.txtString.Text = string.Empty;
                        }
                        else
                        {
                            uint max = strings.Max(a => a.Key);
                            this.txtID.Text = (max + 1).ToString("X8");
                            this.txtString.Text = string.Empty;
                        }
                    }
                }
            }
        }

        private void SetSelectedItem(StringHolder str)
        {
            str.ID = str.ID;
            this.txtID.Text = str.ID.ToString("X8");
            this.txtString.Text = str.Value;
            this.cboPlugins.SelectedItem = str.Plugin.Name;
            this.cboType.SelectedItem = str.Format.ToString();
        }

        private void StringsEditor_FormClosing(object sender, FormClosingEventArgs e)
        {
            Settings.SetWindowPosition("StringEditor", this);
        }

        private void StringsEditor_Load(object sender, EventArgs e)
        {
            Settings.GetWindowPosition("StringEditor", this);

            this.Reload(this.Plugins);
        }

        private void StringsEditor_ResizeEnd(object sender, EventArgs e)
        {
            this.listStrings.AutoFitColumnHeaders();
        }

        private bool TryGetCurrentFormat(out LocalizedStringFormat format)
        {
            format = (LocalizedStringFormat)Enum.Parse(typeof(LocalizedStringFormat), this.cboType.SelectedItem.ToString(), true);
            return true;
        }

        private bool TryGetCurrentID(out uint uiID)
        {
            uiID = 0;

            string strID = this.txtID.Text;
            if (string.IsNullOrEmpty(strID))
            {
                return false;
            }

            return uint.TryParse(strID, NumberStyles.HexNumber, null, out uiID);
        }

        private bool TryGetCurrentPlugin(out Plugin plugin)
        {
            string pluginName = this.cboPlugins.SelectedItem.ToString();
            plugin = this.Plugins.FirstOrDefault(a => a.Name == pluginName);
            return plugin != null;
        }

        private void UpdateStatusBar()
        {
        }

        private void btnAddString_Click(object sender, EventArgs e)
        {
            uint uiID;
            LocalizedStringFormat format;
            Plugin plugin;
            string text = this.txtString.Text;
            if (!this.TryGetCurrentID(out uiID))
            {
                MessageBox.Show(this, "ID Field is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (!this.TryGetCurrentFormat(out format))
            {
                MessageBox.Show(this, "Format is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (!this.TryGetCurrentPlugin(out plugin))
            {
                MessageBox.Show(this, "Plugin is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            bool doResize = this.strings.Count == 0;

            StringHolder str = this.strings.FirstOrDefault(a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (str == null)
            {
                str = new StringHolder { ID = uiID, Plugin = plugin, Value = text, Format = format };
                this.strings.Add(str);
            }

            StringHolder addStr = this.addStrings.FirstOrDefault(a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (addStr == null)
            {
                this.addStrings.Add(str);
            }

            if (doResize)
            {
                this.FitColumns();
            }

            this.UpdateStatusBar();
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            this.ApplyChanges();
        }

        private void btnDeleteString_Click(object sender, EventArgs e)
        {
            uint uiID;
            LocalizedStringFormat format;
            Plugin plugin;
            string text = this.txtString.Text;
            if (!this.TryGetCurrentID(out uiID))
            {
                MessageBox.Show(this, "ID Field is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (!this.TryGetCurrentFormat(out format))
            {
                MessageBox.Show(this, "Format is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (!this.TryGetCurrentPlugin(out plugin))
            {
                MessageBox.Show(this, "Plugin is invalid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            bool doResize = this.strings.Count == 0;

            StringHolder str = this.strings.FirstOrDefault(a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (str != null)
            {
                this.strings.Remove(str);
            }

            StringHolder remStr = this.remStrings.FirstOrDefault(a => (a.ID == uiID && a.Plugin.Equals(plugin) && a.Format == format));
            if (remStr == null)
            {
                this.remStrings.Add(str);
            }

            if (doResize)
            {
                this.FitColumns();
            }

            this.UpdateStatusBar();
        }

        private void btnEditString_Click(object sender, EventArgs e)
        {
            using (var editor = new MultilineStringEditor())
            {
                editor.Text = this.txtString.Text;
                DialogResult result = editor.ShowDialog(this);
                if (result == DialogResult.OK)
                {
                    this.txtString.Text = editor.Text;
                }
            }
        }

        private void btnLookup_Click(object sender, EventArgs e)
        {
            string strID = this.txtID.Text;
            if (string.IsNullOrEmpty(strID))
            {
                MessageBox.Show(this, "ID Field is empty.  Please specify a string ID to find.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            uint uiID;
            if (!uint.TryParse(strID, NumberStyles.HexNumber, null, out uiID))
            {
                MessageBox.Show(this, "Unable to parse string id", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                StringHolder holder = this.strings.FirstOrDefault(a => a.ID == uiID);
                if (holder != null)
                {
                    this.SetSelectedItem(holder);
                }
            }
        }

        private void btnNewItem_Click(object sender, EventArgs e)
        {
            this.ResetEntry();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.OK;
            Close();
        }

        private void listStrings_Click(object sender, EventArgs e)
        {
            var indices = this.listStrings.SelectedIndices;
            if (indices.Count > 0)
            {
                int idx = indices[0];
                var str = this.strings[idx];
                this.SetSelectedItem(str);
            }
        }

        private void listStrings_DoubleClick(object sender, EventArgs e)
        {
        }

        private void txtID_TextChanged(object sender, EventArgs e)
        {
        }

        private void txtID_Validating(object sender, CancelEventArgs e)
        {
            string strID = this.txtID.Text;
            if (string.IsNullOrEmpty(strID))
            {
                return;
            }

            uint uiID;
            if (!uint.TryParse(strID, NumberStyles.HexNumber, null, out uiID))
            {
                this.error.SetError(this.txtID, "Invalid String ID");
                this.txtString.Enabled = false;
                this.btnEditString.Enabled = false;
                this.btnAddString.Enabled = false;
                this.btnDeleteString.Enabled = false;
            }
            else
            {
                this.error.SetError(this.txtID, null);
                this.txtString.Enabled = true;
                this.btnEditString.Enabled = true;
                this.btnAddString.Enabled = true;
                this.btnDeleteString.Enabled = true;
            }
        }

        private class StringHolder
        {
            public LocalizedStringFormat Format { get; set; }

            public uint ID { get; set; }

            public Plugin Plugin { get; set; }

            public string Value { get; set; }
        }
    }
}
