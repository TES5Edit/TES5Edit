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
      789CECBDFB73DB46B620FC7BAAFC3FA0B4FB95A53B924C80E02B73E7EEDAB295
      78C7AF6BD9C9BD5F98DA0289268911087000508F49E57FDFF3E86E00242180B2
      244A49276589028146F7E9D3E7FDF86D9864137BE8F962127AD1D46E399DA117
      A501FD182FA6B6D37186CB31DF31690DF9679AA5B3893F1ACFDA76A7D5E13FC3
      98FFECF29FB3A0F4E728A067F11DED56DF569F2702DED81F66333117FA3BFDD7
      EAB7E3B4F5DB70124759360AE1436B08C3FA81359C24F1DC8B8693F1CC4B5291
      C1F545F24FE7B7E1BF0D175E14A7C26A39F07FB7D56E755A2EFC73E093FBFB97
      602E52EB83B8B43EE3E37FFD1D86B4F590E96590A6370F3982215D1A9AFF777F
      7F99045EF8D7DF9F7D0743397AA879EC8B64757A7679AC1E4C6940A3E0F45C18
      EB245E268148708234B576C56A9DF5A9C19EB40072F0AF0753C4217BBF9F5DCF
      4771C88BCC011705E1CD03ADFDF7FBCF4134F5E15F2AD769BB1513B3DBDDCD1B
      B132EAEF9FDEC370EF82AF78DFC40B336BF8DCB387CF3BADD4F9385EBE14BFF3
      FAABDEB3716F709B79BB71DB716F4EBCF908B6C77AEF653339F5766F9BED9ED0
      D6D046EB21C300C6A4E9B9ED2DF67BC37FB0DF511A875ECAA3B9CD67B669B033
      318D85F5F5AD5CA8DBD9668F360DF8BFD526D1F44218E41F71021084137ED7C7
      9066EC8F0A6FB01F06C36641E19DCE76A8D1DE8C1AD6BB603ACBE49A46C5F1AB
      8EF337102FD8952052E36F755AB6D895FC0D5BE1D437ED4AFECEEE1D1D58B51F
      F9C8BDBBDF0FB75B45B2DB7D1ED55A79CC3A79C34F56CDC6C17DDDFCE475A20E
      FBA06A63BA76C5C33F24429CD39B3B55A7D9EE3A150F7F5926FC68E531EDF52A
      1EDDFF518C127179C0CF3B95CF57816BFF65E28D82F1815C79A7EA50D9FD6EC5
      08AF00EF8231BFBF929175DB55EFFF291059E4C14521D75085A0F996938CA036
      BA53C581F28D96F7EBEDED0C2A1EC9B7971FC937B5DBAA7CC4293DA2B6B25B25
      07E55BC90F9436B05B4533F30D944F95B7ADDBAE7A4E6F1B3F57D8AC6E1583CC
      374BBE6B758BBADD2A46ADF6C8B60AB297DAA96EAFF231B9552B8FE90DEB0EAA
      9E543B567E32DFB75EABFA4967C3936AFB7A76E57372FFCACF9576B15729B8AA
      6D5C79B8BC99BD4A3948ED66F9F1C29EF6DCEAE5B637BD79756BED7EFF662A6E
      299663FD2CD20CDE7003EB6109B15F4FC38B82A5C29676BF9E82979FBB4EE483
      F5D4BBF4608E2DED413DED2E3D4AE8C2CB1CD453CED2A3855D6B0FEAE966E9D9
      B56D73ED7AAAA9E429C520ED7AC2A91FC939A35D4F3BD553395C5DA79E7CAAA7
      D409749D7A0AAA9E299D3ED7A927A2FAC1F2C9739D7A3AAA1E2DEC9FEBD49352
      FDC6B5ADEB35A2A6ACD9E4D24D235AAA1ECAB7AFD78892CAE70A1BD86F4447E5
      737A0BFB8D28997CAA08D07E233A261F2C8394D7D9AF3F0F4AC1D330EDD71F88
      FC996BB5C4FAF3A01F2AC073507F20F46339917107F567423F563E1483FA4391
      3FA94F053D597F26F493C53D1CD41F8AFC8D1BB67050C789FEF72A2B5A57ACAB
      86A8551F4AA354F19326AA447120BB52BC6FA0569406AA94F36B558CD230952C
      AB81BAB1BEBA4A26D640F9581DAB52336EA2869446AA923E9AAA246BB614A7C6
      5AB38D84B4623271FA8DB938594514B696C6A82248EB6C5D8EA171B5384CBB92
      D2ACF1791E26C7D4D2309564678DF1F3300A4F4B835452A03549800759C1D2D2
      589554694D3890631571B43452A7B1ACC0231530B4344E15AB5A171EE48CD6F1
      B368176BDF9AE89546B925D15B19C6BD35C95B5B977B7BA2571AE65B88DEEA58
      DF42F2D617F84D44AF34D2B712BD1553A87B3B94522C221FE7F648551CA6DA4C
      D68C8FE603DD12A5D616566D366B8654A5B1BE9D8FE663DD1EA5D6D778074855
      B47E77EF9C8FE64337E7A31A4F4BCF37E7A10A3F8B8FF79AF3CE12D7CC0768CE
      35737C2C0DD09C6396F0B03446734EB9CA23F3319AF3C812DE95C668CE1FD7F0
      ADE89FE87D0B5FCC47F91665A03850FF5B885869A06FE28BF930DFAC0C9446FB
      4622561AEB5BF9623ED2B792305AE8380EE3241B857F1D26C26F0DA7B02B516B
      380A97A2B57EC9E9748A17E1CF9B2EF300F8D78621562EAFDC5B3144C50B7908
      DBE9172FC29F375D6EFDF5D9777819FFDE30C8CAE556F9623EC8C6CB7A908123
      BF800FF4C5C06904E7166EF6BF6150CC78B64052E138438CA7197AD2EB89D134
      FA0F0CBC917F742CF5E0C25B58B0C27F86D6300C5AC304FEA59E0D6C2A0D9DCE
      007ECE9761660F2F037F9C850B2F195E26DE029EF3E0F2D04B175EB89879F821
      5ACE815179CB2C1E7AFE3F966996A0DC0E03C25C43FC1164DEA265FD3E8CE27F
      02D6C5F33813D66FC334BB0E453A1322FBEDE126314CB210603119A7362EDE9B
      B4E01F02CF53C14C30912CE15B5A0AB02ACEA8106244C0AE83F5703C4D029F1E
      8B168511A2058E610DD3485C65F096F49F9338997BC0EAD34512C449905DB7AC
      0F7809E36F609EA95D06D1C86E11A0F0E708176DC35FFC7B2B50C5CB0C802342
      7121C25663C00DBD91821C88CA9B2107931E0DE9FB4DD03B07F906A41DD00519
      8E2D05C3D676F01B79A9F0E3A8254109534B61CEE77667234C0716225D9206BE
      EDB6BB8ED36D5933E1616892654B383BF70F67FB36700648DD086784642596DE
      11741D05DDEEB6D0752474DBF70F5DE736D0757A374317BEBF77E8B615747BDB
      42B7CDBC00D6046379BE1F64C18580DB53310F6681EF8B08FE5846F0512CE195
      85416DEB3543D6FAE425DE14203DB34EE328A30161ED596ADBF023892FFD6196
      4CB2F4E7C0CF66AFDAF0C7025E14DAADBEFC98E41F27A1FA7E92E94F23FD29C1
      4FE3D1C203B20E1F26FC61044B070EC7BFB3EB8580BBD20B916420D9C0A751E2
      27EA77287F8FE4EF44FEF6A7A1FEA4AECDE4EF0BAB8EC5C06AEF85C93C0A1663
      DB37A0C3B3EF98D3585FBC5128342E758AB85445FCCB2B1951842DD27C4DDF73
      3C47E46404C7DFF1F8BC84891BD0FB47459AAD13905AF5BCBAF5F3C2D76E9817
      5C4622B43A1F67CBF938E5F9F4EAE7E3F436CE072FAFCDA6BDE56CDA6A362425
      F4EF87C06E8DECEE0DC8EEDE392D2DECAA9604FA25596A0D7CF3348E947CC5FB
      38A8DCC749ABBC8665381C4F9C95BDAB26B6AB1B07C42DC19D566F765ADBBDD9
      76D6D0B8F1CB4FE3308C2F855F9A44EA807439CED126470D26B3F833A59F9736
      685749BAC029DF2DDAD88836F60D42CEC590BEAF461D5BA18EFD4D6C585305DC
      600DD3E6BBFBE5FD3BEB4BBCB0E209003B99EB4D76AA3759AEBDBCD517945A80
      9737D2AC12112DCD6E6542FF3A2ACC4653AED469DFB0E5D99F74CBDDDB6FF9AB
      38CBE2F9DAAEBB77BBEBEDE6BB5E9E5061E33B8F9C45C0C2EF8549ACAB339D9B
      59C4224E61E3E2E82811A1873BA854C4EE2387E0833159A77B3304FD245EF8F1
      65A48F43B5ACB4CAE94AB87FD32B8E820875BFA3119E0BFDA2FE9DBFE8D9776A
      3547632F11997E5573B9A1E9AB001B66B11630DBCDC583A62F00956B76E40717
      40D2F2D7D837CBB1B8FF251976E575EB1A2B71D095379F65491C4DF53B6F608A
      B75CDA385E46596155EDA66F58A5B737BC23118BF82889638D03ED1BC8FC2DD7
      F18FF488762915D3B988F237556B65B747EC540085F2B202CA55EB58B746B9E4
      68EE1FB9FA0D774F0926412880184CE2026693CDC9E844CAC2D4DF46AC914681
      FD9FC5E8406FDB0DC4CEA145AE6C1EE6B4D2C55BEA4A285A9DC43E592552B755
      DA49BD5B68A8BA1A80A4985DD9FDB603BF9C9EDB875FED6ED7855F6EA7DF825F
      1D7780B7745D1B6FE9B5314FF8AAEFB82E3F8DB70052F46898D6608037D9F600
      CD5A57B603F7E1EF76CFA5FBDC6EA77BC74822E177A354D4BA014D1C8526CE37
      4945AE1236DD9B6C469B77EA5322980B64C25728E356F3959B51669300CC936B
      2200AFCDA764B471AB194FB04E81827A56B7811EBD99033AA441AADF791FAC68
      111E69A1C7BD7B2E04C38F2519751FBBDEF06064D4ADD11BE6C991B6C8BB77CF
      4927DDBFFE4EA387419A6568B2FD8D3EF2DF62BE006545C0FD7D1B6859BFDF72
      F86B728E0CE967341983FAAF3E46EAF33FC62DF5216AA1B4879F276430925FA4
      99976468AEE7BF16DE58C86F82084E61D6FA8DFFCA004AC3E72D7BB83C6A0FEC
      B6F5BF101CFCBEE57C24123813549D20E5D8628F762F386A7771F77B70F11F63
      B93824D40EE104FC42CFF52D9672E3422E60B25146EA5D71556AF99BD7156F5A
      8F53B11EDB75CB0BA20B3032FE7EC025552D0896AAB60A74998D5B65B72AD6E6
      20DB2CAE8D2EC04BF0F723585BCDCA90A956AF0DCE4E796D7801D706BF1FFFDA
      6E5819FC44042FAE0D2FE1DAF0F7935E9BDB5E211F74015E81BF2D8A677AB26B
      C3EA01A5B5D1057805FE6EB26B8AAA3DC6B5F55628095DC0B5F5EE8692A8B5EF
      606D5D778592D0057805FE566BC3983B0B86C1CF810F8A8B3DE8D9BF6F64ED47
      7DD7ED753ADD417F0BB0E47B5FB3E57F44D6AE37BF765D86B51BD6FED8D76658
      BB61ED86B53F55D6DEEED9DD0E28E79B797BCFEE0FDC41D7710D6B37ACDDB076
      C3DA0D6B37ACFDF1AECDB0F6226BEF74FB4ED71DB89B59BB3DE8BBC0F8079D6D
      2CF286B71BDE6E78BBE1ED4F776D86B71BDEFE07E0ED4EABD5EE3AFD7685DE7E
      E4D8C0FA3B9D81D380BB6FBFEB7F10EE8E0BBFC5263F7DEE4E54EEDBF1F6B173
      F76F925C9E3677BF51722166FE87E5EE2B924B99BF3FE1B5D570F7A72DB97C2B
      777FC492CBADB83B1635EB749CCDDC7DD0B1072D67601779BB02C037EFF953E2
      ED3561817F64DEDEDC186178BBE1ED86B73FEEB519DEFEE7E1EDED4EB7D76ED9
      55D174ED1E3C3AE81ADE6E78BBE1ED86B71BDE6E78FB235E9BE1ED25DE3E70BB
      AD5EAF5FE1723F02DED11EF4BAFD6EFF3E76DD7077C3DD0D777FCC94D47077C3
      DD9FD2DA0C772F85CAB75AAEE3B4DBBD2ACDDD75EDCEA0D531CCDD3077C3DC0D
      7337CCDD30F747BC36C3DC4BCC1D90D56DB5DD2AE66E3BBD5EAFDD715A86B9DF
      C1529E0C3F2F2EE8E62A3C869F1B7E6EF8F9E35E9BE1E77F1E7E3E180CFA0EBC
      AA22FBADE5767A4087FA8EE1E777BDC74F86B91B65DD3077C3DC0D737F026B33
      CCBDC8DC5D7B60F75DB75D1143670337ECF5FABD76D73077C3DC0D7337CCDD30
      77C3DC1FEFDA0C735F61EEBDAED3A962EEED4EA7D3EDDAC562B3263EDEB076C3
      DA0D6B37ACFD29AECDB0F63F0F6B6F77071D07A8E866D63EE8F55AED9EEB98DC
      37C3DB0D6F37BCDDF076C3DB1FF1DA0C6F2FF176B765B7BAEEA0C2E17ED4EFB6
      FBBDFEC036D1F186B91BE66E98BB61EE86B93FE2B519E65E66EEBDBEE30CBA55
      B5E4FBAD8EEDF45A8E6B98BB61EE86B91BE66E98BB61EE8F776D86B99798FB60
      D06A753A9D7E057377ED96EDB876D7307793FA66F8B9E1E7869F3FC1B5197EFE
      A7E1E79D7ED775DA9D76A7829F776DBBEDF4DC96E1E7465937CABA61EE86B91B
      E6FE88D766987B91B977ED6EC7E9767B15217480CA760F386BB161BB09A133BC
      DDF076C3DB0D6F7F8A6B33BCFDCFC3DBFB4EBBDB6B77AACAC70F9CBEDD1FB41C
      93D66E98BB61EE86B91BE66E98FB235E9B61EE45E6DE6BD91DDB6D39555EF676
      B7EF3AAEDDAF888F6FE590696D0B96469070E05FEB78150A082258429285E3D9
      70324E6D6BE84D00126196F0856FE1F31BD794EFFA9D6F362ED1FEB625DE82F5
      6FB3739ABB7FE32A9D6F5BE52D84806FC1CFDB8837B8CAF637AE727B71E08E56
      59B9463AFB2BAB74BF6D95B7100CEE7B95ABE21CAEB2F36DAB2489603B11E101
      5729D7D85D5B234BB38D5759232E3C8E55F69AEE249EF58DABDC5E7078F855F6
      BF0D5F514E58116A9B88109D7EBBD3EF56B485EFF46CA7D3861B9E8071007599
      7B330FDCB58C7897C681272DD27FB371E0118BF4F76E1CB80BD9EE966BDBA571
      E0BE0D56B7E0FC4FC660750B7EFF9828C98D06AB6F360F3C5A4A723BDEEE74BB
      AD4ECFAD489FEF766C1B2DFF86B71BDE6E78BBE1ED86B73F06026278BBE1ED4D
      787BB78F41F77685E9FFA8DBEF3B2DBBEFB60C7337CCDD3077C3DC0D737F0404
      C43077C3DC1B30F7BEDDEE38F6605051AEFEA8ED749D963370BB86B91BE66E98
      BB61EE86B93F02026298BB61EE4D987BA7DDEFBBDD5E55DDBB56BBDD6D776DC7
      98E50D7337CCDD3077C3DC1F030131CCDD30F706CC7DD0EAD99D6E77506596B7
      BBED56AFE7B86DC3DD0D7737DCDD7077C3DD1F030131DCDD70F726DCBDDD6B75
      06C0F33673772442F6C0ED19DE6E78BBE1ED86B71BDEFE180888E1ED86B737E2
      EDFD41C7717B15156E8FECBED3EF767A03DB38DD0D7737DCDD7077C3DD1F0301
      31DCDD70F726DCBDDFEE77DC5E559ABBD3EAB63AAD9ED3770C7337CCDD3077C3
      DC0D737F0404C43077C3DC9B30F7816BF7074EB72A5C7E3080677B3DA3B91BE6
      6E98BB61EE86B93F0A026298BB61EE0D98BBDD72ED4E7F30E85755B0775ABDF6
      A0ED748CDBDDB077C3DE0D7B37ECFD511010C3DE0D7B6FC4DE3BBD76D7195435
      9FB3DBBD6EB767F75D639937DCDD7077C3DD0D777F0C04C47077C3DD9B7077DB
      B55D60F0FD5E65545DCFEDF63A9D9EA95367D8BB61EF86BD1BF6FE18088861EF
      86BD3761EF6EBBD5763B7DA722ACEE089BC7B88EE3F65CC3DE0D7B37ECDDB077
      C3DE1F010131ECDDB0F746EC7D000A7CDB1E54B2F77EABD3EB0C1CD7B077C3DE
      0D7B37ECDDB0F7C740400C7B37ECBD197BEFDBAD41D7A94879775A76B707E377
      8DEBDD7077C3DD0D7737DCFD311010C3DD0D776FC2DD3B7DA767777AFD8A6275
      47760FD8BFD337CABB61EF86BD1BF66ED8BB61EF86BD3F1DF6DEB5DDD6C0715A
      159175C0FA3BEEA0D33539EF86B91BE66E98BB61EE8F818018E66E987B23E6DE
      EDBBED4EB733A8D2DD073DA7D76ED926AECEB077C3DE0D7B37ECFD511010C3DE
      0D7B6FC2DE7BAD56AB6F773B55B5E6FB3DA0B1CEC035156D0C7737DCDD7077C3
      DD1F030131DCDD70F766DC7D60BB4EB7AAA2CD51B7D3B361327DA3BB1BEE6EB8
      BBE1EE86BB3F060262B8BBE1EE8DB87BBBDDB6EDBE7D4339DA7EDBED83FE6ED8
      BB61EF86BD1BF66ED8FB23202086BD1BF6DE88BD0F6CA7DDEFB5AAD8BB3D00FD
      BED3036264D8BB61EF86BD1BF66ED8FB23202086BD1BF6DE84BDF79D9E63B740
      81DFCCDEBB4EBB63B7BB7DE37837CCDD3077C3DC0D737F0C04C43077C3DC9B30
      F741ABDFEBF4E13C5631F76EBFDDE9989879C3DC0D7337CCDD30F74741400C73
      37CCBD1173EF383DE0DEFDAA5AB44EABD7B33BAEB1CB1BEE6EB8BBE1EE86BB3F
      0A0262B8BBE1EE0DB8BBD3723A6DA70B1C7C3377B7EDCEA0DDEDB64C8FF73B58
      CA5D32F4C21A14A97B3AA8FACD0C5DAF2CE7EC8F666DF7CDD0CB2B4300FC2918
      7A71656AD70D43370CDD30F41586DEB7DBDD8EDBA96CFCDAC52879176E311CFD
      6E77D9E8EB465F37FABAD1D70D7B37ECFD1ED97BA7D5B63BED2A7D7DD0EDF45A
      4ECF54B0B983A5187DDDE8EB465F37FABA61E886A1DF1B43B7DB8ED3B77BF6E0
      77F8FEDFE86A7C219224F0058C118ADF4A979453DE766D50F1DBFD5EE9DB71BC
      84C50CC35449072B8F39ED4E17ABD7DA9B9F72363F35E8B7FB1DB7D775363FD5
      D6CAEACA733DA7DB6D757AEE60F373EEE6B7E52578373FD6A9585AABD5EE3AFD
      766BF353DDCD4FF5ED76C7B107830A80F4363FD5B5BB1D585BAF8B746DD373FD
      CDCFF55A9D7EBBD3AF02E460F353EDC160D077001D2BB6BA55B16BAD9EDDE976
      07FD8AC72A5064D086590E58FADAF49853B5DB79CFE28A27DB15CB6BB55CC769
      B7AB30B90A4D74B1A78AE72AF0242F2351F15C05A6C0B6B9707CDA9DAA3DB72B
      90653070EDFEC0E956A0985D812B794C6DC57315D862C389838330A8828B5381
      2EFD4EBBDF77BBBD0AB03876E5BEEB9A9A154F565015D786393AA0C8543C5685
      2EC0DEDD56DBAD4017A7025D06EDFEA0E3B8BDAA49565215E51EADDA76A7025F
      E028C02C3B7DA7E2383815E892E741573C57455BBAB007362076C56355E8A2F3
      B22A887BAB6ADFBB5DDCC1AAC72AA88BDD72ED4E1FE859C5EADA15C89207A155
      3C57852D3D40CCBE5D7186DA15C8E2B4EC0E9CF48E53B5E9ED0A74E9F69D3630
      D84ED5EA2A702557EA2B9EABC095DCD65FF15C05AEB88341ABD50168563C36A8
      DAF35C58A960E915C4256F785BF15C15BAE8567A15CF55A08B3370BBAD5EAF0A
      CBDC0A6CE9C0FE75DD815BB5ED6E05BEF4005F6CB7E554C0D3ADC016D76DD92D
      785F1530AB288B6E4054F15C05B6C071B5FBAE5B85646EBF6AD7DD76178E1FA8
      FA150F569016D7ED01F51B742B36A1D36281371117D928B47EFB1A9D47F165F4
      57BEBA982EE82A7E1806F003E86890790B4484D630817FE908FE7988705BDCD2
      DF7A10C085F59BDAB5C380787107D31DDCC520BDDB0F8208A16FEAD42FBAFE96
      FA3B9C7AE03AF54BEADE05E41C6400B537D9F570A9BDA3553F463DEA36007F03
      AC6C80FE4EFD30763DEADA551BC064210D7CA400F4A1DB0799BDDBE3CF835E07
      293B7EEE39A01BB5FBFC79E00257E3CF207C751DA78B6F9BCFBD6CF629E1DFA7
      7194B5DDE17C949CBF0AA296FA70B68437CFD3B91786A7893786CF7E902E5E8B
      094A7DF3F0BD974CE9EE447FF2C5E4FF8CEDE1FC32F1166FC98440D6DE791065
      EF82397C88BCE41A3E215F0BA249FCDBD05B66B338B1DE84704F9A89E4E557F8
      2A5E88C4CBE0F217F80EAE46D69B681A8A04BE1A27C2CB82F9F03A016964309C
      C7EDA17FDDC13774900B21D55CFF7696D87807BE15C86D1AC4113248E1E33B91
      E745F164E14D454AF5EFE18FCB38F141C3EAF507FCF778E6252968DF2DD6F2D4
      95CB74D0EF0F5C1E351AF47887AEE621AC8488347DB4AD59962DBE7FF1221DCF
      C4DC4B8FE7C13889D378921D8FE3F98B783209C6E205BEF2052AEBF4691EFEFE
      FB70E101182E6DD078BAFC7986310AFDE11CA01D325CE153A23F65FAD3883E4D
      97190014F0284B5231CED0AD7019F8F1E5384BC2E1248B46FF187A22F2FD783C
      CC607BCFE7C08BD2167F9EC40920461644537BE8C7519C89F948F8E9753A0154
      B101CCE1751C5DCCC356E1DB10EEF6BDCC8337271318555CC0FEC380175E18C0
      7501D0B087E92CBE5C84DE58CCE2D047BB121CF1691427621E5C097F0CA3A3DD
      09F0FD4204113D79856FC1C7E003F04A40081B76E02A84E9C5D722825589AB45
      3A4BB2082E2F61B161BA180FFD08B6204A47FE08AE92650B96B48475C3C2D299
      07DC1850EB5FB8767F3A27F4850F33BAD106B1CA9F5E143EC3ADC1943D16F84D
      E9AF194ECDA607F0031ABA603E5EE40F2F0271791E44BE4D9FD2B1170A5029E0
      9C8F123F9909CF971F27719C0DD345789D5D464124706BF4E759368713922E60
      116134CB3CFF1FB0ACE132156136F2C26808FFE002BC64088FC01BC6F0D725FD
      011F926C9A0CC3080E33AC5CC010F0E9324101629846DE228BA7207904D15884
      210C14C69793408470687D187E08372E96D118EDB55E1A787A14A42309CC58D1
      9261242E61C434BB86AF5378C934892F61CEF124C870A211023CBB06B8A3B803
      DFC364232030593A9C089C9C08C5055C1E5FA50B32EC0161F0610F2FF1BAC03D
      F526633850386B6F42372F012FC3E18CEE40C0654035BD04EECCC6171EC12A83
      D9E24393040182172EBCEC6A74353C4FA2459246221B8E3D388E807021C0D142
      CC09E0342EBCCC8269652D3CE6FF36BC04449ECCB34910C241B21C1764333CFC
      40819689C866499C65A1002E164EE2B937F6B271182D171D3A7130216B88C7CE
      B7D40104821E89ABD610B75E24D73D20CAB8F5F223CC24BDC20F00FF68261241
      4FE323B84B6849A5D1C4C4031C1FC30ED209B648288CE0ABF0024ED7225A8E93
      395E40332FFECD865CB45B2DA299174D51748CB2ABCCB38EA544291F469E8E8F
      C3646FF57C1B3E81187BAB675DF814367FF341F9E94EF3378FACFDDFAB86E912
      001A4FE3A6A17A3450B38DB8699CFE5D4D68D0644224D56E1A09B84F02C42AF4
      82C892B83DFC271C1A25A00057014CC5AB48CE46F433A59F97207B8D9274E1B4
      AC21CA04127D81A22CBC7031F3F043B49C0F271E528C2190B7659A01759D6530
      70442E022502C2F05E51860109280BC7B3E1640C1C1628430BFEA520BC7A21AC
      C56E391D9A2ADFC02E75FC16BF6CB7FA367D98089B94D318EEF2266DBB038C76
      1614FEF047FA8FCE708CE7909E8B168521A2050E029B509E8E8DD3B1BBA5490C
      2F86701D2F038D4B8B421B8A13A5C5212E020561D0E7401F57013D7B20A0DF6E
      999A576C5AA784B85D86366DCAC4B65E018D8DE7563CB14E81916C0B9687C2C5
      0707CB9778715B98FCB951A540B6D291DD4249937E8E7081209E7AFC3B075903
      B0C44BE2D3E4106D7D1390468A90B9FD55F2351A4E5C7788DF0C612AB3E139A8
      1C2070B71B404EC10D9EDF0038D7B57E9E79D9F3D40249CE02127FF5C60F32CB
      3D6E1D3BFF6B4750B4EF068AED156C533004A0110CB7C0B94AD8FD3D3E3A0D1E
      104CDF74069949BA65A8304CD0787107E078697148001E4390FE93D4F2D273E1
      5B20FF5B9E75E95D5B596CA5CBC5224E3289693EEE78BC988334625D06D90C10
      011E05DCB63E795922E2C8026DEA053CFFC9BBFEE485C712D8B553799B590120
      757C692DE2340D40B5A87FB7358AE1471CC1ADC15CE08BAD39E8A4B3F0DA0245
      D7CB82384AAD8BC0E36D3FB4104453589E1F2428ADD3EA3C6B9C081C7C8CC8C0
      2BC11D5B0854F8AD7D58C945EDE4E115BCDC033C922FBFFECFC6CBFE32133C3B
      18602A10048021B80538ED4C7F395A02B58C7070BC96013F219CB2C67112F1F6
      E1F539CA7CA8331F1B4A5007F81FBCB9483EC5224BAD9F025FC4A9A10A05AA00
      BC658FC1B2A7706FE6A5D6480838DFBE0FF8B92D2A36380980FC9741185AF102
      DF62FD77BCFCB21C090B54996BB446F091674A902EC4389804B5838EE11CE12A
      ACD17561C7CDF1A805DCABE574125C09752AD837469165B97AA92D272B08BA82
      9A325CBA5EF051AA5D794A34D349DB1A3E1FF5869937FA7DC3AE9502B01B6FDF
      4A981B3EDB6043C374F336E2E3E58D94C6FCBB3EC1B57BF73FBA6DD73AB27E39
      FDE8FE6A498FA4F54924E7D69B284BAE177100FCD3EEF49E7DF70877B77675CF
      BE83F575617D2F7D1F99B567A56360D7993549BC298906C4D5FF73295214937F
      7AFFF2B505EC3E0694F1639146CF415E59A0859BE8947AE8043DBA1699549F22
      50F613817212D065A0D4AF8314977B0030626A9988B9A0C84F6B7F195D7A11DC
      175E83A8B242AA41E04BAD791005F3A00185F817BCEC7206941A5E800F861E90
      E87118A72225492C01F8C7F003DEE101C1CE00E24F11B2CFBEAB82EDCFB87804
      608AB1B0932024F10D7D21BE955D0663410C2B28DC93021A46FEA1455B92028D
      49918D7A91459E1280268E9188C89B23621FE350346E8A6F4E67CBCC8793FCC7
      02E22FA71F7E422205DA876F019E20AC04600F8811AFDEBFFE8210BD4CE2688A
      22BD98002385BB40A6F79200BD0F561AFC4B58FB296821217C1182C682424A3D
      896C83409089F4E08F05CC93380CBD05A930003F49F4F014A26AB14F20A613EB
      11E57C016421BEC00F290C860FCD3D74EAA607A00B45D632F2419C1B8B2443FA
      300E92F1720EA7381A033A32F64AE4F552D01C3389BDC05F702454DD107B89C4
      E2754CEC4A9E22B4AB60BDF75A8805407C718D08F9510606ED118F0135164861
      031A3A13E373B94F440AC60043DF9A26F17291F25685717C8E00458D5C6E0F13
      D44820998911DB592087CF2490A38A9BFD91204D749615F3DF5745298744A9F2
      D4D17BE0369EBD9A557BE3ACDAD6DB08B17BEDC5F72DC33DFBCE3A17D74ACBFA
      291097C43602C6ADA289048EB5759225217E9E84C1821ED83B8DC74BB21102E1
      64FC001504051DC2331C6F0FF42CB490FC1150A5013835C3393B7BF3ABF5FAE5
      979708889F5F7EF98C406506F4144171837C22AD73800F73714868118CD12256
      A5BACF90627BD628F4802A8DE0071222E0C5FB4070A273106D669EDFBA849FD7
      7E9B081253F7AB27C945F727B4B6D1B5B22A8A048176E65DEC88D01C8B74FEE0
      64C6825DDCCD5AC3875F2B8BD2CA68FDE6EC3DD04B8F592B1005B6FA2EE0187D
      6CC0B93FBC7C6F510C9C47B2EA651290040524DA43F1E89FCB20117472843545
      D13FC348B8B430053C3C40B9E1B0880863DC94F40A8FCF180761827FA493B503
      347BE9FBEF5966DA3FD8050747311AE4B3B11786287AE3AE63DEA494E0BC4410
      33A7B8396B1EFBCB50AA7B7FA05D47FF4604F83C256F0C1E0381F175A05D4402
      3489B4C151035D0F849831CACA28FDF8A80E93E562CEA60B3A5F4A36C6C33CC6
      00993F14147FF9F2E6ACF38224979F495700007C8A2F8167C3FACF7EFCF8D592
      2A30E2136A0461308D50417EAA26BE2A389C7E6CBF208BC1598CF614A0D8D1B4
      709CB2C48B525035C936A0CE1712F929DB0DD2E578F61401B2091C4D08501962
      A0A49FBE3BFBA27005F0C40F5204951C99CCDE4F113C95F8F27AB9088331DA7A
      F74E50B54E40938C277BD60F9FBF7E4A151C587C06C1378AA3A309204F28ED71
      05FECE360E4036E339AADB8CF75EB404109E84C28BC8728171C9E489C703E98B
      45227047FC0784E423F7B756436CFFF9CBC50298DF29C734237353773D6F702A
      0EADE75F231F3028E3E088D77CDCADCF6222E02800FF7D7E485F3CFF8CA64038
      256F31CA144E0C59135876DA5306AAE7B481A84106BE40E9361EA5318DADE459
      38315902720CCD1E8FCDF3FF5C06A04BBE844DE0893F4739872743AE5E8CF788
      23582186E3C31104E1284563A5B8228243A6C45990367622BF8F139C05274490
      543D42597F751A4A3263AA511FDE11D12C54E4D507905FFC78BC2467D33E7C39
      07DC0B1621B9AAD13C3A020A7479489619B2FD0B0F30476FEB81713FD742FC97
      9F4472FDABDCB733C48D93389A002DCFD24379F517DCCE5F793F198B697FD1CB
      6FBD0B22786C39027CF08589EC28461B014EA60098B992A3C941488712CF049E
      47941FC7289B0B150F9591100F7095C11DE24A90EDDF876749AA672B247C5B3B
      0304C25CA0A8DE3C30245627097ED2BC0FADEB7849F32567199F3210EFC4F1F4
      F8FB4728C0EC3C62C179E4110B78DA371EF6EF57CC0698DFB4D1707097660310
      99F154E0A4684E38253DA36340FE1D99E960F1F51694BB0404689D2E41E23FCF
      4EEE63DD8FF0A8D66E45132C7D10E3D6D9D91BDC9B4785A11540C05214F786A1
      1D828241D03282E6B2EE4E90F3F4C34F1A39712A3493C78798F708808F4439FF
      F3A5C1CB125EEE0E251533A379FCE9F051710B838E721FCACAE26E8824D3089C
      094E04E7F1674249B5FC1FDEDD234E1AA57F4DE9D78637B2B9C960909F83C847
      91D65B28DB1D5E7D8FFE35FEEA10B5FCB9772ED0C72DBC9453C304EADEF51E3C
      95C0A5734828AF9DB348307D8B5FA7D47B631F6B46BDDEC51EA7EAAD1BC40CF6
      1713EC1A11B7BB246D47089910B6E71EA85A2D35D7263665E5A6C0DF2C9E0A38
      63091BEB1F1E22FF441C45B08C113F1BC185D8CDC373B9BB5FF6CE967C0B6B2B
      E7E1661873CB111A5EC2A49E32EEAE396384635538B1433B9369951C8588378D
      E3F9DC6BE25D41FADB787A64E27DF87D94E2330A2AABA89C1F769957D438906F
      ABCD363CB1114F7C73156486F915991FE6F2EE86010AD88BC7CA00BD42E5033F
      98903F3C9302F23E12998D5EC6771F5FFF20E0F719651C1E205DA4A069966E71
      CDE876C678BF6B4E85B3BC09CE03E921974944E13AC038D0A83E79399D09DFC8
      C2B5607A83894A5E684EBD66E15190055EA88B67A08A2081B492C5DF98ED3282
      CBE3C44E57CA387A70C222D7A198F18EE448A5BEEE4896160C845D2C1ED04793
      D7C6D8F3D2E21CF445128F4231B7C6CB04C92D10C940066F06138DA1984B8C91
      771C342D0D0430948CE701899284534A28B4306AC9E784EF9C8AAB9B9B4448D2
      0E9E65C29B1FF2AF3C81AF90259E88690007FE3A8F74E2EA4B344B9ED8C243AE
      02B3E3A3424616643D14864BB959017C2917F93CB55E7B99470F190A5FBB4FA7
      58EF749959D4ABC6107982C96BCC860E384C906410A2EA8CB37C22C663AE6940
      91AC588939E5CA4E734B9655C6C3651FB78E5DC25BFCD4418C1CCF8C09AEC106
      9CC9A4691020DF7E38FD584F056518A541E19CFC7E62862033A2088C2A173DC7
      69AC43E3138A966E00D65116B845B41ACBCE75CC80104F29EBE6120BF5528AD6
      62110680E4D6FE17BAA4932792398D14012A261407A7D3ACB36542952EE2C984
      830DF182CCF8826B32184D65C5739AD748E00D981A9651A5082F53B6F706C0C9
      0AC3B13925C1A2650C03C0235464900F2618A13E62BB0C65C288681AA0493DB1
      4EFE7E7CD09445BFCAD33DDF4693F87B7E8F4A4D87A9C421A7F30789F50993DF
      F61789B808E2654A771EC02D32A658557198C75C8C6526AE2970182D24C23F94
      89A3C8F863EB324ECED5CAC26BC96AE5387E710AD61C10B980133C187C6E8064
      F042718C5184DE7816085A45901E961758C8A64F399716C967E2CB5A0685758F
      B034B958DDDB98B67CABAA6F948FC1BBC93E97DC3902D889FB0EA3EEE9BBF6AC
      7D85D570FD4BB2140784877BA78852F320E51A7C30C5F29DC03B5341CE1BD8B0
      5424B22883DEBD91C074C37899349296F0B4E41347510DCF011AFDE00CE407EF
      602B486CCA0FA340D4FC20A3AB8AAC92FCE2719ECC61BD7EFBF25DB18602E9DA
      743EE05F80E2E12489E7C52DBCF0C225AAF9BA2E0BDF4E0754A32B802DC6FC18
      AC3EC672E8C9DF95F4291F806B97B8BEFC211070C7A2494E5B2A4A87F6A0986B
      221110BEC6CAA86F5F1F736934954C48C96DC5C85C2AC37F955970DC96CAF8CA
      4FC257E1720E984535CC95532F0777AAE1DD78BF30F63DB72A174EA42E4281D3
      49E2503AF4B2CB58E237005CB6CFA19303C0262A9B63BDD0B44E3D70D9A08046
      44D69D839D38F08FF02820423EB8CBFE7027CBFD10FFC9168CB41549C60E968B
      A466377B7C5F8B363A45EDB67F04B07F65B30366AE185521973D3E52C5059601
      52CC6EC6AE1E949A89A12D524A94FC832A4E49A69771CE967401585448145502
      C98B7C12A173E141CC1771822ECF9337EFDEE572862CC95418FF587A4A75AD07
      B2B2CA9A12C8A0590740451C9BB5948CB128BD12F7D66F535388A3235F90DB74
      45A46F00A37A874204B396AE8A10F586EB55978596C451B085D913D0372EACB1
      C05040699D6594BB648AEE93C912E7B032232C9B21781E7A9B5316CE94721781
      CCB33E3F922C17CB64815E18D636D4167864BD93523726D09FBDC19655A8359D
      62CDD32692B00A86D27B440E609C0EEF3B1A31272C1892D02CEB131C5BA7CB84
      BC50EB498A5941CAE3C4C40D73DB46B04E04D78B421D31CDD3B4567704E689E9
      5420BF626DCC692C751ECEB9F2329DB7F86DD381592C55B57A18A83489DAA77D
      91A77C8980E02733BF826C276E8867DF0124F235EC2C6C931C1154815319A6EF
      1A1405C2532933E480787820DCC61B81C7FF231FFFBD975C7687AA157E24ED79
      A5D0B552A6898464A8771FABD29F70BAE430688C82437201785AB0FF131565E2
      45B69A940BFBA0736103C1DAD705BB1A1020D8697EF5A11A95EB17AC8ECB13A1
      D246168E8D93696E15A275C2B9254BD70ADD3864004832AAFC1DCA1CC09E1A5D
      0F55554115D4A52EDDDE5A225FA3C96332E6B7E46AF0C3BBE11875CE60811F9B
      8ACBF715DF6564EB5A601D8F52EFC5F1C873AC1F0135C387ADE5F1C8C5EB5251
      FD713DDE8D516E98EC22A01277710727EDC50E16EA39BB20299AFB618345ACEE
      11A27642852DFC5CCA600440BBEA8303E6D5D94B18774336F41D99271AB02394
      D3C90C8B22425A52EDBEBC396BFF694E8585754D40E82175E7528004E095A141
      2A9AAC12813565C41569EDACF970B1B6D38FEC7E3EFDD8EBEA1B7620C4363E6F
      F702C06DC2B359F945EDCB4AB10A5A90A64BEDDD54F5BAFF3428C8EA36876C02
      F6249E75110763A1CA67C3295D5263A54886F794FC0D20D17F8AC3209DA9B3DB
      3900D2C645C10A15CE05C80B224DB118F742D63927C50B454F629D46FCAA8FD2
      BC5A609578565A4C1044218C64AE54B9A23BAD10D886DA2A430F54506F247D8E
      A87AD547B801F3BE08B854B834F3FC1D3DAB58C80AFB2B592F8164BC468B8FC1
      E0FA9D9AC1F4A818FFD94208FF15B5C532989C5B7A59C7DFFBFAD63A937AFE1E
      22ECA1C4E13D0660097A8DDB88ED294BCB4A0073D1381048C3B077E10521855D
      EAD899A2879C47E6AE661C0384D5CD9B2416A00D79B5067A305F24D445830BE0
      A1CC8C712F64D86D6E683983D330CE54B9BB925125E1D27CB40E4FD20915D160
      FD28C285F54276B0830F1FC4D5327D1FFBF8F98720FB7139820FB2263C7C522D
      1A5FC8B6822F64DB420D8D1D51813F541F56DBF461AD0F3733EDE52A8BB5B51F
      79B1B6FFD1B5FBD691D53E6E93E28628DFB2264072913E36D87B1957AF7C7924
      A7933A2DFBDCCCADB7AF41A21F25C23BE718CFA34470B616DC7108543CC15B9F
      646D7C80DD005BD7713961A0C40837D4782F8B96F6CF6F3EBD7B79F2C67AFFF1
      F59B77D6E9DB776FB0DFC01BD9E8EE29AEBBBA4B8997A1171CAFF30D32A45A44
      E3987CE45C8A794EB241AE94953432C4C271E2A54FB3B4372FBB0104D740872D
      5A5EC081B9447A358FD1612BF9B8E5C7E465A2F85A0057D71D054F126FAAB0E6
      9D986297380C73249F109532592ED840D9E2B670DCC08C4C24D8762F908AE71F
      090CDC3DEFCBC9E957DC650E8FCFF3F139836AEF34A60094AF8BBDA7B8F41B5A
      07E64D11F63E61946E82BA2DE81C7AB7F35C2E2C68BBC8AC9F3F7EFC54085F7D
      8AF0A882C62889CF4543BBDF1D37F3696AF97B7887CC5D2F74172662E26C8203
      DF54E058215A1C25456B1A70080076126D20811147E54AEB7FA423208BD8BFFD
      F2BED80EC5A30AFA209A06D13F40C72641A39888F5A4965E4D0DF75E075E184F
      AD2FF12218EF716AC8CF7112FAA0668CC59EF5034730CA008A0B2CB89C225B00
      C088AB05DCFE14C151050CAECF20CB9853BECC19D5E0FF2CC6682592B4F2490B
      4693FAA8B967DF6DEA89A2FA49922D39400B1C550B28588A5587344F255FC986
      64D26D12F22992B6B50DC93B4F119E952D64C802A974552956E771B2636F3C13
      85CC216EA128836BB9EF830C0DF68ACD5D9F22842AE0531F75FCEC3BB6B84EB0
      2529406373BA974FC1AAECF600E48325489B27D70AD0C819710380BC172A28C5
      B12C1500079D462BC510FF8160AD9CBB6C0748B7283F71B78210E0F3C3CB41A8
      EAA73B2A553AF6D21D84B6A69997C99EBD6CFF2023DBCD9B7E7FA5D6DF461928
      DD894E78787878A8AE5CC0B5ADD18396F97AA2567676EED403969D71C693A9BD
      13D7D6225E2C430F7388311B075D98254FD96A903872F8858817AA2AE282D2D8
      75968887456C8E3047DA8F2359042C57E1E0299F8CDF70597AE88C3BBE4126B2
      7275A2AE239D9D23E394DF10C1CFFE77E977412FB972901F16DDCACA337E1360
      55018BDAF7521BA9511C72E10E32C52292EDAC9EDD1FCAC3DC321EE6A6B0FBA0
      D551430CAC97D65E0E96BDBC87611EF34DE996BECADD11F39120F616445A1FC3
      0AB85B65EF709A6C39AD13DD3558D80D0B664C136FCEE194C7C878A9CFB30AA7
      D97B1D634E227B77A20CA45F59FE628FEF1BC557B92A081A4284026A93FC4DF5
      FEC992E28DE9F5A97C0595C3DFD0E911A1A4AA6FEC8FC4D843879BCCF682AF64
      E9AD9D7577DCDCE36DEBB3E9F4369F4DA7777767F30B056701BB39C1C02CD06F
      CC112DE6BA7DF978A2C4CC42785C28261C1D573B461E3E5740637295EE537C1C
      C51A005A9FE756BCC28DB03907AB59DA740041C49D2115F0D6F74FE3FC43479D
      BF8E9738959330189FFF59BAF2BD01983FBCFDE5D9770A57103D39AB942C6F32
      B1535A8565D5056D8B6BCC267E0EFC6CA6F0165F814C83CEAAA76CD258EA014B
      636D93EC7B8636146B5F590FEB05D7048D8A07B243F1FA94389D15BF4D449AC5
      58F8E1929381B9E892AC54E54DBD60674ADC13E204EC9631E43F97D064B36851
      6A97A38B6BADD06AF4E314927F1F9AFABE7CF7C5FA8B75F6081A563D7B88BEB0
      275F3EBF83F59E3EFC7AC97552EC252E8A49470FBDEDA7ED5D701F4D66C92347
      F1FC58485F3A95CE8558A4123A1447AA22E495FF087EA768A4AB7D559C52ECD0
      CEA0BB33F6AE015C2441DB80782141272BDFA87168AB90942502B70E6B174652
      8F3AD4354C52591754A892269B8790CF19CE5ABBA1FF7F1CCF0D5FCDF9EABF62
      C4D6C41B9F8FBC645BCEDA08DA567DE10459C2932B64863B6B20201959EBD0FA
      0B9DC0A34A72B3E64E34C5FEEEEC847E7D8BDAFE5C18EBC74A1D92282F979796
      1AF58C96184103DC5F838EF2FFAE95B9824A309101531609CB6649BC9C72C98A
      3D7A628F1B616222A0AA49749D6662CE97F683711CA91ABA25A30B0660147312
      2F65534C383D178147D7D5A438B02A6AB2DE4C9771DAAAB0DBDAAB0AE358948E
      886D8C3C2EF28CA5EE2665253DC3679B1B7001B6B1ACFBC16F2558A95AC8C5B9
      B03F89864FA920722A10AB32159DF38EC218F67D2F39C7DD41AE0EC00EF12A16
      5CD735C859FF7E0DB759FBEA5B75B77CB87833BF701B08E2FC64208305B03AC7
      BDC682274A82E152E0B2A27C29C994BA9E221CD53241429A711D4925B33042C9
      E1397E036181C14A73616A05343282023E799758921003385134848339098331
      9EC6305E26866696692679402E1966EABC6BD5872066A56302EBFE88AB26B2A8
      1DF9083FA666A9BC93A2AC50BA6FA23560CCF9D5027626C078484D62680B0FB0
      1ECC3D9D7936D061C999926769C94D848349805E1A39CE0B7EFE80C7A3EAAA79
      BB03B5E611F547D1CD2BF9A22C89951BCA159545944C83266559EBEDF53071D4
      A7348663DCD7D2B460A907ADCC02DB401E8C4C95AB3ED98D15168AA1E0444114
      54A5074A763888A7D35026A1902D3D0883EC9ACB2FCBFBB3380E2521910F4953
      389C51E0AB6C7F071E3B0A22D97C801D48BC6D54546B9FCE27EF209F70FDFD4B
      18657FD460B9AB07BB792B8A9FA9B00FAE30C7AB39D5595960CFC7729E7231A0
      798C95AF247D6070CAB0E643292F666C30A1FBF64B4B7E515CE0811A44BE5F02
      3337C1189250BB893FC2148F5E7F7ACB9CD050818D52822A100BDCB90CAFA250
      2F53A8A64D3293236C6A87EC1F98B0289611D72645FA62020A1A46F0A6AAF8D6
      7F5800F7FF4FA1BD92425495D863DD38300CE641A69BA7CA4E4A743854ECDA08
      004CB3A77CDF98B43F11AE48DF380BE6B4A509C2D9CAD894A9D41673D81A21D5
      DE8FDE7CB44CA622D9B3DE834E688E5B21D24AC38640B35711382C2D8F2BB686
      0DA606D905488E822C09357CD2C4C988B8AF9B6A1E48E68459DF544121023889
      F4FB479808B3F35A2BEE23AFB5F22E4692F52F227D8F70FF6AE7FF833717EFB0
      E8D77E30E1066451F6240BB76095EFA7386F536F710520EFB17B1FDB7F33EC3C
      49C204F1FC2812982EEC25010806FB7F2389C11740686BC7F465F286AC334772
      7CDE8EB8587D2E05927E6D4D45961778A4826F458334C7A41AF1A3BEA4E8D93B
      E52730F8BDEE42E17E3ADA9182A8851043E17F53A3A4FD420D67FCEE58A42156
      D4054123D07600AC6F284D7D9E6C9C2156C66EAE70AB27501599C7FE120D0CDC
      47A289CEA17A809263C1B3F6C8D6B787450DB2DC3848F9D8DCFA915B22E2015C
      2CD46314B5F7E6EAEACAA22A09C7D69B2B8FF4823028F6F6E196AA52029B0B0F
      EB566A654ADB365437A3E5023F3A9DB6B5875BB0A7D7B6DF6A5147CED76CDB70
      5B83AE9EB6BEE7F44D4BDEF6E6F4F4F440AD523655A576955930075EB495C348
      6F7C5E1107C8D338E3B645DCCE92ADA57A26E853A36F65C7535C8BFAF250624F
      9202890CA641962A8955369E4482FAE1E3172A2110061CC1E951150E1F2BEFCC
      8348145FED45D773784773D429345941271792592E044D4129DC9C9543354938
      467533C7FD49DEB093B3F9E70BAF49012EDAE57D24E7289663568EAE6147D1A9
      91F571842546DEBE3E546DC7A8688B97432928B6E73C04FDF77FD2266B7C0525
      9CFC8F79A1975C57DD705CB63A6AAA30FB7873140276EA5CE8D2480DFB69DE65
      54C2D1DB6904480053DD451D7102BF6EE2A50E015109C27CA42B587700E718D4
      8B04D332BD55769515A2BA8B068F9F52B1F4E3A650BEEB18B31294113C7CFAE8
      689580CEC448421D4FB82E4BD200B0925463F9BB941F461F01770127814F16F2
      207A5D3C1BF27C16A9BE91C3EAF6F5143B1CC2C6F4BA461CAB824DED8D00BC62
      7FC442337BEA74A77C0E987EB78B8677D89E833A1D50A7BBBBEEBDD228E25BB7
      5C50EDEE1E9E434DE25E7717AB07915CB3E6E67DEEA878380B2844E8901C22FC
      E04451D1272A7FFE59909A3A161C5D45F0D54D5C542A2809BB454197750B22E4
      67247E5D9F05574083E7BC33FC35876B25EA05A9A6E022A9EF361F27CDA59B75
      0284F39D6AB704976392F2FE2206FE22D5FEE83A0641342F99E9C9E561140177
      960CE3F81C85EF0DABC437CE97E3197B41D13338E6A658B2642D17D8A3600A59
      C3AFF1825EC1D0D8E416BB7179305B6F1E2FE117BC882ABA722075CA1B91C876
      981394A97181B2685761972DAF3E4A0176D9871506936B69798EAEB96AFFD788
      7C307BD685172E15FF5CE9FB6E98642D80F539F331CBF9C42397B0E1939BC153
      6C8E2BD56CD6E9A8DE1A10A509C50ED125A2321CA2C7D5D858118CA31011986D
      6C233C15327A94F5D493CF27DAC94262271E532C1509078E3B4D52A641F3230B
      0B60DF21BD38AD3F71D2FCC77386590191E230018C264D0410A590AAC3A0628C
      872EB23AAD56A957B532E0C474FC4BF43BF388D2E7CF3AA003635DDCEDE24C25
      0DB3B0B0244773D044F556ADEC13435836B8C6EC0E621E726687F8A998D446FA
      79736E96DE8823F53C94825BD866550E19E359ABF493E16F28FC0F7F7FF61D11
      7A02B0B48C15AD1E9CA5C27808E095B5555078CBB8E0CF046827486DCB0CAD25
      A325371D57D45AA6BCA8A6A98AED209FD23D4B18D34BAB8C6EB589C553A1EC61
      051DF418F6936FC1DD420CAE1D5526BE52793A223A38B5BDD75EE629E8118113
      7B7C2CBD71B6F4424E26E73781C6471D8CB80E845CB16698806DB758A00CBBAD
      B26E00FB153BB66FBC8639115C7661DFF85BB1A1A31FA4887329D18DB1A43B3B
      04C83BA0171B123AEF5DAEFE1BD6E37A2EADA0C573927B2BF9F0527B68BCA864
      E05DB4D9D6E04267E4C327A12A60112C8AC092DC58B19F0439E12E2C5B27DF0F
      7F43CA32FC7D17C0219A2675078A48CD2164A4E35AAF2C8C141CA1DC43DE0E8D
      4BC892942D1C64A14A09C008D24586B848622A7C1D17844229953529D78B1D68
      2A452D7F99907385B374A50B4C24780347C9CF712BB91022EE669A3B37380890
      7C8CBA91709EDC75F2E92B463F8942793A69C6A5061FB9368CE235B69043471B
      4D031D6EC1DC586A1B84A515141CDC16A9FA8032D476CC71AA3A4E0C1EA92D16
      75C449EDE3A83D6839D7CB23F195EA591079CBAF926E5FED125163C8E3576C06
      414A56653176732AEA131CA98523405B770BA68E52B12F16F887F169AC855011
      D5900E7755B6415B8CD9CD463AA20CBDC0B544D3A245F6E587B3B7D63E1A5F47
      D7A037030369E23DC4C9823289995C7248C92164AE65AA2BF1AB10EF7C17F731
      EE83BB18649782533978B054391161A6341B36741EE0A1A34070EB13E6D1C6CB
      14DB66A42A7585431066A03850330D0A5187D517DB9F73FF0936C41440C61EC8
      C047611AA5451DD84150D13396713852AF7DF9A14939A57A5CCFC7973428C410
      53F9962DE32F0A3517313088B2EF56265D58106B52AAEE31DD2AD3EBC6BADD9B
      CCF59475EEC7A197E26D3053B5DF5BD80500B2D28887B6171053549EA2320E90
      E13E54860939CB94AD5654B69956F91CCD55D801037328838822027D0A3849EA
      AB897181140283B24F6C04FFC73353D2A4412D37E27D122B0C3D2EE03AA6EE60
      2A7B1E74BA76742CEA6332F5D07A8C76678987262D60435A40E791A705FCC08C
      546FED91A4778803D24D47118C9306D883226A842CFB306F3682B6424A9D3AC4
      601C9144F0AE288F9EA1C839B837D15D59946F95DAF01D3F42946A205EFCF4FE
      E56B549D17D89A958F4E76BD1012C8E41F4A12EF3A3F521AECE4F21157B0583C
      6467E7D7493067D385870E7BAE5142E530E47E4903BA327CE7C281E291968736
      DA2C8828F22F3FD6144439ABAF001BC914B815B6F9A47644E6BEA04CB501CDD7
      41892E0DC2D41D34473996D3D941694012292FB9CCBFC4A42065B10281F724B7
      FED9775F122F4AE1F8906BACD9FEAF1C2549AA244D52E21645F671379D29E7A0
      A6421C6340AEF571140620E545873A9EA4DD60A22C2EAA27A8741830598E902E
      4D15262542E0BD856A19732C4B4169B829C691C835B06CBD1EC5C1B32C509708
      4B941D72020915760672112EA9F44F74AD30A000406B5F014D66D0B2F7B10CC1
      FA53747F16FCC77A8A1A7051E11FA8D082FC71EE3C8BCECFF07AFD441AC9754D
      8E29F8E80BC7047564AD36D94EC7B1F649A33AB2DE7919F63D3E28188A01A163
      904C122EC9B44C77E2D97CF6DDD1787124CD1DDFFFBB9AFC7F3C3C625F926EB0
      0300EC72D1D8BA820BC03DF8C297D9A4BFA3F8582F3F24EC5539C6DE1BBA136E
      322732C472FB0805F8FA7A95940E499193F24C09E2368DAD30AB22359598583B
      DF9201011BFCFAE5B47F2CF559EEE921B386CAAFA7D0D65583633EAE2CCE96E6
      42028780E1E81CE402EC91E5630DB14B8252225219CD42319CCD17BA2EABD252
      C9FE87FE4CAA2D551FF31AC9842169868E28DB8B338916E86F93420C722BFA4E
      FEBD8360841DB36A632DAB47498945C65096C789E7F2F33ECA66676F38F52E0E
      7D16A48B65334AA790CF33CAE4D3088FB9B19A6DB09A751FB9D50C5E3F0AC620
      36820CD97D841B58BB008CD343B67644ACEC49AEE05F02145DDA81D6539CBFEF
      45412A17E03CC50588681A3EED154C82E889EFC10423AB9EF202A6029489E829
      2F2011E29CE7DF7E8AF39F2DA3A997046A0F9E24290599200C9E3416FDC35B78
      4F9C1F47717229A64F7B1B1671CED19EE4494033C672BA644C7AAABB902CD354
      E391FD1457006ACD13172CD24BE13FED1564CBE45CAFC035968B92E5E2EC4D6E
      A3A8B7251A23C6AD8C18BD476EC4D8A8C0991342274479E1DD924FBED735A6BD
      6F3D15FD477F2A1EFE403C51BFC06B8A28A12AE8D2F78521D7FA48509239D75F
      27578BA1303A747EAD0A0E55B19F15821328929C22FF7380EE631515B8A4A212
      B8C4834A9CD74D34F1505ADE08EE3AC0C47AEA6173AD527D4A3B62EDCB74A2D4
      DAFB4AF10DA5AFBFDFDB94508FBE454A966B5E6351BB6175657174C862678042
      8A03FA63396851CDB35EF1D70B51F11A0B11710092C71D7AB0F32802115DB5BB
      706EFE325E2887F3AF0FEFE04CC5982B90C8A67654271E0B0AA9B646B23869A0
      4BBADF7038F303985D0DEC2EFCB4FB6D077E393DB70FBFDADDAE0BBFDC4EBF05
      BF3AEE006FE9BA36DED26B3B784BDF715D7E1A6F8153DEA3615A8301DE64DB83
      16DE653B701FFE6EF75CBACFED76BAF77BEA9F3D44D3E7222EAC9E9CAA67A48C
      F6370C0669FACC3976A688A3BF75E13F43738BE997790F2E0A6DB7E630613C18
      3B8AED79F8D21DC44F60ED412129719FEB313F380C103DEFBE5B6C9390AEE879
      7628035781F321D672EF390FAB9A6CC5D50A1895C7FF502B39AE898CE14120ED
      8F858C9E2B04560137F4451260B228716EC5E54D3C4A13B993241E053243E4CA
      C994243B6229738E635302225CD97BC3FC64CFDA878F7B24776955977A2CE6D2
      FB84828E8BC1751AD7756BC3F99C7253B05EE0FDC4C7362966137EFFEF6AD60F
      1F217A2C9BBD35A98641527F9A05C53676B2CC0B51A3F432C8A8435E3148B110
      C4C72D3129AFA050B59C229DB34CCC17B4C553514E5BD64F6BFD601721BC1858
      F91FC7A02DEE26CAEF305F7DA0A2D9AC73714D0720CFD65025A0D3B57B280D02
      53B03844D410E9EDE3580D952E53E9DADB2A7AD26EAC494086975588AB6AE7AA
      755E4EDB53496BB81D44B28CB0EA8D24E13A955C368B2A759DD94A389AC09CB1
      3DEEE6D9A196BE8C64573E15616A053AFC9A23B8F7C95771FAD195D9511F7B5D
      750302036EAA9D4A5F9DE08C8AD389ABB100522935ABE3836D56548237078673
      BECF7ABE08D57F1827C2CB64254E0421D92A74C522AAD440D1D7B240C38353E6
      3CF6FAE1F30CF224D57215C91DB0A7E35C33DF418A0997B138B6C4F1F47817AB
      E738E6FF2B45C35DC2828B7CD22191C926AA458A67216D0A05CB9A970D4282F8
      88F9220D928276D6BC10F866827A293BFB0669512CCBF88C93CEC72719332DBD
      D01ACFE2604CC9153B52B23727573C4C494C59D23111B2BCB23669E7702D3401
      CA93EEB8D4CA6D399311C9AA39D8864C682395E5D0A90FFB5F055FB9E852B1DE
      D206DA81AC8ED3B756B3B328359B317E91C4D3C49BCBAA88FB32F9703BDDED6E
      53A977A9BB610B8462F6EE8D2686FBABC9B05B13C3B3EF0E881D7172A2ECA1C6
      4CFB30473EF2FA61B9BF95888442FDB9941013EE137E3DE8C981C8350A41DFB5
      4E8AEDEAF53BB259122FA7B39B29B3ACEAABAA9CA58CDB4296F25C0567506D05
      0EEE12AA519CEDA26D1533B7B2AF77853D664532BD8F54030D719AA01CDCA682
      D906C772B6A92E8664C1D3301E91C25950686A5FB38F7BBB48823809327EB2C2
      7C7550E0E7BBA8EE3C5EEC34913E6E984C7EE7AB3EA22DDFE9DA4B26E385AAA1
      BFB1B6C083F8641F636D81075978630FE4DDFB1FD76A0BEC60F9701A7641FD4B
      FDB09008A379EC12256FD5BC300881781EEEA08382220F770D96069237054351
      2F98648B362E25AE867CABBE86B2EC995236D461016B2C1BABAAED80888E0D68
      AE8BC6BB3F9B4DAAC64EC9903AE4F0215FA4E32418A1FA4222E36437FC6DD765
      24B630DFDDEDC25F27DE348E467112DD23CA6CD12A908A7E65C18508AF0FCB72
      EE8D522777E62A5BD0297642498AA44F3CF841FC771016AFE0BFFFD885893C8D
      E78245231987C9676D412AD6FE7AE7F5837223B29DA023026B077225EB2D3B58
      EFEE04A9E87A35948B05AAC31A52747F76120C9BDF81D320B76F10CB0AB16109
      B5AA732DBF49D95AEAA74EB18068CE0B05374368A57580BC4F9AD31AB45BCD74
      92AD42048D95BC41E0C2D41211CCD4D43B5A71E7EBAC27091E2B125E52D18884
      3205B01906463115BBFE8090285DBE6489DAD828C384A33F0095E1840F05FFEF
      55DA75D328737E7C5A2ABBA99B2F7CCFC535D7AA6B6E3738CA8AB5B7AE7A644A
      53B0F3299C5C27411806E32DE7407507D786EE765A2DDBDAFFFAE5F4A87F60A8
      84A2123F63A4D123F1713F8CE522F771AB46B59AB2296C59EB4E0A94D1D0B707
      48B769B5BE6FB57EB55E79E3F369122F81BF607350917C6FFD22435E24C93B3E
      FBF2F9ED871FCE7E9567BE29093127DEFAB9BEC01015C27E78A2B0A52DE48E13
      6D020A6F141411746851EB1FD5A1886BE7C6599E1F6EA8C03D5281DC3CA623DC
      2A8EBBB54F61160A6D0E0C9BBF89CDEBE2F6E8F5FDF31D700E8CA0349B804EB8
      A55A2770BB85BC0D8261F70FC7EEDDCDECBE602217E9FC57EBB47634B4A9CAC6
      99FBD449F3FB9783D37EFBD5E96963FD619B09DD8610DDE904CE28DC4C76FB85
      291862574DEC76620FFC2FF8EFCE63141A2C3F4FFA037246724CC107B191EE35
      89783784F16109A3ED6C2603278B8F92C87C116906A46051418B4E9120FE484E
      26EB758E003B94919E68876004BD85E724015A12F9A1A1B52B56E6701D404475
      47D869371197499065D87337C664FD4C802E45080A28E961F22C9A9175A3126C
      D4EA51DFBB79805D3888ECE42D588B8DBC0446B7B28BDA5B6F09D2D8FD7D5650
      F20E69B42F6FCE5C4C606BCB04B60F3F1597B85A05809CB95CB1873AD1CB565D
      3048E7C5D9D91B1EA276161FDD3C625CBEA7A15DEE6E7DA38B7009504D8FB3AB
      5DC4DAE6A053352EFC58702B2D95561444801E00FDBC3BBA647285991FE816E9
      1296B8ABEB0F72645728B0D9A5DACD1D840DE13C699AF701F4ADB2A734BA62EE
      A6EC8AA6228A1E5E5B042977276A220060178B0D77B1589DC3592F5516FB3765
      1867C75D9B9032CB709F3767EFAD49E851493299C81C4CA4BC390FB8177A2102
      66ABB0C11201BE5595C67BDE41FBF871146B1C7C63B1C66FC5F4DF6A2185EC79
      F8FB8DC7FBD6B5841E21623812311EBECCCAD7850FA7B4311DBD53C27284CCE4
      0E8AA9BA77319BF671B302D41F272007065E68BD7E7782940A5EE4638083A23C
      47450EF90851CDBD1F541BFED600D9F854FFDF9F3EEF0CDFC841F8D3E752F95F
      D7FAE9F363C1C24E432C3CA120F638B24EC2E5488A61413D83AEC3D6C702866E
      4330286902F3CA09088F6501BD860B88E2E8A86A11C67260BD9D58FE92827450
      B6C3DFA0DC17943AAA2FC0985CECCACC9997D2D08F7A1DEB897124B84C2A95F3
      FEE7924A48CCBD34CBB344544FE610CE977F5D8CFE6099347FACD0029A5F1324
      69766C7D69A0C1723BEE30BE4C37EFBFEC46BA588621CF9F528982082E2B117A
      04C39DEF2AEAF309D9E5B0DDFA7BDE2A9DA76AF9C0BE63532361A5E4E52A78E8
      E0A8B3B6AFF38BE57D983F55369560A53B723751B9352FC18A75EA3B79883D2E
      6ECD472E3DB4F6C6F1E21A15C4E3E363C2EF3D36F405F320849D89170D0E9348
      8811A607B939B16044D496C5C68A2417F146232367337BA8C88A8B001089A988
      3CB9D7F1922B7C8B15C2C08BDBB28836EACDE3385CCE23863B19E63F1261DB9F
      065A7B26BB27BCCB4B619F64B12A2C3A18D0C649BD99E8E1C1A1668EF8E91D2B
      DDFB93B20507EE22CBB57CD324AE9D6EB2B2EDDC1FF5344EE66F5F5B9F123109
      AEB6D2D92F022E98A83045667C001D04280238E5264454F25BA6A25168B2DC94
      C62F7B2F5F40C62A6569909B45E0E7603EFABA9968EA0B4432FF2E4554A411E7
      E248D65FD895650BF6E079C6257BC4F87C8BDCCDD3127D505BCADC4CB15239A6
      FE96AA4504735D0DA4F625340059F357CF9CAA7B4F7BF8CBF1AFAA06170A0DBF
      FCD7AFCD4B00FF379C6DB264A932FEDE0547B293850953267DCC6C4D4596E2D8
      2B4B6AFC9AD7F1125F70024B3F47C1E4244BC2BFBC8928731EA1C22B8D23804A
      A629742E7B50F5FB521DC17118CBC2354CC319121FFFDE7846E415D7A47EEF44
      93E706E93A44BF415412B0975E26743601D14B4D2EC991725D2AE295D788C315
      61892D54AF817ABDD0748BEA7AA7B27102B64BD8CA3658B9AA7CD248461381FE
      A3B4C009811124622E30FB2A3F0546DAAAB68D90F71836EFF9998621B286541D
      556B168724029C7CF9FC8E76C3E73330C633F0DC48643ADFB641A51BEC1AC239
      A3B704772E31510B896355819B48F6C40BD32D8E18BB80501BE329B19470C86F
      5605F96722F4610A972CBB94C81F33096F8C453CF320BBF732231D7E5B3F004F
      5CB0B7751F9605BCF23A1407B2ACA05E3F6624EDAC8EEF133AAAA74B6418C877
      956BF3783A8B619BA48BDC1C45CDD9182E794A88726CC18E27D79CC7BD2FABCF
      12831A674B2081849788CF694A15D8038A4AB806CEECA37435F3A4202B87D74C
      B0B9A232415E880978EA65D40DA7305D183448B3C3E26BE83246B14FE1C92D24
      BB37BC3E792C491E62118347FFFA563AE16B078A3312B46F5CBA39B6D576DF92
      6A1B272876027124DA989AB3BB41E993A041939B358183BB4C64597ECDFC00A9
      B9889DECCB15A3B21DCC651563BC6D1A5370129E772B0CB20C0F1B5E296ADD0B
      D041B6D07C613E301C49BD599CE9A26C330076AA585F79570F73F34974CD4230
      2EA75E63E702819702CB8EA7327997DBBB312EE1E90539584CD9924260504572
      0E49EF66151CF5ACC8A36A817A72CD0B88E867782B2EBD6BE4F919CE8AA14F9B
      32160945F0ECA361F43288B00FDD810E99266DCB9321A9CA5430E3B222FB2331
      F674DD4EEAC6A06C0B12D02992E37819653A1C8CCA9850E5BEB449E491B40A1F
      1C5BAFAEF1B504165A08950CD7AF213A1FC58449A0CB017C40410B16A8140554
      437102224F06FA4F268516362CC9F5A8361FA88F089C2C0A62D2C873814A10C5
      C5CD38657BB9B8CD0E506116645FB80A86988475DEA2421A976238DB018AF4D2
      4ECEB0DFE2A5A024C31B659F1C52DAB18032C0A001C0114C29B34A192798C621
      06D5610D198C0B94953071DC5530CD74B599FC2491564DEC070D4AF34506DBE4
      5D0453C67B6DE7E3C296980A72CD16C0BD53324791028B4FAB2D4CF78E0B92AF
      ACA24446507C6E11C3A9D2A7169D0F78684179A7262E117367D99D0F41840301
      417E9E4A2747DA2453B5011469D5003A6C161344B93D41AFC2A2834350C5EB38
      6102080552C2A12C4C9B96CFFB19611967C2999BC043946EEE9DA3BF26630A2A
      BCF45A7A54000EC4405662F10E99FE08654746738BDCEE2C5658906312BD8B35
      8309E22AACCF9B2215A1511A4051D4C339624782442498059D1C3AFD488E57B0
      CFD4E368EA99618274B6E27C30124CC97645F1CD799C3F995229C858B1F04369
      16AB04A8CE56972732BF4A4752795CA48731D25EB3747D243C662814CD63AE4C
      4C81B552B2DAAE786D3E095D3F3BF7B61C5A694C564364567E807D51E05C8BAB
      85EAE613447E00920CEA5AA583293D3241C2D58AA3ACF9A4FE5BBE6E22E959C1
      CF802393E318A85780D1E901695B2AFB574F611BCE780D1C75CE4E350E905426
      66E21ED2BE8C8CE5C283DD1985A6895CFD79791321A05EBC0E5232DE23443F8B
      B0DEAFE515F428437DCAC5380B35BF6589FB9FE844A8A381D480CD7E74007D09
      7BACF24EBB9143F6B0A889803EB68CB4D50ED8B9427D14E7F2232D533F2E4B5A
      D19ABB9A39BE39200D23C78A3A9C41F7755F7C76195B1CC51E4B59B4684BE043
      503BDCD7B78DB9C1B3EFB8454E9252F80148E2B91FD5D1414BA5C827B14977D1
      CDEEA24231F6BD93F20A8E8F8FF7F2B317A8AE8FF9313FC4372203A221C82DF9
      3ECFF2D8A4324DE231AA1052BA60EF25BF74453081D7A452ED91795AF09E065B
      43AEB9F07AD509CAE401FB83530E415426126FA84DF8769D5F41BF452F64CA2A
      4E18C7E74492B202DDF3460C0CB818823890596DA916A7DAE4B02FD5E5BFE0EE
      29EBC5C1712541E5429F0A24176BE4D5BB79130F9509A101249F7D07120EA5F6
      A287DFA31833D4A757B75BB6445A25F641BAB2D91A9168D709F558C55681576B
      1264281100E9BC0E1220EB4F8C3EE3D13213B91D4241568AA6B2D53C4F0AF79E
      2D0B4A506497795E2B550E2C530747549CBE018CEA7BD4F35661A45001BB8FAD
      97643A40A53448E6EAFC2947B746D9F29120B88D84D6799580BB82C6FA3EC4F6
      DDB9A39F10AB5B01A0E1734542B78A5D7866D980A55ACE944E10324534642A12
      B5B5BEF3818D48C5202FF23A2BDAD3806E11797A1BA522C98EB57E2AC79AC768
      1784E59093FB325A2369408A4F96490A5F7F5D582FD4E7D7A4129F7C3E599914
      5AA674E5F8C24867B36092FD85E7A03A707A59211A58F12762A164DA92370713
      8E3F9EC8403E4903E9D5C1A46A9863B2A0F2E73B3107CA5760B4D1E713B56619
      C9565AE96BBAB68D37B2185E4DCB2A871748ABA72A32AF43AA711E122A92B887
      2AF05ACD96E207E694089EC330E5B700A0B1FAFF65204DFF390C0B09889C6278
      E9618F78D6ACA3E6CE9A371EBCB75415890B32E33C303AE976A9862BC7BB719E
      0D4D0BE6589E2CAD61D2B686CF47BDC7916368B7BE31C9F0FE33C975B8D291F5
      B2208A7CF8F845C7E36BCD163D20328A45E28F8EBFD594946358A878F7F12344
      897AB6C041DB47D6C755E14BA55AC85350F2BC3DC9A53EFBEE2C5E2663815BBF
      2A6BAEAE96B519ED5BCC9D91E54E1A32069A91407A9F26F5CD07E379490E2E20
      9EDC0EEEAB9466BA1307CD4D4E5F4D75951D3FA9CD00C88D185E47C8478AB0D7
      F93587E5A34685189FEE497BF6DD5B0AC0B1DE7DE43563D291DCFA026B2CB23F
      1D429D07E1CC551910DDFF6F1D1FC8A651EF00D3468F459CB206AB10B1107ACB
      DD5C294BE1FB5B6551AF80DDD932A7D5D9347BD0AF6B199EEDBAB7E778F47053
      9617841715E14434CC63E17C2FB944C3D16AD984529F91BCAECA1CA35D12B477
      00A9BA8B0377A73BDF60BD702C5E61C61CAC18892D1AA1C478594A5FBAD47E7C
      8A38C7385290F4E82910C2A36B1D75AF535028076FF570CA3E9E5EFE803CAE9C
      B1D768730A2F9B283FD4C697C94085AA777D99154D86A90AF5E0A19087D3CE63
      1B6E1881ABCB181DB9A8239374AFA49D2C9E4EA5AD8C0C60D2BA332706ADD526
      58EB5890F287ADC630B499833FF8562D31CCE3E516D1D5AF2452952378461C88
      595F998FEAF929D499061754F910B3588E572CDECA9447D6360CDAE003812E4F
      91182D6713C9DF4CEC1F9396F3A964D8FD200DBBB2248F367268BB3AC748894C
      9AFAE762D5E2A383040ADFC941F6E741B44CF380DE8327299C119C4E4AE17831
      D3482964C9D5A26B0853892800226A40521060CA8C1D068B518CB89BC7FE91D8
      37E2485251C8F7FE4085ECFC2033D4398F9ED864675F379853F6DBE126578432
      A6173206D7DC1155364F8E32C1919079F2061EC39353760F4ED8715290C20BFE
      07A2D8CD834468992A3AA43001F4EA7D268779EE97DC5B71C5A031B3941E88DB
      39A5AC5AE56288C42506CB91794E0F4E36AED2839C555D4E06357E87EA8C9132
      2E18077B2564E888AD14112CB525F5B4BD7824DB4BE5D9A2F960DB78785329EE
      A0075656DB50AE478FA2637323B63E113295752B4732A7EA73832CAE07AAFAA9
      AA34FD88BA65CF44D8DC89F2116377D78028D319A45AB2117E7C0F37E425E3A5
      A210AC496C93452F8320280C7DF354FC98B4C691E0540A74A55459F6691A914A
      0A1258CD354F95F2A84366C9CA63A84EB59B42266A98B89E75369A72568F97E6
      311B78D0DFD7C7052A0A80FE3A0C5FB3F62859A5229466A5255439D26352153D
      B34D6D120E1162676D4120588DB19046443C6C69B978406E4255F225118C55D9
      C9A3C8539D34AF9B6697E2E0CDA9ACAFF1806E54005CBDEBD69CDB2DCEEDFAB1
      647F7501371FF46496222AF2C3A8B8AE8E8A8A54F9A05C85D82471B0BD9DDCF2
      3BCC8B7D42C78CCA98AA780A73804A07A8BE9244B313C6A562295E034ED1CE0E
      5A31E4708D1BAE2AF9756A7D313710EE1501C69260EE2645A524BA5054A3785F
      159B08CF6EA9E1F3BC3651100D4FBD9642B28B5A4D71968549E0028BD4250FB8
      AD8AA6DD72DAE3591CD38BD906524AC35912B6B0DB56CD8FA282B46D420705A9
      5247C55C76530BA0512D00DCFDB33C3ECC903DCD8D57A153A644A8D15F5395BF
      3CEE318FEACAB5557D405424CC2E1A453DFB6E6D31FB5707F7D505C29CB86AAA
      0773C7FA61E5CDD833072F4F6A2C56A5AA0017C7CDCE6195C1519EE502DC8738
      5A64FD72F5AB3A6E1B4A54D5C7B2E435AC3AC7D6898C70E59C349F336B327A23
      19A628BCC54AE7980791F0FB9DED0ACB552F84946BDD682D272FA5A8BA8A341E
      CEDB59035D51CEAA30EE1FEAE21025BD5FBD94C200460DEA2C62BCB5AF430A2E
      64E6CB96B0E152CB3283631D2661300F5884C9E3A637AC1ABD635CD203FDF0DA
      8B7111781B64CC1B801A06E7424668186A57BB839F75572EAED3FB0B61FA2214
      BFE6DA6B8E58860A96C40FAE32B902A7FA605004647EC8F775E6F74DEA54295B
      EC604357B56DEC8B541A06C422AA12A2DCDF44B061061B8E26280EE2D87A8B6F
      CB9609B78EC4E7A91D9B4875A7366D6884D9F989379D2A02C50458F73593B965
      D6189384A5819202FCE98AA4994DCA42F3DB12984A8982297D9315492A244225
      4AF3F29F8B240680CF0B1E29B51F5BE4F6231B6414508766E3992944DC94191D
      C1519A8A1622413712555AD9845572242A5E55288498C8C8E22C5E58447A7445
      56854B20E53681242893AA02024627F06CD88F45DAE54296E03624B5014955C2
      87FC9D22BFA28A41867C2A2071393015E186B0A1B0A44D75B9EF5BF33AE2221C
      72AF76518F1B2B0DA16717C94149DEA39971534B39BDC6E4E94759159693D928
      DCE96528D3D9EAF3F054792B59B58DA53134BFA9420C29853C0693D2E40A2130
      34F3E63C295256B9B1974A7B52B172168FAEEA5A72E70FAC95C3D980AA3A98BE
      D14BE404247309D0CC4EA74546BA1B2A56CFDEA8A237D7E491C149867A15F35C
      C7F17CCE693B11999A4112A1FAF479253B69FC24036E93427839C0D128C5F160
      988854AA23478760BF50F45EDE18505D25315FC4009DEBBC58ECA5C71103CB08
      742B799E31C303ABC8FB5C698DE24848060AB0D832278862594225BE615614E6
      0A0B50F540D8F1160BD5C5461FA40727DA849FAF095A6700F11DF4A865233785
      E77914E0121DC5AA6FDCBEFEF437EE51CCA5220E2DBA5E3B383EE887E3F4D03A
      39490F4AE90BD8CC8CE3D2376CC7909071071D0657B7E37B0FBBBF1D8EB09DE9
      E1189B93EF7683743DC452746F038872820565CBCFBD6B3865E370898533D5F6
      AEF8540C43A9DC8FBD338CFEFA1A5170ACF56310657B407B16A1371669AE98ED
      913D1151684F9A180DD7C9319AEC6D9B0089145D7AD7A4E2F751D6EADA8FA94C
      825CF901472970F09D4C0AC1A0F7A51C4D15CA05E151594AED968511FF19D534
      19A1BA0A23CEE0ADB928C6CECB65E4CB3CA61FBDF968996059DCF7546848D582
      215E22DF244343B1CE20AC868308311E30679FF2CEC642E4894AC4A9976EB118
      4FA0022475DDB1658A7506A9EEF96AE5B1ED278103FEF25FBFAAEDA0D761F371
      4C09257ECDB9E5764756234A258786EB68C7060A04E8868A23651EB07318271B
      C5F1BF847E5AEF8D2140CDF472743EB3595A65005A82BB2310B091F01882939B
      B8F65680B6FF0A28C38182D49EA432F5C762A54AC8BE5F70E064C952346FDB54
      D98444CAC1AA10B24C6E9A576FF7BECACAE162DC98BAA78A1B632A292ED49CAA
      C611C900B292F1D59C221D1D5A6C81B3C94E4DB67442632F131CA61044472419
      514A18202D22EE5B2CDF8F1DFC5008AD7DEB128B5770B98A8343EB14A4E08CEB
      069ED2410844E8CB72DA586A8CDF9ABF8C2BD652F313386BB0BD629B46416705
      DFE4A695F0DBD9DC1762010CCB4FE20597744259818AA32F626ABE001C595627
      D817E45324C3182FACD80F72B69C62C38C7D6D8AA75C672EB3EE4DA32003801C
      A057D22FD4D337E7BAFA5C33996C503989F71577C49CF9A2775041B0002090C6
      A9AE1F4AE49BC842B90A23790D1236FAE08139908402BBF4A416F710048E1570
      ED3152FD4789F0CE65395DEE289272AAEB293B943C58AF7A19FA18CD41A81782
      B04584AC166E103C170D91E0223D651B3C9A1F552F0DD5DF856156F47A8E6781
      D846A5DB63E0AFB49E3851CD55DEC580F9E95ED11BCE7D3B3124E9C647536E42
      CCEAAE5F6EB7F2CB3853B7E10BD25FD5D3F2CBB73EF2A5B1177E89DF9355EF67
      00A87AE2D0CA9FC6EBC5BF79B4ADD20DDAE575501836850504197AAFC9B3DCA4
      340A3B9F95664DE995BE72B8ADBFC3DAD7AE6756D3D17C765070641FCB244B0E
      0028F9FDB3623F19FDC0A1259BA791359CAC712BAF204B848A16CE8A45F965B5
      1569A0CEB829021B1E10E582724562CC33E46DCD9F6880CF4D9CE41650B0713C
      17BA285C14FBA5CCCC721DC4E22258D2620D1EFBF16913BB1C8310B0905D7929
      00959F67CADE98D7832ABBFEF30E41EA066E012301425D15122FF727EAE35A00
      E62289B17FDDB1258EA7C7EC1F2C74C59137E18A1B40B1DEB21D0A2FA296535C
      5021C6C633F87AF45960AC1E21228160A24F2EF55EE156771287040525AC54FD
      1DE3D85B101732A679059C92D87458155B86F7EC4DB0765618FC0BE362F63D2E
      B1A4E90FEF9D777DA07AE2C08C54083FE1A69F4766E4A8A1EA49C79894001404
      70A951F00B67ECAB02980C17EC6956DCDD4BAFB02E5511206F76AE4E0C0C3226
      6F29B09CE5385B26D87547DA02F729A24E7638C2989742B5664FFA8CF242D2F2
      BD8998030B48574FA8C77B4EDD01C85E9866714CE210751A59223D57C17BD697
      BC3F16168158A65404DB635B5A036C0C6AEF4875747854A8F9B469EBC5159533
      61AD860A879383AD883D6487D80EFBF68AC2051DB2137940C8A42BAEB08015EE
      5CA1B9029B7F99F3D08EBE13C0ECF77877F7FE7389E2E45991D771FC1613D852
      74818A97DD8A23EDBDBAB65E79A9F84C48B0278B719383A4F6F9517CA5504E06
      9FA98CFC42F828478570834D0E4FC3C631FA8EFDBF59A44F724D2BEBE4CDBB77
      883ED8306E824473AC6EDDC2A4C484A0B0129C685E03FDD0FACBA175C400FE37
      EB5C5CA7AB6DDC648004EC0DA7FBBD0CC3BD43FDD70720566A7FDE461728ACEB
      DC9FBD2DBA075033506E1993931CCD46255991028F32FFAB4C6175F4550B8F9C
      5F291988EB8CA9F61C3287085E85274ED660F18A05DEF546EA022B542B876E94
      0E8654E8D1D57B578AA45014479EA5BC28858D18A5E4065B36C8D2326694CB4F
      184F596502A13E2BAA2EC6CDCD405381A2B58AC91A0912F9D0BBAF06F4C26D82
      6D036632BAE62646582E83D0279EBBB687BA6D25460DE8B6A06C31A0396F119F
      AA2ADDA6DC90C3A778FA3DFDDA3D0ADF52DD8581A85E638082EE6C08BC0DC035
      838934204D739147D2AAE4C462AB3F967E8BBE7619E89CC62CF870F82F60D4F8
      1C781CB253048CB601861C100B3BC1E679205528B0C8777AD9B62D2B3F329FD8
      B4011A5B68972846174BAA14B6AFC0AEF5102F96513E9CE255F94AD9B5B8D7D0
      D85050F6B60E4B3E89130AD99A8A4886EC7236CAA6A5CA0EF2299D014A959DA0
      11295B4685D62D128B802080F8C344DCE3E6299CADE159D8A218CF146812D384
      54098C31D7E975F835475CC30490A1A77CF0CECEDE184ADFD8BFB22725BE5354
      12F728501F3F5A3F5253199398A101F649859250ABDE06B48B301AC397589603
      AA878E044115600A302F08580AEAC7D62BD98F58F57F25C5272647E4FB97675F
      807E8F3435D0A17D05AD4BE68BD1B8E4D2788EC70ABBB6178BB9A28E7528F50E
      129F428CFDA3507D2CF1182F135D84621981A622D347F19812E141595FB06687
      D57061211175723CC07378271D2716225EA802547E8C960B629E1EBC572C94A6
      07F329D01522E2682442FAC0F1BD94C34EE9FDA5E0C286C1E4B940AAC35DB4FE
      88260419CBAAD45A005F717B55DB26A69EB273356C2B56D7E2DB024E799715E2
      F75EC2773C407A73A3AD42458426A6BAD5A2099BE645482656A746C55CD3656E
      2B138506D552D34A09145A57D22D97D44091F5CF25A00A39D6097DE46A492F6D
      B6DEE6EA64CCE74EED8CEA42AE2A31160F1F75FE3B943B3D5F368860D7BAC97D
      2617340E8DE4C5D05A70090F1E0D49DAB2EAF90C7BDE081094E6707721BB6FFF
      0E5BF2339088B7F3D7316CF40E42428FAD4F58FF44B0F581B11B48960EDF963D
      AF85CCBE20F1C8572DC822EA40A62D137E6C9D238E5DE208F44D82E5D4616146
      ACA9578CE620105EC8481CA6B464164E63D23E5863184B6398A44EA6E64FC131
      96731FD2131011019D65910BDDDAB9506406C5FEE68EB733D8879CDC6F74B015
      6FB1F689FF60F3A675F5EF604F7327EE23AD9807658EE326376FDFB8CA885666
      565FEA8FA65E1A044D8A9F254325B33459F5E497773977EC3FD42E64834A5B98
      4CB604AE06D09BE4765DA44E748D8A0D706C3A49035282A4F68E398387A95CE8
      A00369498D8490CEA8512E7021E1A3BA3D2022A2BD83C3E00A521BA050134125
      41C7C552C5E7284BDF81BC1A621C7D72CE5D6E54149E218CF59609D5898AEDFC
      056D8322B74C0AFE5A0676059C547CE84A7191AD9C02A47269DF0E3B06DF9CBD
      3F841FEF9845BD8BC71E7903651F092A7341D6700E740B45D9EB774359347328
      AA757A324E36B08A4FAC5F3EBDFBEFCFDFB7E83FDBFD15A98FF2AFE69DBF86BF
      A17975F8FBB1B832E1DE2B504620EECB3E670A8C07CA8AED6D002695CD2B0054
      378A28242972B846A159A367C9604E389F893F8E7DD585AAC0A69A7BF0D8D90E
      4C3A45736DD1569B259EEC15FC59E9BCBEF5EA3A3783D697EB88F2BE58652BB3
      39B0D5D9E76A538F7D4F9560974287396F4577FA8327CE9676E6AE35F026B644
      4686429A979445299295B32B4B15A5A4E79A2BC5230D12F391F0FDB28514C8CE
      963EB92291D0BD217128988DA7AC65B95B1DE91A264687DE989D6377BE71BFD5
      6EDD0F40623F3099CD7751B5F13C6E608ABA871DAFDFEF91D8B44B8676569385
      606188E54662499091D15A19BB1BBD391B783713948CF4768C2EF1C6E37819E5
      D6FFB9E7D3D1DFCEA7AE2791ABDDD24828F15BBA3448EEC791F1E6E3EC8A1BBC
      6E2060E6583446005515EB4477D58AA34DEA9439321A62DCE3ACBA58A2EC7A4C
      80554E9C88B3AFD8838485B7B917ACBAA6C3CD64ECF34AA7B3634B561AAAF7CF
      C0CCCAAF9FC4E82841EECA8A807C633BF1E51CCC21A985EA2F3F89E4FA576B43
      14A8319E37A83D564643ED154A555BCC872F73F34FDC49647963B58FBB28A472
      24A3430BBDF874B5FD38EF3075B81260AC6BE3507B277CC4928DA42816762D43
      A73E8D3CBEB4C6790A0F45004B3BC2A1349D1F928F7C17EE4D4C967D2CDBA5B2
      7128A89DC31AD7B7265519F2B49170775EB317A3B9C2E5146643D28B0ADD2B16
      1D2EF5142DC405EFCB2C8D60629D7CF9FC0E75AD9908A5035545171E18525EB7
      8F4CC37FC17A38BF725A80A1E0AB14BCF6C62743E2C9D5BD4BD29ED73607920A
      BF42A1BB32164E3BD26D1D1621BDF2A4D76806508C8ED5FEFBB542E6322D4867
      D2ADF428A1F00C9931F135F2B9EB13FEF59A53567263AE4CE4DCFBDC24638A7C
      BC7B3A7F330F01DBCB4BECE26254DE4DD5F48E77852508C4E69872C7554A3772
      150A0E63167E687D7DFDF950B9D2DF7E79BF0770FBE7925272C876BE60EB7F9B
      62EDD3556141D66FD1A16B8C9618B78CC9AE1CCACC283109D88BBDF7EAE3D9D9
      8B771F3F7ED16953CD722730A4BE9460D5D800C04499C30738ABAA5C9F7F9944
      A83E4DACBD334CF34444957885011222D2D17954F602B4ABBC6180364802E454
      09D3713C8DD0B978C019FD0274B3BDB716865159184765BD7D3EB728944AE678
      E14B54C8A32AE801F25082A069EE4D79497978B8619C7AC0F98B2C002A38BFF6
      2EA3E912DB7C3708BAC25280D48D49AB9669BC04CDCF0B9208C33F431FB8D058
      704F511DCF80C2A3B4904C651F7BE98D8DB03E197C4A971CBFF51C037813E1F9
      D7C5148FF6B1736C13E00AB1E7C5B6004D021427C195F202C3DB0EF3029AB807
      18E0401413F33572C1765ECC682B443FA84C6655A90805224E1120B46A42AD8B
      E28004080C39E6B89F54E4C58D54C8871F5C04FE521D30AA395E281DCAA9C858
      419EE22EE5791E5D672A25B99CCD0DC7724B975C9EFF5A58A83C3F3A5E17B6C7
      5F8E295A3898105DE7CE56547E2ECFA1C03D9F7B11469C00CB9E8132B18F5999
      C138C82447B9960552EB8D0F32C4A6F07CA1003B9031C9E814253385A01A9439
      4ABCE9F3E8F96BACE403B875398B4B5E62531CAAAAF2F55A3D289573B49A3656
      69A82BC11AA3DF8BBD17661C14B35FD4DD382E0588EA816A1FA7AC7C642B8F28
      1BCBE07CEDEEBD8F97F539E6141094642068903CB9F77F96F305B096BD8DB5C0
      9ECAC9B8FFB87934245B7FE1FA480FEFB58C37D569934749B20A0C62C9375335
      823521220DCFCE07EF02F8780AD27D2114FCA9A0FFFD33865320155FDE9C755E
      9C9DBDE1BA7D1FDD434C90F5483717FE54A87EA6F011AB7F9DA7DAC358C8F705
      0D0C0426CEC7A78612D80D47F96D48A183311B889EFC5AA9AEA86A34F8B8767A
      4672430FB16EA0AA319CCF0E1B8B51FEA92FAEF21C37AEBB19A4B9E8776CED7F
      5679A96B5A148BB5A866614D81C9E4F800DBDFE27B4EFE4E919EC4F1BC5140D9
      ACE96C39998424A18374AE2A206048BAE29C2BDD7256262B578282FA9D64C971
      CD65ACED837A0E279214F3D14A534855C61F170D024570025A2665D40611567D
      E1D4ACA8A0427E78F9D37B561F8914E57E0E5F64026B534D31008F325B40E02E
      646173392D504E27A88661734CAEA583AA0BA6E13515FA3723ED981A4A0529A7
      2263FD8B602C612ED13955E20E96FA808D6D60D723EA0C4301328D63D853D050
      321A546B37853B18448D7597CFEB29CF79788124579C1544498D40AA3802B894
      BA4F67539D892D921937970C605F2ED50A04307E5164801746B0A4CDDF1F81E8
      96A75666ABF7C109A1DA3BF0BB40369A44FB472BB4E70067F50FE47E3AAF55D7
      BC92F71592090F2D24B6DC9B8F00230B781A3ED9209F5986B9CC96195548958E
      4BDAE464B9305142EB51FB4239A3F0484A738BAEF517487A235B6EE313D80D25
      AF7A43F03E2C5CC4A4661E8F7BA3E48DB80B15DEB1051BC2A5C161C2A00AE060
      E8AB543610BD9B329E825FAD9B79CB299522AA67BC2E3A5378D7C7BFA345365B
      2D78926E5D122DB2602A00B81956A1C71A424B2A42AA3AD24479E49544C9C31B
      268D902EA0EA06F3136AB341B43479938D12FF5477C62CC6BC3F73F24BB5C9CA
      C0C993F5F084C1F1F7F1E4175BBF583F82B4F42655F90EF2A287C9936F5FC397
      532C4AF365A67305B1E82ECA8B0770BCB26C0B89E26DA13C4102AA8EAEFA107A
      540D85DA6DEC93B4E98D13E0FB568A54268E8CE5B1C999A0BC1290D7C2CCB316
      94854A6663734256BA39142044FE2F4FF95B8106D76B2FB2FEA1EEA5542ADA47
      02B2E2B1703A2EA91EE665CC655862728B29CBA272A36E25128332061A2225E2
      A16F9827808393C2B2F75E601D798AF5953EDD63EBFFB1F7F65D715B4BBAF8FF
      ACC577D061EEBA86491BF7FB8BE79E99850127DC80F1004ECEFCE2ACBBB6A42D
      D0412DF591D4603233DFFD574FD5DE921A9AB4481C1B65FAAC130CDD6AB576ED
      DAF55E4F1D05DC972F4DADF71FA59AD2AE64204A0AB5C4BD2A13104BBEC3A2A7
      CA78B41441D73A691CB6502ADC5A00E049C9A5794EAB49CD83DAC916C0353136
      47979E7DE9C5F5E1A2707424EB5F7D20C16C22051D462A15D813339AB62A6077
      9DBD07A081C8D2541EA920B3C08CD99DFBD5236BE5760D4AC6984499191CB758
      936B7D9F1E1CA3A86CB594C24E8BF25289285814D5CAF33C59B633B770A7B892
      50BDC57D5978AC62ABB9CF44247FABC2649559F29C6DA747DEA53D678F0DB0CD
      7C93EDBF3A87AC32CE49596062F207AE796FC9A4407B159F4B72C7FBDFD6298E
      F0AED18093CB491067B6420DD2794F4BFD110542636D57C853940A5657CC3B24
      193D5AE5431E63C01AF6C88B298886FFEF31DBBD4215402C85A689179DC2F6CA
      5B3364DE3CA2E18A983B782FA53D514A4EFC852F6772D6819D2583B72831D9BE
      B7CED4D6DA91E161C232D0F2A5C4BC1251555A29F2AC928BF4CBACEC6FE154DE
      18C609C81E8820B67C9E22DAAF1ECAD4DF207F24DA81AF9B4E05939CBFB27CBA
      D5D05322413303288ADD34812F1971690A17AC9C7B42B7C77111ADB86F5856AD
      B6CA0EB1590758855F33E46A6013EA9298F43D21667AE62ACE05E08385EA82F2
      C80C6AB7E57DA9D75850B5F251D422881D5B7888A659A6FE6817005266ABF121
      4AC54BB6F41EEF0AFDF2460A7894C3F4CCDFE3F9F7DEECCA3597745C6DEF0EAE
      C21D6EB16C865CBC44E50C2A1450575AFD34D0A07206E37DE2528C0A5A246695
      BD215D588E546407511F0F6B6C03D2C6DC7C240CC7D36049BABD36971CE0BEF2
      942DB3FAC575D73E24B5620A266AA85516A29EA1123CBC84C64993F9E5D5C2E1
      26D95879C4621E96050AFB1561B0001C6C64B1DDBA7B94B2A54B24FF482ABE74
      EF5E16ED802CBD65B60FDDA320ABD0FBDEEB567597AF3F20E5EF8FCFFF88F83C
      0FDC352D283826F7055FC1CF0BDBCB4AC600A1487C8E93F00866E3862CB6ABC4
      4648F737F1C2AF5B4E0C9D0D5C982A38F53CE5A00EA6B0DA899BA9E98A330A04
      EF6C9B41C074C678870C4FDF979E3BCEEDEA327DE6A30A4436638ECDAC542B0A
      8AF0BD4F535EA8D92BA740D1BD83790466C0D870168369399D81F5EDC2779904
      0C0B72525D0C3748BF2F10C6C400CA4AA412AF27B7405FD696C51A5FE4022396
      5C6A2E9A00B800B38C55FBF7EECE742FD4F6AA45D36733C9DC55C96914A464EF
      18F0DF7C7B59E2BC486367FB44DD2DB42ACA8E1A1BDDA80AA34EAAB3418B3686
      AA60CC74853CC63A740ABC2163519B4CA3BFBB2EF55FB9CBD6C02766469D5E81
      F95C01C32CCDFA754063816C46EBADEE1D2AA80A422F50B4023C8A28031D1212
      E45A0C0F1C9FBA12CA3E8FBA7FFFC2A4E551E01AB201C5AE3A83F428AA7C5B06
      89ABC031C9E6A1E4CC2D945026C1FE05B7CCA94C41C1ED0AD954BA5A85CBC965
      B4EBE3B86A1FDF70168533F218D7E67CA7A359CB79A73FCD3352FEAB0BBE5ACE
      B761FEDDDC6DA15D01A6530BAA86147DAA913C51977A5DE7F280D88F0D503259
      359B322B3C23D458DF86B18FD9CDB24FB683E73F3F628607E06899BA1F79708B
      21B1737F7DF75656BB5F839F9F16B3B82A5E6CD0733EBE70471FE9ECFEF7920D
      0EC297BD217661D47DC24ED3DAFEEEF1BAE82CE49FF0D91A7B1F659DEE5206C0
      E717596034E94FDAEDF1E7E680D5484174B89C97E4F4F2FCC22BFC0571B780CB
      F09C76B4862B66254546EB425AAAFC1B67BF5C1E7935BC3526DA061C59F63E2E
      4DC85297DD06259A7E3A8F390AAFB286524764239186BD2DB6A761DB06A1F1F0
      22D4F1E4A4E4486924339EA05971292DE1CA3A16695391FE8C66D2C46809C32D
      B2E7F6B54CA737F02ACEB48A5EB2ADEFF18CB13A714804F4D8B0975BCA702D78
      AE86B6C08E750ED1B68C0AF090498A61278D24E2E68655B02F9DC368CA6506E9
      DE8717D982E2ADC816E73F809B6F8C6D9938421ECB3C67F0FF2C33B387CBAEAD
      24BE4CB8BF640EE8FC05FEB47CB9B6AD566E93242A64D6D657A2D6728DF8646A
      7547CBA9D51D7D3E6A89AC5C1B8B8B7DDF827EBCD078693194ED14B76075F270
      49C6305E2478CD449704668A9AE43206B375C098CAF6895273771329B500B5F5
      A3C088D4980FB3BCBA51612465CACA71314901A55F988D68531252E1C6D337F8
      81CCF79B2AB1C4C0317C2DA9D5A073585870EBA3F81B8EE2E2495B6DB7086FDE
      A7F9673F8DA559FED50E64F9088F9CC93ACF50380948FE23F148C64F524AB56D
      9EEBDBDF6DEF7E6AD13F5DFCB3BBBBBB234943F964566788B48068D8E8BA54AA
      B045BA2D49024E8148B664C794CE5494BD291D3522888B424333D9CDCE211538
      FA7B3B588C9831132DD70571354AC68DC59BEA69C8BC5665C6B5082B0BE2160E
      6951128ED18FF4CC11879DC07A969E72489F7236B99D5E8E360E07FA37C0D472
      846AE4D1E2A28CA190633F7DFA594E5739F22A2F650BCF4932329767143F6DB8
      2F002538B49C4218A5980A91A40594FEBDA9B7E6DC4ACF1553B0526F378BD026
      C207D8920FF7B3BD227463CE1657053DEE49DA63AA620975DCBF7FEDA598193F
      B60BCE3879AB0B1C21A3449A56BCBB5DE7AD787C22CDB24A25D68D99781F66DC
      435D2E4ECF74ECDB1E52961E5CEF6E7CCDA286679AC8D83814BFCC491CDEAD65
      5B0D18506E54A7A5D27940906C6D932D1CE187F471B64529F359BA09D5BDE174
      4B1A9D772AD178942F5C114D9E5058833937FC18ABDBF8323B27901455389D4F
      CD73D361B9529129E0342D76E6AD058C3A6313D47F326BA115F3A84DC7EC3A77
      B02C77D07BE6B983CD8D73CB1C2F99EB04C5222BC6168612C4ABC3428B07C768
      BA223E2FF38BE91BB8284A46B0B3FD6C867D722D4D5914211553CF90A76A90F4
      6DC8F3EB4D343A0FF3A84007D9AE2202EF94F3C616E96B6BF3A7A65F40B09D50
      B98356F4D5E03CACF889E75C866053D3C4202C99CDB50331F989B2F017BD045D
      CE6E9BE9413779422E34C5271ABC331710DCB23585A8CC0B7A64BF420BAEA2CC
      99922CFDCB94921DE902E7D32315102F9098BF460465519DB9F00DB735C685F1
      9D9328AA34F93590F8E753147BBE44E59E8B7E7393932AF6853BDEE5F8ECFEE1
      5B7464FB1772CCD0B55F5439280E8058B5417925F9AF39105179A0126F88FD89
      7B1FAD539D66DA557F4D48806F666902C397E79AA1C0E92A9DC7D74E96984AE5
      CAF762F995B11EBFF6D44F66D2253CB8B6B31FCFCB630FE2A4448760BCB4E92C
      27F597DCAE8DEE45BF7905B5B66A000E2DB8D83AE688D8AB223456B6912C1B2D
      BD60BD3FB1DB9B3BEAD6F6EF32FBB7FFECED5F52025CC2CC5089884158C0BDCC
      8C5C23069A61AC1BA079D13E48CC689B9CED6400B6F6C884CBE7DC5CF246C7E1
      655CBE9BA0BF0FC17B08D7ABD0F775DC48157E1488F15EC01B3F4AAA3A1D9CA6
      59E29627B85EE1F45BF2EEB42A079F8926B717D259FC83469290F9CDB6429D5B
      4CE4CA7CCC9A2C7642C72E04AE13E2FD55A9F92BBCB656D58F378CCDEC54775F
      13038B05C4735478C6CB82E55334023D1C07B3F27B1A034EF8A546CF1A9DBD75
      B048F61F0AB22F9BB9530E4CB0C85FEE1D07F5A799F6B6EE8FAB750E844E4688
      0CDA4FEB973160D0E203F07371F039E044442A28C4A855C7EC8C254C22CDD20F
      D72039457AEEAB242A3ABFC95BC9E800CF679238B85D8D284072F45ADFED3064
      294868EF64F286C6B891C7B64D3D45EC464D79A0172E0AA7F5D31CE73A379D4C
      38306D9B64100A09A80EEAC2B84C2EA9008A71637701DFCD54088B316DFC78A8
      DD2C9A858596DCCECAA45C8BB19A620C93AFF72258200A3F39584BF7A2F365B1
      ADD7901E8F882190AD4624E651BA3E267B049B309DD73F6415CFA2E5CCE3CC34
      DEE0EB32233CC834F0055B6FA7288FE0277B52A281AEE70A4CEE02220996F074
      99BFD4BE81144D7C5240996C15636EB8816E66060ED813CD264DB798159A91A5
      9220996BF0B7C27282C8E37C59F25EFE69D219D2CFCEB8D7A57FBAA3FE98FEE9
      0D877DFAA73F18B7E99F417F824B86FD0E2E19F5BAB864DCEDF7E5D3B884187C
      C4B7694F26B8A8D399B47155A74BD7E1DFDEA8CFD7F58783E11FCBF0B4FA3F7E
      0CC69EE3BCC1FFEF6FF063D7D3C5FB8EB357F7F2FDB568298C3DB6E08B03660F
      735801B2C20158B3FF1765FF27F03DFE5FF772F95FFD63E2AC4FCA22E8ADA836
      0EA487A920F76C5B5CC83238EEFCD5590C8EF351E20CF8171F28B42D4A79E751
      68755AF91F06AEFE15C66C6D1BE3E2F105FF81A393A4A5D16423C5EA42B59998
      458C1ABC60F8AC9D84C70F5B395D8CFDC28B86CD4DF8E3C5D1695C7ACDB9725B
      32AD8B5E5B9DCE5BCC08A6DA36D7A39AD9604B98E96EC9130B6F8E30A3A90A49
      63EE439EFF3B0373F60A5B0A009527552C9AFB94B519D75ACFEC706264170D9C
      8DA959C6C5C65D17249985564291DE886E2264A204B48CE7899A6EE434499E34
      2C5C4888D07C11A2E3E7E370C95518F9698DD479CB01D5C8ADC90406479EEF45
      56BC8C1888AC780A4C80CA9097A740945E24262045D4F1E65959707AADEF64DE
      F63C5BE78996E68906CF3C4FB417E5DFBC839EF937E67C7BE8CCD9C190B802E2
      FF396DECEA75E5D1373FD825B1EC585C53F35674189B59C840D67F5DECD4CB7F
      B512927E2BD64ABFFFB0647650A316BC2F41E383E4367E8DD8748D98F1B420CB
      231B0FFA2D23CCDAAC7A5C3FDBA1161E54A1280006CC36609B0BE4ACE1E9FF4F
      31B604FF76E56527B0C03ECC5E81CD9D6D546EEC38AFCC4C0F3900C59B56DBEE
      880E37AA984BA452D35E90E5649114EA5970414D10B77EE8941F7CCFF7CBC7F9
      E22ED9519CE934FFDCB3BDEA20013E4E65179D2BCAD345F786B86E96BCCB9B0C
      2B5D863616FF966F19EB5BAEEFABDCA28680CBEC89DB72B6FD7B21F81D297B9B
      9A31AC264576BA503C14C63CF6C6AF26E8BEF8E662F6FBD770B5259F29E55260
      EFE7CDD74F5AFC130FB78F499CABD81B17CD1ECA8FB5AA5CD58094A1010C3171
      14BC38917275943DD0946B4559F5D52B84DA2E5B886D2C345C5D2F50096CD84A
      046940E7B5DBE16171A5DADA40EA9585D476461C9F89DF833D9A8271954C9AF6
      2AF5E0F7F326B15F0E659687C9EF66069F1C36ACF40A66451F161BB368164C60
      E0327CCFFA6CD63E9B12C0205D9925F3D413B81F4C1932439E0DE2FB6A6C1083
      786C261F6DFD74A0F5EC673AFAB33BC4896C0EF815B2EF40575C0F1A7990FDAF
      CCD3560F08B8BD4041A1F64E4149A0F9A5253AED02FEBE49F417ADB626BC27BD
      5C8AE102A5DF96E7B19B5A03E5EC1F1E1FDBC602E5FC78767CC06177E7ECF0ED
      59F93AAEDAB1C39735E67AD458AD4AEF16228D74608BD9EF88FF3DE03E167BF5
      7B99538D8AA46C0168BF00F4F26D7F93588386AAC62CCC967D7B652EBD9C91DA
      4FF21695630807A32CA202FF612BA46CD31D7AE781E0563C8D6D5EB1908E2ABD
      D4B960A46E17323B444473AA56A36B926993EDE0F1D5BD05ACE5E2E3FE6739B8
      460600AC855525EC6DFBF2B7A6F7C9548E10238D9EDF39DBD02782E55DD42ACA
      FC218BB6022190268C49BEFFFD0EC38C43C49520E20B834445B16BFF4B46541A
      CAC25B47F1DF49E4F3E0D0ACBA476BDD5B9B4CCE760151645175B89BA8464CA2
      D27064E0AD9171B2775952236C8A1B4C4A0917C98C3DDBA4F8AE50FCC5F465BE
      6D9E140A8543197F9726037BE9F65F0BB5625FB2557BCA0E37B18D1D95BBCA64
      0006D227FF833B8A3D8FA70673EFB679B459AA83F0D31326B5CC8A9EC650129C
      ABD557A90AC96E90D9639A413E2590E362BDF428EC20C1D20186B799592DAE82
      62D0FD34B7B11F79F61D6BAB0A1A8935A09EE6E170C133BE544653D3B2EE742E
      B3AC16E786184D2EF46E711B07E39E8BD1048B487C3B7ABBFE80871F550A2BE6
      B5E475EDE846E6A277A7178E194FA1E2BB72E4F8CA7B0A6A3A9B675383225DA6
      83CDAECB5F616AD81AC39BD726C56A41634C7AEF9E4FE46CCB2429FAF3360D51
      8DBBB376911E52EF2195B6CA49F00B9D08768A1CE3FA3F4EF6C279B227A7F6B9
      7B5799CCA7F27B270FD2C03E250EDFEA184D31A3AD5A375D8C2B593873C61578
      2AA0D652E2DD288C1D673904BFC8F6B4C70F9E67E1ABCD683AE2934B1EFB834E
      B4309D8A2A33339FB9AFCA631A07153968662E404BD927C92D7482F9244FE2B9
      0CEDB835EF2A093D9956F91F75BAEB333B517E8B15C5D6BBA478A136C9B8658F
      A92F0191B2E9F1E1B43B4BB3A554A8A2A3AD2087F134B72B1BB44872EE0D341F
      7BF8183B161FEDD777AEFCBE1AB434E3F39E403689A18BFDC1B0CFF70DAA160F
      035F8872E0683E49204A3716171A2D062E164694B6CC08ADC83C4A2203E2C2DC
      8E73CB4CF192218DD9C7F2031890509E61FAB67B941554709E275E8396D5CDCC
      AC39676FF4703B2DED0516E607E327ED1B3F49FCFF452F8B6EB9FF3D1E5AFC31
      E5CCA2F9651857895FF4C94FE75175E8DB5A613FAE72B871D7B80698750D5972
      787EBCD6CA8B4670A1FF729EC373DF57E1C35C98E9FFEAFCAFB76FDFCA504312
      FFD399646A8DD7B31A71F04A4F053B2A20B7A9BCEDFFF92BDF77B7982D1B90DB
      B638992B4F7016C8188E1F3A524F9CC1F91B0CEFB55DFD871DD33372B3793C7C
      714E4947ACADE7A5ADCD088C635C83556705F36674571EA2455E791167AB24E8
      7E3D4CC2D6D663E2F2191FAB5AC88CBD4A30921F6675CCE28A6BC05155C8EA9E
      C7B017311927433B291052D13C1A008DA462158981281CBD065EAA35F341C73A
      2543E817CDA5DEB4BF6CE181FD4EDFED9D1465794D1107BFB3DAA642B1C7EA6D
      5EBE0D3FBD875D490738F6F4E72E285BB963AF3E7785519D35BF4BBEF2AA2124
      BFC6C2A5030847E17FCE467FB51557259081CA752E4540A1B0B1924D90903DA9
      072EC581929A9EB04635137F541DD7D2A74F1D9E9F84C11A09BB56215AA46692
      4F78C7ED3F45F9995ACF0CAA84370D69AA5D71CCC8067AFAA7973F3BD9DDD44D
      2253C7B18872EF0999393F33AD3F5CDE6C0EC235291978331297122532E86392
      3EC3E88D242D87A817A562EC51CE6651A8CD207601C0A1C72B51DED83D9CAA3B
      1367444D45925E2608435AF8A11A812EC9DCE1D1D0E85660D31BE30ECFE1256C
      CAB9CABBE6E97CE9AEB32DF92253BB660281E6E11D8E0BC1A1E5DED638C9ED64
      DB4AAD9BFEA4B87E47DEB09FB4734CB85736CC4B4012F26805F5476E580C95AE
      578B648BA06D725E6A84791A83B551C104189C9026715E86DC7DDDB2C5843528
      296C62B79BC35C0F36988BFFE840F1F49324AE0A4EBC7D680851DD7EC407C84C
      3FB4ACC197AABC7217049DE1326815670542034A7D4D6AD15F44A3C25E9A69DE
      F721AB9FD2D189C5555B3AF938156BB4C74658880392720AEA045F433A2C37A1
      3F2797C89E089EA1BBF81572BFEA37146775C90D768517CAA348F7F3CA53AAE4
      9EDB959A79C32E66988D01BA165C2AC5754F0FBEA3D81BBE97E04D6BEE47E2CE
      CCC57BD875D4273903F384B693D4ABC393613179C77079CBB48A42CAB1DC70AB
      7B55C82AE91EF093B95B3D29B6685C6721781A05BD5CFECAA5B66D495A57C180
      B94E4BD2EDD952E040936C4619B5415454514AE7E14EC0C5ABDFEF3CC4538825
      8F2EC91B83FD83C72E0A69EBD4EFADA67B682678D372D7D3876A0D4BCB4D28D3
      9178C55B88DBEF685BD78567F770831769B555C87F1BF22909677BF10B94525C
      F39DFEF4344C2EB4470AFA1D43F91853C7C8A87F6355B3009B8D77A4A1B25AD9
      B9B0B978E38403CECE374E677D3C6A2058947B1A57C022CBAAAAD533F28C085D
      9FA652D35D54CDFB02A38A6397F78FD2ADD5E765D6B552D29699CC6969B42D29
      6F339D8053CE11D109A91A4282FDB800A229815DD8290C9AA5F287CF64AAD838
      0BCB295B632E69E55D551E0FF7E7C7B377A8534960BF0477586BB0FADDD001F9
      30ECF698E23A36658AE2BA35087E41B183A5F4C140C7506CE954B39FE1B17F94
      82A74DDC0889823A6EAAA0314A973FDDD0CCB0E46C274A0E2FB5832A95E2DC1B
      DF7E2BCBF1CA4FC533FDCC091EFB910297294E4CAF957DA7F03CE9AE970631A6
      D3A6A3474E81A99790363294C9586B9EB8E6922CFECC2ECB7878B6470333683C
      25ADBAC5FDEDEC1CC4FB9FDC8FC6A0EF3296BC6ECA991BCF1299BA717FBB104B
      28EBD369A5A68FD8A87F649AB33BF257A7A80B6DAE1C591AB475CBB0ED93E5C8
      A3B15B3C3C0A78EFC76D3F9F345BEDDE60B8202B1E226019CE5D8BAEAA1DFEC5
      5BC41FE58C2F817E50304159E2599849C6923F2F40CA6D2923711047F6B91E1D
      C2438A4C4CB61A7EBDF1E3170AEBA5722BDBCD3FE51CADE48843761DCEB23A61
      20F340DF722B5FF9481C1C5B7053F05052AA436E7FE8171F5A179CD4C837132F
      1C87F1B5F3CA797BDA475B1FFE5ACB871263BB42165B8A0873E06DFFFCD07AE5
      61EC4573FF091AFCC8040A6D6963C63CCC2E07FA514EFB52F469BE5AE2C83280
      DB947A7235358FDF362F5CD20BAD7BD5D665F388D484D6387326065FF567F860
      236859B0CAAF4F23DA7AAFF2AB2DC60C348E0EFC2CF3A66D1C853554BFD10686
      A37D0CBF058B4D554CCA252E1B66FF26D2E6248479745E7DA543A9701FE16491
      4494452A1B1C7F9A795654FC0030A6C01F90113445DE94F9089B8D161A29F971
      AD599A5B9B140B289BA4781871FD8A9FAFA4DBF0CC748EAFBFAE7EBB0F688FA4
      C554B22ACF5CE57F6E005A3BBF7491F71F9E6CE2B2B3E25C617CB03DC23CD05A
      8EF01BF28851A54EAF1C4368ADAEBE5FABE1BA655F36EF5A4D114A34A2CC0B07
      E1A7F5D4EBAA888BD08BE098B25974462CA558C5B59D2ABF80237840F0A2EDC6
      3686932CBE7C5299E5512CA5D99E321372318CDE347799B615BA3D990D951AD6
      798C07B98CB9EEEFE8E284F3BE9C9BB3B06F95F7577BF9F44573EF0AB6C9537A
      5EA4B627F4489DE379C36C5A8AD04ABBBA494923BC6AA6E910D10D1399C49B55
      570FA9DB2A067F723BAE9DB4FC20ED706BFBB74C4AE47E6AD588F425D03CF4A4
      B46B6806E3B13C25FA8EE9012E1E956E5907E003C9F4BB1C7BA7EDD020DB289B
      EA0C3762EC11713D6E9E0461FCAB142FCC00A1F516D1724E87E3466F2D21ABA1
      04C335E3F2CCF9E164EFC0799F22BE9373194920B4DB3ACFD3B9976F2112B7B5
      C760E4F4967D912B5EA4E878AA71A0AA1EDE255E7EE43E75BAB016BEAA855151
      585DEA86798AA66139C18267ACA5A29BC5382A4D9ED0487C945BB37CC18A05D6
      2168B2E39C7B693833A2A142A06AC0FEC391B3ED92F9050C392E0FC03CA8545D
      BE885F0032AD7E8FF8FD86A7A338488A5C1EEDA26F828BE03231F4B8D9EB8A87
      077E0533E58EFEF7723A7D49D4FA90E9F4B5F3891ED9D79F5E3B778BCFB2B9F1
      FBA5FB6AC3E56B8C0A7897C48F97D3FE816311B643292C69AFAB0C56CB920FEC
      82C2A94BD2A30386948FD4A5684EC52D1D24F4B9A5706D2955EC928BC3F3C1AB
      F3F3431B5D78F5F67434740E0F8E2EAC50AA7470C27E29810E5BB673B718D739
      4BC324351D9BDEECD434BC3EC14D2E8AD6A4F0D2F6BF8B61C6DF8E5AAB989DF4
      949C151BB27475D51A622C28F9F0AEF3665E0762D57A35451445EAFC0A7692C0
      2826FA890DC60861A96863935AE26288B42486E4917910EF56D1FB6BB3BAF6AA
      FADD437B6554877CAF4B04EFF3542BD25AF62111F0BCC54035BB53C422E55E31
      3D8A288D25E57D42722688FB79CA6F9391EC1C92F82D94941BF3B84489B9C409
      279A806B8E052C5497720A8BCEEC5AE0D5AB1B913A58CF74E693E7FE8A498E8E
      37E2CAB5A42B8895D8B05969F54BC2424A291EA163F8D0E00A1F7BDEF073EA7E
      3A875F232C54D6B88B715A011BDA86A6908A15947CEF5403A8E5895E002FB26D
      98ABBFF7D7F6C0F0F25A22AC5611E29A002E01F096DBD8ACB3533838B4A5C0B8
      941C421927DF06DC65CBD9DBFFEE4CEA275ACEF1DE3BBAECFDB767E6E2777B3F
      9CE0E37CC79B5015CE50C268F1DB3B95B8368F958623B5B3163C15134B28D6B2
      38A24BDCD0C5ED0221E9B0F58B6DABA4576A080E8605C25D91827942E0C12476
      AD3D5580BBC88465863691DE421ECB0E6C83849DF46F9C4F2DE7AEBE8D77BFF7
      392F909F33AD52D4B6C1FBADE0F4087500A3124AE1F802C691D833924F113982
      F21D8B3BB6C34CCC4916A9EA59BCAB0936051CBB9678B84CD08D35DB79357064
      AA68234F884470E2FB3E1F2C3D7C16CBC11EC2C5A8447DB456A22AEE2F410EFA
      0A679B2B09495A184C6C2E1E8AEEAC3D6BFA928C6546BB2F70B8ADD2BA7B64BF
      163A85EEA35255F606A4A80611D5EA3257FE2E3C46FDD8AB8C1E36419B5F937D
      82BB51F23537E187E6FB5A8CAEC3B1353A5DB46FA14DE59918207321AD23D545
      60129FFB6D294281BD414C135C526607A596944355552E2828FFC52323AC01BE
      466864AAC98F5AA3FCD4088BA0DBD6362FA9302E441F71291F86D5C5C2382DD2
      2F664FEE5ABD97FEAEC8975F152CB1D622BFE7D2FACC282495FD30D0E4855491
      D085DFAAAA5C0E66156FF06DABA39711DE4A0579D4C26E97A81E66E023862CC6
      DCD2E5B1DA12C79B6B0C5854890C629123F9B1AA5077E7641AD42208FB570BD1
      8662611C7128256C49333F9422D469625C87F22D2B5B25ED55F9B49805ACB18A
      FA7D0B31880888D08A8BCE4A3242297101F7ADA992E1F956B22F7EAB6C1CB416
      434922BED036A33159F001180B78073323B91D3EFF2C1D66B241FEBD63B70E03
      D7F0816CDE5036D5F8434B1A366065A3EEDC764F669C849A23E56EE28E6B2957
      35DA9791B0103FDB6C5C23BF4A066D1466006D5CCCE01AD14784A6A3CDED2A08
      E33E24BA5861263463A3A5526C2E8779AA628122AEF6EAA22DA6E8E36591C333
      5117FA5BEA94E0152894A8D132A8952A1397202DAC58C16B2C1F1346296CE83A
      C2919F4E0A58CB4854F9A56618D34289986DC06D15129FAB73E90E681657B866
      D7D97E23504BB844651523BB8A5850D2492C54513C06A46911BAF3969E623EAB
      DF572F73D0A4746E31FB4E7C117ADAD8AF979A2BD88AAA44B5F4B8D68933D387
      C5852BF568550BF3FA4089A9A47DE05F400D9AAEEF876A69A17AD02A8F7B2811
      ADC7BABFAA8AD86C892DA1E66A417B6B7233D1E507FD0F9E121526E80398035C
      A92FB49F78ACF5ACC6A95D0D3E5E41675FAB963A487CB04FB6EC565C490FDDB2
      8AD735EACAD2EE664BC06AC8B026252D1CC015CF01D0B14591B5B798290CFCD2
      9E82F94B4210E3B2103ECE8A0BB9E9EA0A35C0463988F4BB8F54B48067600711
      D5C20DE0642919CE12FA28BD76AE92599FAF95043C3E3DF89636D618E3EBA353
      540CA994073E096196952D1ACAA13C97A15FE26BD415EA2C89FFB266BB55E43D
      BFE2228744AC8F59121A3711C55853E4B3B85C8B2CBF245DBB0405D54EA42F36
      2B2D9F226760243292090163EAA4E97C0613E61E914D61E876616D2252FC4EBD
      AB585D2B1FE3B6AC6487F608E3391F081F03FFA489A2DA115C79329EE8765BBF
      6CEF57D65B14A682459CC44351A66D105F642294C5983FCB11364F08115BACE7
      EB18DFBB84671F72AC5D73429C140252F60D2CF0CC5752DBC1380432A3205075
      1C98BC28D5253D6BBE028F24A4B016B051A8E40B8A0B135EC60C7AA50A48D8A2
      6216F53E5225430E617EC5602464B5E31A374DAEC5568F8D5FB3EBFC4732173D
      7DCD591417EE21D794DCAE35ECEA5C4892326C13A3CC9C7035AFF3AA9C28685E
      C1A13DFB108387645CE25E1472059DF3EF1FCE2FD6B9DD8594DABD6AF24AB35C
      8DC3643BBE4AD4352EA4C6C999BBD5C41F0B15BB1BC7E717CE5F2B5D39B23D37
      19DEDA3FA7B78035685A63ABEF1DE3BDE3C41458F03B3B8F24A53372D0C9D8B6
      A8706C1317CF2823CDB34A56BACA4F5243BDC851F613D51963F4891A249ED648
      4F14BE8261DAF578DCDA1EEDDE6C46D259CADF1908C30E77A934CCACCF7BA5F3
      97E1461835EB7E5B8649B22037CEE4B4E3561219079DB8C9279361092A37616B
      220AA7F42B92C761D92863EE623FCB5220B6EDF5551878733B3E51A4428D1CB2
      A0F0C0837F5AAE7C7572A29ADB29E253F2BC2D9B34B1151966190F803B5B8F8C
      1552D975811F7AAF450A0697BA2906E63ADBE7D6BCF0C3CC23E6A4B7EC47CA46
      AAFA265E11182C271C79519299FEE2272FAA0E18E393D65D5DB18CEF49F2C542
      3BFB60D5D5CBB2B0101B29677C0746956AD93A48C152359FE6DE725B99834A18
      B0DC8B8CBE457BF3A754BBF037CB37A19E44EE5E20E520E8B9904FCB403E24E7
      E66668922D455AAD25E0071BC3F2FE90297CCF5A15ACF6827977D8FA6EA0ECFF
      E361D789269E26A74EA3E64580CC8F829330C3A9DA561AC5D8AF9DA35B17BFFC
      0B9D66B9047F4102BF46A68BAEA477CE93349737B3D7CE9B2489E0FFFCD5B948
      E77AE75FBE389EFBE606DB7E66B4516C2C3572135DF364B3A2777EDB6CA0F463
      E071F997790ABF36A864722CF02A596598A1B2DA82830BC9D3D54C99D65740D5
      5FB2BDD9926D2D36EEE29CF733FB3A5B46CF28D50B76048B1DFB86BE53F38C9C
      48E505EC22B369378551BA25BACDE51D320EDEF164E69C53E1CE72E8BD4A4BF8
      FD2F5D61566ECC1B4D46870C0FD856061795F7C6FCFEF9B7A24ED0FF8F987AF1
      04A21CC6FE87D9CAEB7F0BCDFEC0E2BD7B80FAB056605599EC31F2C5B60D4086
      5D39EEDC7531E2861B84AFB8F1491B631AF7BA9A5F6A245C675AC2885C3D83CB
      5F896DC375C38C09402206FDCD4F4235AF3E6D145EC31C0AB31A03DA4BED977F
      9A7486F4B333EE75E99FEEA83FA67F7AC3619FFEE90FC66DFA67D09FE09261BF
      834B46BD2E2E1977FB7DF9342E21153BE2DBB427135CD4E94CDAB8AAD3A5EBF0
      6F6FD4E7EBFAC3C1F08F55B9DCEBFB4773F98D4AEF6FD363973A95B66DE6EF7D
      719074FA2F756FE142BCD4FFBE57AFC85FAE7F795578958FBA53FBE91C8C07AF
      7F319E4F7A008879CDF7DD151E269DB9F219EADF3408B9C0F0294FC1E2E9772C
      5AC77EEDAB2BD7AEEDD58A8A20E38507C51D2258BF7FA5BDEBE3C4BBFEF2764B
      7D55C94D6D7F80B27C48890F71F455684136DC3D25E88719170B98A17E1E9E0E
      6A4B62BE5CC485568A9577AEF45A14C56C65A19919FA6CC2471983CC644974C3
      5F8DE415AAB36E43EE1D16F8123BEDD096E261F06889F536ABD4A47E8DDE831F
      9334F2CF67CAD32DE705AAA97E7AFFF38B9638535FC31AFC1AE814CBE9D0690D
      9E4689CFDC497A8FBDA18B14370DA69A5DC64A6DF9CEA3AD65B7AB6BDC68DD19
      D66D7AA35095F963F1E257E34D635EA343F60764B9BF96B0A5F57F9585BF5300
      1DF83A4B37210D8385709BA4D782AA18A9CB0CC36E307A8747B94BB0951B2B16
      EA6DD1D165C64AADE386ABA8FD667EB9869F7B147EAE46EC4B1AB10CAC9C3BBF
      ACD6777135A11DAE0648D8904729A2CA23D23923BD32AEDCB28FD978B8AD2BE6
      1CA9BD070AA30D7E6C51E2FD9F1FF116D248BC871F6711990866239DFB54BC47
      BFDAF283174E545824075329E8391F5FB8A38FB972FF7B091B05E1CBDE107B3D
      EA3E819F686D7FF7785D742CC8AFA6CFD6E0B028237F7D199BE1F38B8C369AF4
      27EDF6F873F3590D29F74F8351DF7989548D77CD7D1500104B7416BFC845EA09
      3A4F947F5316AC3FC3AD5EB9525AE790D67926B62CC435571C6199A645A38444
      E4522CC0B25D9A2A5C60B3CD6A1CDAA2DEB469A41911690E54AE96126639399A
      B95666F809AD5670472CA773E3E38C8C4A936141BB6AC25904CC5202E2E1AC04
      F423A9F7E1E2EDCBB18380A3F3D29BBD9EE701FD69D1239B48977F1A8C7B4415
      10A548E19ACA3A955E4BCD9DB4569A2C2F3345D145C599E526AE1BFC308600F4
      C96632D95E64642462CC4DB0E447443C6AD8CB51A6B89DB192DDA9F406A03320
      73F2DBA4888DF952C15A9430769A481BA2CCE0C14949B5E0771AB88769120336
      CC368C45E89F30DD67D298E1D1A1418D4916D6E9699D2F4C406A1AB5A060AEF5
      9D9BC0EA280B77C2982526F30416942D28D886AE151AA310066E12016E342ED9
      2498432C6078B0699C69E832C7100D76F3188F57806C420F396DCE9A26448617
      595541FC09B677525D371E9D567895A4E12F88F94566161D46317808146636A5
      E626799D639E4CA74926B56A77CD24D0A44D0482558C327D927F5353EBE254CB
      1B7C2D8A94539066B46C480C3367BE710117D4D0D543636EA108380A7FD166DA
      C8D6C26C0AA9BA6FE2F23637B60B4F9A2BEB3269DF7B59543FD83A094427A517
      D76A392F4CBDF914BDBB1EF70C5A186FD3BD62BA374C34BC89C4A992A64E0CAD
      423D29CB79C5FA00BF2CA366A4ED28EE9B30CD31037BAB8CC36E9565F236AFB0
      5D3480180AC34AC3C77C72669E6348A20EF7098E18E664238A07AD02F21DABF8
      728EF6A38A6161265DDF2AC18BDA15E72533734189EF76DD4CBDDA7555D701C6
      5678A39BC974CB29424E18F96075D8D0F87208E0464668F98E2596E0EA90EBAB
      A0D1BCEB0A663E096B7B95125C1603C78FAFFE135132D5A48EEC4C4D1E91CE9D
      5364E927C07E405BD57DD4A6462DFBD14365A2F70681A33C5998B309E14FD731
      26046AB4F527E5C9AC252D960BC742A4F3C5BB5ADD64E85D1BF00D41E1974645
      D298C8D136D33E7E9CAC31635B2317E7559A114AAC9557159C95BB99994E5091
      EE4605D8A6FD02DF4F1593FA2AB695E3EA88914CB8E3BB9152FF9F86ED364727
      6746292A27260FCAF8DE6A36736ECCC0071966D1C4352EB5AAEAD8102FCB5E11
      53D7905430760A0B8091528087622E9AC77918999260DB3EC0B8B59CB2A03FFF
      3444240AFDF4F6B4FFB3F3F6DDDE094ECFB7C7A76F20966ED3A499CB7CDC06FF
      35BB10972E41DE1464359897CC22D676E4C671C31FF5BB954A0E644C5D61C23F
      1789B9E146DA32F7EF23AF6E733AA8D21DB3D372B6DE25F076F7A268AB3C8D45
      C6DCF69F56064070ACB5B12AEF11AAED312355C8C6E85E0CC75CF4C4CAE0C52C
      CC4D9C7367119C66759BAABA2365183B29AC511E03B683F21837527123034D8F
      D192AB2C00BF5070122D9ADB721BE9BF3C6A27EDDBE0F81551C19BE7A6D044A0
      BC046382218D8A5E3A330CD92255DE99E6BEF845DE44BA3C4295333A33C9D4D9
      FB615179DF563A101BB9DA82D96B30CCE279B838DD2FFDB345114B17FE18C6A3
      2612E471592A07800EC6D65B327F59B198F0E96DE8E7570C515422E1E70BA003
      454E929C90542B03632B9F63E414DCA79162E4316A7D5783D24717278799B36D
      AC97F7E4F0879F9CEF8E78D610A09E1C69D7720E2581B9C356E4D987F74EA45C
      1D15C139D3699310ADA78DA4E1E33CB79F4C6750ABE7B615BD386706AFBD028A
      6C6184F785297F2C98B28924798C206F30F0915EFA0EB040F43A2DE22E73F6D5
      CC2635D9BBE0B4DF2B3A55C9BC46E22715292E569237CF7292F344D06933E392
      8F3393055B0BB36C2E00B4CEA783F97426CB4FE731479510CA900E76866330C2
      AC98982581F13F17615034C120131251F5381516809B4E4D9E0C22CA806121E8
      81FE7DF23BB23BA2C55472CC322EA18974798C2A3508BA588561CA9219891DA9
      0E67A688C5CA0AB6301008D9282AB12D05A92B89FCC6F2D4234674144A930B16
      79FA3DE0DAF21214F44442BBE7456897F9AB90ED8690AEBEB289279E49A218FB
      83DBF2BF42D93F8AD13EFF54D43FD5A6DFBAA741405200458BA485B37DBA0AF6
      0BEC14416F4DB90D98A3EB1C879018BFB420399CA3BFE3A3F3A722CB3C166C1B
      193B078ADCA88805A6600CB2C60EE3E2BAAB50A266225E33819DB99CA7667A70
      A77B25B732EABF89B47A8452957ABFD5A99BCD0DA96CDBFE2B2E37F0897122F1
      1C329689B70406B8987EE9F34C801BD40DD29B0212FC27B371644E5C8BC11EF8
      1784BAF601F701B29E2C66F5A53B119AAA520AB1FD3E62074D0E29B0238A43CA
      54BE4BE602CA5341F5B7D5027C8C7BBBBDDDE15FFEF29746E67C1ED0B54E58C0
      4668194AE99DBEE5D0C0124F8523DD157B409461E57388379AEC276EC1C59B3A
      C839E359417E2A8096B60E12181E7C5F19D82EF9158371BF259B088831498722
      A7B9E46B59FB2A604B2597A99A4AFBC89F62F7CCD69C9F1F16961AED498D3DCD
      2BFB64E4ECF2F1EE9D85783A1F0090D35EDBEFFF99E8B8F78305BF2DA718D810
      5813D7F9B81C958095E359C99904CE81BA45B14FEAEFEA6C6A2A6833A72F5519
      05A027C236E249FF638EEE1DBE431369B3843235E8C9C4BB4AA2625A8B29C5E4
      92D56B6DDA78A4D8AC02B08A63E3E569642B37EF171B406195857B0B80DD4D27
      AA78E016494FA6E5D23AC3592433B60B58658BF3274E2717E565CE7F6F6E7C69
      4F8851F7786C2F4A3BF0885FA30F58AAE9C84584B76DD8854D99E63AD3BFA38C
      B39C65C635DCB6ACF9DE290A17DC6B3A4FE12F40876822AD1E0F3C901471BE91
      F8030E19E771BF9321240B75A9A2DB9908367ECC498885E92426D7C590C92CD1
      CCC43ADC5D0E71736B0D1E93451F0AECE7691D4B096E3D0975CD187306E76B19
      C8AD61C62A2CF1BDB00F4F24977960B7DCABBF003FDB4412FF8A7D0111FFD2D4
      361683758B2ABB2573A82A130CCB8F315C3E6A1F0DD3163E42493D7BE782CCF3
      D9CAE7F6ED08C99BC561477F12E21B444A706215BFB6B5545A9A0AC60225A724
      BEAA00A79BBA37862FFE7311AB304D160AD94B76124378116D98813702EE406C
      22317E4746A05A1CD12A8E6335566238C5CCC592D66E2E83CB8BF17FC07E30A4
      6C22F9FE69D8E9A05E48C0CB19C00207872D7FF29D6692652AF1A16504624357
      DA350DDA56A57187598E3CF4E13986D0CF187F4B9AB1B0FF09D7BAA621D70C35
      71CD8F1D0E2F55D99574682BCF33691AE4C06A9C9AD404C84CA88C3B41E49CB4
      2471C0761EDD4C4B79FA4C21442ED0A2AE6657D20098237CA6780A503118C800
      00D8C8050455F13DCA767F951332730330A064454DDCA2C785F9D64F075ACF7E
      2E4A48B74F4D0DE97F210E28381C3B5B2B7BE8506A1A25C9B5648E6DF497F3E5
      7696ABAB0DD98DC99C03382717DD51994ACAD077B0DD9B8B6132ECA0F1F2BDA9
      BF31B18CC4D733705F9EAA38AAAEED4BE34DB53F0FDE547FBC40675A8C459CEA
      8F0571EA5AA78894F5869FC1BF37B1E95846394BC0A3B7DBDDEDFEDB33E490AF
      0F68347AF680461F8C116D1B66806B9EF808A07301CEA7F343AB22779FE10EAF
      5CA02CCFEA91FD8B83BDA2EDBA91614AB31E2F21752BAD77580D6376036EEFB4
      D772DEBEFB413CD2CADE3571A966BE26C996DD76139FFFD3B0EF5451FA1AF5F0
      3234984C0D36F16E541ACA545D76A2B0323317B5896B2BA7AE347811B00A2DEE
      D46778FEEE137310DD658FD57592957AB7D3EFFF76C5CB1FAEAB79C3E8E6114C
      4FBECDF350C07BBE5F99369FEB3AD3F932E995F22CDAFEE750CC9F75FF572EE1
      2D524387E7EF0BEF5BD0B1C839BF8A438F1D4E0365CCF52CE4AF3F47E3636D5E
      AEDA6769B3FD166DB6082C1DBD7B7BEA7C8BDAAE67B89BAB43EF3AA0D386E699
      D096F47BA65F26D5129376F6F719FDA989CBC3A323CD93A4882E88665C6B96E6
      6A96CD0D541A625BAD909534B498705C9F7970BCDF724EB9C91621D1CA3B87E7
      27CF9087D70277A5C0BD383C1FBC62A96B1DFBF78767DF3FC3BDACA33B7AAFC8
      97FDD979B7F7C38911484D5CC8619C610E8AB243180448016DCC08D1668533D2
      E8B884A09F93FC481193BE559C6BD397524486D044E243B5844D0D466C6E1C98
      5931FE5DACA6A147E6B7B45004A18EFCCC2A4CE9BAB6A3D09433D529501C662A
      F7AE769D1F1181465966FE12B004F0B155246DB60B370B03E7179D26DCB3CB59
      16A0286780CB4CC4588E243ECF23D6002D5FD4EB9998BEF95AC99BEC62A01A92
      2D51261001C804A07A234495282EE5F6C2842C6DE3107371B979267A9A9C3C94
      1A8E49B0F20A536368BE11531193583F47D37EE54ADE9CEFD1D73B37EDDD4113
      1F1FD183AF3015EA65461FF92A4589B362A22AB3E04C490F9C85F99356896BED
      B8610C309CD0A7D3044FD45433DA4E66EE76E36246E421E5C3BB02057FA5B22B
      6DDA3455E4CD23D6BE52707C723090FCEBC5DB04532AA2D04DABF33DD799A7DF
      9E79EAAC334FCB2CD5F173B754CFCF0FC550DD676D89EE8D68EE3A599DBEF819
      52E8CE369C16E3DCECB460650047BDE2C4C2EEB0CE0FF1CC17EF4CFDE75DCFF3
      BEC61C3008AD67782AEAB82F8357C4183F3B5BDFEA18A507DC5B7CEAFE5D7B79
      B6655342322FBB910B2C9C1AB394BD3C025ED8ACB186BF41D23BED9B053515D6
      6373E3FCFA2E0DA7CE0F679C3C7D0B388F79DEC7DFD99C05CE6BB2A763D3EE0E
      3FFB873328A15DFD89A7381209CA175A7805954F2BBF779E1BC08B9764770F6E
      527CF06590F4E9B7C2666924636C6E045C6648FAFF351C9AF14B9FBC3F7251AE
      F427E56B2F9C927565007604A5130EC12C4D6E425F7A21B7DE20BC6A461081B2
      498A219D668CE696384B2D29BC3637E2866257573A2A79A64813E9C775E80B53
      318A644918FBA8458DE1C24DC3881E9EDCA8AC65027CDC02414E563CAFC89595
      2A836BAE6106975F99C451235BD83737B6CE7426C389E65E3E4FF5D643D29872
      7E799D2BCB672AD6766AE634942AC9D21F5771536961919A6C9A713931CE6CDB
      A8EFBCB9E32AFB5B6968B821351C15BD0A45AED254D4B043044CE226120765CE
      CE3644F97F91D1B173A2662798DE9466BBF9A79CCF579D82CEE2F3FF3ED7597E
      017C66FE3C310D40515009CBC5E53CE74760653804680B1205D6092718186CD1
      9CEB68E1E6C8554D246C38851C2F0250923A0B1B6BE3DC18782A777E29153DCC
      1B10AE5353A8DCC865C5951212562645287AEFFD118744CA89867FCF92B8E5C4
      61406A668AE86EA822FA354A7C89906C6EAC6319BF2D96B17A9BCA60C73AD4B1
      2CD4316940A8E367C7B817E79887450AF5D0D46F1ADFA2383FCF696BEBAEECFC
      B0E1CE9F7162C5E573FAE5A6346F29BFA27A656A04101AC43F6A2834C89F5F1B
      AF55E9EF4D0B74767B6B5DB944577697EFF15A57AE75CC139622F39BCD0238CB
      8266BA2C52395748D86E74096B16F39EBD643A85A48EB88AD2C6369BB9995BE7
      66007CEDC8521357B9DA8D5FABA8DFA1A2D6EEDC5215B5BCB2F6F9A8A870F5DC
      99CD8D3FBB11CE85A64516B3AA0A2EA3E496E7946AD4C334726D4592F62D5735
      16E33264DB04935E2B8ED312011ABCD2CD0DB38FF869F652DD24A19F3997927F
      675C865493938595627FFDF98C741D32F326E786699892C0CB5AEC9491903306
      9CA95DC4C802841357FB40984BC7905E0C732F33C24B3C56C4CED78AE7F72B9E
      75C9D452C5D37DE68AA7944B7B8CDFF1FECDE15E8351EEFE6449A21F4EF60E10
      8F6221A9A7B3FCCEA1AF52778D5CCC27A30CB01EABEADE9CEF357A2CB65D13F1
      9D613B03760BC80B0D842405041D41D789C84CCB3C35D3D07B4D5C2DC909ABD0
      51CD74DA93BFD6EAF3F7ABCFF65A7D2E539FBD67AE3EB31900B01A9F27904E2B
      336B3ED2EABAC1ABC8CCF86E92C0E80DE72AED83A3BDE3E6AE28881295DBFA9E
      1438C80D75F0957FA3B81AEC24F1B9653F7302AD504CD7C4D5F8A9BAFCDF7E1D
      98FC64C60A73CB00E070D7CE7DC4DEAD858047487B7C13FA184AC098A14DA40F
      06C599DE25C643E5387E3965AE894B2AF3A98D6FAEDDDC2817E340DD1A504DE4
      C4507261322D72C1EBAD5C67F9EE4C814D4D2CA5085AA17C9D811F51B5D8FF2F
      2E5D24DBF0BFC85ADC11582454AF379146629EA92C4BBC50E52B2FD7A6AD3510
      DA2D191FF7C73707A1E09FB6E98BB743B61EEF84A295FF91CBED3FB3E5FE719D
      AEFFBC1B24BDAFB15AD65E5F67C1F1CD575930C9271D674D95EDDCAE48369673
      9A5EAA38FC45A7CE76A7C591F0EE0E22E081CCF6CEC9B1354395A55B7F59329D
      369E68F0659B1C5F4E13F394AFFF8FF9055AE65F3F3723347173039912FE353A
      ED79C61530EB31A3320ABDFC2B9C4C637E105718D4F126EE61FC95A0124E5F7F
      5D9C046E0593F1DAC93C9FCD7333BF897D1E588F26BC6813851850399D7B5786
      E9A5219B84B39A625ED617EFBDDE2202EEEE7EFC48A2B590AC1F3F92B59C7DFC
      687B8B7DE72004707A4E4BD95A223AFF074AAC32C724AE1F39B557A16F6234B9
      A6BD64BA292F4F2C5A4D33978925CA8C4E04FC23627924B279C6D4C5D9E1A1A9
      5E23C62872DAC55070CD826C657A2BD605764F7307163CA80F6881140F6ADE5E
      FEABC191A35F8ACEFD86664ECC927FD46A96C4AFF6D26992BEDA9B4EE7B12942
      9D2121965D699D3792F58B9A8F37A70717AFE847975D8672601227320B387881
      5E30139C6FD9DEF49DF98C85BB352D30382589E68D0565107A1CD97CF4C1E99B
      FFEB5C115168B12B3FDC489BC6ACF86CC9C0235F63944B393FAFDADCBBCE1AFE
      E6AC617BB7B72EF75C9A36EC3FF3B461986573ED0C27AF39F23AADA1F9C918F6
      0449CFD84DF7D0FDB81B3C404AC14C0644959BA3A6B80A9717607E4018B620DF
      8DD43542BB4E9F88678A054332B63E71A7BB194E2473878C083A055234699669
      2357BBB961D63BECBEAE8CE14E935CDC23155F46D0A2E9B41C70B55DF1A49079
      618E296117E0AFEC34911657497EADEFB212B664757ABE823C62104EB6BF4238
      EB1027F5CB874A5EB23115A6D3166A6967CAFF1AA1BC6FBE428888F71C78A3F7
      C3F49F2309F3F2AB2D284E62FD75120F5F7EC9614CC22A6FA498DADCB84A22DF
      39BF0A83DCE0EA66B992A21431DD1006BB0E673C1B32E131854638D175E4E36E
      C30F22273F25F195CF3D8396211F2553961E9A874FA10D4CD08375769DA3C680
      9CC84652EC01BD380A00BA9C7E5F05A9C239A841FE0579CF38D100610A018C4D
      549F19030A90C9BE0C63365A5540A50153DCE00957FA13E07EF4A3CBB3B46488
      6775A3C2C8D665341830501E9DA7B186193DE91D27B72EC9FA335553B4DFE28A
      72A7146943135ECE9C6D3485F05879762A1A797EF6F334FA661FE8DD21D61A47
      77CE3B9470E0F1794E7B54C7CE9CB989C208D6C3CCA34F24A6C9C6F901DDA672
      989A489BCD8D6AA39C4154B7E71CA157E33BF97332AB031565761A0B109C0579
      DDB4D449EE01ED5A8D3C2306134C0A7A34432C0992628B787F9A382FF618AD6F
      F96528FD79D1C4553F52B155C1A6CA5E232C2B034B180FD216456DD3B1AAE199
      47DFFCB8D3727E4C5272C36740637B9326B71952EE7B51FECDDB5E2325CAE646
      C10033446DC9ABC6F0E524B99EAAF4DA685053B9F85AE44F67777760137CAAB8
      B4E5800AF6BDCBC4719577DD448A543A3B022CD102B6FF78767C0090D1C4A6B6
      E2E4B6E5BC48E21715ADD2C4053FECE2DC7635ADD944F15B00A72F620A1CA468
      665441D659278F6D4B1D15D23780F4249323263D4B46840CBFCE220CC290B655
      9209B348036CD6E89CBB649E16D0786160066634916245B6E7EC6127BA59ECF6
      8F17DF9DB538EBD1E2593B2D4901CDD4EC2E9D677C7A5ACEB73A3FC454779E75
      508C9F25CA156D7CEFD4CD0977423BDBF9958AAF5959FF3D896FFD518399CDF4
      5A3245B62D4998356AD03ECF76400424946524EFF10FC7DF3ADB9751E2AA88DF
      A217DEED3A17579A271EBEC8015EAC89B68280BCFF3DB2CF39C6C0988A73D34C
      8D7BE5FC21891A49512FC335D2C72A7DD28DA378DF52FC6F67DF1ED0AA5D9B86
      4A9CB3C3B7C4A73C44501C84E6CE84429905EA0FB8CE2F955683F7C707DDCA82
      691FDFEFED7F4FF28AA3A8A8D06EE64A5169F1E6FDC5816C578D53C328CCB6C3
      C24DFC3B5425E5529101EC24BAD93B276E2A8F333DCE34BDC09534FB87C7C77C
      9CD938B9944E1B2599214EC4068D9DE620BAA7FFCACCA4337545BCCEAA6176FA
      F6FCA2A2979C6DF6E45E9C875C38660CD717366E00F32D0876D619E9CF90915E
      E3402CCD480F9E79465A67333396CA0C49460D3989125707494A52239B361354
      CD644F7BC3D718A59BE5E47D3AA418D32032D30EC8D0BC4C759671CB9D270954
      047AA204BEDECCC6099BBCF6D16B47FC134190A8E3FC5B8B8114240611E718A7
      04CF27738E2E4ED021CCA16552A90B3846B10686AA476FC70D2DCCC68011B4DC
      A23C9355C618CD8B295B4BD93FE6A8587353E2219D3FA48CA946B80C394C2081
      427CCE62CB32567F46CECDAEDE757EFA5FEFC3FC3C4F663F37914C1CF03970A3
      7DAED64CE2C5992B528941674A5D22BAAA5C14AB44386AFA069488EE60A2D619
      20C2CE4762A69ACA74886913E9C5FE4531EEC234A8F374EFDB327064E6CA609D
      BECC056D687400A02EA24B705EAC22B943DDBE9703E9DFBB929C677E65D2516C
      7967B60B60207E2D0C7420B5161FE0F495E12109DD37913E8F44A45BCE8723AE
      CC4A93E85E787A2FCB206FA62AA603552724DDB21F716D289A0F6C4363D12666
      222AEC6FFBFFDF99B3AD635BFEF60B72BB458AF3DF76169D5D78F78D5FF2FB93
      A3F306437299B5484082A49B9B25DC198126F3A8DC2EE2F393D383372DFA797E
      D072DE7EFBED1EFF3CC7CF8BF306AF7C6E86A61FEF5FBC5BF049D149A7FD8AA5
      F0E1FCFBF7C6E26EF2492D349AE9D5E3FC2AEDFA8D7654142A249679ED0E590C
      107410FE4D5EAF988C15204F3B469B636DCD3DB9459CFFC581F8B72FCC10F62B
      CDBD3A1583E5C5CB6EA73FEA8F7BC3FE78B78DFFBD807DE36A1E88CC628CB800
      7129D3042537421C9ADCB2BFED1FFF584A822692AA10729221DA4240EAE3C753
      F7EF7542931E2292F3181830A64CFB7EEEE84F91363234AA4EAFB7891E294D87
      2CE0E11B4D5D5DBF14F6158BBF2AF3E910309C6353317DCC2A45E2BDFFF6ECAC
      626FD18F743E2B064BAAFCEA3205EAAFCCFC53370D0D092C2C7989903FF9F6F0
      6D9D980AB81BF6A8C8BFBF1D9FEE375FE41574D9FA10CF33FAD75645FCEDFCF0
      608B847CDAD44050D9B32C0B940287C59D7FF77EFFFFB59664BF77D78984CF90
      485823622E4D240C9F79226173C30049A7FAE6D53BDAB413CD739811BC31F522
      F3980ECBAEF381EC1B15C00C240391ED44E6824426E69A9E07A42C15BAD9D2B0
      72B29E134BACA4C8B906C2311320D5FF988729A036A54F8D61867C6E7E2659E9
      377279B2DD8A360C153C8F81086147317929B82B300F5EC0E70DA5578F33D7E0
      8A66669938BCB657615B14179338D352507A5BA355CD4F6E1BB9FD5BFF773E9D
      F1D0A2A4B0FDC4A87991D916CC59329BCF18D4A1914B3C8C118C7F6582F2DCB2
      4BE6AC349C9AA68946AEEB38B994D387FA871B9DDEA6213D7A8C4A91DEC99B46
      2E6973E3A74F07C490188A96AB08DD307A662ABE53048A51FF8360C4559ACC2F
      AF4823E185F736074C07F84A214CC5ED4259AEA6B35DE72877A61CEF7035BAB2
      827984EB72A401716A05C485EDC3A692CC6077D04BD79955C61574506926C7EC
      0104EBCA9192BBCE7B13A5A0FFF6BFE74E134E87729EAE91C458565CF42B55AE
      92EF64A8E98B1369C9479EE6CE20DEEEEC7ED111D6BFC7FAFF0CB8542BED209B
      F47AFD0C39E3EB1BF6A3676ED8BFAB4E7687CDD7C803FEEE917EA0ED3046DFA4
      344C5ECE2305E37C464AA14EB50CEEB0D3587254F3CEDB17C7CA2513D6871FDE
      722EF6D1FB764CEB79937C6AE60A3737CE0DD39AC236E50138926C008EC3594C
      09C990730FF2376F5993C184178F94E43EF9359AFE360A11FD72CDA4C699C9C2
      667771AE3E3957246B22C81B38E869D1F667FC962F19C77AE6BA0B43FBB2B5DE
      5AA6B7C6CF5C6FFDA0D250460887BF002B213778304857F0048686C61C4EE70C
      EC2499C347D6D5BC551D499CBDD31DB4E8C7103F26F83176B6F1E35665CE16AA
      02B90D0F4BDFDA598BA9827A2761E6ADA5D432293579E6526A73631F880DD3C4
      0F83106DF70C85399DA93C74C32824E79BCD1537A11F079AD6183A7F3B6487FC
      6F873D8B249B0149364BE629A00C5080D948112001E5372AD3EFB09E22FA9025
      CE3CCE247E235310D9A433687698103FF7304BC824189AB9F83777B9DEC3E29C
      48C797B4D9E497A408B27001CDB0EFB8619EAD138C9F21C1D89DAC138C4B2465
      6FF9263F1F49C91B49871E82E12634A5E5D3A40E7AF654C5443320A8316AE6C7
      20F2E1E9FCE7C77FC6AF2867FB0A72DFF9EE3FDE1F9E1D1FBDFBDED9BACAF359
      F6FAD5AB69629E75D7D737A18A011FB64BEAE015FDFBEA4267033CF6CB23A242
      F6B23F1C4DBAA3F164B8F5101AAED6D30F27A3C168DC7FF8F0A00B0A3A9858F4
      A4EDB6DFF6265A8D26C1C4559EEE74C6DEB8DB6E2BD56EF75D3569BBED6E5BFE
      D7937FF48AEB277DB96E386EB7477DF31FFD3DA2CFF7E8AA6E20FF0D7DFA0FFF
      4ECCEF449AA1A66B3AF255F8AF4B7F0FE9F3C3017D7E68AE35D7E1BEF89DB898
      7FE76B7BE69EBEF98EEAFBF4F7C0DE0BCF42FF6E6EE02FFE8689B98A3E893350
      DC49CBD578BD47EFD3A96DF768393DBAA6D735BF8FCDDF4359F96832188F3B41
      BFE776FC51D01FABA04B341AF85E7F3CE88E86868E44B38172B1D0FFFE6F706F
      E4A759F454669D471FBDA0FB59ECCCDFC5A7B4848F19792822E5F01B048CFED4
      FE28E9C2BB517BFC314892DCFCEA2551F609BFE8D88FAF74AAF9D3F808EACB20
      1AF96E22D8BCE86316E4B1FBF75AC46198C43FF5E8055373891ECE30060AAEB2
      1DCFBEF61248CFED33D397B47776B2D772DEFD707E8422FC836E0B4012A7CD8C
      7399751FDE100FC132445C97A1E09C4BF4C5206B5743341F1D48C117AA13A2F0
      17DC44FA951A4C92B78FD531321A890DF0CB402833E132993571BDA6FBB5DD77
      5ED3A2D18D9600E40B6027E435A0DF99B100B3A9B38D5F2EAF922CDFE12C7191
      FB6D680CC562468FC7B4F4039943C2D15DF888400D75660A834492683E25C731
      CC81B8495E14AD0E034779F8060484694274B6FD39976429E70A6B5FD9B5C9FD
      1E649D31A49E3BBFDC01180DDD30C4D412046F24722303C9140A2C1B4DE64E67
      4274B67059579C0A57BE8F4344B4CF32E76FC767C745F7A7199A09745BA97993
      54314894645AAEE599A9A433C9BA4DB9073F0E2F638BCF63ABCA8F2E4E1A4936
      4BB436118DD34B155C456E8865BCC5CC8CC125A11DFAA6BD38DB75F6A22C21BE
      D1356C945B67EBFEEDB7102101008888B94692EFB452CE6286A0219705AE62F0
      2652F0643899B325F593AE2695057FBA910B2EA459B73C65FB6A46CE6801786F
      4AB463013CE5267D6E3CAA34E7FB2142483047898B0EB44901F367797E021F39
      D4B26498FB08F44FF0E23AB4BCAEDEA81735E93CF3A8C9621A1C055B6C0D1506
      1F479731B7CE0721672A238BD7D9C2A4B12DE75ADF91D66EA62D8402870AEAAB
      C5BB6EEC5A1614D8170D043F73F9B4CED03F2A9BBACF5E36ED23D395B293711B
      46111B2FB622593B70D73ED1BAB9628B3C391837A95C18E60023BAD13C4632A1
      65DC19E411575F85713345963190BB0318C81614D53451CBC83C06A75A791FF4
      9700F0A9A1F50D857BD5EDB0A760061919A4A12470CEC8AC45BD83CCC3642462
      7637C9C03B2B062515631038E215A93B49A449DF118C6371BFF8ED242637EC1D
      4FA9E33B97E396FEB67F7C66FDAECA16E8D4C25A349AD1DAAF3A1D840A4AAAE1
      FCD94E6699C851B46849E75249E21AA219ED3DC9F57CE6F8730EC4714F976FF8
      9A51B480EFC4033AE671AAA3B0B11ADAFAB623A2E61B99F06A2AEA3ED881B0F0
      E20F4C274941F00CF8FA4D5E307C33F14C9D2D03B22961E52D6298C81A604D75
      41ED2A2188F67EA836B43B55A43CC6B322A1C1DEA85428EC3AE71237C6B64F49
      569082525154275B69B008216E20994C1D4474674F91E6D83629FCAC9967A590
      EF6DC89E1F38500F5046435891D070D8F1D7E1F9098326EC3A6F94777DC9F1C3
      721C62144E43E3E7F3B470FAB7C02534D4E286AD86D369C4068144EB95F38FB9
      CE72AB948C12A415A54A50188DDC09527509740DE9CC27CDE76A3B5D9DB49673
      BE9AF797B1AF67B348CD6D7AB2441D12510F391BB2D0856C1A7481702908757C
      BA91378AD5CD9421E977C9E7A0C3F901C546C8A6215A5B09C4C1CFD64180AACC
      1B3AB5C5F145005CC27382F4D448FA59EAC1463D35863A88274C69992E7388AC
      FFCE2FED19E0273447D9D440D19C57431A226A272719F9AA9665C6907B880113
      18FEA2FD92C806B656C28040A6683495112AFF210989641777336DC6D490118C
      0CCD6CA6C979DB754E8420999CD78593B98E0E38DFC738BA4C95758C60598CA0
      F7EC6304D65BE9D161F8C0E9E907D923B11950226AE477CB0A026B54901A2307
      2361F8E2D7EC88ECA3AF2710A7B2883DB816798B5424068FE492BB2C86CBF1A3
      60CE5A33AB234AEDC776BBFB77525285FD6AAA6D0591D500B42932A62E6312B0
      669C1E19A42FF2821C20235FBE6BD39F7EA291CB5BF92039DB659589D5E68B6D
      41B3D1BDFC176D82246812447D683F4CA3C35ACAADCBFF578AB7E73E10BEAC25
      8045B50527673E33ECBF25197137F944F2CBBB4A520961B9498E417D98E541D2
      AB917248DD242120FFC44303C6B7075440D42759D390C46FE230C880AFDDF925
      42805FB4E1E7CF5BFE3E5E97BF2F9314CF7D50C7E6C68FD0D3390AAACC283EA3
      0F43644072159B91AF9AFC4FF4309380E0D17376F0AF1849E5E869E859FA8DDE
      5391F34E7F9AB3D7769E6B35655F35BB4ACC6810B2850E58F1ABECDA512EC626
      F16318654D62683E6D328EEFFB1AC437C3DAB6A55AD206FF768AD152B03025B3
      3E25656CC333624C82521664E0805CE424769334760E8EF71B4CB42D60BC191B
      D2393AD85A565A6A22A44D5CE50556676A840A64ABA5E542BC623BABA0894BDD
      338D86901E9214AB8C0EA7174DE6EDFF38E376FBAA890BE41CA2267DB0FA984B
      456C1085C4D45E12B17319FB769CAB2D9D256DC31D7A4D1E9DBEB9B1B53815AD
      00729316D4D80B617C89AB6706FF1EEFBD3B90B19E4C15FAE5A83819DB32807E
      71F2FCCEAE731A57E6E11A3840063E149BA465064F87BFFC09C6D11FD9F1A54B
      E77CC0140382C8EA426A53E5F34541A4FEBC06EF686DF02E33789F3FA0ACB134
      3E9882043F5451C299D7FC6E66A606099A7C6777FC0CB7B8C60A8FA5C148BFF2
      B5E935D2CE3C0FC6A6750981B554C55954366F99DE8C9640F8DCB1F89D4E054C
      96842B0A3CCFF394999FC8636A3D01C06A32257902B82733C1A1894433A8BAA4
      53C42E79556445B2EB7096115D7C9F0C32BDF2463271612D643F8F901DAE85EC
      3221FBDCC1FD4A10D0D3830B08183257D85AF69DED3C4DE62E6A2A394170A06E
      E3CB39C0AA75D64C6FBF58EBDB62D4234685EDED1F9A2A78811871C3198FAB62
      C7D6A4378E389652A2B4A4CAD3CEFDFA1F994F67623364EF155D944B6E297D79
      65B1818465560BADE622ACEE99C23F1E7848ABC62F95027D06E7E3C29D0A1E1D
      7915D668B6AFAC87357F0E693D584BEB65D2FAB943DA15128C1C4D8CD4E4DA2E
      CC3E3F7A7F706EE78A8A187B86FB5B37B2283850078798E46E8AD7F68EF7BF73
      B661F06F1D68017C6259815C1869A8AD66EB23D6BD95F9951943CDA79A07071B
      BC52BAA68B432C600DF4F3944330ACBDAC2242002F61B007E4E2C9297204F8A1
      89C42979C16A0DC6ADE01AA7D8C198B572FDE00BD6137C1CD48DA59910A1D9AB
      5F6D126C6E90CD024CFA0A1B9CC8ACB5F7EC1D6FDB119C443896FEFD1DAEEF40
      1D4B51B78859157119B377AE54C683D36D24AA81346410771B3C988619D70EF1
      7CB6A68F617B14CBE3FCFDE17183074FBEE7F6D3972EC3DE9531D4EC8ECCE429
      9FF7ADBDD98CB8567A5AB704B2629BCB24CA1E4FD88B358A660AE6C6A0714C25
      CD9346AA912D830C20D468E40AF648BEDFFDA23198445681AC409AEA38A7BD36
      19D6EC73E03075EB2ECD3C7277D913779D64A5BDDAE9F77FBBC1CA1FAE6BB186
      D14DB4BC099D6FF33C0CD7F3EBBB349C3A3393458F92CF9128FDAC9BB91A7FC3
      8DC21B4461CFE6315AD64404BD4F139448A458527D7C415AFC1F4FF3FBF882AF
      5FBDBABDBDDD8D51E9314DFC8CF1DA12B3AA5778E555BF331EF61A082738EA2E
      8713AC42098E46E57F0C03A80DCC1F3E63E0FE0AB8C1BE01F45B061788FFE8FB
      869E0104B4908306087001B6D0DE2730C0801DC00932142020027BCF160A7025
      733D85A1E87989E19F09F25FB371FFD62192D5DED08964E0D126A9A4AA3F4B9C
      24C080331E550BFB829D24783D5BA7C8906DC1FB165BF20DFAC651C1F02AD58A
      BEDE05EC40E14ED123B79C73FD0F06966B39267DC7D9B996A3736FB79116E4DB
      798489693318D8D78092923077EAD8540047602ED691D7CF1079EDAF23AFCBC4
      CAF387E9BF578C805E2287DC6C3A257448FC087E2ABBE2A6DC7637FFC4C5B97A
      BAF2DE333B612F71DE9C9E9F335E2B0701AD43FB0C39A66E04CB442A6ED089CC
      0D3EE5343D1C8C7FFF707ED1E0D5ED1F1E1F3BB70A393C165500A49BCF381EE9
      6AC0F115C58495412D4D5C6FC1FE7B1C989E26DC5517E94BE5DD3967EFF64E4C
      421371D97F11F4198B1E66DE9199E9885BD3CF13FCFCF170EF7D8B23FBA4608F
      CE9B5C0B7D56A7AA6F730376C9723A14B15BA6D562F4761E672AD012DC9FDD95
      0007367AC500AD503422791A6981FCF4F6B4F7B3F32EE1E49529363D38DA3B76
      80F8306B64A8968E4C314954A4607A7F9EA88C0657977E12450088A53B3A5EAA
      3234426150B669D9E0960E8E831A9BF6E078BF9124018685B355627E6D99A9D9
      187B03AC2163939B19E19CCD0992082A360C4CAF0BCC7958ECBA99D856458130
      90A6C8DAB92B8D0762874FC3BE897537727BBFA3BD72F62FCE8ED9896063489C
      0A83AE813947418D73438722283D92B5D7F119BC8EDEDAEB58E275F49FFBC89B
      C2EC321681543B5B8036680F09AC57D325B4E5535C9DBD5E274C966E79231226
      C79041622E662DE7082AA1E59CCF34190A9F45F37DD9DC09ADE2F5E2225ACE77
      5A71442DA7DFDF2AEF73F5FC7CD9859D294FBF76BE53614AAB38BCD3954D6AD8
      4AF6659A9E4E9BF7E8675AFA239AF7E4E860703065BB798FFEBDF1EE57A72193
      F8B5B3974E93945C5DAD668894EF4DA7490B52616D9534D72A816BFB8AFDF61F
      39EEA953541BC2D6FF7070264E9A002B61F6BA73ABD8CC25DB24CBD425830638
      828C4A4A4EDD9C08B2DE33E487BA31201B187EE0E567BB6B43ACB986D8E6C69B
      F707173C7FDAF687DC113BDB6E3D5FA2DA12BB61480C9EDF433E7C9C0B8F8701
      3743E74EA4D03F4386B9B35D9669AF7E00FE3AF69DF14D9F23BAF7C56D3F7249
      F310A89002A17D5BA1245E27A2F9FAD31F1F35FFB2EB466AC35106FD72113BBC
      5C3EAFBC994BCB72E6E5875BCA6F347465457CAE50490C03185F7398FD20BCA1
      C5E549FA1C63EC6BBBA56E4A927CB6B77F73665749ACD18977CB968A9ECE6AD4
      0C23532B317953705DE9BF68A4F1F2B027325BAC28E705223BCD877E5B527B53
      524711EB44CF4CDA82F0C6A5FF22D7451629DA0A4046FBCFE7620392CC47C763
      40AE0120421A4DB77D2600845E9ABFD4B10C4E6434648CA6A05F3056E1FCF0DF
      25C3B18D2E5200444BE2A3C8E8C8EC12859E0C4F37932265679A4850E94EE0D2
      FC70E5871B3A1F405A4CF6BFDBB34D177C266CAB89001B5EA928D2005532A015
      48F01E20F67542DC7F875C5E83977E60478572B2D6246F5B221994CC923510BD
      0B42859B704CCABB91AB7F97708B1E0F1790A56DE1645FC312BA05622DFE9209
      0EB4DEAD46AED1E669D14AB73ACA436B929E6E008C5824A93066CC72F496F93C
      54B18974D8DC304D476FC308AA1FAA6EDFA4E4A55B05C383722D50C5927413C6
      08E403193935007311460167CC528C873DFD1E6D78B9D0C95C2B946A31D8B160
      0E08A0A30144E6C9C59FC2DC22275FA66ADA1298C7075F66422FF82E9D367554
      91A1B9E1A7959757A34A4D962FE7025B6E8265EC7C2CC4DC5E711F2058EDFF45
      C925D71ACE67098F4B6BE674DBCD0D3140A72146BC019A830F0B1F26B2975E00
      8B31F66D6988548558588EB4ACA628B89F43313243B818622DD0A6B8378E11DF
      9A014FB86790AEE06FE0FBE16B5ACE6C9E73D5495CAD4A49EB147A25B92D5C11
      E7C27E9EF6477BF39CBF90ED41FAFE6DDB58B44B6FB61CDAD81FE4379D7B6BC4
      E3CF52FDD05D573F2CF3D79FFBE85AD334782EFD9F8D146B98DC5A409A6752EC
      4582AB894B912E6332F05CC6A867545C808F804B72008562264392DE35727167
      7AAAA72EC9EB599299B19BA40B10ECD3284585FC9E2A1E06650CD9E62DB104BD
      229DB4DA212F26B03192C6F95518E4DF1CB8D17E147AD70D35E47FDA8BA29F9D
      1FD33BEDBC51D9957379956430142D40FAF683BED72E4BB8F67D2516F46B3FBB
      7DA6DED267EA39FFBCABB3D92E3FC96FEBBAFD1DF2750747D83816128FE2B99C
      CD65F19FF68E8F7F76DE1E9F5F30F08D834797A2E1C5CC4B831777787074E028
      9E2E979548D54596AC992B93C861B59992A50F2A460C7B4695F74AAC54557386
      9C99E16715585E42AA36995E2FA3D736A5EC0003161A0B06BC93D172BD2B8173
      4F78808A606F57A966063B3471F9652F92CC6D44B8B590E22692CE51D64A27DE
      2BB4EB71B71EFBCAA6D14063664350C87FD0A091149158AC14579D24FEF7E4F7
      1C9D9C1ED898B41D5181E0C88D4A19A5B21C5FDBE015BF3F3EE82EE2A63D98CF
      CD2A8E0C563A248D5DA81459C9384D49AE5787B239B4CC34C000DD20FCD4CC35
      DA0888CD4226B7A843BD0A679683A5CF96B6120D974D5FE3799CDCDE39B75A31
      36B7AD13AB13558274FB542D48D84BF3AB6992A4EB38D1E788137526EB38D1B2
      3851F799C7893637C2B2ADEE7EF1258E89845D38EBCA495720589B52B3F5B9F9
      0CE7668DFDBEF4DC3CFFD1BA6F31D37D9EBFFB814F047A6BA72ABDA673842A06
      8B751E068E3F9F919FC9853ED2904D47EA0653B631F98A5BD39E2103AC4E16B2
      B1C10DD7926D8A92E49A7B5573C755AB3B1BB419F35E8E396B2215B6802F00D9
      29603FD9563167E52A99477EC5A49691E3CC0F3A5761E4DC8410051C0986BFCE
      6561EB711A9F45A4AE01DA978AD4E73FCED7E799198E8738397AFA951D9F67D2
      C8B6FF85CFCEED1592C05749C4810C6E9DFFFB7C3A33E8642A6F3094EF03E1CA
      E205CB9CE9F4DA4ACEFCAE0649679C9D3F8C91E07F9F847123F1CC3737C4813F
      67075EA03011909157BF31AFBF076D0E853617773329AD0714B7727890884FAE
      B1443331E1D596E017C0C7B82198AC80D5E042D426920BA5830BC708A5C42919
      F07755CC10CDFAE9D649661A963E427A1C3776D425ADAD89EB966313C62F19FB
      DF2E87D89F1C1C3A38D19DE321DEE3E43518EE8AE3C2335443195A2144CC965B
      08AD0392A040FB127543CA0378C0AD8C18D6F25E8CE90111BD6CA64036D3CCDB
      DC38E1313BD2A0C7349017CE64E60E9B2DD2C86222A5187EF4A3F42BBEB673D6
      F427227F8889612A6A598F92C9E5D127D753697EA7D1D3DD1DECAE414A96DA3C
      CF7F3039A2B67480B24CA7F9B2A9041EBD8EEA89874987F579F91DE7A5B33E2F
      CBCECBF39F6BFA667E894CC76B278812C545363398B5ACAD551A6632EA13864D
      843AF1AD60FECB2F775BBBCEC5559871F750AA33247471A4D06372EF36440E57
      A77203734B043550EAAAFF315711C37192964FE697ACECEF1C5BE66F7C94289C
      627CA8D43D29AFC68ABC790A2448FA8831DCB6D1B89CEB9DFBCFC629AB6CD779
      23B5B55CA48ED1796890F6A4538C2B66F9639938412610E1EA6201B22A8953F1
      2B6B79F219E449FBDFBE12159717A23E998ABDE1E299B53424A2310DEB00BEAF
      8C969D69395EC6AD975283DDDDDDAD2F48BBDF43ADCF008A5F074A08EE0303AA
      9B5213413020768BD54D7829252879AA3587415EFEABB38CAC2BBF08743764AF
      51E1B964DF44FE48E0933D6AFB2609328BC8EA6A843F21C16C50463A3931410B
      117315DF710A3E0DFDCA4850C68398628720B73C03AEE44B14C8DC63075D3EFC
      170B616E2175E42F19D9CCE1779698B597C92A025D0D990EE691ED21629F6F4A
      1C159237087F678E2299DC36AA91BD10D7F22813833D678359C13C9FA7BAC5D3
      C45444ABB9553157D7A8E856DD65705A6F401665B2047638AAB3AD772F771D69
      107C7BDA7B2FC8B5A416EE604692478A3762BA10948DD46CC6179ACD31D53B25
      B2865950CBB1DDB553750D672E353D5971628370A996DBC38FC326DB0ABAEAED
      116EC157E01EE285B3313BE564E12A1A5DAEBC222C7B5DEF577CBA8F1D4FB73C
      A0F524D96A1DB077F6EEE8DDB7AFBF78D1E9E6461909C42E564E9CE2FEA58C37
      43B654CE27EFA669AAE32E1A80AC9001202320E1CF4BAF1B6DEEB51C47AEAC30
      B7600E9867CCEF61665F45828B8300C56C5F3E23F8B4AF673AF6D57DBE8AB50C
      42E0EB3085970506EACAF858D33BC4C8AC4BCD11C69020E1C8AB1A8CC322284F
      0A7A2C88065E9F927E3E8BFEA83C881A585B77B5A5C31E9DD196D0C19E44703B
      E7F140D230B2A313793646A452C845DFE77645754B26D716CFCEAB109DDE37ED
      53183D3F9FE1B7FEB76FE4CCA4739929388F51BFA39C61DF25FAD8AFA62DFF91
      8B8DD7EEE0EF37DF7ABB6DE7F06FEF0FCF8E4E0EDF5DEC1DAF7DC365BEE1F31F
      C72E67CED82AF0A71081E5B0702673C2EF15B8B48C336806A34E21C1A6886A8A
      37553164E8275A740011EB93FA13EB824EFF96FCE971EFB6918A5B7CC2158EEA
      1D571BD2D51E4422395D73CFF676CF12C05C85C0AF20EDAF4DF30C3A9F8D7DB0
      B5CF9319919638641880AD62E47723ABF81263F670183E861CAB539C24A28EE4
      4E1520AE3063A649965BF85E33AFD778FA53ADE28A95C6F236D326969FC12DBE
      85C0ADD66A1417FBA18FA6597EE38E9B5A331D05CE36BA98C001B153B69D66D3
      96B37F5E42B97005B571BA6DD2C5B5B21D6B2043ED881B2B8A59047843A02044
      BBD85D76DCBB3AF5F935A8C8D6B131170DA600A9A99771222337880838BB532D
      2A9D9F8E2DD2EA23E2E483E699361413909A4C8C79323C88C0D75ACF649371DF
      6CC7205AC977A3EBBAF2E55721CE61F5EBF9DB2F162860C6384B7AEA255FFEFE
      DBB303F13FB44A230C5A322AB191B0EFE8712C566BA75484FECACFB1ED164E3F
      1B74EB175FF89BF925EA71393927112C5339E35D25A167BB105C2D5830161E4D
      0CBC26AE7773E38258F8432C000BAC210CFE4BB9FF46488905FC1E39C3D4D9DB
      FFEECCF949661876FA3FE3B01C4AD3FD7BC552AFB438CFE993E6BD736EBE24E2
      9ECE58AF7023A67CC018A1F435BBCEB7A104338DD13D93AFB4B54B35D6040426
      EE04A1632C7B652499DF5A083F160958E92C10178077D876F7DF2669441FE2E8
      6A189491D5190EB72042A69A5D563007C8274D2882A023CDA69CEB2F642EDD88
      5394BE55A8D6056AA4F6ACC93D2CB611BB2E28CE7D7C3083B8F1AD0E4C1BAB59
      4BEA9608FE28BC162486AD33D9C1174755C34772C22F9C3356CFA5A1E2F84963
      1BA52E8A5A105E8848279016759FB799532D56E21C0179E028B3313EA26C0799
      CE10D21E570218DC323E18E6525F9B17B143EC7A0B737B119ACF2452C35F4CAC
      2DC7A2827C73A57CE17386C4295B33D79EE06FF604BBEB44FA72E7EFF98F2EFD
      16D1AD738B61B3FDEDC9F9C58E9C421C5A06732A945096442BEF88B25E57A13B
      32112C9D243D3A6871D85ACC9046CAB53D53CD6474E299BE143BBB00E0E37610
      A1133BCAE2E72AE72D928AF2E1B59CF90C72E68B260C9F79D2EBA21A5435F91E
      EE479DAABF2729D3CE5A142A0AF33B9334A9447A5C7627901C37956A7443537C
      06DE9E4EC9485D2BC8DFC5B82B3F00CEEEECAEF1A296EACFE73FA357D0026D6A
      290853C47B9086294B4848F79129CB5E071BFCCF70A76B8222CA54BD2EDCC8C5
      257281B08A38B0480F952BCC056BE23A11592A304ED07E7699A477CED677A14F
      8E1B62292789EF7C8B86B42D3B3D933C18571B2C4C367B9AB86E9EA76227A1D2
      32ADE5E6902279071351B81B61DA4B9D57624B780D5322EAC45CC119802126CD
      53CEB26E22B50AC4E919A48FCC8E7DAFF22BE28CD06F6460718F7684CB13B6E6
      312085E32D1BF3875FCDB12FA9A333ED21485C1BD7C031DBDFB8356F6E9CDF0F
      546CCF33832CCFBCDEB2267E9E38D975386B21886FFA515BCEEEEE8E6994F1AA
      E5471C5ADC3A2F02145BADE2AF7749AC25CFB575845C4EEE9CAF6EF9348FB8D5
      44122B1FA50A20D05CCA80A4F7C1B6F4DAE6A12408420F493D838BD3C4A5728D
      6D8012DB52577AAC1F6FD3042513162E994CDCB2688BBB398AD13312AB0A53C8
      15C46E6D4649593EDCE6F22F21DF0E3392C9BA19F35F7891EFD6441A92F1A753
      6005E5B75A5D97F94A8DFA9D309B1A955BA3517A730329E40A5E9917A10CABC8
      BF35913A9B1BACA58382BDC20719D1AD37F330AA04A249E54A7E1702C4D9A6E3
      9839FF9823B3A11C570AAEE9B5D0A094913CF7B40C12807DB7B3EBECF1E4118E
      CC16553B3E093133FE9D1E1BA16DF365BEF3E66E8B79B6E80E34C1D772546CD1
      49570228150FEBD7B121309BAAA8B76A329ED449290691B151B3598474BA1947
      25E54BB68BC50B536F3E8559ED353431703FECCF6DCA69726B236AECE039192A
      378B1ADDDBB00643200130D3B89BA0481609B4DBACEC2AE4BE021B871314592E
      4D15F0BAA99E26BBCE7952D472C2C4D12A0B390C42766AE6A5E18CC43360C293
      E4BA91C20339C73BB45B5C3A472F6EB86FF732E17C8872A191FE65DD4FF83BC3
      939D7577D4D220CEE0B90FE95A4C8140184BAFAD5FA95F2391D04CAC95B736A7
      CCBDFDB018DFA36A88EBE5F693D83790553C3886B4A9CFAB960EEE6646708A00
      4DE66CB3BF21F28DE57FA448B73EC7497AB57C559BA3AB54F33D744AC53ADCE1
      0D954AF15782B5C3F5E2CAD9CD75D6877A2DE656706F49510F93E130CC10CB00
      AFF0A45195993A9702DBD4D9368E9BBCB6DA6AE3728A99CA4C5E30BF5AC48F6D
      E496BCB77677CA85F43C76ACDA8A0CEA4BC0B4A4B0994C55064E2FC9985E2BDE
      FAB2FA3FC844FB1EF6193430FFB5478C7E809157EBC460854830F1D876C551BB
      BD4A88018DCD8208F74142EE043964BB2429B5CAFFE27C4736743047B54DBEA4
      0CF8911963508AB5FB404CCB4BB6BAE70B2D699FCA9257F5A067692946FEC7CF
      8890FFF2082C067A1D4D99B51E6D59A2D5FF414649595BDC2ABA96B93DDBA0CA
      5FB1ABA39D2DA694810E2980D42058E7F19534C205B4E35792C038355341F0BE
      B50CB2DD87CBBB7FA4CD7A46DDC964D21B2F65CA997497FDF34754296A5FE5CA
      19B4FB6EBBD7EE77FAED767B48FF8DA522B34B07504F7CDD0EDC20084C95A6D7
      EEF2BF3DF97BE0D2BD83A11EF58703FC1C0483FE68326A0F07A3DEC0EFEAD178
      E80F3DE54D3A9EDBD75EAFD7EEB4E9A2517F1C78E39E1E74FDBEDADC98786E97
      BE7CDC1DE8C9B8EB8DC6DA1BA9EEC8F3DADE7832E9F63B436FE28FDDAE1A0D06
      F430A3BEE77707FD7E578DBBEDCE70E8753D7FD2EB05A389EEB9BA37EABA7E27
      688FDC81D79B8C279E1AF5950A826EBFDBA5AFD16EC7ED8F06BE1AF8416FD40F
      FC89F2373706C3F164DCE9A8CEB8E70D3B6AD00E26E3A0EF2A57BB5E77DC1B8D
      47E3769F6E365183AE1A8C5C3DA435D273B8DD9E3FD693F6A8DB09266DD5F7BB
      81EA8DDB5DCFED0D46C3EE70DC0E7C22A7F67C7AF48EEF75C6DAA5BB747A63DD
      F326FD9E3FD28376CF1D6E6EB8ED8E3F18F77CADF520981019FABA3B69BBF40C
      BDA037EC6BE5F555BFD71E8F7B6ECF6B4F8870DA53E360D227DA7486B436FAD3
      9D7447C1A0AB55BF4BDFA23A9E3F987844A960D299B86D3D1EE8E180B6A5D31B
      A8B1AFBBEDA0DB76C75EA7EBF5DCF6E606883D08BC6048367F87BE400FDDA0E7
      4EF478428FEFFAC3C164E8B99E4FEB75BB633DF27AC381F63C7A8C4E1074FAC3
      7630E8057ADCE9F93DCFA3C7704781F04A00EE217EF9353EA3DD201AA811DD56
      5E6C93EBD3E15F5CC369C1A84B3CE68D7ADD80F8CAFC3E0623054305CEA2E71F
      E9603C707D226367E413BD69651DE22ADA89400D26ED7E0FDB33F269433ADDF1
      28188EBBDD8EEB134768FAD90F36373CDAD6B6725DA233915B07C1484D7A7EA0
      951EBBC14477267D0DEA0C274AA9F6D0EBE96E9F18CF738763DD190D7B3E3167
      401C3C190F545F8DBA83363D0E314F7B3CA4EFA5EF70C1C0DEA0ED77548FC8E4
      F73A1D570DFA6377D86B4F069D2EED42301EFB933EAEEA2ADDEF0EFB7E8776B8
      ED77E98106BEDBEBD359EE8F02359A74469D41E08F88F3C678344D34A393D10B
      069D211DAC516F444BD1E3408DBD491010D7108D3C6FA2FB81D7A1CF075D4F0F
      FAB429433A32937EDF1BD25B437A02D5A17315E8DEA0E7FAC4D3E3E14029BFDF
      D17EDB1DB8C471FE30F0656FEAECECD01D4D26C3CE706C24C658159284FF4792
      83BE81A4C4A01BC8EF9B1BD5BFF07BDFA71B68FA6F4472A56BA50A2DC6EBFB6D
      DAFB2EA40AEDE9C8579DD168D22669409BE1129BF607433AF49EABB4EB06F464
      FDDEC4EBA87E87E40B517412105FD309D4BD71AF37F2B44F7C4C47C6DDDCA0F5
      D02FB4915E7BD4F6C76A382091A3C76330F588E48D1AD1BE8D7DD51F773CDA28
      6FE869BA67870E989E8CC61DA2B8DB1FD341F383FE84D8B237A0672351413C48
      9CE1BB03DFEFB6FDA13B205135E87634ED85EF0F349DDF3E310A893A7A82D160
      A4C7B49B24CD89CBE84D5A086D68BBDB1B3F85FE7DDD09FA6D7FC49C8DB7DC0E
      EF4067F818FDE5F7CD8DF2AF5EC7D25C7B245182314ECBB0D3773518A917B4C7
      BE4FC2CD7587BA4FDFE6BA9ED7990C355D3F7169A57DAFDFD77D35D6433A0343
      DAB3D19044199DCE1149565A531F47A5EB75E85FBF4797F74822FA01F1019D13
      3A65F4E574860322974B87613819F43C3A8C7E9B3EDB1B4C2624D0BD91EF930A
      E892ACEBD2E9EB0C48BAEA80EE312119E69354093CBF3F9E8C54E07BED404D46
      83719FF69C8846DC3D998CBABA37A1233C50741C3BEEA437A49DA50506388D23
      4547580D49E1743CE2A65EBF3F988CFB13705397A42D3D8EEFB7835EE08EC7DE
      68381A939EE80DBD31EDF70412BAAD861D7FD4EE69DFED929C9ED037B43DD523
      3A752744BEF638D0131237F430C4945DAD7BC3C9A8D3A12B8644D60EF181DF1D
      767D7A4D296FD069931E25594152AB3FEE426E4D486C7470BCDC6E9B58942417
      6D0A69B7B6C26DE8A4F73D1265DE70E46BD26E43B743D42405A2BBA442FA7D52
      87E3119D07D2E2F4E0BDE1D09F8C87A476C7BA4D62ACA7DD519774E35875BA6D
      3D0A7A7DED0F86036225EDE92EF454B7EB936A1F9386F483615791E09D0C465E
      40F28A543DA9CD80BE8EF805623320713B2199A8E9204EFC01190BA4E68882F4
      498F589DB6C91F2A12152AC09ADABD7E471143A841AF4B8E97ABBC808ECD6434
      EAF5145920C42F4147114B13234DC882A033D6EBBA81EE8222DE807456301E42
      654FFAB4E52EBD4A6A417BC168447B488AABEF926056C1884C97361D2C321768
      35B413601F6F40A60B9D72D291A4424644D9095928F40289C2EE783C696B2890
      B11E8C941F8C3D3ABF7A3869B72790EF7DDA7FAF471F27394F4C45A41C0FC65D
      D24E636227B74FCA68480C46AC3DA4FD2201E28D341D7E3A84FD099182147E97
      8C9C60082E224130687B839E56A4013AE3CD8D4E8F9E24A0ED24C2BA74BCC66A
      003B039B32D193DE8454C1986E1F0C46C4515DA238896FD27D24ADC7DDCE8884
      03D89ACE5A27202A11918610F8C4C5F40C6DEC47B73D0C063A20CA910C231268
      5793E619D36EF447A4FABCCD8D9E07F54CCA9794BFDF276626F935263B4D4D86
      2A189042A1670F341D36A52601B149406790446B401F2615D427CB30F0349D94
      11318BEFE2231335EE90A0ED0EA027E9A681AFBD71D0A12FE1BF7A6407D10F52
      5CA42C067416E8F090DE2553940E02ED4C77E07BC4043E1D900E8C40A2547B3C
      EA13DD4902D333FB2499492F109F937947BA9388D0275DEB79640EB449A90FE8
      B2A18B85B63BFD0EAC56626752AD2433DB6415914A8641EAD36391DD1590B022
      3E187B640F791D3234E9DE245448808E3D12F4C3B13B268BC3A5ED26238B9E85
      CCBB3131363D3E29DCCE80B484EFF7897664F6F6C92408BA7478488A918C6A93
      693C21A132F0024546E090A40F2CB8B126F371ACE8465E971453876C31AF4FF2
      60ECB6C92E75C7249D47A460BA6D45566E97AC21AF4B9A85AE19D267683B49D5
      D3D379B4763550641DF813123DB4F95DB2C13BF4681EC9D30EC9BD3169CA4167
      D2835E5263522EA37EB7EF43888EE90C9201DB23FEF04856D322FCDE846422CC
      5C9210DDB1A2EF22813AC28DFB5E978C165290F42A1D44D59ED056D0AE13CF13
      778D884A931E3D5B9FECB7DE9858ADAB204489E948BE91A145E6EFC01FF77B8A
      0E3C6911BFADE94A5A3309AD2E492CB24049DD91A94C8A9AEC834E0087810C27
      8DF3CCEC8EA343960CFD47FC4ECF4C0A82449E4FD6407B44D6A9DFF7E939FD71
      974E667F12280DC3A44FD2693020EFC0255549562C71468F6C44AD20CD8624EC
      C89A23414DE61B99E1937647D3FDC8F3A4B34014EA28D2CB2E6D12D98E241DE9
      5792C124E10212C024CB06C40EFD019DCA3E8E1AE9063A33BE268EF78681D753
      B48D2EF1B9EEF6486405A46F883BE8B1E9E1E994FAEE70F0FFB777364D6E1B47
      18BEBBCAFF618FC92155C07C81289F2CCB2EB962C94EA424975CF02931E22E37
      BB5CC72A97FE7B9E06482E0162C01968E3246523653B4B760FA67BDEEE7E7B48
      0C4B4D6C90F29A868051AE26B45AE93C04342D33689A84BFE0CD24E73EFB92BB
      49D08DC508CA2135ABCD5B781113CA2AC64E4936AA643C62C7142E63CD126A5E
      0E5D9782002924752565931419CD837629ECBDA6F30137242FA28D715B956A02
      20C91C1989B52BC9D6E038A7CCB0BA84AD16494449454C94115D5B40DB56BAE0
      6EB442AC5F5D34B92383537B733A3AD2078D574BF3534AD5266140B80840CA23
      B8B5A5344D19D4245718070B2552B2C450BFA94C7599C37D708E26804C52097B
      2298C8B13064CA08D9894E8688A72E91E48162026DC0F3DCBD04B1B585130954
      49B92418BA2CE926A57582C9643497394C2E25E71716BBB123978A54D6550533
      AF1AE9DAA03A101EE71257A41688420348DC5648299C889A4C0D250114D476E2
      DD6A28BA253E0948E00F2B62CA100D07008D491CECD45277E84221DBAB9A85A3
      6FE4554B6122CD53CA29A7C41A959C61B465062D5D2CE418493ABB55014BC242
      3C85F3983E540087142573132DD2A0834365DC0E4092EBA9044DC172A61405E9
      0632A2AA224D1B47B036AE6D572DF5863697BFA8A774347817EFA95C1710F15A
      FA46500137AABA840CD9C1CBB489E44C03552D24369595E8A9560492831B6896
      8A7AD3D002B136BCD538620A22475EB259AD0B49923476743899C0A6C8197645
      1911769DC1C78123F936A379CF8463B00AD2D1926AA40212FD8A86B9604E540D
      9D1AC66DE01F2A27AD3AC80A059C640CC921BC69CE20942BD60A17E7ADCA2A9A
      1F435D4ED3BC4E70BAB4BA9433E6223637963A4B4AC96D85A3A01AB83BA91266
      401651397494654EADD1864E9E1E9B25625DE064AE2A84A3D193D5C4395C0FA4
      49774ECAAF2949E277436B479F916B4D2F5052EF0A05B4E84E485224F7324D20
      2CD4784B2AAA59873223346487029719BAB65AD84B425ACE5B3A234BB66366E4
      94222DE956E10D921F92B2527025A34A4820D5AACE32E832C9999E978CC392E5
      B285236CA5CC489029F0A5D25067BA9D113A12FC4F2745478871AC251369C570
      E189DC9202425FE9EA15DC956EC9200DBF51900656C0191ADAB4C23DE4405832
      1C22CBC81FBCE0587BE84D45976AC12F2D19859F7521CAA9AF8D4C131E471392
      6679D5D95F97D423D9E9C207B594B81A2492842BB2392D015902C432D32A4DE8
      77CAA4C5709567E466DD480B282C8AEA563704309443628D9E1772E472CA20D8
      21FE606C65636913A1ADB2E920EECE05DA0DD99B65A37792A0A1EFA98DCC001C
      60A0A330B06245CB5A4028A03DB0349230CECFEBA2B06D43EAD1052367C497F4
      D5A088061F9753150A3893130FB34696C4519297324294369ED7483260183460
      BF14196009A01C69B68248C181E91BE1355458F4A03C942566800F43BBC584A4
      9527B9CCB6EFD2CBBED354D97CB7F8B83B436DBCD8B90FF76FBA1E5E58098141
      44AB4CB64B5A4706290BE978C053BD5A2144E848A3D4184D63280D126D714A2F
      52D3264A47B3825E91CAC8074D9E436ECB3C8303E6903382AA6E484CC43268A0
      1A2100B7CFE931A8532B58271C90469C0AB0CAEB5C530A4A5CB3220138F26B53
      A750989C8657AD8C346486D687BB69687846D0290A2A141C8E022B372D1C8980
      A2C12C6053743A46A94217D0787AB7B2A678D18810B5E436D99683EEC25341B1
      6301A8EF549194E95B5A0AD9B5C10DF0B055EEC0276592FE8B0586AE924AA08C
      92A30AD97EA80833C85C21916E2A3A160B9C4038B4A75FB9C1EA53DB552DCFDC
      C7EFF8CE5DA7BBC1B034EF7EF0A539C86EE0DC5EE0D4A5935E6688C447A45DBA
      E7A57DAAA98B5051735171BA87321D0997667569F766EAA2261D67C52A4CCC6B
      6A67E7D24C2E6586C99910BE73FE39DDD30DCF19DD4C6DF2E801DBFF63F7BB62
      55951487B73E7EFE997CD8516D37DBBBFB4A3EF2B8DE9F194857D9EE47264FCB
      9D324D6A05BDF4544AFC42FBA7E88A096027A836BC4B6B29EF5ACABDA1EBD42B
      91A0DF37DD8CE5DF958C805F91CA72413D6341EBE19D857CB2401A205767B40F
      D2C5C029927E0EC48AE63DE9E7680032C3FF121856AB649342EF3D43CCD31CB5
      5937A7BD9E73E24379CFECDF559229E8B314AF65FD9C3B2B21729A28A1356C45
      DEE512A19D8568E8FECED01A2C179B0CD4AA7FCDB8B27FAD9353473975945347
      B9EE35C69639779F07EDC718BCF228D3A1535E536752E723E933197D2663CE64
      CC998C3D93B16732EE4CC675322B3C2E1E2DFB753AFCD5BDC74AB8CA0C2546AF
      210716F698946FB9DCECEE771F36CDFDDF37F7F5FD6E7D5DFCA4332B7F6CB6D5
      FBA6AE9B36E9DE6AAED7FD47838757FA4F0DE53188C32BFFECBF417CF8F3F66E
      BDBD5BEF3EF0779EFFFC3864F353D5DCEEAE4E34D2AB53F9E4EA5136B97AD5FD
      CEC3175EE97C20FDAEE9BF4A917E211FB89E4EBBD77A9C74EA9FC0F490EA8B27
      1E503FF580E6E98DB64F3D47F7D403664F6FF4EAA9E798070D78D05A13623F05
      2378A81506D2A14E180E873A66818E5D64511860863AD9029DB0451FEAE48116
      1DD0A187F0D86D2B96F91307085BF19901F4A71B1186869901C2D2CCCC00EED3
      8D0803CDCC0061089A19202E4DF485F1EADB1B39282A32B4DAED7677B3DDF50F
      3D44DDB5B8416F7F447AACAEA4C3E62E4A45268ACA92C4B14FBECB73B9B68351
      ABA2FB4A54D4F477DDB34DDBF6AA5DBF7DB86BEE230D696E7E6C36DBDBE331C7
      51F73E2ADF35BB87BBB8791FF1717CE46A29481E078833BD7BDEA63F7F24EAD6
      B7C5DB457AF0DA4F30F8A0DD85449CA14788140FBB7782BB7513B7CED74575B7
      8D43E5B6888A8E83DE77EBFB58EB44E5EAD9C366D3C4A58A4EEF55FC32767A71
      24A853092D8203A53812D4A98415BA09EF2D316AAFB9C8B6BDEE0213F79A0B2C
      EDD77B89A57BCD4596EE751758BAD7B4FEE6341DF6B26FD6BB4D5C62F96AB395
      A76C23ED7ABD7E7B53C8AF5F443192E118CFFB2FB6770F01BDBD2B6EDF5D7DB3
      BD890BE267DBFAC3D59B589670D45A466DBA95915F7959DF3CC4F97AA0B90485
      47DDB88E6AA81BDAC44F6BC745DDCBFDEFFDBE782466D3301EC1EBA1DC4523F9
      75B179E83941A481CF8B5DDC9D1E01F44D77C8D21E469F3E4424265E092378B1
      AFB371363FDE3FEE968F7A71101CC7DCE2DBEED56313F133F93FF1A9E2C50739
      48717DF33E4AEB9BAD1C30DBD443ED49E02B35C4F04E0EE8D8DB36AD304CF85F
      5FDFBE2BEED77184EEF0CCCDD5CBE2364AF10779082EDE8B5FFFE1BA586F4E8A
      46DCDABD78F3F2BBAB37DB5BE1B0727067DC0A8AF23379BCFC7A91FEBE09FEDD
      DF9AF2F7F137FE12E67CF3E17A89C15F2EE8C83AC5AFD691E9ACD7DAD60BB49E
      1F7F896389897F6C3E94DBE2AE8EBFEF0F74515D70EC9A05DAAF0B79AA385E4F
      9E5BFE174118BD5FD069FFB5B85B4B2BB6B4D1BD7F28FFD1547191F76ADBF754
      313ADFF70F66F6753F769378A01C97E307AA91D5454EF4DE9E6426CF1ED89BAE
      159693D13C669D24BAAA79B7DDC8C927C741A799CBD8DFAF6F8BEAD0F71E84DC
      30697FD79D30F2FADD63837C141C532F113CAEE0514A4D489D587594D3233256
      AF1FAE0FF7DD6F0C1F65CD9CAC1ACADA29D93D5E0682CE2B381A319B121493C6
      23AEBC826A6C7DEE15D58331B3E1EA3C2FEEDE9FFB3C1BB54DF261BBFCC6E0D4
      2A666A5AF67C503D2DD8AD65288028329514F3746CBF0F4B8F0A41A0F288CF63
      CBA3340F328FD20CDAC6B6FBE2F9CFCD8FEBFBC3DEEAF45EAC19997F7FD299CE
      F0B721C8FEF4B0DD17DFE99B0C97F1DB9B5D7373DF9C6885048E77BD6762C8E3
      D99960F268CCC4D4B4862FB83CD2F351E6337D2EE03C379A893C8FE90121A8C2
      92B947FC52009E25B8B010544B42303CE17B3402007C664F0080553480553480
      551480D512008F4D0F01B08A06B08A06B08E03B08E03B05E0660BD04C03A1AC0
      3A1AC067F60400584703584703388CDE78A4C3003C363D04C03A1AC03A1AC026
      0EC0260EC0661980CD12009B68009B68009FD9130060130D60130D60130560B3
      04C063D343006CA2016CA2016CE3006CE3006C9701D82E01B08D06B08D06F099
      3D0100B6D100B6D100B65100B64B003C363D04C0361AC0361AC02E0EC02E0EC0
      6E1980DD1200BB6800BB68009FD9130060170D60170D60170560B704C063D343
      00ECA201EC66B6EE867E900F1D37CDF01395E99E7F68DFA18B3F2ACE7C7AA3CF
      3FE7DCC86F789D7E25685A514DDE334473E8A467DBEDFB88AF091C4719E2F2D9
      BADCACB7DDDEC8874FF97AF4787FF6FBAF8E9F679E8A99C98FA1BACDDC61936E
      945770D80C19ED151C924E63BC82630A61AC57749846CD309C3AB8F6725DC21B
      CA3A9F6C3A259DF9A447E6AF7C7223EB739FDCD878EBB5C976F96230AC4D7DC2
      EE18C54305E553C8A6152EBA6D7A9367C67FBEBDA719577AEEE1F7E9B4C225D7
      7AB4027CECB329C4DD1EE342FDAE62FD1E0C60DF1E4B80DFD522BFABC57E57D1
      20F71A17EA771DEB771DEBF7E00CE2DB4B08F5BB5EEC77BDD8EF7A19DACF4AC5
      65BF9B58BF9B58BF9B45683F4BFC117E378BFD6E96F9DDC6A27DDC5505F8DDC6
      FADD2EF2BB5D8CF6B14D317EB7CBFCEE62FDEE62D13EEE1E02FCEE16F9DD2DF6
      BB5B8CF633E3867EEF3AA2601278223D5B434FE46653F889DC6C063991DB53C0
      D9C471221E46024F14C248E0B9DB8248E0A9FF3C0A7E477A59A3DFA74124F0CC
      B9412470D2C71ECD00677B8D0BF5FB2C099CF27B30803D0A97BD3E2656A17E9F
      2581B37E9F2581B37E57CBD03EE65B017E9F2581537E0FCE201E4A16E8F533EA
      18E1F7591238EBF75912E8F7BB8945FB196BBCECF7591238E5F7B814EED18AF0
      FA197D8CF0FB2C09F4FB7D96044EF9DDC6A2FD8C355EF6FB2C09F4FA7D9604CE
      FADD2E46FB9971A17E9F2581537E9F2581537E77B1681F13AB50BFCF92C059BF
      CF92C059BFC79D4BF01295F8AF61BFBE969FB858F694C38BE2FEDDAE887BC0F3
      2F3777CDFD76233F027498F0C7EE971AE4471AEE77F21B4949DA9D7594F4E73B
      2549BA3F9FE9F3CF8C1CF7DE9D08A4956AAC36A95DD995A94D65E5D4A4D499FE
      2C25EDE45CA3C9CBF523D549D5A66993146999A64593FA4F77EA2F2DE7173364
      DBB46D77DA93EF64AA74F4DFD11BA2DF1E4F1D3BFFFBF8FA7FF092D3347FBDD7
      6FD6FF7AAF09EBEBFD7F9B5F7626FF8DEBB7B5FFF55EBF593F7F59B8866BFB7F
      32D3530F030B714DFF77C60B597E89252CBFBA932EADBFEE27952BEA7CB5CA55
      9BD67238B5B3CCD424B9D3CAA68DF58DAB9354CE2CD63ACDCB5AD526497D8CE3
      7FE5F27A60E1F5F9674F39BB5FE27A4A0FFCFF592FD753796081F587DE637F7D
      FCF86F84D138E3}
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
