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
    object N32: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniCreateNewFile: TMenuItem
      Caption = 'Create New File...'
      GroupIndex = 4
      OnClick = mniCreateNewFileClick
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
    object mniViewClipboard: TMenuItem
      Caption = 'Clipboard'
      OnClick = mniViewClipboardClick
      object mniCopyPathToClipboard: TMenuItem
        Caption = 'Copy path'
        OnClick = mniCopyPathToClipboardClick
      end
      object mniCopyFullPathToClipboard: TMenuItem
        Caption = 'Copy full path'
        OnClick = mniCopyFullPathToClipboardClick
      end
      object mniCopyPathNameToClipboard: TMenuItem
        Caption = 'Copy full path (short names)'
        OnClick = mniCopyPathNameToClipboardClick
      end
      object mniClipboardSeparator: TMenuItem
        Caption = '-'
      end
      object mniCopySignatureToClipboard: TMenuItem
        Caption = 'Copy signature'
        OnClick = mniCopySignatureToClipboardClick
      end
      object mniCopyNameToClipboard: TMenuItem
        Caption = 'Copy name'
        OnClick = mniCopyNameToClipboardClick
      end
      object mniCopyDisplayNameToClipboard: TMenuItem
        Caption = 'Copy display name'
        OnClick = mniCopyDisplayNameToClipboardClick
      end
      object mniCopyShortNameToClipboard: TMenuItem
        Caption = 'Copy short name'
        OnClick = mniCopyShortNameToClipboardClick
      end
    end
    object mniViewClipboardSeparator: TMenuItem
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
    object N33: TMenuItem
      Caption = '-'
    end
    object mniRefByApplyScript: TMenuItem
      Caption = 'Apply Script...'
      OnClick = mniNavApplyScriptClick
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
      789CECBD6973DB48B620FADD11FE0F08F5BC57D2BD928C85AB7B6E4FC85AAAFC
      DAB6DC965C75678A1513209124D1020136006AE98AFAEFEF2C9909802224590B
      97727647591405249027CFBEFEDE4BF3A1D3F303318CFC78E4D86EB3E7C75948
      FF0CA623C76DBABDD980AF187A4ED36EF7F093DDCBF26C3C0CFA83317ED9E25F
      A3A4F2EB38ACFCDA0FF5FDF82CCFEE38EAF350D06FF9584C84FE9BFE6D28ECE2
      974166FFDE1B26719EF723F860F760DD20B47AC33499F8716F3818FB692672F8
      7E9AFECBFDBDF71FBDA91F2799B06C17FEDFB23DBB6937E03F173E35FE380F27
      22B33E892BEB0BDEFED73F6049572F39490291CEAFE954D76CC33A5D5A1BD76C
      C09A87C92C0D458AABFEF58FD7AF6045AFE625DDDB2FD984FFC329C07F6D7859
      5CB4FDC7D9CDA49F44F46E4EB1DF388CEE5EE8D6FFFEF8258C4701FC97D15A5E
      E35B60873063D8210C5DDCA73FE9A7A16F7DF4F3B1DA685B2F995D855976F792
      4302994B8BAB25A310D6A4D76B78DF740E7D78AF6E75B124CE92C8E7CD3AAEF7
      2DAFD697A7C9FF01AEFC71264689B0BEBE973B8D0062FF4CD21ED1C40B2061D0
      2FADEF3CF3FAB48371587A82FB6DE7E62D3E37EB43381AE7F4FEFDF2EA75F8FF
      A4F787130863F5846F42E5079F40B17EF3854EA07842EBF928A75F5EB7FD020C
      B2D3A963685E8797B5E6EEB30E8FE5A6DD4EB7EE663CC5C537DFA4FCE06E1D25
      382DA7E6DE1F53212EE4DD6EEDDD6ECDDDE733F5E43A1C76DAED9A7BB77F12FD
      545CEDA88D77EB90D469D7416DFB20F5FBE16047BE431D163A9D56CD02EFFC28
      0F07F2F656EDF6BDBAE7FF1C8A3CF6E14BC1EF0082B98E2BABB377AC92002CCE
      1DA464ED9DF2E0E7EE9487EE394EDD8DEAD4AB371627EE39B5B25C1D79F55675
      DC9E532B7CD479576F9C3B6BCF69D4DFBF084C958306B2ADBD5B9E74F5EED229
      7B4EAB7ECBDEA227CF1F71CBBD9FBACBA2BF38E2967B3F6957EF9447DCF2EEA7
      EBCA8DC511B7BCFB89BA72AB3AE296773F35556E5440E6AD7AF71353E5EEDB60
      6E766A387E19CC2C5611C2744BB7EE96127CE52D0AB42DA7E69E3268F91E0955
      DE60AB4E2528C395EFD3206DD5E958059354F714044337366A6F9C874585525A
      AD66DD8DA543E41BABE7D7AA93B7E5F3934F9C3FBAB6F32026C8DAA73ABCB6F3
      20FEA76E92C7D7761FC4FCE45DE5036CBB0FE27DF24E75846DF741AC47DE55E2
      3B6DF7417C47DE780BA44ED3B99F1C940A5E701CB8ED7E92286E9340759AEEFD
      44A1EF2A780DDC773F51E8FB1448E1AEFBC942DF352748E0E6FB49A3B8B94C1B
      70EBFDC4A16F2D1D25DC783F7114CF9C3FCA8A65F40445B1B2CEE375C6F232CE
      53D4C7CA428FD4246F6DCC798A5A39BFD613F5CBCA5A8F57356FEFF119F4CEB2
      39EC3C0EA9E65779244AD1F6CA0BB94F41AACA428F374F2ACB3CD952A9ACF644
      A4AAACF524FBA5B2D25351EA9607C47DB836464E0E855295351EAE9EC935248F
      2A2FE23D5C5FE345CA42BFB2D0C315385E4821536591876B74BC48853B55567A
      B88A2757D268747B6B0FD7FA78AD121A55D679B81228DF699E2F95DD5CDE1384
      5D659DC70BBBF2328DA7F0A5CA424F117695859E28EC2A6B3D912F55D67AA2B0
      ABACF50CC2AEECD96C3C5AD85556798AB02B2FD47CA206552CF478615759E6C9
      C2AEB2DAD335A862AD2709BBCA4ACF22ECCAEEECE65334A86295C7F3A9F232AD
      47A3D4AD7DB51E8F5495659EC8A72A6B3D05A56E6FF0A91A54B1D233F0A972FC
      A2F56DDEAC5BF18FD6B7BBB6CAB7B7BFD9CB35BFC037BABB6E6DA0FD48DF5765
      8D47BAC12A6B3CD2235659E309CEB172F0A9FD683E5359E529C2ABBC50E7891A
      51B1D0E3F94C6599270BAFCA6A4FD7888AB59EC4672A2B3D95CFD046074994A4
      793FFA6B2F1581DD1BC1A9C476AF1FCD847DFB2BB7D92C7F09BFDEF5352F80BF
      2D5862EEEBB96B6B96A879202FE1B89DF297F0EB5D5FDB7F7DFD0ABFC6DF172C
      32F7B55DFDB25864E1D77A91AE2BFF001FE80F5DF74170B6F1B0FF03537806E3
      A9A5A3D899EBF6740E0FA7EF3836D891FC319EE22F96BA73EA4F2DD8E2BF22AB
      1785762F85FF32DF69C1BF910BFA45164D6651EEF4AEC2609047533FED5DA5FE
      14EEF3E1EB9E9F4DFD683AF6F1433C9BF486BE3FCB939E1FFC7396E5291A6CB0
      20BC6C84FF84B93FB5AD3F7A71F22F40BB6492E4C2FABD97E53791C8C642E4BF
      2FEF257A691E0DC6400999839BF7659CDE27D0F92A0F0B5E264FF932FB7EE80E
      466918D017F1B4F43709EE5E168BEB1C96C9FE354CD2899FC3A7691A266998DF
      D8D627FC0AF38BE06532A70A87BE631334F0DF3EEECC81DFF8E737C12399E500
      0111894B11D90F864ECFEF03586C040D184235A0E9F7E8AF7350A18F17228D43
      F8BA550F1FFC054F0176978920896D092C7878066F75E1341742AD6B21EEA459
      1874C0D26EB45AD658F8985B6539481699FBF260741E034600450146D8F63C20
      E1EF8B007937F86E01CF55C06B7D23F05C8985DECB83CF7D0CF8DCF65D58087F
      FD76E02DC03D4F81AFFD8DE0F39825C34BC3527E1084797829E0EA4C4CC27118
      0422865F66317C14337862694DC73A62D0599FFDD41F0128C7D649125332D77F
      C02BE699E3C03F697215F4F2749867BF84413E7EE7C12F537850E4D81DF9312D
      3E0E23F5F761AE3FF5F5A7143F0DFA531F982B7C18F2873EEC1C040DFFCC6FA6
      02AECA2E459A8382019FFA6990AA9F91FCD9973F53F9331845FA93FA6E2C7F5E
      5AF7317AD8ED8BB0FAE5317AC7B9E3CC99DB5BE77E3F121A5D9A25744195A386
      05DF4279BBE0BDF662C6BB9851207E328AE3CF64705141C6DB08FE9362AED621
      A88FFAB55B652CAF6378959786CDC9D796EF5679ED7B5ED6FDB69775AB2FDBBE
      FF65DDF642084BBE52FFAA251EA25FD6FBB697F5F4CB664EE765B8EF37100A43
      A3514324B05DFAEB33482AA7535185E6A133C9925869477C8ADDDA531CDAD5C3
      9B45BDC1D09D43A37A4E3C772CC0F8523C46F560D7BE8344173EDA79ECB34F92
      284AAE44507987CC7D21CDF09B34E5BBF1E2D9B0C2BD8B81CE834B32D4ED5F44
      7F479F965B8B26E1EDE30A6F11F06DA1EFDE46CEE30940330B33FD50AF1E375D
      02DCDC73B1D481BE7C1C8A9E7FFC601D268160F46854D043A300EA0ED75DA705
      FF3A1DCF851F6E1B24467EED61D6577EDD687640D85F371B5DBCA4D570F092B6
      E7E2251DB7D1E0BBF112C0B4362D6377BB7891E37451D3B80643D6C5CB1CAFDD
      A0EB1AAD66EB99F99104DF1DFC8841F92CC8D750E2A6F9ADA7F139158C38B908
      3456341F87158F1039FCE64AE654DEFC9E97AD484AB75EACCF534EE515EAD9F8
      34DA2B1869BD1C9E5B7D7E8B77AE3FD0EB77EE96F37312DEBA97F0DD5B8F3BCB
      D3241EFDF50F7A621466798ECADCEFF4917F179369E4E7220C1CC7EBB4DB6DC7
      B1F9CF64FAF4E8DF7838703DFD31569FFF39B0D12EE48F4814F869482241FE92
      E53E68E3A0ABF36F537F20E45F406317718E8FC2DF7240E6DE0FB6D39BED795D
      C7B3FE1782889F379BF4450A8C8B6AA310D986FDD027E40BF7BC1652621BBEFC
      E7406E0E59824BF4093FD079F4E0AD3C702397F0B2317C8433539BBF7F5FC9A2
      FDB835FB711A8DEA86E80B58197FBEF0961EB221D8B63A2AB7BBF8A81CBB666F
      2E32E8F2DEE80B7808FE5C83BDDDB33364DFF57BEB74E6F6865FE0DEE0E7FAEF
      ED8E9DC1BF48E9E5BDE157B837FCB9D17B6B7873EC83BE8047E04F8B620A1BBB
      372CCFAAEC8DBE8047E0CF879C5AC1DED76F6FED394E425FE0DEDACFC3493477
      5FFEDE5A8D394E425FC023F0A7DA1BC6BD2C58063F8741B3D1683AAEF7C742D1
      BEE7D8CD56ABE3369D8E91ED46B61BD96E64BB91ED46B6AFEFDE8C6C2FCBF64E
      D3F6DC46A74EB8776DDB83BF7B46B61BD96E64BB91ED46B61BD96E64FB86C876
      C76D76DDB6DB71EA2C77A7EB7A8D4EBBFB00E9FEEDA7FE2791EEB8F1471CF2E6
      4B77E2724FC7DB7597EE4FD25C365BBADFA9B99030FFD34AF739CDA52ADF3778
      6FF748F7CDD65C9E2ADDD75873798C746F78C0419D6677B174873F77DCB6D7B0
      DD9738F44D12EEEAD89FEF8C3746B83FDC1B6184BB11EE46B8AFF7DE8C70FF7E
      847BA7D1719BEDAEBD58B8775A5DDB6B5522EE6AFF46B41BD16E44BB11ED46B4
      6FD2DE8C68FF8E447BB703C2BB5B67B7DB2EE6D2D9ED86B1DB8D7037C2DD0877
      23DC8D705FDFBD19E15E11EE5DBBD5745A8D765DC8BDD5755BCD6EDB335E7923
      DD8D7437D2DD487723DDD7786F46BA97A5BB6B3B9EE7B5EDDA5238B76D773B1D
      D748F77BA4FB9F4CA09737A4766E04BA11E846A06FE2DE8C40FF7E047ADB765A
      CD46A7C65CEF761A5DDB05816FE2ECCF7DC41B23DB8DB16E64BB91ED46B66FC0
      DE8C6CAFC8F66EA3ED365BF5D56F9EED75C05AB75BC65837D2DD487723DD8D74
      37D27D7DF766A47B59BA7B3688F72EFCB94EBA77BD4EABD5F03A268DCE487723
      DD8D7437D2DD48F735DE9B91EE15E90EB2A1EB79EDC662E9EE355BED2EC87FE3
      9737B2DDC87623DB8D6C37B27D8DF766647B45B6775DC7E93875F56F7BCD8E07
      6B376DDB18EE46B81BE16E84BB11EE46B8AFEFDE8C70AF0A77CF6BBAAD76AB46
      B8371CCFC5018946B81BE16E84BB11EE46B81BE1BEC67B33C2BD2ADCBB8DA6ED
      36EA9AD239AD4E0B4C7BD778E58D6C37B2DDC87623DB8D6C5FDFBD19D95E96ED
      0DA7D16E784DA7B6B4BDD1763B76C7F13AC67237D2DD487723DD8D7437D27D7D
      F766A47B45BABB6EC3713CBB365BBE697B9D7607EC7723DD9F612B1B23D0CB1B
      328D6B8C4037027D93F76604FAF723D09B8D66ABD1EDD424C8EF356DA7E3D8AD
      96A97E33D6BAB1D68D7037C2DD08F735DE9B11EE65E1DEC2E2F6A6DB71EBAC75
      C7EBDA9DAED7326D668D7437D2DD487723DD8D745FE3BD19E95E95EE4EAB6177
      DB7523623ADD96E3D84D63BA1BE16E84BB11EE46B81BE1BECE7B33C2BD2ADC1B
      DDAEDDB56BFCF24EAB6577DCAEEB98FA3723DC8D7037C2DD087723DCD7786F46
      B857847BABD5763CA75153DCEE80E8EFB46C23DC8D7037C2DD087723DC8D705F
      EBBD19E15E11EE5DA7E9B5DBB596BBDD6D37DD0ED8F746B81BE16E84BB11EE46
      B81BE1BEBE7B33C2BD2CDC5174634A5D4DCCBDD9E9389EDBEA744A70319D6B8C
      6C37B2DDC87623DB37716F46B67F47B2BDD376BA6E9D571EB3E53B0DB8A863B2
      E58D7437D2DD487723DD8D745FE3BD19E95E96EE60983B76BB5B3B2DA6E1B49D
      160878E39637C2DD087723DC8D7037C27D8DF766847B55B8B7BC86DB746B0ADD
      9D6EB7D1C229EEC67237C2DD087723DC8D7037C27D8DF76684FB9C706FD9CD46
      9DE5DE721B76A3ED756C137337B2DDC87623DB8D6C37B27D7DF766647B45B67B
      5EBB053BAFF3CA776DCF6BD88E6D0C7723DC8D7037C2DD087723DCD7786F46B8
      97857B178CF686D3726A847BA7EB76C0786FD718EE760118FB5BA1F22040B8F0
      9FBD3F0F048410EC20CDA3C1B8371C648ED5F3870088284FF98BA788F97BF6F4
      EC421EB7E83C6D8B8F90FC8F3F3904C0E376E93E6D978FD0019E829F8F999C83
      BBF49EB8CB6FD7065E609777EA39B8CBC6D376F908BD6089BB947B6CDEDA23AB
      790FDE252904DFA6212C7F97AD879E2462FEA25DDEA32DACC72EDB4FC357540E
      E6B4BDFBF586E5EFB2F3B45DDEA33F28BD6F5E8368773CDBADD3201CC7B55B6D
      A7D16D6D9A7360EEBC9FEC1E786E1DF1859C03CF1697599ADAFB7CCE8142B75F
      9BBD2DD739F038E5EE917B5B17E7C04B0C437C84E8DF1887D52304FE3A71923B
      1D564F760FAC2D9744193E27D21EE01E68351B6EDB71EB46CF391DA7E1753B4D
      B7B101D21D0FFEC59CFFEB2CDD37DA61F764E9BEC60EBB1797EE3A2EB3FCBDAD
      52BABF7438CA48F7B5E52446BA3F5CBA3BB6EDDA8EDDF66A5AE5389D76C36B76
      E1E08D747FF2568CB96ECC7563AE1B73DD087423D05F4EA0B71A4EBBEBBA5E8D
      400763BEEB398DA66D04FAF31EB231D78DB96ECC7563AE1BE96EA4FBCB49F76E
      0347C17B35DDEFBC6EB3ED366DB76384BB11EE46B81BE16E84FB1A301023DC8D
      707F8870771AED4ECB731B35A6FB5ECBB13D7899A66BA4BB91EE46BA1BE96EA4
      FB1A301023DD8D747F8874776DBBE33AED564DF73BAFEB3540BCDBC67437C2DD
      087723DC8D705F07066284BB11EE0F13EE0D6C5EEBD4A5D1B92DA7D3759CA691
      EE46BA1BE96EA4BB91EEEBC0408C7437D2FD41D2DD713B0DC76DD498EE7B4EBB
      D3E9345DCF24C91BE96EA4BB91EE46BAAF030331D2DD48F70749F766B70B28EB
      36174BF7B60D7F775A6D23DC8D7037C2DD087723DCD7818118E16E84FB4384BB
      D771DD46C3B16B84BB6BC3FF3A5DAF6572EA9EBE1553DF6EEADB9F1BF74C7DBB
      11E846A01B81AE057AA3D5E8363B9D3A5FBCD3F59AB6DB755D23D09FF9908DB9
      6ECC7563AE1B73DD487723DD5F50BA771DB765779DBA487B171851D3861F46BC
      1BF16EC4BB11EF46BCAF010331E2DD88F70789F74EBBDD705A9DDA443AA7DDEA
      B43DC758EF46BC1BF16EC4BB11EF6BC1408C7837E2FD41E2BDEB391DAFDBAA19
      048715F0DD9663F2E48D7437D2DD487723DD8D7437D27D73A47BB3D16CB9DD6E
      BBB358BA379A0E3AEFBD4D98F26A84FB26A2AD11EE46B81BE16E84BB11EECF2F
      DC5B6DBBD168BB6E4D039BBD76C7B53B9EDB34D2DD487723DD8D7437D27D1D18
      8891EE46BA3F48BA773CBBD1B6BB75D2DD69781DC7E9BA9E990A67C4BB11EF46
      BC1BF1BE0E0CC4887723DE1F22DEDB76A7DB6802CED6C4DD1DCF6D345DCF64D5
      19E96EA4BB91EE46BAAF050331D2DD48F7074977A7DD6D759C4E4D0B9BBD4EC7
      7541C4778CED6EA4BB91EE46BA1BE9BE0E0CC4487723DD1F24DDDD76C7F6BC4E
      DDD057C76E83EC77BDAE89BC1BF16EC4BB11EF46BCAF030331E2DD88F70789F7
      4ED369741B75FD679D8ED76EDA6EDBF4B331D2DD487723DD8D745F0B0662A4BB
      91EE0F93EE1DA7D9ED38AD1AE9EEB61BAEDD6DB9C6356FA4BB91EE46BA1BE9BE
      0E0CC4487723DD1F22DD3BAEEDBA58D35E9B35DF6C766CCF31D2DD487723DD8D
      7437D27D1D188891EE46BA3F44BA771B8D86E378B569755EB7DBE9365C23DD8D
      7437D2DD487723DDD7828118E96EA4FB83A47BD371DB6DB7D1A891EEAEE3BAB6
      D771DA1D23DE8D7837E2DD887723DED7808118F16EC4FB03C4BB6BDBCDAE67DB
      76AD6BBEEBB49D46BBD13659F346BC1BF16EC4BB11EFEBC0408C7837E2FD41E2
      DDED76DA76D76DFE017FFF0FFA36B914691A0602D688C4EF95AF94CDAFBBDC55
      FE3A4866B0995E94A999B273B7B59B9DB6D3751BADC577B98BEF726DC7F3BCB6
      ED2DBECBD3B26DFE251B1E8807A7D95D7C5F63F1D3BACD46B7E1B49C9ABB9A8B
      EFEAC00BB600816AEE6A2DBECB719BDD2EF00BB7B9F8B676CDC31CCFB1DBDD6E
      1779DCA2FB3A358FD359168B6FEB2EBEADD56AB5E18975A7E6D8354FD3CD146A
      EEAB4112C775DC4EC3711B356FE9B87507EE761B6DB7098FACB9D1AB7B515538
      52735F0DA6385EC7751B0DA7F6BE1A5C69015A368074EA68A70659BACD36109D
      EBD49EBA53832E0D9C26D1E8761A35B7D5618BF6EBD5DC57832E45B4AF86CAEB
      F00588C16DBB75A7E73AB574AEA765D4DC59C3579CAEDD6AC251D49C835B872E
      9D46C76DB6BB76CD6D75D862B71A4010AE5BC3C6DC1A6C291874DDB9BBB5DCC5
      06AC0672A8DB600DBE14A9D635F7D5204CCBB3BB8DA6DBA9A15BB7065F9A8D06
      205A1D73B7EB4EDD03CED9B4DD46CD317835DCC5036BA80BCCBA06A9BD3A5C01
      0BB7D3F2DC46DD7BD6218B6EF65E735F2DB6003FEAC08BB6EA4EDDABC1173C84
      7697E5FEA2DBEA90A5D3EDD85EAB5B23C0BC1A5C69798D6ED7EEDA75E0AC4115
      C0AD960D82B6EE69DD7A99AEA6D6D708F55AE662DB1DD769B76A90B351832EF0
      A25EC36DBA75B7D5AA2CCA6952735F0DBA7870E24D171489BA536FD4E00B40A5
      E9B5DB75E7D0A8632E6DDB69351B9D1AEC6CD4218B1E2E5C735F1D6769801C6A
      763A75A2BDD1A93D77DDBBA1E6CE3A61A4E7242EBEAF59832F0D90EC20C3EC1A
      2A6AD6E92E70E236E8665E0D409B75EC45B795AC3BF8662DC6B88ED371EA28A9
      59832F0DF4D8794DA7069CCD1A7C69037B471E5FB7BD3AD50570CC6D834A5773
      5BBBEED83B4D1B786EDDA1373B6CB3A4E232EF47D6EF5FE38B38B98AFFCADF4E
      4753FA163FF442F8A7D90B737F8A276AF752F82FEBC37F3E22C072AFB0EF5F03
      B0603DDEB5EE0A867B16060862FAD069024EB55AF4D969B61CDB6D23124D267E
      3EFE9CF2CF9324CEBD466FD24F2FDE856036CB0F67335875924DFC283A49FD01
      D2C02408B3E991183ABD49F4D14F477475AA3F0562F8FF0DE06F57A93F7D4F26
      34793B27619C7F0827F021F6D31BF884641AC6C3E4F79E3FCBC7496A9DC33F19
      D8E3D6713C8A440A7F4EA622F5F3857F1AA402CCF649EF2605250C9E96B47BC1
      0D98DFE3D4C347E1F610F5EAAF40E907489B85498C6F2202F82E43428E93E1D4
      1F89AC65F32F57491A80E20F928D2801BE198CFD34EB3A5DD2B2D5EF5719B6A8
      F16C5E365636FBF5248A33C675FAE858E33C9FBE7DF3261B8CC5C4CFF627E120
      4DB26498EF0F92C99B64380C07E20D3EF30D082A8F3E4DA23FFEE84D7D00C695
      838A317F1EA3A1DFE94D00EE1143183EA5FA53AE3FF5E9D36896E722056CC9D3
      4C0C72F4B65F85417235C8D3A837CCE3FE3F7BBE88832019F47238E88B099074
      66F3E76192028AE4613C727A411227B998F44590DD6443401A07001DDD24F1E5
      24B24B7F8DE0EAC0CF7D78723A8455C52560022C78E947217C2F001A4E2F1B27
      57D3C81F88711205E86101FA1BC5492A26E1B50806B03A7A6000AB2F4518D39D
      D7F814BC0D3E00CB01B470E008AE2378BDE446C4B02B713DCDC6691EC3D733D8
      6C944D07BD20862388B37ED0876FC9C7035B9AC1BE6163D9D8079E0608F66FDC
      7B309A1022C387315DE880B6168C2E4B9FE1D270C4BE7BFC4BE5B731BE9A4337
      E00774F9C0FBF871D0BB0CC5D54518070E7DCA067E2440220131F7D3201D0B3F
      901F874992F7B26974935FC5612CF068F4E7713E015AC9A6B089281EE77EF04F
      D8566F968928EFFB51DC83FFE00B78480F6E81270CE0B72BFA053EA4F928ED45
      319035EC5CC012F0E92A453EDCCB627F9A272360E0613C1051040B45C9D53014
      11906F00CBF7E0C2E92C1EA0E7D2CF425FAF821C258537561C261657B06096DF
      C05F3378C6284DAEE095936198E37BC608EFFC06C08E4203FE0EEF1A03A7C9B3
      DE50E0BB89485CC2D783EB6C4A1E2EE010011CE1157E2FF048FDE100E8095FDA
      1FD2C53340CBA837A62B106E3970463F852BF3C1A54FA0CAE165F1A6618AF0C0
      2F2EFDFCBA7FDDBB48E3699AC522EF0D7CA046C0B708C06821E284408C533FB7
      E0B5721BC9FE3F7A5780C7C3493E0C23A023CB0503E70F247E6043B354E4E334
      C97338D25E180D93893FF0F34114CFA6CD0E121CBC90D543AA0B2C457FC0B563
      710DDC084E5EA437A063F4F0E4E5477893EC1A3F00F8E3B14805DD8DB7E021A1
      4B915613431F507C000748046C91688DE14FD12510D7349E0DD2097E81FE4EFC
      9D3D9A184B9BC6633F1EA1008EF3EBDCB7F6A55C9637BB70CE783BBCECA3EEF7
      E01328038FBAB7019FA2873F79A77A77F3E14FEE5BDB7FD42DD322003CF835EE
      5AAA4D0B3DEC20EE5AA7F35C2FD47DC80B21CE2F5C09844F0ABC2AF2C3D892B8
      DDFB17104DA185205BCB7CFAB78FB40F6CDEE79F2070008BF10E540E24FA0243
      99FAD174ECE3877836E90DE9EA5E3223842717BBDD035E37CB7260B5E31C1E13
      93E75C296BB0A05F527340E7C9A3C1B8371C80B40536E1394DBB0D3F33B014FD
      083607FA4F93DE9D2FE2C8335ED5EAD145788D67A3B30B3E0C814D7B5E6F8084
      475FC4D3D2DFE229FE15A05E79641F9E66E3131B9DCA737AFDDE10DD29F8871E
      6C7D3CFF28FA7801EA03084FAFA59F415F837A52D6E550E9286FFA97B19FFF90
      59C0802D3899EBE320CCADC6BEB3DFF85F88CAC080F8E4967766CE379D591D04
      BDD6FC49691802806A61F82D907B371B0D41DDC8249CD8D8A1704F81EA9A8B57
      51CBAE1EAF4A6878EA1BF5A204D604CCED057DFA007222C4A77856EF877EBB07
      A2F18F05C759C99E78F0B9CE85A5F0DE079C74942D3E5FBCFD4127CCC7EB36E6
      20C8478BD6E81361F8FAD55F3AAD86B56765B3FE08F633B6501BB5C20CC86390
      A429CAD31B8BCC0811BC51F66BBC5948F0974EA7035BFC1CCD4005CDACAB301F
      5B7162815D019A44660DFCF887DC4A45964497027E0E419300052FB3F2C482A7
      81C2138800BE1FA089B3693BEFB661E7075926D21C6C38EBC40F2350C4ACAB31
      9889B30C18A8F5456D38B0DEDDE09EFF399B4CF1E7FB4F27A71BB6DDAE8DB87C
      10DF589324E0A34C615FAF5FC17680DFBFFF74FAD10233033F1CE017A0C15B53
      387990EA96426E4410F8BA2F2C3FC083875B7D5C0EC406638C85B0B00098EA8E
      CD0212907CD7467A90AF8F38E03389236600548689F766185FE2A68515242243
      FA98A6E8674066904C6FAC4FEF4FFE0F41F2EF27F001D56CC0AECCC8D0BB8FE7
      6308A69D3540D5D108D26F14A4EEFA0BD2660B994F3F8CC29C18A93F9D02BDB0
      92990DD2709AE3B71920ED2027893244313BC780AFC0C848AE564449DF66413C
      509F2F53D2F234FAEB656AF44F80DACB23E639BA462C1FFFB3223F1D098B73B1
      AC64A8781148BBFC4A804AD0D8B7F7AF89B1130C414F004680F7A20818CC409A
      C6A81006C96036818F80B2B8F8AED59FE55A6CF6D16D28AC7C8CCA5424FC4CE0
      931AFBEEFEB541EBA7A1B56D0C5563A8BE8C7CF5D65EBEB6C98A3B010DEAB41F
      859768CE1CA22EEA6725DD7D08060EFC0B177DFCF1F864B370E02FEDAE8B3B8C
      C2E914382B7A1B018F91FE319618F937C847FBB0D045462C1A6CF63DFE75C3F6
      D9B13DD8A73F44636A001202F9E3EEEB5756964C04B1BCAB248D020A26C159A6
      C9C43AFA7088E6D70DD8EDB915257E80E2254C2DACE24900316F947D6E69AFC5
      A6C1C445989C9C7A6FC17E1D8C615323B12FB289F5FF5A9F138C0A27C905F063
      FA2A16801E1FFDF4C2FA9804E13084DF50D7C49FC12C4583EE1F0787AF5F6D1A
      041A48DF5FE4399297A670BF00D94FDE1F6516060C91E2114BD491C3C3730128
      01D4A119C19B30FE27A9D99B07862621C2A79FE15F451C5680FB9B24B1B8514E
      08918262853431B54602E8264F370EE39B4DB4972A5CC00AA2413CBBF0890120
      AEEF5A21D03831C14FF0FDDE797215C3A6D30B915B97704B36DEB45DB76CD875
      9E24511E4E2D3FBAF26F32E4EF40C00204ACE48A3EFA549238D8B8CD31136BBC
      B58E58E138ED23195A9442606D1F9D9CBEDB411A9E4581A655EB32F42D547093
      F4FDD1A66DB8EDC086BF4E315783D58E332C941980661245D22B66FD0A00F96D
      E33686C4797E7CD6D0A68747C217F30DD08D416EC08FFE08F67A3C1CE2197FD9
      4C0F7907BD3687C04DC7561FBD9BF1304C27E4140D48A4FC31A7E98635CA2E66
      BC3DA3C21B27F30F7E69155B4A968D3B3FE4A7EC599DA60960E7847587209921
      AA822D34B820C9C29AD1240966F0357BE1803C376DBB5D8C70FC7A7671938693
      DFAC3330CD533FB2BE1C1C1EA33DA05422F4F620B592A40C50614AC5BF66612A
      364DA274ED2EEC57FA50596EC883F5A70958ABC974CC26D248C49806099BFD70
      7A7A2E719922352206DDC8C2A2C14DE34D5DC72D33E10132298C4F61F00EF684
      E80C9C98CCA14F620C08811AD3C6ED1111FACBA7838F05FE22DBC5E823193A14
      87ED83CCE12034E2F2007D8A9988B350D6496FD68651E01C7D51463D59FA45AC
      1D50F9209D0033430B9F3F1D0401AA11A85D9C786F3EFDBC591BC678A3D3959E
      9B2FC7275F76AD0F618C5CE94B9280527888C9F095939E913A15109E237F2357
      72E51E646FECBADE307EB69D8A6992E2E692D8026537CC10DF77003A40BA9105
      AF8F588DA70D47FE43AEEC0338FA81204227C524B38ECF3E149E0EC910004852
      B88519317FBC6818F9A38D83D2EB5755381550FA1599E16FD6F1D1FB232290E3
      33907B65F2E1FBACADE3EB2947D91AA0D5A16E8E118A21A05A60D95B0CB07416
      93C9B9753816830B22AF63CA95DEC2876E9EFB701E66AF5F29A81DC7016A0967
      C71CD22FC36B2A52B6CDC4B50F3A7CC995029BCB43502D267E3E18239C08680A
      07F7FB994F20C32F4420316FC3046C3D9E7D48608F0A41B8C082A8320A2F84C5
      C9CDD2074B715D95448449237D5A6FB300B1CD9401F64F80B11EDC3042E193E0
      FC17663FEF63D875EC47A48BE0D193EBE64CE41670E220028898D094C9FF78A9
      F85463EDE3535D1B7D415B5FE3313AB5FC28DADFDF075132A5C43B50EB064934
      9BE08F184FDB9A88786608E66EA84AC1659D8130475984ACA7B0D9BFFBCC8EF7
      7148223A9B4D49EB21156631C880476396074870CA6ADC972064C31A84178AAE
      54A0914C1CFF96EFC9A5BDCC33A0C6337120ADA0E0EBEC8B6BF120DF1775497A
      36EF17C08E0A3DD0F040FFD19241B0271806D92AF60EB881C83C1120D0F70D53
      BA1B5AFF9885830B4454C386980DBDBB61CA415D99190A1190BF7412FA179E8C
      8017788B9904A0A663047DBA027AD2C4B40B76055859F9D8CFD16C10D6361A0D
      21A6762987ACAA43D8D1097421B375B84FE78A866CDF7F64FBFE4C39AF292CAE
      08F67D8E86FF34C9B250C668C8FD399961A43122B34564BB96D81FEDAFF06402
      FF2A1ECD806028932148FD511283C914E3AFCB3F2905BBF3715862814A200E92
      491FD8D38A0402123E5AD72BC0DFED4C601E67945CEDAC4A1CFC8972363D93B3
      6972365FC2266EAEB74DFC975603FDFE5FF0ED80B9C6CA7366F567A3CD3A69B0
      EE5B4D0ABC622A8735EF307E2BDDCE9945CD36D853EAC3972394D16FAC849360
      481CA31D767678FA81C292E1A6A13C01020FF517DC22B57FA0A8BA8C3BEF5A84
      8A7B3AE80E4AC83175F6B00EA8D40EF417CCE9F4951764860E6611CF584342C7
      58468A4EE9A62176D40038FA5856B359D0FA4BAB85B03A3CFEF0C182EDD9BB36
      E5B08266914D676998CC32D0F174956139E955262BA8B4B8FD4DDB77DBD6C472
      E44FFC91808D63AA90A054A1CC9A8459E48382218222EABB717B4486F09E1BEE
      58EFCF3F66EA70754C01B48094429594AA495C01832D96ECA884797F008F4DCB
      B869B53180FDE338C9708FC7679F391202B6C9284D66D30DE368B01D4C3B3E18
      00D9653F874944911E2C7C0293492695102926F110B85A8EA66E3ECBAA67BB59
      5B4626DE752481BE39396DB77EA34A0ADC26F12AEE011053E53359AD680F0DFC
      59262C7897201BF853348E22D82DC28AA3F6A9D81331660772E0DED2093BF10F
      F966C107A0432D11B0DBD18C58947F29B80E813FC9227A8CB1A7025B8051F810
      185906363DD692673342A74D430CD838657DDE4CA95CFE17E14FFF76F4E9E0E3
      DF0EE270C274017F136FAD773E75371C587B7FC3CFFCCBA6EDB543C955A06C4C
      7DB0EEFBF076034C49660504F8F4152AF7C8D9FA3E687BFD599E23CB0E87F477
      2ED345874B9E241675FEDBB84A8356973291389DEE039E2106BB87D6D691C076
      0040EDC7FF9A8553EB3C9C882D8510981A910432E777E3368CDD300EFD981299
      A93A5BC5EFB917C661E423D5EE5A6737D9D73C8CF0539ED2278C0FFC42870E17
      C761BE69A4DDA69E0F5B87A8512A97E39656AE759B07E667D41843F54721D765
      0AA60BF0FF4DDBB4839BF689195B9725E10EF2099B2972694D24F28DDB988B0A
      F6558A692AA03A834D4DD9819845891CEB037E0082FDF8F5EC7CE376E648B6FC
      F1FCD3478BDA2B529704CC7096E9A1C075AFD230C756A7E4999DC5B1C023C63A
      4040D94918B3CE6653EED7C6F1E5B68B56E387D3A31FD1C60672458583775AEE
      4EC4163310EBA7AFA0B3C1F1CF626E6244251AEF907FCBAAB9CD8380E752FAD1
      9575F8770B38D625EC973624110077014A17E23C936F4099A5C0AE658E3832F8
      BE28A5BF936366D3E08045CF1E565451CA10F9535835995821E5E8F9BA095180
      098D0C1CC5CA398D966E89C2F842F778E056AC7E449C421761CD629072D8050B
      23799B05260012EAEBE47AB232DC0C6B671464E37C725D1FCE69B5C36400261C
      4882A2A5850EB54D924DF344B43D6AF235E987A319B69E016EC9F52100807F80
      04001A19524C71E3AA5DDA8DFA9D7D3E00DEB0C13B43CDE450D1F58114D873BB
      034A26565622E543BC720AB6E874E3A8B469BF7E059BD6FC4B1225EC167E539D
      68D8F1823BD57C8A7B3A60061D8A00B896FBD7C07DB206809A2DC596B896364C
      B861145C9785ACABA28F2A6172D20926FE0508F9044B86E324DEF34723E0DDD9
      C695C3D46E9D0A32B1EAFBE0E78FAAE229F4B1B1BD258211D538C8DA0612EFC1
      E8F52B9673DC8C081148B639CAF2242D5228E866D62A39673B4A920B2030CBB7
      D8938B351898E6CC4FC6DA640A48E06D5883028A17EA579B05E5FA44F79F457A
      43094D67E3E4EA50FA38D9930DE479433ECE88DB6E50EB858148739F9259E5A5
      7F1640FCA45B4D6CB3D66CFD4FAB63DB3BD67C492527BB0756A5644B963FB052
      CE3A06A9E6883A231C5728BB36F818FBDAC43ADB7AC0F9816C2189790FB20089
      9B180004F02FB2C40409D5DA3AA490A1B0CE932D6B3ACBD9D956BE9349972D5B
      AA6C24F376B3805507AA52747820FDED71A85BFA9081975D845474B2591BAEC7
      8E7215B64579F0B91809AE6E1CC2F9E616E8DDD84A2E2BB41D623461BC47332F
      2C419D21A4DFF586C810DE9852ECD111B7699A5F1DA080896886CB41A55D0C93
      9382634D424008306E38E290CDA25C89330ACFF40555B66B635712DE2CC67045
      B0990527F52855318625AF465B58197B13B203C9C5CBD59325EDB9B81C7FDB3A
      04653348D1261E6E5914BD249F0271F14D0C4AD781ECE35CD3038CBFF7C598FC
      2AB86125BE8805C1DF32C627F2FF6E9AD3E4AED2D1E69BB3B3E3DFAC77A7A77F
      07C9237C2E6C3CFB7CFC212B7B8E68B00BB9D5366BEB40338B0BF9CE83E131B3
      D9FD0F20534FC07CFC22B26486657D9AEDCAD25919E04AD5DF7565232DBD5900
      A9010729BCD6AF07B33CF9CDE288081D7986140276C42057ECA5ACBB6D733354
      34BC1060D48040ECFC2900C2993ABA2EB8DC8981820B206C303160B3F65A4B0D
      AA35DC2DD51E150F129C536ABA982653A08E2B940E4A70CC69259B05901A7024
      E914242A80E396387CFD6A36CD4AC91F3C47E0560312D59D120866A2F492D8BF
      C48E1DD8DC4BACAA9BF5C6A43F9BBAE0C7E740B7D63B071A73ADC83D5FCAB53A
      3F3F7E875DE378D8E782E0E6D6BB4800A19EAABE035B9B85137F69B5BBD51DFF
      FCFEEC3D997C9F0F3FBE2BF7A9C259A8C1C699BB7F69BB2ECDCC190EC36B4E99
      F02395B38BBE0EF467B381BF591BA380A3A315822D85A28EB3A518FBD6919FFB
      7B27913FCAB6AA1D9B287550F764052CFE89C392943847CD2342E07287228A28
      D968C3901A20E2BD39F9F4F36F16EEDDB2111E68475813501F61B367833489A2
      8DDD148513B6BE60147822CE2829EA739AA07721B5AECF8EAD63D599C8FA908C
      B62CFFD20FA3CDF3837F611387FD7045FB60EB33D83EA0049EA1CB966CE0E10C
      CB15302FB0D41107C58CEC3B8D85F29BB575F4EFEBB6B360F672B7809F413B53
      8D2978C8E686E91F67EC2B0CC2817465CCE28CADFFB3599F3B925A0769EADF6C
      D8BE4ADE0A2E1039FE74F8132ADB7F07864C093E68916CD8A60EC8AFE2675938
      8A95ED20D3773672BC1A36194BB9F993E50FF2F012DD8C98933355350483B1C5
      49F11907A873ECF2A0BA995B54EC4393434B5B0210BC7469B16D3BCB6E2EBBF7
      A0EA69AC627EAE4D9E9C9C2CBD836E49582C7DBF1DDB3687FA029BDC5101BBC9
      D467C720157E9E6D98376CBE66D50239A2CB56E5D8788BBBB5939FCB8A288CA2
      220368BCFDF4FEFCE3B169F276CF61804602FA07FAD33EAB7E12CB84D95A778A
      39C3012F530D16D56723C35E5534C6046772A21B5642F08A26BE5CBD7D04A92D
      96A0DF9367ACFD44CFD8325AC2A0C75DA7122DD0835E5A60FBD9F25BE16483E5
      7774D948025AB672B1870918F7A1E51A21E5F3EEFDA17869B072C92783EC1CE3
      D098DCFA7DE0A23F8A0C2AAE232A1273A4ACF4EF0311FF6558E2FAE221F2C5EF
      0917FD5521A331F56BE073286B96F28453CA30A18CD2C98CBDCFE87390510799
      6BF23BF97A3E1758F9479536A0D46F321039157A51DF49BC669A8A4B6C92A5FA
      25EDE05853EBCACF28D5998A0EA2A81CC6F3652B1AE20A581F8CC9D178B99C92
      BA6BA914BE40C8FE8CD8EF61D2E78A335D5F2C87CE02F8321CA9CADD70AA6140
      AC3FA77619B31CF68981711E3342A9C35738703DC5CBF564167A157C759E9751
      E93BCA19DDECFD9020923956750560D44556767ABDB1127840CAED5D77AA8DBD
      4376F3510FDA45302BC1061FBE6453B882032BB389E90828191AD31374E7D738
      C778BEEAFDEA96BC56C61BF5186F5467BDBD519F1264DE3853598D545E81370A
      191E95C220AD169449CC886B3CD498E7E5B7E87FFDEADBC9F5595B123397A4F2
      5E66A967C92CB20EFD308D65424720B09B4F1FC0C3AD8B37924E97AE579EE070
      9F7AC45F869AA00A7518BBE7D11F701D8FBB22D4B7B94A216599EAC737F95826
      14D0653B2BD25CFF444DAB5DD3B4FA1EC8FD3DD93B098DA62F357D556D0F0AF2
      2CA3B661D9856CD1E3531C0F6853CDA9612C9345085895444A16AAD2DC86EDB3
      9FA7228931E8FC06EEFFECDF7CF6A3EA9803546BCBA30EEE5EDAEA838E0C6A30
      5C1A4E0405B327A0E18D412D0E9258CE76C3527F3AD35D4CC54FB1B34010CA12
      6F6A853948054FCB8193E617C5E3988AFD01C8E76D78515C815F7687E6787EFD
      1F859E2F786DF83B372F88789EA5EA2FC07FE426834AC0E5C95436B5016D3D66
      D8D294472CC01F96263F1812ADC1CB1F41654F3F270254AA9FC3402426105F90
      2B30FC2D06CA96C2BBEA8CA86F4643B2A468884932A506E8FF3B999DCFC09AC2
      EA206A7E4EB428873973CC7F001480EF805549C56919C43603135EC208EDAE77
      B1D05F5A5E316440D55E7C16A00C1FE30CF3698269DB4EB3BD6925D9540485BD
      660F54AF106EBB0A96AD3F22214DF2F51F3391A12EFAF3C783A33B9AD9A99B78
      7034B5F2D93470D4D5A8336B4CC544A02E9559DBB3F8CA8FE1BAE8664715666B
      B6CB9ED0300E27E1BF4B4DB7C9C9E803B31D44492633F7B0AD5F922AF7247630
      DFB0EA857A90FDA23CAC19966A93710852881B5FE457E1800B3AC2D235196056
      1CEC5AA1EAA5C1BEE358B767C1356816220D3AE696DFE85CA526DFE3598E35C1
      7F16F0FD4AD53F5FE3197ABA65F31DAC3D0419FFEEE3D139B75A4DE2116ACAD8
      6B8F1B8C5CFA6948450819A09EB52D5B27482B1E04BEC7DEF00D2B8EAF87D261
      1245FE3493FDB1256B429242657E9B60C7335F88BFBDA18A40FC80A528A5561A
      3BE45E9EE1A0C7A29156980E661320496AEA5A3477C192022AB7561DF174B975
      A61A4B11B247FEC6F592AA83F2D69110539A448038762ADB036EA10C78FD8A7B
      540C288BB914F21960C93AB76EC9D484F2E4426569AB16D6C4F66239CD1A8774
      AB992BA4DFA2ADB761CD14EFE4866C9B2EDD93F83E46745D81F7F042DC285B05
      EBD988B3878C2F651701763038CCD388269A47E194CB594FA8152C58437A148F
      6E48056BE27A6A86F39F03437EA59AB2A383F303EAE87F70FE0561C50260B376
      78874E20BD49D89042ECD23987031ADE5063D152AF3EDFEA4734E901FE418602
      52701B1807B67CCCC67E605FC1BF3781273B4421FBBDDE300157D300E48CDB85
      2D9D61AC248E0487B78A8D2E3DA151AAACCAB17A7CF691FAA512F6020B60D7E5
      1448E7F4D3EB57D47C582738A8DC064A8F28E6D46EEB8648792A7CE08FC51364
      F684D045E22AA0A37BD1C1F3FF1CC4B274E4019BF923AB31DB3B4B4722950EE1
      17A91058FA2E352AD537898BC764074FC28A4DF350D4F54DE34E46E188E78660
      4323EC67541A38114637A081905A8A1A07B69867F7E8840DF5520331AE4FDFC8
      2E3F756DC38A22F55F482187AD7F4EAEB861D8D94FA75FE7C631009A8CE2CDEB
      1A51DB48AC689F41856DC8527980A5A48D3CF5E30C0C34329515B194BA5667B3
      C178B340F1004080C57AF2E1EC5C1D3D1C7B10663C178E6E2317ED66EDBA1601
      8E66D3281CA063B2DA3BEDC72F5F3FEB8E92B2AFA24F7DDA87800D91F4349544
      2E9BFA45BF2013F8A84BB9654F0C20D361120734F9C104F5A421BC083614282F
      35E8C3CC46FE93727AFA19C830CA56253625EBDC2D0723D43C6CC6CF553CAEB4
      2EB3336A1E231F5A50F7BE75A09B60CCC514314387732BE16D4213E87B28BECB
      2636AC82BD133108524BB5EBB73E63672D9C8F0247705461B0DF3D4D70A0FB94
      7171EBB1D0DC9A47E36D0913CAFDCFD399D089D7321E11668A00E013F58611BB
      95A7FA0B1E884E777E198AA2F7B1D339901B28DF37059D1992B9AF9BA61FE358
      F143953BAF661C32CF0AC4341528B20343224C221FFDD7AFEA20B6FDC3018DC9
      3C09A35C0E195457FDB06BFDF035E6FE4D14643C6235CFFAA267D4C125F8871F
      BEF050C9ADF7818873D097C805CB46ED9672E6FF40A7835EBA3010E86E48FA59
      426B2B0703CE0EA001F24456402B3F701F674CDCE6B7FA016D507E1922205DFB
      4013057C6B8226DB08FD14A468729367124212173E26345D80851EF931FAE83C
      997F8E328B59290C25BDCB4C4A9C5A17248319C5B5B7713608A62D4F234A83C1
      180F2527EF923B9A6292C28773D530DF31F47D0FC6FE8A336B7E938742FDDFF4
      DC9ADD05ADBD1907E9F030C18886F86073386C8A2F8CEE2899C03939F03200CB
      443931281781080AD11D69094D781E6CAD1220B9D5334055E684896B417A6520
      754C197681BF4E75FD8C4E174B140DC0BFF4D45DEB2699D1D328FCCEF481D39D
      F647FB8FA9BAF99E539D9CC5B9E86B93EB8444BC9086DF5A0B2A6F5EB6B6E5E4
      D443645F3C0B6B1F707A35510AD8F9322B7CCE8FCF1A04867F9C1DAE62D39B45
      E00F41DD254407CECE8EF1CCD6096D6B2000BB7E29B46D12080CD63E146B0B4D
      7605187BF2E9678DB1BA607EEDB0F5C5767F4A3CF61F0706591F88ACABC25325
      0EE92DBE2F245542C5E0E8BD385AB52B57C14E99A1E07BE06BE05B7C3778AAF6
      FEE3871522AA711DCCB90EB4EB4DCEF1242BFE97300E5055F6A7CA7B87DF7EC4
      1409FED32EFA0A680A459863508A0B4685E0683A174668277C96FBA96C988245
      9DBC9AF2221807DA7D1945C8B3700E20F9736F7BCC0C626BC45E7A7758840AB6
      085A411AB5F6D029F736D535E4C948507F2172C32FBD59EEB7377A7BD61E410F
      166BAB6BB2F8BCFBBDEDA6E57AFB1CC39A2AE98D793315F07252814CFDE3EA32
      9DF7A33A7624B1CC3C984CD0158F0C532D4E9EDD654358AAB7A833CC63584180
      B2E270A5ADA98C04BB4B821D5F8726CDA124AA30D16115E24AC039ACA9B8F24B
      5D4982704871E95CAAA9DBC87B16C60B3F9C1EFD28E0278F41DB4166470522B2
      63205C8AD1E101A7656091ADE50FF13D90C9256A662332CD611887D9D8A46CDC
      7B9CC75812E947869A19B7DF73D68F6E6A43535B1844738948D5768F92103878
      BA8A2671F22595745D8DBEA68CC39528AC8221B0829D035E6896A8D0E2C0E21E
      12AAF1EA6096220704BE15CA34F570A8310B1B07604A32D77A48D33A4A063213
      0634375202A9E0D8C2849E80DB36148C555F4CA03FCB853FD9E51FC594F95223
      87548C42A0C19B22C387BB90D12BF0423482111FCD08AED2E266544540859C21
      FC51EEE087CCC2E1A4745391D363986E9DF70C67DECF72ABDD327C97F9EE1176
      3890F9CD24F189D132C632B20F06DC7484B2F707A9F033EE7136513D8A916E9C
      7D7BBF41588B9F9A888F83B1F14BDD6F97C96E09A0ACBDFF74723A3713F2BBC7
      CECFBA3534B24B8290EA2FF1FA5581AED8172A20ECAB5C8269C815CD95E75296
      D3F6B9591F70D81195F85D517F4DD478B92DE7BEB57D4E5FE9A2AE74422BC580
      65292587E91E0BF92CA56634C970C8F977F885AC2985EF648E97EA75C185A4DC
      E1168B4F734AA1F673E54ACE4BD7B22721C5BE7CBC4140116C80C1CD1FA8E976
      9F9D12547A27E211963160DEEADFF75505EABBA2C2FB7D3C4CDE56D00D9F9544
      DC62234CADCF9F0E3E5ADBBA15395EB90397C81457D5326592701BA3B1B8A13C
      56EEF2BD2B6BC5434A13BF4AD20BF5EAD18D9480729DA0FC0AD6043B8C1727CA
      8BC167584DEC63DE9C3F1887825E31CC76E788A5DCE7428EC245B69506B27D48
      695BBCE23CE0133A8F72E7422AEA6260CF1575648019782C70D396BE6A4BA7C7
      E362E7981D4F38B07582C73909336EF2086F50BD12045226280E00E0CE442ADB
      9C68D8EB26DDD45FBD7829545C10BFD0D504B85520F44E79138BEA3829A9B1C0
      7F0C5890AB8BD71D14255DD6D1FB830FE5BE2364EB21E6C1CD6978A9BA349780
      7BE94733343375DF21BE9CF05AE309EC3851E539AC741DFE5DA95AF286500D92
      D53781362793304B98BE532E2793E7DE7FFDEA46CE9ADDE7EE7CAA9E978A50CB
      499C589423AEC13616F14C39ECE494DACA786815B929A09969702A68630674E1
      472C21F28212208CDAE45789442C0057C26D5F08230154C45A0A74139A07A81B
      AEB8E389087696EE47DC4314444C597EABF0DDA5EFF553B278B7A5BDCE67786D
      F06E915321152FDF8E6371B9FCD35DDD8E8D5E7C0F804EE158BEB2D98C350B46
      1F667D18C1224353164E94F74107A05C001F9311A42A1596C6AF480996739D8E
      74175BD49816B55E29790252230B412F26D324C598D7E1F1870F854E205B8E95
      D6DF97A132DD3085E7447FD415FFACE6A21919E1849BB2770F553C12C5FA69EA
      1592782F1014379B536B5FBFC2389A724A47A8F9DECC3BA7B5B289CA1D3C9B40
      B6F0B5141196704D977E14BEF5B21F7C38C347CC3D101BC3087E8C3E838CB51C
      655CC4A05DDC7E3CA968D3593A45773AEBCB0A3E3EB9855435654CDD6B8E59AD
      3FE11EB83A7544C3872278F83486397AB686AC4091EE281B72EC5B27B394A205
      B76BBEF292BAA4EBBCE61F5DD22F53C13DC7D004C98ACA977978C26B608D0BA8
      71D8D5749448A59C0B61FC5C9781DDF93478C84CF5EA87EBE69E5154D1889036
      278B69C27C051E61D843F17A2BF609537754E56A5CB6842DA0B07CFD699163B8
      5C167DC0DD9AA8B1E4299965F7973B970A9D4F6F153A97BCB5C479982390AA9E
      713F2834EA177081ED52EB36B9EEAEBA851B68CCDFC44FA16E56348C0B9FA40D
      7D7A47A015723DDC22937295B6F22C2B3B921DDEBA93ACEA1F2BF29C5ABCCC5B
      C87215CD2FD2012F521858CBC6373ED33378FBD3956875B771CEE877750A703F
      F3DFECF77DD7FA09902E5A6E1798B556F1E646050C50820E979F928507B4EC0C
      87374BAFFF430C5C411E871635D879060BFEA91B0DD5CA0785B8E6A34717DB92
      CFFEDDD901ACBA3AAB98DD76E4AF43619C55CC86F3E3336F6D89E199C3DBB02E
      E816A4CB5F0910D67E1514AAE41C9B4B886B320559A5E7B67B27A71C913B396D
      B7F405CB6F04BA0212D3902B2574B2418636859561E7BA30CB663AE2A33A937F
      1F78C506222783015AA4BE75998403A19A89FB38F270444D0D3891A1E28B066D
      F8731285D958516373073815377D2B35721720D54586B35F93A96CE74E0609EA
      8624E28C8A745F62D1F5145BE1B3456022C2527652D74909935298A5949B8356
      1EC30E4C37BF2F234968F6605B9CCB909BA34BA7C4DF311C865D6C7070937500
      ACE008FD130639EFF3718CE1E568E6C0D95488E01D0DD33248AADCB46C3A6F7D
      7D6F9D49F3790B717157A2E71683AF02BB078F1EDB52CE87B9B4C8B2511E4A07
      A47FE98711E58DE9348272CC9357E649689CEB40ADDFD11139DFFD3D9C4C531A
      F0C16DA9506DC5F03FB90FB5EFE10CB07890AB1E53153F43CAFDB0E81D7C49BE
      2A7C6CFD24A2A9F546CEAB830F9FC4F52CFB9804F8F9C730FF69D6870FB2D93D
      7C52B312DFC811826FE40442BD931551EF9F6814AA6346A19A71742FD2A369F1
      01AF4D8F269CDBE674AC3DCBDBF7C87A426AB0AD21F0510A5AB0335545794861
      264B558EDF9958EF8F40B5EEA7C2BFE0ECB3BD547041065CB10B7C37C54B376C
      2E0080A48BA3ECB86333705E04075A93576567F397E3CF1F0E0E8FAD8FA747C7
      1FAC93F71F8EAD4F071F8FE5E0BBCDDA71FDA0153FC780257ECF17C8EC4D110F
      120A67729FEB0949F0C222AA9843885683D4CF36AD117A0D447078CC1BC0FD2B
      E42C9304E37A52105B4142510F4A030428B41AFD70C310A16ED31FC40867C661
      BE188540A8F07F3665EF9DCD43E278EA19791B06F39DBB377CFB3C43EFFCF0E4
      2B9E2B67DD1645B05C4EB1759250D0FFEB74EB4FB2E962F6C3D667CC5E4CD17C
      04D5BE6830AE6B3EB069E434B77E393DFD2CC342AF5F61FCFDCF01897E9A5C88
      07BACB9ED799B892A8C4F7E03225812438B548A5E694D26B5165B3462147A5D5
      DC50D95C78E326DFD460B5ECD9FCFEFC6379888B4FDDA041F70BE37F82754B82
      BF5CA4B1219BAED768B68E423F4A46D679320D075B9CB6FE4B924601E8F003B1
      65FDC8695F32D07F894D4C33E4EB0012713D85CB370B107560E0D267D9ED97B2
      F8CFA84DF51731407F8A64799BA9C5D44E73510324C9531A66A5E6FBCA51AAA6
      A9F9AA52434E37930181884942BA9716141CFC490045EE3765F649B5B6C8351C
      F883B128D539F0704599A0C8DDCE6572A45F1EDFFA27818D9CD23DC4B1A2B0CD
      C5552701250BB29F1EF0099E2DBD815C9FABF12DE6AED8C53C53301F13599E0B
      4449AB553230370B883520540148B695B36F28E47E4EC5031074E97A075AC4D9
      4A5AE90DFC6CF93D0369103DCFDA651F0179965673DCEFE31CACD854676F2F1D
      186A26188854ABBFD4CE361BE97296510E0E1899581BBB6BDFDD58D3643A8B7C
      2C4BC4A2010CB255E241F399BD2886A72299AAEE5D532A49D509F53E3681D8C3
      AACA2089655F9BC20E82BB0272F6C2D7320E6582C5F71C5211CE43DB4206F4FA
      26645C46634ADBE6E8B08C31600C57856F77CB815315B7BD0BAC45475230D9FA
      49C4D5F1E49044FC59597BA63F5188D43621D28741EE933602BF7B2A3FB0B60A
      A06C1533B38A8460AA260B54258698F405C9AC30D60613B6702CD76270055EB5
      280DA311D8CC08EBE647A93FE1DCBB7D0B8425CD6D56791C5B4709D66471F022
      CE41139565F25B7C5D3FB92E4C3150D5635417F5E2C319A594D2DA99BC9F1A1F
      2F980A863B5425F8DB7D31F0314C246B66E04FB2E1CCCA2681B9CF42536EBB96
      A6DCF6F3D0D43965F3800438C44C1E30230C6935743BC8F3D343A5F395B2A922
      319C4FA62A612845F0B6295B8AA2D980B1178543AB7421407E67BE36940807D4
      C93112A77FFB70343A2F37AFF82899E18B1C46E1E062F55DF19730CDEA18C0BD
      74D7C5EB570A4B10EFB8268F7C55B26E4EBA466509B6F65EE9A9A9610046BF44
      485C01B9385198AFFCAE58D68DDD664A156567E83FB0B695B70C801D27F98E9C
      FF787B412EE5C3BFA622CB132CD1BEE22246EE7522FBBFF8233F5C991DB331BC
      97E30186E12A5D468EF114953905BAE1CD1CFBC42843A93072B90CF1E0C3B9F5
      9FD6D977C10B0FCFBF7C80CD9E2C7DB3E4FF2FCF7715E5328FE51EF889B70269
      A0392B058B28CF1A3B22CBB0C88510D34C8286B20555F6B38A80C0CF0C5D5349
      46B9242B82DCAA44A9065E99AB7C0BF814DC54384AAE43C780DC2915782CD801
      2C9686C8AE6E9390C9AE7542754D58BC84BCCF08CA7B8EF3FF24C9C488492526
      FF9D20A6A63E98D37EFAAD821241A95BD8710BB968458D9EA560B177ADFF24CA
      D9337DB3D6CEE5F6F53D96014DCC906F457EEC628A8BDE53596542427F86C918
      20AD35E0A88EEA46911C7577218F9C6C2C948FD36436E202FD2DBA638BE78061
      41956A997293E562C25F6D87832456DD25E7BC113B95DAAE2B39130C28EB32F4
      E97BF5529C9D13973AC494DB30DD759945555B38FBC1E7A6A2D8566A58355073
      BC577B1361DB896C40C08BD236547FCEF2A33828417767D4A4331378DCB94AD5
      F840F1EDEDC04F2F10702844010E117E8BBD7375435AB65E8FE0326B5BFD555D
      2D6F2E5FCC0F2CED1F1F2F43D816ECF402A18C8D15943EC07D6165EFDF4A991C
      8D5B4328A85D80BE31E676684A03E0A394CB73DC1EB78A892913618A98EF7557
      12B2F857D8FC0BD3EA50CD1AC879CDD8653599A5865395391579DAAF186240A9
      D8E8AD6C2210C4AC6C4060DDEE738733565BE300E1C75C24935752620D69CA98
      B37B3D05B08798AFA6699FCE67071B4BBC10B5B2630A7B57540214339E5C180E
      438C07C875DEF0FD3BBC1EF5FFF35FBFD27DABD596FAD4815E4FD8E22F65C39C
      C273AB1820621CB54AC4264305EE611ECECCF4A7BF0F2D6599CB02B2351A8652
      F0F33BEBB6CBD9B544D90AA63250211B5D27A35124B3EFC9B71B46617EC39D3D
      E5F579924492BCE54DD2770BC405B28EFDC120F7FA612C9B547320820F8D7AEA
      6C1361F1F93169EABF1FC02ADB05E1AA8BB4B39A3A78E0DB151831A1A60A531C
      1B55AD832C27830EB06F8D244906854C09DD959A4FCEE63C5DB75D79DD37E597
      DB518BC8E74B40140E0243CAF760EA4FF0827B479FDFB36C31D4BB40EAAA268B
      200E15B44000B32C2E69C0B23804F01047F0A03805A126CAAD67B52F8BFE3004
      2B02F31C33D540E76F1600F5FF5118AD44B6EAB4B8AF671845E124CCF5683539
      1E82F05EA502F5017AF46A546598908922A2394515DF82855FE505816C72F6A1
      2905DED0D1037066EB277FD29FA523916E591FC1363294A4735B346408305B35
      F997D2E555139A2FD9C27280835C05250D9AB1648F92FF6B5BCFF6DA913207EB
      4DA9083B062889ECED66D506ACBE39C3620FF3DA3467F8902027FB3771C4CD3A
      DA1FFD89F8802D7FB6C3218F7A89F30D6B02817D7537EB8D4DEBB40A83FE8883
      8FD84F99E34C2DD22748ECC76ACA7508BAC1F67F91D21008E0B781CC74976DA3
      48092F661F969B4965C0B86F4025CA8B566CD403AAEC17E57C41A360DC17813D
      FBA09CD50675E7BDF83C8241FBF211AD105EA8B92F1A7CB15D6A9D8A7FDB1759
      843D2F419508B5F18DDDCCA463CC976DE1C5DCDADA10565FA099C023E033DD48
      5D0E2D23E7B76F6D91576B0B6BA5F3C20D4695A13C328B674D21E14CA778DBEB
      57B1548D4E8EAFAFAF2D2ABFDEB78EAF7DD2D9A3B03CED8187BC490D69227C6C
      20A7ED18ED0E50E32B6653FCE8363D6B0B01B8A55F7DDBB6690CD911BB031A76
      B7A55F5C5F73726CCBCB8E4F4E4E76D43EE51C381AF49587934A73787D264543
      0CE01A839CA754F0942F76FBE9C760C485FE2A47B4E18BAA3FEECA834D33604C
      E128CC33A52ECA815DC8C63E9D9E5395721472029D4F55FB01F6639F84B1283F
      DA8F6F26F00C7DAAA5E6FD182541E6C64D52C977CAC3E238958E144F34E30AAC
      1B1663CAB82A7832050D055F611B3924EAB3583CA07B4651625F6C9DF6B19DC0
      FBA35D359D853A2FF8C50EC3F248B25D301AFF07415FA31298A514592ABA3514
      06DE02342D63B0EA225C1358C6E964533DCD6CF943C6DE8F62381D78D11534C7
      25D0EA592A0A3989A60923919CB13E195F5139BB342E2827C11C9B597A65E7DE
      E74CCC82E4A1107C39F81D9FBD7EF5A14C1215803203901045B2D3DD061E0055
      C9FBB0B754C637A3979AE778926A23ABF4890196915ED255998D1A95E4A17393
      8D6652D54C4A90290F8F2A4D9AA551448A5360F1CEF227126107F83518502F87
      E1AE6448FD3069B7D665423DB5C36565809813B230844D50CCE2DEB7BEE879BB
      94A322E7194BEA531562A4F195B53D568F89FD9E911E7373165E03DF9C30D4F9
      CF9CF4A207F1669AEB523DBE56146E133D3EADF07A737713A9B24E93908601A3
      4919DF24B128F5835383EB31E8CB13B9A224B940FD71C13BE21327B3C198635F
      18531AF000944ACB290A6CCB9655EA7DDFC19D18E9C5B9293EBC8C3FA1C1E5B0
      0EF51FE4FCCF8CA194CA296143540CF3B1EAE8593E02867000EF170E6FA46B32
      BEE1FECD5F6372D06FA989B7B4EFB9A1AF46A8DC431C5F8A49D0EF6EAC439F02
      8146AEB05CA902A73CAB4FDA786C9450E3216006434AD2A0AF88BA39CD89DB12
      B12543DDEF4B73B2532173DFD88E3AFC72A83DF0A4A22181D114F4013F96739F
      35B1C1FB71CC88D665DB08A71CD313614D600E1CD8C54CB654003388A87F029A
      5D482EB1D5049B726EBA3459EE09D16585EBE53EF1C7E25E174C306CBA584983
      93ACC1C25E661C1AA7F7D0709C03226F5F0EA2C46470A277F9E05DFC542E6BA1
      1D6A0E9E59F79E8FF42454D35EF8992AD7BCF73BEAA0BD3F88F7D1DEA5B7A26C
      EE72423A1F30EC5C3607403523E76E15436048A05FCC723493FB331EECA9389C
      CC6E571E0AC5896966BC6A09CF2854D942BC08BE656C526E8C9291B30FA0E64B
      1090940FC80567A569E3B0F0D6919FFB6AE744F5628BB1D51FE4333FE2DA4A5E
      088C069ADCC015C7F27DB5048073BEFD7A3261AFCEB0A5E1DBAB346D8FE08D68
      D32B5046FEAB3C6F2A0833C4868C886D20897565D0F80034B8FC91E20091800A
      E049612AE37711A5619AA23991F8A5D2B5966FD26B58612066E966BD821401A2
      0C29297A14B74E512E2C7D8EDBDEE1DBDEEFC82D7A7FACA074E9BF9851490D97
      72E50A00192DF06EF87D8455C23DD411C8A9AC11098588F26C82DE502B6F8DC2
      D8D0FD0FA66942CD4B9392FA549AB45DAFB30433F265CAE237194410295EC019
      B5133C25EE98850795155E684E71A2188B9E5C58D4571C7EFE8AF91DA2D4CB48
      FAEDA8697A61ADA11289D370305441AF81218B5250C1D04F5D69734947C74391
      DA3BE8F39E6BE864319D3070A4B95336724809D70AA75F64F62AD3A8A47B5A95
      95644C4CBBB7D51A92B2CA5DB5FDF8AE7EB906E1EFEB5A4993A800D678130D2A
      A4791A4920A6F88BF14FCF257D103B90D14C55E4ACBD881C2E21434D46A57127
      38EEBBF0F31D7C3A7B6F6DA34BAF7F03A627C8057406A460AE61AD86BC5E7275
      592895E95EC82AE9B438A06D8C777307E9FC4A70DE382F96A9480FBC063D8ABD
      6B3B484D949A6A7DC612B664966117F24CE5B85F1F07AF5F91AD1E7077724A9B
      85CD5566A5525B6FF6229420C281A23040D51695371DD0A64DEB7796D903D2B8
      ACFE4DB2860873D3E415D5B072A97316661A50F14BFD7A6C6FA88E9374A91E06
      AD86CCC83A2AD9337810F9195E062FA20EA3308B614FD273837E0110EBAA0A48
      D9C6E4678D94D92D5F22636F08F5C3A44DFC806E10ECFC4DFD5A393788A2E4AA
      0A9FF6A08CEF85A0393D3375F3F73598A1E353076A589896D8987F8FD59D45EA
      D92D9CB7A83FFBC84777223A22250E9A14E06F4C01F6D63B05F8F5AB1F5930E9
      73DF936C0E1144866328558A74B918E5DB6ED16B1D3D60541CB18B190822C5D9
      D971913240393C706DAADBD1ABF0168DFBD9DF2C64FAF9E3C111DA84380B3764
      62C96FA642428E1CFC69EADF1444C4B07CFD2A936E7D710DDBA439D017376938
      619BDCC7502617C9B393978F413A7B9593B610B24AA0593EFA1CF330A604A582
      94294F0BEB5112E9B1AE88B00D01B5CC4C47A563015ADE8611BACD09F96AFD88
      B0FF177195EDCB97597E7B2852B8AEB8CFB1C48F3063E50021B761277E9EFA71
      06C4402195E2D0495CD51EFB1C6948A623B98B529728318987038CB85E2C1362
      1FF300ADD37E14820E16EFEAE0BCC79A9AFA951AC88014E48CC9CA7BC0134504
      C2B154063EC17A6B2A77CB30E22E5F90B5D6DB01717E85122B88B151CD2EE779
      53034DA0EDE8F5AB19B59B886FD4D19620646D2B98C862360E4B5501743F6DAC
      01653C6F64E63EDAD85161DAE26F3C640E2366D1CD6D22FAEE95C6792DA11492
      2D11009A7CDA5A71DCA66B6D9321B3677DF0731C6CB853F25602A226A01AA4DC
      206496AD22603698EE49C3FCEDFF542FFEB71504CEAE48275FF2EEEB765CDAEF
      BCD47CBE1D63376E6E01B4E45DCFF2616735497B7E411BECD1DFC766E37A345E
      3A21DEC3FA721F15672E22A29C30492982A483E24AF30A29D555DF224A290D40
      2A7D3D3FE990AA994A96A792FAABAB5346DDBC4FAB5857F6F7C90A81CC1930B8
      3AE72A80AC62E553EFF78AF6589ADF5BC98CBBADEDD14EC8C58431AC728312ED
      A58CA94E8253FDA7186791E21E793FFD4DFEFE9D493DE314BAAFE8552290F107
      A994EB420BDD462DE8EC988B6292286075B45C095E213FA653D46C473192AF71
      0E7DA373A8B1DECE21787A3F1C80F606AA5C6BB3CE16F3AF5044ED9158DAB077
      FFB700EB91A06E6FD69B077E1C66F2D5DDCD7A75118FA24D7DF761186F2CDC87
      9841B399AF3E12A0B2C79BF9EAA91017FCE6DE66BDF978168FFC345470DF3006
      09623D0A371467FEE94FFD8D95A9605E5F89D1A6827E9A14B269C3301E9D08B3
      D18CF166F3209FCEB24C638DB359EF0E66C7C6AA05D9950836F5DDF3597AA1DF
      BD61DC0C2537C3D9B17128BCA443A1B9DE0E85854696A18CA4280E6F54C2CFED
      962197972497D6BA93CBF22965237DFA479455412D7965C009137A35AD50FD2D
      3703A62089613CCC78DEDFEA77410D95C7A5203EA53153C27701CE6DECD9005F
      C9A82157A5AB92649DC18CF468F97DB868074B96693AC18DAADDA81C87B52DEB
      43326BEB2BA50154FEFC766B51A932C603A9B069A7949DCD714DDDC616239CD8
      5FBA94B78E014ECEA0BBFD1A2A29612A62CE9EF17972028E4E4308606873D9E1
      C45F0753159CFD6D0551FA4C0CB85B811CDF430D87B16D889A3521BBE885BA37
      F01D4455104E7EDD05DE9B5F3B1DCF851F6EBBD1811F5EABD5801F8D66C7861F
      CD46172F69351CBCA4EDB97849C76D34F86EBC04A8B34DCBD8DD2E5EE4385D1B
      AF725CB80E7F7AED065DD768355B2F4AAD4B984359C604096BA94EFD17A634C8
      AF2EB0337912FF570BFE67D89C4E782FCD33A19C666B02AF8B18BDAEC927CF5B
      514DFC1B361E960ABBB6B959E792018078B98AC1D259FC43BE2BB32441CE20B6
      F20C1F1F3B3894654809558AF4159AB8C31D3731BB0514EA8190495BA5AC1E90
      3D8148432CA62331A824A6C9C9B85F7F23E54101CC70AE46A94F2FE960D80397
      53B094A605DF6C1DB304D8B2B6E1E3166938DA92A43154850E3CA414D7725E98
      C6733DFB6932A192046CE2B59A7CCCE8EDFF546FFCB7055D2F5E18E0FB722E0F
      F781CBF2B03C0A48B6A32016925D85394D192A67CE9572D3781E182596975AE1
      52CE2C98E593291DDE48542B3AF5DD5A85FEE3F5AB25678462AEDFDFF6C1965A
      4939C32E6CFDF52BB9F9F08382C785B821CC2EB2F55507D3ECD63594278F2535
      9CB66838EFC3464014A99786F596596FCDA8BD8585D8E4729807A7EAC3AB2618
      15FC38935C843B7FA7B318DB7348B6ABAB7CE5708ECA6880B2AE328457C22963
      8B1F8E36EC2C96B38FE483A9978294249C0FBC4D5EF993D3862C7D396DB7D405
      B8574AEB95A49553572B713D10C0C2A4F5B1BF537A9F0A303849986B316E27FC
      5345FA20157E2EDBDAE1FEC80ED77D4FA8729C727965C1F8F795CB5BF829BEB1
      F5F53342A0303A575123C055FBFB96D81FED2F7BEB9C12FB7FA586550B886594
      87703F3FA20D592DA01AE1FB16F28B48B0CEA60927105998960C18DD8276318B
      BA92D308C3ACACC2E44C9864F530F951E59A1F598371120E28C17E2536E4AA53
      EC29EAC2CD41B57BB4806A69C44251E8C43D231ECBE98DF652731E8B8A468D02
      23BD5EB761536DC952EEC6B28029A0EC595C794335AC8CCCD33419A5FE44763A
      DB96155D8501B33AF365D9B623FAD82A9590AB369F5FBF5AB60DB743F285CBC5
      E4D01916A2BB72EC36A11DC585B0C3D75C24BBD4742A239484EB10C93082C44D
      C5C09CB30ECB4371F512F9384D66A3F1DDDC54B6D664C51E1B1113D20AD9776F
      1E5861BD3C099F11667192AFC01DCAE2A81AE99B136879997D6C233340F751A9
      82FA766FA40551C37C5155BF9489A328E9934555320AB6F15CA66998A434AE19
      2B21173B56764AF273F945C39562E155709A15D449D351AE76E31507E554759D
      5E4DF1F4EB570F289FFE93164FAF02E317144F2F9F0856B0F5CA901264A9E8EE
      B942D5564D81A2D1F6BB2BE8A0AD98C22AD07F4A8308D2A2434745FEA084512D
      FBAB5E27ECEA4A2D1765E70FD0707176C14DD913B5863E9697B568EFF0B83198
      7639CF2310D9200DFB5A2B1B2E5F12BD7EB5DA864BABF145BD7E7594FAA324EE
      2769FCADE8F29C7E283D71893A0AE5E1A5886E76AB6AE49D5A1F0F5AA97A8129
      98AE543952D697DE0665FAF61AFEF73031FEBCD4972513C1EA8B4C716312A341
      CBD6F6ED01AC3BD5A1322B404484D4D2494F5A0C2B4FD6594A2F2019C59C4BD7
      61A5677725EC07539057118D2FFC0124A022ECC54FF38A1A6AA62BA571A1572B
      12DC0CDCCEBE0544CFA90E211BB1BB9EBD746BC07889EF8D718F2C11C37B9A9E
      2FE594C8A2A84402C78A859FD6B4E8A7946B6C148FB92EE55117A009CA202539
      7DB4A7A6E2CF33C9C12FCCA1396D5E01FFAD25CB5625D8F9AFA34A0B3FDDFCFC
      2D37EABBD5A9AF72EF028DAEBA80532C7078938651140EAA2B50AFB25B77B69A
      B6ED58DB5FCF4FF63A3B863899387FC16491758EA93EAF33BA88A9AAC9819A9B
      2844B935B40EB891E1292F5D7060DB6F6DFB37EB9D3FB818A5C90C183A8E9513
      E95BEB57991C21D9CCFED9F997F79F7E3CFB4DD2FA433983A174EE50BBE60EA7
      E74EC5A706909456B26BD1280C359083FB5F267951C96A88FBA588BB7028E914
      A71A2AB6B6299EAF5066C748EDBB6859FA95318EF99D1136C7E8A9522124CAB6
      541F73EE7D5E742437D27B49D2BBB1587A979CC9229BFC669DA083514E5CDBA6
      116C6F0FBA271DEFDDC98922EF6F59EE31ECE35BD63FA36423399CD1CC38BF83
      03ADC093FEDFF0BFA5BBC05EBF2A8A9980C7A067B0E44837BC680D7891E32E26
      EEC3E9A9E40CE722CB81C0A7350C8498D44F1405B18E8AC35DA13AB291E31E11
      F01652400A1C220E22C33F2B4ED1E836788893F671B2622AAED230CF71C66231
      F89D9013D0D1C78A40F47AEA86FE381CD0A7E94C9310FBDD13BFD163FFCAD369
      04E63472ECD4BFDD7B5F39F8CF4A66D22E5D7C7E7CD6C0D21D35B5E6D3CFE50D
      CC9723531C91FB70D02C603981061669BE393B3B96D53F8D227D572EB37467D4
      349A013CB2FDFC3A5F45D849014595C80789E0F930AAEA228CE15801AEC5785A
      9639A5F7DED1236A25148734E971FE3E4EEE8904CE5053C7B420E4F8B2E0C6B7
      A4976480AF267A25DBC32924DC55337C5466CAB24D29D03457900F80BB5FFE4E
      A315EC5497B455C696E49885C5C34A904DCAAC90E3B38FD630F2A92F902CA80C
      8752A99B843C86B6942B514E09ABB0C3C7F4477B59E07353341FD7D37DD2A873
      1A7C6339FB6BD226ADFDC436692F0CC3DF514AF6FEB893645FAC4871B350CA95
      28B5ECE488AFD300E8FAC14CF53919CD1E8A9567688C886FF45C67836BCD1D0E
      7C65797C3AA74350F2B0CEF2E8C321F2355824C050BA62647B6541B959F8D758
      11FE291EF17F7FFEB22A24A488D9CF5F2AFD3D1BD6CF5F3603359B7C70879425
      9DC4D66134EB4B15ED053074051B6CF10695AA81C5BAB4BDCD78FBF6BEEC721F
      EFD5EDE0BB37EFDF0FAD6046F927A814D2C4E661D982A37A6DC6DFF2D050AE8B
      93DE71B4E2D8284C62C18D10A903EFBF66546F3FF1B3BCA82D50534523209AE0
      A69CDDC0BA6A715B6942293F264CB35C8ECA445671852B2D385A39796F3A8B22
      7E392A0C096339651BAFEF03925C80466CFC6277E3074EFAFDC8E7A08B0CAD00
      A470624ACACB0EB25BC0219A5064B4AD2B3FE575585053F57960FB2C0AE05013
      273FC53658EA6F923EFD80C893A929DBB5B606C9F4066DC2FDFD7DC2EE2D76B4
      8593308273C1F9972495B29DC25757F2D069B79D320CB9EF2D3AE8B888D447BB
      535C8680024CDC92E66E92991C173D47AFFC62D5C6B368C50E926836891924E4
      AF3E2576B23D0AB52D4B2E4158CACF0084B24B0E3619A399D0CA8A252EB4B3AB
      0D5FFCF4814DE0ED61D5510257914B573E895C881580F330BF93249DBC3FB23E
      A762185E970DE4CB90DB9BA92390A9F6C05E608BB05709A198BAE0CABA1F4A11
      9510536B7D94F793C34619E512503C359BF2B7E8CF0F53BF0281E7173C230623
      615D883D592DBE22F70E00F8879C7B8288C14551C07652211A751CCCE095E890
      B7E8BF52E57A38D15D07E8EFE4429EC755D56399E0FFEBFE6FAAB70ECAC05FFF
      FB37DD00F37F03CA933F463584F62F3997971C2958191660ED5D26F20C6F9D7B
      21B5CA5132C3FB0FE1BD2E504A1EE669F49FC73115EBE22BF37B2631BC72AE79
      4A2108A9D372A5E9D6204A64EB0AE63ABC8FD3BFAB0752E853F39EADC3797E01
      52570098C006D5C9CE44E39AC4C9B57E53699E53345DC2F751BD6F8024DF6862
      A45EB299EC8F8D5DB1CBEEA707BC13927E0A6494CCB2126305DE948A89C07A8F
      E54E20DF48C17D4A614038991FCE340491DB658A06AC7112913C393CFFF281CE
      2260F41C207AFE60843B0BF70342E0844BCF1E09CB42FC52A7F07DD5D895F8D8
      D08FB28238D8AF8F1A373F9185D62E2FACBA338F4514C013AE585256B80A3346
      9C113DCD8B68FE4759AE0A3FAD1F81CB4F3930B60D6F0DDCFF26123BB28D96DE
      1E5632ACAC4DE4C610D9C90CB9304A1A15AADA1F8D13382419AA3444C44424A1
      52A4B4AB80060E75BFE14ACF6DD93F51AA6A33605D84933CEF9CBAF686141BBE
      016117A0B230F6A5D22597D792492BB443943F34415EAE45B30A4A6F03F78459
      BE5B5E85BEC66CDC519C9404CD31BF9D242892FF2C73F9E6AFEF8B7828AA1477
      BE97A1A71A4C39AC5827498A3A14F02C62599921AA2A51158041778835048A9A
      A5B213B3163880AFDCD9490E2B49D0DE0A27B289265E364A28750309D18AC01E
      4432C16FCA86D714B4E5C23A82C7C1D5A402E649AE7B158D0192991237D523DB
      2D6CD7F88635427E5B6A697525B09B6C26EBE8785E0DE3019215288562C4862C
      6D4275A4D825D38BAD30D4E7639F1A60E967EBAA7CFD15C3E9CABF412999E343
      193404B181482989611B3D4A573839381EEDE8F44CD2EA7D9925A78CC1B16CCE
      D417035FB790A3EED8CA7A9460CA908925B338D7A92CD41B80BA4D65CA11B6B3
      6FBDBBC135694BF496D42856AF41AC2F4EE80CC16280BD8119104E818F62F900
      35F51A820E9083A69E4B29CE66BB7C5DD52F1D556B81EF828A87B4B12F515DA7
      8C9D31D73ECEA60BE047BD0A9065E36BF27E25A48A86DFD2744F806842543FA5
      EF8F2157AC0996122C2847059061860D34E50E3266ED32B9284B22CCD5C19608
      984C249BA2E14DF33BE0030168C0B5050E9269453C19CDF5C9340728FA97E188
      514ABB38B80D1A666BDFB0F363EB848C7DB283F06EFD765BFB253D4D360421DF
      0DDE374D006135BEA33B14D11D2C386A551FB3C091C37C1002B810F0A91F32E9
      7695EF0BDBC666F6615C9883057408DD0822F83D3E8AB642A95380CAAF5F951E
      49AFCEA08EB1C9269DD65D5B23FA9EF817E8FDCD992D083FBB91FE59D803F1C4
      B93C9E5D264BA15C57680ECBC3CA1375867387CC3AE810B10476E88F90FA7815
      02597180B002E11B11053290B9733795DE0F73E232119FCD792A8D382DA58953
      2A62918E4B0E26CA18541269577A346AC1A96B32252515DF122929E7AC0C45C4
      DABD9EDD5E09C90325F424E1D690984BA7E466D957593C4237262D5CB7BB5696
      903B07997710626F76A036713D55C302C2380841ECA2BE5D2139E9DE0D53EE16
      19E759D91946ADA4241329B93DF1468AFD00CB08310B34248D5B55B2E9279404
      C10DC88709FBC639B549B9D5889B4A9F1A32DA4B1F20D78FCCD898FB70F93846
      30BD390A337257223CBF08E2D5FA800DD117A19B4A3354D9D4F767C26585D448
      84EC8F21CA082460B1B52D81BA80EB6E599F059D7C166B770A483F85D5A8BB14
      B42693A3AF2AAAF3AD80120B4883FBF75990AA5F9D41F5DBA82EC371F9556271
      5A69A214AE922D194B7F46659E0606DE2DEE085804635C1DE9AFA40B8845EAB5
      1E4E13973AD46E1D569FBEBFBFBF55D04CA8C62F15E4B98B4F4499404B50F8E4
      63910BBD48AB1F2603D495A530E6280B3F744E8EC363B2F0F52BD6CD6511820A
      424437F3B118A65A1C8949F9B67195768F69326665781A983F182DC9580F8F92
      E48218415EE2367E9FB7025F46203E73CB93565306A7A72CCA6D694FFD27425F
      19A73BFB561D23E3FE686A4397B7D89A7FF721EC964C48AA13C3009D4F691568
      8FCD9F841C9830CF3FC36CEE1CF419D3811056B081A6720D6E2BA90083485A4E
      C83E7520906CF7048357FD592E0A3B54814E2A5A72F829BF189E1D9B9E4A31E2
      C85BD1414E2E2C6B56FAD4563767286288BC8438FBD601198E68D684E944A1B6
      8A966974A9621BEDBB2FB4D5A494B13914D2D721A6BD7EB5BAB0D7C6F0FF3900
      1AE65FE839F3B88514971533894B595F84FB28290AAC17B754F74FEC63286747
      F01CDC3263781F6722CDF7B58DC31702354F12F4E9C0CB50ACEC2ABEC54E80C3
      1DCED20CFEFC756ABD519F8FC8B03AFC7238F74CF44BE8DEB5A595CEC6E130FF
      4F7E0B356DCACF4B99658AAF936421C786BC381C722EDB50A6A748DE438F0E87
      75CBEC936BAB1AB6C740FF9743F5BE94BE81A45C79CF234AEA28C52DCA7974F4
      CC6A08B1BCE152EA1C3E47BE7131ED5926CFC9B7A118E284AAF28AFD65FC1000
      02F606BE0AA533B3D85FA900854B4CAE7C1C1DCAF659AC7DC3C73E2C5B69F5C0
      FD19F1319819F0A85293F9BCD1E7CA7DA634517F584A1CA564D2A167F57EE8B7
      D7A4C6A4F3C41A9317E62C3ACB60CF3A505219903BB33E9D9EEB9C4C6D3DA13B
      5886B025E2E8542FCD9C38804D5D3EF7370B59CE39696FCF3A9DD7415416ADA4
      8C4AF860C336F9FAD559324B07020F7C5ED99ADF276BDB3A3452C452AA7DB565
      0E1E1FBC8CA9502CA2ACE7957049C299271E9486A1D0A3E5DBA93799175A1B02
      6500499F01B187C2A00C549D0DBD5BA51BEA1FB58964F3FAD57B8AB45B1F4E79
      B7184297C75D126D65F1A553FF8A70FC4495651723726EE1402923154D603DC2
      56E156296D8D879451DAEADBC7D4B2CDC3D37DDE222277BED8018CC17B0596D3
      683C5E62D1CD0F1559617459937340CBAC85E47AFDEA806B6BF7E60B622BADC4
      8BAC8E0946C553B4CE812F3D078D2D0B275EBF024A7887F50EB057E4A9E8EA10
      835925FDFC4A0734298313D3BF407BA3BB40A78D6F740EAACE74A60A8A797A94
      F3ADFCE20649A1FDDB2B0D55F0A0B4D2EB57C55A32205BB7D4F9B8EC77CA5440
      9A1743114B478AC3206105AEE337D660610D923AAE54913C198DA44F871C35D2
      8B312121AB8D14D8E94090A184834130DD9043DC7CA916EA9364562434BE9308
      514D22E8730655402D88140A8DC24B6AD484D9D4F3BC5A398CC89F83C169C655
      8C3289D41815DF685474D7DBA878FDEA73C5B1F8493A1665EB036DE86B439B33
      3CE4DC781AD332E7B3D0E1D6D2DFE422DB93309E65458EDECEC6A94F04A3C34A
      964FC25C4F2A4272A7E8EDC7647B0C231320946B340AA7FD0451B2F0F592DAD5
      E7C42F512A9DFB446D79823037BC5469118BBCBFB7DDB85496B1BBC8C1AD5CBC
      A542945B0EEE3A5F1CC7E9712514747C7CFB70E7886339433DBFB8082B6A8F36
      31601D87A75DA8007C697D8CD2CC078FB7E6FCF7E885AB94A5E0598DA84C4AF9
      B5637185393EE4BAD28B9387A8722397A8550B808CABBBAE434DF5A04DA05325
      9BCFC185A867AE6D5265A057E148BD3D58BE58AC14CECBA46282C1365970ACC2
      503E65EC15BE5B8DECB2BEAA1C14E49A479E19C15DC9D41C3155EF18D348C7B1
      88B403E314B3016FED50E6FC5E8AFACDF1353C228E3C6F8A7459DB2ED52BCA40
      30B960163F2948C822EA0B4E274657749DBB999EA293E205F67B2BF2F87D1AF0
      54715A186AAF4BEA91C9CE26AF615E00679CD5EE6745E41C29B0A03C8CDD6066
      8EB545E9DE35D90673A314AAC1F4615D8241A9769A932438AA5612A1F3A16CE9
      D34232C9AA659E852F4FA95B44C9F3CA844FE970BA82524F68AC24CD1A7ABA07
      7128E26608EA8904C571CB12DA3D274D5582D605192941A6D34662D598A0484D
      5A2482D9B34BF1D715D6626D0C81506F3215F236B4F1ADB4115B5BDCDD8D82F2
      40002F4523E574AA5B2268DED4BCCFB82C57CDC0B5729A769C706641AA3B5894
      53AAE04F553392575D44BA7AB3FA4D4A29E7EA5D6A9E81AF5726EBFB73F4AA6F
      35182709ADCB667225D77D4627C51135F578CABAD0F6AD4EBA506D1ACA9589A6
      AEF301759D78B467F2840C3B291CF1F3B0A97200341B6FA8274F91AE55E4D414
      5697C67D9573B0FC3107B736B27DBDB3FCC6A38616EF01D001BC39B65DA91ED6
      9621C945FD3E6A80C5A98413D863B857289DC520DE5FAF7F53847877F38FE6BE
      7528F302B9A824E014FB9C1624CF0A652558D904B3AE535EDEADF4D2A97F0D32
      21F50490826D54F2926AD2F5393FFFD6C6CB7A4B8DD37757171157AC5BF5508A
      D4E22679646A292FDDEF57F7C53D04651AF7EDFD44E124648DA148E25CF0C618
      CEE0AA6C0C746ACFF465E82FD0B7EE0048145E0819DF363CE61E32FAA2274270
      8FBA5F0947A791F8AD8858142861784F491DE086588BA054D0DEB6AE85BCCB6A
      A8147BEC2C18D751F25D51653F2819546CAEA288C4E4E0010B880A346CB16FBD
      C7C5F259CAA384F07E1AE321323DE1433BB1E0E141EA8F468A2D3057D3233564
      798835C0D239E9FCA25C64FA26ABE479A5F09C0ADF5026111B43546A4E7DCC8A
      2662D33401604D4A010005CBA20528337E06BF42D7BBCF613E299BA0205D1153
      91A2639F8AEDEF38516ACA51EABAA4D21E71D23491BCEECBA60E5A1A44AAD816
      63B4FC280E1B9085A41A3F1A3E752F9F52A256FECC5004502F07C3939827718B
      1495B48390A1848B45ED2A5FD6BCD8E35270794E2BE852896D2830C486445ED1
      7CE8C57842917C3B45783FC9B6705C8642891A07912C44D11D4364131AD64CD0
      6FA30A7E33CAAF0A8795A54B117C7AAE66E2B1F2D60CFC4CBA32CABD46F866D5
      DC8ABB3763A703AEC2511D55F4857E2AD797DC3844CF2961B14C9335BCE53E3B
      8B1A6972C705995961780AF3142C1D1B249309A7F0C7E47E04C94E0D598BCE3F
      D2E736F6A5502DBA57C83C152C28A8B4D421ECDE2EB570951786D410434CA609
      6CFCA6680577E5734C7516837D20E910F3BEB1AB6AC08D6B38516ACC09043BB2
      660BDB27294506AB1BB0744E80B9028A833F9DAA2EE49A4296CC2709F18E0856
      6700CC158CBC25AF29E50CF914FD8FF71235BB635B7FFA2F9EF1C6F5CCBB96FE
      3E8806D9AE757898ED549293712E0427A62E00F5B261FCFAD53C94DFFA384063
      B78F63A3760738AF71E9C3340AA8EB96519504C007C091B3AAA91C74E2DF00DD
      0CA219F6F452675338D60DF7BFFB34B6CE30DFE56B4C5976D64F619C6F013799
      46FE4064855DB245FE25C49F2DE9723222A2D48D691110913FCBF88B34894E65
      6796ED84AA88E5AE77383ECCA94632931C7362677235D57D0F3434E556736C0B
      9381732AD7EFA3CC8115C7F0D44263E2E8D52C0E64E9C24FFEA43F4BB11DDF47
      6A4FA15A149064904F924968D8CC0976C3295398FD54483A79A51218872AB59E
      1A38842A574BF7889965D8AC895A90CE778959B8C4AFFFFD9B8215AD862317B1
      E48A442397603A4DD9A22293C210BE478F24B006C003348A306B982377F82A71
      92FC5BE89B35DC8C52F81083130387ECC254B53696E006C204696407860D286F
      FCD61CC8B6DF01C5EE28386D49EA9F2F8FDF0E4A4EF63C9D099DD65FDB615BEA
      8AAAFBA2AC2698D41FD5B64A97E7C69A5803A3FA2962C115BEA6A18707663502
      C02ABE3C83FF8CFF95DEEE8B9C9EE4752514F673C1E1E130DE233D83EA34121E
      B1FB1E9BE8E22014A9D265B2EA7A67D73A01953197839209C7431105B23927B6
      9DE1458BB5B8571F35EE0632C281E4A5FEF567A5C8CFA2F7E0C5D97F14611DB7
      15A4C9943B80A0ECA42EA8D384DA0F838C9315B9DB82A23EE46CE1F72E8FB419
      CF46D8307A5B3B6DA9D88FFBA9FAA338CC61BF3B18370A4A5D6D0D45D65124B3
      37956C8AE036C4588467168007144F20138EDC2EA2D76A2F2CF22FA7ECAD405A
      D891148CDDE5338B87C1801809B90B0D7947FAA9F02F649F40EEA79D7161DC09
      47157CD8AE7A1846810C8EDFE79AC326CFB27DA9416EA569211F4536C91E61F4
      99A95ED8AA373A43ECFF67EF5D9BDB469274E1EF8AD07FC0724F1C53DB34ADFB
      C57366376449EED669C9F24AB23DFBB63B4E804051C208043800A84BCFCE7F7F
      F3C9CC2A1428CA97B15B367A39B1EB96441040655565E5F579FCB457749918CF
      73E98864A7D0A5F72C30F9514E8BBAECF8A948A14E4291C507BF5A0AB599386D
      7113AAFC97A8B297E101E5AFF6DBFAE1618CD3240AD3F3FC98834DEF4818F61B
      BDA0FE36FEEEFF2E77F3AB91D79AAF894A4E605921E99A54C82FFAA941EBDD71
      33516CB326F76F11745D62505C45846F96BC34635F7B8E24B9DAC8A9563ED4BA
      FB422F502E0D0E9E723468EA11EC0DDB9AC6CA07F0D50E7E0D7956827E2CCE2F
      D643D2C452CCF28AA1F96462FC6F916288F29171003F591E371A959A5856FE2B
      88E9217E26A8555CC855EFC193EF7523DD907B0F2C2A356D6A5090665AB546B6
      B71708C6BA0E87E1918BB0CEEAB89DE00D6A5CE42023E907A67FD197340E6F12
      402CA06F522FE3B68CD48419D31424D5134190C80CBE8C08340A7B7811F00086
      6ECD33B8B9D092E8FC19CEE84E8111F2BDEB5DC7B192D09B2E9DA8DE43C52CB8
      A63304FC499AFC86747E5779E6DDC614C186774B160F9E1E684B7479DAE33A25
      5DCFDB3500341385C6A511F7BCA9764887322A7050F892BD09BDD7B65DA335FD
      A0ED22A39B449C92223D3A89AA490140798DE474B9424781F791CBF72020438D
      DFD70895FADCC28C48B395D36B3B941963245F8EF694559EF309CF60DC13E831
      5B0C149CD79C0AD1E202298F49C9D099A10B1ED9FACDCCC3CF98352FE696BBCC
      C58266B0504E55F853CBDE6A63E63BFE71C66B6F4FD71E47CBCC2DB03E20560F
      A558226BA20E59DC4786CE978E88BEF39F13982F67BE0296920FD11B8DE4A7AD
      5BF3D564E7C55DF0222CCD294F4047D13539AC3CC86FED6C6AB589ED9AF42ABD
      24DF2C2440528F0260737745F7CF013B1682EE11EC1D1C1D616640CF31842E88
      ECA54B533B64EA3D6A58D25EF0432F782AA3FFB7E0CADC95D3A4199A9E25C149
      BBF56E9A767AEEB757B449ADF00EB36B586EAEE8BDD360231240F37AA339BDAC
      9B49CF3F1BD3B42D63764758146A6F5FE99128682916615A2BE3E9515886DA9D
      1EFA70D26E125CEB39E303F0851A352D8DBBBB7DEE54FB386790EB76B5712323
      3D373F1F0C0292DDA4D55BD2FD3B0FFC7B4E96DFD0E2F689ED5AFE309F516960
      84D9428D81610B04F9477BC330F58ADE54313B1C3094534D9234E653E6DE0439
      EE1EA42D1DB391B87DFC4A35A78185C32B05553AE682D38EBB6B876B3A2C3119
      A9B23B24405D3D08A97B1AECA5A4475DC19A2DFCF23957C44EF2737A5A0B58E6
      72064B091D4D7574454A1FC70706E5E22BA994A591902468491A04C7AB3E33AC
      A6587B4E44B3CE928D9B27162017C2A1D5DC93AC773CB95B3C9B64F5EDAC76AF
      0722798E7B16B75FBB27C98EBCE0228B0BF2C295288A8B9C67BDA8123696BC76
      B8E5690817BB9A641EEEB7CE1F6D23A63765022741EF9642E230003719D62219
      8417055B8428A274DD18F858AA0EE905708095B260CFCE0EE6DAF11343C21DB5
      4E40184DEE1FEA50993BFA2746349FD70CD75049924BAEB9C6509920560B2912
      844685286D71E122F065EA991C56AAFDE085729959FE2AB69073CE8C1CEF9E9D
      93DA1BB89DEAEA713CF35C9B0CF8BE1CA97D824D0322451FA40DC6784F4D5C36
      285214EC70392B409EF2C235F94E32B289B59D087B907502CC4E231E0030EC68
      1C19B3E22CF1261B9B7C6CF12EE2DC11458624ACD898B1B5E7E96EDE9667E507
      271A5B574AE51C7F7BB39C478E9FDA7C721967E704C08BD3BA2FEB9BD0D07CD1
      5BBC7ED15BCA484722075A875C96485FA242A77676E933B941F96186840FB58C
      BA872E2E788FE5F935D34F668CB5725247028C473DA7267BC9237546B7C3DAB7
      37CA82BF4D689A2C55B41B0CBB279F361CE755E48D1A3047FD67F190FC65CD44
      293D9D270697B366EEB7AC5EE57A21794F7E4DBCDD3728624DB29A2F8EA6EBB1
      A570F833CDC53BDA9987A3FD9C26F01BF40706AFD1B66DC4F99435498AC25520
      2A519ED1CA5EA58B57C6888C09239C631AE7C115D6D60DEE70A714F131C6353F
      E53F320D8723B07D6A265D941F07CBCABC10724F0EF76A1C4335CA1C8540CF7C
      FF38608B188B9096B2B6073B4E39AFF31E16B08BD29F91906BFD3B331AEF5F12
      74F9400065C07D2F64A9E38E0BE6A7B3CA9CBBF730810E76755AEFCF7C6EE31A
      447A4EF578E2401C4763F4C34F7F3090E9D7BCD0BC0631B46F868E081AD8B00E
      854127F0DFB89152AA24F9EC5443877970EAC3909E74EDF2821ABECA8CD1C0F6
      A0362DA06E1867804C1938AB523EE2592852667F9DB0DB230D521A7F59D2BFA6
      28D7645664A60594D294B9AEF9549202897A7AF62E573CCCFB0F9BBDCF0F49C9
      164C4DF533FB2156B6E85D945AF20F0767C73DFAE74854FA511E859C74500062
      6EDFE5F0A39487A4A6995CF800F4C97CBD3F3091AF39A2746A86C12FAF8FFEEB
      F4F932FF6F65FD57680D4B24565336BCFF3B224DEFFFD137B7F3BA43EB553B11
      76959EC20A71C9860DC319A2C48AF5C5E94086BD9E14C9A57A843A4A8F4AFA89
      5E238EF2D852117827C7529D5EF1D999FD005B55844A61766A3DB2188CE2D321
      4CDEA3CDC0DE7C273DB0107EB213D28F430BF5A967F87CA7D445518FEC453666
      E51BB437C93AF0CAF7D5AAE3B22DE99869605768F24EF04EA13ACC6860E2B819
      12236DD14C4DF87BDB11EDE04A7A5868433075E210DA06DD6969184912E19127
      E5FDDF7F24B5F74A545F3D43960BE993A7EAEB863B06669680E7FAEE01799D27
      E3B9829BA1E0582E5AC05149D2271C493C71B61EA8D82D455E3C8CA27C92D591
      E05118F3966EA40CDD336AB752434FBA743538CDF631BE888BFBD5ADB060CD50
      2BF315FFC9A06582CDB1E74810F26C96D331DF0DB21B946CE261A024657D63B1
      DA607E2675FD92490042A5306BD9BFB91A18AD119CA2A5E8071638811EDCBCFB
      3047541DE79D18CC7AC3B522D647CCD7FF4766F497B7A6B8FB359851F1358FB6
      7E1401A5B9045D0AC1B19C3E7676E56F98451C53919DC36F601D3FD552348F12
      C5C1CDE635E1406FAA8ED0C105301D00BE1228F10057D5CDAC0E8FEAEA70AE04
      543FBAA7D1DC1EA7383F691260757EB569406BD4B79F0A9A085B251E0E1617F2
      6BAD91BA2FF6D2763A0A5379E961ECA1C4259D5CD0A3D8DAB0C5463EC05F838C
      C92B30EC6A0D73320CF6CE4F8FE0D25C9A346E82DF2CCDF5F387675114F32FC0
      09F855EA7AE76AB9956A997399DF501DD7F8A0A427E93FA971AC37DE2E86AE75
      496FCDBAB27FE194F6AC1E87FB60A05A4EEFBA3FEE71A267E99DD64BBFC96221
      11C06FFB8B0B524F5E0731B5F5A7A389C08E6BE7A98B6A3A35A21EDED556BC3F
      F4F4FEB7590190D08757C1EF56F4D0380BDC49C0C53872A4F68237FBA73D9B6C
      3D3C3FEE90D0FE36E15A7A0E178F255CBDC6C5B6E5F4E1ADBDF3AE5448961C0A
      30D11725359932DD43D4A1F1773A2F4ECECE9E1D9D9C9CBB7E057A3E6A6A1B6D
      0BD682174528E961694568A2CF4E8A0C4EC630E89CA169080B489704B2D72673
      B54CDC768CA2200787EB226D346E8B7C16E51719D2544BD27669C883E91C06A8
      5E0950BE121C3E19055CC1A28D117888ADFFB2FDD2647E1418D6525D198CC611
      48532A87A59F46AC252B82FDF026BB98C0ED019E1003F33BE7A9CC2720D44E8A
      0C656A69CC849CC2C6E4B2D14A7A8ACB2F944853737219B04EE8A77222352F4F
      502A589830BEF3ABABD7FAABFD15E5FD74E5AB3EE8ED396A796F6DAA8F6ED6AB
      91B3201E24A859CDA054BAB6E0467E8F8797BDB60D67167E01D6819400DF3FFA
      7430747D24B50EA5A9E1186CB23D4EAE9378629725A3727A8060D2500600542E
      1FD35D30B8AB6C6359B3A38E167333F352F741F92F29CBD2D50492E4E2496418
      CA6FC86A4C180C1865A6AE6FC6748CC20CD97E3AA02EC9E2EDA2012889924A55
      E89DA29AD9D204EF630F6094B6AE2A6EBB7BE7C0131FA5FF29C28B27D9937DA0
      0FD0BAB8B9CC1B89BC3918C50C5BE27006FE842DF59F6EA4783000D490348A67
      7D54E04BA937E8FAFE85D404902A5BB20C20367AC4E1D58C7B1CE6EBFD23B377
      0C5266F86D4545C72A5B469DFF3B198D499D7766028BB464D1FFDE387F083D06
      3F08A0C3A37BF0F92CC017DD23AAFF513E504FA465C79AA7F73F49C0AFC26B3A
      794B3252BD6AD4962CFCDF5DDBBF2415717E70B6F1ECECEC40D0814ED67BE825
      0BD97934F1852554C58F402AB92A5D2ACAEB7B2337820C1C4BF9498626F0D96D
      909FBD12774F35C9551D2D2EF0A72EF995E96CF5003E6491FDEA87833F829BBD
      62735BB79C082E17C855AD25D60FBAA7B609EC9EAF2046249C0934BD0E87FDA5
      6057C2637B3F73E11B9F52E120E1D6B1F272321CA66CEC92A16B5B7451156B4F
      BB29F4F6A997D591DC48E91C500A8165006B9E4BCC171752BF81A47183D2B6CF
      084C02392B43F284B8F92CC9D06B2FCD1699E7E6BCDA7D7B2C2E0EEB883A7E12
      93F70D248C0BD42471D53B59AF5E37A1807790033584BB01DA21C11F800DEFDA
      62662F9788990392525AF2D0189D442A0E9DF4D25A0F68F18E9DCAA32B691AA3
      9CA4499678C5DF7156BC77850CCFBEC4E9FDC6BD3A3DAB9B5C8AF9B9FF8736B8
      9422363A3B794DDBC556F7FDCC6E18957C18C3FDD0AB9F3757320F94C5DE1D90
      9952371955D3D7D1CA62AC01FAAFB79B3C31C97E5BC223FF0A6DEF7AAF1C7886
      5EE775DDF402A817212EE1412976D6FC5CF85801A54DF05F4E2A8626D32823CF
      5F3119CFAB23DC29A165BFC646FDB195D49577603D89EE72A5FEC33700B15DE3
      14B0B47BDE1FD1B927F713C0ED9A10D0C3320547064B053D6D19A77BAC03EE26
      4A33C9725FC718A8CF6B14655ECA4BF366C155273F2346564DF7A097D3B02B99
      905AD3556306CB8B270CEE6521CAB3BA5A441753EF03EF0429798B6C46E402EE
      54924DE62D461F5F9C8EB6A6CA05A869BE633D92215F3475F30C360F6DDB183B
      D6470D0F7E22C3E1A0B4D5D0FA47E6F83CDCA70F2F8033707EE95A77006407C3
      6789764E55D507F4A1D7395B90BDED9A85D3905BE4198CB9CB5651181574CE06
      25367F9ECD235A1F5FEE5C520E82E32A0CC6DCAEC5B1C6F9E2F73B5C3A9E7C38
      D110DA9C9496D48ADA5600FD0628119B92F654A3757DC348593779DD7A4F7A5A
      035236D5E41B8F64EE930FC2AD31C87EC9FDF15D36AA3BC70678A85C34A869AD
      3E3083D0572AED61D34FF293765EC8B91E9F52CDD711E7C585194FB1A8664263
      51B8609CBF901CC48FD46FE96BD8D34BDFC34227A3175ECFE8557AB599173BEC
      0ECB5EDF787105D0A0332F49C3423AE1954ACBD75B7DA5F6F5518F1054F79EE8
      8424682B56EE1FDC2CB53A0CCBAB5291663243BED9F458D841F566416AE246AE
      104DDC490B7DE63D6C5A1FF23C712F6328A153DBC6DF78AA9B052E01176DD9F3
      A6D7E37AE46C1FBD519FA683BD0A8010F24DBA7F0E0E58CD9E918205B7DA1B25
      3F0E33EF2A5EF0E4CFADFF68A22BD4B557B2C0624BA26E47423ABE9121A1B74F
      D4E8F386E6CA7EFCB765E149E283DEF0FEDC32B8003B748EE14597D5D4244F25
      B081449168331A1ADAEC9596CC595F51276C7121E35EB40BE9C6916474DC78BC
      05A3485CEAB93B358CC296CED031A9FE340EAD5A4B5CCAFEADCF54791549D9C4
      75EA69C61A61B1729769796F5FF231FC39DAEAF2BE1EB9BF29C5D5C5DD462381
      AEE43BDE530AA5A28041921A4E10EA1CCD69DABD5D173A1F395F74DA04F10D00
      4F3A6C21A063F64336C14966EA81D06D1230FD90835F495334AB81A91717EC46
      BB6A2411DBD0DCF255242AC5A0715E8056793BC46BE0409106776A9A4CA25D96
      08FDF04292DEA1702357AFF1F4DD177DB9E68296A92D19C755B8C30D5E9AD192
      2E90AF467E12F553FEB705D202D074CD17518DD61CA93FEFD834BC3DBC2D2194
      EFBB7A5090EEE69276994B6667A24DFB5C2FD9C77DE5257A3AB8E6B0EE054A4C
      582648557AF1920B28B0229F5C5C36562C6D57EFF60E5ADFE28C7C60853740F0
      543D58A94E8DD2E6F20D73CF3E1DDC3D75CD21AC50046C9CEEE14422B2AAFFBE
      B8C09F58555F7F3235BFEF10CC63762A2D4CC6EA99DE8B6EA13404CB5A4B9BBF
      9519B810E5C47457AC287C512106356B163E7CC231BE22FAD87D88C349C1FE2C
      C88B2C574DA14D0CAA91F0495749B1686DB2F874B14CEFF8A5C0D223D4388A8C
      3932B65BD565D971DB86B243F9478DF84E5F1D4E524819CC76BC758B1A5796D5
      6FE3561A4A65DDB2B840CA8E817CE8B7C6C0D485A913F4353E4065E13CACCD80
      413CA9042C24BF309C70446B25CFA83D07A6EECE7273522B25FAED0B4315AA44
      C0190D556F5D17B1352514748FC3BB465F88885B0D1DD55EAAE12CEDCDE202E4
      E08A507D85501A6FF47A96070EBE406D178DD7C7FD79A5E6C78065D4D2A2B58A
      D213070FE86148D5F6D5DC1F137F8C856601729DC8C2724A5C1E1817BC28DA01
      A4218D1C95D81B2A4E7BB770FAEBCE7C614C45834D8BBA2953625BBB62AF9EAA
      2CD75E5D4E12492A596C8252E2830DF337F0C099713BA7346A9BD7D9ED5C9135
      DF481F5E152F38ECCA292F102B043F9974DC0B5E99DB49494726CDFF8F49F5D3
      6440064952C21AE841C1D3E95718445BC30B334FE1EAEEB2927C08707D2A80EE
      6C6894EADD24599CDFD849B0A5D37F7F0FF464C0B3B16CDF335CB50A38981EDE
      D4C0BE56A3719AD33D43BA5D3CE01F96DF63D7D2FD83F74F065BEF69C7FE63C6
      CC0F93A76B9B989EADD5CF580234ECBF463C64DA02D52DBEFB098B22C53867AD
      0C7CFFBB581BD853C153729C9860E412BF41C7359A525B32D7A09355D5402342
      74BBFE1DDAA01E1819EE3C271AC4006A1B1BE9171AC5311E05AC83722D261987
      04C3B27572113D49426177842D5A18A0C344DD971479F58A4E333A1DF231D3DA
      781E9315599D9996BA6529FA6D9B34F4ACD015727BB0B88099B67F2D4D710D9B
      FED484E95336C6232640E0E80A9BD5B23204F71F3E9B0A0D006CC1011ABE5098
      98B0AC003ADD32E92C2ED8F3F36970908E38ED58ECBE795236CE554F4504FF95
      4F0A6BB109B034F909938AD166CB52E9BBEAC2FB3CBBC8B99679029CD6C692B3
      4B6D6E177D6422254E2B2406DF4856AB5F4556AB5B0FCA6A75EBEBC84A54DFDC
      0EF45BE504BCB0D1356321102D35C6CC5447D694A663CBF10BE5EA9845679F01
      0DEBFBE9292431390B22E77362D8902AAB91EB3049A5346E8A82D7C684A71978
      F5F65AAB916B6BE9B75226ADD920CE469AEF91AFB347A605FAB9DBA4365A7FAF
      9D523FE181CD7238AC0D6024039171215B20AFC7D965DEABF5FE72FFB647FF59
      C57FFAFDFE92A453E49BB615D706682563CC465557A2C41CE29668B8B2744FBC
      A34DCBA6745F734154A26415966B48F053A784EBF0C3953B675E31F2D13247B5
      ED0A334A7895F8CB68AE176CC5C83413BC634BBAA4374E397E826567A5299BCB
      DB53DC60283B0EEB1EB5C258AFB23BF8A69A3575CAE197DB5F655FD4440355BD
      A319DF5ED510138435A8B7D098CAB1C9023BBC00BE705E38ECD629562BDD50F5
      9B245EBDC93845CD31EF2C3B36DCCF161ED38D39C9E6EB3EDC93F4E528CCC479
      9EBEBF7D538560B75D02D691C0D6170DE43908FDE0A5380DA2244AAF9AE15A39
      1041E68D80AE7B35333699AB25E74DC92594EAAEB8643BF9FC5C37823CF784B4
      CCDD5C657C142E8B5BEF68A0B454113299DB0F5E59E57DE9045D39E778175C27
      E11457C78CFEAE252F5A8B8CEF2549A44EF203CA5C9E525A5613D2DDC96832D2
      A7D232BF0C53AD4ED21E07FDA881EAA287A4BBAFB5261CD39B76F2CC03BF9F19
      F89DBD95BF9BC0EFE2C2995D154F793545BA9A2C3B8B5A5B9FB4789A0B5ECF16
      1763752CAE5CBD21BC876C272A9F10D715D4196829ED68D7727B993013A44615
      ABA44AB53B1945655D1FEB6EA9E667684AD6D6818EB4F454301D5001F1B78935
      7A69310D18D0241CE58AACA0D366397D781ACAE43733038AC5CE8736CC696287
      0BBCF08D168AFC1C1A5464EEB45EE5E4507E40065C5A251CB6AC8635CEBFB840
      1759386FB8451169E3AC215C7E90A84557B4D57886E05A714DA5D79DD112A92E
      2E40AE6723547F3D4541D1005D779A097022E7B63E59F2FDAF28FDD9B23FB425
      B41558B9EC8374ED2F2EF0A300316614BF8CB4B561EFD77BA51AA580CD696FE3
      F80CCBDEBEBDB76B31DFE32267EB3417128FF2B29864574199078E0FD9DE14A3
      F3309D3FF44A5FB8B8E686EA47129C98832CAFDB57193E6534AEE824CA6FE656
      ABDF0CF411594D3B8F26E320CC33178D69508FDE63A26B58B7CDDE396E85985B
      989F6961CE8E317F471626696EAEB764B82338E6351FAE905FD0CA61D65BE0C9
      A1658416996D28B3E8B36C5691A5544DB87EFB85C9928BACFE3447D30722B050
      9997491C9BAC7527EEE1502C6387C7F7A0986C3DB470655E62BB5AB92DF5BC9D
      CAD290EF8A4C6C0369CB6473A825EF20AA540E3313FBBC429FB86A8E692325C0
      7740B8D857701F583EF313F5818913A78FA3868656A5182A0CBDCDA8DF0D03C5
      D5F8CF91D43F10584673811EAD9DFDA64CDF3A99CE8258AFB1762D3CC8E08E83
      C6A3D2449D6982AE605FF96945336C2C376AED15B4506C687E2C8747871CA62E
      04920FC5B480549E31C1D2F176FF15255344AF7599A7AE378FECFD92B6DE642C
      81E99B2CB832774B42A14BC377BCDF920D52FB41DEC956FBBB3004B9C213A91E
      416AC975E3984AFB0FB050976D005A46E7C885B98027F730459A6CB73C80C411
      61F0C35128E6FAC1440CDC16C55298EB8E4F66E0DB4D718E87F897C38D741DAD
      7B0BE238EF539EA91C3E22B48736BCA006151333C3EAEE0593ACD46A7BDCADD4
      1D4B27A9B003974B2E91CC0FF663D0F42B976E71E17E65395BFFC57E2ED9E3DB
      10D04A3D8719CE0D2D634582B53B89CFEF55C76F54D2B19C233BA6301C498DD9
      FCF08AA867BDBADD59D9A47F57B6D756E93FAB5BEBDBF49FB5CDCD75FACFFAC6
      F632FD67637D07976CAEAFE092ADB5555CB2BDBABE2EDFC625B4B4B6F836CB3B
      3BB8686565671957ADACD275F8EFDAD63A5FB7BEB9B1F9BB2E351AFCEF0D71B7
      1B042FE8FF54CCF4E35E10ECDA96C2F97694ED2866A65BF7760BF93CF058B8F3
      65FB78CBB65EB0DEF295FFB9E51BCC57B08FE6278A9E63A1492110015D8BA5E4
      8740FF1C3463A0BCC639DBF8C8B8E95D39A196BE01715CFEE834015D3D66BFC5
      68A52D481344625DA0D045EC0306C76B5800733BF70141BEACB911D86D399FFB
      BC0D2D7492D52E5D150E7AC246703F5553989A6577106A47B4E2A0E7CDCA8543
      E0D8FB08037A193995AF1404E519A6031DF57EA1945E5627A8AF8C195B0632E4
      75147C406B1871B1BA82D2F5DFE88C118D4AB7664F3A14D413661FD256BB22CF
      7DB23F191FA2A32EA8C28F672799DCED986ED40B3024B2AB4B011C90BB3F29DD
      9FE1FBCAFB8ED089EAE1657B805BE7B9C608E8D5A34959D79891E72D7C779372
      1E82FFDC10FCDAF71D820755DE2BE8EDFFE0056BB7822E795053B46BC277ABF4
      87B77628BC93DB3B96834C19CC00E3FADCCDCDD37FB79A8A7E72A3A49FDFCE00
      656FC950F724DCB79FDF64CF25AA6847FBC04C422CB3C63BB7371E9885430B69
      1CE120120DCFF08D8A95D510E627F8A4FF33AC10018D3B86E5F166FC0CCB33E8
      2263BD143C533C6759B8EE437B562EC901AB0729D77D145A725C5674D8BBC355
      40BD3440E7E266FCD8DD38AE9FF6C82EC661569AE25B30A63F2CC18161CAF21A
      F95B5C112BBAD96D345E1F8D0D91BEE45B66E686EB8DBC5B94761F74826E3C15
      175D92229C91522F69C2E1A451ED90648C341EFBB98C47A7940481E2A3B34F48
      DE478A3BB06A3F71B97ECD717F9B05DBDCB03128823EB66A71D1F8FE969F1F5C
      1FEE2328D1C581582AB2F9411A0E4C5ADE3BB7E6C7565DABE589A95B37D7D940
      5DE2BBD70D3E6E19589363C1D61E0A4C9B2BC5B42C17BCDC3F00CB5660C98542
      1A177905A3D3B1F2CC53C5F2ACEA6EAC409DB005A559A774CD1096C8BBCC6128
      32F8C27C577DE2AE124F1FF4C8F9A48804B001B8F1CA19A7C0A7164451A1EA3B
      BFEC1B33FE95F6E4F80EC10C9B8C7B861424A0ABE600D2F526E414AAC7BD17DE
      135FB7213F91F5929323D0940A5759BDB8104E63CC22A1EA1AD93406255D1721
      033649371B132B6ACA360CF60E8E8E6CDD7118BC3B3DDAE7A06D707AF0F2B4FE
      3BAE5AB2746D0688CF6171D788753137A532342244756FE5B0BA714D7C052998
      9C8E441F4CD6E1A4C4B6D9404C2B9589DA58E5AC9B7BE490B27C1DB50C5C4704
      03913AF6FAB46DF5866D5D413F26006DDCC36C55B9C5BB02F36725D8705DA70A
      93CA62BC964B4C903AF5F4B9B67960337848E222BFB98ED0833A77ADA69DD1B4
      906A74713A23ABBBA00B1D2DB0A1AEFE4900E16DD33D3667913300EADECF4B0C
      DF0CCD52E39536288EE4A834F1637AFBAD5CBE9DC3ECAFA4659914A9F467687E
      DCD54BF983420ABA0E84C29A9ED30D008AC4893485BD6446B5A0A6983551B1B8
      80CB8468C4B6FCBC7247A9E352E31B57B93B05D857FFAB940ADB4BBB7F766781
      FD932D470A2DB0774DFAEAEE2A08C38CD84BA636B7DC4511339171D7A2BEDAB8
      30C3E4B606211FBB0EA1643A2755D1412B2C0D86A1C624CE30C0DBD28DD892C7
      B9CFE4CDC21F275671C8C8BC45654313F2E4256BB949E7BB35281AB63A9737E2
      9ECC248797BA3355CDCA5ACB52CF461186F08233826A6D21888F411F3B90E677
      C26BFD5C1269962C81E7F0D5C979A000D161765793F7097A2A1B1B23859CACD3
      6B2A50F92D296ACAD73955D947B5985A9FD194F11E7405BC8E7E55B2EBA5B92D
      3FADDCEECBA853132EFA05C3968D83A17D1F96B933F2ED9EB0CBF795473E1256
      535B06BBD4BE8391D24965BBF08B241D567863B3A84D3B8536327360D7212802
      7977C33CB72D91F71FD7B8B37278D00C5E309C3D5A28926224FA5B39DAB82520
      62010C3DEDA298C850CCF64D2ADB54ABDF6408FA8BC4325B449779220C939DFF
      32A5A565ECB0EAECBCCADD1FA686ABCE6EDD3E739FCEC38E76E6FBFB982E1F19
      88BA2A5D4FB44D61713B8A7EEDFE6B2C59D8970FCBBC7E9EF28334239272CC31
      9CE2F4B1DC63C2BC867B8AB5FA59EA4152755CC4D0F4371BAC433D255348F555
      72E1E0F0BC292D8C00083F0F4BE7A0FE0AB085EB754FCF9B928A206D2A315F2D
      9ED21A05F6AAFB72B67293E6FAB76A48EFA9212DAE5FD30CA75BEEFD8C371283
      3D0CC6E9E422C97CD9BAFEC7D124F58937E667D34367133771A9F508D238ECDF
      83B3A3F901E422BA5056F630A818767EDADAE57DEA4CC57F0FFED7CB972F8554
      86B4E9682CC92CB59C2B701D33ACC6902CEBFA5BFFE7CFFCB5BEA39B1A92D95E
      7344080B0F9639596CD97D4BBB490E3437FEBE9F0D766A94DED9ED3052DD7313
      6F6A878D3550096C627BC2B8855BD27798EDA1ACA3275E22E3C30E301B260F69
      B96FB761D005BBE605888424FC92CB295139C4072853113A5F9939C443E0ACA1
      956888F66DCF8C105B48D6DA9C7AF6E30BEF479391539E32B9385E6B64D820C2
      CA3879B57BEC6A745AB24D7FDFAA94C585A72F93DBD730D26863659179EC7CFF
      B3472EC3A101BFCABFED90A1B81E79D44FA5381EEB7F71E18F3EC53CC176B8CD
      677373D4EF5DBBE3291D05F20B2E4427A13ECA8BDA3A7E71AE0FC09932125A58
      459B67AABBD1C1D971329CA3637E42554B1A8E25EAFB8A2BF35D2D4B3807A357
      DDE704E3778228F138035AFEF2F4D7A0BC1B0DF25493D34DCCDA48842CDE8E23
      BF54C9231051901D35A6752BF10FC556910C04D0A9F3A2268A748529EC508DC7
      6962946C520007E8E9357E0DBB4FA3F04EA356C824E7C5458EA05613AA01CF45
      EF0719E38B0B233F9084C744399B548330BA620696A21F742564AF85301A7BD2
      770B38E2017F8E3BB1B2BCB234655EE18CB90DB95E403EB0DFB448DEDCD99554
      759B38397402A2203774DC7E5CDC608B1C6DDA51CA0019B6D89A829821401017
      7956D5B1D1D8F46C5D914C909D8932C98187784FFA5C07444B992127F3CCD746
      F8F84087E1CF0D9C5BB2650FECBCF1A561E5DD05F14598CD26CC4AD7A08B7A3D
      4DBDC4F7E6CA52224E43517A2D4678773F9F237CDC760876C08E5238D3154823
      8A93EB249E90492F93B2B85095CC57D6BC835CEEDFC009F1DE2DAAB22F1355AF
      72BA5F546F8050EED9F50A56752E156D5D4128056223E4428A7BCF7092E57B09
      58A4E1027D6E366ADEC38EC3098C910812DBDAE4D68E9678D1F2595CE869EF92
      CF445A0BD26D6229BC8DF3C9C05F84B6EAD29409D613AAE2B80A8D0BDA9625A1
      E6B7B472618724F2CAC0120FFBC0429A294325A2622D8569416BF14E603BFDE7
      07B35A6639C72731724543C06BBB7A36D577244E7AD5A5397CDFA7D053541ABF
      0AC4D77D092DF4134DC9BCCEC42F08ED3425D5715AD3060B6AB1D996CA1A562C
      01B9E26D031D046D3802A0C3F0067AF6EAD6FF0FD6BF0D604A7C228D3B7E0556
      63E6F0C1B190A0FE10ACCC57FE475B88EB09CB3C20A8BA90A254C535DF07F53E
      7086A403E4E078D7F416B8B1E75F9DDAF20A544A27DA0F14AB684F8A2389F5ED
      0201866A806349286F7141D8D4F32BCBFBDC782BAD49B1A9AEDCDA0F268C2EBD
      17C413F805EFDD011FCFDDB34FED961B9231CDF6B7D6D1B065E0EA68E6E0B0BA
      AFF6674A07E43B899895856183396253BFC062D5A802E2C6A1403D497B275DAD
      4C419C504265D105E8912FEAFDAADE5FA7ACF0975FDC037FE548BBFD8A43AAC8
      726D0EB09F38EF86EE7AA1ADFA2BCBB461C8F8D554B2B435E0D5ACD54A0BE282
      2CDBB27EE7C5859A4948A1D2A3503AC2DC132C823BE2BBD31D120C792A64879A
      95E34E875C80A2A7650977B22EDFA437D566333D4F918C2BEFC82B1AA17CABB5
      1BFC8136B1411D6FFB2AFBFB29DE1C3574D3C1BE8794CCD757314C25C3AA1EBC
      BA2E0A37D728F549FDD891D88716C523B4BDBAF9AF0BBD9C55A216F19983F2B4
      2551B4783816CBC5A0D019CA7B2FFE231C5775541B35A952AE52F6ABDB8AE354
      EC529757C9B8B44FFB915B46EAE77158A561CBE3895280404E6B12BB2FCD13F1
      1FCDF7D1341F25D955F02C7879B28E0E15FC36DFF5DA6FEF0BC51656E1787EB9
      7E7660BDD2248BD2495C9FA7871A7FB27558252F4FB6CC51827DB22E05687A67
      9F7850CBCEB858926907F50FA0F9EE4D1553D615D75A9D96DC8BF5F16E43A0CB
      4DF287F1EE3BAFC3EAB2C3B0456AEAC3D7D00F6DF712EC0A57380E03CA3E25EE
      C1B8093DD36A865702DEB45C8AEE65500F9257D68541B587042F82B4908C21B4
      D1CE861DE3AA141A54E88256EE92473C839807D48C4B99C2C01A6895B5CEF07E
      75C93E13B9B92A856F7214E08568735C7DD3E3601AB01511E69144B8BFEBE3F1
      2BA3CE5982A8E69ABDBFE168F99CBAFD005E35BBB398E54F76D60BF2E750A54A
      7F3982A228E687D6A715A9D8DC949F881147B94E8D0D93DB39D35F7D9CA5A843
      0EB4F40E45CF33E5E53976A330765DA8F7C4ED0ADD6DD720E9CF0BBF9CEB3093
      D2CC28540A3150676A9B82968A83A2F4C62F749B6478CE45C6254887E7C79C3A
      E3148B45ACF13E47C7ED24BAC4395C2B67AE1748223ADBF0ACA41CD55ACB6B33
      D48C1CE26D0ABD4EF2D0D9B5B98FC505D5FFF787DE73344ADC6D6529E4EE8598
      6F6CAF8246B7A7B353AA4767C014D0BB9248D1F8C030EE351281B678B997D55C
      D8E00E1CA31AF05EAEFBA80A53E22AEEC316F3F8DA8714FCA0BCF44C5C5CB0B2
      EA90242605084C3B3384A2E360F8435C5E066F8F77F783D705020715A7A88732
      F2CE59554CA2AA83F84B6797713BE923FB474E964BDDE0C860ADFA3E0493C87E
      D27D7A00ECC7341783A42AD011262B5F00088DD453B2EA430EBBEE123BACAC6D
      D730A7807F84F12C056751918C75C77883F3A3A76F0E83EE802C0900D0706E13
      C8FD4578F1247B02C815D77C375DE27F980D7397EF2001C71A10C20C8B49C2DD
      0B974C9AF2E887EE1DFDEFE968F49444F1A634C5F3E0965E3836B7CF83BBFF11
      50B7AFF2ECD32ADEBEEE40BB896CF1E53935F8C764F5865D1C78157971B8CFB0
      AA6978210749C875D0A445B979666E1588554087F4F9C1D9C6B3337269D5317D
      F6F2646B3338D83F3CB7AAC8EB54C2615EE31FF56CEB98A3281A17495E686752
      343ED1BEADDA4B73352E522365BB16C5C6E09BE340CBD8052CC8A4B641A88199
      3AF943FD723F7881B6E8AAE93C4B498F5B0812C702198A1813C2DF2D668006F0
      39075CD403912C1B7381755CFB99CD78D9AB5CB1FC6EEDAB93757F81286A5598
      904E09FB0E8850DD80B0C20A91A6A616238FC5B9E7560CD342E0703C17C0D74F
      132A47F166A7A520DF62961871B5B39C43F940F2C4DB356ABC3807403B65AE64
      3E25D52DB56891366492DBF78C058ECE0C5A4F73EDB2EEE0FBC56EA90D57890B
      4B7AF8012926F74D9BE4A1D74DBEE20BD3FEFA06E77B5D212A46A007A7D0856E
      66BDCC25974B7EC4ACDECB0D7886BA55E8E3CB74BED53F86482DE63BBA6C8155
      D5C54C9C9EC009A0F90260954473EBA86717D855BD6077EFA753491CF782A3DD
      5774D9EB1F4FF5E257BB6F8FF175BEE375123A87216794D5EE9217C6646E3A38
      1B4B738DE2EC159157CF4282CD70D49A930531D23E5A7793E645C2151A015F42
      30BC768B35AD656D0FD7682F4C6EDCAC2E4D30CCCA8896D69C7DCC1F82DB5E70
      E703F6373AE72A077E589AB040950CF3BAD5BB565E1D7DEF89947D36501AC43C
      90C8B66C70941458C893255E5F1CEE964A83E65D354A31E460A3043085AE2B33
      6C15C122F012194EBA9C939B16F1CC556D1B70EDEA6EBAC40E178D868CAF8B03
      4D7708BA5C3044BB4C411DB91821BDB3A659936794242F9870BDDAD87940988D
      F2F569D00B4F7018A91F1C0A25B685A7948D32C350DDF90FED78E964AE570477
      47267ABB9E746C226242CB8E849AD87C85866E7882E92D0AE38245F8DECC3487
      4000208C8419AA331C52D1C5310A7F069C581ED96D66A5F60DCED59121637D0E
      77F0519FD992776AD0CDE90B5A7FF53297EE03BB61E6A7D17A0DABF9616D9019
      231A51E941B1FF3D492B22A6D304E2D4C63DFF80E11886FB80EFEA53B821AA51
      0882978594AC7BA895A906FC3219F727448B0BACE8C5F7E3F4272B18512DAC49
      240DE02BD2C1E4422DF886A3EADE9A9DD55AE5D5F2881329221B59BE9CFA23AB
      EC24B2EF7D5B8E403E005CDDAB851482F32C82E0EA915A46D0F15C1B79A36973
      A616502AD45EDDA042B75D5CB8734039D2A5CE7438DA38C163C6577034E213D0
      E5140274A647E4D4669887E53E7A02D8C448CD148C18FC0CFE5D32D55090695B
      704A0EE54F90EED350D15CF3D42569B304E8B442974D40A48FC8704B9312284E
      CD04952A2412336D4A2ECF46DCEDBEC8C5A051B7DDA745856A93D6AA4CB0FAFC
      6E2E9481BB4E2F56164C04D528F93E1CD6A85328D95094AAB014BBB470D69AA0
      3CD56F01EB4C41B9E9CE5222564718EA3B2ADA7DA31CC43668D53C985CDC4677
      40235F886BFA41F7858049E092B0813BEC7572D66314434D74B9C2503471B86E
      E82D2663D7B128F41052E4C279BFC50597F9A3494B22A386DC85E1721457FD13
      CEDC49F8444CFCFA60F14F257E3B8C6324E16F98B83817B423EFBE2A6F94F158
      853BD5FBDA7BA8D3C03F9954A0B67E90CB76ECADC90D41B308402733B3B870A3
      8A5F1A37C12BE695FAD8EF7C42A3C35C1D7F02FE0ECEE38E15E2A53463CCAA0A
      9B7781CFE85DB3E2F3E3349F2847DBA679C9C8AF26B3886FF61663D0D50F4C14
      C2924B2A661340C4AE74177281FF25CAE854A18AD699864468F4995A3077CDE6
      9079274E71ED32725E7DBE713E32FF4727FB3FD29CA95539DF13B227DE8605E3
      E98B5866D50FA9DC5002C77DEED9152A804C9967FF325F721F16EFD925E75F73
      39EBC779A2BE0EAA434608FC73FD0859497931B78D75411E4B6B55591B222E82
      AB6A16A1DD21C30F14C5640C7B624AC45A02D675A61B6282AFC2570D23C81582
      42E327D984D77A0C161349C7FA3D63DE8399C7A236533EF0B6AE7C0CD31BE411
      8AAF6CF35F730120DBAEBFD638E24DE656944F5D65B8ED8CE5747F31D937CE69
      921380BBBD80295AC6A1A49DB93F5440718721E7A3259D4CC7967E1FCF936158
      5350CF277247C4124F2E32C6D5081D769B2B5B438D8024DFC927A9982416CDAB
      B86650E45762B4666A9EF783FFCA2772EC5D71C07A000F85D3DD3773D0828F6E
      987779C1E814DC927FCC1577C1B39A2645FF82ED72FA26C30211FE96DD34E192
      9AE03FDF9C9DCFF3535EC67BAA5A73AA370382AC315BB88E119B6232F0D327BC
      D7ADA08FCECE833F7BA5E422F9EB121FED9DD1478011D2F628FFB3237C76946B
      F6973F597A206B5692874966A9C59461EBD1BDA3525707931225B1E2CDFB8B45
      0A219BCBC57EE7018205FC4D57D39C25EB13BDB6DDF19894A6549F7273B1C501
      F7CAB8E7DBD0F56E79FCBC5315CD357BBBA4C92CB6772E8C70F920BFD570B84F
      F2CBC7739A8CE847E4E792BA3F48EF62BFCBFB377B988F3DE09D40E79AAA070B
      880A2CD446B6B1116B77910F795ACF86B06D36585FE21E5856EF01F4F8B0BC72
      985D5355F9B03FC26BC79B1574CFEC891D2765440B0BCCBDFA95BA767FA9F1EE
      A2412C4E7D94E6A5F688FDCEEFECBFADA0B4E7952D8C21ED25E90C7DAEFFEE2A
      717A4F1BBDE4B65746B6E8D9BA25411FD36F73EB9ECDE923878EE97E52D2734C
      34F112E97C63B91172D9F265D7D68F585723F55062F0C8644C14FEDE9620B033
      A576D2348E3F6E3357A01F73A558F46C4AB64F63FEDED0AE2490C8906B6190AE
      1728CDC3E17152623B7443839AC7E7C1E1CD003FFC8936A25C82DFA0B69E236D
      4057D227677951C987E5F3E0459EA7B0E4FF1C9C83B7F84FDFA07B11968E42D4
      676A95903333D0171BBBDEC6FB2CCBFCC3A4C898B9B90EBC5BA034B2621C6304
      F35B6871C8A3A3F2CE98BA72C694B949393FE3B92ABFC974D02B4A7ED6027A5B
      19A243495F91134EFCFE7DA488ACC0196B52229A9C9B1622C62012CA8FC05B78
      0DAA48A7171F775EEA597961E810175CDA6EA838673C31FAF327CEC3D76F62FD
      661239C8E2CF90C7A3200F4FA1B5C2348085A2393AE4E46C19ADB0150483C960
      002C74EE32BBE4727FE3F1BE5F4E2E0CF25E6323E1232E1DC0E5CFC490E0F23E
      6EC824C581CE351FB6D37F9934B9826991949FC08C589F46D5EDCECA26FDBBB2
      BDB64AFF59DD5ADFA6FFAC6D6EAED37FD637B697E93F1BEB3BB864737D05976C
      ADADE292EDD5F575F9362EA1236F8B6FB3BCB3838B5656769671D5CA2A5D87FF
      AE6DADF375EB9B1B9BBFEB11C88BE0F75D9FD7A105BC09BCBE3E5E997B9668F6
      4F7AC5007BDA5DFDEC19F963EE377FBFD7F759FA93BBA0720554017F59CA4F69
      CEF5EA3BE760D04AACEFE0BE334CB8DAC7BB47BDA1663ED064B1FDC5FB716EF2
      587D44672493531C2072B97769A2ABA33CBA7AF4E3F1D39532CE82AFAF96EF8B
      E14D967E0B41909D30A58FC9F1E43CA59288447839685089907151C6547DAF2B
      2CA9EB4294704D3DF2929BCDCB3CBDE63B23C08E5A8B9B847BB3A457DA72A3D8
      AA171010D5202A63AFF4EBF14B6ADFE5451A9F8DC3C8F48227289DF8E5F5AF4F
      7A62687F83097BFC76DCD94258E96D7C9E18BEAE5D35B56EA1D9436EED280CFB
      125E55E5D2834D043718558951691D3D4A9FDEB93F7EA345A7E6193A90DE223D
      F68DD4230DFE1B8CFA558846CD6F326E7562B57D94D6C6956018A5E145093872
      409B33BFA204C6B85AB851F186D60285CC9FC7883E2CEB17938B39684C238E3E
      0D1A5318C57A194C2EFC5A0FAE2AB29C10803D4B9898058965705BE26C663498
      595FB3614D5BF4C709227B0FD42D2A469AAB9FFCFB7B7C84383A4FD0FB714A07
      BACE52302DA329E97C25BDF09E2CA34BBAFDDAFB78C03F2CBF476517DD3F78FF
      64B0F5BE0A07FF98B17C86C9D3B54DCCF1D6EA67AC231AF65F231E32ED06F2D5
      E8BB9FB0B252AC8159CB0BDFFF4E16D8BF6E6CAD074F11498FAEB81419C827B9
      29B32795A83A011848AB1FEA52CF762D021AE1268DF0B426D7E5DA080C500B9E
      6B70232EF80050CC8556E8012D66EC4ACDDA33E22D1AF17E588533C7FBC71825
      AFDD1D1AA7F464DB45CBDD38E30274C81C66258F3BCA39300C587C00228D6BCC
      20526D6FCE5F3EDD0E106D0A9E46E3E7936A48BF5A68A87649E45F37B6D7481E
      10874B9369394F585C49A18F340369268D1782EB1EE0FC5DEB460CEDC5F4CDE2
      1722B02E0142EEC522933E653EB2A8424D54B7E4B373C9D5F52E2E94DC1B5506
      D54DEEC23EB194AAB98AA995D64965E3DEBE288C807969DFC628CF808B621B2C
      52D43D6BB786145447B44590372F936A62F1ED5B270628FE2B7337C86106D455
      0649C62A8FA71943291B475EEB460965EFF6F4204F815996D5333F9C60778378
      4C6BD85B37C06DEC713B610CA527300049840422A7B17212C093D2D7EDAD9ED2
      1D7FC478691ADB655E24BF2176962A6108B0822304DC4A9B0419E455958F4679
      293532776D1BF7CE328D1BC6262A6D493B8DB44A20F093C3B191A38D73414AA4
      45BE37E283B41006805768DDB8718A75502A08F25F05AFEE34F094A5ECB65D03
      5B5CE83A7795AB884A698479EA72CA36FB8CB09DF4A3D973274A8A683242FF5A
      C4DD371646534BC6B5E85A03C47F14B14809C333D6D3F861969852633900AF93
      A202F95EA70E4D76EAE2571B43EFBAA26E151D8C217C2D26FFA0650E3D494EE0
      5340EE87C016B43D0477440F9AA0CEDF3BE4959EEF26142C8FBEF803A5522BD1
      52EA0FCAF0597F10AE06402F49AE4DFBD6D16C69904FB35DFB3D0856A6AA5AE2
      C04A417011C8410C719090F35F03D09232B55785DA792F4B09F76D97881E1050
      61E8A0B074444CD5C8AD0D6421E7E83146DFC334D6464B06FCE09AD0E8B43670
      D7DB04FC45D042741DF72DA318D4F2C2A2AA92ED086183ADA41BD94457DABD2D
      40B8D29C4347957CD22E793D24AD8C412A9965DDAB34AE1BEC9F91EB58B7D7DF
      8D151AD8D3BEAAA26DDFA9C3370A1D8D8A67C804039372133C7736B64C2BFFEB
      E6F23247D8C67A5C8541463E873AA0E1781C5C2BCEB284B1DB35BA874F6B571F
      AE59F1DC835370872E77DE034E412F9A6455926AC5A2AD4A66083B8EB1D3AFED
      92CE43B2F9E5E5C9FAAFC1CB57BBC7D80A3F1E9DBC80F2B829F2B60DF0E1E9FF
      90F9C554C3F721C804CF06561C2F0B6BA271B7A3AE89198B8A31F3645DB54B76
      0F498E4BF20504706FBA6EA4CB0987BAC07E71E162A917745EE570FD76D3B453
      6F2D978AB58D5B1E4E328704DB76183DBCD676796D7822633C168658746D64C2
      9C53C7EB969AC807E00CEC02DF07361D73422CA15262408368597CE421217146
      1E0DC06E71D070B9C9AD6586FD0346C9E2C29E0DCA5ED2F8A349A5E50802D922
      FDCD96B2597A6394F3CDE278DD69BB4EF6A4FA4348E49436403E0A76DF360FD4
      1BAF97A865E37C60699F9FECD50E4B5301D285EF926CEB8F314E59C9B4C23B2F
      C9746475AF11BE9B24AE2E19C2A2076698CAFAF77E17AD4B6591F95E9850C1F8
      E49BDCA18F3BB54C173C7C26FC74787E7C50065D35145E93539BDCD25F19471F
      281F81B463040792D65A624BECF4CDEB200D072675D1242DB8CF4988A39609E7
      21D1ECE5A3318EB933DBB4E9B68C42BF7A588D1600714FD6D9BB6471C1AEB476
      09E3E195F2027C40F4A79F0037417FA701DC95C19EF213D3AA60BB9CB346CF68
      93E413653C177B239A9415295992D5A88511B2074462417392B29C08AA5E70BB
      3F198D65E0C524E360081C75E911E55E6255398EFB41C2B2ED12C9C311799056
      D0DB4BD02FE26CCA5048B84E34D9024DA3A02870E9D11B4B16BB324D73CE5180
      94DB25918717493383AE05A00CE48AD879300E69D5D4C543C95000F7D2B4C613
      13AC963C8DDBB64C1E8C23EEA58994FE6378273F0368A7AA21D8EED113F39271
      DA57453830973687C1F0E121F7B173AFEBA31755A35CE8F1FBDDFE208BE16670
      321CD28647A9199D9FE51E5DC5410CB22C0443AF08D1BFC7A16176D52D2B356B
      5CCEE9DEF1666A97401E10C72413DC868A6C88919152B4EB3065AD2880527CCE
      2699BBF232915891E8D05250172E2685F2CEADAC5E0A91901EDAED92D283CBC6
      ABD732527AD4FD337E5694AC4C5980C962A5E522F88A8E7F29368EE8953E14F4
      C59659250F067938FBDBE34E6AFE01E19D3DF4C94356C7750E7871C1D9ED7C10
      7939F1EEEB941D1FD9713E0FBCF461DDE51341B2F0C0856D7699F7E45A7FADBF
      F92FFFF22F2DCB413C7C88BF13589057E686BDE8199E00C762BD735C8E32EF7B
      089F69FE0CB7E0823933AC3867E6B3A75A5491CE7E0E8381EF2B8C9912F55724
      DF8ECC0EA06AEA84DA8CC7F2D9092EF322BF28C29154E1FF51A6E5ECECC05957
      AE3A41264095DD6C76CE9546C497972CE464AF5D5F6F97801ED4056F2DD0600D
      BE6C03402D1E21F9D6F518255C134456C3E5C3603FBC41214711F74D39D27AC5
      325897F4BCC367436C437CD3BF4DD0B7C0776897541EDE189779EA30DBB50C8E
      AB00AF8CF627486D908772873D1055456AABE6A673CFB0C6EA02AA0656694BA4
      F5A0D36A619D846C8D46988C53E15E74989616534A9C39AE9E2A1FBF8D9111A2
      98F30D197EBCE037686394CA27F2BEE0C2EA2A6103A28D1EEA436BA2E615E13A
      585B203AB5279286434ABB23F90D6DE86DAB717FC849276D10FC20BE3AC4C349
      C09F041E7DC681CBC337B442B4C60551F20672BA665718A492759372C7E0FE32
      016D4C4F3FAC83DF3882BA510E2F96F4AE619023C5A399853AA82BCC47899C8A
      7E30B1A41077DC705B700351B05DB27B4872AC839F6A7999A380433D14E99F07
      18233C7AA0FA8B0C278C02345D879E99ED04676FEE246C2955BC9DDE2EB17EA0
      345830CEB0BA7C24C3DE4CB5A675640E37A3166BE8E1CA6AA912A34CB64B4C1F
      B5071AC5BEF5FA1083B20927C9FDFA436E856A9BF6FFD86AB1F09976EFF84EBF
      4EBE7266489B281726558E92072DE32AA576C9E55F375756500F2270AFDCF18E
      5DC0D6333916634971D4B09F4248D4BA31AE6AB3A73D6DB837A6422EF3E00C74
      A36306D6916612CC79CE558645C23521ED1AED078A308BB0BC948ECF308A3489
      10725F58A2B5001CE7E1E27759F43D894DB3D944571A29E21D8788C50AECDCC0
      B087A548B288FD844C1DE0D804B43FD8FAE85028EE39A16D4EF128A8C4FDD22E
      E4505EBA5D3320F22713F1DE0C747ED93766FCAB2BE5EB9E682DDF7F2388257D
      F74B9D8FB6F8A0E42FCDF32BC944DA9824E75D2DD1D9C0A8D8D5FEAC808DA144
      BC1EED176351C1146E235AC1E60A7AC15E6B39863AF7796CC6587755116665EA
      0FEBB1916496BF0A92CCFA7643C23E92CCFAF6C3483257A640A0686DF3B3C4AE
      11D54CE80D250CB0D65FEDAFFE47BB96C6B74733D9F8DED14CDEA8DD6BFB0D80
      6F9BC7881B736DC7EDD9813D0EFBED9A7B1998E31A3CDFDFAD39665B399228A7
      53571A901C572EA36A9DACF58297AFDE8A4FE84D58BB46A98C5BA464FACBED7A
      F3DBCDF5C087E06AC96B0B272019186CD85D874522BC7AEC07614CCA8ED6AE51
      D590F9AD7C7DD87F1686E62BBCF9EA577A737E4F04FCDD9BF35886AB41FED183
      76657DFD9F3F69F9CB9F7AD426E9F503B87D7C9BEFE4C4DD8D638F14966B58B8
      3525B288CD5FE3A07DAC897F89BCC8C1D96BE7332BC7B1892E33256D567C512E
      A1202FBB6566C4DC84FC8810A56DF147B42D224474F8EAE589D05BB76B9E691E
      68EFD5A4D270B6B51DA23012240EF6F61858A65D03C34B238B9217082468B8BF
      451A667EB47CFAD1823238AC52AB8C25A92B161D170DEE1FEDF58213EE7A44C0
      D3FBE4E0ECB85DEB7AAE983FA698CF0FCE369EB176B64EFEEB83D39FDB35CB74
      BAAC3D23E7F6D7E0D5EEDB63555FED1AC2415682AA20B478EAD2BA8E9654446D
      4BE7AFB4343A2170C8A4470A04A86F42CEA2990B29B4427C228F63A5E46DD9C8
      1617F695C321BECBC2511291892EC5FAC3C4A4B1A50FD7DE59CB9613062353A0
      A57E1C56D1653F78877034EA10ABA7682587D31DA6D25BD9B859320C7E3345CE
      28319C6C01D66A0964BE5CCCEA54C2F4CCC203946957CDA6A17D7DACA44FFA20
      E541CE252DA5B91B0901144E24288BC4A5DCA796934D8E5120495172EDB3BE15
      BD4F454ECA50EBE7F47AF059E599699909FFE26C971E1C5C2FF737DAF5E20806
      3C3AB9CAD392FEF02D4AEDC68ED88ED7DC3894A6290B342665F7572618241910
      429298163F5C4CADD1B3CDA9DC1EC5257AC81BCA97FB82EC7C199697469BF5C2
      349AA47C284A59ECF1FE86A444CF5FE6808F4F9341E153B1CD9346FF6CD26865
      9E34FA4CC372F3FB362C17177E393B3B10CB728F8F3D741CA49341504EC6A838
      08BA702ED40959EAC10A004AB2E786C22EB04E0A2D9647EE60FCB77E1445DF80
      69078AAA5D7B817C888D6734D9BF069D1F4D86F2006E3D3D19FCD54455D90934
      692324A52D1B9AF32C7410BB550A54A5710B6D70850E3B59D7A1B41189E1ECEA
      AE4846C1DB534E63BE04FEC2A45AC7EFAA559E93699B69EF335CDBB7A73862FA
      E69699D068F0F51F7AF88BD622493DC853B26F37AE0BFCFDE9305FA79F9CB9D1
      B2B95E5C104E763AA09FC369D87E1A936F456EC0A5B90D63132523328914E044
      39701246F9BE4E62E999EBBC406053D93D20B2BC00419D72CC75C421E94975B1
      DEC8327AD79D778CF4DF36C971A97503D4DEA52D922C46FD6606176994A4F4E2
      E4E8943D0DA171D93EB941D9C42A08A92B86515ADF2FCFD296F51B774E4D29BC
      1F93A89A14A6737FBC5AA42F7FE7AAE9719819CB143712BE6DCF890DB3BBB615
      05772CF88D4DCBCD16C3A96D2B8C8317775C3BCE8E0AE90FB2D80BDA75B6B8DE
      65F7B4F8845D12209EB64B2C8B0BA8F60DBA50B6FF4D46C0D271383E062D4A51
      F6ABDB8A374BFDE17F4E4C599D03D6953FA49500800A948672E934336508B807
      07C06C9D9E20E560AF01822A9D7061297C08B9AA5D124B46D0B32E0813705229
      69A14171AD583F83C98594B6F06443F58DB45AB76503CABCBA0A56F22EECBAFB
      FA90630B3575D75FCB3CEB05593224F53F423C330953FA31CD630935CC43025F
      18129807043E3320B0F57D07047E610F510DF833F0CCD06178A0C58A6ABDB7CD
      26D0319D1DB4D6A552A7501CA960BD9E88360DE20327AAA0C7A335DF916BB76B
      6C7FE443767E467ED919B9D25F9B9F929F794A6ECF4FC9F919F34F0C42084C6D
      EE02A909DB34C6C97FDB172D714447781AE5A311F475CA65833698D8AE9177CE
      94C4F893E33EED1ADFC7FDF1F901F54F1F507337EE730FA89DEFFB805A5CF823
      5BDB5C0EE9927DBEB6BF48F31BA60C34280F69D9A85C16F325D7E1396C7F992A
      81E63621475569E8AD1CE3E282CE1DFED5F90BAFF3242E830B494A33A04061C8
      83C21831A7F1644C4719D2D59AC1027F9DA4C3CA1E7B5CA4CBD416D36A3BA0B5
      2310C814548CDBC470DEC28F5B835C22843D3F3CBEF4F09817057DE6E1B1367B
      F2BF9BC3A35644BB8C37F1FAC5C16E2B21CEFE30399CB7C7BBFB882BB13E34A3
      717517D04DC2BB960DE356353E46624FB21767BB2D25A0B5A3F1569982930278
      C100972704B48BC0BED0D3E3320AC706E75ABB064AAAC01ED528E7395993DFE6
      27E7979E9CCBF393F3334FCED97D7BDFCDC9598E81D5D4E2B0BF74002913746A
      C2AB56BEBF258E273D8C1E66AE4BDE3FDC3D6AE35886691E56B6CEA600DE6DEB
      DCF530BE0EB9D4EA388FB99DBC0C8626448D5ABBC61117E1C5FF8EC987E473B0
      A3A02BDC69320DCADA694425129AB4EB2406DC3B434DB66BD8A0B6D24E1B06D0
      E4487ACD8BD5AEC1D479CD16F7692E2ED4C30870346A8134B24F286ED0FC865C
      F0BC5399B2EA8F432C4A8D85B868128AB0195010C57FEBFFCD158064E0FD3799
      7C4B02BF831AEC76494789D7CB328F12A006B9F64708E5D17BF0FEAD8F727592
      FE63B7E1F5BED158D7FFA78C7598AF7D83A1F2D9F32D469B5D7F8BD1823C3E2B
      DBA7A2B9418EEC9DE0A4B808B3E4375304DD951E07A4579710881E0AD56F450E
      A512B24A17F7AC4CF4E313763C1DE5FA8ECFFF8FFE80A3E2DF1FBF97B84D933E
      14C6E1C7EFF3662220A09683412F4DA2EAF137AA9A16B4581486BA5D53977D93
      FEFC93E78F3E4FAC54161758AD70C79330FAE6936A3CA9940A879D1618841AF6
      B3A93930EC8D2611029B58E8D20E4C2A3A1C8177E8913B7F3B24BD7EFFFD7B52
      B24EC7BE7F4FE66FF9FEBD6D708D83FD0408DB150DA4334389CEB5D7CCFCB378
      76E4AD5E26B1C6512A4373CC120DA32AB748276D1B200627EC8408CAA7B40990
      4C66B69FF3D383032D0CA3C5E2F2CA8EC6D8641738932D9C8B05B16F9904A693
      EF3D8CF15EBDD8D37F576031FAC1F58AB72E6DA1837D67C2719E3DDB2D4679F1
      6C77349A645AA639460AAABC34A66ADB3A9681BD38D93F7F46FFACB24B5013DB
      70B2D061804B7BBF32CBDEB061192F2E049331EB6E6B2F80A2214F272D6CFD17
      591CDA1CDCFEC98BFF1B5C9240D2D699203A94D319D434B1014F47CD34E677A0
      CEF36FFF64FE6DB9BF36AF7BFCDC04DCEAF79D804BCA726282CD9DE74138595C
      A8F21159AD9180BBA9213305D5C60DCD4304EF95670D15624138C255B8DC21B3
      0144D6A23AB7ECBC10A1ACAC9354B4822E21EBE796DBB4956A46586454E79C00
      00984E87513BC7B9B9FADCA30D2EF24A3C177A588A33B018D534455DCFC9416E
      83D70878F8040400CEC452DB6CBCCBBCBA3277A58F8851C35A283646F7D15DDD
      036CBA4777769FB2819314A31E0A46C7E137889CFEF0F891189E6D20407E83B0
      F8D36F35DC2CCFCCB748033CFA78938C9453B5D42EA5B4B80062EFE0EC321956
      0A805A56A15469883D8658D455326692BE9C69E55457D175E47D76E1AD90EB5D
      9036AB2691C23BC857C93AA5D7617E20343709CCAB29AF2A64EAC9C96B99ACEE
      498A3D7348E4E4E707B4FAE282C88A317A33A10067718ED5EA01686D2C8CB47A
      300AA02F60625B4931646E0130631E1C981512C3EB86D76192DAB28556A2C2C9
      4B33C76552D23BDE71EAE8828C35AD0CA2391657917B7BE8B0D3806D1974D1F9
      C014D96CDBB76C3380CBFB873DA02527186596DE05AF50E18017674AEA34190F
      F210B4960765C474F7D2FF21D4DDA243DA3564BF534B61A9ED564524527D9678
      42C6ED304C4B4B74015C5D81AFD69E2E09CEA377A86C9B0DAB505252C06218AB
      4760F27AB48C4779F04478C6675F86529727ED1AEF0355491EBC51F91C814C61
      7B60983F5BFED3E51DF26EA917BCCB0BF268C7C0E67A410E7E7E5322E9BC9B56
      3FBC5C6BD9AE5F5C70733A4620935C54F0D2E6F9D5282CAEF44CD352BBE7014B
      60A5DFDFB009ADD05DDA0B307EFBD9451E0CC2E8AA5DB2F0BA0A86189CC5C37E
      777AB40F38C8DC266BB2FCA6173CC9B3279EB66FD750EFF70676078646ABC1EC
      1E50BF9D73CEDE7ED9B285AD23B48577219212005FA4B33DA3630D44715D21F9
      2D5320FD4B97236DEE716A80F4A9E7C15D3E291C065A325446807689C2B5829E
      DE6F50D66176DF9DFF74DAE3987E8F49437A92DC1887E3BB6252F256E8053F9A
      EA00BCD58C0BEF98354966AE31E755787DCCCDB241B7BA0CB32B3E42FF9A6737
      F1563BD78FF4E5B12CBA5618BA1C96303624338543F4E8EDD18F41F722CD0761
      BA1420248A3FBDEA07E79786F9DC9E80EF3B3024344194DDFB19B9CF0AD4155A
      C2ACEDB4B85BC55F92908AD48D32D41E7DCD6BA56D9128D7AD28FF72FAE33E8D
      7760D32B79707AF092961E53A08961DD46BE1AA4F491F1E6BAB342EAD55F1FED
      AF7A43A5B97BBDBBF773D00D396488C2DFB68D1159FD17AFCFF7ADDA8015A0D5
      F7833CBE43C94B25A97D20DBD095AF82AC7DCB9587796AE8522EC3D83B383AE2
      3DC976C085B4558492C5E05CE1B08518F57226AC3F53BA2B2D47E111FAD6CFC9
      CBB373EFBC08BAECF73C394BB80E49EDC2276A19B18D341C2ECDD3A55F9C2E9D
      77FA7F6EBA74EDFB4E979A72AC943BCAEC8AB265522E0333CC0BD223E5A85D13
      AE19C0B5CDE7E0F82C2B72F6023AF38A61AA80F064105E14A62CB9252B922420
      C224690E076B6C8366ED1CF5D6F3407C07410870673C9D7D203EADC0EF02A7A3
      0C0ECF8FD1DDC98153B6091B583399019465441764AD2BA201A502DA2651BEC7
      A7C236BAD60AB66DCABF4D50063528685998EABE5434397E91B0BB2D91337CCF
      827B32EE79497E45DFF4835FFED7EBA43AABF2F1AF6D1310874BF607E91E17FC
      E5599361428A02688B841708358603544CA4D839E61A5248EFD89864BB3F57E2
      43C1C66F99AE60D3DEC1FC6BC7309303DFD4311525C7C0086321106C9D970D80
      0DD1F158FC56C1DFA16C3BAA008A1E5D4AB6ADBAD4AC095BC7A52D02DF104712
      4634502EDD1738CBA28B4202D36D93CC0351D75EF0E6906B7D8A3C9D0AC1EE96
      2514C728CC6877143DFBFBA0D0602B6FADD6455B35A82067C75FF6FEBFD3A06B
      325B27F51BF2892EB9F61F4B4DD7115E728B07FBFAF8F0AC95C8462E8E38E200
      573E2873AE6647F76FEA9DFCCF83E393FD173DFAF76CBF17BCFCF1C75DFEF70C
      FF9E9FB572CC1325403EDA233FDE7702D1FF6462EFDC7E73F6F36B3565DBB923
      DD31A4CD559CF8A399BE3641982621329D3CEA804E6FE829E8ED768E548C360F
      E8D0D2E3726CAA8D3BD485B79FEC8B97F84409952F0DB75B7896C593A7AB2BEB
      5BEBDB6B9BEBDBFD65FCEF090C918161CE54565434F308F868838ADC08515AF2
      72FEB277F4AEDEF1ED12D2543AA48348CFFBF74249180C007652766C09EE740E
      A4E5E90F1DBA4F306D131652708C0DCD5402ED1BD77AADA53D2BDB57D6B49E19
      CEAE7D68283A3E5158AF7F3C3DF50C22FAA7988C1D1F5D585D5E148036156EB1
      F0BA75DE7463B033B4F3F18F072F79A1C20E14DDF497A393BD36AB2337DCCE9B
      6C52D27F6DBEFD2F6707FB1D52BD45FB82227567A70C4D52E7CDA97CF57AEFFF
      F5662461E7ACD95F1E379FE3FC7D6EDC7CFDFB8E9B2F2E28326E61AE9FBDA2E9
      3C36CCCE8A988896334C32DA44FDE00D192CE110E61A19726CCFF1FAC8857653
      6BD791B30BC7E83D2A126FCBB564B59C19E0B7F2D80BF3B74952004150BA8A18
      BD05829A8C4971C62D1B98CC7148B384AA9287B059308D608019DEB966F12770
      3F13E9A9E27C2D9642BBC6CE91AC5D6F8DA2FC94B49A91E243A9AB6DD9983AFF
      77321A33434AEE8C3431539E94B6F76D9C8F2763EE826FD9E00E3244A79F6994
      9A51E1C8E2941E3F2D796FD9888EF20BD94248E05F9BE2A648E8A5331439AC1D
      BF68D96016177EB9DDA7E50786A52A4C493346C6B24F1708B0A25C058EFE6591
      4F2E2EE914C11F5EDB7425EDC3CB10611F6EED28AB7034EE07875530E258C2C0
      A035663849715D85F45640BB53C02BD8D66B99B02CC0015D7A55DA83D3833C94
      2E5D80A023E85533D5F583D71A22A0FFDFFB99FB0338BDC7E9A97EDBAAE067D5
      C27CA0585219E2017A7B7E2C7DCE4855DC296CE7D2635AF25F60BBFFFEB6DB99
      CDF93C6FD77AF8F666F9C6F76D96BFF299A161BCB54CEFBD7AA00DA45BD3A917
      E6629286B0AC41C9CEC0884B2D1CA59F61ED9E1F850332326338CCBDE07C0FFD
      4B47349217F96DDBC676A6AB4FCBA9C208607874AC7368CC76E64B9A983B3C7F
      78C987148C6B710C49AD93A761E8773DEBD0EFB4D4BAA3EB541393E55D5685B7
      C125E98B143A033E72E15AB6D49B981F4C7A3081F7AB9C1F4A9F79286D7EDF87
      D2DBB048847C34F90D7DE995366D2359C098F12D5371271306C691ECDC1F603C
      87120C5F59DDE8D13F9BF86707FF6C075DFC7313964107D56EDCAE854177E696
      B45558C74919CDF5D567EAABADEF5B5F2D2EECA1C17E94C7C930415335C3048E
      C661950C923421AF9B8D99414EFFEC1B1A6212FCE5803DF1BF1CAC59C8CC1290
      99653E29D0A48EE2C396290509FDBE084BF30A23710187320F265929A11A6160
      63534F91C1C02F3D89406CA2F1FFB60DFBC55D657631AC2035D9054D30391E05
      222A5C81B2B91E0C92AA9C6704BF3823B8BA33CF087EA6D6DCFEBEB5264F31A9
      01A88AEB444BAC4779320A339247F08FC585BFBF67C8C1F7C33486DBF3F7F7FF
      861F5106F6D8EF1AFCF45FAF0F4E8F0E5FFD1C742EAB6A5C3E7FF6CCBD6A3F36
      D74998019CA94F6AFF19FDF7D9B92937F0CE4F0F6984E5D3F5CDAD9DD5ADED9D
      CD4EF08F7FFC1DA328CAF4E151D094CF1EC7247D1F0D57BF78385F34847FD0D2
      2EC96C95B58D9FF0BAA4726E6917704AE86E6B79FBFD30CF2BFD31CAD3F2163F
      982CCE2E4D61F8FBF80A8A7DB025F87EB2A0A3F47D39ACB2C15F1FFF146F937A
      B1C570683A4B32404F86B6753336518EEDD43DD5568DDDD3E3DD5EF0EAEDD921
      CA9AF7577B68683F695BA048477C704DAB0A6603627B0CE5145CA0A300D99BC3
      7DA9D04106394D7EC315D29FD1CA91BE7CA8868C510C6CD45658501CD15ABB46
      AA7D78CBEBC1731A2E3A6E7200F6003F816C44F45A323857390ABAF8E1E2322F
      AB254EFFB9A45EEBBC6719F3F6360D795F00F539BE071F00587CC13804687E9E
      4E46E4182415D0ECC856A651810C8FC1E6B1C7B5B52AE8C613D4C52C2E046170
      190A104361E84865B4ABC1E46209C015F48D0410FCF0CAC52517629D10E56D2D
      93DFE282AE9A951D12A105C0B9E4F46518C7D81124D6B20CFE72747AE4DAD594
      BD0D4090525324293E08272F8D5CCB847D74D6913152704B6F965C6416C5C396
      E41E9E1FB74C60565CCB242ECE14783067DCBBC7F067A5F22E924A4D626D702C
      FBC16E5AE63D5A5DB0D63AD3DFEEC06B05808028A396C9E5C4AB2650121EE41D
      B05018B5854ED40A2D6BBC51A4E46C60E8308157D3B2A1DA3DB3BD5A6F99BD70
      4C7E800376D63AD74C7002B9EB97BB29BC6EDF3881430F9B9016C6BED1BC1B7F
      9791C179FFA098A0040119F0F5B0BCE6A1BF7912FD0B3DD99DEFDB93F55398A8
      A3810DB3B850C38D71F40FA44A31E4380E4BB24E830E58713AC195B9A343B96D
      360C12D21EE6A2058B6DE1281A07D8A306EABE6B5D35CFABFE137A6A7D76BCF5
      BBD153C8538CC6EC3DE5A494D2944D1B5B286A02B85CB7346C2EA5216F0CA64F
      21172615D04FAE0DB39AE5348A3B45481898CB246B9BFA528B78750316B1853F
      D4BE51A17D62781B94E30317A6A5A35B617B9F6E9E2C2ED08C2A66493E0C4EC9
      8A45FA5988D9181D945D45B2EA4E1D0B888309E788521ADE4946433A33600B8B
      03C51FE7193952AF986B89EF5C7389FC65EFE8D47A4E4DC96A237ECB64EB9CCF
      D5E5672B2BF0E16B896133D9264E81A1770D2CD2DCE18B37CDF3ABC93888271C
      C7E2769658D72183EC00258631E9275961D2A485A7AB753BB748482F841A506B
      98DE582641B8D6FB5A7EEF4453028DBA9D438577255E65D051683D89C1766805
      A4D6606AAFFBB8B2029DB2FBD66FCF6D806631220EED7EF62525DBDB0FCE2412
      8BC91ED1A6A7A3234C6D8F0F2B05E80F4D18A777764B188EF3D2315BB66DE13B
      692D433FBCE57035D0D4545EA241E145E3B783B363EEE9EE072FC2E8EA826373
      35FB569A8C1275BE994596FEEB70C7544EDCB2D2320959F96CF1F9BBB82061ED
      30F8DBC494953D2EF478A2B114A1E0ABA9FA1816E1051AFEA5CF98CEA481B17C
      BB749E7C78B9B5B1B7A35E4F9B24AF03CE07345A23B57510A0748246C5FB1009
      912CBC1E318C733F7899D04E7B83120B248810E2F4425DF05CCD7088BAB46BDA
      826E2F225E2C013001856999E420B7C505480E96DE891ABA109CAC34BB92CA80
      44FA9FFCA75D45894117888DA2D79D47FD605F761D52313DBBBE126E5E04D657
      F29B896BE92926A4C4D1D019DF42F14178081CBFCD1392C4F9DDD8289B029992
      48428CC7865C9A7E702CA22865F335B6D9FF7867FAE70C7B91653277A93FD3A5
      5EF9BE5D6AEB0DACD11679C399D87B19163AEF4907150C98A8AABA6755833509
      E8AC222B3F6778D1E7EC0DECA1A161282E9B73D50716CA878E39E0F25792D573
      0447FC3260FC695B6EBF3EE2D8845606663527B59050201615C2292423E82223
      65AB644E3153945B4140807C79DF2606E3DC942CC292831897A6795F5B84A9E7
      27FF46D29564468EE807095ACBB5E76A6D5ECAFCCFEBB3EF9C0DB8F6F4603175
      E0934CC6BA2D3A92281EE4B7A4B0A2CBBC9088D020AF402905F47C52572D533C
      E1759E00344C5C2920F346218D32AE6D3E52B479C02DD2B1194C2E4078FBA8DD
      0C7FD47ADEED793DEF67AA8EEF1C197F71E11DCEEB0AC5464A3FA50767829441
      15664A3F68C8D944FB26690C6665B2C4931218A9D94C7120D34FF4599806AFCC
      ED84DDB4B3CA8423764CCBCB5CB1F8C91ADA6703202CAF827000CE127E0D3DD5
      492F4D46ED44F97CAD54455DA9F9B3A1B62547D702D3916BE682111DC71C3B59
      5C283484C45826B60F7A9F9CDD3C1BE44516EC1FEDB5521A1D0047A979181CEE
      776615476A2CB25DE33BC7B8B48AC641ECCC2CA8E1B15A44F1760D72579BA1A0
      042477E431D0D21F3541F57F82EDE5E5CB760D8DD36C86F318E0FA4A135A9F51
      9EB2FB97C5965AD05675D251C08D42ED24D645666371C1A30D72E050D2F79645
      098C2571C59478F268F7D5BEF0D1B13CE88743B7C8BB424CDC64245EEA072799
      C7CAA898618C8B2656444FB94C93DF5A4D537C6819F766C2EAC36C62FA56AD4F
      99DB9D5F6C776ECDEDCECFB43BBF7B6449B50EDE68EE3D4EC234E7BC647537B6
      E4E68C16BDD2DF6ED7E41F49238B79161BED6931C1A41A6E6BFF0BE25B459895
      69DDFBA37D013D0110B9632D3B1A996C714141D151A0785615BC214830623B32
      1CA3A62FAA1C10330AB6DE2E7129AE261D1B624B3C73A98AF22A199724933826
      F349E1D1E7DAF4CBB5E9E65C9B7EA636FDCE01C12C90E0C9FE39F4C984148718
      EB71D0AD8A7C3240D11F07E6F7C39BEC62028C5A53B6CDBB7667C64B477D066A
      9EDDBD032DD616BC82413266AA18F63735A170C8518B1AECA1007BFC74018C50
      3C691484EC38D79E37E396D2FE55E7F02500E20018DB24D65D2D61631A301A0E
      7EF0CAC419DA8B6B573C442B7200A6ADDC39F1E8972BE68DB962FE4CC5FC9D83
      62A9C2227F1124745CFA0476DFC3D7FB6796834FB456DB80EF1A04EDFB07E029
      D6BAAEDDA3BD9F822ECCF7CEBE11A018D61EC838D131D469EBA1C387AB470A57
      32F67461982D53910FE99A556C69E9DDA77F4F84350447943D6D1048CBB9F71F
      296E726E02C101689758EAF9B767070318701951264CD66EE4580B7C5AF0F20F
      AFADB464F86D1D372C0D20507BF37A2C2447AFD96DED5AD23A92072BF7F525AE
      8340A5079D2FB68C0F10F3591D020F2EC392397D1BA1A3B60887A19BAD473F4A
      4AAEAD616AA4F632203D08E870F6FAE0A8A5946DAFB99BF1E98011AFEA186679
      47E6EC88376E67773CA6752A4D921D4130E8722541DD38D830FF40920B8ABE2A
      6F9982EF6847B90CB265EFBE4B9AF7EE37131CE517F2FE08B01785C9AAF4CE66
      1BCBAF0192B3FA9506C54308E9766E503CCCE16A907FD4A25C595FFFE74D4AFE
      F2A7DA94497A9DCEAE61E4DB7C17A6E5D9D55D918C82B1E69AD3FC6B24161F6B
      9A4F0669728DE8E7E92443C394E899D7458ECA00D0D45F04FFF82780C41E84E0
      FAD2014D43893D7FF6ECE6E6A69FA1BE6194C725E36FE53AA867F8CBB3F595ED
      CDB54F430E9BF23C7F17E4B04F7DE3FB40618F0A13F6BBCD60BB14FBDCB1FE78
      21AB2460D171164AA1759907F910CC39CC6788D390AD7218D99D13644C3AF0DF
      C49479814659A4AE9F1526A49B0FD038EDEC777AE35E7066FEC6F056BD40133A
      9CAFE905A68AFA2DB3715E4E5250F18C61D95D012447E2A04560A3C4ECB79FCF
      23785F1CC15B9F47F03E53D17CF730D153896A347C04E4F381E29AF6530AC789
      FD42AD88EC57B75C3FC92004C2DC94072F4ECECE18F191E346D6816AD7526902
      1C5EA39793BB303CBA63DA0BFFF9E6ECBC95E302EFB8328EB35602B6D664CCC1
      AB8101A6982B12F3D800DA3552B79677397239CAB98F2935176174179CBEDA3D
      D6B416C2777FD205AC5047FA89B0E722B049FF1EE3DF7707BBAF7B1CF4A5F3F3
      F0AC9D25AA96C665F6F05C888F45D00CF24DB2321C1A09EA8EEF82F1E282EDF4
      B67111C06FF04121FAA165960328957F0D5EE59CA6D0BAC0FDC3DDA3004DEFE3
      9645F468FD3B82395163F719DB99DE35BC88F33405FE24DD22888AB044770928
      4FB5DE9DEBE13964A6F6E7FED15ECB84B187F5DAA9B1853ACA800A2A04C0A0A8
      E5AC3CAF1CBB1FE6298EBD64A82D0230BA6157B7EC2073D59B00BE21C3E3AE3E
      C86901DC6EAE6B20B46513FA13CD4EB0777E7AC4263E9B2462F22BE600D82EB0
      BA87B5333037F8BFD8E05F9B1BFC9F69F07FE70C07CE48D2835E8A502D441436
      90445EFD483B2D8611AE2E9FCF63ED9F176BDF6E45ACFD085A4BECC3B2171CE2
      6CE80567634336C25729DC78AC19A7F77FDE7CFD5EF0930939E455D1CF2FC3E8
      6B75633CD6904EC3C83C0F7E0A9382DEFFE0CE7813D39A31EC09AD9229DAF4D2
      A7460AD8DBF4CE28300F40B9DAA697FED97AE079F63CD82D4679416EA909C788
      45EF8E46790F6A696E84FC118D10B8AACFD8037FC7114653A0560CF6FC9BFD53
      71BD0467061CBCC14DC8962D992265195E88B12F988D747285D7C78229D6AE95
      32157CBDE7AF97FDB9C5F547B4B816175EBCDE3F6756525BD67F474BDCF653C5
      127A96F80C630630050879ED5925EB3E1972576A15E0A913DA0E285977E5B672
      37768971A3AF11947B441B8E1CD12A01009E80F3FA83C2DF491AB1B9FDFD23D7
      8F3562A414825021FE9A78C4F5C079CC6D1B5459F1C2BC3F8DFC41EBC6E4026B
      EEB461C0B3EC8AA3E0FBC9350DABCA8B9685C0E7C6CAA7464CC87D342FFF128C
      2FF3CCA047EA860D144D844ADC5C6B67BD8AF8961924F79BD0CA6659300F0D69
      5FDEE15D19FD884E9A944FB3489979A09D71E99FE4BA1A5A59F51CE3895713B1
      E848A9A3C56C482E005016DA25319B5FA5812F2E5406BAADA89E9A4CA8D018D3
      1578F6F40320D6CF0EFE53F20F5D34EC01E256D2122ED3220C06210AE923D352
      5938452965E55C57DD3E807129F7DFFB69D796C1F302B765FF82CB7619A6A058
      A6A52C5DFDC8A0EE23E2744C4BF90E69B3560E7ADF32F9712E5473A33DD9E0A1
      903B2A90684337702B8466935B36EE5739F73B3170B90CAA830D7A05BBE506B0
      9BF84D70E169A49D968DCEA641B92F895E56BA6001AA606172928C2194D1AE13
      D7F4682D19DEE282F673BC4C521CC3387CF634852D7D03FDE0555E19015095EC
      96CCF450BE50921F01E80A99794CF5B8005BE3C9CFE869AA443E7AAD48A8C710
      ACD2762DE8710AD3CADCA0B74965F15C2F8A70D4134CB97B0FD3D0069E658AF6
      F18EA8B43DA0251B8E69A70E3813E0638D2FB151DF08533DE38E29AC9EFF97E6
      175C083719E7CC4FD4369A4921D342131BD8940035C02B9F770619254F00FC96
      C5B63A420A232CCC40511716B8A5CC310A61E914EED720545044DC1B7B826FCD
      E00DDC5B4557F013F87E784C2F184F2A2EBCC8FCC28C22CF2B5B9821F6B6FD90
      C46EA249C577638B8A6EDEB58D177DFAB017D07CBD959F4C15CD0152BF4239C0
      EABC1CE0339DDBEF9D2652DAACCEA497AE655A0C5C89350F869439919E6AD720
      A43F93CCB101E35A33D6266014B0302A601602DF3D2FDA46F8766A46663420AD
      3DCE4BA5B223758F0899419125B4F828645A98161A9C35428FD4A1296F129BD7
      6797C9B0FA617F90EEA54974D5B281FDB29BA6BF06EF8A3B13BC08CB4B21B747
      9590C22177FF31AD9F56593F2D4F1F4EC3F5AFF4D6FFD637E5B8CFEF71EFD9BF
      B36E5CC25654B35EA234CC84D7C605FBCBEED1D1AFC1CBA3B37386E308F0D252
      E2DA4C35B4725807FB87FB41C84C51650D75EB52412D1B938BC0FA6D79AC6250
      19A1CB31F53EAB7118435DA020DAB2A74A556331B64C102A86A7E9739BE30C00
      1B896304B67550D240A34B416ECE990A4150791BC21028F6760DBCEE63114235
      841C9D0ED60031471ABD96AC67E8DBE2B62DF64BB5BADD00887DE8B43746DF32
      59483C52EA818EF3F86772440E8F4FF66D44D622CE23F8701D168C7057733FB6
      72ACAF8FF6579B404CF7F869F95C226B91B6440B8728153FC26C2789609F3689
      A99F87A0A61C26B76D1B9D0D3FD8F4597E83AAC7CB646CD7AB3456D2F4A11DAF
      BDA33BCBF29BBBE0C6840CD4EBB71725B77E4E7CB7A82E47795ECC632F5F1E7B
      59D999C75E3E2FF6B2317BF6BF9BD8CBE24252B76A4D17FE61FB484083138A9C
      4F04A8ADD63CCDF7D317EFA7394CF4E7EEA7EF9CF77271E125589527D5ABB7BC
      53D0BF390A8B2BE5AAB6E0C8C930882763F211B950451A7D69AB5D8314173C36
      DC17D5AEA521DCE6DCC82B11A934CFAFB82FB20A8082A73CCAEDE421EAA0091D
      4A52D05CCA8E2353B8CC2769EC99C742FCCB136CAA304983EB04BB9E43AA70A0
      B94E69AE39BF5873CE719C3F57737EF70C9B31A3E8071162D668130F2DF395A6
      636DD305EFA89B4BE45B2FF394C313DC93FDD7C968AC705461D54AD8D07B3A94
      D50D063836C595D5A0A8F3C2300F32E4BF5FE749D63264E3C505F1BCCFD8F366
      08428E9EC85F7FD0BFBFC6900F64C8CCAF8E3A2860F786013306C4200FE74023
      48136D9DB7434EC50DB16A1CE4029741B64B50A8726BEC0814AF16648ADFF948
      12860FA09B201F1BD8EC88B971A436082F6854ED1AF1E282EC81247BCAA8DF76
      28B4DC85983ABD0B228467789C513E1AA3DA478580B02C1B51094061401D18A6
      C9058A63C2083DE437C2C369E4B30C98E029FD5929D9DA66702D2E1C33378634
      6EF1E0E50FA74A94014B433A1F344409AE9277D2C1F6DCF220995B126A02DA9F
      30ED596F8F0515D137E78C135F64A9ACF637FA73F48ACF3554BE7B3E5F045669
      6395A529AA59B0E511FD1D7505F7B300F37DF44FEFA395F93EFACC7DF4DDF313
      BE985C2049F13C18A679C8D52B6318B37CAC8745520A751F4C9B1495D09DE1E4
      B7DFEE3AFDE01C1CD6E85B294C896C2BB61A5A21A66E43D21898426EA0B74438
      A20C268B0B99F9DB244C1963912C827C72C186C15D602BD4D5E5489311E800A5
      56288CA249011C3FFA5D2DB3EE7A30B8ABCCD2F4A3398D54F68317524FCA55D6
      A0BF42B76C24CD475C48CA5F2BC561D150C2C004137D3B7969091DF15FE66AE4
      8BD5C8F27F7C2319CE0E5C7EAE0CD7361F942109E841197E8EE43AA746768EBA
      DF92E8EFF7FB9D4794DC17C8EAF7D75B00938107C138D75AE0219DEEB4D4B2F0
      3AB990C28FAA308683154FFF3D7848A82AD3991F8BDE9090233BB9F643524016
      307360107884E6B1810F69ED030F0E82CF6176C7E9EC22893D3A3E6EEA1F41BA
      D0379182E3C41269D17B2CA1BD847F63CDC83D8581FC26BCA81CC9664D6747C1
      8A1905F6A5194E52DB9BC22ED988263B013936792513548F2C2E54B6A7894EF0
      8C2958C59351DD3B9C5493C2F498D1274CE95D6EC28CAB4AC2F426BC2BE10F5E
      6350A186CB2DAD60D035FD8B7E202D622F4FD65E0B282829E33BD86CE410E283
      8C2E845CD2703CE60B55B45AB552831BE8FBF602DB2C390AAFE05115DACA9339
      827672CCF9F670A63045B60CCCBF3DE2177804DD637121101757A8EB690C5E7F
      E2749DE1E0A1753D6870197C85EDFF6EF7F4D5E1AB1F9F3F76A52389C345BB30
      03DE5A0FB9BFA56441CA74C8CEE099D03E2A6EC70046051D99C286068758DA9B
      6862AE642370AD80DE82676F82B3B8C2B2D5BF224BC35EB463B4E4E58B6FC766
      6CB2389C5E1399117477BE0EE494BC55510BC51B8A3EA145C8E70F3D0FAB9EAE
      22875BD693ECED2A77C36DEC397EFD503AB42C3C1E5921B487617EB872EC5DDA
      1D3D1985DD0358679C4A824092D4F28131507F1A16D02771CCFD65E10D99181D
      668FF244469F6B8B0C78912763FCB4FEE30B59ABC544F8B426192A49C260737D
      40A3B38FA6097BC7F5A973AFE74BCD95B5FE7270F097D707A787C707AFCE778F
      E62ED067BA40DF39A9F0E282EC453DFBE1572024891226E9FDBB5793D1539F47
      590047D04B2304FBC4ABF00C03FA175D1B80CE8CE94092D39AB442477E8DB8F9
      56755D87777E882D7CC795707475044547CEC724B2CDB9E31CD83F090002E83C
      36DA558116563DB13B7BCC5E86C8FB01B766771CCB6DCBEACC161772354238DE
      9C79BA8D148D0F94E52C86515E5616AF54F926D5531D9930531F0F3A9F156C69
      34685DC2EFBB8186F5EB03DCC57112A3137271813FBAE35EC5D2A4C3A08BCE15
      4C6E16D40D87E5A817EC9DD500185CA6AB7EA54D1C0CAC3AC728C82A3AE422FC
      B1C554C707D2792F078A9D4085CC1184727BA0F199F234CB05C79F0680FD3432
      727AF27DD970F36F8EDD08799546472BA01CA558AC74C69370AE8C198BF471DF
      72899E4DD6817B3A5A60BDC75F26D81EFE0BF0F3CF1B6FAF24A2921E79CA97BF
      FEF1745FCC6C131629A85A2C2F75BBD62A3AD0DC382D4A7E12B305948CBE1A80
      E4238EE8C5E402459C9CF3919889565B44977912D9CAF381110C0C0BE8241654
      BB467A4EABF14D262DEBAC8315F5A29E50D516E276BD4E43DA09B45277F77E3A
      0D7E59E6FFADACFF8A957F204DCDAF435640B5B57746DFD5CFCEB8F38DC47A32
      66DDCD5D70F2053500E941FDE0C744A262EAEB716EAC70952EC088E1A27EDA70
      3205AA2FE25E238EE5D27552302E96314F9CED9EBEC98B94BEC431B86458C7DF
      C6D88682335718F6C230E7900EE736171714D7461AF93823EC741BDD8A935FB1
      3D93AC6FD0BA03E81397062B5844389DBCB9AF0A5684B423F14965A5D813FD9B
      2657D2C4DE115A8EE0C9A16F14481AF14970CA275C7D880771DEBA4696735702
      C003103D0279A14CEFA60CFCA2130E0FD3F2A2E55D1577EA518994C99E842A8D
      3861AC7049BCDAF5D2D8E81F2178763365C54629DA8224A2C08FA6D52A6BDD03
      F6B80C6359BA8CF85177C0CDFDA67FD26F5A9D675D3FDB55FAEED9087F4484E7
      CCA27D747F3C3E3B5F92DD89EDCC1836EEC429F3F49AD9C3D1B4960BA8485E1C
      EEF738262A9642CB14D9AE16B9E8B9766A2EC4AE75A8605CC82F02607F51DCBD
      3078891C937C79AE58BE58B13C6AFEE8BBCE829CFBF1464D2170A3E028FC6B5E
      B0E4ACE110A64975A7917C2FD831603B1F7952AD61A21B6A5912D6F5684466E6
      FC34FCC245BBD29F03E67CEE59F8DD13660AEC994D950C930241152415EA2202
      3AE8C857168F81EDF9762D827A8461B00AD7AF393A2E010D530EBA81AF3C0449
      50BB4688B88D438A4023D0455EDC059D9F92987C3104348EF338F811AD411DCB
      92176618BB60F8B161D3AE1133C3826539A4015AAB2CA0E3E215AC3B59CC085A
      5E98CA0BEDE06F9924F86825870C285093C47E157EA06F418E37861211C2C7D7
      617549939DB4AD316A97E68193DD9D4906A0D2AC63C3DAF07E39A624B5505ABD
      8F54AA1AEA4C0BD0AED19E4D0712BA93928620DD0BBC707BD622AFF2A0BC4AC6
      3D44B9B5C1AF17F4FB4BDAC110F925241CACEB9CB90042A7E77E7B956746B233
      9D436421AAC0BD43A75DB20B63E4C331F28994814885BA6D7EB4ED1AF9709844
      C831296048BB062991EBE7417D7A457C62DD143912F6167E95CCCCBA16876BED
      1D7B8404879202CAC1907EAFB328A15D5A5DAEEB11C12DF1DAD02C911AE1B2BC
      F87EED921E1961A6007C4A7563C2AB3AB36650269194233D06A5CAC683598A52
      FCC9A592DA35E8C5053E16876EC524F712729D179324F5C2B84C735E486AA713
      74696795C1DF2688E787C140EA55E96F89A22F91B68D8C0086C3885AEA07BB4C
      14C0D14D57271293A25116657A2B0486F56171F0E2AED3E054B701CC9A9CD135
      23D5803145FD7D10C1B8E29B76C2E21CD78A0A198A703C4E91A655EE17A983B1
      55FF51524493114CD2A875D1F2E96838776116F98D8D3AB143149428BB73C58D
      1C8243EF19F8B1B8F02720BDA399A09BB26EB8E2326A1B8A128849AE0A1428AD
      9119E5FDE02C77757630184C58261C0D205BCFB27D032C38CFAF5AB6CD9136BB
      435DF94570F8E49ADB132F727A6D92C200C7C19FE6AD565F18E69837887C6E98
      E33B27BD6906FCA177A53D31F66A9B4849B4CDFD7B69B3A9DCD40CF3ED358A56
      B88A6A2FCF62C5DE61A2073A2C631EAFF4B9B62DC4E1221865D065835F741D9F
      0269484767CB78AA1617EAFC9357FE75DFD1136B6E8927512A819F097E08D703
      8741BF32E53A4E4F875ECF55FBAE6AA3C4D21F232680F5C1A18FB0D46A0C87B7
      1874D567B2809C48FC8FC352735EDA20EDC02A5B26EBD7D6002EB8449A097CFC
      664B8855C283B5E89410A60E135E90553B3F573F755AFE8B2CAF9F6176E180E5
      DF7669FDEE836D669EF492C03B0905D61B1BA4D8603797392D3E354810D1DDCF
      C9F827AFA84F8ACF84D5BF043F91693C9CA06CA49A510CFA00B90FCE35EB3A68
      1B82F4DFDCD6858FE1BD26919940D85F0F06FBE9211607C67A38E245F1492D22
      00E2FE6A13501798F65C5F25F7872A80344A69B9AE89C5A458070EAC099A7092
      5D4AD3D09026EB5262ED270ADE8FCFEDE9FC49CD0BE10A596B65BABAB143FFC2
      97F97A4BFDDED25E5BD958DE6ACEAC0A6B6563736579756BC3D2F4D2B4FCDB7B
      94DB9938ACC26063797DB0BCB64C025C5E5EDEA4FFDF96BAC155DAA9662736CB
      C3C17038D45AC2687995FFBB26BF6F0CD6D736879B666B7D7303FF6E0C37D6B7
      76B6963737B6D636E255B3B5BD196F4661B4B3120DD64DB4B6B6BCB24C176DAD
      6F0FA3ED35B3B11AAF878B0B3BD160951EBEBDBA6176B657A3AD6D136D85AB5B
      51B41C6DEFECACAEAF6C463BF1F66035DCDAD8A097D95A8FE2D58DF5F5D5707B
      75796573335A8DE29DB5B5E1D68E591B98B5ADD541BC325CDE1A6C446B3BDB3B
      51B8B51E86C3E1EAFAEA2A3DC60C5606EB5B1B71B8110FD7B6D687F14E182F2E
      6C6C6EEF6CAFAC842BDB6BD1E64AB8B13CDCD91EAE0FC2811944ABDB6B5BDB5B
      DBCBEB74B39D706335DCD81A984D1A23BDC760752DDE363BCB5BAB2BC39DE570
      3D5E1D866BDBCBABD1606D636B7375737B791893384D14D3ABAFC4D1CAB619D0
      5D56D6B6CD5AB4B3BE166F998DE5B5C1E6E2C2607925DED85E8B8D311BC31D12
      C3BA59DD591ED03BAC0DD736D74D18AD87EBB405B6D7066BD1F20E09CE44E1F6
      70679D64B3B24963A35F073BAB5BC38D5513AEAFD253C29528DED8894852C39D
      959DC1B2D9DE309B1B342D2B6B1BE1766C569787ABCB83ED6865355A1B2C2F2E
      40D81BC368B84906FE0A3DC06C0E866B831DB3BD43AF3F8837377636A34114D3
      7807ABDB662B5ADBDC305144AFB1321CD2E65B1E6EAC0DCDF6CA5ABC1645F41A
      83ADA1AC9521560FAD970FAD339A0D9241B845B7953F2E939FB3C23F0C74A50D
      B756698D455B6BAB435A57FAF33616D27033C4CAA2F7DF32C3ED8D414C625CD9
      8A49DE34B2155A553413C3706367797D0DD3B315D384ACAC6E6F0D37B7575757
      0631AD0843FFAE0F1717229AD6E57030203993B8CD70B815EEACC543139AEDC1
      70C7ACFCFFED9D4D93E3467286EF1DD1FFA18FF6C111A86F54EC6925ED86362C
      69D7ABB17DF1A5802A68DAEA698EFB63ED0987FEBB9F04D96C8224D828CCACBD
      8E5D4833D364570295596FBEF9669104A32D121D1F534A8DEF4DD116E0F59D6F
      8B0ADE64C03980E0D8BA6453D0AE613A80A7693DD7E51A9D00B8774D56C910A6
      6C94EA92B36DE74D139DD2ACC2D0B6395A19A553B1DADBAC58E1266B26E47267
      ACD7DA862185A88272430E20AF95A91562466698C1294F62051370A5B4436AFB
      380CA08618F57D2C76E815F683EE8BB32C8A2765A2B5BDE7579E1924455EC1BD
      CE74194CB7DEA594AD2AB9E95C07E2B21FF2766D96ACACEF428C5EF976C7186D
      DA33C978C01C5C0196707AD8FE7C7D75F8487EB6991314FE047845BFB00ACEF4
      3637ACBD1656614D434E2A84D8C0062C46074CADF3247DDFA5D2750333B326F6
      2A5905BF10D138806B32B098D698D0970C8E4999EEFA0A7FF88185EC9BD0E436
      7907E594B6155007F82605D6ADCDC9B6AA67A17ADF17CEA948B01243AB887867
      5B122D0F36024BE3981B5401064146EE5CCEBAC9BE735095D3AAB01639BB42FE
      5A8002D53183E0426959CDA02328E39738C28236DAB435F11F9ADE9BE822A41C
      E4B93EEA6DFCFD5CFCB73F5F5FBD3E32EA25E6A57770444BC6804950D40CC542
      1EFD603474A1815F69C9470D8301ACC829B1C8380C7B83BF3C78B838C7385034
      6CDF76D4179F184281E2410A5DCF42EAC81AB6E1FA0A0283798887E5B161415B
      4D060F11977DEC0032E90BD2B331311550E612A5A8148DFBB1ED6CE309764729
      1D0AECEBE48FCD43C8B91F5CD13EDB8EE585E90299406A126CD8AE748598B09C
      5EDBEBAB360F89A70C55021006A11408BB4BB68936910D850B9A26043380AF50
      3AF2315B4AA006124D0CDE36063EB72131B287A553DF16DC74A6B4C12BC87380
      F79D2D457583767DA7C86DF25849305AE24A65CA2D54DC72F5C8EC72484587B6
      855D4A344937365BCA6881FD29B19406936206541DCE9A92FC40209AA471A978
      630165CA9C308298DCF68EB4375A43381E885A98B5A84622014FC0622EF76568
      24178A3249D9A01A567CB078A85C08853026A134808ACB001B3EB28DF3D1F8AE
      656D9CE95B348986394D82318D693B00946C0CC07A6872D71A12802A4144553B
      A82E84DEE3A2EA3A64016885348AE0204AE1EA2D2200B8786A4C706D23243920
      2A5AC5EA9236192F540E546D889D1ACC79410A42A049B0B61033708D04815346
      FEC287040BA9A1B0D8AD815D066840533F3B68BBF8A10CF8DD51068941B12110
      14D846596722298970A374C0223CD785D4E9AC95ED489921E5A171A53416B7FB
      6C75A01AB44801DD26C308040849104D4BCDECC048EA55A79B48B68272961F44
      DBE049099639427A0DFCA260654D31E8B5E90B4B1ABD265F7A909354142401F1
      68E995A1C8BE87A41360D44898A4A18B9E9A117BC4044F341DF384D64251B88B
      32B3634AC02194E0260F5AC41CBC48FD21002420A43464CAF2F5D5E0841B7308
      0C623D3C15B0EF22E4627124E55E63C55065E4DF9E2A1187D0C8CFD01B356920
      1C1163E59007284AA05318CEFF2632C419E4083C6DFB41C10D3203C6F033000B
      720E545A27FFA68EAA35103294673029F4D6A360C00645B1CD44BB4F4A3BCA4C
      8B1E3145B85F07C928A532BF683CB1B04EB5525C89D7903D451805D002F0CE5A
      4AADA316D8E45586A660229F3C4A744023C048E803A82172918CF8A5AC05349D
      E659B0650D79E26D8CD9C1D34371AE8F095A821758788D0CA32B447AF60EDD02
      5F8A7E09A84BD7F5A677858ADC504374ECFA44067AF405EE2878066860D2BB9E
      EA1C0964A7B0EC7586DCA044106212A4C2958B517D41A6817CA8B2B5C6DAD46B
      A68BE2341A96D4899604FCB6E829E30DA02C4C1D66F60492D2AED1259D77AE25
      3F416D6C2D6A0A3DD0220C01221A024EEC018C72B2FC440907883FA7ED18615B
      74BAE5B90EC90FE3248F426C5C68C9044D7C9820A9E1C10AC966D0B203304252
      71315605EE1E2836B06BB442969E0201AA4B68C0BBED2D7D412677590532C9D3
      7100ECC28251DC6133A90BCC175DA7E5329E9C8E94258971DF7A2ED118CBAA74
      09298408683D3C37500032B28747D4E1E85C03010F034A37A0A180664F3AA1C7
      C8AED6C38EAAF3E8483A16ABD0342D85CAC74629348E6D90F8944495695C14D0
      A3C54197330912C9942ED0F9500323958EBC4B836D05920809C3391BD4EF28DE
      C829A0C72AB6C1E1192B1406F4D3809009147E780377C87D387168256041B03F
      0051D700C9A6F818201E0789FA0C7752C8215BFA11A929B0E750A4C006FEA782
      B5F028C9A4E04F23C42612DB2AA41EF5DBA32548C8D88FA2485613F683003CC8
      80AF463E2041A47DD0144CC2017567E4712B092709CEF50DFD0D4D5312066EE1
      29E9514C84C0D15F4C021E719AEA90A87A0E6959087B21D91205BA815723F93A
      58DA36C800B1123A4BD9E81A617D5859626090B6233B100A0881380BD17B69BD
      7AE472C7BA804120839043DA813396010D87EA7320A5771D2A059249F4472847
      37A4C692C45C1A85C03883FC4026A08507C280B195A681C4212FA19EF6FA0A96
      0294DEBABE2070D1021DA5053A104D1928AEC87D43EB9DD1162C534F550A04B8
      531659470524552CC948D25048E0F9E07A95079A90D046500820A8D47D627EC6
      0EB04969E8095057200FAD404564159A42816F482F51329E8E840B932CB4166D
      923059B40724A2596868D8DAC085A88BB483083C299B09218380404EB038B84D
      3BD3A07814B041580587EA0CB0072768338BA04CE492E80B69433A5905A28988
      2989324D1D471ED02C50185A18B1CB8C8D6041537969975140BA23C2523390CD
      A14B00DFD2E34500A0C116BF47E5B3F29C4CEA6AC989D648714E641CB0A01A34
      46AA1D1A829CB6087F18493453DF9498C82D374096A8407426BD8033F467608A
      4A44024039A22AF02F28D92E891DD9DA455524B60EA5AA00A0E3BC140265E98E
      E98CA05166466AA2FC5B1603FC5B140F0540217FC88054A8CE03A771D235B0BE
      0801547CA1D521B8FC480E1B8A06F3A5FB46008AA4400F11307282E242314518
      A3D9E897DB088BA163A54370A813BA1BF4B4955A43B7093992B31A96A113A7FB
      2163FC00135099607F789B4604F13228944C408425C36C806E4307E11B51B550
      76246375C7C2C28570BBD749AA10B22A6B68B6B5D429A895CA0D3B2530425C61
      1A1420729E024EC908682C2F5B1F889E210A2F0DE402352C48E1704E3008F03A
      04279E862019D4233048209F4366511A8B137EA41B51EB5D0FB9B2644D54F4CB
      06FC3406AD2C55800C828300306D2F910313B4C934A58394461682DE84AAD6A6
      C82AC03B46BC2E8ED8E541E43E3C173A9D2090BE81E3AD88290B6791CA303C60
      4DD42B6428B5D4B2122C138D1F6D61237B2F88265473EA22F2154674E40DD4EA
      6045CA0133C5374F158F1DD9415941A5E514536821718284DA013FC50D1E2282
      DA8825449E6030989F54884302E3FCAF349844F18E2CDBA2507B3F743E3A4468
      E9BD6C91C10A4C491AC22627AA33938E1E8C90341D980834B9A2B983134E94B3
      3B208DE351FCA309E211958BEC67652145C46DA298D32207DA0F71929A910BF9
      D3248227DB4BA1EB84B15BEFE1075C417852B6E91A2153281DF543C14746A2BC
      A543024DD45C180E7DE0D1ACF4B682992615F09169A258363C23638CA7F068E7
      515D94EFAECFAA6B64EBACA1DF41F08A544586A222868224469717C2C93C5149
      2570A0C9684B3C6D542FBD286C419B43D396E8CE53471726BD331C0DBB42F350
      30F00D7D26FEF07F9237191248FE42E4D3A9D0950C0AE9841820C026D39F1132
      D96960B251769581231725F32810B8435EA07C001755931C28503894E7650B48
      07AE14081CAB409233CF86A6AF07D546F61E421A44B634AC003A3008D7290FBF
      D3FDA25F44032DEEE9714DC5260292DD5E4AB7B5D5E1A5A76715CE76F587BB68
      6FEDAF4C77D9C69D160D15C31003241064538B6248D38C74888A7E3AA3941A22
      4CD3DB5AE9990C6D26281B90AF8A2E8BFE022DDE373088F42C9DB4ECB1838962
      A67B65A0A1D3354A10A790EF467A7A1728CDC8749AC502754284448DA60F3183
      502544C0494BB746A6C946371A4CE8DAC265D7575C1781A139274D1240D0411A
      AFD867A8597645698D0B62CCB4C850BA019D44BE2B5427BC8ECB81CE960E6F90
      CD5315649F877AE659802015AF51B2E3D05073A077C2203219DDA8695994107A
      714A742222021C31ED36C93611ED1B3ABC4BC922C47A2A2FF207A2CBBBFDF5C9
      EA2BDAC12C9FDFAFDF977F39AEAF9A33C7B25DFBB7E6207BB697766CCFCF8009
      8EA3CEEFE7BE75CDB77613CF1DF40B711B9DB9BDAEB732E1AD59BDB5C7767E15
      A8490B67F5BAFFF6D64CE698815C08F3112281D3A599AC638D71AEAEF1FBCBB8
      ED1FB7DBBDA4F7DA23E597EB2B7951AADFDC6D1E1E7B7969EAC3EEBE7BB49CC3
      EECC0D3CCD9582A11ACBBE5BD65A2283C0D65A68958653B615BDB411417E2B1B
      7E96026A5A190191DB71C6F2772F6720B28C0A5170CFB9E81F1A084C5E018208
      0C3E689BA5CF1161B69D03D962F89D123B7A7FCB7FC851104C7320EDF4181925
      3B697E08E39C7676E834E222BFB3BBDF6AE10A6FF9575149C6398F5ED2B31AB2
      C420F365BCA7DFF565F4100BB3BD724F6FA1469F688A77CF59DF6D9F1BC7E9FD
      38BD1FA7F7E3C6E738B7CC796480DD3926CFBC8E6106DBE7F4C9A8D333999331
      E6648C3D19634FC6B89331EE648C3F19E3C7312D11978876DB757A7934FE8E95
      F0BD9D8E387A8E7160618749791FD2FDD3E3D3A7BBF2F86F778FF9F1E9F643FA
      2F13BC3CB8DBF43F1734C5D08CBF2A1F6EB72F19BF3CB37D35F9F9F175CC7F6C
      DF99FDF2F0E3C3EDE6E1F6E9138F63FCEFD7536EBF32FEE6C042DD1C8E6F6E5E
      C736373F8C5F55F0ABD9D17132FA7DD9BE3346FDEAFA6A3AEDADD5EBA4D5FC04
      CE9F52FFEA0B9FD07CE913DA2FEFB4FBD273F45FFA84E1CB3BDD7EE939C64527
      7CB1BA25C5FE6B3182A756CB403AB55986C3A98D5D61E35679B40C30539BB0C2
      66D9A24F6DE2428F5ED061A6F078DAF42CF3679E60D98A5F3881F97C2796A1E1
      C20996D1CC8513F8CF776219682E9C6019822E9CA08E26B685F1E677F772FBAA
      CAD41A369BA7FBCDD3F6C32955574DF7D8ED6EF15D6B2B74581EAA4C64A298AC
      218E1DF9AEE772E32667EDD3F856B9AAE93F8D9F19DB0C37C3ED4FCF0FE5B1D2
      9172FFA772B7F9B8BF6171D5B5F7C60FE5E9F9A16EDE7B7CEC3FCAB61624AF27
      A8737DFC5CD4F676295597FE987E5A6587AEFD0C875FACC794A873740F91F4FC
      F45E70775BEAD6F943EA1F3675A8DCA4AAEC78B1FBEEF6B1D63B31B9F9EAF9EE
      AED451C568F743FD328E7675226834595A042746752268345956E8CE446F8D53
      3BCB55BEED6C57B8B8B35CE1E976BDD778BAB35CE5E9CE7685A73B4B37DF9CAA
      692FFBEEF6E9AE8E58BEBEDBC8A7972BFDFAF1F6A7FB24DF2051A548A6E7F866
      FBF6EDF1035A3F3DA48FEF6F7EBBB9AF4BE2AF36F9D3CDBB5A95B0B75A276DC6
      95916F29B9BD7FAE8BF5C4720D0AF7B6751DD5D47669137FDEBA2EEBBEDF7DAB
      ECB7AFC2EC3C8C8FE0F5DC3D5523F9C774F7BCD504950E7E939EEAAEF40AA0DF
      8E3787DAC1E8F34F5189891F44117CBBABB3753EBF5EBFEE92AF7675103CCEB9
      D597DD99D712F157F2433D557CFB49EEF9787BFF7395D56F3772FBDB92A7D667
      81AFF514C34F722F939D6FE70DA684FF9B0F1FDFA7C7DB3A41F7F231AA9BEFD3
      C72AC33FC8A719EBA3F89B7FF8205FD6FE5A34EAD6EEDB77DF7F77F36EF35134
      ACDC5DB46E05C5F8ABCDD3D3E6C32AFB5D13FC77FF5ABABFAFBFF0AF51CEF79F
      3EAC71F8D72B3AB2D1F0EBDB4A3ADB5A6DF20AAB6FF6DF9DB1C6C57F2C9FBA4D
      7AC8F5D7FD035DD4981C4F6585F58F493EF15D6F279F29FF4F92B07ABF60B4FE
      97F4702BADD81AF8BDAB363CE8901F9FBB7F2F7D5DCAFEB059D38CFD7EFB11DD
      AD6458B6F178D6B4AE384C4CEBCAD2BBEDADFB6F050FD51BE213E3BA294F4CD7
      4CF9EBF1AE4C4B7777CFDBEA55FEBE587FCEACEB5AA19DADBCBC2D5F7CB7CAE5
      17E3953EBF98AF727A73F7FCE1FE71EDBC47DB35E87AB1AD954A53EB954B35DA
      D6F50A5B5BB94DE3AA508D86EB9677345DB3B4A3E19A088D86ABC3B3F4B58833
      A6752F5C1D18D6BD7AB5355C51060E0CD7ADE5EA22B062C3EDC070CD5A8E86EB
      D672345DB396A3E19AB534DFDC94F12B4FD611D981F9BA753D38C13A12BE7F2A
      1F3E6E1ED2C3A715E6BFB92B3FA5CA167F6BF98787CD20370894BB05AED317CF
      DDD3284E569BAE291EB43BAB2E2976EB16582C2BF714E45B663607FDE8CC2B9F
      AF2CB6C2A177F27EBAB376074D715FDE6FEEE43685EF5E5F9E39BFCF752CB27F
      FC98FA9757495E06F9698BFFDD785BC01FDFBFBE9CB21FA8CE0C1C65FB64943E
      336A1F8DFD283319F57DC9B7CF1F5EAEBA83C27EACBD34F665F9F7A3DDB9D107
      B5613FD0CF0ED4D381E1DCC003E5B01FD8CE0E3C3A639C1D682603C3746DBE49
      0F3F1F364AFB61D395D9EBC773AB18F4F9B1270B19CCF981A76B79014037BFEE
      7BD9FA51CB90F43AFC6851E7403573FECBE89A31BA0CB319A30B689B5ACCE5F3
      1FCB9F6E1F5F7734CEBF726F8FDC7F3C781DE3C26EDF1466FFF4BCD96DD59CBF
      C874197F4705BB7F2C07564B1267264A17326876C92F24D3CC552E64D5798BB9
      F49A197D39CB668C2EA4DB9CEB97326FC6F50529A8EB52502F63F599E1CB12F0
      84BB97A5A0AE4E415D0DE0E52560C662017C4FDC5F00605D0560BD06C0BA1AC0
      7A71E198757D01804D1D804D1D80CD1A009B3515C4542896990B2D00B0A906B0
      A906B0A9E6DF63DFDF02B0590360530D60530D6053CDBFF678D9DF02B0AD03B0
      5D0360BB06C0B69A7F4F7C5F00605B0D605B0D605B0D605BC5BFC77E2F04B0AD
      06B0AD06B0AD06B0ABE35F57ABE1DD1A00BB350076D50076D5FC7BE2FE0200BB
      6A00BB6A00BB2A00BB35FC7BECFA1200BB6A00BB6A00FB3A00FB3AFEF5C70BBE
      0CC07E0D807D35807D35804FFC5900605F0D605F0D605F0560BF06C0C7AE2F01
      B0AF06B09FEFC5D5340EBB9DD5C9BB6FCE77FC53FF5E7AF8BDE1A53D0675EE92
      7F9CBC7DFCBCA13E7BCD2596D3207DB5D9FC5CF196D2FD59A6B8FCEAB6BBBBDD
      8C3B239F3EE7A374C7BBBABFFF7AFFDEB7C361F6647756DEB234EEE54E5B74AB
      67074EDB276B66074E45A7B5B3038F758775B343A7346AA7E934C2F5E5A51C08
      6F3AD6CF8D55E74687B9D147EEB773E38EBC8F73E38E9D77B33EB9912F26A775
      6A6EB0DF67F1D440CF1984F3066F86EDFC16CF85F8CDED235D08E5CC35E6637A
      DEE0ADD0CE582D88F19C4F4BC23DE3DCD2B8EBDAB82F06F0DCEEC782B8EB5571
      D7ABE3AEAB413EEBDCD2B89BDAB89BDAB82F6690B9ED8AA57137ABE36E56C7DD
      AC43FB49A9783BEEB636EEB636EE7615DA4F88BF22EE7675DCEDBAB8BB5AB41F
      77550BE2EE6AE3EE56C5DDAD46FBB14F357177EBE2EE6BE3EE6BD17EDC3D2C88
      BB5F1577BF3AEE7E35DA4F9C9BC67DEC88168BC083D1176BE8C1B88B147E30EE
      22831C8CDB49C08BC471307C99083C305826024FC3B648041EC66FC6603E90B3
      AA713EA68B44E049701789C0B3319EB15C10EC59E796C6FDA2083C17F7C5009E
      31783BEAC7C26A69DC2F8AC08B71BF28022FC65DAF43FBB1DE5A10F78B22F05C
      DC1733C88C245B18F513E95811F78B22F062DC2F8AC0F9B8DB5AB49FA8C6B7E3
      7E51049E8B7B1D85CF585544FD443E56C4FDA2089C8FFB4511782EEEAE16ED27
      AAF1EDB85F1481B371BF28022FC6DDAD46FB89734BE37E51049E8BFB4511782E
      EEBE16EDC7C26A69DC2F8AC08B71BF28022FC6BDEE1E56DF6352FF91BD1F3FC8
      77E4ADFB44ECB7E9F1FD53AABB19C83FDF3F94C7CD9D7CB1E7CB84EBA7FB9DCC
      F497F14BDBE4FBDA1E9FE48B521B35DE4E536E2DAA77B7FADCDD06D4CA373F8D
      379D345A1767AC72AD6B6D965B5F7BE7957C7182DCAED378B975E6D9C36FCF9C
      9B7E50AA3449754AA5A2E66F20BA3D4C69C6FBBB0E6518E40B4D0E6EFD393DD4
      D1BF47BF10FB617F6BDBD3C7FBE7FF8CC7F5D59FF3EC7FE9C7DFBCFFEB3DCE78
      9F77FF96FFDD99FC5F1C7F5BFBBFDEE36FDE5F3E1C4AC30FDB3FC136A3F0B0A8
      105FB68F034F84F8964A587F8CB75377F375BFE97DCAB16DA31E54B64816EF98
      A96DA2377AFC428C99A36B4AB9BE8ABAB1C505E453A3E614C75FCA311B8195C7
      F91BD4FF251F5F3202FFFFBC97E34B456085F7BBDEE3E5F8E597FF0101280AB7}
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
