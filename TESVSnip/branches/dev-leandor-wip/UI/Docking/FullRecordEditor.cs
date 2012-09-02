namespace TESVSnip.UI.Docking
{
    using System;

    using TESVSnip.Domain.Model;
    using TESVSnip.Properties;

    public partial class FullRecordEditor : BaseDockContent
    {
        public FullRecordEditor()
        {
            this.InitializeComponent();
        }

        public FullRecordEditor(Record rec)
            : this()
        {
            this.Record = rec;
        }

        public Record Record
        {
            get
            {
                return this.panelRecordEditor.Record;
            }

            set
            {
                this.panelRecordEditor.Record = value;
                this.UpdateTitle();
            }
        }

        private void FullRecordEditor_DockStateChanged(object sender, EventArgs e)
        {
            this.UpdateTitle();
        }

        private void UpdateTitle()
        {
            if (this.panelRecordEditor.Record != null)
            {
                if (Pane == null || Pane.IsFloat)
                {
                    Text = string.Format("{0} - [{1:X8}] {2}", Resources.FullRecordEditorTitle, this.panelRecordEditor.Record.FormID, this.panelRecordEditor.Record.DescriptiveName);
                }
                else
                {
                    Text = string.Format("[{0:X8}] {1}", this.panelRecordEditor.Record.FormID, this.panelRecordEditor.Record.DescriptiveName);
                }
            }
            else
            {
                Text = Resources.FullRecordEditorTitle;
            }
        }
    }
}
