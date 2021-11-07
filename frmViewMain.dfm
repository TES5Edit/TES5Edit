object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'TES5View'
  ClientHeight = 663
  ClientWidth = 1370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Padding.Left = 3
  Padding.Top = 3
  Padding.Right = 3
  Padding.Bottom = 3
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClient: TPanel
    Left = 3
    Top = 3
    Width = 1364
    Height = 657
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object splElements: TSplitter
      Left = 455
      Top = 30
      Height = 603
      AutoSnap = False
      MinSize = 250
      ResizeStyle = rsUpdate
    end
    object stbMain: TStatusBar
      AlignWithMargins = True
      Left = 0
      Top = 636
      Width = 1364
      Height = 21
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Panels = <
        item
          Width = 50
        end>
      ParentFont = True
      UseSystemFont = False
    end
    object pnlRight: TPanel
      Left = 458
      Top = 30
      Width = 906
      Height = 603
      Align = alClient
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 1
      object pgMain: TPageControl
        Left = 0
        Top = 0
        Width = 902
        Height = 599
        ActivePage = tbsView
        Align = alClient
        RaggedRight = True
        TabOrder = 0
        TabPosition = tpBottom
        OnChange = pgMainChange
        object tbsView: TTabSheet
          Caption = 'View'
          OnShow = tbsViewShow
          object vstView: TVirtualEditTree
            AlignWithMargins = True
            Left = 0
            Top = 25
            Width = 894
            Height = 545
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Align = alClient
            BevelInner = bvNone
            BevelKind = bkSoft
            BorderStyle = bsNone
            ClipboardFormats.Strings = (
              'Plain text'
              'Virtual Tree Data')
            DefaultText = 'Node'
            DragOperations = [doCopy]
            Header.AutoSizeIndex = 1
            Header.Height = 21
            Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoOwnerDraw, hoVisible]
            Header.PopupMenu = pmuViewHeader
            HintMode = hmTooltip
            HotCursor = crHandPoint
            LineStyle = lsCustomStyle
            NodeDataSize = 8
            ParentShowHint = False
            PopupMenu = pmuView
            SelectionBlendFactor = 48
            SelectionCurveRadius = 3
            ShowHint = True
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toWheelPanning, toFullRowDrag, toEditOnClick]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect, toSimpleDrawSelection]
            TreeOptions.StringOptions = [toAutoAcceptEditChange]
            OnAdvancedHeaderDraw = vstViewAdvancedHeaderDraw
            OnBeforeCellPaint = vstViewBeforeCellPaint
            OnBeforeItemErase = vstViewBeforeItemErase
            OnClick = vstViewClick
            OnCollapsed = vstViewCollapsed
            OnCollapsing = vstViewCollapsing
            OnCreateEditor = vstViewCreateEditor
            OnDblClick = vstViewDblClick
            OnDragAllowed = vstViewDragAllowed
            OnDragOver = vstViewDragOver
            OnDragDrop = vstViewDragDrop
            OnEditing = vstViewEditing
            OnExpanded = vstViewExpanded
            OnFocusChanged = vstViewFocusChanged
            OnFocusChanging = vstViewFocusChanging
            OnFreeNode = vstViewFreeNode
            OnGetText = vstViewGetText
            OnPaintText = vstViewPaintText
            OnHeaderClick = vstViewHeaderClick
            OnHeaderDrawQueryElements = vstViewHeaderDrawQueryElements
            OnHeaderMouseDown = vstViewHeaderMouseDown
            OnHeaderMouseMove = vstViewHeaderMouseMove
            OnInitChildren = vstViewInitChildren
            OnInitNode = vstViewInitNode
            OnKeyDown = vstViewKeyDown
            OnKeyPress = vstViewKeyPress
            OnNewText = vstViewNewText
            OnResize = vstViewResize
            OnScroll = vstViewScroll
            Columns = <
              item
                Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coFixed]
                Position = 0
                Text = 'Labels'
                Width = 250
              end
              item
                Position = 1
                Text = 'Values'
                Width = 233
              end>
          end
          object pnlViewTop: TPanel
            Left = 0
            Top = 0
            Width = 894
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object fpnlViewFilter: TFlowPanel
              Left = 0
              Top = 0
              Width = 828
              Height = 25
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnResize = fpnlViewFilterResize
              object lblViewFilterName: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 7
                Width = 73
                Height = 13
                Margins.Top = 7
                Caption = 'Filter by &Name:'
                FocusControl = edViewFilterName
              end
              object edViewFilterName: TEdit
                AlignWithMargins = True
                Left = 82
                Top = 3
                Width = 121
                Height = 21
                TabOrder = 0
                OnChange = edViewFilterChange
                OnKeyDown = edViewFilterNameKeyDown
                OnKeyPress = edFilterNoBeepOnEnterKeyPress
              end
              object cobViewFilter: TComboBox
                AlignWithMargins = True
                Left = 209
                Top = 3
                Width = 53
                Height = 21
                AutoDropDown = True
                AutoCloseUp = True
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 1
                Text = 'and'
                OnChange = edViewFilterChange
                OnKeyDown = edViewFilterNameKeyDown
                Items.Strings = (
                  'and'
                  'or')
              end
              object lblViewFilterValue: TLabel
                AlignWithMargins = True
                Left = 268
                Top = 7
                Width = 45
                Height = 13
                Margins.Top = 7
                Caption = 'by &Value:'
                FocusControl = edViewFilterValue
              end
              object edViewFilterValue: TEdit
                AlignWithMargins = True
                Left = 319
                Top = 3
                Width = 121
                Height = 21
                TabOrder = 2
                OnChange = edViewFilterChange
                OnKeyDown = edViewFilterNameKeyDown
                OnKeyPress = edFilterNoBeepOnEnterKeyPress
              end
              object fpnlViewFilterKeep: TFlowPanel
                AlignWithMargins = True
                Left = 446
                Top = 0
                Width = 259
                Height = 27
                Margins.Top = 0
                Margins.Bottom = 0
                BevelOuter = bvNone
                TabOrder = 3
                object lblViewFilterKeep: TLabel
                  AlignWithMargins = True
                  Left = 3
                  Top = 7
                  Width = 24
                  Height = 13
                  Margins.Top = 7
                  Caption = 'Keep'
                end
                object cbViewFilterKeepChildren: TCheckBox
                  AlignWithMargins = True
                  Left = 33
                  Top = 3
                  Width = 54
                  Height = 21
                  Caption = '&children'
                  TabOrder = 0
                  OnClick = edViewFilterChange
                end
                object cbViewFilterKeepSiblings: TCheckBox
                  AlignWithMargins = True
                  Left = 93
                  Top = 3
                  Width = 54
                  Height = 21
                  Caption = '&siblings'
                  TabOrder = 1
                  OnClick = edViewFilterChange
                end
                object cbViewFilterKeepParentsSiblings: TCheckBox
                  AlignWithMargins = True
                  Left = 153
                  Top = 3
                  Width = 96
                  Height = 21
                  Caption = '&parent'#39's siblings'
                  TabOrder = 2
                  OnClick = edViewFilterChange
                end
              end
            end
            object pnlViewTopLegend: TPanel
              Left = 828
              Top = 0
              Width = 66
              Height = 25
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
              object bnLegend: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 60
                Height = 21
                Align = alTop
                AllowAllUp = True
                GroupIndex = 1
                Caption = 'Legend'
                Flat = True
                OnClick = bnLegendClick
              end
            end
          end
        end
        object tbsReferencedBy: TTabSheet
          Caption = 'Referenced By'
          ImageIndex = 3
          TabVisible = False
          OnShow = tbsViewShow
          object lvReferencedBy: TListView
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 894
            Height = 570
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Align = alClient
            BevelInner = bvNone
            BevelKind = bkSoft
            BorderStyle = bsNone
            Columns = <
              item
                AutoSize = True
                Caption = 'Record'
              end
              item
                Caption = 'Signature'
                Width = 70
              end
              item
                AutoSize = True
                Caption = 'File'
              end>
            GridLines = True
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            PopupMenu = pmuRefBy
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lvReferencedByColumnClick
            OnCompare = lvReferencedByCompare
            OnDblClick = lvReferencedByDblClick
          end
        end
        object tbsMessages: TTabSheet
          Caption = 'Messages'
          ImageIndex = 1
          OnShow = tbsMessagesShow
          object mmoMessages: TMemo
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 894
            Height = 570
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Align = alClient
            HideSelection = False
            PopupMenu = pmuMessages
            ScrollBars = ssBoth
            TabOrder = 0
            WordWrap = False
            OnDblClick = mmoMessagesDblClick
          end
        end
        object tbsInfo: TTabSheet
          Caption = 'Information'
          ImageIndex = 2
          object Memo1: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 888
            Height = 567
            Align = alClient
            BorderStyle = bsNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            Lines.Strings = (
              'xEdit is an advanced graphical esp editor and conflict detector.'
              ''
              'Discord: https://discord.gg/5t8RnNQ'
              
                'Forum: https://afkmods.iguanadons.net/index.php?/topic/3750-wipz' +
                '-tes5edit/'
              ''
              
                'The navigation treeview on the left side shows all active master' +
                's and plugins in their correct load order. By navigating that tr' +
                'eeview you can look at every single record in any of your master' +
                's or plugins. Once a record has been selected the detailed conte' +
                'nts of that record is shown on the right side.'
              ''
              
                'The view treeview shows all versions of the selected record from' +
                ' all plugins which contain it. The left most column is the maste' +
                'r. The right most column is the plugin that "wins". This is the ' +
                'version of the record that the game sees.'
              ''
              
                'The navigation and view treeview use the same color coding to si' +
                'gnal the conflict state of individual fields (in the view treevi' +
                'ew) and the record overall (in the navigation treeview).'
              ''
              
                'Previously colors were listed by background and text color. Inst' +
                'ead, click the Legend button in the upper right corner. The Lege' +
                'nd window will summarizes the meaning of the colors.'
              ''
              
                'Conflict detection is not simply based on the existence of multi' +
                'ple records for the same FormID in different plugins but instead' +
                ' performs a comparison of the parsed subrecord data.'
              ''
              
                'The navigation treeview has a context menu where you can activat' +
                'e filtering. Filtering is based on the same conflict categorizat' +
                'ion as the background and text color.'
              ''
              'Command Line Switches:'
              ''
              
                '-cp:<codepage> or -cp-trans:<codepage> [sets codepage for transl' +
                'atable strings to codepage number or utf8]'
              
                '-l:<language> [Sets language, affects used codepage and .strings' +
                ' files]'
              '-edit [Enable Edit Mode]'
              '-view [Enable View Mode]'
              '-saves [Enable Saves Mode / View Mode Only]'
              
                '-IgnoreESL [Will load all modules as full modules, even if ESL f' +
                'lagged]'
              
                '-PseudoESL [xEdit will check if the module falls within ESL cons' +
                'traints (not containing new records with ObjectIDs > $FFF) and l' +
                'oad the file like an ESL (mapped into the FE xxx namespace) if p' +
                'ossible]'
              '-DontCache [Completely disables ref caching]'
              
                '-DontCacheLoad [Don'#39't load cache files if present, but save if p' +
                'ossible]'
              '-DontCacheSave [Don'#39't save cache files after building refs]'
              
                '-AllowDirectSaves:<filename list> [File may be an .esm, .esl, or' +
                ' .esp. Without a list of files, this will load non-official (off' +
                'icial = game master, official dlcs, CCs) modules without using m' +
                'emory mapped files. Optionally you can specify a list of files. ' +
                'Which will only load the listed modules without using memory map' +
                'ped files. This optional list may include official modules.]'
              
                '-<gamemode> [Specifies which game mode to use. <gamemode> can be' +
                ' any of the following: '#39'tes5vr'#39', '#39'fo4vr'#39', '#39'tes4'#39', '#39'tes5'#39', '#39'ender' +
                'al'#39', '#39'sse'#39', '#39'fo3'#39', '#39'fnv'#39', '#39'fo4'#39', '#39'fo76'#39']'
              
                '-moprofile:<profilename> Opens the plugin selection from the MO ' +
                'profile named in the switch.'
              '-setesm [Set ESM flag. Plugin selection screen will appear.]'
              
                '-clearesm [Remove ESM flag. Plugin selection screen will appear.' +
                ']'
              
                '-VeryQuickShowConflicts [loads all modules according to plugins.' +
                'txt without showing module selection, except if CTRL is pressed ' +
                'on start]'
              '-quickclean [cleans and prompts to save the file]'
              '-quickautoclean [Cleans 3 times and saves in between each step]'
              '-C:<path> [path to use for cache files]'
              '-S:<path> [Path to look for scripts]'
              '-T:<path> [Temporary Directory]'
              '-D:<path> [Specify a Data Directory]'
              '-O:<path> [Specify path for generated LOD files]'
              '-I:<path> [Game INI Files]'
              '-G:<path> [Save Game Path]'
              '-P:<path><filename> [Custom Plugins.txt file]'
              '-B:<path> [Backups path i.e. Edit Backups\]'
              '-R:<path><filename> [Custom xEdit Log Filename]'
              'All path parameters must be specified with trailing backslash.'
              ''
              'Keyboard Shortcuts:'
              ''
              
                '- Holding Shift+Ctrl+Alt while starting shows a dialog asking if' +
                ' the setting file should be deleted.'
              '- Holding Shift while starting to reset window position'
              ''
              'Module Selection Treeview:'
              ''
              
                '- Hold SHIFT to skip building/loading references for all plugins' +
                '.'
              
                '- [UP/DOWN] arrow to navigate plugin list. If multiple plugins a' +
                're selected, this will deselect them.'
              '- [Space] to check or uncheck selected plugins.'
              ''
              'Main Treeview:'
              ''
              '- Ctrl + S Create temporary save.'
              '- Ctrl + F3 to open Assets Browser'
              '- Alt + F3 to open Worldspace Browser'
              ''
              'Navagation treeview:'
              ''
              '- Ctrl + 1 through 5 to set a Bookmark.'
              '- ALT + 1 through 5 to jump to a Bookmark.'
              '- F2 to change FormID of a record'
              
                '- Ctrl or Shift while clicking to select several records/plugins' +
                ' at once'
              '- Del To delete a record or a group of records'
              
                '- Alt + Click to fully expand a tree. This can take a lot of tim' +
                'e when expanding large trees.'
              '- [Right Arrow] or + to expand current node'
              '- [Left Arrow] or - to collapse current node'
              '- * Expand treview (recursive)'
              '- / Collapse treeview (recursive)'
              ''
              'View treeview:'
              ''
              '- Ctrl + UP/DOWN to move elements in unordered lists.'
              '- F2 to activate inplace editor'
              '- CTRL + Click on FormID to switch focus to that record'
              '- [Double Click] on text field to open multiline viewer'
              
                '- [Double Click] on [Integer, Float, or FormID] to open In-Place' +
                ' Editor'
              '- Shift + [Double Click] on text field to open multiline editor'
              '- Ctrl + C to copy to clipboard'
              
                '- Ctrl + W from a weather record to open the visual weather edit' +
                'or'
              
                '- Alt + CRSR while in view treeview to navigate within the Navag' +
                'ation treeview'
              ''
              'Messages tab:'
              ''
              '- CTRL + [Double Click] on FormID to switch focus to that record'
              ''
              'Modgroup Editor:'
              ''
              '- CTRL UP/DOWN - Move entry'
              
                '- INSERT - Insert entry (Insert Module or CRC depending on which' +
                ' is selected)'
              '- SHIFT + INSERT - Insert crc (when on a module)'
              '- DELETE - Delete a module or crc'
              
                '- SPACE / Mouse Click - toggle flag when a flag is currently foc' +
                'used'
              ''
              'Modgroups:'
              ''
              
                'For a modgroup the be activateable, the order of the mods in the' +
                ' load order and modgroup must match.'
              ''
              
                'If a modgroup is active, what it essentially means is that for e' +
                'ach record that is contained in more than one mod of the modgrou' +
                'p, only the last (in load order) is visible. That'#39's it. The invi' +
                'sible record versions simply don'#39't participate in the normal con' +
                'flict detection mechanisms at all.'
              ''
              
                'A modgroup does not perform any merge or make any changes to any' +
                ' mod. All it does it hide away version of records that you'#39've st' +
                'ated (by defining the modgroup) that you'#39've already checked them' +
                ' against each other and the hidden record is simply irrelevant.'
              ''
              'Modgroups File and Syntax:'
              ''
              
                '[xEdit EXE Name].modgroups i.e. SSEEdit.modgroups for SSEEdit. S' +
                'ave in the same folder as the EXE.'
              
                '[Plugin Name].modgroups i.e. for Someplugin.esp, Someplugin.modg' +
                'roups. Save the file in your Data folder instead.'
              ''
              
                'Prefixes are processed from left to right. #@Plugin.esp is the s' +
                'ame -Plugin.esp. They combine "negatively" not positively.'
              ''
              'without prefix file is both a target and a source'
              '+ The file is optional'
              '- The file is neither a target nor a source.'
              '} Ignore load order completely'
              
                '{ Ignore load order among a consecutive block of mods marked wit' +
                'h this.'
              '@ File is not a source'
              '# File is not a target'
              
                '! File is forbidden. If the listed module is active, the modgrou' +
                'p is invalid.'
              '<filename>:CRC32'
              ''
              
                'If a module is followed by a list of one or more CRC values, the' +
                ' modgroup is only available if the module has one of the listed ' +
                'CRCs. Source means that if a record in this mod is found, then i' +
                't will hide the versions of the same record from all mods listed' +
                ' above it that are targets.'
              ''
              '[Modgroup Name]'
              'MainPlugin.esm'
              'MainPlugin - A.esp'
              'MainPlugin - B.esp'
              'MainPlugin - C.esp'
              'MainPlugin - D.esp'
              'MainPlugin - E.esp'
              ''
              
                'The above example means that all in that particular order for th' +
                'e modgroup to be activateable.'
              ''
              '[Modgroup Name A]'
              '-MainPlugin - C.esp'
              'MainPlugin - D.esp'
              'MainPlugin - E.esp'
              ''
              '[Modgroup Name B]'
              'MainPlugin - C.esp'
              '-MainPlugin - D.esp'
              'MainPlugin - E.esp'
              ''
              
                'Group A) If a record is present in E and D, the records from plu' +
                'gin D will be hidden.'
              
                'Group B) If a record is present in E and C, the records from plu' +
                'gin C will be hidden.'
              ''
              '[Modgroup Name]'
              'MainPlugin - C.esp:12345678'
              'MainPlugin - D.esp:A1B2C3D4,F9E8D7C6'
              'MainPlugin - E.esp'
              ''
              ''
              
                'Not all mod groups defined in that file will necessarily show up' +
                ' in the selection list. Mod groups for which less then 2 plugins' +
                ' are currently active are filtered. If the load order of plugins' +
                ' doesn'#39't match the order in the mod group it is also filtered.'
              ''
              'What'#39's the effect of having a mod group active?'
              ''
              
                'When a record for the view treeview is generated and multiple fi' +
                'les of the same mod group modify this record, then only the newe' +
                'st of the files in that modgroup will be shown. So instead of se' +
                'eing 5 different files with numerous conflicts you are only seei' +
                'ng the newest file in that mod group. This also affects conflict' +
                ' classification.'
              ''
              
                'It'#39's worth pointing out here that if a record is overridden by b' +
                'oth plugins in a mod group and other plugins that normal conflic' +
                't detection will still work perfectly.'
              ''
              
                'Basically this system can be used to reduce a lot of noise from ' +
                'the conflict reports.'
              ''
              'Reference Caching:'
              ''
              '[GameMode]\Data\FO4Edit Cache'
              ''
              
                'Cache files are based on the CRC of the xEdit EXE, then the plug' +
                'in filename. For example 3917E178_DLCNukaWorld_esm_43D25C56.refc' +
                'ache. Once built xEdit will load the cache file rather then buil' +
                'd the references again. This reduces load time.'
              ''
              'xEdit Backup Files:'
              ''
              '[GameMode]\Data\FO4Edit Backups'
              ''
              
                'Backups are saved with the file name [PluginName].[esm/esp/els].' +
                'backup.[Date Stamp} For example PluginName.esp.backup.2018_07_25' +
                '_20_52_10. These can be renamed and copied to the Data folder.'
              ''
              'Show Only Master and Leafs:'
              ''
              
                'What this does is, similar to modgroups, reduce which records ar' +
                'e being show in the view treeview (and are taken into account fo' +
                'r calculating conflict information).'
              ''
              'Suppose you have the following mods:'
              ''
              ''
              '+------------+'
              '|            |'
              '|   Master   |'
              '|            |'
              '+----^-------+'
              '       |'
              '       |       +--------------+                +-------------+'
              '       |       |              <----------------+             |'
              '       +-------+      A       |                |      D      |'
              '       |       |              <-----+          |             |'
              '       |       +--------------+     |          +-------------+'
              '       |                            |'
              '       |       +--------------+     |          +-------------+'
              '       |       |              |     +----------+             |'
              '       +-------+      B       |                |      E      |'
              '       |       |              <----------------+             |'
              '       |       +--------------+                +-------------+'
              '       |'
              '       |       +--------------+'
              '       |       |              |'
              '       +-------+      C       |'
              '               |              |'
              '               +--------------+'
              ''
              
                'Then with active "Only Master and Leafs" only Master, D, E, and ' +
                'C will be shown. The assumption here being that whatever the con' +
                'tents of A or B, it'#39's already being taken into account by D and/' +
                'or E.'
              ''
              
                'This assumption is obviously only true if the author of mods D a' +
                'nd E did their job correctly, so this isn'#39't a good option to hav' +
                'e always enabled. As long as that assumption holds true, it can ' +
                'declutter the reported conflicts significantly.'
              '')
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
            WordWrap = False
          end
        end
        object tbsWEAPSpreadsheet: TTabSheet
          Caption = 'Weapon Spreadsheet'
          ImageIndex = 4
          OnShow = tbsSpreadsheetShow
          object vstSpreadSheetWeapon: TVirtualEditTree
            Tag = 3
            Left = 0
            Top = 0
            Width = 894
            Height = 573
            Align = alClient
            Color = clInfoBk
            DefaultText = 'Node'
            DragOperations = [doCopy]
            Header.AutoSizeIndex = 0
            Header.Options = [hoColumnResize, hoDblClickResize, hoRestrictDrag, hoShowSortGlyphs, hoVisible]
            Header.SortColumn = 1
            HintMode = hmTooltip
            HotCursor = crHandPoint
            IncrementalSearch = isAll
            ParentShowHint = False
            PopupMenu = pmuSpreadsheet
            SelectionBlendFactor = 32
            ShowHint = True
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toFullRowDrag, toEditOnClick]
            TreeOptions.PaintOptions = [toHotTrack, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toRightClickSelect, toSimpleDrawSelection]
            TreeOptions.StringOptions = [toAutoAcceptEditChange]
            OnClick = vstSpreadSheetClick
            OnCompareNodes = vstSpreadSheetCompareNodes
            OnCreateEditor = vstSpreadSheetCreateEditor
            OnDragAllowed = vstSpreadSheetDragAllowed
            OnDragOver = vstSpreadSheetDragOver
            OnDragDrop = vstSpreadSheetDragDrop
            OnEditing = vstSpreadSheetEditing
            OnFreeNode = vstSpreadSheetFreeNode
            OnGetText = vstSpreadSheetGetText
            OnPaintText = vstSpreadSheetPaintText
            OnHeaderClick = vstNavHeaderClick
            OnIncrementalSearch = vstSpreadSheetIncrementalSearch
            OnInitNode = vstSpreadSheetWeaponInitNode
            OnNewText = vstSpreadSheetNewText
            Columns = <
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 0
                Text = 'File Name'
                Width = 150
              end
              item
                MinWidth = 75
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 1
                Text = 'FormID'
                Width = 75
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 2
                Text = 'EditorID'
                Width = 150
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 3
                Text = 'Weapon Name'
                Width = 150
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 4
                Text = 'Enchantment'
                Width = 150
              end
              item
                MinWidth = 120
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 6
                Text = 'Type'
                Width = 120
              end
              item
                Alignment = taRightJustify
                MinWidth = 85
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 8
                Text = 'Speed'
                Width = 85
              end
              item
                Alignment = taRightJustify
                MinWidth = 85
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 9
                Text = 'Reach'
                Width = 85
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 10
                Text = 'Value'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 11
                Text = 'Health'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 85
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 12
                Text = 'Weight'
                Width = 85
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 13
                Text = 'Damage'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 70
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 5
                Text = 'Amount'
                Width = 70
              end
              item
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 7
                Text = 'Skill'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 14
                Text = 'Stagger'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 15
                Text = 'Crit. Damage'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 16
                Text = 'Crit. % Mult.'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 17
                Text = 'Range Min'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 18
                Text = 'Range Max'
                Width = 65
              end
              item
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 19
                Text = 'Sound'
                Width = 65
              end
              item
                MinWidth = 120
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 20
                Text = 'Template'
                Width = 120
              end>
          end
        end
        object tbsARMOSpreadsheet: TTabSheet
          Caption = 'Armor Spreadsheet'
          ImageIndex = 5
          OnShow = tbsSpreadsheetShow
          object vstSpreadsheetArmor: TVirtualEditTree
            Tag = 3
            Left = 0
            Top = 0
            Width = 894
            Height = 573
            Align = alClient
            Color = clInfoBk
            DefaultText = 'Node'
            DragOperations = [doCopy]
            Header.AutoSizeIndex = 0
            Header.Options = [hoColumnResize, hoDblClickResize, hoRestrictDrag, hoShowSortGlyphs, hoVisible]
            Header.SortColumn = 1
            HintMode = hmTooltip
            HotCursor = crHandPoint
            IncrementalSearch = isAll
            ParentShowHint = False
            PopupMenu = pmuSpreadsheet
            SelectionBlendFactor = 32
            ShowHint = True
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toFullRowDrag]
            TreeOptions.PaintOptions = [toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toRightClickSelect]
            TreeOptions.StringOptions = [toAutoAcceptEditChange]
            OnClick = vstSpreadSheetClick
            OnCompareNodes = vstSpreadSheetCompareNodes
            OnCreateEditor = vstSpreadSheetCreateEditor
            OnDragAllowed = vstSpreadSheetDragAllowed
            OnDragOver = vstSpreadSheetDragOver
            OnDragDrop = vstSpreadSheetDragDrop
            OnEditing = vstSpreadSheetEditing
            OnFreeNode = vstSpreadSheetFreeNode
            OnGetText = vstSpreadSheetGetText
            OnPaintText = vstSpreadSheetPaintText
            OnHeaderClick = vstNavHeaderClick
            OnIncrementalSearch = vstSpreadSheetIncrementalSearch
            OnInitNode = vstSpreadSheetArmorInitNode
            OnNewText = vstSpreadSheetNewText
            Columns = <
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 0
                Text = 'File Name'
                Width = 150
              end
              item
                MinWidth = 75
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 1
                Text = 'FormID'
                Width = 75
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 2
                Text = 'EditorID'
                Width = 150
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 3
                Text = 'Armor Name'
                Width = 150
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 4
                Text = 'Enchantment'
                Width = 150
              end
              item
                MinWidth = 120
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 5
                Text = 'Slots'
                Width = 120
              end
              item
                MinWidth = 110
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 6
                Text = 'Type'
                Width = 110
              end
              item
                Alignment = taRightJustify
                MinWidth = 85
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 8
                Text = 'Armor'
                Width = 85
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 9
                Text = 'Value'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 10
                Text = 'Health'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 85
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 11
                Text = 'Weight'
                Width = 85
              end
              item
                MinWidth = 115
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 7
                Text = 'Equip. Type'
                Width = 115
              end
              item
                MinWidth = 110
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 12
                Text = 'Template'
                Width = 110
              end>
          end
        end
        object tbsAMMOSpreadsheet: TTabSheet
          Caption = 'Ammunition Spreadsheet'
          ImageIndex = 6
          OnShow = tbsSpreadsheetShow
          object vstSpreadSheetAmmo: TVirtualEditTree
            Tag = 3
            Left = 0
            Top = 0
            Width = 894
            Height = 573
            Align = alClient
            Color = clInfoBk
            DefaultText = 'Node'
            DragOperations = [doCopy]
            Header.AutoSizeIndex = 0
            Header.Options = [hoColumnResize, hoDblClickResize, hoRestrictDrag, hoShowSortGlyphs, hoVisible]
            Header.SortColumn = 1
            HintMode = hmTooltip
            HotCursor = crHandPoint
            IncrementalSearch = isAll
            ParentShowHint = False
            PopupMenu = pmuSpreadsheet
            SelectionBlendFactor = 32
            ShowHint = True
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toFullRowDrag]
            TreeOptions.PaintOptions = [toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toRightClickSelect]
            TreeOptions.StringOptions = [toAutoAcceptEditChange]
            OnClick = vstSpreadSheetClick
            OnCompareNodes = vstSpreadSheetCompareNodes
            OnCreateEditor = vstSpreadSheetCreateEditor
            OnDragAllowed = vstSpreadSheetDragAllowed
            OnDragOver = vstSpreadSheetDragOver
            OnDragDrop = vstSpreadSheetDragDrop
            OnEditing = vstSpreadSheetEditing
            OnFreeNode = vstSpreadSheetFreeNode
            OnGetText = vstSpreadSheetGetText
            OnPaintText = vstSpreadSheetPaintText
            OnHeaderClick = vstNavHeaderClick
            OnIncrementalSearch = vstSpreadSheetIncrementalSearch
            OnInitNode = vstSpreadSheetAmmoInitNode
            OnNewText = vstSpreadSheetNewText
            Columns = <
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 0
                Text = 'File Name'
                Width = 150
              end
              item
                MinWidth = 75
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 1
                Text = 'FormID'
                Width = 75
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 2
                Text = 'EditorID'
                Width = 150
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 3
                Text = 'Ammunition Name'
                Width = 150
              end
              item
                MinWidth = 150
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 4
                Text = 'Enchantment'
                Width = 150
              end
              item
                Alignment = taRightJustify
                MinWidth = 85
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 5
                Text = 'Speed'
                Width = 85
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 6
                Text = 'Value'
                Width = 65
              end
              item
                Alignment = taRightJustify
                MinWidth = 85
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 7
                Text = 'Weight'
                Width = 85
              end
              item
                Alignment = taRightJustify
                MinWidth = 65
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 8
                Text = 'Damage'
                Width = 65
              end
              item
                MinWidth = 80
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
                Position = 9
                Text = 'Flags'
                Width = 80
              end>
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'TabSheet2'
          ImageIndex = 7
          TabVisible = False
          object DisplayPanel: TPanel
            Left = 0
            Top = 0
            Width = 894
            Height = 573
            Align = alClient
            BevelOuter = bvLowered
            TabOrder = 0
          end
        end
        object tbsWhatsNew: TTabSheet
          Caption = 'What'#39's New'
          ImageIndex = 8
          TabVisible = False
        end
      end
    end
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 1364
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object bnMainMenu: TSpeedButton
        Tag = 1
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 24
        Height = 24
        Align = alLeft
        Caption = #926
        Enabled = False
        Flat = True
        PopupMenu = pmuMain
        OnMouseDown = bnMainMenuMouseDown
      end
      object bnBack: TSpeedButton
        AlignWithMargins = True
        Left = 805
        Top = 3
        Width = 24
        Height = 24
        Action = acBack
        Align = alRight
        Flat = True
        Glyph.Data = {
          36090000424D3609000000000000360000002800000030000000100000000100
          18000000000000090000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF7F4026814125814125814125814125814125FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93939394949494
          9494949494949494949494FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652814672913672913672913672913672913FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF824125814125CB6600CB6600CB
          6600CB6600CB6600CB6600814125814125FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF949494949494A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A19494949494
          94FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF682913672913BC4B00BC4B00BC
          4B00BC4B00BC4B00BC4B00672913672913FF00FFFF00FFFF00FFFF00FFFF00FF
          9B4E18C56203CA6500CA6500CA6500CA6500CA6500CB6600CB6600CB6600C563
          03814125FF00FFFF00FFFF00FFFF00FF989898A0A0A0A1A1A1A1A1A1A1A1A1A1
          A1A1A1A1A1A1A1A1A1A1A1A1A1A1A0A0A0949494FF00FFFF00FFFF00FFFF00FF
          83350BB54701BB4A00BB4A00BB4A00BB4A00BB4A00BC4B00BC4B00BC4B00B548
          01672913FF00FFFF00FFFF00FF994D19C46202C86300C66100C66100C66100C6
          6100C86300C96400CB6600CB6600CB6600C56303814125FF00FFFF00FF989898
          9F9F9FA0A0A09F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A0A0A0A1A1A1A1A1A1A1A1
          A1A0A0A0949494FF00FFFF00FF81340CB44700B84800B64600B64600B64600B6
          4600B84800BA4900BC4B00BC4B00BC4B00B54801672913FF00FFFF00FFBB5D06
          C66201C46002C25E02BF5B02CE833FD6955AD8975BD68F4BD07720CB6600CB66
          00CB6600824125FF00FFFF00FF9D9D9D9F9F9F9F9F9F9E9E9E9D9D9DB8B8B8C4
          C4C4C5C5C5BFBFBFAEAEAEA1A1A1A1A1A1A1A1A1949494FF00FFFF00FFA94202
          B64700B44500B14300AD4100C06928CA7D40CC7F41CA7632C25C10BC4B00BC4B
          00BC4B00682913FF00FFA85411C96707C7680AC56809C26608C16405E7C3A0FE
          FEFEFEFEFEFEFEFEFEFEFEDB9957CB6600CB6600CB66007F40269A9A9AA3A3A3
          A3A3A3A2A2A2A1A1A19F9F9FE3E3E3FFFFFFFFFFFFFFFFFFFFFFFFC5C5C5A1A1
          A1A1A1A1A1A1A1939393923A07BA4C02B74D03B54D03B14B03B04901E0B289FE
          FEFEFEFEFEFEFEFEFEFEFED0813DBC4B00BC4B00BC4B00652814AC570FCD7114
          CA7218C8721AC7711AC56F17C56F18C6711CC46E1AC56D1EE4B78DFEFEFECA65
          00CB6600CB66008241259B9B9BA8A8A8A9A9A9A9A9A9A8A8A8A7A7A7A7A7A7A9
          A9A9A8A8A8A9A9A9DBDBDBFFFFFFA1A1A1A1A1A1A1A1A1949494973D06BF5609
          BB570BB8570CB7560CB5540AB5540BB6560DB4530CB5520FDCA474FEFEFEBB4A
          00BC4B00BC4B00682913AB5812D48434CF7F2ECD7E2DCD7F2FCC7D2CEACCACC6
          7019C2680CBF6003C66915FEFEFECA6500CB6600CB66008241259C9C9CB6B6B6
          B2B2B2B1B1B1B2B2B2B1B1B1E8E8E8A8A8A8A2A2A29E9E9EA6A6A6FFFFFFA1A1
          A1A1A1A1A1A1A1949494963E07C76A1FC1651ABF6419BF651BBD6318E3BD97B6
          550CB14D04AD4501B64E09FEFEFEBB4A00BC4B00BC4B00682913AC5915DEA264
          D7934DD38B41D48D44ECCFB1FEFEFECB7B2AC67019C3670BD7985DFEFEFECA65
          00CB6600CB66008241259D9D9DCBCBCBC0C0C0BBBBBBBCBCBCEAEAEAFFFFFFAF
          AFAFA8A8A8A2A2A2C6C6C6FFFFFFA1A1A1A1A1A1A1A1A1949494973F09D48B49
          CB7A34C67229C7742CE6C19DFEFEFEBC6017B6550CB24C04CB8042FEFEFEBB4A
          00BC4B00BC4B00682913AA5711E6B482E3B17CDA9854F4E0CCFEFEFEFEFEFEF8
          EEE3F3E1CFF2DFCCFEFEFEE5B88DCA6500CB6600CB66008241259B9B9BD8D8D8
          D4D4D4C4C4C4F7F7F7FFFFFFFFFFFFFFFFFFF8F8F8F6F6F6FFFFFFDCDCDCA1A1
          A1A1A1A1A1A1A1949494953D07DEA068DA9D62CF803AF0D7BDFEFEFEFEFEFEF6
          E9DAEFD8C1EED5BDFEFEFEDDA574BB4A00BC4B00BC4B00682913AA550EE7B27D
          F0D3B5E5B079F5E1CCFEFEFEFEFEFEF4E2D0EBCBABE9C7A4DB9E60C76303CA65
          00CB6600CB66007F40269A9A9AD7D7D7EDEDEDD4D4D4F7F7F7FFFFFFFFFFFFF8
          F8F8E8E8E8E5E5E5C8C8C8A1A1A1A1A1A1A1A1A1A1A1A1939393953B05E09E63
          EBC6A1DD9C5EF2D8BDFEFEFEFEFEFEF0D9C2E5BC96E2B78ED08745B74801BB4A
          00BC4B00BC4B00652814FF00FFAF6221F3D9BFF4D9BEEABB8BF2D8BDFEFEFED5
          8E45D08232CD7720CB6F11CA6604CA6500CB6600824125FF00FFFF00FFA3A3A3
          F2F2F2F2F2F2DCDCDCF1F1F1FFFFFFBDBDBDB4B4B4ACACACA7A7A7A2A2A2A1A1
          A1A1A1A1949494FF00FFFF00FF9A4711EFCEADF0CEACE3A972EECCABFEFEFEC9
          752DC2681DBF5C10BC5407BB4B01BB4A00BC4B00682913FF00FFFF00FFAA550E
          E9B782F8E7D5F6DFC8E9BB8BEFCFAED78F45D38433D07A22CF7417CB6808CB66
          00C563037D3F27FF00FFFF00FF9A9A9AD9D9D9FBFBFBF6F6F6DCDCDCEAEAEABD
          BDBDB6B6B6AFAFAFAAAAAAA3A3A3A1A1A1A0A0A0939393FF00FFFF00FF953B05
          E2A468F6E0C9F3D5B8E2A972EAC199CB762DC66A1EC25F11C1590ABC4D03BC4B
          00B54801632815FF00FFFF00FFFF00FFAB5610EBB986F6E0CAF7E6D4F0D1B1E8
          B98AE3AA71DFA060D98F44CE7111C563038F481EFF00FFFF00FFFF00FFFF00FF
          9B9B9BDBDBDBF7F7F7FAFAFAECECECDCDCDCD1D1D1C9C9C9BDBDBDA8A8A8A0A0
          A0969696FF00FFFF00FFFF00FFFF00FF963C06E5A66CF3D7BBF4DEC7EBC49DE1
          A670DA9556D58945CE762CC05607B54801762F0FFF00FFFF00FFFF00FFFF00FF
          FF00FFAC570FB36728ECBC8BF0CBA6EECAA4EABC8EE1A263D47E28B05C158945
          21FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BA6A6A6DDDDDDE8E8E8E7
          E7E7DEDEDECBCBCBB2B2B29E9E9E959595FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF973D069F4C16E6AA72EBBC90E9BB8EE3AA75D88B48C764169C41096F2D
          11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAE5911B05D17B2
          611DB1601AB05B149C5019FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF9C9C9C9F9F9FA2A2A2A1A1A19E9E9E999999FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993F079C420A9E
          460E9D450C9C410984360CFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 3
      end
      object bnForward: TSpeedButton
        AlignWithMargins = True
        Left = 835
        Top = 3
        Width = 25
        Height = 24
        Action = acForward
        Align = alRight
        Flat = True
        Glyph.Data = {
          36090000424D3609000000000000360000002800000030000000100000000100
          18000000000000090000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF7F4026814125814125814125814125814125FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93939394949494
          9494949494949494949494FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652814672913672913672913672913672913FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF824125814125CB6600CB6600CB
          6600CB6600CB6600CB6600814125814125FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF949494949494A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A19494949494
          94FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF682913672913BC4B00BC4B00BC
          4B00BC4B00BC4B00BC4B00672913672913FF00FFFF00FFFF00FFFF00FFFF00FF
          9B4E18C56203CA6500CA6500CA6500CA6500CA6500CB6600CB6600CB6600C563
          03814125FF00FFFF00FFFF00FFFF00FF989898A0A0A0A1A1A1A1A1A1A1A1A1A1
          A1A1A1A1A1A1A1A1A1A1A1A1A1A1A0A0A0949494FF00FFFF00FFFF00FFFF00FF
          83350BB54701BB4A00BB4A00BB4A00BB4A00BB4A00BC4B00BC4B00BC4B00B548
          01672913FF00FFFF00FFFF00FF994D19C46202C86300C66100C66100C66100C6
          6100C86300C96400CB6600CB6600CB6600C56303814125FF00FFFF00FF989898
          9F9F9FA0A0A09F9F9F9F9F9F9F9F9F9F9F9FA0A0A0A0A0A0A1A1A1A1A1A1A1A1
          A1A0A0A0949494FF00FFFF00FF81340CB44700B84800B64600B64600B64600B6
          4600B84800BA4900BC4B00BC4B00BC4B00B54801672913FF00FFFF00FFBB5D06
          C66201C46002C25E02C76F22D18A4BD6955BD8965AD4883FC96400CB6600CB66
          00CB6600824125FF00FFFF00FF9D9D9D9F9F9F9F9F9F9F9F9FABABABBEBEBEC5
          C5C5C5C5C5BABABAA0A0A0A1A1A1A1A1A1A1A1A1949494FF00FFFF00FFA94202
          B64700B44500B14300B75411C47032CA7D41CC7E40C76E28BA4900BC4B00BC4B
          00BC4B00682913FF00FFA85411C96707C7680AC56809D69A5CFEFEFEFEFEFEFE
          FEFEFEFEFEE7C29FC66100C96400CB6600CB6600CB66007F40269B9B9BA3A3A3
          A3A3A3A2A2A2C5C5C5FFFFFFFFFFFFFFFFFFFFFFFFE3E3E39F9F9FA0A0A0A1A1
          A1A1A1A1A1A1A1939393923A07BA4C02B74D03B54D03CA8241FEFEFEFEFEFEFE
          FEFEFEFEFEE0B188B64600BA4900BC4B00BC4B00BC4B00652814AC570FCD7114
          CA7218C8721AFEFEFEE5BF98CA7C2CC77320C36B16C05F08C35E00C86300CA65
          00CB6600CB66008241259B9B9BA9A9A9A9A9A9A9A9A9FFFFFFDFDFDFB0B0B0AB
          ABABA6A6A6A0A0A09E9E9EA0A0A0A1A1A1A1A1A1A1A1A1949494973D06BF5609
          BB570BB8570CFEFEFEDDAD80BB6218B75810B2500AAF4403B24300B84800BB4A
          00BC4B00BC4B00682913AB5812D48434CF7F2ECD7E2DFEFEFED0873CCA7825C6
          7019C2680CE6C3A0C15C01C66100CA6500CB6600CB66008241259C9C9CB7B7B7
          B2B2B2B2B2B2FFFFFFB8B8B8ADADADA8A8A8A2A2A2E3E3E39E9E9E9F9F9FA1A1
          A1A1A1A1A1A1A1949494963E07C76A1FC1651ABF6419FEFEFEC26D25BB5D13B6
          550CB14D04DEB289B04100B64600BB4A00BC4B00BC4B00682913AC5915DEA264
          D7934DD38B41FEFEFEE2B484D08537CB7B2AC67019FEFEFEE5BE98C56000CA65
          00CB6600CB66008241259D9D9DCBCBCBC0C0C0BBBBBBFFFFFFD8D8D8B6B6B6B0
          B0B0A8A8A8FFFFFFDFDFDF9F9F9FA1A1A1A1A1A1A1A1A1949494973F09D48B49
          CB7A34C67229FEFEFED9A06AC26B21BC6017B6550CFEFEFEDDAC80B54500BB4A
          00BC4B00BC4B00682913AA5711E6B482E3B17CDA9854EFD2B5FEFEFEF5E6D7F4
          E4D3F7ECE1FEFEFEFEFEFEEDCFB2CA6500CB6600CB66008241259B9B9BD8D8D8
          D5D5D5C4C4C4EDEDEDFFFFFFFBFBFBF9F9F9FFFFFFFFFFFFFFFFFFEBEBEBA1A1
          A1A1A1A1A1A1A1949494953D07DEA068DA9D62CF803AEAC5A1FEFEFEF2DECBF0
          DCC6F4E6D8FEFEFEFEFEFEE7C19EBB4A00BC4B00BC4B00682913AA550EE7B27D
          F0D3B5E5B079E3AA6FEAC39AF0D6BBEDD0B3F2DFCBFEFEFEFEFEFEEBC8A6CA65
          00CB6600CB66007F40269B9B9BD7D7D7EDEDEDD5D5D5D1D1D1E2E2E2EFEFEFEC
          ECECF6F6F6FFFFFFFFFFFFE6E6E6A1A1A1A1A1A1A1A1A1939393953B05E09E63
          EBC6A1DD9C5EDA9554E3B282EBCAA9E7C29FEED5BCFEFEFEFEFEFEE5B890BB4A
          00BC4B00BC4B00652814FF00FFAF6221F3D9BFF4D9BEEABB8BE3AA6FDC9B5AD5
          8E45D08232FEFEFEE7BD92CA6604CA6500CB6600824125FF00FFFF00FFA3A3A3
          F2F2F2F2F2F2DDDDDDD1D1D1C7C7C7BDBDBDB4B4B4FFFFFFDEDEDEA2A2A2A1A1
          A1A1A1A1949494FF00FFFF00FF9A4711EFCEADF0CEACE3A972DA9554D18340C9
          752DC2681DFEFEFEE0AB79BB4B01BB4A00BC4B00682913FF00FFFF00FFAA550E
          E9B782F8E7D5F6DFC8E9BB8BDE9F5ED78F45D38433E7BC90CF7417CB6808CB66
          00C563037D3F27FF00FFFF00FF9B9B9BD9D9D9FBFBFBF6F6F6DDDDDDC9C9C9BE
          BEBEB6B6B6DDDDDDABABABA4A4A4A1A1A1A0A0A0939393FF00FFFF00FF953B05
          E2A468F6E0C9F3D5B8E2A972D48843CB762DC66A1EE0AA77C1590ABC4D03BC4B
          00B54801632815FF00FFFF00FFFF00FFAB5610EBB986F6E0CAF7E6D4F0D1B1E8
          B98AE3AA71DFA060D98F44CE7111C563038F481EFF00FFFF00FFFF00FFFF00FF
          9B9B9BDBDBDBF7F7F7FBFBFBECECECDCDCDCD1D1D1CACACABEBEBEA8A8A8A0A0
          A0969696FF00FFFF00FFFF00FFFF00FF963C06E5A66CF3D7BBF4DEC7EBC49DE1
          A670DA9556D58945CE762CC05607B54801762F0FFF00FFFF00FFFF00FFFF00FF
          FF00FFAC570FB36728ECBC8BF0CBA6EECAA4EABC8EE1A263D47E28B05C158945
          21FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B9B9BA6A6A6DDDDDDE8E8E8E7
          E7E7DEDEDECCCCCCB2B2B29F9F9F969696FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF973D069F4C16E6AA72EBBC90E9BB8EE3AA75D88B48C764169C41096F2D
          11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAE5911B05D17B2
          611DB1601AB05B149C5019FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF9D9D9D9F9F9FA2A2A2A1A1A19F9F9F999999FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF993F079C420A9E
          460E9D450C9C410984360CFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 3
      end
      object lblPath: TEdit
        AlignWithMargins = True
        Left = 30
        Top = 5
        Width = 769
        Height = 20
        Margins.Left = 0
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alClient
        AutoSize = False
        BevelInner = bvNone
        BevelKind = bkTile
        BevelWidth = 2
        BorderStyle = bsNone
        Ctl3D = True
        ParentColor = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        Visible = False
        StyleElements = [seFont, seBorder]
      end
      object pnlBtn: TPanel
        AlignWithMargins = True
        Left = 866
        Top = 3
        Width = 495
        Height = 24
        Align = alRight
        AutoSize = True
        BevelEdges = []
        BevelOuter = bvNone
        PopupMenu = pmuBtnMenu
        TabOrder = 1
        object bnPayPal: TSpeedButton
          AlignWithMargins = True
          Left = 442
          Top = 0
          Width = 52
          Height = 24
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'PayPal'
          Flat = True
          Glyph.Data = {
            76030000424D760300000000000036000000280000000D000000100000000100
            2000000000004003000000000000000000000000000000000000000000000000
            0000000000003E3829446C5C38766959357425231E2700000000000000000000
            0000000000000000000000000000000000000101010102020202856A2E93DC9B
            01FDDC9B01FD6C592E7800000000000000000000000000000000000000000000
            00004F392D715D3723945E392595A26915D8DD9B01FEDE9C01FF90712AA00101
            01010000000000000000000000000000000000000000764A33B8843000FE8430
            00FEA55801FEDD9C00FFDE9C01FFAB7D13C30606060600000000000000000000
            00000000000000000000543E3276843000FE853000FF984800FFDD9C01FFDE9C
            01FFC88D04E6443E2D4A2B27202E1E1D1A1F0404040400000000000000003F33
            2E51822F00FB853000FF8D3900FFDC9A01FFDE9C01FFDD9B01FED59600F6D293
            00F2C78B02E5846726951A1A181C000000002723212F7E2D00F3853000FF842F
            00FFD69401FFDE9C01FFDE9C01FFDE9C01FFDE9C01FFDE9C01FFDB9B00FD9E76
            1AB40A0A0A0B17161519762A00E4853000FF842F00FF863C02FF924C02FF944D
            02FFA05A02FFBF7B02FFDC9A00FFDE9C01FFD79701F7473F2D4D0A09090A6F2E
            0ECB853000FF853000FF722501FF692002FF692002FF692002FF681F02FF8840
            02FFD69401FFDD9B01FE8E73359D03030303693820B0843000FE853000FF7727
            01FF692002FF692002FF692002FF692002FF681F02FF904902FFDD9B01FFBD93
            35D4000000005C3D2E8B843000FE853000FF7A2900FF692002FF692002FF6920
            02FF692002FF692002FF681F02FFC58301FB705E347C000000004B393166832F
            00FD853000FF7F2C00FF681F02FF692002FF692002FF692002FF692002FF681F
            02FE7E5222BC1313121400000000352D2944812E00FA853000FF842F00FF7D2B
            00FF7D2B00FF7D2B00FF7D2B00FF7D2B00FF7F2D00FE60443789000000000000
            00002522212A7D2D00F2853000FF853000FF853000FF853000FF853000FF8530
            00FF853000FF822E00FC45352D5F000000000000000011101012732903DC8530
            00FF853000FF853000FF853000FF853000FF843000FE812E00F9683015B81313
            1215000000000000000003030303593C2E84744228BB734127BD734127BB7342
            27BC754429C0704834AB43342E5A0F0E0E100000000000000000}
          OnClick = bnPayPalClick
        end
        object bnPatreon: TSpeedButton
          AlignWithMargins = True
          Left = 332
          Top = 0
          Width = 58
          Height = 24
          Hint = 
            'Patreon is now live! Please support further ongoing xEdit develo' +
            'pment.'
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Constraints.MaxWidth = 58
          Caption = 'Patreon'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            20000000000000040000000000000000000000000000000000000059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF0059FFFF0059FFFF0059FFFF0057FBFB0A4F
            D1DC1B3E7E9A13182033000000000000000000000000000000000059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF0059FFFF0159FFFF1969FFFF1F6DFFFF035A
            FFFF0059FFFF0059FEFE193E839D0505050A00000000000000000059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF035BFFFFE9F0FFFFFFFFFFFFFFFFFFFFF1F5
            FFFF9CBEFFFF1C6BFFFF0059FFFF134AB0C40505050A000000000059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF045BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFEEF3FFFF3C80FFFF0059FFFF193E839D000000000059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF035BFFFFA3C3FFFF5B94FFFF5B94FFFFA6C4
            FFFFFDFDFFFFFFFFFFFFEEF3FFFF1C6BFFFF0059FEFE131820340059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF0059FFFF0059FFFF0059FFFF0059FFFF0059
            FFFF5691FFFFFDFEFFFFFFFFFFFF9CBEFFFF0059FFFF1B3E7E9A0059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF0059FFFF0059FFFF0059FFFF0059FFFF0059
            FFFF0059FFFFA9C6FFFFFFFFFFFFF1F6FFFF035BFFFF0A4FD1DC0059FFFF2470
            FFFFFFFFFFFFFFFFFFFF518DFFFF0059FFFF0059FFFF0059FFFF0059FFFF0059
            FFFF0059FFFF6097FFFFFFFFFFFFFFFFFFFF206DFFFF0058FBFB0057F9F91C6B
            FFFFFFFFFFFFFFFFFFFF5D96FFFF0059FFFF0059FFFF0059FFFF0059FFFF0059
            FFFF0059FFFF6098FFFFFFFFFFFFFFFFFFFF1F6DFFFF0057FBFB0C4ECCD9025A
            FFFFEFF4FFFFFFFFFFFFA7C6FFFF0059FFFF0059FFFF0059FFFF0059FFFF0059
            FFFF0059FFFFABC8FFFFFFFFFFFFF1F5FFFF035BFFFF0A4FD1DC1B3C7C970059
            FFFF98BCFFFFFFFFFFFFFDFEFFFF5792FFFF0059FFFF0059FFFF0059FFFF0059
            FFFF5A93FFFFFEFEFFFFFFFFFFFF9BBEFFFF0059FFFF1B3E7E9A12161E300057
            FDFD1A6AFFFFECF2FFFFFFFFFFFFFDFEFFFFAAC7FFFF6198FFFF6198FFFFABC8
            FFFFFEFEFFFFFFFFFFFFEDF3FFFF1B6BFFFF0059FEFE13182033000000001A3D
            7F990059FFFF397EFFFFECF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFEDF3FFFF3B7FFFFF0059FFFF1A3E829C00000000000000000404
            04081348ACC00059FFFF1A6AFFFF98BCFFFFEEF4FFFFFFFFFFFFFFFFFFFFEFF4
            FFFF9ABDFFFF1B6AFFFF0059FFFF1349AFC30404050900000000000000000000
            0000040405091A3D7F990057FDFD0059FFFF025AFFFF1C6BFFFF1C6BFFFF025A
            FFFF0059FFFF0058FDFD1A3D809B040405090000000000000000000000000000
            0000000000000000000012161E301B3C7B970C4ECAD80056F8F80056F8F80B4F
            CCD91B3D7C9812171E3100000000000000000000000000000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = bnPatreonClick
        end
        object bnNexusMods: TSpeedButton
          AlignWithMargins = True
          Left = 128
          Top = 0
          Width = 76
          Height = 24
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Constraints.MaxWidth = 76
          Caption = 'NexusMods'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000202020B1D1C1D7C1A1A1DCC1A1A1B840303030C0D0D0D1F0B0B0C1C0000
            0000000000000000000000000000000000000000000000000000000000000404
            041F222224D6515052FFABABACFF565657FF201F23FF201F23FF201F23FF2020
            23F31A1A1CBA232225EA201F22FF1F1F21C30303030B00000000000000002121
            23D0818283FFF1F2F2FFFFFFFFFFF7F7F7FF86A5CEFF2E94E3FF2E94E3FF2B83
            C6FF295D8AFF25507EFF687C9CFF656566FF1D1C1EB600000000000000002625
            28FB265384FF7B93B9FFF1F5FCFFFFFFFFFFF0F6FCFF48A8FAFF30A3FAFF30A3
            FAFF30A3FAFF2D8DDAFFB4C0D3FFE8E8E8FF212024FF11101154000000002020
            22C5244871FF2C8DDAFF68B1FAFFF2F7FDFFFFFFFFFFC5DCFAFF57ACF9FF30A3
            FAFF30A3FAFF8EBFF8FFFAFCFEFFFFFFFFFF7B7A7BFF18171995000000001A1A
            1CA2225078FF30A3FAFF30A3FAFFABCDFBFFFFFFFFFFF7FBFEFF30A3F9FFB1D3
            F9FFC1DAFBFFFEFEFFFFFFFFFFFFDEDEDEFF201F23FF0A090A3E000000002120
            23DD2C7BBCFF30A3FAFF30A3FAFF93C2FAFFDAE9FCFFD8E7FDFF3FA6FAFFF6F9
            FDFFFFFFFFFFFFFFFFFFDAE8FCFF4981B5FF222124DB00000000000000001F1E
            22FF2C85C9FF30A3FAFF6EB3FAFF9FC7FAFF59ACFAFF39A5FAFF62AFF9FFD6E6
            FCFFF5F9FDFF97C3F9FF30A3FAFF2A83C7FF222124FD00000000000000002221
            24FD2B83C8FF77B7FAFFDBE9FBFFFFFFFFFFFEFFFEFF60AFF9FF8BBFF9FF5AAD
            FAFF30A3F9FF47A8FAFF30A3FAFF2B84C8FF2A292CF400000000040405152625
            28EFA4B2C5FFFBFDFEFFFFFFFFFFFAFCFDFFDDEAFBFF30A3FAFFF0F7FDFFFCFD
            FEFFA0C9F9FF30A3FAFF30A3FAFF296CA4FF1E1D1FBF00000000161617805757
            58FFFAFAFAFFFFFFFFFFE2EDFCFF65B1F9FF79B8FAFF6FB3FAFFFAFCFEFFFFFF
            FFFFB7D5FBFF30A3FAFF30A0F5FF213B59FF19181B9300000000141415907C7C
            7DFFFFFFFFFFE4E9F2FF49A8FAFF30A3FAFF30A3FAFF41A6FAFFA3CAFAFFFFFF
            FFFFFBFDFEFF8BBEF9FF2B7EC4FF254A73FF1D1C1EC6000000000909092B2322
            26FCC5C5C5FF7F96BAFF2C7FC5FF319FF2FF30A3FAFF30A3FAFF2FA3FAFFDFEB
            FBFFFFFFFFFFFBFCFCFFC3CCDBFF60718BFF1A191CCC00000000000000001515
            166D212024FF263C58FF232F44FF24303EFF276598FF2C77B5FF2B76B3FF4A6E
            96FFD9D9DAFFFDFDFDFFBFBFBFFF212024FF1818198100000000000000000000
            000017161866131214991717187C161617661C1B1DAE1A191CCC1A191CCC2322
            25BF201F23FF28272AFF1F1E22F5171718690000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000B0B0B2C0E0D0F6504040417000000000000000000000000}
          OnClick = bnNexusModsClick
        end
        object bnKoFi: TSpeedButton
          AlignWithMargins = True
          Left = 392
          Top = 0
          Width = 48
          Height = 24
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Constraints.MaxWidth = 48
          Caption = 'Ko-Fi'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000000000000000000030301182F2715736A5930B59C8247D39D8347D46A59
            30B5302815730303011900000000000000000000000000000000000000000000
            00000000000230281671B09350F0BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
            57FFBF9F57FFB09350F032291672000000030000000000000000000000000000
            00024C3F2297BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
            57FFBF9F57FFBF9F57FFBF9F57FF4F41249A0000000300000000000000003129
            1672BF9F57FFC6A96AFFC9AE71FFC9AE71FFC9AE71FFC9AE71FFC9AE71FFC8AC
            6FFFC0A15BFFBF9F57FFBF9F57FFBF9F57FF332A17740000000003030118B193
            50F1D5C193FFFDFDFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
            FEFFF1EADBFFC0A15CFFBF9F57FFBF9F57FFB29451F2030301192F271573BF9F
            57FFE2D4B4FFFFFFFFFFFFFFFFFFFEFEFFFFCBCBFFFFEBEBFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFD5C193FFC5A867FFBF9F57FFBF9F57FF2D2615756B5931B6BF9F
            57FFE5D8BBFFFFFFFFFFFEFEFFFFBBBBFFFF6161FFFF7171FFFFE6E6FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFEFDFCFFE3D5B7FFBFA059FF6E5C32B89D8347D4BF9F
            57FFE5D8BBFFFFFFFFFFC6C6FFFF6060FFFF5F5FFFFF5F5FFFFF7272FFFFF2F2
            FFFFFFFFFFFFD9C69BFFE3D5B6FFFEFEFEFFD5C193FF9F8448D69D8347D4BF9F
            57FFE5D8BBFFFFFFFFFF9090FFFF5F5FFFFF5F5FFFFF5F5FFFFF5F5FFFFFCBCB
            FFFFFFFFFFFFCCB37AFFC0A05AFFFCFBF8FFE4D7B9FF9F8448D66A5930B5BF9F
            57FFE5D8BBFFFFFFFFFFCDCDFFFF8383FFFFAEAEFFFF9393FFFF8F8FFFFFF2F2
            FFFFFFFFFFFFCCB37AFFCCB47BFFFEFEFDFFDDCDA7FF6E5B32B72F271572BF9F
            57FFE5D8BBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFAF8F3FFFDFCFBFFF6F2EAFFC5A867FF2D25147303030118B093
            50F0D3BD8CFFE7DBC0FFE7DBC0FFE7DBC0FFE7DBC0FFE7DBC0FFE7DBC0FFE7DB
            C0FFE7DBC0FFE7DBC0FFDECEAAFFC4A766FFB29350F103030119000000003028
            1670BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
            57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FF322A177200000000000000000000
            00024B3E2296BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
            57FFBF9F57FFBF9F57FFBF9F57FF4E4123990000000200000000000000000000
            0000000000022F27156FAF9250EFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
            57FFBF9F57FFAF9250EF31281670000000020000000000000000000000000000
            00000000000000000000030201172E2715716A5830B49C8247D39C8247D36A58
            30B42B2413710303011800000000000000000000000000000000}
          OnClick = bnKoFiClick
        end
        object bnHelp: TSpeedButton
          AlignWithMargins = True
          Left = 1
          Top = 0
          Width = 69
          Height = 24
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Constraints.MaxWidth = 72
          Caption = 'Help'
          Flat = True
          Glyph.Data = {
            960C0000424D960C00000000000036000000280000002C000000120000000100
            200000000000600C000000000000000000000000000000000000000000001F1F
            1F7F2323248D2323258926252786262526812524257D25232479232222742220
            20712221216C211F1F68201F1F641F1F1F5F1E1D1D5B1E1D1D581C1C1C531B1A
            1A4F1B1A1A4B19191946181818431D1D1E9E0F0E0FDD1A1919BF1F1F1F681E1E
            1E601F1E1E68201F1F7122222279232324812525278926282B92282A2F9A282B
            32A2282C34AB272C37B3282F3BBB293040C32A3243CC272F43D421293CDC171F
            30E5111623ED16181BCC000000002625259737475DFF2A406BFF233B6FFF2845
            7CFF2C4A82FF2F4D84FF2F4E84FF2E4D83FF2F4D7FFF2D4978FF2C4572FF2941
            6AFF283D63FF23365AFF203151FF1D2D4BFF1B2A48FF1B2A49FF182645FF1422
            44FF192239FF1C2741FF283B62FF2B3F67FF2C426CFF304770FF314A76FF344E
            7AFF37517EFF37517FFF36517FFF365180FF35507FFF324E7DFF324F7EFF314E
            7EFF2F4C7CFF2C4574FF2E426EFF2E4266FF27364DFE1E1E1F5D000000001212
            122B383D47FD5F80AAFF6180AAFF637FA6FF5D789EFF516D94FF415E88FF3351
            7FFF375582FF375480FF375582FF395785FF375585FF335181FF2F4B7BFF2C46
            75FF273F6DFF213761FF233762FF445E85FF5982B2FF668EB7FF475E83FF3049
            76FF334F7DFF3A5787FF3B5A8AFF395685FF35507FFF334E7BFF334D7AFF4059
            82FF4F678DFF5E7699FF6D86A6FF7E96B5FF8CA5C3FF98B3D1FF89A9CBFF5F7B
            9FFF303743DB0202020400000000000000002E2B2ABB5474A0FF6F98C6FF9FC0
            DEFFB8D2E5FFC5D9E9FFCCDDEBFFC8DAE7FFB5C8DBFFA1B7D0FF8BA3C0FF7892
            B0FF6983A5FF5E789BFF5C7598FF5E7799FF677F9EFF7D95B3FF97AFCDFF86A5
            C7FF6B98C7FF94BADEFFB9D1E4FFC4D7E7FFB7C9DBFFADBFD3FFA9BAD0FFAABB
            D0FFAFC0D5FFB7CADCFFC1D4E4FFBED2E3FFBBCFE1FFB6CDDFFFB1C9DDFFABC4
            DBFFA3BED9FF8FB1D4FF799FCAFF506991FF2323246200000000000000000000
            00001E1E1E4D4A5A71FE6992C3FF8FB4D8FFB9D2E6FFCFDDEBFFD7E3EDFFDDE7
            EEFFDFE9F0FFE0E9F1FFDEE8F0FFDCE8EFFFD9E6EEFFD7E4EDFFD6E3ECFFD0DE
            E8FFC1D2E2FFAEC2D6FF9EB3CEFF8FA9C8FF73A0CDFFA8C6E2FFC9D8E7FFD5E1
            ECFFDDE7EFFFE1E9F1FFE1E9F1FFE0E8F0FFDBE4EEFFD6E1EBFFCFDDE9FFC8D6
            E5FFC5D4E4FFBFCFE2FFB3C8DCFFADC4DAFFA2BBD8FF7FA7D0FF698FBCFF404B
            5DDE02020205000000000000000000000000010101023C3B3EDB658DBEFF83A9
            D3FFB2CDE5FFCCDCEBFFD8E5EDFFE1EAF1FFE6EDF4FFEAEEF5FFEBEFF6FFE9EE
            F4FFE6ECF3FFE3EBF2FFE1E9F0FFD9E4EBFFC6D5E3FFB2C3D7FFA0B4CEFF97AF
            CCFF7FA9D3FFB3CDE5FFCDDBE8FFDDE6EFFFE7EDF3FFEBF0F5FFEBEFF5FFE8EE
            F4FFE4EBF2FFDFE7EFFFD7E1EBFFCEDAE7FFC9D6E5FFC2D1E2FFB7C9DCFFB1C6
            DBFF9AB7D6FF749ECDFF5776A4FF262628650000000000000000000000000000
            0000000000002B2928705E7899FF749DCBFFA2C3E1FFC5D9EAFFD5E3EDFFE3EB
            F2FFECF0F5FFF0F4F7FFF1F5F8FFF0F5F7FFEDF1F6FFEAEFF4FFE7EDF3FFDEE7
            EFFFCCDAE5FFB8C9DBFFA4B8D0FF9DB3CFFF88AFD7FFBCD3E6FFD3E0EBFFE5EC
            F3FFEEF2F7FFF1F5F8FFF1F5F8FFEEF2F6FFEBEFF4FFE6ECF2FFDCE5EDFFD3DE
            EAFFCDDAE7FFC4D3E3FFB9CADCFFAFC5DAFF83A8D0FF648CBFFF455165E00303
            030600000000000000000000000000000000000000000707070F555A65F26E97
            C9FF8FB4DAFFBED5E9FFD3E1EDFFE3EAF2FFEEF2F6FFF4F8FAFFF7FAFBFFF6F9
            FBFFF2F6F9FFEFF3F7FFECF1F5FFE5EBF2FFD3DFE8FFBECEDEFFAFC0D5FFA8BC
            D4FF91B7DCFFC4D7E8FFD8E4EEFFEAEFF5FFF3F6F9FFF6F9FAFFF5F8FAFFF2F5
            F9FFEFF2F6FFEAEEF4FFDFE7EFFFD6E1EAFFD1DDE9FFC6D4E4FFBACBDDFFA2BD
            D8FF6F9ACCFF5473A3FF29292A68000000000000000000000000000000000000
            00000000000000000000383433936D8FBBFF7EA6D3FFB3CFE7FFD0DFEDFFE2EA
            F2FFEEF3F6FFF7FAFBFFFAFCFDFFF9FCFCFFF7FAFBFFF3F7F9FFF0F4F8FFEAEF
            F4FFDAE4ECFFC4D4E2FFB7C8DAFFAFC3D7FF98BDDFFFCCDCE9FFDEE8F0FFEEF3
            F7FFF6F9FAFFF8FAFBFFF7FAFAFFF5F7FAFFF1F4F8FFECF0F5FFE1E8F0FFD8E3
            ECFFD3DFE9FFC7D5E4FFB5C9DDFF8AAFD6FF6189C0FF495369E2030303070000
            0000000000000000000000000000000000000000000000000000121212276773
            87FD79A0CFFFA1C2E2FFCADDEDFFDEE9F1FFEDF2F6FFF7FAFBFFFCFCFDFFFBFC
            FDFFFAFCFCFFF6F9FBFFF3F6F9FFEDF2F6FFDFE8F0FFCBDAE6FFBDCDDEFFB6C9
            DCFF9CC0E0FFD3E0ECFFE4EBF2FFF1F5F8FFF8FAFBFFF9FBFCFFF8FAFBFFF6F9
            FAFFF2F5F9FFECF0F5FFE1E9F1FFD9E3EDFFD3DFEAFFC4D3E3FFAAC2DDFF79A3
            D6FF5879AFFF2C2C2D6B00000000000000000000000000000000000000000000
            0000000000000000000000000000494545B679A0CEFF92B7DDFFC0D9ECFFD9E6
            F0FFEAF0F5FFF5F8FAFFFBFCFDFFFCFCFDFFFAFCFDFFF9FBFCFFF5F8FAFFEFF3
            F7FFE4EBF2FFD1DEE8FFC1D1E1FFBACCDEFFAAC8E3FFDAE4EDFFE8EEF4FFF3F6
            F9FFF9FBFCFFFAFCFDFFF8FAFBFFF6F9FAFFF2F5F9FFECF0F5FFE2EAF1FFDAE4
            ECFFD3DEE9FFC2D2E2FF9FBDDFFF6F9ACFFF576681E604040408000000000000
            000000000000000000000000000000000000000000000000000000000000201F
            1E487689A3FE84AAD6FFB2CFE8FFD2E2EFFFE5EDF4FFF1F5F9FFF9FBFCFFFBFC
            FDFFFAFDFDFFFAFCFCFFF6F9FAFFF0F4F7FFE6EDF3FFD6E2EAFFC6D4E3FFC0D0
            E2FFB1CCE5FFDFE7EFFFEBEFF5FFF4F7FAFFF9FBFCFFFAFCFDFFF9FBFCFFF6F9
            FBFFF2F5F9FFECF0F5FFE2EAF1FFDAE4EDFFD2DDE9FFC0D2E3FF93B7E1FF688E
            C2FF343537740000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000015E5E62D880A7D6FF9FC2E3FFC9DD
            EEFFDFE9F2FFEDF1F7FFF6F9FBFFFAFCFDFFFBFDFDFFF9FBFCFFF5F9FAFFF1F4
            F8FFE8EDF4FFD9E4ECFFCCD9E5FFC7D6E5FFB8D1E7FFE2E9F1FFEDF1F6FFF3F6
            FAFFF8FAFBFFFAFCFDFFF9FBFCFFF6F9FAFFF1F5F8FFECEFF5FFE2E9F1FFDAE4
            EDFFD1DDE9FFB9D0E6FF84ACDAFF637794EB0606060C00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000302D2B6B7E9CC0FF8FB4DCFFBED7ECFFD6E4F0FFE6EDF3FFF0F4F8FFF6F9
            FBFFF9FBFCFFF7FAFBFFF4F8F9FFF0F3F7FFE9EDF4FFDFE8EFFFD3DFE8FFCBD9
            E7FFBFD6EAFFE6EBF2FFEDF2F6FFF3F6F9FFF6FAFBFFF8FAFBFFF7FAFBFFF4F8
            FAFFF0F4F7FFEAEFF5FFE2EAF1FFDAE4EDFFCEDCE8FFA7C6E6FF789FD0FF3B3D
            407B000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000707070E3A3E437D7693B4DEAACA
            E8FFCADDEEFFD9E6F1FFE7EEF5FFF0F4F8FFF3F7F9FFF2F6F9FFF0F4F8FFEDF1
            F6FFE9EEF5FFE2EAF1FFD8E5EDFFCCDEECFEC5DAEBFEE8EDF5FFEDF2F6FFF1F5
            F9FFF4F7FAFFF6F8FBFFF5F8FAFFF2F5F9FFEEF2F6FFE7EEF5FFDDE7F0FFD2E0
            EDFFC3D7EAFF99BDE2FC383F48750505050A0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000303030640484F727F8F9CBDB6C9D9ECD8E6F2FEE4EE
            F6FFEBF1F8FFECF2F8FFECF1F7FFEBF0F7FFE8EFF6FFE5EDF4FFDEE9F2FF8F99
            A1BD51555877E4ECF3FCEFF3F8FFF1F5F8FFF2F7F8FFF2F6FAFFF2F5F9FFEFF3
            F8FFEAF0F6FFDFE9F1FCAFBCC6DC79828BAB4A51577817191A2D000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000001111121F3032344F595D6080898F94B0B8C0C6D9D2DA
            E1ECD0D8DEE9A6ABAFC6515355740404040800000000161616264E50516F7173
            75937C7E7F9D727375935A5B5D7C3F41425F212222380707070D000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = bnHelpClick
        end
        object bnVideos: TSpeedButton
          AlignWithMargins = True
          Left = 72
          Top = 0
          Width = 54
          Height = 24
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Videos'
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            000000000000000000000101022C080C16870F1526C3161C2CE3192236E71821
            33D00D1118940202043800000000000000000000000000000000000000000000
            0000000000000B0E188E202741FF2A2A37FF272B3BFF171E32FF1D263BFF252E
            43FF293348FF293043FF11141B9B000000000000000000000000000000000000
            000011131EB4222D4FFF1C2235FF211405FF2B292AFF28344DFF282E3EFF292E
            3AFF2C323EFF2D333FFF353A47FF1F2127C10000000000000000000000000A0A
            0F8B2A304AFF202238FF212234FF20202BFF2C2A37FF3B3B49FF2E343BFF2824
            2BFF3E3540FF383B41FF2C2D32FF44454FFF1C1D229900000000010101222527
            38FF190E1DFF303C4BFF588395FF628699FF5E7C8FFF444C56FF484850FF5669
            75FF5C7E8FFF48555CFF383338FF3A3639FF585A65FF090A0B2B0F0F148F3129
            39FF3E4F5DFF68ABBEFF516D78FF4D4C51FF6B8997FF6CA8BAFF4D4950FF7895
            A1FF70BBCCFF393B3DFF453C3DFF353136FF423F47FF2B2C309A272429D34745
            53FF79C3D9FF56808DFF22090DFF261619FF58616EFF7CBFD3FF3B3A41FF687D
            8BFF5E98A6FF373232FF493636FF261A1EFF322E32FF38383EDA3E353CF46B7B
            8AFF94E1F6FF3F474FFF281C21FF271E24FF6D8693FFA0E6F5FF404852FF606E
            7AFF7EBCCBFF536D75FF69858DFF303037FF241415FF3C3A42F4453B44F4606C
            7CFF99E5FAFF3E4A50FF31262AFF444349FF4C5C69FF4E6067FF404046FF6B7B
            87FF7EBBCDFF464C59FF77919EFF83C2D2FF272930FF3E353BF73C3840D3574E
            5BFF86C6DCFF517F8AFF260F12FF4B414BFF352B35FF2A3940FF3A2E30FF6675
            7EFF70ADBFFF2C1B22FF38252BFF89DCF0FF52707CFF3C2D35DE27282C92746C
            79FF626871FF87BFD1FF566F79FF555154FF6C8C9BFF73ADC0FF4C4248FF6E89
            94FF7EC5D7FF54626CFF638B99FF6EA6B9FF4C4951FF2C272C9B040405267475
            83FF473C44FF655E64FF688B9EFF5390BDFF7091A9FF666E7DFF555664FF7687
            97FF7B8F9FFF6A7F88FF657A86FF423A44FF3C3441FF0E0E1129000000002122
            27917C7F93FF4F4242FF212739FF053A7EFF4A546FFF6A5C64FF454A58FF3E3B
            47FF564D5CFF565365FF38333FFF292732FF2C2F3D9300000000000000000000
            0000444650B98C8DA1FF454552FF2C2C37FF4E4953FF5A5967FF5A5D6AFF4A47
            53FF4A4259FF3F3B5AFF262741FF2F374AB80000000000000000000000000000
            0000000000002D2F3892777588FF786F79FF49434DFF3D3A48FF534959FF4B4A
            5BFF3D6068FF33555FFA22394687000000000000000000000000000000000000
            0000000000000000000007070832292930903E3C45CE5D5D6AE9545868EA3446
            50CF183B32860916122000000000000000000000000000000000}
          OnClick = bnVideosClick
        end
        object bnGitHub: TSpeedButton
          AlignWithMargins = True
          Left = 206
          Top = 0
          Width = 60
          Height = 24
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'GitHub'
          Flat = True
          Glyph.Data = {
            66060000424D6606000000000000360000002800000016000000120000000100
            2000000000003006000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000A0A0A134D493D6F908566B1BB9A6BDCDAB77EF3E6C2
            84FCDEBA7FF6C19F6EE19A8E6BBA5954457C1111101F00000000000000000000
            0000000000000000000000000000000000000000000000000000000000001414
            1324D7C48FECF0DA9CFFEED597FFDCB479FF806D4FFFDBC189FF806D4FFFDDB5
            7AFFEED496FFF0DA9CFFE6D096F72A2823430000000000000000000000000000
            000000000000000000000000000000000000000000001111101FCDBB89E4F0DA
            9CFF9A8C67FF6D634CFF5A5443FF5D5644FF585242FF6D634CFF9A8B67FFF0DA
            9CFFDFCB92F224231F3B00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000606060B3F3C335E7D745BA22222
            22FE544E40F4514C3EF9554F40F5222222FE857B5FAA4A463A6B0B0B0A140000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000010101031F1F20FA29292AB32626
            27BC29292AB31F1F20FA01010103000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00002323236334322DE4302D29F01F1F20FD282828C2262627BC272727C51F1F
            20FD010101030000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000001514132416161636393833B40707
            070F0606060C252525D61F1F20FF212122F01E1E1FFF202021D6000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000111111262F2E2C8E080808100E0E0E20242425703336
            3AC13A404AFF3E4550FF3B414BFF363A3FC32727287611111127000000000000
            000000000000000000000000000000000000000000000707070E000000000000
            0000000000000000000026262681515967FBA1B8DDFFB1CAF4FFAEC7F2FF9DB3
            E5FFB0C9F3FFB1CAF4FFA7BFE6FF535D6DFD2626278600000000000000000000
            0000000000000707070E000000000A0A0A171010102610101027101010262222
            226B2C2E33FFAEC6EFFFC2CBE8FFB5C2E6FFB1CAF4FFA0B7E7FFB1CAF4FFB5C3
            E7FFC1C9E6FFACC3EBFF242527FE1F1F1F5B1010102610101026101010260A0A
            0A170000000000000000000000000000000000000000292929B3404550FFB4CC
            F4FFA7ACD4FF8B95CBFFB1CAF4FFB1CAF4FFB1CAF4FF9CA6D5FF8D95C8FFB8CE
            F4FF303339FF2828288B00000000000000000000000000000000000000000000
            0000000000000000000000000000262626D6232426FF98ADD1FFCAD7F3FFC0D1
            F1FFB1CAF4FFB1CAF4FFB1CAF4FFBFD0F2FFCBD8F2FF8B9FC0FF1F1F20FF2929
            29A3000000000000000000000000000000000000000000000000000000000000
            000000000000262627CF1F1F20FF282A2FFF555F71FF5B667AFF525C6EFF4E57
            67FF535D6FFF5C677BFF525C6DFF242629FF1F1F20FF2929299B000000000000
            0000000000000000000000000000000000000000000000000000000000002727
            27831F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F
            20FF1F1F20FF1F1F20FF1F1F20FF1E1E1F520000000000000000000000000000
            000000000000000000000000000000000000000000000505050A212122F01F1F
            20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F
            20FF282828B50000000000000000000000000000000000000000000000000000
            0000000000000000000000000000020202041F1F20FE1F1F20FF1F1F20FE1F1F
            20FE1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF1F1F20FF29292A9E0000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000242424DD262627C41D1D1D4C0D0D0D1E1A1A1A431D1D
            1D4F19191A410F0F0F2326262681232324E42626267C00000000000000000000
            00000000000000000000}
          OnClick = bnGitHubClick
        end
        object bnDiscord: TSpeedButton
          AlignWithMargins = True
          Left = 268
          Top = 0
          Width = 62
          Height = 24
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alLeft
          Constraints.MaxWidth = 62
          Caption = 'Discord'
          Flat = True
          Glyph.Data = {
            76050000424D7605000000000000360000002800000015000000100000000100
            2000000000004005000000000000000000000000000000000000000000000201
            0102452C2451996050B3C67D68E8633E34740000000000000000000000000000
            0000000000000000000000000000000000006942377BC67D68E8955D4EAE4229
            224D020101020000000000000000130C0A16A26655BEDA8972FFDA8972FFD888
            71FD8654469D0302010319100D1D3F28214A51332A5F51332A5F462C25522014
            1125030202047F504395D1846EF5DA8972FFDA8972FF9C6251B6130C0A160000
            0000AB6B59C8DA8972FFDA8972FFC77D68E9432A234E643F3475B6725FD5DA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFBD7763DD6B43387D3622
            1C3FB5725FD4DA8972FFDA8972FFAB6B59C800000000DA8972FFDA8972FFDA89
            72FF9C6251B6CC806BEFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFCC806BEF925C4CABDA8972FFDA89
            72FFDA8972FF00000000C77D68E9DA8972FFDA8972FFDA8972FFDA8972FFA96A
            59C64A2F2757633E3474CE816CF1DA8972FFDA8972FFCE816CF15C3A306C5133
            2A5FBB7662DBDA8972FFDA8972FFDA8972FFDA8972FFBA7561D900000000B370
            5DD1DA8972FFDA8972FFDA8972FFDA8972FF120B091500000000000000007247
            3B85DA8972FFDA8972FF55362D64000000000000000038231D41DA8972FFDA89
            72FFDA8972FFDA8972FFAC6C5AC9000000008A5648A1DA8972FFDA8972FFDA89
            72FFDA8972FF00000000000000000000000052342B60DA8972FFDA8972FF2C1C
            17340000000000000000110B0914DA8972FFDA8972FFDA8972FFDA8972FF8A56
            48A100000000603C3270DA8972FFDA8972FFDA8972FFDA8972FF2D1C18350000
            0000000000008F5A4BA7DA8972FFDA8972FF71473B8400000000000000004C30
            2859DA8972FFDA8972FFDA8972FFDA8972FF59382E6800000000301E1938DA89
            72FFDA8972FFDA8972FFDA8972FFC67D68E8764A3E8A905B4CA9DA8972FFDA89
            72FFDA8972FFD78770FB8855479F7F504294D1836DF4DA8972FFDA8972FFDA89
            72FFDA8972FF291A15300000000001010001C27A65E3DA8972FFDA8972FFDA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFC27A65E3010100010000
            0000000000007F504294DA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA89
            72FFDA8972FFDA8972FF7F50429400000000000000000000000033201B3CDA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFD88871FD321F
            1A3A00000000000000000000000002010102A56856C1A36755BFDA8972FFDA89
            72FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA8972FFDA89
            72FFDA8972FFD4856FF8A26655BEB06F5CCE0000000000000000000000000000
            0000000000002517132B8654469D4B2F27587E4F4293B87460D7D5866FF9DA89
            72FFDA8972FFDA8972FFDA8972FFD1846EF5B06F5CCE674036785B392F6A9C62
            52B72417132A0000000000000000000000000000000000000000000000000302
            0204472D255355352C6336221C3F120B09152A1A16313C261F463C261F462A1A
            1631150D0B1951332A5F73493C874A2F27570302020400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = bnDiscordClick
        end
      end
    end
    object pnlNav: TPanel
      Left = 0
      Top = 30
      Width = 455
      Height = 603
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 3
      OnResize = pnlNavResize
      object pnlNavContent: TPanel
        Left = 0
        Top = 0
        Width = 455
        Height = 603
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblFilterHint: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 28
          Width = 449
          Height = 26
          Margins.Bottom = 9
          Align = alTop
          Caption = 
            'A filter has been applied. The treeview contents is fossilized a' +
            'nd will not adjust structure to changes.  Please remove or re-ap' +
            'ply the filter if necessary.'
          Visible = False
          WordWrap = True
          ExplicitWidth = 440
        end
        object vstNav: TVirtualEditTree
          Left = 0
          Top = 63
          Width = 455
          Height = 511
          Align = alClient
          BevelInner = bvNone
          Colors.SelectionRectangleBlendColor = clGray
          Colors.SelectionRectangleBorderColor = clBlack
          DefaultText = 'Node'
          Header.AutoSizeIndex = 2
          Header.Height = 21
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
          Header.PopupMenu = pmuNavHeaderPopup
          Header.SortColumn = 0
          HintMode = hmTooltip
          IncrementalSearch = isVisibleOnly
          NodeDataSize = 8
          ParentShowHint = False
          SelectionBlendFactor = 80
          SelectionCurveRadius = 3
          ShowHint = True
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSort, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale, toAutoFreeOnCollapse]
          TreeOptions.MiscOptions = [toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toPopupMode, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toRightClickSelect]
          TreeOptions.StringOptions = [toShowStaticText, toAutoAcceptEditChange]
          OnBeforeItemErase = vstNavBeforeItemErase
          OnChange = vstNavChange
          OnCompareNodes = vstNavCompareNodes
          OnExpanding = vstNavExpanding
          OnFocusChanged = vstNavFocusChanged
          OnFreeNode = vstNavFreeNode
          OnGetText = vstNavGetText
          OnPaintText = vstNavPaintText
          OnHeaderClick = vstNavHeaderClick
          OnIncrementalSearch = vstNavIncrementalSearch
          OnInitChildren = vstNavInitChildren
          OnInitNode = vstNavInitNode
          OnKeyDown = vstNavKeyDown
          OnKeyPress = vstNavKeyPress
          Columns = <
            item
              Position = 0
              Text = 'FormID'
              Width = 201
            end
            item
              Position = 1
              Text = 'EditorID'
              Width = 125
            end
            item
              Position = 2
              Text = 'Name'
              Width = 125
            end>
        end
        object pnlSearch: TPanel
          Left = 0
          Top = 0
          Width = 455
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object pnlNavTopFormID: TPanel
            Left = 0
            Top = 0
            Width = 123
            Height = 25
            Align = alLeft
            AutoSize = True
            BevelOuter = bvNone
            Padding.Left = 3
            Padding.Right = 3
            Padding.Bottom = 3
            TabOrder = 0
            object edFormIDSearch: TLabeledEdit
              Left = 41
              Top = 0
              Width = 79
              Height = 21
              EditLabel.Width = 35
              EditLabel.Height = 13
              EditLabel.Caption = '&FormID'
              LabelPosition = lpLeft
              TabOrder = 0
              StyleElements = [seFont, seBorder]
              OnChange = edFormIDSearchChange
              OnEnter = edFormIDSearchEnter
              OnKeyDown = edFormIDSearchKeyDown
            end
          end
          object pnlNavTopEditorID: TPanel
            Left = 123
            Top = 0
            Width = 332
            Height = 25
            Align = alClient
            BevelOuter = bvNone
            Padding.Left = 3
            Padding.Right = 3
            Padding.Bottom = 3
            TabOrder = 1
            DesignSize = (
              332
              25)
            object edEditorIDSearch: TLabeledEdit
              Left = 64
              Top = 0
              Width = 267
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 42
              EditLabel.Height = 13
              EditLabel.Caption = '&Editor ID'
              LabelPosition = lpLeft
              TabOrder = 0
              StyleElements = [seFont, seBorder]
              OnChange = edEditorIDSearchChange
              OnEnter = edEditorIDSearchEnter
              OnKeyDown = edEditorIDSearchKeyDown
            end
          end
        end
        object pnlNavBottom: TPanel
          Left = 0
          Top = 574
          Width = 455
          Height = 29
          Align = alBottom
          Alignment = taLeftJustify
          BevelOuter = bvNone
          BevelWidth = 3
          TabOrder = 2
          DesignSize = (
            455
            29)
          object edFileNameFilter: TLabeledEdit
            Left = 98
            Top = 6
            Width = 356
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.AlignWithMargins = True
            EditLabel.Width = 86
            EditLabel.Height = 13
            EditLabel.Caption = 'F&ilter by filename:'
            EditLabel.Layout = tlCenter
            LabelPosition = lpLeft
            TabOrder = 0
            OnChange = edFileNameFilterChange
            OnKeyDown = edFileNameFilterKeyDown
            OnKeyPress = edFilterNoBeepOnEnterKeyPress
          end
        end
      end
    end
  end
  object pnlCancel: TPanel
    Left = 403
    Top = 280
    Width = 318
    Height = 153
    BevelInner = bvLowered
    BevelKind = bkSoft
    BorderWidth = 50
    BorderStyle = bsSingle
    TabOrder = 1
    Visible = False
    object btnCancel: TButton
      Left = 52
      Top = 52
      Width = 206
      Height = 41
      Align = alClient
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
  end
  object tmrStartup: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrStartupTimer
    Left = 56
    Top = 496
  end
  object tmrMessages: TTimer
    Interval = 500
    OnTimer = tmrMessagesTimer
    Left = 56
    Top = 544
  end
  object pmuNav: TPopupMenu
    OnPopup = pmuNavPopup
    Left = 152
    Top = 136
    object mniNavCompareTo: TMenuItem
      Caption = 'Compare to...'
      OnClick = mniNavCompareToClick
    end
    object mniNavCreateDeltaPatch: TMenuItem
      Caption = 'Create delta patch using...'
      OnClick = mniNavCreateDeltaPatchClick
    end
    object mniNavCompareSelected: TMenuItem
      Caption = 'Compare Selected'
      OnClick = mniNavCompareSelectedClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mniNavFilterRemove: TMenuItem
      Caption = 'Remove Filter'
      OnClick = mniNavFilterRemoveClick
    end
    object mniNavFilterApply: TMenuItem
      Caption = 'Apply Filter'
      OnClick = mniNavFilterApplyClick
    end
    object mniNavFilterForCleaning: TMenuItem
      Caption = 'Apply Filter for Cleaning'
      OnClick = mniNavFilterForCleaningClick
    end
    object mniNavFilterForCleaningObsolete: TMenuItem
      Caption = 'Apply Filter for Cleaning'
      OnClick = mniNavCleaningObsoleteClick
    end
    object mniNavFilterConflicts: TMenuItem
      Caption = 'Apply Filter to show Conflicts'
      OnClick = mniNavFilterConflictsClick
    end
    object N25: TMenuItem
      Caption = '-'
    end
    object mniNavFilterApplySelected: TMenuItem
      Caption = 'Apply Filter (selected files only)'
      OnClick = mniNavFilterApplyClick
    end
    object mniNavFilterForCleaningSelected: TMenuItem
      Caption = 'Apply Filter for Cleaning (selected files only)'
      OnClick = mniNavFilterForCleaningClick
    end
    object mniNavFilterForCleaningSelectedObsolete: TMenuItem
      Caption = 'Apply Filter for Cleaning (selected files only)'
      OnClick = mniNavCleaningObsoleteClick
    end
    object mniNavFilterConflictsSelected: TMenuItem
      Caption = 'Apply Filter to show Conflicts (selected files only)'
      OnClick = mniNavFilterConflictsClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mniNavCheckForErrors: TMenuItem
      Caption = 'Check for Errors'
      OnClick = mniNavCheckForErrorsClick
    end
    object mniNavCheckForCircularLeveledLists: TMenuItem
      Caption = 'Check for Circular Leveled Lists'
      OnClick = mniNavCheckForCircularLeveledListsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mniNavChangeFormID: TMenuItem
      Caption = 'Change FormID'
      OnClick = mniNavChangeFormIDClick
    end
    object mniNavChangeReferencingRecords: TMenuItem
      Caption = 'Change Referencing Records'
      OnClick = mniNavChangeReferencingRecordsClick
    end
    object mniNavRenumberFormIDsFrom: TMenuItem
      Caption = 'Renumber FormIDs from...'
      OnClick = mniNavRenumberFormIDsFromClick
    end
    object mniNavCompactFormIDs: TMenuItem
      Caption = 'Compact FormIDs for ESL'
      OnClick = mniNavRenumberFormIDsFromClick
    end
    object mniNavRenumberFormIDsInject: TMenuItem
      Caption = 'Inject Forms into master...'
      OnClick = mniNavRenumberFormIDsFromClick
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object mniNavApplyScript: TMenuItem
      Caption = 'Apply Script...'
      OnClick = mniNavApplyScriptClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object mniNavUndeleteAndDisableReferences: TMenuItem
      Caption = 'Undelete and Disable References'
      OnClick = mniNavUndeleteAndDisableReferencesClick
    end
    object mniNavUndeleteAndDisableReferencesObsolete: TMenuItem
      Caption = 'Undelete and Disable References'
      OnClick = mniNavCleaningObsoleteClick
    end
    object mniNavRemoveIdenticalToMaster: TMenuItem
      Caption = 'Remove "Identical to Master" records'
      OnClick = mniNavRemoveIdenticalToMasterClick
    end
    object mniNavRemoveIdenticalToMasterObsolete: TMenuItem
      Caption = 'Remove "Identical to Master" records'
      OnClick = mniNavCleaningObsoleteClick
    end
    object mniNavLOManagersDirtyInfo: TMenuItem
      Caption = 'BOSS/LOOT Cleaning Report'
      OnClick = mniNavLOManagersDirtyInfoClick
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object mniNavSetVWDAuto: TMenuItem
      Caption = 'Set VWD for all REFR with VWD Mesh in this file'
      OnClick = mniNavSetVWDAutoClick
    end
    object mniNavSetVWDAutoInto: TMenuItem
      Caption = 'Set VWD for all REFR with VWD Mesh as Override into....'
      OnClick = mniNavSetVWDAutoIntoClick
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object mniNavCellChildTemp: TMenuItem
      Caption = 'Temporary'
      GroupIndex = 1
      RadioItem = True
      OnClick = mniNavCellChild
    end
    object mniNavCellChildPers: TMenuItem
      Caption = 'Persistent'
      GroupIndex = 2
      RadioItem = True
      OnClick = mniNavCellChild
    end
    object mniNavCellChildNotVWD: TMenuItem
      Caption = 'not Visible When Distant'
      GroupIndex = 3
      OnClick = mniNavCellChild
    end
    object mniNavCellChildVWD: TMenuItem
      Caption = 'Visible When Distant'
      GroupIndex = 4
      OnClick = mniNavCellChild
    end
    object N5: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavAdd: TMenuItem
      Caption = 'Add'
      GroupIndex = 4
      OnClick = mniNavAddClick
    end
    object mniNavRemove: TMenuItem
      Caption = 'Remove'
      GroupIndex = 4
      OnClick = mniNavRemoveClick
    end
    object mniNavMarkModified: TMenuItem
      Caption = 'Mark Modified'
      GroupIndex = 4
      OnClick = mniNavMarkModifiedClick
    end
    object N6: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavAddMasters: TMenuItem
      Caption = 'Add Masters...'
      GroupIndex = 4
      OnClick = mniNavAddMastersClick
    end
    object mniNavSortMasters: TMenuItem
      Caption = 'Sort Masters (to match current load order)'
      GroupIndex = 4
      OnClick = mniNavSortMastersClick
    end
    object mniNavCleanMasters: TMenuItem
      Caption = 'Clean Masters (= Remove all unused Masters)'
      GroupIndex = 4
      OnClick = mniNavCleanMastersClick
    end
    object N23: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavCreateModGroup: TMenuItem
      Caption = 'Create ModGroup...'
      GroupIndex = 4
      OnClick = mniNavCreateModGroupClick
    end
    object mniNavEditModGroup: TMenuItem
      Caption = 'Edit ModGroup...'
      GroupIndex = 4
      OnClick = mniNavEditModGroupClick
    end
    object mniNavDeleteModGroups: TMenuItem
      Caption = 'Delete ModGroups...'
      GroupIndex = 4
      OnClick = mniNavDeleteModGroupsClick
    end
    object mniNavUpdateCRCModGroups: TMenuItem
      Caption = 'Update CRC in ModGroups...'
      GroupIndex = 4
      OnClick = mniNavUpdateCRCModGroupsClick
    end
    object N4: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavCopyAsOverride: TMenuItem
      Caption = 'Copy as override into....'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCopyAsOverrideWithOverwrite: TMenuItem
      Caption = 'Copy as override (with overwriting) into....'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavDeepCopyAsOverride: TMenuItem
      Caption = 'Deep copy as override into....'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavDeepCopyAsOverrideWithOverwriting: TMenuItem
      Caption = 'Deep copy as override (with overwriting) into....'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCopyAsNewRecord: TMenuItem
      Caption = 'Copy as new record into...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCopyAsSpawnRateOverride: TMenuItem
      Caption = 'Copy as override (spawn rate plugin) into...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCopyAsWrapper: TMenuItem
      Caption = 'Copy as wrapper into...'
      GroupIndex = 4
      OnClick = mniNavCopyIntoClick
    end
    object mniNavCleanupInjected: TMenuItem
      Caption = 'Cleanup references to injected records'
      GroupIndex = 4
      OnClick = mniNavCleanupInjectedClick
    end
    object mniNavCopyIdle: TMenuItem
      Caption = 'Copy Idle Animations into...'
      GroupIndex = 4
      OnClick = mniNavCopyIdleClick
    end
    object N10: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavHidden: TMenuItem
      AutoCheck = True
      Caption = 'Hidden'
      GroupIndex = 4
      OnClick = mniNavHiddenClick
    end
    object N16: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniNavTest: TMenuItem
      Caption = 'Test'
      GroupIndex = 4
      OnClick = mniNavTestClick
    end
    object mniNavBanditFix: TMenuItem
      Caption = 'Bandit Fix'
      GroupIndex = 4
      Visible = False
      OnClick = mniNavBanditFixClick
    end
    object mniNavOther: TMenuItem
      Caption = 'Other'
      GroupIndex = 4
      object mniNavCreateMergedPatch: TMenuItem
        Caption = 'Create Merged Patch'
        GroupIndex = 4
        OnClick = mniNavCreateMergedPatchClick
      end
      object mniNavCreateSEQFile: TMenuItem
        Caption = 'Create SEQ File'
        GroupIndex = 4
        OnClick = mniNavCreateSEQFileClick
      end
      object mniNavGenerateLOD: TMenuItem
        Caption = 'Generate LOD'
        GroupIndex = 4
        OnClick = mniNavGenerateLODClick
      end
      object mniNavBuildRef: TMenuItem
        Caption = 'Build Reference Info'
        GroupIndex = 4
        OnClick = mniNavBuildRefClick
      end
      object mniNavBuildReachable: TMenuItem
        Caption = 'Build Reachable Info'
        GroupIndex = 4
        OnClick = mniNavBuildReachableClick
      end
      object mniNavBatchChangeReferencingRecords: TMenuItem
        Caption = 'Batch Change Referencing Records'
        GroupIndex = 4
        OnClick = mniNavBatchChangeReferencingRecordsClick
      end
      object mniNavRaceLVLIs: TMenuItem
        Caption = 'Fixup Race-specific LVLIs'
        GroupIndex = 4
        Visible = False
        OnClick = mniNavRaceLVLIsClick
      end
      object mniNavLocalization: TMenuItem
        Caption = 'Localization'
        GroupIndex = 4
        object mniNavLocalizationSwitch: TMenuItem
          Caption = 'Localize'
          GroupIndex = 4
          OnClick = mniNavLocalizationSwitchClick
        end
      end
      object mniNavLogAnalyzer: TMenuItem
        Caption = 'Log Analyzer'
        GroupIndex = 4
      end
      object mniMarkallfileswithoutONAMasmodified: TMenuItem
        Caption = 'Mark all files without ONAM as modified'
        GroupIndex = 4
        OnClick = mniMarkallfileswithoutONAMasmodifiedClick
      end
      object N13: TMenuItem
        Caption = '-'
        GroupIndex = 4
      end
      object mniNavOptions: TMenuItem
        Caption = 'Options'
        GroupIndex = 4
        OnClick = mniNavOptionsClick
      end
      object mniNavOtherCodeSiteLogging: TMenuItem
        Caption = 'CodeSite logging'
        GroupIndex = 4
        OnClick = mniNavOtherCodeSiteLoggingClick
      end
    end
  end
  object pmuView: TPopupMenu
    OnPopup = pmuViewPopup
    Left = 760
    Top = 216
    object mniViewEdit: TMenuItem
      Caption = 'Edit'
      OnClick = mniViewEditClick
    end
    object mniViewAdd: TMenuItem
      Caption = 'Add'
      OnClick = mniViewAddClick
    end
    object N26: TMenuItem
      Caption = '-'
    end
    object mniViewRemove: TMenuItem
      Caption = 'Remove'
      OnClick = mniViewRemoveClick
    end
    object mniViewRemoveFromSelected: TMenuItem
      Caption = 'Remove from selected records'
      OnClick = mniViewRemoveFromSelectedClick
    end
    object N27: TMenuItem
      Caption = '-'
    end
    object mniViewNextMember: TMenuItem
      Caption = 'Next Member'
      OnClick = mniViewNextMemberClick
    end
    object mniViewPreviousMember: TMenuItem
      Caption = 'Previous Member'
      OnClick = mniViewPreviousMemberClick
    end
    object N28: TMenuItem
      Caption = '-'
    end
    object mniViewSetToDefault: TMenuItem
      Caption = 'Reset structure'
      OnClick = mniViewSetToDefaultClick
    end
    object N29: TMenuItem
      Caption = '-'
    end
    object mniViewCopyToSelectedRecords: TMenuItem
      Caption = 'Copy to selected records'
      OnClick = mniViewCopyToSelectedRecordsClick
    end
    object mniViewCopyMultipleToSelectedRecords: TMenuItem
      Caption = 'Copy multiple to selected records'
      OnClick = mniViewCopyMultipleToSelectedRecordsClick
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object mniViewMoveUp: TMenuItem
      Caption = 'Move &up'
      OnClick = mniViewMoveUpClick
    end
    object mniViewMoveDown: TMenuItem
      Caption = 'Move &down'
      OnClick = mniViewMoveDownClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object mniViewSort: TMenuItem
      Caption = 'Sort by this row'
      OnClick = mniViewSortClick
    end
    object mniViewCompareReferencedRow: TMenuItem
      Caption = 'Compare referenced records in this row'
      OnClick = mniViewCompareReferencedRowClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object mniViewHideNoConflict: TMenuItem
      Caption = 'Hide no conflict and empty rows'
      OnClick = mniViewHideNoConflictClick
    end
    object mniViewStick: TMenuItem
      Caption = 'Stick to'
      object mniViewStickAuto: TMenuItem
        Caption = 'Auto Top Row'
        OnClick = mniViewStickAutoClick
      end
      object mniViewStickSelected: TMenuItem
        Caption = 'Selected Row'
        OnClick = mniViewStickSelectedClick
      end
    end
    object ColumnWidths1: TMenuItem
      Caption = 'Column Widths'
      object mniViewColumnWidthStandard: TMenuItem
        AutoCheck = True
        Caption = 'Standard'
        RadioItem = True
        OnClick = mniViewColumnWidthClick
      end
      object mniViewColumnWidthFitAll: TMenuItem
        AutoCheck = True
        Caption = 'Fit All'
        RadioItem = True
        OnClick = mniViewColumnWidthClick
      end
      object mniViewColumnWidthFitText: TMenuItem
        AutoCheck = True
        Caption = 'Fit Text'
        RadioItem = True
        OnClick = mniViewColumnWidthClick
      end
      object mniViewColumnWidthFitSmart: TMenuItem
        AutoCheck = True
        Caption = 'Fit Smart'
        RadioItem = True
        OnClick = mniViewColumnWidthClick
      end
    end
    object mniModGroups: TMenuItem
      Caption = 'ModGroups'
      OnClick = mniModGroupsClick
      object mniModGroupsEnabled: TMenuItem
        Caption = 'Enabled'
        Checked = True
        GroupIndex = 1
        RadioItem = True
        OnClick = mniModGroupsAbleClick
      end
      object mniModGroupsDisabled: TMenuItem
        Caption = 'Disabled'
        GroupIndex = 1
        RadioItem = True
        OnClick = mniModGroupsAbleClick
      end
      object N22: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object mniViewModGroupsReload: TMenuItem
        Caption = 'Reload ModGroups'
        GroupIndex = 1
        OnClick = mniViewModGroupsReloadClick
      end
    end
    object mniMasterAndLeafs: TMenuItem
      Caption = 'Only Master and Leafs'
      object mniMasterAndLeafsEnabled: TMenuItem
        Caption = 'Enabled'
        Checked = True
        GroupIndex = 1
        RadioItem = True
        OnClick = mniMasterAndLeafsClick
      end
      object mniMasterAndLeafsDisabled: TMenuItem
        Caption = 'Disabled'
        GroupIndex = 1
        RadioItem = True
        OnClick = mniMasterAndLeafsClick
      end
    end
  end
  object ActionList1: TActionList
    Left = 368
    Top = 88
    object acBack: TAction
      OnExecute = acBackExecute
      OnUpdate = acBackUpdate
    end
    object acForward: TAction
      OnExecute = acForwardExecute
      OnUpdate = acForwardUpdate
    end
    object acScript: TAction
      Caption = 'acScript'
      OnExecute = acScriptExecute
    end
  end
  object odModule: TOpenDialog
    Filter = 
      'Plugin Files (*.esm;*.esl;*.esp;*.esu)|*.esm;*.esl;*.esp;*.esu|S' +
      'ave Files (*.ess;*.fos)|*.ess;*.fos|CoSave Files (*.obse;*.fose;' +
      '*.nvse;*.skse)|*.obse;*.fose;*.nvse;*.skse|All Files (*.*)|*.*'
    Options = [ofReadOnly, ofPathMustExist, ofFileMustExist, ofNoTestFileCreate, ofEnableSizing]
    Left = 352
    Top = 384
  end
  object pmuSpreadsheet: TPopupMenu
    OnPopup = pmuSpreadsheetPopup
    Left = 680
    Top = 616
    object mniSpreadsheetCompareSelected: TMenuItem
      Caption = 'Compare Selected'
      OnClick = mniSpreadsheetCompareSelectedClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object mniSpreadsheetRebuild: TMenuItem
      Caption = 'Rebuild'
      OnClick = mniSpreadsheetRebuildClick
    end
  end
  object pmuViewHeader: TPopupMenu
    OnPopup = pmuViewHeaderPopup
    Left = 664
    Top = 136
    object mniViewHeaderCopyAsOverride: TMenuItem
      Caption = 'Copy as override into....'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderCopyAsOverrideWithOverwriting: TMenuItem
      Caption = 'Copy as override (with overwriting) into....'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderDeepCopyAsOverride: TMenuItem
      Caption = 'Deep copy as override into....'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderDeepCopyAsOverrideWithOverwriting: TMenuItem
      Caption = 'Deep copy as override (with overwriting) into....'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderCopyAsNewRecord: TMenuItem
      Caption = 'Copy as new record into...'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderCopyAsWrapper: TMenuItem
      Caption = 'Copy as wrapper into...'
      OnClick = mniViewHeaderCopyIntoClick
    end
    object mniViewHeaderRemove: TMenuItem
      Caption = 'Remove'
      OnClick = mniViewHeaderRemoveClick
    end
    object mniViewHeaderJumpTo: TMenuItem
      Caption = 'Jump to'
      OnClick = mniViewHeaderJumpToClick
    end
    object N24: TMenuItem
      Caption = '-'
    end
    object mniViewCreateModGroup: TMenuItem
      Caption = 'Create ModGroup...'
      OnClick = mniNavCreateModGroupClick
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object mniViewHeaderHidden: TMenuItem
      AutoCheck = True
      Caption = 'Hide'
      OnClick = mniViewHeaderHiddenClick
    end
    object mniViewHeaderUnhideAll: TMenuItem
      Caption = 'Unhide all...'
      OnClick = mniViewHeaderUnhideAllClick
    end
  end
  object tmrCheckUnsaved: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = tmrCheckUnsavedTimer
    Left = 56
    Top = 400
  end
  object pmuNavHeaderPopup: TPopupMenu
    OnPopup = pmuNavHeaderPopupPopup
    Left = 152
    Top = 88
    object mniNavHeaderFiles: TMenuItem
      Caption = 'Files'
      object mniNavHeaderFilesDefault: TMenuItem
        AutoCheck = True
        Caption = 'as selected'
        Checked = True
        RadioItem = True
        OnClick = mniNavHeaderFilesClick
      end
      object mniNavHeaderFilesLoadOrder: TMenuItem
        AutoCheck = True
        Caption = 'always by load order'
        RadioItem = True
        OnClick = mniNavHeaderFilesClick
      end
      object mniNavHeaderFilesFileName: TMenuItem
        AutoCheck = True
        Caption = 'always by file name'
        RadioItem = True
        OnClick = mniNavHeaderFilesClick
      end
    end
    object mniNavHeaderINFO: TMenuItem
      Caption = 'Dialog Topics'
      object mniNavHeaderINFObyPreviousINFO: TMenuItem
        AutoCheck = True
        Caption = 'by Previous INFO'
        Checked = True
        RadioItem = True
        OnClick = mniNavHeaderINFOClick
      end
      object mniNavHeaderINFObyFormID: TMenuItem
        AutoCheck = True
        Caption = 'by FormID'
        RadioItem = True
        OnClick = mniNavHeaderINFOClick
      end
    end
  end
  object odCSV: TOpenDialog
    Filter = 'CSV (*.csv)|*.csv|All Files (*.*)|*.*'
    Options = [ofReadOnly, ofPathMustExist, ofFileMustExist, ofNoTestFileCreate, ofEnableSizing]
    Left = 352
    Top = 440
  end
  object pmuRefBy: TPopupMenu
    OnPopup = pmuRefByPopup
    Left = 760
    Top = 160
    object mniRefByCompareSelected: TMenuItem
      Caption = 'Compare Selected'
      OnClick = mniRefByCompareSelectedClick
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object mniRefByCopyOverrideInto: TMenuItem
      Caption = 'Copy as override into....'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByCopyOverrideIntoWithOverwriting: TMenuItem
      Caption = 'Copy as override (with overwriting) into....'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByDeepCopyOverrideInto: TMenuItem
      Caption = 'Deep copy as override into....'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByDeepCopyOverrideIntoWithOverwriting: TMenuItem
      Caption = 'Deep copy as override (with overwriting) into....'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByCopyAsNewInto: TMenuItem
      Caption = 'Copy as new record into...'
      OnClick = mniRefByCopyIntoClick
    end
    object mniRefByCopyDisabledOverrideInto: TMenuItem
      Caption = 'Copy as disabled override into....'
      OnClick = mniRefByCopyDisabledOverrideIntoClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object mniRefByRemove: TMenuItem
      Caption = 'Remove'
      OnClick = mniRefByRemoveClick
    end
    object mniRefByMarkModified: TMenuItem
      Caption = 'Mark Modified'
      OnClick = mniRefByMarkModifiedClick
    end
    object mniRefByVWD: TMenuItem
      Caption = 'Visible When Distant'
      OnClick = mniRefByVWDClick
    end
    object mniRefByNotVWD: TMenuItem
      Caption = 'not Visible When Distant'
      OnClick = mniRefByVWDClick
    end
  end
  object pmuNavAdd: TPopupMenu
    Left = 152
    Top = 184
  end
  object tmrGenerator: TTimer
    Enabled = False
    OnTimer = tmrGeneratorTimer
    Left = 56
    Top = 448
  end
  object pmuMessages: TPopupMenu
    Left = 760
    Top = 272
    object mniMessagesClear: TMenuItem
      Caption = 'Clear'
      OnClick = mniMessagesClearClick
    end
    object mniMessagesSaveSelected: TMenuItem
      Caption = 'Save selected text'
      OnClick = mniMessagesSaveSelectedClick
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object mniMessagesAutoscroll: TMenuItem
      AutoCheck = True
      Caption = 'Autoscroll to the last message'
      Checked = True
    end
  end
  object tmrUpdateColumnWidths: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrUpdateColumnWidthsTimer
    Left = 192
    Top = 408
  end
  object tmrPendingSetActive: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrPendingSetActiveTimer
    Left = 192
    Top = 456
  end
  object jbhPatreon: TJvBalloonHint
    DefaultBalloonPosition = bpLeftDown
    DefaultHeader = 'Patreon'
    OnBalloonClick = jbhPatreonBalloonClick
    OnCloseBtnClick = jbhPatreonCloseBtnClick
    Left = 1301
    Top = 105
  end
  object jbhGitHub: TJvBalloonHint
    DefaultBalloonPosition = bpLeftDown
    DefaultHeader = 'GitHub'
    OnBalloonClick = jbhGitHubBalloonClick
    OnCloseBtnClick = jbhGitHubCloseBtnClick
    Left = 1173
    Top = 105
  end
  object jbhNexusMods: TJvBalloonHint
    DefaultBalloonPosition = bpLeftDown
    DefaultHeader = 'NexusMods'
    OnBalloonClick = jbhNexusModsBalloonClick
    OnCloseBtnClick = jbhNexusModsCloseBtnClick
    Left = 1073
    Top = 105
  end
  object pmuMain: TPopupMenu
    OnPopup = pmuMainPopup
    Left = 208
    Top = 280
    object mniMainLocalization: TMenuItem
      Caption = 'Localization'
      GroupIndex = 4
      object mniMainLocalizationLanguage: TMenuItem
        Caption = 'Language'
        GroupIndex = 4
      end
      object mniMainLocalizationEditor: TMenuItem
        Caption = 'Editor'
        GroupIndex = 4
        OnClick = mniMainLocalizationEditorClick
      end
    end
    object mniMainPluggyLink: TMenuItem
      Caption = 'Pluggy Link'
      GroupIndex = 4
      object mniMainPluggyLinkDisabled: TMenuItem
        Caption = 'Disabled'
        Checked = True
        RadioItem = True
        OnClick = mniMainPluggyLinkClick
      end
      object mniMainPluggyLinkReference: TMenuItem
        Tag = 1
        Caption = 'Reference'
        RadioItem = True
        OnClick = mniMainPluggyLinkClick
      end
      object mniMainPluggyLinkBaseObject: TMenuItem
        Tag = 2
        Caption = 'Base Object'
        RadioItem = True
        OnClick = mniMainPluggyLinkClick
      end
      object mniMainPluggyLinkInventory: TMenuItem
        Caption = 'Inventory'
        RadioItem = True
        OnClick = mniMainPluggyLinkClick
      end
      object mniMainPluggyLinkEnchantment: TMenuItem
        Caption = 'Enchantment'
        RadioItem = True
        OnClick = mniMainPluggyLinkClick
      end
      object mniMainPluggyLinkSpell: TMenuItem
        Caption = 'Spell'
        RadioItem = True
        OnClick = mniMainPluggyLinkClick
      end
    end
    object N30: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniMainSave: TMenuItem
      Caption = 'Save'
      GroupIndex = 4
      ShortCut = 16467
      OnClick = mniMainSaveClick
    end
    object N31: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniMainOptions: TMenuItem
      Caption = 'Options'
      GroupIndex = 4
      ShortCut = 16463
      OnClick = mniNavOptionsClick
    end
  end
  object fcWhatsNew: TFileContainer
    Compressed = True
    Left = 560
    Top = 448
    CompressedData = {
      789CECBDF953E348BA28FA3B11FC0F0AE6BEDB700E5092BCD79C991B144B77BD
      81A2A6A0BACF7DED8E13B295B635C8925B9259A6A3FFF7F72D9929C95840B119
      75E74C74618C94527EF9EDEB6FFD241B397DCF17A3D08BC68EEDB6FA5E9406F4
      CF703676DC96DB9F0FF98A51C369D99D3E7EB2FB69964E46FE6038C12FDBFC6B
      18977E9D04A55F0781BE1F9FD5B0BB8EFA3C12F45B361153A1FFA67F1B093BFF
      6598DABFF54771946583103ED87D58D70FACFE2889A75ED41F0D275E928A0CBE
      9F25BFBABFF5FFA33FF3A2381596EDC2FFDB76C36ED94DF8CF854FCDDFCF83A9
      48AD4FE2CAFA82B7FFF57758D2D54B4E635F248B6B3AE5353BB04E8FD6C6359B
      B0E67E3C4F0291E0AA7FFD7D7D0D566C54BCA47BFB255BF07F3805F8AF032F8B
      8B767E3FBB990EE290DECDC9F71B05E1DD0BDDFADFEF3F05D1D887FF525AABD1
      FC16D821CC1876084317F7E94D0749E059275E36511BEDE825D3AB204DEF5E72
      4420736971B56418C09AF47ACDC6379DC300DEAB575E2C8ED238F478B38EDBF8
      96571BC8D3E4FF00577E3F13E358585F3FCA9D8600B17FC5499F68E20590D01F
      14D6779E797DDAC124283CC1FDB6736B2C3F37EB38184F327AFF4171F52AFC7F
      D2FBC30904917AC237A1F2834F205FBFF54227903FA1FD7C943328AEDB797EC8
      341AED2A86D6E8F2B2D6C27DD6FEA162118DAA3772F11497DF7C93C807F72AEE
      75DA4EC5BDDF27425C487E5745A74EDBADB8FB7C2E9FDCACA241A7D3A9B877F3
      073148C4D596DA78D3AD5CA20A6A9B7B893708865BF21DAAE8C8E9B62B16F8E0
      85593094B7571189D36E543DFFC7406491075F0AF90EAD7615575667EF580501
      5838F756A7F24E79F00B77AA436FF5AA6E54A75EBEB170E26DBBFA5677C9ADFA
      B8DB4EE58DF2BCCB372E9E75BB52895087BD707FE9A0DB95A24F9D74F9EEE229
      B79BD55B6E2C7BF2E211B73BF7537751F4E747DCEEDC4FDAE53BE511B73BF7D3
      75E9C6FC88DBDDFB89BA74AB3AE276F77E6A2ADDA880CC5BEDDE4F4CA5BB6F81
      B953C9F18B6066B18A10A65BAAD4AB227CE52D12B41DBB57714F11B47C8F842A
      6DB053D03417EF7317EE5320ED384ED53D9A49AA7B7282A11BABF48F9C35EA1B
      8B94D271AAB4BAE221F28DA5F3EB38CDCAED35169F78EBE8DA0F6282AC7DEAC3
      6B3F88FFA99BD4F1B51FC4FCE45DA503EC3C88F7C93BF511761EC47AE45D05BE
      D3E93C88EFC81B6F81D469B5EF2707A582E71C076EBB9F24F2DB2450E1AEFB89
      42DF95F31AA7D5B99F28F47D0AA470D7FD64A1EF5A102470F3FDA491DF5CA40D
      B8F57EE2D0B7168E126EBC9F38F2672E1E65C932EA3E5E512CAD53251FEED719
      8BCB38954ADC03D4C7D24295AADCDD9AE4AD8D399542E8016AE5E25A9522E961
      FA6569AD2A83E77E55F3F61EABF4896FD03B8BE6B0F338A45A5CE5912845DB2B
      2EE43E05A94A0B3D12A91697790A4ADDDEDD1391AAB4D6E3916A71A5A7A2D42D
      0F88DBBD57FC949C1C0AA54A6B544995DBEA995C43F2A8E2228D4A61714B5FE3
      458A42BFB450A5E0B8A5C0F1420A994A8B548A905B1A1D2F52E24EA5952A65CA
      2D154FAEA4D1E8F6D65AF70AB6F25A05342AAD53A573DC5602E53B2DF2A5A29B
      ABF10461575AE7F1C2AEB84CB5C7E2017CA9B4D053845D69A1270ABBD25A4FE4
      4BA5B59E28EC4A6B3D83B02B7A369B8F1676A5559E22EC8A0BB59EA841E50B3D
      5ED8959679B2B02BADF6740D2A5FEB49C2AEB4D2B308BBA23BBBF5140D2A5FE5
      F17CAAB84CFBD128756B5FEDC72355699927F2A9D25A4F41A9DB1B7CAA0695AF
      F40C7CAA18BF683F5C7FD242AF74FFC375A782D6A46FAF36B1ABBC5C8B0B3C5C
      5BCA855B6981876B4A8B3A52BEC6C375A412DF29ADF170DDA824C44A6B3C5C2F
      5AA611E5EB3C9ACF9456798AF02A2ED47DA246942FF4783E535AE6C9C2ABB4DA
      D335A27CAD27F199D24A4FE533B4D1611CC6493608FFDA4F846FF7C7702A91DD
      1F847361DFFECA6DB58A5FC2AF777DCD0BE06F4B9658F87AE1DA8A252A1EC84B
      386EB7F825FC7AD7D7F65FD7D7F06BFC7DC9220B5FDBE52FF345967EAD17E9B9
      F20FF081FED0731F04671B0FFB3F3085673899593A8A9DBA6E5FE7F070FA8E63
      831DC91FA319FE62A93B67DECC822DFE1A5AFD30B0FB09FC977A4E1BFE0D5DD0
      2FD2703A0F33A77F15F8C32C9C7949FF2AF166709F075FF7BD74E685B389871F
      A2F9B43FF2BC7916F73DFF5FF3344BD0608305E16543FC27C8BC996DFDDE8FE2
      5F01EDE2699C09EBB77E9ADD84229D0891FDF67A2FD14FB27038014A481DDCBC
      27E3F41E81CE537958F03259C297D9F74377384E029FBE886685BF4970F7D348
      5C67B04CFAEB284EA65E069F664910274176635B9FF02BCC2F8297499D321C06
      8E4DD0C07F07B833077EE39FDF048F789E010444282E45683F183A7D6F0060B1
      11346008558066D0A7BF2E40853E5E88240AE0EB76357CF0173C05D85D2AFC38
      B225B0E0E129BCD585D35A0AB59E85B893A4818F5EEE369C9F35111E2657590E
      D245EABE3C1C9DC7C0116091C311F6BD0849F8FB3248DE0DBF5BD07315F4DADF
      0A3D57E261E3E5E1E73E067E6EE72E3C84BF7E3BF496605F43C1AFF3ADF06B30
      5786B786B53CDF0FB2E052C0E5A9980693C0F74504BFCC23F828E6F0C8C2A28E
      75C0B0B33E7B893706584EACA338A27CAEFF8077CC52C7817F92F8CAEF67C928
      4B7F0AFC6CF2A101BFCCE041A16377E5C724FF380AD5DF4799FE34D09F12FC34
      1CCC3CE0AFF061C41F06B0759035FC33BB9909B82ABD1449063A067C1A247EA2
      7E86F2E740FE4CE44F7F1CEA4FEABB89FC7969DDC7EB61B72FC2ED5F8FD73BCE
      1D67CE0CDF3AF706A1D0E8D22AA00B6A1D155CF816CEDB39FBB597F3DEE5AC02
      F193711C7FC6C38B12322EC1F01F147FB5F64185D4EFDD2EA27915CF2BBD35EC
      4EBEB77CB9D27BDFF3B6EE37BEAD5B7EDBCEFD6FEB7696C258B296EA772DB011
      FDB68D6F7CDB867EDBD4E9BE0C07FE065A6170342BE804F64B7F7D0671E5744B
      0AD12DF04CD338524A129F63AFF21C4776F9F8E6617F38721730A99A1B2F1E0C
      70BF044F523DD9A58D7FCBB39D473FFC280EC3F84AF8B75FC2A9DC7E70FB2D82
      85E7DF9667EE12981F4E0177D22095FA80FB420AD5B3A1E363917189F477DD6F
      3925C9CD377F12832D7D408D6AFC74691B0B6784550FF4E523D1F4FCE4D8DA8F
      7DC1BA6FB37456FA3C5089B8EE396DF8D7E9365CF8E176407464D78D76BB093F
      9AAD2E48FDEB56B38797B49B0E5ED269B87849D76D36F96EBC048EBD43CBD8BD
      1E5EE4383D5439AEC1A875F132A7D169D275CD76ABFDCC6820E177075762583E
      8B1EDD5462A7F5CDC7F139114C6899F0355EB41E87178F103DFCEA4AF6945EFD
      BEB72D894CB75AC02F329AD23BDCC1CE67E14ECECAAA25F2C2F28B9BBCFB0143
      FD80EEDD227F41D8DFCF2BDDDBCF3BCB92381AFFF5777A6418A45986AADD6FF4
      917F17D359E86522F041B36C37BACDA6CB7F2543A84FFF46A3A1AD3F45F2E3BF
      86361A89FC517D3922B9207F49330F147350DBF9B7993714F22FA0BC8B28B37F
      E3DF3240E7FE77B60BFFD9BB081C7ED47C3A10490A5F82D97CF7E98E821D4CE8
      0E830EE0E3BF86729BC8215C2257F8817EA507EEEA417BC2AD5FC29B47F00B1C
      DF376CD179DA169D66B3BC47FA021E873F9F7B97957B54275FB94BF769BB7491
      991777495FC0E3F0E7ABEDB26A8FB07BDE65E389BBEC761776895FE02EE1E7CA
      7729F7D8BCB547DAFEC37709FF9677495FC003F1E75BD965EBA127B9E018D3BB
      6C3616780F7D010FC49F6F6597EDA7E12B967FC1FE8BBBC4AF7097F8F3ADECB2
      F3C45D7616780F7D817BEC20EFC1A8D35BD865F769BB6C3717780F7D018FC39F
      EA2431D666C192F8191404A7D1683740F4FDBE547F709BBD86DB6B349BCBE0E3
      367200A9CF0F87D08380E2F4E73B8D9ED3B0FECF2260600758698DDAEA681078
      4F5219DC86927D8FDBCAB71FB6132FDB8F5BB19F47E807DF76366AFB4FDA121D
      95DB5B7E548E5DB1B74768054FC3BBC2CEF4B65F6A6FDFAE0B3CDBDE1EACF33C
      726F8FD0005E756FF7EC0C0DF7CABD3D42EEBFA5BDDDB1B34749FBBAECED3132
      BE267B7B8464779D6EAFD76EB7F5C61745BBE3763A0DD7B58D6C37B2DDC87623
      DB8D6CAFC1DE8C6C37B21DAC76B7D16B34DC4AD90E463D70A1AED3691BD96E64
      BB91ED46B61BD9FEF6F76664BB91ED81DF6DB46CB7D1EC55C9F61DC7769BF026
      9DCED2A0BE11EE46B81BE16E84BB11EE6F6B6F46B81BE10E8639F61BE8B45ADD
      6AE90E467BDB6DB67AC62D6FA4BB91EE46BA1BE95E83BD19E96EA43B4AF76ECF
      715BDD4EA574EFF6BAED966B44BB11ED46B41BD16E447B0DF66644BB11ED0136
      546A81EC6E34AA43EEDDB6EB623E9D11EE46B81BE16E84BB11EE6F7F6F46B81B
      E18E95F54EA7D7E9B49A95767BA3E1769A4EA76D2C7723DC8D7037C2DD08F71A
      ECCD087723DC03DFB57BDD66BBDBA90EB977DD960DF2BD6384BB11EE46B81BE1
      6E847B0DF66684BB11EE20DC1B6EA3D7EBD9956EF99D5EB3D968779B2D23DC8D
      7037C2DD087723DC6BB03723DC8D7047E1DE6D37407C57BBE5BB6DC7ED38ED4E
      D7087723DC8D7037C2DD08F7B7BF3723DC8D70C7CEB276B7D374DBADEA4AB85E
      DBE9B69B6ECFD4B91BE96EA4BB91EE46BAD7606F46BA1BE98ED2DD755DB0DC2B
      FDF2AEED60931B90F146B81BE16E84BB11EE46B8BFFDBD19E16E843BC8EE16FC
      DF86BF579AEEED4EB3DB6B98843A23DB8D6C37B2DDC87623DBDFEEDE8C6C2FC9
      F65EAFD16DDBED3BEADC7BDD5EB3DD5E3E52D6087723DC8D7037C2DD08F7B7B5
      3723DC8D700FFC86EDD88D4EBB553937A6E574DD5ED36D1BA7BC91ED46B61BD9
      6E647B0DF66664BB91ED20DBDDAEDD6B779B76A553BED5ECB47A76D318EE46B8
      1BE16E84BB11EE46B8BFDDBD19E15E12EE5DA7DD74EDCE1D95709D0E5CD46999
      4A3823DC8D7037C2DD08F71AECCD087723DC41B8F79AAD26C8874AE1EE6077DA
      6ECF6D1BE16E84BB11EE46B81BE15E83BD19E16E843B0AF75EA3D3EE369CEA32
      F776B7DD705B8E991B6384BB11EE46B81BE15E83BD19E16E847BE037DB6EAFDD
      6BF5AADDF20E18EECD5EAFD735417723DD8D7437D2DD48F71AECCD487723DD41
      BA7781CBF41A77B49F755DBBD56DF79AC62F6F84BB11EE46B81BE15E83BD19E1
      6E843B0AF76EC76937DB95C2BD6B63E7F99E6B64BB91ED46B61BD96E647B0DF6
      6664BB91ED81DFC20AF69EED56C6DC9D86EB761CB7D1325E7923DC8D7037C2DD
      08F71AECCD087723DC03BFED36BBCD4EB7BAB3BCD3EE369B8ED33221F767D8CA
      DB92E7E53DE0FEFF14F2BCB83375E8469E1B796EE4792DF766E479519E775A8D
      AEDB70EC6A63DD769B2DA7EB98EAB7E73EE3B725DC8DB16E8C7523DC8D70AFF7
      DE8C702F0977FC53B7E75437A573DCA6EBB43A5D53FDF6F4ADBC2D795EDE8331
      D68D3C37F2DCC8F3BAEDCDC8F3923CEF34A9118D5B2DCF9BDD5EA70D02DDC8F3
      E73DE3B725DC8DB16E8C7523DC8D70AFF7DE8C702F0AF7AE4DC67AA3738770EF
      B8ED8EDD74CC7C1823DD8D7437D2DD48F71AECCD487723DD51BAB7DB0DB7D1AA
      74C53B38D3DD767A4DE38A37C2DD087723DC8D70AFC1DE8C7037C21D84BBDBEB
      385DA75769BA3B3DDBEEB88D46CB58EE46B81BE16E84BB11EE35D89B11EE46B8
      077ECF69369C46A7D3ABF4CBB75BDD76AB67BCF246B61BD96E64BB91ED46B6BF
      DDBD19D95E92EDAD8EEBF41AED4AD9DEEA74C16E07566464BB91ED46B61BD96E
      64FBDBDF9B91ED46B653E17AA70DFF77BBD5097576C3ED35DDAE6B7AD518F16E
      C4BB11EF46BCD7606F46BC1BF18EE2BDD1EC817CEFB5AAC57BA763F7EC56CF35
      9E7923DE8D7837E2DD88F71AECCD887723DE51BCB740C2DBDD767563BAAEDDED
      361CBB6D8C7723DD8D7437D2DD48F71AECCD487723DD51BA77DC6EABD96B541A
      EFED6EA7D3EBB53AA61ACE087723DC8D7037C2BD067B33C2DD087710EE4EC3E9
      BA609DB7AB84BBDB6E39BD6EA36184FBD3B7F2B6E479790FA6EBAC91E7469E1B
      795EB7BD1979BE20CF5BB6DB6CB42ADBCE3A4ECFEEB5ED9E63D2E49FF990DF96
      7437D6BAB1D68D7437D2BDDE7B33D2BD2CDD4170771A4EF38EA6F24EDB717BED
      9631D78D7437D2DD487723DD6BB03723DD8D7407E9EEDA4EBB6177AAD3E8BAED
      6EA3D56AB78CE96E84BB11EE46B81BE15E83BD19E16E843B09F7A6DDEB8184BF
      A304AED7B59B8DA6A97037E2DD887723DE8D7837E2FDEDEECD88F792786F3870
      A24ED7AE1EDFEEDA9D56BB69777B46BC1BF16EC4BB11EF46BCD7606F46BC1BF1
      8EE2BDE3369D96DD6A56A6D535BBCD76D769BAC6376FA4BB91EE46BA1BE95E83
      BD19E96EA43BCA6EDBEE369ACD6ADF7CA785FF6B9BD6F246B81BE16E84BB11EE
      46B8BFDDBD19E15E16EE34ADBDE35666D5ED38AD5EB3D96E39A624CE887723DE
      8D7837E2DD88F7B7BB3723DE4BE2BDE5769A9D6EDBB963724CCB6DBA20E34D5E
      9D11EF46BC1BF16EC4BB11EF6F776F46BC97C47BDBEE763A9DEE5D69F34DC7ED
      80F5DE3693638C7837E2DD887723DE6BB03723DE8D7847F10EC86AF7DCC61DE2
      DD759BBD8EDB3583E18C7837E2DD887723DE8D787FBB7B33E2BD2CDED1F1DE68
      77AAABE29C66ABD7B1EDAE639CF346BC1BF16EC4BB11EF35D89B11EF46BC8378
      EFD8CD5E03647CA75ABCB71DBBE974CCF81823DE8D7837E2DD887723DEDFF0DE
      8C782F8B77D7EE743BAD4E65E67CD376DC56A769378D7037C2DD087723DC8D70
      7FFB7B33C2DD087710EEDD96EDF69C6EB371473FDA6EDB6DDAA6EADD887723DE
      8D7837E2DD88F737BC3723DE4BE2BDE7D80DBBD7BB2BB1CE69F67A9D76AB6112
      EB9EBE95B725D1CB7B3093DD8D443712DD48F4BAEDCD48F4A24477ED66AF6DB7
      1A6EE5ECD72670A14EC754B93FF711BF2DD96EAC7563AD1BD96E647BBDF76664
      7B59B6B7ED4EA3D3B4BBBFD3DEFF83BE8F2F459204BE805542F15BE92B65E5EB
      A933A5BF0EE3396CA61FA6CEEFCB6F73BA3DC76D753BCBEF722BEED2E36997DF
      D6A8B84D57F02FBF2DEFA8BF7063D76EB71B6EA355B1B7D6F2C7B98D6EBBD16C
      369ACBEF6A57BCA4EE00BCFCB64EC56DDACBB2FCB6EEF2DBBA6EAFE3749D5E07
      85DAB2FB7A55E7D6B67B9D86D3742B8EDBAEB8CF6EE17B76AB4ECEA9C01317C0
      DFEBF5EC46C56D1588E2B65CECB8D8EC56DCD6A83AF146170B46EC4EC5D939CD
      E5CF6B398D46BB51B5B70A3CE960D7A89EDBAE026515A2B49C4EAFD36955BD62
      15A2E826945547EE54E04A07B906906B158557A04AAF05CF02BCEC55907815A6
      E8391715F755614AD3755D20BA0A4C29D82C8B376AABA6E2CE0AAED2769B5D38
      C0CA0756A04ACF6936608F9D2AB054200B5041A3D3EE56E1985B812CCDB6DB6B
      F75ABD66D5A1BB55E862BB9D36FCDFAD2021B702591CB7DBEA01FFAB824A155F
      D1B1E00ACE5E852D3AFFBBE23EA79AB7135637AA6EACE02C2DE0478D865BC16D
      1B551248E7B155DC57812CC03301393B708215F75589202DCDABCEBD5181308D
      5EB3D5043BB182FA1A55E8A2CBEC2AEEAB4217DD3BAFE2BE0A7C69B85DBBD7EE
      362B1ED7B42BA91D148F5EBB5DA50954309766176C3038F70AA834ABF415DD5B
      A0E2BE0A74E9B41A5D1714AB0A6C6956608B0B3CA2DBB6DB8DAA436F56A08BE3
      808E03CCB355C1029B55A2C869B51B9D56ABE2F09A15C8D2C5A7016257DC5581
      2AAEDDC3F9469DAA87F52A8F1CC8A0D374DB1534D4AA602D2DB8A5DDB3DD8A43
      685569B67ACA72C57D55B86203AF6D0133AB7ACD2AD6021A386027A85655A7DE
      AA4097860DECA5D36E55BD6805B234BBDD0E907BBB82165AEDDF7F47F3211197
      D920B47EFB1A5D44F155F457FE76369ED1B7F8A11FC03FED7E9079332463BB9F
      C07FE900FEF3F0489E7E05E2C3733EC77EC1777D8E2BA4E196A4818F40A60F6E
      B3D76A771AF419B4AA6EBB6523554EA75E36F99CF0CFA338CA80B54D07C9C587
      006C58F9E16C0EEB4ED3A9178647890756EED40FD2D9811839FD6978E22563BA
      36D19F7C31FA7F87F0B7ABC49B7D246B961C8FD320CA8E83297C88BCE4063E21
      E104D128FEADEFCDB3499C58E7F04F0AA6B175188D4391C09FE39948BC6CC99F
      7087C344800D3DEDDF242E52E734769CBE7FD3C507115122E655FC1929011036
      0DE208AF143E7C495663148F66DE58A46D9B7FB98A131F347087E41DFC3E9C78
      49DA737A5DA7F0FB15983B1DB04D78D108843FE1F8F5348C52C672FAE858932C
      9BBD7FF72E1D4EC4D44B77A7C13089D37894ED0EE3E9BB78340A86E21D3EF11D
      488B067D9A86789AFD990780B8729C9EDDE6CF13077440D80BC03C64E8C2A744
      7FCAF4A7017D1ACFB34C24802959928A6166C19257811F5F0DB324EC8FB268F0
      AFBE2722DF8F87FD0C8EF8620AE49CDAFC791427801C59108D017E711467623A
      107E7A938E005D1C807278134797D3D02EFC3584AB7D2FF3E0C9C90856159780
      05B0E0A51706F0BD007838FD74125FCD426F282671E8A3A303E86A1CC5899806
      D7C21FC2EAE808018CBE144144775EE353F036F800EC0650C28143B80EE1F5E2
      1B11C1AEC4F52C9D2459045FCF61B3613A1BF6FD080E214A07FE00BE25570B6C
      690EFB868DA5130F181A20D7BF71EFFE784A480C1F2674A1D3855D8D2F0B9FE1
      D260CC2E74FC4BE9B709BE9A4337E007F498C1FB7891DFBF0CC4D54510F90E7D
      4A875E281CDB06421E247E32119E2F3F8EE238EBA7B3F026BB8A8248E0D1E8CF
      936C0A7492CE60136134C93CFF5FB0ADFE3C156136F0C2A80FFFC117F0903EDC
      024F18C26F57F40B7C48B271D20F232068D8B98025E0D355823CB89F46DE2C8B
      C7C0BC836828C210160AE3AB512042205D1F96EFC385B3793444C7AF97069E5E
      057949026FACF8493F1257B0629ADDC09F5378C83889AFE09DE35190E18B4608
      F0EC06E08E1203FE0E2F1B0193C9D2FE48E0CB89505CC2D7C3EB74469E26600F
      3E9CE1157E2FF04CBDD110480ADFDA1BD1C573C0CBB03FA12B107019B0452F81
      2BB3E1A547B0CAE06DF1A6518200C12F2EBDEC7A70DDBF48A259924622EB0F3D
      204840B810E06821E604408F332FB3E0B5329B99E91520F2689A8D821008C972
      9BA02D20FD03079A27229B247196C199F68370144FBDA1970DC3683E43919A25
      F042561FC9CEB7140102CB8EC4B5DDC7A317C94DC7EEF6F1E8E5477893F41A3F
      00FCA3894804DD8DB7E029A16B8F5613230F707C082748146C915C8DE04FE125
      50D72C9A0F93297E817E47FC9D3D8B18D59A45132F1AA3F48DB2EBCCB376A550
      9637BBC871E07678D947DDDF804FA0093CEADE267C0A1FFEE4ADF2DDAD873F79
      606DFE5EB54C9B00F0E0D7B86BA90E2DF4B083B86B9DEE73BD50EF212F441AD3
      B29540FA24C0AC422F882C89DBFD5F8168721504F95AEAD1BF03A47DE0F31EFF
      048903588C77A06620D11738CACC0B67130F3F44F3697F4457F7E339213CB9BA
      ED3E30BB799A01AF9D64F098887CD84A0B8305BDA25603FA4E160E27FDD11024
      2EF0898683ACC91BA5AE0BAC0D76E7D86E8B5E9E2FB2511AD255ED3E5D84D734
      ECAE431F46C0A81B8DFE10298FBE886685BF4533FC2B80BDF4C8013CCDC62736
      BBA5E7F407FD91E362F8B9D9EDC3DE278B8FA28F17A04280F8445B513E83BE06
      05A5B8CB3E6A1EA56DFF34F1B2EF520B78B00587737DE80799D5DCB5779BFF87
      1488C4E2C37BBD6373BEEDD8AA80D8682F1E960623C0A8128CDF06BC0FF3F108
      B48E54828A0D1E0ABEE408AF797919BFECF219ABF482A7BF533F8C615540E0BE
      3FA00F202F027C4EC3EA7F37E8F44144FEBEE44C4BF90C0F3EDC85F01EDEFB80
      E30ED3E5878CB73FEC98F98CDDE60210F97CDDE63380717DED2F9D6ED7DAB18E
      C08E38050DE912B47E6B3F9EDD585E6A29BB35B5465E10C2BF70D1C9F7874775
      4384BF747A2EEE310C6633E15BC8D1019D9113A0B1167A37563CB206B0D0456A
      81466AA5F3C10EFF5AB79DC27976ED06ECD51BA12A360C8587FC72DB4AE3A920
      F6078653E893CE0EE799C453EBE0783FB5A60003D0FEAC30F67C2B9B8820B130
      612906FCBCB11231444BCF827F13D4B56EEA0695BF745D84C9D169E3BDB5170D
      C14C01337657A453EB7F5B9F6334BDE3F802B8337D15094011B0D72FAC93D80F
      40D5F72D6F360BF1A73F071A1E5BFFDCDB5F5FAB1B0C10339A48E95FE4695E05
      D9C4829540B7F7616FC000A61F0F520BAD33A47DC41575F0F0021928E348259A
      25BC0BA27F013208BF6E80F84BB745C8F0E947F8571188E5E3FEA671246E8016
      52A41D9178A940CA98596301D4932535C4FB560B36B957E205961F0EA3F98547
      8C00317EDB0A80D6891D7E82EF77CEE3AB08B69D5C88CCBA845BD249FDF6DDB6
      61DF591C875930B3BCF0CABB4991D703210B90B8923B7A1668FD7154430C6E33
      3B6BBEB70E5807391D20315AE4B5B1360F8E4E3F6C2125CF435F53AC75197816
      2ABE71F2F1A07E5BEE38B0E5AF337490B1227286494243D055C210B60E6A4B6A
      FD0C20F9A5865B43223D3F3C6B6AB3A441C218BD3C80C42077411D3BF1C6B0DB
      C3D108CF59F2F0FA6DB5DB86ADEE03679D58831BD858340A92293225CF27F1F2
      FB82061C5428C1B0F3E05915E1285E7CF4CB2BDF52D2D4F01491BB9E041150E1
      2C89014BA7AC4DF8F11C51164CA5E105491AD697A6B13F87AF532109B57E1BEE
      3561C33F9F5DDC24C1F417EB0C0CF8C40BAD2F7BFB87682B2835C94B04D12DC9
      4E1F95A844FC3A0F921AEA483DBB073B663F899423F270BD590C066D3C9BB001
      35161146A160BBC7A7A7E712A3719796884063B23081B27E7CAAE7B845963C44
      8605FBBD9A88C8825D2152035F2663E993980052A01E55C35D225A7FF9B47792
      633132E18F9F8E4EC90C4A7197039041184C648C1E82520C941CA581CCF6AFDB
      9651001D7C51863F7903B45D8B08BD974C81ADA117803FEDF93EAA16A8711C35
      DE7DFAB1865BEE49FFCE97C3A32FDBD671102177FA12C7A02AEE634642E9ACE7
      A462F984EBEB6BC8E9D01F50BE0B19DD107DE175E46C2E6200698AD631123020
      3DEC314861F348D71C65ADE1BE9AB8AFEF45F6495CB12D6FC511A034052C53CB
      86431BCFA7C094998B05EAD43F5E0D8E02E4EB299D7310CDE6590D37DF9187FA
      EEA8D3FEC5FAF479FF7FFAFDF5B5BD8F07E768007FB40EBCCC2B70B9A625536E
      400D45838258403A036310C960E3536C9D01D8ACBD19E837DE70B251438820D5
      FF8C22EC17EDD825FF163A78523C6E01A24D12BA354F11F77FFCE7D93E6A6B35
      E4EBE4D3390FA6C29A79698ADB4A62D811B2ED103F24F3889C1FE9300966590D
      3592169EE73FE7A0595B7B73C0D17D74E728DD0CB639143B22228B71E38BC014
      15EBF4E8EC9CF0BE86D8DB46CDE4ECF8FB1392C447C7A75F40971E49C9134F67
      A1C80430374A7CA1439E790018CCAAA9DB5ED7D760B7E800F81E4B8DA4EF11E3
      4753746F00F746FFFB0E98C7A87FE58E3C79259A18948F840C7D9348398AF5DF
      4231CAB6EA0790CD44CCE20479531C5907418A1C7B0B2004EC2BB46003A87DA2
      4E068AD97799F2EE1109904A4EEE84D43A3C3BCE231652750701278D5190F768
      AAE145A3D01BD75093A98693E4FA8707A00320F91C9E819D5A5473F93E6BE3F0
      7A462E7C10872C060773F421CEE11E7B8341A6F8E6C6FE44008521A91D5272D9
      063EB48EC1C06AB81D463EDAF5678724034B109B89847DABE2DA1B66C580086C
      2F0BBC10682E1B4E105204368587BB83D49342C8430A66ECAB9DF8A986D97151
      B872462AD166185C088B13C2644C95052F189048B4606878035AEF8F030A9059
      03E0C2327516B893601E0386920F1C8718571E69B312B49FD0E204ADB5BEA1D5
      2A60A4DE25F161C40141DEC1F5B518B80B9B8DA870934F096EC0148D5922403F
      9DA74069BFCEC51C56C3C456B6BAB38997D12ADBC0B7D2799891951691B007B2
      4A6B474C9BCC610737968F9940483408B14F187706C58E05D9C7082827F242F2
      3F211828887726143A256ADB2671A9FA34D8452D51AE6E68B2F2EC25B70ED94B
      3D1BE3821B5FA3098638415DDEDDDD05D564865208B9C4300EE753FC11E1915B
      5311CD0DE1DC0B58A9095967A01FA272835C280FDCBC06E49E02ABAA88E173A2
      DEC72820B52F9DCF489726C57839D48063A37311B442B2E276251439B802EA10
      2A4389C04009F1FF5B71489776B3C88B9ACFC68CB4DA8B2FB42BAEC58322A1CF
      0C4F0BE04729D7E8BAC158E2AB836147301CD2D5EC1F7004F17A2A40CCEF1A16
      752FC0C81586186B98529EA87DC334841A32B31722256F05C4F42B1E0F7A98DF
      63E629AAEFBB229D95DF034BA65E21CB4293D5364744B441616DA2611A606180
      0AD42BD7D916402E0C913307CCE8E13ECE5FA0882179924ED89374A6D21AC8B0
      53A4FB314317D30CCC934066F150507C8AF6CB2C24D358A4DB96D81DEFAEF474
      7CEF2A1ACF81722836E027DE388EC030A750C12AF8A082DFF924283044252687
      F17400CC6A652202B9007A725622213653210008617CB5B52A01F18DC5460F2C
      FD290A88D72CFE6998E21F53FCF362E673E3CD9BCF7F695390F80BBE20F0DA48
      396CADC17C5CB7E35E5FFB4BBBD5D4991D8BD18AF732E6915A541ACF4E7A0FBE
      1CA3E07E67C59C3F4D321ACDB5B3FDD363CA600BEA87F9040A3CD89F709354AD
      4D6998324D71DB228CDCD1599AA09B1C5225BEB5072ACF2C01B5068B833CE534
      996374434473569CD099C6A922859B4658010F90F4C220AB9D0BFB2FED36426B
      FFF0F8D8820DDADB36954381BA91CEE689744B7300164055AC9F92F9ADAAB262
      B77E3BEFD89A640EBCA937C60834E6990BCA334FAD6990861EE81CC2CF93676A
      B84B640C1FB94D86F5F1FC245507AC8317A01724945B40353FC41D30DEA78239
      583C0210A95FAA76BB4359619338C55D1E9E7DE6601C982EE3249ECF6AC7DB60
      4358C3B63704F24B7F0CE290C28D706068CEC95C6422C9381A017FCBD01ECEE6
      69F97CEBB66964E83D4727B89D62861B96E8E246896B51282C88803BC9781B9A
      4B436F9E0A0BDEC64F87DE0C6DA710F68BD0E244CF44250CF93A2390B389A2EF
      EA9700D8A60C7DEC1D843639870FB9BC953F79413897D9F99C3043F14A606929
      18FE981499CE09A5EA871CB0752A1FBA99C588E53F096FF6F7834F7B277FDF8B
      82295307FC4DBCB73E78D49A6C68EDFC1D3FF32FF5DB6D9732F32798E7974DAC
      01BCDF102BDC5825019E7D855A3FF2B80166840DE65986EC3B18D1DFAF82C88F
      AFD03393C5B1455DBBEA57C90B274E49EC5C8F718CE788B917236BE34060DB2F
      A0FAC35FE7C18CD22137145260B64EECCB02B21A6E19137CF7BD88EAE2663374
      C7C984124E5DDD0F31ED1394DBB39BF46B1684F8294BE81386167EA283878BA3
      A086C99F1D1B85DEC67E31F16F432BDD9469824935CCD93008AA3300C9D39980
      5103B2A07EDB7670DB1E3166EBB220EC415A615B34AEDBC654D0FA6DCD45C59B
      7394B900810A4CB0140779D7317E00C23DF97A765EC3BD3992459F9C7F3AB1A8
      591A6E86CAE564FE3D70E0AB24C8B06921B972E75124F098B1DD0420EE348858
      8FB32931B1863CBAE3A24D797C7AF03DDAE040B6A882F05E1301968488D08094
      163510EDA7AFA0C7010ACCA344A471784999DC1F9097CBC60CF58301F69669B8
      94D97465EDFFC302EE85395DB4298906B813C109DC4CC83E152901F39689EDC8
      EE07A2505149EE9BBA4102E080E5099488441E175655A6564029A4801DB248DF
      C78C5B060D30F5F53562EB5C9145378541043A8DC8AE309B80DB2B7A21710C5D
      E53F8F40E661A61C06026B0828D4E3C94165A5B81DD6D82842C7E589BA251167
      7F8FE2219877201586F304882A2BC6E9A6B15F3FAA0110A0AAB3371D04E37990
      514D22171E0310FE09F20028654441C91A1652779AD57BFBBC073CA2D67B436D
      655FD1F89E14E10BFB5349C105A2DEC72B6760ABCE6A47AFC8E25BA8C9686E26
      C913F60BBFA9645F76CFE05E35CFE2866298A087E200AEE5913D709F2C2C452F
      053046712DED9BA0767EC7AAD468DD88E7A0146D272D61EA5D80D88FB1474D14
      473BDE780C9C3CAD61A5F592CDAFAFF1F6A9FB07361BDAFBF14495D4071EB6AE
      B6843FA6D21C5992C3558A63967BDB549D8248C4A862A51916EAAA6C0CBA8E75
      4D2E3108E3F802C8CCF2649518E6DF6346353F179BE15010036FC3E26650C650
      E7AA1B9CABCB117E14C90D25499D4DE2AB7DE90F65CF3710E90DF94343EEFA46
      3DBF8622C93CCA989597D60D149B8061CB41F183EE72B6298B2FFECBEADAF696
      B5D8B98373EB7DABD41140D6ECB0B2CE5A07A9EC883EE362D11EC6CCEAD9D2A5
      1A8B3C9FEBE9287B42D6CE7119E2842B3C64651412ABB5B14FC146619DC71BD6
      6C9EB153AE78271330DBBDA1AEBEAF1BB8AA8055882D0FA57F3E0A74674932FE
      D28B806AA5EAB6E56A0C2936FDB128E93E1363C12D344670C69905FA38361E48
      73ED87184E10ED50877B2A4407B8B18FF6868811DE99F2F9D161573F5DB01A58
      C04E34F3E560D43606DA49E5B1A664F6708C020B9D9468A3900E77A7C80D6149
      7EF308031C7E5D8B5C0A705A5F2B6B4945635935B41851CE06198239B0640170
      41A3CE2FC7DF36F641FDF413B498471B16C53DF3C2B27A86B4ABD0EB64A1D316
      C6EF0762A26BE994282356047F4B19A7C8575C3F53F9AEFAE7D6BBB3B3C35FAC
      0FA7A7FF0029243CAECD3DFB7C789C167D4BD41D859C6F75DB3CF098E57584E7
      FEE89019EE2EF6B73902C3F28B48E33956156A062C2BC065582C517FD7C5B9B4
      F41F0624DC36E367EC9BF18B6C9C21DBE2484A916CA6A8CD6D5EE1FA649021C8
      A8E795A85D33850A8070C68F2E702FB6FFE26E48112516D46DB79508A07A15DF
      52F8511121313AA392E2249E018D5CA1A4504264414BF9C380244E6620610124
      4BC4635A4820D94B538179930BBDEF54E374209BA9D25322EF125BC561A75971
      6552AB4D79F28BE65737DF7C7E35E66D35F2C66494B7757E7EF8011B19CBEE63
      B7C3A21B1F4201E47AAA5A69D4AF7953BBD32BEFF9C78F671FC91CFCBC7FF2A1
      D830152722FA353486FFD27131AE99CE47A3E09AD32EBC506503A337047DDFEC
      00A8DBD62868EB6815614321AAE36C2836BF813DC5768E426F9C6E941B875232
      A21E1A00B8FC03873429118F3A5A04C0F0F6451852DA52ED501B60D27877F4E9
      C75F2CDCBD652344D0C2B0A6A052C276CF86491C8635DE16851F36BE600C792A
      CE28C1EA7312A3FF21B1AECF0EAD43D57CCB3A8EC71B9677E905611DBDE65FD8
      FC617F5D3EE5C2FA0C7611A88667E8DE251B7934C79208CC342CB47C42A92387
      A460D57EDD368FF1003D1B01CC626E5EF023E86CAA5B064FDEAB9D4A72C65E45
      3F184A77C73C4AD93F70361F70CB7C6B2F49BC9BDAEDACE0D1E04294C34FFB3F
      A01AFE0F60CE942A84D64AEDB6B547DE172F4D8371A4EC0A990694D473C20176
      D44BB8CB99E50DB3E0125D9298DF3353750AC389C569F72987B7CB4DC1A8B088
      C60A2ED6C9BF746DB36D3BAF3F0161E74125DC5848FD7C1B3D3A3A5AC1A88782
      F858C19EBBB66D0EF7C536BAA5427ED399C7CE442A3C3DAB9DFF6CB16AD602E9
      A20B67E598698B470D9167CC0A2908A3A20A68E2FDF0F1FCE4D0F4A6BBFF3C40
      5901D5041D709F55978BD704DB5B6F657316532B6F0519D50024C5D65A34932F
      C0FAED5403F18A06185EBD7F04C92D97AC7F2E675AEBA9CEB4D7695983EE7A9D
      9FB49266425EBA8A763DE9B052AAC1BE5FCE7F594B5A7A7DAD6307733AEE43D0
      37859ECFBDFFBB30D4E0E7CAF113B93C06B7318FF6CF8395DE383448F9769192
      182625C3FF7950F257C326DF3A4622AFFCB361A5B73AB4343E826A10EDCBFAA9
      2CE614364C60A3F435E328D08FDC4BA9E9CD35B9AD3C3D8F3688AC83526B53EA
      9EE98B8CEACEA88B265EA3064FA8464F5BD63FF7F6AD2B2FA54C6BAA7C08C362
      84D093DD73D6D7884760F1B29C9E378D7DF24C6C5B2A73D017B2D924B6A6980E
      B8044E173FA71C160718E2B832D9C2A71C63C41279EAED210B9F78480FE52D5F
      890417F2FC7CB2114FDA8037E15933A54EAA9C50CE6E13092299D255558D46BD
      7165FFDA1B2B860724DCB476ABDCC03C602F2175D65D06B30264F0E1AF6E3C97
      B060157D5B8BC740B9D89803A1FBD94619A60CA88EB66EC1E5655C598F7365B5
      DFBC2BEB538C8CFC0488E54452C66AFA6203EFA3B21C24DB9C48892B71B50936
      DA09BE612AC1F3AA25DF4EB9CFDC6FB9346E0839EC593C0FAD7D2F4822993AE2
      0BEC42340010715FE647D550BC05A25D81D27984738EAA89E0755450553CC498
      BE480A80F778EC2549BFC93513098B5A2FBAC9263275812EDB5A915AFBC7EACC
      ED9ACEDCF703EF1FF1CE51602C81DC12508D01407D9EA7D4FD2CBD90DD853C0A
      100291AA793D8C6BB22282C7628302868A36F793FBEC658988238C69BF83FB3F
      7B379FBDB03CDC01D5DEE28087BB97B606A043839A0C97E29462D4AEA7A0FD4D
      406DF6E3484E4DC4AE0474ACDB581690600B043F9095E8D4DD7398089E1A0487
      CD2F8A273213BB4310DA9BF0A2B802BFEC164DB3FFFABF723B40F0DAF077EEB2
      10F24C77D50A81FFC81D1395C4CBE299ECC603DA7CC4B0A529AAD82960549877
      6108B51A3171B26FF23916A06AFD18F8223671FE12D102F3DF60B86C28EC2B4F
      CCFA6664245B8B06B8C433EAF3FE7FE3F9F91CEC2D2C59A21EEF44914CA832A5
      60087480EF808552F98119F43613225ECC52EDBCF90AA6BFB41BF94C05550AF2
      191B765C58875196DCCC62CC1F775A9DBA1D3ED566611BDD3DD5E084FBC982F9
      EB8D496893BCFDE75CA4A8A1FE78B27750E8CCB7D8974FDDB41FCF319D1EBB10
      D50F2055E5F4CC26133115A85DA5D6E63CBAF222B82EBCD95215E49A05B3EF34
      888269F0EF426771724B7AC07887619CCA5441EC511827CAA1898DDA6B574A51
      0DB49F945736C59A72B21C412671AF8EEC2A18727D4950B82605EC8AFC6D2B50
      ED3FD8DF1CE9AE32B806CD89A4C1E2DCD71C1DB2D4C97C32CFB070F98F03C09F
      A920E96B3447EFB8EC1B84859120F33F9C1C9C7307D9381AA3FE8C4D03B92BCA
      A59704540F9102FA599BB2D38334F2410168B00FBD7675FCD570DA8FC3D09BA5
      B205B864514858A8E46F12F478D80DF1B97754AC881FB032A6D0FD638B5CD273
      1C819977020B92E17C0A8449BD6AF39E3458DB4055E1AAB19FAE0A4F555F2C42
      F8D0AB612BAC2A386F1C0831A3B10B8867A7B2CFE146DE526348C9D3D8834C07
      8B865859AF4AEAE914B0299D4A10573DBA89FD4572FA37E0A81E35433A2F5A81
      B5EB0B79275764BB75052EC78F1122ED4ADC8C17E24659315868475C3E60BC29
      BA10B0E1C27E968434073E0C665C6F7B443D6EC14ED2738874472D5813D75313
      AFFF2878F23395BA1DEC9DEFD1F882BDF32F082D160675DBE31D3A82F438610F
      0DB14D671D0C695A4585BD4B6D073D6B10D2680BF807590BC8C44D6021D8C132
      9D78BE7D05FFDEF80DD9E20A59F175EDC45D45CF9233EE79B602D6B1A210141C
      E16A36BB82C449A9CC2A37ECE1D909B581253C0676C08ECE1910D129775656A9
      12C05D559E04A55AE4B37C37754FA72C111E70CBFC09321343E87A761507D28D
      F5E0F97F14B259010A81557DC2EACDE6D64A04AE4AB0F0F2E40AACD597DA966A
      FFC4156DB2392961C71FE4C8CFB91D5330E69129D895099B3215E66C04A04C90
      CA8A5A888F1B97EED4291BF3855E685C4C5FD33E45551DD0F28AFA9F485D87CD
      7F8EAFB8F7D9D90FA75F17265000A28C236E7551370854B600CBFB7E50B51D32
      589EED2929244BBC2805238E0C6A453285D6DCE97C38A91B301E000AB06B8F8E
      CFCE1502C0E1FB41CA83F2E836F2EAD66DDF954870309F85C1101D99E54670DF
      7FF9FA59B7CA94ED223D6A4A3F028C08A557AA90B1C82E81BCE5910999DC91D8
      CB4E1BC0A8FD38F269DE85090ADE0D1E0AB717BA0E62EE24FF49B949BD14651A
      E6C412C392E5F89683716E9EB7E3652A9E575897191BF5BE910FCDA97CD7DAD3
      BD3B16629298F0C3D99BF0368109147EC3B1CA263CAC957D101148564B0D28B0
      3E638F309C0D03A77050E2B5863254B8FC943172E3B100DD5844E64D09162A35
      C892B9D049DE328E11A48A0CE01335B611DBA5A77A4B1E88AE7A7E198AC50FB0
      AD3B101DA8E43739B519C27940A3502FC221ECFB2A555F4D7E64E6E58B592250
      82FB8650AA4006D64D0EB4CDEFF66882E851106672F2A2BAEEBB6DEBBBAF1137
      A1A220E501AB7ED6173DB40F2EC13F7CF785A76D6E7CF445948106454E5B367A
      3754F5C3777440E8D30B7C812E897890C6B4B67242E0B88404EC4F6ED70E14F3
      1D37ABC60C717EABEFD03EE5972132D2D5163444C1B3A668CE8DD19741CA27F7
      B2CE05D2494CE31458FC91A76380EE95C5A728839995C440D2BCCCCFC4017E7E
      3C9C535C7C1347A2605EF42CA4841A8C0D51F6F336B9AF299E293C38570DF12D
      43E3F723ECCF38AFE717792ED4C94ECFECD95ED2C09C9190CE0FB395688411B6
      B9C31100C2E892F923CFC9D1970264908CC8CEA77C06222A447AA42734F079FE
      B74AABE47ED60058996326AE05E999BED43965B006FE3AD3153B3AFD2C569400
      FFD253B7AD9B784E4FA3003E53090EB7DA1DEF3EA6CEE7CF9D37D57DF3795348
      CB4B49F9BDF5FB6FB0EDD72D383A3A6D20CA2F1F08B60B98BD8AB2B807C7369E
      1312E787674D02C53FCFF657B5F1BA917B151ABF7A4CE1ECEC10CFEE0928FC7A
      08BCD895E95951B84560F8060C36F85BD0745782BB479F7ED4B8ABABF8FF5478
      7B744A9CF79F7B066DBF016D5787B14A54D27BBC55747D796163B0F541D85A36
      4457C36299C1E09BE08BE07BFCA93056EDFFFBE395A2ACF139DCF63968BF9D9C
      7B4AE6FF4F41E4A34EEDCD94EB0FBF3DC1DC0BFED3363A196822479061748BEB
      5785E0003D5765683F7E9A7989ECEF8235A6BC9A723F18FFDB03222BC8C17060
      22F9836F3BDC0C7A17D17B054D701134D8D96825CE0AEDE4537E722AACC8E2B1
      A0C648E4CD5F415FE0857E75B73C4B6F47D6BD4AE7C8D76A9C73CBE3CB0D0132
      8C95AAFC3AE6D6545BCCF90A32CB908BDD746A91EA2D124732A9613A45C73EB2
      50B53839895F1FCA520346656211D372629445902BEEAD65E4DA3D72EDF03A30
      59146501867914AB1162020EE3CD0A31AFD044C50F4614F4CEA41ABB899C6869
      2CF2F8F4E07B013F7964DC16B23EAA5591ED0FE1520C3E0F39F3032B802D6F84
      EF812C2F56932E91858E8228482794156268FBDE133DC4724D2F3494AD1FF991
      138C742F1E9A65C3505AC8792A77B19404C1D1D98737BC7B4EDE205F53C9DC55
      C5E49421B9229556301456B27BC00FCD22157AEC59DCF442F5951DCE13E488C0
      C70299291F8C3486619703CC88E6A213698A87F15026DE805E472A22D5455B98
      3DE47397899CD1EA8B09FC6799F0A6DBFC232F342EF49D48C4380072BCC9D389
      B8951ABD022F44C32BF1D18CE82A136F4EC50C54671AC01FE50EBE4B2D1CEE4A
      371916FC20AF1B001AF3A93A6DC385F5230FB021834CAF263D80D82EE32DA3FC
      70C89D52A8846098082FE5466D53D58819A9C7D9B5779B84BBF8A98558399C18
      6FD6838C37D9DD01B4B88F9F8E4E17C6691A1CED589F75176C649D0424D51223
      4759EC6BE51306EA0BD6D7A8D2345DD06A79A667B17680FB0E02B71D53DDE115
      F50C456D985B8DEE5A9BE7F495AE334BA6B45204B89650469A6E0A91CD13EAA2
      138F469CF7875FC88257F84E2696A9F61C5CE5CA1D7CB13236A30C6E2F536EE8
      AC702DFB1C126C31C85B042C415300C51475171FB0F382AA014534065AC042C1
      C4DAFFC7AE2A8FFD9017A27F8C46F1FB12C6E1B3E290BB820489F5196B773775
      D775BC720B2E91B9B5AACFCB34E60E4C13714309B4DCD07C5B96B40794A57E15
      2717EAD5C31B290DE53A7EF115AC29B652CFCF941783CFB09AD8C5643D6F3809
      04BD62906E97DFBED096438E1246D69550CBA8F535EED1A1B6C52B2E023EA6F3
      283661A40A3306F64265490A9881C702376DE8AB3674763E2E768EC9F984031B
      47789CD320E57E95F006E52B4132A582620800EE5424B2338B86BDEE454EADE4
      F397422506F10B9D52805B39426F153771ABB8747D0D340FCAA5CC2900C31DE4
      16E39587797D9975F071EFB8D8579F2C41C23DF82FB8547DA80BE0BDF4C2391A
      A1BA61125F4E98AD3105F61CAB2A2156C1F6FFA1142F7943A0C6F0EA9B40B793
      B99F056CDF2AD6B6C9B3873FF39CDE5D6E31A88A8CA932767DAD983B8AB541E2
      1A2C6711CD95734FCEF82D0DD956719F1C9EA9AED655F0C6F4EBDCE75840E525
      954818F3C9AE62895A00AE983BD5104E02A888B9E40827341750375C718B16E1
      6FADC0E7B8836888B8B20A5FF6F60AF6FB29CE77FCFA9EEC55EC18B916D2F32A
      061AB2F05CC529AF72D7465FBE1F46D853E42BDBD5584061F4E412646470CB4A
      B10702E806945FE061828354B182C2041A29D7322E1D221733694AD47717F561
      29917C52317305404C67718271B3FDC3E3E35C5790DDD30A4FD895E136DDE785
      A76D9FE8D604AC00A39919E2989FA22F10953F12D1FA69EA15E268C717147BBB
      ADF2EE2A4776883AF1CDA2435B2BA1A8F4C1930964A59702E548BE9622C602C2
      E94A94DC235FF49E8FE6F8908547623F1BC10FD2A790B2F6A3CC8E08B48E5B50
      D925E56D364F66E884674D5AC1C723E7912AF38CA8E9CE21EDDF3AC2FEBE3A1D
      4543872280F82C86387ABF46AC56914E29BB87EC5A47F384220C41B4BEB65888
      961514295D7CB6F8E882E699086E9C86E6499A17E22CC2135E044B6E40BDC356
      ADE3583628E4BA1C2FD3B569773E0D1E32576309E0BA8567E4453D22A0EDC9DA
      9E205B89FF187691BFE0CA3DC8D4F45539255F5FE2E6905885C45DE6462ED66D
      EF71B329EA96794A86DBFDF5D8854AECD35B95D805DF2EF120E60CA4CAA7DCCE
      0ACDFE25DC60B3D0834EAEBBAD6EE16E1F8B37F153A81917CD25C327695700BD
      23D00C39276E914BB18C5CF9A195A5C9EE71DD225735C61559463D69166D68B9
      8AE61BC99017C90DB0D7C7393ED53378FFD3BB34BD5789F01A9DEF017AF120F5
      DEED0E3CD7FA01702F7CDDCE356F5DED5B988D3044993A5A45B2179ED22A68E9
      DD0A76EAB92BE11A5AF860CB1CEC4E406D74A8B4DFCF8538A3003AE55E1D321F
      CEF660DD55F8844A1345D8CF87223A2D1915E787678D3F0F6158D8DB01B40ED2
      F7AF048871AF0C0E55238F1D31C435998BACF4731FC1A3538EE91D9D76DAFA82
      5574397D28B9BD0CF40AA9A36CB69189956223BE204DE73A62A49AB1FF79F08B
      8D494E3603F4483CEB320E86427550F77028E498BA31706244C99B0DFAF2E738
      0CD289A2CCD616702EEE6157E85F2F40E08B1447E5C633D9C59ECC16D41E49F4
      1905EA01194BD7331C02C06683892D17A3EF53654D15C335858C1FB406197C60
      E27903199142F3083BFB5C06DC115E3A31FE8161356CC58373ACAC3D600A07E8
      CF3028FA809398C0FBD1C485B39910FE071A2F6650B5E0DE65437BE3EB47EB4C
      1ADB1B8891DB124937188225F03D781EDB8672552CA45E164DF840BA2DBD4B2F
      0829270D6E5E5FBB1D43E5B579401C674F50CF7B74602EB6BD0FA6B384A69C70
      872D546A31A180DC8EDA577106D83CCC54BBAC925F22E1D65EF40E9E2463158E
      B67E10E1CC7A2727F9C1874FE27A9E9EC43E7EFE3EC87E980FE083ECF20F9FD4
      20C97772BEE23B399E51EF644554FCC71A18EB9881B16650DF8B359CEABDF986
      5338CECEE95A3B5663B741D61512856D8D80A752D883DDB02A4E448A3459B372
      16D1D4FA78002AF72011DE0567B6ED24820B41E08A6DE0C0095E5ABB81080094
      1ECEF8E3D6D4C0851120686F5E151DD55F0E3F1FEFED1F5A27A70787C7D6D1C7
      E343EBD3DEC9A19C0858B73D57CF9BF1320C7BE2F77C814C1015D130A6A028B7
      F49E9244CFADA592A984A8354CBCB47E7DDF2B60825374DE01055C218799C618
      1F9482D9F2638A9A50A221C0A1DD1C04B54386AA6D1F8B310ED3C38C340AA250
      6382F98CBD7D364FCFE36170E4911816BA94FF5140C00306CFF78FBEE2E9727E
      6F5E96CB251C1B4731A5107C9D6DFC61B69D0FBED8F88C5992099A97A0F4AB33
      5E5F8BF25A13EC8A39CBAC9F4E4F3F175210FF28B01824F18578A06BEDB99D8F
      0F74AEAD20A6F18770B39290129CB6A4927E0A09BDA8CD59E380E3DC6AC4AAEC
      A4FCC76171B245F5C7F393E2341B8F9A5F83561844FF020B98D481627548EDB7
      BD711078613CB6CEE35930DCE064F99FE204673283863F141BD6F79C5426D307
      2EB15B6B8A7C1E8022AE6770C31F05145C902D9B1B53FDC019F5E6FE2286E879
      910CB0AEDA4DE5501B3567937CAB415A983BA05CAB6ACC9CA7AA44E4D8371948
      089930A4A36BC924AD3F0CA8C859A70C43A9F2E6198D436F3811851A0B9E4029
      D320B9CDBB4CC0F48AD36EFF30D091E3CD4738811536BA6CA45A44E986A9F4EE
      034EC1C3A5EF906B8535CE45DC0A3C1FFD0A06662C4B85813469B5529E67DDC0
      58014415C2647B3AFD86D2F2E75545004D57A089A0DD9CAEA827E0D04B57D100
      31CDBC4C0E28666F02F9A1EE3EF697EB3CFB31CAC0DA4D74BEF80A00A286A581
      98B506AFDA8AA7AEBE6A1924E1889389D7E53EFC1B6B16CFE6A187859258AE80
      81BA52446931971885F34CC433D57B6C4665B23A99DFC326153B58E9E9C791EC
      C393DB4970974F4E62F85A46B24CD8F9FE53CA6382687CC8A8E0C0049F6F45F3
      104B299A272314180D5681E0ED620056C57FEF826CDE67158CBA411C72E53EB9
      31118B56366AEC8F156AB54DA8F5C1C0FBA40D4543EE38BC702387CB463E512C
      CF3FA6B2365F958288E94090080B226D536137CA623108970296ABE3309881BD
      97B0B07F9C78534EEDDB45D94913AF5562C8C6418CC5611CFB8832505139C3D7
      DFE0EB06F1756EAD811E1FA116A9171FCD297395D64EE5FDD4D779C9CC34DCA1
      5CDBDA1C88A187712659B4037F929D71563627CD7D1ECA723B9594E5769E8BB2
      CE294708A4C13E6607818961082C870DA0DFF9E9BE52040B695AA1182D666915
      F094C2809B9486458171C0DB8BDCFB55B81080BFB558AA4AE4033AE60449D4BB
      7D3E1AA95F3B81F9209EE3ABEC87C1F0625553006E552CBC7C17C14CACC0CBB1
      BEA6B005F18F4B04C9B925CBF8A43F55D6866B77979E321BF8D9442126AE803C
      9D88CD53CE5AAC37C7F63885E2B6337433589BCABD06008FE26C4B4ECABCBD20
      5716E25F13916631568E5F714D25B76691ED6ABCB117ACCCC8A91327E6488261
      BF05FD460E3E15A5D10CBA4BCF0233C50045A152F3B5D9E3DEF1B9F59FD6D95B
      988F42DD6E5E7ABFFBE75F8E61C3472BD830850F8A937145B1C2E4B50FFEA8B1
      12F9A0792D459C28B11B1B3ECBC8CA8510B3548287921255BAB50AA2C0CF143D
      59714A89482B83DEEA04AC066091CB7C0B0815EC54544BAE434781DC2A117834
      38023792C6CAB6EEE790CAE67B42B57758BE84BCCF88CFFB4FF4FF8BE3A9119E
      05E1F9EF18F135F1C0F0F6926F159F084DDD8F8FBBE1852BEB622D458DBD6DFD
      2751D0CE2AEA288D9FFE7E187DFD8836F3D40C4C2F3C92DD5251DE382B2D0D85
      18CC31CB0324B8861D9573DD28E2A39634E4C5935D91B24912CFC7DC436083EE
      D8E0D16858D5A5FABCDCA49998F2579BC1308E54CBCC05DFC5FADA56A9C8EC4A
      0E4A031ABB0C3CFA5EBD16A7FE4485C636C52E52775D6651F1180EBCF0B85B2A
      76C51A950DD90CEFD53E48D8782CBB24F0A2B411D576B4F8288E69D0DD29F51E
      4D059E79A672408E295CBEE97BC905820EC52A4022C46FB129B0EEB4CB56EE01
      5C666DAABFAAABE5CDC58BF98185FDE3E3653CDC829D5E209CB1FB83D210B8E5
      AD6C6A5CAAD7A319740805B50BD04026DCCD4DE9047C9872794E03C0AD62C6CB
      5498CAEA8739F2005FBC2B6C5F86897BA87B0DE5B86BEC1F1BCF13C3B10ABAB1
      6CD19612DB22B0298AD5E60301CD4A8704D9CD01B769637536F21184CC4B5279
      2565EC90068DE9C1D733807C8009719A03D0116D61EF8B17A2597663617B8D52
      7063CE431D835180B1045E677D2D79C72B6CF18AD4C6306FCBADB634A036FB7A
      D4187F297BFCE4FE5EC50611E9A8E323B646CAD10F937BE6A609FF03F05216D9
      2C215EA36F1414FFF5B5ECCE72F262222FD1B702AC0C73C86EDEF1781CCA847F
      F208076190DD70A352797D16C7A124737993F4F8029181E4632F3248C14110C9
      4EDC1CC6E093A316409B445E7C884CA2FAEF7BB0CAE62DA2D331BD9FA8C908BE
      5D8E1653EAF830C3C959E592CC62CEE9105BEC48D26450C8CCD36DA907656CEE
      D3759BA5D77D577CB92DB5887CBE0444EE4030247D3FB2FE00EFB873F0F9230B
      1943C50B560351E8FADA95EE1809E2B10CB2A2562C6B52001B71F6100A571071
      A2D84F577BBCE80F23B02D308D32559D7EFE6E015CFF1F85D74A80ABA691BB7A
      7853184C834CCF9893B33008FB5576D1000048AF46E58E31192E225C505EF12D
      5814965E108827634F9B54EAD7D72C434F0F439B8D1FBCE9609E8C45B2619D80
      D16428AA982DA38143B0D9A848F094AEB18A307FC14E96532BE42A2877D0C425
      5B95FC649B7AB8D996944058FC4A95E111004AA4EFEB5690B0F2CE11CEF2DCBF
      B7D43AE23846B6F66F628F753BDFEFBDA938C6F6449BC188C7DC4459ED9A5460
      C7E0BABDB3E9F9B608B5139CFDC43ECD0CC78A9196819AC33C5223C103D01836
      FF46AA842F80FBFA32B15EF6B922053D1F0559EC7E95021BBF014529CB7BC851
      D3AAA20F95F3118DD2F18010EED9B1F26D1B045EE2F7E78913DAFB8FC8852043
      9D7ED9A48FCD421F58FCDBAE48436CDC09EA45A0CD736CC2265D689EEC7E2F16
      D6D6A6B2FA020D8869ECCFD1AC57FDE2E5F43672967BD606F9BF36B0783BCB1D
      6654A40A474BB3C378E81612D06CA66EA48CAFC3EBEB6B8BEAC177ADC36B8FF4
      F930288EB750C33FCE99D43CEC7CA7BD8CDA61A0A675CC67F8D16D35AC0D04E0
      867EF54DDBA6796C07EC3068DABDB67E717DCDD1A12D2F3B3C3A3ADA52FB9403
      F168DE59164C4B3DF0F599E4DD3A80770C331ECBC1C3CED841A81F83311AFAAB
      9C55872FAAFEB82D0F3649813D05E3204B950A29E7962133FB747A4E25D361C0
      89791E3512F0B12BC8348844F1D15E74338567E8532DCC28C0A80AB238EEF44A
      5E569E9AC7297AA48CA2899763DD289FD6C605CAD319282CF80A9BC82751C7C5
      4205DDE08A120623EB74801D0E3E1E6CAB7134D40EC2CB77181427B36D8341F9
      BF08FA1A95C064A55854DE422237FE96A0691183554BE48AA0340E699BE98E2A
      AB98B5F6711CC1F9C0ABAEA4CB2F81570F9051084AE4495889248DC5D2F892CA
      25A6F14139111658CD0A2A6C773EA762EEC70F85E2B3E70495A088F029904609
      A8CC08245491FC740B84074056F2406C8595F2CDE8D4E6C1A6A4E8C8C601C408
      8BC82FE9ABC84E8D82F20D43A58D9E7217708A93B30A0378690E93E2195830B4
      8A714CEB6BD8E09E5A893F7416D3CB4C6292738257D57461671477DAABE8B39F
      2E99C244BD7D59452056850C0DE1E3E703CB77AD2F7A1C31E5BAC871CF921055
      751AE981451D90956662C567A4DDDC9C05D7C045A70C79FE3327CFE839C5A9E6
      C1D42040AB0FB7E91F9F96FBC9B9FD8A5464677140B392D1DC8C6EE24814DAD8
      79F2E53068CC63C9C238BE40AD72C93BE213A7F3E1846366188B1AF2CC975277
      2C0A8CCBEE5AEA7D3FC09D1829C651311EBC8C37A5E9EEB00E354FE4BCD294A1
      94C85169235417B3896A4A5A3C0286B00FEF178C6EA41333BAE176D45F2372E9
      6FA871C0B4EF8589B846C4DC4F1F5FF259D91F6EAC7D8F628846CA54C02788F2
      B185D2FE638385FA23014B1851AA077D4534CE2953DC3D89AD1C6AEC5F18279E
      089949C736D6FE977DEDB127B50DC98C46C50FF9B19C59AD490EDE8F0353B42E
      DB4D38089A9E086B028BE0B03066C525025842480D1DD02443A289AC16D89B0B
      03B8C9AA8F893A4BBC2FF3884BE6F7BA609E61BFC8524A9D641016B65EE3C03A
      BD8786E3021079FB722627A69A13D5CB076FE3A762110DED50F3F1F4FEF3915E
      8672F20C3F5365B2F77F43BDB4FF3B7140DABBF464144D614E77E703869DCB3E
      05A87464DC3E63046C09B48D798626F460CE334E159F93B9F3CA7BA1F8313270
      05748942A52D44CBE05BC4267671907AA38C9F5D00355F8280A4DC422E722B0C
      648785370EBCCC533B27C2171B8CADDE309B7B21D775F2426048D0500AAE7996
      EFABE5009CF3EDD793C97F55462FCD275FADD97B00EF44DB5E89D9FBB7E2902D
      3F4811235222B8A124D81542E41828711573C8012A3E95E293FA54C4F33CACC3
      B4452333F14BA579AD42A3D5F0C2C8CD0A545B052D0246115A520C29CE9DA08C
      58410DF2CEFEFBFE6FC83BFABFAFC429F237665C52EFA5F4BB1C484637BC3F94
      05EB043BA836900F5AE313CA15E5080555A252041B35B298C88DE504D47D352E
      28558551E4D59A8C3F27CFA72CB893610791E0059CAD3BC583E2C65E785669EE
      B7E684298ACA90E0E5813A7915C7FEE7AF9827220AED96A48F8FBAC1E7B61C2A
      9738FA07C31BF42218E62804220C1DDD91C15350DFF164A4620FAA7EC335F452
      492F0C1F690C154D2052D1B53AEAE559C3CA702A68A6E59564344D3BC4D51A92
      C28A4DC2BDE8AEB6BF06ED1FD06F93A66F01B8F1361AD5485343625FCCF017E3
      D1BEADB29C306790F1505568AD3D8E1C6821730EFF1224347F1DE7A2E73EC1BD
      4F671FAD4D74FF0D6EC0400539812E83048C3AAC0A91D74B1E2F4BB352DDD859
      A5B4E6A7B489F1726E889D5D09CE4DE7C552152382D7A047B1270E4BF360694A
      7CB53E63D95C3C4FB1B57AAA32E939003C010D9F1AAE53522E6CAE343A96FA94
      B3AFA100110E31053E2ABDA8D2E990386D5ABFB3CC3F902668F96F92458498EC
      26AF2807A60B1DBE3057810A6DAAD7636B4435CAA44BF5AC6C354F47966DC9E6
      C7C3D04BF13278117518B9F10C7B92FE1DF41E8098571547CA82269F6CA88C73
      F91229FB4CA88D276DE23B74966023736A36CB39461467579D00680FCA445F0A
      9AD33353BBFF80D6377482EA4C0D2B2BCA6FCCF1C7AAD23C91ED16E65BD4727E
      ECA1EB119D9612134D7AF137A7172FD70BDE527AF1FADAF72CA3F4E1EF488E87
      5822A338947745EA5D84A26E3BEF1F8FEE32AAC2D8C6340691E054F128CF3BA0
      8420B836D14DF655548C461BEDD60DA37E3CD93B4083112703074C33A029DDCC
      84841E450592C4BBC9A949C3932201E21A364AB3B12F6E9260CA36BB873150AE
      D267BF301F84F40F2BBF6E2E719574B33C7451664144F94E394553DA1796BEC4
      D2C95D9267B501B6CC7C471D64096ADE8612FADA090157D0C47E57BECE2ABA57
      910E76C5BD9A25960429EB0B08BDDA9DFBFADA79E245299005C5631E76F80B24
      22D98FE4334A87A23C271E7930E612B554885D4C2FB44E0761008A59B4ADA3FB
      0D56DFD4AFD4D3068422276296DE039E28429095853AF429967B537D5D8A217B
      F982ACCADE8EA8E32BACAF2545A61061F79C6D4E23A7CE9F40E5E19CBA5E4437
      EA700BF0B136154C64FD1C47B4CA00BA9F4256461F8BA4F99A14B2A5A2BCF9DF
      78B81E06DCC29BDBA46454C98EB5A8361482BA053A4073505B328EDB72AD4D32
      7276AC632FC3B98E5B05BF26E06B0CBA42C2ED4AE6E983C36DCF1C401ACE76A4
      E1FEFEBFD4CBFF7D059CFD8AB4F51548B395EE1A3B8B736BA215EC7C9E8DBA2B
      098AF1882E45291C09D8C5F6E97A3260322566C4EAF400F56A2E5BA24C334937
      82048662538BDA2AD577DF2251292240547D3D3FEAEE4A1B919BAACB0282F2EA
      94A7B7E8FDCAD795BD87D25C4A73460DAECEB90F20C05833D5FBBDA23D16861A
      97F2ED6E2B82B41372466100ACD836453B3523AAC9E0B282194668A40E80C280
      FE267F7F7BA2F025F31B48141A17D203CA6E251E19EF5121B53BD62AEA262A48
      67875C8A13873EEBAAC59AF4122132C5A2E23B8E90908D2BE99B5D49CB89E72D
      B992E00506C110543BD0F3DA753B604CEE4299B54372AA766FFF6F01562641DE
      AEDBBBFB5E14A4F2E5DDBABDBC88C6617DDF7E14443586FD08D372EAFAF26301
      FA7C54D7974F84B8E0776FD4EDDD27F368EC2581827DEDD82548FB30A82DE6FC
      CB9B793596B360855F89717DC13F8B7369553BCC477FC37C3C67ECA923F49379
      9A6ADC71EAF6F66099D4585948AF845FDFB7CFE6C9857EFBA67149945D126787
      C6F9F0B2CE87C69B773E2C35C40C853085A81876B314D1EEB40DD9BC2CD9346B
      4036AF4F31750D091C50C206351896612B4C20D6344355C1DCDA98C22C860715
      E29B1F6F35E4A01ED193427600E54E5396790ED34D6C2A015FC9002417CCAB6A
      699D368DA4697903B8680BABA969FCC28D2A1C299D89B5298B53526BE32BE517
      94FEFC7E635915358616A9B66AAB9012CE2152DD911783A5D832BB902C8FB152
      CED4BBFD1A2ADB612622CECEF1783004CE8C43086094F4F523933F0F672AD2FB
      CB4A12755231E4660A725611F54FC6DE266AA0866C0018E856C77750574E41D9
      75CF69C3BF4EB7E1C20FB7D3ECC28F46BBDD841FCD56D7861FAD660F2F69371D
      BCA4D370F192AEDB6CF2DD780990698796B17B3DBCC8717A365EE5B8701DFE6C
      749A745DB3DD6ABF2CD9AEBFC644CE223A48704B2DEB6F982621BFBAC09EEB71
      F4B736FCCFB0BC62A67D61740BE5515B537863C4EB5727EC3BB35A5E92A0899B
      C3E6834281D926771C7D75202082AEA47B429046DF65DB322F13240F222E8F2D
      F2B0D54451AA145026CF8DA12143DC3A14536740DF1E0A991B5648190269E48B
      24C0C23E128C4A869A648F076976A4512898193EA61FC929CBA49B614B5FCEF2
      521A187CB371C82261C3DA848F1BA4F9687393E66FE50AF288D26A8BA9671ADB
      F5D0ABE9944A22B0FBD8EA1240C3F7FFA5DE7A051990EB6BBB721C11B7B14BB3
      A0380149F6CD2076925E05190D572AA6E81592E0781C1AA5B517FAFB52AA2E58
      F0D3191DE158948B4CF5DD5AC15EC119FC17A615FE7D170CAE95A46372998D06
      4070AC6072216E08C7F37A01D59235BD750D65EA63710FE7481A4EFCE0691779
      AAA761C50BACB862E6E0D22A71F24F2C4254B51756C39B72FE9C4A7EC28DCD93
      79849D44241BD625C872144969FE41518319C12BE198B5E50F475B771EC9B14F
      F2C1D4F0414A164E41DE2497FED1695396E09C76DAEA02DC2B65124B02CBA829
      97B81E0A6066D23CD9DD2ABC4F09189C97CCF520B72B0EA85C7E98082F939DF9
      707F64AFABEE685CD64EE9C3B29AFDEDA50FBF74254DEED3F8C6CEDECF0A85DC
      365D8D4ECFAD05762DB13BDE7DFDED7316EEFF48DDAB048C5BEDC45E1C18DC9E
      90E844162BA89EFF9E85BC2314ACCF6922F2451A24051347F7D55DCEAEAEE468
      C6202D2A36191329D9454C8A544DE785D670120743CAEF5F91A5B9FA0C7F0ADD
      70BF53ED56CD215B982891575E71838BC7727EA3D3DCE10A5A52CD6AD49ABBC0
      53EE22536C20B3843DA0345A5E024415B68CD2B3241E27DE54366BDB9405667F
      560307FD72A522CD3B0DED97ABB65BB9A1BD4532872BD8E4CC1D16ADDB39FA51
      74099B942D04C70B4DB352424DB80E910DE350DC170D4C3E6BBF3833582F914D
      92783E9EDCCD5B65BF50D5972965E415B285E022B8826A6A0D9E156A519CAD00
      63593C952386650107567B5664259BC818D0E154A8F3BEDDDA6949FC315BD67D
      404AC971180FC8E62A980D9B7836B32488139A688DE599CB9D305B0589FAFA6D
      8487B35235F3EBEB89C87556B1ED1D3AD0556FBEE4DA9CA916DBF7D578BF1458
      D6D7DE7A8DF7CBC6C25683FD4B2ABC5741102BD97E69460BB25974125DA1F6AB
      46620521F0CFED55757C2026B11A5298D1148624EF2F52924B2879D4BC82B2BF
      0AFBD6522749D9B704B4601CDC7053F461BD1DCFCC2BDABF77F8EB1854DB9C49
      E28B74980403ADB58D5621A1D6D756DD3C6A555EACF5B583C41BC7D1204EA26F
      459BE7F560E90154D41F290B2E4578B35D5636EFD40C79E24CD9974C817AA5EE
      9152FFEA00FE2FD0F9AEE17F0F13F1CF4D89693C15ACDEC8A43A26371A4D6D6D
      DE9E54BB559EB0F340847C5E4980D05A8575C3D6C50A36BC9A8637968C8E2EA4
      06B152B47D0F3B7A397F042642AF26DE9F7B12487485389080463935D5285C4A
      1E43BF5828B813BA9DDE07A897642B76AF61AF84AD188FF343A2E8634B44F0AA
      A67DCD424A665EEB22E16345C24B2A261550F23736CBC7BC9AE2E40FD0166508
      949C46DAD353F2099A14E597E7449CC3AFE0FFDE9215B612F2FCD771A951A16E
      FFFE9EDB11DEEA4758BA7789C2575EC0C917D8BF4982300C86E515A807DBAD3B
      E1E56DC7DAFC7A7EB4D3DD3224AA1FF91326A5FC59E3B56AD0A2E62B0A5F6ECD
      F803BE64B8CB2B1440D8F67BDBFEC5FAE00D2FC6493C07EE8E23F844F2DEFA59
      66604886B37B76FEE5E3A7EFCF7E9154FF501E61685ED2FC9FD0511550329CA0
      04966D8BA683A81925DCE833CEF2A25B43E62F48E6B9174A675455D0B3B54929
      030A6FB68C24BF87AAA5671A23A46F94C45F325D92B300A87222201AB7543777
      EE019F77663712FDF5247A73B9442FF8A2453AFDC53A42CFA49C4CB749A3EADE
      EFF58EBA8D0F47478AD0BF65B9C730926F59FF8C329BE4304B332CFE6E5EB412
      97D97FC3FF56E232CBCBAC80DBA02FB1E088375CE96D7025C75D4EE6FBB353C9
      23CE459A01A9CF2A5809B1AB1F2890621DE4E7BB4215A5AE033211F616D24102
      BC22F243C34C17BDA8E16D08115B1DE024CA445C254196E14CCA18EB9B3301C6
      0CA12820A587E58AE826D5630D7098A24703ACA60176FD27C6A3C7241607F708
      4CA4E440AC777B02818A0B9C156CA86DBAF8FCF0AC89D5446AA0CFA71F8B1B58
      AC9BA68024B710A149CA29CF0782455AEFCECE0E65415233CF1D96CBACC06F35
      0BE700917437BBCE5653F7A100A36AFAFD58F0E81C5500124470B400DB7CB42F
      0BA0C29B6FE9F1BE1292239A8EB9781F670F850287CDA9A35A52F9F3D220C7F7
      A4D764A0AF2A5141B6BD53C8B8AD461CA9B497D7B7B440075D89170521B08ADD
      862BD9ADAEB82B0D73C930DD8B47B820DB942927876727D628F4A8C591ACF90C
      4652DB9B063CC6B7908451CC3D2BB1C7C7F47D7BE903E0666F1EAEA8FBBF5147
      38F8C67276DF48FBB7D653DBBFBD38187F43D1D9FFFD4EEA7D410749DD30CB95
      98F5FA693A5F673E90F883B9ECF3729D1D9435CFD0FD11DFE9F94E08575B3822
      F8CA6AF0199D8E4007C46AD083E37D6473B08A8FA179C5D7768AF2B36E78D85C
      191E2A8EF13F3F7E591D3252E8EDC72FA566A64DEBC72F7541D1161FDF3E6569
      C791B51FCE0752837B014C5DC916DBBC45A5836061316DB02EEFDFD995FDFEA3
      9DAA3D186740C7FA38B2FC39BCD8FADA9894461A813D2A5A7B5462CE885C9CBD
      CAA57BD2BB8E161F1B907124B8DF23751EFE754E6D02A65E9AE5450E6A386B08
      D4E3DF1493265897CD6F2B0C7AE5C704499AC971A3C835AE70A525E72BE715CE
      E661C82F47552A41244797E3F503C0948B556522D6C9978653934FF8207419A4
      E5835C8E4D0DFC8253ED167C882E14296DEAF254791D56F7947D24D80F8C8240
      D491CA4BB0AF97FA1B51E9183BAAE20FA6A874DBDA18C6B3F5B51BB41C777777
      09C737D83D174C83100E07678792904AB7720F5FC1AFA79D7D8A18B8D12FBAF5
      B8D6D543EB545C0680074CE292F26EE2B99CBFBD40B5FC6AE54EBB68EB0EE370
      3E8D1828E4EB3E25A6B2390EB4C54B8E4458CA4B0188B2DD0FF64DA321DBCAD6
      255EB4B5ADCD63FC74CC86F2E6A8EC5681ABC8172C9F448EC712C879FCE1519C
      4C3F1E589F13310AAE8B66F465C01DDBD421C82C7F6032B045D8AB8450446D7F
      65091265A24A88A9B54EE4FDE4DE51A6BB04148F21A7E430FAF3C334325FE0F9
      F9CF1B6502FABA103BB2B47D65CE2000F27719373411C38BBCA6EEA8443AEA48
      98D52B21226FD17FA542FB60AA1B25D0DFC9F9BC88AFAAB1349DC1CFBBBFA806
      41280D7FFEEF5F748FCFFF0B684F9E1BD505DBBBE4B46172B960A19A8FE580A9
      C852BC75E185D42A07F11CEFDF87F7BA4079B99F25E17F1E46544F8CAFCCEF19
      47F0CA99E62CB948A4F6D2A50E62C330961D3798F7F03E4EFFA11E481154CD81
      36F6E359996780FC1500263051755E35D1B9267372CADF94BAFFE4DDA3F07D54
      F31E20CB779A20A96D6E2A9B82632BF0A2A3EA01EF84E49F0029C5F3B4C05E81
      3F25622AB0D4E47547BAD755889F5224110EE7BB330D44647AA922036B128724
      58F6CFBF1CD371F88CA143C4D0EF8CA0D78FDC23348EB906EE91E0CC05313548
      DF55ED6B899B8DBC30CD4984E301A881F313597C6DF3C2AA1DF544843E3CE18A
      656689B7307BC449DBB32C4F0B389135B4F0D3FA1EB8FD8C036B9BF0D620056E
      42B125BB81E9ED61E9C4CAFA5FD689D48EE6C88E51E4A848D7EE7812C339C968
      A721A53C08C380C9F3E7551804CE3CB9E1C2D34DD91852AA6E73E06184993C3B
      9EDA13071461BE01C1E7A3E230F1A4122697D7524A2BB8239445580AA4D6A261
      0D85B7817B8234DB2EAE425F63C2EF18EECC85CE21BF9D242BD20558FEF2CD5F
      3FE61155542FEE7C2F4355D5A8B25F3258E204552A605EC4BB52435AB7E095C3
      065D25D608E86A9EC896D35AF800D6726B2A39B325462B2C98CAFEA078D938A6
      341024472B042B118905BF299A6333D09F739B091E0757935298C5996EB43401
      60A64AF4944F6D3BB769A31BD611F96DA927D795C066B9A92CE2E3D93D8C0A48
      5CA0268A319BB7B409D536639B0C32B6CD50C38F3CEAE0A59FADDB05E8AF184E
      57DE0D4ACC0C1FCAA021880D4542C9109BE86DBAC291CBD1784BA77E929EEFC9
      D43B65224E6467A981187ABA171EB501479B727D0D25B404548ACC2C9E47994E
      8CA1B605D42E2B556EB2AD5DEBC30DAE4A9BA2F7A44EB87A0D6281514CA70856
      04EC0E4C8360860A7D405DC946A00F64A0BB6752A2B3312F5F57B58747655BE0
      9BA012222DEF4B54E029FB67C28597F3D912F851130564DCF892BC5F09A9BCB3
      B934E863A09B00B551E91764C8E56B82ED040BCAF90864AA614F50B9839419BC
      4C544AE310F37EB057032626C9AE6E78D3E20E26BAAB438E81646A115F46137E
      3ACB0082DE65306684D26E0FEEE286A9E037EC10D938220700D94578B77EB78D
      DD82C626FB95904707EF9BC580AE1ADBD1518AC80E161DF63D8B799E04881D39
      D30821804B01ABFA2E952E59F9C6B06DECDD1F44B981984387D08D2082DFE3C3
      6833948605A82C1FA95F9D011D61C7503AABBBB646D43DF52ED02F9C3153105E
      7A233DB7B003628A0BD940DB4C944239B4D03C964795C5F204D7D7C4C221B33E
      3A422C811D7A63A43E5E8776901F21AC41F84624810C64E1DC4DB1F9835DBC4C
      C7670B4E4C2354CB59E894DC98A7F992E3897210955CDA969E8E4A88EA625049
      51F9B74452CA712B831591F6BFA7B757422241393D8DB9C32566E629E909985F
      F064E60FD19D5673C7EEB695C6E4E84126EE07D8821EA84E5CCFD4648420F203
      10BFA87D97484F3A7F8384DB5E46595A749351DF2BC94E0A4E51BC91E243C03C
      02CC2C0D48FF56A573FA09058170037262CABE734E8F520E37E2ABD2DB862CF7
      D203D80D423333E701E87C1821A4DE1D0429F93211A45F04316E7DC686F84B01
      9E526F57D9ABF847C26885DA488CECA921FAF0256CB15B2F413B07ED7651BB05
      0D7D1E69470BC84285DBA8C9E41427D3AEAF4A8AF4ADB0138BCB9CFC0D0DDC61
      57AA3E7B06E597A2BC0CDD6557B1C589AAB152C30A1666247D1DA5212218AAB7
      B899611EB471756E4029C1402C53BBF55C9EA8D0747763BFFCF4DDDDDD8D9C76
      E462C3F5B502A16EE3335146D022146839C9F3AC97E9FBA378883AB414CF1C8F
      E1C72E4876E007A9D4D86599830A5684378B311BA65E9C174A19BC5199860F69
      6C68698E1C1845185549593F0FE3F882184256E03ADE8037025F86204C33AB21
      6DA9942397EB6BD845595A59FF89D05726EBD66E2543E3566E6A4397B7D89B77
      F7216C170C4B2A49C3409E47891868A52D9E839C0CB1C8478374E114F419D371
      1056B0E1A692136EE946989FB4BEA698A80E17923D1F63886B30CF446E9B2AC0
      49B54BCE85E5D7C29363735429491C9FCB5BDDC985654DCC80FA03670C430CA6
      179066D7DA2373124D9D20992AC45631358D2C654CA35D0F84B6A59462B68040
      FA3A9E4B6B64C0B7F8CA240C8D0028E93C8B18865497E6439B0BB9624401282D
      72DC17B794F94FEC7F286653F090E02273F818A522C976B5DD232F9C02B1AEAF
      F9E8B3A088DA55748BA50097DB9F2729FCF9EBCC7AA73E1F90B1B5FF657FE199
      E8B3D0AD770B2B9D4D8251F69FFC166ACC969715F2D1146F27D9424E0F797130
      E20CB8914C6791D2811E1D8CAA96D925A75739C48F49015FF6D5FBCA740F78CB
      F5B5FC3D0FE8DB425CA3987D47CF2C071A8B1B2E24DCE173E41BE7E3B065CA9D
      7C1B8A344EA9F62FDF5FCA0F0120606BE3AB40BA39F3FD15CA5AB870E5CAC349
      AA6CB145DA6B7CE8C1B2A53E13DC46121F8359048F2A60594C3A7DBE046ACA31
      F54685AC53CA441D35ACFE7783CE1BA95C693FB572E5159A66EAAC841D6BAF20
      A23F9D9EEB744E6D4EA1B75846BB25F6E8FC30CDA138D64D1D4977EB8631E79C
      EDB7639D2E2A242A0557124829BE50BB6D9EC5F36428F0C01735AFC57DB2DAAD
      632779B08534DEF535DD1B5C26EFF1E14B2F3F852B8A6A5F019F24A479924361
      E00B3D5CBE9F7A9745E9551B380350060C8A1D940B45C0EA74EAED32F55037AB
      7A12CF470ACA5BC7A7BC5B8CB6CB032F48B9A224D3198379E47EAAEAC06910D0
      FA5AAAD3658A78B06013EB91BE0ABF0AF96E3C9A8D725EDF3FA64E6E11A2EE73
      1726B98B6513601FDE2BBD9C66F3F1E28B6E7EA8FC0AC2CB8A14055AE6ED88B1
      3DAEE1DD592CBC2DF542CFF340A618414FD0660706F51CA4F67A8881E6B4F501
      2B2760B7C85ED1012286F35212FB950E80520628268E81464777819E1BDDE81C
      569D2D4DB5188B84298779612B587D8B24D6C1EDB5462AC8B0742D19C08D2A16
      3A9F14FD51A90A5FF352286FE950711A26ACC0BD038C91583212494B57AA4916
      8FC7D2DD433E1CE9E29892C8D5B60B6C7628C87EC2712798ABC85171BE54FBE7
      A6F13CCF86FC2071A29C7530E0C42B9F1A21A9931F0797D4320A13B217B9B6F2
      2591B307E3D98CAE188E1289B135BED9D6E8D4C0D6F85C723C7E928E47D96C41
      3B01B411CE992122933EE2A958F467E8F06CE16F7291CD6910CDD33CBF6FAB76
      FA14C168BF941B1433F7931AF3345E5FA3BD623C00D3F631F04CA050EED33098
      0D62C4CBDC1B4C9AD88013C644A11CEF13B506F283CC70D5429AF93227F16D6F
      2FD5786C2FF3822B4F70A1AAE5961FBCCA59C7A17D5C09A51E9FE02EDC39E680
      CF484F73E61BD6D7300AA95DDFC48C75F09EF6A1A2F6852760306731DCBCB1E0
      E647475DA9CA050F6C4C9557CA011E892B4C1022EF965E9C9C48A51BB9EAAD5C
      4F647CE277A466974FDB4445AB414354B4D0BDA934B42CF7B80EE4CC89BC702A
      5FAC10FB4BA5AA82913959CFACA2561E25FDE54E5E8DF2B268AB1841E4624A9E
      79C14DD2D4AC34554819D128CB8908B583E314130A6FED50A60D5F8AEACDF135
      3C0A8FBC738A8059052F1442CAA831B968963FC98FC9501A08CE48469F75955F
      9A9EA2B3EB05B69FCB0B023C1A5C557269189ABF231F48A64C9B548825E238E5
      F4782FCD83ED488739FD61A807937AAC0DCA1BAF4850581803518EBF8FAA3212
      0AA5D99C57C141B882385D8C7E4BBF17124B5AAE20CDFD7D4AFF227A5E542D3C
      CAA7D3C5997A1E6529FBD650D5FD9843313A43564F272B0E761690EF3929AB14
      E9CE894909359D6F12A9EE07794ED33271CC1E600ADAAEB0C0AB4E6442EDD154
      A8DC50C8232824B236B8C71CC5F3810C5E8A528AD958B7C4D1A2117A9FD9592C
      C6816BE54CF128E6A4844437CB28E664C19FCAE625AFBA8C80F566F59B14F2D7
      D5BB543C035FAF48DCF7A7F895DF6A3889635A970DE852E2FC9C4E8A2370EAF1
      94B0A1ED5E9DAFA1BA41142B1E4DC9E8C34A46F174CFE42119A65272D92F82A7
      CC07D09CBCA1264079BE579E94935B639A0254B6C24347333C6F53C35B9BD9BC
      DE5A5D6F67439577C83378796CF5523EAF0D439C150D462AE0C5598953D866B0
      93ABA2F9D0E19FAF7F51247977B791D6AEB52F530CB956C5E78CFD8C1624DF0B
      E53458E91493B8135EDE2DB5F0A97E0D322FF5EC929C8194729B2AB2FF39DDFF
      D6C68B7A4C8573785B572A972C5FF5500AF0E22679286C21CDDD1B94F7C54D0C
      655EF8EDFD84C134600D22CF075DF2C618FBE0D26F0C8E6A0FF665E02DD1BFEE
      0048185C081916379CE67E3AFAA2A7586C5088EA6742D359287EC9C31B395618
      0E54560FB81BD73240E514B8A9CB2DEFB2254A15245B4BA68C14BC5BD4440094
      0EAA6B57A1476275F08025A4057AB7D8B53EE262D93CE15148783F4D1F11A91E
      4CA2DD5CF0703FF1C663C51C98B7E94920B2E6C41A625D9E748F5172337D9396
      B2C512784E897B2843894D24EA4C404DD4F20E66B32406604D0B810205CBBC52
      83D93F835F61ECDDE7B098E54D50906E8A994830004095FD779C28F5FF28347B
      52E99338519B085F378553072DCD2455CF8B615D7E148717C86E529D270DB77A
      08B7523257FE4C511650EF08C399F423B9278B4AFA41E050AEC6B2AE992FDDDE
      7D87ABCEE561AD643825F6BEC0A01C927B4913A257E3114BF2FD1409FE20FBD2
      71850BE579EC85B2C645372A919D6F585341BF8EAA2B4E29472B1895962E44FE
      E9B99A9D47CA9B33F452E9EA283638E19B555F2D6E278D8D150415F8A8362EFA
      422F91EB4BBE1CA07F95905926DD1A2EF300DB825A7A728707999461B84BA90F
      CA309E4EB93420222725487AEA0E9B371D929EB98927856CDE304366B960A942
      A99B0FE1F866A19FACBC30A01E1CEB6B623A8B61F7377937BA2B8F43B1F308EC
      06498F984D8E4D5E7DEE9BC3D956134E3DD892E56BD8BB49A936583981D57902
      CC185025BCD94CB547D794F2EA3C93F0EF80E07506007D7D17CDFA1A7B5829EF
      C8A3DC81682756934636F5A7BFF1C03A2E9DDEB6F4F77E384CB7ADFDFD74AB94
      EF8CF32B38D17509B8570AE7F53582F47B0F877D6C0F70EED5F6108750AE60F0
      470E79DDB74AE7133E10969CAC4D95A753EF06286818CEB1B1983A9F0547BC91
      05D5C7B1718629335F234AD7B37E08A26C03D8CA2CF48622CD4D960D7240210A
      6D489F941118056E427EA26590446E2DA336D2643A956D6136632A5B965BDFE2
      D832A72CC91C754CB49DCBD5541B40D0DB94F3CDB12DCC30CEA84BC0006510AC
      3881A7E67A14C7BCE6912FAB227EF0A68379827D014FA82346282513C909F924
      99CC861DA560379C7A855954B9E493572AE2DA5749FBD4352250395FBA41CD3C
      C57E51D41375B145CDD2257EFEEF5F14AC68359C2289855D242AB9DCD369C9BE
      18A9148DF03DFA2D81410032A0C58489C81CEFC35789E2F8DF42DFACE166D8C3
      030D528C38B2AF53D5F25882FB1A13B0912D187650F0DC6F2C406DF303D0ED96
      02D586E4018B55F99B7EC1219F2573A12B062ADB7F4B0D52B58394850AD3EAD3
      DA5479F8DCE9136B6C548B47ACE9C2D73454F1F01C498059C9E967A8204F782B
      B69F5FE620250F2D21B297090E2D07D10E291E540612F304E18FD8DB17A7B648
      252F9595DE5BDBD6112891999C054D981E88D0973D43B1F30D2F9AAFC5AD03A9
      AB3810134E5E2FB4D83F2BC48A96BD072FCE5EA6106BC72D3F8967DC7E04E528
      35679DC5D41519E49DAC00DE14142722770CBF7771FECE643EC656D69BDAC14B
      5585DCE6D51B474106FBDDC248935F68B66BE8F20EBA643EA7B25711E286244B
      019D2510025594DA44A13ABA8C6ACB2DB9C81D9DB03F0329624BD23136C04F2D
      9E5D032225E04638E43F1924C2BB906D0BB9D977CAF577471C87F060C3EA6118
      373298FE002503DB50CBB6AA06C50BBA17F2546499EC3F46DF9A6AD8ADDAB733
      D08AE1B2E12410058B668381BBD0027B5FF54E3F8E01B5D38D620893E73D618A
      C69DB7A63C938D8D39BFDC4DFDE761A62EC307A4BFA8BBE51F3FFA2859865E78
      1E9F903BEA270086BA63DBCAEFC6EF8BBFF36AC50CE746E935D7D712CA0CA560
      6D90615CB2185254561F152BF92ACE525E0217B0367540914DC8FF9FBD776D6E
      1B49B286BF2B42FF01C37DE231354DD3BA5037CFCE6EC892ECD6B66E23C9EED9
      B7DDF1040814298C40800380BAF4ECFCF7374F665601A0285B9E565B462F2776
      DD920802A8ACAAACBC9E83E0CE52253DD9D59E2649CAD672B145150DDE7DA1E3
      29E9070759395634F508F6926D856451C51656D8000D8C1602CD2C4E31D64354
      85755C5CA0FFE3EE219998EAB7483D04E9C83890A1240D6B8D507550ADEA2B88
      1922FE2768605C6056EFC1935FE976BA21B71FA0586AE6949024F5746C09BE6F
      2F1018781D0E2337677E9903723BA132A871968235A5EB99EEB02B499FC5850A
      AEBD5EC60D1FB1F1136652888A17025C91187C19716A9405F122E0010CDC9A67
      FC75E14FD1F9339C099EC246E47B97BB8E63287E65BA74A23A0F95C2E09AD600
      D02B71F40BCA00DABE4070B88D2982F5EF962C683D3DD016FC72D0372C53D97A
      D7C5059A39CBF797A20499365739D50E785146059A8CAA646FFCCA6BDBDED492
      37D176A9D14D024E60912A9D04C52403E6BD4678DA5CDFA3EC00A801A82052FA
      1AE52FE132F5B999199166CBA7D7B62F33C6F0C21C05CA8B34E5739E91C227D0
      63B694C8BB10DA87C505AC51741C4F72C6F1F45D50C9D6812615D08E59F3626E
      B9A55DAC69462EE58446756AD97FADCD7CAB7AA2F1DADBD5B5C75134730B8011
      88B5029D2C113751872CEE4343274C4B44DFFACB0446CC7955014BA988E88D5A
      AAD456BD55D564EBCD9DF7C6CFCD194F404BC13E39E8DC4F6FED6C6A958AEDCA
      ACD48949865AD88AA48E0598EBEE8AF69F3D76320452C4DBDD3F3CC4CC804164
      005D10D84B97A676C8D47B9418A91DEFBB8EF75246FF47EFCADCE5D3BC1E9ACC
      25C1495BF74E1CB73AEEB763DAA4567807C935EC375742DFAAD12609D67AB9D1
      9C5ED6CDA4E79F8D75DA6634BB232C3476655FE99128102D16F65AEBECE95158
      86DA05EF57D15DDD24B816778622E00B359A9A1B7777FBDCA92675CE37978D70
      E35AFE7A6E847E2A3848A693167E4983F13C315077B8AA4D326EB7D8DEE84F13
      2FE506A6982DEEE81BB64390A7B437F4E34AC99CAA6787448662AC4914877CD6
      DC9B23473184F4A6A3601217905FA9245DB0B07CB9C05C875CB4DA72776D711D
      88E5512385768744A9AB2121A54F83BD9434AA2B77B36563557A18B196AA793F
      AD24CC533989A5008F663BB822D58F430483721197588ADA484812CC243D8243
      569FE91753F44227A25F67C9C6CD130B90CBE8D0D05E916CE59072B7783549CA
      DB591D5F0E44B220D34673AB5AF927A99034E3AA8C2179E4CA68C585D2B35E54
      5926735E3BDC463580BB5D4C920A14B9CE1FED246666659E290114976264DF03
      8F1AD6229985C38CED429460BADE0E7C2C358BF40238C67259B0E7E7FB731DF9
      F850714BCD14505E931F88425666BFFE9E71D6E775C7E5234F6DD2B92446431D
      835830A44E10320500B4C21454C45A313FAC60BBDE1BA55EB3845B6C2DA79C37
      39DA39BF20E5D777FBD5D5F0544C756D57E0FB7204F705B60ED81FAB287130CC
      3B6AEEB27111A3C8874B62812E9566AE897892907DACED49D889AC1960821AF1
      0600A247E34898BE6789B7DAD8A4638BAD11A6C26EB9B800C269FA96195BDB9E
      EE56D9F8AC02E15063034B919DA3A1AF1700C921549A522E2BED5C5678745A2E
      66FD141A5A55F4964840B49712E891C8810C229745D2F1A840AEAD1DFA4C6E90
      CFA06E7864332A1E4ABEFBD463797ECDF49319E12D9F94510153E1C953F33DE7
      913A03DCD100D81B25DEDF27344D96EBDA0D865D95C70DC7791869AD6ECC3115
      5A0CA6EAB26626978ECE1343DB5993F7796B5FB9BE48DE945F14EFF72C7CF151
      5252DCD1947D7D491CFC4033F223EDCF83D15E4AD3F81C85C05DEF148DE1461C
      52599BA4305CF5A232FC19AD0D56DE7B25B54898D3C239AB61EA5D618DDDE00E
      77CA751F6264F333FFF3337130024FA9A6DC450F720C2D4F33A125E528B08637
      54B9CCD10E2A356995C381AD642C455AD0DA80ECA8F02A1DFEB08A5DFCFE9CE4
      5C6AE39971FAEA255E9B8F07B01ADCF74C965AEEF0605A3DABDAB92B1073E850
      60A74F8199CFAD5D8318D0991E561CA2E3388D7EF8F80703357FAD12B4D7F086
      76E2D08141031B9441326806FE1B37684A75259FA46AF6305D4F7934D293AE5D
      DE50035B89311AF2EE978606940EE31990610307564A4DACBD726D2902AF2376
      85A4E54A23334BFAD718659ECCEACC6C8652C632D7389FDF318E434142A21503
      984B23E67D8DF73AAB1F12942DB19AEA96AE8660D9CA77516CC94FEC9F1F75E8
      9F43D1ED8769E07352422191B93998C393524A129B7AF2E113402BF355FF094F
      91C34D6766E0FD747AF8DF67AF97F97F2BBD9FA13E6C12A7E495F8F80F84A13E
      FEB36B6EE7F58AB3A4D856120D2BC7251B56F4674813EBB62A51877B5CE97091
      8C6B85FF47F95D4951D15B84411A5AB284CA29B2542661AA44D3D5005C91F9CA
      BB76667DB510C4E8D3214EDEA9F5C0DF7C3F3DBC12BEB773D20D7D8B39AA47FA
      7CBFD4CAA8BEBA87599B9A67F1B1653954DA00D4D6E3622FE9BFA9216568B24F
      F057A144CCA86FC2B01E3623BD514F625477B9A306C295F430DF8669CA4423F4
      0E7ADE623F9074C3579F988FFF78472AF058D460394B96BFE9D9A6AB6F660979
      AEFD3EB1AFA3F15CDDCD56772C1A2DFD282451E48F24FA385B2314ECB622A3EE
      07413A49CAB8F1C80F7973D7D28CEE19A5DBA9012A5DC01ACA66CB195FC4C5DD
      E256F8BB662898F9BAFF12D4340104D975640D6932CB2399EF895264C28CF130
      4C93F2D6B1646D0220911E01C93E002F5358C1ECDF5C0D8DD6184E3168743D0B
      D3400FAEDF7D90220E8FF34F4C69BDE15A16EA239E8F00B849FBE0A70F26BBFB
      D99B5136368FCD3E067BA5BE145DDAC1D1B67EFDACCCDF319538B6023B91CF02
      35F052CBDA2A342E0E08372DC9113A5335890E9C80A90BF0154F4912B8426F66
      A57950569A7355A17ADB1D8DFF763845FA0CC89C2FD174F52D4C074D86AD3AE7
      2256A9B5B2825F5C28459FDB5E4A2162CF2B887F28968927437A18DB20B66CA9
      0A37586392AA142CB6B5263A1A78BB17678770792E4D1CD6A17796E6DAFAB313
      296AFA27E012FC2CA5C27325DD5C25CDC9D06755CE256E29694DFA4F6C1C5F4F
      653F43F3BAD4B9266ED9FF702A7C56F7C47D90522DD4777D25F768DF93F84E2B
      B1DF27C2FACEBFED499D7A19F624D3449A8A5A9A486CB946A1B244A75562FCE1
      5D6D2DFD434FEF3ED72A808C1EBF129E3A6232F364E0F21E39643BDEFBBDB38E
      4DD81E5C1CB548707F9F70A53E8799C712E65EE322DE7CFA38D75E7D577C24CB
      0E859DE8BA925A4F99F24124D9D4D69B93F3F35787272717DEEEE2825D4B6706
      B5BAB5A608EBE58A4E9414B3343AD491712759021764E0B5CED1928465A4CB02
      197093B8EA286E7046999183EA7571391AB745610BD2618224D792B4761AF26F
      5A071E2A613C94C278072F461E57C368DB051E622BCA6C673619241986B55456
      1CA32D05D2948A64E9D611FBC98A60CFBF49861338454033621201E75AE5E904
      84E15196A0F02D0E996054B8A45C465B795C71F950894135A3970061857ECA27
      523DF302C58799F1C3BB6AD5F65A77B5BBA23CA6AE2CB60AC87B811AE15B9B28
      A49B754AF42E8807496E563528C12E6DBA51B583A49201B7ED6C16EE01B68294
      16DF3F057530747D20F512B929E11F6CC23E8CAEA37062972563855660C9A45D
      0DB0AC5C90A6BBA07F57D8B6B57ABF1E2DE67AC6A6ECB2AABEA42C4B57654892
      0B2701973046035666C2B6C0D83665DD34A663E427A818A083EA926CE036DA8B
      A2202A548DDE29B69A2D6FA87C5C813DA5ADABCADBEEDE39D0C563501C327FF8
      2279B107A8035A1A3797692D073807BF78A0006C06DE856D24986ED378304854
      13368A72AB88C59752B3D0AEFA1C5257400A6DC97296D80813076213EEA098AF
      FACF4FDF11D8A6E1CE65059DAF6C26B5FE6B321A935E6FCDC43269CAD2FF0A14
      1C45167BDF0980C4B3D8F3E92CA819DD2D7A1EA00CA19C4FCBEF352F13783440
      AA7F4D87714E766BA5CEB5295BE02B68FFB7A42F2EF6CFD75F9D9FEF0B3AD149
      AF83CE359FDD4A130E2D492C7E0446CA55EE9258952E3B722EC8ECB134A6647E
      024BDE2606D85771F754439D75D3E2827EEAD266894E5807E0471665B07C3818
      2FB8B52C34B7656B8BA0838130D6DA675DAF7D665BCEEE7910625AC2C540A3ED
      60D05D0269199EB3FB0317D3F1A9E5F7236E54CB2F278341CC263099BFB62D18
      F5B6F6F49B429A9F7A591DC98D94E3013111F809B0F1FDA0585C98541AEA555E
      A5A86D9B8E4033900B3320FF885BDDA204FDFDD2D491549C9FE39D0F47E2F8B0
      A628A32B21F9E540DF18A2C289ABEAC9A6ADF42E0A6008B955033821A04C12CC
      0358F6AEFD66F6720998E520CAA50110CDD851A0E2D049CFAD3581B6F2D0293E
      BA92A63148499A649F17FC1D67DB57AE90E1D99738BBDF26582676759F4BB300
      F719D11E97F2C65A1F29AF69BBD8CAFEA2D9EDA9924363A0217AF58BFA4AE681
      B2D8DB7D325BCA66A662FA3A5A598C6F40FFADECA68A9864BF2DE1917F83CE77
      3D5E0EB043AFAB74F7743C6818A15AE1412976D7FC74784CFB9E56075C4E0A46
      47D330244F613619CFAB2BAA8FD4826263F303D850EAE6078B0B162828D2DDAE
      2486F80E40C04B8C041679A7F247740ACA1D0512BCA436ACE0AB82D78345830E
      BA84D343D63D77B3A55968B9AFE33ED4E7D54A3D2FE5B579D3E0AA931F10412B
      A63BDFF369C8974408BBE9AA3183F685138617B330EA49596FA22BAAF3897782
      942A2B6D465C036E56944CE6AD4C8F6BC5B16C3B458A4E9CF9CEADD5454D49A7
      6CD2C116A2CD1B62DF5651CDBDEFC98CD8CF6DA5B5FE91394B0FF6E8C321300E
      2E2E5D8B1000F560062DD1FE298AF2B83EA8F4EB666480BB16E5D8E7F67C8689
      6EB38DE407199DBA5E0E159026F3A8D7A3163D57AC83B9B9F0BD317786714872
      BE05A63A695A1511714AC2B7192C2DD51515AE30FF357024362F2D320FADEE1B
      46ECBA49CBB67FD2D91AB4B289A9AA41492E00F925DC82835C99DC1FDF6543BB
      756480D1CA25889A04EB02BB08BDACD28C36FDA46A8AAF129C2EC7D711B7C0C6
      A6E166CD788A455713D28DCC05ECAA6BC9410D491D98BE863DC9F43D2CA833FA
      F0F5BC5EA5579B79B1430FC1BA951C66F57902E141E75F14FB9974E12B155855
      7B7595B0B88ABE84F07BE5894E4882F762E5FEC9FD522A453FBFCA15EB2631E4
      AF4D8F859DD6CA2C486DDDC815B4898B6921D82A0F9BD68A3C4FDC39E94B78D5
      4208D49EEA66814BCB4567762AA9870A6325E705E98DBA341DEC69000C916FD2
      FEB3B7CFCAF69CD42CB8E1DE2BA5B39F54AEE2054F3E5EEF9D09AE502F5FC802
      0B2D41BC1D0969FA5A2E85DE3E5203B032345732547D5B169EA448E80DEFCF2D
      031BB093E7186974594D4DF254BA1B28189136BDA171CE5E6929AAF51579C2C8
      62A5D743CFDB50FA7D24751DD61E6F81302297A86E4F0D23B325377458AA8F8D
      A3ABD41297B27FCB93555E45923B6199A49AB14658ACDCD39ADFDB977C187F89
      B6BABCAF47EE6F4A717F71B7D1482034F98EF79442AE686490A4861884E847B3
      9F766F9765D387CE3F9D3644AA6640453A6C27A03FF75396C14962CA81D06D22
      F01291D35F480B36AB81A917BF11643A5D3592B2AD696EF92A529A62D6388F40
      6BC61D0A3790A848833B354D86D10E4B847E7823E9715F789E8B533C7DE74D57
      AE19D232B505E8B80A77B8C14B335ED310996D6432517755FDB6C0690022AFFE
      22AAD1EA23ADCE3B360D6F8FCA961022FB1D3D2848777381BCCC25B349D1A67D
      AD97ECE1BEF2121D1D5C7D58F78227C6CF2324352B3194211458964E8697B515
      4BDBB5727B07FA6F314E3EB1C26B607CAA1EAC54A74669B3FE8619745FF6EF5E
      BA8613562802804EF770221159D9BF2F2EE82756D597DF989ADF1F11E063362D
      2D70C6EA99DE8B6EA1D404CB5A4B5BCD95DF3813E5C4F45CAC28AAA2425C6AD6
      2C7CFA84639C4774CD57A1162719FBB62059B2843A99B644A846C2276DA5F0A2
      B5C9E2D3C532BDE3973C4BDC50E23932D6C9D86E55978FC76D6BCA0E8522250A
      3D7D7530892165F0F1F1D6CD4A7C5B56BFB55B697895750BA93A8610A29F6BC3
      5237A64CE4975804850510B1160386F0A210789274683825E9BDB9038A0F66D4
      9E0353F767B939A9E51211AF0A4315AA44C51995556F5E96BDD525E4B58FFCBB
      5A9789885B0D1DD55EAAE1AAB43CAE78B5AA0E725319BD9EE49E834A50CB4523
      F861775EDFF908341B35B568B1A24AC521145600AC4A036BEE93D5E566C17A9D
      D4FC7C4A621530307852B40B484B1A392EB13F54A2F66EFEF4D79D09C3C88E06
      1B17555626C7E676A5611D555BAE893B9F44926CB23808B9C40B6B26B057018A
      C6ED9CEA28ED5E67BB73FDD67C3B7D7659BCE1482C67C3C0F6E07D6FE271C73B
      36B7939C4E4E5A02EFA2E2FB49BF830A5318051D687A3A04338300AC3F34F304
      EF7D613E04013F155677D634CAFB6EA2244C6FEC3CD8B2EB7F7C049E3340E258
      BC1F19405B65EC4D0F70AA7EE2E95A99E394EEEAD30DC33EFFB0FC11BB979EE0
      7D7CD1DFFC483BF79F33A67F10BD5CDBC01C6DAE7EC13AA081FF2DE041D34E28
      6EF1DD47AC8C385FD99AB93CF0FD5FB1409E7479606F792FC98F62F6934BFC06
      7557EB786DCC842F2E3825416342D0BBFC1D7AA11C1A59F23C311AD500741C5B
      ED430DEB980A83AD4397CD2609C708FDBC7192118D494261FF848D5C58A48348
      FD9918C9F7828E363A2AD231B3EE545C282BB2327D2D25CF640873C570F3E4B1
      B8A06787AE13996DFBB7DC64D730F5CF8C1FBF640B3D6076060EB9B0AD2DD70B
      29011C39151C30E0BC7DF48FA1A2316279010BBB81F2B1E7E94B6F3F1E716632
      DB79FF22AF9DB31555E1FD773AC9AC112788D7E4404C0A06C0CD73651A2B2BF7
      D364987231F404D0B1B5856717DCDC54FAFC5C4A045768169E495CAB4F23AED5
      CD07C5B5BAF954E2123538B70EA79AEF044AB1D67F6301192D85C7CC54485217
      A863F5A916D795318DD61EC32B96F7D34349627616CCAECADD6143AEAC4FAEFD
      289672BA290A611B339E6610D6DB6B5D47AA2DABCFA5559AB44D9CD534DF294F
      B653A665FAA59BA5B4647FABFD523EE1812D733028AD62A40C919721D3202DC7
      D96696AE5E77B97BDBA1FFACE23FDD6E7749922EF24DDBE26BC3B89257662BAB
      2DB1640E844BCC5CB9C62795634E0BAD7477730955A4A41A961949305DA784EB
      10CE95E9675E5DF2980249B5F632338A78A15457D25C3B54AA4BA659ED1DC3D3
      25BD74CC11162C3E2B50D962959DC56D8BB2EFB0FA516B8C552B7B846FAA1956
      A7227EBAFD59764749885094FB9A71F8551931A9598D2E0CEDAE1CC3CCB0CF33
      201FA799C3939D62E2D26D55BE4954A94D19C7A859E6FD65C786FBD9C265BA31
      27E4AA1A10F724AD39F213F1ABA7EF6FDF5421E26D9781F52EA000440F55BC86
      AEF7563C09511579A5F2E15A791B41498EC0AF7B35333689AB45E7ADC9A597EA
      C3B8C4FC2815360EE4C427A46BEEE68AE331405DDCCD4763A5D58A80CADC96A8
      9763DE1790D796338FF7C275E44F318BCCE8155BAA44759123BE24A194650180
      5A97A768F4D7C7691D8D26237D2A2DF64B3FD67A26ED94D08F6AF8317A60BAFB
      5ACBC271D4693FD03C40FCC501E2ED6F3E40BCB8706E97C64B5E52812E294B28
      A3E6D7A356507DD5EB31E322B18E84968B3E84B6910D47A540E2728432752D15
      214D5B736F23A6B2D4B8631115B16B7D6E57A1F6964A1289BA643B3425521033
      D29A55818D40E9C4DF27D60EA615D567DC147F942A78834E9C653FE247E6D12F
      6606E28B9D11EDBED33C105786E11B8D13FAE202C47E01652A72770AB070B2C8
      3F2107AECB12225ED6C8654EC0D1EF922C0352CB494DBCFC18D18FAEDEABF604
      81D2E272CC4A9347C3E47A3E42E9D84B5423F5D1C6A759032772EE139465DFFD
      CDA57F60EB6F0BD089D90755D63F333D1B854C23A56DD825AEBC109FAE8B0B0C
      83C0F6F5F497C79650F9E1BD8B191F67299BABA920E4E497D924B9F2F2D473A4
      CEF6A6185D0568FAC197B23462BF7279CDEDD64FE4433109495A36C4324CCB68
      5CD08194DECC8DD8A99EA2CF886BDAA33409C7675EB9404D8D3DF51E8D5ECDD8
      AD37E2712FC5DCE0FC528393AEFBD60D4E52E05CB5C9E04A70D8B5149F3472AE
      241DB47C98BD171876683CA195669BD32C0C2EDB5864381513AE027F63926898
      949FA6681D418416BAF3320A439334F0F03D1888A9EC50004B02E42941D9BA6A
      E1FBBCC4AEB5925BEA54362CCB43BE2B52B14DA98D93CE8116CF679679CD8455
      1EA459EB667161C6CA39A2FD14013D0221E5AAA6FBC4129A1FB00FCF9DB8821C
      5634B434C570613C708622AF192CAE61608EF0FEE9E0339A15F4A46DEDD5C5FA
      C1897516F47B89F96B2148FA771C581EE526684D138B797BCAB52B1A627DB956
      BBAF70896258F36339843AE0507626608028CC05BCF38C39960EBAFBAF283925
      7AADCB3476BD7EE402E4B4012763095EDF24DE95B95B123A601ABE633297BC91
      9A13F24EB67BC0C527C8439E48D9099250AEBBC714DACF80B5BA6C83D4323A47
      94CCB53F6905B7A4CEDCCB03881C53073F1C7566AEBF4CC4C06D562C85B906F9
      12FEC09D1887BA8F7F391E4917D2D2B70892F3EEE78754C467E4F6D0B6177CA2
      6C626698E21D6F92E45ABF8FBBE5BA6FE95C15AEE37CC9259EF9C1D53835FDCA
      955FDC0A5058EAD93FD8CF25DB7CEB03C4A9E310CCB94D66AC48B4763FF169BE
      EAD898723AA253E4D114E8232AB1A31F5E14E5C417B7DB2B1BF4EFCAD6DA2AFD
      6775B3B745FF59DBD8E8D17F7AEB5BCBF49FF5DE362ED9E8ADE092CDB5555CB2
      B5DAEBC9B77109ADAE4DBECDF2F6362E5A59D95EC6552BAB741DFEBBB6D9E3EB
      7A1BEB1BBFED6AA3D1FFF600C93B9EF786FE4F254D3FEE7ADE8EED559C6F4AF7
      48313DDDEAB71BA9CA6F8FE53B5FBC5F75F196CBB6B288E57F6E117BF3753C85
      21284A9F03A6512620046D8BDC548D93FED9AB074A79A57376F219983EDA7262
      2D3D03B547FA48FA82271EB01EBDCF3162693BD28C92581C2893119B81A1F96A
      56C1DC02FEC4862B691BD8A7B998FBC4F79C84A474F90ABFDF119E845A2AA5A3
      8DD28E37B8EF6B07B622B4A7F5BA870320EC57110DF432723A8F1574E5156604
      1DFCD5622BBDACCC6C5F1933B6CC69480529D8815643E26275150565A0D67823
      FA15612D78DABEA0AC30539236F465695AA52A94F12192EAE22EFC7876A2C91D
      0FE9461D0F43228B3B178003B9FB8BDCFD19BEB1BCEF085DAF150CEF0ACCD745
      AA31047AF5609297756AE4990B55DF249F47ECBF3C623F5B317D4B117BF0FC1D
      4385FF27AF5ABB1F74DD8339C371FA3566DE778AF8BB0F7638BCA5EBE369D668
      F613255E03AAEC6B37432FFFC32A2DFAC98D937EFE300330BE3183DD95D8E05E
      7A93BC9610A41DEF03B309C1CC1AF1DC04F94496CEC22C07389844E33388A462
      75D5E4F908BFF57F8D6122B875473046DE8F5F61917A6DE4BC97BC570A332DCB
      D77D688FCF253973F56CE5EA914C2B99F382CE7F77DE0AAE9846F35C908D1FBB
      1386E5D3BE3A71D641929BEC710CE34FCDB4F0B014FB8619D94B5072F153ACF8
      66F7E9541A756C4CF52DDF3231375CB954B9456EB743CB6B875381D42529E719
      295794E6294E6A351351C220E8613505F20CAE2318209FC16B949491948960F5
      3E72D93EEDD89F6BE1D6376F0862A3CFAD5E5C34BEBFFDE747D9675B1572F48A
      20028BBA002FF6FB26CEEF9D64F383AC56FF559154BBECE5B3B1BDA8EA83D7C8
      C6656C7532085BD328D871AEC4D3D271F0A2FF04565C8685E70BE75D5029449D
      0EB22715C52CCF2AEEC68A1E0A1B51BA8272D76F6159CAF3140624833FCCF7D6
      E3F796440440F99C4EB2401023806DAFAC770AC86AC11D154EBFF5D39E31E39F
      69678EEF10F4B0E9BC574862024E6B8E6D5D7B24E7612B0482FE3D09B66B2214
      712F395102DE292BF104A7C16F9193755D731AAC92BE0E9FF1A3A4758EB92135
      EBEB7BBBFB878728D993AA66DFFBF1EC708FA3BCDED9FEDB33CFFD1DD72D59B6
      3903306A3FBBAB85C5986053692611CDBAB77858E9B89EC18CD44C4AC76315E7
      D6A1B584B69D41CC2D9589DA5DF9AC9B57182E65053B261C3896881B22FF5C69
      0EB78520B63D06ED9F80D6710FB335EB16800BF4A58540D6B59D428C0A0B3F9B
      2F31CBEBD4D3E73AE7E1DD50C1391711CE35457968A7AEBFB5359A9653097F4E
      E76571E7B5A1AC05D7D415540962BDEDF7C716CD524668DDFD61894157A15F4A
      48D51A2F931C9B26FC9AE180A62EE2D641F23752B84CE6945727697EF43D5E4E
      5EDBA160947473D38D060A178AFC86B5586794216AA65A331CB84858516C73D1
      B13B561D0D1CDFB648DD89C0BEFCDFA412D95EDAFEB33B17EC9F6C7D936FF1C7
      4B0A5B7757014266606132BEB9C12F0898448DBB24F5D5C6991944B72556FAD8
      F52245D3A9AC820E5D2193300C7E2671883EDE966EC4B63DAC0066A316EA3BB1
      937D8610CE0A1BBA90272F59434E9AEEAD7151B3DEB96A12F7F48342BA16EF4C
      5112CC96B2D47352842144E70CF25A5A0BE275D0C70E4BFA4721EA7E2DF937CB
      E9C033787C72E1298EB59FDC95BC8302F0CA86C748F130CBAC9C0A547E8BB292
      BD76CEB2F6983DAAC6683065CE7B6D41D4A35F95C07B696EDDCF10DF7D31B54A
      C6C86A35B2A50E610CE287C5EECC7EBB33EC223EAE30A5F8C5D4C6C15EB5EF60
      A42253A939AAB5970ED8BCB665D4CA9D823B9939B06B1F1C87BCC761B0DB16CC
      FB8FABDD5909476812878CBD8F2E8D281B890E5772396E39085800838A8E51F0
      66A867FB26856DE3D56F325EFE30B2341CC1651A094566EBBF4D6E79255BAC40
      5BC7A9FBC3D470D5032E7B74EE738FD8D1CE7CFF2AA8CC6706A2CE4BBB22DABA
      B0B8E745BF76FF35962CEECCA7655E3E4FC94CEAF14A39EC18E471FA70EE30D3
      5FCD61C55AFD220D21A93DAE80A8FBA0358AA48E323FC4FA2AA9108654FC2BAD
      AAD041E90C945F00F871B9EAE96915992C2EA873488F5046C1F24EB9350DEC51
      765FCE566EC238F1418DEA5D35AAC519AC9BE474CBDD1FF04E62BCFBDE389E0C
      A3A42A5BD76B399AC4559690F909F50915CBAD626A4682EA0E5B78FFFC707E0C
      55E3BD5059F6482818257FDAF2E5DDEACCC6FFF0FECFDBB76F85078774EA682C
      89AFD2861E09A4C7806CECF25BFFFE67FE5AD731640DC884AFD35A1429163B59
      6FC97DABDBF119CD4DC16F71A39D19A5AA763B8DB4F8DCE0BBBFD3C61AC8047E
      B23D71DCF2CDE92B4C52919771954ABAE3D34E319B290F29BCE7F3A0D076BB56
      091D09E7F9255766A2F2888F53665174FE3353A2FB807D43BFD2005DE315A342
      2C23596E73F48B47ADBC7726215F3D66BA74BCD9C8B08584C57172BC73E42A7C
      9AB2597FFBD280976FA3DB53186EB4BD92C07CFD1A8157CF500FF1F2387DEE61
      43893DC7C8A5F41E9BE17FD1543FDF90BDF1E242A9871467D01B8A9A42A55525
      BEEBC8D3B9B60027CD48786E15249FB9FB46FBE747D1600EE1F9B8BA98D81F4B
      88F898ABFF5D358C3FC7D02F1FE964536D3851567546DDFCE9E5CF5E7E37EAA7
      B126B6EBF0BA81C8593C22C7E9A9C247C822231B6B4CAB5722250AF522F90AC0
      69A759C97FE94A5BD8E91A8FE3C82887A6E01ED0D34B481D76B146FE9DC6B790
      854EB3618AF0571D3102CF458B8983C455F30B0F095236B6FA7E70C52C3259D7
      6B4B805F0B691617344AA5EFE6716C043E1FB77D25696199D72AA537E6D6E76A
      03F9C07ED3428F731B5954947DEAE4F4099683DCD091167261842D9AB4C94A29
      296484656B26628680969CA54951465143D3B19549324176268492795AF65C47
      446B990131D3A4AA91F0F1E2C2BE0EA33A377080C9CEDDB7F3C617FB45E53E88
      44C2A4367E92BBDE60D4FD69AA26BC375796EB711A2AB3D2C984B7AFE67F8466
      DC0EC20E38B47CA789AE401A53185D47E184CC7DBBD4987DADFE7DB9B8FA7527
      4270A9DEBB455726AA5CE574C7A0DC00BEDCB55D2980D5B954787805C914A40F
      9F8B30EE3DC34996EF255096864BFFB9A7A97E0F3B1227308642886C07955B3B
      5A2446CBA7A30D52557AD5528C6E0B4B196F984EFA31E722A76E447788B0A250
      57C7756C5C12B72C09B86A1F2D178548E22F9F8973A4993594332AF4931F67B4
      1AEF045694DF409FEFCDEAD3E59CA044D3158E012FEE2AE254DF9138E955E748
      FA8FE3D42834C8E58923FC166AE87B9A937985CA545969AB2EAC96558F76A556
      2467BB374BA4B3088491B735881234F908960FA32BE8F9ABDBFF3F5907D76033
      F189B405552BB86A93870F8E84DEF53B6F65BEFE1FD3B35CCE595281A52AAB2F
      72D55FF3DD50DB0DCEA474A8201C159BDE0837F6242CD3614EB44CD4E7E4FB89
      3217ED77711CB8551B41B0AA6A785D12F213BAF8F4CA125BD7DE4AAB596C7A2C
      B59684F183CBCADCE3FEFC7AF7EE808FE707CC1774E40DC8B266735C8B70D84C
      7045387308DBF2917B330504F6A048CCCCCCB0011DB0E99F61C96AAC0131665F
      B0A71617A49594AE57B2234E43A13669080EE861B96FD51F6CE505FEF2937BE4
      CF1C97B75F71401949AA0D07F613E7EFD05D878A11B0B24C1B87CC614D434BAB
      045ECEDAB1B42A8664EBE6D5B7B61A4081DD035F3ACEDCFD2DE23C02C1D33D17
      8CCA2AE48D9AC9E3DE895420ADA76509F7B22C02A5F7D466363D5B91C0CBEFC8
      4F1AA1FCABB9DBFC81405CBF0CC53DD12E7F89974719DE742CEE2165F35BA81A
      A6C261AD0FD2609728986B96DAB9FDD5FB6B1F5C1B5F63C4743FB710CA823167
      A9A8AD7CEEF0466D6915AD228ED7726929348824F0359108B756DDD85A85AB94
      BDE4DDE2B6E02816BBDCF95534CEEDD3DE713B4AF93C0EBAD4AC7C3C514A18C8
      A58D42F7A57922FF3199429AE9C328B9F25E796F4F7A687FC16F730D50F6F957
      E562CBB47060BFED9DEF5BAF354A8278129667EC81C6A86C5557CE8B942D7694
      759FF4A49C4DEF5C6553D422362EBD642E45FD0308CD3B53A5996515B756BB45
      F7E281BCE7100C73F3FC69A4FED6A95F5CB61841499D007821FAA1ED8E82ADE1
      8AD16154D9A7841D983B7EC5DC9AE1AD80062E95427E19D4838C9C95227DE73B
      C1BF205D2463F06D44B466DBB82A871AE9BB00ACBB3413CF20E60175E852E6D0
      B7265B61ED35BC5FD906C0BC74AECAE1998E05BC12ED90AB67415F280F866964
      5944A2471209FF5F765C3AB2ABFADABDBFF168199DB97D01A238BBC398BC5076
      D81B72F750FB4A7F3984C2C8E647D8A38B5D6C32AB9AB91157BACCA40DA2DB39
      8161ED708B51E3EC692D1F0AAA678AACE2FA8DFCD0F5BCDE93B82BA2B7DD89A4
      4D87D5E2B083440A3E035F49D1C00BAA2D105A860EFED59B6AD9DC24C1738609
      57331D5C1C71B28DD3321637A7F239FA7B27C1254EE55255739D4114D0498767
      45F9A8D45F957646CDE1212EA798F1240F9DE05AB664D6C03B8E108ABBB92C25
      5EA913161734207D63FB2034163E9DCF528D3A031A81DE95448AA60AC69F2FD1
      0FB489CCBDAC66CFFA772050D5F0F872D9A995991C5771DFB798CCD755ACC34F
      CACB9D9022A916496292819BB53543283A0A4665C4E5B9F7E168716167CF3BCD
      105A2838A93D9091B7CE8B6C12142D44685A3B0C2B4A1FD93F727A5DAA104706
      6BB5EA573043EEA3EED301D3005E3EEB4745869E3359F9828C68A43A931520F2
      DE651FDA41612DBD9A710514A60F473B7B4BDE79904563DD3195C15563ACEF0F
      BC769FEC0AC0DF7036149403993F7C91BC00D88B4BBE4DB70F1C2483D4654748
      C4A1068C30C362A07067C425B3BE3CC3F17B47FF7B391ABD2461BCCF4DF6DABB
      A5570ECDED6BEFEE590EE4C722F23EA50C8ED3E471B5734F3DD876245B7D799E
      BB7D84B8DEB3EF037723CD0EF618FA35F68772A6F85C604D0A957B74E6364299
      8F48BC8BFDF3F557E7E4EEAAD3FAEAEDC9E686B7BF7770611553A5270A477B09
      C2D4B14D6A8E6F699C4569A63D50C1F8443BC44A0FCED5C8488D95ED8F148B83
      6F8EE32D61F7302333DB86A9FA66CA0EF0F5CB5DEF0DDAB08BBA632D25416E2D
      48A40B9C2E625A0855B91C751AEEE7FC71560E4472734C6FD6728D6E364F66AF
      7285F83BA51F4F16FF1001D722333E9D19F61D10C3BA01E38615224D4D29461E
      8B73DDAD18A685C0E17B2EAE2F9F262495E2E94E4B41BEC56437E286272987FE
      81328AB7AB558971CE8036CB5CD53C324D2EE56C81767F9237F88A658EC60F5A
      52731D534A2BB5C196D29895F8B1A4961F106474DFDC891E0A85444F1C0CA19D
      F60C65D465ADA9188715208736B4B4E4F051BEB9548DAB95BBBA060C5136247D
      7EB5CE37FD23DC69B1ECD1DC0BD8AC3626E3EC04FE014D1990B324EC5B8647DB
      00D1EA783BBBDF9F49CEB9E31DEE1CD365A7EFCEF4E2E39D0F47F83ADFF13AF2
      9D2F91320C6C7BA912EF64CA3DF8214B73DD52B55F44641D0B4F36C38DABCF17
      2449BBA9E7E6AD12355750067C0981F3D269D64498B5455C8BBF10D4719BBCB4
      D930E524DA6853F640BFF36E3BDE5D9567A0D6A5573838C6DCF8196A6D98AEAE
      DCBBF2EAE8B88FA48CB4860F21E68244C1659BA320C142AE2CF112E3D0B8D429
      D4EFAA518C01072425C829FC6389612B09164225E9E1A4CB59BC6911CF5CD8B6
      E9D72EF0BAC3EC30DA68C8F8BAB8D77407AFCD6547B4D11466928B19E23B6BAA
      D5695449F2824FD7298D9F0784592B889F86DBA8080E23AD868E7C897CE12979
      AD64D15767FF539B5EBAA7CB15C19D9891DEAE23DDA188A8D0B223A14636B7A1
      811D9E607A8BCCB85012BE37332522E00308326186CA6C8854857104A33A034E
      2C5FDDA166CDF62C1EF5C890013F075B788C376DA9493532E7D4062DC372B54B
      5383DD37F373C93D52D4C327F542628CE846E53F8526A8085B913A9D4E107737
      EC548F1A0E70D00764B0F2477CDF2A331D821E99A08959A8CBB2775BC9764091
      9370F783A87CF10A3969CAAA46940CEB14491754556A7F3254ABBEE6C2BAB766
      37B6547EA53CC248CAD14696F0A7FCC8AA3DC90054BE2D87211F05AE8E5674FA
      E2827703C75A64C4B527A594A0EFB9D4F246D3EDCC86A06CAF9DB2FDC59E94E5
      F8F942DB92C163C6177048E213F0FD6402B9A687E5D47E9887ED1E7318D82C4A
      C9868C70FD0C8E61B2DB50DD69FB7B728EFA4F901CD438D25CFFD44ADB66C9D0
      6986369B8448369121174739F0A4EA496E554B2469DA9A5CF48DB8DC7DA98B81
      A30E3D47C8161794F9152A4E9AB712410FACF68BA1BCDCF592B1D26046AB5A29
      F94105E818051F8A98E5E762A966CE7E13C4A9F23D60AF297038DD59CACCCAE8
      437947C5E5AF1593D826B092E4930BE4E80E6816F4714DD76BBF11280B5CE2D7
      50912BBDA2E518C574139DAE2018754CB01B7A8BC9D8F5440AA18594C8D4F384
      34695160D4B01B1A2E65719543FECCCD844FC4E42F8F97EAD9C4EF86518C2442
      0E9317678376FCDD57E8B51220AB74A77A6B3BB67B6171E1E155E8046A6B10B9
      E8C7DE9C1C13F4A1000613D32DEA5F1A43418F562913B2DF7844F3C45C293F0E
      01080773CBCAF152BA3C661595CD7BCD67C40FB93FCECAB01AC279A4306D3BE8
      2523D29AC462D0D95B8C7D103398C087551715CC7B80785EEE2EE4C6814B94E2
      A95A15DD330DC050EB67B580F39AF521634F9CE5D295E46CFC7C037D7E091C9E
      ECBDA369532373BE37DC233FF81923FF8B6466D51EA9E85044C75DF5C915AA87
      4C9E267F982FBCCFCAF7FC9213B6A91CFEE334520708C52523E407B8FC848CA6
      349BDBCBE5238FA4792B2F4D1317E555958BF0EF80210FB26C32868D3125652D
      226B3B630E71C363FFB86618B9825268FF2899F08A0F41BC2229DC6A575AE5C1
      CCBB519A2E9F785B57808619F6D200055CB6C7B0BE0690A1D75F4BACF33A292D
      0AB0AE12DC76C68ABABF9EEC1BA734CF11C0E6DEC03CCD435F52D5DC872A90BD
      039F73D89282A6234CBF8FE7C930AC71A86715B928629B47C384D13C7C8725E7
      0ADF505720097BF2530AE6BF45932CAEE967E99518B2891AEC5DEFBFD3891C81
      571CD4EE23AFCF29F29B129672AE683E11E14A3306C5601480232EDBF35E95CC
      2EFA17EC98B3F709D68890CEECC41117E3787F797F7E31CF64D5B3E453559F53
      1D1F90658916C3F590D81A937E35D1C23BDECAFAF0FCC2FB73A5305D847F9DE3
      A3DD73FA080046DA7A55FDEC109F1DA69C2D5E5CD0CF961EC8B0E5E47D92A96A
      F16CD8A2746FA9ECDC95145B75BD4841657DC5D86F940D25F7AC645D507386AF
      C7FB733BE331694F2964E53E660B575EA9089F6FC68A07B7E3BDAD700F4F5548
      9734F59258B348E4A9B0DAA5FDF456C3E65502633EACE368443F22A3179515E7
      7A17FB5DDEC7C9C3C4F31EEF083AE5544D58B85620B5D6F293B598BC8B8DC8D3
      3A36D46DF3C7FA12F7E0BA3A0F20DDFB3919E6F61EF52A7F5823FEB563FDF2DA
      E7F6FC0EA33CA0D5054A62FD4AD90BB0547B77D12316533F88D35C3BD0FEA577
      069ED563DFBAFABE822A9F16532535FADCEABBABC4E93D6D74935B6B1951A363
      6B9E04FF4CBFCD8D81B60A0059774CF78B9C9E62824925F5CE37961B21FB2D5F
      7630028886D5521439068F7CC744A1FA6DD1023B586A354D730EE0367345FA08
      F78AA5CFB6650335E76F8F444A32090CB91B06497E01F63C181C45393645DB37
      289C7CED1DDCF4F1C39F6833CA25F80DCAEB35D20B74257D729E66857C98BFF6
      DEA4690CEBFECFDE05F898FFF42CB503B07B14503F512B855C9CBEBEDAD8754F
      DEE78FE61F2659C29CD46588DE42B69155E3582E989343CB4A9E014876C6F4E5
      33A6CD4DCCC539CF57FEC82979EA96557A49C9E85AE8712B47743FE94B727A8A
      47D0453AC90A9DB12F25EEC9F96CA194F402A12AF12ACBAF467AE974E4D7AE99
      2967E68DA1235DD072DBBE62AEF1E4E8CFCFB43D1E8DF5FCDB48653F09BF4026
      34F8AF51D03B85210B7301568BE6F590C9B325B942B1E0F527FD3EA0DBB993ED
      929B084C85DDFE723234C8958D8D0498B8EC0097BF12E3828B04B9E9939408BA
      E3AA60A2D59789A32B981B51FE0896C7F2782A6EB75736E8DF95ADB555FACFEA
      666F8BFEB3B6B1D1A3FFF4D6B796E93FEBBD6D5CB2D15BC1259B6BABB8646BB5
      D7936FE3123A0337F936CBDBDBB86865657B1957ADACD275F8EFDA668FAFEB6D
      AC6FFCB66722AF83DF7A915EFB1674C7ABB40FF2F2DCB5ECB97FD22BFAD8DCEE
      EA57AFC85773BF55377E799FA53FB90B0A5782E5F197A58E95A65DAFBE737E07
      2DC6F20EEE3B83884B852AF72877D5CC079A24B4BF547E9C9B4115BD44672693
      6AEC23C2B97B6982ABC334B87A86E3F2D30A9A86FF9BABE8FBA2789FC4CF230C
      B21DA6743339A69CE1540A9400AF076D2A91342EEA98AA18768529655D8992C7
      A9C79E73737B9EC6D77C6784E351AD711371F797F4665B6617DB59061AA512C2
      655C29217B8E22DD1FD32C0ECFC77E603ADE0B945FFC74FAF38B8E18E1FF6BDA
      7F670B62A5B3FE79514CEFAADFD0B680AAF7B96F2433EC6B54AA34971E6C4FB8
      C1B8728C4B2BF45142F5A3FBE3B32D3E35DBD0E3F40169B567539724806719F9
      B18FC6D0671A3B694769F4E086555A235782A814FBC31C10EA006367EE4809A3
      711572AD820ECD0B0AF23F8F297D56DC6F26C33974CDE7A06B32A38833FDC9B0
      5A35C2554A96CD02506C11D3CA20390DF64E9CD88C4933EB6B36186A8B0939BD
      64EF817A48C56D735599FFF8888F107DE739FA388EE998D789F2A6A534B53F9F
      4C437C249BE9921EB0F631ECF30FCB1F512B464FF03EBEE86F7E2CFCFE3F67AC
      A141F4726D0313BDB9FA058B8906FEB780074D9B82FC39FAEE2396579CAFAECE
      5C63F8FEAF58654FACE5FE6D7DB3E7BD44103EB8E23A6780B0A4264F5E14A2F5
      04DD202EBE2BEB489BB612688C1B34C6B3924598CB2C3044ADA62E9196B87604
      A835432DFC0374CDD895AF3569CC9B34E63DBFF0678EF8F7324E5EC1DB345269
      06B74B979B7EC619B89F393A4BBE799072441990FE473B7BF0C92C881169B9F7
      176F5F6E79084D792F83F1EB4931A05F2D5655D364F26FEB5B6B241108C465DA
      B43EC8CFAEA47248FA8E3419C78BC135287002B08163861E63BE6A711E119397
      8822B77D91BD1FFB8B0B058379A2D0AA9DF361BA54291C46D970EE1537A90B12
      8552FDE68AB0569A2617EC8FADF57BFB23338232A60D22A33401448BEDE48851
      5AAD6D2152B31DD05641023E8F8A490D9DBF31822031E010B83277FD14764159
      AE1025ACFC78AA3198BC760036709C50FC6E6FF7D318706A4939F78309763958
      D4B450BE8143DCC25EB793C6387F82421005C842721E2C2511BCC8AB7ABEE1D3
      BA5D1D335E9B46779966D12F08B5C5CA7A0260E300F1B9DCE64FFA6951A4A351
      9A4BC9CD5DF346BEBD4C2387098A425ED25223AD39F0AA59E6D0C841C78924E5
      0623E71C01455A0C7D203C3470E438D35AA84204D5B1A26DB76A00D052D7DBB4
      A12D2EB49D37CBE554B9F4DDBC74C9699BC6468C4F9AE0EC191444593019A169
      2EE0661F8BF5A955E95AD7AD51E5A609E621B1483DC42BD6D8F86196986203DF
      9E6C1C90DF45590156C15619C96C95B5B536F4DE7695E32A3C1847F85A487E43
      E33C7E5A5482E402E64244C0A0F921BC437AD404ED0495435F99076F7C8115E9
      8A9F902B53142DA76E3FF75F75FBFEAA072095E8DA346E2D3D280FF276B64A8F
      0871CD58554CE85939083403398F3E0E95E0AA82954B6AD55EE56BF3BF2C27DC
      B769427A404499A143C3B22B311325775190D59CA2C1192D16D3981F8D19F283
      EB4283D9DA3F5E6E16D031411FD175DC388D5A534B7C8BA24DB62B84EEB69076
      68135C69F3B8E0F64A27101D5BF249D324F690BC12C6D1CCE1562641A598B9EC
      F17F55E9EFBF1B2B9671450F7BA2AC6DCBAB835CF21D174CC5B0F1FA26E62E7C
      EEA86C9C7EFEB78DE5658EC38DF5F0F2BD847C11754DFDF1D8BB566868897937
      6D7C0F1B35AE085D53EB6905D3C11DC1DCFE8F267FBD68921451ACE590B6F499
      C1F538244FBF364D3E0F49E7A7B727BD9FBDB7C73B47D810EF0E4FDE4089DC64
      69F386F8F012F89441C6ACCAF7D1D1046007961D2F0D6BB47193A5AE8B190B8B
      E1FC2C2450B3A4F790ECB8FA5FDAA776B9046571A15284D2E61445A59A7FA9E3
      B58E5338853B71DC2A3798CBE2DA5EB10AA833070E9B77303DBCDE76787D5484
      C6E0308C00E93AD78404A88CE92DD501184089D806E210AC3C26B45842B9459F
      86D1B8F8C94362E2843EBA8FDD02A101736FDDEFC7DCDFB5C1DB4B92403029B4
      9E415064A4BDDA32544B338E12D95980B13BED0E4A5E144D93C9031239A36D90
      8EBC9D0FF5E3F5A6D2BED4B8913EB0C02F4E764B47A6AE0AE9C21FA364F3F732
      5259CFB4CE5B6F1717C8A064E5AF91C09B282C2E194FA304C9AD9346BBF41719
      F599F1152950BEC73001B84F1375C203D2FAFEE0E2683FF7DA6A389C92C31BDD
      D25F99020090239EF47E78FB920A5B62DBECECFDA917FB7D13BB889356F5A724
      C651E3C4F3907076D3D11887DEB9ED17751B47716AE3C585124ED2A234EECA5A
      FBD1ADB5A689E3E1D5F206F446F4A7EF817C417FA721DCE5DEAED231D3CA606B
      9DF34CAF68ABA413A57917FB2398E405A95B92D5A89151B4078462717CA23C9F
      08EC9F77BB37198D65E8D924E16009DC786951E55666553D8EBC4202B84D13CA
      2C912C2E48FC1ECC1B3402090E069C7F1960899C6872061A47315AE0F0A33997
      AC7825D7E64CA5603F374D260F2F947AEE5D6B4A19711671766FECD3CA294B90
      A2816002C671097626E031691C3670A93C6094C69174176078273F00F9A728F1
      E1EEB130F3A2595C707A5885D8375CCFE850CF7D6EA6E756DB67A8D846D1D173
      F404346D493CE8A9DCF44F0603DAFA285BA3D334DFA5AB38CC41B68600FD653E
      DA06398CCCAEBC25E166EDCBD9E03BDE54BF1B914C128191103E1848E3DA8F59
      430AD6159FBB51E2AEBB8C249E24FA34170888E1245352BD95D54BB9951EE2BF
      1B39552ABF8C1430B5FF8C9F15C22B51CA63B26369C90810A423940A8D63B3A5
      0F0526B27176CA838120CE1C77B89D9B7F400868170DFB90D651257FBCB860ED
      793E962AF9F4F669CC2E91EC3BF487BB7DC712BE4B2702AD51C143B69969DE99
      6BDDB5EEC61FFEF087C6E52C1E3ED47F14A4926373C33EF63D0F41F17C2BE7BA
      1C6D95EF21C8A63937DC824BEFCCA0E03C5B9520D6029DB4F65218107C5F2105
      951C81C20FB7647E809E5326E1663C96CF5290B767E930F34752E2FFFB9998F3
      F37D676FB9DA069902557AB32948576AB1615EB69094BDB6D76B9A881ED4081F
      2C1A62891A6D4344CD1EE3E242394A09E87881D574E9C0DBF36F500892855D93
      8FB4FA31F77A92DA770072887D88DFFAF709BA22F80E4D93CBC3DBE3328D1DDC
      BC16D47145E195D1EE07A930AA00F16127044516DBFABBE9AC35CE8EB20CAB86
      ABDA18793D588E6631A784418EC6188D63A19674F09B16F04ADC3CAEC2CA9FA3
      6F9201AC98CA0EF50178C567E99B940A2AF2CCE0E0EA5A6183A2A1FEEB032BA3
      A448E1DA5A5B723AB537A29ABB4ABB24FA059DF00E5EB5396278C08D27BDE07D
      27DE3C04C4C9C3EF05DD7DC601CC02A0EDB3B820553288A9D780DF351FC3789A
      ACA5940807F7972968666AFB617DFCDEC1828E5278B8A4830DE32F2944CE2C70
      445D6555444BB1EA9CC8993753F8476EB81BB9067CD834E93D243BD6C72FB550
      CDB1DB715D9594C1CE20BFA8B01D955F64146494B2E95AAC18DF4E74F6E64EC6
      961DA6B2DF9B26D88797A5C2B061855541173B33D59B56A439088F52B07E0508
      570B9E1810B369829A21A6C585BA85502B212E5789989975F44B860B1870C355
      D304F1B91563D13EED0EAA8604740128F987B4A5727953E11886D0ABAE526A9A
      64FE6D6365051525824FCBCDF6D80B6C5393C33196844889532A0C4B0D1CE5AA
      3697DA9387BB6F0A6440F7CFC1A93A66AC1F6956C1BCA75CB398455C55D2B4F1
      7EA2A833F3F34BE930F58340930E3EF79F455A49C091202EAB97A5DF9128369B
      5174A591C2E0B18F98ADE0E2F50DFB5E0A7F8BE890CFEC078E10417B92AD070F
      B5E29EE3DBE6970AAF963866DAF9ECCB4B376D0E74061617EECD41EBA73D63C6
      3F6B5960EEB54FB42AF07F10E8928EFFA5D6679B88503C18A7E995642F6DE492
      F3B596BFAD6F54F06A911600E750C6E10A9B194364C1386E2652C2C60A3ACE4E
      B59C435DFF343463ACBD22F3933CAE0EEC6B43DA2C3F0DA44D6F6B3A1BE7206D
      7A5B0F43DA5C990C91A4B58D2F94BC865E13E16F9428C15A77B5BBFA9F4D5B1F
      CF8FA9B2D6004C95F76A0DDB6E0680F2A62162CC5C1D727BBE6F0FC76ED31680
      0CCD112A5EECED9464BA0D1D4B90D2292C6D4E8E1698A1BE4ED63ADEDBE30FE2
      2F5626AD69E3543231D237DDE5A6BDFBED46CFAB028335E6C585F8908C0E36F7
      AEFD2C12F240F691302A257F6BDAB84AF0FF860E0076A185C47982775F7DB277
      E7374592C0BD3B8F66B0EAA59F3D7B577ABD7FFDF0E52F3FF6F48DE2EB078005
      F936DFCE21BC1386152A5C2E85E10E98C0C24D3FC5D9FBF566FF2D9229FBE7A7
      CEAD566667135C264A56AD68A85C87418E78E36C8BB971F979394AABE43BB44A
      22987470FCF64498BD9B36D93419B4094B4E6DB8E4DA749119092B7BBBBB0C73
      D3B4A1E1B5917D4933041C3449D02865333F6ABEE8A841651D16AB55CD921516
      538F2B11F70E773BDE09375B22425AF964FFFCA869CB7BAEA61FA1A62FF6CFD7
      5FB1AEB6C180D3FDB31F9A36D574DAACBD2217F867EF78E7C391AAB2A60D623F
      C9C1BCE05B5078699F473B2C62BDB9F3671A1BC7101C6752291902DB373E67E1
      CC508AB710C948C350F9881B37B6C5853D25A508EF127F140564BF4B4BC02032
      716839D4B573D75201F9DEC86468EC1FFB4570D9F57E44181B158EC54BB4B3C3
      35F763E9EAACDD2C1A78BF982CE516514ED4001B36077A602A16772C017EA618
      0240B6AB91D3A4803E56522F5D300E215F13E7D25E8E54024A3022145CE252EE
      8D4BC95CB74CF0A8AC0E1617E4ADE87D0AF260065A95A7D783B42B4D4CE3ACFB
      37E73BF468EF7AB9BBDEB45747C8E01988E85EE6F497E729E11B3B263F5E7B63
      5F5AB52C109A94F75F19AF1F25402C8942DA04F042B5F6CF36C6724B1697FE21
      F7285FEE0A26F5A59F5F1A6D11F4E36012F3212965B7477BEB9256BD789B0201
      3F8EFA5995776E9E74FA1549A79579D2E98B0DCEDE376F702E2EFC747EBE2F16
      E72E1F83E86E88277D2F9F8C913BF7DAF03CD44359EAC02E00BA73C55185A560
      3D185A315FBD7BF28FDD20089E8551094AAB699B823C8CF55734E53F7BAD7726
      41B90137BF9EF4FF6682226F799AF4118ED6C60DCEF91D3A8C9D2206EDD8B891
      F6B9C29B9DF47430CD448638BFBACBA291F7E18CD3A16F810731297AF85D35CC
      6B327B13EDC186FBFBE10C674ED7DC32ED1B0DBFFC43077FD11A27A9317949D6
      EFFA7586BFBF1CA43DFAC999208D9BEFC505A1A8A753FB355C8AAD9721F95EE4
      245C9A5B3F344134224349615794DC27629CF2EB28947EBDD61B844295AF0442
      4B33F0F129A55E4BDC958ED430EB8D2CC179D9F5C79C05CD931D9774D7C0F95D
      C6234A4254882670A146514CAF4E8E50DED1781BB708909B944CACA290EA6518
      ABE5FDD2246E5CCF73EBCCE4C26432098A49665AF747AC0D01F277AECE1EFB89
      B1A47823211FAFB8B97E72D7BC16949685E5B179BDD982385B5CB06D8DA1F7E6
      8EEBD46FA4DCFF9A0ECAD815F2BBF4A096B3B0BB0294D6A6090615C55E1B4AF7
      7FC824583AF2C747207AC9F26E715BF086293FFCCBC4E4C505A068F9435A0B8B
      0B80CC40F129976833EF87008E70A8CC56010A860F761C20B2E20997AEC2BD90
      AB9A26B368048DEB82351E27A4A2461A18D78A43D49F0CA55886A71C4A70A435
      C18D1B5252A9D26085EFC2B43BA7071C7F28C9C9FE96A749C74BA2011D052344
      3F233FA61FE3349470C43C6CF0EBC306F3A0C117070DD6BFF9A0C14FEC3FAA61
      7F0EFE1C3A1CF7B51852ADFAE659093AAAF3FD06BB5BEA328A93E5F5CAC968D6
      303E71C60A0E3EA0021CCF78D346F7FB3E76E7A7E6AF3E3557BA6BF373F38BCF
      CD8DF9B9393F73FEF5610875ABCD7A20A961DBD6B88CC0F6684BD4D151BD06E9
      6804ED1D7351A20D3D366DECAD73A5717E7484A86923FCBCD73E3FB07ECD8135
      77F4BEFCC0DAFCE60FACFBBB06398ADF8F25CEE5962E5958D5FDC338BD619A44
      837293C68DCBE541DF728D9FE32B90E9129871E373249606DFD0512E2EE8FCE1
      5F9D43FF3A8DC2DC1B4A6A9B810E32431E164689790D27633ADA90F4D6FC17F8
      FA24999677D82323B5A6169A56F2017D1E8143A6DA627C290626177EE0129E13
      81EFF951F20447C9BCD0E8CB8F92AD6FFE282955D20EA3619CBED9DF692824DB
      EF2803F4E168670F3128D68D66342EEE3CBA8B7FD7B881DCAAFEC758ECC9F6E6
      7CA7B114BC763C95B5A6F0AA008530C00FF2014023E034F4FC300FFCB1C139D7
      B4A19252B087370A844ED6E4B7F959FA0467E9F2FC2CFDE2B374FB9B3F4BF331
      B0A51A9D3090DE2365C58E8D7FD5D011E4CA484C5A193DD55C01BD77B073D8CC
      D10CE2D42F6CF54E06DCDE063AF57E78ED7309D7511A728B7BEE0D8C8FFAB7A6
      8D24CCFCE1FF0DC9CFE493B1A5D030DCE1320D2EDBAA452F229AB8EB28048C3D
      8365366DE020F3D21E1F0601E5087CC904D6B4E194D9D146F78BF230161704BB
      13A7A59662237B856209CD8DC8485FB70A9317DDB18FA5A95113177942B93703
      22A2BCB0F73F5C634886DFFF9029B8244041A8F66E9A7C948E3ECFD320E2AE4C
      DB8609B13C431FE01FBB288EA719F8FAAD809D671B6FEF7FD37807E9DAB30C97
      CFA3E7197172FD3C2326F56392BC896A9B5BF5C816F24EB2A19F44BF98CC6BAF
      74389CBDBA8430F640E88F0BF23D190F4AB9576766B69F839EE4E528D5B77CFD
      EFFA030E90FF788E0EE7A64DFE40B8989FA30B9D499080CD0E26C1380A8AE7D8
      B66A7AD0B251A0EDA64D60F24C180227AF9F194080BBAF84EF389D14E349A134
      40ECE0C06CD4A0A14DF5816D7034091018C59297566552DBFE08BC4B5FBD2BB9
      4512EC763F7E24C5EBF4EEC78F6426E71F3FDAC6DBD0DB8B80245ED0505A3314
      EB571078B336439944124F90FCDBCB28D4F84B6168A659AA7E50A4169BA57943
      C4F084AF11C1FD98360392D4CC767471B6BFAF2568B4645CBEDA113D9B6488D3
      DA42D058D0FEC6C9603AADDFC128EF55A6BDFC0FC546A31F5C2F7B0313203ADC
      1F8D3F4E93573BD928CD5EED8C4693440B43C74868E597C614CD5BCD32B43727
      7B17AFE89F55761C4A621F4E3F5AB4F3C5855440089477F7864DCFD09B8C5993
      5B2B02C414693C69243C8148E3C0E6F4F64EDEFC97774922891B6898E860CE66
      50F384060C2525E75AB537769ECFFBD7F379CBDDB5799DE51727F4D6662F816F
      29A107FAD97C62BC8DEDD71C581D913D1B08B89B1A37538073DC703D400A4059
      E7508BE6F9235C85CB1DBE1CE0712D7075E34E0F11CA4A8FA4A2D57A115944B7
      DC48AE643BC2A3A3DAE704F0C674568C9A3AD28DD5D7156AE52C2DC4AFA1C7C5
      3811B35149D6D4AEB840C891F03A29A10AE0682C35CFF2BB4C8B2B739757D13B
      4A080EC5F1683F833BBC8FCDF70CE18B976CF644D9A88322D5B1FF2C51D7EF9E
      236EC3B30E5CCB6709ADBF7CBE212769629E279DF00C638E125257C552F3D454
      1C7AE797D1A05070D7BCF0A50EE47671818D3544AFAEA2311318A64CB8A7DA8B
      AE242FB50D8F869CF48CF45B3109149042EC3CB25EE97D982B09ED5602626BF2
      AB027500E40A364E5A8B0BF7E4C55E3CA472F2C327753DA31027429BCE021DAB
      3D0450DE50987BF5B814C86200E136946EC9DC021CC73C38342B240610F6AFFD
      28B665110DC5B793D76616D028A7B7BCE324D4900C39AD40A2791687923B8DE8
      00D4406FEEB5D181C194E26CFC376E4B80FDFCBB5D604247186712DF79C7A8A0
      C0AB3385771C8DFBA90FE2CFFD3CA05F53ED4411B273D91D4D1B7415C541E1B7
      ED9645F452BD9A7042A6EFC08F734BF201DC6081E9D62E3309ECA393296F9E85
      AB705852246318694820FF3AB49847A9F742B8D9675F86729A174D1BF1E2C203
      F54F1580A6FC35C29F4274C1B08596B9BECD3BE5C7A58EF7639A91E73B06C6D8
      9B2CBDC991C6DE898BEFDEAE356EF72F2EB8791D23F8498E2C187CD3F46AE467
      577AC26961DF6B8F25B0D2EDAEDB9498EF2EED789080FD6C987A7D3FB86A9A34
      2A9D0D030CCFE27EFF7876B80780CBD4A67A92F4A6E3BD48931715CDDFB4C1DE
      EF586CF70D8D5783E01DE09B3B279EA302790397B78ED216FAF948690050924E
      FB848E393ABF8512398FC16E20DD97B4C5C7B1017EA99E0D77E92473586ED140
      59109A268C7A987CC611D8FEF1E2FBB30EE7023ADEF1CEE2C287A38E2446C6FE
      F82E9BE4BC213ADE3B53EC83E99B51F01DF72849CDB5081DFBD747DCC8EBB58B
      4B3FB9E203F56F6972136E36770D49B720CBA36D05A28B6209E3434A5498560F
      3F1CBEF3DAC338EDFB317F447F38EE7A17978629EE5E8023DD332436C1CADDFD
      01F9D302941D5A3AADADBEB857C15F92D08B54AA326C207DADD2E6DB18614294
      3D2BCABF9EBDDBA311F76D6A26F5CEF6DFD202644A3831B79BC9D783E20064CE
      B9B22D935AF9D3C3BDD5CA6069FE4E77767F20F5C32146941B376F94A80F7873
      7AB1671508AC02ADFDEFA7E11D4A680A2912001E0F5D79EC254D5CB43CD03343
      977251C7EEFEE121EF4DB60B86D2D8E14BFE83B38D83A6E2F19FF75E29ED9716
      B7F008ABD6D0C9DBF30B3E3BC89696A280367B442FCE23AE6E525BF185DA4A6C
      350D064BF394EB53A45CE778045F9E729D4DBFF82DA55C4D3E56D221A5BF4599
      34A999BE19A41969947CD4BCD8826611D7365E8305352FC819F4E814CC06B1C2
      DF93A138CC4C9E7383582089440453E214EED7D886D79A366E9B3E5F59DB7CED
      8967215806EEE4A7F310F4B005186EE090E4DEC1C511FA4E39D04A27680D2127
      3180E70CE8E3A481853980684233278A03F994D842175DC6164FFEF7098AABFA
      192D0D53DC978AA6D987113BE41263C3F72C642963BCE7E473744DD7FBE9FF9C
      46C579918E7F6E9E8838A8B2D78F77B99C304DEABC1A5260401BC51F222CE9F7
      517F1163FF986BC821BE6323937D82540921850B60D43451B0D9EF880DB49B99
      69946FCAC88B9282608CA1D02A36CE0F071888E87B6C00ABECEF50201E14807F
      0F2E254B575C6AA685ADE6DC969BAF8B9309E31AA89DF20532C7241A6D178604
      B29B269B0723B41DEFFD01D70F65693C15AEDDC9732890919FD01EC93AF6F7BE
      0DCDF2066B606C56C30E728AFC75F7FF3BF3DA26B1D557BF2017E9D272FFB954
      772DE147377AB8A74707E70DC5647211C71187C2D27E9E72E53CFA92E38A1DF0
      DA3B3AD97BD3A17FCFF73ADEDB77EF76F8DF73FC7B71DED0514F942AFA70977C
      FD32C4E8B5D17D65C2CA39FEFEFC875335719BBA33DDA1A4AD5D9C34A4D9BE36
      9E1F473EF2A43C6E8F4E73682C68F1A68E550CB90A68A32511E62856A377EA8B
      3D71225F28F1F4A5E1F68E8AA5F1E2E5EA4A6FB3B7B5B6D1DBEA2EE37F2F6098
      F40D33CAD2B84389CC2230A44D31722B4475C9FFF9EBEEE18FE5CE6FA8986C0A
      A58598D0C78F42D3E8F501CD92B76C99EF74E6E4F79234A99271DB3487943563
      633375421347D62B3576C5FAAE2A6E5AD50CCAD744EC161DA1A8AED377676715
      2389FEC92663C7CFE71797C30C70ADC2B2E65F37D0DBAE0D7786A63E7AB7FF96
      972BAC43D1527F3D3CD96DB66272036EBD4F2639FDD7E6ECFF7ABEBFD722359C
      353170527697CAE024FD5E9FCEE3D3DDFFD79991C69D738C3F49AC7D8E57F8E5
      B1F6D56F3ED6BEB8A098BF99B97E754C737A6498BD1691132D8C9824B499BADE
      7B3262FC018C38F248D9CEE345920A25A956C823E3E78FD1F3944595ADD79825
      736E804ACBA3CFCCDF2751062444E966629499909B5E4989868D1B9ACCB34F33
      850A95873064309560BF19DCB9D6F517704F23E9E6E28C2F9643D346CF31AF9D
      CA4A45692B293823258D52B5DBB851B5FE6B321A33374CEA4C37315D5EE4B6F3
      6E9C8E2763EECA6FDCF0F613C4B35F695C9BDB2FC912951E432DAC6FDC980ED3
      A16C2514025C9BEC268BE8B513944BAC1DBD69DC7016177EBADDA3450896A9C2
      8F494B06C632756708C8A2F805C180CB2C9D0C2FE94CC11F4E6DB293F6E3A58F
      F010B791E4853F1A77BD83C21B71C4A16FD0883398C4B8AE4062CCA35D2AA01A
      6C0136515C0ABB40175FE5F6282D63FCDA2F0CB07704C84AEEBEAE77AA8104FA
      FFDD1FB8138193839CDA6A9C2066D5D67CA21053727F0CE57B71241DD74870DC
      2908E952D755047C0D2BFFD7D8F5334D3A740B3EA151776ED345AF9BB62C9EDF
      645FFBE64DF6E32A8F368CBAC66DFEE3079A4EDA25097D668693D887D50D227B
      06775C6AE438AB59DAF6C5A1DF27F3338457DDF12E76D1357548637993DE366F
      74E7BA06B548CB0F00E347473D07D22C5A80249BB9BFF4BBB77C68C1F016D791
      D43CF921867ED7B32F5C5C30A3B4799238D3D4667E9714FEAD7749AA2386FA80
      1F9DB95631F535BE6638EA5B3FA8408196CF0FA92F3EA47ADFFC21F5C1CF2221
      678D7E418F7CA1CDE34833303A7EB779359C271306F0910CDF03636AD6880E24
      8CBEB2BADEA17F36F0CF36FED9F2DAF8E7C6CFBD162AE9B8510CC36E2DCDD557
      F9C8A3280FE6DAEB8BB5D7FA37AFBD161776D1F23F4AC36810A1C59B410E4763
      BF88FA511C9177CE464E3FA57FF60C8D32F2FEBACF1EFB5FF7D72CEC670ED8CF
      3C9D64689A477963E3D483848CDFF8B939C6585C68224FBD49924B604738E9D8
      08543433F0714F0290BA68EEA079037F7357981D0CCC8B4D32A44926C72443F4
      85AB5A367A5E3F2AF2795EF129F28AABDBF3BCE2176BD08D6F5E83F23C934280
      D2B88EB4A07B9446233F219178FF5C5CF8C747064CFC3888433846FFF8F847FC
      8822B3AFFFB6DEF7FF7DBA7F767870FC83D7BA2C8A71FEFAD52BF7B2DDD05C47
      7E0218A92E1D02AFE8BFAF2E4CBE8EB77E794063CC5FF63636B75737B7B6375A
      DE3FFFF90F8C23CBE387C741F33E7B2493F86330587D8201FDAA41FC9356784E
      06AD2C71FC841726F5734B9B81934A779BCB5B1F07695AE88F411AE7B7F8C124
      61726932C3DFC7575044849DC1F793751DC41FF34191F4FFF61CE77AB3348D2D
      B643DB5B94003ED3B74DA4A109526CABF6993688EC9C1DED74BCE30FE70728A1
      DE5BEDA0C9FEA479C1141DF3FE35AD2D9812880632E89437441703F23F077B52
      F9836C741CFD822BA42FA4A1637DFB50851A632BD858AF70BF38E2B9A68D55FB
      00977BDE6B1A30BA7D52800A01D9816C47F47C3294583EF2DAF8617899E6C512
      27115D6AB0811EB6ED7FDCDAA261EF096500C704E1210043D01BFBA00548E3C9
      88DC86A800021FD9D13432500432983E76BBB67679ED70C2F536BE77E90B4444
      66E8886564AEFE64B804500DBA3E02C5003C7771DB8552C847F15C6325B8B2B2
      4D22B4203D979C04F5C310FB82C49AE7DE5F0FCF0E5DBB9CB2D901C2526A9524
      5108F1A4B9916B99C4904E3E324F326E2F4EA2616231466CE9EFC1C5518345B6
      4C22E32C4305988DFB0719B02D57464A52AF51A86D9679D7DB89F3B4C3165C6B
      FABB2D78B5803510A5D438C99C546A13947808190B2C16C695A1F3B540CB1C6F
      172967EB1B3A58E0F2346EB0AA7956CB6DB3EB8FC9417040D55A4B9B08B62177
      1F730787761D2F2EA0EF388CE0F2C34EA4A5B167346FC7DF66BC73DE45284CC8
      41C2064C402CB07998709E8E7F0A4F77F39BF7741717AA895054E7B05DE3CC36
      8E14824A2A8428C77E4E36ABD7020B50CBBB3277744837CFAA4162BB82156901
      6F1B398EDA81F655837ADFBADE9A6767FF359DB5D5009DB58B6C46C6AEC44D14
      C76CF0D87254E3C121BBA59173790EF96A308832B9302A80CD726D98D32DA581
      DC297643DF5C4649F354995ACAABEBB0942D74A336DD0BD91543F0A00100B835
      8D1B9FF3055657D817F0858F443155D2817746F62D92D8424CC7F8A6EC4A92B5
      77E6F84E1CF039479E62FF4E3221D20F022B59DC2BFE384DC8CD3A668629BE73
      C99AF2D7DDC333EB57D565ABE0008D93AE95EDF2ABC5859515F8F8A5CCB0A56C
      33A940EBBBC6196929A90A384ED3ABC9D80B271CEFE2369A50D722030101C786
      91F6274966E2A891A7AD754A37494C6F841E512BA3DE5B364538DF7B5AEEEF84
      93035BBBA98385F7255EA7D752484089D8B66815C4D6886AAE7BB9B202BDB2F3
      A1DA28ECE593C58512DE8B717B480BB0B729F9E2AE772E715B4CF888363F1D23
      7E6CBB8B5839408F68CA39BEB31BC37054984EDDBC79CBDF69E265E8890F1CDE
      06FA9BCA4C7429FC6CFCB67F7EC43DE65DEF8D1F5C0D398A57B28EC5D1285258
      30E6D5A5FF3A9434951437CA344E4656429B7C1A4B10DCF7FE3E3179610F0E3D
      A8CCE2C26D91F98207A76A6490F943801048CF339D4F7D633988E96CF9F4926B
      6A3F8995D806496C9F3308B5F64C6D5E048C9E2067F16E441225F1AF470C49DD
      25439FF6DB7B946A20AD847068252406AFD60C06A875BBA68DE87624A2CB1228
      13D09AC6C9CE4A0E96DF899ABE109CAC365A4B8B0B4381B420A1FE85FFB8A328
      36E83CB151F7B2E3A9EBEDC9DE43FAA663D758C4ED9340268B7E3161293F45B3
      94881B3AF51B2B4004993FA411C9E2E26E6C9425828C4B242DC66343BE4ED73B
      1261E4B2056B9B6DEE6A6F7A3F24D8922C96B9C3FDC50EF776031C6EEB29ACD1
      6679CF99DC7B7919B1005057A76ABB6395843511E8E422EB3F6568D4D7EC25EC
      A27D6220CE9C73E4FB166E880E3DF00D14920F74544EFC2A60366A5E754079E0
      B161ADACD46A626A79A280432AD4944F66D1105CD54A5C15327DBB150544C897
      776D4A314C4DCE42CC39C87169EAF7B5C59D7A9AF26F245F4980A4888E90A8B5
      207CAEE0E6A5D2BF4EB3F59AC38FBCB2023BAA056F6532D6EDD19234733FBD25
      D5155CA699448DFA6901022DB00290E26A9C0AF2AFD3081067E266015F38F069
      9C61690992D24D3D6ED60E4D7F3244C0EDABF64DFC8EAB85B7E6D5C25FAC44BE
      7DC4FFC5851F718217285D52BA2D3D4A2324190A3F51EA4543CE281A48497730
      079525DE14D3A96474C5114D3FD1677EEC1D9BDB093B71E785F147ECB8E697A9
      720C9085B4C726819F5F797E1FBC2CFC1A7ACE93869A8C1A8751EA60264E9596
      A92D958416D86EC9D1D2C0A4947CF5884E681B6311EB1142B0FDD87B993F4C93
      7E9A25DEDEE16ED3E4A1D26801E04A8D46EF60AF35ABE452A3964D1BE10546A6
      15390E046866710E8FD682AA376D983BDA7E05652019A70A132FFD51D35AFFEE
      6D2D2F5F366D709C9C339CFB00BF591CD12A0DD2985DC324B4B48AB65694CE05
      6E4C6A2AC5F0E242AB4E91E440ACA4DB2E09221850E2A829F1E6E1CEF11E98F8
      3E1CB144E88703B7D4DB42D25C67675EEA7A2749859352F1CD18C54DCC8A8EF2
      B946BF349CB2F9C0720DCE240B8025C524B65AE732B7469FC21ADD9C5BA35F6C
      8D7EFB98986A2DBCD7DC7D18F971AA39CDE26E6C29DF19F97AA5BBD5B415B0B8
      70286D33E65568B483C6789362B0A5DD368885657E92C765AF91761F7404DAE4
      8E75EE68247098A45151F4785E64BC2F48345AFF0818494D7A1429E06F1440BE
      6902534C503A44C4BA78E5121CF95534CE49266148269502BECF35EB9368D68D
      B966FD62CDFAED439795F087277B17D02C64A0B0D11B7AED224B277D14127230
      7FCFBF498613E0EC9ABC79FE77ADAFAF2FA54E673BBBFB5A0C2EC809FD68CC74
      38EC8D6A12E280E31A2427073D91F981F1A64B6984D04A232564DDB9A6C01937
      9576B3B20E4082240D858DDCD1A238263EA301E1874A213A439071154C05778B
      5C8369EB774EBFFA244A7A7DAEA4BF58497FFBD05D4E49934709023E2EA602DF
      F1C1E9DEB9E51F141DD6B4E9AF11D7EFED83B9592BC5760E77BFF7DA30EC5B7B
      46006C588F2057458752AB714750FDA8AD90E1E58CA39D19E60B55B446BA6615
      7B5B3004E8DF13E145C19165CF1E84DC52C620409A9C1C1F4FF0089A2698720D
      D89384A114B82C29117E6F3776AC073E3B780BF8D7565E2280A68DDC2D0959FF
      7DE0695766F748289D4ED9B16D5BBA3E9209EBFADE125754A06AC4150702363F
      2983E6DEA59F33BB712DC4D418F108ABBDF5FA4751CE553A4C03D564B6A707C1
      25CE4FF70F1B4A54B7B870CA7D942FFB8CC955463CF33B327347BC815B3BE331
      AD5569CE6C0992429BEB11CA86C59A5108BA6090131669E3947D4BFBDA65988D
      7BFB1DD2C277BF18EF301DCA081094CF329314F19DCD54E64F01DEB3FA64C3E2
      41F87443372C1EE860D54B3F6B68AEF47AFFBAA5C95F7EACA919C5D7F1ECEC3F
      DFE65BB138CFAFEEB268E48D35591DA74F9197FC7A737DD28FA36B844ACF2609
      7AB444E59C66290A0C320CC7FBE7BF8076F6204AD8AF1FD234DED9EB57AF6E6E
      6EBA090A25466998334458AAC37A85BFBCEAAD6C6DAC3D0EDEECC132C2278537
      7BEC3BDF4733FBAA5866BFE12C364DCFCF9DEFC7CCE9912471D1E9E64B39779E
      7AE9001C41CCE788F391ED7518E0AD13E45A5AF0EFC4C07983465D24C05F65C6
      A7BBF7D1BCED2C7B7AE78E776EFECE005C1D4F13419CE7E978A608BA8DB37CDE
      4E62900E8D61F15D01C047E2A69967E3CAECDB5FCCE37D4F11EFEBCDE37D5FAC
      729A00763D95F0468389475E21A8BF695FC570ACD873D46ACB6E71CBB5990C88
      203C55A9F7E6E4FC9C312A39C2641DACA6AD973A20E3357A49B9EBA342004D5B
      E22FEFCF2F1A3A3230B22B173B6B2860804DC61CE8EA1B609FB9D2B30AC341D3
      C65A06BA38D2394AB97B2A36433FB8F3CE8E778E34298660DF9F74192B14937E
      225CC20884D2BF47F8F7C7FD9DD30E8789E93C3D386F5C09AC938925AB993D44
      17106431D443829324F7074602C1E3BBB2E3DCC64F189612A786E889C6D91220
      99FED93B4E39B9A115877B073B871EDAEFC78D8BFFD18C3B6A3D5168F7D9EC99
      E8D61F86691C0333936EE105999FA39B05D4AF5A57CF75F71C5E53AB74EF70B7
      71E2009C80D72A718F5ACA040B7A0780B3A845AD8CB71CF11FA4310EC168A0CD
      0830C6616F37EE5873B5A180E4215BE4AE3CD86911DC6EF43470DAB849FD9E66
      C8DBBD383B64E39F8D1471061401012C1E58E383D24D98BB024FE10AACCD5D81
      2F7605BE7DD6066724E8C12F45AE16C40A1B4942B5D5F83CAD8811AECE5FCF23
      F45F1AA1DF684A84FE102A4C8CC6BCE31DE0A8E878E7634366C393F0B87DBD69
      A711BCAE0FA0E37D6F7C8E8E15F4F35B3F78AAF68FAF37A8333F30AFBDEFFD28
      A311ECDF99CAE4346814BBC21F65B266BDF699914AF966BD356AD93D70CF36EB
      B57FB06E7A9ABCF676B2519A91DF6AFC3102D83BA351DA818A9A9B26BF5BD304
      EEEC2BF6D37FE488A4C95085066BFFFDDE9938678283034662EFC667B3970C94
      3CF787E20A08D2241D65FEF591E09F356DB94C856BEF79F579776E89FD6E2DB1
      C58537A77B174CCD6AFB08EE68A5DB46AE50E2D512CA611803663821E73E2964
      F947036E8E2D3C3C7742BB02F5F1AEA257EEC67E336EF41431BCAF6ADB91B35A
      44C0EC137CE1EAB0F0779247686E7FFB70F7D71B3372119EAFB8847550E572E8
      3CEAE60D2B2F7879DE9F4AFEA081A372713877F8303E5B72C5C1F3BDE89A0656
      A459E322E77303E60B622BE4619AB77FF5C6976962D09F75C3468B265325DEAE
      15BA95FAFBC61929E5706D135C5E2F3FE6C12179CC5BBD2DE31FD1C113F3E116
      080711AB6A5CFA27B9AE84885695C7E8E8C544EC3CD2F068701B907700EC87C6
      CA6C97070F3597152F4D22D46F8C4B0B847EFA0190F1E7FB7F91CC451B2D8380
      E9958486CBD2082F838FA2FDC0344F1A651792E84C2961E70AEE26C2A54B7BC1
      EEF73BB6E89E97B96D33101CB94B3F06E1342D68C119400E760FC1A9235AD077
      48BB3574D87B96BF90F3A99A5FEDC846F785D85241506B3A829B2F3423DDB891
      1FA7DC69C540EC32AC1636EA154C991B8086E23741BAA7B1B61A373E9B4AE58E
      287A5DE9C605D48305F289120683469B505852C23566808B0BDA43F2368A712C
      E328DAD554B8F42974BDE3B43002012BC93199ED817C21271703801A32FB98EE
      7106A6CA931FD04B558884F45A9151874164A5095CD0EE146896B9516FA3C222
      D20E337FD4110CBC7B0FD3F0079E65B226B2AAA8BC2B70503668D3545D702E00
      CE1A87626BBF16CE7AC5BD5A5841FF2F4E875C603719A7CCC2D43C92CDC505B1
      F9461158A3007FC0EB9FF70799292F00549784B6D2428A2C2CF441569628B805
      CD610CE12875ECB702E5887B6367F0AD194E82BBBAE80A7E02DF0F8FE978E349
      C1451C49B5C8234BD3C2167988156E3F24C19B6052F0DDD8C6A29BB76D9F4797
      3EEC7834631FE42753047378D7A7292B589D97157CB1EBFBED53646A7FD7B974
      F2354E9F8125B264F990D229D2584D1B86F4889289D6678C6EC60905B003D647
      01A44560D6A759F328EECECCC88CFAA4C3C769AEF47DA4FC114A3328E1844E1F
      F94C7DD34833B4441192FA36658862B3FBFC321A14DFEDF5E3DD380AAE1A37B4
      9F76E2F867EFC7ECCE786FFCFCD21B5EA639CC3C0BEBDCFEE7B4AE5A655DB53C
      7D5A0D7A4FF6DE7FEC9A7CDCE537B9F7F4DF5C532E6153AAC92FD11C66006CE6
      C2FD69E7F0F067EFEDE1F905438578786D29A3AD67281A3AB0FDBD833DCF6766
      ACBC04EC7559A4C68DCA451FAB6D81AC6E5064A18B32AE7C56E247FABA4C412D
      664F99A2C4906C9C2854102FE3D73649EA01F012C70A2C6F2FA7A1069782429D
      32CD83A00BD7C421F0F20D1DFA8E90C8213CE9F4B10694392A5969057B857EB1
      94EC57B871F05CB592DE005A7EE07439C6DF3C6970F4520A8C8ED2F007F2530E
      8E4EF66C04D7A2E8234471ED678CCAE7A0961A38F73CDAD3C3BDD53A60D43D9E
      5E3EA5C88AA48DD1C8414A059170FA492EB94A12C544D80350730EA2DBE68DCF
      86296CEA2DBD4149E56534B6AB565A3B690AD10CD8E4F19D27E9CD9D77637C06
      1CAEB63545B7D5C4FA4E565C8ED2349B47699E244AB3B23D8FD27C719466EB9B
      8FD22C2E44659BD8744921B691043E3821C9F94840F36A19D57C5F3DC5BE9A83
      5E7FF9BE6A02F7E75BF04C4F8AE30FBC63D0453AF2B32BE5EFB640CFD1C00B27
      63F221B9EC455A8E69CB5D8322188C3DDC91D5B4F5219CEFDC522CD1AB384DAF
      B837B3F080DDA7CCD24D655D6AA1251E0A53D066F296238BB84C277158319C85
      089927D9147E147BD711B63F0761E16273E5D35C8B3E85169DA3527FB1165D6F
      02CF68C8FC005E804837DAD67DCBF6A5495DDBE4C13BEBE61259DBCB34E63006
      7788FF6D321A2B70965F3414F8F49E3E65C583218E4D7665B529AAC730D0FD04
      79F4D3344A1A87D2BCB820DEF9397BE78C9DC85116F9EB77FAF7530C7A5F06CD
      DCF3A8AD020AB1EF311B420856750E4B8234D296933BF457DC102BC701417089
      65D34485EAB9DABE40716C4646FA5D15E1C2F07174E3A563036B1EF1398EEC7A
      FE90C6D5B4312F2EC84E8892978C636E07438B5EE8BAE33B2F401887471AA4E0
      992BEC3A4218970DAB08A035204EF4E36888621B3F4047FB8D70911AF92C01CA
      794C7F562ABAE6196147CCFD21ED623C78F9C39910812C2EB0ED216D161AD004
      1FCB8FD23BF7DA723E995B126B048A233FEE585F904515D037E78C1ABFD67659
      EDAE77E7A81A5F6EBA3481DD188158DA60796EB26216147B407F4785C2FDDCC1
      7C3FFD9AFDB432DF4F5FBC9FBE7D7EC6C585379321921BAFBD419CFA5C0D3386
      91CB07BD9F45B9D016C2DC89516FDD1A4C7EF9E5AED5F52EC0EC8D4E99CCE4C8
      D762CBA1F162EA362490BEC9E4067A4B842C00413F49CCDF277ECCD8906423A4
      93219B0A779EAD845767248E46204394EA233F082619B007E977B5D6DA3DAF7F
      5798A5E94773022AEF7A6FA45E956BB941F88586DD401A9EB85095BF968B2BA3
      C186BEF1ECDBC94B4B8089FF3257274FA14E96FFF399C438FB8CFB6231AE6D3C
      284692D18362FC32E1B5CE8CEC1F75CFA560A0DBEDB6BEA2F07E8DB83E8F63FF
      EB8504A81B38170CDAADB522D2754F0B2EF1AFA3A1D4901499311CCF78F91FDE
      437255B1CEFC5814884427D907B61F9226B2489F7D83182554908D8D485721E8
      7E10ABF6933BCE88675158612264808111040CC51328744F28C118BDC712BA59
      F8375691DCCEE8C96F420FCB816F56797614ACA151C99F9BC124B6AD30ECAD8D
      68BE23F08593BB3221BD4E8E4B61DBA8E83C4F9889569C1C55C2834931C94C87
      898BFC98DEE5C64FB83CC58F6FFCBB1CAEE23506E56B74DD322A7A6DD31D763D
      E94B7B7BB2762A78A6A495EF60C491AF880F12BA107289FDF1982F54D16AF94B
      09B4A0EFDBF16C9FE6C8BF82AB9569E750E278EBC96BE7DBC3CBC214D9AAB2EA
      ED11DEC023FCABC505E389F7CBC624C650698C9C2E5EEC3F7434F76B0C0D4FA2
      037EDC393B3E387EF7FAEB1750D2A2702131CC4265BDFBDC4E93B330654A6477
      F06C68EB16F77E003383CE4F218083BF2C1D55343957B219B8DC406FC13338C1
      C15C60E9EA5F91D86127DB517AF212C6B743333649E84FAF8BC408583D5F076E
      4EDEAE28ADE24D459FD042E49308946B129E206F5CD694ECEF2275C3ADED3B7E
      7D5F9AC22C961F9924B48F618BB87AEF1DDA211D1985DD07586B9C7D8240A2D8
      D29F31F340EC67D02961C82D6DFE0DD91B2D26CAAA888C3ED77E1C50444FC6F8
      A9F7EE8DACD76C22E4619304E528BEB7D1EBD3E8ECA369C27EE4B2D7B92BF404
      B6CB5A77D9DBFFEBE9FED9C1D1FEF1C5CEE1DC2FFA62BFE8DB6757961D496FBD
      B8003B00CE062297A8869296C37B651D1D758494FC7004FD340239B0B81A1523
      81FE457B08F03E433A9CE4E426EDD0925F03EEFC559DD7620DE0632BDF71611D
      5D1D40E1914732096C67F038052651049C023A9B8D366FA07B564FEFD62E93B5
      2148BFCFBDE12D47F5DBB8A2B5540D120E4B27151D470A2784422F7B5BADFD30
      4AF3C2C2AC2AD5A63AB023E3277969FBB0AACD8D46B773B88337D0B5D5E20277
      71188568C0E40FEEB8413237F1C06BA34106939B786597633EEA78BBE7251207
      57FFAAB369330C7DABD671AC908574C015FE0E1A1E1F48EBBF1C2C760215C447
      60D6E9605B5CD046713A5D5E26A99012D000B0A94646CE51BE339B71D5DB634B
      425EB9D1D10A3E482EF62B9DF6249C2B63C6227FDC375FAA3D1D9DB795875F46
      D81ED5C7F3D32F6A6FAFECA9924779C9979FBE3BDB1393DBF8590C061A4BCFDD
      B4B58A763737520BF61F856C0B45A32783BAFCAA637A3319A22694D343124CD1
      428DE0328D025BD4DE3702C56161A6C49A6ADA5817172E6855BE4FA4679E75B1
      C26F94D3AA3A435CB15364B5C8FEDBFDFECCFB6999FFB7D2FB19EB7F5FFAA94F
      7D5642A5ED774EDFD4CFCEB9CD8E047B32660DCE2D77F2053507E9315DEF5D24
      0133F5FEC6F2485B2603C01AEE17A06D2793102E2E286448A716E472D93DA944
      174B9927CFB66EDFA4594C5FE2005D34288373636C47C1C1CB0C7B6698774847
      9A15049F44BA063985EC341CDD883365A13D99ACA7D0B863E8D14B83D52CC29F
      4EDEDCBC056B423A9EF8BCB252EC88168EA32BE9A06F09C788F7E2A06A1C48D6
      F18577C6E75C79987B61DAC03E191165D9A3A7FA043243B5DF4DEE55EB55387E
      4CFE270A32D4C71239937109951A708659F19B78BDEBA5A1D13F42F4EC78CA9A
      0D62F41D499C811F4C2B56567B055DE4D20F65F932EC48D96837F7A4FE754F6A
      759EA4FD179CA726102FBE43ECE7DC828EB4DF1D9D5F2CC92EC5A666401D77F6
      E4697CCD14EAE88E4B05DB24CD0EF63A1C3115BBA1712A6D47EB63F4943B3343
      B1751D5819F7078808D8871417D0F7DE2219255F9EAB98A750315F35D1F4ADE7
      4A2EAA11494D34704FE2C8FF5B9AB1F0AC29E1C75171A7F17ECDE2C21CEDB3F5
      8FB4AA1641D10DB5AA09AB7B3422D3737E3AFEFAA5BBD29DE3F77CF9D9D80486
      504164B34995419421E882F443597B40071F79D2E24BB0A5DFB495508ED1F756
      E116D6C7C7D5A47ECC6139F0B6FB603F6ADA1811DB715015E8341AA6D99DD7FA
      3E0AC95343C8E3280DBD77E83D6A593A40725BFA464106D9D869DA981717982A
      C2923AD220ADB5E6D1F1710CAB4F1635C29B4353540240F85B2229415AD13EE3
      1994ECB84D138443D21D439F08BFE5A95F5CD28447CDEBBDDAA199E024796B92
      00533569D90038FC638E3C493195360520FDAA263C531B346DBCE7D3A186F664
      712157846C5EBC1D6BAB17A9975F45E30E22E2DA49D8F1BADD256D8D08AAC527
      1CD46B9DBB2043ABE37E3B4E1323B99CD601721685E7DEA1D534E9F921F2E818
      FB444A483253918EEB0449078328404E4A514B9A364C8973BFF6CAB32CE0F3EB
      264B91EAB758B1647E96953C5CC2EF5830248814651E9B348896DAAC8B6F9757
      9BAB8244744BBC3E34ABA4C6B92C31BE5FD3E4479699C980E252DC18FFAACCC5
      19945844F9480F45A9D2A9A03E0531FEE4924F4D1BB61E9103B76AA27B69BCD6
      9B49145782BECCF59E493AA8E5B5697FE5DEDF2788FFFB5E5F4A5FE96F918241
      91DE0D8C209DC3AC5AEA7A3BCC74C0915057651292C2510A697A2B8491F561A1
      F7E6AE552396B7C1CE9287D2F53A95B83559F97DD0DAB8D29DA6E2F31C950A0B
      190D7F3C8E91DC55261BA9A3B1AD044194059311CCD4A091D1F5E9E839377C66
      E98D8D4EB1B7E4E528DF7345921CAC43831BA8BFB878C8E58E6EF2B2A38BABB2
      6DC04A5030B9B650B0BD46669476BDF3D455EBC17C307E1E71B4806C3F4B770E
      6CE334BD6ADC6647B2ED0E85EA43EFE0C53577410E537A7192431F07C39FE6BD
      5CBF3E1032EF3CF9F2404813387CEA49026861E9840C2B1552A4309A36F96F6D
      2E96BBA861D29DA2F4856BB176D32454102066ABA0C333E4F14A536DF382202E
      C6917B6D760444EFF19910FB7494368E7F6B71A1CC5B55CAC8EE3B8162E12DF1
      444A6DF12B0130E10A63DFEB1626EFE12C75E0FBDC0BE02A3F722CFF31620658
      231C1AF173ADE87080905E5BBD298B198AD281B19F6BAE4C3BB21D9A66E3A47D
      6ACDE28CCBAE9991A8DAD509C14A18B1149EB2DB94E1C421D9BAF373F60B66E6
      BFC91CFB01B6180E5CFE6D8716F11EB873E6C9B2AA9460D3B1A18A8D767399D2
      12541B05D1DFBD94DC02F298BAA4028D5FFCC1FB9E0CE6C104E527C58CE2D207
      D88A70C659A7421B1CA4BBE7B62CA5F4EFB5A0CC44EF7E4AECEE9707582118ED
      C18857C6A31A509E780ACAA2D58E6BE1E45654C5BCBE64B7C4782D1695C22C38
      E42868C54972296D49039AB04B89CD9F28FB003EB7A7F5A35A23FC1532E1F278
      757D9BFE859FF3742BFEDE025F5B111D5A995D15D76A6F7B7D6373CD1213D3BC
      FCF1236AF74CE817BEB7BEDCEB2FAF2DF7567ACBCBCB1BF4FF5B5286B84AFBD5
      6C876679D01F0C065A9A182CAFF27FD7E4F7F57E6F6D63B061367B1BEBF8777D
      B0DEDBDCDE5CDE58DF5C5B0F57CDE6D646B811F8C1F64AD0EF99606D6D796599
      2EDAEC6D0D82AD35B3BE1AF6FCC585EDA0BF4A0FDF5A5D37DB5BABC1E6960936
      FDD5CD20580EB6B6B7577B2B1BC176B8D55FF537D7D7E965367B41B8BADEEBAD
      FA5BABCB2B1B1BC16A106EAFAD0D36B7CD5ADFAC6DAEF6C395C1F2667F3D58DB
      DEDA0EFCCD9EEF0F06ABBDD5557A8CE9AFF47B9BEBA1BF1E0ED6367B8370DB0F
      1717D637B6B6B75656FC95ADB56063C55F5F1E6C6F0D7A7DBF6FFAC1EAD6DAE6
      D6E6D6728F6EB6EDAFAFFAEB9B7DB34163A4F7E8AFAE855B667B79737565B0BD
      ECF7C2D581BFB6B5BC1AF4D7D637375637B696072189D30421BDFA4A18AC6C99
      3EDD65656DCBAC05DBBDB570D3AC2FAFF5371617FACB2BE1FAD65A688C591F6C
      93187A66757BB94FEFB03658DBE8193FE8F93DDA035B6BFDB560799B0467027F
      6BB0DD23D9AC6CD0D8E8D7FEF6EAE6607DD5F8BD557A8ABF1284EBDB01496AB0
      BDB2DD5F365BEB66639DA665656DDDDF0ACDEAF26075B9BF15ACAC066BFDE5C5
      05087B7D100C36C8E85FA107988DFE60ADBF6DB6B6E9F5FBE1C6FAF646D00F42
      1A6F7F75CB6C066B1BEB2608E83556068395DEC6F2607D6D60B656D6C2B520A0
      D7E86F0E64AD0CB07A68BD7C6A9DD16C900CFC4DBAADFC71997C9F15FEA1AF2B
      6DB0B94A6B2CD85C5B1DD0BAD29FB7B090061B3E5616BDFFA6196CADF74312E3
      CA6648F2A691ADD0AAA29918F8EBDBCBBD354CCF664813B2B2BAB539D8D85A5D
      5DE987B4220CFDDB1B2C2E0434ADCB7EBF4F7226719BC160D3DF5E0B07C6375B
      FDC1B659D9EE19486763DBF7FDE58D60CDACF668E105FD8D2DB3B2B9B116D2E2
      1CD00ADEDE5AF77BFEE62A692592C3D62629277A2E3DE3FF6FEFDC9A1C37922B
      FC3E11F31FFAD17E7004EA8E0A3DE91ADAB0A4955763FBC52F055441D3564F73
      DC97F54E6CE8BFFB4B90CD2648828DC2CCDA72AC20CD4C935D0954669D3C79B2
      48829D00B8774D56C910A66C94EA92B36DE74D139DD2ACC2D0B6395A19A553B1
      DADBAC58E186244ED6E5CE58AFB50D430A5105E5861C405E2B532BC48CCC3083
      539EC40A26E04A6987D4F67118400D31EAFB58ECD02BEC07DD176759144FCA44
      6B7BCFAF3C33488ABC827C9DE93298865753CA5695DC74AE0371D90F79BB364B
      56D6772146AF7CBB638C36ED99643C600EAE004B383D6C7F7EFDEAF091FC6C33
      2728FC09F08A7E62159CE96D6E587B2DACC29A869C5408B1810D588C0E985AE7
      49FABE4BA5EB0666664DEC55B20A7E21A27100D7646031AD31A12F191C9332DD
      EB57F8C30F2C64DF8426B7C93B28A7B4AD803AC03729B06E6D4EB6553D0BD5FB
      BE704E458295185A45C43BDB926879B011581AC7DCA00A30083272E772D64DF6
      9D83AA9C5685B5C8D915F2D70214A88E1904174ACB6A061D4119BFC41116B4D1
      A6AD89FFD0F4DE441721E520CFF5516FE3EFE7E2BFFDF9F5ABE747463DC5BCF4
      0E8E68C91830098A9AA158C8A31F8C862E34F02B2DF9A8613080153925161987
      616FF097070F17E718078A86EDDB8EFAE21343BC6A789042D7B3903AB2866D78
      FD0A0283798887E5B161415B4D060F11977DEC0032E90BD2B331311550E612A5
      A8148DFBB1ED6CE3097647251D0AECEBE48FCD43C8B91F5CD13EDB8EE585E902
      99406A126CD8AE748598B09C5EDBD7AFDA3C249E3254094018845220EC2ED926
      DA4436142E689A10CC00BE42E9C8C76C29811A48343178DB18F8DC86C4C81E96
      4E7D5B70D399D206AF20CF01DE77B614D50DDAF59D22B7C96325C168892B9529
      B75071CBD523B3CB21151DDA167629D124DDD86C29A305F6A7C4521A4C8A1950
      75386B4AF203816892C6A5E28D05942973C2086272DB3BD2DE680DE178206A61
      D6A21A89043C018BB9DC97A1915C28CA2465836A58F1C1E2A1722114C29884D2
      002A2E036CF8C836CE47E3BB96B571A66F91241AE63409C634A6ED0050B23100
      EBA1C95D6B4800AA041155EDA0BA107A8F8BAAEB9005A015D22882832885ABB7
      8800E0E2A931C1B58D90E480A86815AB4BDA64BC503950B521766A30E7052908
      8126C1DA42CCC03512044E19F90B1F122CA486C262B7067619A0014DFDECA0ED
      E28732E07747192406C5864050601B659D89A424BA8DD2018BF05C1752A7B356
      B62365869487C695D258DCEEB3D5816AD02205749B0C2310202441342D35B303
      23A9579D6E22D90ACA597E106D83272558E608E935F08B829535C5A0D7A62F2C
      69F49A7CE9414E52519004C4A3A5698622FB1E924E8051236192862E7A6A46EC
      11133CD174CC135A0B45E12ECACC8E29018750829B3C681173F022F587009080
      90D29029CBAF5F0D4EB83187C020D6C35301FB2E422E164752EE35560C5546FE
      EDA91271088DFC0CBD519306C21131560E7980A2043A85E1FC6F22439C418EC0
      D3B61F14DC2033600C3F03B020E740A575F26FEAA85A032143790693426F3D0A
      066C5014DB4CB4FBA4B4A3CCB4E8115384FB75908C522AF38BC6130BEB542BC5
      95780DD9538451002D00EFACA5D43A6A814D5E65680A26F2C9A3440734028C84
      3E801A2217C9885FCA5A40D3699E055BD69027DEC6981D3C3D14E7FA98A02578
      8185D7C8301A43A467EFD02DF0A5E89780BA745D6F7A57A8C80D3544C7AE4F64
      A0475FE08E8267800626BDEBA9CE9140760ACB5E67C80D4A042126412A5CB918
      D517641AC8872A5B6BAC4DBD66BA284EA361499DE848C06F8B9E32DE00CAC2D4
      61664F2029ED1A5DD279E75AF213D4C6D6A2A6D0032DC21020A221E0C41EC028
      27CB4F947080F873DA8E11B645A75B9EEB90FC304EF228C4C685964CD0C48709
      921A1EAC906C062D3B00232415176355E0EE816203BB462B64E92910A0BA8406
      BCDBDED2176472975520933C1D07C02E2C18C51D3693BAC07CD1755A2EE3C9E9
      48599218F7ADE7128DB1AC4A9790428880D6C373030520237B78441D8ECE3510
      F030A074031A0A68F6A4137A8CEC6A3DECA83A8F8EA463B10A4DD352A87C6C94
      42E3D806894F495499C645013D5A1C74399320914CE9029D0F35903E4CF22E0D
      B6154822240CE76C50BFA37823A7801EABD8068767AC5018D04F03422650F8E1
      0DDC21F7E1C4A1958005C1FE00445D03249BE26380781C24EA33DC4921876CE9
      47A4A6C09E4391021BF89F0AD6C2A32493823F8D109B486CAB907AD46F8F9620
      21633F8A22594DD80F02F02003BE1AF9800491F64153300907D49D91C7AD249C
      2438D737F437344D4918B885A7A447311102477F310978C469AA43A2EA39A465
      21EC85644B14E8065E8DE4EB6069DB2003C44AE82C65A36B84F56165898141DA
      8EEC40282004E22C44EFA5F5EA91CB1DEB0206810C420E6907CE5806341CAACF
      8194DE75A8144826D11FA11CDD901A4B1273691402E30CF2039980161E0803C6
      569A061287BC847ADAD7AF602940E9ADEB0B02172DD0515AA003D19481E28ADC
      378D6609688A506254A540803B659175544052C5928C240D85049E0FAE5779A0
      09096D048500824ADD27E667EC009B94869E007505F2D00A544456A12914F886
      F41225E3E948B830C9426BD1260993457B40229A858686AD0D5C88BA483B88C0
      93B29910320808E4048B83DBB4330D8A47011B845570A8CE007B708236B308CA
      442E89BE9036A49355209A88989228D3D471E401CD0285A18511BBCCD8081634
      9597761905A43B222C3503D91CBA04F02D3D5E04001A6CF17B543E2BCFC9A4AE
      969C688D14E744C6010BAA4163A4DAA121C8698BF087914433F54D8989DC7203
      64890A4467D20B38437F06A6A84424009423AA02FF8292DD92D891AD5D544562
      EB50AA0A003ACE4B215096EE98CE081A6566A426CABF6531C0BF45F1500014F2
      870C4885EA3C701A275D03EB8B1040C5175A1D82CB8FE4B0A168305FBA6F04A0
      480AF410012327282E145384319A8D7EB98DB0183A563A04873AA1BB414F5BA9
      35749B902339AB61193A71BA1F32C60F30019509F687B76944102F8342C90444
      5832CC06E8367410BE11550B65473256772C2C5C08B77B9DA40A21ABB286665B
      4B9D825AA9DCB0530223C415A6410122E729E0948C80C6F2B2F581E819A2F0D2
      402E50C382140EE7048300AF4370E2690892413D028304F2396416A5B138E147
      BA11B5DEF5902B4BD64445BF6CC04F63D0CA5205C820380800D3F6123930419B
      4C533A48696421E84DA86A6D8AAC02BC63C4EBE2885D1E44EEC373A1D30902E9
      1B38DE8A98B27016A90CC303D644BD4286524B2D2BC132D1F8D11636B2F78268
      4235A72E225F614447DE40AD0E56A41C30537CF354F1D8911D9415545A4E3185
      16122748A81DF053DCE02122A88D5842E4090683F94985382430CEFF4A834914
      EFC8B22D0AB5F743E7A3438496DECB1619ACC094A4216C72A23A33E9E8C10849
      D3818940932B9A3B38E14439BB03D2381EC53F9A201E51B9C87E56165244DC26
      8A392D72A0FD1027A919B9903F4D2278B2BD14BA4E18BBF51E7EC0158427659B
      AE113285D2513F147C6424CA5B3A24D044CD85E1D0071ECD4A6F2B986952011F
      99268A65C33332C6780A8F761ED545F9EEFAACBA46B6CE1AFA1D04AF48556428
      2A622848627479219CCC13955402079A8CB6C4D346F5D28BC216B439346D89EE
      3C757461D23BC3D1B02B340F0503DFD067E20FFF2779272281E42F443E9D0A5D
      C9A0904E8801026C32FD1921939D06268B6EB73425868B92791408DC212F503E
      808BAA490E14281CCAF3B205A403570A048E5520C9996743D3D7836A237B0F21
      0D225B1A56001D1884EB9487DFE97ED12FA28116F7F4B8A6621301C96E2FA5DB
      DAEAF0D4D3B30A67BBFAC35DB497F657A6BB6CE34E8B868A6188011208B2A945
      31A469463A44453F9D514A0D11A6E96DADF44C863613940DC8574597457F8116
      EF1B18447A964E5AF6D8C14431D3BD32D0D0E91A258853C877233DBD0B946664
      3ACD62813A2142A246D3879841A81222E0A4A55B23D310A5C053095D5BB8ECF5
      2BAE8BC0D09C93260920E8208D57EC33D42CBBA2B4C60531665A6428DD804E22
      DF15AA135EC7E540674B8737C8E6A90AB2CF433DF32C40908AD728D97168A839
      D03B6110998C6ED4B42C4A08BD38253A1111018E98769B649B88F60D1DDEA564
      11623D9517F903D1E5DDFEFA64F515ED6096DB01D4EFCB3F1DAF5F35678E65BB
      F62FCD41F66C2FEDD89E9F01131C479DDFCF7DE99A2FED269E3BE817E2363A73
      7B5D2F65C24BB37A698FEDFC2A509316CEEA79FFEDA599CC3103B910E6234402
      A74B3359C71AE35C5DE3F79771DB3F6EB77B49EFB547CAAFAF5FC98B52FDE666
      7377DFCB4B53EF7637F6A3E51C76676EE069AE140CD558F6DDB2D6121904B6D6
      42AB349CB2ADE8A58D08F25BD9F0B31450D3CA0888DC8E3396BF7B3903916554
      88827BCE45FFD04060F20A104460F041DB2C7D8E08B3ED1CC816C3EF94D8D1FB
      5BFE438E82609A0369A7C7C828D949F34318E7B4B343A71117F99DDDFD560B57
      78CBBF8A4A32CE79F4929ED5902506992FE33DFDAE2FA3875898ED957B7A0B35
      FA4453BC7BCEFA6EFBDC384EEFC7E9FD38BD1F373EC7B965CE2303ECCE3179E6
      790C33D83EA74F469D9EC99C8C312763ECC9187B32C69D8C712763FCC9183F8E
      6989B844B4DBAED3D3A3F177AC84EFED74C4D1738C030B3B4CCA9B926E1FEE1F
      3EDC94FBFFB8B9CFF70FD7EFD25F4CF0F2E066D3FF52D0144333FEAABCBBDEBE
      62FCF4CCF6C5E4C7FBE731FFB57DE3F6D3C3F777D79BBBEB870F3C8EF1AFCFA7
      DC7EE5FDD58185BA3A1CDF5C3D8F6DAE7E18BF26E1B3D9D17132FA6DD9BE4546
      7DF6FAD574DA5BABE749ABF9099C3FA5FEEC139FD07CEA13DA4FEFB4FBD473F4
      9FFA84E1D33BDD7EEA39C645277CB2BA26C5FEB218C153AB65209DDA2CC3E1D4
      C6AEB071AB3C5A0698A94D5861B36CD1A73671A1474FE83053783C6C7A96F923
      4FB06CC52F9CC07CBC13CBD070E104CB68E6C209FCC73BB10C34174EB00C4117
      4E504713DBC278F5875BB91756656A0D9BCDC3EDE661FBB995AAABA65BEC76F7
      10AFB5153A2C77552632514CD610C78E7CD773B97193B3F6697CA75CD5F41FC6
      8F946D86ABE1FAE7C7BB725FE948B9FD73B9D9BCDFDF0DB9EADA7BE3BBF2F078
      5737EF3D3EF69F745B0B92E713D4B93E7E646A7BA795AA4BBF4F3FAFB243D77E
      84C34FD6634AD439BA87487A7C782BB8BB2E75EBFC2EF5779B3A546E5255763C
      D97D777D5FEB9D985C7DF1787353EAA862B4FBA17E1947BB3A11349A2C2D8213
      A33A11349A2C2B7467A2B7C6A99DE52ADF76B62B5CDC59AEF074BBDE6B3CDD59
      AEF27467BBC2D39DA59B6F4ED5B4977D73FD7053472C5FDE6CE4C3CD957EFD74
      FDF36D92AFA8A85224D3737CB57DF7F6F879AD9FEFD2FBB757DF6C6EEB92F88B
      4DFE70F5A65625ECADD6499B7165E46B50AE6F1FEB623DB15C83C2BD6D5D4735
      B55DDAC49FB7AECBBAEF77DF6CFBEDB3303B0FE323783D760FD548FE29DD3C6E
      3541A5835FA587BA2B3D03E89BF17E523B187DFC292A31F18328826F7775B6CE
      E7E7EBD75DF2D9AE0E82C739B7FAB23BF35A22FE427EA8A78A6F3FC84D23AF6F
      7FA9B2FA6623F7D12D796A7D16F85A4F31FC20B73BD9F976DE604AF85FBF7BFF
      36DD5FD709BAA74F525D7D9FDE5719FE281F6CAC8FE2D7FFF44EBE38FEB968D4
      ADDDB76FBEFFEEEACDE6BD6858B94169DD0A8AF1179B8787CDBB55F6BB26F81F
      FEBD74FF587FE1CF51CEB71FDEAD71F8F3151DD968F8E575259D6DAD367985D5
      57FB2FE458E3E23F970FDD26DDE5FAEBFE48173526C7435961FD53920F80D7DB
      C947CCFF9B24ACDE2F18ADFF2DDD5D4B2BB6067E6FAA0D0F3AE4FBC7EE3F4B5F
      97B23F6CD634637FDC7E56772B19966D3C9E35AD2B0E13D3BAB2F466FB4D00D7
      8287EA0DF18971DD9427A66BA6FCE578DBA6A5BBBBE76DF52A7F9FAC3F66D675
      ADD0CE565EDE966FD65BE5F293F14A9F9FCC5739BDB9797C777BBF76DEA3ED1A
      743DD9D64AA5A9F5CAA51A6DEB7A85ADADDCD17155A846C375CB3B9AAE59DAD1
      704D8446C3D5E159FA5AC419D3BA17AE0E0CEB5EBDDA1AAE28030786EBD67275
      1158B1E17660B8662D47C3756B399AAE59CBD170CD5A9AAFAECAF8FD29EB88EC
      C07CDDBA1E9C601D09DF3E9477EF3777E9EEC30AF3AF6FCACFA9B2C5DF5AFE78
      B719E4FE817233C175FAE2B17B18C5C96AD335C5837667D525C56EDD028B65E5
      9E827C5DCDE6A01F9D79E5F399C55638F446DE4F77D6EEA029EECBDBCD8DDCC3
      F0CDF3CB33E7F7B98E45F64FEF53FFF42AC9D3203F6DF1BF1BEF17F8D3DBE797
      53F603D59981A36C9F8CD26746EDA3B11F6526A3BE2FF9FAF1DDD3557750D88F
      B597C63E2DFF7EB43B37FAA036EC07FAD9817A3A309C1B78A01CF603DBD98147
      678CB303CD646098AECD57E9EE97C346693F6CBA327BFD786E15833E3FF66421
      83393FF0742D2F00E8EAF3BE97AD1FB50C49CFC38F16750E5433E7BF8CAE19A3
      CB309B31BA80B6A9C55C3EFFA9FCF9FAFE7947E3FC2BF7F6C8FDFB83D7312EEC
      F64D61F62F8F9BDD56CDF98B4C97F10F54B0DBFB7260B5247166A27421836697
      FC4232CD5CE542569DB7984BAF99D197B36CC6E842BACDB97E29F3665C5F9082
      BA2E05F532569F19BE2C014FB87B590AEAEA14D4D5005E5E02662C16C0F7C4FD
      0500D65500D66B00ACAB01AC17178E59D71700D8D401D8D401D8AC01B0595341
      4C856299B9D002009B6A009B6A009B6AFE3DF6FD25009B350036D50036D50036
      D5FC6B8F97FD2500DB3A00DB3500B66B006CABF9F7C4F70500B6D500B6D500B6
      D500B655FC7BECF74200DB6A00DB6A00DB6A00BB3AFE75B51ADEAD01B05B0360
      570D6057CDBF27EE2F00B0AB06B0AB06B0AB02B05BC3BFC7AE2F01B0AB06B0AB
      06B0AF03B0AFE35F7FBCE0CB00ECD700D85703D85703F8C49F0500F6D500F6D5
      00F65500F66B007CECFA1200FB6A00FBF95E5C4DE3B0DB599DBCFBE67CC73FF5
      EFA987DF1B5EDA6350E72EF9A7C9DBC7CF1BEAB3D75C62390DD2179BCD2F156F
      29DD9F658ACB2FAEBB9BEBCDB833F2E1633E4A77BCABFBC72FF7EF7D3B1C664F
      7667E52D4BE35EEEB445B77A76E0B47DB26676E054745A3B3BF0587758373B74
      4AA3769A4E235C9F5ECA81F0A663FDDC58756E74981B7DE47E3B37EEC8FB3837
      EED87937EB931BF962725AA7E606FB7D164F0DF49C41386FF062D8CE6FF15C88
      DFDC3ED28550CE5C633EA6E70D5E0AED8CD58218CFF9B424DC33CE2D8DBBAE8D
      FB6200CFED7E2C88BB5E1577BD3AEEBA1AE4B3CE2D8DBBA98DBBA98DFB620699
      DBAE581A77B33AEE6675DCCD3AB49F948A97E36E6BE36E6BE36E57A1FD84F82B
      E26E57C7DDAE8BBBAB45FB7157B520EEAE36EE6E55DCDD6AB41FFB541377B72E
      EEBE36EEBE16EDC7DDC382B8FB5571F7ABE3EE57A3FDC4B969DCC78E68B1083C
      187DB1861E8CBB48E107E32E32C8C1B89D04BC481C07C39789C003836522F034
      6C8B44E061FC660CE60339AB1AE763BA48049E047791083C1BE319CB05C19E75
      6E69DC2F8AC073715F0CE0198397A37E2CAC96C6FDA208BC18F78B22F062DCF5
      3AB41FEBAD0571BF2802CFC57D3183CC48B285513F918E1571BF28022FC6FDA2
      089C8FBBAD45FB896A7C39EE1745E0B9B8D751F88C5545D44FE46345DC2F8AC0
      F9B85F1481E7E2EE6AD17EA21A5F8EFB4511381BF78B22F062DCDD6AB49F38B7
      34EE1745E0B9B85F1481E7E2EE6BD17E2CAC96C6FDA208BC18F78B22F062DCEB
      EE61F53D26F51FD9FBE99D7C4DDEBA4FC47E9BEEDF3EA4BA9B81FCEBED5DB9DF
      DCC8777C3E4DB87EBADFC94C7F1DBFB44DBEAFEDFE41BE35B551E3ED34E5D6A2
      7A77ABCFDD6D40AD7CF3D378D349A37571C62AD7BAD666B9F5B5775EC91727C8
      ED3A8D975B679E3DFCF6CCB9E907A54A9354A7542A6AFE06A2DBC39466BCBFEB
      508641BED0E4E0D69FD3431DFD7BF40BB11FF6B7B63D7DBC7FFE6F78BC7EF5B7
      3CFB6FFDF8DDFBBFDFE38CF779F76FF9DF9DC9FFC5F1FBDAFFFD1EBF7B7FF970
      280D3F6CFF04DB8CC2C3A2427CD93E0E3C11E24B2A61FD31DE4EDDCDD7FDA6F7
      29C7B68D7A50D92259BC63A6B689DEE8F10B31668ED4C89705B49D1B4AC82687
      46CD298EDFCA311B8195C7F91BD4FF968F4F1981FF7FDECBF1A922B0C2FB5DEF
      F174FCFAEBFF00AD957485}
  end
  object jbhSave: TJvBalloonHint
    DefaultBalloonPosition = bpRightDown
    DefaultHeader = 'Unsaved Changes'
    DefaultIcon = ikQuestion
    Options = [boUseDefaultIcon, boShowCloseBtn]
    OnBalloonClick = jbhSaveBalloonClick
    OnCloseBtnClick = jbhSaveCloseBtnClick
    Left = 53
    Top = 145
  end
  object tmrShutdown: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrShutdownTimer
    Left = 184
    Top = 520
  end
  object pmuBtnMenu: TPopupMenu
    OnPopup = pmuBtnMenuPopup
    Left = 976
    Top = 104
    object mniBtnShrinkButtons: TMenuItem
      Caption = 'Shrink Buttons'
      OnClick = mniBtnShrinkButtonsClick
    end
  end
end
