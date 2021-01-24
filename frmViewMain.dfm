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
      789CECBD7B73DB46B62FFABFAAF41D509C734FA4194906C077F69E3925EB91F8
      8E6D792C3939E746A95320D1243102010600257152F9EE773DBA1B004548B22C
      9382D3B3772C8A021A58AB57AFFEF57AFE7E996423E7D2F3C528F4A2B163BBED
      4B2F4A03FA67381B3B6EDBBD9C0FF98A51D369DBDD4BFC645FA6593A19F983E1
      04BFECF0AF615CFA7512947E1D04FA7E7C56D3EE39EAF348D06FD9444C85FE9B
      FE6D24ECFC97616AFF7E398AA32C1B84F0C1BE8471FDC0BA1C25F1D48B2E47C3
      8997A42283EF67C96FEEEF977FBD9C79519C0ACB76E1FF3A76D36EDB2DF8CF85
      4FAD3F2E82A948ADF7E2C6FA88B7FFD71F30A4AB879CC6BE4896C774CA637661
      9C3E8D8D63B660CCA3789E0422C151FFEB8FED2D18B159F192EEDD976CC3FFC1
      2CC07F5D78591CB4FBC7F9623A88437A3727A7370AC2FB07BAF3BF3F7E0EA2B1
      0FFFA53456B3F539BC439E31EF90872ED2E94D0749E059EFBC6CA208EDEA21D3
      9B204DEF1F72442C736970356418C098F47AADE6E78C3590ECE7FF6072FF3817
      E358589FDEF060ADCF9AD40110D92FBF591CA571E8A592D01018F6EF38B9A425
      F11564D01F14C6779E797CA26012149EE07EDEB435574F9BF536184F327AFF41
      71F42AF1FFA2F787190822F584CF92E447CF403E7EFB2BCD40FE84CEF32D9C41
      71DCEE57D08FFD2A81749B3D1ED65ABACF3A3A9144BB7DB7EA669CC5D5372F12
      F9E0AA79763A4EC5BD3F24425CC9BBAB66D1E9B815775FCCD5933B55F776BB15
      F7EEFC280689B8D9D584574D85D3ADE2DACE61E20D82E1AE7C875ED500BD4EC5
      00AFBD300B86F2F67E25F9CDAAE7FF14882CF2E04BC1EFD0749C2A3DAAE6DEB1
      0AFB5F3EEF4DA7725B5513BF74A79CF4A653A9BAD5AC976FCC671CE4BFFA5677
      C5AD6ABA9B4EA7F24639DFE51B97E6BAE974ABEF5FC5A6D244379D5EE5DD72A6
      CB771766B9E9F4AB496EAE7AF2F214779A0FAFEEE2CE9F4F71A7F9F0D22EDF29
      A7B8538944F2755DBA319FE24EF3E1455DBA554D71A7F9F06A2ADDA8982C497D
      783195EEBECBE68E53A1F18B6CE66D15394CB7546DD345FECA5B146B3BAD8A7B
      8AACE57B245799C04EBBF23E77E93ECDD24ED526962B49754FBE60E8C62AD898
      AB467D6371A5743ABDAA1B0B93C83796E7AFD3AF24AFB9FCC4E5A9EBBA0F4F9D
      029F6AEEBAEEC37397DF2327AFEB3E3C79FAA6E2EC75DD87674FDFA8A6AFEB3E
      3C7DFAA6D2FC75DD87E72FBFB338815DF7E109D4779666B0EB3E3C83F933EF4C
      61F351FB18437E3D87CD476D61EA263589CD47ED5FF2AED22C361FB57DC93BF5
      34361FB57BC8BB0A5B47B7F9A8AD43DE7887A5A51351956E7D04402C8D53A565
      1FC68AC5619CAA1DED31B0B13450D506F70082BC43985375247A0C9C5C1EAB72
      F37C1CAE2C8D55B99B3E0831EFD25809991F8F378BC760E76942B53CCA13458A
      C82B0EE47E895095067AA2502D0FF325227597BA2F14AAD2584F17AAE591BE54
      A4EE583E2AF79FBB288C8C1B4AA44A6354ED447761991C43EAA8E220CD2A4C71
      17A7F120C59DA2345015D0B80BDC7820254CA541AA6C6F77911C0F52D24EA591
      2A21CC1D682747D2627497B44A547307EDF15805312A8D530974EE803FF94ECB
      7AA968DEAA3C483C62B32B8DF3F4CDAE384CEB4BF45269A02FD9EC4A037DE166
      571AEB0BF55269AC2FDCEC4A633DC36657B468B69EBCD99546F992CDAE3850FB
      0B11543ED0D337BBD2305FBCD99546FB7204958FF5459B5D69A467D9EC8A66EC
      F69720A87C94A7EBA9E2309D278BD41DBA3A4F17AAD2305FA8A74A637D8948DD
      25F04B11543ED233E8A9A2DFA2D200B3DA8A75C7EF516987A93669156FEF3E1E
      35E5FAA834C0E3D152BEB99506783C525AC648F9188FC74825BD531AE3F1D8A8
      B48995C6783C2E5A8588F2719EAC674AA37CC9E6551CA8F78588281FE8E97AA6
      34CC176F5EA5D1BE1C11E5637D919E298DF4A57A86081DC6619C6483F0BF2E13
      E1DB97639895C8BE1C847361DFFDCA6DB78B5FC2AFF77DCD03E06F2B8658FA7A
      E9DA8A212A1EC843386EAFF825FC7ADFD7F67F6D6FE1D7F8FB8A4196BEB6CB5F
      E683ACFC5A0FD277E51FE003FDA1EF3E8ACF364EF65F317267389959DA7B9DBA
      EEA50EDDE1A81DC78673247F8C66F88BA5EE9C79330B48FC2DB42EC3C0BE4CE0
      BFD4733AF06FE802BE48C3E93CCC9CCB9BC01F66E1CC4B2E6F126F06F779F0F5
      A597CEBC7036F1F043349F5E8E3C6F9EC5979EFFEF799A2578608301E16543FC
      27C8BC996DFD7119C5BF81D8C5D33813D6EF9769B608453A1122FB7D7D2F7199
      64E170022B217590784FFAE73D629DA7C2AFE065B2842FB31FE6EE709C043E7D
      11CD0A7F93ECBE4C23719BC130E96FA338997A197C9A25419C04D9C2B6DEE357
      1856042F933A653E0C1C9BB881FF0E9032077EE39F9FC58F789E01074428AE45
      683F9A3B97DE00D862236BE02054C19AC125FD75892BF4F14A2451005F77AAF9
      83BFE02C0075A9F0E3C896CC8287A7F056574E7B25D7FA16CA4E92063E0ED0EE
      F7AD89F030A4CA727059A4EED767A3F31436022B723602D9CB8C84BFAF62E4FD
      ECBBC33C5731AFF399CC73A51436BF3EFBDCA7B0CFEDDE2785F0D7CF67DE0AD9
      6B2AF6753F937D4D56C9F0D23094E7FB41165C0BB83A15D36012F8BE88E09779
      041FC51C9E5818D3B18E9975D6072FF1C6C0CA89751A4714C4F55778C52C751C
      F827896FFCCB2C1965E9CF819F4D5E37E197193C2874EC9EFC98E41F47A1FAFB
      28D39F06FA53829F86839907CA153E8CF8C30028878D867F668B9980ABD26B91
      640030E0D320F113F533943F07F267227FFAE3507F52DF4DE4CF6BEB21450FD4
      7E1555BF3E45EF38F7CC396B7BEBC21B84428B4BBB202E08392A54F01D91B773
      DD6BAF56BCAB1505CA278B38FE8C87572561BC2BE03F2AE56A1D017CD4AFDD29
      4A7995C22BBD3410275F5BBE5BE9B51F7859F7F35ED62DBF6CF7E19775BB2B39
      2CF54AF5AB1674887ED9E6E7BD6C53BF6CEAF4BE8EF6FD8C85C2DC68552C1220
      97FEFA0C3B95D32B41A165EE4CD33852E88867B15F398B23BB3C79F3F0723872
      97C4A85A132F4D0B28BE04A7513DD8B5EF59A22B1FED3CF5D9A77118C637C2BF
      FB0E4E35F12ECDD8D27B60083D7DF9341E5CBC7B6B1DC5BE90A0C0FD4AA0EAD9
      E4F2A952B90202B8EE67304AAAF49D9FC56097D167193F696EE0467EDB773AF0
      AFD36BBAF0C3ED82FACE6E9B181F96DDB6DA3DD8796FDBAD3E5ED269397849B7
      E9E2253DB7D5E2BBF112607A9786B1FB7DBCC871FAB8EDDFC2A9D2C5CB9C66B7
      45D7B53AEDCE334F8214B57B94038BDDB3205985C5DCD6E74AEE87443074CB84
      AF5750EB692BE809FADF2D6D00A5377FE0654BDB96DBAE7CE3E0AEE2099696FA
      5DF0EADE55B2275310873448F523ABB7F5A5E72DD35DADC867E17EAEC6AA77E2
      657A1E3FFA508FDEBB7F9F5FDAE11F66987BE771E759124763691BFB2BAC9434
      CB10CEFD4E1FF977319D855E26027FBFDBB75B3DFC87FF4C879F4BFA371A0D41
      53A88F91FAFCEFA1AD3E44F2D388B604F94B9A7980C601ABF36F336F28E45F00
      B18B28B37FE7DF32583F97DFD9CEE57CBFD9779AD6FF4216F1D3E6D3814860C2
      29250AE57B3408BCD4BE9C2402FE1D4EE827487FB0DFECA02AE8BA36CCF5BF87
      9254D44A2EA908F881C6A4E726EC1A5E3E828F30878FA5325E459DFB28EA9C16
      E8CA2271F4053C077F5A34CB2F80409A46B7BF7A1A1DFB5194BAB87B1429A52F
      E081F8B36A22D14C513F4A7BBD254AF10BA4147E7E96C82AF25F2AA5F06F9952
      FA021E883F9F63712A066C9CD256D32D534A5FC003F1E7F3AB21A47B439462EA
      578952FA021E883FBFB2C2D5D3BD1E4ABB4B1A89BE404ABBD51AE92BE82345F5
      D7A3B4D35AD248F4053C107F2A4AD1EF66C1A0F839F0DBED7EA7E776FE580D2C
      5CBBE73A7DB7DBB4BFC61A5F27B6D83CB2B87FFABF1EB6D838B200C237892DEA
      49E9B3618B974EE957C7162F86D235638B0D52BA496CB1664A5F08B6F8FA943E
      015BF47ADD6ECF6D57608B7ED76D01B668B95FD368F108CCF50D408BFB67FF1B
      86160F08371A8ABF1168F18C94BE7068F17C94BE7468F17C94BE7468F17C94BE
      7468F18C94BE7068F17C943E015A384EAFDDE9BBED0AC305E8EC76B3DF7D06AB
      4535B47804E4FA86A14505B028B8660DB430D0C2408BDA536AA0858116F5A5F4
      29D0A2DD69F75CBB5D61B7E877DA6EDB6D6D24D4C2400B032D0CB430D0E21BA1
      D4400B032DEA4BE953A045CF757B4EABDD5F0D2D3AFD7EBB0FC8E3AB7A440CB6
      30D8C2600B832D0CB6F8462835D8C2600BC416184AE1769AAD8A700B07E4BED5
      EBDB1D63B930E862F3126ED0854117F5A5D4A00B832EEA4BE993D045AFDB6B76
      9C5E15BAE8775B003F5ACD8E4117065D6C5CC20DBA30E8A2BE941A7461D0457D
      297D02BA709D56AFDFEDB5AAA2395D78AB56BFEF98784E032E362FE0065C1870
      515F4A0DB830E0A2BE943E015C349D5EA7EDB67A958E114C43EDF7E002832E0C
      BAD8B8841B7461D0457D2935E8C2A08BFA52FA1474D16E021B5CB75961BA68BA
      7DB76377FAC62F62C0C5E605DC800B032EEA4BA90117065CD497D2A7808B8EDD
      EA369BAD6E85E9A2E3F65AED6EBFDF33E0C2808B8D0BB80117065CD49752032E
      0CB8A82FA54F02176EBBDDEF772AC08563BB6EB7D3EB1BCB8501172F40C00DB8
      30E0A2BE941A7061C0457D297D02B86835FB9D96E3B42BF2453A6DF893EBD82B
      033AED9C49F6E7F2E891C8C285FFEC8365A620C780827BDBC53D17CEF812229F
      52051C29769E95E227608F4D10ED3E2BD14F80219B20BAF9BC447F3E22D904D1
      AD6725FA09E0641344B79F95E827E0944D10DD7956A29F0059364174F77989FE
      7CF4B209A27BCF4AF453804C1BFB27F7BA5589AFED7EBB6B379DFE33048F9A06
      69F751F90D7731310DD24C83B4FA5A494C8334D320ADBE56928D36486B3BBD6E
      B3DD6C55941A777A4DD8A0BADDD6B3E7BD7E6603DE3A818BC74EF9378C278CD7
      C5785DEA8B278CD7C5785DEA8B2736EA7569035A68B53B55A9AED8CDBDD5EF77
      BB265ED484746C5EC00DB830E0A2BE941A7061C0457D297D0AB868B77A2D000F
      1599AE803DEC66CF714D8D2E832D362FDF065B186C515F4A0DB630D8A2BE943E
      055B74ED56D376DC0AC385D36EBADD4EDFE9985C14032E362FE0065C1870515F
      4A0DB830E0A2BE943E055CF45DDB69761CBB025CB89D8EDD6E759E3FCAC2800B
      032E0CB830E0C2800B032EEA4CA90117F7818B7EBBD9EAB7DC8AFC10D76E3AED
      56BF6B7ABA1B70B1790137E0C2808BFA526AC0850117F5A5F409E0A2035AB9D3
      B29B557DD15A5DB7EBB6FB1D032E0CB8D8BC801B7061C0457D2935E0C2808BFA
      52FA2470D1EFD85DD7AD483EDD77EC7EAFD9EDB5BBC62F62D0C5E625DCA00B83
      2EEA4BA94117065DD497D227A08BAEDD6D39DD66AB5F812E3A6EAFDDEFF79BA6
      E9AA01179B1770032E0CB8A82FA5065C1870515F4A9F022EBA5DDB6DBBBD0A70
      E1D88EDBEEB9AE6DD2450CB8D8BC801B7061C0457D2935E0C2808BFA52FA0470
      D16F765AAD4EC7AEB25CB81DD775FACD9E29A265C0C5E605DC800B032EEA4BA9
      0117065CD497D2A7808B5EB7DDEBB5ED8A5CD4FD9EEBB6BBADFE73B41331E0C2
      800B032E0CB830E0C2808B6F8752032EAAC18563BB9DAEDDB75DA7025DB43A4D
      A7DBEE9BFADF065DBC000937E8C2A08BFA526AD0854117F5A5F449E8029E6B77
      1CB7A2D485DB76DA9D4EBF634C17065C6C5EC00DB830E0A2BE941A7061C0457D
      297D12B8E8B8DD76C7B52BFAACB73A803EFA2D53E8C2608BCDCBB7C116065BD4
      9752832D0CB6A82FA54FC116002EFA6EB7D3A9C016FB8EE33A76AB0BF8C3C00B
      032F362EE2065E1878515F4A0DBC30F0A2BE943E095E3876BB6FF79B55319DFD
      5EBFD5765BA68E9641172F40C20DBA30E8A2BE941A7461D0457D297D12BAE838
      BD56DF6955C474B6BBFD4EB3DF774C48A701179B1770032E0CB8A82FA5065C18
      70515F4A9F022EDC56A7DDE937ED6E95E9C2B57B1DBBE798B88BE724CC000A03
      280CA03080E21BA2D4000A03280850B41DA7DD6FF7ABC2387BCD56ABDB31719C
      C65AF10204DC800B032EEA4BA90117065CD497D2A7818B5EDB81FFAFA8CCE9DA
      6EAFEDBAEDBE4117065D6C5EC20DBA30E8A2BE941A7461D0457D297D12BAE8F7
      5CD7B55B15CDD6B11F6ABFD3EE744D7D0B832E362FE1065D1874515F4A0DBA30
      E8A2BE943E0D5DF47BAD76AB551169E1B49BCD26200C539AD3A08B1720E1065D
      1874515F4A0DBA30E8A2BE943E055D34DB7DA7D376DBADD5E8A2D3818D1D1349
      0CB830E062E3026EC0850117F5A5D4800B032EEA4BE993C045B7D76C771CBB02
      5C34DBDD56A7DF33C5B30CB87801026EC0850117F5A5D4800B032EEA4BE953C0
      45CB69F79BED7E5506AAD3725BBD8E6D12460CB87801026EC0850117F5A5D480
      0B032EEA4BE953C045DBEEB976B3D3AE481869F65BDD3E600F032E0CB8D8BC80
      1B7061C0457D2935E0C2808BFA52FA2470E13A2DB70F08A3225FC46DB77ABD96
      DD3765BF0DBAD8BC841B7461D0457D2935E8C2A08BFA52FA2474D16CBB5DA75D
      D5B3CC71FB6DB7D36BDB26EAC2A08BCD4BB84117065DD49752832E0CBAA82FA5
      4F4217BD9EEB763BCDE66A74E1F6FAFD4EDF31960B53F5DBC00903270C9C3070
      C2C0090327AAE144BFD3B25DDBAE289DE5F47B4ED76DF59B26D0C2182B362FE1
      065D1874515F4A0DBA30E8A2BE943E055D74DC66BBE9D8CD7605BAE8B95DDBED
      B74C750B832E5E80841B7461D0457D2935E8C2A08BFA52FA1474D1ED38B6EB76
      3A55FDD59DB6D374BBAE0117065C6C5EC00DB830E0A2BE941A7061C0457D297D
      0AB8E8757B3DC769752B4A67B9B6DB69769BDD8E718C1874B1790937E8C2A08B
      FA526AD0854117F5A5F429E8A2EFF47AED8EEB54D4CEEAB73A7DBB65DAA11A70
      F11204DC800B032EEA4BA90117065CD497D227818B4EABD9B29B7645026AC776
      5B5DDB714CFEA901179B1770032E0CB8A82FA5065C1870515F4A9F082EDADD7E
      B7591174B1DFEBB76DB76B1BBF88C9403580C2000A03280CA03080C2008A7B00
      45CF753B802A2A3250F75DC7693A76C7710CA230F68ACD8BB88117065ED49752
      032F0CBCA82FA54F84179D5EA76B57D4CBDAEFF4ED2656EB34E0C2808B8D0BB8
      0117065CD49752032E0CB8A82FA54F0217FDA6DD6F3B9D8A30CEFDAEDB69767A
      AED332E8C2A08B8D4BB84117065DD49752832E0CBAA82FA54F43179DA6ED745A
      CD3FE0EF7FA56FE36B9124812F608C50FC5EFA4ADED5ECB8ED36DCD92DFD7118
      CF81B2CB3055611B4B77394EAFDDE9BBEDCEEABB5C2075F57DBA95DAEA1B9B15
      8F6B77DA3DD76EB757DFD5AAB8CB6DF7DAF0A24E7FF56DED8ADB74B2CDEADB3A
      554FEBF77BAD76ABD585695E7963B7E2469D3ABCFAB65ED56B2A4BD5EADBFAAB
      6F03F16A759BCD56D57CDB5533A01AEC56DCE7544E79B3DD773A6DB75D419EE3
      AE7E62BFD969B53A1DBBEA8115A2D26ABBDD560F585A715B85ACB45B76B7D5EE
      F4AA5EB24A569ADD5EB3DD71EC56D5A43B55E2A26BDD55DC57252DB60B73DEB7
      5DA7E2BE2A71715B1D58B24DBB6AE22BE425D72A154BDDAE9A78587A5D20B155
      41A05BA55A7489E18AFB2AE4258F34ABB8AF4260DA7DD7769A308515B755084C
      AB09CF739C76AF6AE2DD0A9169B75BBD56BFDBADE26795BCE828FD8AFB2AE4A5
      DBEDDA6EDBED552C23B74A5C7AAEDB735A55CBDDED572E77BBE376417B56BD67
      B342C180A4C026EEBA156C6956480B6C27BD7EB7D7AA10966695B0E8B61815F7
      556D442D104F506876A5926F562918106B50D8153755A91717A31D5CBB92BC4A
      61715BAEDB695668B36685AC349D1E28EA5695126CF62A275D97D6AAB8B34AB9
      80B4F4611A3A15C2D2AA10960E1C404149342BD8D2AA442D8E0D73074AB0E2BE
      4AD5A2624EAA66BD55252F4EC781D50E6253715F357401DDD26FF7AB1853A55C
      BA760BB4B55B3183AD2A79B101B2DA1DC7AD8065AD6ED5CCF77B5D584A6DBB8A
      A3D5E005364EE04DC56D15F202401536947EABE235DB15E20270A0DB732BF6A1
      7685B0740110385D785AD59CB72BA4A503AADAEEBA95CFABC4B8AA0F60C57D55
      A2A28D8A15F7B5F9389088EB6C105ABF7F8AAEA2F826FA2FFE76369ED1B7F8E1
      32807F5A9741E6CD703AEDCB04FE4B07F09FE7D24A54D7348125ABAE2A5E633F
      F90A7EDB34F0F1C5E8034056BBDFA58FB0FFC1BA40F1984EBD6CF221E19FA771
      9481B69B0E92ABD7019CE9E487F3398C394DA75E189E261E9CFAA67E90CE8EC5
      C8B99C86EFBC644CD726FA932F46FFEF10FE769378B33774BA23E3DE3488B2B7
      C1143E445EB2804FCEF616BC41108DE2DF2FBD79368913EB02FE49E1B0689D44
      E35024F0E77826122F5BF9A76122E04C39BD5C242E02B969EC5CFA0B58B493C4
      69E1D36813C109BBEF1A54E230D969104728C2C2872FE90015C5A399371669BB
      CFBFDCC4890F0816F03BFF3E9C7849DAB71DAA55A47EBF01E8DF8635C983468E
      949ADB6918A52C21F4D1B1265936FBFED5F6D6AB743811532F3D9806C3244EE3
      5176308CA7AFE2D128188A57F8CC5700E29AF4691AFEF1C7E5CC0386DC384E1F
      901D7D9E389D5EB3773905EE87CC67F894E84F99FE34A04FE379968904E4254B
      5231CC2C10C29BC08F6F8659125E8EB268F0EF4B4F44BE1F0F2F3398ECAB292C
      05385BD3E7519C8098644134062EC6519C093892FBE9221D81E038C0EA701147
      D7D3D02EFC150EDB63DFCB3C7872328251E1281F6530E0B51706F0BD007E3897
      E924BE9985DE504CE2D047130048F5388A13310D6E853F84D1D14400727D2D82
      88EEBCC5A7E06DF001962A88860393701BC2EBC50B110155E276964E922C82AF
      E7406C98CE86977E049310A5037F00DF921102489A03DD40583AF1401B8090FD
      0769F7C7531267F830A10B9D1E5035BE2E7C864B83311BACF12FA5DF26F86A0E
      DD801FE075FE0DEFE345FEE575206EAE82C877E8533AF442E180DE9F8D07899F
      4C84E7CB8FA338CE2ED359B8C86EA220123835FAF3249BC27A49674044184D32
      CFFF379075394F45980DBC30BA84FFE00B78C825DC024F18C26F37F40B7C48B2
      71721946B0B481720143C0A79B04F5D7651A79B32C1E83E20BA2A1084318288C
      6F4681086111FB30FC255C389B4743F4727869E0E95150A924F0C652B15C46E2
      06064CB305FC3585678C93F8065E391E0519BE6784FCCE16C07654B6F07778D7
      08B44D965E8E04BE9B08C5357C3DBC4D676474012DE1C314DEE0F702A7D41B0D
      6145E14B7B23BA780E62195E4EE80AE45B06BAD14BE0CA6C78ED11AB327859BC
      6994203FF08B6B2FBB1DDC5E5E25D12C4923915D0E3D588D206F21B0D142C109
      6031CEBCCC82D7CA6CDCBCFF7A7903723C9A66A320847564B92DD82E71F9832A
      9A27229B247196C1945E06E1289E7A432F1B86D17C8636972C8117B22E71D5F9
      965A7FA0B723716B5FE2CC8B64D105C08F332F3FC29BA4B7F801D81F4D4422E8
      6EBC0527096D5C349A187920E24398405AC0166D4911FC29BC86C5358BE6C364
      8A5FA0410E7F67931B3A9466D1C48BC6B87145D96DE65907723F9337BB30CF78
      3BBCEC93EE6FC227D8449F746F0B3E858F7FF26EF9EEF6E39F3CB076FEA81AA6
      430C78F46BDC375497067ADC44DC374EEFB95EA8FF981742995F39126C3E09E8
      AAD00B224BCAF6E56FB068721C826A2DF5E8DF01AE7D50F31EFF840D07A418EF
      408820C51714CACC0B67130F3F44F3E9E588AEBE8CE724F06403B62F41D7CDD3
      0C54ED2483C74464CC55100806F40AE806504F160E2797A321ECB7A0269A4EDB
      EEC2CF14F0B917027170D86AD3BBF34536EE857455E7922EC26B702CFA300235
      0DE7DC212E3CFA229A15FE16CDF0AFC0F5D22307F0341B9FD8EA959E7339B81C
      B5D00BDCEA5D02E593E527D1C72BC00FB077E2E94C3E82BE067452A0F1125147
      91E69F275EF65D6A81FEB560626E4FFC20B35A07F641EB7FA12483FEE1895BDF
      94399F3565550C6C7696274AB110F853C9C2CF61DCEBF978046023956CE24302
      79237241D73ABC2C58767972957FFF4BDFE8328C614C90DB4B7F401F609708F0
      294DEBF2BB41F71236C63F56CC662980E0D1D38A086529D8E011131DA6ABA717
      6F7FD404F3ECBAAD250ED2CCE2F1FB0B59F8976EAF67ED5BA7707C380340741D
      6C6FC5917514CF1696975AEA90975A232F08E15FB8ECDD0F27A7F51281BF74FB
      2ED21806B399F02DD4E020C6B8FAF194167A0B2B1E590318E82AB500805AE97C
      B0CFBFD68BCEEDADBFF4EC2650EA8D10780D43E1A17EDCB3D2782A48E1C11929
      F409A0C35C26F1D43A7E7B945A53E000603D2B8C3DDFCA2622482C8C158A412E
      175602277C38D659F06F82C86A512F9EFCA5E722474ECF9ADF5B87D1104E2470
      623D10E9D4FA9FD68718CFDB717C05DA98BE8A0488071CD2AFAC77B11F00AAF7
      2D6F360BF1A73F87953BB6FE7578B4BD55370EB470857F94F3781364130B8601
      0CEF035DB0F0A76F8E530B0F61B8E2514AD494C3C33300DDB83AB422781544FF
      0631107EFDD8D0264178FF13FCAB9686E5237DD338120B580529AE1A9178A9C0
      3531B3C602D64D96D44EE2DB6D20F1B0A4032C3F1C46F32B8F1400CAFA9E15C0
      1A2725F81EBEDFBF886F22203AB91299750DB7A493BA51DDE175DEFADE3AE62D
      F96C80926A91E5C2DA393E3D7BBD8B623E0F7D2DCED675E0598800E3E4CD71DD
      08EE3A40F0A7199A8878673EC70092216CDE6108840771945ABF00437EAD1D61
      28BF1727E72D8DCD9BB43FA199C3CA62D88A009DBCF3C640EBC96884732C955B
      BD08DDDEDA4904ECB2A04C2DC05CC7418A44EC02EDB040430B5E5F4429CDA21F
      47DF01F9E18DB7A0991E0ADAAB715D83CA3E397F9BEFCED6CD4444B8898356F3
      E7C0AF2025DEE145A3D01B8F51737F1B5CFA0545E457EBE4F8CD31C1B693F3A3
      13D067392BF83EAB71723BA32DCB6A5983052E96C11CD5C21CEEB11BCCB0641E
      919A6C1C4DC4F08A56D309D94C1BF8D0FA41DE1D266FB0801D0E8E98E8224096
      BD4780032B8865E84D045B44E485B4CC9064DA33CE610798003F4391A41B3A11
      7F9E11E3912685C289787D4685A6312A18A3C257302AB82FDBA8D069F5F1C881
      2F67CDBC4858D21730988FEB35D17FE9B45BB8D5208C02F15FDE1DBE977B4C6A
      91878DF7120FBE1CC3BE6DBDB26286A0482AE8D4D43A3F3A7B6B8908A6AD6E12
      BFBD05ACC049FD1949249F0F1D88E55971CF2249DC07591E5EE1F7B0C99C903B
      CF3A0C436B96001841A3836791ABF2369B7BA13515D11CA08A47FBCD3825D452
      B869846E34E0A3170659DDCE609D0EF2EAE8E4ED5B0BC8B3F76C32B20C8495CE
      E64910CF5380279EEFF36E5CB4CA483B833AB71DD48DEEAEAD97CBB137F5C680
      4309A80B02EA70AE0ED2D01B0838A1909D8DC5A77644A24E78C36E76EBCDC5BB
      54CDAE46AA000240010B6B48C604520B780EB5641C05CC73000C496A47780708
      FF6112A748E3C9F907B697BE8BFD7112CF67355369400E1AC60E87B0EED29F82
      38F450DBC06405706C1A8B08A36A682DC6D108D45A66A570BE9EA7E5B9AD17C9
      A8C5FB8E5CA1AF4ECFBA9D5FC9D68F6492B2C2381420109492877B361209DADE
      9BA770E284A94E87DE0CBE8B43A0167905D791D4EF8B080FE73E4B3A605FB6B3
      C0A9B55EFC01EEE0D2C688233C3C838AF2AE055BCAF993178473987A3C512702
      037FE8500A8A2C15BFCD6163878F244E75130C209C8C2E8B598CF2FDB3F066FF
      387E7FF8EE1F875130E575017F13DF5BAF3D8A061C5AFBFFC0CFFC4BDD68EDA1
      3BE802D0C6CCCB26D600DE6E8816414620A0A76F10DCA3661B7800F706F32C43
      951D8CE8EF3741E4C7376857C9E2D8A298BFDAD9C23B7D54E4C7F11C2D6A6F71
      0E4101C423AB712C30641056FBC96FF360665D0453D15002818690D89726B7DA
      11DC453CE64564479CCD007EA5C32498012299A7A4FD420F57ED9E75BE483F65
      41889FB2843E5900EC7FA649878BA320ABDBD2EEDAB8CD358E10524A2F47DAD0
      E8DAF26391A27991F59905E2AC2E42E83A0A1238BB80FEAF1BD10E12ED9132B6
      AE0B9B3BEC4F1842C9CE9F5064B523CC45847D93C4B862131F0ED5781C3D055D
      4D1AEB2D7E8005FBEED3F945ED2873A45A7E77F1FE9D45419548CAC7C3A31379
      CE44AD7B93041906399323731E4502A7183DD520B2D32062CC6693A5B7767AB9
      EBE2B1F1EDD9F10F78C886E58A8083294D049C1744846744796486C5FAFE1360
      3698FE799488340EAFC943F21AF5B7F4EBD68F034D97ECD437D6D13F2DD058D7
      402F11240500A900D08532CFCBD7B73E9E9C7E04752D5D7BA8E007825D993EBA
      47C83253433EA03B7388861132A73030995A01B9E34132A40BD347E705B34629
      F239B904F196ED2DE0570408466437022EE4006C2F244DA17DA0F30876391884
      421C6BC726C4EB647BB2522486D1D977A9624A1EC1C44EB4513C84231CEC04C3
      7902CB09DD44A908D93D348DEB6689E83611D61C4E07C1781E640BD496E7578B
      24980203FE053B00AC9151009005B6BEBA51D6AAA6ECC321E8861A5386C8E448
      ADEC43B9612F51076B995459BE98AD23BC720667D159CD56E9F6D65FBA6D442D
      5A83C94509D4C26FA4E4C84A860607A454EB298E3A0C22B2B5E0B55CE202EEE3
      9BC87C0ACA50DCCA334C50B3155CE5DBD6713BC789378EA3419C4414A1362408
      7F059B7CEC252821D1BE371E83EE4E83EB9A21D94AD2132F9D505CD2F6D6E14F
      EF644043127898D466097F4C310D3296813678FC0AF7B93D72ECA300B1985869
      16276C8CC52FE93A4695C0C6EF30DE31BE82056679165B7231E202FDE1D67B7C
      2E86069147026F7B0BC303F0427C552F2E57874FFC2492C5BFE6C1F0EA7C12DF
      1C491B275BB261792EC8C61972602805070E4592612A833287D6EC187C870DDB
      5B92113FEA60C81D46CDD67F5B3DDBDED571909EB4F87154845F08B601767098
      8D04E58C31089AA3E88CB16E8E8C2BF4D0F9C59FEBC5B86A09F27C0E41A2B007
      196EC4A1C7C001FCCB4C24A8F271995A8D23F2190AEB226E58B379C6C6B6E29D
      BC74F9644BA1C874BCAD17B3AA5855700F0FA5BD3D0A74D0391DF0D2AB806290
      EA4570B574F86C5D248F30FE29883231C68500678F11CC6F6601EE9E62AA6B8E
      7648D104D13E65BA82C2C6C04C69775DD03284374694EFA121AE6EC8AF8A51A0
      44B4C265A7D21EFAC909E058533ADA90BF617B4BA4F33053DB19B96706024529
      3FECCA85378FD05DA1A155BDF8542D52A5E3B0D4D5781A5687BD9C593256B280
      9EF3CBF1B7C611804D3FC133F1A86191F7926C0AA4C5EBE894AE62D93B56AE7C
      C6450BE83448076242761524586D5FA482E06F29CB13D97FEB6634B92F50B4FD
      EAFCFCE457EBF5D9D93F61E711DE7082849E7F38799B162D4794CE4D66B57A91
      0E6B6675C4E7853F3A61357BF016F6D453383E7E14693CC7F84FAD7665A0AC74
      7025EAEF8C9207826365EBC5900A7610E0B57E399C67F1AF167B4468CA53B542
      50B96C6F2D61B79D1B1C9F0E5EC830B8364AC5EE37C1100ED5D151D3794C8E74
      2EC066838101F5A2B57235A8E4A53BD01E81076D9C334A0B4CE219AC8E1BDC1D
      D4C6B1844AEAC5900A76C4C90C765460C78AED30255BC3F616077F1CA6A9C030
      4779185FC8103F953F096A63AA7049E45DC31502736BC48D897EBE77EEDE0511
      ECC1B544691B0F816EBEE810688CB422E37C21D2EAE2E2E435A66C7161AC15AE
      CDC6EB50C0323DA3824E00D61AF51289BF74BAFD32C53FBD397F4307BE0F47EF
      5EE77B0B9CF8E0A75FBBC3EE5FBA2E7A27D3F96814DC72C08417AA905DB474A0
      359B8FF7F5220C2DF44D47C381861251C76928B5DE38F6326FFF34F4C669A388
      12461C38A87386418A7F64B72485CD518E51004AEE488421851AD54CA88123CD
      57A7EF7FFAD542DA2D1BF981A7086B0AE011883D1F267118D696287226343EA2
      0F782ACE2924EA4312A36D21B16ECF4FAC13958568BD8DC70DCBBBF682B07E56
      F08F7CC0612B5C9EDE6E7D80930F40C07334D8D2097834C76C058C0A2C24BFE3
      2E23EB226025F47A918ED67D8C540CB36066C1A19733FD7E026C8671BCF36964
      7161AD9AC18F73B614FAC1501A32E651CA67FFF3F980D381ADC324F11635A3AB
      60ABE0FC9093F7473F22D4FE2728640AEFC1F348CD883A24AB8A97A6C1385227
      0719BC93D431731B138AF1348427246F9805D76864C4989C99CA20184E2C0E89
      4FD93D0D4A34AFB66151AE0F550B2B90840503472E81D265D25AADE7A1CDB69D
      3FD60B83F7EF3C6F15855855ECB9683C3D3D5D338DC5AD62EDE4F66CDB4CE9B3
      D3B8AB5C75D399C74641CAF93CAF991D6C395DD5823D4467ACCA32B116974921
      0B9715920345F904F0E0F6E39B8B77279BAA035017330E8011801E6848FB00EF
      3415D97A4B277C0193BEBA15E41C4B8FCD345768CBA4345831E4025B01264CA7
      9A8137548BECE6FB272CB4D57BE79FC924D6FA4293D8D7451FFBBFA1F3052DED
      3A84680502FACA7BB5973E6E8F7E4EB2D3E1A3B62FDA329F6DE1D570F9AC1B57
      EC63D8C54342F97244F279497FAC541A995CEFC4A02A47DF3306B4FE2924D11B
      8746105FA0209262A438F43F8518FE66D4E18B9542D4897F2249F436248AE678
      BF9A3D473241298B397E0CA3C72876CC9CF149780E53AA16734B96260F53D406
      21C7031D7B37D1780ECCA1E4A59D54080B7B046352D74084E4C181CBC53556C4
      52B59176B1C8B675E3A514D64C0906615874DA79B2EC0C6904CC05C64068BC5C
      D6ECDEB354B89E2F642946ACED301D707699CE259625D067DEF6569262896FAE
      7D5376FB61B63915C79099455C4094C2846F448243797E5E73955E055F1DF317
      84AFAA775D4C024C48C5E86DB6784816C978AAAA64AF1D34C0CDE2340D06E1C2
      8AE101093D21DD55033375011BF6E2285CACE4598137F8F0359F7F4B32B0A983
      30CD00C53D83A825CA0A85B5E8D07B8F7627F4FEBA054B95B1403DC502D57ED9
      16A8F731EA6EACF0AF0AFCAFDF0285FA8EB25E70A9E60B937411A773A89E03A0
      E6D6BC56B7B73E7FB53E236B76584752222F2BD4F3781E5A475E90443278C317
      58B76700DCA10DE42941D89B5FA56B8794A758EFB95AECD7801154460ECBF6B2
      F083A4E36C9776F41D4E47487843F5A2453691B10374D9EE8640EBB7539BDA35
      B5A9EF67DC3FE3FDD3C0607CC6F82AA71E80F13CA5E260E9952CC4E391D70E16
      663A9F519C1DCB984C35C0DC23825708A1B9D8DA072F4B441CA183F915DCFFC1
      5B7CF0428569DF68402BA1AF7878686B00E81800305C1A4C0539AEA780ED2600
      88FD38F2B8170626F4D394EE61C47D82D503FC40267253C1CB6182B91D000E61
      A2F94571366602FBCD5A3BF0A23802BFEC2E2EA5C34FFF2347F882C786BF7381
      02B4DFC213541501FE239712549B5B16CF64E91AC0E911F3963A37609A3D8613
      1F98057AAF58FE00583DF9100B00533F05BE888DD35D2F5650F60DE64943491D
      16201F6019280E2CFC5C21A423D44D00E7CA784655CEFF4F3CBF98C3290A3380
      A8C239AD445EA0D2BF3F04F9C777C0CCA37CB28C589B9E085FE1ECD979D10941
      7FE934F34E022ABFE28300147C1265C96286BDE82CA7DDAD5BD235253A6135D9
      43550D840BABC281D61BD3064D7BEBBFE6224514FAD3BBC3E3EA8275FAA6A378
      8E91EA58ACA75EECA8CA4167B5988829B67C07F4B4338F6EBC08AE0B17BB2AF1
      9A54EEF61655C922FB671005D3E03F85B2DA645AF440D50EC33895117A58B82F
      4E9451126B94D72C43A1BADEC3CFCAAE9A6232369D0A610FE2D216D94D30E4A4
      8DA0704D0A9215F9D8DC4EDA5BD9621CE9022C384622226F8AB27AC045BDD1A4
      4A65BC27F30CB37EEBC5BECAAA0794DFF3299AA36D5B16D701C988C8B6FDFADD
      F10517538DA331A264ACA6C72544AEBD24A044831444CFDA91C511E4F11DB6FB
      26DBC06B96FE5E2D64D82ECF9BA5B202B6544DB8A410C8EF10F7B8AD0BE9B757
      94F5871F30DDA4502C63978CCAF30893E675A9AC2019CEA7B024A96C6BA2CBB7
      60DA002554AB9A773AA13A55A5A348D843EF1BAA16D5381662A63B0B9FC91280
      8DBC0AC590A2950B8E9E2126A5AB6C749A03ACD8A6A2B155916A527B916C6C06
      F2A9DBAA10BAC5735ECDCA25DEAB0DF95CBA760BE29B08C575DDF6E02BB150C7
      144C5823B52EFB19166D0358A0E0284B42EA6C170633CE573D8DB7B7B0D62B1C
      8574B31D5D710A46C5111B3265E7DB10905F286DECF8F0E2904AF61F5E7C446E
      F10E502F0AEF8104D290841527C41ECD7430A4EE0C15C7592AC6E75983905A39
      C03FA84F6013DC01BD81351DD389E7DB37F0EFC26FCA1250A87D6F6BB6BF5554
      F838E77A606BD7179BF01EC1DC6D82CEF5472F4AC4AA6CAA27E7EFA81C2AF700
      3E3F61AB2576BA3FE3DAC23AA2410533504404ECB4BFCD03AC8FBAA36B556689
      F0403BE6E3CB8009DD8B56BB7174A93978FAB7B154D62E3B70607EC718666777
      DD6B4505407879F003A6B64B34A5AA22718298ACCF49425137EBC48E2C5D76B7
      2E1A572A0AC6DC17040B1661BDA24243890050034152041C58409E0DA3533EA6
      17CA8371FE792D8BF8541505CB93D07F26300EA47F886FB81CD8F98F679F969A
      2D80988CA3FA5585A82E89268B6350F21A6A53EE4E2957469678510A47333A24
      63F0182F964245EA743E9C7C73AC80D3EAE9DBF30B35F530ED7E9072D737BA8D
      ACB3F5A2BAB24EDCF17C160643344A962BA3FDF0F1D3075D2F52564DF4A80AFB
      08E4219456A6C28ECBC7FCBC1E9071795484D8B2110664E9288E7C6AEB609C79
      8CF656B186DCE385E27B18C9C87FE20059E1A5B87D61702A692999C86E39E896
      E64E325EA6DC70856179E3A7CA30F299F9D23EB00E75858B255722C6E4702825
      BC4C60FC7B8F147659A086E1D76B11C1266AA942FCD607AC9A859D4F60068E4B
      CAF5CFBE20D8BB7DC692D8782A331BCB42BC23594271FE5932173ACA5ABA2182
      54893F7CA2B22F62AFF4546FC503D1D6CE2F43AEF301963087C506B87B91AF32
      B3601E2893E945D82FFC48C5C9ABDE85ACB07C314B046ED6BE5920B440AAD9B5
      F3DD21F5BE3C0DC24C760E54577DB7677DF729E2B24CE4573C6674677DD48DE7
      E012FCC3771FB95364E38D2FA20C6012195EF928DB50F6FBEF686AD03217F802
      8D0CF1208D696C6556C08600D4169E9614AC93EFB838334668F35B7DC71DB9F8
      7568F9E834076A14E059533CA98DD13E4108934BC3E71BD0BB985A06F07647D6
      8B011A4C969FA34EC38C0503B9D665D824B6A2F3E3E19C5CD93BD8F003239467
      21C5BDA05B87E290F7C8084D6E48E1C1A46A9EEF9AB57DBFB8FE827D687E9573
      4255DD742F9ABD15E5BA590469EE30A0881AF360C9372C742F0C646405704146
      BB14B83255960B0A3FC0DF48D8711DE1B99D7B55AB6847AEDE0C4C952160E256
      109CF425B494AE16F8EB4CA7C9E8E8B058AD00F8979EBA672DE2393D8DFCEDBC
      3AB05DD3C1F8E029C9357FE6D0A6EE8B0E6DC215BC72017F6FAD48AFF9BA192C
      A7674D14F5D5CDAD0E40A237E29500C2D799C6737172DE222EFCEBFC680334D7
      6B713F4670D7E00D383F3FC1297B4142BB6606A0CD99386064F691329B23D80D
      C8EBE9FB9FB4BCEA84F83F8BAC9E9E917EFDD7A111D5C789EAA6A454ED84F416
      7F2A1155FB8991D007AB53970E939B50A5AC4DF03DF035F02DFE2C52AA48FFE1
      EDE6C4D4580BCAD6026D6993DD38E9E0FE7310F98890BD9932D7E1B7EF301482
      FFB487E601EA261164E87FE2845021D86FCEE90FDAE29E665E224BA160D2268F
      A60C07C662F640DC10EA2B6CE647F6DBBB263223D64AACD75EEA159982A57FD6
      1F12A82D72CA984D890B593C165436888CEE6B2F7CFBF9B5DB9EB3F4CFA337B4
      CD154D7C5672EF1A6539953E43F7A58A6A63B54CD9B91C3920A3FB38794C87F6
      A84A1C7124C30BA653B4BBA3AE5483931D77DD0C96A816C1C2B27CE5AB4F2614
      6EB2DE94D9BBEED9BB4E6E0313CB906F5218CDB0898D4AC034BCCC8DCA2B141B
      F18311F99F33894E7750EFAC740CBE3D3BFE41C04FEE62B68B8A8E923F640940
      B814BDC0430EBDC0FC59CB1BE17BA0828B55CB455498A3200AD28909CB786836
      4F30D9D10BCD5226C97EC3713DBA520DB55D610E2D851A95AB37CA65C04ED24D
      147D932FA9F6D58DE0347520DC084E15CC80F5130E52A1D5A1128A438B4B43A8
      2AAAC37982DA0F74562063D08391962BAC0780D1C69CC6214FD3613C94D12E80
      D808FC511EB185413B3E5763C895AABE98387F9E096FBAC73FF2C4DC427D8644
      8C0358808B3C8A87CB8AD12BF040D43D111FCDE2ADC2DEE6942040299A01FC51
      52F05D6A615F51BAE940279718855B612DC35EF5F3CCEA768CCEE56A9558B640
      C62ED35E4F4A96E595457D38E44A2214963F4C849772D1B2A92A378CABC639B0
      0F5A24B3F8A98DD2389C1843D483873159010150DA9BF7A7674BBD1CFFECB2F9
      41D7784655490C5225237251C53A4F3E495EE9020C302EE1556E26590CC7E7CA
      7BA05BC794B77743953211E77281CD036BE782BED2995AC994468AC4F5F616EC
      0618FEA5CB2664F384EACBC4A31107D8E117325314BE93515CAA7C05A78772AD
      5A4C29CD283CDACB94E5382B5CCBD68304CBEC3189202108F3715BA2DAD90336
      43503E9D88C6989E8051A9FF3C5059A5AFF39CED37D128FEBE246BF8A438E49A
      1941627DC084D71D5D511CAFDC854B6400ABAA82328DB92ED1F6D6442C284E95
      CB75EFC9FCEF8042C06FE2E44ABD7AB890BB9F1CC92FBE8435C542E1F99CF260
      F0194613071819E70D2781A0970CD2BDF2FB170A57C8FEB5A8B2125FD6032990
      C5E32DB33DA6D9289621A44C2D66F552B2460A928193023735F4550D1DF88E83
      5D60DC3B4940E31427731AA45CB111DEA07C25EC45A920A33FB03B1589AC5BA2
      799F17DBA63AE9F95B216641F142EB1288562ED1BB452A56E56652D462BE00D0
      3D41D62D1E7798276A59C76F0EDF162B89D0118F040FFE0BAE55B9E50277AFBD
      EDAD708EE74B5D4B886F20C1CE94A000D1B14ABC61C475F44F85B3E40D816A00
      AB6F022827E32C0BC2BE5B4C1393530F7FE60EB1075C6D4F65E9526A69314A13
      B36DC42D1C89453457363AD95BB6D4D459F969726EA69A9D8ADB18E09C9B0E0B
      72BC22B7077D34D94D2C250B9815731917124960140879529037A15580BAE186
      6B98087F77EDA6C37D14419494B597FCDE5B3BA9EFE3D5C4164805BABF116251
      51E11A5EFBF98DB7CAF5CFEDC6083680F87EFE60BD8D4F7C58C6740403840908
      731512DEA9B103BC07BB3FF9FC3D0C3A90182A283450917B57C60938D23E6C51
      895904BC72CFF10941E65BBC98CEE2041D5C47276FDFE66840960F2B8C7F20FD
      62BAFE09F7767EA733F819DFE2E991FAD6170D7A88ED6813D64F53AF1047FBBE
      98A2F77D15A63D5056E81041EF62D91AAD5126E23A7836B16CE56BA925581035
      9DD5911BD38B86EFD11C1FB1F440ACF322F8317A0E524637EA5C1101AEB8FB78
      0267B3793243FB390365C51F8F6C412A45727B2BA26234278CE94FB1A0AD0E11
      D1DC21771D3E8D798EE6AC110327428DB2C0C681753A4FC83D7037992B2B0025
      9DC0B5FCE002B24C049710C3D3479A27B52CF3135E03D35700BE6185D2712CF1
      38E7B87899CEEFBAF769F090B9AAB80FD72D3D234F9011011127F364826C0346
      60A0217FBDCD9A81A9D0A9322FAE7B77CD99B041077E6E0B2E663A1F72E9252A
      117946E7B18733980BB9CB677772970B065AD23BAC0F08A2A75CDC09CFF22B74
      C04EA10A9B1C774FDDC2E530966FE2A750612A6AA5854FD2277C7A4758296471
      B8B3488A89D7CA98ACCE8F6CE3D63561552558916554B265F9682C47D1DA2219
      F220F9C16ADDE2C6737A0E6F7FB609407757E40CB4AB80BE83D47B7530F05CEB
      4710B970BD155D5E32BA5BAAF73FC4CD73B4FEC82B9C9F350733BC5A7B5E1FCA
      DFBAA3C227DEF696DC65B08A0CA6F0536519CA7EF7F38D9A271EAD6A6B9EF9D7
      E78730EAC6CEC26CA8230B1D6EC369E9B8707172DE7CB12BE1795DD9302C800A
      82F037027669AFCC093A55C844722C18216EE914C8689E2BE89D9EB10FEEF4AC
      DBD117ACBFA2E706D698625E216E938F6274684AB10A5D90A673EDE651F5C5FF
      1492C527430EFB02A1483CEB3A0E86425504F7B05DE1980A1570D842C9FC0C40
      F8431C06E9442DC7F62E682AAEDE56A8C62E604B1729B66D8D67B2263B1D4510
      16D20667E0D1033144B7332C67CF6701E301666844E523254B0A7E95421C0E1E
      EF98757066F306D27184E71D2C72731D708973698BF827FABFB02A0D765EB20E
      410F1CA359C288E603968D09BC1B750D389F09E1BFA666584644A56D964FCC8D
      4F6FAC73796A6EA024EE49E16C30F74AAC7B74E7B086B2392C853F16CFE281B4
      3A7AD75E105284980E1A28BA3879646E64C6B10D54BC1DAD8FCBF5DB83E92CA1
      0E1D5C640A212BBAFBC966A84D0EE720C3C34CD58B2A991712AE6E45EFE0C9C5
      ABBCC5D68F229C59AF64B739F8F05EDCCED377B18F9F7F08B21FE703F820CBD5
      C327D5E8F095ECFFF74AB60FD4946C68ED7E3B4D4C1DD3C4D43493FB0A15977A
      2FBAE212365D737AD6BED53C68D2990997826D8D4087929782EDA7CAAD434099
      8EA8B277CED47A730C907A9008EF8A23CDF613C1291770C51EE8DC042FAD595D
      7F60491FFBD071C965D0BAC80E3C43DE14EDCB1F4F3EBC3D3C3AB1DE9D1D9FBC
      B54EDFBC3DB1DE1FBE3B915DEBEA45F1AA2629DB5B58C0DACBD043897FE14B64
      98A6888631F92FB950F59476EFFC24543A06A1580D132FAD5B25F38AC631D8FA
      E515C8FE0DEA95698C8E3CB9095B7E4C8E0E0AF8032E745A83E01B100424FAAD
      180BB4A8E09247AF0765F4CF676CB5B3B9C31BB72C2323C370B9F676CDC9E716
      781747A79F705E39C2364F71E5A489C6694C5EFE4FB346BD88AEEE915468DFD0
      F880818A091E1D01D8E755C2756E0796809C65D6CF67671F0A5180F5E244E592
      4FE22BF1482BD9F39A1037E18BF813D849693B121C49A422710A51B488D7AC71
      C06E68D5F2539608AE5DE39A0A9996B597DF5CBC2BF660F1A8AA3320BF20FA37
      9C6B69DB2FE662D484E8FB9A47065E188FAD8B78160C1B1CA0FE739C843EE0F7
      A168583F709497F4EC5F6341D214B53AB044DCCEBCA866FDEFAAD8C0A9CDB26E
      2FC5EB9F53B9E98F62889614A9F0EA89612A9BB1A8F68F64210DD242017D6520
      559DD03C9591217B93493740C84B421A965664167C238C22C39B3AF449509B87
      160EBDE14414D219B831A28C47E4AAE53216D22B765EAD176F2A38138CB6B738
      FE331E5288E4EAF4129F6203D93E0FF204CF967640CEC1D5F216717DEBBC1B29
      1C1E6399820B8B92462B055C7E134C545E473E29A79F91ABFD9CB8030474DDB0
      038FC3E946CAE30DBD74ED6500A9833C77C965FB0059953633D96FA20C4EB089
      0ED55E372F543F2FD84FADC15A8BD6D4D1D42C7D1BEC26320E36B2D3BE5E58B3
      78360F3D4C3DC41A5AE8592B398196A37871079E8978A68A72CD28EB5487CE7B
      58E3611F3327FD3892256BF22310DCE5939517BE96CE27E31FBE7F8E72171E9E
      2AA4136F60BCC40521A6006D76084BD702BA6D95C776AFE82B55AEDAFBB89A57
      1885B3DA200E39019EEC90283D1BABBBF4ED78456DE3157D14E3DEEBB3DF9F7D
      891F5A8D9C278DBCE395DE9C3865CC570917623A10B45D05913E266151C662CA
      05A7D99533CFD00381658A30297E9C78538EB33BB05ECB66CB2A6EA3711C63E2
      153B2CA20C10A8CC826FF07583F8363F8001428F1026EAC147730A1EA5B15379
      3F55315ED1D30B295419F63B0331F4D035245363E04FB298CCC6FA78B9CFB2A2
      DC6ED58A72BBCFB3A22E287807B4FF1106EEC0E9C12C2C5DE1F1E2EC4881BD42
      EC542846CBA15305F9249FDD0EC54691FF1AE4F52A3762152E04C6EF2EA77FD2
      B2011C39C1A5E9DD9D1B2DCCEB0D203E8EE7F822476130BCDA7875FB3534A33A
      016EAFDB5AB1BDA56404A58ED3EEC83A2553E3A43154E6586B7B95EE751AF870
      D097E28823A006A7E5E5294B2BE66D63259942D6D839DA0CAC1D651F035E4771
      B62BFB36DE1D90B3F5F0AF8948B31873B06F384F91CB98C8D22EDED80B36767C
      A98BDE65078051B612C5C8F69BA2D46E4057B259529DE85528A43EAE57191EBE
      BDB0FE669DFF19F4E0D1C5C7B740EBE9BA69256B7FB12BAB28A672AC77BA4F9B
      EBDF08B45225CF108553637963E903B91262964ACE5060A00A7256EE0EF899A2
      312A4E296864438CDBD026AA7957D4289FC33DC53659D1428D43B3809A291138
      2B58D62B92C78F3D5D02219595E884AA88B07A08799FD922EF9FCDFF2F8EA766
      83941BE47F6294D3C48323B4977CEE16899CD455E9B82A5CB8A1AACD724FB1F7
      ACBFD1BAD937D5B05E988DEDD31B4CF4999AAEDC72EDB14D29CA2B4AA5A54607
      8339C65CC03EADF94689520BB5DEA86A0B99E064B9A06C92C4F33167DF37E88E
      0677F1C28C29550A65916662CA5FED04C33852D522970C10BBA5E4AD1BD9D10B
      96D575E0D1F7EAA53808272A547E291657BAEF328BD2B2B08583C75542B158D4
      A87C2ACDF05E6D3E04B263595D8007253254B5CDE2A3D8054177A75472331538
      DB998AC8784B8EEC1DDF4BAE9071B87F021F42FC164BE1EA0AB37C643D86CBAC
      1DF55775B5BCB978313FB0403F3E5EFAAA2DA0F40AB98C55131414E042AFB298
      6F290F8E9AA5211714150035265CE44C6DFE3C95727876D023A9187F32152643
      F921FB24C98A778315BD30780E01D650F658C6A2A9F13C317AAAA0A7C8B07EC3
      0C53EB541F0C885D563A249EEE0CB86619A3D5C847E6B10649E595143C430019
      C3726F67C0F30043D2F4BAA7C9D9C59A115F69A5B2250ACB5294BC1168EADFDE
      9AC67E300AD0FC2F477AC523ECF288786F3E96266940A5E475832CFE52D6C1C9
      0DB54AF9A1B851F1C3106B07E59287D136735369FE01A194792C2BD6AC011712
      D867F7E66417E36769592B964AB784AC581D8FC7A18CAF275B6E1006D9824B75
      CAEBB3380EE5EA9637495B2DAC2DD8E6D8FE0B5BDE208864BD69763BF09C51B1
      9C1D5A553C7DBC32F5DF0F61949D3B6B4DFBDE7EA6CA1CF876B9404CA95CC20C
      1B3F95F31C8BE19E43AC48235724B342067DEE49D093F1219EAEDB29BDEEABE2
      CBEDAA41E4F3252372B38059C8F70BEA8FF07EFBC71FDEF0BE62D6EEDD0D5755
      4D84BDB0CCAC22F095A91F2083D844077752D8CF44B18EACB65ED11F467078C0
      40C65415C5F987051CFD7F9434ABDD5A154E3CD05D88C2601A64BA319A6CF240
      32AFE27D06C03A7A35CA208CE96422C2257C8A6FC1DB5EE905B7B760D1646C37
      53C8DDACA28745A6F1A3371DCC93B1481AD63B38139975A462583463882F8D8A
      104B69E6AA70C2178EC0B20F831C0577193CBDD231946C5E3BBA3BD7AEDC6F30
      979412AC23609248BFAF57E4FFC6CB2EF45F74D985B731EAB1FF903EACD7C4FE
      E04DC55B2CE4B3138CB8614B94D5ACBC0316C9ADD71B9B6A6845EDFC0EBB17B1
      6D32C3B658042668C78F5473EA0080C1CEDF0931F80294AD2F23D9652D2842DF
      79EBC26285A814B4F602F050965757A3C24E455B2807051A6CF180BBF5FCADB2
      4F1BC15DB2DB732B056DBD47A1427621645FD5C062A7500B15FF7620D2104B58
      028A08F4991B0B94497398270BBC8BA5B1F5F9577D81E703EEDB9EEA92E8B2EB
      1899BB3DAB4196AC869586DB5B71969BBF28E993DB5E71BF285C38B399BA9102
      B04E6E6F6F2DCAAB3EB04E6E3D82EB6150ECDAA07A5A5CF012F3B0269C3EC068
      2B806A43319FE147B7DDB41AC8C0867EF51DDBA64E62C76C0568D9FD8E7E717D
      CDE9892D2F3B393D3DDD5574CA566ED4A82B0BA6A532EF7A4EF22A17A0338619
      779BE02E5D6CEAD38F411F0BFD557659C317557FDC93139BA4A096827190A50A
      29CA965BA8C4DE9F5D50FA7118709C9C47E9F83E56D3980691283EDA8B165378
      869ED542197EF48BA06AE39AA76431E57E6F1C314798134F70B9D48DF236639C
      EE3B9D013CC157D841FD885016B3037429288ADF8BACB301D6097873BCA7BAAC
      5049052FA730283615DB83F3E2FF20EE6B41821329F992F2320CF9D96E859816
      25589505AEF023637FB199AE44B2FE36616FC611CC0EBCE8FA4BDD1267754B14
      259BB4324920D330CE30EF18DF5099B8B42828F3C09296597BCEE6FE8754CCFD
      F8B10C7CDEA09D12039135850551E2272F7FC9505C74BA88C023982A351F168C
      4AF966B44C73234E823532F99ED45F51E4E5AA2A2A5103471ED9F2D8A09292AC
      1718536C005568144BED84949AC0DC9CF57715C252EE9BEF2B2F1BD96EA4B7FC
      28EE765E486379AA6DCB30801413AA2F648D9F37D13EB03EEA66B9148F229B11
      CBA5A7D2BF08EB15711E036352BCE7846016E7C12DE8CC29339DFFCC012EBA87
      6EAA352E65D96B887077C5E3D3725337172C9160751607D8C9978E92D1228E44
      A1C09BEA378F4E5EEEA915C6F11522C715EF884F9CCE87137676A11369C87D4C
      4A55A4C8912DAB50A9F77D0D77A26717DB9F78F032DE943A8EC338545090C33C
      53E65222FB7C8D1012661355A2B33805CC611FDE2F182DA43D325A7031E64F11
      59E51BD6B547BD6A89EEA586AD6643B97F6D7CCC7B38BF5E58471E39FECC9E42
      7B4A9937C55E7BF26CC78711AA2404AA60442119F415AD6D0E68E23A437C82A1
      32F68516D78990516E7C7E3AFA78A48DEE04CE70795103F3213F96039CF55283
      F76327118DCB6722EC4F4C4F84314135B01F1763D61201AA20A4AA0878DCC2C5
      12596D384B2EF585A6137B4CABB2A4F3328FB4637EAF0B472FACA0580A78938A
      C1C2E264EC09A7F7D07C5C6222932F1B4962C437AD76F9E03DFC54CC5B210AB5
      FE4EAD07E7475A10CA412EFC4C15507EF93BA2CFCB3F48F311EDD24A513CE672
      D4394F30502E93FE1162645C836204EA08B0C53CC3E3F160CE8D39957E9321EC
      CA32A1F430B57B57D5DD59844A2444ABF85B942665BC289C6E0E80D57C093292
      22FF389FACD0271C066E1C7B99A728A7452F1A2CADDE309B7B21274EF240705C
      A0160C9C4C2CDF57EB7F98E7BBAF2743F3AA0EB4D4367B9347DA637823227AFD
      48E4EFC5AE517E90A230A4B4D68672AD6E8C196F6109AEBD173830C4A7CC7602
      4B45E9CE1D33BCA2A8CF237EA970D6FA4FF29A55E87B5977F2966214F1A1C828
      B9EF28559DE0A6B0F6566CFB47DF5FFE8EAAE2F28FF59B39FECE4A4A625B8A8A
      CBF963F0DFBDEC7B07A304FB080FC88EACC508F70F65CC04C850B9D51AA8A8CB
      1ACC9298EA90C605E054E8915D8D56FC39992F656E9B741B88042FE0C8D9294E
      1257C0C2794A73BB33C733915745B71ECC73288E3E7CC2600E51A84E246D7554
      FD3C3FA5217CC49636E89CA0D7402745C18D60564F45D272019CE39C48D80E40
      BEE99A55B27295306FE431A778B821F0AD81A69707F0AA235101735AA591A40F
      4C1BB4D518725D15CB637BD17D856F8DB83F507F927A4901ABF1266A33485D31
      625FCCF01763912E0778902E90BE4B95BFAC2D87EC1EA1E399F4402321D8A63B
      B7ED1DBE3F7F63EDA0196FB0800327EC09680248E09086D918F27AA9D1652254
      AA4B1AABE8D27C7E76D0B7CD85A0B31BC1C1E13C58AA3C3BF01AF0A8ED2D216D
      6ABBB89A2806D5FA80496AF13CC572E2A90A656767ED04B03B1519A7F85820AE
      D8EA94AB73B3EDA0C011760C053E625A846DDA7D4D44EB7796B102F24859FE9B
      540C2186A1C92BCA4EE442292C8C2BA00497EAF1F89CA1AA47D2A5BA8FB3EA14
      2313A564E9DF61E8A57819BC889A8CFC300C34497B0D5A03604B57993EEA444C
      B6D5501DB6E54BA46C03A1DA9644C47768FCC002DE986214441C08444E719561
      4F44A833F74ADE9C9D9B9CF807CAC6D0F4A909351A4C6DD718678FC99B7994D9
      1D91B7A8CAFAD8431B225A1FA5049A50DFCF0BF5755697DB7C29B1BEDB5B3FF0
      B6A4A77D5F2A39940FE980A1B028C27111EE6E7B79C174347B510EC41EC61B88
      049B5E47798000C5EBC0B589AE29AF1C5AD4AFE7A05EB2F4D3BBC3633C0D02DD
      DB5B59C0AB255BCC84E41D99F593C45BE4AB4873934CF9E216C8A416CE578B24
      98F261DC43E725A7C0B36197A7411A78956136DF62D57666796868CC82888291
      F2954C31599876124B2B756903AB09AB65083A428E1562799747682A27E1ABB4
      1E02FD5FC54276205F66ED459F086DDD70C962291E41CAC0001957B309875D29
      F1A2145603F9511E37EB4B2B43EA1CA95C1454A228242EF13FE6ACB05488030C
      F9B3CE066100002CDAD3DEF826C334F52B9586813D9083234BEF014F14216C8D
      853CEF29A653534A5B8A2E76F9820C594B1E70D41E1486802F51D0051116A1D9
      E3906E2A89098B3B9C532D8968A1A6B6C01F6B47F144A6ACB127AACCA08797C6
      3A17C63A7C0F0F2D8D5DE598CDFFC63DE2D047162EEEAEA13F3B605C8608051F
      6C41FCF1B4A7CF298EDB76AD1D3AC2EC5B6FBD0C1B13EE168C9420A631E08284
      6B7FCCD34DB8C886B37D7926FFFEBFD58BFF63FDE27A43707CCDC457115C20F7
      CE8EF95C04635D6DAEEDB366A2E7D9A8B791F83C2F5F186CC53FC0AAE1BAB35D
      3225BDC34879809099138528FE4B2E1341DB82D24805284A409412A7EFAC48B9
      11C086F4E9E2B447203391EA4E85EE9747A7E8B9655B563EAEACDB93E67B31C7
      BBE0E81C9900DB14C34E4DEF0DD15868BE5B8A82BB8BF38812322DA1DBAA587C
      441B2723CA86E080FE19FA56E44E8F7A9FFE267F7F111BDE3A248C363C630A7A
      20AB558A8FB102C9C8EA1C7BEE20FC393FE1BC9738F4198416F3BC4B6B8F1729
      22DA71846BD798843ED324B4DA2FF4524C42F0F0413004D80618AE53AFA9C550
      2BDC9EF6694BAAD9BBFF47C0A191B86ED7EBCD7D2F0A52F9EA6EBD5E5D44E3B0
      AEEF3E0AA2DAF27D841133F57CF5B100B81ED5F3D51321AEF8CD9BF57AF3C93C
      1A7B49A0F85E330509BB7A18D45466FEEDCDBCDAEEA970B4BE11E3BAB27E16E7
      7B53CD241E0D08F3F19CE5A67E9C4FE669AAA5C6A9D7BBC3A9A3B6B020BD117E
      5DDF3D9B2757FADD5BC6C8901B19CE4F8C39E16B9A13565BE05E8A3961E511CB
      AC8B3C03BC557239773B66B17CCDC5D27CE18B65FDEBA48EC6FC638AA3A052BB
      D2CF84F1BB7AA550922D17F925E788D13AA475DEDCA9684175922705BF3D052D
      537877CECD1DACCA005F29873DA79EABBC631DAF8CABD1F20670D52EE62553BB
      81854AD4284D87B523934152ABF1895CFFA53F7FDF58958F8C6E40CA61DA2D04
      63B33B5397A745C726D68D2E84A9A35F9343E6EEBE860A44988988E3653C6E85
      804DD09005E8D15CB717F197E14CF9647F5DBF6B3E1543AE48209BF1501D612C
      0CA27A47C80A79812EF97BCF9ACAD74D76DB773AF0AFD36BBAF0C3EDB67AF0A3
      D9E9B4E047ABDDB3E147BBD5C74B3A2D072FE9365DBCA4E7B65A7C375E028BB3
      4BC3D8FD3E5EE4387D1BAF725CB80E7F36BB2DBAAED56977BEEA625D4337C9A2
      20485E4B28F5778C63905F5D61C1F138FA7B07FE67B49CCE46CB1B945008B335
      85B745817EA90127CF9A374DDA1BE80E0A395C3B5C8673CDF4A3546EA031741A
      7D97EDC99848D8635054B9258F87351A8AFB474150F288156AA0C3A53431A005
      A0F450C828AD42200FEC3BBE48024C9BA32D506D97260EE341E846B841F1CB68
      AD42F95DD5D95EC65C298C05DF344E58F937AC1DF8D8206CA34F90D4532A47BF
      238A672D06826929D78D9CA653CA3EC00A5D9B89BE0CBFFF6FF5C6FF5851D7E2
      EBF2FB4036D9E11A6F691614FBFAC88213A43FD29B20A39641C548B9422C1AF7
      F6A218F242815B0A9085D3F87446733716E5CC4D7DB7C6CE6B2FECF1DF18DBF7
      8F033844AD5F3F73168BA63D78ABD871251624D7795CBE2A4C9ADEB98622E231
      7786A3148DD67D544F873CD0D2A8DD82DAADE899B732DB9A0C0DCBDC54C57555
      3FA25C17A752857031EF641E61FD0DA9727526AF6CB651AAF55F4429237825EC
      17B6FAE178729D47B293917C30954B90BB0807FFEE901DFEF4AC25535CCEBA1D
      7501D24A31BC72616554B14ADC0E05E82F79E838D82DBC4F89191C11CC491777
      43FB29C37D98082F9315EB903E3A7DEBC226941E4E81BB322BFC4F15B89B1B27
      3EB39AF53332203F6A6E201B8013F30F2C71303E5837E51C00FB7F25B6AAE4C3
      1AD240B84E1F2D0C9917A00ADB7B162A8B503058D3ABC617699014CE2DBAB0EC
      6AFD74239B0A066911BC64BC2AE9B0C36B0F0BB47AA1359CC4C19022E9377270
      DC702C3D3959B8E4A73688E63C2D344CC8B399B826C45395BC812DABA7635552
      A8412E6CE6BACB9A72C19562AD95150A01779DD5F93594A4CAA23C4BE271E24D
      650DB31D99B65538B66CECD0B2E603231AD54AB98E1B3F326F6FAD5BE276696F
      E1A430D94086F7CFBD5CE8C80984B5BB969CD6857A522909245C872286EE222E
      17066738EBA8D8D5560F914D92783E9EDCAF4965BD4C55B828659115B29EDEF2
      4C05D55B49F07C2C8BE26CDD6501781B2AFBF49636B2ACA8387606F3EDAD8CEC
      4585FCE8BB558F567808B35509FB72371C87F1808E518593C00ECECA2C09E284
      BA2D63AEE36A53CA6E61E75C7F4E70291778035A660359D034931BA5BB648F9C
      A91AD29B498DDEDE7A4472F4B7991ABD01715F911ABDFE15B07ECA4BDD46509B
      A279E70601AD6AE5444DE9F736500E5B29840DC8FE8C5A0A2479E58DD2CE837B
      8B2ABE5F36326199562AA3282B7A00AEC52E048BA2E1E905DA54BEEA21F61EFB
      1A73698F83397C910E9360A0C1D868FD7BD0F6D646AB286DC6F4749C7863AC20
      3C8893E87385E519CD4EBA6D125509CA826B112EF6CAF8F15EB0C7FD52CA165F
      72992B0447087DEDD54D66DFDFC2FF1EB77F3FEBD24BE3A960D82263D8787D51
      8F646BE76EFBD4DD726B98B58B21B2697B6BEDC7143E266C3C1C671DF57DA4B3
      72292087C1CEDE46540F06186FC0E59E1B00686B0AB1A83EB51C6AA976AC14A6
      8546AC50705D6F3BFD1C0E3D270C421562F79BF6BA8F00C622FC90237B6C8908
      5ED3147229C43BE6D92292375624BCA4A2D43E455363C5778C662936AC000028
      5D9164E4D1969992F5CE04FE7E65EDCC11F18AF9DF5B321955B29DFF3A2E55E4
      D365CCBFE7BA7B770AEF95EE5D01E5CA0338F900478B2408C360581E81AA8FDD
      B9B3D3B66DC7DAF97471BADFDB356B93D6E6CF1810F2927DA7CF1ED8C5BE53D5
      F74FEB122526775ACE812E321AE56BA712D8F6F7B6FDABF5DA1B5E8D93780EEA
      1CBBC289E47BEB1719012195CCC1F9C5C737EF7F38FF55AEF4C7EA05B3CEA9D8
      EC0BB7313D73943D9573A4D0913D8B1A5AA8B61A5CCD32CEF2F454B3B4BFD6D2
      6633121A91741453C51AB676C86FAF2466D7ECD8F7AC6469484697E59F6B59B3
      2F9E9210025AD7962A46CE25CCF3C2E266E75ED3CEDD5ABD73E72BFF40A4D35F
      AD53342ACA9E693BD444EDFBC3FE69AFF9FAF4542DEECF19EE29CAE373C63FA7
      9022D95CD13427AFD63F1BB09DFF6FF8DFBA0D5F041EB6B7284B09340C018A82
      EDDCA8A217A08A1C77F5DA3E9A9D49C57021D20CD6F7AC427F908EFA911C1FD6
      713EB91BC42275ECD7887CB7700124A020223F34DAB3680B0DEF7287F4E8005B
      2326E22609B20C9B24E60DDB493441183D4CF54363A7AECC8FDDFD3C6AB0340D
      B0703D699BBC6F5FB1C58CC0C84576967A77ABE82BB3FE79E188B447175F9C9C
      B7302F47B59E79FF539182E52C63F21C72690DEAE42B9BC8C020ED57E7E72732
      B5A79587E8CA61D66E859A8573E0477A90DD661B7035299EA8BC773F16DCE445
      255504114C2BB035EF2E2BB79CC27BEFEA16B3928B385D776FE4489E50601F34
      354D2BBC8C5F97DDF896F492CCF08DB8AC64B13725837BAA118F8A4359F7310A
      60E6FAFDFF48FCFA090DD74FA8CE562B751FC930E08A7B8EA09294312027E7EF
      AC51E8519D1F992A198C24A09B06DC45B6101A518CFE2AE9C2A7543BFBBABCE7
      12671E8EA7AB9E511D34F8C6720E5E48D1B3D617163DFBCA3CFC1DB7C8CB3FEE
      5DB05F2BFFB05E12E54A895A7734C4A7990FCBFAD11AF519D5CC3E6E29CF50E4
      105EE8D966A67967669A569367E66C04E02EF042EBF8ED11AA3418C247D7B9D2
      61FBC51DB25EB2D7DA90EC29F5F07F7FFAB821012417D94F1F4B753A5BD64F1F
      6B20966D9EB4238A838E23EB289C0F242EFB0AD2B96EEA3A4C9D8217987F4BB4
      D5E0D5BB07B2427DB45FF5FA7FF6C3FC9B91E5CF29C804412035581E15CF6B94
      7ECD825BECF3C9E96ED2108E47363E02C691E04A86543FF7B73925CF4FBD34CB
      D3065423D010568BBF2806313036CD6F2B3415E5C704499AC9F696A8206E70A4
      15332B1BE6CDE661C82F47291F4124DB62E3F50310912B40C0C60676AF78606B
      DE773C0D3A71D0F261E78D4D8678C118768737B422D422DAD1C99CF23ACC9429
      9B37B00616796AA8149397602D2BF537B93A3D2E09CB6B29DDB31AC378B6C013
      E0C1C101C976838D6AC13408615AB069256D46E96E6E972B58E3B4894E1D03B9
      6C2D1AE3382FD4C353A6B80E40027869CB15B788E7B2BDF3D26AE5172B978DC5
      33EB300EE7D388594296E93352263BE3409F5CC9FC07437929B05056BBC14A61
      01F1549E594907EDEEE9632E7E7ACB07DE9D51D928025791F5563E89AC852586
      7313BED33899BE39B63E246214DC168FC3D701D72853532003E941B9008940AB
      E45044356C65460F45814A8EA9B1DEC9FBC938A38EE09251DCE59A82B4E8CF8F
      435CBEC0F9F39FD12104CBEA4AECCBECEFCD587280BDDF655CDE430CAFF2BCB4
      D3D2925193C1CA5D6D1BF216FD574A440FA6BA8600FD9D6CC5CB92AAEA2313F7
      7F39F855D5C8C1FDEF97FFFDAB2E60F97F40E0C9F6A2AA397BD71CAC4B4613CC
      F8F231A52E15598AB72EBD901AE5389EE3FD47F05E57B8431E6549F8B79388F2
      6FF195F93DE3085E39D31A25DF04A94A72A974D6308C651D0AD6394CC7D93FD5
      03C9C5A9354FE368595BC08E2B804D70E0D4D1CCB4C2F502271BFAA2540527AF
      9D84EF83456CF010060BF2955E8A54093695C5ADB1A475D1D4F48877C2859F08
      34FCA705B50A9A29115381C91CEB6D185EC74DFB8CBC7D3031DF9D6B06A2AA4B
      D512B02671489BC9D1C5C7B734153E4BE710A5F33BB3B1D3C67E48E21B734ED9
      1359996FBD54E4FB40D565252D36F2C2345F1A6CBF47ACCD4FE40D6B8F075695
      952722F4E10937BC4B96740AAB456CEA3CCB729FFD3B99840A3FAD1F40C5CFD8
      FFB5036F0DAA7F118A5D590D4B9387890A1B2BF4589725763A47158CDB8C7248
      1D8C2731CC9174489A25C409C7CC943C625D392EB007FB8213387764054409D2
      E6A0B74822B93D39D5DC0DC801BC808DCE47A030F124DC92C3EB5D4943D911EE
      3DD4F05D8E453D060A6F03F70469B6571C85BEC670DB7114173699137E3BB99C
      68EFE7FD966FFEF426F77A229CB8F7BDCC6A5A2D2847A563499C207C028545FA
      2A354BAAB4A472BEA011C41AC17A9A27B28CB2DE6C405AB94493EC3112E3392B
      98CA2A9878D938A6F00C5C865608E7405C24F84DF1C035039C9C9F8AE0717035
      81BF2CCE74D9A1093032555B4D79C6F6F2336BB4602CC86F4BB5A96E0456834D
      658A1C77996131C0450570508CF9004B44A812137B74E4E2D31722F9C8A34A56
      FAD93AD35E7FC57CBAF116B84366F850660D716C28120A54D8413BD20DB6FA8D
      C6BB3AFE92F0BC0732B9BD859170EA18389195960662E8E95A7054DC5A9D1B25
      A3525462F13CCA74BC0A65FC53F1A85419C0760FACD70B1C9388A2F7A452AF7A
      0C527D514CB308A705A00E8E00C10C817B40D5B946B0FF6780D133B983F3715D
      BEACAA758EA05AE09B20E89067EB6B04EA149533E1B4C6F96C05FFA8FE002A6C
      7C49A656722AAFD62D8FEC31AC990091A7B4F87104613E269C91604059E49F8E
      645804535290B262970144691C62380E9639C0802159DD0C6F5AA660A20B22E4
      1248472AD2C778489FCE32E0A0771D8C59A0B46183AB996130F6824D1E8D533A
      E2D3F907EFD6EFD638C8111AC66FA772D67132E0CE590C02ABE51D8DA028EE70
      76A332F3116F37B2050F7200870235F55D2A8DADF28D816C2C441F44F94130E7
      0E091B7104BFC7471131141D05A25C7820BD3A333AC23A993457F79146AB7BEA
      5DA1C53763A520BC74216DB2400129441DA843DD2F7CCCAB1FCAFD9C4D567810
      969395C56A0E972699F1E708A50428F4C6B8FA7814A2209F421881E48D96042A
      90A5793729DC8F32DDF21A3E5F32509ACD340F03A760C33CDC960C4B1412A8F6
      A33D69C9A8E4A64EB7942B29FF96969232C94AF743A46DEAE9DD917071E0FE3C
      8DB9C22345CBA96DB368A2CC9FA1CB8BE616DB3D2B8DC98E83BADB0FB0B43A2C
      36713B5395FE83C80F60D745B05D5A71D2AA1B245CF531CAD2A2158C4A43492D
      52B076E28DE4F0019D1160A06740705BE5A9E92714F681056C0F53368973FC92
      B2A7913295C634DCB8AF3D60DD2034FD5E1E90E59308B9F4EA3848C94C89ECFC
      28C840A9E7D7AC79EDAF2995349585797F224956228D6B900D31B42E7CC957AC
      4F4B9CCED9BA5704B300C8E791B6A3C0D6A7641A814BBED264F4F34D0937DFF1
      22F1EE6824FF81C3A32A3E6704FD8EA04B0F5C76135B1C371A2BAC55384646D2
      90516A85819E768BABFBE51E1857BBF64BF1016215B6D65D6522F6960166C42B
      1B47E5E71F1C1C34F23513A8BE49F9F2DCC367E28E40BE33F29ABCCB839D5781
      FA513C44A02CF76276AEF04397B671784C2A61B94C31509E8770B1EC80E1358B
      3D2C29A0362AAFDC136A6559EA7806271F7491A40CC2C338BE223590493EB0B6
      F1064C0AC0F71036CFCC6ACA2353AA8F923BF228F537E4BE3A97EE1E58556A8C
      EB9D2982AEEF2835EFFE29D82B9C1E29090CBD721EC551E0516C791E64BB8365
      ED19A44BB3A067F826D8DE0AE1FF5932F884A6220CEE80A150CE0E2A4FEDFDA3
      637B8C1EABC13C13F91154314EA22CD9AD945F0CE78E4F9D0A14B1BB2DAF0827
      07962929032A8F9B3117D12B5E109B03EB904E8D78A20992A972612B17991697
      B2AC91180E648F16B1BDE5EBA64B4B42A4AFE47EA946FBDFAFE696B86754BFC6
      38CB72856B2DCD5B081782BC48F2719FC8655EDC01EDEFD9BC500C87404380BF
      A418DE44A948B2037DC091974E6334E6C0CB9083EC26BAA34C40BF1DCD9314FE
      FC6966BD529F8FE94C75F4F1282DF7CA459384AE425B18E97C128CB2BFF13BA8
      36515E560824535A9D7615B269C88B831187AE8D643C8AD43CF4E86054350C30
      87AC5A655F3D7AF73F1EA93796111BA5F73CA6EF0AEE8A62D81C3DB3EC379456
      2455515687CAE163E42BE7DD9965B09C7C19F21C4E29E72E2730E5A70017B0CC
      EF4D208D9839818504134E21B9F1B0DD271FCD226D153EF160D85211072EB888
      8FC1688027A5922CC788369F29C0998242BD51214C942247474DEBF2BB41F785
      E490B4BF3087E46B6B161D5BB06F1D1676E5F767173A04539F9CD00E2CFDD652
      6E746C97564EECB5A6AA9D07F592950B8ED2DBB7CE9611880A9A950BA3E435A8
      1991DB5BE7F13C190A9CEE65A8B54C27236DED11C99D28E512D932E88E275EDA
      EEC9095144790559927CE6BE05857626F468F976EA4D9637AD9A701958326046
      ECE3665064AA0E7EDE2BAF1BAA0B55C765B3BDF5861CECD6DB33A6163DE772BA
      0B3B5B71F7D2D17EB9177EAA52AEF326377764A010828A0760DD7856C9562152
      8D5B8C519CEAF74FC9555BE6A7FBBC8942EE7266031C051FDCAF9C56EBE91B16
      DDFCD81D2B08AF2B420D689897B1711D72E6ECFE72BA6BA92E781ECB31456F78
      820773504BCFB1C4D62512B00C5EC3F93A86D3ED3EA954B47288E1BC146E7EA3
      83CD28661343BE00BBBDA69C08EB305AE8A8531DD94CF912CBCB51B6A7F2F21B
      E4021DDC1D69A4BC062B47928ED8AA812E26459353AADCD03C14EEAF34A1D8C5
      11468079DDDE12C93A4FCE2FFD2C48585C01912C1E8FA53D878C34D28231A52D
      561F5180D0A1A0631236F8C00843F66CF3A57A4B9FC6F33C86F1B5948772ECC0
      80C3A67CAA2DA4E67D1C5C5305260C9F5ED6D4CA5844B61CF44AB3A8A2774924
      E644F199278ACE0B3F517C28D914DF4B9BA22C6BA04FF9FA8CCD911DB2D53BB5
      5B59325868376BE16F72909D6910CDD33C2E6FB776D8897874548AED8959EB49
      14242945433F06D793FB9838A1CCA261301BC42892B99D9740D780E3BD44214F
      EE3D15DCF183CCA852892156197EEFDA6F290D636F955D5BD9760B8927776CDB
      55863876CFE348B8D1F1EC1DC09D6376E38C74E3E1DC9FA88DD9A47FB5FB9DA8
      507EF7C2F8E89E59761A378AA67B7EF9721A0A4ED59892A294413B123718D943
      762B3D3859874A3772425A39E1C758B92B6ACF94E7D978386578F9125B68ED2C
      95432AB5E5F2B409F56E37F87CB0821F2F95A804BD6C32B558F99F3C8AD2CBCD
      B65AD4653655D11BC8F98DDC02828B8DA96E602AB731A29E8C13116ADBC51946
      00DEA150C6F95E8B6AE2F81AEEF3464637B570196B177213A50798AC2FAB9FE4
      C7741A1A080E2146B37B95A1999EA2C3E005D671CB23F73DEAD454B25798B55E
      11C923E39B4D38C3D2E69B721CBB97E6EE725C7FF9BA43A70D86E3580D0AF0AE
      083158EA8C50F6A18FAAA20A0A59D21C1BC1EEB4C2F6B9ECBD96C62C5C246939
      A53337E229A445EB781948781401A7B3257593C55298AC594D0FF4FF434F9B59
      4E5FB69CD85D5910BAE75C51255F75BE88D426A6E34422558020C7C1ABB65F36
      E892D37583995775591E54714C39BACDCAF8EC95C115DBC80F0FD2FFB5164831
      80EACEEEB37CC27CE84C594C92816B6523EC28E660824497A9280651C19FCAA7
      471E75D5BAD5C4EA37290498AB77A97806BE5E714D3F1C95577EABE1248E695C
      3E1D9722DBE73453EC45538FA7480B7DACD58116AA1A43310BD1A4703E9CC289
      337B2E27C8E8126D7C5F664D79FDE36971416577F200AD3C88263F6C69C95751
      06EBEF597087909DDBDDB55712350BF17EFE1CC28B636595F25435CC7A5C51D3
      A382571C3938051283FD3CF83D6FA4FBCBEDAF6A15DE5FE0A37D601DC92040CE
      1FF1399E3EA301C99A424108563AC510EB8487774BD572AA5F830E8E9C630503
      E73AA3148654119BCFA1F877082F42960A33EF9E4E162E9D69D543C9378B4472
      D7D34210BA3728D3C5150265CCF65D7AC2601A3058C8633657BC31FA2F38F71A
      3D9BDA167D1D782BA0D63D0C09832B21FDD946C3DCBF8A3EEAE60E5C82EE1712
      D159287ECD8F66B94418CD9323012E78B58A49F9CADBD1298FF71D174A791DBB
      2B1A6F14EC5594BF0FF88252CA95D790541C3C60C59202682D0EAC373858364F
      B82510DE4F0D3944AA7B7568C3153CDC4FBCF1582905D669BA3786CC04B18698
      23270D5E14774CDFA4A5A0AE049E53D21AEA2CC4A7204A28A73A657991B05912
      03B3A60593BFE2655EDE93D53EB35F49EBFDF3B01C814D5C9006889948D0944F
      49F5F7CC2895DE28D45552318ED82A9A16BCAEBBA6265A9E84544E2DBA64F951
      EC28A0A3912AEB68B4D4435A4AEDB3F2678AFA9F0A36188D441A89CBA0A8081D
      640C8557AC2A45F975CF15FB9CEF2DA769FD2528B1D2047AD4708597400FBD17
      F719922FA756DD8FB2EA1B279C5054C66128534E74511059678641095A6B545A
      6F4AB154C1A83474C15D4FCFD51A3C52369AA1974A0346B19C08DFACAA577159
      662C67C0F936AA688ABED04BE4F8521507682C25199601B146B13C70C0A22299
      5C544146511885420A0553C486F174CAA1FA11991C6153A75AAB79691F69679B
      78723FCDEB53C890144C1C28D5CC21D9DE29546795170654F2424C6731D0BDC8
      2BBDDD78EC419D47703090AB10E3BBB160AACF956938246AC2D102BB32370BEB
      23290C83590C982227E09C0298C19BCD547171BD3ED6AC2449EE8E8957E7C0CC
      753768203369B8BD85D1411E79FAA3FD58B5E1D8D19FFECE6DDA386979CFD2DF
      FBE130DDB38E8ED2DD521032F678E008D4159CBE24215A339FB7B79639FDBD87
      0D31F606D8006A6F886D1737C37B8A595765A14AE17E8FE025C75053E6E7D45B
      C0D2198673ACDBA5E627B7A71BF57FEF6434CE31BCE553442175D68F41943540
      9FCC426F28D2FC50D220D3124A4F435A9BCC1E91575C5AC54354D0D2E9228F43
      67B2FCCA4E4CE9C292E85DF6087360910C1AC7F8D7B91C4D55D70380A60C6A8E
      6D61E06F4659F903DC7460C4093C35074CECB29A47BE4C52F8D19B0EE60996DB
      7B473528542502DA1AE49364C819166C026A38400A639DF2AD4E5EA9768C2315
      454F751A021599A50BC1CC53ACC7442546974BC1AC1CE297FFFDABE2158D867D
      1331B78AF646CEB574DAB212452A7743F81E6D91A018400CF0444411C2ECAFC3
      7789E2F83F42DFAD196740E1234E9BE82D64E3A5CAAAB104D707264EA336305A
      409AE11B4B1CDB790D0B7657B1A92117FF721AFC8E5FB0AE67C95CE808FECAF2
      D9122BAAF28A3271605A3D533B2A309E2B6762B68B2A9988B955F89A66353C2E
      8411F855B2E219E927E92F956D5F65ED24732B09B09709760907D13E610CCAC7
      88B949EE1BAC918BFD4D249A4B656EF5EE9E750A683193AD8E49C20311FAB2F6
      261696E141F3B1B8161F55E58645841DC50BA5E9CF0B0E9F55EFC183B3E928C4
      6C6DCB4FE219D7F9C08D938A9CCE62AA2E0C1B9CCCBBDD11E4EC21430BBF77B1
      53CD643EC672D03BDA5A4BD99A5C2ED51B474106F4EEA2BBC82F14AD35EBB162
      3DB26E5381A5C86DB314B557660577007352F525C49DAB566BB9DA15D99513B6
      54E04AD895EB170BC7A716F778812D24E04A3374A81D24C2BB927500B95876CA
      F96FA7EC4CF0805AF53074FE18097FC02887259C656D5223DA1263A10E4515C9
      9660B496A942D7AAEC3933ACE8EB1A4E025138B23498B14BA5A38F54CDF1B731
      8874DA28FA1FB91F12C655DC7B6BCADDCAF8B4E697AB90FF32CCD465F880F457
      75B7FCE31B1F7792A1175EC4EFC8CEF4333043DDB167E577E3F7C5DF79B462E0
      71B3F49ADB5B09456E92A735C8D0A958F407AA631DE50CF9CA59521E0207B076
      B43790CF8868B5D92DF8160F646A117B544B8ED4AC58455DDFB067C926196436
      2523D0D223E818AC2218B362715E99A42F8D9D199736E6532FCA4350AC9448B5
      F928898727A67817A885613C15BA844F14FBA57CA472B5AAE22B30ECE0F325B6
      4CD1C65639064D7E21E9E806CEF5586C4AC29ABCEC47D9979A17AD571770F974
      490E953E4EBCDC9BA3574281A85912639791034B1C8C0FD87DB3BD55A8072F2F
      A3FC8B5078117520E0A4DA184BAEE3CD687BC6581E12022260A4659EEA9673BF
      11397F82DCB84BC50669EC7CD59191C42B4C979CA8BDAAF815BCA631C2022761
      F01FF4E1EFC846F17A613263BDC5AE2AF60E0F5401B964CDF5733FB41C757B0B
      664E95A18C31441816573ED5AAF4BBC754617B8922676FBCC26BABD4D0BCA3A0
      4A16834186E48A02353A1F66F3046BC54B13CE0E05E5C89AFAE8C02F9478F4A4
      E53EAF40299F9B882968B67459B63D9E31AAD34B669E348B63DADFA9D2F61CF5
      988AFFB12EB85DC2F616CA28A6FBCE532A8DE969AB918AD78C0A253256CD8BB8
      A5547246CF540C949C14C5A9A5736A69E61BC5DD8C64EF48CA1E99C9C42D96F3
      40B6166A10B3498DD521B1FBAD80EDA5C1AC6FFC6B8EE0E5BCA88039CE83F546
      C9E9A942D58A6AB2F17A61BDF652F19126A021AB6792357910DFAAD99421262A
      39B210DCC56E66EEEEC3412858B45C5FB1F3778B0E155CC2C33A3A79FB166706
      3B6F8C50170CD5A5BB4B2B64E93DF2B2A37BD6DFF6AC7DA6FEAFD69558A4CBFD
      30A45B1618C7B9248761D8D8D3BFBD8745AA98F726BA46DCA643DC1BA536435C
      AC3C5F685A2FCBC524F73F65CC54B9616A45A81AD3857525B7442E89A2EA47CB
      387878148AA14C41F78AC552F524E8FC722A0240174A73692AF4E8EAB94B39E2
      E439CEF3D266254FB4019F55C63F804D32628B737C8DBD3F3F60159357F42A51
      A9C9F7372A4A054230159E3110843FD0F1A806F4C2429C9B54CBBACE174650CD
      83D0A73DE6CEFCE8963CE8AFD42D8BF8C847AF94772B50E5EE52AE18ED538469
      438FDAA0480ED56F0C14D9023D9F3A0A04943D103B61BFA88E5153B15E79252A
      85928A8E3C19FE97C6BC0373D41CCCF4F00A543E6E1E4894B6AC841C89064C62
      6325E80FDC5CE533BD6CA91DCF19EBD555BCD1F3440CA4D837CC272F70B6B039
      E9215ECDA37C38A5DB7342D8BDB10C961BC5703DF671C409C5568CE1042E3B40
      5154F3AA17955D1853921D4A6F1AE1F13A9B4785AADE72FE601551C752EACBC4
      B5B93972D8B3B0E718CA22C0C171427810E32675EE05FE99030DE10570FB4A59
      60CFCF4F8C6E7C9C29B821A109368086B3DFFFCFDEBB37C58D6469E3FF13C177
      D0D4BEF11A76CA65EA02149E9DDDC080BBD9E6E2056CCFFEDA1D6FA8A42CD0A0
      926A2415989E9DEFFE3BCF3927535251F8327663ABB72676DD40A924E5C9CC93
      E7FA3CA83C652EE81F19AE7C5924ECB090247F5C1288A116412C165223088902
      3C1CDDED1579566C0D2BD18EF742D9C92C27159BC62927438E77CF2F48E38DDC
      2675253815BB5C1B0AF8BE1C9E7D82FD026AC42A041BACF0B6DAB66C49C4A8D1
      E1E2554038A5B3CC75F2CE12B286B57108FB8FF5010C4E23B63F00EA68200973
      DDACF3069B9A746A012DC2D4723F827F8BBE65A6D692A7BB55B63B2B3EB8CFD8
      B6521CE7C8D8EB253C72F49486934B323B0715FE9B967A59AF84C65695BD45E2
      179DA534732473C071C86591F41F2A2C6A6B973E931BE41F663EF8506BA83C74
      75A5FE589E6033FF644650CB67650CC054D8E4D458CF79A4CEDC7628FAF64689
      F7B7194D93657E768361C7E4D386E3FC89B456F7E5F8FC2CDC51755D33014A5B
      E789A1E3AC81FB2DCB55B93E48DE935F136FF7F855AB515272C0D16C3DB6100E
      7FA2A9784B1BF370B29FD2FC3DBA003ADE2BF4661B713A6545929A703587CA7E
      67B49257B9DF950922612208E79086A9778D95758B3BDC29DF7B88612DCFF70F
      CFC2E104FC9D9A3A17CDC731B23CCD84AE93A3BC1ABE5075B2041A90D3BE7A14
      B0258C25480B599B801D4D5CA5BB1E96AF8BCD9F938C4BDDBB30065FBDC45BE3
      C3004C00F7BD8FF5963B2A8472CE6A72EED3C3043A40D579A5BFF0C1B56B10E0
      39D3B389E36F1C84D10F3FE3C9409CEF5742F21ABCD026193A206868E3320406
      9DC07FE39E49298AE49353ED1CE6B7298F427AD28DCB066AD82A314603DAA3D2
      B080BA6134013264E0A64AC148699F6859FD4DC40E8F744369DC655DFF1AA33A
      93798E99EB4F8A5196BAE6C33BC6710F48B0B362ED7291C3B2D5B0D6E4FC9090
      6C81D45CE37235B0CAE6BC8B4D4BD6E1E0FCB84DFF1C89463F4A039F530D0A2D
      CC7DBA1C74948290D8D4530A1F803759AEF6C5F3F88A03496766ECFDFCEAE8BF
      CF9E6FF0FFBA835FA0326C5AA6646278F7770498DEFDA363DE2FAB0CD59B7612
      5C53D2092BC3751B2CF4174812EBB52A4D871E5CE94091FC69852547E94E4939
      D16B84411A5A8281CAA9B15EA654AA74CBD5B05A91F94A4B76667DB110F4E0F3
      814BDEA1F570DE721F2D5E073FDAF9E884BE05F1D4E37BB94F5C11D423BB8FB5
      4979E4769AD5155D0595427D35E7B84A4B3A636AF8149AAD131C53E80D331999
      30AC87C24855D4B311D58DEDB87370253DCCB79197325308558346B4D80F246F
      F0C873F2EEEF3F90CE3B11BD574E90A537FAE499FAAA518E915924DFA5AE5B2C
      AE8B68BA546EF7951B8B45CB350A49F2F81389212E5602057BA3C882FB4190CE
      9232FA3BF143DECFB514A17B46E94C6AC04917AE06A4D92EC6177171A7782FAC
      560B74CA72BD7F2A2299A06FEC3956833459E46B2CF702EF05658F7818074939
      DC58AA367C9F48FDBEE40E803D293C59F66FAEDE45EB01E768263A9E0547A007
      D7EF3E4E1147C7512786B2DEB09F85FA88E5EAFFF084FEFCC66477BF780B8ABB
      9611D68F419CD417A04B1A38C2D2C74EA7FC0D9388232AB053F8F856F153AD39
      AB109C3814D9B4241068CF150CC6161280E1FDF1154F8904B87C6E6119785096
      8173C99F3ACF6D0DDFB639A3F94973C0D6E6D79A05F43F7D1F3361EBC1B9BC54
      AAA1EE4B3DB7BD8CC2389E57E0F350CC12CF2EE9516C67D8B2A22A765F8D59A9
      5248B8A6B5CAD1D8DBBB383B82277365E2B00E6EB3BED4CD1F9C4451CA3F0306
      E01729DF5DAAE426AA644E5D7E3B555CE27E928EA4FFC4C631D854B630F4ACCB
      706B8E95DD0AA7B0173532DC07F9E49AF9D515259CA8597796DA3C89EFB42CFA
      7522CCE6FCDBBE148D97514BEDEF6969DAAFE57A76CAFA995689958777B565ED
      0F3DBBF30DCE035E0290D1375B060BCE012EBC91F3B4EDBDDE3F6BDBDCEAE1C5
      718BA4F6B71957CC7380782A01EA3E17D5E6F327B7F6C6BBB220597328B444F7
      93D45ECA6C8F23C97BB65E9C9E9F3F3B3A3DBD703D09F47454CED65A13ACE52E
      5A5072C1D26E5007959D65099C8BB1D73A476310D68FAE08E4AA4DE2AA96B8AD
      18E53F0EE5D605D768D416D52C482F1324A5D6A5B1D290E7D23AF450A8E2A152
      C53B7C32F1B858459B1FF0105BE965FBA1C9F2C830ACF5B2FE17CD2190A5D407
      4BCF8C184A5604FBFE6D723983BB03A42086DA774E539ECE408B1D65090AD2E2
      9089358558C9659E95BD14975F2A21A666E0120099D04FF94CEA5B9EA0243033
      7E7857ADA1EE777A9DAEF277BA22D52A96ED052A76DFDBC41EDDAC5DE262413C
      4846B39641417469BC4DAA7D1C954CB56D2AB3E00AB00CA4D0F7FEB9A783A1EB
      03A96CC84D09B66013EB6174138533BB28196EB302F7254D634036E54231DD03
      A3BBC2368FD5BBE66829D7332D65AF53F5256559BAEA3F925C380B0CC3F48D59
      8B09270143C89455CC988E899F20B34FC7D31519BB6B68F28982A8500D7AA798
      65B60CA1F27105399436AEEA6DBB7797B0121FE3F2C9FCCB27C9937D800BD0B2
      B8BD4A6B79BB25D4C4FD13E47001BA842DE79F6F967830EC5313348A64AB60BF
      57525BB056F52C24FF4F8A6CDD327AD89811875413EE6358AEF60F4FDE319895
      E1B065059DA96C15B5FE733699922E6F2D440D69C892FFADE1FB106FF4FE2878
      0D8F0DD4972E0273D11DA2BA1FA502E53C5AA2AB652AFF53E47BE2DFD0A19B93
      755AA93A6DC8B2FFAD35FD4BD20F1707E79BCFCECF0F04F7E774D046AF98CF5E
      A3092F2D2B2A7E040AC975EE524FE824709D6DE440907163993BC9C804E8BA0D
      ECB33FE2EEAAE67815C1DD25BB129DAC3660852C605FF970104270335768DE97
      7D2582B70586546B8375BCB533DBE475CF4B10F3116E045A5AC7E3CEBAB72B41
      B1BD9FB8C08D4F287F14716B587E351B8F633673C9C4B50DB8A87EF5D2D5157D
      BF3A24FBDCEBEA586EA5480EF083C02A80252FA5E4D52691DAD773DB23232008
      E4A68CC907E2E6B2284127BD3454241507E764F7CDB13837AC21CAB849484E37
      702E2E517DC4B5ED64B756BA05059A835CA7311C0D900809BA00AC77D7FAB278
      B9044C0610E5D27287B6E7285061E894E7D672400377E8141E5D49D318A4244D
      B2C10BFE8EB3DF2B57C8F0EC4B9CDD6FCC2BD3B1BAC7A5649F7B7C687F4BC961
      AD7393D7B45D6C656FCFE28650C98031940FBDFA457D1DF34059EC6B233251CA
      46A262FE3A5A598C2440FFADECA68A9864BFADE3917F85AE770D560E1A43AFAB
      74D6B43D68176122E141292AD6F254F848A1A4CDE75FCD0AC61CD3E0224F5F36
      9B2E6B21EC19A1C5BDC646FAB191D48577403C91EE7125F1C337009C5D6210B0
      B0DB953FA2374FEE2730DA25B55F05A014A4172C14B4CA259CE1B18EB79B27CD
      1CCB7D1DF79F3EAF567C79252FCD5B05579DFE84C85831DF619ECF43AA24C24B
      4D574D19042F9C316C97051E4FCADA105D4BED0FBC13A45459630B221670A4A2
      64B66C23FA38AAB2A5A1295274C22CF76B9533A82A99B23D065B87366D88FD5A
      8501F77E24A3E120B735CFFA47E6EA3CDCA70F2F81217071E5BA730050079367
      9DF64D519487F361A533362353DB7503C73EB7BF33BEF21ADB437E90D119EBE5
      D8FA69B28C637D74B173DD38488A0BDF9B7247160718974BDF2DFD5DAF55110F
      27177C9B84D2CA5951D98A875F031B6223D29E68B4AA6F1901EB362DDBEA4947
      6B18CA6697AA662399F9E47D70F30BD25D727F7C97CDE9D6B101C62997076A26
      AB032C20F48DF2935757EE3DAB9AA9AB049ACB112A5B7C19675EF0148B5626C4
      14990BC155D79183EE915A2D7D097B72E95B58306474BAEBF9DCA3175B78B143
      E5B0F4F3B5D756680C3AEFA2D8CFA4CF5D79B1AA5AABA304BD55342304D22B4F
      7422121C152BF70FEE955219FAF975AE183289219F6C7E2CEC9A56E640EADF26
      AEE84C1C490B695679D8BC36E459E266455F02A6B649BFF654370B5CE92DBAB2
      5D99DC0A6D23E7F7E88D3A341DEC4F005C906FB2F667EF8095EC39A95710A5BD
      560A633FA95CC50B9E3CB9C10F26B846F97A21CB2BB43CE87624A4E16B59117A
      FB480DBECAD05C954FF56D597892ECA037BC3FB70C1DC0AE9CE36CD165E52619
      0186B9558851036A22D2863334AD59015A52667D499DB284BBCD2EA5E346B2CF
      61EDF1166A2272D9E6B5B96164B654860E49F5A47164955A028B81766F79A2CA
      8B489A262CD34D0BD6088B95BB48F37BFB920FE1CFD156FA1E552D727F538A93
      8BBB4D260249C977BCA7147245F7821C35902064389AC7B47BBB2C693E725EE8
      BC01523DFE2BD261FB001DB11FB2084E13530E846E1381BB875CFB42DA9E590D
      CCBDF8AD20BDE99A91E46B4D73CB57919C1473C679005ACFED50AC81F0441ADC
      A9693288765922F4C30B4973FBC2715CBCC2D3775F74E49A4B5AA4B6381C57E1
      0EB77869C641BA448E1A3949D44B55BF2D8015809CABBF886AB4FA48ABF38E4D
      C39BA3B22184B87D578F09D2DD5CBC2E73C97C4BB4699FEB25FBB8AFBC445B07
      571FD6BD1089F1F308E9C94AA4E4120A2C4B679757B5154B9BB5727B07966F51
      443EB0C26BE076AA1EAC54EBA3A4D3DF66F00D13C93E1DDD3D756D20AC520442
      9CEEE28422D29AFBBB55F5E5DFE7E6F72D8278CC37A545C8583DF37BD12D949A
      6059676973B792FC66A29C98C08A15455554883E2D9A850F9F708C9B883EF52A
      74E12C635F165444967B26D37605D548F8644D69AE686DB2F074B1CCEFF875CF
      121E94F8880C2932B55BD565D671DB9AB243C94789E24E5F1DCF6248194C75BC
      75B3122F96D56FED561A4265DD42AA8E417AE8E7DAB072B2A6580D9549F9B2FF
      BFB0701DD666C0209E140206925E1A4E33A27D9267D49E0373F767B939A9E512
      F5AE0A4315AA44BE19E5546F5D96ADD525E4AD1DFB77B50E1011B71A3AAABD54
      C355796C5CC569551DE4AB2BA6327A3DCB3D074FA0B68BC6E9C3CEB232F323B8
      316A68D15245B589C3FDAB004495E6D5D21B636F8C6566616F9DC4FC7C4E5A15
      A02DF850B4FE493F1A3928B133549AF66EFEFCD79DF1C25889065B16955226C7
      A676E55D6D5558AE813A9F45924CB2D803B944066BC6AF57815CC6ED9CCA282D
      5E67B5730DD6721B7D7051BCE0782B67BAC095E0FD68E269DB3B31EF67399D97
      34FD3F44C58FB3511BA5A13005DAD0EF74F465066156FFD22C13B7B2B7AC201F
      02519F0B9C3BFB19A579B75112A6B7760E6CA1F4DFDF011119C06B2CDA770C41
      ADF2F5E6473737AEFE57EA258E53BAA74FB70B47FCC3C63BEC59BABFF7EEC968
      FB1DEDD77F2C98F871F4B4BF85D9D9EE7DC60AA061FF35E021D30628DEE3BB9F
      B026E2BCBBBD7061E0FBDFC3D2C08EF29E92CFC48C2157F80D0AAED679DA90A9
      0637AC2A061A11C2DAE5EFD005E5C0C866E729D1F80500D9D83EBFD4008EA9F0
      B93A7CD66C967034D0CF1B2617D1912412F643D89485E5398ED46F89914A2FE8
      20A383219D324B4DC555B2022B93D152A4BCBA2235BE4D93C6EA8A9E15BA4664
      A6EDDF7293DDC09C3F337EFC94EDF080390D38B0C216B55C2F50FE70D7546C40
      57F30ED0DA854AC488A50524E9C649C79E9E4FBD8378C2D9C66CF7F593BC76AA
      565484F7DF405F55734DD0A2C94598150C229BE7CAC655D6D9A7C965CAA5CB33
      00B0D6169D5D6C4BA3E8C3F328115AA125F846A2EA7D1551F5B61F12556FFBEB
      884A54DFD206AC34C5092861AD43C6421B5AAA8B85298EA42E4CC77E532D8D2B
      6315AD7D062A2CEFA78790C4E22C3C5C95E3C286525987DCF8512CA570735CBA
      36163C4FA5ABB7D7FA8C545B48BF952669CAF670F6D172877C951D322FCFCFDD
      24A5BDFA5BED93F2090F6C95C37169FB2205883C0B99016939CE3566B11A7436
      3AEFDBF49F1EFED3E974D6258922DFB42DB7362C2B7962B6A7D62436CC816D89
      812BD9F6AC72AC69A194EE6A2E818A947CC23207092AEA9C701D26B832E12CAB
      443E56D6A8565D6626112F92EA2A5A6A05AD1299A77377CC4757F4C231C74DB0
      E8AC30656B5576143712CA7EC3AA47653056ABEC0DBEA9664A9D6AF8F9FD2FB2
      2B4AEA80A2DCCF8C58AF4A88C9BE6A345A6840E5886486FD9D013338CD1C22EB
      1C43956EA7F24DA24A8DC934468531EF2B3B36DCCF9619D38D39B156D57CB827
      69CB899F88D73C7F7FFBA60AAB6EB96EAC07818D2FFAA7E21974BC97E22D888A
      C82B150C37CA67084A6E8471DDAB99A9495CE5386F492E99543FC525D8C9D9E7
      5A11E4B667A463EE960AE3636058DC6347E3A4958A50C9D27628CB28EF0BC75B
      93338EF7C04DE4CF716F2CE8E45AAFC46891E3BD228194697D8093CB533496EB
      E3748E26B3893E9516F9951F6B3D92F633E84735DC163D20DD7DAD25E138DBB4
      6B6719EEFDCC70EFF0BB0EF7AEAE9CDB45F1941753A08BC992AD4412B0F994A5
      535FEE7AAEB8C0AA6363E56A0DE12F640B51E981B88EA0CC384B2947B316DBEA
      CACB88391D3594584445ECBA90D7AA3876EB25E3425DB2B6EE73A2A5A682DB80
      8A87BFCDACB94B4B69C49825FE2455F4049D354B0BC40FCCA35FCD02B4153B1F
      DA1AA7C91C2EE8C2371A29F20B685091B9D37A859344FE0129703195B0D1B21A
      2EC3FB8E83962419902E4E6AC2E5C7885274455AB527086E15D750563A311A25
      D5F309AABD9EA2806884FE3A4D00388173039F2CF8CE6F2EFB435B325B8063CB
      3EA8B2F699ECD8283A19696AC35E6FE5854A240236A4E7BFCA9D40A87AF9D0AE
      C57C4FB3942DD354C069F2AB6C965C7B79EA395E637B5B8CAE02D5FCA197FA1A
      8B6B69A23E90D2C4042469D9A5CAF828936941C7507ABBB4572B6D3F1F11D5BC
      D368120EBD3C7331981A81E83D4EB99A5D5BEF91E3B687A56DF999B6E5CE776E
      5B92D2E6E24A4633823F5E92DA0A97052D1CA6AE055A1CBA43688DD9CE318B2A
      CBF6141949C58C4BB55F9824BA4CCA4F53F47720EC0A6D791585A1491A77D81E
      8EC52876687B0F8AC9963E0BEBE51576AB95DB7ABBB251591AF25D9189ED136D
      986C0EB5BA3DB3746426AC52047DE29A39A65D1401C281CCE6D5959A7EFBC0F2
      591EA78BE74DDC3D8E151A5A9462A230A0366379D74C1357CDBF84477F389A8C
      1E023D575BFB7591BE71225D849B5E82E85A0490D11D478A27B9095AF35C5BDE
      BED2CC8A5ED8DCA815D52B22A198CFFC588E898E39369D09DE1EEA660195BC60
      7EA5B5EDFE2B4A72885EEB2A8D5D131E19FA396DBCD954A2D1B789776DEED685
      099786EFA8BB2501A4C683BC932DEB77F107F28167522B826C926BBB3185361A
      609D6ED8A8B38CAE2409E67A9DB4821B5267ADE511448EDB829F8EBA30D7F925
      72E0062816C352757C2A97DE6E8C53DCC7BF1C65A4EB68DD5B84C6653FF222DD
      F011993DB4DF0517289B99051677DB9B25B9D6D5E36EB96E583A4885E4375F77
      A9637E7035F24CBF729D1697E817967CF50FF673C917BFF7019ED47658E0DCB8
      32558C57BB8FF8F8EE39BAA29CCEE414193185DA884A34E687174439E9C5FB9D
      EE16FDDB1DF67BF49FDEF66048FFE96F6D0DE83F83CDE106FD6773B0834BB606
      5D5CB2DDEFE192616F30906FE3125A59DB7C9B8D9D1D5CD4EDEE6CE0AA6E8FAE
      C37FFBDB03BE6EB0B5B9F59BAE341AFC6F8D60B7EB792FF07F2A67FA79CFF376
      6DEFE0723BF276142BD3AD7BBB85AA6CEE58B8CB65FB78CBB65CAFF83FFD4DFE
      E756AFB75CC015B83ED1F31C048D32410258B3704965E4D3FBB3578F7CF20AE7
      0CE32323E2AFC9F9B4FEF82C70E9A3A3FFAFE919FB0D062BED3F9A1412CB0285
      2D621B30F45DEDF45F5AB88BE5F8B2643C6087E562E9EC5615D06952FA72853F
      6A0BC3C0FDF44C664AAEDC91AF3DCF8A6E9ED62B150E814E5FC510D0CBC89B3C
      51989367980DF4CC57CBA2F4B232257D6DCCD4F2892193A3F0025AAF888BD505
      94BEFE5A0B8C2853C4A9E042FB826BC27442DA5097A56995B84FC687A0A80BA6
      F0E3D93B263F3BA41BB53D0C892CEA5C2005E4EE4F72F76738BDF2BE13749B56
      70B02B805A17A90607E8D583595E569491CB2DE475B37C1978FFCCC03B5DF73D
      07DEC17B7702A5FD1FBC5EED4ED0150FBE8966CDF76E11FFF18D1D0A6FE4E68E
      E52051463220B43E7773F3F4DFADA2A29FDC28E9E7370BC0D61B32D43D09F3ED
      A7B7C9738926DAD13E309310CBA2F12E8D8DC5937068C18A031C43A2DF199C51
      B1B06AB2FC045FF47F8509229870C7303B5E4F9F61717A6B4852AF7BCF14A859
      96ADFBD01E94EB72BAEA29CA651E995617E7059DF4EE6415CC2E8DCBB970193F
      76370CCBA73DB2737198E426FB06B4E70F0B70649877BC44F41627C44A6E71BB
      4CA55FC606465FF22D1373CBD545955BE47617B4BCB5702E1ABA2E2537132553
      D22CC369ADBE214A18413CAC26301E9D0F0C74888F4D2921B91EA9E6C09AFDC4
      C5FA3587FD4D966B7DB786E0FCF9D89AC545D3FBFB7D79667DB05F2047B306C2
      A7C8DF7BB13F32717EEFC85A9E58AE32AB22A5B5B281CE06E7A2AA5B5D63D596
      71D579136C95A100B0B9A24BCB5CC18BFD03806B19169C2F147041A534743E3A
      9E54D4B03CABB89B2A00278C4069C9C95DD383A5E3CE5358888CADB0DC539FB6
      A7C4C107CD713ACB0281630018BC12C0299EA9454754FCF9D6CFFBC64C7F113A
      7B9A7B9B7D7B869C2350A996C0D06E0B72CAB4C2A3E7DF93DE5A4D7C22EA7527
      462025652518DF3C722CD2A7AE554DE34ED25BE1331493F4AB3145A226687D6F
      EFE0E8C88B5657A4BED8F7DE9E1DED73A0D63B3B787966EB8EE5BA754BBE6680
      E4EC6777B50817F34C2ADB220253F7160E2B1BD7A89719144FE4359058078212
      DAA60231AA54266A5DE58B6E5E217A94D5EBC862E0312204885471A513DBD66A
      D80E15F45C02AFC63DCC568F5B2C2BB0781682FAB6E6146184489AB2D6AE33D7
      E9DCE397CA66F166A820848BF8962A424EE9D47593B626F3322A41C3E9802CEE
      BC356868410375D54E82F36EBBEAB137B394714DF77E5A67A85228961286B4C6
      5924E7A4091FD3C96FE2E26D1D267F252DCB244779758296679D5BC81F9491B7
      E63026ACD5395FE9AF009BC84CD84B1654066A46597313B84898436C57CF893B
      451D2D1ADFB648DD01C00EFA5FA528D85EBAF667770CD83FD9CA23DF627597E4
      ADEEAE021ACC20BCAB2B6465735F5D1030B118B726EACB4D33338EDE97C8E253
      D70614CDA7A10A3A658578C1308898841746785FBA111BF138F6998559E8E0C4
      20F6196E372B6C44429EBC6EAD36696DB7D644CD4CE74A46DC5368E1E8A5EE4C
      5112AC96D2D48351C421F4DE0C8C5A9A07E25ED0C70E79F9AD10543F97DC9965
      40E0393C39BDF014F5D94FEE4A2E3E0145654B63A2589265464D052ABF4559C9
      DEBA641EFB980E53CB3398B3DBBD3541A5A35F95B47A7D69C6CFA9B6FB226A95
      EC89B5D260CBB0C180BD0FCBDC19F8764BD8D57B522114F18BB91D834D6A5FC2
      4899A43258540B221DFE776DAFA83D3B8726B27064373E08FF7873C334B78D8F
      F71F57BBB3F272D00C5E32443D7A25A26C22EA5B39D7B8F83F60018C2BCA4591
      8EA199ED9B14B67156BFC9B0F2979165AB08AED248F8225BFF6D724BB2D862CD
      D93A49DD1FE686AB7E6ED927739FA2C38E76E1FB57315B3E32107553D62AA2AD
      0B8B3B4FF46BF75F63DDC2BA7C58E6E5F394F3A31E8994738E7112E74FE53613
      E0D55C53ACD5CF520F929DE3B285BAB759E3116A2B3D42ACAF920AAF46543847
      4A4B2174503A03E51780185CAE7A7A5A2993D515EB06D2239468AFBC536EAD02
      7B86DD97B3959B34D0BF512B7A4FAD6871FBEA3638DD72EF27BC9358EBBE378D
      6797515295ADEB739CCCE22A99C6F2687AE068E2662DB51DC10287ED7B707EB4
      3C7F6C2417AACA1E050543C9CF1BBBBC4B9D9DF8EFDEFF79F9F2A5D0C4902E9D
      4C2581559ACD1301CE1893595D7EEBDFFECC5FEB3802A931D9EC75D68722C522
      27732DB96F68D7E97E9696DF77B3BDCE8C3235BBFD457A7B69DFD5F7D7540394
      001CB6E78B5BB6397D87F91BC85B7371934AFEE2C3CE2F5B250FE9B86FB75FD0
      EDDAAF848684EFFB8AAB275129C4A727730B3A4F99E9C07D80A8A167688C26ED
      8A0D218690ACB525C0C4C751854D42FE78CC34E178AB896163080BE3F464F7D8
      D5E4346497FEB66528AB2B4F5F46EF5FC140A37D9504E69153FCCF1EB9ECE6E9
      495A1FEFEACA238F185AEBB1072D75F058FDF527734FD0EF7082178FB632561A
      F86F53AA5351380AD1E75D8A3E4235542558EB78C2B92200C7C944285E153F9E
      69EB2607E7C7D178897AF9F12A96D89F4AACF7844BF05DED8ABF84971735EFE4
      52EDF850027106AAFCF9E92F5E7E3719A5B1A6A3EB48B481C858BC1C4763A982
      47F82123036A4AAB56A21E0A9D226907204EA75949F9E80A51D8919A4EE3C828
      6DA4200AD0D34B781A769B26FE9DC6AA903B4EB3CB14A1AC3A16039E8B1E0F87
      1EABB6151E12A46C498DFCE09A0955B28EB726517A8EF2AFAEE436E2A4EFE671
      9C037E1CF75B25696129C72A8532E6BDCF3502F281FDA645E7E6FEADA8281BC1
      C991139404B9A163E9E372065BD068338D52F3C760C4D606C40C0158384B93A2
      8C8886A66DEB886482EC4C080BF1BCECB9EA87D6314376A749551309E0DA810E
      A33A37706AC9883DB0F3C617FB45E53E882AC25E367E92BB165C54E769BE25BC
      375796DE701E64B2D24A84B7AF267178A5BA41D80157A8816505D298C2E8260A
      6764CBDBA5C6D463F5EFCBC5D5AF3B11AEAE2CB8454726AA5CE574C7A0DC00BE
      DC75AD529CAA73A908EA0A2F29181A3E974EDC7B86932CDF4B60200D57E27353
      51FD1E76244E608C3510D91626B776B4A48B964F5B3B94AA8CA2A518DD169612
      DB309DADAE8CAA8BD0D6589A3CC28A42151C579D7101DB8664D1AA787D5CC921
      D9BB7C217290A6C75078A8504A7E9CD16ABC13404E7A03F77CEF7E576C22893D
      898C2BDE015EDCD5AFA9BE2371D2AB2EC1E63F4E375168D0CA130FF72554D08F
      341FCBB2924AF167AB2EA896D3983642504ACDB64D968861115812DFD7B03FD0
      6B23E8380C5EA0E7AE6EFBFF60DD5B839BC427D29D53ADB7AA4D1C3E38162ED3
      3F7ADDE5BAFF589370395F4905E4A92C9CC855672D7781DB05CE8474601B1CE2
      9ADF00B7F6E42B53592AD6D515350DDD79F060758AF69E38B2D7AA4D20A04F35
      E42B89DF09237A7A6DB99B6B6FA5452836B5955ACBC1F8C15565DE717F7EBD7B
      77C0C7CB03E5131BE2C66445B3E9AD55336C12B8AA9925E4ABECAAFD85C20191
      4E24E66466D8500ED8C4CFB05435968040B12F204ED2BF49572BEB0FD6EDEACA
      048544972039BE2CF7ABFA7DADBCC05F7E768FFC8583EBF62B0E892249B50DC0
      7EE2FC1ABAEBA536E3773768C390D9ABA9636960C0CB597B9556C425D9B479F5
      ADEDCE57F0F3C097AE2F777F8BC98E88EE7C270423990A67A166E1B8A32115E8
      E77959C28D2C2B35E93DB5A14CCF5224DFF23BF28726A8D56AECF67EA0176C54
      06D9BECAF67E8A3747C1DC7C94ED2115F3D5150CF3C2B09E073BAE0BBD2DF589
      3BA51F3BF8FAD092F8EDFB5ADDEC97355DCE205153F8DC0174DAEA275A3A1C7E
      E5B24F280C25AE17A711DEAA7AA7B5EA53A94CC93BC5FB828353EC49E7D7D134
      B74FFB817B43CAE7712CA566C4E389526D409E6A14BA2F2DB3EE1FCBEED12C1F
      45C9B5F7CC7B793A401F0A7E5B6E7945A8ACC8C45650E15C7E39383FB0CE6894
      04F12C2C8FD2430D39D982AB9C17271BE428B53E1D48A599DEB9CA1FA8F5655C
      15C9EC81FA071075B7E7AA26CBCA6A2D448BEE85F778AF21B6E5E6F8C300F6AD
      577E71D5624422B5F1E164E887B6450926852B1087ED649F12B661D5F815AB6A
      81330202B4548AEB65500F7250564AE79D6B04F78174908CC1B701CE9A09E32A
      126A64E6823FEEB2453C839807D4864B49C2C85A668535CBF07E65713E33B2B9
      8A846F720EE085686F5C7FCBB3601E841531E589C4B4BFEBA3F1EB82C959AEA7
      FA8ABDBFDD68F19CB9DD008234BBAF98AC4FF6D50BF2E3508C4A7F39829AC896
      07D62795A3D86C5435F522FE71990A1B47EF97847DEE288B516CEC69891D2A9B
      178AABE2CF4DFCD0B599DE93B6AB66B77D81A43B2FAB655B8789546006BE7281
      81FF529B11B41E1C3CA3B7D58AB65982E75C265C6B747871CC9932CEA9582C9A
      CAE768A99D055738834BC5CCC5015140E71A9E15E5935265551A09350187209B
      42A9933C74726BA98E45036F3B3624EEA8B24C70F762CAB7B61D41C3D9F3A928
      52A1AB2B50A20B5008E85D49A4E86E6054F61268401BB9DCCB6AEA6B7407A250
      8D716F94BD5299C97115B75A8B617C53450AFCA0BCDC7928926A912466193848
      5B0B84A2A3604C435C9E7B6F8E77F7BD5719A20505E7A3C732F2D67991CD82A2
      85A04B6B97A138D3D595B167FFCCB971A90F9C18ACD5AAF7C04CB01FBA93BB4F
      1B00FC78F96C141519BABE64E50BAEA091C249567C485A979D608785B5EB6AA6
      14908D30A275EF3CC8A2A9EE98CAF0AA01D3D787DEDA88AC0880CB702A1340FC
      997FF92479023C1597399BAFE33F4CC6A94B719088438D026186C51CE116852B
      A64079F413F78EFEF77432794AA2789D9BECB9F79E5E3834EF9F7B77FF1BD06B
      4FD2E4D38AF9BEEA38D722D9E01BCB74EB4744F59A7D1BB8136976B8CF50A9B1
      7F29A788CFC5CEA442B93D666911087D55E25D1C9C6F3E3B2757561DD2672F4F
      B7B7BC83FDC30BAB862AAD4838C84B64A3B6ED0D736443D32C4A336D3D0AA6A7
      DA98557A67AE9C45CAA16C5FA2D8177C731C6609BB7E1919D336F4343273A7BE
      AF5FEE782FD0F85CD49D66A9DE71EB40A257E03511434208B8E560D3883DA77C
      B3722092566356AF96EB2FB3292E7B952B88DF2D7D74B2EB2F11392D32E3D309
      61DF0171A95BB04F5821D2D49462E4B138B7DC8A615E081C81E722F7F269C2C7
      285EECBC14E45B4CF8222E769272F41EE89C78BB5A411787FD69A32C55CC2764
      B6A5EA2CD0864BF2F79EB1BCD17D41CB69A95B1C14BF582CA5C92AB160C9063F
      20C4E8BE51133DF4B6D1D77B5FDA5C8F7FB29785A062FC55A012D6A09725E18E
      DACAF56A94ACDCC735E885B217E8E36B74B9CD3F02302D563B3A688142B58689
      383B85ED4FD305202A09E09681CE356052B5BDDDBD1FCF244DDCF68E764FE8B2
      573F9CE9C527BB6F8EF175BEE34DE43B3F2165D8D4B5F54AE49219E6E063AC2F
      B589B554445C6D8BF4B5C03DABCF15A448BB68E0E6AC12FB56D4037C09E1EFD2
      19D63496B53A5C0FBDF0B1711FBAB4B930B322FA5553F62CFFE8BD6F7B7755F4
      FD5A5F5CE1100D73E3672888814F57C1299057474B7B24B59D350006310C2496
      2DDB1BD50316CC649D971707B8A5A8A07E578D4E8C39C028414B61DD4A0CDB43
      B0052AA90B275DCEC1CD8B78E1A2B6DDB57671D71D6107774643C6D7C56DA63B
      786B5C1B449B4C911AB9F220BEB346599D2B94242F506FEDD2CC794098B52AF5
      793C8B8AE030D26A48C89788169E92D7EA097D75E23FB4E1A54DB95C11DCFB18
      E9EDDA0C22C091125A7624D4C866283460C3134C6F91191724C2F7162636A4BB
      1FE123CC5099D390D22D8E4C5467C089E591BD65D6698F7FA84E0C59E94B2083
      8FB9CA968053036D4E5BD0EA2B17B93418D8EDB23C8AE8696F57570475E543AA
      203146D4A1327C72377645D20A74E9F48038B361BB7ABC70E8C27DC0B7ADF2B0
      219891093297C5892CFBA395740654310937218892178F8F939DAC5C44ADB016
      91C07F55898E66976AB9D7DCD369BABA92AFAE4425D467A9F24A918491548C4D
      2CF94DF991557612CFAF7C5B8E403E005C89AB450B82DB2CA2E06A91524AD0F1
      5C0779AB8972660A503ED376D987624FC752027CA1ED8DE051E30B3818F10998
      6F320130D303B2B6195657E8D85DEA988F1C00361F52D2FD22F0BE8044972C35
      145FDA369B9CE3F733A4F83446B4543DAEFE6C91FC9C5658630310292332DBE2
      28073C533D2DA51A89A44C5B92EBB0116FBB2F713167D461AF729B42B749F754
      22187CD5862DD47BBB662E5617CCE954ABED3EACE003A34443E1A7FC5CACD2CC
      D96A02DF54BE056C33C5D9A63B4B4158195B28EFA8F0F5B5F20FDB8555925972
      291BDD01DD7A3EAEE9786B2F04280297F83530E14AB366394631D344972BC444
      1D60EB96DE6236754D89C2F620452DF55C1F4D59141835E22E0D179FB85A1F7F
      E136C22762DECBB182FEBABA85CA6F87714C24EA0D0317E78236DD8932CF2B8A
      BC56B663D5ED5C7B6BFBA18682EAC9A402B5D5825CA6636F4D4E089A42702062
      BA45E94B672608C22A853DF61B9FD0CD0055BC54C61F83D6C161DCB252BC92A6
      8B454560CB36EFFB0D6A567AD510CD278AD1F6615E31A2AB492C909BBDC51484
      F32313F8B0E3A282E90110ABCBDD855CC97F85A23955A7A273E6110F6A8DA416
      9F5D733864DE89435CBA8B9C495FDA301F9EFEA3D3FD1F68CAD4A05CEE08DE11
      6FFC8C01F2452A8BEA85546C2878E336F6E41A153F264F933F2C17DC07A57B7E
      C529D7540EFA691AA99383629009E2FD5C2E4206529A2DAD62598EC7D23D9597
      26888BDCAA8A454877CCD80259369BC2969893B0167CAD39A30DB1C013FFA466
      FEB8A24F68FB2899F14A0FC149220958CE70692757E5C14C4B51F6CA7FE06D5D
      B91866D74B03145BD906BFFAFC23BFAEBF96D8E075FA55144B5D27B8ED82D574
      7F2DD9374E698E2340B6BD80199A87BE249AB90154706EC73E67A025814C4796
      7E1FCF9361582350CF267244C4068F2E1386CDF01D229B2B52435580A4DBC91B
      2998E915DDA9B86694A5D762AE266A9877BCFF4E6772E45D73A07A04DF8413DC
      B74B43F0A301AC3463E4096EB93FE6F23AEF59497AA27FC16E397B9D607D081F
      CB6E1C71098DF75FAFCF2F9659A932C73D579939D7830139AEAE94802C5CB588
      4D311B55D326BCD7ADA48FCE2FBC3F57CAC645F437393EDA3BA78F8011A46D50
      D5CF8EF0D951AA395FFE64FD816C594EDE2599A41630862D47F78ECA3F5D4997
      55D78A143DD6578BFDC6038409AB2BF8AB2EA725E5D5A7F96BBBD329E94C2935
      E5F6618BEC5DA9D95E6E43DBA355E1D89DAB5E2E09D8253966E1BA5321774B47
      E97B0D8457897AF9708EA309FD88AC5C545683EB5DEC7779F7260F53AA7BBC13
      E85453F560414E816F5ACB31D6A2EC2EE6214F6BDBD0B5CD01EB4BDCC3C16A3F
      0007EFE7D70E8E6BAE021FD6877FE348B0BCB5737B5E87511ED0BA02FDAE7EA5
      ACD35FAFBDBBE80F0B3C1FC469AEBD60BFF13B57DF5680D7D362AE18469F5A7D
      739537BDA58D59726B2B0357B46D9D92C08AD1B75757F07D6ED1B3997C64CE31
      DD4F727A8E096695F439DF5A6E850CB63CDCF5ED23CA554B39E4183CF21733C5
      B3B78507EC48A995340FCC8FDB2CD5E747DC28963CDB91CDD397BF353E2D0924
      30E45718E4E80522F3707C1CE5D80F6BBE418DE373EFF076841FFE44FB502EC1
      6FD05ACF912DA02BE993F3342BE4C3FCB9F7224D6398F17FF62EC03EFCA7C76F
      528495A398F389DA24E4C88CF4BDA6AE85F13E5532FF30CB12A65F2E03EE1601
      8D6C184700C174155A10F2C815150BE62D5F5B5DB93F636E4E2ECE79AAF26F31
      1BF48E9292B508DD56846845D237E42C13BF7E0779212B6F4691944026A7A485
      52D10B84C0C3AB2CBB1AE9A3538ADF6A5A5E183AC1056D76CD570C339E17FDF9
      13A7E1ABB7AA7E33811C24E16788E311B093E731586117C038D1B41C1271B66A
      56C807BCD16C3402B63937935D7165BFA930B75FCD2E0D525D53237123AE16C0
      E5CFC48AE07A3EEEBB24AD8106B52A1867F565E2E81A5645947F02C561791215
      EF77BA5BF46F77D8EFD17F7ADB8321FDA7BFB535A0FF0C36871BF49FCDC10E2E
      D91A7471C976BF874B86BDC140BE8D4BE8B8DBE6DB6CECECE0A26E7767035775
      7B741DFEDBDF1EF07583ADCDADDFF4F8E335F0DB2ECF1BDFE2D97895F63D5E98
      7B9630F64F7AC5083BDA5DFDEC197962EEB7EA6E2FEFB3FE277741E16AA63CFE
      B2D49BD29CEBD577CEB7A09558DEC17D671C71814FE51EE57E5AF8409384F697
      CA8F4B73C7AA233A20996BE20021CBBD2B135C1FA5C1F5639F8D9FAE92F920F8
      EA4AF9BE145E27F1379003D90873DA983C4E4E4D2A2348807783FE94C0185761
      CC95F3BA4A92B21044A9D3D415CFB9A33C4FE31BBE33E2EA28AFB88DB8094B1A
      A22DD1892D73019950899232AD547A3D7E05EDDB348BC3F3A91F98B6F704D512
      3FBFFAE5495B4CECC79FAFC7EFB95D2C836E7BF3F3A4F0554DAAB9550BADEE73
      1B4766D889A89451AE3FD831708B41E5189416CDA3D2E9ADFBE3375A726A99A1
      D9E80D7262DF4635D2D8BFC1A04F7CB4637E8B61ABEFAA3DA2B432AE05A028F6
      2F73008C03AA9C5912251AC6A5C1B5F23674112804FE3230F44151BF985D2E31
      61AAA1F3794C98CC2894CB6876592DEDE01222CBF10044B38849569049063F25
      4E65067B59F4351BC9B4157E5C2165EF811245853F73A5927F7F878F103AE7F9
      79378DE928D749F2E64534279CFED7510AEFC824BAA2DBF7DF8523FE61E31DCA
      B8E8FEDEBB27A3ED77853FFAC782D5338E9EF6B730C5DBBDCF584634ECBF063C
      64DA0BE4A3D1773F6161C5796FF1B6C3F7BF8FF5F52F9BDB03EF2962E7C13517
      1D03D7243579F2A4103D27100271F1C7B2ACB3596B8046B845233C2BF971B916
      0203D4D2E612BA880B3C000373A9D578C08299BABAB2E68C789B46BCEF17FEC2
      F1FE3E46C96B7787C6299DD776D172DFCD3403A3318756C9D10E520E0603E81E
      8047D312118834DBEB8B974F871E824CDED360FA7C568CE957817E6A9A44FE65
      73D82779401C2E33A9E53B7E762D853DD2F4A3D9335E08AE4F8033768D1B31B4
      1733308B438860BAC405B9EB8AACF998A9C5820235506B391F9DEBAE86172C48
      A8E1CDBDE23675D19E504AD35C8554B77152D9BCB72F3223505DDAA131491320
      9FD8568A1835CEDA9721C5D3016D1164CAF3A89859CCFAC689018AFFDADC8D52
      5801655D4194B0CAE369C650F2DA91D7B85142D9BB3D3D4A63209225E5CC8F67
      D8DD6011D37AF5C60D70883D6E278C81F2A4DD3F0A9034E4DC554A0278925775
      7BA3A774A73A62BC348DED2ACDA25F11348B95010428C001226DB9CD7D8CD2A2
      4827933497AA98BBA68D7B6783C60D631395B5A49D265A18E05513C2A191A38D
      5340CA8A458E370283B41046805168DCB8718AB5501A080E5F85A56ED59092A5
      CCB659035B5D5973DE2AD70DE5D2F4F2D425926DCA19113BE93CB3E74E1065C1
      6C824EB5803B6D2C48A696886B91B546867F2F6291B28567ACA7F1C32231C5C6
      52FADD44590126BD5619956C95E5AE3678BEE68AB855743086F0B590FC8386F9
      F32439814901571FA25AD0F610DC113D6886BAFECA21AF5C7BB7BE607674C41F
      C8952B8996526794FBCF3A23BFE701A524BA31CD5B478BA5413ECDB0F47B10A9
      8C55B5849E958240209083E8E32021E7BF849725656AAFF2B5C75E9612EEDB2C
      113D20A0CCD0416139869877915B19C8424ED14D8C3E8779548D860CF8C135A1
      A1696DD52EB7092889A085E83A86BE40F9A72579451D25DB1142ED5A48DFB109
      AEB54F5B606EA519878E2AF9A459F27A485A09C350325F7AA5B6B86CA57F5669
      A3BF9BD215AB2BDC785E6A5F55D1B6C7D4E118F98E1EA562C878231373BB3BB7
      31364C2BFFCBD6C60647D8A67A5CF95E423E873AA0FE74EADD288AB244B19B35
      BA874F6B5711AEE9F0B4029CE00E5DEEB14727BD5E344B8A28D62A455B87CC48
      751C62A75F9B259D8764F3F3CBD3C12FDECB93DD636C851F8E4E5F4079DC6669
      D306F8F0F47FC8FC62DEE0FB5063825C032B8E978535D1B8BB51D7C48245C5D8
      78B2AE9A25BB8724C745F8D2BDB4375F30B2C609874A49FD7ADB6B9DA470FC76
      E3B8B5BA526E2D9787B58D5A1524640E0936ED307A78ADEDF2DAA8888C915718
      4AD1B58D09274E19AF5BAFA31C8008700D403EB0E998F1611D4512231A44C3E2
      230F0989D3F168F8758B8386CB4D6D0D33EC1F304AF66C48F68A461FCC56570A
      AD45107816E967B61CCCD20DA35C6E16AFEB4E1B749227C5EF422267B401D289
      B7FBA67EA0DE56FA871A36CE0796F6C5E95EE9B0D415205DF8364AB67F1FE394
      954C6BBCF5924C47287C1BE1BB8DC2E28A012B4A8459A5455E5DD1AE5997CA22
      F33D33BEC2EEC937B9231F776A982E78F84CF8F1F0E2F820F7D6D45078454E6D
      F49EFECA48F9C0F4F0A407C33B90B4D63A5B6267AF5F79B13F32B18B26699D7D
      4A429CFC6E84B3974EA638E8CE6DA3A6DB340AF25AC165B450877BB2D2DEBA95
      D62C618828E854B8278C17E0FBA13FFD087809FA3B0DE02EF7F69474985605DB
      E59C357A469B249D2989B9D81BC12C2F48C992A4260D8C903DB03E2C444E94E7
      33C1CFF3DEEFCF26531978364B381802475DBA42B97B58958E637790B06CB344
      F270441EB414F4F612F40B389B32C6E238D5540BF40C99DF028202971EDDB064
      B12B7D34E71C0530B95912797891D433E85AFDC990AD889D7B539F564D593C14
      8D055A2F8E4BEC30C16649E3B069CBE4C138E25E1C49CD3F8677FA1380758A12
      6EED1EED30164DA97B558423736573180C13EE73E73AB7B73E7A3D35CA851EBD
      CBED77B2166E47A7E331ED77549AD1E199EFD1551CC320C342E0F2321F5D7B1C
      19664FDD924DB3C2E594EE1DEFA5DF89406689403508530A6471E3C7AC14053F
      8A8FD92871D75D45122A12159A0BCCC2E52C5352B96EEF4A6EA567F6EF444A95
      722D2395476B7FC6CF0A8A9528BD2F19ACB45C044AD1112C85C671B8D28702B4
      F8BB314A84D5A4CDFDD3FC03E23B7B688E87B48EEB496069C8C239544989AFBD
      8AD9EF911D57A57797FEABBB7426D0151514619B5CE63DD9EFF43B5B7FF8C31F
      1A96827858A66F0507E4C4DCB213BDC00DE0506CE5189793ACF23D44CF347D86
      5B70BD9C19179C32AB52A35A1891D67E0A7B81EF2B749812F457C8DE96CC0EB0
      69CA7CDA82C7F2D10992F22CBDCCFC89D4E0376B5ACA49595DA94FCBF9F98133
      AE5C71824C802ABBC5D49BDD5AC097972CE464AF1D0C9A2AA0394DF0C6E20A96
      38CB36FED3AC113EBC33255AE30556BFA5636FDFBF451D4716764C3ED172C5DC
      1B4876DEC1B121B421AEE9DF66685BE03BFC5EA47295C60E9C5DABE0B808F0DA
      687B8294065560EDB00782228B6DD1DC7CEA19E745593F5543266D88B41EF459
      2D8E9330AAD108A3692CE48A0EC2D2C248892FC7C553F9E3773032241413BB21
      C18F177CFC0E46A97B22DF0B0EAC2E12B61F9AE89F3EB4244AFE10AE82B5E5A1
      735B22AAB9A3B439A25FD17DDEB40AF7879D745207DE1FC55787803809F8A340
      A12F387159003616CA31F21A46BAE656189292559332C4E0EE3201BF9BE4346D
      93A74A532CD552706249ED1AC63552109A452883BAC2AAA09073B10F268F1482
      8E5BEE08AE2108364B761F38D4A1849F6A7999A37A73F5500BB8212A2440E5D7
      183C18E567BA0E9D955DCACDDED909D832A75436FAEF45AA0A6A86C555052E6C
      2FD46A5A44E6D0324AA9FA151059AD536250C96689E9A3D640ADD2B75C1F624E
      D6F123B9537FCC7D504D53FEF7C4402E5675B558BC4CBB75AA2EBF4EBE926348
      8F285725158E7907EDE22AA566C9E55FB6BA5D148308BA2B77BB6317B0ED4C6E
      C554F21B25CAA7F00E356E8C3DEDF4B4870D37C61448631E9C835374CA703AD2
      4982394FB9C4308BB820A459A37DB0FE32F3F32B69F6F48340F307BE375D5D41
      25A516027094872BDF65D1B72532CD36135D6BA48677EA23122B507323C3FE95
      02C722F2E3334F80A30ED0E660EBA143A1B8E7F8B633A5649A2AB4F9D897176E
      96EC1F3E935A3FEF1B33FDC555F0AD9D6A09DFFF207825EDF6EBAD8F76F6A0D2
      2F4ED36B4940DA5824A75B2D93D9C8A8C0D5F02C8088A13CBB155E2FC69E8205
      DC449082AD2E5AC05E6915863AF56968A6587145E6277175548F0D1EB3F155C0
      6306C39A802BE03183E1C3E031D7264378A8BFF55942D7386A22E485E2FCF73B
      BD4EEF3F9AB530BE3D8249EF3B473079ADE6AEED3100906D1A2258CCF51CEFCF
      0FEC29D869D6D4CBC01C97E0C5FE6EC920DBC89104291DB6D274847130822B50
      B44EFB6DEFE5C91B71042BF3D5AC412AA516A998CE46B3DEFCFDD6C0AB626E35
      E4B585F28F8C0B36E76EFC2C12DA3CF67E3026A53F6BD6A84A60FC46BE3E6C3F
      8B3CF315DEBCF795DE9CDF13417EF7E63C9671CF4B3F7ACC7607837FFE9CE52F
      7FEA411BC5370FE0F4F16DBE87F376370C2B84AF5CB4C2AD28810566EE7C9538
      CA63CDFB4BE4420ECE5F394759F98B4D70952821B3828972D504B9D60D332296
      F6E38765287D8A3FA04F1161A1C39397A7C25CDDAC69A669A0CD57F245C3CDD6
      FE87CC4860D8DBDB632499660D0C2F8DC4499A2184A021FE062998E5C1F2C98E
      1CAADEB048AD2A9634AE98735C25B87FB4D7F64EB9CB1131CECA2707E7C7CD5A
      D64BB5FC11B57C7170BEF98C75B3F5EF5F1D9CFDD4AC49A6B3A5FF8C1CDB5FBC
      93DD37C7AABC9A358483240723816F91D3A5531D3DA888D6E6CE5769686042C0
      8F498D64084CDFFA9C373397525885D8441A86CAB8DBB091ADAEEC2B57437897
      F89328200B5D8AF3C7918943CB0DAEADB29613C7F726264307FDD42F82AB8EF7
      166168D41D164FD1390E87DB8FA595B276B368ECFD6AB2943B3339BD0268D5D5
      951C507CA958D5B104E8996D07A8D2AE7E4D83FAFA6049997440BE833C4B9C4B
      37375201A895885008894BB9312D2593DC729CFBCCFBCC6F45EF53908F32D67A
      39BD1A9C5569621A66BFBF38DFA5077B371B9DCD66BD3802018FCEA1F234A73F
      7C83D2BAA9A3AEE32537F5A545CAC28A4995FDB5F14651023C9028A4950FF752
      6BF26C232A374371491ED285F2E58EE0385FF9F995D1D63C3F0E66319F895205
      7BBCBF2959D08B9729B0E2E3689455D9D696C9A27F3259D45D268B3ED3AAEC7F
      D756E5EACACFE7E7076256EEF19987F6827836F2F2D914496E6F0D8E853A20EB
      6D98004044AE78A0300AAC83426BE591BB15FFB51304C1E3F3E9404B356B2790
      FFB0F98CE6FA17AFF583495012C05DA6A7A3BF9AA0C85B9E266B8483B4614373
      5E850E62B78801A0346DA0FDAD2861A7031D4AF340175657CEAFEFB268E2BD39
      E3F4E54B402DCC8A017E57A5F29C8CDA44DB9CE1D6BE39C301D331EF99ED8C06
      5FFEA18DBF68E591D4803C25DB76F326C3DF9F8ED301FDE46C8D86CDF5EA8A10
      AED3F1FC1C0EC3F069487E15390057E6BD1F9A209A903DA45826CA761331A0F7
      4D144A7F5CEB05429A4AE40191A51948E89447AE25CE485B4A89F54696AEBBEC
      B26350FFA6498EABAA6BF8F52E5F112521AA351338479328A61707DB7D5BA367
      5CA34F2E5032B30A42AA88619196F74B93B861BDC5AD33930BC5C72C28669969
      DD1FAF569CCBDFB9467AEA27C6F2C14D844DBBE2C0FAC95DD34A8057575A16E7
      C6E6E4160BE2CC361186DE8B3BAE15BF957AFB1B3A1A63574AEF127B5A73C2FE
      08E04D9B2616D4F67A6B50B6FF4346C0FAB13F3D06034A96778AF7056F96F2C3
      FF9A99BCB800862B7F482B0158142804E5426926C5101C0F0E7ED9DA3C01C5C1
      5E03DA543CE3325278107255B324164DA0675DF8C5E37452D44083E246617D46
      B34B2969E1C986EA9B686D6EC3069454EA2958C9BB90EBEEAB430E2C942C5D7F
      CDD3A4ED25D198D4FF04B1CCC88FE9C7380D25CEB08C077C593C60190DF8CC68
      C0E0BB8E06FCCCFEA19AEFE72094A1A3F0402B14D5766F9A45A0633A3F68AC43
      A52EA1B851DEA09C88260DE203E7296B716EC277F4D9CD1ADBEFF9885D9E905F
      7442763BFDE519F99967E4E6F28C5C9E309F3F08E129B5690B6425D02496C77E
      C1497FDB012D3144C76B1AA49309B475CCC5823690D8AC91B7CE95ABF893633E
      CD1ADFC77DF1E5F1F4CF1E4F4B17EE738FA7ADEFFA785A5DF93D5BDA5C04E9D2
      7C555D7F19A7B7CC0B685015D2B051B9FCE54BAEBE73FC25325582BF6D7C8EA7
      D2D01B39C6D5159D3BFCABF3E7DFA451987B97928E66E080CC90F78431624EC3
      D9940E3224AA357705923A4984E56DF6B64895A925A63576806447089079A618
      9E8931BB8504B784B244F07A79747CE1D1B1AC05FADCA363FBBB3E3A4A35B4CB
      D812AF5E1CEC3612C7EC7793BB7973BCBB8F88126B43339916771EDDC4BF6BD8
      30DEABBEC748EC39F6E27CB7A11CB37634B4CA749129FE2860160CE0777CA0B8
      08C20B3D3CCC037F6A70A8356B9CA409EC398D2A9ED3BEFCB63C36BFF0D8DC58
      1E9B9F796C0EBFEB63339F0294A9C1D17E69F951A6E7D8F8D78D7C7F4B0C4F5A
      182DCB5C8BBC7FB87BD4C4B18CE3D42F6C714D063CDBC679EA7E78E37375D571
      1A72F778EE8D8D8FC2B4668D23CCFCCBFF1B92FBC8A7604B1156B8B7641E77B5
      550B484434693751083C7746936CD6B0415DA5BD358C91C921F492F9AA598329
      D3990D6ECC2C07E1E15CD49A68249D50D1A0690DB9E0790B947779D199FA5894
      1A06718124545E3372202AFE06FFC3657F64DEFD0F197CEB82B583C2EB664947
      89D5F33C0D226E7EB4FD8E10CBA337DDFD6B0735EA24FD47EEBB6B7FA3A10EFE
      970C759CF61F7FA47CF07C8BC12637DF60B020864FF2E6A9676E88235BC73BCD
      2EFD24FA957CFFB56E9BE3D0BD75C49FC742E35B902FA954ABD2B0BD28FDFCF8
      6C1C4F27A9BEE3F37FD31F704CFCFBA3370E3769CEC74226FCF83DDD4CF2034C
      72B0E3C551503CFA3655A382968AA24C376BE6926FD28A7FFAFC5BF6E1737F93
      50F5A6B3623A2B94E586BD1558821AEDB3E93870E74D6601E29958E6D2FB4BFA
      D99F8051E891DB7C5B24BC4EE7DD3BD2B04EC1BE7B47966FFEEE9D6D670DBDFD
      0818DA050DA4B540832E55D7A294B37874E4A55E45A1C64F0A4353CC02F58322
      B590264D1B200627B48308C5C7B407903F661E9F8BB38303AD04A3B5E252C98E
      9ED82497388F2D6E8B45A96F9804E6F3ED6D8CF15E81D8D37F570031FAC13586
      372E59A1837D6BFC699A3CDBCD2669F66C773299255A973945DE29BF32A668D8
      3A7675132F4EF72F9ED13F3DF6074AD61ACE113AA46FE9E657D2D85B362B436F
      3665D56D8D05D05EA4F1AC817DFE2289439BDEDD3F7DF19FDE1589236E9C01A2
      43395BC03A131A5070941C62D576D365D6ED9FCBBA6D74FACB42C7CF4DBBED7C
      D769B7D59528CF67C6DBDA79CE01D10999AC81609FA9193387C8C6BDCB6384EC
      953F0D25619E3FC155B8DCC1AF0129D6623737ECB41091740724132D998BC8F6
      79CF1DD9CA24232431AA714E81F24B67C3A499E3DCEA3DAFB0016769216E0B3D
      2CC6F9974D4AFEA1B58A87838C06AF91B2DF1F9EC47AD32CBCABB4B836777915
      FCA244B050188CB54777730FB0E91E3B1EF194AD9B289BB451203AF5BF41C4F4
      8F8F1E83E1B906CCE33708863FFD46A34DD2C47C8BD8FF630F374A483115EB4D
      534871E89D5F45E342F14DF3C297AA8CF7AB2B6C8A2108751D4D99792F65AE38
      D5537425F99D6BF053C8E9CE489315B340511CC48A23BB945E87D97FD0C72448
      AE26BF2E909B27F7AE61B25A5DB9272DF6CA2193D39F3EA8D319863711566F16
      E7542D1EE0D286C231AB87A260F60209B6910C42E63D7064CC8303B32262FC5C
      FFC68F625BA8D048F037796926AE8C727AC73B4E185D92A1A6B54034C7E22472
      230F9D741AA9CDBD35B43930E9359BF50DDB0C60E7FEE31EE090238C3289EFBC
      135435E0C599663A8EA6A3D40757E5411E3083BD347B081DB7EC8B660DB9DA96
      A5C8D376AB2206A9FE4A3823C376ECC7B965B20076AE20546B039744E5D12894
      37CD7E55C428295A310CC92368786D5AC693D47B22DCE18B2F4371CB93668D77
      75E5814AA40A8E51FE1C414C6174603C3F5BF4B3C67BE4ED7ADB7B9B66E4CF4E
      01C2F5224B6F73A49A77E3E28F2FFB0DDBF5AB2B6E4EA70860927B0AB2D934BD
      9EF8D9B59E695A5CF7DCE3F1773B9D4D9BC9F2DDA56D0FE3B79F5DA6DEC80FAE
      9B258B4A17C11883B398D76FCF8EF681FA98DA344D92DEB6BD2769F2A4A2ED9B
      35D4FB8D806B2343A3D520761BC8DECE31674F3F6FDCC2D631DA623B1F0909A0
      2CD2E99ED0C146E7B5F0F7E631A0FCA5A591B6F6343600F4D4F3E02E9D650EEA
      2C1A2BE47FB344510F742F38F4D6DE5EFC78D6E6587EDB3BD95D5D7973DC96A4
      C6D49FDE65B39CB742DBFBC1140720A366EC77C79B493273DD5E27FECD3177C6
      7A6BC5959F5CF311FAD734B90DB79BBA7EA4118FA5B166C5A10B621DA3432253
      48428FDE1CFDE0AD5DC6E9C88FF923FAC349C7BBB832CCD7F60424DE9E21A109
      70ECDE4FC87A1660A7D0A265ED9DC5BD0AFE92C453A4529411F5E86B95BED986
      8812821C5841FEE5EC877D1AEFC8265652EFECE0252D3EE63813C3BA89943448
      E623D7CDD5669954A8BF3ADAEF55864A73F76A77EF27523B1C2E44A96FD3C688
      7CFE8B5717FB5671C00AD07AFB511ADEA1D2A590A43E406CE8CA132F69DE72E5
      619E19BA940B30F60E8E8E784FB21D70298D14BE6430384B386E2014BDA8B7C1
      3365B4D242141E61D5FA397D797E513931BC35F67B9E9C475C80A476E113B58C
      D8461A8FD79789D22F4D942EDBFA3F3351DA5F3CF9DF4BA2D4E45325D551DE56
      942A936A1999719A9116C927CD9A6FCDFDF5B79E83C2332FC8D5F3E8C4CBC6B1
      A2BE93397899993CE716AC40D27F0892C429DCABA90D99356BD436DDDDED6F3F
      F7C47710400077C6D3D90766D3022C2E703972EFF0E218FD9C1C38A5D3B2062B
      9318205606F471D2B8E219699244D11E9F0843F4A8656CD7E47F9BA1F46994D1
      A230C57D896852FC3262575BA266F8DECDEA8A627832B8794E5E45C774BC9FFF
      CFABA8382FD2E92FCD12D0EA0A074BF647F11E17FAA5499D4642CA01688BF897
      0834FA23D44AC4D839E6065288EFD89464AB3F55664301C06F98AE60C3DE61F9
      6B873073FFDE96111565C0C0084361086C988F0D2C0DD1F058FC56BDDFA1563B
      28807B1E5C49A6ADB8D28C095BC6B9ADFCDE1417120674E4C7AB2BE55738C7A2
      8B42C2D2CD92CC8311D7B6F7FA90AB7CB2349E0BBFEEE63954C7C44F6877646D
      FBFBC8865A796B352ED6AA01053939FEB2F7FF9D796B26B11552BF229BE8526B
      FFB15E771CE1233778B0AF8E0FCF1B0963E46288130E6FA5A33CE52A76F4FBC6
      9573FFB9777CBAFFA24DFF9EEFB7BD973FFCB0CBFF9EE3DF8BF3468E79A60CC7
      477BE4C5575D40343D99B07272BF3EFFE9959AB2CDDC91EE18D2962A4EFBD14C
      DF18CF8F231F794E1EB547A737F414347733472A665B05D3D0B2DF7264AAC13B
      F4C9BEB8884F942FF9CA709345C5AE78F2B4D71D6C0F86FDADC1B0B381FF3D81
      19325A5D31CC8ACA8A8A661EE11E6D4C915B21464B5ECE5FF68EDE963BBE9142
      B2A99016E23CEFDE09EFA03702B849DEB2C5B7F31990DF47F2A3CA206DD31552
      6A8C0DCD8C01CD1BD7A0D4D2152BBBAAAC693D33765DF3D04F747CA2B05EFD70
      76563188E89F6C3675A4737E71759901C554E8C3FC9BC679D3B5C12ED0CEC73F
      1CBCE4850A3B5074D35F8E4EF79AAC8EDC705BAF93594EFFB5D9F6BF9C1FECB7
      48F566CD0B8A941D9D3234499CD7A7F2E4D5DEFF6B2F48C22E79B1BF386ABE44
      F5FBDCA879F7BB8E9AAFAE28086E666E9E9DD06C1E1B26604544448B1966096D
      A18EF79ACC157F0C638DCC38B6E67879A4C2ACA965EBC8D7F96839CAA2CA7E6B
      C85A3937406AE5A167E66FB328035CA03413315C4BC83DA6A435C3860D4CA6D8
      A7494241C943602C9845F0BC8CEF5C87F813F89E91B45271AA162BA15963E730
      D66E6589A2F294749A91AA4329A96DD8985AFF399B4C99072575169AD8284F72
      DBF2364DA7B329B7BE376C70070942D3CF3444CD3D8F646E4A6B9F56BB376C44
      47E9A56C21E4EE6F4C769B45F4D209EA1BFAC72F1A3698D5959FDFEFD3F2038F
      52E1C7A4190363F9A533445751A9022FFF2A4B6797577488E00FAF6CAE92F6E1
      958F980F7775E4853F9976BCC3C29B70286164D015339EC5B8AE4076CBA3DD29
      88156CE8354C5816D3802EBDCEEDB959413894E65CC09D23E255B2D175BC571A
      1FA0FFDFFB895B0338BBC7B9A94ED30AE01795C17CA0525239E081707B712CED
      CDC853DC2946E7FA639AF15F60B8FFE696DBB9CDF73C6FD672F8F63679EFBBB6
      C94FAACCCF30DD1AA6F54E1EE8FE582BE9D23373398B7DD8D5A05C671CC4F506
      8EB29A5C5DBB38F2476462867096DBDEC51E1A978E68242FD2F74D1BDBB9AE3E
      ADA4F203A0DFD1A1CE5131DB8E2F19626EECFCE34B3EA2605A8B57484A9DFC0C
      43BFEB498746A7F5C61D5C679A93CCEF92C27FEF5D91BA88A132E02067AE574B
      7D89E5B124C712C8BDF2E591F4994752FFBB3E92DEF85924F4A2D1AF68472FB4
      531B590206876F98823B9D31168EA4E57E07E339942878B7B7D9A67FB6F0CF0E
      FE197A6BF8E7D6CFBD16CADCB8470B836E2DAD685557C7511E2CB5D5676AABC1
      77ADAD5657F6D0553F49C3681CA1939A51012753BF8846511C91BFCD86CC28A5
      7FF60D8D30F2FE72C03EF85F0EFA1621330742669ECE3274A6A3EAB0612A4182
      BE2FFCDC9C60242ED490A7DE2CC92548232C6B6CE6291418F8A36701F84B34F0
      DFB461BFB82BCC2E86E5C526B9A40926A723432C850B4FB606DE282AF26522F0
      4B1381BD9D6522F03375E6E677AD33798649094051DC445A593D49A3899F9038
      BC7FACAEFCFD1D230CBE1BC7211C9EBFBFFB57FC88EAAF477E55EFC7FF7E7570
      767478F293D7BA2A8A69FEFCD933F7A69DD0DC447E0240A60EE9FC67F4DF6717
      26DFC42B3F3DA401E64F075BDB3BBDEDE1CE56CBFBC73FFE8E416479FCF02068
      C2170E6316BF0BC6BD2F1ECD178DE01FB4AE7332586561E327BC2DA99BF7B405
      381174B7BD317C374ED3427F0CD2387F8F1F4C1226572633FC7D7C05F53DD80F
      7C3F59CD41FC2E1F17C9E8AF8F7E803749B5D8F237B499450960267DDBAA199A
      20C55E5A3BD3E68CDDB3E3DDB677F2E6FC1085CCFBBD361AD84F9B161FD2111F
      DCD0A282C580901E43377997E82140CAE6705F6A7290368EA35F7185F4643472
      A42F1FAA1A63CC021BAC15AE1347A5D6AC916ADFDDC6C07B4EC345974D0A781E
      E025907988EE4A06E3CA27DE1A7EB8BC4AF3629D737E2E93D738B7D9761B0E87
      34E87D01CFE7C01E1C00A0EF79531F00F9693C9B9057101540AF234399C605C2
      3B0696C72ED7762A6F2D9C71358CEF5DF902BC90193A4F19DD6A34BB5C075005
      5D1F016C1FEEB8F8E2429FE3A3A0AD61F2D335D3DD21F159B89B2BCE58FA6188
      FD4022CD73EF2F476747AE3DED767545F8D900FC28754492D78370D2DCC8D54C
      C947471D59221937F126D16562513B6C11EEE1C571C304E6DA5BBB1B24324E11
      5480CDB85F8F01CF72E55624A51A85DAD49877BCDD384FDB6CAAB5E6BFDB82C3
      0AC00051460D93CB69A58440C976906EC0426194163A510B34A9F1469132B391
      A1C3041E4DC386AA1AA7872DB3BA229B66CF9F920FE0409CB5B235115C40EEF4
      E5FE894A876F18C197874948CB62DF68BA8DBFCB28E0BC7F50419083660C787A
      585CCB98DF3273FE654EECD677EDC4DA999590168A67D88671061A87FDC09D14
      428C533F27DBD46B81FDA6E55D9B3B3A929B66C1200B5DC157B4D0B00D1C45ED
      F87AD408DDF7ACA996C9D47F464B6D7FD75A6A0FA9888C1D85DB285E5D89D9AC
      B195A1C683BBF59E46CDD533E489C1EC41A5320A970B209DDC18E62E4B691077
      8A8830325751D234E5A5B6706F13B6B0853AD42E51A17662301BD4DF0303A661
      A373B67EAFCBB6BE2F6C1C8A50928EBD33B260917316FA3546026537912CBA33
      C7F6E120C1399A14FB7792C8904E0CD8C1E23CF1C769424ED409332AF19D4BCE
      90BFEC1D9D59AFA92E596DBB6FAC6C379E75BBF0DE4B896133D9964D019C770D
      2BD2CD51156F9CA6D7B3A917CE3886C5ED2BA1AE4306D501260CE3CFCF92CCC4
      5103CF56EB706E93905E0801A0962DBDB67C8170ABF7B5DEDE892607F2743387
      0ADF4A3C4AAFA5307A127F6DD10A88ADB9D43CD7B18C1E40A3ECBEA936E3D600
      B2180187763FFB9192E4ED78E71285C5644F68D3D3D1E1C7B6A9879502F487E6
      89E33BBB250CC778E994CD9BB6F09DB436A01FDE70A81AD8692A2FD1A0F0A0F1
      DBC1F931777077BC177E707DC971B992652B8E26913ADE4C154BFF7528632A27
      EE5169AC84B6F9049690B6EFFD6D66F2C21E177A3CD158325FD0D4547D8C33FF
      12EDFDD2554C67D2C858525D3A4F3EBCDC9AD8CC6165B545B23A20DB344BE75A
      21B557101074823EC5FB10C990C4BF99306473C77B19D14E7B8DCA0A248710DE
      AC84B9E0B59AF118C56837B405DD5E44AC58825F0201D330C995EB0C96DEA91A
      BA109CAC34BB92728F44FA5FFCA75DC58441DB878DA097AD461D6F5F761DD230
      6DBBBE22EE5604B657F4AB094BE92902A4C4D0D007DF30F159E12164FC268D48
      12177753A3BC09644A22FD309D1AF2683ADEB1882297CD57DB66FFDB5DE99F12
      6C4516C9D2A1FE4C877AF85D3BD4A537D0A72DF29AB3B0F7722B72DEA3F04D15
      75DB2A066B10D04945367ECA40A2CFD917D84307C3581C36F6BF45055BF7A2C3
      08FC85E4F31C9511BF0AB87D9A96D5B77A86CDE7D515E558566352AB07055051
      E19A7C32812EC1BCACB44D21D3905B4140807C79C72605C3D4E42CC29C431857
      A67E5F5B79A9A727FF46D29534468AD807095A2BB4974A6D59BDFC4F6BB36630
      FE76BBB0965AF0476653DD142D490F8FD2F7A4AE82AB349368D0282D401D0594
      7C52560D533BFE4D1A011E4CDC2860F006401043BD8D35F848CFA61E37448766
      34BB441CED51FB177EA735BCC3650DEFE7698EC1F70D81BFBAF2168775811A23
      6599D2533342B6A0F013651934E467A259931406932F597E49B1914AD2529CC6
      F4137DE6C7DE89793F630FEDBC30FE847DD2FC2A55D07D3285F6F9F4F7F36BCF
      1F819A845F438F74524BB349C3E03C1D3BD12B65245A93623F1B675B77BC2CB0
      1C25D13CA1E3D8064EC44884086CD7F33EF9B969324AB3C4DB3FDA6B96345416
      2D6044798A6A79B8DF5A5413A961C8668DEF02E3D2E21907A7B3B08E86C76AA1
      C39B35C85D6D7F821290B451856896FEA8B9A97FF3861B1B57CD1A1AE7D70CA7
      3040E91547B43E833466CF2F092D83A02DE5A493805B839AC99FBBBAD2AAB303
      392028E9744B8208A692F861CA2F79B47BB20FE2B937C72C0FFAE1D02DF235E1
      1FAE130FAF77BCD3A442BEA8F8608C812646445B294BA35F1BCD467C6889F516
      E2E7C36A6296562D4C595A9D5F6A756E2FADCECFB43ABF770849B50D5E6BD23D
      8CFC38E584647137B50CE60C0ADDED0C9B35F7AB2B47D2BF629E85465B598C37
      2BC6436D7B41702BF3933C2E5B7EB419A02D702177AC652713818F241D8AAAC4
      F322E3FD00827B295004F0A2E62D8A1470328AAADE2C712982261D1A62493C73
      398AFC3A9AE624913024E34951D097BAF48B75E9D652977EA62EFDBEA1BF9C2E
      7D71BA7F016D4286081BB6A1B75664E96C845A3F8EC8EFFBB7C9E50C58B4266F
      9A675D6BAA1B494DD2D9EEDE81D6670B36C1289A321B0C7B9A9A4738E4780549
      C9413B64A0879FAF7B111E278D80900DE73AF216DC54FABDCAD4BD043F1CD062
      93C4BAAB956BCCF545C3C10F95DA7006F1E292950A761519FFF316EE925BF48B
      D5F2E6522D7FA65AFEBEE1AF546191A708A639AE77027DEFE1ABFD734BB3275A
      AB69007735FEF5FD0310116B31D7EED1DE8FDE1A4CF7D6BE115018D61D4835D1
      21D46AD891533F582BBC6F39234C6786093115E190AEE961474BB33EFD7B2AC4
      2038A2EC5983105ACACDFEC86C9363E349E37FB3C452CEBF3D3918B1806B8712
      A1AA7623C75AE0B38297BF7F63A525C36FD6B8DD7290953F02D27465668F85C9
      E8153BAD6B96998E24C2DA7DB0CE051028F170B57B00924FCAE0B777E5E74CDB
      5B0B1A35443842CE6EBDF9499473410DB31F3597E4E8410487F35707478D6465
      5B5D79C50D8C4F478C6E55462FF33B326627BC715BBBD329AD52E98A6C0960C1
      1A971094BD8235E30F3CB860E12BD28629F896B690CB201BF6EEBBA479EF7E35
      DE517A29EF8FD07A9699A488EF6C9631FF1AA838BDAF34281E824FB77383E261
      8E7B5EFA5183B23B18FCF316257FF9534DCA28BE8917C74EF936DF8365797E7D
      9745136FAA29E638FD1A19C5C79AE5D3511CDD20EC79364BD024256AE65596A2
      240044F497DE3FFE09D4B08700B7BE743CF3B861CF9F3DBBBDBDED24A86B98A4
      61CE685BA98EE919FEF26CD01D6EF53F0D266CCEEBFC2D60C23EF585EFA3823D
      2A26D86F357FCD52EA4B9FFAA3B5AB92754587992FA5D579EAA56350E3305B21
      0E4236C7615FB74E912869C175132BE6051A6391AF7E96199F6E3E42A3B433DC
      E985DBDEB9F91B4359B53DCDE27092A6ED9922E834CCBC79398BC1B533855177
      0D401C0980669E0D0FB3CB7EB10CDD7D69E86EB00CDD7DA69AF9DEB1A0E7B2D3
      68F0F0C8D9038135EDA6181E133B845A04D929DE73C924430E083153EABD383D
      3F676C470E1859CFA9592BA50E657883CE4DEEBAA85019D356F8AFD7E7178D1C
      1738C5954D9C751250B466538E5A8D0CD0C35C5D5805F0BF59232DA3561CB29C
      A4DCB7149B4B3FB8F3CE4E768F359B85B8DD9F74012BAC917E22CCB88868D2BF
      C7F8F7EDC1EEAB36477BE9F43C3C6F6655AAE569593C3C17D963111CD3B6AD46
      F76649EE8F8DC473A777655FB70D88309C23CE09D10F0DB31B4097FC8B779272
      7E424B01F70F778F3CB4B84F1B16CAA3F5EFF8E3448DDD676367F656FF324CE3
      18ACD0740B2FC8FC1CED246034D512772E81E758995A9FFB477B0D1306DAF5BD
      568925D4528253F01D00F444ED66A571E5A0FD388D71EC4563ED0A80C90DABBA
      6107992BD804CC0DD91D77E5414E0BE0FDD64023A00D9BD01F6976BCBD8BB323
      36F0D92411835F1106406981D53D2E5D81A5B9FFA5E67E7F69EE7FA6B9FF7DD3
      18A841A0718029F2B174025838286C1F89B85603ECB41626B83E7FBE0CB17F5E
      887DB30921F623A82C310EF3B6778883A1ED9D4F0D19080D9A6E7AFBE7F5976F
      7B3F1A9F635D05FDFCD20FBE56EFC5630DE9CC0FCC73EF473FCAE8FD0FEE4C13
      A7654F68934CD6A4973E3352AEDEA4774641B9073AD526BDF44FD6F94E93E7DE
      6E364933F2488D3F45107A773249DB504A4B03E4F76480688C064EEA33F6BDDF
      726CD164280F8325FF7AFF4C9C2E419401BDAE77EBB3514B66489EFB9762E60B
      36231D5BFECDB16087356BA1CC855DEF79EA7967696DFD0EADADD59517AFF62F
      9871D416F2DFD10AB7BD53A1C49C2530C3F800CCF241EE7A52C8B28FC6DC815A
      7878EA8C76034AD45D81ADDC8D7D61DCE86B44E31ED1822317B48880732718BC
      D541E1EF248DD0BCFFED43D68F3562E4123C5F91FCEAB0C3E5C079CC4D1B545E
      F0C2BC3F8DFC41E3C6E4226AEEB06164B3E49AC3DFFBD10D0DAB48B386C5BE97
      A6CA27A646C977342FFFE24DAFD2C4A025EA96CD134D804ABC5C8B652B25F00D
      3347CAC1DAAEB3BC5E07CC4343BA9737F89A8C7E42074DCC8759A0DC3B50CEB8
      F44F725D09A0AC6A8E51C38B99D873A4D3D1513626FB1F800A0D95D81E0F1DAA
      2D2B9E9A44A8CE18B915A8F5F40380D4CF0FFE4BF20E6BE8D00390ADA4235C86
      45780A7CD4CD07A669B2281B80444F4A1D391752370F465CEAFBF77EDCB575EF
      BCC06D9DBF20B05DF931F89369294B0B3F32A7FB08371DD352BE43BAAC9183DE
      B74C7D9C03D59C685B36B82FF48D0A175AD30DDCFBA059E4868DFB24E5062786
      279741B5B041AF61B6DC025E13BF09FA3B8DB4D5B0D1D9F4273722D1CB4AD32B
      10142C224E94305032FA73C29200AD21C3D3F68D976089C1318CC3674F53D7D2
      28D0F14ED2C20850AAA4B564A649DB32DC2DB91140A99099C7544F3330329EFE
      8416A642E4A3D78A84DA0CB52A7DD60214A770ACCCFEF93E2A2C6EEB65E64FDA
      021F77EF611AD8C0B34CD63C769197329E0AA6920DC63453079C0BC0B14697D8
      A6AF05A99E718B1456CFFF8BD34B2E809B4D5366216A1A91A43066A16B0D9C49
      C016E095CF3B838C9227C0784B425B152105111657202B0B0ADC52E61085B070
      3A6E57C13FC4BDB127F8D68CD4C0CD5474053F81EF87C7B4BDE9ACE0828BA45A
      9091A569610B32C4DEB61F92D84D302BF86E6C51D1CDD76CAB45873E6C7B345F
      6FE42753044B24D42F2F03E82DCB003ED3B5FDBE8920B5ADEA5C5AE71AA6C3C0
      8658725D48711369A9660D42DA31C9181B317E35836A023501EBA200382150DC
      D3AC69A46E6766622623D2D9D33457BA3A52F6088F19945642874F7CA67E69A0
      B95902F248F5997223B1717D7E158D8B3FEE8FE2BD380AAE1B36B09F77E3F817
      EF6D7667BC177E7E25E4F5A80F52DCE3B57FCCABA71EABA78DF9A3693C187C9D
      B7FED78EC9A71D7E8F7BCFFE6D55E33A76A2DAF412A261B2BB26AED79F778F8E
      7EF15E1E9D5F30F886879796BAD67A9AA191C33AD83FDCF77C2683CA4B485B97
      066ADA98248056EDC363FD9266EDD515BB1CE3CAA725DEA2AF0B145C5AF65029
      4ACCC5660AE269FCDCE6373DC043E2148161EDE534D0E04A109A53263C10F4DD
      9A300472BD5903AF42AEB0371AE5B953C11A1DE63063A50FEB199AB5B8578B9D
      522D6937805B1F3BE58DD1374C16128C944AA0E334FC89DC90C3E3D37D1B8EB5
      B8F2883CDCF819A3D995F48E8D1CEBABA3FD5E1D76E91E052D9F4B642CD29668
      E010A5D847C8EB24095CE5466276E731D827C7D1FBA68DCEC61E6CEE2CBD45BD
      E35534B5EB55BA2969FAD083D7DCD19D27E9ED9D776B7C86E4ADF61445EFABF9
      F0DDACB89AA469B60CBC7C71E0A5BBB30CBC7C66E0E5FBE6B65F5D89CAEEACF9
      8A3F6C1E8966702E91538980AFD56AA7E56EFAD2DDB48483FEDCDDF4BD135BBE
      0469F2AC3879C3FB040D9B133FBB562A6A0B821C8DBD703625FF902B54A4B397
      36DA0D386FC155C3CD50CD5A19425DCE9DBB128C8AD3F49A1B210B0F78774A93
      DC4CAEA1167ACEA12205BC256F39CA84AB74168715D358787D79824DE147B177
      1361D3733415EE3317282DF5E697EACD255EF3E7EACDEF9B423364A47C2F40A8
      1A3DE1BE65B6D21CEC6475453B2D783FDD5E21CD7A95C61C98E016ECBFCE2653
      C59EF28B46C283DED3A0AC6C30C0A9C9AEADFE44791786799020EDFD2A8D9286
      2118AFAE88CF7DCE3E37630D72DC44FEFA47FDFB2B0CF94086CCE4E9287F0246
      AFEF312F40086A700E318216D156773B8454DC10EBC6212C70F563B30485E2B6
      DA9E40CD6A4666F85D1538C2F0F173EBA553037B1DD1368ED27AFE258DAA5923
      5E5D913D10254F19DDDB0E8596BBF04EC7775E80C00C8F3348C1A856D8358480
      2C9B50118E0C8C1525BE97288AF103748DDF0AD5A691CF12807FC7F467655D6B
      9ABD75CC0418D2ACC563973F9C291B06CC0C6977D0D8240849DE4AD7DA734B74
      64DE934C2330FBF8719B1DBDD595586BF302FAEE9258E24B0C955E67B3B344AB
      F84C3B65F37B27EC45449536569E9BAC58844E1ED0DF514F703FFCBFDC45FFEC
      2EEA2E77D167EEA2EF9D80F0C5EC12B989E7DE384E7DAE5999C292E533DDCFA2
      5C98F960D7C4A87E6E8D67BFFE7AD7EA7817A0A846AFCAEA4A6672A459B1D5D0
      0031772312C7C864720BBD296211A8FA347F9BF931E329923590CE2ED928B8F3
      6C55BA7A1C713401DF9F5408F94130CB80D947BFAB59B636F0467785599F7F30
      678FF28EF7426A48B9B21A0C5768900DA4E1888B47F96BB9782B1A451819F776
      F2CA1235E2BF2C95C8972A918DFFF846225CBC173F5784FDAD874448F2795084
      9F23B8D699915DA3BEB764F73B9D4EEB1105F705A2FACD9516A063E03A309CB5
      167548673B2DB4C4BF892EA5D8A3C88CE130C5D37FF71E92A98A74E1C7A23424
      D4C8EEADFD90B48F45C61C19041CA1766CC8437AF9C07383A0B39FDC710A3B8B
      C20ADD1E37F14F205C289B40A1704289B2E83DD6D14FC2BFB15AE426424F7E13
      D6538E60B39AB3A360AD8C8AFADC8C67B16D4661676C42731D81F89A1C92192A
      460ADBC2446777C2F4AAE2C2A8DA1DCF8A5966DACCD7E3C7F426B77EC275247E
      7CEBDFE5F0036F30245F83E49634D05B339DCB8E271D612F4FFBAF04FB93F4F0
      1D8C35F203F1414217422AB13F9DF2852A58AD5329A10CF46DDB9EED8D9CACAE
      F8D770A632EDDD491CF93AB9E4FC00F85198225BFA557D0022177808EE21AEAD
      90D2D3182AED88F38585A38716F5A8CA56F015B6FEDBDDB393C3931F9E3F7265
      E3EA4A19E382FC2BEBDCE766969C85289321BB6202096AD314F75E008F82CE4A
      E13A831F2CBD4C3429D7B209B836406FC13337CB791946B9FD2B3233EC3C3BBE
      4A5EBA34E309C8D4A72609FDF93591188170E72B413DC91B15D54FBC9DE8135A
      847CF6E8D601DD86AC26D9D745EA865BDB6FFCFABEB46359143C323F68FFC2EE
      70D5D7BBB437DA320ABB03B0C6387D048144B165FB622CFED8CFA04BC2909BC9
      FC5BB22D5ACC0D5511197DAEFD30603C9E4DF1D3E08717B252B399B065CD1254
      8EF8DED6604463B38FA6097BCBF5A84B67E70BED947E67C33BF8CBAB83B3C3E3
      83938BDDA3A5E7F3999ECFF74E172C3B514F7DB8138842A26049DAFCEED560B4
      3D717494E16F029D3441844F9C898A4940FFA24503F898211D45724E934E68C9
      AF01F7D9AAA66BF1BEF7B181EFB8EE8DAE0EA0E4C8E79805B60F779A02E52702
      16009DC5465B28D0ADAAA7756B8F99C9106D3FE02EEC96E3AF6D585559AAE607
      4798938A5E232553C5C372B6C224CD0B0B49AA4C92C0C762536862FCA462E9B0
      7ACD8D06AA73B87BB7D0AFD58A0077711885687AE40FEEB8293137F1D85B4393
      0AA636F1CACEC27CD2F6F6CE4BA40B2EC95567D2A60A4656956314640F1D72C1
      BD034DC707D2622F87899D3E85C61108727B94F179F2344905A89F5E1F9B6962
      E4E4E4FBD29909A3AD7A7B6C46482C373A5AC1DFC8C556A5139E84736DCC54E4
      8F3BE7EBB5A7A3D7B5F2F8AB089BA3FA02FCFC8BDADB2B3DA824449EF2E5AF7E
      38DB17F3DAF8590C2616CB37DDAC958A6633374E0B821F856CFD4493AF0613F9
      88237A31BB44C12667792450A2D515C1551A05B6CA7C6404ECC2023789F5D4AC
      91423F18EF7522DDE9AC8315E0A29C52D5166235BE42668AACBDBD1FCFBC9F37
      F87FDDC12F58F907D2BDFCCA6705545A7AE7F44DFDEC9C9BDC48ACA753D6DCDC
      F0265F50E38F1ED3F17E882414A686EA541E692B5B0006C305FCB4E1640A545F
      84ED5AF0CA25E8A4389C3E5B5D21AB98A7CE364ADFA6594C5FE3D05B342EC36E
      536C444194CB0C7B6098754847BA070401447AF63807EC741BDD88F35DA13D91
      AC5FD0B0E3E7931706AB5704359DBCB9870A3684B41EF1496565D816ED1B47D7
      D2ADDE12DE0DEFC961D52490CCE113EF8C4FB8F208F7C2B4814D2B172EEDCF43
      104D0289A130EF36AF959A704C983C4DD452A8372552266312AA34E00CB1E222
      F16AD74B43A37F84E0D9C594F51AC468019258023F9856ABACF40A82C7951FCA
      D265688FB2DB6DE933FD733E536F9966FD6C37E97BA71AFC01B19D730BEAB1F6
      C3F1F9C5BAEC4D6C6586AA71E74D9EC637CC098EF6B454B043D2EC70BFCD9150
      B1131AA6C676B5A8454FB533732956AD03FFE2A27D1100FB8AE2EAF9DE4BA495
      E4CB4BB5F2A56AE5515346DF73E6E3A21A67D4B40137044EFCBF92EF9F545C12
      3F8E8A3B8DDF57C21C23B6F19118D59225BAA1562161554F2664622E4FC22F5B
      B2DDCE1215E773CFC1EF9D0B5390CD6C82641C6508A6209550D60CD02147862A
      BB0A6CC8376B099403F4BD1E3CBEFAE0B8DAD38F39DA060E721F0440CD1A2102
      360E0E021D3F976976E7B57E8C4272C210C9384E43EF07F400B52CFF1DF92423
      A3287D6CD3346BC4CCA060F90B6980D620F3E8AC388161276B19D1CA4B535462
      3AF85B22593D5AC93EA30694F4AFAB2BCD1283039F9D42850895E32BBFB8A2C9
      8E9AD601B54BF3C0D9EDD62C011469D2B2D16CB8BD1C4C92CA272DD4BF418A5E
      4C54C6FD6FD668CF4DBCBA528F20AC31C339D3F9459C055663BC48BDFC3A9AB6
      11DCD64EBEB6D7E9AC6BB34250AD19E1285DEBDC450E5A6DF7DB499A1849CAB4
      0E917E28BC731BC368354B767E881438463E93BA0FA946B75D8EB633231D8FA3
      00A925450569D6202564FDDC2B4FAF804FACDB2C4596DE02AC928D5916DF7055
      3D9F03AB2B800892B85094413D20F409A26A44F77CBBB4D6B8904704B7CE6B43
      93436A81CBF2E273A559D22313CC64C048296E8D7F5DA6D40C6A23A27CA2C7A0
      94D554B09482187F7219A4660D7A75858FC5B15B31D1BD4C5CEBC52C8A2BF15B
      2630CF24A7D3F2D66867E5DEDF6608E4FBDE48AA53E96F91422C91B60D8C4082
      C3885AEF78BB4C05C0614D571C1292A2517E647A2B4484F561A1F7E2AE55634B
      B791CB9278D1F51D95A83059F97D30BDB88A9B6662DF1C978A0A89097F3A8D91
      9D557217297EB115FE419405B3094CD2A07161F2F92038B75C66E9AD0D38B13B
      E4E5A8B473D58CB7A4B710ED9E1A5C2CF8732E05749B97AD555C346DA3500223
      C965808297353193B4E39DA7AEB40E0683F1F388430164EB591E6FC001A7E975
      C3B639F26577A822BFF40E9FDC7027E265CA617F7F84E3E04FCBA6AA2F8B712C
      9B413E37C6F17D93DAD423FDD0BA823813560A9A484534CDF97B6993A8DCBD0C
      E3ED156A55B8746A2F4D4205D86122073A2A431EAF34B4362DC0E1E217B9B7C6
      E6BE683A3E03629F0ECE86D150ADAE9489A74AD5D77D374F6CB9759E4429FD7D
      2630215C00EC7B9DC2E4039C9D0E9D9E8BF45DB1468EA53F454400EB83031F7E
      AE45180E52D15B538FC9626E22DF3FF5734D766927B4C3A36C98AC5F59F337E3
      AA6826E8A9B65542AC121C2C45A7842F6590F0926CDAE5A9FA89B3F2DF6476FD
      049B0BC72BFFB64BCB771F6432CB6C17C7DC4926B0DCD818C5F6BABD4A69E9A9
      358268EE7E4A863F79441D527BC62FFEE0FD4846F178865A916241FDE703D43D
      38D5ACDBA07D07D26CF3BEAC76F4EFF5842C04BAFE7A30D74F0FB13630D6C309
      AF894F6A0961A0EDAF24FFB2A8B4ED1A28B9115401A2AFD8EB305E8BA5A49006
      0E90096A70965C498BD098E6EA4AC2ECA78ACD8FCFEDD1FC49CD0A7E972CB53C
      EE6DEED0BF7063BEDE42BFB7B0FBDDCD8DEDFAC4AAB0B636061B3BDB967F97E6
      E45FDFA1E9C4847EE17B9B1B83D1467F63D01D6C6C6C6CD1FF0FA552B047BBD4
      EC8466633C1A8FC75A3D186CF4F8BF7DF97D7334E86F8DB7CCF6606B13FF6E8E
      3707DB3BDB1B5B9BDBFDCDB067B6875BE156E0073BDD60343041BFBFD1DDA08B
      B607C37130EC9BCD5E38F057577682518F1E3EEC6D9A9D612FD81E9A60DBEF6D
      07C14630DCD9E90DBA5BC14E381CF5FCEDCD4D7A99ED4110F63607839E3FEC6D
      74B7B6825E10EEF4FBE3ED1DD31F99FE766F1476C71BDBA3CDA0BF33DC09FCED
      81EF8FC7BD41AF478F31A3EE68B0BD19FA9BE1B8BF3D18873B7EB8BAB2B935DC
      1976BB7E77D80FB6BAFEE6C67867381E8CFC911905BD617F7BB83DDC18D0CD76
      FCCD9EBFB93D325B34467A8F51AF1F0ECDCEC676AF3BDED9F007616FECF7871B
      BD60D4DFDCDEEA6D0D37C62189D30421BD7A370CBA4333A2BB74FB43D30F7606
      FD70DB6C6EF4475BAB2BA38D6EB839EC87C698CDF10E8961607A3B1B237A87FE
      B8BF35307E30F007B4C887FD513FD8D821C199C01F8E7706249BEE168D8D7E1D
      EDF4B6C79B3DE30F7AF414BF1B849B3B01496ABCD3DD196D98E1A6D9DAA469E9
      F637FD61687A1BE3DEC66818747B417FB4B1BA02616F8E83F11699F65D7A80D9
      1A8DFBA31D33DCA1D71F855B9B3B5BC1280869BCA3DED06C07FDAD4D1304F41A
      DDF1B83BD8DA186FF6C766D8ED87FD20A0D7186D8F65AD8CB17A68BD7C689DD1
      6C900CFC6DBAADFC71833C9C2EFF30D29536DEEED11A0BB6FBBD31AD2BFD7988
      8534DEF2B1B2E8FDB7CD78B8390A498CDDED90E44D23EBD2AAA29918FB9B3B1B
      833EA6673BA409E9F686DBE3AD61AFD71D85B4220CFD3B18AFAE0434AD1BFE68
      447226719BF178DBDFE98763E39BE168BC63BA3B0303E96CEDF8BEBFB115F44D
      6F400B2F186D0D4D777BAB1FD2E21CD30ADE196EFA037FBBB7B941AF438B6763
      B845CFA5678CB08083CD8DB0EBF7494C61BFDB1DF99B83E168ABBFB1B3D9EDD1
      2C8C87C3706780AB7ABE19F4B6066197667823ECD10B6D86A3FE60ABD71B6C8F
      FDED9DEE7677731C6ED3CA1BE2D50CC98C76467FBCD9DDA28DB5DDDFA6A198E1
      D81F063BE331AD1A925110EC98C138E8D2F7C7BDC06C0E6852B668CBEC0C06C1
      167DB4456FE077695F91E6DDEC8F425AD3C3AD4DDF0F075D136E8C3647B4E2C2
      AD712873F32933BB35DADED9D9EA6E0D55630C7DA749F87FA439E809A425367B
      63F97975A5FA1B7E1E84740343FFBF4D7AA567B50A0D2618841B34F73D68159A
      D3EDD0EF6E6FEF6C9036A0C918D1321D6C6ED1A60F46BE198DC6F46683FE4ED0
      F5075DD22F24D19D31AD6BDA81A63FECF7B70313D23AA62D335A5DA1F1D00F34
      91C1C6F64638F4B73649E598E1108B7A9BF48DBF4DF3360CFDC1B01BD044055B
      81A17B766983999DED6197243E1A0C69A385E3C10E2DCBFE26BD1BA90A5A83B4
      32C2D16618F636C2ADD126A9AACD5ED7D05C84E1A6A1FD3BA08542AA8EDE607B
      73DB0C6936B77B3BB4CAE8431A084DE846AF3FFC1CF98F3782ADFE0E9D8CDB34
      12FA5FB0D313F96F3D247FF97975A5FCADDFB53237C126E98821ED185A93B48A
      36C66640CA2318F77BA42E7AB4FCCC90F6638F34182DAC1DBA257D23A40193F6
      A6F5178EB74817873B3B633A3406C17044E7CB964F976C7537E8177F7B14D044
      F676680E87DBAB2BA4C048F3903C06F47B9F2674D8A31D3CDEA1216FED8C6821
      D3F6A5951EF6FB3BBEA155B6E9D351644C8F86BF331C0D36B648D8233A48C786
      B4EF26FE7F108EB7C330186F9ADE563818D1F492A6DBA69D405B93844DDACE8C
      0CC984A673AB37585D1986639FFED4A7538216E136540A29EC914FC7E9C0A7DD
      60E881FD8DEDEDFE98D6D7B619D17E0C077404F66849D089BB35D8E8933E1F6C
      FB7465405ADA0F868686F9FFB7776E4D721BC9157E6704FFC33CDA0F8E40DD81
      D093A84B68C392565ED2F68B5F0A40411C6B669A9ECB7A191BFAEFFE127D9946
      7703832A726D3956AD0B393D9585CAAC93274F5677A39D4975F00AF21CE07D67
      5352EDA05DD72A729B3C56128C9AB85299FA1A2AAEB97AC3EAFA10930E750DBB
      A4C6445DD9DE524613EC4F89A53498D8F480AAC55993A21F084415352E256F2C
      A08C3D133620A6AF3B47DA1BAD211C0F442DCC9A54259180276031D77769A824
      17923251D9A02A767CB078A85C08893046A134808ACB001B3EB295F38DF16DCD
      DE38D321C92A0D739A08631A53B70028DA2600EBA1EADBDA9000540922AAEA41
      B521741E1755DB220B402BA49104078D14AECE2202808BA7C6045757429203A2
      A256EC2E69D3E385EA03551B62A706332F4841085411D6166206AE0D4160CA86
      FFE1438485D490D8ECDAC02E0334A0A99F2DB49DFC9006FC6E2983C420D91008
      0A6CA3AC330D29896CA374C0223CD786D8EA5E2BDB923243EC87CAA55459DCEE
      7AAB03D5A0460AE83A1A4620404882C6D4D4CC168CC44EB5BA6AC85650CEF683
      681B3C29C13637905E05BF285859530C3A6DBAC496365E932F1DC889AA112401
      F1C6D22643915D074947C0A891305143171D35A3E910133C51B5AC135A0B49E1
      2ECACC8E2901875082AB7ED022E6E045EA0F01200121A5A1A72CBF7E3538E1C6
      3E0406B11F9E0AD8B50DE4627124F69DC68AA1CAC89F1D55A21942257F87DEA8
      4903E16830560E7980A2043A89E1FC6B1A8638831C81A76D3728B84156C018FE
      0EC082CC814A6BE5CFD852B5064286F20C2686CE7A140CD8A028D63DD1EEA2D2
      8E3253A3474C12EED741324AA99E5F549E5858A76A29AEC46BE83D4518055003
      F0D65A4AADA316D8E8550F4DC1443E7A94E880468091D0075043C3457AC42F65
      2DA0E934CF822D6BC8136F9BA677F0F4909CEB9A082DC10B6CBC4686D112223D
      3B876E812F45BF04D4A56B3BD3B94445AEA821BA69BB48067AF405EE28780668
      60D2B98EEADC10C85661D9E91E728312418889900A574E4675099906F2A1CADA
      1A6B63A7592E8AD3685852471A12F05BA3A78C378032B17498D913484ABB4697
      B4DEB99AFC04B54D6D5153E8811A610810D110706207609493ED274A3840FC99
      B66584ADD1E996E75A243F8C133D0AB172A1261334F16181A486072B249B41CB
      0EC00849C5C5D815B87BA0D8C0AE8D15B2F41408509D4205DE6D67E90B7A7297
      5D20933C1D07C04E6C18C51D3693BAC07AD1755A2EE3C9E986B22431EE6ACF25
      2A63D9953622851001B587E7060A408FECE127EA70E35C05010F034A37A0A180
      66473AA1C7C8AEDAC38EAAF5E8483A16ABD0343585CA379552681C5B21F12989
      AAA77151408F16075DCE22482493DA40E7430D6CA874E45D1C6C2D90444818E6
      AC50BFA37823A7801EBB58078767EC5018D04F03422650F8E10DDC21F7E1C4A1
      968005C1FE00445D0524ABE49B00F13848D4F77027851CB2A51F919A027B0E49
      0A6CE05F2A580D8F924C0AFE34426C22B1AD42EA51BF3D5A82846CBA5114C96E
      C27E10800719F0D5C8072488B40F9A824938A0EE1E795C4BC24982737D437F43
      D31485816B784A7A14D340E0E82F16018F384D7588543D87B44C843D916C9102
      5DC1AB0DF93A58DA36C800B1125A4BD9682B617D5859626090B6233B100A0881
      380BD17B69BD3AE472CBBE804120839043DA8133B6010D87EA7320A5732D2A05
      9289F447284737C4CA92C45C1A85C03883FC4026A08507C280B195A681C4212F
      A19EFAF52B580A507AEBBA84C0450BB49416E8403465A0B822F74DA5D9029A22
      9418552910E05659641D159054B1242349432181E783EB543FD08484BA018500
      824ADD45D667EC009BA48A9E007505F2D00A544476A14A14F88AF41225E3E948
      B830C9426B51470993457B40229A8D8686AD0D5C88BA483B88C093B219113208
      08E4049B83DBB433158A47011B845570A8CE007B3041DDB309CA345C127D216D
      482BBB403411312952A6A9E3C8039A050A430D23B63D631BB0A0A9BCB4CB2820
      DD1261A919C8E6D046806FE9F11A00A0C116BF47E5B3F34C267535F591D64831
      27320E58500D2A23D50E0D414E5B843F8C249AA9AB5213C92D374096A8407426
      BD8033F467608A4A44024039A22AF02F28392C695AB2B56D5492D83A94AA0280
      8E792904CAD21DD31941A3AC8CD444F9D76C06F8B7281E0A8042FE900131519D
      07A671D235B0BF0801547CA2D521B8FC951C36140DD64BF78D001449811E2260
      E404C585628A3046B3D12FD70D2C868E950EC1A14EE86ED0D3566A0DDD26E448
      CE6A58864E9CEE878CF1034C406582FDE16D1A11C4CBA050320111160DAB01BA
      151D84AF44D542D90D19AB5B36162E84DBBD8E52859055BD86666B4B9D825AA9
      DCB0530423C415A6410122E729E0948C80C6F272F481E8191AE1A5815CA08605
      291CCE0906015E8BE0C4D31024833A040609E4FBD0B32995C5093FD28DA8F5B6
      835CD9B2AA51F4CB06FC5406AD2C55800C828300306D2F910313B4C934A58394
      463682DE84AA56C7865D80778C789D1CB1EB0791FBF05C68758440BA0A8EB722
      A62C9C452AC3F0803552AF90A1D452CB4EB04D347EB485959CBD209A50CDB16D
      90AF30A2236FA056072B520E5829BE79AA78D3921D9415545A1F9B186A489C20
      A176C04F72838788A03662099147180CE627159A218271FE551A4CA2784796AD
      51A89D1F5ADF384468EABC1C91C10A2C491AC2AA8F546716DD783042D2B46022
      D0E48AE60E4E38516677401AC71BF18F26889FA85C643F3B0B29226E23C59C16
      39D07E8893D48C3E913F55247872BC14DA5618BBF61E7EC0158427659BAE1132
      85D2513F147C6424CA5B3A24D044CD85E1D0071ECD4A6F2B98A962021F3D4D14
      DB8667648CF1141EED3CAA8BF2DD76BD6A2B393AABE87710BC225591A1A88821
      2189D1E58970B24E54520A3CD064B4259E36AA935E14B6A0CDA1698B74E7B1A5
      0B93DE198E865DA1792818F886AE27FEF07F9477171248FE87C8A753A12B1914
      D2093140804D4F7F46C8E4A481C5A2DB2D4D89E1A2641E050277C80B940FE0A2
      6A9203090A87F2BC1C01E9C095028163174872D659D1F475A0DAC8D9438883C8
      968A1D400706E13AE5E177BA5FF48B68A0D53D3DAEA9A66A00C9EE2CA5DDDAEA
      B0EFE9D9858B5DFDF129DA4BE72BD353B6F1A44543C530C400090439D4A218D2
      34231D1A453FDDA3942A224CD35B5BE9990C6D26281B90AF8A2E8BFE022DDE55
      3088F42CADB4EC4D0B13353DDD2B030D9DAE518238857C37D2D3BB406946A6D3
      2C26A81322246A347D8819842A21024E5ABA35320D510A3C95D0B585CB5EBFE2
      BA080CCD9C344900410769BC9AAE879AE55494D63821C64C8D0CA51BD051E4BB
      4275C2EBB81CE86CE9F006393C5541CE79A8679E0D0852F12A25270E1535077A
      270C2293D18D9A964509A127A744272222C011CBAEA31C13D1BEA1C3DB182D42
      ACA3F2227F20BA7E77BE3ED97D453BD8CB27F6F3CFE5F78FD7AFAA0B8F75A7F6
      2FAD41CE6C974E6C2FAF80058EA32E9FE7BE74CD974E132F3DE8179A6D74E6CE
      BA5ECA849756F5D219DBE55DA026AD5CD5F3F9DB4B2B9963067221CC4788048E
      4B2B29638D71ADAEF287CBB8ED7F6E777A49EF7540CAAFAF5FC98B52DDE66673
      FFD0C94B53B7BB7BECD1720EBB992B789A2B0543359673B75E6B890C025B6BA1
      551A4E3956F4D24604F9AD1CF8590AA8A96504446EC715CBFF3B9981C8322A34
      827BE6A27FA820307905082230F8A06D2F7D8E08B3ED1AC816C3EF94D8D1FB5B
      FE418E82609A0369A7C7C8283949F34318D7B4B343A71117F99DDDFD560B5778
      CB9F8A4A32AE79F4929ED5902506992FE33DFDAE4FA3875898ED953B7A0B35FA
      4453BC7BCEFA76FBDC384E1FC6E9C3387D18373EC7DCB2E6910176734C9E791E
      C30AB6CFE9B351E73399B331E66C8C3D1B63CFC6B8B331EE6C8C3F1BE3C73135
      119788B6DB7DDAFF34FE8E9DF09D9D8E38798E7160618749790BD2DDE3C3E3C7
      9BF4F01F370FFDC3E3F56DFC8B095E7EB8D974BF2434C5508DBF4AB7D7DB178C
      F7CF6C5F4B96CF7EEC9FF9AFED5BB2F73F7EB8BFDEDC5F3F7EE4E7A6F9EBF394
      DBEF83BF3AB25057C7E3ABABE7B1D5D58FE3B7117C313BBA998C7E9FB66F8A51
      5FBC7E355DF6D6EA79D16A7E0197A7D45F7CE609CDE79ED07E7EA7DDE75EA3FF
      DC1386CFEF74FDB9D7D8AC9A706F754D8AFD653582A756EB403AB55987C3A98D
      2DB071451EAD03CCD42614D8ACDBF4A94DB3D2A33D3ACC141E8F9B8E6DFEC409
      D6EDF8C204E6D39D5887868509D6D1CCC204FED39D58079A8509D6216861823C
      9AD816C6AB3FDCC90DAB32536BD86C1EEF368FDB4FA5645D35DE61B7BB9977AE
      ADD061BACF3291856252421C3BF22DE772E326B376717CA35CD6F21FC70F8B6D
      86ABE1FAE7A7FBF490E948BAFB73BAD97C38DC9E38EBDA07E3FBF4F8749FB7EE
      033E0E9F612B05C9F30479AE8F1F88DADE2425EBD21FE2CF4576E8DA4F70786F
      3DA6449EA30788C4A7C7F782BBEB94B7CFB7B1BBDFE4A17213B3B2636FF7FDF5
      43AE776272F5E6E9E626E551C568F763FE368E7679226834595B042746792268
      345957E82E44AFC4A99D65916F3BDB02177796059E6EF7BBC4D39D6591A73BDB
      024F77966EBE3955D35EF6DDF5E34D1EB17C75B3918F2D67FAF5F6FAE7BB28DF
      1691A548A6737CBD7DF3F6F8D9AC9FEFE387F757DF6EEEF292F8CDA6FF78F52E
      57251CACCAA4CDB833F27D24D7774F79B19E5896A0F0609BD7514D6DD736F197
      ADF3B2EE87DD37C77EF72CCC2EC3F8045E4FED633692DFC69BA7AD26C874F0EB
      F89877A567007D3BDE146A07A34F9F2213133F8A22F86E5767F37C7EBE7EDE25
      9FEDF220789A73C597DD99E712F11BF94B3E557CF751EEF3787DF74B96D5B71B
      B9DD6DEAA7D61781AFF514C38F7213939D6F970DA684FFCDED87F7F1E13A4FD0
      ED3F4375F543FC9065F8937C90313F8ADFFCD3AD7C1DFB73D1C8DBBBEFDEFDF0
      FDD5BBCD07D1B07247D1BC1D14E337721780DB22FB5D13FC0FFF9EDA7FCCBFF0
      9728E7BB8FB7250E7F59D0918D865F5D67D2D9D66AD317587D7DF8AE8C1217FF
      397D6C37F1BECFBFEE4F745163723CA602EBB7513EEC9D6F271F27FF6F9230FB
      BC60B4FEB7787F2DAD5809FCDE651B1E75C80F4FED7FA62E2F657FDC9434637F
      DC7E3A772B19D61D3C5E34CD2B0E13D3BCB2F46E7BB3FE6BC143F681F8C4386F
      C913D392257F35DE8E69EDE9EE655B5DE4EFDEFA53569DD70AED6CE5E56DF98A
      BB2297F7C6853EEFCD8B9CDEDC3CDDDE3D94AE7BB42D41D7DE36572A4DAD0BB7
      6AB4CDEB15B6B6727FC6A2508D8665DB3B9A966CED685812A1D1B0383C6B5F8B
      B8609AF7C2D59161DEAB575BC38232706458B697C545A0E0C0EDC8B0642F47C3
      B2BD1C4D4BF672342CD94BF3F5551ABFE4A48CC88ECCCBF6F568823212BE7B4C
      B71F36F7F1FE6381F93737E9E798D9E26F2D7FBADF0C726740B94D6099BE786A
      1F4771526C5A523C68778A2E2976651B2C9699670AF2AD329BA37E74E695CF67
      162B70E89DBC9FEEA2DD5153DCA5F79B1BB93FE1BBE797672E9F739D8AECB71F
      62B77F95643FC84F5BFCEFC7FB01BE7DFFFC72CA61A0BA307094ED9351FAC2A8
      43340EA3CC64D40FA9BF7EBADD5F750785C358BB3476BFFD87D1EED2E8A3DA70
      18E86707EAE9C07069E09172380CAC67079ECCD8CC0E34938161BA375FC7FB5F
      8E1BA5C3B0E9CE1CF4E3A55D0CFAF2D8B38D0CE6F2C0F3BD5C00D0D5975D2747
      3F6A1D929E879F6CEA1CA866E65F46D78CD132CC668C16D036B598CBE73FA53F
      5F3F3C9F685C7EE5DE9EB8FF70F43AC6C269DF1466FFF2B4D91DD55CBEC8741B
      FF4005BB7B4847566B1267264A0B1934BBE50BC934739585ACBA6C31975E33A3
      97B36CC66821DDE65C5FCABC19D757A4A0CE4B41BD8ED56786AF4BC033EE5E97
      823A3B05753680D79780198B15F03D737F0580751680750980753680F5EAC231
      EBFA0A009B3C009B3C009B12009B920A623214CBCC855600D86403D86403D864
      F3EFA9EF2F01D89400D86403D86403D864F3AF3DDDF697006CF3006C4B006C4B
      006CB3F9F7CCF71500B6D900B6D900B6D900B659FC7BEAF74A00DB6C00DB6C00
      DB6C00BB3CFE75B91ADE9500D89500D86503D865F3EF99FB2B00ECB201ECB201
      ECB200EC4AF8F7D4F5350076D90076D900F67900F679FCEB4F377C1D807D0980
      7D36807D3680CFFC5901609F0D609F0D609F05605F02E053D7D700D86703D8CF
      F7E26A1A87DDC9EAE4DD37973BFEA97FFB1EFE60B874C6A02E5DF24F93B78F5F
      36D417AFB9C6721AA4379BCD2F196F293DCC32C5E59BEBF6E67A339E8C7CFC94
      8FD29D9EEAFEF1ABC37BDF8E87D9B3D35979CBD278963B6DD1AD9E1D386D9FAC
      991D38159DD6CE0E3CD51DD6CD0E9DD2A89DA6D308D7FD4B3910DE74AC9F1BAB
      2E8D0E73A34FDCAFE7C69D78DFCC8D3B75DECDFAE446BE984CEBD4DC607FC8E2
      A9819E3308970D5E0CDBE5239E85F8CD9D232D8472E61AF331BD6CF0526867AC
      56C478CEA735E19E716E6DDC756EDC570378EEF46345DC7551DC7571DC7536C8
      679D5B1B77931B77931BF7D50C32775CB136EEA638EEA638EEA60CED67A5E2E5
      B8DBDCB8DBDCB8DB22B49F117F46DC6D71DC6D59DC5D2EDA4FBBAA157177B971
      77457177C5683FF52927EEAE2CEE3E37EE3E17EDA7DDC38AB8FBA2B8FBE2B8FB
      62B49F39378DFBD811AD168147A3176BE8D1B8450A3F1AB7C82047E376127091
      388E86AF13814706EB44E079D85689C0E3F8CD18CC07725635CEC77495083C0B
      EE2A117831C633962B823DEBDCDAB82F8AC04B715F0DE0198397A37E2AACD6C6
      7D51042EC67D51042EC65D97A1FD546FAD88FBA208BC14F7D50C3223C95646FD
      4C3A66C47D51042EC67D5104CEC7DDE6A2FD4C35BE1CF745117829EE79143E63
      9511F533F99811F74511381FF745117829EE2E17ED67AAF1E5B82F8AC0D9B82F
      8AC0C5B8BB62B49F39B736EE8B22F052DC1745E0A5B8FB5CB49F0AABB5715F14
      818B715F14818B71CFBB87D50F98E47F64EFEDAD7C415ED92762BF8B0FEF1F63
      DECD40FEF5EE3E3D6C6EE43B3DF70BCE5FEEF7B2D25FC72F6D93EF6B7B7894EF
      48ADD4783B4DB9B5A8DEDDEA73771B502BDFFC34DE74D2689D9CB1CAD5AEB6BD
      DCFADA3BAFE48B13E4769DC6CBAD332F3EFC76E6BEEA06A5521555AB544C6AFE
      06A2DB8749D5787FD7210D837CA1C9D1AD3FA70F75F2E7C92FC47E38DCDAF6FC
      E7C3F37FC3C7EB577FCBD97FEB8FDFBDFFFB7D5CF0BEDFFD99FE7757F27FF1F8
      7DEFFF7E1FBF7BBFFC70280D3F6CFF0BB61A85874585F8B4FD39F044685E5209
      E58FF176EA6EBEEE579D8F7D53D78D1E546F912CDEB1525B35DEE8F10B31661E
      F2CD06AF5F5923B7411F74EF2B35A7387E2B8FD908143E2EDFA0FEB7FCF89C11
      F8FFE7BD3C3E57040ABCDFF51EFBC7AFBFFE0FCF90DC88}
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
