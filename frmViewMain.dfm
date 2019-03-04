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
              ' any of the following: '#39'tes5vr'#39', '#39'fo4vr'#39', '#39'tes4'#39', '#39'tes5'#39', '#39'sse'#39',' +
              ' '#39'fo3'#39', '#39'fnv'#39', '#39'fo4'#39', '#39'fo76'#39']'
            
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
      Width = 730
      Height = 20
      Margins.Left = 0
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alLeft
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
      789CECBDFB73DB469628FC3BABF43FA0B4F72B5333124DF0CDECCEDE926539F1
      1D3BF65A76B2FB85A95B20D9241181000700F59854FEF77B1EDD8D0644489444
      C6F4B0672A2605028DEED3A7CFFBF1FB204E27EEC01B8B49E08553B7DE680FBC
      30F1E99FD162EA36DA8DC172C4774C9A6EBBDE1DE0B7FA204993D9643C1CCDF0
      629BFF0C22FEB3C37FCEFCDC9F435F3F8FEF6AD67BAEFA3E11F0E6DE209D89B9
      D0BFE9BF8ABF8E92FAEF834914A6E930802FF5010C3DF69DC1248EE65E38988C
      665E9C8814AE2FE27F347E1FFC65B0F0C228114EBD01FFEFD49BF576BD05FF35
      E05BEB8FCFFE5C24CE8FE2DAF9848FFFFB1F30A4AB874CAEFD24B97FC8210CD9
      A2A1F9FFAD3F4E63DF0BFEFD8F830A0CD5D043CDA3B1888BD373F36375614A7D
      1A05A7D782B1CEA265EC8B182748536B96ACB671776AB02F75801CFCD78529E2
      90DD3F2E6EE7C328E04566800BFDE0FE81EEFCEF8F9FFD703A86FF12B9CE66EB
      31DB80E0E76DC0ED40989D79F32180CD79EFA5339A5EABF928C8E12E30E45A6A
      C4284CA2C04B78B18DE6E3F694E1DF903BDBFCE3424C23E17C792B971BC01A7F
      8BE2019D892D60E078688CEF968CEF363BABDF50D8B03F3EBE879D7AE77FC1FB
      265E903A8317C3EEE045B7099F8DC18B317C7AFDC18B893778316A0F5E88FE1F
      729933DF9846E331109CD02EE4F6C30B7CD862E79D3F9DA5B4C8A1397A19623F
      15886A9BFC50BDE15118BAF63665E3B7BFE63665D3E83C6E9BDAABB7496D5036
      6E77F3E06BB5FB65E4ACD9E3619DC273CED9B95C74AB5376EE1AB8D5AB1FBE8D
      F9C59D46D96675DC9267BF8F85B8944F9721ABDB69943CFD79A9DE5C86866EB7
      5BF26CF507318CC5F5915E7829A675CBA0563D8DBDA13F3A9273E8940DD0EB94
      0CF00AF0D11FC9C7CB50C145C0AC7EFF4FBE48430F2E0A35877E099E665B4F7C
      D4D8F06EBDEC11BDE1F211B5CDDD329A956D333F616C6EB78C53649BCBCFE82D
      EDB6CA9ED05BCA4F1437B2DB2E7D300F83FCF675CB8E78B67DFC98B969DD6EE9
      B29AF977DDD9AA6EBF8C15ABBD721D434E3176AC572F7D526E59E149B571BD52
      B949ED5CFE4163FF7AA58283DAC0FCA37A1B7BADD207E53EE61F2CEE66AF5DFE
      FC2A30E537B5D7297D5AEE6AFE69736F7BDDF2253757BDB9B8C5DDFEC384D894
      D0B22DEE954A3FD9A1CC3F29B7B8577F9804E71ECCB6B8572A2C644734F7A8DA
      E25EFD61C2977B5001592EF561BA977BFA0E987BBDB54E12CBAD04637CA8BFD6
      21520F29F0F6D73A41F229095B5E667FAD03249FD4A0EDAF85BFF22903797BFD
      B590573E7807A46EA7F7302351C27B86B66EA7FF3033C91E934085A71E6628FA
      A90C61E1B987998A7E4E81149E7A98B1E8A70AD4081E7E98B9640F9BA4081E7D
      98C1E8478DAD84071F6632D93B8B5B99D3A97A4F170C73E394D2B50765447318
      B754055B435CCC0D544EF4EE951CEF2CCC2D25816B8891C5B1CA45D2B5E4C9DC
      58A5B2E983A2E5DD359652EBF5E54C53916E3CA0A83B4A01737E16490A94E859
      FA72A3F7205DCAA9C48ADEE7C628A56D0673CD8D2191D71CA45966CE3219AD39
      88C90D72039513BFC6CA811425CB0D524A0935E2E607C9A16D6EA472EAB81AC0
      19D2DE5D5A29B1340403732C83ECE5C629A59C8688909B5311614DA348F31954
      3037CED3A9A0394CEB39543037D073A8606EA06752C1DC58CFA482B9B19E4905
      73636D800A9A76B0D6D390AA38CA1351EA8E59AEFD4CD69A0DF444A42A0EF31C
      94BABBBAE7B3D66CACA7235571A4E7A214ADD3347E96DAE236C15A0B16CECEFA
      8C3563A9D9D3EBB3D40C61CD01BAEBB3D30C517303ACCF460D069A3DBE3E032D
      20666E94F599670E217363ACCF34F3EC321B617D76B902014DF374F7C9542D37
      CAB318A51EA6F7649A76675DBDA753B5DC30CF6794D958CFA1697717F82CAA96
      1BE9B9540D061C454114A7C3E0DF07B118D70753D895B03E18064B51BF7BA9D1
      6E9B17E1CFFB2ED7FFFDA08297F1EF1583142ED7F317B341565E2EBC9287701B
      3DF322FC79DF651E19FF5A3144E172E1DE9221CC17F2D2DD7E43FE045FE8A77E
      632D48D771B3FF82E102A3D9028945A331C0688381275D5E186BA0FFC0B004F9
      47DB510F2E3C78F01F813308FCFA2086FF12CF05AE95048D761FFE9D2F83D41D
      5CFBE3511A2CBC78701D7B0B78CA83CB032F5978C162E6E197703907BEE52DD3
      68E08D7F5B26698C623C0C08330DF01F3FF5167507F07C1046FF00AC8BE6512A
      9CDF07497A1B88642644FAFB9F378D419C06008BC928711D09912E7C22F83C15
      F001534963BEA9EEC0B419B82A0AC308C020803F04EFC1681AFB637A2C5C1823
      840B1CC31924A1B8496162C93F26513CF780FF278BD88F623FBDAD3B3FE2258C
      4E8069246E1E4C43B74EC0C27F87B87017FEE2CF47812B5AA6002011882B11D4
      1F01BC21ACB08EB003F97935EC06C301FDBA0A769720F2800004EAE1FDF0C185
      0FBD448CA3B02E81052F4F6056976E7B25D4FA0EA2569CF870F0EADDBAEB769D
      99F03034C371F1D4248DEDC3D17D0A1C0116191C61DD4548C2EFAB20F9107E15
      A0D750D0EB3C167A0D8987CDEDC3AFF114F835BAF7E121FCFA78E8ADC0BEA682
      5FF7B1F06B32CD8659C358DE78ECA7FE9580DB1331F767FE782C42F86319C257
      B184571A83BACE6B869DF3D18BBD29C072E6BC89420A1AF90BCC314D5C17FE89
      A3EBF1208D2769F2B33F4E67AF9AF0C7025E14B8F59EFC1A675F2781FA7D92EA
      6F43FD2DC66FA3E1C203F20B5F26FC65084B074EC49FE9ED42C05DC995885390
      40E0DB301EC7EA33909F43F919CBCFF134D0DFD4B599FCBC7A9023C16ABF1E33
      F8335881EBDE83120715E608CE676F18088D4F6D139FCA88F49D235167EAAC29
      71462B104119C9F1331A5DE6B071058AFFA008AC730612A69E57E7E179E16B57
      CC0B2E1B674FCFA7F1C8F934F2F3E93E3C9F4677E57CF0F29DD9341F399BA69A
      0D71F3DE76C8E823109E17DCBA07D95B9BA1996E2F27D5DC01D03C894225E9F0
      4EF54B776A52CFCF72190C4693466177CA496A716B8084C5B897EACD8DFAE3DE
      EC36EE20EADA2F7F130541742DC6B949240D90F3461962649BCFC414FF4DE8DF
      6B17749D3859E094378B182E2286DB291789AF2824186FD98044A20F37EEA206
      DCFA5BF8F9FD3BE773B470A20940349EEB9D6C94EFA45C607E3FF5A256939E1C
      2DCCCDAE30A17F9E18B3D104286934EFD9D7F45F795F5B4FDFD757519A46F33B
      5BDBDAECD636D7DFDAFC848CDD6DEF38396745F62904FDAE0AD1BE9F9C2FA204
      B6260A4F621178B8470CA1CED7851000605B2CEF2E843AF743681C478B71741D
      6A842E974C8A5C2787BDF7BDE2C40F519F3A192266B39D915ED5DBFCABE46A4E
      465E2C52BDA6F579F8BA2F82FD9E455A9C6BAECDAA8B87FE3EDCF5D2D9C9D8BF
      02B294BDC8BD5F6E2C488C85F5DCD51189D115DE7B91C65138D56FBC87773D79
      69A36819A6C6AA9A1BDF9F582CA293388A340E34EF21D44F7CC741E5B7E48476
      2911D3B908B377956B414F7D5722800679A98172E51ACD53DF3109222F3D8955
      0E08BDE55E6A50B00CADFD1E3F104012269189DD4973D7B5900DB2AD66EF31E2
      8754B4AB3F8BE191DE987B485A8396514002CC76A38B4F53100E2A24049D4563
      66A1AD7A6EB7B21D496FFA20B3A5376EAFD9808F4617F4FAF4A6D9E9B4E0A3D5
      EED5E1A3DDEAE32D9D968BB7749B984178D36BB45AFC34DE02DBDEA561EAFD3E
      DEE4BA7D3417DDB80DB80F3F9BDD16DDD7EAB43B1B460309BF7213A884E52630
      A1A524BFD67DC696D512E9C75830414FC558E145AB9C41DC8F17ABA4519EDC3A
      D2E89DF9E4AC1DAD721EE2DF2557FEC35C6B0551399FC39E277EA2DFB9364F79
      0C4B0E4EB47ADEDA3C4381E147D226D3DA75217E833699D60342FC3C3ED106EB
      D616D85E87DCCB7F015024698AD6CCDFE92BFF2DE60BD01C843F3E717B4084DC
      5EABD7E3DFC93D30A07FC3C908746AF53554DF7F1BD5D597B08E3404BF4FC8D4
      227F48522F4ED19CCD7F2DBC9190BFF8211CB4B4FE3BFF950298062FEAEE6079
      D2ECBB4DE77F233CF87DCBF950C480F6947F9C701CAD471BE49F343BB8C15DB8
      F8DB48AE0E096E83B61D3ED003FB84A5DCBB902B986C9892B265AE4A2D7FF5BA
      A255EB6994ACC76DB5F20BA20B30327EFE894B2A5B102C556D15681E2BB7CAAD
      97ACAD81ECCF5C1B5D8097E0E70EACED8195A18C54BEB65EAFB036BC806B83CF
      DD5FDB3D2B837F11C1CDB5E1255C1B7E7ED36B6B350BE4832EC02BF0D32165FE
      9B5D1B2641E7D64617E015F8B9CEAE29AAB68B6BEB1628095DC0B575374349D4
      DABFC2DA3AAD0225A10BF00AFC546BC3D8310786C1EFC0EEBBBD7EBBDBE8FF51
      C2DC5DB7E976FBF5766B1B9BFE2FC2DC71E14FD8E36F9FB913917B3EDAEE3A73
      7F96E0F26D33F77B0517E2E5FFB2CCBD20B8E4D9FB37BCB60798FBB72DB83C97
      B9EFB0E0F204E6DEC608F35EBDB39AB937FBF556B7D1CCE9ED6AFD008D7A0697
      FA6381B2161C1AF05FBD56840102081670AF09E3C95CFE81353D608B78FC56E3
      12DDE72DF1098CFFE93BF734490657D978DE2A9F20023C073F9F628CC155369F
      B9CAC70B035B58E5BD620EAEB2F5BC553E412CF8135729D7D8BEB34696F2D65E
      E503FAFF6EACB2B3EE4E163D39CFB004FCF9ABEC3E0F5F513628087B0F8B0D7F
      FE2A7BCF5BE503E28312FBF20244A3D3751BDD7ABB5B621E68F75B9D0688186B
      5807B622423CD93650D8EFED9AFED75BCA9F6B0ED8614177EBE680AF68A1FB9A
      E600BDEC2D5AFB77D91CF01C33CE13B8FD2EA9CCF79A719E6DEDDF594AF224CE
      FE8DACED69FCBCDFAD777B6EBF596EEE77EBBDBE5BB7FC7CB37BBC25E66E986B
      BE11B4DD1C73CF24989D59DB9FCBDC9FE876FAB699FBFDF132FF9ACCFD3982CB
      37CEDCEF175CB6EDCAFFAACCBDC0D21EB6F6379BA0A8371A3D77357377DD7EAF
      D5EA74BB4F8BD3FB73993BEEFB4EC5E9FD59CCFD9B76BF3D9BB9EFB25562DBCC
      FD2B5A25BE2673DFB655C232F79DA52496B93F82B977DA1887D72BB3C4BBBD4E
      A7DEEC36FADF82EA6EB9FBB788B796BB5BEE6EB9BBE5EE96BB6F9CBBB79A2D64
      EECDDE6AEE0E34A8D3EB75DB5673B7BCDDF276CBDB2D6FDF05026279BBE5EDEB
      F0F656BDDEEDB65B2551F8276EBD57EFF5DBEDA6E5EE96BB5BEE6EB9BBE5EEBB
      40402C77B7DC7D0DEEDE69D6BB7DB7D52BD1DC4F3A9D56C7EDBADD8665EECF5E
      8A0DA2B341749BC63D1B4467F9B9E5E7969F6B7EDEEAF4BBFD66AB24880EB4F5
      76BBDF6FD6FBDF42CA9BD5D6BF45BCB5DAFA3376CD6AEB565BB7DCDD72F732EE
      DEAF630BDF326DDDEDB5DAF54EA3DEB1B678CBDD2D77B7DCDD72F75D202096BB
      5BEEBE0677EFD61B9D6EB7552FC96E6FD47B6DB7D1E8D7AD2DDE3277CBDC2D73
      B7CC7D17088865EE96B9AFC3DC1BDD7EBFD7E99466B7F7BA3D50DD5DABB95BE6
      6E99BB65EE96B9EF0201B1CCDD32F775987BBBD3EE349B9D4609736F01545A9D
      56D33ADD2D73B7CCDD3277CBDC77818058E66E99FB1ACCBDD770DBA09BF7EA25
      4EF77EA7D175FBED86AD5C6399BB65EE96B95BE6BE0B04C43277CBDCD763EE3D
      EC23D72A8BA8EBB7EACD76A3DFB2AABBE5EE96BB5BEE6EB9FB2E1010CBDD2D77
      5F83BBF7B1FD3BEC6A0977773B4DB751EFB5FA1DCBDC2D73B7CCDD3277CBDC77
      808058E66E99FB3ACCBDE776DC7EA75F920C072A7BAB01ECDF2AEE96B75BDE6E
      79BBE5EDBB40402C6FB7BC7D2DDEDE6A00C6F6FBAB797BBBDBEED55B7DDB2CC6
      F276CBDB2D6FB7BC7D270888E5ED96B7AFC1DBDD7ABDD9AE775BCD923C7760AC
      6EB7DD685AE66E99BB65EE96B95BE6BE0B04C43277CBDCD762EE6EBDD7ECD7BB
      6505681BF576B3D7EEDB1A3696B95BE66E99BB65EEBB40402C73B7CC7D3DE6DE
      EFB9AD76BB44733FE9759ACD56BDDBB53E77CBDD2D77B7DCDD72F75D202096BB
      5BEEBE0E7777BBDD0EF0F74659A27BBBD768F7FA3D5BC5C67277CBDD2D77B7DC
      7D270888E5EE96BBAFC3DD1BAD66B35EAF374BB87BA3556FB7DABDB6AD3F6B99
      BB65EE96B95BE6BE0B04C43277CBDCD762EEDD7EABD7723BDD12D5DD6DB6BBAD
      6EAFD7B5ECDDB277CBDE2D7BB7EC7D17088865EF96BDAFC3DE9BF54EAFD368B8
      ED32F6DEEF749ACD46A76D0BD958F66ED9BB65EF96BDEF0201B1ECDDB2F775D8
      7BABD568B4FBCD72EDBDD5ECF5BBD6F36ED9BB65EF96BD5BF66ED9FBD7A62496
      BD3F86BD779A9DBE0B4CA28CBDBBAD6EB7D9EB58E3BC65EF96BD5BF66ED9FB4E
      1010CBDE2D7B5F8BBD77FB2DB7DDEF96D4A1ED75DABD6EB3D9B619EF96B95BE6
      6E99BB65EEBB40402C73B7CC7D1DE6DEAE371AA0BD77CB4CF3AD56B70EFCBD6E
      1DEF96BB5BEE6EB9BBE5EEBB40402C77B7DC7D2DEEDE73BB6EA3DEEDACE6EE6E
      A3E9F6BBAD966B4BD15AEE6EB9BBE5EE96BBEF0201B1DCDD72F775B83B7687AB
      634A7B99DFBD03AA7DB7E9F6ACDFDDB277CBDE2D7BB7EC7D17088865EF96BDAF
      C5DE1BAD7EBFD96C9798E6DD46B7ED36E00E6B9A7FFE5236C9D08D352852F7ED
      A0EAB319BA5E59C6D977666DDB66E8F9952100F682A19B2B53BB6E19BA65E896
      A117187AB3D9AD7781AF9704D2B92E96966FD940BA0DEFB1D5D6ADB66EB575AB
      AD5BE66E99FBF6987BA7E5BAFD465994FC49BBDEE9B9ADBA6B6DF196BB5BEE6E
      B9BBE5EEBB40402C77B7DC7D1DEE0E5A7BBB053CBEACEBABDB68B5BBF54EDF16
      A8B3ECDDB277CBDE2D7BDF090262D9BB65EF6BB1F7BEDB68F65BDD7E197BAFD7
      FBAEDBE936AD6DDEB277CBDE2D7BB7EC7D17088865EF96BDAFC3DE7B2E206CA7
      5B2FB1CDA3DF1D1EEEF46CF959CBDD2D77B7DCDD72F75D202096BB5BEEBE1677
      6F349AF56EA7551256E7F6FBED0626C159EE6EB9BBE5EE96BB5BEEBE0B04C472
      77CBDDD7E2EECD46C3AD379B659EF75EB3D3EEBBFD868DABB3DCDD7277CBDD2D
      77DF050262B9BBE5EEEB71F7A6DBEDB79ACDD5DCBDDFEB369AAD9E6BA3EA2C73
      B7CCDD3277CBDC77818058E66E99FB5ACCBDDD6BB9FD76BF34AAAED5ACBB7DE0
      AF36AACEB277CBDE2D7BB7EC7D17088865EF96BDAFC3DEFBF5AE5B6FB49B257E
      F713B7DDAF37312BDEB277CBDE2D7BB7ECDDB2F75D202096BD5BF6BE167BEFF4
      DA583EBE8CBDF75A9D7AA763C3EA2C77B7DCDD7277CBDD2D77B7DCFD9BE1EE8D
      7AA3DB86A5775AE5B6F976ABD96D74ACEBDDB277CBDE2D7BB7EC7D17088865EF
      96BDAFC5DE9B0DB7DE6EF7DA253971AD66CBC5A439CBDC2D73B7CCDD3277CBDC
      77808058E66E99FB5ACCBD855D624ACBD9F4DC4EB7D374EB96B95BE66E99BB65
      EE96B9EF0201B1CCDD32F7B5987BA7D9EEF77B8D7A89E6DEEC345AF5B6CD77DF
      C4526CD7D74D3174BD32DBF5D5767DB50CDD3274CBD03543EFF6EB6EB77F4F6D
      F97EA7DF68745C1B48B7E15DB6FABAD5D7ADBE6EF575CBDE2D7BDF1E7BEFF73B
      AD46B7D3FC037EFF0B5D8DAE441CFB63016304E2F7DC25F954B7DD69779AA0CA
      E77E1C454B58CB204854ADBBC253CD66BDDD6D347AEEEAA71AAB9FCA3AD3AE7E
      ACA9795BF1C156ABD168F79B9DEEEA075BABDFD76BB8ED6EAF4E805BF1547BF5
      53DD46B7DFEF753A256BEBAC7EAAEDB67B9D5EBDB3FAA16E0940E055AD5ECBED
      7491C6AD7AB0B7FAC146A70BCFC21EAC7EAA5FF254BF5BEFF6DC7EB364AFEBAB
      1F03A9A3DEEDB65B256B734B70C4ED345AFD7EB3593649B751BADDDD5E1FD0AB
      5FF25CB3E47D75B7DE6B622A68C973255892A597943C5782276E079EACB77BED
      126C764B30C585E306FB00E029DB74B7045D328B5CC97365D8A22943C97325F8
      92E5D5961CF31284E9D6013FBBAD7AC9EB1A6ED9C6779AA0A2B8AD5E09441B65
      74A55D6F349A9D7EB704D31A6518D3AC777A9D06508992E74A30A6DF6B354036
      E8972068A30C617401D1B28D6F94A18C6E1B52F25C197DD1CD424B9E2B41987E
      8F90BB5FF6BA327CA9BBF064ABDD2ED9F866BD9CC07760FF5CA0F3254F96D098
      56B3053A6DAF59C650CA10C6ED7661756ED9416A96210C6C7BB35EAF37CB9E2B
      2331BA307CD9CE374B70065858AF8F5EF692C7CA1046B7912B79AE94C2281341
      C9732508D369C163207695ED43BFF4C4B7E0D8F69BAD12046D9550181756D672
      DBFD3249A25526B774DA2E224C991C51862FBA7E50C97325F892E53694ED7BAB
      0C6300C9DAF52EA05BC9736534A6DD83430FDB58C2AC5B25080367AFE9824A50
      8267AD527C51012025CFF54A4FBCAEB758F264990CA3E349573FD7AEB3F41B8B
      AB741838BF7F092FC3E83AFC77BEBA982EE82A7E19F8F08FDB1DF8A9B7C0F35C
      1FC4F05F3284FF3C443B750B1CF6876EE93F7847A39DDD02B8B0FAA6875FD47E
      F00ED77D782E6B4CB7B581A934CAD68328A16FEA3DBCA44D4CC66D3C3CDF8771
      E1E1C9AE31933620C0C3373D7CCB8377741E1EE361946BAC81500F6F90DB5903
      FF1FDEA287A1F2F43B986C24FE1829047D698150E9F6E96B07C915A89FF81D34
      13D06B7AF41D496DDD25817D3EF7D2D9C7983FDF4461DA6C0DE6C3F8F2951FD6
      D5978BE510973F4FE65E10BC89BD11FC32F693C56B317107F3E0BD174FE9EE58
      7F1B8BC9FF19C16FD7B1B7784B2606B206CFFD307DE7CFE14BE8C5B7F00D199E
      1F4EA2DF07DE329D45B1731EC03D492AE2D32FF053B410B197C2E5CFF01B5C0D
      9DF3701A88187E1AC5C24BFDF9E0366E80FC3698478DC1F816F66B1637F0356D
      64F9484D57DED2C45BF0DD4087133FA2AF628C6F469618469385371549BB4567
      1EFEBC8EE23168621D52AAE0EFD1CC8B13846DC3F8FB3A01519E64371835EC77
      796B6EE601AC87A8377D759D599A2EBE7BF93219CDC4DC4B6A737F1447493449
      6BA368FE329A4CFC9178892F7CD9006E4ADFE6C11F7F0C161E00E3DA05EDA6C3
      DF676E0745C839C03C60E8C2B7587F4BF5B7217D9B2E53002B20501A276294A2
      27E2DA1F47D7A3340E0693341CFE36F044381E47A3410A5B7C39072695D4F9FB
      248A013D523F9CBA83711446A9980FC538B94D2680302EC039B88DC2AB795037
      7E0DE0EEB1977AF0E67802A38A2BC00218F0CA0B7CB82E001AEE209945D78BC0
      1B8959148CD1FA04277B1A46B198FB37623C82D1D13A05887E25FC909EBCC1B7
      E063F0059828A0850B3B7013C0F4A25B11C2AAC4CD2299C569089797B0D82059
      8C06E310B6204C86E3215C25FB172C6909EB868525330FF83420D83F71EDE3E9
      9C9018BECCE846B707AB9A5E19DFE1567FCA7E0DFC25F7D70CA7E6D203F805CD
      61301F2F1C0FAE7C717DE9876397BE25232F106EB30DE77B188FE399F0C6F2EB
      248AD241B2086ED3EBD00F056E8DFE3E4BE7704E92052C220867A937FE0D9635
      58262248875E100EE03FB8002F19C023F08611FC754D7FC097389DC683208423
      0D2B1730047CBB8E51B21824A1B748A32988247E381241000305D1F5C417011C
      DD310C3F801B17CB7084565D2FF13D3D0A52931866AC28CA2014D7306292DEC2
      CF09BC641A47D730E768E2A738D110019EDE02DC510E82DF61B221909934194C
      044E4E04E20A2E8F6E920599FF803C8C610FAFF1BAC03DF526233850386B6F42
      372F012F83C18CEE40C0A5402DBD18EE4C47571EC12A85D9E2439318018217AE
      BCF4667833B88CC3459C84221D8C3C388E807001C0D141CCF1E1342EBCD48169
      A57524037F195C03224FE6E9C40FE020398D16086D78F8810E2D6391CEE2284D
      614F077E3089E6DEC84B4741B85CB4E9C4C1849C011EBBB1A30E2050F250DCD4
      07B8F522BE456114B75E7E85992437F805E01FCE442CE8697C047709EDAD349A
      987880E323D8413AC10E498B21FC145CC1E95A84CB513CC70B680CC6BFD9DC8B
      8EC64538F3C229CA94617A937A4E4D8A9AF26154F9F07198EC939E6FC237906F
      9FF46C0BBE05EBBFF928FF747BFD370F9DEA1F65C37408006B4FE3BEA1BA34D0
      7A1B71DF38BD4D4DA8BFCE8448DC5D3512709F188855E0F9A123717BF00F3834
      9964026A20906CFA7788671FE8BCC79FC071008BF109940C24FA02455978C162
      E6E19770391F4CE8EE41B4248427FF437D00C46E99A4406B6729BC2624B78292
      036140CF946B40104A83D16C301901BF053AD174412B85CFA4D100D206AB43FB
      204D9E6F62BF3CFE8A3F36EBE821802F1301F7818E18C15D3C08080FBEF1C778
      A8FF680F467832E9B970610C112E7010D896DC9486F0581D67D4EAE5E631180E
      266E0363065ABD01C06636B804610258691344D13031173940A923B7EA9F675E
      FA227180043BB03737E7633F755AB57AADF1BF11998104F1DEFD79BBE63E6ED7
      CA60D4EC94C0088042307A10327F8F4EDEF807953F110CCF5938AFBAD1CAAF5A
      AE19D59687967B503975D863E7441307D86E9C385E7229C60E305EC773AEBD5B
      278D9C64B95844712A31658C3B162DE640069C6B1FA4F1650A8F02EA391FBD34
      1651E88018F3129EFFE8DD7EF4829A04E6DBD4F101E7A26B671125890F2CFBE1
      A19D6104FF4421DCEACF058EEBCC41D69B05B70E089020D74761E25CF91EEFDB
      B1830B9CC2ECC77E8C5C9026EF39A002E0E023DC4B9E28027C21509076AA3051
      1C81277B8407E2F4CBFF5293FE3C133C36FC3E15B800D81E840F3E92EA1F8720
      33C3BAE159BC96460B8736D4194571C8B0C5EB73A4842849D6F6FD981D545E2D
      A71310DD1309093686915B39E31A5A202A207D01DD65E0D4832FD5F45991E33A
      13E949D319BC1876072046FEB162477261586B6F4DC1BF8DCFAEB15941B27A8B
      BA8DE226B1F2BE7182F06F9D66CB39717E79F3A1F5AB238D8BCE47115F82429D
      C6B70B10C353C76D77776CDB60DA1D98F6E9788CA7DB7392119CEFD499C4DE94
      68099181FF5A8A04D9DE4FEF4F5F3B401F4061062A2292F005D0AF05AA9A744A
      D5436768737548B7D9B1D51E54AAB140AA097408A8CE6B3FC1B51C0100988A82
      562C280AC3A92EC36B0F74E371700B94AD408580BA27CEDC0FFDB9FF4F18E97A
      268082A57435F012205E41948884886E0C9003653B810140D5015930153B0693
      3288FC8CABC26527184D022A191171B4138C9DF4DA1F09E233BE710F88BE5138
      3E760890091CD604E9BA173A2286530DDCE27A86A3C422F4E6886D351C8C464E
      F0DDC96C998EE1D47C23F0F9E5CD8F3FE14907DE3F76606F110CA04A22CB7AF5
      FEF56704D6751C8553E4B862028C04EE0296EBC53E2ADD4E02A8E35413900102
      F8210079217186C2693AC3DB5424475A92DA75309C4541E02D483680954BE280
      388F5CBF4AC0A1F3E111857909272CBAC22F090C860FCD3DB44502373B023123
      7496A024C5CE48C4291EB6911F8F96733835E1087084914AE2949780CC954A94
      02028B63A154842845C408AF63FC72BC63802CA74187AF8558004017B788291F
      A407EB90482D887F405766627429614C676B04AB1F3BD3385A2E120673104597
      080A9442256899F48402CF6D8438065BC1DF49E442B92FDD3118DD4B935810FD
      A3C8C01BC4C08BB36AAD3BAD83CADB1031EACEB8CF150C9C4B71ABE4DB9F7C71
      4DF4D1E70D35E579382ACE591A07F87D12F80B7AE0F04D345A92BE096484F70D
      045264B2B4FF38DEA1132D509CDFB52D9C801430066AA6541311E30E5E7857DB
      D8BD9A48E67FFC8E0EA4CDEE1D9CA22D4C35D838921D54241F556AE5F9C57BC0
      228F09C1C5C5392B6E0BC09F0F3F9EBE77C803E411B3BA8E7D22C480951ED2D8
      7F2C41051C3B5544BF29B2F514FD4089313E6226202BA09808D1B7A3D8173C3E
      E3ED85B71F7D1BF8B8E9DD0541FA3D93DDEAD1361012792490F0911704C85971
      3730DA5712792F164457C88F030AFF78194801EBDBD80D341A84804253325020
      E60974E58054100A900012109E800E121B44023A46C19164F3390BE784AF8AED
      21E68FD0D0FAADACFE97CFE717ED9770587F757E260E0F6BFB185D833C044BBB
      F8E1C317478A8BB8C5C8C7037F1AA230F98D2CEFCD87E64B129A2F22D4168020
      85530371D3D80B1390D8483C56988C346CCAA273B21CCDACF9E7BD172EBDC039
      0B841792A0873E43B2E621C8C66201E22148BDE37D31C496C3A3FAE2F4A0B258
      00C178C3FE442408EABE17C7CE8B2FA06B042265EB28489984789FC44480860A
      D4066EC11F5E7C42950544B1B7E8BEF181F2A284C644FE5009E32F08FAA0FEC2
      D404B2CF68984434B662987086D31808324D0E4FF68BFF5AFA20CD9F02047956
      2F9060F364AEFD2020836F14C2F4D1CFED78CE1C09E014F92E1D6C5278667EA2
      4CA2EFA3185FC28104C49587280814DFA238089F51924B4118957E8D1F81D68E
      41E224D34F157E9CC3B6FB0B000B8510A0861A4420C1A2AC4A6ABFF060D334CC
      8FAC79B6F2CB4F22BEFD5582FD0277EE2C0A419E1FA5C9B1BCFA0BEEC6AFBC1D
      8C63B43DDF23F37AE787F0D87208DB39D67CEB5FFE101F543E934899C0C2E78A
      AD93458E8E04A22C9E06E479239403847247A4243000DCA4A340DC08B20F8CE1
      59922058AF825F710D73818281F650440A8FE15F7AEBB1731B2DE96D64A3621C
      07CE236AD3DA773BC664BFBABDBDF175EDED78CC569EB2EFD693E9D11DBDB654
      0F920B6223BE935E896FD42FAC01D26DDE6AB005CD134ED9F9458B16F25F1767
      5B99F68E1D9267E0C7A3E00A323B82F51BC60D543D68098F400C4AC2FDB65123
      938BB68116A0EC68B4C037D18BBE199478F38168C57F9DEE15466C091914E5A5
      971878F04D982C1579DB1344C84BE39BC70579B0F035F8167C0902F6A0F22D91
      85D3EFDF6D171BF650E9D16A3F69FCD267F4B31F8E517EF116CA728057DFA3B9
      937F3A462D67EE5D0A34E10B2FE1C03321D8B2C6810D330F7577113A148D2A48
      F1C7E0301E4DE93F567DAF9CA3FFD90BF60707DF86A0297B810E274423990442
      8635E47954D8C11825CD48AC28933779D38446CE02DFB63599491D07B2D26D5E
      6F3C11BC86CDCF1D76465B34D4C69C3A1C75B688A36120E6CE6819C3F66030A7
      2FCDECFE44EF2D062BA117901D49921C007394B6C3708C8421E4080A070DA063
      8E051BFB133290A6D9CD04BC8B5478F363FEC822168CE8B0584C81BB83D2AE2D
      A21C454D53E081161EFC82AF661423720838B6242707F9C581E0A915BC489CD7
      5EEAD143B53F35F0784749D71B4C295AA64EB7B33FD4EB354656F96CEF9F61E8
      0F912BC63A46D8D188A31123F4A2614A63C231DA7347662622EEBBB57AAD4598
      87DFDA8853A399E58768D990615A2028BCFDF1CD07E5EFD81F0CFBC8C454463E
      100C54E85A867018903D26FCC9DD0064179780FE1874D8DF3A822899748DD2AA
      395D00E8DC94BCF8D7988846A1188B45E003063AD5CF7449797E318E724E6385
      80293199C4756C57BA8C2910359A4CD8AF8017646C075C93966D1544C7011D43
      81376010484AF19E5EAAC4D0D4B817C9356C3CE606F012010944CC2167310692
      C08A74C08808A73ECA96B173F6F79A8A0379E58D2E31500D61144EA2EF72E884
      6F8A028EDCF363E72386A85417B1B8F2A36542771EC12DD23147C19607150CC8
      8D384679266EC9FF16441EC829C70453726B014CAEA3F8524D3DB8959C488E34
      3627E1CC01CD8C3DE5C1E03B8C266AE82DF046335FD024FDE4383F7F23BA2EE1
      C035243CF15846251ACBE2F18A608F6837CCDC093C7812D42CF867223C60066E
      0A3C74A8EF3A74AA0AA3E0FAE778298E08030EDFE066CEFD84D34C6006F93B81
      692482340800772262193DA9613F1418D2132D61AF110DB359A1FC80E885BE4E
      40AD0CA38FCC55AC0AE6204F4E760050D749E8A5342E8534C2EE20C579FDF6F4
      9D19EE883731E2C17F3E8A2493389AC3E5838A86EF95172C01ADAB3A2A991F20
      C4D688028B8E1CCCAF0FBC5B967ECEFEAE641EF9005CBB46CB40F6108855D2F7
      6420FB91194A25B71E7E7E03A7F4ED6BC01AC44215B343B128A6E78AB2AF6F52
      07B07889918E788D9F849F82E51C369D525795D2974133D1E0CC441F74DE665E
      2E039375BC27BE2F8E02A9F2A5D791C42D0097AC97424809A022DA92619CD044
      403D70CD9198627CB479FBC809621922C3168C0BC79B9FED8FD1A3E6BBA1D962
      E1A0A7CD1729021E952DCC168FD016E09BCD78E3E6522BE2553020F40BEB6918
      74B03FA21D47C232EF4930940EAB0C20ADF5D02627A50249F7289D4052E39483
      6528B701A82A1AAD49849334744C3251C6B4C47C11C15A6E9DB3F377EF32FE26
      A3F68DF16B32D353C7E0922D4606F222E760890DB51A2C1E7150C9196D505E21
      C6A2DFA7261185276331F7C255525A4DEADA5E8062DC6D415ECDE4269454E0DD
      04B295D35207C9C0261DBB813ABC041671257EE56489AF28BC10638D05BF46EF
      41C2FC5A49CA21704AF3F507159E00091C8B65BC88124A553272643DB2354841
      0A83292FCEB1CE0D4AA96F3097525B503574109AF43686391A4B262C0A901C24
      634C6BCE9B650C57E3158157A9C1FA75B055F1C586AC140BCE0A40793AC94257
      8AF0846960900A0824987D378DA484C9912C5EAA63B1EE7D1BBC64A9D2D7E1BE
      C23BB23018E1D3E264348C9F6EC3CC0793CCDEBFA5A0046DEAA3343D657FDA38
      A7CAD6B17983DF0A6B1FE2F407C6E9C3530EC1A7F4A70F24E5E78DB75AE8275C
      4F513FA8A9143F403B390C2AAC232C637D6C9AE0E8ECF39924B12FE1207FD410
      EF9201A7FAB34C414010F3B8C7EA110F0FEF49F1217E0B252838F820BE49EB8D
      3447C056D263EF202A4D5E9E6B652E545A095B3175CEA2CA5414546529B9A370
      C951F4898D473C4826AE6F1C5F78D32E607A1FB6218FDDC5993D96726AC3C47B
      591B7A0DE707400B2C9DB52F820E9FE4642146FEC41F014F1F137A3B2BA4E9E7
      A636018C378EC52F379E800548B08DC00B4D70B1AE15C67E07288251E0F43863
      3A0C7E345B6C7A5DAF2E4EE1B12DE8CC1995448986AC18C854929CF8F9F9FCA2
      B9F95CB96D2014880318B50E5C8EE4BA6B016CC3CB2F86444D19438CF1FEE286
      540316F138B3E8CD077618BCF9D0EDE81BB683AADB5BBF516186456C1286134C
      CFF19364A90DD22A1FFB5BD95F16DAAB18B78D698AB1E75C45FE48A81C69C0E0
      2515A509A5BF3267E902F9E863044ADD4CE175FB084E2D5ADF7309E802B88848
      12CCB85EC834741231515A20926B996EE5FC668149FA2C05EE8DD388D2DBE49A
      0D332C3AD10F2AD28D8EB23B430704726F286DCD28CC62C6CF95CF69E152D9FB
      3B9ACC3145C7F91FF8EB140EE46BD4FB2C82552E66F07A2A7870B11062FC8AAA
      49ED0DA21D543EB05273F8E5AD7321159B43C4A7638962870CA01C74D62EB6E5
      54A5258AFC7348DB8E0E95A6B83A34E802106494AACCB49C621673161D89409E
      3C1BD27B239C1F44B0705E3A3F8A9B65F23E02C9E2A5F3BD9FFEB01CC21759FE
      01BEA922692F65EDB097B2F4982C22F6D5DCF58FAC9CB8669D4258CC362A15BA
      7B5FA9D096502B4BE96A7EDD94AE83CABF75DC9E73E2346B4D92AD115FEBCEC4
      F329E556C692299B308972A48DC87A3773E7ED6B10FA86B1F02E39F0E224165C
      A311EE3876E602AB4E4F77AD30C5BF21284F9C53AA6784E412D78BCAC4B569F9
      FA74FEF1DDE9D9B9F3FEC3EBF377CE9BB7EFCE9D1F4FDF9FCB7A6D3BB6A4B2F2
      3D1E3595C5EB7C830C2C122128C5F89DAA8D3B73E24999AC9D13B4112D46B197
      CCBE91250FBDD1E54B40CE6B3CD9F308CDF4925B39E3884CA814A002CBECB486
      FEB7B291EFC4144B9D61AC02194C295E7DB9602B479D6B9B71252FD225B12C9C
      6FAA00BBBE3EAEEDF6F9ECCD17DC198EE9E200ACACF6CAE11B6A06E97C591C7E
      2BABCAEA8B1C7EC4C89718150B1018F5FE6481BB9867BD489D9F3F7CF8680495
      7C230B1DC6D1A5D896B562E386C32D1938376DDE3CA810DD15EC2F57DE6623FA
      09250767EAB3A32754C49C8B567C2388234B7DBCFDFCDE2CB5E35111119040FC
      F037506F887D9951B0BBBEAAC3D7BE174453E773B4F047871C16F873140763EA
      B871E87CCF9108D2F3758589F5095236583177D6F846D679C1B56BB944048541
      5E507D924F6284961549157694D51E544ACA26A9BA816426F2517BA7841DC34A
      A46ABE792A925556619316CD8071566AFD2B2232770C12257020B38412FEA5EC
      94C5A750771123CA93CC6E2AA885CBD4E8DAEC46D5CC1D5B7A2912C80AC413AC
      0609EB581D563BA60812CED5017C80974B7B0BE701697C09B9D6495686129488
      48A601C1A9A1D17261393B06A51218292705AB44C9B672BA008736CF5C51B749
      B691AD3BF292F26094620CE923264C95ACB90E29EB6BA4A5AF0FF2472CE16D98
      82BA11EBB0B82D7838A5B042ACC1C978C31E9BC8A465954DC6FB634F7F75EB2C
      A2C532F030C5004326D1909EB33217E3AA90A52C448435D288FB2C28BB440714
      7A985779821912AAED862932C35363325FC16569DDB64E9D4AE6064051553A02
      86FBE6DAA1C037F6E248CB2746E75D0199C51CB263D393A23C37F7012E2B2E00
      32FE300A385D8D8C34880363EB3C59C37952B7CE934A562A727FCEE22928CC7A
      D9875989CC2CE48BE2D6C72AE294DA738E49A0D65238962634634E39D63F1FFE
      8E7654CCC4C75CB369ECCD39A2A4E6BC92458F5524EAE1EB08A3BFD9EC1AA620
      79C9E4B243BE6F18DD64F23D089721CA4F7AF0C992829568EC443E4F95465614
      01C515AAC4B5EA508C3CB460CBD860F849665A7FB5C29FAB8B103EFA5C34BA25
      E7A2D15DFB5C7CA622054089CFB8A7EA1EB12A0C9FFEFCE16C4533AF404C8AE1
      05069691FFA04A9167E4EC02ACBBCC2C15C68D00DBA3622609213F085F333C60
      9E7307FC1A2537AC8EBC8E96F8A6B3C01F5D7EBD824D8F5259CF01225B505AE5
      3EE1CE73043F99116494BDB43AC994296D5850BBF2B33FC6FE74133D02D242C2
      624F99B4300D0B539D8DF8F50BD43A9DAA326400B0C2283D922593EF0EC881FF
      461B26D98B46E5D9CADC636FEAF95F4DEEDE190AC6B6D2FDEAE028EB578B5C89
      AC5C7B1C8308A111D648A5D874E388779F9DBF3A17DF4409B883CAD9E74FEF60
      BA6F363F5D32719AC5C585194ABBE95A76CDCD2F4053183258537EBF9F68CBED
      A5108B442E8DE25654089C32D2C26782268528218FECB656BE2596A0176F9E2C
      63F907950701A056AE6CDE722402E48C3AD42060B18E422805D3639DDE97C8D2
      1F4265FBAD1E423EB7F724FFFF8FA2F97E11FC7F46886DB1072A92173F96E423
      B874310F2EA5A19BF06CFA7C4A025B3F76FE4AE87DB2F1B36A0D8D952F6F31F3
      73BE4F7D165875A71AA39CEF94A08D5137B21E2ED1350A7C4B8386D2EA6F15DA
      537630593A646A783A8BA3E59453DB0EE989432E688A256D54CAED6D92628726
      BC54F54751A86ADD1434C4A35C04FAB52C6E2ABB4CE37535297685874686B199
      487FDF6D6858B9F2B1D6AAC7358EB02CC024AFB2603BA9CC4A1372276DD22A68
      505A86AA1564BE8A4DB2F43437E349046E68AAFCAAEFC84F561D7BF125020E99
      11C021C0AB58C84BD7C7627DE635DCE654D5AFEA6EF9B07933BFD058FF5CE812
      120EACF412A18C29898AAF72992A598AAC66E63E53DD5884825A0570EE1917B4
      509C94B7520ECFFE3FD5AA692E6CCA13D942B0DFFA351668C03014EA4226DB01
      6055A76819EF1BB591CDEB0926EAB469719720E22423025B75C8552658800BC7
      081FA60389BC939CE424336288D9CD02C0EA63FC07E2ED4185CE2FEDC011A674
      6EE9C4E90E4D79E3ED92CB28FB131F6DA5729C97FCFC118F473558B242786A49
      432A4A19A9327B7C51266C67F63045C210A3A85C4D8059EC197225E941C54B97
      B66AE54145C627AF387B7BC4EA4FD37BD3BCCC98323A9E2AAA5B5A7165F5BB68
      3A0D64CC2799DDFCC04F6FB94892BC3F8DA2409E52F99034ABC109D10D6E8101
      0DFD50D6AE632B2D6F0B259557E974F00EF1F9D2BF9FC228D53B67463B1C7EE6
      FECF30BB6CCFE79447B910E1712149C40CA11A61DAB7D1965707521D4B112465
      FD94EEABE6A6FBD29CDC911A44BE5F0222D379ED71ACFC00533879FDF12DB380
      FD398139F66774B2CCC3C3142665D4F1F4A002D243CC3E41E02EC2ACC4A54D2C
      F4C30444720C5D4A54EEFA7F3A00B6FF4F61A5E29EAAEC4D4D57090FFC390042
      95FD91855F0977555401A8C81C4940491C11C9FBBAFBB492FA7016CC86721304
      D44FD9B0A3A4617B1608270E7FF0E6C3653CC5E691EF4195D89FD370EA646BA7
      A51F968454A9CEF4ABFD87867228EBABCA5190E227D42713143432CA547505FC
      2349FB31638732CD428083486C53BF420668EBEB6680BE8B909AFCD3DBC17EF6
      AA538F530555986A2587E9AEA5926225B11D9BD29E95FE38A8501B5EB67EA558
      365EB7B7CEF730AFFE8DB8E75800D11ACB0850590E9A24CAACCD8659243A01EA
      77EB4C459A75E4A0420BA6B58DA37B2CA7AD9C5FBC5346CEFD41BFCCBECBE555
      B595175103218262E8AAA2B655A31416FE56134980B59380A7FA5A1BF4E7DAE0
      E2C98293A230B6D6CCD4059479E7D17819A806574355A89FCDA29E7348B69243
      4C3A4B6109DABC42393C5C3A9FABA223FA2F16EA418AE238BFB9B971288FADE6
      9CDF78248006BE59C955D5B9FDCC07C5C302285A28D7FAA92A4DBB5CE0D746BB
      E91C22000FF5D4ABF53AD5CB7FCDFA69ABDEEFE889EB7BDE9CD7E56DE76FDEBC
      3952EBF4A4498B5A0AFBF35CD949BD2759EA2D9CFC51CA1568B9163D1B93F46B
      D0164FBFCA5E023851F5E3B1DCD83801E2E24FFD345172932C2C8FA4E8C70F9F
      29592CF039D8C6A3ECC631A6F8CEFD5098AFF6C2DB39BC43EFAA511614EDE748
      A0B8D816D9E4B8AB0187DD9004863A49867593AC983E676FCD17C0EA710A55A4
      7228D861C8ADAEF0404140A1F3618869976F5F1FABCACB9480EA652BF4CDD2F9
      C7A001FD2F82BE4624D0B2C8E79025AD66DACA0A3435315855852B71FB610DFD
      854E8FDE4229FCB7D310C00F33D9469934028EAE74ACD08B0E17E1141E484C14
      C33928FB89DE4DA5B51608C5C621F03111CB71B42E041E99F7938700AECD40CA
      1C40F8084A8820E2EBB4CB35A022A90F967A48F861344D72CB171210643E2391
      2013ED24669B84CC32F6ACD1D5FEF17763ED667975A3B11015EB56A71583CEB7
      50B31B8B5E6EBF2F9FEC5C24E32B365DACF66412753B7F52633EAA7FC64C8D8E
      3812025CDD386B5F56733EE90647E485970DA42486ABDC02925C4CA985C53C22
      6117C48F6F2FFC1BA03E73861BFFCC6E7DDDF728D1B48BF21E35C3BB7BB0F06D
      536D8AE46C6A297A2D229F7A2FA17A13DE62F7C0AC448AEAD7872E31AE1A1F44
      D125CA412BE6886F9C2F4733762AA0B17EC4058A731524C8F1272B50A8F9BE82
      27D11386758D3D988C37A75E6F300E15D5E148B184A114CB4AF6131470D299AA
      23656E0143780CF3F327B7D2D614DE721DBD2F21594D0F557F215A77A1C58E25
      CD954F596BAD57B7CE99473E94FDA1CEF9E59B3D21A4BEC10232152B80033D21
      37345DA213CAC1185CCA80A56AAA066A34178B858CD06199FEECD399368B92B0
      8287845AC7C9D69C1CE9A80F0CCC8F8DF1342ECBE9D8178ADE0863C20167AF17
      C6DBC4020E744079AAA80220CA874E1BF49B42472ED222233A5B39CA957A44E3
      B2671BA00E60A9A15CB08E3CDE0E162861BF21CD43C3B100445EBE6C7782A19F
      7466E58B8FF15BAEDB31AE5053E1C479707FA4569B77ECF33B5564E9E07794C6
      067F10FDA2B54BCDD954BD38FC9437D8530D298959A79C153C01A2025C7A99A2
      CA365C72031945A5642CABD2961535A5467BAA191FA3506E09E12AF89AD8A414
      6A435CAF01A8F9160424452D71A284D1A10D063EC456AB6AE574AEC521632BA8
      DC4B2FE0AC1C1E88BAB822E7A27C33395F4DC5619FEF4E4F8615952959D4AE6C
      AB6AD66B7825AD6A1B6AD6DFCC8AF0633FC1FD4CE8B88CE471DBDE7ADEC131D9
      CE9AC69482488287896399759CF19A3A92E04525B36C6FAD68FEDEE65A6929E6
      5A250157342F46EABAF1E59D7D37F81D8FD4E08FCD0BAB7FE3C32A25350A97C9
      9667A599F770A37F829C905B81AA8D4652A96C49C01D4BB9CAFE083E48CA657F
      4C1D464CD0C9FA9295F3DEF192AC4B3265431A66458C3770F4DB1CF7812B6CE0
      562499658F6320C86E9DB515D7D1CC671FBFA0F3581875138C969C86E680C210
      56C846F32F4D03CDC086A1768FCFC0A9214D22D8A59C099267B3B1BFB8CECB97
      A2B729709340A8851F2F0BC15362BA210739B991A4AF401B1DD518F274984517
      BDF0BE726E16692B6FE718E70FD0D4AD3EA86E7034160BFC63EFAC86EFF9D04A
      4F8D4A91D39625364493E02FFD6D38576C9296D97E4E7FBC78EB54D1CC33BC05
      5506E8332A973188FF18DD2CEF97D455B70D50F5F874EF70BD0555F4E47191C2
      F45A7090260F96281B3A4C835EC51697233C111443E67C54CDA9AFE06E15508A
      8EA9830AEA7E632E6149F16DB038B3AF0F978664ADD480089BE0FD310A79DC48
      513AEB68D17ACED2332A9595FC6FF2780718C022EFC8BBCC8C3A1CE845A570F1
      F2F158765695A2E856DDC04B95CB96B905B2EADD28F012BC0DDB50CBCDC8D4AC
      44759F4EB875A88E9CD72DA1D1F61628354E4E2261ED9AEA58D1225E98FDC0FD
      908317C805A8923869114A9B5B099B0F177B9F767950B9A01D527BB63F74E833
      7593422B8311DF7207711D2AF439F5D0C6445DCB198F6CB05E2158AFFDB5DB35
      7CCFDC41EFDB89A435B8C1D24E4EB1182414610B59A028BA64271A452894F818
      1DAC22C6466B61E611A520016A43AFAA7D28BF03552EAFED1832FCF4FEF4356A
      40D8D1C9676C4E6F170280C4C021C36C1C7BB7199E6B70913156DC601B69EC48
      76791BFB73D6313D74227102269BE618CED244A74C6B192B536CC3F1D0CE94FA
      21853864678D223D303C3B9276C61CA3D81558CA2850E4DD2B10EB2E10D09A49
      E8B3F9CA3935F9B62DD4B920C9E39A8BFCC92DF4136692B8F65DDB1420DEB117
      268092648E5E6F670AE8294FB63CC24A2EA0E0062E223BE5148644809EFE064E
      CC8761E05F510361E59A6CB24CA2FEA4247D60151CF7949B07BC5104C0418C24
      C139E6E28DB9D92346B3F104593EBBEB0EE4295C5C1E54F4810CB11C80EC3A4C
      65ABE084054B4A270E6FD5DE19F071AA0A2632BF820DFA79003D0E7DB785BC8F
      0C9C79087D8F948B2AFB8DDB4AA0B720B8BD8BE77B20FD14D9A5E17032901415
      102D3ABB8D76C3A992547DE2BC033D3F74DE1E19362C4026D073E39893B4B955
      F5C62DD0A3C589D403BFFB0F35B3FFDC4A341689879B9EFF23E7FCB81268892A
      84901F1B16FEEC792FD3496F2BC1355E865F6C2BAD61314ADDF0229ED30965E1
      6B88521887AD53E487C4364134509DDDA2F043496D77105B523DA0BE5F3EBFE9
      9158134BC2A04250F3A353DC4CD14A918D2BEB142419E3611F398ECEDE4CA0C9
      2CE8E8F55E17FAB8E6E35FEE0A1EB412321AA0FDDF4CD3D696A590A27A393075
      81166CC9D69042D26FF2EF6F8EBA5B3DBDF24E6EF21EA9E82CF390C453458E7D
      71CE81D4513066D1C74CA3CB1D023E2D28474D433C44565F2FE8EB9DAFABAFC3
      E8437F04720408159D1DDB1B0C83404A7E42D47BD726F74F01DA02C1ADBE6353
      1B7B21362AA7B935766C6E229C063B3B39D0F276177213F493EFE8DCA602E4C3
      7047E7160B71C9536BEED8D466CB70EAC5BE82DCAED111604081BFABDBFA9BB7
      F076973B80C2742DA63B0BBC459411E15DC33A54EC96D3256FED0EC22E5E2689
      DE5877C7260752E6EE72B0E45A8C777672E932BED4936BED996A77716E95B8E7
      2871DDAFABC4AD14AAF7047795D3A7957301753B16A19F83D0BDAF8DD07F3E2E
      EFA8B5F135F91EA9969A3457638097C666CAEFE12A6E64A0DD9FC3FFF64ED62B
      D5BA9B198E320A5CE3F6BE1A6055CCDC844BCA43C6896D2AAB49C7ACE19971BC
      21DC7584594F54C2F55685DCE620EE5465586FE21C7E215F5BEEE7EF0E57653B
      A1C38062CA8F8C803C767CE8F264E802C1EA7F46A8227A40389CE3EE3494E76F
      214276237B5C5E16BB2D2008D0F7B1717FC32FA38572CFFCBA0D9F4322469CB2
      282B8D532938CCFF5525756559175F576DBB07F333EC4E6FFA6E07FE757BCD06
      7C34BAAD1E7C343B9D167CB4DABD3A7CB45B7DBCA5D372F1966EB381B7F41AAD
      163F8DB7C011EAD230F57E1F6F72DD7E1DEF721B701F7E36BB2DBAAFD56977B6
      7BA436E15B34375342534A167F43B7A3BC7489951DA3F06F1DF8DFBE501B8CC9
      CF4A2F53149B3387E9204E6EBE08C1167DBC3075DF8879AF7205A7CD87482172
      6CC3B11EBE488F65D80CD05BC4082EF9ED612AA5494B8DEDCAFCBC549E9B0B29
      A11B18A4BB9190F10586FB1B68F058C43E660A103B50ACC3BA3E51182136A940
      B22FE75F9550536D0665BC81921AE0CAE13953CA43A70A5F0F895B6BD584EACE
      6722DB84A29ECC20088DABBADCFB7C4EB19E5897624B013CC177FFA1A6541E03
      73F0E466F03559859B8B9324A96F16FE96B9A57490936B3FA59AE266A087114A
      C1CD2728DECFA833466152A0A9CD1704FEA9C8A794E8A7B540B7791AF71F187B
      F29F3590CEB713087A9C4DDE573107CEA5B825DCCA82205571A9E4CE3D147E88
      D1C21C2563E957E54E2CCFBE11B0920E152BB3B148CF2C024C953953F5C633AA
      96C893CCA50D63EC203C57C44B67FAC832BEB9FAA526D79EC094B0AEFFEA97A3
      56B30C65A5721585434D42991E73085995CC996F3EB46454F0876E47DD806BA5
      4830793C522AB4206E4602C88894756B47C67C72C0E0B8320E72BD1B67496969
      D4F259D64AC1F59166A69390297D8CC2BF64D6D8B716FE95E99EDBABED57CBB4
      906DD46D90E9733547D4A6B58D4F9E83A4FEAF1406B6BB142EB5421826C33455
      BD4CCFC1531708961F34FA8D45E2C78640AC2B7CAD3EE8D7B28B869F98CC3865
      F426299A911843E33D6C361EF9230A6C7C8452B10B59178014B272472C64E125
      6D38CAC0629452CDC2AC47B209FAD308DE1E33E2556923FBC38B57AC3E9F626C
      6617AF3899488457C71D53A60A23E4228EA6B137971534AA3222FD71F2F066A5
      E1A72B1368BCC865437C3D8DE8E9BB7E44849603D66591666617C7D9C693D919
      EB3E14BC5546A182849002EEC36D460335979AC0A68C67664F233D84D98DB194
      26C9B2452C2562A934421B212BAA14A1E1978B14FE6380027AF0E6752726CA79
      4F4081ACA7E601ACE271428DDCC853BA9B2DBFC2AB90AECA7D939C611A444312
      AF0D09B18A705DC47E1453B7AC2B119768BA470617D942E2CE961376B6D05B1C
      B38D08DA8F9DFA23E5809CDD65A16ACBFD0BA5206DC2EEF167A6206D019156E4
      646D02DC594A129206D461AF518C5195C3A943DEF1F60EC6360E32BA57A9E866
      9C6564E62821D23A559E32AF0C635D282A0723333D415AC13A9DB7A682FC2D29
      8E00BA0754795EE8313B2441D31AC5FE5073E8C91668E296B3D0B582BC69EFD6
      EBD89B46E1308AC36D6E5856659BF2A8531FF49FDBE3BC50702F0FE7C2BC7903
      0F798C146326D169F33C61F1DD0DFC6F2B8C193BF6312B9311098CA6DCD7AF7A
      B7FDCB51BE8CF0E6A931AE741B0B9532D8A6A7BB3DC617DE163DB3CC008FB775
      0831B66AF367CED05188500658F991AA3CB7545716F29AA3AE1B082E5B574F8E
      1F30C515D5C6471DA67ABF59DFBC7C652D389577916E98B847869B55FD229D50
      78714949478AF5C2B283E8D634CB9B825C202DE9A44EAE2C4968639A9E4FE838
      224F81F73B47666F48C0F2AFD35C090E5D4AEF3B2EB471A7D246EED915F2437E
      00371BE0EC36F683C01FE547A03A09779EECB4EB75D7A97EF9FCE6A477B42F07
      EC67F42A6E9E0F6CBB5E13FA0D54E7017DA2D556DE297A0F14C19EEBE7C72AD6
      EBDFD5EBBF3AAFB226F058D55EC4DF39BF48279C3CEAB58BCF9FDEFEF8FDC5AF
      F2BCAD7B3AF7E3B415D5F04DECCD5615719FA20004F91F8F1D2A3FAA8AA07285
      9A28CDF239EC017BFA01CBF474EDCE2E39494E95BC4A6ACF8FF6997BE9BA6768
      EBF7B6A0B96DF570B12789421C7D3A5D8EAA69C795F0B2FA74968B6D8C8BB556
      7331C34E2692F9AFCE1B34CCC87AF0552A10FFDD69FF4DAFF9EACD1B75C41E33
      DC538EF063C6BF20B7B36CFFB047FDBEEE5281CDD300346CFC37FC6FF3868D2C
      1219CE393157C3466809C29F4210DCC6EA1376B6F8208FE76791A470CA1625A7
      9828C50FDCC1FB75B67D5F912FEF68478877594BEB99178E833D22536CCB0AEE
      0220EB93178BEBD84F536CC390752A23040394F230661F8D55BA4224F60FE056
      EB739F7A742255C83A0398757DB9693107E1DEADE6A88CAB1786587F4C377F3E
      BF686164AFAAF7FBE34FE60A8A793BE4C9E0C44DEADB236BF7C220ED971717E7
      3238B8958544C961361FD2BA0896B0E0A496DEAC17EEF2387747B62C95CFA5BB
      C6AB80503F849D01C818DDAB99BA1B333BD2DD64242010E2771F644F7720B04A
      BB82F4A6E17550C169D02CD686D953CCF7B2F685C2846355C058397937EEB205
      C9680B423BCC7E0B45CE45126C7EAE3A6C3C570F36C5A000AE028BE44237957F
      CFEDD31391CAB403EEE4093838F7B9638BE1B43423147254E129C51D9EB9D15C
      D1C1C3077491072AFB00571CB7B61B351EFACFABF1F05C10191D53B74014776C
      CF1B72CF370CC42FD442F62E083713D57482C471039551F0956B830F6F2EC00F
      2E394D06E087090804BE1738AFDF9DE1E18751C6E82E53A7FDC4A4E73B8603AD
      EDE0803A48FFF7A74F5B440432A9FFF4295764A7E5FCF46947D0A3CDB03DA3E8
      B22874CE82E550F59EDD3C966C63051D5E81627A985562365CFDDAD3EBD6645D
      C3F0A46C8A7BA033BD9DA8CE8B46A75743A6A6DC20C631B30106479F4BDB1D8A
      D52CA663DF3CAA6542B5A8A83B1E36564BD22C6E5275C808B0C5E9ADE96564C1
      277BCCE8B6C1AFC196E3B22904B577C391566C9EAC8FBF58526B6D981C85ADFA
      A16CAC84F70F010D2E41BCB20603EC2C23DB26EA607D670CFC28DAABF4A5D98A
      E5135EABA350D53912F23E0CF8CD2B9298F94F2662CA5FF762CCE057BFC933E6
      7175263E11C9B173388A16B7A824D46A35C2D043B640F8733F00C863A709A2FE
      C95166C4304C17DA9EA13485B7BAB130A75B78BA5BAA3CA0F2DCDC464BD980A8
      70E67862F90A4EA8D68CA260390F1924648CFB4024A13AF5B57243B61218CA4B
      B03FACB4962CA284BA0C29B58628C9D1B1D684F0DB3BD689AA93BCEE0A779135
      4BBE89FB5A9A00E782FDA0F1CEDFBEC6669913FFC6D498543F35B50532841248
      042C117B203384422A2725A39A29E4A9D05FF6BD7C9E7468A5A54940711F268A
      85A09FD7532FC702F76FFC282B369C8D4B7122139FB6A37103805EA49C032A46
      9714206F581532B457006532AB08B87C48FF4A5956D8025466B8D1EF641C2B62
      9B2A374610FCA5F6ABEE070A9CE897FFFE55D7C0F91F405A52B1557134EC53AF
      7A9453E4FA18A3FB41B7A6BE748509A9515E474B7CFE0CE67589BCEA2C8D83BF
      9E8794148353E67952AFBA5453858C1D51D1B15CB5815110C94447A61BBC8E0F
      7F572F24F789A61E8767C5130FBC4F009840EBD1E177DCBC541D52321ADEE6F2
      9DB35C75EE910C670C340838542FF571928D09B9561C5688332D0A6BCC893A9D
      CB06B41969A4AEB7738191BC7F6E4FAB1D659F1FC80F01B07F71A16184144937
      07766611B7883FFBFCE91D417BCC083842047CB13F2CF6949030E2D0FC27422B
      63825436AFE6C8EA4D448B265E906408CE064F945DF98DCC3A8E796055E86C26
      8231BCE19AF9558E323071C39E488B347309BE972931F0E97C0FA478C166FB2A
      CC1A48F46D208E64F502BD3C8C8FFD6A756A76E8A0BC5922AD447EA0ECECB5E9
      2C826DD8BB26E572DD59A0A5B2156323B25BCE66A9CA022E52E859028121BCE2
      1E5D547C8BFB0EDEAA7EDE334F8A2F7278CD21B46838413E405DCFE458543ED3
      980DF7663D3647A1CB189F360D2383E09FF3ECE4A1203ECCBC8F1FFEF236F3D7
      206BBF775E7B7C26CE72927C444D3B81B2106149F6ED60640B3FA8A082EF4CE0
      542C6359524D137EC039CEE897457023D43EFCB9ACE383B74D23F2F0E2617202
      D08E10D5F18AA9862C40F2CC7405781DDC4DE2541AA53AC77D06B04A14D9CF6F
      CA71A6C985B72C5DF16CA994C1B5C0925489CC92E04AC7BCD37834B00BF494D5
      3AEE6C2FF3478F4911619D0465E3D0A3C207FADD3AFF4F5FA2C815D55330C597
      32680862231193A3B48A36926B6C03144E8F74381449C89EEA062B55A3994CEA
      1F8A91A78B7750993BA54B4930254888A265986A873765215295824499768E6A
      CEAB5B1C9396245B3227C61844BEC288F610A46F581B88D4FE0205619F4A394C
      801303FE83D49B4A6ECA4AAC9CAE2A5D88622A767D2601406A9C5728FA92637F
      C6992DCBC50AF8515624F57F9CA9227D125259E53EA9C846702C7C14F4A4358B
      21978D095A070C282B6F9292830584E41A1226CF3206218902F4E863F225C61C
      C86218F8507105339DA6A9A67C50919A15D155545EE78B14A0E85DF9534629AD
      F073F90B8C7FBC6553C0E11B527D49A7C0A7F5EC0E6B86BC24937FC99281CF2D
      2240588DEF68E04374076D88AA4686CC34648D6884000E0494E845220D8972BE
      592F4AAD5A65D021742388E0757C152D85022C00958D172607159C3A833AC412
      45B45BF72D8DCEF7DCBB447B66CA644178896C108E6B20AA57081538E6632994
      2107554BB95969A4F6B0B0C92C0B4E104B6085DE144F1F8F422BC888088C40F8
      468702094861DF6D2E9E324BF231BD2858E6F685251E547E5656F161163D4706
      178A0D525CE5586AF8A500D3193BF2346457E9382873A3349087DA249CDC1D09
      511CB9EC3CE2B23E1473A3989F697ECBDEA1EB3A65D6C8632789C8BE811478EC
      6395463832E266A14A7FFAE1D807DE89826FEEDC488BA51F73A99F304D4CEB10
      556F9094C0B0E4E183E4928073EF63C4974FA2AF4AB2D06F30A8F92D10F9399B
      7B397C43D99988244A231352CB2B0F40370C6C29E583CA79888078F9DA4FC842
      8710FB2488A4EA2DDC9793CB35458C5A54B2AAD941E527C24785987892D84041
      D83D96A0C3DA6004CC0C72C7A66009C2F132D4F60560430A335188C8CE8B0C66
      BCCEC9B077FC1CCCA92CFE56CE542197BD43577280494F4F7A4D6DCA091FA5F4
      926194549FBEBCCD55B845BFACC3C570322F41433B8273DE6461CAAA07958C21
      48CA1F1A85C20ECFF2EFAFD56A8719E6FBAAB07876CC8EF19D489D6908B2ECBF
      CF621F5709C9936884A2A7E48BEC00E09716582ABC269182AE8CFB55D6F1E0B6
      E824E093876D4B28B62FCC9FBF73EA5E923957C8F77850017D024DF9090BB641
      145DD28166C194A98637E4C5C0C5005859EA34A51A926805AD2AD593BF22FC95
      AE77542B25485C16452DE9EA0E71F2EEDF84634323A31C0AF41E79E47747F5A6
      B813B2FCAA5A8F7A112C7A7250890E2AE65EE87DA64D21CC609D47B9ABEF8826
      81DC1F2482DA4745AA70847E95E13215995AA70027651ED9A2862786BBC79A9C
      1251D82994158E9103CB48F12155564B198AE87F3510A7E69C921E865A821FCF
      156A2B478E46187C08545D8D25B4EAA1D06A88128C0A68A4EFE32639968A570A
      00DA2B127E073BF0C42459F72723B487F017E97D86B9E28E20FC232BDEA6FB9C
      FB159987FB6D988838AD699541DE388FD0C801532127CE75788720008D3A5BC6
      09FCFC65E1BC54DF5F939672F6E9ACF04654D475E93563A48B993F49FFCA7350
      35DCBDD4081E52B499780369FAF266FFA032E180A5898C5F90F4835EEE4FCA06
      AA91B527EF15463FF2A7333563E9DFCFCDF3355D338CF166A814BD31EFDB92D6
      1555834D8747E16BE484B3B65A32404A4E86BC5B734A67C99697F05B000A58DB
      EEDA97E6BD6C7946C43AC7A45F7BD89B86959D505B4BCF3D18369710CC759DF0
      35E8777E526C7A31BCEF5FAAF1A05BFFBA9D070D27F589736AF0C61F3F7CD681
      735A0F410BA7F48ECA9DD7B13C9AB8B06F94CA7BD5766CB73F73D8D589F3A1C8
      E8552CA3C4DD9CC97BD75671112DE311368B3E2D0A2C72196806960B619955DB
      EB33037FBEB0A30C93E2AD93766532909BD292810D12905C3AD6A8CC4C3094F3
      53202DB28D5D0123AC79C82B3D418A6B6EBF8E2A3DCEA336D5E2D849CC7E4B2E
      58E7DD075E0CFA56E57619DC81570772A43AC39233684FED5CE5046615B7EFEC
      A211F687CAA06E71A4B0C3882CE2CE01141BF8DD5312548A006B3C322BA1510C
      EC06ADE741AAEFB65A4F27FBF4F0BA74DF0FAE4AFCCD34CC9F42FE4F3921EDA4
      9845962B8499F9EBE7E82B8D51C504C29029A93BB1A980A9AF30701B1683540B
      5572315AE66270AFB51F8B82E030FA0644147A0AE4B6F05687F11D5474C02705
      83174F8C2C67EF658FC83334BC3BD644199C578E24FD7065037D9E99169244F9
      217928E452B467D8020546E004D2FDD26948AA54FC3A8DA653695D20D38DD4A7
      E7C4A8B4B00D6B190912F8B13E33C673B1EF926FD58C711E2DB388B15772C3F3
      DEE12187B78CA95084DAD8A97F45153130E4B4482D95D9822C0BE875646C44CF
      8388AD6C5CA491ABA9E39F281B7FCCD9A87E94362A99B3AB354EADEFB1EF5DB6
      E6A362D905D5593BD18CDFE420D5B91F2E932C02EA68D7440C02C1592EBC2262
      BA234505B910B40C63C430F9FE68A1CA8A16F88B61842895990549361972C88D
      30D2707EA4B209633FFD73D370BE7614EC2A63E05D9B1E05901FAFB2752A7B9F
      11327FC7DE5966D661072A8E84FC84B7A8064F4ED9B83FD1CDB1325F91367012
      15D40E525A85F28C1AE3A3D1BEE8F33B2C9872D1A4930BA0C7DD98524A863272
      86E21A2328C80EA207276B43EE414E87D1C90AFB6EF92C6CE51E79AF8A2BA713
      50A87C916B6FE069C3DADDEE7FD96086932B911C5E7540343C0B1EC53465C63C
      8DB0329BC37495718E14D74CE6EA2EAAAB82CA8F0AA951CB4C045A9BFE80F152
      775628A322AF44F9E2F81E6E7941861C75FC583035F29BA4778FEC01ABDF348E
      483B180A0EB844636C99F95136B395A1BF020BE764D1CA1E95EACF29D87B7C62
      CF65C0E71E3A9C4F138EDDF592CC9D89A7283B3D688EC7B007E790825A4B9CC0
      8552C4791FE7A4CCEF6BE44BB2F79A1D25062B2B7A17A59105513DC9278665B6
      2325DAD0692C32758FE28574CE95EE1A930B0DB467A2428E127B281E3C14EC50
      32506793E722E74BCC8E826228DA1B1FAA84E24CB25CC50AD958486EB1AF98F9
      B143484E556E94AFD1E2F72AFCE64240E4EF041CDE169A9B812677384151F37A
      48D7CAD09DEE95EDEAC2889DB6B14E1E37034EE0A7BC56C5A3AE3A7D7AB17A26
      4668AC9A4BC93B707AE6C97C3886293FABD12C8A685CD61A7331B94BDA2976A4
      A8D793475BAB7BDAA1ADF2ABCD44279B08468960B87917720FF6872220A329AE
      3E7F8A518BBAA5921659304B16729029211A7F95C397EA146FB630D59D99566F
      8EB651FED29E8853981BD625C8C3FB705F0E463E59BE088C838A0407073CCD61
      15FE4916799BF528FBE5E657751CEECF9D6FD79C3319BBC421E8630EE64D6940
      52F7C9EBEB24738CEE8C79F846AE9C44F9344827D265B8B3C39B0BCD58C9A88F
      651C70110F7212408935F158E7FEE5D435F552F2B4E122B98F9511FFEA0DF3EB
      E26256325CF4EE7A027FEE33EFCD42CD56CC186DE19C4C896E2C6DF2BCF2BD15
      92CB3D00A16E9CEC9DB474A2F2495774E6524ABF10162E02F16BA692649BBE37
      F483192BD775590587ECFC547506D37D32742E30FC6845416DC3A0A25A8D529E
      A7F22311A18217AC3818206F8A9AF316074B973197E4E756A568DE4C740D6E6D
      5981978F636FAADBC23365D235AF6548BF33C264196991A1A047BA92E4626162
      784FEEEC2B05815503CAF2A4723C592D9C451C01B0E6866559C132736431F966
      F02B84BC7F1F8AE19F0405A95B2F448C1663CA73BD6747291FDE283CA282BBB0
      851F1D5B5D5E486DB4540F548A1C3AE9F8556C8F267D415520B3B406688D6288
      F23341424D89D2FB4257B8BE800A8CC095934F9C2A9F6DBA25C80967594A506F
      BEE4196661A3FF040F5A4E82A0F772197FF97285FC3FC8EA441C744EEEF2D340
      869DEB8479598381393C5A12549A5D425128FE2437B4E162A5F76A421A2AFBC1
      C84BA4726DA6DAF3C3AA3E0B97E3C424618EB9570505F48D5E2CC79714D14773
      1CE1990CE7B3E7BB724A55D7381B593AB7F7E55C73C2FD289ACF39E03724A316
      7048AACF9715AF90969C9927995396BB2D830130FC3857158230B46A54F49337
      FA940E2EE68B0896769B5524BAF6D825B60C4156966709634CB1C8DE986B2F70
      C4C98C3DBC4732CB022B8028810063A131D54580E80E0CD85B2C5469588DE51B
      360C9C10EEBC26605C00B4364EAD0E2A6C4DA3D00A8F1CACE149A44A8757F5B7
      BF713B12CE023C76F4F571304A8E9DB3B3E428172A8935AF39886E05B0068407
      DB06D5771ED6F83E1E627786E311F600DA46BDEF0C78BAFC482EA6690D7070A8
      26E551CDBD5B40E051B0C4FA300AC405BBE91E13D2C30BF4FC7F092966C8F9C1
      0FD34338B68BC01B892413A40FC9AC812870282D1DFB426DC9ACB00A4848E866
      980A7C9945847C90E501AA11A5D0C9751DB10F8EC32A64F82906EA2DE578AA16
      13082CCA5AE3D61D0C404C29DB7488E41B469CC17B330182DD0BCB702CE3997F
      F0E6C3658CC599DE5376B5CAB025222BDF24036EB02C08AC87C34330D223631A
      F24E7530CE543C2EE51FFB2A2E45172A582658F5838ACA154B15AC1CE297FFFE
      55C18A46C31E3F982B415C86B397DC360C85F9D589E42B701D0D5D70B861A751
      8AA75046F6ADE05CC228FAA7D04F6BC0D9B3CD4A103A6FD8F8A5A2EC1DC1751D
      099878A6F7E52C6361D3C30250AAAFE0D81D29481CCA235C4CF0AC8E0D036C1A
      2F858E072E2D5E2A652755504B8621CFCB37A3AAE270B9561A46BFAB1259984C
      81D3B438ADC3B00024392BD0FEE070AEF4ED2A831859E4080DBD54B013CE0F4F
      88A5531077C4CDD5DE626D43ACD62EA5A344E61D1E1D3B6F40FA4A65973BC253
      5F046359330D8B17F0A0D9585C7D896AA2C251C096904679DF0BC3B2BF6A1E3C
      385B2602CC6474C671B4E03C746462549C6E11515548603632A3AD2AC8AA4F46
      009EB759777FB69C62A5CEAA36E851320E97B9F3A6A19FC27A8FD02F30368A0D
      EEF3A96222A4E2DF10A0FB73A0505558010090E2A84E074A72ABCE5CBE2E0A59
      1763D6A2119F8FE429C4E2BB89C335EBB1AF35D733206D6D180BEF52567EE252
      A50967B6BC61ABB107EB512F432BBFC5D3CA2956C89465E3F607414F899E21B9
      628B21DA6354A950553A966162BA2646335F18A2FC21C3AE507CF34C16C474DE
      458098C9A1E92EE22E0DE8CEBEF7D184FBA0B01633CE5772FD6594AADBF005C9
      AFEA69F9E3DB3152F591177C8EDE9319E46700877AE2D8C99EC6EBE6DF3C9A19
      02D9CC4F137EC2E833728CF929FA804CF78D5277289360ACECE2C5216A35A7AA
      9D37AC3BA145E2C87005D564C2013BC0727EAFD4AC44AB1F387664B97032CC91
      81A3F00A520F5514566A96469479AED29C96726149D606111FFC7C6DAC830A28
      E9D8859536C67C0A0EF7289A0B5D2C228CC6B92C857C6513730A2C02B0DE85F5
      E1B5394F8EA13BDFCAE1AE41DFC5C22452C4C892DBF3AEAFACF0AFBA814BD0CA
      E550E1C9D8CBACFEFA24188B92BDDE6B8EA84D6B6CE6F71607155D5157DE46F1
      DC81F042AAE2CC59711196ADC587D1BA8901148404B48089C679AAFDCA95D7E5
      FE09F2BA158A4BD1D8D9A993FDD8B3ED921B755C163480F71C4E308D3FF0FF89
      2ED7AAEC52AA0F2603D6BB3D52E572E1852AA8908C8DE3CC6DA8F7EDA0A2CB8E
      4518E608872BDB6A5DB78A578525BA4DC85E7BC6B455DA57D6AB48A590C02023
      725900A55C8ED2658CF576A569A34A9110B22E31FA5B8D925E9EB40D6715C7E4
      7B633107CA961471DBE31DA3FA8A64FE48D228222E4D754E9748C754D085F359
      959C3EA85006D064995029344F5B5354B45A68B4155AB52FE286523D5992A5D2
      6F640637B79634BFDCCE1F9A0C8B70EF4CE21E1990C40DE6C423588DDA916C6C
      627248E07E2780811C32E80FFF6B8922C8854980D92DCF7423E71C53F1412699
      3C7C75EBBCF212F18936E050564B234BE930BA51BB29230254CA941151C31E45
      EE73C03103583256DF51FD9B43023E67C13B67E7EFDEE1CE60F5F209D28291BA
      F5A870420AF3C0585F8E0D3876FE7AEC9CF0EAFFE25C8ADBA458535CBAEF0070
      1CD57E1A0487C7FAAF1FE1902AE0BD0DAF50FAD261BA87B9860B5C2A363B689A
      2ECBC324F99F32F2A95C137522546D50E35C4996C8550554DD4F19CB4B6D853D
      955EEA99C5F1F426E8DC51CAE2A51BA51931117A74F5DE42FE277918B33C9745
      CE63B9C722E4272053331943C3C97D7B64CD4665C70CA3D7B8AED20EEF6FD990
      0814A494337E28488A40EF961AD00BEE76B7D33569306C65E90763E21477B640
      B72740A7986EDEC0EA174D29ABF8ACCA2B255CE9734CC179877AD443F2DBABFE
      29408E6ED1BDA67DFE40B261B13376BEE9C02015606396956759C77435C998AB
      24623ECAA14AB099A34B20DCC8027051DA561170F80F00898D7840059045CA77
      7A69A131C107A68EAB60A3F78900782CDB909B9035588C1EE2E532CC8653143A
      5B081BEF8B22EFA11923C516FC282637FB14B461D90B830242574D54F6864A08
      7728D16282AA6EBA0C8D6AAC72FFE0A0503734EA51C1F55439E8D273B0C10AE2
      220875D398A43A0C56D3F1E3F8334777C1049009258CB01717E796C26913E9A1
      9421B00724286918D147ED207FA03AB27B145FF951B931B39628E8D766E90188
      019A0AA9B1A4093083EB2B90D59C57B2DB8AEAB041426A4486FEF7A7179F816A
      0DF541D3E11686842CE3A9695C325ABE409CC7764D663D2194878FA594493C3D
      C0780C8AFAC36227D132D6D97DCB10E45299DFE0011B1BF3A946E14FB01C8E15
      9760292155FD3FA263B210D142A59C8F23DD91CA8367C442C9D470228D234BC4
      0B15593C7A1CCEA41BAEE6C335987D64228C76836A5511352919B9A3F403589B
      097B550399E98E6C9A0330C77479BECDE76C265948EFF0147EE30192FBAB4EDF
      9768B6EAA5B4BDA2F85EAA15942C335D5CE8DE3807955889CD09AD540BBEBA7E
      B11A2A74FEB1844D529D21F5624845586F395AB28F72313EBA3B912A2A62E235
      95903F96FB44659294A8998F11DC4628094F84E681AFDF423E0EE91DAA290D00
      7CE3EB78FB7700D7CF7074DECE5F4700E38D870FD59C8F986D89D685830A1C64
      C60B38AA3ACA4BF6D31132025276689595B0432A84AD15B471E45CE2FE5EE308
      B7B22BEB18276E3965E5ED1CDB7E49FF2B9318320B2551CC5DBEC8B0293576D5
      02777FF8A649564932E466D5D2A798B59E31F25E5112D416E70B006346C7565A
      96CD5B9C2A9156AC857C571A3F3AD48497DBD828AA48293FB847BAD65E9180AE
      7C71EE1E345B7C92949EAC4A645A903F3EE2CD58B1B769189AA54A2E23F581D8
      C2D2269961074F365DA3F42B0E63232E246506AAD29F355D83375D694F9534C6
      84424833ED3063D2483428CF17840254DB38B0C0E0F41C547CE59302C02919D2
      9A7024AF06184F474D0EA97F10072D588A919567662B9D211C92A77C7FB29664
      DA8C82C241A50007150E53C864348D7E24E06ABB295BC4CF2FDE539B7926BDEF
      A291476670595832EBE0CE810381C89BBBEF291FB0C738FB912C209FC4C4F9E5
      E3BBFFF9F45D9DFEE7B67EC5B3ADBC0259C9EAC1EF681919FC5113377B141996
      01A92ACB6F2B301D294396B70258887526C074FD48238A9E3D7446CD7ED9CE0C
      A808CC633C8AC6AA50B341C18F32A3BDD912D134F9A4B1271B9D7C523AC618DB
      78168D6A74CEF2A6A63D3E0D3F2890D7C69EAA0F27B9E5BE603BEAB9A57A1100
      E1699A510EB09B4F01E39D322295A5844341351CDE9FCBFE966E192E6387C757
      CC87623CCE5B5AE0C4E60DD6E6F9D2E5FCF14E7899A714FBCC2584271E735A02
      6FC4A6E54DAB9B83DFBF07DAF223D3970CC2AA63C2DAA07EA4123D14AB40B4C7
      54E3B3BFD83B32C19171B472E9204FD920EFCDD956B4FA34A6A429A1DF51359E
      5656BEB937A6839573E7E877648A8E346948F493864792F6F041BCB996DE70BF
      8B1587DB62ADDE3F95817EA66B3D47E12A21795F305A16CD56253B0E2A2BE23C
      B8470B014E195B438E41665B2FD61DE32E1AEA9A8E1390715485FADA3547251F
      C3ABF3A34F22348A22E760F14F0ED8C436EFF40A8BC3955F7E12F1EDAFCE8AB8
      973DB2C495E7F2E7D1489B88756BAF8DDBBFFF811B81FC40F752DFBCAC772243
      668CDAEBBA901F59BA0E2AAA23503EE249A7DC52D5626A443FCDFAEBAE8E63CD
      FACF73CC92D4CD8EA5A5EE985C411B0723E64A3C11948F94E54E74442A05B871
      24C75DB0252A3F897B5C2646D52474C407CB29BC8AF8AE0A89304B36E57A2F18
      A14C55192DE94F9CB3CF9FDEA1883D13C1385F86E1C85239266FBF609AEDAF1C
      236889DBD7226EE4F0D946550045D6B2BA6B406DE02310BAC4BD7196906269E7
      9EF43D91BCAB49DFAA98E6BB45D664F8AC8EF6BED30F330C6E657CE49790DB61
      D25FAA37BC362EC940FF43E92939D4C1FB99FBFE30AB71843355F1ADF86E58FF
      8AB7D7B6B48708822DEEE30A8A4AAE7B662DC7CE97D79F8E9547E9EDE7F787B0
      EC7F2C29FA954C710B36053629B42E2932319939AA430B186930DC0A33193802
      8B376CE2B3B7E7F0D5878B8B97EF3E7CF8ACE38BE1ED183F970B3356D224131B
      F68071E870BE2ADF320E51E09D38871718E48F282037153D7422D4910F94AE87
      0104BA4CA0B69FC0AA55259B51340DD1887FC4A94E02A4E9C3B70EBAD11DF4A3
      3B6F5FCC1D72A5CB40667C898A15517986C084635CD65116058881DE084B8E12
      E4F877961A14085E7BD7E17489223856ADA0D2BF5A904FA225B662F4E310435A
      8231B5A1E2D609DADF269B79E1ED53D93E4A7A2C424CD6876FC9927DF32F30A4
      2816DEF8D68CA46CD61A355776BBD2A16A6631C0CF18B777A31C2130D8715645
      05C1832E38D525DB9063E6664CB6E19F5309222AF538EBD07E97BDA8CEDD513C
      627F6E22B25464E54E1CFB57FE78A990922A9D19C5613801048BCA51A8893C03
      C3DB542582E433600095F336ED2C6FC19C24A3A58E1F02C88D97230A4EF22744
      88B846329549C86219713BE65E88FE4C60113390FBAA18B0EF8FFC5492C05B59
      E146395F8D9F8DA26D707025E15567D7265DBF8EBDE941E545F8E235E6E5C2CE
      5FCFA29C13644F13B1DFAEC8BD56A1B9C5C0E75283420E96182C67564B9CB147
      B56A4ADAECF5047274A4EA842B6B0499DC428A49DE7B9CC5DEF2185E01908B53
      607E24FD1CFE9FE57C0144F77065DAFCB782B8CFAD8B2DDBB9632AF336AA3745
      AB2A1248449684163DA0D95EA85E15D6432931F747EF0A985802D29E119EF6AD
      60E7F3C9EA1B38A99FCF2FDA2F2F2ECEB904C587D631265978A42989F154B50A
      C3AF984A7F99683F8091100212374803AA9915486558205659674980D763C2E2
      0F2A438EC9D5BF6ACF4328F7E3182B5CA83A4ED9CBB1083565418CC54D16CCCD
      055CB06D98125B6A4EF593CA8EB82358B3C485923766744D26B523E7942D3267
      7FA7181A6207DED0A79C8A64B69C4C02920C412A54F96766ABE042F9D8C264E5
      4AAE652B6A80DD35062E531433478E9A91D9B901121598CE39C020D94F406DA0
      AC0C3FC444528E620E0D9DE0C7D39FDEB33E40E73C53F7C7A06A629AF7144323
      289415443D23CD8633D341DB98A06C8E1D0438B916055E1D6FBE1A5D4654BAD8
      4F385705B3FEFC910487DCF444B169CC5F1C6BB20577C2368E22802688AD2937
      FA5522AF71072F4F4DE2D3DD8C96CC37268F3147E852603D1C618E6ACAA53C11
      4E2B64CB02EA576752B12B83EA51C0D43F1B983C443B012C94C05E1D823C9045
      EFA7C5FB00B32891163E8DD3648089CFDB11BEF237A4D83AAB416786CBFB8C70
      F663070908573FA745C9022D96B6573E2AFFE96C9952851B69F6A21D8A978BBD
      722FCB2840A18CC5781CA4EEAAAB49F8F2A4CA6E3AF804D617CD1269099EC7C6
      454C6AE1F1B8DA68D663C7A83E8785B669DD98F01192955F699C7A2BA41B8FC7
      D54D78E4FB72F15DB20531213CDEF5E1EF68124A8B099649B12E40C82D17E1AE
      0555551A2FA9828CAACF1A66EE76892EC7F7CC09A164A0D10A551D750F3F5CDA
      D87F0A6E57D5EDD30863DBF7E7D4511580FCE2B398763C0070F4C678EACC6AAB
      CE0FC0C0CF13151C292F52EBABB7AFE1C72926C27E9EE9907AAC788402C81160
      7F9A668CF2AD911A168364ABD3E1028F7238A9046695A4136F1403BF73123CC0
      4603EEBD46598A21C5E67CA9E72C2853824C60FB85C0A7CEA10101B270EB36BA
      32428FC9A72C1E9CAB5E416299E22E809BD75452E53ACA7243815E4A2B8AF251
      98821888CE20CF53C43ABA4D787C7C1604687CF4F0BDC0127614FF247D22352C
      2F81A9579C7B517C97E9EF31AC9DD90A653BD3CCD8B9E21DAAFC0DD7D28EB505
      C944155D0B828358E4240A8DEF55BD4A4CD894BCB201135B79B34E1057FD5173
      D39659DAC07BFCC08B395D53F6C530694F4D76AD33CB63A035D778A30611A7F4
      2BB8DF7B1C3292E62597892C67108A6B7853612DA4EC197BC08904731D8DC3AA
      99AA9163BCAC48D36897284FC8637B9FCA35CDBD55EF02459432C53B3636D768
      BE444E2698510DB6832474DDF7BAFA37E79C48E50510496C94F245F6F5F342E3
      2E4278D08D5ADF8BD12586C9A68C5E63D5E253AD04E874CE340FB3F7A5F0652C
      4D77A336674BC0638B3BCCB0B8B770264E290796D4235D685E35D00E4A108B56
      8D19D3BECC12C15C1375A7EA54282729B72CA414912907D8B317735C335FAE32
      A67DEDB5AC169611ABC8076075523745C6935189199FDE8C2FF244D85730CE7C
      1E06640F2A39C0520A5772E76412337D0CBD9ADDA523778F252B8E38DA7CCE55
      CE68C43B642191056310925239E70AFED29DA64E7716B3F94E6B764541C264E3
      067C88CF633ADA7D9CFD4328B285C0303E361C007539E59C43220485897399AF
      5C0FF53CEDE647D147C6628996C765C0AA2E528AE54612919169106C4E0922F0
      E5157B5B3DEE29987EC4B79FBEAAF13D53405315FD8A77E108D738692ACA3145
      5729BAC63000C67C9A33AFB18A517E2292A6E5576AEE3B1E1A3A1EC691E07EA6
      A7925100F5A6E85CDE4B6A1201C7F63B79CB6B1C9727712C17975FD61DB383F0
      121FBD6486F5618A242C8E96D3590E63E1B81AC3EB8AC62A1DFE1E0CCFD54B92
      E44141B5B04AE54616D40EEE64787BA263D589A0707D58EE437B7AAC28F09DEB
      8AD467D7736080838B4A1AF176DD510FB1A7781635A2E4004B544B6656CA667D
      319327EABA41A4C204155A7456EDC2FD3C8E4A716192A8590D6B19936689DD19
      5425FF58C6634BBE85BF54656F0EC04D029F4496E2893F725455EAACE41625D6
      2FD451D50E5E1C3647EC30F2202BD20B8F4E9601C2199BE4D0D18DB312844480
      734349C324D1162075AA196E6E59520DC93CC359EA6DAAF2DD95CC804B789172
      367D3415E425C36C29DA4FC5070AA313D4141D879F12B6259BC0900495EDC954
      384F0E9E4530E521E454DF7BB7B9107706B7147524F59214CE6C19A083044D72
      900863F592973B3A3358CA2ED2F63DAED940BB8A92A5001731AA415799324A99
      6412D4FEE8540416550D5103C54B0A0031AABEA02604380C344E30B343EC9600
      53A379C5C7B50042C5B7041E3C0CBA11091E4D1D29742C898ECE7A4C963E3B59
      54DA6FC2B6B69C08EB18953871387DF033B955CBDE14CE630FC32B3252929307
      6B5D3B3F886071ECFC286E9609B035D8E1EFFDF487E5F018630191631F231906
      0E150BB44D7A53B1476E4905ABB20AB90583B296643156EBDA0FC7D1B502B38A
      5EFD7D80E52EB1960F416F40F54525089DE2FC0B335F3B7F3088E0210FEE1F0F
      E94B7D80470B0670062F86DD011CAB3F566CDEC43F697610C2DDC6237611D6F5
      DB88D604689ADEE0B36BEC6B90B88D959B8BCFE7B7B7D56876DCFEC63717D1DE
      3901FD83CAB2CFF02F2434B934B55DD92C7D3861C268C9CDFEC6F398CD1B045C
      02A954F6B1FC0F89B25369ED1046BF365D572F5E86643AF3925D5B3613225833
      C9E424D8A11436F1A5141FA0AB3605860004365A50297F436D5010C99C9D1C37
      CA41973BB758496DE50EF33EA96B8988AF5072FD24BCE08404CE11D583260B02
      898E7C3F974146BD44C2046BF838E798768231633E8102EB77EEDAE20F2A8AC1
      9C38E7C19CBC58F1E99717498EF11807D4F91F2C882785162EC209E2EE32A5AA
      7E4922DB866481CB51388D2816748915F17228A350C58A061536287259E6AF04
      8DD55CE1D1D068744BA0D1E8AE090D263EBA63F41E083B4611C77C6E802A65A5
      0A76AFB4AB871A6286499975661DE194A9C787AFA93055369EA4F56CFE518584
      CC4ADDCA7A47875DB5443F2E76CA53E6C762A33C39BC74D0ABAED05FEBC8EF0C
      92635B59294A583C5F17CF8B207B2CAA67D2DBB6B03D7B4309C2BF9D6492207A
      8FD0400F5C37CAD659A58E1AAD5ABD76730C1F0DFCA8D56A476C7DE72755DA9E
      B2E7B18B91E4932A1B15C922CAC653D9107369B01819EF22CF2645B2F8B284B6
      EA62C0B5EC0AC0D5555165557E1B2690C94FB198FB840726A2ECCFD93EBDD338
      55F75298C19C0252D6117514BCF88018E782D299F8D4505B6B9F7ABD4A0CA741
      A5A34C1FF05F6E7E65DCCE4A20A7D9A9A4CABB929450FB905C630E4C83236356
      8CA734C67A8D51ACEBE8157A5EC84391CDC437420C1601066DD2E9506BC3F154
      E4260C4C7E15937EE19840F3E65EC89A60717C3553599A5685592BB11B8F2F53
      11439CAE396F58C4E6839E182EEC2BD92109DB66A205504F4D2C44A88371E960
      51FC9A14EEB5871514580A1640D7E61228C5AD3DF695334E0382A50032A286BF
      477C1C0FD0DDF53B55E63784C957BE57A804BE2251E5C830EFA1A36E066BCE7C
      B358DE95DF92A88AE94061FDF9722EDF0AA83AF30219562203BDE54FB96A0A92
      59E9711557D7BD5C643A83B514162D85CDAF6B293CA85CA86D3D217418497450
      C5DB7DB636ACB3F9798495F45D1BED749FB5FFC7DEBB76358E25E9C2DF598BFF
      A0F69C7512A69DA42DCBB7EC33338B04328B53DC1AA8AA9EB7AAD6595BD216A8
      B125B764435233FDDFDF2722F696646348A0C84AE5A46BA649B075D997D8718F
      2738682E9D8958DF32ED06389C5B86FE24A25E3372791F733326E3C79AC6D351
      51ACB8510552DA2C41A5E717CEE6D78D4D4A9F1469535CF91F5C95BCBE46820A
      C4E033CA801AA7A658DA6C8B85F4E757E6F16F7A093A825D7053D6635CF59C38
      4377D46D4DD7D76855CF898BC9B2169C675A4C357F609A9C95229DE2981596CE
      DFA23F1C962A003F4CE6568F5F238CA9C876997B8320BA703A5A25C1BC5ECB76
      36A6BC98D7946AE153758F710F172BCAE54342B45B9F7D71F76D7AE194DA6AD8
      1755A8973B0D6A03CC036EA9D9CCAB0CA82C3A669D73F156AA60585FFBC4C9A3
      0D9D64292B71A9A049E497D92CB972F2D4299A0ADAC7D2EC2AF0990F0DEA25A8
      E71BD6E6BEA3354ED2B20C8E310BC6932984417AF38DA9768D4FACC6A295A413
      F618BC295C0773DDBBEE3483995301E72B7438D17BA5862DAA61DE9755C3C03A
      C7D209979058125DA83F65435C6C3D777E239C24CA680795D89A95A2E731E926
      5038A6334E2E7DA793F82229BF4D29279DFC7DC4B52EE330D449DDA4DA7E24EA
      6101235576C65B58059B8B29FDA42EE938D965D96C564E124F56EE9529DB32B2
      1A4EDDA61E9F157D3ACB5E028FDCF34390794C85D8E45AACF297E59BFFAD8BA5
      E3F5B5896DAC146A10964873063065ECD439295EA4087FC388B3E486A4EC6323
      9F1ABBF3ABF663B16ACB5A0E97688AB61ADFBF6517E338D74163B1B586B36BFA
      ACC9F1EDB6E692710DA0962893FC5AE9D5CD4ECD4CE0A228578F402F976CA114
      C5DC1DA2C40630ACCB745494EF40EDCD718066137163DE24D4B677535AC161FA
      45FF49F1FF1B212C63B2E9C085C10C9B6E2691790A2614E9FA7A6A129489145B
      D65D29B32BBBE471FA435AA9E19F6FDC66FB6D5B9594DE4E493245CD88AC0317
      4EF032ACF4D24A039CED11894B453FD977854B41DA1643EC9BAA47AC9EF04F2C
      CB7DA7569036B2995EA27F369D59929B8C5C7A5A6E8E1D849A34BACB378BF81F
      BFB8EAB2C49F9CDB124BDB74D3DAEC4FF67B09FA7D540447D22CA05D396D7D62
      8006ED696051EA166D117248C8940222A6EC3D2E6139EFDFF3725FA71F87ED1E
      7EB6071D17FFB87D6F807F3ABD9E877FBCEEA0857FBADE902EE9796DBAA4DF71
      E99281EB7972375D02E2E9F3635AC3215DD46E0F5B7455DBC575F46FA7EFF175
      5EAFDBFBBCC4C4F849BF139D69DB71DED1FF9B95C4EF3B8EB36D6B83BE9D3325
      6A5B41BCF61C543B8B12F5AD68EF2569AF243AFA7FF397FC5790A0F32D512161
      0B09C765175B9C494DEE86051129FD6ACEBF39F37E3526530E12BD34C0ED8688
      82CD97875D4F095119BBFBB2C33512E9338C5712F08DE35EE42C45F9455232B4
      D29C2CFC86B5B6F7255034EBD9E7DF9C19769C9456C654F94D816EBEEB46CF74
      D9EECD57A68ACFC0C6A6F361DB7D82FDAD56C59ACB60E71C99D2FD37B4E05405
      5ACDF4309795D1BD2B6ABB6D9A8790C7DD14CC9A442ABAD8182752AB3A97C82E
      6C89FC2064DC29A9D5B7DDAB397A96A6D55E3B323F729B15963CBF9EED365880
      211ED474684AD4E55BCA64E5E9D4AADC7C4CE6988C97DBB556A0492B502FE7A9
      315B31F460969749323006A519CD2C5FB956EFB856BB5FD6B54A6D6A8E8879FE
      07539CA56543B304C55DB31DDB9E8EFEFCA31D2B9FB51A0F762F319D47084BEF
      6DB1BAAFFFDD320BFC564C03BFFFB804A0B62E73D9112FCF6E7A93BC1567929D
      CE3D7B41F35E36A16F582EEF5B68C880D8B9F04986DF32282973CBF50813E77F
      8AB41648A04392D03F4CDE1089391B14B1DB74DE18E44B21BEE24B2B53364510
      1981C391EBCCE416E653755B0A21816C316E99C25BC2AFA5AEE7C5DB5E5A7BDF
      4F729DBD7C7BCCF5B507D6C0D7DCA1B2443915C5D94E7E79D67A256DDDBAB6DE
      F323137DC3390F9547E496561BCE46B8E0CFDA944480B1E9C960BCBDC773F1DA
      386154D5B0EA487ED4C2532BA4C7235F9F9F1EBCBC11226E73093013E5FC3124
      F32258DDF3641F12BAFFA728872E9ADC3D38DF300B37597C39A53593938AC28E
      CE48F97A94DFE1E0DF0E033FBF9C5B888DB226C43A48E2AA4136D77C51863E8F
      CB6CF388048CA648ABB2C8D84CB20F80CF6444364ABAB20495E4AF4537635261
      69F2AEE9EDC4C091916623F9E979913B6CBB36E629A93D5C7EBB3A19C5C910EB
      8FFAECA5B32C909A5D42A2356D570C809B058332E0B78D9F77618FFEEA70EF52
      6CAF0D37BCA1200B01787C5B60971C06AA34A851771668636E856435378B9522
      C4096A19B5BE66B11417F0F0282854D45FCC35B8560C6A214518DC7DC8849D94
      B3B3777060F30095F3D3E9C12EBBDB9CD3BDF7A7E5E774D5A6ED87A2099D5265
      B7731E0E6EE064DA189163E20E6D30CB286A4F324D61DD7C0EF6AEA8760F6DFA
      AEA819B677B7E81BF9B287573A2809811690F264CC900B88C25F9512411B45B6
      C9DE544644A803C5CB6C96A7C504A1F658D263DED928D8594C9E14D3CF6D939B
      882DBCFE9B651987EB6B25B0A9ACD0B773D0CFD3A2CCA9315E5C8612CE14C26A
      7AEB6C102B159CB2229B22D7A6D501176DD209CB52C65BDBF97E9321D4883D94
      006973FD094466E9F08F34316B4982EB6B8DFDE4EF6086DCB320AFEEC1B72577
      1E5C0667A32844B67ADC625EAD81FE222FB1BD6449FE908993193F315D24F8E2
      3613FEA89068452B137EEC342D98319B8F7F9704407BE9FADAC6BF154CD97E68
      731B94C5022D1B9815CF15504206F983DECAD52441C0AD40B8E2C60C6E92E928
      FE58E2964E8AD4F97831243085C4136067CDC82D62FCFA345E3C88D56212C0DC
      6A501AB8888AA918CE2F9B5A7B59DEBC699524A99C9C986690738A2FE73BD133
      A5910B0675ABA765FFB172358D901A9B2EC79401C9906DA5A816851D5F17B88E
      3F4917C6B712C7B008CBBC8747C7E78EC19454C96DD93D47E0DA58EA8F0D3E56
      19DD300B2A7FC559D9DC6CD52B0447D0287AC18226EC6C08DA0FFE34CD1737BF
      41C5B87177151A65D7A2B934408BC3CD8080CEBDCB5AA8CC96B02D0D1E5560C7
      D57481EEE9A8D9416849A63228D7D5B4A90223748EE28D86B85072BE7466D78A
      1AEDF0112565D796FCDC7DDDDC930D7A3736E982616C4D4375556DD1CDB9BC01
      2F40546111064991F8AB1DC9D4D684993B197AF622B688D6C1651A4B9FA6C67F
      EADC3637324D838FD2E28385E91AE3B04C5DBF0BE46D67BB74FCD5C2FE4F4CC4
      28FE1B95A59D5F2CCE1537B7DD1DC6A6ADFD7F78CDCBF71964F0793F9B482B46
      A05A94AD4D6E593367EC11AD3E890348288603C1F3D6DB5CB781A60151B68DA8
      53C1DE8EA779D96A3AAF4CCAEC407903611996548FB7E98FEB6B73AB22E86397
      65336379526E65BBBDEAEE3ADB7593F2CF1F8D46BB63345A31A4E6F5613C72E7
      7B1A9368CECAF4ABAFAE6D511B349E8DAA80DBDFB280E10A0AA3E45153173AA1
      7B6707DF90149126C896A14F19707651F1E4B356E86CFFEEFCAFF7EFDF0B203C
      38E27822A18E52851D4B6D760415B7BCEBFFFC1BDFB655348B88A03FCFE33B4F
      532255A84EC95DA5771ED87FA585FD9187E4549B5686C5290183FDB674ADA282
      84DC6F04AB68E55F417C396E62AC66D83F853FA1E2637FD89C640DE13E66F4E5
      A89E6AC53A159789F4BCBCE4DC30CAC16049C6DD800ADB935B622A42BDC96D37
      F68A3C17A544C86955E6DC773EE8F5B50446EC88BB61D28BC79A750FDAFBE3A3
      EDC32219E26B396BBF33D4FBFA7DFCF184F41D1C8D24D09F21E6FBE6A5A3D3AF
      8FD28706FD024326EEF0F279C9AF252796A8ECC547FCE28BBCBEC6CBFCD9065C
      3D7BB695F285E6A349B91E15675FD1539263B4C43CC7D282CC00C6725B95F1DE
      D9611CAD40B9383B60A426E20E3CE28CD9222740F95F0B53FBFD0A4431F56A0E
      B66936C9385A3FBFFED5C96FC77E3A3201C279B8BB409651F4EBA25592595B32
      5F3308FD09684FAC66530D2FCEE77CBE297719E027525D5F5393C9883A657326
      B6D49FE2FD25A800ABEC63756BBC1D14CF4BB38B949C21F395BBF466CABB2E40
      EA8C4640AF095296FFBE0AAE18AA3CDB7236C45B6B120A6C5371199BC3763259
      105CC790A453DB12A39280A03F2A8ED9CA17F64E0BE4C97511F1B42C37840921
      15B5F240EA0553AD34BC5C5F338957367224894D8C7A5834D07DCD0D7431C364
      5A7AD542DDB4391AB2497637A4DFDDE2FA734645D9297BB1BFF69E99081B5866
      6FC8A082EAB567778E2FA53EBFC553C82F455A9E56495E548951F692F1BB8777
      F6CA36D12930B4D6D7ACD535DF02ABEACE970E8E761276C29526744285D40C3E
      BE8E436AA46EC98D7B67CCDF2F17576F2F9670C903B664A34A3AC7F382F20828
      79E6462585CEECA4815B35F05A5271AD389C7DE71DBCB2EB6BDCA5859E263058
      9A537739D57FFE297626C58271556B6C0B0B0ADA31E932209FA6A91BA876AE2A
      97B138C6920A18A633BF4A8236074DE731D153C6CD9A6D6A504BA22955AC238E
      AE4B14275F8A1661C22494B565F031D428032D72B7AA9CD0C52A2370EE567D25
      12E211EFAAA9ACA58117B94186E7613931D815362D634C4F8D57C411E3EB3D71
      99EFB0E8DF54B09FDCFCF36BD128389FB54FCB85B12549259C4B4CCD7A3ECED5
      8A538ABD6022709DAC91A0E6F0FE07F3D039C82DFA4692F2ABB92C737B435F1C
      4A63AC3F3BED15F5CE6D495241EF2863DDB9612FDF162D172A5D519DCD6E9245
      32BEB172A80C4D54B204F262F11EC81830D9EA456BB0AA7416B88E39CC12F100
      490FCCF4CA76EB9B1B93490BB0818A944410D4424A0555C1656580F4061EE09D
      67D0D72BE65E56B344505C59D735E90A2C838B74856F06BC6E5766BFBEB6307F
      42B28F4545CB342B9F012BCD19119CB1B3C965A80480434AA870B581DDE78000
      A5685C5063BB8BF2CC195BAA914FE9939F8B17FECA4E567B4B51359DA42665D9
      7E53D80A78EA8529396DB740F450244D384F92AD696856FFC3965F64D479BC32
      667B7E0D98EAFA5AA0A4DEA37883C57925C7DF62DE3663BA498F1E1355B1EDA0
      496B5D5C4B32CD2A2D64535B4A62E41A0553F25B581863CA83F97A0FE9520792
      5FBA901E7B465FD3D828DD68D187F4829C8061D999E7523FB5C2B5F4AD1C7B12
      88F73A00B108CFF457DEB7712F513B56EC5199D3520870A3009E15606436FB03
      1BCC4E404E5EA3A3691BA30B6C2C8535C5B69ACBA193C87CBE35FD3865D70A5B
      81F9552CCD75E96D1F38D7BC7C1F7B02E654577AA3C4696165C56171D32A5EB9
      BEF6011B79102757CE1BE7FDB147C9EBF4D7B772F6088DAB326D9B074292ECBD
      77B6670DA9380946B3B0143DFBC6A164D346F2B98EB178A0E4CB9827571BDE98
      2C99B2FFB3F980FA2C361772BFCA2C4F934E13DF7130F18921EF4AB18D0F43D7
      364ED4F4B2C1481546B7ADB4E6B6A50B24848B6455D235EC5BC226E901AAA285
      2C51C2A9D7472A89BE32A97B9B2655D2780B8380946670129983B240F57322BF
      88E5CEF5A21460D322F2C03B48FB4079AA12CCF575D9825514191A5F9928CCCD
      478A58EE8B97653243A63782BEAF3E6344E60E621CB925C7E2187DF922D9CF27
      66CA9606F3547397E4B181A7054572AF5243DBDC1B4668FB1DCC0B4A6BC32707
      7454B315EB5FFB20113B1B78A8FAD8C5322BE31E51FCF15BEA0FB3ED8C28F9D0
      31993C94E9B874452A96C458854521D79D052DB25B2BCDD22FAAA923FB89E472
      05CA74B6C875919C6CF243A939D54D35AB6696141DD04367FFFC90E31EEC1FB7
      100695EFA9686D165C92342B581C14390EDAC6016404BD2DCEC725F7A894F998
      800AB9690C902A56C4ECE09CE37AD9D49B456700AE93B08D4BEEF8166F6C82B2
      716BDAA08D0D2C186EB6A45A1723C59252B63323B29605B9A638A318AA0964F8
      B7D45D0AEFC402081CACAD8180614AD77131A3A88AD75534A6ED87D6AB902DB2
      520DACC42CA3D6558D258B62E6C1B8517479EEFC78B8BDEB9C6464A94E39BE18
      C9CC1B67D36C164C1B64F037B619B40C5FD90F39D629394A634DB45AD5A6B97D
      D8A39EB3BED624F85D1A7CE6C7D38CAA3984F605BB494BFA1633300A4296151E
      FB53AB23CDA92504894133DA74CE822C9E983353995ED5E9F6C3BEB3E1432213
      1E0287A60886375317AF9257841F50C44116337BF793282D5CDD58E2D0F82068
      8F45B473D2F225E3943F52F83D41F4DDE2BFD7E3F16BCCF5875C676F9D8F1851
      A83FBE756E3F0BD6DEFADA4BCFE0284D5E3EFDC6D988E598B55601ACF5B51F58
      1D270D38CDF67719F56DA42E845D2BCE6CA486D39497FEED485708BBF3BDB3EE
      9B331858C64C7AF3FEB8DF73F676F7CFED81AEA4F993502C01339AB6EEA200DF
      9F64719A99B4FE60726C8A1E4A9BA108F44BAA88ADF91159CD0F27C190B04192
      41BDB46E0D5F2F4850656EDE72DE5161E074DE9493AC8662ABC53342F8E02294
      A503A28808E379E5205A564E44421CDCA5A251D46ED88083BDAA4870DD2E2D47
      68BA17E43B9B665A81D7DA3190CFE386F09FED226273CA65E4B914C6A25D86C5
      45603F2A27AD966F932E3F625B2DAE82DCC5C0E962F82529FB6009C78C463797
      EAC2CE5B9C8515A39058A124DD04A65E0946CE1B5E524A9806C57C3B1C828074
      4582974A9C780B25BE76CF3AC577857C7CDF78E2A78C0887E073B851CB743551
      682A65BD1BC421251049F95F9B552F4A79A2E6CA84CB2CFB4F93D2EAC0AD1965
      934AC1089E6483D6FAF4985456EC086194880FAFF4756D105C49D3D9DEF9EE54
      226B4DE760FB08979D7C3835171F6DFF7848B7F313A983A8556F538689DBD8AC
      38AFB8F309A9C69BDFCEB9DE4FCC8A342DCECB12C3617E3B68A17016BC625B2A
      1E4E53A14B379193B334D34CC861BEC939B916B94F08D74C4AFA3977EEA1AAAC
      946D9E3F3B1F9BCE6D157B77AE6E645AA052E55A6514EC276BA352532B43A7F2
      CB58B2C8E68A8545D08AC7520E2945556DF9FC265310BB3125D83AFF54633747
      ECC212B798F4914834EB17245B2B0EEA6275395EB2B8C44BE9D6D69059FA9D37
      D10AB01B4C996E17830E4F703638EF81FAD60BDA16C76347B756C9996F358595
      17A09F66A936DCB39873F9B08BB5D79585E3F6EF156785126F0BBD259FCB7852
      C6BC7CE84C4B315E49115C1B149BC735B9E0D5B49AA7458DAD1FDAA44DF10663
      14992EDC1774DF52F7B554A292638376A8F45C4B620ADBCCD51D2896E5A58D40
      E64B2F6F058E35D4D655D52C2C40DBBCC9386A8A130D0A290951D28D2D497F3B
      12410EE683273291A6A6A96D00C5458395C5345863C571141B2D6C56B93C1BDD
      F4C5FA1A7FC50FAE760721433C1350160BD75516F219EC77426C4F38EB58B8AD
      98321C5BE2532EE79B8FB37887ABDCCC9F5D186576CEEE2A46CDB657C977CA05
      09634966195BFCF9F22BCB71C4E15BB95BE41073E12287CEB0D3F5B51BB20665
      8D38C05EAE12B15ACEC3BA315149861936EDAE9A65DAB91552E5FCF9429B0CCD
      73A61B483ED137043F9F09728D91530BF4BEF214411FB51EF1B2DD1BB95E9734
      51834644A95F366D3E671FEE8C2239C6B7F1EDB08FF3E5599FE5B9DE605D8A22
      03D08046714EA81CF3B107C355B09038589CAE49AEA0BB8B2A9A81B142AB8DAF
      883F49C14322004AD52A0B4A0B2D2A30F8C0737384B914D0FD0ACC22C5B40DEA
      88CA45C1CB0AB547503BCA51909A636047F164C983290DE6F2890693772E5E6E
      0B27CA26499CC1832750818DA26BB69C8D7752934C97A83954C64A8D553947D1
      78841F9B6AE6795C951BEAAD3BD9DAACEA43260B603EA4832D8B036DF4A10BCD
      D1FA2239422D3D29F48D68CAA568A80A161E1BCD622C1E57D21489AF9B3A99BB
      CC782ECB21B8A41CDF8B32CDA1EC0C724FE67155B69805B549529CD7601F0E7D
      9ED2C349A8D1760BEB96622AEAB451C984B0773C22ED79C5501989816466C32E
      D3A5245F2F4B8BF9F62A2CB9A2C42E50D529F1C895B20550970CA9A7138BC163
      1F31A1BEA0BE0E146953F194118FC90195171772C2EF25650A1996287C63B164
      78AE82CB82D59A1001942CB10F4BEB89839E2BE25F3B38DEFD805D31BADBB742
      D73FAA8C9223C8B5CA135F96A0615686F284B80A34B9A2140B9DA7C99F566473
      76C9A1B754A4EA248D8D5540E1F531799B39000F6D24CDBE212DF3500A1EF252
      A4174E45C3EEC8DB1871816D96CD26DC1C787E114D96CC46A104919BEA481DCD
      A91345C61B71DE389931BD8684872EB1B66A2547E5C58C975D8AFC07465BE4D8
      D0063A6940192AB6E8667E8B29946AFE2C8152E7FB82518EC955428F5D423077
      C9C58E38C536C684B6F38ED4BA3C541253E4CA2B810B8C14071B255608F161EE
      A7F7C934AC5265E404147BD169E38B842BC75501A65364F650005822ABD0EEA7
      DC828CCAC2E81A3F4BAF44014C8CA2BBE5FC673A13F173C53E549F747D8E65DE
      ACDABA93D726CDB8C29A4B520F39F1C8795302AE9B4FE8409CFE9010090812FC
      F628E69C07E7AF3F9C9D7F43618FF777D3D21652B969A90A640149D822C29EF9
      55AF3C9F57BB940767E7CEBF55F25E656DAF73FA6AE70C5F11DC85A988A87E77
      40DF1DA42630C8DF6CDE138CC9617141C5B3C807AC89156334CD0D2BD1982A31
      48B6979003A4B1F9D4DE730F06347D66E865D515A3B062B62713B03649A3E3C2
      3C8B635AC948FD568ED2B6633A93EAF5B5B08A5622C997658F4E89A058FCD154
      BAB8A47EFAD13869AB6DE6584C8EE2317EA5D04D5C26B39AA7D87BF90C26F777
      DD74989A215FCC11B7487104123717889AF30017D6BCBCAD691DAB3650680671
      0798A5790FBEADCAAF0A7C98851462D203D475D127C3D938B392338CF300A443
      9DE5CC2D65A2F1E6DCD8850B5824DD6094E6A62CE4338FB93A5A41924DA745DE
      C3FA9A38D9CD7BAB63372B8E715A7F1C57AB71F576D3269608D28DB99BAB756C
      B897C2ABB4DDAF72BC4707B34A8C951F2C0FA230A7DC5C14BD92FF66CE214ECD
      51D9BB3E3300BD363ACD8689D157169186E9312B26B826DC8F95B6AF90EBFD6E
      30374C39D050D335056B053E6D3F3A8C7322E90DA52975ECADB37FE3D32F7FC1
      61924BE82F623D6FC9998D2BF1CD599A4DE5CBFCADF32E4D47A415FF9B734E7D
      F7FEF239329C48A53028B9B68530347FDFBC7952D42CDD6D03C8BFCCB2845B0B
      961E5F8B9A0375A1009E66986C13DC7FE9E8F892A5CF972C79B1A8E767BCD639
      2DE71D08C2DF1D54C718243067E144ED1A50C5821903C72978805B1459B00BC6
      E061E246E3B0A47437720241FE762A9431D77FA9603E9F6D5DDF6988424103DC
      5006D38697D6FCFE1908D34044BE742D5C39A7BD24FC636784A3B60081473290
      44B109AF5040C5A603E6A6FDEECCE7F6DC5CF971297DCD2BCD3D2F67179A4216
      132DFE0A8EDCD2E56F4462728A139749E1F0513D491507AD3A98517C453234CE
      1FD12DA864CAD38FC3760F3FDB838E8B7FDCBE37C03F9D5ECFC33F5E77D0C23F
      5D6F4897F4BC365DD2EFB874C9C0F53CB99B2E01E7EFF3635AC3215DD46E0F5B
      7455DBC575F46FA7EFF1755EAFDBFBBC9280F1587FE7B1B9561616C1A954D330
      71EDD81E697F3157F874B08AABDFBC81F150FC553D74E57336FF525C302D9250
      1CBE5992ECB0ABE6EADB425706AD954F28EE89624EA6A83CA33C134B5FA893D0
      FE51F9F55B92ED10260C31BD47EEAE9D4B1D5CC14CBFFA92DCEF59BCEFEE347E
      48467727F222E8C48B4C0F660C47810C5677406F2736253E130E5A2F24121681
      F7326E6E1A8C18FB2EE73ACB3C1D5DF393C96D4AD1E89B98CB29A448D04290DB
      AC0002EB2FABF02795F496CF90BBF7539A8DC2B3890A74D37945D1E39F4F7E7D
      D5149DEEB3D4A1BDBCE05C3E8D76B3FBF9267257601283539CA99D69563C2BD9
      5B9BF7660CDFD0B0731AB6499AA5F48C9F8A0F3FD7C61B4D826A027EA4C8C2D7
      A22299711F292A41FA4C2397AC67AE7BC2EE5C0914C4485DE404264AB0A4DC55
      479C0D9C173897174399BC06F2766577BF9B5D7CF395FF993605FBFEECA21A4F
      E6EC038BCB4C083031039C53E08BBA129194E192FE65B759778F4DF061E7B77D
      06E52819B8982253EABF7EA1AFC8BFC85BF0CB6404D164F6C1595C8485E93FF6
      6CFE02297D89FB3BBF843EFFD2FA85523CF000E797577EFF97A9F2FFB98402A2
      F875A747DBD4779F400A98D7DF039E132816BA3BEE7D04718C72D804CB2884EE
      9FA711CFEDF4DAC317A7907FE9F63DE7353908832BCE19A4DAF354E7C9ABA970
      1BD3227CFAE7322BAB667B8829F43085D3B26D19C756690626F5B04490E08031
      D5E25F984C1B2AC89F140925359A521F53DA5553B574425FCF3486988694FA59
      AAE2CC7458F353E3C6837914A4ECEB224859428D9894B00A601D3F9CBF7F3D70
      C8F8775E0793B7B369843F2D7E46ED263CE860C234DFC2FF6EE2F52ABB9248BE
      E4BE1B173D6F649168CB8181FA4D891804B7A633AD57930BE371E1CA02A88E23
      EE7C114C29AB612367E9B259C990A3FCB89C5B305B1B3B94549322E3A15DBF49
      77EF106EA60592C4A4288FD384AAD26D2EF18812044D62B2641E06A0610AA8E5
      F1743607FC5AA35912E3BCD2B77E4A52B08C2EC6097314DE261A6B3E2713EA37
      0D6296C599F2D311E1A624E5CE45333A5DD4BBC2246BD66F06033A6376C919AF
      476A3BE3A0E8839C6286D45EB9E48EF5DE9461754A342A0CFE32CDE2DFC81131
      3268D584DC1790F722B76E5B3F9D4ED3F138CD257C7D5BBB890D5B9818694494
      6D06063036F13BA71AF309B5707F764F9B6609B0D1C89B82ADF4A9EAB57E1323
      46DFA05C1A6A4866C0201B73F884925B56B3916F14260D47E07349AA7E5D848A
      6C50891C24529D6059731067C16C4CD50C0167725BB42C93F66812078D3BAC66
      B35E5FBB6FDE123A7CC3BC8E7E59B60E236D5BB15CC719354A771AA597A75166
      775997E046917968D6C6F4572728065537AB6E43AACAA9850A3920885FD2BA1C
      A8E46246B9A61541679AA0DC282971DE129D3437C0F920852D3F576FB67CE53A
      54D44DCD9EBF8EC9426D1E94AA35F98C46E660878E9DA454A2C2C450C4886100
      963070E055F62A654A1D8510E8B945CA68CDD720D360B5166A9E5ADA48822CD4
      B8946ABE287B76B144B92E33C2E95E3E27E3E8331573252513F83CF1015CC7A5
      6294AB645B6451D20FCB52698C359502301D5C9972398194931C6E307BF9A666
      0B72DF72248C44C5AD172B996E65C9E29B4AB9E2EDC460E855D89BE181B60AC8
      002FACAFD9F6AD522D500873C7D7232E2BE43A94BA31BE7FE9B55AEC0A991896
      AF9C04BAAF3164D464E25C1BCC41F107D66CF8F709B422BFD0C4C1D24A816921
      97B816912A0ECD45B3641A8F4C328DCD6A63FC1BF645963D55EB3EF99FDF1F7B
      BF3AEFA91B2CA8F5C3C1F13B3ABE37595ACF19ACAF2D99C3433A06B735BB8B4F
      2275F6A4AAF0C65A3D84EB4ECCAE2E210B06D411CAA8D9E2DCAFAE71DEA5A49D
      EF2C867337D8FD5AC9A2DC6C3A8DA3942C8CEDD1A851527F1119B2F9F515BC41
      F6DDD48FA1DFB31CDBBCB795F5E01A71C64F2A92F905EEBC74AC6CCED772524F
      940D421520D5852188372932EA8F147502F84AD681437C542D556C2F66C4D504
      5F8906BA63FD5F30FAA7C16C6AC297520A2EB55EB6B99BE4279B761916E1E3D6
      A44C27AFA65FC7844F41A3E9D8D9FE715EEADC5412B6EB36917B68EFFC78A754
      9CE7790C2EFC294EFA5FC94484D840848DF7508098651A67CC4D1C4E2FB96AB6
      C46E9B6FA756B8E5A163665A19141DB92F8D28E1829F54BBD378CF527CB77F7E
      B8973B1B46589EC0388A3FE253866CA5BA6147F2659D3D71D26FB2BA71FAC389
      3352BE1E156E03938D996295C65FCBDCEF343F2D68DA809F5560922CFAD08ED0
      C94F059D7C25737D4700ECF8E83B2A5D351D337367C77420C39EB2EAC80EF237
      A0E07466FA128AC40D66F954FA378FEBE7E9B867C6A64A1E67389F09948DF371
      77369EC8BCB2599298EEB94ACA58B8DCC91CF80203589C635FC98C29B6C6D559
      E29D09D8AB1CD1E61E1B97339D72531E4D361F55E750774EE904C7C191D8B40C
      F82A263C1F8933D9508C5E46FE4767A2B0E765949F5A7F1346CD685402784851
      763A0AEBB7C9F7A84FD5CEE3C7DF53C1FCB48434B9D3958C37BC606B66857C5D
      74DC66644AC575705C67F319E0F7F728B2FF19321BBF86DDBAF18FA308E78952
      362039F21D5CC5362A84A680C6645CB7C0CE3536D46CB738E6571C38BA6562FE
      3AE63B4BA4F25270AA69AAB0CC99A7083003CB983829AEBB8CC5D2170E944BD5
      E4C52CB36D36DD4B79941158F5B3D2962F43252D424B0AC0C6BFD1EF064EC2B6
      18853285ED1640A002853ED445EB277C2970417513B9F77B2D046EBAC98556FC
      0B19E83B540647CB71381F6A926476E2D495C8DAC6C988B56A3912D5068A92BB
      7E9BCEA496B402586743587C683A5B9DADDE9FFEF4A7BA79611F72F570E5ED91
      BE61136B8916CACEAE8A24136E5FB98FFC1B2606408FE0D4131D4DD9EF5FEDA6
      640B771BBB29894C7EAE74D011C7A841CC6CC8F2533578191458F25A162FD421
      90DADDAAB12474D66CDDEF5BF5B3B3BD427D284298B2BE86DD2C6FC5D39E73A8
      31C9D132D86B3DAF7E5CEABEC3FAA345C52951F7AC7DFF954C41AC7127B01C26
      8D9C5D754301DD2CDCD2F9D8A4F6E48E2741BE0267842C5BB16DFE31A324577E
      42CD267D3FC7B84C4705D4A6C937E17C9A2B6D925925C65F816321320DA6D9C8
      A6A72C86B8882597990E73D05775598E7BCD1E0B4E201D213085783292362D05
      42924546108B81D31C3E479F480632E0CE131408A411BC7CE187E4204087273B
      C76C230BD17A9A31F76C5A09AACC395D36176A812AE339BB05F419FF46F56935
      9BE3BD51F91D1C38E7CF62B3D1FC3914F19DC04E2E113B3C3FEB6E6227E21C1E
      A5711F335C91691BCD97D2D3657DBFB210D70F05A8D238255B089C4B73997E50
      B6CC5D04A7311452850B5A3072B9BD8C2016DF70A5D31CF04CCD16E75EB9465C
      ECB5C9E328BA441499094BB0702BC0E5E56D0CEE46791EE9FA9A5052A10B960B
      639F5DACA0C58AAE9CC4AF64D90C4806114715AFA6B994AB986C8DA29EB55C36
      5541003309058C25F4D5687685489CCB5CAB76002D70F68B04692E128C3875FD
      2B9965359ED62C28BB6A189ACD3348BF5233C3C903D3020A9C0AD8CC12D46CDA
      FFD26BB729E22BA85B5C604764CAFA1D74DB8978794BF425413AAFDF245C53FB
      62D935E7414F2998B277461D7F265C722E79C5B46B2967E36431C77D6B369D3B
      A4B8BE66B39132955F4A018C0A02E34D559CA66FFAF78A35CFA99642974DF101
      B2DE802BB5E4A34D1439C504D6C4D7ACC51B482E694B4F4862053CAA2978B276
      1C1DE8E23DCA662A97E8F4535350A564B8755F5CB3B48D9F77B59EFC5AE4C16C
      D8E697FF4D3E08A9F0DB6C4822F7FADA03A9DC9431334AD32B899458AF11077E
      6C7B036ADA6C5B1C335C0CD5C99A3E5615B07F46582035AF96A58FBD36E5EC9F
      9868AC31FED2504F8866A6994A46D561FFD195DFAD97A9FCF6068B765A51FBED
      0DA4F6FB4A67E415E8F43EBDAEC6A99548E31131133B5BEE96FB1F35DBDC2F5F
      9BDCFFB2B5C93F18B5CDE6AC123E581A926B8EA3BB1FCFF6AC2CD9AAD9D6C9C8
      8B2E1EE7BBDB65F7A57A0E3548219324919C06CAA05A843371DC693AEF8F7E14
      9BA3B2E2359B8501C1C729DE6AD56C681F7B9E53059DA8CBB8A45986334B5831
      B956592C0D2758D5A6419B9603351B76099D59CFF191A2620BBF5F6068EE6387
      C60321C76631341E6CE43AE927A549DBF39E2F4EF8E6C7CA9378747D0F1E0C3F
      E60F112BDB61586939C4D1684E310E2CE0DC4B489317DBB7F7E4FCDD3B3B29CC
      26D3204B079789E9F865809F38560A43AB6EC2F09BD763A482E3035570901DBF
      7FF4FE589A9BD56CA3B09020FF4A1FD88493E74D3E03FBD29C9D1D2EE5AED9C8
      695465AF71E3D5ACD3295E715FBB54942F425464D999848644EBE0049ADD839D
      A673CC051EE435AA7CB37776583BBFEC8AB99DEF9D75DF3087B3F6DAC9DEE9F7
      35DB26B0E0CE1BD831BF4A6B70E110351BE35E9213DEA8B2788D52EA460534E4
      C3CA0BBDB7AE96A420C1E1B466E48FBB51ECB2D717929640C6641A86A65B52DD
      86BE6B7056C3DB448DE300AAA0646F46B11E85B9152852C86361A39533A6183C
      D5D84DD434B8DC727E22EF1BA5D54C5FC7A681A01A49E7A9B9C7C591F39BCE52
      AE3B61BF30E15CE584E9928A7E3712B723035213825E91DC615C9578F145E15B
      DE227C6ADBA799423EE4E0A428684C593E74A934EB8672689BC8296EC9C563CA
      A905BC1E452699C45C4DE0EA69A2EBA649BE3BDBC6939DEBD656B7662323ABEF
      A5D3A95FE7F8E4FEB412ACC073134B26459F02DEF5899244730B7021899657DA
      F1E3846A72E3903ACCC2D6301929B6528653CA392185020D72F39680D65D2A6A
      4128C5096A14CC462C18240DEB70B72BD193F3F72941538E623FAB22F3AF9CD4
      F73BA9DB2B27F5A2FE33F8B2FACFFADACF67677BA200EDB06CA034D2D1CC77F2
      D984825CCE06A9B146DDDD6C9224248CB88ABD42B2D1AAC3D8ED97E623FFBA15
      04C1E7C94EAB9D3A0E6DB4FB06FBF1ABD3F8A0130ADA71D1CBB1FF771D4CF386
      6D962A9D5BEA36F6424735A3DC9E8E080B60524765CFA0521C7B95F6B3351BE2
      FADAD9D56D168F9D1F4F397AF19E0A2367538FFE3667F32D74A8C41446911DF3
      E32971DA2DFD9181F131BBF283267D62E2F312677D0D55AA7B9DD1E7AFA3D4C3
      6F855CADDB6EADAF494737489FB7A47E0E5E8750C3A1505EEA8F2AD4413C8670
      3785C106293A66A4C1EB38947280C63BF204198C5D5A9334A38604A6A7404354
      DBA664A59907D97E60655101E37DD66C6938FF6E0EF9B270B4C649984A13DB3C
      1EC7238C8BBAE5358DCB82B3314DAF475374C9E968DC69B2785E9A8CEA062DD5
      38D5B9A0EFCE02189ABA71774226F9503EE76CBA894AB4ED2A30964E5D157346
      25B59BA42DF9B69EFEE5B32CFA8D86CEBB5B4E19BC91BCCA6BC88E5191305984
      0B4C4497355F8293AAD9ACD7D72845CCD9205EF6DF10839B876A7248C8C359BE
      35FD28DDFCCA2FFF3AD3F9F49C40B1F84BEC23158772C356CACC62305BA99B35
      DD9E25BD442AC4B971244CCCD18C7399485395AB6AB624A6C15E58E04591933B
      AEA348BD3665ECFEEC4202C6BC5DC45BC626C5AB6E234E2AB14E6693858F6AFB
      649FCDC81242FEEF799A349D248EC040C7E41B8AD508BF8ED250ACCA95F5F749
      EB6F65FB2DDA7EC32FECFB664BC368996784D70C99B167F2688C8A59B33D3343
      3EDBABAFDE6E4C0BD1D61DAFA60BF9805C1188492AAC2B3A76D56CF05FB5A859
      498A4F498AF65667252B166485BB7CFF56B2E26B67C4D210C63A5BC9974A79EF
      F9484D39A467CBA2C46553349009D2F19878DE88335EACDFA666536B9C99B64C
      8F36D16B36814F1B5F2B2EFE00175F69FC77B8F8F2F4A53F8C8B7FD55A1FA7EA
      14D1852AC7BC18A537DC214253D8B66EC32EE222EF39C3A4C0E894C516903FAD
      D80D85B9D57412B2F6F4D3ACBFBA4EE330772E244CC5357D9986264E53A03D09
      67D4D29E0258C69F4ECEBDC8B8E7F326EBEEE01646A330792484DB487E170644
      67FC000606949E41259E1039F5560CF8D30C78156EBFC380DD2F9E4B6D98C136
      176F9EBCDBDBAE271AC6D7E378E6A68B04064C6C478F27D35B074F51B7751BE7
      47C33969A896E1BF3BDBAE6B631E3B5C1082A10383D544758C9A4AC815952A4B
      47AA11B4873C50134DFCBF6613C171B3328BC2E8C71DF96B25403E2D405A2B01
      B228403A5F5680E413AAFFAFB3AB53F2A84D93AA915657F51CA0ED2A076E4615
      4D9CBAB6BBBF7D50CBC146A3544D6D183B2308AFFA99672ABC569C897098865C
      1E963B915694A151B38152E3E9FF4D9D3D591E344C2131A7F42E424D35E6CCCC
      18CB7E1D8784E3C8083D359B17C1A29B9C65061662FF6189A95EB3D19611913A
      178594A3744800980C3AF27953E4D17865E582B78DA9CEA75B134554636CD7C2
      BCA72C3D866AA1F415EFBF3987059AC87F4337D99492704AD2ABD9E44DDBB53C
      4F83980B2F6CAD05CDFAE5D37C291F11ABF7CFF5B597169ACDCF335A8F46FB19
      C67A77017EF768A3B4F33906CB1CF4A5D7767D0DE34DAE3FCB78A93F5B92D790
      D1703E3D24A7739C5DA824FE0D36D546BBC98E3077931C609174029A42A937FD
      5EA42E6A591CE83300C6BE1EA766106FFF8FF98578DABFFF4FEF97104953A117
      2F8E623067C2F5A34E02A3389882D831F51726772387B06106E8AD66AB9B7C8E
      BAB3E3B79FB7E88C13A4A5F50E0CFBC96C6A008D594724F16EBC0DD6354EBD02
      C6B3801C26444B524343CD6DA957EB8B4FBF81F96F6DFDF20B7849C14A7EF905
      DA4AFECB2FEB6BB6AA24747663029B9B62AC8DFFE967B874BA8A2A0CFDFD320E
      8DF147BD3BA5BC4F05D3D416B9D66E06347A6985400E376A884958F88CBB7C7E
      BAB7671204B09B4564A5E81AA4A9CBA82E4A756B89A87827BED4A429DCC91A78
      FDEF065A01BF140552F5F3389AD9FCA4D5244DDE6C67E3347BB33D1ECF12932E
      3321F76F7EA9F5B4768426237F77BC7BFE063F5CE91F5D600CB3ABBDC0B393AA
      34D329E686759090DA70137BB3628D2052D3D1AC8EF56A32D57D1BE7D83D7EF7
      7F1D18CEE1A87E72D28CF574094A70A8098FB50455AFD675AC7CDBF7FAB65B5B
      9D557ACA1DE7B6F7A58B91A507626FF896DD2D63684F81C03E1869BD0045C185
      3E11F9EC0C663CE509386A4C57D1E505F2046141597CB4BAF15C9973DBC3A44D
      AA440C11FF91EB930CF6AFC0FA9A737F4C485CE0B1B56B5F6A26D273DF56FAF4
      64E9547460955C8C485064E312F379A3A22EDB6EE86959BF465A6BDDBA635DA6
      D32B7D9B572B2DCB72495373B9F1F22E91CFD39C90E0C0A9935D366E5266CE44
      BDBC37E7CF8F1A34F9229E62D7F28A1310CCCBBBF65EBFFC2A9BE12669A217C7
      8B89FF7EF7DECB8F384E7002A7753B7BEB6BD44FCA39BB8CA3A9011AE2466E65
      C324B2CDAFE20903F3A78C346F8E24AE83A9B041AA29CCA08C7AB6CF0253DB27
      B74291C9A9C92CC406E5230BA092CEAFA6142882C25EB7C5B8B31481EDB87AFC
      FD83DC89B1AC12E93BC5AB3531C2B568995E706F01BE22BCA50237B966ABA03F
      5209AFBE77EC761518884A5DAB7864C362F504A6905171EB09D3DB8F7CBE1710
      FB26FA8B7D12C59FF375C1B48D8F2977362855923B3BB19A57377AA51E537FDE
      2164B098A6918C6E9D238AA1D1C8B897D2289EF8A9A26E137B79C08DD0242354
      9A4A09F1D66C4ED5FC6983B2660F0CB95E8C821ACEA007456A945B70D26B6912
      9A1499D6E211AC632F3B532E2F214ECDC5CE02C4D1049D8D53E79534B85A7E19
      05435FD56C42F7C49D2B05E0F95BF2DC0882272385D808F00693F04F9B4DE7A7
      3483F93121808177597A9353B4667B34FDF3FB4EDD4E5DB12313F2DAC096A066
      2D697A3556D99561FB26D7E12D7781FB737B6BAB6B5DDCAAB8B4E9D0F4EC7717
      A9E3ABE0AA6653AD2428522BEB02DAEDA7D3835DC28349ADF337496F9ACEAB34
      7955E196359BCBDD7CFB0D5F633AC6F7D62484BAC24C62BBAB7686929982CD7D
      50E40525FC1548B7047C1FF24AFAD7E423027D94B2001CAD89745536DCF4369D
      650546431C1970C89ACD747D6DDE3FB7442A6CFC74FEDD69937D8C4DC6706D8A
      2F75A226B7D92C675A6D3A1FF4748FDA29ED4AAB69D3D2028B5224631FA9EB43
      AE0F7136A833EC154B98BFA7C94DD8AFE9FE4B9E3B4F76C3CE9637747D6D9A6F
      D2F0297E210D3A0E7E3CF8E06C5C8C525F8DF82B7C70B4E59C5F6A46897F457D
      A61C8D551150A79DEF29D831251C5293A6652A484C83C15B6BDC4AEA0D8379E0
      B64AF5489DD6CAB36BF5B7D30FBB98906FFDB9A973BAF71EC4C3C0EBA2FBD512
      0098C26C14A4AA36EE3B39D8752B73C1EA9F6CEF7C8FA3CF0E14CA7EAADD2428
      D2F6EEE47CB7E82E991649807E1ADE72A3B4BCE8C5882B8F9CA48614C5F338D5
      B894839B3B7B07077C2E581A5E487EA612B729C70F22838858AF59D0B9786320
      BA4D0C97275015F1C7EFCFCE2B3CD7D960D5FAD559CCF175A3DDBC32E29F1581
      28DA5C45481E112159D58FDD899074BF6C8444E71383626CBAA650DE18356694
      8E7F3A1FD76CC74C4CA0D37B4BED37F2A9A206D3505BA391C12684627391E93C
      E7ECEA40C202640D8F52D2E46DE3C2BA99C5765AFDB7A60BA3D49D15920E0282
      9A8E4C09519794DFDCD93F3FA46A88D034C49EAB024E34B783C5D749FD62CF52
      81404925CC5707945D9EB1F8CEFF31A3D8BF9F6153F5F4EE944D34EB2266AB4C
      DC1B749F85EF6184BE1CDAED96DE727EFE5F27F1F46C9A4E7EAD9D8F91EDE25D
      7F54B4479F831A95309DF439CD1983314867A3B06C607DCB0A116B9FA9E98620
      388C753BABAC60169891A63E86FBE6DC94C6B38141A52984D276A06EE618D554
      0A8F24EAB40C921A0FAB604AE07DD2959E5DFFE21E66052EB7F97B5D314626D2
      10B7BC81DDC9B67733BBF76A36F17B5C5B4DE7877D8E7E67E968C1CFB59DE774
      70C72A01F1664DFBB76F7D5A4CF9F5736A19D35238EFDF76FEBF536743273635
      E0378A6D145180FFD89C373FC894AAF36C4E0EF7CFEA59105EF873C6EC8948FD
      3CE534442A84195524DF5BE7F078F75D133FCF769BCEFB0F1FB6F9E719FD3C3F
      ABE7A466A6F5CFC10EACB9AA294119DA3AACC8AE1FCEBE3F31DA564D4F45C1A9
      4DF2378720B057D7D4823D561454E169399060C40C88F7D5742AA27A5470526C
      5B197622D4F994BCDA154BE295692474A93995B5223C5FBD76DB5EDF1B747ADE
      60AB45FFBD22592B8DD48BCEDE64B69BDC5E7910F9BBA048FF6DE7E0A7F2CCD5
      4E635AF0FD36C866FFE5176963E0F854BF9A376C72D6A2CBB7EEDE5E3337D3C4
      887B2759FFACE49AD1A1AA63C75CE364B4BCAEA2ED55591E888EB1346A58E06A
      26205CE1E4C3E96945B4E347369B1418F86A7A7991113E91E0A1ABEBFAD95573
      B359C2E30E3FECBD675A22954558C0DF0E8E77AAA7BEBEF369FC207D996D0CEE
      6F677BBB0DB0B0AC86066E591E22639770DAFC661C9DECFCBFE692C0CEAAEBD3
      63FC882B18913B7EC4DE97CEB436F853B067DF1C613F0E35B74D211BD7443167
      09E87CCBF921B74DD5A19448E340DAE054FA6998CC468A2228CABECEE2CAA1A8
      CB6E9F698258E2B965FA1FB338237C12C9ABE67AE090CB56C09CC2BA8D5C3649
      6199291A7C5FB52FED0321F246B745D1D72B325662491BE71010ED65CD26C7CE
      85ED0A1551DA14188796A41B49F8AADBA01BFF77369E30A46D5A681B228E5FE5
      36417F924E66132E58ABDBE8F71272D8BD318E3BAEB1806E249506261FB26E43
      3E482F848C297077ADB39B2CC6A8128A5D760EDFD56DB4EB6B3F7FDC058510EE
      F41436B8FE1868DB5D2923B714C591C9B4BBCCD2D9C525782D7D70626320380B
      978A0C754ECECDA76A3CE1FEA863B61E7D4DB9CBD16CC48D54C9EBEEE08448A5
      272B2D755B0D5B4D884BAF722B3F2A902A52AF43787DE4872821F2B79C136312
      E27FB0F4293B94C30AEC35AFE32C1783D40F6402990665843B757E28054DE481
      BD35A83D9B7FA44AF97B94C8DFAD839C5957F5DB9A6DE897D70EBF7053F4A36A
      63245241EA76E48EEE49E2DD283B7A65FA62463DEFF447EA0AC6902F9B759C46
      3536B3717EA07CE84221994E4DE77C87D2C30F30D477E9C7DA0DFECC10884944
      5001418C40B4B1A7C256C9490489AB54FEFC9EF93829796242803542A5D5F8DB
      88034A28AFDD344F4DBC23BF4DA6EAA373891339A25349C65256A4BC1BA5F59B
      E1DD04659EAFF8F622DFFEC2CD9C7F54B0BFB96B48FC1B15AF4D4DE117394719
      D7B06E87EB78C665DA1211F81A06BC2FBEC1B6DB6DE2478F7E0CE9C7C0D9A01F
      372A771A94E9C109EF34ABC6B7A3CF1DC679B062098B2CE10BF7F85B5FDBA122
      BB711AC6514C85598CCD329EA869ECC7A318B617CB6B3FC58F5D8D29C4CEDFF6
      D81EFBDB5EC7C20871BFD83C9D6554C7469935753B96E227A31ECF4734D4C2AE
      CC536796E462720B263CAB2B060AA2EC216CBC9DB59BD7BBDBA9DEA6713B239D
      5C608BA0DF6664197370B8E7397E3CCD57318847C420DCE12A06B1C09A3A5FB8
      A51CEF118E62D9A8DDBF05A38AC72AC17C092781515E7E89462169D7FFF5CBBF
      D2AF9442E1DC8550F8DD8807DFFDE7C9DEE9C1FED1F74EE3723A9DE46FDFBC29
      C6B215EAEB58250435B005E6F906FFBE39D7799786F57A1F53C85F7BBDFED0ED
      0F86BD86F34F1AF928CCF2D1F4A96B361BFD1244EE63B8FAEF1AE33F417C39F4
      2BA13EFA8D365E7F0495B207FBB6DF1AFC12A5E9D4FC1AC038FD48BFE8244C2E
      75A6F96EBA8582EC44B2FC3421B860F44B1E4D13FFEF9F4196D5EA00DB44104A
      BC8F1302E451B6C224D4414A04BD716AB269B74F0FB79BCED18F67FB9418B7EB
      36A9B4EDB876C6AE99D2DE3536DEB41E14DC01E782F242C9D9BCBF2B91718A2A
      8DE2DFE80A49A2ADE754DEDF975EC11589D6C92560BA05307CCDA6628A0D5A9E
      F316F3A1C4E694AAD3A9D811CA0C95843016443E7636E8978BCB349F6E72BCA1
      8822D4CF92B2585F830166B52B8896EC502185B3680889ED1ACDC6D042E32921
      9C406FC3C009805F9A48E6450EBAB311CE3822AD9C4B25559399866061EC057F
      76B14965A4B83E26044CB2D0C43C13846545991F755B20B3EB10BC6F1D5B0E7E
      C9E110158644B258B33C77FE76707A5024ED1BB479C2EE9150BDC41468EEEB6B
      69AEE56A6E11008100999B71ED50125F24B668D6A684ED9F1FD675455A581176
      8D566033B84881E13472D3AB017C2B0E4DA946BEE56C8FF2B4C93A4763F1DE06
      1938542B28ECA06ED33EAE04100D9233B95969ABB9C81962674AC9FB4CC9928B
      E16B30645299EB361773E6DD92A677D404DA668108C72958EB6B6C7912300C17
      1869D35ED0161685311977A4D9606377B58904F0DD0C0BC8044EF1C39CC0DE09
      6F85C8E39B71C4AC026BF79A3C5FB8FF6A356642B16D96E38516C29E1842E50E
      6995262A8786E53408B5B9E15CE95B48ADDA49718A605530742CBE561D8739C7
      E3FF50A7C92A52533F46F085FB80EE900B366385F5261E8D5876DBEC26ED9056
      FF119322A34AB29F48BA6772693CA53AE26BCDC8F52946796BAA1D7D7D1927B5
      E310466973BBA4B459481B53E022C8E15CEAAD4DEBCEBA0DDF9A296DB7CD5AA7
      01A93515C069E49C42D5A28895A0EB3324131B1CD04C4E0B10DC029D907D0323
      752B0E5CC9AB25854DF474FE3A4DA0AF1F319E373FB984D2FDDBCEC1A955CFE7
      97CE14E5D577F15A6FDA6D32F4CA25218AB7A528825F59E4174B6E6E75FD4669
      7A359B38E18C3D129C6D1C1A4AE2A2732AAA6638CB5992E9515C4711648D973E
      56E19D746830A9033FD8860E6481ED9AD4CC62EE3981E8D5742EA4C68B75E234
      0CDC8A38BC1AD8C391D50B6A68861484D9A653BDFD63B54C680EC4816BC47102
      D98B2411A42DE74CDC5EB45DA6CDA51AD9246B3E987486CBA6E5866A353BD520
      8CF2BAD2668B4EE88FECFA23740EB31CC2A4C8D8A2BFF6CE0EB9366CCB79A782
      AB0B76A29408EDA3781C1B1B8D3BDEE0DF02E8C22C03E71B6FD5AE62B1A08856
      9F0595380995F38F99CEA796E91A268FC1664A303BCC118E327541C57F52EF04
      CEEE6BDBFE075CF96182A965E6AE5D8C1E16638F9DA7D5EA0FD8E7A67E82904C
      0442818F0A398813753D6688BA2DE89E380C3F5064953CE2E46EAAB82DC806D2
      5144191FD73825C57121E79C3833A4CCBA6E4B53520AA934C74669A3B5115AB1
      B49053FBC7BFF247DBA6EE9AB27CAD4FB2CC0CDF7276E568906BBA692924E60A
      0E42A0887FD361B93C06E9477C22546357B7F5B1AB435EBA1FD318533DBF9D68
      03A50A9D893CB693898676BDE51CCA5C73391F7327E17FBC61F67D42A785E7BC
      32CF16CDB32FDC65BB545C3BA0E21F383A74C7E32C8291B24B0C376CDAC36925
      67428D840980867C71ACB6EE50BA6B24C64361F8F9B6F61DA282603DA712A528
      00C0792804985DBB78A13DEBAC089A76504667A2281AE7E008B68EC12D505006
      2EA84D9441330FB9A5999D29AD105FBE65431D61AA735EA39C2DDECB4A6E0F5D
      6813948C0CE2BFB07CE2FB4DC954C64A9A64C26F86B1ACF2F09671942FDCDAC8
      DA1BA43334487586392B54DB90B0959F7E04C3082ED34C7C037E3A254475C2E5
      04BBA8DBC157D7694C2817A2D213A459404018146AB77A0D5859EA701557A8FD
      D905B94DFED05CD8AF37556DB04A555B3CBD5F1876F327926953CA1FB0CD0F45
      B4C4E481A536AAD2C042C3A4A1FA161C5A062EB7CD474453A09E34EB6B69E1C2
      C26FF8568D9C23FD71C6D6C2D954AB311B40F9656A803EA11248DF4F955F39CA
      27CC611E88917C600EB3714DE19B4E0CDCF786E4DA58B7CA6681A74C0A9284C0
      C69059D6CA165D8866686BB9766152A5899F6689B37BB053CFC9360845C12841
      CEFE6E6359CE91712BD56C02E7347013392FAAD99706D17932160FB166B3D836
      E9EC7410C5995EE904840F8DC7FEFF388356AB6EDD6F39ACA0D9EF5BF44D0DD2
      111B1949685B54D85C287053CE04AF6907A3C63CF076019460BAC206316904A2
      F09B062407DB47BBD21581A78B5FF60B2ADC90064FF39D9D36B79CE364AE7987
      C1C090FEB31FA57C527AD2C4BFD5BBE153D17F762972272907DC67C784AD57FA
      D323F4A7FE4A7F5AD49FBE30DC9091913F98785F18AB51CA81166A566C1AB531
      905E7B6B50B3BD3B903C67FD26D426E5593BB3693430E9D1E4AAC854928FD434
      8672975473529B522D7CCBCC6C3C16A021302ACAFC399B66D27530B3494084E0
      639CBDD394AAC10D5864CDD6C3802981F98A447D533876A995608E298721B404
      DB7977C5B01EC1B07A2B86B5C8B0BE30028645AE39DE3DA7130D81CC2A5AE86C
      4CB374E653BA0DFB3977D54D723123E4309DD7CE0C2BFA52BD2F20FC09017B7B
      67CFA41A4A61A41F4F18CF992D17E37EDD670BB62C1BCDA8D5DD62545C90D08D
      450C65A5A89F58F248C9ED2FA386D2A0B59E803EDB26B784D1EE315EFAA592E4
      C840171CD2AE004040535DD4D5563D661EC3FBBA2BDEB7C8FBBE308A84611A30
      4CA85F02673450AFA5FD93DD33DB0D423847CD366EAEE1DCEE1E358532D918DB
      073BDF49EFE7C6AE96A26F3EBFE463072B6FD48D7157A54FA57B41CE807D99E6
      BE29066807D7B874A2A4C0103F8F05339898BCE5D7E41249B94091426A50B11D
      2956ACE7AC2BDC97CB283933C074F12CA6467BC9FC96A9535DDBE590F9D57662
      246D09B6AFB2338782237EC2E6CF86EDAE80093377F4363972CADD926DEA0C21
      6326A53B915B81268B1E82DACC9DE1F0ACE1378E738EA597AD0CEB365C01B1BE
      B76AF4EC64EFA09E8D074EB85CE4B5CFE010A52F29BF85C6251D311BD2AA596A
      501A5241B9C1B1C74A63F4AA0243ED8AA851C434AD1B836C989A389945DD06B7
      0DDE75FB9B760ED20B1920F922B30CE6F0E8B6EC54FA02A3761F3B6A1EA3C2F5
      C5A8791E91EBA49FD479DA9EF77CA5876F7EACD6138FAE47CB0BB4F8317F4C85
      D6D56D168F8BBEBCA3F425E21C2FB64FC7FE28BE2667FAE92CA17C7739CB2759
      4AA142EA9977F178D88C7B160BD3FD1DB0196FDFBCB9B9B9D94A28A209E33167
      288AD48CFA0D7DF2C66B0F7A9D3F0425E32903FAE73F612EAF403156D6D3EFDF
      8F4309E798E6EC9CBC963A6944A0D5DC13832402AB7EA4CB358EC9FBDB20355F
      04F23B2A15A258D79B4C2B3CDDA7E2AF4249C4909ACE99FE07E340341DE39CE6
      44F2A6A3A7C156DD24F5FBD98850B027A4805C51B1BA789432C73AD4D83C3B5F
      B94A1EE12AF156AE92C5C3FEC5D1F516225B94ECEBC038A0965F20F911379A24
      03C2A4026D4D3F72E290B48B65D8F31436FCD9192308B1896F55F19AEDF53C9E
      CE3515BB70066EA57514A8F5AF3F9C9DD773E0DC005D7AA8F1D127A489D9841D
      09BE26008D22F5A202445ACFA96CB317689C7292F9485FA8E0D6393DDA3E344E
      76F294FCC55098810D30DF4817237212E1E721FDFC696FFBA4C9FE310899FDB3
      9AE656590CE6E5E32FBC293CC7797FCA2CC955A4C50336B92D8BD1AC85CB8041
      C469E57C6ED6AE2E8D9A53FDEA1CA5453FDE347276F7B70F1C2ABD9BD4CE7D52
      3440103E71B7BD1C37E15117613A1A115C111EE00499CA297398FAD6985449DB
      0ABBD0A2760F76EA3657AA11741A65217FC3B4B12190552A67360A9EE9C6C38E
      CA281D91648823933E4ABA21A97F75E3F5454E1295A043B8DE96C20C5BF8B1E7
      19B752DDB6E43BACAFB3737E7AC0AA26CB5D513D4DE52221E1120146A552BA52
      3C1FA17876568AE782E2E97D61EC5423180FAB4D482D9A0251B8B8B1AA7E47EC
      25B72CCDDFAE3C8F77F6B20E9EC703E20BA2E4E44D679FD82B4CFD8986A0ACD3
      8661786FE747D774BEA39EC6272A9BE2F7F72A78A934DB171BF3A90AF45BE73B
      156718E0DEADAEE5C2EE0828B9CE6A35AA533D52B5DB4FCA3C74A82F4EAD46F5
      BDB5B5D2E4ADB39D8DD30CF689561372CD6D8FC769938EF64A90D6509092C9F2
      E6FDF1FA1A4CAD9FD85BA3334A9120B5F187DD53D1D1A55E9B3A1DD93EC610A8
      79AE2E44A7140C1FB06F757D28F01735DBEA054FD51DD32CDF5A2906B5540CD6
      D7DE9DEC9E736F199BB1790B22B4D9E8A1F8E1C496E6C240C6F6857D964C8532
      E3880B67A6CE4851B22A744067A3CCE292A7B16D440F7A8900C24B2A1B3048A6
      31A1A908E25975D4F439A61BEA8F9FDF8DF76253220FA9A30C20CC3C8A5B3933
      9E54ED469D4F9976EE6E047F51BF41176E8C822733BC4672C57EBFDDF81AE39E
      A659DD42662B996C420DD0DADFFFCD995CA689A60CF21B96C22672226E429395
      55C976AC9BD4BD9B839FCF6794F1D82910C4476C43A63706371E31C70F0CEA35
      3766C7A57F91EB4AB839C3491806713A13BD047C9132EC23EAD25EBFAE973620
      231D7D73EA58F25A2782E2CF105A04A3895F08F8F16CEFAFE24DDDA07204820C
      33BDC2AD6358A04F15A54806BAAE532D1891641472CE5D0D5111255773E7BB6D
      9BE2C81468733605E5E3528DA81515684D2AF728E4B24BE6FF2168ED96FCF4F5
      9CD5AEED13C1C113134C69CA1153D2FEC3C03ACD9D4E4E5435F1A5BA4DEC28AD
      3470E75137E8905C916CBE211824FA4BE028319546DD866F23279CB78DD1489D
      0D953EDA8AF13861D438CA770E4BF8FEBA8C7F7DCD24D4BE8F47DC0D16277BC7
      C4AD24ED93607CB96739F642BCE9B25791DC90435FA50A52D93BDA2CEE54EC1C
      7F4F39DF53590073AD2C419341ADA4344BD0460CF015F77FF9184F2D42D645A6
      C64DC120B9F33263C5D2BB745643D060B39C15D4006B5AD7F41C9E09DA9B7106
      B06E59F52A74DE704E39EDFFFF1BA5179C01329BA40CF15DBB5E23A2A58C6342
      1BA77A41264D265DC8DE5753E9D96C429A12CDB4B58259192C2C688DAD51E9C3
      5274E7118C1B7A3647DFE4E15C62C9F9E7B886DFC14FA417359DC96CCAF1D2A4
      1A4FCDD2746AE3A9A218DA2FB1AE3A984DF969AC3AE0E11B3671760B5F361D6C
      C88FF29B9E062B50AA47C500DD550C70D14CFAD2CD442455FD4C0A0AEAC649A8
      E54689712B09043AABDB28A58E047A87CF907C0C8044E58EB47553C2A921E4C8
      34AB5D5B825358C4631FBC6F92E6A6A3029826F933346508112F1C2B4665AEA3
      EA54D6A34B8E86C116674DF0EC328EA67FDEF5473BA338B8AADBC87FDE1E8D7E
      757ECA6E35751BBE945E7B148137486F1BFF5C3CE52E9FF2C531798F1DD4BF6E
      E97C7D6DB2C52FBAF3F0DFCB423689DE8D0E298635B754A825D1FCBC7D70F0AB
      F3FEE0EC9CCB571D1A952451CDFB4FEB39EEBDDDFD5D4731DC795E827C151EEA
      DA0D5A1C17D5FA023EA614D334F432AA7C5782E328434104066F79EBD402E4D4
      769EAF476F6D6C84BAA38F8999929EE6E498497029A0722943990A14DBDC6C6B
      D912BD524D4DC649CC4D03CDD689D38C7D3795BCF43794BCCEB9EB6CA398FC45
      4D188D51C1E06872B59B2A7B7824D47E9886DF4365DD3F3CDEB54E2C8B3649A6
      E4B5CA18B4A4ECF151CFC99C1CECBAF3A5FF779AFD30EB86D6029AADE31CDE70
      E2B2F43F90F85015F99B9B5D45D465A4869D577FB6D6A2F5DAA737949673194F
      2C494985073680AA0A6A3CFCB324BDB9756EB46288B16A1A76FCB11A0BDBCEA6
      97E334CD56B6F0636CE1F670650B2FDAC25FB89F5E5C66AC2FA6B5107D8BF5C9
      810A8E53105A97C9175811FC23087E05507787E0BF788792F7D4436A363DFA91
      89994A49C62ABB32CDB72C6E5B1C39E16C025B8383C8523384D3704D0D8408CB
      99F3C76BB6B7D26C8DAB82C43F40DDFFB88263EA10BC89E91A555334ED06959C
      11279202E7BC51A09D5EA6B35158D1E3A40B126F919EAA78245DEF05DA9D6C2D
      CE0258B1A747B0A71586DC1DF6F485DB9DACAF850C93E904E4C5A3AA316511D8
      4D1CC7E6CE32D14B03D0CB549AA47205D7DF67E389414950D37A422EDD615481
      6D0F3BD1D9956553942841F3D84B28367692C649DD80D7C4483B63238DB163D8
      54964FFF6C3E3FA119EDC98CB89F1B651910F2987218F133A46666ECF6A10618
      3653F07A7DCD024BD12369DF8B22494EF5A9D94A501EC81CD152825506ADF1B6
      5ADCA9998DDF38E944937A494E12768D39EA42C575AB195F5F13328D93D78C1B
      68C74A9D1B6D4FC180AC71E9439C1276FFD4D201F9C1585B8889F1D26428E1EC
      8262D72AA0AAB21B698CA2E5BB84600547D4F254F0FD6BA75A1C32FEACA4C0F3
      E4E4835303464B0257F25B8DCF88007F7F9264FFB716CC5B7FC4A2C5046EAD46
      4D6B59F03A04B87305FAFA0981ED6E75B756F5A477E4F5176E70447EAE9CBAF3
      E96CBA0CF730C0E7144FBCEB375D11FA0384DE5E11FA22A17FE14E14D47A1DC4
      FED68946A9F4AC9E9046C6824F65712E1D1CD6D748BE8F281BAF11CD7EFBEDB6
      411D29A997A4A20649398580E834504AECC283305B5F6702936C1E4AA62B2538
      E97FCCD488B1732032D3D9C5A53442B649904631E61EDA3688AF82609611BE0B
      FE36CAC986E7F8B753BDB9F862E9A8B9851972BA14E7F911483B15FE049223CE
      79527C5B2E6AB5B149A901A9199D0C196627FB11F8B3D5497FC4496FFDC7175A
      A5E549484F5EA54E6FFE48156B8445E1357A84C9D738D542FDC6D49310E3D6D6
      56E30F5C9B2FDA7A757D8DAAB8491566303F131B96E2BA985BA3C71712339E66
      5AB3E9FBFADF9DFB96CDACDAD2AFE57C8B8F894D2EFB251885C543F235799AB8
      DDA031A3A594427AF152FBBD5B8EC365715869EEC07584635A3FE20B81A94A0F
      8BE6BAF48C4D4A44E6BF9883710D87237F49231B763E3247B2B360F649799EB9
      8E66239BC5CCC6C518DB1953CB30E8DF338A4C4F6DF63AC464C21D734463B73D
      0F67D359A69B8C8CAD4618C98DE9C0A84637EA3627BBE69AA6A48C7FB368DAB8
      A1B72EB61CC9F67F7FDC3911CC278CD079776B5A13D357092EA57519A9C9842F
      354B6B22E2653DA5196FD3B1C529637545B6436692BE93A2ED1C6C487E3C990D
      B4453603A4FA78B2A6E915F40C31D5A4DF1EE650291659CC01F2EF235B7F0E31
      F53127F8A7EDD3A3FDA30F6F5F3CCD080B5CB84668052BB4AA380F3AE78590E5
      14CAE6953419F317D2E999459300F793E9B6BE26A9EC58DA2B2165E924290FE1
      F59FE54C4C716E3F25D7385B7C4587132640BA3BD4B0E643B5B8AB89168CCA4B
      D37F7ACC878D3225F8485063C1E30E4B0143FE04CB2BF42067B3683D98CF9F19
      1EBC925C7C8BDC02698F334862BE4838DC067D37E75B8F129DB0F79E16241E59
      E87B46131DA98CF84118722581BA81286F30D03A2F5951C16E32ADA911D56C42
      BF791FDE09B56533C1969F2514E1564ECFF33137FB6A6CD84F9C1CB652FF3FAD
      1474B65ACEDEDF4EF64EF70FF78ECEB70F56B6C0A22DF0859B3CADAFC97131E2
      95546C725F5172849471DC0926378DF26F7A528C89718C53D328754EF69AA6F3
      04BC1482E78B40C4C16DC89F01973A1966D4E0C3A9E894DD72960CAE0E881365
      3A9C05B6146A9252457F4C358F107ADA64FE5EEBA215706387B1FCC9D1BAC7A5
      6C8DA26B51DD5254B8531E8B72F63E2615FE82C35E05A828A4EE38CDA716CECA
      F42F3136D958ABA4A2333093CBB5B62D6D736A61002E570D8B1617877148652D
      FCC52D179DE47A14391B943C4D7B973865E5483E6E3A3B6765452E27D1190BCA
      7A897D61A8981F21FEE94DC8194E522D8027311BD31E5098BADD2153462F188F
      56A4305F7F9DA402558A09D081186B915FFC5C567FAA0FA7E344EB956B335BA9
      13CE45EB839CC5E25C693D91D5A7E7E69B73EFA662A5CACB2F63A2FEEAEBF9ED
      E77363372D69C417FE9A2E5F5F9B9C7C38DD155555AB6C4490CFB65358CD8891
      2A158AA958A4D0386435231EBF18FAD14B0EF9DDEC8232B8D8872F16BE093207
      97691CD8DC4E5F4BDDAE8569103DA46653595F3B07D1FC9048911F734253AB5B
      6E8A39D2A2609D5060018AD1CE77A7CECF2DFEAFEDFD4AE4B9272564278A7944
      A9149DE14EF3DD19574860DD8E27CC3FB95AE244ADAFD12D4653C28BB69C0FB1
      B8698C56379197DA183E159F73662CCE85AC72D9F3B3EA5829222C92B3290A24
      EF8DAD56BB49B3116E62A7501C950EA1099D15C170A9F4B1A6D591A45C296696
      820F0EC3150C080FE2684668E58255A1EB26041ED8F7F5B5EACE3393237F5AB1
      9C9CFB4FA25A32EA595AD8456A0A0F1CC5575213D810F460E7D57E55F24AE0E7
      158C6B9232A5A474C2B47EB9DC7246CA020D73D869492809E82677AAD176F637
      C2ACA278B3311D6419A175113B0B3844677014985ACDA5A1361FD2CAB2352514
      178C28F55D4C5F7E31E84D68B552AB7CA942213E2E622ECB305606C2BD0682BB
      0A84DDB509BE70FB8E0FE46B38B305CC1B1F0ECFCE37E5F8D069E3BA79E24130
      1D88A9E7E9E89A7BBA5171452A95D2D40BB9C9FE3591B7756326DB26B66FA4C3
      A9BE1015AE00FCE05C5AE1B36CF988E1A29CF71438909B5787FB1187FB0F0D09
      7C61B7F779D541657CC65CB332567F37AD1AAD8455A3787A6B9CB715D3DB6795
      960258263D23CE97B44F5F11DE2708AFBDB52AD4BF2353BE7097184134B1CEEF
      28CEC844273771197E85B8805EC6CA2F2BA635DBC27206CA71C906991F3DA78F
      A911BB68A8D19C22C4F19A4D81ACFCA2EE96D2E12FD2ECD6697C1787300BC83A
      3E4C43E70325C8376C5F0A28D1BE36003A2CDF6B362586AAB57D413003AB7D38
      E0B847A4C708B9919BEA424F2B8E00FA2C91A00A884D718167D9B9A866B32CC0
      D3267446A503CA89826DFF218B6B97FDBF8D75E4005F6396101057D2B06E4832
      A4D8BD20791A267F96824F46A564F4D59A4D677DED6CD1E8DCE01E76DC4523E6
      2899D11C6153E757F1A4496E475368D274B6B6364D9270508D8BB36BA6715618
      9B8D66F1D7519A68F18737F6C92D3C758A11346AB6388AFB39D3D46612BC960C
      525B6563139ED3288A0372DB9B12EA9ACD425C896F2B422A60B67E93A51487B4
      F8615086CA821B93EE5A00ED8A3320CEE88892C7CA3AA695258E0D4E379095D9
      E4DD358E77A32A0A81F0D36AB63C5024744615E3D31BADAECA6884A6F06E9C8F
      8DAC90E87E05D92118D14785FBBD66B362C911153B1EDF8951348A3694E255E3
      F6749938C31BCE06483F77FE3123FFA9727C495753D2B77D7D8D201FC0D2022D
      B891A42B6C6E39DB8CD8CADEA822801DE2B09BFE5B181579EACCEB42E7DD6D63
      AE1B9E7538551A29DB84FCB2463E2BEF2750EB2227A0A6A5FE8725B32097AF9A
      4C46149C3238D61281B789B7419C05B331A95641FDFC938BDE472EF7C9D21BEB
      6360BDDBC15321DFCACC27F6AA500D0521EA735641E13BBFC9CBA202CE84B48E
      07C167E2842101E818EB71BAE59CA5450A0EC955ADF298ED461596BDCC33C74F
      D3ABBA9D448A24DC52EEE785B3FFEA9ACB642E5276A82A9F78EE5F5605059FB4
      785759D68B166FF70B2378CF7B5189B9499D4C58C98BC041ADD9B6BDB731202E
      70232DE58402DE9C60B19326A1C11360485D489490A723F552B533770B6B3677
      3658331576C29C74445D50EB867A5FFADC2B891F772D0A515AA04352C8D6E4E1
      BD91826BCEC653CED654E71E0998028694B35E8B70704EB439210392DBEF72D3
      C9DC0479CB1EBD1B467BB7605714709CA8DCF8F94DA95C811355B7C53CB1AA5C
      C639880C385E2DEBA175136F4EB93606FEBAF4EA5C403B5B099FF22DFF090DE3
      7B522F480AF15FDB20C15D02D7FE761CFD9836A929AC5AD129B8B94C4140462E
      938F6D37859E0A0D7D0BEC47ABE99F9CEFA0E251C3CD5B93893B9FAD750F5A39
      4907ABE59A4C5D4932FF58E626A93BB9D0BF176CF1F53EED2F4D667FCCFBFA39
      32A1273687AB5994E970B191C130BC6435583B0D9EA8293E2D402488E1CC924B
      C96E8FB0DC97E2BF3C3630ABF4BD1563F9D63387DF7787C36167B06CF43605FD
      5F7FA15416CD5D6DBB2DCF6F755A5EDB6BB55A3DFC6F2059392E685D0F43DD8A
      FC288A4CA64ED072F9DF8EFCDDF5BD4E2FEAE9BED7EBD2CF6ED4F5FAC37EABD7
      ED77BAA1ABFB835ED80B54306C07BEA7834EA7D56EE1A2BE378882414777DDD0
      83241806BE8B970FDCAE1E0EDCA03FD0415FB9FD20680583E1D0F5DABD60180E
      7C57F5BB5D0CA6EF05A1DBF53C570DDC56BBD70BDC201C763A517FA83BBEEEF4
      5D3F6C47ADBEDF0D3AC3C130507D4FA928723DD7C56BB4DFF6BD7E3754DD30EA
      F4BD281CAA707DADDB1B0C07EDB66A0F3A41AFADBAAD6838883C5FF9DA0FDC41
      A73FE80F5A1E1E36545D5775FBBEEE618E1887EF76C2811EB6FA6E3B1AB69417
      BA91EA0C5A6EE077BAFD9EDB1BB4A210CBA98310436F87417BA07D3CA5DD19E8
      4E30F43A615F775B1DBFB7BEE6B7DA6177D009B5D6DD688865F0B43B6CF91843
      27EAF43CAD024F799DD660D0F13B416B8885D3811A44430F6BD3EE616EF8D31F
      BAFDA8EB6AE5B9788B6A0761771860A5A2617BE8B7F4A0AB7B5D6C4BBBD35583
      50BBADC86DF983A0ED061DBFB5BE468BDD8D82A80735B38D17E89E1F75FCA11E
      0C317C3FEC7587BDC00F42CCD77707BA1F747A5D1D0418463B8ADA5EAF15753B
      911EB43B612708300CBF1F09AD44443DA09787E80CBB8135507D3C563E6C41DB
      6EF32FBEA1B4A8EF82C6827EC78D4057E6F7011152D4534459187F5F4783AE1F
      6219DBFD10EB8D99B54155D8894875872DAF43DBD30FB1216D77D08F7A03D76D
      FB212842E3A717ADAF05D8D696F27DAC33965B47515F0D3B61A4951EF8D150B7
      879EA6D5E90D9552AD5ED0D1AE07C20BFCDE40B7FBBD4E08E28C40C1C3415779
      AAEF765B180E88A735E8E1BD78874F041C745B615B75B04C61A7DDF655D71BF8
      BD4E6BD86DBBD885683008871E5DE52AEDB93D2F6C63875BA18B017543BFE3F5
      5CD7EB47AA3F6CF7DBDD28EC83F20634348D35C3C9E844DD760F07ABDFE9632A
      7A10A941308C22500DD6280886DA8B8236EE8FDC40773D6C4A0F4766E879410F
      5FF53002D5C6B98A74A7DBF143D0F4A0D7552AF4DA3A6CF95D1F1417F6A250F6
      E6313BDBF3FBC361AFDD1B188E31500527E1FFC039F0067089AE1BC9EFEB6BD5
      BFE8772FC40334FED7075F712D57C164022F6C61EF5DE22AD8D37EA8DAFDFEB0
      056E80CDF041A65EB787431FF84AFB7E8491799D61D0565E1BFC052B3A8C40D7
      3881BA33E874FA810E41C73832FEFA1AE6835FB0910158673850BD2E588E1E0C
      88A8FBE037AA8F7D1B84CA1BB4036C54D00B349ED9C601D3C3FEA08D15F7BD01
      0E5A1879439065A78BB1815580064119A1DF0D43B715F6FC2E5855D76D6BEC45
      187635CEAF074201ABC308FADDBE1E6037C1CD4165F81213C186B6DCCEE029EB
      EFE976E4B5C23E53367DE5B77907DABDFBD65F7E5F5F2BFFEAB4ED9AEB001C25
      1AD069E9B53D5F132175A2D6200CC1DC7CBFA73DBCCDF783A03DEC695C3FF431
      532FF03CEDA981EEE10CF4B067FD1E58194E671F9C1573F2E8A8B8411BFF861D
      5CDE01470C23D001CE094E195E8E331C61B97C1C86DEB0DB097018C316EEED74
      874330F4A01F8610012E789D8BD3D7EE82BBEA08CF18828785E02A51107A8361
      5F4561D08AD4B0DF1D78D8732C1AA87B38ECBBBA33C411EE2A1CC7B63FECF4B0
      B3986044A7B1AF7084550F02A71D809A3A9ED71D0EBC2151930B6E8BE184612B
      EA44FE6010F47BFD01E444A7170CB0DF43E2D02DD56B87FD564787BE0B3E3DC4
      1B5A81EA609DDC2196AF3588F410EC06830151BA5A777AC37EBB8D2B7A58D636
      E820747B6E88CF940ABAED16E4287805B8963770896F0DC136DA74BC7CB70512
      05E7C2A640BAB5143D0627DD0BC0CA825E3FD4906E3DBF8DD58400D12E4488E7
      411C0EFA380F90E21878A7D70B87831EC4EE40B7C0C63ADAEFBB908D03050542
      F7A38EA7C36EAF0B52D28176494EB96E08D13E80840CA39EABC07887DD7E1081
      5F41D4436C46781DE885D86604763B044FD43888C3B00B6501620E2B883B0390
      3AB629EC29B00A15D19C5A1DAFAD4010AADB7161C3F82A88706C86FD7EA7A3A0
      81805EA2B60249839086D02070C63AAE1F69975624E8426645831E89ECA1872D
      F7F129C4820EA27E1F7B08C1E5F960CC2AEA437569E160415DC06CB013443E41
      17AA0B4E39642444481F2B3B8486820FC00ADDC160D8D2244006BADB57613408
      707E756FD86A0D89BF7BD8FFA083DBC1E7415458CA4177E0423A0D404EBE0761
      D4038181B47BD82F3090A0AF71F87108BD21960202DF859213F5888AC008BAAD
      A0DBD10A12A03D585F6B77309208DB8985F571BC06AA4B7A066DCA500F3B4388
      82011E1F75FBA028172B0EF60DD9076E3D70DB7D3007226B9CB5768455C222F5
      88E1838A318616ED87DBEA455D1D61E5C0C3B004DAD7903C03EC86D787E80BD6
      D73A018967085F08FFD00331837F0DA0A7A9614F455D08148C3DD2386C4A0D23
      9049843308D61AE16688200F9A6114689C943E8825F4E996A11AB4C168DD2EC9
      493C340A753088DA7809FFD5811E841F105C10165D9C051C1EC85DA8A23808D8
      19B71B0620821007A44D4A2056AA35E87B587770608C390467865C009D43BD83
      ECC4227890B5410075A005A1DEC5653D9F26DA6A7B6DD25A41CE10ADE0992D68
      4510C9A490861816F4AE08CC0A743008A00F056D289A7836980A18E82000A3EF
      0DFC01340E1FDB0D250B63817A37006163F810B8ED2EA444187A583BA8BD1E54
      82C8C5E10117038F6A41351E82A97483484109EC81FB900637D0501F070A0F0A
      5C08A63674B1C0033F18F82DE8A5FE00DCB90F01E3B614B45C17DA50E042B2E0
      9A1EEEC17642D4637401E6AEBA0ADA413804EBC1E6BBD0C1DB185A007EDA06DF
      1B405276DBC30EC925358070E97BAE1712131DE00C4281ED803E02F06A4C22EC
      0CC11349CD058770070AEF0243EDD383BDC085D20201894F7110556B88ADC0AE
      83E6415D7DACD2B083B179D0DF3A03909AAB888982E8C0DFA06841FDED8603AF
      A370E02145C296C695983398960B8E050D14E20EAA320435F483764406031427
      4DE799C99D8E0E3419FC0FF48E31434080E585D0065A7D68A7A117629CE1C0C5
      C9F48691D2A49878E04EDD2EAC031FA2125A2C28A3031D512BE2663D303B6873
      60D450DFA0860F5B6D8DE7C11AC559C00AB515E4B28F4D82EE08EE885FC183C1
      E1223060F0B22EC8C1EBE2547A74D4201B7066420D8A0F7A51D051D8461F74AE
      DD0E5856047903EAC0B031789CD2D0EF75FD0ECE06589ED638306E2FC4D18AC8
      F220A2893002AD5BF80B7A3398B3705FF06E3068DDC524200E21B3A26104BD08
      03EA0778761BCCC6F5F13C9C1D4FF5FAD8B31664DE10EA3A09042885605D2D5F
      B7541FC643A7D786F61EC2F201DD8079E1B4E1B991DBEEE000B4FA3D7024EC9D
      0F6E0D3A1E42CC6077716C3B74252E052BC240F1C45EA4A0B60D3A0A6F832984
      FD0B951EF6C0C1217B87B0E8C03E607845307E7C92DA601850B87000211E41B7
      5D9F8CA63E5493A18BC9410BC549E9B73CC86F48A6D01F42F7C1E2747080BC56
      40DA130E13782C346488117027583238F1904B60F220C516D406AC3CDEEE8362
      C32E74222255B05C30185859644D92E9044DA60FE372084DAE0D9EAFBA9837E6
      312489E4874100CD3CD064B541D581C2D3EBB57AAADD0589420D00E3EE92520A
      9D08321932140C4041B6E3BC773B50D1BB389F3890207F68451832148D1E08D0
      F35A3D68A75DC81D58A150B60721360E76233EED423081CD4394439CE2AC4192
      E3319D2E4610C18A85728C2B61D90D14B424CC102B85C5C3F0A10A6041948FB1
      D15D60833DE8507DBC0E04095E0F49A015B6B30DA140D6401FA72A009BF67A38
      ACBA17458308F206662EFE823C854583D5C5EAB9C38E82221E92DD08AA806E14
      304386B283558699089EE94155557436DD2E9D9E608083D4836ED0C15641DE68
      9840D81B7CA57B385350E4C097BAFDB0A38849C2B08385D327B251433C760031
      42DA751FFA38C811FCB60FE3BD4F3A0676812C5AB01A928038FD2E0C66853141
      6A74DA1E9EABA17FB843B0D51E941508703063283938DE30CEA0500EB05758E2
      61E4F603183F1EE472BB3D0C5B5874327521CE30169AB3EE42CE82A50CBB0116
      0AAA0696BB15B43002701177087514DBDCEE7A1D0F963C6C6C6C11F6053A592F
      50A4A3C1260B71CEA1EB81D2C83A07CB0F219268DD3D9876B033869D0E6C011F
      F24EB9202D5827605260EE7EBB05850532BE0B5614621FFC3E8E067928B0641E
      ACB690B49716D8F2308265D405B7C3C8C05354DB87B50ABD81F843CB0F5CE84A
      9EEB430984B40AFB7DA8CB60CEB079C171B0654372E190B6E2F7C120DB205F48
      1AC819F68CC022C1FAC392824588C9612F319088264E7A225E090102BBB2170E
      A0BBC25AF27035F41B174A0376A0E7C1A06D07581EF04068C9D021FA7DF00F7C
      D0C3DE43BD0960A57641BF30C920F8B12F38E590AF9A86093D0E4648BB3F0C78
      FEA10F79449E2EAC4148222E0425820907E0E63009C02540B11869D06EC1DEF1
      5B1126EE0EFBE0CD1D4D26206951906EA1C60186CA41670D362F94A3DE106210
      B483F3078DCDD75D9889505BC9E940CB3D24D2D6E0DED836D84E746860F7841E
      8D00748009F62018B0632AC25E40A180DA032D0D4C188B3F0C95EA461AACA7A3
      F0E43ECE17D9D5A02218F858724805059DA9472B8C3DEA8271F8E04B7D1C5198
      F1F80C4C06340C6AC0FC49C8802C41503DB0D9008A147460D88DD06B2061711F
      541E88258C006BF8586BB105A6356C0D69B462A5FB6269BAFD87ADC5D23B03D9
      F849CB7DDE7FC3363C6925381838D16E9FDC25510F1CC45764F1809EC2C10017
      E1E890A1A4BD0E0C4332906016B7618B843013C9A21940BD022B033FD0C32194
      5B7FD8870E3884728643156A30269C655003A4112E806E3F848D01393580D609
      1D10863824C060180E3B10053E96660006D0037FD5611B2ACC1006AF3BF0C820
      F360FAE06D1DA8E17D1C3A1702152A38741468E55E041D09070A06A68236054B
      C7735DD55150E361BBF92184170C119C5AF03672CB41DD859E0A2AEE610320DF
      2145DA187E172605796DB00CD0C306C31EE8136212F6173618EA2A58095446E2
      518ADC0F018E1994394527DD0B60B174414EA070A83DB27373BB0FD9EE865477
      F9748FEF43FF55BDC1D0D2EEF5077F6A0CE40D7CC817B8ECBF4E4BAE99A7C492
      D23EF5CE4FF9A996FD87A3E23E742AAA3E94E527E153A3FA94F766D97F9049C5
      A8B00B4BC6B5CCB3F3A9917C8A332C1D098EEF43EB53F5E93E9E67F048BBAD72
      05BAF2BFAEF18A05414BD9AFFEB9BE46C18E201DA5591E50C8636C4081605546
      E6C9E0D3F4A67E07AC15D40B9BCAA57581F9E7C22AC601EE11557BF816A6257D
      DB85B8F7607576067405EC7D8F474C3F037A02D61557F58744F57816D47AE89D
      8A220B6003E0D57D980F64C540A768C91870563AF88EEC3918007D0FFFD78286
      15B9E4A4E89895C199877114F5794CE6BE5E8FD690BEF3CCB72E710AD8592E3E
      EBCB98799650E43A3825300D23BABE37A413CA33C41D1D7933D41ACC9CE6E441
      B592CFBC9E2F9FF1756E719D5B5CE716D7F16778368D99E341E619739F94D730
      75D267EE9DABEE3EA973E79ACE9D6BBC3BD77877AEE9DEB9A67BE79ADE9D6B7A
      7CCD002B4E2BEACB3ED9BFF83BEC442FF0E6AF58F80CD781160C4D52164732CD
      A7B7239DFF32CAC37C1A8FD5C74EBF4B7F8CD2E04A87A18E5AFC951EC71228B4
      9F480C9152B9ED27FF90FC4EFBE7248BD32C9EDEE2EFE1F0BFCA474A4B47A772
      47DBA95EDF72CA6B5BCE110302FFE5DEAB8773575F6AC94A68FF657D6D7ED872
      5739E8F6FD0358FE48F72F2FFCC0CE4B3FD07BF949775F7A8CBD977E60FFE527
      3D78E9310E1FF5407B578C23F6F1D1143C7FD7E38874FE9EC7D1E1FC3DDE33EE
      E93E6B468F2398F97BFACFB8E7719B3E7FCFF09133B2D4D199278F691A609B7F
      E7031EB7E30F3CA0F3FB27F1386A78E0018F63330F3CA0F7FB27F138A279E001
      8FA3A0071EF034362182D1D94F0893E489472B4AD369924E253DFE496F5509EE
      33F8A34FBD97D8A1CE9E740B0D14B73C877118E6FB7C5EDEE9CE3D35509C20F5
      A4E14B0BF93472A2F86296E9FC8913D1C9B51EA593028DF149EF2E6ECEF47496
      3D6DDC057D14E530CF2592F2014F9B3A57664869FF935E3D5117CFBA0F7AEDEF
      98B0BD9B8FC4D3265A90889A4D2F89EE62FDB47D1EAB204B9F4695A97AD2E9B0
      F71DC4F9536747B738EF66A3917E1AABE0FB8E9EBE8D7CDFD39420BEE5B14270
      EEA6A729417CCBE304DD92D57BCEA4CC9DCF9A9BB9F7195334773E63A6B2DFCF
      99A9B9F3593335F73E63A6E6CEEEFDC6697BDE963D8FA7A3A731969D514A1590
      4F9CD7597C912802B87E924632FF8C5DD3A69AEA572E3235B974DEA7C9D30EF1
      BB34BC75CE9FAA2514773D4FB5E19D2108F538993D6DADE7EE7C0E1516F73ECD
      A29ABFF7B146FCF2BB9F76EA0E4D03B5EF4AC56C39192F90D7CC9F3E9992CFD4
      68263AC11327B8ABA64F7B534940EF1927C590D1EF7FC41369E2883482EF8C9C
      7DDA9CCBF73FED95E57D4F23C1C533F7ECD79ADB9FCA88DFD12F4F6715DFDD12
      C6589C5C3DE9AEF729011EEA70FEEEA584EFBAF3343C25440333B7E537CC33FC
      BDF1E452E5F1D3143A5BFEE21CAAC9936E3CA152B1A7AFE2DEEB31B50E2D85C6
      D3F6EEBBF3C303E73C9D900E4B70754FDB41BAF91D552B8F9F75BF3182377ED2
      FEE6D35FBC0DCD39B91D3F67C2DBCFB0C8F8C69DF889EC4CEE4AC367DCB55BA0
      8E3F678ADFEB5B3F5559F8F4F79EC08AE2C331D5CFB8FB4C5141ECD3EFA392DB
      1B1CC227FB0BF8EE1F55169329F61CF23B7FF28D150B399FF97FD7C1D38EEC51
      FA1C63EC58CA234565789CE371E9AD4F130E73B73E4D2C9D0BE0724CF4F06487
      F8DCCD4F1BF2DCADCF19F20E43B73CD6BBBBFC5EF759F3B577FF9E513FCD1432
      F752789BBAF23C6BCAF6E667CED9DEFEAC49A7A3D938C99F3B6EBEF739D465EF
      7DAAAA347FF733B78AEF7D9AAD20F71260DAB3968A6F7CDEF6F2ADCFD95ABEF1
      392BC4373E7B791E1B8B5872EBD30257951B9F16BD921B9F21062A373E6F2F9F
      2D049EE170ABDCF89CBDE41B9FB7977CEB73F6926F7CCE5E76764DAFF0E731B2
      CAEDCFDBD7CA039EC78493A91E4FD24C65B7CFB87D6FA42FD4134D7CB9F3244B
      230219234CE1E7E917337FCACAC9B36F7D8EF080B9F3AC57D27DCFDB60BAF389
      3E05EA2B9056ECD17B229F25177BC684CE299F6EE97D15A338D097E98890D0CE
      CBF0CC723FD7A2927D3651818D92D88B7AF326FE0103939D5D96E194E2C2F692
      0B596D9FBBCA5D7255B11AC5559DB9AB0E7518CFC6F6AD86148A6BBD87AEB5DB
      5F5CDD5D767545361417F6EEBDD09DBFB0BFECC28AE6505C38B8F7C285270EEF
      BDB03377617F7E6F7655765535948ACBE677A6D01F97ED62DF5D7EED9D8DEC77
      965F78772F1F2020673B08C8F5D37E1C2595972F6CEA7D4475CFF31FA6AE7B6E
      7A98CCEEB9E9016A9BBFE3BEF37CAAAFE3BCF4682C8FDC7B0BD3CF2B718C07BC
      7DF364F6D7596A5C35CB5F32BF8DFB906049AE2B773DE6E0DCB34A0F9CA07BB7
      FC81C374CF5B1E3855CBEFB8EF78DD73F5C3A7EC9E9B1E386EF74DFDA19377CF
      D41F7104DDA71D41F7715CFD9ECB1F7700EFF0EEC71D41F7C947D07D32013F5E
      04DC73C723C8F7CEF41F41C0EE9308D87D0E01BB4F2660F7D182E3DEA93F8280
      3B4F23E0CED308B8F31C02EE3C4782749EA0B1DCF3A2471070E7C904DC793201
      779ECC7F17E7FE2902EE3C87803B4F26E0CE9309B8F364FEEB2D6EFBA708D87B
      1A017BCF2160EF3904EC3D99FFDE99FB2308D87B32017BFF7F7BE7B39B361084
      F17BA4BC8BD79E19E09A5E7AA92AB5EA0310B0D5A869904A2E3DF0EEF5DA80BC
      7F663CB3A5692B5829429059E3F9F1317CBB985DB380C12C6030D5DF386FA580
      C12C60300B18CC02465BFD45AB87C71201638980D12C6034D7DF247D8580D12C
      60340B184D02C692FA1BA7AE11309A058C6601934DC064ABBF14BFE03A015389
      80C92C60320B38C9472160320B98CC02269380A944C071EA1A019359C0C48FC5
      5DC8E138B31A5C7D931FF187F99DC6F0E78ED21C83CB3DE5A7E0F2F17CC73AFB
      9C9A9E21A487DDEE9BE192D2F351425D3E3C3D3E3FED8699919FBFF353BA7856
      F7E3BBF3B56FD330486667FD254BC35C6E3844879A0D0C874FD0B081A1E90460
      0363DF01C886866514C2B7D320D7D357397DC10B63898B75B9E805171DA5BFE4
      E2A2EC575C5C9C3CB239E1502F82C3A2E382E9FC2E0E3BD45C8745BEC32CB6FC
      148FC08F9B47125032CFC133CD779843CBF45230E672D2E06692D372AFADDCD5
      02E6663F14DCEB22EE7531F7DA2C7236392DF7C6CABDB1725757106EBA42CBBD
      29E6DE14736FCAD49E7C54CC73072B77B0728722B52785DFC01D8AB9431977B4
      AA3D1E5529B8A3953B1671C762B5C73959B8631977B27227ABDAE3D183823B15
      71A762EE54ACF624B990FB3022529BC049B4F8193A89134BF8244EAC2093B8A3
      05140BC7245C6702271D742630C5A63281537E4C071E24EB1A79A62A1398C055
      99C02C63A6A702369B9C96BB680273DCD502663ACC538F8D9596BB680245EEA2
      0914B9D7656A8FFD9682BB680273DCD51584B1644AEA89753470174DA0C85D34
      813C77B0AA3D718DF3DC451398E36E2BE14C2F03F5C43E1AB88B2690E72E9AC0
      1C77B4AA3D718DF3DC4513C872174DA0C81D8BD59E24A7E52E9AC01C77D104E6
      B89355EDB1B1D272174DA0C85D34812277DB1A561FFA2EF69FEC7DFEEEF7362B
      FB45ECFBF5FEEBEBDAB618C897971FED7EF7EC774D3C9DF061D8D5CB6FE8B57F
      F5FB45566E5817B31AD702AD2A775CCBF3FE0EFCD640C3EA914D5DB7D880C325
      2E610B1BF42B6C3A8271DDCD86FC1A98D946E391B6D5A673AEADD6EED1B975EB
      F89540C7D6F8BD2EFA43766DD70D2B8372AB98BAE836FA87EFDF9D57A84DEF9F
      1FFF83CDAFBC7EBDED96FDF5B64CF6DBE36DFBB667F237DAEDB5BFDE76CB5E6E
      D87B0DEAC6BF058CD6037A1742ED787FD13FB058CDB984F236AC8A8EFCE77EB5
      A1F576B55CAEEACE6DFD462684FD9942B5A2A646D72277DC4D45E4779B71C39E
      5C5BA81CE738FE95C612286CF777973CBBB7689724F0FF65EFDBA50814647F1A
      7B1CDBE1F00BE92CB901}
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
