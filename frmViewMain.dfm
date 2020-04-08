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
      789CECBDF973DB46D628FABBAAF43FA034F795A5194906C03DF3CDDC2B6B49FC
      465EC69293EF7B61EA164836494420C000A09649E57F7F67E96E3428C2962CD2
      A6C2CE8C250A041ADDA74F9F7DF9BD9BE643AF1B0CC4300AE291E7FA8D6E1067
      21FDE84F479EDFF0BBB33EDF31AC790DB7D5C54F6E37CBB3F170D0EB8FF16283
      FF8C12FEB3C97F8EC3D29FBD503F8FEFAAB96D4F7D1E0A7873BB9B8FC544E8EF
      F45FF3DFF633F7F7EE3089F3BC17C107B70B430F42A73B4C9349107787FD7190
      662287EBD3F437FFF7EE5FBBD3204E32E1B83EFCAFE9D6DC865B877F3E7CAAFF
      71194E44E6BC1537CE077CFCEF7FC090BE1E72920C443A3FA6571EB305E37468
      6C1CB30E631E27B33414298EFAF73FB6B760C45AC524FDFB930470BAB060F8D7
      82C9E2A0AD3F2EEE26BD24A2B979C57AE330FAF440F7FEFBE3A7301E0DE05F26
      E7E5D52B26E6D59A8BE13737EA1FEFDFC070E7E147BC6F1844B9D37DD16B755F
      B46AF0DBEFBE18C0EFA0D37D310CBA2FFA8DEE0BD1F9839651AB7AF1C26DC3ED
      E26DC3EDF311C4C1A4978681F326C8C70AC62D3D64761366D9A7871CD26EF934
      B81A320A614C9A5EBDF62814E8C1BC3AE5C192384BA220E33DF39B8F995A4F22
      12FF0334FDE3428C12E17C7CAD76ADF9E46DFB3F6ADF6882110CF26B9276E988
      2FFB40D194073DE30DDE3742BA71684CC27F1CB6D416638B731E8EC6B95C64CF
      1CBFEAC83F812EC13685B11AFF5107E811DB54BCA1F1EDB6A998C4A34ECE270E
      B5DAA062E4D6F237A8DE695711FA5A9B8775E69E738E4FE5A39DAA4771AB173F
      7A97CA857DE24C35BD8AA7BF4F85B8A2779B8761FE69BFE2E9CB592A9FAD4274
      AFD5AA7876F707D14BC5CD9E1CA09298B5AA60B67B9406BDB0BFA7575F89AAED
      66C510AF001FC3BE9C41B372F9B5AA19FC188A3C0EE0A290CBF0DA552C43EDBD
      E7188281DAF786D7A97C4E6EFCDC73C5A6FB5ED5A36AD7CB8F1A3BEE57CA386A
      CBCB8FEAEDF62B39A3DAEFF283E5BDF6EBD54F2F02D2FC46FB8DCAE7E54E979F
      3777D960C2F7965C5BF4EEF92D6ED63FC31A1D45F09C9F4496C31B1E43F86881
      EDDAE7098829FA282C6AD73E4F3DCACFDDF17EB6EB9F271CA5070B1C6AD73F4F
      354A8F120EF132EB9F3FB0A5478D7D6CD73F7F5A4BCFDEDBC776B35DC1544C20
      337B57F06D76AA1E31E02B1FD107B4DDF22A9E3281CB4F19706D558926265CF9
      29752CDBAD5AD5339A0AAB674A27B2DDAA573E380F8BB9C3D86E35AA1E353691
      1F35F7AF55C5D2CDFD936F9CDFBA8EFF202ACBB2B7DABC8EFF2012AB1ED2DBD7
      A93D88BECAE78A0DECD41E445CE5736A0B3BB507D136F99401D04EED41844D3E
      580629AB13ADC6E70F8452411450E1A1CF1F89E221496EBC56F3F347423F5580
      149EFBFCA1D0CF1584069EFBFCC1D0CF954E063CFAF9A3513CAACF063FFAF9A3
      A11F35B6121EFCFCE128DE797F2B7DEFB33CEAFFCC33A9FB1AE0170BB1A5519E
      22CF9A03794F116D4B037DB9945B1AE62902EFFDD53D45FA9D1FEB49627069A4
      A74AC4F7947E7F95B2D39C6EEF3F9CBF93FAAED0B734C6C319BE1C4323AF394C
      EDE112000F53A06E6998878B043C8C42DCD2200F9711789039B42D8DF570B141
      8E65226D69A4874B113C9281B2A5711E2E56C819DD4758D380F30049BC820A96
      46F9422A3837CC03A4F40A1A786F5D0F90DAABA860699827AAFDA5B19E6C0128
      8DF6242A581A69097601D36657FF3294523CA318E7CB91CA1CA6F144C65A0CF4
      8528756F618D27225569ACA733D662AC2F47A9FB6B5C02529966DAE6EA196BF1
      AEC729CE8A6B14CF3F528B9E7BFC8BD4E9D2008FD4ACEF2DE04BD5ECD2185FA2
      71CF8FF178D5FBFE5A9EA0879B86F4D653186531CA53D40573A0F653A85A69A0
      2731CA629827AB0BA5D19E48D54A633D955116233D95A6D142FB4994A4792FFA
      7B371503B73B825D89DD6E2F9A09F7FE25BFD1302FC29F9FBACC03E05F0B8698
      BB3C776FC510152FE4213CBF6D5E843F3F75D9FDFBF6165EC6BF170C3277D92D
      5F2C065978590FD2F1E517F081BEE8F80F82B38B9BFD578CD4E88FA7482A7CBF
      8B811EDD40BAE730CC43FF811121F28F86A31E9C06530756F85BE474A3D0EDA6
      F02F0B3CE05B59E4373AF073328B72AF7B130EFA79340DD2EE4D1A4CE1B9002E
      77836C1A44D371801FE2D904385730CB936E30F87596E5290AF23020CC35C21F
      611E4C5DE78F6E9CFC0658974C925C38BF77B3FC2E12D95888FCF7AF37896E9A
      47008B613FF370F18174390604C04045DBC064F2946F73157055008C11FB4200
      FF1CBCBBFD511A0EE8B1786A8C104F710CA79BC5E23687B764BF0D93741200FF
      CFA66998A4617EE73A6FF1124698C05C33AF0CA69EE712B0F0670F17EEC15FFC
      FB51E04A6639004844E25A44EE8381D70D7AB042172107F27305E47A5DFA7611
      ECAE40E4010108D4C34FC30717DE0B3231486257020B5E9EC1ACAEBCC642A875
      1C44AD340B075EA3D3F1FD4EDB198B00C36B1C0F4F4DE6AF1E8EDE97C0116051
      C011D63D0F49F87E11243F875F73D0F315F49A8F859E2FF1B0B67AF8F95F023F
      BFF5293C846F1F0FBD05D85753F06B3D167E35A6D9306B182B180CC23CBC1670
      7B2626E1381C0C440C7FCC62F82866F04A6350CF3961D839EF833418012CC7CE
      5912E73420CC31CF3C0F7EA4C9CDA09BA7C33CFB291CE4E35735F8630A2F8A3C
      B72D3FA6C5C761A4BE1FE6FA534F7F4AF153BF370D80FCC287217FE8C1D28113
      F1EFFC6E2AE0AEEC5AA4394820F0A9970E52F53B92BF7BF2772A7F0F4691FEA4
      AE8DE5EF6BE773AC0056BB1266B036ACC0F33E8112DB5BCC119CCBA017098D4F
      0D139FAA88F4BD23E13275D694B8A01588A08CE4F83BE95F95B071018AFFA008
      AC730C12A69E57F3F3F3C2D72E98175C36CE9E9E8FFFC8F9F8E5F9B43E3F1FBF
      B5703E78F9DE6C6A8F9C4D4DCD86B8797B3564F41108CF0BAE7F02D9EBCBA199
      5EBB24D5DC03D0244B6225E9F04E752A776AE89667398BBAFDA13FB73BD52475
      7E6B8084A5B897EACDBEFBB8377BFE3D447DF0CBCF92284A6EC4E0FE24BCEA49
      F8B4697353C1D868BAF88550B87C73EE1C27032171D35F9188B48EB8E9FB8F81
      9424BFBB3F89DE1E0B936569488303B9F26DC76BC24FAF5DF3E197DF02629BDF
      D69ACD3AFCAA37DAC0466F1BF50EDED2AC7B784BAB8611F5B76DBF5EE7A7F116
      807A8B8671610EF8DBEB200FBF051DD2C7DBBC5AAB4EF7D59B8DE6927741225B
      C52EC01A25E22D45305592955F7F34EEBE4F054B62B918E84354FFC243B490F1
      94687D69729F9B4F8905F9D5AC3ABC4F61C2B9037D5FDCF41750D3D309EC7916
      66FA9DD56C78EE85F32BFF04C99E460705B9AAE6ABF32B7AC4F07D3D7CFBD36C
      7B8E617F1E66FEFDF76D6F5DE469128FFEFE07BD340AB33C4711EB77FAC87F8B
      C9340A72110E0EBC4EBBD36AB6FD4E93BF279DA54B3FE3611F4882FA18ABCFBF
      F65DF521969F8644FDE51F591E800C0D1236FF350DFA427E0372B68873F777FE
      2B8783D27DE17ADDD941ADE3D59CFF8D40E2B7CD263D91C2A6535A4BC68EFD80
      F03A3CA835F194B7E0E2AF7DB93624373E9D7DF8E590A56FD94BB986E9C6F011
      F6EDA1EB4A16ADC7AF588F57AF971744176064FC8D76AE072F08B5ED552D89B6
      CAEF2CDE2ACFAD589B8FC4DF5C1B5D8057E0EF47ADED412B43007CBDB5B5DB73
      6BC30BB836F8BDFCB555AE4CEDFA32D7063FCB6BA30BF00AFCFD15D756B53258
      F317AFAD5E9B232074015E82BFD7606D9F59198A2B956BC31C92D2DAE802BC04
      7FAFFFDA3EB5B2561331BDB4B616D312FCFDACD7D6ACCF5112BA00AFC0DF0553
      4387960303E16760FA75CC03ABB71A7F2CE6EECD4EA7E9759AF5E7C6DBE736D9
      E4EE6BB1C52BE2ED8A8A3F1FAC5D1E6F5F43B9E5EBF2F6AF2AB7AC0B6F5F85DC
      B2EEBCFD2972CB33E7ED9F965B5A73B4E44FC5DBE7585A99BB2FE4EDAD46ABE6
      7B6E6D316FF7BC761BFEEFD7DBCF80B9E3BE3F44755F8B3D5E26735F135BC437
      62EE054F5FBFB5AD9AB9ABB57F83B57D4BE6AE97BDA2B559E6BEB694C432F787
      3377DFAB35EAED96E75528EEC0D93B6EA7E6B62D77B7DCDD7277CBDD2D775F07
      0262B9BBE5EE0FE2EE2DBFEDF95E8559BEE6FB6EA7DDA8B996B73F7929D6126F
      2DF1D6126F2DF1969D5B76BE3276EED7EB4DFC516189779B5E1BFF5976BEDC2D
      B6AABA55D5ADAA6E5575CBDB2D6F5F1D6F6FB45D60DF55BCBDD10455BD5D6FF9
      96B95BE66E99BB65EE96B9AF0101B1CCDD32F78730F766B3DDF1DD4EA7CACBDE
      04D6DAE95827BB65EE96B95BE66E99FB5A1010CBDC2D737F0073AFB92EE6BB37
      DD0ACDBDD502C6EFD6ACE26E79BBE5ED96B75BDEBE0E04C4F276CBDB1FC2DB3B
      AEDFC27E9F15BCBD8D85D2DBD6E36E79BBE5ED96B75BDEBE1604C4F276CBDB1F
      C0DBEB8D0EF66969F81546F956BB56478FBC8D8EB7CCDD3277CBDC2D735F0702
      6299BB65EE0F61EECD76A7EE82FA5E65946FD66BCD7AD3A6BE59E66E99BB65EE
      96B9AF0501B1CCDD32F70730F746BDED77DA75BFB2DAACEB7A8D56AB6D99BB65
      EE96B95BE66E99FB3A1010CBDC2D737F08736F763A7EABDEAA8A95AFD7EAC03F
      5CDF32F7A72FC516ADB1456B968D7BB6688DE5E7969F5B7EAEF979ABD36E359A
      952174BEDF6A7835D876CBCF97BBC75659B7CABA55D6ADB26E99BB65EEAB62EE
      CD9ADB68008B685630F7A6EFF94DBFEE3F87C66F96B93F47B4B5CCDD3277CBDC
      2D73B7CC7DF9CCBD516FF9CD56B3A224DD41CD6FB53DD77F165D5D2D737F8E68
      6B99BB65EE96B95BE66E99FBF2997BB3D3F2DAED76859BDDEBD49ACD5ACBB39A
      BB65EE96B95BE66E99FB5A1010CBDC2D737F08736FD59B9D66A35DA1B9376B4D
      AFE1765CCBDB2D6FB7BCDDF276CBDBD7818058DE6E79FB83787BD377817DB72B
      ACF29E0FE8DC68776C513ACBDD2D77B7DCDD72F7B5202096BB5BEEFE00EEDEF2
      3AEDA6EF5599E5EBED5AA7556FD59A96B75BDE6E79BBE5ED96B7AF0101B1BCDD
      F2F687F0F6A657EFD49B5E6517B81A30F726DC60B9BBE5EE96BB5BEE6EB9FB3A
      1010CBDD2D777F0077C750F8761B785E15776FD7EB5EDDF3EAB6119CE5EE96BB
      5BEE6EB9FB3A1010CBDD2D777F0877AF7B2DB759AB7915DCBDEED7DD4EA3D6B6
      217596B95BE66E99BB65EEEB40402C73B7CCFD21CCBD51AFFBB546B3A28A0D0C
      0D7B6E1BC159DE6E79BBE5ED96B75BDE6E79FBB3E1ED9EDBEC343B6EDDAB6AF3
      EAB95EDD85E7ADEA6ED9BB65EF96BD5BF6BE1604C4B277CBDE1FC2DE3DAFD669
      FBC0C22B83EAFC7AABE9D76D369CE5EE96BB5BEE6EB9FB3A1010CBDD2D777F10
      77F76B8D56A3E1567277B7D3AEB7BCA60DAAB3ECDDB277CBDE2D7B5F0B0262D9
      BB65EF0F63EF1DB7D168795515E65B9D7AC385FFD98438CBDD2D77B7DCDD72F7
      75202096BB5BEEFE10EE0E24B4E5D6FC76AB2A66BE5E6FB43BBE677577CBDD2D
      77B7DCDD72F775202096BB5BEEFE20EEDE6E797EABDDA8AC66E3FB7EA7D5B4A6
      79CBDE2D7BB7ECDDB277CBDE2D7B7F3EECBDD668B73B0DBF5DE179F780BDC3F7
      AE6F93E22C77B7DCDD7277CBDDD7818058EE6EB9FB83B87BB35D6FB7FD464513
      19AFE1759AAD76D3D699B7DCDD7277CBDD2D775F0B0262B9BBE5EE0FE2EE6D8C
      996BD42B8AD579CD66CD6DD4DCBACD787FFA5296C9D08D352852F77C50F5C90C
      5DAFACE0EC6BB3B65533F4F2CA10001BC1D0CD95A95DB70CDD3274CBD0E7187A
      C76D833AEE57F8DA3BAE5BEF34BC9AF5B42F798FADB66EB575ABAD5B6DDD3277
      CBDC57C6DCEBED5AB3D369563674AF7B9D56BBD6A82DD4D6DD0230EE63E1F220
      50F8F0CF3D9C0703C2085690E6517FDC1DF633CFE9064362EE519EF22513308F
      65F44F59D5E3771B97E83D74898B17882C7E6EE72B55FB6FB84AFF69ABFC8C14
      B058C2F9FAABAC3D71958F97075CC35CF3B556597FDA2ABF403258B8932B34D6
      E02A1B4F5BE517C8088FC1D7654876B8CAE6D356F905D2C2924EE583653C5C65
      EB89AB7CBCDCB06ADA43146F6E95EDA7AD920486474A100DD7F36B2DAF5D9146
      EFB97EA7E6FBCDE6D2EDFD8F14F11F66217826F60116EF5764FE5F4BC9F79352
      FDF2CCFFDF646D9FB10FCCC976AB35FFAF8F7DE059DBAC9E6C1F58639BD5CAED
      03DFD066F52DED03ABB6597D11770702DAAAFBF50AE37FB3D1A8B75C7709F56D
      EFEFF946F1F67961CEF276CBDB9FF3DA2C6FB7BCDDF2F635E7ED8D4ECB73DBED
      0ADB7FBBE9B76A75BF6399BB65EE96B95BE66E99BB65EE96B93F1BE6DEA9B51B
      B54695E27EE0B53B7EAB83FDE92C7BB7ECDDB277CBDE2D7BB7ECDDB2F767C2DE
      9B7EBBD66EB75A155976075EADD3EA34FC4EDDB277CBDE2D7BB7ECDDB277CBDE
      2D7B7F36ECBDE9D6DC1A206D057B6FB87EBB556BD5975000CF7277CBDD2D77B7
      DCFD19ACCD7277CBDDFF1CDCBDD3E8741A8D0AEEEE355B9D3AF0F665749EB3DC
      DD7277CBDD2D777F066BB3DCDD72F73F03776FB92DD76FF9CD2ACF7BAB56EB74
      EAB565B4A6B1DCDD7277CBDD2D777F066BB3DCDD72F73F05776F7A7EA7D9F0AA
      FACAD6DA7EBB5EF77DCBDD2D77B7DCDD7277CBDD2D77B7DCFDD970F74EBDD346
      0DBE2AACCE85FFD5EAF5B64D8AB3ECDDB277CBDE2D7BB7ECDDB2F7E7C2DEDBAE
      D7A861687C65525CADEED6BDDA328AD559F66ED9BB65EF96BD3F83B559F66ED9
      FB9F83BDB79A9D369CC7C5ECDD776B9EEFD71B96BB5BEE6EB9BBE5EE96BB5BEE
      6EB9FBF3E1EE9EE7B56AAD5A7331776F771AB54ED3EBD89438CBDC2D73B7CCDD
      3277CBDC2D737F2ECCBD0314B4E57A7E85EAEE7975B7D606E66EFDEE96BB5BEE
      6EB9BBE5EE96BB5BEEFE6CB87BCD73DBAD56AD56C1DD1B1D17D887EFDB8477CB
      DD2D77B7DCDD7277CBDD2D777F3EDCDD6FFA7EBD59C1DD0FBC5ABDE1D55BA0DC
      5BF6FE895DFEFC426CD757CBD12D475FE3B5598E6E39FA9F82A3B7DBF55AC775
      2B7ABA1FD46AB566ABE179565F7FEAD1B4FABAE5EE96BB3F8FB559EE6EB9FB9F
      83BB779A7ECDAF55F48EF15DB70D1CB1EDD9123696BB5BEE6EB9BBE5EE96BB5B
      EEFE4CB8BBEF36EB6EA3E5FA15DCBDD3E9B49BB55ACBE6C059E66E99BB65EE96
      B95BE66E99FB7361EE9EDF6AB46B5EB3FD077CFF57BA9A5C8B340D0702C688C4
      EFA54B4AE1D7DDE44ADFF693192CA51B659E3EDBF30F6A4BC1E20755FF9AB9C7
      7CBFD176BDB65B5FFC546DF153CD46BDE5375BCD8AA7EA8B9FAA37DB9DBA5BEB
      B88B9F6A2C7EAAC825C44D5EF460B3E2758D8ED768761A15906C55BCCEF36A9D
      B6EFD52B66D9AE80A316E5163FD6A90064ABE9BB5EC36D57ECB65BB5DD6DCF05
      26C682D5A207BDC5EFABB9AEEF63D9858AC72AB0A4E89350F15C059EC0CA3CBF
      D6F2DA1588E255608AEFD7EB18A652AFDA72AF0A5974C9E78AE72A70C56B746A
      ED46AD51AF5A6015B6E868D98AE72AD0A5682B55F15CA7F29CD701A8B57AAB51
      71CCDD8A17C2F2DC069CDB2AF25081308D56A7DD6A34DDAAD755218CDF6E01FD
      6B372AE0E957204C0BC858D3F7DA9DAA8DF72B3006E00968D66E57BDAF025FDA
      75406D50B1AAA052812ECD56BD09585685D67E05B6346B6EA3013A43B3E2B176
      D5A6FB1EA02640B46A9A15D4C56B34002A2E80A582BA57218B8E12AB78AE0259
      E0F0D53BF5A657B109B50A64018EE00379711B559B5EABC09676A35EF76B8D66
      053C6B55D4C56BF96DCFF72A70BA56495B1AAD9AEFB95540A9222DBAFD7BC573
      ADCAA3AE4BE0553C59455C800402A2B5BC2AA65E812E85C452C1D62B694BB35D
      6FB74192A878AE025DBC06A898ADBA5FAF3CEDF52AF20228D36E01A5A8C0B47A
      153FD2A98B15CF55604C116451F15C15CAD0EB6A400C2B9E6B56ED3D1C77E0D3
      75BF0247EB55FCC805BAD471EB5E055FA957A14CBD5D6B763ACD2A41A45E4561
      7411E6C5CF352A51A601B4BAE19386BEF8C90AA4F19B2045FA6EA762E71B5518
      A3EB4D553C578131204076FC56BD55F5BA2A8401B1A7D16A342A5FD760A52015
      D7792F727EFF185FC5C94DFCF73F081FFEDA9D8EA6741D3F7443F8E176C33C98
      E2686E37857F590FFE05085D7587577107BF270B0738207D68B681E1355BF4B9
      E5773A20FAD06710823A281DC2139349908FDFA7FCFB2C89F35ABD3BE9A557AF
      42D0C9E4878B19BC61924D82283A4B03D0DA2683309B9E88A1D79D446F827444
      F7A6FAD3400CFFDF3E7C779306D3D7A49B91196D12C6F97938414498C4417A07
      9F71EBC37898FCDE0D66F938499D4BF89181B2E79CC6A348A4F075321569902F
      FCAA9F0AD00927DDBBD407A6D29D24F5EEE0AEDD1DA7C097E065241A23DC3F71
      0BEE2A6C59162631DE2D06709174A138194E8391C81A6DFEE3264907208C0249
      E1BFFBE320CDDA78268CBF6F408EAF773A2E0F1A036AA86DBE9D4471C61B4D1F
      3D679CE7D3EF5EBECCFA633109B2C349D84F932C19E687FD64F232190EC3BE78
      892F7DE9BB6E8D3E4DA23FFEE84E0380C78DE775DC267F1E0315876D9D00F023
      06337C4AF5A75C7FEAD1A7D12CCF450AC893A799E8E70E6CC64D38486EFA791A
      758779DCFBB51B88783048FADD1CF6FA6A02189DB9FC7998A4802579188FBCEE
      2089935C803E3DC8EEB221E08D07A08EEE92F87A12B9C6B7A0398F06411EC09B
      D3218C0A7A789CC380D74114C27501D0F0BAD938B99946A0D08F936880FA3B1C
      82519CA46212DE8A411F4647FD1E90FC5A84313D798B6FC1C7E0039C38C00C0F
      76E13682E9257722865589DB69364EF3182ECF60B15136ED7707316C419CF506
      3DB84A160458D20CD60D0BCBC6011C6AC0B1FFE0DA07A30961337C18D38D4056
      E0F3B5F1196E0D476C19C66F4A7F8D716A1E3D801FD03809F309E241F73A1437
      57613CF0E853D60F22E101ED988E7AE9201D8B60203F0E9324EF66D3E82EBF89
      C358E0D6E8CFE37C02C7259BC222A2789C07835F6159DD5926A2BC17447117FE
      C1057849171E8137F4E1AF1BFA033EA4F928ED46319C6C58B98021E0D34D8A44
      A89BC5C1344F4640BFC2B82FA208068A929B61282238C30318BE0B374E67711F
      63DE832C0CF42848545298B1222CDD58DCC088597E075F67F092519ADCC09C93
      6198E3446304787E077047A209DFC36463A03679D61D0A9C9C88C4355CEEDF66
      5332A1009518C01EDEE075817B1A0CFB70A070D6C1906E9E015E46DD31DD8180
      CB81520629DC99F7AF0382550EB3C587862902042F5C07F96DEFB67B95C6D334
      8B45DEED07701C01E12280A3839813C2699C06B903D362DFC25FBB3780C8C349
      3E0C2338488E5F07CE87040048D12C15F9384DF21CF6B41B46C36412F483BC1F
      C5B369A381270E26E474F1D80D1C7500818AC7E2D6EDE2D68BF4AE057C19B75E
      7E849964B7F801E01F8F452AE8697C0477092D56349A180680E37DD8413AC10E
      319618BE8AAEE1744DE3593F9DE00534A8E1DF6C30439BC2341E07F108D94F9C
      DFE68173C85C443DECC346E3E330D92F7ABE069F80197ED1B375F8143DFCCD7B
      E5A71B0F7F73CFD9FDA36A982601E0C1D3F8D4502D1AE8611BF1A971DACB9A50
      E72113429C5F3812709F1488551484B12371BBFB1B1C9A422A41BA9605F4B387
      671FE87CC0BF81E30016E313282248F4058A320DA2E938C00FF16CD21DD2DDDD
      6446084F165CB70BC46E96E5406BC739BC2626D3AC129960C0C0146F4008CAA3
      FEB83BEC03BF053A51F31A20BE06C3CCF781B4C1EA3CD76FD0E4F92617B9217D
      8B5FD6DCB6471F86024D70DD2881BB789066771C1A7F0C7AFA8F46B78F27939E
      8BA7C610F11407816D294DA9078FB938A37ABB348F6EAF3BF4FC6617BFE8026C
      C6DD2B90278095D69A40093373915D943C4AABFE691CE42F320748B0037B737B
      3A0873A77EE81ED6FF3722339020DEBBAFB76BDEE376AD0A46B566058C002804
      A3CF42667BEBD56C34049922939060919E3C06053A6B4A5DC61EB7FC76E513FF
      EC4B35E2283C71197B8635A7FBA2D7EA027FFB63C18E947CEC0FDE9A3937283E
      FB80CD8AB2C55B848F3F6C937887FCFA1C8C787FFCFA43B6E62F6DB7E61C38C1
      10D96A3F1201E2FBBE93251341B80C22703420F92B73866932714ECE8F336712
      DC39C0C99D2809064E3E1661EA60584502D3BD7352D0C3406C77E0678A7CF36E
      CDB67D371530D35C0C9C24764EC20C67BB0730381459E4C0EC448C8A49E68038
      FD227782E826B883B527695FD07A013E4E9039A717E7C50A9D9B31A848000867
      920C403473C28CE083370DA360341283EDAD6F44071E49BD1F482B6131ABA096
      354B2D2DB5ACA096FEB7A6967F69D63B40273EE0FB1DD02B8523D591DE6CB466
      9BF59766A30E53FDF9EC5DFD17E7782CFA5748C19C5352DABF739802660E29F1
      4CBC02B83802BAE7BC7492DEAF68A4C0953863207517C7EFCE1D1050D370ED90
      121858B3819BF213AE81D4C61409B4E441FB0E21CB01A05BFF0AAFE789734A26
      01E7288A9C690AD41A395BE090B9E3369F81063A11F10C6879808B8F47199175
      E3A121AAE200A8200AF375636D7F69361118C7A7E7E70ECCDFDD778955F78493
      4D676998CC32E055C16000BC0F2061F2F6C18CE0A62480C3B55B58CBD5F87C12
      4C8211B0DA6014F61D311C02B28248126651D01351046BCB663D4680F55B059E
      CAD76C4D735E5FBEC9D4FE689904D8219031E1F4830CB6858E261ACA1C692F85
      9D0A61C5E9FAADAC092BFB7E9C64B888D38BF770A8E0C0BC4906A334994DD78D
      6EC07CDB30DFA33EE07EF6639844011E69007708C2DB48C468FDA6F390C443A0
      1DB903BA7A3ECBCABBB3766BEA78F28CBC3C7BD76A02E14FA677B80AA207680F
      86F9C3B90F906FE11A806206B30CC45AD8AAAC1F4CE15A12C1621014701FA1E5
      8188D11438605404312D1B27B36800A2F1FA2D1F0F179AF65104072A105C0BD6
      59F853104633D83A94CB538116765200805664E2B719B037F848E8B08E1BDB80
      955DDE4D1344C09F4430FDE7C9DBA337FF3C8AC309232E7C27BE735E05E41EEB
      3B07FFC4CFFCC7DA2DA6EDE36280A94E837CECF4E0F57D74E031A3055A778362
      26128F5E00624B6F96E748F6C2217D7F13C683E406F5AB3C491CF28EADDD023B
      480A4F92191C1BE71CF7008E603274764E04FACEE0BC9DFE360BA7CE6538113B
      6A43610F81563AA7C4CDD66F452D942A8218CF4E309D821091F5D3700A6C7796
      118189023C37FBCEC55DF6310F23FC94A7F4C90101F327DA34B8390EF3B53B5C
      2D1739C1CE314A3EC08D817FA5D98E96F29C412232B40330C97000DFD44D2861
      0DC3148464A0A16BB72A0F5715104173AE0D0607441CFD7DB86B03507DF3F59B
      B98F92DE4D9AE0A94907A05EA1E67206F48E88C2397E8043F3E6E3C5E5FA4DDD
      93A4EDCDE5DB370EF9F070AE1F8E8E4FA54A8294EB260D7374A9DF8440FF6671
      2C7093D0720658350963963C5CA777B78E9B83FAC5F9BB93EF51DD8203835C95
      17920A104B458CCA84549EE0B8BCFD0892076CDF2C4E459644D7284A006B021A
      780642EDEB93F5A30635E44E6FC58D73FC2F0748C2352C87E62BB70FA7098203
      A2241F9F81F3E1F4EC03103C968B48BCE8A172925EC17781D4B1D76F9968F5ED
      A3824B6A3173DE89035A09702AD857195233806D962B57847036C508027A240A
      6360D022BF11701BBBE2417FC653AA227260E38109C010E4EBD236D0358203CA
      8C642470329C2FCB172F32B56AB510650E1E267D50038092F66729603BDA7E33
      C0833E22C224593B85B35543CE7D34E985A35998DF2131BAB8BA4BC309ACF0DF
      4041018987217065E00D6B37F57AF5D4DF1FC1E95CE7A923F33D56A7EB48B2AC
      B9E9C379226A611CA863BC730A2ACB74ED64C05603D9B22612F258C062E02FA2
      2364AD40BD1217A28901F207529B5163C67B391D089EE387C81005F446DC4A41
      395CB73354E52E52A632E7240D4649DC4BD2F8506413E28A93E00AD85C12A4B8
      C3F141301A0105CC38916A9DD6B6BD55B9BA34C8C6B86F6F8F7E7C23DD5B6918
      6010A0230623F27049CF163139BC84EC601F15364201DE6827CB9394CD5A7891
      EE63B908E0F4023D88C9159C002770D82686FEB7141187DE7B1D066C7EC5C7CE
      6178902D50845833305601F14791DEFD7B16F6AF2EC6C9CDB13425B1C90FCECF
      1D999222F6A462C49AD317698E911DCAEAB46ED25135BAFC00D3EA276857DE65
      C1CEF92FA7EDBA7BDA191C48CB0B1CFA011A670AD729AC979DA6526E643E4BD2
      236EFD08B3FE58E342440BE4E735834C155C8201FB8BC9D3297DC3EC6B8705E2
      375391224D058C8673045A287930847399EC38D359CE3611F3593E5BAC1D91F7
      9D54A467020DC3DDD497A6C9381C3A3D18124E366911D9551823555DB3155563
      FE80ED3CE461C2AFC2381723C455908287B043B903E2E104C36F0B8E4F873D8C
      0F28FA1668628891D66CE0BAA3930273466134408BC9DA89370089EDAD85B080
      A3ACE91A9BC8F7D1B5468CDE999090CDD6D76C16E58A25902DBA2710190AA549
      9E8E598CA65B2D60AC19203EC13D4DC54A1244D4AB945651C042869718326071
      3BFEB5730C32D52045FD6AB8E3902F85944F22956BE9E4AA82C91BA660AC2DA1
      2D6A12663D31260D1B57A498009101F82E638C2053DB3359E2CF97A7178D9717
      17A7BF38AFDEBDFB17506F11F4C7B88E8BF7A7E7996922A0206F328FACDBDA86
      C90C6DEF77A05F5D8B08134170699783E129D3B1C373603B67A0A37C105932C3
      A8284DD7182CCA549FAAEF59D2EBA18901867E1EEB25B1CDF9F9689627BF386C
      1BA62DCB1402CBC36D8A27BB37383A09FF080FB833CEC4DEF3582F7BD6C358CA
      65850B5DDA608158A317F1792C268C7F658BCCBCF4898C97F8CA141734489329
      20EF0DD2564576E7B8F2F3586F924E81E1C07A17708BCCF0F31E6599C0B01FA9
      CEDDC98818CC2B8B4027017C9E28AE1C07D77087100E26CC7CB3D8C5358ACA7B
      13C6C0A4D65310F9E6A179B56F1F9A47864E23F6E1F2F2F4155C91999F0BBC30
      3BAF220167E91D653A823CB2B37ED6E966AB535ED48FAF2F5E9366F1FEF8CDAB
      8246836A01BF07EBA736FDA5E5A33B259B0D87E12DBB508348C59AA1DE8BC643
      D604D76EE6354FB3C51D85459EB7A308E4CE49900707675130CA764C6E39E468
      1BB53188683FB01F8542515E837A988640498E45145174C0CE9AAD1C965C7B79
      F6F6C75F1C5C9CE3E282519A75262004C16A2EFA691245EB3B6BB2BDEE7C40C7
      D3445C5098C2FB34412D33756E2F4E9D5315E1EF9C27A31D27B80EC2680D6D8A
      1F5896669389C6A6D8790F4236883317681F23556938C348560CA581F782C241
      3888C458266660D9AC355B1B9A43317E27CAC3A903FA514E0AE08F20696000DA
      6C123B9C98B96E7CF682ED3683B02F75D6599CB11E7831EB7D60027094A6A0D0
      AFD9C40DC594A37F4FDF1EFF80A2DFBF80AC914F1EC5DF759BF511E9C8419685
      A35889AAD2E72E0FC49A4DF8F4764AF2354ADC01E888D768D34167FA54459782
      7AC8F194193BBD8014E17648E58362B129E3B33C679FA4A3F2CC3169B2FED0C9
      BB544061B922D7C183A6F988499E9D9D3D6892546FF5C1D334A9E2B267DC76DD
      AF08562CE5B252C03E669A7BCA8C3F99066C0DA1FC928B75B310CCE7BE3840F0
      74FA8B2C6BE1BCA38417D2FE9D884CB3CA1889B2F60FAF2FDF9C66560306EE07
      BC0ECD0CEFE1B513611866BF06549E02872524CA5E6046EC542F9C683CE5D588
      7E380CD9C31DA08149C2E88652646FBEFB82F3B0982AFDA90C06F5A71A0C9E48
      B90F7E43FB2E9A03B5AF7D15BC27C896CE730E7ECBFA4BA7E6EB89A4CB861CFA
      2617ED3BAC7EB9E05CC9BE5FAF66E33763EB91ECA0AB064394CA836351A5F5DC
      F06014D983FEE5C49DE2F39ECB5EFF6669FA13B61A4FF7F3DAEE6065FBBDC10A
      CAB10C43CE1376DFA3F39E5CF79BA3A51C6594DD7B4B1A6F80A1E4BD889DBA27
      C14D3C9AC1FA2948793713C2C14609189DDD1311D935E176718D450254B2F99E
      F3EFA363D064328ACCA240C628328DD1814C13A6C387693118CB85B72703528A
      F61D15123110B2CA0B260A4E7A1C26AED36AB6B7647521005106E3C85CE5B239
      1BD3A62895520618637E948C19BD11290E150C8A423C34159C3A46498A812A68
      70390E331980C63A9B0491748A570575EFA221609A6459D88BEE9C045E90D21B
      B23D3530AF2E64034312C35D8B6066C0065FBE6CC252DAE45551180221456E01
      AEA44A11C6021AE81842D517DD12BEA12C5B2578A112DCF8D64AF0DB0449E41B
      C0D337122957A1042355A1F8573C1005FAD379E7B84F4C290E3915E4DB9F8847
      AE6E978909A5AE30E5B9486691731C84692CBD770381D9D23D582051DA2F8908
      7B8692D919564CABC6AD2509671C3ECB08348F61804EB81F25E6B4CBC18929F3
      8620BECBC7D2B544B7ED7D2329EA591569F337BE48DBBF9283B3F0AB46C57D6B
      B952A573813036CBA8F8417625F3A003B275C309CA66538A59604C91118A1832
      4C12018A6D5C2DE27D90A72289D1B9F2129E7F1FDCBD0F222547BDD6429414B7
      C4E787767A209181D005B78613414E9B0988236310C206494CD15D19E592D1BE
      ED63145F8A896B8350E62051519C7E8A319F20CFC05EF24411E05381B5E19D5D
      98288EC093DDC30371F4F17F1552A5E0B1E17BCE8D434313BC4125B0F1975CCB
      44F1893C99CACC63900D63862D9590C414300C8E3ADCF463B6BDF53D4890E9FB
      4480F4F0633810C906399C8E88F0EEF0B27714EE603DBE1EA6DB731CC7635189
      64F79B103492644A45FFFE27995DCE407CC700602AF847E7898F99F46DF5018B
      710E18765CEC87454E5BA8B342AF69AE41347051FD52C56EBE17201B9E82927A
      374D30E4CC6BB4D66CE360DA5839EA48E58C728D2550948211B13AE252FF9E89
      0CA5B21FDF1C9D7CA234877AE8185BE270C6F59AADB62A898A694F2A2682FA86
      3ABBB3F8064D78706774B7A7928B346563F354188793F03F46953AB2FC0440CF
      FA5192C9400EAC4292A4CA668415FDD62D30B23AA3F02765D7CA30E1885419A0
      E49C1D99DF847D0E060D8D7B32C08D78B0EF842AE1922D76B1CEC2C531521107
      13C4B643AE9187262DAA8A379EE59819B366F0A94CBCA3C8DF8FF10C8D873247
      1A83FB810DBE7A7372C945979278840221560DE124D3EB200D29F83103D47176
      65769E54298127D6D8C4B8B7768901D568729C445130CD64C539491E10EB512C
      DD25F070B55FA2312F29221F3F6018AB916FB94756BD598C995FBA284198F667
      13383554E2A9C8E1C55847CA2B52E53F745E51A672F8095DA360FDD2F6AB01B9
      7322C4940A6822A6BC93E54E768A5CC73E059619B6F03EA65EA99C2B0232D6B6
      509171AA661C919E58B07502704C17E325310ED59275ABFCF2498AC47AD2B26D
      47DB5BAF63C4A8A55BB09D2B71A764660C3727EA286BF59BEA2626CB1DE76984
      9F875138E58C8F33AAFD0452B92EA2AC53FB614C1C6F4786FA3E932DFC9922C2
      4F8E2E8FA80CE5D1E507040693D1355BC22738A3B42D60F6A2D8A79D0AFB5431
      B44237A2D22281D38BA8BC28FCC0330BCC6217CE265698C19E64EE0DFCBC1BD4
      64AE3D92B0DB6792C97BC1A513967D26D97EBEFC502980EF0AA6BA8AC819291D
      295BD6E9C51BAA804428020789AD4553C0CF775CEF4B7B2F95E392BC9FC0327E
      9B8558126957E78FE7D8523133C697CE51DD8C44DBB975650C78FB33C1C765EF
      2EA8476F9899EEEEAD0221953F33287C9998422559B7CA24E7C07159958736EE
      79ECC625E7768723AE078B29DE98E16D94210D81BB9170836C110B1FB22D69C2
      2A9751EF8053A0D63323BAAACA419107F513C96DB0B6F7C90DD737B8F8E1DDC7
      B92A9EB0C9A3780D9303AB8B38C824488A564782C40D2C24E2E6691067208793
      D2A330D9A8E296CDFAE3E7B752D03CCECE2F2ED5D6C1B60DC28C6BD6D36364AD
      7A1ECB3A994DA3B08F369C722587EF3F7C7CAFCBC7C82A2B0195161CC26E4652
      A537580E6B64455AF5065B69A54A0CD8709CC403AA17BA415E8445AB27EF9A51
      F4036377F82B8EE91241864C00E3A98852C8242FC743AF16170A0E7265FF3786
      658A4239BCF29DC5F93B748E741EE49C0F037DEF1C3C049309AD63A1D834994C
      CC42C82B11033372541949E73D9611C0C2B800E4931291DB00B466E7D83BC6A7
      9D2F85D7CE3C2AEECA55530C699ECE840EEF93F657508F2512C3274AF10595D3
      7C6BB0E0856885E4C990E7AD87F5FDE0C8808079579C158BF65B6F8218FB6F1D
      AB184CD5838129CB404C5381BC71B039685E0D91DD1747D487E38C3BD0A124AE
      EE7AB1EFBCF81873A63CF93D4E581C723E882108B25CA31F6EC2AF5E7CE0B616
      3BAFB10331881E64F262FD6A4759375F10FCD1A6120E046AAE492F4B6874A5AB
      62D54BEAA5464703F0FD05D74FC3F0429ED70BD495783A740874942CD5C20C9C
      09EA1E2354794924E3F26A0533789350554C663DA410F750079F7F8B52DE58BA
      0AE58995714C58D47F90F467E44BDBC5B2B318B7378DC8F98D366D8ACEDB27E3
      1F79514400DBA661BE674FE8D6CF58D1F8170976AA86A1AB1AEF2F2899C73846
      DB83810354C1194B65602D48B14142D82559733258F84469D4E4E4A42381288B
      A701D54DEE3FA5C28FB80E1BC04D4673885B4102DA400A6BD2500DDF4E75A8B5
      0EF448141E6782DFBAEFDC25337A1B39FD18C7B174F7E1E8F04B02B4FFD4210C
      AD6F1DC280076DE139FBEE6106B547950701651AF17171B9F24340BBE53B6256
      60F6BD3CBDD8DEAAD342FE7D71BC9269AFD93179027E3CCA1B7771718A607DDE
      B8D1A0253C02311E9708B096A8514846AB408BB3B73F6AB4D0B976CF0625CEDE
      11ADF8F7D14661C48A9001CE575DE3828107CFC25FA8C8DB862042591E5F3E2E
      C88385AFC1B7E04B10B0DB5BCF892C1C7D7FBE5A6CD840B5472BFEB2FF056920
      DC1BD4390EA6CA768057DFA0AF91BFDA473D878A7A82C624828C534D8460B716
      478B6A331EB599E3B8784C07E1D194066415F82D3AFB58C09F2C46F735F64D41
      4E74832FBFD01E9599C17CF3E5533AADE12B1317C572E6C948502E3A19E296AF
      187EB2BCC69A12F015577FB96F6AE18CB51C1D04462BD744A6CFB0874D068A70
      E0B9F653ABCCD424966EB8C9040D664838D4E0649D5995C4831C6E7E8F0B2496
      E904AB2C25B0E994F8F436DC18A7DDA5EC64B6E0502EA3BA970050AE22E8EF21
      843730B26307E190FA20E752E8D9C513BCD036CE5D94F71DAE51BE8724834253
      659D14B8157D1D7D761362168BEC1C47FD3555D702EAC318C66136B62E44D8AE
      534C5908A24D395318284F9E649D204D956E190873CEED72A11A89CCEC0A5849
      E50D390BC56756223B28717F55E28FE0352C7FEEB0339AB0A88D397238515115
      6D2A3A4C8732862F1CEABDC5FC368CF7E22855A9EE80F22FBDA3204590404249
      370EBA78B9D1AE419EF4CD04BC8B5C04937DFEB5B035712A4621E0F95DE1F3E5
      BA1034051E889A10E0AB19C554B0C38C2228299502143AB5821799831D34E8A1
      43DB60687BEB0CFB8BCD72A7D5DC14EA752286E1F6562CA3C788F711B962AC63
      84EDF7398195C21BFB29E8FF5C7562A26A9421EE7B87EE619D300F3F3510A7FA
      63ABEF53D56ACEEB03C1E4F5DBB377737D13FEF418B6BDF55E977743B2453050
      B98E887020E011CA611EFF8030A8740B067995E4306EDE600636720914A07423
      4A12B8A1DA4228BF7149A24367F7922EE9C0F2744223C580292939FD753A603E
      4B297739190E3972022FC8C411B8267DF72AEF92B345B880166698E414A016E4
      CACC36DF675575F6A30572533F982C9C3F2E9CD7BB2BFA190A6C5E8A4DDC9DE3
      7F1DAA34935745A6D4EB78987C5742286AF61871BA67983AEF310366579713C4
      3BB11534719EBEEE623C4938AD5D75BDE54A7DFB32E72AA420BC9B24BD329A45
      332792E30CCC293813AC115810111E0C3EC368E210E321B015A7A02986D97E79
      F6B003D880995332654B17243DE940A6B21ACBE211E7019FD07E98F56028309D
      813D17F69A0166E0B6C0433BFAAE1D1D7C88835D62EC21E1C0CE196EA7EA878A
      3328DF096C23136423057067229529B71AF645A13E2A9258CC0A25084430B43F
      00721518BD67AE6251AE0845AB140700ADB9DCA89AC6ED1781EBCEC9EBA37333
      47965417423DF8175EAB2A700674AF8368865A934E63E7DB09B135A2C09275D7
      42967E8EFFA5649EA25F25979ED40F815825A36B0C54DF3383E6E5C6C3D767DB
      5BD491E5900BA6A894204A7531A373306E59DC82AA27E299B2E2C85E2EA54646
      CAAC5D4033D3E054D0C6F0B4C2B86460F28228693469E73789C42C0057C209CA
      8492002AA22D05BE094D04D403379CBC2B067BCB372E1D208E212AACC079B2BF
      FCD9BE4D1E35DF25CDF6CB6DCC480FF0A8AC60B678845600DF62C64B77075B11
      6F0BB34D3FB29E8661959B23DA719A2D731E6C1116003713DC66BDE8C7683699
      97B438E7706069C773A8EA150A70928662AB46936589C93449D1A47F7C7ABEBD
      755EF03759EAC178C3A1F405E8145FEE89F446E7D8B1CC867A0DB536338D3628
      AF105BD1EF539348E2838120C7C07D19ED50590B2314E2EEE6AD865A6E423905
      DE4C205B382975900C6CD2D1A985D15319284158829762E7C17BAFC45466C12F
      32FA9312C75692720C9CF2FE0448DC98CED2295A3A59F853F009C8D6A0122F62
      CAB63E6519F50C0B70690FB1860EF92FF05D0C7134960C591420294826B01E3A
      67B394CCB8F743CB7383F1EB7072FDE2ED2DF96A43564A05979240793A2BC273
      E7210A13C1405C1049B064D32891122647EB06B98E375FB45023BA379DA9929C
      70DFDC3B8A505F11D2F264C46F98AFC2D007932CDEBFA2B04B6DECA3DA4ECA02
      B5745E55AC63851EDCC2DE67E6301D71863FD5CC794752FEE773938CACA477F7
      B2920C231C9D7E3E9324F8655C430075C405E770D7A8A821C7DD578F70D2E9FC
      43FC16AA7F40D5D9F14D5A6FA43902B692267B0F51CD942A6530545A09DB3175
      992B55DC4AE439A535CF2B5C72147D66D33E0F5288EB4BC717DE34ECC5FA6E15
      12D97D9CD96039E7B097052F0F7B81EFFC0068117DDDDCE66F2AEACC55E3EC23
      171952E4C43D79FAA9955300C64BC7E2974BAFEF0248B08AD0524D7031E119F3
      DB28099A92C30605D361F0A3D962D9EB7A7571048FAD406B2E557F652B063295
      AC24805E9E5ED4965F8A67150805E20066E6019723C9EE063BA907E5C590A829
      F3A430A751DC9272C0421E172E397BC72E83B377ADA6BE6135A8BABAF51B3148
      2C6293389C61F58F30CB66DA20AD8AF83D8BFD8505B2D8CEB113B03569E05C27
      D4759B0BEB05D8D36144D970ECB12CD9BA403E7A9F805A375678DDD88353CBA5
      338CAA8502B888C8B0414C3295B50B49C444698148AE65BA5BDCD15A4A811BE3
      36A2EA39EFB6B7A6F39E49C3918EB2BBEAF79D073D696D466116B39AAF43AE25
      28953D6CB34E69C8586FDB39820379827A9F45B0AD8B31BC9EAA645E4C8518BC
      A22AE71B8368EF58A5D9F9F8DAB9906ACD0E62D3BE130091A7FAEF0CA012741E
      5CF57D47A985739140A6BA144AE34C701D8411056A687FA1E9DBE091B9083D3B
      35A956221A69E6CB258693694A5565B932008A52E8E723E38AD60A2F0013B96F
      F83D0D30E592043487401E41E526727E10D1D479299B01C087B7E27696BD4906
      F8F9FB30FF61D6830FB23A247C52AD265ECA0E0C2F650307BD12DBEFA5784B55
      BF176FE3FBBDD85AFF5589F2ED6F9D28BFBDF597A6D7760E9CDA618DE479C458
      D719023523B32A1B9B941D9A9BFCA106240B334F9CD7272068F652115C71B0C7
      412A389A17EED807EA97E2ADEB566B13D6DCC156015CE60D081CAE1715981BD3
      DAF6E1F4FDF9D1F1A9F3E6DDC9E9B973F6FAFCD4797BF4E654361658B32555D5
      F70D727489E075BE41863389181471FCCCB5EF26C4070BF9BE24DC235AF4D320
      5BBBE286154BC6A2C42F01396FF06C4F12740D487EE50C1232DB52580C2CB359
      EF85CF6523CFC5086BF2637C041969290B703665CB8ACB45F8B9E43CE9AFFDF9
      6A7DEBBE3E6E4270797CF6117786E3C88A541F0ED4DD394BC8F3F771BAF35C56
      55944CDD798FF136292A3320A616450375B830D6AF99E6CE4FEFDEBD3742599E
      C9427B69722556652159BAB1724546D5E55BAA88EE0AF6D22B1F7738D7D97714
      B27349F52691C5C09E09E2C8126AAF2FDF98D583032ACF06124818FF0A9A0EB1
      2F33F676DD57B57312065132722E9369D8DFE150C49F92341A8024D8173BCEF7
      1CFD20BD6DD758AE2843CA062B16B753B8FD99AC93B3AF64E92D0ABDBCA0BA6F
      1F441F75634915D694D56E6F551412560D2EC834156646C14965995265EC0315
      3F2B0BCB4B2B6AC4382B6D010BA240D70C12157020538812FEA5EC5444C5F483
      FE5818B1A5DC194286D270F93FDDE3D268EFB2664BAF4402D92A6B886D4B601D
      8B43790714B5C2864DC00778B934BD70F691C697986BC815FD5240894864F211
      9C1A1AAD140AB46650AA8091728CB04A94AD2A930C7068F96E12D46DB255A4D0
      F783AC3A00663E72F51113A6966BDC3087F535D2D21F0EF2472CE1759C83BA91
      EA50BC55B4FE5655D7813538BDAF9AC8BDA64632695B6533F5A6D8F0B7B75EDD
      39D3643A8B024C6BC040CD7D2728DB99E763B990A54C4532552521A694D3A2C3
      1803CCE63CC0AC0CD5BED81499E1A90199AFE0B2B46F5B47D256E108405155BA
      027A9BE54EDADEA2603B764E4ACB27FA77946B67DF74AA289FCEA70057946C02
      19BF97449C2247461AC4816F5671E059B94F5CEB3ED92A4A706FCE593C028559
      2F7BA7283D5E849951ACFC4045B962BF5BD9D45B4BE158A0C78C73E5FC8272C8
      3DDA5131FF1F33DC466930E1289643E795ECE3A43CB13B2709469CB3D935CE41
      F292096D3B7C5F2FB92DE47B102E63949FF4E0C3190548D1D8997C9EEAB72D28
      AE8E2B54C972BB3DD10FD0822DE391E12B99DFFDCD0AAAFBCB39177EABE25CF8
      AD079F8B4BF2B803253E466F3B08C69B733C3006E1F2DDB192908C9886480CE7
      431A0C2C23FFC12EC52C90B30BB0EEAAB0541837026CF7E6F35708F941F81AE3
      010B9C7BE0D728B96475E42499E19B8EA3B07FF5EDAAA83D4A653D0588AC4069
      95FB843BCF590364469091FDD2EA2413B5B4614137610907A02A4A94C0119016
      121607CAA485C95F985E6DC4CC5FA0D6E9EC2A4306002B4EF23DD98AE2FE809C
      6C60F40B972D93556EAFCC770E4641F8CDE4EEB5A1606C2BFDAAE55BBE395797
      7D4144A9F068A98FB34184D0086BA46F2CBB17E6F9A5F337E7E259D465DCDE3A
      BEFC700ED33D5BFE74C9C469366D1166F8EEB22B04D796BF004D61C8604D7177
      58D84D5A6EAF849866726914B7A2A2E19491167E6768524832F2C8AE6AE5AB61
      09DB5BC5F2CDB3F51800A8952B9BB71C870039A6A6BB0858ACDD104BC1745FA7
      1466BAC9B3CC305C3C847C6EE349FEFF972493CD22F8FF4910DBD20054A4207D
      2CC94770E902225CC043F7155EF6F99404D6DD77FE46E87DB0F4B36A0D8D5B1F
      5F63F8F46493FA57B1EA1E17150BB252C9D3DE0C5DA3C0B7346828C2FC4EA13D
      652493A543A6A3E7E334998D389D6E879ED8E132F1186AAED27CEFB21C9B4EE3
      A5DDB09FC4AABECE9C86B8578A7ABF9125E301F9AFC380AEAB49B12B3C36B29A
      CDE4FD4FDDE6503C3B16730DB8AE12162318965516EC905D586960D9894C17E4
      416919AA4291F92A36C9D2D3DCE63013B8A1B9F2AB9E939F6C7710A457083864
      46008708AF62F9305D938BF59913B8CDD955DFAABBE5C3E6CDFC4263FDF87AE9
      2B7360A55708654C83547C954B63C9F267A50402AAC68F5050AB00BE3DE6321A
      8A93F256CAE1D9FFA7BA4F4F844DB36264D8DE0A6EB0280486A1506375D547B4
      9F44C92CDD346A13729B6282893A6D5ADC258838599F00B7DBE3CA162CC0C503
      840FD3814CDE494E72921931C4EC167B6C8718FFA14F2FEDC01E2691AEE8BCE9
      BE9764BA85AD56C6DB1937A7088721DA4AE5482F79843D1E912ABF14C5F7D492
      7A540A53978EE78B3249BCB0872912861845457222CC9C2F900B5DF2335B2973
      7B4B46272F38791BC4E88FF24F26969911657438554CB7B4E1CA8A7BC96814C9
      884F32BA8591EC82ACEFCF93249267543E248D6A704280E5B0A10ED84F2F8C65
      B53CB6D1F2B6501AFB2E9D0DDE213E5FFAFB231865F7DE89315A3987117B578A
      3D9F50E6E614CBB1975344CC00AA3E269ACB73C5A0906154FB5200C9593BA5FB
      764BD37D694E6E4F0D22DF2F0151E8BBF6386EFD0053383879FF9A19C0E69CC0
      12F3533576802F95E1618A9232E6183009CB6A235703CE22CCDA5FDAB8425F0C
      411CC7B0A54CE5CAFFD301A0FD3F0A2715E75465760E755DF2289C84B96E3A20
      4BCD12E6AA8802508F398A8012381292F5453427F1E12C98056D6F95A608A89F
      B35947C9C2F62C104EECFC104C7AB374842DB9DF8022B139A7E1C829D64E4BDF
      A908A89256980AEFA1A11ACA8AAE7214A4F819751F07F58C4C32BBBAEAFE9EA4
      FD98AF43796631C04164B655F25C0668E75B67809E274851FE439469CD3647F5
      3F74764115A6FACC71BE6EA9A41754067DADA6B461E546B6B7DE604571B67EE5
      58AC9E982B71C058B5140B814DEEFE8338E84000D91AC8085059A68164CAA2B9
      8759BC2103FA7707F2415E942FA19A0BA6B58DA37B2CAFDD3ABD385746CECD41
      BFC2BECB255DB595175103218282E8A252BABB46F92DFCEE506411D66B02AE1A
      6A7D102B8048834B208B5C8AB9B1B56EA62EA0D43B4906DB5BB348350EEDA906
      016C180D9C1DB296EC60DA595E18582887870BCA73257644FFE9543D46511CA7
      B7B7B70EE5B11D3AA7B70189A05168D68F55D5752FF9A0045874458BE55A4355
      05716753FCE8376ACE0E027047B6FB0325D575A946FF096BA875B7D3D4D3D6F7
      9C9DBAF2B6D3B3B3B33DB54A4A4AC23AB354063F0F27A562977A578AE45B38FB
      FD9C2BDF720D7C3627E917A1359EBE951D0C70AAEACB7DB9B56906E4251C8579
      A6642759CE1E89D1DB7797942E16851C6E13507EE300937C27612CCC5707F1DD
      04DEA1F7D528468A167424515CE28BAC72DC4B81036F480A43CDA4C0BB6151C4
      9FF3B7265360F638855DA47328DC61D0ADAEF1406140B1F3AE878997AF4FF655
      C5674A410D8A158666C1FE7DD083FE17C15FA312685AE47528D2560BA56A0E51
      6746096583845439FEB076FF542748AFA004FFEB510CE08799ACC45B8FC0D115
      96157AD1F1229CC20389A96238076543D1BBA934D73952B17408BCCFC46C903C
      14028FCCFC294300D766206509207C04254410F175E2E503A022E90F167BC8F8
      61344F72A3191211644623112113ED24669BA4CCB2F6A2C1D6E6717863ED6659
      77A39D11950857A715C3CE5750291C4B6DAEBE1FA0EC9824232C965D22F76098
      B49A5FA92120154363A646471C0901AE0E702D946DD30E9D0FBAAD12F9E165DB
      2A89E12ABB806417536E61418F48D805F1E3BB8BF0165BFD32DCF86B76ECEB7E
      4B99A65D94F9A819DEFD83856F2B0C929C4F2D85AF691252CF275470E23BEC5A
      581449517D02D129C6B5EAA324B9424968C11CF18D93597FCC8E0534D8F7B92C
      72A98604B9FE640D0A35DF57F024FAC2B09A7200930926D4630EC6A1B23A1C2B
      96319452593F7F88024E3E5695A4CC2D60080F607EBADB33AC8CABF77D8CC976
      BAA3FA1AD1BAE75AFB58D2BCF5A168E9F5EACE390EC88FB239D4B9BC7CB31785
      D4385840A6720503D905982FD109E5700C2E66C05235D520556DE5A8CDAB8CD1
      6199FEF8C3B1368D7263722C71800DEB644B508E75D40706E6C706791A97E574
      EC47456F8431E180B3E70B236E5201073AA24C55540110E563A7011ACE5C1F30
      D223133A5B25CA950744E38A677D5007B0D850295C471E6F074B94B0EF90E6A1
      E13807445EBE6CB382C19F7466E58BF7F19319CC4D2BD45438733EBB3F52AF2D
      E765F13B556C69F77794C6BA7F10FDA2B54BDDD954BD3800953738508D308959
      E79C173C04A2025C7A96A3CAD69B71E31A45A56434ABD2961535A5F67EAAA827
      A3506909F122F89AD8A4546A435C3F0450F32D08488A5BE25409A32F1C0CBC83
      2D5ED5CAE95C8B1DC65650BA6741C479393C10758F45CE45196772BE9A8AC33E
      DF9F9E0C2CAA52B2A84DDA4AD5AC137825AD6A156AD63FCC3AF48330C3FDCCE8
      B8F4E5715BDD7ACEE1982C5FC8F907E6B3BF90360A13C3A4757C7B0B9828E335
      F541C1CB4A6659DD5AD100BEBAB5D242CCB54AF2AD285E8AB4750562EAF177DD
      DFF14875FF58C5DAE8B04A498D42668A055A69E60DDC181E2027E416A46AAB91
      542A5B1270C74AAEB239820F9272D99753071213748A7E68D5BC773023EB924C
      DA90A65991E20D1CFF36C17DE01A1BB8155961D9E34808B25C17EDCC753CF3F1
      FB8FE8401646E504A311A8A139A0308475B9D1004CD34043B061A8DDE0337064
      48930876296782E459F33717D779F952F436056E1208B5F0131461784A4C37E4
      20A73492F41668A3A31A439E0EB3EC62107FAAA09B45DAADD754B91EA0A91B8C
      50E5E06420A6F8C7C6590DDFF0A1959E1A9524A72D4B6C8826C15F7ADC70AED8
      9AADB0FD1CBDBD78EDECA299A77707AA0CD067542E5310FF31BE59DE2FA9AB4C
      10C874453EDDB35C6FC12EFAF2B84C617E2338509307CB940D1DA641AF628BCB
      1E9E088A2373DEAB96D8D770B70A2ABD3D1D6C6F91EE37E0229614E5068B33BB
      09717148D64A0D88B0093E1CA098C7ED1BA5B38E16ADE72C7DA35259297F278F
      7784212CF28EB2CBCCA8C4817E540A18AF1E8F6567552B8A6ED56DC354C16C99
      5D20EBDEF5A320C3DBB0FDB5DC8C42CDCA54CFEB4C362C55B1F3BA1535DADE22
      A5C6C94964AC5D53252B5AC40BB30B791873F802B900551A272D4269730B61F3
      EE62E3132F2FB6B76887D49E6D0E1DBAA41E56686530225CEE21AE43A53E4701
      DA98A85B3AE3910DD89B0BD8F31657CFFAAA3D1BBE6706A1B7EE40921BDC6369
      2AA7800C928BB0772D10155DB713ED221453BC8F3E56916287B7B8708A529C00
      DC9BEADAA5CAF540E5CB0FD70C1FB6B77E7C7374826A1036930A19A5F3BBA990
      C021DB6C9A067705AA6B70913D56DC62076B6C857675978613563303F4237116
      265BE718CED24AA7AC6B0537539CC309D0D4948731453914C78D823D304A3B91
      A6C612AF581758CA505064DF0B10EB3E10D0A049E8B3FCF23987F26D2B287641
      C2C70D57FA935B1866CC2771EDEBB62940BFD320CE0025C922FDB09D99434F79
      B2E51156A201C5377025D911E732640254F5333831EF7A51784D9D8B9577B2C6
      6289FA9332F5815B70E853691EF04611011331320527989037E02E9318D2C613
      64110DD353E67D823C09E340C6581340B63BA6DA5570C2A219E514C7776AEF0C
      F838BB0A2632D1826DFA65003D0E7D5785BC8F8C9DF91CFAEE292F55F11DF796
      40874174771FCF3740009A679786CFC94052D441B4F4ECF90DDFD925C1FAC039
      07553F765EEF19662C40265075D39433B5B947F6D26DECFDE9815405BFFB2F35
      B37FAE24208B24C465CFFF91737E5C1DB44C5543288F0D0B7FF2BC67F9B0BD92
      F89AA0C02F36971E62454ADDF5229DD00965E1AB875218C7AE53F087C4364134
      509DDD79D18772DBEE21B6A47A407D3F5E9EB549AC4925615051A8E5D1297466
      DE50518C2B8B156405E36137398ECE0E4DA0C92CE8E8F5DECC35902D87C0DC17
      3C6825643740178099ABAD8D4B3105F6726CEA148DD892AD2185A4EFE4DFCF8E
      BA6FBCAABEBD752E377983B47443E2D9458E7D71CAB1D4493460D1C7CCA62B1D
      023E2D181F328AF11059957D5E655F6C24FF8A2A3B8CDF0BFB204A805CD15CB3
      EDC1600824E60744C0D76D72FF11A03010DCDC359BDA2088B1493ACDCD5FB3B9
      897814ADEDE440CD5B5FC80DD15BBEA6731B091011E3359D5B2AC4154FADB666
      531BCFE25190860A72EB4647800545E1BA6EEBAFC134585FEE003AD38D18AD2D
      F0A6494184D70DEB50B79B8D66BCB56B08BB7496657A63BD359B1C089AEBCBC1
      B21B3158DBC9E5B3F44A4FAEBE61DADDC5A9D5E39EA4C72DB6507C453D6EA15C
      BD21E8AB5C3FF59223A8D5B438FD249CAE7D7B9CFEFAE8BCA666C71372415275
      3569B7C6602F8DD094EBC375DDC852BB39E7FFF5BD0C58AA7E37363C6614C4C6
      CD7E35C076318B132E29571927B9A90C271DBF86C7C6097A70D71E66405141D7
      3B157E5B82B8B32B437C3367E72339DD4A5F7FB7B328F3093D07145FBE6704E7
      B10744972B435F08560334C216D115C2711DF7A7A15C805311B33F39E062B3D8
      790141804E90A53B1E7EEE4F959FE69755381F32D1E7F44559779C4AC3612EB0
      2AB02B8BBC84BA8ADB2730BFC0EEFCB6E335E1A7D7AEF9F0CB6FD5DBF0ABD66C
      D6E157BDD176E157A3DEC15B9A750F6F69D57CBCA5EDD7EBFC34DE0247A845C3
      B8305FFCED755CBCCBF3E13EFC5D6BD5E9BE7AB3D15CED915A8693D1DC4C094D
      295CFC03FD8FF2D215D67A4CE27F34E1BF4DA136189F5F1462A670366702D341
      9C5C7EA6D70A9DBD30F5D0887FDFE57A4ECB8F9542E45885873D7E91EFCBF819
      A0B788115C003CC0B44A93961ADB55387CA95C371755427F3008787D21030D0C
      3F38D0E0814843CC1A2076A058C7C6FB404FB6B7249B5420D994F3AF0AAAA9A6
      8332F040490D7065E79429E58EB30B1F77885B6BED84EAD01722DB90C29FCC68
      088DABBAF8FB6442419F58A36245913CD177FFA5A6541D0CB3FDC5ADE10F6555
      6E2E5492E5A159085CE699D241CE6EC29C6A8C9B111F464C0597F4A7C03FA3E6
      18C54B81B2369912F847A29C5EA29FD602DDF269DC7F6110CA3F0F413A5F4D44
      E87E31F950051F3857E28E70AB88865485A6B27BF7501C22860D73B8CCC6D3AF
      EDAD7B413D9B46C08A8E15A57E150B33B348CF9C07982A79A62A9017542D9327
      990B1DA6D84F78A28897CEFA91457D4BD54C4DAE3D8429619DFFC52F47AD6616
      CBDAE52A1C875A86323DE658B25D326A9EBDABCBF0E077ADA6BA01D74A2161F2
      78E4547441DCF605901129EB1EEE19F329018303CC38DAF57EC025A5A8510368
      593705D7479A994E48A654328A03931964CF2D0EACD03D5757E7EFB0D0425651
      8343A6D21D3AE27074B8F4C973B4D4FF95C2C02A97C2455708BF64B4A6AA9C19
      C02AF1D44582E5078D7E039185A92110EB6A5F8B0FFA8DECAA11662633CE19BD
      498A6624C608F9005B8F27619F221C1FA154AC43FA05804BD6F148852CC2A40D
      4705588CB2AA45BC755FB644FF3282B7C18C7851FEC8E6F0E205AB2FA71B9B99
      C60B4E2612E1C501C894B0C208394D93511A4C64358D5D199AFE387978B9D2F0
      972B1368BC28A5457C3B8DE8CB777D8F082D47AECB82CDCC2EF68B8D27B333D6
      8098735819450B32420AB80FB7190DD45C76025B341E9B3D8EF410666FC64A9A
      248B18B1948865D3086D84ACAE320F8DB05AA4081F0314D08397AF3B31512E7B
      02E6C87A6E1EC05D3C4EA8911B094BF733E7177815F245497092338CA2A447E2
      B52121EE225CA76998A4D43DEB5AA4159AEE9EC1455690C1B3E2CC9D15741AC7
      B42382F663A7FEA88963D29F617799AA3A737FA25CA465D83DBE662ED20A1069
      4172D632C05DE4262169401DF606C51855459C3AE6EDAFEE60ACE220A37B950A
      70A6456A66891222AD53A52ACBCA30D688A2D23032E513A415ACD979672AC8CF
      4C71FC8C2ACF0BDD678724685AFD34EC690E3D5C014D5C713ABA569097EDDD3A
      49835112F792345EA97AAC2B6E5342751E82FE73B75F160A3EC9C3B9486FD9C0
      431E23C59849745A3E4F987E770BFFAD8431630F3F6665322281D1943BFDEDDE
      6F06B3572E29BC7C6A8C2B5DC542A50CB6ECE9AE8EF1C577F39E596680FBAB3A
      84185BB5029354A1A310A18CB00A24557CAEAB0E2DE435475D37125CC2CECDF6
      3F638A9B571B1F7598DC4ECD5DBE7C652D385BE7896EA0B841869B45FD239D58
      04694579478AF5C21284E8D6344B9D825C202DE9A44E2E2C4F68639A9E4EE838
      224F81F73B47E67048C0F2B7A3522D0E5D56EF3BAEB871AFE446E9D905F24379
      00AF18E0F82E0DA328EC9747A08209F79E6C365CD773763F5E9E1DB4F736E580
      FD845EC5E5F38155176E42BF81EA42A04FB4DACA7B05F08122D873FDF45845D7
      FDCE757F715E154DE1B1C2BD48BF737E964E3879D40F2F2E3FBC7EFBFDC52FF2
      BC3DF4746EC6699B57C397B137ABD4EBF03861AD16F23FEE3B548A541544E552
      35495EA474D803F6E507ACD0D3B53BBBE22439BBE455527BBEB7C9DC4B174043
      5B7FB002CD6DA5878B3D4914E218D2E97254713B6EF55314AAB35C6C695CACBE
      988B197632914D7E71CED030236BC3EF52B1F8EF8E3A67EDDAABB33375C41E33
      DC971CE1C78C7F416E67D90A62837A7FDDA702CBA70168D8F86FF86FF9868D22
      1219CE393157C3466809C25721089EBFF8841D4FDFC9E37929B21C4ED9B4E214
      13A5F881FB799F14DBF70DF9F29A7687382FDA5B8F8378106D1099625B56741F
      0045CFBC54DCA4619E634B86A26B192118A0548031FB68ACD2A522B19700375E
      9F84D4AF13A942D125C02CF0CB0D8C3908F77E5947655CBD30C4FA7DBAF9F2F4
      A28E91BDAAF0EFDB1FCD15CCE7ED9027831337A9878F2CE10B83345E5E5C9CCA
      E0E07A11122587597E48EB349AC182B3C3FCF661E12E8F737714CB52F95CBA83
      BC0A090D63D819808CD1C99AA9BB31B33DDD59460202217EFF41F6744702CBB5
      2B482F1B5EDB5B380D9AC58361F625E67B59014361C2BEAA64AC9CBC4B77D982
      64B402A11D66BF826AE7228B963F571D365E2A0C9B63500097834572A11BCCBF
      E156EA99C865DA0177F5041C9C84DCBDC5705A9A110A25AAF025F51D9EB8D15C
      D421C007749D07AAFC00571CEF704DCA3CD49F5AE6E1A950321AA8AE802EAED9
      B6FB72DB970CC48FD451F63E089713D87480F47109F551F0950F061FDE3C073F
      B8E4D41880EF8620138441E49C9C1FE3F9875106E8315307FEC024E96B8603F5
      D5E0803A48FFF7C70F2B4404B2AAFFF8A1546AA7EEFCF8614DD0A3C1B03DA600
      B324768EA3594F35A35D3E96AC62054D5E81E27B985862F65FFDD6D36B1DCA02
      87F141D51437406D7A3D548D188DC6AF86584DE9418C6366330C0E4097E63B94
      AC5952C7367A54CE842A5251B33CECB396E545E8A4EA961161C7D33BD3D1C8B2
      4FF198D179835F831DC8658308EAF686232DD83C592B7F3AA34EDB30398A5C0D
      63D96409EFEF011A5C8184656D06D865467651D4F1FACE00F851B251194CE305
      CB27BC56476157A749C8FB30E6B7AC4B62F23F598929853D4831895F7D27CF58
      C0059AF84464FBCE4E3F99DEA19E7078784818BAC346887012460079EC3A41D4
      3FDB2BEC1886F5429B3494B2F05AF719E68C8B40374F9507549E9BBB64269B11
      CD9D399E58B988136A36FD249A4D620609D9E3DE1149D81D855ABF2173090C15
      64D82E561A4CA64946FD8694664394646F5F2B43F8E99CD5A2DD61597D85BBC8
      A025DFC46D2E4D8073F17E507A27AF4FB077E630BC359526D55B4D6D818CA204
      12014BC496C80CA1982A4AC9C0668A7A9A6B37FB463E4F6AB452D424A0B82713
      8543D0D70FD3300702F76FF02843369C8D2B7120739F56A37403805EE49C062A
      FA5714236F18160AB457006532AB08B87C487F4B8956D8115426B9D1F7641F9B
      C73655718C20F8F3E12FBA3D2870A29FFFFB175D06E77F006949CB56F5D1B071
      BD6A594EC1EB030CF007F59A3AD4CD4D488D7292CCF0F96398D715F2AAE33C8D
      FE761A535E0C4E99E7497DEB724D150A764475C74A0507FA5122731D996EF03A
      DEFD4BBD903C289A7AEC1CCF9F78E07D02C0045A8F8EC0E35EA6EA9092DDF0AE
      94F25CA4AB73CB643863A041C0A17AA98F936C52C8E5E2B0489C695478C09CA8
      F1B9EC475B90466A823B1118CCFB75FB5BAD29FB7C47AE0880FD8B0B0D23A448
      BA57B0334EB863FCF1E5877382F68011B08F08F8627358EC112161C2D1F95F08
      AD820952E5BC43E784974CB46818445981E06CF344D995DFC8AC639F0756B5CE
      C6221AC01B6E985F9528031337EC8F34CD0BAFE01B991503BF9DEF81144FD972
      BF0BB306127D17893D59C2402F0F4364BF59A99A353A286733A495C80F94A9FD
      70344E601B36AE67B95C77116BA9CCC5D894EC8E135A76650D1729F4CC80C010
      5E71BF2EAABFC53D08EF547BEF7120C51739BCE6105A341C221FA00E68722CAA
      A069CC86FBB4EE9BA3D0650C511BC58941F04F7976F250101F66DEC70F7F7C5D
      B86C90B57F725E1B7C268E4B927C420D3C81B21061C936EF60144B4705DF19C2
      A998A5B2AA9A26FC80739CD42FEBE026A87D841359CA076F1B25E4E4C5C3E444
      A01D21AAE315530D9982E459E80AF03AB89BC4A93CC9759AFB18609529B25FDE
      94FD42938BEF58BAE2D95235831B8155A9329928C1C58E79A7F1686047E811AB
      75DCE85EA690EE9322C23A09CAC67140B50FF4BB750AA0BEC47092FD05737C29
      838620D61729F94A77D1467283FD80E2D19E8E8802DD1E65E440C6BD28E5682C
      33FB7BA21FE80A1E54EB4E695312501992A26416E7DAEB4DA98854AA2053C69D
      BD43E7D51D8E498B920D9A33630C22607142BB08F237AC0E84EA708AA27048F5
      1C86C08B73907A73C94D5989959355D50B514CC50ED02400488DF31A455FF2ED
      8F39B965365D003F4A8CA45E906355A74F42AA28DE2715D9048E4588829EB466
      31DC8A3141EB800165F14D5272B086905C41C6E45986216449844E7DCCBFC4B0
      03590F031F9A5FC158676A1618484A0A5155545D27D31C20185C87234628ADEE
      73FD0B0C80BC6343C0CE1929BEA451E0D37A6E3B87CE4FDB5B5A5E92F9BF64C9
      C027A70920ACC67734F021BA833644852363661AB24C34420007024AF4229386
      4439E3A22FA556AD0AE810B21144F03ABE8A1643311680CAC60B69EA0CE8186B
      14D15E7D6A6974BA27C1155A3373260A22C864AB705C01D13CA03EE568817D3E
      9642197250B5949B95276A0FE7369965C1216209AC3018E1E9E3516805C516C2
      08846F74249080CCEDBB4DC75366493EA6177396B9CD61893F29AB78AF08A023
      830B850729AEB22F35FC4A80E9A41D791E8AAB742094B9511AC8636D12CEEE8F
      84288E5C769270651F0ABB51CCCF34BF15EFD0A59D0A6BE4BE932564DF400A3C
      08B150231C19713B55D53FC3781002EF44C1B7746EA4C5324CB9DA4F9C67A675
      880A38485A6058F2F0417249C0C90F31E82B24D157E559E83718D4FC0E88FC84
      CDBD1CC1A1EC4C4412A59109A9E57500A0EB45B69AF2F6D6698C807879126664
      A143887D104452F5166ECEC9E5C22246412A59DAEC47C24785987892D84041D8
      3D90A0C3F26004CC0272FBA66009C2F12CD6F60560430A33518828CE8B8C67BC
      29C9B0F7FC1CCCA92CFE6E1DAB5A2E1B87AE859F27BFD9DEA296E5848F527A31
      14B3582AF8A522B7E89775B81E4EE125F0B523B8E44D168BA4555DF539362A85
      ED1C97DF7E7878B853E07DA82A8B17476C1FDF88B4998620BBFE9B22F8719190
      3C4CFA28784AAEC8E67F7E6900F85062A9F0A24C0ABA32F45759C7A3BB792701
      9F3CEC5C42E17D71F9FC9D520393526D7FD025D08C9FB1581B25C9151DE6DCA0
      18418F970217236063B953932A48A655B35DA99AFC0D61AFF4BCBD43A78A1471
      5514B59CEB7B8429A02DD8DEAADC847D431FA3240AF41D05E47547E5667E2764
      FDD5791A186673FBA0F7983684B082F51DE5A8BE279444726790FC69EF1429C1
      097A547AB35C140A9D029B9476647F1A9E14EE1BEB704A38E98FB7B7D02154D4
      8D9143CB40F11E1556CB198AE87B3590E6D039222D0C3584309D28C4564E1C8D
      2C65E18D56DD135A015122D11C02E9FBB8438EA5DF5B7300DA14E2CDB2C63C76
      E089C98AD64F46500F612FD2FA026FC53D11F82DABDCA6E39C9B159907FB759C
      89343F64D09BB74E123470C064C8817313DF230740A38E6769065F7F9C3A2FD5
      E713D2508E3F1CCFBD13D5745D79CD18E9621C0EF3BFF12C5409F72037028714
      5D26CE407ABEBC391C72A8D250462E48FA41AF0E8755C31C929DA7EC0F460FF2
      07901DD48CA56FBF34CF13BA6618E2CD30297A67D9AF252D2BAA049B0E8D825B
      D5948BAE5A32384A4E873C5B13CA66291698F15B000A58DAEE269486BD628146
      C03A87A4DF04D89A86159D585B4A4F0318B6940FCC659DF035E873FEA2D0F4F9
      D0BE3F57EBC1C6B76E3D480E6A906540913E708E0CFEF8F6DDA50E9BD35A08DA
      37A56F54EEBD8EE4D104863DA354DFEB70CDF6FB9283AE0E9C77F3CC5E45324A
      EC2D99BBD76D1517C92CED63CFE8A379A1657E192CB16A4BBD16FAE6EA3ACA10
      29DE38695326E338CB4BDB5B8C110636484072ED58A33433BD5CCE4FCD659E75
      AC0B1861D53D5EEB01D25C136E3AA674BF8CDA548C632D317B7BEB35B9609DF3
      77BC1CF4ADCA0D333884C905746C56E1A79DA8A4C0A2E4F6BD5D2C298349D1E3
      4861871157C4AD032832F0BB2F494F990798FFC89C047F3EAC1BF49ECFD27DAF
      5EFF72C24F0F3F94F287D17585B79986F94A0CE08873D20EE613C94AB5300B7F
      FD047DA529AA99401C8A08C0B5D8D6ED2DC0D65718BA0DCB41DA854AB9E8CF4A
      51B837DA93456170187F03820A3D05F25B7CA703F974C0270583CF9F1959D13E
      281E90A7A8777F2452F2D883B4702CE98BAB1AEA726CDA4832E589E4A19053D1
      AE6127141881B348374BB721D952F1EC3C198DA48581CC0652AB9E10B3D22237
      ACA52F48ECC722CD18D1C5DE4BBE55B3C749322B62C65EC92D2FFB877B1CE032
      A06A116A6347E13595C5C0A0D3798AA9CC17646140CF236323FA1E446A25E479
      3AD9FCD612F2F6D6FB92A5EAADB454C9D45DAD796ACD8F3DF0B2431FD5CC9E53
      A2B523CDF84E0EB23B09E359564441EDAD9BA04120382E8558244C79A4C02017
      82D6618C1A26FF1F2D54D9D3A270DA4B10A90AE320C9273D0EBB11462ACE5BAA
      9E3008F3AF9B8AF3AD2361171905EF5BF728887C7F91D55359FE8CB0F97B96CF
      2A030F3B517124E428BC4587F0E4880DFC43DD23ABF017694327D141ED24A555
      28EFA8313E9AEEE7FD7E3B73465D34ED9482E87137469496A1CC9DB1B8C1280A
      B287E8C1C9EA507A90536274C2C2A6DB40E7B672633C58F7574E2760AE0046A9
      CB41A00D6CF79B001683197E9A4CF278D508D1F0310414D75418F534C2CA8C0E
      D3DBC379525C3A998BBCA8E60A2A472AA67E2D6311699DFA1DC64CDD5BA18C8C
      BC16D58BE37BB8F3059973D4F163D1D4C871921E3EB20B2C7ED320210DA12738
      E8128DB2556648D9D35686FF0AAC9F53442C0754B1BFA4666FF0893D95419F1B
      E77406469871FC6E90156E4D3C45C5E941C33C863E383B14D85AE10A9EAB485C
      F6750EABBCBF46CE247BB0D96562B0B2793FA334B420AA67E5E4B0C282A4441B
      3A8DF34C3DA098219D77A59BC794C203ED99D82287C9461E8AAA236178378D43
      C18E25037596792E4A5EC5E2282886A2FDF2B14A2A2E24CB45AC904D86E41EFB
      86D91F6B84E454E946791D3705BF1F47F4B91810F93D01875785E666C8C93D4E
      30AF797D4ED73203F5E15ED9B52E4ED8799BEA047233F404BE2A6B553CEAA2D3
      A717AB676284C7AAB954BC03A7679ECCCFC7319567D51F27098DCB5A63292E77
      463BC5EE14F57AF26C6B754F3BB6558EB599EC6493C128190C37EF42EEC1E650
      046434F3AB2F9F62D4A2EEA8AC4511D652841E144A88C65FE5F6A572C5CB2D4E
      756FA6BBB77BABA882694FC411CC0D6B1394E1BDB33907A39C325F010E0E7C9A
      C02AC28322FAB66855F6F3ED2FEA387C3A7FBE71E81CCB18260E431F70406F4E
      0392BA4FBE5F279B608C67CAC3FBA59212D5D3209D4857E32E0E6F2940A32238
      98A381EF2DDC94002AAC89FB3AFFAFA4AEA99792AF0D17C9EDAC8C38D8A0575E
      1717B49281A3F7D713859390796F1172B660C6680BE7744A74646993E775182C
      905C3E01106ACAC91E4A4B27B63EE8C2CE5C4EE967C2C269247E29549262D337
      887E5CF2B999DE2D8443717E767516D3A764E85280F8DE82BADA864145751CA5
      5C4FE5472242052F58703040DE1487CE6B1C2C9FA55C999F3B96A27933D3A5B8
      B565055E3E488391EE0ECF944997BE9601E54E1F1366A44586821FE94A568A88
      49E13DA5B3AF1404560D28D3934AF214F570A66902C09A18966505CBC291C5C4
      9BC1AF10F2D3FB301F064A5090BAF554A46831A66CD74FEC28E5C41BC5475490
      1776F2A363AB4B0CA98D96EA814A9343271DBF8AEDD1A42FA82A6496D600AD51
      0C51FECE905053B2F4A6D015AE31A0422370E5E413A7EA67CBEE0C72C0999612
      D4CB2F7B8699D8E83FC183569220E8BD5CCD5FBE5C21FF0FB24211079F93BBFC
      2892E1E73A695ED661600E8F9604956A97511C4A382C0D6DB858E9BD9A90C6CA
      7ED00F32A95C9BE9F6FCB0AAD1C2253931519863EF5551017D6390CAF125450C
      D11C47782683FAECF9DE3AA2CA6B9C912C9DDB9B72AE39E9BE9F4C261CF61B93
      510B3824D5E82B0A58484BCE3890CCA9C8DF96C10018865CAA0C4118BA6B54F5
      93378694122E26D3049676575425BA09D825368B4156966709234DB1D0DE80EB
      2F70C4C9983DBC7B32DB02AB8028810063A231E94580E80E0C38984E5579588D
      E54B360C1C10EE9C10302E005A4BA756DB5B6C4DA3D08A801CACF141A2CA87EF
      EA4FFFE0AE249C0DB8EFE8EB83A89FED3BC7C7D95E295812EB5E7318DD026075
      090F560DAAEF02ACF3BDDFC3260DFB7D6C05B48A9ADF05F0740992524CD303C0
      C1C19A94513509EE0081FBD10C6BC42810CFD94D379690829275819EFF8F31C5
      0C393F8471BE03C7761A057D911582F40E1935100576A49D6373A82D19167616
      8009499D34904B29FD9D2C11B09B502A9D5CD71EFBE038AC4206A062A0DE4C8E
      A6AA3181C0A2AC359EEB6000624E59A73D24DF30E218DE5A0810EC5E98C50359
      44E38760D29BA5589EE90DE558AB5C5B22B2F24D32E0064B83C06A383C04233D
      0AA621EF5407E35845E4521E72A8E25274B1825986953FA8B0DC7CB9828543FC
      FCDFBF2858D168D8EA07F32588CB700E93D79079D699E42B701D0D5D70B861A7
      518AA75046F6ADE05CE224F98FD04F6BC06DFCD9964A103A6FD8F8A5E2EC1DC1
      B51D099878A637E72C1F61C8630928BBAFE0D8ED2948ECC8233C9FE8B93B300C
      B0793A133A1EB8B280A9949D54512D19863CA9DE8C5D1587CBF5D230FE5D15CA
      C2740A9CA6C5691D8605202959813607874BE56F1719C4C822476818E4829D70
      617C402C9D82B813EEB1F61AEB1B62C576291D6532FF706FDF3903E92B97CDEE
      084F43110D64DD342C63C0831663710526AA8B0A47013B431A257E2F0CCBFEA2
      79F0E06C9988309FD119A4C994F3D191895181BA6942952181D9C8BCB65D4156
      7D3202F0BCCDDAFBE3D908AB75EE6A831EA5E370A9BB60148739AC770FFD0203
      A3E0E0269F2A26422AFE0D01BA39070A5585050000298E2A76A024B7E8CC95AB
      A3907531652D1AF1794F9E422CC09B395CB71EDB5B735D03D2D67AA908AE64F5
      272E579A7166CB195B8D03588F7A195AF92D9E6E1D619D4C593A6E7310F488E8
      19922BB618A23D46150C55E5631926A66BA23F0E8521CAEF30ECE64A701EABDA
      ADE7092066B663BA8BB853033AB33FF968C6BD50588B1994ABB9FEDCCFD56DF8
      82EC17F5B4FCF2F500A97A3F882E93376406F909C0A19ED8778AA7F1BAF9378F
      668640D6CAD3A4D833728B85397A804CE78D5276E04C6D6F8978A0ECE2F78770
      76B5F3867527B448EC19AEA0439970C00EB092DF2B37ABD1EA07F61D59329C0C
      7364E0987B05A9872A0A2B37CB23CA5C57694ECBB9B8246B83880F61B9421635
      62A54D319F8083DD4F2642978BD8DE02553E1994B214CA154ECC29B008C07A17
      D688D7E63C78DB4095F23552116E40DFC5022552C42852DCCBAEAFA2F8AFBA81
      CBD0CAE550F1C93428ACFEFA24180B932DDF0F1D71383A6433BF515557DE44D1
      DC910862AAE3CC3971092081130B7C18AD9B18404148400B186A9CA7FAAF5C7D
      5DEE9F20AFDB5C91291ABD3875B22D7BB15D72A3F6AB8206F09E9D2126F347E1
      7FD0E5BA2B9B95EA83C9800DEEF654D15C78A10A2AA46D1F146EC362DF54F1B1
      04831CE168151BADEB57A9EABA58A6DB84EC4D604C5BA57D15FD8A14AEC1307D
      725900A59CF5F3598A3577A56963972221646D62F4B71AC5BD02691B2EEA8EC9
      F7A66202942D9BC7ED8013E0A9C622993FB23C49884B53ADD319D2311574E15C
      1665A731916F965139B440DB5254AC5ACC79E6800955FB226E29D59325592A01
      476670736B49F32BEDFC8EC9B008FB8E25F691F948DC62563C82D5A81FC9A626
      268704EE73010C648741BFF3EF198A2017260166B73CD38D92734CC507996472
      E7D59DF32AC8C407DA801DD946872CA5BDE456EDA68C0850295346440D7B14B9
      D701C70C60D9587DC7EE3F1C12F0390FDE393E3D3FC79DC1FAE543A4057D75EB
      DEDC09999B47516C6EDFF9DBBE73C0ABFFAB7325EEB2F9BAE2D27D0780E3A8F6
      A328DAD9D77FBD8543AA80F73ABE46E94B87E9EE949A2E70B9D8E2A069BA2C0F
      93E47FCAC8A7724DD48950F5418D93255922D71550B53F652C2F75170E547A69
      6096C9D39BA07347298B976E9466C44CE8D1D57BE7F23FC9C358E4B94C4B1ECB
      0D16213F00991ACB181A4EEEDB206B7639885E613A503D9576F8E9B60D994051
      4A39E37B822409F46EA92183E87E873B5D9906C356666134204E716F0B748302
      748AE9060EAC7ED1948AAACFAAC852C6D53E07149CB7A347DD21BFBDEAA102E4
      E80EDD6BDAE70F241B163B66E79B0E0C52013666697996754C57938CB9CA12E6
      A41CAA049BD9BF02C28D2C0017A56D151187FF0090D88807540059A47C6790CF
      352778C7D471116C344D2200EECB6EE426640D16A38778398B8BE114852E16C2
      C6FBFB52B31123C516FC242537FB08B461D90F830242174D54F687CA087728D1
      6288AA6E3E8B8D8AAC72FFE0A0504734EA52C1755539E83270B0C90AE2220875
      A394A43A0C56D3F1E3F8354777C1049009658CB01717A796C26913E98E9421B0
      0F24286918D1472D217FA07AB21B145FF95EB9318BA628E8D766E90188019A0A
      A9B9A4093083EB2B901D3AAF64BF15D5658384D4840CFD6F8E2E2E816AF5F441
      D3E11686842CE3A9695C325ABE409CC7964DB2A29014405122DE97722671F508
      233228EE0FCB9D24B354E7F7CD62904C6586039E223AD528FC0996C3B1E6122C
      25A6CAFF7B744CA62299AA94F341A2BB5205F08C982A991AC6328E2C112F5464
      F1E87138936EBA5A0ED760F6518830DA0DAA0571D4A464E48ED20F606526EC0F
      756176A63CB2750E401D13E6F9C690F3996449BD9D23F88E87C83E5D7DFA53A9
      66CE8297D2068BF9F752BDA06C5668E3C2E88F23C5E68C56AA055F5DC9580D14
      3BBFCD6093547748BD14521100111EB41C2DDB27A5281FDDA348951531319B0A
      C9EFCB9DA252494AD82C4709AE2298842742F3C0D7AF202387340FD59A0640BE
      F475BCFE1780EB27383CAF272709C07805014487CE7BCCB814AC863166C061D5
      715EB2AF8E903190B24FABAC8A1D53516CADA20D12E70AF7F70647B893BD5907
      3871CB2BB75E4FB0F997F4C0328921D35096A4DCEB8B4C9B5267578D70378773
      9A649564436E592DBD8A45031A23F31565416D73BE003016746CA16DD9BCC5D9
      25D28A5591EFCBE37B3B9AF072331B451529E907F748D7DB6312FA991797EE41
      C3C50749E9C9AE44C605F9E523DE8C957B6B86B1592AE532561F882D2C6D5898
      76F064D3354AC0E24036E242526AA06AFD056381375D6B5F9534C7C44248436D
      AF60D3483428D317840254DC38B4C0E0F51C567C1D920AC04919D29EB027AF46
      185147AD0EA98B10872D588A517412663B9D211E92AF7C93F29664EA4C051C54
      40CC5C2EA369F62301575B4ED9267E7AF1869ACD33E93D4FFA0119C26571C9A2
      8F3B870E90DC6518BC3F5140608371F63DD9403E88A1F3F3FBF3FFF9F09D4BFF
      79F55FF06C2BCF4051BABAFB3BDA46BA7F1C8ADB0D8A0D2B80B42B0B712B30ED
      295356B00058887526C0740549238E9E7D7446F57ED9D40CA808CC63D04F06AA
      60B341C1F70AB3BDD91AD134FAE469205B9E7C505AC6005B79CE9BD5E89C958D
      4D1B7C1A7E50203F1C04AA429CE4969B82EDA8E756EA4500842FD38C4A805D7E
      1218EF9411AB2C251C0AABE100FF52FEB774CC70213B3CBE62D2138381B6B5C8
      3C2D5136599BE74B97F5C73BE1658152ED0BA7109E78CC6A89823E1B9797AD6E
      767FFF1E68CB5BA62F058455E7840783FA914A744F2C02D106538DCB70BA7164
      82AD70B472E924CFD9241F4CD856B4F834E6A429A1E751359F5676BE4930A083
      5572E8E877148A8E346948F493A64792F6F041BCF930BFE5BE170B0EB7C55ABD
      7F2A07FD58577B4EE24542F2E660B42C9C5D5DB643766B21C029636BCC51C86C
      EBC5CA63DC4D435DD39102AC8BCC57D83E7454FA31BCB83CFA3041A328720E16
      FFE480356CF54EAFB038BCF5F38F22BDFBC55910F9B23196B8EA5C7EC096ED2D
      038DB4895837F95ABAFDFB37DC08E407BAA3FA2A52680F64D88C517F5D17F34B
      8ACAC8FB73314F3AE996EA16533BFA51D1657771246BD1879EA396A46EB62F2D
      75FBE40A5A3A18315B621128EFD56678B2E07CA0635229C88D6339EE832D5319
      4ADCED3233EA26A12B3E9A8DE055C47755508459B4A9D47DC10866DA95F192E1
      D039BEFC708E22F65844837221863D4BE598BCFD8C89B6BF38D205B899C46D7B
      AB44DEBE01712387CF2A895A51790DA80DFC8A842E726F9C25A458DAB9277D4F
      24EF6AD2B728AEF97E99351940AB63BEFF7FF6DEBDAB8D2C3B1BFF9FB5F80E35
      CABB5E4346C6BA5F3C996461C06ED2601CC0DD935FBBD7BBEA720A6A90AA3455
      92814EE6BBFFF6B3F73EA74A02DC9E346E978366256E4052E95CF77D3FCF1D6E
      CC7472AB1592EF5321C6E4DF2C43BC0B2E69A97F4333258DC3CD0D5BC05FA6F0
      1B25CE11C66A6B5C1FFAF69D2FB48758822FB88FF748544EDE8B6A697AEFF74F
      9B36A374787EDCA069FF6DC1F5AF1C8A9B4928B0CBC575C5AA12D3DE51575A20
      87060557E866901A2CD9B038916C4FE3D5C9D9D98BA393937357614CDF8E0ABA
      A542636B4D8AB0910C98140F2FE3F22DF214066FEC35CE50E68F23A05B8A0C9D
      495DE50337ECA180C00105BAF809CDDA62D984D9458A20FEB6343B19B2A61B87
      1ED2E81EF2E8DEE1B3A9C7A9742D65C697D86A11DB69484A38C7B4B6CB3A4094
      7A632DA54E502AE0C566B04BB0EF5FA7170B98E0C0AD60F05F67C817D902A48C
      499EA2A865123115959027B87C9B127AE1ED174A21A5198B14EDFAF453B190DC
      FC331415E5C68F6EABB594DD9DCE4E5B19AF5CB15A150EF01C957B373611420F
      6B96382A581EA4E02C6376C58E9956ABB22BF939DB22629B8F4BA6F6BBEAC5B2
      78677928F9DCC294CDC8369D18251F9368610F25639D55E061A40504B0725C6A
      A27720B89DDB5690E51E183ACACB31EDB273A13A483996AE8288562E5A845C9E
      94C42C880425998112CA6A466CC7D44F91CF2415714976DF164AF6933099AB08
      BC558C1B9B7CADBC5C816DA38BAB82D7DEDD75DBF5E6C67EEE5F3C4B9FEDA333
      9776FEFA325B4A823CD156ECC37BBAAF6D71EE6AE9F3830185A5B544B95C152F
      F15232AA5B554B5BB29E248EB62D52B88D4670C82DE5AAE4277F668F4119487B
      442B97CF49F9B1FDD1F8F7C5744642B7716FE3FCB772707F2B32B612BBA399F9
      4BE03765F76112E84156418B0C68B91796AD629DA154B9F2D6FF484AAC206BAF
      529EF6AD9CCEDF7A7E5ED33D3DDFDC3838EBBF383B3B10108A935E136D163E7B
      4A26BAB06461F811CDF45785CB03545A42C8E2266BC0D25991550688581B9D65
      03DE3D53EDD72ADEACCB3BA4BA1B4D205C581CA7F2AB0142CD5D1091B9298BB9
      05C005B461D668D9F1B64E6D77C41DB35AEC2DD8DDE8E88A63BA04DBE467EC4A
      4C66EF7BAEA26185E00709F75514978B389EB06D4876A1ED41AB5206AF40C8AE
      0C586773AD94D4B47A68D685F12B95A3D5DAECA58F17B6305DBA80C9B28FC96D
      E0BE8C244533A9D431A7159FE0EDEE0FC7E20FF03D2F1DFE885C4D347A5FA034
      824B59C9D4738D369B1BB63B9DFC8D18D6395804A4C11626AFAB39E72373E7C0
      840C5F9C14D2AF82CEBF24D4E5D06D2FACA2460F63E40417BD93B632CC6835C9
      709D0BDDAF357A2BEF9009DA419CDEED6A29B3637A91A546978BEBE9124B5DD3
      52DB139F6A7BE0CAA2FAFBBBA92495C1981434F4F3E5B3CC13E585DF0AC82228
      2BF8E7ABEFA393C5CDB4F4DFCA7DAA2C93DCB86D7CE55F21B35D6783EB0ED7F7
      554ADA9B1E448820A0F3A414A4652DDD37DED90CEAE562CE28371AFAE21DCA17
      B3279560D63A4063C3C5B80EEABD3A4489446FAA32EAE013C0182D9B69793D9B
      953FA2B1459E2788A325CF4E05810E60DB3C6FB47CA41CE7B73EA7DB0A4DE4C9
      731D118F7EDF528597D210F381C7BB4EBE4750685E2D80E481AC6203A442BB48
      EF9A31B252B46014198BD19A9609773D2ECD4F8C09AB543946F738EBF03E9274
      B1AEFEE7F2768B703FCF50DDFE746E1D23012C4FBEAC6AC705A0AB17E1D65511
      57BDEF48851F14B63C52FFC8F45787FBF4E2059A61CF2F5D513D508F60806CD3
      E99FCF4B457958690FCBC9B6752D71139FFB381906738BAD133FCC49DF79052E
      708584FB491F59AE220541DFDCF766DC2BC141B0A7758077BD46650538C6EDA8
      74B5464FC4A702082F2158B05966B50B9DCD6B8655B9CECAFE5092971A47B159
      8AAA2146A633D9F45CB38EC4893C1F9F6503B5716C0062C7F54F9A11D901C004
      5AAFA4F762F59BAAF99E4AB4B39C9F129A96C1CE7BBEC302E0089A76EE2248D5
      83E2D020A4884507617548951358F077ACA6ECD0C0F8CDB0C897DFEE9AC42D47
      EAD2C0B5539B744F32F17369D8546E8CAAECD951E6BA2A4406E2B99501BA4592
      B67EBBEE9FBC0EA548F38BAB42210D52437ECEEAD4D9E1ABEC8294064D5D3D8E
      B8671629A7F265AB328DF7893B857C89F8D96ED3A56F75FBC035A522F19A95ED
      AD1030719A8946B4431BC216BAE3BEDEFAB377C0A2F28C8424C852DE2BB71F43
      BADB77F18127DFA8F7C6845728949DCB018B2CCDA79D09C9E9A5E03C8D3E51E3
      AB323557775119EDE6862C9F44DD698C777797FB60D93D7260F396447B799B57
      B29FE89A4EB44F04BD26F69D96AD5007A95B967293C88594D84B1E335AFA72DB
      339DB8ACE55665D19964C6D63E90AA53EF148AA7941297727F4BBD4803D9DC60
      4688293B782EEF71CF29E185E526AEE2CEDD6465FA8FC8ABCBBB92E4EEB514C7
      114F9B4E05E98C9F784730140A1A839554F75C50FC35A1666F7759B579E43CBB
      5543A2AAC6ED46593D8F86B44F69F693D49413A1C724201D2077792E5D872C08
      56062E505F4B3CEACBB25B3E8A2C999825CE1ED7925507540AC81192E14E5093
      61B3CB2B423FBC927CAB2FBC82F377F8F6DD573BF29E0B3AA6B6FE15EFC213AE
      316806E6B840B214C93194C0543F2DBDD740325A1E88CAB4E59956F71D9786AF
      47E54A08A7E9AEAA0A92DF5C9F2B7BC94411746D5FEA5BF6F15C19445327B73C
      AD3B6107E31709F26495E8C30544589E2D2E2E974E2C5DD7CAE31DAAB16D89CF
      36371E3EE34BA8492A20ECBAAECCD3A6920D93C23D0F6E9FBB7A75162982122B
      6CB4BB4D2B83EFFCDD0AFBF2EF2BFBFB2342634C94A1159A383DAB77D11D94A5
      8565A9A5BD954AD887D4CEE606424D78248B8AEA6221A673DF3E7C5ACB312017
      1A45AB98588B9C7D4B7034583CFF5C6BB25526E1952D65E8A0D3C9CBA7C765F5
      CE6F7B169BBA04DEE2E6FA99BDAC2EC98BC72E893B541F9450BDF4D17831C13A
      832A07979796232FE10859082F3D4C83932C5F48DC5952DCA589A92B52E687CB
      06DCB9ED7AB7760326F16C2E3DF5D985E15C197AA6784FAD2E58793AAF9B5BB5
      42E2C9D5C550912A316586CFD34797554CCB2BE46D1DFBDAB9BFB9A1B514B2E0
      6AEEA804532957A50E70A58255915098CAEC559F7BAE3F58ED178D80473BEB72
      BB0D6B4FD169446D83439BAA409A9456D4D3F1AB78592C2EA25B14BF5859900A
      FA0BBC213AC524E78C283C9C6F5D30FB347FF5E3CE0861102E838B87D21B53E0
      6ABA7AA1A68A1DD7FB582C1249B6D8E6DF42E26D4B66AC5741E4C4E3DCC52F6D
      57677F7351CFFA32BCE24025A77A8079ED7D6726B3A6F7D6DC2C0A526DB4C36F
      92F9778BA0898A40E8EC26C430E9A8DC203EE95F9827939CB42BB58A93BBB961
      73212B416567CDA262EB3A49A3ECDA2EB3AD61FDAF0F80BD04A20FAFDE07C619
      D525F456C7BF32F2CFEE229C64F4219FDE1F05FC43EB03AE163DC0FBF02C187E
      A06BF5F77B362F4E9E770758E161E71FD8459AD75F439E131DD3F90D3EFB19FB
      3A29DAC37B37179FFF9DB61707DF7B4E5E0803B45FE237889AA576B5BA6C97BB
      9E3460C473CBDF7123CB719391CB8BAA2E3F6080D8A0BDD09887A930B73984BD
      7C917200CD2FEA366D11453467B6CCD9B4832516276AC94F90B09D934A20119B
      CD18D4BFE23AD81529539E523F2AC597B59BACCA5BDD61D927FBB7C2E41F61BB
      9E1A7FF29C8DCE9091A1398EC0C6A3BC5F0091E19DE89A00CBC73B40FB096AC7
      125E0A2079D66DF256C13CF70E2653CE64E5BBEF9F154B8AA7723DBDFF042C9E
      1A2D02C649E6EE62CEE87E45A1F42165F972965E645C11BA00325E7960C8419D
      BBA3B2360E3624AC2800CD5F69353A8FB31A9DE103ABD1197EE66A88F071DCD1
      FFEBCD9DCD8D0A9CE3728F8085B4B2D0DDF746D753B76295C0B2F8CDAED6A974
      911BFB0C50553E4F65BD84802CA05015B3DBC6F0F8BA5B72F4E62A679E0D42AE
      52E6E9E3354D6FF9A1BFD695AFCD2107C1AC9A12EB73FEB9E77C75C9FED1A35E
      5A6F5FEAB497DFF0C0813F8C4B4B10392484E949EF66E53CB7985BA3B7D3DAB9
      69D27F3AF8CFCECECEB6C4E0E593B63BD946F424D5C8F6C9960416392E2A2154
      A5C65C54548C56BDE8DDE47A9644C1B42D9F8160DAAD2CAE4347557CFE75B1C0
      E686B59472334DF81C540FCAD3B9DBBB7728541DABC2258D69C2EE3A8E8E5D2F
      B920957BC16D4D726B98E03A61D6573DE1FC504D97B90BFED3CDCF72B64B30E4
      79792B198157450913892C5174A01D8EC359396E690EDCC62C77787A2BEC177A
      29CA9124955283D904A59B7C3BECDCF03C5BBF490FE6DC4A557EE19924F3A67E
      2A9EE0EAF3ED4815A0D6965B5BC31BD757A448C503DBF15E8B912D17BDA824B2
      3F2A5712083411037443333393BA925CBE585CC5A6E6BDCBB29203CB25034870
      2E4852DCAEAFFDC69EB403D154E830C2C37F427A1C17E8EEFCBD2DD1377C923F
      26FE0A22F83D0D2BDB95101F92759734E732430B9857F996C262A793844DA68B
      A97E2B1DD54B7FA2C5255AEEAD2F2DA12AA8B272CFB55ADDB1BA685BC33A56B8
      1A2B1C7DED58E1E6C699DDD8E77C20423D1016C83D9188C3E76CFFF2915509EF
      C2768E738DCB4384A5882D2EA51EE0A46E99FE93BC7ACD0ECCEB848999349235
      4FE613D7B6B8558154DADC48B74B80E9E5A5B39576532DEE93866DE497FFB6B0
      F6211D8780D106FC69A66DD3BA2D16DC9FBFB2487E31F7E024D805D7161F0DD7
      73010D3E51C7353D87149345759267EE265A7C62925C9B229C712C0ACBE0AFE3
      8A4B51DB1592444C97568FBF484493AB7A59FA0EC176E1B2B44AA1795D966D73
      030B7736457DCC73145C04E8F2D100B15B536E239243BBF3C596D72EEEA12D33
      9C8362C37E51E5F432EBA08175B6B921D062865DBDCA90CA0664B63B573FACBD
      0C0FDE3CBA77D8D0599EB1199709AE4471992FD22BAFC83C4730681F8AD95580
      343F35A4C7383D4FD89EFB0E6B9C66AEF243D00BA6B3392983ECFA8919778D5F
      598D553FC9A41C3378E182074B4C5E776861968CC0E54E1D2EF85E1B62AB86D8
      F8EB1B62243EA7C28C0B5C96B444A6B0F4B8B4F9CC0307CC2454B7D339B1DD2B
      8E0119D609191CF3059799BE3269729196AF66A84E47CC0F72EB32892293D64D
      AF1DC662203A48A90757C156650AB7D4252E945D96ED66E52EF164E5B33265DB
      5056C3A9DB22E433C7DA59F20A7CE69E1FD3414FD0968DF06255C2DCBFF94F5D
      31B1F342063B47A10C1D2CD1E70C66CA38AA4B7ADC150B3F69F459A1CC500DD5
      D85F5EB51FDCAADD074B5B222BDACEFCE096C38CD3C2848D559A0D6F5F59D7E4
      FAF65B4B45B90AAE255E167FAD307773603317E82854EC0100F39E2D94F698BB
      4394FC000DEB329BB8461E327C0BBA408B998432AF5390F86E0B311C4DDFB151
      4A0E40D5B08CC916053B9799BCBA8564E791507085FB66AE85CA388A2D1BB294
      D9958C795C029155BAF99749DC2CFBB6354AF1ED289471DD23B20EDC42C1CBB0
      B64C2B6438BB13A84B1FFF72FC8ADE4A47DBE2893DA9CEC4EA0DFF956579E8D6
      0AEA46BE30F758A04D6F91165A978BA7157AED48A909E95DB1ED7280FCC5D5B0
      25FDCA25518990A82BCDD91FECEB92F8BBF1014ED27430AF5CBE3E53D0417B1B
      5895761C4542411A324352441BE09312A2F3E13D2FF7757E336E0FE8DFF6A8DB
      A1FF7486BD11FDA73B18F4E83FBDFEA845FFE9F7C678CBA0D7C65B86DD0EDE32
      EAF47AF269BC850ECF901FD3A2FDC07FDBE316DED5EED0FBF0DFEEB0C7EFEB0D
      FA832F7B98184BE9372235ED7ADE2BFC9FAE24FDBCE779BBB64BE8E9DC2931DB
      DCE1B5F7A0CA338AD3B73E7B8F79F6CA4387FFD3DFE47FEE087A4FE914026548
      242E87D8925CBA73B72C9C481959F3FEEC2D47D6F89872A2E8B1C16EB744156C
      3F3EDD4E0674E53B60E4BF75B8AA91BEC078A5105F43F7A26791E9174DC9204B
      4BBAF0095B6DAF4BD068B6B3CF9F9C1B7692965EC6DC0F9A02E37C378C9E9B92
      FA2DF0B59B4F2164B3E5D4ED212080ABFDB1FA36F273DE6A13FF0B2C38FA41AB
      D51EFAB632BF7705126E251241CC5D5B67B5980A6F56E7447A56978AD9452C21
      0E02E7CE97AE7DCB64CDD9B32CABF2EEC8FC10349B59BA64FE7AF6DBC8038CE8
      414D0F5302E7B7B4CBCAD3415CAE7F863B26E365EAD60A4C6905F4E53C53B795
      861E2E8AB250869C4121A65914EBE0EA6A7095DEF79583AB20AD790BF1F96F7C
      E6EC69D6530B60EE9AEDD9EE7CF2C71FEC58F9B6D578B007A9F2900057EFA55B
      DDE7FF6AC505FDE4A6413FFF700F5C6D5DE6B227719EFDEC3A7D29E1243B9D07
      F602F3BE6F424F58331F5A98C810025D242543712962CAD2727D8693F3BF455F
      0B3CD03174F4FBD90B1C316F0B59BB6DEF85A260CAE1732F5AADB22DAA48550E
      67AF73AD302CE6FE6DA98604BC4503332E5EC25F0B0E74F76D8F6DBF1FA685C9
      1F9F2C7373E3136B1018E6AB2C114FC574B693BFBF76BD52BC6E835BAFF991A9
      B9E6BA87CA230A7B561BDE56B412D1DA966280A9323468BCF76429679BA48CB0
      1A5543C99FB5F020B9FC7C1CECF3D3A3C7774324702E49669C9CDFE7C83C0A72
      F7F2B18F80F5FF6B27076F9ADDBD384F58846B255F81E26684A99078F4267E60
      26C51D09FE7404F8F9E5D2426C959D21364492545DB2252A4619FA3246B3AD25
      12581A575A6551B2F9C87E028626C7B1F185A325AC1480AD061AD38A4893EF9A
      DFCE149A0C968D54A917AE82D872381619CC1E6EC25DDF0C7733C4FF03EB5EB6
      C843E9DD052AAD92B028989B85855220DCC64FFBE491FEEC3193296DAF4D38BC
      409A05401E4F0BF892134115BA1AFFCE026D2DAD90ACE6B65B29204FE425CCD0
      2A321E9242AE076389ECDA67680B69C46026224D3BF9DEDEC1D191AD04F4BD1F
      4F8FF639DCE69D1EBC3E2DFF8E776D5B6E1403A44A3FBF5D8A70309993521A91
      C76CEE391B2C325C074A6E90D82D9620F05CCF7B644B78C5CCB04CDE626F14F7
      3DBCC2A72407D4C1CBC39941100809B04AA3A0CD23DB826F3413017BC07D99AD
      F4B4D82020CB12C6796FCB89B304B1146577DB664AB195AF7FC222A302732A2B
      F4742EFA79E69A9D1AD3D56528A14D4959CD6FBD2D8852C12B73F51482466B5B
      3771C7F28C91D7F6BEDF662835888712286D89AB407496897E4F17B3A647B071
      98FE95C421F31714D53D785A7AE793CBE06DB976646BC7ADD6D62A0418E2C4F6
      2DF7541069A64C23C57813638D6F6EECDB7AF8B74EA73962137EF03C73E2981D
      C8BF4A11A07DEBD69F9D50B67FB2D50DBEC5052DE9CCDC53AF3944CE707F64B7
      72474918322D0877DD08103AAAA9E2E4A6C4309DB9F2F964352930279D2730CF
      86F15BC4F90D305A7A109BC550C14C3C28642E6262FA0CEB97CFADBF2CDFBC6D
      8D24E99FB49A7DC9F0E58A273C53685D6850B7665EB291956BA94A6AAA9CC7A8
      8164E8B652598BC14E2F3B84C71F8593F1A564322CDA32EFE1DB93734FD125FD
      F4B664D311D836D6FB53C5C92AF31BBAA0F25B929754676BDE10BA826AE8852B
      96B0B725983FF4AB52316E3F41C3B87177151A2587D15221A0C5E4666040EFC1
      657526B33DD8F60CBEAD4090FBF395738FAB660761A49C4A11AFAB85530E2D74
      E9C4AB85B8D2787EEFCC3EFA20DDE12B0A63D736FDDCFDBAA5272B92376DD205
      43DA2AB9BA5F25ECE66ADE901720AE880845548474B52399DBBE30FD2483D05E
      2416DD3ABCCC12E16C6AFCA7292CD1915208BFCDDC1F56A6ABCE6159BC7E17D4
      DBCEF6DEF157DBFB7F65226AF86F55967679B1B85A5C3F767718DB1601E0D36B
      5E7E9F62842FC7D944573112D5AA6E6D327DCD92B387B3FA0F490049C5702A78
      D97F5BE21E682A9CB2A5A5CE04873B991725F174519954531AD1D2CA47806A58
      9E7BFABE9555110CB2CB92DA589E5458CD6EDF75779DEDBA4903E80F6AD1EEA9
      452B8ED4B23D4C8FDCFB1E2312CBD957F6FAEADABAFEA0E9625205DF7ECA0A86
      7B28D4C803C10B6EE8C1D9D113D22242896C05FA9C816757CD4EBE6BCE66FB57
      EFFFBC7EFD5AC0E149224E6792EA284DD8A9F467C764E2969FFA973FF3C7761C
      71444CF6F332CEF33CC35125D329BD6BF22E83FCAFADB0DFF3929C1A253674B7
      8404ECD3B2B55C0F09C26F8057B492DE1DBE823EC498CDE4FFB8784225C6FE69
      77922D848784D1D73BF5E816EB564226C28079C9D561A8C1604DC6CC40CEF364
      824C1FD83785E566AFE873314AE438AD5B9D71B2DE98949CD8093363E28BA786
      6D0FECFDC9DBDD63570CF1ADDCB5DF98EA7DFE3AB979077B87AE461A9A2F90F3
      7DF1D8D9E9E76FB34F0DFA11860CE9F0F895C9CFA52A16A7ECD147FCE88BBCB9
      C1CBFCC5065CBD7B9658F942AE266A3D2AC13EC72FC9395A08CFA91092296C2C
      13AC4C0FCE8E93780DCDC5D501137F26E1C0B75C33EB6A02FCE05B116ABFDD80
      7053AF56612BF124A369FDF4FC67AFB89D06D9445384CBA077A12CA3D8D78E36
      49D716EE6B4E4A7F736346A74FFC66ED8897F073B14CD35DA6F8D9889FCD2660
      CDE65A6CE940A5EF2F4105D8649FFAB71AED403E2FCB2F320443967B77F1BDA8
      BC7650756A11E04BC28CF57FE087570C589EEF785B12ADD582024B322E23F3D8
      4F8607C19D0C6936B7D41895020473E373D6565EC0273737B8D54F013DB93722
      99972D87E4444857AD3CD2B1C2708AD9965DD9BC91943531F2A1A3D27DCE54BA
      34BF745EC6D422D3B4151AB245BC17B413C27CB7BAF65C4F517266AF326D1FE8
      02547706EE14195E0776D7F8AD60FC754F41540A369EF153E60D410799562F69
      DC3DBAB357964C6715476B8583BB1ACC1736473B093BE10A1D1DCF1B538D928F
      490452757BD4984163F9F3F2E6EAC7DD12DEF3801DD926F9901EF9B0BC00BE3C
      73AB52401782C7067BA9A0AB0AB0253DD73EA7B3EF7C8B5B5B7E9A0061192EDC
      E552FFE567D899B805E3AED6C43616B8B3A3C532747C9ADA375065B02A97D11E
      9C480A01A36C11548FA0AD40334582F394336DB32D0C6A492EA58A76C4B975C9
      E16C6E14F7E245689A04555B8A90E14F723A8DB70249561D8177B7EB2B95048F
      C456B5B316037795412AF1683969B06B7C5AC6999E6B4CC413D7EB35A4CC77B4
      E44F2AD58F20FFF25A349CE4B3DE69B930B625A984734940D973B3D42B8E027B
      C144E03E59D59F7A79FF8D65E812E8165E9192FC6A25CBD2DEE08563A1C7FAA3
      D75E9FDEA52D492BE81D65A6BB50E1F2B4CEB233E85C77360749568FF1B5D542
      6562A2522350B8C5FB44BD80D6AA3B82B0AA762E42122119B7C095A825120112
      3ECCECCAF2F62D8D4ACB026CA222B35ADCF8E1656580F8061EE09D27E0E5B570
      2F7B5962325BD9D2D56205D6C1AE58E109C1D7EDDF3B7FA0D92762A2E5864DCF
      908DE61C074EBD6C040C7D01E090062A7AB742EF733A00051A17A0B7BB28EF9C
      7A528D628EBFFCE4BEF0670EB1DA8FB8AEE934D38265FB8AF313E8A917DA72DA
      6ED1A12743529379526A8DA1C1FE23EBF29201242F72F09057466D6FB002AA86
      BE747BB86FB038AF08FBAD566D33A29B30F5684EC51243C3665D5D4B3866152A
      D9CC3692A85E432AA5B8250F638A2A986FF792DE1B3E0ACA00D2E7DED1E7181B
      8A8D5623488F2809189A9D252E38D55C60E9A95C7B28C407C37FB408FFC368E5
      431BF7189D636E8FCA8A16A7C0D5003C736064B6F683369843805CBA86AB6929
      D2053816494DF1AC962AE8242F5FECCC6FE61C58612FB0B84A846417DFF6866B
      CDCBEFE348C092E98A6F942C2D795949E43EB4CE566E6EBCA18D3C4AD22BEF85
      F7FAA487D275FCF654EE1ED0B82AD3B65520D064AF7B6707D6914AD270B2884A
      D573A8410F5B34522CF1C6D203A55A469F5C25BDD11A9992075AFF00AEC5E64A
      E55759E3A9E54CC99D0013DF184457DC367E1ABCB6F1CE9F5F3618A9422DDB0A
      45B76D5C800A76A5AAB035ECB7444DD8017EC50AB9C70807DF472665BE32A907
      89932A45BCCE2180D14C9244E6E0DB10DB92CA7799DC253E4A0136757907DE41
      EC03AA5425951B585B666E0D198CAF2C1266021297C97DF4A64C16C8F8463ADF
      575F301F7307310E61C9A904461FBF45F6CBA99992D460F9D4DC3DF2B481A7EE
      44325FA99E6DE68791B3FD8ADC0B14B5D15F8E7055F3B5E8B7A9749B76A8C6D8
      C5332B731E7172F394386276BD094A0F3DADE3419DE3BD2B52F124A67EE4DAB8
      EE2CA8AB6DAD50A65F540B470E53A9E40A7D65B6288C2B4DD6EA5010545D576B
      6A16A9E3418FBCC3F363CE7B707CDC0218545E47CBDA22BC84362B451C276C93
      903404BE2B29A6A5EC285B7C3637224DA8204CA340AAB422BA834B81EBFBA6DE
      74DC00DC2561A94BEEC416AF6D79B2863557130B2ACDEEE9D5A5B1D292A2D699
      1159CB765C6DCD7043D53446700B86298D74B6CAFE07724AF12E6E65144391E7
      B6B9F1592BE6748BAC548356629183BEAA71CFA2E83C18370A6F2FBC1F8E77F7
      BD77393CD5396717639979E36C9E2FC279030E7F639741CBE825FB47CE744A85
      D2D4E0AC56AD69A610FBACE73401BE8BA1E74132CFD1C921275F909B8C946E4D
      363720C090822CFB3B0EE7D6465A324B008881196D7B67619ECCF4CE54A6570D
      B9BD3FF4B602D2C84043E0D414607873FFE259FA0CE8012E0FB25AD77B98C699
      0B75D312471A83C01E8B6AE792E54BC629FF4CE5F70FA8BE5BFADFF3E9F439CD
      F57D61F297DE0D8D2832372FBDDB2F82B5B7B9F1D833789BA58F5F7CE36D2572
      CD5AEB04D6E6C67B36C7610167F9E13EA3BE4DFC0B11D73ED73582761A55E94F
      47BB92B23B3F38EBBF3823074BDDA417AF4F8603EF60FFF0DC5EE84A913F9462
      0997D1B45D170E7C7F962759AE45FDE1EC445B1E4A9FC125FAA550C476FC88AE
      E6874331A4EC90E4645EDAB046605634A8AF1FDEF15EA12D70BEECCA495583DB
      6A898C001F5C94B2B0208A8AD0C82B27D1F2722292E2608E8A86EBDCB0E906FB
      2E57DEBA5B7A8E64E95E207636CF8D4FB2D68E01318F6BE03FDB45A4CD299791
      E7E29C45BB0CAB8BC071542E592DBF4D787EC4B75A5D05F91403A78BE397661C
      83058A1946B754E8C2C15BBA0B6B4121B94229B809B55B899C9C17BCA42897A6
      13F37424048074458397469C440B25BFF6C03A2577957CF2D078927F64447409
      1E5F4F6E6E94C56A62D0549A7AB72021250D89EAAFED6A14A5BC514B4DC2658D
      FDAF1FA5F585DB5063138D608027D9C25A9F9EC064A51D014689C4F0CA58D716
      E04A9ADEEEDE77A792596B7A47BB6FE96DEFDE9CEA9BDFEEFE708C8FF313C122
      6ACDDB8C41E2B6B62BC12B663E8169BCFD74EEF561AA2BD2B4382FF7380ECBDB
      8185A2BBD073DB5289706A7F2E3E842067E9A669CA6199E81CA145E609E18E49
      293E67E61EF46465ECF5FCD1BB697AB755ECDDA5AE91B9C3A42A8C9F23D90F6F
      A3D2512B4347F325FB312BADC2A26825622997145955DB3CBFCD2788C398926C
      5D7EAAFACD3187B0242C263C12A961FB02BAB512A076ABCBF992D525BEF7DCDA
      0E327B7E975D3407754353C6C7C5A1A327785B5CF700EE7AC1DAE27CECE4D61A
      39CB5453B4F202F4D32CCD86071673A91A76B5F3BAB2704C015F2292E07D7814
      BEA558AA78F2D5BDFCD49D9656BCF244706750A28F6B72BBABD2CD6351131B87
      D660026F308D22372E7C81CFDD1BBE963E540436B04365E45A0A53D867AEEE80
      5B96C77602592E3DBE769B1A325BD73DB3E4015AF2260DD4B81B4D27A43C8852
      6C6C8FF4D3D10872313F792353A135CD2C0114B70CF2626E6EC8722ADA98BB90
      E2A545CDAA9C67B7DBBDC00FAEB283C011CF0592C58275956D7C8AFD0EC4F694
      AB8E45DA8A2BC3B925BEE572BFF93A4B74B82ACD82C5851AB34B7E971B33FB5E
      A5DC2917244AA498656AF1E7CB97E69B1B2A7324E45BF9BC682296C3AE8ACEC2
      4BC01B9485E0047BB94610B55C8775AD5949061956BAAB6659766E9554397F7E
      A32D85E639E303D04F7805F0F3B9E0D6A89E5A39EFEB4811D9A336225ED2BD21
      F87A0F891A594428FDB265F305C77017C8E4686CE3E9888FF3FBAB3ECB7BBDC5
      B614320364014D9202981CCBB907952AB49074B1B85C13A1A0BB8B2A96817AA1
      55E22BC827697848053EA9DA6581B250D781C1179EC911964A400F2B308BC869
      2BE6885F8881973BB347303BCA51C0CC51D0517AB2D4C1940E73F94445E45DCA
      97DBC6899224892B78E80968B0F1F19E1D6FEB957424E32DFE122A63A5C3AA9C
      A3583C228DB597791955E51AECBA33D7472430D25205B09CD2A12D4B42A3F6D0
      85E16CBD2B8EF0EFBD2978452CE552CF56150B8F0DB3984AC4159622E4BAF6C9
      2C096392AB77EA1CACC85CE9496B3E54795CD52DBAA0B6488AEB1AECA3C99E47
      7938941AB65B04B734538169A35209613FF11965CF6B81CA380CD0990DBB4C97
      527C7D5F59CCD3EBAFE48E12BB40D5A0C467AE946D7FBA64383D935A041EFB88
      1978410313FAB0A69239E31D230055B83772B9EF252A8554248ADC586D185EEA
      E0B250B59A2220234BFCC3D27BE2A4E7FAF06F1C9DECBFA15D51DBEDE99CEB1F
      FC9C117F65E2F71568E8CAA04E88BB40D32B945898224BFFB03E3667979C7ACB
      44ABCEB244BD02A4D7A7883673029EAC912C7F3256E6B1B43B14A5420F803D2D
      414515778836C6DC609BE78B1993032F2FA256C96C39230861AAB7FEDB2573C2
      55BC41F226E982CF6B043474C9B5553B392A5FCC78D9A5CABF67BC76B4AEC606
      1BE865212A546CD3CDF2162395AABF9620A9CBBC60A831B94AF1D87B0ECCDDE3
      62479CD13626C0DA7905B3AE887CC92972DF958005C63E271B255748EA433F8F
      EF936958A34AF50419F662D3261729778EFB0E4AC7D5F620012C9955B2EEE74C
      4186B630BC27C8B32B310053357477BCFFCC16A27EAE38861AC0D6E75CE6F59A
      D61D519B2CE70E6B6E493DE6C223EF4509B7AE7FC185387D9FE2080812FCEE24
      E19A07EF3FDE9F9D3FA1B4C7EBBB65692BA5DC58AA1257800BB6D80729164135
      2ECF37D62EE6D1D9B9F7E74AE5ABACEEC7022FED9DD14B80BBD09E88EA6B4778
      ED28D3D420BFB2FD403AA6209F8B8C3C8B7CC0B6981BA5D21B56F231D5E320F5
      5ECB07C27EE2010468FC4DCF8B03A7589B721B8DDDD98C849B14D2716B9EC531
      ADD4A43E9DCBB4EBBDAE30C4AD945F962C9D9243B1E8A399B0B8644176A361DA
      2ACD1C2BCA4932A51F91BC49CA72567D8AFD2CDFC1F461DE4D8FCF336918BDE4
      16290E20714BA9A8A518B0F3E7E5DB9A36B46A53853A883BB02CCD07F06DFDE2
      CAE1C3AC1411C312F03F3A9E0C6FEBCCEACE2829423A3A6096D38F94A5C6DB4B
      631729609174C349566863C8171E7375B482239BCD572A1FF45BAB23D7F5A651
      DA781C77AB71EF76D3169608CA8D7E9ABB7524DD0B3B0F09566CF7B382BEC784
      8B4A96951F2D8F42A2533EEEDA5E11C1590A89831E95E3EB0B05E8B5F969764D
      D46259451AC663D6427043A41F9B6DDFA0D4FBCD606E34E5D090A16E90AE15F8
      B4C3F8382970A8B77C83E2B197DEE175801FFE449749DE82DF207A5E229C4DEF
      A457CEB27C2E2F162FBD575936815DFC67EF1CBC7B7FFA12ADA230291425D792
      0893ED1FE837CF5CD7D25D1A40FE6191A74C2D58C67C2D6E0E190C0E789A61B2
      35BDFFD8F9F17B96BEB867C9DDA29E9FF15A1758CE3B1084BF39AD4E6390D49C
      8513B56B80AE051D03672A78803BC82DD80563F03009A4716252D88DBC5090BF
      BDCAC958626072C2E78BADEB2B43AA50D000B77C45B5E1A5D59FBFC0C15488C8
      C7EE862BE7749046BFF38C5600F0A003A1884352629C60414AC51604164ABFBB
      0898A09BBB3F2E85D9BC42EE79B9B830485ACC8C442C38778BB7BF109DC9454E
      DC2845970F1D255524B4EA7026C9157468527C065B502994E737E3F680FE6D8F
      BA1DFA4F67D81BD17FBA83418FFED3EB8F5AF49F7E6F8CB70C7A6DBC65D8EDE0
      2DA34EAF279FC65B48F20FF9312D5A29FCB73D6EE15DED0EBD0FFFED0E7BFCBE
      DEA03FF8B29A80F1587FE3B5F9E85B6004AFD24FC3876BCFB2A4FD49DF11E062
      B977BF7841CE83FBAD7AE9CAE76CFFC9BD61EECA503CFEB094D9D1AEEABB6F9D
      AD4CA7AD7C82FB4C9C703945E519E59DB8F70B4D1AD95F2A3F3E25DD4ECA8421
      A60F10F0DABB34E115B9E9575F53FAFD8F64DFDD69BC4F277727F228E8C4AB62
      8FDC18CE03295677886F8798929809A7AD574A095DEABDCC9C2BC188FA770577
      5A16D9E4233F198153E4A3AF136EA89046410B416EEB0200D65FF6E1CF2A052E
      5FA07AEFC72C9F4467333F344DEF19F2C73FBDFBF959536CBA2FD289F6F88AF3
      FE69B49BFD2F3711B24D57CE0E049CCFB5DAB961C3B352BFB5FD60CDF035865D
      60D85A368B028D1FDD1FBFD4C6AB2581AE801F905BF8564C241DF75B1F4D485F
      68E452F7CC9D4FB43B57020631F12F0AC089029894597524D8C075814B9531A8
      E555C0DBB5DFFD6A71F1E47BFF73A32DFBC1E2A29A51E6FA038BCB0C0C988401
      CE91FA022B11B40C37F5DFF7311BEEB1253E1CFEB6CF40959202C6B85AA9FFFA
      8097105FE42DF8309B906AD27DF056176165FA9F7B373F9096BEA4CF773F4401
      FFD0FA80220F7A80F7E15930FC30F783BFDF7302E2E47977806D1A76FE81A340
      F3FA6BC873A2134BB63B7DF6330EC7A4E8DC7F3BF0F9DFE98CFC537FD8F39E23
      48185E71DD20FACF3353A4CFE6226F94247CFEC7B232AB66BB485318D0144E4B
      E232CEAF62065A7E58A24870D218FDF8175A6D83A6FC992B2AA9D1948634A57D
      7FEEDF3BA16F671A639A86B4FBD953C5D5E9E4D1CF3590470E529871B40BB0B2
      408E9895D00A243CDE9FBF7E3EF21000F09E87B3978B794CBF5A0C8DDA4D78D4
      A50963BE2E06AF397B3FBF926CBED4BF6B989E37D215DB726AA07E5382806072
      3A255F4D2F34E6C2DD05643C4E98FB229CA3B261AB60FDB25DA992438D5CC124
      CCD6CB8EA4DCC4553DB4EB37E9FE9D839B1B8125D132E56996A233DDD6134F50
      24A8C5C9527D18D219464AAD48E68B25F0D71ACD1282F3CADC0619F460995F4C
      529628BC4D186BB1A413EA370D084B77A7826C02EC94B4DCB97881DB05F60A2D
      D8ACDF0C46B86376C919B547FA3B93D03121673443102C97D2B1DE9B32AE4E09
      A3A2C15F6679F20B42111348C76C32017A5F88F8456103B741369F67D3695648
      02FBB676131BB76862B0885071460260AA193CAF9AF5898C487F0E502B610279
      6988A7D05606E87CADDFC420E81BA8A601259902423696300AA5BEAC6623DF72
      4E0DE7E00B29AC7EEE924536AD841089742858D11C2679B898A2A321E46A6E8B
      99A5A58F5A3CA801B19ACD7A73E3A1794BF2F005CB3AFC70DF3A4C8CA563F998
      E4A04AF71A659CA7515678D9A0E096AB3ED4B5518675C031F875F3EBB6A4B31C
      342A0841405E625D8EFCF462817AD38AA2531A946B5FDA9C77C4262D143A9F8E
      C24E50F82F7602BFE3A1B11B74CFDFC664C96C1E95A635A24613BDD891672729
      DDA8E462F810C4E40096507024ABECBB7C6D77948380E7BAB2D19AAF416E48D4
      5AB87926B5E1225932E332F47DA18276B54DB9B633DADC903969A84FBBE6CA93
      0CF879C8019A3BB78BA15AC99264A1EC8775A91063CDA505CC8457DA3227B072
      52C74DC25E5EA9D98290B8BB7F9311A44A957EB152ED56362EBEA8342DDECE14
      49AF22E0540ADA5EA0150257E91870CADC0BCC845B0BB917A56E82EF9F06AD16
      8742662AF27D2F25DB571D197F36F33E2AEEA044046B36FC87149AAB30D44C58
      566932757A89FB11D175A86F5AA4F364A2E534B6AE8D3170381A59B2AAD67DF2
      3FBD3EE9FDECBD061F2C9DD5374727AF707DAFF3EC9B99C18A8501A6C28A8DC1
      D46677314AA4D71EA60A6FACB543B8F74477F59E63C1A03A72326AB6380F9B6B
      5C792985E77BAB09DD2D0EBF56EA28B79B5EE36D060F6377326994A7DFE5866C
      857D0573906337B513E80F2DC72EEF6D653DB84F9C31945C39BF409E978195ED
      E57E4EF0A26C015900A60BC3106F23371A4C7CB0017C23EBC0493E744CB9EDA5
      197147C1376281EED9F81739FDF37031D704A6B4834BBF972578931A65A5CCB0
      181FB75A349D3E9B7F1B133EA5339A4DBDDD1F96B5CE75A568BB6E1379E0EC9D
      9FEC9586F3B28CA137FE98A4C39A4DE461E92AC78D8E61E33599402C34351C73
      9D44F34BEE9D2D11DC9649D55C609E6CCCDCF88AA5239FE3A6423CA776B7F181
      85F8EEF0FCF8A0F0B65459BE23E728B9A1BF326C2B7A873DA998F50E2448BFCD
      E6C6E9FB77DEC40FCCC4850DB42233A3359A7E2B73BF437FEACEB402A055A092
      2CFED09E9C921FDD29F946E6FA0A20ECF4A7EFD0BEAAAC9985B7A72C64B4A76C
      3A7280FC059DE06CA1DC84A271C345311706E769FD221D0FCCD8F6C92745B110
      381BEF667F319DC9BCF2459A2A83AE2F8D2CDCF0A4D7DDE1004B70EC1B993172
      6BDC9F25D19990A3CA3136F74443CEB8E5DA220D9F0FFD3960E81436384E8E08
      D2DF3732E1E54C9CD643318219E28FDECCA73D2FB3FCA0FE064ECD6452827848
      63763689EAB7C90F984F55F6F193EFD1343F2F614DEE3093F1863BB1A62B1418
      C7BACDE8943E77C271A7CD1780E03F4066FF0BD4367E0BBB751D9CC431DD2794
      6C90E628F6E85DECA392D214E0989C3B1738B8C68E9A658C6379C589A35B3ECC
      DFC67C17A9F45E0A5635A64A9E39CB140167601D93A4EE7D978978FA22810AE9
      9BBC58E4966AB373298F5285553F2FEDFE65A89445182901D8FA337E5648094B
      334AC6146DB780023924FAC838FA277A512083BE15952B80D34D6EB4E21FE09E
      EFA10D0E8B71BC9C68926276C8E94A5E6DEBDD842DEA707383AF44954451AAD7
      6FB38574935640EB6C0A8B2F4D77A7BB33F8C31FFE50B728ECA7423DDC7BFBD6
      5CB38B758F15CAC1AE8A2613695FF91CE21B9A03C023B8F4C4C4738EFB571995
      6CEB6E633F83CAE4E70A8B8E04461502AE211209FDE06552E09EAF65F5029640
      10DEFA5329E9ACD9BA3FB4EA676707CE7C70294C595F1537F7D3F1B497026A7C
      E4B00CF6BDBD5EFDA4D443D7F5078B8C5322EF59FFFE1B9982F8E25E68650CF9
      DFFBFE3512BA79B4638AA996F6145E4F927C0E69049EADF8367F5BA0C8959F50
      B3493F2C312EB38983DBD47A13AEA7B9325ACC2A39FE0A240B8E6938CF27B63C
      6535C105A15C563A2CC15FD565391E747B2C3C81B042D01492D944A85A1C4A92
      4547108F81CB1CBE045724431930FB04128118C1E3B77E480D02D9F0F073741B
      598DD6D38D7960D34A6065AEE9B2B5502BA73259F25BE87C26BFA043AD6E737C
      C055A3EBE6FD513C36CC9E1311DF09F0E43D4A876767834D1C425C42A4D4E031
      5DE4CD8DF052A9A3F9CD78BEACEF3796E27AEF6095A6197C21925C861BF5C392
      3677159E464F48153068C5C9658A19412DBEE65EA725E8999A2DCE837A0D52EC
      B9D67138A6085797700F1E6E095EBEB9E1951F648837547AE85972B660B930F6
      D96E052D5E74E5267E23CBA63019381C55C49AE6BD5245AB355C476BB9687E05
      034C0B0A184DE89BB1EC9C4A5CAA5CABF2803AAC7D5720CD6D823197AE7F23B3
      ACE6D39AEE64571D43DD3C45FB959E192E1E983B3870B4B0E912D46CDAFF3468
      B791F115DC2D6EB1C33165FB8E6CDB9944794BFC25413BAFDF243ADAFB62C535
      D741CF914C393803EBCF8C9BCEA5AE18BB9671354E9E70DEB766D379B01629F7
      8B4B697FF1C35063A93E17E92B83AFF8F25C6829A7B24953578234B21CE8BD46
      AAD1663E8262026D1218B6E215944BA8E98125E62052B5E1C9FA71B8D0EE9B7C
      5BA95C22D4CFB5A1CA9701D76C711FB6141A3FED1B33FBD955C26C590ACCFF46
      14427AFCB61BBF5ACA8D8A9949965D49A6C4468D38F163290E40DC6C698E1930
      069DB2CA655501FC678C05187AB56C7D1CB451B3FF4EB3B1EAFC659199E1CCCC
      733F9D5487FD7BF77EB71EA7F7BB375AF5D35CF7776F24DDDF57264754A03BF8
      F575D5A0562AE423E22676773A3B9D7FABD9E67EFDEEE4CED7EE4E7EAF869BAD
      5A054658162138C7F9DD9BB303AB4D766AB6793272C7E571BEBF5B7230D573A8
      61465A494AC9315006D602D6C449B7E9BD7EFB83781D9515AFD92C140A9FEEF1
      4EAB6643BB19F4BC2AF0445DC6259419A447D934F9E8E789D04EB0B18D412BF1
      40CD865DC267D6737C30546CEBF7230CADF3B943E38120B4E986C6838D3B5EF6
      ABFAA4DDEBFDCF150A7FF873354A32F9F800260C3FE677522CBB5154A11EE28C
      349719871676EE31F4C9A3EDDC6B04800FCEDE39D74989B24C78992AF397C23F
      71BE949CADBAA9C3B52DA37D1C6FD0C7016FFEF0EDEB13A139ABD956D152D205
      A830C2A65C42AF550D1C51F3F6F6B8A1BB6623C7A84AD6718D6DD6E91EAF2570
      F93C548EE01C5991262922B13DB89066FF68AFE99D70A307A24795570ECE8E6B
      179F5D0B38EFA7F383B3FE0B9672D66F7B7770FA7DCD368AC470F705F9333F0B
      51B848899A8DF1202D803DEA5BEC46697A432B0DA25985B37FEBEA510A2A1CDD
      D71C91B96B9F83F7E6420A14E0546651A4DC49751BFAE6C6BEA2AE46B7A93F4D
      423209A592334ECC24B2646CDAD46341A47D6F6A7274DBCDFC7978B9E3FD8838
      1C0A6CE6CF13A513F427D232B2F4B024F67E3179C6FD275C250AC4AB02E82E99
      5879130940323835D0F41C974C61C396FAC512F5DD015AB5E56D46FA07C14E64
      441354FCE0AD42DE4D46A22595F399A28B47558012DE4C622D2CD177036A3D4B
      4DDD2CCA5767BBF464EF636BA75FB391C1FF7BECD2EAE705FDE5E112135A81FF
      6991C9CCB116F0AECF7C293AB7601752747965BC2049D19F9B44609C259F43AB
      536CD70C979773710A920EF2E11D01B0BBF44149288D0AFE245C4C58354849D6
      F17E5F7229E7AF3300554E9220AFE2F4AF03D60F07ACDBEB80F5AA0DD4FDDA36
      D0E6C64F6767076204EDB1764051E9641178C562868497B70563568DDEED26B4
      2110E32A7E0BF4A3358A69BF1F5B92FCF34E18865FA656AD76463959A4FD17B4
      1F3F7B8D3726450A8F5B604E82BF9A705E342C7DAA30B9D46DECCE4ED551EECE
      27400698D5D1E0538C8A935E8590B666433CBBBACD93A9F7C329E7315EA34972
      31EFE177BD992FC9864AB5490A9ECC0FA790B43BE68661F2696E3F6C6EB83F35
      F137CDD64BD6F5391953FD8F39FEFE3CCE7AF493D3AC75DBADCD0D617823FDF3
      1226E8E87944A638999497E6C68F4C984C49BD6B9BB02247278C3BF83189A439
      A0F10A112145DCC59A6439080A9463A021E66D536848F541961FAC6C3160F4CF
      9A2D0D57E32DE160BA906B924699D0DA16C93499D0B8C09ED7D4C005D7662AFB
      A3B66072711A334FBAE765E9A46E40538D53530816EF222467D334EE4E484B11
      E5EF5C5B37F353635906A6C2DC557169FCB47693B40DE036E67FFF2C1DFF68E4
      BDBAE50242B6890B320D73BA12B67CD2250E34BBCBB62FA0A56A366B948B795B
      9065FF4D4A70FBD89F1D03853847B27C7E23EC7EE5CBFFB130C5FC1C00593B78
      91F611ADA24CE18A3A2D86B6952E5AE57F966213E9176722497232270BAE6C82
      AD2AEFAAD99228E15EE4D0A310EC4EEAA8523F6A537BB0B890E4316F1764CB54
      0BBEEA36E2B492F76431E9E254BBEF0ED9912C01E5FF5A6469D34B939804E814
      F1A1C49FD08F932C12BF72EDFFFDAAFFB7F6FE56BDBFDED7F6FE7E625F432DCD
      33E03793D638D0AA1A35336BB66B3AE4B383FA5AEEEA5C88C5EEF56ABA909FD0
      2C023889463BC7E155B3C17FD3CA66AD2B7E4D57B477BA6B6DB1AA2DFA6B6DF1
      BF54140B458C0DB8229E8A4AF862E2CF39B1671BA5246CE32865C26C3A85D49B
      70F58B8DDDD46C6A8D33256AFA6C37BD6613F875076C2DC73F21C7D756FF1D39
      3EF8DA72FC9BB6FCB868C7E518AA32F362925D336B8441FAB66EC376D991D75C
      6BE2503B65B105F8CFF81C8CA2B9D57412B2F6F857D7DFFF982551E15D48B28A
      FBFC7243D638A6803D8916B3C9E60688CF1D2B30380E24485F34D97E2779A136
      85569400CB11D117064927A5175E3258A0F00895184308EDAD45F0AF8BE075DA
      FD8E081E7E6D115C8A835D6EE97CF7EA60B79E1819DF4E009AA91801110CC163
      A6B3F9AD474FF16FEB36CE1B959D18AA15F9AFCE76EB4AD763874B0741CF8122
      38A1B7D1A0B5DC4703B334374FC87E28427F66A0016A3611BA6E566B21A17ED2
      95DFD62AE4D755486BAD425655C8E86BAB9062065C803A873CA5AA5AC9AB26C6
      BFAAE7002DDB1CC933F4387111DBFEE1EE512D071B4F327F6E13DA39C0BDEAE7
      A2F9D1479F6B128EB3881BC60A2F363E6A356A36501052FF5F307EB24668687B
      3197F7AE425035965CCD8496FD631201DF91917B6A362FC0A56BFD32030E7114
      B1C45AAFD968CBCC489D5B44CA517A50015A4B87C83732901A9B9537BC6CCC4D
      31DF99F93835EABF3A171F157B0CE1824296DE7F73350BD922FF4DD6C9B6348A
      A35CAF6693573AB6A2C8C2849B306CDF0566FDF805BFA84CA4D5FBFBE6C6632B
      CDE697196D0FA3FD0263BDBB00BF79B471D6FD12836509FAD86BBBB941E34D3F
      7E91F182B72D2D6A2868B8B29E34A777925FF869F20B79555BED2607C33ADB08
      82C5C20F3427B35E7960A447EABE6CD01700927D3ECD74102FFF457F804CFBD7
      FFED3C0AB1900D3D7AA314833C03EF0F0C0393249CD361A7A93FF271573D441B
      A61070355BDDF44BF4A09DBCFCB20D685C2A2D943CE4DACF1673053A661B11EA
      5DE30D363C0E1681E92244C8046749BA69407A0B06D7479F7E83E6BFB3F3E103
      C912274A3E7C206BA5F8F06173C3F69744DE7E0210BA398DB5F1BFFD0E976157
      3185C97EBF4C2275FEC0E929AD7E7E38CF6CCB6BED6680D10B4502426E20CA44
      4A851199CF4F0F0EB44C8076D365571C9B9001FBA8718DBBB5445ABC93636A62
      0A776A079EFFAB422DD00FAE55AA7E31479DCD8FC69F65E98BDD7C9AE52F76A7
      D345AA45333304808B4B63E6B53B6832F25727FBE72FE89F8EF04A3BEC610EB6
      3B943BE94F5306996BB64122D07343BC59B506E8D46CB2A863E79A4CF5D0663A
      F64F5EFDBB478E7334A99F9ED4B19EDE831E1C19E0B49660EBD50E8F7574FBC1
      E8766BA7BB2E52B913DE1E7FEDF0F6E686B0230EC62F39E03225FB29141008D5
      D72BD014DCF413236AA768F2A816F0FC29DE85B73BC211E04359D4B4BA495D99
      73BB4793D672898494FC0DF72A292AB000FEEACD3F013A1749D9DA119BEA4406
      9D9715069F3C9B8B15ECA71713A88A7C5AA2416F550C66CB939E95BD6CB05BEB
      C69B7599CDAFCC6D51EDBA2C5B27B5FF72EBF183225F86B61050E1E0B8CBA74D
      D4E7CCFCC78FE7FCF1B3068D68C43FE2D9F28A0316E6F1837BCF1F7F9575B869
      969AD5F1D2C47F7B80EFF1479CA47403E7F5BB7B93C83BBB4CE2B9C20E31C11B
      1B6CAADAE19D5F253386ECCF18835EAF24BD939C852D18A7E408E560735F84DA
      E7271F2553A600FD2CA90DD4250BBC9229AEE6481591C95EFBC5082D17EBC9F7
      9F944E8C6D950A2315AFD64C95AB235377D25B80B080BEE4F0946BB60AE606ED
      BCE6C1B1DB5560602AFFA39F4C6C62AC9E2015322A26A550D63F447D2F48ED6B
      FE97F6494C7FAEDA25A1AD51A6C2DB42C124B33EB1A157B7F30AFEA93FEE0129
      2CC134D2C9ADF71659348C8C599626C92CC87C30511C142153A4495DA8104EC9
      E1ADD99CAA55D48AB9662F0C822F6AA0460BB283627F5258C0D28F421F9ABA7A
      6B8909D691E54E5BE725C969B8F15940399A74CEA699F74CA8AFEE7F1BD2A1CF
      6A36A10732CF9566F0E225623782E9C9A8213607BCC547F8C7EDA6F7639693FB
      3103D8C0AB3CBB2E90AFD99DCCFFF8BA5BB75BE7766486B80DF912A071C9B2AB
      A99F5FA9D8D76A8797CC10F7C7F6CE4EDF06B97DF7D6A687E9D9D72E322FF0C3
      AB9A4DB552A408926B07F4F6E3E9D13EB061321BFE4DB3EBA6F72C4B9F55A465
      CDE672B7EA7E2B30341D8DBE358157E7DC24F6BB6AE728E9146CF5838F3828B0
      5848BBA524F7495F09B34D310104A43407D0D59A09E3B24AD3DB6C913BBC8624
      56A8C89ACD7473633942778F56D8FAF1FCBBD32647199B8CE9DA9468EACC9FDD
      E68B82CF6AD37B63E607205ADA171A6AA5BAA0457105D96FFD8FC7DC25E26D81
      33F68A35CC5FB3F43A1AD674FFA5D69D27BB6567AB1BBA8DC1237F21B41D473F
      1CBDF1B62E2659E04FF825FAC3DB1DEFFCD23072FC33F04F91BF64685504E069
      EF7BA43BE6C025D5422DED2351EAC15BEBDC4AF10D037BD0C72A3D24755AAB9E
      5DABBF9CBED9A7090536A29B79A707AFE9F03018BBD87EB5040446A20D69AA2A
      A5DFBBA3FD4E652EB4FAEF76F7BEA7ABCF0114D43FD56E12C8B5BD7A77BEEF78
      273357061864D12D93A8158EA591DEF9D64B6B78A2781EA786DECAE9CDBD83A3
      23BE17AC0D2FA442D397B0296710624547ACD72C702F5E2864B7667179025515
      7FF2FAECBC2273BD2D36AD9F9D259C6157EBE699AA7F3604E2787B9D23F98C1C
      C9BA8B6C3547D2BD7F037FC71C8929668A6AAC6C2AA81D0369A3B0019A625AB3
      3DD3AC4077F012A41CC5DC07FD3419AEF144910AC9B4B9C84D51708575288901
      F8C3930CB6BC2535AC9B636CA7357CA90C8DD27DE6741DA9085091CC81AF0BF3
      B7F00ECF8FD111112959F65237706A982A965E4EEB977F962E041496B0641DA1
      C23C67055EFC6D81FC7F90D3A69AF9DD296B3EEB2261BF4C021CF89C85F261BC
      BE82ECDB1DB3E3FDF47FDE25F3B37936FBB9765146F68CF78389234F5F021E95
      449D70A0168CC818668B4954925BDFB249C4F667A6FC0882CA58B7BBCA26A643
      90D41E1966D3B92EDD670545C51422A121A89B4386CE4A9191389D56408294D8
      0FE780F213C67A0EFE4B80984DB8C2D6F0F5C52199095D6EF9010E285B5E670E
      F0D56CE20F04B79ADEFB43CE7FE7D96425D2B55B14B8B8533FA5C39B37EDEF81
      8D6AF1C9AF5F584B9D4B91BC7FD9FBFF4EBD2D93DAE2805F90DD7079807FDB5E
      7640E04CD57936EF8E0FCFEAD916EE223A538E456441917129229A612615CDF7
      D23B3ED97FD5A47FCFF69BDEEB376F76F9DF33FC7B7E56CF492D940CE8688FFC
      B9AA33812A6D135574D7FBB3EFDFA9B555D35BE124B51680731282F6EA23E8D9
      131F69159E96471A0CC200B2AFA65311D3A38297628966388C50E75BF26C5F7C
      89674A2D7469B89CB5A23C9F3DEFB47BC3DEA83BE88D765AF8DF33E85A215977
      ACDF70DCB5BE571E84881719D27FD93BFAB1BC73B5B39856A2BF0D78ED1F3E08
      A98117A087B568D8F2ACD5A06FDDE3BD3AB72A9B928DD04AB5192E551DB97435
      CC68655DC5DAAB8A3C3A748CA851C326579D804885776F4E4F2BAA9DFEC91733
      8788EFCF2F2F72E014093ABAFFB17E7ED5D26CEE9171C76F0E5EF35982C92222
      E02F47277BD55B5FDFF934DE0B63B3CDC2FDE5EC60BF41222CAFA1835BB688C8
      D825A1B6BC196FDFEDFDBFE63DA99D350BD4E74412D76022772289F7B39BFEAE
      D5D68A43451EED8BB7B423C7866954E0E56A267391D249DFF1DE1796709DCC12
      A112C41667C2AFA1D58DC824F8A8C0CE93CAB5A8CB7E9F19402DF1DC72F3B745
      9203A5446AABB92B38E2E615124F51DD462E9BE4D3322323FC50CF2FF601E8BC
      F1AD6BFD7A06772591D2714E03612F6B36390E2FEC564E114AA748741829BC91
      A2AFBA0DBAF1EF8BE98CE16D33676F88427E56D822FD59365BCCB86DAD6EA33F
      4811B27BA1A13BEEB320EB48BA0DB426B26E433ECA2EE4182379F7D1E4D77942
      A34A91BFEC1EBFAADB6837377EBAD9A713020CEA3979E1E62634966D2947600A
      B96438779779B6B8B824598B3FBCB35910BA0B973E5C752ED02DE6FE74C68CA9
      53F61F0383FAE57831616A55C4DD3DBA21D2EFC9664BDD56C3F614D25BAF0AAB
      3F2AC02AD2B303DC3E44224AC0FC1DEF9D3A85F4FFE4EBA34294130B1C37AFE3
      2C5713D59FA80652C232A04F9D1F4B531362B0B78ADDB3FD7B1A95BFC58CFCCD
      36C8990D56BFACD9867E7DFBF0AB53A5BFAD5225C108A9DBA57BFB4029EF56C9
      F1959B8B0558F0CC0D78C218FA65BB8ED3A8E667B6CE8FFC80ACA108EE53D33B
      DF4391F8110DF5557653BBC19FE901D162043F04D40829378E56D85E39C92271
      AFCA1F5FB3248799274E040947326A0DFDAE0A0165E5B59BE6A9E63C8ADB74EE
      DF7897742727B89770977257F8AE66EB9391DE80352FD6927B55727F7582E71F
      7CF2C1994524F9054D6C736D00438894110EEB76BD4E16DCAE2D79816F61C087
      12216C77FA4DFA67807FC6F867E46DE19F6BBFF01AA8F7E0C277CCAAF1746CBA
      E3A408D7426155287C75DEBFCD8D3DB4DB4DB3288913B468314ECB74E6CF9320
      9924E481B1CE0E32FA67DFD02412EF2F07EC95FDE5A06B21859845B6C816393A
      DA506153B78B29D132303FBFC5509D775964DE222DC4F116847836591414A264
      16D69867EDE6F5EA766E76316E6F62D20BDA22B27173F8C79C241EF4BC209917
      EB5CC467E4223AE3752E6255387D759A39DE25BA8C25817B704BA22A99FA29CD
      1898098CF8F2219E44B0B1FFEBC33FE3471453785F0038F1BBFF7C77707A74F8
      F67BAF71399FCF8A972F5EB8B1EC44E663E2A7001ED821F1F982FEFBE2DC147D
      0CEBF9214DA178DE1B0CC79DE1683C68787FC7C827515E4CE6FFE89A2D261FC2
      B8F33972FD378DF1EF74FC0AB2B1E4FCE1276CBDB9A173CA91ECDB616BF421CE
      B2B9FE18928B7A831F4C1AA5972637FC697C04E9761C5A7E9A1CB970F2A188E7
      69F0D72FA0CD6A75856D49084AF09314E03CBEED36894C98E1406F9D6A5DEDEE
      E9F16ED37BFBC3D9214AE4F63B4D34BA9DD4CEE5D5291D7CA48D573A42C120F0
      2E50218AA0F3E1BEE4C8915D9A24BFE01D524E5BCFA9BC7EA8D082BB136DA84B
      A0751D4C7CCDA6A26D07AD9EF792E68312E70C9DEA687C247306CD218C0B514C
      BD2DFC70719915F36DCE3BB86C42FDBC298BFB351AD1ACF605DF92C32A30391D
      49246DD76431253B349903ED842C371A38E0F88558B270D5E8DE56B4E0CCB4EF
      5DFAD241991B522C8CC3102C2EB6D1544AEF4F8087092F4D5C34C15BF6510352
      B705D25D6F8F697D6C6BF825A745FC28C291A5352B0AEF2F47A747AE7C5FB1E7
      81E323297BC92D60EE5961E4BD4C17906D6EA43420937317519A5CA4B681D616
      871D9E1FD775455AB4221C20AD406870BB02436B14CADC40722B89B469A3D8F1
      762745D6649BA3B1FAD9065C1CF40D8A38A8DBB44F2A8944C57546B0155BCD0D
      CFA476E628E3E7932C35198121810CA3B96E73D13BDF29CFF49E3F237BD3A1C3
      6931562A1031DC6864485408E1A06D318A12B877B06C6863F78DE603F8D30C11
      C8471C79C402D0EFC05EC1F17832C1987582ED41A7E7AB73B2567327C872B326
      777608476380D21D619D667E413696D7008A73C3BB32B7A4B7A0C76BB6ABC865
      5530752CDE56DD440F670EAB72FE770D9DAC7336F513065F9D1D14E1D9E98C0D
      F58CEEFE64C23ADC563B190FD6FD0D4D8C53DD64F843C7E7F2C6648EBEE28F86
      D1EC331AE7AD763F06E632496B67EDABE9D6E9C374B32037DAF02268E2DCFA6D
      94D0B3AEC36FB3E5A9A0B5DA0F9CC5DE29995BC85C09DE3E4334B1D341D6C9A9
      03C57568851C1F98F8B712C6951A5B186D62ABF3CB594A36FBE6C65BC6F8E667
      97E0BA7FD93B3AB546FAF2D269935EDD16CF7A7AED4EEB45BB0D77AF5C149C77
      DB9A228896AEDA582A75AB2B38C9B2ABC5CC8B161C97E0DAE3484F1237A1A3C9
      9A012E17696E26491D9590756186B40AAF84B541CB08DE5B9207F861FB5AA8E9
      E65E0056AFA67381312F3E8AD7500016097B35680F27D632A8A133E20E661BF7
      7AF7876ADBD012A803F78CD30D64DF4432493BDE9904BFB05D4A7DE94F6CC935
      5F4CDCE292CC5C4FADE1D01AA9A3A2AE67B3851BFA03070081D6A1CB21620A2E
      177E3B383BE65EB11DEF951F5E5D7028A5C46C9F24D3443D3566C1A1FF3AE00B
      5D06AE3EAE9F29EB4E446BC88A4A4285BEF7B78529E656E8AA98A7C1E6BE6078
      E8158E73FF02CD80D2FF44B23D30961288A4F2A70F4C2DEB78ED620C68310E38
      84BAD40BA2BD14C035114005BE280812A7FEC72943D6ED90ED4957E13DF2AB88
      8A23E454095DC00B32716CC2CD0DF2D2E996B8EB82109D8434A4EDBA6E4B539E
      149834276AB2616DE4ACD8B3508012F23FF84FBBDA878D9A5F1B992CEBC477BC
      7DB91A085037ED0949B89F038814C92F262A9747917FA46F183D77755B1FBB3A
      88D5FD902534D5F3DB99517055B29A10B79DCD0CD9D73BDEB1CCB590FBB17413
      FED7BB66DFA7B82F3CE7B583B6EAA07D75EEED6473434DD72E9DE3F79C25BA13
      7916D5883A1395884D7B3DADEE4C412F0C481AC4E4D870DD43F16B2C0E8473FC
      02DB0D4FCA02509F73C9563850701E0A40B46B9737B4B79D4D41258952AB496B
      71046B47710C7C32062E401DA5F8E611D39CD979627DF8ED3B36E11165A6E015
      2213987DDE4BB3FC645BAAA47A887FA3E593187006679956520B0B9F8C6859D7
      E4DD2753BE3AE191F539603734603E934B2BE7B62109AC20BB2191115E66B944
      08826C0E9C75A07592C0A8DBD5F73F6609902FC4AC07CC5908700C24DDAD6D43
      C22CF3B8AF2B32C1E202C193DFB532F6DB2D5B1BADCBD656EE6FEFAB83716E6E
      FC08CD36473581254614059320120B8A55A1B630E4DCA0E7852E2E439A5B5A12
      B1174AB61AA695A5E924806F7A6B6E16EC339CCD8D3F6537A8B8CC14FE93CC02
      6104F58B2BCF0F8045CCC350ED47E26131AD29A8D33B8501DF92BA1B1B5CD976
      38CB309224193625BD657D6DB1873043DBDDB54F8E559606599E7AFB477BF59C
      6C03C80A6A087987FB8DFBEA8F34B854B3099C63E09A45771DEEF726D4793216
      25B166B3D8D5E2765C4309AA571882E88F1AB9FF176FD46AD58D1797D30B86A3
      BF8E5135CC26EC68A491A5AEB07551244FB92EBCA6CC469B1B8D65486E079FA0
      8CB16102AB400C7FA52639DA7DBB2F7C093C61FAE1D09DC32DA17E5AE67CDADE
      F14ED20AAD87E2620833ED8D34540A574DF24BBD89A01C33EDBD789E300F987F
      47D3D76B0BEA332CA8E1DA825AB5A0BE3A08916AC9F79AF78B127F9271C20544
      C64AE1C6007BED9D51CD76EF48AA9ECD8BC86801B4F116F378C4C5D29B1B2952
      BEE7B99F1693B2165C2B549BD2417CCBC26C3A15F8211255A8023A9BE7C24798
      DB8220E0FA68D0779EA1435C41246BB61E0AB144C25774EA0B17E005C9604153
      8E22B2132C27EF5A647D86C81AAC45D6AAC8FAEAB81816D1E664FF1C779A9432
      9B6991B735CFB34580C21B8E77EEFBD7E9C5028862A6A89D2BE638AB5E3B707F
      6063EFEE1D68E1A1B44A06C98C919ED97BD140EC21FBB06523690E1ABCD5FCB8
      60A4AB4F4C068BEBA7B8E79152EB5F6610C51DAE27D0CFAE5699300E3E8D173F
      540A1E19FE8293DB155808B25557EDB535FFCCE748BFFE5AFAAD4ABFAF8E2DA1
      6283DC13702970750398980EDFED9F59A608911D35DBBA253ABAFD0350466965
      C6EED1DE77C20CDDD837D208CE3718B17612E68DBA89EEAAFEA9301B140CE597
      1BE65451001E7A4F07774A5A0EE9DF13C1138698B7121B81918C5B16915E2333
      DB93F6C57ACEBA227FB9B192AB0494E3D34D0D7BC912974FA7FFD12E87CCAFB6
      1383BE05A05F65678E0563FC1DBB405B96798126CCF2B1B7CD5954E652B68534
      C0CC4CCBA0221385A6AB7182DACC9D81F2ACF3374D0ACEAA974487751BAE005C
      3FD8477AF6EEE0A89EA404EFB87DE479C080116544A9B8259B4BF8321B42E42C
      3D290DE9A9DCE21C648536BD6AC280CA082412F3AC6E02B2A15D72328BBA0D6E
      9764D7ED2FC63BCA2E64808848E639B9C493DB92C7F41146DDF9DC51F3187D7A
      BF1B35CF23EE78D9AF5A3DED5EEF7F6EF6F0873FD7EE49261F27F787ABF831BF
      57CFD6D56D9E4C1D6FEF247B8C7CC7A3EDD44930493E22D674BA4851FD2EB7F9
      5D9E21650846BD8B4F43697CC662D1747F0394C6CB172FAEAFAF77526436C981
      2C189E22D351BFC05F5EF4DAA341F77741CEF84706F4F7BF93CBBC06CA587B50
      8FB123C792D851FA762E66CBBC2C06A4357366402BB0F9077BAE7182287003A6
      BE28E557681E42CEEB456E7C7A7A8066306728D2909ADE99F91BA343343D0D52
      7304BAE99979B853376DFD7A310146F60C46C8155AD825AE947B36ACC62EDAF9
      3A60F2190193DE3A60B27ADD6B80BBB792E342F1AF472E0248C1E8D04F988A12
      6E841605EDCC6FB88448086519163D234FFEEC8C9185D8D1B70679CD767B1967
      E723DA5FB822B7422E45E7F53FDE9F9DD773E04C922E2C6B7CF98140B1987138
      213000D67065181590D27A4E65976341D38C8BCE27E6C20F6FBDD3B7BBC71A6C
      47BCE44F7AC2144C405F119E23848AE8DF63FCFBE3C1EEBB2647C948CD1C9ED5
      B4CECA2234DF3F7E1753E1392E47551669E1C746E260B3DBB23DCDFAB90C2404
      592BF773BB769D6AA0AFFAD97B9B39C6DE2CF6F60F778F3C34E3CD6A17447104
      092227EE12D031498F7F11659309608CE8015E98FB05EA88C16BA34593962CDB
      D951FB477B759B2BBA06BD46D9D8DF509A1BC0AFA2C1594D3C65EBE170659C4D
      A01992580B49611DC200AC9BAC77F549684A27F57A5B2A33DAC29B414F834B75
      DB92EF687DBDBDF3D323363659EF8AF1A9BD8CC0C8C5018C4BB3746D7A7E86E9
      D95D9B9EABA6E757475555D5785C252AB5080B38E312CCAAC61F693799D6B478
      B98E40DED9CD7A44208F201BC4D0299ADE21442C39FC3343CAB24E5B46C37BB9
      3CBAA6F71D988FDFF9F99C7E7EED878F5576FB68633EF543F3D2FBCE4F721AE0
      C1ADA9E5C2EE0964B9C96B35AA5323558EB51A14EA103D30E7D46A54DF5B7F2B
      4B5F7ABBF934CBC94731FE0C01BADDE9346BE26AAF9569DD94A9C671E0BABC60
      87EB478ED9981CE512301EDFEF9F8AA52E5DDC6043B27CC7A4548BC2BF10CB52
      B07D4880FB1F8F0518A3669BBD12AFBAE3A0153B6BE3A0A6C6C1E6C6AB77FBE7
      CC3F632B386FE918DAFAF448E271E25373B320C0E069C208D5F1D94C626EA599
      7B131FC5AB64097A5B654D973C8D7D243CE83152098F69709063324F80B32258
      68D551E3EF34DDC8DC7CF970DEA34D099152CF57A898657CB772663CA9DA8DBA
      98F3D9B9BB11FC42FD06EDC2194E2A33EC467AC5F1BFFDE4238D7B9EE5754B9E
      ADF5B27572C99F30AFFFE2CD2EB3D4A0A6FC9A35B1E6502460A8555A95EAC7BA
      69DEBB55F9C57285198F1D2921BE645B32BD29C9E309CBFC5071B199C29DDEFA
      27795F0945A7B2842112E70BB14D4832A2E63E069F7BFDD8316D6A46B87F0B70
      9A3C37A9E0FC33BC164036E90780429E1DFC87C455B7D0A00040316515B72162
      8145F55132199ABA4ED58922A930E41ABC1A22264AEDE6DE77BBB6E4914FA0AD
      E114F48F4B7F02BA2A3A6BD2CD87E4CB3E8200C774D66E11B1AFE7ACF62D9304
      A75134ADD2942BE60B4188023E2DDD4E2E5CD54C53DD26F636AB50BDF3A81BB8
      2457D0CED70048C26F0255495369D46DF83687C275DC341AE9BC413BA4ED224F
      52469443FD735402FCD765FC9B1B5A60FB3A99306B2CDDEC3DCD604919E88EF7
      36637673DA0B89ABCB5EC5F281822C567AAFEE1D368B198DBD93EF51033E9705
      D0F7CA123419EE4A9AB504814421B19821E626995BECAC8BDC9F360597E4CE97
      A9278BEF32790D018575392B4802D6BDAEE93D3C131C380D08B075B9145778C1
      35E6D8FFFF37C92EB8166431CB18FCBB766C249B1B62A74C136091A387900F27
      1F5ED2BECFE6C2EEACE94DC96CDAFEC1BC4C1CBAD3C61EA970B538061FC1BEC1
      B3716CF9D1DC74C9F5E8F40EFE067E1EBEA6E9CD1673CE9CA6D5CC6A9E65739B
      5915C3D0BE48EB6AC2C59C9FC6A6033D7CCB96D1EED08B4D8F36E407F9C9CCC3
      3558D56765033BEB6CE0AAA3F4F5E946A474FD4C5A0CEA264B40C95122E04A31
      81C9EB364AE92C21CB2360B03E0646420324366F0EF41AA04A6679ED480B4EC9
      279E0624FD6659A17C0B243611D330A81682349CFA8CDA5C47E3A9EC51977A0D
      451E675BF0EC3289E77FDC0F267B9324BCAADBC87FDA9D4C7EF67ECC6F0D3889
      2F858F0FB978C57FDBFAFBEA2DEFF02D5F1D53EF7307B5B9F1CF3BA698EDF017
      DD79F86F1521DB38EF6A458A6BCD840BB53C343FED1E1DFDECBD3E3A3BE78656
      0FA39282AAE5186A3DC77DB07FB8EFF9804307419405FF7251EADA0D5A4217D5
      6E03BEA6C86DEA7999545E2B21737C3D41008BB7B2755E82E6D4749ECF272F6D
      7E041CEA530853586A5E4133092F056C2E63905381215B9A6D2D89D32BFDD570
      4F122616D4AD93B019476F2A35EA2F50C8CE75ECECA5682DA3017663EC041C26
      57BBA9728C4752EEC759F43D19AD87C727FB368C655128E14C7EF47306322919
      40EA39997747FB9D6530803B54402CBAC96AA1335BC739484E5DD811244754C5
      056722AC181C24356467FDC9FA8B366E9F5DA33CE73299D92325DD1EB401E830
      A8F1F0CFD2ECFAD6BB363E038F554BB2939B6A3E6C379F5F4EB32C5F7BC39FE3
      0DB7C76B6F78D51BFEEA7C7B4959BFBE5ADE82132EFE27272B3857010C2FAD1A
      581FF9CF38F26BE0BA3B47FEAB33986C6EBC06CBD462FEF6073ECE682D99FAF9
      95D273593CB724F6A2C58CFC0D4E254B0F11DD878FA01802CE335793D76C7785
      8E8DBB842446007E40EEE8987B003D1166A9794D91B61B6841832C9296E7A2E1
      70502FB3C524AAD872C293C45B64E67E32F13E26B87A1C8782BFC5B5006B01F5
      19026A8D2D7747407D753A94CD8D880134BD10B13CF491F9169F5DF339B68E96
      8FBD90845E6642A5CA3D5D7F5D4C678A9CE0CFEB09C57447548596447666F22B
      2BA8503081791CA4C890BDCB92B46E806C9B1BE2AC9DB1B3C69832EC32CB5FFF
      A87F7F87391DC89C98F50DF506C024F33D46038D4079C6E11FD063D8AA410738
      850762DF5DDB2497FCD46C25500FB2746851689593E5785B6DF7342CC8AFBD6C
      6660622254C20132CFBFA061D76C4A724893F439A309DA9182DDD1B20E86F0C8
      3DDA8A4B0E81CD98AF5666896818DB0B09442F2683C2B30BE4B0FD105D66D742
      9A62E4B514708313D0A20AF67FED8C8B6346A69572789E9CFCE154616AA172A5
      D25523478002FE510AFF5F5AA06F7343CB9600F8DA9F34AD77C1EB10D227D770
      B0BFA2B23B3BFD9D7587E9AAC6EE7F750224C4BB0A70F8997C7E1F2262487F47
      5EF16EFC747DD43F71D4DBEBA3BE7AD4BF3A530528DA5F279B1B372FBD789209
      BBF50C7619AB3F3F4F0AE178808E9FA032AF112F7EF9E5B601E64A304EFAA050
      2A900CC27D4079ECCA6368BE81C9E501FA4838B02876327F5BF81346D421B599
      2D2E2E8532D91644AA71CC5CDB369DEF87E12207EA0BFDAE06CA56CF0B6EE766
      7BF58B8579738766C8A5535CF3070877B40185522FCE3553FCB1CD8D428C6BF5
      4D4154AAE393414B3481FFB2BEEB9F71D75BFFF69556E9FE1BF50FAF5277B07C
      A5DC1AD1A2F01A7D86DBD7383572FAD5DD9364E3CECE4EE3775C9BAF4AD0BAB9
      81BE6E98C30CF2A7596269B54B98443DB990ECF13C3786DDDFE7FFEA3DB46CBA
      6AF7BE2CF75B224DEC74D91749505894A4C020DEC48484EA4A4B5B8570F682A0
      EF963372791255A81FB8AB708AF5835408B54F3D7214BC78C6368A92F9379660
      DCCFE1C96F4274C32148964876162C3E51F359987831B115CDEC604C693B1350
      8A910DBE408E7A6E2BD94951A6CCA82356BB65455CCC17B969326AB63FA1915C
      2B43A33FB9F66F0B78371F31255FA39C8ED471CBEC5CEC7852F9FFFAA4FB4E90
      A04864DE2A81315E48E98D5895893F9BE1F7CD0DBBB49A1B2FBB2B75BC4DCF36
      AA4CFD2BF80FB91680A78E988EFC48FE02B80ED8225B0BC223D1C7C39FC657E0
      19E2B009231FCDA1D238B25A0D143C746C83252CD5CFB9C13FEE9EBE3D7CFBE6
      E5A3171C6D6E94E111AC60E5ACFA5C135DF042C872CAC9E695D4EAF90BE18366
      C524A0FE70DFA4A89D16F64A0EB2304DCA23E6979B1BB4FE8B820F5352D8BF23
      40CE5E9FE33FE10388CF47863CFAC85FDDD5D40876E5A5B2544FF9B2A16682AF
      04A8074FBAAC05F4F803B057CE83DC4D474E582CDF191EBE2F75F916CD85B43D
      DD41A879577AB84BE7BBB94C4D8A73C2317C2C4832B1B0F88C323AF173C88328
      E2AE02FF9A14798341D82B4B46AF6BD53588AA1633FCD47BF34A4E5BBE10DCF9
      458A5CB7EF0D7A01CDCD7E356DD88F5C26B676007EDD28E8EEB4BC83BFBC3B38
      3D3C3E787BBE7BB4F60656BD81AF4E02C5D785A4932A5818D90862A150429A3A
      EEA4959B6AFE2B63C514A2639A2999EA92F655727AC0314524F54525D2D56DC8
      AF21373EA9386AF0F5F471CF6EB96286DE1D4216911DBE086D63D42C43877F82
      0E48527B46AB803F1A4717DCD863A47F845B0FB8B1ADE1588DEA56AE92A92AE7
      18645A912FD96273635E85AC707A779A15730B72A5EC26EA954D8D9F56AC0616
      73853196F6B600C101C9B96A7AD4BD394A22B4B8F00BB7DC82529849EC6DA190
      1A7B977A651F49316D7A7B67657F2E17D4A9076563C58115A99803D916875CAE
      EAE028F182B4258A50B7FBA34DF5DCA24807D22A1596ECCFD34C204C6902B812
      53231A8C9FCC0650F5F1B85058AFC2E86CA56BB810BB8F342D2DCE953133597F
      3CB7D8AE7E3B3A657A952FBF4C70FAAB5FCFDF7EBE347A25AC9188F8737EFBBB
      37A7FB62AA1A3F9F000ADAF288D5EC28A267C14DC4E28726119B19C9F4D1F090
      1E73C8AF1617A8E5E248BE78F89A6A0E2FB324B4559E81911E5E0BDA207648CD
      A6724E07E67D2AED7E2C05B56BB7DC12BDCE625EBD436A81CCA2BDEF4E81E5D3
      E2FFB57B3FE3701E483BD93B9F254469149DD167F5B533EE95A0753B99B1F4E4
      BE09F980DA49F4453BDE9B4482346AD3CDE44B6D1E1F6DE85C214B7742D6B864
      04AD06555C96456A37C57CE49DB17D6BD7593EA10F71482889CB70D00C3745F0
      5C2A3CD7581D29CE95B6663A953C1D4EC439F1438FE28C4664B58235A1EBA602
      36373E73EF59C4219EE61694BB00A0A8A5B69E75855DA6A648C0497225FD810D
      C114F69E1D56F5AE247F9E91730D1D53EA492FCAEA57D57DEE72A73C42B9EA58
      1014025D175E35DFCED14672AA90716E9226612D23CB485617C459C8693AC554
      E0F32A6F262B47FF8895657F4ACE5C384111BCB8BEFCD574DEE4B456FA962FFD
      480E1F3734970D196B07E14107A1B34E86DDF5096A40ECF106F18633DBCEBCF5
      E6F8EC7C5BAE10EE1CF7D13BC15E64938FCCF886468B4CBAA6C196DCE4089B68
      DCBA89935DCDF0AB7E38351762C239F80FAEAA9519B2E7238E8BEFBD46EA403E
      BCBEDE9F71BD7FD7A4C0570E7C9F5743541A35E6FE95A9FF572572B43AD69F24
      F35B0DDF565CEF808D5AA4B0B4482329EE21585F1FBC5F3978ED9D75DBFE1DAD
      F2D5F96304E1C406C0E32487938E50719980258541B6199BBF6C9CD66C13CB19
      F85E079EC8F2E8B990CC9F70900634743E90C86B360578FAAE0B1785F117597E
      EB35BE4B22720DE0211F6791F706A5F20DCB5841A67460145087357CCDA6C4F0
      B59631846660ED0F8F64EE5BD83172DC10A8BA30F34A30007F4B25B14287CDE7
      76CF92D3A866B374606A33DC52E14679E7937FFF264F6AD707B04BEBC849BEC6
      22053057DAB0814838531C64905A0DADA245024A4D4AC663ADD9743637CE565D
      CF2DE6B7637E8D8433656A3B925F5D5C25B326028FDA72D2F47676B6B55438AC
      E6C6393CD338730E67A3E97E7B9BA54622E28D438486E79E1B41A3668BE333DF
      33A6B69004B65492DA7E1B5BF89CC571122270AF0DD5359BC5E68604145F56D4
      54C882FD3ACF908DB4886264109585025CF6EAA077252090E4B8A2885BD9D0B4
      6F0FC716971CC8CA6CF3EE6AE85D8D453920FCB49A2D0F99122647FFF8FCDAF8
      57653EC220C59B1453D51592E1AFE03C8413FCC905E06B36ABCD0DD61DB1DBF1
      E44EA6A2E1482A25B6C6D475B984C41BDE161DFEC2FBDB025154DF0BA468CD2F
      99DD49A485467024612B6CEF78BB8CE0CA112997C48EE8B22B33178D0AD13AFD
      B2C87B75DB58E2C9B341A70AD1B22DCC2F3BE6F3F2F380B9769501356DFC3F2E
      850502BFFE6C36417A4A91AD250B6FCB6FC3240F1753985661FD6294CB5D3F4A
      2045973FBBB67106B6BDBD029539AEFA89A32AE8A500CA3E5716B808FA755136
      177035A40D3D085A13170D095CC7D44CB31DEF2C736538D0ABC62F12F61CFDA8
      E43ACFBD20CBAEEA7613914FB845FDE78577F8EC23B7CB5C641C54F50348DC3F
      AD1B0B7ED5E75DD75ADFF179BF3AA6F7721C15E24D3A66A24A6D045DD59A6DDC
      6B9B09E24637D829EF90F4E6228BBD2C8D145D80417649A7443C1DE99CAA9DC3
      EBFCD9C2DB62DB54040ACBD2091852EB86840F67C3C6DD2BE51F77BD0A315BB6
      791BA41AEF85345F734D9EEFEDCC4DD1838A71B0A45CFBEA92C205CEE60C2E24
      53F3322165A1C9DE92BF774BED770B7E85B4E3CC2F34D63FBF5CC68DAADB62BE
      B3A65CCE95880C415E6DEFC1BA493CA75C1B05C42EE33A17649FADD54FF92DFF
      4936C6F73030A087F8B75D3A82FB19D7ED3C8D603F4D1A660A4C2B4E30A35039
      A303A49A1951B6FD8C2C55B2D17748FC187FFE07EF3B32F240C679ABF5B8CB15
      5B0FE097433B583B57EB75A5D4FCA6AC4FF2EF5444FF56F0C5E787D85F4CE670
      CAFBFA25EAA167B68EABE99A75B8E548310D2FD910365E8327AA6DA80E500202
      67915E4A8D7B4CCB7D2911CC13855DC5EB568D7D56A5AEDF26BBA49874FA63FA
      1796F5E31DC73BA7AFDBEEB786CB4BA70B36EC8CC7E3EEC8D252D1B2FFF307D4
      CC18A6D4EDB77A41ABDBEAB57BAD566B40FF3F92E29F0E5D26338E4C2B0EE238
      D682A0B0D5E1FF76E5F77ED0EB0EE28119F6067DFCDB8FFBBDE178D81AF487DD
      7ED431C3D1201A847E386E8741CF84DD6EABDDA2370D7BA3381C754DBF13F5FC
      CD8D711874E8CB479DBE198F3AE17064C2A1DF1986612B1CD1CEF6DA83701C8D
      828E3FECF76930C35E1875FABD5EC71F755AEDC120EC84D1B8DB8D8763D30D4C
      77D809A276DC1A06FDB03B1E8D437FD8F3FD38EEF43A1DFA1A13B483DEB01FF9
      FD28EE0E7B7134C665EB0F46E351BBEDB747DD70D0F6FBAD783C8A7B811F9820
      EC8CBAC3D170D4EAD1C3C67EBFE3F7878119D01C691C41A71B8DCCB835ECB4E3
      71CBEF459DD8EF8E5A9D30E8F68783CE60D48A235A4E134634F47614B64726A0
      A7B4BB23D30DC7BD6E3434FD5637186C6E04AD76D41F7523634C3F1ED332F44C
      67DC0A680CDDB83BE8193FECF9BD6E6B34EA06DDB035A68533A13F8AC73D5A9B
      F680E646BF06E3CE30EE778CDFEBD0B7F8ED30EA8F435AA978DC1E072D33EA9B
      419FB6A5DDEDFBA3C8745A71A7158CC27627EC06ADCD0D2C763F0EE30159B26D
      FA023308E26E3036A3310D3F8806FDF1200CC288E61B7446661876077D138634
      8C761CB77B8356DCEFC666D4EE46DD30A46104C358CE4A8CD343E7E553E78C76
      83D6C01FD263E58F2D32E8DBFC43A0272D1E76E88C85C36E27A673A53F8F7090
      E2818F9345E31F9A78D40F225AC6F630A2F5A699B5E954D14EC47E7FDCEA75B1
      3DC38836A4DD190DE3C1A8D36907119D0843FFF6E2CD8D90B6B5E50701AD332D
      B789E3A13FEE46B1F1CD2888C7A63DEE19ACCE60ECFB7E6B10764DA747072F0C
      0623D31E0EBA111DCE984EF078D4F77BFEB0D36FD170E8F0B44603FA5EFA8E00
      0738ECB7A2B6DFA5658ABAED76E0F77BA360D06D8DFBED0EED423C1A45E31EDE
      D5F14DAF33E8456DDAE156D4A101F5A3A0DB1B743ABD61EC0FC7ED61BB1F4743
      3A79230CCDD09AD1CDE8C6FDF6802ED6B03BA4A99851EC8FC2711CD3A9A1350A
      C3B1E9C5619B3E1F7742D3EFD1A60CE8CA8C7BBD70402F0D68047E9BEE556CBA
      FD6E10D1991E0DFABE1FF5DA266A05FD804E5C348823D99BCFD9D941301C8F07
      EDC14825C6C8779284FF479283BE81A444BF13CBCF9B1BD5DFF0732FA20718FA
      FF21C9958E952A3499B017B568EF3B902AB4A7C3C86F0F87E3164903DA8C808E
      69AF3FA04B1F06BE09829846D6EB8EC3B6DF6B937CA1151DC774AEE9069AEEA8
      DB1D8626A2734C5726D8DCA0F9D00FB491616BD88A46FEA04F22C78C4638D443
      9237FE90F66D14F9BD513BA48D0A07A1A167B6E98299F170D4A6150F7A23BA68
      51DC1BD3B1ECF6696C242AE80CD2C988827E14755AD120E893A8EA77DA86F622
      8AFA86EE6F8F0E0A893A1AC1B03F3423DA4D12DE74CAE8459A086D68ABD31DFD
      23EBDF33EDB8D78A867CB2F152D0E61D680F1E5A7FF97973A3FCADDBB66B6E42
      9228F108B765D0EE050607A91BB7465144C22D0806A647DF160461D81E0F0CBD
      7F1CD04C7B61AF677AFEC80CE80E0C68CF86031265743B872459694E3D5C954E
      D8A6FF465D7A7B97246214D339A07B42B78CBE9CEE704CCB15D065188CFBDD90
      2E63D4A2CF7649F193400F8751442AA043B2AE43B7AFDD27E96A627AC6986458
      4452250EA3DE683CF4E3286CC5FE78D81FF568CF69D1E8748FC7C38EE98EE90A
      F77DBA8EED60DC1DD0CED20463DCC6A14F57D81F90C26987749ABABD5E7F3CEA
      8D719A3A246D693851D48ABB71301A85C3C170447AA23B0847B4DF6348E8963F
      6847C356D7444187E4F498BEA115FA5D5AA7CE9896AF358ACD98C40D0D860E65
      C798EE603C6CB7E91D035AD6369D83A833E844F437DF0FFBED16E951921524B5
      7AA30EE4D698C4461BD72BE8B4E88892E4A24D21EDD6F2F118BAE9BD90445938
      184686B4DB2068D36A9202311D5221BD1EA9C3D190EE0369711A78773088C6A3
      01A9DD91699118EB9A60D821DD38F2DB9D9619C6DD9E89FA833E1D25139A0EF4
      54A713916A1F91868CE241C727C13BEE0FC398E415A97A529B317D1D9D1788CD
      98C4ED9864A2A18B388EFA642C909AA315A44F8674D4699BA2814FA2C28F31A7
      56B7D7F6E940F8FD6E879CA4C00F63BA36E3E1B0DBF5C902A1F312B77D3AD274
      90C66441D01DEB7682D874B022619F74563C1A40658F7BB4E501FD95D48209E3
      E190F69014572F20C1ECC743325D5A74B1C85CA0D9D04EE0F8847D325DE89693
      8E241532A4951D9385427F2051D8198DC62D03053232FDA11FC5A390EEAF198C
      5BAD31E47B8FF63FECD2C749CED3A1A2A51CF5471DD24E233A4E418F94D1800E
      181DED01ED1709907068E8F2D325EC8D692948E177C8C8890738452408FAADB0
      DF353E6980F66873A3DDA591C4B49DB4B0015DAF91DF879D814D199B71774CAA
      60448F8FFB433A511D5A7112DFA4FB485A8F3AED2109071C6BBA6BED98568916
      6900814FA798C6D0C27E745A83B86F625A399261B4042630A47946B41BBD21A9
      BE7073A31B423D93F225E51FF5E83093FC1A919DE68F077EDC278542638F0D5D
      36DF1FC7744C62BA83245A63FA30A9A01E59867168E8A60CE9B044013E32F647
      6D12B49D3EF4243D348E4C388ADBF425FC5B97EC20FA871417298B3EDD05BA3C
      A477C914A58B403BD3E947211D82882E481B4620AD546B34ECD1BA9304A63147
      2499492FD03927F38E74272D428F746D189239D022A5DEA7B70D024CB4D5EEB5
      61B5D27126D54A32B3455611A96418A4110D8BECAE9884159D835148F650D826
      43939E4D428504E82824413F180523B23802DA6E32B2682C64DE8DE860D3F049
      E1B6FBA425A2A8476B47666F8F4C82B8439787A418C9A81699C663122AFD30F6
      C9081C90F481053732643E8E7C7A50D821C5D4265B2CEC913C18052DB24B8311
      49E72129984ECB272BB743D650D821CD42EF19D067683B49D5D3E8429ABBDFF7
      C93A88C6247A68F33B6483B7696821C9D336C9BD1169CA7E7BDC855EF247A45C
      86BD4E2F82101DD11D2403B64BE72324594D9388BA6392893073494274463E7D
      1709D4211EDC0B3B64B49082A4BFD245F45B63DA0ADA753AF374BA86B44AE32E
      8DAD47F65B774447ADE34388D2A123F946861699BFFD68D4EBFA74E1498B442D
      43EFA43993D0EA90C4220B94D41D99CAA4A8C93E68C77018C87032B8CF7CDC71
      75C892A1FFA7F34E63260541222F226BA03524EB34EA4534CE68D4A19BD91BC7
      BE8161D223E9D4EF93771090AA242B964E46976C44E3439A0D48D8913547829A
      CC3732C3C7ADB6A1E791BB4B778156A8ED935E0E6893C87624E9483F920C2609
      1793002659D6A7E3D0EBD3ADECE1AA916EA03B13193AF1E1200EBB3E6D6340E7
      DC74BA24B262D237743A68D83478BAA55130E8075DBA1B24F28CA10BD3194474
      B562781E3834318DC09816FD467633096791BE24BB49409B3E4D82D421E9AC78
      1C935D44031A86F4EC36099B4E40CFA3BBD3F30743DAB316E9BC3199EB500864
      1492E86A05A6E50FC979E80EDA64BD47E4F9D0B921E145B78D9E1B77DA5DBA00
      ADE1802412ED5D40D29ACEF198D40CED2E5DDB2EDE496F25514403A5270E6272
      81E9EAF8F46DE40AD1FE45BE190F488293EE1D934747E2831CAF989C9F005A9B
      0406195C7401493DD2B9ED07709A86649A8C3B3439B242E9A60C5B3DD2DFA499
      A2604CB60F2D4E972E50AF15C27AA2CB4432962C645223249DC893A11B4F7A89
      843C1DC516990DB4F2F4ED019DD8A84F36118E2A895C1230E465C19B84EB4496
      CC909CCB3159726D92F97E9FE64DF318432305511892651E1A786D64EA90C133
      18B4063EB9DF2D980124B8FB304AC926229D4C3A9404804FBA9DEE7BBF4B267A
      9FEE275D483AFE6415D190C9D018D001ECF55A03B24EFBA477C80B25637B14D1
      C691DF487FED936222314FAA9CD429DD35D2E4F498FFBFBD6B6972DB38C27757
      F93FEC3139A48A981788F2C992AC922B92EC584A72C9054F2D232EB121B98EB7
      52FAEFF97A00821C00034E8F360F9705972413EC1E4CF77CDDF3F58018488D1E
      34A862418E2189CA6E9D8325C142780ACE43F74105E090BC40DF480B69D08043
      A5B81C00895C8F99A0CE319C092605AA065244558934AD0C82B5364DB36E30DF
      A0CCC527CCA7A868E05D784F64320711AFA86E042AC08D4A9B904176E0659489
      C8990A5435A7D8149AA2A75C23900CB881C45061BEA95102616CF0556D105320
      72C84B3AAD644E4912851D2A9C9460936768768D6984D8750A3E0E3822DFA628
      DE53E2181805AA68916A680644F40B14CC39FA845943260AEDD6E01F22435A35
      202B98C0918C417210DE28CE4028D7182BB8386B445AA2F85198979324AB5670
      3A95BA98CED017B2B9D698679152325DC251A01A70F7AA5CA107C82222031DC5
      30275A49854A1E35368608E3024E66CA9C381A6AB20A710EAE07A451758E945F
      614A22BF2B9476A8333229510B1498EF720168A13A419242722F9215080BE678
      8D5454611C8A14A1412B14709942D556117B59212D670D2A238D6C879E21A7E4
      49816A15BC81F2C3AA2805B8921205482066AB2A4D4197919C51F322E360C832
      5AC221B652A4489009E08B9906F38C5D19414502FFA392424508E33096E84843
      86134FC4253181A0AE34D51ADC15D5928234F88D0069C0081885823629E11EE4
      40B06470883445FEC00983B107BD2951A56AE0172519267E8C0BA21CF36B4DDD
      048F431192A45969EDAF0ACC47B4B0051F5434C55540229270896C8E92005902
      88454FCB64857AA75835305C642972B3ACA904241685D9ADAA11C0A01C146BA8
      79418E4C866910D841FC81B115B5469908DA4A8B0EE4EE8CA05D237B63D8503B
      51D0A0EEA914F500388081061303462C6F30162014A03D606948C2707E56E5B9
      6E6AA41E99A3E514F14575355084021F2EC7AC90833319F230C648237114C84B
      294214653CCE21C900C34003ECA74906B004A00CD26C0922050E8CBA11BC0633
      2CF44079302DA107F06168B5B842D2CA5619F5B6ABD28BAED214E972B5785E9D
      C1DC78B57277D76F6C0D4FAC0481818816292D97340619A4C8A9E2019EAAF51A
      42081D2A946A255118528184B238412D52A14CA48A660D7A8554867C506719C8
      6D91A5E08019C81982AAAA919810CB400366230880DB67A831304FADC13AC101
      518863065867552631151470CD1A09C020BFD655020A93A1E0156B45059942E9
      83AB49D0F014412730A1828283A38095AB061C0901850233079B42A5A384C865
      0E1A8FDAADA83079A11041D422B7D1B21CE82E782A506C300098DF318B24E8BE
      464941AB36700378D83A33C027A649D45F1860D055A4125046CA51392D3F9408
      3390B99C225D95A85834E0048483F67423E78C3EE67651D1E39DFC15DFA5E372
      35182CCDBB1E7CAD0FB41AB8B4163877C85527E322F18CB46BD7BCB64E357720
      54C452545CAEA1CC47C2B55E5D5BBD993B30270DBDC228CCF46B6E65E75A4FAE
      6586D99E207C97FC73B9A61B9E336C4FF5EAEC01DDFDD1FDAA5859AEF2D3579F
      BEFE8A6E7694EDB6DD1F4ABAE571D7EF3E84AAB2E95B469EA62BA512A915E845
      4D25C82F28FF04AA6204B021542B7C8BD292BED598EE15AA4EB92609D4FBCAF6
      98FE2EA905F815526946A8475BA0F5E09D39DD59401A40AE4E513E5015034EB1
      EAFA805891F88EEA391400A9C27F2B30AC46D02285EC3D83984771D4A4B64FBD
      9E31E443FA4EF5DF0ACA14A8B304CEA55D9FAD952072125182D2B02179935184
      5A0BA121BB2B83D6C072B249815A75E79429BA73564E0C72629013839C3D87B6
      A9CFF67E50DF8673E62C63D149E7C4446ADA929CC8C8898C9AC8A8898C9EC8E8
      898C99C8182BB386C7C9A345374EA74FF63B8C8429952B313A073960A1C724FD
      4C64773C1C1FB7F5E16FDB4375386EEEF25F646AE8C3B62D3FD65555372BFB55
      7DB7E9EE449ECE743729E9D7E2A733FFE87E407AFA78BFDFB4FBCDF1119FB3EC
      5FE726BB7748DE5C68243797F2AB9BB3ECEAE6ADDD7BF81BAF74E648DFD6DDCF
      1E926FBEFECAED76A775EE74E2EFC07C93E29B276E503E7583EAE98DD64FDD47
      F3D40DA64F6FF4FAA9FB98053578D2DA20C47E0946B0AB15065257270C87AE8E
      8AD0D151168501C6D5492374C206DDD5C9022D3AA143BAF038B62586F9331B08
      1BF18506E4E71B1186868506C2D2CC4203E6F38D0803CD420361085A68809726
      BA89F1E6FB1D6D7DC20CADA66D8FBBF6D8FD029F75D57C07BD7E9B53AE2EA5C3
      7ACF52A18E42252671F4C9373E974BEDB45AE6F61758ACEE776FAD6F9B9B66F3
      E1615F1F9886D4BB9FEB6D7B3F6CFAC8BAF6A0BCAF8F0F7B5EBF077C0C4FDCC4
      82E4DC00CF74FBF047B77F00EBD2F7F44A93083DF0DACF30F8A46D438267E800
      91FCE1784BB8DBD4BC71BECBCB7DCB43659BB3A2E3A4F77A73E05A472A37CF1E
      B6DB9A972AACDE5BFE305A3D1E09B22AA193A0A3C4234156256CA29BF15E8C51
      BD66946DBD6E8489BD6684A5DD78C758DA6B4659DAEB4658DA6B6A7F719AB8B5
      ECFBCD71CB4B2CCFB72D3D64C9B4EBDDE6C32EA77DB4598CC46DE345FF5E6C7A
      40E6C33EBFBFBD79D9EE7841FCACAD1E6FDE7359C2A015476DECC8D04EED9BDD
      03CFD78E660C0A075D5E45E5EA8616F1F3DABCA87BD3BFABEDD59998CDC37804
      AF87E2C846F2BB7CFBD07102A6812FF223EF4A6700BDB45BB1F430FAFC269898
      784B8CE0553FCFF26C3E5F9F77C9B31E0F82E3988BBE6CAFCE4DC4CFE87FF8A9
      E2D5236D64B6D97D6469BD6C6967C5BA72B567812F848BE1236D99D0DB36AFE0
      26FCEFEEEE6FF3C38647E84ECFD7DCBCC9EF598A3FD2B3687C2F7EF7873B7A4F
      E979D2E08DDDABF76F5EDFBC6FEF89C3D29E78BC1124E567F440F45D947E5F04
      FFEEAF75F17BFE85BF0573DE3DDEC518FC6D444566159F6F98E9ACD36AAB08AD
      17C3D6E63126FEB17E2CDA7C5FF1AFFB23AA281B1CC73A42FB5D4E4FDCF2F5E8
      99DE7F2208D9EB0556FB2FF97E43A5586CA17B7828FE5E97BCC87BDB76351547
      E787EE21CA6EDEE72E123BCABC1CEFA8F26697F7DDF6CC1B1AD6C005CF5955C1
      B4D6518EE9F273BBC94BE822EDBC2ECFCBAE2E771A75B579154DAF4B77A9E91D
      3E51269F94A36C3E29471ADD6E1FEE7687D87E5BDDC86E5BDD2878F5BA5CCAEF
      6AF3287FA74B5BAB45B9CA2AC6F8C92AC60DAD558D01B3558C760FEFC6D38562
      E81DC91955DE4DA84EB19F08221563C6326AC5EC4235662C2356CF2E1463C6D2
      2AC68DA5558D194BF9A27FBB785C22BB508F19D70BF5D824BC3BD677F7ED3EDF
      3F465CFFBB6DFD216756EA9DE68FFBB6A1EDC8686FB2187EF1501C2D3589E217
      9D728CC351B5448D33E9312B747A9B40DB17879D959E1B91E76C347B818B5AB3
      AC6FDB2DED6136549CF38B4763CAFBEE3E2F4FB71E4E42C6AD9B5FDBEDC4DEDD
      9EEF510C82C98CE040A207293123656D726D37D2917B53579B87BBD375FBA119
      64D592AC7065F59CEC45A61E048D5770D4623A2778318F0F826BAFA0185B9F79
      45A5D366EA8ECE8B7CFF71EAF3D41D9981CFCD8D622AE665A78DCA79C1019F21
      00429D5FD27A4A32B6DF87A5B34210A83CE2CBD8F2282D83CCA3B480B6B1EDBE
      78FEA9FE797338DDDE9EBF1DAE46E61F2E6E0E2C2CA1B920FBD343DBAF7FCC5F
      C41DC6EF319FEC0EF5855648E078C77B21863C9E5D08268FC6424CCD6BF882CB
      23BD1C653ED39702CE73A185C8F3981E1082222C997BC4AF05E024C18585A088
      09C1F084EFD10800F0C49E00000B3680051BC08205601103E0B1E92100166C00
      0B3680250FC0920760190760190360C906B0640378624F0080251BC0920DE030
      7AE3910E03F0D8F410004B3680251BC08A0760C503B08A03B08A01B0620358B1
      013CB12700C08A0D60C506B0620158C500786C7A0880151BC08A0D60CD03B0E6
      0158C70158C70058B301ACD9009ED8130060CD06B0660358B300AC63003C363D
      04C09A0D60CD06B0E101D8F0006CE2006C62006CD800366C004FEC0900B06103
      D8B0016C58003631001E9B1E0260C306B05958BA73FDD0AF743A3F6A99AFF95D
      FB4E55FCA0B8F0031A99CC5DF227E757D9F38A62F69A219AAE939EB5ED47C62F
      3587565C5C3EDB14DB4D6BD7461E3FE709B5F1EAEC0FCF879F945D8AA9C9EA2C
      FD12C82EE5BA45BA125E41B71852D22BE8924EA5BC82630AA1B457D44DA3CA0D
      270BD7D3AD15243C57D6F8649339E9D4273D327FED931B599FF9E4C6C66BAF4D
      DAE60BA7599DF884CD10C5AE82F029A4F30A57DD36BFC8B3E03FDFDAD3822B3D
      D7F0FB745EE19A6B3D5A013EF6D914E26E8F71A17E175CBF0703D8B7C612E077
      11E57711ED77C106B9D7B850BF4BAEDF25D7EFC119C4B79610EA7719ED7719ED
      771987F6C95471DDEF8AEB77C5F5BB8A42FB24F133FCAEA2FDAEE2FCAEB9681F
      5755017ED75CBFEB28BFEB68B48F6DE2F85DC7F9DD70FD6EB8681F570F017E37
      517E37D17E37D1689F18E7FADD5644C124F0427A710EBD905B4CE117728B19E4
      42AEA7808B89E3423C8C045E288491C0A9DB8248E0A5FF3C0A7E477A59A3DFA7
      412470E2DC201238EB638F6680B3BDC685FA7D9104CEF93D18C01E85EB5E1F13
      AB50BF2F92C045BF2F92C045BF8B38B48FF95680DF1749E09CDF833388879205
      7A7D421D197E5F24818B7E5F24817EBF2B2EDA27ACF1BADF1749E09CDF7929DC
      A3C5F0FA843E32FCBE4802FD7E5F2481737ED75CB44F58E375BF2F9240AFDF17
      49E0A2DF7534DA27C685FA7D9104CEF97D9104CEF9DD70D13E2656A17E5F2481
      8B7E5F24818B7EE7FDAAFB0D54F84FC2BDBBA37792C53D68FA2A3FDC1E73DE1E
      1B7FDEEDEB43BBA5B71D9E3ACCEFEE6BEAE927FB8E2D7ABDD6E148AF875C2576
      974A7ACB92E8F7CFECF7D654F4A21EBB97A314A2D652257AADD7AA52A5A6FD2E
      13A3BA5D30A5A11D29670FD3B55CADCA2649EA559E144992D7897F5FCEEE90F4
      E60934D9D44D63F7E9F4ED299A8CFE1D7D41FACDB05FECF4F370FE3F78D03EE8
      BFDDE38BF5BFDD63C6FAAAFFB7FEEFF6E47F717C19FBDFEEF1C5FAE543836998
      A6FB93AA95251E0A2CC4D4DDE71427D2EC1A4B883FEC1EE5DA3FEFAF4A9357D9
      7A9D8926A9E8B52246A3A76A95192974526B5FBB202B297854461B30AFAACAAC
      121FE3F87F39BC1E883C60FDAFEC784A0FFCFAACA7E3A93C10617D5F7B9C8E4F
      9FFE0D4652E259}
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
