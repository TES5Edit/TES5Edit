using System;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using TESVSnip.Collections.Generic;

namespace TESVSnip.Forms
{
    public partial class RecordEditor : UserControl
    {
        private readonly SelectionContext context = new SelectionContext();
        private Record _record;
        private uint Flags1;
        private uint Flags2;
        private uint Flags3;
        private uint FormID;
        private readonly AdvancedList<SubRecord> subRecords = new AdvancedList<SubRecord>();

        public RecordEditor()
        {
            InitializeComponent();
            comboBox1.SetItems(FlagDefs.RecFlags1);

            subrecordListEditor.SetContext(context);
            subrecordListEditor.OnEditSubrecord += subrecordListEditor_OnEditSubrecord;
            subrecordListEditor.SelectionChanged += subrecordListEditor_SelectionChanged;
        }

        public RecordEditor(Record rec) : this()
        {
            Record = rec;
        }

        private void subrecordListEditor_OnEditSubrecord(SubRecord sr, bool hexView)
        {
            elementEditor.SetContext(Record, sr, hexView);
        }

        private void subrecordListEditor_SelectionChanged(object sender, EventArgs e)
        {
            var sr = subrecordListEditor.SubRecord;
            bool hexview = (sr == null || sr.Structure == null);
            elementEditor.SetContext(Record, subrecordListEditor.SubRecord, hexview);
        }

        public Record Record
        {
            get { return _record; }
            set
            {
                if (_record != value)
                {
                    _record = value;
                    context.Record = _record;
                    if (_record != null)
                        ResetValues();
                }
            }
        }

        private void ResetValues()
        {
            Flags1 = _record.Flags1;
            Flags2 = _record.Flags2;
            Flags3 = _record.Flags3;
            FormID = _record.FormID;
            subRecords.Clear();
            var srs = _record.SubRecords.Select(x => x.Clone()).OfType<SubRecord>().ToArray();
            _record.MatchRecordStructureToRecord(srs);
            subRecords.AddRange(srs);
            subrecordListEditor.SubRecords = subRecords;

            tbName.Text = _record.Name;
            tbFormID.Text = _record.FormID.ToString("X8");
            textBox1.Text = _record.Flags1.ToString("X8");

            try
            {
                comboBox1.ItemCheck -= comboBox1_ItemCheck;
                comboBox1.SetState(_record.Flags1);
            }
            finally
            {
                comboBox1.ItemCheck += comboBox1_ItemCheck;
            }
            tbFlags2.Text = _record.Flags2.ToString("X8");
            tbFlags3.Text = _record.Flags3.ToString("X8");
        }

        private void tbFormID_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(tbFormID.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid FormID Format");
                e.Cancel = true;
            }
            FormID = value;
        }

        private void textBox1_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(textBox1.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid Flags Number Format");
                e.Cancel = true;
            }
            Flags1 = value;
        }

        private void tbFlags2_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(tbFlags2.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid Flags Number Format");
                e.Cancel = true;
            }
            Flags2 = value;
        }

        private void tbFlags3_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(tbFlags3.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid Flags Number Format");
                e.Cancel = true;
            }
            Flags3 = value;
        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            Flags1 = comboBox1.GetState();
            textBox1.Text = Flags1.ToString("X8");
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            Apply();
        }

        private void bCancel_Click(object sender, EventArgs e)
        {
            ResetValues();
        }

        private void Apply()
        {
            _record.Name = tbName.Text;
            _record.Flags1 = Flags1;
            _record.Flags2 = Flags2;
            _record.Flags3 = Flags3;
            _record.FormID = FormID;
            _record.UpdateShortDescription();
            _record.SubRecords.Clear();
            elementEditor.Save();
            _record.AddRecords(subrecordListEditor.SubRecords.OfType<BaseRecord>());
        }

        private void comboBox1_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            Flags1 = comboBox1.GetState();
            textBox1.Text = Flags1.ToString("X8");
        }
    }
}