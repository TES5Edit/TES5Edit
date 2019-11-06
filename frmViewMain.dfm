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
      789CECBDF973E3469620FCBB22F43F2038FB4549DD928AE04DCF74EFAA74D8DA
      AEAB4B2A7BF6331D1B209124D102011A0025B11DF5BFEF3B3213098A50E9A0AA
      28337BC6450A0412992F5FBEFBF8A3976443B7E7F962187AD1C8ADD69A3D2F4A
      03FA67301DB9B566AD371BF01DC3BADBACB67BF8ADDA4BB3743CF4FB83315E6C
      F29F61CC7FB6F8CF7150F8B31FE8E7F15DF56AC755DF8702DEDCE965633111FA
      37FDD7E2AF83B4FA476F184759D60FE14BB50743FB81D31B26F1C48B7AC3C1D8
      4B5291C1F569F27BED8FDE5F7A532F8A53E1546BF07FAD6ABDDAAC36E0BF1A7C
      6B7CB908262275DE8B6BE7133EFE9F5F60C89A1E7212FB22591CD32D8ED98671
      BA34368ED980318FE25912880447FDCF2FDB5B3062BD6492B5DB9304705661C1
      F05F1B268B83B6BF9CCF27FD38A4B9B9F97AA320BC7BA05BFFFBF24B108D7CF8
      2F95F3721B251373EBADE5F05B18F5CBC77730DCDBE033DE37F4C2CCE9BDEAB7
      7BAFDA75F8ACF55EF9F0E9757BAF865EEFD5A0D97B25BA5F6819F5B2172FDD36
      DC2EDE36DCBE1A82D89BF493C073DE79D958C1B8AD874CAF8334BD7BC821ED56
      8D06574386018C49D36BD41F84027D9857B738581CA571E8A5BC6770AC1E30B5
      BE4424FE0FD0F4CBB918C5C2F97CA676AD55864FF7DEB6FFA5F68D2618C220FF
      8A931E1DF1551F289AB2DF37DEE07E27A41B07C6246A0FC396FA726C71DE06A3
      712617D937C72FDBA227D025D8A62052E33FE8003D609BF23734BFDF36E59368
      ADE850AB0DCA476EAF7E831ADD4E19A1AF77785867E139E7E8443EDA2D7B14B7
      7AF9A3F3442EEC8E33D5724B9EFE3111E292DE6D1E86C5A76B254F5FCC12F96C
      292D6AB74B9EDDF949F41371BD2B0728E541ED3298ED1C265E3F18ECEAD597A2
      6AA75532C41BC0C7602067D02A5D7EBD6C063F07228B3CB828E432DC4E19CB50
      7BEF3A8660A0F6BDE9764B9F931BBFF05CBEE935B7EC51B5EBC5478D1DAF95CA
      386ACB8B8FEAEDAE957246B5DFC5078B7B5D6B943FBD0C488B1B6D30D2C5E7E5
      4E179F3777B9D62A5F727DD9BB17B7B8D5F80A6B7414C1737E1169066F7808E1
      A30576EA5F2720A6E8A3B0A853FF3AF5283E37E7FDEC34BE4E380A0FE638D469
      7C9D6A141E251CE26536BE7E600B8F1AFBD8697CFDB4169EBDB58F9D56A784A9
      984066F6AEE0DBEA963D62C0573EA20F68A7ED963C6502979F32E0DA2E134D4C
      B8F253EA5876DAF5B267341556CF144E64A7DD287D7011160B87B1D32E936ACD
      4DE447CDFD6B97B17473FFE41B17B7AE5BBB179565D95B6D5EB7762F12AB1ED2
      DBD7ADDF8BBECAE7F20DECD6EF455CE5736A0BBBF57BD136F99401D06EFD5E84
      4D3E580429AB13EDC6D70F8452411450E1A1AF1F89FC21496EDC76F3EB47423F
      9583149EFBFAA1D0CFE584069EFBFAC1D0CF154E063CFAF5A3913FAACF063FFA
      F5A3A11F35B6121EFCFAE1C8DF797B2B6B6EFD6B3CEA7F2D32A9DB1AE0A385D8
      C2284F9167CD81DCA788B685811E2FE51686798AC07B7B754F917E17C77A9218
      5C18E9A912F12DA5BFF69CB2D3826E5FBB3F7F27F55DA16F618CFB337C398646
      5E7398FAFD25001E2647DDC230F71709781885B88541EE2F23F0200B685B18EB
      FE62831CCB44DAC248F79722782403650BE3DC5FAC9033BA8DB0A601E71E9278
      09152C8CF2482AB830CC3DA4F4121A786B5DF790DACBA860619827AAFD85B19E
      6C01288CF6242A581869057601D366D7781C4A299E918FF378A43287693E91B1
      E6033D12A56E2DACF944A42A8CF574C69A8FF57894BABDC615209569A66D3D3F
      63CDDFF530C559718DFCF9076AD10B8F3F4A9D2E0CF040CDFAD6021EAB6617C6
      788CC6BD38C6C355EFDB6B79821E6E1AD2DB4F6194F9284F5117CC813A4FA16A
      85819EC428F3619EAC2E14467B22552B8CF55446998FF4549A460B1DC4619C64
      FDF03F7B89F0ABBD11EC4A54EDF5C399A8DEBE546B36CD8BF0E75D977900FC6B
      C9100B9717EE2D19A2E4853C845BEB9817E1CFBB2E57FF737B0B2FE3DF4B0659
      B85C2D5ECC07597A590FD2ADC91FE00BFDD0ADDD0BCE55DCECBF60A4C6603C45
      5251ABF530D0A3E749F71C8679E83F302244FED174D483536FEAC00A7F0F9D5E
      18547B09FC977A2EF0AD34AC35BBF0EF6416666EEF3AF0075938F592DE75E24D
      E1390F2EF7BC74EA85D3B1875FA2D904389737CBE29EE7FF6B9666090AF23020
      CC35C47F82CC9B569D2FBD28FE1DB02E9EC49970FEE8A5D93C14E95888EC8F6F
      37895E9285008BE1207571F19E74397A04404F45DBC064B2846FAB2AE0AA0018
      23F68500FE3578F706A324F0E9B1686A8C104D710CA79746E22683B7A4BF0FE3
      64E201FF4FA74910274136AF3AEFF1124698C05C53B708A6BE5B2560E1BF7D5C
      B80B7FF1E783C015CF32009008C59508ABF7065ECFEBC30AAB0839909F4B20D7
      EFD1AFCB607709220F0840A01EDE0D1F5C78DF4B851F4755092C78790AB3BA74
      9B4BA1D67510B5923400AAD0AA755B55672C3C8CAE715C3C3469EDF9C1E83E06
      8C008A1C8CB0EC4540C2EFCB00F935F45A005E4D01AFF540E0D52416D69F1F7C
      B5C780AFD6BE0B0BE1D787036F09EED515F8DA0F045F9D09364C1A86F27C3FC8
      822B0177A762128C03DF1711FC318BE0AB98C11B8D315DE79841E77CF4126F04
      A01C3BA77194D18030C52C755DF82789AFFD5E960CB3F497C0CFC66FEAF0C714
      5E14BAD58EFC9AE45F87A1FA7D98E96F7DFD2DC16F83FED403DA0B5F86FCA50F
      2B0736C49FD97C2AE0AEF44A2419881FF0AD9FF889FA0CE5675F7E26F2D31F85
      FA9BBA36969F57CED7F800ACF65938C1DAF001D7BD0325B6B7981D38175E3F14
      1A9F9A263E9551E85B27A2CAA45993E19C522082328EE3673CB82C60E36D0CFF
      495157E708A44B3DADD6D7A7856F5D322DB86C9C3C3D9DDAC3A6532B4EA7FDF5
      E9D4DA4BA783976F4DA6FEB0C9D4D564888F779E87843E00DB79BD8D3B30BDB1
      1A7AE9760AF2CC227C26691C291187F7A95BBA4FC36A7192B3B03718D616F6A6
      9C9C2E6C0C50AF043752BDB8567DD88BDDDA2D24BDEFBB4FE3308CAF855F9843
      5A7B26F16E655801CB7D245EDC1642EE22738BE092446FE717D1DFD5BB552BDF
      AD1AAD6261CF30789C2E3E6AC7B6B77EBA78F7D6398A7DC17B551482F2FDC86E
      BA6E0BFE753BF51A7CD4D0859FDDD45BAD067C349A1D609E37CD46176F69355C
      BCA55DC720FA9B4EADD1E0A7F116D8F4360D53ED76F126D7ED22E7BE01B5B186
      B7B9F57683EE6BB49AAD152381045FB92C2A41B9123C50E254ADF190B38B7BF1
      31112C7D65C2D758D17824562C653705125F98DB57A653603CB572F61CDC262D
      C10282DE96306BB789E8C904363C0D52FDCA72D6BBF0BEC5759713EA69B89F93
      CA725EBAB89EFB8F3ED0A377EEE6D40B3CFAEB00ABDD7ADD7996C4D1489AB7FE
      026721CD3214A9FEA0AFFCB7984C432F1381BFDFA9D65AED6ED7EDF0CFA4A1F4
      E8DF6838004AA0BE46EAFBBF0655F52592DF8644F2E51F69E681C80C0235FF35
      F50642FE0262B588B2EA1FFC570627A4F7AAEAF666FBF5AE5B77FE278288DF36
      9BF445021B4E292C293BF13DC2E860BFDEC2E3DD868BFF1AC8A5219DA9D1A187
      0F8796FD7D96122F5B42AD64096EA3515C035D8091F113CD588F5803D2B23B56
      7105338DE02BE0DE8376A7D65DBE3B6EB5646D3524F4E6DAE802BC023F1FB9B6
      3B5686CBFE766BEB7416D68617706DF0B9FAB595AE4CEDF52AD706FF16D74617
      E015F8F90DD756B63258F3A3D7D6A82FD00CBA002FC1CF3558DB575686F269E9
      DA3045A4B036BA002FC1CFF55FDB5D2B6BB710D30B6B6B332DC1CF17BDB65663
      8192D00578057EE67C0CFD550E0C84DF031F59B5DB6DB6BF2C67E76EBB5573DD
      66AB597B69FC7C61974D8EBE167BFC4CCC5D91F19783B6AB63EE6AED6BB4B66F
      CBDCBFA9E0B22ECCFD3904977567EE4F115C5E3873BF5B70692FD0923F15735F
      606945F6BE8CB9BB587FA1D36E764BB83B68F8B546AD516DBC00E68EFB7E1F75
      7D2DF67895CCFD39EC0F2F87B9E73C7DFDD6F6DCCC5DADFD3BACED7B3277BDEC
      675A9B65EE6B4B492C737F08736F771A35B7EA2E67EE6EBBEBA21FC96D59E66E
      99BB65EE96B95BE6BE0604C43277CBDCEFC3DCEBF56ACB6DBB259ABBDBC2ECE5
      6EBDF112DCEC96B9BF44B4B5CCDD3277CBDC2D73B7CC7DF5CCBDD169D55BF56E
      B3C42CDFEAD43AAD4EBD6D99BB65EE96B95BE66E99FB3A1010CBDC2D73BF0773
      470ADA69D75B8DB288BA6AA3D375B1DE90E5EE96BB5BEE6EB9BBE5EE6B40402C
      77B7DCFD3EDCBDD3C04DEDD4CAB83BFCAFD9A9B95DABBB5BEE6EB9BBE5EE96BB
      AF0301B1DCDD72F77B70F77AADDE6D57BB8D6A0977AF57D1ED5E6FDA90BAA72F
      C5E6BFD9FCB755E39ECD7FB3FCDCF273CBCF353F6F565B9D4EAB592FB5C5B7BB
      DD76BD51AB5A86BEDA4DB6DABAD5D6ADB66EB575CBDD2D777F3EEE5EABB5DAED
      6A59185DB3DAC52ED775CBDC2D73B7CCDD3277CBDCD7818058E66E99FB7D987B
      AB5EADD560E925CCBDE6D6DA5D4C83B3B56B2C77B7DCDD7277CBDDD7818058EE
      6EB9FB7DB87BBBD968755AD5562977AFD7ABD5AAAD4C67B9BBE5EE96BB5BEE6E
      B9BBE5EE2F86BB63CFA666A3DA29E1EE6EB5596FD79BAECD80B3CCDD3277CBDC
      2D735F0B026299BB65EEF761EE4DB751EBD46A256567F7DD66A3DEEC346C4C9D
      E5EE96BB5BEE6EB9BBE5EE96BBBF18EEDEAA0177AFC3FF9770F76EBBE1D69AB5
      964D6FB7CCDD3277CBDC2D735F07026299BB65EEF761EE4D0CA8739BE5AA7BAB
      566DBB2FA277BB65EE2F116D2D73B7CCDD3277CBDC2D737F06E6DEA977DA6EAD
      2C60BED5AEBAAD6EB56D23EA2C73B7CCDD3277CBDCD7818058E66E99FB3D983B
      F0EE6EBB51734B7BBD365075EFB46D613ACBDC2D73B7CCDD32F775202096B95B
      E67E1FE65E77BB75B7E196D694EF82DE5EEF74ACEA6EB9BBE5EE96BB5BEEBE16
      04C47277CBDDEFC3DDDBCD7AABD16A754A54F74EBDDDA8575B2D9B0C6799BB65
      EE96B95BE6BE0E04C43277CBDCEFC1DC3BD55AB7D52C6D07E736AB2D60F070CF
      32C05473B8541F0A967B41A206FF550F16A18020820524593818F78683D4757A
      DE90787B98257CC984CB43F9FC5356F5F0CDC625BAF75DE2F20522875FD8F8D2
      EE32DF7195B5A7ADF22B42C07201E7DBAFB2FEC4553E5C1CD01CFE1BAEB2F1B4
      553E423058BA93CFD82F0857D97CDA2A1F21223C045F5721D8E12A5B4F5BE523
      8485159DCA7B8B78B8CAF61357F970B1E1B9690F51BC8555769EB64A92171E28
      4080EE0FE243B34C80A8B7AB6EADD1EAAC3C24FF8102FEFDEC032FC43AC0C2FD
      3335A05B4BB9F74E997E750DE8BECBDABE621D5810ED9EB701DDFA58075EB4C5
      EAC9D68135B6583DBB75E03B5AACBEA775E0B92D568F63EE5D6C3057D6A0A6D1
      6874EAD58EBB02BFFEED4DDF28E6BE28CC59E66E99FB4B5E9B65EE96B95BE6BE
      D6CCBD5BADB5DD6EB5DE2E61EEED16D6C1EBD42C73B7CCDD3277CBDC2D73B7CC
      DD32F717C3DC9B6EA75B6D9455B0AF773BD55AC76D59E66E99BB65EE96B95BE6
      6E99BB65EE2F85B9373B6EA3D56997D5B805ADDEADB5BA0D770515EC2D77B7DC
      DD7277CBDD5FC0DA2C77B7DCFDCFC0DD3B6EADDDE8364BB97BA35A6BD75C7715
      D9F496BB5BEE6EB9BBE5EE2F606D96BB5BEEFE27E0EE2E26DC35DC7A59C65DCD
      6D341BD576A76B7577CBDD2D77B7DCDD7277CBDD2D777F31DCBDD3EED6EADDB2
      6239FB0015C0E8467505756E2D77B7DCDD7277CBDD5FC0DA2C77B7DCFDCFC1DD
      3BED76B55D2F2D74DB68D51B6EB5DAB2CABB65EF96BD5BF66ED9BB65EF96BDBF
      14F60E9CDBADD6DC4E597BD976AD86956E57D1A4C67277CBDD2D77B7DCFD05AC
      CD7277CBDDFF14DCBDD1716B9D46A7BB9CBB77BB55B7D1ECDA5A3696B95BE66E
      99BB65EE96B95BE6FE72987BABDD06D6D92CA954D7AA76DAE875B776F9BBF6F8
      EB0BB185672D3FB7FC7C8DD766F9B9E5E77F0A7EDE71AB8D76A7D958CECFDD4E
      B7556B74BB8D15349DFB133374ABAD5BEE6EB9BBE5EE96BB5BEEBE56DCBDEB36
      9ACD5AABA4F4AC0BB368571B8D8EE5EE776DF2D71762D575CBD02D435FE3B559
      866E19FA9F81A1D79BAE5B6DD63B25EAFA3E96AB018DBE56B5DEF5A79E4DABAF
      5BF66ED9FBCB589B65EF96BDFF39D87BAD85BDE0AA25ECBD59ADD59ACD4ED3BA
      D72D77B7DCDD7277CBDD2D77B7DCFDC570F756A3D56E74AB658DE0DC5ABDDB86
      3B56D0C2DD7277CBDD2D77B7DCFD05ACCD7277CBDDFF0CDC1DD4F23668EF6E99
      69DE6D379A7053D7B5CE76CBDE2D7BB7ECDDB277CBDE2D7B7F29ECBD55EB00C2
      76DD9246AFFBF566AD51AD37BB96BB5BEE6EB9BBE5EE96BB5BEE6EB9FB4BE1EE
      ED6A07E88CDB29E3EE6EBDDDA9B6EAAD9A2D4967D9BB65EF96BD5BF66ED9BB65
      EF2F86BD6317F76EA7556A9BEF745BD57ACDE6C159EE6EB9BBE5EE96BB5BEE6E
      B9FBCBE1EE4DD76DD63ADDB2B8BA864B35696DD0BC65EE96B95BE66E99BB65EE
      96B9BF1CE6DEACB55BDD5A59AF986EAD5EEDB46A756B98B7DCDD7277CBDD2D77
      B7DCDD72F717C3DDDB5DE4F09DB284F79A5BAB55612EB69E8D65EF96BD5BF66E
      D9BB65EF96BDBF18F6DEA9BB55B7D3AE9784D5756BAD46BBDAEE58E66E99BB65
      EE96B95BE66E99BB65EE2F86B9B73020BE595A5CBED3E874302BCE5AE62D77B7
      DCDD7277CBDD2D77B7DCFDC570F76ECB6D82FE5EA2BABB0DB75607EDBD6B8BD5
      59EE6EB9BBE5EE96BB5BEE6EB9FB4BE1EEDD5A135837A8E7657EF76AABD6C6E7
      6D469C65EF96BD5BF66ED9BB65EF96BDBF18F6DE76AB9D56691F19B7D96D8282
      6F63E62D73B7CCDD3277CBDC2D73B7CCFDA530F75AD5EDBA18355F52CCC66D77
      81F7373AB6549DE5EE96BB5BEE6EB9BBE5EE96BBBF1CEEDEEA366BCD7AB356C2
      DDAB6DB7DE6D763B96BB5BEE6EB9BBE5EE96BB5BEE6EB9FB8BE1EE9D7AABEDB6
      DD32EE0EBFB5DD6EA36D33E22C77B7DCDD7277CBDD2D77B7DCFDA57077B7DA6C
      6129DAEE17F8FD2F7435BE124912F802C608C51F854BF22950F56BAD76BBDA2C
      FC388867B0925E98BAFA682F3ED76E365A9D56B5B5FC3925612C3C95CF71F963
      F5E58FB930CB56A751EF56973FD658FE58BD55AFD66A8C144B9E6A2E7FAA5D75
      BBED46CD75718F973DD75AFE1CCEAFDDEDB64B20D95EFE54B3E9366A9D5ACD5D
      FE54A70420D55AB7D570EB9DDAF2C7BACB1FEB566B20DF55EBED92CDAE96EDB6
      5BEDB4BBB57AB7D52979D22D9927563EAE751A9D92FD764BF0046059AD766ACD
      92E5B92578D2EDBA1DB7DB2C5B5E099AB46AB005F506D3F1A50F96604A9E835A
      F25C09A6004090FC966D9E5B822A791F8992E7CA904597B92A79AE5BBAEDBAB6
      75C929AF966D7BC7AD36DA9D66C94C6B65E8526F355AED46B75AF6BE1274C91B
      68953C574657DC2A3CD96E76CB76BE5682321D3C7FCDD21DAC95919676135758
      768A6A65F8A2F5B692E7CA10C66D778090554B684BAD53BAEF3A40BBE4C912FA
      D26A76EA1D986609A2D54BD025F729973C574A5D5A88DAF566C934EB65E8E256
      AB40410149CBF6BD5ECA88EAD5166C4419FB2AA3305844B6EA364B36A25E465F
      00288D26B0BE92E3502FC197BC197CC973EDB28DEF02B586F3D7AC973C584661
      1A1D2084F56ED93E94A04BDED5B684AD9791976AA703224BBB5E721E1AA5E405
      C859B559EF34CAF6BD518231DD260013886F095C1A25E8526F565B9D4EAB0C9C
      8D1274C9BD3025CF95F223953559F25CAB549A03DEDEAE761B65F25509814195
      1DEB2B95E059A3045DBA558CFFAC36CAA659862EBA9ED3F2E79A25E8D2AEBBDD
      3A668C96ED7AB30C5F74F5E792E74AB0A5D900E600FCBD6C9E65C445C7CD963C
      D760C13E1157593F74FEF81C5D46F175F49F7C753A9AD255FCD20BE09F6A2FC8
      BC298E55ED25F05FDA87FF3C8491BA03C9DFF27BF83D69E0E390F405A41C6079
      55FADEEAD401C7DAF4BD5DEB76BB441726132F1B7F4CF8F3348EB27AA337E927
      976F0250ABE497F319BC60924EBC303C4D3C50BC267E904E8FC5D0ED4DC2775E
      32A27B13FDCD17C3FF3D80DFAE136F7A46EA1559C2264194BD0D26F025F29239
      7CC30D0CA261FC47CF9B65E338712EE09F14B435E7241A852221BC8FA722F1B2
      253FFED11B2402D4BA496F9E202FEA4D62D7EDF973B7374E404B9CA095036E42
      B8DF750FA22DEC591AC411CE47F87091349A281E4EBD91489B6DFEE33A4E7C10
      2AEB1DF9E360EC2569A7DDA2FE9FEAEF6B10C76BDC330C068D8097F3AEDC4CC2
      28E59DA6AFAE33CEB2E90FAF5FA783B19878E9C1241824711A0FB383413C791D
      0F87C140BCBEDEDE8297BEAE55ABF5D7F8FA49F8E54B6FEA0144AE81CB801647
      DFC72E6C6DA73701F0870C68F896E86F99FED6A76FA359968904B0274B5231C8
      1C40A7EBC08FAF075912F68659D4FF57CF1391EFC7835E06BB7D3901944EABFC
      7D1827802759108D008A7114670294623F9DA743C01C17601DCEE3E86A12568D
      5F41FD1DF95EE6C19B93218C0ACA7494C180575E18C07501F0707BE938BE9E86
      A0958FE3D047251CCEC1288A1331096E843F80D15149072CBF1241444FDEE05B
      F031F802470E70C3855DB809617AF15C44B02A71334DC74916C1E5192C16B4FE
      41CF8F6013A2B4EFF7E12A990160493358372C2C1D7B70AA01CBFE8D6BF74713
      C267F832A61B5D90C4FDD195F11D6E0D466CDEC55F0A7F8D716A2E3D805FD0C2
      08F3F122BF771588EBCB20F25DFA960EBC50A02D753AEA277E32169E2FBF0EE3
      38EBA5D3709E5D474124706BF4F771368123934E61116134CE3CFF5FB0ACDE2C
      1561D6F7C2A807FFC10578490F1E81370CE0AF6BFA03BE24D928E985119C6D58
      B98021E0DB758274A89746DE348B4740C0826820C210060AE3EB61204238C53E
      0CDF831BA7B36890C182BC34F0F42848551298B1A23891B88601D36C0EBFA6F0
      8E51125FC394E36190E13C2384773607B023D184DF61AE11909B2CED0D05CE4D
      84E20A2E0F6ED22999418050F8B085D7785DE0967AC3019C289CB437A49B6780
      96616F4C7720DC32A0955E027766832B8F4095C164F1A16182F0C00B575E76D3
      BFE95D26D134492391F5061E9C47C0B710C0E820E204701CA75EE6C0B4D83FF0
      97DE35E0F170920D8310CE915303ADF00B9E7FA045B34464E324CE32D8D25E10
      0EE38937F0B24118CDA6282567094CC8E9E1A9F31D75FE808A47E2A6DAC39D17
      C91C349B1EEEBCFC0A33496FF00B803F1A8B44D0D3F8086E125A9D683431F400
      C507B08174801D622D11FC145EC1E19A46B34132C10B6814C3BFD9E8850E9769
      34F6A21132A028BBC93CE740F225F930725F7C1C26FBA8E7EBF00D98E1A39E6D
      C0B7F0FE6FDE2D3EDDBCFF9BFBCECE97B2615A04807B4FE3AEA1DA34D0FD36E2
      AE713AAB9A50F73E13429C5F3A12309F046855E805912371BBF73B1C9A5C2A01
      850D2836FDDBC7B30F64DEE34F603880C5F804CA08127D81A04CBD703AF6F04B
      349BF48674772F9E11C29315B6DA035A374B3320B5E30C5E13917955094D30A0
      67883D200365E160DC1B0E80DF0299A8BBCD6A1B3ED35A0D081B2C0E787593E6
      CE37559117D2AFF863BDDA71E9CB50204FEF8531DCC583B47AE3C0F8C3EFEB3F
      9ABD011E4C7A2E9A1A4344531C0476A530A53E3C56C519353A8579F4FABDA15B
      6BF6F0871E8066DCBB046902182948D1209E98A21D8A1DE69A7F197BD9ABD401
      FAEBC0C6DC9CF841E6340EAA07F5FF89980CF48737EEDB6D99FBA02D2B0350BD
      550220800801E82B6079331B0D419448B7B724185898277B7F8EC89A461711A7
      5A7CB7F2687FE5951A63148254196D8675A7F7AADFEE015FFBB264330AFEF17B
      EFCA820B139FBDC73E85E9F2DDC1C7EFB53FBC39B5C60280786B6A8DAF81E83F
      5AADAEB3EF1C9DBC7DEB0093ADEE559D893777FAC249A7B32488676938773CDF
      17BE93C50E88C0A14FF257EAF8F03350A741283C3C17076BB6AFFFD16A376061
      672CAB3A6717EF52B5B2444CE3248315C1F104D80A67E0A5B0A0EB31A8362886
      3A521B813506C3A148D66D5D2D58D78FE338C5259C9C7F4C1D106A9D77B10F12
      DE6C9AAEDB6C3B30DBC301604CFA731083720080055007A170462242CD92B028
      8E866100BA10B0C16C96167766CD56D4756145BF9E7E68BC3EFDD06EFDE61CC5
      D339AE81CE10EA59307B382B9E33C4450EBC08FE0381DB0136E483B231856B71
      084B4140C07D8490FB224219DB67240486013ACB2CF4A357D9BA2D1E0F15AACC
      FE0CA78BEAA0334CE289FCE6052188E00E08F6B028D45B7D075699CEFAA9F87D
      06620D7C255458BF4D6DC2BA2EE6D31851EF17E14DFF7EFCFEF0DDDF0FA360C2
      280BBF891F9C371ED99C06CEFEDFF13BFFB1664BE9D4702963E180D63476FAF0
      F201DAC45227836B40DFAE91DF21C9E87B834BA73F03751D485D30A4DFAF41FC
      8C417081BBE3D8218BD37A2D0F5431585EE508D90E10742082495A7186A811E3
      36F9B148E1D448EC7360FAEA26646FC3204933070EE39AADC9C5357974329C2B
      834A022D40730C52171F64B96CDDE65DABC2BCAF9318E61727A03C237A39A770
      7008BFDEE217384EEF3E9F5FACDBC45D7946DE5DBC7FE790790567FAE9F0E804
      5067008BC123709D0419DA3BAF033848B32812B8435E3277009F2641C4ACABEA
      F4E7EBB73128D4BDFD70FCA38888032161E6652402241A11A1049781A2E28C91
      6EBFFF0CAC0BB66E1625228DC32BE44540DF80699D823C7476BC5ED47A470B70
      70488E8314B76B17D6AB4451E738F14671D48F93E840A41302C0C4BB8415C520
      4903738AF6BDD108569A7244D2FAAC6C7BAB746D89978E1145DF1FFEFC8E2903
      680C1E1AE21DE18F04A2EB308465C1935ECA97408DB8DC43024F949DC3A740C0
      8A13167DF122DDC7E80F5002BA19C6F1A5339B82F4C272330004F45E2FE4F75E
      051E3D76828FBD85E101891057D60A886520FC5924F37FCE82C1E5F938BE3E92
      02272B05C01EE7247082B283B20B5A8C9D81483234AD28D974BD0E4139AAFC04
      931AC4A8B1EDF0E975FECBE954ABBB92B001239412DA1888340A717035419BE6
      1CB16212A3642789831F234E1089C06D1F61E01CB35344324F7E5F2BB8944105
      7458240D1ED96578918E37C495C0F2F097A94850F9C3F303E205DA9C014C1771
      C599CE32969DE0C9ED2DFD2C9F2A667E61ECF9CC015F042CC85BC34464209597
      08E4BF3E0C09279AD8447A1944484BD76A3DE538EFC73364590338A797F81368
      606284580A62C810762773407C9AA0DB8B24C4FC9007D13E79BD801206E8E364
      31784E6704661CF8B0D3C016411C5B2B4894C1010EB0A665AC3CEFC1FC076847
      86938B1626A99BA5B330534C80F4D4BE40349878C9257310792A66112A76BE1C
      62DD8C773BC378868ACC1CC4E32B11A2A71AA170E10F4F78BB0FDEC2C93C05FD
      F413C835B304F6596F3F4350E93D89FA9DD9601F352518FA25AC96789AF3EBE1
      2C8B7F73582F22A761EAA480F403125217A9F7CE358E4E52114203EE8C52B1FB
      12568B8697DF007325D342DB8214D85903019C4643CC4B584A10FD0B5600876B
      91312365A2C337C5E5F8493C05B4BD8E9C7828E5F145B2B5D18E85EDAD774104
      A45B93A835DAF9EFEE5DA87D67EF42BB5B3496FE7C767E465CF9E3D1BB37F9E1
      05B60C9FFEBA091CA048A3312D9D0D87C10DDB944015929E0F9416035F49506B
      356F0078FDF5E9FB9F7F734E412774AA4846DE7CF8F00F6702DC21752AE78324
      0EC3CA9ACE9974F5CAA75994051301530DA6D9C724462925716ECE4F9C13D049
      23329FBF8D4715C7BBF28270EDB4D04F2C5EB0A8AD901CB6E123C81D40E7CF51
      A722497B380B4336D5C25B33818AC4D0C1238B4C3B481CCC565AAB95A1FA8CD6
      E1300BA6CE18246DB2FAFD1C805E3588C3D92472389266BD28F1394BFB7E8096
      AF21D9BA5296A0CF67FD4F2C411C2689374F379C9902A0002C1100E623BC7322
      B27C27BF05489E008427322B587A3C41AF895A35190EC9132E06C13060AB9987
      D29904D0B587E6A2EB1F1E81E8359AEA9F58F0A83F51F0580EA0C6FD20B4FF3B
      EA4428466BE3DD97FB200B65E0DF135D5049BE35E813679D0EEE35CD87E0F4FA
      61E66A6186E68EAFED3686CA3E1190CFB0DB5776BB1F0E34A42E68C840DFC64B
      D8646F14DA3D7E0CF126675E29E83025694D76F8777B881FB5C17892976CF27A
      1EE3DFBD67DAE54DD5328ED85887017064BF46EB35D9AE3744D5384C2940F086
      5451CF9926713F141354308EBDEB683483C553ECC24E2A848385488230055D24
      2425166E1757189BAB2255779D7F1E1E813A92920387FC9CE1F65668DA1D3C19
      6B48470E741772FAE003B14FBACD9EA35C02BE9041EB5E9A8A09BAD5B2B14885
      1E8CC2FD003E298C22C31D8B760B0C9BC139C432F200E363A443F95A24389027
      031DB5F709A78E4E54E11F4804B81807A9F453B1E2254124E374CB623D76D0B6
      388DD334E8877327861724F48674570DCC6B0BD0ED71EDC411DC95C32C879801
      197CF96AC949618B9F87AE10F8FA02BD78F12C519A2CA6F1A1E50F7557B43DD5
      0C6DD76AB14BB4D8C677D562DFC74816DF017ABE93B8B87A2D164909F9C5F114
      E4384F879C7DC2DE741A061CFFFFBD8FC18356B6C3D40397201DDDE7F12C748E
      BC2089A45DD617E92009FAB03822AD8F7180BE30D1EB344E06A21CA356227D85
      D7DE3C9568B388578044B813052EB4C33EF884D98017CDB331F9AC63BE6DF73B
      894A0FCB74BB675E19AC65F59965B5CDCE2CFB47BC7F1AE8C8943FBDE4A82239
      41DC9AA514D89E62CC0E0B926892868393CEA6E47E621C9151071810437C1F05
      B3598A67ECA39725228ED023FB1A9EFFE8CD3F7AA19294CEB49824052AF1F5A1
      9D3EC85C2056C1ADC14490A7770242C718C42C3F8E28AE3DA53052DAB43D74DA
      2718B3EA0732049132670609C63580D4021BC91345684F059666707660A23802
      4F76178FC2E1E7FF91CB8D82C786DF392C164D45F00615BBCA3F72DA83620C59
      3C75683731163262D8E2F509C67FA29FF760A30FD8F6D68F2024261F630172C2
      CF812FE24DF1081D12B1ADF09A2B0A6BC61ECAD6A0857062E443918864F3EB00
      B48D788A8338FF279E5DCC403C0739638E92079F243E60D2F93400FCC5396010
      51BE199B8D9636A378B9D2D2FCCE313FF5868ED393B5969C8F0284C013503EE7
      D3182306DC667BADF60C268D59B5872A483CA5A813D082BC11B136E24AFF9C89
      14E5AF9FDF1D1EAB2C21956F369B62251D3668C8878EB000152757ACD55ACB62
      8799DE246222A8CEAEB3338BAED11E077786F35D1528ABA9199B9B82289804FF
      361257C992E3010D1B84316655A304008A18669D481B10A6F8AE57444B795CF9
      2FCA4A9562F02C692B40BB39243ABB0E061CC31318F7A4801791BFE7042ACA9A
      AD6F910EBAC73112117913C4B4034E9B45031525CA8E6719467AAE1574CA60F3
      2B056B7D8E66680894E910222233E09B77C7179C4017472314FDC4308838AEFC
      CA4B024A2F4B016D9C1DCE73563A23F0C03A9B0B77D78CA897A3C8511C86DE94
      845458B9240B88EF287EEE1070E86C7002CA6B0A22C42F187DC421F7949EBA4B
      36BA598431CC3AF3284806B3099C174AD7CB83F631C23B05D13F93E80464552A
      CCA94AD52154C5F614EB9591520EC6CAB11053CAA5472CF9208BF855F278FDC1
      580C2E4D8BF600D6EE3B5CF480418CC96B32325367FD12C989049B1E00BF742D
      0B12D950F958AF14FB3B2911EB42AB35099D4588495FFE0028AC520C702EC55C
      49C6181B481431E0AD34D549AC8C709425217E1F86C1941EA89CC68319193A74
      F5119DBF0363E27815109EB3979296F3EBF9F9C96FCEF1E1C521951738BCF884
      A060D2B9560BB883134ABB016CCF44ECD12E05032A1C50A2FD50D6A0E7F443AA
      3200FFE04905F6B00327121347B1D85FF51AFE9DFB753AB14CB66E5E4416CA39
      6747ADF624B2197CD5E71020BBF269AE3EA645CA40CA3A7572FE8ED2990931E0
      F0B0FD670A58F9818B0A688FA3723692BF12D8C3EFB300F39B7774C65386354A
      53637CE9CE143A8A5C19AC75D21BBCFD4560E16AF715949F77CC347776578F86
      CA03E9E5DE478C6C970C5A653E71D2B94CB1A52D7B09FB8036C7085067C4753B
      00E3045616E59211224D41E4053E46020C32401F857DD2A626AC4E1999791C9B
      BE8EA94C65F9781727E7CDD7C4DF7E21C90C56F631BEE64CBCF39F3E7C96A58C
      687B51FE0A8351B476D91AE5C98632278542C3910845230365B3C48B5290B249
      A151386C9461486783F14B5B276815A76FCF2FD4B6C196F941CAC5A9E831323E
      BD84451DCFA6613040AB4CE508550550BA01392BCE8F9F3E7F4CD5F26416B047
      554186B093A154D40D16C3BA569EE3B599D6D6ED2DA9E902221CC5911F902F67
      43FC00CB964E9E31ACC31EA2CF6D4CD135FC13C75B092F45B28FD14E441FA88E
      F120735CF4485125AE8997290BBE312CD3114AA692EFCCCFDD81731849C567D1
      0B81EE720EEF81C9041BEE1AC8774C2675B1C4F14644C07D1C55FCC5F9980431
      C88F7384F07181B2FDD9119A1D5B1F18932A8F055665110977E49229B0334B66
      4287DD494B2AA8BD127DE11B9C86E00A9449F3ADDE9217A2459127435EB33E96
      E680C302A2E43C3F259B8EF0EFBC6806DCEB480546AA92784C507C314D043243
      7F4310BC1C1C3BAF0EA753C09C532E1F8FF2B6BAEBD59EF3EA73C4A5F6C87371
      CCA28FF349574D835BF087579FB8C060E50CAB75839811820E0B38CF1A5445D9
      295F11F0D14E12F802F5D2B89FC634BAD244B1544D02FA0E972F044C7FC5F53C
      30F28FE7F50AF5219E0EA1BF8E5BA502369E33410D63840A2D895F5CEE236700
      EF622A65C3EC86D4DD3E6AD88B6F510A1ACB52813CAB32E2E83DD00A3F1ECCC8
      17B68355A230B06E1A92CB1A6DD3143EB747C63CF284080F364DC37C77D3CFE6
      AF587BEC370973CA44D6F5C7F696D46F6114A3BD415F3F555AC334652CF22B36
      45E4BA202B4D0AAB9E288D991C9474181059F11CA042C9056555A01015EA42A0
      C9E80B7123481CF3A568264DCEF0EB54873EEBC08C586130FC4B6FDD73E6F18C
      DE462E3BC66EACAF77303A784CC0F49F38EAA0F55DA30EF0802D3D5F3FDCCF4A
      8691C5F7B49381AE8C88B8BC9CE001E0DB8A8DA3ABB7E05E9C9C376809FF3C3F
      E209AFD8DAB75627E30958716F886E6F9D9F9F20485F2E463469FA0A21561C8C
      BF8608918B3EAB4686D3F73F6B54D0796D08D6EDADB54784D30F4419FE79787F
      3C780816AC211E3C0B0A280A4BAFD0FBFF029C7B8A8C6DC0F617E5EB9513013E
      48F8127C07BEE285A0809AF98F6F9F1307364D7DD1AABB2C3B4B9AC42FDC6DE1
      C89B2AED1FAFBE439F20FFB487FA0AD54303CD477829277708C12E288ED8D426
      386A21C6F1E89880C1A3294D66D355703AED580D960C3EB775EE8D404B745497
      128BC59A1A0F29C982B9DBAB966DB47EAE4C53144B99C5234159DD64405BB56E
      7767698A35A4D5CF5A2BE5B6818433C23234E5ABC806A64894A4C25E3019BCC1
      A1DEDA87AC123EE348BACA2613B47121995083934DE579C41964648B7B9B23AE
      0CDE7FBE64FCCDA4B944714F6E826C4378FE05B708781E022B008EAB0FBABB0F
      89F58C7C53EE87874E00166A76F0CC2E356073EF993D87CBB7EE2291A0805059
      59046E456FC4805D789829229B312071E086E3D247380CA2201D6FBA7BEF04F3
      02D0C7B41127697BEB8CFDBB3AD91865360983059773B1AC8B446336D63F43C9
      0A3907C5539E413E5042FCF3883782E7BFEA79C38E6852A236E4D0E1D43F55DA
      68304B90726097191941170CF59E62D618465C7174A854604087971E4B901448
      E8A0841687FB0A524A5E4E90F4CD04B8F34C78933DFEC853488C24BD448C0240
      EE79EE87E5AA0A34051E886A32E3AB19B554E8C18CA217295D015434B58257A9
      738CB590F0A1836F7A4CD78F586D6F9D62038A59E6B45B1B42AF8E31C14DC66F
      119F2302C5F8C6A83A18703A2885160E12D0E5B96683EE368B58EF1E540F1A84
      73F8AD89D834185BDDFD5CA6CA810472F6FEF4830AAED808DCFAA8CB9E21A1A2
      E5ABCCC1EDAD1CD530119EBB7A166EC120AB82ACA5FACCE621855C380468DB88
      C2F1AFA9100FCA685CBFE7C0D9B9A04B3A8C3B99D048116048420E789D5E97CD
      12CA018E87430E61C00B323903AE493FBACA62E48C0CAE31A53A2D7291383695
      2DB629521D5F6881B2D916E7FD5141B9FE3CEF7223A21186586264CF3F0E542A
      C79B3C07E92C1AC63F1470C9E1C6874216DDFF8859263BBACC1EDEB99BB74E54
      D9AE939893C355C328AE60B727B399A8872AB6CCBE343AAC31EF91E3F8E6149C
      09D6CECB77940783EF309A38C0D8046F300E044D3148F7164E8299E228EBDA23
      C9497C99186A2C8B475C047C4CFB615651A1507006F642C0690A98917197E38A
      BEABA283FF70B00B8CFD231CA89CE2764E82940BCEC00C8A7702AF4805D93901
      DCA9486402AB867D5EC48E8A07E6B3429901110CAD0A805C3946EF9AAB589697
      419123F901408B2C7778A3710779B0B8737C76F8D6CC3925F584FA0CC17FC195
      2A946640F7CA0B67A819E98470BE9D105B230A2C3956A1C32CEF1CFD43493979
      1F232EC8A81F02414A46BA18A8BE6B06AACB8DDFDE821BB851D001171B51C937
      94566246CA60C4B0B801754E4433659B912D860ABD1C94693A8766AAC1A9A08D
      4162B9C9C8C0E425F1C96896CEAE63895900AE98137E09250154445B727C139A
      08A807AE391D56F8BBAB3619ED23862122ACDC09BEB7EA99BE8F1F34D795CFF4
      219A0752013C202B9F291E9B95C3F5ABB37DAC5175D345394CDFFCCC6A180633
      6E8408C7AB96967327C5FC37E05BE4A0F38CFE756637464975330EBF95563987
      6A43A1A826A9A54FB24FCE9CC4641AC342E6200E600FBC9C93C92209C61B0EA4
      2D5F27CC92854566DD8E6465461260A89760C1108392093110F53E3D8938DAF7
      0519F66F4B6307CAF617A2B8365FB4016A090925127833816CE9A4D411325049
      C784E6264CE43FDB5BCAE0884D966EBD12138305BFC8684446BC59C9C411F0C4
      DB1320C1623A4BA668B764314FC187FBCBAA14878872974F581A3DC55A55DA9F
      ABA1431E087C17431C0D21B20729C93B322DF4C0399D256494BD1DCA9D192C5E
      876FD38BB7B78C571B525122B814034ACE691E14BB0851980886BF82F081258E
      46B194253946D6CB747CF7B2851A31B5C94C15AB84FB16DE9107D88A809627E3
      6C836CF5C63B9862FEF667896DD0063CAA84A42C4B2BE64EF91A9ECDE39ADBF0
      CC2CA143CE93A71A331F488EFF7AF68F91F7F3E156DE8F6158A353CF679144BB
      9433F1510B5C72FE768C6A1472DC3DF508A7722E3EC46FA12A0254971CDFA435
      439A236029E9AAB710D44C5A524640A577B06D5297845285A0449651A2F0A24A
      2547D1673519F020B940BE625CE12DC366731F562F7BDDC6974D956A0EFAA9F7
      FAA0EFD59C9FB0A7FAB74D15FE7E82CD42854A6C3A4F9C734990DBD32A8E0078
      578CBBAF575C1305F67EF5A17D9ABC62EA30668D513A31A55CF9397B61B0A319
      62B56B7A737E080FAD5C0B2E5441658B04B28FB420625E9C9CD7575DB666F548
      040C1FF3DC809791DC762D803978C585902029738FBCD041630B8AFE2CC271B1
      8FD30F6CF2C706B9FA86E740CFE75ABB111DC4C23309BA2956CC08D274A68DCA
      AAACDDDAEF2BF26DD01D547C036C49E2395731B50EE542731E362E18516619FB
      180BB62A907E3EC6A0AC8D152E3777E19472B909A3869F005621526C7C124F65
      253F121E511620D2BAE96CF5E4668A450E59C0DB0C770FD599C1056F6F157D89
      86D31B6572060D08DA5E5FDA895148C5ACE0AB806BEB49E5ED1F68ECC6345EAC
      32ED1CC2313C463D6ED351EB7C0CEFA66291E75321FC3754D87B3350EC032B29
      95CF67CEB954542A88477B845ADB5BD74E85A15300CDBDAB9C5794A2B710A763
      2A408134B3E8D6DDB98FCFF447F0C85C749D1D91543910CD2D8BC50383C934A1
      BAAA9C538FE212FAE6C84CA2F5BC73C0C141A612E40B3A5DC2E9FC34074FFA18
      946BC7F9498453E7B5AC7C0F5FDE8B9B59FA2EF6F1FB8F41F6D3AC0F5F64AD44
      F8A69A2ABC96BD065ECB56057A25B6A1897C4759431377B31B9AD8C2F6CB53CC
      DBDF35C57C7BEB3F5A6EC7D977EA077512D81153ABCE1048185945D966A4CCC8
      DCA50ED51B599178E29C1D8344D94F8477C95119FB89E0D05AB8630F485E82B7
      AE57E149587117EBE2730534A069B85AD44FAE4D93D9A7938F6F0F8F4E9C771F
      8E4FDE3AA7676F4F9CF787EF4E6415FDB55A5059795B2F436F065EE71B64B891
      8840BBC6EF5C146E428C2F17E20B123CA2C420F1D235ABF857B260ACC8FB1AD0
      F21A8FF424469BBE644F8E1F93DD9522576091AD463F78199BF8568CB0003D06
      30908D9552ED6653369554B9E23C575827E574B058C56EBD57C7F5F62F8E4E3F
      E3AE7098579E5FC391B395D398DC759FA79597B1A6BC7A68E52306C324A8AF80
      3C9AD7D2D3D1BB58E8659A39BF7CF8F0D188337911CBEC27F1A5781EC3C78A6D
      8ECF62175DB5E189A8AC6077BA7246070B4D6847017B8354E30D5925EB45A08B
      AC2D7676F1CE2C9EEB51D532903482E85FA0C610AB32E360D77B4D95E3C00BE3
      9173114F83418523037F8993D007616F202ACE8F1CA2205D635758CE27454A06
      EB153753B8FD45AC92D39D644D2A8A833CA752689FC400955E4907D693A92EAF
      A2ABFA3790A529488DCA8BCAD0A46AB67B2A9055565197E6D09071552AF84BC2
      31D74CCB298103D93794702F25A43C6865E00DC6C208F2E4E60732D285ABE1E9
      168D46DF9297B070D9F769881D39600D1186D52C89A8F529A484AD94800DF06E
      694DE1B41F8D2D119755CB9B81809210CBAC1F382F345A214EE725C048793658
      E1499F27790BB067D57E0ED45BD2D567A50FBC74F525A4B86F18F780613D8C34
      EFFB83FA011D71325024121D1BB77A014695180736E0E47C60338D5DDB5BD23A
      CA86E68D30C16F6FBD993BD3783A0B3DCC24C08849B4BE17CCC48BC155C83CA6
      229EAADA0A534A23D1F1841EA64CEE632284EAB36B8AC4F0944F8628B82CCDD3
      9BEE01CA8DF8288B4A337E7F83FC40DB5B14F7C6FE4469BD44C78CF2C9EC99DE
      10E58CB90B6A798D2390E0FB71C8F9686470C1DDFF6E29FC2FC7EF51DD6CBF07
      62A4AA37BD2147F010B460BDE64A5E643B0FFDA228755FC599626F56D9745A8B
      D858DCC68C34E5C8FE62B03B9A4231AB1EB3C8468937E1489303E78DEC4BA43C
      A795E31863BDD9721A652060C9A4B10ADFD78F6F72E11DE4C70805253DF87046
      C14B34762A9FA73A674BCA88E30A5542DA4E5F0C3C3441CB8860F849E64E7FB7
      D2E1B5959C885ABBE444D4DAF73C1117E41E07EA7B84AE71107E37E46060B4C0
      C58723250C19D107A1182E061F18F845C6FF1D8A2E201F15E0DB656E7E306E04
      C0EE2EE68C10DA839C35C6A3E539B760AF9171A5FAC6713CC3F71C85C1E072ED
      2B8E6D6F9D002C56AE89CAFDC11DE7487DB20AC8687A6942924951DA4EA05B8B
      043EE88012157004A47E84BA9EB24F61A215262D1BB1EAE7A84E3A3BCA2E0180
      8AE26C57B659B83D2007F81BDDAC655B5F95312BB388BD91177C37D17A3D6816
      5B3C37A654D1A1EA76210AC5380B7D860DB283B654236162B51D1CDF5E387F75
      CED79E861C5D7C7A0B133DFDB2BDB5EAC05DEA1B6CB420116618ED6ACBE4D657
      0D674D4FC8D64C717058004D1A5E2F8598A672591452A2A2D39485153E53B411
      C429394E9F67D5CF41FC55198F856D7BD0E2D5AA95B95A8E43401C536358042A
      D63E88A4D0B9A793F552DD7E58E6EE2D1F423EB7D9C4FDFF8FE3C90691F67FC7
      886789078A8F973C94B823AC74E90D2E7DA17BDF3E0B41ADEE397F25B4DE5FF1
      09DD6C5BE1E7338C5D9E18F1987F6EC427251C4B0AE579FF69A10C687F861E4C
      E0511A3214DD3D57C84EF9BD64B59049DDD9388967234E57ABD013152E8D8E61
      DE2A69769E66D810192FED606B79558F6641E7DB2D449C5FCB32E980F4578147
      D7D5A4D8631D1939C2660AFC5DB739144B8E054E3DAE438429FDC3A23282DD9B
      738B0B2C3B96E9783C282D4355F4315FC556557A9A3BF3A5027733530ED0B7E4
      DADAF1BDE4120187CC07E010E2552CB7A56B58B1A6720CB7393BEA5775B77CD8
      BC995F68AC1F5F2F1D5C0EACF412A18C69868A8F722929592EAC10BC4F15E811
      0A6A15C0A7C75C8C42714EDE4A393CBBEC5477E489D8F8B426C605EF1AEB2A60
      980875FC564D2F077118CF92CDA1336C49BC6670A853B6BDA5855A0287930E08
      663B7DAE0CC1A25AE423709802A4F24EF266937488915F37D8013AC0000D7D6E
      09F8BB98A6F94C274DF7692C1A6067DC8821180668EF94E3BCE6E777793CAA9B
      C2236D6F6198815A529F8A45EAD2E97C51A65DE7B62D45BC109DA8C84C8889E8
      3966A1FF7CB6F1B524658CF09233B71996D5C3AC2C8D0B1B982E047BD1C15461
      D5D2122BABD2C5A351284330C9841684B253AFBE3F8BE3509E4EF9903491C1D9
      0036C366376039FD209215E5D8D2CA7B42E9E13B742E787BF864E9DF0F61949D
      FCDCA99BF276C341C8DE917CC327942339C5B2E4C5EC0C33BE698049DCF24431
      28648CD39E143A32D640E9BE9DC2745F9B93DB5583C8F74B40E43AEDA61FC49F
      E0FDFBC71FCF98F26FC4D9DBDE2AB03C559F067891098CEDAD4498A2A30C0106
      2CC242D3C8CB80A308B36296369ED00F4310BF31BA2855B9E87F770066FF9FC2
      47C52F55919A035DA93B0C2641A60BEFCB52AC84B52A0800946076FC53FE444C
      B2BD0817243C9C05339EC20401E93336DA28C9D79E82EDADCA4FDEA43F4B46D8
      33FA1DE80C1B720E0E9D7CE1B4EE4A49D493B4B194F8FD0C1550563A95A32095
      4FA93736A8616470D9D1F5E77725BDC744194AED8A000822B5ED7C0BB9969DEF
      9A6BF9364622F26F22466BB52FAA979FB303BA2E152C8EB2F54AD9C4625F6B35
      A14D2ADFB1BDF50E6B6BB35D2BC3B2EDC44689DB45AA6556002C71E76FC42B7D
      0184CA978199B2F801498E79630BB324420A146F0E9240969703A14A06A61D8D
      6370369DAF9E9CBF55B6CB0D413C162D49AEA462A7DA728B4881E04071735991
      D91DA37415FE7620D2106B1E01070DB4BE871535A429C5936520C5C2D85AF752
      1750B69DC4FEF6D62C540D30FBAA483E1B3B3DA74296900AE67A65B9E984D267
      B8A83A572347C49F4ED563147371727373E350F2D8817372E391A01906666555
      5577F6828F8887454CB4F0AD3550D5996A36C5AFB566DDA920002BB2911D28A1
      D52AD5A93F660DB451EDB6F4B4F53DA7275579DBC9E9E9E9AE5A25E50361195A
      2A059F0593423948BD2B798E2B9CFA41C63561B90E3C9B8AF48BD0C24EBFCA2A
      FE3855F5E39EDCDA2405C2128C822C5572922CE98E64E8FD870BCAD40A030E8E
      F128A5D0C75CDA491009F3D55E349FC03BF4BE1AE53AD12A8EC4896BD692BD8D
      FB0970980C495CA87DE47837CC0BD973EAD4640ADC1DA7B083140E05390C87D5
      E513286827723EF431D7F1EC784FD542A69C4F2F5F616016ADDF035DE77F10FC
      352A8172499E843C4F34D74B16107566141736E847990B0FEBD74F751EF2CACB
      D09F8D22003ECC63E5610608165D755821161D2CC226388ADB5B19E668E10C94
      7D44EFA4D24C17C8C48A57FF3115333F5EFDEA31D6A0B07E5C97818C0570F0D1
      43D204D04084D7B98EF78088A43B584521E587D1E6C84D564828904984447C4C
      7493186D92B00D67E6793BA90DE3E9C6C2CD12E746131F2A97ADCE280682AFBC
      6A3696A57CEE7E77B247908C8C586DF1D8FD61DC6E7D93867754468CD9171D6A
      3CFAB8323F6F0E76E07CD24D84C88B2E9B3449B45671FE24A598120A8B7444B4
      CE89F3CECF831B6C58CB30E39FD92DAFBB0BA59A5A51BAA1666DB74F13BE2D37
      2F72D2B214B3A671401D8E508989E6D8952FAF39A2FAE0A16B8BEBB587717C89
      32CF9239E21B27B3C1985D04687A1F70B1E042790672DFC9F20E6ABE6FE049F4
      67618D610F26E34DA8931A8C43156A38B22B652825B286FC1045996CACCA3199
      5BC010F6617EBA6331AC8C848FCAE7882CA115D5C587D6BDD0C866D389F1A7BC
      7BD59BB973E4913B6443E87171ED662706A955B0104CD5007CD9D1962FD1D9E4
      300AAE15C0923355EC345A772542C6D6B0DC7EF4E9489B3AB9AD365610C0C66C
      B2D925C724EAA302F363D33A8DCBB238F65DA237C29870B4D97B8591328980A3
      1C527A288AF988EC91D3042D66A1DF15E98A319DAA02CDCA3CA26EF9B33510F9
      B16E4F21CC461E6C076B7FB0FF8FE6A1E1B800445EBE6C3282419A745AE58BF7
      F09B19644D2BD4F43775BEBA3F52772DBAE6F99D2A06B4F7074A5EBD2F44B968
      ED523F36D52B0E14E50DF654A34762CF1927E30E819C005F9E65A896F567DCB6
      45D1271975AA34624547A98D9D2A84C928545842B40CBE263629B5D910CB0F00
      D47C0B0292E28D3879C1E87F060357B079A95A391D6A51616C05C57AE6859C21
      C303515F54E45994F525E7ABE937ECF3EDE9C980A032458ADA813DA32A750C2F
      A435AD5E99F89B599BDD0F52DCCB948ECA401EB5E75ACB5B3820CFB11E9F1200
      49D430712B3777333E531710BCA8A494E75A27DAB3572DBE6D6FA975D232CC75
      4AA2ADE85C821475C54B3BFAA1F7071EA2DE9755AFEB6F7C38A54C46312EF9D2
      365C6E7907B705FBC8F6B8AFA6DA61A48BCA3804ACB094856C888883445B769A
      D4A1BE049ABCEF573997F567642F926914D2D02A12BC81E3D426B8095CC202F7
      21CDED741CBB4076E8BC25B78E383EFAF8195DBFC2284F60B4B634B403147BB0
      6A359A73691A68D635CCAE9B8AFD8786D0883097E2240898F5DA866239AF5D8A
      D7A6504D429F1670BC3C604E89E286ACE3144692567F6D445463C87361D62BF4
      A2BB6AA26D3ABA9E51397700A5EEB441D575635F4CF18F4DB202BEE3932A3D2D
      F1F6964C55D31623362993582F7D6638516C3F96DB740EDF9F9F393B68BEE9CF
      4151019A8CAA6302C23D461FCBFB25459561FBA92E67A73B6F6BF8EFA0378E6B
      FC65D782432979B05459C3611AF42AB6A4ECE259A0782FE7A36AEC2CFBDE139B
      61D7D218644EAAFC489168B034B3930ED7540C80428D14F5923D2AC9981EF828
      CE716B42E96EA345EB394BEFA654458ABFC9831D62D489BCA3E8F4326A5DA027
      94C2B9CBC7630959955FA25B75932C55515A86FDCBC27183D04BF1366CE22C37
      2357A252D5B93995CD38555CBB6EA88C36B5502969721229EBCE541C8A16F1CA
      ECA51D441C7A404E3C954C498B50BADA52D87C38DFECF4C7EDAD73DA1EB5611B
      41812EA87B13DA0E8CA814B57E03651DAA9039F2D07644DDBE19836C605D21B0
      AEFB9D9B18FCC84C416FDABE2431B8BFD2EC4D61142405612F562024BAD8255A
      3B28DA770F3DA422C19E6651EED224EF3EF56E576535941B816A7B1FAC15266C
      6FFDFCEEF018951D6CA51430F5CDE653214143B6D624F1E6398A6B60917D55DC
      603F666C0176394F82096B921E7A84381B92AD6D0C65697553D6B29C7F295EE1
      78683ECA82882213F28346011A183F1D4BD361813BAC072465B42632EC254875
      1B04689E24D4597589D403F9AE67E807A75ABF796AF382947922AE7BBDB603D4
      9BC48B524045B22CDF6F4F16D0529E67797095104031095C7C75C4B905A90045
      FC144ECA877E185C511F5EE55FACB300A2FEA4FC78E00E1CA6549807BC5184C0
      348C7CBD0926C6F9DC4D11C3CF78822C8C61B6C8A2578F27611CC40833F165F3
      5EAA0605272B9C514E6F34573B67C0C7D9513091890F6C9B2F02E86188FB3C68
      FBA09AB95F43DC5DE569CA7FE3560B68F40FE7B731FCCF2DE9DCE68E86D3C8C0
      4E5433B4800C83D79C1D929DF79DB7A0C747CED9AE619D022C0255364938459A
      5B3DAFD8A23C98EE4B5DEF87FF52F3FAFBEAB189DB78AE76EE0F9CEF434A8AA5
      AAFC40E98C61F58F99F32C1B769E2114C6CB718A2D9F0758CA51778048267424
      59BEEAA3A0C5E1E414AB21314C10C153877551BE418A7B1B9925890352FBF9E2
      B47320C57D2EF028C3438BA353A4CBA2FD211F57560648732EC3BE6D1C9DBD90
      4080599AD1EBBD5EE88E5A8C58B92D5FD04AC82080A67C333D5A1B8C228AB8E5
      A0D129DAA3250F439248BFC9BF5F1429DF6CEDFBADDCDB4D29C4B2BD6508353B
      C898CF4F38B4390E7D966ECC44B602EAF319C1508E518447C76AE1052DDC5D5E
      14FA5BA9E130783F1880BC000FB4D66A6730680169F73ED1EBF59ADABF05A802
      04B3EA5A4DCCF7226CF64D33ABADD5CC44340AD7746AA0BAAD2BD486E8DD5ECB
      998D044881D15ACE2C11E29227565FAB898D67D1C84B0205B5F5A21CC06BC260
      3D37F45FDED45B574E00CAD0B518AD29E0A6714E72D70BDB50619B8D66BCA96B
      07B76496A67A4BDDB59A1A4891EBCAABD26BE1AFE9D4B25972A9A7D6D8248DED
      FCC4EA664FD0CD9647217D2BDD6CA9CCBC0968AB3C358D82DFA6DDB2B8FC045C
      5E6E39FB76B8FCEDD178FDEC86DB5BC7E429A4A264D2E28CD1571A9129B586CB
      A1919D75430EFDD9AD3C53AA1837369C5B1452C67D6B35B4763057122E29AF16
      2794A96C221D4D86A7C5F1FA70D72E661B51F1D3B90A832D80DBD991A1B6A953
      F94CFEB1C2CF3F54966519A1C19F22BC778D5039765CE8525FE8C2C00A7A4618
      217A3038E6E2F63494B76E2A22F6F97A5C9815BB112008D077B1627FC1AF83A9
      72AEFCF60C2D53C580D304655D6E2AA986D9B6AA10AD2C9812E8EA6777A07C8E
      D6D94DD76DC1BF6EA75E838F5ABBD1818F7AABD5808F46B353858F66A38BB7B4
      1A2EDED2AED7F0964EADD1E0A7F116383B6D1AA6DAEDE24DAEDBADE25D6E0DEE
      C3CF7ABB41F7355ACDD6B39E2558FC0AF7518252CA117F436FA1BC74898511E3
      E86F2DF8DF46D0188C8ECF0B155378993381B92036AE3AD1FFD9BCB230EDC008
      3EDFE18A48AB8E5D429C58BD0B3C7A95EDC98816A0AE88065C18DBC3A4459372
      1ADB947B65A98C35972442A72DC8700321A3000C6735505C5F240186EB13F157
      8C62B39D95C7DB5B92232A786CC4895785C8544B3D1917A0A403B8523961C258
      7176E06B85B8B2563DA8327B2E970D291CC90C56D058AACBA14F26147889151F
      9E25B826FCE1BFD484CA6354162349EEDD594556AAE6921F691698C5B1651E27
      1DDFF43AC8A8EEB6198C61843B70817B0AC033EA7451F81268619329817E248A
      091DFA692DB4AD9AAAFD174687FCFD0084EFE788C9DCCB271EA8E000E752CC09
      A7F2884455A029BD750FC50262C82E47B16C36C5DADEBA1568B35124ABA46BC3
      D20C28521F17A1A58A84A97ADC391D4BE5F9E592800976C69D2872A5B36B64BD
      DB42C54F93430F614A58F17EF9CB515F9945B292B70A94A156984C8139B86B87
      6C93A71F1A3238F743BBA56EC0B5528C963C1819952F10370301C4430AB307BB
      C67C0AC0E0882F8E37BD1DF548A960D4CA58561FC1F591CEA5937D29658B02B3
      64A6D64B0ACCCA35CAE7AA8877902B18ABEFBD4A896A078E38181DAC5C2CE7F0
      A5FF2B99FEF32D83CB95104EC990495557D273F09C858265048D70BE4883C410
      77757DACE547FB5A7694085293E9668CD0242333DA6244BA876DB3E360404186
      0F5017BE77A2C3F696AA82910859B8481B80729018E546F310E7816CE5FD38F2
      B6A90C7759A2C686F0DC254B2FA6EF9A99BB4BCE2312DCE591BF9416C2A858E8
      76EFECC878F08749BBAB94751FAB26A021A2907FF0BDF49CC7EEF62E91550E15
      97A58B9931ECE51B4E0663ACA2B0E05F3232FF534206B80FB7174DCB5CB8011B
      101E99DD7CF41066E7C1522A248BFEA824F494D145C8CA248BB008CA8586E0FE
      2001BD76D57C9C4970D17EBF40C433F3D0EDE01142FDDA4807BA9D7DBEC41790
      2D4B2F937C6014C67D129D0DE96F07613A4D8238A11E51572229D15D770D9EB1
      F21499674D8D59798F6CCCE921383F74DA0F4118D3763255F5D7749ACF6AE5C0
      EF9AE8F3A8196F6F7DBB449F9523CFEA51BC50A616C900EAA2D728A3A8FAD9D4
      036EEFB90EC2EA655D747E5229CA244F702C503CA469AA686351A1C5324A5446
      45264E822482D52BE7A692FB52144029F5DFA18AF322F7D85D087AD32009FA9A
      030F574EFB9E358DFB99D4DCE3C41BC5513F4EA267547175A5694A43CE02D064
      E67B45867F277FE612B545C30C797514D3259168D5099ED31F6EE07FCFC074B1
      0B1D332B191FC0A8C9BDEA766EB73AD92D16D35D35D5C555AE7E9152AE5AED54
      9F8BB145F3456F2933B8BDE7397418D9B4723352AE6B10410CB11222D5376EA8
      9E23E4C1465D35145CCCAD9AEA05AE36D3180F4FB55BAFAE5A66DA74BBCBDB58
      F7FDDB1473CBB29E874E24BCA4A4BC21C55861153E74359A453E81EB4B5B3729
      844B2BF4D978A22752360E8353B0FDC191C91112AAFCEBA850AB425796FB812B
      52DC2A495178768988501CC0CD07389A2741180683E208545CE0D693AD66B5EA
      3A3B9F2F4EF73BBB1B71B47E416FDFAAE9FEF3163242EBBEAAAFAFCFB1DAC35B
      A5DD810ED8D3FCC4E8C06AF5876AF537E74DDEAF1CCBB78BE407E757E91F9307
      FCE0FCE2D3D9FB1FCF7F93A7ECBE677203CED81D0AF5634FD933FA54C91F2FC8
      2FB8E750F14D550294ABB8C4599E2B618FD5238F55AE746BFF72C9F97176C8E9
      A3B67B776339952E038636796FE51AD9331E29F6F45050614067CA51A5DDB861
      4D5EA6CD72ACD570ACC6728E6598BA443AF9CD39450B8B2C7DBE43B5D07F38EC
      9E76EA6F4E4FD5C17AC8708F39B80F19FF9C7CC1B2C7C1A6F4AEBA7DF6BFAC18
      63D054F1DFF0BF559B2AF2885F38DDC4480D2B9F2503CF4F06DCDAF2737534FD
      200FE5854833385BD392B34BF4E1276E367D9CEFDD77E4C1EBD8F2E06DDE7879
      EC457EB82994894D53E1EDD5E76DDE12719D0459867D06F2665B845A804C1E86
      C5A3ED49174AC402F9DC0F7C12507349240679E97BB3962DF7D7E588D7DB450D
      9595F4DC90DCF7E8E68B93F30686D1AA1AB7EF7F3657B09810432E08CE7FA466
      34B25A2D0CD27C7D7E7E2223711B795C921C66D531A4D37006CB4D0FB29BFBC5
      9E3CC44F912F492548E9A6E62A0E33886057002A46936526E8C6BC7675931409
      0484F6ED07D9151D0AAC45AEA0BC6AE73F4E82E6706F783DDCFE2EAB45280CD8
      53057B952776C57E55907F562E95C3CC575EC65BA4E1AAE7A9E3B20B655033F4
      D673F153240FBAD7F93BEEEC9D8A4CC6F473E349C0BB494042A3D91CD30C1D28
      5081C7D44278D2067301040F6FD73511A84A025C71DC83352989507F624984A7
      81C868EFB97222B856FB5D93FBBD52F07DA64EA77702EFD131AEFB480A57503E
      045F784FC0E1AD0B90834B4E9D41F761084C3FF042E7F8ED111E7818C4470F97
      3AE1FB26ED5EABBD6F3CC7DEABA3F37F7FFE741B0148D778228DDE9731C13F7F
      2A54A069383F7F5A0BB46832548F28C42B8E9CA370D657ED51578F1DAB9F7F8B
      E7AFD81BA66B989D41BFEFE4DA07B2B45FB45F36C13FBB227436549D028D86A4
      86B04CF9368C5C6637078EF1960638949759FEC66E6F54EB83EA33514F376C07
      966679D4A26AF7106233CEB9E91364E9267FCC681DC1AFC136D8B2C9013525C3
      9196EC9CACFD3E9D51BB67981C058C0691EC0B84F7F701072E0FBE6949EF75D4
      FFB13F8AECF5A7E3E11D1FB84FBC392941E3256B278C56876047E720C8FB30D0
      B6A81B7ABA3B3B667D7B09E6BCABDFE4E9F2B866119F8574CFA90CE2E91C7580
      838303C2CD0A1B1482491002D8B17F0211FC7437B7491896086D9E508AC0996E
      7ECBE90C9EEEEB298FA63C31F378267BE82C9C369E58B1AE116A2D83389C4D22
      060959D53E1031D819055A7721D307B6924FB193A9347E4CE334503DE4B57D61
      774F2B3AF8ED2DAB3C3BC3A24A0A7791654ABE893B319A00E782F4A0C84ECE8E
      B1B9E330B8311522D5084C6D810C6704E2004BC43EBD0CA1888A2CC988620A48
      5AE884FA4E3E4FAAB152C224A0B89510C52CD0CFF7D31D7D81FBE73FC0120DC7
      E252ECCB94A2E750A40138AF32CEA61483CB3C28FDB480F00A944C5A15D1968F
      E85F2977099B55CA9C31FA9DAC5C8B78A6CA6F11EC7E3DF84D77AE04EEF3EB7F
      FFA6ABC4FC1F4057D29D55B130EC9DAEDA6753BCB8CF3DE2336AA5B6302135CA
      713CC3E78F605E97C89F8EB224FCEB4944892738659E273558CB343DC8591015
      E12AE4E80FC258A60D32C5E0757CF8877A21B93E34DDA81C2D9E75E07702C004
      6A8D0E8BE3369BEA7892F56F5EC819CEB3BCB98F2F9C2E5013E038BDD60749F6
      D2E3DA695831CD3415DC634ED4875BB64ACD8922F5679D088CA9FDB64D99D691
      657E203F0200FED5B906101222DDC3D619C7DCBDFCE8E2D35B02B5CFD83740EC
      7BB5216CF590D02FE6B0F847822A677C5444EEC039E6F512151A7A619AA336DB
      2E5152E53732BBD8E38155F1AFB1087D78C335F3A8024D60B286DD7DA659EECC
      7B275350E0D3F91108F0942DEF3B306B20CCF350ECCADC7FBD3C8C58FD6E155D
      D6E5889CCE9044221B50B6F283D138863DD8A416DADB5B72D179F8A332FC6233
      AD39E790ECC8522752C499015D218CE23E5354988A9BE5CD55B7E9B127851539
      BCE60A5A101C22EDA7CE5D722C2A2169CC869B88EE99A3A8F6F3C1288A0D227F
      C2B393C781782FF33B7EF8F359EE7041767EE7BC36F5341C1584F6985A4C0241
      217A926ED891C8D78D2ABC3384F3304B64B1314DEC01DB382B5E96808D51CB08
      26B2DE0DDE368AC9312BDBB6671922395E31D58D29C899B94E10E8D6EF40EA33
      9D2B3E0640A58AD41777642FD7D8A239CB523C5B2A07702DB06C532A7315B8C8
      2F6F331E0A6C533C62F58D3BAECBFCCC3D523858F7404938F2A878807EB7CEB5
      D397184EB2235E862F65D010C45423F71DB4825C636B9B68B4ABA396649F6C4F
      86A82825682CD3E3FB62E0E9D21754024E694D12502912A1781665DA534D397F
      BA293C996F760F9C37731C931625FB06A7C61844BAF24EF6B03A10A183290ABE
      0115441802FFCD40C6CD24076565554E5615F443A194BAC623D3979AE5150ABA
      E48F1F737EC96CBA047E948148DD0BC7AA7C9D84545ED34E2AAC319C8900253B
      69AF62B8E563828E0103CA4A94A4D260C91DB9829409B30C1D48E3101DF198E8
      88A102B2A0043EB4B882B14E89CC31905412A2A7A8A24EA61940D0BB0A468C50
      5AADE7021218A1386785BF724A0A2EE90FF8B49E5BE5C0F9657B4BCB4832C196
      2C16F8E4340684D5F88E263C4477D07DA89662C4EC4256484608E04040865EA5
      D25428679C7752D48A540E1D423682085EC757D162282E0250D978214D9D011D
      61591FDAABBB9646A77BE25DA2BD3263A220BC5476B0C61510C103EA53F4F2EF
      F1B114CA60838AA4DCAC2C567BB8B0C92CFF0D114B6085DE084F1F8F422BC8B7
      1046207CA32381046461DF373D17EEBD012DE77CC1FCB621CCF01765F1EEE781
      6E6458A1601EC54FF6A4265F0A2D9D3B234F427E958E8232284AE377A42DBEE9
      ED9110B991BF4E622E8A4381328AED9906B6FC1DBA1A526E6FDC73D298EC1848
      7BFD006B1852E3FAA92A8919447E005C1385DDC2899136C920E1423951969A56
      20AA8B20A98061ABC307C9DD00673EC010AD80C45D95F8A0DF60D0F13990F709
      1B7439FE42D99388184A6312D2C92B0F40D70F37BCA8F0F6D6498450787D1CA4
      648643707D124449F5FE6DC899E54A1D4615275907EC67C24485927886D81041
      78ED4BB8613D2D82640EB63D539804817816693B02B01E85932838E42745C61D
      5E17E4D65B3E0CE64E9B8EB947AA32CA66216AEEBDC9AEB7B7A8A53661A29455
      0C352C928A7CA1E62BFA591D2E2D937B006ADAB15BF00E8B65B2A92E7F1C19C5
      B52A47C5B71F1C1C54728C0F5469EDFC70EDE11B911ED31064B37F9787292E13
      8987F100C54CC909D9B4CF2FF500190A6C145E944AB15606E72ACB77385F7400
      F099C3161D149017154FDE0975EA2894B507CD014DF4290BB1611C5FD231CE0C
      5AE1F57929703104D6953975A970A45A11DB918AC85F11F64AABDB3D70CA8810
      171C51CBB9BA45923CDA82EDADD24DD833B42FCA6E40AF90475E745465167742
      16275DA47E41BAB00F7A8F6943082B58BB51BEE75B8248287706099FF63C91CA
      1BA3B7A43FCB44AEBE29B04909473662E149E1BEB1C6A60492C1787B0B9D3D79
      491639B40CE5EE0BA3733B7A540DA439700E49E7427D2048260AB1958346234B
      5160A355F78556379418B48040FA3E6E05B3E9947B013A1B41B659BE58C40B3C
      2B69DEDDC808CF21BC452A9F63ACB825F0BE67D5DA7484734F1EF3489F45A948
      B203AD1AC81B27319A31602AE49AB98E6E9101A04D47B324859F3F4F9DD7EAFB
      316923479F8E16DE88CAB82E5E36DFDECAC73A1F07C3ECAF3C0B55CBDCCB8C10
      2045918927903E2F6F0E861C74349491089272D0CB8361D9300764CF297A79D1
      2FFCE948CD587AEA0B2B3EA66B86A1DD0C77A237163D56D27EA22A99E910277C
      8D9C70DE364A0639C9C990CF6A427926F9F2527E0BC000ABC35D07D27C972FCF
      082DE7E0F16B0FBBB1B05213697BE88907C3165272B96212BE06FDC88F0A225F
      8CCEFB3335D46B7CD7867A86D379DF393458E2FB0F173AF24DAB1C68C0940E4F
      B9ED3A24475316767752D5AC83B5DAEA0B8E9DDA773E2C7277158A28D1B660CD
      5EAF356C6F9DC7B36480FD8E0F17A594C565B088AA0DF15ACA5BA88B28239D78
      DBA4C9986CDFA6806460820423D759350A17D3ABE5ECD44C16F9C57A001156DC
      E775EE23A13561A60342F78A484DE52FD610A7B7B7CEC8ABEABCFDC08B4177A9
      DC2C832998845F8758E5AED789CAD0CB8B51DFDAC182DE17E73D7D146618E141
      5C469F42FB7E784C0AC922B86A0FCA1FA82D06638382F35552EF361A8FA7F5F4
      F07D897D105E95B88F69986F41F30F39576C7F31C1AB504C32F7BE4FD0FF99A0
      320914218F6B5E831D05247D0357B6B72E613148AE50F1168359217EF65AFBA6
      288C0DA3684028794341DACE6134D781783A549302B8170F8B2CF2EEE50FC8E3
      D3BF3DD2501992978E247D6B65035D8C4D2B48AA3C8B3C14B226DA316C030223
      703EE7378D35FFDE2A0C09918A4767F168244D086417906AF384D89396AD6121
      0341D23D1634C6A02C7646F2AD9A1D4EE2591EF6F546EE77D1DDDBE748159FEA
      34A87D1D0557548C02234617E9A4B24F9009011D898C8AE850108915858BD4B1
      F95D45E18F051BD47B69839269B45AB7D49A1D7BD2B7B7640B3A2A2FBDA0266B
      C798F19B1C66671244B3348F64DA5D2FB98240705408958899E248F9402E03ED
      BE18EB4BDE3C5AA6B29485C1B41F233EE5663F1247FA1C3E238CA499F754B9C0
      0FB2CD21644B6D7DB78D7614F7BDB7CC98A90C7A46A4FB2D836699F586FDA138
      12B211DE9F037872C476FBA1EE0B953B80B4FD92A89FF677D22A94A3D3181F2D
      F28B5EBCCA82AD162D3785B877DC8A11E550282B6624AE311482CC1D7A70322A
      141EE4FC956286C1A69A3617F671335C52B7974DB8BF507BA2D005C0D396B3DB
      8DEEF2C10CC74B2A79BA6AF467380D3C0A4BCAAD751A5565FA85E9BEE174262E
      3ECC755554F30195CA1451F792B108B5D6FC01439E6EAD5006365E89F2C5F13D
      DC15828C35EAE0B1246AA42249971DE9FDCBDFE4C7A40CF405C74CA2B5B5CCBE
      283BB5CAB85D81256BF250638FAADB1754E94D3DAB27326073B3FCC7C0FC520E
      BCF5D2DC4389E7273F376869C7F805A74211A9255EDD85BABE45B7E5B0CC916B
      2435B2339A7D2006FB5A74194A430A22795ACCE1CAED434A96A173B8C8C83D0A
      F9D1E951BAA54A21AE6FD34F03394036EF38941D06C34B691C07F6121948B3CA
      13517010E687403111ED5C8F54BE6F2E472E637F6C0C245FD7774CD55817F4A6
      4233CA7BB81198FD3042CF8578C87D09D8FB5C086E468CDCA2FE8B1AD6D7742A
      33AA1EEE953DDBA2987DB089CEEA362347E0A7A2F6C4A32E3B777AB17A264644
      AB9A4BC93B707AE699FC7A1852715683711CD3B8AC1D16426967B453EC2051AF
      2707B556EBB47F5AA53F9B694936676B32C59D3B971BB011B400594BBEF0ED2D
      897B85F38BDAD29CAA4CE4512979EC40AE6C68CC55EEDB5BC57F9F5A186A718B
      9C9D9BDDD51798DCF073700813C34A0145505736E2381433D83524B6B78AB0E0
      68A5092C21D8CF8365F3065EBFDEFCA60EC1DD09EDCD03E748861E71BCB8CFF1
      B7DCED9D9479F2DF3AE9044332131EBE56A8EE503E0DD27B7455EBFCC816C22B
      4A627939787711090A1CBFC44AB8A793F30A2A997A2939CE7091DCEEC9085BF5
      FAC575713D2919E7797B3D61300998D7E671624B668C066ECE7544B79436655E
      05DE1249E50E80504B4A76366E3A85F8A4CB247341A35F0905A7A1F82DD73CF2
      1DDF0CCAC13E502EB0B20C08F9C9D9D129467749CB8548EEDD2525AA0D7389EA
      B8492998CA2D44240A5EB0E4488064290E9C331C2C9B255CDB9E3B76A2D932D5
      55ADB5DD045EEE27DE48773D679AA4AB48CBC86F6780392DD2DE42D18A74252D
      C4B324F09EC2A957AA002B019480497571F2A234D32406604D0C8BB18265EE97
      62C2CDE057D878F73E2CC66D1214A4FE3C15095A822909F58E1DA55475A30E88
      0ACEC21E777460759D1FB5D1521150396CE873E357B19D9934035504CC5219C5
      07E5678AF49912983782A270D2BF0A6EC06593739BCA8EADB697CE3EA73F4A28
      AFBADE18A645A337048F574162A0B772397CF96A85F23FC912411C214E3EEFC3
      50C688EB0C76591481393A5A0A540E5C4A5124C1B030B4E12AA5F76AF21929FB
      C0C04BA5F26CE6BEF3C3AA540A57C0C4DC5D0E915719FEFA462F91E34B3A18A0
      A18D104C06E26DFAA93EA48A679C212C3DD41B719A39FD7D104F261CA01B91B9
      0A382215C6CBEB48481BCDD893CC284FA696EE7C0C172E146820DCDC314AE9C9
      1B03CACF1693690CEB9AE76581AE3DF66ECD22908AE529C2B850AC6EE7731904
      0E1819B3A77657A64360310E250060EC32E6A40810D281E17AD3A9AAC3AAF17B
      A58AFF3EA1CD3181E21C60B5FAC6F46423A3C0088F9CA4D17EAC8A72EFE86F7F
      E3661E9CA2B7E7E8EB7E3848F79CA3A374B710DD8835A539F46D09A07A8403CF
      0BA61F3CAC9FBDD7C73E077B03EC9CB3FA5ADA39E07405904228D23D40C1B195
      94E834F1E680B8837086255A1478172CA19B493A418D3A47B7FDE788427D9C9F
      8228ABC0599D86DE40A4B9B45C21AB05EE7E451A323684BE92D1A0B2044648DC
      A4B15BCAE11F649EFE4E4CD96D7251BBEC49E38008192A8A917533399A2A8304
      C289B2C4B85507E305334A00ED23C18611C7F0D65C586057C12CF265E8F14FDE
      A43F4BB02ED23B4A775669AF4456E59B64A80C56E680D5706007C668E46C42DE
      A98EC4918A9DA594E0404594E88A01B3140B6F502DB7C59A014B87F8F5BF7F53
      B0A2D1B0370EE633105FE1DC22B729539E53C949E03A1AB1E058C336A3A84EB1
      87EC27C1B94471FC6FA19FD680DBEC532DD51CF4C2B0554BC5C23B820B291224
      F1346FC8293EC400C5024476DEC081DB5560A8C8C3BB9875B9E31B66D52C9909
      1DB85B5A2754CA49AA8E958C179E94EFC48E0A99E5126518A3AE6A5361C6034E
      73D3B159854E013C0AE69D0DC1DE427DD965662EB2B311027A9960575A10ED13
      0FA748EB981B919D6131412C832E65A1546603EEEE39A7206B65B21B1C616820
      425F1629C32A023C683E16173DA2F2A37008B069A25143F7DCB0D42F9B070FCE
      568710F30B1D3F89A79C168E8C8BAAC14D632AC3080C46E69AED08B2D29392CF
      F3360BDA8F6723AC8BB9A3CD74942BC375E5BC511464B0DE5DB4F3FB4675BF8D
      3D4F4C7B54C01A4273438E12AA044B560F321B95CA40B96DD9692B9625218361
      C25A3262F2AE3C7F58E13675B8183CB679E6B202A491F513E15DCA824B5C1534
      E5C49353B6027BB01AF532B4DA6F3A861E622D4A59A46D4350F39068189228B6
      02A2A54555E454F5591920A69361300E8421B25718700B352E8F5471D4B731A0
      645A311D3FDCF8005DD2773E9A725311D656FC62B9D45F0799BA0D5F90FEA69E
      963F9EF948C9075E7811BF2323C72F000CF5C49E933F8DD7CDBF79343360B15E
      9C26C58B91832BC8D09763BA61945203A7697B4B44BEB273DF1EC2D9D16E18D6
      91D0E6B06B38750E644A00BBB20A1EACCC2CF7AA1FD87364356E32B9910963E1
      15A406AAC8A9CCAC4228534FA5A12CE31A8EACF5C91EF266512AEA504A9B623E
      01477A104F842ED7B0BD05FA7AEC17F2088AC545CC2930DB67FD0A6BAF6B431D
      BCCD57B5728D64816BD06BB13688142BF254F3A2132BAFAEAB6EE03AAF723954
      E331F1724BBE3E09C6C264DFF303471C8C0ED8746F94AD953751D47528BC880A
      2573B25A0C48E044021F46BB2506411012D002861AE7A9C02A173697FB27C87F
      B650D78946CF4F9D6C4F9E6F97DCA8BD32C73FDE531962527D18FC1B9DA73BB2
      A3A73E980C586FBEABAAD2C20B5520206DBB9F3B00F37D53F5BE620C4C84A395
      6FB42E19A5CAD7621D6C13B2D79E316D95929537FE51B806C30CC80D01647236
      C8660916B595268C1D8A6690C57FD1736AD4D3F2A4D5372FF525DF9B880950B6
      7411B73DCE46A7828664E648B33826FE4C25456748C754E0847391D775C624BB
      594A15C83C6D3351516611A77D032694ED8BB8A10C4C965EA9EA1A19B8CDAD25
      3DAFB0F315935B11F61D49EC233391B8C1247504AB51AC914D4A4C0E09DC6F05
      B08F0A83BEF2CF190A1FE7260166073BD38D82C34BC5F89864B2F266EEBCF152
      F18936A022BBD2902DB41FDFA8DD94BE7D95D46444C5B08790DB08B0F71FABB3
      EA3B76FEE69050CF89E9CED1C9DBB7B83358207C88B460A06EDD5D38210BF3C8
      EBBBED397FDD73F679F57F712EC53C5D2CDC2D5D7200388E413F0CC3CA9EFEEB
      3D1C5205BCB3E80AE52E1D5A5B29F433E0AAACF941D374591E26C9FF94314FE5
      84A813A18A711A274BB2444EF457853665FC2DB5E0F554EAA76756A6D39BA0F3
      3A29BD966E94E6C254E8D1D57B177233C96B98E7A34C0B5EC84D151E3F018D1A
      CB5018CEBDDB147B7531E45DE1B82C8F86E4F1EE8E08A940214AB9D6FB826408
      F45AA921BDF07693385D1B06434F6641E8138FB8057F5DFB9F7AD31BBDEA8170
      D094F2B2CAAAC051CAA5357D0AADABE8512BE485578D498010CDD16DA63DF840
      AC61B16376AAE9E01E152463566D6729C77423C9B8A934661ECAE146B093834B
      20D948FC7151DA321172080F00898D7570FE9139CA777AD942DDFF0F4C1797C1
      46532302E09E6CD66D42D6602E7A88D7B3281F4ED1E67C216C9EBF2D2F1B714E
      6CA38F13F29B8F400396AD26289C73D94465BBA5947087D22286A8DE66B3C828
      7F2AF70F4E09B516A306105CC49443263D079B97202E8238374A489EC380331D
      F38D3F7384164C00D94FCA087B7E7EB2E9B44D99422B5274C03E8AA09B61481E
      B554FC892AB76E4A74E447E59FCC3B8DA0AF9A250620036812A4CE8C26B40C4E
      AFE075E0BC914D4C54EB0A124C6332E5BF3B3CBF007AD5D7474C074F1852B18C
      83A671C938F90AB11D3B20C9B23E52E84429784FCA96C4C9438CAFA0A83DAC3D
      12CF129D81378B401A951909787EE83CA3C02758F6C6B247B094888AEAEFD201
      998A78AA12C1FD583779F2E019315572348C651C56225BA8BCE2A1E3B024DDB1
      B4187CC18C23175BB48B530BDFA83DC9201CA513C0CA4CD81FE8CAE74C73643F
      1A803AA6B1F38D01E71DC942769543F88D8748EF2EF27C574A98B3E4A5B4C162
      F1BD54B5279DE51AB8309ACE485139A5956A6157170C560345CEEF33D824D560
      512F85D40240847B2D47CBF37121664737FE51653E4CCCA64AED7B72A7A86091
      12308B917EAB0F0FE169D02CF0E52BCF9F214D43F57A0170AF780D67FF0040FD
      02C7E66C721C0374571E0A74E07CC48C48C12A1763041C521DAD259BD40819C3
      285B9CCAA2D311D59CD6EA981F3B97B8AFD738C25CB635F571DA9BCE1DCF26D8
      464B3A5699AE900D288D13EE9A45364CA99CAB06B21BC22B4D424A7220777896
      FEC2BC9B8B91938A729FB62C9F030C73CAB5D4826CDEE2EC1031C5B2C3B765EF
      DD8A26B5DC1946D1414ACFC10DD255F099687EE5C5857BD03CF149D276B21E91
      0941FEF88037637DDCBA615296AAB78CAD07F20A4B1BE6061C3CD3748D52A538
      208DF88E9413A80C7ECE4AE04D57DA17258D2E9110D21CDBCF1933920BCAC105
      310095340E1730B83B07045F0524EE731285B41AECCAAB2146C651BB406AC9C3
      A1089B4E2B74256436C519D220B9C03726C34826B994004185B72CE41B9A663D
      1266B565946DDE27E7EFA82B3B53DCB7F1C02343B72CE798373CE7700092B10C
      83F61D49FD9B8AAD1FC9CCF1490C9D5F3FBEFD3F9F7EA8D2FFDCC66F78A495D9
      3FAF0CDDFB03CD1FBD2F07E2665362BC7208EDC822D70A46BBCA54E52D8114E2
      9B092D5DB2D1887D67EF9B51125F760503E201D3F007B1AF4A221B547B3737C8
      9B5D054DA34E9678B27FC827A54BF8D80573D16C4627AC684CDAD473F09382F7
      81EFA9D26C923D6E049EA31E5BAAFB00041EA3FD1460BAEA442DDE2223C658CA
      321420C321F9859C6CE968E1D2717868C5A42F7C5FDB51642E95281AA2CD53A5
      0BE5E39DF0324FA9EDB99307CF39E69F84DE804DC6AB55277B7FFC08F4E43DD3
      941CBAAA13C1BDC1FC2005B92F96816753E9C44530DD2CC2C076355AB6747567
      6C5EF7266CFD597E0633D284D07FA87A342BCBDDC4F3E938159C33FA1DB92223
      8D1512F1A43191643A7C106F3EC86EB883C492236DF1B52BEB047142F891AEA4
      1C47CBE4E00DC1655991BABC7486EC7742505386D3882387D96E8BD5BEB82B85
      BAA63DFDAC6B2C96AE3E70544A30BCB838FA30461327720A16F2E48075EC854E
      AFD874ECFDF56791CC7F739684AD6C8675AD3CAB1EF0647BCB40206DF0D59DB1
      566CC9FE1DF70039806E35BEFAB4D67D19EC625434D765F3E2BCE2F0DE42A492
      4E84A57AC0D4A57D9437A25D1E7F9AB767E75823A977ED49CBDB1E3973560C42
      CC6A5806C65BF5119E281AEFEB28520A4BE3188CDB204B550611B7844C8D6A45
      E8420F67237811F15815CC60964A2A343230C28F7664846330748E2E3EBD4521
      7A2C42BF580E6177C3E91A13B45F31F9F537477AEF36809C6D6FDD49D0BE3939
      238FCDF391B1BCCA19D017F808852E176F9C20A451DA31275D4724D16A62B72C
      FEF876493319E8AA63B36F358F8CC2B98C64FC1C71EF48FC0BE6ABBAA66B6391
      0CCAAF486F474507DAE76EF74A5E5908E7AA6251CBDE7EF02CFB8700B8FF1E3E
      48EB5D4A43C9D9CE8C64CFF97CFC694FF983CE2EDE5560C9BFCF2846958C6A53
      36EAD5290C2E5D6459329B53870230C2606814661C70B4146FD630605F4DE5CD
      87F3F3D76F3F7CB8D051C0F0768C752B04032B8991290CFBAF38C0B758FF6E96
      4428D40E9DCA3986E2E3E6CBED44FF9A8874A40225D2A1C35F17E4D3361158B5
      AA21338847111AE27739154980C45C3973D0F9EDA0F7DB397B3571C8012EC38D
      F1252ABA43650002CB4D7059BB79C41E8663232C39A28FA3D45942502038F6AE
      A3D10CC56CAC1D414575B5B09EC6336C5D18241106A1843E3570E21604DA5B26
      BB60E1ED23D978497A1D224C9D876FE98C7DEAAF300828119E3F37A31EEB07B5
      0357F689D2616566D9BD0B8CB1BB51CE0C186C2FAF6282E041079A6A246D482D
      133372DAF0AEA9340E950E9C3730BFCD535473EB3819B0373615797AB07206FA
      C155E0CF1452526531A3380BA7696011370A0D9167A03FCF54BA46314F0550B9
      689DCEB30BCC49325AEA881F809C3F1B503851302412C4D587A968411E7788DB
      31F122F446026B188394B78361F5C120C824F99BCB0A33CA756AFC6C14498383
      2B89AE3ABB1B9F087D9C78A357D1AB634C97856DBF1EC7055FC6E625479F2149
      D8DE5AC8875601B48BE1C9A5E682022031B0CDAC4B38667FE88E2955B3CF1208
      D1AEAABDAD6C0D644A8B287278D3B1F51D76D8436524C980E791C851F9DFB3C9
      14686D65691EFB0B41D9A7559B96BDCE31BD78F57593E265D50124024BD28ADE
      CB7C1B54C707EB5DA46A6ADE15F0AC14843B2390EC8560E553D5A153389E1727
      E7CDD7E7E7275C08E243630F931F3CD288843F52EDB5F02BA6B55FA6DAA26F24
      6A80740D9C5F358002090C8BAF2A6B2B09EB7A4C29AB9A955CB50721925BB187
      552654FDA4FCD558D89972137C7193075A73F9146CB4A504940367E793CA59D8
      DEBA2544B374855236E6580D8707BBD8A205DF74F40F8A792106E0F503CA7548
      C7B3E130242910244095116676D35D28CDBA305DB9966BD9A8196087A9B328E6
      726CA719355D783C5521E39C930B32FC101404CA9508224CEDE408E3C890FEDF
      1FFEFC8E257F3ADF24CB820E4959B6A05262E2F508031A28DC14C43A23FD8573
      C541B318A21C8ED5F839DD15855B1D0DBE1C5D0654163848398704F3F0828104
      87DCF4543166CC28F435C1823B61230731401344D48CBBE12AF1D6B88317A826
      F1E976A649EEE5926798A36829EC1DCE2F472115529108A715BAE5E1EECB339C
      D83141B52160EA17454CA68512E077FA2001E4B1F5D9E27D805994DA0A9FC669
      32C0C4E76D175FF92FA4D53AE740E76ACBFB8C60F33D07A907D714A745C93229
      9B4ED53F2A37E8789651911969D7A2ED4966D3CD7111FFA25AC44B23301E04A9
      A1EACA0E813CA3B21B0D3E81553CF3A45602E69E7111934D783CAEE999F7A831
      2ABE61F96A5A34A6614464B9577AA5DE07E990E37175131BF9BE423C96ECD34B
      A88E777DF8071A7E3233509126B298A31F718342B86B4A558DFC19D571515550
      A3DC652E7165EF8E3921940C1C5AA290A39E1144331B99BFA50BC66731069F6F
      C879A35CFCE2CAF38873447D38743E9EB742FBFA9F806D9FA42A8C515EA4A651
      67C7F0E30893522FC63AE01D2B0EA1D0B10B789F6539733C3392B51210657582
      5AE8513E25159CDC2189C41B24C0E39C148FAED19D7A739195423DB19B5DE639
      534A6220FBD606A1EEA15331964FB66BDD6856C6D331C994E5790BD523480853
      1C05B0F29A4A9A5CC7799E26D0486925519E0753EC024119E4778A274767088F
      8FCF92385A7927B0681C452D492FC7011677C054A8FFC7DEBB36C76D24E9C2DF
      19C1FF80E93D71448E5B545FD037CD99DDA0484AE6316F4B52F6EC6B394E1480
      0209B31BE801BA45D1BBF3DFDF2733AB0A409394E4316D41433A6628B21B97BA
      64E53D9F948A88D537556338152F66393FD3F4B3746282086EBFC5C2CF084A75
      EE3C44553A71580C92826286B1D20FDEA24352F1A4918F3D0CEDCE8B5D99B6ED
      235A1BB8A99586BC49A62A97C249D361A2CA75B64CA7B72A3C05F9692B6F748B
      2485F576DD3F7A164A66A68AABC2800AA41A56CDEA5CD8B8ABEC82A4F5CC5C2E
      8D186216A5A6F2B2556EC6FBC4F53B4AFC79B6EAB3F656B70B9CFF29BCAE5DD9
      DE4A03230E1F61445BD80ED6C75D67E88DBF7A7BCC24CFC01EA9E5C85BD30B8F
      81D2ED554CF0B084FC373ABCA2A4D6851058641B62DA998043D79CEE187D6214
      AECAD45CF64475B4BC78E24BC7086FEF2D57A3B229E400DC6D83E9E93D64C573
      A6DAE5C45470501588BDD2F6F63343341BB6BE967201C78524C14B6C32AABDDE
      D62E272E12B9B1328DDC663140C8194B94444EC9252EE5FC96125186225180A8
      8C66DC4123BCAC5C5855DC3A972C447F0DB7BABCCD476E1F4A3112E969B39960
      8CF1136F3185C2C0B5D04A9AD8BA20E39B30993DDB65A6E581B3E2561588AAF8
      AEAC0ECB772A12FB98443F4E7539113C2621207F98C60BA9046436B0327001D9
      AAF518AF736EB995625FA28E380DDCA4993A585082FC0007776C1A0ACD36AF08
      7E7925515425DDF81627F4F6ED575B72CD05C8D4E6ACD255F4846B1A3403635C
      500894425E94CA52BD5B2AA00943A83E10C3D1EA33ADEE3B1D1A3E1E9523211D
      40B78DA000EFE69C5AD94B6EBE8043FBD25CB24BCF9541B4CDE4EAD3BAE562D0
      AA4828FA55F1345C1003CBB3E5C5658D62715C2B8F77E8C1B630FD23145E432B
      32ECC1AEEACA2C6D78587343B5E7C1CD73975BCE0C451059A573EB76DBF2DFEA
      E70437B75DC22695DFACECEF0FE406E3E61326B792A867F52C3A42A92D2C732D
      53EF68DADDE5C29CB89B05338AEA5291F7E6AE5DF8B88463202C2ADDAC62512D
      73B625A9F78105CBCF4D16B5E148F4CD86E97901DAE4E533C4B27AE2373D8B00
      5D025E7191FBDC1E5517B8A5C7D6981D651494B0B8B8355E4E6995A9ED0C1FDD
      BC040164F65B7B947142326F01ABB3ED636BD332E64719F12D0B6217B6FEDC6A
      0C3485670BA96ECF2E34C7C0A89E295C5FA31DB57260E5F9BC6E6ED50AF11B57
      17C33054F11D336C9D79789991545F216FE350DDD412D365B98DA263B897E170
      55607E97EC57650785AECCDE4872CFD5EB1ACDC5F8B9A3ADC79E3267D5281022
      A52A3898A70AA248A93C3D125B8AD7C4E210BA1551C5CA6A549057C80202F582
      BB69117344D766B5ECD3D4EAED4EF560E82B4D078ED268744187D2E5FEB40DBB
      711589C53291608A2DC62DC4AF56535DBD0A02263DCE1DF9525F753A3727E83C
      F263F08ABD911CC9216869EF5B3D9DB7BD23FD6159409A617BDF248B6F97419B
      92FA4850B789FB4230E59A9C90EA423F96B0A35DA8FB306957DCC64E7BA5BCAB
      EB248DB26BBBC63603F5BFDF11C024E1E8F0D2BD63444FB37EDEEAE857C6FD99
      F57DD30CB7285C1D05FC4BE71D1D29DCEEBD7B168CDEE138FDE38E7D8B93E7FD
      212DEEA8F72B3610B3FA39E419813E171FE8DECFD8D269D11DDEB9AF74FF1FB1
      B344F0DE73181C8C7F7E497F117FA955933563A7DCA1C470C9615BFE4DE7B01C
      35B4595E4F63D913FA0E6BAE17C6B5A12B6DCF1C945DBE4CD94FA68A664D5AD8
      0F66CC0A386B71A472C58951D8A714835D400680A76673C6CBAFD808763DCA28
      A6247F4AE664C3A66A38ACD95DD923FB59A1F3F7A4A49E6A357DCEBA65C8C0CB
      EC2C602D51AE17BC613241CC8A10888EB747952294FC95F042105C66B3A6BEBE
      6645CA736F6F3AE30055BEFDF6595113359583E9FD1721D0191D45102FA1D72E
      170CA45714A6234799799CA5171927732E0984AE462E964C1EBB26204E43813E
      FE424BD17B90A5E88DEE598ADEE8B39642588E6BAEFCAFAED854E012EB39FD16
      40CAC261DFE9354FDD72551CC66213BB6CA5D2FC6DED321C54F93CC3DEC5BD63
      417CAA38D8D63BC767DCB60E6FAFF69BB3EEC5D57673E6F126E46E1B287FA993
      DE0CF2766AC313857F26855756EC9F22F25251FBBDE8BC7CC33DA4BE1F974A1F
      4585C8F50E319B95F3DCE04E15FE5667EB431BFFF4E89FADADAD4DF1ABCB9DB6
      C0CE7AEA2474C8EAC886B80BD9D7296E51D3507259112B2677C59C4ACE4A490C
      40B5ED0E20D8712B8BEB70470DDAFD230FFC5B9D687D2DD7B38489A04A258FE4
      546FDF6A39EABA135C62405336C68968EC72C9D1A89C082E3D92F3C22DA013EE
      926A689B1F6A825FEE68FFF8E127A1EA126078519E4746B5354C841B72D45A5D
      50C91ABBA9723A9F39212366B9C3AD5BE922618E433992A49236309F52D2259F
      0B3B377A9ECDBCC483395652E55CF44C70BB994AC5DC5B7DBE1DA9017FB569D2
      56C32E3BCE5734E72DEFB568D372C48B4A50FABDE939446D27C9B7E786A6E73A
      75C9B47CA4380BCDE8F12E660A2B95C3FF14AE5C8247DC3CEE034FB02B5CB583
      798012C9867F2C6E373A3AB727EF6D888C611A7E9FA8157CED3B8A4B362B8E3B
      0ABB5D62C265A4952054E52D85452207634D66CB99792B88F4524D4D8A8849D1
      365FD5500E8C8072CFB592DCF5453185084F3EC0BA0F70F4457D80EB6B67764F
      9F332D8486162C227A22FE84CFD9F93AB51AB6EE1C72AE6119C7BFA5C50F2B58
      06C39F23B365144F82E38DA295D709F734325EAA45B298BA9AC28D0A9AD1FA5A
      BA59A236D717CE26CACD4C6E9ED4515388F8EF4BAB0C821202060050B3CC5433
      9B4DB118F9FCCA22F945DF015D6097DB54E318FF3B67C0D01DCD5BD173625EB2
      A48EE12CDC348B8F4C91534BA4D91A73C0D2A5EB9AAC91A658846084696DEDF8
      45C2915CD24AED1D02B1C2396595CCF0662CDAFA1A2DDBD98C925B9E53BE4440
      E538C6EDEB5694EB7D8460B77EB7C5B54BBB6F330417D4A5C2BEA842B9DCAC4F
      9332B6BE26885E9A6DBACA90CACA605633576F36A507F79E3A9C39DACE799EB1
      D69609D44371992FD32BAFC83CD797CF3E946657C1ABFCD8901E82761EABFAF6
      2D2D709A95456B8C26309B2F2003B2EBC7A4CBB53EB114AB06914ED92DF0C2F9
      076A0DB06EF554A9E97CF5921ACED27ED2BBEA7AD7F80BEB5DE09933E9224BF8
      28690912615BC962DFB9731AE116512E3A48C4D699B86EC1A48E40C3582C3931
      F4954E938BB4FC36A36C72F2E811B3BA4CA248A7CD1265FBB168830ED4E9DE35
      B05994D291E9924E925D94CD76E510F154E55E99B02DF96ADCC46DCAF099EB6E
      59E2F37FE67E1F82C2132A9626C76195B1DCBDF18F5A12B19142E9F1E462D2A0
      2991DE8C18CA60A535A9EDF27A1F2FBEAB349D3022A9B55B5FB2EFDD92DD05FC
      5A2219DA6AF9E0861D88B34287ADD54615DEAEE95126C776D0A9A5CF1A682B31
      A6F8B5D2DB9A5D96B90037518E1D814DDEB17F52C4727B88E2F3C7B02EB3A92B
      B7818E5BE0E82CE7E2A4BC4EA9CDEDA6B451C3F45DD746F1EB1BB92B63B209BC
      CE2E86F1B694103B05095C82BD5E989462A2C38E7546CAECCAFE729CC590552A
      ECEB2DCF6C7F6AAB7FD2DB29CFC5D578C83A70A9032FC3635742CB4632DB5392
      908A7EB2730A5782AE2D94D7E3A91CAC9EED4FACC97DE7553030F2A5BE43D96C
      7BCBB43039B4F4B4C21C3808326910576CBA881EBFB8EA90C49F9C9E92488371
      D319EC4FF67B09E37D500413D27680AA9C623E37607FF61CB0F8ECB9760305A4
      6246810E53949E949098F76F78B9A98B0F93EE103FBBE37E0FFFF446FE18FFF4
      87431FFFF8837107FF0CFC095D32F4BB74C9A8DFA34BC63DDF97BBE91250CE88
      1FD3994CE8A26E77D2A1ABBA3D5C47FFF6473E5FE70F07C3DF959218CEE83741
      256D7BDE2BFA9F5946FCBEE379DBB688E7919C2651D21CD9DA1350EDC44974F7
      44750F467525B9D1FFCC5FF29F233EEFD1D01FE1FC089765DF59924BC5EC8685
      F5285D66DE5FBDBACB8C0994C33E0F0B2ABB21CC7FF3A15BD564ABE8C5BF9D98
      368CFC79F0B14A92BCF1C38B4CA548BD48458637AAC9BDC7AA9BBD2E11995995
      3E7F5C66D6715A5A110B15B40524F9B6473CD7658BB44099BA3A03D09AD543AF
      FB04B07B47677AD83147A694FE05AD36D56556F334CC656590EE8A5A529B561C
      E43E3725AC26018A2E36C687D48ED6B2CD85119187838C3725B5F3B6AF3307C1
      B2ACDAB346E647AEB0B96D20CCAF67BB0C165E8407B53D9A1275C096B255793A
      B5F1361F93B925E3E5B6A61528D00AE8CA7966CC520C3D5C16658A0B8C3DE9EB
      B22C9EBCA52BDED2C917F59652C79723E299FFC1E46609D910AC66DCBC066DD7
      F662FACDF776A47CCC1A3BD4BDD4B4F22008BB976E659FFFBBE512F8CD4D02BF
      7F7F07186C3366B223CE9BDDEC3A7D293E223B997BF681667DD7741EAB20DEB7
      608C21B170E18D0C7E65B04A6A6BF51926CCBF8478164C9E4312C96FE72F88B8
      BC0D8ABA6D7A2F0CD0A4909DFBD20A914D913C46C270DC3937A980C542DD9452
      4730538CB7C53941F8B5D40EDCBDED6115F4FDB4D0F94377925C5FFBC8FC03CD
      CD1C4B4051D18FEDC4EF4E2DAFE4965B6FD56B7E64AAAF395BA1F288C21269CB
      DB88565C549B12C29F995607C6757B5C8BB7262903984655AFF0672D3A75C3F8
      5C68E9F3D38387B633C4FF2DC161A2983F9854D6D7FEB971D7493D22BCFC4F51
      0C5D34BF7D581E2BC336E97605A51D93CB894286DE54057A5ADCE2D78F845D9F
      5FD65661A32CD5B01E8FA46A6FD53A15CAB8EBA0C736E747D05F5C0A94859D66
      62FD08DA4B4E04A3A4BD495849D45AF518A6152626EF5ADCCC0DFE176930923C
      5EB8F45EDBE2B0C848BDE122D8A7332167422C3BEA4D972DF3500A6709E9D534
      2F317069167AC980CBB67EDC85ADF993C72D3EB1B73660F082C224049AF18850
      25398A53E9F1A26EADCE466D79642937DD3211D0435E22F9ACC2CE5144C71545
      D4BA3E2B469290CA086EDF636246CADBD93B38B0B97ACAFBE1F46097FD67DEE9
      DEEBD3F273BA6AD3B615D10402A97202DA5A5F2B5D17DC03C97402228FC32DC2
      6066E14A42724DF1D8A28630E7AACD239B602B2A856D692DBA4571D7C32B4D88
      843A1D523B992BE4DBA1E855A566CF867F6D323655F750CDBF7B99CDC5B4501C
      D4614A7AAE7B1B8E9125E42231EDD036B90FD7CAEB1F2BB3A8C087CAF23C9223
      7E9EB9BAA3D66C750D4AC45008A8C58DB7411C54A0C05C028480BCDAFA493A5B
      79C6A0663BDF6D324E1931861285AC06F82F724A477FA405D944E26BEDA73F83
      0B720780A2BA018F48D67C740DBC0D570D6CB5B6D5BC5783AF452E5F7BC99D09
      5B26D065DCBE74990077DB2CF52327C75C5F107EF022732C980DC49F2553CF5E
      BAF157C788ED47361D4159A8CDB2F5977BAA60FE31861EB454AEF10843EEAAC1
      55306668F35CC7C987121674EE92DA9355FFFE02724E709335A3A588711BD068
      F120568249EC72873EE985220AA562B4BC7C61ED6179F3A6D58AA488D14AF39A
      9ACBC949F44CE98A8241DDE845D9BCAB5C4B239866A61530252A322E5A29A045
      3DC7D70E36F107695EF852821216BE9877F0E8F8DC33908D2ABDA937B337418A
      9981A22A43156641E5AF242F3B833DFAB61B56B30B57F45E6F43E075F0A76958
      B8F9D8D4E0D6ED256895CD7F6AD97A16DE9AF1F6BC7BD7D429C896A42DF51D55
      D0BCD56285E2E990D94168C97C32F0D1D51C2707BE59A375A30FAED47DDF39B3
      F78ABAD5F0E124D5D616E1DC7E5DEDC906141B3B74C1F8B0A6DBB8AA76B1E67C
      DB901720AE30070354487CD58E6461ABB4CC9D8CE97A9158A8E8F0324BA4D951
      EBBF74613B0499FEBA4799FB6065BAC60E2C33CB6FE363DBD9DE39FE6A75FD27
      2662D4FC8DCAD2D6178B93B9CD6DB787B1690BF03FBEE6E5FB0CE076DD932652
      8A119F56A56A9BBBBFD44C3BA2D55F75FC25B4C2F1DCBAB55683F16F1B7462DB
      B5391350EB64014304F698E9CC5C54A665F6A0BC8520034BBAC7FB565645B0BE
      2ECBEEBFF29CC2CA747BD5ED75B6EB26C598DF1B2D76C768B16236D575603C72
      E73B1A9168CBCAB474AFAEADABDA992DA75524EB472B5AB8BEC1E876D422858E
      E7DED9C163911FD22FD8B2F20523B9AEAA9A7CCA9C9EF6EFDEFF7AFDFAB560AC
      8317CEE612BE2895D699D448C7506BCBBBFECF5FF9B62DD77D2186CE5C874C5E
      6444A45097D2DB6A6E1D2BFF49F3FAC38EC7A9368D00DDF9005F7D44FA952BEE
      20071B41175AEEEEC8AEC03D0C7F0C6BC7F90D2AFEF38F1B8FAC15DCC783BE1C
      BD530157BFE21A917691979CD64559142CBDB8B18EB333B99BA422B899C2B62C
      AFC870514484969ECA8DD7DEE814F6EA947B48D25B679A550DDAF8E3A3ED4397
      D0F0959CB2DF14B87DFE3AF97042DA0D0E451AEA076F65FCE261E3CCCF8FB28F
      0DF8370F9738C23FFE1BF37ED825A67C2222AD071EED032FEEFA1A2FEFEF34D8
      EA51B3FD862FE424529646C58DE7DA2F72AC9518E54C3A77190C56EE4632DB3B
      3B4CE227E4AB6C3A5573F1F21D7156AB8BEAABE02B6160BF554D70F3AE26499B
      BE8C0C56F5E3F39FBCE26616645393A35C47930B650D457F76DD85CCC292619A
      43B4AFAFCD417762119B4274712917F5BED565909E95F4F97C4A8DA439555A0A
      40F1FEB2929F55F299BA317E0C8ACB65F945466E8E7AE92CBD9712A31D069C91
      FBF4923063291FA8F08A01BFF32D6F433CB02625C076DD9691796C019385C025
      0669B6B0BD242A2904FA83E2E8AB7C4177AEAF71BD9DC1C8E4A2856451D6FDC1
      4890A25679A46BA0C2A1629B2A65A340928EC49082AEC7EC73EE318BF9A58BD2
      5B16E9B6CDB1902DE2BDC04E487BB8D5B5E78C88B28DF46AF3E93DB300D59D21
      7309EAD59EDD35BE945AE1BAA790BF893439AD526EB441C55C26F3C8F8D2A35B
      7B65FBCEAC6255ADB4A5AE3AE8A5E5A19D849DB0EBDA96CABC69AA51F23E89A8
      CFB82535EE3A51BF5F2EAEDEEE96F08E076CC936C94D86E4C3F2002879E64625
      E92DA4AE2FB49706C7D4C05849C9B3E2B0F4ADB7B8B5E5A709DC94E6145BCEC4
      AF3FC3CEC42D1897962636EFDFD18E497701F9B44D5A7FB5D553B98C96702249
      DE8BB2655025419B3DA68B84E829E77EC636B5A723F1912AAE10C7C8252EB3BE
      56DC09D460421F9474658029D4340735DE08F0577504DEED32AC548236E23535
      E5AD347097DB63381E9613837DE490AF4714F03B0E7E068F822527D6D56B6231
      DF62BD1F4FC89E1CF7762964215A8EE759EBB35C155B2B54E2A724D4E0E643AD
      549B92E0058C808B558DE434C7F63F987BD680ADE81B499BAFE6A2B8F1D8611C
      4A1BA96FBCEEA3A65BAE6C2BF723AD60669441EBC2F0944744C54E8973C5D1EC
      FE5825E06B2B79CA304325D65FB895FB48DCDFE494BB2E5A55895C84E01C1957
      A5954021E2DB915691D9956D6A571B9509EFDBB0436625B756E1656580F4061E
      E0AD27D0D78F9BA1DB3A93F5352F869ECAAAADC93860A1EB320E1E0B38DCEE9D
      932738F84414B25CB3A219B28A9C13A9196B9A9C804A302FA4B009571BEC7A76
      EE538AC505757FBB284F9BB19B5AC5823EF9D1BDF027769BDA5B5CF1729A9904
      63FB8DB30AF0D40B53FFD9ED80DCA1369AA09CA446D3D048DB832E79C9C08C17
      3935E6AE8CDA9E5D03521A2AA9C7706FB0D8A9E4CD5BCDB266D034E96C632224
      B65B3269A8AB6B496658A5C36A664B3D8C2CA3C04871037B6246792C5FEDF1BC
      D34314943EA2CF399DCF69589429F48FF5B5DF8B0330B839B3596A3CE67C478F
      E2B89308BCD7B5B75A4BF3B95E48B7670F5ECFE536A7CC4671E2DA287A670EED
      CBE66D6067D9BDC70967741C6DA7700161A5B0A4D84EB5BC3789A9175B8B0F0B
      769DB09D575C25D26F96DEF686B3C2CBF7B1AD5F5351E98D1267851D9544EEA6
      471F6F7C835D3C48D22BEF85F7FAD8A70C73FAEB519C3882BBAACCD9E66E90DC
      7AED9FED59532949C3E9322A05CDBE7168D8548FA2D644150F941C17F3E46A8F
      1893D7523643361F5017C2F64ABE569993691260925BCE233E2BE439717BF871
      20D8D6895A5CB61824C268B0953ED5B6B880046ED9713ED4EE2D519BA4BEAAE8
      1C7728DBD4242393B45C99D4BD7D862A29B74EF127E5183C44E6A0ACFBAC26E0
      5D2CB6D6A951B0425D34817790F681B24A25181BE8B237A9A82D34BE32A997BB
      76B858EC03174A321BA6F781B4AF7EB708CB2D38367237CEC4E1F9D0E5AABF97
      60299B01D4A9E536A963E34E1D2572074F43D3DC4C4568FA152C084A41C32707
      7444F347CFEC25F466E30855A7B9D85E6510234E3E3C9A862ADBDE9452043D93
      7843F988772E47C55298A9C81557DD5A4D97835AE9187E514DF6D84F25EF2A54
      A61B44A15D0AB1C9E2A43E4ED7D53C9865EADA8047DEFEF96161BAD797F00195
      EFA9906C195E92FC2A991A075E93103281DE9514B3926394E537EB6B91098F90
      03C6A0926245CCF6D5DCD0774DBDED30F5B98EC136FBB8E52FBCB669C4C655B9
      1A26303CEC8EDA598C154B4A39C90C6F5A96C79AE20937541394086EA81193F1
      5E76CA0A05189D741517188A52C8735B5FFBAC1573D24456AA859558E6D4E5A9
      75C7A298793048135D5E78DF1F6EEF7A273959A20B8E15C632F3D6D9225F868B
      1619F4AD6DC606C357F6438E5B4A56D14C13AD563567EEB4F559CF6913922D0D
      3D0F92454EB51642F90293A425DD6ABABE46AC8B028A6505C6FEC26A45354584
      E02868469BDE5998277373662AD3AB3AD3DEEE7B1B016430611270A089306D73
      75F12C7D4675FC2EAAB19A7FBB9FC699735F638923E363A03D1661CEA9C5970C
      F6FD9922EFB305DE0DFE7B3E9B3DC74CDF163A7FE97DC07822FDE1A577F3BB40
      D93D6C36CA51963E74D28CB791C8F1EA3CF230D4FADA5BD6BA49D1CDF2FD5DC6
      559BAA0BE1D18A1310A9F732A58C3F12790AF176BE773678710623CA98422F5E
      1F8F86DEDEEEFEB93DC295F47B1283255A45DBD64338D4FA799E64B949B70FE7
      C7A618A1B40B5CA05E123D6C2D8E48677E388982948D8E1CAAA4755A047A4566
      2A73F396F78A4AF51675734DB212DC3E8BDF83DBC807657B40110AC697CAA1B0
      BC9C88842BB8B143CBD554D8D081BDCA25A16E97D621B4DA0B72892D72ADC05D
      ED18C8A3714D20CA7611B135E532F25C9C416897617511D833CA89A5E5DBA423
      8ED84FABAB207731EEB8187769C65E55420BA3D1D51255D81D8B83F0D8590407
      7A245B26344544B0665EF07A524633C8E591F006C2A415695D2A6CE2059428D9
      3D8B94DC16E8C97DA3493E7F3C20FE87778D962966A2B854CA6B37882F4A2091
      72B636ABFE91F21CD5CA75CBFCF74FD3D0633F6646A3A4AA2C4206D9A0853E3D
      26BD14DB41F020E29A2B5D581B8414D2F6B677BE3D95F058DB3BD83EC265276F
      4ECDC547DBDF1FD2EDFC44EAAB6975D88C71D836362B3E296E1442FAEFE62339
      CDFBA9598EB6C557B9C334A8EF05AD124E81EFF6A4E2B53495B27413392E4B43
      CC0410EABDBEC95DC86D35B8765192C3B9C50DD548656CD77CE37D687B375528
      DB5A2DC7C2A140155AE514A8277BA252DB2A43A73248B654568A7645B08A1752
      8E27C5456D01FB26930FBB26255C5A7FAAB18C63764F89CB4B9A2FA49AF50992
      A515A7B35B5D8E7EAC2EF19D446B2BBA2CF1D68D3007318329D3ED62B2E109DE
      06E72C50FB7641B7E288EAF4C62A35F58E4C587901D869976AC23D8B59CB5E5D
      AD81AE2C1C77412FF140E83A7A14BDA5A8E5292963407EEC404B695C49115CAF
      9398C7B5B9F0D4745CA7454DAC6FD9B80B7883318A5C3B0705DD77A74B5A2A42
      C975413B547AA325A984ADE2EA0EB8657958439559D243DB7A330D15F59157AE
      521DC2FADAC266349B3EAD7CB0401A25054A56B0A5E5472207E4387EF41CA6D2
      E633B35D92B87CAFB29206D9CB1D42B1C4A27695B7B35DEDBEE0C7569B6990A5
      9D0B148A05C62A0BEA0C7C3A819EA79C192C1C56CC158E11F1C9E6330D258E0F
      B1787DAB3C2C585E18C5B5665DB951B38555729B7241A24492506616C4BDFCCA
      F21971E456EE16E9C3BCD765BD597007B2F864214C1F7BBB46C45E3975EADA44
      1719B5D774846A97A9E1563095F3E70B255D797DCD145ED22D2495E83BC270CF
      0531C648A715627FF49EA06DEBE62E1BA29147F58E36635082285FCB66B617EC
      985D526CC6B82F1E09E338BF3B43B33CD31BAC3B91AF1F1ACF3429080DA31E4D
      30FC04AB8823C5A995E4EAB9BDA2A209185BB3DA1D8A38931424A4025954AD82
      A0144E5721C1479D7B0BD4D235F72B7086149736681FAA10852E776A8EA06594
      A320B5C6C07AE2C992C5529AC5E5130DDA6D2DE66D0B1BCA7E429C7F83275001
      8CA26BB6BC8D5752174C97A81AFA61A502AA9CA36838C2894D45711DCFE49ABA
      CDCE5D9DCFF9E5FA5A6219D14A98069B9684DA6840179A63EE2EC541DD7950E8
      1BD18D4BB150152A3C3A9AC74C1CAAA41B125737952CB719712D57C1B2CB959A
      B1F67D59C255B96216D4A638716E823C7A7D4D7BD0E029939B041A6DB8B06D29
      77A25615957C063B9CCF48527EF4CCB475CA682C2DBB469792277D5766CB23AB
      7DE49A0FBB3A55EFC3672E932D4DBA64F83A9D5ADC1BFB8839B5CC0C74A8488B
      4A168C264C6EA6C25DC8C9B99794E963D8A1F08CD532DE5A7595858335EE7FA8
      56620B96961287301F3BD91F1CEFBEC1961885ED9150F4F72A673C5D99F55D89
      16665928D3876B33D32B4A95D04596FEE99113CCD92547D33211A3F32C314600
      C5C867E44AE6283A14902C7F2C5AE5A1942414A508774E43C3E2C89B1873C16B
      9E2FE7DC2BB7BE8226CF65C3293DE4863A524735F5C165AB11B74DD225536A44
      10E3123BABD65A545ECC38D4A580FFC8685D960CED9E97859463626B62EAFB4B
      A151F36709445A6FA345592257293DF60E6AB94D2B76C419F63021849B57A4C4
      1591921821D744092C5FAC387828B13F880C733FBD4FA6619528231BA0C88B0E
      9B5CA45CC9AD1C808DCBCEA180AE444AA1CD2FB86317956CD135419E5D89BA97
      1AC576CBFBAF6C2922E78A7DA401E9F61C9BBC7EECFDCDD7D77EC8722E77E62A
      D143CE1BF25E9418E6E6133A0DA76F53DA7F8157DF9E269CBDE0FDE7DBB3F3C7
      12D0787D3BA56C25F19AD6A9ACF0E7642B22E96550F5B7F349B5EB787076EEFD
      B592AD2A0BFBBEA0AF76CEF0D2BF32F084A95DA87E7B70861B0F3213EEE36F36
      EF09B414B0ADA0D2590C02D6BCDC284D1FC04AA4A54A0B92AB55A7067BC73DF8
      CAF4992196A7FE1262AD6CCFE7E06892FFC615731626B4924AFA480ED1B6F7BA
      D24D6D2565B26C632951118BEC994927942CC83E9874C96A4B36168DD364865F
      291C939429A8E629F65E3E7DE9FD8D293DA663C81473B82D221B81B1D5824B35
      FFAEB3D7E56D6DEB38B5C13F33885BC028ED7BB0635571E5105A56127F49F6AB
      F7AEE384B77166A565941421E8861AB1995BCAF4E0CDDAD8E5F45B94DA709A15
      A67C6375CCEB6B0F3CEAEA7805A5355BACE43198B5AA8EDDAC38C6697D6E5C4F
      C6B5D46D9B22224833E66EAEAAB1215C0A99D2763F2BF0161D2E2B71537EB03C
      88429772B32B45250F8DC5E7E0F151FF50F69E2F0DF8AD8D38B3196274945514
      5F7ACC63677FC2F7584BFBFAF8DD6F0450C37C430DA55C53F05540CBF6E3C3A4
      2062DE509A72BF5E7AFBD701FDF2171C22B984FE22A6F3925CD5B812DF9C65F9
      42BE2C5E7AAFB26C4A3AF05FBD73EA53F79787CF532215C2E0CFDAEEBAD0F203
      F3DEB9AB2BBADD348F7F59E62937E22B7DB916B1060AC2CC423933F4B409D43F
      6CA4FB8E652FEE586EB7A0E767BCCE052DE5ADF4EADF1820C70824D866A13AED
      FCA9BAC08C80E30F3CBC2D8A18D8C562C82E719171A0517A0379A120697B159A
      A8F52F720CE7775AD3571AC24FB0F73694C193E16535BF3F38411A18C687AD53
      2BE7B397467FE86C56E0E648DA91D035A1120A8ED834BEC234A55D06DCAB9A6B
      332EA5C977A5F9E5E5F24243A6AEAF15732DFE088EC1D20D2F443A728A121732
      E5D255BE8A3B561DCE34B9227999149FD169A7E4C18B0F93EE103FBBE37E0FFF
      F446FE18FFF487431FFFF8837107FF0CFC095D32F4BB74C9A8DFA34BC63DDF97
      BBE91230FA113FA63399D045DDEEA44357757BB88EFEED8F7CBECE1F0E86BF2B
      E367A0D3DF745ADE2B0B4DE0558A5D98AE766C5BB1BF982B023A4FEEEA172F60
      22B8BFAA67AD7CCEE65FDC050B9748E2F1CD9221872D3557DF38A518A4563EC1
      DD13279C15517946791CEE7CA14E23FB47E5D77F69395EB20A880E866BDE2337
      D6CEA50EAF60825FFDE536EEC51FC6F11E64126FD3294FE37326412CF69F6575
      3053389A6330AF437A37B126F18670E07925F9CF05CFCBD8B769CE61ECB782AB
      1F8B6CFA9E9F4CAE508A275F275CF220C57B16CADB46F609EEBEAC869F579253
      1E3CDFEE872C9F46677315EAB6F78CA2BF3F9EFCF4AC2D7ADBEF521DF6B042F2
      EE2974DB83DF6B12D03D576886F899E294EA5CB36259C9B9DABC37BBF79A065D
      D0A04D822BA556FCE03EFC7D36DC680C94B7CF9DE3BF0635C88CF9485161D0EF
      326AC94CE65A24ECCA9540304CD54541009D04F5C91D68C475C0597CB55C16CA
      B63510B28FDA8E7EB5BC3075F75F89C47DF8CAFB5C9B82F96079518D0373BE80
      C53826CC958461C2296C45BD7B489E7049FD5DB759C78D4DC66107B67D06E513
      19801697D7F4DFEFE82BF214F2FABF9B4F2184CC2678AB4BB032F9CF3B91EF20
      8B2F7177FF5D14F02F9D77949281DBBD77CF82D1BB850AFE71C7E6C7C9F3FE90
      7668D4FB15548059FD1CF28C40AAD0CB71EF67D0C594A6711771D0FD7F0479FC
      DB60E47BCFC9CF175E717A1F157E67BA489F2D84C9986ED98B6FCAF4A9466D20
      2630C4044ECBBE5E1C14A5F19B1CC112BC8123BD54067F61D2624C4FFBA64D68
      8409EDAA85BA733A5FCB2426988454DE597AE2D47118E90BE38D83D91366ECB4
      228056026B98976806E0186FCF5F3F1F7B64D37BCFC3F9CBE522C69F16B6A261
      D31DF7315D9AAD739F9B10BBCAAF24F82E89E9C6C3CE9BE87261D9ABDFB40911
      5BE09E6DA61B697A619C289CF60FFD70CA2D23C205A5216C142C50362B696C94
      C456703F626B3747921BE25214BA4D9BF2E016C9E65A30404C06F12C4BA928DC
      A6FA4E2987CFE40D4B726008EAA55858912C963518D5C6CC9198E595BE093212
      7B65583049998FF016D1488B9A1468DA248841BAB3146453022949CB5D8B9774
      AAA8E983C9A56CDAF8C774B6EC7233388E145926A16B099C617ED469B8E4884D
      DE9049754234260CFD32CB935FC8B730258E984DA7048A179243A2B0FED7205B
      2CB2D92C2B24E27CD3B0694D3A9816E93E941286633F333137AF1AAC89B4F07B
      F6329B0E0330C2C83D826D0CA8F4B469D322D6DEA294176AD56530165B35D83F
      49FF6AD4B8379CD5C2C1F242329D9FBB188F8D0691D7438A052C330E933C5CCE
      A8BC20E4F46A0B4965F2124D669FF16D356ACEEB6BF7CD5AA27D2F98BFD12F77
      ADC254DBCE25EF939C3A857BADD271D32A53B0AC776FC325069A95310DC60903
      4135CB6CDB90926EEA37429E05E291B42A072ABD5852226845B0997E21D74AEA
      8BB744F72C0CDE3CC8602B28D48BAD40F53CAAA8A68EC75FC354A11C8F4B059A
      5C415373A023CF4E51CA4161462862BE30F04A8C3570287B9532F5864204F45C
      E71A69F40AE41AECD5A2B473E717CE5C85C29651F115A5B5AE9608377A3EC673
      27656BEB6B151A26CC763AFFB892EBB52899C8F691A2BC1C969DD23B6A215558
      3ABC32556B82D526A9D560F0F24DA396034CEE9E054919F089FB115692D1CACA
      C11795AAC19BB901A7ABB035C3FB6C41CE4A1F53C9DF77C2DB0BF4946BFBB826
      A459ECEEDF869D0E3B39E686CD2B2F858E6B8C15359F7BEF0D909F38F91A35F8
      FB44984BFE3341ACAC52E1E92411170352C19FB968992E92A9C978B129678C36
      C3EEC5B2B768B3A7FEE3EB63FF27EF35F5440595BE39387E45C7F63ACFBE92F1
      7F4C9FE08E5FE05FB7C040A4BC9D1413DE54AB75701188D9D13B4882D16B842A
      1AB534F7AB669C0E2959E03BAB51D80D76A756921B37DB5EEB28233B627B3A6D
      9574EF023C36E1BD02E5C75E998631F1FB16639BF7B5B21A5C9CCD40452EB35E
      B0C24B97C966BD9092DA876C502D3F292A8CE6BB4961CD60AA0843FFAB58058E
      D251D192DB5ACC8753FBBF0A5D73C77AB560D22FC2E5C2C41FA5FA5A0AAE6CDF
      334918361D262CA0C68DC9604E9F2DBE86E99E823AB399B7FD7D5DCE5C57F2A7
      9B358D7BA8EEFC78A75490EB9C0517FE90A4A3464DE37E8E2A8406026CBD86BA
      C38CD2385AAE936871C905AB25385ABDD79873B2439BCCB5329035721FD7F3D1
      731A760AEF59866FF7CF0FF70A6FC308C7131840C9077CCAF8A754AEEB4912AB
      B7270EF74D562E4EDF9E785315E8A9730A9864C90C2B34FB3A667EAB0BA8A366
      832B564123B2103F3B42213F380AF92A66FA8AB0CBF1D1B754336A1A4816DE8E
      69CE85FD642591DDDD2F40BBD9D234EB13091B2E8B85B4319E35CD8B71CF7C6D
      517A52144B418CF13EEC2E67739955BE4C53D34456492509571C9963EEA074C5
      E9F555CC97E2635C1E257E9790BDC4316DECB17121D3E93635C964D551790CF5
      AA9406691CE610E8BCAF62BAF5689A495E627030F2297A7385FD2EE3F3D4F99A
      6060A6D3122743EAA0B369D4B40DBE4755AAB6DE3EFE8E2AD417256EC8ADA65D
      BCD98E9999F509B46B39CD508F8A8BD0B8D4E5C151EBF72826FFE0A987CDDFA7
      EBE0388E718A28CD0292A2D8C1556C8142440A264BCE4504EC306343CCB65163
      1EC5E19F1B26E2AF61B6CB54CA1D05E699260AAB9BF9882020B04C495277DD65
      2276BC709D420A152F96B9ED38D9BB94471901D5342BECEE45A824336809DD6F
      FC957E37A80DB6D726D4266CB560ED38F0F648BBEE48F8529078BE0E012B70CD
      6DAE71E25FC8F4DEA1EA335A8AC37AB84872CB89335762631B2753D69BC3F535
      3E0CD59E82924C7E932DA578B382026703517C5CFA5BFDADE19FFEF4A7667955
      3FE6C2E142D7237DCD46D41DDA26BBB02A924BF87BE53EF25C188F3E3D82D345
      74BC601F7EB5E590AD936DED662422F9B9D266465C9D0651AD259C888AAF4B07
      FF1DAF6581428DF3A8E3AB9A49D665A356FDBE353F3BDB73CA820B42CAEA1A36
      7377B79A6ECD4DC6E4468B60AFF5FDAF62F6DBDF5BC89912C0CEDAEE5FC504C4
      CEF642CB59605BEFAA6B0AC7E6D1962E662615A7F07C09D339200FB25BC57AF9
      FB929250F9098D9AF2FD7CE2329B3ACC4A9323C2193057DA249B4A74BE827642
      E4192EF2A94D29590D5211232E33146A8052CD588C7B0D1B5BFF2F2D14308164
      3E956E260E78C8820F8855C0E9090FDF36919102B8510305F2E8FD0F5D872199
      03D0D2C98E311BC842B38966CA3DDB55221273F695CD5B5AA1C6A46697802E93
      5FA838AC5933BCC710C321F3BE117B8CE6CEE1846F05B7F10E11C373B30E2476
      09D6001D8D2318C7777D2DBC343D93F9627ABEACEE5715A47AEB508A6619593B
      E0569A6BE1C3B267EC2AEA8BA18E2A08CF8A01CB5D5804EEF79A4B8E6A882E8D
      5A9A7BE51871AEE726F7C2355470D9047780C89678DF65D2066E64A434CACE30
      74E474BE7259ECB3DDFA5998E5CA19FC2A16CD20501061544160DA7772139361
      E18A48CB255315382D9308C0003D4DB32F3F25026B3966D566980E98DE252F73
      9D5ECC29E55FC51CAB11B1B6A3E9AAE16736CE40E44A050B07FD170E3F9BEAC8
      CC02346AD2FF36EC76295A2B20565CE54604CA9A1C74D8B9F86C4B302301076F
      DA147AA612C5B268CE515E504864EF8C5AE2CCB9BE5BB27E69C732CE9EC9138E
      D9366A32F7660EE5AAB89462141586C633AA3875DEB4AF153B9D9321851EDB98
      F8FA1A97424353C0B55AF2C6E68A5C5D821B1268D6D50DBA95746227482E872E
      6A4A8FACA54607D9BD49D93CE212CC7D614A9B940CB8514B7BBF66D0FA7157EB
      F94F2E7765C3F682FC1FF22F489DDD66EB9369D694E332CDB22B8978586F1087
      6F6C2F806ABF784663A13255D3E4A9828CCF5006A4D635B0F870D8A55CFA1313
      4B35E65D16E939D1CB2257E9B43AE83FBAE0FAEED2D25F5B70ED8F574D315772
      ED8FA5E4FA4AE764F4F7879F5A54E3A94AA53B87D881FDADDE56EF3F1AB5AF5F
      BE2AF8EE5AF93FAA2AF8AD51D16C5629816D6511B9DB3836FBE16CCFCA8FAD46
      ED9B8CDBB5B938DFDD2E9B133571A06106292429DE344CDBD5FEF571BFEDBD3E
      FA5E2C8BCA6A376A0E062D1E8777ABD3A8817D18FA9E817868D0A8A497046426
      2B21EF559E483F0656A869C80697BF51832E21279B383A52486CB1F5030CACF7
      7903E361909BD20D8C871AF7BCEC93C2A3EBFBFFBCF4E09B3F577C24D3F7F700
      AEF063FE0829B21D4595263C1C48E6ECDFD0E2B63D84F078A04D7B4DBEDCBDB3
      1367179996513ABC4C4D0F2C03A7C4814E5852CD927C8F5D63918A8A37545141
      36FAFED1EB63E9F5D5A85DC22A5287F9B2096A2A3DE3250B81FD63DECE0E1750
      376ADC34A6B2C1B6F15236E7F03E715CF3344AF22002B24C4C223CA26270C6CB
      EEC14EDB3BE67A0B720655BED93B3B6C989BF5D1B334EA63FF82F99AB5C74EF6
      4EBF6BD41E81EDF65FC052F949BA610B6768D408F7D282A03A95053D9472332A
      6621BF54E1F4DB66DA8902AD86439A9387ED5AB1F35D5F483201998A591499E6
      41CD1AF8FADAAE81288D6E52354B42687D926119277A1AD92E64A6A8C6A22C2B
      6FA673AA729BAB4578B9E5FD40FE344A83593C4F4C073D3595B28DDAC392D8FB
      45E719D78070F626E14715849B92892A37153722A33713201D2564ACAFF12A1A
      E7A379B1786EB74C2F786E504CA11B7259521C33A1BC1CBA545A544313B4DDD4
      1477A8E25115D4F15C4F63930262AE260CF22CD5CD521B5F9D6DE3B9DEFBCED6
      A051E322CBEE6121459F17F8E0FE5410CCFE9F4B06993B087FDEEDB992F46F0B
      2521A99057DA0B9294AA619388DAAAC2A0305924B66A8513BD398984020672F3
      9680C05D2AEAC127E5026A1A2EA72C0A2465EA7077207190F3D719613C4E9320
      AF02D73F399CEF7138779F1CCE755DA7F745759DF5B51FCFCEF644D9D9616940
      699ED365E015CB3985A9BC0DD2578D5EBBD926D947A86B15AB84A4A1D57BB1D5
      0FCB3DFEBC1586E1EF9147D6282A84C63978817DF8C96BBDD12905DCB8F8E438
      F859878BA265FB834A1B93668DDCE9A1668CDB8B29D5DDCF9BA7D219EC8763BF
      D26DB551035C5F3BBBBAC99399F7FD29C71F5E5349E272E1D3DFE634BE849E94
      9AD224B252BE3F25C6BAA53F306E3CE6567ED0A64F4C4C5DE2A3CFA12E0DDEE7
      F4F9F338F3F19B93A1CDDA2969660631F39214CCF1F3086A3614C64BFD41D196
      85C90C62DC14E31A70E58411FBDE279124E7B75E9177C760D3D28A6439A1F51B
      C0FD96A8AF6DE9B2691E649B619529FE8C97D9A885E11CB91A76A4F39A266994
      49CFD6229925538C8A1AC5B58D2782B3254D834353EEC84963DC5CD13D2F4BA7
      CD026C6A9DEA42506B97218C48DDBA3D1D931E289F73C6DB5CA5DAC2EECFA451
      55C55C5169C3A6684BACADC3FEEE39BA069B91F7EA8693FA58EB2DA0FCE5380C
      36A1D179FD4D2496B55B82686AD49C298DCBDB20FEF53F107A9B876A7E4868BD
      79B1B5F8200DECCA2FFF73A98BC539814CF197D8412AC9E4EEA4943FC520B052
      AB6A9A1A4B2A88D46373AFC4647D2D0DA74BCE3A227554AE6BD48298B6729143
      61227775D23C11FADE148D07CB0B09F4F2661147999944AC668D37ADC4299935
      3AAFD3F6C93E9B8825D4FACF4596B6BD3489C13467E4EF49D414BF4EB3482CC6
      27CBEEE396DD935D57B7EBFA5FD687CDD684D127CF08E3185262CFE4BC1865B2
      511B66067CB6D754EDDC980FA2937B7E2317F1237244201AA9ACCD35AD6AD4D0
      BF62D1F224193E2A19BA5BFD27D950970DFE936CF85763BDD224C53A4DC9274A
      59E8C5542D3818670B93C411E39AAA84D96C467C6ECAD929D61BD3A889B5CE4C
      8BA2CF36BE1B35FC4F9B564F7CFB3EBEFDA4D3AFF0EDC117E5DB5FB176C72935
      2E4650E59217D3EC9AFB27680AB6366BD02EB6F19AB3411CBAA52CB400E569C5
      8E25CCAC91539075A79F66EDD5FB2C890AEF42C24C5C4D976B68DB3401DA8F68
      493DDA290065FCE284F62F4EF6A2CDDA395884D11D4CC607A11E922F85F235D6
      D7A8563FBC64703DE9A153A2F4909BEE89E97E82E93E05C85798EEF04BE7371B
      26B0CD259327AFF6B69B8838F1B5B890B9DD20C1E712B3D1B3F9E2C6C343D44D
      B346F9C1704B1AA865F1AFCEB69BD9A8C60E16246028C0A01F51F5A0A6826D45
      85C152343C85A650846AAE89E3376A1A3864564651F0FBB82F7F3D098C4F088C
      CE93C0A80B8CD1171518C59CAAEC9BEBB894CC66D3AC69AAD555138767BBAA81
      835145112796EDEE6F1F3470A8F134530B1B7CCE0912AB69C6978ADE2BCE1C38
      CC222ECD2ABC582BCAA768D430A9B5F2FFA65E96CCFF5BA66C97936C57819B5A
      351332C192BF4F22424164D49B46CD8A80C34D0E3143F5B037B0441D6FD458CB
      9846730B33CA317AC4EF4D861B79AE296268FCAB72C1CBD642178BADB9227A31
      56A933DB298B8E015028D5C4FF1FCE3781CEF13FD04236A5F89A92E81A3575D3
      74AC28B230E1D2075BED40737EE8B45BCA15C4CADD017BFEDBC463FBF718A9CF
      237DF0713E2CE2FB9FB7E2ACFFF003656EF9D06B1AA7EF69A4EB6B0F3C56EA49
      96168D632A9CCD0EE9E81DE7172A4D7E819DB4D16DB343ABB7496EAC58FAE02C
      A0AB9B9E2752877457F4E6C181559FCF32338497FFC7FC42DCEBDFFF95BB07C4
      D250E7814B9118E89890F008577F9A848B95C38825F8CD246E240D36CA00A435
      6A5DD387AFEF3A7EF97B16777182B2B49C81793E5F2E0CD82F6B7E24BA8DCFC0
      3AB409377FB60CC9E9411424152BD4B4957A903EF0D45B98FBD6D6BB77E01C8E
      71BC7B073DA478F76E7DCD567244DE6E42E06C0B8CB4F5AF7C664B57A928B7D0
      C72F93C898710B8D0DE0D550E122B305A40D1B3F8D5DDA0190B38C9A3D52F883
      1189CF4FF7F64CF81EFBE82221AE538EA6FE99DA15C1361079F0562CA84D13B8
      15D37FFEEF06A700BFB862A4A6F90ACD5C7ED06A9EA52FB6F35996BFD89ECD96
      A949629993D3B6B8D47AD130129371BF3ADE3D7F811F3DE985ECB077D939EEB0
      DFA4FACBF448B9662D23A286D2C4D0AC002308D16CBA6C5E5D984C74DF462576
      8F5FFD5F0F0670346D9A4434233DBD033D37D284565A428C572B299EFCD177FB
      A33B5BFDA7B4911587F4F80B97F84A8FBFE1E425BB4C66D09242814F30B27905
      D4810B6B62F2B819FC748AE27B6A4657D1E5D546EF0E52AC597C5666DCF53165
      93C69040A07F905EF682892B70B7E6BC1F137E15F86AC3DA729A690C7B2F2BDD
      69F26C217AAE4A2FA6241AF2598983BC5151896D4FEFACAC1323DDB459BDA02E
      B3C595BE29AAB58C6541A2A96ADC7858B55D5AEF3DB86FE3B9746BCB676DCA97
      99AB87F6CA7CF3E0B683596982507968B7DCF387F67299A1A659AA3F73ACBFC2
      C3F2E7871E6D92E2BC2D9A75D2D6D7A86B92777699C40B03CDC34DCACAC64064
      6B5F257386A5CF1869DD1C405C07236083144F983739751B5F86A66E4E6E85AA
      5250BB548807CA031600225D5C2D289C0365BC594B716B2142DB3DF4F8BB8F72
      22467E4AA5BB12AFD5DC8850D7EEDBF16981892274228721DCA835D01FA82856
      DF3B72BB060CDBA4DEAB646A43574D0477903171CB05D3B38EBCB51710ED2632
      8B3D12A59E3365C1A08DB7A8F036285591BB18B11ED72C4AA56E4ADFEC108656
      429348A737DE11C5B9685CDC35689ACC834C519F85BD22E4465F929129ED9384
      6C1B35A36AD6B2C122B307851C2946FD8C96D07462352D2C68E77B697A99BAFC
      66F1EB35AF4F9B293D9710A4E6E26101B36883C26699F74CDA38DD7D19052B9F
      356A3AF7C4842BE5D4C54BF2C308B425236DD8F8EC0613EF0F9B6DEF872C8761
      31A752FD5779765D507C657BBAF8E675BF59A7CDEDC69C7C30B012A83949965D
      CD547E6518BDC94078C97DCEBEE96E6D0DAC8B5AB94BDB1E4DCE7E779179810A
      AF1A35D14A8A2035637600683F9C1EEC12964A661DB86976DDF69E65E9B30A87
      6CD44C6E67B86F047AA1AC17AD4D286ECEFC617BAA6106909980CD4850E4CB24
      EC1248B3149C1EF2497AB51453824394447C1CA9B9F406361CF4265BE60EE920
      890D6C6213E7797ABB76C5CC61E387F36F4FDBEC296C33AA695BFCA17335BFC9
      9705D368DB7BA3417F7BD4366857DA259B460E581297027DA4DE1F722D86B741
      5D4EAF58A6FC9CA5D7D1A8597BBFBE66564572CB79BA1B76BE663B3769F0147D
      90A61407DF1FBCF1362EA659A0A6FC153E38DAF2CE2F3503A53FA36E4A9EC69A
      0810D2CE7714AA58103EA7499932F51AA675DE8D355A251986E130705BA552A3
      192B45EBE4DB75FADBE99B5D4C27B05ED9CC3BDD7B0DD261F071D1F21A08884B
      E1310A2F555BD29D1CECF62A33C1CA9F6CEF7C8723CF0E11CA456AD8142842F6
      EAE47CD7754CCC5C2A5E904537DC0AAC701D0671E59197368E967816A71A9772
      407267EFE080CF034B3F69314FADBC498B66FF7FDC48C4C033FF8501AA365157
      1E7E55A01FBF3E3BAF705A6F8315E8676709C7C28D26F3CC087B16FB71BCF914
      DFF8547CE3A9426B25BE31F9A2F10D5DCC0DA6AF691442D95CD46E503AD9E962
      D6A8ED323EFDFEF025359D28168ADA24433D8DA706BF0F4ACC45AE8B82F39A43
      71EB93AD3BCD485FB7EDF89A65F4DA498D5E9ACE8252D9E5241B440235DA5810
      C22C29B985B77F7E48D5079169E95CABAD4D35B736351DED1B3551C9F9A7E40F
      E6A563CAEACE5958177F5F52A43EC8B1A17A717BC2260E759148637A765CD07D
      16F88691EC0A68B15B7ACBFBF17F9D248BB34536FFA951B3679B773798BAE6DE
      35104E09AE49CFCE82310AC36C398DCA06CC37ACFAB08E99993E008253D8AC13
      CA6AA44354349528DC23E6BA348C0D3C284D2012C0FD66995B54AD285C91A8D2
      B2446A9EABC20501DC49377576E18BAB9715B5C2E6D50DC4DC984B6BD7F20676
      0DDBEEC3ECB06BD4B4EF7157B5BDB7FB1CABCEB3E98AEF6ABB28E8B8CE540AB2
      CDDBF6EFC0FAA998E69BE6A83266A3F0DABFEDFC7FA7DE864E6D18FF178A5038
      6FFE7F6CD60D0C32959A3B9793C3FDB32696573B2FCD8C3D0C5950649C1E4845
      27D38A9C7BE91D1EEFBE6AE3E7D96EDB7BFDE6CD36FF3CA39FE7674D9C92ED0A
      7FB0035BAD6A2C509EB48E2A92EAEDD9772746AB6AE46970BCD9A460732001FB
      F49E5A87278A02233C290F128B5800F1BB464E44948C0ACA886DA1C2CE81E69E
      8E67BB622A3C330D732E3527975644E5B3E7BDAE3FF2C7FDA13FDEEAD07FCF48
      B24A0370D7939A0C72936B2B0F220F1694E5BFED1CFC509EB586C55357FCB82D
      B2C6DFBD13087F2FA0BAD0A26553A756DDB75F85E7B6DA21C8FA5A250F8C0E53
      F3FABE1A97A1E56F15ADAECAE6406E8C46D1B8C251337CE105276F4E4F2B621C
      3FF2E5DC61C0ABC5E5454EA83E8209AEDE37CD6AAACDE50EBE76F866EF355311
      292772F0FF7670BC533DEB4D9D4DEBADF415B611B4BF9DEDEDB6C0B6F2C699AE
      6579868C5C8261F58D383AD9F97FED3B82334F7D8D3EE9157C82E1A87B05FB77
      EFDD1F97F56CF09A60ABBE38C2661C6A6E1442F6AB89412E5350F896F7B6B0CD
      C0A18048333CDADD4CBA4898BC438A0528CA84CE93CA7168C6569F698225E299
      E5FAEFCB24277C0FC971E67ADB88CB46C092A2668D5B36486189298A7B5F352D
      ED0161D4C637AED8EA199923892470731087F6B1515363A7C176857E28BD09FC
      424B828CA465356BC8ADFFBB9CCD19E635739A8508DF67854D939F67F3E59CCB
      C49A35F6BD941C702F8C238EAB1CA00549B6BFC9566CD6800FB20B215F0ABABD
      D7F9759E604C29451DFB87AF9A35D61F3FEC82327EF25EAFAF41C79982A784DA
      F610CAC9D144D15F32DC2EF36C797109EE4A1F9CD82806CEC0A522139C93668B
      859ACDB9CBE78C6DC340534671BC9C723B50F29D7B38195257C90A4AC3D6C2D4
      EFE1D2ABC2CA8B0A2489D4CA10A61DF9174A88F82DEFC4187CF83F6C78CADCE4
      D0007BBF9B37C7D5D0F247B2764C032E426A3A3F945222F2A6DE18BC9BCD3F52
      75FC0DCAE26F5437CEACCFF965A3F6F2CB6B815FB695F751B50110A91BCD3A6A
      47F724D76E24AE6355AE2F96D4CD4D7FA0BE570C9DB2D9BC4954A32B1BE7072A
      80D613916DD4F6CE772861FB00037D957D68D8D0CF0C6998C401151264074419
      7B206C659A4480B85AE49BD7CCB94999132301EC108AABC6DF4600508A77C326
      796A6216C54DBA501FBC4B1CC4291D4632867297826E54D3C7C1AD09CFBB78E2
      D4754EFD651B117FAF605973A78CE4172A1D5B98C22B727532F65FB30ED5F192
      4BA1C5AFDFFCE1EE8BAF0F9BD1C68F21FD98D08FB1B7413FAE55E1B5282F8313
      D0694EAD47A2B71D2645F8C408EA8CE0CB76AE5B5FDBA102B759162571428551
      8C76329BAB451224D304B6154BE720C38F5D8D1924DEDFF6D8DEFADB5EDF42F2
      70DFD3225BE65445465930CD3A8EE2F9A21EC547345067351699B74C0B31A705
      159D551303B250F6C135BECB86CDEAD5CD426FD3A8BDA94E2FB03DD06273B27A
      39A83BF4BD2059144F91844F45127A93A748429D217DD97669BC4138826583F1
      E006EC2999A914D3252C02C64D79174F23D2A1FFFBDD9FE9574A7AF01E1C5CF0
      DBFF3AD93B3DD83FFACE6B5D2E16F3E2E58B176E245B917E9FA8944AFAB7C030
      5FE0DF17E7BA18D0A09EEF6302C5737F389AF446E3C9B0E5FD83C63D8DF262BA
      F8B5EBB59CBE0BE3DEA7F9F86F1AE13F4077053429213CFA8DF65C7F0081B22F
      FA66D419BF8BB36C617E0D617A7EA05F741AA5973AD77C37DD42A171A2567E9A
      D05A387D57C48B34F8F9C1655783CEAD4DDBA024F82425701B65EB3C221D6644
      C81BA726CB75FBF470BBED1D7D7FB64FA96BBBBD3695951D37CC903513DA7B8F
      2D370DF5A4BADFBBA08C4D721BEFEF4A3C9BA242D3E417BA42925B9B3891D7F7
      A543701DA0755B09D4AC03476FD4444CDA7FC7F75E6236946C9C511D38951842
      6DA1C20C465B2866DE06FD727199158B4D8E1AB85840D32C258B96351E634EBB
      8201C96E12522B5D8B436CD5743983AE992C083D04FA19864D00F4D216B17039
      E1DE46B4E438B2F22E95D42AE61A8284F10D82E5C526956EE2FA843023C90213
      F34BB08715656A346B79CC8E7727581D5B7A7DC9210D154544AC58B1A2F0FE76
      707AE052E80DE23A21E248785D220334F3ACD0722D03E467EB6B29C6A373AEDE
      49938BD496A9DAC4ADFDF3C366AE4707EBC18ECE0A2C05170C305C4561FA1480
      5B2591299A28B6BCED6991B559BF68ADDEDB221386AAF4840D346BD2C795F09F
      C13926A7296D33971443D02C28959E69587227020D264C7A71B36662CE7AAFA4
      E61D358752E9F0D44CAA542A802B5CE0A3C122A46D9E2DED891232DE488BC1A6
      EE6AE3D1E7BB19508F899BA27F05819F13960991C6E370B03C05C6EE316ABE6C
      2FD16AE48362D22CB79DCEC11E16C2AC8E6891E6AA8036E5B508D9B8E55DE91B
      C8A986496D8A4155B0692C5A55F30659E3EA7FA833E429DAD2A8E3FF65BB5A92
      93753667453CC3699F4E5956DB4C24ED91F6FE01B3E2B034147B92E5B95C982C
      A86EF7BD6644F70C83BC31758681BE4CD286F105A39EF506A49E59A818536822
      B8DA5C56AD4D2BCA660EBECBBAA501733515B759EC9D42A5A2889320CE33C411
      9B14D0414E1D58AC43F763AB7FAA6EC4192BF9AEA498892ECE5F672974F2F5B5
      23C6BBE66797A0B37FDB3938B54A787DE14C495CB396CE5A71DD5EE745B74BA6
      5CB92444E9B62844D01F5DDEAF64CD56D76F9A6557CBB9172DD9DBC059C091A1
      222EF0A6226606835CA6B99E26CD133AD64019610D5E49CF0213F07F6B5B1C90
      8DB56B5227DDCC0B82A26BE44C4859170BC46B1928137163B5B07F53AB0534CE
      D47024D9A5F3BCFD7DB558A70694C015D938796C79481468CB3B1367166D9569
      DDA8A636F5990F249DDEB2E1B6A157CDAE32C89FA29954D9A193F93DBBF308FD
      C22C86302732A7E8AFBDB343AECEDAF25EA9F0EA82DD23257AF9349925C60AE3
      AE2FF8D741499845E04CE0664DDFD14267C48249DC7ECAFBFB52170BCB660D63
      C75073258818E6E0C6B9BAA0C23BA93902370FB46D7F033EFC715269604EAD5D
      8A2196628F9DA1B53A0C53C94018210253C007849CBDA97A3F6398B72DA89838
      026F29264ABE6D722155DC1164E3E838D6E1FA1A6C6F9C0E774CC8E1266E0A29
      6B6ED6C2945442EACBB151CE6865844E2C1D14D4D6F03FF9A36D53E74CF9B7D6
      CB58E66B6F79BB7224C8D1DCB6D491703505A13C24BFE8A85C1C839F23B5B954
      E3D6ACD5B16B439EB7EFB304133DBF996B03410A0D893CB0F3B98612BDE51DCA
      4C0B3919B533F0AF6D7A7D97D241E1093F19607503ECCB76894ED6D78C82DA07
      FDBEE518CF2DFFB10842CA07315CB06D0FA5959429B5C425701772B0B17ABA43
      C9A8B11809CEB00B6CA539C40341622E24DEE0A0B27928042EDDB0889F3DE3AC
      F2997648463F321933825963F0011404FF0535493298DF11B7F2B2B3A4D5E1CB
      B76CC822CA74C1EB0345972DDA4B5D7FB24D27329287FFC2E2892F37235318EB
      6852FE1E074379CA97BBCD49BE6C7B1F6B55908ED0221519E6AAD06B4B824F41
      F6018C22BCCC72B1FD836C41C8E3846A0936D1AC03AFDE6709614988E24E0061
      21C14D5098DC6A31606099C7B554910E9617E414F9437355BFD2A4B2F1535259
      FDD47E59D0CAF5B51F488E2D28F66F1BFE893849C8AB4AED42A5BD8386F142F5
      2638AE0CF26DDB72886E50766AE106A9984B42004847FAC392AD82B385563336
      738ACBCCC0644205901E97AAB8F2544038BD3C0C23EBC01496B346C2229D1860
      EC0DC98FB12E934D87404CEA9004B2661053D68E16CD87E6676BAA7661386569
      90E5A9B77BB0D3C4A9B608B1C0A83CDEFE6EEBAE2C21E3306AD4F0CF69D826EA
      EDEAC7EF0C80F3542CAA60A3E6B06DD2CCE9F88973BCD219071F1A0FFCFFF1C6
      9D4EB33ABC729040B31FD7F5070DB3299B126964DB37D8DC25B050CED16E643F
      9FF5B5561DA6DAC11298EEA761421A80A8F6A635C7C1F6D1AE740EE0E9E2977D
      47811BD2EEA8DEE76873CB3B4E2B8D2D0CD6847459FD20E58BD2A725F9A5C9CD
      8F5C97D53B912F4917E0CE3326E8FCA42B7D4A571A3DE94A355DC9FFB2503E46
      26BE3531BB2851D38C4326D48ED7342B6350BAEED6B8511B772059C8FA45A44D
      42B2F6968B78CCC9CBEB6B29856ACF739516D33233DBE48DB6A54EF78619D86C
      26203E604F94AB73B6C8A5E75E6ED376081FC7B86F1719D5601BC8C546AD8681
      2902BB1509FAC2B96AA9915E41BDE223E804B6BBEC139BFA149B1A3EB1A93A9B
      FAB2581395DEEE74922180591D8BBC8D459E2D034A9161DFE5AEBA4E2F9684C6
      A58B86195AAE1FD16B07734F88D1DB3B7B2625504A138364CE18C86C9D1897EA
      3EDBA765D9664ECDDE5663DA821A6EEC5DA826AEAAE18E474AD67D19FD1353B7
      898039DB26238451E1315AFAA5928CC8A0121C90AEC02D40235DD5CB9E3AAF7C
      92E30D9E385E9DE37D59CC06C32C607E504F01CE46A0DE43FB27BB67B65F8270
      8C46ED5AADE5DAEE1EB548327914DB073BDF4A97E3D6AE96626B3EB7E43107FB
      6E358B5957E54D05E1BF60F8BB5C733F110365836B7A7494A4CC0F3F8F056D97
      18BBE5D1E4EEC8B84C90426350A53D29196CE29C2B1C974B1939AA6FBA57BA89
      D13E328F65BA54EFED62C8EC1A3A2D92AE048257D99543C1DD3E611367C37620
      C0749925FA9B1CFDE4CEC036E585F025D3D245C82D30D355FBBF21336778396B
      DACD928223E16523BF660D56809FEFADDB3C3BD93B68223CFF0917703C0F188A
      A1F4111537D0ADA413644B9A124B55484BAA1837387A5869FD5D5556A8810FB5
      525864CD628A2D539B267368D6D0B6C1AF6E7ED1DE417621C323EF629EC3D89D
      DE94DD391F60CCBDCF1B338F50E16A37669E45DCF3B24FAA375DDFFFE7F51BBE
      F973159C64FA7E7AB761C78FF9438AA5AE6EF264E61AD14EB38708583CD0261D
      07D3E43D398F4E972925A2CB113EC9338AF551D3B88BCF47A8B867A130D97F1A
      A1E2E58B17D7D7D75B290524611B168CFB909931BFA04F5EF8DDF1B0FF070052
      FC9AE1FCE31FB0859FF0279EACA3DFB41987129431CDC739D12CF3B298809EB9
      6704C90056F148676B1D932FB745AABC88DF5754BA43D1AA17B9567878406558
      4E19C480DADE99FE3BE32EB43DE36A663F72DBD38B70AB5972F9F5724AC8D173
      5236AEA8445CFC44B9679D646C7E9D3FB9403EE502F19F5C20F543FEA5D1EA56
      A253948CEBC100A0F65720F62937592423C124EE6C2D3E709A8F34486598F00C
      F6F9D91963F4B0F96E15EE466D741DB3E63D959F70866CA5951208F53FDF9E9D
      3771D8DCE25B7A89F181275C87E59C5D048126B00A97305101F36CE244B6D9B7
      33CB38FD7BAA2F5478E39D1E6D1F1A77397940FE6268CB14EA9B6FA4B30FB97E
      F0F3907EFEB0B77DD2669F17C4CAFE5923F3A02C76F1DDA3775E129E61DD4FB2
      4C0B156BF16ACD6FCAA2306BBF32240FB1573997CD9296D4AAE927EF2873DD67
      B3D8DBDDDF3E30CDE91B3756691220BCE1768B356E4CA32EA26C3A2530203CC0
      0B735550562F757331A98CB6DDB3D397760F769A3553AAD3F35A65E17CCB3477
      2190522A23368A9CE950C36EC7389B9224486293DC493A20A979CDE2ED2E7F88
      CABE21496F4AD185EDFB30F48DABA859DBF12DD6D6DB393F3D60859265AC2898
      A67690506489F4E252F57C522F3FA55EF69FD4CBBA7AF965B1478D183CACB6DE
      B4D80544DBE299AAFA11B191DCA8B378F9E4495CD9C80678120F881D883E53B4
      BD7DE2A9B0E2E71A92B139BB85C1BDAC8FADED7D4B0D7C4F54BEC0EFAF55F850
      39B00F34E25315EA97DEB72AC931BCBD1BDDC045DD110C6F9D37684CA75A120F
      1B34244A0DF4A8594C83C6F49D35A4B2F4A5B79DCFB21CE6875673F2B46DCF66
      599B8EF393D86C90D8345E19324B5EB029F5037B60744E290DA41EBEDD3D153D
      5C6AA4A9F78FEDD90BF15914EA42744741C801BF56EF0F056AA251FBBCE27BBA
      657A155B4F4A40F39480F5B55727BBE7DC74C52654DE80FE6C8A78248E353194
      B92E8F90D1315BF2B93151263157B02CBCA9A24C52287BDE46996C254F63F387
      1EF4109E8D87532C60742C12EE19CF2062D531D3E7986CA43FFCFE7EB9079A10
      B93B3D653057EAB068E5BC784A0D1B73B160AAB9BD09FC45D386ECFC138E0D33
      8A457AC56EBCDDE43D46BDC8F266F9F01EBB0CB60103A8E6AFFFE6CD2FB354CF
      A4DD3C88CE443FC4F167B2A72AD9888D94B22E27BEA8677DF1B82990C3276B43
      A63603FB9D328B0F0D4E34371EC7A57F91EB4AF036C33E184E707D6DB1142D04
      CC9072DE63EA43DEB48E8F36A8221D6C0BEAE7F15CA78277CFD0540447895F08
      40F16CEF3FC53BBA41E50104C5653A625B37AF80872A4A610C753327EAF88FE4
      FC715E5CE3F005259372E7DB6D9B82C8D467332A054BE3524DA93593F64CE51C
      854D76C9B23F0495DD90C7BD8973DAB5BD1438046242226D395C4ADA6318C0A4
      DAB9E4245213216AD6B48EB24A8B721E738B0EC71589E26B0218A2BF04D41113
      69356BF036FEC1B9D4188BD4BB50D961A5713C3B941BD9E55E125D5F2753EE7F
      8AD3BC63E24E9292B9E51D65DC951BBB206E71D9A5586E28A094E25AB36BB44D
      DC95D73BFE8EB2B017327973AD4CBF0D825D5FA30810F33FC6F3307052DC1BE5
      43B2B0B85317B99AB505E5E3D6EB8C954A6FD379E3E076CD72562AF4ADE1DCC8
      F37726E869C6D06725B2E62F78C179DEB4FBFF6F9A5D70C6C6729E312476C33A
      71884E324B089D9BAAF5982C996C21699F2DA43FB109484A2CD256EAE565B0CF
      50D9FA5A21E6A67429717D6B0443869E4E04CB0FE7F246CE09C715FC0E7E22BD
      A8EDCD970B8E76A6D568689E650B1B0D1515D07E8955D5E172C14F6345010FDF
      B059AD5BF8B2ED613BBE97DFF4227C027BFA7414AFF714C5AB9B425FB8D986E4
      8F9F498A7FB3380835A528116225F0AFF3668D516A3AA065040C6FC7D042546A
      48BBB6201418C25FCCF286C1F79FC2DE9D05E077F3AC307D07C028C955A1299F
      87F8DF4C319E71F3D4A4B2FE5BF22A0C1637EB7C679749BCF8663798EE4C93F0
      AA59E3FE717B3AFDC9FB21BFD1D45DF7523ACE51E4DCA0A66DFC63F564F7F864
      AF8EC8FFBC21ADAFFD794B17F32D7ECDAD47FF36A6B149546E34453199B9E940
      0389E5C7ED83839FBCD70767E75C32EAD19824D9A9EE0C6DE2A8F776F7773D45
      E0E0D40CC98266395773C3862CEE886AAE3F1F4D0A481A4A9956BE2B616794A1
      1D024EB7BC745102CF347296CFA72F6D7883FA7FCF8879922EE61598477829F0
      6C19C3800A78576DAE0D6CFA5DA95D26E323E1A67966DBC409C6FE984A9EF80B
      4A26E75C72B6414C7EA12694C3D8B1349A5AC326CA5E1B89901F66D177D04AF7
      0F8F77AD5BCAA2359299F85EE50C0952F6BF68E2544E0E767BF512FB5BED6F98
      59433B01B5366F061203970E0112E0A9E26473DBA798FA6F34AEDBE88FD60EB4
      DEF7EC9A32682E93B92526A9B4C0E253867F63077F9666D737DEB5560CD7554D
      8D4E3E544359DBF9E2729665F9938DFB491BB73B79B271EB36EE97ED28979439
      E4AB492844D9625772B081630D847D6542FC4FA4FE29527F027A5B21F52FDBBB
      E335F5535A2E8EBE6722A6928E99CAAF4C132A8B7F96C45EB49CC39AE0E0AFD4
      EDE014BCA7863A847CCC19DDEB6B8DDA586939C6B53962F753F73BAEA6587804
      1E225D94168D449E6E51C117F11F29282E5A0E27F4325B4EA38AC6265D817883
      F4422553E9EA2E00E8644D71ECFE89297D8A293D61B1AD30A52FDB06647D2D62
      90492F24AF1CD56D298B546E223136AF95C95D1A5F5E66D21C94ABA87E5ECEE6
      068D402D9A0863748B3D85B629EA5CE7579639516A03CD622FA5D8D64996A4CD
      82301333EC8CCD3086656143583EFDC67C7E42F3D993F9705733CA0C20142FE5
      315A66445DBDD89D43AD216C329F036AA207D28EBBF2444ECA6998B0A1BC8D1A
      B9522A540EFDF0A65A56A999755F7BD95C932249EE0F767879EA02836ED48484
      3C93F43923EFD97152DF42DB512F244BDBC3465CB24B6BCEDD57658EE4DD62ED
      20216E4B53A1C4B00B8A39AB90EABAAEA55D8896EF5282E69B52A34F41C06F18
      C4E221A3B64A5A3A4F4D3E383510AE246025F9D4F8820824F70749BF7F6981AF
      F5072C5A4250D06ADAB6F603AF42883B9FC0523F26A07B5B83ADA74ACE15F9FC
      651BFE90FFAAA00E753A5FDC851D18E2738A06DEF6843E91F87D24DE7D22F11A
      890FBE6C9F066A2FFE3A595FFBF0D28BA799F4679E93FEC5C24EE549213D0E48
      9E4F296BAE152F7FF9E5A645FD18A98FA2A28641058572E81C50C2EACA6330D9
      40E7F200F348324E291949FF7DA9A68C4B0321992D2F2EA5F5AF4D54342A3077
      8BB6C1771586CB9CF053F0B75146367C2FB859E8CDD5174B3FC92DCC90539B38
      1B8FE0CCA9062794EC6DCE69E2DB288F8A5568637952F34D333E19B4780AF893
      A733FEA933DEF98F2FB444771789FDDA25EA0FEB87C92D10568417E893665DEB
      540BDD1B734EC2845B5B5BAD3F7061BE5CC3D1F535AA9C269D9751F14C6857CA
      DB12EE019E5C48C877916BCDB6EDF37FF7EE5B33B364777E2DC75ADC476C57D9
      2FC11F2CD050A0C989C4FDF68C9D2CB50DD280963AD0DD70382D4FA24AF703AE
      E49BD1E21133084D2578E4FAC9D23336091B90FF62C6C545159EFC25FD5DD8AB
      C88CC8CE82B926A562163A5E4E6D8A315B1133EC6542DDB3A06A2F29B4BCB069
      E5108D29379211E5DC36FD5B2E96B96E3394B49A6224D7A601A19A5EAB9B824C
      98F73425651C97AE67E186DEBAD8F22409FFF571FF44C094C0296F4C375EFA22
      C585B42A53359FD3DFEB6B76694D48BBAC6834E36D7BB65A64A6AEC84CC84D4E
      76EAFAAFC154E4179085405B6493377824E6F16432D32BE819629549DB39CCA1
      52BFB19AB813DC47B4410D73F4D387F787EDD3A3FDA3372F1F3833687DADF47C
      D0EA55E854719272C18B204B2954CDAB6892D92FA4B131CB22C1B7270B4D32CC
      B1A85742C4D246511EB1B85C5FC3DA2F0B26A4A4B09F93BF9B0D3BD7FE83898F
      EE8F340CF648ADEE68AA05EAF1D2B45B9EF141A334073E0ED45DEFB8CFBCDF90
      3E41DA0A2DC8B974FDF78AFA79E1E12B4992B7002910F0387F24D95D66E03668
      BB5DEFBA4934C22E795A90646A51E2199273AA72E20551C449FEEA1AB2BBC5B8
      E49525C3F726119A7A332DE7F49BFFE695505ABE1420F6654A616AE50DFD0073
      B3AFC686FDC0F95C4FBAFE27F480FE56C7DBFBDBC9DEE9FEE1DED1F9F6C193E2
      5F57FCBF6CE7233E26E04A46A8923E4DDE29CA6E90EA8A5B31E1B6D1F44DE386
      19B18C5966BA84D624AEE9AE4EC8461138BD88411CD996FC1972ED9161432D3E
      968ACED70DA7B8E0EA90781054EE65686B93E61955D227547A0851A74D7AEE7B
      ED3AE0B67618F89EBCA87B5C57D672ED7C9A95619219E1CDAEC5B4C255B2E5FA
      DAA28A09E124ED2C2B16162DCA34F830E6D74CABB4A22730732BB4B6DD5C0B42
      FB0777ABC638DDC5511251B5097F71C3B520859EC6DE06E537D3CEA55E59D051
      CCDADECE595916CB996FC654B20EE0C032529A03B4897DCE2775188EF485D404
      0A2BB7BB630AD873A96671A284F9F9F33413CC4F4C804EC34C8BDCE227B3CA53
      7D3C9D255AAF429BD94AB16E219A1EE42B16E74AEBB9AC3F3DB7D8ACBE9D4A56
      FCCACB2F13A2FDEAEBF9EDE7B5D19B9E2DE2E67ECE979FBC39DD15E554AB7C4A
      78C9B67956A308918A08DC342CE46612B16A91CC1E0C63E8E106FC6A7941A957
      EC9C1733DE448BC3CB2C096D2A66A0A574D6822388E6D1A8899C8354DEA6526D
      C7DCCF14CB96DB610EB2A85327142B801AB4F3ED2981E474F8BFAEFF1391E59E
      54749D28E60DA51274867BCD77675CBC80553B9E33D7E44206B9C1E84578D196
      F726113F8CD1E1E6F2521B88A7BA6F4E62C56990152E9B5E56FD262E6C222996
      A22EF2BED8D2B1EB2C9FE226F6FA2471E9F199D31911BC944AEB665A1DC99F95
      6A6250244F87E36A8EF1E0511CA488AC34B02A73B358FFFADA67EE3CB3367298
      B9E5E4F47C12CF92F6CE32C22E525B38DF34B99202BD9600F07ACFF6ABD256A2
      39CF6046936C29A5A317654D4BBA3E7761501E9F1C725A0ECAE1B92EBC6AD09C
      9D8930A02870DC86FC60D9228B08358BD858C831370360C0B42A1743B3311FD2
      BAB2ED24F4164E29435D4C5C7E35684D28B552327CA922213CAE252EEB249E8C
      81BB8D81DE536C6B55FFFFD29D2EDE904FE1CC56AB6FBC393C3BDF94A343678D
      0BD71D332FB2E97B6E7346F50F99942B531BE0367BD044C6368B896C9B20BD91
      08A7FA42D43587B2C1C9AF323FB671C44451DE6B8A07C8CD4F87FA5387FA0FF5
      F47F4987F679D5FD64BCC15C5232533F9B9E8556A2AA69B2B8316ED98A791DB0
      FA4A11299363911477F40B7F22B98F915C77EBA94A7E458A7CD9562A0222629D
      DA719293094EEEDF328E0A01011D8C955C56411BB57FE5F895D7235BA33E76CE
      FD525376C050EB354570DD8D9A0059F1AE0496F2D62FB2FCC66B7D9B4450FEC9
      FE3DCC22EF0D65B2B76C1B07A8CB813668352CCD1B3521467DB52D34307EAB69
      78E0B247A4B108A19103EA422F2A863E7D964A980464A6B8DEB26CECD3A8393A
      6CB2391D4D691572A260BBBFC99386A5E86F630D3954D75AA6847595B6AC7391
      4C25761F48A2854977A55092511C19C9B45193595F3B5B352B37B8A91BB79C48
      38E265344458CCC555326F932BD15482B4BDADAD4D93D11B56E3DBEC76699D39
      63B2D5767F1D65A9160F776B9F9CBD0BCF8DA0D5A8A551DCC69826B69410B4A4
      7CDA22189B9D9CC57112921BDE5432376A0EEB6BE2227C59114B21B3F2EB3CA3
      88A285E882E25306FA393BD501D68AA19FE47434C917651DCDCA12C606A70CC8
      BA6CF2CE1A47BA510A8538F8698D5A1C680D3AA7B2EDC5B55657656C41539036
      2966463A487CBE02AB104EE923E74C6FD49CD6D7585AC46EB7935B318796EBC8
      28DE32EED8968B7BBBE56D80EC0BEFEF4BF28A2A2F903C3355362A07230BB580
      319266B0B9E56D33FC297B995C103AC221378DA9302AF2BF999745DEAB9B56AD
      3D9C7524557A08DBBCF9B2503D2FEF27586817D96F64B5FD61C924C88DABE6F3
      2985990C12B4C4D06D9E6C98E4E172466A54D8349F63BD14C77451C2A1CFAEAD
      0781156CAFA08C1A97B5C4DE122A7320287ACE0A70DEF0EBA2CCFCE7E445EB54
      1020244EF6116C8C999E655BDE59E6D26748926A55246C19AAA86CDF9D7B4196
      5D35EB0C5264E08692352FBCFD67EFB98EE5226317A90A88CFFEE529EBFFE316
      ED5342F48A45FB6521B0EB5E51626952C61255B21A70401BB567AF6D2C87EBCE
      482739A170352747EC6469644AFA199D163224E2C9482953C3CC5967AD16DE06
      EBA0C244987B4EA91568B3F0E2C9A0B0FEF34AD2C66DCB4154944DDE02C99C7B
      2195CF9C3FA7BCAD852E7C12290E3D9673545D40B720AA9C9389C8DD67B90363
      6102B5658BDA0DA3A55B5C290A1ACE55617CF68BCB3A2853B396F2C42A6D39E7
      0C325E77B5E686564DFC34E5CA1804E9D25F73014DEC49DC9877FC17D489EF48
      9720B9C37F6D83FA76334EB479044E7BCC98141252A138304C89C41948C78861
      F29CED66D047A1876F81E968B5F893F72D9439EA3D79637266EBF955F7807D93
      3CB0DAACC9A99554F00F653691BA95B1FCDB500C9FEFD3D6D254F667BCA50F9F
      AF3CB719576D573FC35540061EF092955DEDB57892A612D42138109359A69792
      7F1E63A92FC523796C304BE97B2BB63E2B93567531CA62DA1B4CF093B4E787A3
      C35B74D7EF0E3AA3FAC299E51AF52693497F6C3B3461D1FFFC8E725C34778E1D
      74FCA0D3EFF85DBFD3E90CF1FFB124EBF4708AF424D29D3888E3D824F0849D1E
      FFDB97BF0781DF1FC6433DF28703FA398807FE6832EA0C07A3FE20EAE9D17818
      0D43154EBA61E0EBB0DFEF743BB868E48FE370DCD7835EE4ABF5B54918F4F0F2
      716FA027E35E381AEB70A47AA330EC84E3C9A4E77787E1241A073D351A0C3098
      911F62C77DBFA7C6BD4E77380C7B6134E9F7E3D144F703DD1FF582A81B7746C1
      20EC4FC693508D7CA5E2B8E7F77A788D0EBA813F1A446A10C5FD911F47133A68
      83E17832EE765577DC0F875D35E8C49371EC072AD041D81BF747E3D1B8E3E361
      1335E8A9C128D043CC11E3087AFD68AC279D51AF1B4F3ACA8F7AB1EA8F3BBD30
      E80F46C3DE70DC89232CA70E230CBD1B85DDB10EF0946E7FACFBE1C4EF47233D
      E8F483E1FA5AD0E94683713FD25A0FE20996C1D7BD4927C018FA717FE86B15FA
      CAEF77C6E37ED00F3B132C9C0ED5389EF8589BEE1073C39FC1A4378A073DADFC
      1EDEA2BA6134988458A978D29D041D3D1EE8E100DBD2ED0FD438D2BD4EDCEB04
      E3B0DB0BFB41677D8D167B1087F1104A6B172FD0C320EE07133D9E60F841341C
      4C86611046986FD01BEB51D81F0E74186218DD38EEFAC34E3CE8C77ADCED47FD
      30C43082512CB41213F5805E3E4667D80DAC811AE1B1F26107BA7B977F090CA5
      C5A31E682C1CF57B31E8CAFC3E26428A878A280BE31FE9783C08222C63771461
      BD31B32EA80A3B11ABC1A4E3F7697B461136A4DB1B8FE2E1B8D7EB06112842E3
      A71FAFAF85D8D68E0A02AC33965BC7F1484DFA51AC951E07F1447727BEA6D519
      4E94529D61D8D73D1F841706C3B1EE8E86FD08C419838227E381F2D5A837E860
      38209ECE7888F7E21D01117038E8445DD5C73245FD6E3750037F1C0CFB9DC9A0
      DBC32EC4E37134F1E9AA9ED27E6FE8475DEC7027EA61408328E8FBC35ECF1FC5
      6A34E98EBA83381A81F2C634348D35C3C9E8C783EE10076BD41F612A7A1CAB71
      388963500DD6280C27DA8FC32EEE8F7BA11EF8D894218ECCC4F7C321BE1A6204
      AA8B7315EBFEA01F44A0E9F170A054E47775D4090601282E1AC691ECCDE7ECEC
      30184D26C3EE706C38C658394EC2FF8173E00DE012835E2CBFAFAF55FFA2DFFD
      080FD0F8FF087CA567B90A2613FA51077BDF23AE823D1D45AA3B1A4D3AE006D8
      8C0064EA433004388D4A07418C91F9FD49D8557E17FC052B3A8941D73881BA3F
      EEF747A18E40C73832C1FA1AE6835FB0916167D489C66A3800CBD1E33111F508
      FC468DB06FE348F9E36E888D0A87A1C633BB38607A321A77B1E2813FC6418B62
      7F02B2EC0F3036B00AD02028230A0651D4EB44C360005635E87535F6228A061A
      E7D707A180D56104A3C1488FB19B60DEA0327C898960433BBDFEF8D7ACBFAFBB
      B1DF89464CD9F455D0E51DE80EEF5B7FF97D7DADFCABDFB56BAE437094784CA7
      65D8F5034D84D48F3BE32802730B82A1F6F1B62008C3EE64A871FD24C04CFDD0
      F7B5AFC67A883330C49E8D866065389D237056CCC9A7A3D20BBBF837EAE3F23E
      386214830E704E70CAF0729CE118CB15E0300C27837E88C31875706F7F309980
      A187A3288208E881D7F570FABA0370571DE31913F0B0085C250E237F3C19A938
      0A3BB19A8C06631F7B8E4503754F26A39EEE4F7084070AC7B11B4CFA43EC2C26
      18D3691C291C613584C0E986A0A6BEEF0F26637F42D4D403B7C570A2A813F7E3
      603C0E47C3D11872A23F0CC7D8EF0971E88E1A76A351A7AFA3A0073E3DC11B3A
      A1EA639D7A132C5F671CEB09D80D0603A2EC69DD1F4E46DD2EAE186259BBA083
      A837EC45F84CA970D0ED408E8257806BF9E31EF1AD09D846978E57D0EB8044C1
      B9B029906E1D458FC149F743B0B270388A34A4DB30E862352140740F22C4F721
      0EC7239C0748710CBC3F1C4693F1106277AC3B60637D1D8C7A908D63D5ED75F4
      28EEFB3A1A0C0720251DEA1EC9A95E2F82681F434246F1B0A7C0782783511883
      5F41D4436CC6781DE885D8660C763B014FD438889368006501620E2B883B4390
      3AB6291A2AB00A15D39C3A7DBFAB40106AD0EFC1340A5418E3D84C46A37E5F41
      0301BDC45D059206214DA041E08CF57B41AC7BB422E100322B1E0F49644F7C6C
      79804F211674188F46D843082E3F006356F108AA4B07070BEA0266839D20F209
      07505D70CA212321424658D90934147C0056D81B8F271D4D0264AC072315C5E3
      10E7570F279DCE84F8BB8FFD0FFBB81D7C1E4485A51C0FC63D48A731C829F021
      8C86203090F610FB0506128E340E3F0EA13FC15240E0F7A0E4C443A222308241
      271CF4B58204E88ED7D7BA7D8C24C6766261031CAFB11A909E419B32D193FE04
      A2608CC7C7831128AA871507FB86EC03B71EF7BA233007226B9CB56E8C55C222
      0D89E1838A31860EED47AF338C073AC6CA8187610974A02179C6D80D7F04D117
      AEAFF54312CF10BE10FE910F6206FF1A434F5393A18A071028187BAC71D8949A
      C42093186710AC35C6CD10413E34C338D4382923104B14D02D1335EE82D1F606
      2427F1D038D2E138EEE225FC571F7A107E407041580C701670782077A18AE220
      60677A832804114438205D5202B1529DF1C8C7BA830363CC113833E402E81CEA
      1D642716C187AC0D43A8031D08F5012E1B0634D14ED7EF92D60A72866805CFEC
      402B8248268534C2B0A077C56056A08371087D28EC42D1C4B3C154C040C72118
      FD701C8CA17104D86E2859180BD4BB31081BC387C0ED0E2025A2C8C7DA41EDF5
      A112C43D1C1E7031F0A80E54E30998CA208C1594C021B80F6970630DF571ACF0
      A0B007C1D4852E16FAE007E3A003BD3418833B8F20607A1D052D1706102E8364
      C13543DC83ED84A8C7E842CC5D0D14B4836802D683CDEF4107EF626821F86917
      7C6F0C4939E84EFA2497D418C265E4F7FC8898E81867100A6C1FF41182576312
      517F029E486A2E38446FACF02E30D4113DD80F7B505A2020F1290EA2EA4CB015
      D875D03CA86B84559AF431361FFA5B7F0C52EB2962A2203AF037285A507F07D1
      D8EF2B1C784891A8A37125E60CA6D503C782060A71075519821AFA4137268301
      8A93A6F3CCE44E47079A0CFE0F7AC7982120C0F22268039D11B4D3C88F30CE68
      DCC3C9F427B1D2A498F8E04E8301AC8300A2125A2C28A30F1D512BE26643303B
      687360D450DFA0864F3A5D8DE7C1D4C559C00A7515E472804D82EE08EE885FC1
      83C1E1623060F0B201C8C11FE054FA74D4201B7066220D8A0F8771D857D8C600
      74AE7B7DB0AC18F206D4816163F038A551301C047D9C0DB03CAD71607AC30847
      2B26CB838826C608B4EEE02FE8CD60CEC27DC1BBC1A0F50093803884CC8A2731
      F4220C6814E2D95D309B5E80E7E1ECF86A38C29E7520F32650D74920402904EB
      EA04BAA346301EFAC32EB4F708960FE806CC0BA70DCF8D7BDD3E0E4067340447
      C2DE05E0D6A0E309C40C7617C7B64F57E252B0220C144F1CC63081717414DE06
      5308FB17293D19828343F64E60D1817DC0F08A61FC0424B5C130A070E100423C
      826E0701194D23A826931E26072D142765D4F121BF2199A26002DD078BD3C701
      F23B21694F384CE0B1D0902146C09D60C9E0C4432E81C983143B501BB0F2787B
      008A8D06D0898854C172C1606065913549A6133499118CCB0934B92E78BE1A60
      DE98C784245210852134F35093D50655070ACF70D8192A98DF1D5203C0B807A4
      944227824C860C05035090ED38EF833E54F401CE270E24C81F5A11860C456308
      02F4FDCE10DAE9007207562894ED71848D83DD884F07104C60F310E510A7386B
      90E4784C7F8011C4B062A11CE34A587663052D0933C44A61F1307CA802581015
      606C7417D8E0103AD408AF034182D743126885EDEC4228903530C2A90AC1A6FD
      210EAB1EC6F13886BC81998BBF204F61D16075B17ABD495F41118FC86E045540
      370A992143D9C12AC34C04CFF4A1AA2A3A9BBD019D9E708C8334846ED0C75641
      DE689840D81B7CA587385350E4C09706A3A8AF8849C2B083853322B251133C76
      0C3142DAF508FA38C811FC7604E37D443A0676812C5AB01A928038FD3D18CC0A
      6382D4E8777D3C5743FFE84DC05687505620C0C18CA1E4E078C338834239C65E
      618927716F14C2F8F12197BBDD49D4C1A293A90B7186B1D09CF50072162C6532
      08B1505035B0DC9DB08311808BF4265047B1CDDD81DFF761C9C3C6C616615FA0
      930D43453A1A6CB208E71CBA1E288DAC73B0FC082289D6DD8769073B63D2EFC3
      160820EF540FA405EB044C0ACC3DE876A0B040C60FC08A22EC4330C2D1200F05
      96CC87D51691F6D2015B9EC4B08C06E0761819788AEA06B056A137107FE80461
      0FBA92DF0BA004425A45A311D4653067D8BCE038D8B209B970485B094660905D
      902F240DE40C7B46609160FD6149C122C4E4B09718484C13273D11AF8400815D
      398CC6D05D612DF9B81AFA4D0F4A037660E8C3A0ED86581EF04068C9D0214623
      F00F7C30C4DE43BD0961A50E40BF30C920F8B12F38E590AF9A86093D0E464877
      340979FE510079448E2DAC4144222E0225820987E0E63009C02540B11869D8ED
      C0DE093A3126DE9B8CC09BFB9A4C40D2A220DD228D030C9583CE1A6C5E2847C3
      09C4206807E70F1A5BA0073013A1B692D381967B42A4ADC1BDB16DB09DE8D0C0
      EE897C1A01E800131C423060C7548CBD804201B5075A1A9830167F1229358835
      584F5FE1C9239C2FB2AB414530F0B1E4900A0A3AD39056187B3400E308C09746
      38A230E3F119980C6818D480F99390015982A08660B3211429E8C0B01BA1D740
      C2E23EA83C104B1801D6F073ADC50E98D6A433A1D18A951E88A5D91B7DDC5A2C
      BD33908D9FB4DCEBFE1BB6E1492BC1C1C089EE8DC85D120FC1410245160FE829
      1A8F71118E0E194ADAEFC330240309667117B6480433912C9A31D42BB032F003
      3D9940B90D2623E8801328673854910663C2590635401AE102E8F613D8189053
      63689DD001618843028C27D1A40F51106069C6600043F0571D75A1C24C60F0F6
      C63E19643E4C1FBCAD0F357C8443D78340850A0E1D055AB91F4347C2818281A9
      A04DC1D2F17B3DD55750E361BB051184170C119C5AF03672CB41DD859E0A2A1E
      620320DF2145BA18FE002605796DB00CD0C3C69321E8136212F6173618EA2A58
      095446E2518ADC0F218E1994394527DD0F61B10C404EA070A83DB273B5DD876C
      EF45548EF9EB3DBE1FFBAFEA0D869676AF3FF85363206FE0C77C8177FDD7EFC8
      35754A2C29ED53EFFC949FEAAEFF70547A1F3B15551FCADD27E153A3FA94F7E6
      AEFF2093DCA8B00B778CEB2ECFCEA746F229CE70E748707C3FB63E559FEEE7F3
      0C1EE9A053AEC040FE3F305EB130EC28FBD53FD6D728D81166D32C2F420A79CC
      0C3210ACCAD83C197C9ADE34EA83B5827A6153F5685D60FEF56015E3000F89AA
      7D7C0BD392BE1D40DCFBB03AFB63BA02F6BECF23A69F213D01EB8AAB4613A27A
      3C0B6A3DF44E459105B001F0EA11CC07B262A05374640C382BFDFFBFBDABEB6D
      DB86A2EF05FA1FFCB83D0CB0F8E5187D6A92162996B45D936D2F7B916D39D162
      5B9E2D773586FEF79114258B1249F3DE781F45ABA2682DDD43F21E1E52979444
      CA6B6A3C2707002326FF0C658435276A92821A66649B9783A3F94897C9E08450
      1CAA6BCC5C25AAA790E32C22CF8DAA326B2F652047652B9143C3B9B21763D542
      B5871241AB9C6558233D573E31195A55E7989854E7B41D69EC4863471A3B7D4E
      A6ADCAAC9F079934AC33071BAD4E758EF4ACFA29D19E0DEDD9B09E0DEBD9F09E
      0DEFD9889E8DD036679271C5E8A4AAA7FA97BE266B424C996DD13927EDA4168C
      26D58B21AB725BEE17D9F6B7C576B62DF365FA898E84FAB128A68FD96C96CD87
      FA52B6CCAB2791F599EA21A57A0BBC3EF347F58268FD73BDC98B4D5EEEE5EFF1
      F8AF4392D5068C83162219B4ED878383ED70F0562FFEFBC26B3DB6AC1FB2EA65
      87E4C5F36776B12BD4A1D089BF00EE24C98B1327484F9D203BBDD3FCD46514A7
      4E70747AA7CF4E5DC6715482352A974DEC53B4826D549C486D4C9C0E6D0C4360
      38CAA338C1D89811021357E936661CE951AD0E6ACBA32CA6B29A9F98405C8D07
      12A04F77224E0D8104E2BA994002E2E94EC4892690409C820209C0BA89EAC638
      78B3528B95009BD6BC28CA5551566FD983724D571267962085625577986D4010
      555009C1741CA6F3C5F7E5945BA94E53FD0616A8F8D546EFC57C30CFEF779B6C
      0B74245B7DCC16C5BA599411947703DE64E56E032B77A38FE68B1AAC480E09C0
      5CD71F78546B0080B25EAB1D45103819D73EC1E11AAD9B04CCD14622E9AE7C50
      BACB33583D2FD3E9A680A9B24841ADA3C65DE75BA8770A3238DF2D1619ACABD0
      B8B7F06AD4385810A421B137410B040B823424EE46E7600FE39441A27C335884
      8B0689F0B4AA6F8CA70689F2D460119E1A24F70F4E137B2C7B97970B58C772B1
      28D4479440BF6EF3FB55AAD6B8064524761A9766A369F541CCFD265D3F0C5E17
      2B58233E2F66FBC11D344A6850B8D046D78C5A453D5FED605C5B488C0A1B2C6C
      4465636307F16E34ACD5DD984DD2AE0E81995BC61D79ED262558C9B7E96257C5
      0440072FD31296D34140AFF5B22A46464F4F02A889B72A22B832F75998CF87FC
      61591E70300976DB1C3A5B038776C4E7EA3FF0AEE26AAF9621CB578F20D4EB42
      AD8698CD6CB453F884D81A2ED57208C63737C0EEF05F2DD70FE936870574F5B7
      35839B740D02BE57DF9FC1597CF5C3526D0C7AB869C0EAEEEAEEE67A7057AC55
      0CABD6B383D5A0029FABCF9E9728BC19047FF76B36F91E9EF14B1939AFF64B8C
      C32F1123320DBCC881DD59852A6608D465B30439C6C51FB3FDA448373378BEEF
      E5284A378E3243A06F53F5852D1CA7BEE1FD533642F07C8146FF926E723514C3
      0E74B7BBC9EFD914D6F2DE16D5980A8279577D3A59DDF7A193C41618D6C75B50
      D8DDE5AE5A4E3957D51A39E1E98412A0B7161853E40BBD844BEC24AD1B0B63D9
      C6426FA3361A36A23158F5945AEDAF8372B906A37CAEC148A78BC56EB9DA62CB
      ADB1C8626B2C4A5E060B0DF96D342CE4AFB06AB93414551A88E149037155ABA1
      18316B209A1ED883A71630F689A4030A7B085501CD8D0009C4D4256AC6AC05C5
      D42562F6AC05C4D4A506E2EA52433175492FCDC6DEB88EAC05C7D46B0B8EED84
      5765B65C179B74B347E4FF6A91DDA7C0917A857CBF29E66AB931B5F61826BED8
      4D4A1D9AA0E28B0A8C215C8E5A50F5AC70C011BADA01A03083C3CA4BCF83C843
      6FE4CCA035D69C660FC542AD52D68C38DD9347DD90F7769D4EEB470FB591B0C7
      CDD77AC9B0DB87C3338AC630711836417463451C56DA27DB77412DBB9B6C96EF
      9675BEA66A1A5B16B225B62D77D9B67AEAC650780D3B298E5C86ADFB786378E6
      35245DEFC75E536AA539B26BE732DD3CF6391FD935D3C473AE5A1C11B76D3F51
      EA366CF419232039CE9FAAF994A4EBBF4F4B074094A83CE6616D794061917940
      01B5757DF7B5E70FD9C77C5B3FDE763F0E671DF7B7AD87038129345B643FED0A
      33FFE1CEC4AEC637F27EB2DA662D544CC3F1D677A00D79980D34260F22D0A6DC
      085FE3F258875B99CFF55083F3641468791ED7239A2089EBCC3DE6C71A60AF83
      8B6B8204D304E33B7C0F2242C03D7F22044CC0022660011390800946C05DD763
      044CC002266001539880294CC01427608A1130050B988205DCF32742C0142C60
      0A16705C78E3B18E1370D7F5180153B0802958C00C2660061330C309986104CC
      C002666001F7FC891030030B988105CC4002661801775D8F1130030B988105CC
      6102E63001739C803946C01C2C600E1670CF9F080173B0803958C01C24608E11
      70D7F5180173B0803958C00226600113B0C0095860042CC002166001F7FC8910
      B0000B5880052C4002161801775D8F11B0000B5804A6EE6C1ECC4CA7F5528B7B
      CC6FFB578FE21B60E0051A9AB8B2FC60BD95ED0612679E31489BA4F3A27804BC
      A9D9A462EBF23C9F2CF242CF8DEC9FF2855A7776F6DD45F34A59DB8CF56667D5
      9B407A2AD71EA433E235B407438C7A0DEDA09331AF61378460DC6B6A77A3CC6E
      4E5AAEF5A315D9E1D9B6C2679BB8AC473EEB8EFB673EBB8EF7639F5DD779EEF5
      89EBFEC24A96273E63D1B4621B407C80911B709436F7244F803FDFDC53804A4F
      1E7E4EDD8063D47A50111CFB7C8AA1DBE35C2CEF04CA7BB4807D732C11BC1314
      EF04CD3B018BDCEB5C2CEF14CA3B85F21EDD83F8E6126279A768DE299A778A53
      7BEF56719C7706E59D41796728B5F73A7E00EF0CCD3BC3F1CEA16AEF8EAA2278
      E750DE398A778E567BD72708EF1CC7BB80F22EA06AEF8E1E22781728DE059A77
      81567BCF399B773D228A0E025BD6C17B68CB2ED885B7EC823D48CBCE8480C18E
      A3651E1704B6007141609FB6A820B0CD9F07E027D21B35FA398D0A027BE44605
      814E8E3DC808B2BDCEC5F21E0C025DBC470BD80338CE7A37B08AE53D18040679
      0F068141DE094EEDDD782B82F76010E8E23DBA07F1846491ACF7424700EFC120
      30C87B3008F4F3CEA06AEF458DC7790F06812EDE615DB8070560BD173E02780F
      06817EDE8341A08B770E557B2F6A3CCE7B3008F4F21E0C0283BC73B4DA7BCEC5
      F21E0C025DBC07834017EF02AAF66E6015CB7B30080CF21E0C0283BCC3DEEABE
      9110F89770B74BB51F19EE43D3AB74FB50A6B035367E5E6DB26DB1503B1CD605
      8617F75A95F4B3DE634B6DAFB52DD58690C344AF52A976592266FD4CB3B62653
      1BF5E8B51C292119A72CE167FC8CCDD894ABF52E13C1AA5530A9502B523A0F51
      A53C1B4EE749920DD36492246996F8D7E5AC0EAA769E9049CEB3F95CAFD3E95B
      5334E9FCDBB9A0F0F366BDD8FEEFE6FC3F78A875D0BFDEE39BF75FEFE1F07E66
      FECDFEDD92FC17C7B7BAFF7A8F6FDE870F2E230D31AFFE8ED850071E4C462122
      AB7E8FE489D1F85894803FF41AE5DC7FDF1F4E453A1B9F9D8DC93C99A96D4504
      972565C3B1A0842719F7A5ABB64179FE2C194F2693F17838E3C3C41771FC5F0E
      2F03C84346915FD8714A06BE3CEFD5712A0610DE9BB1477D7CFEFC378DD09836}
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
