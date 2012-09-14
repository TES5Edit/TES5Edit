namespace TESVSnip.UI.Forms
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Drawing;
    using System.Globalization;
    using System.Linq;
    using System.Media;
    using System.Windows.Forms;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Framework;

    using Settings = TESVSnip.Properties.Settings;

    /// <summary>
    /// This file contains the incremental search related functionality for the main form.
    /// </summary>
    internal partial class MainView
    {
        private enum SearchType
        {
            EditorID, 

            FormID, 

            FullSearch, 

            TypeEditorIdSearch, 

            TypeFullSearch, 

            FormIDRef, 
        }

        internal BaseRecord IncrementalSearch(BaseRecord tn, bool first, bool forward, bool wrapAround, Predicate<BaseRecord> searchFunc)
        {
            using (var itr = new RecursiveRecordIterator(tn, forward))
            {
                BaseRecord startNode = null;
                Debug.Assert(tn.Equals(itr.Current));
                bool keep = first;
                do
                {
                    do
                    {
                        tn = itr.Current;
                        if (keep && searchFunc(tn))
                        {
                            return tn;
                        }

                        keep = true;
                        if (startNode == null)
                        {
                            startNode = tn;
                        }
                        else if (startNode.Equals(tn))
                        {
                            return null;
                        }
                    }
                    while (itr.MoveNext());

                    if (!wrapAround)
                    {
                        break;
                    }

                    itr.Push(PluginList.All.Records[0] as BaseRecord);
                    itr.Reset();
                    wrapAround = false; // multipass protection
                }
                while (itr.MoveNext());
            }

            return null;
        }

        internal bool findNonConformingRecordIncremental(BaseRecord tn, bool forward, bool wrapAround)
        {
            var node = this.IncrementalSearch(tn, false, forward, wrapAround, this.IsNonConformingRecord);
            if (node != null)
            {
                this.PluginTree.SelectedRecord = node;
            }

            return node != null;
        }

        private void BackgroundIncrementalSearch(BaseRecord start, bool forward)
        {
            float totalNodes = PluginList.All.Enumerate(x => x != null).Count();
            if (totalNodes == 0)
            {
                this.toolStripIncrInvalidRecStatus.Text = "No Plugins Loaded";
                this.toolStripIncrInvalidRecStatus.ForeColor = Color.Maroon;
                if (!Settings.Default.NoWindowsSounds)
                {
                    SystemSounds.Beep.Play();
                }

                return;
            }

            int prevCount = 0;
            float currentCount = 0.0f;
            BaseRecord foundNode = null;
            this.toolStripIncrFindStatus.Text = string.Empty;

            // Grab selected node before searching as it can only be accessed from UI thread
            if (start == null)
            {
                start = this.PluginTree.SelectedRecord != null ? this.PluginTree.SelectedRecord : this.PluginTree.TopRecord;
            }

            Predicate<BaseRecord> updateFunc = n => {
                if (this.IsBackroundProcessCanceled())
                {
                    // returning true will stop it
                    return true;
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

                return false;
            };

            var searchContext = new SearchSettings();

            var item = this.toolStripIncrFindType.SelectedItem as ComboHelper<SearchType, string>;
            searchContext.startNode = start;
            searchContext.type = item.Key;
            searchContext.text = this.toolStripIncrFindText.Text;
            searchContext.partial = !this.toolStripIncrFindExact.Checked;
            searchContext.wrapAround = this.toolStripIncrFindWrapAround.Checked;
            searchContext.first = this.toolStripIncrFindText.Tag == null ? true : (bool)this.toolStripIncrFindText.Tag;
            searchContext.rectype = this.toolStripIncrFindTypeFilter.SelectedItem as string;
            searchContext.forward = forward;
            searchContext.updateFunc = updateFunc;

            // exclude null text searches except for when type is specified
            if (searchContext.type != SearchType.TypeEditorIdSearch && string.IsNullOrEmpty(searchContext.text))
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

            this.StartBackgroundWork(
                () => { foundNode = this.PerformSearch(searchContext); }, 
                () => {
                    if (this.IsBackroundProcessCanceled())
                    {
                        this.toolStripIncrFindStatus.Text = "Search Canceled";
                        this.toolStripIncrFindStatus.ForeColor = Color.Black;
                    }
                    else
                    {
                        if (foundNode != null)
                        {
                            this.toolStripIncrFindStatus.Text = "Match Found";
                            this.toolStripIncrFindStatus.ForeColor = Color.Black;
                            this.PluginTree.SelectedRecord = foundNode;
                            this.toolStripIncrFindText.Tag = false;
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

        private void BackgroundNonConformingRecordIncrementalSearch(BaseRecord tn, bool forward, bool wrapAround)
        {
            float totalNodes = PluginList.All.Enumerate(x => x != null).Count();
            if (totalNodes == 0)
            {
                this.toolStripIncrInvalidRecStatus.Text = "No Plugins Loaded";
                this.toolStripIncrInvalidRecStatus.ForeColor = Color.Maroon;
                if (!Settings.Default.NoWindowsSounds)
                {
                    SystemSounds.Beep.Play();
                }

                return;
            }

            tn = this.PluginTree.SelectedRecord ?? this.PluginTree.TopRecord ?? null;

            int prevCount = 0;
            float currentCount = 0.0f;
            BaseRecord foundNode = null;
            this.toolStripIncrInvalidRecStatus.Text = string.Empty;

            Predicate<BaseRecord> searchFunc = (BaseRecord n) => {
                if (this.IsNonConformingRecord(n))
                {
                    return true;
                }

                if (this.IsBackroundProcessCanceled())
                {
                    // returning true will stop it
                    return true;
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

                return false;
            };

            this.StartBackgroundWork(
                () => { foundNode = this.IncrementalSearch(tn, false, forward, wrapAround, searchFunc); }, 
                () => {
                    if (this.IsBackroundProcessCanceled())
                    {
                        this.toolStripIncrInvalidRecStatus.Text = "Search Canceled";
                        this.toolStripIncrInvalidRecStatus.ForeColor = Color.Black;
                    }
                    else
                    {
                        if (foundNode != null)
                        {
                            this.toolStripIncrInvalidRecStatus.Text = "Invalid Record Found";
                            this.toolStripIncrInvalidRecStatus.ForeColor = Color.Black;
                            this.PluginTree.SelectedRecord = foundNode;
                        }
                        else
                        {
                            this.toolStripIncrInvalidRecStatus.Text = "No Invalid Records Found";
                            this.toolStripIncrInvalidRecStatus.ForeColor = Color.Maroon;
                            if (!Settings.Default.NoWindowsSounds)
                            {
                                SystemSounds.Beep.Play();
                            }
                        }
                    }
                });
        }

        private void InitializeToolStripFind()
        {
            var items = new[]
                {
                    new ComboHelper<SearchType, string>(SearchType.EditorID, "Editor ID"), new ComboHelper<SearchType, string>(SearchType.FormID, "Form ID"), 
                    new ComboHelper<SearchType, string>(SearchType.FullSearch, "Full Search"), new ComboHelper<SearchType, string>(SearchType.TypeEditorIdSearch, "Name w/Type"), 
                    new ComboHelper<SearchType, string>(SearchType.TypeFullSearch, "Full w/Type"), new ComboHelper<SearchType, string>(SearchType.FormIDRef, "Form ID Ref."), 
                };
            this.toolStripIncrFindType.Items.Clear();
            foreach (var itm in items)
            {
                this.toolStripIncrFindType.Items.Add(itm);
            }

            this.toolStripIncrFindType.SelectedIndex = 0;

            // toolStripIncrFindType.SelectedItem = toolStripIncrFindType.Items[0];
            this.ResetSearch();
            this.toolStripIncrFindStatus.Text = string.Empty;

            if (!RecordStructure.Loaded)
            {
                RecordStructure.Load();
            }

            var recitems = RecordStructure.Records.Keys.OfType<object>().ToArray();

            // var recitems = TESVSnip.Properties.Settings.Default.AllESMRecords != null
            // ? TESVSnip.Properties.Settings.Default.AllESMRecords.Trim().Split(new char[] { ';', ',' }, StringSplitOptions.RemoveEmptyEntries).OfType<object>().ToArray()
            // : new object[0];
            this.toolStripIncrFindTypeFilter.Sorted = true;
            this.toolStripIncrFindTypeFilter.Items.Clear();
            this.toolStripIncrFindTypeFilter.Items.AddRange(recitems);
            this.toolStripIncrFindTypeFilter.SelectedIndex = 0;
        }

        private bool IsNonConformingRecord(BaseRecord tn)
        {
            if (tn is Record)
            {
                var r = tn as Record;
                return r != null && !r.MatchRecordStructureToRecord();
            }

            return false;
        }

        /// <summary>
        /// Helper routine for doing an actual search.
        /// </summary>
        /// <param name="ctx">
        /// The ctx.
        /// </param>
        /// <returns>
        /// The TESVSnip.Model.BaseRecord.
        /// </returns>
        private BaseRecord PerformSearch(SearchSettings ctx)
        {
            Predicate<BaseRecord> searchFunction = null;

            if (ctx.type == SearchType.FormID)
            {
                if (string.IsNullOrEmpty(ctx.text))
                {
                    return null;
                }

                uint searchID;
                if (!uint.TryParse(ctx.text, NumberStyles.AllowHexSpecifier, null, out searchID))
                {
                    PostStatusWarning("Invalid FormID");
                    return null;
                }

                searchFunction = (BaseRecord node) => {
                    var rec = node as Record;
                    if (ctx.updateFunc != null && ctx.updateFunc(node))
                    {
                        return true;
                    }

                    return (rec != null) ? rec.FormID == searchID : false;
                };
            }
            else if (ctx.type == SearchType.EditorID || ctx.type == SearchType.TypeEditorIdSearch)
            {
                if (ctx.type == SearchType.TypeEditorIdSearch && string.IsNullOrEmpty(ctx.rectype))
                {
                    return null;
                }

                if (ctx.type == SearchType.EditorID && string.IsNullOrEmpty(ctx.text))
                {
                    return null;
                }

                string searchString = string.IsNullOrEmpty(ctx.text) ? null : ctx.text.ToLowerInvariant();
                searchFunction = (BaseRecord node) => {
                    var rec = node as Record;
                    if (rec != null)
                    {
                        bool typeOk = true;
                        if (ctx.type == SearchType.TypeEditorIdSearch)
                        {
                            typeOk = !string.IsNullOrEmpty(rec.Name) && string.Compare(rec.Name, ctx.rectype, true) == 0;
                        }

                        if (typeOk)
                        {
                            if (string.IsNullOrEmpty(searchString))
                            {
                                return true;
                            }
                            else if (ctx.partial)
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
                    }

                    if (ctx.updateFunc != null && ctx.updateFunc(node))
                    {
                        return true;
                    }

                    return false;
                };
            }
            else if (ctx.type == SearchType.FullSearch || ctx.type == SearchType.TypeFullSearch)
            {
                if (ctx.type == SearchType.TypeFullSearch && string.IsNullOrEmpty(ctx.rectype))
                {
                    return null;
                }

                if (ctx.type == SearchType.FullSearch && string.IsNullOrEmpty(ctx.text))
                {
                    return null;
                }

                string searchString = ctx.text.ToLowerInvariant();
                searchFunction = node => {
                    var rec = node as Record;
                    if (rec != null)
                    {
                        bool typeOk = true;
                        if (ctx.type == SearchType.TypeFullSearch)
                        {
                            typeOk = !string.IsNullOrEmpty(rec.Name) && string.Compare(rec.Name, ctx.rectype, true) == 0;
                        }

                        if (typeOk)
                        {
                            foreach (SubRecord sr in rec.SubRecords)
                            {
                                var val = sr.GetStrData();
                                if (!string.IsNullOrEmpty(val))
                                {
                                    val = val.ToLowerInvariant();
                                    if ((ctx.partial && val.Contains(searchString)) || (val == searchString))
                                    {
                                        return true;
                                    }
                                }
                            }
                        }
                    }

                    if (ctx.updateFunc != null && ctx.updateFunc(node))
                    {
                        return true;
                    }

                    return false;
                };
            }
            else if (ctx.type == SearchType.FormIDRef)
            {
                // Back reference form id search
                if (string.IsNullOrEmpty(ctx.text))
                {
                    return null;
                }

                uint searchID;
                if (!uint.TryParse(ctx.text, NumberStyles.AllowHexSpecifier, null, out searchID))
                {
                    PostStatusWarning("Invalid FormID");
                    return null;
                }

                searchFunction = node => {
                    var rec = node as Record;
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

                    if (ctx.updateFunc != null && ctx.updateFunc(node))
                    {
                        return true;
                    }

                    return false;
                };
            }

            return this.IncrementalSearch(ctx.startNode, ctx.first, ctx.forward, ctx.wrapAround, searchFunction);
        }

        private void ResetSearch()
        {
            // use tag to indicate text changed and therefore reset the search
            this.toolStripIncrFindText.Tag = true;
            this.toolStripIncrFindStatus.Text = string.Empty;
        }

        private void findNonconformingRecordToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.toolStripIncrInvalidRec.Visible = !this.toolStripIncrInvalidRec.Visible;
            if (this.toolStripIncrInvalidRec.Visible)
            {
                this.toolStripIncrInvalidRec.Focus();
                this.toolStripIncrInvalidRecNext.Select();
            }

            this.toolStripIncrInvalidRec.Enabled = this.toolStripIncrInvalidRec.Visible;
        }

        private void toolStripIncrFindCancel_Click(object sender, EventArgs e)
        {
            this.toolStripIncrFind.Visible = false;
            this.toolStripIncrFind.Enabled = false;
        }

        private void toolStripIncrFindNext_Click(object sender, EventArgs e)
        {
            this.BackgroundIncrementalSearch(this.PluginTree.SelectedRecord, true);
        }

        private void toolStripIncrFindPrev_Click(object sender, EventArgs e)
        {
            this.BackgroundIncrementalSearch(this.PluginTree.SelectedRecord, false);
        }

        private void toolStripIncrFindRestart_Click(object sender, EventArgs e)
        {
            this.ResetSearch();
            this.BackgroundIncrementalSearch(this.PluginTree.TopRecord, true);
        }

        private void toolStripIncrFindSelection_RecordChanged(object sender, EventArgs e)
        {
            if (this.Selection != null && this.Selection.Record != null)
            {
                int idx = this.toolStripIncrFindTypeFilter.FindStringExact(this.Selection.Record.Name);
                if (idx >= 0)
                {
                    this.toolStripIncrFindTypeFilter.SelectedIndex = idx;
                }
            }
        }

        private void toolStripIncrFindText_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyValue == (char)Keys.Enter)
            {
                e.SuppressKeyPress = true;
                e.Handled = true;
                this.BackgroundIncrementalSearch(this.PluginTree.SelectedRecord, !e.Shift);
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

        private void toolStripIncrFindTypeFilter_VisibleChanged(object sender, EventArgs e)
        {
            if (this.toolStripIncrFindTypeFilter.Visible)
            {
                if (this.Selection != null)
                {
                    this.Selection.RecordChanged += this.toolStripIncrFindSelection_RecordChanged;
                    this.toolStripIncrFindSelection_RecordChanged(null, null);
                }
            }
            else
            {
                this.Selection.RecordChanged -= this.toolStripIncrFindSelection_RecordChanged;
            }
        }

        private void toolStripIncrFindType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var item = this.toolStripIncrFindType.SelectedItem as ComboHelper<SearchType, string>;
            if (item != null && (item.Key == SearchType.TypeEditorIdSearch || item.Key == SearchType.TypeFullSearch))
            {
                this.toolStripIncrFindTypeFilter.Visible = true;
                this.toolStripIncrFindExact.Visible = false;
            }
            else
            {
                this.toolStripIncrFindTypeFilter.Visible = false;
                this.toolStripIncrFindExact.Visible = true;
            }
        }

        private void toolStripIncrFind_VisibleChanged(object sender, EventArgs e)
        {
            this.findToolStripMenuItem.Checked = this.toolStripIncrFind.Visible;
            this.toolStripIncrFindStatus.Text = string.Empty;
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

        private class RecordIterator : IEnumerator<BaseRecord>
        {
            private readonly bool forward;

            private int current;

            private BaseRecord parent;

            public RecordIterator(BaseRecord rec, bool forward)
            {
                this.parent = rec.Parent;
                this.current = this.parent.Records.IndexOf(rec);
                this.forward = forward;
            }

            public RecordIterator(BaseRecord parent, int index, bool forward)
            {
                this.parent = parent;
                this.current = (index != -1) ? index : (forward ? -1 : parent.Records.Count);
                this.forward = forward;
            }

            public BaseRecord Current
            {
                get
                {
                    if (this.parent == null || this.current < 0 || this.current >= this.parent.Records.Count)
                    {
                        return null;
                    }

                    return this.parent.Records[this.current] as BaseRecord;
                }
            }

            object IEnumerator.Current
            {
                get
                {
                    return this.Current;
                }
            }

            public void Dispose()
            {
                this.current = -1;
                this.parent = null;
            }

            public bool MoveNext()
            {
                if (this.forward)
                {
                    ++this.current;
                }
                else
                {
                    --this.current;
                }

                return !(this.parent == null || this.current < 0 || this.current >= this.parent.Records.Count);
            }

            public void Reset()
            {
                if (this.parent != null)
                {
                    if (this.forward)
                    {
                        this.current = -1;
                    }
                    else
                    {
                        this.current = this.parent.Records.Count;
                    }
                }
            }
        }

        private class RecursiveRecordIterator : IEnumerator<BaseRecord>
        {
            private readonly bool forward;

            private bool needMoveNext;

            private Stack<RecordIterator> stack;

            public RecursiveRecordIterator(BaseRecord tn, bool forward)
            {
                this.forward = forward;
                this.Push(tn);
            }

            public BaseRecord Current
            {
                get
                {
                    return this.stack.Peek().Current;
                }
            }

            object IEnumerator.Current
            {
                get
                {
                    return this.Current;
                }
            }

            public void Dispose()
            {
                foreach (var itr in this.stack)
                {
                    itr.Dispose();
                }

                this.stack.Clear();
            }

            public bool MoveNext()
            {
                while (this.stack.Count > 0)
                {
                    var itr = this.stack.Peek();
                    if (this.needMoveNext && !itr.MoveNext())
                    {
                        return false;
                    }

                    this.needMoveNext = false;

                    var r = itr.Current;
                    if (r == null)
                    {
                        return false;
                    }

                    if (r.Records.Count > 0)
                    {
                        itr = new RecordIterator(itr.Current, -1, this.forward);
                        this.stack.Push(itr);
                    }

                    while (true)
                    {
                        bool ok = itr.MoveNext();
                        if (ok)
                        {
                            return true;
                        }

                        this.stack.Pop();
                        if (this.stack.Count == 0)
                        {
                            return false;
                        }

                        itr = this.stack.Peek();
                    }
                }

                return false;
            }

            public void Push(BaseRecord tn)
            {
                var queue = new Stack<RecordIterator>();
                for (; tn != null && tn.Parent != null; tn = tn.Parent)
                {
                    queue.Push(new RecordIterator(tn, this.forward));
                }

                if (this.stack == null || this.stack.Count == 0)
                {
                    this.stack = new Stack<RecordIterator>(queue);
                }
                else
                {
                    foreach (var itm in queue)
                    {
                        this.stack.Push(itm);
                    }
                }
            }

            public void Reset()
            {
                while (this.stack.Count > 1)
                {
                    var itr = this.stack.Pop();
                    itr.Dispose();
                }

                if (this.stack.Count == 1)
                {
                    this.stack.Peek().Reset();
                }

                this.needMoveNext = true;
            }
        }

        private class SearchSettings
        {
            public bool first;

            public bool forward;

            public bool partial;

            public string rectype;

            public BaseRecord startNode;

            public string text;

            public SearchType type;

            public Predicate<BaseRecord> updateFunc;

            public bool wrapAround;

            public SearchSettings()
            {
                this.type = SearchType.EditorID;
                this.startNode = null;
                this.text = null;
                this.first = true;
                this.partial = true;
                this.forward = true;
                this.wrapAround = true;
                this.updateFunc = null;
                this.rectype = null;
            }
        }
    }
}
