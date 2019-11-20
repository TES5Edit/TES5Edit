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
      789CECBD6973E3C6D928FA5D55FA0F28E6DC1A29913404C0D5799373345A6CDD
      CC9691C67EDF6BBA4E8104482202011A00B5C4E5FF7E9FA5BBD12009891A511E
      4ED84979488140A397675F7FEBA5F9D0EE797E308CBC7864D79D66CF8BB390FE
      194C47B6D3747AB301DF3174ED66BDDDC36FF55E9667E3A1DF1F8CF16293FF8C
      12FEB3C57F8EC3D29FFD503D8FEF72EB1D5B7E1F06F0E64E2F1F079340FDA6FE
      9AFF7590D57FEB0D9338CFFB117CA9F760683FB47AC3349978716F38187B6916
      E4707D9AFEEAFCD6FB736FEAC54916587507FEDFAABBF566BD01FF39F0ADF1FB
      55380932EB7D706B7DC2C7FFFA3B0CE9A82127891FA4F363DAE531DB304E97C6
      C6311B30E649324BC320C551FFFAFBEE0E8CE8564CD2599C246C671D160CFFB5
      61B23868FBF7CBFB493F89686E76B1DE388C1E1E68E17FBFFF14C6231FFECBC4
      BCEC46C5C46CB7B57CFFE646FDFDE33B18EE6DF819EF1B7A516EF55EF5DBBD57
      6D173E9DDE2B1F3EBD6EEFD5D0EBBD1A347BAF82EEEFB40CB7EAC54B8F0D8F8B
      8F0D8FCFC12DF626FD34F4AC775E3E967BDC564366B761963D3CE4904ECBA1C1
      E590510863D2F41AEE9340A00FF3EA96074BE22C89BC8CCF0CD0EA0953EB0B40
      E2FF004C7FBF0C4649607DBE90A7D6AA82A7958FEDFFC873A3094630C8BF92B4
      4728BE6E84A229FB7DED0DF65702BA71A84DC2791AB4B8CBA1C57A1B8EC6B958
      645F1FBFEA889E4197E098C2588EFF24047AC231156F687EBD632A26D15A1352
      CB032A466EAFFF801ADDAA411DB7C3C35A73CF592767E2D14ED5A378D4CB1FBD
      4FC5C2AAB1D66ED9154F7F9F06C135BDFB018C6C39154F5FCD52F1AC53F56CBB
      5DF1ECDE0F413F0D6EF7C50095C4AC5DB5677BC7A9D70F07FB6AF5956CACD3AA
      18E20DC063381033A8847424B4CB67F06318E4B1071703B10CBB5DC532E4D9DB
      962618C8736FDA9DCAE7C4C1CF3D571CBA53AF7A549E7AF951EDC41DBBFA5167
      C9A3EAB89D4AE1489E77F9C1F2593B957C551EF6DCD37307ED342A9F17275D7E
      5E3F658D092F2CD95DF6EEF9236EB9DD87498625099EF55390E5F086A7103E5A
      60C77D9C80E8A28F84A28EFB38F5283F77CFE7D9693C4E384A0F1630D4693C4E
      354A8F120CF1321B8F236CE951ED1C3B8DC7B1B5F4ECC239765A5592A2BEC9CC
      DEE5FEB63A558F68FB2B1E5108DA69D72B9ED237979FD2F6B56D573EE5CC3D25
      D1B2D3AE12670A2A2C9F296164A7ED563E38BF1773C8D86937AA1ED50E911FD5
      CFAF5D250CEBE727DE387F745D67252ACBB2B73CBCAEB31289950FA9E3EBBA2B
      D157F15C71805D7725E22A9E9347D87557A26DE2296D43BBEE4A844D3C58DE52
      5627DA8DC71142AA207253E1A1C751A27848901BBBDD7C1C25D453C596C2738F
      23857AAE2034F0DCE388A19E2B61063CFA386A148F2ADCE0471F470DF5A87694
      F0E0E3C851BC73F1281DDB798C47FD9F7926B5A80156F292C784D8D228551359
      459ED507B2ABD9CCE3A26D69A04A49F55129B7344CB5BCFAB8C0BBB8BA4A4EB8
      82F43B3F5625675C450C2E8DD47A94C73E2C112F28FDCE23668567C94E73BABD
      53499916F83BA9EF127C4B63745766F8620C05BCFA306E35D99A970078980274
      4BC35452B10591808791805B1AA49A9ECDCB083CC81CD896C6AA24700B628318
      4B07DAD24895146F418AE09134902D8D53652958142BC48C16015637E0544BD4
      8F51C1D2285F4805E7867940D47E84062EACABF1E554B034CC73A8E0FC58CFA1
      818B0B7C16152C8DF45C2A3867B36B7C1948499E518CF3E540A50FD37C26632D
      06FA42905A5858F39940551AEBF98CB518EBCB416A718D6B002ADD4CDB7A79C6
      5ABC6B75C6AA00B7F4FCEA4C5502ACFEF8038A71B53A5D1A6075365A00686980
      D5596809304B63ACCE3AE7996631C6EA4CB30488A5315667980B00A81BD2DBCF
      6194C528CF5117F4813ACFA16AA5819EC5288B619EAD2E94467B26552B8DF55C
      46598CF45C9A460B1D245192E6FDE8AFBD34F0EBBD119C4A5CEFF5A359505FBC
      E4349BFA45F8F3A1CB3C00FEB56488B9CB73F7560C51F1421EC2763AFA45F8F3
      A1CBF5BFEEEEE065FC7BC9207397EBE58BC5204B2FAB41BA8EF801BED00F5D67
      A57DAEE361FF19233506E329920AC7E961A047CF13EE390CF3507F604488F8A3
      69C907A7DED48215FE1A59BD28ACF752F82FF36CE05B59E434BBF0EF6416E576
      EF36F4077934F5D2DE6DEA4DE1390F2EF7BC6CEA45D3B1875FE2D904389737CB
      939EE7FF6B96E5290AF23020CC35C27FC2DC9BD6ADDF7B71F22B405D3249F2C0
      FAAD97E5F751908D8320FFED8F9B442FCD23D88BE120B371F19E70397AB4819E
      8CB681C9E429DF56979B2B0360B4D817DAF0C7F6BB3718A5A14F8FC5536D8478
      8A6358BD2C0EEE72784BF6EB3049271EF0FF6C9A86491AE6F775EB3D5EC20813
      986B6697B7A96FD769B3F0DF3E2EDC86BFF8F349DB95CC72D8A0200A6E82A8BE
      F2E6F5BC3EACB08E3B07F273C5CEF57BF4EBB2BDBB0691070420500F1FDE1F5C
      78DFCB023F89EB62B3E0E519CCEADA6E2EDDB5AE85A09566A1DF69D83690736B
      1C78185D63D9883499F3F2DB687FC936C25614DB08CB9EDF48F87DD9463E065E
      739BE7C8CD6B3D71F31C0185EECB6F9FF325DBE7B41F8242F8F5E99BB704F65C
      B97DED276E9FCB041B260D4379BE1FE6E14D007767C1241C87BE1FC4F0C72C86
      AFC10CDEA88D695BA7BC75D6472FF546B09563EB3C89731A10A69867B60DFFA4
      C9ADDFCBD3619EFD14FAF9F88D0B7F4CE145915DEF88AF69F17518C9DF87B9FA
      D657DF52FC36E84F3DA0BDF065C85FFAB0726043FC99DF4F03B82BBB09D21CC4
      0FF8D64FFD547E46E2B32F3E53F1E98F22F54D5E1B8BCF1BEB313E00AB7D114E
      B0317CC0B61F0089DD1D6607D695D78F02054F4D1D9EAA28F40246D499342B32
      5C500A04508671FC4C06D725685C84F01F2475B54E40BA54D36A3D3E2D7CEB92
      69C1650DF3D4749CA74DC7294FA7FDF8749CF6D2E9E0E585C9B84F9B8C2B2743
      7CBCF33224F409D0CEEB6D3C00E98DF5D04BBB539267E6F7679225B11471F89C
      BA95E734AC9727398B7A83A1337736D5E474EE60807AA57890F2C54EFD692FB6
      9D05205DF5DDE7491425B781BF3807BB7A0E0E9DD8DC4C30249A2E7ED91E5CBD
      7B6B9D247E20E0D27921C96813E1D2719EB05182ECEEFD14F4F759842C0B416A
      37901BDF75ED16FC6B775C073E1CF4C7E7776EABD5808F46B303ECF3AED9E8E2
      2DAD868DB7B45D0CA3BFEB388D063F8DB7C0A6B769987AB78B37D9761779F71D
      288E0EDE66BBED06DDD768355B6B3E04016A1587006B1460B71671540A544EE3
      A990FB310D58FECA035F6150E30B316829C32911F9D2DC1E994E89F538D50C3A
      5C242EE11C322FCA98CE22193D9BC0816761A65E59CD7CE7DE37BFEE6A523D8D
      0E0B4255CD4DE7D7B3FAE803357AE7615E3DC7A51FDF3067E17597799AC42361
      E0FA33E04296E72854FD465FF9EF60328DBC3C08FDC36EABED34DBED76837F26
      1DA547FFC6C301D002F93596DFFF35A8CB2FB1F83624A22FFEC8720F846610A9
      F9AFA93708C42F205807715EFF8DFFCA01437AAFEA766F76E8766DD7FADFB845
      FCB6D9A41FA470E094C492B11BDF23880E0FDD16A2771B2EFE6B20968674C621
      A4870F8B96BDEEA5DCC07463F80AA7B6EABA9265EB712AD663371AE505D10518
      193FD1AAB5F28250B97EA925D15139DDE54765D72BD6E620D5D7D74617E015F8
      F9A4B5ADB432DC803F6E6D9DCEDCDAF002AE0D3ED7BFB6CA95C9535FE7DAE0DF
      F2DAE802BC023FFFC0B555AD0CD6FCC56B6BB87304842EC04BF07303D6F6C8CA
      504EA95C1B668C94D64617E025F8B9F96B7B6865ED16427A696D6DA625F8F94D
      AFADD598A32474015E819F055343F7950503E1F7D00739196868B7FBFB52DEDE
      6A3A204037BBDF1C6B9F3B639DB96FC409BF106B9744FCDB01DAF5B1F60D145B
      FE58D6FE878A2D9BC2DA5F426CD974D6FE1CB1E51B67ED0F8B2DED395AF21FC5
      DAE7585A99B92F63EDB6E33A9DBADBAAE0ED8776A3DB6A753BAD6EFD1BE0EE78
      F0ABA8EE1B71C8EBE4EE1B628BF84ADCBD60EA9BB7B697E6EE72ED5F616D5F93
      BBAB65BFD0DA0C77DF584A62B8FB13B87BA3D1A66A4BCBB9BBEDD61B6EB3E3BA
      2DC3DC0D7337CCDD3077C3DC37808018E66E98FB0ACCDD711A754A09AF60EE9D
      96ED345A8D866398BB61EE86B91BE66E98FB061010C3DC0D735F85B9BB6EB35B
      6F3B6E855DBE8519DB750069C3DC9FBD14E367377E76E367377E76C3CF0D3F7F
      317EDEB03B0DB7D1A8B0C41F02816DD8CD6EBB63B4F5351FB2D1D68DB66EB475
      A3AD1BEE6EB8FB8B71F70E7608019E57618AC7C2088EDDB18D9FDD3077C3DC0D
      7337CC7D13088861EE86B9AFC2DCBBAE5D6F34DBED0AE6DEADD75DB8A76D98BB
      61EE86B91BE66E98FB261010C3DC0D735F81B9BB76A7D5741ACD46955DBE097A
      BBDB6A743B86BB1BEE6EB8BBE1EE86BB6F000131DCDD70F755B8BBDBEA749CBA
      5B1145E736DC7ACB719C6FA1728DE1EDDF22D41ADE6E78BBE1ED86B71BDEBE76
      DEDE70DD6EA7D9ED54F9DCDB6EC3765A75A3B81BE66E98BB61EE86B96F040131
      CCDD30F755987BB7DB6CB4EBED8ADCF6C3A663BB6DBBD536E96F86B91BE66E98
      BB61EE9B40400C7337CC7D05E6DE6CDAAD46D7EE5404D40173775CDB755BC62C
      6F98BB61EE86B91BE6BE0904C43077C3DC5762EEC0BD5BF56EB32AA0AED16E39
      2613CEF076C3DB0D6F37BCDDF076C3DBBF1DDEDEAEDBAD66D7ADE6ED2DB7DD75
      3A0D639637DCDD7077C3DD0D77DF040262B8BBE1EE2B71F74EA361779A150175
      8776D769B89D46CB3625EA9EBF145373D6D49C5D37EC999AB386A11B866E18BA
      62E85DECEED66D5664BFD94DBBE3B4405F37FC7CCD676CB475A3AD1B6DDD68EB
      86B91BE6FE52CCBDE5B4BA6EBBDBA88A90B761EC76A75B378DDBD7B014A3AD1B
      6DDD68EB465B370CDD30F49762E8ED66DD69BB1DA7C2B96E77BB1DE0F90DD7F0
      F3359FB1D1D68DB66EB475A3AD1BE66E98FB4B31F78ED368B55CB75E5966B6E1
      DA75D70511C07077C3DD0D7737DCDD70F70D202086BB1BEEBE0277EFBA8DBA53
      EFB6EC2AEE6E3B4DB75DB73B26EBCD7077C3DD0D7737DC7D130888E1EE86BBAF
      C4DD3BF56EBBD3AE0AA36BB49AED6E1B5E6098BB61EE86B91BE66E98FB061010
      C3DC0D735F85B9B73B9D76A3ED76AB54F74ECB69775AAE51DD0D7737DCDD7077
      C3DD37828018EE6EB8FB0ADCDDAEBBED66C7693A159679DB75BBCD6EB7DD30DC
      DD7077C3DD0D7737DC7D130888E1EE86BBAFC4DDDBED46A761BB4E85F2DEE8BA
      CD66DBB14D2179C3DD0D7737DCDD70F74D202086BB1BEEBE1277EF345BB6DD75
      2AFCEE8776BB01B7741CDB38DE0D7B37ECDDB077C3DE37818018F66ED8FB2AEC
      DDB68177B7E15CABD87BD7A9DB4DA7DE360DDC0D7B37ECDDB077C3DE37818018
      F66ED8FB2AECDD6900F3765BAD0AF66E379B75173888691563B8BBE1EE86BB1B
      EEBE1104C47077C3DD57E1EE6EDBADB7BA6EBDA2585DBBDD6A3AED6EC7A8EE86
      B91BE66E98BB61EE9B40400C7337CC7D15E6DEB01BED46A3DD6D5585D539F566
      B3E3BA26ACCE7077C3DD0D7737DC7D130888E1EE86BBAFC4DD5B7613D477BB2A
      68DEEED6E1D0BB6ECB28EF86BD1BF66ED8BB61EF9B40400C7B37EC7D25F6DEEE
      B8ED6EBD55C1DE3B4DD7ADB79BB661EE86B91BE66E98BB61EE9B40400C7337CC
      7D15E60E7CBBEE36EACD8A6A756EA3D3EA384DD7349131CCDD3077C3DC0D73DF
      04026298BB61EE2B31F796D3B4DB8D6E85E66EDBCD46ABD969B8A6569DE1EE86
      BB1BEE6EB8FB261010C3DD0D775F85BBB7EC66BBEBD61B5585E6BB4E0B33E20D
      7337CCDD3077C3DC0D73DF04026298BB61EE2B3177B7D9A8376CB7BD9CB93BF5
      2670FE3A28F786BB1BEE6EB8BBE1EE86BB6F000131DCDD70F795B87BC36DBA6D
      C7A948766FDAB6DBA8B7BBC6EB6E98BB61EE86B91BE6BE0904C43077C3DC5762
      EEDD7ADB769A8D8A0E71874EBBDB751B4ED3D4A933DCDD7077C3DD0D77DF0402
      62B8BBE1EEAB70F736B08756DBE956A8EE87DD66A3EB34DD8ED1DD0D7737DCDD
      7077C3DD37818018EE6EB8FB4ADCBDDD703A6EBB59D9FFB5DDB11DB7612AD918
      EE6EB8BBE1EE86BB6F040131DCDD70F755B87BC7AE77EB8D96531154D76CB51C
      D76D18B7BB61EE86B91BE66E98FB461010C3DC0D735F89B9B79A9D6EABDDEE2C
      67EEED46DB756CDBF076C3DB0D6F37BCDDF0F64D202086B71BDEBE126FEFB8DD
      8EDBB0DDE5BC1D0BCCD79D4ECB356679C3DD0D7737DCDD70F74D202086BB1BEE
      BE1277EFD6DB4EA3DBAD0898B7DB8D56B3E1B87553C9C67077C3DD0D7737DC7D
      130888E1EE86BBAFC6DD81B763F7F60AEEDE6C825EEF024C1BEE6EB8BBE1EE86
      BB1BEEBE0104C47077C3DD57E1EE5DECEC0AE8585584D6E934DAA0D93BC6326F
      B8BBE1EE86BB1BEEBE0904C47077C3DD57E2EE76D369D4DD46454CDD61D3E9B8
      76CB6E18CBBCE1EE86BB1BEE6EB8FB261010C3DD0D775F89BB3BB663D79DAA06
      3276C369B59C6EB7612CF386BB1BEE6EB8BBE1EE9B40400C7737DC7D35EEEEB4
      6DB7E35614AAB33BF576BBD9E89A523686BB1BEE6EB8BBE1EE1B41400C7737DC
      7D25EEDE6E3BDD46CBAE2865736877B002BD5BE178AF173B537FEAC6ACB4170E
      FC573F9ADF07DC2458429A4783716F38C86CABE70D89BB4779CA97F49D792AA7
      7FCEAA9E7EDCB8447BD5252E5F20F2F8B9A32FB3FFCD58A5F3BC553E22062C17
      71FEF855BACF5CE5D30502C5E3FFC055369EB7CA2F100D969E6421D9BDC82A9B
      CF5BE51708094F81D7758876B8CAD6F356F905E2C29AB07265210F57D97EE62A
      9F2E38BC34ED218A37B7CACEF3564912C3D34588363699AD578910AD6EB7D16D
      AFBF4FCD1365FCD54C04DF888180E5FB759A08BEFA929E23D63FDB44F075D7F6
      8881604EB65BB789E0ABADED1129E09B365A3DDB40B0C146AB1737107C45A3D5
      D73410BCB4D1EA0BB8BB53B7BB6E070BE3541A085AF566CB693A6B88DD5B3CF6
      FF18F66E38BAE1E886A31B8EBEA16B331C7D8B38BA6BBBEDA66B577174A70EB8
      DA6C35DD86E1E8CFC4CD790B8D61EF86BD7FCB6B33ECDDB077C3DE379BBDDB8E
      DDB091C7FF0EBFFF99AE2637419A867E006344C16FA54BE22917CBDE3B8D66A3
      F4E32099C14A7A51662BD49E7BAE6874B7FC4159AC67FE319532B0FC3177F963
      CDA6DD6A74ED4E7BF9538D8A97A9763DCB1F6B56CD518646E0292F7BB055F1A0
      6D373B4E9B316CC963EDE58F159696E58F752ADE568723E8346CB7E204BA156F
      EBD49BF53A4B48CB0EBC5E79E22A97B3E249BBEA146475C68AE72A4145BA972A
      9EAB8015A761771A6EA3D1AA78AC0A58EA9D66CB06F874AB4EDDAE8217D5D1B9
      E2B92A708199361DB7D5AA5A6005BC74DB9D0E36A3A84021BB025E9AEDBADD6A
      76DDAA59762B0FBE6537DB5DB75E85B34EBDE285DD86DBEC749B6EC56315F0E2
      BAAD4E077495AAC72AC0A5207F15CF55800B3CD480036C775B55E7EE54404CC7
      69B45A2EEC4BC56355E0D2027CB031B8AAE2B90A7069361D00967A15943915D0
      6203216BBA6DD7AE22D49DAA736FB63B0DC0A56605783A1504C6765CA0316EAB
      8AC257400B1C5D1BA867D3A9D816B78ABC346D785BA3DEAC7A5F15BCB86E1309
      5325BABB15000394ACD968D7DB1564D0ADA22F006340B2EB1564C9AD8016E00C
      7540F8760554BB15C0D2725A5DB7DDADA2D56EBB1AD95DA4B9B65BC133DD0AEA
      E2206B007256F5C22A6001C8ACC354EB1550DDA88296461B848F6EBD5501D58D
      0A68296C2055C7DEA86247AA8540C57315E0D26ED69DB60B805DF15805B87401
      A49D7AB755810D8D2AE2A29A18553CD7AA66EFB21053C59355D24B1736B3D16C
      57896615F0D26E0037AA77AB5E56052E2A2765F973CD0A7069B87076CD6EA7F2
      D49B55D4A5053CCC6D3B55C7D7AC8216F48C8160D0AD80CF66153752C52E2B9E
      6BB0709F0637793FB27EFB1C5FC7C96DFC57BE3A1D4DE92A7EE985F04FBD17E6
      DE140978BD97C27F591FFEF37093E41D184BB3FC1E7E4F16FA38247D69755CD7
      6EB5E93B883B5DA04DF41D84501BF401786032F1F2F1C7943FCF9338771BBD49
      3FBD7E13826A25BE5CCEE005936CE245D179EA81F235F1C36C7A1A0CEDDE247A
      E7A523BA3755DFFC60F8FF0EE0B7DBD49B5E908A45D6B04918E76FC3097C89BD
      F41EBEE10986F130F9ADE7CDF271925A57F04F061A9B75168FA22025C04FA641
      EAE54B7EFCAD37480350ED26BDFB1405F2DE24B1ED9E7F0FEC689C36F06DC480
      70DF1FBA078F15CE2C0B93186F0F7CB848BA509C0CA7DE28C89A1DFEE336497D
      90285B44E0E0EFC1D84BB30E88D8B6F6F76D86A8D57178D018A4533E95BB4914
      677CD2F4D5B6C6793EFDEEF5EB6C300E265E76340907699225C3FC68904C5E27
      C36138085EDFEEEEC04B5F3BF5BAFB1A5F3F897EFFBD37F560476E6164604CF4
      7D6CC331777A13D8FE88371ABEA5EA5BAEBEF5E9DB6896E7415AC7A0B22C18E4
      188A7D1BFAC9ED204FA3DE308FFBFFEA7941ECFBC9A097C3695F4F00A4B33A7F
      1F2629C0491EC623D8C5244EF20014633FBBCF86003936EC75749FC43793A8AE
      FD0A2AF0C8F7720FDE9C0E615450A8E31C06BCF1A210AE07B01F762F1B27B7D3
      0834F37112F9A888031E8CE2240D26E15DE00F607454D401CA6F8230A627EFF0
      2DF8187C019403D8B0E114EE22985E721FC4B0AAE06E9A8DD33C86CB33582C68
      FE839E1FC321C459DFEFC3553205C09266B06E585836F600AB01CAFE8D6BF747
      138267F832A61B416881EF37DA77B8351CB189177F29FD35C6A9D9F4007E412B
      23CCC78BFDDE4D18DC5E87B16FD3B76CE04501DA53A7A37EEAA7E3C0F3C5D761
      92E4BD6C1ADDE7B77118077834EAFB389F00CA64535844148F73CFFF172CAB37
      CB8228EF7B51DC83FFE002BCA4078FC01B06F0D72DFD015FD27C94F6A218701B
      561EC010F0ED36453AD4CB626F9A27232060613C08A208068A92DB61184480C5
      3E0CDF831BA7B378802E702F0B3D350A529514662C284B2F0E6E61C02CBF875F
      3378C7284D6E61CAC930CC719E31EE777E0FDB8E44137E87B9C6406EF2AC370C
      706E4114DCC0E5C15D36255308100A1F8EF016AF0778A4DE7000188593F68674
      F30CC032EA8DE90EDCB71C68A597C29DF9E0C6A3ADCA61B2F8D030C5FDC00B37
      5E7ED7BFEB5DA7F134CDE220EF0D3CC04780B708B6D142C009011DA75E6EC1B4
      D847F0E7DE2DC0F170920FC308F0C8721AC0C210FF8116CDD2201FA7499EC391
      F6C268984CBC81970FA2783645734D9EC284AC1E629D6F49FC032A1E0777F51E
      9E7C90DEB7EB9D1E9EBCF80A33C9EEF00B6C7F3C0ED2809EC647F090D0F244A3
      05430F407C000748086C116B89E1A7E806906B1ACF06E9042FA0610CFF66C317
      9A14A6F1D88B47C880E2FC2EF7AC23C197C4C30E9C333E0E93FDA2E75DF806CC
      F08B9E6DC0B768F537EF979F6EAEFEE6BEB5F77BD5302DDA8095A7F1D0506D1A
      68B58378689CCEBA26D45D654208F34B4702E69302AD8ABC30B6046CF77E05A4
      29A412BB8E149BFEED23EE0399F7F813180E40313E813282005F2028532F9A8E
      3DFC12CF26BD21DDDD4B6604F06489ADF780D6CDB21C48ED3887D7C464629542
      130CE869E28D3517490DDA4EBD0D9F99E3006183C5D975A7598AAE463F18FE8A
      3FBAF58E4D5F8601DC07D2790277F120ADDE38D4FEF0FBEA8F666F808849CFC5
      536D88788A83C0A994A6D4C7F86E9C51A3538EF2EEF7863648B0F8430FB666DC
      BB06690218A9DB024298696BECA1D8A1AFF9A7B197BFCA2CA0BF161CCCDD991F
      E656E3A87EE4FE6F8464A03F7C707FDC91D94F3AB2AA0D725B151B043B421BF4
      C8B6BC998D86204A64BB3B621B5898279B7F01C88A463F1C822FBCDA8FBC5241
      8C04903A83CDD0B57AAFFAED1EF0B5DF971C46C947BEF2A9CCB931F1D915CE29
      CA969F0E3EBED2F9F0E1388DB90DE2A3711A8F6DD19F5A8DAE75687DC2975B20
      1D0596E0AAFDD968A3CEE94FAD660326FAF3F987C62FD6C938185C5B20BB5867
      24787E67A5C13401D9C52241D4BA1D8396E2C1C5112815D66B2BE9FF0B056D5C
      8735F632EBF2E4C35B0BA86C1A223C6ED62AF1387EC2F993DC03F03082750C50
      F539B008460E01CA06D7783D4FAC331269ADE328B2A669E2CF0641060B2771FD
      2E9F81083509E299950349B2909964F0350022AB3D36446112B60944FAFC7EC3
      36A3859B7172F6F6AD05F3AF1FD4AD89776FF5032B9BCED2309965D1BDE5F97E
      E0E34E807A16F9A41B64963FA37D1B44818734FB68C396D5AE2B483EF526A0E2
      C2BA46E1C00A864300D3CC9A8459E4F541FA879565B33E1FFFA6AD01B1F18235
      41EBE2EA5D26CF863111660ECC0F2857600DBC0C8E845012953C4BE8FA704A21
      AC37DDB475B5605DDF8F930C977076F911D00910E55DE283FE349B6E1AB56877
      60B6C70380F9ECC73001D51BE9DDED388C026B14C468B7213C48E221D08CDC02
      21339F65E593D9B015756D811BAFCF3FB45B40EA93E93DAE81A8005A3160F680
      ED1EF2295C01D0490FD4590B843C1F54F9295C4B22580A6E04DC47007918C4A8
      C1FA0C84208E65E36416F9F1AB7CD3168F488506297F46B8EFDD003F4E9389F8
      E6851128B816A8CDB028B40AF916AC12284416FC3A0376065F091436EF509BB0
      AEABFB6982A0F753E04DFF7EFAFEF8DDDF8FE370C2200BBF05DF596F3CB2E80E
      ACC3BFE377FE63C396D2717029C044A75E3EB6FAF0F2015A9C99B1027DBB4569
      124946DF0311A53FCB732475E1907EBF05E52E01B500EE4E128BECB91BB6BC2E
      92BFD36406E862BDC5FD07D44B8656ED34405B2FE0D9D9AFB3706A5D8593A026
      0F13CE0FE8A37546DC6BD3D6D34609C28B1167BCE91404866C90865360B2B38C
      C84AE421BE1C5897F7D9E73C8CF05B9ED2370B04C99FE8C0E0E638CC370CA9DA
      75A4FDB513947180F702BF4AB39A92E62C3F093220708250580069F22694A586
      610AA230D0CD0D5B938D6BF2888859371A4303B28D76693C311F94DA7CD3E6ED
      A044779B26882DA90FEA13EA26E740E38814BCC52F802CEF3E5F5E6DDAC46D41
      CEDE5DBD7F67919D1967FAE9F8E44CA81D48AD6ED33047C7CF6D08346F16C701
      1E9097DE5B004F93306629A36EF5EF37EF60508378FBE1F47B54A800519087F2
      32D20084CF20467541A8478026EF3F83940147378BD3204BA21B141B801501DD
      3B07D1F5E274D368808BDCE87D706B9DFCC3024270038BA1D98AA3C349829080
      C0C868E35B9FCECE3F019163098844893EAA1FE935FCE609FD79D316E9C22207
      A8BE92D2CB7C766281DE019C09CE54787C7D3862B16E49FC6653F46FD1235118
      033B0EF2DB006E63471168C7889DD2610C870E641F862053EC8699A960175036
      24038095E16C59967895C935CB65805E95E0DA87C900447DA09E83590A709E23
      EB03181820104C920D5327DB2EF2E9E3493F1CCDC2FC1E49D0E5F57D1A4E607D
      FF04AA09E03B0C81070337D8B08937AA27FEF118B07273278EACF64462D5B160
      517393073C221AA121D209DE3905A564BA61B25EBB894C589106810EB014F88B
      A8075921506BC4652812801C815462D486F15E8E3587E7F821322E019509EE84
      381C6E16EEEC29830BE0FA69982131D84782298C5FD669EA8D92B89FA4F15190
      4D880B4EBC6B606B8997E2E9C687DE6804542FE318FD6F6065A9978DF1C4DE1F
      FFF88E85C33C0D3D0C4AB1027F14A0C4328C6051C4D27677F82232800354C8E8
      F8F990AD2C4F523655E145BA8F6520D825A0A151925C03EC5B9EC5762ED89020
      45A0A137DF841E3D76868FBD85E141924081E19BD8C41F83F4FE9FB370707D39
      4E6E4F8481888D788039F76420029681C88FF113D620487374344A5BD2664942
      55ABFC01A63448D042BCC7029CF55F56A75EDF27A6B9BB93FAA00D098B0A20BB
      8F46177834450F3FD1726094B3484A88CC57494EC4631F612A09EB54283979E2
      FB46EDCBEE4ED5CE783E69531EF92979999637C4B5C002F1976990222D451C02
      2D937C11817595D4ACE92C676B87FE2463156B4051E2F9AC066DD45E54ED84E6
      321A0863631C0EAD3E0C09184DBA42761DC6484B376A3DD567EBB3FD86FC44F8
      5318E7C108A114A4DD219C4E6E812038C120B082C3139287F121C58001250C31
      E28FCD56F784233063143B3DB4856C983053B50F80C08A96B1B1FB009D63C4D6
      AD0989D26C4BCD66512E9900D995FB018241A116099C98C5688855E2C486E908
      D50051529E042144DD49EA0EC55E78D1AD779FE9F25E713BFE553B0109CA4F51
      871AD62CF289907A490472031D55553BF28EE9166B4468639A84593F1893068D
      EB91849FD01F7ECB181EC880B6590B1C2633B436DF83A671134418AC8BEBBBF2
      87678CE3476F811C9F83BCFE29C892590AC8AD709EF7461AA753F93BCB3E7D54
      B361E86F61B524C8583F1FCFF2E4178B2DA2143799C90316A0AFB3ECBD5B1C9D
      4461DC0DB833CE82FD6F61B5EC390E6321A9142E62617B044286DEB26F612961
      FC2FB648881007258D213B228A3BC5E5F8693205B0BD45AA2309D21CAFFA1656
      9BA45320C4B0DA255434D37C99C7591660308B506DEE45AC07C6FC47209F0324
      4F24B78ABD1BB823082C0C6556FC683B23CC7677DE8531D06EC59D370822BE7A
      9899F395C3CCC8C0A7F9F5AFAECEDEC015918CB3C4E7507B130580431F28FB04
      38746DA3CEF34FAD76B7BCA01F2F2E2F48C2FE78F2EE4D419341C4864F7FD394
      873FB51D741D64B3E130BC6327A117C9B829D4FBD068C6DAD086CDDBB5150BAC
      49E8B1ED9A2488B5532FF70ECF236F94D574CE38E40812792808603FB0CF8002
      2C2E40454A43201E27411491E77BB3E00D16ECBE3E7FFFE32F162ECDAAE372DF
      7CF8F00F6B02C20EACE572902651B4A973267B63ED133A5826C12539E03FA609
      6A5AA9757779669DDDE5207DA118FE3619D52CEFC60BA38DB3A47D626999CD05
      0A8E62EB2388D120B65CA25D88D485E10CA331313C04DE9A071E411FD25E04D0
      30B5B006C946AD0C4D80189112E5E1D41A87714E2AD08F20516030D56C125B9C
      1BB3592CF5922D167E38103A1B68E7ACEA5DCEFA9F18ED8FD314D4D98D9AF6CF
      576797CDD7979767BF88D8D5B3F7273FA078F70F2065E46F460177B3E67C8CCA
      94E581163C8AA5302AFCC90211366ABA677753929F51A2F640FBBB415B063A8A
      A7323E12143F8E09CCD8B503E4078F42A81614454CC936E5193B240395E78D09
      2B8DD5A65EAFDB0B433E4FAC3A5C698A2B4FF0FCFC7CA50952B1BA15A7A8D3C0
      F5CEB6436596FFF8ED7CC289AFBAA1AB4F715F1AAA27538FED1A940571F976CB
      353F600640FA51B7FE08EF9C049A9DEE8FD892676CC23301E2329904D6747747
      AD9AA81EE54804837018B277D343838AD8A05B0FDD7AB7DF7D01C95E8EAFFF41
      5AB2FB4C2DF95904EDF0573463A2E54B3959D74F8EBD6CCD64F8F0D76CB06622
      B78990B9DE3D43B7D463A78D09FECFDCC81738ED1B73DC4FDF34A42EE87BC018
      946FE190BD5164CEF84B8837055D556EDD7CCFCDAF49B40D127FD10123262F39
      E4CD44E35FBD173AE56DD5324E4418699EB0CB191DCEE46EDE0A556377E738A3
      C4CB3B523A3D8C02EE47EC8B3CF56EE3D10C164F31A67B591058584219436BFB
      4144863AB83DB8C1AC6D9901BC6FFDF3F804D4918C026D281A2D8A74CBAA2732
      3809E1308F014373F0F6C427CDE6C0923E7C3F108536309B6BD2E7185F950791
      B18D1F762783517C5096288DB46C9BC51C17CA761311A298CC2202FF6E831487
      F24402A98A12C2A963B05BE0CB0CF3AB719889782256BCC416095F6E554CEE1E
      FA8DA6499685FDE8DE4AE00529BD21DB9703F3EA428C54B8B59218EE5AB667DA
      DEE0CBD74B4E4A47FC327485B68FC270004E52A9C9623503F46EA0EE8AF67507
      4F5268BB468B5DA2C536BEAA16FB3E41B2F80EC0F39D80C5F56BB1484A287E11
      B1A0807942738EDDC364CF9083F7BF361A3C69657B4C3D28D18049CD65328BAC
      132F4C63E17BF203CC61EDC3E288B47E49CCD237267A9D27E920A886A8B5485F
      1CF8C860330F5700447812253EB4C7617329B3012FBECFC7C23542B7ED7F2551
      E969F5B956AC86056B597F3D2C67BBEB61FD23393C0FFFD088ADAF27391ECB7C
      1B10B66619E5A0EFEE64D72235D5239334204E369B928B9D614484CE610C2BF1
      7D14CC3869FFA397A7411263B4CD6B78FEA377FFD18BA4A474A1C4242150058F
      0F6DF541E602B10A6E0D270145F14C40E8188398E52731851F6594EE43877680
      1166296617F9A14815A18A2483144311416A8183E489E26E4F032C286BEDC144
      71049EEC3EA2C2F1E7FF55C88D018F0DBF7302139A8AE00D32C7887FE4721292
      31E4C954248482F417F3EEE2F509E6E9600CCFD15623D8EECEF72024A61F9300
      E4841F433F48B6C323046A1A11DB1AAFB926A1060B9FF531FB99C30E9E0A4424
      9BDF86A06D2453AAAEF63FC9EC6A06E239C6A4526535C2244630E17C1A00FCE2
      1C3012B6388CED064B530771B9D2D2FCDA01AA4579411956F8310021F00C94CF
      FB6982515176B3BD51670693C6723DC732958F4BDB8016E48D88B51157FAE72C
      C850FEFAF1DDF1E903F511E4432758369F9360376AADE5449EDD9D229587294E
      1A4C02EA1166EDCDE25B2F863BA3FB7D99DBA2A8199B9BC2389C84FFD60A8291
      25C7031A3688922CE09A6F58082249A50D084BA76D56D45E75BAD74FD24A9561
      BE0B692B40BB39752DBF0D071CA7186AF7640017B17F6085321B8EED6FB14A8E
      C431D220F6260869475C8E0C0D5454806C3CCB313963A376A76A6F7EA680D4CF
      F10C4D81226D15E3CC81EDBD79777AC5D56E927884A21F966EE0FCBF1B2F0D29
      362F03B0B1F644F514A133020F74D95CB8BF6144BD1A444E9228F2A69928EF25
      C802C23B8A9F7BB4395C449568CB6B0A10C72F1861A9A5C2ED938D6E1663DA91
      CA100FD3C16C02F842B5758AE44A0CC6A3C41659854125B66432A59A40153BEB
      6E563A4FF536D64E83604A350A114A3E889A13B522C56E40956A359BF600337F
      64CA0F6D31161990815CB24417919C3860D303C097AA724A221B2A1F9B557CE3
      414AC4BAD07A4D42173142D2EFBFC12EAC530CB0AE837B291963FC3351C4908F
      525727314BEB244F23FC3E8CC229A71E9C53C91D90BD555D5A95670D63E27835
      1183FA4D1CDECF14A47C7A7C754C95FE8EAF3EE15630E9FC2616F093B01A60C2
      5C704067140EA81C6385EE43B51D3CAB1F51ED46F807F11498C31EE02396F7C0
      0625F5DBDD1DF8BCF75D91F88C64EBEE9B481CBDE42CF6F562229BC1D78D87B0
      B36B9FE6FA635A840C24AD536797EFA8F00C0106200FDB7FA600971FB8BC92F2
      384A6723792C813DFC3A0BB10ECD9E4A52CEB1B352A68D2F1C9A81CA9491066B
      559C00DEFE4D40E17ACF15949F77CC34F7F6D70F86D203E915DE47CCDE110C5A
      262B737120510A858EEC5B38872B4E1F0E475C6413B388318958ABEF18021F23
      01061920569663DBD084D5292D999EF36F3631EFB62A85BE48C2F989243358D9
      C7E49693E72F7FF8F079AE40221CF028DEB88CB4EAFA0022EF8E82C3910871E5
      7F01B279EAC51948D9A4D048182E0A666115E9F1B7B64ED02ACEDF5E5EC96383
      23F3C38C8B7ED363647CFA1616753A9B46E100AD32E52201DF7FFAFC3193CB13
      853B3CAADE3684938C84A2AEB118D6B58AFCDDEDB4B6EEEE084D1700E124897D
      AAC4B82D7E80654B27CF98564902A36BF8278EB80ABC0CC93E463B117D109946
      968D1E29AEBCEAE5D282AF0DCB74841246C53B0BBC3BB28E55F2DD9C1702DDE5
      1CDE039309B7DC35509C98485C6589E34D1003F7B164913EEB2326AA63B151D8
      E1D31265FBCF0668766B7D6038AA9DECEE7CE166D5E681704F2C99023BF37416
      A8B03B614905B557802F7CA38C525027F5B77A4B5E8816459E0C79CDFA58420D
      900544C9FB024BB61DE0DF793176293A918191B27E3D13143F98A60132437F2B
      00FCA1EDD87B754CED0BCEB93D17CADBF2AE5707D6ABCF31276493E7E294451F
      EB932A710EB7E00FAF3E713780DA05F6180431830C58AC3FD5A495F2156D3DDA
      49423F40AD34E96749B4BB83A34B4D144B0A52BB29420A80F4575C820B23FF78
      5EAF501FE2E910F8ABB8552A34E85913D43046A8D092F8C515BA0A06F02EA192
      83CC6E48DDEDA3863DFF16A9A0B12C150A5C1511475817DD4F0633F285ED6135
      4F0CAC9B46E4B246DB3485CF1D90318F3C21810787A6F67C7FDB71F367AC11FB
      8BD873AAB6A0EAC41E2C29B9C620466783BE7EAA888BA518B0D65EB02D22D715
      59693258F5446ACCE49E24644060453C4085921BF5C840212EE5059B26A22F82
      BB80C4315F8866C2E40CBF4E55E8B30ACC482404C3BFF4D603EB3E99D1DBC865
      C7D08DC5FD8F46475F1230FD1F1C75D0FAAA510788604BF1EBBBD5AC644F2945
      F0C145405C5EF6F908E06DCDC6D1F55B70AFCE2E1BB4847F5E9EF084D76CEDDB
      28CC780654ACBCA3BB3B979767B8A5DF2E443469FA1220D61C8CBF810051883E
      EB0686F3F73F2A5050796DB8ADBB3B1B0F08E71F8832FCF3787538780A146C20
      1CBC0808480A4BAF50E7FF0D38F72419DB82E32FCBD76B27028C48F8127C07BE
      E21B010139F3EFDFBE240C6C9BFAA25477D11E8034096E8A689D7853A9FDE3D5
      77E813E49F0E505FA19A8FA0F9045EC6C91D41C02E288ED7542638EAB6C5F1E8
      9880C1A3494D66DB5570C2762CE04E069F459D7B2BC0121DD595C462BEA6C653
      4AB260EEF6BA651BA59F4BD314C552E6C928A0AC6E32A0AD5BB77BB034C506D2
      EA17AD95B26820E18CB01C4DF95AE7CA4424A9B0174C046F70A8B7F221CB84CF
      2416AEB2C9046D5C4826E4E064537919710619D9FCD916802B82F75F2E197F3B
      692E51DCB3BB30DF129E7F251A39BD08810D601FBF0681F5B47C533F1C921724
      1722CD1EA2EEE868A9019B1BC51E585CA27A1F890485848ADA22702B7A2306EC
      C2C34C11D1328B1A0ACA42F5D47E2E8CC36CBCEDEEBD33CC0BF0A22DC1A4DD9D
      0BF6EFAA64632ACDCA7B30E7722E97751180CCC6FA17285921E62079CA0BC807
      52887F19F126E0F9AF7BDE70228A98C80339B638F54F96362A9AE78622822E1C
      AA33C5AC318CB8E2E850A1C0800E2F3C96202990D041092D163A5EB997A84692
      D4CDB4719779E04D0EF86369EFD534188500DCF7851F96AB2AD0147820AA3B8F
      AF66D092A107338A5EA4740550D1E40A5E6516B64BA0878EB6BE7BCC39F68C9A
      E556BBB525F4EA54F526CE98CF1181627863501D0C381D94420B0729E8F25CB3
      61226B7821D4DB47F5A306C11C7E6B22340DC64677BF14A97220835CBC3FFF30
      5729FF3F1DB63EAAC26748AA680364EE60016A9808EF13E4946EC020AB92ACC5
      B5FAF590422E1C02B46DE4EDEE4CA8B33396E241298D2BF81C597B5774490572
      A7131A2B061849C905AF12ECF2594A59C0C970C8410C7841A467C035E1499779
      8C9C93C155A6308F23A710312F97C6B2F98692B24D1B2D913BB451DE1F1594EB
      DF178DE902ECD1889DA9AD937F1CC9548E374516D2453C4CBE2BC112F5EC8B38
      7932DCDD49AD8F9867B2A70AEDE1BDD8EB568401C97CD749C2E9E1B2B527D7B0
      3B10F94C2185C1DD26E9B5D60B97B98F18C7D727614DB07A5E71A63C187C87D1
      82238C4EF006E330A04986D94179FE5A8AA3E8DD812427F5456228F74BA145F1
      78F3DB9ED06914ACEB8AEA65A572B3E7424E33800C3C1678ACA6EEAAA9F03F1C
      EE0AA3FF08066AE7789CB2F523CEA17C27708B2C204B276C7716A4228555ED7D
      51C68ECA0716B342A901010CED0A005C054CEFEBD56096656650EC4881026893
      E54EBC34EEA00817B74E2F8EDFEEEEE879A7DCF31C810FFE0B6F64B1346D876F
      BC6886FA914A0AE7DB09B415A8C0A255233A96794EFE21259DA2FD209765540F
      813025A25D3470DFD783D5C5E1C3CFDC82E388CB8DC8F41BD188BD8895C198E1
      E00E54BA209E49EB8C68DE5174ACD9DDF18B7A26C57E666A43E57E63A0586136
      D26079498C329AA6F3DB44C0166C9768344F60095B45D4A580B8409101F9C02D
      A7C406FEFEBACD46870863080A6B77841FAC7BA6EF9327CD75ED337D8AF68174
      001164ED3345B459FBBE3E3ADB2F35AC6EBB3887299C9F5915C380C62D11E338
      7195B90C767FF2807305DC3BBA68AEA777CEE64E61C43540BB14B6398BEA43A1
      B826A8A54FF24FC19C82C93449D12C4F4DFA1427136512B4F18F84355FA5CC72
      FB9B772A7F8DA533D45DA867956E8A41C98418887A1B884C6212497CE80764DC
      5F94C88EA4FD2F4291ED7EDE0EA86424944AE0DDB4654BA7255148032515175A
      1832759323B6925B7821A60607FC1AADCD2471662915C7C013175F4F82C57496
      4ED172C9621EEFCFEE0E2593011B94690E31E52F9FB1447A8EF5AA944F57ED0E
      7921F06DBCE7680C11FDE249E211A9A147D6F92C25D3EC623877AE317915C23D
      FF624D2A4A032EC680B2735684C5CEEF274C03036041F4C02247A34448931C25
      EBE52AC2FBC1B7C14B66B25C25DC37F78E22C43608697122D236CCD76FBE8329
      166F7F91E80665C2A35A48D2B6B466DE54ACE1C55C0285154FCF143AE64C79AA
      32F381E4F8C7F37FB4CC9F0F0B993F9A698D709E719104BB8C73F1510B5C827F
      7B5A450A31EE817C849339E71FE2B7501D01AA4C8E6F52BA21CD11A09474D505
      00D5D396A41950EA1D6C9D5445A16429A820CF29555828554A1911A3284C4D07
      3C482190AF1956F8C8B0A5E687F54B5E8BF0B2AD32CD513FF35E1FF53DC7FA01
      E021FA639385BF9E583357A372803C6348510E0B616ECFAB3902DBBB66D87DBD
      E6AA2870F6EB0FEE53E4159387312B8D128A29E9CA2FD80B6F3B1A21D6BBA637
      97C7F0D0DA75E0521D54B64820FBC84A22E6D5D9A5BBEEC235EB07220BF3DCC2
      9BDD1D96DA6EB1E5B5575E08099222FB08B304833B12FC5980E3721FE71FD8E8
      8FEDCFD50D2F019E2FB17612F48AF820169E49CCCDB0664698653365549685ED
      36FE5C5541A23D8C4AC25A41A967DD24D420994BCD79D8BA6044B965EC652C59
      AA40FAF99880AA3696B0DCDC072CE582135A15BF0058459061EB93642A6AF991
      F088B20091D66D67ABDC7F580878DBE2F0A15A3362C99A0955737BA34C2E5B33
      E75E5F58895148C5BCE09B90ABEB09E50DBB6153222FD699B68E010D4F518FDB
      76D0BA1CC3BBA95CE4E53408FC3754DA7B5B40EC03AB29B5CF17D6A550556A08
      490702B86ABC3BA5AD59B9CE794D2A7A73913ABA02140A338B77E38511055428
      1F9FEE8FE091B9EC3A3B22A97A209A5BA880A0563E309C4C53AAACCA59F5282E
      A16F8E8C244ACFBB0418E466CF0B3A5DCA09FD34074F209F74EC583F04D1D47A
      2D6ADFC397F7C1DD2C7B97F8F8FDFB30FF61D6872FA25E227C936D155E8B6E03
      AF45B302B512D3D244BCA3AAA589BDDD2D4D4C69FBE549E6EDAF9A64BEBBF3A7
      96DDB10E2DF7C825811D21B56E0D81849155946D46D28CCC7DEA50BD11358927
      D6C5294894FD34F0AE392EE3300D38BC16EE38009297E2AD9B557A1256DCC5CA
      F85C030D681AAE16F5935BDD64F6E9ECE3DBE39333EBDD87D3B3B7D6F9C5DB33
      EBFDF1BB3351477FA3165455E2D6CBD19B81D7F906117014C4A05DE3772E0B37
      21C65708F125091E4162907AD986D5FCAB583056E57D0D60798B283D49D0A62F
      D893E5276477A5C8155864ABD10FBF8D437C1B8CB0043D0630908D9592ED6653
      3695D4B9E63CD75827E574305FC76EB357C715F7AF4ECE3FE3A970A0579161C3
      B1B3B5F384DC759FA7B56F634D45FDD0DA470C8549515F0169B4A8A6A7E277B1
      D4CB34B77EFAF0E1A31665F24D2CB39F26D7C1CB183ED66C737C11BBE87A0D4F
      BB3B44650376A64B677438D7867614B23748B6DE1075B2BE097011D5C52EAEDE
      E9E5733DAA5B06924618FF0BD41862557A24EC66AFA9761A7A5132B2AE926938
      A87164E04F491AF920EC0D829AF53D872808D7D80D16F4C99092C17A83BB29DC
      FE4DAC92139E44552A8A83BCA462689F82012ABD820E6C26535D5E4757767020
      4B539869B517A5A149566DF76420ABA8A32ECCA111C3AA50F09784636E989653
      B10F64DF90C2BD90908A9095813718075A8827374010712E5C0F4F3569D43A97
      6CD4C277772A962E7A3F0DB12B07AC627944AD4F21256CA5046880770B6B0A27
      FE286889B9B05AD10E04948444E4FD00BED068A5389D8DDAA38A1D929E0D5678
      B29749DF02E859372B45BD255B7F5EFAC0CBD65F448A3B87711718D6C348F35E
      7DAB9FD0132707452255B171EBF72EC922E3C006AC820F6CA7B16B77475847D9
      D0BC2526F837F7D63499CE220FF308305E126DEF2533F17C7015328F69904C65
      758529A591A868420F93260F31114276DAD5456278CA2743145C16E6E96DF700
      15467C94458519BFBF557E208A7B63978FB05EA26346FA640E746F8874C63CB4
      6B45952390E0FB49C419696470C1D3FF6A49FCDF8EDFA3BEDD7E0F556F7A77E7
      764B50F018B4605565BB5694D92E42BF284ADD9771A6D89B55B49D56223696B7
      D1234D39B2BF1CEC8EA650CCABC71CB251EA4D38D2E4C87A233A1349CF69ED34
      C1586FB69CC63908582269ACC6F7F593BB427807F9314641490D3E9C51F0128D
      9D89E7A9D2D99242E2B8429990B6D70F061E9AA0454430FC24B2A7BF5AF17067
      2D18E1B42B30C269AFC8A6AEC83D0ED4F7045DE320FC6E096260B4C0D5871329
      0C69D10751309C0F3ED0E08B8CFF7B145D403E2A80B7EBC2FCA0DD081BBB3F9F
      3142600F72D61851CBB316F65E01E35AF58DD36486EF3989C2C1F5C6D71CDBDD
      3983BD58BB262ACE074F9C23F5C92A20A2E9850949A444293B816A2E12FAA003
      0A50C01190FA11E87AD23E85695698B4ACC5AA5FA23A69ED49BB046C549CE4FB
      A2D1C2E2801CE0AFF5B3168D7D65C6ACC822F6465EF8D544EBCDA0596CF1DC9A
      6245C7B2DF45502AC759EA34AC911DB4A56A0913EBEDE1F8F6CAFA8B75B9F134
      E4E4EAD35B98E8F9EFBB3B6B9E2AD928F52624811E46BBDE42B9EEBAF759D113
      B235531C1C96401366D7EB2098666259145222A3D3A485153E33B4112419394E
      5F66D52F41FC77778AA5EBB8F494C5CB554B63B5188736714CAD617153B1F641
      2C84CE0395AC97A906C422776FF910E2B9ED26EEFF5F924CB688B4FF3B41384B
      3D507CBCF4A9C41DF74A95DEE0C217AAFBED8B10D4FA81F51702EBC33563E876
      DB0A3F5F60ECF2448BC7FC4F077C56C3E322EF3F2B9502EDCFD083093C4AED0C
      4577DF4B60A7FC5EB25A88A4EE7C9C26B311A7ABD5E8891A1747C7306F99347B
      9FE5D812192FED617B79598F664EE7DB2F459CDF8A42E900F437A147D7E5A4D8
      631D6B39C27A0AFC43B759144B8E454E3DAE438409FDC3B23282FD9B0B8B0B2C
      3B11E9783C282D43D6F3D15FC556557A9A7BF365019E662E1DA06FC9B5B5E77B
      E9356E1C321FD88708AF62B92D55C58A359553B8CDDA93BFCABBC5C3FACDFC42
      6DFDF87AE1E0B260A5D7B8CB986628F92817931205C34AC1FB54831E7741AE02
      F8F4984B5148CEC947298667979DEC8F3C09B63EAD8961C1BBC5BA0A1826423D
      BF65DBCB411225B374ABE84CC8CD746943249E29A196B6C3CA06B4677B7DAE0C
      C1A25AECE3E63005C8C49DE4CD26E91023BFEEB0077488011A0A6F69F3F7314D
      F38998B6BBB32AAEA95E8D6513EC8C9B3184C3102D9E629CD7FCFC3E8F477553
      8A427572497D2A17A98AA7F34591765DD8B624F14270A212331126A2179085FE
      F3D9D657931431C24B706E5B2CABC7F983895C7AB017A1A50CAB16965851932E
      198D2211824926B43012BD7AD5FD799244023BC543C2440698016C86CD6EC072
      FA612CEAC9B1A595CF84D2C3F7082BF87818AFD4EFC730CADE02AE680D87C388
      BD23C5814F2847728A85C9CBD9197A74D30093B80546F1568818A7032174E4AC
      81D27D7BA5E9BED627B72F0711EF171B51E8B4DB8E883FC0FB0F4F3F5E30DDDF
      12DC2B313C599F067851793374C1510400030C61A169E464C04D02BD5A96329D
      D00F4310BE31B6289399E87FB760C7FE1F098D925BCA123547AA5277144EC25C
      15DE178558096607C0FA58F40325981DFF943F91906C1F4473121ECE83194F69
      8A00F4391B6DA4E46BB06077A7F68337E9CFD211F68D7E073AC396E0C1B1552C
      9CD65DAB887A1236960ABF9FA6028A4AA76214A4F21975C706358C0C2E7BAA02
      FDBEA0F7982843A95D316C42909986BEA55CCBCE57CDB57C9B2011F93791A38D
      3A17D9CDCFDA035D970A16C7F966A56C62B1AF8D9AD07695EF7887D5B5D9AE95
      63D97662A4C4ED62D9342B0496B8F737E2957E0084CA178199A2F801498E456B
      0BBD24420614EF1E6481BC280742950C743B1AC7E06C3B5F3DBB7C2B6D975B02
      7885CD968B9D2ACB2D02056E078A9BCB4ACCEE69A5ABF0B7A3208BB0E61170D0
      50E97B58514398523C510632981B5BE95EF202CAB6DC0F2E53851345557B3275
      7A568DAC2035CCF4CA0BB30925CF704175AE458E603F9DCAC728E2E2ECEEEECE
      A2D4B123EBECCE2331330AF5AAAAB2E6EC15238887254C94E8ADF44F59267636
      C5AF4ED3B56AB87D3535F1BD7A9DAAD49FB2FED9A8775B6ADAF29EDD9DBDF3B3
      BAB8F1ECFCFC7C5FAE53340AA032F0793829158354675264B802CE0F72AE07CB
      35E0D94CA45E84F675FA5554F1C7A9CA1F0FC4C1A61990957014E69994924441
      772442EF3F5C519E561472688C4709853E66D24EC238D05FEDC5F71378873A55
      AD5827DAC4913471912CB2B6713F010E9221790BB58F02EA8645117B4E9C9A4C
      81B7E314F690BEA11887C1B0AA780285ECC4D6873E663A5E9C1EC83AC894F1E9
      152B0CF592F507A0EBFC2FDA7D054AA04D911FA1C8122DB4922560AA43B0ACE2
      56E1C0C3DAF5539585BCF612F417A318361FE6B1F62003DC96DD1D5573588216
      A116C11322236668E10CA475449DA4D44CE788C49A57FF310B667EB2FED563A4
      01AE5FAD1ED7A50163693318F5C46E20C0AB4CC7157644D01DACA190F1C36871
      44C2244402914248C447073701D13A09DB72565EB493DA328EAE2D5C2F6FAE35
      F1A162D91247310C7CED35B3B128E54BF7BB131D82445CC47A4BC71E0E9376EB
      0F69784745C4987D115223EAE3CAFCA239D891F549B510221FBA68D224C05A46
      F99394A24B282CD011D1BA24CE7B7F19DE61C35ADE33FE999DF2AAB750A6A815
      251B2AD6B6884DF8B6C2BCC829CB42CC9A2621F537421526BEC7AE7C45C511D9
      070FDD5A5CAD3D4A926B947896CC11DF38990DC6EC2040C3FB804B05978A3390
      F34E147790F37D034FA2370B2B0C7B30196F429DD4601CAA4FC3715D19EF522A
      2AC80F5194C9C7B218937E04BCC33ECC4F752C869571D5BBCF3159426BB2830F
      AD7BAE89CDB613E34F45EFAA37F7D68947CE902DA1C7E5B5EB5D188456C14230
      D502F045475BBE44B8C941145C29802567AAD7A9B5EE4A031159C372FBC9A713
      65E8E4B6DA583F00DBB28966971C91A85005E6C786751A976571ECB9446F8431
      01B5D9778571326900A81C5172288AF908ECB1D5041D66AED715698A09615589
      66E51E51B7E25907447EACDA530AB211886D61E50FF6FED13CD43ECE6D222F5F
      B418C1104DC256F1E203FCA68758D30A15FDCDAC47CF4768AE65B73CBF534680
      F67E43C9ABF73B512E5ABBD08E75F58AC344F9803DD9E891D873CEA9B8432027
      C0976739AA65FD19B76C91F449C49C4A8D58D2516A6327CB6032089596102FDB
      5F1D9AA4DAAC89E547B0D57C0B6E24451B71EA82D6FD0C06AE61F352B97242EA
      A0C6D00A8AF5CC8B383F8607A2BEA8C8B328E74BCC57D16F38E7C5E98970A02A
      458A5A81BDA02A750A2FA435AD5F99F89B5E99DD0F333CCB8C50652050EDA5D6
      F21610E425D6E353FA1F891A3A6C15C66E8667EA018217A594F252EB446BF6CB
      AD9396A1AF53106D49E752A4A86B5EDAC977BDDF10897ABFAF5B2CFD1B23A790
      C928C2A558DA96CB2DEFE0B6F010D91E77D594278C74511A87801556B2902D11
      7190688B2E932AD097B6A6E8FA55CD65FD19D98B44128530B40629DEC0516A13
      3C042E6081E79015763A8E5D202B74D1925BC51B9F7CFC8C8EDF402B4EA035B6
      D4B403147BB066359A73691A68D6D5CCAEDB0AFDC79AD0887B2EC44910305D67
      4BA19CD72EC46B5DA826A14F09385E112C2745714DD6B14A23099BBF3222CA31
      045EE8D50ABDF8A18A68DB0EAE1754CC1DB652F5D9A0DABA891F4CF18FEDB202
      BE635C15BE1699A8A62C466C5226B15EF8CC70A2D87CACB0E91CBFBFBCB0F6D0
      7CD3BF0745056832AA8E2908F718792CEE17145504ED67AA989DEABBBDBBA34E
      600FFD715CE32FBF0D38949287CBA43D1C26422F635BCA3E6203C57B591F6563
      E71BB85B867DB273690C5227557EA45834589CDE49876B2AB2CEA9ED081BD343
      1FC5396E4C28DC6DB4683563E1DB14AA48F93781D811C69C883BCA4E2FADD205
      FA412994BB7A3C969065F125BA55B5C892F5A445D0BF281B3788BC0C6FC306CE
      E2300A252A937D9B33D18A5346B5AB66CA68538BA492262691B1EE4CA5A16811
      AFF44EDA61CC8107E4C493A994B408A9AB2DDD9B0F97DB9DFCB8BB7349C7230F
      6C4B28D015756F42EB811695B200B216D5C71C79683BA24EDF0C4126ACAE1456
      D7FDCA2D0CBE67A6A00EED5090183C5D61F6A6300A9282B0132B101255EA12AD
      1D14EB7B801ED220C58E6671E1D224EF3EF56D974535A41B812A7B1F6D1424EC
      EEFCF8EEF814951D6CA4143228E7F7D3406C0DD95AD3D4BB2F405C6D16D95783
      3BECC58C0DC0AEEFD370C29AA4871E21CE85646B1BEFB2B0BA496B59C1BF24AF
      B03C341FE5614C9109059A518006464F27C27458E20E9BB193225613D9F512A0
      5ADC02344F12E8ACBB40EA9178D7BAED2A2C68DC72B13C717861C63C11D7BD59
      C701F43AF5E20C40912CCBAB9DC91C580A7C16882B85008A49E0D2AB23CE2DC8
      0250C4CF01533EF4A3F086BAF04AFFA2CB0288FC93B2E3813B709852691EF0C6
      2002A611DCEDEEA820B309A6C5F9DC4D11C3CF788A2C8E2D7AF578121A22C698
      872F5AF7522D28C0AC684619BDF1BD3C396D7FAC3DB92722F1816DF3E50D7A1A
      E07E01D8AEBB7FE86380BB2F3D4DC56FDC68018DFED1FD2284FF674B3ACC1B77
      770AEEA8398DB45C52543394800C833BD61EC9CE87D65BD0E363EB625FB34E01
      14812A9BA69C20CD8D9ED76C511E4C0F85AEF7DD7FC979FD7DFDF597B989E77A
      E7FEC4F93EA5A058268B0F54CE1856FF25739EE5C3CE0B84C278054CB1E5F308
      0B39AAFE0FE9845092E5AB3E0A5A1C4C4EB11A02C20222781259E7E51B4A2C5B
      006641E280D07EBE3AEF90EC920A4A20C343CBA353A4CBBCFDA11857D405C80A
      2EC3BE6D1C9DBD904080599A51EBBD9DEB8D5A8E5859942F6825640E4053BE9E
      1CAD0C463145DC72D0E814EDD182872149A4DFC4DF2F45CAD78D7CDCF87EABB5
      EFB7E26CB7A70C8B26D4EC2163BE3CE3D0E624F259BAD1D3D84AA0CF388282D2
      2846D4315A78490BB7979784FEA3D47018BC1F0E405E80075A1B753218B480B4
      FB90E8F5664DEDDF012802B467F58D9A98EFC5D8EA9B66E66CD4CC8278146DE8
      D44075DBD45D1BA2777B2367360A400A8C37726669105CF3C4DC8D9AD878168F
      BC3494BBB6599403784D146EE681FECB9B7A9BCA094019BA0D461BBA71D3A420
      B99B056DA8B0CD46333ED48DDBB7749665EA48ED8D9A1A48919BCAABB2DBC0DF
      D0A9E5B3F45A4DADB14D1ADBE599D1CD9EA19B2D8F42FAA374B3A532F33680AD
      F4D4344A7E9B76CBC0F2336079B9E5EC8F83E53F1E8C37CF6EB8BB734A9E422A
      49262CCE187DA50099526BB81C1AD959B704E92F16F24CA962DC58736E514819
      77AD55BBB587B99270497AB538A14C6613A96832C416CBEBC35DFB986D44854F
      EF65186C69BBAD3D116A9B59B5CFE41F2BFDFC5D6D5996111AFC29C27B5F0B95
      63C7852AF4852E0CACA0A70511A20783632E16A721BD75D320669FAFC74559B1
      17016E01FA2ED6EC2FF8793095CE955F5EA0616A30E0344151959B0AAA61B6AD
      2C422B0AA684AAF6D903205F80757ED7B55BF0AFDD711DF870DA8D0E7CB8AD56
      033E1ACD4E1D3E9A8D2EDED26AD8784BDB75F0968ED368F0D3780BE04E9B86A9
      77BB78936D77EB7897EDC07DF8E9B61B745FA3D56CBD282EC1E2D7788E622B85
      1CF137F4168A4BD758163189FFD682FF6D058DC1E8F8A24C3185975913980B42
      E3BA13FD5FCC2B0BD30EB5E0F33DAE87B4EED8258489F5BBC0E357F981886801
      EA8A60C065B13D4C5AD429A7764C8557964A5873492274DA820C3708441480E6
      AC068AEB076988E1FA44FC25A3D86E6725091DC411E57E6C05C6CB3264B2A19E
      880B90D2015CA99D3161AC597BF0B5465C59A91E5497BD90CB86148EA4072B28
      2855C5D027130ABCC48A0F2F125C137DF75F7242D5312AF391242BF7551175AA
      B9E44796877A696C91C749E89BDD863955DDD68331B470072E6F4F01785A9D2E
      0A5F022D6C32A5AD1F05E5840EF5B412DAD64DD5FE0BA343FE7E04C2F74BC464
      1E14130F657080751DDC134C151189B24053B6700FC50262C82E47B16C3BC55A
      08B4D92A9255D1B1414798B2FA38BF5BB24898ACC75DD0B14CE02F17044CB12F
      EE44922B955D23AADD96EA7DEA1C7A0853C27AF7CB5F8EFACA2C1695BC65A00C
      35C2640ACCC15D7B649B3CFFD010C1B91FDA2D7903AE9562B40462E454BE20B8
      1B04403C84307BB4AFCDA7B4191CF1C5F1A68B518F9408468D8C45F5115C1FE9
      5C2AD99752B628304B646A7D4B81598546F95215F18E0A0563FD9D572951EDC8
      0A8E46476B17CB397CE9FF0AA6FF72CBE072250453226452D695F42CC4B32860
      1941019C1F6461AA89BBAA3ED672D4BE15FD24C24C67BA390334C9C80CB61891
      EE61D3EC241C5090E113D485AF9DE8B0BB23AB60A481285CA40C40C59668E546
      8B10E78168E4FD65E46D5B19EEB2448D2DE1B94B965E4EDFD5337797E02312DC
      E591BF9416C2A058EA756FED8978F0A749BBEB9475BF544D40434429FFE06BE9
      395F7ADAFB445639545C942E66C670501C38198CB18AC29C7F49CBFCCF0818E0
      3E3C5E342D73E1066C3F78A2F7F25143E87D072BA99028FA2353D03306974054
      2699DF8BB05A680857DF12D06BD7CDC7990497EDF773443CD7916E0F5108F56B
      2D1D6831FB7C892F205F965E26F8C0284AFA243A6BD2DF1EEEE9340D93943A44
      DD046985EEBAAFF18CB5A7C8BC686ACCDA3B64634E0FEDF353A7FD1480D16D27
      53597F4DA5F9AC570EFCAA893E5F34E3DD9D3F2ED167EDC0B37E102F95A94532
      80BAE82DCA28B27E3675803B78294458BFAC8BCE4F2A459916098E258A87344D
      166D2C2BB4584689CAA888C4499044B07AE5BDAEE47E2B0AA090FA1F50C57991
      07EC2E04BD6990867DC581876BA77D2F9AC6FD426AEE69EA8D92B89FA4F10BAA
      B8AAD234A521E7216832F7076586FF207FE612B565C30C797524D3259168DD09
      9ED3EFEEE07F2FC074B1071D332B111FC0A0C99DEAF6161B9DEC978BE9AE9BEA
      E22AD7BF482157AD77AA2FC5D8E2FB796F2933B88397413A8C6C5ABB19A9D035
      882046580991EA1B3764CF11F260A3AE1A055CCCAD9EA905AE37D31891A7DE75
      EBEB9699B6DDEEF236515DFFB6C5DCB2ACE3A115075E5A51DE9062ACB00A1FBA
      1AF5229FC0F585AD9B14C2A515FA4C3CD133291B87C1C9BDFDCE12C9116257F9
      D751A99293AA2CF71D57A4582849517A768988501EC02E0638B94FC3280A07E5
      11A8B8C0C293AD66BD6E5B7B9FAFCE0F3BFB5B815A3FA1B76FDD74FF650B19A1
      755FD6D757782CCF70A1B43BD00183CDCF8C0EACD7BFABD77FB1DE14DDCAB17C
      7B907E67FD2CFC6302C18F2EAF3E5DBCFFFEF2178165ABE2E416E0D8030AF597
      62D90BFA54C91F1F905FF0C0A2E29BB20428577149F22257C2A0D517A255A174
      2BFF7205FE587BE4F491C7BDBFB59C4A9501439BBCB7768DEC05518A3D3D1454
      18124E59B2B41B97832BCAB4198EB51E8ED558CEB1345357904D7EB1CED1C222
      4A9FEF512DF4EF8EBBE71DF7CDF9B944ACA70CF72588FB94F12FC9172C7A1C6C
      4BEFAA45DCFF7DCD1083A68AFF86FFADDB545144FC02761323D5AC7C860CBC3C
      19B09DE5787532FD2090F22AC872C0AD6905EE127DF8815B4D9F1667F71579F0
      26B63C785B345E1E7BB11F6D0B6562D354B4B8FAA2CD5B1ADCA6619E639781A2
      D916811600938761F1687B528512B1403EF7039F84D45C12894151FA5EAF65CB
      FD7539E275B1A8A1B4925E6A92FB01DD7C7576D9C0305A59E3F6FD8FFA0AE613
      62C805C1F98FD48C4654AB85419AAF2F2FCF44246EA3884B12C3AC3B86741ACD
      60B9D9517EB75AECC953FC14C5926482946A6A2EE330C3184E0576456BB2CC04
      5D9BD7BE6A92223601777BF14176454701D62297BBBC6EE73F4E82E6B0F27E3D
      DDFE2EAA4548083890057BA52776CD7E55907FD62E95C3CCD75EC63BC8A275CF
      53C56597CAA0E6E8ADE7E2A7481E54AFF377DCD93B0B7211D3CF8D2701EE2621
      B720D1BC8B7AE840890A7C492D84671D301740F0F076551381AA24C015CB3EDA
      909208EE334B223C6F8BB4F69E6B27821B75DE8E38EFB56EDF67EA74FAE0E67D
      718CEB2192C235940FC117AEB87178EBDCCEC125CBE5ADFB3004A61F7A9175FA
      F604111E06F1D1C32531FC50A7DD1B75F68D97387B893AFFF7C74F8B0040BAC6
      3369F4A18809FEF153A9024DC3FAF1D34680459377F58442BC92D83A89667DD9
      1E75FDD0B1FEF9B778FE92BD61BA86DE19F4EB4EAE7D244AFBC5875513FC4F57
      842E86B253A0D69054139629DF86814BEFE6C031DEC20087F232CBDFD8ED8D6A
      7D507D26EAE986EDC0B2BC885A94ED1E226CC679AFFB0459BA291ED35A47F06B
      B00DB66872404DC970A42527276ABF4F67D4EE19264701A3612CFA02E1FD7D80
      81EBA33FB4A4F726EAFFD81F4574FA53F1F0960FDC27D99E94A0F192B513444B
      24D8533908E23E0CB42DEB869EEACE8E59DF5E8A39EFF237815D1ED72C625CC8
      0EACDA2099DEA30E70747444B059638342380923D876EC9F40043FDB2F6C129A
      25429927A42270A19ADF723A83A7FA7A0AD41418739FCC440F9D396CE38995EB
      1AA1D63248A2D924E62D21ABDA0722067BA350E92E64FAC056F219763215C68F
      699285B287BCB22FEC1F284507BFBD6595676F585649E12EB24C8937711F467D
      C3B9203D28B2938B536CED380CEF7485483602934720C2198138C012B14F2FEF
      504C45964444310524CD75427D279E27D5582A6162A3B89510C52CD0CFABE98E
      7E80E7E73FC1120D68711D1C8A94A29750A461735EE59C4D190CAE8BA0F4F312
      C0CBAD64D22A89B67844FD4AB94BD8AC52E48CD1EF64E59A8733597E8BF6EEE7
      A35F54E74AE03E3FFFF72FAA4ACCFF00B892EE2C8B8561EF74D93E9BE2C57DEE
      119F532BB5B909C9514E93193E7F02F3BA46FE7492A7D15FCE624A3CC129F33C
      A9C15AAEE841C182A8085729477F1025226D902906AFE3C33FE40BC9F5A1E846
      ED641ED781DF05B04DA0D6A8B0386EB329D193AC7FF7A59CE122CB9BFBF80276
      819A00E8F45A2192E8A5C7B5D3B0629A6E2A58614ED4875B344A2D8822F5679D
      041853FBC73665DA4496F981FC08B0F1AF2ED5062121523D6CAD71C2DDCB4FAE
      3EBDA5ADF619FA06087DAFB684AD1E13F8251C16FF855B55303E2A22776489E2
      464485865E9415A0CDB64B9454F98DCC2E0E786059FC6B1C443EBCE196795489
      263059C3EE3ED3BC70E6BD132928F0697D0F0478CA96F73D983510E6FB28D817
      B9FF6A7918B1FAD52ABA6C0A8A9CCF9044221B90B6F2A3D1388133D8A616DAB4
      E4DD9D5C0B7F94865F6CA675CF39247BA2D489107166405708A2B8CF1415A6E2
      6679F7B2DBF4D813C28AD853C51594203844DA4F9DBBC458544252DC4E57A889
      E8813E8A6C3F1F8EE24423F2673C3B810EC47B99DFF1C39F2F0A870BB2F307E7
      B5ADD8705212DA136A30090485E849B65528415DE5C5BA5185B786800FB35414
      1B53C41EA08DB3E24509D804B58C7022EADDE06DA3841CB3A2697B9E2390E315
      5DDD98829C59E804A16AFC0EA43E57B9E263D8A84C92FAF2891C141A5B7CCFB2
      14CF96CA01DC0658B62913B90A5CE4978F199102DB148F587DE38EEB223FF380
      140ED63D50128E3D2A1EA0DEAD72EDD425DE27D1112FC797F2D6D08EC946EE7B
      6805B9C5D636F1685F452D913CECC1A68BC6A542091A8BF4F87E30F054E90B2A
      0127B526B1511912A16416E7CA534D397FAA293C996FF68FAC37F738262D4AF4
      0DCEB4318874159DEC617520428753147C432A883004FE9B838C9B0B0ECACAAA
      98AC2CE8874229758D47A62F34CB1B1474C91F3FE6FC92D974C9FE510622752F
      1CCBF27562A78A9A7642614D00274294EC84BD8AF7AD1813740C185054A22495
      064BEE8815644C9845E8409644E888C744470C15100525F0A1F9158C554A6401
      81A492103D45157532CD6107BD9B70C400A5D47A2E2081118AF7ACF0D7CE49C1
      25FD019F5673AB1D4909697727CC64822D592CF0C9690200ABE01D4D7808EEA0
      FB502DC598D985A8908C3B804301197A950953A19871D149512952C5EE10B0D1
      8EE0757C152D86E2220094B517D2D479A3632CEB4367F5D0D208BB27DE35DA2B
      73260A8197890ED6B8022278C2C7BFBB237DA5078C968134D8A022290E2B4FE4
      19CE1D32CB7F43841258A13742ECE3516805C511C208046F84124840E6CE7DBB
      73E184D971778771F472CEFCB625CCF02769F1EE17816E6458A1601EC94F0E84
      26AF28DAFC6EA9DC198109C5554205695014C6EF58597CB3C59110B891BF4E12
      2E8A43813292EDE906B6E21DAA1A52616F3CB0B284EC18487BFD106B1852E3FA
      A92C8919C67E085C1385DD12C6089B649872A19C38CF742B10D545105440B3D5
      E183E46E009C0F31442B247157263EA8376874FC1EC8FB840DBA1C7F21ED4944
      0C853109E9E48D075BD78FB6BEA8F0598CBBF0FA34CCC80C87DBF52920039C3A
      BF2DC159AED4A155711275C07E244894208938C48608826B5FEC1BD6D3A29D2C
      B6ED40172641209EC5CA8E00AC47C2240A0E05A688B8C3DB92DCBAE0C360EEB4
      ED907B222BA36C21A00AFF4D7E4B2DB5091285ACA2A961B150E44B355FD1CF6A
      716999C203E028C76EC93B1C2C934D55F9E3582BAE553B29BFFDE8E8A856407C
      284B6B17C875806F447A4C4390CDFE5D11A6B84C241E26031433052764D33EBF
      748E89C26B3221D48AD05CB67BEFEECCB2E87EDE01C038872D3A28202F2E63DE
      1975EA2895B507CD014DF4190BB151925C131AE71AADF0FABC14B81801EBCA2D
      57281C9952C4F68422F217DC7BA9D5ED1F595544880B8EC805DD2C9024EFE123
      38D0742F6F7707B31BD02BE491171D5599F99310C549E7A95F98CD9D833A633A
      10820AD66EA4EF79411089C4D920E1539E27527913F496F4677950A86F72DB84
      84231AB1F0A4F0DC5863930209BB7A8A822C626011C8DD0F64DFF6DD1D3628EB
      6073641D93CE85FA40984E24604B078D029632ACD1AAFB815237A418340740EA
      3E6E05B3ED947B6E77B6826C5F695001F027E00271252BBA1B69E13904B948E3
      05CC96C04A02D07B56AD754738F7E4D151FA22CE82343F52AA81B87192A01903
      0E815C33B7F1021900DA74324B33F8F9F3D47A2DBF9F923672F2E964EE8DA88C
      ABE265DA4897E37098FF85E7202B997B22826277874B990B8A4C3C81F479717B
      38E4A0A3A188441094835E1E0EB5814AC31C913DA7ECE545BFF0A7133963E1A9
      2FCDF394AE6986763DDC89DE58F65809FB89AC64A6429CF03562C245DB2811E4
      2426433EAB09E59914CBCBF82DB007581DEE3614E6BB62795A6839078FDF7AD8
      8D85959A58D943CF3C18B69492CB1593F035E847FEA220F2F9E8BCFFA4867A8D
      AFDA504F733A1F5AC71A4B7CFFE14A45BE2995030D98C2E1298E5D85E4289ACA
      EE4EAA9A75B451477DC5B15387D68779EE2E431105D896ACD99BB5864B9422D3
      01F63B3E9E9752E697C122AA32C417B6FB725D4411E9C4C7264CC664FBD60524
      0D12C436729D55AD7031BDFA32A1D9C999CCF38BCDD84458719FD779888456DF
      3315107A50066A2A7FB181307D413E55EBED07580AC5DBA2BB541C96C61474C2
      AF42AC0AD7EB4466E815C5A8174E508BDA43AD4FF5F49190A1850771197D0AED
      FBEE4B5248E6B7CB7952FE80331F8C0D0ACEA3A4DE6E34BE9CD6D3C3AB12FB30
      BAA9701FD3307F04CD3FE65CB1C3F904AF5231C9C2FB3E41FF678ACA24508422
      AE79034E1480F40D065BC3529058A1E21D0C66A5E8D95B15BDB3BB43616C1845
      0342093D07925A7CAF02F154A8260570CF238B28F2EE150F08F4E92F8E349486
      E4A52309DF5AD5405763DD0A9249CF220F85AC894E0CDB80C0089CCFB9150A8C
      28F98722A4E4D079321A090302590584D23C21E6A4246B58C82020D91ECB1963
      4816BB22F956C50C27C9AC08FA7A234EBBECECED739C8A4F551AE4A98EC21B2A
      4581F1A2F354525A27C880806E440645742704A91184CBB4B1F99505E18F251B
      D47B61831269B44AB7549A1D7BD245033A2A2E3DA7242BB798F69B18646F12C6
      B3AC8863DADF2CA98236E0A414289130BD11D28158065A7D31D2977C79B44C69
      278BC2693F41782ACC7E248CF4397826D05266DE53DD023FCCFFD89499AF1AC0
      BACCD2B768B2A3A8EF8365A64C69CED3E2DC17CC9955B61BF686E248C844F87C
      8EE0C9115BED87AA2B54E1FE51F64BA27ECADB49AB906E4E6D7CB4C7CFFBF06A
      73965AB4DB94A2DEF128469441216D9871708B811064EC50839349A1F42067AF
      94F30BB6D5B039778EDBE2909A5F36C1FE5CE589520F004FD9CD16DBDC158369
      6E974CF074D9E64F731978149454D8EA14A88AE40BDD79C3C94C5C7A98ABAAC8
      D603329129A6DE25E320523AF3070C785A58A1086BBC09AA17C7F7704F0832D5
      48C46339544B44120E3BD2FA97BFC94F4815E8071C3189B6D62AEBA2E8D32AA2
      76032C5853041A7B54DBBEA4486F2BAE9E8970CD6DF31E1F671C76EB65857F12
      F1A7C01BB4B363F48255A378D40A9FEE5C55DFB2D37258E5C6D5521AD915CD1E
      108D7DCD3B0C851905813C2B677015D62129CB101ECE33728F027E5472946AA8
      528AEADB766C20F787418787D1817D441AD0AC13237407A18604928928D77A2C
      B37D0B397219FB63532079BABE62A2C6A68037959991BEC3AD80EC325CEFEE3C
      0CD95C86879C9700BD2F05E07ABCC802F59FD7B01ED3A9F4987AB857746C8B13
      F6C0A62AA75B8F1B819FCADA138FBA0CEFD462D54CB4785639978A77E0F4749C
      2C85212D0D422ACF6A304E121A97B5C35220ED8C4E8ADD23F2F5E49E566A9DF2
      4ECBE4673D29C9646C4DA6787297E200B68216B0E9767EE965FC456DE99E6A4C
      14312945E440A16C28C895CEDB85D2BFCF2D0BB530CFBDBBFDF59797DC723C38
      8689619D80F256D7B6041DCA19EC157BC1D14A135842785884CA16EDBB7EBEFB
      4522C1C3E9ECCD23EB44041E71B4B8CFD1B7DCEB9D9479F2DE5AD9040332531E
      DE29D576A89E06E93DAAA67581B2A5E08A8A485E0EDD5D58B8CEF12BAC84072A
      35AFA492C99792DB0C17C9CD9EB4A055AF5F5E17579312519E8BEB89C249C8BC
      B688125B3263347073A623BAA59429F326F496482A0F6C0835A46457E3B65388
      4FAA48329733FA9940701A05BF149A4771E2DB4239AE1863A6F74B37A1C09C3D
      9560F490B45C8AE3DE5F52A05A3397C87E9B948029DD4244A2E0054B500224CB
      E0C8BAC0C1F259CA95EDB95F279A2D3355D35AD94DE0E57EEA8D54CF73A649AA
      86B488FBB60698D122EC2D14AB4857B252344B0AEF2961BD54055809A0F44BAA
      8A5394A499A6096CD644B318CBBD2CFC524CB679FB25343E7C0EF3519BB40B42
      7F9E06295A822905F58113A54475AD0A880CCDC20E7784B0AACA8F3C68A108C8
      0C36F4B9F1ABD8CE4C9A812C0166A88CE483E23343FA4CE9CB5B415138E55F06
      37E0B2C9B54D45C7D6DB49E790931FC52EAFBBDA182645A33704D1AB2431D05B
      B918BE78B504F91F4481208E10279FF7712462C455FEBA2889C01C1D2D053203
      2EA3289270581A5A7395D27B15F98CA57D60E0654279D633DFF961592885EB5F
      62E62E07C8CBFC7E75A3978AF1051D0CD1D0460026C2F0B61DAB8FA9DE19E707
      0B0FF556603357DD1C24930987E7C664AE028E4865F18A2A12C24633F604332A
      52A9853B1F83854BE5190836F7B4427AE2C690B2B383C9348175DD1745816E3D
      F66ECD62908A0516615428D6B6F3B90802078C8CD953BB2F9221B01487140030
      721933520210D281E17AD3A9ACC2AAE07BAD8AFF2181CD296DC525ECD5FADBD2
      938D8C02233C7292C687892CC9BDA7BEFD8D5B797082DE81A5AEFBD1203BB04E
      4EB2FD5274235694E6D0B7251BD5231878D96DFACEC3EAD9077DEC727030C0BE
      39EBAFA45D6C9CAAFF510A455A612B38B292D29C26DE3D00EE209A618116B9BD
      7396D06D259DB54B74DB7F8E29D4C7FA218CF31AE0EA34F206415648CB35B259
      E0E9D78419634BE82B190D96ED11123761EC1672F80791A5BF97506E9B58D43E
      7BD2382042848A6264DD4C8C268B208170222D3176DDC278C19CD23FFB48B061
      C431BCB51016D855308B7D1178FC8337E9CF52AC8AF48E929D65D22B9155F126
      112A83753960351CD881311A059B10774A943891B1B394101CCA8812552F6096
      61D90DAAE4365F3160E9103FFFF72F72AF6834EC8C83F90CC45738B3C86E8A84
      E74C7012B88E462C406B386614D529F690FD2438973849FE1DA8A7D5C66D3B56
      939A835E18B66AC948782BE0328AB49388CD5B82C5C718A058DA91BD378070FB
      721B6A0279E7732EF77CCDAC9AA7B34005EE565609157292AC6225E28527D527
      B1274366B94019C6A8CBCA5498EF80D3DC766896A153B01F25F3CE96406FA9BA
      EC323317D9D90800BD3C60575A181F120FA748EB84DB905D6029412C822E64A1
      4CE402EE1F58E7206BE5A2171C41681844BE285186350478D0622C2E7944C547
      0109B065A25641F752B3D42F9B070FCE568708B30B2D3F4DA69C148E8C8B6AC1
      4D132AC2080C46649AED0564A527259FE7AD97B31FCF465815734F99E9285386
      ABCA79A338CC61BDFB68E7F7B5DA7E5B8B4F4C7B64C01AEEE696A012AA044B56
      0F321B15CA40B96D19B6958B9290C130652D1921795FE01FD6B7CD2C2E058F4D
      9EB9A8006964FD34F0AE45B925AE099A71DAC9395B813D588D7C195AEDB71D42
      8FB112A528D1B625A0794C340C49145B01D1D222EB71CAEAACBC21BA9361300E
      034D64AFF1C6CD55B83C91A551DF260092594D77FC70DB0374483FF868C62D45
      585BF1CBC5527F1EE4F2367C41F68B7C5AFC78E123251F78D155F28E8C1C3FC1
      66C8270EACE269BCAEFFCDA3E9018B6E799A142F460EAE30475F8EEE86914A0D
      45FAFBD2CABD3880B5A79C30AC21A1C5615F73E91C898400766495FC57B95EEA
      553D70606125EEDD9DA9A8AD4B268CB997901A2823A772BD06A1483C1586B29C
      2B38B2D6273AC8EB25A9A83F291D8AFE04A0F4209904AA58439CF8A51C827259
      11FDF5CCF259B7C2AAEBCA4827C650FD60C570B7A0D362551021521449E60156
      5BD15C5845655D790BD778158BA1FA8EA957D8F1151E68CB123DCF8FACE06874
      C4867BAD64ADB88962AEA3C08BA94832A7AA255815161F459B2506401008D002
      860ADEA9B42A9734A74AE59C9F21D22A0A433F8D5D609C684C5E1C9538A483C2
      E9BFBB33575A0CEEAA0D31A13E0AFF8DAED33DD1CD53A1256FAD77BF2F2BD2C2
      2B6518201DBA5FB8FF8A9393B5BE120C4B04C42A8E5A958BE25561056C7D5F6F
      3D6DDA321DAB68F923E10C0619900B0248E46C90CF522C672BCC177B14C920CA
      FEA2D754ABA4E5EDEE089B6F51E64BBC390D2640D7B279C8F6F8CCA898211939
      B23C49883B5339D11952311936615D15359D31C56E9651FD314F594C648C59AC
      A57C2F2BF816DC51F6254BAE546F8D8CDBFAD1928E573AF99ACEA908F64E04EC
      918928B8C30475DC56AD4C239B939814D276BF0D8075D478EB6BFF9CA1E071A9
      135F76AE33CD2839BB647C8F4E226B6FEEAD375E167CA203A88922656407ED27
      77F234855F5F2634691131EC1DE40602ECF9C7BAACEA8EBDBF5924D0734ABA75
      72F6F62D9E8B07370C91160CE4ADFB731832378FA2B2DB81F59703EB9057FF67
      EB3AB8CFE64B760B771C6C1CC79F1F4751ED40FDF51E90546EDE457C8332970A
      ABAD953A19703DD602CD144D16A824789F34E4C97C108911B20CA78657821D72
      8ABF2CB129626FA9F9AE27D33E3DBD269D3A0495D349A9B574A3301566811A5D
      BE772E2F933C86452ECAB4E481DC56C1F113D0A8B10883E1BCBBEDB1559703DE
      1594CB74C0877B2164010A50D2ADDE0F487E408F951CD08B16DBC3A9AA301876
      320B239F78C4C2FEABAAFFD4955EEB520F8483A654145496A58D322EABE95358
      5D4D8D5A230FBC6C490284E81E5D66CA7B0FC41A163B66879A0AEC91013245E9
      1329E5E82E2411339525CC4139D4084E72700D241B893F2E4A5925220EDF814D
      62431DE03F3247F14E2F9FABF8FF81E9E2B2BD51E7441B7820DA74EB3BAB3117
      35C4EB595C0C276973B11036CD2FCACA5A8C13DBE793947CE623D07E4593090A
      E55C3651D1682923D8A1948821AAB6F92CD64A9F8AF3032CA1A662D4FA81CB97
      72B8A46761DB12844510E646294973186CA6E2BDF1678ECE820920FBC918602F
      2FCFB69DB64933684D880ED84111F4320CC7A3668A3F50CDD66D898CFC287D93
      458F11F453B3C4006400CD81D49351DF2D8DD3CBFD3AB2DE88F625B2690589A5
      0999F1DF1D5F5E01BDEA2B145381139A542C62A0695C324CBE4268C7DE477A41
      1F94800F8464497C1C1524CFE7883DAC3A92CC52957D378B411A15D908883F84
      CF28F0052C7B63C923584A4CE5F4F70941A641329549E07EA2DA3B79F04C3095
      52348CA5212B912D545D11E9382449F52A2D075E30E328C416E5DE54A2376A4F
      220047EA04B0327DEF65B161A638A20F0DEC3926B0F36D21671C890276B563F8
      8D07C81E2EEEFC5032D8B297D2F106F3EFA57A3DD9ACD0BD03D56C66772795A2
      72462B55C2AE2A152C878AAD5F677048B2B5A25A0CA905AB2D4749F349295A47
      35FC91053E74B8A60AED07E29CA85491142FCB317EEB0F0CE169D02CF0E56BCF
      9C213D43F67881CD5EF31A2EFE011BF51320CDC5E43481DD5D7310D091F51133
      21D192B0BB0308CCF00028AAE2B444739A40442F8AD6A6A2D8744CB5A69532E6
      27D6359EEB2D8E702FDA99FA38ED6DE78D17136C9F255CAA4C57C8FE93252977
      CB22EBA550CD65E3D82DE1943A212529903B3B0B4F61D1C545CB4645A94FD994
      2F610F0BCAB5D476ACDF62ED1131C572C38B92F77E4D915AEE0823E92025E6E0
      01A9F276F32473E98B4BF7A071E293A0ED6439220382F8F1096FC6BAB8AE664C
      168AB788AA07F20A4B1B16E61BC469BA4649521C8A467C4748091E96BF2FFA96
      C19B6E94174A985CE22010C6D87EC196915C50F62D0801A8A271A080C6DB3914
      F82624619FD32784CD605F5C8D30268EDA04522B1E0E42D8765AA12A20B3214E
      9305C9F9BD35B94522BDA562136460CB5CA6A16ED4236156D945D9E27D76F98E
      BAB133C57D9B0C3C32728B428E45A3730E048882B231FB8174FE6D85D68F64E4
      F8140CAD9F3FBEFD9F4FDFD5E97F76E317446969F22F2A42F77E43E347EFF7A3
      E06E5BA2BB8A1DDA13C5ADE51EED4B4395B764A710DEF4DD52C51AB5A877F6BB
      69A5F0453730201E300D7F90F8B214B246B5F70B73BCDE4D5037E9E4A9273A87
      7C929A848FDD2FE78D6684616553D2B6E2C10F72BF8F7C4F166513EC712BE01C
      F5D84ADD0776E04BB49FD29EAE3B458B8F488B2E16B20C85C670307E291B5BB8
      59B8681C226D30E907BE5FB6A2009E96CDD03A56A902F97827BCCC934A7BE1E2
      413CC7CC93C81BB0C178BDEA64EFB7EF819EBC679A52ECAEEC40B0F2363F4941
      EE07CBB6675BE9C45538DD2EC2C0516DB46CE1E6CED9B8EE4DD8FAB31C0773D2
      84D07B287B334BBBDDC4F3099D4AAE19F58E429111C60A0178C29448321D3E88
      371FE577DC3962094A1B78B54585204E053F5135949378991CBC25B02C6A5157
      17CD107D4E68D7A4E134E69861B6DB629D2FEE4621AF293FBF88839A2B5A7D64
      C96460787179F46182264EE4142CE489015DEC814EAFD876E8FDF9C720BDFFC5
      5A12B4B22DD6B5EA8CFA32002983AFEA88B5664BF6AF7806C801548BF1754B74
      8722D045AB64AECAE591E56A774776D329C729A91458AA044CDDD9474503DAE5
      91A7455B768E34127AD781B0BC1D903367CD5B88F90C5FB88D4F92D80E550429
      85A47104C6E296653277885B41665A9D2274A047B311BC8878AC0C65D08B2495
      1A1868C1477B22BE311C5A27579FDEA2103D0E22BF5C08617FCBE91A13B49F31
      EDF5170EE933E4EC2B9033F2D8BC14192BAA9B0175810FEC98B5BB53345854FD
      7D62BF70CC09D71149B48AD82D8B3D5E2C6626825C5554F642D3C838BA17718C
      9F63EE19497FC95EE9CA542482F16BC2D7515301F685CBBD565414C299CA38D4
      AA771FADBFFC0B9D1F6EC04B9CE1EECE721A4AAE76662407D6E7D34F07D21F74
      71F5AE068BFE754611AA64549BB251CFA520B86C9E65893C4E150AC020838151
      986BC0B1527C58C3907D35B5371F2E2F5FBFFDF0E14AC500C3DB31D2AD140A2C
      2546A630ECBFE2F0DE72E5BB591AA3503BB46A9718888FC72F0E14FD6B41AC22
      1528850E1DFEAA149FB289C0AA65F59841328AD110BFCF49480148CCB50B0B9D
      DF167ABFAD8B57138B1CE022D8185F22633B64EE1FB0DC1497B55FC4EB612836
      EE25C7F371843ACB08720B4EBDDB783443311BAB4650395D25AC67C90C5B1686
      698C2128914FAD9BB8F980F296FDFFECBD6B53DC589635FC9D08FE833AE789C7
      3095C679BFB8A7670203763105C603B8DCF3962B9E38928E404DA6942D29B9D4
      4CFFF777AFBDCF399212B0DD5D54596EE898710199A93CD77DDF6B19F62BBCFD
      CC502E99AC4382A679FA295F4A4EFD194A8032ADC29B6ACD637FABB7D5350C51
      AEA8AC0AB8778A0ABB6B9BCCA087B54BFC122C0F12689640BA62B5CCAB75D395
      EC9A6DE0B08DC02571F96D9D6249ADD32C906C6CAECBC6609B0C0CE3CB385CDA
      43C9986215581669D2007C1B9786983BE0DF14B659A3DEA34247B91E9D2E3B0B
      AA839463E9EA7D68E5C265C0C54471C44248708719AEA0AC3AC476CC55826C24
      A98673B2F23650541F077161C4DF8DC196B1A9D3CACB157834BAB846E8DABBFB
      E85BA0773375F62C79B68B4659DAF6ABF3B496CB788C6DD1FB777442DBF2D9D5
      E2E47BC305B58544595B1591F05CF2A11B55AB5A72962488362DEAB68D357028
      2DE1BAE1C77E5A0FC1AD0767242B48E7B1D1D1FACFE57C41B2B6756707FB3772
      647F1DCEB4E1384763F1C32326A577E10298036C442BB297E53658AE87A7EC22
      E3A8A94BD2593919779542B26FE454FE5A41FA9AAEE7E9DEC9F0C5C9C99E4040
      1C0DDA687D50EC13E9F0CC126BE14734B45FE42EA25F69D320EB9A34BFA57E22
      0B0CB0AB36DACAC6BA7BA6B155AB18AE2E839098AD68035FC22227955F0D4867
      EE4C08F57559662DC029A0D86203657D0D14F5DEC6B1ED59B865448B75052B1B
      1D5651B4B5090A0B7CD3CE0F5CF3C20A40F931773AE4E7CB289AB1154816A0ED
      07ABB2E8AE80B2AE0CD7CCE5CA1034D3DAA1711666AED476566BA66B1FCF6DC9
      B874E4920D1F9183C09D127182B64EA92F4E2AD6FFDBED1F0FA11E61FBF30D2F
      5DFA905C4AB45C9FA1A081CB4DC9ACAB34BF489738791611EC70E0F04BB32B8C
      5B570B7EF77109181038CEA583045D78716096C36C7A6E1533FA094327B0E89D
      B491414AAB49266A212CB8D6BCADBC43266807717CBBCFA4CC72993B2C55B45C
      F44EF757AA906A8D487CA6ED712B8BDDEFEE6F92C404A342D0D04FEB279927CA
      0BBFE193055056D617ABEFA393C56DADF4DFCA6DAA2C93DCB74D7CE55F20AB5D
      C781EBD436EFAB949AB73D480F4113E749198094C72ED5DFD934E8F9B2607819
      13D7E2EDC9968BC79322FE60A9E14D101817C178A80ED3213677D4F0D0E013C0
      EF2C5B5A7931DB953FA2D5449E27689E253B4D05EB0DC0D53C69B461241CB9B7
      7EA5DB07939093E73AFA1AF37DB57A2CC3CFCB471DEF3AFA01819F62B5E1315F
      EDD04F849A90DEB5603CA370C9082E16FF342953E6E6ACB43F3126AC52E50CDD
      E190C3CF8893E55365FE9A838A2F52149F3F92FBC69DF8F5999715E738FA74E9
      42DCB71A71FDF7A4B4F7725BC668FEC87451FBBBF4E2195A524FCF5DC13BB086
      60746CD2B92F8A5239EE575AB53232655D7BDA4C713725434D6EB045A2828C74
      9C97E3EA5678A91FEF61E5524FF0D815CA5B701303C7B71ED1D1DDF65A95E973
      ECDA51CC9A7A3A11990698B7861DC14698D528742AAF18CEE42A2DBB3449469A
      2889CD3D54CD2E3294C97EE77A722443E4F9F82C9BA3AD430DB838AE5A32798E
      2D403BA0154A3A2256BFA99AC3A94431CBF919BACF328879C77758E01941A7CE
      5C7CA87A4A1C0E8314A09841B0DE585F2B7349161712AD93463FF66868D5B7BB
      37BB266DCB205A1BB8E994267D13CF54268D93865BA22A75B60CC75B159C0271
      DACA37BA4592B67ABBEE9FBC0BA53053F9456E2005124D5ECDEA5CD8B9ABEC82
      94F5CC5D2D8D386216A1A6F265ABD28CF789FB7794C4F36CD767ED5BDD3E70FD
      A7C8BA76657B2BD4459C3EA2116DD176B03DEE38A137FEE4EDB1903C21F108B2
      91F786054F259577F181274F68F0460717286A2DE48085960AD3CE8424742DE8
      4EA35F5F8B8DC955999CE36AAE8E97974FA2E934C6DBBBCBDDA8EC0C39F0764B
      2E3DBBE760F1ACD1BB1C9B1E0EF481D8775A5E3F1A645CB2B327DCC0712645F0
      929B0C6B5F6E3B9763978BDC58994466AB1848C9796477B32F0AA553CA8973B9
      C1A54E94A1481E202CF319779C125E586EADCA6FDD4D56A37F8FBC3ABF2D496E
      5F4B7113F1B4F95C10C6F889B704436EE05AB092C61517547C9328B3B7BBACB5
      3C707EDCAA095155E095D5610D8F36B14FE9F4A3449713A1C7C400F127E7B890
      5E4016042B031788AD1ABF785D76CB4791FD1283C4D9E0A6D0D4418202F28364
      B813D464D26CF38AD00FAF248FAA8489AF78876FDF7EB525EF39A3636AAB56F1
      2E3CE10A8366608C33244191F442314BF5D3D2030D0CA1FA408C4CABCFB4BAEF
      B8347C3D2A5742D83FB78DAA20E9CD55B5B2974CBC4097F6A579CB2E9E2B8368
      9BC9D5A7752BC8A0551E23FF5589359C418465E9F2ECBC7662E9BA561EEF9083
      6D63FA274E780DADC88807BBAA2BB3B40962CD646ACFFD9BE7AEBA9C058AA0B1
      0A6BEB76DB4AE05B7FB7A2BEFC7B6D19D6D7B6E098B16E777C74383DAB77D11D
      94DAC2B2D4321D8F86EA2E13F1C44C162C28AA4B85F8CD5DBBF0691DC7405868
      DEAC62512D33F626C17B6081F23353476D24125ED9307C17743679F9CC6159BD
      F19B9E457F2E01AFB8CD7D61AFAA4BDDE2B13561879A821212973E1A2D675867
      50CEF0D5CD4A004016C0B547993024CB161275963AB6362DE3809439DFB225B6
      B01DE8D666C0149E15D2DF9E9E69CE82A1A389F7D3EA8195A7F3AAF19AD171A0
      9772891C5717C30854891E336C9D79785993545F216FE350DDD44AD365B98DA9
      63A497917055507E57EE571507B9AECCDEE872CF75EC1ADBC544BAC3ADC75E34
      670D293A88285670304F154491D27C7A24DE14AF894521742BA2F295D5A820AF
      C007A2D34BD24D8B9AC3B936AB659FA6563FEE4C0F86BED2B87228A4D1392EA5
      ABFE691B71E37A12F3652CE914DB8E9B4B64AD66BC7A15044C3CCE5DF9D25E75
      563797E83CEA6BF08AA391F9FA1A77A42D488E7CAF678BB6F7565F2F73D266B4
      BD6FE2E2FBA5DF46611F14751BD2971453A611865467FAB1241ECD52DD8B49BB
      123876D62B2AAFAEE2244CAFEC1ADB1AD4FFF908804920E9F0D27D64444FB37E
      DEEAE857C6FD851D7EB3943EA2E8DDA1CF3F743EE24AD1C7BD8FCFFCF147BA4E
      7FBB63DFA2F8797F84C51DF7FE8E0DA459FD25E019D1F92CAEF1D92FD8D259DE
      1DDDB9AFF8FCEFB1B338F0DE73723818FBFC1CBF41BED4FAC99AB153EE52D270
      11B22D7FC73D2C474DF62CAFA7F1ED81BFC396EB99096EE80AE59983B2CB9609
      47CA54DEAC498BF8A119B301CE561C4CAE283626FB0C59D8827400C9D474C158
      F9151FC1AE4799C794F24FA99D6CD8548D8435BB2B7B64FF96EBEC1246EAB156
      B3E76C5B060CBBCCC102B612E5FD82360C17C4AC086074BC3DF48AA0FC2BE685
      005C66B3A66E15CA736F6F36E70455B6FDFE595E5534EB6B9523BEE5FD3710E8
      8C8D22889764D72E0B06D2CB73C3C651D61EA7C959CAE59C4B80D0D58E8B3D26
      8FDB12585F93B0A1401F7FA5A5E83DC852F4C6F72C456FFC454B2122C7112BFF
      B31B3615B8C47A55BF8590B270D877C6CD13B75C9590B1F8C4AE5EA9747F5BBB
      0C08553ECF887709EF58189F2A0EB68DCEF11DB7B4E1ED55AE391B5E5CA59A33
      8F3749774B9EFCB56E7A338EB7331B9E4EF8179EF0CA8AFD4387BC34D47EAB73
      5E7EC33D477D3F2A8D3EE485107A27459B96F3DC609E8AC15667EBBA4DFFE9E1
      3F5B5B5B9B1257974FDA163B1BA993F4219B231B122EE458A784450D99E4B2A2
      564CF58AB9955C97121B806ACB0E20E8712B8BEB90470DDAFDA34FFD5BBB28D3
      F3980F41F5943C925BBD7D8B6ED4B1139CD38066EC8CE3D0D8C592AB51B911DC
      7C24F785E99F63664835679B1F6A925FEE6AFF74FDB39CEA1260B828EF23E3DA
      1A21C2841C35AA0B34AD71982AC3FDCC808D98660EB96E8545C25C87722471A5
      70603143D925DF0B3B373CCFD65ED283395752955C782649BBB94AC4DD5B7DBE
      1DA90180B585D2D6C22ED9E62B96F396F75AAC69B9E279252D7D691887403989
      D89E1B9A5EE8C495D3F295E23A3463C7BB9C2979A95C008074E59264C4CD63BF
      F03BD2B743F3A093081FFEB184DD70756E4FDEDB101DC367F832562B08DB77B4
      976C56027748BB9DD384CB4C2B4054E55B728B444E82359E2FE7E65BE9909EAB
      9929123145DAE6A51ACE815150EEB956933B5E14D38AF01403ACC700C75F3506
      B8BE7662F7F4399F85C09C058B881E4B3CE14B76BE7E5A8D587701394758C6F9
      6FA1F86103CB60F87366B6CCE24972BC5167E575CC9C46264A55C4C5CC7615AE
      AF791B5544A3CD12B7B9BE70B6546E6EAAF3A4931A29E2BF2EAD314827C16710
      00354F4D3FB3D9148B92CFAB9CC7BFE83BC00BEC729B7E1C137FE70A187CA279
      2B7A0AE1254BEA044EE1A6997F628A5C5A22546B2C016D48777DEDA62459A385
      0A481026B5B5E32F1289E48A566ADF21202B5C5556A90D6FC6A2ADAF61D94EE6
      286E798E7A091F0D3926ECEB56943B7EE4C06E3DE4E2DEB9B4FBB646B0004B85
      FD227B72D7D7F05580B3D1062B8704A5669FAE32A4B23798CDCCCAB1AF32FD55
      6FDDEA9DC3762EB294ADB654C01EF2F36C995C7879EA39563EFB50CCAE8258F9
      A921FDCAB3F3C80DB8EFB1C4495A36AE31A2C07C51901648AF1E9335D7FACC52
      ACBA443AE1C0C00B1721A85160DDE255A9597DF5B61AAED47EB2BCEA96D7E42B
      5B5E2435E7C2210B8C94A4048AB044B2B4EFCC9D06EC22D4A3D311B1BD268E2B
      180609D918C5924B435FE9243E4BCA5753549423A60771751E87A14E9AA5CCF6
      23B1071DB4D3BD6B60EB288595E91C37C92ECA66BB728978AAF25999B06DFB6A
      DCC46DD1F089E3B72C31FABF70BF0FE984C7689846E8B02A58EEDEF847AE89C4
      51E12093A63325FA9B514319B0B4A6B75D65EFE3C57815E209A3925ABBF525FB
      D12DD95DE0AF259AA1ED98F76F388438CF75D05A25ABF0760D4B995CDB61A756
      406BE0ADC472E4AF15766B0E5A6602DE842A3B004EDEB17FD2C8727B8812F5A7
      619DA733D77243566E4E5767B99030E55502A2DB4D2152A3E93BDE4689EC1BBD
      2B63B225BCCE3326F76D294976A4095C89BD2E4C5131CE61C78623657625C31C
      D731A4952EFB3AED99E5A7B61628BE1D952EAECF43D6819B1D78191E7B14B124
      93D99E41432AFCCBE1297A279D6B0BE7F578BA07AB77FB336B72DF7D151C8C6C
      A9EF3036DBDE32C94D152D9E969B0B478A4C48E2F24D97D3E32FAE8624E9572E
      50898560DCB083FDC1BE2E89BC6B05A890B60355E522F38501FCB3F780D567CF
      510EE4A41553A43A4C637A5CC262DEBFE1E5A616D7D3EE88FEED4EFA3DFA4F6F
      3C98D07FFAA3D180FE33184E3AF49FE1608AB78C065DBC65DCEFE12D93DE6020
      9FC65BE8E48CF9319DE9146FEA76A71DBCABDBA3F7E1BFFDF180DF37180D47BF
      E9496248A35F0597B4ED79AFF07F6619E9E71DCFDBB66D3C8FE4368991E68EAD
      BD01552E4E9CBBA753F760A7AE3C6EF83FF39BFCCF1D3EEFD19C3F60FD8894E5
      E8599C49D7EC8685F6288366DE9FBC7AD08C0F28277E1E1618784384FFE643A3
      02A7AB08C6BFFE306D18FDF3E0639532791389179D8A5CBD68458638AAE9BDC7
      6A9BBD2E5199D9943E7D5C6ED651527A1185F2DB02947C3B269EE99226CD57A6
      B3CE80B4A6F5E4EB3E4076EFE0A6273FE6AD69A77F81D5466766B552C3BCAD4C
      D35D8094DAD07120806E9A584D0914DE6C9C0FE91FADD59B8B20428403CE9B92
      EE79CBEDCC69B034ADF2D6C8FC100A736E3A7F3DFB65E4E185F4A0B687298103
      5B5A57E5E920F2367F86BB25E3656AD30A1C680578E534356E290D3D58E66591
      0B397BC2EDB2CC9FA2A52BD1D2E9578D9682F5E52D64E67FF071B307D91C58A0
      5E376ABBB68BD9773FDA91F2356BEC50F71243E70118BB976E659FFFBB9512F4
      939B04FDFCE31D80B0CD98C98E046F76D3ABE4A5C488EC64EED907CCFAAEE93C
      5645BC6F0119038870918D0C8065D04A6A6BF5052ECC3F857A165C9E43A8E4F7
      8B17385CDE06B26E9BDE0B033629C7CEBD6895C8A6681EA36138F39C9962C0BC
      5037A5D611D414136D714110FE5A5082BB6F7B58037D3FC975F6E06C92EB6BF7
      CFDFD74CE858828A8A7D6C277E777179A5BADC46AB5EF323137DC5F50A9547E4
      F690B6BC8D702544B52949FCB9A13B30A1DBA35ABE354E18C434AC4685BF68D1
      C12AF4A5F0D2A7C7070FBDE812FF96E4304ECCEF7C54D6D7FEB171D78F7A08CC
      FCCF9D18BC6971FBB23C56816D0AEE72141E23E48494A13753BE9EE5B7E4F523
      11D7A7E7B555D8289B356CC423AEFA5B35B64219771DF8D856FD08FE8B2B82B2
      D0D37C583F81F792E1C028A138092AA55AAB11C3A422C4E4BB8A9B8541008305
      23E5E3B92BF0B53487790AF386DB609FEE84DC09F1ECC04F972EB3405A6781F6
      6A084C0C609A055F3200B3AD9F76C9D7FCD9639A4FDA5B9B307881340960331E
      11B22467712A3C2FEAD6EA6CA497EB6B950592C5DC740B05B087AC44F359059F
      434EC73546D4B89F15A34948770493F898AC91F276F60E0E6CBD9EF23E1C1FEC
      7204CD3BDE7B7D5CFE1DEFDAB4E4221A60902ABBA9852E9807C9B00121E270EB
      60B0B0704D2199463E36AF61CCB97EF3D096D88A496169ADC5B6C8EF7A788588
      484EA7436B87BB82D80EB25795AE3D9BFEB5E5D8E8EF41D7BFFB325B8D69C138
      C03225BCEBDE86136431422486126D93B9B856BEFEB10A8B0A88A82CCFA3B8E2
      A7A9EB3B6ACDF5FADACA1A94A8A1A4A08A1B6F031254E0C05C018400BDDA0E4A
      DCAD2C6558B39D1F3619A90C62A1C421AB81FE8B9ED2E1EFE94136F1F0B5F693
      BF900C641680BCBA018F48D77C720DBC0DD70F6CADB6D5BA5783B08590AF7DCB
      1DC53E26CD6582BE78934077DB2AF5B74E873966107E6C913A01CCEEE15FA44E
      CFBE75E34F4E0CDB3FD9620465A1364BF22FF754C1FC63BC618073CDB8CB2308
      985983FB60CCE016998EE2EB121874E1CADAE3D5F87E415A4EB09335E3A58873
      EB63BCF4203682A17499A54FF850C4A0548C979715D61F966FDEB45691B4315A
      5D5E3373B93809CF1466141AD48D2E4A02AF72358D629A1B3A60142A32325AA9
      9EC53CA7971D70E20721307C2949090B61CC7BF8F6E8D433A08D2AB9A913DA9B
      24C5DC805195A90AB3A0F25B9C95EC608F9E7AC35A76C18ADDEB6D08C00EFD6A
      480B371F9B19DCBABD04AD9200A856AD6721AE1971CFBB774D9D796C8FB43D7D
      6F2B88DEAA5839F1B86476105A2A9F0C8074B5C6C9C16FD6CEBAB107573ABFEF
      9CD9A502630D5F4E98B6B60DE7F6D7D59E6C60B16987CE1821D6708EAB2A9335
      D7DB06BC0051453818A84248563B92C2F669994F32AAEB596CC1A283F33416C2
      A3D67FEBDCB2041996DDB7A9FBC3CA748D1F585696DFC6C8B6B3BD73FCD5FEFA
      CF4CC498F91B95A5AD2F1617739B8FDD1EC6A66DC1FFF49A97DF6720B7EB9134
      D1538CF9B4AA55DBCC005373ED705605EAFC8B0580245738A35BF7D66A60FE6D
      83506CD99B5301B68E8BBC6467CE2BD3327B507E00A081E5B9A76F5B591541FB
      3A2F1980E539B9D5EAF65DB7D7D9AE9BB463FE2856ECFA1A8A13D98E15C7A96E
      05D343777EC098E6EC332843EC5E5D5DD7B7335FCEAA68D68F56B9708783B1EE
      4094820BBA7772F0583488B0065B615E309AEBAAB9C9B7CC596AFFEEFD9FD7AF
      5F0BCE3A49C3F9421218A5E13A973EE9880CDBF253FFF627FED896E36088C86A
      AEC32617290E29194CC96D53B78E97FF647BFD6ED7E3581B3A40773F48AE3E22
      0BCBB57720C406F8422BDFDDB1CBE9330C814CFE8E8B1C5422E89F761FD92EB8
      4F067DBDF38E16AE7E253822A491E75CD8853A0AD65F4CAFE37C4DE69454809C
      C92D7179458B8B292267E989CA6CED8D4EC8639D319324BE75AED9D8C0C61FBD
      DD3E74250DDFC82DFB55A9DBE7AFE3EB77B06FE85224817E7042E3170F9B697E
      FE36FDD4807FF5702111FEF63F34EF875D625414E1683DF0681F7871D7D77879
      7FA3C156AF9A651D3E939B883A8D4A20CF913072B61582722E0C5E0687953949
      E67B278771F4847E95CE666A2171BEB75CD7EAF2FACAFF4604D8AF3513DCBCAB
      65D2869D9101AB7E7AFEB397DFCCFD7466527D7544B940D650EC67C730641616
      8E6946AA7D41A74E3C62FADBFADA990B2AE775F6EA324DCF46FA6231039D3417
      4B4B0B287D7FD9CBCF26F95CDD984806327369769622D0516F9EC537A334DAE1
      C019BD8F2F0952D6F2BE0A2E18F43BDBF23624066B8A022CF7B68CCC631F181E
      023719246961F9242A4504FA5A71F6555EB09FB4289921F9C2315CF5B2F38F9C
      04696B95473A12154E16DB62299B079282248615744CB3CF996996E6971465BC
      2CD46D5B65215B64F74248E256D79E6B224A32E9550AEA3D338DEACEC05D22F3
      6ACFEE1ABF1584B8EE298838C192D32AC95DCB162A8F104B5F5FCB509CB7BA57
      967B6615AF6A859CBA1AA217E2433B093BE10A739B9C4130A6C7977108B6717B
      D49879A2FE797973F5E36E09EF78C0966C5379CAE979417901943C73A352F666
      76D2209916E7C02007EC80B6C1953BBEC5AD2D3F4D20A73417D9722DBE85C32A
      1BA7F13EB760DC5C1ADBCA7F77764CC10B1D9FB629ECAFD23D95CBE82EB194EF
      85E9D2AF1E415B3FA6F318E7296356635BDCD3910C49155B88B3E49299C9AB40
      0DB40E16AAC1243F507665A029D42CA3D37823E05FD51178B71BB11249DB48DC
      D434B862E0AEBAC7483C5A4E1AECA3877D7D8BA49F043C3CF1AE5E43C47C4FEB
      FD4892F60642A8BE102D27F3ACF759AE8AED162A11546290DC5CD79AB551062F
      7004DCAE6A34A7B9B6FFC1D2B3066E8557A470BE5A8D52DB18BC70285452DF79
      DD477E6E6BFB91545033CAB4756EE05F1EC5293EAD9A70AC69D7D798730BE18F
      D5037C756E593E5D9AA192EDCFDDCA7D22F36FAACA1D935655230B46460D2844
      223B4216995E585ABBDA984C82DFA61D52ABB7B50ACE2BC3C3F37978B79E8097
      1FBB38779D261159A96CD89A8A0356B9AEE2E0B180C3EDDE397900C2C7628E65
      9ACDCC800DE40C47CDF8D208012AC1BC90C6267AB741AFE7D03E4A2CCEC0FF76
      4626BD0323307E532B2FF0979FDC57FECC6153FB21D7BE9CA4A6C4D8BEE2BC02
      7AEE99E900ED76E8C093D968D272521C8DC1596B8F76FC2C033D7765D4F6E61A
      98D240493F867BBE454F452C6FB5CA9A41D384DBC6E4472C5F32ECD3D5B58413
      56E1584D6DAB87D164488BE437E44DCC51C7F2CD5ECF3BE3437E1921FA92DBF9
      1CC342A5D0DFD6D77E2B09C0F0E62C66413DE622478FE2BA4305DE1BD85BEDA5
      F9D218A4DBB3DF2AA857D6A238556D8CBC1387F565AB3648A58712DCE382335C
      47CB152E30AC484A8AE754AB7B938C7ABE555C171C38612F2FBF88857116DFF7
      866BC2CB6F644FBF66A0E21B25CB4A5E541CBA0F3DFA6CE31BDAC78338B9F05E
      78AF8F06A830C76F8FE2C601EEAA32675BB901ADF57A70B2671DA5380966CBB0
      5434FB269C610B3DF21A8D2A3D502A5CCC93AB2C31A6AEA5A443367F000F617B
      A55EABACC9340530F1ADD011DF15C44DDC1E7E1A08B6F54E15E72D068930166C
      85A9DA361740E1969CF38176DF12B6A1F355C5E6B8C3D4064D462A65B932A97B
      99862A45B7CEF087714C5244E6A06CF0ACA6E05D26B6C6D52858A12E97C03B88
      7D4055A9A4627D5DB2938AD182F19565BDCCDBE132B10FDC28C96218DF4747FB
      E2B713C5AB706C0836CE25DCF9D0EDAABF9962717400F5D372FBA8D3C61DBB93
      C81C9EE64C339D8A9CE957E441A0008DFE72802B9A3D7A612F89379B45A886CC
      C5F32A5318517CFD682855B6BD194A043D5376836AC43B97A3E229CC55E89AAB
      6EADA6AB41AD70869F554B3DF613A9BA0A94E183C8B52B2136559C6072BAAA56
      C12C1347041E7AFBA787B9E1AF2FE1032AAFA3916C199C437F95428DD3AE7140
      3A01DF15E7F3526254DA6F4C6A04C11783494AEB6136AF1682BE6BE26D87A95F
      A08BC1927DDC8A155ED9226213A65C4D111809667C3AF2512BBDB334565A52D4
      2433BC69D91EAB0D0AAA1DAC4949F837A06232B1CB4ED9A1404E27DEC5ED8562
      145E56818F3EB95E4E97C84AB568259619589E5A772C8A99074334E1EDB9F7E3
      E1F6AEF72E831F5A709E309299B74E8A6C19142DB8F3AD6D4606A397EC1F8BF5
      B5D4D514CD35CE6AD57266AEAD2F7A521B48B6187CE6C745865E0B39F90293A4
      A5D88A0517928965FFC57E616DA29A1902300ACC68D33B09B278616E4C657AD5
      50DAFB7D6FC3270D0C44024E3201D1365367CF9267E8E277190D537DEB6A6FF7
      932875A16B5AE2D0C417B0C3A2CAB9ACF89CA1BEBF50E17DB1BABBA1FF3D9FCF
      9FD34CDFE73A7BE95DD378427DFDD2BBF94D80EC1EB612E56D9A3C74C18CB711
      CBE5EA3CFA14D47BB6B961E6A6D9FE2EA3AACDD4994868C5C587E05E46B9F8A3
      D0A6A4DA4EF74E862FD6D74EC885328ED08BD747E391B7B7BB7F6AAF70A5F81E
      4AB0C4AA68DB6E088759BFC8E23433A5F6C1E2C83422945E814BD24B9187EDC4
      11DDCC0F872248D8E5C8C890B4410B5FAF684C653EBCE5BD42AB5E5177D6A422
      C1EDB3C43D9846DE2FE901452998382AA7C1B2722292AA605A8796EBA7B08903
      FB2E5780BA5DFA8664D39E212056645A9174B563403CE30A10CA7611696BCA65
      E4B93877D02EC3EA22705C948B4ACB6F13461CF19E5657413EC5A8E3E2DA2529
      C754811586D1D58A5438184B17E1B18B084EF348A54C605A88C89779C1EB896A
      663A2E8F42360822AD68EBD25C9318A0E4C8EE59A4F8B6428FEF1B4DFCE5E3A1
      C3FFC07A912CD5B2BC4C0C974A73ED0624A3A41151AFB5598D8E94F7A8D6AC5B
      D6BE7FFE0C3DEE6B66EC49B291234105D9C0421F1FC12EA5ED00348804E6CA00
      D6065042DADEF6CEF7C7921C6B7B07DB6FE96DEFDE1C9B37BFDDFEF1101FE727
      8257D3DAB029A3B06D6C5622524C1302FB77F391DCE6FDC42C47DB62ABDCE11A
      D4F702AB44B760E0F6A412B3347DB2F810C296A52366120875AE6F040B995483
      3B17A5309C096ED01F95B257F39D77DDF66EAA40B6B53E8EC26140E55A6548D3
      C39FA874B6CAD0D1AF1B4BC557AD655714ABC420E57A22276ADBD737F9F87060
      5252A5F5A71ACF38E2E09404BC847A21D16C4F40975642CE6E7539F7B1BAC477
      1E5ADBCD650F6FDD0973003334657C5C5C367A82B7C1150BA06F176C2BCEA7CE
      6EAC5153E763A29517709D766926DCB398B5CAD5D50EE8CAC2310B7A251CA124
      9A826FC96B354ACA38909FBAD0D216579E08EED589CDE3DADC746A18D7B1A8B1
      8D2C9B60016F308D22D32E4081CFDD1990966E50842EB043652C5A0A4AD82BAE
      EE805B9687755459243DB4AF37D764A23EFAAED5F796E2C84460DC55A6A3519E
      40A908B667F991E801B98E9FBC8789907CA69623895BF72A2B6950BDDC25144F
      2C6C57653BFBD5EE057E6C954A039E36FAF098E8D5026395ED74063E1DA0E709
      D7058B8C15878573447CB7E556F32596986F5586F9CB3363B8D6BC2B376AF6B0
      4A69532E48184B09CADC42B8972F59392361DCCAA745FBB0EC75156F16DA011E
      9F2C84E1B1B76B04F1EAAFAFA174EACA641719B5D73042B5CBC270AB9ACAF9F3
      1B6DB132CF191F8056C22B4070CF042FC668A795C3FEE82341DB36CC5DD2A121
      9E7A07C9181941A8D6B255ED39876597C8CC98F0C523111CA777576796777A83
      6D2744FAC9E299C539B030EAD904234F6815E94A716125423DB757542C01E36B
      56B9A12099A4192111C0A26A07040A385D77045F756616A8156BEE57A00C9195
      36581F2A17832E73668E206594A3805963403DE9C952C352BAC5E5130DD66D2D
      E36D9B1A4A3621AEBFA127A0F945E13D5BDEC62BE909C65B540DF9B0D2FD54CE
      512C1C91C4A69BB88E667205AED985EBF1116066C9E3D7E14D69CBE2401BFBE7
      4C73BEDD9537A83BAF095E11CBB8540A5595C263C32CE6124E856508896E7A58
      6E8BE15A9D8215962BDD62EDFBEA83AB5A05CBB9BEC6F8DC52E2C49509F6E164
      BFA3861BEA0CDB2D425B1A9D405351A965B09FF882F2E4472E4A5BC78CC3D222
      0961D6E85C6AA4EFAA6A79645D8FDCED61D7A71A7BF8C265B24D49E70C5EA713
      8B79631FB1005DA6AF03050B2A2E18491841A6DCBD910B73CF51E56384A1488C
      D506DE5A5F95058235C17F32ACC4132CFD244E5F3EEE63BFBE7670B4FB86B6C4
      186B8FE444FFA832C6D29559DF5564619605553EDC95995CA04C42E769F28747
      7E604ECE3997968A1A5DA4B1710190219F2390CC3974323FD2ECB1D89487D28C
      90972ADC850C8D88432C31E256D72C5B2E9827B7BE82A6CA65C3993C0842BD55
      6F6BE683AB5483B48D93259FD410F0E29239ABF65954BE9811A84B05FF89D1BA
      1A19EC9E9706A830B1FD30F5FD4562D4FC5AC290D629B450217291E0B1779C96
      DB67C58E38A53D8C816DF30A465C1E2AC910723F9440F2458A538792F9239561
      3E8FEF93695823CAE80632E3C5828DCF12EEE1560EBAC655E6209D2B7952B2E5
      0B66EB42B316DEE367E985987B89316BB7BCFF4E97A2722E3842EAC3B2E7CCE4
      D513B7F98734E34667EE0F3DE49A21EF45895F6EFE82DB70FC3EC1FE0BB0FAF6
      2CE6DA05EFBFDE9F9C3E9674C6EBDBE5642B45D758A7B2B79F0BAD70A4977E35
      DACE37D5AEE3C1C9A9F7A74AA5AA2CEC658E97764EE825004E98AE85EA6B0778
      ED2035A93E7E65F39E244BCE44B364D259F401B6BCDC280D076025CF523D0B52
      A9553F0DF613F7602BE36FE6B03C714BC05BD95E2C489E9D04EB6B88F373AF9C
      8508AD94913E924BB4EDBDAE30A9AD144C9614969213B1A89EA9B0A0A47E7A6D
      02B0553A36568DB3784E3F2219139705A8E629F6B37CFB92FB49293D3EC7A453
      CCE5B6586C8061ABA5966AD15DE7AFCBB7B56DD0D4A6FECC206E41A2B4EFC18D
      55F985C3665929FA85EE57978E6DC2DB38B1DA328CF380CE0D48D8CC47CAD2E0
      CDDAD8E5F65B84DA6096E6A675E33719F3FA5A39EAEA7805A1352D56AA18CCF7
      56C76E569CC669236EDC4DC67DD46D5B20221833E6D3DC516313B8489862BB9F
      E5F42D3A5856B2A6FC6079101297F261D7848A084D2DD80DEE5046D3592E2443
      69F3CDEC86181B6515C1178F79DCE28F9C105E59B6D2BE3D79F72BA1D368BE81
      26A35C23F52A7065FBD1619CE3306F288DCAAF97DEFE958F1FFE48D748DE82DF
      20745E22504DEFA4574ED2AC9017F397DEAB349DC106FE93770A8EBA3F3E7446
      172684C19DB5BCBA0A900BBEF9DE85EB29BA4D98C73F2CB38449F8CA58AEC5AA
      2103C1C13833ECB449D33F6C9EFB8E65CFEF586EB7A0A727BCCEF92796F21FA5
      ABC30824D166413AEDFCD1596046C0D9071EDE16F20576B118AC4B42649C6614
      5E202F100C6DAF72266ACC454EE0FC466BFA4A93F213D4BD0D6590647859CDCF
      0F7F200580F1617BD4CAF9EC25E1EF399BF5B555A839E83BA85D932C417AC496
      F1E5869276E933533577669C0BC57785FAF27C79A69180586889477006166F7F
      21DA910B94B889291346F92AE2587530B3F802FA32CEBF8065A794C1C5F5B43B
      A27FBB937E8FFED31B0F26F49FFE6834A0FF0C86930EFD673898E22DA341176F
      19F77B78CBA43718C8A7F11612F4637E4C673AC59BBADD6907EFEAF6E87DF86F
      7F3CE0F70D46C3D16F2AF819E2F457DD964B656109BC4AAB0B9FAB1D4B29F647
      F30E1FF7C9BDFBC50B7211DC6FD5BB563E67F38FEE0D852B23F1F8C3521F475B
      6ADE7DE38C623A68E513DC67A298C9612ACF28AFC39D5FA893D0FE52F9F19F5A
      8F97A28254070335EF218CB573AE830B72C22FFE781BF3E27793780F3289F7C9
      8CA7F125938088FDE269AC083A7253389B63D0AE037C374493444338EDBC52FA
      E752E765E6DB107318FF2DE7CEC73C9D5DF293110A453EF92AE6860769DCB320
      DE36AF0FA0FBB2137E51294D79F06ABB0F69360B4F162AD06DEF19B2BF3FBDFB
      F9595BECB6DFA437EC6195E4DD53E8B687BFD924564E0CA499228DB9C108466C
      58562AAE36EFADEDBDC2A0730CDA94B7A2B0E283FBE36FB3E1C66240D53EB3C6
      7F0B669019F35B85B6A0DF64D45297CC9D48B42B1702BF30536739A03901F2C9
      EC33123CE01ABE5A250B6A6D0D78ECA3F6A35F2DCF4CCFFD37A2711FBEEB3ED3
      A659DE5F9E55F3C05C2F60D18D81B712334038D256E0ED813EE176FABB3E6603
      37B6188703D8F619A82732E02CAEAAE97F3EE225440A79FD3F2E66A484CC2678
      AB4BB032F92FBB911F49179FD3A7FB1F439F7FE87C4449067DDCFBF8CC1F7F2C
      94FFB73B363F8A9FF747D8A171EFEF380534ABBF043C233AAA6497D367BFE05C
      CC308DBB0E073EFF7B1C8F7F198E07DE73C4F9820B2EEE43DB77AAF3E4592142
      C6306517DF95E5538DDA409AC08826705C727A715214E3371582257003677AD1
      047F66CA620C9F7DD32634A609EDAA42DD399D6F6512539A84F4DDD9F3C485E3
      E4A217261A476E4F9072D00AD0AC806A589458062431DE9FBE7E3EF1E0D17BCF
      83C5CB6511D1AF16B4A261D39DF469BA98AD0B9F9B14BBCA2E24F92E65E926C2
      CE9BE82A6139AADFB409412C305F9B61224DCE4C08854BFEC93E9C31594450A0
      0C61236785B259296343115BCE5CC4D66F0EA536C49528749B36E5E1AD239B69
      C1FF30F5C3F334414BB82DF49DA186CF540D4B716040A717B9B03C2E963508D5
      C6CC11C2F242DFF829D45E99168C139623BC4518695ED3024D9B0404A4BB4B7E
      3A03444952EE5AB4C4AD02DD83A9A56CDAF827B85B76B91918475A2CE3C0D101
      A7343FB00C9712B1C91B32AD4E0863A2A19FA759FC0B620B3303F50C40BC0001
      89DC465FFDB428D2F93CCD25E37CD3B0694D3B342DD83E2809A36B3F373937AF
      9AAC09B5C87B8E311B6E0172C2101EA16DF4D178DAB46941B4B750F402922E83
      AFD8AA41FE49F957A3C6BDE1BC164E97E752E9FCDCE5786C3608710F6916B0C2
      3888B36039477B41C0E5D5168ECAD4259ACA3E13DBFA26E62CB9BE172CDD50BB
      7FF6E2AE559869CB597219676009F75A65E0A6559660D9E8DE862B0C342B63C8
      C58180A09AE5B66D48433798461059808CC4BA1CA8E46C8942D08A62334C2157
      4ABA8BB7C4F6CC0DD63C1D832D3F572FB67CD5F3D04F0DB6E36F61AA641C4F4A
      031AA1A099B9D0A167A728CDA0E44628085F72F04A84359250F65DCA741BCA21
      C0735D68A4D12B906912AF16A19D395FB872950CB614AD57286B5D6D106EC67C
      D6D7EE999189DD99B6B5F20C03AF1D1280DEC7FD5A2827B20C52A8CB61DDC9BE
      A0542E723AC0F4AC09529B9456938097571AB51C1BEB6BF72C47C2704FCC4458
      29462BFB065F547A066F16069AAE22D68CECB30D392B0CA652BFEF94B7E7EB19
      77F6714F48B3C4DDBF8C3A1D0E722C8C98575E4236AE7156D462E15D1A183F09
      F2356AF0F7293157FC67925869A5BFD369226E0544C39F79D33229E299A978B1
      25678C35C3E1C59255B4D953FFE9F5D1E067EF35D850E994BE39387A856B7B95
      A50D1B3F49AA7B66F0298B82D9BE6E438148733B0C13DE546B75701388D9D13B
      8E0463D7C8A968D4D25416667DADB6345C0E2955E03BAB59D80D0EA7568A1B37
      DB5EEB6D0A3F627B366B95E7DE25786CC17B05C88FA3324D13E2F79C936DDED7
      CA6A706B36C314B9DA7AC1092F43269BF5464A50876CA0931F860A23F96E22B1
      E9CF14F0F3BF8955E02C1D9A96DCD6D27CB8B4FF9BB035776C548B5CFA225816
      26FF28DDD7D2706519CFA460D8B04B58388D1B53779D3C2BBE85E91ED3E94CE7
      DEF68F753D7355A99F6ED634EE3975A7473BA5815C972CF4C60F71326EDE34D6
      D7EE98881C343A80ADD764EEB0A0348196AB382CCEB961B58446ABB38CB9203B
      5993995606AE463EC7FD7C784EC36EE13DFBF9FDFEE9E15EEE6D18E5F88E1CA0
      F89AFECAE8A768D7F5A488D5DB9380FB261B17C7EFDF7933E5EB990B0A9852C9
      945668FE6DCCBCC2002A2D22EE341B54B159894464017E76E4847C7027E49B98
      E92B2097D39FBE47CFA8A18ECCBD1D43CC45FBC9462287BB5FD0D94D9786A64F
      346CB0CC0B21309E372D8A71CF7C6D537A9CE74BC18BF1AE7797F385CC2A5B26
      89A18F55D249C21D47E69A3B205D097A7D13F3457E8CDBA324EE12709438C2C6
      1E9910326EB7E949865787F618B0540A391AA7390438EF9B986E3D9B668A9718
      180C31456FA168BFCBFC3C38AF0103339B953819D2079DCEC2A66DF03DA65295
      74FBE80774A817256EC82DCA2EDE6C27CCCCFAF8DA914D33D0A3E226346E7579
      70CCFA3DE4E41FBC2EBFF9FB74E51F4511DD22945990A6C877E85DEC81928A14
      4C968C5B083860C68E98A5506319C5E99F1B3EC4DFC26C9789B43B0AC833264A
      5E37CB114140609D1227EE7DE7B178F122757269553C5B66966BB2772E8F320A
      AA695ED8DD8B502966D092BADFF8137E36A80D966593CC26DA6AC1DA71D0EDA1
      76CC48F4A220F1344BC1DE1FAA11C0E6367739F10F70BE77D07F86C538AC278C
      A4BA1CB2B9921DDB783763CB592E43954F508AC96FD2A5346F5630E06C228AAF
      4B7FABBF35FAC31FFED0ACA8EA7D0BF641DA5CDFEA2B76A1566CCDF5B5998528
      AB682E91EF954F227261E2F97808978BE8A8E0187E956EC8F6C9B67653A8487E
      AE50CC48A8D320AAB564F1D17C5D06F8EFF85A562820CD03DBAB9A4BD5E537B1
      EA27277BCE58704948595D2366EEE6AAE9D6C2647CDCB008F6BD83C13731FBED
      1F2DE44C0960677DF76F6202E2677B81952BE45BEFAA2BA463B3704BE773538A
      937B0349D339200FF8ADE2BDFC758922547EC23731E5F374E6F02A4D8508D7BF
      5C68536A4A1316A8FC12ED04C73328B2992D29594D52410C97150A3540A9662F
      86EBFF1702059A40BC98099789031EB2E003E2157079C2C35326325200D33420
      9187EF7FE83E0CA91C202B1D7E8CD94056994D7453EED9AE128D98ABAF6CDDD2
      CA698C6B7E099DCBF8173487356A86F766D377E89A79DF894786D97342E17B41
      6EBC43C9F0EC6C08898382354847130A660420C397CC6FC5D365759B9DA4AAED
      FE7B8751344FE1EB90B4D2DC091F946CB1AB982FE66C08088F05A35871609983
      45C07EAFB8E5A886E8D2A8A5B9DF5E66D9F5DC545F384205574F70078C6C05ED
      BBFC1823A5A13AC39C2267F395CB629FECD6CF822C57EE60A316EDDE7A3441A0
      C0D1A882C0B4EF9426A6C2C23591964BA62A705AA61080017A9AE65F7E4E05D6
      6ACCAA44980E96DE152F739F5EC425E5DFC41CAB19B1B63BD355C7CF6C9C81C8
      950E164EFA170E3D1B7D6466011A35E97F1975BBC8D60A881577B9E180B22D47
      36EC4262B62598914083376D0A3DD389625842A546B9404A64EF0484380BEEEF
      96AA5FEC58CAD53359CC39DB464DE6DECAA14CE5E7D28CA282C044461597CE1B
      EA5AC90A7131A49CC7B644F5D84AA0776AA91A5B2804BA0433C4D7DC92B4BE66
      D0AD84851DA05C0E5DD4B41E594F0D17D97D93B275C425947B615A9B940CB851
      4B7BBFFA6BFDB4ABF5E26757BBB2619920FF17F105E9B3DB6C7DB6CC1A352EB3
      34BD908C878D0671FAC6320154B9E2198B056DAA86E2A9828BCF500630EA1AD8
      7C38EAA296FE9DC9A51AF72E0DF502E7A5C85432AB0EFAF76EB8BEBBB5F4EF6D
      B81E4C565D31D7723D9848CBF585CEE0F4F7479F5B5413A94A849B43FCC0FE56
      6FABF71F8DDAD7AFDF157C77AFFCEFD515FCDE9868B6AA14605B6988701BE766
      AF4FF6ACFED86AD4BEC9B81DCDC5E9EE76494CD4C4810629E92129F1C6302DA3
      FDEBA37EDB7BFDF647F12B2AABDDA83918B478BABC5B9D460DEC7A34F00CC443
      8346255C12A433D90CB954592C7C0C6C5063C80697BF51832E21279B383A1824
      B6D9FA0106D6FBB281F13010A67403E3A1463D2FFDACF2E80E06FFB8F6E00F7F
      A9FA886797F700AEF0637E0F2DB21D8615121E4E2473F56F6071DB1E42793CD0
      A6BD462C77EFE49DF38B0C61940ECE13C38065009538D1499E54B334DF63B758
      A4A3E20D3A2AE0A3EFBF7D7D244C5F8DDA255A45F0CB9714A88930C64B1502C7
      C7BC9D1D6EA06ED4B831A6925EDB44299B73799F24AE791A4A3C7080AC10930C
      8F98185CF1B27BB0D3F68EB8DF02C1A0CA2B7B27870D0BB33E7A910616FB172C
      D7AC3FF66EEFF88746ED1189DDFE0BF2547E162E6C910C8D1AE15E9203AA5359
      D043693743330BE252B9B36F9BE9270AB41A5DD20C11B62BC5C1777D26C50470
      15D33034E441CD1AF8FADAAE81280D6F12358F03B2FAA4C2328AF52CB42C64A6
      A9C6A22C2B6FAE3374B92D54119C6F791F104F43194CF13C360C7A6A266D1BB5
      87C591F78BCE52EE01E1382FF0A372E0A6A462CACD248CC8E8CD00A473051926
      F468BE56E2B65B86079EC98991B849E8486B042AF318753978B31054932568D9
      D4143354F1A872F09DEB59648A40CCBB81419E26BA5966E3AB936D7AAE77D9D9
      1A366A5CF0EC1E1652F4794E7FB8BF14E41F46A55F38087FDEED8592F26F0B25
      21A59017DAF3E304DDB071085A5572284C1589ED5AE1426F2E2241C2403EBC25
      2070E70A1C7CD22EA066C172C6AA404AA60E77879207397D9D02E37116FB5915
      B8FE29E07C4FC0B9FB1470AEDB3ABDAF6AEBACAFFD7472B227C6CE0E6B039479
      CE96BE972F174853791BB0578D5DBBD986EE03EA5AC52B8136B4762F6DF5C34A
      8F7FDD0A82E0B7A8236BD429248B73F882F6E167AFF5462748B871F3C991FF17
      1D1479CBF2830A9149B346EEEC5033C6ED6286BEFB45F34C3A83FD7034A8B0AD
      366A80EB6B271737593CF77E3CE6FCC36BB4242E8B017E37B7F125594A89694D
      8297F2E33104EB96BE66DC789A5BF98736FE6218A3243FFA9CCCA5E16586BF3F
      8FD201FDE47468B3766A7D4DE8CC48D1BC848939791E92A14D46E3B9BE56A10E
      E239A971D38C6BC0956346ECBB8C4329CE6FBD4274C760D36245D20C68FD0670
      BF25E66B5B2AC7CC832C195659E2CF78998D5A18AE90AB6147BAA8699C84A970
      B6E6F13C9ED1A84014D7369108AE96340487A6DD918BC6985ED13D2F4D66CD02
      6C6A1DEB5C506B97013991BA757B3AA63850FECE156F0B95680BBC3F17A2AA8A
      BBA292864DD1B658DB80FDDD7374049BA1F7EA868BFAAEA4EAF192B4C5CC1534
      BAA8BFC9C4B2750B88A646CD797D0D855CDE0624D8FF92DADB3C548B43E0F566
      F956712D1476E58BFFB5D479710A98297E91F6104D99CC4F8A0A2A8681956E55
      436B2CC520D291CD6C89E43CCE965C77047354DED5A80531B472A1436142B83A
      6E9E0ABD344DE3FEF24C12BDBC559028735388D5ACF126953C258B461775DA7E
      B7CF2E6209B5FE973C4DDA5E12472434E788F7C46A463FCED2503CC627CFEED3
      9EDD935F57F7EBFA5F3786CDDE84B1274F80714C5A62CFD4BC1863B2511B6606
      7CB2D754EBDCB80F62937B83462EE227F4884034A2ADCD9156356AE8DFB06A79
      D20C9FD40CDDADFE936EA8EB86C1936EF86713BD42926283A68889A20A3D9FA9
      829371B6314902318E542548E773C8B91957A7D8684CA326D63A3114455FEC7C
      376AF89F77AD9EE4F67D72FBC9A65F91DBC3AF2AB7BF61EB8E4B6A5C8EA02A25
      CF66E915F32768245B9B356897DB78CDD5200EDD52165A80F2B4E2C012CDAC89
      53585F332B8F7FCDEAABCB340E73EF4C124DDC4F9769B2B73105EC48B8044B3B
      525026320EBC7F09B3E76DB6CF494818EBC1D47C00F710D114060EE74E7D06D7
      130E9D12A50741BA27A1FB19A1FB94205F11BAA3AF5DDF6C84C036B74CBE7BB5
      B7DD44C4896F2584CC748380CF85A8D1F34571E3D143D44DB346796D6425066A
      45FCAB93ED6612D5D8C1D2113027C0E01FA17B50A3615BA131589A86676429E4
      815A68C8FB464D832E99D550487E1FF5E5B72785F11985D1795218758531FEAA
      0A235FA0CBBEB9814BA96C36644D33AD2E9A383CCBAA46120C1D455C58B6BBBF
      7DD0C0A146B3541536F59C0110AB69CE970A2F15570E1CA621B766E55EA415EA
      291A354C502BFF5F7059B2FC6F99B65D2EB25D056E6AD55CC89896FC320E8182
      C8A8378D9A1580C34D0D3143F57034B0441D6FD458CB9C46731B33CA317A90F7
      A6C20D916B640C4D7C55DEF0B255E8BCD85A289C17E3953AB71D55740C808242
      93C1FF72B509D91CFF4B56C8A6345FA388AE515337A463799E0631B73ED86E07
      CCF9A1CB6E512B482B7707ECF9AF538FEDDF62A4031EE9838FF36111DFFF752B
      4AFB0F3F5096960FBDA651728991AEAF3DF058C14996E48D132A5CCD4EDAD13B
      CACE5412FF427ED246B7CDE1ACDE26C25891F0E01464AB1BCE13E943BA2B7BF3
      E0C0AACFE7A919C2CB7F333F407AFDFB3F337B4024843A0FDC8AC440C740C203
      AEFE2C0E8A95CB484BF0AB8FB8D134B4510620AD51EB9A3C7C7FD7D1CBDFB2B9
      8B0B94857286DCF3C5B23060BF6CF941759B98810D6703357FBE0C10F4C00992
      8E1590B68283F481A7DEA2B96F6D7DFC4892C3098E8F1FC90EC93F7E5C5FB39D
      1CA1B71B039CADA091B6FE99EF6C192A15E396ECF1F338346E1C7829A5814E05
      456A1B481B367E8C5DE800102C03D923921F8C477C7ABCB767D2F7B48F2E0FE2
      987234F833B56B826D20F2E0AD4C501B13B895D37FFEEF06A7807E70CD484D8B
      159AB97CD06A91262FB6B3799ABDD89ECF978929625920689B9F6B5D34EC88C9
      B85F1DED9EBEA07F7AC285ECB0773938EEB0DFA4FBCB70A45CB1951182501A02
      CD2A304088A6B365F3FAC264A2FB362BB17BF4EA3F3D7280C359D334A219E9F1
      1DE8B9A1065E6909315EEDA4788A47DF1D8FEE6CF59FCA465602D293AF5B36C2
      0C7FA3E94B4F2DD7D78A744E565220F0094637AF803A705B4D84889BC14F4716
      DF5373BC0B6FAF12BD3B48B166C959997377409336450C3129F46BE1B2174C5C
      81BB35F7FD08F85524571B46CB69A631EABDACB0D364692176AE4ACE66500DD9
      BCC441DEA898C496D33B2DFBC4609B368B0BEA3C2D2EF44D5EED652C1B124D57
      E3C6C39AED42BDF7E0B18DE7C2D696CDDBA89659A8878ECA7CF7E0BE83596940
      A83C7458EEF94347B9CC509334D15F38D6BF23C2F2AF0F3DDA38A1FB5634EBA6
      ADAF8137C93B398FA3C240F3304959490C045FFB225E302C7DCA48EBE602D2FB
      C809D880E149EE4D06B6F16560FAE6E4A364AAE4A04B25F5803A600120D2F945
      81740E19E3CD5A8A5B0B1158F6D0A31F3E298918F9291176255EAB8551A18EEE
      DBC9698189023A91C3106ED41AE86B34C5EA7B476ED780619BD4A58A673675D5
      4470071913532E18CE3A446BCF48B59BCC2CED9118F55C294B02DA448B726F03
      A58ACC61C4765CB34E2AB894BEDB0186568C4924B31BEF2DF25C1817F306CDE2
      859F2AF02CECE501137D493DA69027C9B16DD48CAA55CB068BCC5E1404528CF9
      192EC9D289D42CB7A09D97427A99B8FA6689EB358FA7CD349E4B0A5273F3B040
      59B4E984CD53EF991039DDFD36242B9F356A3AF7E4842BEDD4F94BC46104DA92
      91366C7E76830FEF87CDB6F721CDC8B158A051FF55965EE5C8AF6CCF8AEF5EF7
      9B75DBDC6E2C1083212F01F424697A3157D98511F4A602E125B39C7DD7DDDA1A
      DA10B5726F6D7B989C7DED2CF57C155C346AA295124190313B00B40FC707BBC0
      52496D003749AFDADEB334795691908D9AC9EDFAF60D5F17CA46D1DA407173EE
      0FFB530D7380CC046C4582422C13D825A4CD1292F4A49F84AB259F011051CAF0
      E94A2D8419D848D09B749939A4833862A697861124B95684E3DBDD2B66161B1F
      4EBF3F6E73ACB0CDB8A66D89882ED4E2265BE67C4ADBDE1B5DEC81386857C892
      0D91032D892B817EAB2E0FB917C3DB00CBE905EB94BFA4C955386EE4DE4B6539
      4F75C3CED56CE626868EDC8350521CFC78F0C6DB389BA5BE9A6D7A88E6E04F6F
      B7BCD373CD40E9CFC0A7E4695A130142DAF901A98A02F89CA664CA746B18E2BC
      1BEBB44A310CC361D0C72A9D1ACD59A9815DA93F1FBFD9A5E9F8362A9B7AC77B
      AFE9E030F8B858790D04C4457A0CE9A52A25DDBB83DD5E6526B4F2EFB6777EA0
      2BCF0111D422356C0AC890BD7A77BAEB181353578AE7A7E10D5381E58E6190DE
      F9D64B1A77967816C79ADECA09C99DBD8303BE0FACFD84621E54DEB0A239FE1F
      351231F064F0C200559BAC2B0FBFAAD08F5E9F9C56E4ACB7C106F4B3939873E1
      C6927966943DABFD28DA7CCA6F7C2EBFF1D4A1B592DF987ED5FC86CE1706D3D7
      1085A09A0B8483C264A7F379A3B6CBC4F4FBA397209DC80B059264324FA399C1
      EF2323E62CD379CE75CD8184F5E1EBCE52D8EB968EAF594EAF9DD4F8A5611694
      CE2EA7D948258068A300C22C8CDCDCDB3F3D44F74168289D6BBDB589666A53C3
      68DFA8894ACD3F8A3F58964E50D59DB1B2CEFFBA44A6DECF684375717BC2260F
      7516B3DF25810B7CCE02DF308E5D4E56EC96DEF27EFA3FEFE2E2A448173F376A
      F6ECF3EEFA3347ED5D03E194E49A7076E68C5118A4CB59581230DFB0E9C33666
      6A780004A7B0593794CD4887A8683A519823E6AA748C0D3C2826100AE07EB3DC
      2D742B8A54C4A9B42211E4B92A280070276CEA1CC297502F1B6AB9ADAB1B8AC3
      B1106AD7F2031C1AB6ECC31CB06BD4B4EF0957B5BDF7FB9CABCED2D94AEC6A3B
      CF715DE72AA1639BB5EDEFBE8D53F1996F5AA0CA388E226BFFBCF3FF1D7B1B3A
      B169FC5F90A170D1FCFFD8AC3B1870959A3B977787FB274D6CAF76519A394718
      523F4FB93C104D27B38A9E7BE91D1EEDBE6AD3BF27BB6DEFF59B37DBFCEF09FE
      3D3D69E2942C2BFCC10EF96A55670175D23AAC68AAF7273FBC335655236F8393
      CDA6049B1309B44F97A00E8F1512233C298F34164400E45D23272246460565C4
      52A87070A0B9B7E3D9AEB80ACF0C61CEB9E6E2D28AAA7CF6BCD71D8C0793FE68
      30D9EAE07FCFA0598502DC7152C32137B5B6F22044B0C858FEF3CEC187F2AE35
      2C9FBA12C76DC11BFFF85120FC3D1F7DA179CB964EAD866F9B1DB93533AB3204
      D958ABD481E132358FF7D5840CAD7CAB5875553147C78DD1281AD7386A862FB2
      E0DD9BE3E38A1AA77FB2E5C261C0ABE2FC2C03A68F6082ABCBA6794DB5B9DC21
      D70EDFECBDE65304E3442EFE9F0F8E76AA77BDA9B369BD175E619B41FBF3C9DE
      6E8BC456D638D7B56CCF90914B32ACBE116FDFEDFCBFF61DA999275EA3CF4605
      9F6038EA51C1FEDD7BF77B45050D5A1379AA2FDED2561C6AA60981F76AF28FCB
      84CEF796F73EB754E0647EE00AACAF29DEDD5458244CDD2172010A95D0595CB9
      0ECDD8EA130D58229E5BA6FFBA8C33E07B488D33F7DB86DC364222296CD6B865
      8B142D31B2B8F775D3620F80511BDDB866AB6770476229E0E6240E76B25153E3
      A0C176E5FCA0BC89E48596021929CB6AD6905BFFB99C2F18E63575968528DF67
      B92D935FA48BE582DBC49A35F6BD0401B8172610C7C010640549B5BFA9566CD6
      800FD23339BE48BA5DEAEC2A8B694C09B28EFDC357CD1AEBFADA4FD7BB743680
      C05C9077ADAF036D398432049A90FD85E3769EA5CBB37392AFF8C33B9BC5A03B
      70AEE08273D16C5EA8F982793EE7EC1BFA1A15C5D172C684A0889D7B7433A4AF
      920D9466AD85EDDFA3B75EE45663542049A457069876882F9410F15BDE3BE3F0
      D1FF930F8FCA4D4E0D70F4BB79735C4D2D7FA266C7107001A9E9F4505A89104D
      BD3178379BBFA7E9F82B8CC55F696E9CD898F3CB46EDE5D7B702BF2E95F7DB2A
      0110CC8D665DB5B7F714D76E948C55993E5B82CD4D5F83F58AA153369B37896A
      7665E3F440F964F584F08DDADEE90E0AB60F68A0AFD2EB860DFDC41C0D5338A0
      024076902AE30884ED4C930C10778B7CF79A25378C397112481C92E1AAE977A3
      0050E2DDB0491E9B9C457E9314EADA3BA78B38C365843B94B91274639A3E0E69
      0D3CEFFC4952D725F5D72522FE519167CD4C19F12F681D2B4CE315429D8CFDD7
      AC4B75B4E4566889EB377FB8FB12EBA3CD68D33F23FC33C53F136F03FF5CA9DC
      6BA12E830BD031A7D623B1DB0EE33C7812047541F07599EBD6D776D0E0364FC3
      388AD118C56827F3852A623F9EC5E45BB176F653FA6757D30C62EFCF7BEC6FFD
      79AF6F217998F7344F9719BAC85005D3ACEB28912F7014BFC5409DD798A7DE32
      C9C59D165474364D0CC842C9836BA2970D9BD5AB9B426F63D4DE4C2767B43D64
      C566F07A39A93B1A787E5CE44F9984CF65127AD3A74C425D207D5DBA34DE20BA
      8225C1B87F43E2299EAB84A60B2C02C64DF918CD42D8D0FFF3F15FF1238A1EBC
      070717FCFEBFDFED1D1FECBFFDC16B9D17C5227FF9E2851BC956A82F6395A0A5
      7F8B04E60BFAEF8B539D0F31A8E7FB3481FCF960349EF6C693E9A8E5FD0DE39E
      85593E2BFEDEF55ACE3E0651EFF372FC578DF06F74EE72B2A4E4E0E127ECB9BE
      A603CAB1E89B7167F2314AD3C2FC1890EB798D1F741226E73AD3FC697C04A971
      9C567E9A9CB560F6318F8AC4FFCB83EBAE06DD5B5BB68122F83801B88DB27D1E
      A10E521CE48D6353E5BA7D7CB8DDF6DEFE78B28FD2B5DD5E1B6D65470D7364CD
      84F62E69CB0DA19E74F77B67A8D844D8787F57F2D9C80ACDE25FF00E296E6DE2
      445EDF570EC19D80366C2550B30E1CBD51133165FF9D81F792668362E3147DE0
      683124B3058D198CB690CFBD0DFC70769EE6C526670D5C2EA0699ED2FA9A4C6A
      32A139ED0A0624874960563A8A43DAAAD9724EB6665C003D84EC331A3600E885
      16317735E1DE46B8E43CB2F2CE95F42A669A1409E31BF8CBB34DB46ED2FB6360
      46C20313F74BB087152A359AB53C66C7BB535A1DDB7A7DCE290D158638ACB462
      79EEFDF9E0F8C095D01BC47520E270999FC90C60E669AEE5BD0C904F0A80F46B
      C6BD3B497C9620172F6DAAB6706BFFF4B099EBD1A1F5E040670596821B0618AE
      22373C0524ADE2D0344DE45BDEF62C4FDB6C5FB4563FDB820B832E3D1103CD9A
      F45125FD67708E1134C536734B31299A02A5F47C86A576C2D724846117376B26
      E6AEF7CAD3BCA31664543A3C35532A9508E00A37F8684399671B7B42121970DE
      60C5D0A6EE6A13D1E74F33A01E1F6E64FF72809F03CB0447E37104589E1263F7
      38355F974BB49AF9404E9AF5B6B33938C202CCEA108BB4503959535E0BC8C62D
      EF42DF909E6A98D6460EAA824D63D1AA9A37C89A54FF5D83214FD996465DFFAF
      CB6AB983806AC686E9553C9BB1A6B67548DA83ED7E4D73E2A43499F5D0E499BC
      312ED0B57BA919CF3D5D5FA341DE983E435F9FC749C3E48231CF7A439867162A
      C6349A08AE36B7556B4345D9ACC15B57A4DBEBB27569E05C4DCF6D1A79C76454
      21E72498F30C72C44E055921C70E2ED6E1FBB1DF3F5337128E959A579866628D
      F3CB694256F95BC6BBE62797A0B37FDE3938B646787DE14C4B5CB396CE2E5CE7
      45B74B8EDCFA5A654170D66D5388A03F9A3A2E65AA66ABAB374BD38BE5C20B97
      1C6DE02AE0D09C226EF046133383412E934CCFE2E6291DEBA08CE908BD12CE02
      93F07F6F290EE063ED9AD24937F31C50748D9C098C75F140BC9681329130568B
      F66F66AD80C6B91AEE3677719BB77FAC36EBD48012B8239B6E1E7B1E9205DAF2
      4E249885AD32D48D6A664B9FF942E2EE9684DBE6BC6A0E9591FEC99B792A3B08
      B2FCC8E13CA05F98C510D104770ABFED9D1C7277D696F74A0517671C1E29D1CB
      67F13C367E18B3BED07F1D94845904AE046ED6F4DD59E88C593149D84F797F5D
      EABCB062D688751A6AA60411C35CDC28536768BC939E2392E5BEB6F43724873F
      7D541A58536B9762444BB1C7C150278F111A319D0CC008119802BE2008F626EA
      72CE306F5B6462D215788F9C2862DB0822C9F55A5F2B0C309AA7A308351A9774
      3BDC3541C04DC214D2D6DCAC85294F09CC9723639E6165E49CD8739083D6F0BF
      F84FDBA6CF19F5B736CA58D66B6F79BB722510686EDBD311733705501EE25F74
      582E8EC1CF9178077ADC9AB53A766D1079FB318D69A2A7370B6D2048C93E4204
      76B1D064446F798732D35C6E46ED0EFC73BB5E3F24B8283CE12707ACEE807D5D
      96E8D2B6EFD3F97DCF399E5BF1635184A8073152B06D2FA5D59409287101EE82
      001B9BA73B28468DC44570AE9D6F3BCD493D0012B3907C8383CAE6A1005CBA61
      193F7BC7D9E4337448C63E321533825963F0011429FE33902419CCEF90A9BCEC
      2CB13AFC7646CB249760E7077A87CE798572F669CF75FDC9B69CC8681EFE8D16
      4F62B9299C615A4753F2F73804CA53BDDC6D49D2047A9F6E1736420B2632B9AB
      725E5B927CF2D36B1214C1799A89E7EFA70590C7816A4962A259175E5DA631B0
      24C47007405800B809A4C9AD1543022CF5B8972AD4FEF20C2191DFB556F51B2D
      2A9B3C1595D56FEDD705AD5C5FFB003D5620F76F09FF449DC473B44FAAC4D03B
      68725DD06F42D79541BE2D2D87D80625530B13A4D25C620020BDD5D74BF60A4E
      0AADE6ECE6E4E7A981C9241340382E557EE1291F38BD3C0CA3EB48282CE78D84
      457A67A0B137A43EC6864C361D0231CC214964CD494D593F5A2C1FCCCFF654ED
      92E394267E9A25DEEEC14E13A7DA0266813179BCFDDDD65D55422660D4A8E19F
      62D826EBEDFAC7EF4C80F3542CAA60A3E6B06DCACC71FD24345E61C6A13F9AF8
      FBBF79934EA7590CAF9C22D01CC775FCA0413A635722092D7D83AD5D2211CA35
      DA8DE4F3595F6BD561AA1D2C81613F0D62580062DA1B6A8E83EDB7BBC21BC0D3
      A51FF6DD09DC10BAA33ACFD1E696779454882D0CD684B0AC5E4BFBA2F0B4C4BF
      3499FCC8B1ACDE897C095B8099674CD2F9C956FA9CAD347EB2956AB6D2E0EB42
      F9189DF8DEE4ECC258CD524E99808ED7909531285D776BD2A88D3B902A64FD22
      D4A620597BCB229A98E26504223295E4B3B22EDB548DB6A54BF786C5D77CAE93
      F535038D885A9D932213CEBDCC96ED001FC7846F8B143DD80672B151AB61608A
      48DC8A067DE142B520D2CBC1151F924D60D9659FC4D4E7C4D4E8494CD5C5D4D7
      C59AA870BBE32E930266732CF4368A2C5DFA2891E1D8E5AEBA4ACE9640E3D279
      C31C2DC7D1F4DAC1DC03317A7B67CF94044A6BA21F2F180399BD131352DD67FF
      B46CDBCC40F6B69AD316D470E3EF9269E2BA1AEE78A454DD97D93F71759B0898
      B36D2A4218159E468B1F2AC5880C2AC109E90ADC0259A4AB76D913F3CA6725DE
      F049E2D525DED7C56C30C282DC0F700A703502B887F6DFED9E58BE0491188DDA
      B51AE9DAEE1E28924C1DC5F6C1CEF7C272DCDAD5D26CCDF716117312DFAD6609
      EBAABEA920FCE70C7F9769E613315036F49E1EAE92B4F9D1BF4782B60BC16E65
      34C21D29B709223146A6B4272D834D9C7345E2722B2367F50D7BA59B18F69165
      2C9F4B7569174366D7D06941BB0204AFB22B8782BBFD8E5D9C0DCB4040D36591
      38D8E4EC273303DB0E1CE04B2665889029309355FFBF2133677839EBDACDE39C
      33E125915FB3062BC0CFF7F66D9EBCDB3B68223CFF3B6EE078EE3314431923CA
      6FC8B61226C89690124B57484BBA1837387B58A1FEAE1A2B20F001954291364B
      28B64C6F9ACCA15943DB267975F38BF60ED233191EA28B5946CEEEECA664E77C
      8031F7BE6CCC3C4245EF7663E659443D2FFDAC79D31D0CFE71FB863FFCA5064E
      3CBB9CDDEDD8F1637E9766A98B9B2C9E3B1ADA59FA10098B07DAA4237F165F22
      7C74BC4C50882E57F85D9622D707D2B8B32F47A8B867A168B2FF3042C5CB172F
      AEAEAEB6122424C937CC19F72135637E81BFBC187427A3FEEF0048F1F70CE76F
      7F235FF8097FE2C93BFA559B71284919433ECE6566A99746007A66CE08E80036
      F160B3B58E10CB6DC19417F5FB0A8D3BC856BDC8B4A287FB68C472C6200DA8ED
      9DE8BF32EE42DB33A1668E24B73D5D045BCDD2CBAF973320472F606C5CA0455C
      E24499678364EC7E9D3E85403E1702193C8540EA97FC6BA3D5AD64A7508CEB91
      0300FA2B3AEC3326598493600A77B68A6B2EF311825486094FC93F3F39618C1E
      76DFADC1DDA88DAE63D65CA2FD842B642B544A7450FFEBFDC9691387CD14DFC2
      25C6171EB80ECB0587087C0DB00A57305101F36CE244B639B6334FB9FC7BA6CF
      5470E31DBFDD3E34E1724440FE68CE9669D437AF08B30F423FF4EF21FEFDB0B7
      FDAECD312F522BFB278DAC83B2D8C5778FDE45497886F538C932C955A425AAB5
      B8299BC2ACFFCA903C10AF722F9BA52D41D5F4B3F73675ECB369E4EDEE6F1F18
      72FAC68D5548024436DCA65863621A7516A6B319C080E8015E90A91C55BD6073
      31A58C96EED9D94BBB073BCD9A29FAF4BC56D93ADF32E42E0029451BB131E40C
      430D871DA374064D1047A6B8133620CCBC66C976573F84B66FD2A437A5EAA2ED
      BB1E0D4CA8A859DBF13DADADB7737A7CC00625EB5831304DEF20506471F4A2D2
      F47C322F3F675EF69FCCCBBA79F975B1478D1A3CAC526F5AEC029C6D894C55E3
      88B4914CD499BF7C8A24AE6C6403228907100762CFE46D6F1F3295BCF88526CD
      D89CDDA2C1BDAC8FADED7D0F02DF772A2BE8E7D72A78A81AD8071AF1B10AF44B
      EF7B156734BCBD1BDDC045DD110C6F9D35684CC75A4A0F1B342494067A208B69
      D0987EB08E549ABCF4B6B3799A91FBA1D50291B6EDF93C6DE33A3FA9CDA6A94D
      38252FD891FAC0F1179DA1A001C6E1FBDD63B1C2A5431ACC3F96B19794679EAB
      33B11C433D5B5FD3D0B56FD5E5A1404D346A9F57624FB75CAF7CEBC908689E11
      B0BEF6EADDEE2993AED882CA1B3A81B6443C94C09A38CADC97C7C0B8E4802585
      1CCB38E20E96C29B29549292B1E76D94C556F234767FF0A087886C3C9C61414E
      471133673C838855C78CBFD364437DFDDBC7E51E684208777ACA60AED461D1CA
      79F1941A36E6BCE053737B13F885A60DD9C5279C1866148BE482C378BBF1258D
      BA48B366C5F09E74B0240CC8347FFD676F719E267A2E74F374E84CF643027FA6
      7AAA528DD82C2D7BBB2A3EAFD77DF1C891CAE1BBB521939B93009EB1900F0C56
      34938FD35BFF28EF2BE1DB8C006140C1622976080943D4BC47E0216F1AE3A34D
      AA08836D0E3E8FE73A11BC7B86A6021825FD0000C593BDFF92E8E806DA0300C4
      6518B16D9857C043154A1803DDCC893AF923357F5C17D7387C41A9A4DCF97EDB
      9620F2D9B3159582A571AE66A066A253269D73489BECC2B33FA4537683887B13
      E7B46BB91438056252226DB95A4AE8310C6052ED567211A9C910356B5A6FD30A
      45398FB985CB7101557C058021FC26A08E349156B3066FF31F5C4B4D63917E17
      B41D5688E339A0DC4496FBF53553EAFA3A9E31032ADDE71D937992A24C00E032
      2F37ED8304C6659F22F9404E66297A3765DFB051CCCBEB1DFD803AEC42A66FDE
      2B0BD066A828698F123C0F0327C5DC28D7716171A7CE32356F0BCAC7AD2F337E
      2ABE4B678D83DB358B59E9D01768D9B099F7EF44D0D38CABCF46642D62F082EB
      BCB1F7FF6F969E71C5C67291322876C39838C42299C7C0E746B71E1F4A3EB4A4
      699F15C24F6C1292928BB49D7A5999EC73A78C9D4DE12871AC358220836773FE
      4C1ECEED8D5C134EEFE1EFE027E28BDADE625970B633A96643B3342D6C36544C
      40FB22ADAA0E96053F8D0D057AF886AD6ADDA217DB1E6DC78FF2932E8227B0A7
      CF67F17A4F59BCBA2BF495C936A47EFC444AFC9B2541404A5122C44AE25F67CD
      1AA3F4749095E133BC1D430BA1D510BB56000506F88B69D630F8FE63F277E73E
      C9BB459A1BDE011294085568D4F340FECD15E31937CF4C2AFBBFA5AEC26071B3
      CD77721E47C577BBFE6C67160717CD1AF74FDBB3D9CFDE87EC46835DF75C18E7
      903937A8691B7F5BBDD93DBED9AB231A7CD990D6D7FE754BE78B2DFE9A5B8FFE
      75426313A7DC588AE23233E940030FCB4FDB07073F7BAF0F4E4EB965D4C398A4
      D8A91E0C6DE2A8F776F7773DC5D0E079099AE542CD0D1BB28423AAB5FE7C3591
      903427655679AD849D51E6EC0038DDCAD2A2849E69E42C9FCF5EDAF406F8BFE7
      109EB0C5BC9CE6119C0B3C5BCA30A002DE559B6B0349BF2BBDCB703E6226CD33
      DB2641308EC754EAC45FA0989C6BC9D90731F5851A2887911369985AC326CA51
      1BC9901FA6E10F6495EE1F1EEDDAB094456B849B78A932860429F92F9A389577
      07BBBD7A8BFD2DFA1B16D6649DD0696DDE0C240B2E0C0192E0A9E26433F15304
      FE8DC6B18DFE64FD401B7B4FAF5041731E2FEC61924E0B5A7C54F83776F02749
      7A75E35D69C5705DD5D2E8F8BA9ACADACE8AF3799A664F3EEE677DDCEEF4C9C7
      ADFBB85F97512E2E6BC8578B5070B2C5AFE46403E71A807D6552FC4F47FD7347
      FD09E86DE5A87F5DEE8ED7E0535A166F7FE4438C968EB9CA2E0C0995C53F8B23
      2F5C2EC89BE0D4AFF4EDD02DB804A10E908FB9A27B7DAD511B2B9463DC9B237E
      3FD8EFB89BA2F0001E6238941A893CDD42C317E48F3414E72D87137A9E2E6761
      C562135620DE205DA87826ACEE02800E6F8A33F74F42E97342E9098B6D45287D
      5D1A90902126BD003139746D298B536EF230B6AE950FBBD05E9EA7420CCA3D54
      7F59CE494015EB6BA9A43E1B0863744B3C05961275A1B30B2B9C50DA008B632F
      416EEB5D1A27CD82301337EC84DD308665614758FEFA9DF9FB3BCC674FE6C3AC
      66A80C008A97F2182D3304AB178773400D618BF91C50131E883D77ED895C94D3
      306583BA8DDA8145215446F6E14DB5AD52B3E8BEF2D285862189F00707BC3C75
      46836ED484D6D7E480C6C973C6DEB3230573A1E5D40BE06B0BEB6E0A74FBC29E
      0144B7D83A88216D311594859D21E7AC02F4755D095D8896D71240F3CD40F429
      08F80D83583C64D456294BE7A9C91F8E0D842B14AC149F9A581040723F4801FE
      4B0B7DADAF69C9624041AB59DBFA0FBC0A017DF2092CF5530ABAB735DC7AEAE4
      5CD1CF5F97F007F1AB1C0C753A2BEEC20E0CE8EFC806DE8E843E1DF1FB8E78F7
      E988D78EF8F0EBF234ACAF81609C0EFA4B2F9AA5C2CFBC80FDC5CA4E65712E2C
      07D0E733D4CCB5A2E52FBFDCB4C0C7081E4505C2A01CA91CDC0314ACAE3C8626
      EBEB4C1E601E09E734F796EB6B89FEEB52CD189986D464BA3C636D79E3D95245
      6306335FB44DBFAB2058664050A1DF8D39B231F0FC9B426FAE7EB5304A6E79AF
      A4B889EBF100688E2E9C40AAB7B9AA893F968B096D3C4F906F9AD1C9A02552C0
      7F79BAE39FBBE39DFFF84A4B747793D8DFBB44FD51FD32B905A215E105FAEC9D
      6A1D6B39F7C6A19334E1D6D656EB775C98AF4738BABE86CE69D8BC8C8A6752BB
      D2DE163307787C2629DF22D39ABDDBE7FFEEDDB76666C9EE7C592EB5848FD8AF
      B22F9274B04043BE461089F9F68C9F2CBD0D42400B06BA1B4EA7657158613FE0
      4EBE39160FC220309DE0A1E393C533365125CCBFB1D8E2A60A4F7E137E178E2A
      B218B2B360A98952CC5C47CB992D31662F624E7B19833D8B4CED2552CB204237
      85E5A41C13A69211F3DCD2FE2D8B65A6DB0C26AD6634962B4341A86657EA2687
      0B7389492913BA74AC851B7AEB6CCB9332FCD747FD7702A74492F2C6F0F1E285
      84DE887599A9C582DF6896D6A4B4CB8E4633DEB667BB45E6EA026E42662AB213
      C7BF46AE223F1E1E02B6C8166F541F0F97195F41CF585FF3C42B13E2399A43A5
      8363B574C7BFEFD8FA35D4D1CF5FDF0FDBC76FF7DFBE79F9C0B541341917FBC0
      FA554EAAE232E59C97411653CE35AFA329663F136A63D64682700F1F4D6ACC69
      592FE4180B91A23C82D77E0935C75491E6AF8877B363E7E83FF8F0E1D3A12687
      3D54AB3B9A68817A3C3774CB73BE682873E0EB0076BDA33ECB7EFA3E9C597A17
      F980721AE4663A06BEBC7E6378F84ACAE42D440A2978BA81D0ECAE36709BCE76
      BBCEBB8953C241792C483CB338F10CCA395319A441187291BFBA22EDDD6264F2
      CA92D1EBA6141AEC4CCB057E1ABC7925272D5B0A14FB3241A25A79A3814FB3B3
      5F4D1BF6812BBA9EACFDCF5802FDAD8EB7F7E7777BC7FB877B6F4FB70F9E4CFF
      BAE9FF75B98FD6D7E4A218B50A7B1AF129D437487FC5ADAC70DBD8FA86BA610E
      A1314F0D4F684DE71A7E75601B8524EB4511D2956DC9AF01771F1941D4E26BA9
      70BF6EB8C885DE1D400A91D1BD0C6C77D222452F7D8CE6435275DA14E85E6AC7
      81DBDA61E87BC451F7B8B3ACE5087D9A5563B2BE961AF5CDC1C5A42257E89257
      51219CAE9DA77961F1A20CC58771C0E65A25C67581BC65E1966B6DF95C73E0FD
      9374AB6639DD9BC33844BFC9FA1ABF74C3FD20B99E45DE066A9CB17789573675
      E4F3B6B7735236C672F59B71976C10D8B7A214B3207B629F6B4A1D8E235E90BE
      4011E6767F4C13BBC0265A65C2F2FC79920AEA274D00B761AE4573F173D9E4A9
      3E1C7709EB956B335B69D6CDC5D623FD4A8B73A1F542561FCFCD37E9BB4933BB
      6F471751E5EBCF639CFEEA00F8FB4F6BA337BC2D12EA7ECE6F7FF7E678570C54
      ADB21930932D8156A38E221A09DC342CEC661CB27111CF1F0C67E8E106FC6A79
      86F22B0ECF8B236F32C6C1791A07B61CD3D7D23E6B0112C4F668D4444EE9A8BC
      4FA4E38EE59F69982DB7C35C65F126DECD141D533A46DB3BDF1F7B3F75F87FDD
      C1CF38967BD2D5F54EB17428CDA013FAAC79ED841B1868D58E162C37B999413E
      602C23FAA22DEF4D2C9118E3C270922273C978F47E73212BDD0659E192FAB21A
      3B71891329B3149391F7C5B68F5DA5D98C3EC4719F382A633E0BDC11C14CA9D0
      3763753889B4BE66FAD5A51F83736B4EF0D0A33851115A7D608DE6A609FF2FDC
      79166E089AB9E5E4127D2868297D672D6117A92DB26F165F48935E4B4078BD67
      FB557D2B199D67E44A43BB94FAD10BD3A6155E9FBA54288F4F2E399603753C57
      792D75CE01453A1C74388BECC6380AB2886468418C059C773320067C56CD5B43
      6DFE887565EF49CE5B304395BAB8B9FCD574D6E4A4569A86CF5528078FBB89CB
      5E892777E06E77A0F794DF5AF500BE36DBC51B44154E6C2FF1C69BC393D34DB9
      3AB86BDCBCEE84799ECE2E99EA0C3D10A9B42C830AB8CD5134D1B1CD1222DB26
      516F34C2B13E1373CD216D7001ACCC8FBD1C715294F71A1901F9F0D3A5FEDCA5
      FE5DA3FD5F33A87D5A0D40998830B795CCD55F0C6FA1D5A86A16173726305B71
      B07D365F919332751671BECA1A1E3EE9914F1FB9EED653A7FC8A16F9BA742A02
      2462C3DA519CC1094700B8CCA59282201B8C8D5C36411BB57FE5F895D783AF51
      1F3B577FA919876040BFA600D9DDA809C08B776DB0A85D3F4BB31BAFF57D1C92
      F10FFFF7300DBD37A8666F592A0795606A8258C3DABC511362EC574BA341E3B7
      96864752F62D2C16396808409DE9A2E2E8E36F89244AE89829EEB92CC97D1A35
      47874FB6C0D514BA90778A7CF73759DCB032FD6D5A434ED7B59609F0AE92960D
      2FC255E2F081945A989257A4938CE1C868A68D9ACCC9AA53B9015AB7F535A19D
      8839EB652C44F298F38B78D14630D17483B4BDADAD4D53D51B5473DC1C76699D
      3867B2D576BFBD4D132D31EED63E82BD85E7C6D06AD4D228A632C6C496928696
      B24FDB08632B94D3288A0304E24D3773A3E62001C29715A514B020BFCA526414
      2D4817993D65AA9FEB531D64ADB8F971868BA95187EE42CDCA1E8C0D2E1B9075
      D9E49D35A1746314CAE1E0E7356A71C86AD0195AB78B2BAD2ECAEC82469A36CE
      E7463B488EBE02AD10CCF027174E6FD49CD6D7585B446EBFE35B398796636594
      6819B3B66512DE6E791B74EC73EFAF4B444595E74BA5992AC9CA4990055A0019
      61196C6E79DB0C81CA512697860EE9921B722A1A15E26FE6CB42EFD54DAB4611
      670349151E615B3B5F36AB67E5E7010DED72FB8DECB83F2C8504C2B86AB19821
      D164D0A0258B6E6B6583380B9673985141D3628EAB3145EEC8C9D22B1B3F60F3
      DACB5151E3EA963856824607C0D1735500BD757D4DA2E1577959FDCFE58B36A8
      2060485CF023F818733D4FB7BC93D495D040936A95C7EC19AAB0A4F0CE3C3F4D
      2F9A75079119B841B9E699B7FFEC927B59CE520E912A1F92F68F4F95FF9FF668
      9F8AA2573CDAAF0B835D8F8A42A4492B4B58A96BA00BDAA83D7B6D7339DC7B06
      9BE41DD2D55C1EB19326A169EB67845AD221214F46DA991AE6CE3A6F35F736D8
      061521C2D273063AD06661C697D1F34AD1C66DBF410C944DDE00A99D7B21BDCF
      5C41A7BCAD42E703A81487ECC955AA2E9D9BE34C2E14EAEB84819659187393A8
      2D696A378C956EB1A590345CA8DCC4EC4D179B03666AD652BEB3465BC655838C
      D95DEDBBC1BA499CA65C1B83225DC66BCEC8127B5237E63BFE9BCC891F604B40
      EFF06FDB74FE760151FD4882F6346798246C44E1F45F9DA774748C1A46E46C37
      257B94ECF02D123A5A157FF0BE27730EFC9337A66EB65E61750FE037F481B566
      4D5DAD94835F97D544EA56CDF2AF43327CBE8FADC554F6E7BCA50F5FB1BCB035
      576DD741C39D400622F09CCD5DEDB57892A61BD4A13840C82C9373A9408F68A9
      CF25227964704BF1BA555B5F544BABBA6482E4B3DE704AFFC27A7EB87378EBDC
      F5BBC3CEB8BE7066B9C6BDE974DA9F5896265AF47FFD881A17CDECB1C3CEC0EF
      F43B83EEA0D3E98CE8FF2752ACD3A35BA4A7A1EE447E1445A68027E8F4F8BF7D
      F97DE80FFAA368A4C783D110FF0EA3E1603C1D7746C3717F18F6F478320A4781
      0AA6DDC01FE8A0DFEF743BF4A6F160120593BE1EF6C201298869E0F7E8CB27BD
      A19E4E7AC178A283B1EA8D83A0134CA6D3DEA03B0AA6E1C4EFA9F1704883190F
      82B0371C0C7A6AD2EB7447A3A01784D37E3F1A4F75DFD7FD71CF0FBB5167EC0F
      83FE74320DD478A05414F506BD1E7D8DF6BBFE603C0CD5308CFAE341144E55B8
      BE361C4DA6936E577527FD60D455C34E349D44035FF9DA0F7A93FE78329E7406
      F4B0A91AF6D470ECEB11CD91C6E1F7FAE1444F3BE35E379A76D420EC45AA3FE9
      F402BF3F1C8F7AA349270A69397510D2D0BB61D09D689F9ED2ED4F743F980EFA
      E1580F3B7D7FB4BEE677BAE170D20FB5D6C3684ACB30D0BD69C7A731F4A3FE68
      A0553050837E6732E9FBFDA033A585D3819A44D301AD4D774473A35FFD696F1C
      0D7B5A0D7AF42DAA1B84C369402B154DBB53BFA327433D1AD2B674FB43350975
      AF13F53AFE24E8F682BEDF595FC3620FA3201A91D1DAA52FD0233FEAFB533D99
      D2F0FD70349C8E023F0869BE7E6FA2C7417F34D44140C3E846517730EA44C37E
      A427DD7ED80F021A863F8EE4AC44383D745E3E75CE6837680DD4981E2B7FEC90
      EDDEE51F7C73D2A2718FCE5830EEF7223A57E6E7090E523452385934FEB18E26
      433FA465EC8E435A6F9A59974E15ED44A486D3CEA08FED1987B421DDDE641C8D
      26BD5ED70FE94468FA7710ADAF05B4AD1DE5FBB4CEB4DC3A8AC66ADA0F23ADF4
      C48FA6BA3B1D68ACCE68AA94EA8C82BEEE0DE8E005FE68A2BBE3513FA4C319D1
      099E4E866AA0C6BD6187864387A73319D1F7D277F838C0C1B01376559F9629EC
      77BBBE1A0E26FEA8DF990EBB3DDA85683209A703BCABA7F4A0371A845DDAE14E
      D8A3010D43BF3F18F57A8371A4C6D3EEB83B8CC2319DBC0986A669CDE866F4A3
      617744176BDC1FD354F4245293601A45746A688D8260AA0751D0A5CF47BD400F
      07B42923BA32D3C12018D14B231A81EAD2BD8A747FD8F7433AD393D150A970D0
      D561C71FFA74E2C25114CADE7CC9CE8EFCF1743AEA8E2646624C949324FC3F92
      1CF40D242586BD487E5E5FABFE869F07213D40D3FF8F49AEF4AC54A1C90483B0
      437BDF8354A13D1D878AB4C0B443D28036C3A7633A188EE8D207BED2BE1FD1C8
      06FD69D055832EC9175AD16944E79A6EA0EE4FFAFD71A0433AC77465FCF5359A
      0FFD401B1974C69D70A2464312397A32C1A11E93BC5163DAB749A806936E401B
      158C024DCFECD205D3D3F1A44B2BEE0F2674D1C26830A563D91FD2D84854D019
      A49311FAC330EC75C2913F245135EC7535ED45180E35DDDF011D1412753482F1
      70AC27B49B24BCE994D18B3411DAD04EAF3FF97BD67FA0BBD1A0138EF964E325
      BFCB3BD01DDDB7FEF2F3FA5AF95BBF6BD75C072451A2096ECBA83BF0350E523F
      EA4CC290849BEF8FF480BECDF783A03B1D697AFFD4A7990E82C1400FD4448FE8
      0E8C68CFC6231265743BC72459694E035C955ED0A5FF867D7A7B9F246218D139
      A07B42B78CBE9CEE7044CBE5D365184D87FD802E63D8A1CFF687D32909F4601C
      86A4027A24EB7A74FBBA4392AE3AA2674C4986852455A2201C4CA66315854127
      52D3F17032A03DA745A3D33D9D8E7BBA3FA52B3C54741DBBFEB43FA29DA50946
      B88D634557588D48E174033A4DFDC160389D0CA6384D3D92B6349C30EC44FDC8
      9F4C82F1683C213DD11F0513DAEF292474478DBAE1B8D3D7A1DF23393DA56FE8
      04AA4FEBD49BD2F27526919E92B8A1C1D0A1EC69DD1F4DC7DD2EBD6344CBDAA5
      7310F646BD90FEA65430EC76488F92AC20A93598F420B7A62436BAB85E7EAF43
      479424176D0A69B78EC263E8A60F021265C1681C6AD26E23BF4BAB490A44F748
      850C06A40E2763BA0FA4C569E0FDD1289C4E46A47627BA4362ACAFFD718F74E3
      44757B1D3D8EFA031D0E47433A4A3AD03DE8A95E2F24D53E210D1946A39E22C1
      3B1D8E8388E415A97A529B117D1D9D1788CD88C4ED9464A2A68B380D87642C90
      9AA315A44F0674D4699BC2912251A122CCA9D31F74151D0835ECF7C835F25510
      D1B5998EC7FDBE220B84CE4BD45574A4E9204DC982A03BD6EFF991EE61458221
      E9AC683282CA9E0E68CB7DFA2BA9051D44E331ED2129AE814F82594563325D3A
      74B1C85CA0D9D04EE0F80443325DE896938E241532A6959D9285427F2051D89B
      4CA61D0D0532D1C3B10AA34940F7578FA69DCE14F27D40FB1FF4E9E324E7E950
      D1524E86931E69A7091D277F40CA6844078C8EF688F68B044830D674F9E9120E
      A6B414A4F07B64E444239C221204C34E30EC6B451AA03B595FEBF66924116D27
      2DAC4FD76BA286B033B029533DED4F49154CE8F1D1704C27AA472B4EE29B741F
      49EB49AF3B26E180634D77AD1BD12AD1228D20F0E914D3183AD88F5E67140D75
      442B47328C9640FB9A34CF8476633026D517ACAFF503A86752BEA4FCC3011D66
      925F13B2D3D474A4A22129141A7BA4E9B229358DE89844740749B446F4615241
      03B20CA340D34D19D361097D7C64AA265D12B4BD21F4243D340A753089BAF425
      FC5B9FEC20FA871417298B21DD05BA3CA477C914A58B403BD31B86011D82902E
      48174620AD5467321ED0BA9304A631872499492FD03927F38E74272DC280746D
      109039D021A53EA4B78D7C4CB4D31D7461B5D27126D54A32B3435611A96418A4
      210D8BECAE8884159D834940F650D02543939E4D428504E82420413F9AF813B2
      387CDA6E32B2682C64DE4DE860D3F049E17687A425C270406B4766EF804C82A8
      479787A418C9A80E99C653122AC3205264048E48FAC0829B68321F278A1E14F4
      483175C9160B06240F267E87EC527F42D2794C0AA6D75164E5F6C81A0A7AA459
      E83D23FA0C6D27A97A1A5D4073574345D6413825D1439BDF231BBC4B430B489E
      7649EE4D48530EBBD33EF4929A9072190F7A831042744277900CD83E9D8F8064
      354D22EC4F4926C2CC2509D19B28FA2E12A8633C7810F4C8682105497FA58BA8
      3A53DA0ADA753AF374BAC6B44AD33E8D6D40F65B7F4247ADA72044E9D0917C23
      438BCCDF21B9717D45179EB448D8D1F44E9A3309AD1E492CB24049DD91A94C8A
      9AEC836E0487810C278DFBCCC71D57872C19FA7F3AEF3466521024F242B2063A
      63B24EC34148E30C273DBA998369A4340C930149A7E190BC039F542559B17432
      FA64236A056936226147D61C096A32DFC80C9F76BA9A9E47AE2EDD055AA1AE22
      BDECD32691ED48D2917E24194C122E22014CB26C48C76130A45B39C05523DD40
      7726D474E2835114F4156DA34FE75CF7FA24B222D237743A68D83478BAA5A13F
      1AFA7DBA1B24F2B4A60BD31B8574B522781E3834118D40EB0EFD467633096791
      BE24BB4940EB214D82D421E9AC681A915D44031A07F4EC2E099B9E4FCFA3BB33
      50A331ED598774DE94CC752804320A4974757CDD5163721EFAA32E59EF21793E
      746E4878D16DA3E746BD6E9F2E40673C2289447BE793B4A6733C253543BB4BD7
      B68F77D25B4914D140E989A3885C60BA3A8ABE8D5C21DABF50E9E9882438E9DE
      297974243EC8F18AC8F9F1A1B5496090C1451790D4239DDBA10FA7694CA6C9B4
      4793232B946ECAB83320FD4D9A29F4A764FBD0E2F4E9020D3A01AC27BA4C2463
      C942263542D2893C19BAF1A49748C8D351EC90D9402B4FDFEED3890D876413E1
      A892C82501435E16BC49B84E64C98CC9B99C9225D72599AF86346F9AC7141AC9
      0F83802CF340C36B2353870C9ED1A83352E47E77600690E01EC228259B887432
      E95012008A743BDDF7619F4CF421DD4FBA9074FCC92AA22193A131A203381874
      46649D0E49EF90174AC6F624A48D23BF91FE3A24C544629E5439A953BA6BA4C9
      E931FD218D20222F968C637A27797613455612CD90568A168F864FA6002D88F2
      696CF81489C111D95063FA3A3A9024EB49136845DBD925A5006F604CB72A2031
      3D18D165D5A3289A44A46FC8CDA5DF489F924743AB4BABD79BF61519E221FC46
      3A15641B052C90C9D8A15526379164E6804C5585BBD91BE2F60413BA4823B20D
      FAB455A46F34B940B437F4921ED19D22438EE4D2701CF61584243976E4E18C71
      6CD4941E3B213502EB7A4CF6381D4792B76372DEC7B0316817E0D192A88106A4
      DBDF238759D198486BF4BB037AAE26FBA33725B13A226385143809633272E87A
      93734606E584F68A96781AF5C601393F03D2CBDDEE34ECD0A2C3D525754663C1
      9CF590F42C8994E9F0FF6FEFEA9ADDB68DE87B66FC1FEE63FBD01912044071F2
      14DBF13853DB4963B77DE90BBFE4AB5A57BC9574D3DCE9F8BFF72C4851024940
      58F8F6239330633BA27641ECE2ECE22C2882351C05AA01772775821E208B8802
      7414C39C2A994954F2A8B13144181770325D97C4D15093358873703D208DAA73
      A4FC065312F95DA2B4439D5164196A810AF35D29002D5427485248EE559A80B0
      608E5748450DC6A1CA111AB442019749546D0DB1970469B958A33252C876E819
      724A9956A856C11B283F24552DC095A4A84002315B35790EBA8CE48C9A171907
      4356D0120EB1952A47824C015FCC349867CCCA082A12F81F95142A421887B144
      47D66438F1445C121308EA4ADDACC05D512D494883DF0890068C80962868D31A
      EE410E044B0687C873E40F9CD0187BD09B1A55AA027E519261E2C7B820CA31BF
      B6D44DF0381421695ED4C6FEA6C27C440B5BF04143535C03242209D7C8E62809
      90258058F4B44E13D43B55B286E1A2C8919BB3964A40625198DD9A16010CCA41
      B1869A17E448179806811DC41F185BD52A9489A0ADB4E840EE2E08DA2DB23786
      0DB513050DEA9E46520F800318A8313160C4CA35C6028402B4072C0D4918CE2F
      9AB254EB16A9272BD1728EF8A2BA1A2842810F97635628C19934791863A49038
      2AE4A51C218A321EE790648061A001F6D324035802501A69B60691020746DD08
      5E8319167AA03C9896D003F830B45A4C90B48AA4A0DEF6557AD5579A22F7578B
      E7D519CC8D572B777BFDC6D4F0C44A1018886891D372C95A23835425553CC053
      B35A4108A14385522B3314865420A12C4E518B342813A9A259815E2195211FB4
      4501725B15393860017286A06A5A2426C432D080D90802E0F6056A0CCC532BB0
      4E704014E2980156455364980A2AB8668504A0915FDB2605852950F08A95A482
      4CA2F4C1D532D0F01C412730A1828283A38095CB353812020A05660936854A47
      0A516625683C6AB7AAC1E4854204518BDC46CB72A0BBE0A940B1C600607EC72C
      92A2FB0A2505ADDAC00DE061AB42039F9826517F61804157914A4019294795B4
      FC5023CC40E64A8A7459A362518013100EDAD38F9C35FA98DB45438F63F2577C
      7DC7E56A30589A733DF85A1F6835D0B716B87464492F6323F18CB46BD7BCB64E
      B5742054842F2A2ED7509623E15AAFAEADDE2C1D9893C65E611416FAB5B4B273
      AD27D732C3624F10BE3EFF5CAEE986E70CD353959C3DA0FA3F6A5815ABEBA43C
      7DF5F9D95774B3A3EEB6DDFE50D32D8FBB616F205495EBA165E469BA529E21B5
      02BDA8A904F905E59F40558C00D6846A896F515AD2B70AD3BD44D599AD4802F5
      BE343DA6BF6B6A017E85545E10EAD116683D7867497716900690AB73940F54C5
      8053247D1F102B19BEA37A0E05402EF15F0286B516B448910D9E41CCA3385AE7
      A64F839ED6E443FA4E0EDF0ACA14A8B304CEE57D9F8D95207219A204A5E19AE4
      7541116A2C8446D65F19B40696934D12D4AA3F2775D59F3372629413A39C18E5
      CC39B44D7D36F7838636AC336719834E3A276652F396B2994C36939133193993
      5133193593D133196D6456F03879B4EAC7E9F4C97C8791D0B5B42526E720072C
      0C98A41F86EC8E87E3E3B63DFC6D7B680EC7CD5DF973966BFAB0EDEA4F6DD3B4
      EBC47CD5DE6DFA3B91A733FD4D4AFA1DF8E9CC3FFA1F889E3EDEEF37DD7E737C
      C4E7A2F8D7B9C9FE258C37171AE9CDA57C7273964D6EDE990D80BF764A1796F4
      6DDBFFD821FDFAD95776B77BAD73A7537707969B145F3F7183D95337289FDE68
      F5D47DD44FDD60FEF446AF9EBA8F45508327AD0D42ECE76004DB5A6120B575C2
      7068EBC8081D15655118606C9D3C42276CD06D9D22D0A2133A321B1EC7AEC630
      7F61036123EE6920FB7223C2D0E069202CCD781AD05F6E4418683C0D8421C8D3
      002F4DF413E3CD773BDAAC84195AEBAE3BEEBA63FF2B7BD655CB1DF4866D48B9
      BA940EDB3D4B853A0A9598C43124DFF85C9E29ABD5BA34BFC06275BF7FD97BB7
      BE596F3E3EECDB03D39076F753BBEDEEC76D1959D71E95F7EDF161CFEBF7888F
      F1899A58909C1BE0996E1EF0E8F700605DFABEFC18A5075EFB05069FB44D48F0
      0C1D21523E1C6F09779B9637CE7765BDEF78A8EC4A56749CF4DE6C0E5CEB48E5
      E6F9C376DBF25285D17BC71F46A3C7234146257412B4947824C8A8844D740BDE
      8B316AD08CB26DD08D3071D08CB0B41FEF184B07CD284B07DD084B074DE52E4E
      53BB96FDB0396E7989E5C5B6A387289976BDDF7CDC95B4CB358B91D86DBC1C5E
      364D0FC47CDC97F7B737AFBA1D2F889F77CDE3CD072E4B18B5E2A88D1919DA49
      7DB37BE0F9DAD28C41E1A8CBABA86CDDD0227E599B17756F8757A5BD3E13B365
      184FE0F5501DD9487E5F6E1F7A4EC034F06579E45DE90CA057665B9501465FDE
      041313EF8811BC1EE6599ECDE7EBF32E79D6E341701A73D1971DD4B989F839FD
      0F3F55BC7EA46DC836BB4F2CAD571DED86D836B6F622F085B0317CA40D1106DB
      9615EC84FFEDDDFD6D79D8F008DDE9D99A9BB7E53D4BF1077AFE8CEFC56FFF70
      472F073D4F1ABCB17BFDE1ED9B9B0FDD3D7158DACF8E3782A4FC9C1E7BBE8BD2
      1F8AE0DFFDB5AD7ECFBFF03760CEBBC7BB1883BF89A8C88CE28B0D339DF55A5D
      13A1F572DC843CC6C43FB68F5557EE1BFE757F40156582E3D84668BF2FE9095B
      BE1E3DC3FB4F04217BBDC068FFA5DC6FA8148B2D740F0FD5DFDB9A1779EFBABE
      A6E2E87CDF3F3AD9CFFBDC45624B9997E32D55DEECF2A1DF4E7943C31AB8E0B9
      A82A98D65ACA315D7E61B670095DA45DD6E579D9D6E54EA3B636AFA21974E92E
      35BD6327CAE4937294CD27E548A3BBEDC3DDEE10DB6FA31BD96DA31B05AF4197
      4BF96D6D1EE5EF7569BBB4285719C5183F19C5B8A135AA3160368AD1EEE1DD78
      BA500CBD23B9A0CABB09D52B0E1341A462CC5846AD985DA8C68C65C4EAD98562
      CC581AC5B8B134AA316399BD1C5EEE1D97C82ED463C6F5423D3609EF8EEDDD7D
      B72FF78F11D7FF76DB7E2C99957AAFF9C3BE5BD37663B4F7580CBF78A88E869A
      44F18B5E39C6E1A85AA2C699F498153ABD01A01B8AC3DE4AC78DC873365ABCC0
      45AD59B7B7DD9676291B2BCEE5C5A329E57D7F5FD6A75B0F27216DD7CD6FCCA6
      61EF6FCFF72846C174417024D1A39458903236D9B6EBCC927BDB369B87BBD375
      87A11965A54F56D8B26A49F622538F82DA293869315F12BC98C747C19553504C
      AD2F9CA299D5666E8FCECB72FF69EEF3DC1E9991CF2D8D622E9665E78D66CB82
      233E4300843ABFA6F594746ABF0B4B6785205039C4FDD87228F941E650F2A06D
      6ABB2B9E7F6C7FDA1C4EB7B7976F87CB89F9878B9B039E25341B647F7AE886F5
      8FE58BD8C3F81DE693DDA1BDD00A091CE7787B62C8E1594F3039343C31B5ACE1
      0A2E87B43FCA5CA6FB02CE71214FE4394C0F08411196CC1DE2D7027096E0C242
      50C4846078C27768040078664F0080051BC0820D60C102B08801F0D4F410000B
      3680051BC0190FC0190FC0591C80B31800676C00676C00CFEC090070C60670C6
      067018BD71488701786A7A0880333680333680250FC0920760190760190360C9
      06B0640378664F0080251BC0920D60C902B08C01F0D4F410004B3680251BC08A
      0760C503B08A03B08A01B0620358B1013CB32700C08A0D60C506B0620158C500
      786A7A0880151BC08A0D60CD03B0E60158C70158C70058B301ACD9009ED91300
      60CD06B0660358B300AC63003C353D04C09A0D60ED59BAB3FD30AC745A3F6A59
      AEF96DFB4E55FCA8E8F9014D962E5DF247EB57D9CB8A62F19A219AB6939E77DD
      27C62F35C7566C5C3EDF54DB4D67D6461EBFE409B5E9EAECF72FC69F945D8AC9
      D9EA2CFD12C82CE5DA45BA144E41BB18929953D0269D523A05A714422AA7A89D
      46A51D4E06AEA75B2B4878B6AC76C9A64BD2B94B7A62FECA2537B1BE70C94D8D
      574E9B94C91756B32A7509EB318A6D05E152C89715AEBA6D7991C7E33FD7DA93
      C7958E6BB87DBAAC70CDB50EAD001FBB6C0A71B7C3B850BF0BAEDF8301EC5A63
      09F0BB88F2BB88F6BB6083DC695CA8DF33AEDF33AEDF8333886B2D21D4EF59B4
      DFB368BF6771689F4D15D7FD2EB97E975CBFCB28B4CF123FC3EF32DAEF32CEEF
      8A8BF6695515E077C5F5BB8AF2BB8A46FBD4268EDF559CDF35D7EF9A8BF669F5
      10E0771DE5771DED771D8DF69971B6DF4D45144C022FA4BD73E8859C37855FC8
      7933C885DC4001BD89E3423C8C045E288491C0B9DB8248E0A5FF1C0A6E473A59
      A3DBA7412470E6DC2012B8E863876680B39DC685FADD4B0297FC1E0C6087C275
      AF4F8955A8DFBD24D0EB772F09F4FA5DC4A17DCAB702FCEE25814B7E0FCE200E
      4A16E8F5197564F8DD4B02BD7EF79240B7DF2517ED33D678DDEF5E12B8E4775E
      0A776831BC3EA38F0CBF7B49A0DBEF5E12B8E477C545FB8C355EF7BB97043AFD
      EE25815EBFAB68B4CF8C0BF5BB97042EF9DD4B0297FCAEB9689F12AB50BF7B49
      A0D7EF5E12E8F53BEF57DD6FA1C27F12EEFD1DBD8F2CEE41D3D7E5E1F658F2F6
      D8F8F36EDF1EBA2DBDE3F0D4617E77DF504F3F9B776CD1EBB50E477A2164929A
      5D2AE92D4B62D83F73D85B53D28B7ACC5E8E9910ADCA64AA566A251B592BDAEF
      32D5B2DF0533D3B423E5E2A1FB969BA45EA7699B946995A6659BBAF7E5EC8F8C
      DE3C8126D7ED7A6DF6E974ED299A4EFE9D7C41FAEB71BFD8F9E7F1FC7FF0A07D
      D07FBDC76FD6FF7A8F05EB9BE1DFF6BFDB93FFC5F1DBD8FF7A8FDFACF71F0A4C
      43AFFB3FB94C0CF1906021BAED3FE7389117D75842FC61F62857EE793FA975D9
      14AB5521D66943AF15D10A3D9549A133A1D256B9DA2D12913EFB2A4DD6559314
      EB4625A98B71FCBF1C4E0F441E6091BFB0E3293DF0CBB39E8EA7F24084F543ED
      713A3E7FFE37222BB1F9}
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
