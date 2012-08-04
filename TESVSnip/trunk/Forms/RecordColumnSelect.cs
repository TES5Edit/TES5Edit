using System;
using System.Collections;
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
    internal partial class RecordColumnSelect : Form
    {
        private RecordStructure rec;
        private OLVColumn olvColumnName;

        public RecordColumnSelect()
        {
            InitializeComponent();
            this.Icon = TESVSnip.Properties.Resources.tesv_ico;
        }

        internal RecordColumnSelect(RecordStructure rec)
            : this()
        {
            ConfigureRecord(rec);
        }

        private void ColumnFilter_Load(object sender, EventArgs e)
        {
            InitializeTreeList();
        }
        
        private void InitializeTreeList()
        {
            this.filterTree.SelectionChanged += this.filterTree_SelectionChanged;
            this.filterTree.SelectedIndexChanged += this.filterTree_SelectedIndexChanged;
            this.filterTree.SizeChanged += this.filterTree_SizeChanged;
            this.filterTree.Enter += this.filterTree_Enter;
            this.filterTree.KeyDown += this.filterTree_KeyDown;
            this.filterTree.MouseDoubleClick += this.filterTree_MouseDoubleClick;

            filterTree.MultiSelect = true;
            filterTree.CanExpandGetter = x => (x is ColumnSubrecord);
            filterTree.ChildrenGetter = x =>
            {
                var r = x as ColumnSubrecord;
                return (r != null) ? r.Children : null;
            };

            olvColumnName = new OLVColumn
            {
                Name = "Name", Text = "Name", AspectName = "Name", Width = 175, IsVisible = true, IsEditable = false,
                AspectGetter = x => { var r = x as ColumnCriteria; return (r != null) ? r.Name : x;}
            };
            filterTree.Columns.Add(olvColumnName);
            filterTree.CellEditActivation = ObjectListView.CellEditActivateMode.SingleClick;

            filterTree.Roots = filterTree.Roots;

            var checkedItems = new ArrayList();
            if (this.Criteria != null)
            {
                var modelItems = filterTree.Roots.OfType<ColumnSubrecord>();

                foreach (var item in this.Criteria.Items.OfType<ColumnSubrecord>())
                {
                    var modelItem = modelItems.FirstOrDefault(x => x.Name == item.Name);
                    if (modelItem != null)
                    {
                        modelItem.Checked = true;
                    }
                }
                foreach (var item in this.Criteria.Items.OfType<ColumnElement>())
                {
                    var modelItem = modelItems.FirstOrDefault(x => x.Name == item.Parent.Name);
                    if (modelItem != null)
                    {
                        filterTree.Expand(modelItem);
                        var modelElem = modelItem.Children.FirstOrDefault(x => x.Name == item.Name);
                        if (modelElem != null)
                        {
                            modelElem.Checked = true;
                            checkedItems.Add(modelElem);
                        }
                    }
                }
                this.filterTree.CheckObjects(checkedItems);
            }
        }

        public void ConfigureRecord(RecordStructure rec)
        {
            this.rec = rec;
            if (rec == null)
                filterTree.Roots = null;
            else
            {
                var srs = (from sr in rec.subrecords
                           let children = sr.elements.Select(
                                se => new ColumnElement() { Checked = false, Name = se.name, Parent = null, Record = se }
                           ).ToList()
                           select new ColumnSubrecord()
                           {
                               Name = string.Format("{0}: {1}", sr.name, sr.desc),
                               Checked = false,
                               Record = sr,
                               Children = children
                           }).ToList();
                // fix parents after assignments
                foreach (var sr in srs)
                    foreach (var se in sr.Children)
                        se.Parent = sr;

                filterTree.Roots = srs;

            }
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


        public ColumnSettings Criteria { get; set; }
 
        private bool ApplySettings()
        {
            var recStruct = rec;
            if (recStruct == null)
            {
                this.DialogResult = DialogResult.None;
                MessageBox.Show(this, "No record was selected.", "Warning", MessageBoxButtons.OK,
                                MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
            }
            else
            {
                var checkeditems = this.filterTree.CheckedObjectsEnumerable;
                var items = checkeditems.OfType<ColumnCriteria>().ToArray();
                if (items.Length == 0)
                {
                    this.DialogResult = DialogResult.None;
                    MessageBox.Show(this, "No Column criteria was selected.", "Warning", MessageBoxButtons.OK,
                                    MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
                }
                else
                {
                    this.Criteria = new ColumnSettings();
                    this.Criteria.Type = recStruct.name;
                    this.Criteria.Items = items;
                    return true;
                }
            }
            return false;
        }

        private void bApply_Click(object sender, EventArgs e)
        {
            if (ApplySettings())
            {
                this.DialogResult = DialogResult.OK;
            }
        }
    }
}
