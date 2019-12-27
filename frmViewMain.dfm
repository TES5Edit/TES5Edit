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
      object mniClipboardSeparator: TMenuItem
        Caption = '-'
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
      789CECBDF973E3C6B528FCBBABE67F4029EFD54889A421166EBE37B94FA3C59E
      2FB365A4B1EF7DA6EB154834494420C000A024C6E5FFFD3B4B37168A10C11989
      22C79D9487100934BA4F9F3EFBF25B2F4E8766CFF5C43070C391D9B09A3D374C
      7CFA67301D9956D3EACD067CC7B0D1E37F9334190FBDFE606C9BCD4693FF0C22
      FEB3C57F8EFDD29F7D9F9EC577D88D8EA9AE8702DED8E9A5633111D96FD95F8B
      BF0E92C66FBD6114A6693F808B460F86F57CA3378CA3891BF68683B11B272285
      EFA7F1BFACDF7A7FEE4DDD304A84D1B0E0FFAD86DD68361CF8CF822BE7F72B7F
      2212E3BDB8353EE1E3FFF13B0C6965434E224FC48B639AE531DB304E97C6C631
      1D18F3349AC5BE8871D4FFF8FDC57730A25D3149EBFE2401940D5830FCD786C9
      E2A0EDDF2FE7937E14D0DCCC7CBDA11F3C3CD0BDFFFDFEB31F8E3CF82FE1B19C
      8A6999766B39F416C6FCFDE33B18ECADFF19EF1BBA416AF45EBA66EF65B39158
      1F06B313F1BB5A7FD59B96EE12EE0EEF12EE9685107527FDD8778D776E3AA6A9
      DBED6CC0E4D64F9287071CD2D65834B41A30F061441ACBB1D7D8EF25FF83FD0E
      93287013B958C7A93FB765C35D8A51248CCF6F7872CD75F668D970FF476D128D
      17C020FF8C6280201CCBC73E3BB47CAF5F7883B9010C83778EFDC23BADF550C3
      5E8E1AC65B7F344EE59AFAC5F1AB0EF357501CD8153F54E3AF7556D6D895FC0D
      6BE1D457ED4AFECED6231D58B51FF9C8EDC7DF0FA75545B0ED0E8F6A2C3C669C
      9EF39355B3B1705F973F398F15E5E8566D4CCBAC78F88758886B7A73B3EA349B
      2DABE2E1AB59CC8F561ED376BBE2D1FD1F453F16B707FCBC55F97C15B8F64F62
      B7EF0F0EE4CA9B5587CAECB42A46780D78E70FF8FD958CAC6557BDFF275FA4A1
      0B5F0A5E43AB55C505D49E9B4681B1ABFD6EB52B1F931BBEF058B6D9AD6ED593
      6AB7CB4FE63BDD6E543F692D79526D73DBAC7C4EEE73F9B9D21EB72BA522B5C9
      0B0F9737B85DC964D50E971F2FEC6EDBA95EAEBDECCD8B5B6B763A0F930843D1
      33E36791A4F08695F24C67358128CA2C0A5BECCE6AF2507E6E1ECB07579386D2
      8339B6D8DDD584A1F428A10B2FB3BBFA58961E2DEC9ADD5D7D284BCFDEDB36C7
      ACE219452033B356D4D7AC920B8BF0958FE464D7EC563C55042E3F95C3D5B11A
      954F590B4FA913E85866D53319A555CF944E9F635549353989CD1E2C9F3CC7B2
      AB1E2D6C223F5AD83FC7AA12638BFB27DF786FEBDAB5A8298BCD39EBAC454BD5
      43F9F6B56B5152F95C61033BB5E8A87C2EDBC24E2D4A269F2A02B4538B8EC907
      CB20E57576569F07A53B6430EDAC3E10F93373B5C4D5E7217BA800CFEEEA0391
      3D961319A7BBFA4C648F950F4577F5A1C89FCC4E053DB9FA4C644F16F7B0BBFA
      50E46F5CB285DD559CE8FF2CB2A2FB5A5BD5102B65D3D22855FCA48E9C5A1CC8
      AC941D6BC8ACA5812A85C895F26B69984A96554396BDBFBA4A265643B25D1CAB
      52EDAA23E39646AA923EEACABBF714756B8529601D0969411FB73AB5B938A9DC
      0A5B4B635411A4FB6C5D8E91E16A7118BB92D2DCE3F33C4C8EA9A5612AC9CE3D
      C6CFC3283C2D0D524981EE49023CC8029696C6AAA44AF78403395611474B2335
      6BCB0A3C5201434BE354B1AAFBC2839CD17DFC2C1A5DEC2F267AA551BE90E82D
      0CE37C31C9BBB72EE7CB895E6998AF217A8B637D0DC9BBBFC0AF227AA591BE96
      E82DD8D99C2F4329C522F271BE1CA98AC354DB60EAF1D17CA02F44A97B0BABB6
      C9D443AAD2585FCF47F3B1BE1CA5EEAFF11190AA685A6D3D3A1FCD87AECF4733
      3C2D3D5F9F872AFC2C3EDEAECF3B4B5C331FA03ED7CCF1B134407D8E59C2C3D2
      18F539E5228FCCC7A8CF234B78571AA33E7FBC876F45E377FB6BF8623ECAD728
      03C5813A5F43C44A037D155FCC87F96A65A034DA5712B1D2585FCB17F391BE96
      84D142075110C5693FF88F5E2CBC466F04BB12367AFD60261AF7BFB29ACDE297
      F0E7435FF300F8D7922116BE5EB8B762888A17F210A6D5297E097F3EF475E33F
      5E7C875FE3DF4B0659F8BA51FE321F64E9D7D9205D4BFE0017F443D7AA05E706
      6EF69F314C62309E22A9B0AC1E4658F45CE952C3F88AEC0F0CC5907F340DF5E0
      D49D1AB0C27F05462FF01BBD18FE4B5C13D8541258CD2EFC3B9905A9D9BBF5BD
      411A4CDDB8771BBB5378CE85AF7B6E327583E9D8C58B70360146E5CED2A8E77A
      FF9C25698C723B0C08730DF01F3F75A70DE3F75E18FD0BB02E9A44A9307EEB25
      E93C10C95888F4B7CD4DA217A701C06238484C5CBC3B6CC07F083C5785B7C044
      D2986F6928C0AAC89342D009017B15AC7B8351EC7BF458382D8C104E710CA397
      84E22E85B724FF1A46F1C405569F4C633F8AFD74DE30DEE35718DA01F34CCC32
      88FA66830085FFF671D126FCC59F6B812A9AA5001C11881B11346A03AEE7F615
      E440545E0E399874BF47BF2F83DE35C83720ED802EC8706C281836D6835FDF4D
      8417850D094A985A0273BE369B4B61DA3510E9E2C4F73A8E6902A137C6C2C5A0
      17C39460B69E1ECCE697801900F5209811909548FA48C0B514705B6B02D792C0
      B59F1EB8D69700D76A3F0C5CF8FDC9816B2BE0B6D704AECD8C00960443B99EE7
      A7FE8D80BB1331F1C7BEE78910FE9885702966F0C6C298A671C680353EBAB13B
      02408F8D8B284C6940587A9A9826FC1347B75E2F8D8769F2B3EFA5E3D736FC31
      85170566A3232FE3FC7218A8DF876976D5CFAE62BC1AF4A72ED074B818F2451F
      560EEC8D3FD3F954C05DC98D8853106BE0AA1F7BB1FA0CE4675F7EC6F2D31B05
      D995FA6E2C3F6F8C55FC0556FB241C662BF88B693E800E2FBE6336635CB9FD40
      64B8D42CE25215E52FAFA44F019748F033E29EA3392227E3377E4683EB1226DE
      C7EE1F155D364E4162CDA6D55A3D2D7CEB9269C1D7488216A763AD371DAB3C9D
      F6EAE958EDA5D3C1AFEF4DC65E6F32B69A0CC9079DA721AE6B63BAF300A63B8F
      4E470B7B9AC9009D9214B508BD4912854AB0E25DEC56EEE2B0515EC22CE80D86
      D6C2CE5513DA856D03BA16E336AB175B8DF55E6C5AF750B8EEBB2FA220886E85
      777F0E66F51C2CDACF85996004347DF96530B87AF7D6388D3CA1C4AD2792B776
      0F6B2D6B0D304A92BDFFB3E893F920B1CAA255062BE4E2775DB305FF9A1DDB82
      0FAB0D043ABDB35B2D073E9C6607D8EE5DD3E9E22D2DC7C45BDA36C6D4DF752C
      C7E1A7F116D892360DD3E876F126D3EC22CFBF0345D6C2DB4CBBEDD07D4EABD9
      7AE42D9288582DA4D1AFD59B64A94DB2BE4EFE55329AE5AC8BF21F63C1225D2A
      BCECE8395F78F496F2B112EF28CD6DC5744A1CCDAAE6FBFE7DAAE42F5081FB62
      AB759FFE9E4F0017123FC95E59CDD317DEB7B8EE6A1A3F0D8E720A57CDA417D7
      537FF441367AE761116081F9AF069875EF7597691C8523698BFB331C93244D51
      56FB8D2EF96F3199066E2A7CEFA8DB6A5BCD76BBEDF0CFA414F5E8DF70380032
      A12E4375FDCF41435D84F26A48DC42FE91A42EC8E120A5F35F537720E42F20AB
      8B306DFCC67FA570427A2F1B666F7664774DDBF82F0411BF6D36E98B18369C92
      5D128E277009A3FD23BB8527BF0D5FFE7320978624C8227A001F062DFBB19772
      03D30DE11276ADEEBAA265EBB12AD6633A4E7941F4058C8C9F6880ABBD2040FA
      275B126D95D55DBE5566A3626D163284E2DAE80B78057EAEB5B65A2B43006C6E
      6D9DCEC2DAF00B5C1B7C3EFEDA2A57A676FD31D706FF96D7465FC02BF073836B
      AB5A19ACF98BD7E6D80B0484BE8097E0E716AC6DC5CA5084A95C1B26A494D646
      5FC04BF073FBD7F6D0CADA2DC4F4D2DADA4C4BF073A7D7D6721628097D01AFC0
      CF9CA9A1A7CD8081F0DAF74084061ADAEDFEBE94B7B79A16C8D6CDEECEB1F685
      3D2E32F7ADD8E12762ED8A88EF0ED23E1E6BDF42B165B3AC7DA362CBB6B0F6A7
      105BB69DB57F8DD8B2E3ACFD61B1A5BD404BBE29D6BEC0D2CACC7D196B372DDB
      EA34EC56056F3F329D6EABD5EDB4BA8D1DE0EEB8F17554F7ADD8E4C7E4EE5B62
      8B7826EE9E33F5ED5BDB537377B5F66758DB7372F76CD94FB436CDDDB7969268
      EEBE0677779C3655655ACEDD4DBBE1D8CD8E6DB73473D7CC5D3377CDDC3573DF
      0202A299BB66EE3598BB65390D4A56AF60EE9D9669392DC7B13473D7CC5D3377
      CDDC3573DF0202A299BB66EE7598BB6D37BB8DB66557D8E55B985CDE0094D6CC
      FDAB97A2FDECDACFAEFDECDACFAEF9B9E6E74FC6CF1DB3E3D88E5361893F0202
      EB98CD6EBBA3B5F547DE64ADAD6B6D5D6BEB5A5BD7DC5D73F727E3EE1DEC3702
      3CAFC2148F2D3F2CB3636A3FBB66EE9AB96BE6AE99FB361010CDDC3573AFC3DC
      BBB6D9709AED760573EF361A36DCD3D6CC5D3377CDDC3573D7CC7D1B088866EE
      9AB9D760EEB6D969352DA7E954D9E59BA0B7DB2DA7DBD1DC5D7377CDDD3577D7
      DC7D0B0888E6EE9ABBD7E1EE76ABD3B11A7645149DEDD88D966559BB50B946F3
      F65DC45ACDDB356FD7BC5DF376CDDB1F9DB73BB6DDED34BB9D2A9F7BDB764CAB
      D5D08ABB66EE9AB96BE6AE99FB561010CDDC3573AFC3DCBBDDA6D36EB42B72DB
      8F9A9669B7CD565BA7BF69E6AE99BB66EE9AB96F0301D1CC5D33F71ACCBDD934
      5B4ED7EC5404D40173B76CD3B65BDA2CAF99BB66EE9AB96BE6BE0D04443377CD
      DC6B3177E0DEAD46B7591550E7B45B96CE84D3BC5DF376CDDB356FD7BC5DF3F6
      DDE1EDED86D96A76ED6ADEDEB2DB5DABE368B3BCE6EE9ABB6BEEAEB9FB361010
      CDDD3577AFC5DD3B8E63769A1501754766D772EC8ED3327589BAAF5F8AAE39AB
      6BCE3E36EEE99AB39AA16B86AE197AC6D0BBD8DDADDBACC87E339B66C76A81BE
      AEF9F923EFB1D6D6B5B6AEB575ADAD6BE6AE99FB5331F796D5EADAEDAE531521
      6FC2D8ED4EB7A11BB73FC252B4B6AEB575ADAD6B6D5D3374CDD09F8AA1B79B0D
      AB6D77AC0AE7BAD9ED7680E73BB6E6E78FBCC75A5BD7DABAD6D6B5B6AE99BB66
      EE4FC5DC3B96D36AD976A3B2CCAC639B0DDB0611407377CDDD3577D7DC5D73F7
      2D20209ABB6BEE5E83BB776DA76135BA2DB38ABB9B56D36E37CC8ECE7AD3DC5D
      7377CDDD3577DF0602A2B9BBE6EEB5B87BA7D16D77DA5561744EABD9EEB6E105
      9AB96BE6AE99BB66EE9AB96F0101D1CC5D33F73ACCBDDDE9B49DB6DDAD52DD3B
      2DABDD69D95A75D7DC5D7377CDDD3577DF0A02A2B9BBE6EE35B8BBD9B0DBCD8E
      D5B42A2CF3A66D779BDD6EDBD1DC5D7377CDDD3577D7DC7D1B0888E6EE9ABBD7
      E2EEEDB6D3714CDBAA50DE9DAEDD6CB62D531792D7DC5D7377CDDD3577DF0602
      A2B9BBE6EEB5B87BA7D932CDAE55E1773F32DB0EDCD2B14CED78D7EC5DB377CD
      DE357BDF0602A2D9BB66EF75D8BB6902EF6EC3BE56B1F7AED5309B56A3AD1BB8
      6BF6AED9BB66EF9ABD6F0301D1EC5DB3F73AECDD728079DBAD56057B379BCD86
      0D1C44B78AD1DC5D7377CDDD3577DF0A02A2B9BBE6EE75B8BBDDB61BADAEDDA8
      2856D76EB79A56BBDBD1AABB66EE9AB96BE6AE99FB361010CDDC3573AFC3DC1D
      D3693B4EBBDBAA0AABB31ACD66C7B675589DE6EE9ABB6BEEAEB9FB361010CDDD
      3577AFC5DD5B6613D477B32A68DEEC3660D3BB764B2BEF9ABD6BF6AED9BB66EF
      DB4040347BD7ECBD167B6F77EC76B7D1AA60EF9DA66D37DA4D533377CDDC3573
      D7CC5D33F76D20209AB96BE65E87B903DF6ED84EA35951ADCE763AAD8ED5B475
      1319CDDC3573D7CC5D33F76D20209AB96BE65E8BB9B7ACA6D976BA159ABB6936
      9D56B3E3D8BA569DE6EE9ABB6BEEAEB9FB361010CDDD3577AFC3DD5B66B3DDB5
      1B4E55A1F9AED5C28C78CDDC3573D7CC5D3377CDDCB7818068E6AE997B2DE66E
      379D8663DAEDE5CCDD6A3481F33740B9D7DC5D7377CDDD3577D7DC7D0B0888E6
      EE9ABBD7E2EE8EDDB4DB965591ECDE344DDB69B4BBDAEBAE99BB66EE9AB96BE6
      BE0D04443377CDDC6B31F76EA36D5A4DA7A243DC91D5EE766DC76AEA3A759ABB
      6BEEAEB9BBE6EEDB40403477D7DCBD0E776F037B68B5AD6E85EA7ED46D3A5DAB
      6977B4EEAEB9BBE6EE9ABB6BEEBE0D04447377CDDD6B71F7B66375EC76B3B2FF
      6BBB635AB6A32BD968EEAEB9BBE6EE9ABB6F0501D1DC5D73F73ADCBD6336BA0D
      A7655504D5355B2DCBB61DED76D7CC5D3377CDDC3573DF0A02A299BB66EEB598
      7BABD9E9B6DAEDCE72E6DE76DAB6659A9AB76BDEAE79BBE6ED9AB76F0301D1BC
      5DF3F65ABCBD63773BB663DACB793B16986F589D96ADCDF29ABB6BEEAEB9BBE6
      EEDB40403477D7DCBD1677EF36DA96D3ED5604CC9B6DA7D5742CBBA12BD968EE
      AEB9BBE6EE9ABB6F0301D1DC5D73F77ADC1D783B766FAFE0EECD26E8F536E0B4
      E6EE9ABB6BEEAEB9BBE6EE5B40403477D7DCBD0E77EF626757388E554568AD8E
      D306CDDED29679CDDD3577D7DC5D73F76D20209ABB6BEE5E8BBB9B4DCB69D84E
      454CDD51D3EAD866CB74B4655E7377CDDD3577D7DC7D1B0888E6EE9ABBD7E2EE
      9669990DABAA818CE958AD96D5ED3ADA32AFB9BBE6EE9ABB6BEEBE0D04447377
      CDDDEB7177AB6DDA1DBBA2509DD969B4DB4DA7AB4BD968EEAEB9BBE6EE9ABB6F
      0501D1DC5D73F75ADCBDDDB6BA4ECBAC2865736476B002BD5DE1786FE49069AC
      0B985AB0B0E0BFC6F1221C1048B084380D06E3DE70909846CF1D12770FD298BF
      2A42665D4EFF35AB5A7FBB718966DD252E5F20F2F885AD2FB3FFED58A5F575AB
      5C21062C177136BF4AFB2B57B9BE4090F1F80DAED2F9BA557E8168B0742773C9
      EE4956D9FCBA557E8190B00EBE3E866887AB6C7DDD2ABF405C78A453595BC8C3
      55B6BF7295EB0B0E4F4D7B88E22DACB2F375AB2489617D11A28D4D661B552244
      ABDB75BAEDC7EF53B3A68C5FCF44B023060296EF1FD344F0EC4BFA1AB1FEAB4D
      04CFBBB615068205D9EEB14D04CFB6B61552C04E1BADBEDA40B0C546AB273710
      3CA3D1EA390D044F6DB4FA02EE6E35CCAEDDC1C23895068256A3D9B29AD623C4
      EEDDDFF66F86BD6B8EAE39BAE6E89AA36FE9DA3447FF037174DBB4DB4DDBACE2
      E85603CE6AB3D5B41DCDD1BFF26C2E5A68347BD7EC7D97D7A6D9BB66EF9ABD6F
      377B372DD33191C7FF0EBFFF99BE8D6E441CFB9E803102F15BE92BF9948D65EF
      2DA7E9947E1C443358492F48CCEC682F3C9737BA5BFEA02AD6B3F8589632B0FC
      317BF963CDA6D972BA66A7BDFC29A7E26559BB9EE58F35ABE6A842237097973D
      D8AA78D0349B1DABCD276CC963EDE58FE59696E58F752ADED6802DE838A65DB1
      03DD8AB7751ACD468325A4651BDEA8DCF12C97B3E249B36A175475C68AE72A51
      45B9972A9EABC015CB313B8EED38AD8AC7AA90A5D169B64CC04FBB6AD7CD2A7C
      C93A3A573C57852E30D3A665B75A550BACC0976EBBD3C166141547C8ACC09766
      BB61B69A5DBB6A96DDCA8D6F99CD76D76E549D59AB51F1C2AE63373BDDA65DF1
      5805BED876ABD3015DA5EAB10A74C9C95FC57315E8020F39B081ED6EAB6ADFAD
      0A8CE9584EAB65035C2A1EAB4297169C071383AB2A9EAB409766D30264695461
      9955812D2610B2A6DDB6CD2A42DDA9DAF766BBE3C0596A56A0A75541604CCB06
      1A63B7AA287C05B6C0D6B5817A36AD0AB0D855E4A569C2DB9C46B3EA7D55F862
      DB4D244C95C7DDAE4018A0644DA7DD68579041BB8ABE008E01C96E549025BB02
      5B803334E0C0B72BB0DAAE409696D5EADAED6E15ADB6DBD587DD469A6BDA153C
      D3AEA02E16B2062067552FAC4216C0CC064CB55181D54E15B6386D103EBA8D56
      05563B15D892DB40AAB6DDA96247590B818AE72AD0A5DD6C586D1B10BBE2B10A
      74E9024A5B8D6EABE2343855C4256B6254F15CAB9ABDAB424C154F56492F5D00
      A6D36C57896615F8D276801B35BA552FAB42972C2765F973CD0A74716CD8BB66
      B753B9EBCD2AEAD2021E66B7ADAAED6B56610B7AC64030E856E067B38A1B65C5
      2E2B9E7358B88FC54DDA0F8CDF3E87D761741BFE077F3B1D4DE95BBCE8F9F04F
      A3E7A7EE140978A317C37F491FFE731148EA0E8CA5597E0FBF27F13D1C922E80
      DBB5EC7683AF3BB66DB6DA740DA24F17E8145D83406A826E000F4F266E3AFE18
      F3E74514A6B6D39BF4E3EBD73EA859F2E272062F9B241337082E621714B189E7
      27D33331347B93E09D1B8FE8DE38BBF2C4F0FF1BC06FB7B13B7D43EA1659C626
      7E98BEF5277011BAF11CAE7037FD7018FDD67367E9388A8D2BF82701EDCD380F
      478188E910445311BBE9921F7FEB0D62016ADEA4378F5138EF4D22D3EC797360
      4DE3D8C1B71133C23DB87F4F13EE31F11E121B60FF123F0A114B84075F925E14
      46C3A93B1249B3C37FDC46B107D2258097FF1E8CDD380144E85885BF6F413407
      A1AFC5838620A9F20EDD4D8230E15DA74BD318A7E9F4FB57AF92C1584CDCE478
      E20FE2288986E9F1209ABC8A86437F205EDDBEF80E5EFACA6A34EC57F8FA49F0
      FBEFBDA90B10B985918149D1F5D8846DEEF42600FE80010D5771769566577DBA
      1ACDD254C40D0C304BC420C5B0EC5BDF8B6E07691CF48669D8FF67CF15A1E745
      835E0ABB7D3D01F44E1A7C3D8C62C093D40F4700C5288C52014AB297CC932160
      8E09B00EE6517833091A855F411D1E796EEAC29BE3218C0ACA7598C280376EE0
      C3F702E061F69271743B0D404B1F4781874A399C895118C562E2DF096F00A3A3
      D20E187F23FC909EBCC3B7E0637001C70F70C3845DB80B607AD15C84B02A7137
      4DC6711AC2D733586C904C073D2F844D0893BED7876FC92C004B9AC1BA6161C9
      D885130E58F66F5CBB379A103EC3C5986E040106AE6F0AD770AB3F62732FFE52
      FA6B8C5333E901BC408B23CCC70DBDDE8D2F6EAFFDD033E92A19B88140DBEA74
      D48FBD782C5C4F5E0EA328ED25D3609EDE867E28706BB2EB713A8123934C6111
      41384E5DEF9FB0ACDE2C1141DA7783B007FFC117F0921E3C026F18C05FB7F407
      5CC4E928EE05219C6D58B98021E0EA36469AD44B42779A462320667E38104100
      0305D1EDD017019C620F86EFC18DD359384077B89BF86E360A529518662C294B
      2F14B7306092CEE1D704DE318AA35B987234F4539C6788F04EE7007624A0F03B
      CC3504729326BDA1C0B98940DCC0D783BB644A661120141E6CE12D7E2F704BDD
      E1004E144EDA1DD2CD3340CBA037A63B106E29D04D37863BD3C18D4BA04A61B2
      F8D0304678E017376E7AD7BFEB5DC7E1344E4291F6062E9C47C0B700C06820E2
      F8701CA76E6AC0B4D85FF0E7DE2DE0F170920EFD00CE916139C0CEF0FC032D9A
      C5221DC7519AC296F6FC60184DDC819B0E82703645D34D1AC3848C1E9E3ACF50
      E70F287A28EE1A3DDC7911CFDB8D4E0F775E5EC24C923BBC00F08763110B7A1A
      1FC14D422B148D26862EA0F80036900EB0416C26849F821B385CD370368827F8
      051AC9F06F3682A179611A8EDD7084CC284CEF52D738963C4A3E6CC13EE3E330
      D92F7ADE862B608C5FF4AC035741FD371F949F6ED67F73DFD8FFBD6A981601A0
      F6341E1AAA4D03D5DB8887C6E93CD684BA75268438BF7424603E31D0AAC0F543
      43E276EF5F70687209C56C20C5A67FFB78F681CCBBFC090C07B0189F401941A2
      2F1094A91B4CC72E5E84B3496F4877F7A219213C59651B3DA075B32405523B4E
      E13521995B95000503BA05F1C6588CAA86FF12CB02A2060B331B56B314658DFE
      30FC157FB41B1D932E8602EE03293D82BBDC21A84EC074C77EE10FAF9FFDD1EC
      0DF050D273E1B4304438C54160474AD3E9AB19399D72B477BF37749C1E7EDF03
      A88C7BD72048000FB55B400393C2F27A287194962B67064F97A645B3876F8D9F
      C76EFA323180361BB06977E79E9F1ACE71E3D8FEAF17DF219E0375E26DDDDC86
      9A6B6D681508EDD6721002CC08842B00076B5F05BAD7B3D1104491448289D502
      F21EE4C720A3F00F07F34BFFF8AACD5438579E10CD73681BBD97FD760F38E3EF
      4B36ACE471AFBD730B4E517CB6C65E06C9F21DC4C76BEDA13C95CE029068FB2C
      E7AB51FE4F2DA76B1C199F707206C85FC2907CBB3F1B6DDD5EAE5CCD8BEFFED4
      6A3AB09E5F2E3E38BF1AA76331B836408832CE4902FEDE88C5340221CA2089D8
      B81D83BAE4C29723D06E8C5746D4FF274AFCB85C63EC26C6E5E987B70690FBD8
      DF42C4AE070CDCDC9F719924A701F68D60B90354D50E0DC2C823C0E9C1357E9F
      46C63989E0C6491018D338F2660391007C48BDB84B6720F24D44383352209306
      32BF042E45F1A1218ABE004B5040D2F9EE41EC4FAD16C2EBF4FCED5B0396D838
      6C1813776EF485914C67B11FCD92A006D4E786EB79C2437882521A78A4112586
      3723E80F02E122BB3ADE45F0B41BD9D93A7327A0FD037C46FEC010C3211C9CC4
      98F849E0F6413182E527B33E63DA4E2E1489C81BD6A48D3757EF1285084C4060
      79202000DD16C6C04D60738992A0926C485B09ECB70F40897772F12D58FC0FE3
      28C1759E5F7E041A00E7FB5DE481923A9BEE2025842575604927033887C94F7E
      14B848A460D3FC40182311A2058DCE6654E37887432098A9011A413A4BCA68B0
      7B90411ED135E5A17E75F1A1DD02AE194DE7080D228368998245022D735132C0
      85022F716789304078F792813B85EFA200568C2085FBE8901C8910AD121E1F0C
      10A39371340BBCF065BA7B3002082135404BA43723CAE6DE809814471379E5FA
      C10C50208C5258399A033D034001F42F11FF9A81F800978479BB8820B0F8262C
      FE6A3E8D10D77F16EEF46F67EF4FDEFDED24F427788CEA9C187C5C7C6FBC76C9
      3D30308EFE86D7FCC72E82A463214840F499BAE9D8E8C30C07E8E3607108B8C0
      2D6A1C4833FB2EC89FFD599A2243F087F4FBAD1F7A11289870771419E435C8B4
      CB9D824217D9C4593483736EBCC5BD049A110D8DBD33818E072010E7FF9AF953
      E3CA9F883D853B702E808F18E7242FECE4A2DB2820BA211E76773A0DE6401762
      7F0AB2CF2C21A219B878D00F8DCB79F239F503BC4A63BA3240E3F81936BF8636
      1DDDC278A19FEE22C1683790D7EE9DA29C0B5213081171B297690686178904D8
      80A4940660BFBA0945EEA11F83EE05DC6517176EE2C25D22F5C64D41CA000E88
      6E1B440F4F0422DDC9C55928FADFC6111EF2D81331A9D517C00988D0BDC50B38
      E3EF3E5F5EEDE4EA4C49D1DF5DBD7F6790430797F3E9E4F45CEACB48B06F633F
      450FEBAD0F647F168602B7DA8DE706A0EFC40F5988AC71BC1B467FBEA35880FA
      F1DB0F673FA04501CE37CA3E0C8E5880B62342D474A57D004EF7FBCF2042029E
      CCC258245170833221B07EE00D17A02BBD394B7691F381CCDCB65102782F6E8D
      D3BF1B40E86E60D5B42C892BB8169002F188F089F78C4FE7179F8019B01C4CB2
      621FB5E7F81A7E73A5416A476161032C06680F222B128B401303146790060047
      64F887072823C1A378C06C8A0E6E7A24F0439094447A2BE036F614BB01911615
      3D0248045C1486205FCCEE810A00856A0419DD8C0417C492E0CB448145AD3401
      00217886D100344C602183590C472B456103B06980E83489BC5D3C3B000414A0
      4E267D7F34F3D33912D9CBEB79ECAF7C720270FA0770173850431F442360ADBB
      B87C67F9F271751F4F8098ECF8EA50023A55A4E0440A050B2B84C34FF4AF70FA
      4FF1CE2968D4D31D3CD848039B281D65644F9E635831FC4594914C84683EC1D5
      66E40DB9279990D07A84F772520D3CC70F910D1928A8B893EA95BF83C6D47D34
      99D60022595581D89DF90952C303642AD2566E9CC5EE280AFB511C1E8B644292
      C7C4BD065122726344A6F0C81D8D8033249CD4B463107AF1DD7E66565E0040EC
      26634490F7273FBD634D228D7D1703FC0CE18D040AA5C300D62E8508FC0A39E9
      211A1D08D718A38C248D62365AE397741F0BB9004AE03441145DC379345C832D
      DE0035112386D27B6F7C971D3DF8D85B181E443C90E456AEEB9BDA8A9F443CFF
      C7CC1F5C5F8EA3DBD388ADC0EC1680E33E272B303068246C18D1660C449C62E8
      C740DDFA2D01E34798F9204227D73E0BF2C67F1A9D46E340F9160D57DA43818C
      796832856F630CCC228E07B2CB2C507A028B3AA42D208E8D301B900D0288D1AE
      BCDE3DE02D035D0D8823745D8F6C052E05A230B00C7788100130E12F531123AF
      C1436FEC9D9263571857D19E319DA56C842C3EC9848055F720723DD6DFBF0D88
      22B80ABEFC81745D84FED0E8C38340A948394DAEFD1019C9B7B3688FEDAEE4BC
      C79FFC3015233C33A0310D619753033485094612E7025732AE657A84B18E28D6
      18F8848F91E56CB89ED3A18675A3EAE2A279721765D46A9A06842923E4ECCE3B
      C4D80712C48C09696DECE1496641AA3829B9C4FA02712ED7E5E5299D85E81ECA
      04C06F0956256D5F720054F695269B83CB0D6EDD795294F52F56A3A01A0F6FDF
      3B05B9D98BD12A30DC33C8034D7615621EBB1A605005D7774CB259CB47E3F1C4
      4FFA624CF6255CB4E29C44D4E0B784118FCCE72FBEFBFD6B42C78C4787A24AB4
      5150947FD78FDCFBA2E554BEF5CBB1FD97ABF3CBE6ABCBCBF35F8DD71F3EFC1D
      38AC70076304FDE5C7F3B749D1A647F90064F67C9CD93FD9E67C7558E566C314
      617386D10C3DAA73C3C3B8584C7BC2BDB9F286E7CCE88EDF826C731147934F22
      896631B0AF8CF1F1BE2A076CAC7E67DDA78FF6CA59B88B54E41E48EAA8D90835
      52648C5F4E6669F4ABC19E3AC2DC44911E49DA8BD2F8FE2D0E4E7A374215EE0C
      1371F02D408D40C2516D7E2835953C7C4DBABB80E16340CCEEADB7F2E8F8E13F
      D996BCA8B4A1FE4A02CC1457EDC5D1148ED22D3260C5EB1724C4DD034A06921A
      E02B432D8AA720FC00D496082649213AEA244904461A4BA3CD5C46D8626668E0
      CEF1744D941019BA377087100626BCE93C8307B7E39D1F821CB4AD22F5B3271B
      585B9D6C80D186E4FF29441B5E5D9DBF866F640AF812A7FBDEEB40C051FD4079
      CE2013EF6DDDAED7893FED9657FDD39BCB37A4AB7F3C7DF73AE735A0ACC3A7B7
      93968A3FB52D6BE54D1847391B0EFD3B8EFF710315168FF62C7496B00167F756
      4F8E70339323F6143E9BE69E22F37B676EEA1E5D04EE28D92B8A17438EB45518
      8028FF23BBCB29C6F44D08D2970F44EF54040105DAEDE00900A8D8AF2EDEFFF4
      AB81EB371A0813D4A58C09C89EB0E0CB411C05C14E2F8C1C527B9F304A61222E
      2928F0631CA1812836EE2ECF8DF3BB14246654EADF46A33DC3BD71FD00E36176
      6FCD9F589D62BB6B86B6A1F111F42C90212FD1964F168AE10C1389304616A606
      4A33213BB2273C0F7E6C60E9BFDD5B3E3A8030763748FDA931F6C3944C333F81
      EC8681F0B3496870AEFAF68927F596E6879E3F9006A75998B045E472D6FFC4F4
      EA248EDDF90EAEAD60C5E1FCACF3958FBC3FFD1165F6BF0325A7C835D47E7670
      E52764947293C41F854A0D915169F2F4EEDE9ACEEFA6A45EA1C2E50E52FF06CD
      CB186C3655A93D83B1C1492809875000F5C55D971A2C25E561C63E2CBDBC308B
      44E0C5E53935D7A7E66D2F9DB76D341AE6E39ACE8EEE0DB76C0198BCFF584BB8
      B8B8D8B0F5AFC83E36BEDC0EF58ED9F88ED55E404169DE9E1D3B50FED8C9D465
      732265615F7EA1595CFB289496B198D26E006FCAB2DA65E927E303E5B1939DCE
      08C815A71C47A872FEF8E6EADD79F224FE096DB5AA94AB408A42ABE14798D344
      A4B974B809907D05909EDC2274194D308F4E4185183A25DC8B813FF43966CD45
      93B404E0ADBBDA668B87E2FB2FA015CBE9F0376622B4BFD244F8B4F2D1D1BFD0
      35851E882C70AE4CA9B0B0DA538B1B6E524FCC78CC6527835A1499249B7AEBDC
      D603B059C8BEF8EE08C37A56A1D537895437885558A0EC1117AAB14A62159253
      F48F63BCF51F0097DC51B04459D6A8F418A844C489921DFE0088F4AFC1633374
      8D47453C42BAF487C12577F04444496BB2CB77F95466B3A51107916108190590
      697596D4D993840A25DD9189C6C59CC67EC0913E67EE6D389A017028856D3F11
      C2C096569801D81701F95DE076718365E65415B103E31F27A7A0F226145D4E49
      21415074B9B9B2E2121D78CC38C77874BC3DF2487B3E3454D49E27644153AC4F
      32E9732A6296B19EB0AF19A097C028B2E853D96587C50FA8C48BCC2CC3120632
      87E756C43810DC5C03836E57DE4111532AB81E178F592BC25315F3563E7F35F6
      1319A7CFF603B90B3218AB2AAB701F8D63D32849FC7E30372298414C53480E6A
      BF9921ECB3552E0A619865FB56D81F9CDD868966090F9F48E7ACB74514D90EE8
      1E2BA30F169AC4380034F3A0FFD82A1886B43DA7C29EE36CB73DE77D842CE21D
      1C837712E7376FCF41B24AA950781AF3B347248F9377B09493CFF9D61B17DBD6
      3F908F089A7DA693945CCE54F7329A05C6A9EBC7A18CF0F00496B8EA0374884F
      7D49C8F7B7296E5F44F1405463F606246E4EAE62E45DC46E4065DCCE9264B0CF
      291031B355379CA763191040B71D3C93F0BB5ED5FA27AF135F4388595E297EE5
      638D63EBBFB482F12088FE1E1D5DF85A99606542956F00197C965089BCE45AD6
      9572D113862737994D291C8F9150E62A604214C95028AD7365C28F6E1A8B2844
      17F02B78FEA33BFFE806B525DB3799582B2564B1FADD461F84681083E1567F22
      C8F73C01096F0C62B1178514CC9D507109DAF3438CEA8FB19285E7CB5A015475
      761063920988888009BC12DCAEE9EAEA13D829CAD887A5E22B78B907785A4F3E
      FFAF355409C1B38301B8DC069A7B618EAA2606FFC8253E15074DA3A92CF304F2
      7EC8DB87DF4FB01E04063A1F6B1AF020D47F00993FFE180990D87EF23D11695F
      79460F80E1EC314CF614D661A7823E964DE3B0C67591B09EAE76EB83021B4DA9
      5FC2FF44B3AB19A86B98C844BD12E8B0DFAD8EA7C4732C1DFB033841B80ACC4A
      CBB75B1F8C8701A8BBAC5469C1CDAD4E7CFA53CBCEBB92A8D4908F02C4F5F330
      8DE7D308A3C8CD667B174BFA51521796823E51656BB82232A8D7EE88640162E3
      FF98890445E69FDE9D9C3D5007523D748ABD42B946D5EE81A45C48A00604F35A
      032C49C56282BD2141E0DB9F85B76E084305F30395C09E9170B60CFBA13FF1FF
      5DA8B54F265317E8F220881219F4876533A358196CB179C10E665E549768F859
      D98C13CC58275D179816D75F496FFD0127A4F8857B1240C1D03B347C55D285ED
      E961564E08C78845E84E10A98FB9D23F5A83A9B6FF6A1BF62CC59CE96F09C6BF
      509AD3E770862E0259550A333341B078FDEEEC8A0B2447E108C57BAC62C9C570
      6EDCD8A7E4890470D4D897B532A4E50284089B1D093B5848A01A52A75110B8D3
      4416C497C40ECF1FEA10FB043F6E3D4514F315A542E205E6DA142ABA1C905D7C
      1662F981AC9C9C1F0F661338BFE1CAF9610E4F5EAD08F32428255D15A2CC52D2
      13557B8D8E4DE0EE64B9B5EACDD83B13624A4D4D101D3FC8DA9C7B7975900185
      54179C6A034CEC5719FDB451581F5105B1AB6AF5444843C1963640E4ACE91349
      DFA8C9EE602DD307E92B6BDF1B4FC0781322DA6EDAB67A5DA798CA5C695B98FD
      47BCC4679C2A1A49B01AC4691A07783D0CFC2927035F507167D0E702D52F2C2B
      D80663E2787B3299E9DBC1A25F28FBEEECE4EA84FA819C5C7D42783147D9BD55
      3E208D48C31B16F91087B4DFFE805AC054E8E654FED235FA01F58B817F90F800
      6BDD072283E556B1F576E316FE9D7BB6AC7E86E4FA6E07B96645319A4BAE99B7
      71E2F21C3E37D8BFE75867B0F19A5D52605676E8F3CB7754AD98301848011B72
      A7707C3E70A5F02CE044C59A50B80AB0E67FCD7C2C5FBCBFF29D59D1AA34162E
      90D27C0232DC456459F8CA7996D56B84E97D3BE769E30806DAFF3B968CF60F36
      7DA054F8889B878E60690129A3A9B2569C1B27ABE21262ECA6B9A5AA121E5792
      F247DC76080B4A613DA9429F1A1F440D12765146C136136C129EB04141D67A5B
      3901967E875B5C85E94BCF4CA142C0CFA40B007C3E46B75CFCEDF2C70F9F17BA
      B7003E8D422EE1B17B30A8C4A3BCA209A5E6218DE64EBFF228A5B11B26A02592
      52AFCE56A1087D321B8C770F1C358001AAF3C5DBCB2B850480009E9F00146AD8
      ED851C998CD8BB079C4A5C399B4D037F80B6DB7235BC1F3E7DFE98D54595D537
      5DEAD33004C409A48DADC0F0D93491577ED20EA08AF06BB62C013E9D46A1477D
      62B47394517419682860A1507211234CF9270E9E166E824C114397899CC97A05
      86896E7EEE63E5A6B51DA585F7325DA482402B1F93B3CE09C4B1719215325970
      EE62A41607C9C2727CED2FAD795C64D122160D5F8B10F8B6A17A78181FB1BA1A
      3663821D382B91E83FFA91E278830F8C897B5F0ACCBD4524DE9720A12C92349E
      89FA01F6D2CFE327EA7CC01595FF118738AD95CF67F376974C191D19BC1C8A76
      E863B70338CFA055CCA9C5359D537DE41E86F03B379C01873F554916AAF12BD3
      444F4C63810283A78F181DB16A70EDBF3CA1FEC2177E90CA76ABEAAE9787C6CB
      CF21D7F022EFEE1909A2C2F89435E1845BF087979FB8CDEEDE1B4F8429886A64
      8566457D4FF93C5ED2D6A081D2F7E0F11AB30699AD9F44F47A655BC10E2431E8
      D6DCB7008ED24B2E328ED1FF3CF197A87BF37CE97C653932D42FC93526A8A48E
      D04443A230D720CF79DC6ACC8BA83F09336DB2F0F4D1EAB4380D652D6089D697
      E44406F4624B4F2F1ACC286E611F7B156170FC34A0602774A85108FC21D9F4C9
      952C5C408B6CD70E347578788F7EC1365ABFF29EACB6EB5039C2ACD7D6E192B2
      F58CE5B4B9184546DDC9B0562176D2105A32E6D37A4596CF04A03251661F8A32
      A1E388A7014F22DA33A875B55061B65C9A1C802A2307C59D20A9D99312B4746D
      C1AFD32C4BAB7E5061A4CE10FC4BD33A34E6D18CA64351177CBEB0A9DDF1E8F8
      4B92BFBEF180B7D65607BCE13197C7B57C88BF3796A47F3D6DA6CEC507FB7CE5
      4D80D3CB3BFC1D03DA3FAE3DBB0699ACED227A3C285D9D5F3A48157EFAC7E5E9
      93AC79BBCEEFCA2DA883BC1B70AB5C5E9EE3AE6C022FB7D371893679828046CB
      1C2D7369F61950F2E2FD4F194A66E51FFE28E878F181A8E43F4E343666D8F85C
      88A85816CDE20F85858A2B6824C4F2E625EDEF390822D3049C074E0367F14741
      44B5F41FDE3E19266AEDBDACBD67B6B3849B35909EFCB31F7A28A9BA53657EC3
      6FDF615C07FF7488EA3AB52801C55FB809A70E0BC17E7DCE3AC9CCF449EAC6B2
      740E66EFF2684A4FD726AE1AE4087B5192C9F6BEC94AA3B542EBCDD7B004A060
      2DA94D5366B28FD509134143BF344F5396481A8D04D5A1222BFBC6ABEBAD5F4E
      708D5251DB680459B712E7A32EF70BACA85C952145A7A80AF263C24E49D61CF2
      20031E39EF2F0B5D526561A250C6454C266849476A5BFBED6499DDF41649D117
      C58D450CCD0FB8CC287DC20A679AFB3DC0FDCEEF7C1D4291B3390CA2780E5627
      601B9E85D5493E56035DAA589D5BA87CE3F943F26AA75200DE47BAB3D417F8F6
      C3D90F023EB9FBDE015242CAAC91852FE156F40C0F38A00373A30D778853450A
      18A9FEA24851877EE827631DECB16AFBCE3137D50DF459A7B3FE86A385B2AA48
      D4A58721B41002B56641512912B25FF4398A14CA5528C6FB2CA2608DC404D65A
      9F4556160CA1C7AE46BD1A32805719CDAD8D562706972051E58907B318092C90
      455F46FAFBC30C75B19C04866A73768DB409C05032C806A44612402971DCC068
      238F2B7EE4743BBB99B6E63215EEE4903FF22CEC420D90588C7C38E3F33CB688
      EBECD11478206A2A8AAFE603A2E2F566A1DBAF41B6382F1788BCA716F93231B0
      3B2F8DAB89FEC3D0BB805DC0C0AA764BD37DA2FB6758ED42067E93BC41849E11
      9ACFC260C0E56C28E961100B37E12A7E1355E81B8F9579DC387608A9F1AA89B8
      38186B7BDB2AF85FCAA2192029BE797FF161A1A5E91F1D373F66A5CF91961280
      5495911C55B1A698479857BA0163AB4B3233F753CD53156ABC3F60ACC7F2E723
      4AC9BCA5F2B3288E73D5DA6363FF8ABECA72EBE209BD2C04248C292C2DABB291
      CE622A70140D871CF8875FC83C61F84E068FA98A279CFBCBF59D31A138A5D071
      375516F4B4702FDB4062AC3BC9300014425D04191B15B6EFCFF3DC62118E303B
      040372FF7E7C5097E7BECED3FADF84C3E8FB12B6D649A686D94601976AF163E3
      23A64CEF670D0370B003B845C6FFAAFA3C93882B708DC59C827CB992FEA1AC21
      E05304FE6D145FABC50773C981E5385E7196C604FB00E468C383C1358C268E31
      A4CF1D8C7D4153F493C3D2028B9552644B69A48AB1278BD01416C5E32D6E5C0D
      4A10AD96961027D62AFE49697F8C110B093909A02FE20E4C7E2FBB6B2F4B6EC0
      455D616E0321EADE05E2DCC44FB8142B2CB37C27F0D444908F06763411B1ACC8
      936D6F5E2A9F7A2DE4B342E10C4F019AF2E004E44944F5732AAA1287292A341B
      8FDC4D646BE417C34ED739FE3225D0387B73F2B6586387546E3A63F09F7FA3AA
      B117D0E0C60D66A8ED6715BBF8763AC1193E03D82295E0C5C2E9E9DF95482A1F
      F05537E8EC21907A65A06BE1541F14D3112586C2CFDC2EFA988B60AA3C73CA7B
      2E86C9624E96B84B0D386C336552C5276B20ED9B95779C95DBCA2BE75EBE6549
      B667B5F71CE3DC737B73E14C2F493343CF5F7A1BC903003B12710D253A9EB01B
      44A7F363213282AA1EB8E5E241C23B786C6BF18BD5BD8F8FF0AC20C66ED81276
      F80C4B7D1FFD81168B141509C5C6978AE4E539F6F66916ACD58B87F71B4BD37C
      66DB04E69468B582F83A17EC617120C12A18208350A0888B912A525CF40B6D9C
      24EF4A39CD4A5AFC0DAA1E8DBA8164291E89DBB9902026D328469FE6E9F9DBB7
      5C970FE509599AAF30FEB1748566A582B8DDFCBBAC30052B03A88B07D86BAB68
      A24531961879F6363585283CF204F94517C4FF1A78B35A3A0A61D6D23311A08E
      315FF4506422390AC1307B02FAD285D5E6FB056CCEB27F720F4CD15B329CE11C
      166684459504CF23DBE6848530A5E58520FEDC9F1F0999D3593C45A70BAB1D6A
      0B5CB2EEA974DE900A439DB3867581B5AEEBA8462AB629DB237202E37478DFD1
      8239640190E46759C3F1D8B898C5E474BA9F36981604BE2C5570716EEBC8D8B1
      E0E280A84F2679FAD4E28EC03C310F0AE454AC8C3C8AA47EC4C9526E9AA51A7E
      DD74601633D5B704062A4D62E5D39EC873B5844FF093295B7EFA0CCE0980423E
      7F744FBCF8EE19422FC9FB40D59795D17AD32E881C089B07C097B8208AB5054E
      B8181B95A2FD40DAF1EA9A018562001FEE150328F805887A32D1224D24E1726F
      68005A42A8F6B3E28D35080FEC32BFFA508DCA556E16C7E58950B93BEA9F8893
      A96F39A275C2792553D702BD382C5543507E10651160F74C56095BD5BF16694A
      359DD6B686C8D76464311EF05B724D78D348CF887309CBFB5057347E9AA02D2D
      473F0CA9E37EE2BE3AEEBB96F123E064B0D9524FDB2C4A33A5CADAA20C500818
      6E3EF411F767C35CE3D5126FF9532FD2B5365F05356365585E0A8B6650C9292A
      28E1E5E2026F3C1A4137BCF3AF2F4F60D4A7B12AD4E02A2866934115397D52D2
      CCAECE2FEDAD3D078FCA46B08A08C82DA4A9DC0A60E26E1912A45DC9C20B58C3
      45DC91C2CD4A0B57E3BCF8C0CEE38B0FED5676C3C6ED54CF70C232E0AD1336ED
      AEAECB864A2D6A557081AA4D92CC32F7A5EAC6B04DB8098B7F1AF0B20ACD5197
      8056B16BDC44FE40A8D6082E36AF1D5169100EE929B902405AFF18057E325607
      BA7900948ECB42165A5308100944829DBEA3A96C50410A158A95C420B578F5F0
      2E9DDF4DB1B7076B233AF881392F15B0952029F8B80A316AA88332E840B174FB
      D253880A1516A6BA596DC4E32E0FD268F37774996225296C91679C00A13843FB
      8DC6DD8761783986B9517F95CBA910DE6B6A6BA871585ADA5967DFFBFCC6B894
      7AFB1EA2EAA1C4DE3D865E0974B57B40EE29CBC942787251D9F7A581D7BD71FD
      80AACC65F13245A7378FCC2D2939A8873A57A0A1B78E2165A1BF853F99C6D413
      894BCBA1D88C812C64A0AD6F38B9847330485521B9929124E6BA78B40E575208
      158160FC2882A9F14AF61E858BF7E26E96BC8B3CBCFEC14F7F9CF5E142F6FB80
      2BD559F795EC06FB4A769BCDA0F14CE7FF5B69ABDD383675D7EC8701A71B8356
      D5496B6F759DB43FB5CC8E7164D8C736E96E88EB0D630884967C3E68E6AD9336
      9C392C4922276D5A762B9B186FCE4076EFC7C2BDE668CEA358706A15DC7108B4
      3BC65B77B0EF0940AE8B4D47B9703C505F841AAABCB7456BF9A7F38F6F4F4ECF
      8D771FCECEDF1A176FDE9E1BEF4FDE9DCB16A5BBB7EAEA9E536E8AFE6BFC9E6F
      9021D1221C44E4DDE692FB13920672D5ABA47721060E6237D9C5F60D05A8D431
      C9150087EDB65EC151B9453A3589D0D12AF9B6E145E425A200590056CBE9FB3B
      88335518F3568CB07D27C629924787EA89CCA66C916C70BF4E6E3E49069041A1
      E1C0B703046E6A7A757AF1197798C3DFF324794E79DABB882868E4F3746FF716
      FE403FD7BCDDCDDE478C9F8D517F05ED226F929065676169D8696AFCFCE1C3C7
      42DCE8EE41A30A16FD38BA1635ED798FDA96ED59BC2E1B5FE4E66DC2C4C70407
      A8A900AF4280374A84C6C867973DF67CAE216611FFE41AE5DF0EE2CBFAF06FAE
      DE159B5BB954791E44503FFC2768D0245414B3AA7668E10F3506F6DD201A1957
      D1D41FEC719AC6CF511C78A04A0CC49EF1034719CA60871BAC689C201B00B088
      BB29DCBE7BC0A80205174C9005C02973E5920ADB7F1203B4FF48EAB8BB225065
      032BD5BB978CBF7E5268F871E3B3695735AF74551294EC16293D1C011F0F6912
      5B9246F30D018BCC864AD594B2711EA43A7007635148CFE19EB632B295FB24C8
      B85CB7D8617BF7E0B3143A35A07A2463500106030AB85D9E74E5519C28FB2800
      F16005D24CC939FA1962865C343FEF390D3A6D2453F4E104D368A5F0DD6F04D2
      4799F79595F8648D820F8F29D500266F5AA8412D3D79963A9F0337D9783DD324
      7553D9119DCD1664177B9ECD7E13A6A02DC7597EC1A661A11A26020336FA1B2D
      AEB58BD6F08FEEBCC63D81C1EE32ED6824F6F47A6E4CA3E92C70312517935ED0
      C35872642DC664232F9F8A68AAAA0B4E296D3C4BC670B150CC1166257B51284B
      6BE51A183CE591951ABE960E34ED277F788F723724EA2AD211D9D7DEF2021253
      A83C3BC6654121745F2BCFF561D1DFAB5CD60F41957CC5ABA9B3EC9FD48F02AE
      A241565344AF672B20F7EDB87E1BDAF55B0B70EF3355F38F4E034E8CBD1C267B
      793BBF3C0C9BD2183D951B23267D41FCCC0F33650BABCBAE951DC3E9A7E57449
      74A860B5342C38318ADD0987341E1BC06941171E5CABF096BDB30873FDD8FF12
      A620E4CA0A137B7C5F3FBACBF53C5002E0A71A6088F3F70F67140C4CAF4FE42B
      A86AFC92A687082555E062BF2F062E3AC4643615FC24AB5A3D5BA343EB514EA5
      D55E7E2AADF6639DCA2B8A940216738A5152A0C3E8C399D5C3BDFA70AA24CA42
      A05A20868B716A05FC242FE53E05A291831FF0F53AB7BB156E04C01F2CA635D3
      C90261758CC7DBBDBF3719326F369CFB2C9AE1444E037F70FDECCD4236D088EF
      1CA0BD699BC98BEF148E20D6711A26D9C96426A4B4DFCAF20499E5AC7E436ADF
      4BC70A5FF115C805E8FC0192D588DC91D58EA998D43AE9B397681C31F6953110
      B6338CD203D95CF7FE9438FF137F8D4592465821E196B367B95091ACEEE48E5C
      FFD9D4B05D21EDEC1AD1F45C0A5BB205B2287590C9CA482D5067F4B514726537
      4B6F4FDE5E197F312EFF08A4F6F4EAD35B58EBC5A6D74AAE8D62676C51CCDDD9
      EC765FD89BE7351951255F1985C7633979E9F0B916629AD428644DA0A3084E15
      91AE9C3FF099A0D52D4A2840E79920FB4C8C3C036E91E4DC03EF03D05360538E
      38390E6D1392AE58E0B66165BF50AA408759698F44D6CC14AAD2C7F221E4739A
      873EBC9BFF378A269A834A0EFAEF08F1347641D377E3120F5D2D40AE66B2B5F6
      222B6DC9551F83672AA32FD956E3D0F80B9DBCA3C7CEC4D62E868771E1F31B4C
      FD9A086DAE18168A738479C5B8A4D49AA63FC33816E0F419DC28756EAE8E1355
      23225BA3AC93958EE36836E2820F7BF4C41EB776C41C3A559E679EA462C25FED
      FB832854156517AC2407A574BE958BB9957D20E158DDF82E3DA866CDD14FFC12
      992E7B9C0579D72A0CF4C0480665F261E31E97EB1963B5B76159FD4EF1D9FAB6
      56806D24AB66F05B0956AAEC6F712EECF1A1E113AAFD9B0844A95445C9BCA5C0
      827DCF8DAF7177908B03B003FC168B8F6725BB59B33E83DB8C7DF9EB6A61580D
      27472F8EC6335AA7F6122E40461F1800CC6B4406AC27A2441A2EAD2D2BB49712
      38A9D127025AC10144A631D75A54420C639C1C9E432E1058185534113AF7BECE
      EE18EE2DD6ECC3F8491414E1D80E037F8067358866B126A705724A7E8C5B0698
      2205998243E0329201C174BFCF3505EB956203C13CF410BE4CEA123918454C91
      2E8091DE7753D8161F031633EA43FB77802557BE821C3C74DAD92A87555D4AFE
      A119B7D4F5873EFA5AE438AFF8F9031E8F6A8FE68D03D482FAD44024EBDD085F
      D6895F5FAD78AA3254B9655D1171C4692AF41A60E9AE1CBD31486BA67B94AC00
      AC4CB55A4218B4A025B5A0F4C18A05C5186DA21D0AA4D28F242BFC47A3512093
      3EC832EE077E3AE7B2C4F2FE348A02491FE443D2F20DA71378295BD381AFF6FD
      50D6D6673F11EFD9558DA607D8B2008F2EEF2F1FFE6C801378CDFEBD037DB086
      B4F53315C7C115E64835A18A25536C7D58CE002E461B0FB0AC943CD50C4E1973
      7C2885C894AD2674DF7E71C9C9ABE2FC0FD420F2FD1298B91D4613838777F047
      98DFD1D9C737CC00F5F9BF2F19A8D2A9C091CBC02ACAF8325D0970101BB8213F
      07AE2A8A55B3337321FD3004650C6368135597EA6F0640F47F2B6C5632832A8E
      7A9C35C90BFC899F66AD41650721C2791549D607D0D1D4285136224D4F040B82
      34CE82596769827064D2A84EA390D5502CA839FA1CAE06E8DE8FEEA43F8B4722
      DE33DE8102A94FA20A9FCA004370D9AB08FF9586C78AD80D324AF03991DD73E4
      28C8A7D016403A3B1919F7B3F69307926361BA35152D08014822F97EEB52579E
      BDAC4967ABCB9ABC8D90D8FD9B88E6D6EDDDCAD9FFE04EC45BACA9B5EF0FB91F
      5798EE6085142C8ABD7BB3D6150C8BC4F81D76C263E3708A5D1C49FA20061F86
      029375DDD8074962FFAF2462780268EBCA513D997521EBB7913C9FF7EA2D5675
      4B808ACF41C24AF392895448AD68ADE6D8522D6B3C0CF3F3CBB7CA83A0317BC1
      B3C29D6632FF0A2215820B9580652D84F60B2592F1B7639104589716A40A3FB3
      0460C54069E673656B09B13076FD0689EA095449269137431303775AA8B14ED5
      7393FD0DAEB14776BE3D2C2590E686414A96E6E687DC71108FDE74AA1EA330BD
      F3BBBB3B836A131C1BE7772EA910815FEC7AC38D49A5B835112E5682CC94AACC
      BAA1FAFCCCA67869356D630FB7602F5BDB7EA3413D29CFD878E134BAAD6CDAD9
      3D17E70D79DBF9C5C5C5815AA5EC3B4A0D1B537F020C68AD0613D9C6E7956780
      300D526EE8C30D1DD9529ACD045D6DF4ABEC1B8A6B513F1E4AEC8913208EFEC8
      4F13259E32948994BEFF7045D9FD814F71C1802DB82C0F2BDC4CFC50145FED86
      F309BCA33EEA14DA90A0EF0B092C9753267B34B738E5D84C92845133CD717F98
      B7ACE454FBC9D4AD630AA75DDE47428E323866D464F5E128DA34343EF4B1ACC7
      9BB343D5908BCAA4B83994FCB000A5435095FF176D7286AFA08C935B322FAD92
      ABB54B8ECB5A474DD53DAF0849C05694D3AC04D16377945C19A270F46614020A
      C044375F259E409FB5B65207802804613DD2142C098033F4570B02A332AD55B6
      950582BAF15CEBA38F899879515D083F6E885909C2081A3E7574A44A00672224
      218E273BAB145203A892446361B9841F46D70037C826114F56D7203A5D3C13F2
      5C16A9BD96BC1EDCD40B6CF807BBD26E6901AC84EB0A302B6F05C8157B05169A
      C053D737E567C094B9CD377FC36E17D41F005EBF7982AC8243650FFAE708993B
      1A46EDD633342C49BEA4E71B15DE665184481B1240841D1C23AABC44A5C33F65
      4DEC29BC8A609B754351699B24D616455AD62288745F92A035BFF4EF80EA4E78
      57F8678ED7CABADB2719CD16F16AEF7814D79763EE531D9C6FEEABE0AA4852B2
      9F46C051A46A1FCE231039F31294AE5C1EC60A7077C5208AAE51CC5EB24A7CE3
      643618B3C713BD8003EE25258BBF72F13A8A8790F5F16A2FE8350C8DFE7FEC51
      E5C26CDD4934830F78115547E5C8E9843722962D2187283DE30265E5ACC22E1B
      EECA37E22E7BB0427F389706E570CE15EF3F87E498D9532DE209720B2DCC355B
      7C18BAD921F3301DF9D425DFAFE68CC419CBB029B68695AA34EB6D54F00CC8D1
      906283E82BA22F1C7CC7E5D058D9A36622A1600B5A1FCF830C1C655DF4F4D369
      E6352111130F28966084A3C6FD1629A9A0FE618505B01B905E9CAC3E6BD2B8C7
      7386590179E260008C138D0590A3808AB6A0F28BC72D349AA0FC173B352B234D
      4407BF44B95397687CFEAC057A2ED6985D2BFE51512F034B3672CC064D34DBAA
      857D6208CBF6CE98C8416C43CEEC10AF8AF96AA483D7E76389F1108ED42B1822
      ED52E590309EB5CA34E9FD86827EEFF717DF118927004BEB57D1B2C109298C87
      005E59F804C5B594EBF00C816A829C364BD122D29F71CB6D45A765768B6A1DAA
      180E72A8ACD307637A6995E1176D62F154289B5741D73C86FDE45B70B7108357
      87DB70362BD588238A8353DB3B735357418FA89BD8E363E90ED2991B706638BF
      09B43BEAF8C3D512E48A335609D8F6050B9401B555160C60BCE2596D18673023
      82CAE605C7BF16BB207A7E82F89610CD18489AF36CC0780B946249A6E613A74C
      FE15CB63BD9416CEE2F9C89D8F7C68A939327EA9A4DE8D37F7CB4185BEC54DE7
      962A40111C8A80921C58B19C18B9DFE6AD56A7DFF77E435AD2FB7DF380211A26
      B5040A32CDA1A3E5E00781F70EC6F18F50C821F7458644C87F94711B049F4A76
      AF45E6ACACCB348EA87C745410FFA4FCB53A6A167BB5548A54DE2C26470927DE
      4A779688F1068E549FE02E721D42DCC824775470EC1FF90BB34EBB79FED6E9C7
      CF18B6240A35E2A469961A62E4FA2E8AD1D8600D9D66340D749EF994B3A40FD8
      C3B272418FC15D911A0EE83CB6A50FD2D283C4B0911A61510F1CAE1C0035844C
      9675F3987AA55E16C45AA3F42AE9BECD5C1C6A0C79F48A6D144891AAAC77AE0D
      2F0FEFD01BEA6C08A0CE1AE752DBA5C81353FC43FB28CAE14F442CA4CB5CD55F
      C82CC1EC30230D50064FE042C251D1D27AF2FEF28DB18F46D5FE1CB4E2698DC4
      CD17DFA1C525065511F3B0E490922FC81CC9242B74AFE2B9F32DDCC7C80D6E11
      90DE0A4EC7E0C112E50E8499D26CD8807980C78D22B68D8F98201BCD126C3791
      A8F4130E2218837A404D28281E1D565FEC0FCE9D1BD8CC520019FB127D0FC566
      940DB3D00C824A3663194923B5D693F7758A20AD46F47C7C497D028C0A956F59
      338242D53DC424B4C99473E716265D5810EB4BAAD830DD2A13DB0659433499A6
      294BC90F0237C1DB60A66ABFD7D0FA01B2D244879615104E5496A152FDC9201F
      28B3839C65C23629AA954CAB7C89C6286C2F8119907E48D17C1E858CC4D1CA69
      70A5130283B23E2C05FF874B5D9B64056A13022894D09458C925987E83C9E779
      A8E8BD4363508390918B5661B4274B0CD4F1FBF7E2F7BB5B1DBFFFE2BB1F9881
      661B7B24E91C628074BB51EC21D9A443E4C38779930E34F151F2D321C6CA8838
      8481C23CB88502DAE0DE38EB65A21CA1D485EE78EBB06525BC7E7A77725607AA
      20FA61AF799F0F4D3A9F0A0960F2F8C4B13BCF0F53067272E2883B80051EAFCB
      EB79EC4FD83EE1A2F39D0B8E506D0BB957D224AE4CD9B940A0F8A2E1A2E535F5
      438AD7CB0F34853E62525A243D03254EB843FB21F34F50485A82BFF7E1841E08
      C2D24AB321C0E049ACCFC772321B2FD487F261EDA26BAEC2223F61310261BB83
      787115BB6102C7869C5C0CF91A3058853D0BA74C123949CD94F445217BDCC766
      C4F9A78910C718616B7CE8073E087DE161163662B368A8FEA4A25EC056399EB9
      340F78A30880DB16EA5A4CB0800425CF26180B2227C872F4FD480C9E4281AA84
      583CEC90133DA8DE720D91A9867D6F10CCA8065038571854D804635F4155A6D7
      B22FB20CE2D587F4698EE88BEF9EF5903E70020F540441FE1B376B451F6730BF
      7F54FFE852ECA25453F0C3170E106ACA99F2645A4DCBD827BDEAC878EBA6D825
      F8A0602406348D409489A9A0D2EA2D9D25CFE0E27CF1DDD1607A246D22DFFFA7
      5ADBDF368DCFB7A4446C7CF1CFB760EC2EC185DF36BCE8593AECFCFE1B9CFA4D
      573A76F393C36E96636C8D91B5968D27449858FAEFA31AC0498C140B29CF9120
      DE53DBFE42B27741B0A63211F7CEB46425C0143F5F5D7448688E25C154193FE5
      D753B0EAA2A9518D5B27BF6D2A2BAE25B9C8C0D15F38018E6F015EC8927606B3
      5B82532C1219C842819BF561715FEE2568907110BD9BC5B25199FD39A45C2DCE
      039AA2874D4A2CC87DE837F9F786513867BA9B466362BBDA4AB602D524FA6803
      199FF78214BD8F42D8E539A7CB4581C7E274B1AE45E9ECD58817C4538CA2FB28
      C4C3ADCD69F7CC69E6F28667DB624F8397F7FD010890204DB6B66EF7564E1FE3
      F2908F1D11EFDAC1F9FF5B80224CD06FECDEEC3D37F413397D6BF7A62FC251B0
      CBF31FFAE14EC37F883155BB3BFD91009D21DCDDE9C7425CF3ECEDDD9BFD7816
      8EDCD857F0DF41E209DC3FF077187FFEE94EDD9DE6BDA0F3DF8AD12E6FC134CA
      F9D70E9E003460CC4633C6A1DDDC81789624190699BB377FD05A765A84486E85
      B7CBF34F67F175367F471B2C7283C5E5F9C3A6096D79586979581E78BC2D9687
      A5DA9746FD38F3AD3B254F7BBBA5CFC3579E87E506ECED390F9B3F0ABB68DE3F
      A308112A572E5D53182E9D1D064AFFE642E9E42ED1848508CB9B7B6569A8D6FC
      B8104F4021E014B29F43731FCB9AC0572A90802B2FA87CF6AC8D259E46C3EDC3
      5D0798EF4EAD63E62A3BA7B41DC6BECC004A8CBDCF147150FAF9FBBD6579EEE8
      18A4DCB6FAE50D332F6A56C11BFDA9589CBF909B80EE548E3C54F35CADB5670B
      5121165311722490CB8D71B0F7270211DDA89B4F84FE653055DEE25F371D5390
      88011705912DE6A8163B56F7519D84644D503F2B9BFEC0A9CC4F5E7AD7355BF0
      AFD9B12DF8B0DA4E073EEC56CB810FA7D969C047D3E9E22D2DC7C45BDAB685B7
      742CC7E1A7F11638DE6D1AA6D1EDE24DA6D96DE05DA605F7E1A7DD76E83EA7D5
      6C3DE971DF4097E5221A2C1E99AA67A440F6578CD0A8FBCC35368E88C2BFB6E0
      7F9AD266799279B32A8A483726305B3C12CF126BB3E94A95C44160DD7E217970
      9F8B1F6F78FD88959B5FBF9F842FD343192F0A7C0E51951BBCB9585E642D1E56
      C0A4D5BEC42C54871ABA7175628CE401997F2064885B210A0A98A327621F333E
      89912BA6AFE34B560AA024FD287869BA57289B4E42249613E778342529C2377B
      E7CC5FF68C7DB8DC23012C5375A9C7612EC30F295AB81824971D83ACB5E06442
      992658C9EF5942578F82EFFF53CDF86F1B0F053B96EDD6B8DC6492FADC25AE4E
      CE805F28DC48442AB9F553EA51570C342C84E1713B4A4A0328540DA708E53415
      93296DEF4894938EB3A7332561C3FBF39F1818F9B763D0159F274EEF305FB9AF
      42D28C6B3127C4CF132B5419E6E4DE3D94908089541CE2A9C9F2C340BF1761AA
      E972812E979BBCAE0E0B535D6097D6112083CB22B855AD71D5DB2EA7E689A430
      DC84219E85589F4612ED2CFD5BF6642A7579594B521AC29CB17FE5F2D9A1823E
      0B65DB3C15206AF859E034C75EEF93DBE1E28323B39C3EB45BEA060406C547CB
      A3998EEBA468010F1B08209052B73A3E586745257873BC36E7DDDCCBEEE09A0D
      8358B8A9AC8D8920243345565B88AA2B50D4B42CAAF0878A9ACECD3C6BF60F78
      D46CAD5C2BDF78BE07979C3836C4F1E878F32BE7F8E3FF2745C0E7830397DAA4
      8321333F543312D7407A14089628B353E389C48F576755E4AA6EFD42DCCB89E8
      ADECA2EB2745012CE5734D3A1D9F5ECC92740363308EFC0125423C8B86BD3CFF
      7013C5296581C558C802C799F53A8769A1D54E9E12C7E550BE941369E1AB76FA
      B296BFA43D700134755C0CE59248C56A484B280632B6E5F953944CCDB83E8DA3
      51EC4E64A5C27D99FBF744BA590D3F45513BDB782A6029A3F6F14D0775EAD596
      8D071B85C001B11E4E1B949DC9983D1FE628470E3D2CBEB7106350280897103A
      C27D8860E8FAE382809476B59A0D9F161BC1676F49C771341B8D1FA6C5B2AAAE
      AA3D96304E0B59567311987E153CFDC7836818A59B976A9991955DB80BAC302D
      929E7DA41368562B24E97F4145B125FEE27409F157EC7614447D52260BCACA3E
      6EDA34F6A3D84FE7AB5F8A4F5618A40E0ABC7BF3759507D367CC588F6A666E3F
      F28A8F68B39F71DD25C3EF5455AA5F9AC0BF013FEB5627F03F5565A067702B56
      24F06F7CE970029E61A3F3647F24B768E4BA45915A3500F403A0A387C61216F4
      C41E10450E9E012453EAAF12AFD11AA5C4BB903BA93623D292B63AD69FB91756
      8BC662ADAAB40D88DED8D4655E34BFFD912C4B2BAC8C0CA5438EFDF1443288FD
      7E26310E9F838B3D6BCDA4750C708FB9E8B3D81D45613F8AC3274395359AED51
      B9ACD4BF11C1FCB02CC13E284F7287ABB2DD9BA21B940C483AC2A6FD8C2006DE
      C1FF36EF033692682258F09141937CBEA6A432EDDFEF507E506EE6F5D876E01A
      7A2F026AE312236B221B5FEB738949E17C31FA8AC5A5C367223D18D3BE71337F
      6EA520D61460FB0F6AF1E6185E0DA31DF71AA7B03D34C505821B0C34927580F8
      B834A6D1B51B8FAC6568ABF6C378F0361A19228469EA5A42CA985DCA4092B031
      42E1C6150D3D287C1FFB4A605451B1730E0880D2214B76A4A53D27749CF85313
      164EC150C0FF5EE533D70DFFE6C747A5DA95591F83EFB942E5BD1295EB0D8EC2
      E0CA5B17A4C5F214CC7C0AA7F3D80F027FB0E61CA890DFBDA15BCD46C334F63F
      5F5D1C750E347D20FAF03346FF6C850F7A038B2DF8A0552BD78C9E2934B9D7BF
      13E8A1A66A4F9DFDD2687CDF68FC6ABC7607D7A3389A014BC10E9A22FEDEF845
      46A24842777C79F5E9CDFB1F2E7F9527BD2EE1F8639FF39F6BC84E5C1A7AD3A4
      E0A96C1B35168C271DEBA2528CCEA1414D73546F1F2E2D1BA5795EB63EFB4F75
      F6734B57166E5671C88D7D8A7F501873A0597A254BCF8ABCA3EBF6DB39D67598
      3C473550528B4FE7DA50ED07B86541DE0640B3F60DB17667396B2FD8B84532F9
      D5B858391A9A46657FC97D6A38F9FD49F7A263BFBEB8A8AD21AC33A12F213F8F
      3A814B8AFE92ED70610A9AC45590B867B0EFFD37FC6FD351042FBECB13EB8088
      91CC52F0212CA5767562CD3539DC203934ADE587FF74FA4192962B91A44000A6
      1514E802C9E08FE42132CEF2DD7F46796817DBE722DC0D3C21315090D00B3479
      2D1A8D83FBD02142DBC736B4B1B88DFD34C586B411A6C8A702D425424D404617
      7353D12A9CB5EAC02EA62E35889BF8D88582A84DDE9F341AAE9E54D6F74A6014
      2ABB9DDDFB6D356ABBB42F0B8ADE218D76757EE9602A996A98F5FEA7220C1673
      EFC949CB6573A87BBB6C7E0583345F5D5E9ECB6C34270FD896C33CB6B1AD865B
      731ACC0064C9717A976EDCABA760A2EA497891E0C6522A8BC70F013100AC79BB
      70C9D50AB33EC87A86D739D60C68DCD1FB6373645620B0A3A4DAC90D4B0EB80C
      9A62EDFD20D7EE234774C88A8D0A4D0F557F301515B4697D1184DDC786C56AB1
      0717BFF985069B5F689641596A699462F81B3732424A2C2372CE2FDF19C3C0A5
      325F3243D81F4AB172E27363F042A0CA5AD17C257AFA45050F9F7473CCE32DA9
      7B687F65DDC3AFC3E1DF56020A596DEFF7070FEDBD78DEDA66DBEDC2094BE2C4
      A699F6E7A90787B3365D7C446271848CE1118A913A5F3F17FBB85E51E60F4390
      E47C3730CEDE9E227182F7781892A088CD5191D76D1D8A394F8162BDDF6A2019
      9FE3FFF7D3A767C233F2ECFDF4A95436D7317EFAB41DD8D7AC897DA714461E85
      C669305B79735F4A5AABB1743B80D0AA0904253660A636AD703BA6DFAE39FD30
      0A8FAA96F047B706BC191ADE8C4269507EA30EF3C3A2BA46C9FA8CC2C5D6C29C
      DA288DF5A88EB1061885824B8C52F5EB7FCD7CECA5397193344FD050BD870338
      58DEBC18AAC17267FE58A18F31DC53632DB8B37192CAA6BB48726E93E59B2F3B
      6C4E6741C0F3A70C1E3F84AF9598DC8781AF9F2B247357AC6CD870FC1DEF5396
      056A78C0AC235D70A0606EBB071B3A32EA94ED67A9BBF23E4C5A2ADB36B02C1C
      398BA83E991B637937F59B3CBE2E9783E6C3961C1A7B83683A47F5EFF8F89830
      7B8F1E5E39E3C49FF801EC1BF6C925CE971CE4A6C1824130B312D65612B9E835
      1A0C394DD8452555DCF880434C3DE4899D4733D9F67E8120F0D2D62C3A8D3AF1
      200A669390A14EE6F50F44D0F6477EA619930D13DEE526B04BB2C21396F0F369
      DBA44E4C74F0E030E38778F59615EAFD61D9E80277A1097AB5A424A74226CFD2
      A6735BD08B289EBC39333EC662E8DFADA58FDFF85C5B50E1894CBC00FA075004
      70CA4D08A944B6CC00A3A861B929B55FF64EBE80EC4BCA8A20378BC0CF1177F4
      733D39D4138864DEE31D43240ED7E2481634781E6314C0FF65CA356FC4E07A8D
      54C98B126550DBC91C4CB14F3966F62B155FF02759610DFA9D6CEA8BC7499580
      A7EDF9E5F857559B0AE5805FFEFBD7FAF571FF078E2D19A054457BF786E3C7C9
      308449881EE68926224D70EC8519D77ECD5934C3179CC2CAAE51D6384DE3E02F
      E721659DE3A279A551088B4E33D29B8B13EE6A69D1CB2BF351A4D8208864FD17
      A6DE0CAA0F7FAF3D65726867447EEF74913083F42360ABDC546431FC440A334A
      48EE8C79A1029657A89B8620C6F253A82203617A9591242A769DC81E02D83960
      2D935E8D4923858C05BA7992028B031A1F8B89C01CA71CC9B5005561DC20DF2E
      ECDCCBCB0C8048F213754E8D711410633FBDFAF496B6C2E30330C003F0520B59
      24649D107E479C6AF985A0CCA51C6A9570AC2A4B13A91DBA41B2C6D9614F0B6A
      4E3C25E6EC87FC66557E7E2C020FA670CBF24689AE3171770758AD328B685BCD
      66DEC9EC6EF8347E005637656FE73EAC1B58E03C1007B2D85E0620CC007AB65A
      B6BB72482F66C806909B2ADFE2F1681CC1264AFFB43E8474080928AB7DFD853C
      0DE5A4026488E79C3ABD2F4BB44A797806A4915016CF42925061729F52DAE6C0
      8D3D94A8C6AE145CE5A6649CB1BE6232440689B970EA65D42D468E47DF883B3F
      490F8BAFA1AF31C87C044FAE21CD9DF3FAA4464142128B153CFAE737B91B1D05
      B30757A60F6C85D156AAA92B6F643D368A511005A2493433D1C7BA74AC73B8A0
      51CD18C2919DC5B2567DC632019DB9029CEC5815A15AED4F64A15FBC6D145148
      119E7423F0D3148F197E53D4AFA7A092ACA1E3C27C60381282D328CDEA9A8D01
      D25CEDE4DE961EE6669270CE32312F87CAE7DD0AACCA9DC804596E6AC68884C7
      D25FAD39A462C436130283AA4073481A362BDBA876852E95DACB2657BF5247F6
      0C6FC5AD3B474921C56933F469530622A6E89B7D347DDE6257FA707490053693
      F2E5CAF851651418CB52707D3170B36297D4C540591124A01324C4D12C4CB318
      2DAA1742C5EF1265D43D38365ECF714C5A33CD92CA65CB316A1CE084297C1811
      26816A07F00175CC9FA28EE45301C221084A29A843A99464D88424D7A3FA5EA0
      7A2270B228BE4973CE0DEA4414CD36E6BCE9D9F44B76802AA020E3C28532C424
      ACF3BE0DD28C14C1C1F651C897967086FD1A2F059D19DE285BC6900E8FB58625
      0C12E68032742F89020C63C34A2C18AA4755226B99CE71DC45308DB3B22EF949
      22259B38139A8E26D314B6C9BDF1478CF799458FAB4262B6C69C6D7D7B176478
      227D169FCEA6BF775C90976599223276E273D30894CDECD4A27B010F2DE8F2D4
      D52464BE2CFBD621887020A0C62F13E9C690F305B860DF133FCC0D0339F800E5
      EBA0640D2832E071749C300184F2EFE15016A64DCBE7FD0CB1EA31E1CC43E021
      4A3771AFD123933205156E32973E138003718F3C8E8ECC94874C7F84B217A3F5
      4562441A294459C02456178688AB00257784548447A1F9E748002310D6D3E146
      524A9853272D6FE51D19F6E972180F03EA7D61478CCB050F83965DF254128A47
      CE23F2C9644A31BF8ABB1F4AFB582534B3B4717916F36FE9302A9789F41E8699
      532CB93F121E301487261197F4A570582584AC65DFCF2791959BCE3D2A874612
      AD1E06ED8BC8C73C1F3B8AC091177753D501C70F3D1FA42054C04AE75EBA65FC
      98AB008769FD59FF8F7CDD5092BA82B3014726AF3110361FC3CD7D52C154C66E
      36857598E61C98ED84FD6A1C01A98CD1C458A4251A79CE8D0BDBD70F74ABB555
      AA6B88507A75E62764E347707E12C471320CD1742773FA968A64CB5AF03FAD7C
      96CE823A144828D8824847CF9380C79AE9B41539DC0F8BFA0B2869B330B3EF01
      8F57488F325E7E986516C76D4955BAE7AB6631401F8D151607556D549F847B27
      413AE1D3DBC8E0D0F448099505D34228AD5FEB3599C2701F83EBBDE61E524B86
      20D511D8CBA14E62992A9335850B0BE5CDF74ECB2B383E3EDECB4F9DAFBA22E6
      14E01027854C878620A7E5BB3C23639906358C06A8C64A91837D9BFCD2056905
      5E93482D4856FB525EB960BEE8FFE4538F5DB25195A881D835AC1E65FA714E0D
      B76B6FA30A90814578B893A4140551744DF48A959A9F8828BA7D86177C198094
      901AB654A493CC48B12F15ECBF200E287BC7C1B151458EB90EA782DACD3DDAEB
      3EBCCF8705A30325E5A273DFA59032D4BF1737BB06B45F7C27FB0DA945ABD9F8
      C9023E64B8468841D8C94AB98AC7BA27790612479009644104642F8AD0E9DC9F
      A522B75C28C84A9156B66DE7492106B12D42C98FEC73CF4B99CA81658A609F2A
      C3A70C668C002A20EFB1714286025441FD78E2D780D16A73C6A8E429CF10BF7C
      6A086E7D9169C94AEE5D40E4EC3EEE2CAFF9E0C3A05F809E668219895BC42B3C
      AD6CEC52DD5D4A670739667E6AC4FA0AD07B36381543BFC8AF5D224D6FC244C4
      E971A6AECA1B2711DA1061AE518DC5C5ECC35EA47840844F6771022BFD3C355E
      A9EB3352A24F3F9D2E4C0AAD585909F7C24897637F98FE85A7A99A59BA692136
      58F137E2AF64069337FB438E461ECAF03E49FDE8D5FEB06A9863B2B696438630
      C8E8D3A99AAF8C4DCB66F9383C74649CD1B8EBF82C8BC1D6B4AC720083B490AA
      8AEF598035AE45424592F5408561AB155384C28452BD731826FC160034D6E9BF
      F5A59B20876121E590930A6F5DECBDCEAA7658DFB173EEC27B4B058EB86232CE
      03039BBE2CB970E170D74CB4A149C10CCB53A5150C6DA3F7B2DFDE92AC42E72B
      B30A9F960466614E47C64941FC78FFE12A8BCB4755B7C6595203A9201A895C59
      C86E46663984864A6F1F6F1DBEACD66E38C6FBC8F8B02891A99C0C79404A0EBC
      1D5CE88BEF2EA3593C1088198BE2E7E25A5907CA1C94B947B3DCEF42864C3302
      48171639FC8A926F01ED24ACB98D518D50E2AC5F06CD4D4E5F4D75914FEFD056
      00DCFA0CAD23642F45C8AB241C5953B5E886F6C35D3D632FBE7B43B13BC6DB0F
      BC628CB9917851E097459E98455CE7F13B1355FD23EFBF770F170AA908680599
      4609EBAB0A090B91BAE9EA529EE4B9C08486EFBF28A37A01E8D65A79AED6B249
      81B2BD920B9A8EF3E56C901EAECB07FDE0A622508986D90676F8E2BB13AED270
      B45839A1D411248F049B60A84C8CA60FA0618F71D41E71D76BAC160EC46B4CA7
      83F5220D46839518CC4A194EB7590800C5AE635C2A087EF414C8E4E13C8BDFCF
      F25428416FF158CA0E9A6EFE803CA8FDFB230D9513EAFE48F57CFD32C6A1EA5D
      57E3A27931515122FC36E4DBB4EFD8EC1A46E0AA315A5FCEFB1AA0A4AFC49B34
      1A8DA4598DCC60D20C3B21A69D298BB0D081204510FB7F612035078DF0AD9990
      3089666BC472BF9618558EFCE973E8A64735F914E68CFC1BAA5C88B92E659ABF
      BAAE5166D0239B1B067BF069407FA888B5C6739FD237B75AE379F1DDC792FDF7
      BD6C252F8BF164C68ECCD8C071552295FE808958B4FC64E10585DFE420FB133F
      9C25797CF0C14E4A6304A7D352085FC4C451CA5572B5E83FC26C240A9D206828
      2B75E04FFB11A2656E9727310E865BAD58BA52769383BDA77A749E9F6AA22C45
      9692A15EFAC1EE5BCB2935EE70991F4259D20BF986F77C1155664F8E3CC19190
      61F2F61EC39323761F0ED96B5290B90BCE0722D4F5034768992A62A43001F4FA
      A97087D5F45C3A36F7161C3568F02C2517E2668F281F57392042718BC17764C2
      CBDE4E76B0D2839C8F5D4E25D55E898A5285654CD1BE793ED18B60A1D3B7502B
      B0D441D4CDACC97DD92D2A4F43CD075BC7859F4809093DB3B232877249BA14AD
      5B83722B1B7876586412ED5AA1049CFFCF0DB1B81EA8EA8DAA72FF43EA713D16
      417D1FCC070C36BE0765993921D598A500E67BB8B12E993715F16035679DD47C
      19604106B0E553F122D231FB82B336D01353E518A06964A94902CBBDE6F9582E
      75BE2C59833441AA7071C884101D2DB42063249C3AE426799807D280FC68A31F
      0FA3DD8C3D4A78A988BF59E8F2548EFD1896436EEA04B8AC5B12E34D2A6393D8
      CB5B102316C332A4A1118F59522E58901B5995484AA46251E2722986354BD4CF
      DA5E9702F6F5797C78BFC8F9AA0FE4D71D48F6601790EEFE995CCDCB6B1EDA2F
      3893A5208CFC182A4E9B855085AA0E51AE72143DED05968A150408719E2F2377
      570E18553C55F117FA6CAD7DB6B8622CC56EC0F178E888652768E50C9EE28815
      2313EF71C04573C02A034031E910EE153E069E60522885B0C459ADA9628422FC
      B4A6AACFAF5D461A327866532D64C2A8C9AA49AC2E7C509E252EB048575687EE
      AEB9AEC1388A68666C2D2925F1CC089DD899AB164021449991228B205225958A
      19F2BAFEC0C31B80F50710372EE50E6A8297B975164153A641A8B9CFA944601E
      1E99077F655AE9EA34D3ECECA8B099CD77917AF1DDBDB5EEDF1D7C1B2DE377E5
      209EC0C4B17659791FF6F4795C5235AB02561C753B8125FA47798E0DB023E281
      A1F1CBDDAFEA903D5C42AB796C9CCA105ACE63F3386D27A501C9EC4471304632
      C11C8A9887B7D62B58573D4F52A0B3F66A395129C5D52D157F6A40F2502605DD
      035E5136AB30FC1F6685284AEABF9A17C50D20A0F0534EF24626C4AC091BAECA
      2C133BEEC324F0273ECB347950F59225A1578D6B83A0633E735FDCF8EE12B5AD
      0CD4D5EA5F31ED2AF0AF850CE8D074EE61B87DCA5A7671D9DF5FE81C4C03F16B
      AEC5E638A5E95F2E8F7061CB6540CACFEE7E9621FE906DA2943E76B0A49DDA3A
      D643AA2E036210952B51DE70A2C430832587125404716CBCC1B7A5B3185B45D6
      587F4AAFA0566D22C9BAB8659646588017BBA391224D4C9DB39E67321FCD1860
      D6B1B450526A007D9394222463784F897629CD925546AA4542454FF382A2D338
      02804F0AAE28B51F6BD40040FEC63BAC0EC4C35BBD984341E13D3520292D4653
      11A30789EAB93C80575422AB508351C526A7D1D420B293958155E826D5465529
      01E3DEF955EC9F223D52D5EBD6B47215AD543287FC4C90ED50C5214D17099BB9
      96980A7343C0507CD2B2F2DD4FAB421D71910EB94D8FAB3AD5295684658ED04F
      8B62514978A379718B4A39B9DA44E94759849633DB28E6E92490B96D59D92B59
      CD8D852BB49EA95A0C098534FAC3D2BB0BB12E34B1FA8C265446B5819B487350
      B1A2168FAE2A5D72CF0FACA4C3C9815425B3380D37961390ECC047FB389D02E4
      1D2B67337BBE9A4FBB42BB4EA82C3897EB91314A9A6611CDC274D74134997016
      4F484664903CA8C27D5E1F4F9A35C71C489F81128DAD1CF0853945A5BA7284FC
      FB859AF8F2469FAA2D89C9348275CFF3B2B1B72E7BF66721A848F21C63C206D6
      90F7B8F21A872CCA168B07329114CB142A410B139C301F5880C606928B3B9DAA
      BE35D9F9D8301D26BC3B23585D023037DE179DEDD2147BE752044A7814A9B670
      FBD9D55FB9893017813834B2EFBD60901C1AA7A7C94129DD001B927128F91248
      F70889366E325C84F4F72E766F3BEC636BD1C301760DDF7427B71CF259E9C452
      386E0D58722A04A5B94FDC391C9D4130F36A550BCCB670C105A2F9C37280ED5D
      625CD6E790425E8D1FFD30DD0382330DDC814872D56A8F4C7D885E7BD2FAA799
      485E2E70190C91824B279854C93EC8B25CFB11953E908B3EE030028E8893D91F
      18C03E93A3A942B920032A03A7D930307A3FA50A257DE44A30E218DE9A8B5CEC
      849C859ECC57FAD19DF4673196C57D27EA14779D1D66C55F88BDC8C9C8984F2C
      48080BE6E03F8CE3CBD9A5BCB3B63C79AA726EA8B88EAFE216B32263B304CB09
      52CDF3C532635FF68E5FFEFB57B521F43AEC0B8E399DC4A13929DC6CCAEA4289
      E4C9F03D1AA0813C01AEA1EA477904ECE6C5C98651F46F913D9DED8E263D35D4
      EA5A91F16C6D56697E86E0AE0AB4154893342D92CE993D095205B1FDD740360E
      1498F624095AACFAB1EF157C2E693C13F53B3855B62D9132AF2AA52C939426D5
      5BB9AF1270B81037A6DFA9C2C6980B8AEBD0E7E9E1CD5021C200AF92C9541F0F
      3A1E79BB9C95370FAE97DA9EC9F84D18EEA682430DFCF0886425CAFB027C469C
      7E8355FDB1439F145B13595FE2E0D0B800B138E5F2801774047C1178B2883696
      0BE341F3B1B8182D353B8153067B2BD6692A7459F0122E9B28BF9DED740196B4
      30BC389A72712664FF54127D1A51CB05E0C2B2E6C0BE200720C81DABAB05CB95
      171B428E67236C06B99F99D7298F99ABAFBBA3D04F016207E863F40A65F6F591
      AF38F24C3E556437425B9FF6CC53B7043A207D53553E94C04BFDB3E4792FD750
      242B7FCC461D3C2A079202603F9EC4E01682C0A57CAE1F46FA7F3F16EEB5AC94
      CB1D44124EE7BD60D78E0BAB552F4387A0C6F015F64BEC0721EB7F6BD496721E
      D25024916C5547C3A2EA9AA13AB930C08ACEC9C1D817EB68667B0CF9852613A7
      AA8DCADB08703ED92B3AADB9612786043DF868C26D8559B1F5CA8D557E19A4EA
      367C41F2AB7A5AFEF8C6435E347083ABE81DD9EC7E0670AA270EEB9805F317E0
      A387C6E20BD74A0EB0CB4BA5D86A72F0FB29FAA18B3E62A52053FAA3A7BC63F7
      0730F633F72F6BDB68433B28F89B8F6512243BE14BBEF7B4D839267BE0D0900D
      D2C8884D26B9855790CD4185EF1261AA5578565149594145DAA753EE94C07608
      C44BBF5C9118730179EF8B4F00691A44139115650B23AF94F7582E529816FA00
      B0F0C48A3836DCCB6CE3720CC2AF42EEE2AD004C7D992A9B625E97A9EC5DCF5B
      FDA81BB8238C5CCAC0ADD39468351679B19BFB08B3135D00CC348EB08DDDB121
      8E47C7ECF32BB4C89137511A5720DC907A47719583083BC8E0A3E86CC05839C2
      3302C1303B98D48885BBD5491411141AB0508C97C65E83769055CC2D6083C483
      C3AA8039BC676F8845AE02FFDF189DB2EF72B923495E6A60A3CCCB81A70E54FF
      1B98B40ABB27C4F3F2F8881C7B5425E808F3044036CFD12DABF3CB70C1E664C5
      9DB9750BEB52A9F8797F7285EB30C880DC9BC04E6683741663FB1C69D4DBA780
      35D9AA08234F0A45945DE9ECB9CDEA3BCBF7C66202143E59385B35B0717558A2
      CB78435D01C87898A45144B212351F9921C957F175C655DE2C0B4B3CCC12AA6F
      ED66964815931D162A302DDB7A714735465851A17ADEE4192B620F1915D6C3BE
      BDA2E04007E4541E10B2CD8A3B2C27853B576888C0765C662CB4A36F0570F23D
      DEDDBD7FCC504EC45B569F7BC55338CC8A096C291C4005B4AEC56EF65ECF8DD7
      6E223E1196ECC922DAE425E947770AE56408984A882F846F728406F7C8E42031
      EC0393DDB1FF57835444AE30659C9EBF7D8B5B8F9DDF86483407EAD635EC434C
      0816269A97263F34FE72681C3180FF6C5C8B79B2D88F0D64B0D5D5BB51DBDEE3
      D0367478EF1D667FBD076AA636F04D7883627A96ADB3B746C9796AF8C91D6072
      912763A392A848814719FA55BAAEA20DAA2F4781C2481988CB82A99E1B32A907
      5E85C749964F718B85D9B39DCE6AA350851BBA51BA1212918DAEDEBB50DF84E2
      32F254E169291044AB2355366B10A4655C27977ED0BEB05CE52EE6F265A74415
      A478B8E16722506256E1537D41D2207AEDD5806EB04E34ACE43F59DD4C0C819C
      F98147ECF8DE0666AD29311A206BFDC956029AF31A01A4AA106DC25D363C0A75
      DFCB5EBB47A158AA7730D0DB39061E64615CC0F6005C6398480D804F441EEAAA
      023E8BEDFC58302EBADA65247212B1C0C3C1B7804E836B607FC869113099C52F
      E07054D80936C30391425946BED34DD76D4BF98159C8B20DC8B08576898268B1
      964961FB0A9C3C1BE2D52CCC87536C2C5F293B0FF76ADA180A3ADCDA71C3A751
      4C01562311CA985A4E1459B654D95B3EA1334059AB43341CA5B3B0D08F456211
      5003908C987CBBDCEE8413295C037B10E3990205611493868041E0591516FC99
      43A26102C8EB133E789797E79AC6D7F3A3EC4949F00295C73D0AA3C74BE347EA
      01A3532286AA6821C78850AFDE1A0F102E63CC120B7840EFD01F20A8364B01E0
      05A14A81FCD8782DBB0DABEEAEA40D45E46A7C7772790594BB9FD1812C50AFA0
      8AC9242E1A973C132FF1406137F662BD5554BC0EA53242225380917C1445FFFF
      B3F7FE5F6D2359DAF8EF3927FF83D6FB9E37B0E33860CCB7CCCEEE2140BAD986
      9005929EF974FABC4796CA58832C79241942EFEEFFFEB9CFBDB74AB231B1E84E
      13D4EB39D3046C5956DDAABA75BF3E0FC018D349E630202609B92FDAAA890DCA
      2A07F6BD11770F80B5349084D91A57B103BF0EE5A949C716F3294C1DA7BD4FDF
      6BC6D675A3E7A9681456DF080C413348952E3792738FFD54A9E0C26F9763BC34
      425D318B73081157D09A53EBEB92F8AAD36B2996446F2A2F354D2B00ADE4B248
      FACE15BABDB547EFC90DF22FF366556009EA000DCF2217CC7B2E5E6466F6D118
      72359F94A12F53A19F56F72B67513807CAD123D91B25DE3F26B4543875CECB47
      47CBCE6ABDF1D67721D3A91256C7316E8113AB9B8F29FCDA3AD3A3C9622AE3C2
      F923BF5FF57F65EB7CB9EE5486C223C1001EBB00324A4A36679AEF5A42A0B17D
      BDE2DBA31F68327E24E570343A48698A1FBDFAB6E3BD073A89915084AC6A5255
      AEC25A99AC8DB646B041145A9AB08459C25C98224CBD2BACAD1BDC81DFC98073
      4EC35A1A320BFCA011D97FD75A6023EA9503C479CACE863808366EAC2A6909B5
      232BB87ADEB04F80253859F8C15CEB424A46E70A3A0C7C80FAF9B7739AA5F204
      989B67AB5EE2ADF0910406A6BBBEE06ACB1D58421F6DCF13EEF0C612A8CFBF38
      7B36CD7DB2A96B10593CD3239423CB1CDCD337BFF4687500891EF4ECA05188BD
      8D4A664E8362DA1C49471DC96F504680A1BAF8358605904A753611D4AC6412C7
      F2D4A787B97675071A734D8CD1B455BFB4C2A015195187EC46843FA4FAAD62CA
      4933D475C42EACF4D16A3C6F555F8D51329F5D09238DADAC5BAAC4052108CB06
      25B17E752E16274650488D8AAD6527FC1412C894142B42B2E5A033E81E0F4A1B
      B0FFE5B23F923A3C3C3F69D38F6339BA8ED3C0E77CA1523F30100587C3A5BA2D
      36D349BF2F00952DF7CBFC9978CF01CA3333F07E7A7FFCB7B3D76BFCBFF5DECF
      503A36755A726F7DFA2F44503FFD4FC77C5E56656B7CC449704569C644860B3F
      BADE5BB5616C7F8EA8B1A0ABE276CC0E95CE4329C2A8B02CFA9ED66ED2CECCC2
      200D2D9554E560AA9FDD932C3B9DDC39E2B5D5606D91F94AEF7B665DDFD07B73
      7B27E6CE7B7C3A8ABCDC89F77481DB09EB84BE453E571362B9D35CC9E723B75F
      4E4DCA638719640D0CA50166E1D5D29EA5362717AD72FDD334C693A6AA05991D
      9AC78CFA260CA7C3A3A46C1E988AABAA06C7D8885BD1D3F8365456E6D1A1CDD0
      E31CFB81E4C4BEF2ACFED7C279FD8ED4EA3B51ADE5145B624D996B92C0A3CE76
      DFCC9B80A5B6BCE7688AC64BF578573DB258B428AB90D4A13F92906DB589B3D4
      1205FBE5A811F183209D24653C7FE487BC9F1F961F770F51FACC1AFED395AD49
      0A36DE71675CDC293E0BD9EA1CADB4DC10750166055C6ADF315EA5C93C8768B9
      597A1566B174BEE3B8F006AE0294B1F55CC62691962A491701EA5A5859ED6BAE
      9E4CAB9F6738CA3A9EC5FEA1279BBEFB2045DA0387A558F37AC38D2CD4AF586E
      8F2F4FD84F1F4D76FBB357D67896ED0ACB1DB100E26B7A01BA1C4F6E29281F1B
      7AE61F98441C72819DC2C7B6CC5F6A45675063E595EC780ED53E2D799BDA3375
      C30ED0864993F0114FE999B8C4756EE34D5036DE7061AF8600DA1AE76E7396FB
      F133B5686AFDE653F5FC194D96ED9FE13A752947BC2BF5DC76B0F31CD1D5250C
      2EAAB0E2C9253D0B5B2AB6E4CEB690D4C2F99F22F7AC94FAAE68674634F0F62F
      CE8EE14D0D4D1C4EA3BFAD2EB5FB17052C6AFD2780D8FC2C7D004BA5DE44A5CE
      B9EA6FA121449D9720E1A444E99FD83876C3CA16862276250D9A5467CFC569F4
      796D5B02F75D0782B7A297B405C875CDCDF07F70F585363F7C4842215BC25F07
      D27D520667B527B3A559DA96EBB32CCBB65A251C2D06631B68EEFBEECE373851
      788D60CF7D8B7532FF1CE1622E398FDBDE8783B3B64D841F5D9CB44866FF9870
      5F0D47C1C746A3150BBF6A830BE7F359E34041575C359AAC5A1421A32155EA92
      65390C22C941B7DE9C9E9FBF3A3E3DBD70ED51F480287E9FEA92AAEDDE8BA295
      E4BF743E4D23D84FB2041ED0C06B9DA357132B50D714AA174CE2AAE9188E821C
      A41275DFC5104972163834482F13E4FF56A5DFDE907BD53AF250FCE4FD385C5C
      415F78472F461E574869A3169EC2D6305A240E328F3208067991FA6D00E895C3
      9C4A1F8134218A4D68E57CE0DF249713F875C0EB630A23E71DE6E984BC3B3FCA
      12946BC621F3D40BEDA62B358025A8F18F4BA58FD7846902B430FA2D9F48DDD5
      0B14DC66C60F6FABCD181B9D6E679D0557A912AF42E7D729281C449F6DA236AF
      A3BD4CBB44B8C434A18281152A9A2F4A437654ED5CAB9437D85E630B2F042348
      EAFDEF1EF12A10BA3E90A29CDC947043B61A238CAEA37062770FC37757803BA5
      9F1860EC5C27A9FBB97F5BD8BEE2E98E6BDA730FCC9D951DAAD551EC2F4656C1
      067305B8347FE124E0F2DF68C01A5DF8A2182DAE6C87C0A218F9090A4AE82C1F
      92EBB082DECB28880A3D4B6E15BFD456BF54DEAE0095931AD343CE6AB22534D3
      82E93AC8FCCB17C98B03C0EBD0C2BA19A653B9DC255CD39C8ECB39004CB62F68
      B6B56B7E946DE197D007A6660285EC55FA82A194B4AC54D956A4AA84F4EDAAA5
      63B3313C0E9227DC52B5DC0E5F16FC498ABA3A126B56907DC12664EB3F26A331
      9D28ADB9C85B0DD913BF3B3D5891C5DE9F04B1E8B1CDDB741E209AEE103D1C50
      5F52CEA3654A5D9677D4D912EFFC6B3A9573B2D42B45DB0D59F6BFF751F096F4
      C3C5E1F9E6ABF3F34352B1353E117A6F4F7B6D74B6FAECA69BF0D2584E50FA15
      505D57B94B27561A75C92123F3C8F2D393B10C9E199B8961FFCEDD535D932A69
      8D4B5F263A9B6D60F75974DFF2ABC1C4C55DA1A1F95CF69F09EA659497565CC7
      5B39B3DDA2773C263161E152A1C77F30E8AC7A7B12A4DCAFB1DE7EA813F8182A
      A8D0D0EF47DCA99A0F278341CC063B19EB16D70015E6D67399E1A19919B2CAE3
      46EA3B81770C381E7835D2EE51ED169BFA786EFBF104E787DCBE01F994DCE91A
      25006A91C6A9A4E230BEDBFB7822CE22ABA132D4159AC204459BFC0D72B8B9FF
      84ACE74A77B4005CE5931A525C5CA13E80E306264A81D0812753BFD16E66E1EB
      AA0E98CB29CAA5C918981651A012D7B5995B2309F81EA153DD7425ADB720A509
      2387A5E0CF3867A77285C8B0F6539EDDED552E6B09549D49730FF724922A939A
      DDA99E7BDE9B76DB3CA017716EAF7F9DB52D195EC6FE23F95C4CEF6A96262FA0
      953E597465F364317B1DED1086CBA17F2B9AA53217A27B56B1A2FF8EA3D1B5A5
      3A1C2BBDAED20BD8F6A08C85CE8E05A3309ACB43F4CBD3FADE16B40C2705A398
      6A649BA72F9B8C97C54076F96B85BDB169266C460DAA3860BE3ACDDCAA6B94F4
      1A37056F498962C3F3D1AEBC888665F94A613129F9B82BC8ECA03563B9A11137
      E114A58D75B8A9D4DA08B9AFA3C2D6EF9BAA811ECAB87837E1AAD31F109A2D66
      314AF207039C251E3D0A096E08687800FE4C182BD412C3246581D5625754166C
      FB0BA3829C2B0B794EA00ADE6F944C969D91357AD8940FB148D1DCB7540AAE42
      704632653B1E361F6986103BBECAE3E27D4F36D6616EBB1BF4451FDD8F4707F4
      E62520662E86AE1B10B0B9B0105769E715C503CC8CA30AE44046FE914372887D
      C63661828C15B62FFD20236300CD9800A55B462717EE06EE10210B2E2E7C6FCC
      3DA41C365EEE0DB737F6BC56453C9C1DF36D9A550BD845E90BE3D1E278CA142E
      1FDBCBF6E0A57D718343A9B849055425E5A4990D2EDA04EB832C6472BCC8A7E4
      4E3AA4840562083767E7A4756280FECE75BE9AEDED784703EEB6976ED4D947A9
      26BB2BE98752426D71C7CAECC39CEFB0E0A6425D96B9B86BE536752C79076127
      3595FA9CF6F4D407B54C144029512BA34BCF3EF7E2FAB04FD837520F50DD3B82
      BD44877214FB99809828C16B55B576BCBD3BB07F48D1541EC98959E0C2ECCC7D
      71BF961ADBCFAF72055B4B6A7192D3C3CCC883A31A95A99662D8912B30951884
      054AAD3CCF83B53AAF16EE02F7259C6F515CCC4DE5B1DC5473E388E8FC766591
      55E8DA39174F8FDCA13967EF0CC0CB7C9395BF78877C589CD33101DEE10F5CEF
      DE16163F7B15EF4B72BE7BDF99E00AED32852CF3B08EB680D42BD2A0D3EE012D
      EA02309C8E230568AE08C8D50556C7CC7324093D1AE7DD55C60034ECA23B8E42
      DD0133CB6DA68805904991F6E1A2D9D75E79A34CEEFA88BA2E126EC2BD943E43
      A93509A7BEDC422645AEB6646592D7389DA6C699D9EA3B323A34908313BED499
      435156A58522CF2AB9CAB0CCDAFE9AB5CA13C32DFEF9EC3DC4EA717C773594FB
      F0AE56FD151A48C21FF8BAD14870C5F92B679F0E2E1A637E2E2E8AA0D9D45099
      10506AD582D5740FE8F53876E18B59A3B26AB15566884D3A20227CC988AB8132
      684A61D2F74460DC2CFC84F18BF5F49A918DC06ADBB52FC51A5387AD7C148508
      62C33AC7515B65EA53B2005A920E5D77B29299BC576F56E8CA3752BDE37B2CCF
      E23D9E7FEF4D476E7249DBD576EEE02A7CC50D86CDE08997A8AC4105030A49AB
      9F06BA53C188BB0F1C8A1E42D3C2AC2E6F6817D62315DD41D2C7C3AA7540E731
      B71EC982632256D26EAFF59203DC579EB2ADA39F1EF7C36384C6CF23DAA23594
      7035BD7C8933274B2797C3A9CD4DBAB1F2888EC1CA027F7D41194C81FFAA2EB6
      533723295BDA44FA8F14E7CBFEED4BD706C8DA5B3879E81E4EAC22EF99D7EDE1
      5DBE3EB3847E44349EA96CF99A1A7AB9868D8B6D32ABF864C1A308B13ABD7CC8
      28CC89C4EC38138FE0351E8AD57655D8E864FA556BE1CBB613E36303D2A58A40
      3DC938D6032A554B8D99694F9C1E20786745697A698FF10CE99A9ED59EAB9E25
      3A7330D7F572AF523932557084EF7DA85D81AA3ECBDFC4C85C83498CE5003A6F
      56845949C2C027EED4B769D28655391D5E0C2048BF4F8946230065295209B653
      58082F6BCF420C2F0A01084B2F0DD74E002780178D3DF867EECE927772CF2553
      27E2AC533BC9D3AA47A424F418D75FBFBD2C7E9E96B2B772E2DF4EB52ACA9CAA
      9DAE87851E28552E4FD7D850558DB9A988472D44CF8105A955ADC9C7B0B3ACEE
      FFF2945A0B9F5632CAF81C787305DBB2B4EB97E10C01E883CC2C498393188448
      D25ABC894A37A90411458C81B6072971234607364E5DED649FC79F99AED29C65
      A26E03AD80425893436FB80AE0B66A550746924F22C9B15B24A05CE2FF534E99
      57A139C1ED9C562ADD2CE7707289ED72237E7112DF70568593F76059F3BE37F1
      B8EDBD339F27399DFAB43EBE8B8AEF27FD36FA0F82C549DA2C6CE384A1133E33
      48A6F89766591123DBD74AFA3E6EA499FC99F38750567D132521D89565926C3F
      CF7F7D023D07406559B49F989345E5EBCD8E6E665C35EBDBF8F96930D3A3E2C1
      0E36BC4F2FFADB9F68CFFECF9CB91D442F37B63001DBDD074C328DECEF018F8A
      3641F1199FAD31ED71BEBE3577EEF1F9A730FBD855DE4B7273996F7088BFA0E4
      A670189ECE6CD658CC4E41D0A890822AFFC6962F07475E0C4F8BD68E000F963D
      964B0D529AB2B5A0C4C1CF260907E6FDBC91B2118D498261FF8C6D6798BA8348
      FDB918653C051D6B744CA46366BBAC3890566C658D8A74A4486F481325C22707
      6907592932DFF6B5DC64D7F01FCE8C1FBF64AB3E6046B03A314604EFD884975B
      0AD315BC54952C5060BD43B42CA3E43B628182A2A481227CFECC9EA82FBDC378
      C46504D9DE8717F9D4495BD129DEDF8078AF56A2B0849067322918B63FCF951D
      B8ECDF4A93CB941B492600BD9F5A9B764D2E2DA92FCF9164248437EB1B89AAFB
      5544D5DD9E2FAAEEF6D7129568C8A55D58E9E71664E2A9CE4B8B6F6CB9D80635
      CC6FC91B569382C9B4B4EB254C34D2E50A95CB104BEB80F18EED13657A770D85
      5A10D9FA615E0462F4C3ACA6AEFD2896AA63DFEB83FA00255F6027B43907295B
      63BA0C7E20FD7EAD0E4B1560E15B29ABA6EC4067AF2D37E14337E1F41E5B6CA6
      C8AA9C15F857DF87A505FECDB662F908F7ECC63ACFE0FC0164F69153246B272D
      F5D90A73EAF63A6B9DCF6DFAA78B7F3A9DCEAAE403E593F9E236C2E7CF0437C3
      86CDA50C850DD01589FF7376431221AB5A175339E0B55854950F5779464ABF66
      694205247E66061D1B8C124E2EEBDC169587AB7D9B9951C40BADBA1297CA4BEB
      DCA6B6A7ABED0633233D70CC51252C3A2B4CD99E0FD995DC432F9B1ADB022D18
      58CEB27916574AE3B1B436C169B09F3EFF2CFBAAE4A52A4AADC26446AA6D995D
      F861ACBB0089E0987106359481A521CD1CC4FD0C5FADEE58699B620956CAE8C6
      319A4178EB5AF1E17EB623846ECC29E0AA8AC73DE9DC18F989C43366EF5F7B28
      4AC8637BDDD49F5B8C9101ED247AB4E2C875BCB7E2DC891ECB2B0556D74A451F
      E5DC1D5D0ECE8C4DE27A91586F70E9BABA95AE3067940AB71B2A5A26A4086F97
      5AEDCB33B42FFDE7344EDA0C08832DED309BEF367384E3ADC841CCBBE83AF267
      B8E3E67439AF56C2ECA8461892401E502703C6197E8CC5453EB9A5F1A3F3291A
      4D46FADCB44D867EAC1599DA42A76F4D81D0A91D50FFC9AC55E628A2B5237699
      14B89B14D87ED24981E7CFCEEDC278C92B4E502972C728184994AECEF299DE34
      7ABEB9D0BB900AD337707D9330A2B3BDAC3C9C5C1653563748F1D3935B4F75BA
      CE232693D750731115B1C3FA58A9A2F7AE4A71E0DDCD69CBEC47DA1B20204E28
      C04193F9628C1F3EEC69BDF51967CD1FA58A93A4536B992AF989F2E81771B4A6
      1C4E3769DA80AEA93FAE18C5271A3B2F1750D832314E45164E1AF91724C1C590
      05CB91B57E9929B2142B70340352FDC99480F96B4441BA22CBA96FB8A9D1F4C1
      774EE3B8D2A1D738D19F8F50B1F912E5777D74916BAAC9CD0AB7A9CBD6E9FCEE
      137464DB100A10DBDA2FAA6C120FF0A946C15B49EF1B0E39541EA8841662FF61
      E6A375CA20B515F54B0A02AB669CA53074997D0C654AC36C925C7979AAE5C695
      EFC5F02B741B5F7AEA072FD1392B706957DF9367C70424698908C18868A37141
      A75E7AB334B24B23BBB54054AD1A15AE53CEB44938EAF5CA85BFCA6E97794CCF
      53D6FA037BB8B9256E69EFDEB577779EB8BD4BAA9F6B8F19E41091060BA7972B
      ED192D9E31B8D780B88BDE3F5A88B637D962FBB37D47465B31E1BE903726892E
      93F2DD14CD7908CE43A50EA3303449038FEDA38198EA0EB3F85E41D569B6D42E
      871B664D1D62DF5BE1AEB62B5B9E4526B717C159B882060A90D79AED603AB730
      C71566CA9ACBEB84365C040827C4F2ABDAF20BEB6C7938DFD3E435B6ECEAA1A1
      B52B060FF39F30F5CA94A1E39A77EED2DD2CFC9EA6200F3E0EDDAB9ED2AD8369
      997F74329F432854A134B0E05EFD5B0ED88F7213B4662962BD0311922A8FCDB5
      8775672A78B3D8FBFC5C1C581E70922113CC60149883FA62CE0A91FEE6BB6390
      4C213DF7308D5DB3367926396DDDC9589202377580E9BC2B73BBCA40A310A1BD
      936603D59C91C7B63D382E42E38F987F0B1745A3FA298C735368EB1176CB9A4D
      208884041C07E55D5CEB965620C1B817DBE171B3142247A9C68F87E24BD7DD2B
      B2E4FE5316E55281D5516020A2DE8B6174F8F8C9B158BA156D2E8B54BDC4DF98
      A78020B31AD1967B857A9FD611E0C16C527F7B55BC88B63749726DA4C1D7E5AA
      36C81C0805176FD5953BF0933D288940D773092537ED90EE4A99F9E59F6ADF40
      8A203EFB00916C3B8E1AEE741B2B3180DDCB6CC6741D53674ED6498A14AD2268
      452509C8FD8BB25C78C5E7DDF52DFAB9BEB3D1A57FBADBBD1DFA67636BAB47FF
      F43677D6E89FCDDE2E2ED9EAADE392ED8D2E2ED9E9F67AF2695C42AB7B9B6FB3
      B6BB8B8BD6D777D770D57A97AEC3BF1BDB3DBEAEB7B5B9F5BBAE761AFCEF0DF5
      BBE7796FF0FFD9D9BDEF7ABA78DFF3F6EA5EBEBF542AAC54C45E775BCB6EE3A8
      823485A5BF5CF88FB7F01FB0E2F1FFBA97CBFFEA6F106FB9476CCC1F65337C9C
      71883CCA045A67C5423596616FEF2FDE74D89B371167B41F992D6A458EE1D55A
      18E934CF5F4D5CF0041E7BAC6A4A7C83C14ACFA1E616C5C242BD9898408CEE3B
      65E42C5D81F9727C5BB281B1EB77D12CD283DF5B019D26A5575CF8FDB6D06BDD
      4DDE65C636B4A3C458911C94CC267D6065CC113893AA10307A1F72DCDF29B0D8
      2B4C17004B1E544CA8F7290B28AE8C195BBE5F2402153E460B8971B17ADB82DC
      32D5CC27EA186149443C7C010963364FED03CED2F441D4DC2242C4D3175EEDE2
      6F3C000E870CA338A447697B901AF926B9C0CEC8F3BDC8DDCB0861C88847E8C3
      AF30AB3C040EF422D57812492798E4652DE895B91582EB49BE4CECCC49ECEC3E
      E9C40ED8ADDFE1F0F8775EF576C3E9BE011FDB939BD2C5632AE23F7DB4C3619D
      D1ECF11C264A2F0C40FBD76E8E5EFE9BD58BF49B1B29FD2EAA3BAB534C513DF8
      1A24917D09051FA437C96B89385BA1DC33E990DEC76FC470D4441BE9C8D24804
      38FB44E3331AB5A2594EC9B28697FEBFC272127CD913584B1FC6AFB038BD15D4
      4DAC7AAF94FE4296AD7BD31E9DAB7220EBB9CAA5499996F1E7059917EEAC1550
      4D0DABD60F66F273ED8561F9388FEC341D25B9C98AAF4BA155077CEC7E09F7D1
      1DE207255B8B385756B4F35BF82A3D7C3632FE966F99981BAEA9E35BD4582996
      16537752CB5B096702E2AB526A3652F2524D559D4E95ED440913C884D544D923
      4F2C38D21FDF11969CA2142961593FE5F5FC80813F70438760B75CB4AC71D1F8
      AECE589E7B5F6CEEC9D15985E034EA4CBCD8EF9B38BF73EC2D4F3D57915891D2
      4AD9928BB8E4C21B20701955430EB606401ABA79E0D3BC5AB6FC56703D5DB9B2
      254FE3DDF0B02A866990CE0C4BD617D2E6A052753D9BBD48C292DF581EA6B81D
      2B94374C51E9C0CB5D8F13DBA468C14B61A732FACD7257D6DB951278A0A3314F
      2759206039E0E051B2E460E11D043ADD22032B7150EBA70363C63FD3A61FDF22
      BE6313B0AF90FA0612E1928FC3ED72CEBB5748A9FD3BD25B99129F887AD58911
      E0775909E03A0B528F14BB6B5DD5989C7449F98CAE27FDABCC58AE597EDFDB3F
      3C3EB685FBBEF7E3D9F10107C1BDB3C3B767E5EBB86A55C1056A8C333160C8F0
      B3DBA9F02073CB2B3B3A827695A567790348E1D5EF0DCE0CAA80F229347A8784
      15DADE21B1FC54AA6A02E6F3BEBDC2DC2E1BA43EE3217C67C47051905001D2B0
      5549B69D0DBDE8003E734F639B432C02A29F5D9A42C044579CB65ECC688638A5
      60BCE7AB787C7F66004B8D385F6E15721711DF524D893192BA0EF7D668564625
      570B9DE2C5ADB782634480AE5D65A010F458C4126CFF2C65C0EEFD1F5619831B
      CAAD44D89E22DE94C3DC848F190F69E2E26D1D257F274DCF2C9B79758296E7AD
      5BC85F9491B7E2007ED476AE530A3BDBCAA3D8CF480D590B7C4E2DAE961568EE
      071709F19C6DFC7BE70E7B4742CCB72D52778870A8E2EF52C66F2F5DF98B3B4A
      EC4BB646CEB7AC1FB671A2725701CC67087AF236B8433708985F973BA1F5D1C6
      9919449F1F406132767D82F58EAC6AAAB2205B4168B90C23624AA0A68FF1D2A3
      B03B04EB0600D74ADD2C8E81CF58F45961633BF2ECABD63815440F6B343DCC9F
      E1C2627CA9B03CD3B06E4D21344FD3841A7A7A8BBCDBDC28C1A0E0A515249E1C
      BD5D9FF9E0473F83E5F25A12B0961D8B57D1BBD30B4F791BFCE41610268B5314
      CC032C90E26C928D1468B9CCDBEAACCB5F51A6CB1A34C74B33628126561B3E98
      F180BC15E157A23F6FB20885AFAB4B87684641DF1551ABA4539FAAF5B7D46A0C
      777FBFCC9DAB64F74CED1DF7AE4257E717337B0E7A409EB2062CAF91AA65A52D
      ABD6273BFE8EA9DDA686FF43E1A8E60AEFDA0735376B207841B643FCEEF34C7D
      B5B2B5D122B964361D747945D9480E31A53EE6B6A580653CA86840A522C0F964
      9FA4B03004FA4926A7B98C2C0359304CA3A016ED09581EFF6672CBBADEE223A2
      F52E752F3C54641AF9289B09EFD2BF5989CD954115596C8130D4AB5CA94CCFB4
      C0B9EB4E3F76F731562DB6D897E70DDF574392F248CA27F700F61D89918BDDC1
      E8C8B386549B19B1A7221AD8980FD285927BE64AA0E920C5146B675B39A5627D
      945418D3A2C2F9BE5A5DA4A2D1792C3F00EE00FD7AE9FF9C912C4367D759954A
      CD5D7E556ECD387BA3BBD369652FF02A1FD533DA57CF487CFD69BF8A6EB9FF03
      1E5A3C30DF1BC793CB28A90ADF759E8F267195056D7950DF7350733FACFA0360
      7D861A393C3F5E9EC63609018D68CFBD82696966BD13DEC6CE30FF37EFFFBC7D
      FB56F8FD48ED8FC6927B5D1C4A768ED048B09706E42895B7FDD7BFF07D3B8E68
      75408EDA34455591621790F99BDC759D1E4847F920537B6949FF9E1BF48CBC6A
      A648773B948E86A5BD3CBD43C71AF80693813DC2DCB2CDE9A6CC26450EB68BA6
      55526F5F0E89B07D759F967C621B6AE16354775C2DC0C38D4A4C929F16B61E29
      2754F4F111CF6CE42EFEE2E568D404A228DA3207C0F5A858426214CA725E0217
      2D94FF77263119593EBF182EBEA6B963930E6BEFF4DDDE89AB9B6B8822F87D2B
      679E3F7BF936FAFC1E56246DDD24305FB7286CE164BD7AE44AA197EFD2E9F13E
      7FF6C82386627CEC414B8B0D56FFF4377347E31F7082E78FB632561AF8EF32DA
      AAC2513059EF52F4110A122B590209C52F6E3419785C7183136B74C2C7AB92E3
      30A5F1E8F0FC241A2C31A2179791C5FE585204EFB8F5C6158FF94BEE1C31089D
      5CAADD66BC801594F9A7973F7BF9EDA89FC65A8B318DFC1E888CC515ABCFA2AE
      3383304C4646DC9896B5447F14AD4BD26120A248B3922DDC157AB1BF381EC791
      51C671018EA1C72B31D1D8F91BF9B7759272126044E9449A5DA6883F4E23FBE0
      D1D061E6F0DAD580C37304299B6B7D3FB86262BAACE3AD48FE472BCF34C0A70F
      EF71BC07EE2A778B266961695C2B956AE6B3CF3538F286FDA465F5E0EED3A828
      E13CC85F15B41CB9A1E34EAE87E3618B966D9A5DEA7A99A1C0DAA15804512DA4
      1F92505294B1F6D0B46DB5A02C133BDD1CBEBA33C15CBA47BB89B940D2A45498
      72BF43154475FAE1FD93A57D6897065FEA1795BB20940CB7C0F849EE500E50A2
      ABA9C2F0CE5C5BD2EA5940E787B4526270D504256F273BC67A896211596869EC
      13DD28249530BA8EC209B93D76473067ECD457E8C5D58FBB499873838EAC8572
      2BD2FD827297FA72CF954A8DBB2E17A576512068C173F2B976E9CE77B8B9E17B
      091EB3E1A6206E899CBA479D38EAE224B1CAE20101EB2306C7896C9FA7DB055A
      3E4A1BA1AD6D9C5084AC37FAA632574E9D494340984EFAD5CD64EBC14D1E61D9
      A36297EB5BB996764DF2D4554C5D2EC7920C7B3E178D4FF3CB28925690423FCE
      68CBDC0A3E77F5FBBDBBE00589A4CEA31AD2E6C48EE2EF6064AE98564F0F9A56
      1ACD928D67519210B51F12A7F42424F116DAF67B9AB265F958A596BD352DA896
      D3FD36A4534ACD36C03B444F5CF3BDF9FC30342BF4270A621C43E1A899A3FAE9
      DFF998998295C63BD2D158ADCC9C9A59BC71C2A164EF4FDEFA72637CB906D64E
      688D5A1467C7F3C15DD64FE5AA1897FBC8ED2367D23B6C278E49CE6EA11B7B86
      9719D44A595AEE24FB851235EDD61B71D6877646D5F8119CC429C04909D8C236
      61B029BFB8FB4C5A8966D3A5A9B57F8C4FC75C8DF19723C023F008EE7C09DE5E
      9E590B8C59DB863C20A785FD1CAD8E63C3C455C72DC1E165D91DCC150EC80C23
      B19C33C35E45C0DE5086D5ACD12184FE7D812594AE79BA5AC919392D896AC04B
      E3A190C46D6775D35B7981577E725FF833E763EC471C6851926AD393BE53C713
      717E267DF1A502B3ACAFD18E221740AA1EB4E50B4F6F7D355A329764DFE7D561
      59EDA18C2C812F8DB4EEFE96490641FC07F78E3120BA70706B992CF780A54233
      313B1B23FFB652364E03D1265E3DCF9114CE6FC9F91CA168B3B10A626ED0B55F
      865D1FA820EE8DBEE2C9515A3B1B79FD5A4A6AB12F08E23C3E4C4876653876A9
      91D410586C543D7A76E2BE35F3FBE311B8E55196663AA348EDF57307DF6D4B10
      696D71489E2BC8A151A4484473CE70CBD50D9F2A85979AABBC537C2E381EC901
      83FC2A1AE7F6DBBEE36EBAF2FB38B635E569E01BA58E86FCED28741F5A56832C
      4A09D32C1F47C995F7CA7B7BDA435B1DFE5AEA048596AEC8C4D606E2647FDB3B
      3FB42E759404F1247CC0617CA4113E5B6B98F3EA65BF018D21A73DA9C2D4AF96
      00B0F0486BED251737338BB4BE70492FB4678A9FCB2E0E2DD28CEE845B793322
      94E816C197D9745AEFFD62D862083D7545E009D58B43E26ADBB509C3A67EC70B
      6C40FBA4611BF6995FB10EE7F85D20B24DA5DF4804732FED7AA555C8F9807083
      48D1891C7C1BD57E98A5E5CA7180CCE2DAFE856BC5253A791D61B2D1CB22F538
      7D6B8416D602C500CA6E2566D6AD5F6DF34D8E2B3C316DE1AB6F7964CD62B823
      D3309254C8933EC1BF2E06ABA5E39C5EF377373DADAE33B79FC0846B7737B332
      CBD67F431E2DCAC5E9956328AB855F9F2D0FDE0507AFD43ED82C6935A127A184
      328B3B883E2FA99BDD911CA31DC0D312563427CC1557C5711DF9A1EBFEBF236D
      D7F762BBB149FB5E3EA8A8F128911AE9C057B25770A96B779576AAD0EDC950A8
      94944E123CC865C295784717279CA2E51C994553ABBCBFB86E8ABE68120C618D
      3CA4ED44CA6FA280CE783C6F948F4AC559E911D7EC31A2A24A184342D7153495
      DD9A27DDB6E3B1E44E584B197C274B70631BA83483319B0555453E0703879E94
      660DDD58CC3C53C2DC68FBAD7B54BA658D6D8995D0BF0571BDA635D6CA1ED5CC
      E4B811437D889B71FD2098DF2F4ADC1DFC22EB16C972427BE3DAB4E6885525C1
      90C6B83CF73E9EEC1D78EF33446F0AAEF81888EC5AE74536098A16C268AD3D46
      E2A6B7EC8B5C9C2235C023830D5575D52EF1F23DF7A921C9E9AF6A830D09A3CB
      FA5191A15F5776B060FE1A29B066058EA29007F4F01E15D6109F326D01210899
      AC7AE741168D55355404548DB37F38F256FA647001A28D33F9A03CCAFCCB17C9
      0BA092D56FCF9EED393A4A06A94BBDD12C861A19C42A13D38EFBAD86CC8BF7E8
      C6C92DFDEFE568F49264F52137D96BEF333D70683EBFF66E1FBD18F21BE0E3BF
      4B937A35BD5FD52C5B89A4F6636D5906B040541FD81985EF966647078CB51EFB
      97725CFADC56419A9E5BF996B691ADCBB9383CDF7C757E7E682308AFDE9E6E6F
      7987074717560D55DA2661B19400826DDB2EEBD827C7599466DA26198C4FB5CB
      F401AEB0AB2893AA48DB722EA6187F3B0AA11276C433724C6CB4B16FAAF60F83
      2DC9873BDE9BC9622006142B16D39112A9B0736B49629AA0A913AB8B21B83239
      7F3559C4D50A59290C49F832A76CCB35DCDAF4ABBDAA7EFBCE5E19B9213FEB12
      11F922333E9D53F62111CEBC0157989D295A20E55CB13C5CB0C68A7256909CD9
      E1869AF2DB84539CC30EBF46927263E60094B84A9272E208B8DF18C054E92767
      9C68C32E55DD97E5CCD976A9500DB4179E5CF4572C6FF49BD1925CEA38473A24
      965369E14B96418A31EE116274D7B88AEE7BDAE8EB3D2FEDBFC78F839565E762
      8456F07C56703E484109AAB057ABA1D1721F4FE103D9EEC7C5DFFB25F9EB225E
      EA8105A782F81F80250064E40A66EAEC145E0CCD27702325355086BF570021D9
      F6F6F6BF3F932288B677BCF78E2E7BFFDD995EFC6EEFE3093ECE77BC8E7CE7F1
      A48CB4BEB25A0957333732BCA5D5A5BAB1269588ABADF993798EE6F45C418AB4
      CD7A6ECE2A59951A0A8391777057645E1E105AD01CACB59F1C828AD004337E88
      34F631AB3860045276C3FFE47D6E7BB70F622A9A6A362E1C88726E7C9A03F16F
      2B5038221D60954452A23D052324F68BE4484483A000C7827AADF20AE6C489D4
      E54CDF55C349038E4B4BAC5BC86013C376DDE21885A9427A3C20D6C039EAD975
      3077E759D804BB03A7E30EF5E14F49AAB8BF8431E82BBC152EF12355A1F0D25C
      DB13DF5AFB559B84D412A3D9177CD97669CDDD335F536D3BB3C04F95B98128AA
      61423FAF7144A4F218F5A3ABC2A2AB61992F293E81B828D73577BD47FA7D6D86
      B0E1E819ED2E9AB7C8A6E734CAC7AB90C69119177AC4E77E5DDA4FB06510B5C4
      2A29337E52E4C9C1A8EA2A70927FE4F8072BFFC70F808C0CF94C4B189D45C10F
      B4B2DA16223F4A9CCEA3E5C9BB6071B512B689746DD92DBB3CD44B84F02F2B93
      C418D1D9426B2F501F95A9507C6FA749243C11B6ABC72C47ABDC1B7CDB2A7F30
      E2579940795AECEA121943990C412F9870C354C0479538D75C2BC0EA49F40EAB
      19C97A5515797F42E6408DA5F6FC197B5253110537308E2A945AB594591849E1
      E8C8522E966F597D2AC9ACCAA7C514E053CA15D35BE43E443944565C13568A11
      07111754DF68B50B133DC9BC84EDB273CF5A09A588F842DBEAC562C1076020E0
      1DB025721F7AF155FAE86482C2991DB70CF22E325C6D2A506654BD9F39AD1330
      AB51076EBB0E73CE2B4D9042D7C0E252BBB98E9679F2738A67854D69E44BC97C
      8DA31C3888D31959557A2465DAD4DC128220ED5D898BCDA5E1171B0B95D270D9
      C6233F1154DF6A9B2CBA535C0B2D2B1BE6019D6A33A95344E7801D5165A54090
      7E2E0E40E66C5681402C1F1326282CE63A6A919F4E8A4FCB6853F9A5CA5F3455
      E4651B5B4BAE782E9BA53BA04FDBC7351D6FE58D2019E1127E62C7E450010B28
      E524F6A81C398A81348D8679434F3119D76F6917CA30297E9BCEA6D3BA8802A3
      D6EAA5E11A345757E8CFDDAB75A2C8F46171D8CA13B47AFEF2F82089916474E0
      4DE000D486EBBB07D254FD9F3D3666001ADAF73561558F609D125BDBCCF57EF6
      D6E454A28D0E273FD6941C5ED2F80F6ADB4A85A0FDC47D1D6035F4E062B8930A
      D0F9F250F9B2A85A670C04DAB2F330943EB67935AD4BA893BB6DC5567AD5B860
      4D31DA06FB2183E99BC442B2DA5B8C7D706499C087C94BEA0F0C530810E7EE42
      EE7D1AA27E578F05D17B15940B6E31984208B00C3E3522109C02255359021CA5
      6FCED52EB4AF963BEB8BF23B3E3DF88E6655ADEFE5A6E14DF3D1CF982349A432
      AFF450C586E25A465A49AE501B68F234F9A7E582FBA274CF875CB3908AB9314E
      23F508514D3542A28AEBADC8D44BB3A50320CBF144BA56F3D2CE71F900D5C248
      140C18BC26CB2663182C3312D6B2CE15675B220AFCCE7F57B1B1163EC84D5981
      8E13234A26BC154250E349D343B55FB7F26411DB5BF58BEEBE305E57568AF5E1
      A5014A2A6D63F6F40A42898BFE5972BF3C20FC6B2193AF127CEF9C057B77B9DA
      31A7B48C22E0B3BE81BD9D87BED46970F3BF40FC0FFC3AEE4AE10A6DE96CD5AF
      C0238928ACBDAB8728797EE2B0449709A34BF90E5FD5D5BBA276472A5EC8FD2B
      868CFC41363AAEE967E99558E6897A311DEF6FE944CEE62BCE90F4E10C727DC8
      CDD25E5D90E44833463E623C97132EC4F55E95DC7BFA0A76ECD987040B488805
      F7E288EBE0BCFFFC707EB1CCD89605223355E095CEB71A37B0BD5925B0191740
      63CF4CFAD5741EAB133B15C7E717DE5F2A7D343237D739DEDA3FA7B700E7A7ED
      ABD5F78EF1DE71AA0513FCCEEA3DA9E69C1C7132AD2DF01A5BC0EE1985E53BAF
      E49AAB8B496A9FA79793FD44D935C7567D8DE53AAA917B709E81AED8257F6C3D
      CF756F3C26A52C35EB8C4E6149512A5D2ECB9D6EBB7319008461A9661B293481
      825C37CBD27294A4C2949CF6D3CF9A3D19546EC216441C8DE8572483A3B2B545
      EF623FCBFB3FB19DED551C75BD1DEF253A36550359547580B23F2CF7BD38F150
      CDDBB808943C6FDB26446C85850EE30E2A66FB1E2E1E3FBF72E09C334D4D30B2
      FC6BC728EBAD9C5B93228CF2805626BD653F52B63ED537EB5CE8AFA4050AE234
      D71EE0070FAAC6827AD8B8AB2316CE9BB4982E99B30F561DBD0C0B03B1B17086
      5660F8A6B6AD6614A052FD34F77FDB4A1B54B660C9BDC8E95B4C307948F50A7F
      B37C13EA43E4EE0E980661CDA95C590EF121F13651A6215B5AB4F87C80D7ABC6
      E42C3313BE6779082CF079796AD8DC6E9ED6FFBD41F94920812117CEA07E4560
      BF8F0627518EFDB4E21B5452BFF68E6EFAF8E5CFB48FE512FC05DDFB1A592CBA
      92DE394FB342DECC5F7B6FD23486B7F317EF229B98D53F3F32F2FDF3676CED29
      1B50A2B619B9847D7DAEB1EB6D5FD1B9933E0A3C2CFF32C9E0C30E2A391A8B43
      4A7618C8476A4006D257331599965B7DDD72A41A104973A6369F33A56ED22ECE
      792EF36F315DF484528D60794B2C3F1ABA43F509393DCA8FDF41BED24E08C35E
      4BE49ACB358423DD0B849CCDABAC4B09856872D069CDC7DD71E5A4BC31646608
      C4FE8AAF50A33C2FFAFBD79E863A6519DF8032A214C861127E182FBCFED7C8EB
      7723619841A68765020B4A73C1C8FEDAE27DA185F2FA937E1F9430DCBE3BE426
      25A38633EE359C5C1AA44FC746C2845C0583CB5F891DC335BFDCB14F6A05DDC7
      0F8207AF3E6D1C5DC1F489F21A9CE5E561577CDE5DDFA29FEB3B1B5DFAA7BBDD
      DBA17F36B6B67AF44F6F73678DFED9ECEDE292ADDE3A2ED9DEE8E2929D6EAF27
      9FC62574A26EF36DD6767771D1FAFAEE1AAE5AEFD275F87763BBC7D7F5B636B7
      7ED713965B717FDF057EED67B37374DFA55EA5A39A97F6BE784226FB73DD5BF4
      A155EA7FDFAB57E415D7BFBCAAB3CA475DADFD741E48B3EB5F8CE793E27D5AB9
      FA7DB7CE95A40D573E43FD9B0E22AE127CC853B066FA0D83364958FBEACAB54B
      DBD41E0D64AC309FDA21C2F0FB43135C1DA7C1D563DB29BFC3F1F82033EEAE14
      3E24F1B790C3CCB117463927FD95F32EC093E1A092582E1761A1F1A1860152E9
      8D70E56865A99832216B782867D8973C8DAFF9CB9190427DD54DC4BDBD022862
      E9006D311D38394B48B671A59EF4F17B057E4CB3383C1FFB81697B2F500DF5D3
      FB9F5FB4C5617A7C03FCF1F122E6CB60BDBDF93B49A18EFD3BB3B071F4F8DCD9
      971976092BF5E0ABF7B680DD2CAE4EA351E718B5F630A19EF247F7E2375A936A
      46A383F523F2D5DF46B9D2D8BFC1A0DFF98001F816C3D650856213DCA4D99520
      19C6FE650EDA17F0D4309FB9044FB90962AA42161D57CAC1B48C037E51D46F26
      974BE8B72F41BF654611DBFA93CB6AD91517F8598A31E0AB46CC1388120C10C5
      A3D68121DBE67C6CE1738436B26D6B8039CF69BF0445CC8AD6EACAB1FFEB13DE
      42428827F0D33826634067D19B95E18CF46A6A0D7E3A7AD4E967E6A10C36BC4F
      2FFADB9F0ABFFF3F7356D0207AB9B18569DEEE3E6029D1C8FE1EF0A8683F90CF
      4C9FADB1B8620C65DE0AC3E79FC61AFBE7CDED9EF7120997E08AFB1F00DC959A
      3C795188AE138C9CB8F8535958FEE4A679E13869945B34CA33B157A1A2B95208
      83D4468A1288904BA8008676A935B340441BBBDACF668D7A9B467DE017FEDC31
      FF7146CAEB7897C62AF01E760173C7E1982C434D82A04534E5503FB882002038
      2EF1F148917DB878FB72C74384D07B198C5F4F8A01FD69C1189B27957FDEDCD9
      209940242EBBAA856E7E76252570D2D1A809585E10AE858993BECD1B35D6C20E
      745A48C68FA661913491F02E779E922310336F6E50A0667025E74375B5529C8F
      D2FCDC2B6E5217CB0AA59CD4D513AE374F322497CD3B7B24330284A9A80AA334
      011A97EDD48AD1BEA06D5FD21711D07641E9471ED569239D4C9100354B563831
      AECC6D3F85095156D34409EB495E0F184E3E755E3672A438259C12E8A731303B
      9372890C26500760C2D59E95460E72072AC14E1C43DA0A524C1420D9CC29CD94
      84F022AF1E0A8D9FDADDEAA8F1E034BE619A45BF2044172B071B080E02C4F572
      9BF5EAA7459DED9D8E46692EA563B74D14CFEE1A8907C62DEAE449EB8DB4F6C4
      ABD61C84468E4ECE112A432A39FB8856D29AE9038BA79163C719D942256E1CFD
      62949CA33545E52045EFCD1BDCF3672BCE53E612B75CFAE55EBA92045BBC8070
      A2B4BDDA732D88B26032429B6CC04D7A16015B5B47B47542C3D6CD134D553075
      425F15D94995CC2B3E03F0CB3C59C6C6D24D5F4759019EE75619366D9575EA36
      FCBFE27A2F54BEB0C9F0B1909C96A7174FA8B3F2049C0B34CF08BDE12481F08E
      FDE47282BE9F8A21A144CD37BE803075C449C9950593D65CA79FFBAF3A7DBFEB
      01B82ABA364D5C70F3E541AE16795A7596A07A6C88B9C6AAAC42CF8A4A606BC8
      BDF5718A055715A07952D1F62A5F604F14C31E5FFD87916366E808B21C92CCEE
      CDED4A64D3A78057402FD32C1A5283067DEF76D260BB425C947B0AAC9250F974
      1D832EA044DA7CF603A1233262A970AC435A4E82E1E2006870A5E816025B2FBD
      81744A2289DA445BF87EA1260C0C8D845950E90428A14C5E55604C6EC70AE65F
      D1E9AAF86D67BC03CBF31D895DC596F2FA2666A010EEAC6EA0AEFFE7ADB5350E
      2A8EF520F4BD843C25F5AFFDF1D8BB56760409E0376F8473ADA83A56C3CBB249
      434B0ED20A7C8D3BF319840450237AD12429A2586B726DDD3EA3BF728681FEFC
      838890E4F3D3DBD3DECFDEDB777B27D837DF1D9FBE813ABAC9D2260EF27E7BFB
      4B56202E9D035F29506530267979584B913BB4756DD46F112A571F03D3CA02FC
      2309987B5CA407727F16BC74857337958694D5B6D77A97C2A7DD8BE356B90F5D
      52DB367B563813388ADAD063EE1E99EDF122AA088D01B318CFD8B59F0A1B611E
      151AC15C9D467D59DC11EADFD2019878196C4F66CA5A45DD4A3FF693060692EE
      9324174100E1C0AD221A32F7BF36D053B9D72EDAB721EF21C92098145A0522C8
      5802E2C03841AE714D497F2DE4E3AD76D2252F8AE649E51E999CD16E4947DEDE
      C7E9E3FAA6D2ECD7C0B1DEB3CC2F4EF74B276B5A6BD2853F46C976F3C67ABF7A
      94754DEBBDF596EC583E2934EA791385C590417D4A74F862AA65DF250FC997C8
      8CAF30AFF239461CC17D9AA91BEE91D6F747172787B9B7A296C67B72C8A3CFF4
      2A93E900F9C893DE26EF501289AB6CEF9D7D78EFC57EDFC42E6CA6ED29290972
      F48712D07E3A1AE3103CB79DDA6E03293C79050FD822E8EECB7AFBD1ADB7E609
      E43E71BC017F21BDF43D7072E8751AC26DEEEDFB35243CB6F94776133847F78A
      76543AC944EF8A45134CF28234338973D4C478E1FD0BC9A28E45793E11F455EF
      F3C1643496C1679384233E08344873372315A88E72645012ACFE238905450B8C
      BE2071CE80D352032C9353CD5941352932144212686C27EF20BF25498C24D32B
      BC007F24A94C173968F12E638B23B3E08D7D5A3D65CD57341068D4382E911B05
      932A8DC3862E977B6CD93892D60F0CF1F407C0921525E0E589C453CF5D3C9597
      8E53D82AC6BE19DA2C0FF36AF88C77C10DE98F5E128F0AAFAFCDDDD9BCE9BE67
      B217F7393C7FD63F1D0C68EFA348904EDD7C9F6E046B055689809666DC29CBD1
      6E8E1148CC5D3A763CCE92DFF29E6A9ED4EEDD249344805E84490DF2B8F66356
      9202B2C7C76F94B8EB869144B344A5E682C17239C994FC76BD3B945BE971DF3C
      49DD23A74A859D9152B195BFE07785064C52AF16D7007D80CC625A57827CEB88
      1C4346BFBF46A51EBD29B8B87F288B46D8CFDA8C80C0BF2004B50FFC0B08F564
      3AAF2E8D7C38BC2AA5082BEF63F6B2647B0250C16D4F9E86DB7422E83415007B
      9BAFE70DBCD1D9E86CFDD33FFD5303F32FF78744192EE89DB961C73D5C8C34FE
      FCD91D8F8463CF150341CEC7CAAD1105D42C24BE858B25CDA0E0CC630500C9E1
      0DB50E5258227C5F611A976C8782B9B7640A81B4256949E416E77C2D1FC83E20
      96D2CBCC1F49EFC51F67EECECF0F9DE1E6CA42640A547932E5780DA57287957C
      7D2AC2CD8B1FC2B40CE6BDDE1F478A7B1F2DE66B09D56FE357CD1BE5FDFA53A2
      4D5E6035663AF00EFC1B14DA6461C7E423AD57CDBD9E5445382C4B8465C45BFE
      C7048D2F7C87E649E63EB90CD3D8718D6865630D297389E895D10E1829F2AA20
      8B62C3044516DB5AC9D9743F8EA9B25C6E0AA0FA0F2052072327A4AF34CA681C
      0B41B4C311B62077E27B72295CFEF80DB30C38C7DCB328ACC0033E7EC3AC54B0
      919F08875B170A9B2E4DF5A7EF5B1625F7D6A88E999117AE807866F744531E36
      EDA3E8178026344F52F7471E4877787F920004A4C8B9D4EF856163CE71CF22B0
      5161CE1A4C516F68D689118259D529051BEE2EB3D4D45CFF7D4BED83033A1EA5
      F0CB494B1BC64F532C2BBC5307C06306D755176215867726EAC374DA427275C3
      EDEC5388ABCD13F017EC09A8F5975A4DE898615D65DB1C6AA50A1D5FF931C684
      47B5A12E58E70D94B2B3777642B60C64159DF04792ACE22C629155D158DB7395
      A096043A4C987C718DA615BD5F4108D76A3346EBFD23C9D299225305E3E55212
      A3771A5A97512906DCD7F7471245B5F6A0EDF65935D8A18B40999CA40B9A6BCB
      0A47550770049553F364F3CF5BEBEB28C411106EC677C096A913F985D2222F69
      2C79A3120A59F8FC1A298AAEB63BDB838CBBB70A64940FCFC19E3E66202A6975
      C2F248B9B6348BB85EA77923BE7F6304999F0FA5E3D90F02CDCDF8DCE818697D
      0647BAB89942F6485BE2FD6CB8D19546EABCC73E62DB029AD937EC112A0C37A2
      5F3EF3D7384A1BED94D7E0C3C2C76715E51EC4B7BD5525D563A1ADFABE8CE78F
      3441AD9F0E8C19FFEC8A36574EB56AF3BF11E513A08AD5D6C2FE341477C6697A
      2559601BD9E5CCB7A524ED1B9D1535910B60CA14726654C83519010EB67A5321
      3EB6D6D1D0F85E2B68345E9186668CA559647E125747F6D8104CF371601E0AC1
      D4DB9916B28560EAED0804D395C91008DBD8FA1A1C3D12744E848958621A1B9D
      6EA7FBEF4F6E717C7B989FF9085B4F07E6E7839AD4B62305F8DD6988B83857D0
      7C3E3FB4A762E7C9CDEEC2E1C9E0ECD1B17F71B05712CB377634414A07B0F4B4
      612C8C4F0DD8B9D38DB6F7F6DD47713C2BF3D6BC812A47246994CE5AF39EFEF3
      56CFAB82D535E8D185EE96EC0A36F7AEFD2C12465876A6302EE5F56CDEC84A22
      91C60E01E69F856AFA0A4FDF7D5052A13BEFA1BA5EBAF0945DEFF57EFD31CB1F
      AE7BCE46F1F53D78967C9BA770DCEE85618519BD307518E67269420A2C9CFCD7
      3886BFE2DC2F1CC05B647A0ECFDF3BE75AE0A4C8F71E2651C02EA742F772390A
      B9E34FCFD0589A915F9E63E959FD0E3DAB88181DBD7B7BEA7D87A2AC2737930B
      87425341BB0CAD2B912DAA0FB45B25331287F6F6F71930A97983C38323679366
      081C6866E169E993E5595273CF9DD770EED2ACC09C5BCD2BF968B1E6B828F3E0
      78BFED9D72432BC2A095770ECF4F9EDCF25E6AE1055AF8E2F07CF315AB62EBD5
      BF3F3CFBE1C9CD639DE364E315B9B23F7BEFF63E9EA89E6ADE300E931CD41FBE
      652010A002B40B23249B3B8FA4C121098617275B2ECB1081BEF139E9662EA530
      0C5189340C95D5BD81A37BFEEC40E951C2DBC41F450159E1D20431884C1CE6F6
      0495DE66CBF7E57B2393012361EC17C1B0E3FD8878338A2C8B9768FB878BEDC7
      D2F33A75B368E0FD62B2941B6839E102E4E11C7093A958CDB1C4E299470C08EB
      AE024FE3F7FAB59221E980350C79973897267C44FD519B11A1E61397724B604A
      26B77AC45C24AECF444F5390A352C33F192C4EE648D5A07E2328FFD2C43C3D1B
      7FE138DE9CEFD1977BD76B9DCDE63D3C82078F4E7FF432A7CF7C8322C3B1A308
      E5A537F6A5B1CD42E549ABC395F1FA5102809928A45D045754AB136DCF31B7B0
      717122328DF2E18E80A60FFD7C68B4ADD28F8349CCA7AD140E9F1C6C4A7EF5E2
      6D0A928638EA6755D2CA657EE957E697D697F9A5BB2669F7699BA4E7E7876291
      EEF3F188D68B78D2F7F2498D7530467EDC5B8167A21ECC6A1B460520C72B6E2C
      CC0CEBE1D07A79E43ED37FE90441504BC5D188BF9A5C59533DB9DD50C743D97C
      454BE267AFF59D495051C03DC2A7FDBF9BA0C85B36F1239CCF0D1C9EF35B7420
      7B450CD8AD7143AD7B85A23BEDE9709A89B7F1FCD9F9D56D168DBC8F679C1A7D
      0B9C8D49D1C3DFF98495CC6B329A136D588713FDF10C874EC77C666E421240F9
      421BAFA0D269E1F74E0AC5A27849C6F5E675860FBE1CA43DFACD19280D5C14CF
      9F0DB8A4904EFBD7F059765E86E4DE911732349FFDD004D1880C29C5BC517EAA
      8891F3AFA3501A175B6F105055CA1DC835CD403DA9D4902DF187DA523BAD37E2
      CEDFBEA9B43F32DD46F3A4C785E45394112E2D1225216A4E13F868A328A64727
      3F296F6BD48EFB17C88B4A26157DB2F098E0BA6AD8BBE557A649DCC03EF3E7CF
      5A672617BE9E49504C32D3BA2B18ADC697D7B9767CEC27C6B2418E2229762CDD
      6D3F69A6242C70924D25CE17C599EDF00CBD37B75C457F23DD08D774F0C6AED1
      C0E523B54A86BD1E80F8364F34A853F656A0C0FF9B8C8CD5137F7C023AA32CEF
      149F0BDE5975EA32DDE7FF7362F2E20270C6FC795A30003341BD2B978F33F98D
      80C17064CF56160ACA12F62EB0CEE20957CBC29991AB9A27D66804EDED224B92
      228B1A6AD35C2B56547F7229553ABC2EA052475A69DCC0412595D2103E405C6C
      79EFFD11C73B4AC6BEBFE769D2F692684047CB0801DBC88FE9D7380D25FCB10C
      53FCB630C53248713748B1F1E483143F7BEA249C83FA898EC743ADB1540FE1F9
      B32737AD75C7757ED868F74D9D5071DABC5E39214D1BC8178E51A14B00308278
      388D44E3F8A39FACCB83F1371D8CEB9D8DE5D178F768EC2D8FC6E5A1F2EB0722
      4CC4FAF89C0A41435B1EFB05D72DD83E7089433AE6E2201D8DA09CEB24F8B91A
      D2C62B9B27A0D6B91298D78E17356F8C8B1DF4E5A1F56B0FADA53F37E7D0DA7C
      D287D6F3677F74539B2B3D5D96B1AAFD2FE3F486A9370D0A541A383297427DCB
      A5858E4242A64C00DD17A3BE3C7FE673D89524D458513C7FA6D38C9F3AD5FE75
      1A85B97729C973867DCA0C795A1827A63F9C8CE978435A5D13676081942C5CDE
      66CF8C949B9A735A63083A00440899768D51B318255EA8AE4B8053C4B99787C9
      6F3C4C96154C730E93AD277D98940A698FB132DEBF39DC6B2C82DC1F2A93F3F1
      646FE135078844B16634A37171EBD1A3F8B70D1CEB67D5FF180DB29CD0FC6FCE
      F71ACCFE6C47444B5257A4E2CA0280C200A2C8078C8D40DCC464B4E5813F3638
      E89A3756521FF6FC46FDD1E986FCB53C4E7FE371BAB63C4EEF1EA7DB4FFA38CD
      C7009F6A785240BA9E94493D36FE5563C7902B4135295D346D7301F5C1D1DE71
      53C7338853BFB0E53819D0861BE9DFFBE1B5CF855B2769C87DF4B937303EAADE
      9A379630F32FFF6F48DE241F7E2D8598E1069959D0DBD6542823A2C9BB8E42E0
      F8333A67F3860E06356D1262DC510EC997F46BCD1B50990D6D78DF6A39100FE7
      A6425722A9550BAD3DB495DD728FD7ADC2E44567EC63056B08C5C5AA5057CE10
      8B282CECFD3757179209F8DF6414AE0A2A11CACA9B274231C3FC3C4F8388DB47
      B963742082A9D584C30D315FAD0D0745F634038FDC6DD8FE4643EDFD2F19EA20
      DD78FC91F249F52D069B5C7F83C192B23149DE4C3DCE6D80642479A7D9A59F44
      BF98CC5B596F732CBBBB8A18F64018AB0BF246954F58DADE35FF3D95DC7E7C46
      9697A314CFB8F03A1AC4EB7FD5D1E03CF9B7AFBB469A37EF0361CE7EF43DFA92
      59A1000E0F26C7380A8A47DFAE6A60D06A50F4EEE6CD5EF24DC0084E5F3FF654
      959A853BB0846C3A9D14E349A17C47ECE8C02ED4F8A04DEC81C071340986BAD0
      A5EF9934B53F02B7D41C5ADBDF574FB548789DCEA74FA4699DA2FDF4699486F9
      A74FB69137F40E22808F173494D6FF76FD54668DC4D7231F7618851A69290CCD
      224BCC0F8A34ABD3EC8D8EB566D6D94106427089507E4CBB013969A66CBA383B
      3CD4D2345A332E3DED28B64D7289F3D962E158A8FF064A61368FDFC638EF94A3
      BDFC37C562A35F5C7B7C23131E3AE01F8D3F4E93577BD928CD5EED8D4693440B
      47C7C861E543638A06DA9CAE2EE3CDE9C1C52BFAD1657FA1A417FA78B27750E2
      A90BB681D21EDFB0C9197A93312B746B44806C248D270D453D10691CD9DCF2C1
      E99BFFF0862492B891C6890EE76C0E3D5068407E5252C855DB649759BC5F97C5
      5BEB6C2C4B2CE7A4F1769E741A2FCAF389F1B6765F7B7E1D249F221D91511B08
      D29C5A4133E877DC523D403E4099F1507EE6F9235C85CB1DD81D00792D167603
      4F0F91DC7A8F44A7257A11D9459FB9595C697A84814735CF294095E9AC183570
      ACCF9FE968B7BAAF2B84D3595A888BE32797314EC56C54D23CAD54BC21244D78
      B594A805F0391AC8483F4C8B2B739B2BDEC7C2CB1910A484EC5068909547F7FB
      0EB1431FDB6B7EC96651948DDAA85C1DFBB3A1D84718F79F1E3DA8C3730D04CE
      2F44D969E0BF66B42FBFD160923431DF2267F0D8C38D12524D450395D2F367A0
      83F7CE87D1A0507CD9BCF0A52044CC3384ADAEA2317321A6E824B3AA88AE23DF
      74053E0C39E71929AB621228C0847C946C557A66E65E426795A0E89AFCAA4021
      00B97F0D94D71D69B1EF0EA99CFE504572CA6B487E56B733567222B4F12CF3B1
      9A49000E0E857258CF4F015606586F63099ECC67E0E2987B076725C930C7FEB5
      1FC5B674A2B1587AF2E0CC3B1AE5F49CB79C95BA240B4FAB9568AEC5CBE40625
      3AF934109C7B2BE8C760D274761A1AB873C0F0FEA77DA05747186912DF7AEF80
      3C8D872791D4D82FD86BE37EEA838DF4300FE8CF549B5784F55DB651F32453ED
      4C533471BBBB110355BF289C90D93CF0E3DC129300C55850C7B5874DF203E891
      6A649C5841B3A49CC6301291400CB64942A3D47B212CF4F32F43E1CD8BE68DF9
      9E62AA0A8053FE1A2154A1E76098445BB3B452C3E7E63DF7E36ADBFB31CDC8C1
      1E03ACEC4D96DEE4C891EFC5C59FDE6E3450933C7FE6267F8C082BF9CBE01F4E
      D3AB919F5DE999A9E584AF4506EB9DCEA64DC0F9EED2B60719D8F72E53AFEF07
      57CD9347A56D6280015AB8F21FCF8E0F80BB99DAF45392DEB4BD1769F2A27292
      346FB8773B2257FA8646ACD1F63680D95DAC80830F4D8C16B80C83AD1EF49141
      0188255910091D9C64130873731E83D941FA3B69AB8F630368553D486ED349E6
      60E1A281324034581C6777BBB975A82B3F5E7C7FD6E6D4439B4963DA928519FB
      E3DB6C92F3B6687BDF99E2107CE50CE1EF6854496EAE2FEE9D7F7DC2EDC2DE4A
      31F4932B3E7FFF9E2637E17603D7918A4D1A17591E2B2A903A1697AE9C558800
      A95A21963DFE78FC9DB77219A77D3FE6B7E885771DEF626898C7EF05C8E03D43
      9215ACDFFD1F90D72DC069A2B5DDDA718C7B15FC2109F6488D2CC314D2C72ADD
      C60D9377CFCAFBAF67DF1DD098FB3655947A67876F698D32399E58FA4D253642
      7503B2FA5C67974941FFFBE3836E65B83487EFF7F67F203DC5414F143B37719C
      A85E78F3FEE2A0CE7E5155044B43BB18FA69788B22A042AA1C003544377BE725
      CD5CDD2C8D33432F70F1CAFEE1F1316F63B6352EA54DC597F40DA749070D6529
      90F3A6F74AE9D4B490874759B5B24EDF9E5F54CE226F851DB217E711D768A90D
      FAC23AFEB0C50683D565B6F8B7668B97180A73B2C5BB4F3A5B6CF2B1522B29D3
      2FCAB64983F4CD20CD4859E4A32737A575F3B81B5BAFC1089B17E43D7A740E66
      835841FCC9A2BCCC4C9E731F5B20C94D0469E214DEDAD846F79A3BF2EDD79E38
      2102AD50C775B7E6019D8760D32DC00904F726F78E2E4ED049CBC1603A41A760
      7F120358D180DE4E1A595104C60C34A7A2BE91CF881DF403666C18E5FF98A032
      AC9FD1FA31C55DB9688DC065C44EBE04F8F0390BB6CA20F43979301DD3F17EFA
      3FEFA3E2BC48C73F374F481CAA39E8C7FB5C0F9926D31422521D41BBC9BF444C
      D4EFA37C24C62633D790437C0B5BB40E23067B18A972700AE54103B50F3B118E
      C1419BB8999CFAA60CF928490A46190A8F65239D7FE09CC8E9819D628F8E5B54
      C3070520EC83A164268BA1268ED8C0CE6D6DFDA638AEB0C3815EEA3EC089265D
      3F126C6F9E74EE8921B7BD0F475C2595A5F14C40792FCFA167467E425B29ABB1
      63DAF6237D1B3CE6ADDAC8E8B10644E4D8FAEBFEFF77E6AD98C416A2FD82FCAB
      4B44FEFBEAB4370BE7BDE1037E7F7274DE58E82A17111D71A02EEDE729371300
      D43E2EA78A56F8C9E9C19B36FD3C3F687B6FBFFB6E8F7F9EE3E7C57963C73D51
      42EFE3FD8B77534E277AD14C58B10C3E9CFFF05E2DEBE6EE50778669B71B6741
      69C6AF8DE7C7918FD42F8FDC230B01EA0D0ABFB9A315F3B0827069699E3984D6
      D41DEBC2F62F0EC47F7DA104E143C39D2F15F3E4C5CBEE7A6FBBB7B3B1D5DBE9
      ACE17F2F60CDF40DD3F6B2F2A215808093F60BC98D105826E7EBAFFBC73F961A
      A079829A49F6B41069FAF4E9B4FFF73A754401C28C9304E0295A223D9B06FA03
      64805442555E759BB391A270E800E69C68E6D87AA582AF58F6553D4FCB9F910C
      9B0984A363143DF7FEBBB3B38A6D453FB2C9D8B121FAC5F03203C6AD90D5F9D7
      8D74F9A7063C47B19F7C77F896172DCC4A51697F3D3EDD6FBA1673436E7D4826
      39FD6BCB11FE7A7E78D022AD9D35338253B6F3CAF0A4B2607A4ADFBDDFFF7FED
      39B9E925EFFB6F0EF92F711EEF86FC37E6CFEF5309F93F7FA670C999B97EF58E
      26ECC4301530822E5AC63149689774BC0F64A9F803987364E8B1BDC72B2015E2
      56ED25404ED1474F581655B6D4D3590E0BE5716E00D5CBC3CFCC3F2651060049
      E9F662FC9D909B824941860D1C9C4CB54F9385A21A87AE536391CC00F060C241
      3234B87528002FE0D446D212C799672C9AE6898863667B95158D0A5FD27246EA
      3AA57CB981E36AFDC7643466769DD4D97062C1BCC86D0BE3381D4FC60C71D0C0
      011E26089CBFD2003AA30592512AED9ADA8CD0C0511DA797B2A55096706DB29B
      2CA2074F50BEB171F2A68103FAE9F3012D44507A157E8CFE1233D66AEA0C41DD
      710D9895E7CFE07F15C32C9D5C0EE9904209CF7B9BC4A58D3BF4117DE20E9DBC
      F047E38E775478230E65F40DDAA0069318D715C8E579B49D05CA846DC5064AB4
      84B9A097AE727B3A579033A5471BA8FA88C09544891DEFBD0620E8BFFD1F2093
      80339A9C6C6BA028E695037DA1165552968CA97C71227DEE48B8DCD6B1810528
      76F5319D86DFE026FCEE46E4B9CD6DBD7E72ABE6DB7B00EB4FDA037857E52487
      81D8C08DFFEE9E169D95284103A3742E5E4E621F56FC180705DE5E6DE848AB39
      E3958B63BF4F966A082FBCED5DECA3CFEC9846F326FDDCC4F15955E24AD0FC00
      F08974E073F0CDE233486E9B7B7CFFF4960F2ED8E9E29192A227DFC6D0DF7AFE
      A133AD89B238D31C6A7E9B14FEE7C5253343D22F31740CFCF7CCF5DFA9EFD271
      FD86FFDB0F2B30D6E5CB83EAEE41D57DD207D5473F8B842C37FA0518058576E6
      2331C1F4040DDCE2A713064D92CCE01F644C4712745FEF6EB6E9C7167EECE2C7
      8EB7821F377EEEB550DDC7FD7218786B6946AB663A89F260A998EE2AA68D27AD
      989E3FDB0748C2280DA341846E77468C1C8DFD22EA4771448E37DB2EFD947E1C
      181A61E4FDF5909DF1BF1E6E5824D51C48AA793AC98020802ACA06EE7C892FBF
      F173F30EA37171873CF52609AA5F79CB83D98FAD3B858703F9F92400698EE61A
      9A38F437B785D9C3D0BCD8249734D1E4796408AE7045CC56CFEB4745BE4C31FE
      D6146377779962BCAB1E7B4F5A3DF224D25E873EB88EB4287C94D65805D1C84F
      4862C02663F4C94F83388433F35F9FFE05BFA230ED91C7E27DFFB7F78767C747
      EF7EF05AC3A218E7AF5FBD1AA5FA9C9DD05C477E0268AE0EE9FF57F4EFAB0B93
      6FE2915F1E9104F297BDADEDDDEEF6CEEE56CBFB9FE7CF7ED5B36F6D6D6C6D6C
      AFDD79760805651C2C29DA636B6BE15AB06BFCEDDDC16EDF0FCCFAFA4EB0D35D
      5BF3FDB5B55EDFDF5DEBAF75D7E47F1BF28F5970FD6E4FAEDBDA595BDBEEE97F
      F4F7367D7E83AEEA0EE4BFAD90FEC3BFBBFA3BC966CBD035EBF255F8AF4B7F6F
      D1E7B736E9F35B7AAD5E87FBE2775AC0FC3B5FBBA1F70CF53BAAEFD3DF9BF65E
      7816FAF7F933FCC5DFB0AB57D1277BBB953B19B91AAF6FD0FBB461D748AE6B1B
      74CD46577FDFD1BFB764E4DBBB9B3B3BEB83DE467F3DDC1EF476FC419764B419
      06BD9DCDEEF696CA9164B6E9F731D0FFF91F2CDD38CCF2F8A12B75127F0A06DD
      AFA04A7FD332A5017CCAC91111F586DFA059CCE7B54F9233BCDD5EDBF93448D3
      427F0DD238FF8C5F4C1226439319FE343E826231E844BE9B68B420FE940F8AA4
      FFF75AA261ECC13F2C0F81164EA2CD324A0023EBDB6EE4D0042994E6CA99B611
      ED9D9DECB5BD771FCF8F503D7FD06D03DAE1B489012E1DF5E135AD1E588188D3
      32CA9A7789461664E66A18DF470752E085AA8338FA053791F6A2C60AE4ED7DE5
      888C0D6283F54291E4681B9B375A6D505DEB79AF69C8681C4B81A105E011F20E
      D08CCC107BF9C85BC12F97C3342F563951EC72BB8D0C9058B8E59D1D1AF88170
      6D70BC167E204038BDB10F3E8D349E8CC8398C0A405892AF446303C926735040
      3168AFA0B7124EB806CBF78618F9421B869B34C81863B4BAFEE47215B03074C3
      08E41D88CC485846E8B97C94523658C8EBEBBB24658B4735E444B71F86D83E24
      F93CF7FE7A7C76EC5A34950B1240B152E226795E0828CD8D5CCB3CA1744A9229
      9B71737C125D261627C796841F5D9C34506856646B2432CE2455E00AB9679561
      0C73A57D25551D85DAFF9B77BCBD384F69CD981A36C98DD79ABD7D0B11100072
      887A6BA0F04E2B952CCAFA85B41556140328D1914E6692EE2A2995EC1B3AA6E0
      343770B84E8B75CBFDB5EF8FC9E37418F15A849D087E28F7CF73A750A56F3E8C
      102082E9492BE8C06812973FCB7403BCD950A39283FB10809A5887CB78F1B2EC
      62615464F3494745A613DDA8C062E3C759771C32064F5B08318EFD9C8C5BAF05
      86AD9677656EE9986EA2E983F2850A82AA458C6EE848A64EAC478DEE3E65A5B4
      4CAFDFA390B69EB842DA47CE2A6357E2268A6336546CD1B1F1E0927DA6517385
      15796B306432B9302A8009746D983131A541DC2A1048DF0CA3A4897A4A0DE1EE
      260C610B40AA1DCEC210C7F850E80A01A8520347E8FCA3EE3A1BFB4AE1A3683E
      E9C03B23DB149508C2EAC858BDEC2D929D76E628821C310007AA62FF56F25DD2
      27040B57FC277E3B4DC88F7AC7A46C7CE79268E8AFFBC767D6719A96AEC24834
      50BE56BA6BAFD6D7E1E79732C3B6AA313DB6D158282C5CCF95342355E7204ED3
      ABC9D80B271C3FE30EAC50172CA354014189E92A264966E2A8A1E7AD754DB749
      966F848054CBDB3E58BE52B8E007DAFFE1C4930375BEB9C38573258EA5D752C4
      4A8903B76825C4D6946AA60769C70805B4F7B1DA48EE5511E86008D7D82F63D2
      27EC6F4A8541C73B97583056C588D4081D4A7E6C3BD358CD40236991427C6BF7
      8FE160349DDF79137789D3EA6BD0391F39AE0EA04315ABE86578DBF8EBF0FC84
      810A3ADE1B3FB8BAE4A05F49FD1747A3489D7466B8A67F1DDA9FCA8A1BAC1A28
      252BA36D3EDD25B4EE7BFF9898BCB0C7901E7B349ACC175CC31A612D554883CC
      BF04DC8574D5D371D83796309C8EB22FAFCBE6762159A16E91500F397531D527
      AC4DB4C08C14EC37DED748F124FEF588B1DC3BDEDB88B6E507D40021ED85006B
      257E063FD90C06A890BCA6FDEA362E22D612551334A5064ACFCA0EE6E6A95ADC
      109D2C49BB9E6AA1C193DCFF933FB5A7F84B6868B2C1FEB2DFAEE31DC81E466A
      A96D1762C44DBC80DF8B7E31612962058095E81D00231A2C63C4B63FA61149E3
      E2766C94B0854C5EA453C663431E58C73B1171E4B253A7F6E4FF76EFFE87047B
      9645B2F4F1EFFAF8DB4FDCC7B76EC906ED820F9C40BE93E7112301E59AAAB4DB
      76FF5B2B6271C95748E7281040119A6697641FFD3803712E5D70A16FB1AFE854
      048F4721294847BCC6CF0A16B2261637942722DBF04A2F2FE8A7B63056F04F15
      1ECD27E3EA12A4F34A3447E6E98BC2090342E4CB3B368B19A6266731E61C7A19
      9AE9FBDAC2623D6EF92F92B0245352C46C48D8DA67B0546ECBFAFB2F69B5A74D
      725EA6FA613FB5E0CC4CC6BAEE5B92B2EEA79FC9E00E86692601AA7E5A80A00E
      D417A4931AA85DFCEB3402949EF861C0C80E80B687B2216BE3914A4D3DEEEF0F
      4D7F7289F0DEA336DAFC412BD0779615E87715C4D3E6B578FEEC471CBB058A9C
      94814ECFBF08F98AC24F984299990B18F087F40293B2597E5B31894A76659CAB
      F41BBDE7C7DE3BF37992C3EF3A2F8C3F6277341FA6CAA44186CD019FE37E7EE5
      F97D500BF163E8E14CDA67326A2020AE031D79AFC46D2B529A68C376AB8E5B09
      610EC96C8FE870B5E11531FB2006DB9F7F404E6E9AF4D32CF10E8EF79B271195
      470B186A6AED794707AD79559C1AD96CDE182F30362DCC71F851736B7478BC16
      C1BF7903DDD3BE3D280549605588AFE945CD92FDABB7B3B6366CDEF038DB6738
      4F0256BF38A2B51AA4313B7F496859476D012A9D0EDCCFD65C4EEFD634D797C3
      409346CD1ACA2E09229851E28A2979EDF1DEBB03E1B064A1D12F476E47AC0871
      FA3463FA6AC73B4D2AACAE8AA2C780826260B4953839FAA5F134EA4796A9732E
      EB05AC2AE68BD6D299A555FA5BADD2EDA5557AC72AED3D75E855B5193E68A63F
      8CFC38E5DC67713B565E1CC1505FEFEC3CB9E9AD31BE63E9C831AF42A3CD39C6
      9B14831DEDF541282BF3933C2E7B9DB4A5A12D5836B7AC504723815D25758932
      C9F322E3654FC2D18A4920916AC6A248018AA48C05CD1399A2CFD2192116C62B
      979DC8AFA2714E52094332AC944060A9367FB3DADC5AAACDBB6AF369E3D59578
      97A70717501A6456B03D1B7A2B45964EFA283CE430FB817F935C4EFCC588A261
      C7E48DF6C2DF3ADE423060EDED1F6AF9B8406EF4A3313331B14FAA3984238E70
      949825991F186FAAE4C651AE69C484CC36D76B38E796D2C15666F92558D25828
      D13D2DA1637A3E1A127EA914AE33281D97C25480D6C8EE9F356C973CC20F51D1
      0B2F9AABC337973AFCAE0E7FDA506EAAB6C849043524974981AEFBE8FDC1B965
      C714DDE5300B9FCEDCD61D9C80211D1C827C5CEBC0F68EF7BFF75660D6B70E8C
      A01EB10E41368A4EAD56938F203E8D2B4C8C3943B06786896F15BD93AEE962F3
      0A8201FD3C156E1D1C58F6EC41C82D650404E4B8C9F1F1040DA179A229D7813D
      4918CA812B8A12A1A977A3C79AE0B383B7827F6D25262268F2D8617F0067BD32
      BF27420FF69E5DDB15CB1449326175DE5BE58208947D7837C31A2787D407829A
      2129A3EBDED0CF99F07B2AC0D42409327AB90D0D8CA29C8B759875ACD9E462F7
      825B9CBF3F3C6E3089E27B6ED17CD967CCB732EA99DF92453CE29DDEDA1B8F69
      514BDF674B701C56B83CA1EC849CB21EC17F0DF2CC226DE0C9D0D27E78196803
      9F7F8F54F6ED2F061C1C320684E7177E2CCB4C52D02C6BFE33FF1A6044DD7A23
      D747EBCE7BB2AE972EB44CD77BBD5F6F9AF287EBDAA6517C1DCF8F32F06D9E82
      897A7E759B45236FACF9ED38FD1A69CCAF38918BE128FA71748DB8EAD92441FB
      97A89DF7598ABA840C03FA55B87A2485DF45DEB3C87AAF5FBDBAB9B9E92428AE
      18A561CE5065A98EE9155E79D55BDFD9DA6861148D82D1DBEECE87D1AB42E86D
      6F97FF31FC9D51783B7C4661EE1CCC5E4F81ECE6C1E4E13FFABEAD4081F02CD4
      9E02E04DC1F5D9FB0C14106F1D307A0C810768BC8D270A81B770653D6435D1D3
      D2027F228877CDC5BB5BC63F16598B27921C47B7A12FC5F079EAA503707B3121
      2BEC0D7696E0DAB44E91E86AC1BD16A3F10DDAAE515AF02A333E7D7B1FEDF8CE
      ADA2076E7BE7E61F0CAAD6F6340BC749B6B6678AA0D3406BF2ED24065DD81876
      F415C09424709D7936F6CFE1958B65B8F5B766C47ACB68EA5D6DF2D4F1E7670A
      09D079E3911B4DDB83764718C30F65575BEB593BC567AE7E35A385F71E5BDAB8
      D47B737A7ECEE0A41CDCB30EEB935B2D7563531A87B846A32EF7CB5458DC694B
      FCE787F38BC68E6DFFF0F8D8BBF1918A63FD0424B6C998A38C7D03143A57F757
      211D69DE68DDC2DFE350F328E5F6B4D85CFAC1AD77F66EEF44B39288B5FE5990
      5A2C7696BE2364E08844D3CF13FCFCF170EF7D9B23F574A21E9D37B71219EC51
      3524083364BE145CC89625351DB49D24B93F3012AC1FDF96C0003670C568A438
      5C44E334D0E00095FCCFDEBB9413515AF27970B477EC012761DCC0F02B6D1647
      8A29BA2F9BA5C614DA6BFF324CE31858A874472FC8FC1C6D45E078D63E08EE93
      E0D8A69AAF07C7FB0D1408901FBC56097AD552CA6730B80072478D6F25B7E6CC
      CC208D71A846036D1F81DD0ED3BC81A7A02BD0051A135936B7A5A9400BE1F356
      4F23D70D9CD8EF6996BCFD8BB363F614D8F011CF41D12840D633587817DA0A83
      D2E97854F2BC3FA86BB1B1742DEEBA164F9BBBC559587AFC4B39B28526C37121
      7172A4466CE683A67B84ABF3D7CBDCC79CE96E40EEE3188A47ECC2BCED1DE114
      687BE7634356C1D39AD18523A111BC9E1E40DBFBDEF81C252BE8F7B77EF0B51A
      6C1E7358677E605E7BDFFB51466338BC354D9D9E7D61803359D31EFCCC48D342
      D39E1B6D051EE8A19BF6E03FA8DBBE388F9826AFBDBD6C9466E4C51A7F8C98F7
      DE6894B6A10B96F64733ED0F78ADAFD821FF91C39826435120CCF90F0767E281
      09AA1008C3BD1B9F8D59B242F2DCBFE4267B4F2042E948F3AF4F046CEEC9AD85
      BA811D1BE5BDE3BEE79DA5C1D54C83EBF9B337EF0F2E981AD9F66CDCD242B64D
      73A104A82520C3E011CC3F43EE7952C8EA8E06DC655C78B18F961732BEBD95B2
      8A5AEEC67E2F6EF435A2718F6CC4913F594449912B3C747560789D24129ACFBF
      7F7CFB31478D0484E72B88E3342A7639781E7713079617BC48A7A673719F1686
      CC9F6CE4C05DC8CD1D428C7A975C71BCFC20BAA6A11569F6F482E54B2BA59695
      F233DC49F3F6AFDE789826063D71376C9948E24963E75AEC5CE97968AE25E2DA
      0EF3E94A6E1A5C0D9909053A6B831511D1884EA8984FC14019A2A0D121AA3FCB
      75B183EF56BDC800F7C544EC3D3A08D07738201700681BCD13AB5B47FB3C7CA8
      BAAC786912A1F96330603031D02FC0FD3F3FFC4F4954ACA09313E8C892BF7069
      19E1E0F0D14B119826CAA36C1313BD294D035C31DF4CC47B69EAD8FF7ECF363A
      F06297E68E1AABC322FD0DFD182CF3B4F2052702F9D90344B54E68E5DF221DD7
      58D91C58524BCEB56AEEB52D3AC117C65385A99DD238DC17A3F9EA068EFD5DCA
      DD728CA72F036B614F5FC134BA016A2BFE12CA021A6DAB8123B46956EE6AA307
      968E6AC0755830A628612C6EF4718525C35F8386A8ED3D6FA318073D4EAE7D4D
      94A37DA4C6F64E26E0C7298C00F54AE24C96C440EE99936F03DC1459225813E3
      0C14A6A73FA065AE1021EAB522C63643FD4AAFBFC01B2A1C3033EB7E8E0A8B1B
      7C99F9A3B6801EDEF9320DACE0BB4CD64C361E9D940AEE970D083557699C0B1A
      B746B9D887980A96BDE27E3BACA2FF17A7979D1A0B1065819371CA445F4D6460
      15EE39744B829A0C7018BC517823917DF402E08549682B3AA498C34261646521
      845BF91C6A11965B47B12C209FB837B610DF9A3148B8798FAEE06FE0FBE16BDA
      DE785270B148522D26C9D2B4B0C524E223D83749F42698147C3736EEE8E62BB6
      95A7436FB63D9AD68FF25B1DAADD225882FEFEF6D285EEB274E1AE53FEB40956
      B581EF5CFA301BA8CDC0305A12B6487916E9ABE60D441A81C9DCEB33323B63C7
      02F003EBA300AC262808D2AC892C8A676664467DD2E2E334578E4852FF88E319
      148C42AB8F7C263B6AA8515B224B491D9D5287B1197F3E8C06C59F0EFAF17E1C
      05570D1CDC4F7B71FCB3F763766BBC377E3EF42E87690E9BD0C27EAFDC692DED
      B2CA9A7E6C1AF7A057F3C9ED136DCC7DA20DEF5F3A261F77F8397E5D5BEBAF56
      97ABD895EA1C481C8909249BBA6E7FDA3B3EFED97B7B7C7EC1F8311E1E5C2A76
      A793288D1DDAE1C1D181E7331D5A5EA238BB645703C7E5A29FD58645D638A8E5
      D0A51957DE2B61457D5DAC6094B3874D51428B365018248A1A0283B45EC6AF6D
      D2D703582A0E2098E05E4EF2088682619E320B88C04E4FC94C480A9A279FB2F5
      4748061143759A5B23DF1C17ADB4BCBD425F1CB7C571039CD6F71B10140C9CCE
      87041A280F899E4AC1D3491AFE408ECBD1C9E9810D335B3606443EAEFD8C711D
      4B8ED5C68EF7FDF141771A74EC0E75341F6B6477D2F668E830A5F049481D25F9
      5DE5096386F601385E07D1E7268ED006376C3A31BD413DE8301ADBB52B8DAC34
      8DE86A6CF608CF93F4E6D6BB313E0357DBCAAD1ACA8E35F5E76AB9C05E560C47
      699A2DA33BBF39BAB3BEBB8CEEDC8DEE6C3DE9E8CEF36751D9C0365B0789FD21
      E1124E8B72561410CF5A1CB6DC30BF75C32C61D3E76C98A74EFDFA1634E393E2
      DD47DE0A685D1DF9D99532BC5B1CF068E0859331F9925C7E23BDCEB497AE41FE
      0C4A276E037B7293BF70F403362DB897590259719A5E713B68E1F5FDC55D0546
      99C74BEEAEE6C9A085A67D284C81CCC95B8E7064984EE2B0623A0B0F36AF0553
      F851EC5D4750011CB8853FCE855ACB8ED8DFAE4797D0E573F4E853279B0D9963
      C20B10F446AFBC6FE9E034C76BDB4E78D3DC0C91C41DA6314729B829FDEF93D1
      58A1BDFCA2B180B777342A6B150C726CB22BAB2E8BDB1A021D73E2FC3041EEFD
      7D1A250DC4FA7EFE4CFCF373F6CF053B12B11679F54FFAFA7B48E6502473713B
      96D2770055FB1EB36A84E4FB4A141324A4B644DE4103E38658600EA6822B429B
      272C54F14D6D20D4F36664A8DF5611380C1F49375E3A36B0E811A9E350B0E75F
      D2C89A376AD93051F29211F1ED6068E10B6B7B7CEB0508E5788B59309E3F1B72
      A8778C0A269514A2BE6CA64538692010D4485FA294C70FD0957F230CB846DE4B
      80A91FD3CBCA69D8449BEEF9B313669B917E389680BC70A6D433B052A4C544C3
      9FA008FA519A035F5B8631F399841F814ECB8FDBD66B646105F4C9257FCB6FB1
      71BA9DCDCE12F4638E89F3D4E9B21189A59D93E7262BE641F507F43ACA1AEEA6
      10961BE5D76E94F5E546B9B351369F3A83E79BC925D216AFBD419CFA5C193386
      01CBA7B39F45B9D05AC28C8951A8DD1A4C7EF9E5B6D5F12EC0018F969DCCE4C8
      C9622FA1B563E636248CBEC9E4067A4BC42C506F6AFE31F16386AFA4533D9D5C
      F2E17EEBD91A7BF545E26804AA4CA944F2836092011A91FE561B6CA5E7F56F0B
      B33AFBC59C5ACA3BDE1BA95EE5127010C2A1C53890CE2B853D5B88C7B0D830C2
      57E7E20D6928A26FDC0865D812A5E257969AE6B76A9AB57FFF46229CDF85FF50
      116E6CCD1721C98C45F8DB05D73A33B2F3D4B39752824EA7D37A44C1FD0651FD
      EE6A0FB83D7023188D5CAB48045F80165AE25F4797525D5264C67018E4E5BF79
      F7C954455AA3D472CEE745334940939D66FB26A9380B5FDA37086B42B7D998CB
      62F0BFE7CFB8B11244540894FBC92DE7D9B328ACB064321CC308130485152896
      512871207C0DDD63150D38FC17AB67EEE8F4E42F212EE6A83BABDBDA92E0C303
      4D07B9194C62DBDEC3DEDF88165404AA7BF27D26A881296CF71859110953288B
      B7A4E7C360524C32D366C62D3FA647BDF113AE8CF1E31BFF36876F7A8D31FB1A
      F9B764A0DE8AE95C76E809EA489224FFF674E3BD20C1D299720BCB927C53BC91
      D0BD20D9D81F8FF9429D3F2DCE29812D74406DCF36BB8EFC2B387699B64B25A9
      0DC365466E0F9F0EEBC016C7556F8FA00BBE02F7107F9CED5B0CB2D2593A5B82
      D9BF6F6BF5CBCD5547052DD6DC7B67EF8EDE7DF7FA916B409F3F2BA378907E65
      33F9DC1494B310652A64EBF12C689F1AF7AFD46A64E5435DB80FE1B64B8719CD
      DB95EC34AE8ED06FE1C99DE4BC94A3DCBE8A9415FBFA8EC996973F3E1D9AB149
      427F76C924464802F83A90D2B2BA404518EF587A87D6281F91BA3BC199238B4D
      B44B913A794C6D697E785F5AE42C3022595AA4226062DDD6DED57BB4FDDA3248
      BBC9167E06CB98F3721068145BD640E68C88FD0C3A310CB945D0BF2123AAC5D4
      711591D3FBDAB60466F5C918BFF5BE7B239B219B08A1DE2441FD8DEF6DF5FA24
      1DFB6CB4267EE4E2E0A5EBF71B0DB28DCE9A77F8D7F78767472787EF2EF68E97
      7EE05D3FF0A95392CB66530305EE15A2AB1CF2CD850C7BA644A5AD8E9F92818E
      A0B84688598A7355A722AC3470E8273A6800BD1AD299272605698696FC1970A3
      B5EACB16EF7E1FDBF896EB08E9EA00CA925CAC49601BB1C729A0A52260489055
      60B4BB059DC86A37B4F699B6101989436EC76F3976EC0656E8717D1D9B431C85
      4F2A3A8E144E156DCD1926A3342F2CE6AD32D4AA573F327E52B1BB58D1E6C6D4
      99530EE5E770826FA08CAB7519EE7E6114A29195DFB8E546D3DCC4036F056D46
      58018957768BE6A3B6B77F5E82A97055B4BAD836E3D2B77A1FC324EBEC88DB24
      1CA03FDE104806399AEC2C2B129340E3DB93930F9F97492A6C13F4F8D8962323
      C734DF976DCCEACDB1A921505A64A31A1A7431A341C80B5ACAC0D87E279B8566
      E0CA98B14C319E2D5F9D7A7E344A5706308CB051AB43E0115C4C8D5F998D2533
      F5922F7FFFDDD9817825C6CF629013E9426A20863A9A0FDD582DCD4314B2C116
      8DBE1AF6E9238FEACDE41265B49C7493609696C004C3340A6CCB40DF30B98103
      5913B3AF79A3BD18D6D039C6FB900816029F0C8ABF52CEBDEA2FB189DF235598
      797BFBDF9F793F09CFDF7AEF676C934369807FEFB3422CADD073FAA4BE77CE5D
      9124FBD3319F27DC21291F50C394BEA6E37D17494C53CDF0B17CA5AD5102B411
      B76CD0EE947952F514B6A722882EA92A6D0062F1F3ECDA4EFB9B348BC3F65789
      607214361A9411D831F6BDC03366861D582C2EC8573A4E04E246DA4439FFEF94
      31DD889397A13D69AD63D5C863F562586B79F1A98018B79B356ED78309251D6E
      7CFE5A39B6E5D088A32B814D689DC914BF38AA9A3B920A7EE19DF1B95D9A275E
      9836B4E1E9C2957EF0304471416AA8EBBCC9BD6A5D12A709C865474D8D3A9522
      69B2A7A1BD034EFE2B5E18EF1B5CBAF021E85EA1D14F6176D85397851DC4E831
      93980D3F192D6BD91215789AA11FCA1A67DC9AB2FB72E93AFE3AD7B1BB4CAFCF
      F3169F3AF9E77708949D5B949995EF4ECE2F56657F623B33D4923BBDF23446CD
      AED0CAA70266936647076D0E4C8B69D24075B6A7754B7ACA9D994B31AA1D281E
      B7778810D86D1697D6F7DEC6A95F07F646EEBF5430BF55C13C6AB2F029E7BC2E
      AA91594DF670BFE9C8FF7B9AB1E0AC8DE1C75171AB49954A50A8CFDE07D2EA5A
      B24637D42A342CFCD188ECDAE599F8DB96EC7A6709D534E7447CEA04B682CF67
      F34E83284354080998B220848E3B325BD97960D3FEC9CD724D104221A1EBC217
      9C1E607A5DC75DCFC8F0E6E0233D75E18370AB79824070C94196A0D3EC32CD6E
      BDD6F751481E1C222E2769E87D87DEB39665A12467A66F149A920DA1E68DFAF9
      33262FB17CA2344C6BCB816BF01D6C4259FC88D25E9AA21281C26B89645769E9
      FB0C5851923C374F140ED1790CAD23E4AAEFFD6248931E850D8C2BEED16C70AD
      416B9200B43769791ACB876BCCB12DA9A8D38E0FA4AAD5C867468EE68DF87C36
      10B132C915AF9D1770DBDAF245EAE557D1B88D8C85F693B6BD4E67B5CE012FAD
      3141B5D888238BAD73178268B5DD5FEFD2C4487AAB7584144E513E64AB7902F6
      43142660F413A9E7918606DB926B7B81D2C1200A90A853FC9AE60D948B6807A8
      A12DCFC780CFC49B2C45058505242663B5ACBDE2060DC7F12281A628833E41D0
      D5669A7CBB0A57B88A4B84B7CA6B0479B485CFF6A2B096BEAC43FEBAE689986C
      419301F2A7B831FE5599C334286D89F2911EB252365541130B62BCE4F269CD1B
      B81EB903B7B0A23BD9CDD69B491457C2CB74C44A3A176AC35BA16D987BFF9820
      5BE17B7DA9A5A6D7220519231D1E989C8F305873AB1D6F8F693E38E2EAAA7342
      D24CCA874E8F8D80B57E599D6E53EFCD6D8B17B4EB03D4B06AC9B8EABAE64A1C
      24371E217F725555CD457C3A29951F522CFE781C2331AE7C4F52A464FB528228
      0B2623D8C7414383FDB3C17CEE33CED21B1B306347CECB519BE98A6C39828876
      4970E0716D964B89DDE465EF1F7703F8451980F3A56C5450E346669476BCF3D4
      D559C262317E1E7194824CCE3CC8A231E95C206CA7E95503B5027288B76891B8
      F48E5E5C735FED65CAF909BF8F43E6CFCBAEBFDF168259B632CD09C13C6D0AAB
      E99404142C9906351640884476598046CAE2C94DFDE2B88C4D0D734F3E8CC3F7
      28FAE162B7FD340915548AF957E8F80C79C4D27DDDC4E88B0BAEE4DE0ABB15A2
      F5F84C887D3A4C9F1E015D8D03B34CA7552AF5EE7A9E620AAEF2644AF1F72B01
      C5E11270DFEB1426EFE134752410DCDBE20A5A72EC9331421558271C93F1732D
      5421076CB129CE48A4DE8ABA6F16D516E50E633FD71C5F319C86726DE084BCB7
      2676C6C5F3CCD955ED2486EC25125ACA57899DCA88E825D9CDCBA3B8E651FC37
      B2D77E80B1863399FFDAA3357E00C2A865068F5504C904E61E5BB1D86237C394
      969E9A3088491FA4E435904BD521FD68FCE29FBCEFC99A1E4C502A53CC29EDBD
      43CFB5B8948CF9BB704AD66E0BD1F616691CFB5C56A9FA77BA93E682D37FFA6A
      D0F42F8FB0BA20ADA311AFAA5ACD490C8EFF9566B02C276EBBA6646EAD5640F7
      213B3CC66BB19414E8C3A19C41994E92A174B30D68B687926E38557E0DBC6F2D
      815A3D2DFE3A598F79DCDDDCA59FF0A0BEDE56B9BB35A6275525B9DDDDDDDDDD
      D8B1ACDF3421FFF209858E26F40BDFDB5CEBF5D736D67AEBBDB5B5B52DFA6F47
      2A36BBB4C9CD6E68D606FDC160A0559CC15A97FFDD90BF37FBBD8DADC196D9EE
      6D6DE2E7E660B3B7BDBBBDB6B5B9BDB11976CDF6CE56B815F8C1EE7AD0EF9960
      63636D7D8D2EDAEEED0C829D0DB3D90D7BFEF367BB41BF4B5FBED3DD34BB3BDD
      607BC704DB7E773B08D6829DDDDD6E6F7D2BD80D77FA5D7F7B73931E66BB1784
      DDCD5EAFEBEF74D7D6B7B6826E10EE6E6C0CB677CD46DF6C6C77FBE1FA606DBB
      BF196CECEEEC06FE76CFF707836EAFDBA5AF31FDF57E6F7B33F437C3C1C6766F
      10EEFAE1F3679B5B3BBB3BEBEBFEFACE46B0B5EE6FAE0D767706BDBEDF37FDA0
      BBB3B1BDB3BDB3D6A39BEDFA9B5D7F73BB6FB6688CF41CFDEE46B86376D7B6BB
      EB83DD35BF177607FEC6CE5A37E86F6C6E6F75B776D6062189D304213DFA7A18
      ACEF983EDD657D63C76C04BBBD8D70DB6CAE6DF4B79E3FEBAFAD879B3B1BA131
      6673B04B62E899EEEE5A9F9E6163B0B1D5337ED0F37B1B6B3B3B1BFD8D606D97
      0467027F67B0DB23D9AC6FD1D8E8CFFE6E777BB0D9357EAF4BDFE2AF07E1E66E
      40921AECAEEFF6D7CCCEA6D9DAA46959DFD8F47742D35D1B74D7FA3BC17A37D8
      E8AF3D7F06616F0E82C116F91AEBF40566AB3FD8E8EF9A9D5D7AFC7EB8B5B9BB
      15F48390C6DBEFEE98ED60636BD304013DC6FA60B0DEDB5A1B6C6E0CCCCEFA46
      B81104F418FDED81AC9501560FAD972FAD339A0D9281BF4DB79517D7C8E55AE7
      5FFABAD206DB5D5A63C1F6467740EB4A7FDFC1421A6CF95859F4FCDB66B0B3D9
      0F498CEBDB21C99B46B64EAB8A6662E06FEEAEF536303DDB214DC87A77677BB0
      B5D3EDAEF7435A11867EF606CF9F0534AD6B7EBF4F7226719BC160DBDFDD0807
      C6373BFDC1AE59DFED1948676BD7F7FDB5AD60C3747BB4F082FED68E59DFDEDA
      0869710E6805EFEE6CFA3D7FBBBBB9468F438B676D678BBE97BEA38F051C6CAE
      85EBFE068929DC585FEFFB9BBD9DFED6C6DAEEE67A976661F0FFB77776CD6D1B
      591ABE7795FF832F772FB60AE8EFAE5C8D9349656A93CCEC3A3B73B3378DFE88
      B59145AF24CFC63595FFBE4F83142590048486BD1F5309528A45B24FA3CFE9F7
      BCE73DA0083A97BCAAA344C84A18957A76B84B8205E93448658450B604EB7BDB
      EB922CC873756999989119B2E8DE9058565A5CC9AE04177D29A08618C5E8B32A
      B1C7BE8898B562530C29E3958A86970C2B083D7955B2D4724860DA191D42527D
      4EDDA00710974C49FBBD59B3B366B0DE9BDEB80363B8706492F1803938032CA1
      45D9FFFEF2C5D347F577959820F363E115F1C02A381355EAD87B5159853DB529
      50207C071BB019033055DA90F4710879180A2B53D2C73EA81E7E21A2BE806B32
      304B27A58D398163526678F9027FF8858D8C9DED920B464339D9B90A6A0BDF04
      CBBEB91494EB231B154DCCCCD99360D95BD713F14139122D15E581A5D4AC0DAA
      008320230D3A25D1253368A84A8B3EB31729E94CFE2A8002D5B102AB6D76EC26
      E40DCA781147D8D04E48D7127F95FBA2BA644764D797867EDC81DECCC57FFFFB
      CB178F8F64FF10F31C6194E26AB6985E0DB9024996CEA504B90D83C98AB30D43
      8CBD3799F17EC0531595CA2AB86CC801C39E590395919D1666C527555345C49E
      7F9364B88411530107E40959C6C9C9E142B80692C1782D23C9983A6CA5F61E42
      8F36254A8080EB04D9D76BD83517E6F0705882554A4CCA791B4A8A5D09DE6AA7
      D8738206BABDB7224B4F0AEB403AF68397869DC5C152B3D1065238180A4E1F41
      93544A7BA77C4593806D594E4A5D9165702E5A631D75429AE8D86F5F19BA0BA6
      4FB693390D029EF69CA18B411227E1095FE74AF6D00D8B0194226769BCED7B46
      18C2DA8383248C483C1742D47D471D852B602DE544E52D0F6DF435BD06D10151
      988B4DA1BA75A14E43A6AB0895456353A6BA99A1279A14902C28214A510E9D25
      1FA8E22C5C1A93BC33945D973B684CE6C10A6AA30BBDE8B22D52E5A48D064A39
      6651EB941089D2EEA890A91811205EAF6D2CF015A59EB259381D78A9B459A05B
      0F276612D1278D58A0CC11412C2350679B9209504528D5A74EAA3E0088A0A5A0
      B31B422CA48DB756CA8002012FA50F401A207914043926C550B2A811899A9A55
      9CA925DB2BB67CE059CA428EC55AF690C2A5068839148B74E9482CE402DEB013
      153E51235DC8726A2425C412598F42E109A85038E7BB5C0B88CBDA86545C247F
      B3F15DE72BBF2BF63F4ACCE1794045289D7682EAE480D3A028460680016DC37E
      4120D166929F24549E5050F00522A7988A2288407751CB1CA800BD7BF9A297AC
      A4B09D047620BD5CD05567D44DF1D94B4F29704C5FB40551828843DFD43ED8DA
      89DE420E15D6E45A5F8812413295F041316BE8EA7E88CE149D0B9183C308411E
      3295C7B11BCA52FAE2CB1732D6F24CF1A5F8270598E12F874E0BDE84A22928AC
      BD64922D045F80492107A1D682312548A10C4BCC648A052C69A8263EB81EA215
      BAD649262D2947577A4E323E92E820FE47E1A258687281E4A1EE224549047646
      E81401412241FA2A028954E7AC22EE30306B4E303375019C23EFA89D0441516B
      63440E741475CD30335447BB5EF555B502674A2B9CD9A18A28C95590269685EE
      2A90153870113D147B842673432A10A88B10BD718343710C6C37228BB520EF1C
      C066F914DC5E53255252C40ED9AB900445903CB0181CD5218D3DA4A263098840
      03FB5405E732F2D105268A82C2D4A3C5A2820FDCD0A14B07073B5B0A8CE8022A
      57A086A2A0B230C660C37652EA595DC4F7A003EA2079A887CD1768F09EA545F8
      B487F71C9552F75ED6BA141CC5C52AA1522551470E226025F88870354E24E9E1
      C42A736108E102E782506D9D58458168A140F22C89183ACF56B0EB601E7459A2
      E4256B53E837E9809A089544011DFC86D042FE6A3A3C194878AA48EA3223F119
      D21230160A94728754A650A30FFA521B068453AEF93CC2BDA60E4A861FF0CE9A
      2910505E420D7416759A54629DC9093253F9127215260A76D29AEE60A054A262
      41864423E650D9CC4076A839881AF9860CF75D9F998F16975C20427DA02E0F6C
      12DA1176E4573818862B10305CA68183D264A5AAA9466D20675206F1D1942803
      DB3880F32C249455A837A08365B378B2340D460F92DC80F27226618449A456A9
      9D47054D610539773C423743CE7BF685BB21E8AC71827248CD2ABEA08B58908D
      CCDD433662603E72470563D9B38E9AE791EBB520200AA1AE6EC85DB0340FD2F4
      A8F744E7036E202FB28D798BE82509D0590323B177036C0D8E3D6586DD256D65
      1DC950A8888532A329B4BFA44EE06CB442EC5F0AD91B189CDAEBE9E8A00F1AAF
      42F333D4AA0D6120B84840CA23B8D5436D9A2CD2C40B9C43859229B653D46F2A
      531A3CDA87E048124875B1AA2792098E4521534660273A19329EBA04C903C50E
      D940E439FB006293461355A842B9100C5D56ED266BEB8492B134971E25D7C3F9
      41E3377EF85A91861423CA3CE6DAB52175103CC67426F41A882203206E5D4529
      9A889A4C0D850002B59D7CD71289AEC94F1212F8A38A583242C30040A53A833A
      D5D41DBA50C4B64B6C1C7D23CF6A0A13344F29A79C926B5472A6919A1514BA58
      C43123E9EC5C4025E1219122782C1F294040C2C0DAAA153468D05096D30148B8
      9E4A9003DBD953146A3760C9AA084D2B43B266538A2BD41BDA5C1E514FE96888
      2ED1135E068478AA7D23A8401BC59190113B44993611CE5448D5507353E89A3D
      D19148066D20D92AEA4DA605626F78291B720A21072F699B64A8244963478763
      2B6C82675A4719A9EADAA2C781237C6B69DE6DD518EC42ED68A19A5A01C97E41
      C31C58135543F68A7933FA437868D5205628E090312287F4A63943503AF68A10
      FB226CA4F951D4E5BEF7A923E8B5D5A59CB196EA73D6D45928C5EB48A0901A84
      BB8B1D2B804584478EB2CDBD5652D1C9D363B345EC0B9ACCC450351A3D5922CF
      D17A20AD76E7507EA224D5B82B5A3BFA0C2F25BDC040BD0B0268D19D405290FB
      D07708166ABC868A12FB305852A35EA120648AAE2D55F5D241CBBED01969D88E
      95C129A11FE856D10D951FBA210AB492120322906A95AC452E43CEF4BC300E5B
      E6EB259CAA56060B41F6C0974A439D19AF8CD091107F3A293A429C632F5948A9
      8E579DC8292920F4952639B42BDD926234FA46201AD801A36868FB4878E04054
      321AC25AF883270C7B8FBC8974A91AFCD29251F8D917B29CFA9AEB32D1713421
      BDF571F43F0DD4A37A618B18A45AE212488484236C4E4B004B8058561AFB8E7E
      67E80A8E0B6FE166996B0B585514D52D651218C951738D9E1771643C6510EC90
      7F28B6216BDA44646BBDE850C3ED2BB433ECCDB6D13BD5A4A1EF49AAAE001CE0
      A0A130B063A1B017080A640F2A0D1226F83E85A04B867A6460664B7ED5BE1A14
      D1E01372AA424033991A61F648431C03BC644951DA789E8364C03068C0FF5A64
      80258032D06C4448A181E91BD1355458EC903C942556400CD7768B1DA4E53B5F
      57BBEFD2877DA729EC72B7F8787586DAF86CE73EBD7E33F6F05595901864B4B0
      F572493130C8106AC7039E92730C22756AA39495A431AC0D126D714F2F926813
      6B47E3905750197C90BD47DC0EDEA2013DE28CA44A196222974103D58801687B
      4F8F419D72A84E34208D3815C0F9E425A56020340E0230F06B4E3D12C6D3F00A
      A76A43A6687D389B44865B924E505091E0681454B92A6824128A0633A0A6E874
      94104106643CBDDB90285E3422642DDC562FCB2177D1A9A0D8B001D477AA48CF
      F2352D45BD6A4318D061CE1BF04999A4FF628391AB500992B17254A8971F2269
      86980B35D355A463D1C00984237BF63B37D97D6ABB48F533F9ED577C978EA757
      835169B3D7839F5B43BD1AB8742DF0D221BBFD9829121F91F6DC399FBB4E75E9
      2055C452563CBD867239139E5BD573576F2E1DD4A4E3AAD8850BEBBA7465E7B9
      953CC70C175742FA2EC5E7E935DDF59C31AE54778F11D0FB1F7DB82A1663171E
      5EFAE5E58BFA6647DC5DEF6EEF627DCBE3DDE106827495E530333C5DCF6425D4
      0A7AE9A9448D0BED9FA02B26814D45B5E2555ACBFAAAA6DC2BBA4EE9EA08FA7D
      35AEB8FE3FD619882BA3ACAFA8672E643DBA33D47716A001B8DAD23ED42E064D
      D1EDD740AE485EABFD1C0D8055FCD7A1B08AA81729E42132E43CCD51B1E39A0E
      76C6D418D6D7D4E1555199823E4BF09CDDAF79F4122127C9125AC352C71B5F33
      74F4100BB93F33B206CFAB4F0A69B57F4E9961FFDC384E1CC789E338711C373E
      C7DC75CDE3FB41873926CF3C8E19D1599F1367A3CE67926763E4D9187536469D
      8DD16763F4D9187336C68C631C11AF111DF6FBF4F0687C8D9D30514D479C3CC7
      38B070C064FD139A9BFBBBFB8FD7F9EEDFAFEFD2DDFDD5BBF0B3B4A63EB8DEC5
      9F724AB974E34BF9DDD5FE5DC88767F66F50D68F523C3CF39FFBBF467E78F8FE
      F66A777B75FF91C7DEFFED71CAFC73CCEFEF5F3DB1E85F3D1DDFBD7A1CDBBDFA
      7EFCFA872F6647FBC9E8B779FFB71AFD172F5F4C97BDB77A5C743FBF80CB538A
      2F3EF384F2734FA83EBFD3FA73AFD17CEE09EDE777DA7DEE35FA55133E585D91
      623FAF46F0D46A1D48A736EB7038B5511B6CF4268FD601666A6337D8ACDBF4A9
      8D5FE9D1033AE4141EF7BBC8367FE204EB767C6102F9E94EAC43C3C204EB6866
      6102F3E94EAC03CDC204EB10B430411B4DEC0BE3AB3FDCD45B4935A656D9EDEE
      6F76F7FB4F59349D35DC6077B8637AAB6DA5C37CDB6452178AC916E23890EF76
      2E977A326B0CE35F5F352DFF7EFC10D4AEBC2A573F7EB8CD778D8EE49BBFE6EB
      DDFBE3AD919BCE7D34BECDF71F6EDBD67DC4C7F1B3595B41F238419BEBE3077C
      F6F723693AF5FBF0E3263B74ED2738FC603DA6449BA34788840FF76F2BEEAE72
      DB3EBF0BF176D786CA5D68CA8E07BB6FAFEE5ABDAB26AF5E7FB8BECE6D5431DA
      7DDFBE8DA35D9B081A4DD616C189519B081A4DD615BA0BD1DBE2D4C172936F07
      DB0D2E1E2C3778BADFEF2D9E1E2C37797AB0DDE0E9C152CF37A7FDB497FDE1EA
      FEBA8D58BEBCDED54FEC36FAF5E6EAC79B50BF2DA349914CE7F86AFF17C1E3E7
      8B7EBC0DEFDFBEFA7A77D396C4AF77E9E3AB1F5A55C2D16A9BB41977A67EE9CB
      D5CD87B6584F2CB7A0F068DBD6514D6DD736F197ADDBB2EEBBC3D7FF7EF328CC
      2EC3F8045E1F86FB6624BF09D71FF69AA0D1C1AFC27DDB991E01F4F57873A603
      8C3E7D8A464C7C5F15C137873ADBE6F3E3F9DB4EF968D706C1D39CDB7CDA8379
      2B11BFAEBFB453C5371FEB5D17AF6E7E6AB2FA7A576F429BD3D4FA22F0859862
      F8BEDEE6E3E0DB658329E1FFFEDDFBB7E1EEAA4DD03D7CB4E7D577E17D93E19F
      EA67ECDAA3F8FB7F7A17AEAE9F148DB6BDFBE687EFBE7DF5C3EE7DD5B0F51E9F
      6D3B588D5FD74FB4BFDB647F6882FFE12F79F8C7F613FF0EE57CF3F1DD16877F
      B7A1231B0DBFBC6AA4B3BDD52E6DB0FAEAF8251E5B5CFCE7FC71D885DBD47EDE
      3FD1458DC9719F3758BF09F503CBED76F523D1FF4512365F2F18ADFF1C6EAF6A
      2BB6B5D1BDFB30FC478E6D99F7FD6EDF53B5D8FC71FFC9CF7DDD6FBD483C316E
      E3F889696375A977FDDE3D61A6996B603F8CAD70BDAFDA8C5B4F882EE6B7BBEB
      7A1F95E3A49795CB69BCDFBC0FF1A1EF7D1864A6A4FDED78BF92376F1F1BE4E3
      C053E955071E77F0384A5C18F5C4ABE3387922C6D2D587770FE73D5C183E8E55
      4B63C574ACBE34F68097C940333BF064467B696075E97446373B509C7AEF6787
      CAC99C76BA3B5F85DB9FCE636E4FDAA6FA667BFDC2C14BBB68C5E5B1E793CACB
      03C7BD5C0B208A4CACC5BC3FF57F0E4B8F06AB4035337C195B3346CB209B315A
      40DBA9EF73F9FCAFF9AF57770FD7562F5F8B5527EEDF3DE94C17F4DB1464FFF2
      617728BE974F32DDC63FDCDCE79BBBFCC46A4DE2CCEEF7420ECD44762199662C
      1672EAB2C55C72CD8C5ECEB239D797126EE6440B9937E3FA8A1414EBC87C66F8
      7309784670EB52506C49C1F5843F63B102C067FEAC00B06806B06806B06802B0
      D802E053D7D70058340358340358B60158B601586E03B0DC0260D90C60D90CE0
      337F5600583603583603789DBC9919BD0EC0A7AEAF01B06C06B06C06B06A03B0
      6A03B0DA0660B505C0AA19C0AA19C067FEAC00B06A06B06A06B06A02B0DA02E0
      53D7D70058350358350358B70158B701586F03B0DE0260DD0C60DD0CE0337F56
      00583703583703583701586F01F0A9EB6B00AC9B01AC9B016CDA006CDA006CB6
      01D86C01B06906B06906F0993F2B006C9A016C9A016C9A006CB600F8D4F53500
      36CD00360B97EEA671A86F3A5EE7E93B2A977BFEA97F0F5DFCD170E1DD1B79FE
      3EE775FDC2AFA77F1274D9505C3CE71ACB69905EEF763F35FC99C07196292E5F
      5F0DD757BBF1DAC8C74FF9F3E8D3EBB37FFCF2F87EE6D361EAE2DB50E3C5DC69
      93AEC4ECC06933A4E4ECC0A9E8546A76E0A984507A76E89446D5349D46B8EEC7
      8D84371D6BE6C6F69746DBB9D127EEBBB97127DEFBB971A7CEEB599FF4C81793
      69753F37D81CB3786A20E60CEC658367C376F922CF42FCE6AE3D2D8472E61CF3
      31BD6CF05C6867AC56C478CEA735E19E716E6DDC456BDC570378EE1ACB8AB88B
      4D71179BE32E9A413EEBDCDAB8CBD6B8CBD6B8AF6690B96B096BE32E37C75D6E
      8EBBDC86F6B352F17CDC556BDC556BDCD526B49F117F43DCD5E6B8AB6D71D7AD
      683FEDAA56C45DB7C65D6F8ABBDE8CF6539F5AE2AEB7C5DDB4C6DDB4A2FDB47B
      581177B329EE6673DCCD66B49F39378DFBD811AD16814F462FD6D027E31629FC
      C9B845067932EE20011789E3C9F07522F089C13A11781EB65522F069FC660CE6
      0339AB1AE763BA4A049E05779508BC18E319CB15C19E756E6DDC1745E0A5B8AF
      06F08CC1F3513F15566BE3BE280217E3BE280217E32EB6A1FD546FAD88FBA208
      BC14F7D50C3223C95646FD4C3A36C47D51042EC67D5104CEC75DB5A2FD4C353E
      1FF745117829EE6D143E63D510F533F9D810F74511381FF745117829EEBA15ED
      67AAF1F9B82F8AC0D9B82F8AC0C5B8EBCD683F736E6DDC1745E0A5B82F8AC04B
      7137AD683F15566BE3BE280217E3BE280217E3DE765F82EF3069FF33EC37EFEA
      37696CFB94C337E1EEED7D68FB80E7BFDDDCE6BBDD75FD8EA18705B72FF7DBBA
      D25FC62F78A8DFED70775FBFB7A9EBC75B24D55BFC8BC3CD9B0E377652F52EF1
      E38D84A410594BD56BA79D4A2AEA7AB3A5DEA8FD2D98A4A9B743BA7898FDCCA9
      8BA5EF7317FAA1EF43EEE76F0AB53F64BDED3153965CCA7893A8B91B5AF527FF
      9EBC50EDCBF16665E78F8FCFFF0F1EF5269CBFDEE337EF7FBDC705EFD3E1DFFC
      BFBB92FF8BE3B7BDFFF51EBF79BF7C68948629FB1FABBA5178285488C9FBC796
      27AC7F4E256C3FC61B64EAF9BADF45139277CE8BD2A77A4F6BA359A9EABC9142
      F759CFCD2B3AE95EBE10469534049174D7CF298EFF2FC76C04361EA8C8BFB3E3
      7346E0EFCFFB7A7CAE086CF0FED07B3C1CBFFCF2DFCAC5901F}
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
