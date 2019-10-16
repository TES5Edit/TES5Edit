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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splElements: TSplitter
    Left = 458
    Top = 33
    Height = 603
    AutoSnap = False
    MinSize = 250
    ResizeStyle = rsUpdate
  end
  object stbMain: TStatusBar
    AlignWithMargins = True
    Left = 3
    Top = 639
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
    Left = 461
    Top = 33
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
          OnGetHint = vstViewGetHint
          OnHeaderClick = vstViewHeaderClick
          OnHeaderDrawQueryElements = vstViewHeaderDrawQueryElements
          OnHeaderMouseDown = vstViewHeaderMouseDown
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
          OnGetHint = vstSpreadSheetGetHint
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
          OnGetHint = vstSpreadSheetGetHint
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
          OnGetHint = vstSpreadSheetGetHint
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
    Left = 3
    Top = 3
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
    Left = 3
    Top = 33
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
      789CEC7D6973DB4896E07745E83F2038BB616A5A9249F0AE9E9E5D594795B67D
      B52557CD6CB162032492245A20C006401D5D51FF7DDF91994890842DD9A44D35
      B367CAA2286422F3E5CB771FBFF7936C54EF7BBE18855E34AED7DC56DF8BD280
      FE19CEC675B7E5F6E7437E62D4A8B76A9D3E7EAAF5D32C9D8CFCC170825FB6F8
      D730E65FDBFCEB2428FC3A08F4787C57A3D6ADABCF23016FEEF6B389980AFD37
      FDDBE25F8769EDF7FE288EB26C10C2875A1FA6F603A73F4AE2A917F547C38997
      A42283EF67C93FDCDFFBFFDE9F79519C0AA7E6C2FFB56B8D5AABD684FF5CF8D4
      FCE33A988AD4792BEE9C0F38FCCF7FC094AE9E721AFB22599CB35E9CB303F3F4
      686E9CB309739EC6F3241009CEFAE73FF6F760C646C922DDE54502386BB061F8
      AF038BC5493B7F5C3D4C0771486BABE7FB8D82F0D3132DFDEF8F5F8268ECC37F
      A95C57BD59B2B07AA3BD1A7E0BB3FEF1FE0D4CF73AF888CF8DBC3073FA2F069D
      FE8B4E037EBAFD173EFCF47AFD1723AFFF62D8EABF10BD3F681B8DB217AF3C36
      3C2E3E363C3E1741EC4D0749E0396FBC6CA260DCD153A677419A7E7ACA119D96
      4B93AB29C300E6A4E5351B4F428101ACAB579C2C8ED238F4523E33B8564F58DA
      402212FF0768FAC79518C7C2F978A94EAD5D864F8F3EB6FFADCE8D1618C2247F
      8F933E5DF1755F285AB23F30DE50FF4E4837098C45B84FC396C66A6C715E07E3
      4926373930E72F3BA2AFA04B704C41A4E67FD2057AC231E56F687DBF63CA17D1
      5ED3A5560794CFDC59FF01353BED3242DFE8F2B4CEC238E7F45C0E2D5B8F8B47
      BD7AE8432237D6ECF4CA0EAB5D2F19FD6322C40DBFBB5B76E7EB6DB764F4F53C
      91634B6F33EE68E5D8EA4F629088BB0339815B3A4119CCAA2789370886076AF7
      DD527AD86D974CF10AF03118CA1594724124B4AB57F07320B2C8832F85DC46AF
      5DC632D4D9D71D4330D0E7DEEB948E9307BF302E3FF45EAF6CA83AF5E2D0FCC4
      4D2ABF34D45D31541DB749BC1707CAF32E0E2C9CB549759746AF02D2C2419B54
      7571BC3CE9E278E3944D8AB9B4E5C6AA772F1E71BBDEFD34C97014C1737E1169
      066F780AE1A30D76EB9F2720A6E8A3B0A85BFF3CF5288E7B48E4C0CF138EC2C0
      1C87BAEEE7A9466128E1106FD3FDFC852D0C35CEB1EB7EFEB616C62E9D63B759
      C6544C20337B57F06D960997267CE5107D41BBCD5EC92813B83CCA806BAB563A
      CA5D18A5AE65B7552F1BA3A9B01A53B891DD56991C94535F3DB07819BBAD46D9
      50E31079A8797EAD66E9F61A8B6F5C3CBA5EED515496656F7578BDDAA348AC1A
      A48FAF577B147D95E3F203ECD51F455CE5387584BDFAA3689B1C6500B4577F14
      6193038B206575A2E37EFE422815440115067DFE4AE48324B981519FBF127A54
      0ED27AA7F1F94BA1C7E58406C67DFE62E871859B01433F7F35F2A1FA6EF0D0CF
      5F0D3DD4384A18F8F9CB91BF73F928DD7AED733CEA7F2F32A9650DB06C8ACF0A
      B18559CA18CB63E45973A27AA980F908D1B63051A9A0F95929B7304D29EF7A84
      C0BBBCBB526EF608E97771AE528DED31627061A63231E4B112F192D25F2A2CAC
      43765AD0EDDDEEA3F93BA9EF0A7D0B7394D1A965862FE7D0C86B4E534E7E9624
      009E2647DDC234A5A4684924E06914E2162629254A4B32024FB280B685B94AE9
      D492D820E73291B63053996D6C598AE0990C942DCC53C6C396C50AB9A2658435
      0D388D2FA6828559BE900A2E4CD3FC621AB8B4AFE69753C1C2345F430517E7FA
      1A1AB8BCC1AFA2828599BE960A2ED8EC9A5F86528A67E4F37C395299D3B4BE92
      B1E6137D214A2D6DACF595485598EBEB196B3ED797A3D4F21ED78054A699B6BD
      79C69ABFEBF18C55236E61FCE399AA42587378E7F1CCB4C046F3091ECF467304
      2D4CF078165A40CCC21C8F679D8B4C339FE3F14CB3808885391ECF309710D034
      A477BE8651E6B37C8DBA604E546E8F7E04552B4CF4558C329FE6ABD585C26C5F
      49D50A737D2DA3CC67FA5A9A461B1DC6619C6483F0CFFD44F8B5FE184E25AAF5
      07E15CD496BF725B2DF34BF8F5535FF304F8DB8A2916BE5E78B6648A9217F214
      75B76B7E09BF7EEAEBDA9FF7F7F06BFC7DC5240B5FD78A5FE693ACFC5A4FD273
      E51FE003FDA1E73E0ACE353CEC7FC7488DE16486A4C275FB18E8D1F7A47B0EC3
      3CF42F1811227F69396AE0CC9B39B0C37F844E3F0C6AFD04FE4BBD3AF0AD3474
      5B3DF8773A0FB37AFF2EF0875938F392FE5DE2CD609C075FF7BD74E685B38987
      1FA2F914389737CFE2BEE7FF7D9E66090AF23021AC35C47F82CC9BD59C3FFA51
      FC0FC0BA781A67C2F9BD9F660FA148274264BF7FBB45F4932C04588C86691D37
      EF4997A34700F454B40D2C264BF8B19A02AE0A8031625F08E09F83777F384E02
      9F864533638668867338FD3412F719BC25FDC7284EA61EF0FF7496047112640F
      35E72D7E851126B0D6B45E04D3A05E2360E1BF03DC781D7EE39F4F02573CCF00
      402214B722AC3D1A787D6F003BAC21E4407E2E81DCA04F7F5D05BB1B10794000
      02F5F0D3F0C18D0FBC54F8715493C08297A7B0AA9B7A6B25D47A0EA25692067E
      BD596B749BADAE33111E86D73875BC35A9BB7938D6BF048E008B1C8EB0EF4548
      C2DF5741F273F8B5003D5741AFFD54E8B9120F1B9B879FFB25F0733B9FC243F8
      EBD3A1B702FB1A0A7E9DA7C2AFC1341B560D7379BE1F64C1AD80C753310D2681
      EF8B087E9947F051CCE195C6A475E78C61E7BCF7126F0CB09C38177194D184B0
      C62CADD7E19F24BEF3FB5932CAD25F023F9BBC6AC02F33785188E667FE98E41F
      47A1FAFB28D39F06FA53829F86839907E4173E8CF8C300B60E9C887F660F3301
      4FA5B722C94002814F83C44FD4CF50FE1CC89F89FCE98F43FD497D37913F6F9D
      CFB102D8ED4698C1D6B0827AFD1328B1BFC71CC1B9F606A1D0F8D432F1A98C48
      2F5D891A53674D89735A8108CA488E3FE3E14D011B57A0F84F8AC03AA72061EA
      75B53FBF2E7CED8A75C1D7C6DDD3EB719FB81EB7B89ECEE7D7E37656AE07BF5E
      5A4DE389AB69A8D51037EF6E868C3E01E179C3CD4F207B733D34B3DE2D48354B
      009AA671A4241D3EA95EE9498D6AC555CEC3FE70E42E9C4E39495D3C1A206109
      9EA57AB35B7BDA9BEBEE12A23EFAE5177118C677C22F2C22753724E7AD0D3160
      BF5F881ACBC2C8A788DD12BC24EDABFE220607FABCDCF2F372691B0BA78661E4
      F4E5979DD9FEDE4FD76F5E3BA7B12FF8B48AD2507E22D97DAFDE867FEBDD860B
      3FDC0E90DAECBED16E37E107CC044CF4BE85E169D97DBB59C7473A0D8CA7BFEF
      BACD268FC647E0D83B344DADD7C387EAF51E72F07BD0205D7CACDEE834E9B966
      BBD55E331A48F8954BA512966BC1042557B9CD27DD5F3C8CF78960392C13BEC6
      8BE617E2C54AB653A0F485C57D6E3D0506E49633EA6099BE040B38BA2C6CBA2B
      68E9F914CE3C0D52FDCE7226BCF0C2C59D7F8260CFC2A39C629673D5C51D3D61
      FAA19EBEFB69A6BDC0AE3F0F3377D5A5BECA92381AFFF90F7A6918A4598602D6
      EFF4917F17D359E86522F08FEA6EADDBA975BA2D97FF4E1A4B9FFE8D46432008
      EA63A43EFF7D58531F22F96944B45FFE92661E48D0205FF36F336F28E45F40CA
      165156FB9D7FCBE0A2F45FD4EAFDF951A3576F38FF0B81C46F9B4F07228143A7
      A49694DDFA1EE17570D468E32DEFC0977F1FCABD21B971E9EEC30F87EC7CEBDE
      CA2D2C37828F706E8FDD57BC6A3F6EC97EEACD667143F405CC8C3FD1CAF5E80D
      2155DBD496E8A8DCDEEAA3AAD74AF6E622F137F7465FC02BF0E793F6F6A89D21
      00BEDDDEBADD85BDE117B837F8B9FEBD95EE4C9DFA3AF706FF16F7465FC02BF0
      E737DC5BD9CE60CF5FBCB766638180D017F012FCB9057BFBCCCE506A2DDD1B66
      9014F6465FC04BF0E7F6EFED533BEBB411D30B7BEB302DC19FCF7A6FEDE60225
      A12FE015F833676AE8CE726022FC0C4CBFDB68759A9DD61F2B997BBDD7EB36DB
      C0DA9F1D6F5F386493BB7FAFAD7C5B769E73F1AD43D48DB373B5F7EFB1B7EFC8
      CEF5B637B437CBCEB7962D58766ED939B273B7D9ABF5DC566F353B3F72DBB596
      DBA8756B969D5B766ED9B965E7969D6F255BB0ECDCB27364E7DD461BF875BD5E
      A29D771BBD4EB3D5AE772D3B5FEF116F88B72B8AFE7CB0767DBC7D0BBD0ADF96
      B77F53AFC2B6F0F64D7815B69DB77F8DDCF2CC79FBA7E596CE022DF997E2ED0B
      2CADC8DD575ADE3141AADDEDBA25CCBDDE6EB67A4DF759B8D5F1DC1FE358DF8A
      335E2773DF924881EFC4DCB7D928B169E6FE1D8D12DF93B96FDA286199FBD652
      12CBDC9FC2DC7BED7AB3DBAE9518E2DBF55EB351ABBBCFC110FFFD98FBB7E7E7
      5659B7CABA55D62D3FB7FCDCF2F3023F6FB7BAAEDB29E5E76EDD6DB4602D35CB
      D0D77CC8565BB7DABAD5D6ADB66EB9BBE5EE1BE3EEDD5AADD7EA349A25A6F856
      A3DBE9B5BB1D6B8AB7CCDD3277CBDC2D73DF06026299BB65EE8F60EE8D0E56A6
      6E754A82E8DA2EFCB5D9B17ABB65ED96B55BD66E59FB361010CBDA2D6B7F046B
      6FB6DC56ABD1E99565AFB7BA980FD769372D73B7CCDD3277CBDC2D73DF020262
      99BB65EE8F61EE9D5EA7516F37CA92DF9A6EBBEDF69A3DCBDC2D73B7CCDD3277
      CBDCB7818058E66E99FB63987BB7D6E9B4BA9DC66AE6DE75DD5AADDBB5FE76CB
      DA2D6BB7ACDDB2F66D202096B55BD6FE08D6DE6AD41A4DB75956B4E6A85DAF35
      7BBD9EF5B85BE66E99BB65EE96B96F0501B1CCDD32F7C73077E0EEB56EBBD72D
      61EEF546AF01A37B2D6B95B7DCDD7277CBDD2D77DF060262B9BBE5EE8FE0EE6D
      AC39D7E8B5CBB83B707FB7EED66D1E9C65EE96B95BE66E99FB561010CBDC2D73
      7F0C73776BBD76ADD12CB7CBF79ACD666B75059B5A0E97DA53C1F22848B8F05F
      ED78110A0822D8C06217DDC5BECB5FCAE7BF66574F3F6CDC62FDB15B5CBD41E4
      F00B07FFF94632DF7E97EED7EDF23342C06A01E7DBEFB2F195BB7CBA38A039FC
      37DC65F3EB76F90582C1CA93DC604542DC65EBEB76F90522C253F0751D821DEE
      B2FD75BBFC0261614DB7F2D1221EEEB2F395BB7CBAD8B069DA43146F6197DDAF
      DBE567DAD1AC16208032351AAD9298BDA36EBB0D88D06BAEDDB1FF44017F9D9D
      E0BFBB90C8C2FD77EA04FF5DE4DE4FCAF4DFB813FC37B60E2C8876DFA913FCFA
      F7F61921E0595BACBEDA3AB0C516AB8D5B07BEA3C5EA7B5A07366DB1FA12E6DE
      E9767BAD5EAF3420BFD76BC1E835B8F597CF7CA778FBA22C6779BBE5EDCF796F
      96B75BDE6E79FB76F3F66EAFD3EB367A655DE1DB8D56ABD969AF2366CF3277CB
      DC2D73B7CCFD19ECCD3277CBDCFF05987BA7D968B6DCA65BD299A6DEA9F7BAED
      9A6B99BB65EE96B95BE66E99BB65EE96B93F1BE6DE06BE5907F65E966ED7EEF5
      DA5DB751EB5AEE6EB9BBE5EE96BB5BEE6EB9BBE5EECF84BBF76AED06FC7F995D
      BEDE6DF63AED56631DF97696BB5BEE6EB9BBE5EECF606F96BB5BEEFE2FC0DDBB
      0DB7D7ED746A654D65EBED76BBDB69D6AC61DE3277CBDC2D73B7CCDD3277CBDC
      9F0B73EF35DC4EA7D12CF1BAF7305ABEDD6858DE6E79BBE5ED96B75BDE6E79BB
      E5EDCF84B7F7DCA6DB76DDBA5BC2DBDD46B3D5EAAEA37EBDE5ED96B75BDE6E79
      FB33D89BE5ED96B7FF2BF0F646B7D6A8B5DC4E89CBBD59AF355B8D6EDD7ADC2D
      73B7CCDD3277CBDC2D73B7CCFDB930F74E1794F35ABB55164F879A7BBBDD6B5B
      E66E99BB65EE96B95BE66E99BB65EECF84B9F79ABD7AB756E6713FAA376B8D6E
      AFDB6DD954B84F1DF2E737622BCE5A866E19FA16EFCD3274CBD0FF25187AABD9
      6AD49A65E5E47BED56A7DEAB593FFB57DF4CABAD5BE66E99FBF3D89B65EE96B9
      FF0B30F77AADE1F6EABD6EA72CFBADD5EEBAADB6F5B35BE66E99BB65EE96B95B
      E66E99FBB361EEF54EB3D9EDD6BB657DE2DD5AA7DD6B769B0D6B8BB7ECDDB277
      CBDE2D7BB7ECDDB2F767C3DEBBCD66A3ED764A12E0EA9D460F18BC6B8BCE5AEE
      6EB9BBE5EE96BB5BEE6EB9FBB3E1EE6EADD7AC777ADDB240BA4EA3DDAE81EA6E
      FDEE96BB5BEE6EB9BBE5EE96BB5BEEFE6CB8BBEBB69BB59A5B629AAF375A4DB7
      59ABDBCA7496BB5BEE6EB9BBE5EE96BB5BEEFE8CB87B17FEBF5E6F9771F75EA3
      570394B6CCDD3277CBDC2D73B7CCDD3277CBDC9F0B736FD7EBCD7AAD579AE1DE
      68D4BADD7ACB768CB1ECDDB277CBDE2D7BB7ECDDB2F767C3DE1B9D46ADE376DB
      25BA7BA3D7765BBD966B83EA2C73B7CCDD3277CBDC2D73B7CCFDD930F72E206C
      A7D12AAB2BDF05D6DEEA357BD6326FB9BBE5EE96BB5BEE6EB9BBE5EECF85BB37
      DBBD5AAD5DEB957177B75E6F35B1D88DB5CC5BF66ED9BB65EF96BD5BF66ED9FB
      7361EFAD56A3D670BB6595683BF556CD6D74DA96B95BE66E99BB65EE96B95BE6
      6E99FBB361EE9D4EA7596B34CA9BC2B9CD0EF0FFA635CD5BF66ED9BB65EF96BD
      5BF66ED9FBB361EF5DE4ED8D4649ADBAA36EBDD36ABB3DD7F67CB5DCDD7277CB
      DD2D77B7DCDD72F767C3DD7BED4EB7ED764A52E2EAED66AF536F765AD6346FB9
      BBE5EE96BB5BEE6EB9BBE5EECF85BBB75DB7D7EAD5DC7A9969BED1EBD49AF5AE
      CD89B3ECDDB277CBDE2D7BB7ECDDB2F767C4DE3BF556BBE6F64A94F746BBD7ED
      B6DA756B9AB7DCDD7277CBDD2D77B7DCDD72F767C3DD9BED6EABD968963478EF
      D57A6EB7D9ED5AD5DD3277CBDC2D73B7CCDD3277CBDC9F0D73EFBAAD2EF2EFD5
      CCDDAD75DBED4EAD6EA3EA2C77B7DCDD7277CBDD2D77B7DCFDF970F79E5BAFD5
      6BAD12C3FC51BDD769D4DC66A367D9BB65EF96BD5BF66ED9BB65EF96BD3F17F6
      DE6960C87CAF575268DEADF540B9EF008BB7DCDD7277CBDD2D77B7DCDD7277CB
      DD9F0977EFD65A75B7D1E97E2268BED16BD5DCBACD89B3ECDDB277CBDE2D7BB7
      ECDDB2F767C3DEDD6EB3E6367B256175EDB6DB68779B1DABBB5BE66E99BB65EE
      96B95BE66E99FBB361EEAD66BD55837F5733F756BDE7D6DAADBA65EE96B95BE6
      6E99BB65EE96B95BE6FE6C987BB7D576BBA56EF7AEDBE8D41BADB64D88B3CCDD
      3277CBDC2D73B7CCDD32F7E7C2DC7BDD6ED7757BDD921671F546B70BECBDD3B4
      11F396BB5BEE6EB9BBE5EE96BB5BEEFE4CB8BB5BEBD56A8D4EB755FB03FEFEEF
      F46D7C2B9224F005CC118ADF0B5F2999A0DE6BD79B5D7A69FEC7613C879DF4C3
      B4AEAFF6E238B75DAF37EBF0CED50355279B8561BD46B7D6A8B5DCCEEA518DD5
      A3DAB0B776ADD1ACAF1ED55C3DAAD36C345B6ED32D59616BF5A87AB30D706CD7
      7A1D3CE35503DB25037599FFD5C33A25C3B4C565F5B06ED9301562B17A586FF5
      3010EFD07BD3298164BD567ADE201636BB5D586DC9C87AC93A1B5D20A39D46AB
      E4C4EB2588D2768167624FA492612598D26DB45B6EA35EB6BD124C013469B51A
      9D5EABECC8EB65C8E2BA6EBB59ABB9655029C1955EAFD9AB779914AF1A568A2B
      CAF55632AE0C5974AE6CC9B85ED9B1771BA02E743AB59217BAB5B2FDB59AAD46
      AD59727A6E19B2E83E5825E34A9025AFC15D32AE045BF230E4B283774B30A60E
      14A959EFF4BA65E4AF04613ABD5ABB01FF5F72106E09BEB4BB3D7857A35736AC
      045F9A9D5EA7516F37CAC0D22D3BF65EA7DB73619DAD928125D4A5D306D5AD0E
      34B784BA97604B5E63B5645C29BAA8AEA825E34AD0053BA5D7BAED5EB7ECD41B
      65F852EF369B0D586D097E36CAB0452BDE25E34AB005F84917F0BA5736AC8CBA
      00D3831B512F5B65A794C8776BB55EABD3283BBF12F2924B1E25E34AD0A5DEE8
      346A1DB7DB2E617DCD327CD1B98125E34AF005B825660DF6CA8EBD59C68BEA6D
      A066BD7609916F96614BBB0587DE2913AD9A65C80268DD6A03BE940C2B6345BA
      9461C9B876E9A9EB3A492523CBB811DEA3068C2B41CF6609BAE0A8A6DB2C63D2
      CD326C8177F5E026754A36D82AC3169024E0FFEBF576D9B9B74AF00544ED4EA7
      D5ED94ECAF55822EDD1E083C7089CAE4CE5266044252B35342CB5A4D96EA1371
      9B0D42E7F78FD14D14DF457FE66F67E3197D8B1FFA01FCE3F683CC9BE10A6AFD
      04FE4B07F09F8710524FD4F8098249F1197E4F1AF838257D688324566F77E873
      C7ED0141EAD2E73A10DF6EB385E73C9D7AD9E47DC23F2FE2280322321D2437AF
      0250AAE487AB39BC619A4EBD30BC483C50BBA67E90CECEC4A8DE9F866FBC644C
      CF26FA932F46FF67087FBB4BBCD925295764079B0651F63A98C287C84B1EE013
      1E5F108DE2DFFBDE3C9BC489730DFFA4A0AB39E7D1381409FC399E89C4CB56FC
      09EFC43011A0D44DFB0F895BABF7FAD318D432FFA1DEEC4F129028E07574E710
      F29F7C08C100C7960671842B123E7C491A4D148F66DE58A4AD0EFF7217273E88
      942E89A3F0FB70E22569B7DD21B148FD7E07C238103A97278D802AF0C1DC4FC3
      28E5C3A68F75679265B31F5EBE4C871331F5D2E369304CE2341E65C7C378FA32
      1E8D82A17889AF7CE90295A64FD3F00F34D2CD3C80CA1D6880B5367F9E002980
      A39DC201840C6AF894E84F99FE34A04FE379968904902C4B5231CC1C98F22EF0
      E3BB619684FD51160DFEDEF744E4FBF1B09FC179DF4C01ABD31A7F1EC509604A
      1644E37ADF8FA33813A014FBE9433A02DCA903B0C38738BA9D8635E3AFA0FE8E
      7D2FF3E0CDC9086605653ACA60C25B2F0CE07B01F0A8F7D3497C370B412B9FC4
      A18F4A3820FA388A13310DEE853F84D951490744BF15414423EFF12D380C3EC0
      AD03FCA8C329DC87B0BCF84144B02B713F4B274916C1D773D82C68FDC3BE1FC1
      2144E9C01FC0B76406802DCD61DFB0B174E2C1B5064CFB27EEDD1F4F09A3E1C3
      841E04360B9F6F8DCFF0683066F32EFEA5F0DB049756A701F8012D8CB01E2FF2
      FBB781B8BB0922BF4E9FD2A1178A7AAD06377C90F8C94478BEFC388AE3AC9FCE
      C287EC2E0A228147A33F4FB2295C9A74069B08A349E6F97F876DF5E7A908B381
      17467DF80FBE8097F46108BC6108BFDDD12FF021C9C6493F8CE076C3CE054C01
      9FEE122445FD34F266593C061A1644431186305118DF8D0211C23DF661FA3E3C
      389B47C30C36E4A581A76741C292C08A1571E947E20E664CB307F8730A2F1927
      F11DAC391E05192E344280670F0077249CF077586C0414274BFB23818B13A1B8
      85AF87F7E98CEC20402B7C38C33BFC5EE0997AA3215C295CB537A287E7809761
      7F424F20E032A0975E024F66C35B8F6095C16A71D0284180E017B75E763FB8EF
      DF24D12C492391F5871E5C4840B810E0E820E604701F675EE6C0B2D841F0EFFD
      3B40E4D1341B05215C24C76D020F430200E4689E886C92C4590667DA0FC2513C
      F5865E360CA3F90CB5BF2C8105397DBC76BEA32E2050F248DCD7FA78F42279E8
      D4BA7D3C7AF9115692DEE307807F341189A0D138044F09CD4E349B187980E343
      3841BAC10EB19708FE14DEC2ED9A45F36132C52FD02A86BFB3D50B3D2EB368E2
      4563644251769F79CEB1E44D72B08B140786C362BF687C033E0143FCA2B14DF8
      143EFECD07C5D1ADC7BF79E054FF289BA64D0078F4323E355587267ADC417C6A
      9EEEBA16D47BCC8210E757CE04DC270162157A41E448DCEEFF032E4D2E99205D
      4B3DFA7780771FE8BCC73F81E30016E308141324FA02459979E16CE2E187683E
      ED8FE8E97E3C278427336CAD0FC46E9E66406B2719BC2622FBAA148B70459E29
      E280209485C3497F34048E0B7402D4DC5A077EA6AE0BA40D7657AFB92D5A3C3F
      54436E487FC53F366ADD3A7D1801854663510C4FF124EDFE24307EF107FA9756
      7F883793C64533638A688693C0B11496348061355C51B35B58477FD01FD5DD56
      1FFFD007D84CFA37204F002B6DB48112A6E626FB28791476FDCBC4CB5EA40E90
      6007CEE6FEDC0F32A7795C3B6EFC2F921F1287CFEEDB9D5AFD69A75606A346BB
      0446001482D16721B3BFF76A3E1E814C914A48B0504F66FF1C9D35A52E624FAD
      F876E5D8FEEC4B35E2283CA931F68C1A4EFFC5A0D307FEF6C78A132938CA1F7D
      340BBE4C1CFB88C30AD3D54784C31F77487C426E7301467C3E6EF33147F36FED
      76CF39724ECF5FBF7680E3D60E6BCED47B7006C24967F32488E769F8E078BE2F
      7C278B1D1089439FA4B1D4F1E1CF40AA86A1F0F08E1C6FD9E1FE5BBBD3848D5D
      B2E4EA5C5EBF49D5CE12318B930C76041715002C9CA197C286EE26A0ECA050EA
      48DD04F6188C4622D9BE9D75616727433885F4E72006F11B160BCB0F42E18C45
      84FA1B9D4C1C8DC200B40DE033D93C2DEE76EBF6D4ABC39E7EBD78D77C79F1AE
      D3FECD398D670FB80BC24CD46560FD80819E33C26D0EBD08FE0399D60142EF83
      403F83EFE2103683A080E7E8988F448462ACCF470B0419F48279E8472FB22DDB
      7E55A324ACFE2C4887A07A1E003CD4E572CE126F1C478338898E453AA5ED4FBD
      1BE1BC8A814038511C1D79E37102F8C01ED767B1B7C44B2788946F4F7E7EC327
      0484D043638323FCB17082D41985B0ADFD3D18EBA5FC25D0C79B436730CF9C6C
      221C7610038283D64AD719BFA4E7487F4238BDC89C308E6F9CF90C7087690180
      04F83AE81AF4E6DBC0A361E738EC354C9F3AA4FC3C1330FE0C4ACBDF4063BAB9
      029DF7545E79267540C61EE8CA030907BD0BB1FFCE198A2443E95151876DA304
      65FBFC0916358C910F552F80465F9E39FFE1746BB583FD3DB8E8F850EA2071C3
      7D8208EDE3AD876F1354DC1E1033A6B10F3A339C2DC8698E1F235E4CBC5B4147
      3FC6F080A997A26A0988E6C9CF5B0699FDBD32D8007F4622E191F4C91B75BC11
      EE06B6887F998904191BDE23A7728ACA3580EA3AAE38B37996F24D3246F2DDBA
      4B621819C61EBC2DF1B70E1AD5513C8F7C67F0E0F828EDA2D912414157C1F9F5
      04042CE021483E1DB2A7A44E0A62F19018E3E29157EF707622A8484BE149D0D5
      0E9EC77E9163FE06F82D71DD49E703BE0E7C6888F9C8419FC76682E8EFB007C0
      D2C51B8D940B4F0E88386CC84FE2195CE1BBC889478E2406417444B64CA0FE01
      7003AB73BD09A2387186684ED83A69EFBB2B5EEEF756BCE0DA365E5EBCFDF937
      E702441CA78668FDEADDBBBF3A53A058A953B91A2620CD56B6ECDCF25593F059
      F9308FB2602A60B1C12C7B9FC4289A27CEFDD5B9730E225644B2F8EB785C71BC
      5B2F08B750A8FA40FCD4215F86263A7014EF81D102EDB94201E12EC826CE681E
      86CECCCB5060059E813C71E420062133091207030CB76C6F280F822614875930
      7326A03CA16EEBFC1C00A3074D693E8D1CB67EA7965602A840AA8A80F1BC87D7
      4E45F66DA1F23570588309E82A065168A6374ECA25D97FC43000358AF42A0F59
      B084D19D87EAC4DD0F5F80EF2E2DF65F9AB534BE96B5AC8651F3B1403AFA074A
      C02830690DEF8FC7E00CA5A23C1A6B504D5A9AF6AB579E0E1FB5D4A7A1F73622
      E9BA21879AFEAA7387DDAF179C1B39F7DBCD1CFC6E1C3D921D5466D130569C1C
      C305B6F3C0BD71682FFA971377B20A3F97B3FE87A5E95F71D478BB9FD7717B1B
      3BEF1D56504ED98C838E2D3270A279938C9BBBA3A59CA4E4FBBB272DD6736649
      3C08C514759333EF2E1ACF61FFE41AABA6423898C7178429A831614CF118B344
      DCA2335BB9760F9CBF9D9C8226838E92E4868CE7A0E01B16004F3A11F7F7E8FA
      81DA437E471C10FBA4161D3ACA6CEC0B19EFE1A5A998C2B2D028900A3DDD2889
      A7A860A5308BF464166D0877494086E958BAB5060F99F254DC890427F2A40F13
      FF4A0BC1A5A36D5EF8CAF17E3D095278328523649D4D82483AB6CB5C89552FF2
      9D599CA6C1207C70627841426F480FD4C4BCB7004DE3774E1CC153AB60664006
      5FBE6EC25238E44D511802E140A0D3249E274A11C64858B4C6A1EA8BB620D750
      96AD12BC52096E7E6F25F86D8C24F20DE0E91B89949B508291AA6060355D881C
      FDE9BE0F04DD90D92C0C3876E6FBDF8827EEAECAC404B7213DEB57F13C744EBD
      2089A4C9D417E9300906B041A2B45FE2337B8692D9459C0C45396EAD49380BEF
      BC875422D02286013AE1791458533518E19709F3062F7AC826E4EC8CF9B183EF
      24453D3178F491A19AB0994D046BBA3B1FACF9D7F8E822D0B6935D902B551011
      0863F314EDDF5E7A83778AC44CB475C30D4AE733721431A6489FF514483F4904
      28B6CD53BC6CEFBD2C1131488F91FF12C6BFF71EDE7BA192A32EB51025C52DF1
      F9A99D0148642074C1A3C154E0BC4004A26C0242981F4714F8975204139DDB21
      FA7B93318A99818C7CA190B961825E719067E02C79A108F099C0BC27A70A0BC5
      1978B10778214E3EFE8F5CAA143C37FC9D63B2D0D0046F506153FCC7C13CCB60
      DF924F64F1CCA103C5109C88618BDF4F31F00803518E77FD9AEDEFFD081264F2
      3E16203DFC1CF822DE2187D30911DE0A6FBBA27067E2A1EC0D9A0A471B3F1595
      4876BF0B402389673889F3DFF1FC7A0EE23B081F0F288EF07DE26B267D5B43C0
      625C0306A2E4E76191D306EC97E835ADEF1D37F26FED4653477DC9CC66E7BD00
      D9F01C94D487598C7EFE7AABB3650707CB6E63C8BA8A534C29620414256F4CAC
      8EB8D4DFE62245A9ECE7372767D2AC004C4EA418AA399F61DA2A9B3FE4A0534C
      F8E638DF2DDB6D599826D39E444C0595B572AAF3E8CE8BE0B9F001D8EE025D63
      E3541005D3E09F0276A863D8C9F2E3013D1B8631A62DA04C009A1A86404B9B11
      C6FB6F5B344A79F0EA2FCAAE95624826A93240C931EB18F49CBB60C8113881F1
      4C0AB811F9870E01135554B6D829A594132112117953C4B6639C8A4D5AF8E674
      32CF307670CBE053069D5F29DCEA633447E3A18CCC1511990E5FBD39BB465051
      A02E0A846214441C2A7FEB2501865B3929208F53E5B407A552024F6CB089F1E0
      8B9CA4DF074D4EE330F46624BCC2DE257940AC47B1B44AE0A11BC2B1D02FE196
      C518FAFC3285C97010C7FAA60764D59B47181BAB43E18364389FC2AD8930AF89
      514A62145A744138679402022B35EA54458E13BA624DD86D0B8F2E0764E54C88
      19A5D720A6BC93E5332A446A29D8763811C31BD3163E84DDFBCE3889E733694C
      C68C0A04052A4912B04C7A22C1D609C0319D3446621CAA25CF25EB862812EB49
      EBB61DEDEF5D4688516BB7603B37E241C9CC18E347D431E00335D54D4C993ACD
      92103F8FC26046032A17F1704EE6109DEC0722E9944C9B3027CE5701B11AB5CD
      677284BF5E5D9DFFE69C9D5C9FE0067E39B9FE80C06032BA655BF8046794B605
      38A2A938A4930A86A8F097E94694D0E23983D0830B3C807FF0CE02B3A8C2DDC4
      BC26ACB651BB837F1FFC06DD5D2661F7CF24D7E18A9359D67D27D97EBEFE5029
      80EF0696BA89C819291D295BD6F9D51BCABC2314818BC4D6A219E0E7BBB7276F
      4CEFA5725C92EF1358C63FE60126E25575864D86058352637EE91A153A3E5CD9
      B95395AB046F7F26F8B8EED305F5E80D33D3EAC1261052F933BDDC978971EB92
      75AB5C1BCE9194B9607470CFE334D05219010A8D391D1A304F60B11F90F52281
      99D22012037723E106D9A28FEA00E95C5356BA8C8CB094307F3B7367CAF2C0AE
      CFAF5A2F89EBFD42721BECED7D7CC71960573FBDFB28739FE988513A0B8371B4
      851919E5696E32F384A2D5912045630371B3C48B5290C349E951984CD9C3AC10
      A5F3E1E4F9ED14348F8BD757D7EAE8E0D8FC20E58C761A46D6AAE7B1ADB3F92C
      0C8668C3A99CA23A01EA39A068C5F9F1C3C7F7A9DA20CB4198C71A47472338CD
      50AAF406CB618D0C4EDF5A69A54A0CD8701A477E40CEA0DDF122ACDA3D79D7B0
      5462887EBB09C5EEF09F38A64B782932018CA7224A4175C686995347AF9670B8
      D49EB2FF1BD33245A1C429F9CEFCFE1D3B2791548E167D18E87BE7E021584C60
      1D0BF9A139274982621F0921AF4404CCC851C50B9CF749108360F980403E2B10
      B91D406B768EBD637CAA7C29BC2A8BA85895BBA618D22C990B1DDE27EDAFA01E
      4B24864F7027825B5039CDB77A2B5E8856485E0C79DE804105115C1910301FF2
      BB62D17EEF8D17CD81999DAA18CC119673D494C517B344206FF47707CDCB2152
      7D71329B01FE5C70A94794C4D5532F0E9D171F231F8E37E358883316879C0F62
      2440A200311F1EC13FBCF880F65F10362EB1B21E081E64F062EDAAA26C9B2F08
      FA6851097C817A6B3C48639A5B69AA587328014D889686D8FE82EB4B607021AF
      EA056A4AB098FDBDC8E74BA0A364A9DC8AE74C51F718A3CA4B221917A0C899C1
      9B38C1D730EB218578803AF8E27B94F2C6D255206FAC8C637A0B14C38F8773F2
      A555B1D809C6EDCD42727EA34D9BA2F30EC9F8475E14E1C1B169981FD81BBAF7
      2BD6D1F94D829D52A7752D9DC315454518CBE878307080EA063957F3011CA72F
      764808BB266B4E0A1B9F2A8D9A9C9C74291065F136A0BA49C5CA840A3FA28A33
      083719CD21EE050968BE14D6A4A11AFE3AD3A1D63AD02356780CFFD25B0F9D87
      784E6F23A71FE338168C3A1E1F7F4980F6BF740843FB7B8730E0455B79CF7E78
      9C410DA3981F6D5203651AF1717591AC6340BBF53B623660F6857B767ED5A48D
      FCEDEA7423CBDEB26BF215F8F124B85E5D9D23589F316EA0DD8FB6F004C4785A
      22C056A2462E196D022D2EDEFEACD142E7DA3D1B94B87847B4E26F273B85111B
      42064579E925061E3C0B7FA1226F3B820845797CFDB8202F16BE06DF822F41C0
      EEEF3D27B270F2E3EBCD62C30EAA3D5AF1279D5F8667FC12443ECA2FDE4C590F
      F0DB37E86BE43F1DA29E4395D44063125ECAA92642B05B8BA345B5198F9A0570
      5C3CA683F06C4A03B20AFC1EDDFDD758AD142D46CB1AFBAE2027BAC14B2907F6
      B0FAF23233986FBE7E4AA7357C65E2A258CE2C1E0BCA452753DCFA15C34F96D7
      D85202BEE1EA2FCBA616CE58CBD041A06228984651FA0C7BD864A008079E6B3F
      B5CA4C8D23E9869B4ED1608684434D4ED6994D493CC8E116CF384762994EB0C9
      5202BB4E89CFEF839D71DA5DCBFAD92B2EE53AAA7B0900E52682FE1E43783D23
      3B969B61A08B81859E2ADEE095B6F1D7EFCE7E14F0930BC31E20C9A0D0545925
      051E455FC790DD8498C522AB9523A9E0FE83D20F390AA2209D5817221CD739A6
      2C78E1AEDC290C94274FB24E9046B14E0261C1B95D2C542391995D011BA9BC21
      57A1F8CC46640725EE6F4AFC11BC87F5AF1D4E4613167530270E272AAAA24DC3
      798274041B33C818BE60A4CF16F3DB30DE8BA354A5BA03CABFF48E8214410209
      25DD38E8E4F5397D30274FFA6102DE5526BCE921FFC8935C8C84C2448C03C0F3
      87DCEBCB752168093C11557EC657338AA96087394550522A0528746A072F52E7
      0CAB3CE1A0E36F5A4A614B49D705766098674EA7BD3BD4EB0C93F164F418F13E
      22578C758CB0C32127B052782336D64DB9EA846E3F85B85F3FAE1D3709F3F053
      0B716A38B1FA3E55ADE6BC3E104C2EDF5EBC53311DBB8361EF757937245B0403
      95EB98231C66F1FB843F850730C4AB2085A946597958231740013A37A614813B
      AA2C84D21B17243A76AAD7F4950E2B4FA63453246EF7F78032A3D35FA70366F3
      847297E3D1882327F00B993802DF49DFBDCABBE46C112EA08519261905A87999
      32B365C6B3AC5D72EF13DA22B73DA12C452A9B3778C8FBBD88688C619E1851F4
      D7639564F22ACF93BA8C46F10F0574C237C521277B0689F31EF35FAABA98203E
      79008FC8E023959F3B8D39A97D7F6F221E28C6882BF51DCA9CAB2095BDF46E8C
      1645CC89E44CBEB908678A3502F333E5C9E033CC268E311EC21B4E02418B0CD2
      C3E2FA8D84CC9473CC90F024BE4C6435B6C5F32D823DA6D330ABC150583A837A
      21E83505CCC8B84D5B453F55D1A18738D935461E1206542EF030A741CA857360
      05C5278169A4822CA400EE542432E156C33E2FD3472512F355A1FC80E885D607
      40AD1CA30FCC5DACCA14A15895FC02A02D979B23D1BCC33C6CDD39BB3C796D66
      C892E2428807FF05B7AA069C01DD5B6F7F2F9CA3D6A4D3D879002176A6100536
      1DAB0066967E4EFFAA649EBCA30F179ED48340AC92D13506B21F9841F3F2E8E1
      CFDC2EE798CBA5A884204A74316373A8F9F73D287A229A2B1B8E6CB453E81DA1
      8CDA3934530D4E056D0C4ECB4D4B061EAF889146837676174BCC0260C59C9E4C
      28098002244F0C7C139A04A801779CBA2BFC83F59B968E10C7101536E03A395C
      FF6ADFC64F5AEF9A56FBE51666A407785536B05ABC401B806FBEE2B53B83AD80
      B787B9A61F594BC3A0CADD11EC38C996394F8A597AD8E29E529F8CEE6E81510B
      58D2E28C8381A515CFA19A5728C0491AEA934494B32C319DC5091AF4A9C3AAE6
      6EB2CC8331FFB1F403E8F45EB2C4C81CE1B12C3F49220D75DA2B186C505621A6
      A2DFA696104747BE98A25F6E958C76AC6C85210A710F8B36432D35A19C02EF26
      90AD5C96BA480636E9D8D4DCE4699A27B1D5D3D20B318D59F06BF419A4CCAD95
      9C1C019F5C7E3D091BB37932432B270B7E0A3EDCAE51255DECEF45946B7DCE32
      EA0596DFD2FE610D1DF25EE0DB18E6682A19B1204052904C5F3D762EE6091971
      9703CB3383F1EB60F2C5171B925222B88C044AD3691E9ABB084F580606E18238
      82E59AC6B1942F3952D7CB74ACF927DF062F99AB729CF0DCC23BF2305F11D0E6
      64B46F906DC2C8078BCCDFBFA1904B6DE8A3BA4ECAFAB4764E95EF6383DEDBDC
      D667E62F9D70763FD5CB794732FEE7F3928C8CA4774B194986018EEE3EDF4912
      FB52AE1F80FAE18A7B5835AA69C8790FD5104E385D1CC46FA1DA0754991DDFA4
      B5465A23602B69B14B886AA6532963A1D249D886A94B5CA9C25622CB28A57951
      DD92B3E81B9B0C79925C585F3BBEF0A161F3BB779B90C796716687A59CE341EA
      BD3C1E78AEF313762DFEB679CDDF55D059A8C489BD9D8997AE90A6BFB66A0AC0
      78ED58FC72EDB55D0009361156AA092E263B63761B25405362989F331D063F1A
      2DD6BDAF575727306C033A73A1F22BDB3090A9A40501F4FAFCAAB1FE323C9B40
      281007302B0FB81CC9757702D88657DC0C899A32470A331AC53DA9062CE271D1
      928B77EC2EB878D769EB073683AA9BDBBF117FC4223609C32956FE08D274AECD
      D1AA80DF73395F16DA396E028E26F19CDB38180A5554CFC37E0E63CA84636F65
      C1D205F2D1FB1894BA89C2EBD601DC5A2E9B61542C14C045448ACD61E299AC5B
      4822264A0B44722DD3DD3BBF9F615547960277C86544B573E4AE0D43ACE14447
      D99DA10302B937909666146631A3F936E03A8252D9FB2B1ACC3105196B6D3B27
      7021CF50EFDB7904BB9AC0CBF7F7A842E6D54C08FF155538DF21447BC74A4DE5
      E3A57325159B0AE2D3A144B10A81E8A6009D47577CAF28B570210AC854970269
      9CD18DC7735FA1E9D9E099B9003DBB34A94E221A69164B2506D359421565B92E
      008A52E8E523D38AD60AAF001387994AF12F6880091724A03578F20A2A2791F3
      930867CE4BD908003EBC15F7F3F44DECE3E71F83ECA7F9003EC8CA90F049B599
      7829BB2FBC94CD1BF44E6CAF97FC2D65BD5EEA3BDFEBC5D6F92F4B92EF7CEF24
      F9FDBD7F6BD7BBCE91D3386E903C8F185B734640CDC8ACCAC6266587E6067FA8
      01C9A2CC53E7F20C04CD4122BC1B0EF5384A0447F2C2138740FD127C74DBEA6C
      C29E7BD826804BBC0181C3FDA20273675ADB3E9CBF7F7D727AEEBC797776FEDA
      B9B87C7DEEBC3D79732E9B0A6CD996CA6AFB7A19BA44F07B7E40863289081471
      FCCC75EFA6C40773F9BE20DC235A0C132FDDBAC286255BC682C42F0139EFF06E
      4F63740D487EE5F831996D292406B6D96E0E82E77290AFC518EBF16374041969
      2903703E63CB4A8D0BF073B979D25F878B95FAB67D7FDC80E0FAF4E2239E0C47
      91E5693E1CA45BB988C9F3F77156792EBBCACBA556DE63AC4D82CA0C08A979C1
      401D2A8CB56B6699F3CBBB77EF8D409667B2D14112DF884D5948D66EACDC9051
      75FD961CA2BB827DF4CAC71D2C74F51D07EC5C527D496421B0678238B280DAE5
      F51BB372B047A5D9400209A2BF83A643ECCB8CBBDDF65D55CE022F8CC7CE753C
      0B86150E44FC254E421F24C1A1A8383F72F483F4B6DD62A9A214291BEC58DCCF
      E0F167B24FCEBC9265B728F0F28A6ABE7D1043D48D2555D85656BBBA84B06A6D
      4186A920354A4D2ABB942A60EFA9C85959525EDA5043C658B604C0255E1103FA
      3C2041A61025FC4BD9298F89197AC38930E24AB92B840CA4E1D27FBABFA5D1DA
      65CBB6BEBF57B279D9286B842D4B601FAB03797D8A5A61C3266004BC5C9A5E38
      F348634CC4F5E3F25E29A044C432F1086E0DCD560805DA322895C04839465825
      4A3795450638B4FEE800D46DD24DA4CF0FBDB43C0066316EF5090BA6766BDC2C
      87F535D2D21F0FF2276CE132CA40DD487428DE26DA7EAB8AEBC01A9CC1374DE2
      DE522399B4ADB2997A776CF8AF1E9C593C9B871E263560F50634DE17ECCC8BB1
      5CC85266229EA9721033CA67D1418C1E66721E614E866A5D6C8ACC30CA27F315
      7C2DEDDB3BEF48DADFCB1D0128AA4A57C060D7DC49146CC79E2369F944FF8E72
      ED1C9A4E15E5D3F914E0F2724D20E30FE29013E4C8488338F0DDAA0D3C2BF749
      CDBA4FF6F2F2DBBB72174F405DD69BAEE445C727DEFE9E0A33A358795F45B962
      AF5BD9D05B4BE1589CC78C73E5FC8262C83DDA5131F71FB3DBC68937E5289663
      E795ECE1A43CB195B31823CED9EC1A652079C974B60A3F3788EF73F91E84CB08
      E5273DF9684E015234772AC753EDB61585D591DBA954B9EA400C3DB460CB7864
      F893CCEDFE6EC5D4DDF5DC0BB753722FDCCEA3EFC53579DC81129FA2B71D04E3
      5DB91E5419D0B97E77AA242423A62114A3C5900603CBC87F50A59805727601D6
      DDE4D1E1C68300DB83C5EC15427E10BE2678C13C6709FC1A25D7AC8E9CC5737C
      D369180C6FBE5F05B527A9ACE700910D28ADF29CF0E4396B80CC0832B25FDA9D
      649A96362CE8062C810FAAA244099C01692161B1A78C5A98FA85C9D546CCFC15
      6A9D4E5519320058519C716AF5DD8A0939D9C0E8152EDB25ABCC5E99EDEC8DBD
      E0BBC9DD5B43C1D856FA4D4BB77CF7AE43B2278828141D2DF4703688109A618D
      F48D75F7C17C7DEDFCC9B97A163519F7F74EAF3FBC86E55EAC7FB964E2341BB6
      08337C77DDD5811BEBDF80A63064B0A6B83B2CEA262DB73742CC52B9358A5B51
      D170CA480B3F533429C429796437B5F3CDB084FDBD7CFBE6DD7A0A00D4CE95CD
      5BCE43809C50C35D042C566E88A4607AA8530A53DDE0596618AE9E428EDB7992
      FF7FE378BA5B04FF9F31625BE2818AE4254F25F9082E5D3E84CB77E89EC2EBBE
      9F92C0D60E9D3F117A1FADFDAE5A43E3DEC74B0C9F9EEE4EEF2A56DCA3BC5E41
      2A8B9D52F52A109E0773748D02DFD2A0A108F30785F694914C960E998E9E4D92
      783EE674BA0A8DA87089780C355769BE0F69860DA7F1AB6A308C23555D674143
      3C2844BDDFC972F180FCB78147DFAB45B1333C32B29ACDE4FD4F3DE6503C3B16
      72F5B8AA12162318155516EC8E9D5B6960DBB14C17E449691BAA3A91F92A36C9
      D2686E71980A3CD04CF9555F939FACEA7BC90D020E9911C021C46FB17498AEC8
      C5FACC193CE654D55FD5D372B0F930BFD0D83FBE5EFACA1CD8E90D4219D32015
      5FE5C258B2F8592181802AF12314D42E806F4FB88886E2A47C94727AF6FFA9CE
      D35361D3ACC81602E8E0DD6151080C43A1A6EAAA87E8300EE379B22BD4667F4F
      56B5E016C5041375DBB4B84B1071D22181AD3AE0CA162CC0453EC287E9402A9F
      242739C98C1862763F0BF7F78261801120FAFED2091C601AE9866E9CA7BA5E16
      8DB7736E4C118C02B495CA795EF2F8039E0F47E633E92D0DA80CA62E1BCF5FCA
      24F1DC1EA64818621495C80931731EA0ACD10B9DF2735B27737F4FC627AFB87B
      3BC3EA41DACD3E995A664695D1F55451DDD28A2BEBEDC5E37128633EC9EC1684
      B207B27E3E8BE350DE5239489AD5E08600D361531D30A04110C96A796CA5E563
      A144F62ADD0E3E21BE5FFAEF27304B75E9CE188D9C8390FD2BF9994F29777386
      C5D88B49226608D51053CDE5CD6250C840AA43298264AC9FD273D5C2725F9A8B
      3B5093C8F74B40E41AAFBD8E7B3FC1128ECEDE5F320BD89D1B58607FAACA0EF0
      A5223C4C6152461D032661516DE46AC05B8459FB4B9B57E80F2310C8317009D8
      0588F0942FFF9F0E80ED7F2AAC54DC5395DA39D675C9C3601A64BAE9802C354B
      B8ABA20A4045E648024AE28849DE17E182D487EBA07B525C22A07EC6861D250D
      DBBB403851F9C99B0EE6C9185B72BF015562776EC38993EF9DB65E2909A99276
      9812FFA1A11CCA8AAE7216A4F829F51E07058D8C32555D73FF40D27ECCD8A14C
      B308E02052DB28792107B4FBBD73405FC7484FFE497469CB0E47753F74AAA00C
      537DE628DBB66452AC5FB6654BDAB982236FB0A238DBBF322C554FAC953860A4
      1A8A05C026AB7F21FEE90B205BBE8C0195851A48A6CC5B7B98E51B52A07F0F20
      1F64790113AABA60DADB38BEC7F2DABDF3ABD7CAD0B93BE897DB78B9A8ABB6F4
      226A204450105D554AB76A14E0C2BF1D8B34C48A4DC05503AD0F620D106970F1
      64994BB130B7D6CDD41728F572C7BC54178694F5FCC930EA3915B2965430ED2C
      CBCD2B94C3C3E5E4B90E3B22FF6CA6865114C7F9FDFDBD43796CC7CEF9BD4702
      681898D563556DDD6BBE261E165DD14239E9A7FB7BB2A10DBD703EC38F6EABE1
      54108015BDF46AAD4635FACF58436DD67A6DBD70FDCCC5794D3E767E717171A0
      F6299B245009FC2C98168A5DEA33C9936FE1E60F33AE7BCBF5EFD99CA45F83D6
      78FAABEC5F800B557F3C94079BA4405C827190A54A7292C5EC9114BD7D774D09
      6361C0E1361EE537FA98E43B0D2261BEDA8B1EA6F00E7DAA463152B4A02381E2
      125F6495E34E0A1C7843321856F1CAB16E9417F0E7FCADE90C583D2EA18A540E
      453B0CBAD5351E280C2872DE0D30F1F2F2EC50D57BA614542FDF616096EB3F04
      1DE87F10F4352A819E455E873C6D35D75756A0A989C1AA165D89E30F2BF7CF74
      82F4060AF05F8E23003FAC6423DE7A048EAEAFACD08BAE17E1145E484C15C335
      280B8A3E4DA5B72E108AB543E07D2AE67EFC58083C31F3A70801DC9B81940580
      F015941041C4D7A9978F808AA43F58EC21E5C1689CE436332420C88C46224126
      DA49CC36499965EC7973ADDDE3EFC6DECDA2EE4633232A11AE6E2B869D6FA052
      3896DADC7C2F40D92D494658ACBB44EED128EEB4BF5133402A86C64C8DAE3812
      02DC9D9FB74C3B763EE8A64AE487974DAB2486ABEC02925DB45D5D12EA072661
      57C48F1FAE827B6CF3CB70E33FB3635FF75A4A35EDA2CC47CDF0962F16BE2D37
      47723EB514BE6671801D9F48BD891EB063615E2445F50844A718D7AA0FE3F806
      E5A0156BC4374EE7C309BB15D05C3FE4B2C8851A12E4FA933528D47A5FC148F4
      856135650F16E34DA9BF1CCC43657538562C652825B27EFE08059C6CA22A4999
      47C010F6617DBAD333EC8CABF77D8CC86E5A716E3DEA6944FB5E68EC6349F3DE
      87BC9DD7AB07E7D4232FCAEE50E7E2F6CD4E1452E3600199CA15F8B203307F45
      3794C331B898014BD55483D46868960819A3C332FDE987536D18E5A6E458E200
      DBD5C976A01CEBA82F0CAC8FCDF1342FCBE9D88D8ADE0873C20567BF1746DC24
      022E744899AAA80220CA474E0BF49B852E60A445C674B70A942BF388C6E5635D
      5007B0D850215C475E6F074B94B0E790D6A1E1B80044DEBE6CB382C19F7467E5
      8B0FF19319CC4D3BD45438753E7B3E52AB2DBAF6F99D2AB6B4FF3B4A63FD3F88
      7ED1DEA5E66CAA5E1C80CA07ECA92698C4AC33CE0B1E0151012E3DCF50651BCC
      B96D8DA252329A5569CB8A9A52733F55D49351A8B08568157C4D6C522AB521AE
      1F03A8F9110424C52D71AA84D1150E26AE607B57B573BAD7A2C2D80A4AF7DC0B
      392F8727A2CEB1C8B928E34CAE57537138E7E5E5C9C0A232258B9AA46D54CD3A
      8357D2AE36A166FDC5AC43EF07299E674AD76528AFDBE6F6F31AAEC966F6E453
      1222091E268EE5D671C66BEA83825F2A9965737B45F3F726F74A5B31F72A09B8
      A2790952D7B56FEFF487FEEF78A5FA7FAC5F58FD0B5F5629A951C04CBE3D2BCD
      BC81078323E484DC7E541D34924A654B02EE58CA557645F041422E3B72628727
      430C30FAA195F35E7F4ED62599B4214DB322C10738FE6D8AE7C03536F028D2DC
      B2C7711064B7CE5B9953D1570A337AFF11DDC7C2A89C60B4013534071486B02E
      379A7F69196806360CB53B7C074E0C6912C12EE54C903C1BEE2EE23AE73BF3F6
      A5E86D0ADC24106AE1C7CB83F094986EC8414E6126E92BD046473587BC1D66D9
      452FD272E08A5A601669F72EA9723D40533718A1CAC1B12F66F8CBCE590DDFF0
      A5959E1A9524A72D4B6C8826C15F7ADC70ADD89A2DB7FD9CBCBD02B83A5534F4
      0C1E4099010A8DEA65020A004638CB1192BECA148154D7E4D31DCBF52154D19B
      C7A50AB33BC1819A3C59AAACE8B0107A15DB5C0EF04E501C99F35EB5C4BE85A7
      555029BBA626208F52114B8A7083CD99DD84B838246BA50644D8041FF828E471
      FB46E9AC834D5FE62BA6821F461E44F1AFF2828718C2229F283ACD8C5A1CE847
      A590F1F2F9587A56D5A2E851DD384C95CC96F905B2F2DD30F4527C0C9B5FCBC3
      C815AD54F5BC4E65CB528C9E4757AE6E458DD6B7502972721129EBD754CB8A36
      F1C2EC421E441CBE404E4095C8499B50FADC4AD8BCBBDAF9D4CBFDBD2B3A2175
      66BB4389AEA98B15DA198C089725C475A8D8E7D8432B13754B673CB2017B0B01
      7BBDEF1DB0F723F3077D6E47CEF5FE1E511B3C62692BA7880C128CB0792DD014
      5DB8130D2314507C884E5691608BB728F78A52A0003C9BE8E2A5CAF740F5CB8F
      B70C1DF6F77E7E7372869A1076930A18A3B3879990E021E36C92780F39A623C0
      085C649015F7D8C01A7BA1DD3C24C194F54C0F1D499C86C9E63986B434D329F3
      5ACECE14E3703CB435654144610EF96DA3680F0CD28EA5ADB1C02AB605963212
      14F9778E5A1AB1968180164D429FF5D7CF39966FDB40B50B923EEEB8D49F3CC2
      206536897BDFB643B94EBC2805842483F4E3CE650139E5BD961758C90514DEC0
      8564C79CC6900AD0D42FE0BEBC1B608EDF2DB52E56EEC9064B25EA574AD50766
      C1B14F8595C03B45083C44093B7011A69891E7739B498C68E325B284B6EC12E4
      4518D731C29200B2DB3195AE82FB15CE29A5387A502767C0C7A92A98C81C0B36
      E917015482BC70FA5FDF0DE0BB21EF817252E57FE3D612E82F081F96B17C07A4
      9F457669B89C0C144515448BCE30BDEB5449AA3E725E83A61F39970786150B90
      0934DD24E1446D6E91BD761BF470762435C11FFE43ADEC3F37128F45E2E1BAD7
      FFC4353FAD0C5AAA8A21ACFFF2CEB3517723E1355E8E5F6C2D3DC68294BAE945
      32A51BCAA2D70065300E5CA7D80F896D8268A0BABB8B820F25B62D21B6A47A40
      7B3F5E5F7449A84924615041A8C5D9297266D14E91CF2B6B15A439E3612F39CE
      CEFE4CA0C92CE6E8FDDE2DF48F2D46C02C8B1DB413321BA007C04CD5D6B6A588
      E27A39347586366CC9D69042D2DFE4EF6BEFF4F214DAFEC48B48D4DDEAE97BAF
      E521EF908A6E483C55E4D857E71C4A1D873E8B3E662A5DE112F06D41296A1CE1
      25B2FAFA82BE5E5F5DEFFA1B2AEC30FF201882280143DA5B763C180B81C4FC88
      08F8B62DEE9F02D405825B6DCB96E67B11F648A7B5B95BB636118DC3AD5D1CA8
      79DB0BB9113ACBB7746D63012262B4A56B4B84B8E1A535B66C69937934F69240
      416EDBE808B0A030D8D663FDBB37F3B6973B80CE7427C65B0BBC599C13E16DC3
      3AD4EDE6E3391FED16C22E99A7A93ED8FA962D0E04CDEDE560E99DF0B77671D9
      3CB9D18B6BEE987677756EF5B8AFD2E356C73A7D433D6EA55CBD23E8AB1C3FCD
      821BA8D3B638FD5538BDDAEAF64D71FADBA3F3969A1DCFC8054985D5A4DD1A23
      BD344253AA0F9774234BEDEEDCFFCBA504582C31C10186125214C1C6BD7E35C0
      AA98C4095F295719E7B8A904271DBC86D7C6F106F0D4012640513DD707157D5B
      80B8539511BEA953F9484EB7C29F7FA8AC4A7C42CF0185971F189179EC01D1B5
      CAD01782A5008DA84574857054C7F232940B702622F6277B5C6B161B2F2008D0
      09B276C7C3AFC399F2D3FCB609E7432A869CBD28CB8E535D384C0556F575658D
      97409770FB04E6E7D89DDDF7EA6DF8B7DE6DB8F0C3ED34BBF0A3D16E37E107BC
      B8063F5ACD1E3ED26ED6F1914EC3C547BA6EB3C9A3F111B8421D9AA6D6EBE143
      F57AAF864FD55D780E7F363A4D7AAED96EB5377BA5D6E164340F5342530A177F
      41FFA3FCEA06CB3CC6D15FDAF0BF5DA136189E9FD761A66036670ACB419C5C7F
      3D820D3A7B61E98111FE5EE5624EEB8F9442E4D884873D7A911DCAF819A0B788
      115CFFDBC3AC4A93961AC7953B7CA95637D754427F3008784321030D0C3F38D0
      605F2401260D103B50ACC3FA4051182136A940B22BF75F5553533D0765E08192
      1AE09BCA3953CA8A53858F15E2D65A3BA122F4B9C836A2F027331A42E3AAAEFD
      3E9D52C82796A8D850244FF8C37FA8259507C3EC7F7167F86359929BEB94A459
      6056019769A67491D3BB20A302E366C4871153C1F5FC29ECCF283946F152A0AC
      4D6704FEB128E696E8D15AA05B3F8DFB0F0C42F9CF6390CE37135277982F3E50
      C107CE8D7820DC7A3708652CA4AA33952E3D4371881834CCE132967EED2D05F5
      EC1A012B6957B1322D8BF4CC4580A98A67AAFC784ED5527993B9CA6182ED84A7
      8A78E9941F59D1B750CAD4E4DA23581216F95FFD72D46AE6912C5BAEC271A863
      28D3638E25AB9251F3E25D530607BFEBB4D503B8570A0993D723A39A0BE27E28
      808C4859F7F8C0584F01181C60C6D1AECB0197949F46FD9F65D914DC1F69663A
      1F9932C9280E4C96D67C6E7160B9EEB9B9327FC7B916B28956B59845B7BFE71F
      3BE2787CBCF6C573B4D4FF93C2C026B7B2BFC7555708C364BCA62A9DE93978EB
      42C1F283463F5FA4416208C4BAD8D7EA8B7E275B6A04A9C98C33466F92A21989
      3142DEC3CEE37130A408C7272815DB10BFBEBFA78A782442D660D286A31C2C46
      55D53CDE7A283BA27F19C1DB6146BC2A7F647778F18ADD17B38DF344E374D5CD
      4422BC3A00991256182167493C4EBCA92CA65195A1E94F9387D72B0D7FB93281
      C68B425AC4F7D388BEFCD40F88D072E4BAACD7CCECE2303F78323B6309880587
      9551B32025A480E7F098D140CD5527B043E3A9D9E0484F61B6662CA549B28291
      CA9C4F196D842CAEB2088DA05CA4089E0214D083D7CFE39928173D010B643D33
      2F6015AF136AE446C2D272DAFC0AAF42B62A094E728671180F48BC3624C42AC2
      7596047142ADB36E4552A2E91E185C6403193C1BCEDCD940A3714C3B22683F75
      E94F94030A7697992A33F72F948BB40EBBC7B7CC45DA0022AD48CE5A07B8F3DC
      24240DA8C3DEA118A38A8853BBBCC3CD5D8C4D5C6474AF52FDCD244FCD2C5042
      A475AA52655119C61251541746A67C82B482253B1F4C05F959298E5291DFDF2B
      53E579A387EC90044D6B980403CDA1471BA0891BCEE75DA920AFC3CB789678E3
      381AC449B4C903CB0B6E5342751680FEF37058140A3EC9C3B9466FD1C0431E23
      C59849745A3F4F98FD700FFFDB0863C6F67DCCCA644402A32937F9AB2E778239
      2856145E3F35C69D6E62A352065BF77237C7F8A28745CF2C33C0437509D7ED62
      C6D8AAF5DF39434721A353888DAFA9E07353356821AF39EABAA1E00A76B5F4F0
      33A6B845B5F14997A9D66BD4D62F5F590BCEDEEB58774FDC21C3CDAAE6914E24
      BCA4A4BA23C57A610542746B9A954E412E9096745227575627B4314D5F4FE838
      224F81F70747E67048C0F25FC7855A1CBAA6DE0F5C7163A9E44661EC0AF9A138
      413D9FE0F42109C230181667A082094B23DBAD5AADEE543F5E5F1C750F76E582
      FD825EC5F5F3814D57BE41BF816A42A06FB43ACAA5FAF74011ECBDFEFA58C55A
      ED875AED37E755DE111E0BDC8BE407E757E9849357FDF8EAFAC3E5DB1FAF7E93
      F7EDB1B773376EDBA21ABE964A531BF5E052148020FFE3A14375485535542E55
      1367794A87BD605F7EC1723D5DBBB34B6E925325AF923AF3835DE65EBA001ADA
      FABD0D686E1BBD5CEC49A210C7806E97A38ADB7141BCBC509DE5626BE362CDD5
      5CCCB0938974FA9B73818619591ABE4AB5E27F38E95D741BAF2E2ED4157BCA74
      5F72859F32FF15B99D652F881D6AFDB54C05D64F03D0B0F15FF0BFF51B36F248
      64B8E7C45C0D1BA12508DF8420D4DDD537EC74F64E5ECF6B916670CB6625B798
      28C54FDCCCFB2C3FBEEFC897B7B439C4EBBCBBF5C48BFC7087C814DBB2C26500
      E42DF3127197045986FD18F2A665846080521EC6ECA3B14A978AC44602DC777D
      1A50BB4EA40A798B00B3C02FF72FE620DCE5B28ECAB87A6588F587F4F0F5F955
      13237B55D9DFB73F9B3B58CCDB214F06276E520B1F59C2172669BDBCBA3A97C1
      C1CD3C244A4EB3FE90D65938870DA7C7D9FDE3C25D9EE6EEC8B7A5F2B9740379
      15101A4470320019A391355377636507BAB18C0404427C79207BBA4381C5DA15
      A4D70DAFFD3D5C06ADE2D130FB12F3BDAC80A130E15055325601B36B77D98264
      B401A11D56BF815AE7220DD7BF561D365E280C9B61500097834572A1FBCBBFE1
      4EEAA9C864DA0137F5041C9C06DCBCC5705A9A110A05AAF025F51DBEF2A0B9A8
      838703749D07AAFC00DF38F5E32D29F3D0F8DA320F5F0B25A37FEA06E8E2961D
      BB2B8F7DCD40FC480D659741B89EC0A623A48F6BA88F82AF7C34F8F0E105F8C1
      574E8301F86E043241E085CED9EB53BCFF308B8F1E3375E18F4C92BE6538D0DC
      0C0EA88BF4FF7EFEB0414420ABFACF1F0AA5769ACECF1FB6043D5A0CDB530A30
      8B23E7349C0F5427DAF563C92676D0E61D28BE87892566FBD5EFBDBCCEB12C70
      181D952D7107D4A6CB91EAC368F47D35C46A4A0F621C339B617000BA34DFA164
      CD923AF6D0A3722654918A3AE56193B534CB432755B78C101B9E3E988E46967D
      F26146E70D7E0D3620970D22A8D51BCEB4E2F064ADFCD99C1A6DC3E228723588
      648B257C7E006870031296B519608F19D94451C7EB3B3EF0A378A73298262BB6
      4F78ADAE4255A749C8E730E6B7A84B62F23F59892985DD4B30895FFD4DDE318F
      0B34F18D480F9DCA309E3DA09E707C7C4C185A612344300D42803C769D20EA9F
      1EE4760CC37AA14D1A4A59B8D46D8639E3C2D3BD53E50595F7E6219ECB66440B
      778E17562CE2849ACD300EE7D3884142F6B8774412AAE340EB37642E81A9BC14
      BBC54A83C92C4EA9DF90D26C88921C1C6A65083FBD66B5A83A2AAAAFF01419B4
      E49BB8CBA509702EDE0F4AEFF4F20C1B678E827B5369529DD5D411C8284A2011
      B045EC88CC108AA8A2940C6CA6A8A7856EB36FE47852A395A22601C51D99281C
      82FEFC380DD317787EFE930CD970376EC491CC7DDA8CD20D007A91711AA818DE
      508CBC6158C8D15E0194C9AC22E07290FE2B255A613B5099E4467F27FBD822B6
      A98A6304C15F8F7FD3BD418113FDFA5FBFE93238FF0D484B5AB6AA8F865DEB55
      C7720A5EF731C01FD46BEA4FB7B02035CB593CC7F1A7B0AE1BE455A75912FEE9
      3CA2BC185C32AF93BAD6659A2AE4EC88EA8E150A0E0CC358E63A32DDE07DBCFB
      AB7A21795034F5A89C2EDE78E07D02C0045A8F8EC0E346A6EA9292DDF0A190F2
      9CA7AB73C764B863A041C0A57AA9AF936C51C8E5E2B0489C695478C49AA8F3B9
      6C469B9346EA803B1518CCFB6DFB5B6D29FB7C47AE0880FD8B2B0D23A448BA51
      B03389B961FCE9F587D7046D9F11708808F8627758EC092161CCD1F95F08AD9C
      0952E5BC63471670225A34F2C2344770B679A2ECCA6F64D671C813AB5A671311
      FAF0863BE65705CAC0C40DFB23CDB2DC2BF84666C5C04FE74720C533B6DC5761
      D540A21F4271200B18E8ED6188EC772B55B34517E5628EB412F98132B51F8F27
      311CC3CEB52C97FBCE632D95B9189B923D70424B55D6709142CF1C080CE115F7
      EBA2FA5BDC83F04175F79E78527C91D36B0EA145C311F201EA8026E7A20A9AC6
      6AB84BEBA1390B7D8D216AE3283608FE39AF4E5E0AE2C3CCFB78F0C7CBDC6583
      ACFD93EBDAE13B715A90E4636ADF099485084BBA7B1723DF3A2AF8CE086EC53C
      9155D534E1079CE3A47E59073746ED2398CA523EF8D83826272F5E262704ED08
      511DBF31D59019489EB9AE00AF83A7499CCAE24CA7B94F0056A922FBC54339CC
      35B9E881A52B5E2D5533B81358952A9589125CEC984F1AAF06F6831EB35AC75D
      EE650AE9212922AC93A06C1C7954FB40BF5BA700EAAF184EB2BF60862F65D010
      C48622215F69156D2477D80F281A1FE8882892903DD51756AA461399D73F1043
      4FD7EFA04A774A9792604A9110C5F328D33E6F4A44A44205A932ED1C1C3BAF1E
      704EDA926CCE9C1A7310F98A623A4390BE616F205207331484F7F702AAE73002
      5E9C81D49B496ECA4AAC5CAEAA5E88622AF67F2601406A9CB728FA926F7FC2C9
      2DF3D90AF8516224F5829CA83A7D125279F13EA9C8C6702D0214F4A4358B2197
      CF095A074C288B6F9292833584E40E5226CF320C218D4374EA63FE25861DC87A
      1838687107F240F6F7E0D91C07494D21BA8ACAEB74960114BDDB60CC28A5157E
      AE808121900F6C0AA85C90EA4B3A058ED6ABAB1C1BF292CCFF254B068E9BC580
      B01ADFD1C087E80EDA10158E8C9869C832D108019C0828D18B541A12E57AF3BE
      945AB5CAA143E84610C1EFF155B4158AB100548EF6F7F257D2D219D4115629A2
      D3FAD4D6E87E4FBD1BB467664C168497CA56E1B807A27A0BD102877C2D8532E4
      A06A290F2B8BD5192E1C32CB8223C412D8A137C6DBC7B310C8F203841908DFE8
      5220015938779B8EA7CC927C4DAF162C73BBC3127F5156F1411E404706170A0F
      525CE5506AF8A500D3493BF236E4DFD27550E64669208FB449385D9E09511CB9
      EC34E6CA3E1476A3989F697ECBDFA14B3BE5D6C843278DC9BE8114D80FB05023
      5C19713F53D53F83C80F8077A2E05BB837D26219245CED27CA52D33A44051C24
      25302C7938905C1270EF030CFA0A48F4557916FA0D06357F00223F65732F4770
      283B1391446964426A79EB01E806A1ADA6BCBF771E21205E9E052959E810621F
      0491547D84BB7373B9B08851904A9636FB99F0512126DE2436501076FB127458
      1E8C809943EED0142C41389E47DABE006C4861260A11F97D91F18C77051976C9
      CFC19CCAE2EFDEA9AAE5B273E89AFB79B23B6A584ED828659737FB7BB9621649
      05BF50E416FDB20ED7C3C9BD04AE760417BCC96295ACAAAB3E4746A5B0CAA97C
      BFA2CEC7C7951CEF0355593CBF6287F846A4CD3405D9F5DFE4C18FAB44E4513C
      44C153724536FFF34B17182ABC260DF6F758D095A1BFCA3A1E3E2C3A09F8E661
      E7120AEF8B8AF7EF9C1A98146AFB832E8166FC9485DA308E6FE8326706C5F006
      BC15F832043696390DA982A45A39AB4AD5E44F087BA5E71D1C3B65A488ABA2A8
      EDDC2E1126AFE408F6F7E4211C1AFA182551A0EFC823AF3B2A378B2721EBAF2E
      D2C0205D38077DC674208415ACED2847F59250124A1504C99FF64E91121CA347
      6530CF44AED029B0496947F6A7E145E1B9B10EA784137607E5556370E2FD3D2F
      5381E2032AAC963114D1F76AA0CDB173423A186A0841325588AD9C381A598AB8
      46BB1E08AD802891680181F473DC21C7D2EFBD0500ED0AF1665963113BF0C6A4
      79EB2723A8872E06D2FA1C6FC59208FC96156ED371CECD8ACC8B7D19A522C98E
      B5B2201F9CC668DE80A590FBE62E5A220640A14EE7490A7FFE38735EAACF67A4
      9F9C7E385D7823AAE8BAEE9A31D3D52418657FBA8C802CC32A5409772F330287
      145D26CE405A3E2F198DE714AA3492910B927ED0CB8351D934C764E729FA83D1
      83FCE154AD587AF60BEB3CA3EF0C33BC1924456F2C7AB5A45D451560D38151F8
      1AB9E0BCA7960C8D928B21BFD6947259F2EDA5FC16800116B6BB0BA4612FDF9E
      11AECE01E9771E36A6613527D276D2730FA62D64037351277C0D7A9CBF28307D
      31B0EF5FABF160F37B371E341CD447CE89C11DDFBEBBD641735A0741EBA6F48C
      CAB3D7713C9ABCB05F94AA7B1D6FD9795F73C8D591F36E91D5AB384689BD0573
      F7B6EDE22A9E2743EC187DB228B22C6E83E5556DA9CF4DFBC5060D32408A0F4E
      5A94C934EEEDEF19186160830424578E350A33D3CBE5FAD45A1619C7B6801176
      3DE0BD1E21CD35E1A6234A0F8BA84DA538B612B32FC9FDEABC7EC79B41BFAA3C
      2E833F983C40C765E53EDAA94A08CCCB6D2F9D61411104B52FEF70A4B0C3882A
      E2C6011417F8C39724A72C02CC7D624682BB18D40D5ACF67E97EBDD9FC72C24F
      831F4BF983F0B6C4D74CD37C230670C21969478B6964854A98B9B77E8A9ED204
      954C50A5F2F8BFAD3856F209BEC2C06DD80E6A7AA8948BE1BC10837BA7FD5814
      0487D13720A8D02890DEA2071DC6A7C33D29147CF1D6C87AF65E3E40DEA3C1F2
      4CFB7B2365705E3997F4C3954D753D312D24A9F243F254C8A9E8D4B00B0ACCC0
      39A4BBA5D9906CA97876168FC7D2BE404603A9534F895969911BF6321424F463
      89668CE762DF253FAAD9E3349EE71163AFE49117BDC3030E6FF1A956843AD871
      704B453130E4F478C178A68C17645F40AF2363237A1E446225E4453AD9FAFE12
      F2FB829DEAADB453C9C45DAD796ABD8FBDEFB23F1F55CC5E50A1B51BCDF89B9C
      A43A0DA2799AC7401D6C9BA04120382D0458C44C79A4C8203782D6618C1926EF
      1F6D5459D3C260368811A972D3204928030EBA114622CE5BAA9DE007D9B74DC4
      F9DE71B0AB4C82CBB63D0A213F5C65F354763F23687EC9EE5966DE61172ACE84
      1C858FE818468ED9BC3FD21DB2726F913673121DD42E52DA85F28D1AF3A3E17E
      D1EB575930E9A269A710428FA731A6A40C65EC8CC41DC650903D444F4E5687C2
      404E88D1E90ABB6E015D38CA9DF15FC1BEF7F70A3BA71BB050FEA2D0E3C0D306
      B6E5168039180D2F4D2A79BC6A836878183C8A6ACA8D7A1A61653E87E9EBE12C
      292E9CCC255E546B0595211551B7968908B54EFD0E23A616CF56C545DE8AF2CD
      F133DCF782CC39EAFAB1686A643849FF1ED90556BFC98F494318080EB944A36C
      99195276B495C1BF02ABE7E4F1CA1ED5EB2FA8D93B7C63CF65C8E7CEB99C8111
      A61CBDEBA5B953136F517E7BD02C8F810F4E85C25A4B1CC10BF5888B9ECE5199
      EFD7C89864FF353B4C0C56B6E86594A61644F5B4981A965B90946843B77191A9
      7B1431A4B3AE74EB984270A0BD137BE430B197E2B397821D4B06EAACF35E147C
      8AF955500C457BE52395529C4B96AB58219B0CC93DF61D733FB608C9A9CE8DF2
      395AFC5E85DF5C0A88FC9E80C39B427333E06489132C6A5E9FD3B5CC207D7856
      F6AC8B6276DE263A7DDC0C3C813F15B52A9E75D5EDD39BD52B318263D55A4ADE
      81CB336FE6E7A3988AAB1A4EE298E665ADB110953BA79362778A7A3D79B6B5BA
      A71DDB2AC3DA4C75B2A960940A86877725CF60772802329AC5DD176F316A510F
      54D4220F6AC9430F722544E3AF72FB52B1E2F596A65A5A69F5FE60133530ED8D
      3881B561658222BC2BBB73318A09F325E0E0B0A729EC2238CA636FF34665BFDE
      FFA6AEC3A7B3E75BC7CEA98C61E220749FC379339A90D47DF2FD3AE914233C13
      9EDE2D1494285F06E944BA16777E790B011A25A1C11C0BBCB471530228B1261E
      EAECBF82BAA65E4ABE36DC2437B332A260BD41715F5CCE4A868D2EEF270CA601
      F3DE3CE06CC58AD116CEE994E8C8D226CFDBC05B21B97C0220D492933D94964E
      EC7DD0659DB998D2AF8485B350FC96AB24F9A1EF10FDB8E67B337B580987FCFE
      54750ED3A764E84278F8C18AAADA864145F51BA54C4FE5472242052F58713140
      DE14C7CE254E96CD13AECBCFFD4AD1BC99EA42DCDAB2022FF7136FAC7BC33365
      D285AF6538B933C474196991A1E047FA262DC4C424F09EC2DD570A02AB0694E7
      490579F26A38B32406604D0DCBB28265EEC862E2CDE05708F9E973580C032528
      48DD7A2612B41853A6EB274E9432E28DD22314E445209839746D75812175D052
      3D504972E8A4E357B13D9AF4055583CCD21AA0358A21CA9F29126A4A95DE15BA
      C21506546804EE9C7CE254FB6CDD7D418E38CF52827AFD45CF300F1BFD2778D1
      0A1204BD976BF9CB972BE4FF49D627E2E07372979F8432F85CA7CCCB2A0CCCE1
      D192A012ED528A43094685A90D172BBD5713D248D90F865E2A956B33D99E07AB
      0A2D5C9013D38439F65E9514D00F7A899C5F52C400CD71846732A8CFDEEFBD13
      AABBC6F9C8D2B9BD2BF79A53EE87F174CA61BF1119B580435285BEBC7C85B4E4
      4C3CC99CF2EC6D190C8061C885BA1084A155A3A69F7C30A08470319DC5B0B587
      BC26D19DC72EB17904B2B2BC4B18698A65F67CAEBEC0112713F6F01EC86C0BAC
      01A204028C89C6941701A23B30606F3653C5613596AFD9307044B87346C0B802
      68AD9D5AEDEFB1358D422B3C72B04647B12A1E5ED59FFEC23D493817F0D0D1DF
      FBE1303D744E4FD38342B02456BDE630BA15C0EA131E6C1A543F7858E5FB7080
      2D1A0E87D808681315BF73E0E902248598A64780838335299F6AEA3D00020FC3
      39568851205EB09BEE3021AD5CA1E7FF63443143CE4F419455E0DACE426F28D2
      5C90AE90510351A022ED1CBB436DC9B0B00A4C48EAA4815C4AE9EF6481806A4C
      A974725F07EC83E3B00A19808A817A73399BAAC604028BB2D6D46B0E06206694
      733A40F20D334EE0ADB900C1EE8579E4CB88E69FBCE9609E6079A6379461AD32
      6D89C8CA37C9801B2C0C02BBE1F0108CF4C899867C525D8C5315914B59C8818A
      4BD1A50AE629D6FDA0B2728BC50A564EF1EB7FFDA66045B361A31FCC98202EC3
      394CF596CCB24E255F81EFD1D005971B4E1AA5780A6564DF0AAE258AE37F0A3D
      5A03CEDE6D5682D079C3C62F1567EF08AEEC48C0C43BBD3B77F904431E0B40A9
      BE826B77A0205191577831D1B3EA1B06D82C990B1D0F5C5ABE54CA4EAAA4960C
      439E961F4655C5E172B5348C7F5745B2309D029769715A876101480A56A0DDC1
      E142F1DB550631B2C8111A7A9960275C101D114BA720EE983BAC5D627543ACD7
      2EA5A354E61F1E1C3A17207D65B2D51DE16920425F564DC322063C693E17D75F
      A2AAA87015B02FA451E0F7CAB0ECAF5A074FCE968910F3191D3F89679C8F8E4C
      8CCAD3CD62AA0B09CC46E6B5550559F5C908C0EB362BEF4FE663ACD559D5063D
      4AC7E14277DE380A32D8EF01FA057CA3DCE02EDF2A26422AFE0D01BA3B170A55
      85150000298EEA75A024B7EACE156BA3907531612D1AF1F940DE422CBF9B3A5C
      B51E9B5B735503D2D60689F06E64ED272E569A7266CB055B8D3DD88F7A195AF9
      2D9EEE9D608D4C59386E7710F484E819922BB618A23D46150B55C5631926A66B
      6238098421CA5718760BE5374F55E5D6D73120665A31DD45DCA7019DD99F1C9A
      722714D662FC622DD75F87997A0C5F90FEA646CB3F5EFA48D5875E781DBF2133
      C82F000E35E2D0C947E3F7E6EF3C9B1902D9282E9362CFC82D1664E801329D37
      4AD9A13C025F59C5972770AADA75C39A13DA230E0C47D0B14C3718ECEF89627C
      BFACCDAA6BD1EA21878E2C184E863932702CBC84D44315859599C51165AEAB34
      A7655C5A92B541C487A0581F8BDAB0D2A19823E0620FE3A9D0E522A2D82F6428
      14AB9B98AF67F6CF3A175687D7A63C9C0300B0BF97E6ED6FE59477A0EF628112
      2962E449EE45D7575EFA573DC04568E576A8F464E2E5567F7D138C8DC986EFC7
      8E381E1FB399DFA8A82B1FA268EE5078115571E69C380053247028DA36317C82
      9080963FD2184FB55FB9F2BA3C3D413E377A4CBA05F6F7B01614CE9EDF3AD994
      3D3F2E795087654103F84C6584C9FC61F04F74B95665AB527D3119B0DEC3812A
      980B2F54418574EC7EEE36CCCF4E951E8B31C811AE567ED8BA7A15EF0A4B749B
      70BDF38C45ABA4AFBC5791C2349864480E0BA093FB7BF361364FB0E2AE346D54
      2912425626467FAB51DACB93B6E1BCEA987C7322A640D9D245DCF6F8CCA8C222
      993FD22C8E894B53A5D339D2311574E15CE745A731916F9E5231344FDB5254AC
      5A64E499AF3A15714F899E2CC752F93732829B074B7A5FEE5766B391C9B008FB
      4E25F691F948DC63563C02D6A81EC9A626268704F0D702184885815FF9DB1C45
      902B9300B35B9EE946C139A6E2834C325979F5E0BCF252F1810EA022ABA691A5
      7410DFABF39411012A65CA88A8618F22773AE098012C1AAB9FA8FEC521019FF3
      E09DD3F3D7AFF164B07EF90869C1503D7AB0704316D691979A3B74FE74E81CF1
      EEFFDDB9110FE9625571E9BE03C07154FB4918560EF56F6FE19A2AE05D46B728
      7DE930DD4AA1E502178BCD2F9AA6CBF23249FEA78C7C2AD744DD09551DD4B859
      9225725D0155F953C6F2526F614FA5977A66913C7D083A7794B278E94169464C
      859E5DBD7721FF933C8C799ECBACE0B1DC6111F20310AA898CA1E1E4BE9DB266
      17C3E835AEABB4C34F376D48058A52CA193F102449A0774B4DE885CBFDED7465
      1A0C5B9907A14FBC62E908748302748AE9F60DAC7ED192F29ACFAAC852CAD53E
      7D0ACEABE8592BE4B7571D54801C3DA07B4DFBFC8168C36627EC7CD381412AC0
      C62C2CCFF28EE96A92315769CC9C944395E030873740B89109E0A6B4AD22E4F0
      1F00121BF1800A209394EFF4B285D604EF983AAE828D3E2702E0A1EC456E42D6
      60317A8A97F3289F4E51E87C236CBC5F969A8D1829B6E0C709B9D9C7A00DCB6E
      181410BA6AA1B23B544AB8438916235475B37964D46395E7071785FAA151970A
      AEAACA41979E832D56101741A81B2724D561B09A8E1FC73F7374172C009950CA
      087B75756E299C369156A40C815D204149C3883E6A08F9135593DDA1F8CAF7CA
      8D99374541BF364B0F400CD05448AD254D80195C5F81ECD87925FBADA81E1B24
      A4C664E87F7372750D546BA02F9A0EB7306464194F0DF3EEEF49B3E50BC47A6C
      D964D6144289F8504A9AC4D5438CC8A0B83F2C7712CF139DDF378F403695190E
      788BE856A3F007972299731B4ED84A4475FF0FE89ACC443C5329E77EAC7B5279
      3046CC944C0D7319579688172AB278F5389C49B75C2D866B30FBC84518ED06D5
      8238EA5232726788157A494380BD99D057B59099F2C8C63900754C98E7C702CE
      679225F52A27F0379E20FD74EDE94FA59AAD7A291DB0587C2FD50B4AE7B9362E
      8CFE38526C4E69A75AF0D5758CD54491F38F39567EC8547748BD1952121EB71D
      2DDBC785281FDDA148951531319BCAC81FCA93A252494AD82C46096E22988417
      42EBC0D76F202387340FD5980640BEF67D5CFE15C0F50B5C9ECBE9590C30DE40
      00D1B1F31E332E05AB618C177059759C97ECA923640CA4ECD22A6B624754125B
      AB687EECDCE0F9DEE10C0FB233AB8F0BB7BC72EF728AADBFA40796490C9986D2
      38E14E5F64DA943ABB6A83BB2B9CD324AA241946F1FE1E36AC965EC5BCFD8C91
      F98AB2A0B6395F0118733AB6D2B66C3EE25489B46255E46579FCA0A2092FB7B2
      515491927EF08C74BDBD4502BAF2C58567D070F141527AB22B917141FEF1096F
      C6CABD0DC3D82C957219AB0FC416B636CA4D3B78B3E93B4AC0E24036E242526A
      A05AFD39638137DD6A5F9534C744424863ED2067D3483428D317840254DC38B4
      C0E0F51C567C1B900AC04919D29E7020BF0D31A28E1A1D520F210E5BB014232F
      D3CC763A433C245FF92EE52DC9D4991238A88098855C46D3EC4702AEB69DB24D
      FCFCEA0DB59A67D2FB3A1E7A640897C525F32EEE1C3A108AA2C1FB1305047618
      67DF930DE4831839BFBE7FFDDF1F7EA8D1FFEACDDFF06E2BCF405EBABAFF3BDA
      46FA7F1C8BFB9D890D4310EDEF3190AAB210B702D3813265792B80855867024C
      579034E2E8D9476754EF972DCD808AC03AFC61ECAB82CD06053FC8CDF6665B44
      D3E893259E6C79F24169193EB6F25C34ABD13D2B1A9B76F836FCA4407EEC7BAA
      429CE496BB82EDA8E796EA4500842FD38C0A805D7F12189F9411AB2C251C0AAB
      E100FF42FEB774CC70213BBCBE623A10BE5FB4B4C08D2D9AACCDFBA5CBFAE393
      F0324FA9F6B953086F3C66B584DE908DCBEB5637FBBFFF08B4E52DD3971CC2AA
      73C2A341FD44257A2056816887A9C67530DB3932C1B171B473E924CFD824EF4D
      D956B4FA3666A429A1E751359F56710053CFA78B5570E8E877E48A8E346948F4
      93A64792F670203E7C9CDD73DF8B1597DB62AD3E3F95837EAAAB3DC7D12A2179
      77305A16CE2E2FDB21BBB510E094B135E22864B6F562E531EEA6A1BED3910232
      9A6AA1C2F6B1A3D28FE1C5C5D947311A459173B0F827276C60AB777A85C5E1BD
      5F7F16C9C36FCE8AC8979DB1C4EDEF9567F317D1489B887593AFB5DBBFFF8107
      81FC40F753DF440AED910C9B31EAAFEB627E715E19F97021E64927DD52DD626A
      453FCE7BECAE8E64CD7BD073D492D4CD0EA5A5EE905C416B0723664BAC02E552
      6D86AF169C8F744C2A05B9712CC732D85295A1C4BD2E53A36E12BAE2C3F9185E
      457C57054598459B0ADD178C60A6AA8C980C46CEE9F587D728624F44E8170B31
      1C582AC7E4ED574CB4FD8DA3042D71FB5EC48D1C3EEB57601549CBEBAE01AD81
      1FA1D025EE71BFFB7BAA6151E4E7CE3DE97B22795793BE5571CDCB65D66400AD
      8EF95EEA8C19850F3242F263C48D31E937D51F5E1B9764A87F457A4A2A3A7C3F
      77DF57F22A47B85215E15AF6EE6367450581B59C21826063E7987A70488B1495
      5CF7CC5A0E9D8F671F0E9547E9F2FA4D0536FE8F39C5BF92296EC6A6C00605D7
      A58B4C4CE68EEAD002461B0CB8C26C068EC1E2031B05ECEDA9BC7A7775F5F2F5
      BB77D73AC218DE8E1174854063254D32B1610F18070F17EBF2CD930805DE9153
      B9C2507F440179A8E8A113918E7CA0843D0C20D08502B5FD0476AD6AD90CE371
      8446FC034E7612204D572E1D74A33BE847772E5F4C1D72A5CB50667C898A1651
      9986C08413DCD6411E0788A1DE084B8E13E4087896191408CEBCBB683C47111C
      EB5650F15F2DC8A7F11C9B32064984412DA14FADA8B87982F6B7C9865EF8F858
      B690921E8B08D3F5E1533A67DFFC0B0C2A4A84E73F98B1948D63F7B82E3B5EE9
      6035B31CE03546EEDD2B47084C7698D75141F0A00B4EF5CB36E498A919956DF8
      E7548A884A3ECEFBB42FB317D5C33B4E86ECCF4D459E8CACDC897E701BF87385
      9454EBCC280FC3692058568E424DE41D183C60DAA9AEF196E7C0002A176DDA79
      E682B948464B1D410490F3E7430A4F0A464488B84A32154AC8A319F138A65E84
      FE4C60111390FBAA18B41F0C834C92C00759E346395F8D3F1B65DBE0E24AC2AB
      EEAE4DBBDEDF3B4BBCF18BE8C51966E6C2C9DF4DE28213644753B12F57645FAB
      E0DCC5D0E75283420196182E67D64B9CB047B56A4ADAECF5047274A02A852B6B
      0499DC228A4AB638BBF7069B06A28E9264C0FC4802A9FC9FF9740644B7B23271
      FEB920EED756C6968DDD31997913F59BE255350924224B428B1ED0FC2C54B70A
      EBA19498FBD6BB05269682B46784A73D17ECFC7AB27A0137F5FAFCAAF5F2EAEA
      9C8B50BC6B1E629A8547BA92F0C7AA59187EC464FA9B54FB018C941090B8411A
      50EDAC402AC312B1CA3A4B26113DA7945FCD7AB3DAEF10C9D338C40A17AA8E53
      FE6A2C424D5910BEB8CF43B9B9800BB60D5342CBB153FDA0B22396C46A96B750
      EE46EF12C00084EFE303E7846D32A77FA5281A6208DE20A0BC8A74321F8D4292
      0D412E54396866CBE08512B20B0B96BBB9934DA9017A98AC8BC22F478E6A9F8D
      84570E6A1598CE99C020D98F406DA0BC8C20C264528E628E0C9DE0EDC9CF6F58
      1FA07B9EABFB3EA89A98E83DC6D0080A6505510FF7B4BF27592567A783BE3142
      E91CBB0870822D8ABC3AE67C35C20CA97C719072BE0A66FE0543090E79ECA962
      D498C3E86BC2054FC2510E63802608AE19B7FB5542AFF1046F502DE2C372564B
      EE1D931799637429B81E2E31C73515D29E08AB15C2E541F5ABB3A9D895413529
      60E9D7455CA68D12E0AB039008F208FE6CF139C02C4AA6859FC67D32C0C437EE
      005FF977A4D93AB3416788CBE764483BABA74842B8023A6D4A1669B1D47DEFBD
      F2A04EE61955B991862F3AA1643EDB2907B38C0314CA5C8CD7416AAFBAA24420
      6FAAECA88323B0C6689E4C4BF03C34BEC4C4169E8F2B8EE67D768C0A74586C9B
      F68D291F11D9F995CEA98F423AF2785EDD8847BEAF10E125DB1013C2E353EFFE
      8A46A16C31C9325DAC0D1071DB45786A469595FC39559151355AA3DCE12ED1E5
      F0136B42281968B4425947ED2388E636FA9F8A5FAA0AF7598CF1EDBB73EBA812
      4071F379543B5E00B87A3EDE3AB3E2AAF313B0F0F3548547CA2FA9FDD5E519FC
      718CC9B0D7131D548F558F50003900ECCFB29C515E1AE96109C8B62A25CE093D
      CAE3A4329855924EBC6102FCCE49F1021B4DB8771A65298A141BF4659E33A35C
      093282ED16029F3815030264E3D6AD74658C1E934F5940B850C182C432C55D00
      37EFA8ACCA5D9CE78702BD947614E5A73005B14390D00548F514B58EAE137E03
      8E2611B5F24660193B8A80925E91632C3181C9579C7DB1F82EC7F0F818F6CE7C
      87B2A5696EEE5CF10E550287EB6927DA8664A28AAE07C1612C72118A8B985D81
      B9028FE2952E2CCC7898C5F322684E5597D4C2C265AE36709F20F4124ED994DD
      314CEA732C7BD7994532D0A26BBC53038913FB15DC3F792172A2E6A537A92C6A
      1009D07416B74E2A9F710A1C1C34D51139ACA0A95A39C6CB16A91A9D13E50A79
      6CF353F9A685B7EA73A0A852A67987C6F11A2D98C8750F2B3A860321195D77BF
      AEFEC539276279056412DBA57C94DDFDBCC8788A501EB4A3E68F627883A1B219
      2398AF1A7DAA9D00A52E98E761F58114BF8CADE9C80B73B504BCFD3DB6BBC31A
      974F9732614941D2E5E6551BEDE2311B7888BBC6BCE940668A60B6897A52F52B
      948B944716519AC89883ECD993E9175EAEB2A603EDB9AC2E6C2351D10FC0ECA4
      7E8AAC27A71313BEBF3967E485002703ADFD5655405BB87805C0521A57BA7437
      899D3E85624D9629C9F2B564D511679B4EB9DA19CDB844185259360621291574
      AEE32F5D6AEA76E7719BAFB56EB7284A988CDC800F717A4C49FBFFECBD69731B
      57922EFC9D11FC0FD5981B57E418A2B02FEA3B33419194CD6B6D43D276CF6B39
      6ED4728AAC2680425701A2E899FEEFEFF3649E53550049496E5356A909CF3445
      02B59C254FEEF9E48764FBEB99292782C7246C3B008379A17587C208D606AE60
      5F2B9DD457B9B7DECA38992A2685466E93560BA852828E8087178C1AAACDBEAC
      087E79A611575F3B0B2EDEF0EDFBCFF6F49A7390A9CB80E5557CC215072DD01C
      E70C97323CC62498EADD5A7D4D2CA3D581589EB63AD3EABEF3D0C8F1A81C09ED
      6ABA6F4505F8B764E8EA5E4AAB081CDBA7F692433E5707D1B4935B9DD60DC783
      F1F38491B28AFFE19C2C2C4B97E7172B148BE35A797C816BEC8AE22D85835BDC
      42E32BB8499641B8755D9BA70B261B690BF738B87E5C64AC0B4B519C58ED47BB
      DF2C0A56D73F77CCBEFC7C6D7F7FA2734C5A65D81C4D52CFFA592C0865656185
      6BD9EA4ADBB22F53F69412753B5356515D2C7A756EDB870F4B3981E462A96815
      156B998975C92E0D0ED13FB359D99627F19B1DDBA303D429CB67C965FDCCEF7A
      0E9DBA84DE92F2FAB93BAC4598978F5D6177CC3F28C17A716BBC9C709DD92C47
      0E6FC61C1F2E47C184571E66DD93C25FC0EE5C5BDC95895963A48C109725B80B
      57F7EEF4064EE2D142ABEAD37323D132564DC99E3A59B0F67459B762D572F528
      5717C3B254F52A0B849E7D7499C7B4BA42DECE4BFFBA9AE80EA55217DCAA3B96
      83592E576D1E50240B5659426E2AB3B7F2DC2B2A84ADFE627DE0D1DE26E16ECB
      E953A0466637147853155093528B7A3896952C8B43462C16C5CFD716A482FF42
      4C535031F89C518147FAB60BE69EE6AFDF5E282102C36578F0987C63721ECD22
      63A869D94E51FD982F130DB7B8F2DF5C3D6E2B6AAC5741E5E4E38A835FEAAE85
      FE2D693D9BC3F04C5C9512EC21EAB5F79D99CC9BDE2BF37E9943B46187BF4D16
      DF2D8326730229B39B64C3905199A187D23F370F283CE9D6EA2EBCDC35B772A1
      CD3267EB2A9945E9955B6697C5FADF6F097C494C1F59BDB782356A97D05B1FFF
      DAC83FB98E7092E2261FD74781FCD27ACBA38507786F1F05C3B738567FBF65F3
      E2E47177C0151E767EC32E625E7F0D654E20D3C57BDEFB09FB3AC9DB835B3797
      F7FF41DB4BC2F71EC30A1188F60BFE4556B352B05697ED2A8E27064C8F6EF937
      4F64396E28B9B2A8D6E427109028B4E7D6E7612ABDDB0A8CBD6C3913179A9FD7
      6DDACA8A3067D1CC45B5A326162756939F3064BB8048008B4DE702EB5F311DDC
      8A94414FCD20D5F4CBDA4DD6F25BBBC3BA4FEEB3DC64EFA8BB9E187FF25894CE
      50B0A1C58F20CAA35EAF90C8B44EEC9A10CFC73B62010AB3C712590A6279D66D
      F24EC03CF68E2653896565FB3F3CCA57044FE5787AFF45603CABB4281C27D4DD
      E542F0FDF2DC3610291398B7B7D2D9792A59A14BA2E3AD908C23958D72B0A56E
      458568FE42ABD1B99FD5E80CEF588DCEF0135743994F81F2FD4FAFEE14708EDB
      5B93B52A01076AE5C0BB6FF5AECF8A15AB3896D56ED66C274927762672E35020
      AACAE7595EAF2E2007295445ED763E3C39EEAE3D7A73BD6B9E7342AE37CDB38F
      B7817AD721FA4B1DF9DA10395BCC5A55E2A1D0B92B4253D8B57F84CED797ECB7
      927AA9BD7D2E6A2FDF7007C11FC7A526C81812DDF490BB6939CF1DE9AED1DB6B
      EDBD6FE29F0EFFD9DBDBDB551FBCDEE90AF85CC997861A453FD951C7A2F845D5
      856A9B632E2B22C6E6BDD8B329192D8985D3761D0D14D56E6D710B7C548BD0BF
      4917D8DE729A5266A689D04195501ECED9DEBFD144B5E8AB7081314DC45C27E9
      B8F5D20352391752D8A4A7465A5C27D2F7D552B83CD486CB8A03FEF3FB5F94B6
      4B38E445792A0583D7B2126926B2D2A4830571E2CECA784A332237A65981A8B7
      D6FFC21E8A72244925D5603E61F2A69C0E37373ECF6570E2C1125BA9F22F3E13
      3C6FEACFD4125C7FBE1BA985A87509D74EF1E6F1552E5251A7F7BCE7AA62EB41
      CF2B81EC77B65B125B68D207580CCDCCCDAC48CA958325796C56BD2FA2AC3060
      25658001CE2538C5F5E6D86F1D684110A60262A485FF60E4388F4F31FBEDAD62
      FEDE8ECA1BA1E47789BF86097E4BC9CA6EC5C14720B00BCCB98CD012E855DF93
      3BF47470D864BA9CDA5507A95EF8139B5C6213BEED572BB80A565815CF7552BD
      E8EB620B1B36BEC2755FE1F04BFB0A4FDDB63E1672082D393818F744FD0D776F
      FEF656B9FDDECA91B51CBE70DB159DD72478AE7D8A44E3B2CD0724A85B86FF34
      AE5E3382799E486B26EBC95A248B4951B8B8530555DA2D01A65797AE69D3CEB4
      2F9824494BC936E3CB7F5B3AFD10E41008E2803F4D6DE1B4DD1807EF2FAFCC93
      5FCD2D48096EC16D918F75D74B020DEFA8DB9A6E6F7155CFC8C774590BDEB328
      A69A7F609A929DA27DE3841996EEDFA25F1C962A04479CADAC9EBC46595391F5
      B2F206457791B4B44AAA79BD96ED74CAFC98C74CB80858E7631DC4C58A4A2191
      12EDDE675FDC639766B860930DF7A20AF54AE74163417AC02F8D187A950189DC
      DADE921264D13BD76F9EBB067F779F3C6EE83C4B458D4B155922BFC896B34B2F
      4FBDA2C5A07B28675781D2BC735095D61ABF877A1EB03EF71DD7789696057182
      5F309D2F200CD2AB07A3DCD9C2858FACC6BA9D6466E2337852380F567A79DD68
      0CB3A204AED6EA48C2F746115B57C4465F5A1103F39C6A675CE2B2CC0A340570
      43D720179B2F9DE0889AC4EC76D089AB5F297A20533B81CAB1584A9AE933334B
      CE67E5B729B3D3E9F323DFBA48A2C8CCEA26D78E6355100B58A9B253DEDA2AB8
      AC4CED2E75C103E59665B759394B3259BD57A7EC4ACA6A387597847C5AF4ED2C
      3B0B7CE29EBF04A1272CCCA67BB1CA616EDFFC8D6052F345BC500684A5F25CE0
      4C054975458E17C9C20F1A7F569B665809D5385C5DB51F8B55BB0D98B6C45674
      B5F9C1B5B819A7B9091BEB8D36BC43DB774D8F6FBFB592946BE1B5549D94D76A
      EF6E716C660A1EC58C3D4260DEB2855A1E7373881A1FC0B02ED24951C803C537
      C7015ACED5957935631BDF5D6D0D87E917FD28350660C5B08EC9A1C6154633AC
      BAA546E719502812F7CDC2262A93145BCE65A9B32B7BE6490A445AA9E75F6DE3
      E6FA6F3BA5946F67A24C513DA2EB202514B20C1BCDB4D20E677F4271E9F3A7F8
      AF702948DB218A3DA8DAC4EA09FFC8B2DC756A1577235B9A5B34D0A6B79CE536
      2F974FCBEDB18350D3B677F96E1103941757DD96F853F25B126DA36E1B9DFDC9
      7DAF81BFF73EE1499A05D0ABA4AFCF2DECA03B0D224A3B4593841C12326550C4
      96C0272548E7DD7B5EEEEBE2FDB83DC0CFF6A8DBC13F9D616F847FBA83410FFF
      60615BF8A7DF1BF39241AFCD4B86DD0E2F19757A3DBD9B97807886F298D678CC
      8BDAED718B57B53BB88EFF76873DB9AE37E80F3E2F31DD0796E5BEE73DE3FFDB
      95C4EF079EB7EFAA841ECE9952B5AD205E770EAA9D46497D1BDABB4FDA2B898E
      FF6FFFD2FF0A12F41E121512674839AEB8D8924CAB73771CA048E959F3FECD5B
      F5AC09994AA0E8BE218B775414ECDE3FCE6D4A7CE51B70E4BF77B856227D86F1
      6A1ABE75DDAB9C65A45F25A5C02CADC8C207ACB53D2F61A345CF3E7B7066D8EB
      5969652CFCA0A940CE2B3EEBA62DB92B9ABF05BEADE6B320B2E96AE8F69820C0
      D5FA587B19EC9C57B688FF09179CF5A0D56C0F7B5919DFBB641B6EDB4A843E77
      5B3A6B93A978B1354EB4667525995DD912FD2034EE7CADDA77BDAC257A96A6D5
      CE3B3A3FBACD0A4B5E5E2F761B2CC0080F6A7A9C12BB7E6BB9AC3E9D8DCBEDC7
      34C774BCD2BCB502545A817D394BADD98AA187CBBC4C948131A8AD6996F9C6B9
      7AC3B93AFED2CE55B6AD7945F6F91F42738E9A2DD5129ABB667BB6BF987CF3A3
      1BAB9CB61A0FF668663B911059EF69B1BA8FFFDDB10BFC564C03BFFF780B606D
      5DE672A07E9EC3F46AF654DD496E3A77EC05E77DDB841EB0643E7640912119BA
      724A01E3B288292BCBF50946CE3F8BBC5678A09794D13FCC9F90C4BC1D46ED76
      BD2716075389AFF8D249955D154556E448F43AB31986F9C2BF2EC5D05496DD3A
      660A7F89BC967DD08BB7DDB7FE7E3CCB4D76FFED32B7B73EB00681918E9525E6
      A9AACE6EF2B7E7AE5792D79D73EBB93C7266AE24EFA1F288DCD16AC3DB89D63C
      5ABB9A0C30B53D1AACBFF7F54ACC369909C66A5475257FD2C2B3CDE5A723619F
      9DBCB87F33441DE71A6426E5FC3124732FD8DDAB641F11EDFF6394C38BE6370F
      CE0366E136932F677233DD540C3C7A133F3093FC06077F380CFCEC62652176CA
      CA10E72249AA26D94A33461DFA2A4AB3CB2552589A22B5CAE1640BC97E008626
      23D9F8DAA525AC2480AD3B1A671596A6EF5A5CCF2D3419351BCD52CF8B0C62D7
      C5314FA9F64811EEE664142743ED3FF6DD4B9759A8B5BBC4A5B56D582C989B83
      85B250B88D9F0F6191FEE2492F536CAF0B383C619885401E0F0BFA5202419586
      35FE8D05DA5959215DCDDD62A5883C91953043EBC8780C0A1535182BEDAE7D81
      B6D0420CE94564C34EBE7770F4E285CB04F4BD9F4E5E1C8ABBCD3B397A7E527E
      CEAB765D771443A44A3FBB5EF170483B27DBD4888E891B941127DB5B60194505
      4A6618D8CD5720F08A9AF7C8A5F0AA9AE17A79ABBE91DFF6F84A472525D00260
      9EC60C9D400C80550A055D1CD9A57CB39888D803C5CB5CA6A7C30661BB2CED39
      EFED14EC2CA12FC5F677DB95A6626BAF7FC02CA30273AA2BF4700EFA595A143B
      35A6EBCB50429B42582DAEBD1DB252C52B2BF229148DD6956EF28C65A920AF1D
      7CBF2B506A640F2550DA4AB702955926FA234DCC9A9260E378F657B043E96090
      57F7E061C99D0F2E83B75394233B3D6E3DB7D64280D14FEC2EB92583C846CAAC
      A7981729DAB8CB867F5548B45C0B68ACA35958AC63C76240FE559300DDC53BFF
      563065F791CB6EF01D2E68D9D0AC78AAC2130ADC1FF456A9280943690C225537
      7670F3CCC4C9FB12C3745EA4CF27EB418105649EC23C1BC16F51E337E068F120
      518B2982A5F5A0B6735115D31758BF6CE1EC657DF3AE5392B47ED249F615C557
      329EF84C6DEC82415D9B45D98FAC84EDB4426A6ABB1E330752A0DB4A61AD0A3B
      BE2E101E7FD2AE8C4F3592E1D096650F5FBD3EF32CBAA43FBB2EFBE9286C9BC8
      FDA9C5C92AE31B7641F5AF242B9B9D6D3A87E0085A452F5CD384BD1DC5FCC19F
      B619E3EE03548C1B3757A15176315A49047498DC020CE8DDB9AC85CAEC08DBD1
      E0AB0A04B9BF58A37B1E353708A3E95416F1BA9A3855A085AE50BCD510D70ACF
      6F9DD93B9F6D77E48852D975453F375FB7F2648BE48D4D3A17485BDB5EDDAFB6
      EC966CDE501620AEB0088BA848EEEA46B2707561F64E01A13D4F1CBA75789126
      DAB5A9F15F2677AD8E6C13E15769F1C1DA74AD715826AFDF04F576B3BD75FCD5
      F2FE8F4CC42AFE3B95A55D5D2CC916B7B7DD1CC6AE4300F8F09A97EFD3AEA2D1
      AA9F4D6595E050ADCBD6A634B05931F648AB1552DDDEFA380FD0608C0483572D
      B895EE034D0BA8EC9A53A78AC49D2CF2B2F9745E9996DD83F206A21A96748FB7
      ADAD8A62905D94CD8DF539B993EDEEAA9BEBECD64D619C7FB41AED8168B40426
      52536A5523C6430FBEE7985477F66D07FBEAEA161542D3E5A40ABFFD90458C54
      5158358F4D5E78468F4E5F3C2039A26D911D4B5F08F4ECBAEA2967ADD0DAFEDD
      FB5FCF9F3F577878F0C4E95C831DA5123BD50AED184A6E79D7FFF937B96DAF68
      1D1143835E457A5EA42455284FB3AADA3B73B8171598FF8D1EF6471E9213639B
      1B16A7040CF661695B4515091D70045874BCBE20BE1C37096A332CA0C2A350F1
      B27FD8A0141DE12E66F4E5A89EF562DD8AD344BB605E487E18B3304496496FA0
      C2F69426993ED16F72D79FBD22D1552D5172DA143B93B2BE353398B113E98EC9
      174F8DE81EDCFBD7AFF65F16E9105FCB59FB9DC1DEC7CF93F76FA8F1E068CC42
      F319A2BE4FEE3B3EFDF855FAA141DFC390C91DEE3F37F9B1E6C592CAEE7DC4F7
      BEC8DB5BB2CC9F6DC0D5B3E79A2B9FEBD164B647C5DD57F49894282D99E7545B
      9259E05869B1323D3A7D99C41B702EC90F98F8737508BE92ACD9222BC00FBE16
      A6F6FB158862EAD53C6CDB7C52F0B47E7EFC8B975F4F8374628384ABB077A12E
      A3EAD745E324BBB6345F3308FD39684FED665B113F4B23761E1298CA4AABEE32
      C82F4AFC7C3E61E76CC9C6D61A54BCBF041610957DEA5F5B7F07237A69769ED2
      1DB25ABDCB3733F7BA00ABB31A015F12A622FF033FBC14C8F26CCFDB517FAD4D
      29708DC675649E58CAB420A49661962E5C738C4A0A8279EF4BDC56BF70773A40
      4FA98DC01FDB5B45D1218C08ADABD547167D6124C8EC12AF5CE448139B04FBB0
      68A7FB58DAE9627EB345E9558B4CD3E568E816B9BDD0DE77EB6B2F191565DFEC
      F56EDB47761AD59DA13905C5EBC8ED9A5CCAAEBFC553E897A28E67FC595ED489
      317BC9FADD234C0794B0B257AE9DCE3A92D65A1FEEAA3B5FFB39BA49B809571A
      D2290DB23D7CF22E89D858DD919AF4D058BD5F2FAEDE5E2CE12D0FD8D36D2AA9
      1CCF0BCB03E0EB33772A297476272DE8AA85D85AB0F59075C1DCF296626DE569
      0A856524755792FDCBA714983FB8AE5830A96B4D5C6941413B365D06E4D3B495
      03D51E56E5321687585301A374195449D0E5A0993C213D65D2BAD9A506B5349A
      52C53B92E8BA4671F25BF022B6B78A4009F3B62C46863FC9408DD70A4B561D81
      77B3EE6BA6211EF5AEDADA5A0EBCC80DB21C0FCB89C16E106A05697A617D229E
      9A5ECFC965BEC3923FA8603FDDFCAB6BD128389FB34ECB8571454925A04BC2A6
      3DEF57AAC59962AFA80852296BE5A73DBCFF213C7405768BDF68527E35976565
      6FF8C54B6D90F58DD7DE50EFCA96CC2AF81D65AC3BB7ECE561D172A1D015F5D9
      E2245927E32B2787CAC044254B202F16EF031903365BBD68115695CE0AD8B182
      5AC2C793CF6B47CCF4D275EE5B19954D0C70A18AD44971E387179501F20D32C0
      1B4FE0D71BE65E56B3C4505B45D3B5E90A22838B74850704607778EBFC89679F
      A88A9619513D43519A33129CB5B2E930F41582434BA870B505DF9770005334CE
      D9E0EEBC3C73D6926AE40B7EF273F1C25FC4C5BABDE56E2A2AA767A94D5A76DF
      1496029E7B6ECB4EDB2D903D54491BD0D3746B0ECE6980D8F4F38C9DC82BA376
      27D842AA86BED67B14CF7758AF74FBADE76D0BAA9B76EAB13115D71A9A3AEBFA
      5AD230AB34934D5D2989956B0CA5E4D7B030A6CC83F97A0FE9ADEEA3A074207D
      EA197DCCB131DD68DD83748F9C40C0D985E3B2AB5AE1587A28C79E02F14EF71F
      16E11FF456DEB571F7E8FA2B335A0AF16DD5BFD3028CCCE57E607BC50128A96B
      3C98AE45BA02C732A4297615ACCD951C3A8DCBE77B8BF70B71AC8815985F26DA
      6697EFFB56B2CDCB378A27604575E53B354A0B2B2B898A9B36D1CAEDAD6FB195
      2F92D9A5F7C47BFEBAC7E475FEF550CEDE7E75D2A4B5EDAD73DB79E379EFF4C8
      1952C92C9C2CA352F41C5BA7874B1AC9573AC7E2919A2D639F5D6D7B637364CA
      4ED0F603765B6CAEE57E95599E369926B9E160923343EF4AB18D1F86AF6DBCF1
      17170DC1AAB09A6DA549B72B5DA0082E9255A96BB8B7444D6A017E450BB94509
      67C78F54137D755277B64EAAA4F11606019566F0129D83EF5C6C2B22BF88E4AE
      74A45468D322EE203BC87D609EAA86720353B662553586E32B9CCCDAE5AF88E4
      DE7B59A63064BE11F47DF93999F23A661CDD9253758CDE7F91EC671433455B83
      55AAB949F2D8C0938222A563A9A56DE910A3B4FD0CE60593DAF0C90B1ED56CC3
      FA5D28DD851DAA3E76B5CCCA98479CBC7F385D6208D23861F2A167F37898E778
      EB8A542C89A91F15855C3716B4C86EAD344D3FAF268E1CCF34932BF46D778BDC
      14C9C9363F942DAAAEAA3935CB59D1093DF28ECF5E4ADC43FCE30EC2A0F23D8B
      D696E105A559C9E224609B8490107C57924F4BDE5129F2B1E1143A692C902AD6
      C3EEDF8ADBFAB689378BDE005225E15A97DCF02C5EB9F464EBD45C0F2B585E76
      4BAD2E468A0565AEB320B296E5B8600850263502A083B5618CE09A3DA6ACA7B3
      555640C028E55552CCA88AE2BB2A1AD307D7AB902CBA520DACC43263FBAAC62D
      8B62E721B851BC3CF77E7CB97FE8BDC968A72E24B618EBCC1BA78B6C192E1A34
      F71BFB025A86AFDC8712E7D4FCA4A921A556B5696921669F8375F8E0939A84DF
      E5E0B3205964ACE550CA57EC26A3A95BC2BE18802CEB3B8E174E435A514A0888
      C119ED7AA76196CCED89A94CAFEA72FBE1D8DB09208F8986208129C2F066FEF9
      A3D923A207145190D5BCDE098E4C9C168E6E2C7164FD0FDC6115EC92B07C2138
      E59F28FA7E83E0BBC67F8FA7D3C798EB0FB9C99E7AEF31A2C8BC7FEA5D7F16AC
      BDEDADFB9EC1AB7476FFA937DE4EA287ACB5095F6D6FFD20CA38F5DF343B3E14
      D4B7897FAECCDA97AC46B69D664EFAC391AD10756747A7FD27A730AFAC91F4E4
      F9EBE1C03B3A3C3E7307BA92E44F9158C265345DD54501BE3FCF9234B329FDE1
      FCB5ADCE292D8622CCAF6922AEE24725B53C9C626126E64806E5D2B93502B326
      3F7D7BF39EF78C65818B55434E731A8AAD56CF08F1C155246B17441511D6EF2A
      21B4AC9C880638A44B45A3283272C106775591DCBA5FDA8DD073CFE9395B64C6
      07AF7563A0C7E38AF8CF6E11B139E532CA5C0A53D12DC3FA228817551256CBB7
      699F1FB5ACD65741EF12E07435FB66A978608962C6D1ADA4B988EB166761C328
      3452A8E936A1AD568289F3449694C9D23E1D630F85431048572578515F6BBD85
      1A5DBB639D929B423EB96B3CC96F19110EC1E700E02A53D554A1A914F5EE9043
      6A1092B95FBB551F4A79A2568A84CB0CFB8F93D2833F705035B7B7AC2523F024
      3B5CEB93D75459B123C428510F5EE9E9DA215C49D3DB3FF8EE44E36A4DEFC5FE
      2B5CF6E6DB137BF1ABFD1F5FF2767922BB883AF5361590B89DDD8AEB4A3A9F50
      35DE7D38E7FA786657A4E9705E6E311C56B7830B85B3D02BB6A5E2DFB4F5B9BC
      892ECED24CB32187D546E7742C4A9F10A998D4D473E9DCC38AAC546C9E6FBCF7
      4DEFBA8ABDBB5233B22830A972E3670CF5D3DAA854D4EAD0597C99680ED94AA9
      B00A5AF557EA216544D515CFEF0A0589135303ADAB4FB576732C0E2C758A691F
      899911FD82B2B5E29E2E5657A225EB4B7C2BDDBAFA3147BFAB265A01758329F3
      7635E8F0046F47B21ED8BB5EB1B6241A3BB9764ACE6AAB29ACBC02FD344BB5E1
      8EC55CC9855DAFBCAE2C9CB480AF382B7CF5B5F02DF94ABE936FCDCB0F9D692D
      C42B2942EA8212FBB8A614BBDA76F35CD4C479A1AD2B413618A3C84CE1BEE07D
      B73AAFB50A958E0DEE50E9B7D6B414B199AB3B502CCB7D1B81C297EEDF0A9C1A
      A8AD9B8A595880AE799375D414271A145212A2A6853B927E3812410FE6074FE4
      4CDB9AA6AE0194140C5616D3628D15C7516DB4A859E5F262748717DB5BF62B79
      70B53B080DF14C21591C585759C467B1DF89D83E939C63E5B66ACA4864494EB9
      9E6F39CEEA1BAE72B360796E95D915BBAB18B5D85E25DF2917244A349565EAF0
      E7CBAF1CC751776FE56E9543C2858B0C3A61A7DB5B101EB406758D24BC5EAE12
      59AD64615DD998A4800CDB7657CD32E9DC09A972FE72A14B849639F306CA277E
      43F8F94C716BAC9C5AA3F78DA7687B6BDF79C4CB766F74BDDED2440D1A1113BF
      5CD27C2E1EDC25E338D6B7F170D8C7D9ED399FE5B9DE115D8A91016840932427
      26C76AECC172152C240E96246BD2157473515533B05668B5F115F993963BCC14
      3EA95A63C1A4D0A2FE420EBC34475849003DAEC02C32A26D3147FC5C15BCAC50
      7B14B1A31C05D51C0B3A8A276B164C6930974FB488BC2BD1725736513649920C
      1E3C81E5353EAFD9F3769E693D322FF15750192BF555E51C55E3517E6C2B9957
      5155AED85D775E5411298CB4E600AC8674B0654968AC3E746E24565FA446F8B7
      9E94C5F616BE535DB9140E55D122A3E33CA6EA73A5AE48CE6EEB646EB2E3952C
      07C732D72AD29A77E51D57658B5D50972425590DEED1D0E7991C4EA1C6ED56D6
      ADA554ECB451C9837077DC95F4BCBD55054ADBB054E230506A36DC425D68F2F5
      6D69310FAFBE522A4ADC0255DD129FB852AEFCE94200F5CCCC61F0B847CCD919
      3430A14F7D2A5908E2315D507971A1A4FB5E3053C83245E51CEB05C32B155C0E
      ACD60609A066A98558DA4F12F6DC10FFD68BD787DF6257ACF6F670E8FA473F13
      CC5F9DF86D091A766598272455A0B34BA658983C9DFD694336A717127C4B55AE
      CED3C4DA050CB04FE96F96103CF491347B407AE64B2D77C84BA15EB8152DBBA3
      BF319602DB2C5BCEA53DF0EA22DA3C999D420DA2A3EA95FF6A45A12832DEC879
      93D952E835221EBA46DBAA951C95170B627629F23F30DA22CB861BE8A5217354
      5CD1CDEA1633986AFF2C6152573B8331CBE472C6C7DE423037C9C58D38C53626
      C4DA7946C52E8F7C8D2A0AF28EC205C6BE841B355A08F161EFE7FB741A4EADB2
      7202AABD6AB5C9F94C2AC7FD024AA7C8ED61085863ABD0EF17D2848C6561BC26
      C8D24B55006756D5DDF3FE2B5DAAF8B9142F6A406D5FA299579BC6EEF4DBA499
      54584B49EA4B493DF29E9480EBF6131E88931F662401C582DF9F2492F5E0FDE7
      0FA7670F26F0F1FC465A5A91C8BDBD653DF35CAA12574052BF48D8CBA0EA9797
      F3EA96F2C5E999F76F95BC575DDB7739BF3A38C55704BBB01511D5EF5EF0BB17
      A90D0DCA37BB77846372D85C50F11CEE816862C5186D7BC34A3CA64A0C9AEFB5
      4A0EEE8E2A02F4F6D69A7E69E965D315A3B062F6E773B0364DA493C23C87635A
      C9487D28478999B9CF2B1DE2D6D22FCB2E9D1A4371E8A3A976714983F4BD75D3
      56DBCC89989C2453FCCAE04D52A6B3DAA7B87BE50CCEEEEEBBE989B504F9620F
      B9C3892344DC4A286AC5075CD8F3FAB6A673ADBA50A11DC40D5096E61DF8B67E
      7E59A0C3ACA510530FF0A5E09661CC3D6FE7D449CE28C943900E3BCBD95BCA44
      E3DD95B12B177048BAE124CD6D59C8671E7375B48A239B2ED6321FEC5BAB23B7
      EB8D513A7F9C54AB49E5B6FA6EA6DB5B0EE5C6DE2FD53A2EE0CB002BB7FB518E
      F798705989B2CAA3F5510C74EACD45C92B3D382B2E71B64715FFFAD202F4BAF8
      B41826565F59471AE663364C704BB99F286D5F21D7FBDD506E987268A0A61B86
      6B153CED387E99E424EA1DDF3079ECA9777C15F0973FE330E925FC8BACE729DD
      D9B812DF9CA6D942BFCC9F7ACFD27442ADF8DFBC33F6DDFBF3E7C871A24A6131
      725D136168FE817DF3BCA859BAD906507E596633692D58FA7C1D6A0ED4850276
      5A60B26D78FFBEE3E3B72C7D7ECB92178B7A762A6B9D73396F0010FEEEB03AC6
      A0A1390726EAD680350B760C12A99001EE31B6E0164CA0C3D48D268149ED6EE4
      858AFBED552863A50353C17C3EDBBA3E3310858A05B8E35B4C1B595AFBFB6720
      4C0B1079DFB570E59C8E66D11F3B231CB535003C4A418A621B606148C52504E6
      B6FDEE329006DD52FB71A19DCD2BCD3D2F96E786418BB9517F85C46E79F91315
      E792E4246552387CAC27A9E2A0550733492E294393FC13BA05954C79F17EDC1E
      E0677BD4EDE09FCEB037C23FDDC1A0877F30E516FEE9F7C6BC64D06BF39261B7
      C34B469D5E4FEFE625E0FC43794C6B3CE645EDF6B8C5ABDA1D5CC77FBBC39E5C
      D71BF4079F5712081AEBEF3C36EF7C078BE055EA6984B80E5C97B43FDB2B021E
      ACE2EA274F603C147F550F5DF99CDD3F17172C8A34144F6ED6343BECAABDFABA
      D095416BE5138A7BE244D2292ACF28CFC4AD2F34B3C8FD51F9F521C976081301
      983EA2BBEBE0C2849730D32FBF24F7FB8778DFCD69FC309BDC9CC8BD6013AF33
      3D98311205B248DD21DF4E36A53E13095BAFA51216A1F732726E1B8C58FB2E97
      3ACB3C9DBC9327D36DCA78F4552205155A26E800C85D5E00A1FACB2AFC7925C1
      E53364EFFD946693E874EE87A6E93D62FCF8E737BF3C6AAA4EF7592AD1EE5F70
      DE3E8D76B3FFF92672536092C1F992AB9D19513C2BF95BBB77E60C5F71D83987
      6DD36699A0F153F1E1E7DA78AB49B02AE0474616BE1615C98EFB95CF22A4CF34
      72CD7B96CA27ECCEA542414CFCF39C60A2842595AE3AEA6C90CCC095CC18E6F2
      5AB8DB8DDDFD6C79FEE02BFF33630BF683E579359E2CD9070E9599083089C09B
      33F0C5AE44943252D27FDB6DCEDDE3527CC4F9ED9EC11C250B1753E44AFDF75B
      7E45FFA26CC1DBF904A2C9EE83B7BE086BD3FFD4B3F91652FA02F777DF4681FC
      D27ACB140F3CC07BFB2818BE5DF8C1DF6FA1803879DC1D709B869DDF400A98D7
      5F4399132816BA3BEEFD04E2987022B75108EFFF8368E45FFAC39EF7982EC2F0
      52F206597F9E9A7CF668A1FCC636095F7C53A685D56C17318501A67052362E93
      E82A6760D30F4B0C090919B31EFFDCE6DAB0287F5EA494D4684A434CE9D05FF8
      B74EE8EB99C618D3D0723F4755929D0E7B7E611D793090C254BC5D04952572C4
      BC845600F3F8E1ECF9E39147F3DF7B1CCE9F2E1731FE74181AB59BF0A88B0973
      BE8507DE46ECFDEC5263F99AFF6E9DF4B29145B2AD8406EA37253208694E679B
      AFCECEADCF45AA0BA03C4EA4F345B8605EC34E2EF265B79223C70CB95C9A303B
      2B3BD2649322E7A15DBF49F76F106E661496C4A6294FD3192BD35D3EF1842982
      363959730F43D030436A79B258AE40BFD66896649C97E63A482907CBF8623213
      8E22DBC4B1E62B32A17ED320B32CCE54904E889D322B772E5EF274B177854DD7
      ACDF0C463C636EC905B347EB3B93B0E8849C62866CB05C72C77A6FCAB83A258E
      0A83BF48B3E457BA222616AF9AD87D21FD17B973DC06E962914EA769AE01ECEB
      DA4D6CDCC2C4A81131DF0C0C606A23785E35EA1319E5FEE2A0B6ED1260A5D19F
      82AD0C58F95ABF8991D137984DC38664160EB2B18250A8D965351BF94E61D448
      0C3ED7B4EAC745B0C88595E822D10A05C79AC3240B975356348492CBED10B36C
      E2A34D1DB40EB19ACD7A7BEBAE796BF0F089F03AFE72DB3A4C8C6BC6F22EC9D8
      2ADD6B947E9E4699E1E59C823B45EEA15D1BDB619D700C7EDDECBA1DAD2C6713
      15BA20C82FB92E2FFCD9F992D9A61541679BA05CF95AE6BCA73A696E5B278214
      F682DC7FB217F81D8F85DD6CF7FC754C166AF3A854ADE9359AD8831D796E925A
      8D0A13C3272386015842C18157B9AB7C5BEEA884C0E71649A3355F83CC80D53A
      B07969692329B250E352D67D317F76BD4CB92E33C2E9BE7D4ED6D567ABE64A4A
      26F83CF900AE936231662BB916594CFB1159AA8DB1165A0266C24B5B32A7B072
      9AC50D66AFDFD46C41EE5A8E99A05149EBC54AAE5B59B6F8A452B2783DB7387A
      15F66679A0AB035A6DDE4AF86EA9172884B917988994164A254ADD18DFBF0C5A
      2D7185CC2DCBF7BD19745F6BC8F8F3B9F7CEE20EAA47B066C3BF4BA015198636
      1296568A4C0BB924F588AC3AB4172D678B6462D3695C5E9B60E08837B2ECA95A
      F7C9FFFCFC75EF17EF39BBC1825ABF7DF1FA198FEF5596D67A06383995397C48
      C790C66637314AB4D69EAA8A6CACD343A4F2C4EEEA2D6421A03A4A19355B9CBB
      D535C9BCD4C4F383F580EE8EB85F2B7994BB4DAFF12AA585B13F99344AEA2F62
      432EC3BE823928BE9BFA31F43B96635FF6B6B21E52272E184A453ABF029E978E
      95DDD56A4E7645D921B20055170121DE656C3498F8EC05F095AC8304F9582F55
      6C2F6624F5045F89067AE0FC5F30FA17E1726103985A0EAED55EAEBD9B6628DB
      56840EE5E3DA264DCF1E2DBE8E099F8046D3A9B7FFE3AAD4B9AA246DD76D2277
      D0DED9EB8352715EE531B8F0A76436ACD944EEE6AE4A6E20C3C673A840C234AD
      3BE62A89161752395B22B8ADB6542B1CF3D03233E35B2C1DBD4F4A0AF99CDA9D
      C63B16E2BBE3B39747B9B76385E51B1847C97B7C2AB0ADAC1CF63463D63B5227
      FDAEA81B273FBCF1267E602685DBC0E663A658A3E9D732F71BED4F0B9AB60068
      15A824874074A054F25341255FC95C9F11841D1F7DC7E255DB3333F70E6C0F32
      ECA9A88EE2207F020A4E97B633A14ADC70992FB47FF3B47E9E8E3B66ECAAE493
      3C5F2A9C8DF7FE70399DEBBCB2E56C66FBE7FA5AC822054FF6B81738C0EA1CFB
      4A66CCD89AD467A9772614AF72CCCD7D6D5DCE3CE5B6409A361FEB73D89F537B
      C149704491FEBE9209AF46E26C3E942098D1FFE8CD7DEC7919E567EB6FE2D44C
      262584879665A793A87E9B7C87FA54ED3DFEFA7B96CC2F4A50931B9DC964C30B
      B66657283045CF6D41A7F4A5124E2A6D3E0304FF1123FB9F21B7F16BD8ADABE0
      751CE33C31650392233FC05562A342682A6C4C26950BE25C1343CD758C137E25
      81A36B21E6AF63BECB99D65E2A5635A70ACB5C788A4233888C4966C57517895A
      FACA8172AD9B3C5F66AECD66E7421F650556FDACB4DB97A1921661340560E7DF
      F8BB0594702D46A14C61BB1512A840A28F4CD1FC095F2A6050DD44EEDD7AB5F6
      37694AA995FC4203FD8085705C8E97ABA1264D6727A7AE44D676DE4C44A7D623
      516DA2A8D9EBD7E952AB492BA0752E842587A6BBD7DD1BFCE94F7FAA9B17F643
      AE1EA9BD7D65AEC4C4BA450B156757459229B7AFDC47FF868D01F011927A62E2
      85F8FDABFD945CE96EE330A5C894E76A171D758C5A08B8862E3FEBC1CBA0C02D
      AF15F1C21E816C77EB4F35A5B366EB7ED7AA9F9E1E15EA4311C2D4F5B5ECE6F6
      763CED15879A901C97C15DDBEBD58F4BDD75587F74B83825F29EB3EFBF9229A8
      2DEE858EC3C0FE3EF4AF18D0CDA23D934F6D6A4FEEF534C857208DD0B255DBE6
      6F4B26B9CA136A3B69C13DAC4CFB229D14709B36DF44F2692E8D4D66D5187F05
      9285641A2EB2894B4F590F71912597990E2BE057F55B8E35B3C7C1136857084C
      21994FB4554B8191E4D011D462903487CFD12952A00CA4FB0403811CC1FD977E
      680E027478DA39761B4588D6D38CB963D34A6065C9E972B9506B5499ACD82DA0
      CFE45756A8D56C8E7746E50F70E0BC6FD466E3FC2514F19D024FDE2276647ECE
      DD244EC415444AEB3E16C022DB385A2EE5D3757D6B19E2BA8B027E284095084F
      425B089CCB48A17E5836CD5D87A7B11452050C5A3372A5C58CA2165F49ADD30A
      F44CCD16E76EA550F8D8639BC951F48A2872136E81E3ADC09797B709C01B333D
      2C2515BA60B930EEC9C50A3ABCE8CA49ACD9B2DD99E3A63019248E2A624DF356
      AE62B3358A8AD672D1FC0A06984D281034A1AF46B32B44E24AE65AB50B6881B5
      5F24484B99602CA9EB5FC92CABF1B46641D955C3D06E9EC5FAD59A19491E5814
      70E02C61B34B50B369FFCBA0DD66C45771B7A4C48E642AFA1D74DBB97A794BFC
      25453BAFDF243AB6F6C5B16BC9835E30987274CAAE3F73293AD7BC62EE5A2AD9
      38592271DF9A4DE7CE5CA4CCCF2FB4FCC50F43EB4BF52549DF76F0A52DBFBD65
      532D952E9BEA0314BD01D71ACD479BFB748A29B04960448BB7A05CDA989E5862
      0540AA2D7872761C0FB4F51A40537299CA2542FDC21654F93AE0AF64711B3F1F
      1A33FFA5C883D9710D30FF873E08ADF0DB6D7C34919BF9329334BDD438097D46
      DB5B453B61D7E2808D9B5D9B63018C61A5ACED655501FC178C05AA79B52C7D1C
      B499B3FFC64663ADF19746664E9A5964FE6C521DF61F5DFB7D7B75EB6FAEFDEE
      8DD6EDB4A2FABB37D2EAEF4B93D12BD01D7C7C5DAD536BA6CD47D44CECEE75F6
      3AFF51B3CDFDF2D5C9B7D7EEFF81D5C93F58C5CD65AD12232C8DE89C93F8EEFB
      D323274DF66AB6793A72C7930FCE0EF7CB1E4CF51C6A98422A692A39072AC05A
      C49A78DD6D7ACF5FFDA8364765C56B360B0B848F73BCD7AAD9D0DE0F7A5E1578
      A22EE3D2861990A4A29ABCF3B3449B4E88B2CD41DBB603351B76099F59CFF151
      5571A5DFF730B4CEA70E4D0642D7663134196CDCF1D28FCA9376AFF78F0B14B9
      F953254A32797707268C3CE60F122CFB5154693D24116949330E1DECDC7DC893
      7BDBB9E774001F9DBE294C27DB28CB841733DBF9CBC23F49BC14C656DDC4E146
      97B1751CDFB28E83D6FCF1ABE7AFB5CD59CDB60A4B890350E9083B93147A9BD5
      201E35EFE0400ABA6B36728EAAEC3A6E7D9B753AC71B0E5C3E8F7923A423C7D2
      3444A4BA8724D21CBE38687AAFA5D083DEA3CA3747A72F6BE79FDD3038EFE7B3
      A3D3FE13E172CE6E7B7374F27DCD360A6CB8FB04F6CC2FDA285CB944CDC67834
      CB893DEA3BEC462D7A63290DFD5979A1FFD6D5A25454389CD78CBEB92B5F9CF7
      E65C13146854A651643B27D56DE8DB5B87167535BA9EF9D324844AA8999C7162
      26916BC5668B7A1C88B4EF4D4DC66ABBB9BF082FF6BC9FE8876382CDE271629B
      09FA132D19597958127BBF9A2C95FA13F11013F16A7B2B27BE4BAA7ADE445D90
      024F4D3CBD22D1C3BA2DED8BD5EBBB47B46AD7B799E11F3A3B19114D98F1C34B
      B579379444D752CE97065D32AA9C2DE1CD24B68925F66A42ADA73353378DF2D9
      E93E9EECBD6BEDF56B3632DA7FF79D5AFD38C72777A7986005FED1249379D1B5
      40767DEE6BD2B903BBD0A4CB4BE305C98CF5B949C47EB3B0396C768AAB9A91F4
      72494E61D0416FDE5300BB0B9F0D09B550C19F84CB8988064DC97A79D8D758CA
      D9F39440959324C8AA38FD1B87F5DD0EEBF6C661BDAE0375BEB80E747A7AA42A
      D081C806A6944E9681972FE70C78793B5465ADCABBDBA42C0C19C8ADDA2D948F
      4E29C67EDF3727F9D7BD300C3F4FAE5ACDC811FA68FF09F6E317AFF1AD993180
      270530AF83BF9A7091375CEB54EDE352B7B1175AAA1DE5FE62425C80791DD53D
      8B50F1BA5769465BB3216E6F9D5E5E67C9D4FBF144E218CF5924B95CF4F8B73D
      9B4FA143CD6C91142D991F4FC869F7CC7B81C9C7ECCA0F9AFCC4C6EA35E6FA18
      AA54FF5DC6CF1FC7690FBF1572B56EBBB5BDA5FDDD207D9E52011D3D8EA08843
      A1BC30EFFDC884C914C2DD16095BDCE8445007DF25919606349ED11F64F176B9
      2669C6F604B6C3404395DBA6E6A7D907B9EE60658181607FD66C6924136F0505
      B370B826B328D596B679324D2618177BE735ADDB4232336DE7475B8029A969D2
      77B2785E3A9BD40D66AA71627245E25D8630354DE3E6846C1AA27E2E9975737F
      665C8F81A9F6EDAA1834FEAC769374E5DFCEE37FFB2C8BEEA391F7EC5AD207AF
      34C3F21D64C7A4489E2CC20636B62B9A2FA1A56A36EBED2DA68B793BE465FF03
      31B8FBD29FBF240A7196EF2DDE6B6FBFF2CBFF5C9A7C7146802CF912FBC84251
      69DFCA2C2D01B6D51A5ADBFB59534DB45A5CDA48C2C49C2C25AF899AAA5E55B3
      25B1EDF6A2023B8AAEEEA48E22F59D2D690F96E71A3A96ED226F99DA74AFBA8D
      7856897A0A9B2CBC54FB6F8EC58C2CE1E4FF9AA7B3A6374B6230D029BD43893F
      C1AF933452AB7263FD7DD4FADBD87EEBB65FB70EB6DF2F9ED5334F89DE0CA971
      64736AAC9259B35DB3433E3DAAAFE66E8D0BD5D7BD5E4D17F203924501275966
      5774F0AAD9E0BF6A61B391151F9315EDBDEE465AAC4B8BDE465AFC93B2626D10
      E31CAEF4A6320F3E9FF80B09EBB9322975DB140D65C2743A25D79B48EE8BF3DD
      D46C6A8D53DBA6E993CDF49A4DE0E306D8868F7F808F6FB4FE1B7CBCFFA5F9F8
      57ADF949CA4E1163A8F2CCF3497A253D230C83B7751B76111D792E99260566A7
      2EB6C2FE195F9C51985B3D27B1BD65579F3FED0EF8EFD224CABD730D57499D5F
      66A08F7312DC9568C946F70C6459BF3A3B1CA8933E6F8AFE0E7E61750A9B4F42
      24477A5F04225D1005042A50BB0895084374ED6D58F0C759F026E87E83050FBE
      340B2ED9C1BE1474BE7976B45F4F848CAFC7012D8D1809104CB663A6F3C5B587
      A7F8D7751BE77BCB393954C7F29F9DEED7B5598F1B2E08C1D281C56F6265A361
      61B9CF02662D6E9E407FC8437F6EC8FF6B36111C3727B3184E7FDDD5BF3622E4
      E322A4B51121EB2264F8A545483E272A409D5D9E9A536D5B574D8C7F59CF01BA
      5E73E067AC709214B6C3E3FD17B51C6C3C49FD850B686704F6AA9F89E647EF7C
      C949789946522E967BB1F199AB51B381B21DF5FF66BF4F91080D5B5C2CC9BDEB
      00548D155333C1B2BF4B22A23B0A6E4FCDE645B0749BBD2C7043E2452C91D66B
      36DA323252E7029172941E4580CDA5A3E79B1148EB9BD50B9E3616265FECCD7D
      528DB55F0B139FF97A02E0C24496DEFF48360B7491FF8176B2AB65E24CD7ABD9
      E46D33B63C4FC3444A305CD505677DFFE9BECC4CC4EAFD7D7BEBBE8566F3F38C
      B6C7D17E86B1DE5C80DF3DDA38ED7E8EC10A07BDEFB5DDDEC27867EF3ECB78D9
      B56D96D790D1485E3D24A7F73A3BF767C9AFB0AA76DA4D71867576E9048BB53B
      D0026ABDED02A31552B745833E038CECE3696A07F1F4FFD85FC8D3FEFD9FBD8B
      42ACAD86EEBD4C4A209E89F6C7FE0293245C80D831F57B26772B87B0611600AE
      66AB3BFB1C1568AF9F7EDEF2334995D6863C30EDE7CB858539161D91E2DDFA1B
      9C739C1D04A6CB902E13D29256D3B0E52D3BB8DEFBF41B98FFDEDEDBB7E02505
      2B79FB16DA4AFEF6EDF696AB2F89BCC38420740B8CB5F1CF7E864BB7ABAAC2D0
      DF2F92C81A7FECE8A9857E7EB8485DC16BED66C0D16B8304BADCD82693211541
      633E3B393AB26902D8CD22BA52F41232EC3D6A8AB2DD5AE22CDE88303539851B
      B9038FFFDD022DE097A254AA7E3E473B9B9F8C3F4F674FF6B3699A3DD99F4E97
      339B3433A70338BF3066513B42D3913F7B7D78F6043F3ADA55BA401E16677B81
      71A7F569B67FCC95E820119B7393BD39B146E0D474B2AC63E59A4EF5D8453A0E
      5F3FFBBF1E0CE768523F3969C77A720B76706488D25A42AD572B3C36DEED3BBD
      DBADBDEE2649E5867B7BF4A5DDDBDA1971307E2AEE9629B4A7500120ACB45E83
      A590929F983E3B8B24CF5C01CFDFDE9AF23ADE50A050101DCA61A6D58DEBEAAC
      DB3D4CDBA64B2410F2EFA556C9769252B85F7BF25F139B0B5CB6766D4DED4406
      9DA795FE3D59BA502DD89F9D4F282AB2698905BD5351985D97F4B4AC65A3DE5A
      B7AE5917E9E2D25CE7D5AACBB274D2D65FEEDCBF53E4F3342D2450383BDC65D3
      26F373E6FEFDFB73BEF9A441D31BF15B2C5B597182C2DCBF73EFF1FDAFB21DEE
      2C9D99F5F162E2BFDFC177FF234E6638818BBA9DBDED2DF699F24E2F92786141
      87A4C15BD94889D6F9653217C0FE5410E8ED91C475301676A89CC210CAD8CB7D
      19DA3A3FBD15AA4CCEE6B3101BCC4B567025935F2E182A82CA5EB7C5B8B114A1
      EBC4FAFAFB0F722741B69A693F2A59ADB915AF452BF5827B2B0C16B1970A34E5
      9AAD8279CF725E73E7D8DD2A082895FFCE4F262E30564F900A1D95B4A4B03DFF
      E8F53D87D8B7F15FEC93AAFE92B50BA66DBD4CB9B7C38449E9F8248A5EDDE895
      BDA7BE39204A58C269CC26D7DE2B46D13832E9B13449E641EAB30BC5511E4A83
      34CD0BD566534ABC359B53358BDA22AEB90343E78B5551A325F4A0D89FE40EAE
      F49D360F9D15F9D6EA13AC638F3B5B3AAF414E2385CF0ACAD1049D4D53EF9136
      BEBAFD3286431FD56C4277449E2BC5E0F953FA6E14D15350435C0C784748F8A7
      DDA6F7539AC10099136CE059965EE58CD7EC4F16DF3CEFD6EDD4153B32A7DF06
      B6049BB8A4E9E5D4CF2E2DDBB7D90E4FA53BDC37EDBDBDBE7372FBC5A54D8FD3
      73DF9DA75EE08797359B6A2549912DAE0B98B79F4E5E1C121B2675EEDF597AD5
      F41EA5B347156E59B3B9DCCCB9DF090CA663BD6F4DA2D5156692D85DB53394EC
      145CF6834F3F28B15820DD66E0FB9057DAD7269F1000528B0370B4E6DA6DD972
      D3EB749915780D496C81226B36D3A244E2E4666D8D9DC7CE4F67DF9D34C5CBD8
      1444D7A67A53E7FEFC3A5BE642AB4DEF5BB338629BA5436D416D1B5D60518A84
      EC57FEBB975225E2EDB063ECA54898BFA6B3AB6858B7FD2F5645B3DD65BA3B6E
      BE764B77397C4630B46DC78B1F5F7CEBED9C4FD2C09FC857F8E0D59E77766104
      39FE11FB4F7906ABA2004F07DF33DCB1202AA94DD4B27524B6EDE0B5336E35F9
      46803D705BA586A42E6BC595EAB995FACBC9B7879850E03CBAA97772F41CC423
      50ECAAFBD5120E98813686A9AA0DFDDEBC38EC54E682D57FB37FF03D8EBE3850
      98FF54BB4930D6F6ECCDD961D175322DD2008334BA96166A79D1A31157BEF266
      35A42899C789C1A512DE3C387AF142CE8548C373CDD0F4D5712A1184B8A6D888
      A7BD2716B0DB467165025511FFFAF9E95985E77A3BA25A3F3A4D24C26EB59B47
      56FC8B2210C7BB9B18C927C448365564376224E32F1D2331F9DC621ADB5E2ACC
      1D63CB46ED0568F269CDF6CC4605BA83A76CC9912F7CB69E86E21A4F2C522154
      9BF3CCE4B96458871A18A03D3C49A9CBBB968675338CDDB4864F6D7F46AD3E2B
      641D44041B912C88AF4BF537F78ECF5EB22222B2ADB257AA8167461AC5E2EB59
      FDE2CF5A85C0C412E1AC2366986722C0F3BF2D19FF0F326CAA59DC9CB28D679D
      276297A98383F739281FC1EBCBA1DFEE993DEFE7FFF526599C2ED2F92FB5F332
      8A657C184C8AC6E92BC0A31AA8D30EA8B9203286E9721295ADADAF452512FD33
      B5DD111495B16E675554CC0241D2D6C8482F9DABD27CB6A0A89C42A44D08EA66
      90B1B2527924A9D33148B624F6C305A1FCB45FBD38FFD5412C2A5CEE72F8FA6A
      8ECCB5596E798338945D576771F0D56CE27738B79ADE0FC712FFCED2C99AA76B
      3FCF7970A7FE0CC49B35DDDF81F36A09E5D7CFAD654D4BE5BC7F39F8FF4EBC1D
      3373E901BF32BA51C401FE6377D500A13155E7D9BC79797C5ACFB2F0C2A33315
      5F441AE4A9A422B2186652917C4FBD97AF0F9F35F1F3F4B0E93DFFF6DB7DF979
      CA9F67A7F59CD4D2B6027A71007BAE6A4C304BDB4415D9F5C3E9F76FACB655D3
      5351706A9B002E4108ECD53B36674F7C8655645A1E24189901795F4DA7A2AA47
      052FC535991137429D4FC9A343B5251ED9C6421746D2592BC2F3D1E34EBB37EC
      8DBA83DE68AFC5FF1E51D66A8BF5A2E7370D779BDFAB0FA2C70B8AF45F0E5EFC
      549EB9DA694C6BDEDF06ADF6B76FB5A98117B086356FB8F4AC75A76FDDFDBD76
      6ED55E4ACE43ABD9663C5475ECA46BDD8C8ED755B4BD2ACB03D109A2460D8B5C
      ED04942BBCF9F6E4A422DAF1235BCE0B447C7F71719E11A548D1D1FD77F5B3AB
      5666730B8F7BF9EDD173A125AA2CCA02FEF2E2F541F5D4D7773E8D1FB45FB38B
      C2FDE5F4E8B0011696D5D0C02D4B4474EC1A505BDD8C576F0EFE5FF396D0CEA6
      07D4A77812376022EB9EC4EEED1BF8077A12B7B72C0E152CDA27AFB0232F8DB4
      51A1956B2399CB19287DCFFB2177EDD6A1966823416E71AAFD356C762323093E
      73B0B3A4722CEAB2DFA786504B32B7CCFC6D99644429D1DC6AA90A8EA47805EC
      29AADBC875937C2C3323C277D5FC721F88CE1B5F17A55F8F68AE249A3A2E6120
      EE65CD2627EE85FD0A1531750AACC368E28D267DD56DD08DFFBB9CCE05DE362D
      F40D15C88F7297A43F4FE7CBB994ADD56DF44733BAEC9E58D79D545A403BD26A
      039B1359B721BF48CF958C19BC7B67B2AB2CC1A8668C5F765F3EABDB68B7B77E
      7E7F080A2106F50256B8791F1AD76D29A3638AB1641A771759BA3CBF00AFE507
      6F5C140467E1C2A7A92E09BAF9C29FCEA55FEA54ECC7C0307F395E4EA4B12AFD
      EE1E4E88D67B8ADA52B7D5703585B8F43277F2A302ACA2553BC4EDA327A204CC
      DFF3DE58A310FF83ADCF0C51092C88DFBC8EB35C0F547F201BC8362C23FAD4D9
      4B2D6BA20FF6DA62F7ECFE914AE5EF51237FB70E72EA9CD54F6BB6A15F5E3FFC
      E28DD25F555B255109A9DBA17B75472AEF4ED9E32B33E74B76C133EFD9274CA0
      5F76EB388D6A7C66E7EC851F401B8A683E35BDB3032689BFC0509FA5EF6B37F8
      534B203619C10F093502E126DE0A572BA75124A955F9E6B97072AA796A448039
      42A935F8DB0A04A695D76E9A2736E6915FCF16FE7BEF026772C2734973292B12
      DFADDAFA60B83761CDF30DE75EE7DC5FBCBDF38F3E6C70E92292FCCA22B6852D
      00A38B54100EEB76BC5E2FA55C5BE3025FC3808FD543882D69E2C7803FC6FC31
      F276F8E3CACFBD06F33D24F19DB36A3C1C9DEE6592871BA6B0CE14BE78DFBF03
      16DB4DD32889131668094ACB74EE2F92209924B0BF20B1B7B72E700621B80F0D
      2691787F3912ABEC2F475D0729245D64F37499B1A28D1936753B98EA2D63E7E7
      571C6A615DE6A9B79CE56A782B42BCA82C1614A2EC2C6C7D9EB59BD7B3EB85D9
      E7B8BD89999D638BA0E366B48F25483CE87941B2C837B1884F884574C69B58C4
      3A73FAE26DE664977018CB06EEC135985532F5679831311304F3E56D3C89A863
      FFF7DB7FE5AF4CA6F03E0370E277FFF5E6E8E4C5F1ABEFBDC6C56231CF9F3E79
      528C652F32EF127F46D8813D30D027F8F7C999C9FB1CD6E3634C217FDC1B0CC7
      9DE1683C68787FE7C82751964F16BF75CD9693B761DCF99430CEEF1AE3DF417E
      39742CA53FFEC6AD37EF41A7E2C9BE1EB6466FE3345DD85F4398A8EFF98B9945
      B30B9319B99BB730DC4EA295A729C98593B779BC98057FFD0CC1AB5A1D619712
      C214FC6446701EDF559B44264C49D03B2736AF76FFE4E57ED37BF5E3E93153E4
      0E3B4D96B9BDAE9DC96BA774F40E1B6FDB112A068177CE0C513A9D8F0F3546CE
      E8D224F99557683A6D3DA7F2FCAE440BA94D74AE2E85D62D60E26B36155B76D0
      EA794F311FA638A7AC5467E123D4191687082E443EF576F8CBF9459A2F7625EE
      504413EA674D6D6FE9B44623CCEA50F12DC5AD4295B3681289ED9A2CA7D04393
      05D14EA0B961E084E3D7C69279918DEEED444B894CFBDE85AF1594998160111C
      866079BECB92525C9F100F93569A9A688AB7EC3307A46E0B6477BD3DC6FAB8D2
      F00B098BF8514492C59AE5B9F79717272F8AF47D8B3D4F1C1F0DD96B6C81734F
      73A3D74ABB00880348DC4C6A88B6B766C9F9CC15D0BAE4B0E3B397755D911656
      441CA415080D295710688DDC766E00DF4A225BB491EF79FB933C6D8ACED158BF
      B74113877583CA0EEA36EDD79540A2C575A6B3955B2D05CF103B0BA6F10B256B
      4E4660C090A934D76D2EF6CC774A9A3EF0E7D0370B74389B8C35538818293432
      B6D920F317B7B75862142534EFA8D960630F8D8D07C8DD02122824CE38624EE8
      7762AF903C1E8C33661360BBD3E8F9E23D59ABB11346B94592177A88445088D2
      1D719DE67E0E1DCB6B10C5B9E15D9A6BC82DCAF19AED2A6359154C1D87B75537
      D62391C32A9FFF435D279B984DFD98C117EF0E7A40676C266AEB553299880477
      B94EC6A36EFF1ED3924037D47E4AF84C2F4C16AC2A8658DBDE229A7D8A715EDB
      EAC7C05C24B3DA69FB5675EBF4A9BA39901B5BF0A268E252FA6D6C43CFBA0DDF
      192BED4E5B744F0B5B6B2B82D3D83B81C2C5D89522EE0B4893981DD04F4E0A58
      DC02AF503C0413FF5A1DB99A654BB54DB575F93A9D416B7F2518DFF2E4125CF7
      2F072F4E9C92BEBA74B648AF6E8BE796AEF5647BABDDA6B9572E0929DE95A628
      A265916DAC99BAD5F59BA4E9E572EE454BF14B48EE716429498AD059642D0097
      CB596626491D8590336186588567DAB5C1A611FCE09A3CD00E3BB4899AC5DC73
      C2EAD5742E54E6D546F11A168045DD5E0DECE1C46906B53546DA6D9EE9FD1FAB
      45435EBEDCDE2A411DA4661C27506C138D24ED79A7EAFCE276D9D697FEC4A55C
      CBC1E4192E9B995BAA35E25A8338CAEB4A9B2D9ED01FC50148B40EBB20CAA468
      72F1AFA3D397522BB6E73DF3C3CB7371A594A8ED93649A583008E982837F0BE0
      0BBB0C927D5C3F55D62DC150C4943A0A7DEF6F4B932F1CCBB52CDE6C6FBD5F64
      BE6278D8231C67FE398B01B5FE099C3D30AE2510B8F28709A69679BC85D86B0D
      B02047E2445DA906B1D5144436514805392A7413CFFC775301ADDB83F689C3F0
      0323ACF48BD3ED54715ED00E3271CCDC8F773825C571A18B4E5D1A5A765DB7A5
      710B4385E6B555D9B82E4A2BA084EDAD732D0CC59AFDA77CB86FEBB099F3EB3C
      93659EF89E77A847830EEAA6A39044EA39884891FC6AA272792CF28FFA465873
      57D7F5A1AFEEC734C154CFAEE7C682AB4267A2DF763E37D0AFF7BC973AD75CCF
      C7CA49F8A737CDBE9FF1B4C89C3706DABA81F6C57B6F977A7F1774FC8344896E
      789E553432CFC4F2C3A63B9E4E76CED85E989034F4C989E27AC0E4D758CD87C2
      F40B5C353C8405A13E171AAD2840C1652804D1AE5DDCD09D7651056D9328AB35
      D95C1CC5DAB138063E948173B68EB2F8E691B43973F3E4FAC8E57B2EE011A526
      9715DADEA2E250E9FC629FEC5295AC1492BFB07CEA034E692E63256D62E18361
      2D9B9CBCDB784A4D1A1EB5DBD41C1A549F61D22ADD36348015A4EFC132C28B34
      53FF40902E88B34EB44E308CBA1D7DFF5D9A10F942D57AC29C8504C760D0DDE9
      366066A927755D910996E7749DFCA199B15F6FDADA6893B6B67E7EBF3818E7F6
      D64F946C0B6613B8C6882A60127A62D962555B5B189836AC79C1C1154873D796
      44F585B25B8DB495C57412C237BD32EF9762339C2E8C3F153328BF482DFC27D4
      02ED08EAE7979E1F108B588661A51FD8C3725A5350A73716047C47F36E1C9AC9
      6E81B34C2549836153C82D676DAB3EC419BAEAAE4318D9E92C48B39977F8E2A0
      9E936D1059C12A42DEF161E3B6FC23EB5CAAD904CE38701B452F2ADC6F0DA8CB
      641C4A62CD66B16FD3DB790CD5A55EE910840FADDFFEFF78A356AB6E7D7125B8
      60C4FB5B74540DD389181AB3C8B5AE707951E0A792175ED3CE46DB5B8D5548EE
      023EC1768C0D136A05AAF8DBD6242FF65F1D6ABF0499307E392EE870475B3FAD
      F67CDADDF35ECF2A6D3D2C2E8676A67DAF0595DAAB26F9B5DE8DA08ACEB4B7E2
      79523D90FE3B367CBDD1A03E41831A6E34A8350DAAF7C54188AC94FCC1C6FDA2
      C49FA40CB9046C646C5BB809C05E7B6F54B3DD7BA159CFE649646C02B4F1968B
      786493A5E9B2C8FC593E2933C16D7E6A53EB87AF85954DA70A3E0446C51CA0D3
      4576B4BD25FD08339710445C1FEBF45DA4AC10B72092355B0F0BB104E6AB32F5
      49E1E06593C11C938E22E809AE27EF86657D02CB1A6C58D63ACBFAE2B8180ED1
      E6F5E1194F3584B2A86991B7B3C8D265C0C41BF1771EFA57B3F32511C54C5E3B
      53ACE8CEF4BC00F72736F6FEC1914D3CD452C920990BD2B3582FD6117B2C366C
      594A9AB10DDE7A7C5C31D2AD4D0C85A5A8A7B8E5919AEB5FC60FD51CAE27D0CF
      BECD32111C7C8C97BF54121E05FE4282DB155808E8AAEBFADAA6FFCCA770BFFE
      86FBAD73BF2F8E2D61D906CC13F65290EC0676623A7E7378EA3A4528EFA8D9D6
      AD34A33B3C62CB289B99B1FFE2E03BED0CDD38345A082E2798BE7630F346DD58
      7755FE543A1BE402E59719E9A9620178704D87674A4B0EF1F3B5E20993CD3B8E
      4DC7482A258B0CAF41CDF6B47CB19EB3AEF05F29AC942C01DBE3B3981AF75238
      AE50A7FFCE2D87CEAFB613A3BC25A05F65675E2AC6F81B3181765CE7054C58F8
      636F57A2A8D24BD9A5D1103373563A15A551E86CDD4F509BB90B509E33FEA649
      2E51F5B2D161DD86AB00D777D6919EBE397A51CFA6046FA47CE471208011A547
      29BF86CEA5FD321BDAC8596B521A5A53B92331C84ADBF4AA0AC356466C22B148
      EBC6201BB64A4E6751B7C1ED83775DFF6ABC17E9B90E901EC92C83493CB92EFB
      98DEC3A83B9F3A6A19A38FEB8B51CB3CE28E977E54EB69F77AFFB8DA23377FAA
      DE934CDE4D6EB7FDE4317F54CDD6E575964C8BBEBD93F43EE21DF7B653AF8349
      F28EDEA693E58CD9EF7A9ADF64294386ECA877FE61288D4F582C4CF77740693C
      7DF2E4EAEA6A6FC6C8260CC85CE029523BEA27FCE449AF3D1A74FF10E48CDF32
      A0BFFF1D26F30628636341DD432E9686756CF376A6B2E5A997C604B4968E192A
      B444FDA33ED7784D2F7083AABE0AE5672C1D62CCEB49667C3C3D603958A12862
      484DEFD4FC4DD0219A9E75528B0FBAE99945B8573769FD7C392146F69C4AC825
      4BD8D5AF9479CEAD2626DAD9C661F2090E93DEC661B27EDCBF38EE5EE1697566
      0E937F3D98086C0A06A29F482B4A9A113629686FF15E5288B4A1ACC0A2A7B0E4
      4F4F0559480C7DA790D76CB7577176DEB1FC4532722BCDA540AFFFF9C3E9593D
      072E4DD2B5CB9A1C7E22502CE7E24E080C81358A348C0A48693DA7B22FBEA069
      2A49E71373EE87D7DEC9ABFD97D6D94E7FC99F2D85593001FB8DF639A2AB083F
      5FF2E74F47FB6F9AE2258398393EAD699E954368BE7DFC854F45E6B8EA5559CE
      723F36EA079B5F97E569CECE152021F25A3D9FBBB5AB5463FBAA5FBC5769D1B1
      378DBDC3E3FD171E8BF1E6B573A2140D12944FDC6C40274D7AFCF3289D4C0863
      84077861E6E7CC23665F1B9B34E99A65179AD4E18B83BACD9575835EA32CED6F
      D8363704606581B355F16CB71E7157C6E9849221896D2229F5432A8075E3F545
      7E128BD2215EAF4B61862D7C3FE859E752DDB6E43BACAF777076F242944D91BB
      AA7CDA4A46A2E49200E3522DDDA89E9FA07A7637AAE7BAEAF9C55155AD687C59
      6D54EA101648E3EACCAAFA1FB19BD2D6347FBAF140DED8CD7A78205F9037A8A2
      9337BD63B25818FC73036159A72DC3F09EAE8EAEE97DC7CEC76FFC6C81DF9FFB
      E17DA5DDDEDB984FFCD03CF5BEF3930C033CBA36B55CD803852C3759AD467562
      34CFB15683621EA2C7CE39B51AD5F7CEDE4A674FBDFD6C9A66B0518C3FA7836E
      7F3A4D9B3CDA1B615A37616AFD38345D9E88C1F593F86C4CC674092A8F3F1C9E
      A8A6AE55DCEC86E4FA1D43A8E6B97FAE9AA562FB8081FBEF5E2A2C46CD367BCD
      5F75C340CBF736CA414D9583676F0ECFA4FB0C5D01DB5B8AA3EF3B806EFC29FE
      38B5A9A55850D07F61A7CD164A9B492CA5340B6FE23379159AA0B753E674E9D3
      C446E283EE2394709F0A070C9345429C15C542AB8E9A9F63BA9179FFF9DD79F7
      36257A4A3DDF42C5ACE2BB95339349D56ED4F94268E7E646C817F51B74E1CE28
      B8B2C06ECC2EC5FF7798BCC3B8176956B7E0D9462E3B2317F68479FE176F7E91
      CE0C73CAAF4412DB188A3A0C6D965625FBB16E92F766567EBE9A612663674848
      0ED98E4E6F0A7E3C11AEAF1D72D5B8E7A57FD6EB4A283ACB4B042271B154DD04
      9C9139F731FBB9D7AF3BA60BCD68EFDF9C3D4D1E9B99E2FC0BC0162136F10B41
      214F8FFE53FDAA3B2C50209C98ED2AEE5CC40A8BEA33653234759D6AC18A34C3
      5072F06A8898A8B99B07DFEDBB9447A14097C3A9E81F17FE84EDAA406B5ACDC7
      E0CB219D002F416BD7F4D8D7735687AE938484516C58A5A947CCD7062116F069
      E5744AE2AA8D34D56D62AFD24AAB7719758387E492D2F98A0049FC4BA12A3195
      46DD86EF622892C78DD168E50DCB215D157932134439E63F4725C07F5DC66FD3
      6B9F2713E9198B737D60E3579A044A805FE96D8E9D50AFBAEE54AC37E4D05759
      53AA3BC7AD9A6F6F49BBF8D7DF33077CA10B60AFD625680ADC95166B29028985
      C4920E31EF9385C3CE3ACFFC695371496EBCCE5AB2EC9E6CB21A020ADB05AD20
      0938F3BAA6E7F05471E0AC4340B4CB15BFC213C9312705FCBF497A2EB920CB79
      2AF0DFB5EB46A25ACA342116392B0885388578217B1F2DB4B733839BDB5B8F72
      1BD974F5835919382CA84D2C52EDD55274F051EC1B3E9D642B0F97A24BC947C7
      15F20E791E5FD4F4E6CB85444E67D5C86A96A60B175955C5D07D897535E17221
      4F13D5010FDF7169B47BF8B2E961437ED4DFCC22DC80557D5234B0B38906AE1B
      4A5FBEDD88A6AE9F6A8941DD78095B729408B89A4C60B2BA8D522B4BA0790402
      D627C0482C80E4E62D885E4354C934AB5DD38213D8C4D300DC6F9EE6B6DF02D8
      267D1A86D942E486535F309BEBA83C9535EA9AAF6191C745173CBD48E2C53787
      C1E460928497751BF9CFFB93C92FDE4FD9B5614FE20BEDC7C758BCC57FDBF9FB
      FA29EFC8295F1F53EF5307B5BDF5AF7B269FEFC98B6E3CFCF7B2905DD2BBD522
      D5B496860BB5249A9FF75FBCF8C57BFEE2F44C0A5A3D8E4A13AA567DA8F51CF7
      D1E1F1A1E70B187A5E827F155EEADA0D5A5D17D56A0339A68C6D5A7A9954BE2B
      21737C4B41848A77BC7551C2E6D4749E8F274F5D7C845DD4A764A6D4D4BC1C33
      092F146C2E15905385215B996D2D1BA757EAAB699E24D258D06E9DBACDC47B53
      C9517FC24476C963172BC5E6321A6237C60583E3E46A3755F1F168C8FD651A7D
      0FA5F5F8E5EB43E7C67228943426DFF99900991475F6F5DB3799CC9B17879D55
      30801BAD808475436B01CDD6710E1A53D7EE081A23AAE2824B2BAC983D486AD8
      9DF567672F3ABF7D7AC5F49C8B64EE484AAB3DB001AC30A8F1F04F67E9D5B577
      657C011EABA66427EFABF1B0FD6C71314DD36C630D7F8A35DC1E6FACE1756BF8
      8BF7DB4BCAFCF5F5F41652B8DA9F12AC90580531BC6CD6C086E43F81E437C075
      3748BE061D4C9EB3CBD472F1EA47216796964CFDECD2B6E772786E49EC45CB39
      EC0D09256B0D11CEC33BB61822CEB36493D76C77B51D9B5409A98F80FD01A5A2
      63E111F4C4F695AA29D276832568E4455AF29C370A1CD48B7439892ABA9CF649
      922D320B3F9978EF121E3DF143D1DE925C800D83FA0406B5C196BBC1A0BE783B
      94EDAD480034BD90BE3CD691F90E9FDDC6735C1EAD90BD3609BD48B591AAD474
      FD75399D5BE4047F514F28A61BAC2A742D64E726BB748C8A09139CC7D18C11B2
      376932AB1B209B9A6AA762AA09A28C18CCFAE937DB5BF69B379CD391CE49BABE
      31DF809864BE2768A0115B9E89FB87ED315CD6600138C54772DF8BB24949F9A9
      D94A301F6485689968954173BCAE967B1A61E4575E3A375431E92A110799E79F
      63D8359B921269327B2C68826EA4ECEDE8BA0E86B4C8B553714A54FF85A302FA
      C2445B48C8783915A69D9D3382ED87AC31BB4AB6B7A4698AD16F67841B9CB02D
      AA62FFD74EB97829C8B49A0E2FD3D30F4E2C4C2D45AE66BA5ACF11A1807FD2C4
      FFA70EEADBBCC7B22504BEF6274D675D08DD87B8730307FB1191DDD9EBEF6D2A
      4C6F48EC2FDE0089FEAE9C3DFC4CB6B80D1131C4E78C2BDEF49F6E48FD03A4DE
      DE90FA1AA9F7BF78A70AB66807B93FF5E249AABDADE7D4CA44FCF959926B8F07
      4AF809F3F21AF1F2D75FAF1BEC5B9910CD8BD9C899C9190CE279607AECDA8330
      DFC064FA08FB501AB04C76327F5BFA1341D481D84C97E717DA30D925445AE558
      7A6DBB70BE1F86CB8CA82FF8DB2A283B3D2FB85E98DDF5176BE7CD3DCC5052A7
      24E78F10EE2C030A355F5C72A6E4B65C556B6B99B24DA91D9D0E597D09F2C9E6
      A47FC2496FFDC7175AA5DB6BD57EF32A7507AB07AA58232C8AACD127187D8D13
      A3B46F8D3D0D35EEEDED35FEC0B5F9A2ED59B7B758D54D655820FE6C8C580BED
      1269A09E9C6BEC78911923C6EFE37FF7EE5A36BB6AB77EADA75BFD4C6272B92F
      C1261C465260E86D927684D690D6A20AEDD8CBF67CD7128FCB92A8D2F8416A0A
      A75C3F7285D056A94745035E3E639729C9F297F02FA9E6F0F42F6D73230E48E1
      476E1667D2D430273462BC9CB87C663130A6D8CE840DC5A0812F19A15EB83C76
      88C99974D4519DDDF5445C2E9699690A66B63FC148AE6C7F467F72E55FE7B46D
      DE714ABEF571162D1D77CCDEF99EA779FFCF5F77DF280E1418E6B56D5FCC2F66
      B890AB32F1E773B9D02EAC8D8B97959576B44DCF15A94CFD4BDA0ECC4ADDDEE2
      1466455B3A5891F2021A0EDC229709527D01AD69BE844F51734DFBF1610E95B2
      91F55CA0E02EB20D5690543FE504FFB47FF2EAF8D5B74FEF3DDD687BAB748E70
      0D2BB4EA4B46742E0BA10BAA942D6B69B3E7CFB51BB4082685F4A7F1A629ED58
      D84B2564ED33A98F10025AE6424A49EE3EA5735C2CBEA2F789901FEF8E0CAC79
      D8ABFEFABECE8C22575ED81ED553396CCC989023C1C683AFBB22052CF913AE57
      2942CF66D19A305F3D33327C5FB3F21D960B643DCE20857C9178B80FFA6EAE36
      26259D88079F0B924C1C28BE608C4EFC8CFC208AA4A6C0BF82206F08047B65C9
      F0BDCDB966A3AAE59CBFF5BE7DA6D4962D15757E3963A4DBF706BD007373AFC6
      86FD2449621BF5FFE34A4177AFE51DFDE5CDD1C9F1CBA35767FB2F36B6C0BA2D
      F0C55B406D6FE981B102962A365D584C93D0928E1B41E5A655FE6DBF8A2999C7
      34B5AD5457A4AF6D4D4F30A6085C5F45228E6E43FF0CA5ECC932A4861C4F9FE7
      EC5AF2657075485E043D7C19BAB2A879CAFAFE84F58F107BC6E600BF3345B3E0
      C681E0FCD3D97A24656D8DA2A751DD9255B6B7522BCCC50739AB70181CF72A60
      452179A769BE701057B6B7C99EAA1553E3CF2A5A83B0B9DC18D7F436677B03F0
      B96A70B4B8384A2296B8C817D75280929B49ECED308D9A7B37F3CA2A927CDAF4
      0E4ECBEA5C49A7B31694F314939D6F6F0953E52CA05D1C4BBA6A0147C92FB42C
      51D9BADB215B54AFC88F4EA808677F3C4B15C01413E091981A9561F25C5180AA
      0FE781E27AE5C6CE566B8673D5FB2069B13897C6CC75F5F9DC7C77E5DD2C5CAA
      BCFC2221F5575F2F6F3F5B19BB6D57A3FEF0C7F1F6166F78F3EDC9A12AABC6CF
      268482767DC46A468CAC5928A6E2F0439348148D647A6F7848F739E467CB73E6
      7289275F2D7C1B6A0E2FD22474599E81D11A5E07DAA09A48CDA6B2BD7506A2F9
      61A6057FC2096DDD6EB929F648AB8AF586C105A84607DF9D783FB7E4BF76EF17
      92E7919693BDF18547946AD129EEB4DF9D4AAD04D6EDF55CF827EB26A09FEA2D
      5657C28BF6BC6F1375D358BD6EAE2F75917C16A24B8E2CCE85AE72D915B4EA58
      29E22C9ABDA92AA4EC8DAB5CBB4AB3096E12A75012970EA139CF8A22BA543A5D
      7375343D570B9BB5F44302710503C28324A21139B9E094E8BA0981BBF61DFBB1
      BAF3C2E4E84F2B9653AA0028AA35B75EA4855BA4A6F2C04972A9F5810DC514F6
      1E1D5725AF067F1EC1BCA6942925A517A5F5CBEAD63352966AD8C3CE25612AD0
      55EE5523EEE26F8461C598B3351E7419A177919D8512A6B3980A42ADF6D2C8D8
      0FB9B2625129C5851326C1ABF92B2F06BD29AD56EA962FFC48898F45C6795990
      B13111EE34113A9B60D84DABE08B37F6F896FE865357CCBCF3EDCBD3B35D3D40
      3C6F52455F30F53C9DBC937E6F2CB348B56A3ACD8EB7B70E9BE26353895B3776
      B26F63FC563E9C987355E20AF80FC9AAD5398AEDA3A68BEF3D67E8406FDE1CEF
      4F38DE7F6858E00BBBBECFAA4E2AEB3796FA95A9FF57DBC8D1C9587F922CAEAD
      03B7627C07A2D4328465933492FC9616EB1BC2FB08E1B5F73665FB37A4CA17EF
      1FA30827CE051E2719CD743A8BCB102C04067433317C4439ADD9269633F0BD0E
      ED90D5D14B22993F11370DDBD0F94422AFD91468E91755B84C8C3F4FB36BAFF1
      5D12C134A085FC328DBC6F992ADF701D2BA04807C602EA888CAFD99404BED675
      0CC10CAC0672E881E7BEA226A3E44657D5B959549C01FC6CA6A115109B2FE59E
      654FA39ACDB200539BF3946A6F94373EECFB6FB3A4767500FB584709F3359633
      0273CD1ACE1549634A5C0C9AAB61B3681984B24AA5E0B1D66C3ADB5BA7EB86E7
      8E74B893FE1A89C4CAACEE08BB3ABF4CE64DBA1E6DC949D3DBDBDBB5A9C26135
      3A2EEE99C6696170369AC55FAFD299519F78E398AEE185578CA051B3C5F1A5DF
      33A7B6D410B66692BA7A1B97F89CC67112D2756F0BAA6B360B75273EA590DADE
      B24C3E14C67E95A58C473A4431284465AA80A4BD16D0BBEA1048321E517AAD9C
      73DA77C4B1234907BA32BBB2BBD6F96E95452510795ACD9607AA84C9583FBEB8
      32FE651991300CF226F9D4CA0A8DF157701EC2093F2A5CF0359BD5F696C88EB8
      10EBC98D4845A36852A9BE35695D97A94BBCE1ED80F873EF6F4B7A517D2FD0A4
      35BFECEC0E96161AC591A4AEB0BBE7ED0B82AB78A48A307684C36E3B736154F4
      D6D99745DEB3EBC64A9F3CE774AA345A7689F965C57C56DE4F98EB2237A0A685
      FF2F4B6641B7AF3F9F4F18A0B2C8D61A8777E9B7619285CB2955ABB08E3ECA75
      1FA414FE64E995F33388EEEDE5CCCD29F29FC4AFC25A0AA2EC4B6E41E13FBFCA
      CBE202C98674AE07456B92B42185EB989A69BAE79DA6452A0EE5AAF1F3442C47
      3F2A7B9D675E90A697753B898C265C33FFF3DC3B7EF44ECA65CE5371AAFA0139
      EE9F3785051FB57937B9D6376CDE2F8EE9BDEA49257BD38A99A8921D81A35AB3
      8D7BEE224152E8463DE50DC3DE92667190CE228B2E2020BB9029914C476BA76A
      67F016F66CEEED886EAA0C4578E9841D52EB86844F63C379DE2B092037AD0A55
      5B76651B341FEF89165F4B569EEFED2D4CDEA38829604925FBB5080AE7A4CD39
      4D4869CD2B0D29731BEA2DFBF7EE58FDDD815F31EC38F773EBEDB76573056E54
      DD16F38D53E532C9451408F26A790FD74DFD39E5DA5840ECD2AF730EFD6C237E
      CAB7FC17748CEFA960500EC95FFB20C143C26D3F1C673FA64D4545942B9E82AB
      8B1404642533BD6C87293455E8E87B603FC65FFCC9FB0E4A1E9B715EDB9CDCD5
      9CAD3BF0CB291D9C9E6B737635D9FC7D99A1E4DFC889FEBDE08B8F8FB9BF9CCC
      F154F6F5736444CF5D2657B328D691A2238B6978218AB0F11A32515B865A004A
      90E12C67179AE51E63B92FD483F9DAC2AEF27B27C63E2957D76F432FC9279DFE
      183FA959DF1F39DEA0BE6EBBDF1AAE2E9D5DB061673C1E7747AE2D1596FD5FDF
      3263C6484BDD7EAB17B4BAAD1E56B1D51AE07F234DFEE9E0309971645A7110C7
      B14D080A5B1DF9B7AB7FF7835E77100FCCB037E8F3673FEEF786E3616BD01F76
      FB51C70C47836810FAE1B81D063D1376BBAD760B170D7BA3381C754DBF13F5FC
      EDAD711874F0F251A76FC6A34E381C9970E8778661D80A47E371A7D71E84E368
      1474FC61BF8FC10C7B61D4E9F77A1D7FD469B50783B01346E36E371E8E4D3730
      DD612788DA716B18F4C3EE78340EFD61CFF7E3B8D3EB74F01A13B483DEB01FF9
      FD28EE0E7B7134F6A3EDADFE60341EB5DB7E7BD40D076DBFDF8AC7A3B817F881
      09C2CEA83B1C0D47AD1E1E36F6FB1DBF3F0CCC0073C438824E371A99716BD869
      C7E396DF8B3AB1DF1DB53A61D0ED0F079DC1A81547584E1346187A3B0ADB2313
      E029EDEEC874C371AF1B0D4DBFD50D06DB5B41AB1DF547DDC818D38FC758869E
      E98C5B01C6D08DBB839EF1C39EDFEBB646A36ED00D5B632C9C09FD513CEE616D
      DA03CC0D7F06E3CE30EE778CDFEBE02D7E3B8CFAE3102B158FDBE3A065467D33
      E8635BDADDBE3F8A4CA715775AC1286C77C26ED0DADEE262F7E3301E40936DE3
      056610C4DD606C46630C3F8806FDF1200CC208F30D3A23330CBB83BE09430CA3
      1DC7EDDEA015F7BBB119B5BB51370C318C60182BADC4A41ED0CB87E80CBB8135
      F08778AC7ED88242DF965F024B69F1B0031A0B87DD4E0CBAB2BF8F4848F1C027
      6561FC43138FFA4184656C0F23AC3766D60655612762BF3F6EF5BADC9E61840D
      697746C37830EA74DA41048A30F8D98BB7B7426C6BCB0F02AC3396DBC4F1D01F
      77A3D8F86614C463D31EF70C576730F67DBF3508BBA6D303E185C16064DAC341
      370271C6A0E0F1A8EFF7FC61A7DFC270403CADD100EFC53B021270D86F456DBF
      8B658ABAED76E0F77BA360D06D8DFBED0E76211E8DA2718F57757CD3EB0C7A51
      1B3BDC8A3A18503F0ABABD41A7D31BC6FE70DC1EB6FB713404E58D38348335C3
      C9E8C6FDF600076BD81D622A6614FBA3701CC7A01AAC51188E4D2F0EDBB83FEE
      84A6DFC3A60C7064C6BD5E38C057038CC06FE35CC5A6DBEF0611687A34E8FB7E
      D46B9BA815F403505C348823DD9B4FD9D941301C8F07EDC1C8728C915F7012F9
      0F9C036F0097E87762FD7D7BABFA177FEF457880C1FF86E02B1DC7553099B017
      B5B0F71D7215ECE930F2DBC3E1B8056E80CD0840A6BDFE00873E0C7C13043146
      D6EB8EC3B6DF6B83BF6045C731E81A27D07447DDEE303411E8184726D8DEC27C
      F00B36326C0D5BD1C81FF4C172CC6844A21E82DFF843ECDB28F27BA376888D0A
      07A1C133DB3860663C1CB5B1E2416F848316C5BD31C8B2DBC7D8C02A4083A08C
      28E84751A7150D823E5855BFD336D88B28EA1B9CDF1E0805AC0E2318F6876684
      DD04F30695E14B4C041BDAEA7447BF65FD7BA61DF75AD150289B5F056DD981F6
      E0AEF5D7DFB7B7CABFBA6DB7E626044789473C2D83762F3024A46EDC1A451198
      5B100C4C0F6F0B82306C8F0706D78F03CCB417F67AA6E78FCC006760803D1B0E
      C0CA703A87E0AC98538F47A513B6F16FD4C5E55D70C428061DE09CE094E1E538
      C331962BC061188CFBDD1087316AE1DE6E7F3C06430F87510411D001AFEBE0F4
      B5FBE0AE26C633C6E06111B84A1C46BDD178E8C751D88AFDF1B03FEA61CFB168
      A0EEF178D831DD318E70DFC7716C07E3EE003B8B09C63C8D431F47D81F40E0B4
      435053B7D7EB8F47BD31A9A9036E8BE144512BEEC6C168140E07C311E4447710
      8EB0DF6372E8963F6847C356D74441077C7A8C37B442BF8B75EA8CB17CAD516C
      C66037180C88B2634C77301EB6DBB86280656D830EA2CEA013E133DF0FFBED16
      E4287805B8566FD421DF1A836DB479BC824E0B240ACE854D81746BF97C0C4E7A
      2F042B0B07C3C840BA0D8236561302C47420427A3D88C3D110E701521C03EF0E
      06D1783480D81D9916D858D704C30E64E3C86F775A6618777B26EA0FFA202513
      9A0EE554A71341B48F2021A378D0F1C178C7FD6118835F41D4436CC6781DE885
      6C3306BB1D83271A1CC471D487B200318715C49D21481DDB140D7CB00A3FE69C
      5ADD5EDB0741F8FD6E074652E087318ECD7838EC767D6820A097B8ED83A44148
      6368103863DD4E109B0E5724EC4366C5A30145F6B8872D0FF029C48209E3E110
      7B08C1D50BC098FD7808D5A58583057501B3C14E907CC23E54179C72C8488890
      2156760C0D051F80157646A371CB50808C4C7FE847F128C4F9358371AB35267F
      EF61FFC32E6E079F0751612947FD5107D26904720A7A1046031018487B80FD02
      03098706871F87B037C65240E077A0E4C40352111841BF15F6BBC68704688FB6
      B7DA5D8C24C6766261031CAF91DFA79EC14D199B71770C5130C2E3E3FE1014D5
      C18A837D43F6815B8F3AED219803C91A67AD1D6395B04803327C5031C6D0E27E
      745A83B86F62AC1C781896C00406926784DDE80D21FAC2EDAD6E48F10CE10BE1
      1FF540CCE05F23E869FE78E0C77D08148C3D36386CBE3F8E412631CE20586B8C
      9B21827AD00CE3D0E0A40C412C51C05BC6FEA80D46DBE9534EE2A17164C251DC
      C64BE4AF2EF420FC80E082B0E8E32CE0F040EE4215C541C0CE74FA5108228870
      40DA5402B152ADD1B087750707C698237066C805D039D43BC84E2C420FB2360C
      A10EB420D4FBB86C1070A2AD76AF4DAD15E40CD10A9ED9825604914C8534C2B0
      A077C56056A08351087D286C43D1C4B3C154C040472118FD60148CA07104D86E
      2859180BD4BB11081BC387C06DF72125A2A887B583DADB834A10777078C0C5C0
      A35A508DC7602AFD30F6A1040EC07DA8C18D0CD4C7918F07851D08A63674B1B0
      077E300A5AD04B8311B8F31002A6D3F2A1E576A00D851D48165C33C03DD84E88
      7A8C2EC4DCFDBE0FED201A83F560F33BD0C1DB185A087EDA06DF1B4152F6DBE3
      2EE5923F827019F63ABD884C7484330805B60BFA08C1AB3189A83B064FA49A0B
      0ED119F9781718EA900FEE851D282D1090F81407D16F8DB115D875D03CA86B88
      551A7731B61EF4B7EE08A4D6F1C9444174E06F50B4A0FEF6A351AFEBE3C0438A
      442D832B316730AD0E38163450883BA8CA10D4D00FDA310D06284E86E759C89D
      47079A0CFE077AC7982120C0F2226803AD21B4D3A817619CD1A88393D91BC7BE
      A162D20377EAF7611D041095D06241195DE888C627371B80D9419B03A386FA06
      357CDC6A1B3C0FE62ECE0256A8ED432E07D824E88EE08EF8153C181C2E060306
      2FEB831C7A7D9CCA1E8F1A6403CE4C6440F1E1200EBB3EB631009D9B4E172C2B
      86BC017560D8183C4E69140CFA411767032CCF181C98CE20C2D18A6979906862
      8CC09816FE82DE0CE6ACDC17BC1B0CDAF431098843C8AC781C432FC28086219E
      DD06B3E904781ECE4ECF1F0CB1672DC8BC31D4750A042885605DADC0B4FC218C
      87EEA00DED3D82E503BA01F3C269C373E34EBB8B03D01A0EC091B07701B835E8
      780C3183DDC5B1EDF24A5C0A568481E289831826308E8E8FB7C114C2FE45BE19
      0FC0C1217BC7B0E8C03E6078C5307E024A6D300C285C3880108FA0DB7E40A369
      08D564DCC1E4A085E2A40C5B3DC86F48A6281843F7C1E27471807AAD90DA130E
      13782C346488117027583238F1904B60F220C516D406AC3CDE1E8062A33E7422
      922A582E180CAC2C5A93349DA0C90C615C8EA1C9B5C1F3FD3EE68D798C299182
      280CA1998786561B541D283C83416BE0C3FC6E510D00E3EE5329854E04990C19
      0A06E043B6E3BCF7BB50D1FB389F3890207F68451832148D0108B0D76B0DA09D
      F62177608542D91E45D838D88DF8B40FC104360F510E718AB306498EC774FB18
      410C2B16CA31AE846537F2A125618658292C1E860F55000BE207181BEF021B1C
      40871AE2752048F07A4802E3633BDB100AB40686385521D8746F80C36A06713C
      8A216F60E6E22FC8535834585DAC5E67DCF5A18847B41B4115D08D4261C85076
      B0CA3013C1337B50557D9ECD4E9FA7271CE1200DA01B74B1559037062610F606
      5F9901CE141439F0A5FE30EAFA649230EC60E10C4936FE188F1D418C50BB1E42
      1F073982DF0E61BC0FA963601768D182D55002E2F4776030FB1813A446B7DDC3
      730DF48FCE186C75006505021CCC184A0E8E378C33289423EC1596781C778621
      8C9F1EE472BB3D8E5A58749ABA1067180BE76CFA90B36029E37E888582AA81E5
      6E852D8C005CA433863A8A6D6EF77BDD1E2C79D8D8D822EC0B74B241E8534783
      4D16E19C43D703A5D13A07CB8F2092B8EE3D9876B033C6DD2E6C8100F2CEEF80
      B4609D804981B907ED161416C8F83E5851847D0886381AF45060C97AB0DA226A
      2F2DB0E5710CCBA80F6E879181A7F8ED00D62AF406F287561076A02BF53A0194
      4048AB683884BA0CE60C9B171C075B36A60B87DA4A3004836C837C21692067C4
      33028B04EB0F4B0A16212687BDC440624E9C7A225E090102BB72108DA0BBC25A
      EAE16AE8371D280DD881410F066D3BC4F28007424B860E311C827FE08301F61E
      EA4D082BB50FFA854906C18F7DC129877C351C26F4381821EDE13894F94701E4
      111D5B588388222E0225820987E0E63009C02540B11869D86EC1DE095A3126DE
      190FC19BBB862620B52848B7C8E00043E5E05983CD0BE56830861804EDE0FC41
      630B4C1F6622D4563A1DB8DC6392B601F7C6B6C176E2A181DD13F53802D00126
      388060C08EF931F6020A05D41E686960C258FC71E4FBFDD880F5747D3C7988F3
      45BB1A5404031F4B0EA9E043671A7085B1477D308E007C6988230A331E9F81C9
      8086410D983F850CC8120435009B0DA148410786DD08BD061216F741E58158C2
      08B0869F6A2DB6C0B4C6AD3147AB567AA0966667F8616BB1F4CE40367ED4725F
      F5DF880D4FAD04070327BA33A4BB241E8083043E2D1ED053341AE1221C1D1A4A
      A6D7856148030966711BB64804339116CD08EA155819F881198FA1DC06E32174
      C03194331CAAC88031E12C831A208D700174FB316C0CC8A911B44EE88030C421
      0146E368DC852808B03423308001F8AB89DA5061C630783BA31E0DB21E4C1FBC
      AD0B357C8843D78140850A0E1D055A792F868E84030503D38736054BA7D7E9F8
      5D1F6A3C6CB72082F0822182530BDE46B71CD45DE8A9A0E2013600F21D52A48D
      E1F76152D06B8365801E361A0F409F1093B0BFB0C15057C14AA0329247F9743F
      84386650E67C9EF45E088BA50F72028543EDD19D5BD97DC8F64EC4F2CEDFEEF1
      FDD07F556F30B4B43BFDC11F1B03BD811FF205DEF65FB7A5D7AC526249691F7B
      E7C7FC54B7FD87A3D2F9D0A9A8FA506E3F091F1BD5C7BC37B7FD0799548C0ABB
      70CBB86EF3EC7C6C241FE30CB78E04C7F743EB53F5E97E3ACF9091F65BE50AF4
      F57F7DEB150BC396EFBEFAFBF616831D613A49B33C64C8636AF1876055C6F6C9
      E0D37CD3B00BD60AEA854DD5E1BAC0FCEBC02AC6011E90AA7BF816A625BFED43
      DCF760757647BC02F67E4F46CC9F219F8075C555C331A91ECF825A0FBDD36764
      016C00BC7A08F381560C748A968E0167A58BEF68CFC10018F6F07F2D68587187
      4E8AAE5D199C791847F150C664EF1B0CB886FCAE67BFED9053C0CEEAE0B3A18E
      59660945AE8B5302D330E6F583314FA8CC107774F5CD506B3073CEA907D54A3F
      EB0D02FD4CAEEB14D7758AEB3AC575F2199ECD314B3CC83E63E593F21AA14E7E
      D6B971D5CD27756F5CD3BD714DEFC635BD1BD7F46F5CD3BF71CDE0C63503B966
      8415E78A06BA4FEE2FF90E3B31087BAB57AC7D86EB400B96269926325BE48BEB
      89C9DF4EF2285F2453FF7D7738E01F9334BC345164E2967C65A6894622DD271A
      A464B6B8FBE46F9A40EAFE9C6749FAFFB77775BD6DDB50F47DC0FE831FB78701
      9644D231FAD4242D522CE9BA26DB9E655B4EB4DA96E18F6EC1D0FF3E91926551
      22997B6EBC8FA21550B449EF21790F0FA94B4ABADCE4BBC7F2E7F1F8AF6391D5
      19928316221AB4ED8783A3ED70F0D6E41E7EE1B51E5BD60F59F5DA43F4E2DB6F
      EC6657A863A3237F03DC45C62F4E5C6072EA02C5E99D96A76EA33A7581A3D33B
      7D76EA368E49051E507939C4FE242BD846D1446A63683AB4318281912C8F6882
      B131230686D6E936664CF4E8A08EC496C7AE9896DDFCCC02683D1E282079BE13
      3435040AA04D338102D4F39DA0892650004D418102B069A2BA310EDEAC74EA13
      7068CD8B62B72A76D51BF850ADE9AAC4D5894E51AC9E0EB30D04D10D2D219C89
      A39E7CF9737922AD52A7A979030B6A7E756A7D311FCCF3FBFD26DB828E64AB8F
      D9A25837691FA1BA1BF026DBED3758BB1B7D345FDC7045722C0073DD7CFC51E5
      0F80AA5EA7F72C5C19D73EC3E103DA0C09CCD14622E97EF7A0759767583F2FD3
      E9A6C05459A4D0E838E0AEF32DEA9D860CCEF78B45864D1506F716EF4683C382
      2003A1DE042D1016041908ED46E7608FE3548D64F95663192ED64886A7557F73
      3CAD912C4F6B2CC3D31A29FD8BD3C85ECBDEE5BB0536B15C2C0AFD9125E8D76D
      7EBF4A75266D2822B1CBB8ACCFC5D61FC8DC6FD2F5C3E075B1C206F179317B1C
      DCA1514283E28536A66774AEF67CB5C7B8B6901C1536586C456563A98B78371A
      1B7537F5596D57C7C0CC2DE38EBCF6931DACE4DB74B1AF6202D0C1CB7487D574
      14D06B938AA596D1F38B0035F156470457F57D16F3F9583F56E5118749B03BE6
      D8D5D67074223ED7FFC0A78AAB479DC82C5F7D8050AF0B9D57319BD968A7F0E3
      D8D6F04EA74CA87D7303EC09FFD572FD906E732CA03B7C5F33B849D710F09DFE
      160D67F1D50F4B7D4EE9F1A681F5DDD5DDCDF5E0AE58EB1856E7C4C37A5083CF
      F507D14B16BE5E047FF75B36F91EAFF8651939AF1E971C875F32566406789183
      D359852A660CD46593DC9CE3E28FD9E3A4483733BCDE77E52ACA0C8E5DC640DF
      A6FA8B5B1CA7BFE9FDA31C84F07E8141FF9A6E72BD14E32E74B7FBC9EFD9141B
      796F8B6A4D85607EAA3EA2ACEEFBE826B105C6E6780B8ADD5DEEAAF4CCB9EE56
      E286A7131A83DE5A604E932F4C9217EA26AD1B8BB16C63D1DBA88DC656343556
      3FA5D6A7F8B05C3E80593E1FC04CA78BC57EB9DA72DB6DB0CC661B2C4B5E3516
      0DF96D3416F257589D5A8D459501727832405ED71A2847CC06C8A6077BF0D402
      529F483AA0D843A80A58DF0898404E5FB276CC5A504E5F3276CF5A404E5F1A20
      AF2F0D94D397C9657DBA386F226BC139FDDA827327E1D52E5BAE8B4DBA7964D4
      FF6A91DDA7E04ABD42BEDB14739D8E4CE726E3C417FBC9CE8426ACF8A2027308
      2F572DAC7ED6387085AECF1228EAC561E5A5E741E471367256D05A6B4EB38762
      A17398352B4EF7E65137E4BD5DA7D3C3A3878391B2D7CDD7269DD8EDC3F11945
      6318390C9B20BAB18A1D56C627DB7795587637D92CDF2F0FF5D65DD3D88A906D
      6CDB4A976D6BA66E0C95D7B053E2C865D8BA8F3786675EC3B8EBFDD86B9A5865
      8EECDEB94C371FFA9C8FEC9E69E239572F8E62B76DBFD0C46DD8E89322A0729D
      3FD5FB2951D77F9F968E0092A83CE6616D79406191794001B5757DF78DE7F7D9
      C77C7B78BCED7E1C2E3AEE6F5B0F07025B68B6C87EDE17F5FE87BB12BB1BDF94
      F793D5366BA12803C7DBDF8131E4613630983C88C09872237C83CB631D1E653E
      D74303CE535160E4795C270CC19836997BCC9F1A80BD098E360463CE10A44FF8
      1E0441C03D7F08028E6101C7B0806348C03147C05DD729028E6101C7B080134C
      C00926E08427E08423E0041670020BB8E70F41C0092CE00416302DBCF158D304
      DC759D22E0041670020B586002169880054FC0822360010B58C002EEF94310B0
      80052C60010B48C08223E0AEEB14010B58C00216B0C4042C31014B9E802547C0
      1216B08405DCF3872060090B58C2029690802547C05DD7290296B080252C6085
      09586102563C012B8E80152C60050BB8E70F41C00A16B08205AC20012B8E80BB
      AE5304AC6001ABC0D69DCD43BDD369BDD4E25EF3DBFE1D56F10D30F0024D12B9
      AA7C6FBD95ED06C6CE3A29489BA4F3A2F800BCA9D99462EBF23C9F2CF2C2EC8D
      3C3EE70BB5EEEEEC4F17CD2B656D33D1DB9DD56F0299AD5C7B912E62AFA1BD18
      1289D7D00E3A85F01A76430821BDA6F6342AECE164E47A78B4524E78B6ADF2D9
      462EEB91CFBAE3FE99CFAEE3FDD867D7755E7A7D9266BEB08A9591CF5835A3D8
      06C43EC0C80D789236F7264F803FDFDE53804A4F1D7E4EDD80A7A8F5A0081CFB
      7CA2D0ED718ECA7B8CF24E16B06F8F85C07BCCE23D66F31EC322F73A47E53D41
      794F50DEC933886F2F81CA7BC2E63D61F39EF0D4DEBB553CCDBB40791728EF82
      A5F6DEC40FF02ED8BC0B1EEF12557B775545E05DA2BC4B16EF92ADF6AE4F08EF
      92C7BB427957A8DABBAB0702EF8AC5BB62F3AED86AEF3967F36E5644E420B065
      1DBC87B6EC825378CB2E3883B4ECEA10303871B4CC6941600B400B02FBB49182
      C0367F1E809F486FD4E8E7941404F6C82505814E8E3D4802D95EE7A8BC078340
      17EF64017B004FB3DE0DACA8BC0783C020EFC12030C87BCC537B37DE22F01E0C
      025DBC9367104F484664BD173A02BC0783C020EFC120D0CFBB40D5DE8B1A9FE6
      3D1804BA78C7A6700F0A60BD173E02BC0783403FEFC120D0C5BB44D5DE8B1A9F
      E63D18047A790F068141DE255BED3DE7A8BC07834017EFC120D0C5BB42D5DE0D
      ACA8BC0783C020EFC12030C83BF656F74D09C1BF84BB5DEA33C9781F9A5EA5DB
      875D8AE5D8F865B5C9B6C5429F76786830DEDC6BDDD24FE68C2D7DBCD676A78F
      871C46264BA53E6529AEF367D6B935853EA8C7E4724CE238938988E4993C1333
      31953ADF65A444950533513A23A5F35255C9B3E1741E45D9308D26519466913F
      2F677525FAE489B2C879369F9B3C9DBE9CA251E7EFCE7F68FCBCC917DBFFB9F9
      FD3F78E93CE85FEEF5D5FB2FF772783FABFFCEFEDD96FC17D7D7BEFF72AFAFDE
      872F59461A6A5EFD1989A1093C441985A8ACFA7954FE62347E2A4AE05F2647B9
      F4DFF7875395CEC66767E3781ECDF4B1224A962D15C3B14A621965D257EEC49C
      8B2695D081523C93C3C81771FC5F2E2F03CCAB8C223FB3EB940C7C7EDEEBEB54
      0C30BCAFD71E87EBD3A7BF01AEB7252F}
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
