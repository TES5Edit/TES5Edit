namespace TESVSnip.Docking
{
    using TESVSnip.UI.ObjectControls;

    public partial class SubrecordListContent : WeifenLuo.WinFormsUI.Docking.DockContent
    {
        public SubrecordListContent()
        {
            InitializeComponent();
        }

        public SubrecordListEditor SubrecordList
        {
            get { return this.subrecordPanel; }
        }
    }
}
