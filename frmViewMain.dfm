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
      789CECBD6973E346B620FA5D11FA0F08DE795152B7A422C0DDF776CFA8B4D89A
      AEAD4B2AFBCE331D132001926881000D8092D80EFFF7394B662241121225512E
      CACCEE7091028144E6C993675F7EEB26D9C0EEBA9E3F08DD6868579D46D78DD2
      80FEE94F86B6D370BAD33EDF31A8D98D6AAB8BDFAADD344B4703AFD71FE1C506
      FF19C6FC6793FF1C05853F7B817A1EDF55ABB66DF97DE0C39BDBDD6CE48F7DF5
      9BFA6BFED77E5AFDAD3B88A32CEB85F0A5DA85A1BDC0EA0E9278EC46DD417FE4
      26A99FC1F549F2ABF35BF72FDD891BC5A96F551DF87FB35AAB36AA75F8CF816F
      F5DFAF82B19F5A1FFD5BEB0B3EFE9FBFC3908E1A721C7B7E323FA65D1CB305E3
      74686C1CB30E639EC4D324F0131CF53F7FDFDD81116B259374162709E0ACC282
      E1BF164C16076DFD7E391BF7E290E666E7EB8D82F0FE8116FEF7FB4F4134F4E0
      BF54CCCBAE974CCCAE3597C36F6ED4DF3F7F80E1DE075FF1BE811B6656F74DAF
      D57DD3AAC1A7D37DE3C1A7DBE9BE19B8DD37FD46F78DDFF99D96512B7BF1D26D
      C3EDE26DC3ED7310C4EEB89704AEF5C1CD4612C62D35647A1BA4E9FD430E68B7
      1C1A5C0E190630264DAF5E7B140AF4605E9DE2607194C6A19BF29EC1B17AC4D4
      7A0291F83F40D3DF2FFD61EC5B5F2FE4AE35CBF069E56DFB5F72DF6882210CF2
      AF38E9D2115FF781A2297B3DED0DF63742BA51A04DC2791CB6D496638BF53E18
      8E32B1C89E3E7ED9163D832EC13605911CFF5107E811DB94BFA1F1EDB6299F44
      734D875A6E503E726BFD1B546F950DEAD4DA3CAC35F79C7572261E6D973D8A5B
      BDFCD1592216566F979D5ABB69973CFD7DE2FBD7FCEE76E9896C3A254F5F4D13
      F1AC53F62C0263E9B37B3FF8BDC4BFDD17039412B35619CCF68E13B717F4F7D5
      EA4BD958BB5932C43BC0C7A02F66508AE9486897CFE0C7C0CF22172EFA62199D
      5619CB907B6F5B9A60A0F6BDD32E7D4E6CFCDC736AD375523DF7A8DCF5E2A3F9
      8EEB3478E15167C9A372BB75BA39FFA0D8EFE28385BDD6A9E2C2D3CB8034B7D1
      3AD59B7F5EEC74F1796D97757AB6B0E4DAB277CF6F71D3EEDC4F322C49F0AC9F
      FC3483373C86F0D102DBF6C30444177D2416B5ED87A947F1B919EF67DB799870
      141ECC71A8ED3C4C350A8F120EF1329D870F6CE1516D1FDBCEC3A7B5F0ECC23E
      B6EB6592A20E6466EF12BEF576D9231A7CC523EA80B61BD592A774E0F2531A5C
      1B76E953CEDC53F258B61B65E24C4E85E5338513D96ED44A1F9C87C5DC616C37
      EA658F6A9BC88FEAFBD7281386F5FD136F9CDFBA4E75252ACBB2B7DCBC4E7525
      122B1F52DBD7B157A2AFE2B97C033BF64AC4553C27B7B063AF44DBC4531A403B
      F64A844D3C580429AB132DE7E103215510095478E8E123913F24C88DDDAA3D7C
      24D4533948E1B9870F857A2E2734F0DCC307433D573819F0E8C347237F549D0D
      7EF4E1A3A11ED5B6121E7CF870E4EF5CDC4AC7AE3EC4A3FED73C935AD4004B79
      C943426C6194B289AC22CFEA03D9E56CE661D1B63050A9A4FAA0945B18A65C5E
      7D58E05D5C5D29275C41FA9D1FAB9433AE220617466A3EC863EF97881794FE52
      39631DB2D39C6E5F4E9916F83BA9EF127D0B63745666F8620C85BCFA30F790AD
      79098087C951B7304C29155B1009781889B88541CAE9D9BC8CC083CCA16D61AC
      5202B7203688B174A42D8C544AF116A4081E4943D9C23865968245B142CC6811
      6175034EEDC954B030CA13A9E0DC30F527D3C08575D59F4E050BC33C870ACE8F
      F51C1AB8B8C06751C1C248CFA5827336BBFAD3504AF28C7C9CA723953E4CE399
      8C351FE88928B5B0B0C63391AA30D6F3196B3ED6D3516A718D6B402ADD4CDB7C
      79C69ABF6B75C6AA10B7F0FCEA4C5522ACFE786B75665A60A3F900ABB3D11C41
      0B03ACCE420B8859186375D639CF34F33156679A05442C8CB13AC35C4040DD90
      5E6EB85E8151E6A33C475DD007BAC796FD30552B0CF42C46990FF36C75A130DA
      33A95A61ACE732CA7CA4E7D2345A683F0EE324EB85FFD94D7CAFDA1DC2AE44D5
      6E2F9CFAD5C54B4EA3A15F843FEFBBCC03E05F4B8698BB3C776FC910252FE421
      6CA7AD5F843FEFBB5CFDCFDD1DBC8C7F2F1964EE72B578311F64E9653548C711
      3FC017FAA1E3AC04E72A6EF65F3052A33F9A20A9709C2E067A745DE19EC3300F
      F5074684883F1A967C70E24E2C58E1AFA1D50D836A3781FF52D706BE95864EA3
      03FF8EA76166776F03AF9F851337E9DE26EE049E73E172D74D276E3819B9F825
      9A8E8173B9D32CEEBADEBFA66996A0200F03C25C43FC27C8DC49D5FABD1BC5BF
      02D6C5E338F3ADDFBA69360BFD74E4FBD96F7FDC24BA4916022C06FDD4C6C5BB
      C2E5E812005D196D0393C912BEAD2A812B0360B4D81702F843F0EEF68749E0D1
      63D1441B219AE01856378DFCBB0CDE92FE3A8893B10BFC3F9D24419C04D9AC6A
      7DC44B186102734DED22987A76958085FFF670E136FCC59F8F02573CCD00407E
      E8DFF8617565E075DD1EACB08A9003F9B90472BD2EFDBA0C76D720F2800004EA
      E1FDF0C185F7DCD4F7E2A82A80052F4F6156D7766329D43A16A25692065EAB53
      6B3AB5AA35F25D8CAEB16C3C34A9F3F260B49F024600450E4658F63C20E1F765
      807C08BDE680E748E0351F093C476061EDE5C1E73C057C4EEB3E2C845F1F0FBC
      25B85793E06B3D127C3526D8306918CAF5BC200B6E7CB83BF5C7C128F03C3F82
      3FA6117CF5A7F0466D4CDB3A65D0599FDDC41D022847D6791C6534204C314B6D
      1BFE49E25BAF9B25832CFD29F0B2D1BB1AFC3181178576B52DBE26F9D741287F
      1F64EA5B4F7D4BF05BBF377181F6C297017FE9C1CA810DF167369BF870577AE3
      2719881FF0AD977889FC0CC5674F7C26E2D31B86EA9BBC36129F37D6437C0056
      FB229C6063F8806DDF8312BB3BCC0EAC2BB717FA0A9F1A3A3E9551E885135165
      D2ACC8704E29104119C7F133EE5F17B07111C37F90D4D53A01E9524DABF9F0B4
      F0AD4BA60597B593A7A6E33C6E3A4E713AAD87A7E3B4964E072F2F4CA6F6B8C9
      D4E464888FB75F86843E02DB79BDF57B30BDBE1E7A69B70BF2CC3C7CC6691C49
      1187F7A953BA4F836A7192D3B0DB1F38737B534E4EE73606A857821B295FEC54
      1FF762DB5940D255DF7D1E87617CEB7B8539A4CE0B89776BC30A58EE13F16251
      08B98FCCCD834B10BDBD9FFCDEBEDA2DA77CB71C5AC5DC9E61F0385D7CD28EED
      EEFC70F5E1BD75127B3EEF555108CAF723BBEBD84DF8D76ED71CF8705A4062B3
      BB5AB359878F7AA30DCCF3AE51EFE02DCDBA8DB7B46A18447FD776EA757E1A6F
      814D6FD130D54E076FB26D0C96804F074374E0B3D6AAD37DF566A3B9662410E0
      2B97450528D78207529C72EA8F39BBB8179F139FA5AFCCF71456D49F88154BD9
      4D81C417E6F6C0740A8CC72967CFC1226909E6107451C2741689E8D918363C0D
      52F5CA72D63BF7BEF9759713EA49789893CA725E3ABF9ED547EFABD1DBF773EA
      391EFD30C09C85D75D66491C0D8579EB2F7016D22C4391EA37FACA7FFBE349E8
      667EE01DDA4EB55AAF771AB53AFF4E2A4A97FE8D067D2005F26B24BFFFAB5F95
      5F22F16D40345FFC91662EC8CC2051F35F13B7EF8B5F40AEF6A3ACFA1BFF95C1
      11E9BEA9DADDE961AD63D7ACFF8930E2B74DC73D3F811DA71C9694BDF82EA174
      70586BE2F96EC1C57FF5C5DA90D03874EAE1C3A275AF7B293730DD08BEC2B6AD
      BAAE78D97A9C92F5D8F57A7141740146C64F346AADBC20A4672FB524DA2AA7B3
      7CABEC6AC9DA1C24FBFADAE802BC023F1FB5B695568600F8E3D6D66ECFAD0D2F
      E0DAE073FD6B2B5D99DCF575AE0DFE2DAE8D2EC02BF0F30F5C5BD9CA60CD4F5E
      5BBD364740E802BC043F37606D0FAC0CA5D5D2B561C248616D74015E829F9BBF
      B6FB56D66A22A617D6D6625A829FAF7A6DCDFA1C25A10BF00AFCCC991A7AAF2C
      1808BF03CFC7FC20BBF57B096F6F35EC366674BE36D63EB7C73A73DF881D7E21
      D62E89F8EB41DAF5B1F60D145BFE58D6FE878A2D9BC2DA5F426CD974D6FE1CB1
      E595B3F6FBC596D61C2DF953B1F639965664EECB587BBDD9A8579BAD46096F6F
      346A9D0EFCFC1A783B6EFB2A8AFB466CF13A79FB865822BE116FCF59FAE6ADED
      A579BB5CFB3758DBB7E4ED6AD92FB436C3DB37969218DEBE3A6F6FD69C46C7EE
      94EAED0E30F65AA3DE34CCDD3077C3DC0D7337CC7D13088861EE86B9AFC0DC6D
      DBAE765AAD5A7B3977B71B1DA7DDB4EB6DC3DB0D6F37BCDDF076C3DB37808018
      DE6E78FB2ABCBD663B9D9A536F9668EEAD6AD56EB43BAFC2E36E98FB6B445BC3
      DC0D7337CCDD3077C3DCD7CEDC6BD5B6D3EED49D32E66E775A0DBBDA6CB60C77
      7FFE524C089D09A15B37EE99103AC3D00D43370C5D67E89D5AB3595BCED05BB5
      6AAB516DD75F43E69B51D65F23D61A65FD19BB669475A3AC1BDE6E787B096FAF
      D976BB562BF3B21FDAAD56D5B11B9DA6E1EE86BB1BEE6EB8BBE1EE9B40400C77
      37DC7D15EE5EAFB69BC0BFAB25DC9DBA6DD6DAF586E1EE86BB1BEE6EB8BBE1EE
      9B40400C7737DC7D15EEDE6CB4EC3ABCAD2442BED3AAB55BB56AC384C81BE66E
      98BB61EE86B96F020131CCDD30F755EAD6B46B76CDB1EDD228BA46BBE3D875DB
      760C7737DCDD7077C3DD0D77DF000262B8BBE1EEAB70F74EADD5AC579B65DCBD
      D369B49B6D988D61EE86B91BE66E98BB61EE1B40400C7337CC7D05E6DE70EAF5
      4EB5552F8DA903126BB79C8EE1EE86BB1BEE6EB8BBE1EE1B41400C7737DC7D15
      EE5EABD66AED56594C9DDD6875EC16A8F786B91BE66E98BB61EE86B96F020131
      CCDD30F755983BF0EE5AA76E97159D6D37EAF546BD5537CCDD3077C3DC0D7337
      CC7D13088861EE86B9AFD22EA6DA683A75BB5ED20BCEAE373BF576CB71AA86B9
      1BE66E98BB61EE86B96F000131CCDD30F795987BB3DA6E36AA2545EA0EED3646
      D3579B6D93EA6EB8BBE1EE86BB1BEEBE0904C47077C3DD57E0EE2DD0DB6B8D66
      ABBC4C9D53B55BED8609A933DCDD7077C3DD0D77DF080262B8BBE1EEAB70F746
      BBDD6CD965856C80BBDB8D16FCD3319679C3DD0D7737DCDD70F74D202086BB1B
      EEBE0A776F36B1C46CA75EE276EF341B8E83FF19E66E98BB61EE86B91BE6BE01
      04C43077C3DC5760EEED5AABD3ACDAD5CE72E6EE349BED4EBDD934AD5E0D6F37
      BCDDF076C3DB37818018DE6E78FB2ABCBDD1AE35EA8DB278F943DB06125B6BDB
      355360DE7077C3DD0D7737DC7D130888E1EE86BBAFC0DD3B4EB5566B3A652568
      9BAD46BDD96E9ACE7086B71BDE6E78BBE1ED1B41400C6F37BC7D15DE5EABD79A
      B6D3B2CB34F72A7077D0DB1DC3DD0D7737DCDD7077C3DD37818018EE6EB8FB2A
      DCBD5507EDDC6E94F9DCEDBA03A3374D3C9DE1ED86B71BDE6E78FB261010C3DB
      0D6F5F85B7B79BF556D56E9724BA373AB5AA5DAB1BB5DDB076C3DA0D6B37AC7D
      13088861ED86B5AFC6DA5BED66C72E33CA3BD56AB5DEA9576B26CBDD7077C3DD
      0D7737DC7D130888E1EE86BBAFC2DD3B8D5AB5D96AB44AB87BABDAAC39F546DB
      C4CA1BE66E98BB61EE86B96F020131CCDD30F71598BB5D755A8EE3D4DA252EF7
      66BB66D79B5563967FFE52D6C9CEB5354842F77A10F5D9EC5CAD2CE7EB1BB3B6
      9766E7C5952100B6829DEB2B93BB6ED8B961E7869DCFB1F356C3A9D69C4669B3
      9866AB6E379DCEF26631D51C32D5C70266255838F05FF5681E0E082458429285
      FD5177D04F6DABEB0E88A18759C29774C83C96B93F67558FDF6E5CA2BDEA1297
      2F1079FCDCD697B2FF6FB84AE779AB7C400C586EB1F8E357597BE62A1F2F1054
      3591EE8F5A65FD79AB7C8268B074275F50A0C355369EB7CA2708098FC1D77558
      6A7095CDE7ADF209E2C29A4EE5CA361B5C65EB99AB7CBCE0F0D2B48728DEDC2A
      DBCF5B25490C8F1521DA2D1B54EE4659A7F86AB5DE726AF5CEDAEDFD8F34D9AD
      6615D85C9B008BF42F6415D84869F75E497E7D56816FB2B6076C0273E2DCCB5A
      0536C726F0AADD4ECFB6096CB0DBE9C56D02DFD0EDF42D6D022FED767A22436F
      B4ABD55A493D1C6C31576B36D7D11C7E71D3FF34FCFC29029C61EE86B9BFE6B5
      19E66E98BB61EE9BCDDC6DA709CCBDD92CE941D3AE3BCD76BBD934CCDD3077C3
      DC0D7337CCDD3077C3DC5F0D736FDB4DC7693B25A6F87AA353B3EBB5C61A2CF1
      86B91BE66E98BB61EEAF606D86B91BE6FE6760EE8E53EBB49D5AB3246BBED56E
      D4AB55BB6A98BB61EE86B91BE66E98BB61EE86B9BF1AE6DE6CB5DB9D56BD2C69
      DEAE394DF87FBDB3865AB686BD1BF66ED8BB61EFAF606D86BD1BF6FEE760EF9D
      56156DEF25ECBD5EADB51DBB565B43DEBCE1EE86BB1BEE6EB8FB2B589BE1EE86
      BBFF29B87BABD36ED51CBBC4ED7E6837AA76DD6ED69B86BD1BF66ED8BB61EF86
      BD1BF66ED8FB6B61EFB56ABDE9B49AF592927787ED364CA4596D19D3BCE1EE86
      BB1BEE6EB8BBE1EE86BBBF1AEE5EEF345BB5A6DD28E1EE9D56BD61DB9DB6E1EE
      86BB1BEE6EB8BBE1EE86BB1BEEFE5AB87BBD516B02CB2B0B9AB79B1DBBDAB24D
      B6BBE1ED86B71BDE6E78BBE1ED86B7BF1ADEDE745A4EBDEE9494B239746A75A7
      D36A760C7737DCDD7077C3DD0D7737DCDD70F757C3DD5B4EB3D568544B42E6ED
      56A359753A8D9689A933DCDD7077C3DD0D7737DCDD70F7D7C2DD1BD5A6D3AE37
      EC9298BA46A7DE6CB51DE37437CCDD3077C3DC0D7337CCDD30F757C3DC9BB6DD
      00FED072CAF2E19A1DBBED38D5BAA95567D8BB61EF86BD1BF66ED8BB61EFAF87
      BDB79BD576AD5EC2DEED76B5DA76EC76CBF8DD0D7737DCDD7077C3DD0D7737DC
      FDD570F7B653ADD69C5A49549DDDB65BF546A7691BBFBBE1EE86BB1BEE6EB8BB
      E1EE86BBBF1AEEDEB1ED6ABBD928AD33DFB2EB4E03FBBB1BF66ED8BB61EF86BD
      1BF66ED8BB61EFAF84BDB7AAD5B65DAF554B3DEF9D9683956AEB467BBF6F971F
      5E082CDE7074C3D15FF7DA0C47371CDD70F44DE7E80DDB69D75AA50A7BB553AB
      35DBED8609957FEED9340ABB61EF86BDBF8EB519F66ED8FB9F81BD775A8D166A
      EDCD126F7BADD6E9749AC61A6F98BB61EE86B91BE66E98BB61EEAF85B93B55A7
      D60196D728B5C6D71BED56BB6E9B4879C3DE0D7B37ECDDB077C3DE0D7B7F3DEC
      1D8E62BBD9B64B6ACB1F02FFEFD49B8E6D9B3477C3DE0D7B37ECDDB077C3DE0D
      7B7F2DECDDB69D06F0F77AFB77F8FD2F7435BEF19324F07C1823F47F2B5CCAFD
      F52202AFF06B3F9EC252BA616AABB33DF760BBD1AE35EAF0FFE5CF4913C2DC53
      B90CB2FCB1DAF2C71A1DBB55EBD4EDF6F2A7EACB9FEA38D55AADE9349BCB9F6A
      2C7FAADE6CD4ABCD5603B778D963CD9229D6E065ED965D5DFE546BF95379F6E2
      F2C7DACB1F6BD75A9D66D5AE76963FD559FE541380DF6E36AAB592ADAE96ED75
      B3E6C00E745A25CFD925E06F375B6DCCDF2879AC0445EC2A401144C046C966DB
      253862575B0DD870A751B6BC122C0171D76E3A4EDB6997EDB85D8229AD66B3D6
      AE373A257B6797604ADE07A2E4B9125CA9776AAD26A066093ADB25B892D38592
      E73A65DB6E3BCD4EAB5A03EA5072C6ABCBDF58ABB69D4E0D8053F25809BEE465
      B84A9E2B41984E07CE1E1CD812F4744AF0A5596D349DBA5D2F3DE84E19C23880
      D7ED4EAB5EF6C21274C973994A9E2BC3972AA08BE3D4DA25A7DD29C19706E058
      A7DA2ADB77A75DBAEFB0C2461B10AD04419D12FA62C3F23AAD56ADE485B51274
      B19D56A78D41DE65CF95D1975ABDD68487CB584909BAB41A6D204C76C729DBF7
      5A09C2C09905AA047B5FF25809BAD4EAB0E755A78C31D4CAB045559C2D79AE94
      BAC83AF425CFB5CAB61D8F6DBB53774AE84BAD84BED400A18144744A4E6DAD04
      59EAED9A0D7B6E97BCAD5E862CAA415EC97365C445C525966D7BBD045F6A35E0
      10B55A1956D74BD9511B300D787BD902CBA84BCD06E2E9D4CB1E2B252EB2C851
      C973CDB26DCFBD3E254F96892EB52A32B266BD0441EB25F8021C05B6A28406D6
      CB488B8A3B59FE5CA394B6C0E2DA0ED089B26D6F94218CEAB35CF25C1937024E
      DBAADAED12746994A00BB01338B576A304988D3A0BF5897F93F542EBB7AFD175
      14DF46FFC95727C3095DC52FDD00FEA97683CC9D20C5A97613F82FEDC17F2EC2
      48DE81F0587E0FBF270D3C1C92BE3401FDED668BBEB79C4EA7036781BE039377
      88AA8FC76E36FA9CF0E7791C6520CF8E7BC9F5BB00542AF1E5720A2F18A76337
      0CCF131794AEB117A493537F6077C7E1073719D2BD89FAE6F983FFDD87DF6E13
      777241AA1559C1C64194BD0FC6F0257293197CC3FD0BA241FC5BD79D66A338B1
      AEE09F143435EB2C1A867E42781F4FFCC4CD96FCF85BB79FF8A0D28DBBB3C4A9
      02B11DC740A9BD1920E828B1F16D784E11ECF7DC82A418762C0DE20867E37B70
      8D34A0281E4CDCA19F52FA32FC711B271E8893B59AF8B13F729314785FA7A5FD
      7D0B92B8D320E903068D6C9007694FEEC66194F23ED357DB1A65D9E4BBB76FD3
      FEC81FBBE9D138E827711A0FB2A37E3C7E1B0F0641DF7F0BAFDCDDF1DEA29681
      DFBD71F8FBEFDD890BF0B8B5ED0E9C27FA3E02450476750CC00F19CCF02D51DF
      32F5AD47DF86D32CF313C09D2C49FD7E660132DD065E7CDBCF92B03BC8A2DEBF
      BAAE1F795EDCEF66B0D7D76340E8B4CADF077102589205D1D0EE7A7114673EA8
      C35E3A4B07803736803A9CC5D1CD38AC6ABF82E23BF4DCCC853727031815D4E8
      2883016FDC3080EB3EC0C3EEA6A3F87612823E3E8A430FD56F3805C3284EFC71
      70E77B7D181DD573C0F11B3F88E8C93B7C0B3E065FE0C00166D8B00B77214C2F
      9EF911ACCABF9BA4A3248BE0F214160BFA7EBFEB45B00951DAF37A70950C00B0
      A429AC1B16968E5C38D28063FFC6B57BC33161337C19D18D3628F1DEF046FB0E
      B7064336ECE22F85BF4638359B1EC02F685B84F9B891D7BD09FCDBEB20F26CFA
      96F6DDD0B7AB5538DCBDC44B46BEEB89AF8338CEBAE9249C65B75110F9B835EA
      FB281BC3814927B088301A65AEF72F5856779AFA61D673C3A80BFFC105784917
      1E8137F4E1AF5BFA03BE24D930E986119C6C58B90F43C0B7DB04A950378DDC49
      160F817C0551DF0F4318288C6F07811FC219F660F82EDC3899467DCC4973D3C0
      55A3204D4960C682AE7423FF16064CB319FC9AC23B86497C0B538E074186F38C
      10DED90CC08E24137E87B946406CB2B43BF0716E7EE8DFC0E5FE5D3A21030890
      090FB6F016AFFBB8A5EEA00F270A27ED0EE8E629A065D81DD11D08B70C28A59B
      C09D59FFC625506530597C6890203CF0C28D9BDDF5EEBAD7493449D2C8CFBA7D
      17CE23E05B0860B4107102388E1337B3605AEC19F84BF716F07830CE064108E7
      C872EAC0BFF0FC03259A267E364AE22C832DED06E1201EBB7D37EB87D174D2A8
      E3818309595D3C759E25CF1FD0F0C8BFAB7671E7FD64D6AAB6BBB8F3E22BCC24
      BDC32F00FE68E4273E3D8D8FE026A1BD8946F3072EA0781F36900EB0458C2582
      9FC21B385C9368DA4FC67801CD61F8379BBBD0D53289466E3444F6136577996B
      1D09AE241E46411B1F87C93EE9F91A7C0356F8A467EBF02D5CFDCDFBC5A71BAB
      BFB967EDFD5E364C9300B0F234EE1BAA4503ADB611F78DD35ED7843AAB4C0871
      7EE948C07C12A055A11B4496C0EDEEAF7068729904C95AEAD2BF3D3CFB40E65D
      FE048603588C4FA08420D01708CAC40D272317BF44D37177407777E329213CD9
      5FAB5DA075D33403523BCAE035111956A5C80403BA9A7003125016F647DD411F
      F82D90891AE8652DF84C1D07081B2C0E7935CD9D6FAA222FA45FF14750A96CFA
      3200FAEC804818C35D3C48B33B0AB43FBC9EFAA3D1EDE3C1A4E7A289364434C1
      4160570A53EAC163559C51BD5D9847B7D71DD84EA38B3F740134A3EE354813C0
      48412301F1445B6317C50E7DCD3F8DDCEC4D6A01FDB56063EECEBC20B3EA47D5
      A3DAFF444C06FAC31BF7C76D99FDA82D2B0350AD590220800801E801B0BC9B0E
      07204AA4BB3B020C2CC993A53F476445A38B88532DBE5BFAB21F78A5C2188920
      55469B41CDEABEE9B5BAC0D77E5FB21905CFF8CABB32E7BCC46757D8A7305DBE
      3BF8F84AFBC39BE3D4E700C45BE3D41F02D17F349B1DEBD03A397BFFDE02265B
      3DA85A637766F57C2B9D4C93209EA6E1CC723DCFF7AC2CB640040E3D92BF52CB
      839F813AF543DFC57371B461FBFA1FCD561D1676C1B2AA7571F521952B4BFC49
      9C64B022389E005BDFEABB292CE876048A0D8AA196D046608DC160E0279BB6AE
      26ACEBFB519CE212CE2E3FA71608B5D687D803096F3A49376DB66D98ED711F30
      26FD3188413900C002A883D0B7867E847A2561511C0DC20074216083D9342DEE
      CC86ADA863C38A7E3EFF547F7BFEA9D5FCC53A8927335C039D21D4B360F67056
      5C6B808BECBB11FC0702B7056CC803656302D7E21096828080FB08210FFD0865
      6C8F91101806E82CD3D08BDE649BB6783C54A8327B539C2EAA83D62089C7E29B
      1B8420825B20D8C3A2506FF52C58653AEDA5FEAF53106BE02BA1C2E66D6A03D6
      75359BC4887A3FF9EEE4EFA71F8F3FFCFD380AC68CB2F09BFF9DF5CE258353DF
      3AFC3B7EE73F366C296D079732F22DD09A46560F5EDE478B586A65700DE8DB2D
      F23B24193DB77F6DF5A6A0AE03A90B06F4FB2D889F31082E70771C5B646FDAAC
      E5812A06CBAB9C20DB01820E4430492BD6003562DC262FF653383502FB2C98BE
      BC09D9DB2048D2CC82C3B8616BB2714D2E9D0CEB46A392400BD01C83D4C50359
      2EDBB4793B5598F76D12C3FCE2049467442FEB1C0E0EE1D77BFC02C7E9C3D7CB
      AB4D9BB82DCEC887AB8F1F2C32AFE04CBF1C9F9C01EAF4613178046E9320436B
      E76D0007691A453EEE909BCC2CC0A7711031EBAA5ABDD9E66D0C0A75EF3F9D7E
      EF47C4819030F332121F241A3F42092E0345C51A21DDFEF81558176CDD344AFC
      340E6F9017017D03A6750EF2D0C5E96651EB3D25C0C121390D52DCAE7D58AF14
      45ADD3C41DC6512F4EA2233F1D1300C6EE35AC2806491A985374E80E87B0D294
      6391366765BB3BA56B4BDC748428FAF1F8C70F4C19406370D10C6FF9DED04774
      1D84B02C78D24DF912A811D70748E089B273E014085871C2A22F5EA4FB18FD01
      4A4037C338BEB6A613905E586E068080DEEB86FCDE9BC0A5C7CEF0B1F7303C20
      11E2CA4601B10C843FFAC9EC9FD3A07F7D398A6F4F84C0C94A01B0C719099CA0
      ECA0EC821663ABEF27199A56A46CBA5987A01C557E8049F563D4D8F6F8F45AFF
      65B5ABD57D41D880110A096D04441A8538B89AA04D738658318E51B213C4C18B
      11278844E0B60F31648ED92922992BBE6F145CCAA0023A2C920697EC32BC48CB
      1DE04A6079F8CBC44F50F9C3F303E205DA9C014C5771C59A4C33969DE0C9DD1D
      F52C9F2A667E61EC7ACC015F052CC85BC344A42F949708E4BF1E0C09279AD844
      7A1D44484B376B3D83788A72EB0CA4A11B3F44B7242EE7CA1B9C85FE18D48BA3
      F7B011E7A08E7C0136364DFA3EC983421D415048313791BF33D5EBA1600C43BF
      86D51209B37E3E9E6631E89E2406938F28B5521011FB2493CC1FD6BD5B1C9D98
      204203EE8C527FFF35AC16F5EC5F802E091A85AAA490CF58E0048A857AF76B58
      4A10FD0B560087719E0E23B7C15D03B60BCBF1927802687B1B59F140885F70F9
      907CB3C0AF832C4EB6DA8EBCBBF32188807CF5D139B26176846F6E4C76BEAD31
      B9E5A0ED219D0E06C11DABE020390A433132D7C0930C67A3B60D884CEDEDF9C7
      1F7FB1CE4184068D0E8EE1BB4F9FFE618D81BAA656E5B29FC46158D9D039936A
      53F9328DB260ECC3548349F63989D1F89858779767D61988F011591BDFC7C38A
      E5DE802EB87142FB1766CF2C99480209DBF019F836D0C94B14414930194CC390
      2D5BF0D6CC47B96B6021CA23D30B120BD33A366A65A86DA0312DCC8289350AA2
      8C8C243F062086F6E3703A8E2C0E3C48B79CAA039C40548D803F7E86778EFDEC
      8F05C93380F04CAA094B8FC768AD95AB26830579E0FC7E00CA3969EB2E8A0902
      40B72EAAA9B7DF3D01CF1D9AEA9F9803D69EC9019703A8BE1A840E7F45E11CE5
      396534F87D1564A19CDF15D10535EF85419F39EBB4BFD2341F83D39B8799EB85
      199A8C1EDA6D0CD17B26205F60B76FCC763F1E68485D50A3469BEA6BD8647718
      9A3D7E0AF126274229E8300F624376F85773889FB4C17892976CF2661EE35FDD
      17DAE56DD5324ED86A848137644845332A1951B744D5384E2930E98E9450D79A
      24712FF4C7A8609CBAB7D1700A8B279FE95EEAFB16963E08C214749130A660D6
      49E2DF604CA08C90DBB7FE797C02EA087AD1926BF2AF8076AEA9EFAE8870A203
      079A0B8544B929BB5148B739B0A46DDAF345B0AC9BA6FE183DD0A0D1A7BE1A8E
      C28C003E298C23C2AC8A060074D7E31C62E1F144BFBC7064DDFA090EE48A002B
      8A84C1A9E0D4D179E37B470201AE46418AEE01D83F56BC0488447C60998F790F
      031E26719A06BD7066C5F08284DE90EECB81796D01DADF6FAD3882BB96C10C41
      2920832F5F2F39296CF1CBD015025FCF479F5A3C4DA4268BE943684243DD158D
      388EA6ED1A2D7689165BFFA65AECC718C9E20740CF0F0217D7AFC52229C13434
      3A0539CED321EFF9742C269330E0B8E36F7D0C1EB5B23DA61EB804116571194F
      43EBC40D924818383D3FED27410F1647A4F5299EB857267A9DC749DF2FC7A8B5
      485FE1AD3B4B05DACCE3152011EE44810FEDB133386136E046B36C44CED3986F
      DBFF46A2D2E3326C56CC6781B5AC3FA3C5D9EE8C967FC487E7814A7BF8D34B8E
      32820CC4AD694A01B5E9351E251224D1240D07279D4EC88FC33822DCDF189941
      7C1F05B3698A67ECB39B257E1C6198E85B78FEB33BFBEC865252BA50629210A8
      FC8787B67A2073815805B706639FC24FC720748C40CCF2E288E269530A5FA34D
      3B40EF7182B1725E20429F2862BF9FA0831DA416D8489E28427BE2634AB8B507
      13C51178B2FB78148EBFFE8F5C6EF4796CF89DC3F1D054046F903173FC23875B
      4BC690C5138B761363B022862D5E1F63DC193A4C8FB6FA807DBFBB034262F239
      F6414EF831F0FC785B3C42C7446C2BBCE68AC49A918BB23568219C90F5582422
      D9FC36006D239EE020D6FF89A7575310CF41CE98A1E4C127890F98703EF5017F
      710E18CDF2BDDA8CED464B93C9B85C69697CE34CC65A5D058C890A2FD6671F84
      C033503E6793185DEF76A3B5517B0693C66CBE63199C9A52F8066841EE90581B
      71A57F4EFD14E5AF1F3F1C9FCAEC0499E7329D60050F366888874EB0EC0D0775
      6FD45A8BD1A8BB3B793C2A539CC41FFB54DBD3DA9B46B76E047786B37D19B1A9
      A8199B9B82281807FFD612E6C892E3020DEB87316673A204008A1846BB0B1B10
      A6166E566848790CF74FD24A95621427692B40BB31C70E5499DBA0CFC1308176
      4F0A78117907160112F54FB6BF452AD817C748FCC81D23A61D71BA1E1AA82841
      6F34CD30E470A3A053069B9F29EAE96B344543A008C3F6233203BEFB707AC589
      3B713444D1CF1F04116744DCB84940692D29A08DB5C7F9955267041E586373E1
      FE8611F572143989C3D09D90900A2B176401F11DC5CF3D020E9D0D0E7C7F4BD1
      78F82585C1F0219116B74F36BA6984C1B42AE32148FAD3319C174A13627412D8
      84B65910C2199D80AC0A853995290284AA58117FB322E1CBC15839F5FD09E5F0
      22967C12A5C32A79E0787FE4F7AF759B761FD6EE599C6CCD20C6A41911E2A8B2
      0D89E4443E9B1E00BF540E3D896CA87C6C566AEFBD948875A1F59A842E22C4A4
      DF7F0328AC530CB0AEFD99948C31C88E2862C05BA9AB9398917D9225217E1F84
      C1841EA89CC7FD29193A54D5039F330B68E771BC0A08CFA84DBE8ACDFBF9F2F2
      EC17EBF4F8EA98D29A8FAFBE20289874BE8A05FC24AC06B03963FF80F628E853
      BA7289EE43B94AAED50B29B719FEC1730ACC610FCE23A6AB6189B1EAEDEE0E7C
      CEBC1A9D58265B77AF221DE2927395D67B12D90CBEEE7308905DFB34D71FD322
      6420699D3ABBFC40699484187078D8FE3301BCFCC4C9CCCAE3289D8DE4AF04F6
      F0EB34C0BCCA3D957A936165C4541B5FB8337D158E2D0DD6A94C4183B7BF0A2C
      5CEFBE82F2F38199E6DEFEFAD1507A20DDDCFB8821E28241CB141C4E7615A97D
      B465AF611FD0E61801EA0CB95E00609C8F150D3955DD4F531079818F9100830C
      D043619FB4A931AB535A8A584A18BF8939356589615767978DB7C4DF7E22C90C
      56F639BEE594B0CB1F3E7D152554687B51FE0A8361B471690FE5596F22B98342
      C3910845430D65B3C48D5290B249A19138ACA57FA7D3FEE8B5AD13B48AF3F797
      5772DB60CBBC20E5A238F418199F5EC3A24EA79330E8A355A67282AA0228DD80
      9C15EBFB2F5F3FA77279221DD5A56A0403D8C95028EA1A8B615D2B4F96DA4E6B
      EBEE8ED07401114EE2C80BC897B3257E80654B27CF18567F0ED1E736A2E81AFE
      8923AE7C3745B28FD14E441FA87E6A3FB36CF4485105A0B19B490BBE362CD311
      CA4A12EFCCCFDD91751C09C567DE0B81EE720EEF81C9045BEE1AC877CC3A4E12
      94EE48E278E747C07D2C5974C2FA9C0431C88F3384F06981B2FDB9119ADD5A9F
      188F2A27BB3B4F0456651E09F7C49229B0334BA6BE0ABB139654507B05FAC237
      380DC10DA893FA5BDD252F448B224F86BC66C09282080E0B8892B3FC946C3BC2
      7F70A32970AF131918294B713141F1FC49E22333F4B602C1EF03C7DE9BE3C904
      30E79CCB56A3BC2DEF7A7360BDF91A71892FF25CECEE9CB2F0637D51F59AE026
      FCE9CD172E6D56B9C03AC1206890098B35A88AB453BE21E0A3A524F07CD44BE3
      5E1AD3E85213C5228509E83B5C360D30FD0D1796C0C83F9ED71BD487783A84FE
      2A6E95AAE3B8D618358C212AB4247E71DD899C017C88137C09B31B52777BA861
      CFBF452A682C4B05E2AC8A88A38F402DBCB83F255FD81E56A7C1C0BA49482E6B
      B44D53F8DC0119F3C813E2BBB0690AE6FBDB7E367FC69A47BF08985322B2AA7B
      74B0A490082318ED0DFAFAA9C2937539ED6171517F5B44AE2BB2D2A4B0EAB1D4
      98C93D4987019115CF012A945CC852060A518120049A88BEF0EF7C12C73C219A
      099333FC3A51A1CF2A302396180CFFD25B0FAC593CA5B791CB8EB11BEB7A1D0D
      8F9E1230FD278E3A687ED3A8033C604BCFD777AB59C930B278453B19E8CA8888
      CBCB981D01BEADD938BA7E0BEED5D9659D96F0CFCB139EF09AAD7D1B75329E81
      152B437477E7F2F20C41FA7A31A241D39708B1E660FC0D44885CF45937329C7F
      FC51A182CA6B43B0EEEE6C3C229C7F22CAF0CFE3D5F1E03158B08178F0222820
      292CBD42EDFF2B70EE4932B605DB5F94AFD74E04F820E14BF01DF88A57820272
      E6DFBF7F491CD836F545A9EEA4B58BB0899FB8CAFB893B91DA3F5EFD803E41FE
      E900F5152A2C069A8FEFA69CDCE1FBEC82E2784D6582A3D6451C8F8E09183C9A
      D464B65D05A7D38E6549C9E0B3A8736F055AA2A3BA9458CCD7D4784C4916CCDD
      5EB76CA3F473699AA258CA2C1EFA94D54D06B475EB76F796A6D8405AFDA2B552
      160D249C1196A1295F46363045A22415F68289E00D0EF5563E6499F01947C255
      361EA38D0BC9841C9C6C2A2F23CE20239BDFDB1C7145F0FECB25E36F27CD258A
      7B7617645BC2F3AFB834F9CB10581FE0F82D08ACAB659B72172E7401B048B387
      271659E9EECE82019B7B5E1C585C07751F890485848ACA22702B7A23FAECC2C3
      4C1151041E8903B739163EC2411005E968DBDD7B679817E0865B729276772ED8
      BFAB928D5166133098733917CBBA08446663FD0B94AC1073903CE505E40329C4
      BF8C78E3F3FCD73D6FD811454CE4861C5B9CFA274B1BF5A709D20EEC6E2122E8
      8281DA53CC1AC3882B8E0E150A0CE8F0C263099202091D94D062713F334AC9CB
      4992BA99007799F9EEF8803FF214122D492FF1870120F72CF7C37255059A020F
      44C58DF1D58C5A32F4604AD18B94AE002A9A5CC19BD43AC55A48F8D0D11F7A4C
      378F58EDEE9C6327846966B59A5B42AF4E31C14DC46F119F2302C5F8C6A8DAEF
      733A288516F613D0E5B96683EA7289586F1F558FEA8473F8AD81D8D41F19DDFD
      52A4CA810C72F1F1FC930CAED812DCFAAC0A9F21A92200C8DCC11CD530119EBB
      09166EC020AB82AC25FB5BE621855C380468DB90C2F16F47BB3B588A07A534AE
      E07364ED5D51751E15C89D8C69AC0870242117BC4AB0CBA6096501C783010731
      E005919E01D784275DE631724E065799923DDEB84C1C1BCB32ED5ED61AB9F908
      2D91FB8E50DE1F1594EBCDF2762B7E34C4104B8CECF9C7914CE5789767215D44
      83F8BB022E59DC70CD17D5EB3F7F3CFEB0BB63EDA9427B78EF7EDEB44DE6BB8E
      634E0F1FF9338AF4E11A7607229F89BA3762B3DE6BADB713731F318EA74FC21A
      63F5BC7C4F7930F80EA3F947189DE0F647814F930CD283E2FCB514C79433B890
      E4249E480CCD9725C69B077B4CBBA15751A1507006F55CC0690A78917177D58A
      BAABA282FF70B02B8CFD230CA89CE3668E83940BCEC00C8A7702AF487DB27302
      B0533F1109AC0AF279113B2A1E98CF0A6506442FB42A006AE518BDAFAF62595E
      06458EE407002DB2DC598AC6EDE7C1E2D6E9C5F17B3DE794D413423CF82FB891
      85D234E8DEB8E11475239510CEB7135A2B348125C7327498E59D937F4829276F
      A8C30519D54320488948170DD5F7F54075B1F1F033F5AB01B674C4C54664F20D
      A595E891321831ECDF8142E74753699B11BD6E0A4D11A4693A8766AAC029A18D
      4162B9C948C3E325F1C96896CE6E63815900AE98137E092501544459727CF315
      09900FDC723AACEFEDAFDB647488188688B07627F8C1BA67FA317ED45CD73ED3
      C7681E4805F080AC7DA6786CD60ED70767FB54A3EAB68B7298BEF995D5300C66
      DC12118E935699C7A498FF9661776E4C2DD21AA9055A3D5C4175330EBF157639
      8B6A43A1A826A8A547B24FCE9CFCF1244ED0244F2DD0818FEDEE3027134512B4
      371C095BBE4A98250B8BC8BA1D8ACA8C24BE5053BB822106E5126220EA7D7212
      7174E8F964D85F94C68EA4ED2F44716D366F0354F2114A24F06602D9D249C923
      A4A1928A09CD8D98BAB971B0BB33C597CCBD1213837D7E91DA859479B3948923
      E0898B13E0AEDED36482764B16F2247CB8AFA54C71882877F98CA5D173AC55A5
      FCB90A3AE481C07731C45DD9027CC6F28E480B3DB2CEA70999651743B9338DC5
      ABF0EDE28B41A64F35A928F1B914034ACE691E143B0F51980886BF82F081258E
      86B19025394616DB78CB6EDF4B16AAC5D4265359AC12EE9B7B471E60EB07B43C
      11671B64EB37DEC114F3B7BF486C8332E051252469595A3377CAD7F0620E81DC
      86A7E7091D739E3CD598F94472FCC3D93F5ADECFA785BC1FCDB046A79ECF2289
      762967E2A30EB8E4FCED69F528C4B807F2114EE59C7F88DF425504A82E39BE49
      69863447C052D2541710544F5A924640A977B06D5295849285A0FC2CA344E179
      954A8CA2CE6AD2E74172817CCDB8C25B865DDB3EAD5FF65AC4976D956A8E7AA9
      FBF6A8E73AD60FD8CBF98F4D15FE7682CD5C854A6C764D9C734990DBF32A8E00
      78D78CBB6FD75C1305F67EFDA17D8ABC62EA30668D513A31A55C79397B61B0A3
      1962BD6B7A77790C0FAD5D0B2E5441658B04B28FB420625E9D5DD6D65DB666FD
      48040C1FF3DC809791DC76EB0373708B0B214152E41E6186A07F47A23F8B705C
      ECE3FC139BFCCF3FB59AEA869740CF975ABB161DC4C23309BA2956CC08D2744A
      466514396559BB8DDF57218A737C0388CE7759E25A3771D0F765A139171B170C
      29B38C7D8C055B15483F9F6350D64612971BFB704AB9DC8456C3CF0756E1A7D8
      F8249E884A7E243CA22C40A475DBD9EAD9DD048B1CB280B71DEE1EAA332316CC
      2AECEE0EE195E6F446999C410382B6DB1376621452312BF826E0DA7A4279FB07
      1ABB318D17AB4C5BC7700C4F518FDB76D4BA1CC1BBA958E4E5C4F7BD7754D87B
      3B506C77E713AB2995AF17D6A550552A88490702B92A0C9D026856AE725E918A
      DE5C9C8EAE0005C2CCA27A60E71E3EDD1FC12373D175764352ED4034B750F940
      AD7860309E2454579573EA515C42CF1C9949949E770938D8CF64827C41A74B38
      999FE6E08AE3275D3BD60F7E38B1DE8ACAF7F0E5A37F374D3FC41E7EFF3EC87E
      98F6E08BA89608DF645385B7A2D7C05BD1AA40ADC4343411EF286B68626F7743
      1353D87E798A79EB9BA698EFEEFC47D36E5B8756EDA846023B626AD51A000923
      AB28DB8CA41999BBD4A17A232A128FAD8B5390297B89EF5E7354C661E273702D
      DC7100242FC15B37ABF024ACB88375F1B9021AD0345C2DEA27B7BAC9ECCBD9E7
      F7C72767D6874FA767EFADF38BF767D6C7E30F67A28AFE462DA8ACC0AD9BA137
      03AFF30D22DCC88F40BBC6EF5C146E4C8C2F17E20B123CA2443F71D30DABF857
      B260ACC9FB16D0F2168FF438469BBE604F961793DD95E2566091CD7A2F781D9B
      F8DE1F62017A0C60201B2BA5DA4D276C2AA972C579AEB04ECA697FBE8ADD66AF
      8EEBED5F9D9C7FC55DE130AF3CBF8623672BE731B9EBBE4E2AAF634D79F5D0CA
      670C8649505F016934AFA5A7A277B1D0CB24B37EFAF4E9B31667F22A96D94BE2
      6BFF650C1F6BB639BE885D74DD8627A2B23EBBD3A5333A986B423B0CD81B241B
      6F882A59AF025D4465B18BAB0F7AF15C97AA9681A41144FF02358658951E07BB
      D96BAA9C066E180FADAB7812F42B1C19F8539C841E087B7DBF627DCF210AC235
      7683E57C52A464B05EFF6E02B7BF8A5572BA93A84945719097540AED8BDF47A5
      57D081CD64AACBABE8CAFE0D64690A52ADF2A23434C99AEDAE0C631555D48539
      34645C150AFE9270CC0DD3724AE040F60D29DC0B09290F5AE9BBFD91AF057972
      FB0311E9C2D5F0548B46AD6FC96B58B8E8FB34C08E1CB086E5F1B41E0594B08D
      127001DE2C6C299CF4A37025E2A26AD40A040839021194845864FDC079A1F10A
      713AAF0146D2B3C10A4FFA32C95B803DEBF673A0DE92AE3F2BBDEFA6EB2F21C5
      7DC3B8070CEB61A479AF0EEA4774C4C9409148546CDCFA051859621CD88095F3
      81ED3476EDEE08EB281B9AB7C404FF6E664DE2C934743193002326D1F65E3013
      CF075721F398F8F144D656985012898A27743165F2101321649F5D5D2486A73C
      3244C165619EDE760F506EC447595498F17B5BE507A2B83776F908EB253A66A4
      4FE640F7864867CC7D50CB6B1C8104DF8B43CE4723830BEEFE374BE17F3D7E8F
      EA76FB3D102365BDE92D3982C7A005AB3557F222DB79E81745A97B32CE143BB3
      8AA6D34AC8C6E2367AA42947F61783DDD1148A59F59845364CDC31479A1C59EF
      445F22E939AD9CC618EBCD96D32803014B248D55F8BE5E7C9777F203F9314241
      490D3E9852F0128D9D8AE7A9CED99232E2B8429990B6D7F3FB2E9AA0454430FC
      2472A7BF59E970672D27C269959C08A7B5E289B822F73850DF13748D83F0BB25
      0703A305AE3E9D4861488B3E08FDC17CF081865F64FCDFA3E802F25101BE5DE7
      E607ED4600ECFE7CCE08A13DC859233C5AAEB5007B858C6BD5374EE329BEE724
      0CFAD71B5F716C77E70C60B1764D54EC0FEE3847EA93554044D30B1392488A52
      7602D55A24F0400714A8802320F523D475A57D0A13AD3069598B55BF4475D2DA
      93960900541467FBA2CDC2E2801CE0AF75B3166D7D65C6ACC82276876EF0CD44
      EBCDA0596CF1DC925245C7B2D7852F4A7182765F4C7A9E233B684BD51226D6DB
      C1F1FD95F557EB72E369C8C9D597F730D1F3DF7777D61DB84B7D83B51624BE1E
      46BBDE32B9B575C359D113B235531C1C16401386D76BDF9FA46259145222A3D3
      A48D153E53B411C429394E5F66D52F42FCD5C2F5B3F498A5CB354B6335DDBABB
      3362208EA8312C02156B1F4442E83C50C97AA96A3F2C72F706FA64D410E2B9ED
      26EEFF7F1C8FB784B4A372F6EF18312D7141F17193251DF7EE25EE082B557A83
      4B5FA8DEB72F4250AB07D65F09AD0FD77C42B7DB56F8F5026397C75A3CE69F1D
      F1590D8FF2BCFFB45008B437450F26F02805198AEE9E4964A7FC5EB25A88A4EE
      6C94C4D321A7AB55E8890A9746C7306F99343B4B336C888C97F6B0B9BCAC4733
      A7F3ED1722CE6F45997440FA9BC0A5EB7252ECB18EB41C613D05FEBEDB2C8A25
      C712A72ED721C294FE415119C1EECDB9C505961D8B743C1E9496212BFAE8AF62
      AB2A3DCD9DF9521F7733930ED0F7E4DADAF3DCE41A0187CC07E010E2552CB6A5
      6A58B1A6720AB7597BF25779B77858BF995FA8AD1F5F2F1C5C16ACF41AA18C69
      869293722929512EAC10BC4F15E8110A7215C0A9475C8C42724EDE4A313CBBEC
      6477E4B1BFE5694D8C09EEADBBBB03B20B868950C76FD9F4B21F87F134D92A3A
      13702B5D0049A2DAB629A196C061A57D82DA5E8F2B43B0A81679081CA600A9B8
      93BCD9241F62E4D71D76800E3040439D5B02FF3EA669BED049537D1AA5017677
      874DB0536EC5100C02B4788A91DEF208FB3C22554EC9CBD4C925F5A858A42A9D
      CE1745DA756EDB92C40BD1898ACC8498889E6316FACFA75B5E4BF2FDEE0EC708
      2F3973DB62593DCEEE4DE4D283BDE858CAB06A61891555E9E2E1301421986442
      0B42D1A957DD9FC571284EA7784898C8E06C009B61B31BB09C5E10898A726C69
      E53DA1F4F03D3A15BC3D7CB2D4EFC730CADEC259D1DA0D07217B47DEAB0D1F53
      8EE404CB9217B333F4F8A63E26718B13C5A010514E0742E8C85807A5FBF60AD3
      7DAB4F6E5F0E22DE2F00916BB5DB7D1077777E80F71F9E7EBE60BABF2567AFC0
      F0647D1AE0454560E882A30800061CC232D3C8C9809BF87ABD2C653CA11F0620
      7C636C512A33D1FF6E01C4FE3F898D925BCA123547AA4E77188C834C95DD1765
      580967650800A8C0ECF6A7EC8998247B3F9C93EF7016CC7612DCD57C8A80F419
      9B6DA4E46B4EC1EE4EE50777DC9B2643EC19FD0174862D3907C756BE705A77A5
      24EA49D8584AFC7E9A0A282A9D8A5190CAA7D41B1BD43032B8ECA9FAF3FB82DE
      63A20CA5764500043F35ED7C0BB996ED6F9A6BF93E4632F26F22471BB52FB297
      9FB507BA2E152C8EB2CD4AD9C4625F1B35A16D2ADFB1BBF3016B6BB35D2BC3A2
      EDC44889DB45B26556002C71EF6FC42D3D1F089527023345F103921CF3C6167A
      49841428DE0C64812C2F0742950C743B1AC7E06C3B5F3DBB7C2F6D975B8278B9
      CD7640C54E95E5169102C181E2E6B222B37B5AE92AFCEDC84F430B300E3868A0
      F43DACA8214C29AE2803E9CF8DAD742F7901655BEE0697AAC289A2A63D993A5D
      947FC80E52C15CAF2C379D50FA0C1755E76AE488F893897C90622ECEEEEEEE2C
      4A1E3BB2CEEE5C1234C340AFAC2AEBCE5EF11171B1888912BE95062A4BC54E27
      F8D569D4AC0A02B0A2A6BE57AD529DFA53D640EBD54ED392D356F79C9F55C56D
      67E7E7E7FB729DA24D001582CF8271A118A4DA933CC315CE7C3FE38AB05C059E
      CD44EA35685FA75F450D7F9CA8FCF1406C6C920259098641964A294914744722
      F4F1D315E569850187C6B89450E86126ED38887CFDD56E341BC33BD4AE6AC53A
      D1268EA489CB6491B58DBB0970900CC95BA87DE45837C8CBD873E2D47802BC1D
      A7B087F40DC5380C8655C513286427B23EF530D3F1E2F4405642A68C4F375F61
      A097AC3F005DE77F10F415228136457E843C4B34579C96A0A98EC1B28A5B8903
      0FABD74F5416F2DA8BD05F0C23003ECC63DDBEF6DD1D028CAA3A2C518B0E16E1
      131E45CCD1C21948EB88DA49A999CE118935AFFE73EA4FBD78FDABDFDDB18AAB
      C77569C85800061F3D010D447895E9B8024404D5C11A0A293F8C16476EB14222
      81482124D2A3A39BC0689D806D392BCF9B496D1947D716AE1738D75AF850B16C
      7946310C7CED35B3B128E54B77BB13FD81445CC47A4BC71E0EE256F30F697747
      45C4987DD1A1C6A38F2BF3F2D66047D617D540887CE8A24593406B19E54F328A
      2E9FB0404744EB9238EFEC32B8C376B50C33FE999DF2AAB350AAA815251B2AD6
      B6789AF06DB9799153968590358903EA6E842A4C34C39E7C79C511D9050FDD5A
      5CAD3D8CE36B947896CC11DF389EF647EC2040C37B9F4B05178A3390F34E1477
      90F37D074FA2370B2B0CBB3019774C7DD4601CAA4FC3715D2943291115E40728
      CA6423598C49DF0286B007F353FD8A61655CF5EE6B4496D08AECE143EB9E6B63
      B3EDC4F84BDEB9EADDCC3A71C919B225F4B8B876BD0F83D0295808A65A009EE8
      67CB97E86C721005570A60C999EA756A8DBB125F44D6B0DC7EF2E544193AB9A9
      36D60FC0A66CA2D5254724AAA302F363C33A8DCBB238765DA237C29870B4D977
      857132890F4739A4E45014F311D923AB013ACC5CB72BD214633A55059A95B944
      DDF2671D10F9B16A4F21C8461C6C0B2B7FB0F78FE6A1E03807445EBE68318221
      9A745AC58B0FF05BA0A546D10A15FD4DAD07F74768AEC5CC287EA78C00EDFE86
      9257F777A25CB476A11DEBEA158789F206BBB2CD23B1E78C537107404E802F4F
      3354CB7A536EDA22E9938839951AB1A4A3D4C44E96C164142A2C215A065F1D9B
      A4D2AC89E547006ABE050149D1469CBAA0753F83812BD8BA54AE9C0EB55F616C
      05B57AEA869C1FC303515754E45994F325E6ABE837ECF3E2F4443850992245CD
      C05E50953A8517D29AD6AF4CFC4DAFCCEE0529EE654A47A52F8EDA4BADE53D1C
      90758B357FC3D4F137C2FEA063566EEA466CDEDDC9B807085E9652CA4BAD13AD
      D92FB54E5A84BE4E41B225954B909E165F0EB8FDDCA59D7CD7FD0D0F51F7F7F5
      AF8B0EA790C928C2255FDC96CB2D1FE0B6E010D91EF7D4947B8C74511A878015
      96B2902D117190688B3E932AD097409377FD2AE7B2DE94EC452289429859FD04
      6FE028B5316E0217B0C07D48733B1DC72E90153A6FC8ADE28D4F3E7F45C7AFAF
      1527D01A5B6ADA018A3D58B31A8DB9340D34EA6A66D76DC5FE634D6844980B71
      1204CC9AB3A558CE6B17E2B52E5493D0A7041C370F9693A2B826EB58859184CD
      5F1911E518E25CE8D50ADDE8BE8A68DB8EAE1754CC1D40A9FA6C506DDDD8F327
      F8C77659013FF05915BE1699A8A62C466C5226B15E78CC70A2D87C2CB7E91C7F
      BCBCB0F6D07CD39B81A202341955C704847B8C3C86FB777738168C68AA08DB4F
      55393BD5775BEDC01E7AE3B8C65F76EB7328250F974A7B384C845EC6B6947D3C
      0D14EF657D968D9D45DF7B6234EC5C1A81DC49951F29160D16A777D2E19A8AAC
      736A1061637AE0A140C78D0985BB8D16AD662C7C9B421529FE06EF0799964E27
      B021714FD1EDA5D5BA404F280573978FC83A9F2CBF44B7AA2659B2A2B408FB17
      85E3FAA19BE26DD8C499B74F53A352D9B93915CD38655CBB6AA88C56B550AA69
      6212296BCF541C8A16F146EFA51D441C7A406E3C994E498B90DA9A069D1C369F
      2EB73BFD7177E792B6476ED896D0A02BEADF84F6032D2E6501652DAA903974D1
      7A44DDBE19834C605D21B0AEF34D03EBBE67A6A0B6EC501018DC5B61F6A6200A
      9282B013EBEE0E101255EC12ED1D14EF7B803E523FC19E6651EED424FF3EF56E
      976535A423816A7B1F6D1426ECEEFCF8E1F814D51D6CA514302A67B3892F8043
      D6D6247167398A2B709185D5BFC37ECCD802EC7A960463D6255DF409713624DB
      DB18CEC2EE26ED65390793BCC272D180940511C526E4C78C4234307E3A16C6C3
      0277D80C488A684D64D84BD06A110468A024D4597789D423F1AE97E90777CBE5
      F2C4E60529F3445CF7666D07D0EBC48D524045B22DAFB627736829CEB338B852
      08A0A8042EBE3AE4EC82D40755FC1C4ECAA75E18DC501F5EE961ACB10022FFC4
      8A8BB7D68FC01F3854A9301378A71F02DBD032F6C69818E7713F450C40E329B2
      38B6E8D7E349680731C24C7CD1BC97AA41C1C90AA794D31BCDE4CE69F0B1F624
      4C44EA035BE78B00FAD321EEBEF435E5BF71AB0534FB87B3450CFFB34B3AF3FC
      51731B69B8898A8612906170C7DA23D9F9D07A0F9A7C645DEC6BF629C0225066
      938453A4B9D5F39ACDE5FDC9A1D0F6BEFB2F39AFBFAFBF0233B7F15CEFDC1F39
      DFC794144B65F981D219C3EA9F32E7693668BF40308C9BE314DB3E8FB094A3EA
      00918CE948B27CD543418BC3C9295A4360984F044F1ED679F98652CB16905990
      3820B45FAFCEDB24BB248212C800D1E2E814EB326F81C8C7159501D29CCBB077
      1B47673F2410609666D47A6FE7BAA316635616E50B5A091904D098AFA7472B93
      514431B71C363A418BB4E0614812E937F1F79A1B9E3C86903FEAF01129DF6EED
      FBBDD8DB6D29C4A289347BC8962FCF38B4390E77773C966EF444B602EAF31941
      416918E1D1315A78410BB7971785FEA3D47018BC17F4415E80079A1BB53318B6
      80B4FB90E8F5664DEDDF3E280204B3EA464DCC73236CF64D3373366A667E340C
      37746AA0BA6D2AD406E8DFDEC8990D7D9002A38D9C59E2FBD73CB1DA464D6C34
      8D866E1248A86D16E5005E13069BB9A1FF7227EEA6720250866EFDE186026E12
      E72477B3B00D15B6E970CA9BBA71704BA669AAB6D4DEA8A98114B9A9BC2ABDF5
      BD0D9D5A364DAED5D4EA5BA1B1EDEE90CE76796674B367E866CBE390FE28DD6C
      A9CCBC0D682B3D35F582DFA6D534B8FC0C5C5E6E39FBE370F98F47E3CDB31BEE
      EE9C92A790CA92098B33465F2944A6E41A2E884676D62D39F4170B99A654336E
      A439B728A48CFBD62A68ED61B6245C925E2D4E2993F9442A9A0C4F8BE5F6E0AE
      7DCC37A2D2A73319085B00B7B527826D53ABF295FC63859FBFAB2CCB3342833F
      C578EF6BA172ECB850A5BED0858135F4B43042F46070CCC5E234A4B76EE247EC
      F375B92C2BF6234010A0EF62CDFE829FFB13E95CF9E5055AA6FA7D4E141475B9
      A9A41AE6DBCA32B4A2604AA0AA9FDD83F2395A67771DBB09FFDAED9A031F4EAB
      DE868F5AB359878F7AA35D858F46BD83B734EB36DED2AA39784BDBA9D7F969BC
      05CE4E8B86A9763A78936D77AA7897EDC07DF8596BD5E9BE7AB3D17CD1B3F4FC
      B41E7D1F0528851CF137F4168A4BD7581A318EFED684FF6D058DC1F8F8BC5031
      05985963980B62E3BA53FD5FCC2B0BD30EB4F0F33DAE88B4EE1010C489F5BBC0
      A337D981886801EA8A68C085B15D4C5BD429A7B64DB95796CA5873512274DA82
      0CD7F7451480E6AC068AEBF9498001FB44FC25A3D86E6725091DC411253CB6E2
      C4CB4264B2A59E880B90D2015CA99C3161AC587BF0B5425C59A91E54993D97CB
      06148EA4072B282C55E5D0C7630ABCC49A0F2F125C137EF75F7242E5312AF391
      242B77561195AAB9E8479A057A716C91C949C737BD0D32AABBAD076368E10E5C
      E09E02F0B44A5D14BE045AD87842A01FFAC5840EF5B412DAD64DD5FE0BA343FE
      7E04C2F74B84B61DE4130F64708075EDCF08A7F2884459A2295DB88762013164
      97A358B69D622D04DA6C15C92A746DC87B362CCD8022F5711E5AB24C98ACC89D
      D3B1549C5F2E09986067DCB124572ABB46D4BB2D54FCD439F400A68415EF97BF
      1CF59569246A79CB40196A85C9149883BBF6C83679FEA92E82733FB59AF2065C
      2BC568898391510103FFAEEF03F110C2ECD1BE369F023038E28BE34D17A31E29
      158C5A198BFA23B83ED2B954BA2F256D516096C8D57A4D8159B946F95235F18E
      720563FDBD572951EDC8F28F86476B17CB3980E9FF0AA6FF72CBE08225845322
      64525696742D3C67A1CF32824238CF4F834413775585ACE547FB56749408529D
      E9668CD0242333DA6244BA8B6DB3E3A04F41868F5017BE75BCF8EE8EAC8491F8
      A274913200E520D10A8EE621CE7DD1CAFB69E46D5B19EEB2448D2DE1B94B965E
      4CE0D57377979C4724B8CB237F292D8451B1D0EDDEDA13F1E08F9376D729EB3E
      554D40434421FFE05BE9394FDDED7D22AB1C2A2E8A17336338C8379C0CC65847
      61CEBFA4E5FEA7840C701F6E2F9A96B9740336203CD1BBF9A821F4CE83A55448
      14FE9149E829A38B2F6A93CCC32228171A82D541027AEDBAF93893E0A2FD7E8E
      8867FAA1DBC32384FAB5960EB4987DBEC417902D4B2F137C6018C63D129D35E9
      6F0F613A498238A11E51377E52A2BBEE6B3C63ED29322F9A1AB3F61ED998D343
      707EECB41F8330BAED64222BB0A9349FF5CA81DF34D1E74933DEDDF9E3127DD6
      8E3CEB47F142A15A2403A88BDEA28C222B68530FB883973A08EB9775D1F949C5
      28933CC1B140F190A6C9B28D4585160B295121159138099208D6AF9CE94AEE6B
      510085D47F8F2ACE8B3C607721E84DFD24E8290E3C583BED7BD16CD81752734F
      13771847BD38895E50C555B5A6290D390B4093991D1419FEBDFC998BD4160D33
      E4D5914C9744A27527784EBEBB83FFBD00D3C53E74CCAC447C00A32677ABDB5B
      6C75B25F2CA7BB6EAA8BAB5CFF22855CB5DEA9BE14638B66F3DE526670072F73
      E830B269ED66A45CD7208218622D44AA705C975D47C8838DBA6AE87339B76AAA
      16B8DE4C633C3CD54EADBA6E9969DBED2EEF63D5F76F5BCC2DCB7A1E5A91EF26
      25050E29C60AEBF0A1AB512FF3095C5FD8BA49215C5AA3CFC4133D93B271189C
      84ED7796488E1050E55F87855A15AAB2DC775C9162A12445E1D925224271003B
      1FE06496046118F48B2350718185279B8D6AD5B6F6BE5E9D1FB6F7B7E268FD84
      DEBE75D3FD97AD0783D67D59615F9D63B9870BC5DD810E98D3FCCCE8C06AF5BB
      6AF517EB5DDEAF1C0BB8FBC977D6CFC23F260EF8D1E5D5978B8FDF5FFE224ED9
      AA67720BCED83D0AF5534FD90BFA54C91FEF935FF0C0A2E29BB20428577189B3
      3C57C21CAB271EAB5CE956FEE592F363ED91D3476EF7FED6722A55060C6DF2EE
      DA35B2173C52ECE9A1A0C280CE94254BBB7139B8BC4C9BE158EBE158F5E51C4B
      3375F9E9F817EB1C2D2CA2F8F91E5543FFEEB873DEAEBD3B3F9707EB31C33DE5
      E03E66FC4BF2058B2E07DBD2BD6AF1ECAFBBB1099A2AFE1BFEB76E53451EF10B
      A79B18A966E53364E0E5C980ED2C3F5727934FE2505EF96906676B527276893E
      FCC0CDA64FF3BDFB863C78139B1EBCCF5B2F8FDCC80BB78532B1692A5C5C7DDE
      E82DF16F9320CBB0CF40DE6E8B500B90C9C5B078B43DA9428958209FFB818F03
      6A2F89C4202F7DAFD7B2E50EBB1CF1BA58D4505A492F35C9FD806EBE3ABBAC63
      18ADAC71FBF1477D05F30931E482E0FC476A4723AAD5C2208DB79797672212B7
      9EC7258961D61D433A09A7B0DCF428BB5B2DF6E4317E8A7C4932414AB5359771
      984104BB0250D1DA2C3341D7E6B5AFDAA4082020B4171F645774E8632D7209E5
      753BFF7112348795E1F578FBBBA8162131E04016EC959ED835FB5541FE59BB54
      0E335F7B35643F0DD73D4F15975D28839AA1B79E8B9F227950DDCE3F706FEFD4
      CF444C3FB79E04BC1B07DC8444F32EEAA103052AF0945A08CFDA602E80E0E2ED
      AA26025549802B967DB42125116ACF2C89F03C10690D3ED74E04376ABF1DB1DF
      6B05DF57EA757A2FF09E1CE37A88A4700DE543F0852B020E6F9D831C5CB26A0C
      BA4F0360FA811B5AA7EF4FF0C0C3201E7AB8E4093FD469F746ED7DFD25F65E1E
      9DFFFBE3974504205DE39934FA50C404FFF8A55081A66EFDF86523D0A2C1503D
      A110AF38B24EC2694FB6485D3F76AC7FFE4D9EBF646F98AEA1F706FDB6936B1D
      89D27ED161D904FFDC8AD0C540760AD41A92B2C4BBBB23FA718300C2C8A57773
      E0186F6180437999E56FECF746B53EA83E13F574C376606996472DCA760F21B6
      E39CE93E41966EF2C7B4D611FC1A6C842D9A1C5053321C69C9CE89DAEF932935
      7C86C951C0681089BE40787F0F70E07ADB5B1E626F14D1E94F45C35B1EF09E78
      7B1282464BD64EF82CD5BE3D958120EEC330DBA266E8AAEEEC98F3ED2698F12E
      7F13A7CBE58A457C12D203ABD28F2733D4008E8E8E08332B6C4E08C6410860C7
      EE0944EED3FDDC22A1D921947142A2F0856A7ECBC90CAEEAEB290EA6382FB378
      2A3AE8CC9D359E58B1AA11EA2CFD389C8E230609D9D43E1129D81B064A7321C3
      07B6924FB193A9307D4CE234903DE4957561FF40A939F8ED3D2B3C7B83A2420A
      77915D4ABC89FB30EA00E782F4A0C68E2F4EB1B5E320B8D3D521D9064C6E8108
      6604D2004BC43EBD0CA1884A2C8978620A479AEB84FA413C4F8AB154C104A0B8
      8D10452CD0CFAB698E9E8FFBE73DC20E0DC7E2DA3F1409452FA1460370DE649C
      4BE9F7AFF390F4F302C24B50326195245B3CA27EA5CC256C552932C6E877B271
      CDE3992CBE45B0FBF9E817D5B712B8CFCFFFFD8BAA11F37F005D497396A5C2B0
      7BBA6C9F4DD1E21E7789CFA891DADC84E428A7F1149F3F81795D23773AC992F0
      AF6711A59DE094799ED45E2D53F42067405482AB90A1DF0F639134C81483D7F1
      E91FF285E4F85074A372327FD681DBF90026506A54501C37D994C7936C7FB342
      C6709EE3CD7D7CE174819200C7E9AD3A48A2971E574EC37A69BAA1608539511F
      6ED12835278AD49D75EC6344ED1FDB92691359E627F22200E0DF5C2A00212152
      1D6CAD51CCDDCB4FAEBEBC27507B8C7D7DC4BE375BC2568F09FD620E8A7F22A8
      72C64725E48E2C51DA88A8D0C00DD31CB5D97289722ABF91D9C5010F2C4B7F8D
      FCD08337DC328F2AD004266BD8DB6792E5AEBC0F2201053EADEF81004FD8EEBE
      07B306C23C0BFD7D91F9AF9687F1AADFAC9ECBA61C91F32992486403D2527E34
      1CC5B007DBD5425B2C3A0F7E94665F6CA535E30C923D51E844883853A02B8451
      DC658ACA5271ABBC99EC363D7285B02286575C41098203A4FDD4B74B8C450524
      B5D9700BD1037D14D97E3E1846B146E4CF7876E23810EF657EC70F7FBDC8DD2D
      C8CEEF9DD7B69E869382D01E537B492028444FD22D3B12F9BA5181B706701EA6
      892835A6883D601BE7C48B02B0316A19C15854BBC1DB8631B96545D3F62C4324
      C72BBABA31013933D70902D5F81D487DA632C54700A85492FAE28E1CE41A5B34
      63598A674BC5006E7D2CDA948A4C052EF1CBDB8C87029B140F597DE37EEB223B
      F380140ED63D50128E5C2A1DA0DEAD32EDD4258693E88797E14B19340431D9C6
      7D0F6D20B7D8D8261AEEAB982592875DD9B454A84023911ADFF3FBAE2A7B41E5
      DFA4CE24C09422098AA751A6BCD494EFA71AC293E966FFC87A37C3316949A267
      70AA8D41842BEF624FEE1B10A183090ABE0195431800FFCD40C6CD0407656555
      4C5796F343A1947AC623D3179AE50D0ABAE48D1F7176C974B2047E947F48BD0B
      47B2789D80545ED14E28AC319C8900253B61AD62C8E563828E01038A3A94A4D2
      60C11DB1829409B3081C48E310DDF098E6888102A29C043E545C015AD8462A25
      32C741524A88A2A2923A9E640045F72618324A29C59E0B486084E28C55FECA39
      A9B8A441E0D36A7695234D4612E9B564B1C0E7263120ACC27734E021BA83EE43
      9514236617A23E324200070232F42615A64231DFBC8FA252A472E810BA1144F0
      3ABE8A96B2BB43711180CCDA2B69EA0CEA08CBFAD06EDDB7343ADF63F71A2DE2
      199305DF4D45076B5C0391BC391FFF011F4B5F1A6C5091149B95C5720FE73699
      E5BF016209ACD01DE2E9E35168FEF906C208846F74289080CC61EEB667C27DD4
      A0655DCE99DFB68419FE24EDDDBD3CCC8D0C2B14CA23F9C981D0E44BA1A53267
      C439C8AFD24190064561FA8E94C5375D1C09911BF9EB38E69238142623D99E6E
      60CBDFA16A21E5F6C6032B8DC98E81B4D70BB08221B5AD9FC8829841E405C035
      51D82D9C1861930C122E931365A96E05A2AA08820668B63A7C909C0D70E2030C
      D00A48DC95690FEA0D1A1D9F01791FB34197A32FA43D8988A13026219DBC7101
      74BD70EB4B0A9F450885B7A7414A663804D7179F28A9DABF2D39B35CA743ABE1
      24AA80FD4898285112CF101B2208AF3D0137ACA64590CCC176A00B9320104F23
      654700D62371120587FCA488A8C3DB82DCBAE0C360EEB4ED987B22EBA26C21A2
      0AFF4D764B0DB5091385ACA2A9619150E40B155FD1CB6A716199DC03E028B7AE
      1648492C65513255C58FD1E0BCBB23FD449593E2FB8F8E8E2A39CE07B2B4767E
      BC0EF09D4891C9F34256FB0F7998E232917810F751D014BC908DFBFCD239360A
      AF4985582B4273A5E53B9CCD3B00F8CC61830E0AC78B8A27EF8CFA74148ADA83
      E68026FA9445D8308EAF29AE1AFD8439B5707BBC14B81802F3CAAC9A503952A5
      8CED0955E4AF087DA9D7ED1F596564880B8EC805DD2C1025F7FE2D38D0B42FCA
      6D40AF904B3E745465E6F74194269DA77E413AB70B727800C0EE0E6D096106EB
      37D2FFBC208C84627790F829EF13A9BD317A4C7AD3CCCF5538093821E588562C
      3C31DC3BD6DAA450C2EE9EBC248B18588472F77CAD733BFA5435B439B28E49E7
      428D2048C612B1A58B46A14B11D768CD3D2A45BCBBC3919F42149A4322752737
      83D976EA3D079DED21DD0B78816725CDFB1BA9101D81B948E7739CF51784DE8F
      AC5C6BCE702446D497473FD81751EA27D99152108415661CA3310326430E9ADB
      688118007D3A992629FCFC7562BD95DF4F492739F97292163B01A142AE0A9869
      235D8E8241F6579E83AC66EE665A1090A4CAC41548A3173707030E3B1A886804
      4139E8D5C160F930BB3B489F8E177CBDE81DFE7222672CFCF585799ED235CDDC
      AE873CD13B8B7E2B614591D5CC549813BE464C396F1D25029DC464C87335A65C
      937C8129BF05A08015E26E0361C6CB17A885977300F9AD8B1D5958B5899455F4
      CC85610B69B95C35095F83DEE4270592CF47E8FD999AEAD5BF69533DCDF57C68
      1D6B4CF1E3A72B15FDA6140F34630AB7A7D8761598A3680B3B3DA972D6D1466D
      F51547501D5A9FE6F9BB0C4714685BB06A6FD61A2EE369D2C78EC7C7F352CAFC
      22584855E6F8DC7E5FAC8C889EF3DD9D8B53B16DC26C4C16705D44D230418091
      6BAD6AC58BE9E5627E722EF31C633380086BEEF13A0F91D0EA505341A10745A4
      A612181B88D317E459B5DE7FE2A5A0CB546C95C61274B2AFC2AC72F7EB58E6E8
      E5E5A8E5FEE5C2D29116BB87BA9FEAEB2331430B12E252FA14E0F7DD53D248E6
      C1E53C2A87C0990FC80625E741526FD7EB4FA7F5F4F0AAC43E086F4A9CC834CC
      1F41F38F395FEC703EC9AB505032F7C18FD10B9AA042091401D07F7376146D00
      D63B0CB986C520B942F5DBEF4F0B51B4B7CA4345C16C184B0342093D05925A34
      53E1782A609382B8E78F8B28F4EEE60FE021D9DD91F717C71A4883F2D2B18487
      AD38543ED0D548B786A4D2C3C8432173A23DC36620300267756E91124342A4E4
      D1593C1C0A4302590784EA3C26F6A4646B5848DF27F91E8B1A636816BB24F956
      C510C7F1340FFE7A27F6BBE8F4ED71BC8A47B51AE4AE0E831B2A488171A3F374
      525A29C88880CE444645742BF88911858BD4B1F18D45E1CF055BD447618B12C9
      B44ABB54BA1DFBD3451B3A2A313DA7282BF798F69B18646F1C44D3348F67DADF
      2CB98200705208988899DE0809412C03ADBF18F14B3E3D5AA6B49585C1A41723
      3EE5C63F12487A1C44E36B89331FA97A8117643973F9B313B2A5F6BE45B31D45
      7F1F2C33674A939E16EFBE60D22CB3DFB05714474226C2FB73044F0ED97A3F50
      BDA1723790B26112F5535E4F5A8574776AE3A3557EDE97A7D9E4E5E48BD1EFB8
      1543CAA49076CCC8BFC580083277A8C1C9A8507890B3588A7906DB6ADC9CDBC7
      6D714CCD2F9B707FAEFE44A11380AB2C678BCDEEF2C134F74B2A78BA6CF6A7B9
      0D5C0A4ECAAD750A55451286EEC4E1A4262E40CCB55564030299D01451079391
      1F2AADF913063E2DAC508437DEF8E58BE37BB83304196BE4C16339544B48128E
      3BD2FB97BFC98B4919E8F91C3989D6D632FBA2E8D62AA2777D2C5B93071CBB54
      E1BEA04A6FEB593D13619BDBE6453E4E39FCD64D732F259E9FFCDCA0AD1DA318
      AC0AC5A5967876E76AFB165D97833267AE96DAC82E69F68268EC6BDE69284C29
      88E46931932BB70F495986CEE13C237729F0472549A9B62A85E8BEED3E0DE4FE
      08A2DD1D731CEE3B0EEC25D290669D27A2E022CC0F816422CABD1EC9ACDF5C8E
      5CC6FED81848BEAE6F98B0B119E8BDBB43C566A4FFD060F6026673311E725F02
      F6BE14826B71238BD47F5EC37A48A7D223EBE15ED1B72D8AD9079BA8DC6E3D76
      047E2A6A4F3CEAB273A716AB66A2C5B5CAB994BC03A7A79FC98783918AB3EA8F
      E298C665EDB010503BA59D6207897C3D39A8955AA7FCD332095A4F4E32995BE3
      09EEDCA5D8802DA105C85CE6975E3CBFA82DCDA8D6441E9792C70EE4CA86C25C
      E9BE5D2800FCDCE2500BF3DCBBDB5F7F91C92D3F07C73031AC17500475654B8E
      433193BD04161CAF348625048779C86CDEC4EBE7BB5FE421B83FADBD71649D88
      D0238E1AF7380A973BBE93324FFE5B2B1D636066C2C33B851A0FE5D320BD4755
      B6CE8F6C21BCA224A29703781716AE73FC122BE1814AD12BA864F2A5E436C345
      72CB272D74D5ED15D7C535A544A4E7E27AC2601C30AFCD23C596CC180DDC9CF3
      886E2965CABC09DC2592CA3D00A1B694EC6CDC760AF145954AE6B2463F130A4E
      42FF975CF3C8777C5B28C7159F98C96C2910F293B3A7128DEE93960BD1DCFB4B
      CA546BE612D975931231A55B884814BC60C99100C9D23FB22E70B06C9A707D7B
      EEDA8966CB5455B656761378B997B843D5F99C6992AA242DE2BFAD3E66B6087B
      0B452BD295B410D192C07B0AA75EAA02AC04501A2655C7C94BD34C92188035D6
      2CC61296B95F8AC936835F62E3FDFB301FB7495010FAF3C44FD0124C89A8F7EC
      2825AC6BD540647016F6B9A303ABAAFDC88D168A80CC64439F1BBF8AEDCCA419
      C8526086CA483E283E53A4CF94C6BC15148553FF6570032E9B5CDB547C6CBDFD
      740E3909524079DD55C730391ABD2178BC0A1203BD954BE28B574B94FF41140A
      E21871F2791F87224A5CE5B18BD208CCD1D1522033E1528A22090685A1355729
      BD5791CF48DA07FA6E2A94673D039E1F960553B80A2666F07288BCCCF35737BA
      89185FD0C1000D6D846022106FDB4FF531D53DE33C61E1A1DE8AD3CC49F0FD78
      3CE600DD88CC55C011A93C5E5E4D42D86846AE6046794AB570E763C070A14C03
      E1E69E56504FDC185096B63F9EC4B0AE595E1CE8D665EFD63402A9589C228C0B
      C51A771E1743E08091117B6AF7453A0496E4900200462F63568A0F423A305C77
      3291B558157EAF55F13F24B43925505C02ACD64DA3C8424661112EB948A3C358
      96E5DE53DFFEC6ED3C3849EFC052D7BDB09F1E582727E9FEEE4E21BA11EB4A73
      E8DB12407509075E164CDFB95843FBA087BD0E0EFAD83D67CD808305E7A05375
      400AA1482B8082232B29D569ECCE0071FBE1140BB54800CF5942B79574562ED1
      6DFF35A2501FEB8720CA2A705627A1DBF7D35C5AAE90CD0277BF22CC185B425F
      C968B00C4648DC84B15BC8E19F44B6FE5E4CD96D6251FBEC49E38008112A8A91
      7553319A2C8704C289B4C4D8550BE305334A02ED21C1861147F0D65C586057C1
      34F244E0F10FEEB8374DB03ED2074A799689AF4456C59B44A80CD6E780D57060
      07C668E46C42DC298FC4898C9DA5B4E0404694A8BA01D314CB6F5045B7F9CA01
      4B87F8F9BF7F91B0A2D1B03F0E6634105FE1DC22BB21129F53C149E03A1AB1E0
      58C336A3A84EB187EC27C1B94471FC6F5F3DAD00B7EDA79AD41CF4C2B0554BC6
      C25B3E97532448E269DE92537C8C018A0588ECBD8303B72FC1501187773EEB72
      CFD3CCAA5932F555E06E69B5502127C96A56225E785CBE137B3264960B95618C
      BAAC4F85F90E38CDEDC6660E9CC258118047C1BCB325D85BA832BBCCCC457636
      424037F3D995164487C4C329D23AE66664175852108BA10B592815D5CFF70FAC
      7390B532D1118E3034F0434F942AC33A023C683E16973EA222A47008B071A256
      49F752B3D42F9B070FCE568710F30B2D2F89279C168E8C8B6AC24D622AC6080C
      46E49AEDF964A527259FE7AD97B51F4D87581D734F99E9285386ABCBB9C328C8
      60BDFB68E7F7B41A7FDB799E7677CE98F6C88035CE0ADD8AA3842AC192D583CC
      46C532506E5B76DA8AC549C86098B0968C98BC2FCE1FD6B94D2D2E098FAD9EB9
      B0006964BDC477AF45D925AE0D9A72DAC9395B815D588D7C195AEDB71D438FB1
      1EA528D5B615A8794C140C09141695B028C834AFCA29ABB432407427437F14F8
      9AC85E61C0CDD5B93C912552DFC78092694577FC70FB037448DFFB68CAAD4558
      5BF18A45537FEE67F2367C41FA8B7C5AFC78E12125EFBBE155FC81CC1C3F0130
      E4130756FE345ED7FFE6D1F480C55A719A142F460EAE20435F8EEE86914A0D45
      FA7BD2CABD3880B5A79C30AC21A1C5615F73E91C898400766415FC57995EF255
      3D7060898ADC64702303C6DC2B4809947153995E8950249E0A335906D890E45A
      9FE823AF17A6A22EA5B429F933890547BA1F8F7D55AE218ABD420E41B1B0883E
      0166F9AC5B61F57565A41363A8AEB062B85BD069B12E881029F244F3A2032BAF
      AF2B6FE04AAF622954E53171732B3E9C033E059C732B96253A9F1F59FED1F088
      0DF75AE15A7113C55C87BE1B51B1644E558BB1362C3E8A364B0C802014A0050C
      14BE5389552E6D2E76CF27DFD95C5D271A3B3F71A23DB91806031878930ECA9C
      FE784F658009F561F06F749CEE898E9EEA503260DDD9BEAC4A0B2FC4EC7C69BF
      155B21D985DA3959F12BC6B0443858F956CB2AB5A2761856C2D6D1E5D6D5A62D
      D3B1F2D63F12CF60903EB92080444EFBD934C1B2B6C27CB147910CA2FC2F7A4D
      B56A5AAEB0F8E6C5BEC47B137F0C542D9DC76B97778C4A1A928923CDE2D80300
      F4665C56748A544C864D5857796D674CB19BA65485CC5516131963166949DFCB
      F6C5BFA3EC4B965CA9EE1A19B7F5AD251DAFB0F3159D5311EE9D08DC2313917F
      8709EA0856AD5C239B93981412B8DFFBC03A2A0CFACA3FA728785CEAC4979DEB
      4C350ACE2E19DFA393C8CABB99F5CE4DFD2FB4011551A88CECA0BDF84EEEA6F0
      EBCB84262D2286BD83DC48803DFF589F55DDB1F7378B047A4E49B74ECEDEBF47
      A9098B840F9016F4E5ADFB7327646E1E7985B703EBAF07D621AFFE2FD6B53F4B
      E74B770B771C008EE3CF8FC3B072A0FEFA08875402EF22BA41994B85D5560A1D
      0DB82E6B7ED01455164749F03E69C893F920F244C8729CDAB912EC9053FC65A9
      4D117B4B2D785D99F6E9EA75E9D426A89C4E4AADA51B85A930F5D5E8F2BD7379
      99E431CC735126050FE4B60A8E5F80468D44180CE7DD6D8FADBA18F0AEB05CA6
      03DEDF1321F55180926EF59E4FF203FAACE4806EB8D8264ED585C1B09369107A
      C42316E0AFEAFF536F7AAD573D100E9A525E585996374AB9B8A647617515356A
      853CF0B2350910A2193ACD94F71E88352C76C42E3515D8230364F4BAED2CE5E8
      2E24113395C6CC4139D40876B27F0D241B893F2E4A5925420EDF0120B1A10ECE
      3F3247F14E379BABFCFF89E9E232D8A87D22001E8866DD3A6435E6A286783B8D
      F2E1246DCE17C2A6F94559598B7162FB7C9C90CF7C08DAAF683641A19CCB262A
      1A2EA5843B94123140D5369B465A0154B17F704AA8B9183581E032A61C2EE95A
      D8BE04711184B96142D21C069BA9786FFC99A3B36002C87E5246D8CBCBB36DA7
      6D3283B4224407ECA4087A1986E35153C51FA872EBB644467E96BEC9BCDB08FA
      A95962003280E640EACDA8434BE3F4125E47D63BD1C84436AF20C17477272643
      FE87E3CB2BA0583D75C854E88426178B28681A994C936F10DFB10B925ED207A5
      E003215B12270F31B68222F6B0EA483C4D54F6DD340269546423E0F9A1F38C02
      9FCFB237963C82A54454567F9F0EC8C48F273209DC8B559B27179EF127528E86
      B1B4C34A640B55573C741C92A47A9602840BA117CC3A72C145393895F08DFA93
      08C1915A01AC4D87BE2C3ACC344774A401A8630A3BDF1670CE912863573986DF
      7880F4FE22CFF7A5832D7B296C704CC029BC972AF6A4D35CFF460E088010AD67
      84B09CD24A95B8AB0A06CBA122EBD7296C936CB2A816438AC16ACB51F27C5C88
      D751AD7F64890F1DB3A956FB81D8272A562405CC6294DFFA4343781A340B7CF9
      DA736748D390DD5E00D86B5EC3C53F00503FC1B1B9189FC600DD3547B31C599F
      B10D36EA50A472313EC02155915AA2498D2FE21745935351723AA28AD34A1DF3
      62EB1AF7F516479889C6A61E4E7BDBB9E3C5181B6909A72AD315B200A571C27D
      B3C87E299473D942764B78A54E48490EE41ECFC25798F773D1F25151EE5356E5
      4B80614EB9965A8FF55BAC3D22A658727851F6DEAF2852CBBD61241DA4D41CDC
      2055E06E9E642E7D71E11E344F7C11B49DAC476442103F3EE2CD581BB7A69993
      85EA2DE2EA81BCC2D206B90107CF345DA334290E4623BE23A4042A849FF73083
      37DD283F9430BA44BE2FCCB1BD9C3123B9A0FC5B10035049E350018DBB7330F0
      4D40E23E275008ABC1BEB81A62541C350CA4A63C1C86B0EDB442554166539C26
      0D92FB7B6BB28B44824B09106468CB5CAEA16ED62361565946D9E67D76F981FA
      B233C57D1FF75D32748B528E79CB730E0508FDA239FB9E84FE6DC5D6CF64E6F8
      E20FAC9F3FBFFF3F5FBEABD2FFECFA2F78A4A5D13FAF0BDDFD0DCD1FDDDF8FFC
      BB6D89EFCA21B4C7FA972561B42F4D55EE124821BEE9D052E51AB5B877F6BC69
      E5F0455F30201E300DAF1F7BB21CB246B5F77383BCDE555037EA64892BFA877C
      919A84879D30E7CD6674C28AC6A46D3D073F48781F79AE2CCB26D8E356E039EA
      B1A5BA0F40E029DA4F01A6EB4E80E02DD2E28B852C43C1311C8E5FC8C7168E16
      2E1B8787D61FF77CCF2B5A51E09C160DD1FAA95265F2F14E78992B95F6DCC983
      E71C734F42B7CF26E3F5AA93DDDFBE077AF291694A0E5DD9856065303F4A41EE
      F9CBC0B3AD74E22A986C1761E0B8365AB67074676C5E77C76CFD597E0633D284
      D07F28FB344BBBDDD8F5E838159C33EA1DB922238C1502F1843191643A7C106F
      3ECAEEB87BC492236DF095374F26839FA82ACA71B44C0EDE125C16D5A8CBCB66
      886E27043569388D386A98EDB658E98B3B52C86BCAD32F22A1E6CA561F59321D
      185E5C1C7D10A3891339050B7962C01AF643A7576C3BF6FEFCA39FCC7EB19684
      AD6C8B75AD3CA7BE8840CAE0ABBA62ADD992FD2BEE017200D56C7CDD12DDA108
      75D16A99AB8279715E6BF8602E4E4926C1EEEE70AB28EAD23ECC5BD12E8F3DCD
      DBB373AC91D0BB0E84E5ED809C396B062166343C118C8F92D80E550C2905A571
      0CC622D052993DC42D2153AD5211BAD0C3E9105E443C560633E865920A2D0CB4
      F0A33D11E1180CAC93AB2FEF51881EF9A1572C85B0BFE5748D09DACF98F8FA0B
      07F51972F60DC819796CD64DC676772421CB2B9C017D818FD057A5E2B5138434
      4A39E684EB88245A45EE96451F2F96331381AE2A2E7BA1716414CE4424E3D788
      FB46D25FB26BBA32158970FC8AF0755454887DEE72AFE4358570A6321295DF4D
      51D5736F3F7A91FD4300BCC41E022B594A43C9D5CE8CE4C0FA7AFAE540FA832E
      AE3E5460C9BF4E2946958C6A1336EAD5280C2E9D675A229353850230C2606814
      661B70B4146FD620605F4DE5DDA7CBCBB7EF3F7DBA5251C0F0768C752B04034B
      8991290CFBAF38C0B758FB6E9A4428D40EACCA2586E2E3F68B0D45FF9A1FA948
      054AA24387BF2AC6A76C22B06A593FA61F0F2334C4EF731A920F1273E5C242E7
      B785DE6FEBE2CDD82207B80837C697C8D80E99FD072C37C165EDE7117B188C8D
      B0E4883E8E5167194182E0D4BD8D865314B3B16E0415D455C27A1A4FB1716190
      441884127AD4BC89DB0F286F99E87F85B70F45D325E17588306D1EBEA553F6A9
      BFC120A0C477BD991EF5583B728E6CD1234A8595E925F7AE30C6EE4E3A3360B0
      83BC820982071D68B28DB426B58CF5C869CDBB269338642A30B730C7AF8B3C45
      B6B78E933E7B63533F4F0D96CE402FB809BCA9444AAA2AA61566E1340D2CE046
      A121E20CF466994CD72866A9002A17ADD3945D40FBA64F92D152C5FB00E4BC69
      9FC28982011121AE3C4C050BF2B843DC8EB11BA1371258C308A4BC3D0CAB0FFA
      4126C8DF4C549791AE53ED67AD401A1C5C4174E5D9DDF224E8DD9DD3C41DBE89
      DE9C62AA2C6CFBED282EF832B63131FA62492EB40CA09D0F4F2E351714008961
      6D7A4DC211FB43F774A99A7D964088F665DD6D696B20535A4491C3DB8EAD1FB0
      BB1E2A2349063C8F848ECAFF9E8E27406B2B4B73D85F09CA3EAFD2B4E8738EA9
      C545710856FF6CA1365E56194020B020ADE8BDCCB741767B30DE45AAA4E6DE00
      CF4A41B8D302C95E09563E0F73CEE1705E9D5D36DE5E5E9E710988DD9D4FF503
      4C7E704923F2BDA16CAD855F31A5FD3A55167D2D5103A46BE0FCB2F913486058
      78555A5B495857630A5955AFE2AA3C0891D88A03AC30216B27E5AFC6A2CE949B
      E0F977799835974EC1265B524039B2F6BEC89C8505119A652B94B131C36A3038
      DAB78ED9DA72F20F6BB4BBE3EEEEF09F23B71750B6433A9A0E0621C9812003CA
      9C30BD97EE5C61D6B9098BD5DC8A46CD003D4C9E454197A33BF5A8E9C2E3A90C
      1AE7AC5C90E207A02250B64410616A274718479AFCFFF1F8C70F2CFBD309CF55
      7A0F544A4CBA1E624003859B8258A7A5BF709E3868160300409FCCDD22E115C5
      5B150DBE883288307D2A0A1CA49C45829978415F80436C7B2A5933E6147A8A64
      C19DB095FD18A009426AC69D70A580ABDDC10B9493F8B2986B92FBB9C429E638
      5A0A7C8713CC7148856424C26A897079B8FBF21C27764D50650898FA55119769
      A104F8BD1EC80079747D367F1FE80A94DC0A9FDA79D2C0C4276E1F5FF92FA4D6
      2AE740656B8BFBB460F3030BE9075714A745892229DB4ED73F4B47E8689A5189
      1961D9A2ED49A693ED7112FF245BC40B33301E04A1A3AABA0E8138A3A2170D3E
      81353CF3B45602E6817611D34D783CAEE89977A8D1EABD61F16A5A3426624464
      BB979AA5DA07E192E371550B1BF1BE424496E8D14BA88E777DFA079A7EB2F9A4
      C7743E4B3FE2F68470D7846A1A7953AAE2226BA046B9D35CE0CAC13D73422869
      38B44425474D2388A626367F47958BCF620C3FDF92F346D9F8C595E731E788FA
      70E83C3C6F85E6F53F00DB3E4B6520A3B8482DA32E4EE1C721A6A55E8D54C83B
      D61B42A1631FF03ECB72E678A1256B2520CCAA04B5FFC7DE9B36C76D64E9C2DF
      19C1FF80A9B971454E97A8DA17F5ED99A0484AE6B5B62165BBE7B51C37124082
      44B3AA500D5489A267FABFBFCF593201144949DDA62DB8494737455661C9E5E4
      D9CF7366862B2A196E7287351213E59071414147B7D29BFAFE122B277B522FBB
      9509965CC6C01EAE7B44BAFB41AB327DF65EFB36B39A51272C53C1796BF811AC
      84398902AABC645093CBACACD4048F543F898B3D54D52E28CAD0E039A39CC221
      F4FCED2D7244E70210DD7A6509348E339734D6B147000F540E2555119BEFAAC6
      712A9ECC7286DAF4B37464DEF00E073F2318D5B9F71155E9C4A33148128A0E62
      A31BBCC386A4E249958F3D0CECC68B7DA1B6EB225A1BB6564B43DEA433934BE9
      A4F697A8729D3DEDF35605A8204F6DE58D7E89A4B4DEADFB27CF42C9CC4C7151
      28ACC0C2C2AAD99C0B9B77953D90C49EB9CFA61163CCA1D4545EB6C9CD7897B8
      82C78847CFD57DD6DEEA7781334085D7B52B9B5B695FC401248C680FDBC1FAB8
      EF0BBDF3A7E08899E429D823351CF94E3BE19945E52A26785842831736BAA0B4
      D6959057ECDA61BA998043D7DCEE187DAA0A57656A3E83A23A5A5E3CF1A66384
      7E6FB7B7FCEE723D2A1B431EC0DD35989EDD42583C6BAA5E4EB58A832A41DC95
      AEB79F0E52B76CC1251C6792062FD1C9B8F67257BD9CFA68E4CEC6347297C700
      21A7B628899C924B9CCBE92D25A20C44E2007119CFA09585915EA7125E582EAE
      2AAE9D4C16A37F0FBF3ABFCE47AE1F4B3113E969F3B9A08CF113AFB18542215B
      6825D51817647C0D95B9D35D665BBEF476DCA60A5115E095F561094F85629F92
      E96F16B69C081E9312903F8CE39554033223D818B8C06CD57A8CD779B7DC4AF1
      2F5148BC0EAEA9A61E1694603FC0C13D9B864AB3CF2B825F9E4924D54837BED5
      5B7AFBFEB33DB9E60C64EAF256E92A7AC2250D9AC131CE280C4A612F4A67A9DE
      2D55D08423541F88F2B4FA4CABFB4E87868F47E5484807D07D1514E0DE9C572B
      7BC9CD17706C9FEA2587F45C19445B27579FD635278335454A11B08AAFE18C58
      589EADCFCE6B148BE35A79BC470F76A5E99FA0F01A6291B207B7AA1BB3742162
      CB0DD51E87578F7D7E393314416495CEADFB6DC781AF7DEE587DF9B95B06F02E
      D9DF1FC811C6CD2734BF92A867F32C7A42A92D2C732DAD79D47677B9B027EE66
      C1ACA2BA54E4BFB969173E2DE3180C8BCA37AB7854EB9CAD49EA7DE0C0F273CD
      A4568E44DFEC68CF0BD0262F9F12CBE689DF0D1C0274097AC585EE4B77547DF0
      961E5B6376945550C2E2E2D6643DA375A6B6337C74F31204901970ED51EA8664
      DE0256E7DAC7D6A6A5064819F52D8B6257AE06DDE90C3485472BA970CFCE2CC7
      C1A8A689F7D3C9818DA7D3AA6D6F95AB5688EFB8BA18CA50C57FCCD075FAF032
      2BA9BE42C1CE2B73554B4E97E5565547B99772B82A30BF4FF8ABB283C25666AF
      B23CF035BBAABBA8AF3BDEBBEF69734E91022152BA82877A5259A1008BAA3EDD
      136B8AD7C42111FA1531C5C66A54D057C80602F582BB59117344D7BA5AEE6966
      F376AF7A30FC95A52347A934B6A043E9F37FDACA6E7C5562B14E25A0E20A720B
      F1ACD594D7A08282498FF347BED458BDD6CD493AF7FA183CDBDE627F24C77208
      5A3AF8C6CE96EDE0B5FDB82E20CDB0BD2FD2D537EBB04DA97D24A8DBC47D2198
      724B6E487366EF47E8717BEB992ED46DB8B41B8E63AFBD52EED565BA88B34BB7
      C62E0BF5BFDF13C82461E9F0D2BD67544F5DBF6073F41BE3FEC21ABF59865B0C
      AE8E43FEA5F39E8E146E0FDE3F0AC7EF719CFE76C3BE25E9E3FE881677DCFB3B
      3610B3FA4BC433027DAE3ED2BD5FB0A5B3A23BBA715FE9FEDF626789E083C730
      3818FFFC9CFE22FE52AB286BC64EF94389E192CBB6FC9BCE61396AE8B3BC9E6A
      DB13020F6BAE67EADCB095B6671ECE2E5F2FD853668A664D5AD80F66CC0A386B
      71A47225A9AAEC338AC2AE2003C053B325E3E5576C04B71E651C531240257BB2
      6153550EABBB2B7BE43E2B6CFE8194D4136B668F59B78C187C999D05AC25CAF5
      82384C2688AE0801E90447542D420960292F044166366BEA4EA03C0E8E66730E
      50E5FBDF3D2A44D06C6FA9A8A91CCCE0BF08854E751441BD845EBB5E31985E51
      68478E32FB385B9C659CD0B92620BA1AB93832B9DF9AC0F696B80D05FEF82B2D
      45EF4E96A237BE65297AE32F5A0A6139BEB9F23FBB6253014CACE7F53B102907
      897DA3DF7CE197ABE232169BD8E72C95E66FEB9021A1CAE7297B17F78E03F2A9
      62613BEF1C9F71D73ABCBDD96FCEB91737DBCDE9E335E8EE1A287FAD93DE0CF2
      F66AC303857F21855756EC1F22F25251FBB5E8BC7CC32DA47E9C944A1FC585C8
      F50E419B95F3DCE15E1583BDCEDEC736FEE9D13F7B7B7BBBE257973B5D919DF3
      D449F090D5911D7117B2AF53DCA2DA50725D112B9ABDA2A792F3525205A9761D
      02043F6E63713DF6A822DEDFFBD0BFD397723B4F9908AA54724F4EF5FEB596A3
      BE43C139063463639C88C62D961C8DCA89E0F223392FDC023AE52EA94ADBFC50
      0D7EF9A3FDE3C79F84AA4B88E155791E19D956990837E5A8B5BBA0B2357653E5
      743E734247CC728F5DB7D149428F433992B49236B09C51DA259F0B37377A9ECB
      BDC483395652E55CF44C70BBB95988B9B7F97C37D2B733CED275A9D24EC32E3B
      CE5734E7BDE0B968D372C48B4A58FA83761DA2B693E4DBF343B34BBBF0E9B47C
      A4380F4DF5781F358595CA090014AE5C83475CDDF7037F20953B980728916CF8
      FBE276A3A3737DF2C18EC818A6E10FA9D9C0D8BEA1C064B7E2B8A3B0DB39265C
      465A094655DE5238347230D674BE9EEB5B41A4E766A649229AA4AD5FD5900E54
      40F9E73A49EE7BA36831C2830FB0EE031C7F551FE0F6D6A9DBD3C74C0B91D282
      C3444FC59FF0253B5FA75665EBDE21E79B9671FC5BDAFCB0823517147F8ECC96
      513C098E378A56B6B79EA7DCD948FD54AB7435F395853B554CA3DD12B9B9BE70
      6D0DFCCF353B4F6AA92944FCD7B55306410921C3009879A615CDBA290E279F5F
      58A43FDB1BE00BDC726B458EFADF390386EE68D68AD27ABE23E6250BEA190E35
      52B39E146F9F24279748C335E681A553D7375AC3424560848BDADAF18B8423F9
      A495DA1B046685B3CA2AB9E1CD59B4D339A5B63CA66C8990CA71D4E9EBD793EB
      7D8458F7EA4BFB0F2C2CCCC8CF2CEDB1CB115C51A70AF7AA0AE572C33EAB5839
      6093962DBACA90CADA605632376F5DBAAE78B79F38DACC659EB1CE9609D84371
      9EAF1717419105BE2F9F7B28CDAE8258F9A921EDA92CFE65B4735FD5B76F6889
      175959B8C68802F3E50A3220BBBC4FBA5CEB334BB16910D905BB059E78FF40AD
      09D6B5BE2A359DAF5E54C379DA0F7A575DEF9A7C65BD0B3C732E7D6409236551
      0245B856B2D877EE9E46D845948D0E12719526BE5B302923D030566B4E0C7D66
      17E9D9A2FC36A37C72F2E811B33A4FE3D82E9A25CA8E13D1063DB0D3AD6BE0B2
      28A52BD3399D24B728BBEDCA21E2A9CABD326157F4D5B889BB94E153DFE1B2C4
      E8FFC2FD7E050A4FA9649A1C8755C672F3C6DF734924660ABB982C684AA437A3
      863260694D6AFBBCDEFB8BF12A8D275424B50EEB4BF6BD5FB29BC05F4B344357
      2F1F5EB103715ED8A8B5D9AC2238D42E65726C879D5AFAACC25B89E6C8AF95FE
      D6ECB2CC05BC8972EC0870F286FD933296EB43149F3F86759ECD7CC10D74DC02
      4767BD1427E5E5825ADDEE4A23354CDF776E14BFBECA5D19934BE0F576318CB7
      B584D82948E013ECED4A538A890E3BCE1929B32B7BCC71164356A9B1AFB73D73
      3DAA9DFE496FA73C175FE521EBC0A50EBC0CF75D092D9BC9ECCF48421AFAC9CE
      295C09BA76705EF7A376D09D6C58D97CB63FB326B79D5741C1C8D7F60665B31D
      AC1785E6D0D2D30A3D701064D224AED8F5113D7E71D521893F393D259526E3DA
      1DEC5FDCF712C6FB68082CA4ED415539C57CA9807FEE1CB0F8ECF9960305A462
      46810E2D4B4F4B58CCDB37BCDCD4D5C76977849FDD49BF877F7AE3C104FFF447
      A301FE190C271DFC331C4CE992D1A04B978CFB3DBA64D21B0CE46EBA049433E6
      C774A653BAA8DB9D76E8AA6E0FD7D1BFFDF180AF1B8C86A35F959218D2E817C1
      25ED07C133FA9F2E237E3F08827D57C4732F4ED3F69628699E6CDD09A8F6E224
      BA7BA0BA3BA3BA92DCE87FFA97FCE7892FB837F447483FC265D97B96E65233BB
      E3803D4AA759F0A7A0EE346302E5B0CFDD02CBEE08F3DFBD6B54E06C13C1F897
      13D38ECA9F3B1FAB24C9AB1F5E642A45EA452A32C0514DEEDD57DDEC7989CACC
      AAF4BBFB6566BD599456C4CA846D014ABEEE13CF6DD9262D345A57A720AD593D
      F47A4C20BB3774A7871DF35A8BE99FD06A535D66354F432F2B837417D4965ADB
      7190035D4B5835018A2E56E343AA476BD9E6C288C8C341C69B91EA79D7DB9983
      605956ED5B23F323579837D3F9F56C97C1C28BF1A0764053A22ED852B82A4FA7
      46DEFA31995B325E6E6D5A8103ADC0AEBCCBD42CC5D0A37551A6B8C0D893DE2E
      EBE2C15BBAE12D9D7E556F29757D794D3CF33F98DC1C212BC112EA75A3B66B7F
      35FBC3F76EA47CCC1A3BD4A385B6F32010BBA77E651FFFBBE312F8CD4F02BF7F
      7F03206C33667220CE9BC3EC72F1547C446E32B7EC03CDFAA6E9DC57417CECE0
      182362E1C21B19FE4AB14A6A6BF50526CC3F857816549E572492BF5B3E21E20A
      7628EAB61B3C51A849213BFFA51322BB227954C270E439D754C06265AE4AA923
      A829EA6DF14E107E2DB504F76FBB5B05FD7851D8FCCEBB49DE3EFBD0723B47D2
      7CB7B7448310FDD84DFCE6D4F24A6EB9F3443FE7872EEC25E72B541E5138226D
      053BF1868B6A57B220E6DAEE405DB76F6AF1D674C110A671D52B7CB78B4E9D7C
      FEF6DFD8E23B5D74F17F4B709828E62B92CADFD35FA94EEA3161E6DF4E330A8A
      898B96D70FCB7D65D89A6E5750DA31B99C286418CC4C6867C5357E7D4FD8F5BB
      F3DA2AEC94A51ACEE39156EDAD5AB74219771DF6D8E5FC08FA8B4F813A170347
      88F513682F39118C9116275125556BD363B8A8303179D7EA6AA9F85FA4C148F2
      78E1D37B5D9BC32223F5868B601FCE849C09B1ECA83F5DB6CE23299C25AC576D
      60A270690E7A49E1655B3F1EC2D6FC29E0369FD85B17307842811202CDB847B8
      921CC5A9F47931D75667A7B63CB294BB7E9908E8212F917C3681E728A2E38B22
      6A9D9F0D23494865C4F61637F1D1A891090E8E5EBE74F97A26F8E1E4E5217BD0
      8293A3E727E5E774D5AE6B2E620908D2E45735D705F741D26E40E471B84618CC
      2C7C49486E291E5BD410E67CB579EC126C45A5706DAD45B7286E7A78A5119150
      A7C76A2773857C3B14BDAAD4ECB9F0AF4BC6A6EA1EAAF9F72F73B9980E8A83BA
      4C49DFF560C733B2945C24DA126D977B716DBCFEBE328B0A80A82CCF3D39E2EF
      325F77D49A6FAE4189190A01B5BA0A7688830A18984F80109057573F49672BCF
      18D4ECE0DB5DC62923C650A290D520FF454ED9F8B7B4209B487CADE3C55FC005
      B9074051DD807B236B6E5F81ED2D12243BBE1AD8696D9B79AF8AAF452E5F77C9
      0DC93E1AE652A72F5D24C0DD2E47FDB59762BE2F083F76957906CCE6E15F244F
      CF5DBAF327CF86DD472E19C138A0CDB2F9977FAA20FE31821E7454AEF08822EE
      AAC13530323482DBCB6D927E2C6141973EAD3DDDF4EFAF20E50437D9325A8A18
      B7218D17B3642598C42E77E9936E28A2501A46CBCB57CE1E9677EF3AAD488A18
      9D34AFA9B99C9C44CF94BE2818D4955D950DBCCAD554C134D776C094A8C8B868
      A57816F51C5F7BD8C41FA481E153094A380063DEC3D76FDE050AD9681657F586
      F61AA4982B145519AAD0DD96BFD2BCEC0E76EF1B6F38CD2EDAD07B831D81D7C1
      9FDAB470F7BEA9C1ADEB4BD02ADBFFD4B2F51CC035E3ED05B7AEA957901D493B
      EA7B5DC1F336AB0D8AA743E6066125F349E1A3AB394E1E7CB346EBAA0F6ED47D
      DF38B30F86FAD5F0E124D5D695E15C7F5DEDC90A8B8D1D3A637C58ED396EAA9D
      AC39DF36E205482ACC41810A89B3BA91AC5C9596DEC998AE67A9838A8ECEB354
      DA1DB5FECB16AE479076D97D9DF90F36A6AB766099597E1D21DBCDF6C6F157AB
      EB3F331155F3772A4B5B5F2C4EE6D6DBAE0F63D715E07F7ACDCBF729E476DD93
      26728A119F36E56A9BFBBFD44C3BA2D52F38FEDB5B15038F832B1CD1F5F69AB6
      5CADA0D4B7159FD8F56ECE04D63A5D156577E6A2322DDD83F206820C2CE91E6F
      DB5815C1FA3A2F3B00CB730A27D5DD55D7D7D9AD9B14637EAF5AEC816AB16236
      D575E02C81403EF896C624FAB2D1C6EED5D5F5753BF3F5AC8A657D6F850B5738
      A87E476D52E8801E9DBEBC2F1244BA063B66BE622CD74D7593CF99D7D4FE3DF8
      5FCF9F3F17947570C3F9520218A5E23A972AE9048A6D79D7FFF913DFB6E73B30
      24D09AEBA0C9AB8C88140AD3E2BAAA5B47CB7FD0BD7EB3E37162B519A03F1FE0
      ABF748C3F2E51DE46223F042C7DF3DD915B887019061EF78CF41C583FE49135A
      F482DB78D0D7A3772AE1EA579C23D232F29C13BB288F82E51737D7F1B6267794
      34043853B8C6E515292EAA88D0D243C1F1D60BBB80C53AE33E92F4D6B9656583
      36FECDEBFD573EA5E17772CA7E51E8F6F1F3F4E35BD26F70281691BDF386C64F
      EE36D2FCF875F6A901FFE2E11247B821FEFE4B9798328A88B4EE78B477BCB8DB
      5BBCBCBFD260AB47CD751D3E939348791A15479E6FC1C8D156629473E9DEA528
      ACDC91647E74FA2A4D1EB0AFB2D9CC2CC5CFF79AF35A7D5CDF84BF1306F64BD5
      043FEF6A9AB4F66664B8AA1F1FFF141457F3309B69A8AF8E2717C91A8AFEECFB
      0BE9C292619A43B42F417562116B21BAB8948B7AEF6A09B26F6F71463329E9CB
      E58C9A4973B2B49480E2FD652D3FABE47373A59E0C8ACC65F959468E8E7AF12C
      BD9952A33D0A9CCA7D7A4994B1940F4D74C190DFF95EB0233E584D0A70BDB745
      3D0AD806260B818B0C16D9CA7593A82411D88F86E3AFF285BBD3616472D142BA
      2AEBFE60224851AB3C707BCBB750E160B14B967271204948625041DF67F631F7
      99C5FC16ABD25F16DBB6CBB2902D727B212DE236579F7322CA56D29B0DA88F74
      1AD59D217309EAD5914BAEE04BA91DAE7F0A799C4893B36651F8922DCA3C525F
      7A7C6DA75CDF9938DDDEAAA3556DB4A6AEBAE8A5E9A19B849B70A56F9BD02075
      4C4F3FA431F51A771921DC77A27EBF5C5CBDDD2F61E501DB5BEE117BB251259D
      E3895179048C3C75A792F8A67BA948A60A642545CF8603D3D786E9D7969F2580
      5396936C3917BFFE0C3713BF605C5C9ABACC7F4F3B9AF002F2696B627FB5D953
      B98CFE104BFA5E9CADC39204B7B7FC83F08494282AE7AEC62EBDA72331922ABA
      10C7C9253A53DC08D5A0C10F4ABB52680A33CB418D5702FD551D4170BD106B21
      611BF19B6A812B0DDC67F728C7C37262A8F71EF4F53505FDC4E1118875F59C58
      CC3758EFFB13B427D77D7D215A9EE739EBB35C15572D5422A8A4D4E2E663AD58
      9BD2E0058E80CB555572EAB1FD0FE69E35682BFA4612E7ABD928B58DA12F5E49
      23A93F04DD7B4EB7B5FD58545033CAB075A13CE51E51B157E27C7934BB3F3609
      F8D2499E32CC5089F617B272DB5BAB5241B821F6AF79E5BE935655260B4A460D
      2A447C3BD22C32BB706DED6AA3D210BF0B3C644E725B139D570648CFE7ADBDF6
      04FAFABE33745F6B92404F65D556730E58E4FA9C83FB020F7778E3E409103E15
      752CB7AC6846AC22E7446A6A4D9313D008EA859436E16A45AF67E73E25599C51
      FFB7B3F2B4A9DDD42A56F4C98FFE853FB1DBD4DDE2CB971759403A3F7793D5EF
      BC6580E79E690D68B7038287DAA88139498FA6C1397D0F3B7E965373EECAA8DD
      C95598D2C84845867FBE434F256FDE669E35C3A6496F1B8D90B87EC9A4A16EAE
      259961951EAB992BF65059468191E20AF6C49C32597EB7C7F3460F5158FA88BE
      E4743EA66151AED0DFB6B77E2D0EC0F0E6CC66A9F598F71DDD8BE34E22F056D7
      1E56E01FF242FA3DBB6BD6546E4E998FE2C5B52A7AA71EEFCB656E6067D9BDC7
      2967741C5DB7700162A5B0A4D84EB5DC3789A9177BAB8F2B769DB09D575CA4D2
      7196DEF682B3C2CBF7B1AD5F5351E98D1267851D95C6FEA67B1F6F7C815D7C99
      2E2E8227C1F33703CA31A7BFEEC5892330BBCA9C5DEE0649ADE783D323672AA5
      8B68B68E4B4173AC0E0D97EA51D4DAA8E28192E3A24FAE7689D1CC96B21DB27E
      407D08DB1B195B6556A6A6C0A4D79C477C56C873E2F7F0D350B0ADB76675DE62
      9808D5602B9DAA5D790109DCB2E77C64FD5BE236497D53D1399CB25D51B5A94D
      462689B932A95B3B0D55D26EBDE24FCA317888CCC138F7594DC0FB586CAD57A3
      A085FA6802EF20ED03E5954A3036B4657752A98CA2F19589BDDCB7C3C762EFB8
      5492D930BD0FA47DF1AB4558AE01B291BB712E0ECF2F9A0F95697E65C152B603
      A853CB7552C7C69D784AE41E9E4AD3DC4E4568FA192C084A41C3272FE988E6F7
      9BD9BFB08BED2D0ABDB93842D5692E9697B86C691392F4E3BD69A9B21FCC2849
      30D0C41BCA47BC71392A96C2DCC4BEBCEADA6AFA2CD44ACFF0B36AB2C7F142F2
      AE22A3FD200AEB9388358F933A395D56F360D60BDF083C0E8EDFBD2AB47F7D09
      2050F99E4AC9D6D139C9AF92A971E0358D2013E85D69312F3946A500478323E4
      7E515452AC876E5ECD097DD3C4DB1E559F2B195CB38F6BDEC24B9746AC8ECACD
      208172B01B6A6731522C28E52433BC69591EABE5137EA81A9208AFC8175438EF
      65A7AC5180D149D77189A128851FAAD0479F5C2F2F4B64A55A5889754E5D9E5A
      372C8ACE83419AE8F222F8FED5FE61F036273B74C591C24466DE3A5DE5EB68D5
      2273BEB5CFD860F8CA7DC8514BC9299A5BA2D4AADECC9DB63EF91C28EDFA719B
      B06C69F07998AE72AAB610CA17A0242BE956CCB8289C5856601CAF9C4E545343
      088E8266B41B9C4679BAD41353995ED595F6DD71B0134202132601079908D336
      37678F168FA88EDFC73436F36F8F1749E69DD758E258FD0BB4C722CA39B1F89C
      C1BEBF50E07DB1B8BBC27F8FE7F3C798E97785CD9F061F319ED87E7C1A5CFD2A
      5076779B8BF23A5BDC75CA4CB093CAF1EADCFB20D477AC73939A9BE5C7878CAB
      363367C2A10DA71F52EF654A19BF27D214C2EDDDD1E9F0C9294C2835849E3C7F
      331E054787C7EFDC11AEA4DF93102CD12ADAAE1EC2A3D62FF334CB25DD3E8896
      6FB418A1B40A7C985ED23C5C2D8EC8667E388982059B1C391449E7B208ED86C4
      347AF35EF08C8AF55675634D7212FC3E8BD783DBC887657B40110AEA49E54058
      5E4E448215DCD8A1E56B2A5CE0C05DE55350F74BDB103AED1939C456B935E0AE
      6E0CE4CFB8241065B788D89A7219792EDE1C74CBB0B908EC17E5B4D2F26DD213
      47ACA7CD5590BB18775C4CBB45C63E55420BA3D1D5D254D8198B8370DF590487
      79245B26D22222D8324F783D299F19E4724F780361D28AB42E1536F1014A8CEC
      96454AAF0BF4F4B6D1A45F3E1E10FFDD3B46CB0433515C2AE5B53BC417258C48
      195BBB55EF48798E6AE5BA65F6FBE769E8BE1F33D528C1E61817648716FAE40D
      E9A5D80E020711C75CE9C0DA219C9076B07FF0CD8904C7DAC1CBFDD7B8ECED8B
      13BDF8F5FEF7AFE8767E22F5D5743A6CC6386C3BBB158F14370A21FD77F79E9C
      E6E3852E47DBA1ABDC601AD4F7825609A760E0F7A4E2B3D44A59BA89DC96A521
      A6E1837AAF6F7216725B0DAE5D94D4706E71431552195B357F083EB683AB2A94
      6DAD9263E551A00A6B720AD3933D51A96D95A15319642A195FB5A25D11ACE283
      94E349515157C0BECBE4C38E490996D69FAA9671C2CE29717849FB8585657D82
      6469C5E5EC5797631F9B4B7C23D1BA7A2E47BC7523CC43CC60CA74BB986C7842
      B0C3190BD4BE5DD0AD389E3ABB724A4DBD2313565EE075DAA59A70CB62D67257
      376BA02B0BC75DD02BEE0823DE147A4B51CB52326A407EEA404B615C49115CAD
      93EAE3DA5C76AA1DD7695153E7595667016F3046915BEFA0A0FB6E74484B4528
      B92E68874A5FB42494B0555CDD01BF2C776BA8324BBA6B5B6F6EA1A2DEFBBAD5
      EF5C9323F5C1F8A30CD2282950B2821D2DDF133920C7F193E770216D3E33D725
      898BF72A2BA9B85EFE108A2516B71D6FDFDE622E4B96B5FF8A1F5C6DA741B676
      2E60280E1AAB2CA8530075823D5F7066B0F05831583846C4675B4E351F62F1F9
      567958B83E53C5B5665DF951B38555729B7241E2545250E60EC4BDFCCAF11971
      E356EE16E9C3BC17EF74F0A80EDE816C3E5908ED64EF242031584E9DBAD4E822
      E3F66A4FA876991AEE4453397FBED0A52BF39CE906924AF40D61B8E78218A3D2
      6983D8EFBD2768DFB9B9CB8668E44FBDA1CD189420CAD67279ED05BB65D71499
      51F7C53D611CEF6ECECE2C4FF40EEB4EE4EB87C6334B0B42C3A84713949F6015
      71A438B1925C3DD757543401B535ABDDA188334939C242208BAA151094C0E9AB
      23F8A8736F815AB2E67105CE90A2D28AF6610A51E872AFE6085646390A526B14
      D6134F961C96D22C2E9FA868B7B588B72B6B28FB0971F60D9E40E52F86AED90B
      769E4955305D626AD88795FAA7728EA2E10827D67AE23A9EC925759B5DFA2A1F
      816696387E3D48832D4B23ABFACF99E578BB4F6F30371E134E2554DDB8140B55
      A1C2A3A379CCC5A14ABA21F174AD62B9CE886B990A8E596E548CB56FCB10AE4A
      155D5097E0C49909EED1D0DF298B9BC4196DB7306D2975A24615955C0677C766
      CE847BF9F656159CECBE33D3D609A3B1B4DC2A9D4B96F44D792DF7ACF2912B3E
      DCEA54BD0F5FB84CAE30E99C01ECECC2E1DEB8472CA965666823433A54BA6234
      61723315FE424ECD3DA73C1F6587C233368B786B95550E0E56DDFF50ADC4162C
      2D250E61DE77B27FF9E6F005B644D5B57B42D1DF9B9CF17465D637A559E8B250
      9E0F57662E2E2851C216D9E25FEE39C19C9E73342D1341BACC52350128463E27
      573247D1A18064F97DD12A5F493942518A70EF34541647DEC4848B5DF37CBDE4
      5EB9F515D43C971DAFF4901BEAB5795D531F7CAE1A71DB74B1664A8D09625C62
      67D54A8BCA8B1985BA14F09F18ADCF92A1DD0BB288724C5C454C7D7F2934AA7F
      9650A4F5365A942572B1A0C7DE402DD769C58D38C31EA6846FF38CD4B8223612
      23E48A2881E54B0C070F25F60791A1F7D3FB641A4E8952D900455E74D8F46CC1
      75DCC6C3D7F8DC1C0AE84AA414DAFC8A3B7651B9165D13E6D985A87B0B556CF7
      82FFCAD622722ED8471A926ECFB1C9CB87FEE63F6439D74C738DE82BCE1B0A9E
      9418E6FA099D8693EF16B4FF02AEBE3F4B397B21F8CFEF4EDFDD8F80C6F3EB09
      652EE97A7B4B3DEEB44E71EAEAFB39D98A487A1D56FDED7C52DD3ABE3C7D17FC
      A992AB2A0BFBA1A0AF0E4EF115814E68DD42F5BB97F4DDCB4C837DFCCDEE2D61
      9602B615143A8740C07A971FA37601ACC459AA9420995A755A707754D195B7B7
      36B449259687FE1262ADEC2F97E06892FFC6F5720E26B492487A2F0E11175554
      BAA96DA44C966D2C252AE2903D33E9849285D94775C1565BB2B1689CA573FC4A
      E198B44C41D5A7B87BF9F42D6E6F4C19B0550499A2C7DBE1B111145B2DB854F3
      EF7A8B5DDED6766E5317FCD3415C034669DF821D6B8A0B8FCFB291F64BB2DF7C
      F01D27829D53272DE3B4884037D4884D6F299383776B6397F3EF506AA3595668
      F1C6AF3CE6EA68B7B704A5355B6DE431E87BAB63D715C7389DCF8DABC9B892BA
      ED5244046946EFE69A1A17C2A590296DF7A3026FB1D1BA1237E507CB83287429
      37FB3254F2D1D4DCDDD43F947DE76B05BF75116736435447D944F1A5C7DC77F6
      277C8FB5B4DF1FBFFB85F069986F64A1945B0ABE0A64D971F22A2D8898778CA5
      DCAFA7C1F16548BFFC11C7482EA1BF88E93C255735AEC437A759BE922F8BA7C1
      B32C9B910EFCA7E01DF5A9FBE35DC774498550EC59D75B173A7EA86F5DFA9A22
      6999B7BD556D9AC7BFACF30537E22BBDB90EAF060A82877266E8690DD4DF6DA4
      FB86652F6E586EBFA0EF4E799D8B2F5CCABFA7651D8D40426D0EA8D3CD9F6A0B
      74041C7FE0E1ED51C4C02D160376898B8C038DD21B288804473BA8D044AD7B91
      6738BFD29A3EB3107E82BCB763144D8697557FBF7B821410C6BBAD522BE773B4
      887FCBD96C6F6DC2CD91BC23B1ABE1120A90B844BE42DBD2AE43EE56CDB519E7
      D2E6BBD2FEF27C7D662904B1B4E28FE0182C5DFE44A423A7287119532E5DE5AB
      A863D5C1CCD20B929769F1059D764A1EBCFA38ED8EF0B33BE9F7F04F6F3C98E0
      9FFE6834C03F83E1A4837F8683295D321A74E99271BF47974C7A8381DC4D9780
      D18FF9319DE9942EEA76A71DBAAADBC375F46F7F3CE0EB06A3E1E85765FC0C73
      FA8B4ECB07E38009824AB10BD3D5816B2BF647BD22A4F3E4AF7EF2042682FFAB
      7AD6CAE7ECFED15FB0F2892401DF2C1972D852BDFACA2BC520B4F209FE9E24E5
      9C88CA33CAE370E30BED22767F547EFDA796E325AB80E860B0E62372631D9CDB
      E80246F8C51FAFA35EFC661CEF4E26F1DD62C6D3B873E1B7C1E860A670344711
      AF237A37B126F18670E07923F9CF07CFCBD8B736E750FBADE0DAC7229B7DE027
      932B9422CA9729973C48E99E03F276917D02BB2F6BE19795E4943BCFB7FB21CB
      67F1E9D244B61D3CA2F8EF8F6F7F7AD416BDED57A90EBB5B2179F314BAEDE1AF
      36890D8A216E6638A13AB7AC565632AE760969E496ECDE4B1A744183D604574A
      ADF8C17FF8EB6CB86A0C94B7CF9DE37F0F6A908EF9B5A1C2A05F65D49299CCB5
      48D8950B01609899B382E03909E8933BD088F38073F86AB92C946D2B10B2F7DB
      8E7EB63ED3AAFBDF89C4BDFBBAFBDC6AB97CB83EABC681395FC0211C13E24ACA
      20E114B6A2DE3D244FB8A0FEA6DB9CE3C6A5E3B003DB3D83F289149EC5E735FD
      F77BFA8A3C85BCFEEF97330821DD846073093626FF6527F23D64F139EEEEBF8F
      43FEA5F39E5232707BF0FE51387EBF32E1DF6ED8FC247DDC1FD10E8D7B7F0715
      60567F8978462055E8E5B8F70BE86246D3B88938E8FEDF823CFE75381E048FC9
      CF175D707A1F157E67B6583C5A0993D16ED9AB3F94D95B8DDA404C6084099C94
      7DBD38284AE3D71CC112BA8123BD54067FA66931DAD3BE69131A63428766656E
      9CCEEF6512534C422AEF1C3D71E2384CF4957AE360F644193BAD089E95C01A96
      259A0138C677EF9E3F9E0464D1078FA3E5D3F52AC19F0EB6A261D39DF4315D9A
      AD779F6B88DDE417127C97C474F5B0F326FA5C58F6EB376D42C416B8679B7623
      5D9CA90B8593FEA11FCEB86144B4A234849D8205CA6E258D8D92D80AEE47ECEC
      E65872437C8A42B769531E5E23D9DC0A06886610CFB3051585BB54DF19E5F069
      DEB0240746A05E8A8515E96A5D03516DCC1C89595ED8AB3023B1578605D305F3
      11DE221A695193024D9B0431487F96C26C4620258B72D792359D2A6AF9A0B994
      4D1BFF84CE965B6E86C69122CB34F22D8133CC8F3A0D971CB1C91B32AD4E88C6
      84A19F6779FA33F916660AF64C90781139240AE77D0DB3D52A9BCFB34222CE57
      0D9BD6B4836991EE43296138F6738DB939F4A342DA920ABF671FB3F617801146
      EE116C6348A5A74D9B16B1F61625BD50A32E45586CD540FF24FDAB51E3DEF156
      0B87CB0BC9747EEC633C2E1A447E0F291770CC384AF3683DA7F28288D3AB1D20
      95E6256A669FFAB61A35E7EDADDB662DD1BE27CCDFE8979B5661665DDF920F69
      4E9DC28356E9B869954958CEBBB7E313037565B4C13861209866996D3B52D24D
      DD46C8B3403C9256E5A5599CAD2911B422D8B45BC8A591FAE23DD13D0B459B07
      19EC858579B2179A5E4015D5D4F1F8F7305528C79352812657D04C0F741CB829
      4A3928CC0843CC17065E89B1060EE5AE325A6F284440CFF5AE9146AF406EC15E
      1D463BF77DE1CC55286C19155F515AEB668970A3E7A39E3B2D5B730D16888609
      B19DCE3FAEE47A2D4A27725DA4282F8765A7F48E5A4915968D2EB46A4DB0DA24
      B51A0C5EBE69D47280C9DDB2200B067CE26E849564B4B272F049A56AF06AA9E0
      7415B6A6BCCF15E46C743195FC7D2FBC83D0CEB8B68F6B429AC5EEFE75D4E9B0
      9363A96CDE040BE8B86AAC98E532F8A0407EE2E46BD4E06F13613EF94F835859
      A5C2D34B222E06A4923FBD68BD58A533CD787129678C36C3EEC5B2B368B3A7FE
      E3F337839F82E7D4111554FAE2E59B67746C2FF3EC7732FE4FE913DCED4BC347
      DB5B153010296F27C58437D5691D5C04A23B7A0349307A8D5045A396E676D58C
      D321250FFC60330ABBC3EED44A72E36E3B68BDCEC88ED89FCD5A25DDFB008F4B
      78AF40F9B157A6614CFCB6C5D8E77DADAC061767335091CFAD17A4F0D265B25B
      2FA4A4E6213B54CB4F8A0A63F9EE5260339C1942D0FF5DAC0247E9A868C96F2D
      E6C3A9FDBF0B5DF3C079B560D2AFA2F54AE38F527F2D0557AEEB99240C6B7F09
      D744EA4A7398178F56BF87E99E803AB379B0FF7D5DCE5C56F2A79B358D5BA8EE
      DD9B835241AE73165CF843BA18376A1AB7735421341060EB39D41D6694EA68B9
      4CE3D53917AC96E068F53E63DEC90E6D32B746016BE43EAEE7A3E734EC14DEB2
      0CDF1CBF7B7554043B2A1CDFC2004A3FE253C63FA572DD409258832371B8EFB2
      7271F2DDDB6066423BF34E014D95CCB042F3DFC7CCAFF500F5D4ACB862152C22
      07F1732014F283A790DFC54C9F1176393EFA866A46B57D64111C686B2EEC272B
      89ECEE7E02DACDD6DAAA4F246CB42E56D2C478DE342FC62DF37545E96951AC05
      3126F878B89E2F6556F97AB1D04EB4462A49B8E2488FB987D215A7D7EF62BE14
      1FE3F228F1BB44EC254E6863DFA80B994EB7D624935547E531D4A952DAA37198
      43A0F37E17D3AD47D3347989A1C1C8A7182C0DF6BB8CCF53E76B828199CD4A9C
      0CA983CE6671D336F81655A9DA78FBCDB754A1BE2A7143AEB5ECE2CDF6CC4CD7
      27B4BEE134433D1A2E42E352973B47AD3FA298FC9DE7E5377F9F2EC337498253
      4469169014C501AE620B1422523059722E216087191B62AE891AF3280EFF5C31
      11FF1E66BB5E48B9A3C03CD3446175331F1104049629E9C25F779E8A1D2F5CA7
      9052C5B375EEBA4DF6CEE5512AA09A6685DDBC089564062BA1FB9D3FD1EF8ADA
      B0D09655509BB0D582B5E3C1DB63EB7B23E14B41E2699680BD5D7B16C0E63657
      39F12F647C1F50051A2DC6AB7AC048B2CB893757A2633B6F67AC39CB61A87614
      9464F2AB6C2DC59B1514381788E2E3D2DFEBEF8DFEE55FFEA5595ED5CA8211EE
      63CD85C385AEAFED251B5137689BECC2AA482EE1EF95FBC873A11E7D7A04A78B
      D864C53EFC6AC3215727DB3ACC4844F273A5CD8CB83A1551AD258B4FC5D7A583
      FF86D7B240A1B679D4EFD5CC25EBB2A9AB5E5BF3D3D323AF2CF820A4ACAEB299
      9BBBD5746B6E3226375A0477ED60F0BB98FDFEF70E72A684B073B6FBEF620262
      670791E32BB0AD0FCD258563F378CF16734DC529828184E93C9007D9AD62BDFC
      754D49A8FC84E64F797B0B933ECF661EB35273443803E6C26AB2A944E72B7827
      449ED12A9FB99492CD2015B1E13243A10628D5E0C520C3C6D5FF4B0B054C205D
      CEA49B89071E72E0036215707AC2DD374D64A4006ED440813C7AFF5DD76148E6
      00B474B2637403596436D14CB965BB4A3C62CEBE72794B1BD498D6EC12D065FA
      331587356A86B7868F0F70CC823F884546B3E780C23782DC788390E1D9391712
      3B056B908EEA0A660C20ED98CC97D2D365751B18A4BA6DF7BFF32845F38C6C1D
      F02A3BC321A3C2C1B263EC26EA8B5247158467C380E52E2C02F77BC925473544
      97462DCDEDFA32F3AEC79A41E45B2AF87C821B506C2B78DFE56D8C9446D9194A
      455EE72B97C53DD9AF9F8359AE9CC1462DDAADD9688240418451058169DFC84D
      34C3C21791964B662A805A9A08C0003D4DB32F3F27026B3966D556981E98DE27
      2F739D5EC229E5BF8B395623626D4FD355C34F374E2172A5828583FE2B8F9F4D
      7564BA008D9AF4BF8EBA5D8AD60A881557B91181B226071D76293EDB12CC48C0
      C19B36859E56A23816CD39CA2B0A891C9D524B9C25D7774BD62FED58C6D93379
      CA31DB464DE6D6CCA1DC14E7528C62A2483DA38653E7B57DADD8E99C0C49F4B8
      BD95C76DF1EBB19E806BADE48D2D0DB9BA043524B4ACAB2BBA95F46127502E8F
      2EAAA547CE52A383ECDF645C1E7109E6BED2D22623036ED4D2DE2EFE5A3F1E5A
      BBFCC9E7AEECB85E90FF43FE05A9B3DB6D7D36CD9A725C66597621110FE70DE2
      F08DEB0550ED16CF582C54A6AA4D9E2AC8F80C65404A5D038B0F475DCAA57FAB
      B15435EFB2D82E895E56B959CCAA83FEAD0BAE6F2E2DFD7B0BAE07934D53CC97
      5C0F2652727D617332FAFBA3CF2DAA7AAA16D29D43ECC0FE5E6FAFF71F8DDAD7
      AF5F157C73ADFC6F5515FC9DAA682EAB94C0B6B298DC6D1C9BFD787AE4E4C75E
      A3F64DC6EDB8F0C1BBC3FDB2355113071A65904292E24DC3743DED9FBFE9B783
      E7AFBF17BBA2B2DA8D9A83A2C5E3F0EE751A35B08FA341A0100F0D1A95F49280
      CC6425E483C953E9C7C00A350D5971F91B35E81272B289A32385C4155BDFC1C0
      7A5F36301E06B929FDC078A8492FC83E2B3CBA83C13F2E3DF8E62F151FE9ECC3
      2D802BFC98DF428AECC771A50D0F079239FB3772B86D77213CEE68D39E932FF7
      E8F4ADB78BB465948DCE17DA034B019538D0094BAA5992EFBE6B2C5251F1822A
      2AC8463F7EFDFC8DF4FA6AD42E6115A9C37CD90475213DE3250B81FD63C1C101
      1750376ADC34A6B2C1B67A299B73781F38AE3E8D523C88801C1393088FA8189C
      F172F8F2A01DBCE17A0B720655BE393A7DD53037EBBD6769D4C7FE09F335678F
      BD3D3AF9B6517B04B6DB7F024BE527E9862D9CA151233C5A1404D5691CECA194
      9B51310BF9A50AAFDF36D34E1468351CD29C3C6C97869DEFF64C9209C854CCE2
      589B07356BE0DB5B870A511A5F2DCC3C8DA0F549866592DA59ECBA9069518D43
      5936C1DCE654E5B634ABE87C2FF881FC699406B37A9C6A073D3393B28DDAC3D2
      24F8D9E619D780B09797F0A30AC24DC944959B891B91D19B09908E1232B8D971
      E19C8FFA62F1DCEE692F786E504CA11B7259521C33A5BC1CBA545A54431374DD
      D40C77A8E25115D4F1DCCE124D01D1AB09833C5BD866A98DCF4EF7F1DCE04367
      6FD8A871916577B790A28F0B7C707B2A0866FF8F25832C3D883FEFF6D248FAB7
      83929054C80B1B84E982E054D398DAAAC2A0D02C1257B5C289DE9C44420103B9
      794F40E0CE0DF5E0937201338BD63316059232F5EA7028719077CF33C2789CA5
      615E05AE7F7038DFE270EE3E389CEBBA4EEFABEA3ADB5B3F9E9E1E89B273C0D2
      80D23C67EB3028D64B0A53053BA4AFAA5EBBDB26D947A86B15AB84A4A1D37BB1
      D577CB3DFE6D2F8AA25F238FAC5154088D73F804FBF053D07A61171470E3E293
      37E15F6CB42A5AAE3FA8343269D6C8BD1EAA63DC5FCDA8EE7ED93C954EB11FDE
      0C2ADD561B35C0EDADD38BAB3C9D07DF9F70FCE1399524AE5703FA5B4FE353E8
      490B2D4D222BE5FB1362AC7BF623E3C6636EE5076DFA4463EA121F7D0C7569F8
      21A7CF1F27D900BF7919DAAC9DDADE92766610344F49C59C3C8EA16843653CB7
      1F4D6CA3740E31AEC5B80AAE9C3262DF873496E4FCD633F2EE28362DAD489613
      5ABF02EEB7447D6D4BE6983EC835C32A53FC192FB3510BC3197235EC48EF354D
      1771263D5B8B749ECE302A6A14D7564F04674B6A83432D77E4A4316EAFE89F97
      2D66CD026C6A9DD842506BD7118C48DBBA3E1D4D0E94CF39E36D6916D601EFCF
      A55155C55C318B864DD195583B87FDCD73F40D36E3E0D91527F55D4AD6E30748
      8B994F68F45E7F8DC4B2764B104D8D9AF3F6162572053BC4C1FE07626FF79559
      BE22BCDEBCD85B7D941676E597FFB9B6C5EA1DC14CF197D8432ACAE4FEA49441
      C530B052ADAA6D8D2519442AB2B95B228CC7D99AB38E481D95AB1AB520DA562E
      F6284CE4AE4E9B27423F68D178B83E93402F6F157194B92662356BBC8B4A9C92
      59A3F73AEDBF3D6613B1845AFF4B912DDAC1224DC034E7E4EF49CD0CBFCEB258
      2CC607CBEED396DD835D57B7EBFA5FD787CDD684EA93A784710C2971A4392FAA
      4C366AC374C0A7474DD5CED57C109D3C183472113F214704A291CADA7CD3AA46
      0DFD772C5A1E24C327254377AFFF201BEAB261F0201BFED958AF3449714E53F2
      8952167A31332B0EC6B9C22471C4F8A62A51369F139F9B71768AF3C6346A62AD
      536D51F4C5C677A386FF79D3EA816FDFC6B71F74FA0DBE3DFCAA7CFB77ACDD71
      4A8D8F1154B9E4D92CBBE4FE099682ADCD1AB48F6D3CE76C108F6E290B2D4079
      D6B06309336BE214B6B774E5E9A7AEBEF990A571119C49A089EBE9720B7D9BA6
      403B12AFA94B3B85A0D4334E78FFE2662FDAAC9F8349A8F6A0391F847B48DE14
      060EE74A7D06D7931E3A254A0F39E91E98EE6798EE43807C83E98EBE767EB332
      817D2E997CFBEC68BF898813BF171732B71B24F85C623576BE5C5D057888B96A
      D6283F2AAFA4813A16FFEC74BF998D6ADC6041024A018A7E44D583960AB60D15
      064BD1F00C9A421199A5257EDFA869E090390945C1EF377DF9EB41607C466074
      1E04465D608CBFAAC028965465DF5CC7A564366BB3A69935174D1C9EEBAA060E
      4615459C587678BCFFB281434D669959B9D0734E80584D33BE4CFCC170E6C0AB
      2CE6D2AC2248ACA17C8A460D935A2BFF6FEA65C9FCBFA565BB9C64BB09DCD4AA
      99902996FC431A130A22A3DE346A56041CAE39C40CD5C3DEC01275BC51632D63
      1ACD2DCC28C71810BFD70C37F25C53C450FDAB72C1D3D6CA16ABBDA5217A51AB
      D49BED9445C70028946832F81FCE3681CEF13FD04276A5F89A92E81A35756D3A
      5614599472E983AB76A039DF75DA2DE50A62E56E803DFF65E2B1FD6B8C74C023
      BDF371DE2DE2FBBFED2559FFEE07CADCF2AED734597CA0916E6FDDF158A927D9
      A2681C53E16C7648C7E04D7E6616E9CFB09376BA6D7667F576C98D95481F9C15
      7475ED7922754837456FEE1C58F5F13CD3213CFD3FFA0B71AF7FFF67EE1E9048
      439D3B2E4562A06342C2235CFD591AAD360E2396E01793B84A1A6C9402A4356A
      5D17775FDFF5E6E9AF59DCC509CAD27206E6F972BD52B05FD6FC4874ABCFC0B9
      B309357FBE8EC8E9411424152BD4B4957A90DEF1D45B98FBDEDEFBF7E01C9E71
      BC7F0F3DA478FF7E7BCB5572C4C1614AE06C2B8CB4F5CF7C664B57A928B7D0C7
      CFD358CD38EA4C290574265A65AE80B461E3A7B14B3B00729651B3470A7E301E
      F1BB93A3230DDF631F7D1CC477CAB1D43FD3FA22D806220F5E8B04B56902D762
      FA8FFF5D710AF08B2F466A9AAF50E7F28335CB6CF1643F9F67F993FDF97CBDD0
      249625396D8B736B570D233119F7B33787EF9EE0474F7A217BEC5D768E7BEC37
      A9FED21E2997AC65C4D4509A189A136004219ACDD6CDAB0B93891EBBA8C4E19B
      67FF3780011CCF9A261175A42737A0E7C696D04A4B88F16A25C5833FFA667F74
      67AFFF9036B2E1909E7CDDB411EEF0379A3E0DCC9A90E6E7D09222814F50D9BC
      01EAC065350979DC143F9DA2F88199D3557479B5D1BB87146B169F9539770798
      B42631A410E81FA597BD60E20ADCAD9EF737845F05BEDAB0B69C3A8D51EF69A5
      3B4D9EAD44CF358BB31989867C5EE220EF545462D7D33B2BEBC448376D562FA8
      F36C7561AF8A6A2D635990A8558D3B77ABB64BEBBD3BF76D3C966E6DF9BC4DD9
      324B73D75E993FDCB9EDA02B4D102A77ED967B7CD75E2E1DEA225BD82F1CEBDF
      E161F9B7BB1E6DBAC0795B35EBA46D6F51D7A4E0F43C4D560ACDC34DCACAC640
      646B5FA44B86A5CF18695D0F20AE8311B0438A27CC9B9CBA8DAF23AD9B935BA1
      AA14D42E15E281F2800580C816172B0AE740196FD6525C5B88C8750F7DF3ED27
      3911233F2DA4BB12AFD55245A86FF7EDF9B4C044113A91C7106ED41AD88F5414
      6B6F1DB95B03866D321F4C3A73A1AB26823BC898B8E582F6AC236FED1944BB46
      66B147A2D473A62C18B47A8B8A60875215B98711EB71CDA254EAA5F48703C2D0
      4A69128BD955F09AE25C342E9A2D0877196686BA2C1C151137FA927C4C699E24
      64DBA81955B396158BCC1D1472A4A8FA19AFA1E924665638D0CE0FD2F472E1F3
      9BC5AFD7BC3E6D5A782E2148CBC5C30265D10685CDB3E091B471BAF9320A563E
      6AD4746E890957CAA98BA7E48711684B46DA70F1D91D26DE1F76DBC10F590EC3
      624985FACFF2ECB2A0F8CAFE6CF587E7FD669D36BF1B4BF2C1C04AA0E6245976
      3137F985327ACD4078CA5DCEFED0DDDB1B3A17B5F197B6039A9CFBEE2C0B4213
      5D346AA29514416AC6EC01D07E38797948582A9973E02EB2CB76F0285B3CAA70
      C846CDE47A7EFB4E6857C679D1DA84E2E6CD1FB6A71A6600E9045C4682215F26
      6197409A2DC0E9219FA4574B3123384449C3C7915A4A6760E5A057D93AF74807
      69A2B0898D9AA72F4538B95EBDA2B3D8F9E1DD37276DF615B619D7B42D1ED1A5
      595EE5EB82A9B41DBCB0AB236A1B7428CD92B5910396C4A740BF361F5E712D46
      B0435D4E2F58A6FC255B5CC6E346EEBD6496F35477DC5C75337769E8147B9096
      142FBF7FF922D8399B65A199ED4ADF407CF47A2F78776E1928FD1175530A2CD6
      4480900EBEA550C58AF03935654AAB35B471DE95335A251986E130705BA552A3
      392B35702BF5E7931787984EE8BCB2597072F41C84C3E0E3A2E535101097C263
      145EAAB6A47BFBF2B057990956FEEDFEC1B738F2EC10A15CA4864D812264CFDE
      BE3BF41D13339F8A1766F115B7022B7C87415CF93A58348E9678162716977240
      F2E0E8E54B3E0F2CFDA4C53CB5F2262D9AFDFF492311034F074F14A85AA3AE3C
      FCAA407FF3FCF45D85CF063BAC403F3A4D3916AE9ACC2315F62CF69364F721BE
      F1B9F8C64385D6467C63FA55E31BB6582AA6AF360AA16C2E6A37289DEC6C316F
      D476A94FBF3F7A4A4D278A95A126C9504F9399E2F7418939CB6D51705E73246E
      7DB2756719E9EBAE1D5FB38C5E37A9F153ED2C28955D5EB2412450A38D1521CC
      92925B04C7EF5E51F541AC2D9D6BB5B50BCBAD4DB5A37DA3262A39FF94FCC1BC
      744259DD390BEBE2AF6B8AD4873936D4AEAE4F58E35067A934A667C705DDE780
      6F18C7AE8016BB67F7821FFFD7DB7475BACA963F356AF66CF31E8633DFDABB06
      C229C135E9D95930466194AD6771D980F98A551FD63133ED03203885CD3AA1AC
      467A4445AD44E11E3197A561ACF0A034815800F79B656E51B5A27045A24AC712
      A979AE8956047027DDD4D9852FAE5E56D40A97573714836329AD5DCB1BD835EC
      BA0FB3C3AE51D3BEC55DD50EBE3BE658759ECD367C57FB4541C7756E1620DBBC
      EDFE0E9D9F8A69BE698E2A351C85D7FEF9E0FF3B0976ECC285F17FA60885F7E6
      FFC76EDDC02053A9B97379FBEAF8B489E5D5DE4B33670F43161619A70752D1C9
      AC22E79E06AFDE1C3E6BE3E7E9613B78FEE2C53EFF3CA59FEF4E9B3825D715FE
      E5016CB5AAB14079D236AE48AAEF4EBF7DAB5A55234F83E7CD9A82CD8104ECD3
      076A1D9E1A0A8CF0A402482C6201C4EF1A391151322A2823AE850A3B079A7B3A
      1E1D8AA9F0481BE69C5B4E2EAD88CA478F7BDDC17830E98F0693BD0EFDF78824
      AB3400F73DA9C920D75C5B791079B0A02CFFF9E0E50FE5596B583C75C38FDB22
      6BFCFD7B81F00F42AA0B2D5A2E756AD37DDB6CCFADCEACDA21C8F95A250F8C0E
      53F3FABEAACBD0F1B78A56576573203746A3685CE1A80E5F78C1DB1727271531
      8E1FF97AE931E0CDEAFC2C274C1FC104371F9A6635D5E672035F7BF5E2E83953
      11292772F0FFFCF2CD41F5AC377536ADEFA4AFB08BA0FDF9F4E8B005B69537CE
      742DCB3364E4120CAB6FC4EBB707FFAF7D4368E6A1AFD167BD820F301C75AF60
      FFE6BDFBADBC828AD6044BF5C96B6CC52BCB6D42C87AD5F8E37A01FADE0BBE2B
      5C2B70A81F7404B6B70CEF6E265D2434EF9062018632A1F3B4721C9AB1D5A796
      6089786EB9FDEB3ACD09DF43729CB9DE36E6B211B0A4B859E3962D3258628AE2
      DE564D4B7B4018B5C9952FB67A44E6482A09DC1CC4A19D6CD4D4D869B05FA11F
      4A6F02BFB09220236959CD1A72EBFFAEE74B8679CDBC6621C2F751E1D2E497D9
      72BDE432B1668DFD68410EB827EA88636008684192EDAFD98ACD1AF0CBEC4CC8
      97826E1F6C7E99A718D382A28EFD57CF9A35D6EDAD1F3F1E823608817905EBDA
      7E8CACEB219493A389A2BF64B89DE7D9FAEC1CFC953E78EBA2183803E7864C70
      4E9A2D5666BEE42E9F73B60D434B19C5C97AC6ED40C9771EE064485D252B28CD
      5A0B57BF874B2F0A27312A9024522B439876E45F2821E2F782B76AF0E1FFB0E1
      2973934303ECFD6EDE1C3743CB9FC8D9D1065C84D4F4EE9594129137F54AF16E
      767F4BD5F117288BBF50DD38753EE7A78DDACBAFAF057EDD56DEAFAB0D8048DD
      68D6517B7D4B72ED4ED9B12AB7676BEAE6663F52D72B864ED96DDE24AAD1959D
      772F4D08AD2726DBA81DBC3BA084ED9718E8B3EC63C3867EAAA4A189032622C8
      0E8832F640B8CA34890071B5C81F9E33E726654E8C04B04328AE167FAB00A014
      EF864DF2446316C5D562653E06E73888333A8C640EE53E055D55D3FBC1AD09CF
      BB78E0D4754EFD751B117F6F605973A78CF4672A1D5B69E115B93A19FBAF5987
      EACD9A4BA1C5AFDFFCE11E8BAF0F9BD1C68F11FD98D28F49B0433F2E4D11B428
      2F8313D0694EAD7BA2B7BD4A8BE88111D419C1D7ED5CB7BD7540056EF32C4E93
      940AA318ED64BE34AB344C67296C2B96CE61861F87163348833F1FB1BDF5E7A3
      BE83E4E1BEA745B6CEA98A8CB2609A751CC5F3453D8A5FD340BDD55864C17A51
      88392DA8E8AC9A28C842D90757BD970D9BD5B3AB95DDA7510733BB38C3F6408B
      CDC9EAE5A0EE681084E9AA7888247C2E92D09B3E4412EA0CE9EBB64BE30DC211
      2C1B8C8757604FE9DC2C305DC22260DC94F7C92C261DFABFDFFF1BFD4A490FC1
      9D830B7EF35F6F8F4E5E1EBFFE36689DAF56CBE2E993277E247BB1FD909A0595
      F4EF81613EC1BF4FDED96248837A7C8C09148F07A3F1B4379E4C47ADE06F34EE
      599C17B3D5DFBB5EEBD9FB28E97D9E8FFFA211FE0D7457409312C2A3DF68CFED
      471028FBA2AFC69DC9FB24CB56FA6B04D3F323FD6217F1E2DCE696EFA65B2834
      4ED4CA4F135A8B66EF8B64B508FF72E7B2AB41E7D6A56D50127CBA20701BE3EA
      3C621B6544C83B279AE5BA7FF26ABF1DBCFEFEF49852D70E7B6D2A2B7BD33043
      562774F4015BAE0DF5A4BA3F38A38C4D721B1F1F4A3C9BA242B3F467BA42925B
      9B3891E7B7A5437025A0735B09D4AC07476FD44434EDBF33089E6236946C9C51
      1D389518426DA1C20C465B28E6C10EFD72769E15AB5D8E1AF85840D32CA5ED2D
      99D46482391D0A0624BB4948ADF42D0EB155B3F51CBA66BA22F410E867183601
      D04B5BC4C2E784073BF19AE3C826383752AB985B0812C63708D767BB54BA89EB
      53C28C240B4CCC2FC11E3694A9D1ACE5D11DEF4EB13AAEF4FA9C431A268E8958
      B1624511FCF9E5C94B9F42AF88EB8488C3697E1A19A0996785956B19201F0200
      F235E7DA9D457AB6A058BC94A9BAC4ADE377AF9AB91E1DAC073B3A2BB0145C30
      C0701585F62900B74A632D9A28F682FD5991B559BF686DDEDB221386AAF4840D
      346BD26F2AE13FC53926A7296D33971443D0AC28959E69587227420B264C7A71
      B366A267BD5752F3815942A9F4786A9A2AB510C0152EF0B1DA32CF15F6C46019
      64BC9116834D3DB4EAD1E7BB19508F899BA27F05819F13960991C6FD70B03C04
      C66E316ABE6E2FD16AE48362D22CB7BDCEC11E16C2AC8E699196A6803615B408
      D9B8155CD82BC8A986496D8A4155B0691C5A55F30659E3EABFA933E421DAD2A8
      E3FF75BB5A1E90433567C5F4329DCD5852BB3C241B90EEFE1173E2A034D47A92
      E4B95C98AEA86AF783653CF76C7B0B83BCD23AC3D09EA78B86F10555CF7A4352
      CF1C548C169A08AE3697555B6D45D9ACC13B53A4DBEBB276A970AE5A739B25C1
      09942A8A3909E63C831CB151012DE4C4C3C57A7C3FB6FB67E64ADCB192F34AAA
      9968E3FC75B68056FE9AF1AEF9C925E8EC9F0F5E9E3825BCBE705A12D7ACA573
      0BD779D2EDC290DBDEAA2C08D1BA2B0A11F447CDE3329A355B5DBD59965DAC97
      41BC666F036701C74A455CE04D45CC0C06B95EE47696364FE83803650C127A26
      3D0B34E0FF9D6B714036D6A1A64EFA99170445D7C89990B22E1648D052281371
      63B5B07F33A70534CED4F0A7B94BA779FFFB6AB14E0D28812BB271F2D8F29028
      D05E702ACE2CDA2A6DDD68662EF5990F249DDDB2E1B6D2AB655719E44FD14CAA
      EC9093E57B76E711FA852E86B02632A7E8AFA3D3575C9DB5173C33D1C519BB47
      4AF4F2593A4FD50EE3AE2FF8D74349E822702670B3A6EF69A13366C1246E3F13
      FC756D8B9563B3CAD631D4DC0822861EDC2437675478273547E0E5A175ED6FC0
      873F4D2A0DCCA9754B31C2521CB133D4F363728D6825036184084C011F1072F6
      2ECC8739C3BCED41C5C411F88E62A2E4DB2627921CAFEDAD9502A30536492847
      E3034E873F26E4701337859435376B614A2A21F5E58DAA67B43242278E0E0A6A
      6BF89FFCD1BED63953FEADF33296F9DA7BC1A11C097234B71D75A45C4D41280F
      E9CF362E1747F173C4DF41356ECD5A1DB736E479FB3E4B31D177574BAB10A4D0
      8FC803BB5C5A28D17BC12B99692127A37606FEB94DAF6F17745078C20F0658DD
      00FBBA5DA24BDDBE0FFAFD8E633CD7FCC72208291F44B960DB1D4A272917D412
      97C05DC8C1C6EAE90125A326622278D32E7495E6100F0489B992788387CAE6A1
      10B874C3227EEE8CB3CAA7ED90543FD28C19C1AC517C0003C17F464D9214F33B
      E6565E6E96B43A7C39A365C22438F81657D88257A8609BF6DCD69FECD28954F2
      F05F583CF1E566640C631D35E5EF7E3094877CB9EB9CA409ED7DBA5DD2115AA4
      22C35C157A6D49F029CC3E825144E7592E967F98AD08799C502DC1269A75E0CD
      872C252C0951DC09202C22B8090A933B2D060C2C0BB8962AB6E1FA8C5C22BF69
      AEEAEF34A96CF29054563FB55F17B4727BEB0792632B8AFDBB867F224ED23995
      4F9A85B677B0305DA8DE04C79541BE5D5B0ED10DCA4E2DDC201573490900E9B5
      FDB866ABE07465CD9CCD9CE23C53984CA800D2E3D21417810909A79787A1B20E
      4C613D6F242CD25B85C6DE91FC18E732D9F508C4A40E49206B0E31E5EC68D17C
      687EAEA6EA108653B608B37C111CBE3C68E2545B8459A02A4F707CD8BA294B48
      1D468D1AFE3B1AB646BD7DFDF88D01709E8A43156CD41CF635CD9C8E9FB8C62B
      9D71F0A1FADFFF4F30E9749AD5E195430496FDB8BE3F6894CDD89458C4AE7D83
      CB5D020BE51CED46F6F3D9DE6AD561AA3D2C81763F8D52D20044B5D7D61C2FF7
      5F1F4ADF009E2E7E39F614B823ED8EEA7D8E76F782378B4A630BC59A902EAB1F
      A57C51FAB4A43F37B9F991EFB27A23F225E902DC794683CE0FBAD2E774A5F183
      AE54D395065F17CA4765E2771AB38B5333CB386442ED78B5591983D275F7268D
      DAB89792856C9FC45613926DB05E25134D5E2647446E16C5ACCCCBD6ACD1B654
      E95E31FB9ACFED627B4BA1112957E774954BCFBDDCA5ED103E8EBA6F5719D560
      2BE462A35643618AC06E45823EF1AE5A6AA45750AFF8183A81EB2EFBC0A63EC7
      A6460F6CAACEA6BE2ED644A5B73B9D65086056C7E260679567EB905264D87779
      682E17676B42E3B245C30C2DDFA3E9B987B927C4E8FD83234D0994D2C4305D32
      06325B27EA523D66FBB42CDBCCA9D9DB664C5B50C3D5DE856AE2AB1A6E78A464
      DD97D13F31759B0898B3AF19218C0A8FD1D22F9564440695E08074056E011AE9
      A65EF6D079E5B31C6FF8C0F1EA1CEFEB623628B380F9413D05381B817A0F1DBF
      3D3C75FD128463346AD76A4DD70E8FA84592E651ECBF3CF846BA1CB70EAD145B
      F3B9258F39D877AB59CCBA2A6F2A08FF05C3DFE596FB8928940DAEE9D1519232
      3FFC7C2368BBC4D81D8F267747C665821418832A1D48C96013E75CE1B85CCAC8
      517DED5EE92746FBC83C96E9D27C708B21B36BE8B448BA12085E65575E09EEF6
      5B3671765C07024C9759E26097A39FDC19D855E010BEE4A27411720BCCC5A6FD
      DF909933BC9C33EDE669C191F0B2915FB3062BC0CFB7D66D9EBE3D7AD94478FE
      B75CC0F138642886D247545C41B7924E902D694A2C55212DA962DCE1E861A5F5
      775559A1063ED44A6195358B29B6B4364DE6D0ACA1ED835F5DFD6C8397D9990C
      8FBC8B790E6377765576E7BC8331F7BE6CCC3C4283ABFD987916492FC83EABDE
      7407837F5CBFE19BBF54C149671F66371B76FC98DFA458EAE22A4FE7BE0DED2C
      BB8B80C51D6DD29B70967E20F7D1C97A4189E87284DFE619C5FAA869DCD99723
      54DCB25098EC3F8C50F1F4C993CBCBCBBD050524611B168CFB90E9989FD0274F
      06DDC9A8FF1B0052FC3DC3F9DBDF600B3FE04F3C5847BF68335E4950469B8F73
      9A59166409013D73CF089201ACE291CED67A43BEDC16A9F2227E9F51E10E45AB
      9EE4D6E0E1211562796510036A07A7F6AF8CBBD00ED4D5CC9EE4766057D15EB3
      E4F2F3F58C90A397A46C5C5089B8F889F2C039C9D8FC7AF7E002F99C0B64F0E0
      02A91FF2AF8D56B7119DA264DC000600B5BF02B1CFB8C92219099AB8B3B7FAC8
      693ED2209561C233D8E7A7A78CD1C3E6BB53B81BB5D175CC9A0F547EC219B295
      564A20D4FFFCEEF45D1387CD2DBEA597181F78C275582FD945105A02ABF00913
      1530CF264E649F7D3BF38CD3BF67F6CC4457C1C9EBFD57EA2E270FC81F95B6B4
      505FBF91CE3EE4FAC1CF57F4F387A3FDB76DF67941AC1C9F36320FCA6117DF3C
      7AEF25E119D6FD24EB4561122B5EADE5555914E6EC5786E421F62AE7B259D292
      5A35FD14BCCE7CF7D92C090E8FF75F6A73FAC68D559A04086FB8DE628D1BD398
      B3389BCD080C080F08A2DC1494D54BDD5C3495D1B57BF6FAD2E1CB8366CD94EA
      F48256593ADFD2E62E04524A65C4AAC869871A763B26D98C24419A687227E980
      A4E6358BB7FBFC212AFB8624BD2A4517B6EFE368A0AEA2666DC73758DBE0E0DD
      C94B562859C68A82A9B58384224BA49794AAE7837AF939F5B2FFA05ED6D5CBAF
      8B3DAA62F055B5F5A6C32E20DA16CF54D58F888DE4469DC5D3074FE2C64636C0
      93F892D881E833453B38269E0A2B7E6921199BB35B18DCD3FAD8DAC137D4C0F7
      ADC957F8FDB989EE2A07F68E467C6222FB34F8C6A439867774651BB8A80782E1
      6DF3068DE9C44AEA61838644A98101358B69D098BE758654B6781AECE7F32C87
      F961CD923C6DFBF379D6A6E3FC20369B2636C92879C286D40FEC7FB139253490
      72F8DDE18968E152214D9D7F5CC75E08CFA23067A239C676B6BD6549D6BE361F
      5E09D444A3F679C3F774CDF42AF61E9480E62901DB5BCFDE1EBEE3A62B2EA1F2
      0A14E852C46371AC89A1CC75790C8C0B036CB112B24C13AE605905334399A450
      F6829D32D94A9EC6E60F3DE82E3C1B77A758C0E858A5DC339E41C4AA63A6CF31
      D9D87EFCF5FD72773421727706463157EAB068E5BC784A0D1B73B162AAB9BE09
      FC45D386ECFD139E0D338AC5E282DD7887E9078C7A95E5CDF2E13DC860091840
      357FFEE760799E2DEC5CDACD83E834FA218E3FCD9EAA6423364BCA5ECF8A2FEA
      795F3C720AE5F0D9DA91C9CDC18067CCE423C58AE6E6E3B8F48F725D09DFA60C
      840105576BD143C00C29E73DA13EE44DEBF8E8822AD2C1B6A07E1E8FED42F0EE
      199A8AC028F10B01289E1EFDA7784777A83C8080B8B423B673F30A78A8A114C6
      C83673A29EFF48CE1FE7C5350E5F5032290FBED97729884C7B2EA352B034CECD
      8C5A3381CAA4728EC2268764D9BF02955D91C7BD89733A74BD143804A22191B6
      1C2D23ED311430A9762A3989542344CD9AD6EBACD2A29CC7DCA2C37141A2F892
      0086E82F0175C4445ACD1ABC8B7F702E35C622F52E547658691CCF0EE52676B9
      DFDED254D7E7E98C3BA0E23C1F68E4499232090097FB72631FC4312EFB94C80D
      05D452AADD947DA38DE2BEBCC19B6F290F7B25D3D76B6501DA0C1525E55182E7
      A17052DC1BE563BA72B85367B999B705E5E3DACBD44EA577D9BC7170BBBA9895
      0A7D81968D9B79FE4E053D4D4D7D56226B1E83279CE74D7BFFFF66D919676CAC
      9719836237AC13876824F394F0B9A95A8F8992891692F6D14AFA136B40526291
      AE522F2F837D9ECAD8D8941E25BE6B8D20C8D0B3397E260FE7F246CE09C735FC
      0E7E22BDA81D2CD72B8E762EAAD1D03CCB562E1A2A2AA0FB12AB6AA3F58A9FC6
      8A021EBEE3B25AF7F0653BC0767C2FBFD955F400F6F4F9285EEF218A573785BE
      72B30DC91F3F9514FF6671106A4A5122C44AE0DFE6CD1AA3D47440CB0819DE8E
      A185A8D490766D45283084BF98E50D83EF3F81BD3B0FC1EF9659A17D07C028C9
      5561299F87F8DFDC309E71F3D4A4B2FE5BF22A148B9B75BED3F33459FDE1309C
      1DCCD2E8A259E3FE717F36FB29F821BFB2D45DF75C3ACE51E45C51D376FEB679
      B27B7CB2374734F8B2216D6FFDDB9E2D967BFC9A6B8FFE654C6397A85C354531
      99B9E9400389E5C7FD972F7F0A9EBF3C7DC725A3018D49929DEACED0268EFAE8
      F0F830300C0D5E94A059DED5DCB0218B3BA29AEBCF479302924A29B3CA7725EC
      8C51DA21E074C74B5725F44C2367F978F6D48537A8FFF79C9827E96241817944
      E702CF96310CA88077D5E6DAC0A6DF95DA65323E526E9AA7DB264E30F6C754F2
      C49F503239E792B30DA2F98596500E13CFD2686A0D9B287B6D2442FE2A8BBF85
      567AFCEACDA1734B39B44632133F989C2141CAFE174D9CCADB9787BD7A89FDB5
      F637CCACA19D805A9B370389824B870009F05471B2B9F15342FD371AD76DF447
      67073ADF7B76491934E7E9D21193545A60F129C3BFB1833F5D649757C1A5350C
      D7554D8D4E3F564359FBF9EA7C9E65F9838DFB591BB73B7DB071EB36EED7ED28
      979639E49B492844D9625772B081630D847DA521FE0752FF1CA93F00BD6D90FA
      D7EDDDF19CFA29AD57AFBF6722A6928EB9C92FB40995C33F4B93205E2F614D70
      E857EA76700A3E50431D423EE68CEEEDAD466DACB41CE3DA1CB1FBA9FB1D5753
      AC02020FD11E4A8D449E6E51C117F11F29282E5A1E27F43C5BCFE28AC6265D81
      7883ECCAA433E9EA2E00E8644D71E4FE81297D8E293D60B16D30A5AFDB06647B
      2B6690C92022AF1CD56D198754AE911897D9CAE42E8D2FCF33690DCA55547F59
      CF978A4660564D8431BAC69E22D7127569F30BC79C28B5816671B4A0D8D6DB2C
      5D340BC24CCCB05336C31896850D61F9F40FFAF95B9ACF91CC87BB9A516600A1
      789980D13263EAEAC5EE1C6A0DE192F93C50133D9076DC972772524EC3840DE5
      6DD4C89512A172E88757D5B24ACBACFB32C896961449727FB0C32B30671874A3
      26B4BD25049A2E1E33F69E1B29752E743DF522B2B5A5EB6E46E8F62B4703E4DD
      62ED20256E4B53A1B4B0338A399B88EABA2EA55D8895EF1604CD37A3469F8280
      DF3088C5578CDA2A69E93C35F9E044215C49C04AF2A9FA820824F70749C07FEA
      A0AFED472C594A50D066D676F603AF42843B1FC0523F25A07B7BC3BD874ACE0D
      F9FC751BFE90FFAAA00E75365FDD841D18E1738A065EF7843E90F86D24DE7D20
      F11A890FBF6E9F066A2F0E327F1A24B34CBA332F49FB625167F2B4901E0724CD
      679431D74AD63FFF7CD5A26E8CD445D150BBA062BDBD35E3DC214E58DD781026
      1BDA5C1EA10F25E3949291EC5FD766C6B8341092D9FA8C65E555E012155505E6
      6ED12EF86EA2689D137E0AFE566564671084572BBBBBF962E927B98719726A13
      67E3119C39D5E04492BBCD394D7C5B210AB4DA9DD47A53472743163F017FF270
      C23F77C23BFFF19596E8E612B1BF7789FAA3FA51F20B8415E105FAAC51D73AB1
      42F56ACC4990706F6FAFF51B2ECCD76B374A55D3767BEBE34A206935B02BC56D
      2977004FCF24E0BBCAAD65CBF6F1BF07B7AD992ED98D5FCBA116E7115B55EE4B
      70070733145A722171B73DB592A5B241DACF52FFB92B0EA6E5695CE97DC0757C
      735A3C620691D681C7BE9B2C3D63977284F92F665B5C5211C85FD2DD857D8ACC
      86DC2C986B5222666193F5CC2518B30D31C75EA6D43B0B8AF69A02CB2B97540E
      C1B8E03632A29ABB967FEBD53AB76D069236338CE452DB0F9AD9A5B92AC87CF9
      405332EAB6F41D0B77ECDED95E2029F8CFDFF4DF0A9412F8E495F6E2A52F16B8
      90566566964BBE501756C3D96535A38EB61DB84A91B9B9201321D76CEC05F75E
      DBDE229F060C457E01D907B4452E75A3FA023298E925F414B1C8A4E91CE650A9
      DED84CDB096F23DAB08638FAF9C3FBC3FEC9EBE3D72F9EDE715ED0F656E9F7A0
      F5ABD0A9E114E58217411653A89AD75113D9CFA4AD31CB2241B727FB4CF2CBB1
      A81742C4D244511EC16BBF2E988CD2C27D4ABE6E36EA7CEB0F263DBA3BB630D6
      63E377747B4BF7746105E8F15C9B2DCFF9A05192031F07EAADF7A6CFBC5F499F
      006D851AE45CFAEE7B45FDBCF0F08DA4C83B781488779C3F92EB3E2F701FB4DD
      AEF7DC241A61873C2D483A7318F10CC8393339F18238E6047F7309D9DD6254F2
      CA92E17B4D83A6CE4CEB25FD3678F14C282D5F0B0CFB7A41416A138C0621E6E6
      5E8D0DFB81B3B91E34FDCFE801FDBD4E70F4E7B74727C7AF8E5EBFDB7FF9A0F6
      D7D5FEAFDBF7488E898A54D2A5C93345990D5259712D1EDC663D7FB6D2A60D73
      621960EA99F608AD495CEDAD4EB8463138BD88411CD996FC1971E59132A2161F
      4B43E7EB8A135C7075445C082AF73A729549CB8CEAE8532A3C84A8B39A9CFBC1
      FAFEB7AD0386BD271FEA115795B57C339F66E597642ABCD9ADB8A870151CF12A
      1E8497B4F3AC5839A4286DEEA1C6D7DC9A45454BD8DE62E65658EB7AB91684F5
      0FEE568D70FACBE334A65A13FEE28A2B410A3B4B821DCA6EA69D5B0465394731
      6F0707A765492CE7BDA9A9E4DCBFA163A4340B6813C79C4DEA111CE90BA90814
      56EE7647CBD70530D10912E6E68F1799E07D62F87416E656E4163F97159EEAC3
      7192B6B758B01456672B85BA85687A90AF589C0B6B97B2FEF4E462B7F676AA1F
      AABCFE3C25EAAF0E80DFFFAE367AEDD8224EEEC77CF9DB172787A29C5A93CF08
      2DD9B5CE6A14215209819F8603DC4C63562DD2F99D210CDDDD809FADCF28F18A
      1DF362C46BAC383ACFD2C8256286560A671D3482681E8D9AC8F6D63B10CB770B
      A9B663FEA7C5B2E586E8511685EA2DC50AA0081D7C7312FCD8E1FFBA839F882C
      8FA49EEBAD61EE502A41A7B853BF3BE5D205ACDA9B25734D2E63901B542FC26B
      F68217A9786154875BCA2B5D189EAABE398515A74156B86C7A59F59BF8908924
      588ABAC8FBE20AC72EB37CB6BD85DBD8EB9326A5C76749A744F0522AAD9B6975
      247F56AA89A51283A36A9EF1E0411CA2889D34702A73B358FF17EF3B33377297
      F9E5E4E47C12D092F4CE52C22D519B78DF0A975C48795E4BE0778347C755692B
      B19C4730A349BA94D23188B3A6A55CCB3A95D5137ACC69412887E7B208AA4173
      7626C284A2C0B19A09B28850B3888D451C7153F802A655BD34B6FA21AD2BDB4E
      426DD18CF2D3C5C8E51783D6844E2BE5C2E72616C2E33AE2B24AE2C118B8D918
      E83D44B636F5FFAFDDE7E205F9144E5D15F1CE8B57A7EF76E5E8D049E3B275CF
      CC8B6CF6819B9C51F54326C5CAD404B8CD1E3491B1CD6222FB1AA257897062CF
      445DF3181B9CFA2AF3632B474C14133CA76880DCFC70A83F77A87F534FFFD773
      689344AAB89FD41BCC052573F317ED58E824AA99A5AB2B75CB560CEC90D5578A
      476986455A6CF60B8F1FE4C8A749AEBBF75023BF2145BE6E23158110714EED24
      CDA188B2FBB78CA34240400763259755D046ED5F397E13F4C8D2A88F9DF3BECC
      8C5D30D478CD105877A3264056BC2F80A5ACF5B32CBF0A5ADFA431947FB27F5F
      6571F082F2D85BAE890394E5D02A560D4BF3464D88515F5D030D8CDF691A01B8
      EC6BD25884D0C80175665715439F3E5B4898046466B8DAB26CEBD3A8397A64B2
      251D4D6914F2D6C0767F91A70D4BD0DFC71A72A8AEB55E10D2D5A2E59C8B642A
      B1FB40D22C34D9958249AA38328E69A32673BA6952EE5043B7ED2D6938917214
      53354458CCC545BA6C932B51EB40DAC1DEDEAEE6F39206605D7C9BDD2EAD536F
      4CB6DAFEAFD7D9C28A87BB754CCEDE55E0C7D06AD4D2186E624C135B4B085A12
      3E5D098CCB4DCE92248DC80DAF75CC8D9A8338089F568452C48CFC32CF289EE8
      E0B9A0F694617ECE4CF560B562E6A7391D4C4B19E8DED56C1C61EC70CA80ACCB
      2EEFAC3AD2552914E2E0E7356A71A035D89C8AB65797D65C94D1054B41DAB498
      AB7490F87C0554219AD147DE99DEA8396D6FB1B448FC7EA7D7620E2DDF8F51BC
      65DCAF2D17F7762BD801D917C15FD7E4153541285966A66C530E461659816224
      CD60772FD867F053F632F920748C43AE6DA9302AF2BFE9CBE2E0D955ABD61CCE
      39922A1D845DD67C59A69E97F71328B48FEC37B2D6FE55C924C8896B96CB1985
      9914075A62E82E4B364AF3683D27352A6A9ACF71D3A3C895387976E9FC07AC5E
      0705E5D3F89C25F69550890301D1734E002EDDDE126FF86551E6FD73EAA2732A
      080C1227FB0832C6DCCEB3BDE034F309342449AD2952B60C4D5C36EFCE8330CB
      2E9A750629327045A99A67C1F1A30F5CC57296B18BD484C469FFF890F3FF698B
      F6211D7AC3A2FDBA00D875AF28B1342962892B590D38A08DDAB3E72E96C35567
      A493BCA5703527471C648B580BFA199B163224E6C9482153C3CC596FAD16C10E
      EBA0C244987BCEA81168B3D0E24BEF792569E3BADD200ACA2E6F80E4CD3D91AA
      67CE9E33C1DECA160312291ED39333547D38B7209A5C9AED2D2A1D5C68A70953
      68A0B66C50BBA35ABA4395A2A0E1D214EAB3D7FA350FC9D4ACA57CEB94B69C73
      0619ADBB5A7143EB267E9A726D143FBAF4D79C41137B1037FA8EFF823AF12DE9
      122477F8AF7DD0DF218153DF13A73DE64C2A092B5144FD97E7194847C53079CE
      0E33E8A3D0C3F7C074AC59FD4BF00DD439EA3C79A559B3F50CAB5BA0BE491E38
      6D56B36A2515FC63994D64AE652CFF320CC3C7C7B4B53495E3396FE9DDE72B2F
      5DCE55DB57CF70159082039EB3BA6B83164F52EB403D7E033199F5E25CF2CF13
      2CF5B97824DF2862297DEFC4D61765D29A2E549062D61B4EF193B4E7BBA3C36B
      74D7EF0E3BE3FAC2B9E5EA4DA7D3FEC4F567C2A2FFDB7BCA71B1DC3776D81984
      9D7E67D01D743A9D11FE3F91649D1E4E919DC6B69384499268024FD4E9F1BF7D
      F97B180EFAA36464C783D1907E0E93E1603C1D7746C3717F18F7EC78328A4791
      89A6DD281CD8A8DFEF743BB8683C9824D1A46F87BD780001318DC21E5E3EE90D
      ED74D28BC6131B8D4D6F1C459D68329DF606DD51348D2761CF8C87430C663C88
      E2DE7030E89949AFD31D8DA25E144FFBFD643CB5FDD0F6C7BD30EE269D71388C
      FAD3C93432E3813149D21BF47A788D0DBBE1603C8CCD304EFAE341124F4DBCBD
      351C4DA6936ED77427FD68D435C34E329D2483D084368C7A93FE78329E740678
      D8D40C7B66380EED0873C438C25E3F9ED86967DCEB26D38E19C4BDC4F4279D5E
      14F687E3516F34E9243196D3463186DE8DA3EEC486784AB73FB1FD683AE8C763
      3BECF4C3D1F656D8E9C6C3493FB6D60E93299661607BD34E8831F493FE68604D
      3430837E6732E987FDA833C5C2D9C84C92E9006BD31D616EF8339CF6C6C9B067
      CDA087B7986E140FA711562A9976A761C74E867634C4B674FB4333896DAF93F4
      3AE124EAF6A27ED8D9DEA2C51E26513282D2DAC50BEC284CFAE1D44EA6187E18
      8F86D351144631E61BF626761CF547431B4518463749BA83512719F6133BE9F6
      E37E146118E138115A49887A402F9FA233EC06D6C08CF158F9B003DDBDCBBF84
      4A69C9B8071A8BC6FD5E02BAD2DF274448C9C8106561FC639B4C86618C65EC8E
      63AC3766D60555612712339C76067DDA9E718C0DE9F626E36434E9F5BA610C8A
      B0F83948B6B7226C6BC78421D619CB6D93646CA6FD38B1C64EC2646ABBD381A5
      D5194D8D319D51D4B7BD01082F0A4713DB1D8FFA31883301054F27433330E3DE
      B083E180783A9311DE8B778444C0D1B013774D1FCB14F7BBDDD00C079370D4EF
      4C87DD1E7621994CE2E980AEEA193BE88D0671173BDC897B18D0300EFB8351AF
      371827663CED8EBBC3241E83F22634348B35C3C9E827C3EE08076BDC1F632A76
      929849344D12500DD6288AA67690445DDC9FF4223B1C6053463832D3C1201AE1
      AB114660BA385789ED0FFB610C9A9E8C86C6C483AE8D3BE13004C5C5A32496BD
      F9929D1D85E3E974D41D4D94634C8CE724FC1F3807DE002E31EC25F2FBF656F5
      2FFA7D10E30116FF1F83AFF41C57C164A241DCC1DEF788AB604FC7B1E98EC7D3
      0EB801362304990E86231CFA2834360C138C6CD09F465D33E882BF6045A709E8
      1A27D0F627FDFE38B231E8184726DCDEC27CF00B3632EA8C3BF1C48C86603976
      3221A21E83DF9831F66D129BC1A41B61A3A25164F1CC2E0E989D8E275DAC7838
      98E0A0C5C9600AB2EC0F3136B00AD02028230E8771DCEBC4A370085635EC752D
      F6228E8716E777004201ABC308C6C3B19D6037C1BC4165F81213C186767AFDC9
      DFB3FE03DB4D069D78CC944D5F855DDE81EEE8B6F597DFB7B7CABFFA5DB7E636
      02474926745A46DD41688990FA496712C7606E6138B203BC2D0CA3A83B1D595C
      3F0D31D3413418D88199D811CEC0087B361E8195E1748EC15931A7011D955ED4
      C5BF711F97F7C111E30474807382538697E30C2758AE108761341DF6231CC6B8
      837BFBC3E9140C3D1AC73144400FBCAE87D3D71D82BBDA04CF988287C5E02A49
      140F26D3B149E2A89398E978381960CFB168A0EEE974DCB3FD298EF0D0E03876
      43E812D8594C30A1D3383638C2660481D38D404DFDC160389D0CA6444D3D705B
      0C278E3B493F092793683C1A4F2027FAA36882FD9E1287EE9851371E77FA360E
      7BE0D353BCA113993ED6A937C5F27526899D82DD603020CA9EB5FDD174DCEDE2
      8A1196B50B3A887BA35E8CCF8C8986DD0EE4287805B8D660D223BE3505DBE8D2
      F10A7B1D902838173605D2AD63E83138E98308AC2C1A8D630BE9360ABB584D08
      10DB8308190C200E27639C0748710CBC3F1AC5D3C9086277623B60637D1B8E7B
      908D13D3ED75EC38E90F6C3C1C0D414A36B23D9253BD5E0CD13E81848C9351CF
      80F14E87E32801BF82A887D84CF03AD00BB1CD04EC760A9E687110A7F110CA02
      C41C5610774620756C533C32601526A13975FA83AE01419861BF07D328345182
      63331D8FFB7D030D04F492740D481A843485068133D6EF8589EDD18A4443C8AC
      643222913D1D60CB437C0AB160A3643CC61E42700D423066938CA1BA7470B0A0
      2E6036D809229F6808D505A71C321222648C959D4243C1076085BDC964DAB124
      4026763836713289707EED68DAE94C89BF0FB0FF511FB783CF83A8B09493E1A4
      07E9340139850308A311080CA43DC27E818144638BC38F433898622920F07B50
      729211511118C1B0130DFBD640027427DB5BDD3E4692603BB1B0218ED7C40C49
      CFA04D99DA697F0A5130C1E393E11814D5C38A837D43F6815B4F7ADD31980391
      35CE5A37C12A619146C4F041C5184387F6A3D71925439B60E5C0C3B00436B490
      3C13ECC6600CD1176D6FF52312CF10BE10FEF100C40CFE35819E66A623930C21
      5030F6C4E2B019334D402609CE20586B829B218206D00C93C8E2A48C412C7148
      B74CCDA40B46DB1B929CC44393D84693A48B97F05F7DE841F801C1056131C459
      C0E181DC852A8A83809DE90DE3084410E380744909C44A7526E301D61D1C1863
      8EC199211740E750EF203BB10803C8DA28823AD081501FE2B2514813ED74075D
      D25A41CE10ADE0991D684510C9A490C61816F4AE04CC0A743089A00F455D289A
      7836980A18E82402A31F4DC209348E10DB0D250B63817A37016163F810B8DD21
      A4441C0FB076507B075009921E0E0FB818785407AAF1144C651825064AE008DC
      8734B88985FA38317850D48360EA42178B06E00793B003BD349C803B8F21607A
      1D032DB7076D28EA41B2E09A11EEC17642D4637411E66E8606DA413C05EBC1E6
      C34EEA7631B408FCB40BBE3781A41C76A77D924B6602E1321EF4063131D109CE
      2014D83EE82302AFC624E2FE143C91D45C7088DEC4E05D60A8637AF020EA4169
      8180C4A73888A633C55660D741F3A0AE315669DAC7D806D0DFFA13905ACF1013
      05D181BF41D182FA3B8C2783BEC1818714893B165762CE605A3D702C68A01077
      509521A8A11F74133218A038593ACF4CEE7474A0C9E0FFA0778C1902022C0F96
      217608DA693C8831CE78D2C3C91C4C1363493119803B0D87B00E42884A68B1A0
      8C3E74446B889B8DC0ECA0CD8151437D831A3EED742D9E07531767012BD43590
      CB213609BA23B8237E050F06874BC080C1CB862087C110A77240470DB2016726
      B6A0F86894447D836D0C41E7B6D707CB4A206F401D1836068F531A87A361D8C7
      D900CBB31607A6378A71B412B23C8868128CC0DA0EFE82DE0CE62CDC17BC1B0C
      DA0E31098843C8AC649A402FC280C6119EDD05B3E985781ECECEC08CC6D8B30E
      64DE14EA3A09042885605D9DD076CC18C6437FD485F61EC3F201DD8079E1B4E1
      B949AFDBC701E88C47E048D8BB10DC1A743C8598C1EEE2D8F6E94A5C0A568481
      E289A30426308E8EC1DB600A61FF6263A7237070C8DE292C3AB00F185E098C9F
      90A4361806142E1C408847D0ED3024A3690CD564DAC3E4A085E2A48C3B03C86F
      48A6389C42F7C1E2F47180069D88B4271C26F05868C81023E04EB06470E22197
      C0E4418A1DA80D5879BC3D04C5C643E84444AA60B96030B0B2C89A24D3099ACC
      18C6E5149A5C173CDF0C316FCC634A12298CA3089A7964C96A83AA03856734EA
      8C0CCCEF0EA90160DC43524AA11341264386820118C8769CF7611F2AFA10E713
      0712E40FAD084386A23102010E069D11B4D321E40EAC5028DB93181B07BB119F
      0E2198C0E621CA214E71D620C9F198FE10234860C54239C695B0EC26065A1266
      8895C2E261F85005B02026C4D8E82EB0C11174A8315E078204AF8724B006DBD9
      8550206B608C5315814D0F4638AC7694249304F206662EFE823C854583D5C5EA
      F5A67D03453C26BB115401DD2862860C6507AB0C33113C730055D5D0D9EC0DE9
      F444131CA41174833EB60AF2C6C204C2DEE02B3BC299822207BE341CC77D434C
      12861D2C9C31918D99E2B1138811D2AEC7D0C7418EE0B76318EF63D231B00B64
      D182D59004C4E9EFC160361813A446BF3BC0732DF48FDE146C75046505021CCC
      184A0E8E378C33289413EC1596789AF4C6118C9F01E472B73B8D3B5874327521
      CE30169AB31D42CE82A54C8711160AAA0696BB137530027091DE14EA28B6B93B
      1CF407B0E46163638BB02FD0C94691211D0D36598C730E5D0F9446D639587E0C
      9144EB3E8069073B63DAEFC3160821EF4C0FA405EB044C0ACC3DEC76A0B040C6
      0FC18A62EC4338C6D1200F05966C00AB2D26EDA503B63C4D60190DC1ED3032F0
      14D30D61AD426F20FED009A31E74A5412F84120869158FC75097C19C61F382E3
      60CBA6E4C2216D251C83417641BE90349033EC19814582F58725058B1093C35E
      6220094D9CF444BC12020476E5289E407785B534C0D5D06F7A501AB003A3010C
      DA6E84E5010F84960C1D623C06FFC00723EC3DD49B0856EA10F40B930C821FFB
      82530EF96A6998D0E3608474C7D388E71F879047E4D8C21AC424E26250229870
      046E0E93005C02148B9146DD0EEC9DB09360E2BDE918BCB96FC904242D0AD22D
      B638C05039E8ACC1E68572349A420C827670FEA0B185760833116A2B391D68B9
      A744DA16DC1BDB06DB890E0DEC9E784023001D6082230806EC9849B0175028A0
      F6404B0313C6E24F6363868905EBE91B3C798CF3457635A808063E961C52C140
      671AD10A638F86601C21F8D2184714663C3E0393010D831A307F1232204B10D4
      086C368222051D187623F41A4858DC079507620923C01A7EA9B5D801D39A76A6
      345AB1D243B1347BE34F5B8BA57706B2F1B3967BDD7FC3363C6925381838D1BD
      31B94B9211384868C8E2013DC593092EC2D12143C90EFA300CC9408259DC852D
      12C34C248B6602F50AAC0CFCC04EA7506EC3E9183AE014CA190E556CC1987096
      410D9046B800BAFD143606E4D4045A27744018E2900093693CED431484589A09
      18C008FCD5C65DA8305318BCBDC9800CB2014C1FBCAD0F357C8C43D78340850A
      0E1D055AF920818E84030503D3409B82A533E8F54CDF408D87ED16C6105E3044
      706AC1DBC82D0775177A2AA878840D807C8714E962F8439814E4B5C132400F9B
      4C47A04F8849D85FD860A8AB60255019894719723F44386650E60C9DF441048B
      650872028543ED919DABED3E647B2FA672CCBFDFE3FBA9FFAADE606869B7FA83
      3F3706F2067ECA1778D37FFD8E5C53A7C492D23EF7CECFF9A96EFA0F47A5F7A9
      5351F5A1DC7C123E37AACF796F6EFA0F32C98F0ABB70C3B86EF2EC7C6E249FE3
      0C378E04C7F753EB53F5E97E39CFE0910E3BE50A0CFFFFF6AEA6C96DDC88DE5D
      E5FFA063F6902A115F94CAA71D8F5DB3158FD7D99924975C28899AE15A121589
      DAEC54CAFF3D68F043040960D03D4A76B76C6ED95E91FD40F4C303D80D9260FD
      4736B362CBE5346B0F7D79FD0A6E762CCB4D79382EE196C7B65919486795EBA6
      643D4EC39952AE8756AD5E9D5331E045A77F4C67C5BA032B50B5D047756A0947
      A5BEDC0B9D75F21958E87C5F981AC3DF4B2841F3AAADD239A85E97A5C37A1D77
      667067410F037AAC4E75FA00598C8E29A6751D745FE1FA18E4733A014885FE6F
      AA23AC3583490ADE30A3FBBC4E8ED6A9A95383530A388463A239CA60A4D07916
      D3FBD2BACEC64B1DC871DD4B746AB8067B35871E6A3CD4085E9F598735DA73F0
      49E8D0AADE27D4A2DE67EC5867C73A3BD6D9997DBA6CA8B3B91FD49461ED39DB
      1875C23E36B21A97C447367C6423463662642347367264A34636CAD8CC34E3C0
      E8A26EA7F69739A65B422D856D31D8A7EDB4161A4DC28321BBEA583D6DF2E33F
      37C7D5B12AB6D9AF3C55F063532E3FE7AB55BE9E9A43F9B6A8EF44B67BEA9B94
      F01C78BBE75FF503A2EDCFFDA1280F45F5A47FCFE7FF3917597F7E71D2432493
      BEFD7472B69D4E3E9AA57FDF78ADE796F5635E3FEC90BC79FDCAAE768D3A573A
      F157C05D247B73E102F9A50B1497775A5EBA8EEAD205A697777A76E93ACEA30A
      6C5185EE62BF462BD846C589D4C6C4E9D0C6080246923C8A138C8D490998B846
      B731F3488F5A75705B1E55B9D4CDFCC202E25A3C50007FB913716A08141037CC
      040A502F77224E348102E214142800374CD417C6C90F3B58AC04D9B5D66559ED
      CAAA7ECA1E75D66CA771CD12A4582C0C87F90105818A6A0865E068065FFA58CE
      A555EA32334F60A1AA5F7FE6BD5C4FD6C5C3E9901F918EE4BB5FF24DB9EF1665
      449DBB031FF2EA74C0D5BBD347F7460D5524E70270AE9B173CEA350050A7DE67
      0F249C8E6B5FE0708B365D02E7682791EC543D82EE8A1CD7CEDB6C792871AA2C
      3354EF68711F8A23D63B804CAE4E9B4D8E1B2A0CEE23BE190D0E17041948EC45
      D002E182200389BBD039D8A338D52049BE3558828B0D92E069DDDE144F1B24C9
      D3064BF0B4414A7F729AD8B9EC7D516D7003CBDB4D092F5122FDBA2B1E7619AC
      718D8A48EC32AE9BCF4CC30B310F876CFF38795FEE709DF8AA5C3D4DEEB15142
      87A28536A665601DF56277C2716D21292AECB0B88CCAC6C626F16E34AED7DD36
      9F48BB3907666E190FE4755A546825DF659B531D13201DBCCE2ADC99CE027A6F
      96556964F4F222909AF80811C14D739DC5F97C3E3FEE94671C4E82C33E473E6D
      03C70EC457F03FF8A1E2E60996212B769F51A8F725AC8598AF6CB453F88CD91A
      AE604184C63737C01EF0DF6DF78FD9B1C00574EDBB3593DB6C8F027E82F7CFF0
      2CBEFBF3163E0B7ABE68E0DAEEE6FEF6C3E4BEDC430C0BEBD9E15A10C057F0DA
      F396846F92E03FFD235F7C873FF1F73A72DE3D6D290E7F4FC8C80CF06D811CCE
      6A54B922A0AEBB45C8292EFE257F5A94D961853FEF279D4599CE51E504F45D06
      6FD8E271F00EEFBF752744CF1718F4DFB34301A91835D13D9E163FE74B5CCFFB
      58D6391506F363FDEA647DDDC74E125B60DC186F41715797FB7A39E5029A3572
      C2D30965486F2D30A5CA6FCD122EB193B46E2C8E651B8BBD8CDA685C46D360E1
      2E357C5F87E4720B26F9DC82894E979BD37677A4D6DB6089D5365892BC1A2C36
      E4B7D1B890BFC6C2726924AA0C90C29301D29AD64029623640323DB81B4F3D60
      EC1D4907147713AA063617022290D296A419B31E94D29684D9B31E90D2960648
      6B4B03A5B425BF6E3EEB4D1BC87A704ABBF6E0D4417857E5DB7D79C80E4F84F3
      BFDBE40F193253AF919F0EE51A961B83B5C728F1C5695199D084145FD4600AE1
      3A6B21B533E090193AACFF5F36C961EDA5E746E47934729EA0976B2EF3C77203
      AB947519A77BF26818F2DEEDB3657BEBA1355276DEFCC12C1A76F778BE47D119
      260EC32E88EEAC98C3CAF864FBAEB865779BAF8AD3B63D6FD3349DAD08D932DB
      56BA6C7B237567A8BC868312539761EF3ADE19CEBC866CE8FDDC6BCAAD3253BB
      75AEB3C3E731E7A9DD325D3CE76AC594B96DC78572B761A7CF1801E93C7F09F3
      29C9D07F9F96CE80285179CCC3DAF280C222F380026A1BFAEEEBCF3FE5BF14C7
      F6F6B6FB76B818B87FECDD1C084CA1D922FBEBA96CE63FDC27B19BF1077D3DD9
      1DF31E2AA6E378DB3BD0873CCC063A930711E8536E84AF7379ACC3BDCCE77AA8
      C3794E14E8791ED723BA208B1BCC3DE6CF75C0D10017D70519A50BC60FF81E44
      848047FE440898A105CCD002662801338A8087AEC70898A105CCD002E6380173
      9C80394DC09C22608E1630470B78E44F8480395AC01C2DE0B8F0C6631D27E0A1
      EB3102E6680173B480054EC00227604113B0A00858A0052CD0021EF913216081
      16B0400B58A0042C28021EBA1E23608116B0400B58E2042C71029634014B8A80
      255AC0122DE0913F11029668014BB480254AC09222E0A1EB31029668014BB480
      154EC00A27604513B0A20858A105ACD0021EF91321608516B0420B58A104AC28
      021EBA1E23608516B00A4CDDD93C34339DD6432DEE9CDFF6AFCDE23B60E0011A
      9EB84EF993F554B61BC89CE78C41DA245D95E567C4939A5D29B62EAF8AC5A628
      CDDCC8D34BDE501BCECEFEF8B67BA4AC6F2646B3B3F0249099CAB59374C1BC86
      763224B8D7D00E3A85F01A0E430821BDA6F6302AECEE64E4DADE5AD1039E6DAB
      7CB689CB3AF5590FDC9FF9EC06DECF7D7643E7A5D72769C60BAB5899F88C55D7
      8B6D00F3015237E059DADC933C01FE7C734F012A3DE7F073EA063C47AD0715C1
      B1CFA718BA3DCEC5F2CEB0BC470BD837C712C13B23F1CEC8BC33B4C8BDCEC5F2
      CEB1BC732CEFD123886F2E2196774EE69D9379E734B58F2E15CFF32EB0BC0B2C
      EF82A4F6D1C08FE05D90791734DE2556EDC3AC2A827789E55D92789764B50F7D
      C2F02E69BC2B2CEF0AABF661F610C1BB22F1AEC8BC2BB2DA47CED9BC9B8C283A
      08EC5907AFA13DBBE010DEB30B8E203DBB26040C0E1C3DF3B820B007880B02C7
      B44505817DFE3C003F91DEA8D1CF6954103822372A087472EC414690ED752E96
      F76010E8E23D5AC01EC0F3AC0F03AB58DE83416090F7601018E49DD1D43E8CB7
      22780F06812EDEA347104F4816C9FA287444F01E0C0283BC0783403FEF02ABF6
      51D4F83CEFC120D0C53B6E08F7A010AC8FC24704EFC120D0CF7B300874F12EB1
      6A1F458DCFF31E0C02BDBC0783C020EF92ACF69173B1BC07834017EFC120D0C5
      BBC2AA7D1858C5F21E0C0283BC0783C020EFB8A7BA6F3504FF26DCDD16BE4746
      7BD1F4263B3E56196E8D8DBFED0EF9B1DCC0370EDB0AE3ABFB016AFAC57C630B
      3EAF75ACE08390D3C4AC52095F5962CDFA99CDDA9A023ED463D672E48CE5928B
      44CEE44CACC452C27A978912F52A985CC18A94CE4DD525AFA6CB7592E4D32C59
      24499627FE7539EB8DC397277491EB7CBD36EB74FAD6144D06FF0E0E007EDDAD
      173BFEDDEDFF1F6EB00EFAD7BB7DF3FEEBDD1CDEAF9A7FF3FF6F4D7E8BED5BDB
      7FBDDB37EFC39BD491865AD77F5231358187D05188CAEBDFA9DE91CE9F8B12E8
      9B59A35CFAAFFBD3A5CA56F3D96CCED6C90A3E2BA2A4AEA998CE156732C9A5AF
      DC7CAA56AF5FCD13F8A0A10E94E434F1451CBF97CDCB0071D351E41F6CBB2403
      7F3CEF61BB140304EF9BDCA3DDBE7CF92FBA2B58C8}
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
