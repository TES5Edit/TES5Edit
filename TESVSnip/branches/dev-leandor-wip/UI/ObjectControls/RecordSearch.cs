namespace TESVSnip.UI.ObjectControls
{
    using System;
    using System.Collections.Generic;
    using System.Collections.Specialized;
    using System.ComponentModel;
    using System.Drawing;
    using System.Globalization;
    using System.Linq;
    using System.Media;
    using System.Windows.Forms;

    using BrightIdeasSoftware;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework.Collections;
    using TESVSnip.Properties;
    using TESVSnip.UI.Docking;
    using TESVSnip.UI.Forms;

    using WeifenLuo.WinFormsUI.Docking;

    using Settings = TESVSnip.Properties.Settings;
    using TypeConverter = TESVSnip.Framework.TypeConverter;

    public partial class RecordSearch : UserControl, ISupportInitialize
    {
        private static readonly string[] groupingColumns = new[] { "Type", "Plugin" };

        private volatile bool backgroundWorkCanceled;

        private OLVColumn[] baseColumns = null;

        public RecordSearch()
        {
            this.InitializeComponent();
        }

        private enum SearchType
        {
            EditorID, 

            FormID, 

            FullSearch, 

            TypeEditorIdSearch, 

            TypeFullSearch, 

            FormIDRef, 

            BasicCriteriaRef, 
        }

        public void BeginInit()
        {
        }

        public void EndInit()
        {
            if (!DesignMode)
            {
                this.InitializeToolStripFind();
            }
        }

        public void FocusText()
        {
            this.toolStripIncrFindText.Focus();
        }

        [Browsable(false)]
        public void StartBackgroundWork(Action workAction, Action completedAction)
        {
            if (this.backgroundWorker1.IsBusy)
            {
                return;
            }

            // EnableUserInterface(false);
            this.backgroundWorkCanceled = false;
            this.toolStripIncrFindCancel.Visible = true;
            this.backgroundWorker1.RunWorkerAsync(new[] { workAction, completedAction });
        }

        internal void ReferenceSearch(uint formid)
        {
            var cboItem = this.toolStripIncrFindType.Items.OfType<MRUComboHelper<SearchType, string>>().FirstOrDefault(x => x.Key == SearchType.FormIDRef);
            this.toolStripIncrFindType.SelectedItem = cboItem;
            this.toolStripIncrFindText.Text = formid.ToString("X8");
            this.BackgroundIncrementalSearch();
        }

        internal void SetSearchCriteria(SearchCriteriaSettings settings, bool doSearch)
        {
            this.toolStripIncrSelectCriteria.Tag = settings;

            var cboItem = this.toolStripIncrFindType.Items.OfType<MRUComboHelper<SearchType, string>>().FirstOrDefault(x => x.Key == SearchType.BasicCriteriaRef);
            this.toolStripIncrFindType.SelectedItem = cboItem;
            if (doSearch)
            {
                this.BackgroundIncrementalSearch();
            }
        }

        private void ApplyColumnSettings(ColumnSettings columnSettings, bool rebuild)
        {
            // remove all of the old columns
            bool changed = false;
            foreach (var oldColumn in this.listSearchView.AllColumns.Where(x => (x.Tag is ColumnElement)).ToList())
            {
                this.listSearchView.AllColumns.Remove(oldColumn);
                changed = true;
            }

            if (columnSettings != null)
            {
                foreach (var setting in columnSettings.Items.OfType<ColumnElement>())
                {
                    string type = setting.Parent.Record.name;
                    string name = setting.Name;
                    string colName = type + "." + name;
                    string dispName = type + ": " + name;
                    if (Enumerable.OfType<OLVColumn>(this.baseColumns).Any(x => x.Name == colName))
                    {
                        continue;
                    }

                    var column = new OLVColumn
                        {
                            Text = dispName, 
                            Name = colName, 
                            AspectName = setting.Name, 
                            Width = 80, 
                            IsVisible = true, 
                            Groupable = true, 
                            Tag = setting, 
                            AspectGetter = x => {
                                var rec = x as Record;
                                var sr = rec != null ? rec.SubRecords.FirstOrDefault(r => r.Name == type) : null;
                                var se = sr != null ? sr.EnumerateElements().FirstOrDefault(e => e.Structure.name == name) : null;
                                return se != null ? sr.GetDisplayValue(se) : null;
                            }
                        };
                    this.listSearchView.AllColumns.Add(column);
                    changed = true;
                }
            }

            if (changed && rebuild)
            {
                this.listSearchView.RebuildColumns();
            }
        }

        private void BackgroundIncrementalSearch()
        {
            if (!PluginList.All.Enumerate(x => x != null).Any())
            {
                this.toolStripIncrFindStatus.Text = Resources.No_Plugins_Loaded;
                this.toolStripIncrFindStatus.ForeColor = Color.Maroon;
                if (!Settings.Default.NoWindowsSounds)
                {
                    SystemSounds.Beep.Play();
                }

                return;
            }

            var searchText = this.toolStripIncrFindText.Text;
            var searchTypeItem = this.toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (searchTypeItem == null)
            {
                return;
            }

            searchTypeItem.MRU.Remove(searchText);
            searchTypeItem.MRU.Insert(0, searchText);
            this.toolStripIncrFindStatus.Text = string.Empty;
            float totalNodes = PluginList.All.Enumerate(x => x != null).Count();
            int currentCount = 0, prevCount = 0;
            Predicate<BaseRecord> updateFunc = n => {
                if (this.IsBackroundProcessCanceled())
                {
                    // returning true will stop it
                    return false;
                }

                var counter = (int)(++currentCount / totalNodes * 100.0f);
                if (counter != prevCount)
                {
                    prevCount = counter;
                    if (counter % 10 == 0)
                    {
                        this.UpdateBackgroundProgress(counter);
                    }
                }

                return true;
            };

            var searchContext = new SearchSettings();
            searchContext.Type = searchTypeItem.Key;
            searchContext.Text = this.toolStripIncrFindText.Text;
            searchContext.Partial = !this.toolStripIncrFindExact.Checked;
            searchContext.Rectype = this.toolStripIncrFindTypeFilter.SelectedItem as string;
            searchContext.Criteria = this.toolStripIncrSelectCriteria.Tag as SearchCriteriaSettings;
            searchContext.UpdateFunc = updateFunc;

            // exclude null Text searches except for when type is specified
            if (searchContext.Type == SearchType.BasicCriteriaRef)
            {
                if (searchContext.Criteria == null || !searchContext.Criteria.Items.Any())
                {
                    if (!Settings.Default.NoWindowsSounds)
                    {
                        SystemSounds.Beep.Play();
                    }

                    MainView.PostStatusWarning("No search criteria selected!");
                }
            }
            else if (searchContext.Type != SearchType.TypeEditorIdSearch && string.IsNullOrEmpty(searchContext.Text))
            {
                if (!Settings.Default.NoWindowsSounds)
                {
                    SystemSounds.Beep.Play();
                }

                this.toolStripIncrFind.Focus();
                this.toolStripIncrFindText.Select();
                this.toolStripIncrFindText.Focus();
                return;
            }

            this.listSearchView.ClearObjects();

            SearchResults results = null;
            this.StartBackgroundWork(
                () => {
                    results = new SearchResults
                        {
                            Type = searchContext.Type, 
                            Partial = searchContext.Partial, 
                            Rectype = searchContext.Rectype, 
                            Text = searchContext.Text, 
                            Criteria = searchContext.Criteria, 
                            Records = new AdvancedList<Record>(this.PerformSearch(searchContext))
                        };
                }, 
                () => {
                    if (this.IsBackroundProcessCanceled())
                    {
                        this.toolStripIncrFindStatus.Text = "Search Canceled";
                        this.toolStripIncrFindStatus.ForeColor = Color.Black;
                    }
                    else
                    {
                        if (results != null && results.Records != null && results.Records.Count > 0)
                        {
                            this.toolStripIncrFindStatus.Text = string.Format(Resources.SearchProgressChanged_Items_Found, results.Records.Count);
                            this.toolStripIncrFindStatus.ForeColor = Color.Black;
                            this.toolStripIncrFindText.Tag = false;
                            this.UpdateSearchList(results);
                        }
                        else
                        {
                            this.toolStripIncrFindText.Tag = true;
                            this.toolStripIncrFindStatus.Text = "No Matches Found";
                            this.toolStripIncrFindStatus.ForeColor = Color.Maroon;
                            if (!Settings.Default.NoWindowsSounds)
                            {
                                SystemSounds.Beep.Play();
                            }
                        }

                        this.toolStripIncrFind.Focus();
                        this.toolStripIncrFindText.Select();
                        this.toolStripIncrFindText.Focus();
                    }
                });
        }

        private void BatchEditSelectedRecords()
        {
            var selRec = this.listSearchView.SelectedObjects.OfType<Record>();
            using (var dlg = new BatchEditRecords(selRec))
            {
                if (DialogResult.OK == dlg.ShowDialog(this))
                {
                    BatchEditRecords.EditRecords(selRec, dlg.Criteria); // generate report of changes?
                    this.listSearchView.RebuildColumns();
                }
            }
        }

        private void CancelBackgroundProcess()
        {
            this.backgroundWorkCanceled = true;
            this.backgroundWorker1.CancelAsync();
        }

        private void EditSelectedRecords()
        {
            var dockParent = this.FindDockContent(this);
            var dockPanel = dockParent != null ? dockParent.DockHandler.DockPanel : null;
            bool first = true;
            foreach (var r in this.listSearchView.SelectedObjects.OfType<Record>())
            {
                var form = new FullRecordEditor(r);
                if (dockParent != null)
                {
                    var sz = form.Size;
                    if (first)
                    {
                        form.StartPosition = FormStartPosition.CenterScreen;
                        form.Show(dockPanel, DockState.Float);
                        form.Pane.FloatWindow.Size = sz;
                        first = false;
                    }
                    else
                    {
                        form.Show(dockPanel);
                    }
                }
                else
                {
                    form.Show(this);
                }
            }
        }

        private IDockContent FindDockContent(Control c)
        {
            if (c is IDockContent)
            {
                return c as IDockContent;
            }
            else if (c.Parent != null)
            {
                return this.FindDockContent(c.Parent);
            }

            return null;
        }

        private Plugin GetPluginFromNode(BaseRecord node)
        {
            BaseRecord tn = node;
            if (tn is Plugin)
            {
                return (Plugin)tn;
            }

            while (!(tn is Plugin) && tn != null)
            {
                tn = tn.Parent;
            }

            if (tn != null)
            {
                return tn as Plugin;
            }

            return null;
        }

        private ICollection<Record> IncrementalSearch(Predicate<BaseRecord> searchFunc)
        {
            return PluginList.All.Enumerate(searchFunc).OfType<Record>().Take(Settings.Default.MaxSearchResults).ToList();
        }

        private void InitializeToolStripFind()
        {
            if (DesignMode)
            {
                return;
            }

            if (Settings.Default.SearchMRUNameList == null)
            {
                Settings.Default.SearchMRUNameList = new StringCollection();
            }

            if (Settings.Default.SearchMRUFormIDList == null)
            {
                Settings.Default.SearchMRUFormIDList = new StringCollection();
            }

            if (Settings.Default.SearchMRUFullList == null)
            {
                Settings.Default.SearchMRUFullList = new StringCollection();
            }

            var items = new object[]
                {
                    new MRUComboHelper<SearchType, string>(SearchType.EditorID, "Editor ID", Settings.Default.SearchMRUNameList), 
                    new MRUComboHelper<SearchType, string>(SearchType.FormID, "Form ID", Settings.Default.SearchMRUFormIDList), 
                    new MRUComboHelper<SearchType, string>(SearchType.FullSearch, "Full Search", Settings.Default.SearchMRUFullList), 
                    new MRUComboHelper<SearchType, string>(SearchType.TypeEditorIdSearch, "Name w/Type", Settings.Default.SearchMRUNameList), 
                    new MRUComboHelper<SearchType, string>(SearchType.TypeFullSearch, "Full w/Type", Settings.Default.SearchMRUFullList), 
                    new MRUComboHelper<SearchType, string>(SearchType.FormIDRef, "Form ID Ref.", Settings.Default.SearchMRUFormIDList), 
                    new MRUComboHelper<SearchType, string>(SearchType.BasicCriteriaRef, "Basic Search", new StringCollection()), 
                };
            this.toolStripIncrFindType.Items.Clear();
            this.toolStripIncrFindType.Items.AddRange(items);

            int idx = 0;
            if (!string.IsNullOrEmpty(Settings.Default.LastSearchType))
            {
                idx = this.toolStripIncrFindType.FindStringExact(Settings.Default.LastSearchType);
            }

            idx = idx >= 0 ? idx : 0;
            this.toolStripIncrFindType.SelectedIndex = idx;

            this.ResetSearch();
            this.toolStripIncrFindStatus.Text = string.Empty;
            if (!RecordStructure.Loaded)
            {
                RecordStructure.Load();
            }

            this.toolStripIncrFindTypeFilter.Sorted = true;
            this.toolStripIncrFindTypeFilter.Items.Clear();
            if (RecordStructure.Records != null)
            {
                var recitems = RecordStructure.Records.Keys.OfType<object>().ToArray();
                this.toolStripIncrFindTypeFilter.Items.AddRange(recitems);
            }

            this.toolStripIncrFindTypeFilter.SelectedIndex = 0;

            this.backgroundWorker1.DoWork += this.backgroundWorker1_DoWork;
            this.backgroundWorker1.RunWorkerCompleted += this.backgroundWorker1_RunWorkerCompleted;
            this.backgroundWorker1.ProgressChanged += this.backgroundWorker1_ProgressChanged;
        }

        private bool IsBackroundProcessCanceled()
        {
            return this.backgroundWorkCanceled;
        }

        /// <summary>
        /// Helper routine for doing an actual search.
        /// </summary>
        /// <param name="ctx">
        /// </param>
        /// <returns>
        /// The System.Collections.Generic.ICollection`1[T -&gt; TESVSnip.Model.Record].
        /// </returns>
        private ICollection<Record> PerformSearch(SearchSettings ctx)
        {
            Predicate<BaseRecord> searchFunction = null;

            switch (ctx.Type)
            {
                case SearchType.FormID:
                    {
                        if (string.IsNullOrEmpty(ctx.Text))
                        {
                            return null;
                        }

                        uint searchID;
                        if (!uint.TryParse(ctx.Text, NumberStyles.AllowHexSpecifier, null, out searchID))
                        {
                            MainView.PostStatusWarning("Invalid FormID");
                            return null;
                        }

                        searchFunction = node => {
                            var rec = node as Record;
                            if (rec == null)
                            {
                                return node is IGroupRecord;
                            }

                            if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node))
                            {
                                return false;
                            }

                            return rec.FormID == searchID;
                        };
                    }

                    break;
                case SearchType.TypeEditorIdSearch:
                case SearchType.EditorID:
                    {
                        if (ctx.Type == SearchType.TypeEditorIdSearch && string.IsNullOrEmpty(ctx.Rectype))
                        {
                            return null;
                        }

                        if (ctx.Type == SearchType.EditorID && string.IsNullOrEmpty(ctx.Text))
                        {
                            return null;
                        }

                        string searchString = string.IsNullOrEmpty(ctx.Text) ? null : ctx.Text.ToLowerInvariant();
                        searchFunction = node => {
                            if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node))
                            {
                                return false;
                            }

                            var rec = node as Record;
                            if (rec == null)
                            {
                                return node is IGroupRecord;
                            }

                            bool typeOk = true;
                            if (ctx.Type == SearchType.TypeEditorIdSearch)
                            {
                                typeOk = !string.IsNullOrEmpty(rec.Name) && string.Compare(rec.Name, ctx.Rectype, true) == 0;
                            }

                            if (typeOk)
                            {
                                if (string.IsNullOrEmpty(searchString))
                                {
                                    return true;
                                }
                                else if (ctx.Partial)
                                {
                                    var val = rec.DescriptiveName.ToLowerInvariant();
                                    if (val.Contains(searchString))
                                    {
                                        return true;
                                    }
                                }
                                else
                                {
                                    var val = rec.DescriptiveName.ToLowerInvariant().Substring(2, rec.DescriptiveName.Length - 3);

                                    if (val == searchString)
                                    {
                                        return true;
                                    }
                                }
                            }

                            return false;
                        };
                    }

                    break;
                case SearchType.TypeFullSearch:
                case SearchType.FullSearch:
                    {
                        if (ctx.Type == SearchType.TypeFullSearch && string.IsNullOrEmpty(ctx.Rectype))
                        {
                            return null;
                        }

                        if (ctx.Type == SearchType.FullSearch && string.IsNullOrEmpty(ctx.Text))
                        {
                            return null;
                        }

                        string searchString = ctx.Text.ToLowerInvariant();
                        searchFunction = node => {
                            if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node))
                            {
                                return false;
                            }

                            var rec = node as Record;
                            if (rec == null)
                            {
                                return node is IGroupRecord;
                            }

                            bool typeOk = true;
                            if (ctx.Type == SearchType.TypeFullSearch)
                            {
                                typeOk = !string.IsNullOrEmpty(rec.Name) && string.Compare(rec.Name, ctx.Rectype, true) == 0;
                            }

                            if (typeOk)
                            {
                                foreach (SubRecord sr in rec.SubRecords)
                                {
                                    var val = sr.GetStrData();
                                    if (!string.IsNullOrEmpty(val))
                                    {
                                        val = val.ToLowerInvariant();
                                        if ((ctx.Partial && val.Contains(searchString)) || (val == searchString))
                                        {
                                            return true;
                                        }
                                    }
                                }
                            }

                            return false;
                        };
                    }

                    break;
                case SearchType.FormIDRef:
                    {
                        if (string.IsNullOrEmpty(ctx.Text))
                        {
                            return null;
                        }

                        uint searchID;
                        if (!uint.TryParse(ctx.Text, NumberStyles.AllowHexSpecifier, null, out searchID))
                        {
                            MainView.PostStatusWarning("Invalid FormID");
                            return null;
                        }

                        searchFunction = node => {
                            if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node))
                            {
                                return false;
                            }

                            var rec = node as Record;
                            if (rec == null)
                            {
                                return node is IGroupRecord;
                            }

                            if (rec != null)
                            {
                                rec.MatchRecordStructureToRecord();
                                if (
                                    (from sr in rec.SubRecords from elem in rec.EnumerateElements(sr) let es = elem.Structure where es != null && es.type == ElementValueType.FormID select elem).Any(
                                        elem => searchID == TypeConverter.h2i(elem.Data)))
                                {
                                    return true;
                                }
                            }

                            return false;
                        };
                    }

                    break;

                case SearchType.BasicCriteriaRef:
                    {
                        if (ctx.Criteria == null || !ctx.Criteria.Items.Any())
                        {
                            MainView.PostStatusWarning("No search criteria selected!");
                            return null;
                        }

                        searchFunction = node => {
                            if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node))
                            {
                                return false;
                            }

                            var rec = node as Record;
                            if (rec == null)
                            {
                                return node is IGroupRecord;
                            }

                            if (ctx.Criteria.Type != rec.Name)
                            {
                                return false;
                            }

                            rec.MatchRecordStructureToRecord();
                            bool all = false;
                            foreach (var m in ctx.Criteria.Items)
                            {
                                bool ok = m.Match(rec);
                                if (!ok)
                                {
                                    return false;
                                }

                                all = true;
                            }

                            return all;
                        };
                    }

                    break;
            }

            return this.IncrementalSearch(searchFunction);
        }

        private void RecordSearch_Load(object sender, EventArgs e)
        {
        }

        private void ResetSearch()
        {
            // use tag to indicate Text changed and therefore reset the search
            this.toolStripIncrFindText.Tag = true;
            this.toolStripIncrFindStatus.Text = string.Empty;
        }

        private void SynchronizeSelection()
        {
            MainView.SynchronizeSelection(this.listSearchView.SelectedObjects.OfType<BaseRecord>());
        }

        private void UpdateBackgroundProgress(int percentProgress)
        {
            this.backgroundWorker1.ReportProgress(percentProgress);
        }

        private void UpdateSearchList(SearchResults results)
        {
            this.listSearchView.Columns.Clear();
            this.listSearchView.AllColumns.Clear();
            this.listSearchView.ClearObjects();
            if (results == null)
            {
                return;
            }

            foreach (var rec in results.Records)
            {
                rec.MatchRecordStructureToRecord();
            }

            var fixedColumns =
                new List<OLVColumn>(
                    new[]
                        {
                            new OLVColumn
                                {
                                   Text = "Plugin", Name = "Plugin", AspectName = "Plugin", Width = 5, IsVisible = true, Groupable = true, AspectGetter = x => this.GetPluginFromNode(x as Record) 
                                }, 
                            new OLVColumn
                                {
                                    Text = "Type", 
                                    Name = "Type", 
                                    AspectName = "Type", 
                                    Width = 100, 
                                    IsVisible = true, 
                                    AspectGetter = x => {
                                        var rec = x as Record;
                                        return rec != null ? rec.Name : string.Empty;
                                    }
                                }, new OLVColumn
                                    {
                                        Text = "Name", 
                                        Name = "Name", 
                                        AspectName = "Name", 
                                        Width = 200, 
                                        IsVisible = true, 
                                        Groupable = true, 
                                        AspectGetter = x => {
                                            var rec = x as Record;
                                            var sr = rec != null ? rec.SubRecords.FirstOrDefault(r => r.Name == "EDID") : null;
                                            var elem = sr != null ? sr.GetStrData() : null;
                                            return elem ?? string.Empty;
                                        }
                                    }, 
                            new OLVColumn
                                {
                                    Text = "FormID", 
                                    Name = "FormID", 
                                    AspectName = "FormID", 
                                    Width = 80, 
                                    IsVisible = true, 
                                    Groupable = true, 
                                    AspectGetter = x => {
                                        var rec = x as Record;
                                        return rec != null ? rec.FormID.ToString("X8") : string.Empty;
                                    }
                                }, new OLVColumn
                                    {
                                        Text = "Full Name", 
                                        Name = "FullName", 
                                        AspectName = "FullName", 
                                        Width = 200, 
                                        IsVisible = true, 
                                        Groupable = true, 
                                        AspectGetter = x => {
                                            var rec = x as Record;
                                            var sr = rec != null ? rec.SubRecords.FirstOrDefault(r => r.Name == "FULL") : null;
                                            var elem = sr != null ? sr.GetLString() : null;
                                            return elem ?? string.Empty;
                                        }
                                    }, 
                        });

            var columns = new List<ColumnCriteria>();

            // Get custom columns
            if (results.Type == SearchType.BasicCriteriaRef)
            {
                if (results.Criteria != null)
                {
                    fixedColumns.AddRange(
                        from item in results.Criteria.Items.OfType<SearchElement>()
                        let type = item.Parent.Record.name
                        let name = item.Name
                        let colName = type + "." + name
                        let dispName = type + ": " + name
                        select new OLVColumn
                            {
                                Text = dispName, 
                                Name = colName, 
                                AspectName = name, 
                                Width = 80, 
                                IsVisible = true, 
                                Groupable = true, 
                                AspectGetter = x => {
                                    var rec = x as Record;
                                    var sr = rec != null ? rec.SubRecords.FirstOrDefault(r => r.Name == type) : null;
                                    var se = sr != null ? sr.EnumerateElements().FirstOrDefault(e => e.Structure.name == name) : null;
                                    return se != null ? sr.GetDisplayValue(se) : null;
                                }
                            });
                }
            }

            this.baseColumns = fixedColumns.ToArray();
            this.listSearchView.AllColumns.AddRange(this.baseColumns);

            var columnSettings = this.toolStripSelectColumns.Tag as ColumnSettings;
            this.ApplyColumnSettings(columnSettings, rebuild: false);
            this.listSearchView.AutoResizeColumns(ColumnHeaderAutoResizeStyle.ColumnContent);

            this.listSearchView.Objects = results.Records;
            this.listSearchView.RebuildColumns();
            this.listSearchView.Refresh();
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            var actions = e.Argument as Action[];
            if (actions == null)
            {
                return;
            }

            if (actions.Length > 0)
            {
                actions[0]();
            }

            if (actions.Length > 1)
            {
                e.Result = actions[1];
            }
        }

        private void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            this.toolStripIncrFindStatus.Text = string.Format("{0}% Complete", e.ProgressPercentage);
        }

        private void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            this.toolStripIncrFindCancel.Visible = false;
            int nItems = this.listSearchView.GetItemCount();
            bool maxResultsHit = nItems == Settings.Default.MaxSearchResults;
            string text = string.Format(Resources.SearchProgressChanged_Items_Found, nItems);
            if (maxResultsHit)
            {
                text += " (Max Limited)";
            }

            this.toolStripIncrFindStatus.Text = text;
            this.toolStripIncrFindStatus.ForeColor = SystemColors.ControlText;
            if (e.Cancelled || e.Error != null)
            {
                return;
            }

            var completedAction = e.Result as Action;
            if (completedAction != null)
            {
                completedAction();
            }
        }

        private void batchEditToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.BatchEditSelectedRecords();
        }

        private void contextMenuStripList_Closing(object sender, ToolStripDropDownClosingEventArgs e)
        {
            this.copyToToolStripMenuItem.DropDownItems.Clear();
        }

        private void contextMenuStripList_Opening(object sender, CancelEventArgs e)
        {
            var searchTypeItem = this.toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (searchTypeItem == null)
            {
                return;
            }

            var records = this.listSearchView.SelectedObjects.OfType<Record>().ToList();
            var hasDistictRecordsType = records.Select(x => x.Name).Distinct().Count() == 1;
            bool anyRecords = records.Any();

            if (hasDistictRecordsType)
            {
                this.batchEditToolStripMenuItem.Enabled = true;
                this.batchEditToolStripMenuItem.ToolTipText = string.Empty;
            }
            else
            {
                this.batchEditToolStripMenuItem.Enabled = false;
                this.batchEditToolStripMenuItem.ToolTipText = string.Format("Batch Edit not allowed when multiple record types are selected");
            }

            this.copyToToolStripMenuItem.Enabled = anyRecords;
            this.editToolStripMenuItem.Enabled = anyRecords;
            this.synchronizeToolStripMenuItem.Enabled = anyRecords;
            this.batchEditToolStripMenuItem.Enabled &= anyRecords;
            this.copyToolStripMenuItem.Enabled = anyRecords;

            if (this.copyToToolStripMenuItem.Enabled)
            {
                foreach (var plugin in PluginList.All.Records.OfType<Plugin>())
                {
                    Plugin curplugin = plugin;
                    var copyRecs = records.Where(x => x.GetPlugin() != curplugin);
                    if (!copyRecs.Any())
                    {
                        continue;
                    }

                    var tsi = new ToolStripButton(plugin.Name);
                    tsi.Tag = new object[] { copyRecs.OfType<BaseRecord>().ToArray(), curplugin };
                    var sz = TextRenderer.MeasureText(plugin.Name, this.copyToToolStripMenuItem.Font);
                    if (sz.Width > tsi.Width)
                    {
                        tsi.Width = sz.Width;
                    }

                    tsi.AutoSize = true;
                    this.copyToToolStripMenuItem.DropDownItems.Add(tsi);
                }
            }
        }

        private void copyToToolStripMenuItem_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            var array = e.ClickedItem.Tag as object[];
            if (array != null && array.Length == 2)
            {
                int count = Spells.CopyRecordsTo(array[0] as BaseRecord[], array[1] as IGroupRecord);
            }
        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MainView.Clipboard = this.listSearchView.SelectedObjects.OfType<BaseRecord>().ToArray();
        }

        private void editToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.EditSelectedRecords();
        }

        private void listSearchView_BeforeCreatingGroups(object sender, CreateGroupsEventArgs e)
        {
            try
            {
                if (e.Parameters.GroupByColumn != null)
                {
                    if (!groupingColumns.Contains(e.Parameters.GroupByColumn.Name))
                    {
                        var column = this.listSearchView.AllColumns.FirstOrDefault(x => x.Name == "Plugin");
                        if (column != null)
                        {
                            e.Parameters.GroupByColumn = column;
                            e.Parameters.SortItemsByPrimaryColumn = false;
                        }
                    }
                }
            }
            catch
            {
            }
        }

        private void listSearchView_BeforeSorting(object sender, BeforeSortingEventArgs e)
        {
        }

        private void listSearchView_CellClick(object sender, CellClickEventArgs e)
        {
            if (e.ClickCount > 1)
            {
                this.SynchronizeSelection();
            }
        }

        private void listSearchView_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter && e.Control && !e.Alt && !e.Shift)
            {
                this.SynchronizeSelection();
            }
        }

        private void reportToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var dockParent = this.FindDockContent(this);

            foreach (Record r in this.listSearchView.SelectedObjects.OfType<Record>())
            {
                var form = new RichTextContent();
                form.UpdateRecord(r);
                form.StartPosition = FormStartPosition.CenterScreen;
                if (dockParent != null)
                {
                    var sz = form.Size;
                    form.Show(dockParent.DockHandler.DockPanel, DockState.Float);
                    form.Pane.FloatWindow.Size = sz;
                }
                else
                {
                    form.Show(this);
                }
            }
        }

        private void resetToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.ResetSearch();
        }

        private void synchronizeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.SynchronizeSelection();
        }

        private void toolStripCheck_CheckStateChanged(object sender, EventArgs e)
        {
            var button = sender as ToolStripButton;
            if (button != null)
            {
                button.Image = button.Checked ? Resources.checkedbox : Resources.emptybox;
            }
        }

        private void toolStripIncrFindCancel_Click(object sender, EventArgs e)
        {
            this.CancelBackgroundProcess();
        }

        private void toolStripIncrFindClear_Click(object sender, EventArgs e)
        {
            this.listSearchView.ClearObjects();
        }

        private void toolStripIncrFindGo_Click(object sender, EventArgs e)
        {
            this.BackgroundIncrementalSearch();
        }

        private void toolStripIncrFindText_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == (char)Keys.Enter)
            {
                e.SuppressKeyPress = true;
                e.Handled = true;
                this.BackgroundIncrementalSearch();
            }
        }

        private void toolStripIncrFindText_TextChanged(object sender, EventArgs e)
        {
            this.ResetSearch();
        }

        private void toolStripIncrFindTypeFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.ResetSearch();
        }

        private void toolStripIncrFindType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var item = this.toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (item != null)
            {
                Settings.Default.LastSearchType = this.toolStripIncrFindType.Text;
            }

            if (item != null && (item.Key == SearchType.TypeEditorIdSearch || item.Key == SearchType.TypeFullSearch))
            {
                this.toolStripIncrFindTypeFilter.Visible = true;
                this.toolStripIncrFindExact.Visible = false;
                this.toolStripSelectColumns.Visible = true;
            }
            else
            {
                this.toolStripIncrFindTypeFilter.Visible = false;
                this.toolStripIncrFindExact.Visible = true;
                this.toolStripSelectColumns.Visible = false;
            }

            if (item != null && item.Key == SearchType.BasicCriteriaRef)
            {
                this.toolStripIncrSelectCriteria.Visible = true;
                this.toolStripIncrFindText.Visible = false;
                this.toolStripIncrFindText.Items.Clear();
                this.toolStripIncrFindGo.Enabled = this.toolStripIncrSelectCriteria.Tag != null;
                this.toolStripSelectColumns.Visible = true;
            }
            else
            {
                this.toolStripIncrFindGo.Enabled = true;
                this.toolStripIncrSelectCriteria.Visible = false;
                this.toolStripIncrFindText.Visible = true;
                this.toolStripIncrFindText.Items.Clear();
                if (item != null && item.MRU != null && item.MRU.Count > 0)
                {
                    this.toolStripIncrFindText.Items.AddRange(item.MRU.OfType<object>().Take(15).ToArray());
                }
            }
        }

        private void toolStripIncrSelectCriteria_Click(object sender, EventArgs e)
        {
            using (var dlg = new SearchFilterBasic())
            {
                dlg.Criteria = this.toolStripIncrSelectCriteria.Tag as SearchCriteriaSettings;
                var result = dlg.ShowDialog(this);
                if (DialogResult.Cancel != result)
                {
                    this.toolStripIncrSelectCriteria.Tag = dlg.Criteria;
                    this.toolStripIncrFindGo.Enabled = dlg.Criteria != null && dlg.Criteria.Items.Any();
                    if (result == DialogResult.Yes)
                    {
                        this.BackgroundIncrementalSearch();
                    }
                }
            }
        }

        private void toolStripSelectColumns_Click(object sender, EventArgs e)
        {
            RecordStructure rec = null;

            var searchTypeItem = this.toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (searchTypeItem == null)
            {
                return;
            }

            if (searchTypeItem.Key == SearchType.BasicCriteriaRef)
            {
                var scs = this.toolStripIncrSelectCriteria.Tag as SearchCriteriaSettings;
                if (scs != null && !string.IsNullOrEmpty(scs.Type))
                {
                    RecordStructure.Records.TryGetValue(scs.Type, out rec);
                }
            }
            else
            {
                var recType = this.toolStripIncrFindTypeFilter.SelectedItem as string;
                if (!string.IsNullOrEmpty(recType))
                {
                    RecordStructure.Records.TryGetValue(recType, out rec);
                }
            }

            using (var dlg = new RecordColumnSelect(rec))
            {
                dlg.Criteria = this.toolStripSelectColumns.Tag as ColumnSettings;
                if (DialogResult.OK == dlg.ShowDialog(this))
                {
                    var settings = dlg.Criteria;
                    this.ApplyColumnSettings(settings, rebuild: true);
                    this.toolStripSelectColumns.Tag = dlg.Criteria;
                }
            }
        }

        private void toolStripSynchronize_Click(object sender, EventArgs e)
        {
            this.SynchronizeSelection();
        }

        private class ComboHelper<T, U>
        {
            public ComboHelper(T key, U value)
            {
                this.Key = key;
                this.Value = value;
            }

            public T Key { get; set; }

            public U Value { get; set; }

            public override string ToString()
            {
                return this.Value.ToString();
            }
        }

        private class MRUComboHelper<T, U> : ComboHelper<T, U>
        {
            private readonly StringCollection mru;

            public MRUComboHelper(T key, U value, StringCollection mru)
                : base(key, value)
            {
                this.mru = mru;
            }

            public StringCollection MRU
            {
                get
                {
                    return this.mru;
                }
            }
        }

        private class SearchResults
        {
            public SearchCriteriaSettings Criteria;

            public bool Partial;

            public AdvancedList<Record> Records = new AdvancedList<Record>();

            public string Rectype;

            public string Text;

            public SearchType Type;
        }

        /// <summary>
        /// </summary>
        /// <param name="type">
        /// Type of search to perform. 
        /// </param>
        /// <param name="text">
        /// Text to search for. 
        /// </param>
        /// <param name="partial">
        /// Allow for partial Text matches. 
        /// </param>
        /// <param name="updateFunc">
        /// Function to call to update the UI when doing select. 
        /// </param>
        private class SearchSettings
        {
            public SearchCriteriaSettings Criteria;

            public bool Partial;

            public string Rectype;

            public string Text;

            public SearchType Type;

            public Predicate<BaseRecord> UpdateFunc;

            public SearchSettings()
            {
                this.Type = SearchType.EditorID;
                this.Text = null;
                this.Partial = true;
                this.Criteria = null;
                this.UpdateFunc = null;
                this.Rectype = null;
            }
        }
    }
}
