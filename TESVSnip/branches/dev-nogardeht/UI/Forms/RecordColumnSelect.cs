namespace TESVSnip.UI.Forms
{
    using System;
    using System.Collections;
    using System.Linq;
    using System.Windows.Forms;

    using BrightIdeasSoftware;

    using TESVSnip.Domain.Data.RecordStructure;
    using TESVSnip.Domain.Model;
    using TESVSnip.Properties;

    internal partial class RecordColumnSelect : Form
    {
        private OLVColumn olvColumnName;

        private RecordStructure rec;

        public RecordColumnSelect()
        {
            this.InitializeComponent();
            Icon = Resources.tesv_ico;
        }

        internal RecordColumnSelect(RecordStructure rec)
            : this()
        {
            this.ConfigureRecord(rec);
        }

        public ColumnSettings Criteria { get; set; }

        public void ConfigureRecord(RecordStructure rec)
        {
            this.rec = rec;
            if (rec == null)
            {
                this.filterTree.Roots = null;
            }
            else
            {
                var srs = (from sr in rec.subrecords
                           let children = sr.elements.Select(se => new ColumnElement() { Checked = false, Name = se.name, Parent = null, Record = se }).ToList()
                           select new ColumnSubrecord() { Name = string.Format("{0}: {1}", sr.name, sr.desc), Checked = false, Record = sr, Children = children }).ToList();

                // fix parents after assignments
                foreach (var sr in srs)
                {
                    foreach (var se in sr.Children)
                    {
                        se.Parent = sr;
                    }
                }

                this.filterTree.Roots = srs;
            }
        }

        private bool ApplySettings()
        {
            var recStruct = this.rec;
            if (recStruct == null)
            {
                DialogResult = DialogResult.None;
                MessageBox.Show(this, "No record was selected.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
            }
            else
            {
                var checkeditems = this.filterTree.CheckedObjectsEnumerable;
                var items = checkeditems.OfType<ColumnCriteria>().ToArray();
                if (items.Length == 0)
                {
                    DialogResult = DialogResult.None;
                    MessageBox.Show(this, "No Column criteria was selected.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
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

        private void ColumnFilter_Load(object sender, EventArgs e)
        {
            this.InitializeTreeList();
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
            this.filterTree.CanExpandGetter = x => (x is ColumnSubrecord);
            this.filterTree.ChildrenGetter = x => {
                var r = x as ColumnSubrecord;
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
                        var r = x as ColumnCriteria;
                        return (r != null) ? r.Name : x;
                    }
                };
            this.filterTree.Columns.Add(this.olvColumnName);
            this.filterTree.CellEditActivation = ObjectListView.CellEditActivateMode.SingleClick;

            this.filterTree.Roots = this.filterTree.Roots;

            var checkedItems = new ArrayList();
            if (this.Criteria != null)
            {
                var modelItems = this.filterTree.Roots.OfType<ColumnSubrecord>();

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
                        this.filterTree.Expand(modelItem);
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

        private void bApply_Click(object sender, EventArgs e)
        {
            if (this.ApplySettings())
            {
                DialogResult = DialogResult.OK;
            }
        }

        private void filterTree_Enter(object sender, EventArgs e)
        {
            // throw new NotImplementedException();
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
    }
}
