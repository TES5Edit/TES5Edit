namespace TESVSnip.Docking
{
    public partial class PluginTreeContent : WeifenLuo.WinFormsUI.Docking.DockContent
    {
        public PluginTreeContent()
        {
            InitializeComponent();
        }

        public TESVSnip.ObjectControls.PluginTreeView PluginTree
        {
            get { return this.pluginTreeControl; }
        }
    }
}
