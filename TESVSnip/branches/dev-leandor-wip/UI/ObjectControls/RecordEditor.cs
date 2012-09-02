namespace TESVSnip.UI.ObjectControls
{
    using System;
    using System.ComponentModel;
    using System.Globalization;
    using System.Linq;
    using System.Windows.Forms;

    using TESVSnip.Domain.Model;
    using TESVSnip.Framework.Collections;
    using TESVSnip.UI.Forms;

    public partial class RecordEditor : UserControl
    {
        private readonly SelectionContext context = new SelectionContext();

        private readonly AdvancedList<SubRecord> subRecords = new AdvancedList<SubRecord>();

        private uint Flags1;

        private uint Flags2;

        private uint Flags3;

        private uint FormID;

        private Record _record;

        public RecordEditor()
        {
            this.InitializeComponent();
            this.comboBox1.SetItems(FlagDefs.RecFlags1, 4);

            this.subrecordListEditor.SetContext(this.context);
            this.subrecordListEditor.OnEditSubrecord += this.subrecordListEditor_OnEditSubrecord;
            this.subrecordListEditor.SelectionChanged += this.subrecordListEditor_SelectionChanged;
        }

        public RecordEditor(Record rec)
            : this()
        {
            this.Record = rec;
        }

        public Record Record
        {
            get
            {
                return this._record;
            }

            set
            {
                if (this._record != value)
                {
                    this._record = value;
                    this.context.Record = this._record;
                    if (this._record != null)
                    {
                        this.ResetValues();
                    }
                }
            }
        }

        private void Apply()
        {
            this._record.Name = this.tbName.Text;
            this._record.Flags1 = this.Flags1;
            this._record.Flags2 = this.Flags2;
            this._record.Flags3 = this.Flags3;
            this._record.FormID = this.FormID;
            this._record.UpdateShortDescription();
            this._record.SubRecords.Clear();
            this.elementEditor.Save();
            this._record.AddRecords(this.subrecordListEditor.SubRecords.OfType<BaseRecord>());
        }

        private void ResetValues()
        {
            this.Flags1 = this._record.Flags1;
            this.Flags2 = this._record.Flags2;
            this.Flags3 = this._record.Flags3;
            this.FormID = this._record.FormID;
            this.subRecords.Clear();
            var srs = this._record.SubRecords.Select(x => x.Clone()).OfType<SubRecord>().ToArray();
            this._record.MatchRecordStructureToRecord(srs);
            this.subRecords.AddRange(srs);
            this.subrecordListEditor.SubRecords = this.subRecords;

            this.tbName.Text = this._record.Name;
            this.tbFormID.Text = this._record.FormID.ToString("X8");
            this.textBox1.Text = this._record.Flags1.ToString("X8");

            try
            {
                this.comboBox1.ItemCheck -= this.comboBox1_ItemCheck;
                this.comboBox1.SetState(this._record.Flags1);
            }
            finally
            {
                this.comboBox1.ItemCheck += this.comboBox1_ItemCheck;
            }

            this.tbFlags2.Text = this._record.Flags2.ToString("X8");
            this.tbFlags3.Text = this._record.Flags3.ToString("X8");
        }

        private void bCancel_Click(object sender, EventArgs e)
        {
            this.ResetValues();
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            this.Apply();
        }

        private void comboBox1_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            this.Flags1 = this.comboBox1.GetState();
            this.textBox1.Text = this.Flags1.ToString("X8");
        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            this.Flags1 = this.comboBox1.GetState();
            this.textBox1.Text = this.Flags1.ToString("X8");
        }

        private void subrecordListEditor_OnEditSubrecord(SubRecord sr, bool hexView)
        {
            this.elementEditor.SetContext(this.Record, sr, hexView);
        }

        private void subrecordListEditor_SelectionChanged(object sender, EventArgs e)
        {
            var sr = this.subrecordListEditor.SubRecord;
            bool hexview = sr == null || sr.Structure == null;
            this.elementEditor.SetContext(this.Record, this.subrecordListEditor.SubRecord, hexview);
        }

        private void tbFlags2_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(this.tbFlags2.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid Flags Number Format");
                e.Cancel = true;
            }

            this.Flags2 = value;
        }

        private void tbFlags3_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(this.tbFlags3.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid Flags Number Format");
                e.Cancel = true;
            }

            this.Flags3 = value;
        }

        private void tbFormID_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(this.tbFormID.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid FormID Format");
                e.Cancel = true;
            }

            this.FormID = value;
        }

        private void textBox1_Validating(object sender, CancelEventArgs e)
        {
            uint value;
            if (!uint.TryParse(this.textBox1.Text, NumberStyles.HexNumber, null, out value))
            {
                MainView.PostStatusWarning("Invalid Flags Number Format");
                e.Cancel = true;
            }

            this.Flags1 = value;
        }
    }
}
