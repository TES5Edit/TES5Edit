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
      789CECBD6973DB48B620FA5D11FA0F08F5BC57D2BD928C8D9BFBDE9E90B554F9
      B56DB92DB96A664A1513209124D1020136006AE98AFAEFEF2C9909802224D992
      29B29C556109228144E6C9B3E7597EBFC88AA1731184621807C9C8B1DDD64590
      E411FD184C478EDB722F6603BE63685FF0CFBCC8C7C3B03F18CBCB381D8C3DA7
      65B7F9CF7154FBB31FF11FF21D9EDD75D4F550D05FC5584C84FE4EFF351476F9
      C720B77FBF18A64951F463B8B02F60DC30B22E86593A09928BE1601C64B928E0
      F369F62FF7F78BFFB89806499A0BCB76E1FFB6EDD92DDB877F2E5CF97F9C4713
      915B1FC4B5F5091FFFEB1F30A4AB879CA4A1C8E6C774EA6376609C1E8D8D63FA
      30E6613ACB2291E1A87FFD63730346F41A26E9DE9D640BFE07E8C3BF0E4C1607
      EDFC71763BE9A731CDCD29D79B44F1FD03DDF9EF8F5FA26414C2BF9CC6F2FC2F
      811DC28C61873074719DC1A49F4581F53E28C66AA11D3D647E1DE5F9FD430E09
      642E0DAE868C231893A6E77B5FB00F0BFE837D48F2340E78B1BEFFF8992D1AEC
      4C8C52617D7E2B171A03C0FE9966B06240E96F808361BF32BEF3CCE3D30AC651
      E50DEE976D9BB778DBAC77D1685CD0FCFBD5D19BD0FF49F3871D8812F5862FC2
      E447EF40397EEB1BED40F986F6F3114EBF3A6EE7F921E33741C3F5BA3CAA35F7
      9875782CD7ECB79B9EC53D5CFCEC6DC6AFED363CEAB49D86477FCC84B8E4877B
      8D0FBB0D0F9FCFF8BDAD26F2763A9D8647B77F12FD4C5CEFC845B79A08D8E934
      016CFB200BFAD1608767E0363DDF6D373CFF26888B68C04F37919FD3F69ADEFE
      73248A24800F05CFA0DD6AE2C56ACF1DAB22F6CAFD6EB71B1F941B3EF7A0DCEC
      76B7E939B5DBF5E7CA9D6EF79A9F74173CA9B6B963373E27F7B9FEDCDC1E779C
      E6C71741A8B6C19D469543ED70FDE1CAEE761AA5A4DADEB9F7CE6FADD77D989C
      AB92BEDC5BAFFB3031D79F949BEB751F26E5DA83E5EE7ADD8709B9F6A8DA5EAF
      F73011D51E5430E6A5F61E26A2DAD377C0EC3BAD060E5F05338B5184303DD224
      14AAF0958F2826E9741B9EA982969F915065BEECF41A9F73E79E5320F55DBBE9
      19CD19D53325B5D0834EE383F3B0A8D189EF36292AD54DE4076BFBE7BB5EE3F2
      BCF937DED9BACEA3B81F2B9B7AF33A8FE27CEA21B57D9D47F13DF9546D033B8F
      E27BF249BD85DD47711EF95485EDF8DD47F11DF9E05D90761FA606A571579487
      EEC304513EA5D5868729423F545118BA0F13847E4C83B3F73045E887E60488DF
      7B9828CA676B54D17B982AF493D53DEC3D4C14E51BE7B7B0660135F1F3476884
      B5719A98FBC3DA617518A751DF7A84A6581BA85166DCAF35DE5998D3283E1EA1
      43CE8FD564EC3C529BAC8DD524FB1FD62CEFAEB1491BF8023DB36AF63A5F8754
      F3A37C254AD1F2AA03B94F41AADA405F8954F3C33C05A5EEAEEE8948551BEBEB
      916A7EA4A7A2D41D4F87DB240CEE6A61E4CC5028551BA34932DC55CBE4189247
      5507F11AB9FD1D3D8D07A90AFBDA408DCCFF8EE2C6032964AA0DD22809EE6872
      3C488D3BD5466AF2B3DD55EDE4481A8DEE2EAD4949B8ABEDF1581534AA8DD3A4
      36DC55FEE49CE6F952D59DE53D41D8D5C6F97A61571DC67F0A5FAA0DF4146157
      1BE889C2AE36D613F9526DAC270ABBDA58CF20ECAA1ECC46E7D683C2AE36CA53
      845D75A0668FD5E334A872A0AF1776B5619E2CEC6AA33D5D832AC77A92B0AB8D
      F42CC2AEEAB66E3D45832A47F97A3E551DA6FDD52875675DED276950E5304FE4
      53B5B19E82527717F8540DAA1CE919F854F59CA2FD78FD490BBDDAF38FD79D2A
      5A937EBCF378ADA9E447B5011EAF2D95C2AD36C0E335A5791DA91CE3F13A528D
      EFD4C678BC6E541362B5311EAF172DD288CA71BE9ACFD446798AF0AA0ED47DA2
      46540EF4F57CA636CC9385576DB4A76B44E5584FE233B5919ECA6768A183344E
      B3A21FFFF52213A17D31825D49EC8B7E3C13F6DD8FDC56ABFA21FC79DFC73C00
      FEB56088B98FE7EE6D18A2E1853C84E376AB1FC29FF77D6CFF7573033FC6BF17
      0C32F7B15DFFB01C64E1C77A909E2BBF800BFAA2E73E0ACE366EF67F60A4CE60
      3CB5F46975EEBA173A5487A3741C1BEC48BE4CA6F887A59E9C06530B96F8AFD8
      BA8823FB22837F79E0B4E167EC827E91C793595C3817D7513828E269905D5C67
      C1149E0BE0E38B209F06F1741CE045329B5C0C836056A41741F8CF595E6468B0
      C18030D9187F444530B5AD3F2E92F45F8076E9242D84F5FB455EDCC6221F0B51
      FCBEBC495C64453C180325E40E2E3E18DAF00FC116A8102B984891F12DF6C390
      1D8CB228A40F9269E53B09EA8B3C1137050C93FF6B986693A080AB6916A55954
      DCDAD607FC0843886022B9538741DFB10912F8B38FAB72E02FFEFD45B0486705
      AC5EC4E24AC4F6A3217311F41568C0086A004DFF82BE9D830A5D5E8A2C89E0E3
      76337CF00FDC01585D2EC234B125B0E0E539CCEAD2692D845ACF42BCC9F228EC
      763CBBD76E59631160F894E52049E4EEB707A3F33560045094608465CF0312BE
      5F04C8FBC1770778AE025EFB0B81E74A2CF4BE3DF8DCAF019FDBB90F0BE1DB2F
      07DE02DCF314F83A5F083E8FD9314C1A860AC2302AA22B0177E762128DA33014
      09FC314BE052CCE08D95311DEB8841677D0CB26004A01C5B276942015BFF0153
      2C72C7811F597A1D5E14D9B0C87F89C262FCC6833FA6F0A2D8B1BBF2322B2F87
      B1FA7E58E8ABBEBECAF06AD09F06C058E162C8177D58390819FE5DDC4E05DC95
      5F89AC00E502AEFA5998A9DFB1FCDD97BF33F93B1CC5FA4A7D3696BFAFAC8798
      3CACF69BB079C01F66E2DF9CD13BCE3D7BCEDCDE3A0FFAB1D0E8D2AAA00BAA1B
      0D2CF80ECADB25EFB517335E9EA9DDC030104F19D5F1773AB8AC21E55D44FF49
      3159EB1054483DFD7615DB9B185F6DF2B048397D39C7DAF41F3969F7CB26EDD6
      27DD7978D26E6721C4259F7978CA15DEA227ED7DD9A43D3DE9DCE97E1BAEFC05
      04C450F11B8807964BDF3E830473BA3515691E3A933C4D94D6C4BBD96BDCCDA1
      5DDFC4597C3118BA73E8D4CCA1E7B605186286DBA85EECDAF790EEC2573B5FFB
      EE93348ED36B11DE9D83D3BC7897766C6E1E18464F1F7E1D0CCEDFBFB30ED350
      4865C1FD46CAD6B3E1E5D762E502D5C075BF005092D56FFF22FA3B7AAFBCC6BD
      8AEE224C34B745779511F72E711C4F00967994B322ECD736476F00EA14373DA7
      0D3F9DAEE7C22FB70392A4B8F1DA6D1F7EF9AD2E2801372DBF87B7B47D076FE9
      782EDED2757D9F9FC65B609F3B348CDDEBE14D8ED3430DE4068C5B176F73BC8E
      4FF7F9ED56FB99F75D62F73DFC8831FD59946A5F899DD69712CBC74CF0C61522
      D488D0FA3AA27D82E8E11528D9535BC10393AE494EB759DCCFE36F6D0ACDEC7C
      1AEF95CCAC592ECF8D3EBFC47BC71FE8F1BBF7CBFD3989FF3001BA775E775664
      6932FAEB1FF4C638CA8B0295BDDFE992FF1693691C14220A1DC776DADD56DBF3
      F96B328D2EE867321CB89EBE4CD4F53F0736DA8D7C89C4815743120DF28FBC08
      405B075D9EFF9A060321BF018D5E2485FD3BFF5500525FFC603B17B33DAFE778
      D6FF4410F1FB6693BEC88081507A54CEB1A4012161B4E7B591223BF0E13F0772
      71C81A5CA253F8858EA5472FE5910BB982C92670097BA616FFF0BAD245EB711B
      D6E3F87E7D41F4018C8CBFBFF1921EB32058B6DA2AB7B778AB1CBB616D2E32EA
      EADAE8037809FE5E81B53DB03264E3CD6BEB76E7D6861FE0DAE0F7EAAFED9E95
      C14FA4F4EADAF0235C1BFE5EEBB5F9DE1CFBA00FE015F8DBA2F386B55D1BA668
      D5D6461FC02BF0F76376AD64EFABB7B6CE1C27A10F706D9DE7E1249ABB2F7F6D
      6D7F8E93D007F00AFCADD6866762160C83D751E8F976D7EDB4FE5828DAF7E0CB
      96EB777A46B41BD16E44BB11ED46B41BD16E44FB9A88F66EBBDD761DAFB758B6
      3B7EBBD776E06123DA8D6837A2DD887623DA8D685FDDB519D15E15EDBDAED7B5
      7B4E8368DFF35D0FBEF5BB5D23DB8D6C37B2DDC87623DB8D6C5FDDB519D95E95
      ED8EE73B5DA7E7380DC2DDF1B14847B7FB18E9FEE5BBFE2791EEB8F0AFD8E4F5
      97EEC4E59E8EB7AB2EDD9FA4B9ACB774BF57732161FEA795EE739A4B5DBEAFF1
      DA1E90EEEBADB93C55BAAFB0E6F255D2BDE374318C74B174EF74BC167058BF5D
      818B02C093F77C9D64BB5AF4F36DF1DAC8F6C73B238C6C37B2DDC8F6D55E9B91
      EDDF8F6CEF3AB6E3B57B7E83E5EEF91DA7DDEA75DD6FB1E946B81BE16E84FB2A
      335223DC8D705FA7B519E15E15EEAED3F3DA5DDBED3684D339AEDF72BA301723
      DC8D7037C2DD087723DC8D705FDDB519E15E13EEBD6ECFF59C6E8370DF735CB7
      D7EAF47CD737D2DD487723DD8D7437D2DD48F7D55D9B91EEB51C77A78D1D717A
      6E937407C9EFB4DBED5ED7487723DD8D7437D2DD487723DD57776D46BAD7A43B
      E5BAD9AEDD20DD5DC76FBB2D1F940023DD8D7437D2DD487723DD8D745FDDB519
      E95E93EE5DAFD3EBB86EA7E1D8BDE5B6BA5ECB38E68D7037C2DD087723DC8D70
      5FE9B519E15E15EEBEEDB7BB5D60A24DC2BDEDE1C1BB6F62EA8C7037C2DD0877
      23DC8D705FE1B519E15E13EE7EB7D5EB34FBE5FD56CB0689D8B68D7037C2DD08
      7723DC8D7037C27D75D766847B55B8B71C10ED8EE33684D4B5BB3DD873B75AA1
      CE54B131A2DD887623DA8D685FC7B519D1FEFD8876D7EFB47AB6D720DA9D5ED7
      6BB73B8E099637C2DD087723DC8D7037C27D95D766847B4DB8FB5DD745C77C83
      70F75AAEDDB13B8E397137C2DD087723DC8D7037C27D85D766847B4DB8B7BA8E
      E7747A8D9D633A8EE3D876BB6DA4BB91EE46BA1BE96EA4BB91EE2BBC3623DDAB
      D21DBE697B9EDD6EAA51D7ED79DDAE07D6BB11EE46B81BE16E84BB11EE46B8AF
      EEDA8C70AF0AF78EEBB4DA8EEF3598EEBEED777B60DCFB15B898803A23DB8D6C
      37B2DDC8F6755C9B91EDDF8F6CF76DB7D7F67A5E83E1DE6AB5BA7EBBE719AFBC
      11EE46B81BE16E84BB11EE2BBC3623DC6BC2BDD7727B3D20C68680BAAEEB8164
      751CE39537C2DD087723DC8D7037C27D85D766847B5DB8F75AB6DD76DB4D47EE
      9427E71AA7BC11ED46B41BD16E44BB11EDABBB3623DAABA2BDEBF77CF8D774E0
      BEE7B8BD8E03B7B48CE16EA4BB91EE46BA1BE96EA4FB0AAFCD48F79A746FDBAE
      6FDB6E9374F7EC4EC76EFB6D53C3C6087723DC8D7037C2DD08F7155E9B11EE35
      E1DEEBB9585CBED174EF757CDF85E74D4F3823DD8D7437D2DD487723DD57786D
      46BA57A5BB633B609877BCC63CF776DB715DDFE99A76EEF74BF73F9940AF2E48
      ADDC087423D08D405FC7B51981FE1D0974DFEE61027B43145D17BEF26CB8CBC8
      F3E7DEE3B511EEC65A37C2DD087723DCD7606D46B8CF0977DF75EC96D3E08CF7
      BAED76B7EBFBE6A0DD087723DC8D7037C2DD08F7155E9B11EE75E1DEB23DBBD5
      E935748BD9733CDFEBFA4EDB64B71BF16EC4BB11EF46BC1BF1BECA6B33E2BD2E
      DE7B76C7733B7EABC131EF75BD36F67137C2DD087723DC8D7037C2DD08F7D55D
      9B11EEF3C2BD6B77DBBD8636EEDD6ECBEEBABE29286F82E88C3837E2DC88F335
      5C9B11E7DF8F38779CAE07D678BB29E9ADE5B96DCF6E778CB16E04BA11E846A0
      1B81BE866B3302FD3B12E83EDAE74EA7C13EDF73FD5EA7E7D98E899C33DE77E3
      7D37D2DD487723DD57786D46BAD7A43B3050CF71DC6E63E45CAFD76B756CA763
      C4BB11EF46BC1BF16EC4BB11EF2BBC3623DEEBE2DDEDF8BD96DF69486977BBAE
      D703F96F84BB11EE46B81BE16E84BB11EE2BBC3623DCEBC2BD05E2BDE5B59BBA
      BE396DDFEBB65DD73567ED46BC1BF16EC4BB11EF46BCAFF0DA8C78AF8BF75EBB
      033CB4C976777A1DB7D5F69C9691EE46BA1BE96EA4BB91EE46BAAFF0DA8C74AF
      4977CF45E3BDDB546CD6E9B66CAFD333156B8C7437D2DD487723DD8D745FE9B5
      19E95E97EE6DBFE3B76CC76B70CD775B8EEBF77A8EB1DD8D7437D2DD487723DD
      8D745FE1B519E95E97EE5DDBB59D4EC75F2CDD7B6DAFE77BB66784BB11EE46B8
      1BE16E84BB11EE2BBC3623DC6BC2DDEF767ABEDB729B1CF3ED6ECBF5DBB66FDA
      BA1AE96EA4BB91EE46BA1BE9BEC26B33D2BD26DD5BDDB6DBEB3596A7737AD82A
      A6EDD92623CE487723DD8D7437D2DD48F7155E9B91EE35E9DE763CC7B35DAFE9
      D8DDE9FA9D96DF6EF9AE11EF46BC1BF16EC4BB11EF46BCAFEEDA8C78AF8BF78E
      DB6B395E539B5730ECBB76AFD3369E7923DC8D7037C2DD087723DC57786D46B8
      D7853B366877BB4E43505DA7D5F6DC6EAB63F2E18C7037C2DD087723DC8D705F
      E1B519E15E17EE3DBBD3737CBBC131EF392E08F776BB0217D3E4D5C87623DB8D
      6C37B27D1DD76664FBF723DB3B7EA7D3EBB9ED6ED3A17BDBF73CCF753C63BA1B
      F16EC4BB11EF46BC1BF1BEC26B33E2BD2EDE5B6EA7E3D94D85EAF65CBBDB69B7
      BB8E6DD2DD8D7837E2DD887723DE8D785FE1B519F15E17EF5DDF76B1C76B434C
      9DEB749D56C735F97046B81BE16E84BB11EE46B8AFF0DA8C70AF09F7AEEFF7DA
      BD4E936BDEB1DB6EDB755AA60CAD91EE46BA1BE96EA4BB91EEABBC3623DDEBD2
      BD6DF73AAEE7DB8D9EF976CBEB79AE498833E2DD887723DE8D7837E27D95D766
      C4FB9C78EF74F15CBDA9549D8BE9706DB7636AD9DC2FDDFF6402BDBA20B57223
      D08D4037027D1DD76604FAF723D07BBEEB753A9D568340F7601A4EC76B6A1B63
      9790B1BF142C8F82840BFFECFD79282088600959110FC617C341EE5817C11020
      1117197FF014D1BE704DE5AE3FFB66E3129DA72DF12B44FF97EC9C36D79FB84A
      F769ABFC0A25E029F8F935FE0A5CA5F7C4557EB93AF04CAB6C5C23D1FEDC2AFD
      A7ADF22B14836FBDCA79750E57D97ADA2A4923F832156189AB946B6CDF59236B
      B38F5EE503EAC26AACB2F3D89D445A5FB8CA2F571C96BFCAEED3F015F58439A5
      F6512A84D776DCAEDB5001AFD5851B7A3DC75D0387001A33DFCC25F0DC4AE273
      7A07D65AA77FB277608575FA6FEE1D780EE5EE2BD7F692DE816F7D04F515A27F
      6D3C565F21F0578993DCEBB17AB27F606539C9570AF70E88CE5E73F5FA5ED773
      3CD7B78D7437D2DD487723DD8D745F050662A4BB91EE8F90EEAE6DDB2DDB6DF7
      1AA2F55CC773508274BA46BA1BE96EA4BB91EE46BAAF000331D2DD48F7C74977
      AC5DEFFA0D69F42DCFEDFA3DBBD336C2DD087723DC8D7037C27D05188811EE46
      B83F4AB8F73CCCA2775A7FC0F7FF419FA65722CBA250C018B1F8BDF6917ACA81
      A7BAB6DBAD7D394867B0968B38574180F34FF5BA3DD773BA0D4FB98B9F2A9BE7
      2C7ECCD3B26DFE419D43B8F841BF6196DA99B1F8B1D6E2C73ABD96DBEB317F5B
      F0547BF1532DA7D7B11DC775173FD56900890DEA96E776FC1672B9450F769B60
      A99A082F7EACD7F0980BEFEAB5FC4EBB61BFEDE67976ED6EBBD7B03CA701511C
      DBF75DC76E394EC3736ED39EB75A5D5861A7D7F4A0B7F885A0BFFAF0CF6B7AAC
      01551CB7D7EE800AD20897065C716CA7EDB73B40420DCF35604B1922D3B4EF4E
      13C6383EEE84D369DA890684F1FD6E0B30D46DC06AA70961744F8C06526F4218
      5DD4A3E139A769E3BBED76DB75BC5EC3734DBCC5F39DAED36BC233B7015D5A60
      0BB57AB6D7004CB7095D749074C3734DACC5755A6DC7F79CA65D771BF1459DBA
      363CD7802DBEEDB7BB5DD6B1173DD6C45D401DF78099759B76A1015B5A7ED775
      11D11A18BCDDC8E181517B76ABD36B7AB289BFE8F4B386E71AD0055ED44263B8
      81DCBD0674E96015BAB6D76BD805AF095D7082209CFDA66DF71AF0C50336DFF2
      9C26AEEB35618BDB023EDFF2DA4DCB6BC09652856878AE015D4ABF42C373BDC6
      7D6F75DB206C7BED86FDF31BD88BE7D9C8949AB899DF842EBA8E60C3738DDCC5
      458076BB0D00F51BF0A5EC05DCB4F37E13CA78A094D94EA7D3A02BF98D02C9B7
      7B40F58D336D4219DD1FA1E1B94671E4743D409AC60DEC366DBDD7F53AA0D4B9
      4D5BD1C0624009ECC2562C7EA8D5248D7479E886E71AF005F44ED7B76DB76171
      AD4674E980FC6BB7DA4DBBDE6AC217BFDB01D1D26AE24BAD466C69FBA0430293
      6978AE015BC09A680329356D7AAB01597A5DC0CE9ED3C0AB5B9D46D10E08867A
      481338BB6CB964E2AAE8C7D6EF9F93CB24BD4EFECA9F4E4753FA142F2E22F8D1
      BE888A608A1CC0BEC8E05FDE877F0162C0AADD81C6DC6ACCA4E90E867B1E8508
      62BA707B1EA89878D505C2E9B55B740D8A01580FA4F44D264131FE98F1EF9334
      293CFF62D2CF2EDF446046CB8BB3591FD73EC927411C9F640198DA9330CAA747
      62E85C4CE2F74136A2BB337D158AE1FF3780EFAEB360FA964C6AF27E4EA2A478
      174DE02209B25BB842828D9261FAFB45302BC669669DC38F1CEC73EB3819C522
      83AFD3A9C88262E157834C80193FB9B8CD5C24EE490A7A6378DBC5D7F828E310
      03177C3DCE1CBC858C2440DE3C4A13E40022840FC9E84DD2E1341889BCCD8A0E
      FC799D662158012E7126F87B300EB21CD82C297AEAEF6BB0BBBAED568F874D40
      FBA0FDB899C449CE384F978E352E8AE9EB57AFF2C1584C827C7F120DB2344F87
      C5FE209DBC4A87C368205EE11B5F8144F6E86A12FFF1C7C53400505C3B4ECF6E
      F3F5184C710F960B508F19BE7095E9AB425FF5E96A342B0A91D99822908B4181
      BEF7EB284CAF0745165F0C8BA4FFCF8B402461980E2E0AD8E4CB0990766EF3F5
      30CD00418A2819010CD3242DC4A42FC2FC361F02CA3800E9F8364DAE26B15DF9
      3686BBC3A008E0CDD910461557800730E0551047F0B900683817F938BD9EC6C1
      408CD338447F8B7D118D92341393E8468403181DFD3180DD57224AE8C91B7C0B
      3E0617C07A00291CD8829B18A697DE8A0456256EA6F9382B12F878068B8DF3E9
      E0224C600B92BC1FF6E153F2F8C09266B06E58583E0E80B9017AFD1BD71E8E26
      84C67031A61B9D2EAC6A7455B9865BA3117BF2F19BDA5F639C9A430FE0053A80
      603E41125E5C45E2FA324A4287AEF241100BC7B681A8FB59988D4510CACB619A
      1617F934BE2DAE932811B835FA7A5C4C8052F2292C224EC64510FE13967531CB
      455CF48338B9807FF001BCE4021E81370CE0AF6BFA032EB262945DC4091035AC
      5CC01070759D213FBEC893605AA42360E4513210710C03C5E9F5301231106F08
      C35FC08DD35932403F669047811E05F949063356FC2511D730605EDCC2B739BC
      6394A5D730E574181538CF04E15DDC02D85178C0F730D704F84C915F0C05CE4D
      C4E20A3E1EDCE453F277017F08610BAFF173815B1A0C07404F38E9604837CF00
      2DE38B31DD81702B80430619DC590CAE0202550193C5878619C2033FB80A8A9B
      FECDC565964CB33C11C5C520006A047C8B018C16224E04C4380D0A0BA6C59972
      FF71710D783C9C14C328063AB25C90D47F20F103139A65A218676951C0965E44
      F1309D0483A018C4C96CDAEA22C1C184AC0BA4BAD052F407DC3B1137F605EEBC
      C86E3B76F702775E5EC24CF21BBC00F0276391097A1A1FC14D4207238D268601
      A0F800369008D822119BC057F11510D734990DB2097E80DE4FFC9BFD9B78B236
      4DC6413242419C14374560ED4BF92C1F76619FF17198EC573DEFC11528055FF5
      AC0F57F1E3DFBC537FBAF5F837F7ADED3F9A866913001E3D8DFB86EAD0408FDB
      88FBC6E93ED7847A8F9910E2FCC29140F864C0ABE2204A2C89DB17FF02A229B5
      11646B79403FFB48FBC0E603FE0D0207B0189F40D540A22F309469104FC7015E
      24B3C9C590EEBE486784F0E470B72F80D7CDF20258EDB880D724E447B7A52204
      03061525C79ACF8B837FB9EB0253838539B6DBAAE5C9E1F184E7B440AAD24D78
      0FD8180E5D0C81457BDEC500898E3E48A695EF92297E0B10AFBDAEAFDEE877EB
      F978FD8BA1EF5FE0E717B0EAF1FC9BE8F2123407909B5E5BBF823E06CDA4AAC4
      A1BE515DEF2FE3A0F821B780F75AB02937C7615458FEBEB3EFFF4FC462E03DBC
      69CBDB2EE78BB6AB09805E7B7EA31408013E8D20FC12C0BD998D86A068E4124C
      6CEFD0B14F89E49A7FDF9F6C29031B9E3AA38B38853103182EECD305488808DF
      E259173FF43B172014FF58B09BB5288A476FEBDCF1143EFB888D8EF3C5DB8B8F
      3F6A832541FA7310A49D75FD27837073E32FDDB66FED59F9AC3F82E58C2D5443
      AD2807E218A4598682F4D622EB4184AF94019BAC170EFCA5DBEDC2123FC633D0
      3D73EB3A2AC656925A6050800A915B8320F9A1B03291A7F19580DF43502140B3
      CBAD22B5E06DA0E9842284CF0768D9ACDBCA7B1D58F9419E8BAC00E3CD3A09A2
      183430EB7A0CD6E12C07F6697D520B0EAD37B7B8E67FCE2653FCFDF6C3C9E97A
      2D17B0B96723361F24B7D6240D79333358192C07B8FDDB0FA7EF2DB02FF0E200
      3F00D5DD9AC2CE8338B714722382C0C77D610561C88F063818080DC6180B6161
      0130D5136B0824A407397DC48180491C3103A0324CBD57C3E40A172DAC301539
      D2C73443F7023283747A6B7D787BF27F08927F3F810BD4AF01BBD68D387A2DC4
      95B7EF0F8EAC197BDEAC611C8C90F7914AE08D8D4A702F94DF4760A35A03D481
      8D5EF0857A81BBF27A41AB8D9CB41FC551417221984E81FC5963CE0759342DF0
      D31C50765090801C12E5D4E5C935184BE93506F07C8BE92BEFACB566C8F71868
      A0ADF55CDBB99D89699AE12E81D83A8A72546576607759C2A553E4DE416CF9A0
      18DD999B4B739B8796FF4CE00ACEA218A4EF6BEB4D9AC62248FEF81DD6BD4C4C
      B790D02602E53A60F39257BFB97110869FC4BF66112829C7B1980028DEB35AFA
      8D28A6110C92A287E8B8046C7821C9F765BE8B477A132A926F79FE849B65FA13
      9E00B46F2E48CED1256B05F8CF8A836C242C8E08B5D2A1521D40D92EAE8540AD
      CBDEBF21BD924008660AB04E7C1635D0C10C54F904EDD1301DCC90548077E1E0
      BB567F5668ADBD8FC715C22AC668CB014BC905BEC9DF77F76F0C523F09A96DE3
      24334EB26FA20C7BABAE0C77C8837402D6CE693F8EAED095728876709057FC06
      C3208AE127DCF4FEC7E393F54281BF747A2EAE308EA65360AB78C401688CD48F
      E10B71708B4CB40F035DE6C49FF3597F8FFF5CAF75A261637BA8FA0E51E51BA0
      CE09FC71D7CAD3892086779D66714827D8B097593AB18EDE1DA2EBE7D64AD2C2
      8AD32044D91281BA2826A05407D9ADF20D5ADA63BA5E30F94BD745889C9C7AAF
      AD83643086458DC4BEC827D6FF6B7D4C3110254D2F811BD3478900F4781F6497
      D6FB348C8611FC858621FE0E67193A93FE7170B8B9B16E10F091BE3FC97D240F
      71E9FA05B29FBC3DCA2D8C52408A472C515B0E2F2F04A00450876604AFA2E49F
      6413AF1F185A84081F7E869F8A34AC10D737491371AB1CA02203AD0A69626A8D
      04D04D91AD1DC6B75AE8DCA8F1002B8C07C9EC32200680B8BE6B4540E3C4043F
      C0E77BE7E8219C00EA8BC2BA8247F2F1BAADBA6DC3AA0BB0B48B686A05F17570
      9B237F070216205F254F0CD09F9B26E1DA2D8E9998FFDA3A627DE3B48F646851
      DC92B57D7472FA6607697816879A56ADAB28B050BD4DB3B747EBB6E08E030BFE
      3CC50031563BCE30576F009A491C4B8FBCF52B00E4B7B55B1812E7F9F199AF0D
      0F8F842F0639A197868E20DE072358EBF170887BFC693D4FE7BAE8623D046E3A
      B6FA78B2920CA36C420732218994792750D4EC2B8C9E4FDF4DD2653B9F58AEAC
      DDEE2137E533906996026E4E587308D319222A1842834B922BAC174DD270061F
      B3C3BC74B1ADCD727B785AF6EBD9E56D164D7EB3CEC02CCF82D8FA7470788CD6
      805288D0D183B44A723244752993FECD355B6FCFEEC17AE571074B0DB9B1C134
      0553359D8ED9401A8904E3AE61B1EF4E4FCF252ED319B1484033B2306B79DD38
      53CF71AB2C78802C0A4FC6316C00D684E80C7C988CA10F620C0881FAD2DAAD11
      11FAD38783F725FE22D3C5B80732732802A40F1287C35F109707E84ECC459247
      B250C37A2D18C5CDD12765D2939D5F46F9002A1F6413606668DFF3D54118A212
      81BAC589F7EAC3CF6BB7E0CD8D9EF4DB7C3A3EF9B46BBD8B12E44A9FD21454C2
      43CCC3A9EDF48C94A990F01CF91B79916BCF207B63AFF5DAF13317779FF441EB
      1D122EA03BAC3042EF3BD233E712ACDDAA7C5CD58FA2F820AED94EB7D2049099
      82F273CB860D1BD15901F3AE48EDF7DBEBFE4984BC3CA73D8E92E9AC58BBA523
      6EFF8A4CFA37ED96241F0D3A2A725C9A00E62DD159467BFDFC8FB3430AEC59B7
      C59267E23C9A086B1AE4392E2A4B613DC89A62BCC8660919F17C8EB976F2B685
      7BF98F19688CD6C10C98D1213A2594DE018B1C883D9190FDB3F54960BA91757A
      72766E1D0545B0B56E6BA580D3B3773F722CDEC9BBD34F1C3C42BC359D4C6351
      0820614A61A20D9E0600160C4C5DBB95A221FB2356AD919E333CEF98A0910EFC
      09FDC67B1C81A19CD19B1BB8EB2A3035A38DCE91696D130957825663312C76D6
      0B1C9B1B4D6128C0B4620BA68F7A15EA1BA074FC5028FF14213FA99A6418E7D6
      F1D9BBD2D32E555260E1D2BC027986E607DE84C17C6B27A79BA12439FDF111C8
      38249CE333B0BCAA0A1C3F676D1DDF4C3924CBB7FAB7E81BC2E3F121283BA165
      6F31C014B7DC3A1C0BA02D24B2634A10DCC297AEDFF15533D48E9310EDD4B363
      0E67ADC26B2A32F60D8A9B6050545DF9B0B82202E316487530463811D0140EEE
      F7F3400A9E00A997316FCD444E33C4DE55C529E7141355C6D1A5B038A34F9E01
      B2A89501F41830DDA7F1FE2C800039D507DE2B139F29129A780BA8FF21701A62
      58E5F99095A155805614A8D8EB7A145807C5E646098C3CB8E248F121AACDE8E7
      4A81ABA8009E01FB47E0760C2498660274D1590E34F6AF9998C1689894CC7664
      310E0A1A6317532E667141B647C27927719AAF19196D335FEDDF5A21C6A920B9
      20B43E08CE1C60E1F536019A4982987C2908043A783A130A9532B56813566302
      CD9F3BB6C65FF5D89A9E8DE7585B9F93311EC88162BCBFBFBF25839291330CD2
      7836C15F096EB605C6FCCC90CBBD40953A8F75067A20AA31C877961BD3BBCA01
      A96F938894BB7C36257D9994DFC51003FE8CEE31D0FDC84EDB9710E44301507B
      50E9C9043AF8C317881ED7AA2D4E675FDC88A5E71558003A4A8B477F4CB4FCEC
      813DC120C85F60E9801953953AB06F18D2BDC022C71662A96141C482DEDC32D9
      A0EECBCC84A827583AFDFC0B3706BDC4AF31FE11D5F27D914F974F4C9A9276D9
      7DAFAD046B1B2DCD08A3D1D539B2F281EDE890FF88393A3CA7B3D122760ABD67
      A7D0993A73275B4D51EBDB02BD4553B03922195842A7B613344AA631D9BA22DF
      B5C4FE68FF0537260CAE93D10CC8855CFB61168CD204EC6CF2F42F7DA314E8CE
      C75185FD29513848277D604D2F240B90EAD123B37CECDDCE05E69DC4E9F5CE4B
      49823F4F8E8967724C4C8EC937B0835B2B6D07FFA54DA7B99F7072C05813E569
      B5FAB3D17A6D3458F46D2AACC0A106F3070CAFE531456E514542F6AC07F0E108
      C5F32B2BE5A05D92C4687D9D1D9EBEA340AA68DD309E00819BFA0B2E916AE451
      1CA08C94DBB50813F7749820E81FC754FED03AA0B224A0BA600E4AA03C1F333C
      9010C98C9523F48571EC42E52195BD1B60CEFE7A41EB2FED36C2EAF0F8DD3B0B
      9667EFDA9473035A453E9D65D29BAC2BB25493746478A50AE3DF5FB775776C4D
      2C47C12418E1613186360B0A6DCEAD4994C7016817222CE3D4D66E8D546985AB
      925A6FCFDFE76A73F57903E800190500506A0971053C9C53A72F98A700F058B7
      18E17687C293C6698E6B3C3EFBC8276760968CB274365D338E06CBC134A98301
      905DFE7394C674328859DA602DC9305822C5341902572BD0C82D66797D6FD76D
      C93D4792E7AB93D34EFB37CAFBC44512A7E26A6909D5882273152DA14130CB85
      053309F3413045B368732386D522AC38CE3053D13CA10E4BE3509FE487758B42
      6B5358381668464B9B4FFA386F92AF64C1313C37E578163A5A04469683398F71
      79F98CD0690D1183B2546EA7545AEC17114CFF76F4E1E0FDDF0E9268C27401DF
      89D7D69B806AC10FACBDBFE135FFB16E6BED5238F81883EFC0B2EFC3EC069842
      C50A08F0E96BD4ED91B3F53154AB3F2B0A64D9D190BE973580228CB24D2D2A8D
      BE769991ED1EC54E7302C03BDC430C8E185A5B47024BA701BD1FFF6B164D2942
      714B210486D2A4A1CC515ABB0563E5C0C320A1C42B2AFDA4E23D3892F430C638
      4C5063CF6EF3CF4514E35591D1151E0BFC429B0E3727D1DA456376A83EDE16C7
      604A6FE39656AE75493CE66754445085E591D73203D30524C0BA2DDAC14507C4
      8CADAB8A7007F98415E73915186333D76D612E2AD81C2ECC31EF94CF80791FC8
      B1DEE10510ECFBCF67E76BB73247B2E5F7E71FDE5B54839E4AB0614E964C6801
      AE7B9D4505768320AFEC2C49046E31D62D00949D4409EB6C36C50AAE1D5FEEB8
      6835BE3B3DFA116D6C2057543878A5D54AAE6C3103B17EF80C5A1B6CFF2CE182
      AF1452FD06F9B7CCF25F3F08782E051C5D5B877FB7806361A0152D482200AE42
      701C35936F48B930C0AE65743932F8BEA824EC916366DDE080455A3CCC11A028
      21F2A7B06A32B1228AE90C74C1D610036019388A9573E20F3D1247C9A52E48C5
      FD2A829838854E1A9F2520E5307C0DCFF0D60B4C0024D4D7C9F564E5B818D6CE
      E87C8D33E0743D1B0EC31EA60330E1401294F5B7F429DB245D374F44C7A382C8
      937E349A615D4BE0969CD10A00F8074800A091211D27AE5D7E6EC76F5ED9C703
      E00D6BBC32D44C0E155D1F48813DB73A159D5B21E543BC730AB6E874EDA8B485
      3A8BE65E922461ADF0978AB965B70BAE5371A9CD0D59830AA3E65004C0DD5C6C
      0F9E94598B54C935B1C48DB461A235A3E0A6606D5DC5E5A876424E3AC124B804
      219F628993244DF682D1087877BE7609BCCD91EA949F4D756A0E7E7EAFB2B4A3
      00BB7F59221C51568CCC86E1B4C011CB39AE9C8828246B32E605E680AAE809BA
      8FB54A8EF18FD3F41208CC0A64721686C0636033BF176BA9D081043E8659B3A0
      78A17EF56781F2CF22BBA548A6B3717A7D287D9CECC90602BD251F67CC65C2A8
      54D44064454001ACF2D63F0B207ED2A5B1B665EEC37F595DDBDEB1E68B407078
      7B68D592CC65BA0C2BE5AC63906A8EA833AAE6CAE1D9D73A560669065C10CA72
      FB18F52013D638F76FCCE915322509C9D4DA3AA42343619DA75BD67456B0B3AD
      FA24932E5BB6B14EE95E2F603581AA723A3C901EF724D22508C9C0CB2F234A52
      5AAF05376347B56E8C45B1EF851809AEC73084FD2D2CC125A2F352DB21461325
      7BD41890F2BD016AEC77BD2532841953583D3AE2D64DF36B02143011CD70F950
      69178FC949C1B12664DAC04AE9C401338C9438A3031A2E76501ABB92F066091E
      5784EB9963728F62503586557D8421C55B90B1278195EA6CDB8AF65CDE8E7F6D
      1D82BA196668130FB72C3ABD2CF3B9D6F150BA0964EFE7CA34E1F97B5F8C7502
      9B125FC482E0BB9CF189FCBFEBE634B92FD5B8F5EAECECF837EBCDE9E9DF41F2
      88801361CF3E1EBFCBAB9E232AB4416EB5F55A3AD0CCE2D4BDF370282BF1EF63
      999413301F3F893C9D61229F66BB32D55A1E7065EA7B9D094B43AF17401AC0C1
      35297EC5A214BFC9AA14B8E59B1BD7B9A211C95EAABADB36576E47C30B014625
      93C49AD52B68000847EAE83CF26AED282EA8935068C07AADB5911A5429DB3BAA
      3D2A1E2438A794BD9BA553A08E6B940E4A70CC6925EB05900670A4D914242A80
      83C4E1E6465D20E695F00FEEB976A7649AAAA60D0433517A49125C618D312C46
      2AAE4DF0B3C904FE4611D0ED958E80C6705972CE5762ADCECF8FDF608D5BD99D
      EDEED1E6D69B5800999EAA2A15EB560BA9DDE9D557FCF3DBB3B764F07D3C7CFF
      A65A573384DFE1DA19BB7FE9B82E75171D0EA31B0E98086215B18B9E0EF467B3
      79BF5E0BA3E34647AB035B0A451D674BB1F52D2CCEB577821D05B7EA15262974
      505790072CFE890F25296C8E8A4544C0E40E451C53A8D19A213540C47B75F2E1
      E7DF2C5CBB65233CD08AB026A03CC262CF06591AC76BBB283A4CD8FA8467C013
      714621511FB3147D0B997573766C1DAB3A56D6BB74B46505574114AF9F17FC13
      1B38EC852B9B1D581FC1F20115F00C1DB664010F6798AC80518195FA49286564
      970C4C8E5FAFA5A3775F17C907A3972B04FC0CBA992A4531866596455BD66959
      51124603E9C8982539DBFE67B33ED74FB70EB22CB85DB375557C159C1E72FCE1
      F02754B5FF0E0C99C27BD01E59B3451D905725C8F3689428CB4106EFAC65236A
      2C499771A9302B1814D1153A19312267AA320806638B43E2733E9EAED7D6A254
      1F6BBB9EDA0B20F8D649C5B6ED2CB916FEDEA3D2A6297DF999D6787272B2EC7A
      FF1551B1F4E5766DDB6CE9B3AF71471DD54DA601BB0429E5F36CCDFC60F3D9AA
      16C8109DB01AC9FC35EE2B431E2E2BA6031475268086DB4F6FCFDF1F9B826EF7
      EF052823A07AA023EDA32A22B14C90AD726D98B3946A5C2BA8A8DA1A3956A6A2
      766B11E64BE71A80D7D499EEFAF55710DA62D9F93DB9C43A4F74892DA30A0C7A
      DA7508D1020DE81BCBEA205F7EF19B7CB0F4222E6B493ECBD62BF630ECE221A4
      5C1D947CDEA53F162B0D4E2E77639095E3D93306B47E1798188C6283882B8888
      C418290EFDBB40C37F1976B8B258883CF13BC2C4E08550D198F78BC173285394
      8A94E3C7307A8C62C78C8D4FC8739053BD981BF23405BA7B2858F647B56A9F54
      583214052575518149BC47B55750B59176B0E5BA751DE414D64C0906715C3DB4
      0B64D919E208980B2C3B9F4D6407F75D4B85EB85425662C4DA0E933EE797E95C
      E29C4FA8017AD8804BD6BEA91FFA61AE3995C6907945DC80868284AF458603C1
      CD9B1BBA6B0F779380B9702F955A7D518EDE668F8704918CA76A4AF6A262B1B2
      A0EBAD95C20B32AEE2BA532FDD1DB1638F4ACD2E82590536F8F225DBBF351C78
      2943987680E29E31164117784D0A3CBC57255EDD8AA3CA38A0BEC601D55D6D07
      D4871459F77B2091F7921E96EF80427647492F48A9255D122BE26C0E2C4F13BD
      4809FECD8D2F27D6E72C3C5C6BA183FCF42C9DC5D6611065898CDD080596EDE9
      0374B840F15A52E9D235CA13ECDBD38CF64B501154420EE3F63CF203A6E36ED7
      04FA366723642C4F83E4B618CBD001BA6DE78574D63F4F656AD754A6BE1F707F
      4FF74E22A3E2B38AAF52EA41339EE5541B2CBF947578023AB403C2542D6818C7
      64A601772B960DD6B8D6DAC7A0C8449AE0F9F22B78FE6370FB3188EB6D0C509F
      ADB632B87F68AB0FCA31E8BF702BB6D445B57902BADD18F4E1304D64C33FCCE7
      A72DDDC580FB0C8B078491CCE3A68A97834C70231CD8689E28EEC654EC0F4034
      6FC34471049EEC0EB517FFFC3F4A055FF0D8F03DD72788B9CDB62A22C05F7225
      4125DC8A742A2BD7809A9E306CA9F52766D90F2B9D1D0C812E464B6C459B7D4C
      0528533F47A148CD99BB265660F65B0C932D8575F5E64F5F8C846441518B9274
      4A35CEFF773A3B9F811585094054DF9C289109541EEF0F00FF710E9878546E96
      416BD311E11BD89EBD95CE07FA4BDB2BBB08A8F48A8F02B4E0E3A4C86EA72946
      663BADCEBAE55C539E1316933D50C540B8AE2A18B4C1880434C9D67FCC448E5A
      E8CFEF0F8EEEA956A71E3A4C6718A88EB57AD60B1C4D29E8CC16333111A845E5
      D6F62CB90E12B82FBEDD5179D79AE5B2F3334AA209A89FFFAE54D526CF6200AC
      7610A7B90CD0C3BA7D69A6BC9258A27CCD12149A40F68B72AAE698894D362148
      20AE6B515C4703CCD8D8DC40ABB0BC2B07CC4AC25D2B52C532D8619CE8FA2B38
      0AB538A4CED75CD31B3DAA54C57B3C2B30E977BDC0774F87754AF0F99CCCD0BD
      2DABEB607A2148F837EF8FCEB9966A9A8C504BC6627A5C41E42AC822CA33C8A3
      7F83152E6B2348F31DC4BDC74EF075CB7E6F80D1611AC7C13497E5AF2563CA29
      BF1B15F96D821D377521FEF68A92FEF002B34D2AB53276C8A93CC3068E65A5AC
      281BCC26409254B5B5ACDE825903944FAD8ADEE97CEA5C558E22748F833F51B1
      A8AD2321A6D46E00B1EC54D600DC2A8B500C2858B972CE33C0122D2A155DB6AC
      4F2F5530B6AA514D6C2F910DAAB16BBB6AAA42DA2DDA796B562DF15E7EC876E9
      D23D886F1344D7E57B0D2FC5AD325430638D187BC4E852F50E608582C3228BA9
      47791C4D3961F5844ABD8229A45BEDE8825330268EA7FA32FF3910E457CA1A3B
      3A383FA08AFD07E79F1056CCFFFF042B04740022908E242C382176699FA30135
      67683067A9165F60F563EAE4003F909F8010DC06BE81251DF37110DAD7F0F336
      F4640528E4BE37EB26DF1617F838E372604BE7172F717A047BF712EB5C7EF0A2
      D458954FF5F8EC3D554325EC0516C05ECB2910CF299716D6210D2A9A810222CA
      06B4DBBADC51918900B86339BE8C97103A095C1DE3E84A73F0F63F07A92C1D77
      C0607ECF3ACCF6CEB2694505400465F00366B64B6D4A1545E2FC30599E939062
      FDBC134D65D1B8505134E2B62058AF08CB1555FA4944A035904A8AEA06D68F67
      C7E884CDF44A75304E3F5FCB1A3E4D35C1CA1CF45F481987A57F4CAFB91AD8D9
      4FA79FE77A2D009A8C92F52B0AD1881C65750CCA5E437ECADD29256D145990E4
      609C9199AC88A552903A9F0DC6EB058A470002ACD5937767E76AEB61DBC328E7
      A66FF4187967FF14AB3E9A4DE368802EC97A95D01F3F7DFEA88B45CA92890195
      601F022EC4D2C7148135A1252E9BF965392073E4D11061CB6E18C0A5C33409A9
      AB8339CC636D6F1168E878BC527B0F2319F92BE5EE0C72945F189E4A4C4A26B2
      5B0E9E4B731F99A050E77095719999516518F9D292B6F7AD035DE162EE2C1183
      7238961266139903BE4762BB2C50C3FAD71B918014B554217EEB2356CDC2CE27
      B0034735EEFABD53041F6F9F32266E7D2D30B7E691785B8284E2FC8B6C267494
      B53C89887285FE7045655FC46EEDADC18217A2B39D274367E77D2C610EC4068A
      F76D496586601E28931924D82EFC50C5C9ABDE85CCB04231CD04CAEBD0100811
      4833B8B67F38A0DE9727515CC8CE81EAAE1F76AD1F3E275C96890E168F58BDB3
      3EE9C673700B7EF1C327EE14B9F5361449019A12F95DD996DD520EFC1F686BD0
      35178502BD0C693F4F696CE557C08600D4159E480AE8E4072ECE8C21DA3CAB1F
      D0F6E4C910F1E824076A1310581334D446E89E20051335AF514D00BD4FA96500
      8B3B725FF4D16332FF1E650EB33A18495A977193D88A2E4C07333ACBDEC6861F
      18A23C8D29F005CF75281079977CD0740E2902D8540DF31D43DBF7A3EBAFD887
      E637B92754D54DF7A2D95D50AE9B5190F60E238AA8310F967CC342F7C2E88CCC
      00CEC96B97035426CA7541F107444E88EC484968B873AF6A15EEC8D59B01A832
      064CDC08D22743A95BCA9316F876AAF364747858AA28007ED25B77ADDB74466F
      A30377A60E6CD7B43FDAFF9AEC9AEF39B6C9591C76BE2AC14D48C20B29F8B5B5
      20C1E6DBE6B09C9C7A88EB8BBB5BED034ABFC8B9042C7C99893CE7C7673E41E1
      1F67872FB0E6F5A2EEC720EE12CE03CECE8E71CB560869970C00F43A13040CCE
      3E12674B15F605F0F5E4C3CF1A5F7546FCF782AB27A7C45FFF716050F571A8FA
      5258AA2421CDE2BB4251254F0C863E589EBA664DBE042B656E82F3C069E02CBE
      172C554BFFF1DDCBA1A97117D4DD05DAD926DB7192E5FE4B9484A8210753E5AF
      C34FDF6330047FB58BFE016A2711157800C529A142F0B939274068977B5E0499
      AC8582699B3C9AF21C1897D9039143C8AFB09B1F3970EFFAC80C5A2BB45E7AAD
      57040AD6FE597E50A076C9296F36A52E14E94850DD20F2BA2FBDF2ED97176F7B
      CEDA3F8F16682F5735F159977BD72BCBC9F4059E5FAAB83666CB949FCBB10332
      BE8FD3C774708FAAC5912632C0603241C73BF24A35383972970D60A9D5A2B230
      8F5F25F5C994C2972C386564D73DB2EBF82632C10CA590C2708697105402B661
      3505555029371246433A802EA476BA8D7C67E1C9E0BBD3A31F05FCE636663BC8
      E828FD43D600845BF11878C0B11798416B05439C0732B854F55C4486398C9228
      1F9BB88C8776F318D31D83D8903261F65B0EECD1B56AA8EF0A43682ED6A85EBE
      5192019F92BE44D937394925575F444F5306E18BE8A98201B0FC8503566876A8
      90E2C0E2E210AA8CEA609621F7039E15C918F468A8F10A2B0260860F2772486B
      3A4E0732DC05343652FE2893D8C2A89D90EB31944C55DF4C903F2B4430D9E55F
      656A6EA5424326461110E06D19C6C385C5680A3C10B54FC457337AABB8B719A5
      08508A66045FCA15FC905BD858941EDAD7E92586E13678CBB059FDACB03A6DC3
      73B95E25162E90C1CB24EB89C932BE32AA0F065C4B8442F3079908722E5B3651
      F586916A9C7D7BDF279CC5AB1662E3606C1C510F1A63B2060268696F3F9C9CCE
      3573FCDE71F3A32EF28CAC9200A48A4694A88A959E42C2BCDA0D18615CD357B9
      9B64351E9F6BEF016F1D51E6DE35D5CA443D974B6CEE5BDBE7F491CED5CA2634
      5202189651F417974DD8DCC078E759461566D2E19023ECF003992B0A9FC9302E
      55C0821344B95A2D269516141F1D14CA735C54EE65EF418685F678898021A8E6
      A358A2F2D97D764350469D4846989F8061A97FDF5779A56FCAACEDB7C9307D5D
      C3357C531A73D58C28B33E62CAEBB62E298E77EEC02D328255554199A45C9968
      2C6E294C95AA756F6E84BB32033CA218F0EB34BB54538F6FA5F4932385D54958
      13AC155EEE2917FF866B184DEC63685C301847822619E5BBF5F9574A57C806B6
      C8B2B2505604A92C8BC79B077B4ABB512D4448B95A0CEAB96C8D1C300337051E
      DAD2776DE9C8771CEC1C03DF0903B64E70332751CE351B6106F53B4116E5829C
      FE00EE5C64B2728986BDAEB64D95D2CB49A1CA82D885CE25C0AC12A177AA8B58
      949C49518B25FEE3E90439B778DC4199AB651DBD3D78572D2542161EE11DFC8B
      AE54BDE50A70AF827886C6A52A2504862A3F4078AD3105D69CAACC1B56B80EFF
      AED42CF940A41AC0EA874093937196155CDFA96666CB9D87AFB943EC3E97DB53
      69BA945B5A8DD2C46C1B710316B14866CA45277BCBD69A3AAB639A129AB906A7
      82360638979EC30A1A2FC8EDC1239AE23A958805E04AB98E0B6124008A584B89
      6E427300F5C035173111E1CED23D877B888288294BAFF9BDBBF4A57E48172FB6
      B25458F79F64B1C8A79086976EBEB1A45CFEDEBED8828D3E7C3F7CB0E0C667B6
      95311DC1E8C1A40773191296D4D8013E00E94F47FE01C61C48154ACA89CD0DAA
      7C26A557C12938D2416C519559D478A5D40949852C85BC984CD30C4FB80E8FDF
      BD2BF50159412C2A5BB4ECCB83315D0285BB3BBFD749FCACE0A2F9489DEBAB1E
      3D54EE480CEBB7A929A4C95E28E894ECAE4ABBAF9CD031EABCB7F3CE68AD645E
      6F6E806207EF26A02D9C9622C20AB2E9BC8ED29B5EF57C0F67F892B95762A917
      C1AFD1BB90B37EA30C8B04348BBBAF27F56C3ACBA6E840674D59C1272067904A
      924CA81ACD31ABF42758D156478868E8D0691DBE8B218EDEAC212B4E9B1BA437
      CA1A1BFBD6C92CA3F381BBE95C454555D2295CF3AFAEE89699E01A62687EE465
      5ACB3C3C612298C0020A1C16291DA55221E72C97A0D0195EF7BE0D5E325345F7
      E1BEB97794293222A2C5C94C99A878012F30ACA19CDECBFA81A9D6A9F22F2E5B
      BE964078C113FCD2195CCD753EE0EA4B5425F2940CB28773982BD9CBA777B297
      2B1E5A3428253F20253DE7FA4E68CC2FE001DB95426C72DC5DF508D7C4987F88
      DF42B5A9A89D16BE499BF83447A0147239DC21926AEAB5F2262B0B929DDCBA30
      AC2A062B8A826AB6CCDBC67214CD2DB2010F529A56CB4637DED33398FDE94BA8
      747751CE28770DCA6F3F0F5EEDF703D7FA09502E5E6E519755D6EFE64AFE0F50
      780E971F7A85FBB3E46886574B4FEC43FC5B7EC886963258470693F8A9B60CE5
      BF87A5A0E68D47BFDA9277FECDD9018CFA62D630BBEAC847876238AF990BE7C7
      67DECA52C2F39E65C3B0A05490127F2D404A077548A834722C17216EC806644D
      9E0BE89D9CF201DCC969A7AD6F587E41CFE5D397065C256893CD303299722C41
      17E5F94C9FF1A8F2E2DF0556B15DC8315F801459605DA5D140A882E001762B1C
      5199028E59A8399F4109FE98C6513E56A4D8DA012EC5E5DB2AC5D80588739163
      D3D6742A4BB29319822A210937A31A3D10407433C56AF66C0798E35F969A543B
      5282A472AA5209C241D38E4107F65AD097C74668EB60919BAB88EB9B4B3FC4DF
      F1F40B6BD260E325EB00F8C011BA240C6A3EE0D518C3DCA869C0D95488F00DF5
      C232282A3DB36C2D6F7D7E6B9D498B790B31715722E71643AF06BA47370EDB52
      FE86B9D8C7AA1D1E498F63701544318587E98881EA01278FCC7DCC38B0816AB7
      A3E771BE7C7B349966D4A0834B4CA1BA8A67FDE42FD4EE8633C0E141C137CDB9
      1632AE6D45730824F1AAB362EB27114FAD57B2D91C5C7C1037B3FC7D1AE2F58F
      51F1D3AC0F17B25E3D5CA93E87AF64FBBF57B27BA05EC90BD1EE9FA787A9637A
      989A5E72DFA2DED2E2FD5D957A4BD874CDE95A7B96B7EF91D184B4605B4360A2
      7444C1CE5375A6439A32D9A7B277CEC47A7B043A753F13C125C799ED6582132E
      E08E5D60BA19DEBA6675FD01243DEC43C7259781ED2238D088BCAE3A973F1D7F
      7C7770786CBD3F3D3A7E679DBC7D776C7D38787F2CBBD6ADD78A9B9B2D05051E
      4FE2E77C830CD214C920A5C34B2E553D21F15D9A42353B08D16A9005F9BA5532
      6F8008B67E7905B87F8D8C6592E2299E94C25698D2290785FB0114DA7E3F5A33
      44685AF43B31C2866F181946471E94CF3F9BB2CBCEE60E6FDCB28CBC0C83F9DA
      DB6BBE7C6E80777E78F219F795E36BCB04574E99D83A49E988FFF3746B9D17BD
      B9515976D9BE61EB23C62966683B82665F5609D7991D5801725A58BF9C9E7EAC
      0401AE33242A249FA597E2916EB2E7F521BEC441C477E02825712438904885E1
      548268515FB346119F41AB969FB246F0BA35AE69C269597AF9EDF9FB6A0F9680
      8A3A83E61725FF04C396C47E3513634D167D5FF3C82888D391759E4EA3C11687
      A7FF926671080AFC406C593F7288973CD6BFC272A43972750089B899C2EDEB05
      8826307062B32CDB4BD1FA67546DFA9318A02B4532BCF5D4611ABBF1A8E68FE4
      228DF24AFD7CE521559DD002958F217B93C973809849427A96162416FC490045
      9E3765F449A5B68C2C1C0483B1A86433706344198EC845CB65206450EDBCBA5E
      B0590899CD8D3DD5627B882D4161998BB34B420A0C64073DE013BC5B3A023903
      57E35BC2E5ADCB5EA4603CA6320117889246AB455BFE0980B8A78F1DD952CEBF
      2053FB39F50E40D065AB1D680EE72F521C6F10E44B2F02481DE4B94B2EFB07C8
      ABF4329BFD3629C082CD749CF6B261A13A7A813CB5FA4B2D59B38EBE6679B8C1
      E744E6848DFCB46F6EAD693A9DC501661E626E001EADD54E81E6437851024F45
      3A5525B9A69473AA23E703ACF0B0878993619AC88235A509044F85E4E5858FE5
      E9933920BE7F8FCA333CB42AE4295EDF1C13579098A2B3F944581E2DE0B9AD3A
      B2DDAD1E96AAB3DAFBA05AD617055BAD9FC69CFE4E7E48C49E17ABBAF4E73916
      B5CDB1E8A300F741DB7EDF3B891F585B254CB6CA865765E42FE58B852ADB424C
      FA82C455946833094B3256F32D38C7AE9E7686271058A40873E2475930E140BB
      7DEB8D6CB6AC0237B68E52CCBAE2038BA4000D5426C16FF17DFDF4A634C04043
      4F504DD4830F67143D4A63E7F279AA61BCA0A517AE5025D86FF7C520C0A32199
      17035FC952322FD6C6CB7D168A723B4D14E5769E87A2CE297A07B8FF2146EE80
      F560084BD7773C3F3D54CA5E25782A16C3F9D8A90A7ED299DD360547D1F935E0
      EB65E9C4AADC0880DF99CFFD24B2013D728CA419DCDD1B8DCCCB8D203E4A6738
      91C3381A5CBE786DFB25B4A23A06682FDB5BB1B9A17004B18E73EEC83B25F3E2
      A4335426586B7F956E751A8560E84B74C4119083137905CAD38A69DB5847A692
      3276863E036B5BF9C700D6495AECC8C68D7707E4543DFC361379916202F63527
      2972151359D9251805D18B992FEBC277F900C0305BA9C5C8EE9BA2D66C4017B2
      99639D78AA50C97B5C2E333C78776EFDA775F63DF0C1C3F34FEF60AD27CB5E2B
      79FBAB4D5945359763B9DB7DE22D7BF59B1B9AA9D2C910C55363716379067229
      C4349790A1C04015E5AC8E3BE0778ECEA834A7A0911702DC0B09510DBB2A47F9
      12E829B0A9A327390EED0272A64CE0AE6055AF449A1FBBBAFE412EEBD009550E
      61F110F2392322EFDFCDFF93A6132320A580FC778A789A05604207D9978A4884
      A42E4AC745E1E217AAD92C658ABD6BFD27D1CD9E2986B5623EB6CF6F31D36762
      9A724BDA639F52529693CA6B6D0EFA338CB90039ADE1469952B78ADEA8640BB9
      E064ADA0629CA5B311A7DE6FD1135BDCC30B53A6541D94DBBC1013FE683B1AA4
      892A1639E780D8A9656F5DCB7E5E40565751409FAB4971104E5229FB52ADAC74
      DF6D16E565610387806B8462A5A861DD2A2DF059ED3E8465A7B2B4000F4ACB50
      C536ABAFE223087A3AA78A9BB9C0DD2E5444C63B3AC8DE0E83EC120187F213E0
      10E3A7580A57D7976593F5086EB3B6D5B7EA6EF970F5667E6165FDF87A79566D
      C14A2F11CA583241A9025CE65596F2AD25C251AB3484825A05A81A63AE70A684
      3F6FA51C9E0FE871A9187F32112645F921FF24E14A708DE5BC30780E15AC81EC
      B08C3553D35966F854854F9163FD9A0166A59B1BC3BA694000B3F2014175BBCF
      25CB585F4D42041FF3905CDE49E133A4226360EECD14A01E61509AA67CDA9E1D
      2C19F18D68957D515895A2761E31E39E83D13042F7BF1CE7153FBFC3E35141BF
      CD8DB208B55A529F4AC9EB0659FCA12C8353BA6A15FB4384A3EA875839A8443D
      0CB7999942F30F60A54C645940B446BB909A7D716F5676358096E85A81549E4B
      C88AD5E96814CB007B72E6467154DC72A94E797F91A6B1246EF99074D6026981
      9C630730C8BC7E94C87AD37CEEC07B46A572B689AC78FB9830F5F70730CA767F
      9ED4F4E1DB2F549B03675722C4840A264CB1EF533DD1B11AEF39C07A34922019
      1432EA73576A3D055BF174DF766DBAAFAA93DB5183C8F74B40947E0143C8F723
      EA4F30BFBDA38F6F59B018DABD2B7155CD441085756055355F99FB0138883D74
      5090823813D53AB2DA7D455F0CC17AC048C65C95C5F99B0510FD7F14362B61AD
      CA26EEEB26447134890ADD174DF678209C57013F7D001D4D8D520853324D443C
      A7A0E22C58ECA9094AEF24104DC18E33A5BA1B2A7A1865B67E0A26FD593612D9
      96F51E8C2243472A88450386E0B2D5106329FD5C0DA7F0151B58F66190A3A094
      41F395EC50727A6DEBE65C3B52DE603229655827002491BF5EAFD0FF972FBCB0
      D8A9BC2A8517DEA5C8C8FE4D0C71BD76F6C76022DE612D9FED68C80D5B9262CD
      0A3C608DDCF59AB129885665CFEFB17B117B270B6C8B45DA0489FC4435A78E40
      33D8FE6F52194201DC3694B1ECB21C14A9DF65EBC26A91A81CD8F62D28444559
      608D6A3B55BDA11C1668948B070E5CCFDE290FB541DC39CF3D7752D0FE7B442A
      0417EAECD5FE122ABC6ABB520A15BFDB17798C552C418D88B4D18D35CAA43B2C
      90F5DDC5DCD8DA00561FA081C07DDB735D115D761D238777606D912F6B0BD3A0
      8BD2F945499FDCF58ADB4521D94CA7EA310AC03ABEB9B9B128AF7ADF3ABE0948
      5B8FA36AD306D5D2E29C092CC0A270DA7ED14E00D5836236C54BB7E5595B08BE
      2D3DF16DDBA63E6247EC04F0EDDEE6465B4F5CDF75726CCB1B8F4F4E4E76D43A
      652B37ECD56515D1A456E55DEF4959E70278C6A0E07613DCA68B9D7DFA3578CA
      42DFCA2E6B3855F5E5AEDCD82C07B6148DA22257AAA2ECB9854CECC3E9392520
      C71147CA0594901F623D8D499488EAAB83E47602EFD0BB5AA9C28F2723C8DAB8
      EC29794CB9DF1BC7CC91D289265C8975C3B2CF1827FC4EA6A09EE014B6913FA2
      2E8BF901BA181445F025D6691F2B05BC3DDA554D56A8A84250AE30AA7615DB05
      83F17F10F4352A81494AA749652186D2B85B80A6550C5655811B4E92B1C1D854
      D722597E9FB0B7A304760726BAFC6AB70459DD1345E126D12621245233661EE3
      0C958F4BA382F20FCC7199A5676DEE7DCCC52C4C1F0BC0E70DDBA90110415321
      881A3C99FC254091E8741981470055F23E2C1995F3C3E89AE6469CA4D6C8F47B
      6280559497545565A3461D7964CB63A395D470BD02986AFFA74AA358EA26A4D8
      0466E72CBFA91056737FF9BEF2B291ED8BF4961FA69DF68A3496A7F2B6AC0610
      6342F685A009CB26DAFBD627DD2C972252643362497A2A018CB4BDAAA6C78A31
      31DE33D2606ECFA21BE09913063A7FCD212EBA876EAE392EE5D96B15E12EC5E3
      DB4A5F37972C91EAEA348DA8932F9A92C96D9A884A8937D56F1E0F79B9A5569C
      A697A8392E9823BE71321B8CF9B40B4F9106DCC6A456478A0EB2651D2A35DF37
      F0249EEC62F7930026134CA8E3388C43250539D033672865B2CDD71055C262AC
      8A7456B780211CC2FCA2E1AD744826B75C8FF973426EF92DD5AE96D63DD7B1D5
      0894FB69E353D9C3F9CDAD7518D0C99F91292453EAB0A9B6DA93D61D1B23544B
      0858C1904232E823A26D0E69E24A436CC15025FB4A8BEB4CC83837B69F0E3F1D
      6AAF3B2967485ED4C07CC0AFE510674D6A303F3E25A271D926C206C5F4461813
      58031FE462D45A268015C4541701CD2D2496C46A812D39D7189A2CF694A8B2C6
      F38A80B863F9AC0BA617D650AC85BC49C6606179323E0AA7796838CE0191972F
      FB4862CC3751BB7CF12E5E55335768859A7FE7D683FB233D08F520177EA70A29
      BFF81DB5CF8B3F88F3D1DAA597A26AE672DC396F30AC5CA6FDA38A5170158A21
      B023D02D66059AC7FD19F7E554FC4D06B12BCF84E2C3D4EE5D15786714AA2D21
      5904DF2A3629F745C5BAD90750F32D08488AFDE38CB24AA3701878EB282802B5
      72227AB1C5D81A0C8A591073EA240F04E6027561E07462395FCDFF619FEF4E4F
      06E73519B4D437FB254DDA2398112D7AF99AC87F579B4685518EC89013AD0D24
      ADBE1830DE01092EBD19380024A4DC765296AAD85D1ECC3045519B47FC50E959
      CBB7E435A8F0EC65D9094C0A5004872AA0A4DC51AC3A43A1B0F44E6C7B87AF2F
      7E475671F1C7F201432C0A35DBCD8D9CB5D40A7C8CFE772FF8DEC328D11EAA07
      E447D66884F243393341656814B54655D4850DA6594A9548D38AE2546991DDAC
      AD8433725FCAEC3679702032BC81236727B8495C030BF7292FFDCE1CD044A72A
      BAF360994571F8F1334673884A7D22E9ABA3FAE7A59586EA2376B5C1E3099A06
      1E53548E110CF534A42D579473DC13A9B68322EFB9864A165209C3469A3955E3
      86946FAD68066504AF32892A3AA7551B499E816987B61A43D255B5407690DC57
      FAD6A0FB031528A99D14801A1FA24E83D417230DC514FF301EE97A8007F10279
      76A93298B5E7908F47C83C9367D0B810ECD25DFAF60E3E9CBDB5B6D18DD7BF05
      83136402BA003230D2301F43DE2F39BA4C85CA755163155E5AEECF369E6E7329
      E8E25A7074380F96AB931D9806BD8A3D6A3B484B14826A7DC424B574965B1875
      94E52A969D0F6BC7A0BB5399710A9085C5D53A9D527D6EF61D5420C207435188
      3A2DBA24F5F1352D5ACF59C60A4893B2FE9D640C3186A1C93BEA87C895625818
      5740092ECDE3B19DA1EA47D2ADBA8DB3EA152353A564F1DF411CE4781B4C446D
      46690CC39AA4BF06BD0120D255A68FB288C9B71A2B635B4E22671F0855B7A445
      FC80CE0F2CE14DB557390E88CEC4558A3DAD4199DC0B41737A6692E21FA81B43
      BBA7F6D3303025AD31CE1EB337CB20B33B186F5199F551802E44743E4A0C34A1
      BE5F18EAEBAD74A8EF8F2C932CA00DB9ED7B92C7217EC8F3178A8B22352E41E1
      B65B564C47AF17E540EC62B881C8B0ED7552C60750B80EDC9BE9A2F2EA3C8B1A
      F6ECAF172E6D6EFCFCFEE008CD416C661B31B514B753214986BCFA5916DC9654
      A4A1499E7C7103CBA426CE97B75934615B3CC0B34BCE8167BF2E6F83F4EF2ABF
      6C29619534B302F433165142B1482525534816269DA4D2495D935F6B026A1981
      8E1AC702B4BC0B23F49413F2353A0F61FDDFC441B62F27B3F4AA4FA46C5D73CD
      62891E51CE8A01026ECD361CA45216243950031DA33C6ED7E72843F21CC95C94
      AA4441485CE37F24C086E12204621F63FEACD37E1C810696ECEAE3788FF534F5
      2755870129C8D191B599C03B450CC2B192E83DC18C6A4A6ACBF18C5D4E9175D6
      BB47E03C850A2F48B00ACD2E4774534D4C20EE7846C524925BB5B515F858DB0A
      2632658D0FA2EA00AA90C6927DC72F441AB0C50F11C78E3A992DBFE336717848
      16DFDEA5A2EF5D65D46A82C4B7CA216C05FDD1DCD3968AE3B65C6B9B8C983DEB
      5D50606FC29D8A9712103505CD20E3F21FB3FC25CEC806D33D6994BFFE2F35F1
      BF2DFFACEC9A14F2252FBE69C195E5DE9199CFB5602CADCDE57D96BCE85931EC
      BE48805E501206BBF1F7B170B86E6E974D88EFB0AEDC47A599338528004C9289
      20C1A038D2BC2A4AA9D37728528A0210489FCF4FBAA4666692DDA9D8FDFAE814
      3E37EFCC2AC795A57BF2521A73C00B8ECEA10920A858F1D4EBBDA63556FAEFD6
      C2E0EE6A7AB412F22DE1B955B5FA88F64E26940EC111FD533C5C91B21EF93E7D
      27FF5E32767D91C07B560C2381679C410FA4B54AF4317E20195A5D6A9FDBA8FE
      9C1D73E24B1A87AC865633BD6BB4C7448A1AED2841DA354EA12F740AF92BED14
      8297F7A301A86DA0C3B5D76B6B31D60AC5D31E89A4359BFBBF05188D04757BBD
      661E064994CBA9BBEB3575918CE2759DFB304AD616EE430C9959CFA98F04A8EB
      C97A4E3D13E29267EEADD7CCC7B36414649182FB9A314890EA71B4A638F3CF60
      1AACAD4C05D3FA5A8CD615F4D3B4944D6B86F1E840988D668C37EB07F96C96E7
      1A6B9CF59A3B581D6BAB16E4D7225CD7B917B3EC52CFDD374E86D2C970766CDC
      09DFD29DD05A6977C24213CBD0459902EED78E9C3B6D432CDF9258DA2B4E2CCB
      A7937574E61F511C0515DB95E74C18C0AB2985B26CB9CC2F1D8E18AE435CE7ED
      9D92165429795C39B7A7A8658AEF2EA1B98D6519E0237956C8A9E72AEF58072C
      23315A411F6EDAC1BC646A3870AB12356ABB616DCB6490DCDAFA4C27FFB5AF5F
      6F2DCA47C65340CA61DAA90463F369A6AE4F8BE79A5838BA12A68EC79A1C3377
      771A2A0E612A120E9809B81902B6414308E081E6B20F117F1D4CD591EC6FCB3F
      99CFC5802B12C8763C5448180B83A8EE11B2465EA46BFEDE435225D914373DE0
      BBC58DD3F55CF8E576FC2EFCF2DA6D1F7EF9ADAE0DBF5A7E0F6F69FB0EDED2F1
      5CBCA5EBFA3E3F8DB7006D766818BBD7C39B1CA767E35D8E0BF7E16FAFE3D37D
      7EBBD5FEA6B4BA847E92554490B0969AD47F631883FCE8122B8EA7C97FB7E13F
      C3E474365AD9A0846298AD09CC16117A55E34D9E35FC8D9837AC3BAAE4706D73
      19CE25AF1FB1F2055A43E7C90FC5AE0C8A041983A8CA2D7902ACD150951F1544
      290356A8810E97D2C47816D0A40742066955E27840EE84228B306D8E44A09296
      260CE341CD8DF406052FC3B52AE577556F7B1972A5742CF864EB9899FF96B50D
      975BA4DB6803927A4A95CAEF90C259AB71601ACB7523A7C984D20FB042D7CB04
      5FC6AFFF4BCDF86F0B6293BF2DBCF765971DAEF1961751B5B18F2CA646FC23BF
      8E0AEA19540D94AB84A2716F2F0A21AF14B8A5F85830C62753DABB91A8676EEA
      A7B5EEBCF4E0ECFFC2D0BEBFED830DF532E1D9BBE5DAA3770A1C97E296F0BA0C
      CB578549F33BF750483C26CF7090A2E1BA8FEAE950C6591AB65B61BB0D3DF316
      665B939F611E9AAAB8AE6A4854F2E25CB2102EE69DCD12ACBF2159AE4EE595CD
      366AB5FEAB5ACA10A6840DC316BF1C2DD759225B19C91753B904294538F6779B
      DCF027A7BECC7039EDB4D50DB8560AE195845550C52A713310C0BFA4D1B1BF53
      994F0D181C10CC39177723FB29ED7C9089A09015EB707D647DEBC226941E4E71
      BB322BFCBB8ADB2D9D135F58CDFA1901509A9A2F900CC089F9FB96D81FED2F7B
      E51CFFFA7FA56ED50887256481709D3E220C9916A00ADB0716328B58B0B2A6A9
      2614799455EC165D5876317FBA965D05A3BCAABC144C9564EC30ED51765A105B
      83711A0D2892FE452CC7178EA5A74316AEF9A91DA225502B1D13CA6C262E0AF1
      B55CDEE82D8BB763515AA8515DD8CF751734F58A2BD5622B0B38028A9DC5F935
      94A4CAA83CCDD251164C6411B36D99B655B15B5ECC6A59B2C5885EB55AAEE38B
      DBCC9B1BCBC5B81D122D9C1226FBC7B0F8DC2D518ECE80B07457B0B9513FB4AE
      1494CA0921E14E44313C2FE27A6160C45987D5BEB61A1F8B7196CE46E3FB39A9
      2C98A92A17E58CB24216D49BDFA9A8599444CF07B2242D966F5EB320AA9FEACD
      89B2A2CA3AB69111A0C3A8921F7DB7ECD18213C26251CABE9486A338ED931D55
      3105B67157A6599466D46F19731D17FB52762A9273F939C1B55CE017E0322F90
      054D3BF9A2EBAE3924A7AA88F4CBA4466F6E3C2239FACF991AFD02E8BE20357A
      F914B0FC95D7DA8D203745FFCE352AB4AA9713B5A5DF7D817AD88A21BC00EE4F
      A9A7405656DEA8491E942DAAFA7EDDCB84755AA98EA2ACE8017A2DB621B8AD7A
      9E56D0A9F24D8DD87B1C6C0CA55D8EE608453EC8A2BE56C686CB97419B1B2F5A
      47E9657C4F9B1B4759304A937E9A255F8A2CCFE877D27D93A84E50115D89F876
      B7AE3DDEABEC71C394BACB97CECC9506471AFAD2AB9B4C5FDFC07F8F93DFCF4A
      7A793A11ACB6C82036A62F6A926C6DDFED9FBA53EF0DB3743444306D6E2C9BEE
      A499F0E2F138CBA8EF234F2BE7227258D9D97D11D68301C62F70E65E3A004834
      C558559F7A0EF9AA1F2BC569A1132B165CD8DBCEBF0442CFA906210BB17B9EBD
      6C13C078841F3AC91E592281699A422E9580C7325B44C2C64A449035D4DAA770
      6A2CF98EE12CD58E15A000CAB34872F268CF4CCD7B67227FBF3177E6907805FC
      D7964C469560E76F47B58A7CBA8EF96BAEBB77A7F05EEDD905AA5C7D00A71CE0
      F0368BE2381AD447A0EA63779E6CB76CDBB1B63F9F9FEC75770C6D126DFE8211
      21AB7C76FA0D0A6FE2D9A96AFCA7798942933B3DE78017198EF2AD73096CFBB5
      6DFF66BD090697A32C9D013BC7B670227B6DFD2A43202493D93F3BFFF4F6C38F
      67BF494A7F2C5F30744EC56657DCC7F4CC61F654CE916247762DEA68A1FA6A70
      35CBB428D3530D697F2BD22E9D483A8CA98186AD6D3AB75718B36324F63D942C
      1DC97864F97D91359FC553164244746DA972E45CC2BC2C2D6E24F79224B7BF58
      7257DCC7229FFC669DA05351364DDBA62E6AAF0F7A275DEFCDC98922EE2F19EE
      6B98C7978C7F462145B2BBA2E94EDECC7F5EC077FEBFE0BF653BBE3637CA3425
      E030E80EACB8CE0D275A014EE4B88B49FB707A2AF9C2B9C80B20EF6903FB2016
      F5139D7B5847E5E6BEA02AB28EFD1A11EE16124006FC210963C33CABAED0F82E
      74888DF6B1356226AEB3A828B04962D9B09D50139031C0543FF475EAC2FCD8DD
      2FA00E4B9308EBD613B7D17DFBAA2D6604C62DF2516970B786BE72EA9F550CA4
      5DBAF9FCF8CCC7B41CD578E6C3CFD505CC2719D3B92157D6A046BEB2890C0CD2
      7A7576762C337BFC3240570EB3741FD4349E013CF2FDE2A678818326051395F6
      1EA6825BBCA89C8A28815D05B096CD6559E054A6BDA31BCC4A200EA953E3FC73
      1CC6130B6C83A67669C111E3B78536CE9226C9F07E91F32A59E94DA1E0AEEAC2
      A38250966D43818EB9FCC37F5CFCF2171A2F7FA13A57ADD67AA4C0682B6E3882
      2C5206801C9FBDB7867140557E64A2643494EADC24E21EB295B8886AE8578D15
      7E55A9B36F0A7BAE6F16E078BAE4191541834F2C677F452A9E759E58F1ECDBE2
      EFC5EF28212FFEB89760BF55F6E17A61942B316AD9A1109FA72190F5A339EA33
      B2993D1429CF50E1D07FFA5CF4CEF87776C6B73CDE99D321E876983D79F4EE10
      591A0C11E2B9B9E2617B5509B95EB8E7BF10EE29F6F07F7FFEF4420848E7633F
      7FAA15E9F4AD9F3FAD015AB678D30E29083A4DACC378D6977AD9B7C0CE25AFAE
      CDAB53EA0526DFD2DAD660EA9D7D599E3ED96B9AFEF76ECABF1D5AE18C224C50
      09A4FECAC3AAB946B9D78CB8D5269F9CE926BDE068B2B105982682EB1852F1DC
      7FCD28757E12E4459933A0BA80C6402DE16D35828175D3F2B14A47517E4D94E5
      85EC6D890CE21A475AB0B3B25BDE7416C73C39CAF78812D9151BEFEF038A5C82
      066C3C60F7A207F6E57DCFDBA0B306AD10246F6AD2C32BAEB03BB0218A5044B4
      AD3339E57D982653776F60052C3AA6A1424C418695ACD477923A839088936929
      DFB5B606E9F4162DC0FDFD7DC2ED2D76A9459328866DC18E95248CF29DD22B57
      F1C569079D3203B9662DBAE2382934402B535C4580014CDA92E26ED399ECED3C
      47AD3CB17AD158B45907693C9B240C12F24B9F1233D91E45DA7225E71F0C15E4
      004259EB06EB8451036765B3120FDAD9D5662E5EBD6383777B58778AC05DE4BB
      956F2267610DE0DC81EF24CD266F8FAC8F991846375573F82AE20A656A0B6414
      3D30175822AC554228A10AB6329D87424025C4D458EFE5F3E49C5126B80414B7
      B8A6082DFAFA711A572870FFC2E7436024AB4BB12753BF5FC69303E0FDA1E0DA
      1E62705926A59DD448466D0633772536E423FA5BCA428F26BA80007D4FAEE279
      4C55D59109FABFEEFFA62AE4A0FCFBF57FFDA6CB57FE6F4078F2BDA852CEC115
      47EA92D304D3BD42CCA7CB4591E3A3731352A31CA5337CFE10E6758912F2B0C8
      E2FF3C4E28F916A7CCF34C139872A1394A2904A94672AD70D6204E65110AE639
      BC8ED3BFAB17D2F9A6E63C5B87F3DC0224AE003081C1A9439989C23581930BFD
      B65603A7AC9C84F351256C80205F6952A43AB0B9AC6C8DF5ACABAEA647CC0909
      3F03224A677985AD0267CAC4446026C772BB85AFA3D03EA5B33ED8981FCE3400
      91D5E58A04AC711A9330393CFFF48EB62264EC1C2076FE60043B09F60342DF94
      13CABE1294A5E8A512DFFBAA2A2B71B16110E72569B0FF1E756D7E230BAC5D1E
      58D5551E8B3884375CB394ACF114668BD8D1795A9427F6EF65062AFCB67E0416
      3FE5E3AF6D9835B0FEDB58ECC85A587A7998A5F062651ED785C44E66C88251CC
      A803A9FDD138853D92E791868438DB98815286ABAB830B6CC07ECBD99BDBB2FE
      A154D266C0B70823B9373955DC8DE8FCF716045D888AC23890EA961C5E4B25AD
      CA0E51F650B77739167518A8CC069E89F262B73A0A7D8CB1B6A324AD0899639E
      9D242792FD2C6FF9E1CF6FCB434F5427EE9D97A1A6C5887258334BD20CD52760
      58C4AF72435235922AE1824E106B08F434CB6411652D6C005BB93E936C3092A2
      9D154D640D4CBC6D9452700692A115831D8844829F540DAE29E8C9A55504AF83
      BB49F92BD242D71C1A032073256AEA3BB65BDAACC92DEB823C5B2A4C752DB016
      6C2EF3E3B8C50CA3011215A88362C4062C2D42D597D825938BAD2FD4E49380CA
      58E977EB347BFD11C3E93AB8450959E04B193404B181C8284E611BFD48D7D8E7
      3719EDE8E04BD2E7031905A78CC0B12CB2D41783409781A3C2D664356E6E0028
      25A0726462E92C2974B80AA5FB53DDA85C39C076F6AD37B7382A2D8AE649855E
      F518C4FA92947611AC05581D9800D11415F7884A730D41FE17A0A3175282B3B9
      2EA7AB2A9DA3522D7026A87448DBFA0A15758AC919734EE36CBA007E547C0019
      364E92D72B2155D6EA96267B0A3413A1E6293D7E0CB9724CB091604059E29F4C
      32AC80295790336397E143791A63340ED638C0702159DA0C1F9A5FC158574328
      31904C2AE2C768A44FA6054030B88A468C50DAB1C1A5CC3012FB965D1E5B2764
      E293FD834FEBB96DED57343459DD833C36F8DC340574D5D88E2E504476B0DC80
      5EB1C87CC2E24636E04108E050C0A67EC8A5B355CE18968D65E8A3A434044BE8
      10BA1144F0737C192D8682A30095D52BD5D419D00916C9A4BDBA6F6944DD93E0
      123DBE05330511E4B7D2270B2B20863817A8B3CB442994C30ACD60B95545AA76
      7073636E9359FF1C2296C00A8311521F8F432B28B710C6207C2392400632B7EF
      267FFB51AE5BA6E1B33907A511A6650C38851A96C1B6E458A28840258F76A527
      A3119A3AD7525252F929919272C9CAE38744FBD4F3BB232171A07C9EA45CE011
      83E594D4AC7A28CB57E8D2A2A5C376D7CA5372E320EB0E23ACAB0EB4266EA6AA
      CC7F948411085DD4B56B04279DBA51C6151F9322AF3AC1A82C9464221567273E
      48E73DC032228CF28C48DB56396AFA0D1531700BD261C21E710E5F52EE34E2A6
      D297868CF62A00C8F563D3ECE501543E4E104AAF8EA29CBC9408CE4F8258B5DE
      5F43F2FAB8A656CE5416E5FD993059A1349220FB61882E420957AC4D4B902EC1
      BA5BD565411F9F25DA8D02924FE134EA2D25A5C9D0E7EB9ADA7CE7108985A3C1
      FC076C475578CE20FA1D44970770C5756A71D868AA54AD8A1599483F46AD0F06
      1EB45B5CD9AF3C8071F5C97E2D3C402C52AD754B99A4526376EBB0FEF6FDFDFD
      AD926222D532A924CE5D7C23CA031A828E4CDE9791CE8B34FA613A402D590A62
      3E598197821E2EE6A538BC28975AB94C3050070FF1EDFCF90BD32C36B0A478DA
      A44EB9C7D4C7B2D6EE0C0C1F3C21C959078FD3F492D84051E135419F97021FC6
      203A0BCB93F652AECF1FB7A51DF59F087B6594EEEC5B4D4C8C2B9DA9E55CDD61
      690087FB3761B7623C5206181ECA0514468196D8FC4EC85E07F3DC33CAE7F641
      EF316D0861051B672AB8E08E1E14CB9D41C6A90FFEC8624FF1B0AA3F2B44697D
      2AB049054BB629E549E1BEB1C1490AD1E606AC8CCFDACA5A707268998DD2A7C2
      B80543118FC42B48B36F1D90C988E64C944D1462ABF3318D2C754CA355F785B6
      97941A368740FA3E6E946A38FFFD2C6E0E7A86ED6BFD661EAF90D6F2B2777025
      BE8BF01E654489F1E28EC2FE813D0BD548086E585B65096F935C64C5BEB66CE4
      8D9314BD3830153A19BB4EEEB011E06D87B32C87AF3F4FAD57EAFA888CA9C34F
      87736F445F84AE3D5B19E96C1C0D8BFFE439A8EE504151892053FC9C240A3933
      E4CDD19063D686321045F21D7AF5E646346C1A689FDC59F5437A3CD6FF74A866
      2C43356AF33CA2CF2AE714D578397A67FDC0B0BAE04A881CBE45CEB8ECC92C83
      E4E45CE8C470429976E5FA727E0900016BFB5E47D27D59AEAE9258C2A923D701
      36F9649B2CD1DEE0E30086AD556EE02A8BF81A8C02F8BA1492399A78AEC0660A
      060D8695606B8A181D7AD6C50FFDCE8AE48E749F983BF2ADD98A8E29D8B30E2A
      22F9C3E9B90EBDD42613FA7FE579B5C41B1DD3A539139F5653A9CEFDF5C29573
      8ECEDBB34EE7D50F152C2B09A3765EB0668B3C4B67D940E0664B2D6B73432F74
      7E9DAC64EBB390F2F0A45E175B06DBF1C64B9F3D1D3E5455BC0A2E493873B382
      4A0F137AB59C9F9AC9BCC45A13280348FA0C883D940555A0EAA0E7DD3ADD5031
      A875249BB774AC6EBD3BE5B5E279396EF6E6C6A816FC5D955E3ACAAF3C7D9FA8
      4CEBB2B3CD1D1CA8849EA2E5ABDBCD2ADCAA44A8715F318A4F7DFD55396A73F0
      749F3741C89DCF68002BF04179E5F8FED70B2C7AF8B1122B8AAF1A420C6898D5
      105C079C31BB379FE65A2B065EC6704CF0143C439B1CD8D27390D8B25002C8E0
      0DE634C04A91A1A273430C66B520F36B7D8049919AC374732303F6CBCF813E9B
      DCEA68531DD14C7912F3E428BB5205E5039240FB77471AAAE3828523C903D8A6
      81CEC7555F53AE8E9F792894AFB4A1D8BB1146E0C47C630696B58A5113576A48
      918E46D28D43BE19E9BA989080D5F6092C7420C846C29E1E1857C827DA7CAB16
      E8937456462EBE91D8508F18E873B05448F584D4AE8FA22B2ABA8441D3F37C5A
      F988C88D8367D18CAA78A82432634F7CA13DD15B717BE263CD95F841BA126531
      036DE26B039BE339647B77EAB032E7ABD087AB95EFE420DB932899E56534DECE
      9A694E9B1B04A3C35A444FCA3C4FEA4072A5E8DFC7907A3C3426402887681C4D
      FB296264E9DD258DABCF415EA2921CF7818AEC84516138A9542016397CEF7A6E
      29F7627791475B79752BD92677BCDA4D2E383E94C79150CAF1EEEDC393233EBC
      19EA5EC3E529A2766213FBD587EEB40A75DA5E191F8F65E68F8AB7E61CF6E87E
      ABE59EE0568D28134AB9B213718DE13CE4B3D283936BA8F62067A1D5B37C8C7F
      BBA1E04C7D9FCDB9A68C299F030BD1CE5C0DA45A23AED27F7AB7017C3958E5F4
      2E974A099EAEC97C6275F21450685EE9B2D5A82E53A8AA67809CD4C84D1FB8C0
      98EAFFA5121A13EAC23816B1765C9C62D8DF9D15CAE0DE2BD1BC38BE873BBB91
      C74D112E2BDA95844479EE4BAE97C56F0A533285FA82E386D103DDE465A6B7E8
      D87781A5DBCA70FD807A33D59C1586D61BE2776450B309629813BE3907AF0779
      794C8EF457D21D1ED860108EB54551DD0DA10573BD10EA67E7C3A668824A6A34
      4744F0415A457CCE9F5B4B4F1612495ECFE32C3D784AD3223A9E5724028A7BD3
      2992BAAD622D36D650D3FD7843A76C869C9E464E7C545941BAE7A4A8DA297549
      444A88E9089144551D28A39016895FF6E6D281EB0BA65BAD0B7950993175C86D
      28E30B2923B1B6B84E1B9DC203FA7F2B0AA9C64DDD113FF326E6434665353506
      EE95BDAF93944309325D9CA21A3F055FD5CD471E7511E1EAC5EA9954E2CAD55C
      1ADE81D3AB12F5C3C178F5590DC6694AE3B2795C0B689FD14EF1199A7A3D8559
      68BB564759A81A0CD5DC4393B8F970E226EEEC99DC20C34CB4F37D1E3475FA47
      73F1968AED94B15965084D696D69CC573106CB6F53706721DB373B4BAF1F6A08
      F17EF81CC0C4B19E4A7DABB60C3D2EA8E4D1002B0E1B9CC012A3BD52DB2C7BE7
      FE7AF39BA2C2FBCB7AB4F6AD431901C869232187D1173420B9532804C1CA2718
      599DF1F06EAD464EF334C872D4FD3B4A9E510B426A08C9E718FC3B0BAFAA2C0D
      7EDE5D9D225C336AD54BE9641617C98D4E2BD1E741BFBE2EAE0B28C3B5EFAE27
      8E26112B0B65C0E68219E30106E75CE3C9A676465F45C10255EB1E80C4D1A590
      A7D986C3DC4F459F7443072E3CF72BA1E83416BF956714254618CE536A025CE6
      6A11904ACADBD6998EF7990BB5848E9D05CD362A0E2BCADA07FD8212C9D5A921
      B13878C1029202D55AEC5B6F71B06296711B207C9E9A70885CF7E7D09E2B7879
      9805A391620ACCD374430C9900620D30354E7ABC28EA983EC96B215D19BCA7C6
      35942DC4561025925375B2B234D8344B0158938ACF5FC1B22CEAC96C9FC1AFB0
      F5FE7D980FBF2628480FC45464E8CBA754FA7B76940A6E54AA29A90847EC0E4D
      04AFABADA98D9696904AA5C533597E159F149069A48A391A2EF51097527256FE
      CE91FF53A106C391882371F11315A18380A1F08A450528BFAD5DB1C769DE729B
      965F7812EB4BE0911A52784DE9A179717321393945753FC95A6F9C6D42511907
      B1CC37D1C540647519564AD05BA3B279738AA58A86B5A12BE7F5F45ECDC113E5
      A31904B97460548B88F0C3AA66151763C622069C6CA34AA5E81B834C8E2F5971
      84DE52C261190E6B18CB03061695C6E45A0A328CC230146228981D364827130E
      D44FC8E508429D2AAC96057DA49F6D1C48795A96A5903129983650AB9443B8BD
      5DA9C92A6F8CA8D285984C5358F76D59DFED3AE023D459028681A4428CEEC632
      A92157A4E198A831870BECC8C42CAC8AA47418CC61C0EC3801760AE80CC174AA
      4A8A6BFA58329324BC3B22589D013097DD9681DCA471BAB9113043C13259A96A
      BEB1ADAFFE9B7BB371B6F2AEA53F0FE341BE6B1D1EE63BB52064ECECC011A80B
      20FDD2207E1D60FF8BDD3EF67BDA1D608FC5A53756536047BC5775A06A917E8F
      0023074F53BEE724B805AA19C4332CD4A5B666CE956EF8FEE2ADD83AC3C096CF
      0905D3593F4549B1058C641A07039197D6C816F994107BB6A49BC90887B2C0D2
      2218226796A72DD20E3A95E556B6534A12968BDEE1B3600E2992D1E218F83A93
      A3A9627AA099294F9A635B18F15B501E7E1FA50D8C3886B7969A129F55CD9250
      E626FC144CFAB30CABEBBDA7AA13AAFA00C904F926196C86F59960351C1A8551
      4EA58C93772A923A54E1F3549921523159BAF0CB2CC7FA4B545174BEF4CBC221
      7EFD5FBF2958D168D8261193AA4828728AA5D3929527722906E1737442025B00
      344053084383F99C0EA792A4E9BF857E58C3CD3085475899784AC84E4B994D93
      5982AB0113A09119182620DDEF5B7310DB7E03F4BAA3C0B425697F3EF77D3BAC
      78D58B6C2674E47E63B16CA923AA628A326160D2BC53DB2A229EEB6462968B2A
      90881955384D430D8F8B5D0478D5BC7706FB09FB6B45DA177939C9CD4A08FCFF
      B3F7AECD6D2349D6F07745E83F60B84F3CA6B6695A17EAE6D9D90D5992BBB5AD
      8B5792EDD9B7DDF1040882244620C001405D7A77FFFB9B2733AB50A028DB1ABB
      65A31713D3B62C82002AAB2A2BAFE7F84528A9E02879CE26063762A442897B04
      445CB099A829976B47F54AC77B4DA662A1BCC6BCC2A3301E28D226B064E4A6E5
      BD047A8F31B86913813DDC01A2BF70123D8BDE436E2E21A3183DDADE204BA702
      EE817393214DA7296309D3F9A6DDB6ED90933C1C6091F7767969C6B311C09FDB
      364ACBBD7C028EEA8F92A8A0F1AE204D3470206A9BFDF8C07E14DD662A4A21ED
      662BDA6CCC02E990C9C9804B303B17EDD62AB815C7933389506027ACE8FE054C
      7CEE09A30B1D2191C0CB7044A49F85FE95C2FE0934762E7D6FAF2589E0D368CD
      C390F46956F8278271006C5628D26669AB8D051D0A1529116044C90CACB50139
      1781B939AE601C858EC7D212C1CE0145EF1B84F1E3949674DE72F38EC27E847A
      8A8F7E35176E3271D60655CCF15F82C25C8607E4BF9A6FEB8747039C24811F5F
      A6271C5F7A4FC230DFE878E5B7F17BF7DF7237B7E278A3FA9A5CAFC9F9D5A840
      2AD1CD021A9F8E5B8506264572FF065EDBE600C54144C066C5C92876B5A348F2
      A895F469E122A6DB2F743C25C4E06029C77FE61EC13EB0A95B2C5C245E6DCCD7
      1027666279C93ABD580F51151A119D3B3229EE77482504E924B4A03D493AA834
      2155E1A9DC171093437C4B90A3D800ABDE8327DEE934BA21971EF0526AD29440
      1FD5FC69094F6F2E10A0741D0AA31C677E99C1B1BB802E5D5E32C39A66291845
      BA5ED81D752569E320BFEB45DC7411877EC25C0351F14C602192105F45BC19F5
      3BBC04780043BBDE19A15C984574F6424EDDCE210BF2BDCB1DC7F111FB70D4DF
      C824751EAA59C135AD21204DE2E837E4EDDB4A096F37A508D6BF5B31B0EEF440
      887B794962EF3A15E6B8B133673027539405D3C62AA7DAC216CAA84024E12E97
      1BDF796DD30F5A72079A7546370938FD442A741614B30CA8F01ABD6973218EE2
      E72369EF203AFA1AAD2FC126F5B9593821AD96CFAF6B5F668C217939C2931769
      8AB39D5602A36ACFA0C54CD58F77595223A0C77796330AA66F0346A646337140
      3116CD4B78CBEDE3623933EE272726DCA9651FB532F32DF724E3B5B7AF6B8F23
      64E12D203C2056076E58A269A20A59DCC7211D2D2D117DEB3F66305C2E5CE52B
      B51DA2352A894E539EE6AAC8D6AB3BEF959F87E73C012D85CAE430723FBD35B3
      A96525A623D229E892D4B2F0F848E109F0C9ED15EDBF78EC50086887B77F787C
      0CAB0B1C1B43E882C05CBA32B743E6DEA34418ED783F74BCE732FA7FF6AEC2BB
      7C9EF94253B1243869A4DE8BE356C7FEEB9436A911DE51720D9BCD96B5B72A84
      42824B5E6E34AB95752BE9D967E298A621CCEC080327EDEC2B3D0E0504C54045
      6BED3B3D0ACB50FBCE7D171BD54E826D2AE7C67FBE5023A57968EF6E9E3BD718
      CED9E2B2196D5AC93E3786E743813F3299B44A4B1A7B9B507FE95CB90D2B7697
      987EE48F5312E5210C305392D10FD9FE40B2D1DCD08F9DDA3655CB16D90B5553
      B3281EF019736F7E2CF90E7294969C48DC3D7EA59298C000DCE5020E3DE0AAD2
      96BD6B8BAB370CB31829B23B643B6DE507297B1AEC5872A1B62ECDD477B9C429
      6225B9193C2DF9CB533981A5528E663AB822958FC30383B2519558AACF484812
      A824FD81C3559FE91773C43B67A25717C9C6CE130B90EBDDD044EE48D6399CEC
      2D5ECC92F27646B7970391CCC67D5BDB29D193F4469A713DC588BC6FE57AE24A
      E6452FAA7C8B39AF1D6E691AC2B52E668903E0ADF347BB88B94999814960B8A5
      5AD8F7C02E86B548C6E028636B10B592B6DF021F4B7121BD008EAF5C16ECC5C5
      61A31B3F2F0CDC52D30454CFE4F7A1DA94599F7F626CF2A630D8E21F49EAB8A4
      0A431982582CA446100E354C67AE401D63C388B4EBBD522A324340C5B671CA99
      9093BD8B4B52797DE661927D6A2B6F1CD35CFB08F8CE1C9D7D862D031E441777
      0D867847CD5B36266294E670CD2A909BD2CC36F0CE12B287B55D083B9035024C
      CE50AC7FC0D2D1481226B659E12D360DD3A9C1B118A496E7D1A7EF845363C9D3
      BD9CEDCE8A0FCE33B6AD14C459DAF56AD98E1C3D34E0E525359D6C86D99AFFF0
      E0B4C0CBF825343457F806785FB49652CA91D081C2219745D275A850A8AD3DFA
      4C6E907F9CE8E0630DA18B1ECAF31BCE3F9751D3F2591901081DDE3835D69797
      721EA935B82D6CBEB955E2FD7D46D364589EED60D835F9BCE1588F22AD547BD9
      156D508EDC85CD6C271D9D29068C3326EEB72C52E5E220794F7E4DBCDDD3D7AA
      4649C9F746B3F5D44238FA99A6E23D6DCCA3C9414AF3F7E402E87A6FD0921D8A
      DB292B92D484AD3454A6BB50EB7795E75DA91F12667EB02EE920F5AEB0B26E70
      873BE5761F6058CD09FFF159389A80AB5313E7A2F9384A96A7995073728C5703
      18AA4E1A7C0139EFDDA3806D612C415AC8DAFA6B29E19C9E7AD8BE36327F4132
      2E75EFC208BC7B89D7E6E300E8FFF7FD8F95963D2C985ECE28726ECEC3FC5914
      D5799DBFF0B9956B10E139D7C38903701C85D10F3FFFC1C098DF7002F21ABCD0
      C6183A1E6860C33204068DC0BFE33E49A986E473538D1CA6B2298F427AD2B5CD
      046AD82A09430D68F74BC302CA861104C88C819B2AC5228E7522A5F4D7113B3C
      D201A5719715FD6D8CB24C663466563F29446934CDC7F78B651B9060A763EC72
      8143D35E58696C7E4848A6386AAE59D90DACB22D6F63D3927538BC38E9D01FC7
      A2CF8FD3C0E75483C209736F2E071DA518240EAB09858F409A34AB7DF13CBEE1
      40D27938F47E7973FC9FE72F57F97F6BBD5FA1324C5AA6E45EF8F05F08307DF8
      9F6E78DB5418AA376D25D8569A0923C315132CF4174812EBD595A6450C76BA4E
      2477EAF0E228B32929277A8D41900E0CA580736AAC9429159758D90DAB1599AF
      1C64E7C6131B80087C3E70C93BB41ACE6BF6D1E275F093998FEEC037C89D7A7C
      37FBC416403DB1F3589994276E5F92DC7FE8E6DC8C39C7155AD21253C1A4D06C
      9D8097426F84937E381854E360A42AAAD90877635B56425C490FF34DE4A5CC14
      42D5A0F92CF603C91B3CF19C7CF8AF1F49E79D8ADE2B27C8101A7DF64C7DD518
      473F5C24DF46D72D16D765346D94DB7DE5C662D1728D42923CFE4422888B9540
      C1CE28B2E07E10A4B3A48CFD4EFC01EFE74A8AD03EA3742635DCA40B5703D26C
      17E38BB8B85BDC0A8FD5029DD2ACF7CF452113C48D7D4B6590268B7C8D662FF0
      5E50C68887B18F94B58DA56A82F789D4EE4BEE007893C28C657E67EB5DB41E70
      8E5BA2EB1940047A70F5EEC31451741C756228EB0D37B2813EA259FD1F9FD05F
      DE85D9DDAFDE82E2AE26BEFA295893EA02B429034B51FAD4C994BF6312714405
      660A9FDE2A7EAE35670EAB89458E4D4BD680CE5CC120879011D6654C7F7CC553
      F6002E9F5B58021E9425E05CF2A7CE7347C3B71DCE687ED61CB0B5F9B56601BD
      4FDFC74C986A702E2F956AA8FB52CF4D1FA3D08BE70E641E8A59E2D9881EC576
      86292B72F1FA2A6C4A4E21615B6B95A3A1B77F797E0C4F661CC6832AA0CD4AA3
      9B3F3A89A2947F0102C0AF52BEDBA8E43AAA644E5C7E3B555C627D928EA4BFE2
      D0D2D6385B187AD6E6B735C3CA6E8555D8738D0CCB4B928DBD07EDA955F3B6C9
      E31E977912DF6959F4DB44A8CCF95F0752345E462DB5B7A7A559BF96EDD729AB
      675A253E1EDED594B53FF4ECEE37380F78094042DF6C192C3807B8EC46CED38E
      F7F6E0BC6352AB4797272D92DADF675C31CF01E2A904A837B8A8369F3FB9B52F
      DE9605C99A43A1257A9FA4F652667B1849DEB3F5EAECE2E2C5F1D9D9A5ED49A0
      A7A372B6D29A602C77D182920A9676832A90EC2C4BE05C0CBDD6051A83B07E74
      4520531D26B66A895B8A51FC63916D6D708D466D90CC8274942029B5224D9521
      792EAD230F652A1EEA54BCA367138F4B55B4F9010F31755EA6179A2C8F0CC35A
      29EB7FD11A02594A7DB0A05589A1644470E0DF24A319DC1D800431BCBE759AF2
      740622EC284B5090160F984C53D8946CE659F94A71F948493035039700C3847E
      CA6752DDF20C258159E80FEEDC1AEA8DEE7A774D393B6D91AA8B5F7B898ADD5B
      93D8A39B754A2C2C8807C968D63228882E8DB789DBC7E164AA4D4B9901568065
      2085BEF7CF3D1D0C5D1F485D431E96400B26B13E88AEA3C1CC2C4A86D87420BE
      A4690C68A65C26A67BA07F5798E6B16ACF1C2DE56AA6457B9DFCA2F292B22C6D
      DB04496E300BB8B4301AB216131E02468F29AB98311D133F41669F8EA73119BB
      6D34F9444154A8FEBC539C325386E07CECA085D2C655BD6DF66E0329F129029F
      CC1F3D4B9E1D00588096C5CD38ADE4ED1A9889FB27C8D102640953CE3FDF2CF1
      60D8A7226894C8BA00BF63A92D68BB9E85E4FF4991AD18160F1333E2906AC27D
      0CCD6AFFF8E49D804D190E5B56D099CA5651EBDF679329E9F2D642C4909A2CF9
      DFD76A9720A7F78360353C353062BA08C8457788EA7E940A94F368D8AD9A54FE
      E7C8F7D4BFA6433727EBD4A939ADC9B2FFBD35FDEB146DFD9787179B2F2E2E0E
      05F5E7ACD741B798CF7E633818193254FC080C92ABDC269F9CCE367220C8B831
      749D64640268DD04F6D91FB1F75473DC456DB7C9AE4427AB03482183D5573E1A
      2410DCCC35086FCBA612C1DA022DAAB1C1BA5EFBDC3479DDF312C47C841B8196
      D6E1707989B6D08AB72781B1FD9FB9C88D4F29BF1F717B583E9E0D87319BBA64
      E69A265CD4BF9AD36E0E887DEE85753437522607EC41A015C096975272B749A4
      F2F5DCB4C8080C02392A43F282B8BD2C4AD04B2F0D1589E3E29CEEBD3B11F786
      754419391990DB0D948B11EA8FB8B69D2C5773F82E2F99C0259A3E867036401E
      240803B0E06DFB0B96CCFD0513300940944BDB1D5A9FA340C5A1D39E1BEB014D
      DC03ABF4E84A9ACA202569921D5EF077AC0DEF5C2103342F717EBF39AF4CC9EA
      3E97A27DEEF3A13D2E658795EE4D5ED566C195FD3D8B9B42250BC6503EF4EA97
      D5B5CC0365C1B7FB64A694CD44C5FC75B4B2184D80FE76F6932326D9712B78E4
      DFA0EF6D879585C7D0EB9CDE9A8E070D230C243C2845C56A4E864F144B9A9CFE
      785630E698061879FAB2D9B4A98730E78416F88626DA8F8DA46EBC05E289748F
      2B791FBE01C0EC12878085DD717E89EE3CB99FC06797947E0E3E29C82E5828E8
      5B4B38CB639C6F3B4F9A3D96FB5ACE3F7D5EA500732C2FCD5B05579DFD8CE858
      31DF659ECFC3AA2442484D574D19046F3063D82E03389E94F521BA963A1F7927
      48C959630BA21670A6A264D634127D1A54D9D0CF14297A619AFDEA7205B99229
      5B64B07568D30EB05F5D0C70EF27321B0E7353F7ACBF648ECEA303FA70041C81
      CBB16DD001401D8C9E15DA3745511ECE4745B9453332B76D3B70EC730B3CC32B
      B7D922F2838CCE582FC7D64F932696F5C9C5CEB5E360272E7C6FCA3D591C646C
      96BED3C7D272C4C30906DF24A2B47A5654B682E1570087D88834271AADEA1B46
      C1BA49CBD67AD2D11A8A321926D76C24439F3C106E8041CA4BEE8FEFB239DD3A
      098171CA25829ACDEA020F089DA3D20236FF243757E7849ACBF129497C1969D6
      672C2FB94F317865424891D9309CBB8E2C7C8FD46BE96B98934BDFC38021A3D7
      5DCFE7757AB585175B640EC33B5F797185C7A0F32E8AFD4C3ADD950FCBD55A5D
      25E675118D104C779E688524582A46EE1FDD2BA532F4F3AB5C71649290BCB2F9
      B1B07BEACC82D4C04D6CE199389306D6CC79D8BC36E479E27E455F82A6A64DBF
      F2543B0B5CED2DBAB2E34CAF43D7C8393E7AA32E4D07FB138017E49BB4FFE21D
      B292BD20F50A82B4B74A5DEC27CE55BCE0C993EBFD18065728612F64810D0C01
      BA190969F84A6684DE3E5283CF199AADF471DF968527090F7AC3FB73CBE001EC
      CA59AE165D5673933C97B706D244A42D67685B33571A2A667D459DB084FBCD46
      CB4BD2752319E841E5F1066C22B219E7F6DC3032532E4387A4FAD238B24A2D31
      96FD5B9EA8F22A92AA199429A7056B84C5CA9DA4F9BD7DC987F063B4D5F8BE1E
      B9BF29C5C9C5DD261301A5E43BDE530AB9227C41921A4A10121CCD659ABD5D96
      351F5B2F74DE00718F7F473A6C1FA02BF66316C159129603A1DB44E0EC21D7BE
      90C6675603732F2EA88C66D54802B6A2B9E5AB48508A39633D00ADE9B628D640
      79220D6ED53419447B2C11FAE195A4BA7DE1362EDEE0E97BAFBA72CD8896A929
      10C755B8C30D5E9AB19046C853232F899A29F7DB025901D8B9EA8BA846AB8ED4
      9D776C1ADE1ECE9610C2F63D3D2848777301BBCC25F32CD1A67DA9971CE0BEF2
      121D1D5C7558F74224A19F4748513A919211145896CE46E3CA8AA5EDEADCDE82
      E5CB899C7F6C855700EE543D18A9CE8DD2E4F043A68F7DDEBF7B6E1B4158A108
      8038DDC38A446435F77BD45D89AA2F3F999BDFF708E331CF94162263F5CCEF45
      BB502A8265ADA50DDE4AEE8BDC188262B8212B0A5754883E2D9A858F9F708C9D
      885E7517BE7096B12F0B2622433D9369CB826A247CD2567A2B5A9B2C3E5D2CF3
      3B7EC5338407254622838A4CCD56B5D975DCB6A2EC50F651A2B8D35787B31852
      06431D6FDDACC48C65F55BB995065159B790AA63A01EFAB9322C755FCAB47C89
      005018B80E63316008CF0A0103494721271AD140C9F3C9F46CFC2273F767B959
      A9E512F97685A10A55A2DF8C74AA372F4BD7AA12F2DA27FE5DA50B44C4AD868E
      6A2FD5702E8D8DAD3A75D5411E3AA3D793DCB300056AB968A47ED06D6A333F81
      1BA366162D54D49B58E43F0722AA34AE1A5F8C7D31969901BEB512F3F3396939
      505BF0A068F593760CE598C4BE50699ABBF9F35FB7A60BA32586D8B2A8950A73
      6C6A5BE0D55175655BA8F35924E924833E904B5CB062FA7A0EE8326E67554669
      EF5A9B9DABB09A6DF4D145F18AA3AD9CE9025382F753184F3BDE69783BCBE9B4
      A4E9FF312A7E9AF53B280E8521D08176A7832F0B1164F5476193BA95BD6504F9
      108CFA5CD8DC5ACF28CEBB8992417A63E6C0944AFFD707602203788D45FB8141
      A855BEDEFCE8E6C6F5B5BA89E394EEE9D3ED067DFE61F503F62CDDDFFBF0ACBF
      FD81F6EBFF2C98F861F47C630BB3B3BDFE881540C3FE5BC043A60D50DCE2BB9F
      B126628C73D1C2C0F7BF87A5811DE53D278F89F942C6F817145CA5F7B426530D
      4658550C342204B5CB7F43179403239B9DA744A317006463EB7CA4E19BD06171
      B508ADD92CE158A09FD74E2EA2254928EC87B0310BCB731869882A462ABDA0A3
      8C8E8674CA2C358EAB64445626A3A55059AA7CEB260D3D297485C83C9BDFE561
      760D63FE3CF4E3E76C8307CC69B0BCC46115B6A7E51B02E50F674D85067435EF
      10CD5DA8458C5856C092AE9974CCD9F9DC3B8C279C69CCF6DE3ECB2B67AAA320
      BCFF4C67991A6BCB4B85E045938B302B184636CF958BABACB44F9351CAC5CB33
      00B056969C596A8D51F4F17994F8AC10137C2351AD7F1551AD6F3F24AAF5EDAF
      232A517C8D0DE8B4C5092C61A547C6801B1AB28B85098EA42A4CCB7FE316C795
      918AD601431596F7D3234822710620CE65B9308154D621D77E144B29DC1C91AE
      8904CFF3E8EAEDB53A23D526D26FA549EAB23DAC7DD4EC90AFB243E6E5F9D84D
      52DAABBFD73E299FF0C056391A96B62F1280C8B290219096E36C338B55AFBBDA
      BDEDD05FEBF8ABDBEDAE480A45BE699A6E4D5056B2C46C51B52532CC616D8980
      2BD3F6CC39D6B44C4A77351740454A3F61B8830417754EB816135CB9709A1A91
      4F1535AA5D978593881789BB8A1AADA03522F35CEE96FB684C2F1C73DC048BCE
      0853B696B3A3B89550F61B563DEA82B15A656FF04D354F6A55C32FB7BFCAAE88
      6C795451EE6746AC5725C4745F15222DB4A0724432C3FECE801A9C661693758E
      A34AB753F926915361328D515FCCFBCA8C0DF73345C674634EABB99A0FF7246D
      39F113F19AE7EF6FDE5461D54D4F8009F862E38BFE713C83AEF75ABC055111B9
      53BF70AD7C8620E44618D7BE5A380D135B37CE5B920B26E529657A9D9C7DAE14
      41667B463AE6AE51189F82C3E22E3B1A27AD54844A1ADBA12CA2BC2F1CAF2D67
      1CEF81EBC89FE3DE58D0CBB5E2C46891E11D9340CAA43EE0C9E529B9612921C5
      1D4D66137D2A2DF2B11F6B35927633E84715E4163D20ED7D8D256159DBB46BA7
      09F73E32DCBB78237F2FE1DE0BB3249EF3520AD27879891793215B5143EBB3D6
      4E75BDEBC16223AB9690958B3584C2904D442508E2328232E52C951CF55A6DCB
      4BAF23A675D468621115B16D446EBB50762B25E54255B2A6EC73A295A602DD80
      8287BFCF8CBD4B6BA9CFB025FE24550005B9ABE505E207E6D16FE102B815331F
      DA1DA7D91CAEE7C2376A267208FC120A54246E955E61E5903F2083E52545DE1C
      464247CB7AB88CEF5B1A5A926440CA38A908971F245AD1D668559E21D0555C42
      E93462D444AAB2902F2628F67A8EFAA13EDAEB34FE6F45CEFD7BB2E0BB8F95FE
      A365BFBC74646A660B106D994739AB9F198F43852823651DB2E3EBBC520947C0
      B6F4FC57A78656F8E15D8BF99E66299BA6A9E0D3E4E36C965C7979AA5582CE4D
      313A07ADF963AFF4E9C545EBF593CBABB1521FC86A620A92D4563A0948CA645A
      D04194DE3426ABD3F7F30951CDFB8D61C2D19717360C536111BD472B57316DAB
      4D72DCF7D098978F342F178796BF17F3929536575732A4115CF292D956082D68
      E1307F2D20E3D01E426BCCB48E196859B6A8C84C2A665CABFD2A4CA251527E9A
      A2C1039157E8CB7134188449ED8EDBA3A198C51672EF413199DA67E1BD1C63B7
      1AB9AD749C8DCAD290EF8A4C4CA3681D65637A012E2CD379C914F499ABE684F6
      5104240784895DFDF691E5D31CA78BE74D1C3E0E1786B428C54861546D06F4AE
      9826B69CBFC1487F38A08C36023D575B075591BEB3225D049E5E22E91A1090FE
      1D078B277918B4E609B7BC03659A15BDB0B95AA9AA575842319FF9B11C161D72
      783A13D03D94CE022F79C1FC4A6FDBFD5794FC10BDD6388D6D171E99FA396DBC
      D95402D237897715DEAD08192E0DDFF2774B0E488D07792753D76F2310E405CF
      A45C040925DB771316DA698075BA6A02CF323A4B13CC153BA9831B5265AEE501
      4496DF821F8ECA30DBF92562E006289642A3393E974F6F2FC621EEE34F8E33D2
      75B4EC0D4A63D38FBC48357C42660F6D774106CA66E10283BBE3CD925C2BEB71
      B75CF72B9DA242F39BAFD8E4313FD88D3DD33FB9528B8BF40B43BFFA27F3B964
      8C6F7D0028752C1E3837AE4C15E7D5EC233EBBD72D65514E47728A9C98426D44
      2522F3C30BA29CF4E276776D8BFE5CDBD958A7BFD6B77B3BF4D7C6D6568FFEEA
      6DEEACD25F9BBD5D5CB2D55BC325DB1BEBB86467BDD7936FE3125A59DB7C9BD5
      DD5D5CB4B6B6BB8AABD6D6E93AFCBDB1DDE3EB7A5B9B5BBFEB4AA3C1FFDE2876
      7B9EF78AFEAF62A61FF73D6FCFB40E36BB9177A3589876D99B1D1439901558B7
      CDAA7DBA555BAE5767F5CAFFECEAF59A05EC20F6899AE7106894091040DBA025
      B991CFBF78D5D0272F71CE313E312A7E5BCEA795A767824B9F9C01A0AD67EC37
      18AC34006956482C0B94B6886DC0D07795D3BFB17017CBF175C97AC0FECA65E3
      EBBA1AE82C295DB9C2EF778465E07E76260B4BBEDCBEAF3DCF8A709E566B158E
      8050EF6208E865E44C9E2ACCC90BCC067AE6DDC228BDACCC495F85E1D4708A21
      95A3F0025AB1888BD50594BEFE4A0B8C685304A9E041FB826BC29442DA5297A5
      A94BDE27E3434CD4C652F8F1EC1C939B3DA01B753C0C892CEA5C6022E4EECF72
      FB6BF8BCF2BE13F49B3A58D80EA0D665AAB1017AF56096973565E4710B81DD2C
      6FE2EE8F8DBB6F7CD7717770DF9D4269FF1BAF57B31374C58373A25EF3BD57C4
      3FBC3343E18D5CDFB11C26CA4A0684D697766E9EFFAB5154F4931D25FDFC6E01
      E07A4D86BA2F51BE83F4267929C14433DA076612625934DEC6D8583C094706AC
      38C03124FA9DC119150BAB22CBCF7046FF57982082097702B3E3EDF40516A7D7
      468E7AC57BA140CDB26CED87E6A05C91D3554F51AEF3C8B4BE382FE8A4B727AB
      6076695CCE86CBF8B17B8341F9B427762E8E923CCCBE01F5F9C302EC87CC3D5E
      227A8B136224B7B861C6E9983181D1D77CCB24BCE1F222E716B9D9052DAF3D98
      8B86AE48CDCD44099534C97056296F881246101FB8F98B27E7040325E253D34A
      48AA478A39B0663F73B17ECD617F93E55ADDAD03F0FE7C6ACDE2A2E9FDFDDE9C
      591FED18C8D1AE81F82992F75EECF7C338BF77643527962DCC72A4D42E5BE84C
      702E72DDEA0AB3B68CABCA9B60CA0C0580CD565D1AE60A5EEC1F015CCBB0E07C
      A1810B9CDAD0F9F078E2A8617956713755084E1881D29493DBB60743C99DA7B0
      10195DA1D9539FB7A7C4C107D5713ACB0281640018BC92C029A2A9414754FCF9
      D62F076138FD5528ED69EE4DF6ED05728EC0A56A80A1ED16E494A9C3A5E7DF93
      5EBB223E11F58A1523B092B2128C8FACA239EC5824506DBB9A469EA4BDC26738
      26E95963A2444DD1FADEFEE1F1B12930F6BDF7E7C7071CA8F5CE0F5F9F97BFC7
      552B86802D0492B39FDD55225CCC35A98C8B084CDD5B38AC6C6CAB5E46EA25A5
      E3D00589B5302803D355204695CA44ADAB7CD1CD1DB24759BD962C061E234280
      48153BBDD8A656C3F4A8A0EB127835F661A67CDCA05981C9B310DCB7B6558451
      61B05BF315A63B9D7B7AA36B16EF0507865CC4D7680839A453DB4EDA9ACCCBA8
      C40CA7F3B1B8F3DA50D002066A6B9D04E6DDB4D5636B6629C39AEEFFBCC248A5
      D02B250E6985B2488EC970F0943E7E1D176FEB28F91BA958E638CADD096A8E3A
      BB903F2A23AF6D41268CD1395FE7AF089B484C984B16D4056A42595313B84888
      434C4FCFA93D442D2F1ADFB648ADFE67FFFC6F5210CC972E2FD1C5EDBFD873C0
      7CDF941EF906ACBB6470B5F715D46046E125239BFBEA828079C5B835515F6E9A
      85C3E8B604169FDA36A0683E0B55D0212BCC0B21E3884974A18FF7A51BB10D8F
      339F8998850D4EEC619FF176B3C20424E4C92BC66893DE76634C54AC742E64C4
      3D85178E5EEA2E2C4A8ED5529A7A2E8A3084E19B91514BEB40BC0BFAD8022FBF
      178EEA97923A3304083C87A767979E823EFBC95D49C727A8A86C684C144CB24C
      A8A940E55F515612B836C4639FD2616A78067366BBD716B47FFAA7F256AF3456
      FC9C6ABB2FA256499FE816061B7E0D06EC7D58E4D6BC373BC22CDE53874EC42F
      E6360CF6A87987508A2495BFC22D87B4E8DF95ADA2D6EC1C9AC8C2815DFBA0FB
      E3BD0DC3DC743DDE7F5CE5CECACA41133862807A344A44D944B4B732AE71E57F
      C002183ABA45918EA198CD9B14A66F56BFC9A0F2A3C8705504E33412B6C8D67F
      86B9A1586CB1E26C9DA6F61773C3552FB76C92618A8E0A418719EDC2F777315B
      3E31107552DA8E68ABC2E2A613FDDAFDD75831B02E1F9779F93C65FCA8C621E5
      98639CC4F943B9C3F47715C7146BF551DA4172735CB450F1349797A61526A18E
      1224C4FA32A9F06A389E949642E8B0740ECA2F0033B85CF7F4BC39A90884A6D2
      EC95F7C98D5160AEBA2F672337E99F7FA746F4BE1AD1E2F4554D70BAE5FECF78
      2331D67D6F1ACF4651E2CA16C4A6DAE63899C52E994673363D703671A7961A8F
      6081C3063EBC386E0E2013C985B2328741C160F2F3D62EEF536B28FEABF77F5E
      BF7E2D3431A44D275349609576F344903386645797DFFA97BFF0D7BA96406A48
      467B95F5A148B1CCC95E4BEE5BDA55BA9FC6F4FB6EB6D779A85CCD767F91E66E
      0CBCEAFE9A6A801290C3E67CB1CB36A7EF3083435EC64D9CF4C5C79D5F364B1E
      5271DF6EBBA0D375C3090D09E1F7988B275128C4C727530BDA702BF381FB4051
      43CBD0102DDA8E112196902CB5065EE2D3B0C26142FE78CC2CE178AB49C8B610
      16C6D9E9DE892DC9A9C926FD7DAB5096979EBF8E6EDFC042A37D9504E11367F8
      5F3C71D5CDF3D3B43ADEE5A5271E31B4D6530F5ACAE0B1FAAB4FE69EA03FE004
      2F1EAD33561AF8EF53A9E3281CC5E8F346A28F500CE5046B2D4D381704E03899
      08C3AB02C833DFE5E4F0E2241A36B0979F2E6289FDA9C47A4FB902DF96AEF80D
      BEBCA8792B17B7E143F9C319A9F297E7BF7AF9DDA49FC69A8DAE42D106226371
      722C8BA50A1ED1878C0CA829AD5A097B28708AA41D00399D6625E3A3AD43613F
      6A3A8DA3505923054F809E5E82D3B0D734F1EF345885D4719A8D52C4B22C12C3
      F2122734F0643479580059B5AEF09820655BAAEF0757CCA89275BDB6C4E9B5EE
      45434EFA6E1E073AE0C671BB5592168673CCA993096F7D2E10900FCC370D3C37
      B76F4545D9074E7E9C6024C80D2D4D1F5733987A46936994923F462336362066
      08C8C2599A1465487410764C1951BCBCC45364E6426888E7A5CF653FB492194C
      324D5C5D848F0F7518EEDCC0A72523F6D0CC1B5FEA17CE5D105684BD1CFA496E
      5B70519CA7F9964115350333A1EC86F320934E2711DEDD4DE208B1B619825991
      0E37B0AC402F5A5EA275781D0D6664CD9BC5C6EC63D53BC8E5EE0DEC2A8FEEDF
      A02B1355AE72BA5F506E005FEED9766A53752E15425DE1250541C3E7CA897BCF
      B092E57B090C64C885F8DC5354BD8719871518430D44A68389D6CEF292456BD7
      05D4D116259752B414A4DDC452633B48677D77119A12CB308FB09E5004C74567
      5CBFB62A5934B76B952B39247B972F440DD2F418EA0E1548C98F335A8B7702C8
      E93EDF5BD415CB893D098D2BDC015EDB96AFE5CC9D2E02A5976DF0E63FCD3851
      68D4CA131FF73594D04F34234D618953FDD9AA0AAA6575A689119452337D9325
      625804A2C4DB0AF8079A6D041D87E10BF4E4D58DFF6FAC7D2B989DF844DA73DC
      82ABCAC4E18313A133FDC15B6BD6FDA7BA84CBF94A1C90A7B2742257ADD5EC02
      BB0BAC1169E13638C835BF016ECCD95766B39C8A94DC4AF623D529DA7A62D95E
      5D9B40309F2AB85712BF1342F4F4CA503757DE494B504C6E2B359643E80763E7
      F5707F7E3D7B87E525730F5CD01C289FD91137243B9A4D6FAD9B61A3C0D6CD34
      90AFB2AB0E160A075C3A91189459C8A672C0267E86C5AAD104848A7D41719206
      4EBA5A897F38838442A211588E47E56E55BFAF9517F8CD2FF681BF7270DD7CC5
      025124A97601984FAC5F43771D692FFEDA2A6D982085FD9D1BABDA939733162B
      AD881159B5B9FBD666EF2BFC79E04BDB977D824165474C77BE1582914C85B650
      D370DCD2900AF8F3BC2CE14896B59A64A06B47999EA5C8BEE577E40F4D50AD55
      DBEDFD403358BF0CB37D95EDFD1C6F8E92B9F938DB432AE6AB2B18A686614D0F
      825C1B7C6BF4893DA59F3AFCFAD092F8FD1B5BEDEC97655DD6205153F8C20274
      9A02285A3A1C80E5C24F280CE5AE17A711FEAAFAA795FA53294EC9BBC56DC1E1
      29F6A4F3AB689A9BA7FDC8AD21E5F3389A5231E2F1442937205F351AD82F3569
      F74FE5F768968FA3E4CA7BE1BD3EEBA11105FF6AB6BC42543A3231455438995F
      F72E0E8D331A25413C1B9447E991069D4CCD55CE8B934D72145B9FF5A4D44CEF
      EC52086A811917463281A0FE025CDD9DB9C2C9B2B65A2BD1A27B013EDE6B886E
      D939FE38807DEB8D5F8C5B0C49A4563E9C0CFDD0F428C1A4B025E2B09DCC5306
      1DD835BE63552D7047C081964A79BD0CEA411A4AA778DEBA4670204807C9187C
      13E2AC9830B626A1C2672EF8E3365FC43388794075B81425F48D6D5618C30CEF
      5796E733299BAD49F826E7005E88F6C6D5B73C0BE6515811559E4854FBBB3E1A
      BF2E9A9C617BAAAED8FBDB8D16CFB9DD0DE04833FB8AF9FA645FBD223F0EF5A8
      F49B63A889AC39B03EAB20C564A3DCD48BF8C765326C18DD369C7DF6288B516F
      EC698D1D4A9B178ACBF1E726FEC0F699DE93B62D68379D81A43B476EE1D65122
      259881AF6C60A0C0D476042D0907D5E88D5BD2364BF09C51C2D5464797279C2B
      E39C8A01A3713E474FED2C18E30C2E1533970744019D6B7856944F4A95654AE2
      2C39963C3E57307592884EAF4977A8EEBF3FF48E6544E29E2AC306772FAA7C63
      7A1234A03D9F8E5225BA008680DE95448A060786652F9106B491CBBEAA26BFFA
      77E00AD518F76AD92D958539AEE24E6B318CE9CFE5A559F85912B327A248AA45
      92986520226D2D108A8E83610D7179EEBD3BD93BF0DE648817149C931ECAC85B
      1745360B8A16C22EAD3D46E3A48FCC2F393B2E158293106BD5F51E980CF6B3EE
      D301003F5E3DEB474586BE2F59F9022C1872E5241D6DACFA90B62EBBC18E0A63
      D9558C29801B61442BDE45904553DD33CEF0DCA0E9DB23AFDD273B02F8329CCE
      04167FE68F9E25CF00A9627367F3C5FC47C930B5490E12F140234198633148B8
      4B61CC24284F7EE6DED1FF9E4F26CF49146FF3307BE9DDD20B0FC2DB97DEDDFF
      0600DBD334F9BC82BEAF3ACE76245B7CB549B87E42546FD9BB8143916647078C
      961AFB2339477C2E782625CA3D328D4D20045689777978B1F9E2829C5975495F
      BC3EDBDEF20E0F8E2E8D1A72FA91709497E0461DD32066E986A6599466DA7F14
      4CCFB43BABF4CF6C498B944499DE44B130F8E638CE1276FE3232A74DF0A91FCE
      9DFBBE7EB9EBBD42EB7351759BA582C7AE03895F81DA444C0961E196834DA3F6
      9CF4CDCA8148628D79BD5AB6C9CCA4B9CC55B6287EAFF4D2C9B21F21765A64A1
      4F2784790744A66E404061844853538A91C7621D7323867921700C9E0BDDCBA7
      0927A3F8B1F352906F31E78B38D949CAF17B0074E2ED2A255D1CF8A78DD2A898
      CFC86D4BE559A05D97E4F1BD6079A301839653A35B2C1CBF582CA5D12AD160C9
      083F20C4E8BE51133DF4B6D1D77B5FDA5C4F7FB297C5A062FC3970096DE86549
      BAA3BA72C58D9395FBB802BF50B6037D7A8D36DBFC1318D362B5A38D1630546D
      4CC4F9196C7F9A2E60514908B70C75B6014BD5F1F6F67F3A974471C73BDE3BA5
      CBDEFC78AE179FEEBD3BC1D7F98ED7916FFD84949153DB2B4EEC9239E6E063AC
      34DAC4582A22AE8E01FB5AE09E55E70A52A45DD4B373E644BF15FA005F4200BC
      7486359165AC0EDB482F8C6CDC8C2EAD2ECCAD8896D5947DCB1FBCDB8E77E702
      F0577AE30A0B6A98877E86A218E6672BF7ACBC3AFADA23A9EFACA030886120D1
      6CD9DEA8203080262BBCBC38C42D8505D5BB6A7462C82146095B0AF15612B23D
      045BC0495E58E972166E5EC40B17B569B0358BBBEA085BC4331A32BE2E6E33DD
      C16B737D106D32056BE4DA83F8CE186555B65092BCA0BD754A33E7016156EAD4
      E7412D1CC161A40EBE14AEC3ADF094BC5251E8AB13FFB10D2F9DCAE58AE0FEC7
      486FD7919E4C444A68D991502393A3D0900D4F30BD4516DA2011BEB730B5212D
      FE081F6186CAAC86946F7164C29D012B9627F69659A73DFDA13A09C94A6FB00C
      3EE52A1B0A4E0DB5596D41ABAF5CE4D26460B64B73149568990FAA82E5255606
      49188A4254964F6C7F47D40A7569158178B3838E7BBE70ECC27EC07775C9D810
      CDC8049ECB6045964DD24A3C03BA9884FB1044CB8BCBC7F94ED62EA257588D48
      ECDFD5A2FDD9484DF78A7F6ADF997DD452DF19792C2F010F474AC62686FEA614
      96D17512D077BE2F2720EB7F5BE36A1083E0358B20B85CA49411543C1742DE68
      A69CB90294D1B45336A298C3B11C3F5F68DA2378CCF802CE457C02EE9B4C30CC
      F47C9CDB0B4D2CEE53DADF24434AB65FC4DD1770E8929986DA4BD3679373F87E
      860C9F06881ABD63CBCF16C9CF6A84365B7FC81891CD164739009AAA39295546
      2465DA905C888D60DB7D898B2DA3DEBACB6D0AB526ED538980F0B91D5B28F8B6
      DD5CAC2A98D3A952DA7D342C01A550A1A100547E2E2669660D3501702ADF0286
      99E26CD39DA51EAC0C2C947754F8FA4AF58769C22AD92CB9928DEE80663D1FD7
      74BDF62B418AC0257E054CD8E9D62CC728369AE871C598A8426CDDD05BCCA6B6
      2B51D81EA4A6A59AEAA3298B82502DB851C8B527B6D4C75FB88D8AE525FA4CAC
      FBF25071CF247E3B8C6322216F58B73813B4EBEEBE22AF54ED18653BD7DFDA79
      A8A3C03D9554A0A65890AB74CCADC903414F08D02431DDA2F2A5351304614E5D
      8FF9C643ED0CCB4B2EDC66A38C3F09AD83A3B865A438969E8B4535604D9FF7FD
      FE34233D373EF39962348D986386740D1303E5666E3105DF7C3F0C7CD87051C1
      F40008D4E5F6422EE41FA3664ED5A9E89C79C8834A27A9C167D7040E9976E20D
      97BE2227D29B6DF3F1E93F3E3BF891A64CCDC96647F08E78E7670C902F525954
      2EA46243BD1BF7B1275728F809F334F953B3E03E2ADD8B31E75B5339E8A769A4
      2E0E2A412608F673AD08194869D658C5B21C4FA47D2A2F4D101BB655158B78EE
      90C105B26C36852D312761ADF66A5BA30D81C053FFB462FED89A4F68FB2899F1
      4A1F809344B2AF6E5F98F360A6A5280D948FBCADAD15C3EC7A69804A2BD3DF57
      9D7F24D7F59F25C344957E15B55257096EBB6035DD5F4BE68D539AE308986DAF
      6086E6035FB2CCDC012A48B7439FD3CF923DA6234BBF8FE7C9308C11A8671339
      22628347A38451337C0BC9666BD4501220B976F2460A667A457B2AAEE967E995
      98AB891AE65DEF3FD3991C79571CA5EEC337E1EC36AA001B05F3D1FDF23ECD18
      7A823BEE4FB8BACE7B51929EE86FB05BCEDF26581FC2C6B217475C3FE3FDC7DB
      8BCB26255526B8E70A339D168CE525D3685022B270D12236C5ACEFE64C78AF1B
      491F5F5C7A7F71AAC645F4D7393EDABFA08F0012A45D50EE67C7F8EC38D5842F
      7FB2F240AA2C27EF924C528318C396A37D47E59F767265EE5A918AC7EA6A31DF
      98634C585E72ED615D4E0DE5D5E7F96B7BD329E94CA933E5FE6183EDED946C37
      DBD0B468391CBB73A5CB2501BB64C60C5C772AE46E693FBDD520B84BD4CB8773
      1C4DE847A4E4A2B2145CEF62BECBBB37799852DDE39D40A79AAA0783720A80D3
      4A82B11261B7310F795AC704AE4D02585FE21E1056E70140783FBFB2785C7305
      F8B03EFC6B4B82E5B52FCC793D88F280D615E877F52B6599FE4AE5DD457F18E8
      F9204E736D057BF43B2F2F3DEEADDDF715E8F5B498AB85D1E7BAEFAE12A7F734
      514BEE6D65EC8A8E2953126431FD3677E899343ED2E698EE67393D250C664EEE
      9C6F2C3742FA5ABE6CDBF611E5AA241C720C1ED98B9922DA9BAA0376A4D44A9A
      87E6C76D1AF5F909378A25CF7664FDF4E5EF0D504B020942F22B4224E80523F3
      687812E5D80D6D3F4481E34BEFE8A68F1FFE4CBB502EC1BFA0B55E225B4057D2
      27176956C887F94BEF559AC630E3FFE25D827DF8CF4FDFA3082B4731E713B549
      C891E9EB7B4D6D07E37DAA64FE6196254CBF5C06DC0D041A5930960082092BB4
      1AE489CB2916CE5CBE60C6EC9C5C5EF054E5DF6236E80D25216B20BA8D08D189
      A46FC859267EFD2EF24246DE0C2229814C4E470BA5A217088587E72CBB0AE9A3
      558A4F3B2DE5A4BC0AE90417B8D9B6AF10663C2FFAF3674EC357EF54FD660239
      4C068F10C7138027CF83B0C22A8071A2693924E24CC9AC900F78FD59BF0F7073
      EE251B73597FE830B78F67A310A9AE69287123AE15C0E52FC486E0623E6EBB24
      AD81FE34178DD37D9938BA825511E59FC171589E44C5EDEEDA16FDB9B6B3B14E
      7FAD6FF776E8AF8DADAD1EFDD5DBDC59A5BF367BBBB864ABB7864BB637D671C9
      CE7AAF27DFC62574DC6DF36D56777771D1DADAEE2AAE5A5BA7EBF0F7C6768FAF
      EB6D6D6EFDAEC71FAF81DF77795EFB06CEC6737AF77861EE1BC2D83FEB157DEC
      687BF58B17E489D97FB9BBBDBCCFCA9FED05852D98F2F8CB526C4A73AE57DF59
      DF8256627907FB9D61C4C53DCE3DCAFDB4F081613230FF707E6CCC1DA38EE880
      64B28943842CF7C76170759C06574F7D367EBE4AE683E0AB2BE5FB52789BC4DF
      400E6423CC6963F2383935A9942001DE0DFA5302635C853157CB6B2B49CA4210
      254F53573CE786F23C8DAFF9CE88ABA3BCE226E20E2CE987364C27A6CC056442
      2548CAD4A9F47AFAF2D9F769160F2EA67E1076BC67A896F8E5CDAFCF3A62623F
      FD7C3D7DC3ED6219AC75361F2785AF6A52CDAD5A68759F7B38B2909D08A78472
      E5C176811B0C2AC7A0B4621E954EEFED2FBFD19253CB0C9D46EF9013FB36AA91
      C6FE0D067DEAA317F35B0C5B7D576D10A5957125F844B13FCA812F0EAC72E649
      945818970557CADBD042A018F84D60E8A3A27E351B3590306EE87C1E12260B15
      C9A53F1BB9A51D5C4264281E00681631CB0A32C960A8C4A9CC582F8BBE662299
      A6C28F3342E61E285154F4335B2AF95F1FF01142E73C3F1FA6311DE53A49DEBC
      88E684F39594C2073289C674FB8D0F833EFFB0FA01655C747FEFC3B3FEF687C2
      EFFFCF82D5338C9E6F6C618AB7D71FB18C68D87F0B78C8B417C847A3EF7EC6C2
      8AB10616AD2E7CFFFB585FFFB4B9DDF39E23761E5C71D131404DD2304F9E15A2
      E7043F202E7E286B4AEBB50668845B34C2F39221976B2130402D6D2E918BB8C0
      03183023ADC60310CCD4D695D567C4DB34E203BFF0178EF78F314A5EBBBB344E
      69BB368B967B6EA619388D39B44A8E769072301838F7403B9A967040A4D9DE5E
      BE7EBEE321C8E43D0FA62F67C590FE69709FEA25917FDADCD92079401C3631A6
      E53B7E7625853DD2F2A3B9335E08B64F80F375F51A31D6C00EF417B3308B4B88
      70BA4406B9E78AECF998D9C582025550ED9C0FCF15A78A1735BCB957DCA436DA
      3390D2345B21B5562FA9904C36EFED8B2C14A42EEDD098A409604F4C2B458C1A
      67EDCB90E2E980B60832E57954CC0C647DEDC400C57F15DEF5535801655D4194
      B0CAE369C650F2CA9157BB5142D9DB3DDD4F63C09125E5CC0F67D8DDA011D37A
      F5DA0D70073BDC4C18E3E449AF7F142069C8B9AB9404F02C77757BADA774D71D
      315E9AC6364EB3E83704CD62A50001087080485B6E721FFDB428D2C924CDA52A
      E6AE6EE3DE5DA571C3D844652D69A7891606786E427810CAD1C62920A5C522C7
      1B81415A087D6028D46EDC38C35A280D0489AFA252B72A40C952665BAF812D2F
      B5ADB7CA5543B934BD3CB78964937246C44E3ACFCCB9134459309BA0532DE04E
      1B8391A925E25A64AD91E17A89C515CAF2922B16295B78C17A1A3F2C12531C1A
      46BFEB282B40A5D72AA392ADB2DCD504CFDBB6885B450753085F1B907F50337F
      9E169460A480AA0F512D687B08EE981E34435DBF73C82BD9DE8D2F801D5DF107
      72254BA2A5D4EDE7FE8B6EDF5FF70051125D87755B478B65411E0D3934B4B2D4
      EF41A43256D532F08C1404FD801C441F070939FF25B62C29537395AF1DF6B294
      70E73F8488B2900E0A4331C4C48BDCCA4016728A6E62F439CC436AD464C00FEE
      100D4D6BAB76B94DC04804E54CD7718732CA3F0DCB2BEA28D98E106ED742FA8E
      C3E04AFBB405E3569A71E8A8924FFE28F24A18859229D39DEAE2B299FE85D348
      7F3755D45F47FBAA8A363DA616C4C8B7EC288E21E3F5C398DBDDB98DB1665AF9
      9FB6565739C236D5E3CAF712F239D401F5A753EF5A2194258A5DAFD13D6CC4D8
      8A704D87A70E70823D74B9C71E9DF47AD12C29A258AB144D1D32C3D471889D01
      AFEB249D8764F3CBEBB3DEAFDEEBD3BD136C851F8FCF5E4179DC64699D075835
      D63E667E3171F07D9C31C1AD8115C7CBC29868DCDDA86B62C1A262603C5957F5
      92DDC35B87CBF0A57F697FBE64A4CD2907A7A87EA5E3B54E53B87E7B71DC2AB7
      96CDC39A462D0706990382353C8C1E90D71EAF0D47608CBCC2388AB66D4C2871
      CA78DD4A15E5003C806D00F9C0A663C287151449F46910358B8F3C24244EC7A3
      E1D72E0E1A2E37B5FD310CFB7D13921DD3E88359A1950802CE22DDCC8680597A
      61FC607989A9DC0C5AD79DB6E724CF8A3F8444CE6903A4136FEF5DF540BD71BA
      876A36CE0796F6E5D97EE9B05415205DF83E4AB6EB35CE87359DAC665AE5ADD7
      643CB2C2D718DF4D3428C60C595102CC5699916D2A8B8CF72CF415724FBEC71D
      F9B84FCD74C1C392FAE9E8F2E430F7DA6A28BC21A736BAA5DF324C3E303D3CE9
      C1F00E25ADB5C296D8F9DB375EECF7C3D84693B4CE3E25214EFE30C2D94F2753
      1C7417A651D36E1A45787530190DD0E1BEACB3F7769DFD5184F10A643FF4AB9F
      002F41BFA701DCE5DEBE720ED3AA60BB9CB3462F6893A433E530177B2398E505
      295992D4A47611B20704620072A23C9F097A9E777B309B4C65D8D92C21539FEB
      A0906B1ACAF1EA5B9563A91D242C5B2F917C2C260F560A7A7F09FB059C4F1962
      799C69B2059A464150E0D2A31B96EC75658FE69CA3A025FF512452CDA06BF527
      C3B52276EE4D7D5A3765F150341468BD382EB1C3049B258D07755B266A702D2F
      DD3342E3486AFE31BCB39F01AC5394706BF7588779C958DDAB22EC876393C360
      8C709F3BD7B9BDF5C9EBA9512EF4603531CDD9EF547757A7B5F0608CF4A67F36
      1CD27E47A5191D9EF93E5DC5310C322C042E2FF3D1B5C79161F6D40DD734AB5C
      4EE9DEF15EAA97401E10C72C11A00666F1C00142B2B8F663568A821FC5C76C94
      D82BC791848A4485E602B3309A65CA28B7B63E969BE999FD879092966A2D2F89
      0AE1CAA3F65FF0B3826225CAEE4B062B2D178152B4EC4A83D052B8D28702B458
      33A3E423511E4EFF76B87F9A7F407C671FCDF1D08C27D524B03464E11C7252E2
      ED3731FB3DB2E35C7677E9BFBA4B67025DE1A0089BE432EFC98DEE4677EB4F7F
      FA53CD52100F4769DF0B0EC86978C34EF402378043B1CE312E2799F33D44CF34
      7D865B70BD5C382C3865E632A31A1891D6410A7B81EF2B6C9812F457C8DE96CC
      0EB069CA7CDA82C7F2D1098EF22C1D65FE446AF0EB3B2DEEA45C5C1CAA69B5BC
      E41427C804A8B25BCCBBB95609F8F292859CCCB5BDDE1F43407BEF0CAE6089B3
      6CE23FF51AE1C3DA4EA2355E60F45B3AF40EFC1BD47164836E984FB45C31F77A
      929DB7706C086D886BFAF719DA16F80EF5924A5526642B58A98CD3D882B36B15
      1C17015E85DA9E20A5410EAC1DF6405064B1299A9B4F3DE3BC28EBA72AC8A4B5
      9496E3B11A1C27A153A31146D35898152D84A50191125F8E8BA7F2A7EF606448
      28667543821F2FF8F41D8C52F744BE171C585D246C3FD4D23F7D604994EC215C
      056BCA43E7B644547147697344BFA1FBBC6E15EE0F3A66FBA40EBC1FC4578780
      3809F89340A157CA010D617B8EB253AD6F418CBC8291AEB91586A464D5A4FC30
      B8BB4C401D93D30FAD20612816FA86490A2796D46EC8B8460A42B30865505798
      0B0A3917FB60E64821E8B8E18EE00A8260BD64F791431D4AF8B99697599E375B
      0FB58098C2A1002ABFC6E0C1283FD375E858D95670E6D656C2863AC5D9E97F14
      B12AAA1956978B5CD859A8D6B48ACCC2659462F51D14592D546254C97A89E993
      E640A5D4B75C1F624F56E123B9557FC88D5075D3FEF7C5B0BCE4AE16039769F6
      8EEBF3EBE42B3B86348972595261A977D02FAE52AA975CFE696B6D0DD52002EF
      CAEDEED8056C3C935F3195F44609F329C443B51BE3BAB67A9AD3863B630AE431
      0F2FC0283A653C1D6925C19CA75C639845089FD52CB3F9600166E6E763E9F5F4
      83801308082BFADC15166925008779B8F45D167D4742D36C34D195A194F04E7D
      8462056BAE1FB283A5C8B108FDF84C1460B903B43BD8B8E85028F639BE694D71
      A8A6C4FBD21E645F5EBB5E33F0F0C9D4FAE5200CA7BFDA32BEF699D6F1FD3762
      58D275BFD2FA64830FCAFDE234BD922CA4094972D6D5109AF54315BBDA9F0580
      31946BD7A1F762082A18C275C42AD85A4327D81B2DC650DF3E1D8453ACBB22F3
      933C7687F5D42032AB5F0544A6B75391B00322D3DB791844E62ACC1026DAD87A
      94D4359E9A0889A1040136BAEBDDF57FABD7CAF8F648269BDF3992C95BB57A4D
      AF01006DD30182C65CD9717B71680EC36EBDA65E06668E94FDCB83BD9245B696
      2309523A73A5F9C8B2E1329CD6D946C77B7DFA4E3C4267C2EA354AE5D6221DD3
      5DADD79BDF6EF53C177CAB26AF2DDC7F645EB05977ED6791F0E7B1178431290F
      5ABD465522E4D7F2F561FD19089AAFF0E6EB5FE9CDF93D11EDB76FCE6319AE7B
      E927CFD9B55EEF1F3F68F9CB9F7BD246F1F503807D7C9BEFE1C0DD1B0C1CE657
      AE5EE19E94C0203477BF4A3CE5A9E6FD35922287176FACC3AC44C661304E9499
      595145B97C825CEC9A59118D01F971194AC3E28F68584478E8E8F4F5995058D7
      6B9A691A68F395C4D170B4B511220B2540ECEDEF33A44CBD068697460625CD10
      44D0507F8D144C73B07CB62787F2372C52A38A259F2BE61C970B1E1CEF77BC33
      6E7744ACD3F9E4F0E2A45ECBBA51CB9F50CB9787179B2F58371B07FFCDE1F9CF
      F59A643A5B365E9063FBAB77BAF7EE449557BD867098E4A026F00D84BAB4ACA3
      1915F1DADCFA2A358D4C080A32A9910CA1E91B9FF367E1482AAC109B480703A5
      DEADD9C80E94B2617097F8932820FB5C6AF48751180F0C45B876CC1A6A9CE525
      DF9B84195AE9A77E118CBBDE7B04A25180583C470B391C6E3F969ECACAEDA2A1
      F75B98A5DCA0C9691660ACE640E44BC5A68E2540CFA43B0097B6656C1AD4D7C7
      4AE2A40B0E1E645BE25C9ABA910A40C944847A485CCAFD692919E486EADC67FA
      677E277A9B823C94A196CDE9D5A0AE4A93B066D6FBAB8B3D7AB077BDDADDACD7
      8B230CF0E4542ACF73FAC537A8B09B5A063B5E72535F3AA50CBA9814DB5F855E
      3F4A000B120D68E5C3B9D4D23CD38FCA3D515C998774A17CB92B70CE633F1F87
      DA9FE7C7C12CE613518A614F0E3625177AF93A05647C1CF5339774ADC915FD83
      B9A2B52657F4489B72EBBBB62997977EB9B83814A3729FCF3C7419C4B3BE97CF
      A648727B6DB815EA7EAC7460000018D9F13F611218F784D6CA13372DFE733708
      82A7A7D58196AAD74E20EF61F305CDF5AF5EEBC730414900379B9EF5FF160645
      DEF234552354A4351B9AF52974107B450C14A5690DAD6F050B3BEBE950EA88BD
      707175974513EFDD39272F5F03716156F4F06F552A2FC9A84DB4DB194EEDBB73
      1C30DDF09649CF68F0E52F3AF88DD61F490DC873B26D37AF33FCFEF930EDD14F
      D6D6A8D95C0BEB3AB731BD84BBB0F37C405E153900E3F0D61F844134217B4821
      4D94F426625CEFEB68206D72AD5708682A9F07449666E0A2533AB996B8221DA9
      28D61B19D6EEB2D98EB1FDEB25B9E5252EAEAEC0D8DB6C45940C50B399C0399A
      4431BD3848EF3B1A3BE3527D728192995110524B0C8BB4BC5F9AC4356B316E9D
      87B9307DCC82629685ADFBE3D5C273F93D574A4FFD2434B4701321D576DC573F
      B9AB5B21F0F252CBC0DD988CDC62419C9B5EC281F7EA8E2BC66FA4ECFE9A8EC6
      D816D4DBB49E969CB03F028CD37A8905F5BD5E1BAAF6BFC9045839F1A727A041
      C9F26E715BF056293FFC8F599817978071E50F691D009002C5A05C2CCDCC18DE
      C8A72D184AE8CBD4E609360EF61A40A7E2191793C28390ABEA25B168023D6BC3
      2F1E2793A21A1A14D78AEFD39F8DA4A085A71BAA6FA215BA351B50E25453B092
      B701D7BD37471C5828C9BAFE96A749C74BA221A9FF092299911FD38F713A9038
      43130FF8B27840130D78643460FBBB8E06FCC2FEA19AEF17E095A1A3F0500B14
      D576AF9B45A063BA38ACAD43A52EA1B8515EAF9C883A0DE223E7A9A0C5A317DF
      B268D76B6C7FE423B63921BFE8845CEB6E3467E423CFC89DE68C6C4E98C70F42
      E84A4DDA025909D324C6497FD3072D31444B6F1AA49309B475CCA582269058AF
      91B72E94B2F8B3633EF51ADFA77DF1E678FA478FA7C6857BECF1B4FB5D1F4F9F
      6D672F2FD5D0D2E612489BE67375FD284E6F981E30445548CD4665F397AFB9F6
      CEE2F8CB64091077E8733C95865ECB312E2FE9DCE14F9D3FFF3A8D06B9379274
      34C3076421794F1823E674309BD2418644B5E6AEC0552789B0BCC3DE16A932B5
      C4B4C20EC8EC080132DD14A3343170B770E1968896C0A26E8E8E2F3C3A9A5AA0
      471E1D1B8BE7FE7B393A4A35B4C7D8126F5E1DEED512CEEC0F93BB7977B27780
      88126BC370322DEE3CBA897F57B361DCAABEC748CC39F6EA62AFA654B36634CE
      2A531C52C02C8440E1F101E322102FF4F4411EF8D310A75ABD064AAAC01CD428
      E339DB907F35E7E6179E9BABCDB9F9C87373719BDEF7726EE653A032D538DC2F
      1D3FCAF81C87FE552DDFDF10C4931646C73217231F1CED1DD7712CC338F50B53
      5D9301D7B676AEBA3FB8F6B9BCEA241D70F378EE0D431F9569F51AC720F347FF
      7740FE239F822D0558E1E69279F8D556252211D1A45D4703E0BA33A864BD860D
      0A2B6DAE61A84C8EA197FC57F51A4C99CFAC715FE6F252390C0F27A3964523EF
      84A206CD6CC8052F5B459817DDA98F45A971101B4942E9354307A2E8AFF7DF5C
      F947E6DD7F93C1B722503BA8BCAE977494603DCFD320E2EE47D3F008A13C79D7
      DD3F7751A44ED27FE2C6BBCE371A6AEF7FC95087E9C6D38F940F9E6F31D8E4FA
      1B0C1604F1495E3FF5CC1D7164EB7867D9C84FA2DFC8F76FAF753810BDBE8200
      F450C87C0BF2259572553AB617E59F9F9E95E3F924D5777CF92FFA038E897F7D
      F2CEE13ACDF95048859FBEA99BC97E004D0E96BC380A8A27DFA66A54D05211B0
      E99A7927C937E9C53F7BF9D4D3546A146E6F2A683CC87FA5B3623A2B94ED86BD
      1558821AED33F93870E84D6601E29958E6D2FC4BFAD99F8059E889FB7C5B24BC
      6EF7C307D2B056C17EF840766FFEE183E9671D78071140B40B1A48ABFA7E348D
      8DEA5A9C73168F8EBCD47134D0F84911D214B340FDA0480DA249DD0688C109FD
      2042F131ED02249099CFE7F2FCF0504BC168ADD85CB2A5290E9311CE6303DB62
      60EA6B2681F9847B0763BC5721F6FC5F153F8C7EB09DE1B54B56E860DF87FE34
      4D5EEC6593347BB13799CC122DCC9C22F1948FC3B0A8D93AB68513AFCE0E2E5F
      D01FEBEC0F94E4359C24B448DFD2CEAFE4B1376C560EBCD99455B7311640C290
      C6B31A36FA8B248E4CE6EDE0ECD5BF7B6312475C3B03448772BE807C66108289
      A3E41273FB4D9BACDB3F96755BED6E34958E8F4DBBAD7FD769373085E6B3D0DB
      DA7DC9E1D00999AC81809FA9193307C8C6EDCB4384EC95470D35619E3FC155B8
      DCE2AF0128D64037D7ECB41091ACF548265A331791ED73CB2DD94A25232C31AA
      71CE00F24B67C3A49EE3DC5A7FE9B0026769216E0B3D2CC6F9974D4A1AA2B6E3
      E120A3C16BA46CF88727B152370B6F9C1657E15DEEA25F9410168A83D17E7237
      F7109BEEA91DDDE76CDD44D9A4830AD1A9FF0D22A63F3C790C86E71A388FDF20
      18FEFC1B8D364993F05BC4FE9F7AB851428AA958A997425A5E0267B777318E86
      85429CE6852F7519628A210C75154D99802F65CA38D553741DF99D6DF829E474
      67A4C98A59A0300EF255B24BE97598FD078D4C02E51AE6570572F3E4DED54C56
      F724C53E392472F6338C9B8FE87446E14D84DD9BC539558B07B0B403E19AD543
      51207B01055B4B02A1F0164032E18303332262005DFFDA8F6253A8504BF43779
      69E6AF8C727AC73B4E188DC850D35A209A637112B997874E3A8DD4E65E1B7D0E
      4C7ECD667DCD360358BA7FD8071E72845126F19D778A9A06BC38D34DC7D1B49F
      FAA0AC3CCC0366B2976E0FA1E5967D51AF21BB9D590A3D6DB62A6290EAAF0C66
      64D80EFD3837441600CF15886AC54A90A83C3A85F2BAD9AF0A1925252B2163F2
      08205E8796F124F59E0987F8E2CB50DCF2AC5EE37DA00EC98131CA5F22842974
      0E83687909D1772DF969F31E79BFD2F1DEA719F9B353E070BDCAD29B1CA9E6BD
      B8F8E1F546CD76FDF2929DD3290298E49E8273364DAF267E76A5679A16D7BDF4
      78FC6BDDEEA6C965F9F6D28E87F19BCF46A9D7F783AB7AC9C2E92218627006F4
      FAFDF9F101601F5393A649D29B8EF72C4D9E39DABE5E43BDDF09D8EE87345A0D
      627700ED6D1D73F6F4F3DA2D6C1DA329B6F3919000CC229DEE091D6C745E0B81
      6F1E03CB5F7A1A696B4FE310889E7A1EDCA5B3CC629D4543C5FCAFA928CEEF37
      24EB30DBEF2F7F3AEF7034BFC3B4201D496A4CFDE95D36CB792B74BC1FC3E210
      9CD40CFE6E79334966B611E7D4BF3EE1D658AF5D8CFDE48A8FD0BFA5C9CD60BB
      AEEB473AF1581A6D230E5D102B181D1299C2117AFCEEF847AF3D8AD3BE1FF347
      F48BD3AE77390E99AEED19B8BCBD908426C8B1FB3F23EB59809C428B96B57916
      F72AF84B124F914A5186D4A3AF398DB335112504D93382FCEBF98F0734DEBE49
      ACA4DEF9E16B5A7A4C712686751D196990CC47AE9BABCD32A9507F737CB0EE0C
      95E6EECDDEFECFA476385C8852DFBA8D11F9FC576F2E0F8CDA8015A0F5F6FD74
      70C74CF792D4078A0D5D79EA25F55BAE3CCCF3902EE5028CFDC3E363DE936C07
      8CA491C2970C06670987F5C4A2BFE8BD503A2B2943595E9211BAD6CFD9EB8B4B
      E7BCF0DAECF73CBB88B80049EDC2676A19B18D341CAE3489D22F4D94367DFD8F
      4D946E7CD789D2309F2AAB8ED2B6A25499544B3F1CA61969917C52AFF9D6DCDF
      C6D64B3078E605B97A1E9D78D93056D8773207475998E7DC821548FA0F419238
      857B353521B37A8E7AFBA5279E83E001D8139E4E3ED09A16E8AF93D2BDDC3BBA
      3C413F27074EE9B4ACE0CA2421202B03FA38A95DF1CCF292B449A26C8FCF841D
      74A9656CD9E47F9FA1F8A99FD1B2088B522A46269A161F45EC6C4BDC0CDF3320
      9E8C6F9E9357D10DBBDE2FFFE74D545C14E9F4D77A0988432507FD789FCBFCD2
      A4CA2221C500B441FC11C28C7E1F951231F64D780D19C4776C48B2CD9F2AAD21
      E3DF2F2F8535D3156CD85B307FED1066EADF9B32A2A2141818E34028026BE763
      034E43743C16BF51F077A8D60E0A409F0763C9B51563CD99B06D9C9BDAEF4D71
      22614203CFD27E81732CBA2C242C5D2FC93C1071ED786F8FB8C6274BE3B9F0EB
      5E9E436D4CFC847647D631FFEE9B40EBFEF2123657ED62AD1A5090B3E3AFFBFF
      DFB9D70E135321F51BB28936B5F66F2B55C7113E728D07FBE6E4E8A296384636
      8638E1F056DACF53AE6247B76FEC9CFC2FBD93B383571DFAF3E2A0E3BDFEF1C7
      3DFEF3027F5E5ED472CC3325383EDE272FDE7501D1F4140E9C73FBEDC5CF6FD4
      94ADE78EB4C790B65471DA8F66FA3AF4FC38F291E7E4517B747E4353416FD773
      A462B439A08686FE96235375DCA1364EFBEC409CC4674A983C0EB9CDC2B12C9E
      3D5F5FEB6DF77636B67A3BDD55FCEF190C917EC8B4A8ACA868E611EED1C614B9
      1162B4E4E5FC75FFF87DB9E3EB25A4B954480B719E0F1F8478D0EB03DC246F99
      E2DBF90C48CD931F3A749740DAA42BA4D4181B9A2903EA37AE5EA9A51D2BDB55
      D6B49E19BCAE7EE8273A3E51586F7E3C3F770C22FA239B4D2DEB9C5F8C471960
      4C853FCCBFAE9D375D19EC02ED7CF2E3E16B5EA8B0034537FDF5F86CBFCEEAC8
      0EB7F53699E5F4B7C9B6FFF5E2F0A045AA37AB5F50A4ECE894A149E2BC3A95A7
      6FF6FF5F67410AB621C6FEE2A87983EAF7D8A879EFBB8E9A2F2F290A6E165EBF
      38A5D93C0999811511112D659825B485BADE5B3257FC218C3532E3D89AE3E591
      0AB5A696AD235FE74FD1739445CE86ABC962B90881D5CA63CFC2BFCFA20C7881
      D24DC4782D036E3225B539A8D9C0648E7D9A2554943C84C6826904D3CBF0CEB6
      883F83F319492F15E76AB114EA35760E12EF396B14A5A7A4D442E611D69ADA9A
      8DA9F5EFB3C9949950526BA28991F22C373D6FD3743A9B72EF7BCD0677982036
      FD4263D4DCF448F6A6F4F669B97BCD46749C8E640B21797F1D663759442F9DA0
      C061E3E455CD06F3CBED012D3EF028157E4C7A31080DBF7486E0EA345D5ECAE0
      2D15E32C9D8DC6748AA076E58D4956D23E1CFB08FA705B475EF89369D73B2ABC
      094712FA21DA6286B318D715486E79B43B05B2822DBDBA094B410DE8D2ABDC1C
      9C0EC0A174E702F01C21AF928FAEEBBDD10001FDB7FF33F70670728FABD7BA75
      AB805F5009F3B14249658107C4EDE589F437235571A7209D2B4F69C77F81E5FE
      BB9B6E1726E5F3B25ECBE1DB1BE59BDFB5517EEA723FC374AB99D63B7DA001A4
      5D12A667E16816FBB0AB41BBCE40882B351CA59B5F6D5F1EFB7D323107F0963B
      DEE53E3A978E6924AFD2DBBA8DED42579F9652F901E0EFE850E7B098E9C79756
      1DEEEDFCE1351F5130ADC52D24A54E7E4648FFD6930E9D4E2BB53BB8CE352999
      DF25857FEB8D495DC45019F09033DBACA5BE44732CC9B1047AAFBC39921E7924
      6D7DD747D23B3F8B846034FA0DFDE885B66A234DC0E8F0355370673306C391BC
      DC1F603C4712065F5BDFECD01F5BF863177FEC786DFC71E3E75E0B956EDCA485
      41B71A2B5AD5D54994078DB67AA4B6DAFEAEB5D5F2D23EDAEA27E9201A4668A5
      6658C0C9D42FA27E1447E46FB321D34FE98F83904618797F3D641FFCAF871B06
      22330744669ECE32B4A6A3E8B0662A4182BEAFFC3C3CC5486CA8214FBD598222
      51D605E05963334FB1C0C0203D0B4060A291FFBA0DFBD55D11EE61585E1C2623
      9A60723A32C452B8F264ABE7F5A3226F32815F9A095CDF6D32818FD4993BDFB5
      CEE41926250045711D6961F5248D267E42E2F0FE6779E9BF3E30C4E087613C80
      C3F35F1FFE193FA2F8EB895FD5FBE93FDF1C9E1F1F9DFEECB5C64531CD5FBE78
      61DFB43B08AF233F011E539774FE0BFAFBC565986FE2959F1FD100F3E7BDADED
      DDF5ED9DDDADD67D84AD456FCE085B8F7CF7B5F5B5DDCD1ECDEDFCCB436CA8C3
      6059D2AD575707ABC16EE86FEF0E77FB7E10AEADED043BEBABABBEBFBADAEBFB
      BBABFDD5F555F9DF86FC157EE2FADD9E5CB7B5B3BABADDD3FFE8DFF402AB1B74
      D5FA50FEDB1AD07FF87B577F26E96D8574CD9A3C0AFFADD3BFB7E8FB5B9BF4FD
      2DBD56AFC37DF133AD60FE99AFDDD07B0EF419EEE7F4EF4D732FBC0BFDBDBC84
      7FF11376F52AFA666FD7B9532857E3F71BF439EDD8D50D1ACE065DB3B1AE3FEF
      E8BFB764E4DBBB9B3B3B6BC3DE467F6DB03DECEDF8C37592D1E620E8ED6CAE6F
      6FA91C49669B7E1F03FD9FFFA175406B39CBE3CF5BCBEE8A98C51F82E1FA172F
      EA2F5AC834800F39F92DA2DFF013544B784B7A90B38177DBAB3B1F86695AE88F
      411AE7B7F8214C06C938CC42FE36BE822A2F2845BE9BA8B420FE900F8BA4FF37
      EF3E5D4703367FBF0C12ED865102B851DFB4EC0EC220854A6D9F6B93CEDEF9C9
      5EC73B7D77718482F683F50E800CCEEA1626D4111F5ED3B282E188C82E437879
      2374932073777420B559A81E88A3DF708574E6D472A4AF1FAA1E64EC0A13B317
      CE1B4BA957AF916A07E66ACF7B49C345AF550AA026E0669097802E5B0665CB27
      5E1B3F8CC6695EAC70F2D726746B173D3120CB3B3B34E8032151E0F82EFC40A0
      307A531F4409693C9B90731815C031247F89C605E2432618C02ED7B63AAF3D98
      715594EF8D7D01E0C84232AB18E5AC3F1BAD00B084AE8F40BA80A88C84648446
      C94761634DE5B7B6B64B0234C047634E5DFB830176040935CFBDBF1E9F1FDB46
      45E5E90300A8D493497A17C249F350AE656A463AEAC820CDB8993B894689416F
      31C5D847972735139811D72A898BF3440EBC1D776D32EC5DAE0C9BA452A38136
      B7E65D6F2FCE535A2BE1F2D28DD79AFF760B710B00478832AA995CCE9C5A1225
      5D42D6090B85D17AE8442DD0AEC81B45CA0DFB211D26706C6B3654AB73D6CB2D
      B3EF4FC915B460DE5AE19C083E24F77B731F8DD3E73D8810D28149480BE320D4
      AC2B7F97D1E079FFA0902407DD1C7015B1BC9AD06F5340F165B18CDDEF3A9671
      B1BCE424B05143C5368C35D038FA0B0EAD01C438F573B24DBD1658905ADE5578
      474772DD2C18142338489B0622B886A3A81C5F4F1AA8FD9E35559353FF07B454
      6F71B8FD7BD152C8524DA6EC39A5A492E298CD1A53201C7A70B76E69D45C4445
      9E18CC9E4C2E8C0A20DE5C87CC6197D220EE1417A31F8EA3A46ECA4BADE1F54D
      58C306F252BB8585E28B418DD0860134A09A8DCE3A47EB6B6CEDFBC2CAA25835
      E9D03B270B16A50742C3C788B0EC269245776E595F2C343C479362FF4EF259D2
      91033B589C27FE384DC8893A65662DBE73C91DF3D7FDE373E3355525ABF00B35
      93AD91ECEA8BB535F8EEA5BCB0954CE3AE100FD8B62569E97184BBBC445248AF
      66536F30E31816B7310D741D32B412D0819887609664611CD5F06C352EE73689
      E99510416AF5DA5BC31B09B7FA40DB2EAC70722090D773A8F0ACC4A3F45A0AA7
      28F1D716AD81D8984BF5731DCDF8A04FF6DEB92DD915A0344641A2BDCF5EA464
      FABBDE85C46031D513DAF27470F8313D12686AAC7469AD437F68B9407C67B644
      C8315E3A65F3BA2D7CAB7F57A121DE71A81A187A2A31D1A0F0A0F1AFC38B13EE
      E4EF7AAFFCE06AC471B9926D2D8E26913ADE4C194C7F5BB4399513B72AD55642
      DB7C024B48DBF7FE3E0BF3C21C177A3CD158325F50F5547D0C337F049807E92E
      A733A91F1A72653A4F1E5A70263552BF9E9E525A5B24AD43CE05545A62B56514
      50848241C63B11C990C4BF9E307477D77B1DD14E7B8B021B248710DE74C25CF0
      5AC3E1103589D7B405ED5E44AC58825F02055433C919B9C1CE3B533317629375
      66D651EE9140FF837FB5A7C840E8FD31F1F3B2E36C79A9EB1DC8AE431AA663D6
      57C44DAB40788B7E0B07A5F41409546268C043A8A9F810347E9746248BCBBB69
      08068D22CDC89444FA613A0DC9A3E97A27228A5C365F659BFD6F77A57F4EB015
      59248D43FD48877AED3B77A88D3FB0415BE42D6761EF6557E4BC47FDA32AEA8E
      510CC620A0938A6CFC9401655FB22FB08F4696A1386CD651EF1BF8263AE4C0C4
      50483ECF525AF1AB80E3A96E59FDF28063035AB9B6D59CD4225281D554D82E9F
      4CA01118B895BE6BC074F4461010205FDE3529C1411AE62CC29C4318E3B07A5F
      5380ABA727FF8BA42B698C14B10F12B416EA374AAD2962FF87B5D9F7CDFC6CBC
      3C584B2D7823B3A96E8916D2C3CB4BC1553FBD2575158CD34CA241FDB4008518
      D8124859D54CEDF8D76904983871A380C61CF834CE4169F1919A4D3D6E8B1F84
      FDD90861B427ED62F9835672EF3495DC8F541CDF3713C2F2D27B9CD5054A8C94
      6C4C0FCD08C982C24F946C322437132DBBA42F9883CBD08C8A895472D7E230A6
      9FE8333FF64EC3DB19BB681745E84FD825CDC7A9722F902574C087BF9F5F797E
      1F0C35FC1A7AA293569A4D6A86EA6AC14FDF2831555B6AFD4CA06DC5D2F3C070
      943CF3844E631337111B112230BDEF07E4E8A6493FCD12EFE078BF5ED25059B4
      0015A6A6A17774D05A5412A971C87A8DEF12E3D2DA190BAAB4B08C86C76A10E4
      EB35C83D6D82831290AC91C3374CBFD4D4D4BF783BABABE37A0D8DD36B216730
      C0EC1647B43E833466C72F1918224953C94927013788D593467979A9552589B2
      7060D2EF9804114C2571C39466F478EFF440D807591EF4C3915DE46DA1A1AEF2
      4FAF74BDB3C4E1E054943846C21323A2A3CCB5D16FB526A53E32FC8A0B891460
      353159AFD6A53456E7975A9DDB8DD5F948ABF37B471255DBE0AD66DD07911FA7
      9C912CEEA686C89EB1C1D7BA3BF59AFBE5A563695F095F0C42ED6409BD5931DC
      D1AE17C4B6323FC9E3B2E3477B013A021A73C75A7632111051D2A1284ABC2832
      DE0F2418AD4F04FCA6A62D8A14A0420AAD5F2F71298E2A1D1A6249BCB0298AFC
      2A9AE62491C1808C2705C36F74E917EBD2AD46973E52977EDF00705697BE3A3B
      B884362143840DDB81D72EB274D647A91F07E40FFC9B643403227198D7D6B37E
      6D69EE40C3B4B77FA805DA8251D18FA64C0BC4BEA626128E386251027C647E10
      7AF3852F42E7A51110B2E16C43DE825B4ABB5799B997E08785DBAC9358F7B470
      8D29DF6838F8C1290D672837AE587110CCC8F89FB7701B8AD92F56CB9B8D5A7E
      A45AFEBE41D0545D91A708BA412E77028BF3D19B830BC3B6283AAB6E30873A30
      410C3A38041FB5D672ED1DEFFFE4B561BAB70E42810662DD814C131D42ADBA1E
      397CB03AF47F39E38C6721F3A22ACE255DB38E1D2DBDFAF4E799F0C3E0803267
      0D426829F7FA23B14D8E8D277DFFF5124B39FFE6E460C0022E1D4A84B1DC8E1C
      6B81CF0A5EFEFEB591960CBFAEE3869D01B471675E4F84CEEA0DBBAC6D434F48
      F260DDDE5BE1EA07D4777837A08C950CC78DF4A29AE0FFD8CF99BDB91234AA8B
      7018A6DB78F39328E77A1A26C1AA2FD7D583000E176F0E8F6B4ACEF786FB179F
      F719E3AC8C5EE67764CC4E78E3B6F6A6535AA7D2EEDA12BC8236B79897AD8215
      E30F84C820632CD29A29F8967690CB206BF6EE7BA479EF7E0BBDE37424EF8FD0
      7A96854911DF992C63FE354071D6BFD2A078083EDDCE0E8A87395CF7D24F1A94
      6BBDDE3F6E51F2973FD7A48CE2EB7871E122DFE67BB02C2FAEEEB268E24D35C5
      1CA75F23A3F854B37CD68FA36B843DCF67097AA444CDBCC952940464180C60D6
      1E8D1D4712F85D643D8F1EF7F2C58B9B9B9B6E82BA86493AC8196C2BD531BDC0
      6F5EF4D676B636FE986071DBEB8BC1E25CA0B8EDEDF23F06790B15C40DDF5130
      370B26D753B8B6456070F88F9EB71528DC9B01945398B70A289DB9CF5061DFD6
      0016C7406F0080DB7822A0B7DF05E6ED73571CBD2DADA6A7C0756B50DD9AA0C8
      3F3C9B2792364787A02FA5F179EAA543305C31EB282C19F6A8E020B5CE90E96A
      C1F71633F4151A9B5170F0220B7DBA791F8DEED6F7A217EE7817E1DF198AACE3
      691A8EB36C1D2F2C826ECDECD3D7B318A4595358E5570034920876E699F83EC7
      5C2E9BD8EB97C65E7B4DECF5916AE67B87749F2B2F40838E47DE3A68E86937C5
      7079D9A3D72AD66E71CB35AF0C1921FC6AA9F7EAECE282B13939E2675CDF7AAD
      942A14E5353A6FB96BC6A124A7ADF01F6F2F2E6B39AEFDC3E363EFC6471E8E75
      1250D066530E3BF643A0BFD9C23E87B7A35E23B56B798F63CE9394FBCEE270E4
      0777DEF9E9DE89A6231178FDB32E6085A5D24F84E11A2169FAF3047FBE3FDC7B
      D3E1703D9D9E4717F52C2B06DDD2F212AC89C503B4E159164235403B4B727F18
      4A407E7A57F6E59B8816C371E29C10FD5033BB01B4E7BF7AA7292798B496F3E0
      68EFD80344C1B466B1585AFF960652D458364F062924CCFE6890C6319042E916
      5E90F939FA81404CAC3D0ADCC3C0C14EB53E0F8EF76B260CC02D78AD1209AAA5
      3CC5A02D016C8DDACDCAC6CC5997611AE3D88B86DAD601931B5675CD0E325B71
      0B9822B23BEECA839C16C0ED564F43D8359BD09F6876BCFDCBF36336F0D92411
      835F1122C04C83D53D2C5D81C6DCFF52737FA331F71F69EE7FDF6C24D644D243
      5E0A870DA017B68F84CCDD0C09AD8509AECE5F363992C7E54876EA90233986CA
      12D330EF784738183ADEC5342403A146D34D6FFFB2FAF21DEFA7D0E75857413F
      BFF683AFD53CF354433AF783F0A5F7931F65F4FE8777611DA7655FD8CFC2AC4E
      2F7D1E4ABF419DDE191D011E5891EBF4D23F1BE73B4D5E7A7BD924CDC81F0DFD
      2982D07B9349DA81526A0C903FA0010227F505FBDEEF39B61866A8EF8325FFF6
      E05C9C2E4104024BB677E3B3514B66489EFB2331F3055B938E2DFFFA44B0DFEA
      B550E6C2AEF73CF5BCDB585B7F406B6B79E9D59B834B260E367D1877B4C24DF3
      DB4062CE1298618007666921773D2964D947436E212E3C3C7546BB013D06B642
      5AEEC6BE306EF435A2714F68C1910B5A44402A140C657750F83D496310DEFEFE
      21EBA71A3172099EAF588C55D8E872E03CE6BA0D2A2F7861DE9F46FEA07663B2
      11357BD830325D72C5E1EF83E89A8655A459CD62DF8DA9F299B112F21DC3D77F
      F5A6E33409D1D376C3E6892640255EAED5CE4E0F43CDCC91FB4D8379B5909B87
      86742F6FF0B68C7E42074DCC8759A0DC4950CEB8F4CF729D4524366A8E51DF8B
      99D873A4D3D1123824FB1F88183595D83E0F1DAA2D2B9E878950D531F62E5807
      E807E0E65F1CFE87E41DDA68B00410B1A4236C864578267CB43E0461DD645176
      70899E944600AE84AF1F0CBC3468ECFFB4671A1778819B460D41D01BFB3168D0
      69290B0603F2A60708379DD052BE43BAAC96833E304C8B9C03D59C684736B82F
      F49B0AF75AD10DDCBCA239E49A8DFB34E50E3586979741B5B041AF60B6DC001E
      15FF12F47E1A69AB66A333E94FEE24A39795AE6540601848A32861A06B34580D
      4A02BB9A0C6F79493B705E47318E611C3EFB9ABA964E8FAE779A16A100DD4A5A
      4B667A285FC8C98D00CC88CC3CA67A9A814FF3EC6774A115221FBD5624D461A8
      5C699317A43F85D365F6D6DBA830B8BBA3CC9F7404FFEFDEC334B081678559FD
      D86154DA0E289609C6D453075C0840B54697D8A6AF04A95E708F1B56CFFF8BD3
      1117C0CDA629B348D58D0854ACBB4904C62B0043F0BAE77D4126C93340F42503
      531321E5100614222BCB09CC425E5E921085F0A85A6E5E01B0C4DDB127F8E60C
      B5C1DD7074053F83EF880775BCE9ACE0828BC42DC8C8D2B4300519626F9B0F49
      EC61302BF86E6C51D1CDDBA657A64B1F763C9AAF77F25358040D94ED979701AC
      3765008F746DBF73224FE98BBB90DEC79AE930B059966C2552DC447AAA5E8390
      7E5A32C6FA8C40CEA8A880BDC0BA28802E0914FE34AB1B29DF793809277DD2D9
      D33457BA4152F6088F8528AD840E9FF84CDD534373B3C45392EA33E5B662E3FA
      621C0D8B1F0EFAF17E1C0557351BD82F7B71FCABF73EBB0BBD577E3EF646E334
      87396780ABDBF73A34D7593DADCE1F4DC3DE577AEB7FEE86F9B4CBEFF159DDA1
      5F4F35AE6027AA4D2F211A262BACE37AFD65EFF8F857EFF5F1C525A3A7787869
      A96BADA6196A39ACC383A303CF6732AFBCC424B669A09A8DC90613DD4E3CD630
      A889D0E5183B9F958099BE2E5070A19943A52841336B260815C3F3F8A5C96F7A
      C0F7C42902C3DACB69A0C15820B65366AC10F8E48A300433BF9603DF13C63B44
      1BAD02D6D83007199D2EAC1768D54A9797D0ABC54EA996B487C0CB1F5AE58DD1
      D74D161C8C944AA09374F033B92147276707261C6B88011079B8F63386232C09
      3A6B39D637C707EB55DCAC7B14C27C2E91B1485BA2864394621FA11F9424B0CB
      6DC5ECDC43B0870EA3DBBA8DCEC41E4CEE2CBD41BDE3389A9AF52ADD94347DE8
      C1ABEFE82E92F4E6CEBB097DC654767B8AA25B371FBE9715E3499A664DE0E58B
      032F6BBB4DE0E5718197CDC593FFBD045E9697A2B23B6BBEE20F9B47A2199C4B
      E45422F087B5DAA9D94D5FBA9B1A3CEFC7EEA6EF9D98F43548AF67C5E93BDE27
      68D89CF8D99552891B14EB68E80D6653F20FB942453A7B69A35D83B3186443DC
      0A55AF9521E4F3DCB92BC1A8384DAFB811B2F00058A834D7F5248B6AA1E71C2A
      52C05BF296E5BC18A7B378E098C6C2CBCC131C167E147BD711363D4753E13C73
      8152A337BF546F3680DB8FD59BDF3705EAF2D280C90EBC00C16A7485FB869C4C
      B3B0A6D382F7D3CD1869D6711A7368825BB0FF369B4C157BCA2F6A89EF7A4F83
      B2B2C100A7617665F427CABB30CCC30489EF376994D40C825A3CEE0BF6B805ED
      105113F9ED0FFAFB37B02DAFBC4319F225868CF227802CFB1E133B0C40EDCE21
      46F05A9AEA6E0B718B5B62D5588405AE7EAC97A050DC56D911A859CDC80CBF73
      8123423E7E6EBC741AC25E47B48D63B49E3FA251D56BC4CB4BB207A2E439C3B3
      9BA1D07217DEF0F8CE0B1098E171062928F10AB38A109065132A02060CD81DFD
      381AA126C60FD0347E2354A9A17C9600BC3DA65F2B6B5EDDCCADE5A513A63091
      6E2D1EBCFCE25CF94C606748BF8306274129F35EDAD65E1AAAAAF096841A819B
      C98F3BC6D3634105F4CD8618E44BEC94F5EE66B701AB78AC99F2BD132E23A04A
      DB2ACFC3AC58842E1FD0EF514E703FFADFECA27F7417AD35BBE891BBE87B2790
      7C351B2135F1D21BC6A9CF252B5318B27CA4FB59940BB322CC9A18C5CFADE1EC
      B7DFEE5A5DEF1214E36855C9C21C39566C34743FCCDD8684D10F33B981DE1281
      08947C867F9FF9318329922D90CE466C12DC79A6245D9D8D389A80AD51CA83FC
      607929986580ECA3DFA855D6EE79FDBB225C997F34278FF2AEF74A4A48B9B01A
      0C65E88F0DA4DF886B47F96BB9382B1A44E887F6FDE4A52568C4BF6994C8972A
      91D57FFB46225C1CB07CAC0837B61E1221C9E741113E4670ADF350F68D3ADE92
      DEEF76BBAD2714DC1788EA77575A408E81EBC068D65AD3218DEDB4D012FF3A1A
      49AD4791852147299EFFABF7904C55A40B3F16A5219146F66ECD87A47D0C2C66
      3F44BC116AC7443CA4950F4C458839FBC91D67B0B368E0D025720FFF04C285B2
      09140967202116BDC70ADA49F85FAC18B987D0937F096B2D07B059CD9951B056
      46417D1E0E67B1E945615F6C42731D81B89CDC91194A460AD3C14467373D7579
      2955AC2F13E719CE8A5916769873C98FE95D6EFC840B49FCF8C6BFCBE1085E63
      50BE46C90DEDA3D70EBBA3AE272D61AFCF36DE08F82769E23B986BE409E28384
      2E845C627F3AE50B55B45AA8526219E8FB763CD31C39F1AFE04A65DABA93A426
      3E451E39DF1E5E14A6C8547EB9B747E0028FC03DC4B365A3718230C7C8E9479C
      AF2CEC3FB4ACFB2E5DC157D8FCEFF7CE4F8F4E7F7CF9C4A58DCB4B65900BF277
      56BACFDD2C398B512643F605CF83764D71F3050029E8B414B63AF8C1D2CC44D3
      7225DB808B03F4163C77B39C1762949BDF2235C3CEB3E51BE5C58B6F0FC26998
      0CFCF915918482E0CED7813A94372ACA9F783BD127B404F9ECD1AD03BA14594B
      E3E525DED9456A875BD971FCFABEF46319183C3FC00E86E561CBAFF7686F7464
      146607609571FE08028962C3D7C660FCB19F419B0C06DC4DE6DF9075D162762F
      4764F4B936C480B37A36C54FBD1F5FC95ACD66C277364B503AE27B5BBD3E8DCE
      3C9A26EC3D17A436EECE175A2A1BDD55EFF0AF6F0ECF8F4E0E4F2FF78E1BDFE7
      91BECFF74EF82C3B51CF7D38148843A26249FAFCEE156174D4D9518EC609B4D2
      04113E71271CA380FE448F060032077418C9494D3AA125FF0CB8D156355D8BF7
      BD8F0D7CC7856F74750035475EC72C308DB8D314303F11C000E82C0EB58702ED
      AA7A5AB7F6995B0EE1F6436EC36E5906E29A9595A56A7E708839B9667C40D56C
      A4665C482C6B2D4CD2BC30A8A4CA06AA2EEA24F413C7D661F59A871AA9CEE1F0
      DD40BFBA2501F6E2413440DF237F70C75D8979180FBD36BA5430B58957B616E6
      938EB77F51425D7055AEBA932657D037AA1C63207BE8882BEE2D6A3A3E901E7B
      394CCCF4917B4BA7339B7F6A516957369D28CF9354B0FA6900D84E9350CE4EBE
      331B6DEEEDB11921AF3CD4D10A00472ED62A9DF0249CAB309C8AFC71DF7C4591
      79E4D96876751E3E8EB039DCC7F3D32F2B6FAF04AF921179CE97BFF9F1FC400C
      ECD0CF6250B118C6F07AAD54749BD9711A14FC68C0D64F34F96A38914F38A257
      B3112A3639CD23A1122DAF08C669149842F37E28681706B949ACA77A8D7479E9
      92D6E3DB44DAD359072BC24539A5AA2DC46E7C83DC14597BFB3F9D7BBF08C5D9
      5AEF57ACFC43695F7EE3B3FA292DBD0BFAA67E76C15D6E24D6B3296B6EEE7893
      2FA8F1478FE97A3F46120E5353752A8F34A52DCB4BC083E11A7EDA723209AA31
      069D4A00CBE6E8A43E5CEC629E3AD3297D9366317D89C36FD1B00CBD4DB11105
      522E0BD903C3AC433AD23E201020D2B4C74960ABDBE8469CEF1A9813C9F80535
      3B7E3E7359B0724558D3CA9A5BA8604170E7D1F2929C5346861DD1BE717425ED
      EAAD73999A6747AE492099C367DE399F6FE511EE0DD2DA75ADC80E2BFBE45493
      4066A8CCBBC93DB7D284E3C2E469A29842BD299133199350A501E788151889D7
      BA5E3A08F597103DBB98B25E83183D40124BE007D36A9595EE40788CFD812C5D
      C6F628DBDD1A9FE91FF399D69B44EBA3DDA4EF9D6BF047C4762E0C404DFBC793
      8BCB15D99BD8CA8C55634F9B3C8DAF99D71D1D6AA9C087A4D9D1418763A16227
      D44C8DED69558B9E6AE7E148AC5A8BFEC555FB2200F615C5D5F3BDD7482CC997
      1BB5F2A56AE5499346DF73EEE3D28D336AE2803B0227FEDFC8F74F1C97C48FA3
      E24EE3F74E98A3CF363E52A35AB24437D42A24ACEAC9840CCCE624FCB225BBD6
      6D60711E7B0E7EEF6498026D661224C328433005C984B26A800E39F292C55B60
      4BBE5E6BA01CA1EFADC3E5AB8E8EEB3DFD98836DA091F7410154AF1122626301
      21D0F3334AB33BAFF55334202F0CA18C9374E0FD882EA09661C023A7A41F2A4E
      1F1B35F51A3173281806431AA0B1C83C3A2C4E61D9C96246B87214164E5007BF
      4B24AD472BD967DC8092007679A95E62B0F0B353E81021737CE317639AECA86E
      3D507B340F9CE06ECD128091262D13CE86DFCBD124297ED2527D2450D54867E4
      FF7A8D7679E9623E84D0668E7326F48B3811ACD678917AF95534ED20BAADBD7C
      1DAFDB5DD17685C02D1BE1305DEBC2860E5A1DFBAFD33409252BD33A42FEA1F0
      EC1BB4EA253B7F802C38463E93D20F2947377D8EA637231D0EA300B925C505A9
      D720B98871881AC6F2FC0AF8CCBAC95224EA0DC82A999965050E97D65B8A0809
      0C4519D403629F267BE29BA5D5E65A1E11DC0AAF0DCD0EA9092ECB8BEF562FE9
      910D16664049296E42FFAACCA885280789F2891E835259E3A02905317E655348
      F51AF4F2121F8B43BB5EA27BA9B8D6AB59143B015CA630CF24A9D3F2DAB4B372
      EFEF3344F27DAF2F25AAF4BB48419648DB06A18082C3885AE97A7B4C06C0714D
      5B1D322045A30CC9F4560809EBC306DEABBB56852FDD842E4BEA45DB7954E2C2
      64E5F7C1F5624B6EEA897E73522A2A6426FCE934467A56E95DA4FAC514F90751
      16CC26304983DAC5C907CB4B7371706EBACCD21B1373628FC8CB516C674B1A39
      00875633706071C18FCD00DDE4657715574E9B309400497225A020664DC249DA
      F52E525B5B078321F4F388630164EB19266F4002A7E955CDB639D2657728251F
      7947CFAEB9177194D26B9314FA380CFEDCF4557D5990A3E907796C90E3FBA6B5
      A986FAA175A51371E05434918AA89BF3F7DA6451B97F19C6DB1B14AB70EDD47E
      9A0C146287A91CE8A81CF078A5A5B56E010E1BBFC8BD369BFBA2E9F80C887D3A
      386B464405EFCF649E9CA2AFFB6E9ED8722B3C8952FDFB428042B806D8F7BA45
      98F770725AAA05AED3B7D51A3996FE141101AC0F0E7CF8B95661585845AFAD1E
      9341DD44CA7FEAE79AEDD25E688B48593359BF31E66FC665D14CD1E3765642AC
      121C2C45A7942F65907044366D73AA7EE6ACFC27995D3FC3E6C2F1CAFFDAA3E5
      7B003A9926DDC5417792092C373646B1BD6EC6292D3DB54610CD3D48C9F0278F
      A84B6A2FF48B3F793F91513C9CA158A4585000FA00790F4E35E33668E381F4DB
      DC96E58EFEBDA6908550D75F0FE8FAF911D606C67A34E135F1593D210CB5FD95
      E45FD694766C0F25F7822A44F498BD8ED06BB19414D3C04232410DCE92B1F408
      0D69AEC612663F53747E7C6E8EE6CFEA56F0D7C852CBE3F5CD5DFA136ECCD75B
      E8F7177675525550EBBB1BDBEB867C97A6E39F3FA0B42E1CF885EF6DAEF6FAAB
      1BABBDB5DEEAEAEA16FDB7235582EBB441C3DD41B83AEC0F8743AD1C0C56D7F9
      EF0DF9F766BFB7B135DC0AB77B5B9BF87373B8D9DBDEDD5EDDDADCDED81CAC87
      DB3B5B83ADC00F76D7827E2F0C363656D756E9A2EDDECE30D8D90837D7073D7F
      796937E8AFD3C377D637C3DD9DF5607B270CB6FDF5ED20580D767677D77B6B5B
      C1EE60A7BFEE6F6F6ED2CB6CF782C1FA66AFB7EEEFACAFAE6D6D05EBC1607763
      63B8BD1B6EF4431A687FB0365CDDEE6F061BBB3BBB81BFDDF3FDE170BDB7BE4E
      8F09FB6BFDDEF6E6C0DF1C0C37B67BC3C1AE4F8EECE6D6CEEECEDA9ABFB6B311
      6CADF99BABC3DD9D61AFEFF7C37EB0BEB3B1BDB3BDB3DAA39BEDFA9BEBFEE676
      3FDCA231D27BF4D737063BE1EEEAF6FADA7077D5EF0DD687FEC6CEEA7AD0DFD8
      DCDEFAFFDB3BB7E6488EE30ABF2302FF611FED074774DDAB824FA22805152629
      D9A4ED17BFD49584895DAC1758590C07FFBBBFEA195CE6D283AEE6CA96431A72
      773183AAEACACC93274F16303DD2FAA915DC597361EBA264E16B6215A17C5539
      68555C35934AF6FA2A4DA218AF4AADD5B4801B7495614AEC413565758D59470D
      F6BD4A2A4F01C7D51C7D0B1ADF088B6D3C4D41BA66648D5A729528723121E3A9
      16444853F5A65A43588432D1972AA726A7E4B39059A5E9FAAA3BDBB4DC2CAA5E
      70816A535329541FD87E2AD6049B532ED89BA4AF2E2B6B6ACE6C43B426B49D9A
      51AD7AA18ACA996D24D77658691D3DE0E512CE88063E888E65772F4E343762FE
      22ED91D69C0463D929D9C0D5FE6BDF81D46CECC862FFAE366F52C18DC215FC8D
      6502541189164D98B4EAE171858008E95DB35E4A910A88A8FCADDBF55526AC53
      4C093FE3EEDA9A8B41955663F5A9852A82AEDD3B36C418279B55951AE0E5647D
      15CEAA02381B080EDE441D9D3413DB013C93B75C976BA40EE06CA622A2C24D45
      0991A2D13E5988CB0849149AF725E83E4AC6AAA5D54510E1A94836644A52DA4A
      A95D8B2E08274C2B0EE4F9BEB58ACFC80CD58CB02496530E53AA6FD1E7D01AA8
      C1473987AA5B16CC6F3257A3098A256582D6D9F22DCB0EA220AF205DA35201D3
      DE9A188B16B54CC92410576C2BBBD8AC89AC4D2E042BACDF33868F4F4C323F60
      0EAE004B18D9765F5F5FBD7CD6BFD685052A7F1CBC221F590563B22E13B1979D
      5588A92B51381726D880602460AA8D25E9738A35A5C6CEB40A59442DE0173C1A
      1AB82603ABF24AB95C0B382665D2F515F6F00581CC939B8A8FD64039D5FB0E6A
      07DF4447DC7C89DA8B4CA0B2CD953505095683F3028F27ED49B4D2740096CAB0
      37A8020C828C924C29722A3619A8CA4851894529A692BF1AA04075ECC019573D
      D174328032BE8921047492CA8FF8BF4DD9AA6002A4ECFA6B39C89DFFED92FF77
      5F5F5F3D3F53E2D1E7351B38C293316012144DAD6AC8233725A10B09FCAA271F
      250C06B0024B32A36030EC0DFE4AB3707109A1513474F689FA622343AC987812
      5DCA04520662E8DDF5150406F3E00FCD734540BD24835BC0641B1240267D417A
      512AC40ACA4CA414D52A313FF8A4278BB31335B455D8D7F43FBA34574A6EA64A
      5B7422BC309D2313484D9C0DDBD554F109E1B4525F5FF9D2222F29AA0420749D
      5220EC14F51474241B2A17549373AA812F5713F95834255002892938AB27059F
      6B17199961E9987DC54CA3AA7756409E0DDE37BA56919A343909729B3C16DD19
      1EBF52998A878A3D570FECAEB858A5F31E76A9414539E9A229A315F6A7C4521A
      540C0550258C5535DA8623A62831A95AA501652C2C18404CF1D990F64A4A08C7
      02510DB35631754FC013B09829B9B6A9E742152A0AEDC444C49BC642619CABB8
      31764A03A8980CB0E1233D191B944D9ED81895BD3093843955843195F2090045
      1D1CB06E53495E910054093C2A7C13C9B96C3151A4842C00AD9046ED3808BD70
      658D08002E961AE38C9F3A49364485174497B42958218AA36A43ECD460D60529
      088129C2DA9D98816BC0092C19F80B1B222C245A25D85EC12E0D1A90D4CF046D
      57DB6AC3EE4419C407553B8753601BA18D0AA4248A8DD2018BF05A7231C92285
      4EA44C8BA54DA6D64963762E5A3AAA81470A481F152310202441509E9A99C048
      CC22C92990ADA09CF08368ED2C29419803A437C12F02569614832C55AE843458
      49BE64901345E84802E241D32143913943D211304A244C94D045A666848C98E0
      8529B14F68CD5581B928333DA7041C42099E4A935DCCC18BD41F1C4002424AAD
      5096AFAF9AE9DC589C6310F1B054C09C02E4A23124962C99C550A1FABF992A11
      9A9BFAD7D01B35A9E18EC064619007284AA05319CEFF2A30C428E4083CAD7313
      7043DF0163F81A80B9BE062A2DF57F63A26A355C86F2742ABAAC2D0A066C5014
      7DC1DB390A6928331E3DA26AE77EE97A460951F8C664F18536C2F7E28ABF5AB1
      1461148007E0496B4AADA116E8684581A660221B2D4AB4A1116024F401D410B8
      4841FC52D61C9A4EF22AD8D28A3CB13A8462E0E9568DC921424BF0028197C830
      BA41A46736E816F8B2EB1787BA3429AB6C2A1579A286C8907224032DFA027304
      3C033498924DA63A071C990433B32C901B940842548454B872552257641AC887
      2ABD565AC72CD92E8A53495852467A11F0EBD153CA2A4059D93ACC6C7124A55D
      A24B9235C6939FA036788D9A420F788421404443C08919C008D3C38F973000FF
      B36C6284F6E874CD6B09C90FE3448B429C8CF36482C43F6C90D4B06085645368
      D9068C90545C8CA8C0DD8D6203BB06DDC9D25220407575F47494164D5F408717
      88029964E938007625601477D8ACD705F68BAE93FD32969C0E94A5EEE3EC2D97
      9894262A2922851001DEC2738D0250903D3CA30E07632608B83594AE434301CD
      4C3AA1C7C82E6F6147912C3A928E450B348DA750D9300981C6D113129F92280A
      8D8B007AB438E872364122A99A684C812097B03DEF62D3BE431221A1587342FD
      CEE28D9C027A44D13B836544C835F45343C8380A3FBC8139E43E9CD87C7798EB
      D86F40D44C4072AA363888C740A2B6C09D1472C8967EA4D714D8B3D55E601DFF
      53C13C3C4A3209F8537562EB125B0BA41EF5DBA22548C8906751D4A309FB4100
      1664C057331F9020BD7D90144CDC017517E4B1EF09D7139CEB2BFA1B9AA6D819
      D8C353BD47510102477FB10978C448AA43A4EA19A465C5ED95648B14E8095E0D
      E46BD3B46D900162C5254DD94853677D58B9FB40216D6776C01510027EEE446F
      7BEB9591CB89B8804120839043DA8133C2808643F51990924D42A5403291FE08
      E5685A9C3449CCA551088C53C80F64025AB8E10626EBDE349038E425D4E3AFAF
      60294069B5C915818B16489416E8A06B4A477145EEAB4912029A22941855C9E1
      E02434B28E0A48AA689291A4A190C0F3CE64511A4D88F3011402082A758EEC4F
      E9069BD4899E007505F2D00A5444A230550AFC447A752563E948B830C9426BE1
      637793467B4022924043C35A3B2E445DA41D44E0F5B21911320808E404C1C16C
      DA9909C523800DC2CA1954A7833D58C017822054E092E88BDE86A41E05BC8988
      A991324D1D471ED02C50183C8C980A63035890545EDA6514904C78B8D70C64B3
      4B11E06B7ABC000024D8E2FBA87C22CF62BDAED612698D046B22E38005D56052
      BDDAA121C8698DF08791BA66CA530D91DC320DB24405A233E9058CA23F035354
      221200CAE9AA02FB9C409AB890C8D61444EDBE35285501000DEB520884A63BA6
      338246D919A989F2F70403FC6B140F0540207FC88058A9CE8D654CEF1A882F42
      00155F6975702E5F92C38AA2C17EE9BE11805D52A0877018394171A198228CD1
      6CF4CB3EC062E8D8DE2118D409DD0D7A5AF75A43B7093992B31296A113A7FB21
      636C8309A84CB03FBC4D238278690225E3106151B11BA03BD141D8A9AB5A283B
      90B1321158B8106EB732F62A84AC2A129AF59A3A05B552B961A70846F02B4C83
      0244CE53C029190E8D65FBD107A2A785CE4B8D5CA086B95E388CE918047809C1
      89A5CEF50CCA080C12C8165708CAA431C2CE74D3D57ACA902B219B82A05F56E0
      675268E55E05C820380800D3F6E23930419B4C53DA7A692410F42654351F0351
      807754B7BA1A7C575A97FBF09C4B3242207982E37517531ACE22956178C01AA9
      57C8506AA926128489C68FB670EA672F882654734C01F90A231AF2066A35B022
      E5809D629BA58A874476505650692586E83C248E93503BE0A79A662122A80D5F
      42E4110683F94985D02218E77F21C1248A7766598F42CDB6251B0C22B466DB8F
      C86005B6D41BC2A944AA339B0E168C9034094C389ADCAEB99DE99CD85737401A
      C343B78F268867542EB29FC8428A88DB4831A74576B41FDD486A46A9E4CF1471
      5E3F5E722975C6F6D6C20F9882F0A46CD33542A6503AEA87828F8C4479F70E09
      3451736138F48145B3D2DB76CC4CB1828F421345D8B08C8C5196C2238D457551
      BE532E224DFDE86CA2DF41F076A98A0C4545B48A24469757DCC93E5149D5F140
      93D19658DAA8DC7B51D8823687A62DD29DC74417D67B67381A7685E6A160E0EB
      72C1FFF07FECBF588823F90B914FA74257D204D20931808355A13FC365FDA481
      CDA2DB354D89E2A2641E050273C80B940FE0A26A9203150A87F26C3F02928E2B
      391C47144872F639D1F46550ADFAD9838BADCB968908A0035DE73A61E177BA5F
      F44BD740AB7B7A4C13610A80647F96927673A57BECE989C2D9AEFEE529DA6BE7
      2B87A76CF3498B848A61880609B87EA84531A469463A04413F5D504A131EA6E9
      F5BAF74C8A36139435E4ABA0CBA2BF408BE70906E93D4BEA2D7B4830512874AF
      0C5474BA4A74C409E4BBEA3DBD719466643ACD62853A2142BC46D3879841A8E2
      22E0247BB746A6214A81A7E874ADE1B2EB2BAE8BC090AC49930410A4EB8D57C8
      056AEEA7A2B4C61531A63C32946E40C62EDF05AA135EC76447674B87D7FAE1A9
      70FD9C877A660980EB156F12FDC461A2E640EFB8A1CB6474A3A465119DD0AB11
      5D272222C011DBF6B11F13D1BEA1C3538C1A2196A9BCC81F88AEECCFD70FA22F
      68074B7FB7FEF8B9FCE3E3FA6A3AF358776AFFDA1EFA99EDA513DBF33B6083F3
      A8F3E7B9AF5DF3B5D3C4730FFA85B0F3CED259D76B99F0DAAE5E3B633B1F056A
      D2CA5D3D9FBFBDB69325662017DCB28748E0786927DB5863DEAB99ECD365CCEE
      8FD99F5ED27B3D21E5E7EBABFE43A97C777BF7E13EF71F4DBDDDDF5F8F96B3ED
      579EE069AEE414D5B89FBB1529BB6710D852765AA5E1ECC78AB6B711AE7FB71F
      F8690AA8F27D0444AEE71DF7BF735F01CF32CA858E7BD6A27F9820B0FE132088
      406183D4A5F7395D98EDF640B628BE27FA3C7A7FCD7FC851104C73D0DBE9D933
      A29FA4D9E6E63DEDE7A1D3F04BFF9EDE7F5776AEB09A7F059564DEF36C253DAB
      224B1432BF8FB7F4BBB6CE163243EDAE9CE92DC46C134DF1FE356DD3EEB5799C
      7C1A279FC6C9A771F36BACDDF73C33C07E8D83579EC7B083DD6BF264D4E94AEA
      648C3A19A34FC6E89331E6648C3919634FC6D8798CC7E3DDA36917A7C767F3F7
      8884CDFA70C4D16B8C030B7B4CF6DF3E7AF770FFF0D36DBDFFF7DBFB72FF70F3
      36FE4939DB9FDCDEE51F2B9AA24DF3B7EADB9BDDCF8A1F5FD9FD18B9BFEDE3F1
      95FFDCFD36F6E3D3F71F6EEE3EDC3CFCC4F310FEFB79C9DD87C1BF793143BC79
      397E7AF33C767AF3CDFC59049F2D8E0E07A37FA8BBDF87119F5D5F1D6E7B37EB
      79D3627903E797949F7DE205D5A75E507F7AA3CDA7DEA3FDD40BBA4F6FB4FFD4
      7B0CAB167C9C75438AFD6935820F67AD03E9E19C75383C9CA337CC319B2C5A07
      98C3396EC39C75413F9C13565AF4880E75088F87BB4C987FE102EB227E6101F5
      CB8D5887860B0BACA3990B0BD85F6EC43AD05C58601D822E2C304613BBC2F8E6
      77EFFACDAA0653ABDDDD3DBCBB7BD8BD2165E8AAF11DF3F6B7F21E9DDBE9B07E
      189AD237CA942DC4B127DFED5CAECCC1AA39CEBF2337B4FD87F97D6277ED4DBB
      F9FEE3877A3F68487DF7C77A7BF7FEE9D6C443D77E9AFCA13E7CFC30B6EF277C
      3CBD7D6D2B489E1718337D7E2FD4EE062943977E1FBFDF340F5DFB0B0C7E9C3D
      A7C498A14F10891F1F7EE8B8BBA963717E1BF387BB3154DEC5A1EC789CF7D5CD
      FDA8757DCA9BCF3FDEDED631AA98E77D331EC679DE98089AA7AC2D820793C644
      D03C655DA13BE3BD2D46ED676EB26D3F778389FB991B2CDDC57B8BA5FB999B2C
      DDCFDD60E97EA6596E4EC5612FFBDDCDC3ED18B1FCFAF6AEBF6379D0AE6F6FBE
      7F17FB27450C2992C335BED8FDDEF6FCB6ACEF3FC4F73FBCF9EDDDBBB124FEFC
      AEFCF4E6BB5195F0346B9BB49923D33F8DE4E6DDC7315F1FCCDC82C2A7B9631D
      D5E1DCB54DFCF9D96359F7F5FE6363BF7C1666E7617C04AF8FE96118C9DFC6DB
      8F3B4D3068E017F161EC4ACF00FAED7C43A83D8C7EF9128398F8A62B822FF775
      76CCE6E7EB8F5DF279DE18048F736EF365F7D34789F8F3FEC538557CF953BFC7
      E3CDBB1F8766FDF6AEDFEAB696C3D967812FE521861FFADD4BF6B69D9F7048F8
      BF79FBFE87787F3326E81EDF3EF5E6EBF87E68E21FFA7B18C7BDF89B7F78DB3F
      8BFDB9688CC5EECBEFBEFEEACD7777EFBB86ED77131D8B609FFCF9DDC3C3DDDB
      4DF3F74DF0DFFD5B4D7F3F7EE15FA19CDFFDF4768BC1BFDAD091CD137F7D3348
      67BB597765C3AC2F9E3E27638B89FF587F4A77F14319BFEE1FE8A2E6E478A81B
      667F1BFBFBBCC7E7F57792FF1749387C5E30CFFED7F8E1A6B7625B1BDDFB8FE9
      3F6A1ECBBC6FEE763DD5C89CDFEFDE5DBBABFBA387C40793C738FE60EA6075E9
      F716BF7BC14C0B6760DFCDAD70BFFBDB82592F882ED7FE01F7A8EFA745CF2B97
      637F7FFB3EE6C7BEF771903D24EDAFE65BBB7CFBC37383FC34F0587AF5814F11
      7C1A25CF8C7A61D5D3387524C6CACDC7B78FD7DD1F0C3F8DD597C6CAC3B1E6DC
      D83D5E0E06DAC581472BBA7303BB49C72BFAC581F2D8FAB038541DACE90EA3F3
      45FCF0E3A9CFDD51DBD47FD8DE3F6EEF5C149D3C3FF67451757EE01CCBB500A2
      C8E45ECCC5B1FD4B587A9EB00A540BC32F636B61D265902D4CBA80B663DB97F2
      F99FEB1F6FEE1FCF56CF9FC5EA23F3EF5F74A617F4DB21C8FEE9E3DDBEF89EBF
      C861187FF7EEA1BEBBAF2F66AD499CC5785FC8A105CF5E48A685191772EAFC8C
      A5E45A187D39CB964CBF94700B17BA90790BA6AF4841B98ECC1786BF96802704
      B72E05E596145C4FF80B335600F8C49E150096C30096C300964300965B007C6C
      FA1A00CB6100CB6100AB3100AB3100AB6D00565B00AC8601AC86017C62CF0A00
      AB6100AB6100AF93370BA3D701F8D8F4350056C30056C300D66300D66300D6DB
      00ACB700580F03580F03F8C49E1500D6C300D6C300D64300D65B007C6CFA1A00
      EB6100EB61009B31009B31009B6D00365B006C86016C86017C62CF0A009B6100
      9B61009B21009B2D003E367D0D80CD3080CD3080ED1880ED1880ED3600DB2D00
      B6C300B6C3003EB1670580ED3080ED3080ED1080ED16001F9BBE06C07618C0F6
      C2D1DDA11FFA0F1D6FEBE14F54CEF7FC87F63D76F14F132FFCF4469DFE9CF3B6
      7FBCD8CB5F093A3F519EBDE69A99874EFAFCEEEEC7815F13785AE510979FDFA4
      DB9BBBF96CE4A75FF2EBD1C7E7B3BFFFF5D3CF335F0ED3677F0C351FE61E36E9
      5A2E0E3C6C86B45A1C78283AB55E1C782C21B4591C7A48A3FA309D66B8EEC6CD
      847738D62E8D15E746BBA5D147E6FBA57147D687A571C7C69B459BCCCC1707CB
      1AB134D83E65F1E104B934C19D9FF0AADBCE1FF25CF0DFD2D9D305572E5C63D9
      A7E727BCE6DA85592B7CBC64D31A772F18B7D6EF72D4EFAB01BC74C6B2C2EF72
      93DFE566BFCB61902F1AB7D6EF6AD4EF6AD4EFAB1964E92C61ADDFD566BFABCD
      7E57DBD07E522A5EF7BB1EF5BB1EF5BBDE84F613E21FF0BBDEEC77BDCDEF6614
      EDC75DD50ABF9B51BF9B4D7E379BD17E6CD388DFCD36BFDB51BFDB51B41F770F
      2BFC6E37F9DD6EF6BBDD8CF613E30EFD3E7744AB45E08BD1176BE88B711729FC
      C5B88B0CF262DC5E025E248E17C3D789C01713D689C053B7AD12812FFDB73061
      D9918BAA71D9A7AB44E089735789C0B33E5E98B9C2D98BC6ADF5FB451178CEEF
      AB01BC30E175AF1F0BABB57EBF28022FFAFDA208BCE877B90DEDC77A6B85DF2F
      8AC0737E5FCD200B926CA5D74FA4E380DF2F8AC08B7EBF280297FDAE47D17EA2
      1A5FF7FB451178CEEF6314BE306BC0EB27F271C0EF1745E0B2DF2F8AC0737E37
      A3683F518DAFFBFDA2085CF4FB451178D1EF6633DA4F8C5BEBF78B22F09CDF2F
      8AC0737EB7A3683F16566BFD7E51045EF4FB451178D1EF63F725F89A29E3BF86
      FDEDDBFE7927DBDEE5F065BCFFE1218EBDC1F35FDE7DA8F777B7FD239A1E373C
      BEDDAFFA4E7F9E3F88A37F06C7FD43FFC8AB49CCB748EAB78B92FBDB37ED6FED
      A4FBDDFCE71B092929AB515A186FBC2EFD7686D658D16F86DB6FC1A46CBF1DD2
      D987DDAD5CA6DC84A85314498858C5F24DA1760F55A7F99E5DADB6D66F52FDE2
      764E870F71F4EFD137FAFCF674BBB2D3E74FAFFF191FD7577FCED5FFD21F7FB3
      FEAFF771C6FAB2FFB7FEEFEEE4FFE2F1B7D8FFF53EFE66FDE5874169D8B6FBE3
      F4340B0F8D0AB175F7DCF1820BAFA984ED8FF9169966B9EE4FD9C612BC0FB289
      A2912CD6B0533D05ABE47C93E385479CCC7C13DC506A28AAB8492C298EBF94C7
      A207363ECEDF74F42FF9F1293DF0FFCFFAFEF8541ED860FDBEF7787CFCFCF3FF
      009C99A56E}
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
