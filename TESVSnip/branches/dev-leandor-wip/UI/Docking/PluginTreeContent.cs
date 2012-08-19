namespace TESVSnip.Docking
{
    using TESVSnip.UI.ObjectControls;

    public partial class PluginTreeContent : WeifenLuo.WinFormsUI.Docking.DockContent
    {
        public PluginTreeContent()
        {
            InitializeComponent();
        }

        public PluginTreeView PluginTree
        {
            get { return this.pluginTreeControl; }
        }
    }
}
