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
      789CECBD6973DB489628FA5D11FA0F08CE7D61A95B920170AF99EE7B652D557E
      EDAD2DB96AE6152B6E804492441B04580028895DE1FFFECE9299489084168BB2
      A922AADB12050289CC9327CFBEFCD14BB2A1D3F37C310CBD68E4D86EB3E74569
      403F06D391E336DDDE6CC0770CEB4ED36EF7F093DD4BB3743CF4FB83315E6CF2
      9F61CC7FB6F8CF7150F8B31FE8E7F15D75BBE3A8CF43016FEEF4B2B19808FD9D
      FE6BF1DB416AFFD11BC65196F543F860F760683FB07AC3249E78516F38187B49
      2A32B83E4D7E77FFE8FDA537F5A2381596EDC2FF5A76DD6EDA0DF8E7C2A7C697
      CB602252EB9DB8B63EE2E3FFF9058674F59093D817C9E2984E71CC368CD3A5B1
      71CC068C7912CF92402438EA7F7ED9DD8111EB259374972709E0B461C1F0AF0D
      93C541DB5F2EE6937E1CD2DC9C7CBD5110DE3ED0D27F5F7E09A2910FFF52392F
      A7513231A7DE5A0DBF8551BF7C780BC3BD093EE17D432FCCACDE8B7EBBF7A25D
      87DF6EEF850FBFBD6EEFC5D0EBBD18347B2F44F70B2DA35EF6E295DB86DBC5DB
      86DBE72288BD493F093CEBAD978D158CDB7AC8F43A48D3DB871CD26EB934B81A
      320C604C9A5EA3FE2014E8C3BCBAC5C1E2288D432FE53D8363F580A9F52522F1
      3F40D32F1762140BEBD36BB56BAD327CBAF7B6FD1FB56F34C11006F9579CF4E8
      88AFFB40D194FDBEF106E73B21DD383026E13E0C5BEAABB1C57A138CC6995C64
      DF1CBF6C8B1E4197609B82488DFFA003F4806DCADFD0FC7EDB944FA2B5A643AD
      36281FB9BDFE0D6A74CB0675EB1D1ED65A78CE3A39938F76CA1EC5AD5EFDE83C
      910B2B3FB54ECB2979FAC74488CFF4EE5B4E64CB2D79FA7296C867DDB267DBED
      9267F77E12FD445CEFCB014A8959BB0C667BC789D70F06FB7AF5A56CACD32A19
      E215E06330903328C57424B4AB67F07320B2C8838B422EC36997B10CB5F78E65
      08066ADF9B4EA7F439B9F10BCFE59BEEDA658FAA5D2F3E6AECB8EB943FEAAE78
      546FB75B2A1CA9FD2E3E58DC6BB794AFAACD5E787A61A3DD46E9F372A78BCF9B
      BB6C30E1A525D757BD7B718B5BF5EEED24C35204CFFA45A419BCE121848F16D8
      A9DF4D404CD1476151A77E37F5283E37E7FDEC34EE261C8507731CEA34EEA61A
      8547098778998DBB0F6CE151631F3B8DBB4F6BE1D9A57DECB4CA244513C8CCDE
      157C5B9DB2470CF8CA47F401EDB4ED92A74CE0F253065CDB4EE953EEC253EA58
      76DA65E24C4E85D5338513D969D74B1F5C84C5C261ECB41B658F1A9BC88F9AFB
      D72E1386CDFD936F5CDCBAAE7B2F2ACBB2B7DABCAE7B2F12AB1ED2DBD7ADDF8B
      BECAE7F20DECD6EF455CE5736A0BBBF57BD136F99401D06EFD5E844D3E580429
      AB13EDC6DD0742A9200AA8F0D0DD47227F48921BA7DDBCFB48E8A77290C27377
      1F0AFD5C4E68E0B9BB0F867EAE7032E0D1BB8F46FEA83E1BFCE8DD47433F6A6C
      253C78F7E1C8DFB9BC95AEE3DEC5A3FECF22935AD6004B79C95D426C6194B289
      DC479E350772CAD9CCDDA26D61A05249F54E29B7304CB9BC7AB7C0BBBCBA524E
      780FE97771AC52CE781F31B83052EB4E1E7BBB44BCA4F4BB7798151E253B2DE8
      F66E29655AE2EFA4BE2BF42D8CD1BD37C3976368E43587A99793AD45098087C9
      51B7304C29155B1209781885B88541CAE9D9A28CC0832CA06D61AC5202B72436
      C8B14CA42D8C544AF196A4081EC940D9C23865968265B142CE6819614D034EB9
      447D17152C8CF295547061985B44ED3B68E0D2BA1A5F4F050BC33C860A2E8EF5
      181AB8BCC04751C1C2488FA5820B36BBC6D7A194E219F9385F8F54E630CD4732
      D67CA0AF44A9A585351F895485B11ECF58F3B1BE1EA596D7B806A432CDB4ADA7
      67ACF9BBEECF5835E2169EBF3F5355086B3E7E8B625CAE4E1706B83F1BCD11B4
      30C0FD596801310B63DC9F752E32CD7C8CFB33CD022216C6B83FC35C4240D390
      DE7E0CA3CC47798CBA600ED4790C552B0CF42846990FF36875A130DA23A95A61
      ACC732CA7CA4C7D2345AE8200EE324EB87FFD94B846FF746B02B91DDEB873361
      2F5F729B4DF322FC79DB651E00FF5A31C4C2E5857B4B862879210FE1B81DF322
      FC79DB65FB3F7777F032FEBD629085CB76F1623EC8CACB7A90AE2BBF800FF445
      D7BD179C6DDCECBF60A4C6603C4552E1BA3D0CF4E879D23D87611EFA0F8C0891
      7F342DF5E0D49B5AB0C2DF43AB1706762F817FA9E700DF4A43B7D9859F935998
      39BDEBC01F64E1D44B7AD7893785E73CB8DCF3D2A9174EC71E7E886613E05CDE
      2C8B7B9EFFAF599A2528C8C38030D7107F049937B5AD2FBD28FE1DB02E9EC499
      B0FEE8A5D93C14E95888EC8F6F37895E9285008BE1207570F19E74397A04404F
      45DBC064B2846FB3157055008C11FB4200BF0BDEBDC128097C7A2C9A1A234453
      1CC3EAA591B8C9E02DE9EFC3389978C0FFD36912C44990CD6DEB1D5EC2081398
      6BEA14C1D4776C0216FEECE3C21DF88B7F3F085CF12C030089505C89D0BE37F0
      7A5E1F566823E4407E2E815CBF47DFAE82DD671079400002F5F076F8E0C2FB5E
      2AFC38B225B0E0E529CCEAB3D35C09B5AE85A895A481DFB55B8EDB70ACB1F030
      BAC672F0D0A4EED383D1F91A3002287230C2B2170109DFAF02E45DE8B5003C57
      01AFF540E0B9120BEB4F0F3EF76BC0E7B66FC342F8F6E1C05B817B7505BEF603
      C15767820D9386A13CDF0FB2E04AC0DDA99804E3C0F745047FCC22F82866F046
      634CC73A65D0591FBCC41B0128C7D6791C6534204C314B1D077E24F1B5DFCB92
      6196FE12F8D9F8551DFE98C28B42C7EEC88F49FE7118AAEF8799FED4D79F12FC
      34E84F3DA0BDF061C81FFAB0726043FC3B9B4F05DC955E892403F1033EF5133F
      51BF43F9BB2F7F27F2B73F0AF527756D2C7F5F5977F10158ED9370828DE1038E
      730B4AECEE303BB02EBD7E28343E354D7C2AA3D04B27C266D2ACC9704E291041
      19C7F1773CF85CC0C6650CFF495157EB04A44B3DADD6DDD3C2B7AE98165C364E
      9E9E8EFBB0E9B8C5E9B4EF9E8EDB5E391DBCBC3499FAC326535793213EDE791A
      12FA006CE7F5366EC1F4C67AE8A5D329C8338BF099A471A4441CDEA76EE93E0D
      EDE22467616F307417F6A69C9C2E6C0C50AF043752BDD8B51FF662C75D42D2FB
      BEFB3C0EC3F85AF88539A4EE1389776BC30A58EE57E2C5B210721B995B049724
      7A7BBF88FEBEDE2DB77CB75C5AC5C29E61F0385DFCAA1DDBDDF9E9F2ED1BEB24
      F605EF555108CAF723BBE93A2DF8E974EA2EFC72D11B9FDDD45BAD06FC6A343B
      C03C6F9A8D2EDED26A38784BBB8E41F4371DB7D1E0A7F116D8F4360D6377BB78
      93E3749173DF80DAE8E26D4EBDDDA0FB1AAD666BCD4820C1572E8B4A50AE050F
      9438E5361E7276712F3E2482A5AF4CF81A2B1A5F89152BD94D81C417E676C774
      0A8CC72D67CFC132690916107459C2749789E8D904363C0D52FDCA72D6BBF0BE
      C5759713EA69789893CA725EBAB89EFB8F3ED0A3776EE7D40B3CFA6E80B94BAF
      BBC892381A49F3D65FE02CA4598622D51FF491FF169369E86522F09D76BDDB84
      83576FF1D7A4A1F4E867341C0025501F23F5F95F035B7D88E4A721917CF9479A
      7920328340CD7F4DBD8190DF80582DA2CCFE83FFCAE084F45ED84E6F7658EF3A
      75EB7F2388F86DB3495F24B0E194C292B213DF238C0E0EEB2D3CDE6DB8F8AF81
      5C1AD219970E3DFCB268D9EB5ECA154C37828FB06BF75D57BC6A3D6EC97A9C46
      A3B820BA0023E36FB469DD7B4148CE9E6A49B4556E77F5563976C9DA5CA4FAE6
      DAE802BC027F3F686DF75A1902E0DBADADD359581B5EC0B5C1EFF5AFAD74656A
      D7D7B936F8595C1B5D8057E0EF6FB8B6B295C19ABF7A6D8DFA0201A10BF012FC
      BD016BBB636528AC96AE0DF3450A6BA30BF012FCBDF96BBB6D65ED16627A616D
      6DA625F8FB59AFADD558A02474015E81BF73A686CE2B0B06C2CF810F0CDFB5DD
      86FD65256F3F04E9DBED34BB9DC673E3ED0B9B6C72F7EFB5946FCBCE732EBE71
      88FAE4EC5CADFD7BACED3BB273BDEC275A5BC5CE37962D54ECBC62E7C8CEBBB6
      8DB6B11276EEDA9D66C7769C6EA762E7EBDDE227E2ED8AA23F1FAC5D1F6FDF40
      33C4B7E5EDDFD40CB129BCFD29CC109BCEDB1F23B73C73DE7EBBDCD25EA0257F
      2ADEBEC0D28ADC7D156F77EC76A3DE6ABAADD5CCBDDB6D3ACD86DDB19F016FC7
      6DBF8F217E23B6789DBC7D433C0BDF89B76FB24DE2A979FB77B4497C4FDEFED4
      36898AB76F2C25A978FB03787B036868CBB59DD5BCBDDD71DB9D6EA3E556BCBD
      E2ED156FAF787BC5DB37808054BCBDE2EDF7E1EDAD4EBDDD68BACD121FBBD36A
      76EC46BBD1AEB87BC5DD2BEE5E71F78ABB6F0201A9B87BC5DDEFC3DD3BED6ECB
      06ED7C3577776CBBE338F596FB1C22E82AE6FE1CD1B662EE1573AF987BC5DC2B
      E6BE76E6EE36EA2DAC62EA963077B7D1E8BA1DB7F2B957CCBD62EE1573AF98FB
      4610908AB957CCFD3ECCBDDB76EC46BD5473EF763BED56A75E39DD2BE65E31F7
      8AB957CC7D230848C5DC2BE67E0FE65E771CA753B75B9D32E6DE6977BAAD865B
      69EE1573AF987BC5DC2BE6BE0904A462EE1573BF0F736F74DA6EA3D16E9744CB
      379D3ADCD27D0E05E92ADEFE1CB1B6E2ED156FAF787BC5DB2BDEBE7EDEDE76DB
      ED56CB2E8B96771DA7DEE974EB95CFBDE2EE1577AFB87BC5DD37828054DCBDE2
      EEF7E1EE1DDB6D36BBDD923CF743C76900216A761A55B87CC5DD2BEE5E71F78A
      BB6F0201A9B87BC5DDEFC3DDBB98E80EFB5AC6DD1BCDBAD36CB88D2AA4AEE2EE
      1577AFB87BC5DD37818054DCBDE2EEF7E0EE8DA6D371EBB653920CE7DAED6EDD
      C552371573AF987BC5DC2BE65E31F70D20201573AF98FB7D987BBBD3B4EBADB2
      E2F24ECBA9BB2DA7D3AC987BC5DC2BE65E31F78AB96F0201A9987BC5DCEFC1DC
      9B4DA769B7808597D8E5BBDD4EA3D3729D956DE1EC1C2EF643C1722F48B8F0CF
      3E5A840282081650E86F3F24DE6EB6B7FF6A3EFF98553D7CB37189CE7D97B87A
      81C8E11736FEEE96B0DF7E95EEE356798710B05AC0F9F6ABAC3F72950F170734
      87FF86AB6C3C6E955F2118ACDCC9276C0488AB6C3E6E955F21223C045FD721D8
      E12A5B8F5BE557080B6B3A95F716F17095ED47AEF2E162C353D31EA2780BABEC
      3C6E957734965D2940B49CAE6377EB2509774EB7D9A8DBED4677ED31F90F14F0
      BFA2B3ECE65A0758B8FFB65DE3BFAFDC7BAB4CFFE45DE39F766D7758071644BB
      6FD835FE69D7768710F0AC2D568FB60E6CB0C5EAC9AD03DFD162F53DAD034F6D
      B1FA0AE6DE6ABBAD4EC3EE9465DCD5EBAD6EBBD368AF81B92F6FFA9F86B957FC
      BCE2E7153FAFF8F986AEADE2E75BC3CFDB4EBBD96CB85DBB849FBB8ED3ED7481
      9F570CFDB14773D13A5371F78ABB3FE7B555DCBDE2EE1577DF68EEDE71DA8EDD
      E93AA539762DDB69361A9DEE1A72EC2AEE5E71F78ABB57DCFD19ACADE2EE1577
      FF337077B769379D76A7240CDFEDD46DD7A9375706EA55BCBDE2ED156FAF787B
      C5DB2BDE5EF1F60DE4EDADA6EDB63ACD12DE0E9A7B07A850ABE556DCBDE2EE15
      77AFB87BC5DD2BEE5E71F767C2DDBB76BBD9AEB75A257679A7D1769C4EB75B5F
      43539A8AB957CCBD62EE15737F066BAB987BC5DCFF0CCCBDED34BB4DA75556FA
      AEDB763BF546B30AA8AB787BC5DB2BDE5EF1F68AB757BCFDB9F0F64EBBDBB1DB
      EDB2CA7776A3E538CD66A5B857CCBD62EE1573AF987BC5DC2BE6FE6C987BB7DE
      EE36DAED92CA7775D7A93BC8FE2BDE5EF1F68AB757BCBDE2ED156FAF78FBF3E0
      EDA099D79D56AB5B1A50D7AA779C16DAE62BEE7ECB26DFBD90AA704DC5D02B86
      BEC16BAB187AC5D0FF140CBD830B77DDB2DCF66EDBE974E0FF6B6842F32766E8
      95BA5E71F78ABB57DCBDE2EE1577DF24EE0EECBDDE74BA9D325B7CBDED80425F
      29EB156FAF787BC5DB2BDE5EF1F68AB73F1BDE5EAF3730B9DD2909A2739CB6DD
      000E5F05D155DCBDE2EE1577AFB87BC5DD2BEEFE6CB87BABD1AD371CBB5B1645
      D7EEB4DA4EAB52DD2BE65E31F78AB957CCBD62EE15737F36CC1DF3DF5ACD5609
      73779C660B06773A95EA5E71F78ABB57DCBDE2EE1577AFB8FB73E1EE2EFCAFD3
      6C3A25CD5D1D60FC1DBB6D372BEE5E71F78ABB57DCBDE2EE1577AFB8FBF3E1EE
      F516FE286BF5EAB8DD76BB6E3BDD2AC1BD62EF157BAFD87BC5DE2BF65EB1F767
      C3DE9B2DBBD36EB5DAB7B0F77AC36EBB55425CC5DE2BF65EB1F78ABD57ECBD62
      EFCF85BDD7ED4ECB6D76DC12CF3BB0F786DB6E376CBB32CE57ECBD62EF157BAF
      D87BC5DE2BF6FE6CD87BBBDDB69DAE53669C771DA7D56AD461E72BF65EB1F78A
      BD57ECBD62EF157BAFD8FB3361EF0DBBD368D96DBBACE16BBBD105F5BEEE56CA
      7BC5DD2BEE5E71F78ABB57DCBDE2EECF86BB3BCDB6E334DC92B8799846C36D35
      DC4695F37EDB26DFBD90AAB67CC5D02B86BEC16BAB187AC5D0FF140CBD61BB4D
      A7DE2A51D7DDAED36ADA4EB753F1F3479ECC4A5BAF987BC5DC9FC7DA2AE65E31
      F73F03736FB6A8437B599B57C7759B6EDB75ABC6311577AFB87BC5DD2BEE5E71
      F78ABB3F1BEEDEB2DB2DA7E5D8A559EE2DA7D36A379C6E658CAFD87BC5DE2BF6
      5EB1F78ABD57ECFDD9B077B7D1ED36EC5659EF9866DB6E773A8D6E15485771F7
      8ABB57DCBDE2EE1577AFB8FB73E1EE6DA7DB68D79B6E89F2EED41B4EC7753AED
      CAF15E71F78ABB57DCBDE2EE1577AFB8FBB3E1EE8D4EB3DD2E75BC1F3A8D56C3
      769AF0B362EF157BAFD87BC5DE2BF65EB1F78ABD3F17F6DEEC34EC8EDD2D31CD
      1F627ABBE374DB95E3BDE2EE1577AFB87BC5DD2BEE5E71F767C3DDDBAE5B6F76
      BB9D12D37CA3D3A9B79B8D76D53CA6E2EE1577AFB87BC5DD2BEE5E71F7E7C2DD
      3B6EBBD16EB8F5D2EAF22DBBE5369A8D7AC5DE2BF65EB1F78ABD57ECBD62EF15
      7B7F36ECBD61B79A1DA759DA1BAED96DB79C7AD3AED87BC5DE2BF65EB1F78ABD
      57ECBD62EFCF85BD779D16767E6B9679DE1DE0FCAEEDB88D2A6EBE62EF157BAF
      D87BC5DE2BF65EB1F767C3DE3BAD76BD6BB7DCD5ECDD75B0B87CDB6E56DCBDE2
      EE1577AFB87BC5DD2BEE5E71F767C2DD5DBBD9AD375BA09D9704D6D90DC7B15B
      AD6655D1A6E2EE1577AFB87BC5DD2BEE5E71F767C3DD5B75BB6B77EAAD12EEEE
      BA0D50ED9B55C67BC5DC2BE65E31F78AB957CCBD62EECF85B93B76C771EAB65D
      FF02DFFF85AEC6572249025FC018A1F8A3704999F37585FAC2B78378064BE985
      A9A3CFF6E2833A8A6FF583CA80B0F0586E6058FD587DF563F546A7ED361AED92
      9735563FD5EDD6DB5D78A8BEFAA9E6EAA7F2D201B8CBAB1E6C953CE83AF516FE
      288165BB04247AE3563FD629799BEEF3BBFAB16E0924DB6EBBDD6AD9254F3976
      E986B73AF576A359F63AC759FDBE66D369DAAD9653B238A7044F9A2DA7EBD8B0
      7F258F95E0491B36AFD970BB65D85C82287917A6B22D77CA904547BB943C5782
      2B1DB709CFB43BAD92C74A7005B0CB753A08D392E7CA904527CC963CD72DDD76
      BBDDA8B79A6EC9447571CCA5C73A488641A12879AE045D7215A5E4B9127CA977
      6CB709EB2BD906B7045F1A4DA7E3D6811A95EDBB5B8231A02801CAD4DD1232E6
      96D2165575ACE4B9127469B43B4DBBDE2ADD853274698054DD72ED32A874CA76
      BDEE384EA76EB74AD0C52D212E5DBBDD6CD75BAD924DAF97204BABEDB690E496
      2075BD04571CBB5187E5759B2550A997E08AD3697781ED75BA659B5E2FC116C7
      05CED501EA594295EA65E44557922D79AE045BBA6DA7D96D3AAD325E59465B5A
      4D1B005A0A9676E959AFB7DB6D1B096FC99325D4C58589C25E74BA258F95B1A2
      2E321490444B987A19B638AE6BBB8D9239364A90A56BDB20E4B4EDB23D6F9420
      4B0736CFEE749DB24996A18A6EDA5BF25C19AA38F57A0377AFE4C836CA080B4C
      B2DE74BA9D12C2D268956EBAD36A74EB0D60B6254F96D0962E9CA28E0DB4ACE4
      B1324EA4933B4B9E2B4116074F2D6076ABE4B9661923D2F12A653BDF2C232F40
      911A4027CAF0B359465EEA76A7E5363B6ED94CCB504677932879AEC1827D22AE
      B27E68FDF129FA1CC5D7D17FF2D5E9684A57F1432F801F762FC8BC299E12BB97
      C0BFB40FFF3C8492BA03E5DBD5F7F07BD2C0C721E903087F406BDBF4B9ED7641
      B2EED06700ACE3D2999B4CBC6CFC21E1DFE77194D51BBD493FF9FC2A00B54A7E
      B898C10B26E9C40BC3F3C403C56BE207E9F4540C9DDE247CEB2523BA37D19F7C
      31FC7F07F0DD75E24D5F937A4596B04910656F82097C88BC640E9FF0FD41348C
      FFE879B36C1C27D625FC48415BB3CEA2512812C2FD782A122F5BF1E51FBD4122
      40AD9BF4E609F0CA6E6F123B4ECF9F3B2D7C531DF11F615EF23D5100D8AB3488
      239C87F0E122A908513C9C7A2391363BFCC7759CF82048363BF2EFC1D84BD24E
      A7438950EAEF6B10C1E174B479D0C801C98C76E366124629EF307D74AC71964D
      7F78F9321D8CC5C44B8F26C12089D378981D0DE2C9CB78380C06E225BEF2A50B
      AAC5EE0E7D9E845FBEF4A61E40E21A46B65BFC798CB27DA73701B0870C60F894
      E84F99FED4A74FA359968904B0264B5231C82C40A3EBC08FAF075912F68659D4
      FF57CF1391EFC7835E06BBFC7902A89CDAFC791827801F59108D008271146702
      94613F9DA743C01807E01CCEE3E86A12DAC6B7A0F68E7C2FF3E0CDC910460525
      3ACA60C02B2F0CE0BA007838BD741C5F4F43D0C6C771E8A3F20DF83F8AE2444C
      821BE10F607454CE01BBAF4410D19337F8167C0C3EC051039C7060176E42985E
      3C1711AC4ADC4CD37192457079068B056D7FD0F323D88428EDFB7DB84AEA3F2C
      6906EB8685A5630F4E3360D7BF71EDFE6842780C1FC674A3032ABC3FBA323EC3
      ADC188CDBAF84DE1AF314ECDA107F0035A16613E5EE4F7AE0271FD39887C873E
      A5032F1468439D8EFA899F8C85E7CB8FC338CE7AE9349C67D7511009DC1AFD79
      9C4DE0A8A4535844188D33CFFF172CAB374B4598F5BD30EAC13FB8002FE9C123
      F08601FC754D7FC087241B25BD3082330D2B1730047CBA4E90FEF4D2C89B66F1
      080857100D4418C240617C3D0C4408A7D787E17B70E374160D32589097069E1E
      05A94902339614A517896B1830CDE6F06D0AEF1825F1354C391E0619CE334278
      6773003B124BF81EE61A0199C9D2DE50E0DC4428AEE0F2E0269D92F90308840F
      5B788DD7056EA9371CC089C2497B43BA79066819F6C67407C22D031AE9257067
      36B8F20854194C161F1A26080FBC70E56537FD9BDEE7249A266924B2DEC083F3
      08F81602182D449C008EE3D4CB2C9816FB05FED2BB063C1E4EB26110C239B2DC
      06F02E3CFF40836689C8C6499C65B0A5BD201CC6136FE06583309A4D9B0D3C70
      3021AB87A7CEB7D4F903EA1D891BBB873B2F9279DBEEF470E7E54798497A831F
      00FCD15824829EC6477093D0DA44A389A107283E800DA4036C114B89E0ABF00A
      0ED7349A0D92095E406318FECDC62E74B44CA3B1178D90F144D94DE65947921F
      C98791EDE2E330D9AF7ABE0E9F80097ED5B30DF814DEFFCDFBC5A79BF77F73DF
      DAFB52364C8B0070EF69DC36549B06BADF46DC364E675D13EADE674288F32B47
      02E69300AD0ABD20B2246EF77E8743934B2368964C3DFAD9C7B30F64DEE3DFC0
      70008BF109940D24FA0241997AE174ECE1876836E90DE9EE5E3C238427EBABDD
      035A374B3320B5E30C5E13915955094B30A067883520FB64E160DC1B0E80DF02
      99A83B4DBB0DBF53D0FBBD1016E780904F73E79B6CE485F42D7E0972A0431F86
      02EE03553A86BB7890566F1C187FF87DFD47B337C08349CF45536388688A83C0
      AE14A6D487C76C9C51A3539847AFDF1B82BADAC32F7A009A71EF334813C048EB
      2D2084A9B1C61E8A1DE69A7F197BD98BD402FA6BC1C6DC9CF94166358EECA3FA
      FF464C06FAC31BF7EDB6CC79D0969501A8DE2A01104084007407585ECD464310
      25D2DD1D090616E2C9CE9F23B2A6D145C4B18BEF569EEC3B5EA931462188CD68
      33AC5BBD17FD760FF8DA97159B51F08BDF7B57165C97F8EC3DF6294C57EF0E3E
      7EAFFDE1CD711B0B00E2AD711B7781E83F4079B50EAD8FF8720BA4236149AEDA
      9F8D366A9FFEA3D56CC0447F3D7FDFF8CD3A198BC1670B6417EB8C04CF1FAC44
      4C63905D2C1244ADEB3168271E5C1C815261BDB4E2FEBF50D0C67558632FB52E
      4EDEBFB180CA2601E2E366AD12B7E3179C3FC93D800F2358C700559F038B70E4
      10B06CF019AF67B1754622AD751C86D63489FDD940A4B07012D76FB219885013
      11CDAC0C489285CC24858F0288ACF1D8108549001388F4D97CC380D142609C9C
      BD7963C1FCED03DB9A7873AB2FAC743A4B8278968673CBF37DE12324403D0B7D
      D20D52CB9F11DC06A1F090661F6DD8B2DAB6C6E4536F022A2EAC6B140C2C311C
      029AA6E89F5CE719DFDD990469E8F5419D10FE9AC7B6D2599FD173D3608CD4E2
      356BAAD6EBCBB7A9C21DA6148033C09C81B20A6BE0A5803244325009B5A42D02
      B02880FD48366D5D2D58D78FE338C5259C5D7C80E30E07F96DEC837E379B6E1A
      356B7760B6C7033893E9CF411C7A486800D44128AC9188D09E44E7348E8640D3
      320B84E06C96167766C356D475E4D97D79FEBEDD0256144FE7B806A252686581
      D90335F2908FE20A808E7BA06E5B2084FAE9C09BC2B53884A52020E03E42C843
      11A186ED331282B8988EE359E8472FB24D5B3C1E2A3498F9339C2E1A83AC6112
      4FE4272F084101B740AD8745A1D5CAB76095402152F1FB0CD82D7C2454D8BC4D
      6DC2BA2EE7D31851EF17E14DFF7EFAEEF8EDDF8FA360C2280BDF891FAC571E59
      9A07D6E1DFF133FFB1614BE9B8B81460F2532F1B5B7D78F9002DE1CCF881BE5D
      A3B48B24A3EF8108D59F651992BA6048DF5F83F21983DA0277C7B14576E60D5B
      5E17C9DF693C83E362BD41F8C3D18B8756ED54A00D1ACED9D9EFB3606A5D0613
      51539B09FB07F4D13A23EEBA69EB69A384E3457866BCE914049A749004531002
      66299195D0C3F372605DCCD34F5910E2A72CA14F1608BABFD086C1CD51906DD8
      A16ADB48FB6B27288301EF057E95A4352D6D5A7E2C5220709250588069EA2694
      F5864102A23AD0CD0D5B93836BF288885957064303B28D7673DC311F94EE6CD3
      E6EDA2C4799DC4785A121FD43BD49DCE81C6112978831FE0B0BCFD7471B96913
      7724397B7BF9EEAD4576709CE9C7E39333A91621B5BA4E820C1D52D701D0BC7B
      49B814637D4F197716450277DC4BE6EB969E01DF2741C452906DF5E79B8738A8
      81BD797FFA232AA4709091C733981301C2B18850DD92EA251CE3779F400A02D4
      9A458948E3F00AC51A60954097CF41B47E7DBA6934AA8EDCF29DB8B64EFE6101
      A1BA82C5D06C256AE1244188C1C3C2C7DAB73E9E9D7F0422CC121A893A7D54DF
      92CFF09D27ED0F9BB6C83A2C7280EA3F190D580E9858A01701E7843D5DBBBA29
      5DEFBE88D67D5EE4BE28E6319BA2FF9296140611883322BB1680A9EC08F442A2
      6E2A10009012D8260C41A6F64DDB2394ACC9BC63A5385796C45EA46AC56A11A0
      95C6B8F2613C00450978CF6096C029CC5070000C1D208A4EE20D53C6DB759472
      8E27FD60340BB23912F08BCFF32498C0FAFE093C070ED73000090678E9464D7C
      4FDB0A00D0A7418A3BB18F6749DA95ACD3C41BC5513F4EA223914E88404EBCCF
      40F1620FE498288E0EBDD108102EE590F7CD59D9EE4EE9DA122F1DE30EBD3BFE
      F92D4B3659127818E961097F2490DD0E435896A4777809CFDE01EA127412393E
      1F74F938612B0B5EA4FB987D03940081C338FE0CE717146536D1004044824796
      DE7B1578F4D8193EF60686072683BC64A3805806C29F4532FFE72C187CBE18C7
      D727D2B6C1F62738C573B26DC07945DE81A109D6402419FAF0941964B3986439
      AAFC04931AC4687EDD63EE6EFD97D5B1ED7D65AFB63C690C00D6E3A3BD00AE26
      E83C270A00546A162AE181891A8910B8ED23CCCC60750091CC939F370A2E6550
      F17C3FD8DD01E2E0910B90976979435C0B2C10C9C65424C881F104818244667E
      615DC6356B3ACB5851379FE453C5C27B187B3E4BF0CF021686376620ED645130
      B4FA30249C681223D3CF4184B4F459ACC767C3033960F0AB20CAC4087114C48C
      21EC4D66010F9E6074158928F9110FA2430AAE02E148F80106D1B1C5654E6704
      668C3CDF4335FE99B04038C09A96B19DF600FD4E2864C2C9253986CD80E92CCC
      14132093685F201AE412B33C13B3086D88BE1C62D3BCC4A5DCD294AA251144A1
      5A896D3924BCF0DA9BA7A6C49ADF8E7FD54EC6BB3B41E82728BE0E6B1699F349
      F32002B9813E963298BC65BAC5E2289A472641DA176352AE703D8AF0D3F187EF
      52C607B2FD6CD60287F10C0DA573904FAF4488F1AFB8BE4B7F78C6A7FCE80D90
      E3F3249E7C04657796C0F1D6A79E61A3ECAA89FA9E659F3E6A6030F473582D09
      32D6AFC7B32CFECD62631E8524A66A8325F29B2C7BEF1A47275118A1017746A9
      D87F0EAB65A76C10494925F76E4AB319103274F43C87A504D1BF581D5C94C690
      2111C59DE272FC249E02DA5E23D5512449732BE655CF61B5713205520CAB053A
      BA484553C30D779CA602E344A4623397611418461F827C0E983C51DC2AF2AEE0
      0E212C8C12D6FC683B83B77677DE0611D06ECD9D370823BE7B0497FB9D23B8C8
      BA62B8A42F2FCF5EC11599DFB2C25C5E7B150A3843EF29A10338746DA3F6F33F
      5AED6E71413FBFBE784D32F68793B7AF729A0C4236FCF6374D79F88FB68B56E5
      74361C0637ECDFF2421592847A5FE02B6D68C3E65D77340BAC29EC719C9A2288
      B5532FF30ECF436F94D64CCE38E4E007B52988603F91F59763035E8392940440
      3C4E441892D376B3F00D165C7F79FEEEE7DF2C5C9A65E3725FBD7FFF0F6B02C2
      0EACE56290C461B8A973267B63ED23DAB627E2827CC71F921835ADC4BAB938B3
      CE6E3290BE500C7F138F6A9677E505E1C659D23EB2B4CCE6028D4791F501C468
      105B2ED02E44EAC27086818E18D9006FCD8447D887B4171134482C2CE9B1512B
      4313200653845930B5C64194910AF43348141807349B4416A79D6C164BBD609B
      851F0CA4CE06DA39AB7A17B3FE473EF6C749020AED464DFBD7CBB38BE6CB8B8B
      B3DF6458E8D9BB939F50BCFB0790327245A280BB59733E4665CAF2400B1E454A
      1895AE467910B65CF0045C04CC43D1FE03BC73220C33C1B700C92380F0683FEA
      453CC1382EB56A526328FA590C8261C0CE150FF53909A06B0FBD0AD73F7C0582
      BB34D53FB1905E7FA490BE1A408DFB41E8F077B4A2A0E2AD7D3C6B8F52415BEA
      D2A08F9C753A587B6CC0E661E67A618656F1BB761B53771F1B09B1FEDDBEAAB6
      FBE14043EA82A64F74813F874DF64661B5C75F43BC29E6A31474581B654376F8
      F7EA107FD506E3495EB1C99B798C7FF79E6897B755CB3861C336AA5FE4F1427F
      1779BBB644D5384E2965E986B47D0F7349415D2657C8A9771D8D66B0780A71DB
      4B85B0B0202A2620F445487602B85D5C613EA6CA9DDBB7FE797C02EA484A7E7E
      546B31BEDF30EC7832F7890E1C46D8626400DE1EFBA4D91C58CA85E80B99428F
      791013D4E1B3B1D011BA299B18A7DEEE4E92C2383201AB681AC2E870CA139101
      6A18662DE38EAE4582437932F54A0729E0D431D646F82A77F4721CA4329C8115
      2F0922E94A2A0B09DC43B3F53406F5BE1FCEAD185E90D01BD27D3530AF2E4047
      E9B5154770D72A9819B0C197AF979C14B6F869E80A818FA200004F12A5C9629E
      321A57517745F39E6B68BB9516BB428B6D7C572DF65D8C64F12DA0E75B898BEB
      D76291945000159E821CE7E99873E810A649059CF3FDBD8FC18356B6C7D40397
      201D2A17F12CB44EBC2089A4E9DB1798FDD587C51169FD9A908967267A9DC7C9
      409463D45AA42F8EBC62B459C42B4022DC89021FDAE3A89D84D98017CDB3B1B4
      CCD26DFBDF49547A58E59D7BD6B981B5ACBFD28DBBDD956EFE111F9E07DF3460
      E4FB498EC72ADC1F84ADD9EE4E4AF99BE9679934E591491A0E4E3A9B92878F71
      4446EE60081DF17D14CC38DDF5839725228ED0D9FF129EFFE0CD3F78A192945E
      6B31490A54E2EEA1AD3EC85C2056C1ADC1445010C104848E3188597E1C51F443
      4AD906B4690718E092606A831FC84875CAE51F24180905520B6C244F14A13D15
      582AD2DA8389E2083CD97D3C0AC79FFE572E370A1E1BBEE7EC093415C11B548A
      037FC989D88A3164F154260381F4173174F1FA04D3043084E068AB0FD8EECE8F
      2024261F620172C2CF812FE26DF1081D13B1ADF19A6B0A6BB0A4511FF3DED8EB
      F9502422D9FC3A006D239E52DDA4FF8967973310CF31248E6A26D149E203269D
      4F03C05F9C0306E2E59BB1DD685955385BADB434BF777C5C5E384C45357D1020
      049E81F2399FC61894E134DB1BB56730692C7471EC5349014F1685002DC81B11
      6B23AEF4CF994851FEFAF9EDF1E92D99B1EAA1132C84CD39781BB5D6B23C02A6
      37899808EAF763EDCDA26B2F82FBC2F9BE0AAC275AB6BB43F9CC646E0AA26012
      FCDB28A543961C0F68D8208CB1CE134A0098021C27CA06844587362B68A83CE5
      EE1765A54A31DC9EB415A0DD9C39935D07030E930A8C7B52C08BC83FB002958C
      C3F6B748E766E1188988BC0962DA1117F241031595EE19CF328C0DDF28E894C1
      E6578A87FB14CDD01028B3E630CC15D8DEABB7A7975C27228E4628FA61BE31A7
      1F5D794940A14129A08DB527F3FAA5CE083CB0CEE6C2FD0D23EAE528721287A1
      374D65611C491610DF51FCDC23E0707944A22D2F293E153F6080979189B34F36
      BA5984590F3A41354806B3099C17AAFA90E776614E08C5D54B74CAE3EA5395D1
      49A88A5D32372B9BA01C8CB55321A654DD0BB1E4BD4CBFAFE5193E03AA4169D8
      B4079878A0320E08C498E32C837E75711B22399160D303E097AE5F48221B2A1F
      9B559AE0564AC4BAD07A4D42AF23C4A42F7F0014D65A3AE2B3982BC918C32F89
      2206BC95A63A894922275912E2E761184C39F2F99CCA2D80ECAD2B4EEA444F18
      13C7AB81F0FC6C0A18FC4A3192A7C797C75423EBF8F223828249E7462DE0164E
      28ED0698B1230E6897820195322BD17E28B9DCB3FA21D53D831F7852813DECC1
      89C4FA02D87CC0BE869F73BF2EF32E916CDD3C8BBCB50B4EA25DEF496433F8BA
      CF214076EDD35C7F4C8B94819475EAECE22D55BD20C480C3C3F69F2960E57BAE
      9DA53D8ECAD9481E4B600FBFCF022C83B1A7732433EC95921AE34B87A6D081FA
      CA60AD73A3E1EDCF020BD7BBAFA0FCBC65A6B9B7BF7E34541E482FF73E62F280
      64D02A57926B93C84A0CB465CF611F2E397B311871793A4C62C41C46A3905900
      7C8C041864805855886D431356A88C5C5E0EFFDFC4B4BFB20CDE3C07E01792CC
      60651FE26BCEDDBDF8E9FDA785D25DB0C1A368E31262CAD39365DA0F85862311
      E29ADE1265B3C48B5290B249A151386C54EB496783F1735B276815E76F2E2ED5
      B6C196F941CAE572E931323E3D87459DCEA6613040AB4C3147F9C78F9F3EA46A
      79B26E8047C5A386B093A154D40D16C3BA569E3EB89DD6D6DD1DA9E902229CC4
      914FE5C3B6C50FB06AE9E4193312D931BA86BFE2882BE1A548F631DA89E803F5
      17186496831E29AE09E865CA826F0CCB7484F2D5E43BF37377641D4752F159F4
      42A0BB9CC37B6032C196BB06F21D9379732C71BC1211701F4BD508B33E609E2C
      56C803089F1628DB9F1DA1D9B1F59E31A9F6B5C0AA2D22E19E5C32057666C94C
      E8B03B694905B557A22F7C82D3105C813269BED55BF142B428F264C86BD6C70A
      4E705840949CE7A764DB11FEAD1761FF91131518A92A3F3341F1C53411C80CFD
      2D41F07270ECBD38A6C2DFE7DC7807E56D75D78B03EBC5A788F341C97371CAA2
      8FF55117DF855BF08B171FB98E76ED35760F0331830C58AC3FD59495F205811E
      AD24812F502B8DFB694C632B3D142B9A511B193A1280E72FB8FE0FC6FDF1AC5E
      7079519E0EA1BF8E5BA54A679E35410D63840A2D895F5C202867006F63AA78C6
      EC86D4DD3E6AD88BEF510A1ACB52813CAB32E2082BF6FAF16046BEB03D2C2688
      8175D3905CD6689BA6F0B90332E691274478B0691AE6FBDB7E367FC51295BF49
      9853B2B72E5379B0A2E213A318ED0DFAFAA92027668263A92FB12D22D7255969
      5258F54469CCE4A0C4BF0859F11CA042C92D2E54A010571202A0C9E80B712348
      1CF3A568264DCEF0ED54873EEBC08C586130FCA4B71E58F378466F23971D6337
      96613D1A1D7D4DC0F49F38EAA0F55DA30EF080AD3C5F3FDCCF4A8691C5F7B493
      81AE8C88B8BAEAEC11E0DBBA8B70AFDD827B7976D1A025FCF3E28427BC666BDF
      469D8C4760C5BD21BABB73717186207DBE18D1A4E92B84587330FE0622442EFA
      AC1B19CEDFFDAC5141E7B521587777361E11CEDF1365F8E7F1FDF1E02158B081
      78F02428A0282CBD42EFFF3370EE2932B605DB5F94AFD74E04F820E14BF01DF8
      8A6782026AE63FBE794A1CD836F545ABEEB23E396912DC4ECC3AF1A64AFFC7AB
      6FD127C85F1DA0BE4225E740F3115ECAC91D42B00B8A2336B5098EFAAC703C3A
      2660F0684A93D976159C4E3BD68F2683CFB2CEBD1568898EEA5262B15853E321
      255930777BDDB28DD6CF95698A6229B3782428AB7B75EFB147EA76B796A6D840
      5AFDA4B552960D249C1196A1295FB768238A44492AEC0593C11B1CEAAD7DC82A
      E1338EA4AB6C32411B1792093538D9549E469C4146B6B8B739E2CAE0FDA74BC6
      DF4E9A4B14F7EC26C8B684E75FCA3E324F426005C071FD4177F721B19E9171CA
      1DBAD109C042CD1E9ED995066C6E6178607185DC7D241214102A6B8BC0ADE88D
      18B00B0F334564C71E240EB1AA934DBDAF822848C7DBEEDE3BC3BC002FDC9293
      B4BBF39AFDBB3AD91865360983059773B1AC8B446336D63F41C90A3907C5539E
      403E5042FCD3883782E7BFEE79C38E6852A236E4D8E2D43F55DA286F9C18C808
      BA60A8F714B3C630E28AA343A502033ABCF45882A440420725B458DCE99C52F2
      7282A46F26C05D64C29B1CF0AF3C85C448D24BC42800E49EE79E58AEAA4053E0
      81A8EC35BE9A514B851ECC287A91D2154045532B78915A58AD9D1E3ADAFAE615
      E7D8B2669659EDD696D0AB53DD5033653E47048AF18D517530E074500A2DE4DE
      E93EF7859535BC10EB9D23FBA84138879F9A884D8371A5BB5FC8543990405EBF
      3B7FFF1D0A757F4FDCFAA00B9F21A92200A8DCC11CD53011DE27CC29DC804156
      05594B448BA1BC5C380468DB88C2F1AFA9100FCA685CBFE7C8DABBA44B3A8C3B
      99D048116048420E789D5E97CD12CA018E87430E61C00B323903AE493FBACA62
      E48C0CAE31A51A8A7391383695C904DADD1DDDCF4E7589A225728328CAFBA382
      72FD79DE174B60933881ECF4E41F472A95E3559E83F43A1AC63F1470C9E2FED9
      42F635F88059267BBACC1EDEB99F77E056D9AE939893C3555F41AE607720B399
      020A82BB8E93CF46234EE63D721CDF9C8235C1DA79F98EF260F019461347D6E5
      EE0E529171206892417A509CBF91E2285B0720C9497C99186A2C8B475C047C4C
      FB615651A1507006F542C0690A98819B020FD5F45D351DFC87835D62EC1FE140
      ED1CB753F59DC31914EF045E910AB27302B85391C804560DFBBC881D150FCC67
      85320322185A1500B9728CDE3757B12A2F832247F2038016596E034AE30EF260
      71EBF4F5F11B33E794D413423CF8175CA942690674AFBC70869A914E08E7DB09
      B135A2C092750F2C96774EFEA1A49CBCF3199764D40F812025235D60EE702A24
      B2EF9BA1EA72EBE1066E2D76C4C54654F20DA59598913218312C6E409D13D14C
      D9666453B242BB0C659ACEA1996A702A686390586E32323079457C329AA5B3EB
      586216804BF6DB26940450116DC9F14D6812A01EB8E67458E1EFAFDB64748818
      8688B07627F8C1BA67FA2E7ED05CD73ED387681E4805F080AC7DA6786CD60ED7
      3B67FBB546D56D17E5307DF313AB6118CCB825221C27AD328FC1C6331EF02DC1
      8D6BF3BE5E66D35E4975330EBF9556398B6A43A1A816637B7BA4973E493F397B
      1293699CA0519E3A84694E268B24186F3892B67C9D304B161699753B92951949
      80A1EEA305430C4A26C440F4DBD414E2E8D01764D85F96C68E94ED2F44716DBE
      6803D412124A24F06602D9CA49E5EA3523D3EE0EA1938E0BCDCD98A6C9113B59
      2DBD14538305BFCAE87247DC5949C51170C5E5299068319D2553B45CB2A0A720
      C46DC855924344D9CB672C8F9E63B52AEDD1D5F0211F04BE8B618EA610D9AC9A
      241E99187A649DCF1232CB2E0673A3849C196C5E87702FBEDA908B12C1C51850
      764EF3B058E378123C612218000BE20716391AC5529AE428592FD311DEB7BE0D
      5E3253E52AE1BE8577E421B622A0E5C948DB205BBFF90EA698BFFD49A21BB409
      8F6A2129DBD29AF953BE8627F3B9E6563C334FE89833E5A9CACC7B92E4EFCEFF
      31327FDE2F65FE18A6353AF77C1649B84B39171FF5C015E76FCFA84721C73D50
      8F7032E7E243FC16AA234095C9F14D5A37A439029692B6BA84A066DA9232032A
      CD83AD93BA28942A0525B28C528517952A398A3EA9C98007C945F235E30A6F19
      76F47BBF7EE96B195FB655AE39EAA7DECBA3BEE75A3F013E84DF3659F8FB8936
      0B352A07C8338614E5B014E6F6B89A2300DE35E3EECB35574581BD5F7F709F26
      AF983C8C996394504C49577ECE5E18EC688858EF9A5E5D1CC3436BD7830B7550
      D92681EC232D0899976717F57517AE593F125998E7069C0CA53660FED7D871D7
      2B2E840449997D845982E286847F16E1B8DCC7F97B36FA63F7657DC353A0E7D3
      ACDD880E62D199C4DC142B6604693AD3466555D66EE377559723E2F806D890C4
      B3AE62EACECA85E63C6C5C30A2CC32F631166C5520FB7C8841591B2B4C6EEEC3
      19E57213460D3F018C42A4D8F8249ECA4A7E243AA224408475DB99EAD9CD148B
      1CB278B72DEE1EAA3423976C18510DA7374AE40C1A10B3BDBEB413A3888A59C1
      5701D7D693AA1BB6E2A5345EAC326D1DC3313C452D6EDB51EB620CEFA6629117
      5321FC5754D87B5B50ECBDEC2FFFE9B5752115951A62D28144AE1A43A7009A7B
      5739AF29356F214EC7547F026964D1DDD1730F9FE98FE091B9E83A3B22A97220
      1A5B168B0706936942755539AB1E8525F4CD9191446B79178083834C25C81734
      BA84D3F9690E9E3C7CCAB563FD24C2A9F55256BE870FEFC4CD2C7D1BFBF8F9C7
      20FB69D6870FB256227C524D155ECA5E032F65AB02BD92AAA1897C4759431367
      BB1B9A5485ED57A798B7BF6B8AF9EECE7FB49C8E7568D58FEA24AE23A6DAD610
      4818D944D962A48CC8DCA50E951B59917862BD3E0589B29F08EF3347651C2682
      436BE18E03207909DEBA59852761C55DAC8BCF15D080A6E16A513BB9360D661F
      CF3EBC393E39B3DEBE3F3D7B639DBF7E7366BD3B7E7B26ABE86FD482CACADB7A
      197A33F03ADF20C38D4404BA357EE6A27013627CB9105F90E011250689976E58
      C5BF92056345DE978096D778A427315AF4257BB2FC98ACAE14B9028B6C35FAC1
      F3D8C437628405E83180812CAC946A379BB2A1C4E68AF35C619D94D3C16215BB
      CD5E1DD7DBBF3C39FF84BBC2615E797E0D47CED6CE6372D77D9AD69EC79AF2EA
      A1B50F180C93A0BE02D2685E4B4F47EF62A1976966FDF2FEFD0723CEE4592CB3
      9FC49FC5D3183ED66C717C12ABE8BA8D33446505BBD395333A5868423B0AD817
      A41A6FC82A59CF025D646DB1D7976FCDE2B91E552D03492388FE056A0CB12A33
      0E76B3D7543B0DBC301E5997F13418D43832F09738097D10F606A266FDC8210A
      D2317685E57C52A464B05E713385DB9FC52A39DD49D6A4A238C80B2A85F6510C
      50E99574603399EAEA2ABAAA7F03599A82D4A8BCA80C4DAA66BBA70259651575
      690E0D1957A582BF221C73C3B49C1238907D4309F75242CA835606DE602C8C20
      4F6E7E20235DB81A9E6ED168F42D790E0B0F864071296C087B72C02A5647D4FA
      1450C2564AC00678B7B4A670DA8FC69688CBAAE5CD4040498865D60F9C171AAD
      10A5F31C60A43C1BACF0A44F93BC05D8B36E0F0EEA2DE9FAB3D2075EBAFE1252
      DC378C7BC0B01E469AF7FD41FD808E38192812898E8D5BBF00A34A8C031BB072
      3EB09DC6AEDD1D691D6543F39698E05FCDAD693C9D851E661260C424DADE0B66
      E2C5D02A641E53114F556D8529A591E868420F53260F311142F5D935456278CA
      2743145C96E6E96DF700E5467C9445A519BFBF557E208A7A63978FB45EA26346
      F9640E4C6F8872C6DC06B5BCC61148F0FD38E47C3432B8E0EE7FB714FEE7E3F7
      B0B7DBEF8118A9EA4D6FC9113C062D58AFB99617D9CE03BF2846DD5751A6D89B
      55369DD6223616B731E34C39B2BF18EA8EA650CCAAC72CB251E24D38D2E4C87A
      25FB1229CF69ED34C6486FB69C461908583269ACC6F7F5E39B5C7807F9314241
      490F3E9C51E8128D9DCAE7A9CED98A32E2B8429590B6D717030F4DD0321E18BE
      92B9D3DFAD74B8BB9613E1B64B4E84DBBEE789B824F73850DF13748D83F0BB25
      0703A3052EDF9F2861C8883E08C57031F8C0C02F32FEEF517401F9A800DF3EE7
      E607E34600ECFE62BE08A13DC859633C5A9EB5047B8D8C6BD5374EE319BEE724
      0C069F37BEE2D8EECE19C062ED9AA8DC1FDC718ED327AB808CA59726249914A5
      ED04BAB548E0830E2851014740EA47A8EB29FB14265A61D2B211A97E81EAA4B5
      A7EC1200A828CEF6659B85E50139BCDFE8662DDBFAAA8C599945EC8DBCE0BB89
      D69B41B3D8E2B935A58A8E55B70B5128C659E8336C901DB4A51AE912EBEDE0F8
      E6D2FAAB75B1F134E4E4F2E31B98E8F997DD9D354F956C94660B126186D1AEB7
      4C6E7DDD70D6F4846CCD14078705D0A4D9F5B310D3542E8B424A54749AB2B0C2
      EF146D04714A8ED3A759F553107F0C9C574B37CFD24316AF562D5327D53804C4
      31358645A062ED83480A9D073A552FD5ED8765E6DEEA21E473DB4DDCFFBF389E
      6C1169FF778C789678A0F878C943893BC24A97DEE0D217BAF7ED931054FBC0FA
      2BA1F5E19A4FE876DB0A3FBDC6D8E589118FF967477C56C3A33CEF3F2D9401ED
      CFD083093C4A4386A2BBE70AD929BB97AC1632A53B1B27F16CC4C96A357AA2C6
      A5D131CC5BA5CCCED30C1B22E3A53D6C2DAFEAD12CE87CFB8588F36B59261D90
      FE2AF0E8BA9A147BAC232343D84C80BFED368B62C9B1C0A9C7758830A17F5854
      46B07B736E718165C732198F07A565A88A3EE6ABD8AA4A4F7367BE54E06E66CA
      01FA865C5B7BBE977C46C021F30138847815CB6DE91A56ACA99CC26DD69EFA56
      DD2D1F366FE6171AEBC7D74B0797052BFD8C50C62443C547B994942C175608DE
      A70AF40805B50AE0D3632E45A138276FA51C9E5D76AA3BF2446C7D5A13E38277
      8D5515304C843A7EABA69783388C67C956D199805BE91240D439D3422D81C34A
      0704B3BD3ED78560512DF211384C0152792779B3493AC4C8AF1BEC001D608086
      3EB704FC7D4CD27CA293A6FB34160DB068DDDCDD99C47E300CD0E229477AC923
      ECF3885439252F53A796D4A76291BA743A5F9449D7B96D4B112F44272A321362
      1A7A8E59E83F9F6D7D2D491923BCE2CC6D8B65F538BB3591CB0CF6A263A9C2AA
      A5255656A58B47A350866092092D0865A75E7D7F16C7A13C9DF221692283B301
      6C86CD6EC072FA41242BCAB1A595F78492C3F7E854F0F6F0C9D2DF1FC3287B4B
      67C568371C84EC1DC9377C423992532C4B5ECCCE30A39B0698C22D4F148342C6
      381D48A123630D94EEDB2B4CF7A539B97D35887CBF0444AED36EF741FC09DE7E
      78FAE135E8FE44F7B7E4EC15189EAA4E03BC488143324143709401C080435866
      1A3919F01361D6CBD2A613FA6208C237C616A52A13FDEF1640ECFF51D8A8B8A5
      2A5073A4EB7487C124C874D97D59889570568500800ACC6E7FCA9E8849B217E1
      827C87B360B65398E0EE0E207DC6461B25F956A76077A7F69337E9CF9211768D
      7E0B3AC3969C83632B5F38ADBB5612F5246D2C257E3F430594954EE52848E553
      EA8D0D6A18195CF674FDF97D49EF31518652BB22008248AB76BE855CCBCE77CD
      B57C132319F93791A38DDA17D5CBCFDA035D970A1647D966A56C62A9AF8D9AD0
      7695EF788BB5B5D9AE9561D17662A4C4ED22D5322B00A6B8F737E296BE0042E5
      CBC04C59FC8024C7BCB185591221058A37075920CBCB81502503D38EC63138DB
      CE57CF2EDE28DBE596205E6EB3E552A7DA728B4881E04071735591D93DE0B8AA
      70157E7724D2106B1E01070DB4BE871535A429C5934520C5C2D85AF7521750B6
      E56E70A92E9B28ABDA93A9D3B36A6405A95969B8BB1367B9E984D267B8A83A57
      2347C49F4ED5831473717673736351F2D8917576E391A81906665D555577F692
      8F8887454CB4F0AD355055267636C58F6EB36ED51080353DF53DDBA63AF5A7AC
      8136EC6E4B4F5CDF737E66CBDBCECECFCFF7D53A65A3002A049F0593422948BD
      2779862B9CF941C6F560B90A3C9B89F46BD0BE4EDFCA1AFE3851F5E581DCD824
      05B2128C822C5552922CE88E44E8DDFB4BCAD30A030E8DF128A1D0C74CDA4910
      09F3D55E349FC03BF4AE1AA53AD1268EA4898B6491B58DBB0970900CC95BA87D
      E45837CCCBD873E2D4640ABC1DA7B087F40DC5380C86D5C513286427B2DEF731
      D3F1F5E981AA844C199F5EBEC2C02C597F00BACEFF22E86B44026D8AFC087996
      68AE97AC40531383550DB712071E56AF9FEA2CE4B517A17F3D8A00F8308F27F0
      B5236074CD61855A74B0089FD230CE30430B67A0AC237A279566BA4024D6BCFA
      0FA998F9F137583DAECB40C60230F8E8496820C2EB4CC77B4044521DACA190F2
      C36871E4162B2412C81442223D26BA498C3609D896B3F2BC99D496717463E166
      7173A3850F95CA566714C3C0D75E311B4B523E75B73BD92148C645ACB770ECE1
      306EB7BE49BB3B2A22C6EC8B0E351E7D5C999FB7063BB23EEA1642E443972D9A
      245AAB287F92514CF984053A225A17C479E717C10DB6AB6598F1D7EC94D7BD85
      524DAD28D950B3B6E5D3846FCBCD8B9CB22C85AC691C507F235461A239F6E4CB
      2B8EA82E78E8D8E25AED611C7F468967C51CF18D93D960CC0E0234BC0FB85070
      A1380339EF64710735DF57F0247AB3B0BEB00793F126D4470DC6A1FA341CD795
      329412593F7E88A24C3656C598CC2D6008FB30BF40F52B869571D5BB4F115942
      6BAA870FAD7BA18DCD76136344DFDD1DD9BBEAD5DC3AF1C819B225F4F863DEB7
      0BD66E7661903A050BC1540BC097FD6CF9129D4D0EA2E04A012C3953BD4EA371
      572264640DCBED271F4FB4A1939B6A63FD006CCB265B5D7244A23E2A303F36AC
      D3B82C8B63D7257A238C09479B7D571827930838CA212587A2988FC81E594DD0
      6116BA5D91A618D3A92AD0ACCC23EA963FEB82C88F557B0A4136F2605B58F983
      BD7F340F0DC70520F2F2658B110CD1A4D32A5F7C809FCC106B5AA1A6BFA975E7
      FE48CDB5E898E777AA08D0DE1F2879F5BE10E5A2B54BEDD854AF384C9437D853
      6D1E893D679C8A3B0472027C7996A15AD69F71D316459F64CCA9D288151DA526
      76AA0C26A3506109D12AF89AD8A49466432C3F0250F32D08488A36E2D405A3FB
      190C5CC3D6A56AE574A8458DB115D4EA9917727E0C0F445D51916751CE979CAF
      A6DFB0CFCBD393E140658A1435037B4255EA145E486B5ABF32F137B32EBB1FA4
      B897291D95813C6A4FB5963770409E623D3EA5FF91A861E2566EEC667CA60E20
      785149294FB54EB466AF5B7CDBDD51EBA46598EB94445BD1B90429EA9A9776F2
      43EF0F3C44BD2FEB5ED7DFF8704A998C225CF2A56DB5DCB2BBF3166E0B0E91ED
      71574DB5C348179571085861290BD912110789B6EC33A9037D093479D7AF722E
      EBCFC85E249328A4995524780347A94D7013B88005EE439ADBE9387681ACD079
      436E1D6F7CF2E1133A7E85519CC0686C69680728F660CD6A34E6D234D0A86B98
      5DB715FB8F0DA111612EC5491030EBEE966239AF5D8AD7A6504D429F1670BC3C
      584E89E286AC63154692367F6D445463C87361562BF4A2DB2AA26D3BBABEA662
      EE004ADD67836AEBC6BE98E21FDB64057CCB27557A5A6250BED9A1A42D466C52
      26B15E7ACC70A2D87A2CB7E91CBFBB786DEDA1F9A63F0745056832AA8E0908F7
      18792CEF97145506EDA7BA989DEEBAADE1BF87BE38AEF0975D0B0EA4E4C15265
      0D8769D0ABD892B28F6781A2BDAC0FAAADB3EC7A4F6C865D4B639039A9EE2345
      A2C1D2CC2E3A5C5131000A3552D44B76A824637AE0A338C76D09A5BB8D16ADE7
      2C7D9B5215297E270F76883127F28EA2D3CBA874817E500AE62E1F8F2564557C
      896ED50DB2543D6919F42FCBC60D422FC5DBB081B3DC8C5C894A55DFE654B6E2
      5451EDBA9D32DAD442A5A4C949A4AC3B5369285AC40BB393761071E00139F154
      2A252D42E96A2B61F3FE62BB931F77772E687BD4866D0505BAA4DE4D683B3062
      52D4FA0D94B5A83EE6C843DB11F5FA660CAAC2EA0A6175DDEFDCC2E047660A7A
      D30E2589C1FD95666F0AA2202908FBB00221D1A52ED1DA41D1BE07E8211509F6
      338B72972679F7A973BB2AAAA1DC0854D9FB68A330E1E7B7C7A7A8EA601BA580
      696F369F0A0918B2B4268937CF115C838AACABE2067B3163FBAFCFF32498B01E
      E9A13F8833217777D8DAC650965637652DCBF997E2159687E6A32C882832213F
      6814A081F1D3B1341D16B8C3664052C66A22C35E8154CB2040F324A1CEBA0BA4
      1EC977ADDBAEC282C63517CB939B17A4CC1371DD9BB51D978917A5808A6457BE
      DF8E9848B9BB13A80A939E3CB84A08A098042EBD3AE2DC825480227E0E67E57D
      3F0CAEA807AFF22FD65900517F52763C70070E532ACC04E02B42601A46B6DE04
      93E27CEEA488C1673C4516C6967D7A3C05E3204698852FDBF65225283857E18C
      F279A3B9DA37033ED69E8209AC1BBB692BDB7C11440F43DCEF8DB6BA896139E2
      EE2B4F53FE1D375A40A37F385FC6F03FB7A4B3CC1D0DA791819DA86668011906
      77AD3D929D0FAD37A0C747D6EB7DC33A055804AA6C92708234B7795EB3457930
      3D94BADE0FFFA5E6F5F7F5D75FE6269EEB9DFB03E7FB908262A92A3E503A6358
      FDD7CC79960D3B4F100AE3E538C596CF232CE4A8FB3F24133A922C5FF551D0E2
      60728AD590182688E4A9C3BA28E15062D912324B1207A4F6D3E579E7488AFB5C
      DE5186871647A7489745FB433EAEAC0B90E67C867DDB383A7B218104B334A3D7
      7BBDD01BB518B1B22C5FD04AC82080A67C33395A1B8C228AB8E5A0D129DAA325
      0F439248DFC9BFBF23297FD0E1E3B6F75BAD7DBF917BBB2D655894500312D9C4
      DA43C67C71C6A1CD71E8B37C63A6B115509FCF088A4AA3088F4EA58517B47067
      7549E86FA586C3E0FD6000F2023CD0DAA89DC1A005A4DD8744AF376B6AFF16A0
      0A10CCEC8D9A98EF45D8EA9B66E66ED4CC44340A37746AA0BC6D2AD486E8DDDE
      C8998D044881D146CE2C11E2334FACBE51131BCFA29197040A6A9B453980D784
      C1666EE8BFBCA9B7A99C0094A16B31DA50C04DE39CE46E16B6A1C2361BCD7853
      370E6EC92C4DF5963A1B35359022379557A5D7C2DFD0A965B3E4B39E5A632B34
      B6DD1DD2D92ECE2ADDEC11BAD9EA28A46FA59BAD9499B7016D95A7A651F0DBB4
      5B152E3F0297575BCEBE1D2E7F7B34DE3CBBE1EECE29F90AA92899B43863F495
      46644AADE172686467DD9243FF7A29CF942AC68D0DE716859471D75A0DAD3DCC
      95844BCAABC509652A9B484793E169B1BC3EDCB58FD94654F874AEC2600BE0B6
      F664A86D6AD53E917FACF0F50FB555594668F0A708EF7D23548E1D17BAD017BA
      30B0829E1146881E0C8EB9589E86F2D64D45C43E5F8F8BB2622F020401FA2ED6
      EC2FF8753055CE95DF9EA061AA18709AA0ACCA4D05D530DB5615A195E552025D
      FBEC1694CFD13ABBE93A2DF8E974EA2EFC72DB8D0EFCAAB75A0DF8D568766CF8
      D56C74F19656C3C15BDA75176FE9B88D063F8DB7C0D969D33076B78B37394ED7
      C6BB1C17EEC3DFF57683EE6BB49AAD273D4BB0F835EEA304A59423FE86DE4279
      E93316468CA3BFB5E0BFADA031181D9F9729A6F0326B0273416C5C77A2FF9379
      6561DA81117CBEC7F590D61DBB8438B17E1778F4223B90A53C81BA221A70596C
      0F93164DCA696C53EE95A522D65C92089DB620C30D848C02309CD540717D9104
      18AE4FC45F318AED765692D0411C51C1632B4E3C8768CDD2DD1DCE3D9771014A
      3A802BB533268C356B0F3ED6882B6BD583EAB2E772D990C291CC60058DA5BA18
      FA6442A19758F1E149826BC21FFE4B4D68FD313547B24E3597FC48B3C02C8D2D
      F338E9F8A6D7414655B7CD600C23DC81CBDB53009E51A78BC297400B9B4C09F4
      23514CE8D04F6BA16DDD54EDBF303AE4EF47207C3F454CE6413EF1400507589F
      C59C702A8F4854059AD2A57B281A108376398A65DB29D652A0CD1691ACBC63C3
      EE4EA167C3CA0C28521F17A1A58A84A97ADC391D4BE5F9E5828009F6C59D2872
      A5B36B64B5DB42BD4F93430F614A58EF7EF5CB515F9945B292B70A94A146984C
      8139B86B8F6C93E7EF1B3238F77DBBA56EC0B5528C963C1819952F10370301C4
      430AB347FBC67C0AC0E0882F8E375D8E7AA454306A642CAB8FE0FA48E7D2C9BE
      94B24581593253EB390566E51AE55355C43BCA158CF5775EA544B5234B1C8D8E
      D62E967354F6FF954CFFE996C1E54A08A764C8A4AA2BE95978CE42C132824638
      5FA4416288BBBA3ED6EAA37D2DFB4904A9C9743346689291196D3126DDC3A6D9
      7130A020C307A80B1B13318E365D2E5CA40D4039488C72A37988F34036F2FE3A
      F2B6AD0C7755AAC656F0DC954B2FA6EF9A99BB2BCE2312DCD591BF9418C2A858
      E8756FEDC978F08749BBEB94751703CE1F628828E41F6C829EF390DDDE27B2CA
      A1E2B274313386837CC3C9608C551416FC4B46E67F4AC800F7E1F6A269990B37
      60FBC113B3978F1EC2EC3B584A8564D11F95849E32BA08599964111641B9D010
      DC1F24A0D7AE9B8F33092EDAEF178878661EBA3D3C42A85F1BE940CBD9E72B7C
      01D9AA0433C9074661DC27D1D990FEF610A6D3248813EA1075259212DD75DFE0
      196B4F9179D2D498B577C8C69C1E82F343A7FD1084316D2753557F4DA7F9AC57
      0EFCAE893E5F35E3DD9D6F97E8B376E4593F8A17CAD42219405DF41A6514553F
      9B3AC01D3CD54158BFAC8BCE4F2A4599E4098E058A87344D156D2C2AB4584689
      CAA8C8C4499044B07AE5DC54729F8B0228A5FE5B54715EE401BB0B416F1A2441
      5F73E0E1DA69DF93A6713F919A7B9A78A338EAC749F4842AAEAE344D69C85900
      9ACCFCA0C8F06FE5CF5CA2B6689821AF8E62BA2412AD3BC173FAC30DFCF7044C
      17BBD031B392F1018C9ADCAB6E6FB9D1C97EB198EEBAA92EAE72FD8B9472D57A
      A7FA548C2D9A2F7A4B99C11D3CCDA1C3C8A6B59B91725D830862889510A9BE71
      43F51C210F36EAAAA1E0626E76AA17B8DE4C633C3C76B76EAF5B66DA76BBCB9B
      5877FDDB1673CBAA8E875624BCA4A4BC21C55861153E74359A453E81EB4B5B37
      29842B2BF455F1448FA46C1C06A760FB832593232454F9DB51A15685AE2CF703
      57A4582A495178768588501CC0C90738992741180683E208545C60E9C956D3B6
      1D6BEFD3E5F961677F2B8ED62FE8ED5B37DD7FDA424668DD57F5F5F539567BB8
      54DA1DE840759A1F191D68DB3FD8F66FD6ABBC5B39966F17C90FD6AFD23F260F
      F8D1C5E5C7D7EF7EBCF84D9EB2FB9EC92D3863B728D45F7BCA9ED0A74AFE7841
      7EC1038B8A6FAA12A05CC525CEF25C89EA587DE5B1CA956EED5F2E393FD61E39
      7DD476EF6F2DA7D265C0D026EFAD5D237BC223C59E1E0A2A0CE84C59AAB81B17
      84CBCBB4551C6B3D1CABB19A6319A62E914E7EB3CED1C2224B9FEF512DF41F8E
      BBE79DFAABF37375B01E32DCD71CDC878C7F41BE60D9E3605B7A572D9FFD2F6B
      C6183455FC37FCB76E53451EF10BA79B18A961E5ABC8C0D39301C75D7DAE4EA6
      EFE5A1BC146906676B5A7276893EFCC4ADA64FF3BDFB8E3C78135B1EBCC91B2F
      8FBDC80FB78532B1692A5C5E7DDEE62D11D7499065D867206FB645A805C8E461
      583CDA9E74A1442C90CFDDC02701359744629097BE376BD9727F5D8E785D2E6A
      A8ACA41786E47E40375F9E5D34308C56D5B87DF7B3B982C58418724170FE2335
      A391F56A6190E6CB8B8B331989DBC8E392E430EB8E219D8633586E7A94DDDC2F
      F6E461890C6A492A414A37355771984104BB0250319A2C334137E6B5AF9BA448
      2020B4971F64577428B016B982F2BA9DFF38099AC3BDE1F570FBBBAC16A130E0
      4015EC559ED835FB5541FE59BB540E335F7B196F9186EB9EA78ECB2E9441CDD0
      5BCFC54F913CE85EE76FB9B3772A3219D3CF8D2701EF2601098D66734C3374A0
      4005BEA616C2A336980B207878BBAE89405512E08AE51C6D484984FA234B223C
      0E44467BCFB513C18DDA6F57EEF75AC1F7893A9DDE0ABCAF8E713D4452B886F2
      21F8C27B020E6F5D801C5CB2EA0CBAF74360FA81175AA76F4EF0C0C3203E7AB8
      D4093F3469F746ED7DE329F65E1D9DFFFBF3C76504205DE39134FA50C604FFFC
      B15081A661FDFC7123D0A2C9503DA110AF38B24EC2595FB5475D3F76AC7FFE2D
      9EBF626F98AE617606FDBE936B1FC9D27ED161D904FFEC8AD0EBA1EA14683424
      358465CAB761E432BB39708CB734C0A1BCCCF237767BA35A1F549F897ABA613B
      B034CBA31655BB87109B71CE4D9F204B37F96346EB087E0DB6C1964D0EA82919
      8EB462E764EDF7E98CDA3DC3E428603488645F20BCBF0F38F0F9E89B96F4DE44
      FD1FFBA3C85E7F3A1EDEF281FBC4DB9312345EB176C2687508F6740E82BC0F03
      6D8BBAA1A7BBB363D6B79760CEBBFA4E9E2E8F6B16F159480FACDA209ECE5107
      383A3A22DCACB14121980421801DFB2710C14FF7739B846189D0E609A508BCD6
      CD6F399DC1D37D3DE5D19427661ECF640F9D85D3C6132BD63542AD651087B349
      C42021ABDA7B22067BA340EB2E64FAC056F229763295C68F699C06AA87BCB62F
      EC1F6845073FBD6195676F585449E12EB24CC93771274613E05C901E14D9C9EB
      536CEE380C6E4C85483502535B20C3198138C012B14F2F4328A2224B32A29802
      92163AA1BE95CF936AAC943009286E2544310BF4F5FD74475FE0FEF90FB044C3
      B1F82C0E654AD15328D2009C171967538AC1E73C28FDBC80F00A944C5A15D196
      8FE86F2977099B55CA9C31FA9EAC5C8B78A6CA6F11EC7E3DFA4D77AE04EEF3EB
      7FFFA6ABC4FC0FA02BE9CEAA5818F64E57EDB3295EDCE71EF11935535B98901A
      E5349EE1F32730AFCFC89F4EB224FCEB5944892738659E27B558CB343DC85910
      15E1C22C7D9DA33F08639936C81483D7F1FE1FEA85E4FAD074A376B278D681DF
      090013A8353A2C8EDB6CAAE349D6BF79216738CFF2E63EBE70BA404D80E3F452
      1F24D94B8F6BA761C534D354708F39511F6ED92A35278AD49F752230A6F6DB36
      65DA4496F99EFC0800F817171A404888740F5B6B1C73F7F293CB8F6F08D43E63
      DF00B1EFC596B0D56342BF98C3E2BF125439E3A3227247962C6E445468E88569
      8EDA6CBB444995DFC8ECE2800756C5BFC622F4E10DD7CCA30A3481C91A76F799
      66B933EFAD4C4181DFD68F4080A76C79DF835903619E87625FE6FEEBE561C4EA
      77ABE8B22947E47C862412D980B2951F8DC631ECC136B5D0964BDEDDC9C31F95
      E1179B69CD3987644F963A9122CE0CE80A6114F799A2C254DC2C6FAEBA4D8F3D
      29ACC81768AEA005C121D27EEADC25C7A21292F276BA426D440FCC5154FBF960
      14C506913FE3D9C9E340BC97F91D3FFCE975EE7041767EEBBCB6F5349C1484F6
      985A4C0241217A926ED591D8DDC9D78D2ABC3584F3304B64B1314DEC01DB382B
      5E96808D51CB0826B2DE0DDE368AC9312BDBB6671922395E31D58D29C899B94E
      10E8D6EF40EA339D2B3E0640A58AD41777E420D7D8A239CB523C5B2A07702DB0
      70532A7315B8C82F6F331E0A6C533C62F58D3BAECBFCCC03523858F7404938F2
      A878807EB7CEB5D397184EB2235E862F65D010C45423F73DB4825C636B9B68B4
      AFA396481EF600E77677A875A95482C6323DBE2F069E2E7D4125E094D6240195
      22118A6751A63DD594F3A79BC293F966FFC87A35C7316951B26F706A8C41A42B
      EF640FAB03113A98A2E01B50418421F0DF0C64DC4C72505656E564495A8595A3
      504A5DE391E94BCDF20A055DF2C78F39BF64365D013FCA40A4EE856355BE4E42
      2AAF692715D618CE4480929DB45771684F3E26E81830A0AC44492A0D96DC912B
      489930CBD081340ED1118F898E182A200B4AE0438B2B18EB94C81C034925217A
      8A2AEA649A0104BDAB60C408A5D57A2E2081118A7356F86BE7A4E092FE804FEB
      B9D58E720969774725D892C5029F9CC680B01ADFD18487E80EBA0FD5528C985D
      C80AC908011C0AC8D08B549A0AE58CF34E8A5A91CAA143C84610C1EBF82A5A0C
      C545002A1B2FA4A933A0232CEB437B75DBD2E8744FBCCF68AFCC9828082F951D
      AC710544F0B48F1FDBC727D4C96E20F9311B6C5091949B95C56A0F173699E5BF
      216209ACD01BE1E9E3516805F916C208846F742490802CECFB76E7C2BD53B0DA
      DDC1337AB1607EDB1266F88BB278F7F3403732AC50308FE227075293D7146D11
      5A3A77469E84FC2A1D05655094C6EF485B7CD3E59110B991BF4E622E8A438132
      8AED9906B6FC1DBA1A526E6F3CB0D298EC18487BFD006B1852EBFAA92A891944
      7E005C1385DDC2899136C920E1423951969A5620AA8B20A98061ABC307C9DD00
      673EC010AD80C45D95F8A0DF60D0F13990F7091B7439FE42D99388184A631232
      DE2B0F40D70FB7BEA8F059845078791AA4648643707D146480D3FBB72567962B
      7518559C641DB09F0913154AE219624304E1B52FE186F5B4089239D80E4C6112
      04E259A4ED08C07A144EA2E0909F141977785D905B977C18CC9DB61D734F5465
      942D4454E9BFC9AEA9A53661A294550C352C928A7CA1E62BFA592D2E2D937B00
      5CEDD82D7887C52AD954973F96BDE741E6C23B6B27C5F71F1D1DD5729C0F5471
      EDFC781DE03B912293E785ACF66FF340C55542F1301EA0A02979211BF7F9A50B
      6C145E934AB15606E72ACB77385F7400F099C3161D149017154FDE1975EA2894
      B507CD014DF4290BB1611C7FA6639C493830B5F0FABC14107F43605E9955972A
      47AA55B13DA98AFC15A1AFF4BAFD23AB8C0C71C911B5A0AB25A2E4DDBE050786
      F645D90DE815F2C88B8EAACCE23EC8E2A48BD42F48177641EFF075B0BB13C2FF
      193358C351FEE725612494BB83C44F7B9F48ED8DD163D29F652257E114E0A494
      239BB1F0C470EF586B534209BB7BF2A22C726019CCDD1746EF76F4A91A687364
      1D93D6851A41904C940354B96834BA14718DD0B02F8B11833EEEEBEAE00B48A4
      EFE47630DB4EBD17A0B33DA47B092FF0ACA47987232344873017E97C8EB36249
      E87DC7EAB5E90C4745D85F38D8AFA35424D9915610E4AD93188D19301972D05C
      474BC400E8D3C92C49E1EB4F53EBA5FA7C4A3AC9C9C793B4D80B0855725DC2CC
      18E9621C0CB3BFF21C543D732F33C280145526AE403ABDBC391872E0D1504623
      48CA41AF0E8665C30070C8AA53F4F5A277F8E3899AB1F4D717E6794AD70C73BB
      19F444EF2CFAADA41545D533D3814EF81A39E5BC79940C75929321CFD584B24D
      F205A6FC168002D688BB0EA4112F5FA01160CE21E4D71EF66461D526D256D133
      0F862D24E672DD247C0D7A93BF2A947C3146EFCFD456AFF15DDBEA19AEE743EB
      D8608AEFDE5FEAF837AD78A01953BA3DE5B6EBC01C4D5BD8E949B5B38E366AAB
      2F3982EAD07ABFC8DF5540A244DB824D7BB3D6B0BB7311CF9201763D3E5E9453
      1697C162AA36C7E716FC62754419EFC4DB260DC7640137452403132418B9DAAA
      51BE985E2D67A766B2C831360388B0E23EAFF31009AD09331D167A50446A2A82
      B18138BDBBF39A7CABD69BF7BC18749ACACD32988249F875A055EE809DA83CBD
      BC24F5D20E1AB17BA8FBE9CE3E0A338C20212EA64F017E3F7C4D22C922B8DC07
      6511B88B21D9A0E4DC49EA9D46E3EB693D3D7C5F621F8457254E641AE65BD0FC
      63CE183B5C4CF32A9494CC7DF013F48226A8500245C8A39B37604701495F6176
      23A85D8744AE50FD168359218AF65A47F150301BC6D28050F28A42B5ADE368AE
      C3F174C02685712F1E1659EADDCB1F90C7A7BF3CD2509993578E243D6C65035D
      8E4D5B48AAFC8B3C14B226DA316C060223C0C6EDEE88E45BAA74DF5B89212152
      F1E82C1E8DA42181AC0352759E107BD2B2352C642048BEC7B2C6189AC52E49BE
      55B3C3493CCB83BF5EC9FD2E3A7DFB1CAFE253B506B5AFA3E08A4A5260DCE822
      9D54560A3222A03B915111DD0A22A944E122756C7E5751F843C112F54E5AA264
      32ADD62DB56607E2151A9D549F612A32BDA0286BF798F19D1C666F1244B3348F
      67DADF2CB98240705208988899E248F9402E03ADBF18F14B3E3D5AA6B29585C1
      B41F233EE5C63F1247FA1C44238CD4997754BFC00FB26F9B3AF35D035957D9FB
      96CD7614FD7DB0CA9CA94C7A46BCFB9249B3CC7EC35E511C09D908EFCF113C39
      62EBFD507787CADD40DA8649D44F7B3D6915CADD698C8F56F9455F5ECDB4D8F2
      E48BD1EFB81523CAA45076CC485C634004993BF4E06454283CC8592CC53C836D
      356E2EECE3B638A616974DB8BF5081A2D00BC0D396B3E57677F96086FB25953C
      5DB5FB33DC061E0527E5D63A8DAA3209C374E27052139720E6EA2AAA05814A68
      8AA887C958845A6B7E8F814F4B2B94E18D57A27C717C0FF78620638D3A782C89
      1A0949D271477AFFEA37F93129037DC19193686D2DB32FCA7EAD327A5760E19A
      3CE0D8A31AF705557A5BCFEA990CDBDC362FF271CAE1B75E9A7B29F1FCE4E706
      6DED18C560D5282EB5C4B3BB50DDB7E8BA1C9639738DD4467649B317C4605F8B
      4E43694841244F8B995CB97D48C932740E1719B947813F3A494A37562944F76D
      FB69200748751C6E3F0EEC253290669D27A2E022CC0F816222DABD1EA9ACDF5C
      8E5CC5FED81848BEAEEF98B0B129E84DE56694FFB0C2EC25CCE6723CE4BE04EC
      7D2A0437E34696A8FFA28675974E65C6D6C3BDB2735B14B30F36D1B9DD66EC08
      7C55D49E78D455E74E2F56CFC4886B55732979074ECF3C9377072315673518C7
      318DCBDA6121A076463BC50E12F57A72506BB54EFBA75512B4999C54656E4DA6
      B873177203B684162073595C7AF1FCA2B634A75A13795C4A1E3B902B1B1A7395
      FB76A904F063CB432DCD73EF667FFD6526B7FC1C1CC3C4B05E4011D4B52D390E
      C54CF6125870BCD20496101CE621B3791BAF5F6F7E5387E0F6B4F6E691752243
      8F386ADCE7285CEEF94ECA3CF96FAD74828199090FEF166A3C944F83F41E5DDB
      3A3FB285F08A92885E0EE05D5AB8C9F14BAC84073A45AFA092A99792E30C17C9
      4D9F8CD055AF5F5C17579592919ECBEB098349C0BC368F145B3163347073C623
      BAA5B429F32AF056482AB700841A53B2B371DB29C4475D2C99CB1AFD4A28380D
      C56FB9E691EFF8B6508E4B3E31D3F94A20E427674F271ADD262D17A2B9F75714
      AA36CC25AAEF2625622AB710912878C18A230192A538B25EE360D92CE10AF7DC
      B713CD96A9AE6DADED26F0723FF146BAF739D3245D4B5AC67F5B03CC6C91F616
      8A56A42B69219E2581F7144EBD52055809A0344CAA8E9397A6992631006B6258
      8C152C73BF14936D06BFC2C6DBF761316E93A020F5E7A948D0124CA9A8B7EC28
      25AC1BD54054701676BAA303ABABFDA88D968A80CA64439F1BBF8AEDCCA419A8
      52601595517C50FE4E913E531AF35650144EFD57C10DB86C726E53F1B1F576D4
      39E4244809E575571DC3E468F486E0F12A480CF4562E8A2F5FAD50FE27592888
      63C4C9E77D1CCA28719DC72E4B233047474B81CA844B298A24181686365CA5F4
      5E4D3E23651F1878A9549ECD0C787E58154CE13A9898C1CB21F22ACF5FDFE825
      727C49070334B41182C940BC6D3FD5C754F78CF384A5877A2B4E3357DF1CC493
      0907E84664AE028E48E5F1F26A12D24633F62433CA53AAA53B1FC3850B651A08
      37F78C827AF2C680B2B4C5641AC3BAE67971A06B8FBD5BB308A462798A302E14
      6BDCF95C0C810346C6ECA9DD97E910589243090018BB8C592902847460B8DE74
      AAAAB16AFC5EABE27F4868734AA0B80058AD9B4691858CC2223C72914687B12A
      CCBDA73FFD8D1B7A7092DE81A5AFFBE1203DB04E4ED27D69B3DBDD6159052B4B
      73E8DB0A40F508079E164C3F785845FBA08FDD0E0E06D83F67CD80DBDD3140A7
      EB80144291EE010A8EADA454A7893707C41D84332CD4A200BC6009DD56D259BB
      40B7FDA788427DAC9F8228ABC1599D86DE40A4B9B45C239B05EE7E4D9A31B684
      BE92D160158C90B84963B794C3DFCB6CFDBD98B2DBE4A2F6D993C60111325414
      23EB667234550C0984136589716C0BE305334A02ED23C18611C7F0D65C586057
      C12CF265E8F14FDEA43F4BB03AD25B4A795689AF4456E59B64A80CD6E780D570
      6007C668E46C42DEA98EC4898A9DA5B4E0404594E8BA01B314CB6F5045B7C5CA
      012B87F8F5BF7F53B0A2D1B0430EE633105FE1DC22A729139F53C949E03A1AB1
      E058C336A3A84EB187EC27C1B94471FC6FA19FD680DBF6534D6A0E7A61D8AAA5
      62E12DC1E5140992789AB7E4141F63806201227BAFE0C0ED2B30D4E4E15DCCBA
      DCF30DB36A96CC840EDC2DAD162AE52455CD4AC60B4FCA77624F85CC72A1328C
      515715AA30E301A7B9EDD8AC42A7001E05F3CE96606FA1CAEC2A3317D9D90801
      BD4CB02B2D880E898753A475CCEDC85E6349412C862E65A1546603EE1F58E720
      6B65B2271C616820425F962AC33A023C683E16973EA222A47008B075A25149F7
      C2B0D4AF9A070FCE568710F30B2D3F89A79C168E8C8B6AC24D632AC6080C46E6
      9AED09B2D29392CFF336CBDA8F6723AC8EB9A7CD7494E4C4D5E5BC511464B0DE
      7DB4F3FB468DBFED3C4F674C79E4B98AA94AFB644B8E12AA046AFDC6EA4166A3
      621928B7AD3A6DC5E22464304C584B464CDE97E70FEBDCA6169784C766CF5C58
      8034B27E22BCCFB2EC12D7064D39F1E49CADC01EAC46BD0CADF6DB8DA1C0B0B1
      22A52CD5B625A8794C340C49145B01D1D2A2EA72AA2AAD0C10D3C9301807C210
      D96B0CB8854A9727AA44EA9B185032AD998E1F6E7F800EE95B1F4DB9B5086B2B
      7EB168EAAF834CDD862F487F534FCB2F5FFB48C9075E7819BF2533C72F000CF5
      C481953F8DD7CDBF79343360B15E9C26C58B91832BC8D09763BA6194524391FE
      BEB2722F0F60ED69270C6B486871D8375C3A473221801D5905FF5566967CD50F
      1C58B2223719DCC88091BF627747672CE8C8A9CCAC4528534FA5A12CE34A8EAC
      F5C94EF266612AEA534A9B623E01477A104F842ED710C57E2187A05858C47C3D
      B37CD6ADB0FABA36D2C931745F5839DC35E8B45817448A14799A79D18195D7D7
      054C0F549326ACF52A1743751E132FB7E3EB73602C4BF63E3FB2C4D1E8880DF7
      46E95A7913C55C87C28BA85832A7AAC5581D161F459B250640100AD002861ADF
      A9C42A973697BB27C877B650D789C6CE4F9C6C509E6F95DCA48332A73FDE531B
      C6698A9810FC1B5DA77BB2ABA73E960C5A6FBEAF2AD3C22B5518206DBA9FBBFF
      F29D5315BF620C4B8483956FB5AA52EBF1AAB012B609D76BCF98B64AC7CA5BFF
      283C834106E4820012391B64B304CBDA4AF3C51E4532C8F2BFE83535AA6979D2
      E29B17FB52841D7B82005D4B1731DBE33DA3A28664E448B33826EE4C65456748
      C554D8847599D776C614BB594A55C83C6D315131669191F4BD6A5FC40D655FB2
      E44A75D7C8B86D6E2DE978859DAF999C8A70EF44E21E9988C40D26A823588D72
      8D6C4E625248E07E238075D418F4B57FCE50F0B830892F3BD79966149C5D2ABE
      C72491B55773EB95978A8FB4013559A88CECA0FDF846EDA6F4EBAB8426232286
      BD83DC48803DFF589F55DFB1F7378B047A4E4AB74ECEDEBCC17DC122E143A405
      0375EBFEC2095998475EE1EDC0FAEB8175C8ABFF8BF559CCD3C5D2DDD21D0780
      E3F8F3E330AC1DE8BFDEC12155C07B1D5DA1CCA5C36A6B858E065C97353F669A
      2ACBA324799F32E4A97C10752254394EE35C4976C849FEAAD4A68CBDA526BC9E
      4AFBF4CCBA747A13744E27A5D6D28DD254980A3DBA7AEF425E26790CF35C9469
      C103B9AD82E347A051631906C37977DB63AB2E06BC6B2C57E980B7F74448050A
      50CAADDE17243FA0CF4A0DE885CB6DE2745D180C3B9905A14F3C6209FEBAFA3F
      75A737BAD503E1A029E585955571A3948B6BFA145657D3A3D6C803AF5A930021
      9AA3D34C7BEF8158C362C7EC52D3813D2A40262F7EA2A41CD3852463A6D29839
      28871AC14E0E3E03C946E28F8BD2568990C37700486CA883F38FCC51BED3CB16
      2AFFBF67BAB80A367A9F088007B25DB7095983B9E8215ECEA27C38459BF385B0
      697E595636629CD83E1F27E4331F81F62B9B4D5028E7AA89CA864B29E10EA544
      0C51B5CD6691510055EE1F9C126A2E462D20B88C29874B7A16B62F415C04616E
      94903487C1663ADE1BBFE6E82C9800B29F9411F6E2E26CBB69DBD9EE8E3483D6
      A4E8809D14412FC3703C6AAAF813556EDD96C8C80FCA3799F71A413F354B0C40
      06D01C48BD194D68199C5EC1EBC87A25DB98A8E61578CC263199F1DF1E5F5C02
      BDEAEB23A603270CA958C640D3B864987C81D88E3D90CC923E28031F48C992F8
      7888911514AF875547E299CC0E0AD0D13F8B401A95D908787EE83CA3C02758F6
      C69247B09488CAEAEFD301998A78AA92C0FD58B779F2E019315552348C651C56
      225BA8BAE2A1E39024DDB3B41878C18C23175BB47B538BDEA83DC9001CA513C0
      DA4CD8AB92C34C71643F1A803926B0F36D01671CC91276BB3BB563F89687486F
      2FF27C5B3AD8AAD7D2068BC53753C59E74966BDFC2683B2345E59456AA855D5D
      2E580D1459BFCF6093548B45B5981AA905F75B8C96E6E342B48E6EFCA30A7C98
      784D95DA0FE43E51A922255E1663FCD61F18C2D3A059E0CBD79E39437A86EAF5
      02C05EF31A5EFF0300F50B1C9AD793D318A0BBF6589623EB03E6420A56B8181F
      E088EA382DD9A446C8E845D9E254169C8EA8DEB456C6FCD8FA8CFB7A8D23CC65
      5B531FA7BDDDBC7177E7F504DB6849972AD315B2FFA471C25DB3C87A295573D5
      40764B38A54946490AE40ECFD25398777331B25151EAD336E50B80614EB956DA
      8ECD5BAC3D22A558707859F2DEAF6942CB9D61141DA4C41CDC205DDE6E9164AE
      7C71E11E344E7C94949D2C476440905F3EE0CD5819B76E1893A5E22DA3EA81BC
      C2D286B9F906CF345DA324290E4523AE23A5042A839F331278D395F64249934B
      248434C6F673B68CE482B26F410840158D03050CDECEA1C0570109FB9C3E216D
      06FBF26A883171D42E905AF27010C2B6D30A5D03990D71862C48CEEF2DC92D92
      C92D0510603977050415D8B29069681AF54898D57651B6789F5DBCA5AEEC4C71
      DFC4038F8CDCB29063DEF09C030142513466DF92CEBFADD8FA818C1C1FC5D0FA
      F5C39BFFF9F8834DFF398DDFF0482B937F5E13BAF7071A3F7A5F8EC4CDB64477
      E510DA93E5AD158CF695A1CA5B0129C437135ABA58A311F5CE7E37A318BEEC0A
      06C403A6E10F625F154336A8F67E6E8E37BB0A9A269D2CF164F7908F4A93F0B1
      0BE6A2D18C4E58D194B4ADE7E02705EF23DF5345D9247BDC0A3C472DB654F701
      087C8DF65380E9BAD31F788B8CE86229CB50680C07E317B2B1A59B858BC6E1A1
      1593BEF0FDA21505CE69D10C6D9E2A5D221FEF8497794A69CF5D3C78CE31F324
      F4066C305EAF3AD9FBE347A027EF98A6E4D0553D08EE0DE60729C87DB10A3CDB
      4A272E83E97611068E6AA3654B3777C6C6756FC2D69FD56730234D08BD87AA47
      B3B2DB4D3C9F8E53C135A3DF912B32D25821114F9A1249A6C307F1E6A3EC867B
      47AC38D215BEBAB24210A7829FE81ACA71B44A0EDE125C96B5A8CB8B66C84E27
      043565388D386698ADB658E78BFB51A86BDACF2FE3A0168A561F592A19185E5C
      1C7D18A3891339050B7972C03AF642A7576C3BF6FEFAB348E6BF592B8256B6C5
      BA569E515F44206DF0D53DB1D66CC9FE1DF70039806E35BE6E89EE5006BAE00B
      7677642D735D302FCE6B0D1F2CC429E92458AA044C5DDA477923DAD591A7797B
      768E34927AD781B4BC1D902B67CD20C47C86BBC0089BB70640AA08520A49E308
      8C6590A52A77881B42A6469D2274A087B311BC8878AC0A65308B24155A1818C1
      477B32BE31185A27971FDFA0103D16A15F2C84B0BFE5748D09DAAF98F6FA1B87
      F455E4EC3B9033F2D8AC3FBD5C11B2BCBE19D017F8150A5D28DE384148A3B463
      4EBA8E48A2D5C46E55ECF172313319E4AAA3B297DA4646E15CC6317E8AB86B24
      FDA57AA66B5311B0560EC7AF496F474D87D8E74EF75A5E5308E7AA2251CBDE7E
      F424FB870078B23D5C4143C9D5CE8CE4C0FA74FAF140F9835E5FBEADC1927F9F
      51842A19D5A66CD4AB53105CBAC8B2641EA70E046084C1C028CC35E05829DEAC
      61C0BE9ADAABF717172FDFBC7F7FA96380E1ED18E95608055612235318F65F71
      786FB1F2DD2C8950A81D5AB50B0CC4C7ED97DB89FE3511E938054AA14387BF2E
      C5A76D22B06A553D66108F2234C4EF7312920089B9F6DA42E7B785DE6FEBF58B
      89450E70196C8C2F51B11D2AF70F586E82CBDACFE3F530141B61C9F17C1CA1CE
      328202C1A9771D8D66286663D5082AA7AB85F5349E61D3C22089300425F4A975
      13371FD0DE32D9FF0A6F1FC9964BD2EB1061D23C7C4A67EC537F81214089F0FC
      B919F3583F728F1CD9214A07959905F72E31C2EE46393360B083BC7E0982071D
      68AA89B421B54CCCB869C3BBA612385422B06E606E2DF314D5DC3A4E06EC8D4D
      459E18AC9C817E7015F83385945453CC28CBC2491A58BE8D4243E419E8CF3395
      AC51CC5101542E5AA7F3CC0273928C963ADE0720E7CF06144C140C890871DD61
      2A5790471DE2764CFE7FF6DEB5296E2CCB1AFE4E04FF419DF3C463E84AE3BC5F
      DCD3338101BB9802E3015CEE79CB154F1C4947A02653CA96945C6AA6FFFBBBD7
      DEE71C4909D8EE29AA2C3774CCB880CC549EEBBEEFB554826C24A98673B2F236
      50541F077161C4DF8DC196B1A9D3CACB157834BAB846E8DABBFBE85BA0773375
      F62C79B68B4659DAF6ABF3B496CB787C6DD1FB77F441A3789634C31DC5C9F786
      0B6A0B89B2B62A22E1B9248537AA56B5E42C49106D5AD46D1B6BE0505AC275C3
      8FFDB41E825B0FCE485690CE6393A3F51FCBF982646DEBCE0EF66FE4C8FE3A9C
      69C3728EC6E2877729D3BB7001CC0136A215D9CB721B2CD7C353769171D4D425
      E9AC9C8CBB4A21D937722A7FAD29FD9AAEE7E9DEC9F0C5C9C99E40401C0DDA68
      7D50EC11E9F0CC126BE14734B45FE42EA25F69D320EB9A34BFA57E220B0CB0AB
      36DACAC6BA7BA6B1555914ACAF99575D0E21319BD106C284C54E2ABF1CA0CEDC
      9B10EAEBB2D05AA05340B2654D942D6FE3D8F62CDC32A2C5BA82958D0EAB28DA
      DAF4B625DEB2F303D7BCB002507ECC9D0EF9F9328A666C05920568FBC1AA3CBA
      2BA0AC2B833533B93214CDB476689C8599AB025259CB4A27A559AF72A96DD1B8
      F4E492151F918BC0BD127182C64EA9304E2AF6FFDBED1F0FC5F6E71B5EBAF421
      B99468B93E434103979B925957697E912E71F22C22D8E1C0E197665718B7AE16
      FCEEE3123020709C4B0709BAF0E2C02C87D9F4DC2A66F413864E60D13B691B83
      9456934CD4427870AD795B79874CCF0EE2F8769F4999E5327758AA68B9E89DEE
      AF5421D51A91F84CDBC35616BBDFDDDF2489094685A0A19FD64F324F94977DC3
      270BA0ACAC2F56DF47278BDB5AE9BF95DB545926B96F9BF8CABF4256BB8E03D7
      A96DDE5729356F7B901E8226CE933200298F5DAABFB369D0F365C1F03226AEC5
      DB932D178F2545FCC152C39B1030AE81F14F83F5358BE9109B3B6A7868F019E0
      77962DADBC98EDCA1FD16A224F1434CF929DA682F506E06A9E349A30128EDC5B
      BFD2ED8349C8C9731D7D8DF9BE5A3D9661E8E5A38E771DFD80C04FB1DAF098AF
      76E827424D48EF5A309E51B86404178B7F9A9429737356DA9F181356A97286EE
      70C8E167C4C9F2A9327FCD41C517298ACF1FC57D73B8FDD5999715E738FA74E9
      42DCB71A71FDF7A4B4F7725BC668FEC87451FBBBF4E2195A524FCF5DC13BB086
      60746CD2B92F8A5239EE575AB53232655D7BDA4C713725434D6EB045A2828C74
      9C97E3EA5678A91FEF61E5524FF0D815CA5B701303C7B71ED1D1DDF65A95E973
      ECDA51CC9A7A3A11990698B7861DC14698052EA05379C570265769D9A54932D2
      44496CE6A16A7691A14CD63BD793231922CFC767D91C6D1D6AC0C571D592C972
      6C01DA01AD50D211B1FA4DD51C4E258A59CECFD07DDA20269C913BBEC542CF08
      3E75E62244D573E29018A404C50C638509DEE242A275D2E8C71E0DEDCE37BB26
      6DCB205A1BB8E994267D13CF54268D93865BA22A75B60CC75B159C0271DACA37
      BA4592B67ABBEE9FBC0BA53053F9456E2005124D5ECDEA5CD8B5ABEC8294F5CC
      5D2D8D386216A1A6F265ABD28CF789FB7794C4F36CCF67ED5BDD2E70FDA7C8BA
      7625465DA12EE2F4118D688BB683ED71C709BDF1676F8F85E4098947908DBC37
      2C782AA9BC8B0F3C794283373AB840516B21072CB45498762624A16B41771A7D
      6C0CAECAD45CF54475B4BC78124BA711DEDE5BEE456557C841B75B6AE9D93DC7
      8AE78CCEE5D87470A00FC4BED3B2FA9921F286918548C34303C79914C14B6E32
      AC7DBDE50D8D5D267263651A99AD622025673C51A89C524A9CCBFD2D35A20C45
      B2006199CDB8E38CF0B27263557EEB5EB212FD47A4D5F96D3972FB528A9388A7
      CDE7822FC64FBC25147203D68295348EB860E29B3499BDDB65A5E581F3E2560D
      88AAFAAEAC0EEB7734897D4AA31F25BA9C083D2606843FB9C6857402B2185819
      B8006CD5D8C5EB925B3E8ADC979823CE023765A60E1014801F24C19D98268366
      9B57847E78255954253C7CC53B7CFBF6AB2D79CF191D535BB38A77E109571834
      C3629C21058A94174A59AA9F960E682008D50762245A7DA6D57DC7A5E1EB51B9
      12C2FDB96D1405C96EAEA995BD64DA05BAB42FCD5B76F15C1944DB4CAE3EAD5B
      2106ADF218D9AF4AA4E10C022C4B9767E7B5134BD7B5F278871B6CDBD23F71C2
      6B5845463CD8555D99A54D0F6BA6527BEEDF3C77B5E52C50048B55385BB7DB56
      FE967F5F5F33AF58515F7E62657F3F200CC6B413A6B612A767F52EBA83525B58
      965AA6DFD110DD65229C98C782054575A910BDB96B173EADE118060BAD9B5524
      AA65C6BE24580F2C4C7E66AAA88D44C22B1B86ED82CE262F9F392CAB377ED3B3
      D8CF25DC1537B92FEC5575895B3CB626EC50515002E2D247A3E50CAB0CC219BE
      BA5909FFC7E2B7F628138464D942A2CE12C7D6A665DC8F32E35B36C416B6FFDC
      5A0C98C2B342BADBD333CD3930EFD50D9D06DE51AB07569ECFEBE6562D97B871
      75318C4095D83183D69987971549F515F2360ED54DAD305D96DB183A467A1909
      5785E477C57E557190EBCAEC8D26F75CBFAEB15C4C9C3BDC7AEC2573D68CA283
      88520507F254C113298DA747E24BF19A580C42B7222A5F598D0AEE0A3C203ABD
      24DDB4A8399C6BB35AF6696AF5E3CEF460E02B8D0B87321A9DE352BADA9FB611
      37AE23315FC6924AB1CDB8B9C4D56AA6AB57C1BFC4E3DC952FED5567737381CE
      23BF06AF381AC9791C804A7BDFEBD9A2EDBDD5D7CB9CB4196DEF9BB8F87EE9B7
      51D60745DD86F425C594690421D5997E2C6947BB50F721D2AE848D9DF58ABAAB
      AB3809D32BBBC6B602F5BF3F025E12383ABC741F19CFD3AC9FB73AFA95717F61
      7FDF2CA58F287A77E8F30F9D8FB852F471EFE3337FFC91AED3DFEFD8B7287EDE
      1F6171C7BD7F600369567F0D7846743E8B6B7CF60BB67496774777EE2B3EFF7B
      EC2C0EBCF79C1C0E463E3FC76F902FB56EB266EC94BB94345C046CCBDF710FCB
      519335CBEB693C7BA0EFB0E57A66421BBA4278E680ECB265C2713295376BD222
      7E68C66C80B31507932B8A8DC13E430EB6201D4032355D30527EC547B0EB5166
      31A5F8532A271B36552361CDEECA1ED9BFE53ABB84917AACD5EC39DB9601832E
      73B080AD4479BF600DC305312B02101D6F0F9D2228FE8A79210096D9ACA9AFAF
      5995F2DCDB9BCD3941956DBF7F96D7544DE5627AFF05043A63A308DE25D9B5CB
      8261F4F2DC70719495C76972967231E7121074B5E3628FC963B704246828C0C7
      5F69297A0FB214BDF13D4BD11B7FD15288C871B4CAFFEC864D052CB15ED36F01
      A42C18F69D51F3C42D5725602C3EB1AB562ADDDFD62EC34195CF33E25DC23B16
      C4A78A826DA3737CC72D69787B9569CE86175789E6CCE34DCADD52277FAD9BDE
      8CE3EDCC86A713FE8527BCB262FFAB435E1A6ABFD5392FBFE19EA3BE1F95461F
      B24208BD939A4DCB796E304BC560ABB375DDA6FFF4F09FADADAD4D89ABCB276D
      839D8DD449EA90CD910D091772AC53C2A2864A7259512BA676C5DC4AAE4A890D
      3CB5E50610ECB895C575B8A306EBFE9127FED9265A5F6390EB79CC87A07A4A1E
      C9ADDEBE4536EAB809CE69403376C67168AC092957A37223B8F548EE0B933FC7
      CC8F6ACE363FD424BFDCD5FEE9FA6739D525BC7051DE4746B5354284E9386A44
      176859E3305586FB99011931CD1C6EDD0A8784B90EE548E24AD9C06286A24BBE
      17766E789EADBCA40773AEA42AB9F04C9276739588BBB7FA7C3B5203FE6ACBA4
      AD855D72CD572CE72DEFB558D372C5F34A52FAD2F00D817012B13D3734BDD089
      2BA6E52BC55568C68E773953F25239FD8F74E59264C4CDE3BEF0805DE1AE1D9A
      079D44F8F08F25EC86AB737BF2DE86E8183EC397B15A41D7BEA3B964B312B843
      DAED9C265C665A01A12ADF925B1C7212ACF17C3937DF4A87F45CCD4C898829D1
      362FD5500E8C8272CFB59ADCB1A2984684A718603D0638FEAA31C013BBA3CFF9
      2404E6245834F458A2099FDA770BD39A6FD54FAB11EB2E20E7E8CA38FF2D043F
      6C6019047FCECC96593C498E37EAACACAFBD8E99D3C8C4A98AB898B9AEC28D2A
      9ED16689DA5C5F3A5B283737B579D2478D14F1DF96D618A493E03300809AA7A6
      9BD96C8B45C8E72FCCE35FF41DD00576B94D2F8E89BF73050C3ED1C4153D85F8
      92257522A77013CD3F31492E2E11AA3596816550D751ACD14205240893DADAF1
      D7884472452BB56F108815AE29AB54863763D1B064277394B63C47B5848F661C
      13F475ABC9DD3E7258B7DCC2AEAFFD564BBB6F2B040B7054D83DAC9C5CA6EAD3
      062787C4A4668FAEB2D76567301B99AB1F5D583EBCFB6F1C367391A56CB3A502
      F4909F67CBE4C2CB535313B5BE56792C6657C1ABFCD4A01EE2EC3C56F3ED7B2C
      7092964D6B8C26305F14A403D2ABC764CBB53EB314AB0E914E382CF0C2C5076A
      F457B718556A365FBDA586ABB49FECAEBADD35F9AA76D7FA1AC9CCB9F0C7021F
      252941222C892CED3BF3A601B708B5E874446C9F89E3098631421646B1E4C2D0
      573A89CF92F2D514D5E488E841589DC761A89366A9B2FD48AC4107EA74EF1AD8
      2A4A61643AC74DB28BB2D9AE5C229EAA7C56266C5BBE1A37715B327CE2B82D4B
      7CFE2FDCEF433AE1319AA51138AC0A96BB37FE916B22715338C4A4E94C89F666
      C450062BAD696D57D7FB78F15D8576C2A8A4D66E7DC97E744B7617F06B896468
      7BE5FD1B0E20CE731DB456892ABC5DC35026D776D8A995CF1A682BB11CF96B85
      D99A4396990037A1C60E609377EC9F34B1DC1EA2C4FC6958E7E9CCB5DB908D9B
      D3D5592E2448799580E4765348D468FA8EB351E2FA46EFCA986C01AFF38CC979
      5B4A8A1D49025760AF0B53528C73D8B1C148995DC92FC7550C69A5C3BE4E7866
      D9A9ADFD896F479D8BEBF19075E056075E86C76E84964432DB336848857F3938
      45EFA4736DA1BC1E4FE760F56E7F664DEEBBAF8280912DF51DC666DB5B26B9A9
      A1C5D37273E1489109415CBEE9327AFCC5D58024FDCAE529B1908B1B66B03FD8
      D7258D77AD0013D27680AA5C62BE30607FF61EB0FAEC39BA819CB4628A448769
      4A8F4B48CCFB37BCDCD4E27ADA1DD1BFDD49BF47FFE98D0713FA4F7F341AD07F
      06C34987FE331C4CF196D1A08BB78CFB3DBC65D21B0CE4D3780B9D9C313FA633
      9DE24DDDEEB48377757BF43EFCB73F1EF0FB06A3E1E8373D490C67F4ABA092B6
      3DEF15FECF2C23FDBCE379DBB689E791DC2631D2DCB1B537A0CAC38973F774EA
      1EECD495C70DFF677E93FFB9C3E73D9AF3079C1F91B21C3D8B33E998DDB0B01E
      65D0CCFBB3570F9AF101E5B4CFC382CA6E88F0DF7C6860F37415BDF8D71FA60D
      A37F1E7CAC52246FE2F0A25391A917ADC8F04635BDF7586DB3D72522339BD2A7
      8FCBCD3A4A4A2FA2507E5B40926FC7C4335D52A4F9CAF4D51980D6B49E7ADD07
      C0EE1DBCF4E4C7BC35ADF42FB0DAE8CBACD66998B79549BA0B10521B2A0E04D0
      4D0BAB2980C29B8DF321BDA3B56A7311448870C07953D23B6F599D390996A655
      CE1A991F4261CE4DE7AF67BF8C3CBC901ED4F63025F05F4BDBAA3C1D24DEE6CF
      70B764BC4C6B5A8102AD80AE9CA6C62DA5A107CBBC2C7121674F785D96F953B4
      74255A3AFDAAD15230BEBC85CCFC773E6EF6209B030BC4EB466DD77631FBEE47
      3B52BE668D1DEA5E62A83C0061F7D2ADECF37FB352827E7293A09F7FBC030CB6
      1933D991E0CD6E7A95BC9418919DCC3DFB8059DF359DC7AA88F72D186300112E
      B291C1AF0C56496DADBEC085F9A750CF82C9730895FC7EF10287CBDB40D66DD3
      7B618026E5D8B917AD12D914CD63340CE79D33530A9817EAA6D43A829962A22D
      2E08C25F0B3A70F76D0F6BA0EF27B9CE1E9A49727DED13F3F73593399680A262
      1FDB89DF5D5A5EA92DB7D1AAD7FCC8445F71B542E511B93DA42D6F235C09516D
      4A0A7F6EA80E4CE8F6A8966F8D1306300DAB51E12F5A7470407E29B4F4E9F1C1
      43FB1912FF96E4304ECCEF7C5456194DBF74DCF5A31E022FFF7327066F5ADCBE
      2C8F55609B72BB1C65C708392165E8CD94AF67F92D79FD48C4F5E9796D1536CA
      560D1BF188ABFE568DA950C65D073DB6353F82FEE24AA02CEC341FD64FA0BD64
      38304AE84D824AA9D66AC430A90831F9AEE26661F0BF60C148F178EECA7B2DC5
      619EC2BCE126D8A73B2177423C3B70D3A5CB2C90C65920BD1AF212039766A197
      0CB86CEBA75DF2357FF698E293F6D6260C5E204D02D08C47842AC9599C0AC78B
      BAB53A1BB5E591A5DC74CB04A087AC44F259859D4346C73545D4589F15234948
      6704D3F7989C91F276F60E0E6CAD9EF23E1C1FEC72FCCC3BDE7B7D5CFE1DEFDA
      34ED5A890608A4CA6E6A810B6640323C408837DC3A1651BCBE46C2C2B584641A
      F9D8BC8630E7BACD435B602B2685A5B416DB22BFEBF1151222399D0EA91DEE0A
      623BC85E557AF66CFAD79663A3BB073DFFEECB6C2DA685E200C39470AE7B1B4E
      90C50891183AB44DE6E15AF9FAC72A2C2AF0A1B23C8FE48A9FA6AEEFA8355F5D
      83123194145471E36D40820A14982B80109057DB3F89DB95A50C6AB6F3C326E3
      94413094286435C07FD1533AFC3D3DC8261EBED67EF2579282CC00905737E011
      E99A4FAE81B7E1BA81ADD5B65AF76AF0B510F2B56FB9A3D8C7A4B94CD0176F12
      D86E5BA3FED669311AC3FA9A8B6FB358B522981DC4BF4AA59E7DF3C69F9D20B6
      7FB2E508CA426D96D45FEEA982F9C7187A64A5728F471030AB0677C198C12D32
      1DC5D7252CE8C295B5C7ABF1FD82F49CE0266B464B11E7D6C768E9416C0443ED
      32439F70A18841A9182D2F2BAC3F2CDFBC69AD226962B4DABC66E67271129EA9
      82421A576E745192779548984631CD0D15300A151917AD54D0629ED3CB0E36F1
      839017BE94A484852FE63D7C7B74EA19C84695DCD4C9EC4D92626EA0A8CA5485
      5950F92DCE4A66B0474FBB612DBB60C5EEF536045E877E3584859B8FCD0C6EDD
      5E825649FD53ABD6B3F0D68CB7E7DDBBA6CE40B647DA9EBEB715346F55AC9C78
      5C323B082D954F063EBA5AE3E4C0376B67DDD8832B7DDF77CEEC5281AD862F27
      4C5BDB8673FBEB6A4F36A0D8B443678C0F8B02E4389BAB2A8B35D7DB06BC0051
      453818A042C8553B92C27669994F32A6EB596CA1A283F33416B2A3D67FE9DC32
      04197EDDB7A9FBC3CA748D1F585696DFC6C7B6B3BD73FCD5EEFACF4CC498F91B
      95A5AD2F1617739B8FDD1EC6A66DC0FFF49A97DF6700B7EB9134D1528CF8B4AA
      55DBCCFE5273ED7056FF91EB0F42634EAE7046B7EEAFD580FCDB069FD8F236A7
      026B1D1779C9CC9C57A665F6A0FC002003CB734FDFB6B22A82F5755EB2FFCA73
      72ABD5EDBB6EAFB35D3769C6FCD158B13BC68A15B7A96E03D323777EC088E69A
      1CC433789B42EA5E5D5DD7B7335FCEAA58D68F56B9708783B1EE4092820BBA77
      72F058348830065B615E3096EBAAB9C9F7CC596AFFE6FD9FD7AF5F0BCA3A49C3
      F9421218A5E13A972EE9880CDBF253FFFA67FED896E35F88C86AAE832617290E
      29194C49D5D44D2CE044052DFFC9F6FADDAEC7B1364480EE7E905C7D4416966B
      EF40880DE08556BEBB6397D367180099FC1D1739A844D03FED3EB25D709F0CFA
      7AE71D2D5CFD4A7044E822CFB9B00B7514ACBF985AC7799ACC26A90038935BD2
      F28A16175344CED253C3F1DA1B9D90C73A6316497CEB5CB3B1818D3F7ABB7DE8
      4A1ABE915BF6AB52B7CF5FC7D7EF60DFD0A54802FDE064C62F1E36D3FCFC6DFA
      A901FFEAE14222FCFDBF69DE0FBBC4A828C2D17AE0D13EF0E2AEAFF1F2FE4683
      AD5E35CB387C263711751A95409E2360E46C2B04E55CB8BB0C0A2BF391CCF74E
      0EE3E809FB2A9DCDD442E27C6FB9AED5E5F595FF8D08B05F6B26B87957CBA40D
      3323C355FDF4FC672FBF99FBE9CC24FBEA787281ACA1D8CF8E5FC82C2C1CD38C
      54FB824E9D78C4A6115D42CA799DB5BA4CD2B389BEBEB658CC4025CDC5D2D202
      4ADF5FF6F2B3493E5737269281CC5C9A9DA50874D49B67F1CD288D76287046EF
      E36B8294B5BCAF820B86FCCEB6BC0D89C19AA200CBBA2D63F3D8078687C04D06
      495A5836894A1181BE569C7F9517EC272D4626372DC445D9F7472E8234B5CA03
      1D810AA78ACFD3F5B59981AC130F5A0A921854D0B1CC3E6796599A5F5294F1B2
      50B76D95856C91DD0B21885B5D7DAE892889A457E9A7F7CC34786FCCCEC05D22
      F36ACFEE1BBF1564B8EE298838C192D32AC95DCB162A8F4C2C3DBCB5539677A6
      C4AA5A5F333E559D35AA1AA217D2433B093BE1D0B22F25E60C822B3DBE8C43F0
      8CDBC3C6BC13F5CFCB9BAB1F774B78C703B664A3CA534ECF0BCA0BA0E4991B95
      B237B39306C7D4C05849CBB3E2B4F4ADEF90955D5F03BD099E2680539A8B6CB9
      16BFFE143B13B760DC5C1ADBCA7F77764CC10B1D9FB629ECAF923D95CBE82EB1
      94EF85E9D2AF1E415B3FA6F318E7296346635BDCD3910C49155B88B3E49299C9
      EF046A30A90F145D19600A35CBE82CDE08F0D7FA5A7504DEED46AC44D2361237
      350DAE18B8ABEE31128F969306FBC8415F490720E927010F4FBCABD71031DFD3
      8A3F92A43D0308D597A1E5241EB3B9B1F759AE8AED162A11546250DC5CD79AB5
      51062F7004DCAE6A34A7B9B6FFCED2B3066D8557A470BE5A8D52DB18BC702844
      52DF79DD477E6E6BFB91545033CAB4756EA4CAA338C552A0E98C38D71ECDE18F
      D5037C65754F9966A864FB73B7729FC8FC9BAA72C7A355D5C8829151030A91C8
      8E5045A61796D4AE3626B4EF7082DF261E52ABB9B50ACE2B03C437F0006F3D03
      2F3F7681EE7A4D22B253D9B4353507AC745DCDC1638187DBBD73F200848FC520
      CB349B9A019BC8198E9AF1A6110454827A21AD4DF46E835E8F73B7BE364799C5
      1918E0CECAFB663CA7565EE02F3FB9AFFC9903A7F623AE8139494D91B17DC579
      06F4D433D303DAEDD08127C3D124E6A43C1A83B3F61EEDF859066AEECAA8EDDD
      3530A581928E0CF77C8B9E8A68DE6A9D35C3A609B78DC99058BE64D8A8AB6B09
      37ACC2B19ADA660FA3CB9018C96FC89F98A392E59BBD9E774688FC3246F425B7
      F33986855AA1BFAFAFFD561280E1CD59D0827ACCC58E1EC575870ABC37B4B7DA
      4DF3A55148B767BF5558AFAC4671CADA9879E217C5CCCA602B37686739BCC725
      67B88E962B5C8058919614EFA956F92639F57CABB82E3874C27E5E7E110BE32C
      BEEF0DD7859F387C31F6F56B262ABE51F2ACE447C5A1FBD0A3CF37BEA17D3C88
      930BEF85F7FA68801A73FCF6286E1C00AF2A73B6B51BD05AAF07277BD6558A93
      60B60C4B45B36F8245B6D423AFD1A8D203A5C6C53CB9CA12632A5B4A3A64F307
      F010B6572AB6CAAA4C530213DF0A1EF15D41E4C4EDE1A7A1605BEF5471DE6298
      0863C35698AA6D7B01146EC9391F68F72D611B3A5F556C8E3B8C6DD064A45298
      2B93BA9769A85276EB0C7F18C72445640ECA82BDD714BCCBC5D6B81A052DD465
      137807B10FA82B9564ACAF4B7652315A303E174016163C978B7DE0564916C3F8
      3E3ADA17BF9D285E056443B8712E01CF876E58FDCD148BA303A89F96DB479D36
      EED89D44E6F034679AE954E44CBF220F022568F497035CD1ECD10B7B49BDD93C
      4235682E9E5799C688E2EB4743A9B2EDCD5024E899C21BD423DEB91C154F61AE
      42D75E756B355D156A8533FCAC5AECB19F48DD55A00C1F44AE5D11B1A9E30493
      D355B50E66993822F0D0DB3F3DCC0D7F7D092050791DAD64CBE01CFAAB146A9C
      788D03D209F8AE389F9712A3D28063922308BF1854525A0FB379B520F45D136F
      3B547DEE63B0641FB7A28557B68CD8842A6D02C626094882ADAF4186DDD13D4B
      63A525455532039C960DB2A67DC20DD6A425FC1B503199E865A7EC5120A713EF
      E21643310A2FABD0479F5C2FA74B64A55AB412CB0C2C4FAD3B16C5CC82419AF0
      F6DCFBF1707BD77B97C10F2D385318C9CC5B2745B60C8A16DCF9D6366383A5EB
      6B9167FFCC794BA92A9A6B9CD5AAE5CC5C5B9F7A927B4E1B58B6187CE6C74586
      6E0B39F90294A4A5DC8A0517D2896507C67E616DA29A1902380ACC68D33B09B2
      78616E4C657AD560DAFB7D6FC3270D0C4C024E3301D3365367CF9267E8E37739
      8DD5FADBFD244A5DF09A963834F105ECB0A8722E2C3E67B0EF2F54785FACEE6E
      E87FCFE7F3E734D3F7B9CE5E7AD7349E505FBFF46E7E1328BB87AD45799B260F
      5D32E36DC472B93A8F3E09F59E6D6E98B969B6BFCBB86A337526125A71F921B8
      975132FE48B42929B7D3BD93E18B1372A18C23F4E2F5D178E4EDEDEE9FDA2B5C
      29BF87122CD12ADAB61FC2A1D62FB238CD4CB97DB03832CD08A557E0D2F452E6
      617B714437F3C3A1081276393232246DD0C2D72B1A53990F6F79AFD0AA57D49D
      35A94970FB2C710FA691F74B7A40510A268ECA89B0AC9C88242B98D8A1E57A2A
      6C67A07D972B41DD2E7D43B269CF10102B32AD48BADA31209E71051065BB88B4
      35E532F25C9C3B6897617511382ECA65A5E5B7290E958AF7B4BA0AF229C61D17
      D72E4939A60AB4308CAE56A6C2C158BA088F5D44709A47AA6502D34444BECC0B
      5E4FD433D3717924B20198B4A2AD4B734D62809223BB6791E2DB0A3DBE6F34F1
      978F870EFF43EBC5B2BC4CCC964A73EDFADA06E4A2241251B1B5598D8E94F7A8
      D6AE5B56BF7FFE0C3DF66B662C4A7465011964030B7D7C04BB943604F0201298
      2B03581B400A697BDB3BDF1F4B72ACED1D6CBFA5B7BD7B736CDEFC76FBC7437C
      9C9F085E4D6BC3A68CC3B6B1598948315108ECDFCD47729BF713B31C6D8BAF72
      876B50DF0BAC12DD8281DB934ACCD274CAE243085B968E98491FD4B9BE112C64
      5A0DEE5D94D270A6B8418754CA5ECD77DE75DBBBA942D9D63A390A8702956B95
      214D0F7FA2D2DB2A43471B642C355FB5A65D51AC128394EB899CA86D60DFE4E3
      C381494995D69F6A3CE388835312F012F28544B33D015D5A0939BBD5E5DCC7EA
      12DF79686D3F973DBC7527CC41CCD094F17171D9E809DE06572C80BE5DD0AD38
      9F3ABBB1464D9D9189565E0076DAA59970CF62D66A57577BA02B0BC72CE89570
      8492680ABE25AF552929E3407EEA424B635C7922B85B27368F6B73DBA9615CC7
      A2C636B26C8205BCC1348A4CBB00053E7767405A3A4211BAC00E95B168292961
      AFB8BA036E591ED6516591F4D03A6DAEC9447DF47DABEF2DC99189C0B8AB4C47
      A33C8152156CCFF2A3D0031FD6D7A44DFE53F730119ACFD4B22471F35E65250D
      B297BB84E28985EDAA6C67BFDABDC08FAD9269C0D3CE040AC5026395ED74063E
      1DA0E709D7058B8415778533447CB3E54EF31596886F5582F9CB3363B6D67CAB
      45BABE96AFAFC525B659296FCA2509632942995B18F7F2252B6924905BF9B4E8
      1F96BEAEEACDC23BC0E793A5304CF676952060B974EACA641719B7D77042B5CB
      D270AB9ACA15E037DA82659E353E00AD845780E19E09628CD14EB5C3BEBE463A
      EFB1CB886D1BE82E29D11051BD83688CCC20D46BD9CAF69C03B34BE4664C00E3
      51880E29FCBC6B7DDCADDE60EB09B17EB27966710E3C8C7A3EC148145A45BA52
      5C5A8960CFED15155BC0789B557E28C82669484804B4A8DA0581124ED721C1D7
      9DD9056AE59AFB154043E4A50DDE87CAC5A4CB9CA1237819E52860D818604F7A
      B254B1948E71F94483775BCB79DBC6869251882B70E80968805178CF96B7F14A
      FA82F11655C33FAC74409573141B4764B1E928AE239A5C816F76E13A7D4ECF49
      EE5941B492A6A14D8B036D6CA033CD397757E2A0EEBC287845ACE3523154D50A
      8F0EF3984B4815D621E4BAE96411619C570471AD56C18ACB959EB1F67D55C255
      CD6216D41639716D823C7A7D4D7B64C3A3921B2A0D1B2E625BDA9D405651A967
      B0C3F98222E5472F4C5BC78CC7D2B26B742E75D27755B63CB2DE47EEFAB0AB53
      8D3F7CE132D9E6A47306B0D38945BEB18F588034D3D781821D15178C278C4053
      EEDEC8C5B9E7A8F431E25064C66A1B6FADBBCA02C29A04009957E20D96BE12A7
      301FFBB13F38DA7D435B620CB64772A27F541923EACAACEF2AB430CB824A1FEE
      CD4C2E502AA1F334F9C3233F3027E79C4F4B458D2ED2D83801C892CF114CE63C
      3A192069F658ACCA436948C84B15EEC28646C4219E1871C36B962D17CC965B5F
      4153E9B2E18C1E04A2DEAAB735F3C155AB41DAC6C9924F6A089071C99E717AC3
      344754BE9891A84B05FF89D1BA3A19EC9E9706A832B13D31F5FD4572D4FC5A42
      91D689B450257291E0B1779C96DB67C58E38A53D8C8170F30A465C1E2AC91272
      579400F3458AD38792FD2395613E8FEF93695823CAE80632E4C5868DCF12EEE4
      560EC0C655E720A52BB952B2E60BE6EC42CB16DEE367E985987B89316CB7BCFF
      4A97A2722E384AEAC3B6E7ECE4D513C3F98734E37667EE133DE4BA21EF458962
      6EFE82DB70FC3EC1FE0BC0FAF62CE6FA05EF3FDF9F9C3E9694C6EBDB25652B85
      D758A7B2C79F8BAD70A4977E35E2CE37D5AEE3C1C9A9F7E74AB5AA2CEC658E97
      764EE825C04E98CE85EA6B0778ED2035E93E7E65F39E444B4E9E151974168380
      ED2E8C111004C88A08136025D7523D0B52AD553F0DF613F7202CE36FE6B03C31
      4C88B7B2BD589044930A38EE97B340A19552D2477289B6BDD7153EB595A2C992
      C852F22216DB33152E94D44FAF4D18B64ACAC6AA7116CFE9472464E2B208D53C
      C57E966F5F723F35A5C7E798748AB9DC16910D606CB5F4522DC6EBFC75F9B6B6
      0D9CDAF49F19C42D6894F63DE8B12ABF70082D2B85BFD0FD8A7B60919ADCF236
      4EACB60CE33CA073032A36F391B23C78B33676B9FF16A73698A5B969DFF88DC7
      5C1D6DBABEC638AD69B152C960BEB73A76B3E2344E1B73E38E32EEA56EDB2211
      C19A319FE6AE1A9BC445D214DBFD2CA76FD1C1B29239E507CB8390BC940FBB46
      5444686A016F308872F47C69E06F6DCE99DD1063A3ACE2F8E2318F5DFC89DC63
      2BEDDB9377BF12408DE61B6832CA35D2AF025AB61F1DC6390EF386D2A8FE7AE9
      ED5FF9F8E14F748DE42DF80D42E72542D5F44E7AE524CD0A79317FE9BD4AD319
      6CE03F7BA760AAFBD3436775614218F459CBAE4B36BE6FBE75E1BA8A0C69DEFA
      5A85368F7F58660953F195B15C8B58430682037366F06993AA7FD85CF71DCB9E
      DFB1DC6E414F4F789DF32F5C4A74437DF162D20824D966A13AEDFCD15D6046C0
      F9071EDE16320676B118B24B42649C6C1476202F10246DAF72266A0C464EE0FC
      466BFA4A93F213ECBD0D6510657859CDCF0F7F200586F161FBD4CAF9EC25E1EF
      399BF5B555C039E83BA85D932C417AC496F2E5869876E9335F3577679C0BD177
      8500F37C79A69182586889477016166F7F21DA918B94B89129135EF92AEE5875
      30B3F802FA32CEBF806BA794C1C5F5B43BA27FBB937E8FFED31B0F26F49FFE68
      34A0FF0C86930EFD673898E22DA341176F19F77B78CBA43718C8A7F11612F463
      7E4C673AC59BBADD6907EFEAF6E87DF86F7F3CE0F70D46C3D16F2AF819E8F457
      DD964B65A109BC4ABB0B9FAB1D4B2DF627F30E1FF7C9BDFBC50B06CD37BF55EF
      5AF99CCD3FB93714AE94C4E30F4B8D1C6DA979F78D338AE9A0954F709F8962AE
      8BA83CA3BC0E777EA14E42FB4BE5C77F6A3D5E8A0A521D0CD7BC8730D6CEB90E
      2EC809BFF8D36DDC8BDF4DE23DC824DE27339EC6832BBF1541476E0A67730CE6
      7580EF8668926808279E57CAFF5CF2BCCC7D1B7A0EE3BFE5DCFD98A7B34B7E32
      42A1C8275FC5DCF420CD7B16CADB66F601775F76C32F2AC5290F5E71F721CD66
      E1C94205BAED3D43F6F7A7773F3F6B8BDDF69BF4873DAC92BC7B0ADDF6F0379B
      C4CA898134535C529D69322BC1B555A9BBDABCB7BEF70A83CE316853E28AD28A
      0FEE8FBFCD861B8B0195FBCC1DFF2D984166CC6F155A837E93514B6D327723D1
      AE5C0804C34C9DE500E804D42773D048F080EBF86AB52CA8B73520B28FDA8F7E
      B53C337DF7DF88C67DF8CEFB4C9B86797F7956CD0373BD80C53806E64ACC30E1
      485B81BD07FA845BEAEFFA980DDCD8621C0E60DB67A09EC800B4B8BAA6FFFE88
      971029E4F5FFB8989112329BE0AD2EC1CAE4BFEC467E245D7C4E9FEE7F0C7DFE
      A1F3112519F471EFE3337FFCB150FEDFEFD8FC287EDE1F6187C6BD7FE014D0AC
      FE1AF08CE8A8925D4E9FFD827331C334EE3A1CF8FCEF713CFE65381E78CF11E7
      0B2EB8BC0FADDFA9CE9367850819C3975D7C57964F356A036902239AC071C9EC
      C549518CDFD40896E00D9CE94523FC99298B31ACF64D9BD09826B4AB0A75E774
      BE95494C6912D27B67CF13178F938B5E98681CB93D41CA412B00B402AE6151E2
      1990C4787FFAFAF9C48347EF3D0F162F974544BF0A7045E3A63BE9D374315B17
      3E372976955D48F25D0AD34D849D37D1D5C2725CBF6913825860D636C3479A9C
      99100A17FE937D3863CA88A04019C246CE0A65B352C68622B69C1989ADDF1C4A
      6D882B51E8366DCAC35B4736D38201622A88E76982B6705BEA3B430D9FA91B96
      E2C0804E2F7261795C2C6B30AA8D992384E585BEF153A8BD322D18272C47788B
      30D2BCA6059A360908487797FC74069892A4DCB568895B05D207534BD9B4F14F
      70B7EC7233388EB459C68123054E697EE01A2E25629337645A9D10C644433F4F
      B3F817C4166606F019A078010212B98DBEFA6951A4F3799A4BC6F9A661D39A76
      685AB07D501246D77E6E726E16FD2817625291F71C63360C03E484213C42DBE8
      A3F9B469D382686FA1E805545D0663B15583FD93F2AF468D7BC3792D9C2ECFA5
      D2F9B9CBF1D86C10E21ED22C6085711067C1728EF68280CBAB2D2495A94B3495
      7D26B6D5A839AFAFDD376BC9F6BD60F9861FEE5A8599B6CC25977106AE70AF55
      066E5A6509968DEE6DB8C240B33286621C2808AA596EDB863475836F049105C8
      48ACCA814ACE962804AD2836C31872A5A4C3784B6CCFDC20CED331D8F273F562
      CB573D0F3DD5E03CFE16A64AC6F1A434A0110A9A990B1D7A768AD2104A6E8482
      F02507AF4459230965DFA54CC7A11C023CD785461ABD029926F16A51DA99FB85
      2B57C9604BD17C85B2D6D526E166CC876EF5DD3332B13BD3B8569E6160B6E3FE
      D3FBB85F0BE54496470A7539AC3B853DAA902E2C1D5C98AE35416B93D26A12F0
      F24AA396E3BEC54818F089D9082BA56865DFE08B4ACFE0CDC280D355849A917C
      B61DA7CE62BABE66EAF79DF2F67C3DE3DE3EEE096996B8FB9751A7C3418E8511
      F3CA4BC8C635CE8A5A2CBC4B03E52741BE460DFE3E15E68AFF4C122BAD74783A
      4DC4CD8068F8336F5A26453C33152FB6E48CF16638BC58728B367BEA3FBD3E1A
      FCECBD06272A9DD3370747AF706DAFB2B4C1E3A71B5399C1A72C0AE6FCBA0D07
      220DEE304C7853ADD5C14D206647EF38128C5F23A7A2514B73BF69C6E5905205
      BEB39A85DDE0706AA5B871B3EDB5DEA6F023B667B35679EE5D82C716BC57C0FC
      382AD334217ECF626CF3BE5656839BB319AAC8D5D60B56781932D9AC3752823E
      6403BDFC305418CD7713894D7FA680A1FF4DAC0267E9D0B4E4B696E6C3A5FDDF
      84ADB963A35AE4D217C1B230F947E9BE96862BCB7B2605C38661C2026ADC981A
      E6E459F12D4CF7984E673AF7B67FACEB99AB4AFD74B3A671CFA93B3DDA290DE4
      BA64A1377E8893F137310D396674FC5AAFC9D8613169C22C5771589C73BB6A09
      8E56671A732176B22633AD0C648D7C8EBBF9F01C8696F90616E2FBFDD3C3BDDC
      DB30CAF11D3940F135FD951150D1AEEB4911ABB72701F74D362E8EDFBFF366CA
      D733171430A59229ADD1FCDB98F92D1E50779A0DB258058FC842FCECC819F9E0
      CEC83731D357402FA73F7D8F9E514320997B3B869C8BF6938D440E77BFA0D39B
      2E0D599F68D860991742633C6F5A14E39EF9DAA6F438CF978218E35DEF2EE70B
      9955B64C124322ABA493843B8ECC457760BA12F4FA26E68BFC18B74749DC25E0
      2871848D3D322164DC6ED3930CAF0EED31E0AA1482344E730878DE3731DD7A36
      CD142F313C18628ADE42D17E97F979705F030666362B7132A40F3A9D854DDBE0
      7B4CA52AF5F6D10FE8502F4ADC903A6D17FD9D37DB0933B33EBE7694D30CF6A8
      B8098D5B5D1E1CB77E0F39F907AFCB6FFE3E5DF9475144B7086516A429F21D7A
      177BA0A422059325E316020E98B1236669D4584671FAE7860FF1B730DB6522ED
      8E02F48C8992D7CD7244101058A7C4897BDF792C5EBC489D5C5A15CF9699E59B
      EC9DCBA38C826A9A1776F722548A19B4A4EE37FE8C9F0D6A8365DA24B389B65A
      B0761C7C7BA81D3B12BD28483CCD52B0F7C72304B2B9CD5D4EFC039CEF1D74A0
      61310EEB0923A92E876CAE64C736DECDD87696CB50E5149462F29B7429CD9B15
      14389B88E2EBD2DFEA6F8DFEF0873F342BAAFAA9100E37BABED557EC44DD616D
      7208ABA2B944BE573E87C88589E7E3115C2EA2A38263F855CA21DB27DBDA4DA1
      22F9B9423323A14E83A8D692C547F37519E0BFE36B59A180380F8CAF6A2E5597
      8D5AF5FBD6FCE464CF190B2E0929AB6BC4CCDD7C35DD5A988C8F1B16C1BE7730
      F82666BFFDA3859C2901ECACEFFE4D4C403C6D2FB07285BCEB5D7585746C166E
      E97C6E4A71726F20693A07E401BF55BC97BF2D5184CA4F68D494EF9713E7E9CC
      61569A1A11AE80B9D0A6D854B2F315B4131CCFA0C866B6A464354D05315C5628
      D400A59AB118F73A36B6FF5F48146802F162267C260E78C8820F8857C0E5090F
      4F9BC848014CD580441EBEFFA1FB30A47280AC74F8316603596536D14DB967BB
      4A4462AEBEB2754B2BA731AEF925742EE35FD01CD6A819DE9B4DDFA16BE67D27
      1E1966CF0985EF05B9F10E25C3B3B32124AC465E837434A160C600329CC9FC56
      3C5D56B78149AA3B777F7D0DE5230EA5689EC2DB2169A5B9173E28396357515F
      CCE9A882F0AC38B0CCC42270BF57DC7254437469D4D2DC2FD459763D37D5178E
      54C15514DC01235B41FC2E3FC64869A8CE30A7C8D97CE5B2D827BBF5B330CB95
      3BD8A845BBB71A4D10287030AA2030ED3BA589A9B0704DA4E592A90AE8972904
      60809EA6F9979F5381B51AB32A19A603A677C5CBDCA7177149F93731C76A46AC
      EDCE74D5F1331B672072A5838593FE85C3CF461F995980464DFA5F46DD2EB2B5
      0262C55D6E38A06CC9910DBB90986D096624E0E04D9B42CF74A25811CD35CA05
      52227B2720C559707FB754FD62C752AE9EC962CED9366A32F7560E652A3F9766
      1415042632AABCC5FA1A6A804CBE8F3D752E879413D996B81EDB09F45E2D9563
      0B855097A086F89A6D75836E254CEC00E572E8A2A6F5C87A6AB8C8EE7B94AD23
      2EC1DC0BD3DAA464C0DFC4D2B67EDAD57AF1B3AB5CD9B05C90FF83E88274D96D
      B63E5B648D0A97F5B5599A5E48C6C34683387D63B900AA7CF18CC582365543F3
      5441C667280318750D6C3E1C75514BFFCEE4528D7B97867A81F352642A995507
      FD7B375CDFDD5AFA8F365C0F26ABAE986BB91E4CA4E5FA426770FAFBA3CFF2D8
      48A42A11760EF103FB5BBDADDEBF376A5FBF7E57F0DDBDF2BF5757F07B63A2D9
      AA52806DA521C26D9C9BBD3ED9B3FA63AB51FB26E3763417A7BBDB253D511307
      1AA4A485A4C41BC3B4ACF6AF8FFA6DEFF5DB1FC5AFA8AC76A3E660D0E2E9F26E
      751A35B0EBD1C033100F0D1A95704990D66423E45265B1F031B0418D211B5CFE
      460DBA849C6CE2E86092D866EB071858EFCB06C6C34098D20D8C871AF5BCF4B3
      CAA33B18FCEFB5077FF84BD5473CBBBC0770851FF37B6891ED30AC90F0702299
      AB7F038BDBF610CAE38136ED3562B97B27EF9C5F6428A374709E180E2C03A8C4
      894EF2A49AA5F91EBBC5221D156FD051011F7DFFEDEB23E1FA6AD42ED12A8263
      BEA4414D84355EAA10383EE6EDEC700375A3C68D319524DB264AD99CCBFB2471
      CDD350E281036485986478C4C4E08A97DD839DB677C4FD160806555ED93B396C
      5898F5D18B3430D9BF60B966FDB1777BC73F346A8F48ECF65F90A7F2B3F0618B
      6468D408F7921C509D4A600F13D36E866616C4A57267DF36D34F146835BAA419
      626C578A83EFFA4C8A09E02AA66168C8839A35F0F5B55D03511ADE246A1E0764
      F549856514EB596859C84C538D455956DE5C67E8725BA82238DFF23E209E8632
      98E2796C18F4D44C1A376A0F8B23EF179DA5DC05C2515EE047ADAFE5404E49C5
      989B492091F19B0149E74A324CF0D17CB1446EB70C1B3C93142375839025F298
      31EA72F05621A9264BD0B2A92966A8E251E5E03CD7B3C89480987703833C4D74
      B3CCC65727DBF45CEFB2B3356CD4B8E0D93D2CA4E8F39CFE707F2908CDFE7F57
      0CB27020FEBCDB0B25E5DF164A424A212FB4E7C709BA61E310B4AAE450982A12
      DBB5C285DE5C448284817C784B40E0CE1538F8A45D40CD82E58C5581944C1DEE
      0E250F72FA3A05C6E32CF6B32A70FD53C0F99E8073F729E05CB7757A5FD7D639
      39D91353678775018A3C674BDFCB970BA4A9BC0D58ABC6AADD6C43F30548BC56
      BD1268436BF7D2563FACF4F8E3561004BF451D59A34E21599CC317B4133F7BAD
      373A41C28D9B4F8EFCBFEAA0C85B961F54884C9A357267879A316E1733F4DD2F
      9A67D219EC87A341856DB551033CB9B8C9E2B9F7E331671F5EA32171590CF0BB
      B98D2FC94A4A4C63127C941F8F2156B7F435A3C6D3CCCA3FB4F117935197ECE8
      733296869719FEFE3C4A07F493D5A0EB6B0D2B755D5F133A3352342F61624E9E
      87646893C978AEAF55A883784E6ADC34E31A70E59811FB2EE3508AF35BAF10DD
      31D8B4589334035ABF01DC6F89F9DA96CA31F3204B865596F8335E66A316862B
      E46AD8912E6A1A27612A9CAD793C8F67342A10C5B54D2482AB250DC1A16977E4
      A231A65774CF4B9359B3009B5AC73A17D4DA65404EA46EDD9E8E290E94BF73C5
      DB4225DA02EFCF85A8AAE2AEA8A46153B42DD636607FF71C1DC166E8BDBAE1A2
      BE2BA97ABC246D3173058D2EEA6F32B16CDD02A4A95173067127990F1B9061FF
      436A6FF3502D0E81D79BE55BC5B550D8952FFEE752E7C52980A6F845DA433465
      323F292AA8180656BA550DADB11483484736B32592F3385B72D511CC517957A3
      16C4D0CA850E8509E1EAB8792AF4D2348DFBCB3349F4F25641A2CC4D2156B3C6
      9B54F2942C1A5DD469FBDD3EBB8825D4FA5FF334697B491C91D09C23DE13AB19
      FD384B43F1189F3CBB4F7B764F7E5DDDAFEB7F75BFEE67CF589427C038262DB1
      676A5E8C39D9A80D33033ED96BAA756EDC07B1CABD412317F1137A44401AD1D6
      E648AB1A35F46F58B53C69864F6A86EE56FF4937D475C3E04937FCB3895E2149
      B16153C44451859ECF54C1C938DB9824A11847AA12A4F339E4DC8CAB536C46A3
      51136B9D188AA22F76BE1B35FCCFBB564F72FB3EB9FD64D3AFC8EDE15795DBDF
      B075C725352E4750959267B3F48AF9133492ADCD1AB4CB6DBCE66A10876F290B
      2D40795A71608966D6C429ACAF9995C7BF66F5D5651A87B977268926EEA7CB34
      D9DB980276245C82A51D2928131907DEBF84D9F336DBE724248CF5606A3E807B
      88680A038773A73E83EB09874E89D28320DD93D0FD8CD07D4A90AF08DDD1D7AE
      6F3642609B5B26DFBDDADB6E22E2C4B7124266BA41C0E742D4E8F9A2B8F1E821
      EAA659A3BC36B21203B522FED5C97633896AEC60E908981360D08FD03DA8D1B0
      ADD01A2C6DC333B214F2402D34E47DA3A64197CC6A28A4BF8FFAF2DB93C2F88C
      C2E83C298CBAC2187F5585912FD065DFDCC0A554361BB2A69956174D1C9E6555
      2309868E222E2CDBDDDF3E68E050A359AA0A9B7ACE0088D534E74B85978A2B07
      0ED3905BB3722FD20AF5148D1A26A895FF2FB82C59FEB74CDB2E17D9AE0237B5
      6A2E644C4B7E1987404164D49B46CD0AC0E1A68698A17A381A58A28E376AAC65
      4EA3B98D19E5183DC87B53E386C835328626BE2A6F78D92A745E6C2D14CE8BF1
      4A9DDB8E3A3A064041A1C9E07FB8DA846C8EFF212B64539AAF5146D7A8A91BD2
      B13C4F83985B1F6CB703E6FCD065B7A816A495BB03F6FCD7A9C7F66F31D2018F
      F4C1C7F9B088EF7FDC8AD2FEC30F94A5E543AF69945C62A4EB6B0F3C56709225
      79E3840A57B39376F48EB23395C4BF909FB4D16D7338ABB7893056244C3805D9
      EA86F344FA90EECADE3C38B0EAF3796A86F0F25FCD0F905EFFF6CFCC1E1009A1
      CE03B72231D03190F080AB3F8B8362E532D212FCEA236E340D6D9401486BD4BA
      260FDFDF75F4F2B76CEEE20265A19C21F77CB12C0CD82F5B7E50DD266660C3D9
      40CD9F2F03043D7082A46705A4AD60217DE0A9B768EE5B5B1F3F92E47082E3E3
      47B243F28F1FD7D76C2747E8EDC680672B68A4AD7FE63B5B864AC5B8257BFC3C
      0E8D1B075E4A69A0534191DA06D2868D1F63173A0004CB40F688E407E3119F1E
      EFED99F43DEDA3CB8338A61C0DFE4CED9A601B883C782B13D4C6046EE5F49FFF
      9BC129A01F5C3352D36285662E1FB45AA4C98BED6C9E662FB6E7F365628A5816
      08DAE6E75A170D3B6232EE5747BBA72FE89F9E70213BEC5D0E8E3BEC37E9FE32
      1C29576C658420948640B30A0C10A2E96CD9BCBE3099E8BECD4AEC1EBDFA0F8F
      1CE070D6348D68467A7C077A6EA881565A428C573B299EE2D177C7A33B5BFDA7
      B2919580F4E4AB06A4D7D784E36F347DC9219339594981C02718DDBC02EAC06D
      3511226E063F1D597C4FCDF12EBCBD4AF5EE20C59A256765C6DD014DD91431C4
      A4D0AF85CD5E307105EED6DCF723E057915C6D182DA799C6A8F7B2C24E93A585
      D8B92A399B413564F3120779A362125B4EEFB4EC13836DDA2C2EA8F3B4B8D037
      79B597B16C48345D8D1B0F6BB60BF5DE83C7369E0B5B5B366FA35A66A11E3A2A
      F3DD83FB0E66A501A1F2D061B9E70F1DE532434DD2447FE158FF8108CB1F1F7A
      B47142F7AD68DA4D9B85DEC9791C1506968729CA4A5A2078DA17F18241E953C6
      5937D78FDE472EC006CC4E726E32708D2F03D335271F25432507592A29075401
      738E637D2DD4F94581740E19E30D5F8AC0B2871EFDF04949C4C84F89B02BF16A
      2D8C0A7574DF4E4E0B4C14D0891C8670A3D6405FA32956DF3B72BB060CDAA42E
      553CB3A9AB26823BC8989872C170D6215A7B46AADD6466698FC4A8E74A5912D0
      265A947B1B2855640E23B6E39A7552C1A5F4DD0E10B4624C2299DD786F91E7C2
      B8983568162FFC548165612F0F98E84BEA31853C498E6DA36654AD5A365864F6
      A2209062CCCF7049964EA466B905EDBC14D2CBC4D5374B5CAF793C6DA6F15C52
      909A9B8705CAA24D276C9E7ACF84C6E9EEB72159F9AC51D3B927275C69A7CE5F
      220E23D0968CB461F3B31B7C783F6CB6BD0F69468EC5028DFAAFB2F42A477E65
      7B567CF7BADFACDBE6766381180C7909202749D38BB9CA2E8CA03715082F99E5
      ECBBEED6D6D086A8957B6BDBC3E4EC6B67A9E7ABE0A25113AD9408828CD901A0
      7D383ED805964A6A03B8497AD5F69EA5C9B38A846CD44C6ED7B76FF8BA50368A
      D6068A9B737FD89F6A98036426602B12146299C02E216D9690A427FD245C2DF9
      0C708852864F576A21CCC04682DEA4CBCC211DC491814D6CD43C5D2BC2F1EDEE
      15338B8D0FA7DF1FB73956D8665CD3B64444176A71932D733EA56DEF8D2EF640
      1BB42B64C986C88196C49540BF559787DC8BE16D80E5F48275CA5FD3E42A1C37
      6BEFDD9A486D394F76C3CED66CE726068FEC8390521CFC78F0C6DB389BA5BE9A
      F14BF487B75BDEE9B966A0F4676053F234AD890021EDFC805445017C4E533265
      BA350C71DE8D755AA51886E130E863954E8D66AC14D66960D7E92FC76F76693A
      BE8DCAA6DEF1DE6B3A380C3E2E565E030171911E437AA94A49F7EE60B7579909
      ADFCBBED9D1FE8CA734004B5480D9B023264AFDE9DEE3AC6C4D495E2F9697883
      C4AD61DB45AB2EBDF3AD9734EE2CF12C8E35BD9513923B7B07077C1F58FB09C5
      3CA8BC614573FC3F6A2462E0C9E08501AA3659571E7E55A11FBD3E39ADC8596F
      830DE8672731E7C28D25F3CC287B56FB51B4F994DFF85C7EE3A9436B25BF31FD
      AAF90D9D2F0CA6AF210A413517E80685C94EE7F3466D9789E9F7472F413A9117
      0A24C9649E463383DF4746CC59A6F39CEB9A0309EBC3D79DA5B0D72D1D5FB39C
      5E3BA9F14BC32C289D5D4EB3914A00D146018C5918B9B9B77F7A88EE83D0503A
      D77A6B13CDD4A686D1BE5113959A7F147FB02C9DA0AA3B63659DFF6D894CBD9F
      D186EAE2F6844D1EEA2C16627A0E5CE07316F88671EC72B262B7F496F7D3FF79
      17172745BAF8B951B3679F77D79F396AEF1A08A724D784B333678CC2205DCEC2
      9280F9864D1FB63153C303203885CDBAA16C463A4445D389C21C3157A5636CE0
      4131815000F79BE56EA15B51A4224EA5158920CF554101803B6153E720BE847A
      D950CB6D5DDD50DC8D8510BB961FE0D0B0651FE6805DA3A67D4FB8AAEDBDDFE7
      5C7596CE566257DB798EEB3A57091DDBAC6D7FF76D9C8ACF7CD30255C66D1459
      FB979DFFEFD8DBD0894DE3FF820C858BE6FFFB66DDC180ABD4DCB9BC3BDC3F69
      627BB58BD2CC39C290FA79CAE581683A9955F4DC4BEFF068F7559BFE3DD96D7B
      AFDFBCD9E67F4FF0EFE94913A76459E10F76C857AB3A0BA893D6614553BD3FF9
      E19DB1AA1A791B9C6C3625D89C48A07DBA047578AC9018E14979A4B1200220EF
      1A391131322A28239640858303CDBD1DCF76C55578660873CE3517975654E5B3
      E7BDEE603C98F44783C95607FF7B06CD2A04E08E931A0EB9A9B59507218245C6
      F25F760E3E9477AD61F9D495386E0BDEF8C78F02E1EFF9E80BCD5BB6746A357C
      DBECC8AD99599521C8C65AA50E0C97A979BCAF266468E55BC5AAAB8A393A6E8C
      46D1B8C651337C9105EFDE1C1F57D438FD932D170E035E15E76719307D04135C
      5D36CD6BAACDE50EB976F866EF359F22182772F1FF7270B453BDEB4D9D4DEBBD
      F00ADB0CDA5F4EF6765B24B6B2C6B9AE657B868C5C9261F58D78FB6EE7FFB5EF
      48CD3CF11A7D362AF804C3518F0AF6EFDEBBDFAFEAD9E03591AFFAE22D6DC6A1
      66A210F8AF2603B94CE8846F79EF734B064E068890E16177536191307587C805
      2854426771E53A3463AB4F346089786699FEDB32CE80EF2135CEDC6F1B72DB08
      89A4B059E3960D52B4C4C8E2DED74D8B3D00466D74E39AAD9EC11D89A5809B93
      38D8C7464D8D8306DB95F383F22692175A0A64A42CAB59436EFDC772BE6098D7
      D45916A27C9FE5B64C7E912E960B6E136BD6D8F71204E05E98401C7739901524
      D5FEA65AB159033E48CFE4F822E976A9B3AB2CA63125C83AF60F5F356BACEB6B
      3F5DEFD2D900027341DEB5BE0EB4E510CA106842F6178EDB79962ECFCE49BAE2
      0FEF6C1683EEC0B9820BCE45B379A1E60B66F99CB36FE86BD41447CB19D38122
      76EED1CD90BE4A36509AB516B67F8FDE7A915B7D518124915E1960DA21BE5042
      C46F79EF8CC347FF4F3E3C2A373935C0D1EFE6CD7135B5FC899A1D43C005A4A6
      D34369254234F5C6E0DD6CFE9EA6E3AF30167FA5B9716263CE2F1BB5975FDF0A
      FCBA54DE6FAB044030379A75D5DEDE535CBB51325665FA6C0936377D0DD62B86
      4ED96CDE24AAD9958DD303E593D513C2376A7BA73B28D83EA081BE4AAF1B36F4
      1373344CE1800A00D941AA8C2310B6334D3240DC2DF2DD6B96DC30E6C4492071
      4886ABA6DF8D02408977C326796C7216F94D52A86BEF9C2EE20C9711CE50E64A
      D08D69FA38A435F0BCF327495D97D45F9788F847459E353365C4BF68BA468569
      BC42A893B1FF9A75A98E96DC0A2D71FDE60F775F627DB4196DFA67847FA6F867
      E26DE09F2B957B2DD46570013AE6D47A2476DB619C074F82A02E08BE2E73DD0E
      DADBE669184731DAA218EB64BE5045ECC7B3983C2BD6CD7E4AFFECEAF5359A41
      ECFD658FFDADBFECF52D240FF39EE6E932431719AA609A751D25F2058EE2B718
      A8F31AF3D45B26B9B8D3828ACEA68901592879704DECB261B37A7553E86D8CDA
      9BE9E48C3688ACD80C5E2F27754703CF8F8BFC2993F0B94C426FFA9449A80BA4
      AF4B97C61B4457B02418F76F4840C57395D0748145C0B8291FA359081BFABF3F
      FE113FA2E8C17B7070C1EFFFEBDDDEF1C1FEDB1FBCD679512CF2972F5EB8916C
      85FA3256099AFAB74864BEA0FFBE38D5F910837ABE4F13C89F0F46E3696F3C99
      8E5ADEDF31EE5998E5B3E21F5DAFE5EC6310F53E37D6727CEB6BFF8B11FE9DCE
      5D4E96941C3CFC843DD7D7744039167D33EE4C3E46695A981F03723DAFF1834E
      C2E45C679A3F8D8F20358ED3CA4F93B316CC3EE65191F87F7DF0A45383EEAD2D
      DB40117C9C00DC46D93E8F5007290EF2C6B1A972DD3E3EDC6E7B6F7F3CD947E9
      DA6EAF8DB6B2A38639B266427B97B4E586504FBAFBBD33546C226CBCBF2BF96C
      648566F12F788714B7367122AFEF2B87E03E401BB612A859078EDEA88998B2FF
      CEC07B49B341B1718A3E70B41892D982C60C465BC8E7DE067E383B4FF36293B3
      062E17D0344FC9A2654D2634A75DC180E43009CC4A4771485B355BCEC9D68C0B
      A087907D46C30600BDD022E6AE26DCDB08979C4756DEB9925EC54C9322617C03
      7F79B689D64D7A7F0CCC487860E27E09F6B042A546B396C7EC78774AAB635BAF
      CF39A5A1C2108795562CCFBDBF1C1C1FB812FAABF535C15C07268E24D8253780
      B9A7B9967733443EA900D2B01977EF24F15962DB546DE1D6FEE96133D7A343EB
      C181CE0A2C05370C305C456E780A485AC5A1699AC8B7BCED599EB6D9BE68AD7E
      B60517065D7A22069A35E9A34AFACFE01C23688A4DE696625234054AE9F90C4B
      ED84AF4908C32E6ED64CCC5DEFE134AFAFC979DE510B322B1DA29A29964A0472
      855B7CB421CDB3AD3D610CE70D560C6DEAAE36117DFE2C03EAF1D146F62F07F8
      39B04C70341E4780E52931768F53F375B944AB990FE4A4596F3B9B83632CC0AC
      0EB1480B959335E5B5806CDCF22EF40DE9A986696DE4A02AD83416ADAA7983AC
      49F5DF3518F2946D69D4F5FFBAAC963B08A9666C985EC5B3F5B519EB6A5B89A4
      3D58EFD7342B4E4B93610F5D8EB23554B115E8DBBDD48CE89ED2206F4C9FA1AF
      CFE3A46172C19867BD21CC330B15631A4D04579BDBAAB5A1A26CD6E0AD2BD2ED
      75D9BA3470AEA6E7368DBC6332AA907312CC79063962A782AC90630717EBF0FD
      D8EF9FA91B09C74AC52B4C33B1C5F9E534219BFC2DE35DF3934BD0D9BFEC1C1C
      5B23BCBE70A625AEA94BD779D1EDC2952B170427DD368508FAA3ABFB95AAD9EA
      EACDD2F462B9F0C225471BB80A3834A7881BBCD1C4CC6090CB24D3B3B8794AC7
      3A28635A8357C2596012FEEF2DC5017CAC5D533AE9669E038AAE913381B12E1E
      88D732502612C66AD1FECDAC15D03857C31DC92E6EF3F68FD5669D1A50027764
      D3CD63BF43B2405BDE8904B3B05586BA51CD6CE9335F48DCDD9270DB9C57CDA1
      32D23F79334F650737F3470EE701FDC22C868826B853F86DEFE490BBB3B6BC57
      2AB838E3F048895E3E8BE7B1F1C298F585FEEBA024CC22702570B3A6EFCE4267
      CC8A49C27ECAFBDB52E78515B346ACD35033258818E6E246993A43E39DF41C91
      2CF7B5A5BF2139FCE9A3D2C09A5ABB14235A8A3D32A8B274A513C3F432002544
      800AF88A20DC9BA8CB3903BD6D91914997E03DB2A2886E2388540948C0CBD151
      841A8D4BBA1DEE9A20E026610A696B6ED6C294A704E6CB9131CEB02E724EEC39
      C8416BF89FFCA76DD3E78CFA5B1B652CEBB5B7BC5DB9120834B7EDE988B99B02
      280FF12F3A2C17C7E0E748B4033D6ECD5A1DBB3688BCFD98C634D1D39B853610
      A4641F2102BB586832A2B7BC4399692E37A37607FEB95DAF1F125C139EF09303
      5677C0BE2E4B7469A0F6E9FCBEE71CCFADF8B12842D4831819D8B697D26ACA04
      94B8007741808DCDD31D14A346E222B0BF26D2CD5ABC5B0C895948BEC14165F3
      50002EDDB08C9FBDE36CF2ADAF1942246321999A1941AD3108018A54FF196892
      0CEA77C8645E769E581F7EFB964D5A84A9CE798572F668CF75FDB9B69CC8E81D
      FE8D164F62B9295C615A4753F2F73804CA53BDDC6D49F275E97DAC57011BA105
      1399DC5539AF2D493EF9E935098AE03CCDC4F3F7D302C8E340B52431D1AC0BAF
      2ED318581262B803202C00DC04D2E4D68A2101967ADC4B156A7F798690C8EF5A
      ABFA8D16954D9E8ACAEAB7F6EB8256AEAF7D80162B90FBB7847FA24E62445541
      172AF40E9A5C17F49BD07565906F4BCB21B641C9D5C204A934971800486FF5F5
      92BD829342AB39BB39F9796A6032C904108E4B955F78CA074E2F0FC3E83A120A
      CB79236191DE1960EC0DA98FB121934D87400C73481259735253D68F16CB07F3
      B33D55BBE438A5899F6689B77BB0D3C4A9B68058E019F0A0FDDDD65D55422660
      D4A8E19F62D826EBEDFAC7EF4C80F3542CAA60A3E6B06D0ACD71FD24345E61C6
      A13F9AF8FBBF7A934EA7590CAF9C22D01CC775FCA0413A635722092D7D83AD5D
      2211CA35DA8DE4F3595F6BD561AA1D2C81613F0D62580062D81B6A8E83EDB7BB
      C21BC0D3A51FF6DD09DC10BAA33ACFD1E696779454882D0CD684B0AC5E4BFBA2
      F0B4C4BF3499FCC8B1ACDE897C095B8099674CD2F9C956FA9CAD347EB2956AB6
      D2E0EB42F9189DF8DEE4ECC258CD524E99808ED7909531285D776BD2A88D5B5F
      3B903A64FD22D4A624597BCB229A98F26504223295E4B3B232DBD48DB6A54FF7
      8605D87C2E203E249E50AB735264C2BA97D9B21DE0E398F06D91A207DB402E36
      6A350C4C11895BD1A02F5CA816447A39B8E243B2092CBBEC9398FA9C981A3D89
      A9BA98FABA5813156E77DC6452C06C8E85DE4691A54B1F25321CB9DC5557C9D9
      12685C3A6FA6A3F5DA81DC032F7A7B67CF14044A63A21F2F1801997D13134EDD
      67EF94CEB96BDCCC40F6B69AD316D470E3EF9269E2BA1AEE78A854DD97B93F71
      759B0898B36D2A4218159E468B1F2AC5880C2AC109E90ADC0259A4AB76D913F3
      CA6725DEF049E2D525DED7C56C30E282DC0F700A703502B887F6DFED9E58BE04
      91198DDAB51AE5DAEE1E28924C1DC5F6C1CEF7C273DCDAD5D26CCDF716117312
      DFAD460A6BD6371584FF9CE1EF32CD7C2206CA86DED3C35592363FFAF748D076
      21DAAD8C46B823E5364124C6C894F6A465B08973AE485C6E65E4ACBE61AF7413
      C33EB28CE573A92EED62C8EC1A3A2DE85780E05576E55070B7DFB18BB3611908
      68BA2C12079B9CFB6466605BF0027CC9A40C11320566B2EAFF3764E60C2F675D
      BB799C7326BC24F26BD66005F8F9DEBECD93777B074D84E77FC70D1CCF7D8662
      286344F90DD956C204D9125262E90A694917E306670F2BD4DF556305043EA052
      28D26609C596E94D9339346B68DB24AF6E7ED1DE417A26C3437431CBC8D99DDD
      94EC9C0F30E6DE978D9947A8E8DD6ECC3C8BA8E7A59F356FBA83C1FFDEBEE10F
      7FA98113CF2E67773B76FC98DFA559EAE2268BE78E8676963E44C2E28136E9C8
      9FC597081E1D2F1314A2CB157E97A5C8F58134EEECCB112AEE59289AECFF1AA1
      E2E58B175757575B091292E41BE68CFB909A31BFC05F5E0CBA9351FF7702A4F8
      D2E1FCFDEF7FA7593FE14F3C7947BF66330E252963C8C7B9CC2CF5D20840CFCC
      19011DC0261E6CB6D61162B92D98F2A27E5FA17107D9AA179956F4701F6D58CE
      18A401B5BD13FD37C65D687B26D0CC71E4B6A78B60AB597AF9F57206E4E8058C
      8D0BB4884B9C28F36C908CDDAFD3A710C8E7422083A71048FD927F5DB43AC7E0
      6E5D1814E37AE40080FE8A0EFB8C4916E12498C29DADE29ACB7C84209561C253
      F2CF4F4E18A387DD776B70376AA3EB983597683FE10AD90A95121DD4FF7C7F72
      DAC46133C5B77089F18507AAC372C121025F03ACC2154C54C03C9B38916D8EED
      CC532EFF9EE93315DC78C76FB70F4DB81C11903F99B3651AF5CD2BC2EC83D00F
      FD7B887F3FEC6DBF6B73CC8BD4CAFE4923EBA02C76F1DDA37751129E613D4EB2
      4C721569896A2D6ECAA630EBBF32240FC4ABDCCB66694B5035FDECBD4D1DFB6C
      1A79BBFBDB07869CBE7163159200910DB729D69898469D85E96C06BA297A8017
      642A47552FD85C4C29A3A57B76F6D2EEC14EB3668A3E3DAF55B6CEB70CB90B60
      4AD1466C0C39C350C361C7289D4113C49129EE840D0833AF59B2DDD50FA1ED9B
      34E94DA9BA68FBAE4703132A6AD6767C4F6BEBED9C1E1FB041C93A560C4CD339
      081C591CBDA8343D9FCCCBCF9997FD27F3B26E5E7E5DEC51A3060FABD49B16BB
      00675B2253D538226D241375E62F9F22892B1BD98048E201C481D83379DBDB87
      4C252F7EA149333667B768702FEB636B7BDF83C0F79DCA0AFAF9B50A1EAA06F6
      81467CAC02FDD2FB5EC5190D6FEF463770517704C35B670D1AD3B196C2C3060D
      09A5811EC8621A34A61FAC2395262FBDED6C9E66E47E68B540A46D7B3E4FDBB8
      CE4F6AB3696A134EC90B76A43E70FC456728688071F87EF758AC70E9905E5F03
      F78FE5EC25F599E7EA4C6C4741C82179AD2E0F0568A251FBBC127BBAE57AE55B
      4F4640F38C80F5B557EF764F9974C59654DED0F9B305E2A104D6C451E6BE3C86
      C525072C29E450C61177B014DE4CA192948C3D6FA32CB692A7B1FB83073D4464
      E3E10C0B723A8A9839E31944AC3A66FC9D261BEAEBDF3E2EF7401342B8D35306
      73A50E8B56CE8BA7D4B031E7059F9ADB9BC02F346DC82E3EE1C430A35824171C
      C6DB8D2F69D4459A352B86F7A483256140A6F9EBBF788BF334D173A19BA74367
      B21F12F833D553956AC466695997E37175F179BDEE8B478E540EDFAD0D99DC9C
      04F08C857C6090A2997A9CDEFA27795F09DF660408030A164BB1424818A2E63D
      020F79D3181F6D5245186C73F0793CD789E0DD333415C028E90700289EECFDA7
      444737D02000202EC3886DC3BC021EAA50C218E8664ED4C91FA9F9E3BAB8C6E1
      0B4A25E5CEF7DBB60491CF9EADA8142C8D73350335139D32E99C43DA64179EFD
      219DB21B44DC9B38A75DCBA5C02910931269CBD552428F6100936AB7928B484D
      86A859D37A9B5628CA79CC2D5C8E0BA8E22B000CE1370175A489B49A35789BFF
      E05A6A1A8BF4BBA0EDB0421CCF01E546B2DC4BA1EB6B801E33032ADDE71D9379
      92A24C00E0322F37ED8304C6659F484E311A1799A5E8DC947DC346312FAF77F4
      03EAB00B99BE79AF2C409BA1A2A4414AF03C0C9C1473A35CC785C59D3ACBD4BC
      2D281FB7BE0C7EAAAFF9BB74D638B8DDD732DC4A87BE759C1B79FF4E043DCD38
      FA6C44D622062FB8CE1B7BFFFF66E919576C2C17294362378C89637D4D6C9279
      0C7C6E74ECF1B1E4634BBAF659210CC5262529D948DBAD9795E93E77CED8DD14
      9612C75B23183278360E2C3F9ADB1BB9269CDEC1DFC0CFC3D7B4BDC5B2E06C67
      52CD8666695AD86CA89880F6455A551D2C0B7E1A1B0AF4F00D5BD5BA452FB63D
      DA8E1FE5275D044F604F9FCFE2F59EB2787557E82B936D48FDF88994F8374B82
      8094A2448895C4BFCE9A3546E9E9202BC367783B861642AB2176AD000A0CF017
      D3AC61F0FDC7E4EFCE7D92778B3437BC03242811AAD0A8E781FC9B2B46336E9E
      995476804B5D85C1E2669BEFE43C8E8AEF76FDD9CE2C0E2E9A35EE9FB667B39F
      BD0FD98D06BBEEB930CE21736E50D336FEBE7AB37B7CB3574734F8B221ADAFFD
      714BE78B2DFE9A5B8FFE75426313A7DC588AE23233E940030FCB4FDB07073F7B
      AF0F4E4EB965D4C398A4D8A91E0C6DE2A8F776F7773DC5D0E079099AE542CD0D
      1BB28423AAB5FE7C3591903427655679AD049D51E6EC0036DDCAD2A2049E69E4
      2C9FCF5EDAF40618C0E7109EB0C5BC9CE6119C0B3C5BCA30A002DE559B6B0349
      BF2BBDCB703E6226CD33DB2641308EC754EAC45FA0989C6BC9D90731F5851A28
      87911369985AC326CA511BC9901FA6E10F6495EE1F1EEDDAB094456B849B78A9
      32860429F92F9A38957707BBBD7A8BFD2DFA1B16D6649DD0696DDE0C240B2E0C
      0192E0A9A26433ED5304FE8DC6B18DFE64FD401B7B4FAF5041731E2FEC61924E
      0B5A7C54F83776F027497A75E35D69C5705DD5D2E8F8BA9ACADACE8AF3799A66
      4F3EEE677DDCEEF4C9C7ADFBB85F97512E2E6BC8578B5070B2C5AFE46403E71A
      807D6552FC4F47FD7347FD09E86DE5A87F5DEE8ED7E0535A166F7FE4438C968E
      B9CA2E0C0995C53F8B232F5C2EC89BE0D4AFF4EDD02DB804A10E908FB9A27B7D
      AD511B2B9463DC9B237E3FD8EFB89BA2F0001E6238941A893CDD42C317E48F34
      14E72D87137A9E2E6761C562135620DE205DA87826ACEE02800E6F8A33F74F42
      E97342E9098B6D45287D5D1A90F5B5904126BD005139F46D298B546E3231B6AE
      958FBB105F9EA7420DCA5D547F5DCE17068D40154D8431BA259E024B89BAD0D9
      85154E286DC02CF61264B6DEA571D22C083371C34ED80D6358167684E5AFDF99
      BFBFC37CF6643ECC6A86CA00A078298FD13243B07A713807D410B698CF0135E1
      81D871D79EC845390D5336A8DBA81D57144265641FDE54DB2A358BEE2B2F5D68
      1892087F70C0CB536734E8464D488E679C3C67E43D3B4EB0165A46BD009EB670
      EEA6C0B62FEC09406C8B6D8318B216134151D81932CE2A4057D755BCBEC67421
      5A5E4D00CD3703D1A720E0370C62F190515BA52C9D27277F383610AE50B0527C
      6A624100C9FD20E5F72F2DF0B5BEA6458B0105AD666DEB3FF0990FE8934F60A9
      9F52D0BDADE1D65327E78A7EFEBA843F885FE5E0A7D35971177660407F4736F0
      7624F4E988DF77C4BB4F47BC76C4875F97A701F4E274CC5F7AD12C1576E605AC
      2F56762A8B73613880369FA162AE152D7FF9E5A6052E46D26E39D706673A472A
      07F70005AB2B0FA2C9FA3A93479887C239453192FEDB52CD1897869464BA3C3B
      17E25F5BA8684C60668BB6C9771504CB0CF829F4BB314636069E7F53E8CDD52F
      1636C92D9A21973671351EE0CCD1831348ED36D734F1C77231A08DDF09EA4D33
      3A19B2C409F82F4F37FC7337BCF3EF5F6989EE6E11FB4797A83FAA5F25B740B4
      22BC409F75EA5AC75A4EBD71E62449B8B5B5D5FA1D17E6EBD18DAEAFA16F1A16
      2F63E299C4AE34B7C5CCFF1D9F49C2B7C8B466CFF6F9BF79F7AD9959B23B5F96
      4B2DC123F6AAEC8B241D2CCC90AF114262B63DE3254B678390CF827FEE869369
      591C56B80FB88F6F8EC58330084C1F78E8D864F18C4DD408F36F2CB6B8A5C293
      DF84DD85638A2C86EC2C4E99B32F079260B49CD90263F622E6B49731B8B3C8D0
      5E22B15CD8A272528C09D3C888696E29FF96C532D36D069256331AC995A11F54
      B32B7593C381B9C49494095B3AC6C20DBD75B6E54909FEEBA3FE3B8152223979
      639878F142426FC4AACCD462C16F340B6BD2D96537A3196DDBB39D22F3F53575
      01272133F5D889635F234791BF00FE01B6C8966E54BF000E33BE04CF109F4C48
      E7680E95EE8DD5B21DFFBE43EBD710473F7F793F6C1FBFDD7FFBE6E503D705AD
      AF95710FAC5FE59C2A2E51CE79116431E554CFB102A690FD4C688D591709BA3D
      FC33A92FA745BD90432C248AF2085EF965CEC728CEED5F11EB66A7CE917FF0D1
      A31D4BC0A746EE7AA856F734D102F4786EC896E77CD150E4C0D701DC7A477D96
      FDE6E803D0564E83DC4BC7BE97D7EF0B0F5F4989BC854721F54EF70F7ADDD505
      6ED3D96ED73937714638208F05896716239E0139672A832C08432EF05757A4BB
      5B8C4A5E59327ADD9441839969B9C04F8337AFE4A4654B81615F2648522B6F34
      F0696EF6AB69C33E7035D793A5FF193BA0BFD5F1F6FEF26EEF78FF70EFEDE9F6
      C193D95F37FBBF2EEF915C13A352614B233285CA06E9ACB8950F5E5F6B1B3BDF
      D036CC2132E6A9E108AD695CC3AD0E5CA39024BDA841BAB22DF935E0CE232388
      5A7C2D15EED70D17B8D0BB03C82032B99781ED4C5AA4E8A38FD17848AA4E9BE2
      DC4BEDF86F5B3B0C7B8F18EA1E7795B51C994FB3EA4B52A3BC39B09854A40A5D
      F12A1E84D3B4F3342F2C529421F7003E041B1273AD928A9DC0C22DD7DA72B9E6
      C0FA27E956CD70BA378771884E137EE1863B41723D8BBC0D543763E712AF6CE7
      C8E76D6FE7A46C89E5BA37E32AD9F0AF6F05296641D6C43E57933A0447BC201D
      8122CAEDEE98F675014CB48A84A5F9F32415BC4F1A3EEEC25C8BDEE2E792C682
      C9537D3CEE12562CD766B6D2A89B8BA547FA9516E742EB85AC3F9E9C6FD6BE1D
      FD4395AF3F8F71FAAB03E0EF3FAD8DDE30B64890FB39BFFDDD9BE35D314EB5CA
      66404BB6D4598D3A88682170D3B0809B71C8A6453C7F3084A1871BF0ABE5190A
      AF38342F4EBCC91507E7691CD8424C5F4BE3AC854610CBA35113C1E5D5DEFB44
      BAED58FE9966D97243CC551683EA1D72056408ED7C7FECFDD4E1FF75073FE358
      EE493FD73BC5D2A134824EE893E6B5136E5DA0553B5AB0D4E43606F980B18BE8
      6BB6BC37B144618C0DB790AFB46978747D73092BDD0659E192F2B21A37714913
      29B0A4D7D6D7C860E49DB1AD63576936A38F71D4278ECA88CF02B744F0522AD4
      CD581DA99F956E62E9C4E0AC9A133CF4204E5184561B5893B959A2FF8BF79D45
      1BC2656E39B9381F0A5A8ADE594BD8256A8BE49BC517D29ED712F85DEFD97E55
      DB4A2EE719B9D1D02EA576F4C2B46925D7B24E65F784B9E65810D4F05CE55E35
      69CEC14472A19038366E822C22995910630167DC0C7C019F55F3D6509B3F625D
      D97792D316CC509F2E4E2E7F319D3539A79576E17315CAC1E33EE2B24BE2C919
      B8DB19E83D65B656EDFFAFCD73F106318513DB43BCF1E6F0E47453AE0E6E1AB7
      AD3B619EA7B34B263943F7432AADCA20016E73044D746CB384C8B649D21B8D70
      ACCFC45C73181B5CFA2AF3632F475C14E5BD4636403EFC74A93F77A97FD748FF
      D70C689F56C34F261ACC0D2573F557C3586835AA9AC5C58D09CB561C6C9FCD57
      E4A34C85459CDFC116FE74E43E75E4BA5B4F3DF22B5AE4EB12A90884880D6A47
      7106171CE1DF328F4A0A826C303672D9046DD4FE95E3575E0F9E467DEC5CF9A5
      661C8201F19A025877A326002FDE35C0A26AFD2CCD6EBCD6F77148C63FFCDFC3
      34F4DEA08EBD65491CC858F6B5C1AA616DDEA80931EAAB25D0A0F15B4BC32329
      FB16168B1C3404A0CE745171F4F1B744D22474CC14775B96B43E8D9AA343265B
      E06A0A51C83B45BEFB9B2C6E5881FE36AD21A7EA5ACB04485749CB0617E12A71
      F840CA2C4CB1EB25F28D6258318E69A32673A267EB6B75A7728329DD987022E6
      8C97B110C963CE2FE2451BA144D307D2F6B6B6364D3D6F50CD6F73D8A575E29C
      C956DBFDF6364DB444B85BFB08F616DE89756B5B8D5A1AC524C698D85252D052
      F0695B606C6D721A45718030BCE9636ED41C2440F8B2A2940216E457598A7CA2
      85E722B3A74CF373652ACBCFF535800988A31F67B89A884481D90BD118650FC6
      06970CC8BA6CF2CE9A40BA310AE570B03C6ED4E290D5A033346D17575A5D94D9
      058D246D9CCF8D7690FC7C05542198E14F2E98DEA839B1AE88DC6EC7B7320E2D
      C7C628B132666BCB24B8DDF236E8D0E7DEDF9688892ACF971A3355929493180B
      343D6C7D0DF60D59069B5BDE36839F7294C925A143BAE486968A4685F89BF9BA
      D07B75D3AA91C3D940528541D856CD976DEA59F9798042BBCC7E237BED0F4B21
      8120AE5A2C664833191C68C9A1DB2AD920CE82E51C6654D0B498E36A44913B71
      B2F4CAC60FD8BCF672D4D3B89A2594F72374B8D078B360BCB868F8555ED6FD73
      E9A20D2A080C1217FB0832C65CCFD32DEF24750534D0A45AE5317B862A2CC9BB
      33CF4FD38B66DD4164066E50AA79E6ED3FBBE42E96B39443A4CA87A4FDD353CD
      FFA73DDAA772E8158FF6EB0260D7A3A21069D2C41256AA1AE882366ACF5EDB5C
      0E779DC126798774351747ECA449681AFA199B967448C8939156A686B9B3CE5B
      CDBD0DB6414588B0F49C8108B45968F165F4BC52B471DB6F101365933740EAE6
      5E48D73357CF296FABD0F9002AC5217A46502DBA4CE8E638950BB888CC3DCBFC
      8BB949D49604B51BC64AB7A852481A2E546E62F6A683CD4132356B29DF59B32D
      E39A4146EBAE76DC60DD244EC3D5BB82632CF8D165BCE68C2CB1277563BEE3BF
      C89CF801B604F40EFFB64DE76F17E0D48F24684F738649C246144EFFD5794A47
      C7A86144CE7653B247C90EDF22A1A355F107EF7B32E6C03C7963AA66EBF555F7
      407D431F586BD654D54A29F875594DA46E552CFF3A0CC3E7FBD85A4C657FCE5B
      FAC0F5CA65C555DBF5CE700F9081063C6753577B2D9EE287F535E90375F80D10
      32CBE45CEACF235AEA7389481E19C452BC6ED5D61755D2AA2E9920F9AC379CD2
      BFB09E1FEE1CDE3A77FDEEB033AE2F9C59AE716F3A9DF627969F8916FD8F1F51
      12AD993776D819F89D7E67D01D743A9D11FDFF448A757A748BF434D49DC88FA2
      C814F0049D1EFFB72FBF0FFD417F148DF478301AE2DF61341C8CA7E3CE6838EE
      0FC39E1E4F46E12850C1B41BF8031DF4FB9D6E87DE341E4CA260D2D7C35E3850
      EB6BD3C0EFD1974F7A433D9DF482F1440763D51B074127984CA7B4B1A3601A4E
      FC9E1A0F873498F120087BC3C1A0A726BD4E77340A7A4138EDF7A3F154F77DDD
      1FF7FCB01B75C6FE30E84F27D3408D074A45516FD0EBD1D768BFEB0FC6C3500D
      C3A83F1E44E15485EB6BC3D1643AE9765577D20F465D35EC44D34934F095AFFD
      A037E98F27E34967400F9BAA614F0DC7BE1ED11C691C7EAF1F4EF4B433EE75A3
      69470DC25EA4FA934E2FF0FBC3F1A8379A74A290965307210DBD1B06DD89F6E9
      29DDFE44F783E9A01F8EF5B0D3F747EB6B7EA71B0E27FD506B3D8CA6B40C03DD
      9B767C1A433FEA8F065A050335E8772693BEDF0F3A535A381DA849341DD0DA74
      473437FAD59FF6C6D1B0A7D5A047DFA2BA41389C06B452D1B43BF53B7A32D4A3
      216D4BB73F549350F73A51AFE34F826E2FE8FB9DF5352CF6300AA21119AD5DFA
      023DF2A3BE3FD593290DDF0F47C3E928F08390E6EBF7267A1CF447431D04348C
      6E147507A34E34EC477AD2ED87FD20A061F8E348CE4A84D343E7E553E78C7683
      D6408DE9B1F2C70ED9EE5DFEC137272D1AF7E88C05E37E2FA273657E9EE02045
      23859345E31FEB6832F4435AC6EE38A4F5A69975E954D14E446A38ED0CFAD89E
      71481BD2ED4DC6D168D2EB75FD904E84A67F07D1FA5A40DBDA51BE4FEB4CCBAD
      A368ACA6FD30D24A4FFC68AABBD381C6EA8CA64AA9CE28E8EBDE800E5EE08F26
      BA3B1EF5433A9C119DE0E964A8066ADC1B76683874783A93117D2F7D878F031C
      0C3B6157F56999C27EB7EBABE160E28FFA9DE9B0DBA35D882693703AC0BB7A4A
      0F7AA341D8A51DEE843D1AD030F4FB8351AF3718476A3CED8EBBC3281CD3C99B
      60689AD68C6E463F1A764774B1C6FD314D454F223509A65144A786D62808A67A
      10055DFA7CD40BF470409B32A22B331D0C8211BD34A211A82EDDAB48F7877D9F
      04AB9A8C864A8583AE0E3BFED0A713178EA250F6E64B7676E48FA7D351773431
      1263A29C24E1FF91E4A06F202931EC45F2F3FA5AF537FC3C08E9019AFE7F4C72
      A567A50A4D2618841DDAFB1EA40AEDE93854DDF178DA2169409BE1D3311D0C47
      74E9035F69DF8F686483FE34E8AA4197E40BADE834A2734D3750F727FDFE38D0
      219D63BA32FEFA1ACD877EA08D0C3AE34E3851A321891C3D99E0508F49DEA831
      EDDB2454834937A08D0A4681A66776E982E9E978D2A515F70713BA68613498D2
      B1EC0F696C242AE80CD2C908FD6118F63AE1C81F92A81AF6BA9AF6220C879AEE
      EF800E0A893A1AC17838D613DA4D12DE74CAE8459A086D68A7D79FFC23EB3FD0
      DD68D009C77CB2F192DFE51DE88EEE5B7FF9797DADFCADDFB56BAE039228D104
      B765D41DF81A07A91F75266148C2CDF7477A40DFE6FB41D09D8E34BD7FEAD34C
      07C160A0076AA247740746B467E3118932BA9D6392AC34A701AE4A2FE8D27FC3
      3EBDBD4F12318CE81CD03D51D0EC9AEE7044CBE5D365184D87FD802E63D8A1CF
      F687D32909F4601C86A4027A24EB7A74FBBA4392AE3AA2674C4986852455A220
      1C4CA6631585412752D3F17032A03DA745A3D33D9D8E7BBA3FA52B3C54741DBB
      FEB43FA29DA50946B88D634557588D48E174033A4DFDC160389D0CA6384D3D92
      B6349C30EC44FDC89F4C82F1683C213DD11F0513DAEF292474478DBAE1B8D3D7
      A1DF23393DA56FE804AA4FEBD49BD2F27526919E92B8A1C1D0A1EC69DD1F4DC7
      DD2EBD6344CBDAA57310F646BD90FEA65430EC76488F92AC20A93598F420B7A6
      2436BAB85E7EAF43479424176D0A69B78EC263E8A60F021265C1681C6AD26E23
      BF4BAB490A44F748850C06A40E2763BA0FA4C569E0FDD1289C4E46A47627BA43
      62ACAFFD718F74E344757B1D3D8EFA031D0E47433A4A3AD03DE8A95E2F24D53E
      210D1946A39E22C13B1D8E8388E415A97A529B117D1D9D1788CD88C4ED9464A2
      A68B380D87642C909AA315A44F0674D4699BC2912251A122CCA9D31F74151D08
      35ECF7C835F25510D1B5998EC7FDBE220B84CE4BD45574A4E9204DC982A03BD6
      EFF991EE61458221E9AC683282CA9E0E68CB7DFA2BA9051D44E331ED2129AE81
      4F82594563325D3A74B1C85CA0D9D04EE0F80443325DE896938E241532A6959D
      9285427F2051D89B4CA61D0D0532D1C3B10AA34940F7578FA69DCE14F27D40FB
      1FF4E9E324E7E950D1524E86931E69A7091D277F40CA6844078C8EF688F68B04
      4830D674F9E9120EA6B414A4F07B64E444239C221204C34E30EC6B451AA03B59
      5FEBF66924116D272DAC4FD76BA286B033B029533DED4F49154CE8F1D1704C27
      AA472B4EE29B741F49EB49AF3B26E180634D77AD1BD12AD1228D20F0E914D318
      3AD88F5E67140D75442B47328C9640FB9A34CF8476633026D517ACAFF503A867
      52BEA4FCC3011D66925F13B2D3D474A4A22129141A7BA4E9B229358DE8984474
      0749B446F461524103B20CA340D34D19D361097D7C64AA265D12B4BD21F4243D
      340A753089BAF425FC5B9FEC20FA871417298B21DD05BA3CA477C914A58B403B
      D31B86011D82902E48174620AD5467321ED0BA9304A631872499492FD03927F3
      8E74272DC280746D109039D021A53EA4B78D7C4CB4D31D7461B5D27126D54A32
      B3435611A96418A4210D8BECAE8884159D834940F650D02543939E4D428504E8
      2420413F9AF813B2387CDA6E32B2682C64DE4DE860D3F049E17687A425C27040
      6B4766EF804C82A8479787A418C9A80E99C653122AC3205264048E48FAC0829B
      68321F278A1E14F4483175C9160B06240F267E87EC527F42D2794C0AA6D75164
      E5F6C81A0A7AA459E83D23FA0C6D27A97A1A5D4073574345D6413825D1439BDF
      231BBC4B430B489E7649EE4D48530EBBD33EF4929A9072190F7A831042744277
      900CD83E9D8F8064354D22EC4F4926C2CC2509D19B28FA2E12A8633C7810F4C8
      682105497FA58BA83A53DA0ADA753AF374BAC6B44AD33E8D6D40F65B7F4247AD
      A72044E9D0917C23438BCCDF613819F4155D78D2226147D33B69CE24B47A24B1
      C802257547A632296AB20FBA111C06329C34EE331F775C1DB264E8FFE9BCD398
      494190C80BC91AE88CC93A0D07218D339CF4E8660EA691D2304C06249D8643F2
      0E7C529564C5D2C9E8938DA815A4D988841D597324A8C97C23337CDAE96A7A1E
      B9BA74176885BA8AF4B24F9B44B6234947FA91643049B8880430C9B2211D87C1
      906EE500578D7403DD9950D3890F4651D057B48D3E9D73DDEB93C88A48DFD0E9
      A061D3E0E99686FE68E8F7E96E90C8D39A2E4C6F14D2D58AE079E0D0443402AD
      3BF41BD9CD249C45FA92EC2601AD8734095287A4B3A2694476110D681CD0B3BB
      246C7A3E3D8FEECE408DC6B4671DD2795332D7A110C82824D1D5F175478DC979
      E88FBA64BD87E4F9D0B921E145B78D9E1BF5BA7DBA009DF1882412ED9D4FD29A
      CEF194D40CED2E5DDB3EDE496F25514403A5278E227281E9EA28FA36728568FF
      42A5A72392E0A47BA7E4D191F820C72B22E7C787D626814106175D40528F746E
      873E9CA6319926D31E4D8EAC50BA29E3CE80F43769A6D09F92ED438BD3A70B34
      E804B09EE832918C250B99D4084927F264E8C6935E22214F47B1436603AD3C7D
      BB4F27361C924D84A34A2297040C7959F026E13A91253326E7724A965C9764BE
      1AD2BC691E5368243F0C02B2CC030DAF8D4C1D327846A3CE4891FBDD81194082
      7B08A3946C22D2C9A443490028D2ED74DF877D32D187743FE942D2F127AB8886
      4C86C6880EE060D01991753A24BD435E2819DB9390368EFC46FAEB9014138979
      52E5A44EE9AE9126A7C7F487348288BC58328EE99DE4D94D14594934435A295A
      3C1A3E9902B420CAA7B1E15324064764438DE9EBE84092AC274DA0156D679794
      02BC8131DDAA80C4F4604497558FA2681291BE2137977E237D4A1E0DAD2EAD5E
      6FDA57648887F01BE954906D14B0402663875699DC44929903325515EE666F88
      DB134CE8228DC836E8D35691BED1E402D1DED04B7A44778A0C39924BC371D857
      1092E4D8918733C6B151537AEC84D408ACEB31D9E3741C49DE8EC9791FC3C6A0
      5D80474BA2061A906E7F8F1C66456322ADD1EF0EE8B99AEC8FDE94C4EA888C15
      52E0248CC9C8A1EB4DCE19199413DA2B5AE269D41B07E4FC0C482F77BBD3B043
      8B0E5797D4198D0573D643D2B32452A6C380168A4C0D5AEE4ED0A1119014E94D
      C91CA56DEE0E07FD0179F2E463D316D1BE904D360A146C34F2C942BAE764EBD1
      4983774E223F249584751F906B477EC6B4DF275FC0277DA77A74B4C83B212145
      C2DDEF76C860211D3F245114D23EF863BA1A8850D0920DC86B0B61BD74482C4F
      23F28C8624ED6864245354D7276F95EC06C8878E1FFCFFED5D4D93DBB811BDBB
      CAFF618EC9215522088062F9B4E38FF2566CAFB3E324975C2892F22896C489A4
      D9EC54CAFF3DAF418A1248024263261F5B36B76CAFA86E10DD78DD780D8AA000
      579262011288D9AACA32D0652467D4BCC83818B29C967088AD2C3224C804F0C5
      4C8379C6AC8CA02281FF5149A1228471184B74644986134FC4253181A0AED4D5
      1CDC15D5928434F88D0069C0086889823629E11EE440B06470882C43FEC0098D
      B107BD2951A52AE0172519267E8C0BA21CF36B4DDD048F431192647969ECAF16
      988F68610B3EA8688AAB804424E112D91C2501B204108B9E96C90CF5CE62B684
      E122CF909BD39A4A40625198DDAA1A010CCA41B1869A17E448E79806811DC41F
      18DBA2562813415B69D181DC9D13B46B646F0C1B6A270A1AD43D95A41E000730
      506362C088154B8C050805680F581A92309C9F5745A19635524F5AA0E50CF145
      75355084021F2EC7AC50803369F230C64821712C9097328428CA789C43920186
      8106D84F930C60094069A4D912440A1C187523780D6658E881F2605A420FE0C3
      D06A7186A495CF72EA6D5BA52FDA4A5364FE6AF1B43A83B9F162E56EAFDF981A
      9E58090203112D325A2E596A64904541150FF054CDE71042E850A154CB148521
      1548288B13D42215CA44AA68E6A0574865C807759E83DC2EF20C1C3007394350
      55351213621968C06C040170FB1C3506E6A939582738200A71CC00F3BCCA534C
      050BB8668E04A0915FEB2A0185C951F08AB9A4824CA2F4C1D552D0F00C412730
      A1828283A38095CB253812020A05660136854A470A51A405683C6AB74585C90B
      8508A216B98D96E54077C15381628D01C0FC8E592441F7154A0A5AB5811BC0C3
      E6B9063E314DA2FEC20083AE22958032528E2A68F9A1449881CC1514E9B244C5
      A20027201CB4A71D396BF431B78B8A1EC7E4AFF8FA8EF3D560B034E77AF0A53E
      D06AA06F2D70EA4867AD8C8DC413D22E5DF3D23AD5D4815011BEA8385F43998E
      844BBDBAB47A3375604EEA7B855198E8D7D4CACEA59E5CCA0C933D41F8FAFC73
      BEA61B9E334C4FD5ECE401D5FE51DDAA5859CE8AE3575F9F3FA39B1D65B36E76
      FB926E796CBA9D8150552EBB9691A7E94A598AD40AF4A2A612E417947F025531
      025813AA25BE456949DF2A4CF71255673A2709D4FBD2F498FE2EA905F8155259
      4EA8475BA0F5E09D05DD59401A40AECE503E5015034E316BFB805849F11DD573
      28003289FF6660584B418B1469E719C43C8AA36566FAD4E9694D3EA4EF64F7AD
      A04C813A4BE05CD6F6D958092297224A501A2E495EE714A1C64268A4ED95416B
      6039D92441ADDA73522FDA73464EF472A29713BD9C3987B6A9CFE67E50D78675
      E62463D049E7C4486ADC523A9249473272242347326A24A346327A24A38DCC1C
      1E278F2EDA713A7E32DF612474296D89C139C8010B1D26E98721DBC3FEF0B0AE
      F77F5BEFABFD61B5297E4D334D1FD64DF9A5AEAA7A39335FD59B557B27F278A6
      BD4949BF023F9EF947FB13D1E3C7BBDDAAD9AD0E0FF89CE7FF3A35D9BE7EF1EA
      4C23B93A979F5D9D6467571FCCD6BF2F9CD2B9257D5BB73F76485E3C7F6677BB
      D53A753A717760BA49F1E2891B4C9FBA41F9F446ABA7EEA37EEA06B3A7377AFE
      D47DCC831A3C6AAD1062BF0623D8D60A03A9AD1386435B4746E8A8288BC20063
      EB64113A61836EEBE481161DD191DAF038342586F9910D848DB8A781F4F14684
      A1C1D340589AF134A01F6F4418683C0D8421C8D3002F4DB413E3D58F5BDAAC84
      195ACBA6396C9B43FB2B7BD6558B2DF4BA2D48B9BA940EEB1D4B853A0A9598C4
      D125DFF85C9E2AABD5B230BFC06275BF7DCD7BB3BC5AAE3EDFEFEA3DD3907AFB
      4BBD6EEEFA4D1959D7EE9577F5E17EC7EB778F8FFE899A58909C1AE0996E1EF0
      68F700605DFAAEF81CA5075EFB08838FDA26247886F61029EE0FB784BB55CD1B
      E74D51EE1A1E2A9B82151D47BD77AB3DD73A52B9BABE5FAF6B5EAA307A1FF8C3
      68F47824C8A8844E8296128F041995B0896EC27B3146759A51B675BA1126769A
      1196B6E31D6369A7196569A71B6169A7A9DCC56962D7B29F5687352FB1BC5C37
      F49C3BD3AE9BD5E76D417B5CB31889DDC6ABEE35D3F440CCE75D71777BF5A6D9
      F282F8BAA91EAE3E715942AF15476DCCC8D02EEAABED3DCFD796660C0A7B5D5E
      4565EB8616F1D3DABCA87BDFBD22EDED89984DC37800AFFBC5818DE49B627DDF
      7202A681AF8A03EF4A2700BD31DBAA74307A7C134C4C7C2046F0B69B6779369F
      AECFBBE4498F07C161CC455FB653E726E26BFA1F7EAA78FB40DB90ADB65F585A
      6F1ADA0BB1AE6CED49E00B6163F8401B2274B64D2BD809FFF5E6EEB6D8AF7884
      EEF86CCDD5FBE28EA5F8919E3FE37BF1F51F36F45AD0D3A4C11BBBB79FDEBFBB
      FAD4DC1187A5FDEC782348CAD7F4D8F3264ABF2B827FF7D77AF17BFE857F0073
      DE3E6C620CFE21A222338A2F57CC74D66A355584D6AB7E13F21813FF583F2C9A
      6257F1AFFB115594098E431DA17D53D013B67C3D7A86F79F0842F67A81D1FE4B
      B15B5129165BE8EEEF177FAF4B5EE47D68DA9A8AA3F353FBE8643BEF7317892D
      655E8EB75479B3CBA7763BE5150D6BE082E7A4AA605A6B29C774F9A5D9C22574
      91765A97E7655B973B8DDADABC8AA6D3A5BBD4F47E9D28938FCA51361F95238D
      6ED6F79BED3EB6DF4637B2DB46370A5E9D2E97F2DBDA3CCADFEAD2766951AE32
      8A317E328A71436B5463C06C14A3DDC3BBF174A6187A477242957713AA55EC26
      8248C598B18C5A313B538D19CB88D5B333C598B1348A7163695463C6327DD5BD
      D63B2E919DA9C78CEB997A6C12DE1EEACD5DB32B760F11D77FBDAE3F17CC4ABD
      D5FCB86B96B4E118ED3E16C32FEE1707434DA2F845AB1CE370542D51E34C7ACC
      0A9DF6FF6FBAE2B0B5D27123F2948D262F70566B96F56DB3A65DCAFA8A737AF1
      6848796FEE8AF278EBE128A4EDBAF99DD934ECE6F6748FA2174C26047B12DD4B
      89092963936DBB4E2DB9F775B5BADF1CAFDB0D4D2F2B7DB2C2965553B26799BA
      17D44EC1418BD994E0D93CDE0BCE9D8262687DEE144DAD36337B745E15BB2F63
      9F67F6C8F47C6E6A1433312D3B6E349D16ECF1190220D4F925ADA72443FB5D58
      3A290481CA21EEC79643C90F328792076D43DB5DF1FC73FDCB6A7FBCBD3D7D3B
      5C0ECCDF9FDD1CF02CA1D920FBD37DD3AD7F4C5FC41EC61F319F6CF7F5995648
      E038C7DB13430ECF7A82C9A1E189A9690D577039A4FD51E632DD17708E0B7922
      CF617A40088AB064EE10BF1480A304171682222604C313BE432300C0237B0200
      2CD800166C000B1680450C8087A6870058B0012CD8004E79004E79004EE3009C
      C60038650338650378644F0080533680533680C3E88D433A0CC043D343009CB2
      019CB2012C7900963C00CB3800CB18004B3680251BC0237B02002CD900966C00
      4B1680650C8087A6870058B2012CD900563C002B1E80551C80550C80151BC08A
      0DE0913D0100566C002B3680150BC02A06C043D34300ACD800566C006B1E8035
      0FC03A0EC03A06C09A0D60CD06F0C89E00006B3680351BC09A05601D03E0A1E9
      2100D66C006BCFD29DED876EA5D3FA51CB74CD6FDB77ACE27B45CF0F68D264EA
      923F5BBFCA9E561493D70CD1B49D74DD345F18BFD4EC5BB17179BD5AAC578D59
      1B7978CC136AC3D5D99F5EF63F293B1793A3D559FA259059CAB58B74299C8276
      312453A7A04D3AA5740A0E2984544E513B8D4A3B9C0C5C8FB75690F06C59ED92
      4DA6A43397F4C0FCB94B6E607DEE921B1AAF9C3629932FAC6655E212D67D14DB
      0AC2A5904D2B5C74DBF4228FC77FAEB5278F2B1DD770FB745AE1926B1D5A013E
      76D914E26E8771A17E175CBF0703D8B5C612E07711E57711ED77C106B9D3B850
      BFA75CBFA75CBF076710D75A42A8DFD368BFA7D17E4FE3D03E9A2A2EFB5D72FD
      2EB97E9751681F257E86DF65B4DF659CDF1517EDC3AA2AC0EF8AEB7715E57715
      8DF6A14D1CBFAB38BF6BAEDF3517EDC3EA21C0EF3ACAEF3ADAEF3A1AED23E36C
      BF9B8A2898049E497BE7D033396F0A3F93F3669033B98E027A13C7997818093C
      5308238163B70591C073FF3914DC8E74B246B74F8348E0C8B9412470D2C70ECD
      00673B8D0BF5BB97044EF93D18C00E85CB5E1F12AB50BF7B49A0D7EF5E12E8F5
      BB8843FB906F05F8DD4B02A7FC1E9C411C942CD0EB23EAC8F0BB97047AFDEE25
      816EBF4B2EDA47ACF1B2DFBD2470CAEFBC14EED062787D441F197EF79240B7DF
      BD2470CAEF8A8BF6116BBCEC772F0974FADD4B02BD7E57D1681F1917EA772F09
      9CF2BB97044EF95D73D13E2456A17EF79240AFDFBD24D0EB77DEAFBADF4385FF
      24DCCD86DE4716F7A0E9DB627F7B28787B6CFC79BBABF7CD9ADE7178EC30BFBB
      EFA8A75FCD3BB6E8F55AFB03BD107296985D2AE92D4BA2DB3FB3DB5B53D28B7A
      CC5E8EA910B54A65A2E66A2E2B592ADAEF32D1B2DD0533D5B423E5E4A1DB96AB
      59B94C927A56248B2429EAC4BD2F677BA4F4E60934B9AC974BB34FA76B4FD164
      F0EFE00BD25FF6FBC58E3FF7E7FF8307ED83FEED1EDFADFF768F09EBABEEDFFA
      BFDB93FFC5F17DECBFDDE3BBF5FE438169E865FB279333433C245888AEDBCF19
      4E64F92596107F983DCA957BDE9F95BAA8F2F93C17CBA4A2D78A68859ECA59AE
      53A1925AB9DA15B3A27CFE4CD5F4DECA9CF6CB4F5C8CE3FFE5707A20F2008BFC
      8D1D4FE981DF9EF5743C950722ACEF6A8FE3F1F5EBBF016541FF06}
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
