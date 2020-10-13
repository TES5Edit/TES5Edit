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
      789CECBD7B53E348B62FFA3F117C070573EE699801CA92DFBDCFCC098A4777DD
      A9D71454F73EB7DD7142B6D3B60659724B32E0E9E8EF7ED723339532165014D8
      A83A67EF2E8C91525A2B57AEFCE57AFEDE4BB291DBF3876214FAD1D8AD79CD9E
      1FA501FD33988D5DAFE9F5E603BE6254779BB5760F3FD57A69964E46C3FE6082
      5FB6F8D7302EFC3A090ABFF6037D3F3EAB5EEBB8EAF348D06FD9444C85FE9BFE
      6D246AF92F83B4F67B6F144759D60FE143AD07E30E03A7374AE2A91FF5468389
      9FA42283EF67C96FDEEFBDBFF6667E14A7C2A979F07FAD5ABDD6AC35E03F0F3E
      35FEB808A62275DE8B6BE713DEFE5F7FC0909E1E721A0F45B23CA65B1CB30DE3
      74696C1CB301631EC7F32410098EFA5F7F6C6FC188F59297F46EBF6413FE0F66
      01FE6BC3CBE2A0ED3FCE17D37E1CD2BBB939BD5110DE3DD0ADFFFDF173108D87
      F05F4A63D51B5FC23BE419F30E79E8219DFEB49F04BEF3CECF268AD0B61E32BD
      0ED2F4EE2147C4328F06574386018C49AFD7A87FD13CF4E1BDBAC5C1E2288D43
      9F8975BDFA97BC5A5FCE26FF07B2F2C7B918C7C2F9FC46521A02C7FE1D273D5A
      13CF2084C3BE31BEFBC4E3130593C07882F765F3565F3D6FCEDB603CC9E8FDFB
      E6E865F2FF55EF0F331044EA095F24CA0F9E817CFCE633CD40FE84D6D3AD9CBE
      396EFB191464A753A6D0EA1D1ED659BACF393E95447B9D6ED9CD388BAB6F5E24
      FCE06ED94A705B6EC9BD3F24425CCABBBDD2BBBD92BB2FE6EAC96532ECB6DB25
      F7EEFE28FA89B8DE538477CB84D46D97716DF728F1FBC1604FBE439914BA9D56
      C900AFFD300B06F2F65629F9F5B2E7FF14882CF2E14BC1EF001B7399565673EF
      3AC60698CF3BEC92A577CA895FBA534E7ADD75CB6E54B35EBC319FF1BA5BBA97
      AB292FDEAAA6BBEE966E3E6ABE8B372ECD75DD6D94DFBF8A4D858986655B7AB7
      9CE9E2DDC62CD7DD5639C9F5554F5E9EE29677FFEA36B7FE7C8A5BDEFD4BBB78
      A79CE256FDFE755DB8319FE256FDFE455DB8554D71AB7EFF6A2ADCA898CCA4D6
      EF5F4C85BB6FB3B9D929D1F8269B795B450ED32DDDB25B0CFECA5B146B5B6EC9
      3D266BF91EC95526B05506094CBEF27D9AA5AD328C952B49754FBE60E8C646E9
      8DCBBC28AC9456AB5976A331897C6371FE5A65FBAD397FF289CB53D7761FA404
      197DAAC96BBB0FD27FEA26397D6DEF41CA4FDE654E60DB7B90EE9377AA296C7B
      0F523DF22E43EFB4BD07E91D79E32D96BA4DF7FEE5A02078AE71E0B6FB97447E
      9B64AADBF4EE5F14FAAE5CD7C07DF72F0A7D9F6229DC75FFB2D0772D6D2470F3
      FD4B23BFD95C1B70EBFD8B43DF6A4C25DC78FFE2C89FB93C958593D15700C5C2
      388FC78CE630EED7C0C7C2408F4492B70873BF06562E8FF595F8B230D6E3A1E6
      6D1A9F00779AC761F77142B53CCA23458AC83307F2BE46A80A033DFE785218E6
      AB4F2A85D1BE52A80A637DD5F9A530D2D78AD42D0B88F7703446460E25528531
      1E0ECFE41852479983D41F8ED7781073D32F0CF47000C70329612A0CF27044C7
      8314B45361A487433C399216A3DBA43D1CF5F158861815C679380894EFB4AC97
      4C3357FD2B36BBC2388FDFECCC611A5FA3970A037DCD665718E82B37BBC2585F
      A9970A637DE5665718EB09363BD3B2D978F4665718E56B363B73A0E65722A87C
      A0C76F768561BE7AB32B8CF6F5082A1FEBAB36BBC2484FB2D999E6ECE6D720A8
      7C94C7EB297398D6A345EA165DADC70B556198AFD45385B1BE46A46E13F8B508
      2A1FE909F494E9BF687D9935EB96FFA3F5E5A62DF3F6F6175BB99607F84273D7
      2D02DA8FB47D15C678A419AC30C6232D628531BEC238663A9FDA8FD6338551BE
      66F33207EA7C2522CA077ABC9E290CF3D59B5761B4AF4744F9585FA5670A237D
      AD9E214207711827593FFCAF5E2286B5DE186625AAF5FAE15CD46E7FE5359BE6
      97F0EB5D5FF300F8DB8A2196BE5EBAB664889207F210AED731BF845FEFFABAF6
      5FDB5BF835FEBE6290A5AF6BC52FF341567EAD07E97AF20FF081FED0F51EC4E7
      1A4EF65F318467309939DA8B9D7A5E4FC7F070F88E5B8373247F8C66F88BA3EE
      9CF9330748FC2D747A6150EB25F05FEABB2DF837F4005FA4E1741E666EEF3A18
      0EB270E627BDEBC49FC17D3E7CDDF3D3991FCE263E7E88E6D3DEC8F7E759DCF3
      87FF9EA75982073618105E36C47F82CC9FD59C3F7A51FC1B885D3C8D33E1FCDE
      4BB34528D28910D9EFEB7B895E92858309AC84D445E27DE9A7F78975BE8AC382
      97C912BEAC763F7707E32418D217D1CCF89B64772F8DC44D06C3A4BF8DE264EA
      67F06996047112648B9AF31EBFC2F8227899D42DF2A1EFD6881BF86F1F2973E1
      37FEF945FC88E719704084E24A84B50773A7E7F7812D35640D1C844A58D3EFD1
      5F97B8421F2F451205F075AB9C3FF80BCE0250978A611CD524B3E0E129BCD5A5
      DB5CC9B5AE83B293A4C1D06BD55B5EA7E14C848FB1558E8BCB22F59E9F8DEE63
      D808ACC8D908642F3312FEBE8A9177B3EF16F33CC5BCD61732CF9352587F7EF6
      798F619FD7BE4B0AE1AF5FCEBC15B25757EC6B7F21FBEAAC92E1A561287F380C
      B2E04AC0D5A998069360381411FC328FE0A398C3138D315DE78459E77CF4137F
      0CAC9C38677144C15C7F8557CC52D7857F92F87AD8CB925196FE1C0CB3C9EB3A
      FC328307856EAD233F26F9C751A8FE3ECAF4A7BEFE94E0A7417FE68372850F23
      FED007CA61A3E19FD96226E0AAF44A2419000CF8D44F8689FA19CA9F7DF93391
      3F87E3507F52DF4DE4CF2BE73E450FD43E8BAA5F9FA277DD3BE69CB5BD73E1F7
      43A1C5A569880B428E12157C4BE46BB9EEADAD56BCAB1505CA278B38FE8C0797
      0561BC2DE03F2AE5EA1C037CD4AFDD32A5BC4CE1155E1A8893AF2DDFADF0DAF7
      BCACF7652FEB155FB67DFFCB7AED951C967AA5FC550D1DA25FB6FE652F5BD72F
      9BBA9DE7D1BE5FB050981B8D924502E4D25F9F60A7723B0528B4CC9D691A470A
      1DF12C764B6771542B4EDE3CEC0D46DE9218956BE2A56901C597E034AA077BB5
      3B96E8CA47BB8F7DF6591C86F1B518DE7E07B79C788F666CE93D30969EBE7C1C
      0F2EDEBD758EE3A190A0C07B2650F56472F958A95C01013CEF0B182555FAEECF
      A2BFC7E8B3889F34377023BFE9BA2DF8D7EDD43DF8E1B5417D6737750CC1CA6E
      1ACD0EECBC37CD46172F69355CBCA45DF7F0928ED768F0DD780930BD4DC3D4BA
      5DBCC875BBB8EDDFC0A9D2C3CBDC7ABB41D7355ACDD6134F8214B53B94038BDD
      93205985C5BCC6974AEEC7443074CBC450AFA0C6E356D023F4BF57D8000A6F7E
      CFCB16B62DAF59FAC6C16DC5132C2DF5DBE0D5BBAD644FA7200E6990EA47966F
      EB4BCF5BA6BB5C91CFC2835C8D95EFC4CBF43C7CF4811EBD73F73EBFB4C3DFCF
      30EFD6E3CEB3248EC6D236F65758296996219CFB9D3EF2EF623A0BFD4C04C316
      A64778ED96C77FA5B34F8FFE8D46035014EA63A43EFF7B50531F22F969443B82
      FC25CD7C00E300D5F9B7993F10F22F00D84594D57EE7DF32583EBDEF6A6E6F7E
      50EFBA75E77F2387F869F3695F2430DF941A85E23DEA077E5AEB4D1201FF0E26
      F413843F38A8B75013B4BD1A4CF5BF079252544A1E6908F881B6A4A726EC0A5E
      3E828F30850FA5325E459DF720EADC06A84A9338FA029E833F1D9AE41740204D
      A3D75D3D8D6EED41947AB8799894D217F040FC59369168A5A81EA59DCE12A5F8
      05520A3FBF486415F92F9552F8B748297D010FC49F4FB1381503364E69A3EE15
      29A52FE081F8F3E9D510D2BD214A3103AC40297D010FC49FCFAC70F574AF87D2
      F69246A22F90D276B9467A067DA4A87E3E4A5B8D258D445FC003F1A7A214DD6E
      0E0C8A9F016F345AED7AADE1FEB11258B8A0B3DD7AB3D9683CC71A5F27B6D83C
      B2B87BFA9F0F5B6C1C5900E19BC416D5A4F4C9B0C54BA7F4D9B1C58BA174CDD8
      6283946E125BAC99D217822D9E9FD2C7600BF853ABDD6AADC616079DBAD7C1D4
      A127C016E5C8E201A0EB1BC016774FFF378C2DEE916E34147F23D8E209297DE1
      D8E2E9287DE9D8E2E9287DE9D8E2E9287DE9D8E209297DE1D8E2E9287D04B6A8
      77E0D676A759822DBC5AB3EB366ADD566D132E1103757DC3E0A2045A18CE590B
      2E2CB8B0E0A2F2945A7061C14575297D04B8E8788D66A3E3754AC045ABEED6DA
      75D067165B586CB171F9B6D8C2628BEA526AB185C516D5A5F411D8C2755B8D66
      B7EE764BC00556CBC032019E45174F1DA56A0185051416505840F18D506A0185
      051408283C4CC06AB74A42380F5C4CEEEA761A4F11C369018505141650584061
      0185051495A6D4028A3B0045BBDE70BBDD7639A0A8D56AED5AB3692D14D6FFB1
      7909B7E8C2A28BEA526AD1854517D5A5F431E8A2DB69765A9D72FF47A785F8C3
      9A2B2CBA7809126ED1854517D5A5D4A20B8B2EAA4BE9A3CA5934DC6EADDB6AAF
      4617CD7AADD6A9D73A1B299465B185C516165B586CF18D506AB185C516D5A5F4
      31D8A2DD711B5EA75E562BABEBB59BCD16BC9B0517165C6C5CC02DB8B0E0A2BA
      945A7061C14575297D0CB8E8D66B5EB359AB97808BBAE7BA35B7D66C597061C1
      C5C605DC820B0B2EAA4BA90517165C5497D247818BA6DBA8359A255E9146CD75
      3D8016165B586CB179F9B6D8C2628BEA526AB185C516D5A5F411D8A2E175BD5A
      ABDB6C94C4737AB5865BF3BAEDB6758B5874B17909B7E8C2A28BEA526AD18545
      17D5A5F431E8A2D5AC776B1DB7ACCE3728EDAED7ACD73C9B2D628B5B58406101
      8505141650584061014519A0687A0DB7DDE9D64AD24FBD6617C4C1B50922D658
      F102E4DB620B8B2DAA4BA9C516165B5497D2C7B40D41E8E0D6BD126385DBF6BA
      9D6EDBEBD8380B0B2E362FE0165C5870515D4A2DB8B0E0A2BA943EAA2759B389
      7D43CAB24F3BB0AF7BAD5AD73A422CB8D8BC805B7061C1457529B5E0C2828BEA
      52FA0870D1753B8D46ABD9280BE2746BDD4EAD53F73A165C5870B17101B7E0C2
      828BEA526AC1850517D5A5F431E0A25EEF3441B8BD12CB85E7B96DAFD16AD998
      0B0B2E362FE0165C5870515D4A2DB8B0E0A2BA943E065C34DC56C3733BB5B298
      8B8EDBEAD6DBB65599C5169B976F8B2D2CB6A82EA5165B586C515D4A1F852D5A
      1DB7DD6897182E0EE0CFB57AD36D59AF8805179B17700B2E2CB8A82EA5165C58
      70515D4A1F032E105BD44BBD2207CD76BD596FDB684E0B2D362FDE165A586851
      5D4A2DB4B0D0A2BA943E065A74EAED5AB3DB2DA971E1BAAED76D74BB9ECD43B5
      E062F3026EC1850517D5A5D4820B0B2EAA4BE923C0855B6B77BD66ADD32E4944
      AD371A2DECB16EC18505179B17700B2E2CB8A82EA5165C5870515D4A1F052E3A
      F56EB7566F947845DA6EBDD669355C0B2E2CB8D8BC805B7061C1457529B5E0C2
      828BEA52FA3870D169B7EBF54E895FE4A0DB6E79DD66D3268B5874F10224DCA2
      0B8B2EAA4BA94517165D5497D247A28B4EA7D9EAD44BD045BDE5B59A2E48BF45
      17165D6C5CC22DBAB0E8A2BA945A7461D14575297D0CBA709B6DAFD96D74CBD0
      85DB6D76EB1DD8DCAD6BC4C28BCD8BB88517165E5497520B2F2CBCA82EA58F82
      17ED5AA3DE6935CB0B80773A4DAFD16D5B7861E1C5E645DCC20B0B2FAA4BA985
      17165E5497D247C18B6EDBABD7EB6E59E485576BD5BBF556BD65EB5D5878B179
      11B7F0C2C28BEA526AE1858517D5A5F431F0C26B74DD6EAB5D6F973A471AAD56
      ABDE69DA4A9D165E6C5EC42DBCB0F0A2BA945A7861E14575297D14BC68D66A00
      1E9A25D68B46BBD6680300B1B60B0B2E362FE0165C5870515D4A2DB8B0E0A2BA
      943E0A5C741A9D46C36DB5CA6C17AD96DBF1BACD86B55D5878B17911B7F0C2C2
      8BEA526AE1858517D5A5F431F0A25EAFB9F546BB5ED666C4851DD8EDC0DF6D60
      A785179B17710B2F2CBCA82EA5165E5878515D4A1F032F1AB54EB3EE96B61AE9
      763AAD2E067F5A7061C1C5C605DC820B0B2EAA4BA90517165C5497D247810BD7
      AB77DAED5A59D688DB697ACD46ADE5DAC80B0B2F362FE2165E5878515D4A2DBC
      B0F0A2BA943E0E5E349B9DF29A1718F1D969D6ACE9C2628BCDCBB7C516165B54
      97528B2D2CB6A82EA58FC2165ECB6D344BB145ABDBF2DAAD4ED7820B0B2E362F
      E0165C5870515D4A2DB8B0E0A2BA943E0A5C745ACD4EADED96A48CB84DAFD3ED
      7A8DDACA4E23B59C4DB52FE5D203B18507FFD50E97D9823C031A922C1C4C7AA3
      41EA3A3D7F04AC08B384BF80CF4F8534BE86C82F14054DB1FBA4143F027D6C82
      68EF49897E0410D904D1F5A725FACB31C926886E3C29D18F80279B20BAF9A444
      3F02A96C82E8D69312FD08D0B209A2DB4F4BF497E3974D10DD7952A21F03659A
      35AFDEE87A5E79F66BBBD5EED661D3FB7ACC07647F319EA9A4A5A484ACEDADFB
      CD23DF8A71C4B071AD86E8DF8C71E409297DE1C691A7A3F4A51B479E8ED2976E
      1C793A4A5FBA71E409297DE1C691A7A3F45188C2C3A8D07A39A2A8D56A0DD76B
      3C7D27138D2FBE3D44F11009B0F0C2C20B0B2F2CBCB0F0A2E2945A787107BC68
      B9F5BA576FB4CBEA69D4DD4EA3D3AE5B7461D1C50B90708B2E2CBAA82EA5165D
      5874515D4A1F852EDA9D66BDDBAA974576B85DAFE3D63ADD27AF056AD1854517
      165D587461D185451755A6D4A28B3BD045A7E936DC5AD72B494A716B5EA7D968
      B8D67661D1C50B90708B2E2CBAA82EA5165D5874515D4A1F872E9A6EB7DE2DF3
      8CB8CD5AD36BD56B9D955929165D587461D1854517165D587461D18545172BD0
      45BBDBAA7B9DB2B04EAFD6713B6EBD6BE18585172F40C42DBCB0F0A2BA945A78
      61E14575297D14BC68B53AAD66BD560A2FEAED96DBEC3E7D13568B2E2CBAB0E8
      C2A20B8B2E2CBAA832A5165DDC852EDA35AFEBB9ED92C08B838EE77A2DB76B4D
      17165C6C5EC02DB8B0E0A2BA945A7061C14575297D14B8E8B4DA5DCFEB344BE2
      2EBAB5AEDBED749FBEC1BB4517165D587461D1854517165D5499528B2EEE4217
      DD56BB5D73CB72463C6ED2DA7AFA0EEF165D587461D1854517165D587451654A
      2DBAB8035D74DB4DB7DE6D974675BACD4EBB43719F165E5878B17111B7F0C2C2
      8BEA526AE1858517D5A5F471F0A25D6FBB9DD20EEF5EFD194A69996C5128E34F
      842C6E4DFE378C2CEE916DDB82B582C8E2E9287DE9C8E2E9287DE9C8E2E9287D
      E9C8E209297DE1C8E2E9287D14B2E8B46AAEDBA8BB65868B4EC3F5BACF504AEB
      0B41D7378C2E4AB0856DF06ED1854517DF12A5165D5874515D4A1F812EBC5AAB
      DB6D766B6565C00F1A0DAFDE743BF567B55D587461D1854517165D5874F18D50
      6AD1854517882E5CAF5BEBB45DCFFD03FEFE57FA36BE1249120C058C118ADF0B
      5FDDC22485BF0EE23990D60B53650859BEADDB741BB546B3BDFA2EEF0F0A44B8
      7D5FC76B341B1DAFB3FAB6FAEA8775408E5DB7EE3557DFD5587D57EE255A7D5B
      B3E436B75D6BD43BADB2DB5AAB6FEBBA9D46036E6AA06B68D57DED1246361A98
      C9D32A6164A7E4256BEDAED7C4D95E7D5BB7E4361DF55B32D9B592FB7477BC92
      FBDCB2F976DD56A3D9ADBBDD921BBD32AEB4DAF55AA3843AB7444EDC660D5EB2
      EB7965B25C2629ED3A4C42B78C996E99A4E828A7B239774B8425AF7A57725F89
      B0C02CD45C98867AD93C94888B075AA3D56E953DAD545A547A7BC922AF95CE7A
      C36D363BE56BC82BD12A4DAFE1B63BB01C4A6E2B9116B7D681FF355B9D7AC97D
      65F2A253EC4AEE2B939746ADD30499EE76CB26DE2B11996EAB03C256F74AE6CF
      2B9317DD3FAAE4BE3279A1207E58F1650C2D91976EBD0E6AB3FC35BBE5EABDD9
      C4E55EB292EA65FA0526109475BD53F29EF5B25DA8DD711B5EA75EF6B81279E9
      76EAED5A13A6AFE4B63271E9769A1D98C0D259AF97C98B2EA15D725F89B4E43B
      7AC97D65E2029AC9ABD74BB56EBD6C2FEAD66B3081B5926554EF94AE775D66AB
      E4CE120DD36DE07A28DD561A65E2A21B9E94DC57222EB03FD781A16E198E2853
      2F9E0B77B65B6ED9BC37CA04C66B745DD871EB259B7BA34C5E74AFFB92FBCA36
      A45AA7DE0528D728E36789BC3440CB030C2CD3D68D76E9BC7B9D06C01EB76C67
      6994C117D88E9A9D5ADB2DBBAF545E004E782E21E15588AE4C5EDC66DB6B761B
      DD12C16E96C88B0B10AB069AB059BAE29B6522A3FD8825F795484CBD03F0BF5D
      B61F354BF723AFE5369AA5DB6DB3C92782445C65FDD0F9FD737419C5D7D17FF1
      B7B3F18CBEC50FBD00FEF17A41E6CF90C7B55E02FFA57DF8CF47DEAA2B30FE69
      F535FC9C3418E290F4C1835D0BC4843E83A0B4B111115C359DFAD9E463C23FCF
      E228AB377AD37E72F93A802399FC703E8751A7E9D40FC3B3C48743DB7418A4B3
      1331727BD3F09D9F8CE9DA447F1A8AD1FF3B80BF5D27FEEC0D1DCEC836370DA2
      EC6D30850F919F2CE0134E77108DE2DF7BFE3C9BC4897301FFA470D2734EA371
      2812F8733C13899FADF813AE844122E04838ED2D12AF0647B9690C87BAE1C26D
      C069CEC5A7114E4166DF750DAE6198A83488237C1F31842FE90014C5A3993F16
      69B3CBBF5CC7C91030689B1A30C0EF83899FA41D58E7E6EFD780DD9B8D568307
      8DBA3C1137D3304A7972E9A3EB4CB26CF6FDAB57E96022A67E7A380D06499CC6
      A3EC70104F5FC5A3513010AFF081AF3C907CFA340DFFC083EBCC078E5CC3CE02
      3A9E3E4F5CC05B9DDE14981F329BE153A23F65FA539F3E8DE759261210982C49
      C5207360C8EB60185F0FB224EC8DB2A8FFEF9E2FA2E1301EF43298EBCB294831
      9C8CE9F3284E404AB2201ABBBD611CC5998003F5305DA423901B17381D2EE2E8
      6A1AD68CBFC251793CF4331F9E9C8C6054388847190C78E587017C2F801F6E2F
      9DC4D7B3104EF493381CE201BED60BC6519C886970238603181D0FF820D85722
      88E8CE1B7C0ADE061F6095816CB830073721BC5EBC101150256E66E924C922F8
      7A0EC486E96CD01B46300951DA1FF6E15B3221004973A01B084B273E2C6490B2
      FF20EDC3F194A4193E4CE8425476C3F195F1192E0DC66C6EC6BF147E9BE0ABB9
      74037E80D7F937BC8F1F0D7B5781B8BE0CA2A14B9FD2811F0AB7568315DD4F86
      C944F843F97114C7592F9D858BEC3A0A228153A33F4FB2292C9874064484D124
      F387FF06B27AF3548459DF0FA31EFC075FC0437A700B3C6100BF5DD32FF021C9
      C6492F8C606503E50286804FD709AA9E5E1AF9B32C1E83CE0AA281084318288C
      AF478108610D0F61F81E5C389B4703F451F869E0EB5150A924F0C64AC944E21A
      064CB305FC3585678C93F81A5E391E0519BE6784FCCE16C076D493F07778D708
      944D96F64602DF4D84E20ABE1EDCA4333299809A18C2145EE3F702A7D41F0D60
      45E14BFB23BA780E6219F6267405F22D03F5E827706536B8F2895519BC2CDE34
      4A901FF8C5959FDDF46F7A9749344BD24864BD810FEB11E42D04363A2838012C
      C7999F39F05A9CD3F1D7DE35C8F1689A8D8210D691E33560B3C3D50F9A689E88
      6C92C4590653DA0BC2513CF5077E3608A3F9ACD9C405072FE4F470D50D1DB5FE
      407147E2A6D6C39917C9A25DEBF470E6E5477893F4063F00FBA3894804DD8DB7
      E024A1858A4613231F447C0013480BD8A1DD24823F8557B0B866D17C904CF10B
      34A7E1EF6C304377D02C9AF8D118F79C28BBC97CE7506E45F2660F150EDC0E2F
      FBA8FBEBF009F6BF47DDDB804FE1C39FBC57BCBBF9F027F79DDD3FCA86691103
      1EFC1A770DD5A6811E3611778DD379AA17EA3EE48550E6578E049B4F02BA2AF4
      83C891B2DDFB0D164D0E4450ADA53EFDDBC7B50F6ADEE79FB0E18014E31D8810
      A4F8824299F9E16CE2E387683EED8DE8EA5E3C2781270B6EAD07BA6E9E66A06A
      27193C2622536C4D622018D037900EC09E2C1C4C7AA301ECB7A026EA6EB3D686
      9F291CA7FD108873E19045EFCE17D5702FA4AB5A3DBA08AFA9C331853E8C404D
      D7EBBD012E3CFA229A197F8B66F857E07AE1917D785A0D9FD8E8149ED3EBF746
      AE874EDC46A707A44F961F451F2F013FC0E689B606F90CFA1AD08909E7107598
      44FF3CF1B3EF520714B0033373733A0C32A771583B6CFC6F020F89C333B7BE39
      73BF68CECA38586F2DCF94E62130A894875FC2B9D7F3F108E0462AF9C4089FBC
      09B9A86B2D5E14AD5A717A957FFE6BDFA817C63026486E6FD8A70FB04F04F894
      BAD3FBAEDFEEC1D6F8C78AE92C04003C785E11A32C050B3C60A6C374F5FCE2ED
      0F9A619E5EAFB1C4419E5A342C7C250FB7B7FED2EE7ACE81731606B399183AA8
      E260967175E02926F4174E3C72FAC0EACBD40184E6A4F3FE01FF5A2D49004A3B
      B53A50EA8F10990C42E1A3FED877D2782A4821C031221C12824D9D51124F9D93
      B7C7A933050E001872C2D81F3AD944048983A130314CDBC249E0F40AC71E07FE
      4D107A2CAAC593BF743CE4C8D987FAF7CE513400C80E27BA43914E9DFFE97C8C
      F13C1AC797A0ADE8AB488078C021F6D279170F0380BD43C79FCD42FC399C8360
      8F9D7F1D1D6F6F558D03B0F91C389FE43C5E07D9C4816100E40E81AE3300E26F
      4E52074F298ECFDB869A72787806A8145787B264A4AF82E8DF200662583D3634
      4910DEFF04FFAAA5E10C91BE691C8905AC8214578D48FC54E09A98396301EB26
      4B2A27F1CD26907854D001CE301C44F34B9F1400CAFABE13C01A2725F81EBE3F
      B888AF23203AB914997305B7A493AA51DDE275DEF8DE39E11DEB431F25D5A1A3
      BDB37B72F6E1F51E8AF93C1C6A7176AE02DF418414276F4EAA4670DB05823FCF
      D086922295CE39C6470C9CE3380C81F0208E52E71760C8AFD5226C7B6B3711B0
      F9808E71E2C8390952D4467B402BC86DE8C0EB8B2825E28671F45DE6F8E1B5BF
      20060C046D6128EEA0C94ECFDFE69B96733D1111EE6DB0D887F35038414A5B1E
      5E340AFDF11815DA46D0F1979D681E78BE30D1F1FA4E18757BC2B0278CE73861
      782FFB84F19756A38B080BDFCE99F99170A46DB03F1F576BA6FFD26A368012DA
      359CE389185CD2C6720A338716F6EF1DD6CCA943167756AA3E7C39067DECBC72
      62DE7191548098A9737EFCE1AD232298B7AA893C1CA55A4D9CD49F9144B20113
      FE97D078DF21513C00611E5CE2F759EC9C9279DF390A436796C02683672CDF21
      D7C54D36F743672AA2396C413EF2261AA7B41B19378DD0AC0E7CF4C320AB1AE4
      6CB59057C7A76FDF3A405E6DBF4667CABE70D2199C9BE2790A3BB03FC4F30630
      CA3C84CA639582A98755A3BB5DD3CBE5C49FC2D112081F030613A311AC043846
      0469E8F7050032322BB0F8548E48D4096FD8EDE6BCB97897AAD9D5380D600068
      60E10CE8EC446A0161B723DDAA30CF013024A91CE12D20FC87499C228DA7E71F
      D93CF42E1E8E93783EAB984A0372D00E7034807597FE14C4A18FDA06262B0038
      3C1611BAD9692DC6D108D45AE6A4709C98A7C5B9AD1AC95D97D6E7F6D687C6AB
      B30FED16EC6AF16C816492B242BF3410084AC9C73D1B89046DEFCF533849C054
      A7037F06DFC1792A403146E545527F2022F4490E59D201FDF2B1124E2395E30F
      2E6D8C41C04311A828FF4AB061903FF9413887A9C79352223010808E64A0C852
      F1DB1C3676F848E25441C1401BC9C56216A37CFF2CFCD93F4EDE1FBDFBC75114
      4C795DC0DFC4F7CE6B9F027B06CEC13FF033FF52355A3B68FDBE00B431F3B389
      D387B71BA001841108E8E96B44F7A8D9FA3E00BEFE3CCB50650723FAFB75100D
      E36B3C2F6771EC500850E54C7FAD2E2AF293780E8BD6798B73080A201E393B27
      02238860B59FFE360F66CE4530153B4A20400640D33BA7B493578EE036E2313F
      C2958B26EC052CF22498012299A7A4FD421F57EDBE73BE483F6741889FB2843E
      3900EC7FA649878BA320ABDAD26ED7709BDB394648298DBAE98E46D7CE301629
      9A8D589F3920CEEA2284AEA32081B30BE8FFAA11ED22D13E2963E7CAD8DC617F
      C2902AB6758722AB1C611E22ECEB24C6159B0CE1508D07D233D0D5A4B1DEE207
      58B0EF3E9F5F548E3257AAE57717EFDF39146485A47C3A3A3E95E74CD4BAD749
      9061D423F96DE65124708AD13107223B0D22C66C35A7BFC0A9AD1C0BF0D8F8F6
      C3C90F78C886E58A8083294D049C1744846744796486C5FAFE33603698FE7994
      88340EAF1084C1B60CFA5BBAB1AAC7813AEECDEFC5B573FC4F0734D615D04B04
      4901402A0074A1CCF3F21D3A9F4ECF3E81BA969E0C54F07DC19E9B219ABDC932
      53413EA0F76680869180828E2434993A01F91F4136A4CF6608A22299A354F99C
      7C208456C220020423B26B01977140A61F92A6D02E9F7904BB1C0C41214F9563
      13E275B23D392912C3E8ECBB54B144FB69A57364140FE008073BC1609EC07242
      4F482A4272E0A227A472E423AC399AF683F13CC816A82DCF2F1749300506FC0B
      76005823A300200B6C7D55A3AC514ED9C723D00D15A60C91C9B15AD94772C35E
      A20E5632A93263291FE39533388BCE2AB64A31E0A889A845EB2FB928815AF88D
      941C59C9D0E080946A3D85DB1F195CD0D682D772C23ADCC73791F91454A1B891
      6798A0622BB8CCB3ABC3144E127F1C47FD38892820674010FE1236F9D84F5042
      A2037F3C06DD9D06571543B2E56EED41E2A7130AC438FAE99D745427818F592E
      8E188EC9572D7DD4B4C1E357B8CFEDE3519D0488C5C449B33861632C7E49D731
      AA04367E87E15DF1252C30C777D8928B9EF404C58E9E8B9110E491C0DBDEC2F0
      00BC105F558BCB653CFE49248B7FCD83C1E5F924BE3E96164EB663A320619C9B
      8FD92BA48428166A20920C439B9539B462C7E07271FB51C77EED326A76FE97D3
      A9D5F674D8972F2D7EA072866814CC8328801D1C3E214139630C82E6283A63AC
      8221C3A87C747EF1E76A31AE8C6DFE90034B28EC410691709C25D08F7F998904
      153E2E5267E7983C86C2B98877B6B79CD93C63639B792F2F5D3ED952E4251D6F
      BF0D6619EEE181B4B747818EB1A5035E7A1944A8F2AB4570F9B21AB275913CC2
      F8A720CAC41817029C3D4630BF9903B87B8AA96F39DA214513440794F9060A1B
      E3D0A4DD7541CB10DE1851BE8F86B8AA21BF158CDADE2256811A0144B430DC4A
      FBE8292788E34CE970C31E87741E666A3B23F74C5FA028E5875DB9F4E611BA2B
      34B4AA169FEE00060A3423FD5257E359581DF67256C91838033DE797E36F3BC7
      003687099E89473B0E792FC9A6405ABC8A4EE93296BD63E5CA675CB4804E83B4
      2F2664574182D5F6452A08FE96B23C91FDB76A4693321EFC72717ADE7C757E7E
      FAABF3FAC3877FC2CE23FCC104093DFF78FA36352D4794DE4966B56A910E6B66
      14CFD163B58093F19508314B1C69BF188E4E59CD1EBE853DF50C8E8F9F441ACF
      313654AB5DE69B727025EAEF8C92FB687782A1ABC59025766C6F298610E8757E
      399A67F1AF0EFB4468D253B546A47A31B1DBEE358E4F072F64185C19A562AFD2
      0C51ECE0509D209298368FC991CE05D86C3030A05AB496AE0695AB710BDA23F0
      A08D73465950493C83D5718DBB83DA389650C937C2903899C19E0A0C59B121A6
      46F0C7519A0A0C739487F1850CF153E962B060A60A9744FE155C213095405CDB
      F8E7BB27EF5D10C1265C4998B6F120E8FA4B0F8226E33C2A581969757171FA1A
      A4E8C091556E563837775E870296E907AAF102706DA75A32F19756BB5BA4F9A7
      37E76FE8C8F7F1F8DDEB7C7781331FFC1C56EEB8FB97B687FEC9743E1A05371C
      32E1872A6817AD1D68CFE6037EB508431B7DDDD580604789A8EBEE28C5BE73E2
      67FEC159E88FD31D13278C38745027498214FFC86E490A9C7B03E7FE24002D77
      2CC290828D2A26D4C091FAABB3F73FFDEA20ED4E0DF981E708670AE011883D1F
      2471185696287227EC7C422FF0549C5350D4C72446EB42E2DC9C9F3AA72ABFCC
      791B8F771CFFCA0FC2EAD9C13FF11187ED70793EAFF311CE3E0002CFD1644B67
      E0D11CF315302ED0C8F6C56D4626826365E36A918E167E8C550CB360E6C0B197
      32409D9F009D6124EF7C1A395C6AA762F8E39C6D85C360204D19F328E5D3FFF9
      BCCFC9DDCE5192F88B8AD165582B3843E4F4FDF18F08B6FF090A99027CF04452
      31A28EC8AEE2A769308ED4D94186EFC8C5582D7A4E6F66741EC213923FC8822B
      3433624CCE4CE5100C260E07C5A7ECA006259A97177028DB87EA0719246109B1
      9147A87499B4C613D156ABB97FAC19071FDC7AE02A12B1D0D05311797676B66E
      22CDCD62EDF4766A353BA9CF40E49E72D84D673E1B0629F7F3BC62D630336D15
      93561DD84774DEAA2C1EE9706D08B2733921B9519467000F6F3FBEB978779A5A
      63CEDD93018804F0075AD33EC24B4D459663AA75F0EC2BB8F4FC25A7CEB1E2D2
      4CB385364E4A871503AE2B1460E274AA39784D2598AEBF7FC4525BBD83FE992C
      638DAFB48C3D2F0639F80D5D306871D7A1442B70D0736FD87EFAB08DFA29E94E
      070FDAC2A819CFD32DBD0A2EA075838B030CBFB84F2C5F90503E2DED0F954B2B
      956B9E1954E7E887C6E0D63F872CFAE3D08AE24B1445528E1495FEE710C4DFAC
      4A7CB972887AF1CF248BFEA684D11EF54BF8732C7396B29803CA309C8C82C9EC
      799FC5E728A50A32376477F2316DAD1F728CD0897F1D8DE7C01D4A68DADDDE4A
      8570B00F28A67AF545485E1DB8415C619D2C5531690F2B0D3BD77E4AC1CE9478
      1086A623CF97C568482F6086308647E3E5B270F1BEA382F886429668C48A0FD3
      3EE79CE90C6359071A1898629563AE8753740462063A15CC90D946986A2E1340
      AE458203F9C3BCBE26BD08BE38E63488A1AAE87531095219D1CDD60FC9221963
      559600B68BE6B8599CA6413F5C38313C20A127A47B6A60A62D60335F1C858B95
      1C3338830F5FF351B820031B3B13D314503034485AA24C5258A00E1DFA688442
      87B06798ADAC39EA31E6A8E6CB3647BD8F517B63957355E47C03E628D477940B
      838B355F9AA48B38C943155E0735B7E6D5BABDF5E5EBF52979B3CB6A92F27B59
      A79EC7F3D039F6832492111D4381E57CFAC01EDA411E139BBDF975BA76607986
      25A2CB057F1D384165EAB0742F8B3FC83A4E77614FDFE534858437553F5A6413
      19514097ED6D08BA7E4365AB3D5BB6FA1ECEFD333E380B2CD497505FA5DB033E
      9EA754372CBD94357A7C72E4C1DA4CE7330AC06329933908989644200B9134D7
      61FBE867898823F43ABF82FB3FFA8B8F7EA8A0ED1B8D6B250216F70FEDF40124
      030E864B83A9206FF61410DE0470F1308E7CEE0A80B9FE34A7FB188B9F606181
      612073BCA916E620C1B40F808830D3FCA2381D3381CD299D5D78511C815F760F
      17D3D1E7FF91037DC163C3DFB976019A73E109AAC000FF91AB0CAA0D2E8B67B2
      AA0DC0F588794BC5FA31031FE38C0FED12BD5B2E7F00C89E7C8C0540AA9F82A1
      88AD273E5FAEA0F07798293B4AEEB03A791F6B4471CCE1978A211DA5AE033860
      C6332A81FE7FE2F9C51C4E53981E44E5CF692DF212954EFF01AC007C074C4ACA
      67CB0AB66D99F01C87D0D68BCF16CA1B0DA8E48B8F02C0F06994258B1976E672
      DC66BB6A39D94017969A3D52C542B8EA2A9C6BFD316DD1B4BBFE6B2E5244A23F
      BD3B3A7160864BABD9A9DB8EB17F38D7F2A9163BCA6B1BB06A4CC4147B440386
      DA9D47D77E04D7858B3D9599ADD52E1B4283289806FF31AA6E9395D107653B08
      E35486EE615DBF3851F6492C615EB1F4853286FDAC0CAC29666AD3D110F620AE
      7B915D0703CEE7088C6B5290AB687B6B88ADBEA4E9954DC791AECF82A32422F2
      A728AD875CF31BADAB54E57B32CF3029B85AEC2B97B85F28FDE773344743B7AC
      BE83C987B0C7BF7E7772C1B556E3688C48198BED7185912B3F09280B2105D173
      7665ED04798A870DBFCEE6F0AA65C797F0085B87F9B35496C796196FB8A010CA
      EF12E7B8E70BE9B757A8BBA63196607985B928462D8D3D322FCF23CCA9D795B4
      8264309FC292A4AAAE797517CC29A07C6B55124FE75BA7AAB214897BE857AE98
      54B934EE9C0831A3660428651F6485C09DBC48C580C2980D8FCF0033D655AA3A
      CD0216745361DAAA8635A93DEA63C9FE21DD7585F02D9EF52A564DF14E7DC867
      D3B55B12DF4428AE1BB01E5E8A853AAB60421B6976D9C9CE3411600983E32C09
      F1F3280C669CCF7A46B560E134A49BF1E88A5430268EB723137ABE0D09F98592
      CA4E8E2E8EA8A4FFD1C527E4156F00DF06853F4B5B12D6A310FB34CBC1807A37
      44B284F2AD132D15EBF39D7E48AD1EE01F5428B00BEE82E2C09A8FE9C41FD6AE
      E1DFC5B02E4B44A1FABDA9DA06B7BAFEC739D70B5BBBC2D8881F09266F13846E
      20A2518256655A3D3D7F470553B929EAF9291B2FB1F5F707AE3EACE31B546803
      4547C066FBDB3CC00AAABBBA225296081FF4633EBE0C9ED05D48B5434717A383
      A77F1B8B65EDC203A7E6770C6376F7D6BE5A5438849F874260EEBB4454AA7012
      678FC9129E241555B35094974EE36246C1985B87604D232C6964F49C08003810
      2C45C48135E6D93C3AE583BA51418C13D42B59E6A7AC6E589EA5FE33017220FD
      637CCD15C3CE7FFCF079A91F0388C938AA5ED98852E1C8EB6750661B2A546E61
      29D74696F8510A07343A2AABC56214AD4EE7838A35147F0023E0C47AF6F6FC42
      4D3D4CFB3048B9311CDD4626DAAA52BDBD55A0FB643E0B83011A268BA5D37EF8
      F4F9A32E29290B2BFA54A87D04D2104A4B93B1E5F2513F2F18641D1F6531B76C
      8B01613A8EA321B57EB04E3D09F856F1861CE546853E8C6CE43F71BCACF053DC
      C0305A95B494CC73775C745073B3193F53EE386358D666543C463E335FDC87CE
      912E82B1E452C4001D0EAD849709AC9FEFA1E22E8BD830027B2D22D8471D55B0
      DFF98895B5B03F0A4CC14941BFFEE99704FBB93FB02CEE3C969B3BCB62BC2B79
      42B1FF5932173AF05A3A2482542D00F844B561C47EE1A9FE8A07A2CD9D5F869C
      E87DAC740ECB0DB0F7225F6776C9DC574DD38FB0AFF8B18A9D573D0E59670DC5
      2C11B8630FED12E12552CEAFDDEF8EA849E6591066B2C5A0BAEABB7DE7BBCF11
      576F220FE309633CE793EE500797E01FBEFBC42D2577DE0C4594015822FB2B9F
      68779425FF3B9A9BC1F6564CA5FDD1DA10F7D3984657F605EC1D401DE46959C1
      5AF98EAB3863DC36BFD7777804E5D7A105A4731FA8A380EF4CF1BC36463305E1
      4C2EF29C6F42EF62EA2DC05B1E1931FA6837597E8A3A1333260CE46A976194D8
      B36E180FE6E4D6DEC5CE2018B33C0B2906061D3C1499BC4FB66872490A1F6655
      F37CCFAEEE7BE4F517EC59F3AB9C14AAFEA6FBD6ECAF28EBCD32489387D145D4
      C2074BC361497C6181A354011764BD4B812D5365C1A040045A4E28EEB892F0FC
      CE6DAD55F423177A06AECA8030712308540E25C0943E17F8EB4C27CFE858B158
      AD01F8979EBAEF2CE2393D8D7CEFBC3EB0B3D3E1F8F03129377FE638A7F6CB8E
      73C235BC72097FEFACC8BA79DEBC96B30F7594F5D5ADB00E41A437E3A100CAD7
      99DD73717ADE2036FCEBFC781344576B7D3F4474D7E019383F3FC5397B49625B
      C201A0FAB9C4B6492CB052FB50A9CD81EC0624F6ECFD4F5A6275B6FC8B93D667
      A3FE03E9D87F1D59617DA0B06E4A4ED576486FF1E71252B5A95819BD57468BC7
      CA4DA8535628F81EF81AF8167F1A3955B4FFF07683826A2D074B96036D77934D
      3CE910FF73100D112AFB3365BAC36FDF617804FF691F4D05D48222C8D023C5C9
      A242B0279D9322B4053ECDFC44564BC1844E1E4D1911ACFDECBE6822D459D804
      90CCB9B70D6656B0B560AFBD342C7205EB03AD5D7FCFFCED2D69A053D66DCA6A
      C8E2B1A0E24264835F7BA5DC2FAFF2F6A405821EBCAD6DAEC2E2D3D27BDB4ACB
      B9F619FA3455B81BEB664ADEE5800219F6C799653AE64755EB88231975309DA2
      251E15A61A9C0CBBEBE6B084B7881996252C5F8032DB70A375A9EC0E76D70E76
      7A13D8180763ABC228874D6C5702E6610391ED5A53DDB15DF9464592613022B7
      742661EA2EEA9E95EEC2B71F4E7E10F0937BA0EDA1B2A3E410592C102E45E7F0
      80633230C1D6F147F81EA8E462D5B01195E62888827462E335EE9DCE534C87F4
      43BB9A59B6DF70C88F2E68432D5B98454B5148C55A8F7221B0EF741305E2E44B
      AADD7533784D1D0E3702580573600394835C6895A8C4E2C8E1FA11AAEAEA609E
      A00604BD15C810F560A4250B8B06603832E779C8A375180F64200C2037028194
      6CEC603CCF908B36E48A555F4CAC3FCF843FDDE71F79F6AE51C42111E300D6E0
      220FEFE10A64F40A3C10F55FC447B380AB98B8396510501267007F94147C973A
      D899946E3AD4D92756E99659CFB0DDFD3C73DA2DAB7759EF9E60750319DC4C3B
      3E295A965816F6C1800B8E50E4FE20117ECAF5CDA6AA3C31AE1BF7B076D820A9
      C54F4D94C7C1C4DAA5EE3F97C94A0900D6DEBC3FFBB0D410F24F2F9D1F755D68
      5497C421555B221756AC083524D92B5C8011C805DCCA2D29CD887D2ED307FA75
      4CC97DD7545913F12E17E43C74762FE82B9DCE954C69A408642CA1C8305D5D21
      9B6F6F255488261E8D38FC2E9B53614AF99D0CF152752E388994ABDB62E26946
      F1D37EA64CC999712D5B1212ACC9C724828820DCC7AD89EA6DF7D92441497722
      1A63060306ADFEF350E59EBECE73BBDF44A3F8FB82B0E193E2908B6B0489F311
      D36277750D72BC720F2E91F1ADAA58CA34E6124613B1A020562EF0BD0F1C053E
      706C2870E53A4E2ED5AB870BB903CA9186E64B38532C2E9ECF290F079F6186C4
      2186CDF9834920E8258374BFF8FE46850BD905179556329485430CB278BC65B6
      C7341B66CD424AE762562FE573A42019382970D38EBE6A4747C6E3601718184F
      12B0738693390D522EEF086F50BC12B6A354901700D89D8A441638D1BCCFEB73
      536DF5FCAD10B7A078A1A509442B97E83D938A55099C14D2982F00F45790A58B
      C71DE4D95CCEC99BA3B766C9113AEA91E0C17FC1952AD06C70F7CA0FE778CAD4
      4587E0F2ED2D3A25FA86A800D1B1CACD61D475FC4F85B5E41302D54656DF0470
      4E06611AC2BE67E692C9A9873F739FD9432ECCA7527929FFD40CE1C4841C7103
      476311CD95BD4E76A82DB486568E9B9C9BA966A7E236C63FE76644438E57A4FF
      A0D326BB8EA56401BB62AEF74222098C22DD92CB9BD02A40DD70CDC54EC4706F
      ED66C40314419494F55709DF5F3BADEFE3D5D41AB42E077855985A5455B88AD7
      7F8CE3DD72FDB3BB398A2D2CBE8741589AE3339F9A3163C1C26186C35CB184F7
      6BEC26EF0306A050001F631124920A8CD62B7207CB384B475A8B1DAA498BB057
      EE3C43C291F9462FA6B3384197D7F1E9DBB7392690D5C68CF10FA5A74CD74AE1
      1ED1EF74B23FA35C3C4586D8DBC634EE21C2A3AD583F4DBD421C1D0C05B9CD96
      70EDF616BAD1944D3A44E8BB58B64D6BAC89E80E9E4D2C5BF95A6A111AB2A613
      3F72D3BA69061FCDF1114B0FC49A30821FA3E720658CA34E1711A08BDB8F2788
      369B2733B4A6335C56FCF1C92AA43229232A5B73CAB8FE8CCBDFEAC811CD1F72
      E0E1D398E768D81A317C22EC286B711C3A67F3849C05B733BE32032EE92CAFE5
      471BF832115C6E0CCF20699EF7B2CC4F780DCC70011087054DC7B144E59C06E3
      673A09ECCEA7C143E6AA4C3F5CB7F48C3C874604449C4CA509B20D18848186FC
      F5366C12A6C2A8CAD2B8EE1D36E7C2FAF1D32ABBB099127DC4859AA8A6E4073A
      97DD9FEA6C24397FB895E46C186B49F3B04620A89E7229283CD3AFD002BB46DD
      3639EEBEBA856B672CDFC44FA13256D4860B9FA44FFAF48EB056C8F2706B9998
      19DACAB0ACCE916CEFD6656455F158916554DD65F9882C47D1FA2219F020F901
      6BDDF2C6737A0E6FFF6123A8EEB6CC597C570680FBA9FFEAB0EF7BCE8F2074E1
      7A0BC0BC6888B7D42560803BE868FD11593841EB0E7078B5F6F43F94C00D8471
      E8AD06ABCE60B23F55A2A14CF961BE5DF3D4A3896DCD73FFFAFC0846DDDCA998
      CD7664AFC3CD382D1C1B2E4ECFEB2F76313CB1771BC6056C4158FE5AC066ED17
      5941C70B99748EE525C40D1D0719D673D5BDB30FEC943BFBD06EE90BD65F0774
      03CB4C73CF88E9E443199E2B9C140BD705693AD76E1F5598FCCF215B7C48E478
      30108BC477AEE26020542D711F3B1E8EA9AC01C73214ECD180883FC661904ED4
      8A6CEE81B6E29A6F461D77013BBB48B1F76B3C93D5DCE95082F890B6390B93EE
      8B2DBA9961257C3E1558A7B0DC3FA9E8A4E489E16A31C273F0A4C7BC83E39BDF
      97BE243CFA60599CAB806BA34BC3C43FD12586756CB06F937304AAE0046D1456
      38EFB3734CE0E5A8E5C0F94C88E16BEAA5658554996AF9F8BCF3F98D732E8FD0
      3B288BFB523C77987D05DE3DB8F3D88E32402C45469A07F3401A21FD2B3F0829
      744C4712987E4F1E991BA171C003557E4763E472F1F7603A4BA8BF0797A542E8
      8A31006442D4F6877390E241A66A4C156C0D0957C4A277F0E5F2552E64E74711
      CE9C57B25D1D7C782F6EE6E9BB78889F7F08B21FE77DF820ABDDC327D52AF195
      EC20F84A3620D4946C68F57E439D505DDB09D576A37B8E2A4D9D975DA5697BEB
      2F2DB7E31C38F5C33A1D9E7031D49C11A851F25BB03D55397A082FD3615536DF
      993A6F4E0059F713E15F7204DA4122382503AED807B59BE0A515EB0A002CE962
      2B3BAED70C8A17D98187C96BD3DEFCE9F4E3DBA3E353E7DD8793D3B7CED99BB7
      A7CEFBA377A7B2F15DB5282EEFD6E467E8B3C4EFF90219BF29A2414C1E4DAE72
      3DA50D3C3F10154E43285683C44FAB5606BD8423D83AE615C8FE352A96698CAE
      3DB90F3BC3981C1F1408085C6835FA41C504A18CE8B7628C1DE330648CBC2094
      FA3F9FB101AFC62DE2B8E719191B06CB75BB2B4E3E77D0BB383EFB8CF3CA91B7
      791A2C2754EC9CC5E4F7FF3CDBA916D177340ECC7B3FEC7CC400C604CF8F80ED
      F302E33AEF03EB46CE32E7E70F1F3E1AD181D5E244E9924FE24BF1406BD9D3DA
      1237E298F833584C6943121C5DA4A2738CF85A846CCE3860C7B4EA1A2A6B0B57
      ADEF4D9954CBA2CD6F2EDE992D5C7C2A070DD82F88FE0D875BDAF8CD348D8A10
      7D57FFC9C00FE3B17311CF82C10E87AEFF1C27E11020FC40EC383F70E497F4F5
      5F6119D314F53AB044DCCCE0F26A31A28C0D9CFC2CCBFD5224FF39D5A9FE2406
      684E912AAF9A28A6B4998F6A1F4986D220356AEF2B3BA9EAA4E6AB5C0DD9DB4C
      FA03425E12D2BAB422E7E01B611459DFD4B14FC2DA3CDC70E00F26C24874E0D6
      8A324691CB9DCBF848DF6CDE5A2DDEACE0CCF616F246F6E81E615351207375E2
      C990E205D94C0FF204CF96C640CED0D5F2167159ECBC9B291C1F6399A00B8B92
      462B0461569E89C842E57FE4B372FA05A9DC4F093C4040D78E3BF0449C6EA498
      DEC04FD75F3590DAD073A75DB61190656933D3FD26CAE0149BE800EEB5334375
      04832DD5E9AFB5B64D252DCED2C9C1FE22EB6A6373EDEB85338B67F3D0C7CC44
      CC1B401F5BC11DB41CDC8BDBF04CC43355BF6B4649A93AA6DEC7321007985839
      8C2359D9263F07C15D4332F6C2D7D20D657DC5F74C52EECDC3B385F4E7F5ADC7
      D814638ADC66E7B0F431A00B57796FF74DBFA972DBDEC5D6BC26291CD9FA71C8
      19F2649044F9D95881A66FC8435AB31ED28771EEBD3E04FEE957F991B3933365
      276F9A95C7045342D950256388695FD09E1544FAC084451CCD740C4EC22BE6A5
      A13702CB1961E2FC38F1A71C7A77E8BC965D9B5518C7CE498C6959ECBC883240
      A232537E87AFEBC737F9510CA07A8470510F3E9A5344298D9DCAFBA9F4F18AB6
      6048A1CAC2DFED8B818F6E229936037F92256736D60ACC7B9235E5B54BD794D7
      7E9A357541C13CB0031C63200F1C23ECD2F27441C88B0FC70AF319C154A1182D
      C75219124A1EBC5D0A96226F3648EC656ED0322E04CEEF2DA787D2C2013839C1
      C5E9DF9E1C2DCEEB0D2B3E89E7F822C76130B8DC7C5DFC35F4B33A0576AFDD74
      B1BDA5A404E58ED3F2C8562553E7A4695466616BEB956E9A1A0CE1D02F051247
      402D4E2BCC577657CCECC68A334652D939DA0F9C5D652D03664771B627DB3FDE
      1E90B3F9F0AF8948B318B3B4AF398F91CB9DC81230FED80F36768EA98CEE657F
      8055B80ACBC83E9EA2D0A940D7BC59529FE865307223D7AB108FDE5E387F73CE
      FF14BAF0F8E2D35B20F66CEDC492FDDF6CF02ACC2C8FF54EF8597D03BB81D6AC
      E42CA2306BAC892CDD229742CC52C91A8A1654C1CFCA03023F53344DC5294592
      6C88739BDA4A35F34CADF225EC537C53EE28390E4D036AA744E0B46011B0481E
      44F675A504CE97A3BBB870C2EA21E47D76A3BC673AFFBF389EDA6D526D93FF89
      5152131F8ED37EF2A51B25B25257B1E32A72E1864A3DCB8DA5B6EFFC8D56CE81
      2D9DF5E24C6E9FDF6016D0D476F956CB8F4D4C515E7E2A2DF448E8CF31180376
      6BCD384AA35AA82547055EC822276B0B6593249E8F39477F87EED8E14E60984F
      A5AAA62CD24C4CF9ABDD601047AAC0E4923562AF90DA752DBB82C1CABA0A7CFA
      5EBD1447E744469118B312D35D973994B485DD1F7C2E2C8A95A546C5036A86F7
      6A6B22901DCB1A043C2891A10A749A8F62A704DD9D5295CE54E074672A54E32D
      F9B777877E72898CC34D14F810E2B7583F5717A5E5D3EB095CE6ECAABFAAABE5
      CDE6C5FC40837E7CBC74613B40E92572196B2B283CC0B56165FDDF42961C355C
      432E282A006F4CB8229A42003C957278F6DB23A9189832153687F95E7325098B
      7F8DF5BF30AC0E61D640766CC642ABF13CB19ACAD4546469BF668EA995AA0F08
      C42F271D105377B7B7FA5CE48C616B3444FEB11649E5B5145843481963766F66
      C0F600E3D5F4DAA7F9D9C3DA12CFB45AD93085E52B0A0E8A39F72E0C4601FA03
      E438AFF8FE3D1E8F4A00E695AB15417DAA404F0A757B4BE8AF65CD9CDC72AB14
      204A1C554B0CB1D0502E7C188833B725EAEF934B99E7B262DD5A88A1107E7667
      DEB6195E4B4B5BF1547A2A64A9EB783C0E65F83D19778330C8165CDD535E9FC5
      7128D7B7BC491A6F6175C166C70661D8F8FA41240B55B32782278DEAEAECD2CA
      E2F9E3B5A9FF7E04A3ECDE5A6FDA21F73355F0C0B7CB25624A451566D839AA98
      086946830EB0768D5C93CC0A1913BA2FA14FC6E779BA6EB7F0BAAFCC97DB5383
      C8E74B46E41602BB94EF91D41FE1050F4E3EBEE1CDC5AEDE15DBAE2AB408FB61
      915B260096B92198F71261171EDC4F61571366F9596DCCA23F8CE01881818EA9
      2AA0F30F0798FAFF2889567BB6AAB678A8DB1885C134C8747735D92182E45EC5
      02F5817BF472946618D31945844B4815DF8237BFC20BC2B2C9D888A610BC5D47
      0F90999D1FFD697F9E8C45B2E3BC83C3915D493AB845738618B3531280296D5E
      25BE79E3302C9B38C85170A7C1732C1D48C900B6ABDB7BEDC93D07134E290B3B
      022E89F4FB6A25076CBC3843F7651767781BA322FB0F29C46ACDEC0FFE54BCC5
      8A3FBBC188DBBD4459C58A406069DD6ABDB1AD9C56D0CFEFB0F911DB2933ECAA
      45708276FD48F5B90E001AECFE9D30C35080BA1DCA487759358A3078DEFDD0AC
      259582DE5E0026CAF24A6C5402CAB48B72BCA0C517F77960CFDF2A63B515DD65
      2B3E7761D0B67C142BE41702F755BD2F768DEAA9F8B743918658F2129044A0CF
      DE58CC4C1AC67C59195E2C8DADCFC1EA0B3C257013F854D752976DCBC8F8ED3B
      3B64D5DAC15CE92C378351662877CDE27653B8706633751B3E737BEBECF4E6E6
      C6A1F4EB43E7F4C627C81E0666C3076EF42601D254F8583F4E1F63B4354075B0
      98CFF0A3D7AC3B3BC8C01DFDEABBB51AB5223B616B40A3D66DE917D7D79C9DD6
      E465A76767677B8A4ED90B8E7A7D65C1B4501F5ECF495E0E03B4C620E34615DC
      E68BCD7EFA31E871A1BFCA366DF8A2EA8FFB726293141453300EB254A145D9B3
      0BD5D8FB0F1794A51C061C40E753D6FE10CB6E4C8348988FF6A3C5149EA167D5
      A8DF8F5E12546E5C23956CA7DC308E43E90877E2292E97BA51DEA78CB382A733
      4028F80ABBA82111CE62F280AE1945817D91F3A18FE504DE9CECAB062D5479C1
      CF290CCCAE64FB7066FC1FC47D2D4A702E25CF525EAD213FDFAD105353825521
      E112C73236289BE99225EBEF33F6661CC1ECC08B6EA0362EB156B75351C2498B
      9324129733E627E32B2A5B97960565255852336BCFEC3CF8988AF9307E28079F
      8F7FC8195E10DB5BB4240A0C650520398ACB4E571B780057A5EEC3DA5229DF8C
      466AEEE549D04666E9930234855EAE2B538D5A48F2D0CEC91699149189C119B3
      7F94D16D96BA11294D81C93BEB6F4A8405E05F408B7AD90E77236DEA4771BBF5
      527AD453355C0603A49C5085216F867937EE43E793EEB94B312AB2A7B15C7D2A
      438C109F89F6181E93FA3D271CB3380F6E406F4E99EBFC670E7AD1AD7853AD75
      291F5F0385DB8B1E9F3616CAE8CDD54D24689DC5013504C62365B4882361D483
      53ADEBD1E9CB4DB9C238BE44FCB8E21DF189D3F960C2AE2F74290DB8074AA1E4
      1439B665C92AF5BEAFE14EF4F462EB141F5EC69F52EB721887EA0F72FC67CA5C
      4A64A3B01102C36CA22A7A9A53C01C1EC2FB05A385B44C460B2EDFFC3922FBFC
      8E6A7A4B742FF57DB59BCA3D8BE353DE0BFAF5C239F6C90F68F715DE578ACC31
      DBF5C9331E1F4AA8F0102883110569D057B4BA39CC89CB12F149868ADF1BBDB2
      132163DFF81C75FCE9581BE009A2E102A34EE8037E2CC73EEBC506EFC72E231A
      97CF46D8E8989E0863827260BF2E46B22502944148F513F0D885CB25729A70A6
      5C6A304D27F798D66541EB653EE9C7FC5E0F8E605872B1100627558383B5CCD8
      334EEFA1F9B8C444265FF6A2C460705AEFF2C1FBF8C94C6B210AB5064F9D7BE7
      475A128A612FFC4C156BDEFB1D3168EF0FD27D44BBB45698C75D0E48E70906CA
      65710084191957AB188142027C31CFF098DC9F736F4FA5E16474BBB250284D4C
      7DE355457816A10209D12AFE9AD2A4CC18C621E71058CD972023291E9013CE8C
      86E330F0CE899FF98A725AF56287A5D51F64733FE4DC4A1E088E0DD4B881338E
      E5FBEA1D00E6F9F6EBC980BDB2832DF5DFDEE4D1F604DE8888DE0018F9BBD972
      6A18A4280D292DB6815CAC1BE3C65B5883EBEF2A0E1C1952023C012653BE732F
      0DAF296A15895F2AACB5FE23BDE6153A62D67EAC579C2246989C925B8FD2D609
      EE0B6B6FE57670FC7DEF77D416BD3F3690BAF477565412E152A85CCE208B02EF
      E6DF3B182538408C4046652D48B88928CB26E086D2FDD602464FD73F98253115
      2F8D0DF86434DB2EC72CC339D93265F29B742288042FE088DA29CE1257CCC289
      4A732B344738918F45372FCCF32B8E3F7EC6F00E61D43292763B2A9A9E9FD610
      4462331C7455D06BA0CBC2702AD8F55396DA6C60749C1489DE01CFD73DBB4E56
      AF13668E3CEE98871C02E11A70FA7960AF3A1A19D8D3298C247D62DABCADC690
      2BCBACAAED4777D5CBB5027F5FD54A6A4405BCC69BA84F21F5D388876286BF58
      FBF452D007A903E9CD5449CEDA8AC8EE123AA849AF3452821DBF733BDFD1FBF3
      37CE2E9AF4FA0B387AC2BE80C680048E6B98AB21AF975A5D264AA5BA16B28A39
      CD276817FDDD5C413ABB161C36CE83A5CAD303AF418F62EBDA1EAE268A4C753E
      620A5B3C4FB10A79AA42DCD9793B01044FB5C9296616482322B7B764BB542EEB
      CD56048323EC280A86086D11BC69873611ADDF59460FC8C365F16F523584189B
      26AF28BA958DCA59186940C92FE5E3F17943559CA44B753F68D56446E651C99A
      C183D04FF13278113519F9B1186892961BB40BC0B6AEB280D4D998ECACA13A76
      CB9748D91A42F5308988EFD00C8295BF31012988383888DCE42A0D9F8850A7EF
      95BCF9706E13E7EFAB3043F3A766D4EA30BD6563043EA677E6B167B784DEA102
      ED631FED8968899432684380BF2C04D85D5DA2F3C5C4006F6FFDC03B939EF703
      A9E75040A43F8662A508CC45B8C1EDE7C5D6D10446C911FB18822012EC9D1DE5
      310314C403D726BA1EBDF26F51B79FC36A09D34FEF8E4EF05088BD70035E2CD9
      622624E7C8C29F24FE225F449A9764D5173740247581BE5C24C1D4F1B7B7F050
      EEA32F93B3E4D9CACBD320ADBDCA4A9BEFB26A47737C343A664144114AF952A6
      402DCC4789A5C9BAB0875584D532341D71C70AB1BCCD23B49B93F0951A1281FE
      67B1951DCA97597F7D28425CD75CE858CA4790323840CE556CC62F123F4A6131
      904FE50193BEBD757B6948A523B58B824B1499C4DD01C69C2F960A71888180CE
      877E1800088BF6B577BECE504DFD4A15646017E490C9C29BC01345089BA39107
      3EC5846B4A774BD1E52E5F9061EB6D8F38BF825206F0D0082BD5EC73A03755D0
      84B51DCEA9DA44B45013ABF903DA63ECEC2AAEC86436F64B1575C7FD6BE305AC
      8CA775CDDCB736F6949F36FF1BF798439759B8B8BD88FEF4A0711925183E5963
      01E0994F9F565CAFE939BB74903970DEFA197636DC33CC9520A8314083842B84
      CCD34D78CC06B3037932FFFE7FA917FFC7063C67D784C9D74C7D19C506BDCBBB
      E6D3518CE5B8B906D09AA99E67A3CE66A2F6FC7C6DB049FF10AB8DEBDE78C994
      740FE3E53E0267CE22A2A030B95204ED0E4A2B2D0352CAACBEB528E56E00BBD2
      E78BB30E41CD44AA3C15D55F1C9D42EA968D5AF9B8B2C04F9A6FC91C0283A373
      B002EC560C3E35BDD744A3D1C0B7101A771BED112564634227565EA344E466CA
      88122538D67F868E16B9DDA3EEA7BFC9DFFF64BB9E350ADD97F52A05C8DA8354
      CC758E427711059D9F72564C1C0E198E9A99E085E5C7EB1491ED38C2E56B8D43
      5F681C5AED257A31C621787A3F18007A0328D7AAD6DC6200166E5107B42D55EC
      DDFF23E0F4485CAF55EBCD877E14A4F2D5BD6ABDBA88C66155DF7D144495E5FB
      084368AAF9EA6301903DAAE6AB27425CF29BD7ABF5E6937934F69340F1BD620A
      12B6F530A8A8CCFCDB9FF995DD53E1787D2DC65565FD2CCEF7A68A493C1A11E6
      E339CB4DF5389FCCD3544B8D5BAD778763476561417A2D86557DF76C9E5CEA77
      6F5833836166383FB50685E73428ACB6C2BD1883C2CA43965D19719E1DDE28B8
      9FDB2DBB5C9E73B9D45FFA7259FF4AA9A44DFF84A22AA824AF74386144AF5E2B
      9480CBC580C94962150F2B9E37B70A5E5041E589E1C4A738668AF8CED9B98B45
      1BE02BE5BDE7BC749594AC439871413A7E1FAEDAC3A465EA4FB050D91B85F970
      76658648EAEC7CA63880C29FBFDF5995AC8C0E414A6DDA33E2B3D9B1A9EBD8A2
      8B134B4CCB7A1B1CB01FC8C4EEDBAFA1A2126622E2F0199F7B2760F3346401FA
      36D7ED4FFC653053DED95F37E0A64FC580EB15C8063E5471180B87A86E13B28E
      5EA08B03DFB1AAF29593DD74DD16FCEB76EA1EFCF0DA8D0EFCA8B75A0DF8D168
      766AF0A3D9E8E225AD868B97B4EB1E5ED2F11A0DBE1B2F81E5D9A6616ADD2E5E
      E4BADD1A5EE57A701DFEACB71B745DA3D56C3DEB725D43274A531224AF259EFA
      3BC634C8AF2EB134791CFDBD05FFB37A4E47BC1B1D4D28A8D999C2EBA244BFD4
      E893A7CDA926050E8407466AD72E97EB5C3303502E37D15A3A8DBECBF6659824
      EC3328ADDCC5C7C71A0EE61E62884A1EBF423D77B8E62686B700A21E0819B565
      84F5C0DE33144980E974B40DAA2DD30665DC0FE0083C288659CDE519957A0984
      61155C8EC152480BBED939E51D60C7D9858F3B8470F451921A51E520784431AE
      6660989673195B85C91C542800CB786D262033FCFE7FA937FEC78ABA17CFCCF0
      43D998872BC1A55960F6029205294885A4D741466D86CCD03923388D3B825164
      B9510C978266E15C3E9DD1E48D4531A753DFAD21F41FDB5B6B0E09C560BF7F1C
      C2616A23F90CFB92F4ED2D2C7BF556F1E3522C48B2F3707D55C334BD750D85CA
      634E0DC72D5ACDFBB0261079ECA555BDA6EA2D69B6B732159B6C0ECBEC549578
      550BA35C1FA7528B70EDEF641E61810EA976759AAF6CCF51680E60629511BC12
      B6195BFD703CC3CE23D9FC483E98AA29C89D84038277C92C7FF6A121735F3EB4
      5BEA02A495E27AE5D2CAA8AE95B819085061F2F471B867BC4F81191C25CCC918
      B723FE29277D90083F9385ED903E3A87EBCA27943B4EC1BC3265FCCF15CC9BDB
      29BEB0F8F51372203F746E224980F3F60F1D71383E5C37E91C13FB7F25C22A65
      C43AF243B8A21FAD0D992EA04AE1FB0EEA8B503066D30B6728D220310E30BA08
      ED6A15752DDB1106A90961325E9874EAE1E587A96B7EE80C267130A000FB8D1C
      21371D624F5E17AE0EAACDA339538D1E0B79A213178D78ACA2B7E0A5643E5625
      8D5AFC228D5EB77953ACC962966359A11370EB599D794339AC2CCCB3241E27FE
      54963ADB95195DF9F96573A797751F1DD1C456C884DCF4E9797B6BDD47B83DDA
      5EC6FEF616BAA665DF19DE45F773B123B71096F85AF2641B55A7521249B80E85
      0C1D485C550C4E73CEB1D914570F914D92783E9EDCAD4D656D4D55DF2865A115
      B2F0DE32B382F2FD2478429E4571B6016B286F47454FDFD2869699EA63179501
      5A8F8C0CEADBC59156780DB35559FD724F1C87719F0E54C6996017E765960471
      42ED9A311372B55D65CFD83FD79F345C4816DE84A6D9409E344DE566092FD827
      67AAECF46692A7B7B71E903EFD8D264F6F42E257244FAF7F116C80F442971254
      A968EDB94668AB3AA3516BFBFD0D94D0564A6113E23FA34E04495EA1A3B0FFE0
      0EA36AF6178D4E58D6956A2ECACA1F8070B179C1C23444BD4013CBF39E68EF30
      B8319BF639CC6328D24112F4352A1BAD7F27DADEDA6CC1A5CD98A2B6B74E127F
      1C47FD3889BE545C9ED20CA55B2E5145A12CB812E162BF0823EF447DDC69A568
      04265FBA827204D6D75E0665F6FD0DFCEF61DBF8D3AEBE349E0A862F32C28D97
      18755A76766F7760DD2B7695D9802022A7D6BEF4E48961E3B13A6BA905249D98
      4BD13A0C7AF637A27E30047913CEF8DC1E401B5488C5F8A96151433575A5282E
      B46A8582AB81D7D22F61D153C2215423B56EBDB6F6D380B512DFEBE21E3B2282
      F7B4355FCC88C83CA94432C789849F94D4E8A7886BAC148FA12E66AF0B4082D2
      4749461F6DA929D8F36C6CF0336B688E9A57CCFFDE9169AB92EDFCD771A1849F
      AE7EFE3D17EABB55A9AF70EF0A44571CC0CD07385E2441180683E20854ABECD6
      9DAD66ADE63ABB9F2FCE0E3A7B7671F2E2FC1963455EB24FF5698DD1B94F55B5
      0ED4DA4409CAADAE75A08DAC4E79EE7C835AEDFB5AED57E7B53FB81C27F11C14
      3AF69513C9F7CE2F323642AA99C3F38B4F6FDEFF70FEAB5CEB0FD50C76A57385
      DA176E707AEA487C2A00495125FB0EF5C2501D39B8FE659CE599AC76713FD7E2
      CE0D4A3AC2A964153BBBE4CF5722B36777EDBBD6B2B42BA31FF34FB6B0D9474F
      890A01AD6C47D531E7DAE7794572BB7BAF69F76EACDEBD0D63B248A7BF3A6768
      60942DD776A907DBF747DDB34EFDF5D9995ADE5F32DC63D4C7978C7F4EC146B2
      3BA36D727E8706DA8025FDBFE17F6B37816D6FE5B94CA0630854189674AB8C5E
      803272BDD5ABFB78F641AA860B9166B0C267251A84B4D48FE406714EF2C9DD20
      1EA964C34764BC832B200115110D43AB400B56D1F0367B4895F6B1B76222AE93
      20CBB0CB62DEFA9D8413C4D1C78C40347BEA8AFED81ED0A7F64CD3000BDE93BE
      C91BFF99FD69044635B2F7D4BF5D7D5F99F8CF8D83D23E5D7C717ADEC0DC1DD5
      B7E6FD4F2605CBF9C8E449E4421CD40E58F6A081419AAFCECF4F65FA4F230FE0
      95C3ACDD1C350BE7C08FF430BBC936E178524C5139F2C3587087189576114430
      AFC0D7BC43ADDC758C17DFD36D6A251B71BE6EDFC8F13DA1C0366A6A9E56781D
      9F97DFF896F492CCF1CD38B06485382585FBAA8D8F0A4E59F7690AC0E6064202
      90FAF5531A6E80529DD456E85C92612016F72B41452903434ECFDF39A3D0A7CA
      4032A532184958370DB815AD112E61468515F4E1634AA43D2FF3B92E9A8FE3E9
      5269543C0DBE71DCC3175229ADF19595D29E9987BFE336D9FBE3CE25FB6C698A
      D512294F8AD4BAE3233ECF86B0AE1FAC549F52D11CE0B6F204B511F18D9E6A6E
      70ACA5C981AF9C3ACFCE8711A0BCC00F9D93B7C7A8D76090217AD395223B3037
      CA6AC95F6343F2A774C4FFFDE9D3A684909C663F7D2A94F86C383F7DAA866836
      79E28E29503A8E9CE370DE9710ED1924740304B698400535305F97C8ABC6DBB7
      0F65A1FBE8A08C823FFD01FFCDC819CE2904054121356D1E9947384AD966F935
      FB86726A9C3490E3298E4F857124B8142215E1FD6D4E19F7533FCDF2F402D558
      348445335C98010E8C55F3DB8C26A5FC98204933D92D1355C5358EB4626A65F3
      BDD93C0CF9E52837248864A36DBCBE0F42720988D85AC6EE960F6CF6FB8EE741
      E7193A43D885639B556E9AC86E3187D6845A46BB3AF9535E873935459B0716D0
      221F0E9571F2132C84A5FE26D7A7CF65657935A5FBCECE209E2DF04C78787848
      D2BDC3A6B6601A84302FD8029376A5742FB7D619363A6DB85307432E7D8B263A
      CE23F5F1DC29AE0210015EDC72CD2DE2B9EC18BDB45EF9C58AA567F1143B88C3
      F934629690C5FA03A993DD71A0CFB2641484A1FC145828EBE46099316A0BAD4E
      B1A485F6F6F5C1173FBDE523F0EEA8682881ABC8A82B9F4436C402C3B99FDF59
      9C4CDF9C381F13310A6ECC03F255C005CED414C8687B502F4022D02A3914511D
      5C99FA4351A292636AAC77F27E32D8A843B9641437CEA6102EFAF3C3E0D750E0
      FC0D9F508271615D8A039930BE21F30E30F8BB8CCB8288C1659EC3765658346A
      3A58C1ABAD43DEA2FF4AC9EBC154171EA0BF930D795956559565E2FF2F87BFAA
      EA3AB807FEF2DFBFEA1298FF07449EEC31AA26B47FC5E1BC6448C1E4B021A6DF
      A5224BF1D6A51752A39CC473BCFF18DEEB1277C9E32C09FF761A51BE2EBE32BF
      671CC12B675AA7E41B21D55A2E94DD1A84B1AC5EC15A87E9F8F04FF540F27E6A
      DDB373BCAC2F60D715C0263883EA78675AE37A89936D7D51289F93975DC2F7A1
      C6ED70268325F94A2F46AA269BCA12D95818DB343F3DE09D70E927021D02A9A1
      58413725622A30E563BD4DC82BB9717F204720CCCC77E79A83A8ED52B5069C49
      1CD27E727CF1E92DCDC590C57380E2F99DDDDC79733F22018E39FBEC91BCCCB7
      5FAA157EA84ABB921E1BF9619A2F0EB6EB23E2E627F2A6B5CF03ABFACC13110E
      E109D7BC5316B40A2B466C133DCB727FFE3B99B10A3F9D1F40CBCFD833B60B6F
      0DDA7F118A3D59484B9387C90C1B2B145999457636472D8C3B8D72551D8E2731
      4C92F455DA45C48B4872258F6A570E0DECEBBEE064CF5D59415142B539A82E92
      496E794E757B03720E2F60B31B225898F81274C9E1F5CEA401ED08F71F6A222F
      C7A26E05C6DBC03D419AED9BA3D0D718903B8E6263A339E5B7930B8AF67FDE73
      F9E6CF6F728728428A3BDFCBAEA71249392E9C4EE2043114E82C5259A95D54C5
      45953306CD21CE0856D43C91B598F58603F2CAC59D64BF9218CF5BC15496D1C4
      CBC631056FE0427442380FE232C16FCC83D70CD0727E3A82C7C1D50401B338D3
      E58A26C0C9546D37C529DBCFCFAED1821121BF2D55B5BA16584F3695A974DCB2
      86E5009715804231E6832C11A18A52ECD3D18B4F6188E7239F6A60E967EBC47C
      FD15F3E9DA5FE02E99E1439935C4B18148288A61172D4AD7D83C381AEFE9084D
      42F5BE8C935387C189ACCFD417035F5791A3FAD8EAF428D994A2128BE751A663
      59A83C00159C4A95216CEFD079BDC03189247A4B2A15ABC720D517C534877062
      00DAE01810CC10BC07DB5B54D76B04182003A49EC95D9C8FEDF27555C57484D6
      02DF0581873C635F215CA7989D09A73FCE672BF847E50A5065E36B32BD925379
      C96F79748F61D104083FA5ED8F39978F0927251850360BA08319D6D09414A4AC
      DA6578511A8718AC835511309C48D645C39B96299013D2DFDE5A183248472BD2
      C9785C9FCE32E0A27F158C59A4B489832BA161C0F6828D1F3B6774D8A77310DE
      ADDF6EE7D0C069B22608D96EF0BE590C02ABE51DCDA128EE7082A362F5116F38
      B29D0F720007023DF55D2ACDAEF27D816C2C671F44F97130E70E891B7104BFC7
      471129143B05A21C89ED2DFD487A75667584753669B6EE228DD6F7D4BF44EB6F
      C66A41F8E942DA678106D2894B713CFBBC2C85325DE171584E5616AB395C9A64
      C6A0239412A0D01FE3EAE3518865F904C208246FB42850812CCDBB4DF67E9811
      9717F1F992A5D26EA746A4380523E601B96460A29041B523ED4B8B46293B755A
      A65C49F9B7B494947156BA22226D5E4F6F8F84CB0377E869CCD52129984E6D9C
      A6B1327F862E4E9ADB6EF79D34267B0E6AEF6180E5D961B9899B99EA171044C3
      00F65D04DC853527EDBB41C21523A32C35AD61544E4A6A11C3EE893792F30774
      468081A001416E95CDA69F60EC040BD820A66C1CE7D826655723752A8D6AA869
      AF7C605D3FB49D63EE13E6D308D9F4EA2448C95E89FCFC244859EB09B6AB3EF7
      DD140AA2CAC2BE3F912C2BA1C655C806195A1943C9582C6F4BACCEF9BA6F025A
      00E5F348DB5360FB53528DE0255F6B323EFABA809D6F79947887B4B27FDF1152
      D5ACB3A27E5BD4A53F2EBB8E1D8E2B8D15E2320E93913468145A6AA0E7DDE1AA
      80B937C6D3AEFE42BC805885AF757F9AC8A852BB735C7CFAE1E1E14EBE6602D5
      81295F9EFBF844DC136808F29FBCCB83A157C1FA513C40B02C776376B3F04397
      3672784C1A80B0643204C2F442848B65670CAF5AEC8A4901B75171ED9E5273CC
      42FF3438FFA0BB2465201EC6F1252982CCD0367E9F49812F43D83E33A72E8F4D
      A93E50EECAE3D4DF90F7EA6CBA77E894A931AE90A6C8B9BAA5D4FCB2298003A5
      ECD5949F2129550C3D743EC555E0816C792664CF8465FD19A44BF3A0E7982684
      A4824F682AD8E016180AE5B10955A7F602D2C13D46CF557F9E89FC10AAD82651
      96EC7DCA2F85F3C6E74E058AD8ED965790A381411054D24A9F0AEB66CC45F490
      1B6273E81CD1B9114F3541325582AD9C655A588AB24654F7853E342928B62440
      FA3AEEBE6A75FF3D3A6E897D56F1E7186759B270B5A5794B6223E48B1615EE12
      B9CC8B5BB0FD3DDB34CCD0086E836B2A8537512A92EC501F70E485D318CD39F0
      2AE426BB8E6E2912D06EC7F324853F7F9E39AFD4E7133A531D7F3A5E7A229A24
      74E55A63A4EDADF34930CAFEC66FA19A4DF9991156A6743AED2A64D590170723
      0E641BC9D814A97BE8E1C1A86C9843B26B157DF6E8E5FF74ACDE58C66E14DEF3
      84BE335C1666081D3DB1E83D94762455845687CDE163E40BE7BD9E65E09C7C19
      F21F4E29272F272FE5A7000FB034F075200D99397946F209A7975CFBD838948F
      6691B60B9FFA306CA1D2039767C4C76054C0A3D24C9663469F2AEE994244FD91
      11344A81A4A3BAD3FBAEDF7E21F925CDAFCC2F7976C5A2630C0E9C23635B7EFF
      E142C763EA83139A82A5FB5A0A8E0EF3D2BA899DD754E4F3B05AC272C1017B07
      CE876508A22268E5CA28B80E2A462468D4789E0C044EF732D65AA69381B6768B
      E47E9462596D197FC7132FCDF7E48730619E214B92CFDCF0C0E885428F966FA7
      DE6479CFAA089781257D66C401EE0626537524F47E71DD50F9A82A2E9BEDAD37
      E46577DE7E606AD17D2EA7DBD8DACCED4B87FDE5AEF8A9CAC9CE3BE4DC920123
      1A154FBFBA81AD922D23648D7B9451C8EAF78FC9635BE6A7F7B40944DE72A203
      9C04EFDDB0DC46E3F13B16DDFCD02D2B08AF4AE20D689817B2731D715EEDC172
      326CA192781ED131458F78820773D04B4FB1C6D62513DB5BB0125E63AE03D08A
      3A15AD1C62302F849E5F6B6726456F62E817A037BA0B206DB4D0F1A73ACA99B2
      2796D7A36C6EE5E737C815DABF3DD248F90D568E245DB165035D4C4C8353AA5C
      D13C146EB034A1D808325A6C6FF1CCAEF3ECFCE20F8304C71514C9E2F1589A73
      C846234D1853DA64F52905281D083A27615F100C3564F7365FAA37F5693CCF83
      195F4B81280610F4397A6A480588D4C48F832BAAD38491D4CBBA5AD98AC89C83
      8E699655743089C41E2ABEF050D17AE9878A8F059BE27B695394650FF4495F9F
      B339BA43768DA72E2D4B260BED6A35FE2607D99D06D13CCDE3F3F62A079F8847
      C785081F0ACC5F2820242945433F06DA930B9938A14CA36130EBC72893B99D97
      70579FA3BE849137F79E8AF20C83CC2A53052356D97E6F1B712927637F95715B
      19788D2C945B06EE325B1CFBE87124DCEB78FA0EE1CE31FB7146BA7D71EE52D4
      F66CD2C0DA074F5428E7BB313E7A68961DC73B4BB67BB4C315725270AEC69423
      A5ACDA91B8C6001F325EE9C1C94454B891F3D38AD93FD6D45D569EA638D1D6C9
      A922CD97F842AB67A96652A1A197AF2DA9B7FBCAE78319AEBC54221374B5C96C
      63E586F2295C2FB7DE6A6197C955A64390131EB96704D724537DC454B263442D
      1D2722D4168C0F180A788B4219F07B25CA89E36BB8451C99DED4D265C06D242B
      4A2730D960563F6918D391A82F389618ADEF65F6667A8A8E881758EE2D0FE2F7
      A9C153C16A61577B59408F8C74B6310DCB1B70CA21ED7E9A7BCD7105E62B0F7D
      371895E3EC50AC7749A4C1522B85A22B7D54165C60244E7380047BD58C2D74D9
      8D2D8D5AB84CD2628E676ECC53708B56F23298F029144EA74FEA0E8D858859BB
      9EEE111CF2B9D905F5950B8A3D9786D83DE59A2A38ADF365A436321D3212A9AA
      04391A5EB505B36997FCAF1B4CC4AACC02A1C264CAE56DD7C697AF0DAEEC464E
      7990FFE75A226624D5AD1D68F9A479DFD9D2CC98816B6533ED28E6C8824457AF
      3023AAE04FC553248FBA6AE56A62F59B18D1E6EA5D4A9E81AF67AEEAFBC3F38A
      6F3598C4318DCBA7E44298FB9C668A3D6AEAF11476A18FB73AEA42956830B312
      6D4EE703723A716ACFE50C596D921BE2977953D400786A5C503D9E3C5A2B8FA9
      C90F5D5AF655CCC1FABB1CDC2264F7666FFD4547ED5ABC874147F0E65872A538
      593B7649AEAAF551C22C8E249C028DC1411E0A9FF7E1FDE5E657B510EF2EFCD1
      3C748E655820E7930C39BA3EA301C9B04251094E3AC580EB8487F70A7574CA5F
      834E90BA0148AE360A71492591FA1C9A7F8B7013B794D87CF7750271E170AB1E
      4ABE5A24923BA61A41E97EBF4817D70F9451DCB7E9098369C088218FE15CF1C6
      E8CDE08C6C74746AC3F455E0AFC05B7730240C2E85F46F5B1D73CF32FAA4FB41
      707DBA5F484667A1F8353FA2E52261758F0107B818D62A2EE56B6F57A741DE75
      6A28647AECAD68D66198AE28AB1F4006259A2B2F22293978C08A4505085B1C3A
      6F70B06C9E702321BC9F9A788854F7F7D0362C78F830F1C763A51658ABE97E1A
      3233C41960D69CB47D512C327D9316E2BC12784E416FA823111F8628CD9C6A98
      E505C466490CCC9A1AF67FC5CBBCFC272B7E66BF12D7BBE761392A9BB8202D11
      3391A05D9F12EDEF98512AC861545C52618FD8689A96BCAEC9A6265A1E88549E
      2DBA68F951EC35A013922AFA68F5D4BD7A4A6DB5F2678A5B00D571B03A897512
      974751413BC8190AB85855AAF2798F17079C052EE76903152AB104057AD87091
      17900FBD18B727926FA716DE8FB2241C67A150A0C65128F35074B51059808691
      09DA6D54AE6F4AF155C1A830B4E1C0A7E76A251E296BCDC04FA529C3AC33C237
      ABC2565CB919AB1C701A8EAAA6A22FF41339BED4C6011A4E498A6598ACD52DF7
      9DB3A88826175B90811556A7B04EC1CCB1413C9D72087F44E647D8D9A9186B5E
      F547DADC26BEDC54F3C215324C05130A0AE57448BA778DF2ADF2C2806A6188E9
      2C06C2177919B86B9F5DAAF308CE07721D62DC3756541D72D11A8E939A70FCC0
      9E4CDAC2D2490AC860760366CE0938AE0070F0673355815CAF9035EB4912BC13
      E2D5393073031D6FC96A4A21433E39FFA38358F5EDD8D59FFECE0DDE389979DF
      D1DF0FC341BAEF1C1FA77B85E064EC09C181A92B58DD23295A33A3B7B79659FD
      BD8F1D34F6FBD8376A7F802D1BD7DE4D2367BDAE195588027C003339B89A5242
      A7FE0216CF209C63512F3541B975DD6E0177CFC6CE39C6BC7C8E28D2CEF93188
      B21D5029B3D01F88343F9CEC909109E56747DA9DEC3E6194635AC54454D2D209
      23CF451F646596DD98728925D57BEC23E67023194E8E81B173399A2ABF07304D
      D9D6DC9A8311C11925ECF771E3811127F0D41C36B10B6B1E0D65FEC28FFEB43F
      4FB01EDF3B2A4FA1CA14D0F6209F2403D1B09A1350C361531801956F77F24AB5
      6B1CABF87A2AE110A8782D5D23669E62B126AA41BA5C2566E510BFFCF7AF8A57
      341AF65CC4BC2BDA1F390FD36DCA1215A9DC11E17B344B826A0039C09311850E
      B3FF0EDF258AE3FF087DB7669C85860F3976A2FB900D992AE3C6115C4298588D
      FAC0EA016593DF5962D9EE6B58B27B8A4F3B72F92F67C9EF0E0D537B96CC850E
      EE2FADB12D11A3AABF28730AA6E553B5AB62E6B9B42666C2A88A8A987685AF69
      D7C303431B8161058B9E957F96FF4275F755A64FB2BD9208FB99602771101D10
      D0A0648D989BECBEC132BAD80A4562BA54E65EEFED3B67801933D92B99643C10
      E15096E7C4CA333C683E1617EBA3D2DDB08CB029B951C1FEDCF0FFAC7A0F1E9C
      AD482166733BC3249E712110DC3CA90EEA2CA602C4B0C9C9BCDC5D41BE1F32B9
      F07B9B4D6D26F331968CDED5A65B4AF9E38AAAFE380A32A0770FBD4743A3AEAD
      5D91652B92D59B8A384576DBC5983B6956B0079027156842F4B96ABD168B6191
      9539619B05AE853DB982B1BE7CEA703B18D846022E4543A7DB7E22FC4B592890
      2B6AA79C1E77C6BE051FC8550F435F9095F1FB0C7458E659D62FB5C2AD9016EA
      5154936C1746CB99AA86ADAAA333C74CE7D7601208E3E8B2C39C5DAA2F7DAC4A
      93BF8D41A8D31DD321C9CD9330D4E2CE5B536E6EC6A7B661B158F92F834C5D86
      0F487F5577CB3FBE19E26E32F0C38BF81D999C7E0666A83BF69DFC6EFCDEFC9D
      47334392EBC5D7A4784E72BC0619FA184DF7A03ADC513ED150794E6E0FE0EC6A
      E7209F14D17AB3BDB567381B0F65E211BB580B9ED5CC2CB6AE6FD87764370D32
      A1923968E921741C56918D9959C157E6F14BC367C6F58FF9F48BF210148B2962
      7A0F4F8A79072885413C15BAC44F140F0B994AC57256E6E319765C07DB5B21FC
      3FD64B4666A99AF53C0E4DBE9192740DE77BAC4825A14D5E1AA4E85CCD6BDBAB
      0BB8CABA2487EA23277EEEDBD12BC1206C96C4D88EE4D01187E34376E61825E3
      E5459499110A3FA236059C731B635D76BC15ADD018DC434240AF3FD2124FC5CD
      B92D09CEDEF696CC0493095CB9FB8746CF571D194B7C63BAE444ED9785B4E035
      3B232C821206FF41A7FEAEEC34AF172633D65FECA98AF0F04015A84BD33ECC1D
      D3F9DCA93A9531060EC3D2CA275B973AE45315F6A030F97AED1B2FAD1247F5DB
      6E6F6959836106E498023D3A1F64F3044BCA4B53CE2EC5E9C8D2FBE8D137EA40
      FAD28A9F97A8944F4EC414345BBA2CDB3ECF1995F225734F9AC531EDF0548E7B
      8E7A4C850439177957054C069EA75439D3D7B62315C31919353456CD8AB8A14C
      73C6CF542B94DC15CE687B2B9F5A3AAD16667EC7DCCE48FA8EA5F491B94CDC60
      C50F64AC51A6984D6BAC0E89E16F05EC2F3BCCFC9D7FCD11BE9C9B0A98033F58
      6F145CA02A7ACD54933BAF17CE6B3F159F68027664894DB22BF7E31BA53964CC
      894A9D34E2BDD8EBCC6D80382A052B9BEB2B76FFEED0C182AB7C38C7A76FDFE2
      CC60838E11EA8281BA746F69852CBD475E9774DFF9DBBE73C0D4FFD5B9148B74
      B96D8674D202E338CBE4280C77F6F56FEF61912AE6BD89AE10B9E9D0F79D423F
      22AE689E2F34AD97E56292FB9F326AAABC31B52654196A6365C92D91ABA6A812
      D3323E1E1E85822853D47DB3A2AA9E049D7F4E5502E84269364D851E5D3D7729
      879CFCC879CEDAACE097B6F0B3D40808B849C670710AB0B5FC1B872C33AD45AF
      1395BA7C7747A354200C53E11A7D412804BD906A403F3442DFA46AD6D5C030A8
      6A1E8443DA656E4D90EEDE83CE4BDDDB888F7DF44A79530355142FE5B2D2430A
      3BDDD1A3EE5064876A4D06AA6C816E501D15020A1F889DB0935487ADA9F02FB3
      EB0A6325D3A9272302D39877610EA483A91E5C82D2C7ED0389D2F6959083D380
      496CB4040D82DBAB7CA69F2DF5EDF9C09A75156FF43C1103291C0EF3CD0DCE1A
      DB931EE2D53CCA8753DA3D27841D1DB711B711C1C7DE8E38A1508B319CC265AB
      280A755EF5A2B265634AB243894F233C6267F3C828FC2DE70F96113538A5164E
      5CBE9BC3897D07BB93A12C02201C278408319452E764E09F39F6105E0037B094
      05F6FCFCD46AC7079A8477243AC196D170FCC36854EA1EFD231535B791C379C1
      247626E7DDC6303481510B2812348D52976A939D06DA500C3D745ECB4666AA79
      1581E3989C22EF8ECE2F40E3F5F522D50139056C2EF30C686432D37E872B06FB
      289A95DA1089EF4B844B6822C4981D8A68C53A4FF13CD179BEF30830B14C29C2
      15481A0141A760FC8F75EC8094889AE2ECD1129B8978A64A5E0C63DD28D2877B
      C44C617918CB58EEA4F8F0008DCB9683E574F7F662400F6F3D3974D2EE66E083
      3A02E0294EC67EA99309D066725F15EC67AD253BD201D7B160075F16706EA22C
      9FBA73047FE301D2BB1B24DC9536BAEAA134C162F9B954652D9DE7560061349E
      93703D253A35E04E81011204AAA122E7B7394C936A15AD89F9FFD97BD7E6B691
      246BF8BB22F41F30DC271E4BDB342DDE29CFCE6EC892DCAD6D5DBC92EC9E7DDB
      1D4F804051C20804380028593D3BFFFDCD9399550029C997B65B367AD931234B
      2408A2B2AAB2F27A0E3B271F371CE753A40B75608EFACF4222555736F3A43475
      A61860CE1AB95FB38295CB85E439F931F1745FA190354A4ABE389AAEC796C2C1
      8F34173FD1CE3C98EEA534815FA147D07B85CE6D23AEA7AC495214AE0A5189F2
      8C56F72A5DBC924624CC19E1DCD230F5AEB0B66E70875BA5880F31AED519FF81
      69389882ED53F3E8A2FC385896A799907B72B057A318AA515640047AE2578F03
      B687B10869296B8BB0E394AB74DFC3FE7531FA331272A97FEF8DC5572FF136F8
      48006DC05D1F64B3E10E0CE1A7B3DA9C5BF830830E7B7559F1DFFBC50BD720D0
      73AA2714C7E13818A36F7EC237039DBE5B09CE6B1043BB67E890A0A14DCA5018
      B402BFC6ED945226C9A7E7AD9CFC4C84531E88F44DD72E2FA8E1ABC4180D6E8F
      4BF3020A87D106C89881B32AE523151B458AEDAF23767BA44D4AE32F9BFA6A8C
      7A4DE645666240294D59699B0F6C1947542051CF8AD1CB150FAB2EC4C50EE887
      A4640BA696BA9AAB215636EA5D945AF20FFB67474DFA71284AFD300D7C4E3A28
      0C3137F172F851CA4362B3985C780F00CA6ABD3F3091AF38A2746A26DECFAF0E
      FFFBF4F916FFD7EEFD02AD6173342571C3DB7F20D2F4F69F2DF36E557768BD6A
      27C20D25A9B042DCB46143FF1E5162C556C5E9A0862B9D29924BADD0EA283F2A
      E9277A8C3048434B4850393936CBF44A959FB91A602B325F79CC4EAD57168253
      7C3984C97B7431B0B7DA490F2C841FEC84B442DFE27DEA19BEDA296551D423FB
      910BB3F2E87D36EB6BB20E2AF5FB6AD571D996B4CC2C205868F24E404FA13ACC
      746CC270312A46DA62313551DDDB8E6E0757D297F9360C53260EA16DD0A316FB
      8124111E7952DEFEE37B527BC7A2FACA19B28C481F3D555F36E03136F70978A5
      EF1E90D779345B29B87B141CCB454B380A49FAF8538928DEAF070AF64B9117F7
      83209D27652C78EA87BCA5175286EE3B4AB752834FBA743540CDF6313E888B5B
      C53BE1C2BA47ADAC56FC4743970942C7AE63424893FB9C8ED56E90DDA094130F
      C32529F71B8BD586F313A9EB976C02702A855FCBBEE66A60B44E70899BA2E559
      F804FAE2C5BB4F52C4D571DE89C1AC37EC66A17EC56AFD7F60467F7E63B2DB5F
      BC7B2ABE56F1D60FE2A02C2E419744705CA78F9D5FF93B6611C75460E7F02B40
      003CD552B40A2F8A039D4D4BD681E6521DA1030D604E007CC453F601AEAABBB7
      3A3C28ABC3B91250FDE8A646739B9CE6FCA84980D5F9C5A601AD51DFC854D83A
      712E3C951AA9BB62CF6DA7A39095E715A43D94B8C4F30BFA2AB6366CB15115E6
      6F8192A95260B8A135E8D1C4DB3D3F3D844B7369E27011026773A59FDF3F8BA2
      987F0650C02F52D7BB52CBB554CB9CCDFC8AEAB84409253D49FFC4C651DF5476
      3174AD4B7B6BDE95FD0BA7B4EFEB72B803094ADFAB05F5AE07E40E357A12DF6A
      C5F4EB4498D1F9AF3DA9272F8398DAFAD3D04C60C3B5F39465358D12570FCF6A
      2BDE1FFAEED6573813780D40465F6F1DDC731670418E1CAA4DEFF5DE69D3E65B
      0FCE8F1A24B6BFCFB99A9E03C633095877B9DC365F3EBEB57BDE150CC9A24309
      267AA3A42A53A67B12492EB4F1E2E4ECECD9E1C9C9B9EB57A06F474DED42DB82
      B5E045114A7E585A11163168E759022763E235CED0348405A44B02F96B93B87A
      266E3B46599003C57591361AB5C53F0BD28B0469AA4D69BB34E4C1340E3CD4AF
      782860F10E9E4C3DAE61D1C6087C89AD00B3FDD2647E6418D66659198CC611C8
      522A87A59F46AC252B823DFF26B998C3ED01A010C3F33BE7294FE7A0D58EB204
      A56A71C8B49C42C9E4B2D14A7E8ACB2F944E53737209C04EE8B77C2E552F4F50
      2A98193FBCAD5657775B9D565BD93F5DF96A15FAF61CB5BCEF6CAA8F6ED62CF1
      B3201E24A859CDA054BAB4E0A6D51E8F4AF6DA369C59F805580752027CF7E8D3
      C1D0F581543BE4A68463B0C9F630BA8EC2B95D948CCD598105938632C0A07201
      99EE81F16D611BCB163BEA68292F665ECA3EA8EA43CAB274758124B9701E70D1
      61346135263C060C3353D637633AA67E826C3F1D509764F16EA005280A225456
      BAC63255B81062E5ED0ACC286D5C55DC76EFAE80273EC80194F9174F92277B40
      1FA0757173992E24F2566014F79C2107F7E04FD852FFE5468A0703400B924601
      6D151BF852EA0D36AAFE85D404902ADBB43C20367AC4E1D5847B1C56EBFD03B3
      77046A66F86D5941C72A5B468DFF9C4F67A4CE1BF7028BD464D1FFDE407F083D
      7ADF09A0C3A3A71AD3FB005F748FA8FE47F940399196226B95DEFF28011FFBD7
      74F2E664A256EA516BB2F07F776DFF9254C4F9FE59FFD9D9D9BEA0039DF49AE8
      25F3D97934E1856555C5AF402AB9CA5D2AAAD2F7464E04193896F7930C4DA0B4
      DB203FFB24EE9E6A925721DF5DEA2BD1B96A027AC802FBC957AFAFE1CBC122C1
      CD5EA17957769D082E171856AD25D6F2364E6D13D81D5F418C483813687A9D4C
      5A9BDE8E84C7767FE4C2373EA5FC71C4AD63F9E57C3289D9D82543D7B6E8A22E
      D69E764B18EE4E52F2B03A961B299D034C21B00C60CD4B9179B58164E1E3B9ED
      9F6130BE687D8D9C95097942DC7C1625E8B697768BA4E2E61CEFBC3912178775
      44193F09C9F70612C6056A92B8EE9DACD74A37A1807790033581BB01F221C11F
      800DEF5A63EE5F2E01F30744B9B4E4A1313A0A541C3AE9B9B51ED0E21D3A9547
      57D234062949932CF1823FE3ACF8CA15323CFB10A7771BF7CAF4AC6E7229E7E7
      1E20DAE0528AB8D0D9C96BDA2EB7B2F7E7FE8651C98731DC0F3DFAF9E24AE681
      B2D837C664A6948D46C5F275B4B2186B80FEADECA68A9864BF6DE22BFF066DEF
      1AB01C80865E57E9BB697A502F425FC28352ECACD5B9F0A1024A9BE0BF9C170C
      4DA651469EBF6C3E5B5547B85342CB7E8D8DFA632BA92BEFC07A22DDE54A0088
      4F0068BBC4296069372B2FA2774FEE27B0DB252D6005CC144C192C1574B5259C
      EEB10EB89B28CD24CB7D1D6FA07EDF4251E6A53C346F165C75F2232264C5720F
      7ABE0CBB9208B3355D3563B0BC70CEE05E16A83C29AB45743135DFF34C905265
      91DD13B9803B1525F35593D18717A723AF2952B4C9AC766C59CFB4249AB27906
      9B87B66D881D5B850DF77E20C3613FB7D5D0FA22337D1EECD19B17C01938BF74
      BD3B00B283E1B3493BA728CA03FAA0D23D9B91BDEDFA85639F5BE4198D7983AD
      223FC8E89CF5726CFE345945B43EBCDCB9A41C2CC785EFCDB8618B638DABC55F
      ED706954E4C38906DF66A4B4A456D4B622E82F8012B129694F355AD7378C9475
      9396ADF7A4A7352065534D55E391CC7DF241B83506B92FB93F3ECB4675E3C800
      0F958B0635ADD50266103A4BA53DACFCA6F535F9AE6ADAAE12742E47A88CF365
      CCF99E6FB1A866426691B9605C752139881FA9DFD2C7B0A7973E85854E463FBC
      9ED11D7AB07B2F76D81D96C27EE1B1154083CEBC28F633E9855742ADAADE6A29
      C16F15F50841F5CA373A1109DA8A95FB7B374BA90EFDFC2A57A499C4906FB63C
      1676512B7320357153578826EEA4053FAB7CD9B23EE459E266465F42A7B6917F
      E15BDD2C7009B868CB6665722B8C8F9CEBA3276AD174B057011842BEC9C65FBC
      7D56B367A460C1B0F65A2990FDA472152F78F2E77ADF9BE00A75ED852CAFD032
      A9DB91908E5FC890D0D3476AF45586E6CA7EAA4FCBC293C4073DE1DDB9658001
      76E81CCF8B2EABA549E665B5BE56CE03E028226D47434B9BBDD6923AEB43EA94
      25DC8B7621DD38928A0E17BEDEC251442EF5BCB1348CCC96CED031A9FE340EAD
      524B5CCAFE2DCF54791049D98465EAE99E35C262E52ED3FCCEBEE463F853B4D5
      A5B9A3B1EE6E4A717571B7E954C02BF98E779442AE286090A38613844047739A
      766F9785CE87CE175D3641AA0640453A6C21A063F67D36C14962CA81D06D22F0
      FD90835F485B34AB81A50717EC46BB772511BBA0B9E5A348548A41E3BC00ADF2
      7688D7C081220DEED43499443B2C11FAE585A4BC7D61482E5EE1DB775EB4E49A
      0B5AA4B6641C57E10E377868464BBA40BE1AF949D44F553F2DA01680A65B7C10
      D5688B23ADCE3B360D6F8ECA8610E2F71D3D2648777349BBCC257334D1A67DAE
      97ECE1BEF2104D1DDCE2B0EE044A8C9F47485556E225175060593ABFB85C58B1
      B4592BB777D0FA166BE43D2B7C01044FD58395EAD2286D2E1F114344279F8E6F
      9FBAF610562902374E77714211692DBD6E557DF9FAD2FCFE84601E7354696132
      56CFF25E740B6541B0ACB3B4F95BF98133514E4C7AC58AA22A2AC4A0EE9B85F7
      9F708CAF883EF62AC4E13C637F16EC4596AC26D32606D548786743A9B1686DB2
      F074B12CEFF84DCFD22394388A8C3A32B35BD565D971DB056587F28F12F19D3E
      3A99C79032F8ED78EB6625B62CABDF855B692895750BA93A86F2A1DF1786A50E
      8C0485D7D790A02FF1010A0BE8616D060CE249217021E985E184235A2B7946ED
      39B0747F969B935A2ED1EFAA3054A14A049CF150F5D66511DBA284BC8D23FF76
      A12F44C4AD868E6A2FD57055DE1B57825A5507B92943E2EB6BF62CF71C7C81DA
      2E1AAF0F5BAB4ACD0F41CBA8A5456B15A5270E1EB0822355DA572B7F4CFC3116
      9A85C87522F3F325715500B9E045D10E200D69E4A8C4DE5071DABBF9CB1F77E6
      0B632A1A6C5AD44D991CDBDA157B355565B9F6EA7C1E4952C96213E4121F5C30
      7FBD0A38336EE7944669F33ABB9D2BB2561BE9FDABE205875D39E9056205EF07
      13CF9ADEB17937CFE9C8A4F9FF3E2A7E988F9B28158535D0848AA7D32F3388B6
      FA176695C2D5DD6525F910E8FA5200DDD9D028D5BB899230BDB193604BA7FFF1
      16E8C9006863D9BE65C06A15B0B73CBCA5817DA946E338A57BFA74BB70CCBF6C
      BDC5AEA5FB7B6F9F8C876F69C7FEF39E999F444FBB034CCFB0F3094B8086FDB7
      80874C5BA07887CF7EC4A288F3F6F0DE9581CF7F136B037BCA7B4A8E13138C5C
      E22FE8B885A6D49ACC3548655535D08810DD2EFF8636280746863BCF89063180
      DBC646FA8546714C8508D641B966F38443827E5E3BB9889E24A1B03BC2162D0C
      D049A4EE4B8CBC7A41A7199D0EE98C696D2A1E931559999996BA6529FAAD9B34
      F4ACD01522F36C5FCB4D760D8BFED4F8F15336C503A63F88D6D7105D61B35A3E
      21B8FFF0D954688060F3F6D1F085C2C4886505D0E99A49677DCD9E9F4FBDFD78
      CA69C76CE7F5937CE15CADA808EFBF01D3AA169B004B939F302F186D36CF95BE
      AB2CBC4F938B946B99E7406A5D587276A9ADECA20F4CA4C46985C4E02BC9AAF3
      4564D5193E28ABCEF0CBC84A54DFCA0EACB6CA0978E142D78C8540B4D418F7A6
      3A9245693AB69C6AA15C19B368EC31A061793F3D8524266741E4AA9C1836A4CA
      6AE4DA8F62298D5BE2E0B531E1650A5EBDBDD66AA4DA5AFAB594496D3688B391
      567BE4CBEC9165817EEA36298DD6DF6BA794DFF0C06639989406309281C8B890
      2D9096E3DC60DEAB5E6BABF5AE49FF74F04FABD5DA94748A7CD2B6E2DA00AD64
      8CD9ACDA90283187B8251AAE34DDF3CAD1A66553BAAFB9202A52B20ACB3524F8
      A94BC27508E2CA9DB3AA18F96099A3DA76999946BC4AAACB68A5176CC5C83215
      BC634BBAA4278E397E826567A5299BABB2A7B8C150761CD63D6A85B15E6577F0
      4D356BEA94C3CFEF7E917D51920D14E58E66847B55434C11B640BD85C6548E4D
      66D8E119F085D3CC61B72EB15AE9862A9F24AAD49BCC62D41CF3CEB263C3FD6C
      E131DD98936C55DD877B92BE9CFA8938CFCBF7B74FAA20ECB64BC03A12D8FAA2
      812A0E42CB7B294E832889BC52CD70AD1C8820F34640D73D9A9999C4D592F3A6
      E4124A75575CB29D7C7EAE1B419E7B4E5AE676A5323E0897C5AD7734505AAA08
      99ACEC874A59E55DE9781B72CEF12EB88EFC25B68E7BFABB362BD15A647C2F49
      2265921F50E6F22DB9E53521DD1D4DE753FD565AE6977EACD549DAE3A06F2DA0
      BAE821E9EE6BAD09C7F4A69D3CABC0EF27067E47DF76E0777DEDCCAE8AA7BC9A
      025D4D969F2592D0CDC7AC9DC5F5AE478B0BB10A39197D03176F08ED219B89CA
      29C46505657FBC5476D46BB5ADAFBD8C980A52C38A4554C4AE3D79A30A75B759
      12342C4AD696814EB5F254201D5000F1F7B9B579692D8D19CFC49FA60AACA0B3
      66497DF80BF3E857730789A59C0FED98D3BC0ED777E113351339097C7DCD3B87
      0A15993BB5573849E4EF9102D75609892DEBE132D0EFC86B49920129E36441B8
      FC35A2155DCDD6C23708AC159754569A336A225559C86753147F3D453DD1184D
      779A08C05B2C70EEEA9305DFFA14D9AFAFFD26E91FD81ADA02D45CF6AB2AAB9F
      79928DC29791B236ECFC561EA90429606B7AF9A3334B46FCF0AEC57CCFB2948D
      D354706BF2CB6C9E5C7979EA393A647B538CAD02E9EC1E890470F7A1BEC4F25A
      D9A90FE5373107495A76AF327ACA7456D04994DEAC8CD66A2FD00764B5EC3B9A
      846330CF5C30668179F40E15DD8271BBD83AC79D102B03F3130DCCED6FDDC024
      BDCD05978C7604BFBCA4C315EE0B5A394C7A0B3839748CD022B3FD64167C968D
      2AB2948A39976FBF3049749194EFA6E8F94000160AF3320A4393D4EEC43D9888
      65ECE0F81E14932D8716B6CC4B6C572BB7CD6665A7B234E4B32213DB3F5A33D9
      1C68C57B6629CC4C684985D6D7005DF791ABE6883652047807448BAB0AEE3DCB
      6775A23E3071E2F471D0D0D0AA14338591B719F47BC13C7125FE2B20F5F7C495
      D159A0476B636F51A66F9C4CEF43582FA1762D3EC8F89663C6D3DC048D657E2E
      6F4F296A4533F4B7164AED15B3506C68FE5A8E8E4E384A9D09221F6A6981A87C
      CF044BC3DBDD479444113DD6651ABBD63CB2F673DA7AF399C4A56F12EFCADC6E
      0A8B2E0DDFD17E4B3248ED0779265BECEFC210E40ACFA578049925D78C630A6D
      3FC042DDB2F167195D492FCC053C6905536491F196471039220CFE76148AB97E
      309103B745B11856CAE3A319F876621CE43E7E72B891AEA3856F411C577DCAF7
      6A870F08EDA11D2FB841D9DCDC637637BD79926BB53DEE96EB96A5A354F881F3
      4D9748E62FAEC6A0E94F2EDDE2C2FDC2B2B6FEC9BE2FD9E3773EA0959A0E339C
      1B5A668A036B77121FE01DC76F94D3B99C223BA6301C5189D9FCF08A2867BD78
      B7DD1ED0CFF6A8DBA17F3AC3DE88FEE90E063DFAA7D71F6DD13FFDDE362E19F4
      DAB864D8EDE09251A7D7934FE3125A5A43BECDD6F6362E6AB7B7B77055BB43D7
      E1DFEEB0C7D7F506FDC1EFBAD468F0BF37C4DD8EE7BDC0FF54CEF4FBAEE7EDD8
      9EC2D57E94FD2886A65BF8760F55C9E0B17257EBF6F1D66DB960F13FFD4BFE73
      CBD75BADE02A9C9F687A8E86469960046C5830A53208EAFDC55B0C82F212E76C
      E32323E76FC809B5F91588E3D247A709D8D063F66B8C56DA82344324D6050A5D
      C43E6070BC050B6065E73E20C897253702FB2DE72BA77741099D24A54F57F8E3
      A67011DCCDD564A664D91DFBDA11AD38E8E962E5C20170ECAB08037A197995C7
      0A82F20CD3818EFA6AA1945E5666A8AF8C995906322476147C406B1871B1BA82
      D2F5BFD019230A15112BB8D2BEA09E30FB90B6DA65695A25FB93F1213CEAA22A
      FCF5EC2593BF1DD28D9A1E864476752E800372F727B97B19CEAF3CEF149DA815
      BCEC0AE0D679AA41027AF4609E973566E47A0BDFDD3C5FC5E03F31064FD77DD3
      317850E51D436FFF072F58BB1574C9839AA25E13BE53C4DFBDB143E19D5CDFB1
      EC27CA600618D7E76E6E9EFEBBD554F49B1B25FDFEE61E50F69A0C7557E27D7B
      E94DF25CC28A76B40FCC24C472DF7857F6C603B37060218D031C44A2E119BE51
      B1B21684F9112EE9FF0E2B4440E38E6079BC9E3DC3F2F43690B2DEF49E299EB3
      2C5CF7A63D2B37E580D583940B3F322D39CE0B3AECDDE12AA05E1AA0737133FE
      DA9D302CBFED915D8C832437D9A333A6AFAFBD478263C394E525F2B7B8225674
      F7B7D154FA686C88F425DF3231375CEC55B9456EF741C3DB0897E2A29B528333
      55EA25CD389C2C943B4409238D87D564C6A3D3878140F1D1D92724F123D51D58
      B51FB95CBFE4B8BFCE825DDCB02128823EB46A71D1ECEE965F1D5CEFEF23C8D1
      C581502AD2F95EEC8F4D9CDF39B756C75659AC5511D346D95C67037551D5BD5E
      E0E396812D722CD8D243816973959896E58297FB7B60D9322C395F48E3824AC5
      E872A83CA9A862F9AEE276A6309DB005A5592777CD1096C83B4F612832F8C26A
      577DE4AE124F1FF4C8E93C0B04B001B8F1CA19A7B0A7164451A1EA1B3FEF1933
      FB85F6E4EC16C10C9B8C7B861424A0AB5600D2E526E4146A857BCFBF23BE8D05
      F989AC379D1C81A69495A07DCB08B348A7A28D6D7D2D2814ED9F5C3B69BBF019
      B049BAD998585153B6BEB7BB7F78680B8F7DEFA7D3C33D0EDA7AA7FB2F4FCBD7
      71D5A6A56B33407CF6B3DB85581773532A4323425477560EAB1BD7C497199453
      E40B60B20E2725B4DD06625AA94CD4C6CAEFBB79851C5296AFA39681EB886020
      52C7953E6D5BBD615B57D08F09401BF765B6A8DCE25D81F9B3106CB80DA70A23
      C4D494EA7693F95197BE7EA56E1ED80D15287191DF4A49E8499DBA5ED3C67459
      4825BC381D92C5ADB701252DB8A1AE024A10E16DD73D7667963202EAEE8F9B0C
      6A0AD55202962E701CC95969C2C774F76BB97C1B07C9DFC8796756A4BC3A43AB
      F3AE5CCAEF1592B7E15028ACEDB9DC02A0509CC853D84BEEA917D41CB3662A70
      91F08CD8869F6377923A2A35BE6D91BA43805DF5BF49B1B0BD74E32FEE28B02F
      D96A24DFE27A979CAFEEAE02305C5CAEAF19A078C6DC7417044C45C67D8BFA70
      B3CC4CA277250AF9CCF50845CB49A9824E5A2169308C36268186319E976EC4A6
      3C8E7E666F160239318B615FCFD095A5B109F9E64D6BBA49EBBBB528168C75AE
      6FC43D854A8E1EEAD614252D6B294D3D1C451C420BCE10AAA589204E06BDED50
      9A7F1262EBE79249B36C093C87C727E79E2244FBC96DC9DF27F0A96C6D4C1573
      B2CCAFA940E5AF282B395F575C651FD4626A7E064BD6BBB721DC00F4A7B25D6F
      AE8CF965E57657468D927371A164D8F27130B8EFC3427766BEDD1476FD1E57E8
      47FC6269CF609BDA8730523CA97C17D532498716BEB05BD4AA5DC21BB97764D7
      3E4802797BC340B75D9177BF6EE1CECAE2415378C180F6E8A288B2A928706569
      E3AE80800530A9A8174545866EB64F52D8BE5AFD2483D05F4496DB22B84C23E1
      986CFCB7C92D3163837567E338752F2C0D57DDDDB283E62EA1871DEDBDCF5F45
      75F9C040D459D9A888765158DC91A21FBBFB189B16F8E5FD322FBF4F19421663
      9272D231A022CEE5F5B5EAC9DC64D2BC051715ABF5933484A4EBB89061D1E75C
      E01D6A2AA142AC0F930A0F475438874A8B2374583A07E507802E5CAE7BFAB625
      A908D6A652F395F7C9AD5D60AF5A5FBB2B692B39E9B07FA3B6F4AEDAD2E2FE2D
      5AE274D3DD1FF14C62B3FBDE2C9E5F444955B6AE09723A8FABE41BABE3E9A1E3
      893BB9D48004711C76F0FED9E1EA0C72515DA82B7B1C140C3DBF6CF2F23E75D6
      E2BF7BFFE7E5CB97422C43FA743A938456693C4F055B6342C675F9A97FFB0B7F
      ACE528A72664B92FF24414299639196DC95D737B91206865FF7D3B1BECD428C5
      B3DB61A4BA5756DED20E9B69B012F8C4F68C710B37A7CF30E303796D2E8252C9
      66BCDF0966DBE42135F7F5760C7A61BB95209170855F724D25CA87F80C653E42
      E7317B393A8C00B6867EA2099AB82B76849843B2D85618141F5E79DF9B841CF3
      9819C6F15853C3161156C6C9F1CE912BD4A9C93EFD7D4B53D6D79EBE8CDEBD82
      95461B2B09CC6327FD9F3D722D0E0DF838FDBA4386E27AE4513F950A79ACFFF5
      B53FFA14F304DBE12E7E373748FDDE053C15A5A3687EDE85E82414495522B78E
      649C8B0470A64C851B5621E799EF6EBA7F76144D5610991F51DA12FB3389FC1E
      7379BE2B68F15788F4AAFB9C60AAED20CA3ECEA8963F3FFDC5CB6FA7E334D60C
      F522706D20421677C73160AAE41189C8C88E9AD1BA95008822AC48160210D569
      56B245BAEA14F6A866B33832CA3829B003F4ED258A0DFB4F53FF5603574827A7
      D9458AB8D6226003BE170D200E6C564D2C7C4990B24135F6832B2661C95ADE86
      04EDB51646834FFA641E873CE0CE713356921696A90CD7AFAF69F58C79E773D1
      80BC653F6BE1BCB9BD2B2ACA5E71F2E8044A416EE908FEB8C2C1563ADAD4A3D4
      023276B135053143C021CED2A428C3A3A169DAE22299203B134260BC2C7B2E05
      A285CC18DF6952D545787B5F07519D19F8B664C9EEDB59E34B698ED6D7CAFB20
      C408B3D9F849EE9A7451B4A7E997F0CE5C5966C46540CA4A9F119EBE9AD31152
      6E3B083BE00AABB0AC401A53185D47E19C4C7ABBD498B26CF1F37271F5E34E84
      F7DCA025D354AE71BA9F5EBFBE266B9EEFBA51A95AD5B954C87585A214A00D9F
      AB29EE7C8B932DDF4B20230D57E973C7D1E23DEC489CC0188E20B2FD4D6EED68
      9D172D9FA6B62F55C9484B31BA2D2CB5B7613A1F5797A02DBC347984F584C238
      2E44E39AB62D6FA3585F5BC2F6E3E20E49E6E5F7020C69B60CE5888AB8E4C719
      ADC65B01EFAC3E8177B76D36913C9F84C91512010FEE8ADA54DF9138E96157E8
      F41FC1505168F8CA134FF72574D00F3421AB4A936A4D686351520DA7356DA8A0
      149BEDAA2CA1C522F02BBE5B000841278E80E830C0819EBCBAF1FF83F5EF0234
      25DE91DE9D6A11D6C2CCE18D23E141FDCE6BAF56FE07BB88CB094B2A60506529
      45AE6A6BB50FCA7DE0CC4807C9C1D1AEE52D70634FBF32B3552951C99D68DF53
      AEC26D29EB6B79C9145BB50B041D6A01224B427942A89E5E59EAE785A7D2BA14
      9BEB4AADF560FCE0B2F280B83F3FE09D3BE0EDD5A1F2B10D731332A6D9FED64A
      1AB60B5C25CD0A2056F7D5DEBDD201FF4E24466566D85C0ED8D0CFB05835A680
      A8B12F684FD2E149572B5910E793505B740186E48B72BFAAEFD7C80BBCF2B3FB
      C25F38CE6E3FE2C02A9254FB03EC3BCEB7A1BB5E68B77E1B0B29275B3ED16CB2
      F436E0E1ACD54A4BE2822CDBBCFAD476F72B5C7AE04B5398FB068BE28EE8EE72
      9304C39E0ADFA126E5B8D92115B0E86559C2992C0B38E939B5DF4CCF53E4E2F2
      5BF28AA628E0AAED067FA0536C5C46DBBEC8FE7E8A274715DD72A8EF2125F3E5
      550CB3C9B0AA07B5AE8BC1AD344A79523F761CF6A145F1089DAF6EFECB4A2F67
      95A8457CE6E03C6D4D142D1E8EC4723928748664DF351908B755DDD485AA54A9
      56C95BC5BB82A354EC52E757D12CB7DFF63D778D94DFC76195055B1EDF28F507
      E4B246A1FBD02A0FFFC16C1F4DF361945C79CFBC97273D34A9E0AFD5AED796FB
      AA506C5D158EE797BDB37DEB95464910CFC3F23C3DD0E8932DC3CA7979B2658E
      22EC939ED49FE99DABDC835A75C6D592CC3CA82F80E9BBB9544D59D65C6B795A
      7427D2C7BB0D612E37C9EFC7BC6FBCF28BCB062317A9A90F5F43DFB40D4CB02B
      5CE9380C28FB2D6113C68D5F31ADEEF14A409D964AD9BD0CEA41FECA4A51BDF3
      90E04590169231F836D6B960C7B81A85053674412C77A9239E41CC03AAC6A548
      616C0DB4C25A6778BEB26C9FB9DC5C8DC257390AF040B439AEBEEA71B08CD98A
      F8F25422DCDFF4F1F88581E72C49D4E29ABDBBE168F99CBAFD006A35BBB398E8
      4F76D60BF2E750A44AAF1C425164AB43EBE34A546C6EAA9A881147B94C8C4DA2
      772BB2BFF2388B5188EC69E51D6A9EEF9557C5B19BFAA16B44BD236E57E96EFB
      06497F5E548BB90E12A9CC0C7CA511037BA6362A68AD38584A6FAA756EF304DF
      73917001D2C1F911A7CE38C562416B2AEFA3E9761E5CE21C76CA99F415D70B44
      019D6EF8B6289F967AABD26AA8393944DC14809D24A2F3BB90FBB86FE84D47A5
      44EFDF3A1AB93B21E61BDBACA0D1EDE5DC94EAD17B900AE84949A4E87C6024F7
      128CC028E0BB7D54CD848D6F41334ADF4902101879DB4B95991CD77133B618C8
      D7555CC19DF7C9CB9D8A22A90649629E81C3B4718F50741C8C8088CB73EFCDD1
      CE9EF72A43E0A0E004F54446DE382BB2795034107F69EC307427BD655FE454B9
      540D4E0DD66AD587601ED98FBACFFA5A13B0FD78F86C1C1519BAC264ED0B0AA1
      91824A567EC862979D620785B5EE160C2A802061449BDE59904533DD3395E155
      A3A7AF0FBC8D31D91240A1E1DC26E0FB33FFE249F204B82B2E95B65CE37F904C
      5297F12011871A12C21C8B51C2ED0B974C9DF2E8C7EE2DFDF7743A7D4AA2789D
      9BECB9F78E1E3834EF9E7BB7FF2BF06E8FD3E4E32ADEBEEC403722D9E45BAB0C
      EC8764F59A9D1CF8156976B0C7D8AAB17F214789CF75D0A447B97B666517885D
      40C7F4F9FE59FFD91939B5EA9A3E7B79321C78FB7B07E75615555A95709C9720
      484DDB3DE6888A66599466DA9A14CC4EB471ABF4D35C8D8BD448D9CE45B132F8
      E638D21276023332AA6D186A6C96CE7E5F3FDCF25EA039BA58749FA5A4C72D04
      8964811145CC0921F196C34D43F89C05CECA81489E8D19C11AAEFFCCE6BCEC55
      AE587EA7F4D6C9BEBF401CB5C88C4FA7847D06C4A86EC05A61854853538A91C7
      E21C742B86652170409E0BE0CB6F134247F16797A5209F62AA1871B6939483F9
      80F3C4D32D547971168076CA4AC97C4CB25B6AD102EDC924C7EF190B1CAD19B4
      9E56DAA5E320FCC56E294D57890C4B82F8012946774D9BE8A1C78DBEE003D3FE
      FA0AE77B59212A466005526103BA59B2F028BADCACC6CCCABDBC00D150F60A7D
      7899AEB6FA8760A9C57C479B2D00AB363013A727700268BE805A25F1DC32EEB9
      0100ABA6B7B3FBC3A9A48E9BDEE1CE315DF6EAFB53BDF878E7CD113ECE77BC8E
      7CE730A40CB5BAB159096432431D9C8DCD954671F68AC8AB6971C1EE71D41627
      0B62A47DD473935689852B3A023E847078E9166B62CBDA1EAED75EF8DCB85B5D
      9A60989B113DAD29FB98DF79EF9ADE6D15B57FA173AE700888B9F133D4C9C0BB
      ABE019C8A3A3F13D92B2CF05A006310F24B62D1B1C450516F66493D71707BCA5
      D660F1AE1AA79870B8514298C2D99518B68A60115452194EBA9C955B16F1BDAB
      DA76E0DAD5BDE8123B70341A323E2E0E34DDC1DBE09221DA658AECC8E508F1AD
      35CD16D94649F2020CD72C8D9D0784B950C0BE8C7B51111C465A0D0EF912DDC2
      B7E40B8586BEBAF3EFDBF1D2CA5CAE08EE8E8CF4764D861AE098092D3B126A64
      33165AADC8134C4F9119172EC2E7EE4D74080600024998A132C721155D1CA3A8
      CE8013CB23BBCDACD4BEC2B93A3564ACAFF00E3EE8335B0A4F0DBB397D41EBAF
      5CE6D27D6037CCEA34EA94D89AEFD7068931A2119524945BB659D4687B80B015
      19D32903F16BC366F58CE130867B836F5C657243602313202F0B2D59B6512B63
      0D7866126E52104D2FCE1F674059C3886E6155229980AA261DCF2FD4845FF054
      DD33B3B75AEABC52206124756453CB9A53BE55ACAFA9BE93F07EE5F3720AF219
      E08A5F2DB010FC67110497909432829AE702C91BCD9D33C58052A236CB2E157B
      4096E3E70B6DE7048F191FC0D98877409A9309DA999E914BBB611597FBE01160
      732325613082F0F7D0F092AD869A4CDB839373347F8E8C9FC68A56AAA7AC4ABB
      4F804E276CB00D880C12596E719403C9693147A51A89C44C9B922BB41178BB2B
      72B168D46FAF92A342B7496F5522807D41D9CFC895E0AED98B9505D3412D547D
      1F54008551B5A148557E2E8669E6CC35C1792A9F02E6994273D39DA54AAC0C31
      947754CCFB858A10DBA3559261727D1BDD01BD7C3EAE69791B2F044D0297F80B
      E8C39556CE728C62A98926571C8A452CAE1B7A8AF9CCB52C0A4984D4B92CA6FE
      68CAA2C0A81D7761B81EC595FFF8F7EE237A677D4D6DFCF20CAF1E4BFC7418C7
      54E2DFB071712A6853DE5D55BE50C963D5ED52F36BF3A16683EAB9A402B52584
      5CB9636F4D7E08FA45702062BA45E94BDF26B8C52AB53EF6130F773A20F169A1
      3957EAF8C3083C388F1B568C97D28F715F61D8AA0DFC9EF6352BBE6AA0E623E5
      68FB342F1900D62416F3CDDE6206D6FAB1097CD87151C19C0208D9E5EE42AEF1
      BF44259D2A54D13ACB98080BADA616D25DD33964DE89575CFA8C9C5A5F6D9C0F
      CCFFE1C9DEF734676A53AEF684EC89377EC6A8FA2296FB4A88546EA882E346F7
      E40A4540264F933FAD96DCFBC57B76C909D8544EFB591AA9A783F2902922FF5C
      404256529AAD6C635D9047D25D959786880BE1AA9A456C77C2080459369FC1A2
      5812B1D6806D38D30D41C163FF78C10872B5A0D0F85132E7B51E82CB44F2B1D5
      B6B1CA17339B4569A6BCE7695D0519A6D74B03D45FD9FEBFC5058074BBFE59C2
      892FF2B7A282EA2AC16DEF594E7717937DE294263902BADB0B18A379E84BDE99
      1B44051877E273425AF2C9746CE9E7F17D320C6B0AEAF944EE8858E2D145C2D0
      1ABE036F73756B281290EC3BF9240553C592D8A6B8669CA55762B4266A9EB7BC
      FF4EE772EC5D71C47A0C0F85F3DDA80D5CA998F76F989FD28C012AB82BFF888B
      EEBC6725598ABE82ED72FA3AC1021116979D38E29A1AEFBF5E9F9DAF12549594
      F752C166D99EB1BE16D9268412B6858B19B12DE6E36A068577BB15F5E1D9B9F7
      974A3DB9C8FE3AC75BBB67F4169084B447AAFADE21DE3B4C3501CCEF6C3E9038
      CBC9CB24C3D4C2CAB0FDE89E5129AC2B99B3EA62914AC8C5E5623FB1C8B2406E
      5AD52AD6F5B462CBFA48BF6D673623B52905A8DC616CD1C02BB5DCAB8DE81AB8
      2A3CBD4B45CD258BBB64CA2CC2772ACC70E9387DA701F12AD92F1FD07134A55F
      91A28BCA2271BD8BFD2CEFDFE4615E768FFD433AD95441584C54C0A12E241C17
      A2ED2EFA21DFD6B4416C9B10D687B88397D57C0043DECFAF1C70D752693E2C10
      FFDAF167791B67F6CC0EA33CA08505065FFD4859C0BFB9F0ECA2412C5A7D10A7
      B9368AFDCECF5C7D5AC16A4F8BA5DA18FDD6EA93ABBCE9296DF4923B5F19DCA2
      690B97487F3300997E9EFBF76C5A1F69744CF7939CBEC704F34A2E9D6F2DB742
      3A5B3EEC3AFB11EF5A483EE4183C32197385C0B75508EC4EA9A5B48CE68FDBAC
      14E8879C29163D1B93F5D398BF37BA2B092430E45C1864EC054DF3607214E5D8
      101BBE41D9E373EFE0668C5FFE4C1B512EC15F505BCF9138A02BE99DB3342BE4
      CDFCB9F7224D63D8F27FF1CEC15FFCE7AFD0C2084B4761EA13B54BC89D19EB83
      CD5C83E35DB665FE659E25CCE05C06DF2D561A59318E3582592EB43EE4910B2C
      AA13B7BEA65397DF33656E52CECF78AEF2AF321DB4BA243F6B31BDAD0CD1A4A4
      8FC829277EFE16924456E00C3829314DCE4E0B21A31708ED875759780B94914E
      2F7EAD797961E8101768DA0D5FC1CE7862F4F78F9C872FDFC9FAD524B29F849F
      208F47011F5E026C8571000B45B374C8CBD94A5A612CF0C6F3F11870E8DC6876
      C915FFA6C2FF7E39BF30C87CCD8C0490B87800973F132B872BFCB82B931407DA
      D7AAC89DD58789A32B981651FE110489E56954BCDB6E0FE8677BD4EDD03F9D61
      6F44FF7407831EFDD3EB8FB6E89F7E6F1B970C7A6D5C32EC7670C9A8D3EBC9A7
      71091D7943BECDD6F6362E6AB7B7B77055BB43D7E1DFEEB0C7D7F506FDC1EF7A
      04F222F87DD7E7B56F516FBC4A6B1FAFCC5D4B38FB67BD628C3DEDAE7EF68CFC
      31F75775BF97F7D9FCB3BBA07035541E7F582A5069CEF5EA5BE760D04A2CEFE0
      3E3389B8DAA7728F7243DDFB852609ED1F955F57268FD5477446323FC53E6297
      BB9726B83A4C83AB473F1E3F5E29E32CF8F26AF9AE185E27F15711C4FADA923E
      26C7933395CA2312E0E1A0412542C665194B25BEAEB4A4AC0C51DA35F5C873EE
      38CFD3F89AEF8C103BEA2D6E226ECF9276694B8F62EB5E40425422A9CC2AC55F
      8F5F55FB539AC5E1D9CC0F4CD37B82F2899F5FFDF2A42986F65730EC1EBF23F7
      7E21B49BFD4F13C397B5AB96D62D34BBCFDD1D99615FA25257B9F9601FC10D46
      9563545A4A8FE2A79FDC8B5F69D1A9798626A43748907D25F54883FF0AA33EF6
      D1ABF955C6AD4EAC7690D2DAB81220A3D8BFC881490E7473665994C018570B2F
      D4BCA1BB4051F35731A2F7CBFAC5FC62851CB310475F468EC98C02BE8CE717D5
      6A0FAE2BB2C410C03E8B989B05A965F05BE26C664898FB3E66C39AB6F08F1344
      F61EA85C54A0345741F98FB7780B71749EA0B7B3980E749D256F59464BD2F942
      7AE12D59469774FBEEDB70CCBF6CBD456D17DDDF7BFB643C7C5BF8E37FDEB37C
      26D1D3EE00733CEC7CC23AA261FF2DE021D36E205F8D3EFB112B2BCE3BF76F3C
      7CFE1B5960FFD21FF6BCA788A407575C8C0CF093D4E4C99342549D600CC4C577
      D572CF3A2D021AE18046785A52EC72750406A825CF25C211977C002BE6426BF4
      00183373C566F519F19046BCE717FEBDE3FD638C92D7EE368D53DAB2EDA2E56E
      9C590652640EB392C71DA41C1806363E509166256C10A9B6D7E72F9F8E3C449B
      BCA7C1ECF9BC98D09F161FAA5E12F997FEA84BF280385C9A4C0B7AFCEC4A4A7D
      A41D48A97C7821B8FE01CEDFD56BC458038024141267F10C115A971021776391
      511F33295950A02E6A23E7D373B352DB8BCADEDC2B6E5217F609A558CDD54CB5
      EB25159249FFCEBEC88C207A69E7C6344D008D625B2C62543E6BBF86945407B4
      459037CFA3626E41EE6B270628FE2B733B4E610694550651C22A8FA71943C917
      8EBCDA8D12CADEEDE9711A03B62C29677E32C7EE06F79856B1D76E8023EC703B
      618CA627480051800422A7B15212C093BCAADB6B3DA5DBD511E3A1696C976916
      FD8AD859AC9C21000C0E1070CB6D12649C16453A9DA6B9D4C8DCD66DDCDB5B34
      6E189BA8B525ED34D52A01AF9A1C0E8D1C6D9C0B522E2DF2BD111FA4853006C2
      42EDC68D33AC815241F0FF2A8275630154590A6FEB35B0F5B50DE7AE7215512E
      AD304F5D4ED9669F11B6938E347BEE045116CCA7E8600BB8FFC622696AD1B896
      5D6B80B85E6279482852C0F08CB5347EB94F48B1B13480D7D1FA5A56807FAF51
      86261B65F9AB8DA16FB8B26E151D4C217C2C24FFA0660E3D2D28415001C31F02
      5BD0F610DD217DD11C95FE95435E19FA6E7C81F368893F902BBB122DA5D638F7
      9FB5C67EC7038049746D6AB68E1E9406F934A3D2EF41B03256D5127A560A028D
      400EA28F83849CFF12839694A9BDCAD7DE7B594AB86FBD44F4808032430785E5
      2462B6466E6E200B394597313A1F96E1366A32E007D78446A7B585BBDC26A030
      821EA2EBB87319C5A0961A1655956C4708216C21FDC826B8D2FE6DC1C295F61C
      3AAAE49D3F8ABC1246AA64AAF54AAD71D964FFACD2607F3B5374E08AF655256D
      3B4F1DC491EFB8542A868C373631B7C1736F63CDB4F2BF0CB6B638C236D303CB
      F712F239D401F56733EF5AA196258C5DAFD13D745ABBEA70CD89A71538053972
      D7D72C7D0F3AECF5B2795244B1562CDAAA6446B1E3183BFDF9C790CECF2F4F7A
      BF782F8F778EB015BE3F3C7901E57193A5751BE0C336EC75F4B0F9C57CC37751
      C804D106761C2F0B6BA271BFA3AE897B9615C3E6C9CAAA97EC4AC9D15658901D
      17E54B3FD3EE72E5C806A71C2A25F69B4DAF719CC2F5DB89E346D9A6E852B1B6
      71AB0295CC01C11A1E460FACB51D5E1B158131220BA32CBA3632A1CF29E3759B
      8BD807200EDC00C20F6C3A2686D844A5C4980651B3F8C84342E28C3C5A80DDE2
      A0E17293DB1FC5B0DFB541D94B1A7F302FB41C41605BA4C3D9F2364B6F8C12BF
      591CAF5B6DD7499E14F592C803F238A50D904EBD9D378B07EA4DA59BA866E37C
      60699F9FEC960ECBA202A40B7F8A9261FDC64967C23D2395B54C6BBCF1928C47
      56F81AE3BB89C2E292612C4AF8D9452A6597CA22E33D33BE82F1C9E7B8471FF7
      A99F2E78604DFC70707EB49F7B1B6A28BC22A7367A47AF32943E703E3C69C7F0
      F625ADB5C996D8E9EB575EEC8F4DECE2495A709F9210A73513CE43A2D94DA7EB
      6B331C7467B66DD36D1AC57FADA0355A08C45D59673FB975562F613CBC525E80
      14885EFA018013F43A0DE036F77695A4985605DBE59C357A469B249D2BEDB9D8
      1BC13C2F48C992A4A6358C903D20120B9B13E5F95C70F5BC777BF3E94C069ECD
      130E86C051971E51EE255695E3E81F2430FB47110932E2DC1B2D61BF80F32913
      2C8F134DB640D3282C0A5C7AF4C692BDAE74D39C738C9408EB8F2191C50CBA16
      8032902B62E7DECCA75553160F451381DC8BE312514CD05AD238ACDB3279C800
      8D2329FCC7E04E7E04D04E91AEAF39689F3B1CC5BC649CEE55118ECDA5CD6230
      82B8CF7DECDCEBFAE845D528177AFC3AF57A2D8607FD919BF1C964421B1EA566
      747AE6BB74150731C8B21014BDCC47FF1E8786D955B7D4D4AC7139A77BCB9BA9
      5E0279401CF344701B84470592B8F663D6890228C5A76C94B8EB2E711EF3F611
      1D9A0BEAC2C53C53EAB976E7526EA68776BDA4F4E0B2A9546B19293DDAF80B7E
      579CAC44A980C962A5E522088B8E8229348EED95DE14FCC53F8C552294274DEE
      A5E65F10E0D945A73CA475B4980796C62C1C44959CF8C6AB981D1FD971553278
      E9C3BA4DE78264518117B6F965DE93DD56B735F8D39FFE54B31CC4C332FD4960
      418ECD0D7BD1F7F8011C8BAD9CE37294553E87F099E6CF700B2E983393827366
      550A558B2AD2D84B6130F07D853653A2FE8AE5DB90D901544D9950BBE76BF9EC
      04A179965E64FE54AAF0FF28D37276B6EFAC2B579D2013A0CAEE7E82CEF642C4
      97972CE464AFEDF5EA25A00735C11B0B35580230DB00D01F638412ACF102ABDD
      D289B7E7DFA08C230B5B269F928D24F58AB9D793F4BCC367436C437CD3BFCFD1
      B7C0F7A897541EDE189769EC50DBB50C8EAB00AF8CF62748755005E70E7B2028
      B2D856CD2DE79E715E9405540B68A53591D6832EAB857512BE351A61348B857E
      D1A15A5A542971E6B87E2A7FFC3646468862DA3764F8F1805FA18D512A9FC8FB
      820BABAB840D885A7AA80FAC89925984EB606D81E8D29E88161C52DA1DD1AF68
      43AF5B8DFB436E3A6903EF3BF1D63DC6E7E734E00F02917ECF91CB02B0D1508E
      922F60A76B7685412A593729770CEE2F1350C7F4F4C33AF8B543DA9CA6F06249
      EF1A0639523C9AFB5007758555512297A21FCC2D29D41D37DC16BC8028582FD9
      552407FFB57AAE430B3FD50233C703E72AA2EEA1ACA8D003951F63406114A0E9
      3A74667629377B672760CBA952D9E8F592EAC32B5221CEB0B8AA4086CD7BB59A
      969139D88C52AA7E0556566B951864B25E62FAA039B050EB5BAE0FB1276D1DA4
      F4CB70BBFE843BA1EAA6FC3FB45A2C7EA6DD3A559F5F275F4933A44B94EB920A
      C7C9838E719552BDE4F22F83761BE52082F6CA0DEFD8056C3C93673193FC4689
      FA298C44B51B63477B3DED61C3AD31051299FB67201C9D31AE8EF49260CE532E
      32CC222E09A9D7681F5EE941E6E797D2EEE90781E6107C6E0B8BB41480C33C5C
      FB2E8BBE29A169B69AE84A2335BC331FC158419D1B1B76B0144816A11F9FB903
      1C9D80B6075B171D0AC57D8F6F7B534A0EAA42DB8F7D79DC3F8AEC1B3FEF1933
      FBC555F06D9C6809DFFF207A250DF79B8D0FF6F6A0D22F4ED32B4940DA602427
      5C2DC7D9D8A8C0D5F02C008AA124BC15C62F06A1820D5C479882411B4D60AFB4
      0E43BDFA343433ACB822F393B83AAAC74690D9FA220832BDD1724ACD21C8F446
      0F23C85C990C21A2EEE093A4AE91D444880DC5FDEFB63AADCE7FD46B657C7D14
      93CEB78E62F25A0D5EDB67005CDB3444BC986B3ADE9DEDDB73B055AFB99781D9
      D364F77C6FA7E496ADE54882948E5B693CC23818CE15605A27DDA6F7F2F88DB8
      8295F9AAD720956A8B744C6BAB5E4FFE6ED0F3AAC85B35796C210324F3820DBA
      6B3F8B84508FFD1F8C4969D1EA35AA1229BF968F0FEBCFA2CF7C8127EF7CA127
      E7E7449CDF3D398F65D2F1D20F9EB3ED5EEFB71FB4FCE18F3D69A3F8FA01B83E
      BECD3772E0EE8461850F964B57B82325B040CD5FE29C7DAC897F8974C8FED92B
      E72B2BB9B1092E13656B565851AE9C20EFBA6656C4CA82FC8010A55BF17B742B
      22347470FCF24478ADEB35CF340FB4F74A3669B8DADA059119090E7BBBBB8C27
      53AF81E1A1913C4933841134CC5F230DB33A5A3EFE6841ED1B56A955C692CB15
      8B8E6B05F70E779BDE09373B22D0597967FFECA85EEB7AA5983FA498CFF7CFFA
      CF583B5B1FFFD5FEE98FF59A653A5DBACFC8B9FDC53BDE7973A4EAAB5E43D84F
      723014F816465D3AD6D1898A986DEEFC959A0627040599F44886F0F48DCFD933
      7321F555884FA461A85CBC351BD9FADA9E523784B7893F8D0232D1A5467F1299
      38B4BCE1DA326B49727C6F6A3274D2CFFC22B86C793F21188DF2C3E2293AC8E1
      74FBB1B4542EDC2C9A78BF9A2CE5FE4C4EB200623507205F2A66752C417A26DF
      01B8B42B62D3C0BE7EADA44D5AE0E241AE25CEA5A71BE900D44B44A886C4A5DC
      9E96924D6ED9CF51F01CACAFC953D1F314E4A44CB46C4EAF078D559A989A99F0
      2FCE76E88BBDEBAD56BF5E0F8E60C0A373AA3CCDE985AF516137737C76BCE666
      BE744B597C31A9B6BF32DE384A000C1285B4F8E1626A699EED48E5AE28AECC43
      D6503EDC1240E74B3FBF34DAA1E7C7C13CE64351AA618FF6FA920A3D7F990235
      3E8EC65995816D9533FAAD39A3F62A67F4898665F7DB362CD7D77E3E3BDB17CB
      72978F3D341AC4F3B197CF67C8767B1B702ED409D96CC20A003872C50D855D60
      9D145A2C8FDCB8F8AFAD2008BE02C10E1455BDF602F910FD6734D9BF788DEF4D
      82E200EE383D19FFCD0445DEF0346923DCA4351B9AF32C74103B450C28A5590D
      6D70450C3BE9E950EA08C07076759B4553EFCD29A7315F0276615EF4F0B76A95
      E764DA26DAF20CD7F6CD298E989679C7046834F8F285265ED11A24A906794A16
      6EFF3AC3EB4F27698F7E73E646CDE65A88D8E9787E0E9761F43424CF8A9C804B
      F3CE0F4D104DC9205A5F535C13A5BE8918DCFB3A0AA555AEF102814D25F580C8
      D20CBC744A2DD71087A42945C57A234BE45D36DC31C07FBD24B7BEC6F5D50B58
      F62E6D112521EA3613B848D328A6072747276F6A088DABF5C90D4AE65641483D
      318CD2F27E6912D7ACCDB8716A72A1FB9807C53C338DBBE3D5DA73799DABA567
      7E622C41DC5468B62B4EAC9FDCD6AF18B8B19B4E67F00B6C62EE7E419CDA7EC2
      D07B71CB55E33752797F4D4763EC8AEA5D764F6B4FD82501D069DDC4822A5F6F
      03CAF67FC808D83CF267476043C9F256F1AEE0CD52BEF95F739317E74073E537
      692500970225A15C32CD041982E9C101305BA5270039D86B409E8AE75C500A1F
      42AEAA97C4A229F4AC0BC2789C548A6A68505C2BC4CF787E21A52D3CD9507D53
      ADD2ADD980924A5D052B791776DD7975C0B18592B1EB6F799A34BD249A90FA9F
      229E19F931FD1AA7A1841A562181CF0C09AC02029F1810E87DDB01819FD94354
      03FE0CF4327418EE6BADA25AEF75B309744C67FBB575A9D4291447CAEB951351
      A741BCE74415D07874E43B4EED7A8DED8F7CC8AECEC8CF3B23DBADEEEA94FCC4
      53B2BF3A255767CC6F1884F096DADC0552136819CB63BFE0E4BFED879638A2E3
      390DD2E914FA3AE6B2411B4CACD7C81B67CA5DFCD1719F7A8DEFC3FEF8EA80FA
      CD07D4CA8DFBD4036AF06D1F500FEE96F5B53F80B5CDE5902ED957D5F617717A
      C35C8106E521351B95CB62BEE43A3C07E92F532588DCC6E7A82A0DBD96635C5F
      D3B9C34F9D3FFF3A8DC2DCBB90A434030964863C288C11731ACE677494215DAD
      192CD0D6493A2C6FB2C745BA4C6D31ADB603483B0281A89613B826C6F0165ADC
      12DB1221ECD5E1F1B987C7AA28E8530F8FE1B77D78948A6887D1265EBDD8DFA9
      25B2D91F2687F3E668670F7125D687663A2B6E3DBA897F5BB361BC538D8F91D8
      93ECC5D94E4D7967ED686895E922534852C02E18C0F1F8C07511CC17FAF2300F
      FC99C1B156AF719226B02735AA794EBAF2D7EAE0FCDC83736B75707EE2C139FA
      B60FCE7C06A0A61A47FDA50148F99F63E35FD5F2F92D613CE961B4307359F2DE
      C1CE611DC7328953BFB0653619506E6BE7ADFBE1B5CF75564769C8DDE4B93731
      3E4AD4EA358E30F32FFE6F482E249F830DC55CE14693652CD6C6425022A249BB
      8E42C0BC33C264BD860D422B6DB461DC4C0EA4976C58F51A4C99D6AC719BE6FA
      5A390C0F47A3D64723F984DA064D6FC805CF1B85C98BD6CCC7A2D450880B26A1
      069BD10451FBD7FB1F2E002403EF7FC8E4DB14F41D9460D74B3A4AB79EE76910
      7133A4ED7E84501EBD05EF5F5BA85627E93F76175EF32B8DB5F7BF65AC93B4FB
      1586CA67CFD7186D72FD35460BCAF824AF9F8AE6FE38B277BC93ECC24FA25F4D
      E66DB49B1C8FEE6C220E3D117ADF821C4A25619526EEFB12D18F4FD3F1749AEA
      333EFF37FD0547C5BF3F7E2B719D267D223CC38FDFE6CDF43F002B076F5E1C05
      C5E36F54352D68B128FA74BDA62EF92AEDF927CF1F7D9E4AA5C2ED4EC2E29BCE
      8BD9BC00330E13E0B0D3028350C37E3633075EBDE93C4060130B5DBA814945FB
      53B00D3D72E36F83A4D76ABD7D4B4AD6E9D8B76FC9FCCDDFBEB5FDADA1B71701
      5EBBA081341E14354DE94A7B55D3CFE2D991B77A19851A47290CCD314BD40F8A
      D4029DD46D80189C701222281FD336402E99397ECE4FF7F7B52E8C168B4B2B3B
      F262935CE04CB6682E16C1BE661258CEBD3731C63BE5624FFF5D71C5E817D72A
      5EBBB4850EF627E3CFD2E4D94E364DB3673BD3E93CD12ACD193250F9A53145CD
      D6B1ABA17871B277FE8C7E74D82928196D385BE830C0A5BF5F19656FD8B40CBD
      F98C75B7B517408991C6F31A76FE8B240E6CA277EFE4C57F7A97248EB8762688
      0EE5F41E469AD0809EA3E417AB36A0AEF26FBF31FFB6D5EAAECA1E3F3501B7FD
      6D27E0D6D7A23C9F1B6FB0FD9C03A353B25A03414553436609A98DFB992708DE
      2BBB1A0AC43C7F8AAB70B903660386AC0575AED979212269F748265A401791F5
      F38EBBB4956746286454E79C00FF974E87693DC739E83CAF90056769219E0B7D
      598C13309B96EC441B152707B90D5E232506009C89CDBAD978976971656EF32A
      2046896AA1D0181B8FEEEAEE63D33DBAB3FB940D9C289B36512F3AF3BF42E4F4
      BBC78FC4F06C0302F22B84C59F7EADE1266962BE461AE0D1C71B25A49C8ACD7A
      29A5F535D0797B6797D1A450FCD3BCF0A54A43EC3144A3AEA21973F3A5CC26A7
      BA8AAE23EF7303DE0AB9DE1969B3621E28BA837C94AC537A1C6607426F93A0BC
      9AFCAA40A69E9CBCFACB8A7D73C8E4E4C7F7EA7586E84D84F89BC53953AB0798
      B5A1B0D0EAC12878BEC089AD25C39079077C19F3E0C0AC88185DD7BFF6A3D896
      2DD412144E1E9AA92DA39C9EF19653471764AC696510CDB1B88ADCDA43879D06
      6C736F038D0F4C8CCDB67DCD360318BCBFDB055872845126F1AD778C0A073C38
      1351C7D16C9CFA60B3DCCF0326B997F60F21EC967D51AF215761111495DA6E55
      4422D56709E764DC4EFC38B73C1780D515F46A6DE992E03C5A87F2BAD9B08A24
      25052C86A17A0427AF49CB789A7A4F845DFCFECB50EAF2A45EE3AD16F42CD425
      55F08DF2E708650ADD03E3FCD902A00DDE233F6D36BD9FD28C7CDA19C0B95E64
      E94D8EA4F34E5C7CF7B25BB35DEF667486202639A820A34DD3ABA99F5DE989A6
      8576CF3D1E7DBBD5EADB84964F97AEAFC9C54D0FE3B7EF5EA4DED80FAEEA258B
      4A57C104C3B370D83F9D1EEE010D32B5C99A24BD697A4FD2E44945DBD76BA877
      5B0337C68646ABA1EC2640BF9D73CEDE7E5EB385ED42F7B6F4CE475A02E88B74
      BA2774B0D1792D0CBF790CA07F6972A4AD3D8B0D803EF53CB84DE79983408B26
      4A08502F512C86BBF5D05B5FAB1E7B1B3F9DFF70DAE4987E9339439A92DA98F9
      B3DB6C9EF356687ADF9B621F74D50C0BEF78354966AEFBEBD8BF3EE25E596FA3
      B8F4932B3E42FF962637E1B0AEEB471AF3581A1B561CBA2036313AA4338544F4
      F0CDE1F7DEC6459C8EFD98DFA2178E5BDEF9A5613AB727A0F9F60C094D006577
      7F44EEB300738596306B372DEE55F08724A42275A38CB4471FAB74D2D6449410
      64CF0AF2AFA7DFEFD178C736BD927AA7FB2F69E931039A18D675A4AB414A1F19
      6FAE3BCBA45EFDD5E15EA732549ABB573BBB3F92DAE190210A7FEB364664F55F
      BC3ADFB36A03768056DF8FD3F016252F85A4F6016C43571E7B49FD962B0FF3D4
      D0A55C86B1BB7F78C87B92ED800B69ABF0258BC1B9C2493D21EACF7ACF94EB4A
      8A51D6D7648455EBE7E4E5D979A597D7DB60BFE7C959C475486A193E51CB886D
      A4C96473952EFDEC74E9AAD1FF13D3A5DDFB67FF9B49979A7CA68C3B4AEC8AB2
      65522E63334933D223F9B45E13AE19C0EEE039283EF3829C3D8FCEBC6C122B1E
      3C19841799C9736EC90A24098830499CC2C19AD9A059BD466D93DEEDEEF0B927
      DE834004B8539E4E3F309F16207881D3917B07E747E8EFE4D0299D970B503389
      019265406F27B52BA2595F93B64994EFF1A93042D75AC6B64DFEF7398AA0C619
      2D0B53DC958926C72F2276B7257286CF596C4F863DCFC9AF689996F7F3FF7915
      1567453AFBA56E02E280C9DE38DEE582BFD4F142A8B3C94501B445FC0B841AFD
      312A2662EC1C730D29C4B76C4CB2DD9F2AEFA140E3D74C57B069EF50FEB56398
      B9816FCA988A72636084A1F007D6CCCB5E5F03BE86E8782C7EABE06F51B61D14
      C0440F2E25DB565C6AD684ADE3DC1681F7C58D84110D904BF701CEB2E8A290C0
      74DD24F340CCB5E9BD3EE05A9F2C8D9702B03B790EC531F513DA1D59D3FE3DB6
      C156DE5AB58BB66A48414E8EBFEEFE7FA7DE86496C9DD4AFC827BAE4DA7F6C2E
      BA8EF0926B3CD857470767B504367251C42907B8D2719E72353BBA7FE3CAB9FF
      DC3B3AD97BD1A49F677B4DEFE5F7DFEFF0CF33FC3C3FABE598E7CA7F7CB84B7E
      7CD50944FF93092BE7F6EBB31F5FA9295BCF1DE98E216DAEE2C41FCDF4B5F1FC
      38F291E9E4517B747A434F416FD773A462B455700E2D3B2EC7A6EAB8435DA4F6
      C99E78894F944FF9D270BB45C5B278F2B4D3EE0D7BA3EEA0376A6DE1BF273044
      C68629535951D1CC23E0A30D2A72234469C9CBF9EBEEE14FE58EAF9790969221
      0D447ADEBE1546426F0CB093BC614B709773207F8CF447955FDA262CA4E0181B
      9A9904EA37AE5EA9A52B56765559D37A6634BBFAA1A1E8F84461BDFAFEF4B462
      10D18F6C3E7374747E71799101D95488C5FCEBDA79D30B83BD473B1F7DBFFF92
      172AEC40D14D7F3D3CD9ADB33A72C36DBC4EE639FD6BF3ED7F3DDBDF6B90EACD
      EA1714293B3B6568923A5F9CCAE357BBFFAFE9DDAD3D5A91667F7EDC7C85F3F7
      A971F3F6B71D375F5F5360DCCC5C3F3BA6E93C324CCE8A98881634CC13DA442D
      EF35192CFE04E61A19726CCFF1FA488575536BD791B3F3D17A9445951D5793C5
      726680DECA43CFCCDFE751060041692A62F09690BB4D496F86351B984CB14F93
      84A29287A059308BE07F99DCBA5EF127F03E2369A9E2742D5642BDC6CE81AC9D
      CA1245F529293523958752565BB33135FE733E9D313F4AEA6C34B1529EE4B6F5
      6D96CEE6336E82AFD9E0F61304A79F69909A7B1FC9E094163FAD78AFD9880ED3
      0BD942C8DF5F9BEC268BE8A113D438748F5ED46C30EB6B3FBFDBA3E5077EA5C2
      8F493306C6724F6788AFA25A057EFE6596CE2F2EE910C10BAF6CB692F6E1A58F
      A80F7776E4853F9DB5BC83C29B7228616CD0193399C7B8AE4076CBA3DD29D815
      6CEAD54C5816DD802EBDCAEDB959413C94265D40A023E655F2D4B5BC571A21A0
      FFEFFEC8ED019CDDE3EC54AB6E45F0F714C32C554B2ED44A2A3F3C306FCF8FA4
      CD19998A5B45EDDC7C4C43FE334CF7DFDF743BB3299FE7F55A0F5FDF2AEF7CDB
      56F97195171AC65BCDF4DEF1033D201B25997A662EE6B10FCB1A84EC8C8BB859
      C3515613AC1BE787FE988CCC10FE72D33BDF45FBD2218DE445FAAE6E633BD3D5
      A7D5547E002C3C3AD63932661BF3254BCCED9DDFBDE4430AC6B5F885A4D6C9D3
      30F4B79E756877DAACDDD175AA79C9FC3629FC77DE25E98B183A032E72E63AB6
      D49B581D4C7A3081F52B5F1D4A9F782875BFED43E98D9F45423D1AFD8AB6F442
      3BB6912B60C8F89AA9B89339E3E24872EE0F309E038985B73BFD26FD18E0C736
      7E8CBC0DFCB8F173AF816237EED5C2A01B2B4BDA2AACA3280F56FAEA13F555EF
      DBD657EB6BBBE8AF9FA6613489D053CD2881D3995F44E3288EC8EB6663669CD2
      8F3D43438CBCBFEEB327FED7FDAE45CCCC819899A7F30C3DEAA83DAC995290D0
      EF0B3F37C718890B38E4A9374F7209D508FF1A9B7A0A0C0676E979005E130DFF
      D76DD82F6E0BB3836179B1492E6882C9F1C81051E1029441CF1B4745BE4A087E
      7642B0B3BD4A087EA2D6EC7FDB5A93A798D40054C575A415D6D3349AFA09C9C3
      FBE7FADA3FDE32E2E0DB491CC2EDF9C7DB7FC5AFA8027BEC67F57EF8EF57FBA7
      8707C73F7A8DCBA298E5CF9F3D738FDA0ACD75E427C0666A91DA7F46FF3E3B37
      791FCFFCF48046983FED0D86DB9DE1687BD0F0FEF9CF7F6014591E3F3C8A07D1
      B5E7F1DB60D2F9ECE17CD610FE494B3B27B355D6367EC3E392CA7947BB805342
      B7C3ADD1DB499A16FA6B90C6F93BFC629230B93499E1CFE323A8F5C196E0FBC9
      820EE2B7F9A448C67F7BFC53BC4EEAC5D6C2A1E72C4A803CE9DBCECDD00429B6
      D3C6A9766AEC9C1EED34BDE3376707A86ADEEB34D1CF7E52B740918E78FF9A56
      15CC06C4F618C9C9BB404301B237077B52A0830C721CFD8A2BA43DA396237DF9
      5009194318D8A8AD90A0389EB57A8D549BF0B67ADE731A2E1A6E52A0F5003E81
      6C44B45A3236573EF536F0CBC5659A179B9CFE7349BDDA79CFB6F57034A241EF
      09A23E47F8E005008CCF9BF940CD4FE3F9945C83A800981D59CB342EB0E131DA
      3C76B9F656791BE19C0B637CEFD2171C86CCD091CA6057E3F9C526702BE8FA08
      08FCF0CAC525175E1D1FD56D35939FAE99F63689CFA2DF5C72F2D20F43EC0712
      699E7B7F5D5F3B3C3D74DD6A4ADE061C48292992141F8493E6C6FB2BAE65BE3E
      3AEBC818C9B8A337892E120BE2612B720FCE8F6A2630D7EBDADE229171AEA082
      73C6CD7B8C7F962BF12229D528D40EC7BCE5EDC479DA646BADB1FCD906BC56E0
      078832AA995C4E2AD504CAC183BC03160A83B6D0895AA0638D378A549C8D0D1D
      26F06A6A3654A7733AE5A6D9F567E407385C672D734D0426909B7EB999A2D2EC
      1B4670E86113D2B2D8339A77E3CF323038EF1F1413E4E01F03BC1E16D72AF4B7
      4AA27FA6273BF8B63D593BB512D942250D5B31CE44E3E81F389542C871E6E764
      9D7A0D90E234BC2B734B8772DD6C1824A42B808B162BB686A35838C01E3550F7
      4DEBAA555EF5B7E8A9E1B7ADA776D7D79095C8D85DB889E2984D1B5B286A3CB8
      5CEF68D85C4A43DE184C9F4C2E8C0A409F5C1B26354B6914B70A903036975152
      37F5A5F670A70F7BD8A21F6ADBA8703E31BA0DCAF1010A53B3D1397BBFD3667B
      DF17920E852C4927DE2959B1483F0B2F1B8383B2AB4856DDA923017128E11C51
      8AFD5BC9684863066C6171A0F8ED342147EA98A996F8CE2595C85F770F4FADE7
      B42859EDC3AFAD6CB79EB5DBF0E04B896133D91E4EC1A077FD2BD2DC51156F9C
      A657F39917CE398EC5DD2CA1AE43C6D801480C43D2CF93CCC4510D4F57EB740E
      49482F8419506B985E5B2241B8D67B5A7EEF4493038CBA9E438577255EA5D750
      643D89C1366805C4D660AAAFFBD86E43A3ECBCA976E72E206631200EED7EF625
      25DBDBF2CE24128BC99ED2A6A7A3C38F6D8F0F2B05E80F4D18C7B7764B188EF3
      D2319BD76DE13B696D413FBCE17035C0D4545EA241E145E3AFFDB3236EE96E79
      2FFCE0EA82637325F9561C4D2375BE994496FE75B0632A276E59A9AD84867C02
      4B58DBF7FE3E3779618F0B3D9E682C992FF06AAA3E26997F817E7F6933A63369
      6C2CDD2E9D27EF5F6E75ECED28A5352069ED733E60A133525B078149276054BC
      0F911049FCEB29A338B7BC9711EDB4D728B140820821CE4AA80B7EAB994C5097
      764D5BD0ED45C48B2500269830B5951C2CBD133574213859697625E51E89F4BF
      F8A51D05894117888DA2979D472D6F4F761D52314DBBBE226E5E04D457F4AB09
      4BE92924A4C4D1D0185F33F159E1216CFC268D4812E7B733A3540A644A220531
      9B1972695ADE91882297CDB7B0CDFED73BD33F26D88B2C93954BFD892EF5E8DB
      76A923B254C51FE8D22679CDB9D83B191639F15103A7AABA6955833509E8AC22
      2B3F656CD1E7EC0DECA2A161222E9B73D5C716C9878E39C0F21792D573FC46BC
      5F41F853B7DC7EA9A8D98456FA653527B59050101615C1C92723E802A4CCCAE5
      143243B9150404C897B76C6A304C4DCE22CC3988716916EF6B8B30F5FCE4BF48
      BA92CC4811FD20416BB9F64AADAD4A997FBB3EAB091970BB0D8BA9019F643ED3
      6DD19034F1387D470A2BB84C3389088DD3028C5200CF27755533C5E35FA71130
      C3C49502306F005831D4DD58A38F346DEA718F7468C6F30BC4D21EB59DE18F5A
      D03B5A15F47E9AEEE87DE3C8F8EB6B3FE1C02E506DA4F4537A7246C819147EA2
      F48386BC4DF46F92CA6056264B3C297652C9668A13997EA3F7FCD83B36EFE6EC
      A79D15C69FB2679A5FA68AC54FE6D01E5B007E7EE5F9637096F063E8B14E8A69
      3EAD19CAA703C37CA554451B52F667A36D9B8EB005D6A3249CA77422DBF08918
      8A10816D84DE236F374DC66996787B87BBF59286CAA201E028B50FBD83BDC67D
      D5911A8CACD7F8CE312E2DA371183BF756D4F0582DA278BD06B9A3DD50500292
      3CAA30D0D28B9AA1FA376FB4B57559AFA17196CD7022035C5F7144EB334863F6
      FE92D0520BDAA24E3A0AB853A89EC4BAEB6B8D45DA20870E258D6F4910C15812
      5F4CA9270F778EF7848F8EE541BF1CB845BE21C4C48B8CC49B2DEF24A9B0322A
      681803A38915D1542ED3E8D75AD3141F58C6BD7B61F56136317DAB16A8ACECCE
      CFB63B872BBBF313EDCE6F1C59526D83D79A7A0F233F4E392D59DCCE00052DB4
      1B8C16DD6E8DEA35F9EB6B87D2CB629E8546DB5A8C372F26236D8141882BF393
      3C2EDB7FB431A0291822B7AC67A7534195242D8AFAC4B322E30D4182D15245E0
      316AFEA2488131A360EBF51297026BD2B121B6C43397ABC8AFA2594E12094332
      9F141E7DA54D3F5F9B0E56DAF413B5E9378E08E6FCCE17277BE7D027648CB071
      1B7A1B4596CEC7A8FAE3C8FC9E7F935CCC01526BF2DA7AD72F1DF519A8797676
      F7B55A5B000BC6D18CA962D8DFD48CC201472D4AB4870CDCF1CB153042F1A451
      10B2E35C7FDE3DB794EEAF32892F011087C05827B1EE680D1BD380D170F04BA5
      4E9CB1BDB878A50269450EC0B295BB221EFD7CC5DC5F29E64F54CCDF382A962A
      2CF2174142C7B54F60F73D78B5776639F8446BD50DF96E819E7D6F1F3CC55AD8
      B573B8FB83B701F3BDB167042986B507524E740C35EA7AE8F0D15A2185CB197C
      3A33CC96A9D087744D075B5A9AF7E9E789B086E088B2A70D02692937FF23C74D
      CE8D274000F5124B39FFF6EC600403AE234A84C9DA8D1C6B814F0B5EFEFEB595
      960CBF5EE376CB4156FE1820D495993D129AA357ECB86E58DA3A9208ABF7DE26
      9742A0D8C3D5F101633E2943E0DEA59F33A7EF42E8A826C211EE76EBD34FA39C
      4B6B981AA9BE0C480F223A9CBDDA3FAC2565DB2B6E667C3A66C0AB328299DF92
      313BE56DDBD899CD688D9E057430D3BB0D0130D8E05282B27370C1FC03492E28
      FA8AB4660ABEA12DE532C89A3DFB0E69DEDB5F8D77985EC8F323C09E652629E2
      5B9B6BCCBF044A4EE70B0D8A87E0D3EDDCA07898938E977ED0A26CF77ABFDDA4
      E40F7FAC4D19C5D7F1FD0154BECD37615A9E5DDD66D1D49B69A6394EBF4462F1
      B1A6F9641C47D7887D9ECE13744C492FF6AB2C45650068EA2FBC7FFE0624B107
      31B83E7740CB5862CF9F3DBBB9B96925A86F98A661CE005CA90EEA195E79D66B
      8F06DD8F830E5BF23C7F17E8B08F7DE2BB48618F8A13F6BBCD60BD14FBCAB1FE
      7025AB2460D172E64BA5759E7AE904D439CC6788D3906D7218D98D13644C1AF0
      DFC49479814E59A4AE9F65C6A79B8FD139EDAC777AE2A67766FECEF8564D4FD3
      399CAD697AA6085A35B3715ECE6370F1CC60DB5D012547E2A09967A3C4ECB79F
      AF22789F1DC1EBAD22789FA868BE799CE8A554353A3E3CF2F940714DFB2986EB
      C47EA15644B68A775C3FC9280442DD947A2F4ECECE18F291E346D681AAD75259
      4438BC463327B76154E88E692FFCD7EBB3F35A8E0BBCE3CA38CE5A09E05AF319
      07AFC606A062AE48AC420750BB91AEAF71F08A2397D3941B996273E107B7DEE9
      F1CE91A6B510BEFBB32E60C53AD277843D17814DFA79849F3FEDEFBC6A72D097
      CECF83B39A95A8BADD6D995CEE1FA00BF1B11016837CF324F72746C2BAB3DBB2
      D5DBC64518E5110785E8879A590EA054FEC53B4E394DA175817B073B871EBADE
      67758BE8397E3928B1F5B5F01EC676E677F52FC2348E014049B7F082CCCFD15D
      02CE53AD77E77A780E9AA9FDB977B85B3361A083DF6BEC3A70A18652A0820B01
      38286A392BD12BC7EE27698C632F9A688B008C6ED8D5353BC85CF526906FC8F0
      B82D0F725A00EF063D0D85D66C427FA0D9F176CF4F0FD9C46793444C7E051D00
      DD0556F7A474065606FF671BFCDD95C1FF8906FF374E71E04C023DE6A508D562
      44610349E4B51A69A7C530C5D5F9F355ACFDD362EDFD5AC4DA0FA1B5C43ACC9B
      DE01CE86A677363364237C91C28DC79A717AFEE78B8FDFF47E303E87BC0AFAFD
      A51F7CA96E8CC71AD2A91F98E7DE0F7E94D1F3EFDF9ACAC4D4660CBBC2AB64B2
      3A3DF4A991F2F53A3D330ACC3D70AED6E9A17FB41E789A3CF776B2699A91536A
      FC1962D13BD369DA845A5A19217F2823E467A1433F7EF38CFDEF9F38BE683254
      8A8118E5C27BBD772AAE9700CD8084D7BBF1D9B2255324CFFD0B31F605B4914E
      2EFFFA4840C5EAB5529682AF77FCF5BCB5B2B8FE8816D7FADA8B577BE74C4B6A
      CBFA6F6989DB6EAA5042CF129F61CC00E60021AF3D2964DD4713EE4A2D3C7CEB
      9CB6034AD65DB9ADDC8D5D62DCE84B04E51ED1862347B488808027E8BCD541E1
      75924668DEFDFE91EBC71A31520A9EAF187F8B80C4E5C079CC751B545EF0C2BC
      3B8DFC46EDC6E4026BEEB461C4B3E48AA3E07BD1350DAB48B39A85C057C6CAC7
      464CC87D342FFFEACD2ED3C4A047EA860D144D844ADC5C6B672B15F1F534485C
      0B5ABE5814CC0343D297F7F7FADA868C7E4A274DCCA759A0D43CD0CEB8F8CF72
      6589ADAC7A8E01C58BB95874A4D4D16236211700280BF592985B1EBB3C74E8B6
      AC786A12614263505700DAD32FC0583FDBFF2FC93F6CA0610F18B79296709916
      A130F051461F98BAC9A2EC0712452965E55C575D3F847129F7DFFD61C796C1F3
      02B765FF02CC76E9C7E058A6A58CBE7EC99FEE21E274444BF91669B35A0E7ACF
      12F9712E5473A34DD9E0BEB03B2A8EE88276E05608CD25D76CDCC729F73B3172
      B90CAA810D7A05BBE506B89BF84B80E169A48D9A8DCEA641B92F891E56BA6001
      AA606172A2843194D1AE1396FC6835199EF673BC8C621CC2387A7635812D5D03
      2DEF382D8CE0A74A6E8BE719301CF2919CFC080057C8CC63AA6719081B4F7E44
      475321F2D16B45424DC66095B66B418F539C5626077D171516D0F522F3A74DC1
      94BBF3651ADAC07799AC7EC4232AEF0AD0920DC7D453079C09F2B1C697D8A85F
      08543DE38E29AC9FFF17A7175C08379FA54C5054379E4961D342131BE8940035
      C02B9FF70619254F00FC9684B63A420A232CCC40561616B8A5CC310A21E974D4
      AF028A887B634FF0AD19BA817BABE80AFE06BE1FBEA6E9CDE605175E24D5C28C
      2C4D0B5B9821F6B67D93C46E8279C177638B8A6EBE611B2F5AF466D3A3F97A23
      BF99225801A47E817280CEAA1CE0139DDB6F9C2752DBACCEA497AE665A0C6489
      2511869439919EAAD720A43F93CCB131035B33D6266014B0300A601602E03DCD
      EAC6F8766AA6663A26AD3D4B73E5B223758F0899419125B4F8D4675E981A1A9C
      25428FD4A12971129BD76797D1A4F86E6F1CEFC6517055B381FDBC13C7BF783F
      65B7C67BE1E797C26E8F2A218543DEF8E7B27EEAB07EDA5A3E9C26BD2FF4D4FF
      DA32F9ACC5CF71E7BB7F67DDB889ADA866BD4469980AAF8E0BF6E79DC3C35FBC
      978767E70CC7E1E1A1A5C47531D550CB61EDEF1DEC793E5345E525D4AD4B05D5
      6C4C2E9E586DCB631583CA085D8E71E5BD1285D1D7050AA62D7BAA14251263CD
      04A162781A3FB7394E0FA0913846605B7B390D34B814E4E694A9100495774118
      02C55ECB81EF089F1A028E4E036B7898E38C9586AC67E8DAE2A62DF64AB5B6DD
      00847D62AF5B5FE35D5F3759703C52EA818ED2F04772440E8E4EF66C44D6E2CD
      23F870ED678C7057923FD672ACAF0EF73A8B404C77086AF95C226B91B6440D87
      28353F426D2789E02A6F12733F4FC04D3989DED56D7436FC601368E90DAA1E2F
      A3995DAFD25849D38776BCFA8EEE2C496F6EBD1BE333506FB5BD287A57CD89EF
      64C5E5344DB355ECE5F3632FEDED55ECE513632FC36F3BF6B2BE1695AD5ACB85
      7FD83E12D0E08422E713016AAB354FABFDF4D9FB690513FDA9FBE91B27BE5C5F
      7B095AE57971FC86770AFA37A77E76A564D5161C399A78E17C463E2217AA48A3
      2F6DB56BB0E282C786FBA2EAB53484DC9C1B79252215A7E915F745161E70F094
      48B99E3C440DB4A043490A9A4BDE70740A97E93C0E2BE6B130FFF2049BC28F62
      EF3AC2AEE7902A1C68AE535A69CECFD69C2B1CE74FD59CDF3CC566C828FA5E80
      9835DAC47DCB7CA5E958DB74C13BEAE612F9D6CB34E60005F764FF6D3E9D291C
      955FD41236F48E0E65758301CE4C76653528EABC30CCFD04F9EF576994D40CD9
      787D4D3CEF33F6BC198290A327F2EA77FAFA2B0C795F86CC04EBA8830276AFEF
      31634008F6700E348234D1D6793BE454DC10ABC6412E701964BD04852AB7851D
      81E2D58C4CF1DB2A9284E103E8C64B6706363BA26E1CA9F5FC0B3FAA197ECEFA
      9AEC812879CAA8DF7628B4DC85993ABEF5028467789C410ABEB5C2AE218465D9
      888A706660ACA8F5BD40758C1FA089FC4688388DBC9700143CA6979593AD6E16
      D711536348DF168F5D5E38559E0C181AD2F890CF67EB6B33E97CD8F8495AD89E
      5B1A24F38EA41A81F7C78F9BD6DD634105F4D915E5C467992A9D56BFB582AFF8
      444BA5FFCD13FA22B24A5B2BCF4D56DC875B1ED0EB282CB89B0658EDA3DFBC8F
      DAAB7DF489FBE81B27285C5F7B31BF4096E2B93789539FCB5766B066F95CF7B3
      2817E63ED836314AA11B93F9AFBFDE365ADE3948ACD1B892991CE9566C35F442
      2CDD86A4313699DC406F8978040A40CDDFE77ECC108B1ED984E4C45FB06170EB
      D91275F539E2680A3E402916F283609E01C88FFE56D36CA3E78D6F0BB3B9FCD5
      9C47CA5BDE0B2928E5326BF05FA15D3690EE23AE24E58FE5E2B1682C616CDCF3
      C9434BEC885F59A991CF56235BFFF1956478FF6EFC541976070FCA9004F4A00C
      3F45728D53233B47FD6FC9F5B75AADC6234AEE3364F5FBEB2DA0C9C08360A06B
      ADF09056775A6A897F1D5D48E5479119C3D18AA7FFEE3D245495E9BD6F8BDE90
      98237BB9F64D5240162F736C107984E6B1910FE9ED030D0EA2CF7E72CBF9EC2C
      0A2B7C7CDCD53F8574A16F0245C70925D4A2F7D8447F09FFC59A919B0A3DF94B
      88513994CD9ACE8E8215332AEC733399C7B639857DB2294D7604766CF24BE628
      20296C4B139DDFE4A53207ABF832AA7B27F3629E992613FAF8313DCB8D9F7061
      891FDFF8B7391CC26B0CCAD778B9E515F4364CEBA2E5498FD8CB93EE2B410525
      657C0B9B8D1C42BC91D085904BECCF667CA18A560B574A74037DDEA667BB25A7
      FE157CAA4CBB7912C7D04E9E39DF1ECE14A6C8D681556F8F0006BE02F7100F57
      98EBD7D7680C9506C5E542C3F143EB7ABC4066F005B6FF4F3BA7C707C7DF3F7F
      EC52475A022EDC8519A8AC759F1B5C7216A44C87EC0C9E096DA5E27E0C8054D0
      912974687089A5BF8926E64A3602170BE82D78F6E6392FC528B7AF224DC37EB4
      A3B4E4E58B4F87666692D05F5E1389117877BE0EEC94BC55510EC51B8ADEA145
      C8E78F6E1ED071F027D7D7746F17A91BEEC29EE3C7F7A545CBE2E39115427B18
      E687ABC7DEA1DDD19451D83D8075C6B92408248A2D211823F5C77E067D1286DC
      60E6DF9089D160FAA88AC8E87DED910131F27C86DF7ADFBF90D59ACD85506B9E
      A094C4F706BD318DCE7E354DD84F5CA0BAF27A3ED75CE9B6B6BCFDBFBEDA3F3D
      38DA3F3EDF395CB9409FE8027DF3ACC2B217F5EC875F8190246A98A4F9EF4E51
      46537D1EA5019C422F4D11EE13AFA26218D04FB46D003B33A403494E6BD20A0D
      F933E0EE5BD5750DDEF93EB6F02D97C2D1D501141D391FF3C076E7CE5280FF44
      4008A0F3D8685B05BA95F5C46EEC327D1942EFFBDC9BDD7034B7352B344BD504
      E1707352D16CA466AA3859CE5E98A67961E14A695A8570523DD5A9F1938ABDC3
      0A36371AB5CEE1F7DD40C3560B04DCC56114A21592DFB8E556C5DCC4136F038D
      2B98DAC42BFB0DF369D3DB3D2BF12FB84E57BD4A9B37185B658E51904D74C035
      F80E521D6F48E3BD1C2776FA14314700CAED71C627CAD32415187F7A7CECA6A9
      E1D2207B6736DCAAB7C76E84C472A3A315548E5C2C563AE3493857C6CC44FEB8
      73BEB9F0EDE880AD7CFD6584CD517D003EBBCF179E5E3944253BF2942F7FF5FD
      E99E18D9C6CF6230B5585AEA7AAD5434A0B9715A88FC2864FB279A7E31FCC847
      1CD18BF9056A3839E52311132DB6082ED328B0A5E76323101816CF49ECA77A8D
      747DED9CD6E3EB447AD659072BEC4539A5AA2DC4727C853415D97BBB3F9C7A3F
      6FF17FEDDE2F58F9FBD2D3FCCA670554DA7A67F4497DEF8C1BDF48AC2733D6DC
      DC04271F50F38FBEA6E57D1F71544C6D506F265F690B5D0011C355FDB4E1640A
      545F84CD852896CBD6912EE08A71B18C79EA6CFBF44D9AC5F4318EC2459332FE
      36C34614A0B9CCB01786598774A4A5407041A48F8F13C24EB7D18D38F915DA13
      C97A06353B7E3E7A61B07A457CD3C99BDBAA60434837129F5456864DD1BE7174
      253DEC0DE1E4F09E1C544D0249233EF14EF9842B8F702F4C6BD7C722822C3BE7
      54934062A8D3BBC9BD6AD5098787C9D7446185FA532265B226A14A034E172B5A
      12AF76BD3434FA2204CF4EA6ACD720465790C413F88B69B5CA4AAFE07A5CFAA1
      2C5D06FC281BE0565ED36FF49A3AAB9CEB273B4ADF3C19E1F788EF9C59B08F8D
      EF8FCECE376577623333848D3D714C9EC6D74C1D8EAEB5543045D2EC60AFC911
      51B1146AA6C876B4C645CFB553732176AD0305E33A7E11007B8BE2ECF9DE4B64
      98E4C32BC5F2D98AE551B347DF740EE4BC1A6DD40402F7094EFDBF91FF9F54DC
      123F8E8A5B8DE357421D63B6F39125D51A26BAA11625615D4FA76466AE4EC3CF
      5CB4EDD60A2FE753CFC26F9E2F5350CF6CA264126508A920A9509610D04147E6
      2A3B0C6CCED76B0D9403F4BD0EFCBEC5C17101A81F73CC0D6CE53E2882EA3542
      846D1C4E04DA802ED2ECD66BFC1085E48A219E719486DEF7680C6A588E3CF24C
      C64611FCD8AEA9D7889961C1721CD200AD51E6D169710CE34ED632629617A6A8
      4476F05A22D93D5AC93E030A9414B15F841DE86B50E3CDA04384EEF1955F5CD2
      6447756B8BDAA179E04C77639E00A63469D898369C5F0E29492194D6EE238FAA
      763A9302D46BB467CB51840D664167C2BF88B3C16A8E17A9975F45B326B2FAA9
      6DEF6B7AADD6A6F62F04D5FA118ED535CE5CFCA0D1747F1DA78991D44CE30049
      88C273CFD0A897ECFC10C9708C7C2E352052A06E5B1F6DB3463A994401124C0E
      30A44E83E482C609EA19CBF32BE033EB264B91AFB7F0AB646796A5385C6AEFD8
      23243A1465500F0880DA148A6F17D70617F588E036796D688A486D70595E7CB7
      7A498F6C3093013CA5B831FE55995833A89188F2A91E8352625301590A62BCE4
      F248F51AF4FA1A1F8B13B75EA23BF9B8C68B791457A2B84C729E4966A7E16DD0
      CECABDBFCF11CEF7BDB114ABD26B91622F91B60D8CC085C388DA6C793B4C13C0
      C14D57241292A2510E657A2AC485F5CB42EFC56D638151DDC62F4B6A46D78A54
      C2C564E5E74103E32A6FEA098A73542A2AA427FCD92C468E56995FA408C696FC
      075116CCA73049831A06CB9783E1DC8599A53736ECC41E9197A3EACED536720C
      0EBD67E0C7E2BA1F9708BAC9CB6E2BAEA1B691280198E4924001D29A9A69DAF2
      CE5257640783C1F879C4C100B2F52CD737A082D3F4AA66DB1C59B35B14955F78
      074FAEB939F122E5E0BF3FC661F0E7559FD567463956DD219F1AE5F8C6296F16
      E3FDD0BBD29B18560A9B4849D4CDFD7B6993A9DCD20CF3ED156A56B8846A374D
      4245DE619A073A2C431EAF74B9D62DC4E12218B9B7C106BFE83A3E05629F8ECE
      9AB154ADAF95E9A74AF597BA7A15474FACB94D9E4429037E26E8215C0CEC7BAD
      C2E43D9C9D0EBB9E4BF65DD1468EA53F434C00EB83431F7EAEC5180E6FD1DB50
      9FC9C27122EF3FF3734D79697BB483AAAC99AC5F590338E3FA68A6EFA9765A42
      AC121E2C45A774306598F082ACDAD5B9FAB1D3F2DF6479FD08B30B072CFFB543
      EB770F5C33AB9C97C4DD4928B0DED820C506BBB94C69F1A9418288EE5E4AC63F
      79452D527CC62FFEE4FD4086F1648EAA91E29E4AD007A87D70AE59D7417B10A4
      F9E65D59F7E8DFE910B91706FBCB81603F3DC0E2C0580FA6BC283EAA3F0430DC
      5F6C02CAFAD2A66BAAE4E650858FBE64D7C3780D1693021D38A82668C2797229
      1D43139AAC4B89B59F28743FDEB7A7F347752EF86DB2D6F2B8D3DFA69FF065BE
      DC52BFB3B4BBEDFED67071665558EDC160D8EBB58796A497A6E55FDFA2D6CE84
      7EE17BFDADDE78ABBBD56BF7B6B6B606F4FF91940D7668A79AEDD06C4DC693C9
      444B0983AD0EFFDB95BFFBE35E77301998616FD0C7CFFEA4DF1B6E0FB706FD61
      B71F76CC70340807811F6CB78371CF04DDEE567B8B2E1AF6469360D435FD4ED8
      F3D7D7B6837187BE7CD4E99BED5127188E4C30F43BC320D80A46DBDB9D5E7B10
      6C87A371C71FF6FBF430C35E1076FABD5EC71F75B66870412708B7BBDDC970DB
      74C7A63BEC8CC3F6646B38EE07DDEDD176E00F7BBE3F99747A9D0E7D8D19B7C7
      BD613FF4FBE1A43BEC4DC26D3F5C5FEB0F46DBA376DB6F8FBAC1A0EDF7B726DB
      A3496FEC8FCD38E88CBAC3D170B4D5A39B6DFBFD8EDF1F8ECD80C648CF31EE74
      C391D9DE1A76DA93ED2DBF1776267E77B4D509C6DDFE70D0198CB6262189D304
      213D7A3B0CDA2333A6BBB4BB23D30DB67BDD7068FA5BDDF1607D6DBCD50EFBA3
      6E688CE94FB6490C3DD3D9DE1AD3337427DD41CFF841CFEFD1161875C7DD606B
      9B0467027F34D9EE916CDA031A1BFD39DEEE0C27FD8EF17B1DFA16BF1D84FDED
      802435D96E6F8FB7CCA86F067D9A9676B7EF8F42D3D99A74B6C6A3A0DD09BAE3
      ADF53508BB3F09260332F0DBF40566309E74C7DB66B44D8F3F0E07FDED41300E
      421AEFB83332C3A03BE89B20A0C7684F26EDDE606BD2EF4ECCA8DD0DBB41408F
      311E4E64AD4CB07A68BDBC6F9DD16C900CFC21DD565EDC223FA7CDBF8C75A54D
      861D5A63C1B0DB99D0BAD2DF47584893818F9545CF3F3493517F1C9218DBC390
      E44D236BD3AAA29998F8FDEDAD5E17D3330C6942DA9DD1703218753AED71482B
      C2D0CFDE647D2DA069DDF2C763923389DB4C26437FBB1B4E8C6F46E3C9B6696F
      F70CA433D8F67D7F6B10744DA7470B2F180F46A63D1C74435A9C135AC1DBA3BE
      DFF3879DFE163D0E2D9EADD180BE97BE638C051CF4B7C2B6DF253185DD767BEC
      F77BA3F1A0BBB5DD6F77681626A351B8DDC3551DDFF43A835ED8A619DE0A3BF4
      40FD70DCED0D3A9DDE70E20FB7DBC3767F120E69E58DF0688664463BA33BE9B7
      07B4B186DD210DC58C26FE28D89E4C68D5908C8260DBF426419B3E3FE904A6DF
      A34919D096D9EEF58201BD35A027F0DBB4AF48F7F6BBE390D6F468D0F7FDB0D7
      36E1D6B83FA615170E26A1CCCDC7CCEC603CDCDE1EB40723D51823DF6912FE8F
      34077D0369897E6722BFAFAF55FFC2EFBD906E60E8FF43D22B1DAB556830412F
      DCA2B9EF40ABD09C0E43BF3D1C6E6F9136A0C918D332EDF507B4E983B16FC6E3
      093D59AFBB1DB4FD5E9BF40B49747B42EB9A76A0E98EBADD6160425AC7B465C6
      EB6B341EFA852632D81A6E85237FD027956346232CEA21E91B7F48F3360AFDDE
      A81DD0440583C0D03DDBB4C1CCF670D426898F7B23DA68E1A4B74DCBB2DBA767
      2355416B90564638EE8761672B1C8CFBA4AAFA9DB6A1B908C3BEA1FDDBA38542
      AA8E9E60D81F9A11CDE6B0B34DAB8CDEA481D0846E75BAA34F91FF642B1874B7
      FBDBA49487782DD8EE88FC070FC95F7E5F5F2BFFEAB6ADCC4DD0271D31A21D43
      6B9256D1D6C4F4487904936E87D44587969F19D17EEC9006A385B54DB7A44F84
      3460D2DEB4FEC2C9807471B8BD3DA143A3178CC674BE0C7CBA64D0DEA23FFCE1
      38A089EC6CD31C8E86EB6BA4C048F3903C7AF477972674D4A11D3CD9A6210FB6
      C7B49069FBD24A0FBBDD6DDFD02AEBFB741419D3A1E16F8FC6BDAD01097B4C47
      E9C490F6EDE3FFBD70320CC360D2379D41D81BD3F492A61BD24EA0AD49C2266D
      67C6866442D339E8F4D6D746E1C4A797BA744AD0221C42A590C21EFBBDADED9E
      4FBBC1D01776B786C3EE84D6D7D08C693F863D3A023BB424B6B68783DE5697F4
      796FE8D3950169693F18191A66BF6B46C3419B94E784F47EBF674C7B3CE9F483
      719BF636EDE336843122B9D2C9148E48158FE8DBB7E9E9C2A16F3AC3D188B48B
      D9EEFA9DAD5ED8A363D490F6A723968E86AEBF1DD2A21AD360BBC61F4C48105B
      7E87866406DD1E2D4A3FA41B6ED38A0947419FB67DB7D3218533A025DA23CD6A
      DA5B9004E909D262FD3030932DEC05D3EEFAEDDEB0BD45333EE9D108DBFDE1FF
      DFDEB935B9712457F89D11FC0FF3683F38A2EBDE1D7A124529B861512B2F69FB
      C52FD53712D6CC809ECB7A191BFAEFFEB2711934D0DDD355E4DA72ACA00B3998
      CAEACAAC93274F168046E80863144A03A8B80CB0E1235B385F195F97EC8D334D
      8926D130A78930A631650D80A2AD02B0EE8BB62E0D09409520A2AAEC551D42E3
      7151D535B200B4421A9DE0A092C2D558440070F1D498E0CA4248B24754948ADD
      256D5ABC506DA06A43ECD460E60529088122C2DA42CCC0B522084C59F13F7C88
      B090EA3B36BB34B04B0F0D68EA670D6D77BEEF7AFCAE2983C4A0B3211014D846
      59672A5212E146E9804578AE0EB1D6AD56B62665FAD8F685EBBAC2E276D35A1D
      A80625524097D1300201421254A6A466D6602436AAD64545B68272B61F44DBE0
      4909B6B982F40AF845C1CA9A62D068D3746C69E535F9D2809CA82A411210AF2C
      BD3214D9349074048C1A09133574D15033AA0631C11345CD3AA1B5D029DC4599
      D92125E0104A70D1F65AC41CBC48FD21002420A4D4B794E5972F7A27DCD886C0
      20F6C353019BBA825C2C8EC4B6D158315419F9B3A14A547D28E4EFD01B35A927
      1C15C6CA210F509440A76338FF9A8A21CE2047E069DBF40A6E90153086BF03B0
      2073A0D26AF933D654AD9E90A13C8389A1B11E050336288A654BB49BA8B4A3CC
      94E811D309F7EB2019A554CB2F0A4F2CAC53A51457E2D5B79E228C022801786D
      2DA5D6510B6CF4AA85A660221F3D4AB44723C048E803A8A1E2222DE297B216D0
      749A67C19635E489B755D53A78BAEF9C6BAA082DC10B6CBC4686D115223D1B87
      6E812F45BF04D4A5AB1BD3B88E8A5C5043745537910CF4E80BDC51F00CD0C0A4
      710DD5B92290B5C2B2D12DE406258210132115AEDC19D574C834900F5596D658
      1B1BCD72519C46C3923AD29280DF123D65E8994AA8C1F730B3279094768D2EA9
      BD7325F9096AABD2A2A6D00325C21020A221E0C406C02827DB4F947080F8336D
      CD085BA2D32DCFD5487E18277A1462E142492668E2C302490D0F5648368396ED
      8111928A8BB12B70774FB1815D2B2B64E92910A0BA0B0578B78DA52F68C95D76
      814CF2741C00BB63C328EEB099D405D68BAED372194F4E5794258971537A2E51
      18CBAED411298408283D3CD753005A640F3F51872BE70A08B8EF51BA010D0534
      1BD2093D4676951E7654B54747D2B15885A6292954BE2A9442E3D802894F4954
      2D8D8B027AB438E87216412299AE0E743ED4C08A4A47DEC5DE960249848461CE
      02F53B8837720AE8B18B657078C60E851EFDD4236402851FDEC01D721F4EEC4B
      095810ECF740D41540B2E87C15201E0789FA16EEA49043B6F423525360CFBE93
      021BF8970A56C2A32493823F8D109B486CAB907AD46F8F962021AB661045B29B
      B01F04E041067C35F0010922ED83A660120EA8BB451E97927092E05CDFD0DFD0
      344561E0129E921EC5541038FA8B45C0234E531D2255CF212D3BC2DE916C9102
      5DC0AB15F9DA5BDA36C800B1126A4BD9A80B617D5859626090B6033B100A0881
      380BD17B69BD1AE472CDBE804120839043DA8133B6010D87EA7320A571352A05
      9289F4472847D7C7C292C45C1A85C03883FC4026A0857BC280B195A681C4212F
      A19EF2E50B580A507AEB9A0E818B16A8292DD08168CA407145EE9B42B3053445
      2831AA5220C0B5B2C83A2A20A962494692864202CF07D7A8B6A7090965050A01
      0495BA89ACCFD81E36E90A7A02D415C8432B5011D985A2A3C017A49728194F47
      C28549165A8B324A982CDA0312D16C34346C6DE042D445DA41049E94CD889041
      402027D81CDCA69D29503C0AD820AC82437506D88309CA964D50A6E292E80B69
      436AD905A28988E922659A3A8E3CA059A030943062DD32B6020B9ACA4BBB8C02
      D23511969A816C0E7504F8961EAF02001A6CF17B543E3BCF645257BB36D21A29
      E644C6010BAA4161A4DAA121C8698BF0879144333545574572CBF590252A109D
      492FE00CFD1998A2129100508EA80AFC0B4A8E4BAA9A6CAD2BD5496C1D4A5501
      40C7BC140265E98EE98CA05156466AA2FC4B3603FC5B140F0540217FC880D851
      9D7BA671D235B0BF0801547C47AB4370F92B396C281AAC97EE1B012892023D44
      C0C8098A0BC514618C66A35F2E2B580C1D2B1D82439DD0DDA0A7ADD41ABA4DC8
      919CD5B00C9D38DD0F19E37B9880CA04FBC3DB342288975EA16402222C1A5603
      740B3A085F88AA85B22B3256D76C2C5C08B77B1DA50A21AB5A0DCD96963A05B5
      52B961A70846882B4C830244CE53C02919018DE5E5E803D1D357C24B3DB9400D
      0B52389C130C02BC1AC189A721480635080C12C8B7A165530A8B137EA01B51EB
      7503B9B26545A5E8970DF8290C5A59AA001904070160DA5E2207266893694A7B
      298D6C04BD0955AD8C15BB00EF18F1BA73C4AEED45EEC373A1D61102690A38DE
      8A98B27016A90CC303D648BD4286524B2D3BC136D1F8D1161672F682684235C7
      BA42BEC2888EBC815A1DAC483960A5F8E6A9E2554D76505650696DAC62282171
      8284DA013F9DEB3D4404B5114B883CC260303FA950F5118CF3AFD26012C53BB0
      6C89426D7C5FFBCA2142BBC6CB1119ACC092A4212CDA487566D1950723244D0D
      26024DAE68EEE08413657607A471BC12FF6882F889CA45F6B3B39022E23652CC
      699103ED873849CD683BF2A788044F8E97425D0B6397DEC30FB882F0A46CD335
      42A6503AEA87828F8C44794B87049AA8B9301CFAC0A359E96D053345ECC0474B
      13C5B6E11919633C85473B8FEAA27CD74DABEA428ECE0AFA1D04AF485564282A
      A2EF90C4E8F28E70B24E54521778A0C9684B3C6D5423BD286C419B43D316E9CE
      634D1726BD331C0DBB42F35030F00D4D4BFCE1FF286F322490FC0F914FA74257
      D22BA4136280009B96FE8C90C949038B45B75B9A12C345C93C0A04EE9017281F
      C045D524073A281CCAF37204A403570A048E5D20C9596741D3D7806A23670F21
      F6225B0A76001D1884EB9487DFE97ED12FA28156F7F4B8A6AAA20224FBB3947A
      67ABC3A1A7671726BBFAD353B4E7CE57C6A76CC3498B868A61881E120872A845
      31A469463A548A7EBA4529154498A6B7B4D23319DA4C50D6235F155D16FD055A
      BC296010E9596A69D9AB1A26AA5ABA57061A3A5DA304710AF96EA4A77781D28C
      4CA759ECA04E8890A8D1F4216610AA84083869E9D6C8344429F05442D7162E7B
      F982EB22303473D22401041DA4F1AA9A166A9653515AE30E31664A6428DD808E
      22DF15AA135EC7E540674B87D7CBE1A90A72CE433DF36C40908A5728397128A8
      39D03B6110998C6ED4B42C4A08BD734A742222021CB1EC32CA3111ED1B3ABC8E
      D122C41A2A2FF207A26BF7E7EBA3DD57B483AD7C7C3FFD5CFEF078F9A29878AC
      3BB57F6E0D7266BB74623BBD0216388C9A3ECF7DEE9ACF9D264E3DE817AA5D74
      E6CEBA9ECB84E756F5DC19DBF42E509356AEEAE9FCEDB995CC3103B910E62344
      02C7A595E4B1C6B05657F8E365DCEE3FB73FBDA4F73A22E5D7972FE445A9667B
      BDBDBB6FE4A5A99BFD4DF76839FBFDCC053CCD9582A11ACBB95BABB5440681AD
      B5D02A0DA71C2B7A692382FC560EFC2C05D494320222B7C38AE5FF8DCC406419
      152AC13D73D13F141098BC020411187CD0B6953E4784D96E0D648BE1774AECE8
      FD2DFF20474130CD81B4D34364949CA4F93E0C6BDADBA1D3888BFCCEEE7FAB85
      2BBCE54F452519D63C7849CF6AC81283CC97F19E7ED77783875898DD951B7A0B
      35F84453BC7FCEFA7AF7DC304E1FC7E9E3387D1C373CC7DCB2E68101F6738C9E
      791AC30A76CFE98B519733998B31E6628CBD18632FC6B88B31EE628CBF18E387
      3125119788D6BB7D3AFC34FC8E9DF08D1D8F387B8E7160618F49791FD2EDC3FD
      C3E7EBEEFE3FAEEFDBFB87CD4DFC8B095E7EB8DE36BF74688ABE187ED5DD6C76
      2F191F9ED9BD9A2C1F02393CF35FBB77661F7EFC74B7D9DE6D1E3EF37355FDF5
      69CADD17C65F9D58A8ABD3F1C5D5D3D8E2EAA7E17B0ABE991D5D8D467FEC76EF
      8C51DFBC7C315EF6CEEA69D16A7E01D353EA6FBEF284E66B4F68BFBED3EE6BAF
      D17FED09C3D777BAFCDA6BAC564D78B0DA90627F598DE0B1D53A908E6DD6E170
      6C63336C5C9647EB0033B6091936EB367D6C53ADF4E8800E3386C7C3B6619BBF
      7082753BBE3081F97227D6A16161827534B33081FF7227D68166618275085A98
      208D267685F1EA0FB772F7AAC4D4EAB7DB87DBEDC3EEC32949578DB7D8EDEFEF
      9D6A2B74D8DD2599C84231C9218E3DF9E673B971A3599B38BC552E69F90FC367
      C6B6FD55BFF9F078D7DD273AD2DDFEB9BBDE7E3ADEAD38E9DA47E3BBEEE1F12E
      6DDD477C1C3FCA960B92A709D25C1F3E17B5BB5B4AD2A53FC50F5976E8DA2F70
      F8603DA4449AA34788C4C7878F82BB4D97B6CF37B1B9DBA6A1721B93B2E360F7
      E3E63ED53B31B97AF5787DDDA551C560F753FA360E7669226830595B04474669
      2268305957E826A297E3D4DE32CBB7BD6D868B7BCB0C4F77FB9DE3E9DE32CBD3
      BD6D86A77B4B37DF9CAA712FFB7EF3709D462CDF5D6FE5D3CB897EBDDB7CB88D
      F2F511498A643CC7EBDDDBB7870F687DB88B9F3E5EFDB0BD4D4BE257DBF6F3D5
      FB549570B4CA9336C3CEC857946C6E1FD3623DB2CC41E1D136ADA31ADBAE6DE2
      A7ADD3B2EEEDFE3B65DF3C09B369189FC1EBB17E4846F2BB78FDB8D304890EBE
      8E0F69577A02D00FC3BDA1F630FAF2291231F193288237FB3A9BE6F3D3F5D32E
      F9649706C1F39CCBBEECDE3C95885FC95FD2A9E2CD67B9E5E3E6F69724AB1FB6
      72EFDBAE1D5B4F025FEB31861FE44E267BDFA60DC684FFFDCDA78FF17E9326E8
      0E1FA3BA7A1B3F2519FE2C9F664C8FE2F7FF74235FD5FE5434D2F6EECDFBB73F
      5EBDDF7E120D2B37174DDB41317E253703B8C9B2DF37C1FFF0EF5DFD8FE917FE
      16E57CFBF926C7E16F333AB2C1F0BB4D229DEDACB66D86D5EBE31767E4B8F8CF
      DDE77A1BEFDAF4EBFE4C173524C7439761FD2ECA27BED3EDE433E5FF4D12269F
      170CD6FF16EF36D28AE5C0EF7DB2E149877CFF58FF67D7A4A5EC4FDB9C66EC8F
      BB8FE8EE24C3BA83C749D3B4E230324D2B4BEF7777EEDF081E920FC447C6694B
      1E99E62CF9BBE1AE4C6B4F77A76D7596BF07EB2F59755A2BB4B79597B7E55BEF
      B25C3E1867FA7C30CF727A7BFD78737B9FBBEEC136075D07DB54A934B6CEDCAA
      C136AD57D8D9CA6D1AB3423518E66DEF609AB3B583614E8406C3ECF0AC7D2D62
      C234ED85AB13C3B457AF76861965E0C4306F2FB38B40C681DB8961CE5E0E8679
      7B3998E6ECE56098B397E6F555377CE3491E919D98E7EDEBC90479247CFBD0DD
      7CDADEC5BBCF19E6DF5F771F62628BBFB3FCF96EDBCB0D02E56E8179FAE2B17E
      18C449B6694EF1A0DDC9BAA4D8E56DB058269E29C857CC6C4FFAD199573E9F58
      2CC3A1F7F27EBA49BB93A6B8E93E6EAFE53685EF9F5E9E993EE73A17D9EF3EC5
      E6F02AC961901FB7F83F0E37057CF7F1E9E594E34035317090EDA3517A62D431
      1AC7516634EA6DD76E1E6F0E57DD43E138D62E8D3D6CFF71B49B1A7D521B8E03
      FDEC403D1E18A6069E2887E3C07276E0D98CD5EC40331A18C67BF33ADEFD72DA
      281D878D77E6A81FA77631E8E9B1171B19CCF4C0CBBD5C00D0D5B74D23473F6A
      1D929E869F6DEA1CA866E65F46D78CD132CC668C16D036B698CBE73F757FDEDC
      3F9D684CBF726FCFDCBF3F791D63E1B46F0CB37F79DCEE8F6AA62F32DEC63F50
      C16EEFBB13AB35893313A5850C9ADDF285649AB9CA42564D5BCCA5D7CCE8E52C
      9B315A48B739D797326FC6F51529A8D35250AF63F599E1EB12F082BBD7A5A04E
      4E419D0CE0F52560C662057C2FDC5F01609D04609D03609D0C60BDBA70CCBABE
      02C0260DC0260DC02607C026A7829804C53273A1150036C90036C90036C9FC7B
      EEFB730036390036C90036C90036C9FC6BCFB7FD3900DB3400DB1C00DB1C00DB
      64FEBDF07D05806D32806D32806D32806D12FF9EFBBD12C03619C03619C03619
      C02E8D7F5DAA8677390076390076C90076C9FC7BE1FE0A00BB6400BB6400BB24
      00BB1CFE3D777D0D805D32805D32807D1A807D1AFFFAF30D5F07609F03609F0C
      609F0CE00B7F5600D82703D82703D82701D8E700F8DCF53500F6C900F6F3BDB8
      1AC7617FB23A7AF7CD74C73FF6EFD0C31F0D97CE18D4D425FF347AFBF8B4A19E
      BCE61ACB71905E6DB7BF24BCA5F438CB1897AF36F5F5663B9C8C7CFE928FD29D
      9FEAFEF1BBE37BDF4E87D98BD35979CBD270963B6ED1AD9E1D386E9FAC991D38
      169DD6CE0E3CD71DD6CD0E1DD3A81DA7D300D7C34B3910DE78AC9F1BABA64687
      B9D167EE9773E3CEBCAFE6C69D3BEF667D72035F8CA6756A6EB03F66F1D840CF
      1984698367C3367DC4B310BFB973A48550CE5C633EA6D306CF8576C66A458CE7
      7C5A13EE19E7D6C65DA7C67D3580E74E3F56C45D67C55D67C75D27837CD6B9B5
      7137A97137A9715FCD2073C7156BE36EB2E36EB2E36EF2D07E512A9E8FBB4D8D
      BB4D8DBBCD42FB05F127C4DD66C7DDE6C5DDA5A2FDBCAB5A1177971A77971577
      978DF6739F52E2EEF2E2EE53E3EE53D17EDE3DAC88BBCF8ABBCF8EBBCF46FB85
      73E3B80F1DD16A1178327AB1869E8C5BA4F093718B0C72326E2F011789E364F8
      3A117862B04E045E866D95083C8DDF8CC17C206755E37C4C5789C08BE0AE1281
      93319EB15C11EC59E7D6C67D51044EC57D3580670C9E8FFAB9B05A1BF74511B8
      18F74511B818779D87F673BDB522EE8B22702AEEAB19644692AD8CFA85744C88
      FBA2085C8CFBA2089C8FBB4D45FB856A7C3EEE8B22702AEE69143E639510F50B
      F99810F74511381FF74511381577978AF60BD5F87CDC1745E06CDC1745E062DC
      5D36DA2F9C5B1BF745113815F745113815779F8AF67361B536EE8B227031EE8B
      227031EE69F7B07A8B49FA47F6DEDDC877E4E57D22F64DBCFFF810D36E06F2AF
      B777DDFDF65ABED8F3B0E0F4E5FE282BFD75F8D236F9BEB6FB07F9A2D4420DB7
      D3945B8BEAFDAD3EF7B701B5F2CD4FC34D278DD69D3356B9D295B6955B5F7BE7
      957C7182DCAED378B975E6E4C3EF666E8BA657AA2BA2AA958A9D9ABF81E8EE61
      BA62B8BF6BDFF5BD7CA1C9C9AD3FC70F75F6E7D92FC4BE3FDEDAF6F2E7E3F37F
      C3C7CB177FCBD97FEB8FDFBDFFFB7D4C78DFEEFFECFE7757F27FF1F87DEFFF7E
      1FBF7BBFFC70280DDFEFFE0BB61884874585F86EF773E089503DA712F21FC3ED
      D4DD7CDD2F1A1FDBAA2C2BDDABD62259BC63A5B6A8BCD1C31762CC3C74A1E2CB
      17F2855BC145D5FA42CD298EDFCA633602998FE91BD4FF961F5F3302FFFFBC97
      C7D78A4086F7FBDEE3F0F8F5D7FF017D07A6C3}
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
