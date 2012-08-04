using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using BrightIdeasSoftware;
using TESVSnip.Model;

namespace TESVSnip.Forms
{
    internal partial class SearchFilterAdvanced : Form
    {
        private RecordStructure rec;
        private OLVColumn olvColumnName;
        private OLVColumn olvColumnCond;
        private OLVColumn olvColumnValue;

        public SearchFilterAdvanced()
        {
            InitializeComponent();
            this.Icon = TESVSnip.Properties.Resources.tesv_ico;
        }

        internal SearchFilterAdvanced(RecordStructure rec)
            : this()
        {
            ConfigureRecord(rec);
        }

        private void SearchFilter_Load(object sender, EventArgs e)
        {
            InitializeTreeList();
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

            filterTree.MultiSelect = true;
            filterTree.CanExpandGetter = x => (x is SearchSubrecord);
            filterTree.ChildrenGetter = x =>
            {
                var r = x as SearchSubrecord;
                return (r != null) ? r.Children : null;
            };

            olvColumnName = new OLVColumn
            {
                Name = "Name", Text = "Name", AspectName = "Name", Width = 175, IsVisible = true, IsEditable = false,
                AspectGetter = x => { var r = x as SearchCriteria; return (r != null) ? r.Name : x;}
            };
            olvColumnCond = new OLVColumn
            {
                Name = "Cond", Text = "Cond", AspectName = "Cond", Width = 100, IsVisible = true, IsEditable = true,
                AspectGetter = x => (x is SearchSubrecord) ? (object)((SearchSubrecord)x).Type : (x is SearchElement) ? (object)((SearchElement)x).Type : null,
                AspectPutter = (x,v) =>
                                   {
                                       if (x is SearchSubrecord) ((SearchSubrecord) x).Type = (SearchCondRecordType) v;
                                       if (x is SearchElement) ((SearchElement) x).Type = (SearchCondElementType) v;
                                   },
            };
            olvColumnValue = new OLVColumn
            {
                Name = "Value", Text = "Value", AspectName = "Value", Width = 100, IsVisible = true, IsEditable = true,
                AspectGetter = x => { var r = x as SearchElement; return (r != null) ? r.Value : null; }
            };
            filterTree.Columns.Add(olvColumnName);
            filterTree.Columns.Add(olvColumnCond);
            filterTree.Columns.Add(olvColumnValue);
            filterTree.CellEditActivation = ObjectListView.CellEditActivateMode.SingleClick;


            var sink1 = (SimpleDropSink)filterTree.DropSink;
            sink1.AcceptExternal = false;
            sink1.CanDropBetween = true;
            sink1.CanDropOnBackground = false;
            sink1.CanDropOnSubItem = false;

            filterTree.Roots = filterTree.Roots;
        }

        public void ConfigureRecord(RecordStructure rec)
        {
            this.rec = rec;
            var srs = (from sr in rec.subrecords
                       let children = sr.elements.Select(
                            se => new SearchElement() { Checked = false, Name = se.name, Parent = null, Record = se }
                       ).ToList()
                       select new SearchSubrecord()
                                  {
                                      Name = sr.name,
                                      Checked = false,
                                      Record = sr,
                                      Children = children
                                  }).ToList();
            filterTree.Roots = srs;
        }

        private void filterTree_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            //throw new NotImplementedException();
        }

        private void filterTree_KeyDown(object sender, KeyEventArgs e)
        {
            //throw new NotImplementedException();
        }

        private void filterTree_Enter(object sender, EventArgs e)
        {
            //throw new NotImplementedException();
        }

        private void filterTree_SizeChanged(object sender, EventArgs e)
        {
            try
            {
                int width = this.filterTree.Columns.OfType<OLVColumn>().Sum(x => x.Width);
                var col = this.filterTree.Columns.OfType<OLVColumn>().LastOrDefault(x => x.IsVisible);
                if (col != null)
                {
                    col.Width = this.filterTree.Width - width + col.Width
                              - SystemInformation.VerticalScrollBarWidth - SystemInformation.FrameBorderSize.Width;
                }
            }
            catch
            {
            }
        }

        private void filterTree_SelectedIndexChanged(object sender, EventArgs e)
        {
            //throw new NotImplementedException();
        }

        private void filterTree_SelectionChanged(object sender, EventArgs e)
        {
            //throw new NotImplementedException();
        }

        private void filterTree_ModelDropped(object sender, ModelDropEventArgs e)
        {
            //throw new NotImplementedException();
        }

        private void filterTree_ModelCanDrop(object sender, ModelDropEventArgs e)
        {
            //throw new NotImplementedException();
        }
    }
}
