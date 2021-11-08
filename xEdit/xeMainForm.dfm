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
      789CECBD7B73DB48B227FABF22F41D10EABDD7D239920C80E0CB736636643DBA
      7DC7B63C96DCBDBBAD8E0D9028921883001B0025F174F477BFF9A82A001421D1
      7A5174D74CB445514001959595AFCAFCE51F17693E702EFC400C223F1E3AB6DB
      BCF0E32CA47FFA93A1E336DD8B699FAF18349CA6DDBEC04FF6459667A341D0EB
      8FF0CB16FF1A25955F4761E5D75EA8EFC76735EC8EA33E0F04FD968FC458E8BF
      E9DF06C22E7EE967F61F178324CEF35E041FEC0B183708AD8B419A8CFDF862D0
      1FF9692672F87E92FEEEFE71F11F17133F4E3261D92EFCBF6537ECA6EDC17F2E
      7CF2FE3C0FC722B33E8A2BEB33DEFEB73F6148570F394E0291CE8FE954C76CC3
      385D1A1BC7F460CCC3649A8622C551FFF6E7E6068CD8A87949F7E64B36E1FFB0
      0AF05F1B5E16076DFF79361BF79288DECD29E61B87D1ED03DDF8DF9FBF84F130
      80FF321AABE17D0BED90664C3BA4A18BF3F4C7BD34F4AD0F7E3E52136DEB21B3
      AB30CB6E1F724024736970356414C2983C55B7F12D83F524FDF93F58DD3FCFC4
      3011D69777345A0433FC77925E100F3F36D3D0DC835EE909CEE3B3E5282C8DEF
      7E1B9D1B8BE96CBD0F87A35CBE7FAF3C7E1DC73EE0FD6105C2588DFF4DACF70D
      2B503CA1F9242B508CDF7A244E57B42F466E3FFE9B371AAD3A11D4E8F0B0D6DC
      7DD6E1B1BCB5EE7D5C5CC5C5B7CE5225101ADD9ABB9D965373F78FA9105FA584
      AADBA94ECBADB9FB7C9ACA7BEBF6A0D36ED7DCBBFD93E8A5E26A470EE0D60E50
      47B3ED83D4EF85FD1D357BAF6E1F399D56CD106FFD280FFBF20DEAB689D36AD4
      BDC1CFA1C8631FBE14721ACD569D3E536BEF582595A5D7BDD9AEBD4F2EFCDC7D
      C5A237BB75B7AA55AFDE5A5AF1965D7FABBBE056BDDC2DA7F646B9DED51BAB6B
      DDAA55FA6AB1E7EE9E5BE856A3F67EB9D2D5FBCBABDCF2EAA7DC58F4ECF9256E
      B5EFDEDD6565AD96B8D5BE7B6B57EFD34BDC6ADFBDAF2BB7164BDCEADCBDA92B
      B7AA256E75EEDE4D951B4B446E75EEDE4A957BAB44A639B76B657E99CCAC5825
      85DB769D4154A6B0BC6596CA7BBA35F79449CBF714546D972CC3F9BBDCB9BB88
      A03C25C7A9BB4B0B49755765C3B49D3A0BA4108EFA46BD57E8C63AABAEBC887C
      6369FDDA8E573BBDC6FCF36E2E9DD36CDDBD76CA5E548B0737DDBD7AC54D72F9
      E0AEBBD74FDF552CA0D36CDFBD82FABE6209E1BEBBD750DF575944B8F5EE552C
      6E2D2F23DC7AF73AEA5B4B0B0937DEBD92C5336F2E65C590EFDCD7AAA98C5227
      CAEE3070E686716AED8DBB2C9D1BF3726A2D8F3BCD9ECA30B5F272390BA83256
      ADFC5CD618AA8C56679D2F65175546AA537DDF6022953D37E77E2C75C30374EE
      CF54E561DC7B33D5FC40F764A91B13731FC85495B11EC254F363DD9FA56ECEF1
      1198AAECAEBB9DA50D07F2C89594AA8C51A7556E5A12720C6DAC958769D42A8B
      1BC6050F53B05365985AC571C3DAE061947CAA0C52AB426E181F3C48C14837E7
      55AB556ED82372AC322355466A2E6DA0F04825C95419A7CEE2B869B1C837BAA9
      ECCA3199C6BD955D6594FBCBA5F230F5CEF552CAAE32D4FD955D659807CAA5CA
      580F567695D11EA4EC2A233D825C2A87E1BC0728BBCA380FB2A0F430CD8728BB
      CA400F517695811E6E4115633D50D955C67AA0B2AB8CF538165431DEBDE55465
      947BB2D48D4070EB81165431D0FDE554659887B0D4CDD93DDC822AC67A909CAA
      8CF4509652EABD1871790BAAB09D8ABB97B79D945C2ADF5EEF60DF1290A90CB0
      BCB554C8A1CA00CB5B4A15F9531963790B69DE362AC658DE36AAC89BCA18CBDB
      4537E44CF99CA4FD107BA818E52172A63C50E72172A632D083ECA1629807CB99
      CA680F943395B11E6A0F15233D54CED044FB4994A4792FFADB452A02FB6208AB
      12DB17BD682AEC9B5FB9CD66F94BF8F5B6AF7900FC6DC110735FCF5D5B3344CD
      037908C7ED94BF845F6FFBDAFEDBE6067E8DBF2F1864EE6BBBFA6531C8C2AFF5
      205D57FE013ED01FBAEE5274B671B1FF03F343FAA389A58F5C33D7BDD009229C
      1BE2D8E047F2C77882BF58EACE893FB1608ABF47D64514DA1729FC97F94E0BFE
      8D5CB02FB2683C8D72E7E22A0CFA7934F1D38BABD49FC07D3E7C7DE167133F9A
      8C7CFC104FC71703DF9FE6C9851FFC7B9AE5293A6C3020BC6C84FF84B93FB1AD
      3F2FE2E47760BB649CE4C2FAE322CB6791C84642E47F3CDF4B5CA479D41FC14E
      C81C9CBC2F8F947D229DAF927CE065F2942FB3EFA66E7F9886017D114F4A7F93
      E4BEC862719DC330D9EF83241DFB397C9AA4619286F9CCB63EE25798BC022F93
      39553AF41C9BA881FFF670660EFCC63FBF891EC934070A88485C8AC85E9A3A17
      7E0FC8622369C011AA214DEF82FE3A4715FAF855A471085FB7EAE983BFE02AC0
      EC321124B12D89050FCFE0ADBE3ACD8554EB5AC83B6916068EDDE9B6C0EFB346
      C2C7CC1DCBC17D91B94F4F47E73E74045A14748479CF5312FEBE8892B7D3EF06
      F55C45BDD6B752CF957CD8787AFAB9F7A19FDBBE8D0FE1AFDF4EBD05DCD750F4
      6B7F2BFD1A2C95E1AD612C3F08C23CBC14707926C6E1280C0211C32FD3183E8A
      293CB234A8631D31EDAC4F7EEA0F819623EB2489731A10DE31CF1C07FE4993AB
      E0224F0779F64B18E4A3B70DF865020F8AE055E4C7B4F83888D4DF07B9FED4D3
      9F52FCD4EF4D7C90AFF061C01F7A3075D035FC339F4D045C955D8A34071B033E
      F5D220553F23F9B3277FA6F267308CF427F5DD48FEBCB4EE92F530DB2791F6CF
      27EB1DE7963567816F9DFBBD4868766996D805AD8E1A297C83E7ED42FCDA8B65
      EF625181FCC93C8E3F93FED70A332EE0F09F947CB50EC184D4EFDD2AB3799DCC
      ABBC35CC4EBEB77CB9CA7BDFF1B6EE37BEAD5B7DDBF6DD6FEBB617D2588A96FA
      772D8911FDB68D6F7CDB867EDBCCE93C8D04FE86BDC2E4F06AF609CC97FEFA08
      EACAE9540CA21BE4196749AC8C245EC76EED3A0EECEAF24DA38BFEC09DE3A47A
      693CBF3020FD525C49F5649726FE2DCF76EEFDF093248A922B11DC7C09A77EFA
      2E2DDADC8B60C6367D794F2A9C7F786F1D268190C681FB44D6D5A3F1E67D3973
      8129E0BADF422929DAB77F11BD1DBD5A8DDAD50A6FF24C38B74837AD0F77C10E
      391E0335B33063DBD7AB2C8F5E023422AEBB4E0BFE753A0D177EB86D501DF975
      A3D5F2E087D7EC80D6BF6E7A5DBCA4E5397849BBE1E2251DD7F3F86EBC0456BA
      4DC3D8DD2E5EE4385D3439AEC1A975F132A7D1F6E83AAFD56C3DF2CA4B06BF45
      2A31B33F8A1DED29B5D3FCE6FDF22915BC74B908342B34EFB771EFA17AF8D595
      EEA9BCFA5D6F5B51996EBD829F67DDCA3BDC22CE27D15E21CAEA35F2DCF0F393
      BCFD017DFD80CEED2A7F4ED9DFBDFBDC9BCF3BCBD3241EFEED4F7A641466798E
      A6DD1FF4917F17E349E4E702EFE9C2DE6B75BA36FF993CA10BFA371EF4DD86FE
      18ABCFFFEEDBE827F247DC19F86940AA41FE92E53ED8E660B9F36F13BF2FE45F
      C07E17718E8FC2DF72E0E88B57B67331DD6B749D86F53F9146FCBCE9B8275290
      1E5489830C37E8853E3160B88719C751D8862FFFDD979343B9E0D226851F184D
      5A7A2ADF3C1135F7C55349164DC1AD9982E379D539D0173032FE7C8A595CC27B
      C6F011586F99B581A9AAD571BB8B57C7B16BE6E6A2602ECF8DBE8087E0CF1730
      B73B668662BB7E6E9DCEDCDCF00B9C1BFC7CF973BB6566F02F3278796EF815CE
      0D7FAEF5DCBCC69CC4A02FE011F8D3A27385B59D1B561355E6465FC023F0E732
      AB5648F49737B7F69C24A12F706EEDC791246AEE2B985BCB9B9324F4053C027F
      AAB9E1D99705C3E0E73070BB1E18B576E3CF85EA7CCFE9B4C1046EB53A9DA758
      F4EF449FE3C4EFB1C6EBAFDC49C83D9C6D5FBA727F90E1B2DECAFD56C38574F9
      77ABDCE70C97AA7A5FE3B9DDA1DCD7DB7079A8727FC186CB3D94BB6777C187EF
      34172B77C7EBBAED8E63BBAD125D14011ED1C57DF9BA5D4DFAF196786D74BBB6
      569F886B8D6E7FB172D4E876A3DBD7696E46B797753B5648B8ED76DBAB51EE6D
      C76B375BCD8ED1ED46B71BDD6E74BBD1ED46B7BFDCB919DD5ED1EDADA663C3FF
      9D9AA87CB7DBF2BA76B7D97A8A4537CADD2877A3DC5FB22035CADD28F7759A9B
      51EE15E5DE6E78DDA6DDAD397277ED96EB795DD7B38D7237CADD2877A3DC8D72
      37CAFDE5CECD28F74A3A9DDDE9741CAFD1ADF1DCBD76C3711B9E6B94BB51EE46
      B91BE56E94BB51EE2F786E46B957943B6200B6DBDD9A7CBA3DC4D36C761AA0FF
      8D7637DADD6877A3DD8D7637DAFDE5CECD68F78A767741B3B7BCA65DE7BA3BDD
      461746EF18E56E94BB51EE46B91BE56E94FBCB9D9B51EE15E5EEB55B2DB7D5AD
      C996DF73DA5EA7E5745A1DA3DD8D7637DADD6877A3DD8D767FC17333DABDA2DD
      DB8D16F8E65ECDA9BBD370DACDAEDDADA985B30BC2D8DF4A95A508E1C27FF6FE
      3C11904230835B2107EFADE6EF98D3A32B799CA2F3B029DE43F3DF7FE5EE07D9
      83B3741F36CB7BD8000FE1CF9A39DE8A3A88B36C3C7096DF6E0D3CC12C6FB573
      7096DEC366790FBBE0196729E7D8BC314736F3969EE51D40772F6396AD655772
      AE27C54320EF9E7F96ED87F12B1A0773D6DEDD76C3F3CFB2F3B059DE613F28BB
      6FDE82F0DA1EC2DDD6C4075AED4ED376BD6E6B11895E7270606EBD9F16D6F6E5
      04071E0DEAE0D9CCDEC70B0E2C0DA7FC7C737BDEE0C03DF118EF8F71FB128203
      B703493F09C6EDCA05C84302560FC6B85DAD24B93560F5E418B72B9324A8C3E7
      54DA3218B7ED96D36AB5DA35E18116B68468782D770D943BAEFB6A30EB57ACDC
      D73A5EF760E5FE82E3754FAEDC5708A8BD4AE5FED4A75146B9BF58496294FBF2
      CABDD101BFBCD571EA3C77D76E60563E2811A3DD8D7637DADD6877A3DD5F8000
      31DADD68F765B47BD76E345DD773EBF2F6D0AF77BA2DC7F8EE46BB1BED6EB4BB
      D1EE2F418018ED6EB4FB52FD691CDB75DBADD662ED0EAE3BB8F64DCF59A2F99C
      51EE46B91BE56E94BB51EE46B91BE5FE22943B62E1395EB706C4DEB5DBAD4EB3
      DD6C1BE56E94BB51EE46B91BE5FE12048851EE46B92FA3DCE15EB7E538359EFB
      5EA3EDB5DAED9651EE46B91BE56E94BB51EE2F428018E56E94FB12CABDE9746D
      AFDB68D51EBABBB6EDB5DC66C336DADD6877A3DD8D7637DAFD050810A3DD8D76
      5F46BBB7BBE0BB77DA357179A709EAB0EBD8EB50E96E74FB3A72ADD1ED46B71B
      DD6E74BBD1ED8FAEDB5B3628EE86E3756A74BBD76E759C46DBD4C219E56E94BB
      51EE46B9BF08016294BB51EE4B29F76ECBEDB61A3595EE8ED3F5C0736F368CE7
      6E94BB51EE46B91BE5FE12048851EE46B92FA3DC3DC7697A8E5D73E6EE343A76
      A385B71BE56E94BB51EE46B91BE5FE02048851EE46B92FA3DC9B4DA7E3749AB5
      09758D2696C2758CE76E94BB51EE46B91BE5FE12048851EE46B92FA1DCDBB603
      DADD736A947B1354BBDB6EB5CD91BBD1ED46B71BDD6E74FB4B102046B71BDDBE
      846EEFB4BD76C3B1BB75E0F28EDBEED8AED36D993A77A3DD8D7637DADD68F797
      20408C7637DA7D09EDDE6D745CD7F69A757DE11A9D56A3DDF29A262C6F94BB51
      EE46B91BE5FE12048851EE46B92FA3DC815DDBAEE3D621D4B9DC3AC6B14D469D
      D1EE46BB1BED6EB4FB4B102046BB1BEDBE8C76EF3A5ED7AB2D74DF735C17AEF0
      5A9ED1EE46BB1BED6EB4BBD1EE2F418018ED6EB4FB12DA1D416CDA4EDBB6BB35
      EADDF3DC76B3DDF44CD7D7874FE531157A690E4AD4AD0FAB3E58A1EB99159AFD
      C5CCEDA9157A75664880BF84422FCF4CADBA51E846A11B853EA7D0DB8D56D76B
      3B765D34DE6E7A8D76D3350D631E7B958DBF6EFC75E3AF1B7FDDA877A3DE9F50
      BD83EA6EB75B35FEBAD372BC4ECBF54CC318A3DD8D7637DADD68F71721408C76
      37DA7D19EDEE38CD4EC36DB4EA80675DDB763BCD9689C61BED6EB4BBD1EE46BB
      BF080162B4BBD1EE4B697770CB1B5DBB55179A775CC773EC96D33665700F9F8A
      396C3787EDE6B0DD1CB61B8D6E34FA936974D76E773BEDB6D358ACD11BB6E3B8
      6ECB31C1F8475E63E3AE1B77DDB8EBC65D37CADD28F7A753EE4DD7EDD84E6DFB
      76BBE5621A9D01AD31DADD6877A3DD8D767F1102C46877A3DD97D1EE0DAFD1B5
      6DBB55835AD368766CD7EDDAE6A4DD2877A3DC8D7237CAFD250810A3DC8D725F
      4AB9B73D5854AF5B7BD2DE763B8EEBB61D530467D4BB51EF46BD1BF5FE120488
      51EF46BD2FA3DE3DCF6DD99DA65B17996F211A6DA3DB35DADD6877A3DD8D7637
      DAFD250810A3DD8D765F4ABBB7BC86D772BB35CD62F61CD7EB386DC7B3CDC1BB
      51EF46BD1BF56ED4FB4B102046BD1BF5BE947AEFA0EBDE6CD4767A6DBA6DBBD3
      B25DA3DE8D7A37EADDA877A3DE5F820031EADDA8F765D47BB3DBB2E19FA65BAB
      DEDB8D4EC7EDBA26B3CEA877A3DE8D7A37EAFD250810A3DE8D7A5F52BD37BB6E
      DBAB09CE7B8EDD6C1AF0D947988AC1AF31F8358FCD7B06BFC66873A3CD8D36D7
      DABC65771CB7D1746B9BBB366DB7D9EA82C6371AFD7157D938EBC65937CEBA71
      D68D7A37EAFDE9D4BBDB6976C065AF6BEEDA00BA343DD79CB41BED6EB4BBD1EE
      46BBBF080162B4BBD1EE4B69F746C7F1DA0DBB2E14DF6C379CA6D732457046B9
      1BE56E94BB51EE2F418018E56E94FB52CADDEBBA1D509F35F0747B4DBBDB71DA
      9D8E71DD8D7637DADD6877A3DD5F820031DADD68F7A5B47BA7E3D95DAFAECFEB
      9ED3729BA0FBBB2693CEA877A3DE8D7A37EAFD450810A3DE8D7A5F46BDB7BD6E
      A30D53AF3977776CD7751AAE6B4AE08C7637DADD6877A3DD5F840031DADD68F7
      A5B47BABE5BA6DB753D3F4D50175D8ED18E56E94BB51EE46B91BE56E94BB51EE
      EBA3DC3B6EA3DD6A3BED3AD71DDCFA66B7E1D926ABCE6877A3DD8D7637DAFD25
      0810A3DD8D765F4ABBB73A9D86E779B5E074ED86DD6A759B1DCFA877A3DE8D7A
      37EADDA8F71720408C7A37EA7D29F5DEEE741CBB69D7F485DBF3C07D07FD6E9B
      AC3AA3DD8D7637DADD68F79720408C7637DA7D29EDDE6D3B2D17BCF71AEDEEDA
      1DD7ED382DC7A877A3DE8D7A37EADDA8F79720408C7A37EA7D19F5DE6DD80DBB
      DDF56A9CF72E86ED5DC714BC1BE56E94BB51EE46B9BF08016294BB51EE4B2877
      975AC2755A6E5D64DE69385ECB69371AE6E0DDA877A3DE8D7A37EAFD250810A3
      DE8D7A5F4ABD379A2D70CF5B7559F39D76C3E9B63DCF64CD1BED6EB4BBD1EE46
      BBBF040162B4BBD1EE4B6977AFED76DA6DA7366BBE8B4DE21AADAE51EF46BD1B
      F56ED4BB51EF2F418018F56ED4FB32EADD711B8EDD75DB9D3FE1EFFF41DF2697
      224DC340C01891F8A3F2D50D97BFF2D77E3285C95C44990AF4CFDDD6ED3A5ED7
      73BCCEE2BBDCC577C1F576A7E9361BCDC5B735B4729B7FCB76A3D5E836BC9A97
      F4163FCEF510E2A7D5F516DFD5ACB9CBEE743A8ED7A87956AB666AADA663C3FF
      9DC577B56BEE6A3661C1DA6D0F65DCA2FB3A754F533D8316DFD6ADB94DA322D4
      2CB6BDF83ECF46A8432066CD6D354CD2E8D8AED7EA3835AB0D7668CD72B7EC6E
      CBEDB6EAD8C469D45145C131D7DC57C727DD76CB69B55A35C4746A18C569765B
      B87C5EDD7D35AC8277781DB8B76ED19D3A6ED16D9E6BEEABE1160F591AF66B0D
      6F3A75DC62B79BC89C75A2C1ADE196A6D3B53D7023DC9ADB9CBA652F32836BEE
      AC132B8ED3EC34DC46DDBABB75FC82720F05520D61DC5A7EF1DC0E08CE9ABBEA
      D8452746D5ADBB5BC3308D2E0869D7F5EA085AC32EC5616DCD7D75C205849F0D
      CF2455B4E8BE3A7ED16D4A6BA4BB5DBFDF1DBBD5A8D5268D1AF9821B90E65843
      98461DBF3440BADBB65D27CF1A75FCA2EBD26AEEABE197661BDE133CEFDA856F
      D4B04CB7D171C16B6FD60898469D2E02628290B7EDBA85A8932FBAACBEE6BE1A
      8669C322381DCFA9BBAD5BABD69D660B244CB766DF7A3502A668AA53735F1DBF
      782DAFE18166A9A1A757C32FA053EC4EB753F79635DCE2812DE7B61CA755B7EA
      5E0DBB386D30749A76B746BE7875F2C50623A9EBB59D9A6DEBD5718B4639AEB9
      AF8E5B5C1066184EAA7BCF4EDDB277C1B16A83B95AB77C35F2A5D5042E733A75
      BBBD59C32D855D5C735F0DB714E1B29AFB6AB8A5E5813AF2C060AA5BF7660DC3
      8085D5055BBC59B37ECD5A7651389635F7D5F18B0B3AA5633BED1A69D6ACE197
      0E982F48D09AEDD06CD7AAF746DB03AFD3EBD64D503A2EA9B8CC7B91F5C797F8
      6B9C5CC57FE36F27C3097D8B1F2E42F8A77B11E6FE04C7B22F52F82FEBC17F3E
      32C18BBB0238E1399E63DF7B0CA67B16064862FAD002BE00CD4A9F1D1BAD55AF
      C5BF800075BA74423C1EFBF9E853CA3F4F92386F7817E35EFAF56D088EB4FC70
      36EDA12B3BCEC67E149DA43E38DBE320CC264762E05C8CA30F7E3AA4AB53FD29
      1083FFAF0F7FBB4AFDC93B72AA29FE390EE3FC7D38860FB19FCEE0136EDB301E
      247F5CF8D37C94A4D639FC9381876E1DC7C348A4F0E76422523F5FF8A77E2AC0
      911F5FCC52D70603699C80E716CC3A17A3D475F159A42391136FB986F4057071
      162631BE8D08E04B722BE36430F187226BB1C903BF5E2569001E017835FCE7FE
      C84F33D0625DBBF4FB5546A4EEF2B031D821B430D7E328CE98F9E9A3638DF27C
      F2E6F5EBAC3F12633FDB1F87FD34C99241BEDF4FC6AF93C120EC8BD7F8C4D7AE
      6D37E8D338FAF3CF8B890F04B972C03E6FF1E711B84C8DCEC518681F3195E153
      AA3FE5FA538F3E0DA7792E52609F3CCD443FC718FC55182457FD3C8D2E0679DC
      FBF7852FE22048FA17392CF5D731ECF1CCE6CF83240536C9C37808444CE22417
      E39E08B2593600C67180D4D12C892FC7915DFA6B0457077EEEC393D3018C2A2E
      811B60C04B3F0AE17B01D4702EB251723589FCBE182551807117D806C33849C5
      38BC16411F46C7B80CB0F9A50863BAF31A9F82B7C1079041C01A0E2CC17504AF
      97CC440CB312D7936C94E6317C3D85C946D9A47F11C4B00471D60B7AF02D457E
      604A5398374C2C1BF920E680C9FE1BE71E0CC7C4CCF06144173A1D98D5F0B2F4
      192E0D871CD1C7BF547E1BE1AB3974037EC04010BC8F1F071797A1B8FA1AC681
      439FB2BE1F09C7B66177F7D2201D093F901F0749925F649368965FC5612C7069
      F4E7513E86FD924D6012513CCAFDE0DF30AD8B6926A2BCE747F105FC075FC043
      2EE01678421F7EBBA25FE0439A0FD38B2886AD0D331730047CBA4A51305F64B1
      3FC9932148F430EE8B288281A2E46A108A08B67000C35FC0859369DCC778A69F
      85BE1E05A54A0A6FACC54C2CAE60C42C9FC19F3378C8304DAEE09D934198E38B
      C648F07C06744735027F87978D41DCE4D9C540E0CB89485CC2D7FDEB6C42812F
      101301ACE1157E2F704DFD411F3614BEB53FA08BA7C097D1C588AE40C2E5202B
      FD14AECCFB973ED12A87B7C59B06291204BFB8F4F3EBDEF5C5D7349EA4592CF2
      8BBE0FDB11182E023A5AC83921ECC6899F5BF05AB98D72E03F2EAE809107E37C
      1046B0912C1794FD9FB8FB41164D53918FD224CF614D2FC268908CFDBE9FF7A3
      783A697670C7C10B5917B8ED024B6D4090E3B1B8B62F70E9453A6BDB9D0B5C7A
      F911DE24BBC60F40FF7824524177E32DB84A1869A4D1C4C0071EEFC30AD20EB6
      48D9C6F0A7E81276D7249EF6D3317E816150FC9D039D78C43689477E3C44951C
      E7D7B96FED4B4D2D6F4603086F8797BDD7FD0DF804E6C1BDEEF5E053B4FC9377
      AA7737977F72CFDAFEB36E98161160E9D7B86DA8360DB4DC42DC364EE7B15EA8
      BBCC0B21CF2F1C09B44F0AC22AF2C3D892BC7DF13B6C9AC22E41B996F9F46F0F
      F73EC8799F7F82C6012EC63BD04290EC0B1265E24793918F1FE2E9F86240575F
      245362788ABCDB1720ECA6590EB27694C363620AA82BA30906F4CBC60E984179
      D41F5D0CFAA06F414E349CA6DD869F19E87E3F82D98185DFA497E78BF8441AAF
      6A5DD045784DC3EE38F4610082BAD1B8E8E3CEA32FE249E96FF104FF0A64AF3C
      B2074FB3F1895EA7F29C8BDEC5007C9A0BFCC305CC7D34FF28FAF8150C08509F
      8D967E067D0D064AC5A443BBA332ED5F467EFE2AB340065BB038D7C741985BDE
      BEB3EFFD4FE4669041BC78CFB76CCEB72D5B1D111BADF9C5D264041AD592F1DB
      88F7763A1C80D5914952B11B44674105C36B595EE52FBBBAC62ADBE1E1EF7411
      25302A30F045D0A30FA02F427C4EC3BA78D56B5F808AFC73C19A56922B965EDC
      B9532BBC7789E58EB2C58B8CB72FB7CCBCC6AE3747445E5FD77B04326E6EFCD0
      715BD69E7572EA593F7F3838CAACAB301F59A8E323716D65FD349CE4D62445A7
      230F456681CF1B4516BC7926602BF1753998B9EBC61C3F745A1ECC3B9BF686B0
      94230B2D722BCC684E698A26C5CC22774A04AFFF5C665DE854F7F15646061240
      F72CF5F447E68A755BCB4E07D6F25334057F4372709C58E04482D598597D3F7E
      955BA9C892E852C0CF01588D60CD67569E58F038306E0311C0F77DF466D76FEE
      DD36CCFD20CB708326B175E2871198DDD6D548C4D634036D697D56530EACB733
      9CF5BFA7E309FE7CF7F1E474DD260C22AB6BE3D63D8867D63809784153981B4C
      0894FBBB8FA71F2CF02BF1C3017EE1A3BC82D5072B4EED2A814C025FF784E507
      01DFEAE360602330D758480D0BC8A9EE584B32E1AE9013403EF059A22177005D
      0649E3F520BEC4690B2B484486BB84253DCABE6432B33EBE3BF93F44CB7F9EC0
      0774AC80C3D66F8B749BC82FEF40BD59530EBF5A83C81FA2B0272BB0313256E0
      9D94FE10C6496AF5D10532A6E0379B82EE5A98824D34050F7A6114E6A427FCC9
      044401BB4BD214846F3360DE7E4E2A73407BA8AA5FAEC0634EAED68D43B65331
      49529C1508FDA33043636007A8C1FA2199A0E4F323CB03D3E28641E6D2DAD837
      CC41F7B126E09F8511A8AF37D6DB248984BF0293102D7E7F2C50330207D45200
      4F07CB6FF06814380882CFE2F769087AFE38126320C607B6EE56400AB9130618
      F605AE5891EEF8C6C0CF926198B2EE78CE40CCF57306621E42B8E7F0FDCE31AE
      6DF9F89F15F9E950589C5F6B2503A580C174CDAF8440FBC5DEBF261B8DC80866
      3F4836BC17ADB9FE140CE3185DD920E94F71D7802CC3C177ADDE34D736700F0F
      7D84958FD03B02F902AE3D3CC9DB77F7AF0D733F98B96D13653451C627342D1B
      EB605AB6DB18A5F8F5ECEB2C0DC7D6D9F1EBF7C7BFC117321BC6FAE04FE0BF14
      369E75FEF1E08375E947536135BBEBC60C3FB4291275029ED2692F0A2F312073
      889EB49F95620F033F8CE05FB8E8C38FC727EB37C7AE8B738CC2C904D4099E8F
      C1B64589872930913F43E5D18381BE66A497B2696F8F7F5DB799A24B6437D009
      18A0E1DB47D31BF4C2AE9525634162FE2A49A3803220603DD3646C1DBD3FC410
      D2CC8A93DC8A123F40AD1A82D12CC6E05EF8E94CC5192D1D665E37AAFCD0711A
      A5AD4BC910B8FA676C169FA4FE102D8DCCC22C38749E7A33EB9012936033FC13
      542265A7007186EB3773B74167258D37D641DC1FC1820EC5BEC8C6D6FF6B7D4A
      30952B49BE82FEA5AF6201534799667D488210A814903B8D3F83698AE1B87F1D
      1C6E6EAC1B0D704F7828E33E4B3EA6687B114607D1377E77945998E583520F77
      89627978815CC09600F9A085E1EB30FE374513D68D103F749AC40C1F7F867F95
      68009E87F98D9358CC542059A4604FA34C9858430172234FD770C7379B1818AA
      48412B88FAF1F4AB4F2210397ED70A41CA9122F808DFEF9DA37418A352CF419F
      C761365ABF79B76C98779E24511E4E2C3FBAF267196A39D8C8026C2AA9177C8C
      8C27F11A72708BC599F7C63A622BF3B4879BD1A2EC3F6BFBE8E4F4ED0EEEE429
      4878B563ADCBD0B7D0B549D27747EB37E5B683BA6B8289966C829D61ED6B1FAC
      B42892E71BD6AF4092DFD6706AB849CF8FCF3CED7836C80CC16C418CDAD191CE
      077F08B33D1E0C709D3FAFEB99670703D587205947685DC0E61B84E9988EB802
      522FF351C1B03E70133EAAAB13272B0848B2A659C35544E9CAE74A9334012E1D
      B33511245364597086FB5F49D3B0BD344E82297CCDC70F45E0758D26DCF50A27
      F837EB4C8048F523EBF3C1E1317A49CA4CC2C01FEE5BD29D011A51A90C7DAFDD
      8CBB7617662C0F90588FC8C5F5274996A7C964C4AEE350C458D500D37D7F7A7A
      2E399ACEE0C19500AF095101D64F4E751DB72C92FB28B030F70053336056C8D4
      2097C94DFC2846C0146847ADE12C91AD3F63DC4673310A61CC2E213788326D7A
      A083389F0A39BA8F41E64CC45928C150D66DCAA8808E3EAB9007C5418AC43160
      E883740C620DE31FFCE92008D0B4408BE3A4F1FAE3CF6B38E5AE8C6C7D3E3EF9
      BC6BBD0F63944E9F936473038CC5432C78ABACF6948CAC80B81D251D9D2F1477
      8D59D0F179C61A4A364A9B244BD17A8F1B18981EE618E2C90CEE6BAED659C379
      7938AF1F45FE515CB12F6F2531B03415BE64960D8B36A493249662A15AF37757
      BD9310E57A46EB1CC69369BE8693471EFF1505F66F3A804BD11C0C6764383901
      825C32B5CCAEFBF95F67879444B57ED3A508C6793816D6C4CF329C569AC08C06
      149E830FE93426579F4FBCD750FF36713DFF35053BD23A9882583AC4E085B244
      609A7DB12762F28FB63E0B2CECB34E4FCECEAD233FF7B7D66FB694D17CF6FE47
      CE7F3C797FFA99537448CEEA4C6D8BCA056991273E1006339FD76DAE98DDD842
      77F747448B9291363C0F1BA3330FB20AE3EC7B9CBB530ADEEB94E094163B43F1
      B54D5BB9942E1C8941BEB36E04F9A1DB4653F3E3A7C3FF6BBDFA51F8980FFB65
      62FD22C0CE8EB3573A8883A29C42B30E38CEF9DA89ACCD8DBA3C2D90D2910513
      4093120D2DB0B65EE52A64473B9DEC6C8A1164D6F1D9FBE20046DAE3A0B5A487
      094A1CFD2FBC08F344D7D03CA9A392546DC747A0D651461C9F81EB59B65CF93E
      6BEBF87A22A3F296479C9251C6C800ACBCC0B2B798644A3D6C1D8E0408129428
      C75479BC858F5DC7B3CD7AFE3A8E0374D6CF8E395FBA4CB3894839602AAEFD7E
      5E3EE580E9E52178F82095FA23A414914DF1E17E2FF3A5AEF5515031F7AD9D96
      ADA3D8FBB205C1A005B433A3F0ABB0B856180F88373702655FC84A0DCCCAEFD1
      88EB468A7AF601D5DC036523711528DD9E640C783F01481C125CC5F19995A253
      846E24D665ADED49713D3932FF920B1206E83360D02F01E9A272DBFA1C2882CB
      31B366920A30C3A719ECB4DFA7620A6321EA01BBD2F9C8CF698C5DACEF994639
      B95E3157734549B67E9B89256C6F660598C085DB06E9F55170910A2BB27731EC
      9DD88F28A88464A093B933A1D82955D336F966A69EE16992CEBC75483AEBB854
      1A87910BEBECEC98B60B6C2258F9701CFEB750E70A9334E98B0C7DF97563831F
      BA361E676E7D894778320B7ECFFEFEFE96AC564039D84FA2E9187FC4381B6B2C
      E2A9110D77925EDA7AD619D8C068BE21E33C6FA2FF4BCF507F178764D866D309
      F90B64FA2FA61AE8248C8982DD4BEEF8BEA4229F0981C187E65E2AF07C27B8B5
      B4E4890A4BB45D8FEFB32FAEC52A8ABD2D201F018E60082E5CB6C4E811A9B027
      980CD96AA60F1C3251F545FB4640DD49308A6822C31A9154D40FCC780BA14667
      E1423BC97FFEBDF43BAE0E9E13BCC13C61F44EF64536A9BE06C2853D67D5DE2E
      87FEB4BF646D63F827C47215955CA002A03BBA2E2864298F214355F21972A0EC
      0307CACE542A06F9AD6AE7BECB31823601EF2B94994774903F46F76C1291EF2F
      B25D4BEC0FF757B938817F150FA7B06FE8802748FD6112F79294CE7B56210515
      F9CE4761491C2A15D94FC63D1055ABD20F2802304CB512F5B09D092C5203337E
      6755DAE1FB2A486B9882345390F664B181E68B8F0DFCD0A283FECFF882206A63
      158FB67AD3B58B016C6EFCD0227C13CE45993F8A79238F743259764327103E7C
      3944B5FDDA4A38E39B34347A6A6787A7EF29E72E5C3FCE0742E0B2FE82532494
      D2CD0D0AF0C8C4CA5D8B38724FE7958265724C18B41823C2305030C5422E5FC5
      4BA6787423E2299B4D1829E4E496D24D0A04C047C88CF5A3570BE97578FCFEBD
      0513B4776D2A5D036B239B4C531973D70049E55A37193953B520FBEB37F3B6AD
      B7CC913FF68798458099F18232E3336B1C66910F3687088AA4C6359C25011F31
      40B4F5EEFC43A616589FCB805D90527E0855299174C0C34C755285E52E4091F5
      4B2E6FB5298F6D946438CBE3B34F5C8C0A8ECB304DA69335946D6DACBA3BE863
      A8FAE73089B89EF26A84CE9CCC9EA62D99C403906F393AC3F934ABAEEFBA4D1A
      755BD7911BF5F5C969BBF51B9553E344496A316A634CF06DE4D6A2B7D4F7A799
      B0E06D82ACEF4FD0758A60BE482D4E4C4D55D257A07318393D267EB57E298B2D
      AA2940CC7CF4C8F96C944B91F9934403C4B3664E7AA2A358106919B8FD98C699
      4D89A5D68F3960EA54F0349B10EE1FA63AFDE3E8E3C1877F1CC4E1987707FC4D
      BCB1DEFAD4AAA36FEDFD033FF32FEB37DB0ED5128C3057331F593D78BF3ED6E4
      B1490232FB0AAD7E94713DCCEAEB4DF31CC57738A0BF332817C665F224B1A86F
      C5FAD51EC38A53DA3D5790BCC775C4D49281B5752410D91076FDF1EFD3704229
      AD5B8A293015290964C9DB1A4E19CF300FFD982AF9088F4D65CB70FAF16184A9
      BB60DC9ECDB22F7918E1A73CA54F78ACF00B2D3C5C1C876B98C0DB2608CBADC3
      72F2E69636BA356A254B3642FA54599C14E74CC1A9015DB07ED37670DA3E0966
      EBB2A4EC415B614310AE34C774DEF59B9A8B8637E79973C90495C460F110CAAE
      F7F80136EE872F67E76B3837478AE80FE71F3F14C81854E027EBA240025FA561
      8E6D7B28923B8D6381CB8CD020C0B8E330663BCE96F9B96B4804F429DF9F1EFD
      885E386C5B344178AE65E865F6A861D37EFC02761CB0C034668466CAC67F8BB2
      5C4249AC230D1A948C2DAEACC37F5A20BB305D8DA6249900E7B1B92138099F37
      7240655520BC65A6368AFB9E28D58052F866DD2881C84F0D2C32A13C2B8AB9B0
      B132B642CA90F5E312D2B9228F12EB5C4146B74461FC5563DE7163213F2289A1
      7109A631E83C4C03C453C07523149009ED780A5059194E872D363A9FE3824A0D
      1FC5A9ED83A40FEE1D688502E44F9FD28D93602D770DA56B8D7BE1708A00B488
      2944A5D240847F813E809D32A023C9352CFD6E7BF573FB74005262ADE786D6CA
      A1DAE1075285CFCD4F653C9736F5215E39015F75B276FB15055B132D192DCBE4
      F684F9C26F2A9399C33338572DB318FC0D73F35021C0B58CED09F7C95258025E
      8E2D712DFD9B70EDE28E7559DF1A3AE8A872D84E56C2D8FF0A6A3F41549D3889
      F7FCE130C59CCCF5AB0DAF4F7AA7F27F82473AF8F9830201087D6CDE68896048
      7547B2DE882B4D87ACF718AC159948C2C066399616AB5C0CBA8E6D4DAE9F8892
      E42B6C33CB97957E585C80E9E2FC5C84EFA1430CBC0DCBB1C118439BEBFBA1F3
      CF229D5186D4D928B93A94F1508E7CC3269D513C3462843E2A85EB8B34F72959
      565EFAFD90E2278DCBB62D2B4BFECBEAD8F68E358F35C285038155C130900549
      6CACB3D541263BB2CFB05C78896766EB09425321DCE64615F89D4B54307B4216
      067229E9888B5764D9176E566BEB108F1B8196E7C9963599E61C942BDFC91B98
      FDDE48E305AC35B94AC42A9D2DF7657C3E0E350A28397FD9D7904AC1BE972997
      418A2CCAB6CFC55030E4C7005638B70403D567DAF6D9DC608113C67BD4DB95C0
      04806E1CA39DD1668477A6547E0CD8AD9F2D582F89409C68E1CB8751BB78D04E
      268F3526B787CF28B08A4BA9363AD2613C8DC21196DB6F1AE30147B0AE153CB5
      4642D95156001C03CAD82037B02095AC6D2ED9D327C9E686BA017FDF3A04F333
      48D1631E6C5974EE5954CDADE791761DD93ECC6183E1F97D4F8C74A1A0526524
      8AE06F19F314C58AD7CF55BEADBCBBF9FAECECF837EBEDE9E93F410B099F0B8F
      CF3E1DBFCFCAB125C273A1E0DBDA4D7E7189E47930909D41F6118FE704DCCACF
      28169229964C6AF75316B8CB63310C39D2DF75E5310DBE6E2401B1BB98280C7D
      F22B629FFC26C14F24908FDC2952D094ADB96D6E21810E19928C50BAC4DA0162
      D41084337E74F57E19B08CF19B624A2C58B7D9D632804257BE61F0A321426A74
      42F5D26932813D72859A42699D392BE5BB2149924E40C7024916A8C7AC9440C2
      2D156FA0F529907BD8366365A7C4FE2582DB2136AE509DAF4C6A75FDFA99DAEB
      87E457B75E7C7E35E66D5130BF94B7757E7EFCB6D436E0E6B1E8D6DB48C0763D
      554821EB07C0D56A77AB73FEF9DDD93B72083F1D7E785B8678A5D6086BE80CFF
      D0765DEA9A3C1884D79C76E1472A1B18A32118FBE600C0FA4DADE1680301784F
      31AAE36C2931BF85B8707B27D83A74AB0A754AC988BACD01F0F24F7CA0498978
      04D71182C03B145144694B6BC7DA4095C6EB938F3FFF66E1EC2D1B29821E8635
      069312A67BD64F93285AE369D1F1C3D6673C431E0BEE64F2294D30FE905AD767
      C7D6B14216B3DE27C32DCBBFF4C3681DA3E69FD9FDE1785DD197C3FA047E1198
      866718DE251F7930A536EFF9A88C67855A4736B4C182FD759B3C9E07E86E0EE0
      16336EC1CF60B329A08C114CB480CF59AF89857110F665B8631A671C1F389BF6
      18E4DF3A48537FB676332B4534B810E5F8E3E14F6886FF138433A50AA1B7B276
      D3624C1A3FCBC261ACFC0A9906B4A67DE8113030650837CBEFE7E125062531BB
      67A2EA14FA238BD3EE333EDEAE229E516191B5BDA04AFE894B9B6DDB79FE960D
      7BCFDF43F8E4E46405AD294ACAE3F9A7DCB16DB3B44F35CF1D75DC379EF81C48
      A4A2D3B3B58B9DCD57CC5AA05974D16C286BE7B8311245C5AC888E60D48902BA
      773FBD3BFF706C40F7EE5E0F3054C02CC1E0DB270570F19C647BE91836670941
      B12BCA28EC8F0C11B5A8836088B5DB9926E215359ABC7A738F2DB758ABFEB502
      69ED8706D29E05AC0623F53A35692528427EB6029C9EAC5FABD360DA4F17B95C
      CB9DF4EC26C71E2673DCC59E2F8A391F79FAB7F1A7E1CE5573270A783CD3C6F4
      D9BF0C4FFAC3C8B0E48B654912969401FF9761C8DF8D887CE1FC8872F22FC693
      FEEA98D24406EA4974282BA6F28493D630658D12D64C78403FF22023989B6B0A
      56F9BA676E185B47152C53C2CB0C444E9566849B89D7A83E1A0ADA69C7FAD7C1
      A175E567945B4DB50E51543E13F4255ECEE60689082C57961DFEC64940F1885D
      4BE50A0642C24B2218C5B8C7456FBAE039E38370A021369993A03DD553452C8A
      27340F59EAC43D872853F94AA438901F148D9AB86D08BC09B7CEA940A7720A39
      074B24896412575DFD1961E14ABCDA9995C0035206A9DDA9A295871C1B2424DD
      45342B51061FFEDC3E7385095601D45A5E054ABEC6A4078D5F1BE79823A0106C
      DD529CCBC4AFEE17BFEABCF4F8D5C704C5F807D82A1FE4BE580D0A36483E2AC4
      C14D5B6C5192495C5D82C03AE137342078549BE4DBF7ED23C32B575A27A1783D
      4BA69175E887692C33450281A0433DA010C330DFAB64E2256CD9E737384FB065
      53FD16781EF353150B319FCF6F04E07A5CF58A96DFE60A8994D5AC1FCFF2914C
      54A0CB765664D27E5F38DCAEC1E1BE9B78FF4CF64E42E305145E80820100D379
      9A11D659F6556209F97424089B5435E6615E93F50FDCB65B36DB63F4B84F7E9E
      8A24C653ECD770FF277FF6C98FAA8D1CD0E42D3773B87D68AB07F63398C87029
      F69546CB7A0CA6DF084CE62089650B48C420A065DDC5228014010F8250D69D13
      96673F15DC1E08169B5F14576422F6FBA0B2B7E14571047ED91DDC52075FFE47
      E103081E1BFECE980A11F79C57C007FC47C647540A2F4F26127B072CF998694B
      0D6111176050EA6D61366A3D63622FE6F45322C0D0FA390C44624EF62B9B1684
      FF16D3654B715FB535D6373323395AD4AC259910AAFBFF4EA6E75370B6B04089
      10DD6947F2469549047DD807F80E5816552C98616FD30FE2C9DCD4EE7AD42B15
      3D1454E9C7270156F2719CA7B34982D9E24EB3BD6E8B0FF342C8DC030566C2D8
      B1E0FAFA4352D9A46DFF351519DAA73F7F3838BA05834FDD74986C6E4C31791E
      3187D68D20F508152C26533116685D65D6F634BEF263B82E9AEDA87A712D8239
      6E2A1B891638E21492F441F0F6A32493C981884898A42A9889B0EC6B5738514F
      B45F544436C30A72F21C41273132477E15F6B99A242C5D93017FC5C1AE152AB0
      0F8E35C71A4306C7A08690D4239D51CC31184BB8E5A3698E65CADF0F017FA5F2
      A32FF11423E3122508CB2041E7BFFD7074CE78B1493C44FB1921021903E5D24F
      43AA7EC8B08FEDB6C475904E3E18000D8E9FAF5DD57E3D9D0E9328F2279904FC
      96420A37161AF9DB443D6E6D4392EE359526E207AC8329617DEC503C7A8ADD2E
      0BDCAF30ED4FC7B0310999B640A0C14A06AA0157307EBA063C532858C4F091BF
      86C057F594DE3A1262426D1690D34E25AEE15601A1D1A784E9D241511FEBE855
      013DAD0242D0A9947085C84DE22F968DCC8147756319B279D10B5C3B14C85BA5
      22FBADCF1F717C1723CFAE24CAF855CC941383557524E443669A720401D1150E
      F334A28EF65138E1E2DA1302B4053749371DD2005A30268EA73A5B7F2F6CF22B
      D5B51D1D9C1F50AF8283F3CF482DD605EB36C75B4C04197042C00CB14B6B1DF6
      A935458DBB4B1883BED58BA88F05FC83920554E236481084ABCC467E605FC1BF
      B3A021F1AC50125FAF9DB6AB0128396380B3E7971C2B3A7F82155CC95C57922D
      296D5915853D3EFB4098AFC4C7200E38CE39814D74CA30CA3A4B422548508E45
      D1B4775BC337E5A9F0415616E3CB140CA14BD7D52190C6D083A77F2F9BE6F939
      087CEA0F6CDA6CEFAC84935466855F64556055BEB4B414D013D7AF491852628E
      755BF15A24A773865E0A87DC1E0511981080A9D45323045B82CC553442103B9F
      43A96376E44BA8675C36BFA6884475586745EDFC2F64AAC3E43F25578C7276F6
      D3E997B95E13C028C398412DBE170A687C0FAAAC43D9CA3D3CE5FEC8533FCEC0
      7DDBDC20675A6D9912087736ED8FBE4362804F7BF2FEEC5C31002C7E1066DC12
      8F6EA388EEBACDBB564E1C4D2751D8C7306615F2EDC7CF5F3E69504C090CE913
      FCFCC0CFFD4846A44A3A98C30105B891392EB925A1970336C05187491C50670B
      7320783B79E8A8BD842F884993FC271522F533D468980B4B024B16DF5B0E9E71
      735F1D3F576779A57159B011CA8D7C68B1CBF7AD038DD231771E89C93E9CB609
      6F139A43C26F585609B7C356D95B118366B5542B02EB13A2816117185885A38A
      AC353B431D959F32476EDD97A05BF3CCBC2DC9422506793A153AB95B9E618499
      DA06F089206CC46EE5A9FE820762989E5F86CEE17B08E00E9B0E4CF259B1DBCC
      C6590212D48FB1DDFAA14AD1573D1E59780562920AD4E081D9282517B09E68DB
      AF0EA857E84918E5B2C7A2BAEAD5AEF5EA4BCC7053744079C4A69FF559B7E783
      4BF00FAF3E735FCDAD77818873B0A02862CB4EEF963A0078450B8401BD301018
      91487A594263AB1804B64648C1FF646076D831AF18961A73C3F1ADC0FA8E5FA1
      87CAAF431B49D75950C304DF1AA33B37C46006999F8C5B5DA8A40F09B54E6005
      48A18E1E4657AACFF163E532B39918CA5D2FB333B15D5F90F4A7742EBE8DED4F
      30297A12513A0D9E0C51EAF32E45AFE93453F8B0B29AE63B6697DFCDB2BF626F
      9EDFE4BA106A9DEECFB3BB00AC9CD990D60F7395A85D1142DA21DCBF30D664F1
      C8738AF4654099B10A735036036D2A647ADC4FE8E273AF6F9554C9D8D5405899
      6126AE05599A81B43AE5590DFC75A28B7574F259A27602FC4B4FDDB566C9949E
      46C7F7BC4BB091D5FE70FF3E253E7FEDAC296771AAFB4B4A9BC2CDBC702FBFB1
      FEFC03E6FDACC54627A70D64F9C5CDBFF681B3575111B7F4D9C62312E2FCF8CC
      234AFCEBEC7055F35EB7DD5EC7C4CF7DA67076768C4BF700067E3EF69D47617A
      4C066E1215BE817F0DF796CCDC5570EEC9C79F35E7EADAFD17C8B54F47805392
      BAFF3A304CFB0D4CBB327E555A925EE32FC7AC4ACF185E5D8A57AB1EE84AC42B
      4B177C117C0F7C8DBF12BFAAE9FFF87EA50C6B420D37430D3A5C275B9B92D7FF
      4B1807684BFB1315F3C36F3F60D205FF6917630BD47423CCF1588B8B5685E0B3
      792EC5D001FC2CF75309E88285A53C9A8A3A98B0DB12472A28BFB02B2205826F
      C6D90C7B97D9FBF9C16E91328864B49210850EEDA9E8381553E4C95010101245
      F19F1FFEF71674BA67428D5941E8661990C827043F5E10E56508801C4F48554E
      1D8B6AAA26E62C05995BC8E56D3AA148A18924B14C65188F31988FF2530D4E81
      E16727B2B47DD19098E7B36227CABAC7152369199D76874E3BBE0E4DEA445579
      61F2C44A149880B578B10ACC2F81A604E1800EBA7369C16EA31C5A78FAF8FEF4
      E847013FB921DC0E0A3E2A4E91508770291E37F739DB032B7E2D7F80EF81022F
      517D2C51800EC238CC46940962B6F69D2B7A8CE5997E6436B67EE43B4E2AD2D8
      3BD4AD86A93497E75445AC941B82CF639787B77B44D120DF5269DC551DC22917
      7235D6AC6022AC64F2C01D5A402AE638B018E04221C8F6A729CA439062A1CC8E
      0F079ABF10D30073A0B9CC44FAE051D297893660D391794855D016E60B058C2A
      5188597D3151FF2C17FE78977F1445C5259C89540C43D88CB322818881D3E815
      78206A4C898F663657B977532A5FA0B2D210FE2867F02AB3B0712BDD6404F052
      E1362034E64FB55B4606EB471E21FC824CA8262B80842EF32DB37CBF9F4C6553
      D130EEA7C2CF18966DAC209771F738FBF6BE47BC8B9F9AC895FD9109632DE5B9
      492C07B0E1DE7D3C399D6B956978B4657DD278D7283A89480A00A3605944B10A
      88032B1760D673C5A2E56E9DE55A01C61804593BA43AC32BC207454B986145F7
      ADED73FA4AD795A5631A29064E4B61AE9881A62120F2694A9839C960C0797EF8
      85AC7085EF64229902E3E0B25646EBC552D89C72B6FD5CC59FF3D2B51C6F4811
      5090A7085C828E00AA29C211EF71E082EAFF443CC4DA094C90FDE7BEAA867D5B
      549DBF8B07C99B0ABFE19392881140C2D4FA8485BADB1A5D1DAFDC814B642EAD
      C27419278CB734123384634D85842EDF9515EC21E5A55F25E957F5EAD14C6A43
      3952507E096B8CA0E9C59AF260F0194613FB989CE7F747A1A0970CB3DDEAFB97
      4038649B60145D6920D14D4AD3E2F1E6C99ED06A940117A9A28C493D57499201
      67E0A2C04D5BFAAA2D9D8D8F839D63323E71C0D6092EE638CC189B12DEA07A25
      E8A54CD0D101903B13A94461D1B4D7A0E304195FBC149A30C85D188E02CE2A18
      7AA73C8945A5A4943759F03F9E7150388CC7ED17D564D6D1BB83F7655014F201
      89EFE0BFF052E14D97887BE94753CC62E51A6E0247E21B88AF9153884F60CE89
      AA0A6203ECF09FCAEC923784AAC1AEBE092C3B99E959E2F59D722D9B5C79F833
      77E0DD67384155544C95B0E53C51AC0412D7E0338B78AA827AB2776FA579B63A
      EC29A89969722A6A63AA75116B2CB1F182BA233CE8C9AF12C958E0AD278C4843
      1C098422D152B09BD01240DD70C5602C22D879FE58E31EF220B2CA827CC8278F
      60EF3EFF743F26C5849F3F64BF8209A3C0C2CDBC8A703D6BCD15ACF19D937E42
      0BC7D8C977D308A143BEB03F8D8512C63E2E9DAB30AC0AEBF00CF10EC02EA094
      021F731AA4711596BACC48AD967391900C2D5B84AE8B96B0D44601999685F217
      E34992E259D9E1F1FBF7859D2031D24AE3EFCB23360DE8C25DB43F681002367C
      D1BD8CB0914F390288461FA967FD34F50A49BC17083A6FEBA1B93967ECEEAB00
      7684D6F06C3E90ADCD4F34F8E0D944B285AFA5366389E174C54911872FC7CC07
      537CC4DC0311B846F063F41A646CF7288723068BE3E6E3C96C9B4CD30986DED9
      8256F4F12968A40A3A63EBEC6C73E3D83A6663FF04717C75068AA60E1DFCE1D3
      98E618F71AB04945F6A4440AD9B74EA6299D2CDC2C38CB4B26942E3243589FF2
      834B36672A181F0DDD92AC28B899A727BC0696D680618790ACC3441AEA5C7FE3
      E7BA06EDD6A7C143A6AAF9005C37F78CA2784784343959C313E6AB881AC3248A
      F75B79DC98905D552CF2D9F56D4188D5E60414C1E3727DF601634A1122E62939
      6C77D75D972AAE4F6F545C9722BA247F582E90119F316A153AFB0B64C1760968
      4E8EBBAB6E61548FF99BF82984B8457DC7F0493A0440EF083B86421237364BB9
      5C5C459F9587C941710D83ABC06F459E13FACCBCEF2C47D15223EDF32085EBF5
      EC2CC78B7A06AF7FBA2233EF26DB1983EF16A3B897F9AFF77BBE6BFD04AC173D
      2F40CD4BB7F9E6DA1FF451A10E5690DC858BB48AADF4FAF927EABB2B91195AF3
      202E0E421010560E55EF0785026706C058DC7313E6EDD9010CBB8A5050A56308
      C7F6503D671577E2FCF8ACF197D91516823780C14166FE95000DEE57A9A18AE0
      11F4425C9397C8D63E43059E9CF221DEC969BBA52F58018CE9B27BED6988574A
      1365778D1CAB0CC1F6C22C9BEA332205B5FE97E12EF62039B30C9823F5ADCB24
      EC0B058FEE63C3C721812D701E4425800D86F2A7240AB391DA96CD1D905A0C52
      5702A717A0EA45863D70938984A8277705CD46527AC6745A223FE97A8208FFEC
      2F98A3E4F261FB58B951E5139A52820FBA814C3EF0EDFC9E3C8242BF08817B2E
      43C67B97B18B7FE2491A22ED60932AEB0064C21186310C8B2EB11223783F6AA7
      70361122784BBDC30CAB96E2DDEC616F7D79679D492F7B0B39725732E91653B0
      42BEA59BAD6DA918C55C9EA5F2DD373754000315A07FE9871125A1E93C84F2B1
      298FCDDDDF385D8210ED316E390F6A1F8E2729B53061082D3468318380A28D3A
      487106DCDCCF151A56252091327617BD832FB7B13A81B67E12D1C47A2DDBF4C1
      878FE27A9A7D4802FCFC6398FF34EDC10789E10F9F5497C8D7B279E26BD97B51
      CF6445BBF8FBEA06EB986EB0A60BDFD3E1492D5EE5978427F543CBE9587B5663
      BF41AE15EC89CD8D7DDB1A8048A5E30E0EC0AAF321B2A4C997959D86C6D6BB23
      B0B97BA9F0BF722EDB5E2AB8EC03AED805119CE2A56BD7F100C8D2C51E7E0C3E
      0D62180982EEE6553944FDF9F8D3FB83C363EBC3E9D1F17BEBE4DDFB63EBE3C1
      8763D9F16FDDE65CDF4EC6CFF1B813BFE70B6442A888FB091D863268F798547A
      E12E557C2564AE7EEA67EB87EC5E43136C92F31A76C0158A987182E78252335B
      4142E725945808746879BD70ED98A16EDAEFC5105BE561161A1D9F1002C174C2
      A13E9B7BE371AB378A48F44B38E4DF0B09B87DE0F9E1C9175C5DCEE72D4A70B9
      6463EB24A1D4812F93ADEF66DAB2B5C5E6C6F16FD6D627CC8C4CD1C304BBBFC0
      4CD7B525887A39C9AD5F4E4F3F95D20EBF175AF4D2E4AB5832B4F6C8B1C72583
      6B2B38CEF81E82ACA4A204A72AA9549F52022FDA72D630E4F36DD53E55E2247F
      3F024E4250BF3BFF50EE56E313B835D88461FC6F7080C91828D782ACFDB43737
      B68E423F4A86D6793209FB5B9C1EFF4B92460118F87DB165FDC8A964326DE012
      A1583394F24014713D81CBBF175270F1B5842EA67A813342DEFE2CFA187691E2
      6F5D6D9BDAA635AA89268556C3ACD457404556550F395FD584C8AE6EF21C21E2
      8D21E3500B8A1BBE1B5251AC4EB985D2E02DB218FB7E7F244A3515DC5E52A63E
      3288BB4CBBF4CB9D6CBF1BEAC8D6E5036CAF0A135D5CE51250222207F781A7E0
      E13274C895C19AE76206FA2EFABA827B99C8C260D89A345A25BB73DDC8584344
      7580C9DE74F60D75E48F6A890097AEC01041A7395B0DF05FDFCF56017298E57E
      2E7B0F7324816250B72FFA93E121BF8B737074539D22BE027AA84E68A063ADDE
      B342EEAC6B9C5A1E90F0699339AB2BE2F7336B924CA6918F759158A180877495
      D3A4F90462D4CC13914C14C4D8842A6275F6BE8F78147B58D61924B104DC299C
      24B82BA0F8307C2D4FB1CC91F3DDAB549C07A2DF214F047BE6E0F9C6491E7229
      9DE4C9C3093C075647C0BBE5C35775F67B1B650B2C55F0E87A49C445FA14C144
      2E5A591FB1EFEB98D536C7AC4B13EFA3F612CD76C7CE845B055DB68A666145DE
      3155B205AAFE438C7B825458186B870A5127CB15205CFD572D88C3730C8459C2
      2AFE61EA8F39AD6F1F752735B35649215B4709D683F1B1479C83852ACBF6B7F8
      BA5E725DB86A60C5C76845EAC10753CA59A5B133793F61372F68878633549000
      DB3DD1F7F1884956EAC09F2408CECA5AA0B98FB3B3DC76EDCE72DB8FB5B3CE29
      3B08B4C12166068187613658411B60BFF3D34365089652B4223198CFD02AF129
      9D006E5302169D8903DF7E2D425FA50B81F83BF3D5A9B47DC0C61CE116F56FAE
      8F66EA67CE5D3E4AA6F8268751D8FFBA2A9CFF1B950A4F8E16988B55443824A7
      20EF6D6E705520C5B564E59E0CA5CA52701DE9D20D64C3201F29B6C43150A2D3
      56F3559C16CBCB1109A754D0768631066B5B45D680DE7192EFC816983707E462
      42FC6B2AB23CC152F12B2EA3641C16894DE30FFD70652ECE3AC9613E4430C2B7
      64DDC88EA6A2D27C4143F2CC89523C9B2855673EB3703C787F6EFDA775F612FA
      9F10B6CD134FF7F0FCF37B98EFC90AE64BE706E586B7A25C59F2CCCB7ED25801
      05402328414B274D94CF8DA0CEF244E5AB10934C528752115596B53A3C819F19
      06B1928C12535645BC1529D7CD8D42519525CCB75050914E1D66C97168255052
      A5025706F1CA62E9A6EC6AF4864C22EC0905E6B07808799F519D77AFE8FF4992
      B1519C25C5F9DF09F26BEA83CBEDA7DFAA3A919A1A768F61EFA25521554B3D63
      EF5AFF491B68CF407CBDCCF8DC9777E82C8F4D13F48AA2E188545CC0646595C6
      0FBD2966778006D7D4A32AAE99DA7D044143013C8981948FD2643A64D8802DBA
      638B3B9F613197C2759965B918F357DB613F891538E65CD862A752597625BBA0
      C11EBB0C7DFA5EBD1427FCC425189B3262D46D97595431862D2D7CC6444504AC
      41D587CDF15E1D7C84692712168107A5692870D1F2A3F83083EECE08613413B8
      E6B9CAFC784FC7E4DB819F7E45C2A156053A44F82DFCDED378BAECE01EC165D6
      B6FAABBA5ADE5CBE981F589A3F3E5E1E845B30D3AF4865847B500602C3DA4AE8
      E2FD32C00E3598432AA85980013262E4366512F052CAE1F9F81FA78A792E6361
      CAA9978BE001BFF857085586E97A687AF565136BC4894DA6A9915837241605E8
      AF986C6AC76AE7818866657DA2EC768F21D9D89A8D032421CB924C5E49893A64
      406352F0F504281F621A9C9600B4443B0877F1447B96235888A881A71A9B1BFA
      5C63CA3D1BC34188C70872A4D73CC20E8F48908505F8B69A528FA0F4752B31FE
      5242FA14815E250691E908DB1191900AF6C3A49EA901DA5F822F6561CD82CD6B
      EC8DF2EE3DC86FAD212FA7EFD2FE568495E71B12B33B190E2399E64FC1E0300A
      F3194392CAEBF32489E4369737C9602F6C32D07C1C40062DD80B6389B8CDE717
      BC7204FAB34DDB8B1791B7A8FEFB018CB27D63D3E9C3BC5F085904DFAE608B31
      C13C4CB03756B50CB39C69DA47541DB935991432DF7457DA41397BFB74DD76E5
      755F975F6E470D229F2F0951C40FCC96BE9B597F8277DC3BFAF48E958CD9C575
      3A58E143827AAC92AC6C15CB4A14E046EC2F84CA15149C2823E7EA8017FD6100
      9E05E64F660ADEE71F16D0F5FF517CAD14B88288DCD70D9AA2701CE6BA8B9CEC
      7741DCAFD28A7A40407A352A714CC86D11D19CF18A6FC1AA10ACAFF22BC2F6C9
      39D4A6CC7AB39F96639BAD9FFC716F9A0E45BA657D00A7C9ECA8729A8C260ED1
      66AB26B35346C66ACEF74B7EB2EC4D214741BD832E2EF9AA1426DBD60DCC76A4
      06C28257AA068F8150227BB36E6508AB878B581C907E497011EF13146BFF4DE2
      71DDD6F7477F2CDE2326D17638E0663671BE76C0140810BC6EEF6C80DEE6A9F6
      013B3C714433C7D6616465902910AB96DF21D80BDB7F27532210207D0399512F
      C1ADC8402FDA3D9621AF3210E3333094F202388E90AACA11544E443446C71227
      B867EF5564DB30B07E6411F5E7EE123AF68FCC8524439B7E514F8FED12F42BFE
      6D5F6411A2758279116AF71C91D76408CD9758F7626E6CED2AAB2FD0811827C1
      14DD7A850E2F3BB451B0DCB7B628FAB58525DB791130A3D254EE10C6ADB570FB
      4C26EA364AF53ABEBEBEB6A8067CDF3ABEF6C9968FC2721B0BD5E4E39C379A8F
      6077DABFD1E102D597633AC18F6EB3616D21F9B6F8C5373710BED4B6A9EBDA11
      070C3CBBDBD22FAEA6B77D726CCBCB8E4F4E4E76D43C65DB3BEA6A9687E30AE2
      BD5E9302A10364473FE7061CDCD28CC383FA317842437F951DE9F055D51F77E5
      C2A61988A77018E6993221657F3214661F4FCFA9503A0A3927CF27F880009140
      C6612CCA8FF6E3D9189EA157B5D491004F5550C431BC2B4559B9371E67E79131
      8A2E5EC17583A2271B97258F2760B0E02B6CA39C441B172B1434A815E50AC6D6
      690F710DDE1DEDAAC6330402E117330CCB1DD876C1A1FC1F447DCD4AE0B2D249
      54011C5178A70BD8B4CCC10A05B9E64C1A9BB14D348ACA0A7AAABD1BC6B03CF0
      A62B41F625EAEA4E318A3F697F1253E28EC60A697C491511D3ECA062087392E6
      F9EB6AF73E65621A24CB12F1D113822A4444F294364685A62C06245171F369D8
      8325082B6520825F657C3386B4B979299939122C80046199F5E5EE2A8B53639E
      7C43DB6863A5DC469C728FAC52935DEAB8A44406D609ADA0F112C2D91374383C
      7F736335E9B51AC45CB55D7A760D3348DAAD55B469404354AB56DD6F89C07CD9
      3C204185E20CC913140DC9F7ADCFBAE13065B9C886CE721BAA9234B202CB1620
      1BCC2488CFC8B2999D85D72043C74C78FE33A7CDE83EC49996C0840AA04D879B
      BB1F9F56C4C81970459AB19324A46EC8E86AC6B3241625D83A5FBE1C1E1773FB
      B12849BEA245B9E01DF189E3697FC4E765780ED5E7F62E153C2C3A1497785AEA
      7DDFC29D784A8C5D617C78197F4CDDDB611C024BE494D28CA994CA9668033415
      F39102212D2F01533880F70B073319C08C678C3FFD25A670FE966CF9CBF39EEB
      7A6B14CCDDFBE373D10BFBEDCC3AF4E9FCD0E8981AFA94DB134AEF8F9D154244
      029130A0340FFA8AF638A74B315E127B3884E45F6A179E0A9943C7FED5E1E743
      1DAD27A30DB7193583EFF36339A95A6F39783F3E65A271D967C266CFF4441813
      44041F0963465C2A40244484E280EE186E9AD86A82AF39D7649B3CFA84766745
      F6E53E49C9E25E175C334487ACA4D349016121D41A1FAAD37B683ACE1191A72F
      7B6F629639ED7AF9E05DFC54AE9DA1196A399EDDBD3E32C2502D07E667AA24F6
      8B3FD02ABDF8932420CD5D4631CA6E3067BAF302C3CC2538019A1C3963660C40
      2C81AD31CDD17DEE4DB997A99273326D5E452E943C4601AE61ED99852A538817
      D1B7CC4D2ABC51F27CF681D47C091292F20AB9B6ADD4741D06DE3AF2735FCD9C
      36BED8626EF5FBF9D48FB8989307023782BA5070A1B37C5FAD07609D6FBE9E4C
      FCAB7378A907F94A5DDE2378259AF54A5CDEBF971B6A0561860C91D17EEBCBFD
      BA3A82BC877DB88A5EE3409480AAEFC9782A737971A0C33B8B5A63E297CAEE5A
      81B7AFC98547362BB0EA15B188166562491DA4C4768A0AE2F9CB8EF70EDF5CFC
      8172E3E2CF958443FECE424BDABC947657D0C8D885771F61C138E11E9A0C147B
      D6EC843A450540C18CA855BFC6842C277063190161AD262583AAD46EBCDE8A09
      A614F2947576F2C041A4780167E98E71A118C90BD72A2BE2D59C2845A731BA53
      23566E6C6E7046C8E1A72F981F224AF84A32BA47C8EF851F878625F6F9C1830D
      7A113CE0281D40987D744BE64EC974C79591463D98F90DD7EC97DAFDC2F4918E
      50D9FD21F35C9BA27E912DAC9CA692555A1D499EA2E950B81A43EEB03224B81F
      DF06F26BD87E09804D6AB505E4C6DBA82F237508490231C15F4C2CFB66CA08C9
      05790AAAAAAB75AC910F58C89193A7D93819EC7D5E440337370E3E9EBDB3B631
      F4D79B81730A7A02C305293874580D22EF90325E9664651AC659E5DA16ABB48D
      27E50C7F9D5F09CE49E7C132753A042F428FE228DC0EEE2A4A77B53E61B15C32
      CD10463D53F9F37CEC3B02EB9EC0D52915172657E9114B98E41C652851848F96
      C2002D5E34E8F441384D59BE312836957720DDCFF25F75195084496EF28AEA81
      7409D20B7314A8BCA67E3CF6451432265DAA5B62ABDE39B25C4B421DF7233FC3
      CBE045D462148E33CC4AC6763072006A5E551A29EF99E2B19172CCE54B641C2F
      21DC4E9AC42B0C94206C39A1CB726E119DAF2B00009A8372CF1792E6F4CC94EC
      2F8176432BA8D6D488B2B2FEC6DC7EAC262D12D86E70BE4500F3431FC38E18B0
      949C68D28ABF39ADB8F1E2D38A7F641DA5977E0F1C749678C825F2048732AEC8
      BC8B51D9ED1668F1182BA3EA8B5D4C60102936108F8B8C034A04826B530DA9AF
      4EC4A889D1FEBA71D4E6C6CF1F0E8ED065C446C021EF9A7C3611927E742290A6
      FEACD84DD69EA4279D02886B982835C2FE3A4BC331FBEC3E9E7F726D3EC78479
      29646C58C5740B9DABB49BE5637C320F63CA732A7634A57B61C14B2203DC157D
      B636C49619EF688528E62CB1E64D2A619C9D18F0F941EBF7E5DBAC02B18A8CB0
      2BC666964C12666C2E20F1D66ED93737CE533FCE6057D051CC726B3FB743A4F4
      916246995094E0C41D0E865C999609B18F5985D6E9E6462F0AC1328B77F5D17E
      83ED37F52B61D98056E40CCCCA9BC0334504CAB254803EC63A6F2AACCBF0BC5E
      BE22DBB2378FD3F9254A322146CC9C5DCE1E27A44FD8E4D194C02EE2995ADC12
      7DAC6D45135936C787595502D56C90E780747B211B0494DB822DB2A34E788BBF
      71233D3C6C8B6637F79231256F1A0EA503DDD2364087507B328EDB74AD6D7272
      F6ACF77E8E3D1C774A714D60D8046C8594614AA6D9D2676D8F7B7CD49FEC49CF
      FDCD7FA977FFC70A18F78A8CF5E727C04A278D40E20C47F4FC139FE683CE6A92
      00FD62933080D33E42A5EB1680E0808C4912B12DDD43A39A6B9528C54C6E1A41
      EA42C9A87943958ABA6FEC4FA920404D7D393FE9EC4B079121D465D54075744A
      D09B0F7E15E34AC0A1ACD0D19C4A83A373D203A82F364BF58CAF6896A5EEC595
      44BB9B5620CD84625178FA55C64AD111CD980A31B8966082C733D202405D407F
      93BF3FF749FE37A9C1C74E6C204568C2474B94DA4A363291A352AA74619F6EA3
      717476CCE5374914B0A15AAE43AFEC43DEB068F30E63DCC7268CF4CD6124EFC5
      8791E0057A611FCC3AB0F15AEBB6C098D5852A6B8FD4D4DABDFD7F0B703089F2
      F6BABD7BE0C761265FDE5DB79717F1305ADFB71F84F11AD37E802939EBFAF243
      918EC1DD5DD3974F85F8CAEFDE58B7771F4DE3A19F868AF66B272E41DB47E1DA
      72CEBFFD89BFC67A16DCF02B315C5FF24F92425BAD1DE763B8613A9C32F7AC23
      F5D3699669DE71D6EDEDC13359636321BB12C1FABE7D3E4DBFEAB7F74C48A21A
      92383B36C187A70D3E345F7CF061A123667608EF10757CED550EB3DB2DB36D9E
      76DBB4D660DB3CFF8E59D7238123CAD5205061796A85C9C37ACF503530C319D3
      318B9141FA919B1BEF6E0071102EF4A894194079D394635ED0741BC124E02B79
      FEC885F2AA4A5AA74CE3D6B4FC1E5CB48355D4D47061A68A462A6B626DCBC294
      CCDAFA42B905953FBFD95A543D8D278B5457B5534A07E713528DC28B67A50893
      5D4A95C7A352CED2BBF91A2AD36122624ECDF1B91904B689430AE021E9B31F4C
      FEDA9FA873DEDF6A0F27E7D3E71EF37032137DC65090CD89083219214D54070D
      89FA176A74E35B3657B181F2EB2E48E2FCDAE9345CF8E1B6BD0EFC68B45A1EFC
      F09A1D1B7E34BD2E5ED2F21CBCA4DD70F1928EEB797C375E02BBB44DC3D8DD2E
      5EE4385D1BAF725CB80E7F36DA1E5DE7B59AADA7DDB5CF91AD55E606496D6963
      FD1D7324E4575F11653D89FFDE82FF198157CEB12F356BA10C6A6B0C6F8C6CFD
      DCDBFAD68C96A7DCCE24CA61EE61A9B26C9B21469F9B06C89E2BC14C08B3F855
      BE2B133241EB20DB729B221FF125CA1AA5C430455A0C351562A850CC9A015BBB
      2F645258295F08345120D2100BFA48292AFD69123D96B2EAC89A503433524C3F
      923395C92E43085F4EF052D6177CB375CC0A61CBDA868F5B64F5685793FA6D15
      C6F180D269CB59679ADB7593ABF1984A2110716C65899FD19BFF522FBD82D4C7
      CD8D7DD97D8891EBB23C2C373C927019244DB2AB30A75E4AE5E4BC52FA1B773F
      A364F6129C2F65E882F33E9ED00A0E45B5B654DFAD6DEB15A49E623EE13FF6C1
      D55A51A2F86E31FBF03D13044B57BF8A1971F8A92E125010ACD97B4536750D25
      E863490F27471A39BC746F8B22C7D308E239415C7418ACF4175C581B4E918979
      8A2A3861D5AAA990CE9914270C639E4E63C40F914258171ECBC623956E0765FB
      6500AF844DD5163F1CBDDC692C9B3CC90713CC83D42B9C7BBC4DC1FC93534FD6
      DD9CB65BEA029C2BA510CB0D96130E97B8EE0B9065D235D9DF29BD4F85189C90
      CC752037EB0CA848BE9F0A3F97587C383FF2D435340B95B353DEB0AC617F7179
      C34F69CB1725875534BB672742E195AEC69E6738817D4BEC0FF79F7DF69C7CFB
      7FA5D955A1C5F343F7321A216D1259A4A0E0FD7D0B054724D894D33B28105998
      96BC1B0DA3BB58565DC92E8C6156366A72DEA1E412F13EA4FA393FB2FAA324EC
      5356FF6A7CCCD5E7F5D3810DA39BEA606A41D852EF88A2D68A212DEE2BF58D3D
      734B08684101AB31696E234F1539466B6F3F5B241D50152DAEFBA1925A66E949
      9A0C537F2CE1D9B66551D95FD5B74188F07255E6AD1EF69395C9AFD8C3DE2175
      030E1D9D70CBDE3AAC57770BE6A3132504259B3B102F816465C498701DB21A9E
      3D310E1A387BD661B937B01E221FA5C97438BA5DB24A785085C49431EB0A0919
      384FAEB07EAF868F4AB538C9570213CAEAA97A4E38A7E0F2B220D946B18081A6
      525DF74D28A705678EF922B801A9238751D2236FABE4306CE3DA4CD23049A973
      3556642E8EBEEC94F4E9B36306F72795EAE515B4774896ACE17DE4DA6D5ACE55
      CFBD12D09C2830ED6F29E97E44AA6C6EAC5349F7A31F7FAD86F5179474AF6037
      AC64F695562C28613132748566AFEA7B1546203A775704EE40026235FB6042BD
      16D20249A4A29150E7A8AE04D5181522D41266A4442801EB17DB33CCCA71AB17
      138E7946B7F796101D536A97F3460291F5D3B0A7CDB5C10A74D3E6C6AA417056
      14B9DADC384AFD6112F79234FE56A679DCA895EE31453848797829A2D96ED5C2
      BCD520E4A632D5E0319DCB2B2B8F6CF9E7A6EF7F81A9770DFF5B4EB73FF636CC
      92B160B346A6CFF15EA3C6D3D6F6CD3EB43BD51E3AAB604724D60AF6A07429FE
      5246503C9BCF02626368F71B44D1A31A0098EFBC02C9530A1D90CA8AB0E300F5
      69F2548F5BCA11C330582418EADCCE249516B4267C069162771BF60ADC05135F
      5EE6BC7C6889185ED540D4CC255E16F52C923E562CFCB4A61301257823183E26
      D0943B7B8091284F3B2948A4233B9518A0C9437E7231C469FA8AFC6F2C59442B
      09CF7F1D56700835BAFB1B461BBC013758B97781A1571DC02906389CA5611485
      FDEA0884B276E3CE56D3B61D6BFBCBF9C95E67C7EC50FDC85F30FBE42F7A36AB
      5A286AA9A2D8E546F73E904A46B63C7D8D836DBFB1EDDFACB77EFFEB304DA620
      DAB1BB9E48DF58BFCA5C0B296EF6CFCE3FBFFBF8E3D96F72CF2F2B21CC8E973B
      FEAF179B0A29E54D50A6CAAE459D3F54FF11C6F14CF2A2A8D66CF2A7DBE445E4
      49674ED5EC666B9B720314DBEC182D7EC79E96A1683C0C7D991BFC297322F9BC
      9F6A2342DAE196026A6770F70274DD68F367D3E6DE626D5E8A3E8B6CFC9B7582
      C148D9726E9B7AD0BD39E89E741A6F4F4ED436FF96E1EE2346BE65FC334A6092
      5D2A4D07F8DB25D12A0265FF0BFEB792D87B514605B2064388A5D0BB91492F42
      2639EEE24D7E38399512E25C64396CF4498D202161F5139D9C5847C5F2AED03C
      59D7BE97487B0BB7410A92220E22234AE783A7D14D0A9150ED6183C9545CA561
      9E63ABC904CB9773017E0CB12830A58FE588181DD52D0BB047A24F7DA9C621E2
      F993DCD1DD0FCB0D7904E64BF2C1AB7FB3B7803A0E382BB94FBB74F1F9F19987
      E542AA4DCFC79FCB13982F8BA613484607A106C9B2E50E0CD27C7D76762C2B8E
      BC2241580EF3FCF1AA4934058264FBF975BE9AD20E451755B01F24821BE2A81A
      8F30869505D2160D7B59FD94DE7C4737ED95841C50CFCBF9FB38512812D8424E
      ADD4F33727C2D7A4B7649AAFEAC44BE2D92956DC559D8B548ACBB3FB58607EAE
      247A820458C164A3954C56D7D3555AB4E498D7C58D595064CAF492E3B30FD620
      F209B9481674860369E88D43EECD5BCAB82827995544E37DE0DC9E98FE0CE186
      8FD1A06E04F336702D67FF8540BAB51F0AE9F6D434FC0355E6C59FB76EDC278C
      8AAC1557B992AB9E3D03E5CB2480ADBDB4707D5C69B3871AE611C01CF19D1E6F
      7970B4B90582AFAC062FD1E900EC3EACF23C7A7F88E20D4609F0145EC9B3BDB2
      D65C2B1EF456C5834A52FCDF9F3FAF8E11E990EDE7CF155C52CFFAF9F3BAB067
      9357EF9052B093D83A8CA63D69B33D0197AE648A2D9EA2B23BB05A9826B82EEF
      DFDE97D0FDF15EDD1C8CF3DFB2DE0DAC604A392C6826521FEB41D9B9A3AA7166
      E3728F61AEC693917474F0C05FDCDC008F31890563371288F0EF532AFD1FFB59
      5E5430A81EAB11EC9E6056CE8E60FBB5B8ADD4AF951F14A6592EBB86A2D4B8C2
      9116ACAFEC3C38994611BF1E55A084B1EC408ED7F78053BEAE2AE1709D6267D8
      FBF8032F84AE6EB402D0C989296CAF18C084E5374F21DA1B6A3B6DEBBA53791D
      16EF54C32288F045873E0432E5A788D4A5FE26F7A91FD036E53D95ED5A5BFD64
      32436F717F7F9F787C8BC371E1388C6071B00B2829A96CA788E895E2783AB8A7
      360363F662188F4B587DF448C565087CC04121B9F366C954F6D19EDBB5FC6255
      D05CF46FFB49341DC74C128A6D9F9258D91E86DACBA5C0210CE567404289DF83
      3868D42A5BF9B7248D7676B54B8C9FDEB373BC3DA80652E02A8AFDCA2751A0B1
      4270EE647892A4E37747D6A7540CC2EBB2EB7C1932029B5A0299C70F4206A608
      7395148A09C157161851C2A9A4981AEB83BC9F023ACA5D9784E266E29405467F
      5ECE220B04AE5FF0B8874AB0BFBE8A3D59B1BEB2F80F10F955CE2825A2FFB528
      983BA96C1CB5242CEA951291B7E8BF52FD7C38D6F007F4770A36CFF3ABC288A6
      35F875FF3785F983FAF0D7FFF59B86ECFCDFC0F614AD5180D6FE256707539805
      CBD002ACF5CB449EE1AD732FA446394AA678FF21BCD757D49787791AFDE7714C
      85C2F8CAFC9E490CAF9C6BB952A844428AAE4082F5A344C268B0E4E1799CFE53
      3D90CE4BB5FCD93A9C9719A07F059009DC539D3E4DFB5C6F730AC2CF2A883E05
      1E14BE8F02E4816DF95A6F48C2C0CD24BE37A27A9783534BBC136EFF14B65232
      CD4AC215E4532AC602AB499EB733FBBA2AF1533A3984C57975A68988422F53DB
      C01A2511A995C3F3CFEF693902E6D03E72E82BA3E8F5230F888D132E72BB2739
      0B454C60E7FB0A8D96A4D9C08FB2628BF00900DAE0FC44565FBB3CB0C2961E89
      2880275CB1CEACC816168FD8337B921759001F64852CFCB47E04693FE183B46D
      786BD002B348EC48842F3D3DAC905819A0E53A6DB593298A635439EA686B7F38
      4A609DE4E9A6D94AC5C10B13A6489457471FD8EA7EC695A5DB12E9519A6E5390
      61C499DC059ED086433A519E81E20BD07018F9D20893C36B2DA50DDC01EA22AC
      F8516351DF85D2DBC03D6196EF9647A1AF31B7770877164AE798DF4E6E2BB205
      58FFF2CD5FDE1547A8685EDCFA5E6657D5B3CA61C561495234A9407891ECCACC
      D6BA41AF8236182AB106B0AFA6A98490D6CA07B89611A764FB9504BDB0702C11
      3FF1B26142691FB81DAD08BC44DC2CF84DD91D9B80FD5CF84CF038B89A8CC23C
      C9357ED208889929D5535DB5DDC2A38D676C23F2DB12D4D69540F4DB4CD6EA71
      1B1E6605DC5C60268A21BBB734098589B14B0E19FB6668E1C73E0173E9676B38
      00FD15D3E9CA9FA1C6CCF1A14C1AA2585FA494FDB08DD1A62BEC9E1C0F7774A2
      27D9F9BECCB4532EE2480246F544DFD7007704EBAD7C4A49A60C4559328D739D
      0643A004848095A920D9CEBEF5768663D294E82D09D8568F4102304E680DC187
      80B98163104ED09C0F3737086C6C00F6400EB67B2E353A3BF3F27515DA3B1ADB
      02DF058D10E9795FA2014FD93E23AEAF9C4E16D08F40125070E36BF27C25A50A
      A472E9D027B06F42B446655C9029578C09BE130C28DB1D90AB86389F7206190B
      789998942511E6F9201603262249B036BC697E0672417A9B1BB3120F92B34592
      199DF8F124072AFA97E190594A073E189E0D33BF671C12D93AA11000794678B7
      7EBBADFD92CD26F14828A283F74D126058CDEF182A4576079F8E80F663563BB2
      3D115200070251F52A934159F9BE306D84E20FE3C2412CA843EC4614C1EFF151
      34154ABB02568EC5E6867E24BD3A933A4620505AADDBA646FB7BEC7FC5D870CE
      6241F8D94CC66E610E2416E7128076795B0A15D04207592E569EA8359C5B64B6
      4707C82530437F88BB8F472192150B082310BFD1A6400132B7EEA6A67CE9102F
      EFE3B3B910A651AAD59C734A662CD27A29F04439874A2FEDCA48472D4575D5A7
      DC4FC5B7B4A154E0561E56C43AFE9EDD1C093709EAE971C2C095988AA7B42770
      7E2992593C44C3A71681DD5D2B4B28D083423C0811531E769DB89EA85607611C
      84A07ED1FAAE6C3D19FC0D5346B38CF3AC1C2623502B294C4A4151BC91CE8740
      748498491A92FDADAAE4F4134A0A61067A62CC91734E8952013792AA32DA8602
      F7D207DAF522D3026709763E8E9152AF8FC28C629948D2CF82C4B65E63B3F92B
      59D215C8560940FC3371B4626DDC8C1CA9A1FD1148DA22062F51BB20ED6ED9BA
      050B7D1AEB400BE842C5DB68C9143B4EA6595F550CE91B874EAC2E8BED6FF6C0
      2D7EA502D1332CBF90E5E5D15D7E95589C9C9A2833ACE461C632D651E90A8247
      F5162315168736AECE0DA8A418884546B76EB41397B074B70EAB4FDFDFDFDF2A
      F64EA85A4A15DB74179F881A8286A063960F455EF5225B7F90F4D18296CA994F
      63F8A1737A1D1E9381BDBEB921B326CA8715D16CFECC86772FB6FEA4ACDDB8BA
      878FA90368A52D1C384578AA92B1751E25C95712087949EAF83D9E0A7C198132
      CDAD86F4A532ED656E4B1FEB3F91F6CA61DDD9AF15678CD4A6A6737943B8F9B5
      4BB0B921FB4E158E2555A0E1419E4F8918E8A5CDAF84ECF6302F47C36C6E1DF4
      1AD3821057B0DBA692136ED84691F4A55084EAC342F2E6133CE0EA4D735178A6
      8A6CD2E8920D5EF9A570DDD8195526129FCE1548763CF0E686AA81E911F06FCE
      54C4C3F412DBEC5B07E44CA2AB13A663C5D8EA4C4D334B95D768D63DA13D2965
      98CD3190BE8E5BCC1A2B68F94899A4A011FF158B679EBF70CF6545F7E552AE18
      6D2DD41505E78B1BA6FC470E77947329B8DD6F5934BC8B3391E6FBDAEB91178E
      138CF4C0ABD069DA557C439C808C3B9CA619FCF9CBC47AAD3E1F91A375F8F970
      EE8918ADD098BAA591CE46E120FF4F7C87CD0D9888EC9AE5E7A56C3425D949B7
      50C0835F194F2228FF6D209359A404A2878783BA61F629E4553DE0C79480CF87
      EA8D65B247E53D8FE8BBD2994639F38E9E583D642C4FB8946C874F91EF5B74B5
      96E976F25DE894714C757EC5EC327E089000318BAF4219E22C66572A63E14295
      2B1F9BA2B2B716EB88F1B10FC356F0241825121F831904F72A58994F386D3C5A
      F234E597FA8352C62965A10E1AD6C5AB5EFB8514AB741E5AACF20C3D1E7446C2
      9E755052D01F4FCF752AA776A530522C4FBA25F7E8DC302D9FF89C9B0047F7D7
      8D63CE39CF6FCF3A9D37475402AEDC2095B385B59BE6E6C659324DFB02977CDE
      F29A9F299BDDFAE4A4386AA9A27ECBC43D5E7C19E1A7A38AB2D157E22749696E
      CF50EAE1428F966FA7DE645E77AD0D9D81283D26C51EEA853259752AF56E75F7
      1068D57A6E9ECD8D7774246FBD3FE5F9E259BB5CF2929E2BEB329D2F589CDB8F
      55D577D1DDE7061FCCF9C3BA3DAFE2AF52AE1BF75AA37CD737F7A98D5B454552
      72A7F6723CEFFEEA8B6E5E567F85D1654D7A020DF372D4D801D7ECEECD17DA56
      80CE8B1C90319E9EA7E8AF83807A8CADF67C8C81610EEB2D564DC06C51BC62F8
      43F4A795F4F52B7DF449D99F983406161DDD05566E3CD3F9AB3A539AEA30E6B7
      A5ECCFE51737C88DDABB39D2401D2F2C1C491EDCD60D743E2A47A2327570CD43
      A1B6A525C5DE96F10CDC7B460A302E62C545242B5D992679321CCA500FC56F64
      78634C2A57FB2E30D9BE20EF09FB98609E229F87F3A55AC58F93699109F956F2
      4435E3A0C7495701611EA9B51F8697040E85C9D8F3525BC59128D48327D9CCAE
      78142552E36B7CB3AFD15D035FE35325E8F851061D25B8820E0268179C734244
      2E23C463311FCDD047B3A5BFC941B6C7613CCD8ADCBE9D35B4A7884A8795CC20
      4AF19F29CB48CE15CF0230651F0F9D89142A781A85935E827C594482C90EEB71
      B2982895E27D2418A020CC8D542DA5982F0A10DF8CF4527DC76E3902BEB9A162
      E02A0E5CAA69B91107AF0BD6F1C13E8E849A8FD7701FEE1CF271CF40F7672E4E
      2075D89B84B13EB8A779A813FBD2F87890337FD4BC3517E2C7405DA5C205176C
      4855572AF81D8B2B4C0EA2E8961E9C8248951BB9E2AD5A4B6422E2B7A46557D7
      DA9C88D69386F6D01C5653A51D591171EDC9B61245D1543158E9DC2F93A60A9E
      CBC95A667566E553C25F11E4D52C2F0BB6CAA7875C48C96D2D18104D75415345
      9431F5A71C894807384E3199F0C60C65CAF0A5A89F1C5FC33DEE283AA736301B
      E1A5224879624C219AC54F0A1272947A82B39131665D1797A6A7E8CC7A815073
      4531804F5DA92A210DB3E76FC90592E9D2260D62813ACE3835DECF8A8376DC87
      C5FEC3831E4CE8B1B62867BC263961AED743F5F47D50978F502ACBE69C0A3E82
      2BA9D3F9936F19F5C2CD9255AB478B789FB2BF683FCF9B163EE5D2E9C24CDD68
      B292796B76D5DD9C436774665B3D7C5BF1616789F91E736755CEB98BCDA4949A
      CE358915F24191CFB4481D7304988E6C5758DCB54EDB8460D1D441B9D921F7D8
      21B1B5C5D872749E0FDBE0A9764A3913EB863AAAA661DDED7496CB70E05AD929
      3C4E382921D54019E58C2CF853D5BDE451176D603D59FD26A5DC75F52E35CFC0
      D72B6FEEBBD3FBAA6FD51F25098DCBEE7325697E4A2BC52770EAF194B0A1FD5E
      9DAFA19020CAD58EA65C74B972515CDD33B94846A85442F6F3E4A9CA01742767
      040054647B1549398537A67780CA5658B609C3A3E219DE98CBF6F5CE5FA775E9
      3A6DCA0378794479A9AED796D99B35D82235F4E294C4314C33DC2B2CD1A2ABF0
      AFD7BFA91D793BD04873DF3A94F9855CA61270B27E4E0352E885521AAC6C8CF9
      DB290FEF56D07BEA5F83BC4BDDA5A4901F95D4A69AC47FCEF4BF31F1B2195313
      1BDED545CA15C7573D944E787192DCF6B594E3EEF7AAF362FC4299147E733E51
      380ED98028924117BC311E7D70D5379E8DEA00F665E82F30BF6E2148147E15F2
      54DC489ABBF7D167DDB082C1F17E25369D44E2B7E26CA3E00A2381AAD6010371
      2D2254B103B775A5E56DAE44A57C646741439152708BF003C0E6A0927675EE48
      A20E1EB0606B81D92DF6AD7738583E4DB9E911DE4F8D4644A67B90E828173C3C
      48FDE1500907966DBAE9872C37B1FA589227A36394DB4CDF649554B1149E5391
      1ECA4F620F890ADA093FAD002F9BA409106B5C3A2750B42C0AF558FC33F915C7
      DEBE0EF349DE440519A5988814E3FF54D27FCB8A12F44709E749654F62CF6CDA
      F81A0F4E2DB4F49254292F9EEAF2A3F87481DC26053A69A4D532D24AE95CF933
      435D40A0114632E947321C8BCAF941E250AAC622C0CC274675DFE37A73B9562B
      E94189A817782487BBBD6208D1AB713325F97E6A07FE2411E9B8BE85723C0E22
      59DFA2014A24E60D1B2A18D55115C51965688583CAD0A5737F7AAE96E6B18AE5
      F4FD4C063ACAD0267CB342D46228698454E0F21E05E0A22FF45339BE14CB2146
      57899765CAAD11324BB81604E6C9D80E3225C308970A024A3F198FB93020A610
      25287AC2852DE086645C6EE44B1D0B6FA1C13264960B162A54907C88CBB74B58
      B2F2C290F037C47892C0EC67050EDD95CF07B1D318DC06B91F31971CE15D03C6
      CBE15CAB11271EECC8A230446D52960D564D60659E002F062C097F3251C0E87A
      A73CB7C824F63B22629D013D9F3F40B3B9C1E1554A3AF2297120DE4B547B916D
      FDE9EFDC998EABA6772DFD7D10F5B35DEBF030DBA9243B63E30ACE725D40ED67
      27F3E6C63CA1DFF8D8E463B7873DAE76FBD86C72C5A4D78855955CC22588C9C9
      DA54753AF667B07FFAD11421C5D402CD85E18D2EA85F90AD334C98F91253B29E
      F55318E75B20562691DF1759E1B16CFDFFECBD6B73DB489235FC5D11FA0F18EE
      138FA96D9AD65DB26767376449766B5BB79564BBF76D773C0112208911087000
      50979E9DFFFEE6C9CC2A1428CA2D4DAB2DA31713BB6E490401545655565ECFE1
      F81316514B4352CD815185829A2747E86ACDD8A8BF74A27030ED945B9675E04B
      9257967225AD4F4789ED54EF660000C96A3391B795658FBCB9C58569C1F8003D
      9C4174CF113DB7B4A324E3354D02ED8AF8DE1FF7A61930018F180DC3A022F039
      A1CFD252366049D178A4F00A3554E5C9A7579ACDB56B4AF619312232155F169A
      669A03298AD15067C169E6DEE2A71F7F36D2E2BB8130124D5D7C504AB3E7CA86
      2262E47A34D2DF11B62405418B010E13CA9025DB875749D2F497D07E992507B9
      35EAE181FE28F28D12EA349D3C5E2888C62C6CA885461D3881FBD68CD4DA6F69
      E72E1951B5540BCCF6E4B703271E5F64D3D0F60BDC0BFCADF6A30182D43685F1
      FDB3D53655F882F1890E1B03ED888E2EBC66B32B1E5E214932ABC4FC9A5D5096
      BBB9C0F3F3E2A31CA0E585EC17A12496A3E4251B1EDC04920A59F001507DC1D7
      A2465EAE7DDE4B1DEF1D199185B23EF34A8FC23850B45060DEC84DCB7B096820
      E389D36602C7BA03AE7FEEA48AE6BD87DC5C824C313AC7BD204B27023E827394
      61592729E321D379A7FDBFED90D3441C8E91F776997746D32140ACDB36BECB3D
      8502F0EA0F93A8A0F12E21D1143830BBCDBEFCC2BE143D676A5721F1664B56F2
      39732444C6280344C1209DB76BAB605C1C8DCE249A811DB1A4FB18D0F7B927AC
      3574A4440282C3F1935E16FA970A582830DFB974DFBD9334844F03360F43DAA8
      59E90F3032003FAD80AACD12776C2FE854A84C891F23B26680BA0D70BB08CDCD
      96F54751E878342D11EE0CF4F5AE414D3F4C6969E72D3783294C4FA8D0F8E257
      73616313772EA8E2A8FFD42FCC657840FEB3F9B67E7810E064E9FBF1457AC4F1
      A84F240CF38D8E577E1B7F777F97BBB9F5CD6BD5D7E4AA50CED4460592926E3E
      D1F87CDCA8149824CBDD1B786D9B4D140712A19DC58525273BD9D58E26C9C956
      52B1858B036FBFD0F194EE8383AC1C2B9A7908FBC9A63EB270518515344003A3
      8580328B538CF51055211DD1372493E27E8354433F1D87165E2849834A0B5415
      4ECB7DBC9820D7D1E2424CFF07106708CBC0E9CB7D78F29D5EA76B72FC0189A5
      664E094752CDC696B0FBE6020180D7E1306673E6973920BB139C814DB2147C29
      5D2FEC0EBB92F471D0ECF5226EF688433F610685A87821A0154988AF224A8D9A
      205E04FCFA03BBE219775D7853307B8B0BDA62A69D61659A88EF5EEE3A8EA2F8
      CE74E94475EEAB84C135AD018057E2E8175401B47D01E0B01B5304EBDF2E19B0
      7A7AA029F7E5690FCA4C763977062D3345F9316DAD72B22DE0A2F859A0C770E5
      7AED3B2F6DFA52EDDB2E2ED8B546B7E973028B54E9B45F4C33A0DD6B8CA7CDE5
      3DCA0A801200078DD2D7287F0994A94FCEC23169B67C766DFB32670C2CCC51A0
      BC48533EE719237C0A3D662A89BC8B92F001DDC6D39CF13B7D1B523235A08903
      D8316F56C21B6E67175B9A114B399DE10D1617CAA965FFB532F32DF744E3D5B7
      ABAB8FE368E10DE0452058073459626EA20E59E087219D302D117EEBBFA63062
      CE5D052C9522A2372AA95253F4E6AAC9D6DB5BEFAD9F87673C012D05FAE4A073
      2FBD319A438B544C4FA6532626096AE129923216A0ADDB2BDA7FF1D8C9104811
      6F77FFF0103303EE90017441DF5CBA34B34366DEA34447ED78DF75BC9732FA7F
      F52EC3DB7C96D14393B9243869E9DE89E356C7FE764C9BD408EF20B982FD660B
      E85B15C22441592F379AD5CBBA99F4FC33D14ED38A66F68401C57676961E8902
      D16200AFB5CA9E1E8585A83DF0BE8BEB6A27C1B6B73310015FA8F1D43CB47737
      CF9D6951E77C73D90637A9E4AF1B23F44BC141329DB4EE4BDA8B9BC440D5E172
      5B64EC6E319DD15FA65CCA431863A6B8A317B22D8244A5B9A11F3B1573AAA02D
      0E196AB1A6511CF05973678E2CBD10F29B967C495C407EA5926EC140F2E50271
      1D70CD6ACBDEB5C5752086418D14DA2D32A5B68684D43E0D762479545BED66AA
      C65C5A18B198DCBC9F1612E6A99CC5527F47B3DDBF24D58F430483B21197586A
      DA484812CC243D8243569FE91733C44227A25FE7C9C6CE130B90ABE8D0CEEE48
      D639A4EC2D5E4D93F27646C79703912CC85DBBDB29FC9354489A7155C6903C72
      E5B2E23AE9792FAAFC9239AF1D6EA21AC0DD2EA6890342AEF3473B8939599963
      4AA0C4A516D9F7C0A086B54866E13063BB101598B6B3031F4BC922BD008EB15C
      16ECF9F97EA3231F1E2A6EA99902B26BF20351C7CABCD7DF33C67A53765C3EF2
      D4249D4B5234D431880543EA042153C3E8E60AD5313E8C58BBDE5BA55C33345B
      6C2BA79C3539DA39BF20D5D7B3BB55EA77C863BBF51C535DBB15F8CE1CC17D81
      AD03DE4717250E8679470D5E362E6294F870452CB0A5D2CCB6104F13B290B53B
      093B9135034CD050BC0140E8D1481226EE59E2AD3609D38941D60852CB6BE9D3
      77C289B1ECE95ECEB6670508771ADB574AEC2CF97CB5FC478EA0D2903259E9C5
      85C23A04F0E9B45CCCF829343457F8864440B49752E791D0810B229745D2EFA8
      20AEAD1DFA4C6E907F99B4E14BADA8F31ECAF31BCE3E97D1DDF2691913081D86
      3C35DE731EA735BF17172C0580B955E2FD6D4AD36458AEED60D85579D870AC87
      916ADD98CAD5AC6883BFE42E6CE670E9E84C31B09D31799FB5F495CB8BE445F9
      3DF17ACF42141F2525B71DCDD85717C4C10F341F9F68771E8CF7529AC4E72803
      EE7AA7680A0FC51D959549EAC2D62E2AAF5FA895C1CA77AF741609B359585735
      48BD4BACB06BDCE15639EE038CAC39F17F7D260EC6E027D584BB68418EA1E569
      2674A41C03D6E086AA9606E9C0A948738E06B691B11469416BF3B1A5C073BAFB
      6113DBE8FD39C9B9D4C573A3F4EE255E9B8F07301ADCF54B965AF6F0603A3DA3
      D8B925107368116067CF80B9CFAD5C8308D0991E561CA0E3288D7EF8F0070331
      7FCD09DA6B7043DB70E8B8A0810DCA10193403FF8DBB33A5B692CF51357A98A6
      A73C1AE94957366BA861AD240C35E8DD2B0D0D281DC63220B306EEAB149A38D6
      8A14EB5F45EC0849BF95C66596F4AF318A3C99CD99590CA588A5D138BFBE632C
      7F8204441D03980B239AA6C63B6DD5F709CA1458CDB44ABB0158B6F16D0C5BB2
      13FBE7471DFAE75074FB61DAF73925A170C8DC19CCC149292489C36AEAE10B20
      2BCDAAFF829FC8C1A6B370E0FD747AF8DF676F96F97F2BEB3F437D98244EC928
      F1F9EF08427DFE4737BC69AA15E749B1AD041A468E4B26A8E8CF9126D6AD2B51
      8B79EC74B748BED5E1FE515E575254F416413F0D0C5182738A2C952918975EDA
      0DBF1599AF8C6B67C6570B40893E1BE0E49D5A0DFB35FBE9FE95F0BD99936EE0
      1BBC513DD29BFD5229A2FADA0E6665669EC5C396D5E0F400A8A9C7955ED27C53
      41C9D04C9F40AF428784E35E1804D59819A98D6A06C3DDE496130857D2C37C13
      A529B38C503B68788BFDBEE41ABEF6BC7CFEFB7B5280C7A204CB4932CC4DCF36
      5BBD709E8C1BDDF7855D1D4D1A65375FD9B168B4F0A39024913F96C8E37C8550
      B0D38A6CBADFEFA7D3A48C198FFD80F77625C5689F513A9D1A9ED205AC816CB6
      9BF1455CDC2D6E84B96B8E7E69D6FD6300D3040B64D7D234A4C93C7FA4D913A5
      C88411E37E8426E5AB63C99AE07F22FD01927B0052A6F08199BFD9FA19AD319C
      E1CEE87A06A2811E5CBDFB2045101EC79F18D27AC3B52CD0473C1FF57B9DF6C1
      4F1FC3ECF6676F4EC95813997D08EC4A7529DAA483256CFDEA2999BF6126716A
      F5CD3C3E4BAFFB4BAD6873F85B2C026E5AB2227466CA112D30017316E02B9EB2
      237071DEDC22F37E5964CE0585EA6A7734F8DBE1FCE8D787E47C8976AB6F6636
      4CC53997B04A9DD55DC9E7A68B52C8D77307EA0F6532F174480F630BC4142CB9
      3883150629A754B1ADD5ECD1C0DBBD383B84BF330AE3A00ABAB3D4E8EA5F9D48
      51D23F0191E06729126E54746D5534E7419F55359778A5A433E93F7168697A9C
      ED0CBD6BB3E69AB365E7C32AF0798D1377C149B542DF3695DCE17A4FE25B2DC1
      FE9008D53BFFB62705EA65C4537B895A9A416C697FD0E2821F97B539AD12DB0F
      EF6A8AE8EF7B7AF799160144F4F085F0C43BE6BE73810B7BE48CED781FF6CE3A
      26597B7071D422C9FD6DCA35FA1C629E48887B8DCB77F3D9D35CBBF46DE191AC
      3B9474A2E34AAA3C65CE079164525B6F4FCECF5F1D9E9C5CD82E087A3A6A742B
      CD10C6C3158D28C9656970A802E24EB304EEC7C06B9DA31509AB48570572DF61
      62EBA2B8B119E54516A1D786E468D4067DAD9F0E13A4B796A4A53324DFA675E0
      A106C643118C77F062EC711D8CB65BE021A692CC746493359261584B65A531DA
      51204BA944962E1D319E8C08F6FCEB64388543041C23A60EB06E559E4E41121E
      65094ADEE28069458541CAE6B295BF15970F950E54737909B055E8A77C2A7533
      2F507498857E70EB566BAF7557BB2BCA5E6ACB615D1CDE0BD406DF981421DDAC
      53A276413C486FB3A641E97569D08DDDCE1127F76DDAD80CCC032C052929BE7B
      06EA60E8FABE544AE46109FB6052F54174150553B3281922D40123933635A0B1
      72219AEE81DE6D61DAD5AA7D7AB494ABB99AB2BBCA7D495996B6BE9024174CFB
      5CBC180D589709C702A3DA94F5D2988EB19FA056808EA91119C06D341645FDA8
      502D7AAB886AA6B0C1F9D8413BA58DABBADBECDD06E0E221E80D993F7C91BCD8
      03C4012D8DEB515AC9FE35A017F7947ECDC1B9300D04B3ED19F706882AC24639
      AE0B543C926A85B6EB7148450129B425C35462A24B1C844DB873A259F5BF3E7D
      47E0988633971574BEB295D4FACFE978427ABD3517C3A42E4BFFF727DE28B2D8
      FB4E70239EC59A4FE721CCE866D1E300F507E5741A52AFA63EE0C1B8A8FE159D
      C53919AD4E816B5D76C05750FEEF485D5CEC9F6FBC3A3F5F5CD81758A293F50E
      5AD67C762BC36068B861F123C0512E739BC172DAEBC8B720BBC7B09792FD090C
      7993156057C5DE532D751790DE66CC129DB00E308F0CBC60F968F05C70475910
      DE941D2D020A069658639E75BDF699E934BBE3408865090F03FDB5834177094C
      65C5E2C2687121F4767FE04A3A3EB8FC5EC43D6AF9683A18C46C0593056C3A82
      516C6B0EC0198CF99917D6D15C4B2D1EE012019D00335FEAD7DD0E95CAD773D3
      9FC3988011F930037290B8C72D4AD0DA2FDD1C89E3FD1CEF7C3C12CF87754519
      5C09C82F07ECC610C54D5C504F46ADD3B48820271A68C8B31AC00F015792C01D
      C0B8B7BD37CE9271164C9FF90DA25C7AFFD0871DF5551C3AEDB93128D0511E58
      E54757D254F653922699E8057FC79AF7CE153240F31267773B04CBBCAEEE75E9
      14E02623DAE752DB586921E5556D165CD95C34BF335552688C3144AF7E515DCB
      3C50167CBB47964BD9C954CC5E472B8BA10DE8BFCE7E72C4243B6E098FFC2BF4
      BE0568B6781D7A9DD3D8D3F1A06584648507A5B05DCD09F190CE3D2D0E184D0B
      0646D338244F61369D34C515EE23B59A383409026C28F5F42D4250A47B5DB90B
      F10DA07F97E0082CF08EF347B408CAFD040BBC6434748055C1E7C18241F35CC2
      C921E39FDBB9D214744A47BCD397669F58A9F31CC96BF3A6C155273F208456CC
      36BDE7B3682F893075D35513C6EB0BA68C2C66F0D393B2DC445754C7BED5DD77
      829C9C953627B4014F2B4AA64D1FD3C3FA700CCF4E91A20DA7D9B995B2A819E9
      941D3AD844B47D03EC5C17D0DCFB9E0C89FDDC9459EB1F99ACF4608F3E1C02DE
      E06264FB8380A507336889F64F5194C7F581D3AC9B91116EBB93639F3BF31923
      BACD3692DFCFE8D4F57228813469025F0F5AF45CAE0ECAE6C2F726DC16C651C9
      660BCCB4D1B41C117156C237392C2DD41515AE08FF155C24362FCD1947ABFB9A
      C1BAAED3B2E39F74B6C6AD4C6ACA3528C90520DF84FB6F902D93FBE3BB6C68B7
      8E42C0B37205A2A6C1BA802D4223AB74A2CD3EC94DF239F1E9727C1D710CCAF0
      F49C6718583561DBC86CC4CE5D491663488AC0F425CC39466FB1B880F73078CE
      60B5D1137B955EEDEEE58E6078DD4A16D37DA2A077D0F917C57E260DF84A02E6
      6AAFAE3215BBC04B88C03B4FB44212A81723F72FEE975229FAF965AE30374948
      FEDAEC58D8717566414AEBC6B69E4DDC4C83BFE63C6C562BF23C71DBA42F1156
      831E5079AA9D072E2C179DD971A6D7E1AAE4C420BD5197A6833D0D2021F24DDA
      7FF1F659D99E939A052BDC07E572F613E72A5EF0E4E3ADBF0FFB97A8962F6481
      058619DE8C84347D259D426FCF8962A00886CEE06CD190FBBE2C3EC993D03BDE
      9D5DC6356037CF92D1E8C29A99E6999437203022ED7943DF9CB9D2B053EB4BEA
      9425DCF03694661F495E0795871B0C8CC880597AED994164A6E6860E4BF5B249
      007478957A62243BB83C5BE55524C3139499AA39AB8405CB2DADF99DBDC9C7F1
      63F4D5E8AE26B9BB2DC501C6DDC66341D0E43BDE510CB9429141921A6610961F
      4D819ADD5DD64D1F5A0F75D614710D01473A6C29A03DF74BB6C149129603A1DB
      44202522B7BF900E6C5604332F2E009266D548DEB6A2BBE5ABC86B8A61637D02
      2D1AB710DC80A1221D6E153599463B2C11FAE1AD64C87DE1782E4EF1F49DB75D
      B96648CBD454A0E32ADCE11A2FCD604D43A4B791CE44E995FB6DC1D2003E5EF5
      4554A75547EACE3B360D6F0F674B0887FD8E1E15A4BDB9425EE692A9A468D3BE
      D14BF6705F79898E0EAE3AAC3BE193D0CF2364369D28CA102A2C4BA7C391BB62
      1717B0619D0758CC7F0372F285355EC1E2530561E43A334E93FC0F993FF765EF
      F6A5ED39619522F8E7740F2B1491D6CCDF8DB22FFF3E33BF9F10E263222DAD70
      C6EA99DD8B76A1D0B817174AD1B2DED25E736537CE4441313717AB0A5754884D
      CD9B872F9F720CF388B6791769719AB17F0B9625C3A793695784EA247CD25606
      2F5A9D2C3E5D2EB37B7EC933BC0D259C23639D4CCC66B56979DCD65577580F74
      6A9530F4F4E5C13486A441C8C7DB372B416E5909576EA64156D62FA4EE184588
      7EAE0C4C9D9932A35FC211140643C4D80D18C48B42104AD261C8B949746FF29C
      9AB360E6EE2C372BB55CE2E2AE3054A54A6C9C6159F5D6DEF5E282A97EABCAC8
      6B1FF9B795561311B89A3BAAC154CBB9CC3CB686D5550979E88C5ECF73CFA225
      A8FDA291FCA0DB94793E00D0460D2E5AAC2857B110850E86556966359E59556E
      06AFD74ACDCF6724E6E081C19FA25D407A32942313FB43256AEEE6CF7EDD9A31
      0CED1862EBA2DC2ACCB1B96D8D58471597EDE3CEA791A49D0C14422E51C38A21
      EC3948D1B89D551DA5ED6B2D782EE46AB6D3AF2E8BB71C8FE5AC18E81EBCEFC3
      78D2F18EC39B694EA7272D81F751F1FDB4D741A529CC820E343D1D83598830AC
      3F0C9B54EF5D61DE87033F135EB71635EAFCAEA32448AFCD3C98EAEBBF7F06A0
      3350E258BC9F19435B65ECCD0E70A69262EDC9FA99E394EEEAD30D831EFFB0FC
      19BB979EE07D7ED1DBFA4C3BF71F73A67F10BD5CDBC41C6DAD3E621DD0C0FFDA
      E741D34E286EF0DD07AC8C18239DB73CF0FDDFB0409E7479606F792FC99762FA
      93117E83BAABB4BDD666C2AD8AA01121F06D7E073C22F4423934B2E6796234B6
      01F438B6DC871ADC091D0A5B0B2F9B4D138E14FA79ED24B3B8203A9304C35E0A
      9BB9B04A07917A353192F0051D6E7458A41326DE71DC2823B4328D2DD5CF523A
      5C3F79E8C9A1EB44E6DAFC2D0FB32B18FA67A11FBF640BBDCFE40C1C74614B5B
      AE174E02B87241B8B8C062030C9CB78F36329436462C2D8061D74E3E8B0BE63C
      7DE9EDC763CE4F663B1F5EE49573D65115DE7FA7D3CC187102794D0EC4B46004
      DC3C57AAB1B2843F4D862957454F811D5B597666B935A6D2AFCFA5C4718567E1
      99C4B5FA34E25ADDBA575CAB5B4F252E51828D7538D38327688A95461C83C968
      383CE6264492AA402DAD8F5B665776F4B5F61861B1BC9F1E4912B53378762E79
      8709BBB23EB9F2A3588AEA6638844DDC789642586FAFD51DA976AE3E9756A9D3
      36B17654B3539E6CA7CCCAF4B19BA5B46D7FAFFD523EE19E2D733028AD62240E
      919B21D3202DC7D9669AAEF5EE72F7A643FF59C57FBADDEE92245EE49BA6D3D7
      847125BFCC76565BA2C91C0A97B8B9D28D4F9D634ECBAD7477732155A4AC1A86
      1A49605D67846B21CE95EAA7A931794899A45A7B59388E78A1B82BA9D10E4E8D
      C92CADBDA5781AD14BC71C61C1E23302952DE6EC2CEE5F947D87D58F8A63AC5A
      D9237C53CDB25A15F1D3CDCFB23B4A4E84A2DCD70CC4AFCA8879CD2A7C61E87B
      E51866867D9E01FC38CD2CA4EC0C15976EABF24D22A7426512A37299F797191B
      EE67CA97E9C69C92733520EE495A73EC27E257CFDEDFBCA9A2C49B6E03E35D40
      01881E72BC86AEF74E3C095115B953FF70A5C48DE02447E0D7BE5A3809135B91
      CE5B930B30D587B1C9F9712A841CC88B4F49D7DC368AE321685DDCD64763A5D5
      8A804A634B548B32EF0AC86BCB99C77BE12AF267A845E6748D2D39515D648947
      2494B2340068EBF294DC90B090128FC6D3B13E9516FBC88FB5AA49FB25F4A30A
      8C8C1E98F6BEC6B2B02475DA17D404881F1D209EBFA5BFA500F1E2C2B9591A2F
      7949F5754919461935BF1EB482AAAB5E8F191B89155E357A04977D086F231B8E
      CA82C4050965EA5A6A42EAB6E61617DE45CC66A9B1C7222A62DB05DD7611F796
      4A2689AA6C4D19E9582B57053F02A5137F9B1A3B9856548FF153FC71AA280E3A
      718689881F9847BF8473905FCC8C681F9EE681B83A0CDFA89DD0DF45E870BB80
      3215A95B05585859E45F9003D76609132F6BE4322760197849967D52CB4945BC
      FC18D18FB6E6ABF20441D4E2A24CA7D5A3367295C57C3E46F9D84BD423F5D0CC
      A739037CC422E76E4159F4DD47487F71E19F93FF81A9C32DC029661EE5EC00A6
      7B0E153B8DD476C84EB1F34A251E02DBD7B35F9D184EE5FB772E667C92A56CAE
      A60294938FB26972E9E5A967599DCD4D3136076CDABCD2E2C2BC977A8A05D658
      AE5FC888621A92D4D64E0962CB7852D091945E3766EC4C6FD1AF886BD6A70C13
      8ED0BCB2A19A0A81EA1D26BD8AB95B6DC8E39E8AC6E47CB4C9393F10FD6D999C
      A4C2B972939196E0B497D4BEC2D441CB87097C81668706145A69A649CDA0E1B2
      8D45865331E55AF0B761120D93F2D3142D2488D142778EA22008931A1EBF0703
      31962D1EE0BD8232B5D542F939C2AE35925BEA381B96E521DF15A998E6D4DA49
      E7404BE83343BF1606860C09E9FA07AF9C23DA4F11902410547635DD17965073
      C0DE3F77E20C726031A4A529860BC382332279C560B16D030DD0FB97C3CF6858
      D093B6B55715EB472BD67908F025F8AF0123E9DD7268799C87FDD62CBB98B727
      82520DB1B15C695752E44431ACF9B11C441D70303B135C4094E602E679CE1C4B
      27DDDD5794AC12BDD6288D6DCF1FB900396DC0E944C2D7D7897719DE2E092730
      0DDF92994BE648CD097927D33F602314E4234FA5F0046928DBE31316DAD380B5
      BA6CC2D4323ACB95CCF53FA9835F52A5EFE5014496B0831F8E4A33DB672662E0
      662B9642A3411E4322B813E350F7F12F4724E9425AFA064CB2E982BE4F45FC8A
      DCEEDBF68254944DC339A678C79B26B956F0E36EB9EE5B3A5585EF385FB2A967
      7EB01BA9A65FB9F68B9B010AC33FFB27F3B9E49B6F7C003A752C943937CA4C14
      92D6EC273ECB572D27534E47748A4C9A027E442588F4FD8BA29CF8E2E6F5CA26
      FDBBB2BDB64AFF59DD5ADFA6FFAC6D6EAED37FD637B697E93F1BEBAF71C9E6FA
      0A2ED95A5BC525DBABEBEBF26D5C42AB6B8B6FB3FCFA352E5A5979BD8CAB5656
      E93AFC776D6B9DAF5BDFDCD8FC7D571B8DFE77874ADEF1BCB7F47F2A68FA71D7
      F3764CC362B327ED23C5EEB48BDFEC2397E31EABB759BB5F73ED96ABD659C3F2
      3FBB86BD6619CFA0098ACAE7806994091441DB2038B971D2BF78D540292F74CE
      4E7E7DBE8FB61C574B5F1F051436EB338C578FDDE718B0341D693E49AC0D14C9
      88BDC0F07C158BA0B17EBFB0DD4AF206F6672E1A7FF88E839094EE5EE1F73A42
      967037B79385257170CFCFE44056A0F6B45AF57000A07D17D3402F2387F35881
      575E6146D0C1EF965AE965655EFB320C27863C0D8920053BD05A485CAC6EA2E0
      0C549A6E44BB22A4052FDB179C15664BD276BE2C4D5DB642191F62A836E6C28F
      67079A5CF1806ED4F13024B2B673813890BBBFC8ED9FE117CBFB8ED1F3EA4079
      3B505F17A9C60FE8D5FBD3BCAC5223AF5CD8FAA67913AD7F7CB47EED9B8FD683
      EAEF182AFC3F78D59AFDA0EB1E041A96D6AF36F3BE53C4DF7D34C3E12D5D1D4F
      BD46B39F28F91A9065DFD8197AF9EF4669D14F769CF4F3C739B8F1B519ECAEC4
      05F7D2EBE48D841FCD78EF994D0866DE881B13E4FE89383050CB7D1C4CA2F119
      4852D1BA2AF27C80D3FABFC63011ECBA2318231F26AFB048BD36F2DD4BDE2B85
      9A96E56B3F34C7E7929CB97AB672ED48A675CC7941E7BF3D6F05594C237936C0
      C68FDD0982F2695F9B3EEB20C9C3EC611CE34F4DB870BF107B2153B297B8E4E2
      A618E9CD6FD271BA744C38F51DDF3209AFB968CCB9456E7643CB6B073331D425
      A9E4192B6394A6284E2AE51251C238E8819BFDF8FA8E2348209FC16794649114
      8860ED3E70D13EE9D09F6BD956776E0072A35F5BBBB8687277EF37E7D8AF7629
      E4681341EC15E5005EECF7C238BF738C35A758A5F0CB9154BB6CE33361BDC875
      C02B64E332B62A1B84296614E0385BDB69F83878D15712CD5598B80C0BCF17DE
      BBBE53833A1B5E4F1CB52CCF2A6E270A1E0A03511A8272DB6A6158CAF314D623
      233F347BEBE17B4BC201E07C4EA7595FC022006EAFCC778AC76A901D154FBFF5
      D35E184E7EA69D39B945C4C3E4F15E217B0924AD06DCBAF2484EC03A2482FE1D
      09B62B2214712F595102D9292BA10467D16F918CB50D731AA992960E9FA1A3A4
      6B8EF921696492F0F5BDDDFDC34353D0EC7B9FCE0EF738C4EB9DEDBF3B2BFF8E
      AB960CE35C083C6A3FBBADC4C4986453A92611CABAB37858E9D876C18CD44C4A
      C7A30B736BA15A02D3C920C696CA44ADAE7CDECD1D964B59C1960A075E258286
      483C3B7DE1A602C474C6A0F313983AF661A658DD606F81C2B410B4BAB6558851
      61D067F325E6799D797AA373EEDF0D0ED4B988B0D114E5A19DDAD6D6D678564E
      25FE399D97C5ADD786B21650535B492590F5A6D51F5B344B199C75F78725C65B
      857E29D1542BC44C726C86C1D78C05D47511B70E92BF92C26536A7DC9DA4E6E8
      7BB89CBCB67FB5B8601A55236367563B0C142914C90D73C99CFA434D526B7A03
      17092D8AE92A3AB6C7AAE581E3DB16A93D11D893FFAB94209B4BDB7FB1E782F9
      93296CF20DFC7849636BEF2A18C88C2A4CC637F7F6F5FBCCA2C60D92FA6A932C
      1C44378B0B2558FAC4362245B399AC828E5DE1930819FB4CE2103DBC2FDD8AAD
      7BD801CC492DEC776229FB8C1F9C15267421CF5E32A69C74DC1BF3A262BF73C1
      24EE293C78F452B76151D2CC96D2D49352C42164E78CF05ADA0BE277D0C7164A
      FA93D075BF91F49BA175E0393C3EB9F014C6DA4F6E4BFA41417765D363AC6098
      65524E452ABF4559C961DB10AD3D6497AA39DA9F31E8BDB600EAD1AF4AE3BDD4
      D8F773C477574CAD9236D22D4436EC210C407CBFD8ADE16F768659C4C70E598A
      5FCC6C1CEC55F30EA114632A37875B766971CD2B5B46EDDC19AC93B903BBF241
      73C87B1C26BBE9BFBCFBB8CA9D9571842671C8E0FB68D088B2B168716598E36E
      833E0B60E0E818456E8682366F52981E5EFD26C3E50F23C3C3D11FA591B064B6
      FE3BCC0DB5648B1568EB38B57F9819AEFAC0657BCE5DFA1133DAB9EFEF22CAFC
      CA40D47D693BA2AD0A8B9B5DF46B775F63C980CE7C59E6E5F394CDA41AB194E3
      8E111E713C33D5833DA03B4CF857715AB15A1FA52324B7C72510553FB4C293D4
      51EA87585F2615CE10C7C7D2B20A1D96CE41F905601F97EB9E9E362315010055
      52C1F23EB9310ECC558B0B77256D2427FDFC1FD5B0DE55C35A1CC2AA594E37DD
      FD01EF2406BCEF4DE2E9304A5CD9DA46CBF1347689429A33EA0B4A96FBC4D494
      04DF1D36F1FEF9617310B9315F282D7328140C923F6BFDF26EB586E3BF7BFFE7
      DDBB774285435A753C91D45769478F05D163407676F9AD7FFB0B7FAD6B69B206
      64C457592D8A148B9DECB7E4AEE56D298D1A63F05BDC6867A13256DB9D465ABC
      31F9EEEEB4890633019F6C4E1CBB7C73FA0A7354E4656CC549797CD9316643E5
      3E85F77C3E147A6ED79CF091509F8FB83413A5477CA03295A2F5A19919DD07EA
      1B9A95066818778C0AB18D64B935D0170F5A79EFC384BCF59839D3F166E3902D
      242C8E93E39D235BE25397CDFABB5707BC7C17DD9CC26EA3DD95F4C3AF5F26F0
      EAEB5744BC3C4E9F7BD45061CF307029BCC74EF8DF33D1CF37621A8CA3831462
      D01B8A8A429DD55519DDB5ECE95C5B8053662C54B78A8FCFD47DE3FDF3A368D0
      A0773EAC2E26F62712203EE6D27F5B0DE337F0F9E523AD6CDC6E13A55567C0CD
      9F5EFEECE5B7E35E1A6B62BB8AACDB17398B3764293D55F8085764645F4D68F5
      4A9444315E245F0124ED342BC92F6D690B3B5C93491C854AA0298007F4F41249
      87DDABB17FABD12D64A1D36C9822F855858AC073D15F62D170D5F4C243FA291B
      5A3DBF7FC9F43159D76B4B785F0A6910F419B8EFE6716404FE1EF77C25696148
      D79CD29BF0C6E76A03F9C07CD3A08E730F5954940DEAE4F0098883DCD0F21572
      6184299934C94AA9286470656322628600949CA54951C65083B0632A936482CC
      4C0827F3ACECB98E88D6326361A689AB91E86392C3BE0EC39D1B38BF64E3EE9B
      79E38BFDC2B90FE29030A7433FC96D5730EAFE345113DC992B43F3388B92E9B4
      31E1EDDDEC8FF08C9B4198013B44C9B202694C417415055332F5CD5263E2B5EA
      F7E562F7EB5684D1E2C2DD5B7465A2CA554E77EC971BC097BBB69DF2579D4B45
      8657744C81F8F0B908E3CE33AC64F95E82621972DD3F373455EF61466205C618
      0891699FB26B478BC468F974B43BCAE5562DC568B7B014F10629E832DC4568AA
      37C33CC28A425D1DD7B17149DCB2A4DFDC165A2E0A91C45F3E17E048F36A2867
      54CC273FCE6835DE0A9E28DEC03CDF9BD7A2CB194189A52B0E035EDC56C4A9BE
      2371D2AB3620FA0FA3D32834C0E58913FC0E6AE87B9A93A64265A6ACB4551556
      CB6A4E13482825675A374B88B3085C9137156C1274F808880FE32AE8F9ABDBFF
      3F580757F032F189F404B9155C95C9C30747C2ECFA9DB7D2ACFF87342C977396
      38785465F545AEFAABD90D95DD604D4A8B07C211B1D98D706D4EC232156644BB
      B820A6A23D1FEE2D73D16E174B7FEBDA0802525501EA92709FB0C5A79786D5BA
      F2565ACD629263A9B12442BF3F72E61EF7E7D7BB73077CDC1C308F68C71B9065
      CDE6B896E0B099604B701AECDAF2917B730504E2A048CCCC2C6403BACFA67F86
      25ABB106C4977D019D922E52BA5A598E380185BAA421C89F87E5AE556FB09517
      F8CB4FF6813F7344DE7C059D638B0BECE124A9361C98CFACBF43F71D2A40C0CA
      326D1C328735092DAD12783963C7D2AA1892AD9BBB6F6D348062BAF77DE937B3
      F73750F30802CFF65C3018ABF0366A168F7B275241B39E9525DCCBB20894DE53
      5BD9F46C45F22EBF253F698CE2AFFA6EF37BE2703D1B897BA24DFE12EF8E1ABC
      D950DC7DBAE6F7D0344C82C34A1F74C1363ED72896CAB1FDB57B6BEF5D1A5F63
      C0E52A284BC5AC95A276F2B90519354555B4843856CB45A5D01E92B8D704225C
      5A75619DEAD6C585540B5EF26E7153700C8B1DEEFC329AE4E679EFB919A57C22
      875C2A363E9E29C50BE4D04681FD5293C27F488E90E6FA304A2EBD57DEBB9375
      34BFE0B74601942DFEAE5C4C81168EEB77EBE7FBC6678D927E3C0DCA13F64023
      54A69E2BE745CAF63A8ABA4FD6A5904DEFECD2286AF91A975D3289A2FE014CE6
      9D99B2CCB2825BEBDCA23BD140DE750885D979FE32407FEBD42F462D064F5217
      003E887E687AA36069D842749854E6294107C68EEF185B737C15F0BFA552C42F
      83BA978AD329D1B79E13BC0BD2463206DFC4432B968DAD6FA8B0BD0BAEBA4D32
      F10C621E50832E050E3D831750186B0DEF57360130219DAD6F789E53016F441B
      E4F2598017CA9361164F1661E8B184C1FF771D9696E3AABA72EF6E3B5A446776
      57801FCEEC2FE62C94FDF5965C3DD4BCD25F0EA12EB2E6007B70918B4964B959
      1B71A3CB2CDA20BA69780B2B475B8CEA664F6BF850483D57648EDB37F603DBEF
      7A47E2B67CDE7426922E1DBA45610789147AF67D6542031DA8363F68013A6857
      AFDD72B96982E70C13AE623AB838E2441BA7640C608EF3397A7BA7FD11CEE452
      51738D41D4A7730ECF8AF271A9BE9C5646CDDF2126A740F1240F9DE04AA664DE
      C03B96078A3BB90C135E3514BDB86008F0D001A171F0D95C962AD439B008F4AE
      2452B45330E87C897CA00D64F6653573D6BB056FAA86C697CB1EAD2CCC7115F7
      7C8BC17CE5821C7E515EF67C1449B54812D30C94ACAD3942D151301C232ECFBD
      8F473B7BDEE9E24286B042C109ED818CBC755E64D37ED14274A6B5C378A2F491
      F923A7D6A5FA701C62ADBA7E0513E33EE83E1DD00BE0E5B35E5464E83693952F
      9088A15465B20244CEBBEC403B288C9D5731AD00BF84112D79E7FD2C9AE88E39
      2D07E7C6573F1C78ED1E591540BEE14C287806327FF8227901A0179B789B6D1B
      384806A9CD8C9088030D166186C53CE18E881153BD7CFDD3F796FEF7723C7E49
      B2F89087D91BEF86DE38086FDE78B7CF721E3F1488F70945709C260FAB997BEA
      B1B623D9E8CB4DD6F601E2FAC07E0F5C8D343BD863C4D7D81FCA89E2735935A9
      53EECC692C843213917817FBE71BAFCEC9D55587F5D5BB93AD4D6F7FEFE0C2A8
      25A7130A077B09BFD431CD69966269924569A69D4FFDC989F68595DE9BAD8E91
      EA2AD31729F606DF1C875BC2AE614646B60952F5C2192BC0D72F77BDB768C02E
      AA4EB51403D9B520712ED0B8886121FCE472D069A89F33C7593910C9CA319F59
      CBB6B7990C99B9CA96DFEF943E3CD9FB43C45A8B2CF4E9C430EF80F8D5354836
      8C10696A4A31F258ACDB6EC4302B040EDC73497DF93461A6142F77560AF22DE6
      B711173C4939E80F7051BC5DA53E8CB305B4591A55F3C004B914B2F5B5EB937C
      C1572C73B47BD0926A744C29ADD4045A4A5356A2C79254BE4790D15D6327BA2F
      0E123D71248476DA3314509755A6621A3A000E6D6869C9DEA37073C98DA995BB
      BA020851B621FDFA6A6D36FD039C69B1EBD1D20BB8AC3626E3EC04DE014D1930
      B324E45B8646DB80CFEA783BBBDF9F49BEB9E31DEE1CD365A7EFCFF4E2E39D8F
      47F83ADFF12AF2AD279132FA6B7BC9897532CB1EBC90A546B7B8F68B88AC6380
      C9E63871D5F982246937ADDB797322E60AC6802F21685EBACC9A0633B6886DED
      174E3A6E8E97F61A669944F36CCAFEE777DE4DC7BB75E9052ABD79850562CC43
      3F43950D33D4957B575E1D7DF6911490567021C45C9008B86C73942218A89525
      5E621C16970A85EA5D358631E070A4843885722C09D94A8285E0243CAC743983
      372BE2B90BDBB4FA9A055E75972D3A1B0D195F17E79AEEE0B5B9E088369A024C
      7219437C6B4CB52A732A495E90E93AA5F1738F302BA5F0B3301B8EE030523770
      E44BDC0B4FC92BC58ABEBAFA5FDAF4D2335DAE08EEBF8CF4761DE909453C8596
      1D093532790D0DEBF004D35B64A10D24E17B73D321023980101366A8CC84483D
      18C72FDC19B062F9DAFE342BB66771A8C721D9EF0DC2C2439C694346AA6139AB
      356815968B5DBA19CCB6698E25FB48D10E5F540B49188A6A14A651F4DED00675
      C42D209D6DAB14C4DF0D3AEE59C3110EFB01DFD725A343CC2313103183715936
      6C2BC50E8871126E7B108D2F4E21E74B59D3888E619522B90257A3F6A64335EA
      2B1EAC7D67F6624BDD57CA2388A40E6D6C687EB2C505FBA1D17B920070BE2FA7
      219F05B684D6E019C1AF1641E0FB8E8CA0EEB9C6F25A33EDCC81A0FCAE9DB2EF
      C51C94E5F8F942D38BC163C6177046E213B0FC6482B4A667E5CC7E68A2760F39
      0C4C0AA5E43F46AC7E0EAB30996D28EB348D3D3987FCA7C80C6A18A9D13F95A2
      B67932B49AA1CD1621324D64C7C5510E1829379BB5B8706BA89849D6B46FB9DE
      1B81B9BB72170B473D7A97EB152A4EBAB612010D741BC550576E9BC85869308F
      55A586FCC0413846AD870265F9B918AA9935DF0466AA7C0B986B8A184E77960A
      B332F850DE5101F92B7524A6FBABE4F5E4EA38BA03BA047D5CD3F5DA6F05BF02
      97F8153864A749B41CA3586EA2D115F9A20A05764D6F319DD86648E1B190EA98
      6871A19226A4698BFAA15A76C390EB586CD9903F773BE113B1F9CBE3C53D9DF8
      ED308EB184C861F3E274D066BFBB2ABD52FF63D4EE4C5B6DE7BEC605F77C5281
      9A0244AEF731B726BF040D28C50B0800132EEA5F7A42418BE6D40899EF3CA06F
      A251CB0F03FEC1D1DC32721C4983C7BC8AB2A6CD7C4E00915BE38C0CDD18CE03
      85693A41470C461B26067ACEDC62E2839321ECFBB0EBA282290F10D0CBED85DC
      3330421D9E2A56D13EB3D80B9556568335AF691F32F7C45B2E7D494EC6371BE8
      D797C0E1C9DE7B9A3635339BBD611FF9D1CF18F45F2433AFF44845871A3A6EA8
      4F2E513C14E669F2A766E1FDAA7CCF479CB14DE5F09FA491BA40A82D192341C0
      D5276436A5596331978F3C92BEADBC344E6C9857552EE2BF03463BC8B2E90436
      C68C94B586AC6DCD39040E8FFDE38A6164EB49A1FDA364CA2B3E00E78AE470DD
      9634E7C14CB9519A2E5F785B5B7F8619F6D23EEAB74C7B61750D2045AFBF9630
      E755325AD45F5D26B8ED9C1575773D99374E699E2360CCBD85799A07BEE4AAB9
      0555B07A073E27B125074D47987E1FCF936118F350CF2A7252C43A8F86090379
      F81642CED6BDA1B04032F6E4A714CC7B8BFE585CD3CBD24B31641335D9BBDE7F
      A75339022F39AADD83D7C239F2EB128DB251345F8871A519E3613000C01157ED
      79AF4A5217FD0B76CCD987046B44D86676E288AB71BCFFFA707ED1A4B25CA3F1
      DDDDB2CF99860F48B3848AE182486C8E69CFCDB5F09E37D23E3CBFF0FEE254A6
      8BF8AF727CB47B4E1F01BD483BAFDCCF0EF1D961AA0963FE64E99E145B4EDE27
      99AA06CA862D4AFB8EC2B8080FAECCB2B92B462A2AAB6B4699BCEF6381C0DF74
      4935F45E0FF7E8762613D29F52C9CA6DCC06A9DC29096FB6A3DB1616C58B0B96
      7578A644BA24A897DC9A81204F85D22EEDA5371A3A77A98BF9B88EA331FD88A4
      5E54969CEB5DCC77791F27F753CE7BBC23E89C533561705A01D15A495156E2F2
      363A224FEB9870B74921EB4BDCC1EAEADC0372EFE7649A9B7B54CBFC618FF857
      96F2CB6B9F9B133C88F23EAD2E9011EB57CA6680A5CABB8B263170FAFD38CDB5
      01ED777E67F76D054C3EE5BC08B0396CEA439FEBBEBB4A9CDED34438B9B796E1
      343AA6EC49C0CFF4DBDC17680A019078C774BFC8E929617FEA64DFF9C6722324
      C0E5CB164300F1B04A9A22C7E091F3982A46BFA95B60174BEDA659BA01DCA651
      A40F70B058FA6C5DD65073FEEE28A424927E48FE46883CBF807A1E0C8EA21C7B
      A2ED87289D7CE31D5CF7F0C39F6937CA25F80DBAEB0DF20B74257D729E66857C
      98BFF1DEA6690CF3FE2FDE059898FFFC2CE503307C14483F5123857C9C9EBEDA
      C4364FDE658EE61FA659C26CD4658CDEC0B5915163D92D988D430B4BBE3E86EC
      9CD9CBE7CC9A9D978B739EAEFC8133F2D40DABF49292D33588E3468C687ED297
      E4F4148FA08B84929139C35E4ADC9333DAC226E9F585A1C473565F85EFD26AC8
      AF5C34534ECCDB90CE73C1C96DFB8AB6C673A33F3FD3E67830C6F3EF2294FD24
      78844868EC5FA39E77063C16A6022C16CDEB218F672A728557C1EB4D7B3DE0B5
      731BDB887B084287D47E341D86C8954D42092F71D9012E7F258605D70872C727
      6910B4C6B928A2EECBC4D1254C8D287F00BD6379341537AF5736E9DF95EDB555
      FACFEAD6FA36FD676D73739DFEB3BEB1BD4CFFD9587F8D4B36D75770C9D6DA2A
      2ED95E5D5F976FE3123AFFB6F836CBAF5FE3A29595D7CBB86A6595AEC37FD7B6
      D6F9BAF5CD8DCDDFF73CE475F03BAFD12BDFA0ED784EEB20AFCE5DC39AFB67BD
      A287AD6DAF7EF58ADC34FB9BBBEDCBFB2CFDD95E50D80A2C8FBF2C55AC34EB7A
      F5AD7539682D9677B0DF19445C29E4DCA3DC54731F182681F9C5F9B1B1804AAD
      44E725F368EC23BAB93B0AFB978769FFF2198ECA2F6B671AFDEFAD9FEF4AE243
      123F8F2CC86C9851CCE491727253494FFA783DA85209A17145C74CB5B0AD4A29
      8B4A94304E5DF59CDBDAF334BEE23B23128F428DEB883BBFA42BDB70B9989219
      102795D02D13A77EEC190A743FA5591C9C4FFC7ED8F15EA0F0E2A7D39F5F74C4
      FAFEDFD2F83B5F0E2B9D8D5F97C4EC96FA1DCD0AA8799F3B46B2907D0CA74073
      E9DEC6846B8C2BC7B8B4361FD5539FEC1F9F6BE9A9C186E6A68F48A73D9BAAA4
      F13FC7C08F7D34843ED3D049334A830737AAD20AB91414A5D81FE6004D07FC3A
      73454AF48C8B8F2BA573685A5058FF2690F4ABE27E3B1D368035BF065893858A
      33D39B0EDD62112E4E32FC15805F8B98480639697075E2B466249A795F331150
      5343C83925730F94412A569B2DC7FCFB677C84903BCFD1E7494C47BC4E94372B
      A599FDB9F6541AE233D94B237AC0DAE7A0C73F2C7F4689183DC1FBFCA2B7F5B9
      F07BFF98B38606D1CBB54D4CF4D6EA2316130DFCAF7D1E346D0A72E4E8BB0F58
      5E3156C1BC3586EFFF8655F6A46BEC5F36B6D6BD9788BBF72FB9B819C02B6998
      272F16170AD17A826A1017DF95E5A3755B0934CA4D1AE559C91ACCD515C98BC2
      945197F84A5C3202AC9AA1D6FB01B06662ABD6EA34E62D1AF39E5FF87347FC47
      19E7E2028DF4358D549AC065F116D2ED33C9C0F5CC4159F2CAFB29C79101E20F
      64A649095D445AEEC3C5BB97DB1E6252DECBFEE4CDB418D0AF06A1AA6E32F997
      8DED3592080462D36B5A16E467975230240D479A81E3C5603B1338EF57B73163
      1D6C4397313FB5B88E08C64B30913BBEC8DE8F9950AD5FA0BEAA9DF361BAE4D4
      0BA35A38F78AEBD4868702297AB3B5572BB594CBC69DFD9185822DA69D21E334
      01348B69E1885151ADFD2052AADDA7AD82AC7B1E15D30A1E7F6D044162C02170
      19DEF652D805658D4294B0F2E3A9C660722B251C80351C2714BFDDDBBD340688
      5A52CEFD608A5D0EDE34AD8FAFE110B7B1D3CDA431BA9FA00F447DE41E39FD95
      92085EE4AE9EAFF9B4BE76C78CD7A6D18DD22CFA0561B658794E0066DC476C2E
      3789935E5A14E9789CE65267735BBF91BF5EA691C30445FD2E69A9B1161A786E
      6E3908E5A0E30C92B28191738E60222D861E901D6A38729C682D941E82D85811
      B65B15D06729E7ADDBD01617DAD69BE57AA45CDA6D5EDA9CB4C95E23C227DD6F
      E60CEA47597F3A46B75C9F7B7C0CC2A716A36B39B74694EB2698FBC4225510AF
      58632F2EE0C779828A4343687815650578045B651CB35516D49AB07BDB168CAB
      F0601CE16B01F90DB5F3F8695109820BB80A110183E687F00EE9515374113887
      BE720D5EFB0227D2153F21576E285A4EDD5EEEBFEAF6FC550F002AD15558BFB5
      345F1AE4EB6C97FE10A29AB12A9840BD25B09F0A2603398F3E0E95FEA583904B
      6AD548CBD7AE7F594EB8F31F444859488786E15362EE496E9E20AB394567333A
      2B66C13E6A33E47BF78906B3B571BCDC2C2060823EA2EBB85F1A05A686EA1695
      9A6C5708C16D215DD061FF52BBC605AD571A80E8D8924FFE38124B184193C9E4
      9D0AE6B2B9FF95D3D87F3B510463470FABB2369DAE166AC9B7FC2F8E61E3F5C2
      98DBEFB991B276FAF95F369797390E37D1A3CBF712F245D435F52713EF4A01A1
      25E65DB7F1DD7776DBBA734DAAA70E94831CC08B0B867808BDFD7AD93429A258
      8B204DBD3383EA71489E7EFDA3C8E7A77727EB3F7BEF8E778EB021DE1F9EBC85
      12B9CED2FA0DF17EBBF64B0619F328DF454513641DD875BC348CD1C6BD95BA2E
      E62C2D86F193D55537E995B2A30D51911E17FD4BD7D4EE6C014A9B53144E09FF
      52C76B1DA7700A77E2B8553645DA2CAE691073C09C396C58CB83E99EF5B6C3EB
      C31119A3C230F2A36D5813E29F32A6B754C55D0009621B5043B0F298C66209C5
      163D1A46EDE227F7898913FA683AB60B8406CC0D75B533F7EF3552764DF07644
      12E84F0BAD6710F018E9AA369CD4D281A3F4750657EC569B82921745DD64728F
      44CE681BA4636FE763F578BD767A966A37D27B16F8C5C96EE9C85455215DF829
      4AB6EA38523A1FE68C555634ADF4D63B322859F96B24F03A0A8A11C36894E0B8
      559A689BFE22933E0B7D850894EF313A00EE53479D70CFBAF8FEE0E2683FF7DA
      6A389C92C31BDDD05F19FA1F48239EB47C78FB920A5B62DBECECC3A917FBBD30
      B6F1262DE74F498CE3DA89E73EE1ECA6E3C585098EBD73D3266AB78E22D43A38
      92069C7157D6DA27BBD6EA268EFB57CB5B901AD19FBE07E005FD9D86709B7BBB
      4AC04C2B83AD75CE33BDA2AD924E95D85DEC8FFE342F48DD92ACC6F58BA2DD2F
      1403DF13E5F954D0FEBC9BBDE9782243CFA609074BE0C64B5F2AF72FABEAB1A4
      1512BEFDE30805D974EEC896E0609FF32F032C91134DCE40E328340B1C7E74E4
      9215AF74DA9CA914CCE73F8E4CAAB977AD2965A859C4D9BD894F2BA72C418A06
      020618C725C69960C6A47150BFA5729F511A47D25980E19DFC00C09F225D5CB0
      104377D89779D9582DAC42EC852393F160B4739F3BE8B9C1F6EBD76BA3E6E839
      FA01EAB622EE7554AE7B278301ED7C54ADD1619AEFD2551CE5205343E0FD321F
      ED821C45664FDE306FB3F2E564F02DEFA9BA89E41E814C13018E101218C8E2CA
      8F593D0ABE151FBA5162AF1BE178E65D24EA3417D887E1345326BD95D591DC4C
      CFF0BAC9E9DEA5E3947D8552BFD4FE0B7E56E0AE44598EC98CA52523F08F9647
      2A082D852D7D28E0907F203345C85A3ADCC6CD3F2006B48B3E7DC8EBA89A3E96
      26309C4A4E3ABD7D1AB34724FBCE65BC979EAFDB742A701A0E0AB2494BF3CE5C
      EBAE7537FFF4A73FD52E6571BF543F093AC97178CD2EF61CF78083B6CEB12EE7
      9AF33DC4D834E5865B70E55D382838CDE6B2C21A7093D65E0AFB81EF2B4CA092
      2250D0E196CC0F1073CA1CDC9CC7F2410ABEF62C1D66FE582AFCFF3813737EBE
      6FCD2D5BDA2053A04A6F3EEFE84A2534CCCB169232D7AEAFD74D44F7EA838F06
      03B1C48A3611A23FCA18259AE3F58D964B07DE9E7F8D2A902CE886F9986C2629
      7ECCBD75C9EC5BD038843EC46DFDDB146D117C8FBAC9E5FEED314A630B33AFF5
      745C5078196AF30349850BE62DF81E7642BFC862537E379BB4C6C951566155D0
      546B23AF7BBD59833325C47134C668120BA3A405DD342057E2E5710956FE0C5D
      938C59C50476A80EC01B3E4BD7A4D44F915F06F756970ADB1335F55EEF591825
      330A57D69A82D399AD11559C55DA24D12FE881B798AAF511C33D4E3CA905EF3B
      F1E53D348649F2F07B01759F7302B3084CD49423EA15B477CDC63088262B2965
      BFC1FD650AEA99D8BE5F1D7FB048A0E3140E2EA9E09041971419671E1EA2AE32
      17C472263AC26C99423B72CDBDC815ACC3BA49CF911D5C5BF79887427EA9856A
      96D5CED655CD61BC70488ECAAF31F4310AD9742D3AB6B7159DB9B595B1A18471
      F67BDD047BFFB254E835AC301767B13357BD693D9A05EF2805EB3BE8B75AF0C4
      18987F1C415903A152405CAE12B132AB80970C1630E076AB3F8E20DC447AC7EE
      203722A00B40193FA429958B9B0A4B2C844E759552DD24F32F9B2B2BA8271148
      5A6EB5C75E60939A3C8E89A4434A68522156AAE12857B5B5D49C3CDC7B5320FF
      B97F0E26D509A3FC48AB0AE63DE58AC52CE29A92BA8DF7FEF5DECFFC7C24DDA5
      7EBFAF29079FBBCF22AD23E0401097D5CBD2EF48109BCD28BA3294B2E0898FA0
      ADC0E1F54276BD14F116C1219F290F2C0B8276241B071E6AC53EC737AD2F0E9D
      96F865DAF7ECCB4BFF71E6A0F5D35E184E7EB62581ED13AD09FC1FC4B9A4DF7F
      A9F5AB2D44281D8CD3F45272972670C9D95A43DBD60B55F06A911680E6509E61
      87C48CC1B1601CD71327617305FD66A75ACCA19E7F1A8413ACBD22F3933C7607
      F6B5016D969F06D0667D7B361967016DD6B7EF07B4B90C338492D6361F29798D
      BC2642DB284182B5EE6A77F53FEAB63E9E1F5165E39B4754595CF8A0D6B0E965
      00126F1A20C4CCB52137E7FBE670ECD66D01C8D02C8BE2C5DE4EC9A15BD3B1F4
      533A85A5C9C9B20133D0D7C95AC77B77FC51FC4567D2EA364E6510237DD35DAE
      DBBBDF6CAE7B2E2C586D5E5CD80EC9E86073EFCACF22610C641F09A352C6B7BA
      8DABC4FBAFE90060171A409C2778F7270BDECB9B224760DF9D473358F5D25F3D
      7B57D6D7FFF9C397BFFCD0D3378AAFEE8115E4DB7C3B87F04E1038FCB75C09C3
      FD2F7D0333FD1467EFD79BFD7748A6EC9F9F5AB75A099DC3FE28618EEA5B8384
      CA6518E488D7CEB6688CCB5F97A3344ABE47A324824907C7EF4E84D0BB6E934D
      93419BB024D2864BAE2D17592861656F7797416EEA3634BC36B22F6986808326
      096AA56C9AA3E651470DCAEAB0588D6A96ACB0987A5C88B877B8DBF14EB8D512
      1152E793FDF3A3BA2DEF464D3F404D5FEC9F6FBC625D6D8201A7FB673FD46DAA
      E9B4597B452EF0CFDEF1CEC7235565751BC47E928373C13780F0D23C8F6658C4
      7A73EBCFD4368E2128CEA4523204B6AF7DCEC28543A9DD4224230D022521AEDD
      D81617F6948E22B84DFC71D427FB5D3A020651180786385DFB760D0390EF8DC3
      0C6DFD13BFE88FBADE2784B151E058BC44333B5C733F969ECECACDA281F74B98
      A5DC20CA891A20C3E6C00E4CC5E28E25C0CFCC4280C7B625729A14D0C74AEAA5
      0BA221E46BE25C9ACB914A400946847A4B5CCA9D712999EB86FE1D85D5FDC505
      792B7A9F823C988116E5E9F560EA4A93B076D6FDDBF31D7AB477B5DCDDA8DBAB
      2364F0F5C9E75EE6F497E7A9E09B58F23E5E7A135FFAB40C0A9A14F75F865E2F
      4A00571205B407E0846AE99FE98AE57E2CAEFC43EA51BEDC1540EA919F8F42ED
      0FF4E3FE34E633528A6E8FF63624AB7AF12E05FC7D1CF532976BAEC939FD869C
      D34A93737AB4BDB9F9CDDB9B8B0B3F9D9FEF8BC1B9CBA7207A1BE269CFCBA713
      24CEBD361C0F7550963A300B00EDECF8A930148C03432BE66BB74EFE6BB7DFEF
      3F0B95127456DDF604F9171BAF68C67FF65AEFC304C506DCF87AD2FB6BD82FF2
      96A7291F43375FB3C159AF4387B153C4407B9AD4D23A5768B393751D4C3D5121
      CE2F6FB368EC7D3CE364E83B60414C8B75FCAE0AE60D19BD89F65FC3F9FD7886
      23A71BDE30DD1B0DBFFC43077FD10A27A9307949B6EFC65586BFBF1CA4EBF493
      B5406A37DF8B0BC2494F87F61B3814DB2F03F2BCC8451885377E10F6A331D949
      0AB9A2C43E1163945F458134EBB5DE2210AA5C25105A9A81874FA9F45AE2AC74
      A482596F6418CDCB963FE62BA89FECB89CBB02CC6FF31D5112A03E348103358E
      627A757283F28E46DBB841809CA4646A1485D42EC3562DEF972671ED1A9E5B67
      612E2C26D37E31CDC2D6DD116BB1BBFC9D6BB3277E121A3ABCB1D08D3B4EAE9F
      DCD6AF01A5B59B8E2770184C566FBE20CE16174C4F63E0BDBDE52AF56B29F6BF
      A28332B665FC3639A8C52CECAD00A1B56E8241232399716DA8DDFF21A360E9C8
      9F1C81E625CBBBC54DC15BA6FCF0BFA6615E5C0088963FA4D500B80C949E7281
      36737E08D80807CA4C0DA0E0F760C7011E2B9E72E12ABC0BB9AA6E328BC6D0B8
      3654E3713A2AAAA58171A51844BDE9504A6578C2A104C75A115CBB21254E8D06
      2B7C1BA4DD393DE0F043494CF6D73C4D3A5E120DE8281823F619F931FD18A781
      44239AA8C16F8F1A34318347C70CB6BEF998C14FEC3FAA617F0EEE1C3A1CF7B5
      1452ADFAFA59093AAAF3FD1ABB5BEA328A93E5AD979351AF617CE18C150C7CE0
      04587EF1BA8DEE8F7DEC36A7E66F3E3557BA6BCDB9F9E87373BB39379B33E79F
      1F86D0B69AA407721AA6698D8B084C87B6441D2DCD6B3F1D8FA1BD632E4934A1
      C7BA8DBD75AE24CE0F8E10D56D84BFEEB53707D66F39B01A47EFF107D6EB6FFE
      C05A5CF8635BE25C6C699385AEEE1FC6E935132486A836A9DDB86C1EF41D57F8
      59AE02992E81180F7D8EC4D2E06B3ACAC5059D3FFCAB73E85FA551907B43496D
      33CC411692878551625E83E9848E3624BD35FF05AE3E49A6E51DF6C848ADA985
      A6757C409E47E0107578822EC5A0E4C20D5C627322F0DD1C254F70943475468F
      3E4AD6E6AF806FE9282955D20E63619CBEDDDFA92920DB1F2803F4F168670F31
      28D68DE17852DC7A7417FFB67603B951FD8FB19893EDEDF94E6DE977CD789CB5
      A6D8AA808408811EE4037E46A069E8F941DEF72721CEB9BA0D95948239BC5120
      74B226BF3567E9139CA5CBCD59FAE8B3747EE3E0B77496E613204BD53A61209D
      47CA881D87FE654D47902B1B31696574547301F4DEC1CE613D47338853BF30D5
      3B19507B6BE8D4FBC195CF255C4769C00DEEB937087DD4BFD56D2441E60FFF6F
      407E269F8C2D0586E106975968D956257A11D1C45D450150EC192AB36E030791
      97B6F830042847E04B16B0BA0DA7CC8ED6BA5B7471A11C8887D3524BB191BD42
      B184E646E48237AD22CC8BEEC4C7D2D4A8898D3CA1DC9BE110515CB8FE3F5C61
      4886DFFF9029B8243041A8F6AE9B7C948A3ECFD37EC43D99A6091362F9FA5D80
      FFDA456D3C4DC0D76F04EC3CD770D7FF170D7790AE3DCB68F9307A96012757CF
      3360523D6192D7516573971ED941DE4936F493E89730F3DA2B1D0E65AF2E2184
      3D10D2E382FC4EA5A595CEF27959ED67E02579394EF525DFFC9BFE80B3E3DF9F
      A3B7B95E333F1002E667683E67E62320B2833E308EFAC5736C59353968CD28BC
      76DDE62F791EE4809337CF30591CAD511DC34D5742719C4E8BC9B450EE1FF66B
      602D6AACD064F8C030389EF6110FC582970665D2D8FE185C4B5FBB17B94502EC
      763F7F26956B35EEE7CF641CE79F3F9B76DBC0DB8B801E5ED0485A73546AA3CA
      66B642993A12FF8FBCDA511468D4A50869A259AA7EBF480D1E4BFD8688E10945
      2342FA31ED05A4A699E1E8E26C7F5F0BCF68C9D82CB5A5760E9321CE69033B63
      80FA6B2783D9647E07A3BC538FF6F2DF150F8D7EB01DEC354C7BE8703F85FE24
      4D5EED64E3347BB5331E4F132D079D208D958FC2B0A8DD6AB685196F4FF62E5E
      D13FABEC3394743E9C76B418E7023DA054BBD76C7406DE74C28ADCD81020A348
      E3692D41094416072693B777F2F63FBD110924AEA159A283399B43C713846025
      2979D6DC8ED8268BF7CF67F196BB6B4D75E5E3D378ABDF7C1A6F7121CAF369E8
      6DBE7EC3E1D43199B37D017453E36606648EDBAC0708FC2BD31C2AD03C7F8CAB
      70B9C5940324AE01ABAEDDE92142595927A9688D5E4416D10DB78F2BC18E70E7
      A8F63901A4319D15E3BA8E7473F58DC3A69CA585B835F4B8182762362E099ADA
      8E0784CC08AF9312A0008EC652FD2CBF515A5C86B7B98BD951026F287A47FBEB
      3BC3FBD87BCFE00EBF64AB27CAC61D54A64EFCE788B67EF71C311B9E7320593E
      4740FDE5F38D384993F0597208CF30E4282155552CD54D452D2E80FBDC3B1F45
      8342E15CF3C297DA0F31D410B8BA8C264C589832C19E6A2EBA8E3CD436BC1972
      D033D26DC5B4AF1014F255B25CE97D981B090D56025A1BE6970532FFE406FE11
      A4C51E3CA472F2C317F53CA30E27C292CE029DA82D0410DE40787AF5A8148862
      00DFD6945E29BC011C4E78EFD08C901830D8BFF2A3D81442D414D14E5E9B593F
      A39CDEF296534F4332E2B4E688E6599C49EE2DA2D34F63BCB9D746CF055388B3
      E15FBB2D01B6F3EF7681011D619C497CEB1DA36602AFCE94DD7134E9A53E883E
      F7F33EFD9A6AEF89909BCBEEA8DBA0DD6E3185DB365B16914BF568822999BD03
      3FCE0DA907808205965BFBCA24A68FDEA5BC7ED6AD026049594CC8D84202F2D7
      A1C53C4EBD17C2C53EFF3214D0BCA8DB88DD42A14AC59303C994BF41E853882D
      18A8D01416B579A77C5AEA789FD28CBCDE0950C5DE66E9758EE4F54E5C7CF76E
      AD76BBDFCEEA04414F7261C1D79BA697633FBBD4F34D0BF91617DE782C81956E
      77C364C37C7B71C78304CC67C3D4EBF9FDCBBA49C3E96518607806E8FBD3D9E1
      1E202D5393E649D2EB8EF7224D5E389ABF6E83BDDBA3D8EE85345E0D7F770068
      6E1D788E08E4B55BDE36E06F4AFB7CA433002149A77D42C71C9DDF42819CC760
      33907E4BDAE293380462A99E0DB7E934B3E86DD140590F6A2B8CB3BB2DD33AD0
      F6A78BEFCF3A9C09E830414A475222137F729B4D73DE101DEF7D58EC83D99B61
      EF2DD72849CD36051DFB5747DCBAEBB58B919F5CF281FAD734B90EB6EABB86A4
      3F90E5D13602D145B184F1211D2ACCAA871F0FDF7BED619CF6FC983FA23F1C77
      BD8B51C894762FC089EE85243641C7DDFD01B9D302141D5A2CADCDBDB857C15F
      92B88BD4A63250207DCD69ECAD8D3021CA7523CA1FCFDEEFD1887B262D937A67
      FBEF68F931059C98DBF5E4E7416100B2E65CCF964975FCE9E1DEAA33589ABFD3
      9DDD1F48FD70781105C6F51B256A03DE9E5EEC19F501AB40ABFD7B69708BFA99
      420A0480C043571E7B491D172D0FF42CA44BB9A06377FFF090F726DB054369E5
      F025F7C199C6412D11F845D1ADBF52A22F2D6DE131BAF6D0C9BBF30BE7ECF0DA
      EC11BD388FB8B049ADC5176A2BB1D534182C35E9D6A748B73608048F4FB7AE7D
      F3E9D6309F28CB90D2DDA2389AD44C2F1CA41969947C5CBFD8826610D736DF80
      F5342FC819F4E814CC06B102DE93A138CCC23CE796B0BE2411114C8953B85F13
      135EABDBB84DEA7C656DEB8D279E85A017D8939FCE43D0C116A0B48143927B07
      1747E834E5402B9DA0154C9C240420679F3E4E6A589423CD9B280BE433621B5D
      7319DB3B34B17F9BA2B0AA97D1D2088BBB52D114FB3062875C626CF8A6012965
      54F79C7C8E6ED8F57EFA3FA751715EA4939FEB26A2C5050EAAECF5E25D2E254C
      932A93861417D046F187084BFA3DD45EC4D83FE115E410DFB291C93E41AA0490
      82FE3FAE9B28D8ECB75406DABFCCB4C9D765E445694030C64068146BE8870300
      44343EB68051F7B7A80EEF17807CEF8F244F578C34D7C276736E6ACD37C4CD84
      790DA44EFB05CECDE8C2904076DD640300C7B911DA8EF7E1806B87B2349E09D7
      EEE43914C8D84F688F641DF37BCF84667983D53036AB610739457EDCFDFFCEBC
      769898CAAB5F908BB469B9FF58AABA96F0A36B3DDCD3A383F39AA230D988E398
      4361692F4FB96A1E9DC8B16307BCF18E4EF6DE76E8DFF3BD8EF7EEFDFB1DFEF7
      1CFF5E9CD774D453A5863EDC255FDF7512D1771506CE39FEE1FC87533571EBBA
      33EDA1A44D5D9C34A4D9BE0A3D3F8E7CE44979DC1E9DE6D058D0E1751DAB9872
      0E4CA3210DE628563D77AA8DECBED81337F285524D8F426EEE706C8D172F5757
      D6B7D6B7D736D7B7BBCBF8DF0B9826BD9049645965D1EC2330A40D3172234475
      C9FFF971F7F053B9F3EB26A699144A0B11A1CF9F8598D1EB018C256F9912DFD9
      CC49ED93263A78977CDBA439A4A4191B9BC912EA38B2F552633BD6B7ABB86955
      330C5F1DD15A7484A2BA4EDF9F9D394612FD934D279691CF2F46C30C00ADC2AB
      E65FD5D0DBAE0C778EA63E7ABFFF8E972BAC43D1523F1E9EECD65B31D901B73E
      24D39CFE6B72F63F9EEFEFB5480D67750C9C949DA5323849BF57A7F3F874F7FF
      75E624711B52F12789B53708858F8FB5AF7FF3B1F6C50545F9CDC2AB57C734A7
      4721F3D52272A26511D3843653D7FB40468C3F801147E61D5B79BC48522121D5
      027964FCFC09FA9DB2C8D97AB55932E721706879F459F8B7699401FB503A9918
      5B26E0865752A241ED8626F3ECD34CA142E53EE4184C25F86E06B7B66DFD05DC
      D3483AB938E38BE550B7D173CC6BC759A9286D2505174A49A354EDD66E54ADFF
      9C8E27CC06935AD34D4C9717B9E9BA9BA493E9843BF26B37BCFD04F1EC571AD7
      E6D64BB244A5BF500BEB6B37A6C374285B0985005761769D45F4DA09CA25D68E
      DED66E388B0B3FDDECD12204AF54E1C7A425FBA1E1E6CE109045F10B8201A32C
      9D0E4774A6E00FA726D949FB71E4233CC46D2479E18F275DEFA0F0C61C6FE885
      68C4194C635C572031E6D12E15400DB600EB282E055CA08B2F7373943A708DD2
      2B0C787704C84AB6BEAE77AA8104FAFFDD1FB8138193839CDAAA9D20E655D67C
      A10C53727F0CDE7B7124DDD64870DC2AECE852D756047C0D2BFFB7D8F5734D3A
      340B3EA151776ED2456FEAB62C9EDF64DFF8E64DF66397391B465DED36FFF13D
      4D27ED92763E0B87D3D887D50DEA7A86745CAAE538DD2C6DFBE2D0EF91F919C0
      ABEE7817BBE89A3AA4B1BC4D6FEA37BA735D835AA4E5F701E047473D07D20C52
      80249BB9BFF4BB777C68C1F016D791D43CF92121FDAE675FB0B8108ED3FA49E2
      4C539BF96D52F837DE8854470CF5013F3AB3AD62EA6B7CCD70D4B77E5081F42C
      6F0EA9471F529BDFFC21F5D1CF22A1638D7E418F7CA1CDE34833301E7EB77E35
      9C275306EF910CDF3D63AAD7880E248CBEB2BAD1A17F36F1CF6BFCB3EDB5F1CF
      B59F7B2D54D271A31886DD5A6AD457F9C8A328EF37DAEBD1DA6BEB9BD75E8B0B
      BB68F91FA7413488D0E2CD0087E3895F44BD288EC83B6723A797D23F7B218D32
      F27EDC678FFDC7FD3503F99903F2334FA7199AE651DC583BF52021E3B77E1E1E
      632C363491A7DE34C925B0232C746C042A921918B8A77DD0B868EEA07E037F7B
      5B843B18981787C99026991C930CD117AE6AD95CF77A51913779C5A7C82BAEBE
      6EF28A8FD6A0DBDFBC06E579268500A571156939F7388DC67E4222F1FEB1B8F0
      F7CF0C96F8791007708CFEFEF95FF1234ACCBEFEDB7ADFFFF7E9FED9E1C1F10F
      5E6B541493FCCDAB57F665BB417815F90940A4BA7408BCA2FFBEBA08F30DBCF5
      CB031A63FE727D73EBF5EA16DDACE5FDE31F7FC738B23CBE7F1C34EFF347328D
      3FF707AB4F30A0DF34887FD00ACFC9A095258E9FF0C2A47E6E68337052E9766B
      79FBF3204D0BFDB19FC6F90D7E089320198559C8DFC7575044849DC1F79375DD
      8F3FE78322E9FDF539CEF57A691A536C87B6B7280174A66F9A4883B09F625BB5
      CFB44164E7EC68A7E31D7F3C3F4009F5DE6A074DF627F50BA6E898F7AF686DC1
      9440349041A7BC21BA1890FF39D893CA1F64A3E3E8175C215D21351DEBBBFB2A
      D4185BC1C47A85F1C552CDD56DACDA07B8BCEEBDA101A3D72705A810901DC876
      44CF274389E563AF8D1F86A3342F96388968538335F4B04DFFE3F6360D7B4FE8
      023826080F011882DEC40725401A4FC7E436440510F8C88EA69181149081F4B1
      DBB5B5CB6B0753AEB7F1BD912F10115948472C2373F5A6C325806AD0F511E805
      E0B98BDB2E44423E8AE76A27415D372BAF498006A267C429503F08B02B48A879
      EEFDB8B870787668DBE594BF0E109652AB2489428827CD43EF475CCBB48574F2
      917992717B71120D138331624A7F0F2E8E6A2732DB74BBB24C42E32C8303CCC6
      FD830CD8962B0725A9D728D036CBBCEBEDC479DA610BAE35FBDD16BC5AC01A88
      52AA9D644E9CDA04A51C42C6028B857165E87C2DD032C7DB45CAD97A211D2C70
      796A3758AB7B56CBADB3EB4FC845B030D55A4D9B08BA21F71F730787D3771C44
      70F96127D2D2D80B356FC7DF65AC73DE45284CC841BD064C402CB0264CD8A4E3
      9FC2D37DFDCD7BBA8B0B6E2214D5396CD758B38D2385A0910A20CA899F93CDEA
      B5C000D4F22EC35B3AA4EB67D520B1ED60451AC0DB5A8EA372A07DD5A0DEB7AE
      B79AECEC3FA5B3D6E70768BF259DB5BBB8806C46C6AEC47514C76CF09872D4D0
      8343764323E7F21CF2D5601065726154009BE52A643EB7940672ABC80DBD7014
      25F553656A29AF6EC05236D08DDAC12A44570CC1830600E0D6D46E7CD617585D
      615FC0172E12C5544907DE19D9B748620B291DE39BB22B49D6DE99E53AB1C0E7
      1C798AFD5BC984483F08AC6471AFF8E3342137EB98D9A5F8CE2563CA8FBB8767
      C6AFAACA56C1016A2CDDE5572B2BF0F14B99614B99665281D6B78D33D252E20A
      384ED3CBE9C40BA61CEFE2369A40D722030101C78691F6A74916C6512D4F5BE3
      946E9198DE0A35A256467D304C8A70BEF7B4DCDF0A2707B6765D070BDF4BBC4E
      AFA5908012B16DD12A888D115567F77265059A65E7A3DB2A5C81F762D41ED202
      EC6B4ABEB8EB9D4BDC16133EA6CD4FC7881F9BEE22560ED0239A728E6FCDC608
      392A4CA76E5EBFE56FE5B50C3DF191C3DB407F5389892E859F8DDFF6CF8FB8C7
      BCEBBDF5FB97438EE2958C6371348ED43D674A5DFAAF4549534971A34C8D65B4
      C5E7B184C17DEF6FD3302FCCD1A147158D26F3050F4ED5C820F3870021909E67
      3A9F7AA1A11FA6B3E5CB4BAEAEFD24465E9B24AF7DCE2054DA33B57911307A82
      9BC5BB114994C4BF1A332475970C7DDA6F1F50AA81B412C2A14E480C5E6D3818
      A0D6ED8A36A2DD91882E4BA04C406B6A2C3BD87E276AFC4274B2DACC6ACA3D12
      EA7FF19F7614C5069D2726EA5E763C75BD3DD97B48DF74CC1A8BB87D12B864D1
      2F6150CA4FD12C25DE864EFDDA09D0880F41E68F6944B2B8B89D84CA1241C625
      9216934948BE4ED73B1261E4B2052B9BAD71B537BD1F126C49164BE3703FDAE1
      5EF9E61DEE88EC57F113D668B37CE04CEE9DBC8C5800A8AB53B5DD314AC29808
      747291F59F3234EA1BF61276D13E311067CE3AF23D033744871EF8060AC9075A
      2A27DEB76036AA5F7540A9B4D9B056466A3531B53C51A021156ACA27B368089E
      6A25AE0A98BADD880222E4CBBB26A918A461CE42CC39C8310AABF735C59D7A9A
      F26F245F4980A4888E90A8B520BC51704DA9F46FD46CF5E1465E598115D582B7
      329DE8F668499AB997DE90EAEA8FD24CA246BDB400811658014871D54E05F957
      6904883371B3802FDCF7699C41690992D24D3D6ED60EC2DE748880DB57ED9BF8
      03570B6F37D5C28F5622DF3EE2FFE2C2279CE0054A97946E4B8FD2084986C24F
      947A312467140DA4A43B9883CA106F8AE95432BAE288A69FE8333FF68EC39B29
      3B71E745E88FD971CD47A9720C9085B4C726819F5F7A7E0FBC2CFC1A7ACE9386
      9A8E6B87516A61264E9596A92D95842628B764696960524ABE7A4C27B489B088
      F50821987EEC3D7286D3A4976689B777B85B3779A8345A00B852A3D13BD86BCD
      2BB9B4EC7EF51AE10546A615391604686E710E8FD620A4D76D983BDA7E056520
      1927878997FEA869AD7FF3B6979747751B1C27E742CE7D80DF2C8E6895F6D398
      5DC32430B48AA65694CE056E4CAA2BC5F0E242AB4A916441ACA4DB2EE94730A0
      C45153EACDC39DE33DE1E16389D00F0776A9B785A4B9CACEBCD4F54E12879352
      F1CD18C54DCC8A8EF2B946BFD49CB2F9C0700DCE250B8025C524B65AE7D258A3
      4F618D6E35D6E8A3ADD16F1F1353AD850F9ABB0F223F4E39A359DC4EE898595C
      605A1146BE5EE96ED76D052C2E1C4ADB4CF82A08B58326F4A6C5605BBB6D100B
      CBFC248FCB5E23ED3EE808B4C92DEBDCF158E03049A3A2E8F1BCC8785F9068B4
      FE1130929AF42852C0DF287C7CDD04A698A074888875F1CA2638F2CB6892934C
      82804C2A057C6F34EB9368D6CD46B33E5AB37EFBD06525FCE1C9DE05340B1928
      6CF4065EBBC8D2690F85841CCCDFF3AF93E11438BB615E63FFFB9D257C0309D1
      CEEEBE96830B76422F9A30210EFBA39A8638E0C846093D91F9FDD09B2DA51142
      2B8D949075679B02E7DC52DACDCA3A000992D4143672478BE298F88C06841F9C
      42748620E32A1807778B5C8359EBB7A15F7D1225BDD128E9472BE96F1FBACB2A
      2FF22841BFC7C554603B3E38DD3B37FC83A2C1EA36FD15E2FABD7DF0366BA5D8
      CEE1EEF75E1B867D6B2F14001BD623C855D1A1D4AAEF11C447AD438697338E76
      16325FA8A235D235ABD8DB822140FF9E082F0A0E2C73F620E496320601D2E4E4
      F87882475037C1946BC09C240CA5C0654989B07BDBB1633DF0D9C15BC0BF32F2
      1201D46DE47649C8FAEF014FDB99DD23A1743A65C7B66DE8FA4826ACEBD797B8
      A2025523B63810B0F9491934F7467ECEECC69510536DC423ACF6C6EB1F473957
      E9300D549DD99EEE0597383FDD3FAC2951DD297751BEEC31225719EFCC6FC9C8
      1DF3F66DED4C26B452CFFB7452D3A72D415268733D42D9B058310A41170C72C2
      22AD9DB26F695FBB0CB3766FBF435AF8F697D03B4C87320204E5B32C4C8AF8D6
      642AF3A700EF597DB261F1207CBAA11D160F74B0EAA5BF6A68AEACAFFFF39626
      7FF9A1A666145FC5F38B23F936DF8AC5797E799B45636FA2C9EA387D8ABCE4D7
      9BEB935E1C5D21547A364DD0A325FDE0A7598A02830CC3F1FEF14FA09DDD8B12
      F6DB87348B77F6E6D5ABEBEBEB6E824289711AE40C1196EAB05EE12FAFD657B6
      37D71E066F766F19E193C29B3DF49DEFA2997D552CB3DF7116EBA6E71BE7FB21
      737A24495C74BAF952CE9DA75E3A004710F339E27C647B1D0678EB04B99616FC
      3B3170DEA2511709F05759E8D3DD7B68DEB6963DBD73C73B0FFFC6005C1D4F13
      419CE7E97861D1EFD6CEF279378D413A3481CD7709001F899B669E892BB36F7F
      D1C4FB9E22DEB7DEC4FB1EAD72EA00763D93F0468389475E2188BF695FC570AD
      D873D46ACB6E71C3B5990C88203C55A9F7F6E4FC9C312A39C2641CACBAAD972A
      20E3157A49B9EBC32180A62DF15F1FCE2F6A3A3230B22B173B6B2820804D271C
      E8EA85C03EB3A5670EC3410DC7BAB8C0812E8E748E53EE9E8AC3A1DFBFF5CE8E
      778E34298660DF9F75192B14937E225CC20884D2BF47F8F7D3FECE6987C3C474
      9E1E9CD7AE04D6EE724356337F883620C862A88604A749EE0F4209044F6ECB8E
      73133F61584A9C1AA2276A674B8064FA67EF38E5E486561CEE1DEC1C7A68BF9F
      D42FFE6789F5A0CE161782396CF64C74EB0F83348E819949B7F0FA999FA39B05
      D4AF5A57CF75F71C6053AB74EF70B776E2009880D7DAB5B8472D658205BD03C0
      59D4A256C65B8EF80FD218876034D0660418E3B0B76B77ACD9DA5040F2902D72
      5B1EECB4086E36D735745ABB49FD9E66C8DBBD383B64E39F8D1471061401012C
      1E58E383D24D685C81A77005D61A57E0D1AEC0B7CFDA608D043DF8A5C8D58058
      612349A8D68DCFD38A18E3EAFC4D13A17F6C847EBB2E11FA43A830311AF38E77
      80A3A2E39D4F42321B9E84C7EDEB4D3B8DE04D75001DEFFBD0E7E858413FBFF3
      FB4FD5FEF1F50675E6F7C337DEF77E94D108F66F4367726A348A5DE18F0AB37A
      BDF6592895F2F57A6BD4B27BE09EADD76BFF60DCF43479E3ED64E33423BF35F4
      270860EF8CC769072AAA314DFEB0A6091CDA57ECA77FE2886498A10A0DD6FE87
      BD3371CE0407078CC4DEB5CF662F192879EE0FC51510A4493ACAFCAB23C13FAB
      DB729909D7DEF1EAF36E6389FD612DB1B7A77B174CCC6A7A086E699DC78B0BDA
      C81548BC5A42390C63C00C27E4DC27852CFF68C0CDB18587E74E6957A03EDE56
      F4CAFDD86FC68D9E2286F7556D3B72568B08987D822FEC0E0B7F277904E1CDEF
      1FEEFE7A63462EC2F31597B00AAA5C0E9D475DBF61E5052FCFBB53C91FD47054
      360E670F1FC6674B2E3978BE175DD1C08A34AB5DE4BC31601E115B210F337CF7
      A33719A54988FEAC6B365A34992AF176ADD075EAEF6B67A4DC6D81CBABE5C73C
      38248F79ABB765FC633A78623EDEFACA4004558D4BFF2CD79510D1AAF2181DBD
      988A9D471A1E0D6E03F20E80FD503799991C2D0F1D4A2E2B5E868910BF3126ED
      E20210FAE94740C69FEFFF97642EDA6818044CAF24346C964678197C14EDF7C3
      DA4AC3EA4C2961E70AEE3AC2A54B7BC1EEF73BA6E89E97B96933101CB9911F83
      709A1634230D700E760FC1A9235AD0B748BBD574D87B86BF90F3A99A5FEDC846
      F785D85241502B3A829B2F34235DBB911FA7DC69C540EC32AC1636EA254C996B
      8086E23741BAA7B1B66A373E934AE58E287A5DE9C605D48301F289120683469B
      505052C2D566808B0BDA45F22E8A712CE328DAD554B8F42974BDE3B408050256
      926332DB03F9424E2E06003564F631DD930C5C95273FA097AA1009E9B522A30E
      83C84A0BB8A0DD29D02C73A3DE448541A41D66FEB8231878771EA6E10F3C2BCC
      EAC8AAA2F276E0A04CD0A6AEBAE05C009C350EC5D67E259CF58A7BB5B082FE5F
      9C0EB9C06E3A499985A97E249B8B0B62F38D23B04601FC80D73FEF0F32535E00
      A82E094CA585145918E083AC2C51B00B9AC318C2516AD96F05CA11F7C6CEE05B
      339C047775D115FC04BE1F1ED3F126D3828B3812B7C8234BD3C2147988156E3E
      24C187FD69C177631B8B6EDE367D1E5DFAB0E3D18C7D949FC2A2DFC0BB3E4D59
      C16A5356F068D7F7DBA7C8D4FEAE73E9E4AB9D3E034B64C9F221A553A4B1EA36
      0CE9112513ADC718DD8C130A6007AC8F02488BC0AC4FB3FA51DC9D85E370DC23
      1D3E4973A5EF23E58F505A88124EE8F4B1CFD437B534434B0C21A96F53862836
      BBCF47D1A0F86EAF17EFC651FFB27643FB69278E7FF63E65B7A1F7D6CF47DE70
      94E630F30CAC73FB1FB3BA6A9575D5F2EC69F57431DC7FED86F9A4CB2F72E7E1
      BFBBA25CC29E548B5F82394C0058CF75FBD3CEE1E1CFDEBBC3F30B460AF1F0DA
      52455B4D50D47460FB7B077B9ECFC4587989D76B9348F51B9584DBDC9E40D635
      A8B0D025193B9F95E091FEE2822E53308B9943A6282124EB2A8A97F11B9323F5
      807789530586B797D350FB2301A14E99E541C0855DF928BA7CDD86EE62C4B0C7
      1AE5B955C81A51E6B0A4D30BF60A0D63DC2FC68EAB16D28740961F58558EF1D7
      4E1A12BC94FAA2A334F881DC9483A3933D13C03520FA88505CF91983F295C497
      351DEDE9E1DE6A152FEA0E4D2F9F526444D2C6A8E520A5804828FD2495EC7244
      310FF600CC9C83E8A67EE333510A93794BAF5151398A2666D54A67274D217A01
      EB3CBEF324BDBEF5AE439FF186DDAEA6E8C6CDABEF64C5689CA65913A4799220
      CDCAEB2648F3D820CDC6FC25F02D05691617A2B24B6CB6A210DB48E21E9C8FE4
      74249079B58AAAD9574FB1AF1ACCEBC7EFAB6F9FFA7371E11D68A6A7C5F147DE
      3168221DFBD9A5D2771B9CE768E005D309F9905CF5221DC7B4E5AEC0100CC21E
      6EC8AADBFA10CA77EE2896E0559CA697DC9A597800EF5362E9BA922EB5D0110F
      8529603379CB72458CD2691C3886B3F020F32487851FC5DE5584EDCF315838D9
      5CF8D468D1A7D0A20D28F5E3B5681D684603A607F0FA0874A36BDD37645F9AD3
      353D1EBCB3AE4748DA8ED2988318DC20FED7E978A2B8597E5153DCD33BFA9415
      0F863809B34BA34D513C8681EE2748A39FA651523B90E6C505F1CECFD93B67E8
      448EB2C85FBFD3BF9F62D0FB3268A69E47691540887D8FC9100290AA7358129C
      91A69ADC82BFE28658391607426B2CEB252A14CF55F6056A633332D26F5D808B
      908FA36B2F9D84B0E6119FE3D8AEE70F695C751BF3E282EC842879C930E66630
      B4E885AD3BBEF5FA08E3F048FB2968E60AB38E10C665C32A02660D7813FD381A
      A2D6C6EFA3A1FD5AA84843F92C01C8794C7F5626BAFA19618B0B474CFE21FD62
      3C7CF9C3993281C0F6902E0B0D68828EE593B4CEBD31944FE10D893502C3911F
      778C2FC8A2EAD3371B428DDF6ABBAC7637BA0DA8C6E34D973A901B23104B1B2C
      CFC3AC9887C4DEA7BFA340E16EEEA0D94FBF653FAD34FBE9D1FBE9DBA7675C5C
      783B1D22B9F1C61BC4A9CFC5301318B97CD0FB59940B6B21CC9D18E5D6ADC1F4
      975F6E5B5DEF02C4DE6894C9C21CF95A6C39F45DCCDC8604D20B33B981DE1221
      0B9497867F9BFA3103439285904E876C28DC7AA60C5E5D91381A8309514A8FFC
      7E7F9A01783025ABC5536BADBDEEF56E8B7069F6D19C80CABBDE5B2957E5526E
      F07DA15FB72FFD4E5CA7CA5FCBC595D160432FB4EF272F2D0126FE4BA34E9E42
      9D2CFFC73389717E90F3D1625CDBBC578C24A37BC5F838E1B5CE42D93FEA9E4B
      B940B7DB6D7D45E1FD1671FD3A8CFD6F1712906EE05C3066B7D68A48D33D2DB8
      C4BF8A865243526461C8F18C97FFEEDD275715EBDC8F45814874927D60F321E9
      2603F4D90B11A3840A32B111692A04DB0F62D57E72CB19F12C0A1C2242C61718
      43C0503C7D45EE092418A3F75842330BFFC64A92FB193DF94DD86139F0CD2ACF
      8C8235340AF9F370308D4D270C7B6B639AEF0874E1E4AE4C518652981E2A3ACD
      13A6A115074795F0605A4CB3B0C3AC457E4C6F72ED275C9CE2C7D7FE6DBEB800
      57F10A83F235BA6E0815BD76D81D763D694B7B77B2762A70A6A4956F61C491AF
      880F12BA107289FDC9842F54D16AF94B89B3A0EFDBF14C9BE6D8BF84AB9569E3
      506269EBC96BE7DBC3CBC21499AA32F7F6086FE011B887F8BE6C4A62044E57E4
      6CE962EFBE83B957A16778120DF069E7ECF8E0F8FD9BAF5F3E49736A03629803
      67B5FBDC4B9317D1E202AA9A784A6477F06C68E716B77E003283CE4FE17F83B7
      2C0D55343997B219B8DC406FC13338CD793946B9F92B123BEC625B3E4F5EC2F8
      76104EC224F067D745120A563D5F076A4EDEAE28ACE24D459FD042E493483710
      88466445C9EE2E523BDCCAAEE397F7A5238C37C8E2020C833EF6316C115BEEBD
      437BA423A330FB006B8DB34F1048141BF633261E88FD0C3A2508B8A3CDBF267B
      A3C53C598EC8E8736DC70143F474829FD6DFBF95159B4D853B6C9AA01CC5F736
      D77B343AF3689AB24F5CF6DAB8424F60BBAC7597BDFD1F4FF7CF0E8EF68F2F76
      0E1BBFE8D17E511DC895654FAA1D403B2847E412D550D27178A7ACA3A38E9072
      1F8EA19FC688088AABE11809F42FBA4300F719D0E1242737698796FCDAE7C65F
      D5792DD6003EB6F22D17D6D1D57D283CF248A67DD3183C4901491401A6804EE7
      507B37D03CABE7776B97B9DA10A4DFE7D6F09665FAAD5DD15AAA260987A51347
      C791C27141BCACF5304EF3C260ACD2C40AD3A63AB0E3D04F1CEB87556D1E6A74
      3B873B780D5DEB1617D88B832840FF257F70CBFD9179180FBC36FA6330B98957
      3639E6E38EB77B5E027170EDAF3A9B26C3D0336A1DA3200BE9802BFC2D323C3E
      90CE7F3958CC042A868FA0AC9B838DCF9697492A8C04F4FAD852E390CB8BCC9D
      D990736F8F2D0989E5A18E56E04172B15FE9BC27E15C86E144E48F3BE74B95A7
      A3F1D679FC28C2F6705F804FF18BCADB2B79AAE4515EF2E5A7EFCFF6C4E40EFD
      2C06018D61E7AEDB5A45B79B1DA9C1FA8F02B685A2F193215D7ED531BD9D0E51
      13CAE92109A668A1467F94467D53D2DE0B0589C3A04C893D55B7B12E2E5CD0AA
      FC9048CB3CEB6245DF28A75575865892A7C86A91FDB7FBFD99F7D332FF6F65FD
      67ACFF7D69A73EF5590D95B6DF397D533F3BE72E3B12ECC984353877DCC917D4
      1CA4C774BDF79184CCD4789DC8234D990CF06AB85F80B69D4C826A8DA0530971
      D9DC1E6904AE44174B9927CF746E5FA7594C5FE3105D3428C373136C4781C1CB
      42F6CC30EF908E342B083C89340D720AD96A38BA11E7C9027332194FA176C7D0
      839706AB59843FADC4B9790BD684743CF18965A4D8112D1C4797D240DF128A11
      EFC5816B1C48CEF18577C6275D79987B415ACB3E990B5B39C083107D0299A1DA
      EF3AF7DC7A158E1F93078A820CF5B144CE645C42A5F639C3ACF04DBCE2F5D220
      D43F42F4EC78CA9AEDC7E83B9238033F9856ACAC76075C64E407B27C1975A46C
      B46B3CA97FDE935A6D92B4FF84F35407DEC5F788FD9C1BCC91F6FBA3F38B25D9
      A5D8D48CA7634E9F304FE32B6650476F5C2AD0266976B0D7E188A9D80DB55369
      3B5A1FA3A7DC5938145BD76295717F8088807D4871017DEF1D9251F2E546C53C
      858AF9AA89A66F3D5772E1462435D1C03D8963FFAF69C6C233A6841F47C5AD46
      FC9D30488FAD7FA455B5048A6EA8554D58DDE331999ECDE9F8DB97EE4AB781EF
      79FCD9580782500164336995419421E8820444597B40071F79D2E24BB0A55FB7
      95508ED1F756E11656C7C7D5A47ECC8139D0B6FB203FAADB1811DBB15015E834
      1AA6D9ADD7FA3E0AC85343C8E3280DBCF7E83D6A193640725B7AA1620CB2B153
      B7312F2E305384E174A4411A6BCDA3E3E318569F2C6A84378761E10480F0B744
      5282B4A27DC63328C971EB26080BA43B813E117ACB53BF18D18447F5EBBDDAA1
      99E024796B9A00523569990038FC638E3C493195360520FDAA263C331BD46DBC
      8B0BE7B3C18636F3C133BD61C48964B5D58BD4CB2FA349071171ED24EC78DDEE
      92B646F4DDE2130EEAB5CE6D90A1D5B1BF1DA74928B99CD60172168567DFA055
      37E9F901F2E818FB544A48A4ECDDF4599A4E90743088FAC849296A49DD862971
      EE37DEBBC5057B9AF5F904BBCE5224FB0D582C19A0652D0F17F15B1A0C092345
      19D404A2A526EBE29BE5D5E6AA2011DD12AF0FCD2AA9712E4B8CEF5637F99165
      1666407129AE43FFB2CCC68528B288F2B11E8A52A5E3A03EF563FCC9269FEA36
      6C3E200776C544779278ADB7D3287642BE000B482429096DE0B5697FE5DEDFA6
      88FFFB5E4F8A5FE96F91824191DEED8702740EB36AA9EBED30D10147426D9549
      400A4719A4E9AD1046D6C705DEDBDB568557DE043B4B1A4ADBEB54E2D664E5F7
      C16A634B77EA8ACF73542A2C6434FCC924467257896CA48EC6B412F4A3AC3F1D
      C34CEDD730BA1E2C2ECC44CFB9E1334BAF4D748ABD252F47F99E2D92E4601D1A
      DCC0FCC5C543367B749D971D5D5C976D02560282C9B58582ED350EC769D73B4F
      6DB51ECC87D0CF238E1690ED67D8CE016D9CA697B5DBEC48B6DDA2547DE81DBC
      B8E22EC8614A2F4E72E8E158F873D3CBF5DB03214DE7C9E3032175A0F0A92609
      A085A51332702AA44861D46DF2DF995C2C7751C3A43B45E90BD762EDA649A020
      404C56418767C0E395A6DAFA05416C8C23F7DAEC0888DEE33321F6E928AD1DFD
      167C4393B7720AC9EE3A8162E32DF1444A6DF12B0130E10A63DFEB1661BE8EB3
      D462EF732F80ADFCC8B1FC278819608D7068C4CFB5A2C3C2417A6DF5A60C6A28
      4A07267EAEB932EDC8B6689AB593F6A9318C332EBC664222B7AB138295306229
      3C25B729C38943B2759B73F61133F3DF648EFD005B0C072EFFB6438B780FD439
      4DB2CC95126C3A3654B1D1AE47292D41B55110FDDD4BC92D208FA94B2A30F48B
      3F79DF93C13C98A2FCA498535C7A0F5911CE38E35468838374F7DC94A594FE9D
      2694B9E0DD4F08DDFDF2000B04833D18F3C2785007CA13CF4059B5DAB11D9CDC
      89AA90D723F64A42AFC5925294050B1C05A5384D46D29534A0F91A4968FE44B9
      07F0B939AC1FD419E1AF900597C7AB1BAFE95FB8394FB7E0EFACEFB5958DE5AD
      EAE41A71AD6FAEAEBCDE7C6D78896962FEF5336AF7C2C02F7C6F6379BDB7BCB6
      BCBEB2BEBCBCBC49FFBF2D6588ABB45FC3D741B83CE80D06032D4DEC2FAFF27F
      D7E4F78DDEFADAE66033DC5ADFDCC0BF1B838DF5ADD75BCB9B1B5B6B1BC16AB8
      B5BD196CF6FDFEEB957E6F3DECAFAD2DAF2CD3455BEBDB83FEF65AB8B11AACFB
      8B0BAFFBBD557AF8F6EA46F87A7BB5BFB51DF6B7FCD5AD7E7FB9BFFDFAF5EAFA
      CA66FF75B0DD5BF5B73636E865B6D6FBC1EAC6FAFAAABFBDBABCB2B9D95FED07
      AFD7D6065BAFC3B55EB8B6B5DA0B5606CB5BBD8DFEDAEBEDD77D7F6BDDF70783
      D5F5D5557A4CD85BE9AD6F6D04FE463058DB5A1F04AF7DF2773736B75F6FAFAC
      F82BDB6BFDCD157F6379F07A7BB0DEF37B61AFBFBABDB6B5BDB5BDBC4E377BED
      6FACFA1B5BBD7093C648EFD15B5D0BB6C3D7CB5BAB2B83D7CBFE7AB03AF0D7B6
      9757FBBDB58DADCDD5CDEDE54140E20CFB01BDFAFFDFDED93537725C67F89E55
      FC0F7B995CA46AFA7BBA7C654976C9154976AC4D72939BFED432E2121B92EB64
      2BA5FF9EA70720081018707A769D386543DA5D12ECD3D3E7F47BDEF39E063110
      3989B14466116A2C2A79ADB22B6650D15E5FC5416433AA5C4A31D513065DA41F
      226B5055595D42D2419304A38A2A0D9EC09514C6EA35B11116DFF8367AE9AA91
      2568C9558248D9F844A4AA173E0E6534C51AB6452813C65CE450E510C7246452
      71B8BE6AC13635558BE8175CA0D85855F465F42C3F666BBC4D3165FC8D722C2E
      296B4A4A2C43D40AC4866A542DA35059A5C432A2AB5BACD4861EF0720967EC06
      31088E69B74F0EF43E62FA22EE90569D0463C92959C1D5EEEBB101A9DAD090C5
      FA5DA9A38999300A9789379E0950C54ED460FCA055DB1E97D910214757ED28A5
      88194414FED6F5FA2AB1AD4388913813EE52AB0B5EE55A421963F545785D5A74
      AC0F210C36A92235C04BD18E4538AB32E0AC20D88F26E8E0A419580EE01946CB
      75B9466C004E66C82228C294951031183D46AB066F846417EA3866AFDB28198A
      965667C10E0F59B22093A32299A57635382F9C30353B9037B6A515624666A86A
      8425B19C72B852C61AC6E46B0535C428255F744D02FB2A53319A4DB1A48CD73A
      597E64594110E415EC6B54CC607AB42684AC45C9433411C4655BF3766F96ECAC
      8DCE7B2BECB8638C31EC99647AC01C5C019630B26EBFBEBE3AFCAE7DAD331314
      FE3878453EB10ACE249D07F65E3656614F5D0EC2393FC0066C4604A6DA58923E
      C55062ACAC4C2B9F44D0027E21A2BE826B32B0A85129974A06C7A44CBCBEC21F
      BE6023D3E0863C066BA09C328E0DD40EBE098E7D1B73D0A3486C54B2A930A720
      C18A77A320E2518F245AAEDA034B65581B54010641468E266739641B0D5465A4
      28EC45CEA690BF1AA04075ACC019574676D3490FCAF8218EB0A18354634FFCEB
      90ACF2C643CAAE3D97BCDCC6DFCEC57FFBF5F5D5F3774A3CC5BC2403478C640C
      980445432D1AF2485549E84202BF32928F120603589E29B1C8380C7B83BF5C2D
      5C9CBDAF140D9DC6487DB18121960A1E4B7031B191D2B387A3BBBE82C0601EE2
      A1F95EB1A1A32483ABC765EB2340267D417A56CA8702CA4CA014952271DF8F51
      0F9660474A692DB0AF697F74AE2EE7544D9136EBC8F6C2748E4C203509366C57
      6221266CA795FAFA6ACC35F094A24A0042D72805C28E410F5E07B2A170413538
      A72AF87225928F595302259018BCB37A50F0B976819109960E692CB86954199D
      15906785F78D2E45C42A4D8A82DC268F450BC6485CA94C79848A47AEEE595D76
      A148378EB04BF12AC841674D192DB03F2596D2A082CF802AE2AC2AC156023104
      894BC52A0D284366420F62F2980C69AFA484702C10D5306B11438B043C018B99
      9C4A1D5A2E14A182D04E0CEC78D578288C73853086466900159701367CA40763
      BDB271646F8C4A239A44C29C2AC0984A8D110005ED1DB0AE438EA32201A81244
      548C5544E792C5451123B200B4421AA5E1C0B7C295342200B8586A8C33E3D048
      B2222A46C1EE9236192F4476546D889D1ACCBC200521300458BB113370F50481
      293D7FE1438085442D6CF6A860970A0D48EA6784B68BADA5E277A40C1283A29D
      2328B08DD046795212E146E98045782EBA106596424752A6865C0753CAA0713B
      652D1DD560440AC831284620404802AF466A660423218928074FB68272B61F44
      6B674909B6D9437A03FC22606549314852A5C2967A2BC997047282F00D4940DC
      6B9A66283225483A004689840912BA48D40C9F10133C3144D609ADB922701765
      A6A794804328C143AEB289397891FA4300484048A966CAF2F555358D1BB3730C
      623F2C1530450FB9681C093949AC182A54FB3751257C7543FB1A7AA32655C2E1
      3116067980A2043A85E1FCAF3C438C428EC0D33A550137B4153086AF01986B73
      A0D262FB3744AA562564284FA7824BDAA260C0064571CC443B05210D6566448F
      A8D2B85FBA965142647E305862A18D185B71255E355B8A300A6004E0516B4AAD
      A116E8604586A660221B2C4AB4A2116024F401D4E0B94846FC52D61C9A4EF22C
      D8D28A3CB1DAFB6CE0E95A8C493E404BF0021B2F9161348648CF64D02DF065D3
      2F0E75696252C9142AF2400D913EA640065AF405EE0878066860924CA23A7B02
      1905964966C80D4A04212A402A5CB928910A320DE44395A3565A8724592E8A53
      495852065A12F03BA2A7945580B2B07498D912484ABB4497446BCC487E825A3F
      6AD4147A604418024434049C98008C306DFB89120E107FA68D8CD0233A5DF35C
      44F2C338C1A21007E3463241121F16486A58B042B229B46C0546482A2EC6AEC0
      DD956203BB7ADDC8D252204075710378D749D3176472975D20932C1D07C02E6C
      18C51D366B7581F5A2EB64BB8C25A73D65A9C5388D964B0C4AB32B3120851001
      A385E72A0520237BF88E3AEC8D1920E05A51BA0E0D053413E9841E23BB460B3B
      8A68D191742C9A7E8A7D87E1FD20041A470F487C4AA2C8342E02E8D1E2A0CB59
      0489A44A74743ED4404FA523EF42D5638324424231E780FA9DC41B3905F4D8C5
      D1193C63875C453F55848CA3F0C31BB843EEC389756C01730DFB15889A01480E
      C57A07F11848D466B893420ED9D28FB49A027BD6D20AACE37F2AD8088F924C02
      FE548DD89AC4D602A947FDB6680912D2A74914B5DD84FD20000B32E0AB890F48
      90D63E480A26E180BA33F2786C09D7129CEB2BFA1B9AA6D0187884A75A8FA23C
      048EFE6211F08891548740D53348CB42D80BC91628D003BCEAC9D7AA69DB2003
      C48A8B9AB21187C6FAB0728B8142DA4EEC40282004E2DC88DEB6D62B219723FB
      0206810C420E6907CED806341CAACF809464222A059209F447284753C3A04962
      2E8D42609C427E2013D0C2953060AC5BD340E2909750CF787D054B014AAB4D2A
      085CB440A4B440074D533A8A2B725F0D922DA029428951951C018E4223EBA880
      A48A2619491A0A093CEF4C12B9D284B8D183420041A54E81F5295D619332D013
      A0AE401E5A818AC82E0C85023F905E4DC9583A122E4CB2D05A8CA18549A33D20
      11C94643C35A3B2E445DA41D44E0B5B21910320808E4049B83DBB433038A4700
      1B849533A84E077B30C198D904A13C97445FB43624B65D209A88981228D3D471
      E401CD02856184116366AC070B92CA4BBB8C02929108B79A816C7631007C4D8F
      E70180045BFC1C95CFCE3359ABAB25075A23C19CC8386041351854AB76680872
      5A23FC61A4A699D2507C20B74C852C5181E84C7A01A3E8CFC01495880480729A
      AAC03F27DA71898F646BF4A2B4D81A94AA00808679290442D31DD31941A3AC8C
      D444F98F6C06F8D7281E0A8040FE9001A1509D2BD398D635B0BF0801547CA1D5
      21B87C490E2B8A06EBA5FB46003649811E2260E404C585628A3046B3D12F8F1E
      1643C7B60EC1A04EE86ED0D3BAD51ABA4DC8919C95B00C9D38DD0F19632B4C40
      6582FDE16D1A11C44B15281987080B8AD500DD810EC20E4DD542D99E8C95918D
      850BE1762B43AB42C8AA2CA1D95153A7A0562A37EC14C0087185695080C8790A
      3825C3A1B16C3BFA40F454DF78A9920BD430D70A87310D83002F2238F1D4B996
      4109814102D9EC329B32689CB013DD34B51E13E4CA960D5ED02F2BF03328B472
      AB0264101C0480697B891C98A04DA629ADAD34B211F42654B531787601DE51CD
      EB62885DAE4DEEC3732ECA0081A4018ED74D4C69388B5486E1016BA05E2143A9
      A59A9D609B68FC680B8776F68268423587E891AF30A2216FA056032B520E5829
      BE59AAB88F640765059596830F6E84C409126A07FC14532D4404B5114B883CC0
      60303FA9E06B00E3FC2F249844F14E2C3BA25093ADD17A83082DC9B623325881
      25B58670C881EACCA2BD0523244D04138E26B7696E671A27B6D90D90C671DFFC
      A309E23B2A17D9CFCE428A88DB4031A74576B41FCD496A462EE4CF10085E3B5E
      723136C61EAD851F7005E149D9A66B844CA174D40F051F1989F26E1D1268A2E6
      C270E8038B66A5B76D981942011F99268A6DC3333246590A8F3416D545F98E29
      8B38B4A3B3817E07C1DBA42A321415510B92185D5E0827EB442515C7034D465B
      6269A352EB45610BDA1C9AB640771E225D58EB9DE168D8159A878281AF4B99F8
      C3FFA1FD262281E42F443E9D0A5D49154827C400015699FE8C90B59306168B6E
      D734258A8B92791408DC212F503E808BAA490E14281CCAB3ED08483AAEE4081C
      BB4092B3CE81A62F816AD5CE1E5CA84DB60CEC003AD035AE13167EA7FB45BF34
      0DB4B8A7C735E1070F48766729716B2BDD534FCF2E9CEDEA0F4FD15E3B5F393E
      659B4E5A24540C435448C0B5432D8A214D33D2C10BFAE98C521A88304DEFA85B
      CFA46833415945BE0ABA2CFA0BB4781A6090D6B3C4D6B2FB0813F94CF7CA4045
      A7AB44439C40BEABD6D31B476946A6D32C16A81322246A347D8819842A21024E
      B2756B641AA214788A46D71A2EBBBEE2BA080CC99C34490041BAD678F994A1E6
      762A4A6B5C10636A4486D20DC8D0E4BB4075C2EBB8ECE86CE9F06A3B3C15AE9D
      F350CF2C1BE05AC51B443B7118A839D03B61683219DD2869594423F46244D389
      880870C4B2C7D08E8968DFD0E131048D104B545EE40F449777E7EB47BB2F6807
      73BB1D40FFB9FCD3E3FA6A38F358766AFFDA1ADA99EDA513DBF32B6081D3A8F3
      E7B9AF5DF3B5D3C4730FFA05BF8DCEDC59D76B99F0DAAA5E3B633BBF0BD4A485
      AB7A3E7F7B6D2573CC402EB8F90891C0E1D24AD6B1C6B45633D8FD65CCF68FD9
      9D5ED27BED91F2CBF5557B512A6D6E37F70FA9BD34F57E77633F5ACEBA9B7980
      A7B9925354E376EE96A56C9141604BD9689586B31D2BDAD646B8F6D376E0A729
      A06A6C2320723DADB8FD9DDA0C449651CE37DC3317FDC30081B557802002850F
      52E7D6E73461B65D03D9A2F8996876F4FE9AFF90A32098E6A0B5D35364443B49
      B3D54D6BDAD9A1D3884BFB99DEFD5436AEB09A7F0595645AF3E4253DAB224B14
      32BF8DB7F4BBB64C1E62A1B6574EF41662F289A678F79CB671FBDC344EEEC7C9
      FD38B91F373DC7DC6DCD1303ECE6387AE6790C2BD83E274F469DCEA44EC6A893
      31FA648C3E19634EC6989331F6648C9DC68C44BC45346EF7E9E9BBE967EC844D
      FA78C48BE718071676986CBF9474F7F8F0F8E9B63CFCDBED437E78BC791FFE4B
      39DBBEB9DDA49F0B9AA20ED38FCAFB9BED4BC64FCF6C5F4D6EEF14797AE63FB6
      BFB8FDF4ED87FB9BCDFDCDE327BEF7FEBF9FA7DC7EE2FD9B030BF1E670FCF0E6
      79ECF0E687E963127E353BDA1F8D7E57B6BF22237E757D75BCECADD5F3A2C5FC
      02CE4F297FF58527545F7A42FDE59D365F7A8DF64B4FE8BEBCD3E3975EA35F34
      E193D50D29F65F8B117C6CB50CA4C736CB70786CA357D898551E2D03CCB18D5B
      61B36CD38F6DFC428F9ED0A18EE1F1B8496CF3674EB06CC72F4CA03EDF896568
      B830C1329AB93081FD7C279681E6C204CB107461823E9AD816C637BFBB6BF7C2
      EA4CADBAD93CDE6D1EB7EF5BE9BA6AB8C36E770FF15EDB4687E5BECBA42D1493
      35C4B123DFF55CAECCD1AC294CBF2AD7B5FCC7E92D659BFAA6DEFCF4F1BE3C74
      3A52EEFE546E371FF67743EEBAF6DEF8BE3C7EBCEF5BF71E1FFB77BAAD05C9F3
      047DAE4F6F99DADE69A5EBD21FC24FABECD0B59FE1F093F594127D8EEE21123E
      3EBE6BB8BB297DFBFC3EA4FB4D1F2A37A12B3B9EECBEBB79E8F5AE99BCF9EAE3
      ED6DE9A38AC9EE87FE6D9CECFA44D064B2B4081E19F589A0C96459A13B13BD35
      4EED2C57F9B6B35DE1E2CE7285A7DBFD5EE3E9CE7295A73BDB159EEE2CCD7C73
      2A8E7BD9B7378FB77DC4F2F5EDA6BDB9B9D3AF1F6F7EBA0BED432ABA14C9F11C
      DF6C7F7D7B7ABFD64FF7E1C3BB37BFDDDCF525F1579BFCE9CDDB5E95B0B75A27
      6DA69D691F837273F7B12FD647966B50B8B7EDEBA88E6D9736F1E7ADFBB2EEFB
      DD27DB7EFB2CCCCEC3F805BC3EC6C76E24FF186E3F6E3541A783DF84C7BE2B3D
      03E8B7D3FDA47630FAFC293A31F1435304DFEEEA6C9FCFCFD7EFBBE4B35D1F04
      5FE6DCEACBEECC7B89F8ABF6453F557CFBA9DD34F2E6EEE72EABDF6EDA7D744B
      3EB63E0B7C298F31FCD86E76B2F3EDBCC131E1FFE6FD8777E1E1A64FD03DBD93
      EACDF7E14397E11FDA1B1BFBA3F89B7F78DF3E38FEB968F4EDDDB76FBFFFEECD
      DBCD87A661DB0D4AFB76B0197FB5797CDCBC5F65BF6B82FFEE5F4BFCFBFE0BFF
      1AE57CF7E9FD1A877FBDA2239B0CBFBEE9A4B3ADD526AFB0FA66FF811C6B5CFC
      C7F2296EC27DEEBFEE1FE8A2A6E4782C2BAC7F0CED0DE0FD76ED2DE6FF491276
      9F174CD6FF12EE6F5A2BB6067E6FBB0D0F3AE4878FF1DF4BEA4BD91F366B9AB1
      DF6FDFABBB950CCB0E1ECF9AF6158723D3BEB2F476FB4900370D0FDD07E247C6
      7D4B3E325DB3E4AFA7DB362D3DDD3D6F2B57F9FB64FD39ABEE6B8576B6EDE5ED
      F6C97AAB5C7E325EE9F393F92AA737B71FDFDF3DAC5DF764BB065D4FB6BD52E9
      D87AE5564DB67DBDC2D6B6DDD17155A826C375DB3B99AED9DAC9704D8426C3D5
      E159FA5AC419D3BE17AE0E0CFB5EBDDA1AAE28030786EBF67275115871E07660
      B8662F27C3757B3999AED9CBC970CD5EAA6FDE94E9F353D611D981F9BA7D3D98
      601D09DF3D96F71F36F7E1FED30AF3DFDC969F42678BBFB5FCC3FDA6B6FB07B6
      9B09AED3171FE3E3244E569BAE291EB43BAB2ED9ECD66D70B3EC3C53681F57B3
      39E847675EF97C66B1150EBD6DBF4F77D6EEA0294EE5DDE6B6DDC3F0EDF3CB33
      E7CFB95E8AEC1F3F84F4F42AC9D3207BDCE27F37DD2FF0C777CF2FA7EC078A33
      0327D97E344A9E19B58FC67E943A1AF57DC9371FDF3F5D750785FD587D69ECD3
      F6EF479B73A30F6AC37EA09D1D288F07BA73030F94C37EE0383BF0C58C7E76A0
      3A1AE88EF7E69B70FFF361A3B41F76BC337BFD786E179D3C3FF664239D3A3FF0
      742F2F00E8CDAF536A473F6219929E87BFD8D43950CDCC7F195D334697613663
      74016DC71673F9FCC7F2A79B87E7138DF3AFDCEB17EE3F1CBC8E71E1B4EF1866
      FFF471B33BAA397F91E36DFC1D15ECEEA11C582D499C99285DC8A0D92DBF904C
      3357B99055E72DE6D26B66F4E52C9B31BA906E73AE5FCABC19D717A4A0EC4B41
      B98CD567862F4BC013EE5E9682B23B05653780979780198B05F03D717F018065
      1780E51A00CB6E00CBC58563D6F50500567D00567D00566B00ACD65410D5A158
      662EB400C0AA1BC0AA1BC0AA9B7F5FFAFE1A80D51A00AB6E00AB6E00AB6EFED5
      2FB7FD3500EB3E00EB3500D66B00ACBBF9F7C4F70500D6DD00D6DD00D6DD00D6
      5DFCFBD2EF8500D6DD00D6DD00D6DD00367DFC6B7A35BC590360B306C0A61BC0
      A69B7F4FDC5F0060D30D60D30D60D30560B3867F5FBABE04C0A61BC0A61BC0B6
      0FC0B68F7FEDCB0D5F0660BB06C0B61BC0B61BC027FE2C00B0ED06B0ED06B0ED
      02B05D03E097AE2F01B0ED06B09DEFC5C5711C7627AB47BF7D73BEE33FF6EFA9
      87DF1B5E3A6310E72EF9C7A35F1F3F6F28CF5E7389E57190BEDA6C7EEEF895D2
      FD2CC7B8FCEA26DEDE6CA693914F9FF356BA97A7BABFFF7AFFBB6F87C3F4C9E9
      6CFB95A5E92CF7B845D77276E071FBA4D5ECC063D1A9F5ECC097BA439BD9A1C7
      34AA8FD36982EBD34B3910DEF1583B37569C1BEDE646BF707F9C1BF7C27B3F37
      EEA5F366D62733F1C5D1B446CC0DB6FB2C3E36907306EEBCC1AB613B7FC47321
      7E73E748174239738DF9989E37782DB433560B623CE7D39270CF38B734EEB237
      EE8B013C77FAB120EE7255DCE5EAB8CB6E90CF3AB734EEAA37EEAA37EE8B1964
      EEB86269DCD5EAB8ABD57157EBD07E522A5E8FBBEE8DBBEE8DBB5E85F613E2EF
      88BB5E1D77BD2EEEA617ED2FBBAA057137BD7137ABE26E56A3FDA54F3D7137EB
      E26E7BE36E7BD1FEB27B581077BB2AEE7675DCED6AB49F38771CF7A9235A2C02
      0F465FACA107E32E52F8C1B88B0C72306E27012F12C7C1F06522F0C06099083C
      0DDB22117818BF1983F940CEAAC6F9982E128127C15D2402CFC678C67241B067
      9D5B1AF78B22F05CDC170378C6E0F5A8BF14564BE37E51045E8CFB45117831EE
      721DDA5FEAAD0571BF2802CFC57D3183CC48B285513F918E1D71BF28022FC6FD
      A2089C8FBBEE45FB896A7C3DEE1745E0B9B8F751F88C5547D44FE46347DC2F8A
      C0F9B85F1481E7E26E7AD17EA21A5F8FFB4511381BF78B22F062DCCD6AB49F38
      B734EE1745E0B9B85F1481E7E26E7BD1FE52582D8DFB45117831EE1745E0C5B8
      F7DDC3EA7B4CFADFB2F7E3FBF63179EBDE11FB6D7878F718FA6E06F2CF77F7E5
      6173DB3EE3F369C1FDCBFDAEADF497E943DBDAE7B53D3CB64F4D1DC4743BCD76
      6B51B9BBD5E7EE36A0BA7DF2D374D3492565314A0B339A51E776EB6B6BAC681F
      9CD06ED7A96CBB75E6D987DDCE9C875485284310518850C4FC0D44B70F5586E9
      FEAEB5D4DA3ED0E4E0D69FC70FF1E2DF173F68F6757F6BDBD3EFF7CFFF191FD7
      577FCED9FFD21F7FF3FEAFF771C6FBBCFBB7FCEFAEE4FFE2F1B7BDFFEB7DFCCD
      FBCB0F83D2B075FBC7E961121E1A1562CBF67BC713CEBFA612D63FA6DBA99BF9
      BA3F241BB21F472FABC81AC9620D2BD583B74A4E1F8831F3689F1C747D95A2A8
      BE64E4D320E614C75FCA6336022B1FE76F50FF97FCF89211F8FFE77D7B7CA908
      ACF07ED77B3C3D7EF9E57F00B7E1F165}
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
