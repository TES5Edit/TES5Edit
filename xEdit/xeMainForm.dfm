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
      Caption = 'Hidden'
      OnClick = mniViewHeaderHiddenClick
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
      789CECBD6B73E3C6D520FC5D55FA0F2866DFB594481A00BC3B4FB2A5D1C59ECD
      CC6832D2D8CFBEA66B0B249A24221060005012E3F27FDF73E96E0014A1CB4822
      C57127E51145010DF4E973BFFED64BB2A1D3F37C310CBD68E4D86EB3E7456940
      FF0CA623C76DBABDD980AF18D69DA6DDEEE127BB9766E978E8F70763FCB2C5BF
      8671E9D77150FAB51FE8FBF15975BBE3A8CF4341BF65633111FA6FFAB7A1B0F3
      5F06A9FD5B6F184759D60FE183DD8375FDC0EA0D9378E245BDE160EC25A9C8E0
      FB69F26FF7B7DE9F7B532F8A5361D92EFCBF65D7EDA6DD80FF5CF8D4F8FD2298
      88D4FA28AEADCF78FB5F7F87255DBDE424F645B2B8A6535EB30DEB74696D5CB3
      016B1EC5B3241009AEFAD7DFB7B760C57AC54BBAB75FB209FF875380FFDAF0B2
      B868FBF7F3F9A41F87F46E4EBEDF2808EF5EE8D6FF7EFF3988463EFC97D25AF5
      C66360873063D8210C5DDCA737E92781677DF0B2B1DA685B2F995E07697AF792
      4302994B8BAB25C300D6A4D76BD41F750E7D78AF6E79B1384AE3D0E3CD3A6EFD
      31AFD697A7C9FF01AEFC7E2E46B1B0BEBC933B0D0162FF8A931ED1C40B20A1DF
      2FACEF3CF3FAB48371507882FBB873AB2F3F37EB7D301A67F4FEFDE2EA55F8FF
      A4F787130822F58447A1F2834F205FBFF94227903FA1F57C94D32FAEDB7E0106
      D9E95431B47A8797B516EEB38E4EE4A6DD4EB7EA663CC5E537CF137E70B78A12
      9C965371EF0F891097F26EB7F26EB7E2EE8B997A72150E3BED76C5BD3B3F8A7E
      22AE77D5C6BB5548EAB4ABA0B6739878FD60B02BDFA10A0B9D4EAB6281B75E98
      0503797BAB72FBF5AAE7FF14882CF2E04BC1EF0082B98A2BABB377AC8200CCCF
      1DA464E59DF2E017EE94875E779CAA1BD5A9976FCC4FBCEE54CA7275E4E55BD5
      71D79D4AE1A3CEBB7CE3C259D79D46F5FDCBC0543A6820DBCABBE54997EF2E9C
      72DD69556FB9BEECC98B47DC72EFA7EEA2E8CF8FB8E5DE4FDAE53BE511B7EAF7
      D375E9C6FC885BF5FB89BA74AB3AE256FD7E6A2ADDA880CC5BADDF4F4CA5BB6F
      83B9D9A9E0F84530B3584508D32DDDAA5B0AF095B728D0B69C8A7B8AA0E57B24
      547983AD2A95A00857BE4F83B455A563E54C52DD93130CDDD8A8BC711116254A
      69B59A5537160E916F2C9F5FAB4ADE16CF4F3E71F1E8DACE8398206B9FEAF0DA
      CE83F89FBA491E5FDB7D10F39377150FB0ED3E88F7C93BD511B6DD07B11E7957
      81EFB4DD07F11D79E32D903A4DE77E72502A78CE71E0B6FB4922BF4D02D569BA
      F71385BE2BE73570DFFD44A1EF532085BBEE270B7DD78220819BEF278DFCE622
      6DC0ADF71387BEB5709470E3FDC4913F73F1284B96D11314C5D23A5FAF331697
      719EA23E9616FA4A4DF2D6C69CA7A8958B6B3D51BF2CADF5F5AAE6ED3D3E83DE
      5934879DAF43AAC555BE12A5687BC585DCA7205569A1AF374F4ACB3CD95229AD
      F644A42AADF524FBA5B4D25351EA9607C47DB836464E0E8552A5351EAE9EC935
      248F2A2E527FB8BEC68B14857E69A1872B70BC9042A6D2220FD7E8789112772A
      ADF470154FAEA4D1E8F6D61EAEF5F15A05342AADF3702550BED3225F2ABAB9EA
      4F1076A575BE5ED81597693C852F95167A8AB02B2DF44461575AEB897CA9B4D6
      13855D69AD67107645CF66E3AB855D6995A708BBE242CD276A50F9425F2FEC4A
      CB3C59D895567BBA0695AFF52461575AE959845DD19DDD7C8A0695AFF2F57CAA
      B84CEBAB51EAD6BE5A5F8F54A5659EC8A74A6B3D05A56E6FF0A91A54BED233F0
      A962FCA2F5386FD6ADF847EBF1AEADE2EDED477BB9161778A4BBEBD606DA5FE9
      FB2AADF1956EB0D21A5FE9112BADF104E75831F8D4FE6A3E535AE529C2ABB850
      E7891A51BED0D7F399D2324F165EA5D59EAE11E56B3D89CF94567A2A9FA18D0E
      E2304EB27EF8D75E227CBB37825389EC5E3F9C09FBF6576EB359FC127EBDEB6B
      5E007F5BB2C4C2D70BD7562C51F1405EC2713BC52FE1D7BBBEB6FFBABD855FE3
      EF4B1659F8DA2E7F992FB2F46BBD48D7957F800FF487AEFB2038DB78D87FC614
      9EC1786AE92876EABA3D9DC3C3E93B8E0D76247F8CA6F88BA5EE9C7A530BB6F8
      EFD0EA8581DD4BE0BFD4735AF06FE8827E918693599839BDEBC01F64E1D44B7A
      D7893785FB3CF8BAE7A5532F9C8E3DFC10CD26BDA1E7CDB2B8E7F9FF9AA55982
      061B2C082F1BE23F41E64D6DEBF75E14FF1BD02E9EC499B07EEBA5D93C14E958
      88ECB7D5BD442FC9C2C11828217570F39E8CD37B043A4FE561C1CB64095F66DF
      0FDDC128097CFA229A16FE26C1DD4B237193C132E9BF877132F132F8344D8238
      09B2B96D7DC4AF30BF085E2675CA70E83B364103FFEDE3CE1CF88D7F3E0A1EF1
      2C030888505C89D07E30747A5E1FC0622368C010AA004DBF477F5D800A7DBC14
      4914C0D7AD6AF8E02F780AB0BB54F871644B60C1C35378AB4BA7B9146A5D0B71
      274903BFD36975DA76D31A0B0F73AB2C07C922755F1E8CCED7801140918311B6
      BD0848F8FB3240DE0DBE5BC07315F05A8F049E2BB1B0FEF2E073BF067C6EFB2E
      2C84BF3E1E784B70AFAEC0D77E24F8EACC92E1A56129CFF7832CB81270752A26
      C138F07D11C12FB3083E8A193CB1B0A6631D33E8AC4F5EE28D009463EB348E28
      99EBCFF08A59EA38F04F125FFBBD2C1966E9CF819F8DDFD6E197293C2874EC8E
      FC98E41F87A1FAFB30D39FFAFA53829F06FDA907CC153E0CF9431F760E82867F
      66F3A980ABD22B9164A060C0A77EE227EA67287FF6E5CF44FEF447A1FEA4BE1B
      CB9F57D67D8C1E76FB22AC7E758CDE71EE3873E6F6D685D70F85469766015D50
      E5A860C1B750DECE79AFBD9CF12E6714889F8CE2F8331E5C9690F13682FFA898
      AB7504EAA37EED5611CBAB185EE9A56173F2B5E5BB955EFB9E97751FF7B26EF9
      65DBF7BFACDB5E0A61C957AA5FB5C043F4CBD61FF7B275FDB2A9D37919EEFB08
      426168342A8804B64B7F7D0649E5744AAAD0227426691C29ED884FB15B798A43
      BB7C78B3B03718BA0B6854CD89178E05185F82C7A81EECDA7790E8D2473B5FFB
      ECD3380CE36BE197DE21755F48337C94A67C375E3C1B56B87731D045704986BA
      F3B3E8EFEAD372ABD1C4A53D2C9C18561DE0978B94FC607CB9F8F0DE3A8A7DC1
      6755D69FF479A020BFE93A2DF8D7E9D45DF8E1B6817D6737754CC1CA6E1ACD0E
      48DE9B66A38B97B41A0E5ED2AEBB7849C76D34F86EBC048EBD4DCBD8DD2E5EE4
      385D14FB376055BA7899536F37E8BA46ABD97A66E6200178077360603E0B2628
      5DCC6D3CF6343E258255B74CF81A2F1A5F87175FC1FFDD920028BDF93D2F5B12
      5B6EB3F28D83DB8C27586039B79557F736933D99003AA441AA1F592DD6179EB7
      B8EF6A463E0DF773565A2D8917F7F3F0D5077AF5CEDD727E41C2DF0F30F7D6E3
      CEB3248E46D237F667A09434CB509DFB8D3EF2EF62320DBD4C04BED3763A9D76
      B7E3B4F8CF64FCF4E8DF6838004EA13E46EAF3BF06B6FA10C94F431209F29734
      F3401B075D9D7F9B7A0321FF021ABB8832FB37FE2D03FAE97D673BBDD97EBDEB
      D4ADFF8520E2A7CD267D91C081536D14E2F7B01F7884EFC17EBD85C4DF862FFF
      35905B432EE4124B801F166DFBB9B77205AF1BC14738B587EE2B5EB61FB7623F
      4EA351DE107D012BE34FF4873D784368B5BFD496E8A8DCEEF2A372EC8ABDB928
      138A7BA32FE011F8F3517B7BD0CE1000ABDB5BA7B3B037FC02F7063F9F7F6F95
      3B53A7FE9C7B837FCB7BA32FE011F873857BABDA19ECF9ABF7D6A82F3010FA02
      1E823F5FC1DEEED9196A31957BC302ADD2DEE80B7808FE7CFD7BBB6B67ED1662
      7A696F6DE625F873A3F7D66A2C7012FA021E813F73A186912F0B16C2CF81DF6D
      B66DDB6DFCBE5CB4BB75AC12B61B1B27DA17CEB828DC5FC509BF9068574C7C73
      90F6F944FB2B545B562BDA57AAB6BC16D1FE126ACB6B17ED4F515B365CB4DFAD
      B6B41778C93725DA17445A59B82F15ED6EBDD56ABACD0AD9EE34BB9D6ECB69B8
      1B20DBF1D81F62B8BF8A237E4ED9FE4A3C116B92EDB9487F7D7B7B69D9AEF6BE
      86BDAD53B6EB6DBFD0DE8C6C7FB59CC4C8F687CB76C776BA6EABE1D6970BF77D
      60426EC3AE373B46B81BE16E84BB11EE46B8BF02066284BB11EE0F11EE6EAB0D
      F2BDDE5D2EDCBB4D07786CAB6B0C7723DB8D6C37B2DDC8F6D7C0408C6C37B2FD
      21B2BDD544E1DDAA32DC9B4EA7DBB5DDB631DC8D7037C2DD087723DC5F030331
      C2DD08F7070877B7E3DAF5BAEDB81521F76EDB6E62D71223DB8D6C37B2DDC876
      23DB5F010331B2DDC8F607C87610EB8D56D7695638E5F7B119B9DDACB71AB691
      EE46BA1BE96EA4BB91EEAF808118E96EA4FB43A47BBDD3A83B5DBB4ABA37DD7A
      DD69B54DCCDD087723DC8D7037C2FD55301023DC8D707F88706FDADD66A7DD72
      2A847BABDE68B75B6D7B13AADC8D70DF44B435C2DD087723DC8D7037C2FDF985
      7BBB811D6C5AAD0AE1EEDA982EDFEE38C62F6FA4BB91EE46BA1BE9FE1A188891
      EE46BA3F44BA77EBF566CBAE5736A8EBB4DD66A76B9AD818E16E84BB11EE46B8
      BF0A066284BB11EE0F10EE8D8EDBAD775BCD8A0E75CD8EDB6AB4DB6EC3C87623
      DB8D6C37B2DDC8F657C0408C6C37B2FD21B2BD5B77BBED965B9150E7749C86DD
      EE34BAA616CE087723DC8D7037C2FD35301023DC8D707F80706FBA4EA3E3345B
      768570EF76DDBAEDB49B26A1CE087723DC8D7037C2FD35301023DC8D707F8870
      EFD65BF576C3AD4AA86B76E0453A2D23DC8D7037C2DD087723DC5F050331C2DD
      08F70708F796DBB01B2DB75B1172DF775AED66A3D569DAC62FFFF4AD9821AFCF
      25D0F5CECC905733E4D5087423D08D405702BDDE721CA7DBE854B8E2EBF56EA3
      D16A1879FEDC676CAC7563AD1B6BDD58EB46B81BE1FE62C2BD596F38CD66A76A
      580C58EBED86DD6D3B46BA1BE96EA4BB91EE46BABF060662A4BB91EE0F91EEDD
      56BD5B6F36AADAD2390DB7DB45D018E96EA4BB91EE46BA1BE9FE1A188891EE46
      BA3F40BAB79B6DA7516FD72B22ED8DAED368D6BB9DA58D6BEC1C2CF663A1F220
      40B8F09F7DB008048410BC7F928583716F38481DABE70D49B48759C25F15C1F2
      5831FF945D3DFEAC718BCE43B7B87C8328E017CEBD3228BFC65DBA4FDBE53D3A
      C072FD66F5BBAC3F71978FD706EC42A2C5AA76D978DA2EBF422F587A922F9866
      81BB6C3E6D975FA1213C065F9F43AFC35DB69EB6CBAFD0159E892A1FACE1E12E
      DB4FDCE5E3B58697E63DC4F11676D979DA2E495D78A4FED069B5BAAD76BD7296
      6CBDD1E836DAAD674FC37FA47EFF30F7C086380758B77FA1BCBD57A9F6DEA9D2
      3F5FDEDE5AF6768F736041B57BD9BCBDD7E31CD86887D5939D03AFD861F5E2CE
      81353AACD6E91C786987D5D708F7AEEDC21F1B95C364DBADBADD68DBCFD1B4FE
      F6A9FFA1A4FBA23667A4BB91EE9BBC3723DD8D7437D2FD554BF74EB7E174BBCD
      AADE77AE53773BF54EA7F10C8D6D8D7037C2DD087723DC37606F46B81BE1FE6D
      08F756B3DDA99A48E3B661E54EF73972F68C6C37B2DDC87623DB37606F46B61B
      D9FE0DC8F66EA3DD6E388D6645CC7DBFE1D4DBAD7AABFD0CD3E68C7037C2DD08
      7723DC37606F46B81BE1FE2D08F776A7031BAF57C5DC1B8D76DD6E3ACF3191C6
      087723DC8D7037C27D03F66684BB11EEDF8070776CDBEEB61C38D88A7479B7D9
      6E82803796BB11EE46B81BE16E84BB11EE46B86F8C70771A8E63371A557E79A7
      D169D9ED56D336E2DD887723DE8D7837E2DD887723DE3745BC837CEF763B8EDB
      AEB0DD9B0DDBB15B9D86F1CC1BE96EA4BB91EE46BA1BE96EA4FBC6487717ACF7
      B6EB544DA869D69B4EABDB6D19E96EA4BB91EE46BA1BE96EA4BB91EE1B23DD5B
      8DA6E336BB15B63B98F5ED66A3694ADD8D7037C2DD087723DC8D7037C27D6384
      BB6B3BF047A7AA1ECE69B4ED6EA351D1C4DE487723DD8D7437D2DD487723DD8D
      747F8DD2DDB1BBDD66DDA99C3F07C2BD5BAFC3C91BF16EC4BB11EF46BC1BF16E
      C4BB11EF9B22DE3B9D4ED3711B55C3E33165DE75DDEE330C9031D2DD487723DD
      8D74DF80BD19E96EA4FBB720DDEB76A70902DEAD92EE0ED8EDCD46B7E118DFFC
      5DA77CFF46CC483823D18D447FC57B3312DD48F46F42A23B9DAE6B372AFBD339
      CD46A7E1B6DCAE91E84FA54D63B01BF16EC4FB66ECCD887723DEBF09F1DE68C2
      7F20BD2BC4BB6B771B76C7768C3FDE887723DE8D7837E2DD887723DE3747BCB7
      DADDA6ED56F69FADB7DC7AD3E918E17ED719DFBF11E38D37F2DCC8F357BC3723
      CF8D3CFF16E479A3516FB7DA6DB7A26B0D79E3EB4D177E1889FE44DA34E6BA11
      EF46BC6FC6DE8C7837E2FD9B10EF1DA75DAF77EB768578AFB79C66075EC54877
      23DD8D7437D2DD487723DD8D74DF14E9DEEAD6DB609A5755B63B7510FDCD76D3
      CC7137D2DD487723DD8D7437D2DD48F78D91EE6D1CF3EA34BACD2AD73C30D8AE
      EDBAA66FCD9DA77CFF464CB0DD487423D15FF1DE8C443712FD9B90E8F596E33A
      8E5BE58D77DC2688FB4EC7B58D447F226D1A83DD887723DE37636F46BC1BF1FE
      4D88F74EABD969B41A15B9F120DEBBAD8EEB361C3302CE887723DE8D7837E2DD
      887723DE3745BC779C76BBDB68B895E2BDD1B61DDBB54D65BB11EF46BC1BF16E
      C4BB11EF46BC6F9078EFB41ACD4E65325DB769B7DAAE6B6C7723DC8D7037C2DD
      087723DC8D70DF18E1EED61BDD6EBDB20ECE69B84DDB6E351C63BB1BF16EC4BB
      11EF46BC1BF16EC4FBC688F766A7E18280A8E862D3E9749CB6E3B68D7037C2DD
      087723DC8D7037C2DD08F78D11EE5DB7E5B4DA76ABC2766F3A28DADB2DE39937
      D2DD487723DD8D7437D2DD48F74D91EEDD7AA36DBBF5765543F98EDDB5DBAE53
      373D6C8C7437D2DD487723DD8D7437D27D63A47BBBEE827D5E65BBB7ED6EBD53
      6F19E16E84BB11EE46B81BE16E84BB11EE9B22DC5D34DB6DA7D9AC9C05D7AE77
      9C46DD38E68D7437D2DD487723DD8D7437D27D73A47BC36EB88D6EBD6A907BA7
      69B7DC76DDE4D419E16E84BB11EE46B81BE16E84FBC608F766ABDE6836DB5563
      5F5DBBD368820AD035B6BB11EF46BC1BF16EC4BB11EF46BC6F8A78775C90EE4E
      A7DBF91DFEFE67FA36BE124912F802D608C56FA5AF74B05EA5E295FE3A8867B0
      955E983A9AB6176ECC5D05CB6F541E845BB7292564F96DF5E5B7E5C57ECB6F6B
      2CBFADDB68B71B0E2835CBEF6A563CCCB19D6EB7E3B86D3CE66537B62A36D771
      ED7ADD762A1ED7AE789CDB6AC303EBDDE577752AEE6A354162B65AF5E577752B
      EED2ED8A2B8EDBAE3A6FA76EC319743A6EC503750BA55B27A73A2856DC578128
      9D6EA3055852AFBAAD0251607FAD6EAB5D85954E05A2B4EA2DC771BA8D4ED589
      3B15B80287D0E8384D22DA65B755604ABBD9761AF576BD59715B15AAE8D49A8A
      FB2A90054052EFD69B0DA7E2B66ED5A9C35D75D85CD529E8A1160BB7353A2EE0
      73AB59B13DB70A57F4AC8C8AFB2A70A55EEF34EA4ED7AEA020B792A9A8EE5F55
      A7EE56A08B839CB6DE70BB55CCAF8AB3E8F15E15F755A04BAB596F38CD66A782
      F6DC0A746976EB2DE0EC6E05B6B89D4A62D7AD532AEEAC622F7AF4780577AFC0
      172076E0B84DB7E200EB15F882D2A7DB6E55DE56812E8062363CAD5E7DEEF52A
      8CB19D06501F70B38AFB2AF0050EA16DDB6EABE220EA55E80262C16D35AA586E
      BD4A0C694DA0E2BE7625B937ED6EB3D36E55F0897A057B69776D17F49246D539
      54614BBDD5EE366DD0242A847A05B638604E759A8EDBA8804BA3025D4032375A
      5DA7D9AD3AF64615C2348057B7DA6DB74AFBA84097AE5B6F8198AE20F6462573
      C1EA47BB51A51034AAB0C585FD756CA74ADB69B42AC9DD0136E8B8CD6EBBE2CE
      0AFED26D770059ECCA17AD545DD408E38AFB2AF0A5DB4422AA40966605B2B45C
      D053814534AB0EBD59258C804D341C78CF8A436F566AB82A43A6E2BE4ADE62DB
      DD16CA878AFBAAD04597CA56DCD7647B201157593FB47EFB125D46F175F4D7DF
      091BFEDC9B8EA6F43D7EE805F08FDD0B326F8A1CDCEE25F05FDA87FF3C04AFBA
      C2A9B8829F93063E2E481F1AED6EC7B6DBF4B9D36975DA3622EF64E265E34F09
      FF3C8DA30CF48B493FB97C1B8005263F9CCF60D1493AF1C2F034F1C0469BF841
      3A3D1643A737093F78C988AE4DF4275F0CFFF700FE769D78D377648991D36C12
      44D9FB60021F222F99C3273CED201AC6B8796F968DE3C4BA807F5230EDAC9368
      148A042E88A722F1B2A57F1A24022CC0496F9EC041C3F3E246CF9F3BADDE3871
      F061A4DA20A8EFB80411004E290DE208AF163E7C49F652140FA7DE48A4CD2EFF
      721D273E689E5DE2BBF0FB60EC2569D7EE103DAADFAF4169074DD9E545F105E8
      186E266194F2C1D247C71A67D9F4FB376FD2C1584CBCF4607B6B120C92388D87
      D9C1209EBC8987C36020DEE033DFB8B65DA74F93F0F7DF7B530FC0710DEA31A0
      187D1E3BAD4EBDD39B00EC4386327C4AF4A74C7FEAD3A7D12CCB4402E89225A9
      18641650E275E0C7D7832C097BC32CEAFFABE789C8F7E3412F83A3BE9C000EA7
      367F1EC6092049164423A7E7C7519C09309EFD749E0E016D1C8074388FA3AB49
      6817FE0A66F2C8F7320F9E9C0C615530BAA30C16BCF2C200BE17000FA7978EE3
      EB6908D6FB380E7D34D601ED47519C88497023FC01AC8EC63CA0F5950822BAF3
      069F82B7C107A031400C070EE12684D78BE722825D899B693A4EB208BE9EC166
      C3743AE8F9111C4294F6FD3E7C4BEE02D8D20CF60D1B4BC71E9031A0D87F70EF
      FE6842C80C1FC674A10326BF3FBA2A7C864B8311BB81F12FA5DFC6F86A0EDD80
      1FD01309EFE3457EEF2A10D79741E43BF4291D78212D371DF5133F190BCF971F
      87719CF5D26938CFAEA320127834FAF3389B00B5A453D844188D33CFFF176CAB
      374B4598F5BD30EAC17FF0053CA407B7C01306F0DB35FD021F926C94F4C20808
      1B762E6009F8749D20DBE9A59137CDE21170AC201A88308485C2F87A18881048
      D887E57B70E174160D7060AB97069E5E05594A026F2CD94A2F12D7B0609ACDE1
      AF293C6394C4D7F0CAF130C8F03D2384773607B0239784BFC3BB46C06BB2B437
      14F86E221457F0F5E0269D92BB04B8840F47788DDF0B3C526F38008AC297F686
      74F10CD032EC8DE90A845B06ACD14BE0CA6C70E511A8327859BC6998203CF08B
      2B2FBBE9DFF42E93689AA491C87A030FE811F02D04305A88380110E3D4CB2C78
      2D8E23FCB9770D783C9C64C320043AB2DC06C83A247F6044B34464E324CE3238
      D25E100EE38937F0B24118CDA6687C6509BC90D543AAF32D457FC0B6237163F7
      F0E445326FDB9D1E9EBCFC086F92DEE007007F341689A0BBF1163C24F44ED16A
      62E8018A0FE00089802D922411FC29BC02E29A46B34132C12FD07986BFB3730C
      0333D368EC4523943751769379D601F32B75B30BE78CB7C3CB7ED5FD75F804D2
      EFABEE6DC0A7F0E14FDE2DDFDD7CF893FBD6CEEF55CBB408000F7E8DBB966AD3
      420F3B88BBD6E93CD70B751FF24288F34B5702E19300AF0ABD20B2246EF7FE0D
      4493AB21A04301C7A67FFB48FBC0E63DFE090207B018EF400541A22F3094A917
      4EC71E7E886693DE90AEEEC5334278F2D6DA3DE075B33403563BCEE03111B961
      958E040B7A05DD06949E2C1C8C7BC301C85B60137550E7DAF033755D606CB039
      C7769BF4EE7C918DB290AE6AF5E822BCA66E771CFA30148E5DAFF7064878F445
      342DFC2D9AE25F01EAA547F6E169363EB1D1293DA7D7EF0DC12CECE11F7AB0F5
      F1E2A3E8E3252810203CEB2DFD0CFA1AD493C2267BA8761437FDF3D8CBBE4B2D
      60C0169CCCCD891F6456E3C03E68FC2F446560407C72AB3B33E751675605C17A
      6BF1A4340C014095307C0CE4DECE46435037520927D6EF297290A3BAE6E265D4
      B2CBC7AB62E34F7DA35E18C39A80B93DBF4F1F404E04F894BAD5FBAEDFEE8168
      FC7DC9719642F10F3ED7856829DEFB80930ED3E5E78BB73FE884F978DDC60204
      F968D1BE7C220CB7B7FE0486B1B56F9D820571065AD11568FAD6513C9D5B5E6A
      29032DB5865E10C2BF70D1871F4E4E370B07FED4EEBAB8C330984E856F211307
      3C46FA47332DF4E6563CB4FAB0D0656A810E6AA5B3FE3EFFBA59FB84B3ECD875
      D8A93744DD6B100A0F39E49E95C613412C0FCCA4D0271D1DCE328927D6F1FBA3
      D49A000440DDB3C2D8F3AD6C2C82C4C24C9B1810736E25609D836567C1BF092A
      57F3CD82C99F3A2E42E4F4ACFEBD75180DC02801A3F540A413EB7F5A9F6234B8
      E3F812F8317D1509400FB0D22FAD0FB11F8062EF5BDE741AE24F7F06A43BB2FE
      7978B4BDB5691068207D7F96E7781D64630B960135DE877D01D94FDE1DA716DA
      6148F18825EAC8E1E119E8DD481D9A11BC09A27F011A087FF3C0D02444F8F813
      FCAB48C3F2717F93381273A08214A946245E2A9026A6D64800DD64C9C6617CB3
      095B3C2CF100CB0F07D1ECD2230680B8BE670540E3C4043FC2F7FB17F175049B
      4E2E45665DC12DE978D376DD623A6F7C6F1DB34C3EEB23A65AE4BCB0768E4FCF
      DEEE229ACF425FA3B375157816EA8071F2EE78D336DC7660C35FA6E82562C97C
      8EF91E0310DE61081B07399E5ABF00407EDDB88D21FE5E9C9C37B4765E27F984
      9E0E2B8B41148176F2C11BC15E4F86433C63C9DC366CA35DBB0B1B651B4422A6
      1FCF7093DE34068D319E8E594D1989087DBCC0AEDF9F9D5D484E857BB4C01A05
      198DC9351BB779A78152E9E3E107D4B758E4A0A479F7F1F48C04718A47DD8703
      4727364A62D04180355BA988D240E6356DD6865BB0E1E3CF4AE9244D546B5578
      CC87C904A8183550FE74E8FB48C348DAA7F5371F7FDAB80D77A55DF1F9E4F4F3
      9EF53E882E61D39FE318F8F111867C4AE73C234EE65BD763C076E0CFA88996EF
      41234C580374BCA0FEB149C0D8DEDA490468D4B841B0AF8E8314F17D17E003C2
      38B4E0F511ABF1B4E1C8BF0356175E7B733AFA8120BD1C653850C0C9F9FB5C13
      2750119826B13F03B611A4C427F1A261E88DBE2128FD82E2E057EBE4F8DD3111
      C8C9F9D149897CF83EAB76723325F5D46A58FD390AC6FE0C558019DC63D71860
      C92C2295A8763416834B22AF130A91D4F0A19B67DEEEF0F6FA73D066AF4488F1
      4004D947346680B41887DE452032222F2461835B26FDF01CB43D20273F14496A
      FC5F771FC549E483100EAD7340B0007E222481625708B62700EAE5DD48EF2200
      0780259D4D891289AC96830C500EE85200297A3ED8A0071284AC080DBC08A541
      2250A92104FE7D712F2EED6591E21ACF4472F2A5CF4FF0750EC48DB8F5FC65B0
      A43A92E782A605B0A398038A43B4D7570C827DC13048D7B177C00D4466B0BC45
      726098D2DDD0FAE72C185C22A21A36C46CE8ED9C2907053C331422206FE524F4
      6F3C19012FF03D7A5F8741885EC7E91AE84913D31EA837A02965630FB833BC8F
      B5839A5480E1B044C0EB26C06DD8B44C77016A61887C3860B60EF7A52264CD2A
      609DF303EB9CE7423A1BC895A808F65D86CA2858B169208D763257278056C114
      BEC0E7A77B9638181DACF1647CEF3A1ACD8060C8FBEB27DE288EFA7112E1AFAB
      3F2905BB8B715060814A200EE2491FD8D39A0402123E9A216BC0DF9D54080040
      185FEFAE4B1C3C2EAEFEC02877511CAC2ECE5D37716E13E77E8938B7FBBAE3DC
      7F6A35D01BF519DF0E986B442208D96B7F36DAAC93DEDEFA53AB89BE53F2ED5B
      8B4E8CEFA52B24B528EF935D1E1E7C394219FDC68A392A42E218EDB0F3A3B3F7
      E4460E360DE5010C78A43FE306290F9122B43278B9670126E361EF03320F2EF1
      2FA0849C5092A97508BACD3401FD05E3E09E4509B437D90C2CD4898866AC21A1
      97312545A770D310933B018E5E18649B16166CB5105A4727EFDF5BB03D7BCFA6
      B83F6816E9749604F12C051D8FEC71045431514086BE5528F160D3F6DDB635B1
      1C7B136F2460E3183B12143B4AAD4990861E2818A1F0F350C4C66D1239C23B4E
      FEB6DE5D7C48D5E96A872AA801C08105055152660B181AB564763F9C73000049
      366EE31855F9611CA7B8C793F34F9CC203C6C9288967D38D63696DCCD5381C00
      DDA53F0571E89165753D46734D46018916E368086C2D435B379BA5E5B3DDAC2D
      A338EB3A9242DF9C9EB55BBF52FA196E9398155647C0068129796CB6A24134F0
      66A9B0E05DFC74E04DD13A0A61B7082B0E2625625F44182FE67892A523ACD177
      D966C107A083A48D9530686F038BF2AE04276FF1272F086770F418F8490496A3
      50EC0418590A463D0876F848E8B46988011BA73C80F93446FCFE5978D3BF1F7F
      3CFCF0F7C32898305DC0DFC4F7D65B8F8ACB06D6FEDFF133FFB2697BED6086E2
      05681B530FCCFB3EBCDD0093545803013E7D8DDA3D72B6BE07EA5E7F9665C8B2
      8321FDFD3A88FCF81A3D2E591C5B5487B671E959AD2E85C739FFE13D9E213080
      7868D58E0596B101B59FFC7B164CAD8B60226A0A21305E17FB320B64E336DC46
      7DCC8B28B5653A4517DB2009A6A091CC52E27EA18754BB679DCFD32F5910E2A7
      2CA14F1820F8990E1D2E8E826CD348BB6DA398AB1DA14AA97C8E35AD5D5B7E2C
      528C82333FB3009DD54516F92E13B05D80FF6FDAA61DDCB447CCD8BA2A087790
      4F58D8C7F988A1C8366E632E6AD8D7498C149BF8605453CA0AA6F620C77A8F1F
      80603F7C39BFD8B89D39922D7FB8F8F8C1A2523FDCCAE7C3A313696922D7BD4E
      820C0B6FC9353B8B2281478CC9D380B29320629DCDA684848DE3CB6D17CDC6F7
      67C73FA0990DE48A0A07EF3411602F88086D44693203B17EFC023A1B1CFF2C4A
      441A875794B4F716F9B74C35DE3C08D45D4AA7B8B68EFE6101C7BA82FDD28624
      02E02E40E9429C67F2F529E109D8B54CEA4306DF179C5D4B796CE499D9343860
      A5481D736C29018B1C2AAC9A4CAC8032F70037645EAD8F59360C1CC5CA39BB8B
      6E0983083418915D63060097057B21710A9D963B8B40CAC11214CADB2C300190
      505F2737A895E266583BA3281B2739EAA21ACEF51AC60330E140120C66099053
      568CB54DE24DF344B4EBA8D61C4EFAC168166494D7787E394F820900E09F2001
      8046861454D4A9331BB3B346F5CE3E1D026FD8E09DA16672A4E8FA500AEC85DD
      0125132B2B90F2115E39055B74BA61548ACCAC895A8BE65F922861B7F01BE798
      A6D2F1823BD57C8A0BE182889391E15A6E9108F7C9C454F440002B1437D28609
      368C82AB52307529C971294E4E3AC1C4BB04211F7B096248B4EF8D46C0BBD38D
      CBD1AECE3F1D245E3AA66299C39F3EC8BCDB24F0B0D18A25FC11A5DECA945B12
      F0F815CAB93DCA3F45046234B1D22C4EF21C0ABA8EB54A00E3775882175F0281
      599EC59E5C4C0CC6B44D7E2E56AB5044026FC3D46850BC50BFFA56A0FC9348E6
      94D1743E8EAF8FA48F933DD9409E73F271865CAB48F56A0391645860AFDCA11B
      66065703E2475D9FB7C35AB3F55F56C7B67775699E273D7E9CBCEB5BA53A02CE
      06974A39EB18A49A23EA8CB00FAB2C75F330F8C59F370B701560DBDEC2001665
      CA53E283CC8AE76A588000FE652A1264F948A656ED88A286C2BA886BD67496B1
      B3AD7827932E5BB6541D4BE6ED3701AC62787820FDED51A0EBA0C9C04B2F034A
      95FF36362C6BAB281E8C7F0AA24C8C0417DC0CE174330BB4EE09B65FCA751D62
      3341B43FDDDEC2FE4B96A05A41E9779D1319C21BA396EFA1236ED334BF6A0E04
      6C44B35C0E2BED61A49C541C6B42C60D471CD25998297146E199BE4054CA8D5D
      4978B308C3155AB5FA56E054328625AF465B58197B39A864494F417BCE2FC7DF
      6A47A06CFA09DAC4C39A45D14BF2291017DFC4A07415C864E268AA13472741DA
      1763F2ABE08695F82216047F4B199FC8FFBB694E93BBEA999A6FCECF4F7EB5DE
      9E9DFD03248FF00663DCE8F9A793F769D173444DC6C8ADB6615B5F5E9674E10F
      4F98CD1EBC07897A0AC6E36791C6332C5242B60B429C190B5591C80057A2AE60
      2DB92FB8A46BB300024C64394848E5B57E399C65F1AF16C744E8D053452392BD
      1475B79D6B5C9F0C2F945454152B76370B2015E0E0541D5DDC572C0FA6E00208
      1B4C0CF826F6AABA69DC52EC51F1D8DE22C139A54E35493C05FAB846E9A00407
      EA2505AD64B30052490D713205990A20592210D342F2C7619A0A4C7394C6F85C
      A6F8A9963E403013A59744DE15969163BB07716DF29FEF3EBC0F4104427823D5
      B4B52741D75F771234E65A917BBE906B757171F216FB8870A7E525C1CDDADB50
      00999E519B6150D76A9B85137F6AB5BBE51DFFF4EEFC1D197D9F8E3EBCCDA50B
      587DF0D3DF3873F74F6D17E393E96C380C6E3865C20B55D22EFA3AD09FCD06FE
      A66DACEE6875A0A610D4716A8AADD78EBDCCDB3F0DBD515A2B3711A1C441FC75
      7B8B1A590116FFC861494A9CA362F800B8DC9108434A36DA30A40698D4DF9C7E
      FCE9570B776FD90811B423AC09288FB0D9F3411287E1C66E8AC209B5CF18059E
      88734A8AFA94C4E85D48AC9BF313EB44B5CBB0DEC7A39AE55D7941B8797EF0CF
      6CE2B01F2EEFB9667D02DB07D4C07374D9920D3C9C61BD02E605163AB2A19891
      CDFAB0527EB3B68EFE7DCC55C46A500BCC5E6E17F013686798C93B9B4416377C
      DE30FDE39CBD857E3090AE8C5994B2F57F3EEB738F2AEB3049BCF986EDABE0AD
      E00A91938F473FA2B2FD0F60C994E08316C9866DEA90FC2A5E9A06A348D90E32
      7D27D9C47662D8F906ED21B490BC41165CA19B117372A6AA866030B638293EE5
      0075866D1E540B488BAA7DA88B75614BD8C8FE856B8B6DDB795055F133EAC1FB
      0F2A9FC632E6E7DAE4E9E9E9AA375914162BDF6FC7B6CDA1BEC0267755C06E32
      F5D83148959FE71BE60D5B2C5AB5408EE8BA5539C2C4E2FE9DE4E7B2420AA3A8
      C8001A6F3FBEBBF870629A56DD7318A09180FE81DEB44FAAA1C42A61F6AA5BC5
      9C6357ECA9068B6AB49162B32AEAFD1C60E174AA21784D6DB2AFBFFF0A525B2E
      41FF489EB1C6133D63ABE809833E779D4AB4440F7A6981EDA5ABEF85930E56DF
      D265230968D5CAC53EA65FDC8796AF08299F77EF0FC54B83952B3E1964E71887
      C6E4D63F062E7AA3D0A0E26B4445628E9495FEC740C47F1B96F87AF110F9E21F
      0917BD7521A331F52BE073246B96B29813CA309D8C92C98CBDCFE87398520799
      1BF23B7958B6D60F3947E8B8D407941A4EFA22A3422F6A3C89D74C1371855DB2
      54BFA45D9C05655D7B29A53A53D1411816C3789E6C4533E033C00A614C8FC61B
      E470A93D4B25F1F942B668C48E0F933ED79CE90A6339AB0B0098E2242AEE8753
      0E0462053A35CC90D546DCFB9E5287AF45820B797E3E2E805E045F1D6B1AF206
      DCD4789433BAD9FB21412473ACAA0AC0A88DAC6CF53AB7627840C2FD5D77CB9D
      BD0376F35113DA65302B40061FBE6253B884036BB389E90828191A70ADD0FB35
      CA30A0AFBABFBA05B79571477D8D3BAAF9BADD511F63E4DE38894E0DA25B833B
      0A391E55C320B1E6A449BC888B3CD470BCD537E9DFDE7A3CBD3E6B5362669354
      DFCB3CF53C9E85D691172491CCE8F005B6F3E90378B879F146D2E9CA15CB539C
      56528DF8ABD0A7C3EBED2DACD461EC5E447FC0753C6E12864AA6EF709942C242
      D58BE6D9586614D065BB6B525DBFA1B6D5AE695B7D0FE4FE11EF9F0646D597AA
      BE2AB707FD789652DFB0F452F6E8F1289007B4A926D53096C91A042C4C22250B
      3569EEC3F6C9CB12114718757E03F77FF2E69FBCB03CE800F5DAE2B083BB97B6
      FAA024831E0C97061341D1EC09687863D08BFD38F2787223D6FAD399EE612E7E
      828D05FC40D678532FCC4122785E0E9C34BF281EC7541C0C403EEFC08BE20AFC
      B2BB345DEECBFFC8157DC16BC3DFB97741C873D6548301FE23771954022E8BA7
      B2AB0DA8EB11C396668F6105FEB030FBC19068055EFE002A7BF22916A052FD14
      F8223691F89C5C81E1D71828358577E529518F464332A5688C493CA516E8FF27
      9E5DCCC09AC2F2206A7F4EB428C76F72D07F001480EF804549F96919C4362313
      5EC2086DBDEE6AA13FB5EAF99801557EF14980327C825367A7383DDD729AED4D
      ABC9A62A286C367BA89A8570DF55B06CBD11096992AFFF9C891475D19F3E1C1E
      DFD1CD4EDDC4034DA997CF6681A35CA2BEBD9517A9336B4CC444A02E955A3BB3
      E8DA8BE0CA70BEAB2AB335DB655768100593E03F85AEDBE465F480D90EC23895
      A97BD8D72F4E947F125B986F58F942753B889F958B35C55A6D320E410A71E78B
      EC3A1870454750B82605CC8A7C1CC72E5DAFEC3C8E747F165C83A62122AE1E70
      CF6FF4AE5297EFF12CC3A2E06F057CBF50F9CF9768868E6ED97D078B0F41C6BF
      FD707CC1BD56E368849A3236DBE30E23575E125015420AA867EDC8DE09B2DF06
      08FC3ABBC337AC3ABE1A4A38E0DD9BA6B241B6644D4852A8CCEF10EC78EA0BF1
      B7375412881FB016A5D04B6397DCCB331CF59877D20A92C16C0224495D5DF3EE
      2E585340F5D6AA259EAEB74E55672942F6D0DBB86652D570AE1D0B31A5610488
      6567B243602DEF0E34A034E642CC678015EBAA549DCE001BBAA9346DD5C39AD8
      5E24C7F3027EEAA92BA4DFA2ADB761DD14EFE4866C9BAEDC93F82E42745DB9F7
      F052CC95A5F213C852714D9C5D0EE62EBA08B085C151968434A2390CA65CD17A
      4ABD60C11AD2C378744F2A58150BE46AB2A0E7DBC0905FA8A8ECF8F0E2905AFA
      1F5E7C4658B100D8AC1DDEA113486F1276A4107B74CEC180A6375458B4D4ACCF
      B3FA218D7A807F90A18014DC01C6813D1FD3B1E7DBD7F0EFDCAFCB1651C87E6F
      364CC055F4FF38E77E612B67186B8923C1E1AD63A36BC868944AAB72AD9E9C7F
      A086A984BFC004D8793905E239E3EEC33ABF41A5365076443EA976477744CA12
      E1017FCCD797C9134257894B55306F46074FFF368865E5C80336F30756637676
      574E2D2A1DC2CB5321B0F65D6A54AA7512578FC9169E84159BE7A1A86A9EC6CD
      8C82118F0EC19E46D8D2A830732200C581D452D438B0C73CBB47276CA8173A88
      7181FA46B6F9A9EA1B9657A9FF4C0A396CFD537CCD1DC3CE7F3CFBB2308F01D0
      64146D5EDB88DBBBDFDE527DD364FF0CAA6C4386CA232C256D648917A560A091
      A9AC88A5D0B43A9D0DC69B0E8A5B80008BF5F4FDF9853A7A38763F4879301CDD
      462EDACDDA752577389E4DC360808EC972EBB41F3E7FF9A45B4ACAC68A1E356A
      1F023684D2D35410B96CEAE70D834CE0A32AE7963D31804C4771E4D3E80713D4
      930ADF32D850A0BCD0A10F331BF94F9C312BBC14051866AB12979275EE968301
      6A1E36E3652A1C575896B919358F91CFCC89FBC03AD44D3016428A98A0C3A995
      F0328189F33D14DD65131BD6C0DE8A08E4A8A5DAF55B9FB0B316CE478123382E
      F1D73F3C49709CFB8C71B1F6B5D0AC2DA2F18E8409E5FE67C94CE8C46B198E08
      524500F0897AC388BDD253BD250F449F3BBF0C05D1FBD8E91CC80D74EF794E67
      8664EEEBA6E9453857FC48E5CEAB1987CCB37C314D044A6CDF9008934835BC76
      BE3BA42199A74198C91183EAAAEFF6ACEFBE44DCBD89228CDB5BC7ACE5599FF5
      8C3AB808FFF4DD671E2A597BE78B280375893CB06CD3D6942FFF3B3A1D74D205
      BE406F43DC4F635A5DF917707A004D9027B2025AF98EBB3863DE36BFD7776882
      F2EB1001E9DA079A29E05913B4D746E8A6203D939B3CE742E8434CB30558E491
      13A38F7E93C5A7289B9835C24052BB4CA3C499757E3C9851507B07278360CEF2
      34A41C180CF05066F21EF9A22920293C38550DF35D43DDF7E0EB2F38B1E65779
      28D4FD4D4FADD95BD2D69B31900E0FB38B68840FB686C396F8C2288E92055C90
      F72E05B04C9407831211889C10DD9192D07EE7B1D62AFB911B3D0354654298B8
      11A454FA52C1943117F8EB5417CFE85CB158D100FC4B4FDDB3E6F18C9E46B177
      A60F9CEC74303AF89A929B3F729E53FB75E739210D2F25E1EFAD2555372F5BD7
      727A56475C5F3E08EB00507A3D110AD8F92AAB7B2E4ECE1B04867F9E1FAD63D3
      9B45DF0F41DD154406CECF4FF0CC5E13DA56400076FD5268DB241018AC7D28D6
      E68AEC1A30F6F4E34F1A6375B5FCABC3D617DBFD19F1D87F1E1A647D20B2AE0B
      4F9538A4B7F86321A9122A0647EFC5D1B259B90E76CA0C05DF035F03DFE20F83
      A76AEF3FBC5F23A21ACFC182E740FBDDE4184F32E27F0E221F55656FAA5C77F8
      ED074C8FE03FEDA1AB804650041946A4B85854088EA4735184F6C0A79997C86E
      2958D0C9AB292782F19FDD974D843C0BC700923BF7B6C3CC20B646EC95B78645
      A8607FA035A40A6A079DF26E534D43168F043517221FFCCA3BE53EBECBDBB336
      087AB0585B5F87C5E7DDEF6D2F2DD7DA6718D354E96ECC9BA97897130A64DA1F
      5796E99C1FD5AD238E64D6C164829E7864986A7172ECAE1AC252BD459D6111C3
      720294D5866BED4B6524D85D12ECE42630390E055185590EEB105702CEE1958A
      2BAFD091C40F861494CEA49ABA83BC6769B8F0FDD9F10F027EF20CB45D647654
      1C229B05C2A5181C1E704E0616D85ADE10DF03995CAC063622D31C0651908E4D
      BEC6BDC77982E5905E68A89971FB1DA7FCE8863634B28541B4908554EEF52809
      8163A7EB6810275F5249D7F5E86BCA385C8BC22A18026BD839E08566890A2D0E
      2DEE1FA1BAAE0E66097240E05B814C510F861AB3B06900A623739D8734ADC378
      20136140732325908A8D2DCCE6F1B96543CE58F5C504FAF34C78933DFE9157EF
      169A38246214000DCEF3F41EEE4046AFC00BD1FC457C3423B8CA899B51050115
      7106F047B983EF520B6793D24D07BAFAC430DD2AEF198EBB9F6556BB65F82EF3
      DD63EC6E20939B49E213A3658C65641F0CB8E10865EE0F12E1A5DCDF6CA21A14
      23DD3807F64183B0163F35111F0763E397BADF2E939D1240597BF7F1F46C6120
      E41F1E3B3FE9BED0C82E0942AAB7448EACD811CA27DC2B5D8019C825BD954752
      1633F6B94D1FF0D71115F75D53674DD477B921E781B573415F917DBFBD85055D
      C984D68A00CB12CA0DD3FD15B259428D68E2E190D3EFF00B594F0ADFC9142FD5
      E7828B48B9BB2D169E66943FED65CA959C15AE654F42823DF9788B8022A8EEA3
      68A27EDB7D764950D19D884658C18049ABFF3850B5A76FF3DAEE77D130FEBE84
      6CF8A438E4E61A41627DC2B2D81DDD851CAFDC854B6476ABE56D6F65D201C22D
      8CC6624E49ACDCE27B4FD6890794237E1D2797EAD5C3B994807225BFF812D604
      9B8BE767CA8BC167584D1C60DA9C371807825E3248F7CAEF5FE87021A7E022D3
      4A7CD938A4B02D5E6F11EC319D46B16721957331A817EA3952C00C3C14B8A9A6
      AFAAE9CC785CEC0213E309036AA778989320E5F68EF006E52B411CA582A20000
      EE5424B2C189867DDE9F9B7AABE76F857A0BA2177A9A00B5728CDE2DEE625901
      27A534E60480F10AF274F1BA83BC9ACB3A7E77F8BED872844C3D423CF82FB852
      0D9A0BD0BDF2C2195A99BAE5105F4E68ADD104B61CABCA1CD6B98EFEA1342D79
      43A086C8EA9B40999329980554DF2D5692C983873FD39459106C07DC984F95F2
      52FD693185130B72C40D98C6229A297F9D9C505B1A0DAD02373934530D4E056D
      CC7FCEDD88053C5E52FE83419BEC3A969805E08AB9DF0BA124808A384B8E6F42
      B30075C335373B11FEEECADD88FB88828829ABEF12BEB7F2BD7E8C97EFB6B0D7
      C504AF0DDE2DB22AA4E2D59B712C2D577FBAEBDBB1518BEF0110B6E6F8C25633
      562C187598D561EE58C2F21AA7C97BA003502A8087B90852930A0AA357A404CB
      B84A477A8B2DEA498B6AAF943C3EE991B9A01793699C60C8EBE8E4FD7BD409B6
      B7582B90FDC60A4F3890B132DD2D85A7447FD0E5FEACE7A21D19E27C9BA27B0F
      753C12C6FA79EA25E268DF171438BBADD91E289F7488AAEF7CD137AD754DD4EE
      E0C904B2A52FA588B0806BBAF02377AD17DDE0C3EDAD193E64E191D81546F083
      F429A4ACE728FB2202FDE2F60B9092369D2553F4A7B3C2ACE0E3915F48D55246
      D4B8E68435FB536C80AB33473474288087CF6288A3636BC80A14E98EB217C781
      753A4B285870BBE22B2BA84BBACAABFCE0EDAD1C6E6C1A51C331B442D2BCF265
      11A2F02258E3028A1CB6341DC5522FE74218D00D5519D8B28D160A6792996AD4
      0FD72D3C23AFA211016D4F16D304D91A5CC2B087FCF5D6EC14A6D6A8CAD7B86A
      199B4361F51AD432CF70B128FA905B355157C933B2CCEE2F762E94399FDD2A73
      2EB86B89F7304720653DE5665068D52FE1023B85BE6D72DD3D750B77CF58BC89
      9F428DAC6810173E49DBFAF48E402BE47BB84526C51A6DE55A5696247BBC751B
      59D53C566419F577593492E52A9A6324035E2437B1568D6F7CA6E7F0F6676BD1
      EB6EE39CD1F0AA54E07EEABD39E87BAEF523205DB8DA1630AF5AC95B98133040
      093A5C7D4E161ED0AA531CDEACBC001031700D891C5AD460DF192CF7A75E3454
      2BEFE7E29A8F1E9D6C2B3EFBB7E787B0EAFAEC6276DC91C70E85715A321B2E4E
      CEEBAF96189E39BE0DEB826E41DAFCB50061ED954141E6852C3BC7F612E2860C
      4256ECB9EFDEE91987E54ECFDA2D7DC1EA3B81AE81CC34F40A599D6C94910195
      62EBBA204D673AF0A35A93FF31708BCD44CE0803B4483CEB2A0E06427513F770
      E6E1881A1B703643C9230D1AF1A7380CD2B1A2C8E62E702BEEFA56E8E42E40B2
      8B14A7BFC653D9CF9D8C12D40F49CC1935E9BEECA29B29F6C267ABC08485A5FC
      A4B693122685604B2141072D3D861D986F5E5FC693D0F4C1C63857017747978E
      897F60500C3BD9E0E426EB1058C131FA280C72DEE7E718C3CBD1D081F3A910FE
      5B9AA6659054396BD97CAE7D79679D4B13BA86B8B827D1B3C6E02BC1EEC1B3C7
      6ACA01B1901B5934CC03E984F4AEBC20A4E4319D4B508C7CF2CA3C0A8D531EA8
      F73B3A2317DBBF07936942133EB83115AAAE9803404E44ED7F38072C1E64AACB
      54C9D79070472C7A074F92AF0A225B3F8A706ABD9103EBE0C34771334B3FC43E
      7EFE21C87E9CF5E183EC760F9FD4B0C4377286E01B398250EF644DD4FB0DCD42
      75CC2C54338FEE25FA34755E779F269CDBE674AC7DAB7E5027E30989C1B686C0
      46296EC1FE5415E8217D998C55397E6762BD3B06CDBA9F08EF9273D0F613C145
      1970C51EB0DD042FDDB0B90000922E8EB2E38ECDC078111C684C5E17FDCD9F4F
      3EBD3F3C3AB13E9C1D9FBCB74EDFBD3FB13E1E7E389183EF366BC7D58356BC0C
      6396F83D5F20333845348829A2C97DAE2724C07383A8640D215A0D122FDDB446
      E81510C1E1316F00F7AF91B14C620CED49396CF931053E281510A0D06AF4830D
      4384AA4DBF17239C198749631405A1E2FFD9941D78360F89E3A967E46C182C76
      EEDEF0EDF30CBD8BA3D32F78AE9C7B9B17C2724945ED34A6B8FF97696DB3367D
      C7E8C07CFA43ED13263126683F826E9FB718D7951FD839729A593F9F9D7D2AE4
      076E16242A493E892FC503BD65CFEB4B5C4B60E28FE03125812438BF4865E714
      726C5165B3460107A6D5DC50D95D78D326DF5461B56CDAFCEEE24371888B470D
      A141F70BA27F81714B82BF58A8B1219BBE6B0265E085F1C8BA88A7C1A0C6C9EB
      3FC749E8830A3F1035EB07CEFC92B1FE2B6C649A225F0790889B295CBE5980A8
      0203973FCB86BF94CB7F4E9DAA3F8B01BA5324CBDB502D66F92C171A20899501
      E8260DD242EF7DE5255593D43C55AB21679B7134607B8BFC3D79BEC892AA83CD
      0254E5D81BF2BE29B34FAAB579C2E1C01B8C45A1D881872BCA2C456E782EF323
      BDE2F8D66F0436724AF710C78AC23697979EF8942FC86E7AC02878B67406728D
      AEC6B8881B63E7F34CC17C8C65892E1025AD564AC2DC2C20568050C51FD9564E
      1F51CCFD9C8A0720E8CAF50EB488D3B5B4D31B78E9EAFB06D2207A9EB5CB3E02
      F22CADE7B8DF451958B1894EE05E3930D44C3010A9567FA5DD6D36D2E32C831C
      1C2F32A13676D7BE9D5BD3783A0B3DAC4DC4BA018CB195C2418BC9BD2886A722
      9EAA0E5E532A4BD559F51E3682D8C7D24A3F8E646F9BDC0E82BB7C72F6C2D732
      0C6562C5F71C521ECD43DB42C6F3FA26625C4463CADCE6E0B08C31600857456F
      F78A715315B6BD0BAC79575230D9FA71C835F2E49044FC595B8BA66F28426A9B
      08E9C320F7511B817F782A3FB46A39506AF9D8AC3C27980ACA7C558C21267D41
      322B88B4C1846D1C8BE5185C8457AE4BC368043634C2E2F951E24D38F5EEC07A
      2BE736AB348EDA718C65591CBC8832D04465AD7C8DAFEBC737B92906AA7A84EA
      A25E7C38A38C525A3B95F753F3E32583C17087AA0E7FA72F061E868964D90CFC
      49369D59DB3030F75968CA6D57D294DB7E1E9ABAA0641E90004798C803668421
      ADB66E09797176A474BE42325528868BB954050CA508DE0E254B51341B30F632
      7768152E04C8EF2E168812E1803A3946E2F46E1F8E46E7D5A6151FC7337C91A3
      30185CAEBF33FE0A265A9D00B857EEBAD8DE52588278C76579E4AB92A573D235
      2AEBB0B5F74A8F4D0D7C30FA2542E20AC8C589C23CE579C5DA6EEC3953282A3B
      47FF81B5A3BC6500EC28CE76E500C8DB0B72351FFE351169166395F635D73172
      C313D904C61B79C1DAEC988DE1BD1C0F300C57E9327292A728CD2AD05D6F16D8
      27C6190AB591AB658887EF2FACBF58E77F085E7874F1F93D6CF674E59B25FF7F
      71C4AB285679ACF6C04FEB6B90069AB352B088D2ACB12BB20C8B5C0A314D2568
      285B50253FAB0808FC4CD13515A79449B226C8AD4B946AE015B9CA63C0A7E0A6
      C251721D3A06E44E89C063C13660913444F674A7845476AE13AA71C2F225E47D
      4650DE739CFF7F1C4F8C985462F23F31626AE28139ED258F1594084ADDC78EFB
      C8856B6AF62C058BBD67FD852867DF34CF7A752EB72FEFB00A6862E67C2BF263
      175394B79F4A4B5312FA334CC60069AD01476554734572D4E0853C72B2B75036
      4EE2D9886BF46B74478D6781613D95EA9A324F3331E1AF7682411CA916930BDE
      88DD5269D7B59C0B0694751578F4BD7A29CECF890A4D628A9D98EEBACCA2A22D
      9CFFE0716B51EC2C352C1BA819DEABBD89B0ED58F620E045691BAA4967F1511C
      94A0BB53EAD4990A3CEE4CA56ABCA7F8F68EEF2597083814A2008710BFC5FEB9
      BA2D2D5BAFC77099B5A3FEAAAE9637172FE60716F68F8F97216C0B767A8950C6
      DE0A4A1FE0EEB0B20370A94A8E46AE2114D42E40DF18734F34A501F051CAE539
      6E8F5BC5C494893035CCF7BA2B0959BC6BECFF856975A8660DE4CC666CB51ACF
      12C3A98A9C8A3CEDD70C3145A9DA40207859E98080BAD3E71667ACB4463E428F
      79482AAFA4B41AD2933163F7660A400F305B4D533E9DCE2E769678215A65B714
      36AF90E189ED2D0E50CC787A61300C301E20577AC32BECF28AD40230EF5DADB6
      D4A71EF47AC6167F293BE6E47E5BC5FE10DFA85B62886D8672D4C3349C996951
      7F1F56CA2A9725546B140CA5DF6777566D17D36B89B0154C659C4236BB8E47A3
      5026DF936B3708836CCEDD3DE5F5591C8792BEE54DD2750BD405A28EDDC120F6
      FA41241B55731C820F8DBAEAEC105DF1F9316DEABF1FC22A3BB7A84D87E37EA6
      FE1DF87639464CA8A5C214274795CB208BB9A003EC5C23699241213342F7A4E2
      93B1354FD7ED945EF74DF1E576D522F2F91210B97FC090F23D98FA23BCE0FEF1
      A7772C5A0CF52E11BAAACD22C8C332B48AEAAFAC0C012CC4193C284D41A28962
      F359EDC8A23F0CC184C024C75435CFF9BB0520FDFF143E2B89AD3A2D1EE82146
      613009323D5B4DCE8720AC5779407D801DBD1A9518C6649F8870414BC5B760D1
      9780AA557845209B8C5D684A7F3774F4009CA9FDE84DFAB36424929AF5014C23
      43493AB54543860053AB48BF941EAF8AC87CC11496431CE42A2869D08A257394
      DC5F3B7ABCD7AE9439586E4A35D8114049A4DF6F5669C0DA5B33745F776B86F7
      31B2B2FF104BDCAC93FDC19B88F7D8EF672718F2B89728DBB01610D85877B3DE
      D8F44D2BF1E70F38FC88BD94194ED5228582A47EA4E65C07A01AECFC8DB4065F
      00BBF5659EBBEC19453A783EFDB0D8492A05BE3D079D28CBFBB05103A8A25794
      B3058D7E715FFCF5FCBD72551BD45DF4E10F690683F6E4235A21BC50715F36FB
      62A7D03B15FF7620D2101B5E82261168DB1B5B9949C79827FBC28B85B5B51DAC
      BE402B8187C0A7BA93BA1C5B46AE6F6F7BCBAA9157AB86B5D259EE08A3CA509E
      9BC503A79074A6537523E5659DDCDCDC58547C7D609DDC78A4B2874171E0831A
      8771C144E661F7386DC6686F809A60319BE247B759B76A08C09A7EF51DDBA651
      64C7EC0D68D8DD967E6D7DCDE9892D2F3B393D3DDD55FBF4A4EB115F270B26A5
      EEF0FA4CF26618C03506190FAAE0415FECF4D38FC1780BFD558E69C317557FDC
      93079BA4C098825190A54A5B9433BB908D7D3CBBA02AE530E0F4398F6AF67D6C
      BA310922517CB417CD27F00C7DAA85EEFD182341E6C61D52C977CA03E338918E
      F44EB4E372AC1BE693CAB8267832050D055F61073924AAB3583AA03B46515A5F
      649DF5B199C0BBE33D35A085FA2E78F90E83E254B23DB01AFF07415F2312D8A5
      1457CA7B35E426E812342D62B06A235C1156C6016553DDB064F573C6DE8D2238
      1D78D13574C625D0EA712A0A39893409239198B13A195F51F9BA342E282FC102
      9B59795DE7FEA754CCFCF8A1107CE63C9E12041136059228019419808428929D
      EE36F000A84ADE879DA552BE199DD43CCB93541B59A34F0CB088F492AE8A6CD4
      A8240F9D9C6C349332B61720539C1F5598364BB38814A7C0D29DD58F24C2F6EF
      AF6044BD1C87BB9631F5C3B8DD7A2D33EAA9172E2B03C49C9085216CFC7C1AF7
      81F559CFDCA50C1539D358529FAA0F238DAFA8EDB17A4CCCF79CF498F9797003
      7C73C250E73F73CA8B1EC59B6AAE4BD5F85A51B84DF4F8B4DCEDCDBD4DA4CA3A
      8D031A078C2665348F2351E806A746D763C897477285717C89FAE39277C4274E
      66833187BE30A434E00928A5865314D8960DABD4FBBE853B31D28B83533C7819
      6F42A3CB611DEA3EC8D99F2943299163C286A8186663D5CFB378040C611FDE2F
      18CEA567329A73F3E62F1179E86B6AE82DED7B61EEAB112AF710C7E77C16F4DB
      B975E4511CD0C815962B65E014C7F5491B8F8D126A3B04CC6048491AF4155137
      2739715322B664A8F57D6156762264E61BDB51479F8FB4039E543424309A843E
      E0C772E6B32636783F0E19D1BA6C1BE1A0637A22AC09CC81E3BA98C796086006
      21754F40B30BC925B29A60532E0C9826CB3D26BA2C71BDCC23FE98DFEB820986
      0D174B4970923558D8C98C23E3F41E1A8E0B40E4EDCB4994980A4EF42E1FBC87
      9F8A452DB443CDC153EBDEF3919E8472552E3F53659AF77E431DB4F73BF13EDA
      BBF45614CD5D4E47E703869DCBD600A86664DCAB62080C09F48B598666727FC6
      B33D158793B9EDCA43A13831CD8D57FDE019854A5B8896C1B7884DCA89513072
      0E00D47C090292B201B9DCAC30701C16AE1D7B99A7764E542F6A8CADDE209B79
      215756F2426034D0D806AE3796EFAB25009CF3EDD793E97A55862DCDDF5EA769
      7B0C6F449B5E8332F2B7E2C0293F48111B5222B68124D6B541E33DD0E0EAA78A
      03447C2A7F2785A988DF799486698A0645E2974AD75ABD49AF61858198959776
      294811208A9092A24771EB04E5C2CA07B9ED1F7DDFFB0DB945EFF735383CFEC6
      8C4A6AB8942A9703C8688177C3EF03AC12ECA38E404E658D482844946713F486
      4A796B14C6B6EE7E304D626A5D1A17D4A7C2A8ED6A9DC59F912F5396BEC92082
      48F002CEA89DE02971BF2C3CA834F742738E13C558F4E8C2BCBAE2E8D3174CEF
      10854E46D26F472DD3736B0D95481C8583A10A7A0D0C5914820A867EAA0A9B0B
      3A3A1E8AD4DE419FAFBB864E96D30903479A3B4523879470AD707A7962AF328D
      0ABAA7555A49C6C4B47B5BAD2129ABD853DB8BEEEA966B10FEBE9E9534860A60
      8D37D194429AA611FB628ABF18FFF442D207B10319CD5425CEDA8BC8E11232D4
      644C1A7782F3BE733FDFE1C7F377D60EBAF4FA73303D412EA0332001730D2B35
      E4F592ABCB32A95477425669B1F901ED60B49B3B4867D782D3C679B154457AE0
      35E851EC5DDB456AA2CC54EB1316B0C5B3147B90A72AC59D83B763D0E0B7B7A8
      3739E5CDC2E68AC352B9A9377B110A10E14051E0A36A8BCA9B0E68D3A6F53BCB
      EC01695C96FF26594388B969F28A7258B9D0370B330DA8F4A57A3DB63754BF49
      BA544F83562366641595EC183C08BD142F83175187919BC5B027E9B941BF0088
      755505A46C63F2B386CAEC962F91B23784BA61D226BE43370876FEC6F2A320E2
      E4200A93AB227CDA84B2BE97C2E6ECDC94CDDFD75F86CE4F9DA8E1615A646306
      3E1677E6B967B790DEA2F6EC230FFD89E88994386852801F9702EC2C6FD0F96A
      7280B7B77E60C9A4CF7D5FF2394410198FA15C2952E62214707B79AB75748151
      79C41EA620880427674779CE0025F1C0B589EE46AFE25B34EBE760B390E9A70F
      87C76814E224DC8089259B4F85841C79F893C49BE744A4611947E1F6D61C8405
      6C93A6405FCE9360C246B987B14CAE91672F2F1F83F4F62A2F6D2E659544B33C
      743A664144194A392953A216D6A3C4D2655D92611B026A999A8E5AC712B4BC0D
      23F49B13F2553A1261FF2FE22B3B902FB3FAEE50A4715D739B63891F41CACA01
      426EC34EFC22F1A2148881622A8B87BEBDF520D2904C477217A52E516612CF06
      1871C5582AC40126025A67FD3000252CDAD3D1F93AAB6AEA57EA1F0352905326
      4BE8074F142108C7421DF804CBADA9DC2DC590BB7C41565B6F47C4F9150AAC20
      C23E357B9CE84DFD3381B6C319F59AD8DE8AE6EA680B10B276144C64391BC7A5
      CA00BA9F365E01653C6F68E63EDAD85571DAFC6F3C610E4366E1FC3611FDE195
      C6452DA110932D1000DA7CDA5A71DCA66BED9021B36FBDF7329C6BB85B705702
      A2C6A01A24DC1F6496AE23623698EE4BCBFCFBFF522FFEF73544CEAE49275FF1
      EEAB765CD8EFA2D47CBE1D63336EEE00B4E25DCFB261673D597B5E4E1BECD23F
      C05EE37A325E3221DEC3FA721F1567AE22A2A430492982A483E24A8B0A295556
      DF224A290D402A7DB938ED90AA994896A7B2FACBAB534ADDA2532B5F57B6F749
      7381CC2930B83A272B80AC62E553EFF79AF65818DF5B4A8DBBADEDD14EC8C784
      41AC628712EDA68CA8508273FDA7186891E21E793FFD4DFEFE07937AC629745F
      D5AB4420E30F5239D7B916BA835AD0F90957C5C4A1CFEA68B112BC447E4CA7A8
      D98E22245FE31C7AA473687994E8D53887E0E9FD6000DA1BA872ADCD3A5B4CC0
      4211B54F6269C3DEFD3F02AC4782BABD596FEE7B5190CA577737EBD545340A37
      F5DD8741B4B1701F620ACD66BEFA4880CA1E6DE6AB27425CF29BD737EBCDC7B3
      68E4258182FB86314810EB61B0A138F32F6FEA6DAC4C05F3FA5A8C3615F4D338
      974D1B86F1E844988D668C379B07F96496A61A6B9CCD7A77303B36562D48AF85
      BFA9EF9ECD924BFDEE0DE36628B819CE4F8C43E1251D0ACBBD70AFC6A1B0D4C8
      329411E7D5E18D52F8B9DD32E4F292E4527FEDE4B27A4AD9489FFE3165555053
      5E1970C28C5E4D2B5480CBED80294862180F339E77B71A5E504BE57121884F79
      CC94F19D8373079B36C0572A7ACF75E9AA2859A73023415A5E1FAEDAC5A2659A
      4E3057D51BA5F3B0766485486AD5BE501E40E9CFDFD796152B6340904A9B760B
      F9D91CD8D47D6C31C4892DA60B99EB18E1E414BADBAFA1B212A622E2F4198F27
      27E0E8340401C636571D4FFC653055D1D95FD710A64FC580FB15C8F13DD47118
      1B87A85913B28F5EA09B03DF415539E564375DA705FF3A9DBA0B3FDC76A3033F
      EAAD56037E349A1D1B7E341B5DBCA4D570F09276DDC54B3A6EA3C177E325409E
      6D5AC6EE76F122C7E9DA7895E3C275F8B3DE6ED0758D56B3F5A2E4BA82399445
      4C90B096FAD4DF30A7417E7589CDC9E3E86F2DF89FE1733AE3BD30D184929AAD
      09BC2E62F46BCD3E79DE9A6A62E0B0F1A050DAB5C3ED3A570C00C4CB750C964E
      A3EFB23D9926097206B195A7F878D8C3A128430AA892E7AFD0CC1DEEB989E92D
      A0510F84CCDA2AA4F580ECF1451260391D894125324D52C6FD0A1C290F0A6086
      73B50B9D7A4909C32EB89C83A5342DF8A676C212A066EDC0C71A6938DA94A441
      54B9123CA41CD7626298C6733DFD6932A19A046CE3B59E84CCF0FBFF526FFCF7
      257D2F5E18E00772300F77824BB3A0380B4836A42016925E07198D192AA6CE15
      92D37822186596179AE152D22CD8E593291DDE48946B3AF5DD5A85FE7D7B6BC5
      29A198ECF7F70330A6D6C0A3B9BA456F3E78AFE07129E684D979BABEEA619ADE
      BA06B933D5D470DEA2E1BC0F1B0291E75E1AD65B64BDA5617BF9A8BDA5A5D8E4
      735804A7EAC4AB8618E5FC38955C847B7F27B3081B7448B6ABCB7CE5788ED270
      80A2AE328457C23163CB1F8E36EC2C92E38FE483A99B8294249C10BC436EF9D3
      B386AC7D396BB7D405B857CAEB95A495515F2B713310C0C2A4F571B05B789F12
      30384B988B316E67FC534DFA20115E261BDBE1FEC80ED79D4FA8769C927965C9
      F81F2B9937F7533CB2F9F5334220373AD75124C075FB079638181DAC7AEB9C13
      FB7FA58655098855D48770473FA20D592EA05AE17B16F28B50B0CEA609C71769
      90140C18DD8476398BBA96E30883B4A8C2644C9864F530F961E99A175A83711C
      0C28C17E2D26E4BA53EC29EAC2DD41B57B34076A61C6425EE8C44D23BE96D11B
      E5A5E23C96158D1AFD453ABD6EC3A6DC93A5D88E65094F40D1B3BCF2866A5819
      99A7493C4ABC896C75B6232BBA72FB657DD6CBAA4D4774B1952A21D76D3D6F6F
      ADDA84DB95B16C2E18937367588AEEE5684761216CF1B510C92E749D4A0925E1
      3A44320C20715731B0E6ACA3E2505CBD44364EE2D9687C373795BD35557FA394
      9156C8C67B8BC00AAAE549F08C308BE26C0D96368BA372A46F41A06545F6B183
      CC00BD47850AEADBCD9196440DB36555FD52268EC2B84F0655C126D8C1739926
      419CD0B866AC845CEE57D92DC8CFD5170D978A85D7C169D650274D47B9DE8D97
      FC9353D5767A3DC5D3DB5B0F289FFE468BA7D781F14B8AA7574F046BD87A694A
      09B254F4F65CA36AABC640D168FBBD35B4D0564C611DE83FA5490449DEA1A324
      7F50C2A89EFD65A713B675A59E8BB2F30768B838BC605E7444BD4217CBCB5AB4
      7738DC184C7B9CE6E18B7490047DAD950D572F89B6B7D6DB70693DAEA8EDADE3
      C41BC5513F4EA2C7A2CB73BAA1F4C825EA28940557229CEF95D5C83BB53E9EB4
      527602532C5DA972A4ACAFBC0DCAF4FB1BF8DFC3C4F8F3525F1A4F04AB2F32C3
      8D498C262D5B3BB727B0EE96A7CAAC011111522B273D6931AC3D576725BD8064
      1073215B87959EBDB5B01F4C415E47303EF70790800AB1193F0D2C6AA8A1AE94
      C5855EAD507037703B7D0C889E531D42366277EBF6CAAD01E325BE37C43DB244
      04EF697ABE143322F3A212091C2B125E52D1A39F32AEB1533CA6BA14675D8026
      286394E4F4D19E9A923FCFE406BF3087E6AC7905FCEF2D59B62AC1CE7F1D955A
      F8E9EEE7DF73A3BE5B9DFA4AF72ED1E8CA0B38F90247F32408C360505E817A95
      DDBAB3D5B46DC7DAF97271BADFD935C4C9C4F933E68ABCE698EA736A3BDB5B79
      4C558D0ED4DC4421CAADA975C08D0C4F79E97A03DBFEDEB67FB5DE7A83CB5112
      CF80A1E35C39917C6FFD227323249B3938BFF8FCEEE30FE7BF4A5A7F28673094
      CE1D6A5FB9C3E9B933F1A901246595EC59340B434DE4E0FE97719657B21AE27E
      29E2CE1D4A3AC3A9828AAD1D8AE72B94D93552FB2E5A967E658C63FEC1089B63
      F454A81010655BAA8F39F73ECF3B921BE9BD22E9DD582EBD0BCE64914E7EB54E
      D1C12847AEEDD00CB6EF0FBBA79DFADBD35345DE8F59EE6BD8C763D63FA76423
      399DD10C39BF8303ADC193FEDFF0BF95BBC0B6B7F25A26E031A454143CE98619
      BD0266E4B8CBA9FB687A2659C3854833A0F0690507212EF5238541ACE3FC70D7
      A88F6CE4C04704BC851490008B88FCD030D0925734BC0D1E62A57D9CAD9888EB
      24C8329CB2988F7E27E40474F4B02210DD9EBAA33F8E07F4683CD324C086F7C4
      6FF2C17FC5F93402B31A397AEADDEEBEAF5CFCE70543698F2EBE38396F60ED8E
      9A5BF3F1A7E20E16EB912992C88D38681CB09C41038B34DF9C9F9FC8F29F469E
      C02B9759B93B6A1ACE001EE9417693AD23F0A480A26AE4FD58F0841855761144
      70AE00D77C42AD943A8517DFD5636A2518F1BC6EDFC8F93DA1C0316AEA9C9644
      1D5F16DEF896F4920CF1F504B064873885857B6A8C8F4A4E59B53505CAE61A52
      0270F7ABDF69B8869DEAA2B6D2E4920C13B1785E09324A99187272FEC11A861E
      7506922595C150AA75938047D116D2258A5961257EF8352DD25E16F8DC17CDC3
      F574AB346A9E06DF58CEC12BE994D67862A7B41786E16F28267BBFDF49B22F56
      A6B85928E54A945A757EC497A90F74FD60A6FA9C8C661FC5CA33F446C4377AAE
      B3C1B5160E07BEB2EA7C3A6743D0F2022FB48EDF1F215F83457C8CA62B46B65F
      14949B857F8D35E19FE211FFF7A7CFEB42420A9AFDF4B9D4E2B361FDF4793350
      B3C907774489D271641D85B3BE54D15E0043D7B0C1166F50A91A58AF4BDBDB8C
      B76F1FC846F7D17ED50EFEF006FEBBA1E5CF28050595421ADA3C2C9A7054B2CD
      F85B9C1BCAA571D2418E561C5B857124B8152235E1FDF78C2AEE275E9AE5E505
      6AB0680844E3CF8B090EACABE6B7158694F2638224CDE4B44C6415D7B8D292A3
      95C3F7A6B330E497A3DA90209283B6F1FA3E20C92568C4C63376377EE0B0DF0F
      7C0EBACED0F2410AC7A6AABCE822BB051CA20945463BBAF8535E873535659F07
      36D0A2180EB571F2126C84A5FE26E9D3E3B6B24C4DE99E551BC4D339DA840707
      0784DD3576B50593208473C111982495D2DDDC5B57F0D169C79D320CB9F52DBA
      E8B88ED443BB535C0580024CDC92E6E6F14C4E8C5EA0577EB172EB59B4620771
      389B440C12F2589F113BD91905DA9625A7202CE5A50042D92707DB8CD1586865
      C51217DADDD3862F7E7ACF26F0CEB0EC2881ABC8A92B9F443EC412C0799EDF69
      9C4CDE1D5B9F12310C6E8A06F255C00DCED411C86C7B602FB045D8AB8450447D
      7065E90F65894A88A9B53EC8FBC961A38C7209281E9C4D295CF4E787A95FBEC0
      F3F39F118391B02EC5BE2C185F937B0700FC5DC66D41C4E032AF613B2D118D3A
      0E66F04A74C85BF45FA9783D98E8C603F477F2212FE2AAEAB24CF0FFE5E057D5
      5D0765E02FFFFDAB6E81F97F00E5C91FA37A427B579CCE4B8E142C0EF3B1FC2E
      15598AB72EBC905AE5389EE1FD47F05E9728258FB224FCCB4944F5BAF8CAFC9E
      7104AF9C699E920B42EAB55C6ABB350863D9BD82B90EEFE3EC1FEA8114FDD4BC
      A776B4C82F40EA0A0013D8A03ADF99685C9338F9D6E7A5F63979DB257C1F1ADC
      0E361990E41B4D8CD44D36952DB2B13176D1FDF4807742D24F040604D2026305
      DE948889C0928FD50E21DF48C17D4681403899EFCE350491DBA58A06AC711C92
      3C39BAF8FC9ECEC267F41C207A7E67843B0BF74342E098ABCFBE1296B9F8A55E
      E107AAB52BF1B1A117A63971B05F1F356E7E220BAD3D5E58F5671E8BD087275C
      B3A42C7115668C38267A9AE5F1FC0FB262157E5A3F00979F72646C07DE1AB8FF
      3C14BBB29196DE1E1633ACAD51E4C610D9E90CB9304A1A15AA3A188D63382419
      AB3444C44424A19267B5AB8006CE759F73B1E78EECA02855B519B02EC2491E79
      4E7D7B030A0ECF41D8F9A82C8C3DA974C9E5B564D20AED10E50F0D91976BD1B4
      82C2DBC03D419AED1557A1AF31217714C5054173C26F27098AE43FCB5CBEF9CB
      BB3C208A2AC59DEF65E8A902538E4AD6499CA00E053C8B58566A88AA4C543960
      D01D620D81A26689ECC5AC050EE02B377792F34A62B4B782896CA389978D624A
      DE4042B442B007914CF09BA2E135056D39B78EE0717035A980599CE976456380
      64AAC44DF9C8F672DB359AB346C86F4B5DADAE05F6934D65291D8FAC613C40B2
      02A5508CD890A54DA8A6147B647AB11586FA7CE4510F2CFD6C5D98AFBF62385D
      7B739492193E944143101B8884B21876D0A3748DC383A3D1AECED024ADDE9379
      72CA181CCBFE4C7D31F0741739EA8FADAC4709A61499583C8B329DCB42ED01A8
      E154AA1C61BB07D6DB39AE495BA2B7A456B17A0D627D514C67081603EC0DCC80
      608ACA7BB0BD457DBD86A00364A0A967528AB3D92E5F57754C47D55AE0BBA0E2
      216DEC2B54D7296767CCE58FB3E912F851BB0264D9F89ABC5F09A9BCE5B734DD
      63209A00D54FE9FB63C8E56B82A5040BCA61016498610F4DB9839459BB4C2F4A
      E3109375B02B02A613C9BE6878D3E20EE481F4B7B7E6051C24D38A78329AEB93
      690650F4AE8211A39476717027344CD89EB3F3A3764AC63ED94178B77EBBDA41
      414F933D41C87783F74D6340588DEFE80E4574070B8E9AD5472C70E4381F8400
      2E047CEABB54BA5DE5FBC2B6B19D7D10E5E6600E1D423782087E8F8FA2AD50EE
      14A07224B6B7F423E9D519D411F6D9A4D3BA6B6B44DF13EF12BDBF19B305E1A5
      73E99F853D104F5CC8E3D963B214CA7585E6B03CAC2C5667B870C8AC830E114B
      6087DE08A98F572190E507082B10BE1151200359387753ECFD30272E13F1F982
      A7D288D342A6382523E609B9E460A294412591F6A447A3129CBA2C535252FE2D
      919272CECA5044A4DDEBE9ED95903C50424F62EE0E49C9744A70169D95F93374
      73D2DC77BB67A531F973907BFB01B6670772133753352F2088FC00E42E2ADC25
      9A93FEDD20E18E91519616BD61D44E4A729182DF136FA4E00FF08C0013410352
      B955359B7E424112CC41404CD839CEB94DCAAF46EC543AD590D35E7900BA7E68
      26C7DC87CC271182E9CD719092BF12E1F95910B3D6076CA83E8FDD941AA2CAC6
      BE3F112E2BA4462A64870C51862F018BED6D09D4395CF78A0A2D28E5B348FB53
      40FC29AC46E525A735991F7D5DD29D6F459458421ADCBFCF84543DEB0CAADF46
      75198FCBAE638BF34A63A571158CC9483A344A233530F26E7157C03C1AE3EA50
      7F295F402CD3AFF57C1A74FE6F6FA9B85FEDA8FCFC8383835A4E35819AC19413
      E81E3E13A50245D22882F2214F875EA6D80FE301AACB521E73A0851FBA20CAE1
      31A954CE6519828A4284F3C5600C532D4EC5A484DBA84CBB27341CB3343F0DEC
      1F0C97A4AC8887717C49452618F7CDF98DD7E7ADC0972108D0CCAA4BC329D526
      E58E34A8FE82D057D6E9EE8155C5C8B8479ADAD0D52DB6E6DD7D047B051B924A
      C53042E7515E051A648BE72067262CF2CF205D3805B53C00006C95802DE2485A
      692AE1E0964214CAD341F6A9238164BCC718BDEACF32911BA20A7052D392F34F
      F9C5F0ECD8F6548A1187DEF22E72726159B6D2A7D6BA19431163E405B439B00E
      C97244BB2648260AB155B84CA34B19D768CF7D9AF5B2BDC5B9DD521D5B40227D
      254F6035FCFF1E3EB7003EC3FC733D6711B390DAD27C2C7121ED8B701F25458E
      F5E296EAFE91FD1A85F4086467340CB7C81ADE45A948B2036DE6486FD42446A7
      0EBC0C05CBAEA35BEC0438DCD12C49E1CF5FA6D61BF5F9982CABA3CF476979FC
      2E3A2674FFDAC24AE7E36098FD85DF410D9CF2B2426A99E2EB2457C8B3212F0E
      869CCC3694F92992F7D0A383E1F265B6B790C31DDE8ADC63ACFFF3917A6399C1
      517ACF63FAAE10B82826D2D133CB3144E94D52AD6875F21C3E46BE723EF159A6
      CFC997A128E2842AF3F20DA6FC1480023608BE0EA43B33DF60A104858B4CAE3D
      1C1FCA065AA4BDC3271E2C5BEAF7C04D1AF131981BF055C5268B99A3CF95FD4C
      89A2DEB0903A4AE9A4C3BAD5FBAEDF7E255526CD275699BC386BD19906FBD661
      41307F3CBBD05999DA7C4287B00C624BC4D1C95E9A3B71089B5A7D1E6C16B25C
      70DADEBE75B6A884A83C5A4919A500C2866DF23C9E25038187BDA86B2DEE9255
      6D1D1AC96329E5D6DA9849B1BDF5EE581EBC74E25334A2A8E8157049C299C71E
      1426A2D0C3E5FBA97759945A1B0265004A9F01B18FD2A008569D0FBD57A61B6A
      22B5896403874FB176EBFD19EF1683E8F2B80BA2AD28BE74F25F1E909FA8CAEC
      7C4ECE2D1C28E4A4A20DACC7D82ADC2A24AEF1A4324A5CFDFE6BAAD916E1E93E
      6F1991BB58EE00D6E0BD02CB6934BE5E62D1CD0F1559417855917540CBBC12C9
      75C8D5B5FB8B25B1A57EE2795EC704E3E2091AE7C0979E83C6568513E86EB1DE
      62C503EC15792A7A3AC460564A40BFD6214DCAE1C40430D0DEE82E5069A3B9CE
      42D5B9CE5443B1488F72C49597DF8054B8BDA5AE2FAF3554F183A56BC9906C79
      A97CA18B71D1F194AA90342F8522968E140742C20A5CC96FCCC1DC1C24755CA9
      22593C1A49A70E796AA41B634242565B29B0D381204B09A78360C22107B9F952
      2DD627F12C4F697C2B11A29C46D0E71C2A9FDA10A9631F0557D4AD09F3A91779
      B5F218914307C3D38CAB18661289312A1E6954B45EBB51F1A9E459FC283D8BB2
      F981B6F4B59DCD391E72763CCD6A59705AE8806BE16F72919D4910CDD23C4B6F
      77C3D42782D05129CB27669E27D520B94F74F663B23D48030C2413249473340C
      A6FD187132F7F692DED5E7DC2F51A89EFB48AD79FC2033CC54A911CBFCBFB7DD
      B85499B1B7CCBDAD5CBC855A945B2EEE2A6F1C47EA712594747C7C0770E788A3
      39433DC4380F2C6A9F3671601D89A75DA8107C617D8CD22C868F0B311AF5F2E5
      CA143CAB11554A29BF7624AE31CD879C577A717211956EE42AB5720D90717657
      35A9291FB40975AA7CF305B810F52C744E2A8DF5F2B427F5F674F97CB142402F
      959A0986DB64CDB10A447994B4977B6F35B2CB12AB625890CB1E797204772653
      D3C454C96344831DC722D41E8C334C08BCB54399F67B25AA37C7D7F0A03872BD
      29D26575BB50B22843C1E48359FE243F2693A82F38A318BDEF55FE667A8ACE8B
      17D8F42D4FE5F768CC53C96B61A8BD2AAD47E63B9BCC8645019C7262BB97E691
      73A4C09CF2307A83B939568D32BE2BB20D16062A94C3E9C3AA048342F934A749
      705CAD20421703D9D2A9856492962B3D73679E52B788921795098F12E27411A5
      9ED358CA9B35F4740FE250CCCD10D413098A239705B47B4E9A2A85AD73325282
      4C278D44AA3741AE0D2F13C1ECDAA5F8EB1ACBB1368640A83D990A7A1BDA783C
      6D707F370ACA03FEBF148914F2A96E4BA0454BF33EDBB2583703D7CA91DA51CC
      990589EE6151CCA9823F95AD485E7519E5EACDEA3729E49CAB77A97806BE5E91
      AAEF4FD22BBFD5601CC7B42E5BC9A564F7199D1447D4D4E329ED429BB73AEB42
      356A28D6269ACACE075476E2D19ECB1332DC2477C42FC2A6CC01D06A9C53579E
      3C5F2BCFA9C98D2E8DFB2AE760F5B30E6E6D64E76677F5AD470D2DDE03A04378
      736CBC523EAC9A21C9651D3F2A80C5B98413D863B09F27C4E7D3787FB9F95511
      E2DDED3F9A07D6914C0BE4AA129F73EC335A901C2B949560A5134CBB4E7879B7
      D44DA7FA35C882D4634072B651CA4BAAC8D7E7F4FC5B1B2FEA2D153EDF3D5D46
      5C326ED54329528B9BE4B9A985C474AF5FDE1777119479DCB7F7130693803586
      3C8B73C91B633483EBB231D0A91DD35781B744DFBA0320617029647CDBF0987B
      C8E8B39E0AC15DEA7E211C9D86E2D7DC44CB51C2F09E823AC02DB1964129A7BD
      1D5D0C7997D550AAF6D85D32B2A3E0BAA2DA7E5032A8DC5CC51189C9C1039610
      1568D8E2C07A878B65B384C709E1FD34CA43A47ACA87F661C1C3FDC41B8D145B
      60AEA6A76AC8FA106B80B573D2F745B9C8F44D5ACAF34AE03925BEA14C223686
      A8D89C3A99E56DC4A6490CC09A14FCFF0A9679135066FC0C7E85AE779FC36256
      3641417A22A62241BF3E95DBDF71A2D496A3D07749A53DE2B8692279DD994D1D
      B4348854B52D8668F9511C35200B49B57E347CEA5E3EA544ADFC99A208A06E0E
      8627314FE226292A690721430917CB1A56BEAC79B1CFB5E0F29CD6D0A7121B51
      60840D89BCA4F9D08BF19022F9768AF07E948DE1B80E8552350E435989A27B86
      C83634AC99A0DF4655FCA6945F150C4B4B1702F8F45CCDC423E5AD1978A97465
      14BB8DF0CDAABD15F76FC65E075C86A37AAAE80BBD44AE2FB971808E53C26299
      266B78CB7D7616B5D2E4960B32B1C2F014E629583B368827134EE18FC8FD0892
      9D5AB2E6BD7FA4CF6DEC49A19AB7AF90692A5852506AAA43D8BD5368E22A2F0C
      A82386984C63D8F83C6F0677ED71487516817D20E910F3BEB1AFAACFAD6B384F
      6ACCF903BBB2680B1B28294506EB1BB0764E80B9028A83379DAA3EE49A4256CC
      2709F18E0956E700CC35CCBD25AF29A50C7914FC8FF66335BD63477FFA1B8F79
      E382E63D4B7FEF878374CF3A3A4A774BC9C938198213539780BA4758B462406F
      6F2D82FA7B0FE768ECF5717AD4DE000737AE7CA6460E7ADD39AA9407F8006072
      6A3515854EBC3910CF209C616B2F7540B977DD8880BB4FA3768E392F5F22CAB4
      B37E0CA2AC062C651A7A0391E6C6498D9C4C883F35E9773272A2D09469191091
      49CB208CB48BCE647F969D986A89E5AE773946CCE946329D1C5363677235D584
      0FD434E55B736C0B3382332ADAEFA3E08115C7F0D45C6DE210D62CF265F5C28F
      DEA43F4BB02BDF076A51A11A159078904F928968D8D30976C369539801958B3B
      79A5921A472ABF9EDA38042A5F4B778A99A5D8B2893A912EF68A59BAC42FFFFD
      AB8215AD869317B1EE8AE423D7613A4DD9A822951211BE47B724B006C003B48C
      287598E377F82E511CFF47E8BB35E08C6AF810B313C387ECC854153796E046C2
      046AE407860F289F7C6D01643B6F816477159C6A92FC17ABE477FC82AB3D4B66
      4227F75776DA961AA3EAC2286B0A26D547B5A372E6B9C12656C2A8BE8A587685
      AF69E8E181A98D00B09247CFE03FE37FA9C7FB32D727F95E0985BD4C70903888
      F649D1A0628D9847EDBEC366BA381045EA74A99C80B2BB679D82CE98C989C984
      E381087DD9A4137BCFF0A2F95ADCB28F1A780319E168F2421FFBF342FC67D97B
      F0E2EC450AB19ADBF29378CA8D4050785237D4694C6D8841C8C9BADC1D41B11F
      72B9F07B1747DB8C67236C1CBDA35DB754F2C77D55BD511464B0DF5D8C1EF985
      EEB68622AB2892D99BCA38E5227D438C2A48B3043CA079528B26D43E97D16BB9
      2516799913F659202DEC4A0AC62EF3A9C54361408C04DC8C86ACDB7E22BC4BD9
      2E90FB6AA75C1E77CAB1050FB6AB1E86B12083E3F739E8B0D9B3EC626A905B69
      5AC847914DB25F183D67AA27B6EA91CE102B06BF06E340144C971A4376A1CBF4
      916A50FE3E06A44E6BC580248F50C2548B3B6F4D79C4195B6D7EB965F92F834C
      5D860F487F5577CB3FBEF3519A0CBCF022FE402EA79F0118EA8E3D2BBF1BBF2F
      FECEAB155392EBE5D7A47C4E0ABC0619C6188BE14165DC513D918F0DA258EADD
      5EC2DAD1E141B615D17FB35B08361EC8C2230EB19622AB59B1E5BABE61CF9233
      35C8854AEEA085479039AC321BB3621F5F59C72F1D9F19774166EB17F1212837
      54C4F21E3E94E21DC01406F144E8163F518C00D8DE2A562B955B5A155F81550F
      B63371C48A76BCE23AAA5F7DA124E91AEC7BEC4825559BBC354839B89A77B857
      1770AF75B91DEA929C78796C4753426163D324C6A124079638181D7030A7D038
      5E5E449519A1F0221A56C035B7317767C79BD10F8DE93D8404B481A1C6796A72
      CEE349E4F9098AEB2EF424A4D573AA23678957382E79507B55292D784D6D884D
      50C2E03F18D4DF91F3E635613260BDF9AEEA0B0F0F5489BA74EC7E1E98CECF4D
      F5AA8C317118482B3F68D5259EBB5E6E6FD12C8A2264AFBDC26BABD2D17C0CA1
      C2355866408129E0A3B341364BB0B1BC74E5EC509E8E6CC08F11FD4227484F7A
      F1F34695F2B9899800674B1771DBE333A386BEE4EE49B33826094F4DB967C8C7
      544A907591CF56C062E0594AFD333DED3B52399C91EEA101D4B0F45CC40DD59A
      B3064D3D432960513C5AB2564B275F2B8A33C2BE23897DE42E1337D8F103C15A
      6856CCAE35668704EEF702E44B8D415FFBE70CD597F32203E6C40FE61BA510A8
      CA5E2BB2C9DADBB9F5D64BC5673A809A6CB2497EE57E7CA34E53E69CA8D2C942
      BE17479D79181067A5607F737DC5CEDF2C322CB8C7877574F2FE3D9E0C8EE918
      222F18A84B77172864E13DF2EEA47BD65FF6AC7DDEFD9FAD4B314F178767C820
      2D008EAB4C0EC3B0B6A77FFB0844AA80F72EBA42CD4DA7BED74A5389B8AF794E
      689A2F4B6292F24F393555DD98A208D58CBA4059522472CF14D5685AE6C7C3A3
      10116589BA57ECA9AA0F41D79F539F00BA50BA4D53A15757CF5DA821A738725E
      B3362DC5A58DFA59E90404BD49E6707109B0F1FC178CAC62598BA61355BA7CF7
      5CA354A01AA6D235FA82B4108C42AA05BDB090FA2659B3EE06864955B320F449
      CADC3A203DC30783977AC2119B7DF44AF96803D5162FE5D6D23EA59DD6F4AA35
      CAEC5003CA8095CD310CAAB34280DDC366C71C24D5696B2AFDAB387B85F5A462
      504F6604A6F1FF63EF5D9BDB4692ACE1EF8AD07FC0709F784C6DD3B478914479
      7666439664B7B675F14AB23DF3B63B9E0081A2841108700050979E9DFFFEE6C9
      CC2A8014E5CBD82D1BBD9CD8754B2208A0B2AAB2F27A8E9CC2524847531D5C91
      D2C7F18141B9F84A2CC5692424095A9206C1F1AACFF48B39F69E13D1AC8B64E3
      E68905C8E570E837AF48B6723CB95B3C9B26E5EDAC762F0722898EFB1677A582
      4FB21D69C6A51617E4852B6114973A2F7A51256ECC79ED70E3D3082E76314D2A
      F0DF3A7FB48D98E694899C04C45BCA897D0F1C65588B64105E646C11A294D2F5
      64E063A93DA417C00196CB823D3BDB5F6AC74F0C0937D43A017134B97FA84665
      0EE91F19D87C59395C02264932B9E41C436982582DA448101A65AEEAAA382BD6
      861568DB7BA1746696C28A8DE3949322473B67E7A4F1866E93BA829C8A65AE5D
      067C5F0ED23EC17E01976215A50D76784BAD5BB6256254EC703D2B509ED269E6
      BA7CA709D9C3DA5084FDC7FA0026A711EB1F28760C71973035CE1A6FB1894927
      16F2224C1D5DA44FDF32136BCBD3DD2ADB9D151F1C686C5B2996731CEEB3053D
      72F494A6934B373B07001E9C567E59BF84C65695BD85EC179DA5AC742473C075
      C8659174262A7C6A63873E931BE41FA0482097E2C36DA38B1ECB136CE69FCC28
      6BF9B48C02980AFD9C9AEB398FD419DC0E6EDFDE28F1FE3EA569B274D16E30EC
      9A7CC2706830CEA34867AAC01CFD9F0544AAAE6BE64A69E93C31BC9C3571BF65
      FD2A170BC97BF26BE2EDBE41196B94949C71345D8F2D85839F682EDED1BE3C18
      EFA53481DFA043D07B8DBE6D238EA7AC495213AE0651C9F28CD6F62A65BC9246
      24CC19E19CD230F5AEB0B66E70873BA5890F31AEE509FF9169381883F153B3E8
      A2FC385496A799107C72A8576318AA519630047ADE578F03B686B10869296B83
      B0E395ABF4DEC3FA7511FA331272A97F1746E2AB97784D3E10401A70DF03596B
      B8E34238EAAC36E7063ECCA0435E9D57FC0B1F3C730DC23CA77A3E71148E4331
      FAE1673C19D8F4BD4A685E4318DA3B4387040D6D5406C2A015F86FDC4C294592
      7C76AAADC36438E571484FBA7659410D5E25C668587B581A1750388C3540C60C
      5C55291EA95828526A7F1DB1D3234D521A7D59D3BFC6A8D6646E64260794C294
      A5B6F9C89671340512F3AC98BC5CEFB0EC419CED7F7E484AB65C6AAEA7B91A60
      65A3DEC5A825FBB07F76D4A27F0E45A91FA681CF29070521E6165E0E3E4A7108
      5B9A95D4C207E04F96EBFD81897CCDF1A45333F27E7E7DF8D7D3E7EBFCBF4EFF
      17680D9BA129891BDEFF0371A6F7FF6C9BDB65D5A1F5A99D089BE2C97A56886B
      3668E82F1025566C559C0E68B8D2972299D40AA98E72A4927EA2D7088334B474
      04959363AD4CAE54399AABE1B522F395C7ECD4FA642178C5E70398BC4767C37A
      CB9DF4C042F8D14E483BF42DDAA79EE1CB9D5296443DB21F39332BDFA0C549D6
      41A57A5FAD3A2EDA92869919FC0A4DDD09E4295487190F4D18CE46C5485BCC26
      26AA7BDBD1EDE04A7A986F833065DA10DA061D6AB11F480AE19127E5FD3F5E91
      DA3B16D557CE90E543FAE4A9FABA018FA15924E0A5BE7B405EE7D164A9E01628
      38968B16701492F2F1C712515CAC070AF64B9115F783209D26652C78EC87BCA5
      671286EE19A55BA9C1275DBA1A9E66FB185FC4C5EDE25698B016A895E58AFF64
      E032C1E7D8753C0869B2C8E958EE06D90D4A39F130589272BFB1586D383F91AA
      7EC92500A552D8B5ECDF5C058C787EF3CC146DCF8227D08367EF3E4A1157C779
      2706B3DEB09785FA88E5FAFFC88CFEFCD66477BF780BEABD96F1D68FA2A0CC2E
      419744704CA78F9D5FF93B6611C75460E7F01B58C74FB510ADC28AE22067D392
      73A0355745E820039811005FF1947B806BEA16D68607656D38D701AA1FDDD268
      6E8B939C9F3409B03ABFDA34A031EA3B990A5B25CE65A75221755FECB9ED7314
      BAF2BC82B3870297787A418F626BC3961A5541FE6608992AE5854DAD608E46DE
      EEF9E9215C9A4B1387B300386B4BFDFCE15914C5FC3360027E91AADEA55AAEA5
      5AE66CE63754C7254628E949FA4F6C1CF14D651743D7BAB4B7E65DD9BF704A7B
      518FC37D40502DA677FD1F73F0DCF45E48C06BBDF49B4478D1F9B73DA9262F83
      98DAF8D3D04C60C335F39465358D12550FEF6AEBDD1F7A7AFBDBAC0048485701
      2DC4C7858659781270398E1CA92DEFCDDE69CB665B0FCE8F1A24B4BF4FB9929E
      C3C5130957F7B8D4369F3FBCB573DE150BD1925B5DA14582024C7446494DA64C
      F728925C68E3C5C9D9D9B3C3939373D7AD40CF4745ED4CD382B5E045114A7E58
      1A11661168A759022763E435CED0328405A44B02F96B93B86A266E3A46599083
      C47591361AB7453F0BD28B0469AA3569BA34E4C1340E3CD4AF782860F10E9E8C
      3DAE61D1B6083CC45680D96E69323F320C6BADAC0B46DB08A42975C3D24D23D6
      9215C19E7F935C4CE1F6004E88C1F99DF394A753D06A47598242B53864524E21
      6472D968253EC5E5174AA6A939B9045027F4533E95AA97272814CC8C1FDE556B
      AB7BED6EBBA3DC9FAE78B50A7C7B8E4ADE5B9BEAA39BB54AF42C8807096A5633
      28942E2DB871B5C3A392BDB6ED66167C01D6811400DF3FFA7430747D20D50EB9
      29C1186CB23D8CAEA3706A972523735640C1A49D0C20A85C40A6BB607857D8B6
      B2D97E3A5ACCB39997B20BAAFA92B22C5D5520492E9C065C72188D588D098B01
      83CC94D5CD988EB19F20DB4F07D42559BC4DB4FF444154A80ABD5364335B9A50
      F9B802324A5B5715B7DDBD4BD8898F320065FEC593E4C91EB007685DDC5CA633
      89BC2514C5025BE26001FA842DF49F6FA378300034236994CF5691812FA5DEA0
      59F52FA4268054D99A6501B1D1230EAF26DCE1B05CEF1F99BD231033C36FCB0A
      3A56D9326AFCD7743C2175DE58082B529345FF5BC3FC21F4E8FD20700E8F0EE8
      972E827BD13DA2FA1FE503E5445A82AC657AFF93047CEC5FD3C99B93895AA947
      ADC9C2FFCDB5FD4B5211E7FB671BCFCECEF6051BE8A4DF422799CFCEA3092F2C
      A72A7E044EC955EE525195AE377223C8C0B1AC9F19F9058CD26EC3FCEC97B8BB
      AA515E857C77C9AF4467AB05E8210BEC573E1C1C12DCEA159ADBB2EB4450B9C0
      AF6A2DB1B6D73CB52D60F77C053122E14CA0E575346AAF793B121EDBFD890BDF
      F894F28711378EE597D3D1286663970C5DDBA08BBA587BDACD21B8E365C9F72D
      5F57C77223C5738029049601EC792933AFB690CC8C36B71D34029240CECA883C
      216E3D8B12F4DA4BBB455271738E77DE1E898BC33AA28C9F84E47B0307E30235
      495CF74ED66BA59750A03BC8811AC1DD00F590A00FC086778D318B974BC0EC01
      512E0D79688B8E0215874E796EAD073478874EE5D195348D414AD2244BBCE0EF
      382BBE72850CCFBEC4E9FDB6BD323DAB9B5CCAF9B9038836B89422CEF475F29A
      B68BADECFC59DC2E2AF93006FBA1573F9F5DC73C50167B7348664AD96654CC5F
      472B8B9106E8BF95DD541193ECB7353CF26FD0F6AEFDCA4167E87595BE9B9607
      F522E4253C2845CE5A9E0B1F2BA0B409FECB69C1C0641A65E4F9CBA693657584
      3B25B4ECD7D8A83FB692BAF20EAA27D25DAEF47FF80660B64B94029676ABF247
      74EEC9FD0474BB2405AC4099822783A5829EB684D33DD6017713A59964B9AF63
      0DD4E7CD14655ECA4BF366C155273F214656CC77A0E7F3A02B89F05AD3551386
      CA0BA70CED6561CA93B25A441753EB03EF04295516D982C805DCA928992E9B8C
      3EBE381D754D91A24D66B963CB7AA639D194CD33D83CB46D43ECD82A68B8F723
      190EFBB9AD86D63F32CFE7C11E7D78019481F34BD7BB03183B183E6BB4738AA2
      3CA00F2ABDB319D9DBAE5F38F6B9419EB1989B6C13F94146E7AC9763F3A7C932
      A2F5F1E5CE25E5E0382E7C6FC20D5B1C6B5C2EFE6A874BA3221F4E34F836F7A5
      25B5A2B6153F7F0692884D497BAAD1BABE619CAC9BB46CBC273DAD01299B6AAA
      1A8F64EC930FC2AD31C87DC9FDF15D36AA1B470668A85C34A869AD361083D059
      2AED61F34FB22FBEBAA2E17A1B742E47A87CF365CC79C1532CA6995059642E18
      575D480EE047EAB7F435ECE9A5EF618193D10DAF6774975E6CE1C50EB9C312D8
      CFBCB6C267D09917C57E26BDF04AA755D55B6DA5F7AD621E21A85E79A2139260
      AD58B97F70B394EAD0CFAF72C599490C7966F3636107B5923A959AB8B12B4413
      77D2429F551E36AF0F7996B899D197D0A96DE39F79AA9B052E01176DD9AA4C6E
      85EF91B37DF4466D9A0EF62A0042C83769FEC9DB67357B460A16FC6A6F9400D9
      4F2A57F182277FAEFFCA0457A86B2F6479859647DD8E8474FC4C8684DE3E52A3
      AF323457F6537D5B169E243EE80DEFCF2DC30BB043E7585E7459CD4DF25C021B
      60148C0AC11E325ADAECB596D2595F52A72CE15EB40BE9C691547438F3780B47
      11B9D473736E18992D9DA16352FD691C5AA596B894FD5B9EA9F22292B209CBD4
      D38235C262E52ED3FCDEBEE463F873B4D5E57D3D727F538AAB8BBB8DC726714C
      3CF79442AE186090A38613843E47739A766F9785CE87CE179D3741AA0640453A
      6C21A063F64336C14962CA81D06D22B0FD90835F485B34AB81B91717E446BB6A
      24113BA3B9E5AB48548A41E3BC00ADF27678D74081220DEED43499443B2C11FA
      E185A4BC7DE1472E5EE3E93B2FDA72CD052D535B328EAB70871BBC3463255D20
      5F8DFC24EAA7AADF16500B00D3CDBE886AB4D99156E71D9B86B747654308EDFB
      8E1E13A4BBB9A45DE692199A68D33ED74BF6705F7989960E6E7658F70225C6CF
      23A42A2BF1920B28B02C9D5E5CCEAC58DAACEEF6AB2B973B0E5ADF628D7C608D
      CF80E0A982B0729D1BA7CDE61B66A07D3ABC7BEADA4358A508D838DDC30945A4
      35F777ABEACBBFCFCDEF3B84F298A14A0B93B17AE6F7A25B283382259D059854
      6DFF567EE04CD413935EB1AAA87C85A3508BE6E1C3671CE32BA293BD0A7138CD
      D8A3057B9125ABC9B48D4175123E692A3516AD4E169F2E97F93DBFE6597A8412
      479171472676B3BA3C3B6E3BA3EE50006211DF575718A963348D216930DCF1F6
      CD4A745956C13337D3602AEB1752770CE6433FCF0C4C9D9832455F22041416D2
      C35A0D18C493420043D20BC329473457F29CDA9360EEEE2C3727B55CE2DF5561
      A84A950838A3A1EAADCB32361ED4EA8A9391D73CF2EF667A4344E06AECA80653
      2D5765BE7165A85595909BCAE8F534F71C80815A2F99C4EBC3F6B256F363E032
      6A6BD14A45F1898307ACE0489516D6D223138F8C856621729DC8FC7C4E5C1540
      2EF851B4FE49431A392CB133549CF66EFEFCD79D01C3988A069B16955326C7B6
      76E55E2D5559AEC13A9F469256B2E804B94408670C60AF02CE8CDB39A5515ABD
      CE72E79AACE546FAF0AA78C181574E7A8158C1FBD1C49396776C6EA7391D9A34
      FFAFA2E2C7E9B085625158032D28783AFD328378AB7F6196495CDD5D56920F01
      AECF85D09D158D62BD9B2809D31B3B09B678FA1FEF819E0C883696ED7B86AB56
      017BF3C39B1BD8D76A358E53BAA74FB70B87FCC3FA7BEC5ABABFF7FEC970EB3D
      EDD87F2E98F951F4B4B789E9D9EA7EC612A061FF2DE021D316286EF1DD4F5814
      71DED95AB832F0FDEF626D604F794FC9756282914BFC061D37D3965A93B906A9
      ACAA061A11E2DBE5EFD006E5C0C874E739D1300690DBD84CBFD0388EA910C13A
      28D76C9A7050D0CF6B2617D19224127647D89E85F9398AD47D8991572FE82CA3
      B3219D90A7BFBA3213DAB3222B73D352B92C65BF7593C6EA8A9E16BA4664A6ED
      DF72935DC3A63F357EFC948DF180091038BEC246B55C2FB8FFF0DA546C0061F3
      F6D1F285D2C4886505D0E9DA49C79E9F4FBDFD78CC89C76CE7CD937CE65CADA8
      08EFAF006A558B4D80A5C94F98168C369BE74ADF5596DEA7C945CAD5CC5320B5
      56165DE196DAD22EFAC8444AA456480CBE91ACBA5F4556DDAD0765D5DDFA3AB2
      12E5B7B403ABCD72025F38D3376341102D35C6C26447322B4DC796532D952B63
      168D3D86342CEFA7E790C4E42C8C5C9513C30655598D5CFB512CA571731CBC36
      2A3C4FC1ABB7D76A8D549B4BBF9532A9CD067136D2728F7C9D3D322FD0CFDD26
      A5D1FA5BED94F2090F6C9683516900231D889C0BD9026939CE26F35EF5DBEBED
      DB16FDA78BFFB4DBED3549A8C8376D33AE0DCF4ACE988DAAA64489393127F170
      A5E99E568E362D9CD27DCD255191925558AE2141509D13AEC31057EE9C65CDC8
      470B1DD5B6CBCC38E255525D464BBD606B46E6A9E01D5BD225BD71CCF1132C3B
      2B4DD95C953DC52D86B2E3B0EE512D8CF52ABB836FAA7953A71C7EBEFD45F645
      493650943B9A31EE550D3141D80CF5165A5339369961876740184E3387DE3AC7
      6AA51BAA7C93A8527132895175CC3BCB8E0DF7B3A5C774634EB255751FEE49FA
      72EC27E23CCFDFDFBEA9C2B0DB3E01EB4860EB8B06AA38086DEFA5380DA224F2
      4A3DC3B5722082CC1B015DF76A666212574DCE9B928B28D55D71E976F2F9B972
      0499EE296999BBA5CAF828601637DFD14069A92264B2B41F2A8595F7A5E335E5
      9CE35D701DF93304170B3BBCD62AD15A647C2F4922659A1F60E6F294DCF29A90
      EE8EC6D3B13E9596F9A51F6B7D927639E84733B82E7A48BAFB5A6BC231BD692F
      CF32F0FB9981DFC1F71DF83DB36BE229AF256EA65D5D4972C7D01249E8E653D6
      CEEC7AD7A3C585581D892B176F08ED219B89CA29C4650565025A2A3BEAB5DA56
      575E464C05A941C5222A62D7A0DCAC82DDAD95140DB392B585A063AD3D155007
      1440FC7D6A6D5E5A4B434634F1C7A9422BC85D1D97103F308F7E350BB058EC7C
      68C79CE675B8C20BDFA8A5C8CFA14245E64EED154E12F907A4C0D5554262CB7A
      B80CF43BF25A926440CA3899112E3F46B4A2ABDA9A7982005B715165A53DA326
      52854CCFC628FE7ABABA827AA221DAEE3411E004CE7D7DB2E0DBBFB9EC0F6C0D
      6D01622EFBA0CADA678E64A3F065A4AA0DBBBE95172A410AD8969EFFAAB607DD
      DBB3AB2B955D8BF99E64291BA7A920D7E497D934B9F2F2D47374C8F6B6185D05
      D4F9432FF53516D7D24A7D28BB891948D2B27B95D153C69382CEA1F46669B256
      7B813E22AB79CFD1241C8179E6423133BCA315D37674DFB49D6D9DE34E88A579
      F999E6E5F6F76D5EAEAE90DEE6624B463B82575E92E10AF705AD1CA6BC059C1C
      3A466891D97E320B3ECB2615D949C594CBB75F9824BA48CA4F53F47C20FC0A85
      791985A1496A76DE1E8CC42AF6E9B45538BE07C5648BA1852DF312DBD5CA6DAD
      55D9A92C0DF9AEC8C4F68FD64C36BC846C7BC099A3472F69853E71D51CD1468A
      00EF80587155C17D60F92C4FD407264E5C3E0E191A5A9562A630F236837ECF98
      27AEC47F09A4FE81A8323A0BF4686DECCDCAF4AD93E92284F5126AD7A2830CEF
      38623CCE4DD098E7E7F2F694A05634C3C6FA4CA1BD62168A0DCD8FE5D8E88863
      D49920F2A1921688CA0B26581ADEEEBFA2A489E8B52ED3D8B5E691B59FD3D69B
      4E242A7D937857E66E4D387469F88EF45B52416A3FC83BD9427F17842047782A
      A523C82BB9661C5368F30116EABA8D3ECBE84A7A612EDF492B9822B37CB73C82
      C81161F0D35126E6FAC1440EDC16C562582A8F4F66E0DB897190FBF897838D74
      1D2D7C0BE2B8EC535EA81D3E22B48776BCA0066553B3C0EC6E79D324D75A7BDC
      2DD72D4B47A9F003E76B2E8DCC0FAE46A0E9572EDCE2B2FDC2B2B6FEC17E2EB9
      E35B1FD04A2D8719CEED2C13C581B53B890FF0AEE337CAE95C4E911B53188EA8
      C46C7E784594B35EDC6E7736E9DFCEA0D7A5FF74B7FA03FA4F6F73B34FFFE96F
      0CD6E93F1BFD6D5CB2D9EFE092AD5E17970CBAFDBE7C1B97D0D2DAE2DBAC6F6F
      E3A24E677B1D5775BA741DFEDBDBEAF375FDCD8DCDDF74A9D1E07F6B88BB1DCF
      7B81FF5339D3CFBB9EB7637B0A97FB51F6A3189A6EE1DB3D54A582C7CA5DAEDB
      C75BB7E582C5FFE96FF23FB77CBDE50AAEC2F989A6E7686894094640D3822995
      4150EF4FDE6CE2829738E71A1F1937BD2927D4DA37208E4B1F9D26A0A9C7ECB7
      18AD3405697E48AC0B94B9887DC0E0783316C0D2CE7D40902F4B6E04F65BCE97
      4EEF8C123A494A9FAEF0872D6123B89FABC94CC9B23BF4B51F5A71D0D3D9BA85
      03E0D8571106F432F22A8F1504E519A603FDF4D53229BDACCC4F5F1933B10C64
      48EB28F4805630E2627505A5EB7FA62F46142AE25570A57D413D61F6216DB4CB
      D2B44AF627E34378D44555F8F1EC2593BF1DD28D5A1E864476752E800372F727
      B9FB339C5F79DF31FA502B78D915C0ADF3548304F4EAC1342F2BCCC8F516BEBB
      69BE8CC17F660C9EAEFBAE63F0A0CA3B86DEFE4F5EB0762BE892073545BD267C
      A7887F786B87C23BB9BE63D94F94C10C30AECFDDDC3CFDB3D554F4931B25FDFC
      7601287B4D86BA2BF1BEBDF426792E61453BDA076612625934DEA5BDF1C02C1C
      5848E30007916878866F54ACAC19617E824BFABFC30A11D0B823581E6F26CFB0
      3CBD2652D66BDE33C5739685EB3EB467E59A1CB07A9072D947A605C7794187BD
      3B5C05D44B03742E6EC68FDD09C3F2698FEC621C24B9C9BE0563FAC3121C1AA6
      2C2F91BFC515B1A25BDC4453E9A2B121D2977CCBC4DC70B951E516B9DD070DAF
      19CEC545D7A40667ACD44B9A71389929778812461A0FABC98C47A7940481E2A3
      B34F48E247AA3BB06A3F71B97ECD717F9B053BBB614350047D6CD5E2A2C9FD2D
      BF3CB83EDC4590A38703A154A4F3BDD81F9A38BF776E2D8FADB258AB22A666D9
      5A67037551D5BD9EE1E39681CD722CD8D243016973959896E58297FB83A06CC8
      85D292F385342EA8D48BCE87CA938A2A966715771305EA842D28AD3AB96B85B0
      44DE790A4391A11796BBEA13779578FAA0474EA75920700DC08D57CE38853DB5
      108A0A55DFF879CF98C92FB42727770866D864DC33A420015CB504902E3721A7
      502BDC7BFE3DF13567E427B25E7372A45B0033A484EC9BC7984542D5B5B1690C
      4A9A2E7C866B925E362656D494ADEFEDEE1F1EDAB263DF7B777AB8C7415BEF74
      FFE569F9775CB566E9DA0C109FFDEC6E26D6C5DC94CAD08810D5BD95C3EAC6B5
      F06506E514F90C98AC4349096DAF8198562A13B5B1F24537AF9043CAF275D432
      701D110C44EAB8D2A56DAB376CE30ABA310168E31E668BCA2DDA15983F0B4186
      6B3A551821A6A654B76BCC903AF7F8A5BA79603754A0C4457E4B25A12775EA3A
      4D1BE3792195F0E2744816775E134A5A50435D059420C2DB9E7BECCE2C65F4D3
      DD9FD618D014AAA5842B9DE13892B3D2848FE9EED772F9360E92BF919A6556A4
      BC3A43CBF3AE5CCA1F1492D7741814D6F69C6F0150204EE429EC250BEA0535C7
      AC990A5C243C23B6E1E7D89DA48E4A8D6F5BA4EE106057FD6F522A6C2F6DFEC9
      1D05F64F528D04A033DF227B97ACAFEEBE022FCC80BD646B73CB5D1030151977
      2DEACB4D32338A6E4B14F289EB108AE69352059DB442D26018694C020D43BC2F
      DD884D791CFCCCDE2C04726216FB0CCC9B153636214F5EB3A69B34BE5B7B62C6
      58E7FA46DC5388E4E8A5EE4C51D2B296D2D4C3518421C4E00CA05A9A08E264D0
      C70EA3F99D105B3F974C9A654BE0393C3E39F7141FDA4FEE4AF63E014F656B63
      AC8893657E4D052ABF4559C9F9BAE42AFBA81653F33398B3DEBDA660D7D1AFCA
      76BDB634E6E795DB7D19354AC6C5999261CBC7C1D0BE0F0BDD99F97653D8F57B
      5CA11FF18BB93D836D6A5FC248F1A4F25D54CB241D56F8CC6E51AB760E6D64E1
      C8AE7D9004F2F686816EBB22EF3F6EE6CECAE2415378C180F6E8A288B2B12870
      6569E3AE80800530AAA817C544866EB66F52D8AE5AFD2643D05F4496DB22B84C
      23E1986CFCD5E49698B1C1BAB3719CBA3FCC0D57DDDDB283E63EA1871DEDC2F7
      AF62BA7C6420EAAC342BA29D151677A4E8D7EEBFC69A857DF9B0CCCBE72943C8
      6C4C524E3A865394737975A53C995B4C9A37E3A262B57E968690741D1732CCFA
      9C33CC432DA55388F56552E1E1880AE7506971840E4BE7A0FC02B085CB754F4F
      9B938A206D2A355F799FDCDA05F6AA51BCBA322F692B39E9AF7FABB6F4AEDAD2
      E2FECD5AE274D3DD9FF04E62B3FBDE249E5E4449D5EA714D90E3695C25DF581E
      4F0F1D4FDCC7A5062488E3B083F7CF0E9767908BEA425DD9E3A060E0F9799397
      F7A9B316FFECFD9F972F5F0AB10CE9D3F144125AA5F13C16648D1119D7E5B7FE
      E34FFCB5B6A39C1A91E53ECB1151A458E664B425F7CDED5982A0A5FDF7FD6CB0
      53A314CF6E8791EA5E5A79733B6CA2C14AA013DB33C62DDC9CBEC37C0FE4B5B9
      084A259BF16127986D9387D4DCB7DB31E885ED558244C2147EC93595281FE233
      94F9089DC7CC44E23EA0D6D04F34421377C58E10734816DB1283E2E32BEF9549
      C8318F99611CAF35366C1161659C1CEF1CB9429D9AECD3DFB6346575E5E9CBE8
      F635AC34DA5849601E3BE9FFEC916B7168C0C7E9B71D3214D7238FFAA954C863
      FDAFAEFCDEA79827D80E77F6D9DC20F55B17F054948E62F97917A29350245589
      DC3A92712E12C09932166E58059C67BEBBF1FED951345A02647E42694BEC4F24
      F27BCCE5F9AEA0C55FE2D1ABEE7382A9B68328FB38635AFEFCF4172FBF1B0FD3
      5833D4B3B0B5810859DC1DC780A992472422233B6A42EB5602208AB022590800
      54A759C915E9AA53D8A39A4CE2C828DFA4C00ED0D34B141BF69FC6FE9D06AE90
      4E4EB38B1471AD59C0063C170D200E6A564D2C3C2448D9A01AFAC11593B0646D
      AF29417BAD85D1E093BE99C7210FB873DC8C95A485E52993EBC1179972C73517
      0DC847F6BB16CC9BDBBBA2A2EC15278F4EA014E4968EDE8F2B1C6CA5A34D3D4A
      2D2023175B5310330414E22C4D8A323C1A9A962D2E9209B2332104C6F3B2E752
      205AC88CF09D26555D848FF77510D599816F4B96ECBE9D35BED40760F0EA8ABD
      0F428C309B8D9FE4AE4917457B9A7E09EFCD9565459C87A3ACF419E1EDAB391D
      21E5B683B003AEB00ACB0AA43185D175144EC9A45F5DB18B8D29CB66EF209757
      6FE08458B985BD415B26AA5CE574BFA0DC00BEDCB359A95AD5B954C07505A214
      A00D9FAB29EE3DC3C996EF25809186ABF4B9E368F61E761C4E600C4710D9FE26
      B776F0EBEA8A2CA096363055C9484B41BA4D2CD5B7613A1D5617A12DBD347984
      1585D2382E45E3AAB67549AA55B1FDB8B8439279F9427821CD96A11C511197FC
      38A3D57827D09DD5E77BF7DB6613C9F349985C2111F0DAAEA84DF51D89334B57
      576E96E8F49FC050516800CB135FF725B4D08F3425CB5A936A55686356520DA7
      376DB0A0149BEDAB2CC1C522F02BDECE4084A01747607418E240CF5EDDFAFFC9
      1A78069C129F48F74EB50C6B66E6F0C191F0A0FEE075962BFFA37DC4E5842515
      38A8B2982257C5B5DC07E53E7086E44DB4BAA2B01C1CF19ADF0437F6042CB35B
      953295DC09F703252BDA9AE29862AB9681E043CD806449304F28D5D32B4BFD3C
      F34E8A9363B35DA9B51F8C1F5C565E0FF7E7D7BB77077CBC3C543EB5656E44E6
      345BE05A4BC39681ABA55942C4EABEDA5B281DF0EF44625666860DE6804DFD0C
      8B55A30A881BFB82F7243D9E74B59205714609D54517861E810CBC83D151FFAF
      9117F8CBCFEE91BF70ACDD7EC9015624A9F608D84F9C7F4377BDD08EFDCE3A6D
      19327F359F2CDD0D78396BB7D292B820DB36AFBEB5DDFB0A971EF8D216E6EE6F
      51DC11DF9D6F9360E053E13BD4B41CB73BA402163D2F4BB893650927BDA7769C
      E9798A6C5C7E477ED118255CB5DDE00FF48A0DCB78DB57D9DF4FF1E6A8A39B0F
      F63DA464BEBE8A61361956F5A0D67551B8A546294FEAC78EC43EB4281EA1F7D5
      CD7F59EBE56C12B588CF1CA0A7AD8AA2C5C3B1582E0885CE90FCBBA603E1B8AA
      A33A53972AF52A79BBB82D384EC52E757E154D72FBB457DC37523E8F032B33B6
      3C9E281508E4B446A1FBD23213FFD17C1F4DF361945C79CFBC97277DB4A9E0B7
      E5AED7A6FBAA506C65150EE797FDB37DEB954649104FC3F23C3DD0F8932DC4CA
      7979B25D8E32EC93BE54A0E99DABDC835A77C6F592CC3CA87F00D3776BAE9EB2
      ACBAD602B5E85EAC8F771B025D6E923F8C7ADF78ED17970DC62E52531F9E867E
      685B986057B8E2711850F629610BA68D5F31AD16F824A04E4BA5F05E06F5207F
      65A5ACDE7948F022480BC9187C1BED9CB1635C95C20C1BBAA096BBE411CF20E6
      0175E352A630B4E659616D33BC5F59B8CF5C6EAE4AE19B1C057821DA1C57DFF4
      3898476D4584792C31EEEFFA78FCCAD07396246A76CDDEDF70B47C4EDD7E00B5
      9ADD594CF4273BEB05F9732853A5BF1C425164CB43EBD38A546C76AA9A8A1147
      B94C8D8DA2DB25D95F799CC52845F6B4F60E55CF0BE55571ECC67EE85A51EF89
      DBD5BADBCE41D29F17D572AE83446A33035F69C4C09EA9AD0A5A2D0E96D29B6A
      A5DB34C1732E122E413A383FE2E419A7582C6C4DE573B4DD4E834B9CC3A572E6
      7A8128A0B30DCF5A5D89F271A9B72ACD869A9543BC4D21D849223ABF33D98F45
      436F392A25EEB8B23472F742CC37B65D41A3DBF3D929D5A30BB00AE84D49A4E8
      7D602CF7128E40DBBCDCAB6A2E6C78079A510D78AF97BD54AB2B99C9711DB763
      8B817C5D45169C97D88CBCDCA928926A9024A619384C1B0B84A2E3600C445C9E
      7B6F8F76F6BCD719020705A7A84732F2C659914D83A281F84B6387C13BE923FB
      474E964BDDE0D860AD567D08E691FDA4FBB400DB8F57CF865191F924883B5DFB
      824368A4A492951FF2D865AFD84161ADBB19830A304818D19A771664D144F74C
      6578D5E8E99B03AF39245B0238349CDD04807FE65F3C499E0079C5A5D2E6ABFC
      0F9251EA321E24E25003429863314AB881E192C9531EFDD8BDA3FF3D1D8F9F92
      28DEE4267BEEDDD20B87E6F6B977F7BF02F1F6384D3EADE6EDEB0EB419C9265F
      5F66603F26AB37ECE4C0AF48B3833D46578DFD0B394A7CAE84263DCAFD334BBB
      40EC023AA6CFF7CF369E9D9153ABAEE9B397275B9BDEFEDEC1B9554595B6301C
      E7250C52CBF68F39AAA24916A59936270593136DDD2AFD3457E5225552B67751
      AC0CBE398EB4849DC08C8C6A1B861A9AB9B3DFD72FB7BD17E4C9A969EDDC6729
      EA710B412259E04411734248BCE570D3003E6781B372209265634EB086EB40B3
      392F7B952B97DF29BD75B2EF2F10472D32E3D32961DF0131AA1BF0565821D2D4
      9462E4B13807DD8A615E081C90E712F8F26942E828FEECBC14E45B4C1623CE76
      9272301F809E78BB993A2FCE02D04E592A994F49764B355AA05D99E4F83D6381
      A33983D6D352BB6C39107FB15B4AD35522C392207E408AD17DD3267AE875A3AF
      F8C2B4BFBEC1F95ED6888A115801556842374B161E65976BD59859B99767401A
      CA6EA18F2FD3E556FF1830B598EF68B40564551333717A022780E60BB85512CF
      2DE39E4D4058B5BC9DDD1F4F2575DCF20E778EE9B2D7AF4EF5E2E39DB747F83A
      DFF13AF29DC39032D86A73AD12C8648E3A381B6B4B8DE2EC159157CB22832D70
      D466270B62A47DD477935689852B3E02BE847078E9166B62CBDA1EAEDB5E18DD
      B85F5DDA60989D115DAD6906EC911FBCDB967757C5ED9FE99D2B1C06626EFC0C
      7532F0EE2A8806F2EA687D8FA4F07306AA41CC03896DCB06474981053E59E3F5
      C5016FA93498BDABC629461C6E9410A6B0762586AD225804955486932E67E5E6
      45BC7055DB1E5CBBBA675D62078F4643C6D7C581A63B784D2E19A25DA6D88E5C
      8E10DF59D36C966F94242FD070ADD2D87940983325ECF3C81715C161A4D5E090
      2FD12D3C259F2934F4D59DFFD08E9766E67245707F64A4B76B31D800C74C68D9
      9150239BB1D0E00D4F30BD45665CB808DF5B98E810140004923043658E432ABA
      3846519D01279647769B59A97D8373756CC8585F221E7CD467B6249E1A7673FA
      82D65FB9CCA5FFC06E98E569B455A26B7E581B24C68846549A506EDAAE885A91
      319D2A10AF366CD913667585753DC218EE23BE7195CB0D818D4CA0BC2CB864D9
      48AD9C35609A49B8494134BD387F9C01650D23BA8555896402AA9A7438BD5013
      7EC653756FCDDE6AA9F34A818491D4918D2D6F4EF991D57612DCAF7C5BCE403E
      01E899AB2B3371F81BF8CF22082E2129CF61A8792E90BCD1DC39930C28296AAB
      EC52B10764397EBED0F64EF098F1059C8DF804B43999E09DE91939B71B9671B9
      8F1E0136375252062308BF8088976C35D464DA2E9C9CA3F95364FC3456B4543D
      6555DA22013A9DD0641B101924B2DCE2280796D36C8E4A351289993625576823
      F0765FE462D1A8DF5EA547856E93EEAA4420FBAA0D5DA80477CD5EAC2C98106A
      A6EAFBA002288CAA0DC5AAF273314C3367AE09D253F91630CF149C9BEE2C5562
      6588A1BCA3A2DECF5484D81EAD920E93EBDBE80EE8E6F3714DDB6BBE103C095C
      E2CFE00F579A39CB318AA526BA5C912866D1B86EE82DA613D7B428341152E732
      9BFAA3298B02A376DC85E17A1457FEE32FDC47F8442CFCF258A91E4AFC6E18C5
      58A2DFB0707126684BDE7D453E53C763956DB5F9757585D9D01E6835A89E4B2A
      505B42C8953BF6E6E487A05F040722A65BD4BE746E825DAC52EB63BFF1097D0E
      4B65FC09083C388D1B568897D28DB1A82C6CD906BEA079CD8AAF1AA6F94439DA
      3ECD4B06803589C57CB3B79880B57E68021F565C5430A7000276B9BB902BFC2F
      5147A7EA5474CE3C26C24CA3A98574D7640E1977E213971E2327D6971BE723F3
      7F78B2F78AE64C2DCAE59E903DF1D6CF18555FC4B2A88048E5861A386E744FAE
      500264F234F9C372C97D58BC67979C7E4DE5AC9FA491FA39280E1923EECFE523
      6423A5D9D232D60579249D55796986B800AEAA594476478C3F9065D309EC8939
      116B0558D3196E08091EFBC7334690AB0485C68F9229AFF5105C26928DAD368D
      551ECC6C16A599F281B775F563985E2F0D507D65BBFF66170092EDFA6B09273E
      CBDF8AFAA9AB04B75DB09CEE2F26FBC6294D720474B7173045F3D097AC33B787
      0A30EEC8E774B46493E9D8D2EFE379320C6B08EAF944CE88D8E1D145C2D01ABE
      036F73756B281190DC3B79240553C5A27715D70CB3F44A8CD6448DF3B6F7D774
      2AC7DE15C7AB87F04F38DB8DCAC0A58AF9F0867997660C4FC13DF9475C72E73D
      2BC952F42FD82EA76F122C106171D98923AEA8F1FEFBCDD9F9323D554978CF95
      6BCE3567409025680B173262534C87D5EC09EF752BE8C3B373EF4F955A7291FC
      758E8F76CFE823E008697F54F5B3D595437C7A986AFA973F5B7B206D96938F49
      86A9859561FBD1BDA5525857F266D5C5227590B3CBC57EE3019605FC4D57D392
      2BEB13BDB69DC98494A6149F726FB1C502AFD4712FB7A16BDEAAB0F4CE153497
      1CEE9225B3F8DEA9F0C2A5C3F45683E155AA5F3E9EE3684C3F223D179505E27A
      17FB5DDEBFC9C3ACEC1EEF043AD7543D58445480A1CE241B6722ED2EF2214F6B
      D900B64D06EB4BDC43CB6A3D8020EFE7570EB66BAE2C1FF6877FEDD8B3BCE699
      3DB1C3280F686181BF57BF5216EFAFCDBCBBE80F8B551FC469AE4D62BFF13B57
      DF5690DAD362AE2E469F5A7D739537BDA58D5C72D72B035BB46CD192808FE9B7
      B973CF26F49140C7643FC9E929AB2B269856F2E87C6BB91552D9F275D7D58F58
      D74CE221C7E091C5982A00BEAD4060674AEDA4792C7FDC66A9403FE64AB1E8D9
      94AC9FC6FCADB15D49208121D7C2205B2F589A07A3A328C78668FA06258FCFBD
      839B217EF8236D44B904BF416D3D47D280AEA44FCED2AC900FF3E7DE8B348D61
      C9FFC93B077BF11FBF41FB22EC1C05A94FD42A216766A82F3671CD8DF7B996F9
      876996307F731978B7486964C538CE08E6B8D0DA904787E55D3075F982297393
      727EC673957F93E9A05794DCAC45F4B632448392BE22A79BF8FDDB4810598133
      DCA4443439332D748C5E20A41F5E65E1CD10463ABDF8B8F352CECA0B4387B800
      D3367D053AE389D19F3F711EBE7E17EB3793C87E127E863C1E057A780EAE15C6
      012C14CDD0212767AB6885AFC01B4E874380A1739BD92557FB9B0AFBFBE5F4C2
      20EB3531123EE2C2015CFE4C4C09AEEEE38E4C521C685DABE276565F268EAE60
      5C44F927D02396A75171BBDDD9A47F3B835E97FED3DDEA0FE83FBDCDCD3EFDA7
      BF3158A7FF6CF4B771C966BF834BB67A5D5C32E8F6FBF26D5C4247DE16DF667D
      7B1B17753ADBEBB8AAD3A5EBF0DFDE569FAFEB6F6E6CFEA647202F82DF767D5E
      FB16F1C6ABB4F5F1CADCB574B37FD42B86D8D3EEEA67CFC81F73BF55F77B799F
      B53FBA0B0A573FE5F197A5FA94E65CAFBE730E06ADC4F20EEE3BA3882B7D2AF7
      2837D4C2079A24B4BF547E5C9A3C561FD119C9EC14FB885CEE5E9AE0EA300DAE
      1EFD78FC74A58CB3E0EBABE5FB627893C4DF42106427CCE963723C394FA92C22
      015E0E1A5422645C923157DEEBCA4ACAAA10255D538F3CE76EF33C8DAFF9CE08
      B0A3D6E226E2D62C6995B6E428B6E6051444258ACAA452F8F5F815B5EFD22C0E
      CF267E605ADE13944EFCFCFA97272D31B4BFC1843D7E37EE6221745A1B9F2786
      AF6B57CDAD5B68769F3B3B32C3BE44A5A672EDC11E821B8C2AC7A8B48C1E854F
      EFDC1FBFD1A253F30C0D486F911EFB46EA9106FF0D467DECA34FF3DB8C7B7545
      BA30B87B94D6C6958018C5FE450E3C72609B33C7A204C6B85278A6DE0D9D058A
      99BF8C117D58D62FA6174BD4989938FA3C6A4C6614EC6538BDA8D67A705591A5
      8500EE59C4CC2C482C83DD126733C3C12CFA9A0D6BDAA23F4E10D97BA06E5141
      D25CF5E43FDEE323C4D17982DE4F623AD07596BC7919CD49E72BE985F764195D
      D2ED7BEFC321FFB0FE1E955D747FEFFD93E1D6FBC21FFE73C1F219454F7B9B98
      E3ADEE67AC231AF6DF021E32ED06F2D5E8BB9FB0B2E2BCBB78E3E1FBDFC902FB
      B78DADBEF714B1F4E08A0B91017C929A3C795288AA137C81B8F8A12CF5ACD722
      A0116ED2084F4B825DAE8DC000B5DCB94437E2820FE0C45C68851EC06226AED4
      AC3E23DEA211EFF985BF70BCBF9B516ED3286FF75757901EB48B963B71261928
      9139CC4A1E7790726018B8F840449A949041A4DADE9CBF7C3AF0106DF29E0693
      E7D36244BF5A6CA8BA4964D02389C0407489322DE7F1B32B29F4915620CDA5F1
      4270BD039CBFABD788A1BF06D05F4CE12C9E2142EB1222E44E2C32EA63A6240B
      0A544535733E3DD72A95BDA8EBCDBDE22675619F504AD55CC554A75E5221996C
      F0CEA8EE8BCC089A97766D8CD304B028B6BD2246DDB3F66A484175405B0479F3
      3C2AA616E0BE766280E2BF3277C314664059651025ACF2789A31947CE6C8ABDD
      28A1ECDD9E1EA63120CB9272E64753EC6E308F690D7BED0638C00EB713C6487A
      820210054820721A2B25013CC9ABBABDD653BA5D1D315E9AC6769966D1AF889D
      C5CA1702B0E00001B7DC2641866951A4E3719A4B8DCC5DDDC6BDBD4EE386B189
      4A5BD24E63AD12F0AAC9E1D0C8D1C6B92065D222DF1BF1415A0843A02BD46EDC
      38C31A281404FBAFA25737660095A5ECB65E035B5D693A7795AB8872698479EA
      72CA36FB8CB09D74A3D9732788B2603A46F75AC0DD371645534BC6B5E85A03C4
      BF17B14809C333D6D3F861919862634900AFA3AC00FB5EA30C4D36CAE2571B43
      6FBAA26E151D4C217C2D24FFA0660E3D494ED053C0EE87C016B43D0477480F9A
      A2CEBF72C82B3FDF8D2F501E6DF107726556A2A5D41EE6FEB3F6D0EF7A002F89
      AE4DFDD6D16269904F3328FD1E042B63552DA167A520B008E420FA3848C8F92F
      F1674999DAAB7CEDBB97A584FBD64B440F0828337450583E22E66AE4D606B290
      537418A3EF611E6AA326037E704D68745ADBB7CB6D02FA226821BA8EFB96510C
      6A89615157C97684D0C116D28D6C822BEDDD161C5C69CEA1A34A3EA997BC1E92
      56C218954CB35EA9342EDBEB9FB9D6FAD5156E221064E08AF655156DFB4E1DBC
      91EF78542A868C373431B7C0736763CDB4F2BF6DAEAF73846DA2C795EF25E473
      A803EA4F26DEB5C22C4B18BB5EA37BF8B476F5E19A154F2B600AEED0E5BE7B74
      D7EB45D3A48862AD58B455C98C60C731765E4F7592CE43B2F9F9E549FF17EFE5
      F1CE11B6C2ABC39317501E37595AB7013E3CFD1F32BF986BF83E0299A0D9C08A
      E365614D34EE76D435B1605131649EACAB7AC9EE21C97149BEF432EDCED78D34
      39E15029B05F6B798DE3148817A9B713C78D726BB954AC6DDCAAC0247340B06E
      87D1C36B6D87D74645648CC6C2088BAE894CA873CA78DDDA2CF20148039B40F7
      814DC7A4106BA89418D2206A161F7948489C914703B05B1C345C6E72AB9961FF
      8051B2ABAEF1EA0A698FAC08A685962308648BF4375BCE66E98E51D2374B5F7B
      A7ED3AC993E277219153DA00E9D8DB793B7BA0DE54BA896A36CE0796F6F9C96E
      E9B0CC2A40BAF05D946CFD3EC6292B99D678E325998EACEE35C2771385C52543
      5894C0B37426CCF4D0BA541699EF99F115884FBEC91DFAB853CD74C1C367C28F
      07E747FBB9D75443E13539B5D12DFD9561F481F2E1493B86B72F69AD35B6C44E
      DFBCF6627F6862174DD282FB948438FEDD0867371D4F70D09DD9B64DB76914FB
      B582D46801107765A5BD732BEDF7228C172004A23FFD08B809FA3B0DE02EF776
      95A0985605DBE59C357A469B249D2AE1B9D81BC1342F48C992A4C6358C903D20
      120B9A13E5F95430F5BCDBBDE9782203CFA6090743E0A84B8F28F7126B48D151
      3F4858F6F7221264C4B9375AC27E01E75346581E279A6C81A6515014B8F4E88D
      258B5DA9A639E72838CAF592C843F298CD9F6BF92743B82272EE4D7C3A7E2E2B
      C543D148E0F6E2B8C41313AC96340E6BB84C1E3042E3484AFF31BC939F00B453
      94106CF7F88979C938DDAB421C9A4B9BC360F4709FFBD8B9D7F5D18BAA512EF4
      F8FD6EF55A0C0F2C859BE1C96844DB1D85667476E6BB74158730C8AE1004BDCC
      47F71E0786D951B7A4D4AC6F575738A77BC7DBA95E027970774C13416E101615
      48E3DA8F592B0AA0149FB351E2AEBB8C2456243A3417D4858B69A6B4739DEEA5
      DC4A0FEDDF89942AD55A464A8F9A7FC2CF8A9295280D3059ACB460045FD1D12F
      85C631BDD28782BE5833AB64D181B3BAC2611ECEFFB6B8979A7F408067179DF2
      90D6D16C16581AB370145572E2CDD7313B3EB2E7AA44F0D28775974E05C9A202
      2D6CB3CBBC2B7BED5E7BF30F7FF843CD72100F9B35EF0418E4D8DCB017BDC00F
      E0586CE51C97A3ACF23D84CF347F865B70C19C19159C33ABD2A75A5491C65E0A
      9381EF2B949912F55724DF86CC0EA06ACA84DA82C7F2D90932F32CBDC8FCB154
      E1FF5EA6E5EC6CDFD957AE3A41264095DD6272CECE4CC497972CE464AFEDF7EB
      25A00703BE6F2DD06009BE6C0340F51AE1C34B40C2355E60F55B3AF2F6FC1B14
      726461DBE463AD57CCBDBEA4E71D3E1B621BE29BFE7D8ABE05BEC3EF452A9769
      EC10DBB50C8EAB00AF8CF627486D5005E50E7B2028B2D856CDCDE79E715E9405
      543358A53591D6832EAB857512AE351A613489857AD1615A5A542971E7B87A2A
      7FFC3646468862CA3764F8F182DFA047582A9FC8FB8213ABAB840D883A7AA80F
      AD89925584EB606D81E8DC9E88661C52DA1DD1AF6843AF5B8DFB434E3A6903EF
      07B21C5757A01F49409C06FC5100D2171CB92C001B0DE528F90C72BA665718A2
      92759332C72016201350C7F4F4C33AF88DC3D91CA7F06349EF1A0639523C9A45
      A883BAC2AA289173D10FE69514DA8E1B6E0B9E4114AC97EC5872AB2B8B4E7568
      E1A75A60E638E05C45D402C6880A3550F935861346019AAE4367669772B37776
      02B67C2A958D5E2FA97EA0325820CEB0B8AA4086AD855A4DCBC81C6C462955BF
      022AAB954A0C32592F317DD41C98A9F52DD787D893B37892DCAE3FE24EA8BA29
      FF8FAD168B9F69B74ED5E7D7C957CA0CE912E5BAA4C2F1F1A0635CA5542FB9FC
      DB66A7837210417BE58677EC02369EC9AF98487EA344FD1436A2DA8DB1ABBD9E
      F6B0E1D6980289CCFD33908D4E1857477A4930E729171966119784D46BB41FA8
      C1CCFCFC52DA3DFD20D01C82CF6D619196027098876BDF65D1B72438CD56135D
      6984206BE223142BA87343C30ED6AD00C922F4E33373802313D0F660EBA243A1
      B8E7F8B637A5E49F2AB4FDD897D7FDBDC8BEF1F39E31935F5C0D5FF3448BF8FE
      07D12B69B85F6B7CB4B707B57E719A5E4902D2062339E16AF9CD864605AE8667
      01500C25E0ADB07D3108156CE03AC2146C76D004F65AEB30D4AB4F4333C18A2B
      323F89ABA37A6C0499F5AF8220D31FCC08B88A20D31F3C8C2073653204887A9B
      9F25758DA426426A28EE7FAFDD6D77FFB35E2BE3DBA39874BF771493376AF0DA
      3E03E0DAA621E2C55CD3717BB66FCFC176BDE65E06E63806CFF7764A5ED95A8E
      2448E9B895C6238C83E15C01A675D26B792F8FDF8A2B5899AF7A0D5289B648C7
      B4D7EBF5E6B79B7DAF8ABC5593D7162A40322FD8A0BBF6B348E8F4D8FFC19894
      14AD5EA32A91F26BF9FAB0FE2CFACC5778F3EE577A737E4FC4F9DD9BF358465D
      2FFDE839DBE9F7FFF58396BFFCA9276D145F3F00D7C7B7F94E0EDC9D30AC70C1
      72E90A77A40416A8F96B9CB38F35F12F910ED93F7BED7C65253636C165A24CCD
      0A2BCA9513E45DD7CC8A585A901F11A2742BBE42B722424307C72F4F84D3BA5E
      F34CF3407BAFE49286ABAD5D109991E0B0B7BBCB7832F51A185E1AC993344318
      41C3FC35D230CBA3E5D38F16D4BE61955A652CB95CB1E8B85670EF70B7E59D70
      B323029D954FF6CF8EEAB5AE978AF9638AF97CFF6CE3196B67EBE3BFDE3FFDA9
      5EB34CA74BEF1939B7BF78C73B6F8F547DD56B08FB490E8602DFC2A84BC73AE0
      0111B3CD9DBF52D3E084A020931EC9109EBEF1397B662EA4BE0AF189340C9589
      B766235B5DD953EA86F02EF1C7514026BA54E98F22138796355C5B662D498EEF
      8D4D864EFA895F04976DEF1D82D1283F2C9EA2831C4EB71F4B4BE5CCCDA291F7
      ABC952EED0E4240B20567300F2A56256C712A467F21D804BBB22360DECEB6325
      6DD206170F722D712E3DDD4807A05E224235242EE5F6B4946C721EC5EA0A9EC7
      7CD0FC56F43E053929232D9BD3EB41639526A66626FC8BB31D7AB077BDDEDEA8
      D78B2318F0E89C2A4F73FAC3B7A8B09B383E3B5E73135F7AA52CBE9854DB5F19
      6F1825000689425AFC7031B534CF76A472571457E6216B285F6E0BA0F3A59F5F
      1AEDD0F3E3601AF3A128D5B0477B1B920A3D7F9902353E8E865995816D9933FA
      5773469D65CEE8330DCBDEF76D58AEAEFC7C76B62F96E52E1F7B683488A7432F
      9F4E90EDF69A702ED409596BC10A003872C50D855D609D145A2C8FDCB8F8EFED
      2008BE01C10E1455BDF602F9101BCF68B27FF11AAF4C82E200EE383D19FECD04
      45DEF0346923DCA4351B9AF32C74103B450C30A5490D6D70450C3BE9EB50EA08
      C0707675974563EFED29A7315F0276615AF4F1BB6A95E764DA26DAF20CD7F6ED
      298E98B6B96502341A7CF98716FEA23548520DF2B430F9C67586BF3F1DA57DFA
      C9991B359BEBD515A162A703FA399C86C1D3907C2B72032ECDAD1F9A201A9349
      A4B8264A7D1331B8F775144AAB5CE305029B4AEA0191A51978E9945AAE210E49
      4B8A8AF54696C8BB6CB86380FFBA498EEBAB67B0EC5DDA224A42D46D267091C6
      514C2F4E8E4EDED2101A57EB931B944CAD82907A6218A5E5FDD224AE599B71E3
      D4E442F7310D8A69661AF7C7ABB5E7F277AE969EF889B1047163A1D9AE38B17E
      7257B762E08645BCB169B9C56238B5DD84A1F7E28E6BC6D95121FD41167B46BB
      CE16D5BBEC9ED69EB04B02A0D37A8965750555BE5E13CAF67FC808583BF22747
      6043C9F276715BF066293FFCEFA9C98B73A0B9F287B412804B8192502E996682
      0CC1F4E00098ADD213801CEC35204FC5532E28850F2157D54B62D1187AD60561
      3C4E2A45353428AE15E26738BD90D2169E6CA8BEB156E9D66C4049A5AE8295BC
      0BBBEEBC3EE0D842C9D8F5B73C4D5A5E128D48FD8F11CF8CFC987E8CD350420D
      CB90C0178604960181CF0C08F4BFEF80C0CFEC21AA017F067A193A0CF7B55651
      ADF7BAD9043AA6B3FDDABA54EA148A23E5F5CB89A8D3203E70A20A683C3AF21D
      A776BDC6F67B3E649767E4979D919D766F794A7EE629B9B13C259767CCBF3008
      E12DB5B90BA426D03296C77EC1C97FDB0F2D7144C7731AA4E331F475CC658336
      9858AF9137CE94BBF893E33EF51ADFC7FDF1E501F52F1F504B37EE730FA8CDEF
      FB805A5DF93D5BDB5C0EE9927D556D7F11A737CC1468501E52B351B92CE64BAE
      C37390FE325582C86D7C8EAAD2D06B39C6D5159D3BFCABF3E75FA751987B1792
      94662081CC90078531624EC3E9848E32A4AB358305DA3A4987E52DF6B84897A9
      2DA6D576006947209099A718AE8931BC8516B7C4B644087B79787CE9E1B12C0A
      FADCC363EBFB3E3C4A45B4C36813AF5FECEFD412D9EC7793C3797BB4B387B812
      EB43339E14771EDDC4BFABD9306E55E36324F6247B71B65353DE593B1A5A65BA
      C8149214B00B06703C3E705D04F3851E1EE6813F3138D6EA354ED204F6A44635
      CF494F7E5B1E9C5F7A70AE2F0FCECF3C3807DFF7C1994F00D454E3A8BF340029
      FF736CFCAB5ABEBFA58B273D8C16662E4BDE3BD839ACE3584671EA17B6CC2603
      CA6DEDBC753FBCF6B9D2EA280DB99B3CF746C647895ABDC61166FEC5FF0DC985
      E473B0A1982BDC68328FC5DA98094A443469D7510890774698ACD7B04168A58D
      368C9BC981F4920DAB5E8329D39A356ED35C5D2987E1E168D4FA68249F50DBA0
      E90DB9E079A33079D19EF858941A0A71C124D460339A206AFFFAFFC3058064E0
      FD0F997C6B82BE8312EC7A4947E9D6F33C0D228006B9EE4708E5D15BF0FEBD8D
      6A7592FE6377E1B5BED158FBFF5BC63A4A7BDF60A87CF67C8BD126D7DF62B4A0
      8C4FF2FAA968EE8F237BC73BC92EFC24FAD5645EB3D3E27874770D71E89110FC
      16E4502A09AB34712F4A443F3E4DC7D371AAEFF8FC3FF4071C157F7EFC56E23A
      4DFA4878861FBFCD9BE97F00560EDEBC380A8AC7DFA86A5AD06251F4E97A4D5D
      F24DDAF34F9E3FFA3C8952595DC142E58627E1F14DA7C5645A28010E3B2D3008
      35EC673373E0D51B4F030436B1D0A51B9854B43F06DBD02337FE36487AEDF6FB
      F7A4649D8E7DFF9ECCDFFCFD7BDBDF1A7A7B11E0B50B1A486381125D6AAF85E9
      67F1ECC85BBD8C428DA31486E69825EA07456A814EEA36400C4E380911948FE9
      6C452E99397ECE4FF7F7B52E8C168B4B2B3BF262935CE04CB6682E16C1BE6612
      98CFBDB730C67BE5624FFFACB862F4836B15AF5DDA4207FBCEF8933479B6938D
      D3ECD9CE783C4DB44A73820C547E694C51B7752C037B71B277FE8CFEE9B24B50
      F2D970AED021804B77BFF2C9DEB06119AEAE78D309EB6E6B2F8012238DA735EC
      FC17591CD844EFDEC98BFFF22E492071ED4C101DCAE902469AD0809EA3E417AB
      36A02EF36FFF62FE6DBDDD5B963D7E6E026EFBFB4EC045793E35DEE6F673CF9F
      928D9B8EC96A0D04154D0D9939A436EE671E2178AFEC6A2810F3FC31AEC2E50E
      980D18B216D4B966E78508A5D327A968015D44D6CF2D77692BCF8C50C8A8CE39
      01FE2F9D0EE37A8E73B3FBBC42169CA585782EF4B0186760362ED9899A152707
      B90D5E2360DF130C0038136B75B3F12ED3E2CADCE555408C12D542A1319A8FEE
      EAEE63D33DBAB3FB940D9C281BB7502F3AF1BF41E4F487C78FC4F06C0300F21B
      84C59F7EABE1266962BE451AE0D1C71B25A49C8AB57A29A5D515D0797B6797D1
      A850FCD3BCF0A54A43EC31C4A2AEA20973F3A5CC26A7BA8AAE23EFB3096F855C
      EF8CB459310D14DD41BE4AD629BD0EB303A1B749505E4D7E5520534F4E5ECD64
      754F52EC994322273F3DA0D5575744560CD19B08F1378B73A2560F306B4361A1
      D58351F07C81125B4B8621730B7C19F3E0C0AC90185DD7BFF6A3D8962DD41214
      4E5E9AA92DA39CDEF18E53471764AC696510CDB1B88ADCDA43879D066C73AF89
      C60726C666DBBE669B010CDE3FEC022C39C22893F8CE3B4685035E9C89A8E368
      324C7DB059EEE70193DC4BFB8710768B0EA9D790AB8D5A8A4A6DB72A2291EAB3
      8453326E477E9C5B9E0BC0EA0A7AB5B67449701EAD4379DD6C584592920216C3
      503D8292D7A2653C4EBD27C22EBEF83294BA3CA9D7781FA84AAAA01BE5CF11C8
      14B20746F9B3E53F4DDE21EFD65ADEBB34238F760268AE17E4E0A7373992CE3B
      71F1C3CB5ECD76FDEA8A9BD3090299E4A2828E364DAFC67E76A5679A96DA3DF7
      58029D767BC326B47C7769CBC3F8ED6717A937F483AB7AC9A2D25530C2E02C1C
      F6BBD3C33DA041A6365993A4372DEF499A3CA968FB7A0DF57E6B60736868B41A
      CC6E01F4DB39E7ECEDE7355BD83A425B78E7232901EC453ADB133AD6C013D714
      86DF3C06D0BF3439D2E69EC406409F7A1EDCA5D3CC41A045232504A897285C27
      E8E9FDFE641D66F3DDF98FA72D8EE9B79833A425C98D893FB9CBA6396F8596F7
      CA14FBA0AB665878C7AB493273DD5FC7FEF511F7CA7ACDE2D24FAEF808FD5B9A
      DC845BF55C3FD296C7B2685A61E87258C3D890CC140AD1C3B787AFBCE6459C0E
      FD78CD4348147F3A6E7BE79786E9DC9E80E6DB3324340194DDFD09B9CF02CC15
      5AC2ACDDB4B85BC15F92908AD48D32D21E7DADD2495B2351F6AD28FF72FA6A8F
      C63BB4E995D43BDD7F494B8F19D0C4B0AE235D0D52FAC87873DD5926F5EAAF0F
      F7BA95A1D2DCBDDED9FDC96BFA1C3244E16FDDC688ACFE8BD7E77B566DC00AD0
      EAFB611ADEA1E4A590D43E806DE8CA632FA9DF72E5619E1ABA94CB3076F70F0F
      794FB21D70216D15BE6431385738AA2144BD9C09FD67CA76A5E5283CC2AAF573
      F2F2ECBC725E784DF67B9E9C455C87A476E113B58CD8461A8DD696E9D22F4E97
      2E1BFD3F335DDA5B3CFBDF4DBAD4E41365DC516257942D9372199A519A911EC9
      C7F59A70CD00F6369F83E2332FC8D9F3E8CCCB46B1E2C193417891993CE796AC
      4092800893C4291CAC890D9AD573D45BCF3DF11D0420C09DF174F681F7B400BD
      0B9C8EDC3B383F427727074ED9269C819A490C902C03BA20A95D110D1815D036
      89F23D3E1506E85ACBD8B6C9FF3E4519D430A365618AFB52D1E4F845C4EEB644
      CEF03D8BEDC9B0E739F9156DD3F67EFE3FAFA3E2AC4827BFD44D401C2ED91BC6
      BB5CF09726B304135214405BC4BF40A8D11FA26222C6CE31D790427CC7C624DB
      FDA9F21E0A347ECD74059BF60EE55F3B86991BF8A68CA928370646180A7F60ED
      BC6CE06B888EC7E2B70AFE0E65DB41014CF4E052B26DC5A5664DD83ACE6D11F8
      86389230A20172E9BEC059165D141298AE9B641E88BAB6BC37075CEB93A5F15C
      087627CFA138C67E42BB236BD9DF8799065B796BD52EDAAA4105393BFEB2FBFF
      9D7A4D93D83AA95F914F74C9B5FF5C9B751DE125D778B0AF8F0ECE6A096CE4E2
      88630E70A5C33CE56A7674FFC69593FFB97774B2F7A245FF9EEDB5BC97AF5EED
      F0BF67F8F7FCAC96639E2AFFF1E12EF9F1552710FD4F26AC9CDB6FCE7E7AADA6
      6C3D77A43B86B4B98A137F34D3D7C6F3E3C847A69347EDD1E90D3D05BD5DCF91
      8AD156C139B4ECB81C9BAAE30E75E1ED277BE2253E513EE54BC3ED1615CBE2C9
      D36EA7BFD51FF436FB83F63AFEF70486C8D030652A2B2A9A79047CB441456E84
      282D79397FD93D7C57EEF87A09692E1DD240A4E7FD7B6124F486003BC91BB604
      773E0752F3F4870EBDCA2F6D131652708C0DCD4C02F51B57BFD4D2152BBBAAAC
      693D339A5DFDD050747CA2B05EBF3A3DAD1844F44F369D383A3ABFB8BCC8806C
      2AD462FE75EDBCE999C12ED0CE47AFF65FF242851D28BAE92F8727BB7556476E
      B88D37C934A7FFDA7CFB5FCEF6F71AA47AB3FA0545CACE4E199AA4CE67A7F2F8
      F5EEFF6B2D48C22E49B3BF3C6EBEC4F9FBDCB879E7FB8E9BAFAE28306E66AE9F
      1DD3741E192667454C44CB19A6096DA2B6F7860C167F04738D0C39B6E7787DA4
      C2BAA9B5EBC8D9F9683DCAA2CA8EABC9623933406FE5A167E6EFD3280380A034
      1531780BE4349D90DE0C6B363099629F260945250F41B36016C1FF32BA73BDE2
      4FE07D46D252C5E95AAC847A8D9D03593B95258AEA53526A466A0FA5ACB66663
      6AFCD7743C617E94D4D96862A53CC96DEBDB249D4C27DC045FB3C1ED27084E3F
      D3203583C291C1292D7E5AF15EB3111DA617B28590BFBF36D94D16D14B27A871
      E81DBDA8D96056577EBEDDA3E5077EA5C28F493306C6724F6788AFA25A057EFE
      65964E2F2EE910C11F5EDB6C25EDC34B1F511FEEECC80B7F3C697B078537E650
      C2D0A03366348D715D81EC9647BB53B02BD8D4AB99B02CBE015D7A95DB73B382
      78284DBA804047CCABE4A96B7BAF354240FFBFFB13B70770768FB353EDBA15C1
      2F2A85F940ADA4F2C303F3F6FC48DA9C91A9B853D4CEB5C734E4BFC074FFED4D
      B7339BF2795EAFF5F0EDADF2EEF76D951F5779A161BCD54CEF1D3FD005D22CC9
      D43373318D7D58D62064675CC4B51A8EB29A606D9E1FFA43323243F8CB2DEF7C
      17ED4B87349217E96DDDC676A6AB4FABA9FC00587874AC7364CC36E64B96981B
      3C7F78C987148C6BF10B49AD93A761E8773DEBD0EEB456BBA3EB54F392F95D52
      F8B7DE25E98B183A032E72E63AB6D49B581E4C7A3081F52B5F1E4A9F7928F5BE
      EF43E9AD9F45423D1AFD8AB6F4427BB6912B60C8F89AA9B89329E3E24872EE77
      309E03898577BA1B2DFA6713FF6CE39F81D7C43F377EEE3550ECC6DD5A187463
      69495B857514E5C1525F7DA6BEEA7FDFFA6A756517FDF5E3348C46117AAA1925
      703CF18B6818C51179DD6CCC0C53FA67CFD01023EF2FFBEC89FF65BF67113373
      2066E6E934438F3A6A0F6BA61424F4FBC2CFCD3146E2020E79EA4D935C4235C2
      BFC6A69E0283815D7A1A80D744C3FF751BF68BBBC2EC60585E6C920B9A60723C
      324454B80065B3EF0DA3225F2604BF3821D8DD5E26043F536B6E7CDF5A93A798
      D40054C575A415D6E3341AFB09C9C3FBE7EACA3FDE33E2E0FB511CC2EDF9C7FB
      7FC78FA8027BEC77F57EFCEBEBFDD3C383E39FBCC665514CF2E7CF9EB9576D87
      E63AF2136033B549ED3FA3FF3E3B37F906DEF9E9018D307FDADFDCDAEE6E0DB6
      371BDE3FFFF90F8C22CBE387474153BE781CD3F87D30EA7EF170BE6808FFA4A5
      9D93D92A6B1B3FE17549E5DCD22EE094D0DDD6FAE0FD284D0BFD3148E3FC163F
      98244C2E4D66F8FBF80A6A7DB025F87EB2A083F87D3E2A92E1DF1EFF14AF937A
      B1B570E8398B12204FFAB6733334418AEDD43CD54E8D9DD3A39D9677FCF6EC00
      55CD7BDD16FAD94FEA1628D211EF5FD3AA82D980D81E23397917682840F6E660
      4F0A7490418EA35F7185B467D472A42F1F2A216310031BB5151214C7B356AF91
      6A1BDE7ADF7B4EC345C34D0ABC1EC027908D88564BC6E6CAC75E133F5C5CA679
      B1C6E93F97D4AB9DF7BCBA22A31E0C68D07B82A8CF113E780100E3F3263E50F3
      D3783A26D7202A006747D6328D0B6C788C368F5DAEBD555E339C72618CEF5DFA
      82C390193A5219EC6A38BD58036E055D1F01811F5EB9B8E4C2ABE3A3BAADA6F2
      EB74B6498016FFE692D3977E1862479050F3DCFBCBE1E9A1EB5653F236E0404A
      4991A4F8209C3437722DF3F5D15947C648C61DBD49749158100F5B917B707E54
      5B81AD93C0385750C139E3E63DC63FCB957891946A146A8763DEF676E23C6DB1
      B5D698FF6E035E2BF0034419D54C2E27956A02E5E041DE010B85415BE8442DD0
      B1C61B452ACE86860E137835351BAA6A9C6EB96176FD0979010ED5598B5C1301
      09E4965F6EA5A8B4FA86B48EE0D0C326A465B16734EFC6DF666070DE3F2826C8
      C13F06783D2CAE65E86F9944FF424F76F3FBF664EDD44A640B95346CC538138D
      A37FE0540A21C7899F9375EA35408AD3F0AECC1D1DCA75B3619090AE402E5AAC
      D81A8E62E6007BD440DD77ADAB9679D57F454F6D7DEF7A6A1759898CDD859B28
      8ED9B4B185A2C683CB754BC3E6521AF2C660FA6472615400FCE4DA30A9594AA3
      B8538084A1B98C92BAA92FB587BB1BB0872DFAA1B68D0AEB13A3DBA01C1FB030
      351B9DB3F7BB1DB6F77D21E950C89274E49D92158BF4B3F0B2313828BB8A64D5
      9D3A12108712CE11A5D8BF938C863466C01616078A3F4E1372A48E996A89EF5C
      5289FC65F7F0D47A4EB392D53EFC9AC9D64A76FD59A743FEFBEA4A4562D84CB6
      875350E85DFF8A347754C51BA7E9D574E285538E6371374BA8EB9031760012C3
      90F4D324337154C3D3D53A9D5BB4085F0833A0D630BDB1448270ADF7B4FCDE89
      260718753D870AFF4ABC4AAFA1C87A12836DD00A88ADC1543FF7B18C2040A3EC
      BCAD76E7CE606631200EED7EF62625DBDBF6CE24128BC91ED3A6A7A3C38F6D8F
      0F2B05E80F4D18C777764B188EF3D2319BD774E1AF23BEF79683D58052536989
      FE840F8DDFF6CF8EB8A1BBEDBDF083AB0B8ECC95D45B71348E8AD51571BF9944
      96FEEB60C7544EDCB2523309B9F5B4BEC527B084B57DEFEF539317F6B8D0E389
      C692F902AFA6EA6394F917E8F79736633A9386C6D2EDD279F2E1E556C7DE8E52
      5A9B24AD7DCE07CC74466AEB2030E9048C8AF7211222897F3D6614E7B6F732A2
      9DF6062516481021C4590975C16F35A311EAD2AE690BBABD8878B104C00413A6
      B69283A577A2862E04272BCDAEA4DC2391FE37FF69474162D00562A3E865E751
      DBDB935D87544CCBAEAF889B1701F515FD6AC2527A0A0929913434C6D74C7C56
      78081BBF4D2392C4F9DDC4289902999248414C26865C9AB67724A2C865F3CD6C
      B3FFF5CEF44F09F622CB64E9527FA64B3DF8DE5D6AEB11F46893BCE15CECBD0C
      8B9CF9A8815355DDB2AAC11A05745691959F32BAE873F60676D1D0301297CDB9
      EA438BE443C71C60F90BC9EA397E237E1510FED42DB75F2A6A36A1958059CD49
      2D241484454570F2C908BA4848D92A9753C80CE5561010205FDEB689C1303539
      8B30E720C6A599BDAF2DC2D4F3937F23E94A322345F48304ADE5DA4BB5B62C65
      FED7F5D9774E065C7A7AB0981AF04AA613DD160D49130FD35B5258C1659A4944
      689816609402783EA9AB9A291EFF3A8D801926AE14807903C08AA1EEC61A7DA4
      69538F7BA443339C5E2096F6A8ED0CBFD782DEC1B2A0F7F37447FF3B47C65F5D
      798703BB40B591D24FE9C919216750F889D20F1AF236D1BF492A8359992CF1A4
      D849259B294E64FA893EF363EFD8DC4ED94F3B2B8C3F66CF34BF4C158B9FCCA1
      3DB600FCFCCAF387E02CE1D7D0639D14D3745C4F94CFD595D74A56D494B23F1B
      6D5B73842DB01E25E13CA613D9864FC45084086C23F41E79BB69324CB3C4DB3B
      DCADA5341A008E52FBD03BD86B2CAA8ED46064BDC6778E7169198DC3D8595851
      C363B588E2F51AE48E7643410948F2A8C2404B7FD40CD57F7883F5F5CB7A0D8D
      B36C861319E0FA8A235A9F411AB3F79784965AD01675D251C09D42F524D65D5D
      69CCD206397428697C4B8208C692F8624A3C79B873BC277C742C0FFAE1C02DF2
      A61013CF3212AFB5BD93A4C2CAA8A0610C8C2656444BB94CA35F6B4D537C6019
      F716C2EAC36C62FA562D5059DA9D5F6C776E2DEDCECFB43BBF7B6449B50EDE68
      F23D8CFC38E5C4647137B1E4E68C16DD690FEA35F987D2C9629E85469B5A8C37
      2D46036D8041802BF3933C2E9B7FB42DA025082277AC65C76393ACAE28283AEA
      13CF8A8C370409464B1581C7A8F98B2205C68C82ADD74B5C0AAC49C786D812CF
      5CAE22BF8A2639C9240CC97C5278F4A536FD726DBAB9D4A69FA94DBF734430A7
      4D5F9CEC9D43A39031C2C66DE8358B2C9D0E51F5C791F93DFF26B99802A4D6E4
      75F3AEDD285F3AEA3350F3ECECEE6BB5B600160CA30953C5B0BFA91985038E5A
      94680F19D8E3E72B6084E249A32064C7B9FEBC05B794EEAF32892F011087C058
      27B1EE680D1BD380D170F043A54E9CB1BDB878A50269450EC0BC95BB241EFD72
      C5BCB154CC9FA998BF73542C5558E42F82848E6B9FC0EE7BF07AEFCC72F089D6
      AA1BF2DD0C41FBDE3E788AB5B06BE770F747AF09F3BDB167042986B507524E74
      0C35EA7AE8F0D15A2185CB197C3A33CC96A9D087744D175B5A9AF7E9DF13610D
      C111654F1B04D2526EFE478E9B9C1B4F8000EA259672FEEDD9C108065C479408
      93B51B39D6029F16BCFCFD6B2B2D197E5DC70D4B0310D4765E995FF648688E5E
      B3E3DAB4B475241156EFFD352E8540B187ABE303C67C5286C0BD4B3F674EDF99
      D0515D84C3D8CDD6A31F473997D63035527D19901E4474387BBD7F5853CAB6D7
      DCCEF874C89057650C33BF237376CC1BB7B13399D02A951EC986001834B994A0
      EC1C9C31FF40920B8ABE22AD99826F684BB90CB266EFBE439AF7EE57E31DA617
      F2FE08B06799498AF8CEE61AF3AF8192D3FD4A83E221F8743B37281EE6A8EBA5
      1FB5283BFDFEBF6E52F2973FD5A68CE2EB787100956FF35D98966757775934F6
      269A698ED3AF91587CAC693E19C6D135A29FA7D3041D53A2675E67292A034053
      7FE1FDF35F40127B1083EB4B07348F25F6FCD9B39B9B9B7682FA86711AE60CC0
      95EAA09EE12FCFFA9DC166EFD3A0C3E63CCFDF043AEC53DFF83E52D8A3E284FD
      6633582FC5BE74AC3F22C42349BFA2E1CC973AEB3CF5D211887398CD106721FB
      5A64969391DD3841C6A401FF4D4C9917E89445EAFA59667CBAF9109DD3CE7AA7
      376E7967E6EF8C6FD5F234A1C3F99A96678AA05D331BE7E5340617CF0496DD15
      5072240E9A79364ACC7EFBF93282F7C511BCFE3282F7998AE6BBC7899E4B54A3
      E3C3239F0F14D7B49F62384EEC176A4564BBB8E5FA49462110EAA6D47B717276
      C6908F1C37B20E54BD96CA2CC2E1359A39B90DA342774C7BE1BFDF9C9DD7725C
      E01D57C671D64A80D79A4E387835340015734562153A807A8DD4ADE51D8E5C8E
      536E648ACD851FDC79A7C73B479AD642F8EE8FBA8015EB483F11F65C0436E9DF
      23FCFB6E7FE7758B83BE747E1E9CD5B344D5F2B82C1E9E0BF1B10866437CD324
      F7474682BA933B6FB2BA625BBD6D5C84511E7150887EA899E5004AE55FBCE394
      D3145A17B877B073E8A1EF7D52B3881EAD7FC730276AEC3E633BF3BBFA17611A
      C700A0A45B7841E6E7E82E01E7A9D6BB733D3C87CCD402DD3BDCAD9930D0C1EF
      354A70A18652A0820B013828E0582C895E39763F4A631C7BD1485B046076C3AE
      AED941E6AA37817C4386C75D7990D302B8DDEC6B20B46613FA23CD8EB77B7E7A
      C8263E9B2462F22BE800E82EB0BA47A533B034F8BFD8E0EF2D0DFECF34F8BF73
      8A036724E9412F45A816230A1B4822AFD5483B2D8631AECE9F2F63ED9F176BDF
      A845ACFD105A4BECC3BCE51DE06C687967134336C25729DC78AC19A7F77F3EFB
      FA2DEF47E373C8ABA09F5FFAC1D7EAC678AC219DFA8179EEFDE84719BDFFFE9D
      A94C4C6DC6B02BBC4A26ABD34B9F1A2960AFD33BA3C0DC03E76A9D5EFA27EB81
      A7C9736F271BA719B9A5C69F2016BD331EA72DA8A5A511F27B3442E0AA3E630F
      FC1D47184D865A31D8F36FF64EC5F512A01990F07A373E5BB6648AE4B97F21C6
      BE8036D2C9E55F1F09A858BD56CA5CF0F59EBF9EB79716D7EFD1E25A5D79F17A
      EF9C69496D59FF1D2D71DB4F154AE859E2338C19C01C20E4B52785ACFB68C45D
      A98587A74E693BA064DD95DBCADDD825C68DBE4650EE116D3872448B08087882
      CE5B1D14FE4ED208CDED6F1FB97EAC1123A5E0F98AF1370B485C0E9CC75CB741
      E5052FCCFBD3C81FD46E4C2EB0E64E1B463C4BAE380ABE175DD3B08A34AB5908
      7C69AC7C6AC484DC47F3F22FDEE4324D0C7AA46ED840D144A8C4CDB576B65211
      5F3383E47E135A3E5B16CC4343DA97777853463FA69326E6D32C50721E68675C
      FA47B9AEC456563DC780E2C5542C3A52EA68311B910B0094857A49CCE65769E0
      AB2B85816ECB8AA726112634067505A03DFD008CF5B3FDFF96FC43130D7BC0B8
      95B484CBB40885818F32FAC0D454164E514A5939D755D70F615CCAFD777FDCB1
      65F0BCC06DD9BF00B35DFA31389669294B573F32A87B88381DD152BE43DAAC96
      83DEB3447E9C0BD5DC684B36B82FEC8E8A233AA31BB81542B3C9351BF771CAFD
      4E8C5C2E836A60835EC16EB901EE267E1360781A69A366A3B36950EE4BA29795
      2E58802A58989C28610C65B4EB84253F5A4D86B7BAA2FD1C2FA318C7300E9F5D
      4D614BDF40DB3B4E0B2308AA92DD92991EC91772F223005D21338FA99E64A06B
      3CF9091D4D85C847AF1509B5188355DAAE053D4E715A991CF4362A2CA0EB45E6
      8F5B822977EF611ADAC0B34C563FE21195760568C98663EAA903CE04F958E34B
      6CD4CF84A99E71C71456CFFF8BD30B2E849B4E522628AA1BCFA4B069A1890D74
      4A801AE095CF3B838C9227007E4B425B1D2185111666202B0B0BDC52E6188590
      743AEA570145C4BDB127F8D60CDDC0BD5574053F81EF87C7B4BCC9B4E0C28BA4
      5A9891A569610B33C4DEB61F92D84D302DF86E6C51D1CD9BB6F1A24D1FB63C9A
      AFB7F29329822540EA572807E82ECB013ED3B9FDCE7922B5CDEA4C7AE96AA6C5
      4096581261489913E9A97A0D42FA33C91C1B32B035636D0246010BA300662100
      DED3AC6E8C6FA7666CC643D2DA9334572E3B52F78890191459428B8F7DE685A9
      A1C15922F4481D9A5227B1797D76198D8A1FF686F16E1C0557351BD8CF3B71FC
      8BF72EBB33DE0B3FBF14767B5409291C72F39FF3FAA9CBFA697DFE701AF5BFD2
      5BFF7BDBE49336BFC7BD67FFC6BA710D5B51CD7A89D230155E1D17ECCF3B8787
      BF782F0FCFCE198EC3C34B4B89EB6CAAA196C3DADF3BD8F37CA68ACA4BA85B97
      0AAAD9985C04B6DA96C72A069511BA1CE3CA67250EA3AF0B144C5BF654294A2C
      C69A0942C5F0347E6E739C1E6023718CC0B6F6721A687029C8CD295321082AEF
      8C30048ABD5E032FFB5884510D2147A7833540CC91C64A4BD633F46D71DB16FB
      A55ADD6E00C33E72DA1BA3AF992C241E29F5404769F81339220747277B36226B
      F1E6117CB8F63346B82BC91F6B39D6D7877BDD5920A67B04B57C2E91B5485BA2
      8643948A1FA1B6934470953789B99F4760A71C45B7751B9D0D3FD8F4597A83AA
      C7CB6862D7AB3456D2F4A11DAFBEA33B4BD29B3BEFC6F80CD45B6D2F8A6EAB39
      F19DACB81CA769B68CBD7C79ECA5B3BD8CBD7C66EC65EBFB8EBDACAE4465ABD6
      7CE11FB68F043438A1C8F94480DA6ACDD3723F7DF17E5AC2447FEE7EFAEE892F
      5F8256795A1CBFE59D82FECDB19F5D2959B505478E465E389D908FC8852AD2E8
      4B5BED1AACB8E0B1E1BEA87A2D0D2137E7465E8948C5697AC57D918507143C25
      52AE270F51034DE8509282E692371C99C2653A8DC38A792CCCBF3CC1A6F0A3D8
      BB8EB0EB39A40A079AEB94969AF38B35E712C7F97335E7774FB119328ABE1720
      668D3671DF325F693AD6365DF08EBAB944BEF5328D393CC13DD97F9B8E27B984
      1DFCA296B0A1F77428AB1B0C7062B22BAB4151E78561EE27C87FBF4EA3A466C8
      C6AB2BE2799FB1E7CD10841C3D91BFFEA07F7F8D21EFCB9099601D7550C0EEF5
      3D660C08C11ECE81469026DA3A6F879C8A1B62D538C8052E83AC97A050E536B3
      2350BC9A91297E574592307C00DD78E9C4C06647CC8D23B59E7F41A3AAD78857
      57640F44C95346FDB643A1E52ECCD4F19D17203CC3E30C52F0AD15760D212CCB
      46548433036345ADEF05AA63FC004DE43742C469E4B304A0E031FD5939D9EA66
      71ADAE1C313986746EF1E8E50FA7CA940153435A1F344609B29277D2C2F6DC12
      21995B926A04DE1F3F6E59778F0515D0379794135F64AA74DB1BED257CC5675A
      2A1BDF3DA12F22ABB4B1F2DC64C522DCF280FE8EC282FB6980E53EFA97F75167
      B98F3E731F7DF704852FA617C8523CF74671EA73F9CA04D62C9FEB7E16E5C2DD
      07DB264629746334FDF5D7BB46DB3B0789351A57329323DD8AAD865E88B9DB90
      348626931BE82D118FC8BDE9EA4A62FE3EF5630659248B209D5EB06170E7D912
      75F539E2680C3E402916F283609A01C88F7E57D3ACD9F7867785599B7F34E791
      F2B6F7420A4AB9CC1AFC5768970DA4FB882B49F96BB9782C1A4B181A6FAA6F27
      2F2DB123FECB528D7CB11A59FFCF6F24C3C5BBF17365D8DB7C508624A00765F8
      39926B9C1AD939EA7F4BA6BFDD6E371E51725F20ABDF5E6F014D061E04035D6B
      8587B4BAD3524BFCEBE8422A3F8ACC188E563CFDB3F7905055A60B3F16BD2131
      47F672ED87A4802C62E6D020F208CD63231FD2DB071A1C449FFDE48EF3D95914
      56F8F8B8AB7F0CE942DF048A8E134AA845EFB186FE12FE8D352337157AF29B10
      A372289B359D1D052B6654D8E766348D6D730AFB64639AEC08ECD8E4954C513E
      02D8706D6AA2133C610E56F16454F78EA6C534332D26F4F1637A971B3FE1B212
      3FBEF1EF723884D71894AFF172CB2BE8354DFBA2ED498FD8CB93DE6B41052565
      7C079B8D1C427C90D085904BEC4F267CA18A56CB564A74037DDF9667BB25C7FE
      153CAA4C7B7912C7D04E9E39DF1ECE14A6C8D681556F8F00061E41F7585DF1C4
      C715EE7A1A43A54171BED070F8D0BA1ECE90197C85EDFF6EE7F4F8E0F8D5F3C7
      2E752471B8701766A0B2D67D6E70C95990321DB2337826B4918AFB3100524147
      A6D0A1C12196FE269A982BD9085C2CA0B7E0D99BE22C2EB06CF5AF48D3B017ED
      282D79F9E2DBA1999824F4E7D7446204DE9DAF033B256F551443F186A24F6811
      F2F943CF13B07C1072C87A92BD5DA46EB8337B8E5FDF97162D8B8F475608ED61
      981FAE1E7B8776474B4661F700D619E792209028B684608CD41FFB19F4491872
      83997F43264683E9A32A22A3CFB54706C4C8D3097EEABF7A216B359B0AA1D634
      412989EF6DF687343AFB689AB0775CA0BAF47ABED45CE9B5D7BDFDBFBCDE3F3D
      38DA3F3EDF395CBA409FE9027DF7ACC2B217F5EC875F8190246A98A4F9EF5E51
      464B7D1EA5011C432F8D11EC13AFA26218D0BF68DB0076664807929CD6A4151A
      F26BC0DDB7AAEB1ABCF37D6CE13B2E85A3AB03283A723EA681EDCE9DA400FF89
      801040E7B1D1B60AF4B0EA89DDD865FA3284DEF7B937BBE1686E6B5668B6BA92
      AA11C201E7A4A2DB48D15491B29CC5304EF3C202962AE1A47AAA63E327EAE341
      E7B382CD8D46AD73F87D37D0B0D502017771188568855C5DE18FEEB8593137F1
      C86BA27505939B7865C7613E6E79BB67250206D7E9AA5F69330743ABCE310AB2
      8A0EB80A7F6241D5F181B4DECB81622750317304A2DC1E687CA63C4D5201F2A7
      01603F8D8D9C9E7C5F36DCAA37C76E84BC72A3A315548E5C2C563AE3493857C6
      4C44FAB86FBE46CF26EBC03D1D3DB095C75F46D81ED517E0E79FCFBCBDB2884A
      7EE4295FFEFAD5E99E98D9C6CF6270B55862EA7AAD55B4A0B9715A98FC28640B
      281A7F3504C9471CD18BE905AA3839E92331132DB7082ED328B0A5E743232018
      16D1492CA87A8DF49C56E39B447AD659072BEC4539A1AA2DC4ED7A1DFBB41368
      A5EEECFE78EAFDBCCEFFEBF47FC1CADF97AEE6D73E2BA0D2DA3BA3EFEA6767DC
      FA46623D99B0EEE63638F9821A80F4A0B6F72A92A898FA7A9C1BCB5CA90B4062
      B8AA9F369C4C81EA8BB03513C772F93AA91817CB9827CEB64FDFA4594C5FE218
      5C342AE36F136C43019ACB0C7B6198734887939BAB2B0A6C239D7C9C1276BA8D
      6EC5C9AFD09E49D637A8DD01F4894B83152C229C4EDEDC58052B42FA91F8A4B2
      526C89FE8DA32BE9626F082F87F7E4A06A14481AF18977CA275C79887B615ABB
      4E96735703C003103D0279A14EEF26F7AA55271C1EA6E545CBBBC8EED4A31229
      933D09551A70C258F19278B5EBA5A1D13F42F0EC66CA8A0D62F4054944811F4D
      AB55D67A05D9E3D20F65E932E447D902B7F49BFE45BFA9BBCCBA7EB6ABF49DD3
      11AEAEBC4284E7CCC27D345F1D9D9DAFC9EEC47666101B77E2E4697CCDF4E1E8
      5A4B055524CD0EF65A1C13154BA1668A6C47AB5CF45C3B351762D73A5830AEE4
      1701B0BF28EE9EEFBD448E49BEBC542C5FAC581E357FF45D6741CEABF1464D21
      70A7E0D8FF5B9AB1E4ACE1E0C75171A791FC4AB063C8763EF2A45AC34437D4B2
      24ACEBF198CCCCE569F8858BB6D35E22E67CEE59F8DD33660AEE994D958CA20C
      41152415CA22023AE8C85C658781CDF97AAD817280BED785E7373B382E01F563
      8EB981AFDC074950BD4688B08D438A4023D0459ADD798D1FA3905C31C4338ED2
      D07B85D6A08665C9F3138C5D30FCD8AEA9D7889961C1B21CD200AD51E6D16971
      0CE34ED632629617A6A84476F0B744F27BB4927D0614284962BF0A3FD0B720C7
      9B408708E1E36BBFB8A4C98EEAD618B543F3C0B9EEC634015069D2B0516D38BF
      1C52925228ADDE472655ED74A605A8D768CFE6E3084D30A1AFAE08E95FC41961
      35C88BD4CBAFA2490B416E6DF06B79EDF69A763004D50A128ED535CE5CFCA0D1
      72BF1DA78991E44CE3004988C273EFD0A897ECFC10E9708C7C2A552052A06E9B
      1F6DBB463A1A4501524C0A1852AF414AE0FAB9579E5E019F5837598A7CBD855F
      252BB32CC5E1527BC71E21B1A12883723068EC714914DF2EAD2697F588E0D678
      6D6892486D70595E7CBF7A498F6C3093013EA5B831FE55995833A89288F2B11E
      8352645381590A62FCC96592EA35E8D5153E16476EC544F7F2718D17D328AE44
      7199E63C93CC4EC36BD2CECABDBF4F11CEF7BDA194ABD2DF22455F226D1B1801
      0C8711B5D6F676982880839BAE4C242445A32CCAF456880BEBC342EFC55D6386
      53DDC62F4B7246D78C5402C664E5F74104E36A6FEA098B73542A2A2428FCC924
      469656B95FA40CC616FD0751164CC7304983DA05CBE783E1DC8599A53736E8C4
      FE9097A3EACED53672040EBD67E0C7E2BA1FBA74754512413779D96FC555D436
      122510935C1428505A63334EDBDE59EACAEC6030183F8F381840B69E65FB0658
      709A5ED56C9B236B7687B2F20BEFE0C935B7275EA41CFCF787380EFEB8ECB4FA
      C228C7B23FE473A31CDF39E9CD6CBC1F7A57BA13C34A69132989BAB97F2F6D32
      959B9A61BEBD46CD0A1751EDA649A8D83B4CF4408765C8E3953ED7BA85385C04
      23F79A6CF08BAEE35320F6E9E8AC194FD5EA4A997EAA547FDD77F4C49A5BE349
      9442E067821FC2E5C0BED72E4CDEC7E9E9D0EBB968DF156DE458FA13C404B03E
      38F4E1E75A8CE1F016BDA6FA4C16901379FF899F6BCA4B1BA41D5865CD64FDDA
      1AC019574833814FB5D7126295F060293A258429C3841764D52ECFD54F9D96BF
      92E5F513CC2E1CB0FCDB0EADDF3DB0CD2C735E127727A1C07A6383141BECE632
      A5C5A7060922BA7B2919FFE415B549F119BFF883F72399C6A329AA468A05B5A0
      0F90FBE05CB3AE83762148FBCD6D59F7E8DFEB11590884FDF560B09F1E607160
      AC07635E149FD4210220EEAF3601657D69CBB555727BA802485FB2F361BC068B
      49A10E1C581334E134B9949EA1114DD6A5C4DA4F14BC1F9FDBD3F9937A17FC0E
      596B79DCDDD8A67FE1CB7CBDA57E6F69F73A1BEB5BB333ABC2EA6F6D0FD6E9B3
      B273E8DFDFA3D8CE847EE17B1BEBFDE17A6FBDDFE9AFAFAF6FD2FF0FA46AB04B
      1BD56C87667D341C8D465A4918AC77F9BF3DF97D63D8EF6D8E36CD567F7303FF
      6E8C36E8615BEB9B1B5BBD8DB06BB6069BE166E007DB9D60D83741AFB7DE59A7
      8BB6FA835130E8998D6ED8F75757B68361971E3EE86E98ED4137D81A9860CBEF
      6E05C17A30D8DEEEF63B9BC176381876FDAD8D0D7A99AD7E107637FAFDAE3FE8
      AE773637836E106EF77AA3AD6DD31B9ADE5677187646EB5BC38DA0B73DD80EFC
      ADBEEF8F46DD7EB74B8F31C3CEB0BFB511FA1BE1A8B7D51F85DB7EB8BAB2B139
      D81E743A7E67D00B363BFEC6FA687B30EA0FFDA11906DD416F6BB03558EFD3CD
      B6FD8DAEBFB135349B34467A8F61B7170ECCF6FA56B733DA5EF7FB6177E4F706
      EBDD60D8DBD8DAEC6E0ED6472189D30421BD7A270C3A0333A4BB747A03D30BB6
      FBBD70CB6CACF7869BAB2BC3F54EB831E885C6988DD13689A16FBADBEB437A87
      DEA8B7D9377ED0F7FBB40306BD612F58DF26C199C01F8CB6FB249BCE268D8D7E
      1D6E77B7461B5DE3F7BBF414BF13841BDB01496AB4DDD91EAE9BC186D9DCA069
      E9F436FC4168BAEBA3EEFA701074BA416FB8BEBA02616F8C82D126D9F71D7A80
      D91C8E7AC36D33D8A6D71F869B1BDB9BC1300869BCC3EEC06C05BDCD0D1304F4
      1A9DD1A8D3DF5C1F6DF44666D0E985BD20A0D7186E8D64AD8CB07A68BD7C689D
      D16C900CFC2DBAADFC719DDC9C0EFF30D49536DAEAD21A0BB67ADD11AD2BFD79
      808534DAF4B1B2E8FDB7CC68B0310C498C9DAD90E44D23EBD0AAA29918F91BDB
      EBFD1EA6672BA409E974075BA3CD41B7DB1986B4220CFDDB1FADAE0434ADEBFE
      70487226719BD168CBDFEE8523E39BC170B46D3ADB7D03E96C6EFBBEBFBE19F4
      4CB74F0B2F186E0E4C676BB317D2E21CD10ADE1E6CF87D7FABBBB14EAF438B67
      7DB049CFA5670CB180838DF5B0E3F7484C61AFD319FA1BFDC170B3B7BEBDD1E9
      D22C8C068370BB8FABBABEE97737FB618766783DECD20B6D84C35E7FB3DBED6F
      8DFCADEDCE566763146ED1CA1BE0D50CC98C76466FB4D1D9A48DB5D5DBA2A198
      C1C81F04DBA311AD1A9251106C9BFE28E8D0F747DDC06CF469523669CB6CF7FB
      C1267DB4496FE077685F91EADDE80D435AD383CD0DDF0FFB1D13AE0F3786B4E2
      C2CD512873F32933BB39DCDADEDEEC6C0E54630C7CA749F87FA439E809A42536
      BA23F97975A5FA1B7EEE87740343FFBF457AA56BB50A0D26E887EB34F75D6815
      9AD3ADD0EF6C6D6DAF9336A0C918D232ED6F6CD2A60F86BE190E47F466FDDE76
      D0F1FB1DD22F24D1ED11AD6BDA81A637E8F5B60213D23AA62D335C5DA1F1D00F
      3491C1FAD67A38F0373748E598C1008B7A8BF48DBF45F33608FDFEA013D04405
      9B81A17B76688399EDAD4187243EEC0F68A385A3FE362DCBDE06BD1BA90A5A83
      B432C2E1461876D7C3CDE106A9AA8D6EC7D05C84E186A1FDDBA78542AA8EDE60
      6B63CB0C6836B7BADBB4CAE8431A084DE87AB737F81CF98FD683CDDEF6C63629
      E52DFC2DD8EE8AFC371F92BFFCBCBA52FED6EB58999B608374C480760CAD495A
      45EB23D327E5118C7A5D52175D5A7E6640FBB14B1A8C16D636DD92BE11D28049
      7BD3FA0B479BA48BC3EDED111D1AFD6030A4F365D3A74B363BEBF48BBF350C68
      22BBDB348783ADD5155260A479481E7DFABD47133AE8D20E1E6DD39037B787B4
      9069FBD24A0F7BBD6DDFD02ADBF0E92832A64BC3DF1E0CFBEB9B24EC219DA423
      43DA7703FFDFFFFFDB3BB726B98DE40ABF3382FF611EED0747A0EE40E849D425
      B461492B2F69FBC52F05A0208E35334DCF65BD8C0DFD777F89BE4CA3BB814115
      B9B61CABD6859C9ECA4265D6C99327ABBBD1FD10FABE1B5CD2BEB72DDB0BD305
      3281D424D8B05D6A1331613BBDB6AF5FD5FD1079CA50250061104A81B0DB68AB
      C646B221714153856006F015524B3EF69612A88144D5046F2B039FDB1019D9C1
      D2B1AB136E3A93EAE015E439C0FBCEA6A4DA41BBAE55E43679AC24183571A532
      F535545C73F586D5F521261DEA1A76498D89BAB2BDA58C26D89F124B6930B1E9
      01558BB326453F10882A6A5C4ADE5840197B266C404C5F778EB4375A0FA37632
      16664DAA9248C013B098EBBB3454920B4999A86C50153B3E583C542E844418A3
      501A40C565800D1FD9CAF9C6F8B6666F9CE96A248986394D84318DA95B00146D
      1380F550F56D6D4800AA041155F5A0DA103A8F8BAA6D9105A015D2488283460A
      57671101C0C5536382AB2B21C90151512B7697B4E9F142F581AA0DB153839917
      A42004AA086B0B3103D786203065C3FFF021C2426A486C766D6097011AD0D4CF
      16DA4E7E48037EB7944162906C080405B651D699869444B7513A60119E6B436C
      75AF956D499921F643E552AA2C6E77BDD5882F572305741D0D2310202441636A
      6A660B4662A75A5D35642B2867FB41B40D9E94609B1B48AF825F14ACAC29069D
      365D624B1BAFC9970EE444D508928078636995A1C8AE83A42360D44898A8A18B
      8E9AD17488099EA85AD609AD85A470176566C794804328C1553F681173F022F5
      8700908090D2D053965FBF1A9C70631F0283D80F4F05ECDA0672B13812FB4E63
      C55065E4CF8E2AD10CA192BF436FD4A4817034182B873C4051029DC470FE350D
      439C418EC0D3B61B14DC202B600C7F076041E640A5B5F2676CA95A0321437906
      1343673D0A066C5014EB9E687751694799A9D1232609F7EB2019A554CF2F2A4F
      2CAC53B51457E235F49E228C02A801786B2DA5D6510B6CF4AA87A660221F3D4A
      744023C048E803A8A1E1223DE297B216D0749A67C19635E489B74DD33B787A48
      CE754D8496E005365E23C3680A919E9D43B7C097A25F02EAD2B59DE95CA22257
      D410DDB45D24033DFA0277143C033430E95C47756E0864ABB0EC740FB9418920
      C44448852B27A3BA844C03F950656D8DB5B1D32C17C569342CA9231D09F8ADD1
      53C61B4099583ACCEC0924A55DA34B5AEF5C4D7E82DAA6B6A829F4408D300488
      680838B10330CAC9F613251C20FE4CDB32C2D6E874CB732D921FC6891E8558B9
      5093099AF8B04052C3831592CDA065076084A4E262EC0ADC3D506C60D7C60A59
      7A0A04A84EA102EFB6B3F4053DB9CB2E90499E8E036027368CE20E9B495D60BD
      E83A2D97F1E4744359921877B5E71295B1EC4A1B91428880DAC3730305A047F6
      F01375B871AE82808701A51BD05040B3239DD0636457ED6147D57A74241D8B55
      689A9A42E59B4A29348EAD90F89444D5D3B828A0478B832E67112492496DA0F3
      A10636543AF22E0EB6164822240C7356A8DF51BC9153408F5DAC83C33376280C
      E8A701211328FCF006EE90FB70E2504BC082607F00A2AE029255F24D80781C24
      EA7BB893420ED9D28F484D813D87240536F02F15AC86474926057F1A213691D8
      5621F5A8DF1E2D414236DD288A6437613F08C0830CF86AE4031244DA074DC124
      1C50778F3CAE25E124C1B9BEA1BFA1698AC2C0353C253D8A692070F4178B8047
      9CA63A44AA9E435A26C29E48B64881AEE0D5867C1D2C6D1B64805809ADA56CB4
      95B03EAC2C313048DB911D080584409C85E8BDB45E1D72B9655FC0209041C821
      EDC019DB808643F53990D2B9169502C944FA2394A31B626549622E8D42609C41
      7E2013D0C20361C0D84AD340E29097504FFDFA152C0528BD755D42E0A2055A4A
      0B74209A32505C91FBA6D26C014D114A8CAA140870AB2CB28E0A48AA589291A4
      A190C0F3C175AA1F684242DD80420041A5EE22EB3376804D52454F80BA027968
      052A22BB50250A7C457A8992F174245C9864A1B5A8A384C9A23D2011CD4643C3
      D6062E445DA41D44E049D98C081904047282CDC16DDA990AC5A3800DC22A3854
      67803D98A0EED904651A2E89BE9036A4955D209A88981429D3D471E401CD0285
      A18611DB9EB10D58D0545EDA6514906E89B0D40C64736823C0B7F4780D00D060
      8BDFA3F2D9792693BA9AFA486BA4981319072CA80695916A878620A72DC21F46
      12CDD455A989E4961B204B54203A935EC019FA333045252201A01C5115F81794
      9C96342DD9DA362A496C1D4A550140C7BC140265E98EE98CA05156466AA2FC6B
      3603FC5B140F0540217FC88098A8CE03D338E91AD85F84002A3ED1EA105CFE4A
      0E1B8A06EBA5FB46008AA4400F11307282E242314518A3D9E897EB061643C74A
      87E050277437E8692BB5866E13722467352C43274EF743C6F80126A032C1FEF0
      368D08E26550289980088B86D500DD8A0EC257A26AA1EC868CD52D1B0B17C2ED
      5E47A942C8AA5E43B3B5A54E41AD546ED8298211E20AD3A00091F314704A4640
      637939FA40F40C8DF0D2402E50C382140EE7048300AF4570E2690892411D0283
      04F27DE8D994CAE2841FE946D47ADB41AE6C59D528FA65037E2A8356962A4006
      C1410098B697C88109DA649AD2414A231B416F4255AB63C32EC03B46BC4E8ED8
      F583C87D782EB43A42205D05C75B115316CE22956178C01AA957C8506AA96527
      D8261A3FDAC24ACE5E104DA8E6D836C85718D1913750AB83152907AC14DF3C55
      BC69C90ECA0A2AAD8F4D0C35244E90503BE027B9C14344501BB184C8230C06F3
      930ACD10C138FF2A0D2651BC23CBD628D4CE0FAD6F1C2234755E8EC860059624
      0D61D547AA338B6E3C1821695A30116872457307279C28B33B208DE38DF84713
      C44F542EB29F9D851411B791624E8B1C683FC4496A469FC89F2A123C395E0A6D
      2B8C5D7B0F3FE00AC293B24DD7089942E9A81F0A3E3212E52D1D1268A2E6C270
      E8038F66A5B715CC5431818F9E268A6DC33332C6780A8F761ED545F96EBB5EB5
      951C9D55F43B085E91AAC85054C49090C4E8F2443859272A29051E6832DA124F
      1BD5492F0A5BD0E6D0B445BAF3D8D28549EF0C47C3AED03C140C7C43D7137FF8
      3FCA7B0C0924FF43E4D3A9D0950C0AE9841820C0A6A73F236472D2C062D1ED96
      A6C47051328F02813BE405CA07705135C981048543795E8E8074E04A81C0B10B
      2439EBAC68FA3A506DE4EC21C441644BC50EA00383709DF2F03BDD2FFA4534D0
      EA9E1ED754533580647796D26E6D75D8F7F4ECC2C5AEFEF814EDA5F395E929DB
      78D2A2A16218628004821C6A510C699A910E8DA29FEE514A1511A6E9ADADF44C
      863613940DC8574597457F8116EF2A18447A96565AF6A685899A9EEE9581864E
      D728419C42BE1BE9E95DA03423D3691613D4091112359A3EC40C42951001272D
      DD1A998628059E4AE8DAC265AF5F715D0486664E9A2480A083345E4DD743CD72
      2A4A6B9C1063A64686D20DE828F25DA13AE1755C0E74B67478831C9EAA20E73C
      D433CF0604A978959213878A9A03BD130691C9E8464DCBA284D09353A2131111
      E08865D7518E8968DFD0E16D8C1621D65179913F105DBF3B5F9FECBEA21DECE5
      D3FBF9E7F2FBC7EB57D585C7BA53FB97D62067B64B27B69757C002C75197CF73
      5FBAE64BA789971EF40BCD363A73675D2F65C24BAB7AE98CEDF22E509356AEEA
      F9FCEDA595CC3103B910E6234402C7A59594B1C6B85657F9C365DCF63FB73BBD
      A4F73A20E5D7D7AFE445A96E73B3B97FE8E4A5A9DBDD5DF7683987DDCC153CCD
      9582A11ACBB95BAFB5440681ADB5D02A0DA71C2B7A692382FC560EFC2C05D4D4
      320222B7E38AE5FF9DCC406419151AC13D73D13F541098BC020411187CD0B697
      3E4784D9760D648BE1774AECE8FD2DFF20474130CD81B4D36364949CA4F9218C
      6BDAD9A1D3888BFCCEEE7EAB852BBCE54F452519D73C7A49CF6AC81283CC97F1
      9E7ED7A7D1432CCCF6CA1DBD851A7DA229DE3D677DBB7D6E1CA70FE3F4619C3E
      8C1B9F636E59F3C800BB3926CF3C8F6105DBE7F4D9A8F399CCD9187336C69E8D
      B16763DCD9187736C69F8DF1E3989A884B44DBED3EED7F1A7FC74EF8CE4E479C
      3CC738B0B0C3A4BC0DE9EEF1E1F1E34D7AF88F9B87FEE1F1FA36FEC5042F3FDC
      6CBA5F129A62A8C65FA5DBEBED2BC6FB67B62F26CB6740F6CFFCD7F68DD9FB1F
      3FDC5F6FEEAF1F3FF273D3FCF579CAED37C65F1D59A8ABE3F1D5D5F3D8EAEAC7
      F18B0ABE981DDD4C46BF4FDB37C6A82F5EBF9A2E7B6BF5BC6835BF80CB53EA2F
      3EF384E6734F683FBFD3EE73AFD17FEE09C3E777BAFEDC6B6C564DB8B7BA26C5
      FEB21AC153AB75209DDAACC3E1D4C616D8B8228FD601666A130A6CD66DFAD4A6
      59E9D11E1D660A8FC74DC7367FE204EB767C6102F3E94EAC43C3C204EB686661
      02FFE94EAC03CDC204EB10B430411E4D6C0BE3D51FEEE4E65599A9356C368F77
      9BC7ED6753B2AE1AEFB0DBDDE03BD756E830DD6799C8423129218E1DF99673B9
      719359BB38BE532E6BF98FE347C636C3D570FDF3D37D7AC87424DDFD39DD6C3E
      1C6E579C75ED83F17D7A7CBACF5BF7011F874FB29582E479823CD7C78F456D6F
      969275E90FF1E7223B74ED2738BCB71E5322CFD10344E2D3E37BC1DD75CADBE7
      DBD8DD6FF250B98959D9B1B7FBFEFA21D73B31B97AF3747393F2A862B4FB317F
      1B47BB3C11349AAC2D8213A33C11349AAC2B7417A257E2D4CEB2C8B79D6D818B
      3BCB024FB7FB5DE2E9CEB2C8D39D6D81A73B4B37DF9CAA692FFBEEFAF1268F58
      BEBAD9C8879733FD7A7BFDF35D94EF8FC85224D339BEDEBE7B7BFC7CD6CFF7F1
      C3FBAB6F37777949FC66D37FBC7A97AB120E5665D266DC19F98E92EBBBA7BC58
      4F2C4B5078B0CDEBA8A6B66B9BF8CBD67959F7C3EE4B65BF7B166697617C02AF
      A7F6311BC96FE3CDD35613643AF8757CCCBBD23380BE1D6F0DB583D1A74F9189
      891F45117CB7ABB3793E3F5F3FEF92CF7679103CCDB9E2CBEECC7389F88DFC25
      9F2ABEFB28777CBCBEFB25CBEADB8DDCFC36F553EB8BC0D77A8AE147B995C9CE
      B7CB0653C2FFE6F6C3FBF8709D27E8F69FA2BAFA217EC832FC493ECC981FC56F
      FEE956BEABFDB968E4EDDD77EF7EF8FEEADDE6836858B9B768DE0E8AF11BB917
      C06D91FDAE09FE877F4FED3FE65FF84B94F3DDC7DB1287BF2CE8C846C3AFAE33
      E96C6BB5E90BACBE3E7C7346898BFF9C3EB69B78DFE75FF727BAA831391E5381
      F5DB281FF8CEB7938F94FF3749987D5E305AFF5BBCBF9656AC047EEFB20D8F3A
      E487A7F63F539797B23F6E4A9AB13F6E3FA1BB950CEB0E1E2F9AE6158789695E
      597AB7BD71FFB5E021FB407C629CB7E48969C992BF1A6FCAB4F674F7B2AD2EF2
      776FFD29ABCE6B8576B6F2F2B67CED5D91CB7BE3429FF7E6454E6F6E9E6EEF1E
      4AD73DDA96A06B6F9B2B95A6D6855B35DAE6F50A5B5BB94B6351A846C3B2ED1D
      4D4BB676342C89D068581C9EB5AF455C30CD7BE1EAC830EFD5ABAD6141193832
      2CDBCBE2225070E0766458B297A361D95E8EA6257B391A96ECA5F9FA2A8D5F78
      52466447E665FB7A34411909DF3DA6DB0F9BFB78FFB1C0FC9B9BF473CC6CF1B7
      963FDD6F06B93FA0DC2CB04C5F3CB58FA33829362D291EB43B459714BBB20D16
      CBCC3305F98E99CD513F3AF3CAE7338B1538F44EDE4F77D1EEA829EED2FBCD8D
      DCA5F0DDF3CB3397CFB94E45F6DB0FB1DBBF4AB21FE4A72DFEF7E35D01DFBE7F
      7E39E530505D1838CAF6C9287D61D4211A87516632EA87D45F3FDDEEAFBA83C2
      61AC5D1ABBDFFEC3687769F4516D380CF4B303F57460B834F048391C06D6B303
      4F666C66079AC9C030DD9BAFE3FD2FC78DD261D874670EFAF1D22E067D79ECD9
      46067379E0F95E2E00E8EACBAE93A31FB50E49CFC34F36750E5433F32FA36BC6
      68196633460B689B5ACCE5F39FD29FAF1F9E4F342EBF726F4FDC7F387A1D63E1
      B46F0AB37F79DAEC8E6A2E5F64BA8D7FA082DD3DA423AB35893313A5850C9ADD
      F285649AB9CA42565DB6984BAF99D1CB593663B4906E73AE2F65DE8CEB2B5250
      E7A5A05EC7EA33C3D725E01977AF4B419D9D823A1BC0EB4BC08CC50AF89EB9BF
      02C03A0BC0BA04C03A1BC07A75E198757D05804D1E804D1E804D09804D490531
      198A65E6422B006CB2016CB2016CB2F9F7D4F797006C4A006CB2016CB2016CB2
      F9D79E6EFB4B00B67900B62500B62500B6D9FC7BE6FB0A00DB6C00DB6C00DB6C
      00DB2CFE3DF57B25806D36806D36806D36805D1EFFBA5C0DEF4A00EC4A00ECB2
      01ECB2F9F7CCFD150076D90076D9007659007625FC7BEAFA1A00BB6C00BB6C00
      FB3C00FB3CFEF5A71BBE0EC0BE04C03E1BC03E1BC067FEAC00B0CF06B0CF06B0
      CF02B02F01F0A9EB6B00ECB301ECE77B71358DC3EE6475F2EE9BCB1DFFD4BF7D
      0F7F305C3A6350972EF9A7C9DBC72F1BEA8BD75C63390DD29BCDE6978CB7941E
      6699E2F2CD757B73BD194F463E7ECA47E94E4F75FFF8D5E1BD6FC7C3ECD9E9AC
      BC65693CCB9DB6E856CF0E9CB64FD6CC0E9C8A4E6B67079EEA0EEB66874E69D4
      4ED36984EBFEA51C086F3AD6CF8D55974687B9D127EED773E34EBC6FE6C69D3A
      EF667D72235F4CA6756A6EB03F64F1D440CF1984CB062F86EDF211CF42FCE6CE
      91164239738DF9985E367829B433562B623CE7D39A70CF38B736EE3A37EEAB01
      3C77FAB122EEBA28EEBA38EE3A1BE4B3CEAD8DBBC98DBBC98DFB6A06993BAE58
      1B77531C77531C775386F6B352F172DC6D6EDC6D6EDC6D11DACF883F23EEB638
      EEB62CEE2E17EDA75DD58AB8BBDCB8BBA2B8BB62B49FFA9413775716779F1B77
      9F8BF6D3EE6145DC7D51DC7D71DC7D31DACF9C9BC67DEC88568BC0A3D18B35F4
      68DC22851F8D5B6490A3713B09B8481C47C3D789C023837522F03C6CAB44E071
      FC660CE60339AB1AE763BA4A049E05779508BC18E319CB15C19E756E6DDC1745
      E0A5B8AF06F08CC1CB513F15566BE3BE280217E3BE280217E3AECBD07EAAB756
      C47D51045E8AFB6A069991642BA37E261D33E2BE280217E3BE2802E7E36E73D1
      7EA61A5F8EFBA208BC14F73C0A9FB1CA88FA997CCC88FBA2089C8FFBA208BC14
      77978BF633D5F872DC1745E06CDC1745E062DC5D31DACF9C5B1BF745117829EE
      8B22F052DC7D2EDA4F85D5DAB82F8AC0C5B82F8AC0C5B8E7DDC3EA074CF23FB2
      F7F656BE22AFEC13B1DFC587F78F31EF6620FF7A779F1E3637F2BD9EFB05E72F
      F77B59E9AFE397B6C9F7B53D3CCAF7A4566ABC9DA6DC5A54EF6EF5B9BB0DA895
      6F7E1A6F3A69B44ECE58E56A57DB5E6E7DED9D57F2C50972BB4EE3E5D699171F
      7E3B735F758352A98AAA552A26357F03D1EDC3A46ABCBFEB908641BED0E4E8D6
      9FD3873AF9F3E417623F1C6E6D7BFEF3E1F9BFE1E3F5ABBFE5ECBFF5C7EFDEFF
      FD3E2E78DFEFFE4CFFBB2BF9BF78FCBEF77FBF8FDFBD5F7E3894861FB6FF055B
      8DC2C3A2427CDAFE1C7822342FA984F2C7783B75375FF7ABCEC7BEA9EB460FAA
      B74816EF58A9AD1A6FF4F88518330F5DB906EFB58B556B741F2A35A7387E2B8F
      D908143E2EDFA0FEB7FCF89C11F8FFE7BD3C3E57040ABCDFF51EFBC7AFBFFE0F
      3AFE451B}
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
