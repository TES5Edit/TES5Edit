using TESVSnip.Forms;
using TESVSnip.ObjectControls;
namespace TESVSnip {
    partial class MainView {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if(disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainView));
            WeifenLuo.WinFormsUI.Docking.DockPanelSkin dockPanelSkin1 = new WeifenLuo.WinFormsUI.Docking.DockPanelSkin();
            WeifenLuo.WinFormsUI.Docking.AutoHideStripSkin autoHideStripSkin1 = new WeifenLuo.WinFormsUI.Docking.AutoHideStripSkin();
            WeifenLuo.WinFormsUI.Docking.DockPanelGradient dockPanelGradient1 = new WeifenLuo.WinFormsUI.Docking.DockPanelGradient();
            WeifenLuo.WinFormsUI.Docking.TabGradient tabGradient1 = new WeifenLuo.WinFormsUI.Docking.TabGradient();
            WeifenLuo.WinFormsUI.Docking.DockPaneStripSkin dockPaneStripSkin1 = new WeifenLuo.WinFormsUI.Docking.DockPaneStripSkin();
            WeifenLuo.WinFormsUI.Docking.DockPaneStripGradient dockPaneStripGradient1 = new WeifenLuo.WinFormsUI.Docking.DockPaneStripGradient();
            WeifenLuo.WinFormsUI.Docking.TabGradient tabGradient2 = new WeifenLuo.WinFormsUI.Docking.TabGradient();
            WeifenLuo.WinFormsUI.Docking.DockPanelGradient dockPanelGradient2 = new WeifenLuo.WinFormsUI.Docking.DockPanelGradient();
            WeifenLuo.WinFormsUI.Docking.TabGradient tabGradient3 = new WeifenLuo.WinFormsUI.Docking.TabGradient();
            WeifenLuo.WinFormsUI.Docking.DockPaneStripToolWindowGradient dockPaneStripToolWindowGradient1 = new WeifenLuo.WinFormsUI.Docking.DockPaneStripToolWindowGradient();
            WeifenLuo.WinFormsUI.Docking.TabGradient tabGradient4 = new WeifenLuo.WinFormsUI.Docking.TabGradient();
            WeifenLuo.WinFormsUI.Docking.TabGradient tabGradient5 = new WeifenLuo.WinFormsUI.Docking.TabGradient();
            WeifenLuo.WinFormsUI.Docking.DockPanelGradient dockPanelGradient3 = new WeifenLuo.WinFormsUI.Docking.DockPanelGradient();
            WeifenLuo.WinFormsUI.Docking.TabGradient tabGradient6 = new WeifenLuo.WinFormsUI.Docking.TabGradient();
            WeifenLuo.WinFormsUI.Docking.TabGradient tabGradient7 = new WeifenLuo.WinFormsUI.Docking.TabGradient();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.openNewPluginToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.closeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.closeAllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.reloadXmlToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.copyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pasteToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.deleteToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.insertGroupToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.insertRecordToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.insertSubrecordToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editSelectedToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editHeaderToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.addMasterToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.expandCollapseToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.expandAllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.collapseAllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.expandBranchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.collapseBranchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.findInRecordsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.findToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.searchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.searchAdvancedToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.optionsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.hexModeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.useNewSubrecordEditorToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.lookupFormidsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.uTF8ModeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.useWindowsClipboardToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.noWindowsSoundsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.disableHyperlinksToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.resetDockingWindowsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.eSMFilterSettingsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.compressionSettingsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.languageToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.englishToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.czechToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.frenchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.germanToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.italianToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.spanishToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.russianToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.polishToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editStringsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveStringsFilesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveStringsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stringLocalizerToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.reloadStringsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem2 = new System.Windows.Forms.ToolStripSeparator();
            this.internalizeStringReferencesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.extractInternalStringsToTableToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.copyReferencedStringsFromMastersToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cleanUnusedStringsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.createStubsForMissingStringsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exportStringsToFileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.importStringsToFileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.spellsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sanitizeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stripEDIDsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.findDuplicatedFormIDToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dumpEDIDListToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cleanEspToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.findNonconformingRecordToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.compileScriptToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.compileAllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.generateLLXmlToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.makeEsmToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.martigensToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.createRecordStructureXmlToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.mergeRecordsXMLToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.reorderSubrecordsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newFormIDToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newFormIDNoReferenceUpdateToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.OpenModDialog = new System.Windows.Forms.OpenFileDialog();
            this.SaveModDialog = new System.Windows.Forms.SaveFileDialog();
            this.SaveEdidListDialog = new System.Windows.Forms.SaveFileDialog();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStripStatusProgressBar = new System.Windows.Forms.ToolStripProgressBar();
            this.toolStripStopProgress = new System.Windows.Forms.ToolStripStatusLabel();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.toolStripIncrFind = new System.Windows.Forms.ToolStrip();
            this.toolStripIncrFindCancel = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindText = new System.Windows.Forms.ToolStripTextBox();
            this.toolStripIncrFindTypeFilter = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripIncrFindNext = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindPrev = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindRestart = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindType = new System.Windows.Forms.ToolStripComboBox();
            this.toolStripIncrFindMatch = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindExact = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrFindWrapAround = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator7 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripIncrFindStatus = new System.Windows.Forms.ToolStripLabel();
            this.toolStripIncrInvalidRec = new System.Windows.Forms.ToolStrip();
            this.toolStripIncrInvalidRecCancel = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrInvalidRecText = new System.Windows.Forms.ToolStripLabel();
            this.toolStripSeparator6 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripIncrInvalidRecNext = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrInvalidRecPrev = new System.Windows.Forms.ToolStripButton();
            this.toolStripIncrInvalidRecRestart = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripIncrInvalidRecWrapAround = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripIncrInvalidRecStatus = new System.Windows.Forms.ToolStripLabel();
            this.dockPanel = new WeifenLuo.WinFormsUI.Docking.DockPanel();
            this.pasteNewToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.toolStripIncrFind.SuspendLayout();
            this.toolStripIncrInvalidRec.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.editToolStripMenuItem,
            this.optionsToolStripMenuItem,
            this.toolsToolStripMenuItem,
            this.spellsToolStripMenuItem});
            resources.ApplyResources(this.menuStrip1, "menuStrip1");
            this.menuStrip1.Name = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newToolStripMenuItem,
            this.openNewPluginToolStripMenuItem,
            this.saveToolStripMenuItem,
            this.closeToolStripMenuItem,
            this.closeAllToolStripMenuItem,
            this.toolStripSeparator3,
            this.reloadXmlToolStripMenuItem,
            this.toolStripMenuItem1,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            resources.ApplyResources(this.fileToolStripMenuItem, "fileToolStripMenuItem");
            // 
            // newToolStripMenuItem
            // 
            this.newToolStripMenuItem.Name = "newToolStripMenuItem";
            resources.ApplyResources(this.newToolStripMenuItem, "newToolStripMenuItem");
            this.newToolStripMenuItem.Click += new System.EventHandler(this.newToolStripMenuItem_Click);
            // 
            // openNewPluginToolStripMenuItem
            // 
            this.openNewPluginToolStripMenuItem.Name = "openNewPluginToolStripMenuItem";
            resources.ApplyResources(this.openNewPluginToolStripMenuItem, "openNewPluginToolStripMenuItem");
            this.openNewPluginToolStripMenuItem.Click += new System.EventHandler(this.openNewPluginToolStripMenuItem_Click);
            // 
            // saveToolStripMenuItem
            // 
            this.saveToolStripMenuItem.Name = "saveToolStripMenuItem";
            resources.ApplyResources(this.saveToolStripMenuItem, "saveToolStripMenuItem");
            this.saveToolStripMenuItem.Click += new System.EventHandler(this.saveToolStripMenuItem_Click);
            // 
            // closeToolStripMenuItem
            // 
            this.closeToolStripMenuItem.Name = "closeToolStripMenuItem";
            resources.ApplyResources(this.closeToolStripMenuItem, "closeToolStripMenuItem");
            this.closeToolStripMenuItem.Click += new System.EventHandler(this.closeToolStripMenuItem_Click);
            // 
            // closeAllToolStripMenuItem
            // 
            this.closeAllToolStripMenuItem.Name = "closeAllToolStripMenuItem";
            resources.ApplyResources(this.closeAllToolStripMenuItem, "closeAllToolStripMenuItem");
            this.closeAllToolStripMenuItem.Click += new System.EventHandler(this.closeAllToolStripMenuItem_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            resources.ApplyResources(this.toolStripSeparator3, "toolStripSeparator3");
            // 
            // reloadXmlToolStripMenuItem
            // 
            this.reloadXmlToolStripMenuItem.Name = "reloadXmlToolStripMenuItem";
            resources.ApplyResources(this.reloadXmlToolStripMenuItem, "reloadXmlToolStripMenuItem");
            this.reloadXmlToolStripMenuItem.Click += new System.EventHandler(this.reloadXmlToolStripMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            resources.ApplyResources(this.toolStripMenuItem1, "toolStripMenuItem1");
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            resources.ApplyResources(this.exitToolStripMenuItem, "exitToolStripMenuItem");
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // editToolStripMenuItem
            // 
            this.editToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cutToolStripMenuItem,
            this.copyToolStripMenuItem,
            this.pasteToolStripMenuItem,
            this.pasteNewToolStripMenuItem,
            this.deleteToolStripMenuItem,
            this.insertGroupToolStripMenuItem,
            this.insertRecordToolStripMenuItem,
            this.insertSubrecordToolStripMenuItem,
            this.editSelectedToolStripMenuItem,
            this.editHeaderToolStripMenuItem,
            this.addMasterToolStripMenuItem,
            this.expandCollapseToolStripMenuItem,
            this.findInRecordsToolStripMenuItem,
            this.findToolStripMenuItem,
            this.searchToolStripMenuItem,
            this.searchAdvancedToolStripMenuItem});
            this.editToolStripMenuItem.Name = "editToolStripMenuItem";
            resources.ApplyResources(this.editToolStripMenuItem, "editToolStripMenuItem");
            this.editToolStripMenuItem.DropDownOpening += new System.EventHandler(this.editToolStripMenuItem_DropDownOpening);
            // 
            // cutToolStripMenuItem
            // 
            resources.ApplyResources(this.cutToolStripMenuItem, "cutToolStripMenuItem");
            this.cutToolStripMenuItem.Name = "cutToolStripMenuItem";
            this.cutToolStripMenuItem.Click += new System.EventHandler(this.cutToolStripMenuItem_Click);
            // 
            // copyToolStripMenuItem
            // 
            resources.ApplyResources(this.copyToolStripMenuItem, "copyToolStripMenuItem");
            this.copyToolStripMenuItem.Name = "copyToolStripMenuItem";
            this.copyToolStripMenuItem.Click += new System.EventHandler(this.copyToolStripMenuItem_Click);
            // 
            // pasteToolStripMenuItem
            // 
            resources.ApplyResources(this.pasteToolStripMenuItem, "pasteToolStripMenuItem");
            this.pasteToolStripMenuItem.Name = "pasteToolStripMenuItem";
            this.pasteToolStripMenuItem.Click += new System.EventHandler(this.pasteToolStripMenuItem_Click);
            // 
            // deleteToolStripMenuItem
            // 
            resources.ApplyResources(this.deleteToolStripMenuItem, "deleteToolStripMenuItem");
            this.deleteToolStripMenuItem.Name = "deleteToolStripMenuItem";
            this.deleteToolStripMenuItem.Click += new System.EventHandler(this.deleteToolStripMenuItem_Click);
            // 
            // insertGroupToolStripMenuItem
            // 
            resources.ApplyResources(this.insertGroupToolStripMenuItem, "insertGroupToolStripMenuItem");
            this.insertGroupToolStripMenuItem.Name = "insertGroupToolStripMenuItem";
            this.insertGroupToolStripMenuItem.Click += new System.EventHandler(this.insertGroupToolStripMenuItem3_Click);
            // 
            // insertRecordToolStripMenuItem
            // 
            resources.ApplyResources(this.insertRecordToolStripMenuItem, "insertRecordToolStripMenuItem");
            this.insertRecordToolStripMenuItem.Name = "insertRecordToolStripMenuItem";
            this.insertRecordToolStripMenuItem.Click += new System.EventHandler(this.insertRecordToolStripMenuItem_Click);
            // 
            // insertSubrecordToolStripMenuItem
            // 
            resources.ApplyResources(this.insertSubrecordToolStripMenuItem, "insertSubrecordToolStripMenuItem");
            this.insertSubrecordToolStripMenuItem.Name = "insertSubrecordToolStripMenuItem";
            this.insertSubrecordToolStripMenuItem.Click += new System.EventHandler(this.insertSubrecordToolStripMenuItem_Click);
            // 
            // editSelectedToolStripMenuItem
            // 
            this.editSelectedToolStripMenuItem.Name = "editSelectedToolStripMenuItem";
            resources.ApplyResources(this.editSelectedToolStripMenuItem, "editSelectedToolStripMenuItem");
            this.editSelectedToolStripMenuItem.Click += new System.EventHandler(this.editSelectedToolStripMenuItem_Click);
            // 
            // editHeaderToolStripMenuItem
            // 
            this.editHeaderToolStripMenuItem.Name = "editHeaderToolStripMenuItem";
            resources.ApplyResources(this.editHeaderToolStripMenuItem, "editHeaderToolStripMenuItem");
            this.editHeaderToolStripMenuItem.Click += new System.EventHandler(this.editHeaderToolStripMenuItem_Click);
            // 
            // addMasterToolStripMenuItem
            // 
            this.addMasterToolStripMenuItem.Name = "addMasterToolStripMenuItem";
            resources.ApplyResources(this.addMasterToolStripMenuItem, "addMasterToolStripMenuItem");
            this.addMasterToolStripMenuItem.Click += new System.EventHandler(this.addMasterToolStripMenuItem_Click);
            // 
            // expandCollapseToolStripMenuItem
            // 
            this.expandCollapseToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.expandAllToolStripMenuItem,
            this.collapseAllToolStripMenuItem,
            this.expandBranchToolStripMenuItem,
            this.collapseBranchToolStripMenuItem});
            this.expandCollapseToolStripMenuItem.Name = "expandCollapseToolStripMenuItem";
            resources.ApplyResources(this.expandCollapseToolStripMenuItem, "expandCollapseToolStripMenuItem");
            // 
            // expandAllToolStripMenuItem
            // 
            this.expandAllToolStripMenuItem.Name = "expandAllToolStripMenuItem";
            resources.ApplyResources(this.expandAllToolStripMenuItem, "expandAllToolStripMenuItem");
            this.expandAllToolStripMenuItem.Click += new System.EventHandler(this.expandAllToolStripMenuItem_Click);
            // 
            // collapseAllToolStripMenuItem
            // 
            this.collapseAllToolStripMenuItem.Name = "collapseAllToolStripMenuItem";
            resources.ApplyResources(this.collapseAllToolStripMenuItem, "collapseAllToolStripMenuItem");
            this.collapseAllToolStripMenuItem.Click += new System.EventHandler(this.collapseAllToolStripMenuItem_Click);
            // 
            // expandBranchToolStripMenuItem
            // 
            this.expandBranchToolStripMenuItem.Name = "expandBranchToolStripMenuItem";
            resources.ApplyResources(this.expandBranchToolStripMenuItem, "expandBranchToolStripMenuItem");
            this.expandBranchToolStripMenuItem.Click += new System.EventHandler(this.expandBranchToolStripMenuItem_Click);
            // 
            // collapseBranchToolStripMenuItem
            // 
            this.collapseBranchToolStripMenuItem.Name = "collapseBranchToolStripMenuItem";
            resources.ApplyResources(this.collapseBranchToolStripMenuItem, "collapseBranchToolStripMenuItem");
            this.collapseBranchToolStripMenuItem.Click += new System.EventHandler(this.collapseBranchToolStripMenuItem_Click);
            // 
            // findInRecordsToolStripMenuItem
            // 
            this.findInRecordsToolStripMenuItem.Name = "findInRecordsToolStripMenuItem";
            resources.ApplyResources(this.findInRecordsToolStripMenuItem, "findInRecordsToolStripMenuItem");
            this.findInRecordsToolStripMenuItem.Click += new System.EventHandler(this.findInRecordsToolStripMenuItem_Click);
            // 
            // findToolStripMenuItem
            // 
            this.findToolStripMenuItem.Name = "findToolStripMenuItem";
            resources.ApplyResources(this.findToolStripMenuItem, "findToolStripMenuItem");
            this.findToolStripMenuItem.Click += new System.EventHandler(this.findToolStripMenuItem_Click);
            // 
            // searchToolStripMenuItem
            // 
            this.searchToolStripMenuItem.Name = "searchToolStripMenuItem";
            resources.ApplyResources(this.searchToolStripMenuItem, "searchToolStripMenuItem");
            this.searchToolStripMenuItem.Click += new System.EventHandler(this.searchToolStripMenuItem_Click);
            // 
            // searchAdvancedToolStripMenuItem
            // 
            this.searchAdvancedToolStripMenuItem.Name = "searchAdvancedToolStripMenuItem";
            resources.ApplyResources(this.searchAdvancedToolStripMenuItem, "searchAdvancedToolStripMenuItem");
            this.searchAdvancedToolStripMenuItem.Click += new System.EventHandler(this.searchAdvancedToolStripMenuItem_Click);
            // 
            // optionsToolStripMenuItem
            // 
            this.optionsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.hexModeToolStripMenuItem,
            this.useNewSubrecordEditorToolStripMenuItem,
            this.lookupFormidsToolStripMenuItem,
            this.uTF8ModeToolStripMenuItem,
            this.useWindowsClipboardToolStripMenuItem,
            this.noWindowsSoundsToolStripMenuItem,
            this.disableHyperlinksToolStripMenuItem,
            this.resetDockingWindowsToolStripMenuItem,
            this.eSMFilterSettingsToolStripMenuItem,
            this.compressionSettingsToolStripMenuItem});
            this.optionsToolStripMenuItem.Name = "optionsToolStripMenuItem";
            resources.ApplyResources(this.optionsToolStripMenuItem, "optionsToolStripMenuItem");
            // 
            // hexModeToolStripMenuItem
            // 
            this.hexModeToolStripMenuItem.Checked = true;
            this.hexModeToolStripMenuItem.CheckOnClick = true;
            this.hexModeToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked;
            this.hexModeToolStripMenuItem.Name = "hexModeToolStripMenuItem";
            resources.ApplyResources(this.hexModeToolStripMenuItem, "hexModeToolStripMenuItem");
            this.hexModeToolStripMenuItem.Click += new System.EventHandler(this.hexModeToolStripMenuItem_Click);
            // 
            // useNewSubrecordEditorToolStripMenuItem
            // 
            this.useNewSubrecordEditorToolStripMenuItem.Checked = true;
            this.useNewSubrecordEditorToolStripMenuItem.CheckOnClick = true;
            this.useNewSubrecordEditorToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked;
            this.useNewSubrecordEditorToolStripMenuItem.Name = "useNewSubrecordEditorToolStripMenuItem";
            resources.ApplyResources(this.useNewSubrecordEditorToolStripMenuItem, "useNewSubrecordEditorToolStripMenuItem");
            this.useNewSubrecordEditorToolStripMenuItem.Click += new System.EventHandler(this.useNewSubrecordEditorToolStripMenuItem_Click);
            // 
            // lookupFormidsToolStripMenuItem
            // 
            this.lookupFormidsToolStripMenuItem.Checked = true;
            this.lookupFormidsToolStripMenuItem.CheckOnClick = true;
            this.lookupFormidsToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked;
            this.lookupFormidsToolStripMenuItem.Name = "lookupFormidsToolStripMenuItem";
            resources.ApplyResources(this.lookupFormidsToolStripMenuItem, "lookupFormidsToolStripMenuItem");
            this.lookupFormidsToolStripMenuItem.Click += new System.EventHandler(this.lookupFormidsToolStripMenuItem_Click);
            // 
            // uTF8ModeToolStripMenuItem
            // 
            this.uTF8ModeToolStripMenuItem.Checked = true;
            this.uTF8ModeToolStripMenuItem.CheckOnClick = true;
            this.uTF8ModeToolStripMenuItem.CheckState = System.Windows.Forms.CheckState.Checked;
            this.uTF8ModeToolStripMenuItem.Name = "uTF8ModeToolStripMenuItem";
            resources.ApplyResources(this.uTF8ModeToolStripMenuItem, "uTF8ModeToolStripMenuItem");
            this.uTF8ModeToolStripMenuItem.Click += new System.EventHandler(this.uTF8ModeToolStripMenuItem_Click);
            // 
            // useWindowsClipboardToolStripMenuItem
            // 
            this.useWindowsClipboardToolStripMenuItem.Name = "useWindowsClipboardToolStripMenuItem";
            resources.ApplyResources(this.useWindowsClipboardToolStripMenuItem, "useWindowsClipboardToolStripMenuItem");
            this.useWindowsClipboardToolStripMenuItem.Click += new System.EventHandler(this.useWindowsClipboardToolStripMenuItem_Click);
            // 
            // noWindowsSoundsToolStripMenuItem
            // 
            this.noWindowsSoundsToolStripMenuItem.Name = "noWindowsSoundsToolStripMenuItem";
            resources.ApplyResources(this.noWindowsSoundsToolStripMenuItem, "noWindowsSoundsToolStripMenuItem");
            this.noWindowsSoundsToolStripMenuItem.Click += new System.EventHandler(this.noWindowsSoundsToolStripMenuItem_Click);
            // 
            // disableHyperlinksToolStripMenuItem
            // 
            this.disableHyperlinksToolStripMenuItem.Name = "disableHyperlinksToolStripMenuItem";
            resources.ApplyResources(this.disableHyperlinksToolStripMenuItem, "disableHyperlinksToolStripMenuItem");
            this.disableHyperlinksToolStripMenuItem.Click += new System.EventHandler(this.disableHyperlinksToolStripMenuItem_Click);
            // 
            // resetDockingWindowsToolStripMenuItem
            // 
            this.resetDockingWindowsToolStripMenuItem.Name = "resetDockingWindowsToolStripMenuItem";
            resources.ApplyResources(this.resetDockingWindowsToolStripMenuItem, "resetDockingWindowsToolStripMenuItem");
            this.resetDockingWindowsToolStripMenuItem.Click += new System.EventHandler(this.resetDockingWindowsToolStripMenuItem_Click);
            // 
            // eSMFilterSettingsToolStripMenuItem
            // 
            this.eSMFilterSettingsToolStripMenuItem.Name = "eSMFilterSettingsToolStripMenuItem";
            resources.ApplyResources(this.eSMFilterSettingsToolStripMenuItem, "eSMFilterSettingsToolStripMenuItem");
            this.eSMFilterSettingsToolStripMenuItem.Click += new System.EventHandler(this.eSMFilterSettingsToolStripMenuItem_Click);
            // 
            // compressionSettingsToolStripMenuItem
            // 
            this.compressionSettingsToolStripMenuItem.Name = "compressionSettingsToolStripMenuItem";
            resources.ApplyResources(this.compressionSettingsToolStripMenuItem, "compressionSettingsToolStripMenuItem");
            this.compressionSettingsToolStripMenuItem.Click += new System.EventHandler(this.compressionSettingsToolStripMenuItem_Click);
            // 
            // toolsToolStripMenuItem
            // 
            this.toolsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.languageToolStripMenuItem,
            this.editStringsToolStripMenuItem,
            this.saveStringsFilesToolStripMenuItem,
            this.saveStringsToolStripMenuItem,
            this.stringLocalizerToolStripMenuItem,
            this.reloadStringsToolStripMenuItem,
            this.toolStripMenuItem2,
            this.internalizeStringReferencesToolStripMenuItem,
            this.extractInternalStringsToTableToolStripMenuItem,
            this.copyReferencedStringsFromMastersToolStripMenuItem,
            this.cleanUnusedStringsToolStripMenuItem,
            this.createStubsForMissingStringsToolStripMenuItem,
            this.exportStringsToFileToolStripMenuItem,
            this.importStringsToFileToolStripMenuItem});
            this.toolsToolStripMenuItem.Name = "toolsToolStripMenuItem";
            resources.ApplyResources(this.toolsToolStripMenuItem, "toolsToolStripMenuItem");
            this.toolsToolStripMenuItem.DropDownOpening += new System.EventHandler(this.toolsToolStripMenuItem_DropDownOpening);
            // 
            // languageToolStripMenuItem
            // 
            this.languageToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.englishToolStripMenuItem,
            this.czechToolStripMenuItem,
            this.frenchToolStripMenuItem,
            this.germanToolStripMenuItem,
            this.italianToolStripMenuItem,
            this.spanishToolStripMenuItem,
            this.russianToolStripMenuItem,
            this.polishToolStripMenuItem});
            this.languageToolStripMenuItem.Name = "languageToolStripMenuItem";
            resources.ApplyResources(this.languageToolStripMenuItem, "languageToolStripMenuItem");
            this.languageToolStripMenuItem.DropDownOpening += new System.EventHandler(this.languageToolStripMenuItem_DropDownOpening);
            this.languageToolStripMenuItem.DropDownItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.languageToolStripMenuItem_DropDownItemClicked);
            // 
            // englishToolStripMenuItem
            // 
            this.englishToolStripMenuItem.Name = "englishToolStripMenuItem";
            resources.ApplyResources(this.englishToolStripMenuItem, "englishToolStripMenuItem");
            // 
            // czechToolStripMenuItem
            // 
            this.czechToolStripMenuItem.Name = "czechToolStripMenuItem";
            resources.ApplyResources(this.czechToolStripMenuItem, "czechToolStripMenuItem");
            // 
            // frenchToolStripMenuItem
            // 
            this.frenchToolStripMenuItem.Name = "frenchToolStripMenuItem";
            resources.ApplyResources(this.frenchToolStripMenuItem, "frenchToolStripMenuItem");
            // 
            // germanToolStripMenuItem
            // 
            this.germanToolStripMenuItem.Name = "germanToolStripMenuItem";
            resources.ApplyResources(this.germanToolStripMenuItem, "germanToolStripMenuItem");
            // 
            // italianToolStripMenuItem
            // 
            this.italianToolStripMenuItem.Name = "italianToolStripMenuItem";
            resources.ApplyResources(this.italianToolStripMenuItem, "italianToolStripMenuItem");
            // 
            // spanishToolStripMenuItem
            // 
            this.spanishToolStripMenuItem.Name = "spanishToolStripMenuItem";
            resources.ApplyResources(this.spanishToolStripMenuItem, "spanishToolStripMenuItem");
            // 
            // russianToolStripMenuItem
            // 
            this.russianToolStripMenuItem.Name = "russianToolStripMenuItem";
            resources.ApplyResources(this.russianToolStripMenuItem, "russianToolStripMenuItem");
            // 
            // polishToolStripMenuItem
            // 
            this.polishToolStripMenuItem.Name = "polishToolStripMenuItem";
            resources.ApplyResources(this.polishToolStripMenuItem, "polishToolStripMenuItem");
            // 
            // editStringsToolStripMenuItem
            // 
            this.editStringsToolStripMenuItem.Name = "editStringsToolStripMenuItem";
            resources.ApplyResources(this.editStringsToolStripMenuItem, "editStringsToolStripMenuItem");
            this.editStringsToolStripMenuItem.Click += new System.EventHandler(this.editStringsToolStripMenuItem_Click);
            // 
            // saveStringsFilesToolStripMenuItem
            // 
            resources.ApplyResources(this.saveStringsFilesToolStripMenuItem, "saveStringsFilesToolStripMenuItem");
            this.saveStringsFilesToolStripMenuItem.Name = "saveStringsFilesToolStripMenuItem";
            this.saveStringsFilesToolStripMenuItem.Click += new System.EventHandler(this.saveStringsFilesToolStripMenuItem_Click);
            // 
            // saveStringsToolStripMenuItem
            // 
            resources.ApplyResources(this.saveStringsToolStripMenuItem, "saveStringsToolStripMenuItem");
            this.saveStringsToolStripMenuItem.Name = "saveStringsToolStripMenuItem";
            this.saveStringsToolStripMenuItem.Click += new System.EventHandler(this.saveStringsToolStripMenuItem_Click);
            // 
            // stringLocalizerToolStripMenuItem
            // 
            this.stringLocalizerToolStripMenuItem.Name = "stringLocalizerToolStripMenuItem";
            resources.ApplyResources(this.stringLocalizerToolStripMenuItem, "stringLocalizerToolStripMenuItem");
            this.stringLocalizerToolStripMenuItem.Click += new System.EventHandler(this.stringLocalizerToolStripMenuItem_Click);
            // 
            // reloadStringsToolStripMenuItem
            // 
            this.reloadStringsToolStripMenuItem.Name = "reloadStringsToolStripMenuItem";
            resources.ApplyResources(this.reloadStringsToolStripMenuItem, "reloadStringsToolStripMenuItem");
            this.reloadStringsToolStripMenuItem.Click += new System.EventHandler(this.reloadStringsToolStripMenuItem_Click);
            // 
            // toolStripMenuItem2
            // 
            this.toolStripMenuItem2.Name = "toolStripMenuItem2";
            resources.ApplyResources(this.toolStripMenuItem2, "toolStripMenuItem2");
            // 
            // internalizeStringReferencesToolStripMenuItem
            // 
            this.internalizeStringReferencesToolStripMenuItem.Name = "internalizeStringReferencesToolStripMenuItem";
            resources.ApplyResources(this.internalizeStringReferencesToolStripMenuItem, "internalizeStringReferencesToolStripMenuItem");
            this.internalizeStringReferencesToolStripMenuItem.Click += new System.EventHandler(this.internalizeStringReferencesToolStripMenuItem_Click);
            // 
            // extractInternalStringsToTableToolStripMenuItem
            // 
            this.extractInternalStringsToTableToolStripMenuItem.Name = "extractInternalStringsToTableToolStripMenuItem";
            resources.ApplyResources(this.extractInternalStringsToTableToolStripMenuItem, "extractInternalStringsToTableToolStripMenuItem");
            this.extractInternalStringsToTableToolStripMenuItem.Click += new System.EventHandler(this.extractInternalStringsToTableToolStripMenuItem_Click);
            // 
            // copyReferencedStringsFromMastersToolStripMenuItem
            // 
            this.copyReferencedStringsFromMastersToolStripMenuItem.Name = "copyReferencedStringsFromMastersToolStripMenuItem";
            resources.ApplyResources(this.copyReferencedStringsFromMastersToolStripMenuItem, "copyReferencedStringsFromMastersToolStripMenuItem");
            this.copyReferencedStringsFromMastersToolStripMenuItem.Click += new System.EventHandler(this.copyReferencedStringsFromMastersToolStripMenuItem_Click);
            // 
            // cleanUnusedStringsToolStripMenuItem
            // 
            this.cleanUnusedStringsToolStripMenuItem.Name = "cleanUnusedStringsToolStripMenuItem";
            resources.ApplyResources(this.cleanUnusedStringsToolStripMenuItem, "cleanUnusedStringsToolStripMenuItem");
            this.cleanUnusedStringsToolStripMenuItem.Click += new System.EventHandler(this.cleanUnusedStringsToolStripMenuItem_Click);
            // 
            // createStubsForMissingStringsToolStripMenuItem
            // 
            this.createStubsForMissingStringsToolStripMenuItem.Name = "createStubsForMissingStringsToolStripMenuItem";
            resources.ApplyResources(this.createStubsForMissingStringsToolStripMenuItem, "createStubsForMissingStringsToolStripMenuItem");
            this.createStubsForMissingStringsToolStripMenuItem.Click += new System.EventHandler(this.createStubsForMissingStringsToolStripMenuItem_Click);
            // 
            // exportStringsToFileToolStripMenuItem
            // 
            this.exportStringsToFileToolStripMenuItem.Name = "exportStringsToFileToolStripMenuItem";
            resources.ApplyResources(this.exportStringsToFileToolStripMenuItem, "exportStringsToFileToolStripMenuItem");
            this.exportStringsToFileToolStripMenuItem.Click += new System.EventHandler(this.exportStringsToFileToolStripMenuItem_Click);
            // 
            // importStringsToFileToolStripMenuItem
            // 
            this.importStringsToFileToolStripMenuItem.Name = "importStringsToFileToolStripMenuItem";
            resources.ApplyResources(this.importStringsToFileToolStripMenuItem, "importStringsToFileToolStripMenuItem");
            this.importStringsToFileToolStripMenuItem.Click += new System.EventHandler(this.importStringsToFileToolStripMenuItem_Click);
            // 
            // spellsToolStripMenuItem
            // 
            this.spellsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sanitizeToolStripMenuItem,
            this.stripEDIDsToolStripMenuItem,
            this.findDuplicatedFormIDToolStripMenuItem,
            this.dumpEDIDListToolStripMenuItem,
            this.cleanEspToolStripMenuItem,
            this.findNonconformingRecordToolStripMenuItem,
            this.compileScriptToolStripMenuItem,
            this.compileAllToolStripMenuItem,
            this.generateLLXmlToolStripMenuItem,
            this.makeEsmToolStripMenuItem,
            this.martigensToolStripMenuItem,
            this.createRecordStructureXmlToolStripMenuItem,
            this.mergeRecordsXMLToolStripMenuItem,
            this.reorderSubrecordsToolStripMenuItem,
            this.newFormIDToolStripMenuItem,
            this.newFormIDNoReferenceUpdateToolStripMenuItem});
            this.spellsToolStripMenuItem.Name = "spellsToolStripMenuItem";
            resources.ApplyResources(this.spellsToolStripMenuItem, "spellsToolStripMenuItem");
            // 
            // sanitizeToolStripMenuItem
            // 
            this.sanitizeToolStripMenuItem.AutoToolTip = true;
            this.sanitizeToolStripMenuItem.Name = "sanitizeToolStripMenuItem";
            resources.ApplyResources(this.sanitizeToolStripMenuItem, "sanitizeToolStripMenuItem");
            this.sanitizeToolStripMenuItem.Click += new System.EventHandler(this.sanitizeToolStripMenuItem_Click);
            // 
            // stripEDIDsToolStripMenuItem
            // 
            this.stripEDIDsToolStripMenuItem.Name = "stripEDIDsToolStripMenuItem";
            resources.ApplyResources(this.stripEDIDsToolStripMenuItem, "stripEDIDsToolStripMenuItem");
            this.stripEDIDsToolStripMenuItem.Click += new System.EventHandler(this.stripEDIDsToolStripMenuItem_Click);
            // 
            // findDuplicatedFormIDToolStripMenuItem
            // 
            this.findDuplicatedFormIDToolStripMenuItem.AutoToolTip = true;
            this.findDuplicatedFormIDToolStripMenuItem.Name = "findDuplicatedFormIDToolStripMenuItem";
            resources.ApplyResources(this.findDuplicatedFormIDToolStripMenuItem, "findDuplicatedFormIDToolStripMenuItem");
            this.findDuplicatedFormIDToolStripMenuItem.Click += new System.EventHandler(this.findDuplicatedFormIDToolStripMenuItem_Click);
            // 
            // dumpEDIDListToolStripMenuItem
            // 
            this.dumpEDIDListToolStripMenuItem.Name = "dumpEDIDListToolStripMenuItem";
            resources.ApplyResources(this.dumpEDIDListToolStripMenuItem, "dumpEDIDListToolStripMenuItem");
            this.dumpEDIDListToolStripMenuItem.Click += new System.EventHandler(this.dumpEDIDListToolStripMenuItem_Click);
            // 
            // cleanEspToolStripMenuItem
            // 
            this.cleanEspToolStripMenuItem.Name = "cleanEspToolStripMenuItem";
            resources.ApplyResources(this.cleanEspToolStripMenuItem, "cleanEspToolStripMenuItem");
            this.cleanEspToolStripMenuItem.Click += new System.EventHandler(this.cleanEspToolStripMenuItem_Click);
            // 
            // findNonconformingRecordToolStripMenuItem
            // 
            this.findNonconformingRecordToolStripMenuItem.Name = "findNonconformingRecordToolStripMenuItem";
            resources.ApplyResources(this.findNonconformingRecordToolStripMenuItem, "findNonconformingRecordToolStripMenuItem");
            this.findNonconformingRecordToolStripMenuItem.Click += new System.EventHandler(this.findNonconformingRecordToolStripMenuItem_Click);
            // 
            // compileScriptToolStripMenuItem
            // 
            resources.ApplyResources(this.compileScriptToolStripMenuItem, "compileScriptToolStripMenuItem");
            this.compileScriptToolStripMenuItem.Name = "compileScriptToolStripMenuItem";
            this.compileScriptToolStripMenuItem.Click += new System.EventHandler(this.compileScriptToolStripMenuItem_Click);
            // 
            // compileAllToolStripMenuItem
            // 
            resources.ApplyResources(this.compileAllToolStripMenuItem, "compileAllToolStripMenuItem");
            this.compileAllToolStripMenuItem.Name = "compileAllToolStripMenuItem";
            this.compileAllToolStripMenuItem.Click += new System.EventHandler(this.compileAllToolStripMenuItem_Click);
            // 
            // generateLLXmlToolStripMenuItem
            // 
            this.generateLLXmlToolStripMenuItem.Name = "generateLLXmlToolStripMenuItem";
            resources.ApplyResources(this.generateLLXmlToolStripMenuItem, "generateLLXmlToolStripMenuItem");
            this.generateLLXmlToolStripMenuItem.Click += new System.EventHandler(this.generateLLXmlToolStripMenuItem_Click);
            // 
            // makeEsmToolStripMenuItem
            // 
            this.makeEsmToolStripMenuItem.AutoToolTip = true;
            this.makeEsmToolStripMenuItem.Name = "makeEsmToolStripMenuItem";
            resources.ApplyResources(this.makeEsmToolStripMenuItem, "makeEsmToolStripMenuItem");
            this.makeEsmToolStripMenuItem.Click += new System.EventHandler(this.makeEsmToolStripMenuItem_Click);
            // 
            // martigensToolStripMenuItem
            // 
            this.martigensToolStripMenuItem.Name = "martigensToolStripMenuItem";
            resources.ApplyResources(this.martigensToolStripMenuItem, "martigensToolStripMenuItem");
            this.martigensToolStripMenuItem.Click += new System.EventHandler(this.martigensToolStripMenuItem_Click);
            // 
            // createRecordStructureXmlToolStripMenuItem
            // 
            this.createRecordStructureXmlToolStripMenuItem.Name = "createRecordStructureXmlToolStripMenuItem";
            resources.ApplyResources(this.createRecordStructureXmlToolStripMenuItem, "createRecordStructureXmlToolStripMenuItem");
            this.createRecordStructureXmlToolStripMenuItem.Click += new System.EventHandler(this.createRecordStructureXmlToolStripMenuItem_Click);
            // 
            // mergeRecordsXMLToolStripMenuItem
            // 
            this.mergeRecordsXMLToolStripMenuItem.Name = "mergeRecordsXMLToolStripMenuItem";
            resources.ApplyResources(this.mergeRecordsXMLToolStripMenuItem, "mergeRecordsXMLToolStripMenuItem");
            this.mergeRecordsXMLToolStripMenuItem.Click += new System.EventHandler(this.mergeRecordsXMLToolStripMenuItem_Click);
            // 
            // reorderSubrecordsToolStripMenuItem
            // 
            this.reorderSubrecordsToolStripMenuItem.Name = "reorderSubrecordsToolStripMenuItem";
            resources.ApplyResources(this.reorderSubrecordsToolStripMenuItem, "reorderSubrecordsToolStripMenuItem");
            this.reorderSubrecordsToolStripMenuItem.Click += new System.EventHandler(this.reorderSubrecordsToolStripMenuItem_Click);
            // 
            // newFormIDToolStripMenuItem
            // 
            this.newFormIDToolStripMenuItem.AutoToolTip = true;
            this.newFormIDToolStripMenuItem.Name = "newFormIDToolStripMenuItem";
            resources.ApplyResources(this.newFormIDToolStripMenuItem, "newFormIDToolStripMenuItem");
            this.newFormIDToolStripMenuItem.Click += new System.EventHandler(this.newFormIDToolStripMenuItem_Click);
            // 
            // newFormIDNoReferenceUpdateToolStripMenuItem
            // 
            this.newFormIDNoReferenceUpdateToolStripMenuItem.Name = "newFormIDNoReferenceUpdateToolStripMenuItem";
            resources.ApplyResources(this.newFormIDNoReferenceUpdateToolStripMenuItem, "newFormIDNoReferenceUpdateToolStripMenuItem");
            this.newFormIDNoReferenceUpdateToolStripMenuItem.Click += new System.EventHandler(this.newFormIDNoReferenceUpdateToolStripMenuItem_Click);
            // 
            // OpenModDialog
            // 
            resources.ApplyResources(this.OpenModDialog, "OpenModDialog");
            this.OpenModDialog.Multiselect = true;
            this.OpenModDialog.RestoreDirectory = true;
            // 
            // SaveModDialog
            // 
            this.SaveModDialog.DefaultExt = "esp";
            resources.ApplyResources(this.SaveModDialog, "SaveModDialog");
            this.SaveModDialog.RestoreDirectory = true;
            // 
            // SaveEdidListDialog
            // 
            this.SaveEdidListDialog.DefaultExt = "txt";
            resources.ApplyResources(this.SaveEdidListDialog, "SaveEdidListDialog");
            this.SaveEdidListDialog.RestoreDirectory = true;
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel,
            this.toolStripStatusProgressBar,
            this.toolStripStopProgress});
            resources.ApplyResources(this.statusStrip1, "statusStrip1");
            this.statusStrip1.Name = "statusStrip1";
            // 
            // toolStripStatusLabel
            // 
            this.toolStripStatusLabel.Name = "toolStripStatusLabel";
            resources.ApplyResources(this.toolStripStatusLabel, "toolStripStatusLabel");
            this.toolStripStatusLabel.Spring = true;
            // 
            // toolStripStatusProgressBar
            // 
            this.toolStripStatusProgressBar.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.toolStripStatusProgressBar.Name = "toolStripStatusProgressBar";
            resources.ApplyResources(this.toolStripStatusProgressBar, "toolStripStatusProgressBar");
            // 
            // toolStripStopProgress
            // 
            this.toolStripStopProgress.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.toolStripStopProgress.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripStopProgress.Image = global::TESVSnip.Properties.Resources.agt_stop;
            resources.ApplyResources(this.toolStripStopProgress, "toolStripStopProgress");
            this.toolStripStopProgress.Name = "toolStripStopProgress";
            this.toolStripStopProgress.Click += new System.EventHandler(this.toolStripStopProgress_Click);
            // 
            // backgroundWorker1
            // 
            this.backgroundWorker1.WorkerReportsProgress = true;
            this.backgroundWorker1.WorkerSupportsCancellation = true;
            this.backgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker1_DoWork);
            this.backgroundWorker1.ProgressChanged += new System.ComponentModel.ProgressChangedEventHandler(this.backgroundWorker1_ProgressChanged);
            this.backgroundWorker1.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.backgroundWorker1_RunWorkerCompleted);
            // 
            // columnHeader1
            // 
            resources.ApplyResources(this.columnHeader1, "columnHeader1");
            // 
            // columnHeader2
            // 
            resources.ApplyResources(this.columnHeader2, "columnHeader2");
            // 
            // toolStripIncrFind
            // 
            resources.ApplyResources(this.toolStripIncrFind, "toolStripIncrFind");
            this.toolStripIncrFind.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStripIncrFind.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripIncrFindCancel,
            this.toolStripIncrFindText,
            this.toolStripIncrFindTypeFilter,
            this.toolStripIncrFindNext,
            this.toolStripIncrFindPrev,
            this.toolStripIncrFindRestart,
            this.toolStripIncrFindType,
            this.toolStripIncrFindMatch,
            this.toolStripIncrFindExact,
            this.toolStripIncrFindWrapAround,
            this.toolStripSeparator7,
            this.toolStripIncrFindStatus});
            this.toolStripIncrFind.Name = "toolStripIncrFind";
            this.toolStripIncrFind.TabStop = true;
            this.toolStripIncrFind.VisibleChanged += new System.EventHandler(this.toolStripIncrFind_VisibleChanged);
            // 
            // toolStripIncrFindCancel
            // 
            this.toolStripIncrFindCancel.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripIncrFindCancel.Image = global::TESVSnip.Properties.Resources.delete;
            resources.ApplyResources(this.toolStripIncrFindCancel, "toolStripIncrFindCancel");
            this.toolStripIncrFindCancel.Name = "toolStripIncrFindCancel";
            this.toolStripIncrFindCancel.Click += new System.EventHandler(this.toolStripIncrFindCancel_Click);
            // 
            // toolStripIncrFindText
            // 
            this.toolStripIncrFindText.AcceptsReturn = true;
            this.toolStripIncrFindText.Name = "toolStripIncrFindText";
            this.toolStripIncrFindText.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripIncrFindText, "toolStripIncrFindText");
            this.toolStripIncrFindText.KeyDown += new System.Windows.Forms.KeyEventHandler(this.toolStripIncrFindText_KeyDown);
            this.toolStripIncrFindText.TextChanged += new System.EventHandler(this.toolStripIncrFindText_TextChanged);
            // 
            // toolStripIncrFindTypeFilter
            // 
            this.toolStripIncrFindTypeFilter.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.toolStripIncrFindTypeFilter.Items.AddRange(new object[] {
            resources.GetString("toolStripIncrFindTypeFilter.Items"),
            resources.GetString("toolStripIncrFindTypeFilter.Items1")});
            this.toolStripIncrFindTypeFilter.Name = "toolStripIncrFindTypeFilter";
            this.toolStripIncrFindTypeFilter.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripIncrFindTypeFilter, "toolStripIncrFindTypeFilter");
            this.toolStripIncrFindTypeFilter.SelectedIndexChanged += new System.EventHandler(this.toolStripIncrFindTypeFilter_SelectedIndexChanged);
            this.toolStripIncrFindTypeFilter.VisibleChanged += new System.EventHandler(this.toolStripIncrFindTypeFilter_VisibleChanged);
            // 
            // toolStripIncrFindNext
            // 
            this.toolStripIncrFindNext.Image = global::TESVSnip.Properties.Resources.down;
            resources.ApplyResources(this.toolStripIncrFindNext, "toolStripIncrFindNext");
            this.toolStripIncrFindNext.Name = "toolStripIncrFindNext";
            this.toolStripIncrFindNext.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            this.toolStripIncrFindNext.Click += new System.EventHandler(this.toolStripIncrFindNext_Click);
            // 
            // toolStripIncrFindPrev
            // 
            this.toolStripIncrFindPrev.Image = global::TESVSnip.Properties.Resources.up;
            resources.ApplyResources(this.toolStripIncrFindPrev, "toolStripIncrFindPrev");
            this.toolStripIncrFindPrev.Name = "toolStripIncrFindPrev";
            this.toolStripIncrFindPrev.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            this.toolStripIncrFindPrev.Click += new System.EventHandler(this.toolStripIncrFindPrev_Click);
            // 
            // toolStripIncrFindRestart
            // 
            this.toolStripIncrFindRestart.Image = global::TESVSnip.Properties.Resources.quick_restart;
            resources.ApplyResources(this.toolStripIncrFindRestart, "toolStripIncrFindRestart");
            this.toolStripIncrFindRestart.Name = "toolStripIncrFindRestart";
            this.toolStripIncrFindRestart.Click += new System.EventHandler(this.toolStripIncrFindRestart_Click);
            // 
            // toolStripIncrFindType
            // 
            this.toolStripIncrFindType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.toolStripIncrFindType.Items.AddRange(new object[] {
            resources.GetString("toolStripIncrFindType.Items"),
            resources.GetString("toolStripIncrFindType.Items1")});
            this.toolStripIncrFindType.Name = "toolStripIncrFindType";
            resources.ApplyResources(this.toolStripIncrFindType, "toolStripIncrFindType");
            this.toolStripIncrFindType.SelectedIndexChanged += new System.EventHandler(this.toolStripIncrFindType_SelectedIndexChanged);
            // 
            // toolStripIncrFindMatch
            // 
            this.toolStripIncrFindMatch.CheckOnClick = true;
            this.toolStripIncrFindMatch.Image = global::TESVSnip.Properties.Resources.emptybox;
            resources.ApplyResources(this.toolStripIncrFindMatch, "toolStripIncrFindMatch");
            this.toolStripIncrFindMatch.Name = "toolStripIncrFindMatch";
            this.toolStripIncrFindMatch.CheckStateChanged += new System.EventHandler(this.toolStripCheck_CheckStateChanged);
            // 
            // toolStripIncrFindExact
            // 
            this.toolStripIncrFindExact.CheckOnClick = true;
            this.toolStripIncrFindExact.Image = global::TESVSnip.Properties.Resources.emptybox;
            resources.ApplyResources(this.toolStripIncrFindExact, "toolStripIncrFindExact");
            this.toolStripIncrFindExact.Name = "toolStripIncrFindExact";
            this.toolStripIncrFindExact.CheckStateChanged += new System.EventHandler(this.toolStripCheck_CheckStateChanged);
            // 
            // toolStripIncrFindWrapAround
            // 
            this.toolStripIncrFindWrapAround.CheckOnClick = true;
            this.toolStripIncrFindWrapAround.Image = global::TESVSnip.Properties.Resources.emptybox;
            resources.ApplyResources(this.toolStripIncrFindWrapAround, "toolStripIncrFindWrapAround");
            this.toolStripIncrFindWrapAround.Name = "toolStripIncrFindWrapAround";
            this.toolStripIncrFindWrapAround.CheckStateChanged += new System.EventHandler(this.toolStripCheck_CheckStateChanged);
            // 
            // toolStripSeparator7
            // 
            this.toolStripSeparator7.Name = "toolStripSeparator7";
            this.toolStripSeparator7.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripSeparator7, "toolStripSeparator7");
            // 
            // toolStripIncrFindStatus
            // 
            this.toolStripIncrFindStatus.ForeColor = System.Drawing.Color.Maroon;
            this.toolStripIncrFindStatus.Name = "toolStripIncrFindStatus";
            this.toolStripIncrFindStatus.Overflow = System.Windows.Forms.ToolStripItemOverflow.Never;
            resources.ApplyResources(this.toolStripIncrFindStatus, "toolStripIncrFindStatus");
            // 
            // toolStripIncrInvalidRec
            // 
            resources.ApplyResources(this.toolStripIncrInvalidRec, "toolStripIncrInvalidRec");
            this.toolStripIncrInvalidRec.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStripIncrInvalidRec.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripIncrInvalidRecCancel,
            this.toolStripIncrInvalidRecText,
            this.toolStripSeparator6,
            this.toolStripIncrInvalidRecNext,
            this.toolStripIncrInvalidRecPrev,
            this.toolStripIncrInvalidRecRestart,
            this.toolStripSeparator4,
            this.toolStripIncrInvalidRecWrapAround,
            this.toolStripSeparator5,
            this.toolStripIncrInvalidRecStatus});
            this.toolStripIncrInvalidRec.Name = "toolStripIncrInvalidRec";
            this.toolStripIncrInvalidRec.TabStop = true;
            this.toolStripIncrInvalidRec.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.toolStripIncrInvalidRec_ItemClicked);
            this.toolStripIncrInvalidRec.VisibleChanged += new System.EventHandler(this.toolStripIncrInvalidRec_VisibleChanged);
            // 
            // toolStripIncrInvalidRecCancel
            // 
            this.toolStripIncrInvalidRecCancel.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripIncrInvalidRecCancel.Image = global::TESVSnip.Properties.Resources.delete;
            resources.ApplyResources(this.toolStripIncrInvalidRecCancel, "toolStripIncrInvalidRecCancel");
            this.toolStripIncrInvalidRecCancel.Name = "toolStripIncrInvalidRecCancel";
            this.toolStripIncrInvalidRecCancel.Click += new System.EventHandler(this.toolStripIncrInvalidRecCancel_Click);
            // 
            // toolStripIncrInvalidRecText
            // 
            this.toolStripIncrInvalidRecText.Name = "toolStripIncrInvalidRecText";
            resources.ApplyResources(this.toolStripIncrInvalidRecText, "toolStripIncrInvalidRecText");
            // 
            // toolStripSeparator6
            // 
            this.toolStripSeparator6.Name = "toolStripSeparator6";
            resources.ApplyResources(this.toolStripSeparator6, "toolStripSeparator6");
            // 
            // toolStripIncrInvalidRecNext
            // 
            this.toolStripIncrInvalidRecNext.Image = global::TESVSnip.Properties.Resources.down;
            resources.ApplyResources(this.toolStripIncrInvalidRecNext, "toolStripIncrInvalidRecNext");
            this.toolStripIncrInvalidRecNext.Name = "toolStripIncrInvalidRecNext";
            this.toolStripIncrInvalidRecNext.Click += new System.EventHandler(this.toolStripIncrInvalidRecNext_Click);
            // 
            // toolStripIncrInvalidRecPrev
            // 
            this.toolStripIncrInvalidRecPrev.Image = global::TESVSnip.Properties.Resources.up;
            resources.ApplyResources(this.toolStripIncrInvalidRecPrev, "toolStripIncrInvalidRecPrev");
            this.toolStripIncrInvalidRecPrev.Name = "toolStripIncrInvalidRecPrev";
            this.toolStripIncrInvalidRecPrev.Click += new System.EventHandler(this.toolStripIncrInvalidRecPrev_Click);
            // 
            // toolStripIncrInvalidRecRestart
            // 
            this.toolStripIncrInvalidRecRestart.Image = global::TESVSnip.Properties.Resources.quick_restart;
            resources.ApplyResources(this.toolStripIncrInvalidRecRestart, "toolStripIncrInvalidRecRestart");
            this.toolStripIncrInvalidRecRestart.Name = "toolStripIncrInvalidRecRestart";
            this.toolStripIncrInvalidRecRestart.Click += new System.EventHandler(this.toolStripIncrInvalidRecRestart_Click);
            // 
            // toolStripSeparator4
            // 
            this.toolStripSeparator4.Name = "toolStripSeparator4";
            resources.ApplyResources(this.toolStripSeparator4, "toolStripSeparator4");
            // 
            // toolStripIncrInvalidRecWrapAround
            // 
            this.toolStripIncrInvalidRecWrapAround.CheckOnClick = true;
            this.toolStripIncrInvalidRecWrapAround.Image = global::TESVSnip.Properties.Resources.emptybox;
            resources.ApplyResources(this.toolStripIncrInvalidRecWrapAround, "toolStripIncrInvalidRecWrapAround");
            this.toolStripIncrInvalidRecWrapAround.Name = "toolStripIncrInvalidRecWrapAround";
            this.toolStripIncrInvalidRecWrapAround.CheckStateChanged += new System.EventHandler(this.toolStripCheck_CheckStateChanged);
            // 
            // toolStripSeparator5
            // 
            this.toolStripSeparator5.Name = "toolStripSeparator5";
            resources.ApplyResources(this.toolStripSeparator5, "toolStripSeparator5");
            // 
            // toolStripIncrInvalidRecStatus
            // 
            this.toolStripIncrInvalidRecStatus.ForeColor = System.Drawing.Color.DarkRed;
            this.toolStripIncrInvalidRecStatus.Name = "toolStripIncrInvalidRecStatus";
            resources.ApplyResources(this.toolStripIncrInvalidRecStatus, "toolStripIncrInvalidRecStatus");
            // 
            // dockPanel
            // 
            this.dockPanel.ActiveAutoHideContent = null;
            resources.ApplyResources(this.dockPanel, "dockPanel");
            this.dockPanel.DockBackColor = System.Drawing.SystemColors.AppWorkspace;
            this.dockPanel.DockBottomPortion = 150D;
            this.dockPanel.DockLeftPortion = 200D;
            this.dockPanel.DockRightPortion = 200D;
            this.dockPanel.DockTopPortion = 150D;
            this.dockPanel.Name = "dockPanel";
            this.dockPanel.RightToLeftLayout = true;
            dockPanelGradient1.EndColor = System.Drawing.SystemColors.ControlLight;
            dockPanelGradient1.StartColor = System.Drawing.SystemColors.ControlLight;
            autoHideStripSkin1.DockStripGradient = dockPanelGradient1;
            tabGradient1.EndColor = System.Drawing.SystemColors.Control;
            tabGradient1.StartColor = System.Drawing.SystemColors.Control;
            tabGradient1.TextColor = System.Drawing.SystemColors.ControlDarkDark;
            autoHideStripSkin1.TabGradient = tabGradient1;
            autoHideStripSkin1.TextFont = new System.Drawing.Font("Segoe UI", 9F);
            dockPanelSkin1.AutoHideStripSkin = autoHideStripSkin1;
            tabGradient2.EndColor = System.Drawing.SystemColors.ControlLightLight;
            tabGradient2.StartColor = System.Drawing.SystemColors.ControlLightLight;
            tabGradient2.TextColor = System.Drawing.SystemColors.ControlText;
            dockPaneStripGradient1.ActiveTabGradient = tabGradient2;
            dockPanelGradient2.EndColor = System.Drawing.SystemColors.Control;
            dockPanelGradient2.StartColor = System.Drawing.SystemColors.Control;
            dockPaneStripGradient1.DockStripGradient = dockPanelGradient2;
            tabGradient3.EndColor = System.Drawing.SystemColors.ControlLight;
            tabGradient3.StartColor = System.Drawing.SystemColors.ControlLight;
            tabGradient3.TextColor = System.Drawing.SystemColors.ControlText;
            dockPaneStripGradient1.InactiveTabGradient = tabGradient3;
            dockPaneStripSkin1.DocumentGradient = dockPaneStripGradient1;
            dockPaneStripSkin1.TextFont = new System.Drawing.Font("Segoe UI", 9F);
            tabGradient4.EndColor = System.Drawing.SystemColors.ActiveCaption;
            tabGradient4.LinearGradientMode = System.Drawing.Drawing2D.LinearGradientMode.Vertical;
            tabGradient4.StartColor = System.Drawing.SystemColors.GradientActiveCaption;
            tabGradient4.TextColor = System.Drawing.SystemColors.ActiveCaptionText;
            dockPaneStripToolWindowGradient1.ActiveCaptionGradient = tabGradient4;
            tabGradient5.EndColor = System.Drawing.SystemColors.Control;
            tabGradient5.StartColor = System.Drawing.SystemColors.Control;
            tabGradient5.TextColor = System.Drawing.SystemColors.ControlText;
            dockPaneStripToolWindowGradient1.ActiveTabGradient = tabGradient5;
            dockPanelGradient3.EndColor = System.Drawing.SystemColors.ControlLight;
            dockPanelGradient3.StartColor = System.Drawing.SystemColors.ControlLight;
            dockPaneStripToolWindowGradient1.DockStripGradient = dockPanelGradient3;
            tabGradient6.EndColor = System.Drawing.SystemColors.GradientInactiveCaption;
            tabGradient6.LinearGradientMode = System.Drawing.Drawing2D.LinearGradientMode.Vertical;
            tabGradient6.StartColor = System.Drawing.SystemColors.GradientInactiveCaption;
            tabGradient6.TextColor = System.Drawing.SystemColors.ControlText;
            dockPaneStripToolWindowGradient1.InactiveCaptionGradient = tabGradient6;
            tabGradient7.EndColor = System.Drawing.Color.Transparent;
            tabGradient7.StartColor = System.Drawing.Color.Transparent;
            tabGradient7.TextColor = System.Drawing.SystemColors.ControlDarkDark;
            dockPaneStripToolWindowGradient1.InactiveTabGradient = tabGradient7;
            dockPaneStripSkin1.ToolWindowGradient = dockPaneStripToolWindowGradient1;
            dockPanelSkin1.DockPaneStripSkin = dockPaneStripSkin1;
            this.dockPanel.Skin = dockPanelSkin1;
            // 
            // pasteNewToolStripMenuItem
            // 
            resources.ApplyResources(this.pasteNewToolStripMenuItem, "pasteNewToolStripMenuItem");
            this.pasteNewToolStripMenuItem.Name = "pasteNewToolStripMenuItem";
            this.pasteNewToolStripMenuItem.Click += new System.EventHandler(this.pasteNewToolStripMenuItem_Click);
            // 
            // MainView
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            resources.ApplyResources(this, "$this");
            this.Controls.Add(this.dockPanel);
            this.Controls.Add(this.toolStripIncrFind);
            this.Controls.Add(this.toolStripIncrInvalidRec);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.menuStrip1);
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "MainView";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.TESsnip_FormClosing);
            this.Load += new System.EventHandler(this.MainView_Load);
            this.Shown += new System.EventHandler(this.MainView_Shown);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.toolStripIncrFind.ResumeLayout(false);
            this.toolStripIncrFind.PerformLayout();
            this.toolStripIncrInvalidRec.ResumeLayout(false);
            this.toolStripIncrInvalidRec.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }


        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem openNewPluginToolStripMenuItem;
        private System.Windows.Forms.OpenFileDialog OpenModDialog;
        private System.Windows.Forms.ToolStripMenuItem closeAllToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem optionsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem hexModeToolStripMenuItem;
        private System.Windows.Forms.SaveFileDialog SaveModDialog;
        private System.Windows.Forms.ToolStripMenuItem saveToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem copyToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pasteToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem deleteToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newToolStripMenuItem;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ToolStripMenuItem insertRecordToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem insertSubrecordToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem findToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem closeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem spellsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sanitizeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stripEDIDsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem findDuplicatedFormIDToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem useNewSubrecordEditorToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dumpEDIDListToolStripMenuItem;
        private System.Windows.Forms.SaveFileDialog SaveEdidListDialog;
        private System.Windows.Forms.ToolStripMenuItem reloadXmlToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem lookupFormidsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cleanEspToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem findNonconformingRecordToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem compileScriptToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem compileAllToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem generateLLXmlToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem makeEsmToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem martigensToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem reorderSubrecordsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem createRecordStructureXmlToolStripMenuItem;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel;
        private System.Windows.Forms.ToolStripProgressBar toolStripStatusProgressBar;
        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private System.Windows.Forms.ToolStripMenuItem mergeRecordsXMLToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem eSMFilterSettingsToolStripMenuItem;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStopProgress;
        private System.Windows.Forms.ToolStrip toolStripIncrFind;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindCancel;
        private System.Windows.Forms.ToolStripTextBox toolStripIncrFindText;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindNext;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindPrev;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindMatch;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindExact;
        private System.Windows.Forms.ToolStripComboBox toolStripIncrFindType;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindRestart;
        private System.Windows.Forms.ToolStrip toolStripIncrInvalidRec;
        private System.Windows.Forms.ToolStripButton toolStripIncrInvalidRecCancel;
        private System.Windows.Forms.ToolStripLabel toolStripIncrInvalidRecText;
        private System.Windows.Forms.ToolStripButton toolStripIncrInvalidRecNext;
        private System.Windows.Forms.ToolStripButton toolStripIncrInvalidRecPrev;
        private System.Windows.Forms.ToolStripButton toolStripIncrInvalidRecRestart;
        private System.Windows.Forms.ToolStripButton toolStripIncrInvalidRecWrapAround;
        private System.Windows.Forms.ToolStripButton toolStripIncrFindWrapAround;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.ToolStripLabel toolStripIncrInvalidRecStatus;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator6;
        private System.Windows.Forms.ToolStripMenuItem useWindowsClipboardToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator7;
        private System.Windows.Forms.ToolStripLabel toolStripIncrFindStatus;
        private System.Windows.Forms.ToolStripComboBox toolStripIncrFindTypeFilter;
        private System.Windows.Forms.ToolStripMenuItem noWindowsSoundsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem disableHyperlinksToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem toolsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem languageToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem englishToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem czechToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem frenchToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem germanToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem italianToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem spanishToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem russianToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editStringsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stringLocalizerToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem reloadStringsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem saveStringsFilesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem expandCollapseToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem expandAllToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem collapseAllToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem expandBranchToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem collapseBranchToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem addMasterToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem resetDockingWindowsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem compressionSettingsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem polishToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editSelectedToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editHeaderToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem findInRecordsToolStripMenuItem;
        private WeifenLuo.WinFormsUI.Docking.DockPanel dockPanel;
        private System.Windows.Forms.ToolStripMenuItem searchToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem searchAdvancedToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem extractInternalStringsToTableToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem copyReferencedStringsFromMastersToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cleanUnusedStringsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem createStubsForMissingStringsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem saveStringsToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem2;
        private System.Windows.Forms.ToolStripMenuItem exportStringsToFileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem importStringsToFileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem internalizeStringReferencesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem insertGroupToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newFormIDToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem uTF8ModeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newFormIDNoReferenceUpdateToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pasteNewToolStripMenuItem;
    }
}