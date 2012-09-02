namespace TESVSnip.UI.Forms
{
    using System;
    using System.Linq;
    using System.Windows.Forms;

    using BrightIdeasSoftware;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Properties;

    internal partial class SearchFilterAdvanced : Form
    {
        private OLVColumn olvColumnCond;

        private OLVColumn olvColumnName;

        private OLVColumn olvColumnValue;

        private RecordStructure rec;

        public SearchFilterAdvanced()
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
        }

        internal SearchFilterAdvanced(RecordStructure rec)
            : this()
        {
            this.ConfigureRecord(rec);
        }

        public void ConfigureRecord(RecordStructure rec)
        {
            this.rec = rec;
            var srs = (from sr in rec.subrecords
                       let children = sr.elements.Select(se => new SearchElement() { Checked = false, Name = se.name, Parent = null, Record = se }).ToList()
                       select new SearchSubrecord() { Name = sr.name, Checked = false, Record = sr, Children = children }).ToList();
            this.filterTree.Roots = srs;
        }

        private void InitializeTreeList()
        {
            this.filterTree.ModelCanDrop += this.filterTree_ModelCanDrop;
            this.filterTree.ModelDropped += this.filterTree_ModelDropped;
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

            var sink1 = (SimpleDropSink)this.filterTree.DropSink;
            sink1.AcceptExternal = false;
            sink1.CanDropBetween = true;
            sink1.CanDropOnBackground = false;
            sink1.CanDropOnSubItem = false;

            this.filterTree.Roots = this.filterTree.Roots;
        }

        private void SearchFilter_Load(object sender, EventArgs e)
        {
            this.InitializeTreeList();
        }

        private void filterTree_Enter(object sender, EventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_KeyDown(object sender, KeyEventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_ModelCanDrop(object sender, ModelDropEventArgs e)
        {
            // throw new NotImplementedException();
        }

        private void filterTree_ModelDropped(object sender, ModelDropEventArgs e)
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
    }
}
