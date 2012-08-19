namespace TESVSnip.UI.Docking
{
    using TESVSnip.UI.ObjectControls;

    using WeifenLuo.WinFormsUI.Docking;

    public partial class PluginTreeContent : DockContent
    {
        public PluginTreeContent()
        {
            this.InitializeComponent();
        }

        public PluginTreeView PluginTree
        {
            get
            {
                return this.pluginTreeControl;
            }
        }
    }
}
