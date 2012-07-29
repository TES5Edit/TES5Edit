using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Media;
using System.Windows.Forms;
using BrightIdeasSoftware;
using TESVSnip.Collections.Generic;
using TESVSnip.Docking;
using TESVSnip.Forms;
using TESVSnip.Model;
using TESVSnip.Properties;
using WeifenLuo.WinFormsUI.Docking;

namespace TESVSnip.ObjectControls
{
    public partial class RecordSearch : UserControl, ISupportInitialize
    {
        private OLVColumn[] baseColumns=null;
        public RecordSearch()
        {
            InitializeComponent();
        }

        #region Search Helpers

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

        private class ComboHelper<T, U>
        {
            public ComboHelper(T key, U value)
            {
                Key = key;
                Value = value;
            }

            public T Key { get; set; }
            public U Value { get; set; }

            public override string ToString()
            {
                return Value.ToString();
            }
        }

        private class MRUComboHelper<T, U> : ComboHelper<T, U>
        {
            private System.Collections.Specialized.StringCollection mru;
            public MRUComboHelper(T key, U value, System.Collections.Specialized.StringCollection mru)
                : base(key, value)
            {
                this.mru = mru;
            }

            public System.Collections.Specialized.StringCollection MRU
            {
                get { return this.mru; }
            }
        }

        #endregion

        private void InitializeToolStripFind()
        {
            if (DesignMode) return;

            if (TESVSnip.Properties.Settings.Default.SearchMRUNameList == null)
                TESVSnip.Properties.Settings.Default.SearchMRUNameList = new StringCollection();
            if (TESVSnip.Properties.Settings.Default.SearchMRUFormIDList == null)
                TESVSnip.Properties.Settings.Default.SearchMRUFormIDList = new StringCollection();
            if (TESVSnip.Properties.Settings.Default.SearchMRUFullList == null)
                TESVSnip.Properties.Settings.Default.SearchMRUFullList = new StringCollection();

            var items = new object[]
            {
                new MRUComboHelper<SearchType, string>(SearchType.EditorID, "Editor ID", TESVSnip.Properties.Settings.Default.SearchMRUNameList),
                new MRUComboHelper<SearchType, string>(SearchType.FormID, "Form ID", TESVSnip.Properties.Settings.Default.SearchMRUFormIDList),
                new MRUComboHelper<SearchType, string>(SearchType.FullSearch, "Full Search", TESVSnip.Properties.Settings.Default.SearchMRUFullList),
                new MRUComboHelper<SearchType, string>(SearchType.TypeEditorIdSearch, "Name w/Type", TESVSnip.Properties.Settings.Default.SearchMRUNameList),
                new MRUComboHelper<SearchType, string>(SearchType.TypeFullSearch, "Full w/Type", TESVSnip.Properties.Settings.Default.SearchMRUFullList),
                new MRUComboHelper<SearchType, string>(SearchType.FormIDRef, "Form ID Ref.", TESVSnip.Properties.Settings.Default.SearchMRUFormIDList),
                new MRUComboHelper<SearchType, string>(SearchType.BasicCriteriaRef, "Basic Search", new StringCollection()),
            };
            toolStripIncrFindType.Items.Clear();
            toolStripIncrFindType.Items.AddRange(items);

            int idx = 0;
            if ( !string.IsNullOrEmpty(Properties.Settings.Default.LastSearchType) )
            {
                idx = toolStripIncrFindType.FindStringExact(Properties.Settings.Default.LastSearchType);
            }
            idx = idx >= 0 ? idx : 0;
            toolStripIncrFindType.SelectedIndex = idx;        

            ResetSearch();
            toolStripIncrFindStatus.Text = "";
            if (!RecordStructure.Loaded)
                RecordStructure.Load();
            toolStripIncrFindTypeFilter.Sorted = true;
            toolStripIncrFindTypeFilter.Items.Clear();
            if (RecordStructure.Records != null)
            {
                var recitems = RecordStructure.Records.Keys.OfType<object>().ToArray();
                toolStripIncrFindTypeFilter.Items.AddRange(recitems);
            }
            toolStripIncrFindTypeFilter.SelectedIndex = 0;

            backgroundWorker1.DoWork += backgroundWorker1_DoWork;
            backgroundWorker1.RunWorkerCompleted += backgroundWorker1_RunWorkerCompleted;
            backgroundWorker1.ProgressChanged += backgroundWorker1_ProgressChanged;
        }

        private void toolStripIncrFindType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var item = toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (item != null)
            {
                Properties.Settings.Default.LastSearchType = toolStripIncrFindType.Text;
            }
            
            if (item != null && (item.Key == SearchType.TypeEditorIdSearch || item.Key == SearchType.TypeFullSearch))
            {
                toolStripIncrFindTypeFilter.Visible = true;
                toolStripIncrFindExact.Visible = false;
                toolStripSelectColumns.Visible = true;
            }
            else
            {
                toolStripIncrFindTypeFilter.Visible = false;
                toolStripIncrFindExact.Visible = true;
                toolStripSelectColumns.Visible = false;
            }

            if (item != null && item.Key == SearchType.BasicCriteriaRef)
            {
                toolStripIncrSelectCriteria.Visible = true;
                toolStripIncrFindText.Visible = false;
                toolStripIncrFindText.Items.Clear();
                toolStripIncrFindGo.Enabled = toolStripIncrSelectCriteria.Tag != null;
                toolStripSelectColumns.Visible = true;
            }
            else
            {
                toolStripIncrFindGo.Enabled = true;
                toolStripIncrSelectCriteria.Visible = false;
                toolStripIncrFindText.Visible = true;
                toolStripIncrFindText.Items.Clear();
                if (item != null && item.MRU != null && item.MRU.Count > 0)
                {
                    toolStripIncrFindText.Items.AddRange(item.MRU.OfType<object>().Take(15).ToArray());
                }
            }
        }

        private ICollection<Record> IncrementalSearch(Predicate<BaseRecord> searchFunc)
        {
            return PluginList.All.Enumerate(searchFunc).OfType<Record>().Take(Properties.Settings.Default.MaxSearchResults).ToList();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="type">Type of search to perform</param>
        /// <param name="text">Text to search for</param>
        /// <param name="partial">Allow for partial Text matches</param>
        /// <param name="updateFunc">Function to call to update the UI when doing select</param>
        private class SearchSettings
        {
            public SearchType Type;
            public string Text;
            public string Rectype;
            public bool Partial;
            public SearchCriteriaSettings Criteria;
            public Predicate<BaseRecord> UpdateFunc;

            public SearchSettings()
            {
                Type = SearchType.EditorID;
                Text = null;
                Partial = true;
                Criteria = null;
                UpdateFunc = null;
                Rectype = null;
            }
        }
        private class SearchResults
        {
            public SearchType Type;
            public string Text;
            public string Rectype;
            public bool Partial;
            public SearchCriteriaSettings Criteria;
            public AdvancedList<Record> Records = new AdvancedList<Record>();
        }

        /// <summary>
        /// Helper routine for doing an actual search
        /// </summary>
        /// <param name="ctx"> </param>
        /// <returns></returns>
        private ICollection<Record> PerformSearch(SearchSettings ctx)
        {
            Predicate<BaseRecord> searchFunction = null;

            switch (ctx.Type)
            {
                case SearchType.FormID:
                    {
                        if (string.IsNullOrEmpty(ctx.Text))
                            return null;

                        uint searchID;
                        if (!uint.TryParse(ctx.Text, NumberStyles.AllowHexSpecifier, null, out searchID))
                        {
                            MainView.PostStatusWarning("Invalid FormID");
                            return null;
                        }
                        searchFunction = node =>
                        {
                            var rec = node as Record;
                            if (rec == null) return node is IGroupRecord;
                            if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node)) return false;
                            return rec.FormID == searchID;
                        };
                    }
                    break;
                case SearchType.TypeEditorIdSearch:
                case SearchType.EditorID:
                    {
                        if (ctx.Type == SearchType.TypeEditorIdSearch && string.IsNullOrEmpty(ctx.Rectype))
                            return null;
                        if (ctx.Type == SearchType.EditorID && string.IsNullOrEmpty(ctx.Text))
                            return null;

                        string searchString = string.IsNullOrEmpty(ctx.Text) ? null : ctx.Text.ToLowerInvariant();
                        searchFunction = node =>
                            {
                                if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node)) return false;
                                var rec = node as Record;
                                if (rec == null) return node is IGroupRecord;

                                bool typeOk = true;
                                if (ctx.Type == SearchType.TypeEditorIdSearch)
                                    typeOk = !string.IsNullOrEmpty(rec.Name) &&
                                             string.Compare(rec.Name, ctx.Rectype, true) == 0;
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
                                            return true;
                                    }
                                    else
                                    {
                                        var val = rec.DescriptiveName.ToLowerInvariant()
                                            .Substring(2, rec.DescriptiveName.Length - 3);

                                        if (val == searchString)
                                            return true;
                                    }
                                }
                                return false;
                            };
                    }
                    break;
                case SearchType.TypeFullSearch:
                case SearchType.FullSearch:
                    {
                        if (ctx.Type == SearchType.TypeFullSearch && string.IsNullOrEmpty(ctx.Rectype)) return null;
                        if (ctx.Type == SearchType.FullSearch && string.IsNullOrEmpty(ctx.Text)) return null;
                        string searchString = ctx.Text.ToLowerInvariant();
                        searchFunction = node =>
                            {
                                if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node)) return false;
                                var rec = node as Record;
                                if (rec == null) return node is IGroupRecord;
                                bool typeOk = true;
                                if (ctx.Type == SearchType.TypeFullSearch)
                                    typeOk = !string.IsNullOrEmpty(rec.Name) &&
                                                string.Compare(rec.Name, ctx.Rectype, true) == 0;
                                if (typeOk)
                                {
                                    foreach (SubRecord sr in rec.SubRecords)
                                    {
                                        var val = sr.GetStrData();
                                        if (!string.IsNullOrEmpty(val))
                                        {
                                            val = val.ToLowerInvariant();
                                            if ((ctx.Partial && val.Contains(searchString)) ||
                                                (val == searchString))
                                                return true;
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
                            return null;

                        uint searchID;
                        if (!uint.TryParse(ctx.Text, NumberStyles.AllowHexSpecifier, null, out searchID))
                        {
                            MainView.PostStatusWarning("Invalid FormID");
                            return null;
                        }
                        searchFunction = node =>
                            {
                                if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node)) return false;
                                var rec = node as Record;
                                if (rec == null) return node is IGroupRecord;
                                if (rec != null)
                                {
                                    rec.MatchRecordStructureToRecord();
                                    if ((from sr in rec.SubRecords
                                         from elem in rec.EnumerateElements(sr)
                                         let es = elem.Structure
                                         where es != null && es.type == ElementValueType.FormID
                                         select elem)
                                        .Any(elem => searchID == TypeConverter.h2i(elem.Data)))
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
                        searchFunction = node =>
                        {
                            if (ctx.UpdateFunc != null && !ctx.UpdateFunc(node)) return false;
                            var rec = node as Record;
                            if (rec == null) return node is IGroupRecord;
                            if (ctx.Criteria.Type != rec.Name) return false;
                            rec.MatchRecordStructureToRecord();
                            bool all = false;
                            foreach (var m in ctx.Criteria.Items)
                            {
                                bool ok = m.Match(rec);
                                if (!ok) return false;
                                all = true;
                            }
                            return all;
                        };
                    }
                    break;
            }
            return IncrementalSearch(searchFunction);
        }

        #region Increment Record Search

        private void BackgroundIncrementalSearch()
        {
            if (!PluginList.All.Enumerate(x => x != null).Any())
            {
                toolStripIncrFindStatus.Text = Resources.No_Plugins_Loaded;
                toolStripIncrFindStatus.ForeColor = Color.Maroon;
                if (!Properties.Settings.Default.NoWindowsSounds)
                    SystemSounds.Beep.Play();
                return;
            }

            var searchText = toolStripIncrFindText.Text;
            var searchTypeItem = toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (searchTypeItem == null) return;

            searchTypeItem.MRU.Remove(searchText);
            searchTypeItem.MRU.Insert(0, searchText);
            toolStripIncrFindStatus.Text = "";
            float totalNodes = PluginList.All.Enumerate(x => x != null).Count();
            int currentCount = 0, prevCount = 0;
            Predicate<BaseRecord> updateFunc = n =>
            {
                if (IsBackroundProcessCanceled()) // returning true will stop it
                    return false;
                var counter = (int)(++currentCount / totalNodes * 100.0f);
                if (counter != prevCount)
                {
                    prevCount = counter;
                    if (counter % 10 == 0) UpdateBackgroundProgress(counter);
                }
                return true;
            };

            var searchContext = new SearchSettings();
            searchContext.Type = searchTypeItem.Key;
            searchContext.Text = toolStripIncrFindText.Text;
            searchContext.Partial = !toolStripIncrFindExact.Checked;
            searchContext.Rectype = toolStripIncrFindTypeFilter.SelectedItem as string;
            searchContext.Criteria = toolStripIncrSelectCriteria.Tag as SearchCriteriaSettings;
            searchContext.UpdateFunc = updateFunc;

            // exclude null Text searches except for when type is specified
            if (searchContext.Type == SearchType.BasicCriteriaRef)
            {
                if (searchContext.Criteria == null || !searchContext.Criteria.Items.Any())
                {
                    if (!Properties.Settings.Default.NoWindowsSounds)
                        SystemSounds.Beep.Play();
                    MainView.PostStatusWarning("No search criteria selected!");
                }
            }
            else if (searchContext.Type != SearchType.TypeEditorIdSearch && string.IsNullOrEmpty(searchContext.Text))
            {
                if (!Properties.Settings.Default.NoWindowsSounds)
                    SystemSounds.Beep.Play();
                toolStripIncrFind.Focus();
                toolStripIncrFindText.Select();
                toolStripIncrFindText.Focus();
                return;
            }

            this.listSearchView.ClearObjects();
            
            SearchResults results = null;
            StartBackgroundWork(() =>
                {
                    results = new SearchResults
                    {
                        Type = searchContext.Type,
                        Partial = searchContext.Partial,
                        Rectype = searchContext.Rectype,
                        Text = searchContext.Text,
                        Criteria = searchContext.Criteria,
                        Records = new AdvancedList<Record>(PerformSearch(searchContext))
                    };
                }
                , () =>
                {
                    if (IsBackroundProcessCanceled())
                    {
                        toolStripIncrFindStatus.Text = "Search Canceled";
                        toolStripIncrFindStatus.ForeColor = Color.Black;
                    }
                    else
                    {
                        if (results != null && results.Records != null && results.Records.Count > 0)
                        {
                            toolStripIncrFindStatus.Text = string.Format(Resources.SearchProgressChanged_Items_Found, results.Records.Count);
                            toolStripIncrFindStatus.ForeColor = Color.Black;
                            toolStripIncrFindText.Tag = false;
                            UpdateSearchList(results);
                        }
                        else
                        {
                            toolStripIncrFindText.Tag = true;
                            toolStripIncrFindStatus.Text = "No Matches Found";
                            toolStripIncrFindStatus.ForeColor = Color.Maroon;
                            if (!Properties.Settings.Default.NoWindowsSounds)
                                SystemSounds.Beep.Play();
                        }
                        toolStripIncrFind.Focus();
                        toolStripIncrFindText.Select();
                        toolStripIncrFindText.Focus();
                    }
                }
            );
        }

        private Plugin GetPluginFromNode(BaseRecord node)
        {
            BaseRecord tn = node;
            if (tn is Plugin) return (Plugin)tn;
            while (!(tn is Plugin) && tn != null) tn = tn.Parent;
            if (tn != null) return tn as Plugin;
            return null;
        }

        private void UpdateSearchList(SearchResults results)
        {
            this.listSearchView.Columns.Clear();
            this.listSearchView.AllColumns.Clear();
            this.listSearchView.ClearObjects();
            if (results == null) return;
            foreach (var rec in results.Records) rec.MatchRecordStructureToRecord();

            var fixedColumns = new List<OLVColumn>(new[]
                    {
                        new OLVColumn{ Text = "Plugin", Name = "Plugin", AspectName = "Plugin", Width = 5, IsVisible = true, Groupable = true
                            , AspectGetter = x => GetPluginFromNode(x as Record) }, 
                        new OLVColumn{ Text = "Type", Name = "Type", AspectName = "Type", Width = 100, IsVisible = true
                            , AspectGetter = x => { var rec = (x as Record); return rec != null ? rec.Name : ""; } },
                        new OLVColumn{ Text = "Name", Name = "Name", AspectName = "Name", Width = 200, IsVisible = true, Groupable = true
                            , AspectGetter = x => { 
                                var rec = (x as Record); 
                                var sr = rec != null ? rec.SubRecords.FirstOrDefault(r=>r.Name == "EDID") : null;
                                var elem = sr != null ? sr.GetStrData() : null;
                                return elem ?? "";
                            } },
                        new OLVColumn{ Text = "FormID", Name = "FormID", AspectName = "FormID", Width = 80, IsVisible = true, Groupable = true
                            , AspectGetter = x => { var rec = (x as Record); return rec != null ? rec.FormID.ToString("X8") : ""; } },
                        new OLVColumn{ Text = "Full Name", Name = "FullName", AspectName = "FullName", Width = 200, IsVisible = true, Groupable = true
                            , AspectGetter = 
                            x => { 
                                var rec = (x as Record); 
                                var sr = rec != null ? rec.SubRecords.FirstOrDefault(r=>r.Name == "FULL") : null;
                                var elem = sr != null ? sr.GetLString() : null;
                                return elem ?? "";
                            } },
                    }
                    );

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
                            Text = dispName, Name = colName, AspectName = name, Width = 80, IsVisible = true, Groupable = true
                            , AspectGetter = x =>
                            {
                                var rec = (x as Record);
                                var sr = rec != null ? rec.SubRecords.FirstOrDefault(r => r.Name == type) : null;
                                var se = sr != null ? sr.EnumerateElements().FirstOrDefault(e => e.Structure.name == name) : null;
                                return se != null ? sr.GetDisplayValue(se) : null;
                            }
                        }
                        );
                }
            }
            baseColumns = fixedColumns.ToArray();
            this.listSearchView.AllColumns.AddRange(baseColumns);
            
            var columnSettings = this.toolStripSelectColumns.Tag as ColumnSettings;
            ApplyColumnSettings(columnSettings, rebuild: false);                
            this.listSearchView.AutoResizeColumns(ColumnHeaderAutoResizeStyle.ColumnContent);

            this.listSearchView.Objects = results.Records;
            this.listSearchView.RebuildColumns();
            this.listSearchView.Refresh();
        }

        private void toolStripIncrFindText_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == (char)Keys.Enter)
            {
                e.SuppressKeyPress = true;
                e.Handled = true;
                BackgroundIncrementalSearch();
            }
        }

        private void ResetSearch()
        {
            // use tag to indicate Text changed and therefore reset the search
            toolStripIncrFindText.Tag = true;
            toolStripIncrFindStatus.Text = "";
        }

        private void toolStripIncrFindText_TextChanged(object sender, EventArgs e)
        {
            ResetSearch();
        }

        private void toolStripIncrFindTypeFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            ResetSearch();
        }

        private void toolStripCheck_CheckStateChanged(object sender, EventArgs e)
        {
            var button = sender as ToolStripButton;
            if (button != null)
                button.Image = button.Checked
                                   ? Resources.checkedbox
                                   : Resources.emptybox
                    ;
        }

        #endregion

        #region Action

        private volatile bool backgroundWorkCanceled;

        [Browsable(false)]
        public void StartBackgroundWork(Action workAction, Action completedAction)
        {
            if (backgroundWorker1.IsBusy)
                return;

            //EnableUserInterface(false);
            backgroundWorkCanceled = false;
            toolStripIncrFindCancel.Visible = true;
            backgroundWorker1.RunWorkerAsync(new[] { workAction, completedAction });
        }

        void UpdateBackgroundProgress(int percentProgress)
        {
            backgroundWorker1.ReportProgress(percentProgress);
        }

        void CancelBackgroundProcess()
        {
            backgroundWorkCanceled = true;
            backgroundWorker1.CancelAsync();
        }

        bool IsBackroundProcessCanceled()
        {
            return backgroundWorkCanceled;
        }

        void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            var actions = e.Argument as Action[];
            if (actions == null) return;
            if (actions.Length > 0)
                actions[0]();
            if (actions.Length > 1)
                e.Result = actions[1];
        }

        void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            toolStripIncrFindStatus.Text = string.Format("{0}% Complete", e.ProgressPercentage);
        }

        void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            toolStripIncrFindCancel.Visible = false;
            int nItems = this.listSearchView.GetItemCount();
            bool maxResultsHit = (nItems == Properties.Settings.Default.MaxSearchResults);
            string text = string.Format(Resources.SearchProgressChanged_Items_Found, nItems);
            if (maxResultsHit) text += " (Max Limited)";
            toolStripIncrFindStatus.Text = text;
            toolStripIncrFindStatus.ForeColor = SystemColors.ControlText;
            if (e.Cancelled || e.Error != null)
                return;
            var completedAction = e.Result as Action;
            if (completedAction != null) completedAction();
        }


        #endregion

        private void toolStripIncrFindGo_Click(object sender, EventArgs e)
        {
            BackgroundIncrementalSearch();
        }

        private void toolStripIncrFindCancel_Click(object sender, EventArgs e)
        {
            CancelBackgroundProcess();
        }

        #region ISupportInitialize Members

        public void BeginInit()
        {
        }

        public void EndInit()
        {
            if (!this.DesignMode)
                InitializeToolStripFind();
        }

        #endregion

        private void RecordSearch_Load(object sender, EventArgs e)
        {

        }

        public void FocusText()
        {
            toolStripIncrFindText.Focus();
        }

        private void toolStripSynchronize_Click(object sender, EventArgs e)
        {
            SynchronizeSelection();

        }

        private void SynchronizeSelection()
        {
            MainView.SynchronizeSelection(this.listSearchView.SelectedObjects.OfType<BaseRecord>());
        }

        private void listSearchView_CellClick(object sender, CellClickEventArgs e)
        {
            if (e.ClickCount > 1)
            {
                SynchronizeSelection();
            }
        }

        private void listSearchView_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter && e.Control && !e.Alt && !e.Shift)
            {
                SynchronizeSelection();
            }
        }

        private void toolStripIncrSelectCriteria_Click(object sender, EventArgs e)
        {
            using (var dlg = new SearchFilterBasic())
            {
                dlg.Criteria = toolStripIncrSelectCriteria.Tag as SearchCriteriaSettings;
                var result = dlg.ShowDialog(this);
                if (DialogResult.Cancel != result)
                {
                    toolStripIncrSelectCriteria.Tag = dlg.Criteria;
                    toolStripIncrFindGo.Enabled = dlg.Criteria != null && dlg.Criteria.Items.Any();
                    if (result == DialogResult.Yes)
                    {
                        BackgroundIncrementalSearch();
                    }
                }
            }
        }

        private void toolStripIncrFindClear_Click(object sender, EventArgs e)
        {
            this.listSearchView.ClearObjects();
        }

        IDockContent FindDockContent(Control c)
        {
            if (c is IDockContent)
                return c as IDockContent;
            else if (c.Parent != null)
                return FindDockContent(c.Parent);
            return null;
        }

        private void EditSelectedRecords()
        {
            var dockParent = FindDockContent(this);
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

        private void BatchEditSelectedRecords()
        {
            var selRec = this.listSearchView.SelectedObjects.OfType<Record>();
            using (var dlg = new BatchEditRecords(selRec) )
            {
                if (DialogResult.OK == dlg.ShowDialog(this) )
                {
                    BatchEditRecords.EditRecords(selRec, dlg.Criteria); // generate report of changes?
                    this.listSearchView.RebuildColumns();
                }
            }            
        }

        private void toolStripSelectColumns_Click(object sender, EventArgs e)
        {
            RecordStructure rec = null;

            var searchTypeItem = toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (searchTypeItem == null) return;
            if (searchTypeItem.Key == SearchType.BasicCriteriaRef)
            {
                var scs = toolStripIncrSelectCriteria.Tag as SearchCriteriaSettings;
                if ( scs != null && !string.IsNullOrEmpty(scs.Type))
                    RecordStructure.Records.TryGetValue(scs.Type, out rec);
            }
            else
            {
                var recType = toolStripIncrFindTypeFilter.SelectedItem as string;
                if (!string.IsNullOrEmpty(recType))
                    RecordStructure.Records.TryGetValue(recType, out rec);
            }
            using (var dlg = new RecordColumnSelect(rec))
            {
                dlg.Criteria = toolStripSelectColumns.Tag as ColumnSettings;
                if (DialogResult.OK == dlg.ShowDialog(this))
                {
                    var settings = dlg.Criteria;
                    ApplyColumnSettings(settings, rebuild:true);
                    toolStripSelectColumns.Tag = dlg.Criteria;
                }
            }
        }

        private void synchronizeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SynchronizeSelection();
        }

        private void resetToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ResetSearch();
        }

        private void editToolStripMenuItem_Click(object sender, EventArgs e)
        {
            EditSelectedRecords();
        }

        private void batchEditToolStripMenuItem_Click(object sender, EventArgs e)
        {
            BatchEditSelectedRecords();
        }

        internal void SetSearchCriteria(SearchCriteriaSettings settings, bool doSearch)
        {
            toolStripIncrSelectCriteria.Tag = settings;

            var cboItem = toolStripIncrFindType.Items.OfType<MRUComboHelper<SearchType, string>>().FirstOrDefault(
                x => x.Key == SearchType.BasicCriteriaRef);
            toolStripIncrFindType.SelectedItem = cboItem;
            if (doSearch) BackgroundIncrementalSearch();
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
                    if (Enumerable.OfType<OLVColumn>(baseColumns).Any(x => x.Name == colName)) continue;
                    var column = new OLVColumn
                    {
                        Text = dispName, Name = colName, AspectName = setting.Name,
                        Width = 80, IsVisible = true, Groupable = true, Tag = setting,
                        AspectGetter = x =>
                        {
                            var rec = (x as Record);
                            var sr = rec != null ? rec.SubRecords.FirstOrDefault(r => r.Name == type) : null;
                            var se = sr != null ? sr.EnumerateElements().FirstOrDefault(e => e.Structure.name == name) : null;
                            return se != null ? sr.GetDisplayValue(se) : null;
                        }
                    };
                    this.listSearchView.AllColumns.Add(column);
                    changed = true;
                }
            }
            if (changed && rebuild) this.listSearchView.RebuildColumns();
        }

        static readonly string[] groupingColumns = new string[] { "Type", "Plugin" };
        private void listSearchView_BeforeCreatingGroups(object sender, CreateGroupsEventArgs e)
        {
            try
            {
                if (e.Parameters.GroupByColumn != null)
                {
                    if (!groupingColumns.Contains(e.Parameters.GroupByColumn.Name))
                    {
                        var column = listSearchView.AllColumns.FirstOrDefault(x => x.Name == "Plugin");
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

        internal void ReferenceSearch(uint formid)
        {
            var cboItem = toolStripIncrFindType.Items.OfType<MRUComboHelper<SearchType, string>>().FirstOrDefault(
                x => x.Key == SearchType.FormIDRef);
            toolStripIncrFindType.SelectedItem = cboItem;
            toolStripIncrFindText.Text = formid.ToString("X8");
            BackgroundIncrementalSearch();
        }

        private void copyToToolStripMenuItem_DropDownItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            var array = e.ClickedItem.Tag as object[];
            if (array != null && array.Length == 2)
            {
                int count = Spells.CopyRecordsTo(array[0] as BaseRecord[], array[1] as IGroupRecord);
            }

        }

        private void contextMenuStripList_Opening(object sender, CancelEventArgs e)
        {
            var searchTypeItem = toolStripIncrFindType.SelectedItem as MRUComboHelper<SearchType, string>;
            if (searchTypeItem == null) return;

            var records = listSearchView.SelectedObjects.OfType<Record>().ToList();
            var hasDistictRecordsType = (records.Select(x => x.Name).Distinct().Count() == 1);
            bool anyRecords = records.Any();

            if (hasDistictRecordsType)
            {
                batchEditToolStripMenuItem.Enabled = true;
                batchEditToolStripMenuItem.ToolTipText = "";
            }
            else
            {
                batchEditToolStripMenuItem.Enabled = false;
                batchEditToolStripMenuItem.ToolTipText = string.Format("Batch Edit not allowed when multiple record types are selected");
            }

            copyToToolStripMenuItem.Enabled = anyRecords;
            editToolStripMenuItem.Enabled = anyRecords;
            synchronizeToolStripMenuItem.Enabled = anyRecords;
            batchEditToolStripMenuItem.Enabled &= anyRecords;
            copyToolStripMenuItem.Enabled = anyRecords;

            if (copyToToolStripMenuItem.Enabled)
            {
                foreach (var plugin in PluginList.All.Records.OfType<Plugin>())
                {
                    Plugin curplugin = plugin;
                    var copyRecs = records.Where(x => x.GetPlugin() != curplugin);
                    if (!copyRecs.Any()) continue;

                    var tsi = new ToolStripButton(plugin.Name);
                    tsi.Tag = new object[] { copyRecs.OfType<BaseRecord>().ToArray(), curplugin };
                    var sz = TextRenderer.MeasureText(plugin.Name, copyToToolStripMenuItem.Font);
                    if (sz.Width > tsi.Width)
                        tsi.Width = sz.Width;
                    tsi.AutoSize = true;
                    copyToToolStripMenuItem.DropDownItems.Add(tsi);
                }
            }
        }

        private void contextMenuStripList_Closing(object sender, ToolStripDropDownClosingEventArgs e)
        {
            copyToToolStripMenuItem.DropDownItems.Clear();
        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MainView.Clipboard = listSearchView.SelectedObjects.OfType<BaseRecord>().ToArray();
        }

        private void reportToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var dockParent = FindDockContent(this);

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
    }
}