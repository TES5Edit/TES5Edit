namespace TESVSnip.UI.Forms
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Windows.Forms;

    using BrightIdeasSoftware;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Properties;

    internal partial class SearchFilterBasic : Form
    {
        private bool initialized;

        private OLVColumn olvColumnCond;

        private OLVColumn olvColumnName;

        private OLVColumn olvColumnValue;

        public SearchFilterBasic()
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
        }

        // internal SearchFilterBasic(RecordStructure rec)
        // : this()
        // {
        // this.filterTree.Roots = ConfigureRecord(rec);
        // }
        public SearchCriteriaSettings Criteria { get; set; }

        public IEnumerable<SearchSubrecord> ConfigureRecord(RecordStructure rec)
        {
            this.cboRecordType.SelectedItem = rec;
            if (rec == null)
            {
                return null;
            }
            else
            {
                var srs = (from sr in rec.subrecords
                           let children = sr.elements.Select(se => new SearchElement() { Name = se.name, Parent = null, Record = se, Type = SearchCondElementType.Exists, Checked = false }).ToList()
                           select new SearchSubrecord() { Name = string.Format("{0}: {1}", sr.name, sr.desc), Checked = false, Record = sr, Children = children }).ToList();

                // fix parents after assignments
                foreach (var sr in srs)
                {
                    foreach (var se in sr.Children)
                    {
                        se.Parent = sr;
                    }
                }

                return srs;
            }
        }

        public void EnableFindAll(bool value)
        {
            this.bSave.Visible = value;
        }

        public void Initialize()
        {
            if (!this.initialized)
            {
                this.InitializeSearches();
                this.InitializeComboBox();
                this.InitializeTreeList();
                this.initialized = true;
            }
        }

        public void SetRecordStructure(RecordStructure rec)
        {
            this.Initialize();
            this.filterTree.Roots = this.ConfigureRecord(rec);
        }

        private bool ApplySettings()
        {
            var recStruct = this.cboRecordType.SelectedItem as ComboBoxItem<RecordStructure>;
            if (recStruct == null)
            {
                DialogResult = DialogResult.None;
                MessageBox.Show(this, "No record was selected.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
            }
            else
            {
                var checkeditems = this.filterTree.CheckedObjectsEnumerable;
                var items = checkeditems.OfType<SearchCriteria>().ToArray();
                if (items.Length == 0)
                {
                    DialogResult = DialogResult.None;
                    MessageBox.Show(this, "No search criteria was selected.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
                }
                else
                {
                    this.Criteria = new SearchCriteriaSettings();
                    this.Criteria.Type = recStruct.Value.name;
                    this.Criteria.Items = items;
                    return true;
                }
            }

            return false;
        }

        private void AssignCriteria(SearchCriteriaSettings settings)
        {
            if (settings != null)
            {
                var checkedItems = new ArrayList();
                var modelItems = this.filterTree.Roots.OfType<SearchSubrecord>();

                foreach (var item in settings.Items.OfType<SearchSubrecord>())
                {
                    var modelItem = modelItems.FirstOrDefault(x => x.Name == item.Name);
                    if (modelItem != null)
                    {
                        modelItem.Checked = true;
                        modelItem.Type = item.Type;
                        checkedItems.Add(modelItem);
                    }
                }

                foreach (var item in settings.Items.OfType<SearchElement>())
                {
                    var modelItem = modelItems.FirstOrDefault(x => x.Name == item.Parent.Name);
                    if (modelItem != null)
                    {
                        this.filterTree.Expand(modelItem);
                        var modelElem = modelItem.Children.FirstOrDefault(x => x.Name == item.Name);
                        if (modelElem != null)
                        {
                            modelElem.Checked = true;
                            modelElem.Type = item.Type;
                            modelElem.Value = item.Value;
                            checkedItems.Add(modelElem);
                        }
                    }
                }

                this.filterTree.CheckObjects(checkedItems);
            }
        }

        private void AssignCriteria(SearchCriteriaXmlSettings settings)
        {
            if (settings != null)
            {
                var checkedItems = new ArrayList();
                var modelItems = this.filterTree.Roots.OfType<SearchSubrecord>();

                foreach (var item in settings.Items.OfType<SearchSubrecordXml>())
                {
                    var modelItem = modelItems.FirstOrDefault(x => x.Record.name == item.SubRecord);
                    if (modelItem != null)
                    {
                        modelItem.Checked = true;
                        modelItem.Type = item.Type;
                        checkedItems.Add(modelItem);
                    }
                }

                foreach (var item in settings.Items.OfType<SearchElementXml>())
                {
                    var modelItem = modelItems.FirstOrDefault(x => x.Record.name == item.SubRecord);
                    if (modelItem != null)
                    {
                        this.filterTree.Expand(modelItem);
                        var modelElem = modelItem.Children.FirstOrDefault(x => x.Name == item.Element);
                        if (modelElem != null)
                        {
                            modelElem.Checked = true;
                            modelElem.Type = item.Type;
                            modelElem.Value = item.Value;
                            checkedItems.Add(modelElem);
                        }
                    }
                }

                this.filterTree.CheckObjects(checkedItems);
            }
        }

        private void InitializeComboBox()
        {
            var records =
                RecordStructure.Records.Values.Select(x => new ComboBoxItem<RecordStructure> { Name = string.Format("{0}: {1}", x.name, x.description), Value = x }).OrderBy(x => x.Name).OfType<object>
                    ().ToArray();
            this.cboRecordType.Items.Clear();
            this.cboRecordType.Items.AddRange(records);
            if (this.Criteria != null && !string.IsNullOrEmpty(this.Criteria.Type))
            {
                this.cboRecordType.SelectedItem = RecordStructure.Records[this.Criteria.Type];
            }
        }

        private void InitializeSearches()
        {
            this.cboSavedSearches.Items.Clear();
            this.LoadSearches();
        }

        private void InitializeTreeList()
        {
            this.filterTree.SelectionChanged += this.filterTree_SelectionChanged;
            this.filterTree.SelectedIndexChanged += this.filterTree_SelectedIndexChanged;
            this.filterTree.SizeChanged += this.filterTree_SizeChanged;
            this.filterTree.Enter += this.filterTree_Enter;
            this.filterTree.KeyDown += this.filterTree_KeyDown;
            this.filterTree.MouseDoubleClick += this.filterTree_MouseDoubleClick;

            this.filterTree.MultiSelect = true;
            this.filterTree.CanExpandGetter = x => (x is SearchSubrecord);
            this.filterTree.ChildrenGetter = x => {
                var r = x as SearchSubrecord;
                return (r != null) ? r.Children : null;
            };

            this.olvColumnName = new OLVColumn
                {
                    Name = "Name", 
                    Text = "Name", 
                    AspectName = "Name", 
                    Width = 175, 
                    IsVisible = true, 
                    IsEditable = false, 
                    AspectGetter = x => {
                        var r = x as SearchCriteria;
                        return (r != null) ? r.Name : x;
                    }
                };
            this.olvColumnCond = new OLVColumn
                {
                    Name = "Cond", 
                    Text = "Cond", 
                    AspectName = "Cond", 
                    Width = 100, 
                    IsVisible = true, 
                    IsEditable = true, 
                    AspectGetter = x => (x is SearchSubrecord) ? (object)((SearchSubrecord)x).Type : (x is SearchElement) ? (object)((SearchElement)x).Type : null, 
                    AspectPutter = (x, v) => {
                        if (x is SearchSubrecord)
                        {
                            ((SearchSubrecord)x).Type = (SearchCondRecordType)v;
                        }

                        if (x is SearchElement)
                        {
                            ((SearchElement)x).Type = (SearchCondElementType)v;
                        }
                    }, 
                };
            this.olvColumnValue = new OLVColumn
                {
                    Name = "Value", 
                    Text = "Value", 
                    AspectName = "Value", 
                    Width = 100, 
                    IsVisible = true, 
                    IsEditable = true, 
                    AspectGetter = x => {
                        var r = x as SearchElement;
                        return (r != null) ? r.Value : null;
                    }
                };
            this.filterTree.Columns.Add(this.olvColumnName);
            this.filterTree.Columns.Add(this.olvColumnCond);
            this.filterTree.Columns.Add(this.olvColumnValue);
            this.filterTree.CellEditActivation = ObjectListView.CellEditActivateMode.SingleClick;

            this.filterTree.Roots = this.filterTree.Roots;
            this.AssignCriteria(this.Criteria);
        }

        private void LoadSearches()
        {
            try
            {
                var configFile = Path.Combine(Path.GetDirectoryName(Application.ExecutablePath), Path.Combine("conf", "SearchSettings.xml"));
                if (File.Exists(configFile))
                {
                    using (FileStream fs = File.OpenRead(configFile))
                    {
                        var scl = SearchCriteriaList.Deserialize(fs);
                        if (scl != null)
                        {
                            this.cboSavedSearches.Items.Clear();
                            this.cboSavedSearches.Items.AddRange(scl.Settings.OfType<object>().ToArray());
                        }
                    }
                }
            }
            catch
            {
            }
        }

        private void SaveSearches()
        {
            try
            {
                var elements = this.cboSavedSearches.Items.OfType<SearchCriteriaXmlSettings>();
                var configFile = Path.Combine(Path.GetDirectoryName(Application.ExecutablePath), Path.Combine("conf", "SearchSettings.xml"));

                var configDir = Path.GetDirectoryName(configFile);
                if (elements.Any())
                {
                    if (Directory.Exists(configDir))
                    {
                        Directory.CreateDirectory(configDir);
                    }

                    using (FileStream fs = File.Create(configFile))
                    {
                        SearchCriteriaList.Serialize(fs, elements);
                    }
                }
                else
                {
                    File.Delete(configFile);
                }
            }
            catch (Exception)
            {
            }
        }

        private void SearchFilterBasic_Shown(object sender, EventArgs e)
        {
            this.filterTree_SizeChanged(sender, e);
        }

        private void SearchFilter_Load(object sender, EventArgs e)
        {
            this.Initialize();
            if (this.cboRecordType.SelectedIndex == -1 && this.cboSavedSearches.Items.Count > 0)
            {
                this.cboSavedSearches.SelectedIndex = 0;
            }
        }

        private void bApply_Click(object sender, EventArgs e)
        {
            if (this.ApplySettings())
            {
                DialogResult = DialogResult.No; // Apply.  No to search immediately
            }
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            if (this.ApplySettings())
            {
                DialogResult = DialogResult.Yes; // Search.  Yes to search immediately
            }
        }

        private void btnAddSearch_Click(object sender, EventArgs e)
        {
            var settings = new SearchCriteriaSettings();
            var recStruct = this.cboRecordType.SelectedItem as ComboBoxItem<RecordStructure>;
            if (recStruct != null)
            {
                settings.Type = recStruct.Value.name;
                var checkeditems = this.filterTree.CheckedObjectsEnumerable;
                var items = checkeditems.OfType<SearchCriteria>().ToArray();
                if (items.Any())
                {
                    settings.Items = items;
                    var xmlSetting = SearchCriteriaList.ToXml(settings);

                    var dlg = new InputBox("Enter Search Description:", xmlSetting.Name, "Search Description");
                    if (DialogResult.OK == dlg.ShowDialog(this) && !string.IsNullOrEmpty(dlg.Value))
                    {
                        this.cboSavedSearches.Items.Insert(0, xmlSetting);
                        xmlSetting.Name = dlg.Value;
                        this.SaveSearches();
                    }
                }
            }
        }

        private void btnRemoveSearch_Click(object sender, EventArgs e)
        {
            var settings = this.cboSavedSearches.SelectedItem as SearchCriteriaXmlSettings;
            if (settings != null)
            {
                this.cboSavedSearches.Items.Remove(settings);
                this.SaveSearches();
            }
        }

        private void cboRecordType_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.cboSavedSearches.SelectedIndex = -1;
            var recStruct = this.cboRecordType.SelectedItem as ComboBoxItem<RecordStructure>;
            this.filterTree.Roots = this.ConfigureRecord(recStruct != null ? recStruct.Value : null);
        }

        private void cboSavedSearches_SelectedIndexChanged(object sender, EventArgs e)
        {
            var settings = this.cboSavedSearches.SelectedItem as SearchCriteriaXmlSettings;
            if (settings != null && !string.IsNullOrEmpty(settings.Type))
            {
                this.cboRecordType.SelectedIndexChanged -= this.cboRecordType_SelectedIndexChanged;
                this.cboSavedSearches.SelectedIndexChanged -= this.cboSavedSearches_SelectedIndexChanged;
                this.filterTree.ItemsChanging -= this.filterTree_ItemsChanging;
                this.filterTree.CellEditValidating -= this.filterTree_CellEditValidating;
                this.filterTree.ItemChecked -= this.filterTree_ItemChecked;
                try
                {
                    RecordStructure rec;
                    if (RecordStructure.Records.TryGetValue(settings.Type, out rec))
                    {
                        this.filterTree.Roots = this.ConfigureRecord(rec);
                        this.AssignCriteria(settings);
                        this.filterTree.RebuildAll(true);
                    }
                }
                finally
                {
                    this.cboRecordType.SelectedIndexChanged += this.cboRecordType_SelectedIndexChanged;
                    this.cboSavedSearches.SelectedIndexChanged += this.cboSavedSearches_SelectedIndexChanged;
                    this.filterTree.ItemsChanging += this.filterTree_ItemsChanging;
                    this.filterTree.CellEditValidating += this.filterTree_CellEditValidating;
                    this.filterTree.ItemChecked += this.filterTree_ItemChecked;
                }
            }
        }

        private void filterTree_CellEditValidating(object sender, CellEditEventArgs e)
        {
            if (e.Column.Equals(this.olvColumnValue))
            {
                if (e.RowObject is SearchSubrecord)
                {
                    e.Cancel = true;
                }

                if (e.RowObject is SearchElement)
                {
                    var se = e.RowObject as SearchElement;
                    if (se.Record == null)
                    {
                        e.Cancel = true;
                    }
                    else
                    {
                        e.Cancel = !se.ValidateValue(e.NewValue);
                    }
                }
            }

            this.cboSavedSearches.SelectedIndex = -1;
        }

        private void filterTree_Enter(object sender, EventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_ItemChecked(object sender, ItemCheckedEventArgs e)
        {
            this.cboSavedSearches.SelectedIndex = -1;
        }

        private void filterTree_ItemsChanging(object sender, ItemsChangingEventArgs e)
        {
            this.cboSavedSearches.SelectedIndex = -1;
        }

        private void filterTree_KeyDown(object sender, KeyEventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_SelectedIndexChanged(object sender, EventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_SelectionChanged(object sender, EventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_SizeChanged(object sender, EventArgs e)
        {
            try
            {
                int width = this.filterTree.Columns.OfType<OLVColumn>().Sum(x => x.Width);
                var col = this.filterTree.Columns.OfType<OLVColumn>().LastOrDefault(x => x.IsVisible);
                if (col != null)
                {
                    col.Width = this.filterTree.Width - width + col.Width - SystemInformation.VerticalScrollBarWidth - SystemInformation.FrameBorderSize.Width;
                }
            }
            catch
            {
            }
        }

        private class ComboBoxItem<T>
            where T : class
        {
            public string Name { get; set; }

            public T Value { get; set; }

            public override bool Equals(object obj)
            {
                if (obj is T)
                {
                    return this.Value.Equals(obj);
                }

                if (obj is ComboBoxItem<T>)
                {
                    return this.Value.Equals(((ComboBoxItem<T>)obj).Value);
                }

                return false;
            }

            public override int GetHashCode()
            {
                return this.Name.GetHashCode();
            }

            public override string ToString()
            {
                return this.Name;
            }
        }
    }
}
