using TESVSnip.Properties;
using WeifenLuo.WinFormsUI.Docking;

namespace TESVSnip.Docking
{
    public partial class FullRecordEditor : BaseDockContent
    {
        public FullRecordEditor()
        {
            InitializeComponent();
        }

        public FullRecordEditor(Record rec) : this()
        {
            Record = rec;
        }


        public Record Record
        {
            get { return panelRecordEditor.Record; }
            set
            {
                panelRecordEditor.Record = value;
                UpdateTitle();
            }
        }
        void UpdateTitle()
        {
            if (panelRecordEditor.Record != null)
            {
                if (this.Pane == null || this.Pane.IsFloat)
                {
                    Text = string.Format("{0} - [{1:X8}] {2}", Resources.FullRecordEditorTitle
                        , panelRecordEditor.Record.FormID, panelRecordEditor.Record.DescriptiveName);                    
                }
                else
                {
                    Text = string.Format("[{0:X8}] {1}"
                        , panelRecordEditor.Record.FormID
                        , panelRecordEditor.Record.DescriptiveName);
                }

            }            
            else
            {
                Text = Resources.FullRecordEditorTitle;
            }
        }
        private void FullRecordEditor_DockStateChanged(object sender, System.EventArgs e)
        {
            UpdateTitle();
        }
    }
}