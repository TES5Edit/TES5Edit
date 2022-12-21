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
            OnKeyDown = lvReferencedByKeyDown
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
      789CECBD6973DB489628FA5D11FA0F08F57DD7D28C240320B8B9A7FB86ACA5CA
      AF6DCB6DC955735FA96202249324DA208002402D5D51FFFD9D253301508444DB
      129772F64C591405249027CFBEFE7E95E643E7CA1F8861E84723C7769B577E94
      05F44F3F19396ED3BD9AF6F98A61C369DAED2BFC645F6579361E0E7AFD317ED9
      E25FC3B8F2EB38A8FCDA0BF4FDF8AC86DD71D4E7A1A0DFF2B19808FD37FDDB50
      D8C52FFDCCFEFD6A184779DE0BE1837D05EB0E02EB6A98C6133FBA1AF6C77E9A
      891CBE4FD2DFDCDFAFFEE32AF1A3381396EDC2FFB5EC86DDB43DF8CF854FDE1F
      97C14464D67B71637DC4DBFFFA072CE9EA2527F140A4B36B3AD535DBB04E97D6
      C6353D58F3389EA6814871D5BFFEB1BD052B366A5ED2BDFF924DF83F3805F8AF
      0D2F8B8BB6FFB8B89BF4E290DECD29F61B05E1C30BDDFBDF1F3F07D16800FF65
      B456C3FB12D821CC1876084317F7E94F7A69E05BEFFC7CAC36DAD64B66374196
      3DBCE49040E6D2E26AC9308035E9F5BCC6179D430FDEAB5B5D2C8EB238F479B3
      8EDBF89257EBC9D3E4FF0057FEB810A358589FDEC89D8600B17FC5E915D1C433
      20E1A0575ADF79E2F56907E3A0F404F7CBCEAD31FFDCACB7C1689CD3FBF7CAAB
      D7E1FF37BD3F9C4010A9277C112A2F7C02C5FACD673A81E209ADA7A39C5E79DD
      F6D343A6D1A80387DBE8F0B2D6CC7DD6F1A962118D56DDCD788AF36FBE4BE583
      3B35F73A2DA7E6DE1F52213ECBBBBBB577BB35775F4EE593BD3A1A77DAED9A7B
      777F14BD54DCECA98D7B7564ECB4EBA0B67B94FABDA0BF27DFC1AD5BA0D3AA59
      E0B51FE6415FDE5E47864EAB51F7FC9F0291473E7C29E43B349B755C599DBD63
      950460E9DC9BADDA3BE5C1CFDCA90EBDD9A9BB519D7AF5C6D28937BBF5B7BA73
      6ED5C7DDB26B6F94E75DBD71F6AC5B4EFDFDF3C0543DE856AD0AA24EBA7A77F9
      945BB562531DF3CC93678FB8D57E9CBACBA2BF38E256FB71D2AEDE298FB8D57E
      9CAE2B371647DC6A3F4ED4955BD511B73A8F5353E5460564DE6AE77162AADC7D
      0FCCED924CA972FC329859AC2284E9963A215186AFBC4582B66D776AEE298396
      EF9150A50DB6ED6EED7DEECC7D0AA4ED92763A738F6692EA9E8260E846A7F6C6
      59585428A5EDD4292EE543E41B2BE7D776EAD4C1F2F9C927DE3BBAD6424C90B5
      4F7D78AD85F89FBA491D5F6B21E627EFAA1C606B21DE27EFD447D85E88F5C8BB
      4A7CA7DD5E88EFC81BEF81D469B61E2707A582171C076E7B9C248ADB2450E1AE
      C78942DF55F01AB8EF71A2D0F729903ACDF6E364A1EF9A112470F3E3A451DC5C
      A60DB8F571E2D0B7968E126E7C9C388A67CE1E65C532AAE3EB0B288A9575EA98
      FCE33A637919A756035B407DAC2C542B3B1ED624EF6DCCA915230BA895B36BD5
      19410BEA9795B5EA7480C755CDFB7BACD30ABE40EF2C9BC3CED721D5EC2A5F89
      52B4BDF242EEB7205565A1AF44AAD965BE05A5EEEFEE1B91AAB2D6D723D5EC4A
      DF8A52F73C206E9D44B8AF8D919343A154658D3AE9705F3D936B481E555EA451
      CBEFEFE96BBC4859E85716AAE5FEF714385E48215365915A49704FA3E3452ADC
      A9B292F7A81C9B5949A3D1FDADD5E90AF7B53E5EAB84469575EA9487FB4AA07C
      A759BE547673D53A271610769575BE5ED89597A977372CC0972A0B7D8BB0AB2C
      F48DC2AEB2D637F2A5CA5ADF28EC2A6B3D81B02B7B36BDAF16769555BE45D895
      176A7EA306552CF4F5C2AEB2CC370BBBCA6ADFAE41156B7D93B0ABACF424C2AE
      ECCE6E7E8B0655ACF2F57CAABC4CEBAB51EADEBE5A5F8F549565BE914F55D6FA
      1694BABFC16FD5A08A959E804F95E317B516F57C6FD6BDF847AD655DEFDA2ADF
      5E6F25D779B96617585C5B2A845B6581C535A5591DA95863711DA9C2772A6B2C
      AE1B558458658DC5F5A2791A51B1CE57F399CA2ADF22BCCA0B75BE51232A16FA
      7A3E5359E69B855765B56FD7888AB5BE89CF5456FA563E431BEDC7619CE6BDF0
      AF57A918D857233895C8BEEA855361DFFFCA6D36CB5FC2AF0F7DCD0BE06F7396
      98F97AE6DA9A256A1EC84B386EA7FC25FCFAD0D7F65FB7B7F06BFC7DCE22335F
      DBD52F8B45E67EAD17E9BAF20FF081FED0751782B38D87FD1F98C2D31F27968E
      6267AE7BA57378387DC7B1C18EE48F5182BF58EACEC44F2CD8E26FA1751506F6
      550AFF65BED3827F4317F48B2C9C4CC3DCB9BA0906FD3C4CFCF4EA26F513B8CF
      87AFAFFC2CF1C364ECE387683AB91AFAFE348FAFFCC1BFA6599EA2C1060BC2CB
      86F84F90FB896DFD7115C5BF01DAC5933817D6EF57597E178A6C2C44FEFBF25E
      E22ACDC3FE1828217370F3BE8CD3FB043A5FE561C1CBE4295F663F0EDDFE280D
      06F4459494FE26C17D9545E2368765B2DF86713AF173F894A4419C06F99D6DBD
      C7AF30BF085E2673AA70E839364103FFEDE1CE1CF88D7F7E113CE2690E1010A1
      B816A1BD3074AEFC1E80C546D0802154039ADE15FD75062AF4F1B348A300BE6E
      D5C3077FC15380DD65621047B604163C3C83B7FAEC34E742AD6B21EEA45900F4
      D36AB71CDB1A0B1F73AB2C07C922739F1F8CCED7801140518011B63D0B48F8FB
      3C403E0CBE7BC07315F05A5F083C576261E3F9C1E77E0DF8DCF64358087FFD72
      E0CDC1BD86025FFB0BC1D760960C2F0D4BF983419007D702AECEC42418078381
      88E09769041FC5149E585AD3B14E1874D6073FF54700CAB175164794CCF51FF0
      8A79E638F04F1ADF0CAEF27498673F07837CFCBA01BF24F0A0D0B13BF2635A7C
      1C86EAEFC35C7FEAE94F297EEAF7121F982B7C18F2871EEC1C040DFFCCEF1201
      5765D722CD41C1804FBD7490AA9FA1FCD9933F53F973300AF527F5DD58FEBCB6
      1E63F4B0DB6761F5CB63F48EF3C09933B7B72EFD5E2834BA344BE8822A470D0B
      BE87F276C17BEDF98C773EA340FC6414C79F71FF730519EF23F88F8AB95AC7A0
      3EEAD76E95B1BC8EE1555E1A36275F5BBE5BE5B51F7959F7CB5ED6ADBE6CFBF1
      9775DB73212CF94AFDAB9678887ED9C697BD6C43BF6CE6749E87FB7E01A13034
      BC1A2281EDD25F9F4052399D8A2A340B9D4916474A3BE253ECD69EE2D0AE1EDE
      34BCEA0FDD1934AAE7C433C7028C2FC563540F76ED074874EEA39DAF7DF6591C
      86F18D18DC7F07A776F3C1FD9708661E7F5F90B9F7017E3A01BCC9824C3FD27D
      68DB2EA1C9CC7331819FBEFC3AC05FBE7B6B1DC703C16ADC3329225F641E3C4C
      0C4F460A6EE30BC024A5C8EECFA2B7C790F22A90D2D040DDE1B6EBB4E05FA7D3
      70E187DB068991DF365A2D0F7E78CD0E08FBDBA6D7C54B5A9E8397B41B2E5ED2
      713D8FEFC64B00E86D5AC6EE76F122C7E9A2A6710B86AC8B97398DB647D779AD
      66EB89F99144B407F81123DD939C83A7C44DF34BF1F6432A98C87231D014D4AC
      E7580FD1CF57881C7E7325732A6FFEC8CB5624A55B2FD667794CE515EAD97812
      1E144CAC5E0ECFAC3EBBC507D7EFEBF53B0FCBF91909FF389374EF3DEE224FE3
      68F4D73FE8896190E5392A73BFD347FE5D4C92D0CF453038E878AEDD4642E23F
      93E97345FF46C33EB037F531529FFFD5B7D12EE48F4814F869482241FE92E53E
      68E3A0ABF36F89DF17F22FA0B18B28B77FE7DF7240E6AB17B673353D68749D86
      F57F1044FCBCE9A4275260F2541B85C836EC053E215F7080C9D761D0862FFFD5
      979B4396E0127DC20F741E2DBC950537720D2F1BC1473833B5F9C7F715CFDB8F
      5BB31FC7F3AA1BA22F6065FCF9CC5B5A6443B06D75546E77FE513976CDDE5C64
      D0E5BDD117F010FCB9067B7B6467C8BEEBF7D6E9CCEC0DBFC0BDC1CFF5DFDB03
      3B837F91D2CB7BC3AF706FF873A3F7E63566D8077D018FC09F16C51436766F58
      9E55D91B7D018FC09F8B9C5AC1DED76F6FED194E425FE0DEDA4FC34934775FFE
      DE5ADE0C27A12FE011F853ED0DE35E162C839F8381EBD92DA7DBB4FF982FDBBD
      36BC45D369748C6C37B2DDC87623DB8D6C37B27D7DF766647B59B637DBED66A3
      D3AE91EDAEDD683B20109B46B61BD96E64BB91ED46B61BD96E64FB86C8F6B663
      83E4EE34E6CB76901CDD56DBB3BD9691ED46B61BD96E64BB91ED46B6AFEFDE8C
      6C2FCBF64EB3D374BD8657E39377DC66ABED782D7701C3FDCB0FFD4F22DC8D3C
      37F2DCC87323CFD7766F469E7F3FF2BCDDEA765AAD1A5BDD751AED86DD6876E7
      DAEA7601160D8C27B6D45DF8CF3E9C0502420876F0606EE4574BF6B9BB5A58AE
      7FF959E3169D6FDBE25748FEAFDF65ED1ED5C9D7EED2FDB65D7E850EF00CBB7C
      50BBC15D36BE71975FAE0D2C7197728FDEBD3DB272B7F02E490DF832BD60F9BB
      6C2E7A923395A48BEA08EBB1CBD6B7E12BAA04333ADEE3DAC2F277D9FEC65D3E
      AC35CCD7F696BFCBCEB7ED7271FD617B4B6B104EABD1E8B66DB7355F85E876BC
      3698E35F12C87F4A05E2E9BD016BA2D9AFC835B0B07AB734A577C9AE81AF53F2
      BE766F6BE21A7850B5FB06E7C03ABB06BEC55DF515827F9D5C030FBAABBED939
      B0DABD3DE21A9855659ED839B0B2BD3D22DA9550AB3A0740B483ECF6DC664D24
      BFD16AB6BB5EAB6B6F9A709F39E5A545F2572CDC151BDF1CB47D3AE1BE868ACB
      7285FB5215977511EECFA1B8ACBB70FF16C565C385FBC38ACB737BFE572ADC67
      44DAE39E7FA7E5359D66B7E3D684F21B1DD76BB5BB5F9482BF2AE18EE7BE9A34
      3D23CF8D3C37F2DCC87323CF8D3C5FB13CEF765DAFEB75DB35C67AABED363DA7
      6D7F49DAFDF727CF576CACAF49706145C27D8DD3869E5DB8AF306D6895C27DF1
      5C5823DC8D70FF6E85BB6BBB6DA7E3D5D5D41D749B6DA7EDB91D23DC8D7037C2
      DD087723DCD7818118E16E84FB22C21D28B1D5B2DB754575AD4EC3B13B4ECB35
      C2DD087723DC8D7037C27D0D188811EE46B82F20DC1B9D86DB6CDBAD6E4D859D
      ED018F754C98DD087723DC8D7037C2DD087723DC3748B8B7BD66C7ED383596BB
      D37180C936EDB691EE46BA1BE96EA4BB91EEEBC0408C7437D27D21E9DEEDB63C
      AF5D2BDD1BCD66CB6B34BBC6316FA4BB91EE46BA1BE9BE0E0CC4487723DD1790
      EE5ECB6E396DAF5B23DD1DDB01C9DA69B74D4A9D11EE46B81BE16E84FB3A3010
      23DC8D705F44B8B75B6EABE5766AE6CB396EC3EE808437F9F246B81BE16E84BB
      11EE6BC1408C7037C27D91D9B14D10ED6DAF53D371F6C069343CBBD1EE744CD4
      DD487723DD8D7437D27D1D188891EE46BA2F22DD5B6DCFB5DB4E4DD3D903C7E9
      76BBEDB649A933C2DD087723DC8D705F0B066284BB11EE0B08F716486EAC75EF
      CC17EE4DB7D96C0097356E7923DB8D6C37B2DDC8F675602046B61BD9BE806C6F
      3B5DF89BD7A891ED07ED56A7D9EDBA4D932D6F84BB11EE46B81BE1BE0E0CC408
      7723DC1711EE1DAFE53A5DB7A6BBFC41D76B386EBBE919D9FECD5B31C362CCB0
      98A7C63D332CC6887323CE8D3857E2BC63DB9ED3729B35F9F14DC76B345DBB6B
      FCF04F7CC4C65437A6BA31D58DA96E64BB91EDCF28DB9B9EED746B3ACE1EB876
      ABE5353B4DCF18EB46BA1BE96EA4BB91EEEBC0408C7437D27D21E98E5D69EAC7
      BC7A5E072C77DB36E9F146B81BE16E84BB11EEEBC0408C7037C27D11E1DE745B
      203BEB52E81A1DD76980ED6E0C7723DB8D6C37B2DDC8F675602046B61BD9BE88
      6C6F75EDB6D7F16AA6BCB69AAEE3B89E296B37B2DDC87623DB8D6C5F0B066264
      BB91ED0BC8F66EB30586B9DBA8E948E7B4DDB6D3B19DA6C9A733C2DD087723DC
      8D705F07066284BB11EE8B08F76EDB03D16DD708771773E541FC9B09EE46B81B
      E16E84BB11EE6BC1408C7037C27D01E1EED84EABE135BD568D5BBEE178ED9667
      3BA6698D11EE46B81BE16E84FB3A301023DC8D705F48B8BB5EB3DBEC74EA4AE1
      DA9D86EB799DB649A833D2DD487723DD8D745F070662A4BB91EE0B497790ECAE
      07E75A23DD1DCF6937DA380CCE887723DE8D7837E2DD88F735602046BC1BF1BE
      90786FB59B8DB6EB393549755E0BFEBFD9F04CDCDD487723DD8D7437D27D1D18
      8891EE46BA2F24DDDBCD56CBEE7A35A5EE8EDB69B45BED4EC3487723DD8D7437
      D2DD48F775602046BA1BE9BE8874771CAF6B379A5EA32667DEEEE214D8AE6D02
      EF46BA1BE96EA4BB91EEEBC0408C7437D27D11E9EE7AED2E486FB7591778EFD8
      9DAEED765C137837E2DD887723DE8D785F070662C4BB11EF0B89F766BBD3F0EC
      BAE17007AEEDB8DD6EB7655CF346BA1BE96EA4BB91EEEBC0408C7437D27D21E9
      DE69B86DB7595B13E73AAEDDEC385D93356FC4BB11EF46BC1BF1BE160CC48877
      23DE1711EF0DCFED62E25C4D5EDD81E3345B5DC76B3BC67A37E2DD887723DE8D
      785F070662C4BB11EF0B89F756B7E5353AEDDAD0BBEB7A9EDBECBA26B3CE8877
      23DE8D7837E27D1D188811EF46BC2F22DE41B4375DD7A91B00EB3876CB6D361A
      46BA1BE96EA4BB91EE46BAAF050331D2DD48F785A47BDB6B7920DEEB3ADAB84E
      B3D3025664C6C419E96EA4BB91EE46BAAF030331D2DD48F785A47BD76DB53DBB
      539336EFB43DB765B79B1D63BB1BE96EA4BB91EE46BAAF030331D2DD48F745A4
      7BD369B5BBED76ABCE7647E3DE6E771C93356FA4BB91EE46BA1BE9BE0E0CC448
      7723DD1791EEAD26C8F686E3D696BC3B9EDB761D3307D6887723DE8D7837E2DD
      887723DE3748BCB76CB7E135EB1BD681FCEF7860E39BA23823DE8D7837E2DD88
      F775602046BC1BF1BE88786FBBDDB6D3F5DCBAAC79AFED62495CD318EF46BA1B
      E96EA4BB91EEEBC0408C7437D27D21E9DEEAD88D8E5D67BC7B9E03ABBB5D9334
      6F84BB11EE46B81BE1BE0E0CC4087723DC1711EEF09C66A36D37EABAD13AED86
      DBF69AB66DF2EA8C7837E2DD887723DED7818118F16EC4FB42E2BDE5755DC771
      DD1ACF7CB3E33AB6E7997E3646BA1BE96EA4BB91EE6BC1408C7437D27D31E9DE
      F4BAAD46B7B6D73C48F796DB80AB8C7837E2DD887723DE8D785F030662C4BB11
      EF0B89F776A7E5D820BE6BC47BB7DB849B5B6D93346FA4BB91EE46BA1BE9BE0E
      0CC4487723DD1792EE5DBBDBE8789DBA863600968E67374CCEFCB76FE529E579
      690F8AD36D0EA67EB33CD73B2B04FBDAECEDB9E57975670880EF429E9777A64E
      DDC87323CF8D3CAFC873D7765A4EBBEBD6B59F3D701B1DB761B73B2691EE890F
      D958EBC65A37D6BAB1D68D7437D2FDD9A4BBE3369AAEE7746AF3E4BB2D10FF1D
      BB6B42ED46BC1BF16EC4BB11EFEBC0408C7837E27D21F1DEE8DACD4EB75527DE
      1B188A775A4D63BC1BE96EA4BB91EE46BAAF030331D2DD48F705A57BB7D904DB
      FC0FF8FB7FD0B7F1B548D36020608D50FC5EF94ADDE5D92DA7DBB42B7FEBC753
      D8CA5598A9A8FDCC4D4EC373BBED56BBD3997F9B3BFF36AF05CF6A7B5D67FE5D
      0D2DDA66EE6B741A6EB36DB7BAF3EFF3E63FADD96A7BAEDD769AF3EF6AD66C4D
      77F99B7F5BABE661CD56CB6D7B9DD6FCBBDA350F6B35DA0D78561359DCBCFB3A
      752FA99A15CDBFAD3BFFB64ED36D8176D5A8D99A63D7BDA51A5B50735F0D9634
      DBED66A3D3AEBBCBAD3BEE8EEDC06D5EB75D7363A3E635ED361C02A07FDDF66A
      F0040EA1D16DDB6ECDD13935885244C26AEEABC194B663830EDE69D41DB95387
      2BF0BC86D7F45A5ECD7D75B8824F032AF7EADEB30E595A5D1B10DAAB799C5B83
      2CAEEDB69D8ED769D4DCE6D49DBAD368755B1E1C7C0D4EBB354CC5E9765DAF5B
      8B2D6E1DB6E8AAA29AFB6AB0A57091D6DC57C7575C60626D17ACAFBA83776B10
      A605C4670362D7BD680DBE749B2D00A9DBA8416BB7065D5CD0E7E061EDBA63AF
      C196A2F7790D6FB76BCF5D6788D5DC59C35D0A7157735F1DBE388ED7B51B4DAF
      06431B3508832CA9D9716B5FB38EBB004A375D78D94EDDB9376A31A6D9EE343C
      BB4E36376AF0C569794DA7D9EDB835B7D5E14BB7ED394D90D035B7D5B1175D7B
      5F735FB7F6E0F5ACBB1AB15EC361BC76CB05615BC777BD1A7C6977BC96EB74DD
      1A3EE1D5A18BD706960B0758F79635E8D269B7BA9D56AB96CD7B75F8A25B15D5
      DC57832D1DDBF69C965B872C5E1DB2E8EA8B9AFB6AA591EB35BB2059EA5EB353
      77EC8513AAE6CE3A0EE37AED2E88F73A0ED3AC4117004CD3B381CBD4DC56832E
      9D2690ADD7A8612ECD5A6C51D399EBCEBD59832FA873766CAF4E376BD6A04BA3
      D30502F4DA35D8D9ACE32D760B74B336C8B19AFB5A6C43A4E23AEF85D6EF9FA2
      CF517C13FD95BF4D46097D8B1FAE02F8C7BE0A723F41D4B3AF52F82FEBC17F3E
      1E88BA0213091FBDE6CF7B05EC7EF15518F259304020D30760B2C0266DFA0C9F
      1A0E31F1C9C4CFC71F52FE7916473960EBA4977E7E1D801D2B3F5C4C61D14936
      F1C3F02CF5C1D29D0C822C391143E76A12BEF3D3115D9BEA4F0331FC7FFBF0B7
      9BD44FDE90454BCEC74910E56F83097C88FCF40E3E21D504D130FEFDCA9FE6E3
      38B52EE19F0CCC63EB341A852225EA8F1391FAF99C3FFE7ED54F05D8D193ABBB
      141446785E0CFC7570075B1CC317F838D28610FD1EBC087905E06E16C411BE91
      18C097195258140F137F24B296CDBFDCC4E900547297D41EF8BD3FF6D30C7889
      DD2CFD7E032650A7498A3B2C1A81264047713B09A38C119E3E3AD638CF93572F
      5F66FDB198F8D9E124E8A771160FF3C37E3C79190F87415FBCDCDEC267BE746D
      BBF1123F4DC23FFEB84A7C00C98DE37441CCD2E7B1D3EA00CD4F00FE21431A3E
      A5FA53AE3FF5E8D3689AE7220594C9D34CF4737482DF0483F8A69FA7E1D5308F
      7AFFBAF2453418C4FDAB1C8EFBF304283BB3F9F3304E0151F2201A0114E328CE
      C5A42706D95D3604D47100D6E15D1C5D4F42BBF4D710AE1EF8B90F4F4E87B0AA
      B8068C8005AFFD3080EF05C0C3B9CAC6F14D12FA7D318EC3013A3E801D8CA238
      1593E0560CFAB03A3A4600B5AF4510D19DB7F814BC0D3E00E701E470E0106E43
      78BDF84E44B02B719B64E3348FE0EB296C36CC92FED520824388B2DEA007DF92
      EB05B634857DC3C6B2B10FCC0DD0ECDFB8F7C16842080D1FC674A103DAC26074
      5DFA0C97062376A9E35F2ABF8DF1D51CBA013FA02706DEC78F0657D781B8F91C
      4403873E657D3F14681627A35E3A48C7C21FC88FC338CEAFB224BCCB6FA22012
      7834FAF3389F00CD64096C228CC6B93FF8176CEB6A9A8930EFF9617405FFC117
      F0902BB8059ED087DF6EE817F890E6A3F42A8C80B861E70296804F3729B2E3AB
      2CF2933C1E011F0FA2BE084358288C6F868108818C07B0FC155C984CA33E3A14
      FD2CF0F52AC856527863C5662271030B66F91DFC3583678CD2F8065E391E0639
      BE6784F0CEEF00EC283BE0EFF0AE11F09B3CBB1A0A7C37118A6BF8BA7F9B25E4
      78024E318023BCC1EF051EA93FEC0345E14BFB43BA780A68195E8DE90A845B0E
      ECD14FE1CABC7FED13A8727859BC6998223CF08B6B3FBFEDDD5E7D4EA324CD22
      915FF57DA047C0B710C06821E204408E899F5BF05AB98D0CE93FAE6E008F8793
      7C1884404716E830F61F48FEC08CA6A9C8C7699CE770A45741388C277EDFCFFB
      61344D9A2D24387821EB0AA96E6029FA03D61D895BE04770F222BD6B838D8627
      2F3FC29B64B7F801C01F8D452AE86EBC050F093D7DB49A18FA80E27D38402260
      8B246C047F0AAF81B89268DA4F27F805BA21F177763462882B89C67E3442391C
      E5B7B96F1D4AF12C6F76E19CF17678D9AFBABF019F4027F8AA7B3DF8142EFEE4
      BDEADDCDC59FDCB376FFA85BA6450058F8351E5AAA4D0B2D76100FADD379AA17
      EA2EF24288F3735702E19302AF0AFD20B2246E5FFD064453A8228E8D1C9BFEED
      21ED039BF7F927081CC062BC03950489BEC050123F4CC63E7E88A693AB215D7D
      154F09E1C9F36D5F01AF9B6639B0DA710E8F89C8A1AD744758D02FE93AA0F8E4
      617F7C35EC83BC0536D1709A761B7E666068FA216C0E2C9026BD3B5FC40161BC
      AA754517E1350D1BCD75F8301460E334AEFA4878F4459494FE1625F857807AE5
      913D789A8D4FF43A95E75CF5AE868E8BC168AF73055B1FCF3E8A3E7E06050284
      27BA5FE433E86B504FCA0A1DAA1DE54DFF3CF6F31799050CD88293B93D1D04B9
      E51DDA87DEFF41540606C427B7BC3373BEE8CCEA20D868CD9E94862100A81686
      5F02B9D7D3D110D48D4CC289AD1E8AC214A8AEB97815B5ECEAF1AA3C836F7DA3
      AB3086350173AF063DFA007222C0A734ACAB17BDF61588C63FE61C6725A961E1
      739D8916E1BD0B9C7498CD3F5FBC7DA113E6E375BD1908F2D1BADE37C3707BEB
      2FED76DB3AB07EB9F87C970613EBE2F4E5DBD35FE10B69915AEFFC04FE4B81DC
      ACCBF747EF2CD02FA7C26A76370B0FFED2EE74605367602B9D83EE770DF68C75
      1C2777969F59CA38CFACA11F84F02F5CF4EE87D3B34DDB61D7C51D8641928881
      85A20AA815B91C1AA4A17F67C543AB070B7DCE2CD0B4AD6CDA3BE05F376C9F1D
      BB01FBF487A85FF643E1A314D8B7B2782288AD8329180EC80E81934CE38975F2
      F6787B2BB3260001506AAD30F607563E16416A6162560CE47767A5A28FF6AB05
      FFA6A842DE6D1A4C9C468964C924C193BFE8A741925B67A93F9AA05D69A1076A
      00D8D1BBB38EC9410064F00F108164230268469BB66F17F77D76DE78651D457D
      3039FD913814D9C4FADFD687185D2A71FC19A42D7D1509D8387232EB5D3C0800
      4603CB4F92107F0EA6C09847D63F8F0053360D021EF2B58F127F6F827C6CC132
      033E66607793372799855636723AA40F85EAF0F01CAC2AE40A9A01BE0CA27F01
      FA8BC1E681A14988F0FE27F8573105C076D8DF248EC41D507F86FC42A47E2690
      1724D64800C7C8D38DA3F46613B67854E17ED620EC47D3CF3EB13EC4F57D2B00
      DE46CCFF3D7C7F70895C6182423C07F91D05D978D376DDB261D7791C87799058
      7E78E3DF6528D7808005A84F521AF816986E7134D8B8CD3113F35E5927AC4E9E
      F7900C2DF2BB59BB2767E7AFF79086A7C0D515AD5AD7816FA1F912A76F4E366D
      C36D07A555820E4E56B72E30E9AB0F1A5918C2C6412A65D62F00905F376E6348
      9C97A7179E362C1BA474A0930ED017F40B5039DFF923D8EBE97088672C39F7A6
      6DB4D3828D1E03371DA32E0144370CD209B2227F4022E58F193B26A83165306A
      F584E64C14CF3EF8B90D28295936EEFC909FBE0B22A0BD248D013B27AC3B0CE2
      29A22A58BAFDCF245958339AC483297C9D09499E9BB6DDAE5798B8BF5A170298
      A81F5A1F8F8E4FD10E522A919F0AA256929403549852F1DB3448C5A64994AEDD
      85FDB2774BCA0D79B07E1267791A2763360D4722C208226CF6EDF9F9A5C465DC
      A305E602D8459800BB69BCA9EBB86526DC472605BBBD198BC8823D213A032726
      33F0BD180342A0C6B4717B4484FE88FE188DBFC876DFBC3F3B274327C33DF640
      E6A095C7B8DC07D5172838CA0299F3BF591B468173F2513933C8C3A1AD7544E5
      A37402CC0C3D1BFCE96830403502B58BB3C6CBF73F6DD686B7B760CB5DE9B1FA
      787AF671DF7A1B44C8953EC6312885C798485239E929A95303C273E46FE8E3A8
      DE83ECAD8F618BCDE3672E9E3E6984D65B245C4077D86190C1C6919E391ABE71
      BBF270573F88FCBDB8614BDD8A2340660A2B67960D07369AA2DF867957A0CEFB
      CD4DEF2C405E9ED119075132CD376EEB6D79A02FCFDAAD5FADF71F8EFFE7EA6A
      7BEBE8CDC9259AB76FAC133FF74BBCCDD3CEADDE1D1A0D44FA5902C61EA2FFCE
      FBD8BA00A059470968337E7FBCB371F0405AFF0585D6AFDA414D5E2B74DD6478
      D4028499246F6B9A21D6FFF4CF8B63D4CC368E9793AFE63298082BF1B30C3795
      C6B09F21B920E1433A8DC8AD9191FB72E3F48F269EE53FA7A0415B4753C0CE63
      74D3283D0C36D9170722228B70E7A3C00422EBFCECE292307EE3F0B6857AC8C5
      DB1FDE91E43D7B7BFE1174E6A19435F12409452E80A55152121D70E2035830E3
      69E3768AA6FD0F5810267D8918E09BA0DB02F83546100EC0F4454DAB70CDC92B
      D18CA03C3164E1BB44C0510C96AFFA6B2886F9DEA681A38D4A36B26DEBC50F02
      4E7B607D4AAC9F05D81751F6423BAB509C91F3D921BEBD719B6CB0807E93816C
      46CF62401113B2947FF4FF8D91652DA3033CE6244EA5B60DA74F41958DDB3212
      F4EDFB9F2E4E41B1C02C05A0DD34206E3510FDD04F7D76CF017103424F13124D
      143D0AE48E41C714E43CD8ACADEFEAD383133E0932543BF600162085430B5E1E
      0D27747C64604A472F72E584267E4ED62479BF32EBF4E26D11469456276869D2
      830258821E06BC6818FAA38D53C5B7B7EAE0249597D31320159405A717C7A715
      1B8DEFB3764E6F138A31814EC7BA5C6F8AAEEE29DC63EF30C09402B0738CA844
      72E394B25877F0A19B179BAF83D96934404714D01AAA7156B0BD55825722520E
      00885BBF9F97E375B0B93CF043102F797F8C7022A0291C3CEC65BED4A57C1448
      8C791BA645D5E3D9DBB286C809F0C490C2E0B3B038ED542638B0F668F57D2457
      B090FD1EADB75980A80303285E3D5027646E3EF024C19C05ECFB01F019625845
      08D84A7DE4C7682C62A06953F31CEAB122F3AF89FF22060812D0317015F676A0
      B02217285C8E223B49059857D30C68ECB7A998C25A9839CFAEA27CECE7B4C63E
      F0AB6C1AE6E45E8848630582CAFE3464A4259672FA8A2C63E0F9608309A41A76
      9D4A37723044ED156B0D60A3A8EA0C452A224CB2010BA7C8384837319CB5CBD2
      A777072ACEB50891A92088DE63C208EC8E45FC9B08A014F9214103518562F017
      42915CAA366D32486B8E82C34D9226370B43569E46EAAE7D1A69C74597DE11FA
      2EAD8B8B532213201E38F46012FC5BA8486292C6C034B28D330FFED2B5316961
      E75334C6EC0BB0F90F0F0F411D4DC8220409D18FC3E924220E097BB1C0269C6E
      DC0ED1A63FE71DC1D1B157DD7AF7E3C92545F8C3A09F671507A448EFA4A3EB02
      8DFC637DD1EE3413D61FBF0300AADB73090D6737E93DD12E0FDED01BFF8C6950
      F8D64BCF05402A9C08100B7B46163C0C2A69F95817600BA22973CAAE952582ED
      1B00F5FCDCF44D149085974D13329AC9029E0F32503F300C064449FEC7430942
      D6DA508B03CB073435C04B5266EED1C4F392A4B670F1750EC5AD588826A92BD9
      935125C08E2AB830D0809EBB2583E040300CB255EC1D704333A543C3941E8616
      89324454C386980DBDBE63CA4161CF0C8508C85F3A09FD86278311D05758E781
      66EAA1C89215D09326A67D0E6E687F81B58B3EA7008B0B55D2980AFFEC01D4C2
      10F970C06C1D8322944947592CE41E7EC7EEE10B9560477E1B45B06F28BA90C4
      A036CB3C524AD19AA07B2209C9EB25B27D4B1C8E0E57783203FF261A4D816028
      6E3D48FD511CF5E294C2D8CB3F2905BBCB715062814A20F6E3490FD8D38A0402
      123EFA5F5680BFBB9910000030D2F656250EBEAC4A79C19AE1B238585ED570C3
      540D9BAAE1E770F734D6DBDDF39716E52B7DC4B703E61AA9C08BD59B6E985B67
      7BEB2FADA6A7930B67E38DAF64D452C5B8C9F9E1C3972394D12FAD980B75481C
      A31D76717CFE9652A7834D437902041EEACFB845EAEB42FE3AE9D0DFB708150F
      7461002821A7D4B2075D7EE8D51B4C3118E02B07D814E393229AB286843E5FCE
      562CDD34C4563900473F0CF20D0B44FDA5D542581D9FBE7D6BC1F6EC7D9BEA8B
      41B3C892692A834B9C0F04802A97244B37A82ADD3BDCB47DB76D4D2C27FEC41F
      613A149633092A67CAAC4990853E28186250646F6EDC1E9121BCE14E5AD69BCB
      77993A5C1D4B032D20A514372A2725AE80B17A158EC5DA4480C7A625FFC0A598
      EF348E33DCE3E9C5070EA4836D324AE369B2611C0DB683A5D1477D8C37FC14C4
      2197BBDF8CD15A93852F448AD26B8DA66E3ECDAA67BB595B4626DE757466F539
      A65663970BDC26F12A0A630711F0241929A730AF8FDE7A789741D6F713348E42
      D8AD0C0210D6CB7CD5814E44E7FCBEE8C5A6E59DB7A8100CDB0AA2B9CD817FEE
      12C19FFC209CCA2230CED9A4B03930B20C6C7ACCF2CBA6844E9B8618B071AA4C
      BD4B62C46FCCD3FCFBC9FBA3777F3F8A8209D305FC4DBCB25EFBD4BFB46F1DFC
      1D3FF32F9BB6D70E15808D31BD1CACFB1EBC5D1FCBA65901013E7D43899B18F1
      C764E4DE34CF91650743FAFB4D100DE21B74B8E4716C5163CF8DEB86D0EA52B5
      1497FCBDC533C45CA9A1B57322B02F2850FBE96FD320A11CFC1D85109859170F
      645DF2C66D1883CFC77E44C5D649821E3699FEC5A1CAE3102B0D408DBDB8CB3E
      E541889FF2943E617CE0673A74B8380A36AEDEA06DA398DB392E679CEF68E59A
      32C330018EF91906AE755A3AB92E53305D80FF6FDAA61DDCB44FCCD8BA2E0977
      904FD82595DB7F60F5C1A66DCC45059B0B62B8CA8D2A18B1D21339D65BFC0004
      FBEED3C5E5C6EDCC916CF9DDE5FB77459322AAC296655EC0756FD220C74EC6E4
      999D4691C023C61E4D80B29320629DCD96E5041B0702B41ADF9E9FFC80363690
      2B2A1CBCD372421D5BCC40ACEF3F81CE06C73F8D5291C5E135A5E1BF46FE2D3B
      FB6C1E041A5437226EACE37F58C0B130EF92362411007721B85288C97740D5AF
      C0AE65490932F89E2895E8CB2A8BCD8203B6DD6B60710965C3913F8555938915
      508A37E086ECF432C07C78068E62E55CEA4BB78441041A8CC86F3001807B2CFB
      21710ADD28661A8194C36C568CE46D16980048A8AF93EBC9CA7033AC9D51908D
      6BDE75EF3EAECA18C67D30E14012F4A72990535E0EB54DE24DF344B41B945337
      E905A3699053993BF7B00000FC132400D0C890628A1BD791A3EDD5EFECC311F0
      860DDE196A26C78AAE8FA4C09ED99D4AD72F91F2315E99802D9A6C189522336B
      A2D6A2F997244AD82DFCA692F0D9F1823BD57C8AFB6D62F2248A00B89667F7C1
      7DB24F017A20B092EE56DA30C18651705DF6BDEEDC76520993934E30F13F8390
      8FB1AD59144707FE689462C2ECA6B5ECA82F3DE0B202EC4D77F4D33BD59725F0
      7172852506232A9293C5715CF83E6239B74F956288408C26569663D707954241
      D7B156C9253F611C7FA60A45597E8C353198C1CFCFC5FE691490C0DBB04F0628
      5EA85FFD59A08CC9B994D084A9B945662E7AB2AF316F177D9C21B744A50ADDBE
      48B1B4A3C8F4FDB300E2475D9CB22B8BA1FECBEAD8F69E35DBF689EB380656A5
      AD8CAC9E63A59C750C52CD117546E56AF04C97D26C16E06AC0B6BD85F12BAE10
      C2BC0759BFCAD5ED63AEB692158A48A6D6CE31850C857519EF58C93467675BF9
      4E265DB66C43DDC4E54F01AC7274B82FFDED51A0DB2D9381977D0EA866F1CFB1
      E1729F388B0A20723112DC7F6908A79B5BA075CB9EC34AD72136134407C9F616
      0EB3A18E2658374E7ED73B22437863AAAE4047DCA6697EF51C08D88866B91C56
      DAC74039A938D6848C1B8E3860C1A11267149EE1F64685B12B096F1A61B862B0
      99B5540F280665635875441A52BE05197B05A864F17D497B2E2EC7DF768E41D9
      1CA468130F772C8A5E16E59D9B1894AE03D9BB99C68C187FEF89B1AE6755E28B
      5810FC2D637C22FFEFA6394D1EEA3CD07C797171FAABF5FAFCFC1F207984CF75
      F1171F4EDF6665CF11B5D622B7DA866D7D7E85EAE56078CA6CF610DBA29D81F1
      F85164F114EB5591ED821067C642452432C095AA2B74613C2DBE59000126321F
      245C8EF60B365EFA55765E92FDD4248D48F652D6DD766F707D32BC5052519344
      B1611D796AC0C1993ABA0D47B95B24B7D08B2831E04FB157D5BCFE9E628F8AC7
      F61609CE848AF9D33801FAB841E9A00407EA2525AD64B300524B0D719A804C05
      90CC11885929F9E328CB449ADF6B92AA268700C14C945E12F9D7D855141B908B
      1B93FE6C4ADE9F2B07DA5BEF1C68CCB56A145D2C29D7EAF2F2F475690ECBFDE0
      E6CEEB5000999EABB6359BD6EFAFD5EE5677FCD39B8B3764F47D387EF7BADC4B
      9B26CD6C9CB9FB97B68BF1C96C3A1C06B79C32E1872A67177D1DE8CF66037FD3
      36D670B43AB0A310D47176145BDFC1F6930767A13FCA76AA3DA529713015DB5B
      726E0C60F18F1C96A4C439EA8B1200973B166148C9461B86D40093C6CBB3F73F
      FD6AE1EE2D1B218276843501E511367BD14FE330DCD84D513861E72346812782
      07427D4863F42EA4D6EDC5A975AA5ADB596FE3D18EE55FFB41B8797EF08F6CE2
      B01FAE1871647D00DB07D4C00B74D9920D3C9C62B902E605961AAAA1989133C1
      B0507EB3B64EAD37D4681C307BB95BC04FA09DA99E243C3D77C3F48F0BF6160E
      82BE74654CA38CADFF8B698FA7A6584769EADF6DD8BE4ADE0A2E10397D7FFC23
      2ADBFF00964C093E68916CD8A6B8ED8F9F65C12852B6834CDFD9C88E60D8A332
      E5DE8196DFCF836B7433624E4EA26A08FA638B93E2B9D5EB4CBB3D2AF6A191C0
      A52D01089EBBB4D8B69D6537BD3958A87A1AAB989F6A936767674BEFEC531216
      4BDF6FC7B6CDA13EC326F754C06E92F8EC18A4C2CF8B0DF386CDD6AC5A204774
      D96A20ABD878A21CF9B9AC90C2282A3280C6DB8F6F2EDF9D9AFE858F1C066824
      A07FA037ED83EA27B14C98AD75A7988B98A63928B0A83E1B19F6AAA251AB01D6
      4D671A8237348DF7E6D55790DA7C09FA3D79C69ADFE8195B464B18F4B9EB54A2
      397AD0730B6C3F5B7E2B9CACBFFC8E2E1B4940CB562E0E30FDE231B45C23A47C
      DABD2F8A97062B977C32C8CE310E8DC9ADDF072EFAA3D0A0E23AA2223147CA4A
      FF3E10F137C312D7170F912F7E4FB8E8AF0A198DA95F039F6359B394C79C5086
      E964944C66EC7D469FA38C3AC8DC92DFC9D733C4C1CA3FA9B401A57E93039153
      A117F59DC46BD40416D52F69CFFAE7D1B175E36794EA4C450761580EE3F9B215
      4D9FCF002B84E504D4493C2007C3BEA592F806427668C48E0F931ED79CE90AE3
      8CA3D600401C3C29FBE154038158814E0D3364B5114FA9A2D4E11B91E242FEA0
      18ECC50367E04D78DC52A5EF286774B3F7438248E658D51580511759D9E9F5CE
      8AE10129B777DDAB36F60ED8CD473D68E7C1AC04197CF8924DE10A0EACCC26A6
      23A064684C4FD09D5FA31CE3F9AAF7AB5BF25A196FD4D778A35AEBED8D7A1F23
      F37E0734F24E12C40ABC51C8F0A8180669B5A04C62455CE3814D6B8295B4E8DF
      DEFA72727DD296C495415BC8522FE269681DFB41AA264A0E0476F3E90178B875
      F146D2E9D2F5CA339C5B558FF8CB50A7C31B7F7BEB2E93D83D8BFE80EB78DC24
      0B9548DFE52A859465AA1FDDE56399504097AD6AB0CA9FA869B56B9A563F02B9
      7FC4076781D1F4A5A6AFAAED413D9E66D4362CFB2C5BF4F814C703DA54736A18
      CB6409028D4556A318B90DDB073F4F451C61D0F925DCFFC1BFFBE087D53107A8
      D696471D3CBCB4D5031DD9C2818598DE48C1EC09687863508B077124478362A9
      3F9DE93EA6E2A7D8576010C8126F6A85D94F054FCB8193E617C5E348C4611FE4
      F32EBC28AEC02FBB87C474F4E97F157ABEE0B5E1EFDCBA00BDB9F004D55F80FF
      C84D069580CBE34436B5016D3D62D8D290602CC01F96263F1812ADC14B1CC49E
      7E8805A8543F0503119B407C41AEC0F07718283B0AEFAA33A2BE180DC992A221
      2671420DD0FF6F3CBD9C823585D541D4FC9C68914954C6FCFB4001F80E589354
      9C96416C3330E1398CD0F67A170BFDA5D528860CA8EA8B0F0294E1D3284FEF92
      18D3B69D667BD34AB2A9080A7BCD1EA95E21DC76152C5B7F44429AE4EB3FA722
      435DF4A77747270F34B353371DC753CC62C7563E9B068EBA1A75668DA99808D4
      A570406674E347705D78B7A70AB335DB654FA81C9C5A34DD2627A30FCCB61FC6
      99CCDCC3B67E71AADC93D8C17CC3AA17EA41F6B3F2B06658AA4DC62148216E7C
      91DF047D2EE8084AD7648059D160DF0A542F0DF61D47BA3D0BAE41B31011570F
      B9E5373A57A9C9F7789A634DF09F057CBF50F5CFA7688A7E6ED97C076B0F41C6
      BF7E7772C9AD56E368849A32F6DAE30623D77E1A50114286337B7765EB04D96E
      03047E83BDE11B561C5F0FA5E3380CFD2493FDB1256B429242657E9760C7335F
      88BFBDA48A40FC80A528A5561A7BE45E9EE2A0C7A2915690F6A71320496AEA5A
      3477C192022AB7561DF174B975A61A4B11B287FEC6F592AA87F3CE891009CD22
      402C3B970D02778AE6407DCA622E857CFA58B0AE2AD5E90CB09F9BCAD2562DAC
      89ED4572503BE0A79EB942FA2DDA7A1BD64CF1416EC8B6E9D23D896F2244D7E5
      C7A8ADCFE24ED92A58CF469C3D607C29BB08B083C1719E86F87918060917B49E
      512B58B086F4281EDD920AD6C4F5D4F8EE3F0786FC42356527479747D4D1FFE8
      F223C28A05C066EDF0019D407A93B02185D8A7730EFA34BCA1C6A2A55E7DBED5
      0B69D203FC830C05A4E02E300E6CF9988DFD817D03FFDE0D1AB24314B2DFDB0D
      137035ED3F2EB85DD8D219C64AE2487078ABD8E80A121AA5D2AA5CABA717EFA8
      5F2AE12F3001765E26403CE7DC7C58A737A8CC064A8E28E6D4EEEA8648792A7C
      E08FC5FA327742E82271A90A16BDE8E0E97F0E62593AF280CDFC8ED598DDBDA5
      538B4A87F08B54082C7D971A95EA9CC4C563B2832761C5E67928EA7AA7712FA3
      60C49343B0A51176342A8D9C08407120B514350E6C31CFEED1091BEAA506625C
      9FBE915D7EEADA861545EA3F93420E5BFF10DF70C3B08B1FCF3FCD8C63003419
      459BD735A216398AF61954D8860C9507584ADAC8533FCAC040235359114BA967
      7536ED8F370B140B00022CD6B3B71797EAE8E1D80741C673E1E83672D16ED6AE
      6B11E0649A84411F1D93D5CE693F7CFCF4417794947D157DEAD33E046C08A5A7
      A92472D9D42FFA0599C0475DCA2D7B6200998EE36840931F4C504F2A7CF36043
      81F252833ECC6CE43F29A7A79FA104C36C556253B2CEDD723042CDC366FC5CC5
      E34AEB323BA3E631F2A105751F5A47BA09C64C4C11337438B712DE263081BE45
      F15D36B16115ECB58840905AAA5DBFF5013B6BE17C143882930A83FDEE698203
      DDE78C8B3B5F0BCD9D5934DE9530A1DCFF3C9D0A9D782DE31141A608003E516F
      18B15F79AA3FE781E874E797A1287A0F3B9D03B981F27D57D0992199C7BA69FA
      118E153F56B9F36AC621F3AC81485281227B60488449A41E5EBB2F8E6848E659
      10E672C4A0BAEAC5BEF5E253C4DD9B28C478C24A9EF5514FA87BB1BDB54F7F7A
      F191874AEEBC198828077D895CB06CD4EE2867FE0B3A1DF4D2050381EE86B897
      C5B4BA7230E0F4001A204F6405B4F282BB3863E236BFD70BB441F975888074ED
      03CD14F0AD091A6C23F45390A2C94D9E0B21F42EA6D9022CF2C88BD143C7C9EC
      539451CC2A6120A95DE651E2CCBA41DC9F52547B17278360D2721252120C4678
      2835799F9CD11491143E9CAA86F99EA1EE47F0F5179C58F3AB3C14EAFEA6A7D6
      ECCF69EBCD18488787E94534C2075BC3614B7C613447C9022EC97D97015826CA
      85419908444E88EE484968C0F3586B95FEC88D9E01AA32234CDC0AD22A0752C3
      944117F86BA2AB6774B258AC6800FEA5A7EE5B77F1949E46C177A60F9CEC7438
      3AFC9A9A9BEF39D1A9B3DE894E48C37349F89535A7ECE6790B5BCECE1B88EBF3
      07611D024AAF2644013B5F6679CFE5E9854760F8E7C5F12A36BD59F4BD08EA2E
      21347071718A67B64E685B0301D8F573A16D934060B07651AC2D14D91560ECD9
      FB9F34C6EA6AF9B5C3D667DBFD39F1D87F1E19645D10595785A74A1CD25B7C5F
      48AA848AC1D14771B46A56AE829D3243C1F7C0D7C0B7F86EF054EDFD87B72B44
      54E33998F11C68BF9B1CE34946FCCF41344055D94F94EB0EBF7D87F911FCA77D
      7415D0088A20C78814578B0AC1A174AE8AD01EF82CF753D92D052B3A7935E544
      30FEB3C7D2899067E1184072E7DE779819C4D688BDF4D6B00815EC0FB4825C41
      EDA053DE6D2A6AC8E391A0E642E4835F7AA7DC2FEFF2F6A40D8216166BABEBB0
      F8B4FBBDEFA5E562FB1C639A2ADF8D793355EF724681CCFBE3D2329DF4A3DA75
      C4914C3B984CD0138F0C532D4E8EDD654358AAB7A833CC62584180B2DC70A57D
      A98C047B48829DDE0626C7A124AA30CB6115E24AC039ACA9B8F24B2D4906C190
      C2D2B954537791F7CC0D17BE3D3FF941C04F9E81B687CC8EAA4364B340B81483
      C37DCEC9C00A5BCB1FE27B20938BD5C046649AC3200AB2B1C9D778F4384FB11E
      D20F0D35336EBFE1941FDDD18646B6308866B290AABD1E252170EC74151DE2E4
      4B2AE9BA1A7D4D19872B5158054360053B07BCD02C51A1C591C50D2454D7D5FE
      34450E087C2B9039EAC1506316760DC07C642EF490A67518F765220C686EA404
      52B5B185D93C03EED95030567D3181FE2217FE649F7F14E5BBA52E0EA9180540
      8377457A0FB720A357E08568FE223E9A115CE5C44DA98480AA3803F8A3DCC18B
      CCC2D9A474D3A12E3F314CB7CE7B86E3EEA7B9D56E19BECB7CF704DB1BC8E466
      92F8C468196319D9FB7DEE3842A9FBFD54F81937389BA806C54837CEA17DE811
      D6E2A726E2637F6CFC528FDB65B25502286B6FDE9F9DCF0C84FCEEB1F383EE0B
      8DEC9220A49A4B14C88A2DA106847B950B3003B9A2B7F248CA72C63EF7E903FE
      3AA2EABE1B6AAD89FA2E77E43CB4762FE92B5DCF954E68A508702C8587834AEE
      EB060BF934A54E34F170C8E977F8852C2885EF648A976A74C155A4DCDE162B4F
      73CA9FF673E54ACE4BD7B22721C5A67CBC45401154F7513451BFED1EBB24A8EA
      4E4423AC60C0A4D57F1CAAE2D3D74571F79B6818BFAA201B3E290EB9BB46905A
      1FB02E76577721C72BF7E01299DFAABAA54C62EE6034167796BFBD950AD9E27B
      5F168A0794237E13A79FD5AB87775202CA9506E597B026D85CBC38535E0C3EC3
      6AE210D3E6FCFE3810F49241B65F7DFF528B0B39051799563A909D434ADBE2F5
      66C11ED369949B16523D17837AA69E2303CCC043819B76F4553B3A331E17BBC4
      C478C2809D333CCC4990717F477883EA95208E3241510000772652D9E144C35E
      F7E7A6D6EAC54BA1DA82D8858E26C0AC02A1F7CA9B9857C049198D05FE63B882
      1C5DBC6EBFA8E602D43E7973F4B6DC74846C3DC23CF82FB8562D9A4BE0BDF6C3
      299A99BAE9105F4E78CD989262396416ABDA1C56BA8EFFA1542D7943A0A6C8EA
      9B409B933998255CDF2BD792C993873FF398D9436ECCA74A79A9FEB49CC189F5
      38E2162C63114D95BB4E0EA8A5C9D0DB5B6A36B48ADC14F0CC344015BC3101BA
      F0239610794EFD0F466DF29B58A216802BE68E2F8493002A622E05C209CD03D4
      0D37DCEE440CF696EE473C4024445C597E9FF0FDA5EFF57D3C7FB7A5BDCE6678
      6DF06E915721152FDF8E6371B9FCD35DDD8E8D5EFC0880B039C727369BB164C1
      E8C3AC0F73CF1296D8384EDE072D8072017C4C4690AA54509ABD222558CE653A
      D25D6C51575AD47BA5E419902259087A3149E214635EC7A76FDF165A81EC37C6
      EBCB4E2B873258A6FBA5F098E877BAE09F155D3424431C7053F6EFA19247E258
      3F4FBD441C1D0C0445CEEEABB687CA291DA2EE7B37EB9CD6CA26AA77F06402D9
      DC97524458C2355DF951F8D6CB7EF0E1141F517DE0F616DAC4702F3D489F42C6
      7A8E323022D030EEBF00A969C9344DD0A1CE1AB3828F4F8E21554C1951EB9A53
      56EDCFB005AE4E1DD1D0A1081E3E8B218E9EAD212B50A43DCA6E1C87D6D934A5
      68C1FD92AFBCA430E932AFD9079734CC5470C3313442B2A2F065169EF01A58E2
      026A1CB6341DC5522DE73A183FD755600F3E0D1E32558DFAE1BA996714453422
      A0CDC95A9A205F814718F650BCDE8A7DC2D41A55B91A972D610B282C5F7F9AE7
      182ED7441F71AB26EA2A794E86D9E3B5CEA52AE7F37B55CE256F2D711EE607A4
      AA67DC0C0A8DFA393C60B7D4B74DAEBBAF6EE1EE19B337F153A89115CDE1C227
      69539FDE1168855C0FF7C8A45CA2AD3CCBCA926487B76E23AB9AC78A3CA7FE2E
      B336B25C45F38BB4CF8B1426D6B2F18DCFF402DEFE7C255ADD7D9C33FA5D9D02
      DCCBFC97873DDFB57E04A40B97DB0266AD55BC9939017D94A0C3E5A764E1012D
      3BC3E1E5D2EBFF1003979E36AE050D369DC15AFF707B0B555F2A951F14E29A8F
      1E5D6C4B3EFBD71747B0EAEAAC6276DC91C70E857156311A2E4F2F1A6B4B0C4F
      1CDE867541B7205DFE4680B0F6ABA05015E7D85942DC9229C82A3DF7DC3B3BE7
      88DCD979BBA52F587E17D0559098825C29A193CD31329D326C5B1764D954C77C
      545BF2EF03AFD840E46430408BD4B7AEE3A02F5427711FE71D8EA8A701273254
      7CD1A00D7F88C3201B2B6A6CEE01A7E28E6FA52EEE02A4BAC870F06B9CC85EEE
      6490A06E4822CEA8488F2516DD26D8079F2D02131196EA11B59C94302985594A
      B93968E531ECC074F37B329284660FF6C4B90EB833BA744AFC030362D8C406A7
      365947C00A4ED03F6190F3311FC7185E8E060E5C24420C5ED3242D83A4CA4DCB
      A6F3CEA737D685349F771017F7257AEE30F82AB05B78EED88E723ECCA445968D
      F240BA1FFD6B3F08296F4CA71194A39EBC328F41E36C07EAFB8E6EC8D9D6EFC1
      244969BA07F7A442C5151300C87DA87D0F1780C5FD5C3598AAF819526E8645EF
      E04BF255E163EB471126D64B39AC0E3EBC17B7D3EC5D3CC0CF3F04F98FD31E7C
      909DEEE1931A94F852CE0F7C29C70FEA9DAC887AFF4473501D3307D5CCA27B8E
      164DDDF56ED18433DB9C8E7560350E1B643C2131D8D610D828C52CD897AA423C
      A42F93A12A47EF4CAC3727A059F752E17FE6F4B38354703D065CB10F6C37C54B
      376C260080A48B63ECB85B33305E04071A9337655FF3C7D30F6F8F8E4FAD77E7
      27A76FADB3376F4FADF747EF4EE5D0BBCDDA71DD88153FC758257ECF176C6FC9
      E44D11F5638A65728FEB0909F0C220AA58438856FDD4CF36AD097A0D4C7070CC
      4BC0FD1B642C9318C37A520E5B8398821E940508506879BDE04F82086FC508E7
      C561C2184540A8EE7F9AB0F3CEE601713CF18C9C0DFDD9AEDD1BBE7D9E9F7779
      7CF609CF95D36E8B1A58AEA6D8398B29E2FF29D9D9AC4D3F3036B098FCB0F301
      D31753B41F41B72FDA8BEBA20F6C1A99E4D6CFE7E71F4A99819B05895A924FE3
      CF62416FD9D3FA12571294F81E3CA62490046716A9BC9C52762DAA6CD628E0A0
      B49A192A1B0B6FDAD49B3AAC96FD9ADF5CBE2B0F70F1A91734E87E41F42F306E
      49F4976B343664D30F4D9F0CFC301E59977112F477386FFDE7380D07A0C2F7C5
      8EF503677DC938FF35F630CD90AF0348C46D02976F1620EAC0C095CFB2D72FA5
      F15F5093EA8FA28FEE14C9F236548BA9CE71D9DE52935CD4F04872940659A9F1
      BEF293AA396ABE2AD49093CD643C20649290DEA53915079B05A8DA9137E47D53
      669F546B8B54C3BEDF1F8B5299030F5694F989DCEB5C6646FAE5D1AD9B059B1A
      C8C8F9DC431C280A9B8CFCEDAD79652703CA1564373DE0133C5B3A03B93C57E3
      5BC43DB18B59A6603EC6B23A17889256AB2460FE2980A8E28F6C2B675F50C7FD
      948A0720E8D2F50EB488B39574D2EBFBD9F25B06D2107A9EB3CB3E02F22CADE6
      B8DF443958B1A94EDD5E3A30D43C3010A9566FA98D6D36D2E32C831C1C2F32A1
      3676D7BEBEB3923899863E562562C500C6D82AE1A0D9C45E14C3898813D5BC2B
      A18A549D4FEF630F88032CAB1CC4916C6B53D84170D7809CBDF0B50C439958F1
      23875444F3D0B690F1BC9E891897D198B2B639382C630C18C255D1DBFD72DC54
      856D1F026BD190144CB65E1C72793C3924117F56D69DE94F1421B54D847431C8
      BDD746E0774FE547D64E01949D62625691114CA56403558821263D41322B88B4
      C1841D1CCBA5185C7E57AD49C36804F632C2B2F951EA4F38F5EED07A2D6736AB
      348E9D93184BB2387811E5A089CA3AF91DBEAE17DF16A618A8EA11AA8B7AF1E1
      94324A69ED4CDE4F7D8FE7CC04C31DAA1AFCDD9EE8FB1826922533F027D96F66
      6573C0DC27A129B75D4B536EFB6968EA92927940021C63220F981186B45ABA1B
      E4E5F9B1D2F94AC954A118CEE6529530942278BB942C45D16CC0D8CF8543AB74
      21407E6FB634940807D4C93112A77FFF70343A2F37ADF8249EE28B1C8741FFF3
      EA9BE22F6198D529807BE9AE8BED2D852588775C9247BE2A5936275DA3B2025B
      7BAFF4C4D4600046BF44485C01B9385198AFFCAE58D58DED664A056517E83FB0
      7695B70C801DC5F99E9CFD787F41AEE4C3BFA622CB63ACCFBEE11A466E76221B
      C0F8233F58991DB331BC97E30186E12A5D460EF114953105BADFCD0CFBC42843
      A92E72B90CF1E8EDA5F59FD6C577C10B8F2F3FBE85CD9E2D7DB31401284F7715
      E52A8FE51EF8596305D24073560A16519A353644968191CF422499040D650BAA
      E4671501819F19BAA6E28C32495604B9958852809E065E99AB7C09F814DC5440
      4AAE43C780DC2915782CD8022C9286C8BEEE9290C9A67542354D98BF84BCCF08
      CA478EF3FF8BE38911934A4CFE3B464C4D7D30A7FDF44B05258252F7B0E30E72
      E18AFA3C4BC162EF5BFF49947360DA66AD9DCBEDD31BAC029A9811DF8AFCD8C5
      14158DA7B2CA8084DE149331405A6BC05119D59D22396AEE421E39D957281FA7
      F174C4F5F93B74C70E8F01C37A2AD531E52ECBC584BFDA0DFA71A4DA4BCE7823
      F62AA55D3772241850D675E0D3F7EAA5383B272A35882977617AE8328B8AB670
      F483CF5D45B1A7D4B06AA0E678AFF626C2B663D97F8017A56DA8F69CE5477150
      82EECEA8476726F0B87395AAF196E2DBBB033FFD8C8043210A7008F15B6C9EAB
      3BD2B2F57A029759BBEAAFEA6A7973F9627E6069FFF87819C2B660A79F11CAD8
      5941E903DC185636FFAD54C9D1B4358482DA05E81B63EE86A634003E4AB93CC7
      ED71AB98983211A686F9517725218B7F83BDBF30AD0ED5ACBE1CD78C6D56E369
      6A3855995391A7FD8621C65D782B260241CCCAFA04D6DD1E373863B5351A20FC
      988B64F24A4AAC214D1973766F13007B80F96A9AF6E97CF6B0AFC433512B3BA6
      B07545254031E5C185C130C078805CE725DFBFC7EB51F33F7F7B4B37AE565BEA
      51037A3D608BBF94FD720ACFAD62808871D429117B0C15B887793853D39EFE31
      B494652E73C8D668184AC1CF1F2CDB2E67D712652B98CA4085EC731D8F46A1CC
      BE27DF6E1006F91D37F694D7E7711C4AF2963749DF2D1017C83AF60783DCEB05
      91EC51CD81083E346AA9B34B84C5E7C7A4A9FF7E04ABEC1684AB2ED2CE6A6AE0
      816F5760C4847A2A243835AA5A07594E07ED63DB1A49920C0A9912BA2F359F9C
      CD79BA6EB7F2BA2FCB2FB7A71691CF9780281C0486941FC1D41FE1050F4E3EBC
      61D962A8778ED4553D16411C2A68E1840792C5250D581687001EE2041E14A720
      D444B9F3ACF665D11F866045609E63A6FAE7FCDD02A0FE3F0AA395C8568D160F
      F508A3309804B99EAC26A74310DEAB54A01E408F5E8DAA0C6332514438A3A8E2
      5BB0F0ABBC20904DCE3E34A5C01B3A5A0067767EF427BD693A12E98EF50E6C23
      43493AB745438600B353937F295D5E35A1F9922D2C2738C85550D2A0194BF628
      F9BF76F568AF3D2973B0DE948AB0238092C85E6D566DC0CA7B3338F3D3F3D6A6
      39C3DB1839D9BF89236ED6D1FEE04FC45BECF8B31B0C79D64B946F5813086CAB
      BB596F6C3AA75518F43B9C7CC47ECA1C476A913E41623F5243AE03D00D76FF46
      4AC34000BF1DC84C77D9358A94F062F461B99754068CFB0E54A2BCE8C4462DA0
      CA7E51CE17340AC66311D88BB7CA596D5077D68BCF1318B42F1FD10AE1859AFB
      BCB917BBA5CEA9F8B7439185D8F2125489401BDFD8CC4C3AC67CD9155ECCACAD
      0D61F5059A093C013ED37DD4E5CC32727EFBD60E79B576B0563A2FDC605419CA
      13B378D814124E92E06DDB5B91548DCE4E6F6F6F2D2ABF3EB44E6F7DD2D9C3A0
      3CEC418DC2B86422F3B17F9CB663B43B404DAF9826F8D16D36AC1D04E08E7EF5
      5DDBA6396427EC0EF0EC6E4BBFB8BEE6ECD496979D9E9D9DEDA97DCA417034E7
      2B0F2695DEF0FA4C8A7618C035FA390FA9E0215FECF6D38FC1880BFD55CE68C3
      17557FDC97079B66C098825190674A5D9413BB908DBD3FBFA42AE530E0043A9F
      AAF607D876631244A2FC683FBA9BC033F4A9967AF7639404991BF74825DF294F
      8BE3543A523CD18C2BB06E584C29E3AAE049021A0ABEC22E7248D467B17840F7
      8CA2C4BEC83AEF613B813727FB6A380B755EF08B1D06E59964FB6034FE2F82BE
      4625304B29B254746B280CBC39685AC660D544B826B08CC3C912DDB264F933C6
      DE8C22381D78D115F4C625D0EA512A0A3989A60923919CB13E195F5139BB342E
      2827C10C9B597A65E7C1874C4C07F1A2107CE234A80A0411362592A800941980
      8428929DEE36B0005425EFC3DE5219DF8C5E6A1EE449AA8DACD2270658467A49
      5765366A549245C7261BCDA48AED25C89467479546CDD22422C529B07867F903
      89B001FC1ACCA797B3705732A37E18B75BEB32A09EBAE1B23240CC095918C266
      508CE23EB43EEA81BB94A322071A4BEA531562A4F195B53D568F89F95E901E73
      7711DC02DF9C30D4F9CF9CF4A2E7F0669AEB523DBE5614EE133D3EADF07A7377
      13A9B2267140D380D1A48CEEE24894FAC1A9B9F518F4E5815C611C7F46FD71CE
      3BE21327D3FE98635F1853EAF3FC934ACB290A6CCB9655EA7D5FC39D18E9C5B1
      293EBC8C3FA1B9E5B00EF51FE4FCCF8CA194CA216143540CF3B1EAE8593E0286
      F000DE2F18DE49D76474C7ED9B3F45E4A0DF51036F69DF33335F8D507984383E
      1683A05FDF59C73E05028D5C61B952054E79549FB4F1D828A1C643C00C8694A4
      415F1175739A13B725624B869ADF970665A742E6BEB11D75FCF1587BE0494543
      02A331E87D7E2CE73E6B6283F7E39811ADCBB6110E39A627C29AC01C38B08B99
      6CA900661052FF0434BB905C22AB0936E5CC7069B2DC63A2CB0AD7CB7DE28FC5
      BD2E9860D872B1920627598385BDCC38344EEFA1E1380344DEBE9C4289C9E044
      EFF2C1FBF8A95CD6423BD41C3CB31E3D1FE949A8A6BDF03355AEF9D5EFA8835E
      FD41BC8FF62EBD1565739713D2F98061E7B23900AA193977AB18024302FD629A
      A399DC9BF25C4FC5E16476BBF250284E4C43E355477846A1CA16A279F02D6393
      7263948C9C4300355F8280A47C402E382B8D1B8785774EFCDC573B27AA173B8C
      AD7E3F9FFA21D756F2426034D0E006AE3896EFAB25009CF3FDD793097B75862D
      CDDE5EA5697B026F449B5E8132F2B762E0D41D0E60476CC888D8FA925857068D
      B74083CB9F280E101950013C294C65FC2EA2344C53342612BF54BAD6F24D7A0D
      2B0CC42CBD4047418A00518694143D8A5BA72817963EC6EDE0F8D5D5EFC82DAE
      FE5881C3E36FCCA8A4864BB97205808C16F830FCDEC12AC101EA08E454D68884
      42447936416FA895B746616CE9FE07491A53F3D2B8A43E95C66CD7EB2C8329F9
      3265F19B0C2288142FE08CDA099E1277CCC283CA0A2F34A738518C450F2E2CEA
      2B8E3F7CC2FC0E51EA6524FD76D434BDB0D65089C4613818AAA0D7C0904529A8
      60E8A7AEB4B9A4A3E3A148ED1DF4F9866BE8643E9D3070A4B95336724809D70A
      A75F64F62AD3A8A47B5A9595644C4CBBB7D51A92B2CA5DB5FDE8A17EB906E11F
      EB5A4983A800D67813CD29A4791AF14024F88BF14FCF247D103B90D14C55E4AC
      BD881C2E21434D46A5712738EDBBF0F31DBDBF7863EDA24BAF7707A627C80574
      06A460AE61AD86BC5E7275592895E95EC82AE9B438A05D8C777307E9FC4670DE
      382F96A9480FBC063D8ABD6B7B484D949A6A7DC012B6789A6117F24CE5B873F0
      760C1A3CF526A7A459D81A6D727B4B8D4AA5B6DEEC452841840345C100555B54
      DE74409B36ADDF59660F48E3B2FA37C91A42CC4D935754C3CAA5CE59986940C5
      2FF5EBB1BDA13A4ED2A57A16B41A3223EBA864CFE07EE8677819BC883A8CC22C
      863D49CF0DFA0540ACAB2A20651B939F355466B77C898CBD21D40F9336F102DD
      20D8F99BFAB5726E1045C955153EED4119DF7341737E61EAE61F6B3043C7A70E
      D4B0302DB131FF1EAB3B8BD4B37B386F517FF6918FEE4474444A1C3429C05F98
      023C5F0F589B14E0EDAD1F5830E9733F906C0E1144866328558A74B908E5DB7E
      D16B1D3D60541CB18F190822C5D1D951913240393C706DAADBD1ABF0160DFB39
      DC2C64FAE9DDD109DA84380A376062C9EF122121470EFE34F5EF0A22D2B024A7
      BEB8854DD210E8CF77698025A4DB5BA8756128938BE4D9C9CBC7209DBDCA495B
      085925D02C1F7D8E791051825241CA94A785F528B1F4585744D886805A66A6A3
      DA31072DEFC308DDE6847CB57E44D8FFB3B8CA0EE5CB2CBF3D14295C37DCE758
      E24790B1728090DBB01307B994FA5106E4404195C58E7D863424D391DC45A94B
      9498C4C301465C2F960971887980D6792F0C40078BF67570BEC19A9AFA951AC8
      8014E48CC9CA7BC0134508C2B154063EC17A6B2A77CB30E22E5F90B5D6FB0171
      7E850A3388B055CD3E677A530B4DA0EE704AED26A23B75B425F858BB0A26B298
      8DC35255003D4E1B6B40194F1B99798C36F65498B6F81B8F98C3885978779F88
      BE7BA571564B2885644B0480269FB6561CB7E95ABB64C81C586FFD1C071BEE95
      BC9580A831A8062937089966AB0898F593036998BFFA2FF5E27F5F41E0EC8674
      F225EFBE6EC7A5FDCE4ACDA7DB3176E3E616404BDEF5341F765693B4E717B4C1
      1EFD436C36AE47E3A513E23DAC2FF75071E62222CA09939422483628AE34AB90
      525DF53DA294D200A4D2A7CBB30EA99AA964792AA9BFBA3A65D4CDFAB48A7565
      7F9FAC10C89C0183AB73AE02C82A563EF57E6F688FA5F9BD95CCB8FBDA1EED84
      5C4C18C32A3728D15ECA88EA2438D53FC1388B14F7C8FBE96FF2F7EF4CEA19A7
      D06345AF12818C3F48A55C175AE82E6A4117A75C141387035646CB95E015F263
      3A45CD761421F91AE7D0173A87E613CDDA3887E0E9BDA00FDA1BA872ADCD3A5B
      CCBF421175406269C3DEFDDF02AC4782BABD596F3EF0A32093AFEE6ED6AB8B68
      146EEABB0F836863E13EC40C9ACD7CF59100953DDACC574F85F8CC6FDED8AC37
      1F4FA3919F060AEE1BC62041AC87C186E2CCBFFCC4DF58990AE6F58D186D2AE8
      93B8904D1B86F1E844988EA68C379B07F9749A651A6B9CCD7A77303B36562DC8
      6EC46053DF3D9FA69FF5BB7BC6CD5072335C9C1A87C2733A141AEBED50986B64
      19CA888BE270AF127E6EB70CB93C27B978EB4E2ECBA7948DF4E99F505605B5E4
      9501274CE8D5B442F5B7DC0C98822486F130E37973AFDF0535541E9782F894C6
      4C09DF053877B167037C25A3865C95AE4A92750633D2A3E5F7E0A23D2C59A6E9
      0477AA76A3721CD6AEAC0FC9AC9D4F940650F9F3AB9D79A5CA180FA4C2A6BD52
      7636C735751B5B8C70627F69D96D83D3F50359D67DFF355452422222CE9EF179
      72028E4E4308606873D9E1C45FFA890ACEFEBA82287D26FADCAD408EEFA186C3
      D83644CD9A905DF402DD1BF801A22A0827BFED3A2DF8D7E9345CF8E1B6BD0EFC
      68B45A1EFCF09A1D1B7E34BD2E5ED2F21CBCA4DD70F1928EEB797C375E02D4D9
      A665EC6E172F729CAE8D57392E5C873F1B6D8FAEF35ACDD6B352EB12E6509631
      41C25AAA537FC39406F9D567EC4C1E477F6BC1FF0C9BD309EFA5792694D36C4D
      E07511A3D735F9E4692BAA897FC3C6835261D72E37EB5C3200102F5731583A8B
      5EE4FB324B12E40C622BCFF0F1B1834359869450A5485FA1893BDC7113B35B40
      A1EE0B99B455CAEA01D933106980C574240695C43439198FEB6FA43C288019CE
      D52AF5E9251D0C7BE0720A96D2B4E09B9D5396003BD62E7CDC210D475B923486
      AAD0818794E25ACE0BD378AE673F4D26D426009B78AD261F337CF55FEA8DFF3E
      A7EBC53303FC50CEE5E13E70591E944701C97614C442B29B20A72943E5CCB952
      6E1ACF03A3C4F2522B5CCA9905B37C92D0E18D44B5A253DFAD55E83FB6B7969C
      118AB97E7F3F045B6A25E50CFB6AEBDB5B70086F153C3E8B3BC2EC225B5F7530
      CDEE5D4379F25852C3698B86F32E3602A248BD34ACB7CC7A6B46EDCD2DC42697
      C32C38551F5E35C1A8E0C799E422DCF93B9D46D89E43B25D5DE52B8773544603
      94759521BC124E199BFF70B461A7919C7D241F4CBD14A424E17CE05DF2CA9F9D
      7BB2F4E5BCDD5217E05E29AD5792564E5DADC46D5F000B93D6C7E15EE97D2AC0
      E02461AEC5B89FF04F15E9FD54F8B96C6B87FB233B5CF73DA1CA71CAE59505E3
      DF572E6FE1A7F8C2D6D74F0881C2E85C458D0057ED1F5AE27074B8ECAD734AEC
      FF480DAB1610CB280FE17E7E441BB25A4035C2F72DE417A1609D4D13CE406441
      5A3260740BDAF92CEA464E230CB2B20A93336192D5C3E447956B7E68F5C771D0
      A704FB95D890AB4EB1A7A80B3707D5EED102AAA5110B45A113F78CF85A4E6FB4
      979AF39857326A1418E9F5BA0F9B6A4B96723796394C0165CFFCCA1BAA616564
      4ED27894FA13D9E96C5756741506CCEACC9765DB8EE863AB5442AEDA7CDEDE5A
      BE9F6D8F240C178CC9B1332C46F70BB4A3B81076F89A8964979A4E658492701D
      22194690B8A9189873D6717928AE5E221FA7F174347E989BCAD69AAABD51C648
      2B64DFBD596005F5F2247842984571BE74539B855135CE5715673826BDCC3E76
      9119A0FBA854417DBF37D29CA8613EAFA65FCAC45118F7C8A22A1905BB782E49
      1AC4298D6BC64AC8F98E95BD92FC5C7ED170A55878159C660575D27494ABDD78
      C54199A8AED3AB299EDEDE5AA07CFA4F5A3CBD0A8C9F533CBD7C2258C1D62B43
      4A90A5A2BBE706555B35058A46DBEFAFA083B6620AAB40FF840611A445878E8A
      FC4109A35AF657BD4ED8D5955A2ECACE1FA0E1E2EC82BBB2276A0D7D2CCF6BD1
      3EE0716330ED739EC74064FD34E869AD6CB87C49B4BDB5DA864BABF1456D6F9D
      A4FE288E7A711A7D29BA3CA51F4A4F5CA28E4279702DC2BBFDAA22F9A0D6C783
      56AA5E600AA62B558E94F5A5B741495EDDC2FF1613E34F4B7D593C11ACBEC814
      3726311AB46CEDDE1FC0BA571D2AB3024444482DDF62618B61E5C93A4BE90524
      A39833E93AACF4ECAF84FD600AF22AA2F1853F80045488BDF8695E91A766BA52
      1A177AB542C1CDC0EDEC4B40F494EA10B211BBDBB0976E0D182FF1A331EE9125
      22784FD3F3A59C1259149548E05891F0D39A16FD94728D8DE231D7A53CEA0234
      4119A424A78FF6D454FC792639F8993934A7CD2BE0BFB264D9AA043BFF755469
      E1A79B9FBFE2467DF73AF555EE9DA3D15517708A058EEFD2200C837E7505EA55
      76EFCE56D3B61D6BF7D3E5D94167CF102713E7CF982CB2CE31D5A7CDCD2D62AA
      6A72A0E6260A51EE0DAD036E6478CA73171CD8F62BDBFED57AEDF73F8FD2780A
      0C1DC7CA89F495F58B4C8E906CE6F0E2F2E39BF73F5CFC2A697D51CE60289D3B
      D4AEB9C3E9A953F1A90124A595EC5B340A430DE4E0FE97715E54B21AE27E2EE2
      2E1C4A3AC5A9868AAD5D8AE72B94D93352FB215A967E658C637E6784CD317AAA
      540888B22DD5C59C7B9F171DC98DF45E92F4F6E64BEF92335964935FAD337430
      CA896BBB3482EDD551F7ACD3787D76A6C8FB4B96FB1AF6F125EB5F50B2911CCE
      68669C3FC08156E049FF6FF8DFD25D60DB5B453113F018F40C961CE98617AD01
      2F72DCF9C47D9C9C4BCE7029B21C083CA96120C4A47EA4288875521CEE0AD591
      8D1CF78880B7900252E010D12034FCB3E2140DEF838738690F272BA6E2260DF2
      1C672C1683DF0939011D7DAC0844AFA76EE88FC3017D9ACE3409B0DF3DF11B3D
      F6AF3C9D46604E23C74EFDFBBDF79583FFA26426EDD3C597A7171E96EEA8A935
      EF7F2A6F60B61C99E288DC87836601CB0934B048F3E5C5C5A9ACFEF18AF45DB9
      CCD29D51493805786487F96DBE8AB093028A2A911FC482E7C3A8AA8B20826305
      B816E36959E694DE7B4F8FA895501CD2A4C7D9FB38B9271438434D1DD39C90E3
      F3821BDF925E9201BE9AE8956C0FA790705FCDF0519929CB36A540D35C413E00
      EE7EF93B0D57B0535DD256195B926316160F2B413629B3424E2FDE59C3D0A7BE
      40B2A032184AA56E12F018DA52AE443925ACC20EBFA63FDAF3029F9BA2F9B89E
      EE93469DD3E01BCB395C933669CD6F6C93F6CC30FC1DA5E4D51F0F92ECB31529
      6E164AB912A5969D1CF12919005D2FCC549F92D11CA0587982C688F8464F7536
      B8D6CCE1C05756834FE77C084A1ED6599EBC3D46BE068B0C3094AE18D9415950
      6E16FE792BC23FC523FEE7A78FAB42428A98FDF4B1D2DFD3B37EFAB819A8D9E4
      833BA62CE938B28EC3694FAA68CF80A12BD8608B37A8540D2CD6A5ED6DC6DBB7
      0F6597FBE8A06E07DFBD79FF66680DA6947F824A214D6C1E962D38AAD766FC2D
      0F0DE5CA38E91D472B8E8DC23812DC08913AF0FE36A57AFB899FE5456D819A2A
      1A02D10CEECAD90DACAB16B7952694F2638234CBE5A84C641537B8D29CA39593
      F7926918F2CB51614810C929DB787D0F90E43368C4C62FF6307EE0A4DF777C0E
      BAC8D01A80148E4D4979D941760F3844138A8C7675E5A7BC0E0B6AAA3E0F6C9F
      45011C6AE2E4A7D8064BFD4DD2A73F20F2646ACAF6AD9D7E9CDCA14D78787848
      D8BDC38EB6601284702E38FF92A452B657F8EA4A1E3AEDB6538621F7BD45071D
      1791FA68778AEB005080895BD2DC5D3C95E3A267E8955FACDA7816ADD87E1C4E
      27118384FCD5E7C44E764781B665C925084BF919805076C9C1266334135A59B1
      C485F6F6B5E18B9FDEB209BC3BAC3A4AE02A72E9CA27910BB102701EE67716A7
      933727D687540C83DBB2817C1D707B33750432D51ED80B6C11F62A211451175C
      59F74329A212626AAD77F27E72D828A35C028AA76653FE16FD7931F56B20F0FC
      064F88C148589FC581AC165F917B0700FC22E79E20A2FFB928603BAB108D3A0E
      66F04A74C85BF45FA9723D98E8AE03F4777221CFE2AAEAB14CF0FFE5F057D55B
      0765E02FFFFDAB6E80F97F01E5C91FA31A42FBD79CCB4B8E14AC0C1B60ED5D26
      F20C6F9D7921B5CA493CC5FB8FE1BD3EA3943CCED3F03F4F232AD6C557E6F78C
      2378E55CF394421052A7E54AD3AD7E18CBD615CC75781FE7FF500FA4D0A7E63D
      3BC7B3FC02A4AE0030810DAA939D89C63589936BFDAED23CA768BA84EFA37ADF
      0049BED4C448BD6433D91F1BBB6297DD4F0BBC13927E0A64144FB3126305DE94
      8A89C07A8FE54E20DF48C17D4E6140389917171A82C8ED324503D6380E499E1C
      5F7E7C4B673160F4EC237ABE30C29D85FB112170CCA5675F09CB42FC52A7F043
      D5D895F8D8D00FB38238D8AF8F1A373F9185D63E2FACBA338F45388027DCB0A4
      AC7015668C38233AC98B68FE3B59AE0A3FAD1F80CB271C18DB85B706EE7F178A
      3DD9464B6F0F2B1956D626726388EC6C8A5C18258D0A551D8EC6311C920C551A
      22622292502952DA55400387BADF71A5E7AEEC9F2855B529B02EC2499E774E5D
      7B038A0DDF81B01BA0B230F6A5D22597D792492BB443943F34415EAE45B30A4A
      6F03F70459BE5F5E85BEC66CDC51149704CD29BF9D242892FF2C73F9E64F6F8A
      7828AA140FBE97A1A71A4C39AE5827718A3A14F02C62599921AA2A5115804177
      8835048A9AA6B213B3163880AFDCD9490E2B89D1DE0A26B289265E368A297503
      09D10AC11E4432C16FCA865702DA72611DC1E3E06A5201F338D7BD8AC600C94C
      899BEA91ED17B66B74C71A21BF2DB5B4BA11D84D369375743CAF86F100C90A94
      423162439636A13A52EC93E9C55618EAF3914F0DB0F4B37555BEFE8AE174E3DF
      A194CCF1A10C1A82585FA494C4B08B1EA51B9C1C1C8DF6747A2669F5BECC9253
      C6E0583667EA89BEAF5BC851776CB41EB7B7502A4B4065C8C6E26994EB6416EA
      0E401DA732E50ADB3BB45EDFE1AAB4297A4F6A15ABD720E617C5748A6033C0EE
      C010081254DF036AEA35041D20074D3D97529CCD76F9BAAA5F3AAAD602DF0415
      0F69635FA3BA4E193B63AE7D9C2673E047BD0A9065E34BF27E25A48A86DFD274
      8F816802543FA5EF8F2157AC0996122C2847059061860D34E50E3266ED32B928
      8B43CCD5C19608984C249BA2E14DB33B18EBE60905069261451C198DF5499203
      04FDEB60C408A51D1CDC040D73B5EFD8F5B17346A63E594178B77EB79DC39296
      26DB8190E706EF4B6240578DEDE80C456407FB0D5B87C53C5A01048E1CE68310
      C0A5804FBDC8A4DB55BE316C1B9BD90751610E16D021742388E0F7F830DA0CA5
      4E012ACB47EA57674047D86293CEEAA1AD11754FFCCFE8FBCD9929083FBB93DE
      59D80171C4992C9E7D264AA11C57680CCBA3CA637982D8BBBC7AC8AC830E114B
      6087FE08A98FD7A11D1447086B10BE1149200399397753E9BD98139789F862C6
      5369C469294D9C52118B745C723051C6A09248FBD2A3510B4E5D932969A9F896
      88493967652822D2EEF5ECFE4A481E28A12731B786C45C3A2537CBBECAE211BA
      3169E1BADDB7B298DC39C8BC0701F666076A13B7891A1610448300C42EEADB15
      9293EEDD20E56E91519E959D61D44A4AB29192DB136FA4D80F308D00B34003D2
      B855259B7E424910DC817C98B06F9C539B945B8DF8A9F4A921ABBDF60172BDD0
      8C8D790C974F2304D3CB9320237725C2F3A3206EAD0FD8107D11BAA93443954D
      7D7F225C56488D44C8FE18A28C81042CB6B625501770DD2FEBB3A0934F23ED4E
      01E9A7B01A759782D66472F44D4575BE175062016970FF310B52F5AB33A87E1F
      D565382EBF892D4E2B8D95C255B22523E9CFA8CCD3C0C0BBC51D018B608CCB23
      D488DF571206C43C155B8FA7894A3D6A778EABCF3F3C3CDC29A8265003980A02
      DDC727A254A0252880F2AEC8869EA7D90FE33E6ACB521C739C851F3A23C9E131
      99D4CD6511820A428477B3B118A6DA787B2B411B3B2FF95979AD539A8D59199F
      060610C64B32D6C5C338FE4CAC202FF11BBFC75B812F4310A0B9D5907653A6E3
      91BBD29EFA4FCB2D8CD3BD43AB8E91717F34B5A1EB7B6CCD7FF808F64B2624D5
      896180CEA7B40AB4C7F4396C6FC99390231366396890CD9C833E633A10C20A36
      D254B6C13D6D28946783CC538701C9728F3174D59BE6A2B04215D8A49A25479F
      F24BE1C9B1E1A9D4228EBB15FDE3E4C2B262A5474D7573862106C84B4873681D
      91E1D8DFDE02B32648270AB155B44CA34B15D768D73DA1ED26A58CCD2090BE8E
      87AF1AEEFF08979B019F61FD8596338B59486D593191B894F345B88F72A2C07A
      714F717FCF3E86726E044FC12DB385375126D2FC505B38F2C2498CFE1C78158A
      93DD445556028C04B8DBF134CDE0CF9F12EBA5FA7C4246D5F1C7E39927A25742
      F7AD2DAD74310E86F97FF23BA849537E5ECA2A533C9D640AB935F0E2ED2DB83C
      187226DB5026A748DE430F0F86750B1D9263AB1AB4C730FFC763F5C63279A3F2
      9E27F45D296651CEA1A32756C387E50D97D2E6F029F27D8B49CF32714EBE0BC5
      0F27549157EC2EE3870010B02FF04D201D99C5EE4AC5275C5E72E3E3D850B6CD
      22ED173EF561D94A9B07EECD888FC1AC80AF2A3399CD197DAABC674A11F587A5
      A4514A241D36ACAB17BDF69AD497B4BEB1BEE4D9F98ACE3138B08E4A52F9FDF9
      A5CEC7D49613BA8265F85A228E4EF3D2AC8983D7D4E1F370B390E59213F60EAC
      F3590D4465D04ACAA8840E366C9317F134ED0B3CEC59450B77092A60699FAC67
      EBB0481147A9F6D496F9777CF0D27D4F7188B29657C22509679E76501A84428F
      96EFA7203E2BB23604CA00921E03E200854119A83A137ABF4A37D43B6A13C9E6
      0DC5D8ADB7E7BC570C9ECBC32E09368A9E68F1A5D3FE8A50FC44956417E371EE
      E140291B15CD5F3DBE56E15629658D079451CAEAABAFA9639B85A7FBB40544EE
      6CA10318828F0A2CC7F3BE5E62D1CD8B8AAC20BCAEC937A065D644721D715DED
      C16C316CA58D7891D131C188788A7639F0A5A7A0B165E104D0C16BAC74809D22
      47451787E84F2B89E7373A9849B99B98F805BA1BDD05FA6C74C71762F8AEC872
      A6EA89597A9493AD7C758B6EDEDE9B594BC8686BED4A32185BB7D0E5B8EC6FCA
      54289A9742014B078A63206105AEE037966061099232AE14913C1E8DA437871C
      34D27F312111AB4D14D8695F909984234130D190C3DB7CA916E993785AA432BE
      96E8504D1FE871EED4809A0FA9631F05D7D4A209F3A86739B57214912F0703D3
      8CAB185F12A93129BED0A468AFBB49F1A1E2DA7D2F1D8AB2E98136F3B591CDD9
      1D72623C0D6899F157E8406BE96F7291DD49104DB3223B6F6FC394A7ED2D82D1
      7125BF2766AE27D520B953F4F3639A3D06900910CA2D1A06492F46942CBCBCA4
      76F538E54B948AE6DE53439E41901B5EAA7408F6FC56FDBEF71DB85490B13FCF
      B1AD9CBBA512947BCEED3A3F1C47E8712514747C7C8770E788A338433DB9B808
      286A6F3631601D81A75DA8D07B697D8CCECC868D7766FCF6E883AB14A4E0598D
      A8404A79B4237183D93DE4B8D28B937FA8722317A7554B7F8C9BBBAE374DF5A0
      4D8853A599CFC085A867A66152659457E146BD3F52BE58AC14C6CBA462826136
      596AAC42503EE5EA159E5B8DECB2B2AA1C0CE46A479E16C1FDC8D4043155E918
      D130C7B108B5FBE21CF300EFED5066FB5E8BFACDF1353C1C8EFC6E8A7459DB2E
      552ACA10303960E63F6910933DD4139C488C8EE83A67333D45A7C30BECF45664
      F0FB34DAA9E2B230D45E97CE23D39C4D46C3AC00CE389FDDCF8A883952604179
      18B7C19C1C6B8712BD6BB20C66862854C3E8C3BAC48252D534A7477044AD2442
      6743D8D2A7856492550B3C0B4F9E52B788926795099F12E174EDA49ECD584997
      35F4F408E250BCCD10D4371214472D4B68F794345509581764A404994E178954
      4B822229699E0866BF2EC55E575885B53104425DC954B8DBD0C697D24664ED70
      5F370AC903013C178D94D3A8EE89A05953F331E3B25C3103D7CA39DA51CC7905
      A9EE5D514EA7823F55CD485E751EE9EACDEA3729259BAB77A97906BE5E99AC1F
      CFCEABBE557F1CC7B42E9BC9952CF7299D14C7D3D4E329E742DBB73AE5423568
      28D7249A8ACE052A3AF1682FE40919765238E2676153E5006836DE51379E2255
      ABC8A829AC2E8DFB2AE360F9030EEE6D64F7766FF92D470D2D3E02A02378736C
      B8523DAC1D4392F33A7DD4008B130927B0C7E0A0503A8B11BCBFDCFEAA08F1E1
      B61FCD43EB58E6047239C98093EB735A903C2B9493606513CCB74E7979B7D245
      A7FE35C884D4B33F0AB651C94AAA49D3E7BCFC7B1B2FEB2D354EDF7D5D3E5CB1
      6ED54329528B9BE461A9A58C74BF57DD17770F9429DCF7F71306938035862285
      73CE1B633883EBB131D0A93DD3D7813F47DF7A002061F059C8E8B6E1318F90D1
      473D0B82BBD3FD42389A84E2D7226251A084E13D2575805B61CD8352417BBBBA
      0AF221ABA152E6B137675047C9774535FDA0645099B98A2212938307CC212AD0
      B0C5A1F50617CBA7290F11C2FB698087C8F46C0FEDC482870F527F34526C81B9
      9A1EA621CB42AC3E16CD49E7176522D3375925CB2B85E754F8863289D818A246
      01D4C1AC681F96A431006B520A00285816CD3F99F133F815BA3E7C0EB329D904
      05E98A48448A8E7D2AB47FE044A91D47A9DF924A7AC419D344F2BA239B3A6869
      10A9325B8CD1F2A3386C4016926AF968F8D4A37C4A895AF9334311407D1C0C4F
      629EC4CD5154D20E4286122EE635AA7C5EF3E2808BC0E539ADA03F2536A0C010
      1B127945F3A117E3D944F2ED14E1FD281BC271110A256A1C85B20C45770B91ED
      67583341BF8D2AF5CD28BF2A1856962E45F0E9B99A8947CA5BD3F733E9CA2877
      19E19B555B2BEEDB8C3D0EB80647F552D117FAA95C5F72E3003DA784C53249D6
      F096C7EC2C6AA1C9BD16646685E129CC53B06CAC1F4F269CC01F91FB11243BB5
      622D7AFE489FDBD89742B5E85B21F354B09CA0D24C87B07BB7D4BC555E18502B
      0C314962D8F85DD104EEC6E798EA3402FB40D221667D633FD50137ADE144A931
      2710ECC98A2D6C9CA41419AC6DC0B23901E60A280E7E92A8FEE39A4296CC2709
      F14E08561700CC150CBB25AF29E50CF914FD8F0E6235B563577FFA1B4F77E34A
      E67D4B7F3F08FBD9BE757C9CED55929371220427A6CE01F5AA61FCCAC7C119FB
      BDED2D1C18B5DFC7498D4B1FA351405D378BAA24002E0047CEAAA652D0897F07
      74D30FA7D8CD4B9DCD8C63DDF0FE9AB3D8B9C06C974F11E5D8593F0651BE03BC
      2409FDBEC80AAB6487BC4B883F3BD2E1640444A90BD33C20227796D11769109D
      CB8E2CBB315510CB5DEF717498138D641E3966C44EE56AAAE71EE867CAA9060F
      C654E09CCAF47B287160C5313CB5D0973876358D06B26CE1477FD29BA6D884EF
      1D35A550CD09482EC827C914346CE204BBE18429CC7D2AE49CBC5211D5B14AAC
      A7C60D81CAD4D2BD61A6193669A2D6A3B3DD61E62EF1CB7FFFAA6045ABE1A845
      2CB822C1C8E5974E5336A6C8A42884EFD11F098C01F0004D22CC19E6B81DBE4A
      14C7FF16FA660D37C316163137316CC80E4C556963096E1C4C90467660D880F2
      C5EFCC806CF73550EC9E82D38EA4FED9D2F8DD41C9C59EA753A193FA6B3B6B4B
      4D51755D94B50493FAA3DA55C9F2DC50132B605427452CB7C2D734F4B0604E23
      00ACE2C933F8CFF85FE9E93ECFE5493E5742613F171C1C0EA203D233A84A23E6
      D1BA6FB0792E0E40910A5D262BAEF7F6AD33501873392099703C10E14036E5C4
      7633BC68B116F7E8A386DD40463888BCD4B7FEA214F799F71EBC387B8F42ACE1
      B606699C70F70F949DD4FD3489A9ED30C838598DFBFFB3F7AECD6D2349D6F077
      45E83F60B84F3CA6A6695A17EAE6D9D90D5992DDDAD6C523C9F6ECDBEE780204
      40122310E000A02E3D3BFFFDCD9399552850942F63B76CF47262D72D892080CA
      AACACAEB39ED88733E1C6A91F776A96C46D32180A2DB3664CBAD7E82A3EA0FD3
      B8A4F1AE206B143A68B68B1DF9D08E14F5664A4D21EEC566AC923373C4438627
      A332C1F89CB75FEB08581C5DCE255681BDB0A23B18A8F285272430748CC40257
      C3B1917E1EF9578A0F2838DA85B4C5BD949C824FC3350F430E68B1C63F169803
      BCB3C2962E16B7B1B4A047A126251E8C889941C13698E8223137E9158CE2C8F1
      5C5A22D9195CE97D03487E9CD1A22E5A6E225228935062F1C1AF164269264E5B
      588728FF3928CD657840F18BF9B67E7814E23409FCE4323BE150D33B1286F946
      C7ABBE8DBFBBBFCBDDDC5AE48DFA6B721D27275CE312B945372D687CBBE87679
      898EB3D0E44CEEDFC26BDBB4A0B88A08DEAC3849C6AE761C496AB596512D5D88
      75FB858EA71C1A1C3AE558D0CC23D81B36158DA50BDCABDDFB1AF02C05F5589C
      5FAC87B88EA088BE1E9914F71BA414826C1C19609FE5255A5F6916D6DA94EA38
      56EE2B88E9217E2628556CC0D5937BF0E43BBD4837E4DE03874A4D9B0A10A49E
      54AD10EDCD0582ADAEC36158E4DCAF723A762738039BE4194848BA5ED41D7625
      89E340C5EB45DC9291447ECAE40471F904D811B408BC34C297117F46590F2F02
      1EC0C0AE790635173A129DBF88F3B93330847CF76AD771ACC477A64B27AAF350
      290BAE690D007D92C4BF2299DF567E79BB3145B0FEDD8A4182A7079A025D9EF6
      B04A4857F366C02933140CD3D6AA26DAE21B9600C0C797E2716DC9DCF8CE6B9B
      9ED18A76D0AC35BA4DC00929D2A3D3A09CE60092D7484E9BEB7314721F997C07
      FCD1D7E87D854BA9CFCDA33169B662766DFB82F7C108BE1CED29CA2CE3139E41
      B8A7D063A614C8BBACB814D0053C2D1830D3B7A12353BB9932720610341E9A97
      E8967BCCC5826688504E54B853CBDE6A6DE65BEE71C6AB6F5F571F47CBA25B20
      7D40AC0E3AB144D6441DB2B88F233A5F5A22FAD65FA6305F2E5C052C051FA237
      6AA94F53B5E6AAC9D68B3BEF855F44E73C012DC5D5E4A0723FBB35B3A9B526A6
      67D2A9F3926CB390FF48350A00CDED15ED3F7BEC5808B687B77F787C8C99012D
      C700BA203097AECCEC9099F7A8C0483BDE0F1DEFA98CFE8FDE557457CC926568
      72960427CDD67B49D2EAD8DF4E69931AE11DA5D7B0DC6CC97BABC6422440E6D5
      46B37A5937939E7F26A6691AC6CC8E30E8D3CECED22351B0520CB2B4D6C5D3A3
      B010B537DD776154ED24D8C6734607E00B356A5A44F6EEE6B933CDE39C3FAE9A
      D526B57CF4C2FC7C3008487693D66E49EFEF22F0EF38596E3B8BDD27A667F9C3
      3C46450433CC9469F423B642907D3437F413A7E44D55B3C5004331D5344E423E
      65EE4D9065EC41D2D2321A89DBC7AF5471191830BC42B0A4432E376DD9BBB6B8
      A2C31092912ABB43FAD3568390BAA7C18E24396ACBD54CD997CBB62276929BD1
      D34AC0229353580AE868AA832B52FA383E30281B5F49A4288D8424414BD22038
      5EF5997E39C3D673269A759E6CEC3CB100B90C0E8DE68E649DE3C9DEE2D934AD
      6E67B47B3510C973DCB7B89DCA3D4976643997580CC90B5782282E719EF7A24A
      D458F0DAE186A7015CEC729A3A78DF3A7FB48D98D694699B04B35BCA887D0F9C
      64588B64100E73B6085142697B31F0B1D41CD20BE0002B64C15E5C1C2EB4E327
      86845B6A9D80289ADC3F54A13267F48F8C64BEA818AE809224975C318CA13241
      AC165224088D1A823457A28EC16164DAF55E288399E1AD62FB38E3BCC8C9DEC5
      2529BDBEDDA7B616C731CEB5C180EFCB71DA27D832A04F7401DA608A77D4C065
      732241B10E97B202E0899D461F0E139ADC53B289B599087B907502CCCE483C00
      20D8D1485266C359E14D3689B28941BB08334B10E9D377A289B1E6E95ECE8667
      D507171A1B57CAE42C6B7BBD94470E9FCA78B2F966EB02C087D39A2FE399D0D0
      5CD11B947ED15ACA4347220752875C164B4F22405397976050EFD1A7728BE2C3
      BC081F6A189DF7589EDF68F6C98CAF564CAB3840E4D0CDA9C15EF048ADC96D31
      F6CD8D52EFEF539A2443106D10605BEC9C7CDA60AAD2ECCBAC56016657B44143
      72173613A47474A6185ACE98B9DFB27695EB85E43DF935F176DFA084354E2B9E
      389AB0C796C2D14F3417EF68671E8D0F329AC06FD01DE8BD46D37624CEA7AC4A
      5214B6FE5029F222ADEB559A78E58A48992AC23AA661E65D616DDDE00E774A0D
      1F625C8B53FE23D3703406CBA766D245FD71B8ACC87221F5E470AFC63154A72C
      3008F4CC778F03B688B10869296B73B0E59273FAEE6101DB28FD0509B9D2C073
      A3F1EE255E9B8F04D005DCF742565AF6C0605E3AA3CEB9770F136841576735FF
      DCE7D6AE41A4E75C0F280EC47134463FFCF40703937EC309CE6B1043BB66E888
      A0810DAA50187402FF8DDB28A54692CF4E357598FFA63A0EE949D7362FA8E1AB
      348A34B0DDAF8C0BA81B4619205306CEAA948F38168A14D95FC7ECF6487B94C6
      5F56F4AF098A35990D99E900A53465A16B3EB2612C3D81443D1D8B972B1E16DD
      87F5CEE787A4640AA666BA99DD102BDBF4364A2DF987C38B930EFD732C2AFD38
      0B7C4E3A28FC3037EF72F851CA43D8D274920B1F003E59ACF70726F2354794CE
      A381F7F3EBE3FF3E7FBECAFF5BEBFD02AD6172341561C3FB7F20D2F4FE9FDDE8
      76517768BC6A2BC2B652531821AE98B0A13F479458B1AE382DC4B0D39122B954
      874C476951493FD16B8441161A1A02E7E458A9D22B2E2FB31B602B735FC9CBCE
      8D4F1682477C3684C97BB41ED85BECA40716C28F6642BAA16F803EF50C5FEC94
      AA28EA91BDC8DAAC7C83E62659074EF9BE5A755CB625FD3235E40A4DDE09DA29
      544734EE4761580F8A91B6A8A726DCBD6D697670253DCC3741982A71086D83DE
      B4C40F2489F0C893F2FE1FAF48ED9D8AEAAB66C8F0207DF2547DDD70473F9A27
      E085BE7B405E97F164A1E0E62838968B96709492F4F1C7124F9CAF074A764B91
      17F783209BA6552C78EC87BCA56B2943FB8CCAADD4D0932E5D0D4FB37D8C2FE2
      E26E792B0C5873D4CA62C57F3264992073EC5B0A842C9DE7742C7683EC06A59A
      7818264919DF58AC269C9F4A5DBFE412804F29AC5AE66FB606466B04674829BA
      9E814DA007D7EF3EC81055C7792706B3DE70230FF5118BF5FF9119FDF96D94DF
      FDE2CDA9F85A445B3F8A7F525F82368560194E1F3BBBF277CC228EA9C0CCE137
      B08E9F6A299A438862C166B38A6EA033534768C102980C005FF1947680ABEAE6
      5687075575385702AA1FDDD1686E87939C9F3409B03ABFDA34A035EADB4F054D
      84A91267C2B60ECD0DC2CEF7C55E984E4761282F1C843D94B824D3213D8AAD0D
      536CE4C2FBD5A8989C02C3B6D630C7036FFFF2FC182ECD284AC23AF4CDCA423F
      7F78164531FF0C9C805FA4AE77A1961BA9963997F90DD571850E4A7A92FE9344
      96F3C6D9C5D0B536E9AD5957F62FACD2760BF996976C86F61E18A816D45B72E7
      7B7CE86972A715D36F52A143E7DF0EA49EBC0A626AEB4F4B13812DDBCE5395D5
      B42A3C3DBCABA9787FE8D9DD6F7026F01A8084BEDD3AA89F0696E9A825876AC7
      7B7370DE31E9D6A3CB931689EDEF53AEA6E780F14402D61B5C6E5BCC1EDFDA3D
      6FCB8564D1A10413BD51529529D33D882517DA7A717671F1ECF8ECECD2F62BD0
      D351535B6B5B3016BC2842490F4B2B421D7B769AA77032065EEB024D435840BA
      2490BD8E525BCDC46DC7280AB260B836D246A336B86741364C91A65A91B6CB88
      3C98D69187EA150FE52BDED193B1C7152CDA188187980A30D32F4DE6478E61AD
      5495C1681C812CA57258FA69C45A322238F06FD2E1146E0FF0841896DF3A4F45
      360599769CA728544B42A6E3142E269B8D56CA535C3E541A4DCDC9A5C03AA19F
      8AA9D4BC3C41A9601EF9E19D5B5DBDD15DEFAE29EBA72D5F75216F2F51CB7B6B
      527D74B34E859B05F12041CD6A06A5D2950537767B3C9CECB5693833F00BB00E
      A404F8FED1A783A1EB03A97528A20A8EC124DBC3F83A0EA766513226A7030726
      0D65803FE5F231DD03FDBBD23496D53BEA6829D7332F551F94FB92B22C6D5520
      492E9C065C72180F588D097F01A3CC54F5CD988EB19F22DB4F07D4882CDE361A
      80E2202E5581DE29A699294D703E76E04569E3AAE2367B77013CF151F29FDC1F
      3E499F1C007D80D6C5CD28AB25F216601473CE90A339F813A6D47FB691E2C100
      504DD2289F75318147526FD076FD0BA9092055B662F83F4CF488C3AB29F7382C
      D6FB4766EF0494CCF0DBF2928E55B68C5AFF351D4F489DB7E6028B3464D1FFB6
      A6BBC43BBD1F04D0E1D13DF86C1EE08BEE11D5FF281FA826D270632DD2FB9F24
      E053FF9A4EDE824C54A71AB5210BFF37D7F62F49455C1E5E6C3EBBB8381474A0
      B35E07BD643E3B8F51383474AAF811482557854D45397D6FE444908163083FC9
      D0043ABB09F2B34F62EFA926B90BF56E535FA9BFBC24B3D501F89041F6AB1E0E
      F6086EF60AA3DBAAE94470B940AD6A2CB1AED73E374D60F77C053122E14CA0E9
      7530E8AE787B121EDBFF890BDFF894F2FB31B78E15A3E96090B0B14B86AE69D1
      4555AC39ED66B0DB675E56477223A5734029049601AC792931771B480447A112
      B569A0119804725606E40971F3599CA2DB5EDA2D52C7CD39DD7B7B222E0EEB88
      2A7E1292EF0D248C216A92B8EA9DAC57A79B50C03BC8811AC0DD00E990E00FC0
      86B78D31F3974BC0BC0171212D79688C8E0315874E7A61AC07B4788756E5D195
      348D4146D2244BBCE4EF582BDEB94286675EE2FC7EE35E959ED54D2EC5FCDC01
      441B5C4A116B9D9DBCA653550D55E7CFFC8651C98731DC0FBDFA657D25F34059
      ECED3E9929559B51397B1DAD2CC61AA0FF3ABBC91193ECB7153CF26FD0F6B6FB
      CA8267E8754EDF4DC7837A11DA121E9462672DCE858F15509A04FF685A323499
      461979FEF2E964511D614F092DFB8D4CD41F5B495D790BD613EB2E57E23F7C03
      00DB154E014BBBE3FC119D7B723F81DBAEE8001D2C533064B054D0D39672BAC7
      38E076A234932CF7B57C81FABC5A51E6485E9A370BAE3AFB0911B272B607BD98
      855D4985D29AAE9A30585E3865702F03509E56D522BA983A1F782748C9596473
      221770A7E274BA6831FAF8E2B4A43565862699C58EADEA9966445335CF60F3D0
      B60DB1635DCC70EF47321C0E0B530DAD7F6486CFA303FA70089C81CB916DDD01
      901D0C9F15DA3965591DD0474EEF6C4EF6B66D174E7C6E916730E6365B457E90
      D339EB15D8FC59BA88687D7CB9734939E88D4BDF9B70BB16C71A178BDFED7069
      39F2E144836F32525A522B6A5BE1F36BA0446C4A9A538DD6F50D2365DD6455EB
      3DE9690D489954936B3C92B94F3E08B7C620F725F7C777D9A86E9D44C043E5A2
      414D6B75811984BE52690F9B7D929BB47342CED5F89468BE8A38CF3E637909C9
      33453513128BDC06E3DC8564217EA47E4B5FC39C5EFA1E063A19DDF07A46AFD3
      ABCDBDD8627718EEFADA8B2B80069D7971E2E7D20BAF445AAEDEEA2AB1AF8B7A
      84A0BAF3442B24415B3172FFE066A9D4A15F5C158A349346E49BCD8E855D5467
      16A4266E6C0BD1C49D34E067CEC366F521CF13F732FA123A356DFCB5A7DA59E0
      1270D1961D677A1DA647CEF5D11B75693AD8AB203F3AE59BB4FFEC1DB29ABD20
      050B66B5374A7DCC3C2AE62A5EF0E4CFF55E45C115EADA4B5960A1A150372321
      1D5FCB90D0DBC76AF43943B3653FEEDBB2F024F1416F787F6E195E801D3ACBEF
      A2CB6A66926712D8C0A288B5190D0D6DE64A43E5ACAFA813967227DA507A7168
      60B4279076741F6FF8E6639B7A6ECF0C2337A533744CAA3F8D43ABD21223D9BF
      D5992AAF22299BB04A3DCD59232C56EE322DEEED4B3E863F475B8DEEEB91FB9B
      525C5DDC6D3C16E84ABEE33DA550280A1824A9E10421CED19CA6D9DB55A1F3B1
      F545674D10D70070A4C316023A663F64139CA5513510BA4D0C9E1F72F04B698A
      663530F3E282DD68568D24626B9A5BBE8A44A51834D60BD02A6F8B780D1C28D2
      E0564D9349B4C712A11F5E48CADB1766E4F2359EBEF7A22BD70C69999A92715C
      853BDCE0A5192D69887C35F293A89F72BF2D901680A6ABBF886AB4FA48DD79C7
      A6E1EDE16C09217CDFD38382743797B4CB5C3237136DDAE77AC901EE2B2FD1D1
      C1D587752F5012F9458C54A5132F194281E5D97438AAAD58DAAECEED2DB4BE41
      1AF9C00AAF81E0A97A984E969744AE33E334D9FC88B9679FF6EF9EDAF6105629
      02374E77B1421169CDFCDDA8FAEAEF33F3FB0EC13CE6A6D2C264AC9ED9BD6817
      4A4DB0ACB5B4F95B798173514F4C76C58AC21515625033B360FBED3F74C631C2
      223AD95D90C369CE1E2DC88B0C5B4DAE6D0CAA93F0495B49B16875B2F874B9CC
      EEF915CF102454488A8C3A32319BD5E6D971DB9ABA43014885F94E5F1D4C13C8
      19CC76BC79F3A8AAEEE177716FA5C154D62EA4ECB852893BB26A035327A64AD1
      570801A501F430560306F1A414B8906C1871CA11CD953CA7E62498B93BCBCD4A
      AD90F8B72B0C55A91203673C54BD7555C6569790D73EF1EF6A9D21226E357554
      7FA98E73896F826C7949CB505D955044CEE8F534F72C80815A2F1AB10FBB8B5A
      CD8F41CBA8AD456B15C5271620D0C191AA2CAC8547261E190BCD80E45A91F9C5
      8CB81C402EF851B4034847467258626FA838CDDDFCD9AF5B03865115236C5A54
      4E4505B6B52DF7EAA8CAB20DD6C53496B49241272824425833803D079E19B7B3
      4AA3B27AADE5CE35598B8DF4E155F18203AF9CF602B582F763944C3ADE69743B
      2DE8D0A4F97F15973F4EFB1D148BC21EE840C5D3F9974788B7FAC36891C4D5DD
      6524F910E4FA4C08DD5AD128D6BB89D330BB3193608AA7FFF11EF8C9806863D9
      BE67C06A15B0373BBC99817DAD56E324A37BFA74BBB0CF3FACBEC7AEA5FB7BEF
      9FF4B7DFD38EFDE79C991FC44F37B6303DDBEB9FB10468D87F0B78C8B405CA5B
      7CF713164552ACEDCC5D19F8FE77B136B0A7BCA7E43A31C5C808BF41C7D5DA52
      1B32D7A09355D54023427CBBFA1DDAA01A1899EE3C271AC6006E1B9BE9438DE3
      440E05AC0573CDA7290705FDA27172113D49426187842D5A18A083581D980499
      F5924E333A1DB20913DB381E931159959B96CA6529FB6D9A34F4ACD01522F37C
      102F2FC95F8B28BF864D7F1EF9C95336C603A640E0F80A9BD5F20D41FE87D7A6
      4203049B7788962F9426C62C2BC04E374C3ACB4BE6FC7CEA1D26634E3CE67B6F
      9E14B573D55111DE7F67D3DC586C022D4D7EC2B464BCD9A25002AFAAF43E4B87
      1957334F81D45A5B7266A92DECA28F4CA4446A85C6E01BC96AFDABC86A7DFB41
      59AD6F7F1D5989EA5BD8816EB39CC017D6FA660C08A221C7989BEC48EBD2B47C
      396EA95C15B3681D30A461753F3D85245E6960E45C560C1354653572EDC78914
      C7CD90F09AA8F02C07AFDE5EAB35326D2EFD56CAA4311BC4DA488B3DF275F6C8
      AC403F779B5446EB6FB553AA273CB0598E0695018C7420722E640B64D538DBCC
      7CD5EBAE766F3BF49F75FCA7DBEDAE484245BE699A714D805672C66C54B5254A
      CC416E89872B4FF7D439DAB4704AF7359744C54A5761D88604417546B816435C
      D9731635231F2D7454DB2E8FC631AF1277192DF482A91999E582B77C49237AE3
      84E3275876469AB2B99C3DC52D86B2E3B0EE512D8CF52ABB836FAA7953AB1C7E
      BEFD45F645453650563B9A11EE550D3145588D7C0BADA91C9BCCB1C373200C67
      B9456F9DE1B5D20D55BD49EC549C4C12541DF3CE3263C3FD4CE931DD98936CAE
      EEC33D495F8EFD549CE7D9FB9B37551076D327601C096C7DD1408E83D0F55E8A
      D3204AA270EA19AE95051174DE08E8DA578B26516AABC979537211A5BA2B36DD
      4E3E3F578E20D33D252D73B750191F05CCE2E63B1A282D55844C16F683535879
      5F3A5E5BCE39DE05D7B13FC3D631A7C36BC589D622E73B228954697E8099CB53
      0AC36B42BA3B1E4FC7FA545AE6233FD1FA24ED72D08F6AB82E7A48DAFB1A6BC2
      72BD692FCF22F0FB9981DFDDEF3BF07B61D6C4535E4BDC4CBBBC941696A145AD
      AD4F5A3CF505AF678B8DB15A1E57AEDF10E643B613955388EB0AAA0CB4147734
      6BB92D2FBD8C990D52E38A655C26B643B9EDA2DDAD540C0D75C99A4AD0B1169F
      0AAA032A20FE3E35462F2DA63E439AF8E34CB115E4AE964C881F58C4BF4673A0
      58CC7C68CB9C2676B8C40BDF68A4C82FA14345E656EF955612C507A4C0E555C2
      63CB8AB88AF45BFE5A926440DA38AD09971F236AD1966DD59E20C8565C55E9F4
      673444AA90E9C518D55FCB4B4F5152D447DF9D6602ACC0B9B14F167CF73797FD
      9129A22DC1CC651EE4AC7DA6498E14BF8C7475C4BEAFF342154A011BD3B35FD5
      FEA0D93DBBBCE4EE5ACCF724CFD83ACD04BAA618E5D3F4CA2B32CF32229BDB62
      740EAAF3875EEA6B2CAE8599FA507A1333906655FB2AC3A78C27259D43D9CDC2
      66759B813E22AB59D7314A3904F3CCC6626AD4A3F798E86AB66DBD778E5B2116
      F6E5E7D99774DD776D5F2E2F91DEE66A4B863B825B5EF1E10AF905AD1C66BD05
      9E1C5A466891998632833ECB2615D949E594EBB75F44693C4CAB4F33347D20FE
      0A85398AC3304A1B76DEB298D82EB6787C0F8AC9D4430B5BE608DBD5C86DA5E3
      EC5496867C5764621A489B281BD31F706119D22B5EA14F5C3527B49162E03B20
      58EC2AB80F2C9FC589FAC0C489CBC731C38856A598290CBDCDA8DF35F3C4D6F8
      2F90D43F1056466B811EADAD83BA4CDF5A99CE8358AFB0760D4048FF8E43C6E3
      220A5AB3045DDE8132D48A66D85CAD55DA2B68A1D8D0FC580E8E0E38489D0B24
      1F4A6901A93C6782A5E3EDFE2B4A9E885E6B9425B6378FACFD82B6DE742261E9
      9BD4BB8AEE56844497866F79BF2517A4F683BC93A9F5B741087284A7523B82C4
      92EDC6894AED3EC0425D35E167199DA517E6F29DCCC114A9F3DDF200624B84C1
      0F479998ED071331705B144B61A13B3E99816F2FC139EEE35F0E36D275B4EE0D
      88E3A24F79AE72F888D01EDAF0821B944FA3395677C79BA685D6DAE36E85EE58
      3A49851DB858B169647EB01B81A65FB9708BCBF64BC3D9FA07F3B9E48E6F7D40
      2B752C6638B7B34C1407D6EC243EBFD72DBF5141C77286DC98C270C41566F3C3
      2BA29AF5F276776D8BFE5DDBD958A7FFAC6FF776E83F1B5B5B3DFA4F6F736795
      FEB3D9DBC5255BBD355CB2BDB18E4B76D67B3DF9362EA1A5B5CDB759DDDDC545
      6B6BBBABB86A6D9DAEC37F37B67B7C5D6F6B73EB375D6A34F8DF1AE26ECFF35E
      D0FFA998E9C77DCFDB332D858BED28DB51CC4CBBEECD167299E0B17017CBF6F1
      966DB5609DE52BFFB3CBD75BAC6017CD4F143DC742E35C2002DA064BC90D81FE
      D9ABE72D788D73AEF19191F3DB7242AD7C03E2B8ECD16902DA7ACC7E8BD14A53
      90A687C4BA40998BD8070C8E57B3001676EE03827C597123B0DB72B9F0796B5A
      E82CAD5CBAD2EF77848BE07EAA268F2A96DDBEAFFDD08A839ED5EB168E8063EF
      220CE865E4549E2A08CA334C073AEADD3229BDAC4A4F5F45D1C4309021ABA3E0
      035AC1888BD51594AEFF5A5F8C685484ABE049FB827AC2EC43DA689767994BF6
      27E34374D40655F8F1EC2493BB1DD28D3A1E8644767521800372F72785FD337C
      5F79DF31FA501DBC6C0770EB32D31801BD7A302DAA0A33F2BC85EF6E5A2C42F0
      9F1B829FAF90BE9B103CA8F24EA1B7FF9317ACD90ABAE4414DD1AC09DF2B931F
      DE9AA1F04E6EEE580E536530038CEB733B374FFFC3682AFAC98E927E7E3B0794
      BD2143DD9770DF4176933E97A8A219ED033309B1CC1BEFC2DE7860168E0CA471
      808348343CC3372A56564D989FE093FEEFB0420434EE0496C79BC9332C4FAF8D
      8CF58AF74CF19C65E1DA0FCD59B92207AC1EA45CF5916BC17151D2616F0F5701
      F5D2009D8D9BF163F7C2B07ADA23BB18476911E5DF8231FD6109F623A62CAF90
      BFC51531A29BDF44E374D19810E94BBE651ADD70B591738BC2EC8396D70E67E2
      A22B52823356EA254D389CD5AA1DE29491C6433797F1E8F46120507C74F609C9
      FB48710756ED272ED7AF39EE6FB360EB1B360445D0C7562D2E9ADCDFF28B83EB
      C35D04057A38104B4536DF4BFC7E9414F7CEADC5B155D56A39626A57AD752650
      17BBEE758D8F5B0656E75830958702D2660B310DCB052FF70F80B2E55872BE90
      C6054EB9E86CAC3C7554B13CABBC9B2850276C4169D5296C2B8421F22E32188A
      0CBDB0D8559FB8ABC4D3073D7236CD03816B006EBC72C629F0A9015154A8FAD6
      CF075134F985F6E4E40EC10C938C7B86142480AB1600D2D526E414AAC3BDE7DF
      135FBB263F91F58A9523B094F20AB26F166116E954DBC4A61128E9B8F019AC49
      3AD998565113B6BEB77F787C6C6A8E7DEFDDF9F101876CBDF3C397E7D5DF71D5
      8A216B8B80F7ECE777B5481733532A3F230254B3EB86EC385637B6852F270593
      D191E882C95A9494D0B41A8869A532511BAB98737B971C5296AFA59681EB8860
      2052C74E97B6A9DE308D2BE8C6049C8D7D98A92937685760FE2C0519AE6D5561
      5C1A8CD76285E951679EBED0360F6C06074B5CE4B7D0117A5067B6D1B4359E15
      52852E4E676479E7B5A1A30534D4D63F0920BC69B9C7F6CC33863FDDFF698511
      4DA1592AB4D21AC5911C9551F898DE7E23976FEB28FD1BE95926452ADC195A1C
      77D552FEA090BCB685A030A6E76C0380E270224D612E99532DA829664D54E022
      A11931ED3EA7F6202DE810AA7232ACD9CD29C0BEFADFA454D81C25ED3FDBB3C0
      FCC99423F906D8BB227DB577157C61C6EB25539B1BEE828099C8B867515F6E92
      4783F8B602219FD8FEA078362755D2512B2C0D11038D499CA18FB7A51BB1258F
      939FC99B853F4EAC629F7179F3D28426E4C92BC67293BE776350D46C752E6FC4
      3D85498E5EEA2E2A2B56D60A775BCF461186B082337E6A6523888F411F5B88E6
      77C26BFD5C1269862C81E7F0F4ECD25378683FBDABE8FB043B95CD8DB1024E56
      E93515A8FC16E715E5EB82AAECA35A4CADCF60C678F7DA025D47BF2AD9F5CAC2
      969F556EF765D4AA2817DD8261C3C6C1C0BE0FCBDC1AF9664F98E57BEA908FF8
      E5CC96C12E35EF1049E9A4B25DB845921629BCB659D4A69DC11A993BB06B1F14
      81BCBB619E9B96C8FB8FABDD59393C6806870C678F168A381F8BFE568E366E09
      0858000347BB28223214B37993D2B4D4EA3719807E181B668B6094C5C230D9FA
      EFA830B48C2D569DADD3CCFE6166B8EAEC56ED3375420FD07998D1CE7D7F17D1
      E523035157A5ED88B62E2C6E47D1AFDD7F8D1503FAF2619957CF537E907A4452
      8E3906539C3D963B4C9857734FB1563F4B3D48AA8E8B18EA1E678D75A8A3540A
      89BE4A261C1C8E37A585113A289D81EA0BC015BE86D3A0EB9E9E372315C1D954
      62BEEA4E85310BCC55F7E56CE426ADF56FD590DE57435A5CBFBA194EB7DCFF09
      EF2406BBEF4D92E9304E5DD9DAFEC7F1347189371667D3436713B770A9F508D2
      38ECDFC38BE3C5016423BA5056E6302819747EC6DE1595624DC5FFF0FECFCB97
      2F855486B4E97822C9ACCA721E0BA8C6802CEBEA5BFFFE67FE5AD7D24D0DC86C
      AF334494199639596CA9F36CD54A7572A085F1F7FD6CB0F348E99DED0E23D5BD
      30F16676D8440395402636278C5DB8057D87B91E8A2A7AE224323EEC00B361F2
      9096FB761B065DB01B4E804848C2475C4E89CA213E40998AD0FACACC21EE0365
      0DAD4403B46F3B6684D842B2D616E8131F5F78AFA2949CF284C9C5F15AE3880D
      22AC8CB3D3BD135BA3D3906DFADB56A52C2F3D7D19DFBE8691461B2B0DA2C7CE
      F73F7BE4321C1AF069F66D870CC5F5C8A37E2AC5F158FFCB4BBFF729E60936C3
      AD3F9B9BA37EEBDA1D47E9288C9F37149D84FA28276A6BF9C5B93E0067CA58C8
      67156B9EA9EEC6871727F160818DF909552D893F91A8EF2957E6DB5A167F0145
      AFBACF0AC6ED0451E27186B3FCF9E92F5E7137EE6789A6A7EB88B5810859BC1D
      4B7EA992472022273B6A42EB56E21F8AAD221908605367794514690B53D8A19A
      4C923852B249011CA0A757F835EC3E8DFD3B8D5A21939CE5C30C41AD3A54039E
      8BDE0F8B32AB26161E12646C50F5FDE08A64813842DEF5DA12B2D742188D3DE9
      BB791CF1803FC79D5869561A9232A77026BAF5B962403E30DF3438DEDCD91597
      559B38397402A22037B4CC7E5CDC608A1C4DDA51CA0019B4D8988298210010E7
      9920302C2F4974348C3AA6B248A6C8CC85B017CF4A9FEB80682933E06496BADA
      081F1FEA30DCB981734BB6ECA19937BED42F9DBB20BE08B339F2D3C236E8A25E
      4F532FE1BDB9328488B340944E8B11DEDDCDE7081FB71982192E2A242CA9B0AC
      411A53185FC7E1948C7AB3D898ADAC7E07B9D8E524B6229C7383AE4C54B5CAE9
      7E41B5017CB967DB2958D5B954AC7585A014880D9F0B29EE3DC34A96EF255091
      1117E873B351FD1E661C15F7E8116311C4A6B9C9AE1E2DF2A205D4D1DE259787
      D40AB2DAC452781B66D3BEBB084DD56554C4584FA88AE32A342E685B95849ADB
      D2CA851D92C82BE6020B69A60C95888AB5E42739ADC53B01ED749FEFCD6B99E5
      1C9FC4C8D135B9BCC40BEBAEAA68538D4702A5975D00D37F023945A9F12B4F7C
      DD97D0423FD2942CEA4CDC82D0565D522DAB354DB0A0129B69A9AC60C562502B
      DED6D041D08623003A0C6FA067AF6EFDFF64FD5B83A5C427D2B8E35660D5660E
      1F9C0805EA0FDEDA62E57FB485B89AB0D40182AA0A290A555C8B7D50ED036B48
      5A400E8E77CD6E811B73FE55A92DA740A5B0A2FD40B18AF6A4588A58D72E1060
      A81A389684F2844B3DBB329CCFB577D28A1493E8CA8CED10F9C1C8793DDC9F5F
      8FEEB0BC54BF072E581C2A9FDA2D3720639A2D70ADA361CBC0D6D12CC061755F
      1DCC950EA87762312BF3880DE6800DFD1CCB55A30A881BFB02F5B4BC240D9E74
      BD3205714A09B54543D0230FAB1DABFE5FAB28F1979FED237FE158BBF98AC5AA
      48336D0F309F58FF86EE3AD4667D1A4841D67CAAC964696CC0CB19BB9596C490
      6CDBC27D6BB3FB15283DF0A523CCDEDFE0B723BE3BDB21C190A74275A85939EE
      74C804267A56967027ABF24D7A4F6D36D3F314C9B8E28EBCA231CAB71ABBC11F
      6813EB57F1B6AFB2BF9FE2CD5143371BEC7B48C97C7D15C34432ACECC1AA6BA3
      700B8D529DD48F1D897D6851FCE631D8E5253BFF55A197B54AD422BEB0509EA6
      248A160FC762B918143A4359EFC57B84E3AA8E6AAD2655CA558A6E795B729C8A
      5DEAE22A9E14E669AFB869A47A1E87556AB63C9E280508E4B2C6A1FDD22211FF
      D17C1F4DF3719C5E79CFBC97673D74A8E0B7C5AED77E7B5728A6B00A87F3CBDE
      C5A1F14AE33448A661759E1E69FCC9D46115BC3CD9324709F6594F0AD0F4CE2E
      EDA0969D71B124930EEA1F40F2DD9929A6AC2AAEB53E2DBE17EBE3DD8640979D
      E40FE3DDB75EFBE5A8C5B0456AECC3D7D00F4DF712EC0A5B380E03CA3C25ECC0
      B4F11DD36A8E5702D6B44C8AEE65500F52573A25F5D643821F415A48C6E09B68
      67CD8EB1550A352274412BB7C9239E41CC036AC6A54CA16FCCB3D2D866783F1B
      ED17EE675BA5F04D8E02BC106D8EAB6F8082501D07B380AD88308F25C2FD5D1F
      8F5F1975CED043D5D7ECFD0D47CBE7DCEE07B0AA999DC51C7FB2B35E903F872A
      55FACB311445BE38B43EAD48C564A7DC448C38CA556A6C10DF2E78FEAAE32C41
      1DB2A7A577287A9E2B2FC7B11BFBA1ED42BD276E5BE86EBA06497F0EDD72AEA3
      544A33035F09C4409CA96D0A5A2A0E82D21BB7D06D9AE239C3944B908E2E4F38
      75C629168358E37C8E8EDB6930C2395C2967AE1788033ADBF0ACB818575ACB69
      33D48C1CE26D0ABD4EF2D0D9AD653EE60DBC632994B8D7CAD0C755DA60794943
      CC37A65741A3DBB3D929D5A373600AE85D49A4687C6018F70A89405BBCECCB6A
      2EAC7F0786510D78AF567D547954E02AEEC416F3F8DA8514FCA0BCEC9928926A
      9124A639C84B5B7384A2A360F0435C5E786F4F68D11D78AF73040E4A4E510F64
      E4AD8B329F06650BF197D61EE376D247E68F9C2C97BAC17184B5EAFA104C21FB
      49F7E900B01F2F9FF7E332474798AC7C01208CA49E92551F72D85597D851696C
      BB9A3905FCA3B7277B072BDE4590C713DD31CEE0DCE8E99B23AFDD274B020034
      9CDB04727FEE0F9FA44F00B9621369B325FE47E920B3F90E1271A8E120CCB098
      24DCBD3062D294473F74EFE87F4FC7E3A7248A3745943FF76EE985C3E8F6B977
      F7BF02EAF6344B3FADE2EDEB0EB41DCB165F5DE45F3F26AB37ECE2C0ABC8F2A3
      0386554DFCA11C243ED7419316E5E69985552056011DD29787179BCF2EC8A555
      C7F4D9CBB3ED2DEFF0E0E8D2A822A753098779857FD431AD6396A26892C759AE
      9D49C1E44CFBB62A2FCDD6B8488D94E95A141B836F8E032D6517302793DA04A1
      FAD1CCC9EFEB97BBDE0BB4459775E7590A7AEC42903816C850C49810F66E39DC
      347CCF39E0BC1A8864D9980BAC65DBCF4CCECB5C658BE5F72A5F9DACFB21A2A8
      651EF9744A98774084EA068415468834359518792CD63D376298150287E3B900
      BE7A9A10398A373B2B05F916B3C488AB9D661CCA079227DEAE56E5C53900DA29
      0B25F329A96EA9450BB42193DCBE672C707466D07A5A68972D0BDF2F764B65B8
      4A5C5812C40F4831BE6FDAC40FBD6EFC155F98F6D73738DFAB0A5131021D3885
      3674B364E15172B9E246CCAABD5C8367A85A853EBE4C175BFD6388D462BEA3CB
      1668556DCCC4F9199C009A2F40564934B78A7AB6815ED5F1F6F67F3C97B471C7
      3BDE3BA5CB5EBF3AD78B4FF7DE9EE0EB7CC7EBD8B70E43C628ABED15278CC9DC
      74703656161AC5DA2B22AF8E01059BE3A8D5270B62A47DD4B393E644C2151A01
      5F4230BC728B35AD656C0FDB682F4C6EDCAC2E4D30CCCA8896D68C7DCC1FBCDB
      8E77E702F6D73AE74A0B7E58447E8E3A19E675AB76ADBC3AFADE6329FBACA134
      887920916DD9E028283090272BBCBE38DC2D7506F5BB6A9C62C0C14609600A5D
      571AB155048BC0496458E9724E6E56C47357B569C035ABBBEE125B5C341A32BE
      2E0E34DDC16B73C910ED320575E46284E4CE9866759E5192BCA0C2752A63E701
      61D60AD867412F1CC161A46E70C897D8169E52D4CA0C7D75E73FB4E3A593B95A
      11DC1D19EBED3AD2B18998092D3B126A6CF2151ABAE109A6B7C8231B2CC2F7E6
      A6390402006124CC5095E1908A2E8E51B83360C5F2C86E332BB56F70AE8E2332
      D61770071FF5990D79A706DDACBEA0F5572D73E93E301B66711A6D55B09A1FD6
      0669148946547A50EC7F47D28A8969358138B561C73D603886613FE0BBBA146E
      886AE482E0652025AB1E6A65AA01BF4CCAFD09A2E6C5F3E3E4A7AA17512DAC49
      240DE02AD2FE74A8167CCD51B56FCDCE6AA5F22A7984B114918D0D5F4EF59151
      7612D977BE2D47201F00B6EED5400AC179164170F5482523E878AE8DBCD1B439
      530B28156AA76A5031A763357EBED05F5ED2C6091E33BE82A3119F812E2717A0
      333D226736C3222CF7D113C0A4462AA660C4E0E7F0EF92A986824CD380537028
      7F8A749F868A169AA72A499B2740AB15DA6C02227D44865B12174071AA27AC55
      2191986953728136E26EF7452E068DBAED2E2D2A549BB456A582D5E77673A110
      DC767AB1B26022A85AC9F79103258C920D45A9F20BB14B736BAD09CA53F516B0
      CE14949BEE2C25625584A1BAA3A2DDD7CA414C8356C583C9C56D740734F2F9B8
      A6EBB55F0898042EF16BC8C34E2767354631D444972B0C451D87EB86DE623AB1
      1D8B420F21452EF5BC1F4D591C4462C62D2F65C388CB516CF58F3F7727E11331
      F1AB83C53D95F8ED308EB184BF61E2E25CD08EBCFBAABC56C66314EE4CEF6BE7
      A14E03F76452819AFA412EDB31B7263704CD22009DC4748BDA97B64DB08A31CE
      C4EC773EA1D161A18E3F017F07E771CB087124CD18F3AAC2165DE0737AD78CF8
      DC38CD27CAD1B4698E18F9354A0DE29BB9C50474F5FD28F061C9C525B3092062
      57D80BB9C07F84323A55A8A2756621116A7DA606CC5DB33964DE89535CB98C9C
      575F6C9C8FCCFFF1D9C12B9A33B52A177B42F6C45B3F673C7D11CBBCFA21951B
      4AE0B8CF3DBD4205505464E91F164BEEC3E2BD1871FE3593B37E92C5EAEBA03A
      648CC03FD78F909594E50BDB5817E48934561595216223B8AA6611DA1D30FC40
      9E4F27B0276644AC25606D6BBA212678EA9FD68C205B080A8D1FA7535EEB2158
      4C241DEB768C390F66268BCA4CF9C0DBDAF2314CAF970528BF32CD7FF505806C
      BBFE5AE188D7995B513E7595E2B67396D3FDC564DE38A3498E01EEF602A66811
      FA9276E6FE5001C51DF89C8F9674321D5BFA7D3C4F86614C413D9FC81D114B3C
      1EA68CABE15BEC365BB6861A0149BE934F5232492C9A57714D3FCFAEC4684DD5
      3CEF7AFF9D4DE5D8BBE280751F1E0AA7BB6F2A6C87858A7960C3BCCB7246A7E0
      96FC13AEB8F39E553429FA176C97F33729168830B8EC253197D4787F797371B9
      C84F3919EF996ACD99DE0C08B2C26CE13A466C8A69DF4D9FF05E37823EBEB8F4
      FEEC94928BE4AF0B7CB47F411F014648DBA3DCCF8EF1D971A6D95FFE64E581AC
      59411E2699A5065386AD47FB8E4A5DEDA4CDDCA5E22F2F7121647DB998EF3C40
      B080BFE96A5AB0647DA2D7B6379990D294EA536E2D3638E04E19F7621BDADE2D
      879F77A6A2B9626F97349941F7CE84112EEB67B75ACDEC92FCF2F19CC463FA11
      F9B9B8AA10D7BB98EFF2FE4D1FE663F77827D0B9A6EAC100A2020BB5966DACC5
      DA6DE4439ED631416C930DD697B80796D579003DDE2FAE2C66D74C553EEC0F9F
      01079837CB6B5F98133B8C8B801616987BF52B55EDFE4AEDDD4583189CFA20C9
      0AED11FB9C775E5EFA17DEDA7D5F018ACFCA99D2187DAEFBEE2A717A4F13BDE4
      B657C6B6E898BA25411FD36F73EB9EC9E923878EE97E52D053A260EA24D2F9C6
      7223E4B2E5CBB6A91FD12EDF4D3D14183C32195385BF372508EC4CA99D348BE3
      8FDB2C14E8C75C29163D9B92CDD398BF35B42B092488C8B58890AE1728CDA3C1
      495C603BB4FD08358FCFBDA39B3E7EF8136D43B904BF416D3D47DA80AEA44F2E
      B2BC940F8BE7DE8B2C4B60C9FFD9BB046FF19FBE41F7222C1D85A84FD52A2167
      A6AF2F36B1BD8DF75996F987699E327373157807509AC6DD2D6304F35B6871C8
      A3A3F2CE99BA62CE94D949B9BCE0B92A1E7F3AF082929D3570DE4682E84FD217
      E47413BF7D170922236E469A2CE27C7989839748BC3011A31708E587E72CBC1A
      59A4D58B8F3B2FD5ACBC88E810175CDAB6AF38673C31FAF327CEC3D76F62FD66
      12394CC3CF90C7A3200FCFA0B5C2348085A2393A64E54C19ADB01578FD69BF0F
      2C74EE321B71B97FE4F0BE8FA6C30879AF4924E1232E1DC0E5CFC490E0F23E6E
      C824C581CE3517B6D37D9924BE826911179FC08C589D46E5EDEEDA16FDBBB6B3
      B14EFF59DFEEEDD07F36B6B67AF49FDEE6CE2AFD67B3B78B4BB67A6BB8647B63
      1D97ECACF77AF26D5C4247DE36DF6675771717ADADEDAEE2AAB575BA0EFFDDD8
      EEF175BDADCDADDFF408E445F0DBAECF6BDF00DE784E5F1FAFCC7D4335FB27BD
      A28F3D6DAF7EF68CFC31FB9BBBDFABFBACFCC95E50DA022A8FBF2CE5A734E77A
      F59D753068255677B0DF19C45CEDE3DCA3DA50731F18A5A1F9C5F97161F2187D
      44672493531C2272B93F8A82ABE32CB87AFCE3F1939532CE82AFAF96EF8BE14D
      9A7C0B4190D936A38FC9F1E43CA59288047839685089907151C64C7DAF2D2CA9
      EA4294704D3DF2829BCD8B2CB9E63B23C08E5A8B9B987BB3A457DA70A398AA17
      101055202A13A7F4EBF14B6ADF6579125E4CFC20EA784F503CF1F3EB5F9E74C4
      D0FE0613F6F8EDB8F385B0D6D9FC3C317C5DBB6A66DD42B3FBDCDA9147EC4B38
      55952B0F3611DC60540546A575F4287D7A67FFF88D169D9A67E8407A8BF4D837
      528F34F86F30EA531F8D9ADF64DCEAC46AFB28AD8D2BC1304AFC61013872409B
      33BFA284C5B85AB856F186D60285CC5FC4883E2CEB17D3E10234A616479F058D
      C923C57AE94F876EAD075715194E08C09EC54CCC82C432B82D7136331ACCBCAF
      99B0A696FD4982C8DC03758B8A9166EB27FFF11E1F218ECE13F47E92D081AEB3
      E4CDCA68463A5F492FBC27CB6844B7DF781FF6F987D5F7A8ECA2FB7BEF9FF4B7
      DF977EFF9F7396CF207EBAB18539DE5EFF8C7544C3FE5BC043A6DD40BE1A7DF7
      13565652ACAFCF5D5EF8FE77B1C0FE6D73BBE73D451C3DB8E24264E09E64CB4B
      51913E2945D509C04052FE50957A366B11D018B7688CE715B92ED74660805AF0
      5C811B71C1078062865AA107B498892D356BCE88B769C4077EE9CF1DEFEF6394
      CB4B34CE5D1AA7F464A3740563E46E9C490E3A640EB392C71D641C18062CFEC9
      DE011C2E831944AAEDCDE5CBA73B1EA24DDED360F27C5A0EE857030DD52C89FC
      DBE6CE06C903E2B069322DE7F1F32B29F4916620CDA4F142B0DD039CBD6BD688
      B10676A0C198C0593C4384D62544C8DD5864D427CC481694A88A6A177C7AAE38
      95BDA8EB2DBCF226B3619F504AD56CC5D45AB3A44232D9BCB72FF248C0BCB46F
      639CA5C045310D1609EA9EB55B430AAA03DA22C89B17713935F8F68D130314FF
      5574D7CF600654550671CA2A8FA7194329AC9470E4356E9450F6764FF7B30498
      656935F38329763788C7B486BD7103DCC10E3713C6507A02031007482072222B
      23013C295CDDDEE829DD75478C97A6B18DB23CFE15B1B344094380151C20E056
      9824483F2BCB6C3CCE0AA991B96BDAB8775769DC303651694BDA69AC55029E9B
      1C0E2339DA3817A4445AE47B233E480BA10F7885C68D1B67580BA58220FF55F0
      EA560D4F59CA6E9B35B0E5A5B67557B986A8904698A736AB6CF2CF08DB493F9A
      397782380FA663F4AF05DC7D636034B5645C8BAE3540DC2CB13C241429607886
      143B2D7CFC384F4C49643800AFE3BC04F95EAB0A4DB6AAE25713436FDBA26E15
      1D4C217C2D24FFA0610E3D2D28814F01B91F025BD0F610DD313D688A3A7FE790
      577ABE1B5FB03CBAE20F144AAD444BA9DB2FFC67DDBEBFEE01BD24BE8E9AB68E
      E6CB823C9A9DCAEB41A83251C512C2276292C1427111C841F4719090FB5F01D0
      923235B2F2B5F35E9612EEFCBB10511ED14161E88898AA915B1BC842CED0638C
      BE8759AC8D860CF8C11DA2D1696DE0AEB609D88BA087E83AEE5B4631A8E18545
      5525DB11C2065B4A3772145C69F7B600E14A730E1D55F2C9EF455E29C35432CF
      BA536B5CB5D83F73DAEBEF260A0DEC685F55D1A6EFD4E21BF99646C53164BC7E
      9470133C7736364C2BFFDBD6EA2A47D8267A5CF95E4A3E873AA0FE64E25D2BCE
      B284B19B35BA874E6B5B1DAE39F1CC0153A0237779A9A8987BD05FAF974DD332
      4EB462D1542533841DC7D8B9E9FEF7209D9F5F9EF57EF15E9EEE9D602BBC3A3E
      7B01E57193674D1BE0C336EC87CC2FA61ABE0F41267836B0E2785918138DBB1D
      754DCC59568C99272BAB59B253C971C9685D765C942FFD4CFBB395236D4E3938
      25F62B1DAF759AC1F5DB4B9256D5A46853B1A671CBC149E68060030FA307D6DA
      1EAF0D47608CC7C2108BB68D4C9873AA78DD4A1DF9009C816DE0FBC0A6634E88
      15544AF469100D8B8F3C2424CEC8A301D82E0E1A2E37B935CCB07FD028D93741
      D9118D3F98965A8E20A02DD2DF6C289BA5374639DF0C8ED79D36EBA44FCA6649
      E401799CD306C8C6DEDEDBFA817AE3F412356C9C0F2CEDCBB3FDCA61A92B40BA
      F05D9C6E376C9CCB4B0F8C54D632ADF1D64B321E59E16B8CEF260ECB11835854
      D8B3751E659BCA22E33D8F7C05E393EF71873EEED33C5DF080A47E3CBA3C392C
      BCB61A0AAFC9A98D6FE9AF8CA30F940F4FDA31BC43496BADB02576FEE6B597F8
      FD28B1D1242DB8CF4888E3DF8D70F6B3F10407DD8569DBB49B46C15F1DB44603
      81B82FEBEC9D5D67BF1761BC002310FDE947C04DD0DF69007785B7AFFCC4B42A
      D82EE7ACD133DA24D95419CFC5DE08A645494A9624356E5C84EC018118C89CB8
      28A682A9E7DD1E4CC71319763E4D3914B2BC04475D7A44B99758558EE57E90B0
      6CB344F2A1983C682BE8FD25EC17703E6580E571A6C916681A0545814B8FDE58
      B2D795699A738E02A4FC7B91483D83AE05A00CE48AD8B937F169DD54C543F140
      00F792A4C21313AC962C099BB64CEE195CE4C489099AC452FA8FE19DFD04A09D
      B28260BB474FCC4BC6EA5E15613F1A991C06C387FBDCC7CEBDAE8F5E548D72A1
      C7AF536FD66278D01FB9E99F0D06B4E1516A46A767B14F577110832C0BC1D0CB
      7DF4EF7168985D75C34ACD3A9773BA77BC999A259007C4314D05B74148542089
      6B3F619D38A2B3E4C69CB3716AAF1CC5122B121D5A0852C4709A2BEFDCDAFA48
      6EA68776B3A4F4E0B271AAB522293D6AFF193F2B4A56AA2CC064B1D272117C45
      CBBF144696E8953E14F4C5DF8955226C271DEEA4E61F10DED9479F3C647552CF
      014B5B168E21FA3A79539A136FBF4ED8F1911DE7F2C04B1FD65D3615240B075C
      D86497794F6E7437BA5B7FF8C31F1A968378F8107F27B020A7D10D7BD173FC00
      8EC53AE7B81C65CEF7103ED3FC196EC10573D1A0E49C99CB9E6A50455A07190C
      06BEAF30664AD45F917C5B323B80AAA9126A731ECB6727B8CCF36C98FB63A9C2
      FFBD4CCBC5C5A1B5AE6C75824C802ABBF9EC9C6BB5882F2F59C8C95CDBEB354B
      400FEA82B70668B0025F3601A0DFC7082558835653A3E1B28177E0DFA090230F
      BB5131D67AC5C2EB497ADEE2B321B621BEE9DFA7E85CE03B344B2A0F6F8C5196
      58CC762D83E32AC0AB48FB13A436C841B9C31E08CA3C315573B3B9679C185501
      550DABB421D27AD06535B04E42B646238C2789702F5A4C4B832925CE1C574F15
      8FDFC6C80851CCF9860C3F5EF01BB4314AE513795F70617595B009D1480FF581
      3551318B701DAC29109DD91371CD21A5DD11FF8A36F4A6D5B83F9C29227DE0FD
      20DE3A04C469C01F05207DCE91CB0230D1508E92D790D335BBC22095AC9B943B
      0677970968627AFA611DFCC6226D8E3378B1A477230639523C9A79A883BAC25C
      94C899E807134B0A71C70DB705D710059B25BB074F75E8E0A75A5E6629E06C3D
      94CB17811410334638F440D517194E180568BA0E1D33DB0ACEDCDC4AD850AA38
      3BBD59627D78492AC61956978B64D899ABD6B48ECCE2665462F51D5C592D5662
      94C96689E9A3F640ADD8B75A1F6250D6E124B95F7FC0AD500DD4FE1F5C2D063E
      D3EC1DD7E9D7C957CE0C6913E5C2A4D252F2A0655CA5D42CB9FCDBD6DA1AEA41
      04EE953BDEB10BD87A26C76222098E0AF65308891A37C6756DF634A70DF7C694
      C8641E5E806E74C2C03AD24C8239CFB8CA308FB926A459A37D78A507B95F8CA4
      DFD30F024D22F8DC17166B2D00C779B8FC5D167D4762D36C34D1959114F14E7C
      C4620576AE1FB187A548B288FDF84C1D60D904B43FD8F8E85028F639BE694E71
      28A8C4FDD22E645F5EBA5933F080FCC9AB68FD7C1045935F6C215FFB4C2BF9FE
      07412CE9BB5F697DB4C507057F49965D491ED2C42439EF6A88CEFA918A5DEDCF
      12D8184AC4EBD07E3116150CE126A2156CADA117ECB59663A8739F85D104EBAE
      CCFDB448DC613D3692CCEA574192E9EDCCA6D62C924C6FE7612499AB2847A068
      63EBB3C4AE11D554E80D250CB0D15DEFAEFF67B396C6B74733D9F8BED14C9697
      DEA8DD6BFA0D80709B85881B7375C7EDC5A1390EBBCD9A7B1998E51ABC3CD8AB
      38661B399220A353571A902C572EA36A9D6D74BC97A76FC5277426AC59A354C6
      2D5232DDD566BDF9ED56CF7321B81AF2DAC2094806061B76D77E1E0BAF1EFB41
      1893B2A3356B5415647E235F1FF69F81A1F90A6FBEFE95DE9CDF13017FFBE63C
      96C1BA977DF4A05DEBF5FEF59396BFFCA9476D9C5C3F80DBC7B7F94E4EDCBD30
      744861B986855B530283D8FC350EDAC79AF897C88B1C5EBCB63EB3721C47C128
      55D266C517E5120AF2B21B66462C4CC88F0851DA165FA16D1121A2A3D3976742
      6FDDAC79A679A0BD57914AC3D9D676883C9220B1B7BFCFC032CD1A185E1A5994
      2C472041C3FD0DD2308BA3E5D38F1694C161951A652C495DB1E8B868F0E078BF
      E39D71D723029ECE27871727CD5AD70BC5FC31C57C7978B1F98CB5B371F25F1F
      9EFFD4AC59A6D365E31939B7BF78A77B6F4F547D356B08876901AA02DFE0A94B
      EB3A5A5211B52DACBFD2D0E884C021931EC911A0BEF1398B160DA5D00AF1892C
      0C9592B761233B500687F02EF5C7714006BA94EA83E42F4A42431FAEBDB3862D
      C7F7C6518E96FA895F06A3AEF70EE168D421964FD14A0EA7DB4FA4B7526F2737
      8B07DEAF519E71A326275B80B55A00992F13B33A91303DB3F00065DA56B36968
      5F1F2BE9932E48799073490A69EE464200851331CA227129F7A96564931B1274
      9F69A1F99DE86D4A7251065A3DA75783CF2A4BA36ED372BE2F2EF6E8C1DEF56A
      77B3592F8E60C0A393AB3C2DE80FDFA2D46E6289ED78D54D7C699A3240635276
      7F1579FD380542481CD2E2878BA9357AA63595DBA3B8440F7943F97257909D47
      7E318AB455CF4F8269C287A294C59E1C6C4A4AF4F26506F8F824EEE72E15DB22
      69F4AF268DD61649A3CF342C7BDFB761B9BCF4F3C5C5A15896FB7CECA1E32099
      F6BD623A41C6DB6BC3B9502764A5032B0028C98E1B0ABBC03829B4581EB983F1
      8FDD2008BE01D30E1455B3F602F9109BCF68B27FF15AAFA214E501DC7A7AD6FF
      5B149445CBD3A48D9094366C68D6B3D041EC95093095260DB4C1153AECACA743
      692212C3C5D55D1E8FBDB7E79CC67C09FC8569D9C3EFAA559E93699B6AEF335C
      DBB7E73862BAD12D33A1D1E0AB3F74F017AD45927A90A764E16E5EE7F8FBD341
      D6A39FACB9D1B0B95E5E124E763AA09FC369D8791A926F456EC028BAF5C32888
      C7641229C08972E0C48CF27D1D87D233D77A81C0A6B27B4064590E823AE5986B
      8943D291EA62BD9161F4AE3AEF18E9BF6992E352EB1AA8BD4D5BC46988FACD14
      2ED2384EE8C5C9D5293A1A42E3B27D7284D2A9511052570CA3B4BA5F96260DEB
      376E9D4785F07E4C83729A47ADFBE3D53274F93B574D4FFC34324C7163E1DB76
      9C583FBD6B9A83D832D037262D375F0CE7D100900E682C0CBD17775C3D7E2325
      F8D7743426B6B8DE66F7B4F8845D12209E364B2CE836208BAD0D65FB3F6404AC
      9CF89313D0A2E445B7BC2D79B3541FFE651A15E525605DF9435A0900A8406928
      974E335386807B7000CCD4E909520EF61A20A892291796C28790AB9A25B1780C
      3D6B83301E2795E2061A14D78AF6D39F0EA5B485271BAA6FACD5BA0D1B50EAD4
      55B092B761D7BDD7471C5BA8A8BBFE566469C74BE301A9FF31E299B19FD08F49
      164AA8611112F8C290C02220F0990181CDEF3B20F0337B886AC05F8067860EC3
      432D5654EBBD6936818EE9E2B0B12E953A85E24879BD6A229A34880F9CA8821E
      8FD67C4BAEDDACB1FD9E0FD9C519F96567E45A7763714A7EE629B9B538251767
      CCBF3008213035B90BA4264CD318A7FF4D5FB4C4112DE169908DC7D0D709970D
      9A6062B346DEBA501AE34F8EFB346B7C1FF7C71707D4BF7C402DDCB8CF3DA0B6
      BFEF036A79E9F76C6D7339A44DF6B9DA7E9864374C1918A13CA461A3B259CC97
      5C8767B1FD65AA049C3BF239AA4A436FE418979774EEF0AFCE9F7F9DC561E10D
      2529CD800279441E14C688390DA7133ACA90AED60C16F8EB241D5674D8E3225D
      A6B69856DB01AD1D8140A6A062DC2606F3167EDC0AE41221ECC5E1F1A587C7A2
      28E8730F8F9DEFFBF0A814D11EE34DBC7E71B8D74888B3DF4D0EE7EDC9DE01E2
      4AAC0FA3F1A4BCF3E826FE5DC38671AB1A1F233127D98B8BBD8612D09AD138AB
      4CC14901BC100197C707B48BC0BED0D3C322F02711CEB5660D94548139AA51CE
      73B621BF2D4ECE2F3D39571727E7679E9CBBDFF7C9594C80D5D4E0B0BF740029
      137412F9578D7C7F431C4F7A183DCC5C977C70B477DCC4B10C92CC2F4D9D4D0E
      B4DBC6B9EB7E78ED73A1D54916723B79E10D221F356ACD1A4798FBC3FF1B920F
      C9E7604B4157B8D3641694B5558B4AC43469D77108BA5C869A6CD6B0416DA59D
      360CA0C991F48A17AB5983A9F29A0DEED35C5EAA86E1E168D40269649F50DCA0
      F90DB9E079AB8C8AB23BF1B128351662A34928C266404114FFF5FE872B00C9C0
      FB1F32F956047E0735D8CD928E12AF174516C4DC0D691A20219447EFC1FB6317
      E5EA24FDC76EC3EB7CA3B1F6FEB78C75906D7C83A1F2D9F32D469B5E7F8BD182
      3C3E2D9AA7A2B9418EEC1DEF2C1FFA69FC6B947BEDB50E07A4D75710881E08D1
      6F490EA5D2B14A17F7BC4CF4E313763C1D67FA8ECFFF5D7FC051F11F8FDF4BDC
      A4491F08E3F0E3F77933111050CBC1A097C441F9F81B554D0B5A2C0A43DDACA9
      4BBF497FFED9F3479FA7E5A54AAD70C79330FA66D372322D950A879D1618841A
      F633A93930EC8DA701029B58E8D20E4C2ADA1F8377E8913B7F5B24BD6EF7FD7B
      52B256C7BE7F4FE66FF1FEBD69700DBD831808DB250DA43547892EB4D7DCFCB3
      7876E4AD8EE250E328654473CC12F583323348274D1B200627EC8408CA27B409
      904C66B69FCBF3C3432D0CA3C562F3CA96C6384A8738930D9C8B01B16F980466
      93EF1D8CF15EBDD8D3FF506031FAC1F68A372E6DA1837D17F9932C7DB6978FB3
      FCD9DE783C4DB54C73821454318AA2B261EBD81651BC383BB87C46FFACB35350
      51DB70BAD0A2804B83BF72CBDEB069197AD309EB6E632F80A2214BA60D6CFD17
      491C991CDCC1D98BFFF246248EA47126880EE57C0E354D1881A7A3621A733B50
      17F9B77F31FFB6DADD58D43D7E66026E63FEEC7F3709B8E5A5B828A691B7B5FB
      9C03A363B25A03814553436606AA8D1B9A0708DE2BCF1A2AC43C7F8CAB70B945
      660388AC41756ED879212259EB914CB4822E26EBE796DBB4956A46586454E79C
      0100984E877133C7B9B5FEDCA10DCEB3523C177A588213301F5734456DC7C941
      6E83D7480502006762A56936DE282BAFA2BBC245C4A8602D141BA3FDE8AEEE21
      36DDA33BBB4FD9C089F3710705A313FF1B444E7F78FC480CCF363020BF4158FC
      E9B71A6E9AA5D1B748033CFA78E3949453B9D22CA5B4BC04626FEF62140F4A05
      402D4A5FAA34C41E432CEA2A9E30495FC6B472AAABE83AF23EDBF056C8F5CE49
      9B95D340E11DE4AB649DD2EB303F109A9B04E8352AAE4A64EAC9C96BBEACD837
      874CCE7EFAA05E678CDE5428C0599C13B57A005A1B0A23AD1E8C02E80BA0D846
      520C45B70098891E1C981111C3EBFAD77E9C98B28546A2C2C94B33C7655CD03B
      DE71EA6848C69A5606D11C8BABC8BD3D74D869C0B6F0DAE87C60826CB6ED1BB6
      19C0E4FDC33ED092638C324DEEBC535438E0C599923A8927FDCC07ADE5611130
      DDBDF47F0875B7EC8B660DD9EDD452586AB3551189549F259C92713BF093C210
      5D005757E0ABB5A74B82F3E81D2A9A66C32A949414B0448CD52330791D5AC6E3
      CC7B223CE3F32F43A9CB93668DD72DE8A9D525390047C573843285EF8181FE4C
      01509BF7C8BB958EF72ECBC9A79D009DEB459EDD14483AEF25E50F2F371AB6EB
      ED8C4E10C4240715ACB4597635F6F32B3DD1B4D0EEB9C7A35FEB7637C9AED384
      966F2FEE78183F7F4A9F0D33AFEF0757CD9285D35530C0E00C1EF6BBF3E303C0
      416626599366371DEF49963E71B47DB3867ABF37B0DD8F68B41ACAEE00F5DB3A
      E7ECED170D5BD836746F4AEF7CA42500BF48A77B4A071B9DD742F25B2440FA97
      2E47DADA932402D2A79E0777D934B71868F14019011A2A8AF3FB0DCA3ACCF6BB
      CB1FCF3B1CD3EF30694847521B137F72974F0BDE0A1DEF55541E82B79A71E12D
      B326C9CC36E69CFAD727DC2CEBB5CB919F5EF111FAB72CBD09B71BB67E5464D2
      97C7B2681B61D072585EC28258C1E890CE1416D1E3B7C7AFBCF630C9FA7EC21F
      D11F4EBBDEE528623EB727E0FBF622129A20CAEEFF84DC6709EA0A2D61D6765A
      DCABE42F494845EA46196A8FBEE6B4D23648943D23CABF9EBF3AA0F1F64D7A25
      F3CE0F5FD2D2630A3431AC9BC85783943E32DE5C77964BBDFAEBE3837567A834
      77AFF7F67F22B5C3214314FE366D8CC8EABF787D7960D406AC00ADBEEF67E11D
      EAE84A49ED03D986AE3CF5D2E62D571EE67944977219C6FEE1F131EF49B60386
      D256E14B16837385830662D4CB99D07BA674575A8EC22374AD9FB3971797CE79
      E1B5D9EF797211731D925A864FD432621B69305859A44BBF385DBAE8F4FFDC74
      E97C9EC1EF265D1A1513A5DC516657942D9372E947832C273D528C9B35E19A01
      DCD87A0E8ECFA22467CFA3332F1F240A084F06E1308F8A825BB2024902224C92
      6470B0262668D6CC516F3FF7C4771084007BC6D3D907E2D312FC2E70390AEFE8
      F204DD9D1C38A5D3B286349346D974798956045D9036AE8806940A689B44F91E
      9F0A3BE85ACBD9B629FE3E4511543FA7651195F7A5A2C9F161CCEEB644CEF03D
      03EEC9B8E705F915DDA8EBFDFC7F5EC7E545994D7E699A80386072D04FF6B9E0
      2F4BEB0C135214405BC41F22D4E8F751319160E744D7904272C7C624DBFD9912
      1F0A367EC374059BF616E65F3B86991CF8A68AA928390646180A8560E3BC6C00
      6C888EC7E2370AFE0E65DB410950F46024D9B672A45913B68E0B5304BE296E24
      8C68A05CDA2F709645178504A69B26990762AE1DEFCD11D7FAE459321380DD2B
      0A288EB19FD2EEC83BE6F7BE09B6F2D66A5CB455830A7276FC75FFFF3BF7DA51
      6AEAA47E453ED126D7FE73A5EE3AC24B6EF0605F9F1C5D3412D9C84611C71CE0
      CAFA45C6D5ECE8FE4D9C93FFB9777276F0A243FF5E1C74BC97AF5EEDF1BF17F8
      F7F2A291639E2A01F2F13EF9F1AE1388FEA72874CEED37173FBD5653B6993BD2
      1E43DA5CC5893F9AE9EBC8F393D847A69347EDD1E90D3D05BDDDCC918AD1E600
      1D1A7A5C8E4D357187DAF0F69303F1129F28A1F228E2760BC7B278F2747DADB7
      DDDBD9D8EAED7457F1BF273044FA1173A6B2A2A29947C0471B54E44688D29297
      F3D7FDE377D58E6F96906692212D447ADEBF174A42AF0FB093A2654A70677320
      0D4F7FE8D05D826993B09082636C68A61268DEB87A959676AC6C5759D37A6638
      BBE6A1A1E8F84461BD7E757EEE1844F44F3E9D583E3ABF1C0D73409B0AB3987F
      DD386FBA36D839DAF9E4D5E14B5EA8B0034537FDF5F86CBFC9EAC80EB7F5269D
      16F45F936FFFEBC5E1418B546FDEBCA048D5D9294393D4797D2A4F5FEFFFBFCE
      9C24EC8235FBCBE3E60B9CBFCF8D9BAF7FDF7173C5C5CDA3EB67A7D1EDF25279
      12313B2B62225ACE304D691375BD3764B0F803986B64C8B13DC7EB2313DA4DAD
      5D47CECE9FA0F7288F9D2DD790D5721101BF95C79E477F9FC6391004A5AB88D1
      5B426E3725C519366C6032CB3ECD12AA4A1EC266C13482016670679BC59FC0FD
      8CA5A78AF3B5580ACD1A3B47B2F69C358AF253D26A91941E4A5D6DC3C6D4FAAF
      E978C20C299935D2C44C795298DEB74936994EB80BBE61833B4C119D7EA6516A
      6E7E248B537AFCB4E4BD61233ACE86B28590C0BF8EF29B3CA6974E51E4B071F2
      A26183595EFAF9F680961F18964A3F21CD1844867D3A478015E52A70F4477936
      1D8EE814C11F5E9B7425EDC3918FB00FB77614A53F9E74BDA3D21B732CA11FA1
      3566304D705D89F49647BB53C02BD8D66B98B00CBC015D7A559883D3813C942E
      5D80A023E85531D575BDD71A22A0FFDFFF89FB0338BDC7E9A96ED3AAE0E7D5C2
      7CA0585219E2017A7B79227DCE4855DC296CE7CA635AF25F60BBFFF62DE21726
      E7F3BC59EBE1DB9BE51BDFB7597EEA3243C3786B98DE3B7DA009A45DD1A9E7D1
      709AF8B0AC41C9CEC0882B0D1CA59B616D5F1EFB7D32324338CC1DEF721FFD4B
      C7349217D96DD3C676A1AB4FCBA9FC00607874AC7368CC74E64B9A98FB3B7F78
      C987148C6B710C49AD93A711D1EF7AD6A1DF69A57147D7B926268BBBB4F46FBD
      11E98B043A033E726E5BB6D49B581C4C7A3081F7AB581C4A9F7928F5BEEF43E9
      AD9FC7423E1AFF8ABEF4525BB6912C60CCF886A9B8B32903E34876EE77309E23
      0986AFAD6F76E89F2DFCB38B7F76BC36FEB9F10BAF856A376ED6C2A05B0B4BDA
      28AC93B80816FAEA33F5D5E6F7ADAF9697F6D1603FCEC27810A3A99A6102C713
      BF8CFB711293D7CDC64C3FA37F0E221A62ECFDF5903DF1BF1E6E18C8CC029099
      4536CDD1A48EE2C386290509FDBEF08BE81423B1018722F3A66921A11A616063
      534F91C1C02F3D0D406CA2F1FFA60DFBC55D19ED61585E12A5439A60723C7244
      54B80265ABE7F5E3B2586404BF3823B8BEBBC8087EA6D6DCFABEB5264F31A901
      A88AEB584BACC7593CF6539287F7CFE5A57FBC67C8C1F7832484DBF38FF77FC4
      8F28037BEC77F57EFCEFD787E7C747A73F79AD51594E8AE7CF9ED957ED86D175
      ECA70067EA92DA7F46FF7D7619159B78E7A74734C2E2696F6B7B777D7B6777AB
      E5FDF39FFFC028F22279781434E5F3C7314DDE0783F52F1ECE170DE19FB4B40B
      325B656DE327BC2EA99C5BDA059C12BADB5EDD793FC8B2527F0CB2A4B8C50F51
      1AA6A3288FF8FBF80A8A7DB025F87EB2A083E47D3128D3FEDF1EFF146F927A31
      C570683A8B53404FFAA675338C820CDBA97DAEAD1A7BE7277B1DEFF4EDC511CA
      9A0FD63B68683F6B5AA048477C784DAB0A6603627B0CE5E40DD15180ECCDD181
      54E820839CC4BFE20AE9CF68E4485F3E5443C62806266A2B2C289668AD5923D5
      3EBCD59EF79C868B8E9B0C703DC04F201B11BD960CCE558CBD367E188EB2A25C
      E1F49F4DEA35CE7B3680BB3B3B34E80381D4E7081FBC00A0F179131FB0F95932
      1D936B109740B3236B99C6053A3C869BC72ED7E62AAF1D4EB932C6F746BE0031
      E4111DA98C76D59F0E57005C41D7C780E087572E2EB910EBF8286F6B98FC74CD
      ACED92F8B0539697008033E2F4A51F86D81124D4A2F0FE7A7C7E6CDBD594BD0D
      4090525324293E08272B22B99609FBE8AC236324E796DE341EA606C5C394E41E
      5D9E344C6066C1ADD1F5CF3DCE15384067DCBDC7006885322F92528D436D712C
      BADE5E52641DB6D65AB3DF6DC16B05808028A386C9E5CCA92650121EE41DB050
      18B5854ED4122D6BBC51A4E4AC1FD16102AFA66143B53A675D370D6D997D7F42
      7E800576D63AD7547002B9EB97BB299C6EDF3086430F9B9096C541A47937FE2E
      2383F3FE413141010232E0EB61712D427F8B24FA177AB2DBDFB7276BA656225B
      A8A4612BC69A681CFD03A95208394EFC82AC53AF05569C967715DDD1A1DC341B
      0609690771D180C5367014B503EC510375DFB5AE5AE455FF153DB5F3BDEBA97D
      64257276176EE22461D3C6148A461E5CAE5B1A3697D2903706D327970BE312E8
      27D711B39A65348A3B4548E847A3386D9AFA527B787D13F6B0813FD4BE51217D
      62781B94E30317A661A3B3F6FEFA1ADBFBBEB07428664936F0CEC98A45FA5988
      D9181D945D45B2EACE2D0B888509E78852E2DF4946433A33600B8B03C51F6729
      3952A7CCB5C477AEB844FEBA7F7C6E3CA7BA64B511BF61B235925D7DB6B606FF
      BD9217B69269E114087ADBBE22AD1DAE70932CBB9A4EBC709A23363594769650
      D72183EC00258631E9A7691E2571034F57E3746E93985E0835A0D630BD314C82
      70AD0FB4FCDE0AA7001A7533870AEF4ABC4AAFA5D07A12836DD11A488CC1D45C
      F7716D0D1A65EFADDB9E5B03CD62441CDAFDEC4B4AB6B7EB5D482416933DA64D
      4F47879F981E1F560AD01F9A304EEE64530CBD88E3BC74CC164D5BF8565AABD0
      106F395C0D34359597685078D1F8EDF0E2847BBABBDE0B3FB81A726CAE62DF4A
      E271ACCE37B3C8D27F2DF298CA895B561A2BA16D3E8125ACED7B7F9F4645698E
      0B3D9E682CB90F84B5C2A88F41EE0FD1F02F7DC67426F523C3B74BE7C987975B
      137B3B2A696D91B40E391F506B8DD4D641C0D2091A15EF43244452FF7ACC30CE
      5DEF654C3BED0D4A2C90204288D30975C16F8D0603D4A55DD316B47B11F16209
      8009284C6325074BEF4C0D5D084E569A5949854722FD0BFF694F5162D00562A2
      E855E751D73B905D87544CC7ACAF989B1781F515FF1A8595F4141352E268E88C
      6F98F88CF010367E9BC52489CBBB49A45C0A644A2205319944E4D274BD131145
      219BAFB6CDFED73BD33FA5D88B2C93854BFD992EF5EEF7EE521B8F608336C91B
      CEC5DECBB0C8898F1A3855D51DA31A8C4940671559F919C38B3E676F601F0D0D
      0371D9ACABDE37503E74CC0197BF94AC9E2538E25701E34FD372FB95A266135A
      F997D59CD4424281585408279F8CA021589995CC29648A72230808902FEF9AC4
      609845058BB0E020C628AADFD71461EAF9C9BF917425999121FA4182D672ED85
      5A5B9432FFCBFAACD71036E0B535584C2DF824D3896E8B96A489FBD92D29AC60
      94E51211EA672528A5809E4FEAAA618AC7BFCE628086892B0564DEC0A7518695
      CD478A36F3B8453A8CFAD32142698FDACDF07BADE7DD59D4F37EA6EAF8CE91F1
      9797DEE1BC2E516CA4F4537A70C64819947EAAF48311399B68DF248DC1AC4C86
      7852CCA48ACD140732FD449FF989771ADD4ED94DBB28237FCC8E6931CA148B9F
      ACA1033600FCE2CAF3FBE02CE1D7D0539DF4D274DC30944F0B86F95AC98ADA52
      F567826D2B96B005C6A3E49BC774209BE889D8891081E9833E2067374BFB599E
      7A07C7FBCD9286CAA2758ADA1405BB3C3A68CD2B8ED45864B3C677897169158D
      85D8995B50C3633588E2CD1AE49E3643410948EEC861A0A53F6A82EADFBD9DD5
      D551B386C649B688F318E0FA4A625A9F4196B0F39786865AD0D474D251C08D42
      CD24D65D5E6AD569832C3894F4BDA5410C63495C31A59E3CDE3B3D103E3A9607
      FD706417795B8889EB8CC42B5DEF2C75581915338C71D1C48AE8289769FC6BA3
      698A8F0CE3DE5C587D984D4CDFAAF5290BBBF38BEDCEED85DDF99976E7778E2C
      692DA5379A7D0F633FC9382F59DE4D0CB939A345AF75779A35F9C7D2C8123D0B
      23ED6989BC6939D8D1FE17C4B7723F2D92AAF747BB023ADE285E5E1A8E923BD6
      B3E3B1804A92164579E24599F38620C168A522E018357D5166809851B0F56689
      4B7135E9D8105BE2994D551457F1A420998421994F0A8FBED0A65FAE4DB716DA
      F433B5E9770E08663B6A5E9C1D5C42A39031C2C66DE8B5CB3C9BF651F4C781F9
      03FF261D4E81511B158DF5AE5F5AEA3350F3ECED1F6AB1B6E015F4E30953C5B0
      BFA90985238E5A54600F39B8E3670B6084E249A32064C7D9F6BC39B794E6AF2A
      872F01100BC0D824B1EE69091BD380D170F0835326CED05E5CBBE2205A910330
      6BE52E8847BF5C316F2E14F3672AE6EF1C144B1516F98B20A1E3D227B0FB1EBD
      3EB8301C7CA2B59A067C5723683F38044FB1D675ED1DEFFFE8B561BEB70E2201
      8A61ED818C131D43ADA61E3A7CB43AA47005634FE711B3652AF2215DB38E2D2D
      BDFBF4EF99B086E08832A70D026919F7FE23C54DCE8D273800CD124B35FFE6EC
      6000032E234A85C9DA8E1C6B814F0B5EFEFEB591960CBFA9E386A501046A675E
      4F84E4E835BBAD6D435A47F280725F5E5AEFAD7025046A3D6C191F20E6D32A04
      EE8DFC82397D6BA1A3A60887A19B8D473F8E0BAEAC616AA4E632203D08E870F1
      FAF0B8A1946DAFB99BF1699F11AFAA18667147E6EC98376E6B6F32A1552A2D92
      2DC12F68732541D5385833FF40920B8ABE326B98826F6947B90CB261EFBE479A
      F7EED7C83BCE86F2FE08B0E7799496C99DC935165F032467FD2B0D8A87E0D3ED
      ECA0789883752FFBA845B9D6EBFDEB26257FF9536DCA38B94EE627EEF936DF85
      6979717597C7636FA299E624FB1A89C5C79AE6B37E125F23FA793E4DD130257A
      E6759EA1320034F543EF9FFF0290D883105C5F3AA05928B1E7CF9EDDDCDC7453
      D4378CB3B060FCAD4C07F50C7F79D65BDBD9DAF834E4B019CFF337410EFBD437
      BE0F14F6A83061BFD90C364BB12F1CEB8F17B24A02161D67BE145A1799970DC0
      9CC37C86380DD92A8791DD3A43C6A405FF4D4C9917689445EAFA591EF974F33E
      1AA7ADFD4E6FDCF12EA2BF33BC55C7D3840EE76B3A5E5406DD86D9382FA709A8
      7826B0ECAE00922371D0DC335162F6DB2F1711BC2F8EE0F51611BCCF5434DF3D
      4CF44CA21A0D1F1EF97CA0B8A6FD94C07162BF502B22BBE52DD74F3208813037
      65DE8BB38B0B467CE4B89171A09AB554EA0087D7E8E5E42E0C87EE98F6C25FDE
      5C5C36725CE01D57C671D64AC0D69A4E3878D58F8029668BC41C3680468E748F
      E396CB4BE38CFB989268E80777DEF9E9DE89A6B510BEFB932E60853AD24F843D
      17814DFAF704FFBE3BDC7BDDE1A02F9D9F47170D2B51B5BBDB10B9CC1FA00DF2
      B110EA61BE695AF88348C2BA93BBAAD3DBC44518E4110785E88786590EA054FE
      C53BCD384DA1758107477BC71E9ADE274D8BE8597A39516286AF7D79A952614C
      EFEA0FC32C49803F49B7F082DC2FD05D02CA53AD77E77A780E99A9FD7970BCDF
      3061A081DF6B55D8422D65400515028050D472569E578EDD0FB204C75E3CD016
      0118DDB0AB1B7690D9EA4D00DF90E171571DE4B4006EB77A1A086DD884FE48B3
      E3ED5F9E1FB389CF268998FC8A3900B60BACEE41E50C2C0CFE2F36F8371606FF
      671AFCDF39C3813509F4989722540312850D24915737D24E8B618CAB8BE78B58
      FBE7C5DAB71A116B3F86D612EBB0E87847381B3ADEC524221BE1AB146E3CD68C
      D3FB3FAFBF7EC7FB31F239E455D2CF2FFDE06B75633CD690CEFD207AEEFDE8C7
      39BDFFE15DE44C4C63C6B02FB44A51DEA4973E8FA480BD49EF8C02730F94AB4D
      7AE99F8C079EA5CFBDBD7C9CE5E49446FE04B1E8BDF138EB402D2D8C90DFA311
      0267F5197BE0EF38C218E5A815833DFFE6E05C5C2FC1990107AF77E3B3654BA6
      4851F84331F605B3914E2EFFFA4430C59AB5526682AFF93D5AF8EEC2E2FA3D5A
      5CCB4B2F5E1F5C322BA929EBBFA3256EFAA942093D4B7C863103980284BCF6B4
      94751F0FB82BB5F4F0D4296D0794ACDB725BB91BBBC4B8D1D708CA3DA20D478E
      681903004FC079DD41E1EF248D30BAFDED23D78F3562A4143C5F21FEEA78C4D5
      C079CC4D1B5451F2C2BC3F8DFC41E3C664036BF6B461C0B3F48AA3E007F1350D
      ABCCF28685C017C6CAA7464CC87D8C5EFED59B8CB234428FD40D1B289A0895B8
      B9D6CE3A15F1CD34486C0BDAF252512F0BE6A121EDCB3BBC2DA31FD34993F069
      1628330FB4332EFD935C57412BAB9E633CF1722A161D2975B4980DC80500CA42
      B3246697C73E0F1DBA2D2F9F46A910A131A62BF0ECE90780AC5F1CFE45F20F6D
      34EC01E256D21236D3220C063ECAE883A869B2A8FA8144514A5939D755370F60
      5CCAFDF77FDC3365F0BCC04DD9BFE0B28DFC0414CBB494A5AB1FF9D303449C4E
      6829DF216DD6C8411F181E3FCE856A6EB4231BDC1772478511ADE9066E85D05C
      72C3C67D9A71BF130397CBA05AD8A057B05B6E00BB89DF04179E46DA6AD8E84C
      1A94FB92E865A50B16A00A0626274E194219ED3A61458FD690E16937C7CB38C1
      218CA3675F13D8CB4BD237D0F54EB332120055C96EC94C0FE42B05F91180AE90
      99C7544F72B0359EFD848EA652E4A3D78A843A0CC12A6DD7821EA730ADCC0D7A
      1B9706CF7598FBE38E60CADD7B988636F0AC286F1EEF88CADB015A32E19866EA
      800B013ED6F8121BF5B530D533EE98C2EAF97F4936E442B8E924637EA2A6D14C
      0A99169AD8C0A604A8015EF9BC33C8287902E0B73434D5115218616006F2AAB0
      C02E658E510847A7657E155044DC1B7B826FCDD00DDC5B4557F013F87E784CC7
      9B4C4B2EBC48DDC28C3CCB4A539821F6B6F990C41E05D392EFC61615DDBC6D1A
      2FBAF461C7A3F97A2B3F4565B00048FD0AE500EB8B7280CF746EBF739A486DB3
      BA905EBA8669317025563C1852E6447AAA598390FE4C32C7FA8C6BCD589B8051
      C0C2288159087CF72C6F1AE1DB79348EC67DD2DA93AC502A3B52F788904528B2
      84161FFB4C0BD34083B342E8913A34E54D62F3FA62140FCA1F0EFAC97E120757
      0D1BD8CF7B49F28BF72EBF8BBC177E3112727B5409291C72FB9FB3FA699DF5D3
      EAECE134E87DA5B7FE63372A265D7E8F7BCFFE8D75E30AB6A29AF512A56126BC
      262ED89FF78E8F7FF15E1E5F5C321C8787979612D77AAAA191C33A3C383AF07C
      668A2A2AA85B9B0A6AD8986C3CD16DCB631583CA085D8E89F35985C3E8EB0205
      D1963955CA0A8BB1618250313C4D9E9B1CA707D0481C23B0ADBD82061A8C04B9
      39632A0441E5AD0943A0D89B3570BB02F684500D2147AB833540CC9146A725EB
      19FAB6B86D8BFD52AD6E8F00C33EB0DA1BA36F982C241E29F5402759F8133922
      4727670726226BF0E6117CB8F67346B8ABB81F1B39D6D7C707EB7520A67BFCB4
      7C2E91B5485BA28143948A1F61B69344B04B9BC4D4CF0350530EE2DBA68DCE84
      1F4C022DBB41D5E3289E98F52A8D95347D68C76BEEE82ED2ECE6CEBB897C06EA
      753A2469CEDC9CF85E5E8EC659962F622F5F1E7B59DB5DC45E3E33F6B2F37DC7
      5E9697E2AA556BB6F00FDB47021A9C50E47C22406DB5E669B19FBE783F2D60A2
      3F773F7DF7BC972FC1AA3C2D4FDFF24E41FFE6D8CFAF94ABDA8023C7032F9C4E
      C847E4421569F4A5AD760D525CF0D8705F54B39686709B7323AF44A4922CBBE2
      BEC8D2030A9EF228379387A885167428494173295A964C61944D93D0318F85F8
      9727382AFD38F1AE63EC7A0EA9C281E63AA585E6FC62CDB9C071FE4CCDB9F9DD
      336C868CA2EF058859A34DDC37CC579A8E354D17BCA36E46C8B78EB284C313DC
      93FDB7E978A270547ED948D8D07B3A94D50D063889F22BA34151E785611EA6C8
      7FBFCEE2B461C8C6CB4BE2795FB0E7CD10841C3D91BFFEA07F7F8D211FCA9099
      5F1D7550C0EEF53D660C08411ECE814690269A3A6F8B9C8A1B62D558C8052E83
      6C96A050E556DB11285ECDC914BF739124223E806EBC6C12C16647CC8D23B59E
      3FA451356BC4CB4BB207E2F429A37E9BA1D0721762EAE4CE0B109EE1710619F8
      D64AB386109665232A06280CA803FD241EA238C60FD0437E233C9C917C960213
      3CA13F2B255BD30CAEE5A513E6C690C62D1EBCFCE15C8932606948E7838628C1
      55F24E3AD89E7BA3985990A25B126A0CDA1F3FE9186F8F0515D037178C135F64
      A9AC7737BB0BF48ACF3554BE733E5F8455695B1545949716B47C79C9A9410EE8
      13D415DCCF022CF6D1BFBC8FD616FBE833F7D177CF4FF8623AC46E7AEE0D92CC
      E7EA95098C593ED6FD3C2E84BA0FA64D824AE8D660FAEBAF77ADAE77090E6BF4
      ADE451816C2BB61A5A21AADB2C2FF18D481EFD28975BE84D1190400568F4F7A9
      9F30C6225904D974C886C19D672AD4D5E548E231E800A556C80F82690E1C3FFA
      5D2DB376CFEBDF95D1CAEC08388D5474BD17524FCA55D6A0BF42B76C20CD475C
      48CA5F2BC461D150423FB26F27AF2CA123FECB428D7CB11A59FDCF6F24C3F9A7
      DAE7CA7063EB411992801E94E1E748AE751EC9BE51F75B12FDDD6EB7F58892FB
      0259FDF67A0B6032F02018E75A0B3CA4D39D965AEA5FC74329FC28F328E260C5
      D3FFF01E12AACA74EEC7A23724E4C84EAEF990149081CBEC47083C42F398C087
      B4F6810507C1673FBDE374761E870E1D1F37F58F215DE89B40C1714289B4E83D
      56D05EC2BFB166E49E424F7E135E548E64B3A633A360C58C02FB221A4C979712
      D39DC24ED998A63B063D36F92553D48F94A6A7894EF0942958C59351DD3B9896
      D33CEA309F8F9FD0BBDCF8295795F8C98D7F57C01FBCC6A07C0D971B5A41AF1D
      75875D4F5AC45E9E6DBC16505052C677B0DAC821C407295D08B924FE64C217AA
      68B56AA50237D0B7ED78A65972EC5FC1A3CAB59527B504EDE498F3EDE14C618A
      96974C2198FB004430F010DC455C5CA1AEA73138FD89B37586FD87D675BFC665
      F015B6FFBBBDF3D3A3D357CF1FBBD27179A98A7661069CB5EE737F4BC16294E9
      909DC133A17D54DC8E018C0A3A32850D0D0EB1B437D1C45CC946E05A01BD05CF
      DEB4E0851817E6AFC8D2B0176D192D79F1E2DB613489D2D09F5D136924E8EE7C
      5DB9BC3402BF0F3D16D550BCA5E8335A867C02E9F6011F87AC27D9DB6566875B
      DB73FCFABE746819783CB242680FC3FCB0E5D87BB43B3A320AB307B0CA389504
      81C489E10363A0FEC4CFA14FC290FBCBFC1B32315ACC1EE5888C3ED71619F022
      4F27F8A9F7EA85ACD57C2A7C5AD3149524BEB7D5EBD3D8CCA369C2DE717DEAC2
      EBF9527365A3BBEA1DFEF5F5E1F9D1C9E1E9E5DEF1C205FA4C17E83B2715A623
      92F7A29EFDF02B1092440993F4FEDDABC9E8A8CFA32C8063E8A531827DE25538
      8601FD8BAE0D4067867420C9694D5AA125BF06DC7CABBAAEC53BDFC716BEE34A
      38BA3A80A223E7631A98E6DC4906EC9F180001741E47DA558116563DB15BFBCC
      5E86C8FB21B766B72CCB6DC3EACCC87F542384E3CDA9A3DB48D1B84059D66218
      674569F04A956F523DD571E4A78EB5C30AB68834685DC0EFBBA195403AD6AD10
      B0978771885E48FEE08E7B158B2819786D74AE607253AF6A382CC61D6FFFA202
      C0E0325DF52B4DE2A06FD439464156D11117E15B4C757C209DF772A0980954C8
      1C412837C7199F294FD34C70FCE9F5B19FC6919C9E7C5F36DCDC9B6337425E45
      A4630D0CC4A1D8AC74CA9378AEA26822F2C79D8B95DAD3D102EB3C7E14637BB8
      2FC0CFBFACBDBD92884A7AE4295FFEFAD5F98198D9919F27A06A31BCD4CD5AAB
      E840B3E33418F971C816503CFE6A00928F38A217D3218A3839E7233113ADB608
      46591C98CAF37E24181806D0492CA8668DF49256E39B545AD659071FC4345792
      BF3453AAFA422CC7D7485491C5B7FFE3B9F7F32AFF6FADF70B56FEA13435BFF6
      590155D6DE057D533FBBE0CE3712EBD984753777C1C917D400A4C774BD57B144
      C5D4589DC8234DA50B3062B8A89F369C4C81EA8BB0538B63D9749D148C336DBB
      4C9CE99EBEC9F284BEC431B87850C5DF969726D88882349747EC8761D6211FE9
      2810601069E4E38CB0D56D742B4E7E85E64C32BE41E30EA0794B63CEC260058B
      F8A69537F755C18A9076243EA98C0C3BA27F93F84A9AD85B42CAE13D39728D02
      49233EF1CEF984AB0E712FCC1AD7C872694B007800A447E86C1FB2C450A87753
      786ED9098787C9DB4465857A542265B227A14A034E182B5C12AF76BD348CF48F
      103CBB99B25E83046D411251601546AB55D6BA03EC31F24359BA8CF85175C02D
      FCA67FD16F5A5F645D3FDB55FAEED9085F21C27361D03EDAAF4E2E2E57647762
      3333868D3D718A2CB966F67034AD65022A92E547071D8E898AA5D03045B6A745
      2E7AAE9D4743B16B2D2A1817F28B00D85F1477CFF75E22C7245F5E28962F562C
      8F9A3FFAAEB320976EBC515308DC2838F6FF96E52C396338F8495CDE6924DF09
      76F4D9CE479E546B98E8865A9684753D1E9399B9380DBF70D1AE751780399F7B
      167EF78499027B66522583384750054985AA88800E3AF295C563607BBE598BA0
      1AA1EFADC3F1AB8F8E4B40FD84836EE02BF74112D4AC11226E639122D00834CC
      F23BAFF5631C922F8680C649167AAFD01AD4322C79E49AF423C5F063C3A65923
      668605C372480334569947C7C529AC3B59CC085A0EA3D209EDE06FA924F86825
      FB0C285091C47E157EA06F418E37811211C2C7D77E39A2C98E9BD618B547F3C0
      C9EED634055069DA32616D78BF1C53925A28ADDE472A550D75A60568D6689797
      2E6AA104F2E7DBCC84CEA47F31A784D5222F33AFB88A271D44B9B5C1AFE375BB
      2BDAC110B825241CAC6B5DD80042AB637F3BCDD248B233AD2364214ACFBE41AB
      59B2F34364C331F2A914814885BA697E34ED1AD9601007C831296048B3062991
      EBE75E757A057C62DD2C2FE51952F60680950CCDAA1A87ABED2D7F848487E21C
      EA0111509345F1CDD26A735D8F086E85D786E688D40897E5C5776B96F4C8088B
      72C0A79437917F5565D6229449C4C5588F41A9B271609682047F7252494D1A34
      1F8A03BB5EE27BE9B8D68B699C38415C2639CF25B1D3F2DA7EB8BC448BE8EF53
      C4F37DAF2FF5AAB4DB62455F226D1B4402180E236AA5EBED31510047376D9D48
      488A465994E9AD1018D6C785DE8BBB568D53DD04302B7246DB8C5401C6E4D5F7
      4104638B6F9A098B7352292A6428FCC924419256B95FA40EC654FD07711E4CC7
      304983C645CB6763E1D9F212D4499EDD98B813BB445E81C23B5BDEC84138749F
      81218B4B7F6C26E8A6A81AAEB88CDA84A20462926B02054A6B1C8DB3AE7791D9
      3A3B180C915FC41C0D205BCFB07D032C38CBAE1AB6CD9136BB435DF9D03B7A72
      CDED89C38C5E9BA4D0C761F0A745ABD5178639160D229F1BE6F8CE496FEA017F
      E85D694F0C9DDA2652124D73FF5E9A6C2A3735C37C7B8DA215AEA2DACFD250B1
      7798E8810ECB90C72B7DAE4D0B71D80846E1B5D9E0175DC7A740E2D3D1D9309E
      AA2AFBE4147FDD77F3C49A5BE1294C329FECB3287C26F8215C0DEC7BDD322A7A
      383B2D7A3D57EDDBAA8D024B7F829800D607873EFC42AB312CDEA2D7569FC900
      7222F13FF10BCD796983B405AB6C98AC5F1B1338E7126926F0B1ED960C2FE387
      121EAC44A784305598704856EDE25CFDD469F96FB2BC7E82D98503967FDBA315
      7C903189C922E905F1935060BDB1418A0D7633CA68F1A9418288EE4146C63F79
      455D527C915FFEC1FB910CE3C1146523E59C62D007C87D70AE19D741DB10A4FF
      E6B62A7CF4EF3589CC05C2FE7A30D84F8FB03830D6A3312F8A4F6A110110F757
      9B80AAC0B463FB2AB93F5401A447EC7A445E8BC5A4580716AC099A709A8EA469
      684093359258FB9982F7E373733A7F52F382BF46D65A91AC6FEED2BFF065BEDE
      52BFB7B437D63657B7EB33ABC222D16CAC6D6C1B965E9A953FBE47B55D14FAA5
      EF6DAEF6FAAB1BABBDB5DEEAEAEA16FDFF8E940DAED3468D76C36875D01F0C06
      5A4A18ACAEF37F37E4F7CD7E6F636BB0156DF7B636F1EFE660B3B7BDBBBDBAB5
      B9BDB119AE47DB3B5BE156E007BB6B41BF17051B1BAB6BAB74D1766F6710EC6C
      449BEB618F4EBFDDA0BF4E0FDF59DF8C7677D683ED9D28D8F6D7B7836035D8D9
      DD5DEFAD6D05BBE14E7FDDDFDEDCA497D9EE05E1FA66AFB7EEEFACAFAE6D6D05
      EB41B8BBB131D8DE8D36FAD1C6F67A3F5C1BAC6EF737838DDD9DDDC0DFEEF9FE
      60B0DE5B5FA7C744FDB57E6F7B33F437C3C1C6766F10EE223EB2B9B5B3BBB3B6
      E6AFED6C045B6BFEE6EA607767D0EBFBFDA81FACEF6C6CEF6CEFACF6E866BBFE
      E6BABFB9DD8FB6688CF41EFDF58D7027DA5DDD5E5F1BECAEFABD707DE06FECAC
      AE07FD8DCDEDADF5AD9DD54148E28C82905E7D2D0CD676A23EDD656D6327DA08
      767B1BE176B4B9BAD1DF5A5EEAAFAE859B3B1B6114459B835D12432F5ADF5DED
      D33B6C0C36B67A911FF4FC1EED809D8DFE46B0BA4B828B027F67B0DB23D9AC6D
      D1D8E8D7FEEEFAF660733DF27BEBF4147F2D0837770392D460776DB7BF1AED6C
      465B9B342D6B1B9BFE4E18ADAF0ED657FB3BC1DA7AB0D15F5D5E82B03707C160
      8BECFB357A40B4D51F6CF477A39D5D7AFD7EB8B5B9BB15F48390C6DB5FDF89B6
      838DADCD2808E835D60683B5DED6EA60736310EDAC6D841B4140AFD1DF1EC85A
      1960F5D07AF9D03AA3D92019F8DB745BF9E32AB9396BFC435F57DA607B9DD658
      B0BDB13EA075A53FEF60210DB67CAC2C7AFFED68B0B3D90F498C6BDB21C99B46
      B646AB8A6662E06FEEAEF636FEFFF6CEA6C9712339C3F78EE8FFD047FBE008D4
      372AF6B49276431B96B4EBD5D8BEF85200AA346DF534C7FDB1F68443FFDD4F82
      6C3641126C1466D65EC72EA49969B22B81CAAC37DF7CB34882B23C616041946E
      43F1ADD6AA1B4044E66F5BAEAF7A96B5495D479C09772E25A4688692536EBB12
      B38A364B747C4C2935BE37595B80D777BECD8A241B006701C1B175C9A6A05DC3
      74004FD37AAECB353A0170EF9A4125439806A354979C6D3B6F9AE89466154ADB
      0ED1CA289DB2D5DE0E8A156E06CD84DCD019EBB5B6A1A4105550AE0C01E4B532
      B54CCCC80C539CF22456300157725B52DBC752400D31EAFB986DE915F645F7D9
      5916C59332D1DADEF32BCF0C9222AFA05E67BA014CB7DEA534589587A6731D88
      1B7C19B66BB364657D1762F4CAB73BC668D39E49C603E6E00AB084D365FBF3F5
      D5E123F9D90E9C20F327C02BFA855570A6B743C3DA6B6115D6340C4985101BD8
      80C5E880A9759EA4EFBB94BBAE30336B62AF9255F00B118D055C9381D9B4C684
      3E0FE09894E9AEAFF0871F58C8BE09CDD026EFA09CDCB602EA00DFA4C0BAB543
      B2ADEA59A8DEF799732A122CC7D02A22DED996441B8A8DC0D238E60655804190
      31746E187433F8CE41554EABCC5A0C83CBE4AF0528501D33082EE496D50C3A82
      327E89232C68A34D5B13FFD2F4DE441721E520CFF5516FE3EFE7E2BFFDF9FAEA
      F591512F31CFBD83235A32064C82A2A6640B79F4C568E84203BFDC928F1A0603
      5891536231E030EC0DFE86E2E1E221C642D1B07DDB515F7C6208A59B0729743D
      0BA9236BD886EB2B080CE6211E96C786056D35195C222EFBD80164D217A40FC6
      C49441994B94A29C35EEC7B6B38D27D81D95B464D8D7C91F3B94300C7D7159FB
      C1762C2F4C17C804529360C376B9CBC484E5F4DA5E5FB543493C65A812803008
      A540D85DB24DB4896CC85CD034219802BE42EEC8C7C1520235906862F0B631F0
      B90D89913D2C9DFA36E3A633B945AE409E05DE773667D515EDFA4E91DBE4B192
      60B4C495CA34B45071CBD523B31B42CA3AB42DEC92A349BAB183A58C66D89F12
      4B6930290E80AAC35993932F04A2491A97B2371650A68113461033B4BD23ED8D
      D6108E07A21666CDAA9148C013B0981BFA5C1AC985AC4C5236A886152F160F95
      0B2113C624940650711960C347B6713E1ADFB5AC8D337D8B24D130A74930A631
      6D0780928D01589766E85A4302502588A86A8BEA42E83D2EAAAE431680564823
      0B0EA214AEDE2202808BA7C604D73642920551D12A5697B419F0420D81AA0DB1
      5383392F4841083409D6166206AE912070CAC85FF890602155328BDD1AD8A540
      039AFAD941DBD9975CF0BBA30C12836C432028B08DB2CE445212DD46E9804578
      AE0BA9D38356B623654A1A4AE3726E2C6EF783D5816AD02205749B0C23102024
      41342D35B30323A9579D6E22D90ACA597E106D83272558E608E935F08B829535
      C5A0D7A6CF2C69F49A7CE9414E52519004C4A3A5558622FB1E924E8051236192
      862E7A6A46EC11133CD174CC135A0B59E12ECACC8E29018750829BA1681173F0
      22F58700908090521928CBD757C509370E213088F5F054C0BE8B908BC59134F4
      1A2B862A23FFF654895842233F436FD4A4423822C6CA210F50944027339CFF4D
      648833C81178DAF645C10D3203C6F033000B720E545A27FFA68EAA550819CA33
      98147AEB51306083A2D80E44BB4F4A3BCA4C8B1E3159B85F07C928A5067ED178
      62619D6AA5B812AF32A08DA9C2A418C0B39652EBA805367935405330914F1E25
      5AD0083012FA006A885C6440FC52D6029A4EF32CD8B288ECE46D8C8383A74B76
      AE8F095A821758788D0CA329447AF60EDD025F8A7E09A84BD7F5A677998ADC50
      4374ECFA44067AF405EE2878066860D2BB9EEA1C0964A7B0ECF500B9418920C4
      2448852B67A3FA8C4C03F950656B8DB5A9D74C17C569342CA9131D09F86DD153
      C61B4099993ACCEC0924A55DA34B3AEF5C4B7E82DAD85AD4147AA04518024434
      049CD80318E564F989120E107F4EDB31C2B6E874CB731D921FC6491E85D8B8D0
      92099AF8304152C3831592CDA0650B30425271315605EE2E141BD8355A214B4F
      8100D53934E0DDF696BE602077590532C9D37100ECCC8251DC6133A90BCC175D
      A7E5329E9C8E94258971DF7A2ED118CBAA7409298408683D3C57280003B28747
      D4E1E85C03019782D20D6828A0D9934EE831B2ABF5B0A3EA3C3A928EC5D26FB2
      EE307C6C9442E3D806894F4954038D8B027AB438E87226412299DC053A1F6A60
      A4D29177A9D856208990309CB341FD8EE28D9C027AAC621B1C9EB142A1A09F0A
      422650F8E10DDC21F7E1C4D24AC08260BF0051D700C926FB18201E0789FA01EE
      A49043B6F423525360CF92A5C006FEA782B5F028C9A4E04F23C42612DB2AA41E
      F5DBA32548C8D88FA2485613F683003CC880AF463E2041A47DD0144CC20175D3
      84DB56124E129CEB1BFA1B9AA6240CDCC253D2A3980881A3BF98043CE234D521
      51F51CD23213F64CB2250A7403AF46F2B558DA36C800B1123A4BD9E81A617D58
      59626090B6233B100A0881380BD17B69BD7AE472C7BA804120839043DA813396
      010D87EA7320A5771D2A059249F447284757526349622E8D42609C417E2013D0
      C28530606CA5692071C84BA8A7BDBE82A500A5B7AECF085CB4404769810E4453
      068A2B72DF349A25A029428951950201EE9445D6510149154B3292341412783E
      B85E0D852624B4111402082A759F989FB10536C90D3D01EA0AE4A115A888AC42
      9329F00DE9254AC6D39170619285D6A24D12268BF68044340B0D0D5B1BB81075
      9176108127653321641010C8091607B769671A148F023608ABE0509D01F6E004
      EDC0222813B924FA42DA904E568168226272A24C53C79107340B14861646EC06
      C646B0A0A9BCB4CB2820DD1161A919C8E6D025806FE9F12200D0608BDFCB460E
      50E284D4D53C245A23C5399171C0826AD018A976680872DA22FC6124D14C7D93
      6322B75C812C5181E84C7A0167E8CFC01495880480724455E05F50B25B123BB2
      B58B2A4B6C1D4A550140C7792904CAD21DD31941A3CC8CD444F9B72C06F8B728
      1E0A8042FE900129539D0BA771D235B0BE0801547CA6D521B8FC480E1B8A06F3
      A5FB46008AA4400F11307282E242314518A3D9E897DB088BA163A54370A813BA
      1BF4B4955A43B7093992B31A96A113A7FB21637C8109A84CB03FBC4D23827829
      0A25131061C9301BA0DBD041F846542D941DC958DDB1B07021DCEE75922A84AC
      1A3434DB5AEA14D44AE5869D121821AE300D0A10394F01A76404349697AD0F44
      4F89C24B855CA08605291CCE0906015E87E0C4D31024837A040609E48730B028
      8DC5093FD28DA8F5AE875C59B2262AFA65037E1A8356962A4006C1410098B697
      C88109DA649AD222A59185A037A1AAB529B20AF08E11AFB323764311B90FCF85
      4E2708A46FE0782B62CAC259A4320C0F5813F50A194A2DB5AC04CB44E3475BD8
      C8DE0BA209D59CBA887C85111D7903B53A589172C04CF1CD53C5634776505650
      69438A29B490384142ED809FEC8A8788A03662099127180CE627156249609CFF
      95069328DE91655B146AEF4BE7A34384E6DECB1619ACC094A4216C86447566D2
      D1831192A60313812657347770C289727607A4713C8A7F34413CA27291FDAC2C
      A488B84D14735AE440FB214E5233864CFE3489E0C9F652E83A61ECD67BF80157
      109E946DBA46C8144A47FD50F09191286FE9904013351786431F78342BBDAD60
      A649197C0C34512C1B9E9131C65378B4F3A82ECA77D70FAA6B64EBACA1DF41F0
      8A544586A2224A4612A3CB33E1649EA8A41C38D064B4259E36AA975E14B6A0CD
      A1694B74E7A9A30B93DE198E865DA1792818F8867E20FEF07F92F7181248FE42
      E4D3A9D095148574420C106033D09F1132D96960B2E8764B5362B828994781C0
      1DF202E503B8A89AE44086C2A13C2F5B403A70A540E05805929C7936347D3DA8
      36B2F7105211D9D2B002E8C0205CA73CFC4EF78B7E110DB4B8A7C735159B0848
      767B29DDD65687979E9E5538DBD51FEEA2BDB5BF32DD651B775A34540C431448
      20C8A616C590A619E91015FDF480526A88304D6F6BA56732B499A0AC205F155D
      16FD055ABC6F6010E9593A69D9630713C581EE9581864ED728419C42BE1BE9E9
      5DA03423D3691633D4091112359A3EC40C42951001272DDD1A998628059E4AE8
      DAC265D7575C1781A139274D1240D0411AAFD80F50B3EC8AD21A67C4986991A1
      74033A897C57A84E781D97039D2D1D5E91CD5315649F877AE659802015AF51B2
      E3D05073A077C2203219DDA8695994107A764A742222021C31ED36C93611ED1B
      3ABC4BC922C47A2A2FF207A21B76FBEB93D557B483837C7CBF7E5FFEE5B8BE6A
      CE1CCB76EDDF9A83ECD95EDAB13D3F0326388E3ABF9FFBD635DFDA4D3C77D02F
      C46D74E6F6BADECA84B766F5D61EDBF955A0262D9CD5EBFEDB5B339963067221
      CC4788044E9766B28E35C6B9BAC6EF2FE3B67FDC6EF792DE6B8F945FAEAFE445
      A97E73B77978ECE5A5A90FBBDBEED17296DD991B789A2B054335967DB7416B89
      0C025B6BA1551A4ED956F4D24604F9AD6CF8590AA8696504446EC719CBDFBD9C
      81C8322A44C13DE7A27F6820307905082230F8A0ED207D8E08B3ED1CC816C3EF
      94D8D1FB5BFE438E82609A0369A7C7C828D949F3258C73DAD9A1D3888BFCCEEE
      7EAB852BBCE55F452519E73C7A49CF6AC81283CC97F19E7ED7E7D1432CCCF6CA
      3DBD851A7DA229DE3D677DB77D6E1CA7F7E3F47E9CDE8F1B9FE3DC32E7910176
      E7983CF33A86196C9FD327A34ECF644EC6989331F6648C3D19E34EC6B89331FE
      648C1FC7B4445C22DA6DD7E9E5D1F83B56C2F7763AE2E839C681851D26E56D48
      F74F8F4F9FEEF2E3BFDD3D0E8F4FB71FD27F99E0E5C1DDA6FF39A3294A33FE2A
      7FB8DDBE62FCF2CCF6C564F904C8CB33FFB17D6BF6CBC38F0FB79B87DBA74F3C
      8EF1BF5F4FB9FDC6F89B030B757338BEB9791DDBDCFC307E53C1AF6647C7C9E8
      F779FBC618F5ABEBABE9B4B756AF9356F313387F4AFDAB2F7C42F3A54F68BFBC
      D3EE4BCFD17FE913862FEF74FBA5E718179DF0C5EA9614FBAFC5089E5A2D03E9
      D466190EA73676858D5BE5D132C04C6DC20A9B658B3EB5890B3D7A418799C2E3
      69D3B3CC9F7982652B7EE104E6F39D5886860B27584633174EE03FDF8965A0B9
      70826508BA70823A9AD816C69BDFDDCBDDAB2A53AB6C364FF79BA7ED6753AAAE
      9AEEB1DBDDE1BBD656E8303F5499C8443159431C3BF25DCFE5C64DCEDAA7F19D
      7255D37F1A3F32B62937E5F6A7E787FC58E948BEFF53BEDB7CDCDFAFB8EADA7B
      E387FCF4FC5037EF3D3EF69F645B0B92D713D4B93E7E2C6A7BB794AA4B7F4C3F
      ADB243D77E86C32FD6634AD439BA87487A7E7A2FB8BBCD75EBFC21F50F9B3A54
      6E525576BCD87D77FB58EB9D98DC7CF57C7797EBA862B4FBA17E1947BB3A1134
      9A2C2D8213A33A11349A2C2B7467A2B7C6A99DE52ADF76B62B5CDC59AEF074BB
      DE6B3CDD59AEF27467BBC2D39DA59B6F4ED5B4977D77FB7457472C5FDF6DE4C3
      CB957EFD78FBD37D922F90A85224D3737CB37DF7F6F8F9AC9F1ED2C7F737BFDD
      DCD725F1579BE1D3CDBB5A95B0B75A276DC695912F29B9BD7FAE8BF5C4720D0A
      F7B6751DD5D47669137FDEBA2EEBBEDF7DA9ECB7AFC2EC3C8C8FE0F5DC3D5523
      F9C774F7BCD504950E7E939EEAAEF40AA0DF8EF786DAC1E8F34F5189891F4411
      7CBBABB3753EBF5EBFEE92AF7675103CCEB9D597DD99D712F157F2433D557CFB
      496EF9787BFF7395D56F3772EFDB3C4CADCF025FEB29869FE446263BDFCE1B4C
      09FF371F3EBE4F8FB77582EEE5535437DFA78F55867F900F33D647F137FFF041
      BEABFDB568D4ADDDB7EFBEFFEEE6DDE6A36858B9B968DD0A8AF1579BA7A7CD87
      55F6BB26F8EFFE35777F5F7FE15FA39CEF3F7D58E3F0AF577464A3E1D7B79574
      B6B5DA0C2BACBED97F75C61A17FF317FEA36E961A8BFEE1FE8A2C6E478CA2BAC
      7F4CF281EF7A3BF948F97F9284D5FB05A3F5BFA4875B69C5D6C0EF5DB5E14187
      FCF8DCFD7BEEEB52F687CD9A66ECF7DB4FE86E25C3B28DC7B3A675C561625A57
      96DE6DEFDC7F2B78A8DE109F18D74D7962BA66CA5F8F37655ABABB7BDE56AFF2
      F7C5FA73665DD70AED6CE5E5EDF27CB7CEE517E3953EBF98AF727A73F7FCE1FE
      71EDBC47DB35E87AB1AD954A53EB954B35DAD6F50A5B5BB94BE3AA508D86EB96
      77345DB3B4A3E19A088D86ABC3B3F4B58833A6752F5C1D18D6BD7AB5355C5106
      0E0CD7ADE5EA22B062C3EDC070CD5A8E86EBD672345DB396A3E19AB534DFDCE4
      F11B4FD611D981F9BA753D38C13A12BE7FCA1F3E6E1ED2C3A715E6BFB9CB3FA5
      CA167F6BF987874D91FB03CACD02D7E98BE7EE691427AB4DD7140FDA9D559714
      BB750B2C96957B0AF215339B837E74E695CF57165BE1D03B793FDD59BB83A6B8
      CFEF37777297C277AF2FCF9CDFE73A16D93F7E4CFDCBAB242F83FCB4C5FF6EBC
      27E08FEF5F5F4ED90F5467068EB27D324A9F19B58FC67E94998CFA3E0FB7CF1F
      5EAEBA83C27EACBD34F665F9F7A3DDB9D107B5613FD0CF0ED4D381E1DCC003E5
      B01FD8CE0E3C3A639C1D682603C3746DBE490F3F1F364AFB61D395D9EBC773AB
      18F4F9B1270B19CCF981A76B79014037BFEE7BD9FA51CB90F43AFC6851E74035
      73FECBE89A31BA0CB319A30B689B5ACCE5F31FF39F6E1F5F7734CEBF726F8FDC
      7F3C781DE3C26EDF1466FFF4BCD96DD59CBFC874197F4705BB7FCC07564B1267
      264A17326876C92F24D3CC552E64D5798BB9F49A197D39CB668C2EA4DB9CEB97
      326FC6F50529A8EB52502F63F599E1CB12F084BB97A5A0AE4E415D0DE0E52560
      C662017C4FDC5F00605D0560BD06C0BA1AC07A71E198757D01804D1D804D1D80
      CD1A009B3515C4542896990B2D00B0A906B0A906B0A9E6DF63DFDF02B0590360
      530D60530D6053CDBFF678D9DF02B0AD03B05D0360BB06C0B69A7F4F7C5F0060
      5B0D605B0D605B0D605BC5BFC77E2F04B0AD06B0AD06B0AD06B0ABE35F57ABE1
      DD1A00BB350076D50076D5FC7BE2FE0200BB6A00BB6A00BB2A00BB35FC7BECFA
      1200BB6A00BB6A00FB3A00FB3AFEF5C70BBE0CC07E0D807D35807D35804FFC59
      00605F0D605F0D605F0560BF06C0C7AE2F01B0AF06B09FEFC5D5340EBB9DD5C9
      BB6FCE77FC53FF5E7AF8BDE1A53D0675EE927F9CBC7DFCBCA13E7BCD2596D320
      7DB5D9FC5CF196D2FD59A6B8FCEAB6BBBBDD8C3B239F3EE7A374C7BBBABFFF7A
      FFDEB7C361F6647756DEB234EEE54E5B74AB67074EDB276B66074E45A7B5B303
      8F758775B343A7346AA7E934C2F5E5A51C086F3AD6CF8D55E74687B9D147EEB7
      73E38EBC8F73E38E9D77B33EB9912F26A7756A6EB0DF67F1D440CF1984F3066F
      86EDFC16CF85F8CDED235D08E5CC35E6637ADEE0ADD0CE582D88F19C4F4BC23D
      E3DCD2B8EBDAB82F06F0DCEEC782B8EB5571D7ABE3AEAB413EEBDCD2B89BDAB8
      9BDAB82F6690B9ED8AA57137ABE36E56C7DDAC43FB49A9783BEEB636EEB636EE
      7615DA4F88BF22EE7675DCEDBAB8BB5AB41F77550BE2EE6AE3EE56C5DDAD46FB
      B14F357177EBE2EE6BE3EE6BD17EDC3D2C88BB5F1577BF3AEE7E35DA4F9C9BC6
      7DEC88168BC083D1176BE8C1B88B147E30EE22831C8CDB49C08BC471307C9908
      3C305826024FC3B648041EC66FC6603E90B3AA713EA68B44E049701789C0B331
      9EB15C10EC59E796C6FDA2083C17F7C5009E31783BEAC7C26A69DC2F8AC08B71
      BF28022FC65DAF43FBB1DE5A10F78B22F05CDC1733C88C245B18F513E95811F7
      8B22F062DC2F8AC0F9B8DB5AB49FA8C6B7E37E51049E8B7B1D85CF585544FD44
      3E56C4FDA2089C8FFB4511782EEEAE16ED27AAF1EDB85F1481B371BF28022FC6
      DDAD46FB89734BE37E51049E8BFB4511782EEEBE16EDC7C26A69DC2F8AC08B71
      BF28022FC6BDEE1E56DF6352FF91BD1F3FC857E4ADFB44ECB7E9F1FD53AABB19
      C83FDF3FE4C7CD9D7CAFE7CB84EBA7FB9DCCF497F14BDBE4FBDA1E9FE47B521B
      35DE4E536E2DAA77B7FADCDD06D4CA373F8D379D345A6767AC72AD6BED20B7BE
      F6CE2BF9E204B95DA7F172EBCCB387DF9E7968FAA2546E92EA944A59CDDF4074
      7B98DC8CF7772DB914F94293835B7F4E0F75F4EFD12FC4BEEC6F6D7BFA78FFFC
      9FF1B8BEFA739EFD2FFDF89BF77FBDC719EF87DDBFF97F7726FF17C7DFD6FEAF
      F7F89BF7970F87D2F065FB27D866141E1615E2F3F671E08910DF5209EB8FF176
      EA6EBEEE37BD4F436CDBA88B1A2C92C53B666A9BE88D1EBF1063E6D08D31D757
      B1F4F2351B7E088D9A531C7F29C76C04561EE76F50FF977C7CC908FCFFF35E8E
      2F158115DEEF7A8F97E3975FFE0756102CE6}
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
