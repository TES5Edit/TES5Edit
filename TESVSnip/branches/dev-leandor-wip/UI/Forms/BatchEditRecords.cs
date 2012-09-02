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

    internal partial class BatchEditRecords : Form
    {
        private OLVColumn olvColumnCond;

        private OLVColumn olvColumnName;

        private OLVColumn olvColumnValue;

        private RecordStructure rec;

        private IEnumerable<Record> records;

        public BatchEditRecords()
        {
            this.InitializeComponent();
            this.filterTree.CheckBoxes = true;
            Icon = Resources.tesv_ico;
        }

        internal BatchEditRecords(IEnumerable<Record> records)
            : this()
        {
            this.ConfigureRecords(records);
        }

        public BatchCriteriaSettings Criteria { get; set; }

        public static void EditRecords(IEnumerable<Record> records, BatchCriteriaSettings settings)
        {
            if (settings != null && records != null)
            {
                var q = settings.Items.GroupBy(
                    x => {
                        if (x is BatchSubrecord)
                        {
                            return ((BatchSubrecord)x).Record;
                        }

                        if (x is BatchElement)
                        {
                            return ((BatchElement)x).Parent.Record;
                        }

                        return null;
                    });
                foreach (var rec in records)
                {
                    foreach (var kvp in q)
                    {
                        // delete or create any subrecords
                        foreach (BatchCriteria criteria in kvp)
                        {
                            var sr1 = criteria as BatchSubrecord;
                            if (sr1 != null)
                            {
                                sr1.Evaluate(rec);
                            }
                        }

                        var sr = rec.SubRecords.FirstOrDefault(x => x.Name == kvp.Key.name);
                        if (sr != null)
                        {
                            try
                            {
                                var elements = sr.EnumerateElements(rawData: true).ToList();
                                foreach (var sre in kvp.OfType<BatchElement>())
                                {
                                    BatchElement sre1 = sre;
                                    foreach (var elem in elements.Where(x => x.Structure.Equals(sre1.Record)))
                                    {
                                        elem.AssignValue(GetAssignmentType(sre1.Type), sre.Value);
                                    }
                                }

                                if (elements.Any(x => x.Changed))
                                {
                                    // need to repack the structure
                                    using (var ms = new MemoryStream(sr.GetReadonlyData().Length))
                                    {
                                        foreach (var seg in elements.Select(elem => elem.Data))
                                        {
                                            ms.Write(seg.Array, seg.Offset, seg.Count);
                                        }

                                        sr.SetData(ms.ToArray());
                                    }
                                }
                                else if (elements.Any(x => x.Modified))
                                {
                                    // all changes inline
                                }
                            }
                            catch
                            {
                            }
                        }
                    }
                }
            }
        }

        public void ConfigureRecords(IEnumerable<Record> records)
        {
            var recs = records.Select(
                x => {
                    RecordStructure rs;
                    return RecordStructure.Records.TryGetValue(x.Name, out rs) ? rs : null;
                }).Distinct();

            this.rec = (recs.Count() == 1) ? recs.FirstOrDefault() : null;
            if (this.rec == null)
            {
                this.filterTree.Roots = null;
            }
            else
            {
                this.records = records;

                var srs = (from sr in this.rec.subrecords
                           let children = sr.elements.Select(se => new BatchElement() { Name = se.name, Parent = null, Record = se, Type = BatchCondElementType.Set, Checked = false }).ToList()
                           select new BatchSubrecord() { Name = string.Format("{0}: {1}", sr.name, sr.desc), Record = sr, Children = children, Checked = false, }).ToList();

                // Construct specialized editors for FormID and related headers
#if false
                {
                    var elems = new List<TESVSnip.Data.SubrecordElement>
                    {
                        new TESVSnip.Data.SubrecordElement{name = "FormID", desc = "Form ID", hexview = true, type = "uint"}, 
                        new TESVSnip.Data.SubrecordElement{name = "Flags1", desc = "Flags 1", hexview = true, type = "uint"}, 
                        new TESVSnip.Data.SubrecordElement{name = "Flags2", desc = "Flags 2", hexview = true, type = "uint"}, 
                        new TESVSnip.Data.SubrecordElement{name = "Flags3", desc = "Flags 3", hexview = true, type = "uint"}, 
                    };
                    var frmHdr = new TESVSnip.Data.Subrecord { name = "Header", desc = "Record Header", Elements = elems };
                    var hdr = new SubrecordStructure(frmHdr);
                    var hdrElems = hdr.elements.Select(se =>
                        new BatchElement { Name = se.name, Parent = null, Record = se, Type = BatchCondElementType.Set, Checked = false }
                        ).ToList();
                    srs.Insert(0, new BatchSubrecord
                    {
                        Name = string.Format("{0}: {1}", hdr.name, hdr.desc), 
                        Record = hdr, 
                        Children = hdrElems, 
                        Checked = false, 
                    });
                }
#endif

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

        private static ElementAssignmentType GetAssignmentType(BatchCondElementType type)
        {
            switch (type)
            {
                case BatchCondElementType.Set:
                    return ElementAssignmentType.Set;
                case BatchCondElementType.Add:
                    return ElementAssignmentType.Add;
                case BatchCondElementType.Subtract:
                    return ElementAssignmentType.Subtract;
                case BatchCondElementType.Multiply:
                    return ElementAssignmentType.Multiply;
                case BatchCondElementType.Divide:
                    return ElementAssignmentType.Divide;
                case BatchCondElementType.BitAnd:
                    return ElementAssignmentType.BitAnd;
                case BatchCondElementType.BitOr:
                    return ElementAssignmentType.BitOr;
                case BatchCondElementType.Clear:
                    return ElementAssignmentType.Clear;
            }

            return ElementAssignmentType.Set;
            
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
                var items = checkeditems.OfType<BatchCriteria>().ToArray();
                if (items.Length == 0)
                {
                    DialogResult = DialogResult.None;
                    MessageBox.Show(this, "No Batch criteria was selected.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
                }
                else
                {
                    this.Criteria = new BatchCriteriaSettings();
                    this.Criteria.Type = this.rec.name;
                    this.Criteria.Items = items;
                    return true;
                }
            }

            return false;
        }

        private void BatchEditRecords_Shown(object sender, EventArgs e)
        {
            this.filterTree_SizeChanged(sender, e);
        }

        private void BatchFilter_Load(object sender, EventArgs e)
        {
            this.InitializeTreeList();
        }

        private void InitializeTreeList()
        {
            this.filterTree.SizeChanged += this.filterTree_SizeChanged;

            this.filterTree.MultiSelect = true;
            this.filterTree.CanExpandGetter = x => (x is BatchSubrecord);
            this.filterTree.ChildrenGetter = x => {
                var r = x as BatchSubrecord;
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
                        var r = x as BatchCriteria;
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
                    AspectGetter = x => (x is BatchSubrecord) ? (object)((BatchSubrecord)x).Type : (x is BatchElement) ? (object)((BatchElement)x).Type : null, 
                    AspectPutter = (x, v) => {
                        if (x is BatchSubrecord)
                        {
                            ((BatchSubrecord)x).Type = (BatchCondRecordType)v;
                        }

                        if (x is BatchElement)
                        {
                            ((BatchElement)x).Type = (BatchCondElementType)v;
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
                        var r = x as BatchElement;
                        return (r != null) ? r.Value : null;
                    }
                };
            this.filterTree.Columns.Add(this.olvColumnName);
            this.filterTree.Columns.Add(this.olvColumnCond);
            this.filterTree.Columns.Add(this.olvColumnValue);
            this.filterTree.CellEditActivation = ObjectListView.CellEditActivateMode.SingleClick;

            this.filterTree.Roots = this.filterTree.Roots;

            var checkedItems = new ArrayList();
            if (this.Criteria != null)
            {
                var modelItems = this.filterTree.Roots.OfType<BatchSubrecord>();

                foreach (var item in this.Criteria.Items.OfType<BatchSubrecord>())
                {
                    var modelItem = modelItems.FirstOrDefault(x => x.Name == item.Name);
                    if (modelItem != null)
                    {
                        modelItem.Checked = true;
                        modelItem.Type = item.Type;
                        checkedItems.Add(modelItem);
                    }
                }

                foreach (var item in this.Criteria.Items.OfType<BatchElement>())
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

        private void bApply_Click(object sender, EventArgs e)
        {
            if (this.ApplySettings())
            {
                DialogResult = DialogResult.OK; // Apply.  No to Batch immediately
            }
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
