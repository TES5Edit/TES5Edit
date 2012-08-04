namespace TESVSnip.Docking
{
    public partial class SubrecordListContent : WeifenLuo.WinFormsUI.Docking.DockContent
    {
        public SubrecordListContent()
        {
            InitializeComponent();
        }

        public TESVSnip.ObjectControls.SubrecordListEditor SubrecordList
        {
            get { return this.subrecordPanel; }
        }
    }
}
