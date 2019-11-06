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
      789CECBDF973DB46B628FCBBAAF43FA078DF2B4B77249900F7CC9D794FD692E8
      1B6F63C9C9BD2F4C4D816493C40804180094C449E57FFFCED2DD6850844D5964
      4C0F3B294B140834BA4F9F3EFBF25B37C9866ED71F8861E84723B7EA35BA7E94
      06F4A33F1DB95EC3EBCEFA7CC7B0E636AAAD2E7EAA76D32C1D0F07BDFE182F36
      F8CF30E63F9BFCE73828FCD90BF4F3F8AE5AB5EDAACF43016F6E77B3B19808FD
      9DFE6BF1DB7E5AFDAD3B8CA32CEB85F0A1DA85A10781D31D26F1C48FBAC3FED8
      4F5291C1F569F2ABF75BF73FBB533F8A53E1543DF8BF59AD551BD53AFCF3E053
      FDF79B602252E7ADB8773EE0E37FFE1D86F4F49093782092C531DDE2982D18A7
      4363E3987518F32C9E25814870D43FFFBEBF0723D64A26E93D9E2480B30A0B86
      7F2D982C0EDAFAFD7A3EE9C521CDCDCDD71B05E1A7077AF4DFEF3F05D16800FF
      52392FB75E3231B7D65C0EBF85517F7FFF06867B1D7CC4FB867E9839DD17BD56
      F745AB06BFBDEE8B01FCF63BDD1743BFFBA2DFE8BE109DDF6919B5B2172FDD36
      DC2EDE36DC3E0F41EC4F7A49E03B6FFC6CAC60DCD243A6F7419A7E7AC821ED96
      4783AB21C300C6A4E9D56B4F42811ECCAB531C2C8ED238F453DE3338564F985A
      4F2212FF0334FDFD5A8C62E17CBC52BBD62CC3A795B7EDFFAA7DA3098630C83F
      E3A44B477CDD078AA63CE8196F70BF12D28D036312DED3B0A5B61C5B9CD7C168
      9CC945F6CCF1CBB6E8197409B62988D4F84F3A404FD8A6FC0D8DAFB74DF9249A
      6B3AD46A83F2915BEBDFA07AA76C50AFD6E6619D85E79CB30BF968BBEC51DCEA
      E58FCE13B9B0F253EB36DD92A7BF4F84B8A5777FE24436BD92A76F66897CD62B
      7BB6D52A79F6E007D14BC4FDA11CA09498B5CA6076709AF8BDA07FA8575FCAC6
      DACD92215E013E067D3983524C4742BB7C063F06228B7CB828E432DC5619CB50
      7BEF3A8660A0F6BDE1B64B9F931BBFF05CBEE95EB5EC51B5EBC5478D1DF7DCF2
      47BD258FEAEDF64A8523B5DFC5078B7BED95F255B5D90B4F2F6CB4572F7D5EEE
      74F17973970D26FC68C9B565EF5EDCE266ADF36992E12882E7FC24D20CDEF014
      C2470B6CD73E4F404CD1476151BBF679EA517C6ECEFBD9AE7F9E70141ECC71A8
      5DFF3CD5283C4A38C4CBAC7FFEC0161E35F6B15DFFFC692D3CFB681FDBCD3249
      D10432B37705DF66BBEC1103BEF2117D40DBAD6AC9532670F92903AE2DB7F429
      6FE129752CDBAD327126A7C2EA99C2896CB76AA50F2EC262E130B65BF5B2478D
      4DE447CDFD6B9509C3E6FEC9372E6E5DC75B89CAB2ECAD36AFE3AD4462D5437A
      FB3AB595E8AB7C2EDFC04E6D25E22A9F535BD8A9AD44DBE45306403BB595089B
      7CB0085256275AF5CF1F08A58228A0C2439F3F12F94392DCB8ADC6E78F847E2A
      07293CF7F943A19FCB090D3CF7F983A19F2B9C0C78F4F347237F549F0D7EF4F3
      47433F6A6C253CF8F9C391BFF3F1567AAEF7391EF57F1799D4630DB094977C4E
      882D8C52369155E4597320B79CCD7C5EB42D0C542AA97E56CA2D0C532EAF7E5E
      E07DBCBA524EB882F4BB385629675C450C2E8CD4FC2C8FFDB444FC48E9F73E63
      567896ECB4A0DB7BA594E9117F27F55DA16F618CCECA0C5F8EA191D71CA6564E
      B61625001E2647DDC230A554EC9148C0C328C42D0C524ECF1665041E64016D0B
      639512B84762831CCB44DAC248A514EF9114C12319285B18A7CC52F058AC9033
      7A8CB0A601A75CA2FE1C152C8CF285547061984F88DA9FA1818FD655FF722A58
      18E639547071ACE7D0C0C70B7C16152C8CF45C2AB860B3AB7F194A299E918FF3
      E548650ED3782663CD07FA42947AB4B0C63391AA30D6F3196B3ED697A3D4E335
      AE01A94C336D73F38C357FD7EA8C55236EE1F9D599AA4258F3F14F28C6E5EA74
      6180D5D9688EA085015667A105C42C8CB13AEB5C649AF918AB33CD022216C658
      9D613E4240D390DE7A0EA3CC47798EBA600ED47E0E552B0CF42C46990FF36C75
      A130DA33A95A61ACE732CA7CA4E7D2345A683F0EE324EB857FEE266250ED8E60
      57A26AB717CE44F5F125AFD1302FC29F9FBACC03E05F4B8658B8BC706FC91025
      2FE4215CAF6D5E843F3F75B9FAE7FD3DBC8C7F2F1964E172B578311F64E9653D
      48C7935FC007FAA2E3AD04E72A6EF67F62A4467F3C4552E1795D0CF4E8FAD23D
      87611EFA0F8C08917F341CF5E0D49F3AB0C25F43A71B06D56E02FF52DF05BE95
      865EA3033F27B33073BBF7C1A09F85533FE9DE27FE149EF3E172D74FA77E381D
      FBF8219A4D8073F9B32CEEFA837FCED22C41411E0684B986F823C8FC69D5F9BD
      1BC5BF02D6C5933813CE6FDD349B87221D0B91FDF6C74DA29B6421C062D84F5D
      5CBC2F5D8E3E01D057D13630992CE1DBAA0AB82A00C6887D21807F0EDEDDFE28
      0906F45834354688A63886D34D23F190C15BD25F877132F181FFA7D324889320
      9B579DB77809234C60AEA95B0453CFAD12B0F0670F17EEC25FFCFB49E08A6719
      004884E24E84D59581D7F57BB0C22A420EE4E712C8F5BAF4ED32D8DD82C80302
      10A8879F860F2EBCE7A762104755092C78790AB3BA751B4BA1D67110B5923418
      A068DF6E775C672C7C0CAF715C3C35A9B77938BA5F024780450E4758F72224E1
      FB6590FC1C7E2D40CF53D06B3E157A9EC4C3DAE6E1E77D09FCBCD6A7F010BE7D
      3AF496605F4DC1AFF554F8D59866C3AC612C7F3008B2E04EC0EDA99804E36030
      1011FC318BE0A398C12B8D415DE79C61E7BCF7137F04B01C3B977194D18030C7
      2C755DF891C4F7836E960CB3F4A760908D5FD5E08F29BC2874AB6DF931C93F0E
      43F5FD30D39F7AFA53829FFABDA90FE4173E0CF9430F960E9C887F67F3A980BB
      D23B91642081C0A75E3248D4EF50FEEEC9DF89FC3D1885FA93BA3696BFEF9CCF
      B10258ED4698C1D6B002D7FD044AECEF3147706EFC5E28343E354C7C2A23D28F
      8E4495A9B3A6C439AD40046524C7DF71FFB6808D4B50FC0745609D339030F5BC
      9A9F9F17BE76C9BCE0B271F6F47CBC27CEC72BCEA7F5F9F978ADA5F3C1CB8F66
      537BE26C6A6A36C4CDDB9B21A34F40785E70FD13C85E5F0FCD74DB05A9E61180
      26691C29498777AA53BA53C36A7196B3B0DB1F7A0BBB534E5217B7064858827B
      A9DEEC559FF666D77B84A82BBFFC320EC3F85E0C0A9348BD0DC9796B430C58EF
      17A2C66361E453C4EE11BC24ED3BF849F40EF57E79E5FBE5D13216760DC3C8E9
      E297EDD9FEDE0F376F5E3B67F140F06E15A5A17C47B2878EDB849F6EBBE6C12F
      0F1DF3D943ADD9ACC3AF7AA30D4CF4A151EFE02DCDBA8BB7B46A184FFFD0F6EA
      757E1A6F816D6FD130D54E076F72DD0E72F007D0203DBCCDADB5EA745FBDD968
      AE190D24FCCAA55209CBB5608292ABBCFA93CE2F6EC6FB44B01C968981C68BFA
      17E2C552B653A0F485C97D6E3E0506E49533EAE0317D091670F4B1B0E92DA1A5
      1713D8F33448F53BCB99F0C20B1757FE09823D0D8F738A59CE551757F484E1FB
      7AF8F6A799F602BBFE3CCCBC6587FA3A4BE268F4E7DFE9A5619066190A58BFD1
      47FE5B4CA6A19F896070ECBAED7ACB6B79358FBF278DA54B3FA3611F0882FA18
      A9CFFFEC57D587487E1A12ED977FA4990F1234C8D7FCD7D4EF0BF90D48D922CA
      AABFF15F191C94EE8BAADB9D1DD73A6ECDF93F08247EDB6CD213096C3A25B5A4
      ECD6F709AF83E35A134F790B2EFEB32FD786E4C6A3B30FBF1CB2F3AD7B297730
      DD083EC2BEADBAAE78D97ABC92F5B8F57A7141740146C6DF68E55A794148D536
      B524DA2AAFB37CABDC6AC9DA3C24FEE6DAE802BC027F3F696D2BAD0C01F0C7AD
      ADDD5E581B5EC0B5C1EFF5AFAD74656AD7D7B936F8595C1B5D8057E0EF3F706D
      652B83357FF1DAEAB505024217E025F87B0BD6F69995A1D45ABA36CC2029AC8D
      2EC04BF0F7F6AFED532B6B3511D30B6B6B312DC1DFDFF4DA9AF5054A4217E015
      F83B676AE8CE726020FC1C0C2815C96B777E5FCADC9BF065ABEDB9DF1C6B5FD8
      6393B96FC50E6F88B52B22FEED20EDFA58FB168A2D7F2C6BFF43C5966D61ED9B
      105BB69DB53F476CF9C659FBA7C596D6022DF9B762ED0B2CADC8DC97B176B7DA
      A9B7EAD5566D396F3F765BD566ADD501F6FF0D7077DCF85554F7ADD8E47572F7
      2DB1457C25EE9E33F5ED5BDBA6B9BB5AFB5758DBD7E4EE7AD91B5A9BE5EE5B4B
      492C775F9DBB7B2EF0F65AADD52EE3EE4DAF5E6FB8CD56DB7277CBDD2D77B7DC
      DD72F72D202096BB5BEEBE0A77AF79EDA6D7EEB865DCBDDA70BD36F010CBDD2D
      77B7DCDD7277CBDDB7818058EE6EB9FB2ADCBD099A7BAD5E2BF1BA1FBBAD5ABD
      EDD63A96B95BE66E99BB65EE96B96F0301B1CCDD32F79598BBDB697A9E5B6298
      F7AAED5AA7D1AE369B96B95BE66E99BB65EE96B96F0101B1CCDD32F715987BAD
      E9B65CAF5AF3CA34F74EBB5A6DB9B5BA65EE96B95BE66E99BB65EE5B40402C73
      B7CC7D15E6DEF2EACD6ABD56E274773B6EBBDA70DBD62A6F79BBE5ED96B75BDE
      BE0D04C4F276CBDB57E1EDED5ACB6DD6DC4689E2DE69A0DD1E788865EE96B95B
      E66E99BB65EE5B40402C73B7CC7D05E6DE40937CAB5E6B2D67EE9D4EBDD3E934
      5CCBDB2D6FB7BCDDF276CBDBB7818058DE6E79FB2ABCBD51733BED5AB32C130E
      76BC56779BAEB5CA5BE66E99BB65EE96B96F0301B1CCDD32F755987BABDE69B5
      BD4E49389DEBD6DC067ADDADE66E99BB65EE96B95BE6BE0D04C43277CBDC5760
      EECD7AA753871F65CCDD6BD4DD6ABB5EB5897096B95BE66E99BB65EEDB40402C
      73B7CC7D15E6DEA8B76BAD46B3A4B87CBDDD6CB66B9E5BB5BCDDF276CBDB2D6F
      B7BC7D0B0888E5ED96B7AFC2DB9BD556AD5D6B9428EEAD56A7D56CD6AAD6E36E
      79BBE5ED96B75BDEBE0D04C4F276CBDB57E1EDC0BADDA6DB28A94ED7F03A8D7A
      BDDDB27ABBE5ED96B75BDE6E79FB361010CBDB2D6F5F81B7B7803D780DB75D56
      BFA68119EE8DA6AD3C6B99BB65EE96B95BE6BE1504C43277CBDC5761EEF53AA8
      EEF532C5BD5E6B0073AFB56D2FF7E72F659DECDC58832274DF0EA23E9B9DEB95
      E57C7D6BD6B669765E5C19026027D8B9B932B5EB969D5B766ED979819DB7DD7A
      ABD16CB54A4AD6D43A4DD7AD01682C3B5FEF165B55DDAAEA5655B7AABAE5ED96
      B76F8CB7D7DCAADBA955EBCB79FBB1DBAA366B9D5ABB6ABDEC96BB5BEE6EB9BB
      E5EEDB40402C77B7DC7D15EEDEE8B41B75CF2D2B48E7D65AD556DDAB7BD6146F
      B9BBE5EE96BB5BEEBE0D04C47277CBDD57E0EE6EB5DD6E763CAF5EA2BC37DA5E
      AD51837B2C737FF652AC9FDDFAD9AD9FDDFAD92D3FB7FC7C63FCDCAD375B6DB7
      E9951AE3819D632D1BABAEAF7B97ADBA6ED575ABAE5B75DDB277CBDE37C6DE41
      516F759A9DD2D66F9EE7369A408A2C737FF652ACBA6ED575ABAE5B75DDF273CB
      CF37C8CFDB6E0374F692BAB2B55AB3E1B63AB666FCBAF7D82AEB5659B7CABA55
      D62D73B7CC7D73CCBD516DB73B1DAF2487DDF5AA8D7ACB6BD72C77B7DCDD7277
      CBDD2D77DF060262B9BBE5EE2B71F766AB53AB761A25A6F863D76D35BC7AB365
      1DED96BB5BEE6EB9BBE5EEDB40402C77B7DC7D25EEDE6ABBD57AB35ECADD3186
      AEDDF16A96BD5BF66ED9BB65EF96BD6F0301B1ECDDB2F755D87BCD759BCD46BB
      D62863EFD57AA7566F756C8159CBDE2D7BB7ECDDB2F7AD202096BD5BF6BE127B
      6FB6EBED56ADD129F1BC771AC0E01BB5BAE5EE96BB5BEE6EB9BBE5EEDB40402C
      77B7DC7D25EEDEAAD7DA8D46A33CC7BDD6E9B8D566C7A6C159F66ED9BB65EF96
      BD6F0301B1ECDDB2F755D83B708726A8EE756F397BF7DA68BB6F77ACEE6E99BB
      65EE96B95BE6BE0D04C43277CBDC5763EE5EBDE1363AD532DD1DBEC684F7BAD5
      DD2D7BB7ECDDB277CBDEB7818058F66ED9FB6AECBD55ABB6DB8D927A36AEDBF2
      3A9D7AD5AB5BEE6EB9BBE5EE96BB5BEEBE0504C47277CBDD57E1EE8D8EE755DD
      B6579E14D76834DB1E7011CBDE2D7BB7ECDDB277CBDEB7808058F66ED9FB2AEC
      BD596BD46AF546BB4C796F563B5EADE1BA96BB5BEE6EB9BBE5EE96BB6F0301B1
      DCDD72F795B87BB3059A7BADD15CCEDD9BAD66AD5D6FDA7A3696B95BE66E99BB
      65EE5B41402C73B7CC7D25E6DEEAB86EBB512B29350FBCBFD3A9D6EBB6D2BC65
      EE96B95BE66E99FB361010CBDC2D735F89B9B7EBC0E01BCD9284B863B7556BD6
      4179B7BABB65EF96BD5BF66ED9FB561010CBDE2D7B5F85BDB7DC5AA35DAD374B
      0CF3C79E5BF35A58ACD66AEF96BD5BF66ED9BB65EFDB40402C7BB7EC7D25F6DE
      A8D71A8D5AB5C4347FEC763A145657B36175CF5FCA3A39BAB10645EBBE1D5C7D
      3647D72BCB59FBD6AC6DD31CBDB83204C04E707473656AD72D47B71CDD72F405
      8EDE6A343A75D0DBCB387A03FEAFB5AB565F5FF3265B7DDDEAEB565FB7FABAE5
      EE96BB6F8EBBB71B4DB7D16895B586F35CB75DABB73B1DCBDE2D7BB7ECDDB277
      CBDEB7818058F66ED9FB2AECBD5DF7BC5AB5512FF1B67B55B7DA69B4ABAEE5EE
      96BB5BEE6EB9BBE5EEDB40402C77B7DC7D25EEDEF01A9D56AD5EA6BCB7EB2000
      B8351B4A67B9BBE5EE96BB5BEEBE1504C47277CBDD57E4EE940A57527FB65DF3
      1A58E3C6B68EB1CCDD3277CBDC2D73DF06026299BB65EEAB31F7761554F36649
      67B87A0B73E43A4D9BE36E99BB65EE96B95BE6BE0D04C43277CBDC5761EE9D5A
      ADD5AAB7DB257679B7EDB955D7F35A3607CE7277CBDD2D77B7DC7D1B0888E5EE
      96BBAFC4DD5B3560EED5D2C631ED46AB53EBD4ADEA6E99BB65EE96B95BE6BE0D
      04C43277CBDC5763EE98EB56DAF4D56D78ED66B5DEA85AAFBBE5EE96BB5BEE6E
      B9FB361010CBDD2D775F89BB835ADE745BF5D25A366EDD6B751A9DB665EF96BD
      5BF66ED9BB65EFDB40402C7BB7EC7D05F6EE55DB1DB7DDE8782596F96350ECDD
      4EB5654DF396BB5BEE6EB9BBE5EE5B41402C77B7DC7D25EE0E6A79A756F74A4A
      CBBB5E15ADF7EDA5CCBD9AC3A5FA54B0AC04090FFE554F16A1802082052459D8
      1F7787FDD475BAFE90787B98257CC984CB53F9FC7356F5F4CDC625BAAB2E71F9
      0291C32F6C7C6915FAAFB84AEF79ABFC8C10B05CC0F9E357597BE62A9F2E0E68
      0EFF07AEB2FEBC557E8160B0742737D8570057D978DE2ABF4044780ABEAE43B0
      C355369FB7CA2F1016D6742A5716F17095AD67AEF2E962C3A6690F51BC8555B6
      9FB74A92179E2840B835AF516DD63CF777F8FE3FE96A7C2792241808182314BF
      152EC9A79AF54EA70E3FBCC297FD7806EBEA86A9F2242C3C9597E6C1AD5FF6A0
      B7FCC15CCA59FE586DF963AD7ABDD56CD61B254FD54B66A9A31D963FD658FE58
      ADE5D59BD57ACD5DFE545373B885E71AAD3ABCD02B0365AB1494325572F963ED
      924936DD168884B5929775CAC0AF4C4825DB5D2D9964ADD9AEB75BB546A76CBF
      DD324CD1E1A425CF95218AC6E692E74A30C575EBCD56DB6D7AF592E7CA70C583
      A7AA70124A70C56D946DBBDB6C629D8A5AA359F264B3E48DBA3675C973650803
      F0ACB51B8D46D90A4B30A6D1A8B99D36E04DC963652853F3DA4D0FD0A6F4A497
      E04CDBADB71ACD56AB04A05E09C2341BF5760D1E2CC117AF045F1A7818003065
      6F2B43976ABBDDEC785EBD04985EBD6CDB5B20D17B0DB75D024EAF84B8E4C953
      25CF95608BD7ACD66AB57AAD53F25809B2349BD556AD5D6B949009AF04575C38
      7B6DA09D5EBB74D74BD0C56DD61A30CF46D979AF95604BA3EA553D40B392A74A
      90C5735B75804BAB8C9B94208BDB6C755CA083B5B2E76AA5871D36BDDE701B9D
      126A5D2B232F407341812F6545B5127469D75C50FB6BD512F4AC95628BDB697A
      9E5BB6BE32D2A2DBDB956D7BAD046180A7B41B75CF2D390DB5126C01D46C01C6
      B82587A15EC68E401C8049C206963C57C68CBC7ADB6D0087287BCE2BDBF72688
      1F2E50EB3201A48CBCE8EE4225CF95A14BBD0EBC0F9E2C39B7F552EAA222404A
      9E2BE345BA9072D9C6D74BB9910B0C108E7BD91696519826157F6A34CB565846
      5F74D9A8E5CF35CA50C683335FAB761A65CFB9A5475EB7742E79B28CC8005369
      759A9D3296D42865499D3A50B556098E36EA2CDE27E22EEB85CE6F1FA3DB28BE
      8FFECC57A7A3295DC50FDD007E54BB41E64F915A55BB09FC4B7BF0CF4720A93B
      DC923B081EF09E3418E090F4A1D9AED500F6F4B9E5753A1DA0A0F8D905A60DFC
      028FDD64E267E3F709FFBE8CA3AC56EF4E7AC9EDAB00342DF9E17A06EF98A413
      3F0C2F131F74B1C92048A7E762E87627E11B3F19D1BD89FE3410C3FFAF0FDFDD
      27FEF48A742E32AB4D82287B1D4CE043E42773F884EF0FA261FC5BD79F65E338
      716EE0470A0A9C73118D4291C0D7F154247EB6E42B5C6D3F11A0E94DBAF3048D
      ADDD490CF46C306F76C70908CCF0B606222502FED13D2DFC1A1101B62B0DE208
      672206708D349A281E4EFD91481B6DFEE33E4E062051360875E0EFFED84F5210
      4408E9D5DFF7208DD7E03CF3A0910BF2206DF1C3248C52DE64FAE83AE32C9B7E
      F7F265DA1F8B899F9E4C827E12A7F1303BE9C79397F17018F4C54B7CE54BAF5A
      ADD1A74988DBDB9DFA008D7BD7ED549BFC790CC712B67402800F19C4F029D19F
      32FDA9479F46B32C13491555D854F43334FCDE0783F8BE9F2561779845BD7F76
      7D110D0671BF9BC13EDF4E009BD32A7F1EC6096048164423805F1CC599002D79
      90CED321E08C0B500EE771743709ABC6B7A0FF8E067EE6C39B93218C0ADA7594
      C180777E18C07501F070BBE938BE9F86A0A48FE370801A391C8151142762123C
      88411F46479D1D50FC4E04113DF9806FC1C7E0039C36C00B1776E12184E9C573
      11C1AAC4C3341D2759049767B0D8309DF6BB830836214A7B831E5C25AB002C69
      06EB8685A5631FCE3360D8BF70ED83D18430193E8CE9461774F9C1E8CEF80CB7
      0623B612E33785BFC63835971EC00F686086F9F8D1A07B1788FBDB201AB8F429
      EDFBA14053EC74D44B06C958F803F97118C759379D86F3EC3E0A22815BA33F8F
      B3091C96740A8B08A371E60FFE09CBEACE5211663D3F8CBAF00F2EC04BBAF008
      BCA10F7FDDD31FF021C94649378CE054C3CA050C019FEE132441DD34F2A7593C
      02DA15447D1186305018DF0F0311C2F91DC0F05DB8713A8BFAE820F3D3C0D7A3
      20414960C68AA87423710F23A6D91CBE4EE125A324BE8739C7C320C3894608F0
      6C0E70478209DFC36423A03459DA1D0A9C9C08C51D5CEE3FA4533284008D18C0
      1EDEE375817BEA0FFB70A470D6FE906E9E015E86DD31DD8180CB804EFA09DC99
      F5EF7C825506B3C587860902042FDCF9D943EFA17B9B44D3248D44D6EDFB7020
      01E14280A3839813C0799CFA9903D362A3D17F76EF019187936C188470901C10
      2DABBF23010032344B44364EE22C833DED06E1309EF87D3FEB87D16CDAA8E3A3
      8059777EE2FCF68F7F7C9FF8406D9370FE8FBAF70FF82FF8FDB71FEAE9D529FF
      7771FAB7ECA7FEED6D7AFDF787ABD767D3877F052FDFFECDFD7EFEE6D7FB4BF8
      7A1CDF5CDDE08D8AE2970EEC2E19370DDF776E1F3EA4E1D5FCEDF9FFC0BFBEFB
      E69F7FF3DE9E9FBA6FCECFE0EFCBFFAE86177FBB09AAB37FA5FF7A7F3A07FC38
      FD787AFF2EB9F9707D8FE3FCE5F7DF9180007C9D2E529181A3E809B0A4483C54
      BB88C92299B7AAED2E62B2FC08804D1FF003A053341689A0A7F111443AB4A7D0
      6862E8C391ED0342124172884B46F0557817E2599A46B37E32C14B68F373E103
      5BF5D039358DC67E34426E1A650F99EF9C48262B1FF7E86198EC173D5D834FC0
      D7BFE8D93A7C0A577FF361F1E9062D7BC577F79C83DFCB066A3E651A9F1AA845
      03ADB60D9F1AA7BDD28410CD3F3B54E7195302669A00ED0DFD2072246E03C87F
      052A900B596E157910FDEC213103C6E5F36F60A180C7486F50DE91080C2472EA
      87D3B18F1FA2D9A43BA4BBBBF18C509E0CCDD52E50EF599A01F31867F09A882C
      C64A0284017D535673164CD1A085555BF03BF53CA0D5B03AB7EA350AE66974E7
      E3B7F825A85F2E7D180AB80FD4A218EEE241405E0A8C3F063DFD47A3DBC7B349
      CF45536388688A8300380B53EAA1811C67546F17CDE4BDEED0F51A5DFCA20B1C
      F716C423900C6A4D20ECA9B9C42E0A528535FF34F6B317A9031CC581BD79B818
      0499533FA99ED4FE0F894389C37BA7766DF37BE63E6DCFCA20546B9640088002
      10FA2C5C5ECD4643108FD2FD3D0907564DC8A19123B3A6D39F7662C848BFCFBE
      54238DC2912A63CEB0E6745FF45A5D60D6BF2FD98F423CC1CA1BB3E097C76757
      D8AA305DBE41F8F86A5BC4FBE3D51760C4BBE3D53F0FA5FF00B5C039763EE0FB
      1D10FB8423A585DE6CB4659BF51FCD461DA6FAF3E5BBFA2FCED958F46F1D90CA
      9C0B92A9BF7312318D412A7348C676EEC7A07CF9707104FA92F3D2897BFF441D
      0257E28CFDD4B93E7BF7DA01729B048896DBB64EDC929F700524D3015A8C6025
      7DD4EB8E1C42956340B6FE2D5ECF62E782E475E7340C9D69120F667D91C2D249
      1779C866201E4E44347332204E0EF295143E0A20B7C6634394940150A0AF64F3
      AD034713C17176F1FAB5032BA81E559D893F777AC249A7B3248867693877FCC1
      400C1016A07F8603527D52673023C8F543E123053FD9BA85B5AA1A9FCFFD09E8
      F0B0B251D077C47008C89AA22776BDA77D7F6F12A4A1DF038D490CD63EBA93CE
      7A8CA6DB0769A41C57AC903B57376F5285434C350077806103A9154EDF4F0175
      887CA0AEED48930B605300BB926CDFCA9AB0B2EFC7718A8BB8B87E0F471F0EF5
      9B78007AEC6CBA7DB4ADD586F99EF6E17CA63F0671E823D9017007A170462242
      F3199DD9381A0285CB1C908EB3595ADC9DAD5B13DCC8E7F8E5E5BB561398533C
      9DE32A8866A14909E60FB4C947DE8A6B00BAEECF52E180783A48FBFE14AEC521
      2C064101F7115A1E8B08AD090346451024D3713C0B07D18B6CFB968F870BED83
      83194E186D5FCE308927F2931F8433D8BA28CE605968A41B38B04EA015A9F875
      062C183E123A6CE3C636606537F3698C08F893F0A77F3D7F7BFAE6AFA7513061
      C485EFC477CE2B9F8CEB7DE7F8AFF899FFD8BAC5B43D5C0CB0FEA99F8D9D1EBC
      BE8FF67F160780D6DDA3288CC4A3E78368D59B651992BD6048DFDF83761A835A
      0377C7B143C6F5AD5B600749E1793C8363E3BCC63D8023180F9DCAB940D33B9C
      B78B5F67C1D4B90926A2A23614F61068A573411C77DB56D4AA22B1AC9CA10003
      0C0B487C9256B4B0E60C6291023D90A7CA812D5137A1A0340C12907581CC6CDD
      AA5C5C954F67DEB9337800D039B4AAE3B60D407FCDB66FE61E0A6CF7498C8895
      0C404B4205E41248029D9BD7F801F0EACDC7EB9BED9BBA2B4FFF9B9BB76F1CB2
      94E35C3F9C9E5D48DD020FF77D1264E8B6BA0F8044AC24205216C6CA22E22C8A
      04EEBB9FCCD72F7E02E64F82880588AAD39B6F2302A12AF3FADDF9F7A8DBC1A1
      46E6C8C04E0448972242BD456A6A70A4DF7E040102506C1625228DC33B940880
      C30029BB04D9F4EA7CEB3866AB864CE6ADB877CEFEE600D9BA83E5D07C258AE1
      3481FFE3B1E1233E703E5C5C7E00B596C51B92127AA80725B7F09D2FD5F9ED5B
      660D96D9476D9A747066A01307940B6038B0AF1BD0DCA4AF7E20A2F59F1CB93B
      8AA1CCA6E8EFA465854104B280C8EE05602C3B0EFD90A89D8A1D00E4CC008901
      41D190BD7D3B85C229D94C9C1467CB82CC8B54AD592D0314BC18D73E8CFBA06F
      003FEACF12388F59387752C0D43EA2EA24DE36CDF640EBAF30E3F320C5251D22
      6A4A9B87739EF8A338EAC5497422D209D19C897F0B4424F6414C88E2E8D81F8D
      60EF520EB4FF26D696F8E91879D7DBD31FDFB0D89025818F81168E188C04F2B1
      6108CB9204042F211A1FA14C4B48CD31F3A05BC6092C9AF8205EA63B9933029C
      0017C238BE85C3008A1B1B0E00242241FCA737DF053E3D76818FBD861700E546
      02FD8D80F14791CCFF3E0BFAB7D7E3F8FE4CEADB6C17812331277D1B901F0932
      4606387D9164E87252AAF9B6F19EB275FE0093EAC7681E3C60A6E9FC97D3AE56
      0F9545D5F1A5720AD47C80FA2B5C4DD0D73B07BCD8DFC3430F6AADE4CA4C2388
      37E3D68F304782656E44355F7EDE32C8ECEF95C1C61F90B4ED93CB8A17EAF843
      5C0D2C11BF998A04191B9E24D043C8182D9C9BB8E24C67192B8EE6937CBA583E
      0E637FC042F29641A30C1686DFA02FED371128BF3D18124E36C968E96D102155
      FD4656346055985C05F85510656284980ADC7B08FB9339C0D826FB7B18E644BC
      3F3FEC41744C514E4013038C67632BC09CCE0ACC1919A90F8C1FF4B62D834539
      AE03E9D2748DED8847E82541190ECE3009086CA24A6761A6580219EC7A029121
      1749E5D9984568DF1AC821BE157258105A2541449955C9433924FCF0DE9FA720
      791AE260FE00FE55391B07E12041C9705871C8E04CA23D91CAADF4041C0CE319
      5AB8E6A07EDC8910E33511283783E1051C05380827AF816E5D26F1E403285CB3
      044E803E180C5065104BD4F72C2AF4500380A1BF8DF512DF777E3E9D65F12F0E
      9B9728802E95B2AEC20F93BF1DDCE3E8243D223CE0CE281587DFC67AD9C71644
      92B5E78E2A69C681D38EB6FA6F633141F44F5647160518A4DC4498A6B8A04112
      4F0179EFF170AA73BB40D6BF8DF5C6C9146816AC7709B9490D6FCA699A0A0C00
      901AC15C7AC731F83B04A116F079A2C87AE4DFC11D423818D9AAA35276343A67
      7FEF4D1001D5DE4E3EF6D54374BCAF1FA2536B15FD8B373717AFE08A4CCE5862
      C6ADBC0A059CA477948E00425A65EB22AFFEA3D9EA1417F5E3D5F51589A6EFCF
      DEBCCA293448A6F07BB07D52F77FB43CB475A6B3E13078601F8C1FAA9813549A
      82815224B66EE6355733C58AC222D7AD28F25839F733FFF832F44769C5E49543
      F668AB8D4144FB812C92ECEEBD02FD220980929C8930240F5C65CB560E4BAEBD
      BC7CFBE32F0E2ECEA9E2825FBD7BF73767022210ACE6BA9FC461B8BDB326D35D
      E5035A5C2702261B4CB3F7498C4A4AE23C5C5F38170F194865E84D7B1D8F2A8E
      7FE707E1169AA43EB024CD1AB7C6A6C8790F22360833D7685E21857B38C39836
      7457C37B33E1130E223146340D12076B546CD9DAD09A863EF2300BA6CE18546E
      D2887E043903833C6693C8E184836DE3B3D7ACF60F02F4400DC9E794B2FE783D
      EB7D6002709A24A0116ED9C47FBEB9B86EBCBCBEBEF84546015EBC3DFB0105BF
      BF01592387190ABFE9AECB78B0BFB09B2846BF87974E4496A3E01F0193E74061
      0DCEB3EB7882712F6AE1A4355004A9E807C380C3FF7C54A0248CEE7DB47CDF7F
      F705B8EED164FFAD45E2DA7345E2E530AAAF0AA4E35FD17E81EAAE76466C2056
      014D7D8F867DF6CCD3FE067CC3DB88A4EB861C1A6F97ED3BAC7ECDDEF04DECFB
      DD66367E37B61EC90E9A22D18B5B1C1CB37BB773C3FD51680FFA9713770A60F8
      56F6FA574BD39FB1D578BABFADEDF637B6DF3BAB9E9CB1F119F536724EA16B8A
      1C53BBA3A39CA69421F240DAB78FA97CA0BC92CBE2DCBF8F4633583FC5701DA4
      42385875330853506242D2DBE1767187C9702A61E9D0F9FBE919E8312939AEC9
      084911E286B9C597C92674F8302A139DDDF8403C20A5E8C8512EBF8190D9CC7E
      9A8A09EAD4D958E8A8CE94CD7F00A2144691F92E45730DC6155338BE8CC0C2E0
      5C1952732F121CC897992EDAEB8E53C720123150897B37E32095FE79D6D82488
      A4CBA72CE6ED008DCAD3384D835E3877627841426F480FD5C0BCB600DD9AF74E
      1CC15D126605881990C197AF9BAC14367953F48540D81318C110CF12A50663AA
      281A3E51F145B39B67A8CA56055EAA02D7BFB60AFC364612F906F0F48D44CA4D
      A8C04855283C080F448EFE74DE392CC69F4EC380736FBFFE8978E2EA0E9898E0
      32A4E7E33A9E85CE991F2491B44E0F44DA4F821E2C9028ED97C43B7C8372D965
      9CF445396EAD4934E3F82246A0450C0374C2FD28B0A6030EBD499837F8D13C1B
      4B1F3FDD76F89564A827164659B10C092C66FD8548BC1D2F44F2B7F8F832F843
      E33DBEB64CA962DD41109BA5941998DECA041C9FACDC707AD2D994FC718C2732
      F60683E1481A40916D96E2417BEF6789882374D2BF84E7DFFBF3F77EA864A82B
      2D4049514B7C7E68A707D218085C706B3011E4FC9F80283206016C104714B990
      52983DEDDB1146A82418D53F086480362555F7138C66025906F692278A009F0A
      2C50E81CC04471049EEC211E87D38FFF2B9728058F0DDF73E2009A98E00D2AB6
      9FBFE45C58C523B2782A134A402E8C18B6787D82D1F1E8F83FD9ED43B6BFF73D
      C88EC9FB5880DCF0633010F10E399A4E89E85678D91585395871A6871954ECA1
      7C2A2291D47E1F802E124FA9ACCDFFC4B39B1908EE18D846256DE834F121933E
      AD3EE030CE01C3E9F2FDD871D4B485A8CAF499C61644B9E5D59D544CD27B0132
      E10528A7F3698CA1146EA3B5651B07D3C6AA03A72A9126A5A01C5090FC11B139
      E2507F9F8914E5B11FDF9C9E7F22D7523D7486D59839116DCB565B9654C09427
      111341CD689C835974EF47705F383F9401F39849A5E81A9BA582289804FF322A
      9C90C5C7076AD60F632CC283F200A695C689B2156135986D0BF829CF38F949D9
      B3520CA3271506E838278D64F7419F839C02E39E1470231A1C3981CA43613B5D
      A49393708C4444FE04B1ED84EBABA0298B2AAA8C6719C67B6F197CCAA0F33345
      B47D8C66683494A96318B40A4CF0D59BF31BAE461047231406C5308838F7E6CE
      4F020AEA4901759C0399352E5549E08835362D1E6E1D852F03C3591C86FE3495
      B54A2471409C4781F4808043E7637F8F93F55E52A4297EC0F02C4E4CA29A1F87
      64CD9B4598CFA0733583A43F9BC0A9A1BA02796A13E67B50B4BC44A93C5A3E55
      A98D84AED81C72DBB204CACF5BE55C8829155F424C792713BB2B79064F9F8A06
      1A16F03E2614A84C020233A6FCCA005E5D4C85484F24D82A0138A68BCD911087
      2AC9B6A5BD7F9222B18EB46E9BD1FEDE558418B5FEE204B762AE24660CA324EA
      18F0869AAA26A6809C6549889F876130E548E64B4AE707995C1709149CE845FB
      8FE35540A8CEB62F91B1946C52A4E3F9E9CD2995303ABDF980C06032FA8D2CE1
      276955C08C1C7144FB14ECEFF5A9DA5489664419D7BED30BA93415FCC0330BCC
      E200CE2626DE6349FCEA3DFC9C0F6A32051149D8C337929F76CD19A5EB3E936C
      375F7F8014C0770353DD44BC8C948E941DEBE2FA0D958620148183C496A22960
      E83BAEDDA4BD96CA61493E4F6019BFCE824410BEC9ACC80CBB79A4C6F8D2252A
      7408BEB26FEB846178FB37828FEBDE5D508FDE30333D38DC04422A3FA69FFB30
      313540B26E951FC9453C64B102DAB86F63376E3863311871A1344C5CC4BC45A3
      985600DC8D841B648B58CB862D491356B98C2C5E0EEDDFCE4CBFB2DCDD3CBEFF
      2792DB606DEFE37BCEDABDFEE1DDC785D251B0C9A3680B935ECA539365720FC5
      A82341E212CD1271B3C48F5290C349E951986C94B74967FDF1B7B752D03C2E5F
      5FDFA8AD836D1B0429D73BA5C7C85AF56D2CEB7C360D833EDA708AF9C9DF7FF8
      F83E550B94B5037CAAB83484DD0CA54A6FB01CD6C8F274C11DB5D1EEEF499518
      70E12C8E0601B98176C783B06CF5E4573312D9316287BFE2382EE1A7C802308A
      8AE804958DEF678E8BFE2CAE4DE767CAF66F0CCBF48432D3E43BF3D377E29C46
      52355AF45FA0C79D43866032C1AE3B1568C3F6F7A658828012E4580079252260
      448EAAACE5BCC7D4D8209B2388CF0B046E07909ADD62EF189B2A0AC59F0AAFCA
      22221EC85553DC6896CC840EE993B657508D250AC3273811C11D289CE65BFD25
      2F440B244F867C6E3D2C7904070684CB797E52761CE9F7F7DEF811F696385351
      97AA2C31539581982602B9E2607790BC1C22072F4EA753C09E4BEEAD8232B8BA
      EBC591F3E263C4C550C9E371CE8290F3411584DDDF4BE126FCEAC507AEF45CB9
      C24E51207490B18B35AB8AB26BBE20F8A335251808D459E35E1AD3E84A4BC542
      60D427840E0660FB0BAE078401853CAF17A825F174E808E8B8582A0EE63B13D4
      3A46A8EC9230C6E5827246F026A63261CC764815EEA1F6BDF816A5B6B15C15C8
      F32A6397B086EC20EECFC88B76005F4E30526F1A92D31BADD9148F7744663FF2
      9F081FB64DC3FC70E7CFE7CF58E0F1170974CAEED6451E8F961480620CA3CDC1
      70012A6889A9DF581E5DEC90F87543569C14163E519A343937E94020C2E25940
      35937B16A89023AE2A047093311CE24190683690629A3450C3B7531D5AADC33B
      6285C5F093DE7AE4CCE319BD8D9C7D8CE158CBF46474F22501D9FFD6A10BCDAF
      1DBA80076DE939FB6E35431A462DAF6C4A03251AF17179F5D61340BBF53B6036
      60EEBDB9B8AEE332F6F77EFCFBF5D946A6BD65C7E419F8F1242FDCF5F50502F6
      DBC68D062DE10988F1B4C0FFAD448D5C2EDA045A5CBEFD51A385CEADFB6650E2
      F21D518BBF9FEE14466C081914EDA5971878F04DF8091579DB114428CAE3EBC7
      0579B0F035F8167C0902767FEF5B220BA7DFBFDE2C36ECA0DAA3D57E590E9C34
      909FB809D8993F559603BCFA067D8CFCD511EA3954A40E3426E1A79C5E2204BB
      B3384A549BF0A85F0847C3630A088FA634A09D57DFE9E463316AB2163DD6D777
      0535D1F95D4A3700085F98E1880BC3ECF2F5D339ADDF2BF316C57066F14850E6
      F9F2CE5ACF560B3F594A634BC9F7862BBD3C36B4708E5A86AE01DD868C2814A5
      CCB0674D868770B8B9F64EAB3CD43892EEB7C904CD654836D4E0649BD994BC83
      FC6D718F73249649049B2C1CB0DB74F8E221D81967DD8D6CEAB2E448AEA38E97
      00507E1DA2EB1BB9B0DCCC195D0B2CEE1CE0E9452EBBBFF7C82ECEEDFA8E1CAE
      B77B880483C251654514B815BD1C7D760F62E68A6CA18384225615B8A9295510
      05E978E75D871798A2E087BB94867DC5FE639D0E8D229D04C3824BBB58924622
      333B0136526343CE42F1988DC80D4AD0DF94E823780DEB9F3BEC8C262C6A634E
      1D4E4D54E599F23681818CDA0B867A6F31A30D23BC382E552A3AA0F64BAF2848
      10248C509A8DC3ADB1296130274FFA6602DE7526FCC911FFCAD35A8C14C2448C
      02C0F379EEEBE51A1034051E88CA69E3AB19C55488C38C62262979025439B582
      17A983B5E0E9A113DB28E312BBE4CC32A7D5DC1DDA758EC977325E8CF81E112B
      C63946D77E9F1356299C915B6D0F38CF53D62243CC774FAA2775C23BFCD4408C
      EA8FAD9EBF772DB3F84028B97A7BF94E4571EC0E7EBDD745DC9064110C546663
      8E6E98B5CFCDE90B3760505741FE12D1621031973A011A37A28480FBF1FE1E56
      1042C98D0B0F9D380737545448879127131A2B023C49C8D5AF93FFB2594299CA
      F170C8F1127841A689C035E9B15759969C1BC265B254636D2E79C7C6B5C56673
      AA3B152D911B53514E2215C7EBCDF38E5C023BB80964AD677F3B512925AFF2AC
      A8AB68187F57402787FB470BD937E1FDDBD337FB7BCE812E1A88F71EE63DA855
      3EEE24E62476D5FA8FEBF11DC90CAB80C2EEEEE3E4D6E899C95C488E333027E1
      4CB01260BEA73C187C86D1C4094641F8FD71206892417A549CBF917E29DB1220
      D94906326D355F961C6F11EC31ED8659F78582D019D40B41AE29E0056E0A3C54
      D1775574B0210E7683B1868401954BDCCC499072891C9841F14E6019A920BB28
      003B15894CAFD590CF8BF15121C47C56283B207AA1D501502BC7E8437315CBF2
      422842253F0068C1E55E9D346E3F0F5277CEAF4E653B97FDBD81CEBE63D4837F
      C19DAAF566C0F7CE0F67A831E9A475BE9D105B230A2C5A77DE62C9E7EC6F4ADE
      C97BAE717949FD10885432A6C640F64333445E6E3D7CCD0DCD4EB8348A4AFFA1
      B416332207A394C5032879229A29DB8D6C855668C60163C371C80AF04C354015
      BC31242D372A1998BC242A1A0DD9D97D2C710BC025FB4C135202A888B6E41827
      3411500FDC73AAAE181CAEDFA8748C5886C8B00197C9D1FA67FB367ED27CD734
      DB2FB72D2345C0A3B281D9E211DA007CF319AFDD09BCF3021E66967E640D0D43
      297747B0E3945AE63C29E6E4013713DC6B36EF2966F6D995B438E3006069C173
      A8BE150A7092820E4822D2251C323199C6091AF2A93799E66EB2A88331FE89B4
      FFEB645EB2C2C88CE0912C3249220DF5422563CDFE9E32D7A0B4426C45BF4F4D
      228E8E0782DC018F65B41365250C51889B2F5A0BB5D484720ABC9B40B6745AEA
      1819D8A423527373A76998C4DE598F5E8849CB825F6374D8236EADE4E408F8E4
      A3D7EFEF9D90B8319D2553B470B2E8A7CC59DC3F5C255A4494597DC132EA2596
      DBD25E610D1DF25AE0DB18E66826911DA6490A92C9AA27CEE52C2103EEE360F2
      CC60FC3A807CF1C586A494082E1A81D2749A07E42EC213A681A1B7208E6071A6
      512CE54B8ECFF5331D5FFEC9B7C14B66AAEC26DCB7F08E3CB85704B43819E31B
      649B30F0C124F3F76F28D0521BF9A88A93B23CAD9D4FE5EBD8A00321B7F39919
      4BA79CCB4FD571DE918CFFF94C242307E9DDA31C24C3F846679FCF24097D2957
      0B40FDF03119700E8CEA1972DC23F508A7972E3EC46FA14A07547F1DDFA4B546
      9A23602B69B18F10D54CA0528642A593B0FD5217B45265AC44965102F3A2BA25
      47D12736E9F320B9B0BE767CE14DC36E82EF36218D3DC6999D95714E7AA9FFF2
      A4E77BCE0F8014E11F9BC3FC55C59C859A9B7DE421438A957824493FB7420AC0
      78ED38FC72ED755C000936114AAAC92DA63663361BA53B532AD82067390C7E34
      58AC7B5DAFAE4FE1B10DE8CB851AAF6CC1409692167C853717D7B5F597DCD904
      426197117810781C4975F7D809D82F2E86044D991785198CE281140316F0B840
      C9E53B76156067687DC366507573EB37A28E58C0265138C52A1F419ACEC8188D
      62A92AD6F7ADEC2F8BEC1C31015B93F8CE5D4C5D63B9809E8F3D1B4694FDC67E
      CA82950BA4A3F731A8746385D78D4338B55C22C3A84E28808B88141BC0C45359
      A390044C941588E4EE38CBBD789862F54650B2A73B561E83AAE4C8551B2658C3
      798E723BC3078471BF27ADCC28C86206F35DC01503A5A2874D8229E5186B6A3B
      A7701CCF51E7DB71F4C276C1F072AA84793D1562F08AEA98EF0C9ABD6365A6F2
      F1CAB916FB7BACD254109B8E248255184005E8AC5CD7BDA214C285D81F53510A
      A45946F770CFBD84A64F8347E632F3ECCAA47A88689C592C89184CA609558EE5
      1A002846A1778F8C2A5A1FBC063CEC672AA1BFA0FB255C7C80E6E0CB03A89C43
      CE0F229C3A2F65B97FF8F0563CCCD237F1003F7F1F643FCC7AF041D680844FAA
      95C44BD961E1A56CD0A057627BB9A87794F5727177BC978BADE55F9610DFFADA
      09F1FB7BFFD174DBCEB1533BA9911C8FF85A758640C9C898CA2626657DE6E67D
      A8F9C8C2CB13E7EA1C04CC5E22FC5B0EF0384E04C7EEC21D4740F912BC75DB6A
      69C29A3BD80A80CBB80171C3F5A2E2726FDAD83E5CBC7F7D7A76E1BC79777EF1
      DAB9BC7A7DE1BC3D7D73211B076CD992CA2AF8FA19BA41F03ADF20039844040A
      387EE6DA7613E281B95C5F10EA112DFA899F6E5DF1C2922563D1E197809CF778
      B627313A0424AF720631196B29100696D9ACF7826F65235F8B11D6DCC7980832
      CD52B6DF6CCA16952A17D9E792F2A4B7F617EBF16DFBFAB8C9C0CDD9E547DC19
      8E1DCB937A382CB7721993BFEFE3B4F2ADAC2A2F895A798F113609AA3120A0E6
      6501757030D6A99966CE4FEFDEBD378257BE9185F692F8566CCA32B27623E586
      8CA9EBB7E010DD15EC99577EED60A163EF28609792EA3D224B7E7D2388230BA5
      5DDDBC31AB03FB54840D249020FA276839C4BECC68DB6D5F55E53CF0C378E4DC
      C4D3A05FE1F0C39FE2241C8024D81715E77B8E79903EB63B2C4B94226583158B
      8729DCFE8DAC9333AD64892D0AB7BCA6EA6E1F441FF5624915B695D52E2F13AC
      DA5790492A488D9292CA22A58AD4FB2A5E56968D97B6D3903196AD0070889744
      7E7E1B9020338812FEA5EC9447C2F4FDFE5818D1A4DCF94186CF70913FDDBFD2
      68DFB2654BDFDF2B593C87B9C0FCFB14B2B33C7C7740B12A6CD2048C80974BB3
      0BE71A698C89B8565CDE0F05948858A61AC1A9A1D10A01405B06A51218298708
      AB44E9A6F2C60087D61F1380BA4DBA8964F9BE9F9687BD2CC6AA3E61C2D4528D
      1BE2B0BE465AFAEA207FC212AEA20CD48D4407E06DA2A5B7AAAA0EACC1E9FDA1
      49DB5B6822DBDF9356553650EF8AF57E7FEFD5DC99C6D359E8631A038666A2D9
      BE60615E8CDF42863215F154957E98520E8B0E5CF43173F318F3305463625360
      86A70664BC82CBD2B2BDF30EA4DC018062AA7401F476CB8DB4BF47E175EC3192
      564FF4EB2897CE91E94C51BE9C4F012E2FCB04F27D2F0E39258E0C3488015FAD
      B2C037E436A9EEB8DB04715215D8DE9573780A6A322F1AE9D27D252F2C9E8795
      5164FC40C5B4621F5BD9AA5B4BDF5882C78C6AE56C8262803DDA4F31CB1F73D9
      46893FE1A89513E795ECCFA4BCAF95F318E3CBD9DC1A652071C9E4B50ADFD78B
      1F72B91E84CA08E5263DF87046015134762A9FA7FA6C4B4AA7E30A5562DC414F
      F47DB45CCBE863F84AE6717FB572E9DE7A4E85D72A39155E6BC55371433E76A0
      C167E85F077178570E07D5FE736EDE9D29C9C8886208C5703188C1C031F21A1C
      509402B9B800E76EF34870E34680EDE162A60AA13E085D633C5EBEF308FC1A21
      D7AC849CC7337CD35918F46FBF5E95B42729AA1700910DA8AA729F70E7394380
      8C07328A5F5A9B644A963627E8F62AC1001444891238025242C2625F99B230CD
      0B13A98DF8F86BD4359D0365BE006045717628DB4C3C1E90130B8C2EE0B215B2
      CAE29599CDFEC80FBE9ABCBD25F48BEDA3BB5452E95475FC1085A2A285DECC06
      0942D3AB91A8B1EEFE96AF6F9C3F39D7DF44D5C5FDBDB39B0FAF61BA97EB9F2E
      9935CD762CC20CD55D77F5DFDAFA17A0E90B19A929CE0E0BB7496BEDAD10D354
      2E8D625554F49B32CCC2EF140D09714A5ED84DAD7C330C617F2F5FBE79B69E02
      00B57265E796E31020C7D44817018B351A2229941EE9E4C154376E96B984CB87
      90CFED38C1FF7F713CD92D72FFAF18712DF14139F293A7127C04972E13C2453A
      74A7E0759F4E495EAB47CE9F08B98FD77E5277DEB8F8F10A43A527BBD3978A15
      F628BE07222D73A9D24241D3DE0C5DA1C0B33468289A7CAE909EF28EC9C22193
      CEB37112CF469C3657A1272A5CFE1DC3CA5532EF3CCDB089345E3A08FA71A46A
      E82CE886878508F77B590A1E50FF2EF0E9BA9A143BBF232377D94CD1FFD46D0E
      C5AE63A9569F6B2761C181615159C18ED7B97506961DCBB4401E9496A16A1099
      AF62332C3DCDCD0B53811B9A293FEA6BF28B1D0CFCE41601878C08E010E2552C
      10A6EB6EB126730EB73907EA5B75B77CD8BC995F68AC1F5F2F7D630EACF416A1
      8CE98E8AA772F92B59E2AC902C4055F6110A6A15C0B3C75C2A437151DE4A393C
      FBFB5437E989D8F5742A46057F7FEF1E0B3F60D009B549579D41FB7118CF925D
      A135FB7BB27205B71DF61126EAAC69419720E2A47D02DC418FAB57B0E8160D10
      3E4C05527927B9C4495AC480B207EC981D60B4873EBBB40387982ABAA1D3A67B
      59B2C1767F4F996C67DC7222180668219523BDE4110E7944AAED9297D7534BEA
      51A14B5D129E2FCA54F0DC0EA60818621495C109313F3E472E74C0CF6C1D4C19
      89BCE4DCED0C93072937FB640299193F464753C56F4BCBADACA7178F46A18CEE
      24535B10CAAEC6FAFE2C8E437942E543D29406E703D80D9BE780F5F48248D6C2
      63CB2C6F0BA5AA1FD0C9E01DE2D3A5BF3F85510E1E9D17A3357310B24725DFF3
      09E5674EB1CC7A311DC40C96EA6332B93C550C0A19327524858F8CB552BAEFA0
      30DD97E6E40ED520F2FD1210B99EBBF387F10798C0F1F9FB2B26FEBB73FE0A8C
      4FD5D0019E5484872944CAE862C0232C978D1C0DB88A302B7B69930A7D310441
      1C039452950DFF570780F6BF15462AAEA9CAE89CE87AE361300932DD4A409691
      25BC55F103A01673CC00A56AC424E58B7041D6C35930FB0179C69C22207EC6C6
      1C2505DB93001851F9C19FF466C9081B6CBF01056277CEC2A993AF9D965E2909
      9D92B697127FA1A112CA6AAD7214A4F629F51207B58C0C3107BA96FEA1A4FB98
      9743F96411C041A4B6F5F142A667FB6B677ABE8E919EFC8BE8D2966D8EEA67E8
      1C800A4CB597A36CDB5246B136D9964D69E70A8ABCC16AE16CF5CAB00C3DB156
      E27F916A121600933CF80BF1CF8100B23590B19EB21403C99379CB0EB340430A
      F46F0ED241961728A1BA0AA6958DA379769ED35E5CBF56A6CDDD413E6DD795E5
      5AB56D171103218242E8B222B90746712DFCEE44A4215663029E1A684D106B7C
      48438B2F0B588A85B1B556A62EA0C4CB3DF0525DF25156EA2763E8FE9EEF54C8
      4A52C1E4B22C37AC50A60E178AE71AEB88FCD3A97A90A2362E1E1E1E1CCA563B
      712E1E7C123FC3C0AC0CABEAE6DEF031F1B1AC8A16C9B56EAA4ADDCEA6F8D16B
      D49C0A02B0A2A77E50AD52F5FD73D64DEBD54E534F5BDF73795195B75D5C5E5E
      1EAA75CAE60754DC3E0B268532967A4FF2045B38F7FD8C2BDA72657B3622E9D7
      A0059EBE959D0970A2EACB23B9B1490AA425180559AAE42659A61E09D1DB7737
      941416061C5CE3530EE3001379274124CC57FBD17C02EFD0BB6A941945AB3992
      272EDF45B638EE91C061362481A14E9263DD302FCDCF395A9329307A9CC201D2
      3814EC30BC56D771A0A09FC879D7C3E4CAABF32355C999D24CFD7C85815988FF
      0834A0FF45D0D788043A16791AF2D4D45C9D5A82A62606AB3A7325AE3EACC83F
      D549D01B28AC7F358A00FC30938D78E71138BA72B2422F3A5C8453781C311D0C
      E7A06C277A3795CEBA4028D60E81F7A9980DE25521F0C4EC9E2204706D065216
      00C247504204115FA757AE0015497DB0A043CA0FA359921BC8907820B3168904
      99682731DB2464BBCED6F39659BBC7DD8DB59BC5DA8D264554FA5B9D550C30DF
      4005702CA2B9F9FE7EB20B928CA85877F1DBE361DC6AFE410DFEA8D419B3343A
      E04806707583BC11DA89F341B74A22CFBB6C4625315CE51190DC62CA2C2CE411
      01BB266E3CBF0E1EB06D2FC38DBF6657BEEEA1946ACA45B98D9ADD3D3E58F8B6
      DC10C919D352F09AC601F57142D5269A6317C2BC0C8AEAFB878E30AE411FC6F1
      2D4A414BE6886F9CCCFA637627A099BECF058F0B5522C8DD27AB4CA8F9BE8227
      D1FF8575927D988C3FA1AE71300E15CEE1C8B094A194C8BAF843146FB2B1AA15
      656E01437800F3D39D9B61655C9BEF634436D38AEA5544EB5E68D7B3F384F943
      DEA4EBD5DC39F3C977B23BB4B9B87CB3BF84D4355838A6720403D9D1972FD1F9
      E4F00B2E56C01235551735DA942542C6E4B03C7FF6E14C9B44B9C5389630C016
      74B2C127C735EAE302F363333C8DCB323A7698A237C29870BCD9DB8511368980
      E31C522E2A8AFF88F091D300DDC66C94A234C8984E56816E653E51B8FC590F54
      012C265408CF9187DBC11224EC2FA47968382E0091972F5BA760A0279D58F9E2
      23FC64066ED30A350D4E9DCFEE8FD4688BF957FC4E1547DAFD0D25B1EEEF44BD
      68ED526B36D52E0E36E50DF655634B62D51967FE0E81A4008F9E65A8AEF566DC
      8C46D12819B9AA3465454BA9659F2AD8C928545842B40CBE26362965DA10D54F
      00D47C0B0292E2943829C2E8F5060357B061AB5A399D6B51616C05757BE6879C
      81C303512F58E45B945926E7AB6938ECF3E3E9C940A232058B1A9F6D54C53A87
      57D2AA36A162FDC5AC2F3F0852DCCF948E4B5F1EB7CDADE7351C93F58B387FC1
      8CF517D23E6160182C36B78B335E537713BCA82496CDAD150DDF9B5B2B2DC43C
      4D927C2B8A97206DDDDF5BFBF2CEBEEBFE8647AAFBFB26D6468755CA69142663
      6EE66ECB326F60C2C131F2416E29AA361A09A5B222016F2CE529BB23F6202197
      7D3675D8304127EF7056CE790733B22BC9F40C69921509DEC0F16E13DC07AEA1
      815B91E6363D8E7E208B75DE9A5C472F9FBDFF886E6361D446305A7B1A5A038A
      4258711B0DBF340D34001B26DA9D3D01A786248940973226489D356F77319D97
      2FC56E53D82661500B3E7E1E76A744744306720A23491F813636AA31E4D9304B
      2AFA91960197D4F9DA7994BDA27AF4004BDD32846A02C70331C53F76CE5AF886
      8FACF4CFA854386D5162F33389FCD2CB8673C5566BB9CDE7F4EDF5957380E69D
      DE1C9418A0CDA8562620F8632C33DCBFBFC75165445B653240AAABEDE90EE47A
      130ED083C74508B37BC181993C5CAA6CE730117A19DB5A0EF14450E498F35EB5
      B8BE83BB5510293BA4C6208B52794A8A6A83C599FD81B8EC23EBA30644D8F01E
      0C50C0E3768CD245478BD63396FE50A9A614BF83F7EFEFF109057624EF29BACA
      8C6A1BE83DA5F0F0F211596E5695A0E856DD0A4C15C396B904B2A65D3FF453BC
      0D9B59F3F6192A56AA7A58A7B205A98A94D78DA5D1EA162A154E4E2265CD9AEA
      54D1225E985DC583884316C8F5A7D23569114A9333A093C3E6DDF58E2758EEEF
      5DD3FEA81DDB1D3A74435DA9D0BE60C4B43C425B878A788E7CB42E51E773C622
      1BA2B710A2D7F9DA217ADF3377D0FB762C290D6EB0B48F5304068944D888767F
      0F288A2EC88906110A213E42C7AA48B0655B947B422938809AD9ABAA1ECAE340
      75C94FB60C1DF6F77E7C737A8E1A10F6870A18A3B3F95448F090513649FC798E
      E91A606488150FD88E1A7B9BDDCE9360C21AA68FEE234EB764B31C435A9AE794
      592D67668A6D383EDA98B220A2D086FCB45184070665C7D2C6586014DB024B19
      FB89DC7B096A3D06025A32097DD65F21E744BE6D03152D48F6B8E7327E720B83
      949924AE7DDB3605C877E24729A02499A257DB9905F494275B1E612517505003
      97881D71EA422A404BBF8413F3AE170677D4885839256B2C93A83FA9EC9AF323
      B00B8E782ACC04DE2942E022465AE004B3EF06DC3812E3D8788A2CA13D7605F2
      248C031961EABFEC5E4CE5A9E08485334A1E8EE66AEF0CF838070A2632AF828D
      F94500FD5BA2EFA1724FE5DF71D308F41484F3C778BE03F2CF22C3349C4D068A
      A20AA2456718DE730E48AA3E765E839E1F39578786050B900934DD24E1946C6E
      79BD76EB737F7A2C35C1EFFE4BCDECAF1B89C2220171DDF37FE29C9F56EA2C55
      650F8A63C3C29F3DEF59366C6F24ACC6CFF18B2DA527587252B7B34826744259
      F8EAA114C6C1EA14F321B14D100D54677751F4A154B647882DA91ED0DE8F3797
      6D126B12491854E86971748A9859B453E4E3CAAA0469CE78D83F8EA3B3271368
      320B3A7ABDF70B1D618B912F8F050F5A09990DD0FA6FA6656BDB5244D1BC1C90
      3A45FBB5646B4821E93BF9F7DA7BB83C85B63FF1201275DF793DFDB5DCE21D52
      D10D79E700F9F5F505874FC7E180051F3379AE7004F8ACA00C358AF008597D7D
      415F7797D7B2FE03157618BF17F4419080479A5BB63D180381A4FC98C8F7B64D
      EE5F029405825B75CBA636F023EC794E73F3B66C6E221A855B3B3950F2B61772
      4374936FE9DC460204C4684BE7960871CB53AB6DD9D4C6B368E4278182DCB6D1
      11604161B0ADDBFA4F7FEA6F2F77008DE95E8CB61678D33827C2DB8675A8D9CD
      4633DEDA2D845D324B53BDB1EE964D0E04CDEDE560E9BD186CEDE4B25972AB27
      57DF31EDEEFAC2EA71CFD2E396C739FD817ADC52B97A47D057397EEA053750AB
      6971FA5938BDDCE6F687E2F41F8FCE5B69743C27F723155293366B8CF2D2E84C
      093E5CC28DACB4BB73FAAF1E25BD52A1BBB1E12DA3E835EEE0AB017680899B70
      49B9C938B34DA535E9C0353C348EDF83BB0E31ED89EAB6CE55DC6D01E2CE818C
      ED4D9DCA4772B815BEFEAEB22CDD09BD0614567E6844E5B1F743D726433F0816
      FE332216D10DC2311D8FA7A1DC7F5311B12FD9E79AB2D85A0141800E90B53B1D
      7EEE4F958FE6974D381E52D1E79C45595C9CEAC061FAAFAAA32B6BBA04BA64DB
      27303FC7EEECA1E336E1A7DBAE79F0CB6BD5DBF0ABD66CD6E157BDD1AEC2AF46
      BD83B734EB2EDED2AA79784BDBABD7F969BC058E508B86A9763A7893EB76AA78
      97EBC17DF8BBD6AAD37DF566A3B9D923B50E07A3B999129A52B4F80BFA1EE5A5
      5B2CEB18477F69C27FBB426D30303FAFB74CC16CCE04A68338B9FE1A041B74F4
      C2D40323F4FD80CB37AD3FD004916313DEF5E8457624636780DE2246709D6F1F
      73294D5A6A6C57EEECA5AADC5C45097DC120DEF5850C32307CE0408307220930
      6180D881621D3BEFFF3C974C520164574EBFAA9EA63A0ACA90032533C095CA05
      D3C98A73001F2BC4ABB56642C5E673816D48814F661C84C6545DE17D32A1704F
      2C4AB1A1189EF0BBFF52532A0F83D9FFE26EEF27B2F836572649B3C0ACF72D53
      4BE918A7F74146A5C4CD580F239A82EBF653C89F51628C22A540519B4C09FC23
      51CC2AD14F6B716EFD14EEBF30FCE4AF27209B6F2698EE289F7CA0020F9C5B31
      27DCCAE320555DA9F4D13D14818801C31C28B3F3D4EB5130CFAE912FA32985D9
      9262693A16E9988B0053F5CD54A1F19CA6A5F21C734DC3041B054F14E9D2A93E
      B27A6FA16CA9C9B18730252CE6BFFCE5A8D1CC2259A25C05E2503750A6C61C43
      7640E6CCCB77751916FCAED55437E05A29144C1E8E8CAA2C8887BE002222E5DC
      9343633E056070601947B93E0EB4A4BC34EAEC2C0BA5E0FA482BD339C8944146
      F15F3271EC5B8BFFCAF5CECD15F53BC935904D14DD90F973278E38199DAC7DF2
      1C27F50F290A6C76295C6785304CC669AA4299BE83A72E142C3D68F41B883448
      0C615817F75A7ED0EF65EB8C20355971C6E84D1234233146C6FBD8533C0EFA14
      D9F80485621BE2D6012964E18E44C8AA4BDA689483C5A8A19AC759F765AFF32F
      23783BCB8697658DEC0E275EB2FA628EB1995EBCE45C22095E1E764C692A8C8E
      D3241E25FE4496CF389001E94F9385D72B097FB92281668B4232C4D7D386BE7C
      D70F89CC72BCBAACCDCCCCE228DF78323863D98705479551A92025A480FB709B
      D134CD9526B003E399D9C6480F61B65E2CA548B26691CA974F196D842CA7B208
      8DA05CA0089E0214D081D7AF3731492EFA0016887A661EC0033C4EA88D1B694A
      8F93E597F813B265A96F922F8CC2B847C2B5211F1E205CA7491027D420EB4E24
      255AEEA1C1433690B7B3E17C9D0D3411C7642382F653A7FE34C4D11697FDBDC8
      282BF76F9481B40E9BC71F9981B401445A9292B50E70E71949481A5083BD4731
      46150CA7A678479B3B189B38C8E858A57A9B499E9059A08448EB5465CAA22A8C
      65A1A81E8C4CF40469054B74CE4DF5F81B531B3FA3C8F3428FD815097A563F09
      7A9A430F374013379CC5ABD5E375FBB5CE137F1447BD388936B96179796D4AA3
      CE02D07EE64745A1E0933C9C6BF216CD3BE42B528C9944A7F5F384E9770FF0DF
      46183336EA6356266311184DB99DDFC1E3AE2F87C50AC2EBA7C6B8D24D2C54CA
      60EB9EEEE6185F345FF4C932033CDAD421C498AAF59F39434721421962D9472A
      F05C57CD58C85F8EBA6E28B86A5D353DFA8C216E516D7CD261AA766AD5F5CB57
      3B6FBF791DEB2E89BB62B6B959D622D289F6F7849F94D473A4182FAC3A880E4D
      B3B2294805D28A4ECAE4D28A843696E9F9648E23F11478BF7364E686042C7F3B
      2AD4DFD075F4BEE32A1B8FCA6C149E5D223D140770F301CEE649108641BF3802
      154978F464B351ADBACEC1C79BCBE3F6E1AE1CB09FD0A3B87E2EB0E96A37E833
      502D07F489565BF9A8DA3D50047BAE9F1FA358AD7E57ADFEE2BCCABBBE63397B
      917CE7FC2C1D70F2A89F5CDF7CB87AFBFDF52FF2BCAD7A3A77E3B42D2AE1EBD8
      9B4D6A75789CB03E0BF91E8F1CAA3DAA2AA072799A38CB1339EC01FBF203966B
      E9DA955D72929C03F229A93D3FDC65EEA58B9EA1A5DFDF80DEB6D1C3C57E240A
      6E0CE87439AAA01D17C1CB8BD3592EB6362E565FCEC50C2B994827BF38976896
      91C5E00FA83AFC77A79DCB76EDD5E5A53A624F19EE4B8EF053C6BF26A7B3ECFC
      B0438DBE1E5381F5D300346BFC37FCB77EB3461E830CE79C98AB6121B404E10F
      2108AEB7FC849D4DDFC9E37923D20C4ED9B4E41413A5F881DB769FE7DBF715F9
      F256B683789D77B11EFBD120DC2122C5CD4AC2C700C8DBE325E23E09B20C3B30
      E40DCA08BD00A17C8CD54753952E0E89AD03B8BBFA24A0C69C4813F2A6006649
      5FEE53CCE1B78F0B392AC3EAB521D41FD1CD3717D7758CE955A57EDFFE68AE60
      315B87BC189CAE490D7B64D15E18A4F1F2FAFA428605D7F3702839CCFA8359A7
      E10C169C9E640FAB85BA3CCDD5912F4B6571E946F12A1434886067003246C36A
      A6EDC6CC0E752319090884F8E307D9CB1D0A2CD0AE20BD6E78EDEFE13468162B
      C3EC4B4CF7B2EA85C2842355BB583978D7EEAE05B96803223BCC7E0305A2451A
      AE7FAE3A60BC500A36C380002E008BE442F7917FC31DD35391C984036EE00938
      3809B85D8BE1B034A3130A54E14B6A3A3C73A3B990838F0FE8DA0E54ED01AE38
      EEC9969476A83DB7B4C373A164F44ADD005DDCB26DF7E4B6AF19881FA979EC63
      10AE27A8E918E9E31A6AA2E02B57061FDEBC003FB8E4D41880EF862013047EE8
      9CBF3EC3F30FA30CD05FA60EFCB149D2B70C07EA9BC1017590FEF1E3870D2202
      D9D47FFC5028AF53777EFCB025E8D160D89E5170591C3967E1AC2719FA06B064
      132B68F20A14DFC39412B3D5EAD79E5EEB4416358C8ECBA6F86FAF365D0D9DC1
      6C7F8F5CB546975743ACA6C420C631B3FD05079F4BE31D4AD62CA963DF3C2A62
      4255A8A8371EB6554BB33C6C52F5C708B1BDE9DC7433B2EC933F66F4DAE0D760
      B371D912829ABBE1484B364F56C79FCEA8A9364C8EA2568348B655C2FB7B8006
      B73BDF3E123BCAC896893A4EDF19002F8A772A7369BC64F984D3EA181CE8F408
      791FC6FA16F5484CF827FB30A5ADFB0926EEABEF645F539F4B32F169488F9C4A
      3F9ECE514738393921ECACB00122980421401E7B4C10E54F0F731B8661B9D0E6
      0C85C657BAA130675AF8BA4FAA3C9CF2CCCCE3996C3DB470DE7862C5B24DA8D5
      F4E3703689182464897B47E4E0601468DD864C2530949F626758692C99C62975
      17525A0D5191C323AD08E1A7D7AC121D0C8BAA2BDC45C62CF926EE6969029C8B
      F583C23BB93AC73699C3E0C15498542735B505327A12C8032C117B1F338422AA
      2125039A29DE69A1B3EC1BF93CA9D04A499380E2FE4B1408415FAFA65D0E04EE
      DFE049266C381BB7E258E63C6D46E10600BDC838F953F46F2936DE302AE468AF
      00CA2456116FF990FE9612ACB0F9A74C6EA3EFC936B6886DAAC61841F0E7935F
      742750E0423FFFF72FBAF0CDFF00D29286AD2AA2617F7AD59B9C82D60718D80F
      AA35F5A35B98901AE53C9EE1F36730AF5BE453675912FEE922A27C189C32CF93
      BAD4659A2AE4AC882A8D15CA0CF4C358E63832DDE075BCFB9B7A21F94E34F5A8
      9C2D9E78E07B02C0041A8F8EBEE3B6A5EA9092CD705E4874CE93D4B93B329C31
      D01EE050BDD4C7493625E402715816CE3428AC3027EA702E5BCFE6A491FADD4E
      0406F1FEB1DDACB69279BE23170440FEC5B58610D223DD14D819C7DC18FEECE6
      C36B82F580D1AF8FE8F7627718EC29A160CC31F95F08AD9C0552A5BC1347966C
      224A34F4C334476FB676A2D4CA6F64C671C403ABDA6663110EE00DF7CCAD0A74
      81491BF6429A66B937F08DCC8581DFCEF74088A76CB33F805903819E87E25016
      2DD0CBC3D0D8AF569C666B8EC9E50CE924F20265623F198D63D8849D6B4E2ED7
      9D47582A3331B61F9B7312CB81ACDA22059E199017C22AEECC45F5B6B8DBE05C
      F5F11EFB527491C36BEEA0C5C221F200EA7526C7A27A99C66CB823EB91390A5D
      C6C0B451141BC4FE8267278F04F160E67BFCF0C7ABDC55836CFD93F3DAD91371
      5690E1636AD3095485884ABA7BC7225F3AAAF5CE10CEC42C9135D434D1078CE3
      347E59F33646BD2398C8D23D78DB2826D72E1E252704BD08111DAF980AC81464
      CE5C4B80D7C1DD24486571A613DBC700AB5491FCE2A61CE53A5C3467B98A674B
      F50BEE0556A14A6572041736E69DC683819D9F47ACD071377B99347A442A086B
      232815473E553BD0EFD6497FFA12C349F611CCF0A50C1A82585F24E4213D40CB
      C83D76FE8946873A0A8A64635FF57F954AD15866F2F744DFD7153BA8AE9DD2A2
      2498522443F12CCAB4A79B520FC7FEFE5E44351CD8A47378E2BC9AE3A8B428D9
      8839354621F215C5B48B2079C3EA409C0EA628040754C161087C38037937939C
      94D557395D55AB100554ECF44CCC5FEA9A7728F492477FCC292DB3E912F8512A
      24F57C1CABAA7C125279A93EA9C2C6702C0214F2A40D8B21978F09FA060C280B
      6D927AE387FB7B7A0D299367197E90C6213AF331E712C30D640D0C7C6C710D63
      9D9D99E32029284455516D9D4C3380A17F178C18A5B4AACF352F30EC71CE4680
      CA2529BDA44DE0D37A6E951343569219BF64C3C0E7A63120ACC67734EB21BA83
      1E446522236619B22434420007024AF402310C00B0BF07B7CA39E73D28B56295
      C387508E6082D7F175B41C8AAE0074365E4A93676047589788F6EB538BA3133E
      F16FD18E993161107E2ADB82E32A88EE2D44091CF1C114CA88836AA5DCAC2C56
      7B48DB9CBF8B25C121E209ACCF1FE1F9DBDFE3716805F926C2188473742C9088
      2CECFCCE27E1BD35C0E55C2F58E5768729FEA4ACE1BD3C6C8E8C2D1416A4F8CA
      91D4EE4B01A65375E469C8AFD27150A64669188FB439387D3C12A238F2D949CC
      D57C28DC46B13FD3F496BF439773CA2D91474E1A936D0369F020C0D28C7064C4
      C35455FB0CA24100DC1305DFC2A991D6CA20E10A3F51969A96212ADA20298161
      C5C307C91501E73EC060AF80445F955DA1DF60D0F33990F9099B7A397243D998
      88284A0313D2CB3B1F40D70B6DEDE48B08C1F0F23C48C93687F0FA2088A0EA0D
      DC95730BE8CFCC3F2F41258B99FD48D8A8D012CF111B2708B707127458108C80
      9943EEC8142C41389E45DAB6004C48E1258A10F96991518CF70519F6918783F9
      D4CE63EF99AADDB273C84A8E2FE9E1C9EEA9313961A3945B0CB52C92CA7DA1A4
      2DFA621DAE7F937B073CEDFC2D7890C532495557788E8CCA6095B3E2DB4F4E4E
      2A39D607AA8A787EC08EF08D48976908B2E7BF4169747F6F5CF662383C7D143A
      254F64C33FBF76819DC28B5229E6CA705F65150FE78BCE013E77D8A38442FAA2
      E2E9BBA05625852AFEA049A0F93E6581368CE35B3ACA99412FFC1E0BD6703104
      16963935A980A45A353B908AC99F10F64ACB3B3C91358D2280C32229E23A286A
      41778F0893FFE94D3832B4314A9B409F914F9E76546C167742565B5DA48041BA
      B00B7A8F693B082B58D7510EEA470249287706899FF64A910A1CA327A537CBA8
      D2CDFE1E2B740A7052D691BD68785AB873ACC329D1841D41799D1839B40C0EEF
      5121B58C61883E5703694E9C53D2C0503B089289426CE5BCD1C852C4345A754F
      68E54389430B08A4EFE35E383B4FBD17C0B353A4FB116EE07949F3164F46180F
      E12ED2F91C6BC523E1F72DABDAA6BB9C9B1299C7FA2A4A45929D683541DE3889
      D1B0015321B7CD7DF48814007D3A9BC1FEA470C3C7A9F312FF4AC9F182BAC9D9
      87B38577A27AAEEBAC19635D8F8361F6279E852AD7EE6746A890A2CAC41748BF
      973707430E4E1ACA7805493DE8D5C1B06C9813B2F114BDC0E837FE70A6E62BFD
      F985599ED335C3006F8645D11B8BDE2C695351E5D6742814BE464E38EF9D2583
      A1E464C89F35A1EC957C7929BF05608065ECEE0369D4CB976704A87308FABD8F
      0D6858C189B48DF4C287610BD9BF5CC2095F837EE62F0A455F0CE5FBF76A2F58
      FFDAED050DC7F4B1736AF0C6B7EF6E74989CD63FD0B2293DA272EF75F48E262F
      EC0FA55A5E275BB6DF371C6875ECA83C42CDE655E4A2C4DE82A97BDB56711DCF
      923EF6853ECDEDCFD244BFB00C9655B5953E37EB176B38CAB028DE38694B26B3
      B8BFBF676084810D12905C29D628C34C2F97F3537359641CDB024658758FD77A
      8C34D7849B8E213D2AA23695DED84ACCBE22C7ABF3FA1D2F063DAA72BB0CFE60
      F2001D8D957B67272A05302FAEFD680F8D30BFEC7E7F2FCE7B1929EC306289B8
      490045037EF725E9288B00F39E9883E02D867183CEF359BAEFD6EB5F4EF8E9E1
      55297F10DE95789969983F88019C720EDAF162E258A1EE65EEA79FA097344115
      1314A93CEA6F2BB6757F0FF0F515866AC37250CF43855CF46785C8DB7BEDC3A2
      D0378CBA0141859E02E92D9AEBE03D1DE449C1DF8BA74656AFF7F307E439EA3D
      1E697F6FA84CCD4BC7923EB8B2A16EC6A67D24553E481E0A3915ED1A763C8111
      386B74B7341B922D15CFCEE2D1485A17C8642035EA09312B2D72C35AFA82847E
      2CC88C715CECB7E45B357B9CC4B33C52EC95DCF2A267B8C7812D03AA0DA13676
      14DC51110C0C342DD2CC589B2EC8B680FE46C646F43988C44AC88B74B2F1F525
      E4F7052BD55B69A592A9BA5AEFD47A1F7BDE65273EAA8FBDA0426B079AF19D1C
      E4601244B3348F7E3ADC36418340705608AE8899F24891412E042DC318294C7E
      3F5AA8B2A485C1B4172352E5864192507A1C70238CD49BB7542D61106439A3D9
      0192B6D420F8D8B24781E347CB2C9ECAEA6784CA3FB27A969977D8798A232147
      E12D3A8127476CDC1FEA6E58B9A7481B39890E6AE728AD4279458DF1D16CBFE8
      F1AB2C1874D1B053089CC7DD18512A86327546E21EA327C81EA20727AB43E141
      4E83D1490ABB6DFF5CD8C89DF15DC1BAF7F70A2B27FC5F287751E867E06BF3DA
      E3667F39180D0F4D2A39BC6A786878177C8A65CA4D7A1A5D650E87E9E7E1CC28
      2E93CC255D541B05951515513FBBB108B546FD0EE3A416F7564544DE89F2C5F1
      3DDCE3828C39EAF0B1606A643549DF1E590596BF6910937ED0131C6C8906D932
      23A4EC5C2B837E0556CBC9E3947DAACD5F50B277F6BC5EC850CF1D74369FA61C
      B5EBA7B93B13CF507E76D0248F010F4E85C2594B5CC00BB5878BC116C3329FAF
      9123C99E6B7696186C6CD1BF28CD2C88E86931192CB71E29B186CEE22243F729
      4E48E759E926318580C09D3F11E42AB147E2B347825D4A06E2ACF35414BC89F9
      4150CC447BE32395429CCB94CBD8201B0BC931F615F33DB606C5A9A28DF2355A
      EC5E86DD5CF487FC9D80C19B427233CCE4111758D4B83EA7639981F970AFEC4C
      17C5ECB44D74B2B8196C025F15B5291E75D9D9D38BD53331C261D55C4ADE81D3
      33CFE5E763978AB3EA8FE398C6656DB110873BA39D62378A7A3D79B4B59AA71D
      DA2A9FDA4C6FB2C95FD83B2F51A82606BB430F90C92CAEBE7886517B9A53018B
      3C94250F38C8950F8DBDCAD94B2589D75B82EAD14C0F1E0E3751EB72D7CFC329
      CC0C6B1014A15DD99D63514C8E2F0107873A4D6015C1711E6D9BB722FBF9E117
      75183E9D29DF3871CE64DC12079D0F388037A30149C9277FAF934E30A633E1E1
      BD42E988F269902EA4EB6DE747B7109451120CCCD1BF8F166E72FF120BE291CE
      F62BA869EAA5E45FC34572C32A23EAD5EF15D7C545AB6498E8E3F584C12460BE
      9B07992D9931DABF397D129D57DACC7917F84BA4964F00849A6EB25772E7A9C4
      075DBA998B26FD4C38380DC52FB92A926FF90E518F1B3E35D3F95238E4A7E740
      E72B7D4A7A2E04831F2EA99C6D9851543F51CAE9549E232253F08225C702244D
      71E25CE160D92CE1CAFBDC8F144D9AA92EB6ADED29F0F241E28F74EF77A64BBA
      B8B50C1F77FA981C23ED3014EE4857D242144C02EF299C7CA51AB05240399D54
      7827AF7A334D6200D6C4B0262B58E6AE2B26DD0C7E85909FDE87C5C04F8282D4
      A9A722412B3165B57E624729FFDD283242615D0482A94387561712521B2D1503
      9510876E397E15DBA0495350B5C62CA5118A19CADF2912694A8BDE15AAC2D504
      542804AE9C7CE054E16CDD7D3F8E39A352827AFDA5CD30DF1A3D2678CC0AD203
      BD97ABF5CB972BD4FF41D621E25073728F9F8632D85CA7C7CB8A0BCCDDD182A0
      92EA528A3B098685A10D972ABD5793D148D90DFA7E2A956A33B19E1F56B558B8
      E426260473ACBD2A1EA06FF41339BEA487011AE108CF6410DFCE9FEE53AAADC6
      79C7D295BD2BA79A53EBFBF164C241BE1199B2803B5215BEBC4C85B4DF8C7DC9
      98F22C6DE9FAC7A0E3420508C2CF03A36E9FBC31A0C46F3199C6B0B4795E7BE8
      DE6727D82C0229599E248C2BC5527A03AEB2C0F12563F6E81ECADC0AACF6A184
      018C80C6041701423B305F7F3A55C55F358EAFD920704CB8734EC0B80668AD9D
      56EDEFB10D8D02297C72A846C7B12A0E7EA03FFD857B8E70DEDF91A3AF0FC27E
      7AE49C9DA58785D048AC6ACD41734B80D5253CD834A8BEF3B18AF7510F5B301C
      F5B1CDCF262A7AE7C0D365460A114C2B80834333297B6AE2CF0181FBE10C6BC1
      28102F584B77968C56AED1CFFF31A2F820E78720CA2A7068A7A1DF17692E4257
      C89881085091F68DDDA1B564505806262474D2282EE5F377B210C0414C697372
      5D87EC75E3200A196C8A417933391ABC936A2E81B0A2AC346ED5C160C38CB24B
      7B48BC61C431BC35171ED8A5308B06327AF9077FD29B255884E90DE552AB9C5A
      22B1F24D32BC06CB7FC06A381804E33A729621EF54C7E24C45DF52B671A0A250
      744982598AD53DA878DC625182A543FCFCDFBF2858D168D8C607B32388C770BE
      92DB90F9D4A9E42A701D0D5C70B461A75182A7B045F6A7E05CA238FE97D04F6B
      C0EDFCC926F507DD356CF25211F58EE0EA8D044A3CD1BB73924F31B8B1009483
      5770E80E15242AF2002FA6741E0C0CB36B96CC848EFC2D2D502AE52655344B06
      1C4FCA37E34045DC724D348C745785B0307102A7B9F318AD42AE002005DBCFAE
      60705EDA767FAF7FBBD40C46763842423F13EC760BA26362E714AC1D73EFB42B
      AC6088D5D8A55C94CA3CC3C323E712E4AE4C36B1232C0D44389075D1B054010F
      9A8FC51596A8EE291C04ECF76814F0BD36ACF9CBE6C183B34522C4BC456790C4
      53CE3B470646450EA731D57E044623F3D70E0459F249F9E7799B75F5C7B311D6
      E33CD0663C4ABBA19126FE280A3258EF21FA02064649C1DD3D534C8054A41B82
      73578E139BDC970000E437AAC981325CA19C74B0AC0214D91413D69E119B0FE5
      19C4F2BAA9C315E9B16535D72E202DAD9708FF565677E272A429E7AF5CB2A5D8
      87F5A897A1657FE7B1F4146B60CAB270BB839EA744CB9054B19510AD30AA18A8
      2A0ECB30319D11FD71200C11BEC2B05B28AE79A62AB3BE8E012DD38AE920E20E
      0CE8BCFEE4A329F73861ED6550ACD5FA733F53B7E10BD25FD4D3F2CBAB0152F4
      BE1FDEC46FC8F8F11380433D71E4E44FE375F36F1ECD0C76AC15A6B9BF9750A4
      19B9C2820CBD3EA6C346A939942F3050B6F0E210388073A0DD35AC33A11DE2D0
      70FE9CC8B4027679153C5D99596B563F70E4C872E0648E23B3C6C22B482D5411
      579959FA50E6B34A235AC68523590B447C08CCFA57FB7B58B4961AACD2C6984F
      C1D1EEC713A1CB4244F1A0908B50AC62624E81D93FEB5B58FF5D1BF1E418BAA9
      AD1CEE1EF45C2C4222C58B3C91BDE8ECCA4BFBAA1BB8C0AC5C0E15964CFCDCD2
      AF4F82B128D9C4FDC41127A31336EDEFEF193573E56D14B71D0A3FA23ACD9CF9
      1663515A7C186D9A18304148400B186A9CA7CAAE5C595DEE9F203FDB4211291A
      3B3F75B2D17ABE5D72A38ECA8204F09ECA1013F6C3E05FE8643D900D48F5C164
      C0FAF343550E175EA80208C9C438C81D8572D4FD3DD839555E2CC69046385CF9
      56EB0A55BC2A2CC26D42F6DE37A6AD52BBF23E442A510406E9939B0228E5AC9F
      CD12ACA72B4D1A0714F9202B0FA387D528DDE54B8B705E574CBE371113A06CE9
      226EFBBC63544191CC1E6916C7C4A3A98EE90CE9980AB2706EB8A8F4FE1EE228
      A6EBCD522A78E66B2B8A8A4D8B8C6CF265FB221E289D93A5582AF146C66F736B
      49E72BEC7CC56458847B6712F7C86C241E30F31DC16A5487641313934302F76B
      010CA4C2A0AFFC7D8602C8B54980D911CF74A3E01053F1402699ACBC9A3BAFFC
      547CA00DA8C8AA68641FEDC50F6A37650C804A8C322268D88BC87D0C384A004B
      C2EA3B0EFEE29070CFB9EECED9C5EBD7B833589F7C88B4A0AF6E3D5C38210BF3
      C88BC91D397F3A728E79F5FFE9DC8A79BA58355CBAEC00701CBF7E1A869523FD
      D75B38A40A7857D11DCA5E3A24B75268A8C0A560F383A6E9B23C4C92FF29E39E
      CA2951274255FF34CE9564895C3B4055F69471BBD431D85729A4BE59064F6F82
      CE0FA54C5DBA519A0F53A14757EF5DC8F124AF629ECF322D7829775680FC0044
      6A2C636638816FA76CD8C580798DE92AB5F0D32D195281629472BFF704C910E8
      D15203FAE1E3BE75BAF60C86A9CC8270407CE2D116E8F603E808D3CD1958F5A2
      29E5F59C5519A5946B790E2814AFA247AD90A75E754701623447979AF6F203C1
      86C58ED9E1A6038154408D59349E251DD3BD2463ACD298B9288726C166F66F81
      6C2303C045692B45C8E13E002436DE010D400629DFE9670B8D07DE316D5C061B
      BD4F04C023D95FDC84ACC160F4102F67513E9CA2CFF942D864BF28F056CC9828
      B6DBC709B9D647A009CB5E1714FEB96CA2B2EF534AB8432915435473B35964D4
      5B95FB070785FA9C510F0AAE9ACA2196BE830D54101741A41B2524D361709A8E
      15C7AF399A0B26802C286584BDBEBED879FAA64CA315293F606F4750D0307E8F
      DA3CFE40956277289AF2BD725DE60D4FD093CD920390023411827C4CD9A906C8
      0C9EAF8076E2BC92DD5454070D12516332F0BF39BDBE01AAD5D3074D875818F2
      B18C9EA671C95CF902711E9B31993583501A3E92322671F410633028CA0FCB99
      C4B34467F1CD22904A652E039E213AD328F80996C1B1A6122C24A28AFE877448
      A6229EAAA4F241ACBA4D81AAE8C35362AA246A18CD38B244BC508DC5A3C7014C
      BA956A314483D9472EC068E7A75614518F92D13A4A3B80B599B057958E99EEC8
      A63800734C89E7DB02CE5B9225F32AA7F01D0F907EBAB2F4A752CAF8A5FB7BC5
      D7D2068BC5375345A07496EBE2C2E87D2385E69456AAC55E5DA5580D1439BFCE
      609B54CF47BD185210565B8E96EBE3425C8FEE3EA4CA8698784D25E28FE43E51
      2924256816A30237113EC213A179E0EB37907B435A876A3803005FFB3AAEFE06
      E0FA090ECFD5E43C06186F2064E8C4798F9995825530C60B38AC3AB24B76CB11
      32E651F65E95F5AE232A77ADD5B341ECDCE2FEDEE30873D96F758013DF794E79
      35C1A65ED2EBCA04864C42699C700F2F326A4A6D5DB5B6DD1DBE691255920BB9
      09B5F425E66D658CFC569403B5B5F91AC09853B1A55665F316E780C82AD63C7E
      2C8B1F5634D1E516358A26527A0FEE91AEA6B7483E97BEB8700F9A2C3E482A4F
      1625322BC82F9FF066ACCB5B338CCC521D9771F9406A6169C3DCA883E79AAE51
      AA1507AE110F921203D5E1CF990ABCE94EFBA8A4212612429A687B398B469241
      F9BC2012A0D2C6E10439A79741C4770189FF9C80212D0987F26A881174D4C290
      7A0371A8C2CED30B5D8299ED73866048FEF15DCA5092493225705021300B398B
      A6B98F845B6D31655BF8C5F51B6A1ECF84F775DCF7C9002E0B47E67DD9395C20
      144543F7278A04EC2CC6BE27DBC70731747E7EFFFA7F3E7C57A5FFDCFA2F78AE
      9537202F4ADDFD0D6D22DDDF4FC4C30EC582E5403A9025B615980E9509CB5F02
      2CC4391360BA36A41133CF9E39A32EBF6C53063404E631E8C703558AD9A0DE87
      B9B1DE6C75681A7BB2C4978D4C3E28ED6280ED3917CD6974CA8A46A69D3D0B3F
      28809F0C7C55FB4DF2C95DC175D46F4BF52100C297694405C0AE3FD98B77CA88
      4B96B20D05D270287F21C75B3A63B8441D1E5E31E989C1A0686181F35A34549B
      A74B97EBC73BE165BE52E87347109E77CC5F09FD3E9B94D7AD66767FFB1E28CB
      5BA62E39845547849541FD44E5B9279681686769C64D30DD3922C1B170B472E9
      14CFD80CEF4FD842B4FC2C66A421A1AF51B59356B6BD893FA0635570E2E877E4
      0A8E346448E493E64692F3F041BCF9247BE06E164B8EB6C559B97B2ACBFC4C57
      708EA365C2F1AEE0334653EEEFFDE9EC136539640716029C32B0461C71CCD65D
      AC2AC61D32D4351D192023A716AA669F382AC5185E5C1C7D18A32114B9060B7E
      72C01AB66EA757EC3C06FFFCA348E6BF384BE25C76C8FA569EAF5F44226D14D6
      6DBBD66EF1FE1537027981EE8DBE8934D9631924635454D765FAE2BCDAF1D142
      84934EACA55AC4D4567E9477CC5D1EB79AF793E71825A9931D49EBDC11B97ED6
      0E46CC8B5806CA47D5179E2D321FEB08540A68E3D88DC7604B552612F7AE4C8D
      AA48E87A0F67237815F15C15046196642AF4533042970E6474643074CE6E3EBC
      46E17A2CC241B1D4C2E1AED338266E3F6332ED2F1C116849DBD7226DE4E259BF
      E2AA085A5E530D280DFC0A852E5A8FEBDDDF530D88A241EECC93DE26927435E1
      5B16C1FCB8849A0C96D5B1DD8F3A5D46E15C46437E8CB8D125FDA57ABD6B9392
      0CEBAF48DF484587EAE7EEFA4A5EC30867AAA259CBDE7DE22CA911B0963D4410
      6C6C1F531F3669919E92AB9E19CB91F3F1FCC391F2215DDDBCA9C0C27F9D51AC
      2B19E0A66C00AC51285DBAC8C26486A80E2460B4C1F02ACC5BE0882BDEB061C0
      FE9DCAAB77D7D72F5FBF7B77A3A389E1ED182F57082A569224131BF67971A070
      B1E6DE2C8950D81D3A956B0CE94714909B8A3E3911E938074ACCC380015D0450
      DB4D60D5AA564D3F1E4568B83FE4B426019274E5CA41B7B9837E73E7EAC5C421
      D7B90C5BC697A8D8109551082C38C1651DE6517F18D68DB0E4A8408E766789E1
      FF67EFDDBBDAC8B2B3F1FF598BEF50A3BCEB35A465ACFBC593491606EC26ED5B
      00774F7EED5EEF3A55750A6A90549A2A094C27F3DD7FFBD97B9F532501B63B8D
      DBE5C0ACC40D482A9DEBBEEFE7714BB06F2E67A74B98DF40A660505F6FC417D9
      12248B693E4309CB24666A29A143F0193625E8C2DB4F95124AB31433B4E4D34F
      C55272F18F5044945B135F552B27BB3B9D9DB63258F9D2B42AD4DF09EAF43EB8
      E4073DAC5922A56079907473ECD7152B665AADC0AE64E45C3B886B312E59D7AF
      AB17C7C89DE59164700B5BB61CBB04629C5EA4F1D21D4A4632AB00C048BB0740
      E3B8B444EF4078B5706D1FABFD2E74945723D96597427590722C7DBD10AD5CBC
      8C2C832F252C8804FD98C110CADA456CC7D4CC90C12415714656DF16CAF3D328
      5DA808BC52141B976EADBC5C0165A38BAB82D7DDDD87E6EAFDDC9C3E9A3DDA47
      FF2DEDFBE559B692F8B8970DD79B1B8737F458BB42DCF532E75B43092B6B89D2
      B82A16E299E450B7AA56B6E43949186D3BFC6F1787E050DB8C2B90EFFD897D05
      02407827F982141F5B1F8D7F5F4EE724701B3736C77F2BC7F6F7E25D2B493B5A
      96BF043A537613EE801E6315B2C879967BE1F8271E729202DE662E487D1564E7
      554AD1BE95B3F9FB45EA73BAA72707C7FD27C7C7070233F1A6D7443B85612FC9
      C6A78EF80B3FA261FEBCF0B1FF4AEB07D9DA6407386A2AB2C700FDEA62B21C0A
      F1CF54CBB58A23EB730D33DD8D26302C1C4A53F9D58096E66E87D87E288BB605
      A0051460CE5CD909B68E5C17C435835A2C2D58DCC828D11A90D9BDB31DEC4A2C
      66EF07AE99616560C294FB278AB365924CD82A248BD0759A55C97FD7A061D706
      ACB3B9547A695A3DB4E4C2EC951AD16A0DF6CAC70B57822EBDBE64D327E43070
      FF453A43C3A8D42BCF2ADEC0EBDD1F5F8927C0B7BC74F4637232D1CE7D8A5208
      2E5A25230F73DADC5035293DE8E46924B0CBC10C206DB430767D6DF9CD072662
      58E2B490BE14F4F7A5912E876E7BE194343A15632FB6E89DB4955146AB4926EB
      42887B9DB95B79874CD00DE2E87AF74A9911D38B2CD5B85C444F9758AA9856DA
      9BF854BB035716CFDFDC35256C9E8C3B41433F593DCB3C515EF8AD90AC81B252
      7FB1FE3E3A59DC324BFFADDCA7CA32C98DDBC657FE0D12DB7730F81E707D5FA5
      74BD19408408AE394F4A6158EEBD6C7FEB72A667CB05A3D868C08BF7275FCEEF
      554AF927476EAF41625C06F55A3D6A44AAF7541972F009A087960DB3BC9ECDCA
      1FD1C022CF132CD19237A7822E07086D9E37FA49661CDD77BEA6DF0A4DDEC973
      3DB18E7EDF4A3D97D209F371C7BBDEFC8060D062BD95B258EFFF9F098122BD6B
      CEC849F19271621CFAEAAC4CB1EB71697E644C58A5CA31BAC14987DF91CE960F
      55FE9B1B1EB57E91A18AFDFEDC39EEF55F9D7C59BD8EE34F172FC69DAB22A906
      DF93FA3E285C29A4FE91C9AC0EF7E9C55334BC9E9CF9E279A01AC1F8D8A6B3BF
      58944AF2B0D20296935DEBDBDE26867B3519E0728B2D1313E5A4EB8202D7B742
      A57D8F0F2CD78B826A6F618239774470E0EB7E1DDFDDA05159018E6B7B425CAD
      C713D1A9B0C02B08156C9039CD4227F39261532EB3B2079464A5464F5C6EA26A
      8235C936B764CF73753AD225F20DF8341BA78D571610755CEFA499901D4048A0
      C14A7A2CD6BF2BA864792A31CE72864A4D5A86386FF80E07712328D9B98F1C55
      8F8AC77B90B2151DC41A81BD43A3445BA6EAC90E0DACF26631CC579766CFB19D
      AE0C5CBBB149F3A413934B5BA6F25D5465CF8EF2D055413010C5AD7CA75F2469
      DD77EBFED10B518A34539C170A5B30B3E4E3AC4F9D9DBDCA2E4831D0D457E088
      6BE690702A5FB62ED3789FB823C848A4CFF594AE7CABDF07AE201589D7AC6C6F
      85528993F534A21DDA10B6CE3D87F5D65F82031695C724244180F24E99FACCAC
      F22E3EF2E417F55ED8E81C65B10B3960B1A3EC74332139BD1292A7D1A76A7A55
      A6E66B2DAAA3E5C5DBDC90583B8DF1FAEE72AF2BBB461E44DE9161AF6E73E51C
      62D6E88C4EB523045D25EE9D8E7B5007A95B36E376905329A797EC65BCF2E5AE
      333AF5D9CAADB569E4AEDE81549D7AA6503CA59C3893FB5BEA451908E931F2D7
      2F1CC2D9DAC55B59586ED62AAEDD4D56A6BF45629D5D9724D7AFA5388D78DA74
      2A5866FCC46B82A1505818ACA4BAE682CEAF693477BBCB2ACD97DEAB5B3724AA
      6ABCB23EACE7D178F631CDFE6666CB89D06352900990ABBC90EE4216046B03BF
      1488A02A1FFAAAF4968F2237266689B7C6B544D5C39002568464B817D464D8EC
      F28AD00FCF24CB6A842770F116DFBEFB6C47DE734AC7D4D5BBE25D78C22506CD
      E01BA74891222586B297EAA7A5C31A5845AB035199B63AD3EABEE3D2F0F5A85C
      096128DD555541F29BEB71652F990082AEED537DCB3E9E2B8368EAE456A7752D
      E4604D91223B56893C9C4284E5D9F2F46CE5C4D275AD3CDE2316BBB6773DE124
      2D6E38E32BB8482A20DCBAAECDD325902DD3BC3D0EAF1EFBEA74162982012BDC
      B2BB4DDF96BAFE7727ECCBBFAFEDEF4F088B310186D664E2F4ACDF457F505616
      96A596F6502A055F2EE22903A6422EA2A2BA5888E7DCB40F1FD7720CB98586D0
      2AEAD53267CF12DC0B0EA93FD71A6C954978654B9937E874F2F2E97159BFF3DB
      81C39D2EA1B5B8857EEE2EAB4FEDE2B12BE20E350725102F7D34594EB0CE20C0
      E1CB9BA3AE07CBE185F0CAC33430C9F285C49DA3B85D9998BA226556B86CB45D
      B8DE76673760128F16D2399F9D5ACE91A13F8AF7D4E982B5A7F3BAF9552B2496
      5C5D0C15A9124F66803C7D7459BBB4BA42C1D62B73552D6B27A352165CCD1D95
      602AE5AAA400BE3CB02A120A5B99BDEAF3C0F701ABFDA2D1EF78E7DE97D8396B
      8ACE22EA193C9E5405B4A4B4A1EE8F5FC5CBE2500FFDA298626D412AF82E402C
      A5334C52CE8ABAC3E9D605734F33EB1FF72608C36C595C3B94DBD80217D3D708
      3555E8F82EC762994A9AC535F916126B5B3162830AE2261EE7AF7D69B97AEB9B
      0B79EEFB5578C6214A4EF100CF3AF8DE4EE6CDE0B5FDB02C48ADD1FEBE4817DF
      2FC3266A00A1AF9B10C1A49F728BC8A439B5F72829E9D6EA361CDCB570B2B764
      51A37599CEE2ECD22DB3AB5AFDAFF700B504660FAFDE7B4611D5250CD6C7BF36
      F2CFEE179C64F42143EF8F43FEA1F51E178B1E10BC7F140EDFD3A5FAC70D9B97
      A48FBB03ACF0B0F31B7691E6F5B788E7448774F1019FFD8C7D9D14EDC18D9B8B
      CFFF41DB8B831F3C260F84C1D7CFF01B04CD4A6B5A5DB6CB5F4F1A3062B9E5EF
      B891E5B8C9C0E54555771F403F6CCC9E6ABCC356D8D83C825EBE9C71F8CC1475
      9BB688229A335BE56CD6C10A4B52B5E22748D42E48219080CDE60CD85F711BDC
      8A94A94EA9189572CBDA4D56E5ADEEB0EC93FB5B61F30BD8AD47D64C1EB3C119
      31EE33C710D87094F70BDC313C135D13E0F50407683741BD58CA4B01A4CEBA4D
      7E73C3A998C7C1C164CA59AC7CF7DDA36245F5542E68F09F80BE53A345E036C9
      D85D2E18C1AF28941AA42C59CE66A71957812E817EB77264DC51B9F7A6810414
      057CF92BAD45E76ED6A233BC652D3AC3CF5A0B113C9E07FA1E983A15A8C6D58E
      000759E540B96F8CAACFFC8A5502CAE22F4B7D13170F3BD7B8B1CF0054E5F354
      CE4BE8C7410655D1B85DEC8E2FBA233A6FAEB3E0B9E0E33A099E3E5E93F38EED
      F96B5DF79A1C71D0C5AA11F170CA3FF794AF2FD96F3DE8A5DDF6A5CE7AF90DB7
      1CF7C3A4B401913942709EF46D56CE738B39337A3BAD9D0F4DFA4F07FFD9D9D9
      D996C8BB7CD2B5EAB9E62E4930B265B225E1448E864AE054A92E9715F5A2952E
      7A33B9862555986CC7532088756B8BEB914F1577FFA144C0D947B99DA67C0AAA
      C7E4FEDCECDD6B84A89E2BE18CC63461371D07C7AD975C8FCAADE00626B9334C
      569D3287AB9E6F7EA8A6C8FCF5FEF9C32F72B24B90E3457927195B570509D383
      AC106FA0F18D835839EE680E4CC62CF768796B9C167A25CA91A495F282F904A5
      9A7C37DCDCF03C57AF490FE67C4A557AE19924F1A666261EE0FAF3DD48157AD6
      95573B731B97576448C58CDE099E8B692DD7BCA824AF2F940109849888FCF9A1
      D9B99DF9125CBE565CB7A646BDCFAC92E3CA6502486A2E494E5CDDFB4BBF278D
      3F34113A8AF0EBEF910EC7F5B93EFF604B740D9FE38BD4AC217DDFD09CB25D09
      EB01E6EB8CE65CE66401E02ADFA2E13F032D994E9753FD563AA86766A2E5245A
      DCAD2FAD6027A8A2F2CF751ADD33B56813C34384703D4238FCDA11C2CD8D63B7
      B18FF940447A201C3C7B2A5186CFD9FED523ABF2DD07EB3C8F1AA7CB857988AD
      2D2514E0346E99F0934C7ACD0ECCF394C996347EB5481713DFA0B855854DDA2E
      81A35717AEA98566C2F4C525D1DC988D8CF2DF97CE36A4E31032AE809966DA1E
      ADDBE29802F82B8BF4577B031E825B706DE8D1203D97CCE013755BD3CD0DACEA
      09E4982CAB973D0B3FD5E223D3E47A146182636158067D3DFF1B2D55441271B6
      B27AFC35229A7C9DCBCA3708820B17A2550ACBEBB56CC75354C43C468945889E
      1E0D0BFB15E5A62139B43B5F7C710F5D61E102C419EE8B2AA7979904AD02F190
      BCB4ECE45506C47A6B73835B8DD9EA5CFFF0DC11F6DD7EF3B0A1F33C63232E13
      FC88E22C5FCECE83220B3C69A07B28665701CABC75502561C6EF3A3DF7D69AFB
      1E2B3CCBCAD637C62898CE17A40AB2CB7B66DA353EB11AEB3E929D71B4E0890F
      1BACB0735D237B59310157FB72B8C0FBC10C5B37C3465FDB0C23D13915A65B60
      AFCC3C6602C94247784B9BCFDC6E404642353B9D13D7ADE2398D619B90C1B158
      7259E9333B4B4F67E5AB19AAD111ED83D43A4BE3D8CEEAA6D50E13310F3D7454
      C97DB7B60AAE0A5318A3CE70A1DCB26C372B7789272B9F9529BBF6B11A4EDD15
      1D1F7B1ECE9231E033F7FC151DF4142DD8082C5625CCCD9B7FDFD592B82E1C7F
      B274AC4497335829E3A4AEE8705F1A7C8FD1651D1586EAA7C6FEEAAAFDE857ED
      26D8D9123BD1F5E087571C609C16366AACD36704FBCAA32697B7DF5A29C15500
      2D3125F96B85899B439AB9C043A1420F1097376CA134C35C1FA2E405685867D9
      C4B7ED90D15BD0F559CE258879390329EFB650BDD1F43DBFA4C4FE5509CB981C
      2E9C7797C9A35B4A3E1E89045FA66F175A968CA3D872C14A995DC982C7450F59
      A56F7F9596CDB1693B8314DF8ED218DF2B22EBC00D13BC0CF7DE2A2D296E7627
      509506FF72E48ADE4A07DB2186DDAB3EC4EAFDFEC4B2DC7667055D235FDA1BAC
      CF66B09C155A858BA7157AE948A1098D5DB1ED337FFCC5D58025FDCAF52CA950
      A22B75D99FDCEB92EEFB600042D2F430AE5CAA3E5758417717588D763CF94141
      DA314332445BDDD31284F3F63D2FF775F161DC1ED0BFED51B743FFE90C7B23FA
      4F7730E8D17F7AFD518BFED3EF8DF19641AF8DB70CBB1DBC65D4E9F5E4D3780B
      1D9E213FA6351EE34DEDF6B88577B53BF43EFCB73BECF1FB7A83FEE0CB1EA6BB
      C0AADC0D8267F83F5D49FA792F08765D47D0FDB95362B2F9C3EBEE41953714A7
      EFE1ECDDE5D92B0F1DFE4F7F93FFF92318DCA75308342191B81C5C4B73E9C4DD
      72C021654C2DF84BB01A53E363CA29A2BB8624DE1255B07DF738B619F093AF81
      8DFFDEE1AA46FA02E395B27B0DDA8B9E45865F34258329ADE8C27B6BB33D2F41
      A1D9C63EB9772ED89B59E9612C4CD81498E6955875539BEB3CA15B68B46F4F21
      62B3D594ED21207EAB9DB0FA36F2715E6BBBFE132C383A3FAB351EFAB632AF77
      0E4A6D250941AC5D9B64B5800A6F56C744BA53574AD74528210202C7CE487FBE
      E3A5E6AC5996551975647E0898792F9EBF9E7D36F2FE627A5033C094C0E02D8D
      B1F274D090EB9FE18AC978998CB502445A817739C9D465A5A147CBA22C8F2147
      50486796C54358F55A5875FCB5C3AA20A4790DE1F96F7CE6DC69D6530BE0ED9A
      EDD9EE62F2DD8F6EAC7CDB6A3CD88399B28C003DEFA95FDDC7FFEAC405FDE4A7
      413FFF7803246D5DE6B227319EFDEC72F65442496E3AB7EC05E67DD384EEAD5E
      3E74509011C4B9C84986DC52649495C5FA0C07E77F8BB61618A057D0D0EFE64F
      70C0822D64EBB683278A742947CFBFE874CAB6282255389CB3CEB5AAB05898AB
      52094D79D93528E36325FCB5E034F7DF76D7B6FBE1ACB0F9DD53606E6E7C640D
      42CB2C9425AAA998CD6EF23757AB57CAD55D60EB393F72662FB9DAA1F288C29D
      D546B015AF45B3B6A50460AAFC0B1AE97DB392AB4D678CA21A5783C89FB5F0A0
      AEFC7CA4EB93A39777EF8248C85C92CB38397FCC91B9136CEED5631F03CBFF53
      27076F9A5FBF38F756806BF55E81726604A8906E0C2626B493E29AFCBE3FE2FB
      E46C6521B6CA4E10171C49ABEED80AC5A20C7D1585D9D50F09F88C2FA77238D8
      7C603F023693E3D018E15F892A455FEB21C65945A0C9772DAEE60A4006AB46EA
      D20B5F35ECB8198B0C260FB7DB3EDC0BBD17E2F9814D2F5BE69174E8027756E9
      5514B0CD413F29D46DE3E77DF2457F09989F9436D7251A9E20BD02B88EFB056F
      C909A00A118DB9B6405B2B2B24ABB9ED570A0813790925B48E7E876490EFB958
      A1AF360C61218D17CC31A4E92613EC1DBC7CE96AFF4CF0D3D1CB7D0EB3054707
      CF8FCABFE35DDB8EF7C4028DD2E4572BB10DA66952B2228424AE9D8C24DDDC20
      81E13B4E728B746EB10273E77BDB6357B42B2686E3E6165BA3B8E9F115A62439
      A01E3E1E6E0CC23F487C55DA025DF6D89578A379081803FECB5C6DA7C300010D
      9670C8075B5E98A588A2286FDB369385AD7DFDBD1518152053599FFB73CD4F32
      DFDAD498AE2F43095E4A8A6A71156C41900A2299AFA110BC59D7A6891B96678C
      ADB6F7C33683A541389450682B4C04A2AF6CFC473A97B53C808DC3D9DF481432
      374151DD81FBA5733EBA0CC1966F3C7616DC7A2DAD827C213AECDE7243CD9066
      C7343E8C370996B8AB7D7FEDB5198D6173C387C259BC3A51CC8EE3DFA4E8CFBD
      79EB2F5E20BB3FB98A06E3703F4B9A32FF54811F64383FB258B97F248A98F283
      7B6C7470F3DC26E98712A374EE8BE5D3F554C082F49DC0385BC66811A737C468
      E9416C1043FD329DA010B588716918B62F5F383F59BE79DB1948D22BE9B4FA8A
      C9CB354E78A650B6D0A0AEECA264192B613955414D95C718358F0CCE562A6A31
      D5E9658FE0F893302D3E95FC854353E63D7CFDE62450F44833BB2A997204988D
      75FE54B1B0CAAC862EA8FC96E62585D903278833F1A2351B38D812541FFA55E9
      15B7EFA149DCB8BE0A8D929D68A5F0CF216E33F05F70EBB27A63D91D6B77025F
      5700C6CD62EDD4E3A2B9415829A0523CEB6AA994C7025D39EF6A1BAEB598DF38
      B30B033A1DBEA030735D83CFF5AF5B79B2E274D3269D3260ADD2A59B2A053757
      EF46BC0049454028622264AB1BC9C2F580E9271962F63475D8D5D159960A1B53
      E33F6DE1288C9416F875E6FFB0365D750BCB52F5EB90DD6EB6378EBFDAC8FF89
      89A8C9BF5559DAD5C5E2DA70FDD8F5616CBB5EFF8FAF79F97DC2131AAF46D744
      5331D2D4BA666D3235CD8A9B87B35A39AA9B1B9F96019280E104F0AAEFB6C22D
      D054B86447379D09CE76BA284A3AE9A2322DDD83F203C02D2CCF3D7DDBDAAA08
      CAD85949572CCF299C6677EFBABECE6EDD04A4F947B566F7D89ADDDC98684468
      D51AA687EEFD803189DD6C9491BEBABABE1F68BA9C54C1B5EFAF82E18E0935F1
      40DF821B7A70FCF21E6911A13976027DC1C0B2EB6627DF346FB1FD6BF07F9E3F
      7F2ED0EF2411A77349709406EC547AB1133270CB4FFDCB5FF8633B9E162221EB
      7915C57991E1A092E134AB9ABC33876F5181F07FB0C1FEB82B726495B0D0DF11
      12AEF7CBD2F21D2308BB013CD1C9797FF40AFA10233293EFE3230995C8FAC75D
      49B60F6E13455FEFCCA333AC5B099608B3E519D783A1EA82F518B3FE78AF9389
      2F0D306E0AC7B65ED1E66292C8717A686ADEDC786167E4BE4E98EF125F3BB56C
      7560E7DFBCDE7DE5CB1FBE959BF63B93BB8F9FA71FDEC2D6A18B318BEC17C8F2
      3EB9EB7CF4E3D7D9C7067D0743866CB8FB3AE4C752058B5376E723BEF345DEDC
      E065FE6203AEDE3D47977C2A5713D51D95309FE78DE4BC2C44E754A8C6141696
      A953A607C7AFD2E401806B2F9B4CCC5CC280AFB942D6570198F05B1169BFDF78
      F053AFD65C2BA1246366FDFCF897A0B89A86D944D382ABC076912CA358D69E0E
      49D7166E6B4E0A7F4E274FFC65ED7B9F6531F8841886B242BD5D26F5D97C9FCF
      2760C2E6CA6BE935A5EF2FE103D8589F9A2B8D73208797E5A719C220AB5DBAF8
      66D4597B383AB506F02551C6BA3F34D1398391E73BC1964469B584C01187CBC8
      02F690E13B70D7C22C5B38D28B4AC981FD6038532B2FB84F3AC04EEE82A05F36
      377C7B21B90FD23F2B8FF46C2F9C567665562E5B24654C8C6EE809721F33412E
      CD6FB628A369B16DBA9A0CD922B717C268B7BEF65C4151F260AFB3671FE834AA
      3B03478A8CAE03B76BFC56F0F8FAA7201E05FBCE9A59E13BC250ABA4D1F698A6
      43276165AF1C49CE3A5AD61AAF7635882F2C8D6E126EC2159A393983A07B4F2F
      D21844E9EEA8313BC6EAE7E5CDD58FFB25BCE1013BB24DE529A7E745E50530F2
      CCAD4AC19CEEA482AA2A8CD60284421A7AB9E15BFCDAF2D304EECA72992E17F6
      974FF1B83EF43EBF60DCC19ABA36027F76B43C868E4F53BB04AACC54E532FA4B
      2C857F71B60CAB47D0559CD922C579CA998CD99502B5248752C534E27CBAE46E
      8A1B502136377C7A04755A8A846126399DC62B811EAB8E20B8DEE13593C48E44
      55B58B1603F7B5402AF1683969B00F08B4AF9117945848204ED773C898EF69C1
      EF557A1FC1FDD5B56878B9E7FCD272615CFB5109DA92828CE7C34A57388AE905
      FB803B62557BEAD5FD3796A02BC05A7845CAEFABB52B2B7B83175E09EDD57741
      FBBE9FDD950D9955303ACAEC76A1A2E57E9D646FCCF92E6C0E8EAC1FE24BA783
      CA6444A52EA0F08BF7911A01AD4BF7B45F55CD2CA01C2BC824783C64BC705C66
      E78E8B6F65545A0AE0D21399D3E0D644679501E21B7880D79E8097EFBD60F75D
      2B0919AC6CE36A79026B5F5F9E708F00EAF66F9C3F90EA5331CE72CB4667C4E6
      728EE3A6DE35C284466036A4518ADEADB0FA9C024049C62928EB4ECB1BA73E54
      A358E02F3FFB2FFC8503AB9B1BEE43BE3B7A966979B27BC5FB08F4DC536D2E6D
      B7E8D09311A9293C29ACC6E09CED479B7E9A8359BC326A777F15303532D2D7E1
      9FEF905C11EE5BAFD066D43661DFD13C8AA37A86B5BABE9670C92AE4B0996B19
      519D86F4497145BEC514752FDFEE15BD316C149681A3CFB9A18F312E94166D6E
      ACC78DEE4C0A30E83ACB5AB0A4F960D27DB9F25085B786FC6811FE87114AB771
      5F30DC57D6AF78C5AD66DFB1871A73951EB4BD1CF4E332355C4A47772E90B048
      61B237453EE64ABD9C64E18B9DC587058753D8F72BCE53A1CCC5F7BDE0AAF2F2
      1BD9FF5F3159F19D929525DF2A8DFD871EB2932F68235FA6B3F3E049F0FC4D0F
      25EAF8EDBEDCBCDDEAA471D236374E954FE379EFF8C0B94FE92C9A2CE352E91C
      6AA0C31588142B2CB0F448A98CD16757A96CB41EA6E474D63F803BB1B956E755
      D6736AE14C7A2DA8C437061115BF8D1F07A66DBC358BB3066351A8455BA1DB76
      0D0A50BEBE2C155686FB96B809FD6F2AF6C70DC637783C3229E99549DD4A8754
      29D8F58E008C6592243207E3C26A2BCADE676E57F82505B4D4671A7807B10FA8
      4895D46D684B62553160303E1F5816CE3E9FB9BDF3C64B16C7F8463ADFE75F52
      24AF23C22114399560E8DDB7C17E4125E3E90A564FCDF5234F1B78E44F24F38F
      EAD966DE1739DBCFC8B140011BFDE525AE6AFE20F8253FE7120DD5A8BA786465
      9623493FDC27EE97DD608232C340AB7650D178E38A543C88A9897DB3D6B505F5
      75AC15FAF3D36A99C8E14CAAB622A39C1585F565C85A090ADAA9CB6A05CD72E6
      39CDE3E0F0E415673A3822EE200A2AAFA3316D199D419795028E13B46944FA01
      DF9516D35272545A79348182D08C42A4D27AE8FEAD04AA6F9A78D323FE733784
      2324B9164DBC7485C81AC85C4F24A824BBA11B97464A0B8AAA66C65A2D1B6E49
      1C902129317F19AC262EC22BF0466974B355763A90338A7771C3A218891755AC
      A58FAE97D72BB2520D5A89650E4AAAC60D8BA2F3605428BCBD087E7CB5BB1FBC
      CDE19F2E389B98C8CC1BC78B7C192D1A70F31BBB0C48462FB93F726653AA91A6
      1627B56A49332D983E87D6E1A34F6A02581783CFC37491A367434EBE20335929
      D462E1859463D9C771B870F6D18A4902C00BCC683B388EF274AE37A632BD6AA0
      EDDD61B015923606DA01A7A200B09B9BD347B3474007F0798FD50ADE095D9924
      F3C16D5AE258E30ED86151EB5C9A7CC6F8E39FA9F87E83DABBA2FF3D9E4E1FD3
      5CDF15367F1A7CA011C5F6C3D3E0EA8BE0E85DF7BD7FEF0C5E67B3BB2FB509B6
      52B964AD8784D53B36C461FB66F9E13E23BA4DCCA9886AC3158CA08F46EDF9FD
      D1ACA4E84E0E8EFB4F8EC9B55207E9C9F337C34170B07F78E2AE73A5981F0AB1
      84C368BAEE0A0FA93FCFD32CD7D2FD68FE46BB704A6FC1A7F5A52CC475F6889E
      E6874329CCD815C9C9B074018DD0AE694FA31FDE099EA1F96FB1EAC4490D83DF
      6A898900F75B14B2F01A8A82D0682B27CDF2722292D460EE89866F26720906F7
      2E5FC8BA5BFA8C64E39E2266B6C8AD2149EBC68058C725909DDD22D2E694CBC8
      73F16EA25B86F545E0D82917A796DF26DC3DE255ADAF827C8A01D1C5E59B651C
      7705421946B752D6C2015BBA0BF75E4C703E488A6B22ED4922E7E6092F28CAA2
      0D0262F7453E002057B4B7EFA1D528A1E4D36E59A7F4BA824F6F1B4FFA5B4644
      57E04B806B95856962CC541A77B7201F25ED884AAFED6AF4A4BC4F2B8DC0652D
      FDA78FD23DBF6E64646E6EA80FC3E0235B58E9A3373056693F80402291BB32C2
      B505309266B0BBF7FD9164D29AC1CBDDD7F4B6B72F8EF4CDAF777F7C858FF313
      C10AEA0CDB8CE1DFB6B62B212B66338151BC7D7F6EF5E14C57A4E9505C6E7019
      56B7030B4537A1E7B7A512D7D41E5C7C08A1CDD241D344C32A6939028ACCFDC1
      5D915264CE5C3CE8BBCAD8DBF92EF8D00CAEAA98BA2BBD210B8F3755589323B5
      0F3FA3D2352B434783652AF5622BEDC0A264254E2957143954D71EBFCD278883
      97925A5D7DAA7ACC0907AE241826EC1033CBB605F46A252CED57977324EB4B7C
      E3B9755D62EEFCAE3A671EC886A68C8F8B2B474F08B6B8CA013CF482A3C5F9D7
      C995337056C9A368E505C6A7599A0CB72CE64ADDEB7A777565E198CEBD12A630
      1265C1B7142BD54D461DCB8FDD6969B72B4F04F7FFA4FAB82637B42A753C1635
      75D1670D22F006D32872EB0317F8DC8D416BE9344548033B54C6ABA50C85BDE5
      EA0EF865B96BF78FE5D2DDFB7F534B26EB4357EC3B47C7A4011A7F9FE97C94C7
      500AC0DD81BE3FFA40AEE547EFE34C484A3347E9C46D8195C5541C317F19C53B
      8B9B5519CFEE7674B6B9A12FF183AB8C1F70C173815C71405C65AB9E22BA0387
      7DC6D5C5226BC589E17C12DF71B9DD7C9925265C9565E1F2540DD9158FCB8F9A
      BDAE52EA940B12A752BA3275A8F2E54B4EDE4898B7F269D1422C837DBD1C0BD3
      CD0D521DF003658D38A55EAE12042D575D5D6A2692C18395C0AA5996973B1555
      CE9FDFE84A9E79CEF800B4135E01A87C2EB834AAA5D6CEFB438468D7C5C14BFA
      36045C6F2045236B08655EAE38BEE0B8ED12D91B8D69DC1FE17172737D6779AB
      B7D88E423E80AC9F495A00736335E3A032851692AE1517662204747D51C52A50
      FFB34A6505E9246D0D330147AAF652A000D4F759F07567C2839562CFC30A8022
      B2D88A29620A31EE726FF2082247390A98380A264A4F96BA97D2552E9FA838BB
      2B1972D71E51D21E71CD0E3D016D3406EFD909B69E49CF31DE6256F0162B7D54
      E51CC5DA1169ACDDCAABA82997E0CA9DFB6E21018796BCFF6A2287B62C8DACDA
      42A796F3F3BE1CC2DC7853169B1BF49AD8C9A56AA82A161E1DE63195582BEC44
      C875ED87B92E8C572A1B9CC05CEB3C6BDE56635CD52CBAA0AE2C8A2B19DCA3C9
      96472138541AB65B04B7B44C813DA352FBE03E715B81F3E6461506EDDE0BD4C6
      1183BE34DC329D4999F54D8530F7AF8B923B47DC025503129FB952AEC9E98CC1
      F2ECCC21ECB847CCC1F319DAC8C0964A178C638CD053E1DFC8A5BD67A80D5291
      287263BD2978A54FCB81D06A6A804C2CF10D4BCF89539DF7FEE8BF7CB3FF82F6
      44EDB6FB73AA7F343923F9CAC46F2AC9D095415D10777ACECE5154618B6CF6A7
      FB7E688ECF38DD9689469D67A9FA0348A84F1163E6943B5922597E8F2CCC57D2
      D65094EADC071355D421CA98700B6D9E2FE74CF4BBBA885A17B3E50D2084A75E
      9BD72BA684AF6F83D44D674B3EAD3130CE25BF56EDD8A87C31A36097CAFE23A3
      F55535D8C0208B5093E29A6B56B718E953FDB5843F5DE5F94255C9F90C8FBDE1
      C05C3F2E6EC4196D630A249D6730E98AD8481E917175040830319C6094FC20A9
      0EFD3CBE4FA6E10C2AD51164D48B3D9B9ECEB837DC78A01C5FCB83A4AF6453C9
      B25F30A5189ABFF09E30CFCEC5F49BA991BB13FC67B614D573CEB1D310763EE7
      2F2F1F08DA377ECA72EEA0E6A6D3575C68143C2921D4F52FB80E47EF66380082
      EEBE3B49B9CA21F88F77C727F726D9F1FC5A119A2FDADEDCD0683C96AAC40DE0
      422F1CEB65588DC5F36D754BF9F2F824F84BA5C655D6F6A2C04B7BC7F412C02C
      B4F7A1FADA4BBCF632D36420BFB27D4B0AA6205F8B8C3B876BC036981FA35215
      567230D5C320D55DABC7C17DA28AEBBCB9B16659EA797960B950EF65773E27B1
      264573DC7CE7D0492BD5A7F7E522A10AF77985EB6DADD4B2E4DB94AC89C314CD
      8493250BB30F1A9AAD12C6B18A9CA453FA11E99AB42C5DD5A7B8CFF20D9CDDCE
      A019B09744BA45AFB8438003F8DB4AF26925EEEBBD78F9B6A60BA7BAE4A00EE2
      1AE44AF316D45A539C7BEC97B57261D800869B6A91B8DC09B68E9DD68CD322A2
      A3039638FD485954BCBD327691010E1F379A648536807CE13157472BE8B0D962
      ADD241BFB53A725D6F1AA58BC271571AF7664BC466BAB9E1306CF4F3DC97E352
      BC48A962BB1F15F43D365A56F2AAFC687914529BF261DFD68AB8CD4A181C44A7
      1C535F2AECAECB48B34BA2B6CA3A7E301E73EF45A0C83E36D7BE4199F7BB41DA
      68CA912503DD223D2BB06887C9ABB4C091DE3216A5624F83C3CB103FFC99AE92
      BC05BF41F03C45089BDE49AF1C67F9425E2C9E06CFB26C027BF82FC10918F4FE
      FC252A9A604E28F2AD2303269B3FD46F9EFBDEA4EB847EFCC3329F31496019E7
      758838642A78286986BED674FE5DE7C36F58FAE28625F78B7A72CC6B5D6039AF
      410BFEEE343A8D4192710E24D4AD01BA13740C9C9DE001EE209FE0168C61C124
      78C6A948E12A0A22C1F20E2A2763854FC98B9E2FB6AECF2C294241F9DB328A58
      C34BAB3F7F8183A9D08F77DDF356CEE96016FFB133A2ABB6066E071D0845AC49
      15A4515CF95FA134BACB9089B6B9CBE34C18CA2B349D67CB538B44C5DC4AA482
      B3B578FB1351E65CD4C40D5174F9D03952C538AB0E66929E4383A6C567B0FF94
      4279F161DC1ED0BFED51B743FFE90C7B23FA4F7730E8D17F7AFD518BFED3EF8D
      F19641AF8DB70CBB1DBC65D4E9F5E4D3780B49FE213FA6351EE34DEDF6B88577
      B53BF43EFCB73BECF1FB7A83FEE0CB6A02C659FD9DD7E6C238F083A0D239C387
      6BCF719EFD59DF11E262F9773F7942AE83FFAD7AE9CAE76CFFD9BF61E10B4F02
      FEB094D5D1AEEABBAFBCA54C67AD7C82FF4C92720145E519E59DB8F10BED2C76
      BF547EBC4FBA9D940903471F20D0B57766A37372D1CFBFA6F4FB1FC9BEEBD378
      379B5C9FC89DA00EAF0B3D726238F7A308DC11BE1D624AE2259CAA5E2B1DF4E9
      F6325BAEA421EADD15DC515964930B7E3202A6C8415FA6DC3C210D810E58DCD5
      020080BFECB69F574A5ABE40B5DE4F593E898FE726B2CDE01172C63FBFFDE551
      536CBA2FD27376F78AF3E669B49BFD2F3791EB0A1302CE706D766ED9F0AC546C
      6DDF5A237C89611718B696C9A228E327FFC72FB5F16A49A007E047E414BE1513
      49C7FDDAA0E1E80B8D5CEA9CB9CB8976E75C201F26E6B4005028204799294742
      0D5C0BB8520D83DA5D85B2BDDF5EF7B3E5A9F6F77F2BBAF84B74F8E7561BF3C3
      E569358BCC15070E6F19382F29C39623E1059E21E8186EDDBFE9632ED4E38A7A
      38ECED9E81AA240585F1D551FFF51E2F21B6C85BF07E3E21C5A4FB10AC2FC2DA
      F43FF766BE271D7D469FEFBE8F43FEA1F51E651DF480E0FDA370F87E61C27FDC
      700292F47177806D1A767EC351A079FD2DE239D17925CB9D3EFB1987638289DC
      7442F0F93FE88CFC537FD80B1E233C189D73A520FACC335BCC1E2D44DA28DDF7
      E2BBB210AC66BB485318D0148E4A2A32CEAA62065A7058624570AA187DF7A75A
      5F83E6FBB92F24A9D1948634A57DB330374EE8DB99C698A621AD7DEE5471353A
      79F30B0DE3917B14651CEB02642C1022E6258402098F7727CF1F8F0238FFC1E3
      68FE74B948E857879551BB098FBA3461CCD747DF35536FF273C9E14BBDBB06E8
      79237D792DA705EA37250808A69B5332D5D9A9465CB89B804CC709335A440BD4
      336C15AC5FB62B7571A88A2B9852D9F9D8B11499F85A8776FD26DDBF7670732B
      F0235A983CCD66E8417715C41394056A39B2D41B467486914E2BD2C57205DAB5
      46B384E03CB75761063D58E616D3194B14DE268CB558D109F59B0684A5BF5361
      360146CAACDCB96489DB05560A2DD1ACDF0C46B8636EC9199B47BA39D3C8331B
      673443102697D2B1DE9B32AE4E09A3A2C19F6579FA2B02111345A306425F84E8
      45E1C2B661B65864D3695648F2FAAA76131BB76862B0885067460260AAF9BBA0
      9AF389AD487F0E4F2B1102F96888A6D05686E873ADDFC420E81BA8A301D19882
      3E36567008A5AAAC6623DFF24E0DE7DF0B29A57EEC53452EA9840089F42438D1
      1CA579B49CA28721E2FA6D878CA5058F5A32A8E1B09ACD7A73E3B6794BEAF009
      CB3AFC70D33A4CACA359B94873509F078D32CAD3286BBB5C4870CBD71CEADA28
      633AA0174CDDFCBA2DE923073D0A021090975897976676BA44956945D129BDC9
      A591A6E61DB1490B2544A4A3B01316E6C94E683A01DAB841E0FC6D4C96CCE651
      695A236634D18B1D076E92D27D4A2E8681202607B0847C2359E5DE65B4BD510E
      029EEB4328355F83DC92A87560F24C56C3A5B164C665E8F442DDEC7A5B725D66
      44B7FBE63969A04FFBE4CA930C7079C8017A1FB787A152C9915FA1E48775A950
      5E2DA4E9CB46E7DA2427F07152BD4DC25E5EA9D982DCB61C33C69D624AC54A9D
      5BD9A8F8A4D2A4783557BCBC8A785319E87A7F56295901D1CD7D025E9907A19D
      703321F79FD44DF0FDD3A0D5E250C85C45BE096664FBAA2363E6F3E042F10525
      2258B3E1DFA6D07C75A1E6C1B24A5BA9D74BDC81883E437DD372B648275A4CE3
      6ADA18F186A39125576ADD27FFF3F337BD5F82E76079A5D3FAE2E59B67B8BE97
      7956EB19D0CDA9CCE163360653965D472491DE7A982ABCB1CE0EE18E13DDD51B
      8E0543E8C8C9A8D9E2DC6EAE71D5A5949CEFADA773B738FC5AA9A1DC6E068DD7
      193C8CDDC9A4519E7E9F1972B5F51574418EDDD44FA0DFB21CBBBCB795F5E0CE
      70464CF285FC026B5E0656B6573B38C17AB2052C01982E0C36BC8DCC68383140
      FCFF46D681537CE893F2DB4B33E24E826FC402DD73F12F72FA17D172A1E94B69
      00972E2F47DD26D5C94A32E8503DAEB4607AF668F16D4CF888CE68360D767F5C
      D53A979582EDBA4DE496B377F266AF349C57650CBDF1A77436ACD9446E97AE72
      DCE818369E9309C44253C3319769BC38E37ED912AF6D9530CD07E6C9CACCAD51
      EC1CF91CB712E239B5BB8DB72CC4F78727AF0E8A604B95E55B728ED20FF45706
      6845BF7020F5B2C18104E9B7D9DC387AF7369898D04E7CD840AB31335AA3E9B7
      32F76BC4A6FE4C2BDC59051AC9210EEDC929F9C99F926F64AECF00B64E7FFA1E
      4DABCA8759047BCA31467BCAA62307C89FD009CE96CA3B281A375A160B61669E
      D62FD271CB8C5D6F7C5A144B01B0093EEC2FA7739957BE9CCD9419D748130B37
      3BE975F788BF121CFB46668CDC1AF766497426E2A87282CD7DA32167DC726D8C
      86CF87DE1CB06F0AD71B274704D7EF1B99F06A264EABA118B10CF1C7606E68CF
      CB2C3F48BD814C339994B01DD28E9D4DE2FA6DF22DE6539555FCCD0F68955F94
      4026D7D8C778C3BD58D3150AAD67D3662C4AC35D70DC67F305A0F60F90D9FF02
      958DDFC26E5D866F9284EE134A364873147BF42EF65149690A544CCE7D0B1C5C
      6347CDB1C2B1BCE2C4D1151FE66F63BECB99F45D0A2E35A64A9E39CB14816460
      1D93CEFCFBCE52F1F4450215D23379BACC1D8D66E74C1EA50AAB7E5EDACDCB50
      298BB05202B0F517FCAC40128E42948C29DA6E8101F298F3B1F5144FF4A28004
      D54DE5DE6E570B8F49931BADF80738E87B6883C372BC5A4D3549313B247525B3
      B6F576C236B55C892A51A2D4AE5F654BE924ADC0D4B914165F9AEE4E7767F0A7
      3FFDA96E51D88F857AB8EFF6B5BD6417EB062B94835D154D26D2BEF239C43734
      07804770E9894D161CF7AFF226B9B6DDC67E0695C9CF15B61C098C2AE85B4396
      1FBDE06552E086AF65F5022640D0D99AA99474D66CDD6F5BF5E3E3036F3EF814
      A6ACAF8A9B9B6977DA2B01353E725806F7DE5EAF7E52EAB6CBFAA3C3C329B1F6
      9C7FFF8D4C417CF120721286FCEF7D7389846E1EEFD862AAA53D45D093249FC7
      1881672BBECDDF972872E527D476D28C745899F65936F1009B5A6FC2F534E756
      8B5925C75F0163C1318D16F9C495A7ACA7B82092CB4A8715D0ABFA2DC79ADBE3
      A009840182A690CE2742CAE2B1911C3282780C5CE6F025F82019C68099269008
      C408EEBEF1436A10C886879FA3DBC84AB49E6ECC2D9B560229734D97AB855A3B
      95E98ADF42E733FD15FD69359BE3AD59F93DBA70C177E2B361FE9C8AF85EC026
      6F503B3C3F176EE220E20A0AA5868F19AA48C9A1F9AD78BAAC6F2D535CB79D80
      771E4E09D024F0854872596ED38F4A6ADC75681A3D2155B0A0352797E96404A7
      F8923B9D5660676AB638B71B852CC71E6B25876786F0B5093700F056E0CACB8F
      31B01B2A3DF424795BB05C18F764BF820E21BA72136BB66CB7D6B80948060E47
      15ADA679A354D16A0DDFCF5A2E9AA9A07F69410123097D33969D57892B956B55
      B64F8FADEF0BA4B94930E1D2F56F6496D57C5AD39FECAA63A89BA7F8BED233C3
      C5030B0F008E16365D829A4DFB9F06ED3632BE82B9C52D7638A66CDF916D3B97
      286F89BD24F8E6F59B44477B5F9CB8E63AE805922907C7E0F89973CBB9D41563
      D732AEC6C953CEFBD66C3AB7D622E5A63893F61713451A4B355CA4AF4CBDF0E5
      3737B4D452CE655362806C37D07BADD4A3CD0D8262026B125AB6E215904BE8E7
      8123E68151B5E1C9F971B8D01A35204BC9552A9798F40B6DA83232E06F64711B
      3FEF5B3BFFC5D7C16C39AACBFF460C423AFCB61B9F2CE446BDCC24CBCE254F82
      98D1E686A70D76A40620687674C60C17834E5965AEAA40FC33C202CCBC5AB63E
      0EDAA8D97FABD95875FEB2D8CE716616B9994DAAC3FEA33BBF6FEE6EFDCD9DDF
      BDD1BA9FE67BBF7B23F47E9FDB1C3181EEE0D3ABAA21AD99908D8893D8DDE9EC
      74FEAD665BFBF57B936FEEDBFF037B93DFA9D9E66A56810F96C508CD7176F7C3
      F181D3253B35DB3C19B993C87B27FBBB25E3523D871A65A493A4901C0365502D
      E04CBCE93683E7AF7F148FA3B2E2359B8582DFD33DDE69D56C681F06BD408127
      6A352EA1C8203DCA86C985C953A19960531B8356AA819A0DBB84CEACE7F860A8
      B8C6EF3B185AE77387C6034160D30F8D079B7482EC93FAA4DDEBFDCF150A7FF8
      73354A3AB9B8050F861FF3072996DD38AE500D713E9A8B8C2307397717FAE4CE
      76EE39C2BF07C76FBDE3A4C458363A9B29D397423F71B6945CADBAA9C3075B46
      BB385EA08B03BEFCE1EBE76F84D6AC665B454B4917A0C2FE3AE3027AAD69E078
      5AB0B7C7EDDC351B394655F28B6B64B34EF7F8410297CF43D508CE9113699220
      12DB83CB68F65FEE358337DCE681D851E59583E357B58BCE3E08B8E0E79383E3
      FE139672CE6F7B7B70F443CD368AC470F709F933BF0829B848899A8DF1605600
      77D438DC46697943230DA25985B77FEBEA510A261CDDD71C91B94BC3A17B7B2A
      E509702AB33856BEA4BA0D7D73635F1157E3AB9999A611998452C799A476123B
      FA356DE97100D22698DA1CBD7673B388CE76829F10854379CDE271AAF4816622
      0D232B0F4B93E0579B67DC7DC2F161E05D6D6E144077C9C4CE9B480092A1A981
      A6E7CB3C3468A95F2C31DF1D20553B9666247F10EA443E3445BD0FDE2A54DD64
      243A1A39C3B45C3CAA02F4EF7692685989BE1B30EBD9CCD6CDA27C76BC4B4F0E
      2E5A3BFD9A8D0CFEDF5D17563F2EE82FB71798D00AFC4F4B4CE69EB180777D6E
      A4E4DC415D48C9E5B90DC27486EEDC3406BF2CF91C5A9BE27A66B8B89C4B5390
      72900FEF087CDD990109A1B4299849B49CB06A9082AC57FB7DC9A49C3CCF0053
      3949C3BC8AD1FF10AEBE2D5CDD7E0857AF5B409DAF6E011D1F1F8801B4C79A01
      E5A493651814CB39925DC1160C593578B79BD0841192B855AF05DAD199C4B4DF
      772D47FE79278AA22F53A756B3E348D668FF09EDC72F41E3859D2179C7CD2F6F
      C2BFD96851341C59AA30B8D46DECDE46D551EE2E26C00498D7D1D853748A37BD
      0AFD6CCD86B8B9717C7E95A7D3E0C723CE623C4783E472D1C3EF7A379F920535
      D30629F8313F1E41D2EED80F0C904FB32BFFD0C45F344F2FF9D6C76448F52F72
      FCFD7192F5E827AF55EBB65B9B1BC2EB46DAE729CCCFD1E398CC703227CFEC07
      13DB289D926AD70661C58C4E1971F0228DA52DA0F10CD120C5DAC59A64398809
      945BA021A66D536AD3F4418E15AC6C2E60DCCF9A2D0D57E1AD2060FA706B3A8B
      33A1B12DD2693AA1718133AFA9410BAECA54BE476DBEE4B234669BF4CFCB6693
      BA414C358E6C2128BCCB881C4DDBB83E212D4194BF7355DDDCCCAC6317980A63
      57C59D31B3DA4DD2B57EBB78FFCDB3F49CA371F0EC8A4B072FA5BAF28274C7C4
      174EFAA4816676D9EE05AC54CD66BDB98152B1600BB2ECBF490D6EBF32F35740
      20CE8B9DC507E1F42B5FFC8FA52D162700C7E217691FD124CAA4ADA8D062505B
      E99F55BE672933914E71A68F240773B2E49A2658AAF2AE9A2D8912EDC51E370A
      81EEB48E2AF542DBD9C3E5A9248E79BB205BA65AEA55B711CF2A394F16933E46
      B5FBF6909DC8124AFE6F45366B06B33421013A456C283513FA7192C5E2533EF8
      7E9FF0FD1E3CBF75CFAF5B07CFEF9740ADCC63E03693CE38D07A1A35316BB66B
      3AE4E383FADAEDEA5A88B51EF46ABA901FD12B023589063BCFDC55B3C17FD3AA
      E641537C5C53B477BA0FBA625D57F41E74C5FF52412CC4302ED88A482AEADF8B
      89597042CFB54749C8C613C944D9740A9937E1AA1717B7A9D9D41AC74ACFF4D9
      2E7ACD26F069E7EB418ADF2AC51F2CFE6B52BCFFB5A5F8376DF571A98ECF2E54
      25E6E924BB64A6088BA46DDD86EDF322CFB9C2C42375CA620BD89F351C86A2B9
      D573129B1BBAFAF85777C05C64695C04A792A8E2EEBEDC922D8E496057E225C8
      ED91C2D2883A780D243C5F34D9762779A11685D69100BF1171170646671C0106
      0814EEA012570841BD0701FC2901FC906CBF2680075F5B0097C260979B38DF3E
      3BD8AD272AC6B7137866F245800243E8D8E97C7115D053CC55DDC6F941E52686
      EA04FEB3E3DDBA12F4B8E1D241D073A0984DE867B4682637685A9686E609590F
      4564E616D2BF6613A1EBE63416D2E86FBAF2DB8302F99402693D2890750532FC
      DA0AA4980307A0CEA14EA9A356B2AA8935E7F51CA06397236986AE262E5CDB3F
      DC7D59CBC12693CC2C5C1A3B079457FDDC33135F18AE447895C5DC2256048935
      A8D0A8D9404140FD7FC1F0C9FAA0A10DC55CD0BB0E39D5587133535AF68B3406
      9E2323F5D46C5E8047D78A650618E2F86189AD5EB3D19619913A378594A30CA0
      02B4820E316F641E352A2B6F78DA58D862B133373835EABB7AF71E557A0CD982
      F295DE7F730D0B5922FF4DB6C9B6B486A348AF669357FAB5A2C8A294DB2E5CA7
      05667DF745BEA847A4D5FBC7E6C65D2BCDE697196D0FA3FD0263BDBE00BF7BB4
      49D6FD128365097AD76BBBB941E39D5D7C91F182A76D56D450D070353D69CEE0
      4D7E6A66E9AFE4536DB59B1C08EB6C230096081FD082CC7AE57D91AEA89BF240
      5F0038F6F134D3413CFD17FD0132ED5FFFB7F32624422E74E7AD510CEA0C7C3F
      300A4CD26841879DA67EC7C75DF5106D9842BED56C75675FA2EBECCDD32FDB72
      C605D242C1438EFD7CB9506063B611A1DE35DAE002E3E00C982E23044C7096A4
      870624B7E06CBDF3E93768FE3B3BEFDF932CF1A2E4FD7BB2568AF7EF37375C57
      491CECA7809D5BD0581BFFDBEF701974155398ECF7B33456E70F1C9ED2DC67A2
      45E69A5C6B37038C5E28111070033126D2298CBF7C727470A00502B49B3EB3E2
      D9832CD846AD6FD5AD25B2E2B5EC521353B85635F0F85F155C817EF00D52F58B
      38EA6C7EB2669ECD9EECE6D32C7FB23B9D2E675A2E3347F8B738B37651BB8326
      237FF666FFE409FDD3111E698F35CCA1768F6B275D69CA1873C936480C3A6E88
      37A7D600959A4D9675EC5793A91EBA3CC7FE9B67FF1E90E31C4FEAA72775AC47
      37A005C716B8AC25B87AB5AFE321B67D4B6CBBB5D37D284FB916DC1E7DEDE0B6
      30210EC64F39D83225DB2912C807D5D56B4014DCE6932062A7C8F1A81208CCE6
      C614EFC3073CEE04F0A01C4A5ADD64AECCBADDA3696BA1444A2AFE03F7272973
      94C0FBEABD7F03342E92B1B5A331D5890C3A4F2B7C3D79B6101BD8CC4E275014
      F9B4C47EDEAA98CB8E153D2BFBD760B5D68D25EB2C5B9CDBABA2DA6959B64B6A
      CFE5D6DD8744BE0C492180C1C168974F9BA8CC999BBB8FE67CF75983462CE2B7
      F8B5BCE28081B9FBD0DEE3BB5F651DEE2C9BD9F5F1D2C47F7F78EFEE479CCEE8
      062EEA76F73637C02B151C9FA5C942618698D0AD244E826F7E9ECE19A03F63C4
      79BD92F43E7215B6609A921B9483BB7D19696F9F7C940C990264B3A436508F2C
      704AB6385F205144067BDD16E3DA52448E79F5CD0F1F954E8C653513FE295EAD
      B9AA574F9DEEA5B7005F016DC9E327D76C15EC07B4F0DA5BC7EE568161A8CC85
      49272E2D564F600A1915535028C71F62BEA7A4F635FB4BFB24863FD7EB92D0D6
      1853116CA15492199ED8D0ABDB7905D7D4777BC0054B318DD9E42A788D1C1A46
      C69C4A93741E6606AC130745C4846852112AE45272786B36A76AFDB462ACB90B
      83D08B9AA8F192ECA0C44C0A07507A2164A1335F692D11C13A72DA69BBBCA438
      2D373B0B104793CED9340B1E09D1D5CD6F4332F451CD26744BDEB9D2005E3C45
      E446303C1929C46580B7F808FFB4DD0C7ECA727240E600187896679705B235BB
      93C577CFBB75BB757E47E688DA902F01D2962C3B9F9AFC5CC5BED63A3C6536B8
      EFDA3B3B7D17E236FEADCD00D373AF9D664168A2F39A4DB552A0084A6B0FECF6
      D3D1CB7DE0C1642EF83BCB2E9BC1A36CF6A8222D6B3697EBD5F65BA1A5E968EC
      AD097C3AEF26B1DF553B4749A7E06A1F0CA2A0C05F21ED3623B94FFA4A786C8A
      09201FA52D80AED65CD895559A5E65CBDC6334A4894243D66CA6BE39E2E87A57
      8DCE63EBA793EF8F9A1C636C32866B5362A97333BFCA97059FD566F0C22E0E40
      ABB42F94D34A6D418BE28BB15F9B8B57DC1F126C8121F69C35CCDFB2D9653CAC
      DBFEFB55914A779EEE969BAF6EE936868FFC851075BCFCF1E58B60EB74928566
      C22FD11F5EEF04276796B1E21F816F2AB0B42A02EAB4F703921D0BE0906A9996
      769028CDE095736EA5F486C13CE86395EE91BAAC1556AAE756EAAF472FF66942
      A18BE766C1D1C1733A3C0CBE2EB65F2D018091664392AA4AE0F7F6E57EA73217
      5AFDB7BB7B3FD0D5E7000AAA9F6A370964DA9EBD3DD9F72C93992F020CB3F88A
      29D30ACFC948EF7C1DCC6A78A2781E4796DECAC9CDBD83972FF95EB0363C95FA
      4C238153CE1F2435C5433CEE3D51886ECDE1F204AA2AFECDF3E3938ACC0DB6D8
      B47E749C727E5DAD9B47AAFED9104892ED870CC92733240FFD63D73224E3AF9D
      21B1C55C318C953B057563206814E63F5B4C6BB6679A13E80E9E8282A3581810
      4D93D99A4C149B900C9BD3DC1605575747921680373CC960C93B02C3BAB9C56E
      5AC3A7CAC6287D675ED3918200F1C80288BA307E8BE0F0E415BA216225C65EE9
      029E59A685A59767F5CB3D4B07028A4A58AE8E505D9EB3FA2EFEBE44EE3FCC69
      53EDE2FA94359B759AB25726E10D7CCEC1F730425F41D6ED8EDD097EFE3F6FD3
      C5F1229BFF52BB1823FBC5FBE1C4D3A4AF408D4A9A4EF84E0BC6608CB2E5242E
      89ACAFD82062EB33533604C161ACDB5D6503D363466A7F0C73E75C96CEB3C2A0
      620AB1900ED4CD1D434FA5C8489C4E272041406CA205C0FB849D9E43FF121E66
      03AE70F57B7D7146E6428D5B7E80C3C98EC399C37B359BF82DA1AD66F0EE90B3
      DF7936598B73ED16052EEED4CCE8F0E64DF77BE8625A7CF2EB17D452C75224EF
      5FF7FEBFA360CBCE5C71C0AFC86DF82CC0BF6DAFBA1F70A5EA3C9BB7AF0E8FEB
      D910EEE339538E446461917119221A612615CDF73478F566FF5993FE3DDE6F06
      CF5FBCD8E57F8FF1EFC9713D27B554EA9F977BE4CD555D095468DBB8A2BBDE1D
      FFF056ADAD9ADE0A2FA9B5F89B5310B45717A0624F0D922A3CAD803418840164
      5F4DA722A6470527C591CA7010A1CEB7E4D1BEF8128F9448E8CC72296B45793E
      7ADC69F786BD5177D01BEDB4F0BF47D0B542A8EE19BEE1B66B6DAF3C08F12E32
      A4FFBAF7F2A7F2CED5CE625A8BFD36E0B3BF7F2F34064188FED5A2E18AB3D643
      BE758FF6EADCAADC492E3E2BB566B8547564CED520A39375156BAF2AF2E8D031
      96460D1B5C75022215DEBE383AAAA876FA275FCE3D06BE599C9DE64027123C74
      73513FBF6A653637C8B8572F0E9EF35982C92222E0AF2FDFEC556F7D7DE7D378
      27FCCC2E07F7D7E383FD0689B0BC860E6ED91E22639774DAEA66BC7EBBF7FF9A
      3724761E389F3E1D477C8011598F23766FDEBE3F308EB8B9A1F853E4CF3E794D
      3BF2CA326D0A7C5CCD622E6774CE77827785235727A3446803B1C599F0696865
      23B20806F5D7795AB91475D9EF630B88259E5B6EFFBE4C73E093485D35F703C7
      DCB642C229AEDBC865930C2D33B2C1B775FB621F80C89B5CF9A6AF4770565229
      1BE71410F6B26693E3E0C26EE514A16C8A448795A21B29F8AADBA01BFFBE9CCE
      19D236F3D686A8E347852BD09F67F3E59C1BD6EA36FA831902764F3470C75D16
      641B49A781D643D66DC82FB35339C648DC5DD8FC324F695433E42EBBAF9ED56D
      B49B1B3F7FD8A71302DCE905F9E0F643641DBB528EB014F2C870EDCEF26C797A
      46B2167F78EB72207417CE0C1C752ECE2D16663A6776D4297B8FA145ED72B29C
      308D2AA2EE01DD10E9F464A3A56EABE1BA09E9ADE785D31F154815E9D8015E1F
      E2102544FE4EF0565D42FA7FF2F4511DCA69058E9AD77196EB49EA8F54022941
      1970A74E5E494B1322B0578ADAB3FD479A94BFC788FCDD36C8B10B553FADD986
      7E7DFBF0ABD3A2BFAE5223C108A9DBA57B7D4B19EF56C9E995DBD32558EFEC07
      F08231E8CB761DA751CDCE6C9DBC3421594331DCA76670B28702F19734D467D9
      87DA0DFE580F88962298082023A4DC3856E1FAE42487C47D2ADF3D67490E334F
      9C08128E64D45AFA5D15024ACA6B37CD23CD781457B385F9109CD19D9CE05EC2
      5DCA7DD1BB9AADF7467A03CCBC7890DCEB92FBABD339FF68C80767E690F45734
      B02DB4F90B0152C636ACDBF57AB3E4566DC90A7C0B033E94F8206D4993FE19E0
      9F31FE19055BF8E7D2144103D51E5CF48E5935EE8F4DF72A2DA207A1B02E14BE
      3AD3DF1E1AEDA6599C26299AB3189F653A378B344C2729F95FA4B13737CEE80E
      92E2DEB7348934F8EB017B657F3DE83A3021668D2DB2658E6E36D4D7D4ED624A
      B40C4CCFAF3154EF5D1659B09C15E2780B323C9B2C0A085132096BCCB376F37A
      76B5B0BB187730B1B353DA22B27173F8C79C221EF482305D140F99884F66223A
      E3874CC4BA68FAEAC472BC4B74154BBAF6F08A44553A35339A31D01218EDE57D
      32896161FFD7FB7FC68F28A408BE0060E2F7FFF9F6E0E8E5E1EB1F82C6D96231
      2F9E3E79E2C7B213DB8BD4CC0038B043E2F309FDF7C9892DFA18D6E3439A42F1
      B837188E3BC3D178D008FE81914FE2BC982C7EEB9AD1698F92CEE724717ED718
      FF41C7AF200B4BCE1F7EC2D6DB0F744E398E7D356C8DDE2759B6D01F2372503F
      E0073B8B676736B7FC697C04A9761C5A7E9A1CB968F2BE4816B3F06F5F207555
      AB2BECCA41507E9FCE00CB635C9F496CA30C077AEB486B6A778F5EED3683D73F
      1E1FA23C6EBFD34483DB9BDA39BC3AA5830BDA78252014F481E014D5A108391F
      EE4B7E1CB9A549FA2BDE21A5B4F59CCAF3DB8A2CB82BD105BA0452D7C3C3D76C
      2ADA72D0EA054F693E286FCED0A38E96473266D018C28810C534D8C20FA76759
      B1D8E6AC83CF25D4CF97DADC90698D4634AB7DC1B5E4A00A0C4E4F0B49DB3559
      4EC90A4D17C03921BB8D060E187EA1922C7C257AB0152F392F6D823323BD93B9
      25C5C2080CE1F2741BCDA4F4FE143898F0D1C441139C6583FA8FBA2D90EE7A7B
      4CEBE39AC2CF382962E2184796D6AC2882BFBE3C7AE94BF715731E083E92B097
      CC02E69E1556DECB3401A40E48E3E6DC3FB4B9314B4F67AE75D615861D9EBCAA
      EB8AB46845383C5A01CFE0560506D52894B181E4561A6BC346B113EC4E8AACC9
      364763FDB30D3838E818147150B769BFA9A41115CF19A1566C35B73A93DA59A0
      849F4FB25464849604328CE6BACD45EF7CA73CD37B664EF6A6C785D342AC9980
      C3709391558241D42E6E6EA0BD284EE1DCC1B2A18DDDB79A0DE04F333C201F71
      64110B40BE037505C7E3DE84621ED26BB73A3D5F9D87B59A39418E9B35B9B743
      387F0274EE18EB343705D9584103E8CD8DE0DC5E91DE821EAFD9AE22935541D3
      71485B75133D9C37ACCAF93F3470F290B1A99F30F8EA9CA07B08C5E66CB65EA6
      93096B7057E96403D8F61F685A9CE626B31F1A3E9737A60B7414935ADBDC008A
      7D46E3BCD2CEC7D09EA5B3DA59FB6ABA75FA30DD1CBC8D36BB088A38B77D5BA5
      F1ACDBF09DB3D2EEB4D9F654C05AED06CE92E0880C2E64AE04699FE199D8ED20
      FBE4C803E27AA4428E104CCC958471A5C616669B58EBFC723623ABFD35637BF3
      934B58DDBFEEBD3C7246FAEAD269835EDD16CF2D5DEBC9E646BB0D77AF5C129C
      78D796225896BED658EA74ABEB37C9B2F3E53C88971C97E0CAE3584F1237A0A3
      C19AA12D97B3DC4ED23A2A21E7C20C69159E095B831611BC73E40EF0C3F6B54C
      D3CFBD00A05E4DE702635E7C94A0A1D02B12F66AD01E4E9C65505B67A4DDC69D
      DEFDB1DA301414CBCD8D12D081FBC5E906B26F2279A49DE058825FD82EA5BC34
      135770CD171377B82430D7536B39B446EAA8A8EBD96CE186FEC801402075E882
      889082CB85DF0E8E5F719FD84EF0CC44E7A71C4A29F1DA27E93455200866BFA1
      FF7AD00B5D06AE3DAE9F29EB9660C86A4A028526F8FBD2160B277255C4DBCD8D
      0F8BDC087E875EE12437A7680494DE2792ECA175544024953F7E606A59C5EBD5
      5E6B400B72C041D4955E10EDA500AA89C029F055419878662EA60C57B743D627
      5D8677C8AF222E8EB0532578013FC826092A3F2EE896F8EB82109D8434A4E5BA
      6E4BE3160606CD1B35D9B02E7256E8246C6E9C4A5328ADD97FF01F77B5071B15
      BF2E32595689EF04FB723510A06EBA1392723707D028D25F6D5C2E8FA2FE486C
      04FD76755D1FC4EA7ECC529AEAC9D5DC2AAC2AD94C88DBCEE796ECEB9DE095CC
      B590FBB17213FED7BB663FCC705B78CE0F0EDABA83F6D539B74BBBBF4BE7F81D
      6789AE459E4535A2CA44E561D35D4FA73B67A015061C0D62726CB8EEA1F43511
      F7C1BB7EA1EB8427650190CF85642B3C1C380F05F0D9B5CB1BBADBCEA6A09243
      A9D5A4953882B3A31806868C8153504629B279CCF4666E9E581F7EFB8E4B78C4
      992D78853637603854385FF4C9AE5049B510FF46CB2731E00CEE32ADA49615DE
      1BD1F2509177934CA909D551BB0DCBA101F3995C5A39B70D496085D9071219D1
      59964B7C20CC164058074E27098CBA5D7D7391A540BD10B31E10671180319074
      77B60D09B32CE0AEAED886CB53844EFED0BAD86FB5686DF450B4B67E7BBF3A0C
      E7E6C64FD06B0BD412383A44512F29E2B02056154A0B4B8E0DFA5DE8DA3294B9
      A323116BA164A96132599A4E0AE0A6D7F6C3923D86E385355376828AB34C813F
      C928101E50539C07260406310F43751F0987E5B4A6704E6F15FC7B4BAA6E1C8E
      C9B6C757868924A9B029692DE76B8B358419BACEAE7D72B1B35998E5B360FFE5
      5E3D27DB00AA829A41C1E17EE3A6EA230D2DD56C022718B8E6D07D77FB8DE974
      9E8CC347ACD92C76B5B41DD75002EA156620FAA346EDFF2518B55A7563C3E5D4
      82E5D8AFE7518DB209BB19B3D85156B8AA2892A75C135E5346A3CD8DC62A14B7
      874E509ED828854D2066BF5292BCDC7DBD2F3C093C61FAE1D09FC32DA17C5AE5
      7ADADE09DECC2A741E8A89217CB41FA49952386AD25FEB4D00E5F9686F44F284
      79C0BC3B9ABC7EB09F3E693F0D1FECA735FBA9F7D5E1875447BED39C5F9C9A49
      86744B08F262256E6360BDF6CEA866BBF7522A9EED93D86AF1B30D968B64A485
      D20857E466564CCA2A70AD4D6D4AE7F0150BB2E9546087484CA1FEE778911F6C
      6E300B61EE8A8180E8A301DF4586DE70058FACD97A28B812895ED1A84F7C7017
      D482054D3A8EC94A704CBC0F02EB93026BF020B0D605D657C7C37048366FF64F
      70A74921B38916075B8B3C5B8628B9E148E7BEB99C9D2E8124668BDAB9619E91
      E9B987F40722F6EEDE81961C4A8B6498CE19DF993D170DC11EB2FF5AB690E6A0
      BE5BCF8C0B32BAFAC364ACF84E8A1B1E2955FE65E6505CE17A02FCEC6A7D09A3
      DFD378F143A5D491612F38AD5D8183203B75DD567BE09CF9B4ECEB3FC8BE75D9
      F7D511255468906302FE04AE6A00F7D2E1DBFD63C70E2192A3665BB7423FB77F
      009228ADC8D87DB9F7BD704137F6ADB47FF3FD458C9D4479A36E82BBAA7D2A6C
      060503F8E5967954147687DED3C19D925643FAF78D600843C83B798D9048C6AD
      8A48AB91891D48DB623D675D91BEDC50C9D501CAEAE9A786BD6479CBA7D35CB8
      E590F9D57662D0B680F1ABECCC2BC1157FCBEECF96635BA009B37CEC6D73F694
      D9935DF90C903267653891A94167EB1182DACC9DE1F19CE3374D0BCEA697D486
      751BAE805ADFDA3F7AFCF6E0653D8908DE72DBC8E3906122CA58527145169730
      643684BA597A511AD24BB9C5B9C70A517AD580017D1188231659DD046443BBE3
      6416751BDC2EC9AEAB5F6DF0323B9501221699E7E40E4FAE4AE6D23B1875E773
      47CD6334F47E3F6A9E47D209B24F5A3DED5EEF7F6EF6F0873FD7EE492717939B
      3D3F7ECC1FD5AB757E95A753CFD43BC9EE22D371673BF5269CA41788341D2D67
      A87A97DBFC36CF902C048BDEE9C721343E63B168BABF0342E3E993279797973B
      33E434C97D2C189622D3513FC15F9EF4DAA341F70F41CCF82D03FAC73FC8617E
      00C878F0A0EEA0064B123A4AD78E12B6220BB20430D6CC92214A8BCD3FD8738D
      3788003760EA8B527E86962164BB9EE4D6D0D343B48179439186D40C8EEDDF19
      15A21968809AE3CFCDC02EA29DBA69EBE7CB0990B1E73042CED1BA2E51A53C70
      413576D14E1EC2259F0C97F41EC225EB97FDAB63EDF928AB737250F21B908300
      1A303AF213269F8413A1C5403B8B0F5C3A2414B20C859E911F7F7CCC7842ECE6
      3B73BC66BBBD8AAE7381A617AEC3ADD049D179FD8F77C727F51C3893A20BAF1A
      5F7DE04E2CE71C4C082DE0347CF9450598B49E53D9E548D034E352F3893D35D1
      5570F47AF79506DA112DF9B39E308510D05784D9088122FAF715FEFDE960F76D
      936364A4640E8F6B5A5FE550996F1EBF8FA8F01C57632ACB5961122B51B0F955
      D994E6BC5C860F82AC95FBB95DBBFE341056FD12BCCE3C476F9604FB87BB2F03
      B4E0CD6B1742F1A4082227AE53CE31318F398DB3C904E045F48020CA4D81EA61
      70D968B1A4A3C7F676D4FECBBDBACD15DD8241A36CE86F28B50D4057D1D6AC06
      9E32F470B032C926D00C69A205A4B00E61FED54DD6FBBA24B4A2937ABD2A9519
      6DE187414F434B75DB92EF697D83BD93A3976C6AB2DE15D353FB17818C8B0398
      9446E983E1F949C3B3FB6078AE1B9E5F1D495515E3AB2A31A94355C009974056
      35F648BBC934A6C5D387E8E3B5DDAC47F4F12524839839453338848025677F6E
      4955D669CB68784F5747D70CBE07D3F15B932FE8E7E726BAAB62DB3B1BF39189
      ECD3E07B93E634C0832B5BCB85DD1390729BD76A544756EA1B6B3528D41F06E0
      CAA9D5A87E70DE56367B1AECE6D32C270FC59A398273BBD369D6C4D57E50A675
      53A61AC581E3F284DDAD9F38626373944AC0747CB77F2476BA746E83FFC8F11B
      93522D0A732A76A5E0F990003717AF040AA3669BBD16ADBAE69E153B0FC6414D
      8D83676FF74F986F068180CD0DC1CE370E949B7EE5689C78D4DC22C888BFE4A5
      CD167236D3841B6816C1C4A06C952CC160ABACE792A7B1878407DD451AE12E0D
      0E724C1629B05504FFAC3A6AFC9DA61BDB0F5F3E98776753429C34300A0FB38A
      E956CE8C2755BB51170B3E3BD737825FA8DFA07D30C34B6586DA989D73F46F3F
      BDA0712FB2BC6E89B307BDEC9C5CF227ECF3BF06F3B36C66514D7EC99A583328
      122ED40AAD4AE563DD34EFF57AFC62B5BA8CC78E84105FB22D99DE94E4F184A5
      BE70E28A738FB7FE59DE57C2CFA92C6158C4C5526C13928CA8B64FC0E05E3F3E
      4C979811B6DF023C268FED4CB0FD19540BB09AF40380208F0FFE43A2AA5B684D
      008498F288BB00B140A11A944B46B6AE53F5A248AA0BB9FEAE86288952B7B9F7
      FDAE2B77E413E8EA3705F1E3CC4C405045674DBAF8907AD94710E0159DB52BC4
      EBEB39AB7DC71EC149144DAA34E58A1921055190A795DBC945AB9A67AADBC45E
      671572771E750397E41CDAF912A048F84DE029692A8DBA0DDF6550B8869B4623
      3D37688374BDE3E98C51E450FB1C97A0FE7519BF96D63E4F27CC124BF77A4FB3
      5752000A505F6633A79D90A8BAEC54221F28C85E452FA9EC1CB66ABEB9C104F1
      6F7E40FDF7421640DF2D4BD064882B69D312DC1185C16256980FE9C2E1659DE6
      66DA1434926B5FA79E2CF8926D5E4310615DD00A7E8073AF6B7A0F8F05FB4D03
      026C5DAEC4159E707D394EC0FF9B64A75C09B29C670CF95D3B0612B152A629F0
      C7D13BC887930F2FE9DE470B6173466A7373E351A1794DD739989769437FDAD8
      23157E16CFDA238837783A8E2D3F9CDB2DB9169DDEC1DFC1CFC3173583F972C1
      79D35935AF9A67D9C2E555C530742FD2BADA68B9E0A7B1E9400FDF7225B43BF4
      6233A00DF9517EB28BE801A0EA3372819D875CE0BA9BF4F50946A468FD589A0B
      EA264940C25162DE4A2181CDEB364AE92921BB2364783E064342EB23366F01C4
      1AE0486679ED680A8EC8239E8624FBE659A10C0B243411D1B0A814822C9C1A46
      69AEA3E954F6A64BAD86628DB325787C96268BEFF6C3C9DE248DCEEB36F29F77
      27935F829FF22B0B0EE23361E043265E31DFB6FEB17ECB3B7CCBD7C7D4FBDC41
      6D6EFCF38E2DE63BFC45D71EFE7B45C836CEBBDA90E25833C5422D0FCDCFBB2F
      5FFE123C7F797CC2ADAC014625C554AB11D47A8EFB60FF703F300C7F5E94805F
      3E465DBB414BE0A2DA67C0D714994D3D2F93CA6B25508ED113047078275B1725
      584E4DE7F978F2D46547C09A3E8530859D16143493E84C00E632863515E8B195
      D9D69228BDD2590DE724652A41DD3A099A71ECA6529FFE0445EC5CC3CE3E8AD6
      315AE035265EC06172B59B2A477824E1FE2A8B7F20A3F5F0D59B7D17C472C893
      70252F4CCE0026BEC3BE7EFBC69379FB72BFB30A03708DFC874537592D7466EB
      3807C9A80B1F826488AA48E04C7E958075A4867CAC3F3B6FD145EDB34B14E79C
      A57377A4A4D3833600DD05351EFEF12CBBBC0A2EAD61B8B16A3976FAA19A0DDB
      CD1767D32CCB1F7CE14FFBC2EDF1832FBCEE0B7F757EBDB4AC5C5F2F6DC1F916
      EF9313159CA7007297560C3C1CF84F1EF807B0BA6B07BE067C25CFC129B55CBC
      FE910F335A4AA6263F57322E87E1962641BC9C93AFC14964E91DA2DB70014221
      E03A731D79CD7657C8D7B83B48E2036003E44E8E4500A8136591AA29B27603AD
      679044D2E85C343CF2E959B69CC4153B4E5891788BECC2A493E022C5D5E31814
      7C2DAE0278104F9F144F0F7872D7C4D357A73ED9DC881932338810C543F79871
      68EC9AC771F5B37CE88510F42C13D254EEE4FADB723A57B404B3A827FCD23541
      1539BAD8B9CDCF9D9842A104E671304366EC6D96CEEA06C2264EDA313B698C22
      C3AEB2FCF5BBCD0D7DE52DE6742073628637D4190087CC048CFF1983DE8C033F
      20C370D5821E640A8FC4BEFB66492EF5A9D94AA00E64E5D0A2C02A27ABF1AADA
      E469598C5F06D9DCC2BC44908443638139A561D76C4A7248D3D9634610742305
      8FA363188CE08B0B2B71060CFF853B058882B1AD9042F0622A28373B45E6DA44
      E82DBB4C37379822C5CAAB33400C4E40812A48FFB5332D5E3116AD94C1F3F4E4
      0F470A4C0B852B15AE1A3302F8EF4F52F0FFD4417BDB0FB46C2980AECDA4E93C
      0B3EF7117DF20100F6A30ABBB3D3DF79E82BBDA6AFBF3AD911E25C05D8FA6CBE
      B8090331A2BF239F783D6EFA70D06F3DE8ED8783BE76D0FB5F9D950254EC74D8
      9F06C924130EEB392C32567D264F0BE17380769FA016AF912C7FFDF5AA017ECA
      14E85DA840CE6D8114106E034A62D71E44F30D6D2E8FD087C275458193FDFBD2
      4C1843875466B63C3D1362645704A98631736ABB24BE89A2650E9C17FA5D8D93
      AD5E105E2DECF6FA170BC3E60ECD90CBA5B8CE0F80ED68FD89A4469CEBA4F863
      8598D5EA93828E54472743962802FFE5E19E7FF29EB7FEED2BADD1CDDD69BF79
      8DBA83D5EBE45788168556E8339CBDC6919573AF4E9E24177776761A7FE0CA7C
      550AD6CD0D7471C30866383FCD0A4B635DCA24E9E9A9648B17B9B5ECF43EFED7
      E0B665D355BBF165B9D9125D6257CBBD4822C2212285163126261D54075A9A28
      849517247C579C81CBD3B842F1C03D8453AC1F2442A45DE9B127D9C533B65182
      CCBFB1ECE2EE8D407E133A1B0E3BB22C72B33861EAC2023088C972E2EA97D9B1
      98D276A6A00D23CB7B899CF4C2D5AD938A9C31738ED8EA8EF970B958E6B6C9F8
      D8664223B954164633B93457057C9A0B4CC96864D313376ED99DD39D40EAFC9F
      BFE9BE15D4271296574A518C1766F446ACCAC4CCE7FC465D58CD84979D943ADA
      66E09A52A6E61C3E03AA503737308599279F23EF91BF000E03B6C8D57E54BF00
      5E34BE044F11374D58F7680E953691F5EA9FF0B6631BAEA2A67E5AAEED1EBD3E
      7CFDE2E99D97176D6E942111AC60E5A41AAE7F2E78196439E55CF34A6AADFCA9
      F03DB34A12F07EB86C52C04ECB7A2EC758B824E5117C7C96051FA4B4707F4540
      9CFD3CCF71C2870F9F8E2DF9F0E4A59AF55D9D59C1A83C5316EA295F355448F0
      8500B9E09B2E6B003DFC00E695F32037D3D30F16AB3786876FA406DF21B79096
      A71B08F5EE0B0D77E9743757C947714A386A8F0549270EFE9ED1442726873488
      63EE203097A4C21B0CB65E59327A5D2BAC4147B59CE3A7DE8B6772D6F2A5E0CB
      2F67C86C9B60D00B696EEEAB69C37EE2A2B007B3FF53E64077A7151CFCF5EDC1
      D1E1AB83D727BB2F1F7C80751FE0AB133D6D6EC87551E50AD31A612B144548FB
      C6B52472538D7EE5A59842744C33254B5DD1BC4A3D0FE0A59824BEA843BAB80D
      F935E2162715470DBE9C06B7EC8AAB63E8DD112411D9DFCBC8B540CD33F4F2A7
      E875249567B5E2F7C27A3AE0C61EE3F923C07AC02D6C0DCF5C54B7D294CD8D4C
      1539C71D6715F94297BD0A4EE1B5EE342B160ECE4A394C76C4A4985A33AB580C
      2CE40A6B1DAD6D011A039272D574A87F739CC66867E117AEB8D9A4B09324D842
      D134F66E16941D23C5B419EC1D979DB85C3CA79E938B0E43986F6EB048C52CC8
      B238E4E2540F3C8917A4055184BADB216DA0178C47A75258AE3F9E6502554A13
      C095985AD160FC5C367EAA0FC785C27A1556672BFDC185D87CA4676971CEAD9D
      CBEAE3B9C5F6CA77A349A9F2E567294E7FF5EBF9DB4F56C6AEB43412037F9C6C
      6EE0036F5F1CED8BA16A4D3E01E4B3630BABD9614487829F8A430A4D633633D2
      E99D611FDDE5909F2D4F51B9C5D17BF1EC35B91C9D6569E46A3A432BFDBA0EA0
      41EC909A4D6573E3840ECDBB9934F7B124D41EDD7253F44A8B81F5160905328C
      F6BE3F0A7E6EF1FFDABD5F703C0FA475ECAD6119511A45C7F4497DED983B2368
      DDDECC597EA24B82AC53F9885A4AF4453BC18B54C2336AD5CDE54B5DEE1E4DE7
      5C114BF74256B964FEAC06547C6E456A35C580E4BD715D6A97593EA10F713028
      4DCA40D01C7745D05B2A5CD6581D29C695266669F4E0E49B1740F420CE62C44E
      2F3813BA6E4AE0B67DA7FD58DD79167288A3F9E5E49A7FA86AA9A4676DE116A9
      293270929E4B2F6043D08383478755CD2B099F47E45A43CB949A3288B3FAD570
      CB1D291B33F4B2634950FC735904D52C3BC719C9AD429E595D075946B2BB20CE
      224ECD297E029F567D6B6CF58F5859F6A7E4C4451394BC8BEBCB5F4CE74DCE6A
      A547F9CCC472F8D0505C94ED170F0EC22D0E42E7210176DD27F8EAF41D2F106B
      38766DCB5B2F5E1D9F6CCBF5C16DE37E792FD28B6C72C1AC6E68A9C8A43F3ACB
      0F3737F69B1C5D137D5B3761B2AB597DD50E47F6544C380FF4C135B43247F67C
      C47131C173240CE4C30F97FB9397FB0F4D067CE590F749353CA5F162EE54999A
      BF2959A3D3AF66922EAE34705B71BC43366891B6D2A28CB4B88142FDE1D87DF4
      D8B5771EDAF3AF6994AFCE112338262EF49DA4391C740489CBA42B290BB2CAD8
      E561B3B4669B58CEC0041D7820ABA3E7B23133E1000D88E60CF0C66B3605F8F8
      BEDB1645F0A7597E1534BE4F63720AE01BBFCAE2E005CAE21B8E95824CE8D02A
      6C0EEBF79A4D89416A1D2B08CD40AD8FFD8024EE6B583172DC10A43AB58B4A18
      007F9B494A850E9BE1B6CE92B7A866B3F4906973DC52E13F796BC8B37F91A7B5
      ABF9DFA575E4E45E633903FCD6ACE1829070A338B820D5195A338BE4931A948C
      BA5AB3E96C6E1CAFBB9C5BCC61C71C1A29E7C8D46E248FBA384FE74D041DB5BD
      A419ECEC6C6B617054CD897360A671EC5DCD46D3FFF63A9B598986370E11145E
      047E048D9A2D8E6146674C6D29896BA91B75BD35AECC394B923442D05E1BA76B
      360B09243E8592DADC50211FB160BFCC33E4211D6E18994365810017B97A805D
      0905A439AE28E2552E2C6DDCE1D8E2520359996DDE5D0DBBABA92807849F56B3
      E52153C2E6E8135F5C5A735EE6222C92BB6931555D2199FD0A9E4334C19F7CF0
      BD66B3DADC60DD9178B59E5ECB51343C0DA544D5989E2E97607823D8A2C35F04
      7F5F227E6A8250CAD44CC9DD4E222DB28216095B617B27D8659C568E45F9F475
      4C975DD9B7685488D3E997C5C1B3ABC60A179E0B3755A8945D197ED9199F979F
      0798B5AF09A86983FFAB525820E06BE6F30952538A5F2DF977576E1BA579B49C
      C2B48AEA189D5C8F3E729B4F9E5DBA1803DBDE41818A1C5FF5C43115744E004B
      9F6B0A7CE4FCB2285B09B8FED1851D0495898B850496636AA7D94E709CF9021C
      E8556B8A94FD4613976CE6791066D979DD6E22F20857A8F83C0D0E1F5D7073CC
      69C6E1541342E2FEF9A18DE0131EEF436DF5358FF7ABE376AFC65021DCA43B26
      AE5445D045ADD9C63D7719206E6A8395F216E96E2EAFD8CB66B1A20830902E69
      9498A7237D52B57377BD375B045B6C998A3861493A01076ADDD0EEE16AB8987B
      A5F0E3BA4F2146CB366F8354E13D91366BAEC533C1CEC2163D28180F3DCA15AF
      3E195CE06CCEE14032F92E534E169AE22D197AB7D47A7710574837CE4DA1717E
      6D91F3E850755BCCB7CE90CBB9029161C6ABCD3C583789E6946BA3A0D76554E7
      94ACB307E5E3BEE33FC9BEF801C605B410FFB64B07701F80DAF727CC4FD38691
      C28615EEC0E55946C747F532226CFB1959A9649FEF90F0B166F1A7E07B32F040
      B679A575B8AB955AB720944337381B57EB74A5BCFC43599764AE5541FF5E80C5
      C787D85F4CE670CAFBFA25AAA0E7AE7EABE95B73B8C548710BCFD808B6418327
      AA0DA71E3802E266393B93BAF68496FB4CA2976F145A15AF3B25F659F5B9A64D
      564931E9F4C7F42FACEABB3B8ED74E5FB7DD6F0D57974E176CD8198FC7DD9123
      9EA265FFE7F7A893B14C99DB6FF5C256B7D56BF75AADD680FE7F24253F1DBA4C
      761CDB56122649A2654051ABC3FFEDCAEFFDB0D71D24033BEC0DFAF8B79FF47B
      C3F1B035E80FBBFDB86387A3413C884C346E4761CF46DD6EABDDA2370D7BA324
      1A756DBF13F7CCE6C6380A3BF4E5A34EDF8E479D6838B2D1D0748651D48A46E3
      71A7D71E44E3781476CCB0DFA7C10C7B51DCE9F77A1D33EAB4DA8341D489E271
      B79B0CC7B61BDAEEB013C6EDA4350CFB51773C1A4766D83326493ABD4E87BEC6
      86EDB037ECC7A61F27DD612F89C726DEDCE80F46E351BB6DDAA36E34689B7E2B
      198F925E68421B469D5177381A8E5A3D7AD8D8F43BA63F0CED80E648E3083BDD
      7864C7AD61A79D8C5BA6177712D31DB53A51D8ED0F079DC1A895C4B49C368A69
      E8ED386A8F6C484F697747B61B8D7BDD7868FBAD6E38D8DC085BEDB83FEAC6D6
      DA7E32A665E8D9CEB815D218BA4977D0B326EA995EB7351A75C36ED41AD3C2D9
      C88C92718FD6A63DA0B9D1AFE1B8334CFA1D6B7A1DFA16D38EE2FE38A2954AC6
      ED71D8B2A3BE1DF4695BDADDBE19C5B6D34A3AAD7014B53B51376C6D6E60B1FB
      49940CC88E6DD317D8419874C3B11D8D69F8613CE88F075118C534DFB033B2C3
      A83BE8DB28A261B493A4DD1BB4927E37B1A37637EE46110D231C267256129C1E
      3A2F1F3B67B41BB40666488F953FB6C89C6FF30FA19EB464D8A133160DBB9D84
      CE95FE3CC2414A0606278BC63FB4C9A81FC6B48CED614CEB4D336BD3A9A29D48
      4C7FDCEA75B13DC39836A4DD190D93C1A8D36987319D084BFFF692CD8D88B6B5
      65C290D69996DB26C9D08CBB71628D1D85C9D8B6C73D8BD5198C8D31AD41D4B5
      9D1E1DBC281C8C6C7B38E8C67438133AC1E351DFF4CCB0D36FD170E8F0B44603
      FA5EFA8E100738EAB7E2B6E9D232C5DD763B3424BDC241B735EEB73BB40BC968
      148F7B7857C7D85E67D08BDBB4C3ADB84303EAC761B737E8747AC3C40CC7ED61
      BB9FC4433A79230CCDD29AD1CDE826FDF6802ED6B03BA4A9D8516246D13849E8
      D4D01A45D1D8F692A84D9F4F3A91EDF76853067465C6BD5E34A097063402D3A6
      7B95D86EBF1BC674A64783BE3171AF6DE356D80FE9C4C5832496BDF99C9D1D84
      C3F178D01E8C54628C8C9724FC3F921CF40D2425FA9D447EDEDCA8FE869F7B31
      3DC0D2FF0F49AE749C54A1C944BDB8457BDF8154A13D1DC6A63D1C8E5B240D68
      33423AA6BDFE802E7D141A1B86098DACD71D476DD36B937CA1151D2774AEE906
      DAEEA8DB1D4636A6734C5726DCDCA0F9D00FB491516BD88A4766D02791634723
      1CEA21C91B33A47D1BC5A6376A47B451D120B2F4CC365D303B1E8EDAB4E2616F
      44172D4E7A633A96DD3E8D8D44059D413A1971D88FE34E2B1E847D1255FD4EDB
      D25EC471DFD2FDEDD1412151472318F6877644BB49C29B4E19BD4813A10D6D75
      BAA3DFB2FE3DDB4E7AAD78C8271B2F856DDE81F6E0B6F5979F3737CADFBA6DB7
      E6362289928C705B06ED5E687190BA496B14C724DCC270607BF46D611845EDF1
      C0D2FBC721CDB417F57AB6674676407760407B361C9028A3DB3924C94A73EAE1
      AA74A236FD37EED2DBBB2411E384CE01DD13BA65F4E57487135AAE902EC360DC
      EF467419E3167DB6DB1F8F49A047C3382615D02159D7A1DBD7EE9374B5093D63
      4C322C26A99244716F341E9A248E5A89190FFBA31EED392D1A9DEEF178D8B1DD
      315DE1BEA1EBD80EC7DD01ED2C4D30C16D1C1ABAC266400AA71DD169EAF67AFD
      F1A837C669EA90B4A5E1C4712BE926E168140D07C311E989EE201AD17E8F21A1
      5B66D08E87ADAE8DC30EC9E9317D432B325D5AA7CE9896AF354AEC98C40D0D86
      0E65C7DAEE603C6CB7E91D035AD6369D83B833E8C4F43763A27EBB457A946405
      49ADDEA803B93526B1D1C6F50A3B2D3AA224B9685348BBB50C1E4337BD179128
      8B06C3D892761B846D5A4D5220B6432AA4D72375381AD27D202D4E03EF0E06F1
      783420B53BB22D12635D1B0E3BA41B47A6DD69D961D2EDD9B83FE8D351B291ED
      404F753A31A9F61169C83819740C09DE717F182524AF48D593DA4CE8EBE8BC40
      6C26246EC724132D5DC471DC276381D41CAD207D32A2A34EDB140F0C890A9360
      4EAD6EAF6DE840987EB7432E5268A284AECD7838EC760D5920745E92B6A1234D
      07694C1604DDB16E274C6C072B12F5496725A30154F6B8475B1ED25F492DD828
      190E690F4971F54212CC261992E9D2A28B45E602CD867602C727EA93E942B79C
      7424A99021ADEC982C14FA0389C20E19992D0B0532B2FDA189935144F7D70EC6
      ADD618F2BD47FB1F75E9E324E7E950D1528EFAA30E69A7111DA7B047CA684007
      8C8EF680F68B044834B474F9E912F6C6B414A4F03B64E424039C221204FD56D4
      EF5A431AA03DDADC68776924096D272D6C48D76B64FAB033B029633BEE8E4915
      8CE8F1497F4827AA432B4EE29B741F49EB51A73D24E180634D77AD9DD02AD122
      0D20F0E914D3185AD88F4E6B90F46D422B47328C96C0869634CF8876A33724D5
      176D6E7423A86752BEA4FCE31E1D66925F23B2D3CC7860923E29141A7B62E9B2
      19334EE89824740749B426F46152413DB20C93C8D24D19D26189437C646C466D
      12B49D3EF4243D34896D344ADAF425FC5B97EC20FA871417298B3EDD05BA3CA4
      77C914A58B403BD3E9C7111D82982E481B4620AD546B34ECD1BA9304A631C724
      99492FD03927F38E74272D428F746D149139D022A5DEA7B70D424CB4D5EEB561
      B5D27126D54A32B3455611A96418A4310D8BECAE8484159D835144F650D42643
      939E4D428504E82822413F188523B23842DA6E32B2682C64DE8DE860D3F049E1
      B6FBA425E2B8476B47666F8F4C82A4439787A418C9A81699C663122AFD283164
      040E48FAC0821B59321F47861E14754831B5C9168B7A240F46618BECD27044D2
      79480AA6D33264E576C81A8A3AA459E83D03FA0C6D27A97A1A5D4473377D43D6
      413C26D1439BDF211BBC4D438B489EB649EE8D4853F6DBE32EF49219917219F6
      3ABD1842744477900CD82E9D8F8864354D22EE8E4926C2CC2509D11919FA2E12
      A8433CB81775C8682105497FA58B685A63DA0ADA753AF374BA86B44AE32E8DAD
      47F65B774447AD632044E9D0917C23438BCCDF7E3CEA750D5D78D22271CBD23B
      69CE24B43A24B1C802257547A632296AB20FDA091C06329C2CEE331F775C1DB2
      64E8FFE9BCD398494190C88BC91A680DC93A8D7B318D331E75E866F6C689B130
      4C7A249DFA7DF20E42529564C5D2C9E8928D680DA4D980841D597324A8C97C23
      337CDC6A5B7A1EB9BB74176885DA86F472489B44B6234947FA91643049B88404
      30C9B23E1D875E9F6E650F578D7403DD99D8D2898F0649D435B48D219D73DBE9
      92C84A48DFD0E9A061D3E0E996C6E1A01F76E96E90C8B3962E4C6710D3D54AE0
      79E0D02434026B5BF41BD9CD249C45FA92EC26016DFB34095287A4B392714276
      110D6818D1B3DB246C3A213D8FEE4ECF0C86B4672DD2796332D7A110C82824D1
      D50A6DCB0CC979E80EDA64BDC7E4F9D0B921E145B78D9E9B74DA5DBA00ADE180
      2412ED5D48D29ACEF198D40CED2E5DDB2EDE496F25514403A5270E127281E9EA
      18FA36728568FF6263C70392E0A47BC7E4D191F820C72B21E72784D626814106
      175D40528F746EFB219CA6219926E30E4D8EAC50BA29C3568FF43769A6381C93
      ED438BD3A50BD46B45B09EE832918C250B99D4084927F264E8C6935E22214F47
      B1456603AD3C7D7B482736EE934D84A34A2297040C7959F026E13A91253324E7
      724C965C9B64BEE9D3BC691E6368A4308E22B2CC230BAF8D4C1D32780683D6C0
      90FBDD82194082BB0FA3946C22D2C9A443490018D2ED74DFFB5D32D1FB743FE9
      42D2F127AB88864C86C6800E60AFD71A9075DA27BD435E2819DBA398368EFC46
      FA6B9F1413897952E5A44EE9AE9126A7C774FB348284BC58328EE99DE4D98D0C
      594934435A295A3C1A3E9902B42026A4B1E15324060764430DE9EBE84092AC27
      4D600D6D679B9402BC8121DDAA88C4746F4097D50E92649490BE2137977E237D
      4A1E0DAD2EAD5E67DC356488C7F01BE954906D14B1402663875699DC4492993D
      32550DEE66A78FDB138DE8220DC836E8D25691BEB1E402D1DED04B7640778A0C
      39924BFD61DC351092E4D8918733C4B131637AEC88D408ACEB21D9E3741C49DE
      0EC9791FC2C6A05D80474BA2061A906E7F871C66436322ADD16DF7E8B996EC8F
      CEF8FF6FEFEA9ADDB68DE87B66F21FEE63FBD01912044071F214DBF13853DB49
      63B77DE90BBFE4AB5A57BC9574D3DCE9F8BFF72C485102494058F8F623133363
      3BA27641ECE2ECE22C288248AB1A640513389231480EC21BC51908E50A630517
      176B91D7287E24E6E5342D9A044EA75217D319FA4236B70AF32C524AA16A380A
      5403EE4EEA043D40161105E8288639553293A8E451636388302EE064BA2E89A3
      A1266B10E7E07A401A55E748F90DA624F2BB4469873AA3C832D40215E6BB5200
      5AA84E90A490DCAB340161C11CAF908A1A8C439523346885022E93A8DA1A622F
      09D272B14665A490EDD033E49432AD50AD8237507E48AA5A802B4951810462B6
      6AF21C7419C919352F320E86ACA0251C622B558E049902BE986930CF98951154
      24F03F2A295484300E63898EACC970E289B8242610D495BA5981BBA25A929006
      BF11200D18012D51D0A635DC831C08960C0E91E7C81F38A131F6A03735AA5405
      FCA224C3C48F714194637E6DA99BE0712842D2BCA88DFD4D85F98816B6E08386
      A6B806484412AE91CD5112204B00B1E8699D26A877AA640DC345912337672D95
      80C4A230BB352D02189483620D352FC8912E300D023B883F30B6AA552813415B
      69D181DC5D10B45B646F0C1B6A270A1AD43D8DA41E000730506362C088956B8C
      050805680F581A92309C5F3465A9D62D524F56A2E51CF14575355084021F2EC7
      AC50823369F230C648217154C84B394214653CCE21C900C34003ECA74906B004
      A034D26C0D22050E8CBA11BC06332CF44079302DA107F06168B5982069154941
      BDEDABF4AAAF3445EEAF16CFAB33981BAF56EEF6FA8DA9E18995203010D122A7
      E592B54606A94AAA7880A766B5821042870AA55666280CA94042599CA2166950
      265245B302BD422A433E688B02E4B62A7270C002E40C41D5B4484C8865A001B3
      1104C0ED0BD41898A756609DE08028C43103AC8AA6C830155470CD0A094023BF
      B64D0A0A53A0E0152B49059944E983AB65A0E139824E604205050747012B976B
      702404140ACC126C0A958E14A2CC4AD078D46E5583C90B8508A216B98D96E540
      77C15381628D01C0FC8E592445F7154A0A5AB5811BC0C35685063E314DA2FEC2
      0083AE22958032528E2A69F9A1469881CC9514E9B246C5A20027201CB4A71F39
      6BF431B78B861EEAE4AFF8FA8ECBD560B034E77AF0B53ED06AA06F2D70E9C892
      5EC646E21969D7AE796D9D6AE940A8085F545CAEA12C47C2B55E5D5BBD593A30
      278DBDC2282CF46B6965E75A4FAE6586C59E207C7DFEB95CD30DCF19A6A72A39
      7B40F57FD4B02A56D74979FAEAD3D75FD1CD8EBADB76FB434DB73CEE861D8750
      55AE879691A7E94A7986D40AF4A2A612E417947F025531025813AA25BE456949
      DF2A4CF7125567B62209D4FBD2F498FEAEA905F815527941A8475BA0F5E09D25
      DD59401A40AECE513E5015034E91F47D40AC64F88EEA391400B9C47F0918D65A
      D02245367806318FE2689D9B3E0D7A5A930FE93B397C2B2853A0CE123897F77D
      365682C865881294866B92D70545A8B1101A597F65D01A584E364950ABFE9CD4
      557FCEC889514E8C72629433E7D036F5D9DC0F1ADAB0CE9C650C3AE99C9849CD
      5BCA6632D94C46CE64E44C46CD64D44C46CF64B49159C1E3E4D1AA1FA7D327F3
      1D4642D7D296989C831CB03060927E24B23B1E8E8FDBF6F0B7EDA1391C3777E5
      2F59AEE9C3B6AB3FB64DD3AE13F3557BB7E9EF449ECEF43729E997E2A733FFE8
      7F3C7AFA78BFDF74FBCDF1119F8BE25FE726FBF744DE5C68A43797F2C9CD5936
      B9796B7619FEC6295D58D2B76DFFA387F49BAFBFB2BBDD6B9D3B9DBA3BB0DCA4
      F8E6891BCC9EBA41F9F446ABA7EEA37EEA06F3A7377AF5D47D2C821A3C696D10
      62BF0423D8D60A03A9AD1386435B4746E8A8288BC20063EBE4113A61836EEB14
      81169DD091D9F038763586F9331B081B714F03D9E71B1186064F036169C6D380
      FE7C23C240E369200C419E067869A29F186FBEDFD18627CCD05A77DD71D71DFB
      5FDFB3AE5AEEA0376C6DCAD5A574D8EE592AD451A8C4248E21F9C6E7F24C59AD
      D6A5F90516ABFBFD7BE9BBF5CD7AF3E161DF1E9886B4BB9FDB6D773F6EF5C8BA
      F6A8BC6F8F0F7B5EBF477C8C4FDBC482E4DC00CF74F3E047BF7300EBD2F7E587
      283DF0DACF30F8A46D428267E80891F2E1784BB8DBB4BC71BE2BEB7DC7436557
      B2A2E3A4F77A73E05A472A37CF1EB6DB96972A8CDE5BFE301A3D1E09322AA193
      A0A5C4234146256CA25BF05E8C518366946D836E8489836684A5FD78C7583A68
      46593AE846583A682A77719ADAB5ECFBCD71CB4B2CCFB71D3D60C9B4EBDDE6C3
      AEA4BDB3598CC46EE3C5F0EE6B7A3CE6C3BEBCBFBD79D9ED7841FCAC6B1E6FDE
      7359C2A815476DCCC8D0EEEC9BDD03CFD796660C0A475D5E4565EB8616F1CBDA
      BCA87B33BC95EDD599982DC37802AF87EAC846F2BB72FBD07302A6812FCA23EF
      4A6700BD34DBB00C30FAFC269898784B8CE0D530CFF26C3E5F9F77C9B31E0F82
      D3988BBEECA0CE4DC4CFE87FF8A9E2D5236D60B6D97D6469BDEC6837C5B6B1B5
      17812F848DE1236D9730D8B6AC6027FCEFEEEE6FCBC38647E84ECFD7DCBC29EF
      598A3FD293687C2F7EF7873B7A1FE979D2E08DDDABF76F5EDFBCEFEE89C3D25E
      78BC1124E567F430F45D94FE5004FFEEAF6DF57BFE85BF0573DE3DDEC518FC6D
      444566149F6F98E9ACD7EA9A08AD17E396E63126FEB17DACBA72DFF0AFFB23AA
      28131CC73642FB5D49CFDBF2F5E889DE7F2208D9EB0546FB2FE57E43A5586CA1
      7B78A8FEDED6BCC87BDBF5351547E787FE11CA7EDEE72E125BCABC1C6FA9F266
      97F7FDA6CC1B1AD6C005CF4555C1B4D6528EE9F273B3C14BE822EDB22ECFCBB6
      2E771AB5B57915CDA04B77A9E9BD3D51269F94A36C3E29471ADD6D1FEE7687D8
      7E1BDDC86E1BDD28780DBA5CCA6F6BF3287FAF4BDBAA45B9CA28C6F8C928C60D
      AD518D01B3518C760FEFC6D38562E81DC90555DE4DA85E719808221563C6326A
      C5EC4235662C2356CF2E1463C6D228C68DA5518D19CBECC5F01EF1B84476A11E
      33AE17EAB14978776CEFEEBB7DB97F8CB8FE77DBF643C9ACD47BCD1FF7DD9AB6
      22A37DC962F8C5437534D4248A5FF4CA310E47D51235CEA4C7ACD0E90D02DD50
      1CF6563A6E449EB3D1E2052E6ACDBABDEDB6B47FD958712E2F1E4D29EFBBFBB2
      3EDD7A380969BB6E7E6DB6127B777BBE47310AA60B8223891EA5C48294B1C9B6
      5D6796DC9BB6D93CDC9DAE3B0CCD282B7DB2C296554BB217997A14D44EC1498B
      F992E0C53C3E0AAE9C82626A7DE114CDAC36737B745E94FB8F739FE7F6C88C7C
      6E691473B12C3B6F345B161CF1190220D4F935ADA7A453FB5D583A2B0481CA21
      EEC79643C90F328792076D53DB5DF1FC53FBF3E670BABDBD7C3B5C4ECC3F5CDC
      1CF02CA1D920FBD34337AC7F2C5FC41EC6EF319FEC0EED855648E038C7DB1343
      0ECF7A82C9A1E189A9650D577039A4FD51E632DD17708E0B7922CF617A40088A
      B064EE10BF1680B304171682222604C313BE432300C0337B02002CD800166C00
      0B1680450C80A7A6870058B0012CD800CE7800CE7800CEE2009CC50038630338
      630378664F0080333680333680C3E88D433A0CC053D343009CB1019CB1012C79
      00963C00CB3800CB18004B3680251BC0337B02002CD900966C004B1680650C80
      A7A6870058B2012CD900563C002B1E80551C80550C80151BC08A0DE0993D0100
      566C002B3680150BC02A06C053D34300ACD800566C006B1E80350FC03A0EC03A
      06C09A0D60CD06F0CC9E00006B3680351BC09A05601D03E0A9E92100D66C006B
      CFD29DED8761A5D3FA51CB72CD6FDB77AAE24745CF0F68B274E9923F59BFCA5E
      56148BD70CD1B49DF4ACEB3E327EA939B662E3F2D9A6DA6E3AB336F2F8394FA8
      4D57677F783EFEA4EC524CCE5667E997406629D72ED2A5700ADAC590CC9C8236
      E994D22938A510523945ED342AED7032703DDD5A41C2B365B54B365D92CE5DD2
      13F3572EB989F5854B6E6ABC72DAA44CBEB09A55A94B588F516C2B089742BEAC
      70D56DCB8B3C1EFFB9D69E3CAE745CC3EDD365856BAE756805F8D8655388BB1D
      C685FA5D70FD1E0C60D71A4B80DF4594DF45B4DF051BE44EE342FD9E71FD9E71
      FD1E9C415C6B09A17ECFA2FD9E45FB3D8B43FB6CAAB8EE77C9F5BBE4FA5D46A1
      7D96F8197E97D17E97717E575CB44FABAA00BF2BAEDF5594DF5534DAA73671FC
      AEE2FCAEB97ED75CB44FAB8700BFEB28BFEB68BFEB68B4CF8CB3FD6E2AA26012
      7821ED9D432FE4BC29FC42CE9B412EE4060AE84D1C17E26124F042218C04CEDD
      1644022FFDE750703BD2C91ADD3E0D228133E70691C0451F3B34039CED342ED4
      EF5E12B8E4F760003B14AE7B7D4AAC42FDEE25815EBF7B49A0D7EF220EED53BE
      15E0772F095CF27B70067150B240AFCFA823C3EF5E12E8F5BB9704BAFD2EB968
      9FB1C6EB7EF792C025BFF352B8438BE1F5197D64F8DD4B02DD7EF792C025BF2B
      2EDA67ACF1BADFBD24D0E9772F09F4FA5D45A37D665CA8DFBD2470C9EF5E12B8
      E477CD45FB945885FADD4B02BD7EF79240AFDF79BFEA7E0315FE9370EFEEE89D
      64710F9ABE2A0FB7C792B7C7C69F77FBF6D06DE95D87A70EF3BBFB9A7AFAC9BC
      638B5EAF7538D2CB2193D4EC52496F5912C3FE99C3DE9A925ED463F672CC8468
      552653B5522BD9C85AD17E97A996FD2E9899A61D29170FDDB7DC24F53A4DDBA4
      4CAB342DDBD4BD2F677F64F4E60934B96ED76BB34FA76B4FD174F2EFE40BD25F
      8FFBC5CE3F8FE7FF8307ED83FEDB3DBE58FFDB3D16AC6F867FDBFF6E4FFE17C7
      97B1FFED1E5FACF71F0A4C43AFFB3FB94C0CF1906021BAED3FE7389117D75842
      FC61F62857EE793FA975D914AB5521D66943AF15D10A3D9549A133A1D256B9DA
      5D254AD01BFAEAAA2C0BD9A82475318EFF97C3E981C8032CF257763CA5077E7D
      D6D3F1541E88B07EA83D4EC7A74FFF069BB9A3A4}
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
