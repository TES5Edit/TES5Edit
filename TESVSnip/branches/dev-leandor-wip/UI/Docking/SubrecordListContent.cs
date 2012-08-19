namespace TESVSnip.UI.Docking
{
    using TESVSnip.UI.ObjectControls;

    using WeifenLuo.WinFormsUI.Docking;

    public partial class SubrecordListContent : DockContent
    {
        public SubrecordListContent()
        {
            this.InitializeComponent();
        }

        public SubrecordListEditor SubrecordList
        {
            get
            {
                return this.subrecordPanel;
            }
        }
    }
}
