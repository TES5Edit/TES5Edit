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
      Left = 811
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
      Left = 841
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
    object bnHelp: TSpeedButton
      AlignWithMargins = True
      Left = 872
      Top = 3
      Width = 70
      Height = 24
      Align = alRight
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
    object bnNexusMods: TSpeedButton
      AlignWithMargins = True
      Left = 948
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
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
    object bnGitHub: TSpeedButton
      AlignWithMargins = True
      Left = 1029
      Top = 3
      Width = 60
      Height = 24
      Align = alRight
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
      Left = 1095
      Top = 3
      Width = 66
      Height = 24
      Align = alRight
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
    object bnPatreon: TSpeedButton
      AlignWithMargins = True
      Left = 1167
      Top = 3
      Width = 64
      Height = 24
      Hint = 
        'Patreon is now live! Please support further ongoing xEdit develo' +
        'pment.'
      Align = alRight
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
    object bnKoFi: TSpeedButton
      AlignWithMargins = True
      Left = 1237
      Top = 3
      Width = 64
      Height = 24
      Align = alRight
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
    object bnPayPal: TSpeedButton
      AlignWithMargins = True
      Left = 1307
      Top = 3
      Width = 54
      Height = 24
      Align = alRight
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
      ParentShowHint = False
      ShowHint = True
      OnClick = bnPayPalClick
    end
    object lblPath: TEdit
      AlignWithMargins = True
      Left = 30
      Top = 5
      Width = 775
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
      789CECBDF973DB48B227FEBB23FC3F20B4FB0D536F641900EF9E376F5796A569
      EFF87A96DCFDDEB7D9B10102451223106003A08EE9F0FFBE7954E12009119465
      09EAAE9EB1448140A18EACFC6466E5F1FB284E27D6C8F1C42470C2A965DADD91
      13263EFD701753CBEEDAA3A5CB774CCC11FF4CD26436F1C6EEAC6D75CD2EFF19
      44FC678FFF9CF9A53FC73E3D8BEF689B034B7D9E0878E36094CEC45C64DF657F
      AD7EEB26E6EFA34914A6E938800FE6089AF57C633489A3B9138E26EECC891391
      C2F545FC9BFDFBE8DF460B278C12619836FCAF67B6CDAED9817F367CEA7C3DF7
      E722313E882BE3333EFED7AFD0A49D35398F3C11AFB66995DBEC433B436A1BDB
      EC409BC7D132F6458CADFEF5EBF367D062BBA293F67A27612A4D1830FCEB4367
      B1D1FED7B39BF9380AA86F563EDED00F6E6F68EDBFAF3FFBE1D4837F09B7D5A9
      E896D5EE6D9EBD9536BF7E7A0F8DBDF3BFE07D1327488DD10BC71ABDE89A89FD
      D15D1E89AF6AFC556FDAB84AB83ABC4AB85A36CEA8331FC7BE63BC77D21975BD
      DDCF1A4CAEFC24B9BDC1092D8D4D4DAB06031F5AE4B606BBB5D5DEDC96F1CE9F
      CE5239E04E7B071ADAF01FD050984481C30BD5E9D4EFE1A6C6CEC43412C697B7
      DC58779755DFD4DCFF56CB2E071B4033FF8C629849D8EADF613F7AE342FBD643
      D1ECCC2FBCD5BE5712F91D5B2BB45EC51EEE3A676A55FC50BD61A7FD577B55F2
      F677A2A96F5C95FCADBDFB6302E362BBFDFB9FAD4EAF0A0290FD60ABC6CA63C6
      F189622655FDB1715D373F7B13F36B87550BD3B32A1EFD7B2CC4053DDCADDACB
      56CFAE78F87CC9EFED566ED37EBFE2D1D68F621C8BAB7D39E8AE5DD942D584B5
      8E6267ECBBFBDC83AA4D650D7A15CFBF06BAF35D7EBA121A7BEDAAB7FFE48B34
      74E0A2E01EF47A5518A0D6DC320AA242BEDEBD7EE58372C1571E948BDD1B563D
      A756BBFC5CBED27DB3FA497BC3936A99FB56E573729DCBCFADAC71BF52D2528B
      BCF2787181FB9510AB56B8FC706175FB9DEAE1B637BDB7B4B4D4756B30B89D49
      188AA3193F8B248577DCC2D94808D9CE208A5210510B3DB79D39949F93C4D21E
      6C670DA50725B5B03C37DCCE1A4A0F2B82690FB76FCBD28385556B0FB76FCAD2
      B36B3BB263552146719219AA73EE6B55C99AC519960F29B66B0D2B9E294E2E3F
      93EFC28E6D563E65AF3CA526B4635B55CF649C563DB3B2FB3A76955493B3D8EC
      D1E2CEEBD8EDAA070B8BC80F16D6AF635789B1C5F593EF5B5B3ABBFED2919455
      5840BBFE02CA47D532DAF597919F2C2C66BBFE62F2B3D992B6EB2F293FB9BAB0
      EDFA0B2B1B282D6FBBFEF2F2E3C5456ED75F64F9EEB5A5EED7024ED68F8A5252
      2DD8548FA925EED7024DF954617907B520533E972DEDA01668C9A7D4B4F2F006
      B5404B3EBA3EA983EDFB47A9890A5B3A83ED1B277F464DE860FB9EC91E2A624A
      67B87DC3640F66133ADCBE57B287F26D424F6EDF24F993A5FD31DCBE3FB227CB
      6B38DCBE39F277AE2DE1709BC8F1BF57650E7AAEA49E573551430D29B553253C
      6C57498ACD58956A420DF5A4D450A5B670BBAAB23630AB523EA9A1B8ACB65529
      AFD453614A6D556AD85BD599F53156899A3B2837459B8CBDC5E6B3A3285C34BC
      D855B6B9ADA85F6AA58A256D13008A8D54A3F25659A0D44C25DBB94D2C581B52
      35466F9511565BAAE449758485524BDD3BCA0DEBA3AB02ABDA4244D1BED6BE1B
      D35B6DE58E2C8F06576CA8F32D4CAFD4D01D99DE6A33DFC2F2D647F78D4CAFD4
      D6DD99DE6A4BDFCAF2D64CAA9D3B1355A9956FC2D1AC996A73DB36925A1B57B5
      DD6D2B51959AF9761CCDDBFA16925A1FE0371155A9A5FBC1D1ACBDDE3DE2E89A
      B1BC571F49259D969EAE8FA005ECCC1EEFD7C7CE126AE60DD447CD125EE60DD4
      C7CB55A4CCDBA88F94AB1899B7511F2357D1316FA33E3A6EC2C5BC9D6FC1C5BC
      956FC4C5ACA1C137E262DED037E162DECC7DE062DEDAB7E362DED6B7E262DED2
      B7B2301AA81B05519C8E83BF8E62E199A329AC4A688EC6C15298EB97EC6EB778
      11FEBCED3237807F6D6862E5F2CABD154D54BC909BB0EC41F122FC79DB65F3AF
      CF9FE165FC7B43232B97CDF2C5BC918D97B34686B6FC023ED01743BBD63CC325
      D7715D11A65128466EEA87290EDD4D668E07ADF7F101D069E8093925C32112C8
      BFA15F8E3B5B1830B84962DB2374EA1939F2C4155D7AB23FD0FB47FED135D4A3
      0B67618C7E0B8C51E09BA318FE258E05D096047677083FE7CB20B54657BEE7A6
      C1C2894757B1B380A71CB83C729285132C660E7E089773003767994623C7FBE7
      32496394F4A141185F803FFCD45998C6D75118FD06941ACDA35418BF8F92F426
      10C94C88F4F76D9D80F1DD5B3746711AC05C4CDCC43260464CF88753E7287F2A
      E8481AF30DA621A755B93A15BC9C68AAB7CDF4C89DC6BE478F858B420BE102DB
      30464928AE53784BF2DB248AE70E8807C922F6A3D84F6F4CE3035E425F22187D
      6295A7686C993451F8738C43B6E02FFEBDD34445CB14A64604E25204E60ED336
      563307C2F5E699834E8F47F4FDA6D9BB0099082424D01E791E4D3587E66EF337
      7612E145A129A712BA96409F2FACEEC6391D1A487471E27B436BD8314DDB9809
      07BDAC0C4B4EB3FDFDA7D9BACB34C344DD3ACD389195447A4F936BABC9EDED38
      B936F2AAA4BD32B59DF53D7E21C4827E84779F5E7BF7CDDFB965F37746EEC41A
      6EE100769103D8C549B6B64C32D2DCCA349B6A9AFBF06119CE7C4F2CE1861DE7
      BCCDF800E384F61CCFF353FF52C0DD8998FBD0A427C2D5D6559B96F18667DBF8
      E4C4CE14667F669C46213943FD1BF4374D2C0B7EC4D195374AE3499AFCEC7BE9
      EC751BFE58C08B02CB1CC88F71FE7112A8EF2769F6699C7D8AF1933B5E388037
      F061C21FC6300D8094FC3BBD5908B82BB914710A12127C1AC75EAC7E07F2F758
      FE8EE56F6F1A649FD4B599FC7DB915FBFED0B06359B790C3F3678C3EC6B9330E
      44464BDD222D55014279246372FC451CC8787ECE5AAC8CD8F177E45E9428719D
      BA7F54ECDA3806E137EB566F7BB7F0AD1BBA05970B5B30EB8EBD5B77EC7277FA
      95DD510CA792CDD461291BA6AFBD5B7FDB797F61F4D0B541758F6DEAB1B9D263
      7BC4174B3DA9E62D2BDD387FFFCE388E3CA2AB0486FD5D30F7B6CD88CAC0CE40
      F0DD01D61AEE3089727FB67E16E37D4579B679FB46C0719736C1CA02AE038C6D
      AFBDF82C8DA3704A4B677F27A9F4DE109CF5A207583ADB2A89EEAB73364FA250
      49F3BC52F62D3CA24C7BCB0078837DC7ADF6FCD98F809B31F288ECD5EDDD5E6D
      DDF5DDA751104457C22BF50057A34833195DA064713DB47AF0D31AB46DF865F7
      0134D2EB76AFD7815F9DEE004481EB6E6788B7F43A16DED26F63BCC9F5C0EE74
      F869BC05C8AF4FCD98C321DE6459439443AE414FB7F136ABDDEFD07D9D5EB777
      CFE428B9E5ADE468DE428E19DBB7BF8D1C3B0AC8BABBF2E54FB1602E900A2F23
      996ADCBF1D1F36626BA70856A5BE6DE94E0965ED6AD0F7D729D9DFCEE9D677ED
      C91C6821F193EC95B701FBEA42975E57CD1916C1CB7C67DE02C32BE3A9DFBAFB
      D7AFD47CE027698AC2DCEFF491FF16F345E0A4C2F76CCBB2BB9DAED5EFF0D7A4
      4A8DE8673871CDEC53283FFED3CD3EA84B13DAEE26420CFE99A40E08EA20C6F3
      5F0BC715F24610E645989ABFF35F2990EBE80588382F4CF31067825FB59C8F45
      9CC045D0CC6F9F8A89FFB2DDC33DD9879DF54F578E1399834D3B157EA1C1EBDB
      46B53AA64BE877081F61A58A035483AF1CA2F56D43B43A9DF218E902BC0E7F3F
      D828ABC608A3E751DADF364A1BF978719474015E88BF1F7D94728CEDB531D2F0
      7718E560B0324ABC80A384DF4D1965A7EE4AAE4896D928E167799474015E88BF
      9B32CAEEB7D16BA76DE3CE2F8E122FE128F1775346D9FBB65162DC54698C7401
      5E87BF0D3A5D6AC228FBDF38CAFE0AEFA10B38CA7E25EF515CFF014739F8B651
      F63A2BBC872EC0EBF0B71A259E1C1AD0247E0609A1331C74BBBD6EB6D02B1244
      AF3FB4BBFDEED0DC3445763B9F21F5B9FE14D59A156BB47CD91E5A6DE37FADCE
      0C0C01C3BA13767E74BE4966B0DBC5C5DE7D28BBAFB6156D1A8F5D319E3B0808
      BBADCDBA78778721D152D9C3CD4B8571F31BC77607B1E0DBE8AE30B26CD8DF6B
      6CBB0B03F736B6DAA2DD1DC7760711E041C7B66564A8B4578E8D707E37E06FD2
      D86E1919A2FA8A505306FCA73CB6DB417EB328F344C67607686FF7DBBD8ED9EB
      54413B2695E95BB669F734B66B6CD7D8AEB15D637BF3C7A6B15D63BBEFF54D73
      600F3BFD2A6C7F39E87486C38ED9D6D8FEED4369169C97C780E3FF53C0797164
      B79EC76838D770AEE1BCE963D3705E84F38ED5E9C3FFDBBD2A3C6FF7EC6EDFEA
      0D6C0DE7F7BBC4CDC276ADAA6B555D63BBC6F6A73D368DED656CEFF60756BF63
      5661BB6DF6BBBDE160D8D7E0AEC15D83BB06770DEE4F606C1ADC35B803B8C357
      3D736059958678CBEADBDD8E6DB737BAE06B74D7E8AED15DA3BB46F7668D4DA3
      BB467740F77E7FD0B107C361B50BDDA06FDADD9EA98FD935B86B70D7E0AEC1FD
      098C4D83BB067700F7E17068F7DBE6A05A75EF0D6C787ED8196874D7E8AED15D
      A3BB46F7E68F4DA3BB4677DF83F56CDBDD41D7AE0C6C1F98567F6875B4E6AEB1
      5D63BBC6768DED4F606C1ADB35B603B6777AFD61CFECDF12D9DEEFDBD6002044
      83BB06770DEE1ADC35B8377F6C1ADC35B803B80F6D1B54F35B3CEAFA66A76799
      96B6CA6B70D7E0AEC15D83BB06F7E68E4D837B11DC7BDDAEDDEDB7BBED4A70B7
      07FD5E77D86FEB58380DEE1ADC35B86B707F0263D3E0AEC1DDF700ED3AED61BF
      5FED2D3F1858C3FE70A093C96B70D7E0AEC15D83BB06F7E68E4D837B19DCBB96
      3934ABBDE52DB3DB69F74D7B73A9390DEE3AE3EC53C3F3E2C874C6598DE71ACF
      9FF4D8349E97F07CD8ED0D3AE6F0164BBC65F78643BB3BD0DAFA3D2F72B3D05D
      6BEB5A5BD7E8AED1FD698F4DA37B11DD07E6B06B5BA65D1DDB6EDB83AE3DB02D
      ADAD6B70D7E0AEC15D83FB13189B06770DEE00EE7677689A9D616568BB055F0E
      86FDAEA93DE435B86B70D7E0AEC1FD098C4D83BB067700F7CEC0EAF786E62DB1
      EDEDA1D96F0F7ADA2CAFC15D83BB06770DEE4F606C1ADC35B803B80F7A430BF1
      BD3AE56CD76C778013B5B5EAAED15DA3BB46778DEE4F606C1ADD35BAA3D9DDEE
      C0976DABD2A7CE8679E9F77B9606770DEE1ADC35B86B707F0263D3E0AEC11DC1
      BD67757B40B0FD4AC37CA7DDEE580353A3BB46778DEE1ADD35BA6B746FEED834
      BA97D17DD0B3867D40EFEAACB343B3DD81CEE87A311ADD35BA6B74D7E8FE04C6
      A6D15DA33BA0BBD5EE835E3EACD6DD5FF6DBF6D0EC9AA64E3BABD15DA3BB4677
      8DEE4F606C1ADD35BAA343BCD51974ADB6599DCAC61A60A5D7B63DD0F0AEE15D
      C3BB86770DEF4F606C1ADE35BC23BCDBC3DEC036CD4AD3BCDD699B7DAB67EB80
      380DEE1ADC35B86B707F0263D3E0AEC11DC17D6063AE9A6165445CCF1E58EDF6
      50177BD5E0AEC15D83BB06770DEECD1D9B06F712B8B7FB9886B66B752B0DF3ED
      5EA73BECF63A5A75D7E8AED15DA3BB46F72730368DEE1ADD09DDFBB0A683EA68
      F797BD41DFEC5A439D635EA3BB46778DEE1ADD35BA37776C1ADD57D07DD831ED
      6EA7DA65DEEA0E7AF07FED54A7E15DC3BB86770DEF1ADE1B3C360DEF2578EF76
      AC212AF09535645E76BA1DD3EAF4BBFAE05DA3BB46778DEE1ADD9FC0D834BA6B
      740774EF99FD6EBB3B1C54A3BB655BB639B43A437DF2AEE15DC3BB86770DEF4F
      606C1ADE35BC23BCDB9D7EDB6A5BB7D8E66DDBEC77CCFE50DBE635BC6B78D7F0
      AEE1FD098C4DC3BB867784F7B6690E6DB35B9D69DE1C74AD41DF1E68C73A8DEE
      1ADD35BA6B747F0263D3E8AED19DD0BDDD07F43607D5CABBD5EBD8C341DFD2CA
      BB86770DEF1ADE35BC3F81B16978D7F08EF0DE01C5BDDDA94E686375866D7360
      0D75CCBB46778DEE1ADD35BA6B746FEED834BA97D1BD37189A262C6BB5F2DE31
      ED61B737E86AE55DC3BB86770DEF1ADE9FC0D834BC6B784778EF5B5DBB0D145B
      0DEFEDCEA06D0DFA3AA78D86770DEF1ADE35BC6B786FEED834BC97E17D60F7CD
      B639B42A6DF3FD4EBFDF1FE81AEFF7309466E179790C38FE3F059E1747A6165D
      E3B9C6738DE74F726C1ACF4B78DEEF75DAFDB665569EB5BFB4EC36A8F47DDBD6
      D6F87B5EE566C1BB56D7B5BAAEE15DC3FBD31E9B86F755781F76FB7DBB525D7F
      69F5AC41A7DDEEF5B5355EC3BB86770DEF1ADE9FC0D834BC6B7807781FD88361
      7B386857C2FBB0D3B62CAB3BD08EF21ADC35B86B70D7E0FE04C6A6C15D833B82
      7BBF6F0E3A3DEB164779BB6B99ED6EA7AB0FDB35BC6B78D7F0AEE1FD098C4DC3
      BB867780F761B76BF50666AFFAE4BD079A7BAF33ECE883778DEE1ADD35BA6B74
      7F0263D3E8AED11DD1BDD7EB0D7BFDFE2D07EFED6EB73F30FB1ADE35BC6B78D7
      F0AEE15DC37B73C7A6E17D05DEFBED4ED7BEC5363F1C76DBD6B0D3D36E751ADD
      35BA6B74D7E8FE04C6A6D15DA3BBEFD966C7B2EC8ED5AFCC6103E8311CD8BD9E
      3E78D7E8AED15DA3BB46778DEECD1D9B46F715741F7400DEEDEADA70837EBB3B
      E80CDA038DEEDF3C9466017A790C3A878D06740DE81AD09FDAD834A09701BDDF
      EBF4DA6DAB5D09E8C35E6FD8B64C5303FA3D2F72B3D05DABEB5A5DD7E8AED1FD
      698F4DA37B19DD07686BEF5A957EF2DD3E207BDF6E6B3F3A0DEE1ADC35B86B70
      7F0263D3E0AEC11DC17D6876DBC068BA5F69ECFF46D7A34B11C7BE27A09540FC
      5EBA34CAFCEFA47B7DE95B375AC2604641627DDDFC98D5EE0F4C6B68F6373F66
      573C9615A4DDFC587BF3637DD31CD8C34EC5BB72CFC1D5B76571FF9B1FEC5675
      D2EC77DB5D1095363FD6ABE8A46D76DAC37E7FB8F9A97EC5CBDAFD61C7B4BB55
      831B6C7ECC0649AEDBED7511D3363D36AC782C33F054ACB6B9F9B976BF0D2BD7
      AB9847AB82483A40AE3D736055915605910C3A03ABDF1B9A556F6B57AD77C7EA
      F6E15162709B1EEC6C7E5F7768DB40CB95DDAC22936EC71AB6FBFD6E05995855
      748205193BE6B06A09AA08C5B63A83AED536DB556B6E55D04A1E1F5BF15C05B1
      80AA3034CDCEB0627C7605ADE49CA8E2B92A9662DA1D606F95B469DB95FB3CF3
      21AE78B282ADF4BA5D1BB851B7EA8515F4323087F02ED31E543C56C956543DAF
      8AE72AE8C5327B56B7078FF5AB16DEAE22999EDDE9C37C5A554CBA8A606C7BD8
      1BD8A659D5D30A82B1703798B07B2B26B45D413183416F68E19EAF78CCAA5AF8
      5CA3AD78B20A86B264AE15CF55104CEECE56F15C1587E9F4FA4340950AFA6C57
      514CBB8FA4D6B52AD97CBB8A66B2E23215CF55504CC7EAF4E1FFEDAAF9AC2218
      80947ED71A98155BA25D453059CEFC0A64372B597DBF3FE8D8836105D8762A78
      4C1FD3FC0053ABE867A7526C5195762B9EABA0179817D31CDA20F2543C57412F
      B96345D5C277AA48C61CF4AC61DF1A545068A782603AC3E1D0EEB72B27A68AC3
      6469132B9EABE430039460865572606758B5F0B0066DBB3BA802DDAEF9F52B0A
      BFB1B84CC781F1FB97F0228CAEC2BFF2D5C5744157F1C3C8871FE6C84F9D05CE
      95398AE15F32867F0EB2A9FA77581577703F12DFC357D207BB6D591DBB479F7B
      0390C27A7DFADCB761F6DB03FA3CB4401C346DFA6CB5ED1EC8B0039A8BF9DC49
      679F62FE7D1A8569BB339A8FE38BD73E682DF2C3D912DE3D4FE64E109CC60EE8
      3573CF4F166FC4C41ACD83F74E3CA57BE3EC932726FFC785EFAE6267F196F417
      3235CDFD307DE7CFE143E8C437F00977931F4EA2DF47CE329D45B17112C03D49
      2AE2A32FF055B410B193C2E573F80EAE86C649380D440C5FB9B1007D693EBA89
      6DD01646F3C81E79372069CDE22EBEC6C28D836B557D8BCDE23D2C74E247216E
      50E1E1CB9122C368B270A602579DFEB88A620FC4BCCE60C87FBB33274E001F06
      83C2DF570980DB00771EB4190EFBBC50D7F3000644C4411F2D6396A68B1F5EBD
      4ADC99983BC9E1DC77E3288926E9A11BCD5F459389EF8A57F8C25700946DFA34
      0FBE7E1D2D1C988D2B0B54A31E7F9E013386C59DC3A4073CBDF029CE3EA5D9A7
      317D9A2E53985720A7344E849B1AC001AE7C2FBA72D338184DD270FCCF912342
      CF8BDC510A6B7C31873D9098FC7912C5401DA91F4EAD911785512A40D7F4929B
      6402F462C14407375178390FCCC2B7A0554E3D2775E0CDF1045A051D354CA1C1
      4B27F0E1BA80D9B046C92CBA5A04A0ECCEA2C043DD16B6C5348C6231F7AF85E7
      42EBA8FB02D95F0A3FA427AFF12DF8187C803D0A7461C10A5C07D0BDE8468430
      2A71BD4866711AC2E5250C16946977E485B0046132F6C67095B46B18D212C60D
      034B660E7001A0B07FE1D8BDE99CA8183ECCE8466479DEF4B2F0196EF5A76C35
      C56F4A7FCDB06B163D801FD04802FD71426F74E98BAB0B50E62DFA94B84E20AC
      761776FB38F6E299703CF9711245E928590437E955E887029726FB3C4BE7B051
      92050C220867A9E3FD1386355A262248C74E108EE01F5C80978CE01178830B7F
      5DD11FF0214EA7F128086147C3C80534019FAE62645CA32474166934058EE787
      AE0802682888AE26BE0860EF7AD0FC086E5C2C43176D7D4EE23B592BC84E62E8
      B1622FA1B8820693F406BE4DE01DD338BA822E47133FC57E8638DFE90D4C3B72
      59F81EFA1A02934993D14460DF44202EE1B27B9D2CC8B600ECC18325BCC2EB02
      97D499B8B09FB0D3CE846E5E025906A319DD81F39602EB7462B833752F1D9AAA
      143A8B0F4D629C0FBC70E9A4D7E3EBD1451C2EE22414E9C875603702BD05308D
      06128E0F9B71E1A406742B35D9EE7105743C99A7133F807D64D81D600EB8F781
      0F2D6391CEE2284D6149477E3089E68EEBA46E102E175DDA70D0216384BBCE33
      D4FE03B61E8A6B73842B2FE29B3E2024AEBCFC083D49AEF1034C7F3813B1A0A7
      F1115C2434E6506B62E20089BBB080B4810DC2A210BE0A2E61732DC2A51BCFF1
      025A9AF06FB625E139C6229C39E114112B4CAF53C7389440261FB6619DF171E8
      EC9D9E6FC32740CF3B3DDB814F41FD37EF979FEED67FF3D8687DAD6AA6471350
      BB1BB735D5A786EA2DC46DED0CEEAB43C33A1D429ADFD812804F0CBC2A70FCD0
      90B43D021EFC1BEC9B5C52B14C64DAF4738CDB1F38BDC3BF01738090F121140E
      2405034F5938C162E6E08770391F4DE8EE51B4249A27FBA6390276B74C52E0B6
      B3145E1392E1528951D0A0531073402E4A0377369AB800B823670CCC029E9F80
      DC08AC0D86075A76977ACFF7988886E3117D8F5F83BC6AD18789207DFC02001D
      E00CD597089EC0C666BEFCE08DE943DBEA9ADD918BDB939E0C178546C2053603
      6B53EAD5C42C756134E97446301933E07949516443E9A23436F96EB8BDF472EA
      1B5C357E9E39E98BC4005E6CC0225D9F787E6A740ECD43FB7F2155032FDABC88
      F6F75F44EB3E161196E1D645C465DAB0884F62E9FE11BD3CF56F5D251065BFCB
      32DD7D617855EC4EF5AAD0B78FB126DFBA1CCF9F1D197CB06244130304983831
      9CE4427806883086635C3937461A19C972B188E2546E350F293D5ACC81A11A57
      3EE835CB141E05FE617C72D25844A101F2E02B78FE9373F3C9090EE5726FEDCC
      DBD4F061574757C6224A121FA4A3EDEF36C611FC8842B8D59F0B7CB13107A97A
      16DC1820AA830A15858971E93B4C780706CED01486E7F9310A1C343AC7006D0B
      1B77811CE548905216025516A30523B9DCDA7978050F771F79D2D197FF79F8B5
      B47E28586E5F41A3EE5C9DCF040F09DE3A15386F40CEB86E38D634FB720C4A11
      AC07F408AFA5D1C2A00D60B8511CF29AE3F5396E40541556FA7C279AD32CB8E1
      2CF8F5723A01ED33910BC5D6223A77CD572C13EA3731427BA563D2BF688592D5
      64B4CBDDA0DE4DDAC6E8C5B83F021568B3C0855452F253AA4D2E2BC7F6F86C0D
      020A92CD64838F970947DAA22A66A6826A46F4DD2D148373D3532BC77FDC9572
      36319AD5A5A97E1153097D61FC8F5EBB63BC347E39FDD8F9D5900641E393882F
      8C93308D6F16A0DCA686D5ED3784906A8EEAF93318570FC675E479C8E91D2371
      81D7A7C62476A6842B0409FFB914090A993FBD3F7A63005644000D5E2492F005
      80DD020D3CC43AD543C7684835C8A2F0D4A6A3150B0458C00E408A377E8243DD
      87F961C08DC55C90E385D15A86574E08F7053780712BC801924262CCFDD09FFB
      FF8296AE66025027A5AB819300E004512212C2E7182636821FD0809302D0C254
      FE51A6EC671C36CE4B823E26133F206446EB9E67A457BE2B4866F10BF780C61A
      85DE8141339D00874A10AC9DD020DB1FCC23B6118BD081B99DD6EC9F71886FA4
      D727D8C164B64C3DD8BB7F9459FEE5F4C34FC890405CF50C20219C4C018405D2
      CCEBF76FCE71CAAFE2289CA20C28262017C05D20043AB18F163723010A355A09
      88AD017C1180889B186361B48DF14D2A92FD3FCA2C1D4741E02C48988589911C
      0C771ECA8B2D9A3BDAA50EB1C157B0CFA34BFC904063F8D0DCC1738A641FA4E2
      D058861E888B6ECD4E893845BEE0FAB1BB9CC3060F5D2044266F49DD4E02AA46
      2AC91BB0045F88B23ED22DB155BC8EBED5F1D35A8ED60470C0034A528A8A8871
      2DCE1C9C5A634DBAB6A9A7E6AA8409DF0E4054DBD8E36A79AFBD51DE6B1B8722
      996F93EBEF262018C0A11E6D4CC1F719D3F36792712ACDF6E4ECBD31099C2969
      C4676727AC1A2E60FB7CFC70F4DEA0E33C8798CF55ECD3CE015EEE20BDFFB604
      25D3335A48D05364F6291EEA2585F691D613605ED7A908F1944EB123787C56B3
      BF4C59D0C927C6B82A76CAE390138882EF99DDB5F6BFD356412E0A28E33A4180
      9C17171F1D51A514E4C4C208A3D4A02340631E79CB4002F8D35A5580A3CDEB8A
      F68A1068754A2619DC09028F0901584201E8900038035CBB33E15EA009C843C9
      8544CC39CB98B47F2424D14E74D18AFFD4A6A762727E393F39EBBE02DEF26B7D
      2EF5331ED9E31C7D8AAE009A618ACE7EFCF8C590620DD212501B50D33444A147
      1B651A6E9479EF844B27308E03E1E0498C31C1C368325E226BF0C40204381087
      3C6D3A6F8EE9BC7ACD5A2F8E160BE067A77C968EFC4ADDF5E2C078F105A4E940
      A46CAE06919DD492CF622240D1036608B7E0172F3EA3482E8CBDB77874E90372
      A088CC38B52705FAE405D107E890D07581D246344E226A5BC917865F6328611A
      03E650EF91A7BCF8CFA5EF5E1847B0F8DCF1178849DCDF2B3F08C8481F853042
      F402311C638E2C7C8A920C912489F3333FA96DFA7F1FC128D0530AFD7048101A
      A3ECB5DA0D85A2CC46498F06654F1E077E0038F122D038D086D3822FE740D2FE
      02A6963C7050C90BA2AB033CE560FD5B384011D9AAED1F6A26D97026F9CB4F22
      BEF95552C51952DE71144E02DF4D9303BA0A63DCD6C685F10BD2D3AF4C50BCD3
      88C0FE8E12C63B3F8496976320482F132E34B36D00B33D274D2981A5992BE990
      EC93C497902D204B4291C7457152A873BC94E44E585979D425AE0599203C7896
      04D188F8017C8B733B17285FD6E65AE7916226F093BA7560DC444BEA0ED9EC98
      D18036270EA7873F3444566DC8818BAD0F5C56A57A646F1BB9DB0FF5F4E27BD6
      8A4F3FB6718B61AFA853D827EA5281CD563D8BBD3E84CDF6C886A77B9E116043
      27671D9A94FF3C3BBEC3F81AC2026A4EF33790E2BD9B68403BC6792F136243A8
      ECDE078BF6001AED9F86C87219FFB108ECF4C34F1981616FA8337F44E23AFD48
      1CEC3F8FFE2CB4F5A864A50083BAF287A529C59DFFF82455D6151F8D59F11EC6
      CE605FB02B7F44B252C3FCFBBBBBD395D6DE1BA8BD674644B21F4A87989FFDD0
      4351D359283B245E7D8FEBC65F1DA0BA3E772E041EB10A2761DF6421F80C8DFD
      95660E1AFA446850E887202B21BA07736B4A4FD7B6BEA6DBFA4E31446F991AFD
      9EDEC74DD9C76FD09BCAE7238E19BAEAD046636F488FDC265D97FD20233C91C4
      18E68442096AD865E3B921439571C75A87E661876CB3F8A96B2C9CD49DE96DDB
      FC6D7B26BDC780DDBEFD70FA511D53E93DDC943DFCFCD9A7381A07622E3D9068
      9594CF5FBEA93142C0A30D58BAC14F0C9C5A3CA4434F961B43907B817469A0D5
      E0C82180F729B9B75C61742FB9442D16810F5BD8689DD3A5CC53219E534B21EC
      AF982CF8F091D949BA8CC98B389A4CF8A0062F8052B07D8C53F99834C52BCF43
      F6BC1A0B1C0A7A6BA5E4AEEBA44A1E490BF7A2EC01B48B61423C0740C722669F
      C9183DBE60C899679708A73E0A19B171FC8FC3FDBAE707AF1DF7621AD359E6DB
      7012FD50DA32D89528607F483F363EA1B3596B118B4B3F5A2674E73EDC22CF8C
      951BEC3C620FF699B8A183E120723CE11DD09AD05929CCEA55145FC891D59849
      8A919A89FC555EB197C61C7658816CF87DF0195E280EF180C47167BEA051F8C9
      4179806A9961CD13F66045FC883DE90C5A1837B7B7BA7011AD67FDD31A1805B2
      27B99A2C64E6E2225027AE3BB4BA97DDB567B41455C3F5F37829F6890EF74E91
      5EE67EC2516FD0C51A33596E0CE49B4490400B6B9A88583ABE660B3C1630ABF0
      09280E774BDE7174A9C77D8067FD40E0F9C6DBDF6926363963D1115ABE915136
      4FA857F46258C8C0031240DEFEE6EDD1BB6C1DE566E1FD01FF7C74779FC4D1BC
      B884974EB084BDD7CA3CDFF976DA7D19B9C29C443566D2C0EC2C8173C3D2FDF1
      3F9837645D806B57D848DEEE228EE4A96061D3EE177D372501C2D7A7C090DEBE
      01DAC5EDA2BCF6C8D9AC78A648A93BAE5303B6DB121DAFF11A3F095F05CB3950
      16253E505A4C3EDD4936DFB5D70B3D1BF2E3C9C276733C8FB71076278E02A9E2
      A45711D2F7F69845F25591B980686BC16A101BCEB785C89821EF98843920FA8F
      EF3F96F5E325EE06A4C97B0857DC3A49078F35C80FD19F6298C84A91433CCC20
      91533CDA7ADEE350B526D4744D08A303BE70A0203A13690DA8391A10076EB068
      93A08734663842A476D04429255B897A148924B13C6547438A9D02D0C5F30AD2
      7424827AA419E43291982F2298E31BE3F8E4DD3B169F6A740E252C540A1649B1
      0B87323B4216558212BD0A4D41D184551BB4C1606AAB2C6B02DE864239C92D59
      87542FA3F0A527E64EB849993994065527406DE76645EF939A117C42711CDE4C
      73BAB153B5C59CC28EC9BCBA40F852D34D620FF769B20C6ACC64B0D6698CBF11
      DCD56CA113923A33AD3504616E7D0824322F96F1224A28A4B39097C2A13C3452
      9D4037FCB3134CE387EAE02986D96736EB6C7E713DE85DBC66206A7134ED0D8B
      FA32CAE1D0385DC67035DEE0179B1664D3CC1776F5C5CF9FEDA210C482936FA0
      6E9BE48E71AB6B023D450F3710AA31107A1A495D8DDDE09C34F3A6DDD4A15DFC
      EAE2A54AEC030DAD742277B2133E4D90F4B5F349B17A0CBF201869DEC78AA32A
      CC487ACF9C0CED0D74CC41A1D6CADFFB3126E0653EFC071A7AA60FD5A6AA23DA
      A81F79A3EE1D71A41D459C7EFC502751CEFBBD5C2D62C54BE9F3B4C753B40E1C
      AA1070D84BF24D683273B1F4C1812468B23511D7644E44FA54C2717C6882DAC0
      7D5A3FCB60445C5F6EF7403DE220CB7AB9FA10BF8542150D7C10DF54DF304583
      802D488EFC6BBB8F4627191EBD06B890B2486C37CE91089E45C5AB587841D937
      93DD2D3AB21F19338C5D8E84CE55F547D90F4C5E6730C68FDB057E94A6BECB9E
      D0DAC177D60E54A6E1ED8B73384E9C578763C75EA7C78DC4702F3AC88FB0D730
      4FAD563E9AA27C3004240BE1FA13DF0531DA23A6F55861F440940F617779F558
      C373EC87185E2E1760565D8CBE0B50C7A2B0332F17CC78B1D12EBE2135DC0380
      D2EBB32368FA1E8D4F35001AF514329EA3C89494D4D2F393B3F6A380F33D517D
      0DA70603230CB1EAD5B61B490BBC12204B39E54922B554062B6100A8B8265B05
      2B841C097FFA913D254E3FF67BD90DDF615E6B447D3CD88693F35A5FA57C9B4A
      359F54F2244275314996D901B52B73D634941EEF4B42648B430BC3D130EB48EC
      189791EF0A79A88360B8A47492A0BCA7C29997CF8140C9F914057E3253DBB7BB
      0F3C0D0FF14BB97D04C81C22498C208A16D0EEF65328CCC9845A2C0AEC848F5A
      7C6DBA71FBE47A81F99B5815D5DE3D8D112F9F3F3B43D626D7A570528C9904D8
      458FAC20BC7E89913A6379568E2A3D06F45FFA9C79571AFAFE813E0118606FFC
      37FC75049CF20DDAFCF40E6DFA0E3D9BC1A45C204B3D5B08E1BDA644C07AA736
      68A77E64D3D7DE97B7C699347FEDE1863C907B748F97B0B47EB533391B2D7952
      447E6488AEFB7BCA2259B662D616A1CE60E7B9A94AED513200C69CA984941C47
      F21EE50064FC288285F1CAF820AE97C9FB08948057C6DFFDF4C7E5183EC87C85
      F049A50E7F253357BF92E9B4B7F78B735C6FF10DD6051C9AC49CAA0A3858BA80
      43D3974E670FDF94CCA2AD9359AC460DFE8F9E35305E1AEDC3365927707B9BC6
      C4F1298B95CCA0AD4EE049FB243B11E5D142FC7AFB06F4D4712C9C0B76397F19
      0B2E5401771C18738135CCA64F2CE7254CC910138F53F25B044F9C0EB4D65C15
      CFDB3E9F7C7A77747C62BCFFF8E6E49D71FAF6DD89F1E1E8FD894C53FEB4465C
      959CD849D11905AFD74E78C82DC9D81211BA11F9B4709AEC398942B915A26482
      40EA73632799FD31A66EECB817AF608B5C61B19279849E17520232BC880E90C9
      C11F66A1D719FB7F107A7927A698E11B3DACE9A897C246970BB6AD9B9CD29B73
      5493690F73AAFB45D3C4131F3E653CAFBD538CF3E3D32F48001CBAC3713679EE
      D9BDD3885CC4BE2CF69ED6ECDC92113E4FA0BAF709030362B45B803A951102D5
      6EA0DD8109C216A9F1F3C78F9F0A4EF54F6B262A79431C5D889A46EC47394CBC
      9B2851EFF8F0514E33EE9A0D1AF148B007AA72CF2C44A3A028694C7DF6EF51B5
      20648ECD3F06A5CADCA66FCFDF1753163B943515E4433FFCA770F1A972FCE813
      197435A3DA7BE33B413435CEA385EFEE712CD9CF511C78547E77CFF83B3BFE4A
      6FA64BCC079720AF8629E132BB4F6B22AAA6E1CC8D6B4F2596E6E1A48E148377
      46595B3F0B172DD692DF3D4D59A732573A32859F301E0FADF33EDAFC00C2C881
      5919E7556D02478561CED817501ED505BC77A4AD7043A4DFD39AA88A69225BA7
      D220A5E89BBBA553C5E34278211D85285F764CFD9B03C096D763E564590E917C
      F8D93BFF694D6125ADC93A4E93C82537FBCD51A11EF986F31112901D7453DA7A
      9730DB619A9165C829507D59C731459535229993E26AA9B59247FED39AC48A29
      54AE03AC9FCBB0FAC711C1804ABF93C0829A74F27889A05C27F95EC9ADA80019
      46CD27D28C50F34132656D58EB87F2E67A1BA6A014C75944D0779A1E963D0961
      8D1C62B57D7ED450FBBC3C35E3F3427DDCDB9CE3DED737C6225A2C0307732460
      CC1D9EF3CAD592657A57C24B50E65888082B18901CB3A01C1C593C998379CD5E
      620E0855E9B8A842C2531E59D3E1B23C5BD54E1B4DDFBCF919396A86F2947CAC
      5D379AB597293A8A7D34E43916C6785D823C80B9900EA41B440DF7E0529EC3DB
      D63ECF973816C6380A38331319BC717379DAF7E1E9FB3E98DAF7E1892CDD87CC
      80A299F1A333E3E7CF8E8CBD7C61F6F2125079500E85FD7B2AF014CB59937CE5
      87992503CBC2EC147ACAD918CAE905F0501293CD62BAA969ECCCD9ABFDD0782D
      0B1BAA80D4BD371106CFF3196698821A29F34BEDF17DE3E83A37A280E61DA29A
      97353E59528007B59DC8E7297BEE862A5838052A77558D996C8D85EBE081B20C
      5486A76572CF2DC5B1DA2B04DF811F81DD1DC24F2CC265018F160BFA11DE9D3D
      6D2E1873AF1BC09DC0DEDDE26863173567BB3897D6B7ED865B14F495D7E40ABA
      6D9C53F13890218E312359986A39B141AC0903D4CF3F1E2BFDAEE0BC1B88C9AA
      EF6E6103939F438B0296C8350836F4456ED02FDC08ABBFBF9A2785F80AA88E33
      646ECE3A81645BF911429DDE444BECCD71E0BB170F1228B666B17C28F3DC094C
      F65663ECBD0C515205D219277D20A3BB4CAB208F826A282332C75166A9AF0D85
      3FFB5E3A53448CBD4060247EE0A8B32A4CAC84F9357749D771867659A3A5CE16
      6021C328DD972528D7DFC8E924F05BF4778F6255DE5E256694D92C9D29F0430D
      660D05333EDCD508D614043B52455245A9B442967674058DF0D0BA907CE411F0
      E5E8DDB9F117E3EC71A0A530C4958C47F73BC8E3F3CFEF6094A70F324A3A19CE
      EBE56E8711A215A08147A482D3F6434CCDF36739C2902F022504F693EC301D21
      22913B88FCDA5544943A3787DF09DAF8A3847C141F73E33C98B8529CB52273D9
      65DED48429EF05D90ECD3F32A958E07A60BEE6506ABF0759AAB444E642172A73
      DA5A13F5D27DC886B528D15051E2FF8FA2B916249A2348FC2BC24D1C3BEEC5D8
      89771525B6B68FAB9D256BE75CE8814ABDF318EC5442B47960FC8558CFCB7BC9
      EFA10F709B7E42F0E52D26259CEBD2F1CD613DCF9FB1353BCCB32227787A4BC1
      846844182FD1A913D6275B3C4AF77BA3F80965EFA40304996E369DC5D172CA39
      BDF6E8893D2E6D87B5205442CB9B2415F3EDBDA3675ABE1B85AA8AC48A7570BF
      14DA7F25EBE0014BB9F41DBAAE7ACDDEC261214568924BE1353275DDDA121E69
      5CFA58B9CFE1122598F27852B631A5F86CFD031498DB482646E3B7D254A84A1E
      C5BEF0893A359F50398F442035A7CAAFF41DB9EDB53C27BED89E692B66311126
      3BC0C7B0E450568587AD4B6FA01DA3A5BE557753EBE59BB947BB642B9D8B2C83
      B7019379816B8D29E3943CCBC570644DA5C3627E532A748813ADE601E4E519A7
      1C57122C539C6C9E1D1A71B2D00F772E744EA5C66307D3BB7385B9B531DA01F5
      14575639C7A232D132D6A8D2145491B9C9933AF883C843CBAA5866A6FFD3A21A
      894B2BDF1A730A73564D430FE37B99DF27F24E72C0266D1883C2AE1740193EC6
      3A642C9848681F73081679E23DB23CB6BE639AC2D2C9F792EBAAFA131FB362CB
      765EF1F3FB75F2246EBD83FA44850AF29A696A52C65465325225DBF8A24CB19A
      9F9A2924C36D45451F02CC8C9BEF30F4035FEA0A938D679332147C0377D44277
      63D8E3F36747E9AD89AA8AF16DC41FD5BACAA37259C02D9A4E0319264B07817E
      E0A7375CA945DE9F465120D9A47C686BE7E44920703110BCF8741184B0B11FCA
      FA6C7C56CE9445196C5BC47D98C8980766DF1F412BAD359EB4BF83E4FDF3CC0F
      D80929A7EC39A5E35B88F06025354A3156CBC574B192B9F174CA88AD03A92FA4
      6C3EA5FB5AA511BD2AF67F5F3522DF2F27B30EB6C9AE68A6D974A6F9234CCCCB
      379FDEB21CA2F96473F8642648221754153C40802BAF58512F96F1F2B05745CC
      7E872084896245A6EC7C85BE98386E8A215C894AE2FB1F062CE6FFA776BD1231
      55098E43E3C8B808D1D930F0E7B03CAA8889AC934BBC4126F903C92B667775CA
      BA12917504766459F9C45EB0A455EA20708E944CF4F7201CE6A601CD8E9E023B
      DAFBD1998F97F154C47BC67B112E35436A0E433A2AAC0E2DCE5E45789A3CB4A9
      F0662C982B652D5DD90A8A35684624731F1DD0B4A43E1CDCEC4B0107F3135176
      AF10D647243F34244EBC21C9063B3AD9E06A98F2BB0841E65F04560D21969A3D
      FFBB3317EF30CD6FCB9F7029F0307D62690DB1CAD5D3EAB1CE5BDF38D8791FC5
      F208C84FC55C8A9B24D185A1C0EC3F4EEC83E8D8FA1BC9949E0014F16478B3AC
      C54E7AACE74F26421A57F30AED09C0D10D48CC699E079F7258174FEC38AE46CB
      8E4D971D4FCEDEA9735CBD7F9BB37FF343F6C992945275D48E7B0BD70C75DB4D
      45955B85CA47F8DDA14802AC4D0352A29F1902FD7976D8E16C2FFDCB953DC5CA
      CBF76B9FD43E7FA69E41657C1E794B3442AA529798AF4F1D3D3BC61E9D76EC61
      9AB6343F1EA16C53F0723FA6E0034C663C77160BF51805259C5C5F5F1B94F7ED
      D038B97648330EFC62A1605588F99C799583F9FF335B4166BB54A591970BFC68
      77DBC61E2EC15ED6F19669E237A76FD876D931873DD9ED1ADA77A199D31353B6
      74727A7ABAAF26C2916756D8E3D4DFC105E0BC4819797E4E60E06ECA4592A398
      2884FA9AF503DD32E8DBB1982068E060D5970792BCE20430C29FFA69A2F4115E
      0642940F1FCF29735AE073808A4329073DCC033AC762C585573BE1CD1CDE519F
      740A255ED14F0281886B2ED1B1DDB806E90944358E6621ED088D36F9FE9185A2
      956D059D0740E8C561B410F0900362647996589B826F42E3E318F329BE7D73A0
      6A9853E249279F253F2CCCD281F11FC6FFA425CE08FACA89C943254F56999B73
      366C96DAF355E0E655FE7BE9555448D4FAC3E3D4737D3B0DA378EB6D0286F3F5
      7718FBF7F7CBA755C92A89ABBD41DC853604F223CCC586FD5627071919296BE2
      0AAF7D9CDC5E2F3F2562E94534750FE37F5E9A3A9C94C2362ACD24331E3995B8
      9BB3CC8B35A653F26DCCC69DF0C37866898C5D4AB7326721316FB50FB6F61F37
      8ADCAC458CD0626BC3C5D653A035249C7E4F4BAF4D935E0B6B8315CE1510493F
      3C4CF8081AA533576C1493450073789CB862ACF2493512A1170F15E696556724
      D1E6D1321EBE9C44FDDEC394174DD66BA96F8F71A042582C77114F47CE8FB306
      5B9252F8A247AEF159907DC215EC774CB39A957C55494A48C82F0AF8AC531166
      9D89CBAD5D01B1F3E6CCBF063C9AF382F1F3ECE91CAB1E24199A5192C7FA42DB
      3A2FC3FEE607929C6457EA398B08A0549A73C29B08E4EBBC2281238787FE633E
      9D4D065174811AC519C9CEA541E01BE74B77C6EE1FE812E172EDEC527A74F291
      93E9D56B0FE835348D3E615893DB81DE3AF36809BFE045B886DBE98503CE125E
      A9988E41635C74D6E5648EE60219F02A7B30427F72238F4BC21BAEFAF625A4D3
      D73DE3D209964A54C80B39966AB669B86F2ADC67DBDCC3F43FC70EB9E268C46F
      0AE23F7F565E203FE48ADAD2D78133ED91D38243E9BF9D09B9CDD225E2A2EC9C
      CF49C659C1A7EAA9A160EBF21877BD0C2C61FBC3F1E763E427757C19A40E828C
      0C0B22004BA27E71C4697DA60623649F08EA195B14A06BDC67E81570697610C3
      38925800570E2873281A3C90EB8446D73433442B5AEE22626F25004B1D82BAFC
      59DB4804565FD9293E423171036B24B09B1E75345BAA9575E21986EEB029EA80
      F9AAEC1928BF931AD9530A790D688EEAE37D626C252227205B64D95B9A7BADC2
      9047BFA31E37FAFAFC19211D4DB0348916AD591CADCC7408D32B134FA2A49A72
      32D809800788A8CB14AD60632C0E00F288422319FAAC4C980A7711A8D5CA4A4A
      2F0D22BCC3226E174E4ADB46594A0B6688435870BE059793027E38A10B655E27
      66875DDB7BE3A48E9A3D62B1628FB7A5E3A64B27E08448DC1068F754E298B3A8
      C91167120350DB4E54CA6DCA809B2AAB15C81FE2F1ED566FA05B34350F5460FE
      6F644B0960C840E89E9F20A525C42D5CC96D1E6B1A6A14FCE1997A07BCE441B4
      8CBF61E2E617D2D45DDC13B92700EF64E44B745169048F64A8CB88094FFC1F74
      8A68068A5324015921508C58F7485AE9F10FA3DF91BF8CBE3ED0941033935A13
      8541E4F3A2F58286EB05CF9FBD8776FC972871D1E95946C28875EA7405A4B04A
      D1422B11CD5122501858C41115A78A0A02B19448A99A6BA588E82DE96046A6A1
      9187BA22C61B386A0D53C4F89CFD1F8925C94FE3D8B19B4ECD95B05108683FFE
      F4059D31452129B93C8BA0D299B99D03D5022C2E8F47C7D40D3C422E9CE06A36
      D254367254D00B912AA4C6084A66DB2E10598DF37DCD4F1AC64F780DA5D74251
      FF27CD30D3619C3CBE4E795C17D419A3D49274D4C88E36551B9203158B509202
      5D59374E3386A63386B773CCD4018B8D6F5FA22985CA5F479E58E01FFAE8B161
      7BFE3D336EE923A432D365A741EC2D40E60FE94E86335883AD3F7F164E8B4732
      471FCEDE1A2D3C7D19DFA402E50CB427C68E9B628A196C9442BF484A90294492
      AC7AA20ADDCAE9A885DE6C5C7132BD121CA1CA8D25CA1B02FA4AAFE2638C7DE4
      3A149C657CC2FC31D132C1F2A6890AB865BFA91928C254F49442CF60FCEA7889
      CA2F521150B63216268D5D297C0FD544D488A42F5A8D39DA9E2C86A72D1BB5F4
      5094869FF277920907188820EFD8D169AC90EB1FDD1D29AB42F50BD932A00A3E
      D1AD32E5816B80B8192137973944647D42377012BC0D7AAAD67B07A317CCAC34
      40A361114455957F4259BEE8582E505637D9CB844DB254AFEA7ABB33184CC30B
      B4C5623953CC8CE187ECE84D6E742A0B244D8332BE6D9CFE8F673A2DA39ADE86
      A5653C23CA53B4A871A82938043B1CA38C312F551E41B1C6300CAAB83B75F040
      088F92E4EED3F179A5F8BCAE8ECF5B8B72634124A3A397125290E0A49F03B9BE
      938E13A2D0739017D9C523050A293F40AF4C1187D05098BB51922F34DC5BB32B
      7156AE5839A804CE4DEEE6F3D8345C7314CF9FFDF4FEE80D1A9F6082529F7769
      7AB310728AE9F0388E9D9B7CF766934EE7C1E21A8689FBF9ECE226F6E76C7E74
      D0DF89931FF2B11BAF963C7E53C766B9F4A58410C3C1B39ED40FC91F3CE720E4
      5A8FC1FE913C852C891D4F64AA656C294AA31BA8379BA3DA0B974D269E781231
      3FC691D8A1ECF8F7291BFCFC9994CEAFB856A2A4193F61090D67F38951C1F367
      E7B11326B045E8F0FC5652A8DA2E925F498EA3645672E3E6D2D3534ED0910871
      88A118C6C771E083241C1E642E776D16A8D59F942A190099035F4AFD80378A00
      703ACF13577FEDE698B98DD29024E8702747C26ACABA371BF7B5C04742CCDD7C
      C0219654C4081843B0A4ECA1E18DA280C2341A2D357532C9087B2994E7F17BEE
      961A67C3DF77BF6CDD2DFBCA8F28FF8E82A5C8D321B859DF565AA67E7499BA2C
      F4D430D9947C860AF91DD1AC9169BA96DDB58D1629C12F8D770E80AEF176BF70
      BE031B27BA1471CCC96197C9A3F95CB88B97D2FEF4C3BFABDEFFC786EDB3522B
      E57EA2A3489D798C61DF3AD4EFE17183152D392FF5630C77994E060F34509468
      F36DC0C79D87588853FA938778E8159013E625396B1A2A7100F9A2CB4D210896
      6A5BBE56A56CCAC555DAA035F6351DB4329801A47E393F1D1C4A859B4B7CCA08
      D4720F299E60D5129CBF5AA6824E72B183DD4EB175F69B03A865B13B9BB32B9A
      A75824D2836E47B7FF7541986683CCB2E8C9504CC39A1D3F841416CC41A70B3C
      E996520F021E7D27FF7E2419B806F2D782FD7BA1701202B4E9B2A1A6CB7792A4
      B5D5B23112D6F36705CDA38502F1D90907AD4781C72A48319D58892931F7426D
      661A2253D346CC9211B3A78D98AB4A1A8C78ECBB20758308DE6B08B5D4EC3ABA
      5EA3ACF092E48327D6F77F0977C6B36E3EAD9E7B4EE827B2EBF6D3EABA08A7C1
      53EDFBC40F9FECBC4FD057F469767D2A40FF0A9F66D763212EB8E7EDA7D5F3D9
      329C3AB1AFE6FD893148102502FF89D2CC3F9D85F36431358CE22B317DAA53BF
      88726C7A62148FD69CE574C974F3F4663E5E26494635D6D3EA3B683A4F562C48
      AE84F754FB9E2EE38BACEF1D6D3C698AF1844C276727DA48727723495F1B496A
      298E7AB73762B7B3D7489D032BA3537233E9F73497B83B9718682EB1CE25EA30
      087DD8F568875D6FC8BD8BAA36C9C3630C25C9763D6586E17A51746AA9F97C53
      F8FCF3676FD7B20752DDAF59C18788627428A62A5FD216669F834BCA79883343
      A97C3B59F40DF23FC319C35DFB988F87AABEDEA828524513F58EBA8D960C654D
      8CBD2FE4A754A2A91FF63625EA4107038A55AF9F933B73B5C8EA0CA1D3055652
      2B4497A1CF05BB331707C2FD546E550B11B23FA2C3F5684127C3CA6AE46DF128
      0E0CCF9FFDE22E94DBC8AF0FE2A3900897B391F19C7029284CBFA8CAFFCA14F6
      7E56B5A92258B853620AF9C64FAF87560F7E5A83B60DBFEC7E6700BFDABD5E07
      7E75BA03137E753B43BCA5D7B1F0967EDBC65B0676A7C34FE32DC05DFAD48C39
      1CE24D963534F12ECB86FBF077BBDFA1FB3ABD6EEF7B729B621E9A5B30DCBC8D
      DB64E0607F0BB7B12B48F15BA9B04883AB7BB232533AAB097F43FFB1BACF5C60
      19C128FC5B0FFED380D314C0C14C0379B16D0AE631E6304DC81D1E274F550D9F
      C47BF4488411FB8508FB16172C799C91E3CE789091FB49F8223D90EEFA80DFB8
      2FB828BD83D9DF76C2E602F5E49E8A54639E2B81A023236C705748AFDE821328
      60BA27621FF31D9080A28419ED43D75CB582C449B5509A8D37858D73700F2906
      58D788FD8C69226BA81C01852DED9D30A8EF192DF8B84762B5B22075F651CCCF
      F5C70985AF14621C7226203D8831E8938212318DF6238631043FFCBBEAF60345
      2F1CCA9AF09C063E49FD62A57A99F78F386F72E5A7EE6CC575BCE07B9D002B22
      69FDA0589788624CD254CC17B46A5351CEF1913D4D1CB58EB1F091BCB7FF1D5D
      E2FFE3D00FFD07AA1BC311AF9926EC2B8760E342DC10B1E7E17AAA224CB2760F
      45C0619C2D7BF46BA46A2852AD053B68A86A0A54A962832C2496526BAB04406B
      098BC87AB9BAA4AAA613465D961827B25DE2AD5CDE2E5E86981651A2509667C6
      FF97B3B5AF6C2B299422DD49329EC0A0C68E7BB1B9FB68895A72B588ACEB94DD
      4DA237071AB5E88CF7F46347460E7FECF7D40D385B142F2419534A099AC5B52B
      001AA4867EB8BF4B874BF3CDE1491CD9BA1E9948C9A1DC5838A9CC418F3344E6
      B62CA5259514A420219979E9716C6C75437FEF2D0628B743EE589BEDFE879E9B
      761E46AFE47C568786389C1E3ED298399CE4FF4A61F681678013D8D33690618D
      AAACA36320F709040BC4D91EF144E2C705D5B97E119FCD1CF16AC6890AFCA428
      47A6BC494921E7AD88C1FF4E60B8B3C87729886F07BBC7774B65F12095176502
      F2586CBF970B8664A72DF97417CA95E661DB9C5F6D0BE254028A96201B26416E
      CA17A285C8E608911BD6A798405294F23E6EE09488D19B639E29370A6FE4451C
      4D63672EB37CB764A47EA6433E0EC23DACE68C66F252328BC732E53C7FB6CD98
      F31DA86C9F8096A3F765C16A16300E7242A33375CCD3BCE25455C8DC9B1011C2
      7D485678FACEA9A14572681C236C6430A19A486771B49CCE6EC70E594643255F
      4D984C85CC32BF3A41FEDA1CD10186DD1BF9F7325961943E083D32CE963D226A
      57E6CEC03C2DB28F163203B4680679C29E3B2459DDE0A1916ECA3A2505866910
      8D49ED2DA8552D5CC645EC47B19FF2171536C1FD8270F13829955EBA8BDB33C3
      7C1756F468637D494BF9D0232E99D117AA1CD52E0972EEFD94329B81AD773ECC
      145565D079A80A420F7B5EBD9641A79208568E36EE3D3DD4432D6E9E4407192A
      DAD3AE40FACE8ABEFB0170CA83C7AA1EA5F8C2434DC682AA29C63BD4392CE112
      228F2A2A58B6E7612512CA2B2F33D481688C151A6F8A36BE47B10EDC6AC0F91E
      C9C7B61831797E0ED851CE13891BFBE34CAADB5EB1B22E84DD3BDB7E703368B2
      8B19F0DE87FB2676A651388EE2F07E4D803BD413A78497A97F29829B83B2B87A
      AB64C8D56BCBB676F2A051E21EC9FF8F931C6FF1C335FCF71F0F64AA4BA2B960
      49477A12F3765B9022D42A96B49D6135B6783FABA5437BF4BB58A06B088B3845
      0F231CB21EF138A37C50B127BC5975D4DBAE8E927C74F0983C0823641EE6D421
      B73310700558D18EEA38770CCF9FFA69C23E9D681F0B04978A32936C6ED636F3
      03F11273D836EF4347D036F486DAD0DF4553438430293AEB5EB6039A603A2FC5
      82CA053242E1C41545E92872072B93A18F5AB1082648BDF2A89B2C5E9999AA64
      FBD491246B3AE91F339284A3C01411FCA0D28DD40D10E1C7A779DAEDAD4F30F9
      72B5AC1F38B5F65A6EEDDDDEBE412A2FBFC1CADF707C13FB41E0BB3BBE827212
      AF35DDEB9AA665B4BE9C9FBE1CEC6B66D91466F9333A97FD591476F28AE06AA3
      07395357349A171E959A17808266ED7F12D6FEFCD92FA6F98369FE6ABC76DC8B
      691C2D01E1DF21A9C43F18BF489F2BC9EF0FCFCE3F6F6DF0ED87BF9FFD2A3962
      5D06ABF96133F8614D4BF0FD73C4877667241F5D416E73070615B754453AB952
      4194E6D952340BFCE3B3C0DCA89CF99702AFDBC4CA8C1639092972DDD7025EB3
      199A3CF542EF8B3F0B77630F248A17F489BD19AADE17D708CB6B7781A057A31E
      B366847F1E4688B26067B32C58387813C9FC57E314CF6758A9305AC79F8FDBF6
      0F47C3D341FBF5E9696DC57997F7DD850FDF6B07CEC857741147B2DEB9E6F5CD
      E5F58FE541B5F8E1BFE0BF07F18FCA23B381EE48862D9CA26E63FBC0D33557FF
      337175CBDECCE48E171F250B3D17490A8C6E51C16989DDFF48C7F1C69B9CD04A
      8C77BB5BD51609D9FE3E4CB378A0677D030B1D2B2EDAEE5573D1F188BE7F0C3E
      0A5330FB66BE82A46120BF888193865EA091AE4148C7677CC1FA1211EA8D05E0
      602CAE623F4D45489E9481484570C3912DB0691D4C4C8187785971C62B4C0E44
      F5C1E73ED61D2484188B9973E947CB72316481F10CECE4E4AC1741ACED407556
      30B51C506BE727671D8C855655943FFC541CE26A3621720CE2048746BAF56D3E
      768D823DE02DDD5767672732DEBA9387FBC8F73CD681C02258C2C42687E9F583
      045A3C7F96CF87CA8BE545822B17ABB0563F04A28039572191999051E8ECBE94
      26B295C2B55C7F903D7D03311761AAD6F071E28CB0ABD4D37B9AEA9D827A0B94
      77A0EA4A2B67D44771C005A5E61EE6A086018186FD48430C1E6888594680ED72
      7BB1586D8A4ED85C7F1639AE74043D397B6F4C028712AFCA6418FE444AF4739F
      944FA3E025B993CB7889B1DE3D23F8775D37EBB04979C2877FA83CE1F7B0ED7E
      DFBA8028108CBED6E1302BFE67CDA4475BD2E3A3F8E37E5978C022EE3097B710
      4DEECBD7338C97084DF7571A80DE46547DB7FEB40F77A962F3710292A4EF04C6
      9B77C7C813617E3D7450533CEE6511779B495D9DEF465DA3DF6BD017EFD5FFFB
      D3E7EF4B62E449F0D3E752FD8A8EF1D3E7E6105E7727C23BA6F0A928348E83E5
      58CA737E58F3E1E7CFBE13A1DEFBA4F4769A1425B860BA149A92E60CA4BFD340
      C2287C5935186D06698019E4EDC4F096E46A89022DFE8E26455D9512F8F0CECA
      0E0630EE51A84764D829ABBF512838593ED5CBF96D49A99BE64E92E671933EEB
      C74E00FBDEBB297AD3B1209E3F96DDAF5EE3C7497A689CD718D58C4CF6417495
      6CA6403CD31D0B63B10C02EE3F45CCFA215C567AC3189ABBB83D70425B591FDF
      CAFA415C19EF9952B2D40F8607824CA4B3113589CF5022F4D50522CEA1984D2B
      CB0922EFC390EAB2090C7302D3E131E59F7562CCEDABBE935CCCE1CA2ECC7392
      0363CF8D16376816383C3CA40DBEC7665B7FEE07401BD1626BDF454CF249B29F
      9B860B06E1CC4A5CDB78C0F56BD060CC094A1C345E884B1F089999A8645C37D1
      928BDB8815BEC843DBB13C0CDA4ADC2858CE439E753A86FA487CBD35F5338B09
      D9B0E15D4E02AB24935C6272669F964DDA4A080EF60F3229053FBD63434B6B52
      B6D0C15D740E22DF3489B676375E59F47D6E2A8AE76FDF189F6231F1AF77B2D3
      5CFA9C585AD1898C090518805984E9948B1052B51B19A54E413E72516ABFECBD
      7C0119239575492E164D3FFB86D3D7DBD4034F207979F773BE0DCCE842BC9409
      93B6BC1999CCBDF84E617C9313BE4839F19F702F76C8C8705AE2016AE118B295
      BC20DBCCBEA58C4EFE3C4BC3B5F525D4009DBFACEE2C55B78956EA97C35F55D6
      4E948C7EF9AF5FEB177FF86FD8C164A35475AA9C4B8EFC22DB21E64CF0305F45
      22D204DB5E1952EDD7BC8996F8826318FA054A5FC7691CFCE524A43438382B3C
      D228845949332E9C0B5854DEA99465D80D2299278EF934CFC4C77FD4EE11F991
      64EC7CEF78950583B82760A99C5464C175C4F4329E47275B37A504A079AA58EC
      30A6E7446B05B0A05719F3A1E22C892CFC85E5BE7632EACA4E6FC7835B4685CC
      321678E29714D00ED87D2CE602C3ADF35DA045CAA68A94CF9F7D24970C20AF17
      67D9222202258A5718B3282039E3F8FCF33B22078F37A18B9BF085163C9B2378
      1E1127883827C61DD73397FCA81EDCA1AAF342A034718264072EC34795A85473
      9758DA39E037ABC252331178D0852B96C14A0C9E61D071318979EE8AF65E26DD
      81DFC6DF01E817EC01D0826181007013887D9974391B3FC6286F29CFA099D1E3
      33A3D32522320A36EADCFF703A8B804AA4D7886635CD61357265F25051752A0D
      941EDF70A29E962C3F40428A9B2E01646863E2864E12AA22E493AB500D11D6F3
      3D94B0678E5459E4FB3349A9BE4A3A4181099316A8DE50C9CFC278A0513F490F
      8AAFA1CB18013685277790EE4F780224E3229998C54C6EFDCBDBDC8906E5F05B
      47A6F95653F9D671C94412C5A8D800381136259A79358D79E54B83967363027C
      6B19CB325C99F003AB83A9946BB8F1A4AAFA728476257F2E4B7E604BD3887C2A
      91231A819FA6C86DF04AD1C0B400457C07230F74199A23DD308DD22C63F00CA8
      2051D25199F00E723B6178C3AA228F98F2505F092CBC93C8842E5C259CA919B9
      13E87A62CA36411AA5CAFF784016243626A12D2174286B75F6EEFA89F1B26778
      31AE6A408F738382618A1DE76CD7B472AE88C909B1858720577E8815CFF7B358
      1F323A3832AA41D9C56632CDF258B84E962D9E4AB429439A9CEA04212B5A8669
      E6C74A19FC28F774A28E77F60F8DD737D8264DCB9573238BE6646D10D0851111
      8A8831816FEABBFE022D033EE5F29E80D09B1A1ECC3D8BAD6C22959D55E5FC16
      354832DEAED85F0A1C0D8AF3D2E47989D604F2F89D712AA0E5E22EAB48490B51
      06C099E029958B9117B693A6D608F8928F9AA73C34E3C5D9E1A58948E18DB292
      2819B7B08A899CC7846505E9DE9C4401FA0263F24474679619D9F1A1D5399865
      6916F39D44A6250268B49DCE1729ACA373E94F7963A4DBA7FBF93369F5E624ED
      186D79C3F6F0BD5332CE9225085F90757FEFB0A03FC974A3742080CF2D22D899
      D9C6C69348DCD7F3880B3E862CC1C82AEC3845D81080C98B449E78CA21C1BC60
      054F3FCC2D66F9F4D19EA029C3EBF82A1A2D3977C37E2BBC903ACE2B1162B913
      5AEDF2C06A106D9DAD5F9A1E628673E7020F6F5366B2C2496EE4F12ACC0381DF
      8ABFF101F330A1CE54D02C2929228D14A1AC5012EB9713A4559825678A6C865B
      A159C8E9045A20AAA7DD8FDC7685B8746E3AB5AA0DCB4DF7A1B08CC6D9CAD19D
      96DC9A22B9FDAC1C27C679541A1D9250C007082E355808C93607D2685EB9E659
      7E23C966F2ABC467D491AAF4A108B383F964BD25E41D280CCE23AE0C4211114A
      04DBE9782FEF4456AB263F503D309288CE1410813D1F4B2602B312D70B55BFD4
      0F3D1F443CD4C24B1C4B1EBAFA31971309D3FA9DFAEFED479CDC9F89C482C259
      23BE9A7C678067FB186DE4931EAE72AA647DDC451EB8013962CEC7EAEC18AF0E
      A00833E5E913C2E9A503CB370E7471F1A632E4931097E7D51B3FA103455CC7CF
      82503CA35DCD969BC296D9E3A5548C4896D1FA8936BADAF1C805F92480188F27
      17176B4AD172E76B7B50544D41455F86EE763D5C29A9B1505B1EE5FB9CD7C910
      C6AB929ABCE6A8C3F29D660C0D650CC7AA0285E6038DE303B9F7557A15191CAB
      16294DA960750BA5F17BB7FAC9E8116B701992DC61C6CE5C704B7EBCA2AC9F2B
      09498A4261A15CD6DE71B97B8775CE3E0EF7882515CD7845EE77809D427183DE
      422E2AEFF3B8CD0D3D03B6E5A2B22D854DF664E17EADC8A9F09A44AAF632CA5A
      F9600437ABDE2ECCF1A2055A33D3C2E129B78496B328DE69091201AFF7700D48
      D30FA2E882B86C5AE0F5CE98470A176BCC6400C25F6AB4A5E927C9EC6E2D6912
      FA0B2EB032E1ED1F1A5538C3251FD4945CAEA18EB3BECEC5453C2898DA28FB09
      3A7239E42F8D16A3D59594657557E1CD4F56D631A3115A50223C3622292FDE1A
      5691B33AB6A515040B248520FC651E6564238DD00369BC4C456E8C53532F5519
      7719C7681AA4A121FDB0794D2916EC5F9597D5900DCBCC00632A4B96F23AA0E3
      6781740F8D23B27DA155C58FE76AFF2997A78C64CBF44E33371699D146293345
      32AE63A3DF7A471467EFC21DB3CD77494B008F2601AC70300DFF4D817F560356
      9687381E5BAF5569D412E7406921E7196277B5FFF9B30F6C892E7A3C93EB5289
      77BF0D1311A787999946DE388FF058007A4B6E5057E11ABF07083A5EC6097CFD
      6561BC529FDF9065E8F8F3F1CA1BD1EA9C154D2BB47436F327E95FB80F0C9E34
      F83CEC474137890E64B69637FB130E349A489775C9DAE9D5E43CE1DC0BFBDBD0
      95433A6129FBCFA2C7EDE7633566E9B95D1AE91BBAB68B3746318E8A86557640
      93271AAAD25A163B85FD90B322312B501156AAB7E46136A7F435F91C26FC1698
      682C7C77E5CB73BF7CFC85F40A9C40E1CA49D0F50487B8FD5C2DAC7F987BE240
      C74AB946B94C1176147D7CBF21D3C25A24E4A6D05F2363F2E50E52BF276D63F4
      62DC6F524E05CB7CCA4915B61549BB5B846AE6BDFBD2382A487B1F3E9E674180
      99D1054F5AA5CF25D942E57176499C628F4B2AAF75D810EAAB3913E71C22F5D2
      F8B82AD9AAC84EB9D54A87FF4F6C9067D13276052EF6AA00BF3A4AD62133B706
      BC3B078A2D6F61878972D54B1994C4F421CFC8C95DA0A86414484E2E07972B2E
      943AA73ECA61A82EAF62FE13590C9892314FC44BC4B1E2EC6781BC07E5ED4549
      E49FE2EE7A4B8E8FC6BB8F3C567458948B5D80E422EC66E14B99F3636DF24372
      9351D889229E35525931362DA2842D078A040BF131F420C703FE70F76431ABD3
      6E6F9E7639447BD3F06C232AE0E96624B53A9DBB43293D5C174BFDE0B2C2B593
      9AD90CA9DF25D5C7F367479CD9EAE56AB6A95209CFDC57768E5E7431DA9880FB
      DCDF4EFA8625AD3D5220E4D7186D0F6345CE89F63CE12E4B91BF5799DB0F457A
      61F002C886F414C8E4E14D16CC96C56F52FC3EEFBBDA1DC937E8584C706F3B79
      CB72CB8ED75F3951C7B88557E62D49EFA6AA86CE6745336DA2FCC3B82984655A
      793FA41638E79ED6EE9BA5DD935EA244A8349A4EA58D940C9FD2A63727D4CF34
      42986357905E8B05C431AE877DD6F85624F6EDDA293381E50EB147AF2551973D
      13C7EC84EF51AA6B45BC53FF9252816390EA2AAE28132ED947D1D78C3726FA2C
      8858EB67654CD98C267F6AFDEC53E9ECE0833C3B90691B335351666661475391
      CA83A2B958358B651E4785EF6423ADB91F2E933C6E64FF8989983443D2B6541B
      C5A45F74C498218545392178F68871CBE4704513A6CE38027F318E5004CB8F7D
      48881DB33BBE28A4C7F940498C3D3FD550D42028DA7894B46A799691FC07F979
      5BEE9BA7CE7A0AD90FD64ECBAA4CD3EC34872DA1ACC2247438DFEE0AE74DF9FC
      7BC2C787056DA6707E46F054DFE78DE64139BB157A8827DBAB0E537B2B079268
      B52EE542403A9B52A21075CC168A2BF478263B6CD638D92A4B0F72A29872E60B
      7D6ED6B0733320D122056ABF99C6F0B3D59521CEB392ED9B8C70046235CE7BE8
      30419D988C6551EE3CA948FEBE5DDC3F122915A3EF854C2CA77C0A1C8A20C98F
      71325621339EECE465C26999B8AC38E7F1C7C221E3DC921485B8D3316F40FD53
      C28F18DFB236CF32E44F6AD1F91417E68FEFF193CC64AE5827ABBCBB644C92EE
      4F6435DDDC152F22F3C658702C211E26569D6D5137B2B861815518F2686A5CA7
      153BA366C70D63C727328052FB31368E1F1F251CCCEB50163EF65143F6F67EBB
      8CF7FC99E27C78528F7ECCC61EC5A86EF43B5BABA25DF66D9B54F90BEE927F8F
      FD26D90BA32021AE86A948333E3299A49C3A2B3FBC503A1131CA5569DBA1C88A
      2C11968A142E47C8696ED4506E446E1BB05C356FD75CAB795C0BB4E24ABEB5CE
      94D84FA7B0331F942F951CC57256A464ADCC553654094273957B939CC9E77CE4
      8EB435618A66328FC664A82A85F25ED38CA3298C83D8460DF65293B370ED11F2
      CF83257D340653F4BF5F9381568D81DBCC7FC5541070AFF0D177107379901762
      9CA5C0C56E6FCFC62A5DECE1D91D0D7DDCAF4D9C339BCF6C2C85185F359A622F
      0B9DC00116B9EAF6C0921DBBEDCEA2885ECCB6D252F4F192A885DD6454FFC80B
      343351664EA02ABD6B31BB924E8EF514926321F19D491AD27CBF297C9F4FF457
      D7A7CC8AD180774309DC733FFEDC4B39374E651C42395DD6ADA77DCF7591D646
      D3BADEDF90061C966DC7D9D48CA6E98CE608660C33559709604FF39BE6F09B72
      7EE28A05E3F818D4C5FC9779A02F481D24C984C62FD7BF2A2EB32159F1F6088D
      3C9B71F7D03896912C9C8AC0E3E0E294DE48E67772233592390683C6FC7E7BB7
      2CEBD50321531AA73B8137E75CB5E4B75E11C9CCA1CB6B535794AF2BCE760FB2
      046F252B9F7A2979E58D6B24647DFE8C6E959DBC94C1BF3BCE0DD74E9201A8EB
      7312F8739F45D73C3E6AC3A8D17F83F3F6A1535A76887DE93B1B748B5B2635F0
      2F84F486D4ECBEE9ECFE7356B29CCBDEFC421B6D11885F7363514ED71A061A03
      03E7CCBA1637ABEB5483E5D052E65CAE952572BACD8E504A07B0BFA1E8FD2EC7
      2994DF12C4614A98A8D2721262410F36F026D098C5A1F116DF962EE3901C4FF1
      F9B1C073E7844FBB55B51279F6ECC5CE74AA3834235056765E6618305C4C8E23
      CF63289291AE48D0A8933380DF1643574A2C5C195AD88242D910A960495EEB63
      114730E1F3826F825A8F1D5275A11CC044A0B6EDC65D5BF0BF2D233DCDA3B40D
      2F448CDE02947472135DC99628496FA126800A5E4AA385412C37ABCFA26809B4
      9B3A3319A6864A68860E84DC1B765720B3CA4256D5D298D27C4C51C29FFC9DA0
      BC405957357E34053F38E7B3F2E6C7B521C7E94D95C636191C60E8F76B7278C9
      790525C16CAB76761F33407966D16B09796049CAA7AE105753FDA9CD937F9455
      6138550139631F05325941967758E6DB66111B6DE92A675A42411DFEA4F4EE82
      5B2B75AC3ECE86CAC4EE3A89340E17531A73EBAA2803D767C594A09CCA416576
      CE6E7462D90109983E9E15D2C69361829A33379D331F51C9344E6B2AFD9D3547
      6E0A47E6142C6E349F73B877480767205E5285C13C0DBB3CCA99395274CBD3D4
      4A0F768C522FA52FA72DDE2AD4249437FA94F956CC17114CF94D5EC7E5CA61A7
      BA6598FAAA3A0006FF62913F8F137C7320C88C1D6CF765EE12CC86AF046E0C99
      C72C35621E41D37367B15095943336F10886ED97B403DED0849DC18C3E08CED0
      195C502779BBC32C176B2F449389EF62BDC256F6E96FC614679D93BA1D18D975
      2F709303E3F838D92F05BF02679419FA362CC288E8EB3B2C4161947517E107E7
      5024F38331FC0C0E5CF8B978886579FE4C2D0CEE0995B8BF14FB54631E391C97
      7232CD9D1BD8516EB0C4DA0C6A6D568E7A353436151AF7CED003BC06D57C0929
      B8C8F8D10FD33DE084B096AE4872C57E8F0CF248D77BD246AF21B639104B0673
      5EEBF24222BE49B70869B8F828732CB722CA6726E77B9FDDEA384640863863D0
      E452B6A6CAD9801EA08E3A2CD3C0A0D294F2328E11B3A1C519BC3517BBD9EB64
      197A322FC08FCE7CBC8CB1BECD7BCA84AA725112B2CA374DFC5AA941397F290E
      98C32130B22117266463B5758A6315794EF9427D15C99125845E2698199F4AB4
      ADA684BEDB3B7EF9AF5FD582D0EBA298CBC791FCC2A997ACAECCA99A488905AE
      E3511470692073B43D50EC2AFBF56067C328FA97C89ECE564733E9A63369B22C
      A1DB121F6CA9C41E86E05297490D110BC90199B366CACD61CA4718655B5AD9D6
      6BE09FFB6AADF6242F5ECD69D8F20AC7D069BC14F50BAD5716D595AA912AEC24
      9308CC2B49CE68A9E8772E2D86D938543127CC5283E3D08CA5E98C458591C1BA
      940E703497680A972855B4DE74D66684754E3EAF78A33BA9602F3C3F7C49023C
      25A7806D8D5BFB2D966B04D1AB25B5B944A6EDDB3F304E415B4C3903FE297102
      5F049EAC6C8609AFB9D1BC2D2EA343C57C81D90081895D2A7F9F155C4C367594
      DFCE56FB0033051A5E1C2D38032F4A8C54A76E1151A94C90CA6432B79620D710
      B274F3C092C271EE6C3915C1D69EDD18ADECC491524C71493C671AFA29CCD83E
      7A9F7885DA879AF33596F3318EA9F8432408CDF49AC2F4D8B778C31281524AE9
      F55131DDC419CB2515E8F435664B30728C7DF29DC0FAE10BE01127A12C30E973
      AE6CB20C8E63E15CC8623F5C0037E1D442A7EC17E0C040D5CBD055446FF4A66F
      F423AC962A4BC8E91DDE941D7E44808B70C9A7AE7824A3CADAAA5ACCBC6645DF
      1D77E68B5DAC367BBCF8A7FE76647FFEAC5847F75895537E17016F48F68A6E5F
      780444A74179EB9B1E8587908BB05DCC2B1747FEC54DD56DF882E457F5B4FCF2
      AD87A28BEB04E7D17B3AF5F819E65B3D7160E44FE3F5E2DFDCDA4E81B4EDF238
      28D08EFCDFFC14DDB48A2E54643CABE5D3C4E9623CE55AB1FE0EA395F9587106
      133C89D82F786C1DCAA431ECE95672704B8BD59FB3070EE09DC8D8F984900E36
      565E41264B150F96168B49CA1CA6F25C2FE582A06CA144AAF4CBB595306F0A2F
      6BF10960CA6E344717BB1AD6983A9E61EC691C79A54C33E5CA06C541B030CE86
      3E7F8E932D4F26651B4480856C31570248F945AA8E6EF24CCB651FB7BC9EB7BA
      81CB3ECB09A172A1B193FB90643BBA30358B387245024B2A0EA787EC1352A861
      2D6FA2B40F8170422A10EFA73566F1C5D63B38E16F28F0F578D48B5EF9448834
      05936CE752B5653C06CE684890F7DD4A7922EADF0EFC87ACEE4E81A624351D54
      7991E33D7B13CC461DF8FF4207D096C3B98D33FEC36BE7DCECAB0AD6D02315A4
      49B4E9E52E883969A8CA5811869D0207C96989326DD4D9D39EAAD495FAF312E1
      5F398571A9D46FD980B21D03EF71C98506B070E9A6CB186B64CB438316F9CECB
      7AE4E8DC59282BE5C8A3F6BC6E967C6F2CE68012C9EA0E7578CDA9FC231D2C24
      691491C048257497C8CF959BBE711E65BB04D3012E132AE7E564A7142A742DAC
      6361DD7ECC9DA55CDEB4F4E29A0412567CA94A1AF92514A9876C75BB51DF5E51
      FEA14D762C37199DFD886BCC1F8D2B57A89EC9E7448C3CB4A2EF04C8217BBCBA
      7BFFB94481FBAC8875ECA8CC0CB6E451A622637642A4BDD737C66B27119F8908
      F664D5303A6B1E47D78AA2B6177C67105019C60A8122ECFF07B3B994F907A922
      727647EB6F06991C3899B4717CF2EE1D928F03374C9069BAEAD61DCCAECC0856
      4692977C3B30FE7260BCE409FE37E342DC64599297D2F5447ACDC1DA70228BA3
      20D83BC8FEFA00CC4AADCFDBF012D5992CBA7B6F97723A8E2C749C331C05A275
      104BF21D2911A98344952248F10655C4B5C084A490C419C055FD5519460EBDC1
      2D29D3753AC552758A14F25C9C94B5956E944795B0AEAA75F5DE957499E4FB97
      A7275A949C0DB55ED754BDEE33E0C94C066F70BA3FED72D02005AF9C4223E326
      9C07B18E3686CC845DF038F6824FF141F6E09C948940ED44B9328F05C9DEE840
      A6DEE904BB04E648ACCF0A816034C6D20F3C125BD6C88CBB04BC071DD3126529
      62B314F579875816558027E1EAAC1E051FEE65AFDD23B768E81CBC3A405CBA41
      1FB8CCA51AC40398D1197BC86521352A3D47560BA3C684C74A81287A7EC9A0A8
      2462D991438580D4DD0B10135022C189C92CED0107CFC04AF02920307394F964
      B79C548E7587B49B04B59B162023285A258AE7C12C9B85E52B483C5913AF9661
      DE9C82FB7CA4ECC4B1AE0EEF1CA1741CC5E46A3C15A18CDEE1C8DC4D2389C56F
      4B3F261F9920A27431133444A6CBB050A65712093022101019C51CAEA5CB91AB
      8E7115C56405055D6B1A93B285E166598605FC9A83AFA00328F224BCAFCECE4E
      34D4351DEAD429ED9E14C94F518BDFA39041FC68FC48F58B75906A63C0EF9372
      8A04493CE1DD8AAEBF2CC903C316B005F13CB34E36E6E7CF8AAB5E10B1D5BA1F
      1AAF05976A930A3471BC7944FE1CEF8FCECE019FC619B7CB9CE60B8AB94C1E40
      EDD2C1E80BE42B514C1A50566807D5F003A99A92001DA0573D852D62458A6819
      6719F8962128B332830AF22962ACA80E0A56FEB15E110C2474D2650CAA3D32A2
      8588162A5FB217A1618A80DD31BC1A73B41DDFC4421903A03F05C64A20857644
      64901C174489AC28C757C96DBF666459AE9264AE93998901AD4C320845593E60
      FA8ACBAB6A94337C5C396CB1F23C4C28CDB7F99CF74A16E6DB3B82EFB881E4F6
      AAF2B7A545CB5F5A63AEF37E119189D5AE51999B64999B53512C23E98D6B2EA4
      6CB4096F72753A2B1FAE1A0A8DDF96402AE49F44E423474BA68B7AE3AD6F7188
      4AE124B42F0B0452DA7CCE143A7F20579A0A0029E573E740C2EF11E0512306E1
      8AC743C3C1513C4820884F266B9F892E7AACE88BB7FF80C5FA19F8CBDBF99B08
      56F821867E687CC27487824D514CC7C0E0B2F82636868360C8E197240972FD0C
      FAE2265AE6662A2F322E90DCAEB005FA26C6A2763012A0752DC3355C867B3B07
      E1FB52FA4E3253A7838E2422458E952F75FE2119A1CE72DA1889AE08B4A413E2
      4E84FD2C73DA7196F2625ED01A484A668479FDC3EC3320951CFC369E48176F31
      5A84C658BF7CCD1E10EFEF65584D41021994525225A4C3B87EC756607963CF4A
      F7A089FDB3941EE89886ACDCF2CBFBEC1A56B56E17CEB0933AC94D48B8958938
      00E561FE26F95108F270BA4699B838328E042829513B411215041EE8ED65E6C9
      240F1F4221E4F9ED381740111E28992988CC68DF62EFEA8224CC91E7973ED928
      38AD8B346CEFCBAB0186E8C5175C4159796E6BEDBEE9C8901561E763B7826647
      BEB63AF954735040661E52EB542B5152692955D4C54AE2C19D8E114903CF4E83
      D995E0E4ECFD01FC78C762C4BBC875C87F40165CA51478743CC6DED38128FB09
      DC922A5BB38DA6B28D4F7414F0594C8C5F3EBDFBEFCF3F98F49FD5F915B9BFF2
      F750870BB076BFE311C1E8EBA1B8165BD405CD521ED254982D638B6D6F865AC8
      7D7528E5AC2C671D5F14B9B38BAB9E557A2D24C4601FB7147D80586C700C1924
      012C2AF6DC08051516367241A5BEDB037B28812497E0014DF174268DF1D01DBB
      F85959813CE3F5CDDA211B31BBF2B19166494D65493F2A9239F41C55E54F0AB5
      9AE13485E1A0ADF771529D95C8E3410C8F4C8285A87FA96151D007672C99D772
      D7CD4F8BA51313574944EE2CE663E179E5A312E0B63B3A1F147923E6318A5553
      D0614799CD73275D64E7987B28705CF602F81E36E7DFB7AEE8DF015C3E30C0E4
      8BFB51769F56F9F9B38758E7B1D834F51A289A0A14E7FE422343E39081A3EE68
      6D64F5B494DD499C391F706DE6A42959EAD07DD271DD68196EF726CF4E3FE78E
      471C6F379FA9AC97B9994D1E9D480E208F7449D1C596F1E6C3F43AE5DC8EEB7C
      5B338EA7C2385482E6E3C05F8C2358248CF1DC60BED04CA5394C85C2678F6F29
      9DC086734AC39F9DE2871CC4CF2E04587ECD8D82E53C54D7B2C82E191FB5B51B
      EC5FE02AB23934548A5AE859F9F59308BD0150AA62BD57BEB11D7BB20F9A4B34
      9D4BFCF293886F7E353604AAE813D5C63086EA44DCE55D98F94A243F3C6602D5
      DF9098502C7215293D50B2CE97322A4686B59077802A3449278878A84BA177A5
      C82B3AEAC5C355E0623E25F634A618DE55236492A28836C636BB796C33854649
      5BE1813C203D20CFB047CAA38EB9661E7191547032C5F87188C2FA82242AA916
      2D1FDC9D172B42D7ED603985BE90A4AADCF08BD596A4FD7635BFA0D19241ABFE
      C4383EFFFC0ECD09331178E5E4EBFB1AB51A8E5A0057DB9D2F2F8C5F30CFEAAF
      1CC5A9D14CA3D9DDD18CBCCD1E18C5F24A76801EF02B506CEDA0C8E21081326F
      48E90B478A7B86759BB206AC97AD93A1E1F22449AC562226AF4C1935FB25F4B8
      A63DFEF586C396F3B32999CC634F3A2DED65093A7207EEBDBC5810F6540556D3
      BB6B9898B7AB30EBFD3F7C44E2C189AE4340B8A9EFC3C4BB1161C9299C659403
      E3CB9BCF07CAABECEDF9FB3D98ADDF9614AD4D47880B3EE36C530C61B22A2EC9
      F49799CB3A532B066C611E148EE1624A99F8ECADB5F7FAE3D9D9AB771F3F9E67
      11F5F0768C032C05D6E7BEB9750000F83B3BCA713C7DB906E3727BD69010B5E6
      89B177861940907E2545A22BA00833AF7C4A9A87DEEB59D5C8ECFC01664E953C
      71A369885E24FB9C0E4B804ABEF7D6402F6A03DDA88DB72FE6067952CBF07F7C
      890A7550E90041228C716AF6779887234AD2804BC641959CDC82856035D36F9C
      AB70BA444D1E53E853A5F5CC6090444BD0E71D3F0E31AA23F000C65CF4942EBA
      E5D571037432DB201EA2CBFC12C86342CC720D9F9225FB73BFC0F89E5838DE8D
      8C6FA5E0D5F6A17D68D1D415C2EE8AD521EB84264CFC6BE5F0036F3BC88B52E0
      2AA0B71FB1528C44E59AE8F8BA7931DD41C11550A5B951A95E513CE4E047A6BC
      A26421470BF7BBECE39A883CF5ABF25CF4FC4BBF4E5E80A5DA625479AD508E83
      F3D4601D3D8AB8903B7A7C93AA7C35E5543FB03177743DC893A31407CA5B2C8B
      D481E5F1962EC51AF91362F85CD89E9298E7D1A1B8E6732744F74B40F0192854
      2D4CD9E1BB7E2AA1E646161D51BEA285AF0B55E6804F498053AC4A27CA6DBC70
      FE2676A63528FD45F8E20DA62205E2BE9A4525072C9D5FB79182FBF3676F3724
      D55501E5AB39012A8DD4A5D5C6D0BF6211CE19BB80B68ACA3C7B6102AEEC6313
      986B4A59B8E9242DA4507BCD179ACE17DE471810000B1BA720EE91B0BFF77F96
      F30560F7DEC674CD7AE7DF69FD1E40AFC11321E32FC6F1D61B31E1ECD7DF61E8
      DFDFB125DA94F05BB2132952A0CF664E7251B829D386E61F4DE51F1F9C4B9026
      13D0320BF1819A4734473A38058E7E7E72D67D757676C2F9EF3F760E30058E43
      C62BE14D65B934FA8849A42F92CCC7A490D147FC868A03E724A34AAB581B5BC5
      BD9369236B536AE52A1F277E97F9B484925E0E30B9BE2AC754C70097F5CE4865
      0A1A4F5CE7591EB880879FE42AD0A1D1FAAC52D3ACD9135803C492E498576D32
      39DC378EF870E3F81F14DC42628F33F629A14D325B4E260169AAA0A5AA2C7018
      86A8C4A795DAD92B9D9583BDE2E817AC3E85C94B519DE7E0E8623685D2E389CA
      5751C300B7DDF84E9955A721E8D2AE434975FC10B367727282B0604CF970F4D3
      7B36A4102FCE6DC39E480526F09DA2C33D457C83E259C8B3C4398793653C418B
      05B424138EA20A5F3F11C5669275A9B8BC9F702E224C11E8BB72C625E1254AE2
      C56C885E863D7027508A1BC182811A9ED233990A5FB883C75FBB979FD7531AE5
      EE65921B72283CE5EC004EC8114DA5CC5BB4F1D49ED82157C7E68C5FECA942F9
      E461F0E7E5FD4853452BDB1A83709E670E4957EF03F2A7ECA3F0BBC0130A13CD
      5C631F5FF94F04EE2C274B96D257DE877C7FFBDE56B9320E0CE4E006E552A589
      91552EB414D07429E093F2B29C2D53AA62220F9288C6E2E542BBC9364A269061
      98421DC0234F9246D52CDDBB2FF9297BD21274611DE13CAF29ADF841E122263E
      E2F6B8AA7092DD5CA80598460B83D603F3F584E472A1CC9819B14857376E57F2
      68F9BE1A832B596839B51334434C051BFAF80F3C794957733A263B67C50E0DE8
      2D4CDC0CEB156296D82555EA50B59CC3DCF5586E8A835BC685335DD82C1B8CCC
      68B0F1C325674BD1ECB0D1EC70EF986415A476CCB5A1595F53581F65E72E2F4E
      9E9E037910703F0F195FA18E740DD17B66FC08D2F249A24260A55CE7604E95B7
      6FE0CB29A61D3D9F650944B0760FEA0BFBC080D27407A1F36D21415B0CCA7696
      F72E7028212615AF6D91B6E1B831888646827C380AF511CD13E01A14C60C1A45
      903AC68212DFD0E99DE6214DE22154F6B4B046E42DE1288F1C19E9C82280AC4D
      5FCADC4F3AA292B260F75F51518CAB284FB50998EF6C7794E054C6D28FA62EFB
      78FE8C14C703434C2682D26FA0FF10F711DF4F3AFBDE7B81250929224ABA061D
      626A7D4CD9C6997C567B5B747B2A1C46E77374C01686FC2C7AC33B5495152A48
      08DFAA5B8BDB214B72CF3115B2134A9692BD5025603173A55FABF0053E6C43DF
      37B6B7C3E4D20666DFB062AF397731C8717EE0C49CFD92B2E19681E8D0385AAB
      1E8047F6854E6513CDD9B4D5DADDCA38727C73928B44E6220FC515BC6965B864
      A82BAC2447BBCCB30892B44EA431559991E9180AFDD919E0885E288796C38796
      2AFD67A9E7193D509431C3DF4181CC72F7641A088EEA1008832C1B58E0891A69
      FDCD3821DC3C03C40C82C4F842B1810724E26777D1E63D3F39EBFC5DB817187E
      9D32A1B345A7305440F5DD9C3C6078BED4B80A6327C7F81A3487FE84C511D322
      B27B078C729DC6286F2959AEC4B52C4E2F55B315625B7167C44CBBBE4CDE8349
      84D49DD4635C741E85249C9032F74C3927073B267AA597AB4CBB7EE688D85A19
      44AC7CCC41B49286479463729E892459C730BA7D160BE21E0F865D5BBCDC87E7
      2EA44C8B4BF9D392354646F2E12E00315B67BB7760516C36C4D7CDE75CDE8C5E
      B9C6661359590457535A7F416DCD0A9CB88ACFED10F4FA2EB3EAAD0AE045D1B5
      B00024DB6236B9DBA4D9EDC9C94291CF15BC0794E9284E9D30E5E487C4545786
      CEF5BD14EDB3F35E096EF95127A941572CED67960619755CBF903016660054CE
      A017148A235A15F8F09AFD391D83E633FD84FD3F7A7DC8F74C61BBAA1867BC0B
      5BB8C261536581293A52A2BB1A865C149FE6A4C058B667C79E4A082A4F66917A
      91BB101F29F00E987DECAC940E00B22948FBFFB1F7AECD6D2349BAF07745E83F
      60B8278EA5199AE6FDE2D94BC892DCADD392ED95D4EED9B7DDB151040A124620
      C00140C9EADDFDEF6F3E995500484916D4ED0BD1CB89695B164100959595F77C
      52180ED74215BE34971C3C9E25A207CB329A863CCB8479A291244DD62A0D50FD
      560AB25F40E324F1E2E272E9EC926C3CD0F91BE4D3E52D5EF427CEFAD2042123
      8BEDD6AD50CA56B2928824C1F97C7AFB3CC78D60E92D83A2E91E395985DE2BBF
      AF2034AD01507C7585CB7E421EEB1A8582A6CF144CBE2AB672762D91C6A4B40C
      02A4C489B9DA08291BDC90856E9996C86CFCA69DFCB461C433B48076599E52B5
      4838B44756C21C05BC18A39518700023FEF1C98E208356502D8B8C77C8F0F4AA
      F4DC353099E559598C313DB7422B2F1EC5739FA67A50C45D4C0CA77BFB8B101B
      E92A88AF1BCE43E68D05BC9AF2B34CA292E534291E0695A79F970863E21C45D5
      6901549A5990676BAA628DCF3281908E2F34578701308B59E6F1DCE5F696B10D
      565E80B726DF9854B2D365721AF526196A9EFC679E5E74B72CD3D8D93951B74B
      800CB261C604379AC0680BBF44A6BC67AF2CF7525D228FB10F9D1C45D5E4A14D
      36DD6B6D9ADCD63D4863DD073A4B2809CF0727CDAAD8EAF95086C2AFD8C475D6
      27AEC37B6B8766E63B8BCD5EDAB2D2840D4452484E902ED3625A41825415D2F6
      716AF5FEB94DCE43B13489C708ED1F3A8500CDDB5A9A4677E4F084E92290D218
      0B929A4AD66BC937754A136171BB5C3CE78DD885537D5121DFB6C19C597B91B5
      BDF58A139E5C5E14CF492F7DAFC379D379A33F2E52B2D08889BF0BB2EF17D326
      FA06619D36A1EEC9D84A34D298EA426F2AFAD6484CD9DD7C689EF64A863D777F
      B1673741E49174338C605B78FFEB0346BA62F44C697FCDF6DE4FD9EECAC2EE2D
      61762C31570A9179897ECFF9F06C3AFA4022EB7FEE652BB0941F3CEF0DB1EFA3
      EE13788B56F577975744073CFB88EF56E0B630ED74EF65397C7F99E9BABD4EA7
      DF1D3E409A0798EE037FF6099603718676FFE51F4F61BDC7EAB957F7E6E10709
      AFF1072C2A9CE7CEDB08F216B00C73562F4B8067DF9A7D2A2E259777B41E2482
      8B7F43C415CB6A3AC20526B48B7135ECE85E98F838BCB9C2837EE4A1A6DBB118
      64982C22CE0EA9B466E4DBDE122D41D463DF9FBD3B785A7E606205218A2B33B2
      37482BC773548297E31796B64571A134C84A6768FDA86174A5612671F0EDEF52
      9D5CC3BF3DD52A7CCE5EA7CB63EF39EACBFEA35C2FC3DC11203144C37416E710
      5030E8A80A9856980C5B33EA58DBE1B97318CE82A8324D112DDDFBF159BA647C
      94048EF31F98D2676C7399DF4A9EF322E37984692A535C9DA2573C8E2E62EE69
      5D6050DF12675A8EDCD8AFEB6EBF4A3A4E66CF7F72B37A2B9BD5A73FC2EE6042
      7FCEE84D3A1FAEB49EF31FD16FDFAEFB6D84CF6A96BA3E59D48F180ADDF299EA
      9629D7F97DDBF6093361E531C5D1ED1A0762E325AC8F97509AE6B90CC3610743
      293951F7570444CB3B5A31912D61D7BCABA688B0360E780E54F1C0476F686C0D
      C983D8B133D5F39C08D49A2FB39AB85641289D38CA99625C26EA7F8328CB138E
      52E6CC2356F98DCDF34DA9706C70C83EAD2C36F2E79BC99FDC96DF88A03F8E08
      5ADDD4CF2E850A0FF09BC999E2151E103555DE2107D541C512AA25C8E68E0B52
      EEE8D645CBE9B7DAAD8F4DFAAB8BBF5AADD6AE543AC8372DE49B4D08FAC1E360
      4DB0D725A7B623994D4EEC4A0E78D754FC956C37D31661242B373C049924273D
      C12B33A3035776301F8F2C83E6D24D29F3DA9BECD67D4BF42C60562F9F858D88
      5E1711BDB72CA3F26E2F72A02F895221479171F2EC7E8A8C7A8A68623C2C916C
      900DE84DC5991621C34F359565B994FEF9E32F223B8A61F45921397982B95118
      37974F03D402EEE1B39914722410B509E693C6493ED5B05C3740343052A978D5
      A054043D0FD104CBE2C950A7021A4652B4CAD293B9C2A7ACE7F050D28D331549
      AC70F5052AAFD50CEDB6EDFB366202092CBAA214096939AF253A22B23A2D15C7
      5E335E214B7584A38A77D7731DE50DD62C12B953CDC465F2AAC959CC43A2D1BA
      3D5B90B0BFDD48EE7597DCFB02E24404A6E38860F7C6A25E1B710D0956DE9F2A
      B019BC85CE8E18652C4CAE0399C74567DCA1F3BFB817A367B7945D4451DE256D
      D613AA4131B65ADED4A429154CD260B69819CE226971A942D37760E011CC474B
      90E2C6E4ABFE606B801B919E43996C529DCBA9CEDE26D5B99A7E38B37CF89CF9
      D735FCBB107C1494C520B9F0096EAD9CE6C8D97A59DC1AF323CF3E222FC41610
      170F03983513976D160BD86FBC04F9990F575D073EAF4C8BD7648D80DC9246CB
      822CCC910477CA937376A5EAFEAEC0B0FD6B33D3762768B9287EFDC7C23A97C4
      E65306B356B3D8E0CD9AED6DF163CD03D3E0577D0784BBE24A8A6D0B0CA2A294
      5A70BF056E5CCB9D39879690ADC9057796132CBD07B1DC5281FB0C322635AB9A
      22036E870123D2E192BE8996F6801F23623BEF5F587A824C85E056AD1218424D
      A80A9A9ECDD0E5F01C35ED53001299FC784E6E463C92534194A95C69B0BDF585
      37E9C8B601662406F30795CE9283391EDA0C0921ADA439EE557AA1029D941DBC
      D5AF1AE48F4FC900B0C53C89D9998905C73CBD4C16D19593C6952955552148EB
      4FE92541ABD294D44F2DF173F0F4C64B5A572FE97BB040141790678C963D9B67
      A4A6E39B8DCBB4362E938C046D3CB25FAB01201D7134FA451E962E5A53973D27
      DF7A4E8FBE48E15A3D116688BBF437DECBB2F7D2DF782FABCA8AB433376831E8
      3FA27516B91DED48E05E6266DAB75B9E3E038004E27B0B5363A70BB2214ED675
      B6E0CED8573A0A2EA2E2D318E004C8D141915D069EA7A39A995FDB5B47BE7853
      F9F49E07C9645B386FD02A81E5EA9C6EBBCD92F0606AC877852616BCAB8EB4B1
      ADD96776500F6C47164195B9E6848E6E00B055A4F2CA32F713ECB3B174D6D5D2
      D9DE925805E743341D0CB16079BC2C8FBE5DB25CF3CEE8CD48E335368AF6B829
      DC983C8D83E55D7D9FEFEA7D938E31C0AB42F7B800CE5854E3E92D27F566A976
      1B05160237ADB49C03D940234107EDA7F5389B714DE272F2AB73F2C9E73C6322
      5382D05C87F99EF7B0A940DCDC5DA6544CD07B5FC6610EC643CE714A326C3197
      C4E14DE45CE9DB5D1E960112DACB4CC983B10DE59D6C97751E2C54330C9AE78B
      8259F51CE699CE4CE738CE63DB260865F982758902692E288F05E8F8D17B32CE
      2423EDE4E3B59806419A3BAB787FB440E4E82D4249860F61426EE4F8BACB7191
      E22A741A7B218C3A853F39514237A2F36F67636D80E6D6464C0368AE2CA81FD9
      B88724ABA0CA278BEA52A6E478369D45949A3E683C2E35A2916C3F4F40CF77F3
      D2367EB3272509E97AEEC5E09E6B92CF52A2F0A7CA379082B78F0AD8FECD7CE4
      30433ACCCDC0432BB1D866ED722E93B615ADD1718C4A14830B1C14E34CEF1761
      FD25C62F983BFB38E90CE9CFCEB8D7A5BFBAA3FE98FEEA0D877DFAAB3F18B7E9
      AF417F824B86FD0E2E19F5BAB864DCEDF7E5DBB8844ED0886FD39E4C7051A733
      69E3AA4E97AEC3DFBD519FAFEB0F07C32F79A2880AF9B09A4FF8C7ED4F9DA8BC
      36B8FB7B4ED48A1394CFCAF9BD6372F61CE715FEBFCA650F5D4F17EF3BCE5ED5
      CBF73702745D04A8F8A9B994B1122D2861E8420A6C64C0FF3E19F084C38FFF57
      BD5CFE575D56381B71B13EE2026367C4C8E1FC64900868E88E9D5C50A4259D7F
      7196D29255705159E4702DD4B79879BD2346DCEE6798965E65B1F1B7190BBF63
      4CD0AFB54CC1DD30F51E628EA3865AEC659EF3B364116FBCE375F58E65043BC7
      39386073BE8959AE9970DEDE7A1B1501B54C4DC9B79B62FCF49DBA92445B0C2F
      B46019983F33D43A7E6239E91146A397C13FCD7DA6B7CE1B0328FD023C032CCB
      27352298FB14D57DE80AA597F63896F7383A676691454DB316EE66027582D8B9
      04B421DA0C891D844A95404C3B372A1FD895C471F5E682734B63241AF3E4002F
      80C3A49741E8D1939A0EA846FE7C2A38B5F2F86769FE6B443F65C53360939506
      0B3F6522C6796CE2CCB4787791167D2457FA761AA34A70916EF2E72BF9F3C126
      7FBE9AFEDC0BB3BFBC81D2FE373E45F684133756AD16A3F3ACBD205B1356ABBA
      EC2CFCCB7BBB6296635636D56F2D871137A1CA50C297F9163EFF572BA7E9A77C
      95F4F3FB7BE65AD764A9FB928B3A886FA29792F2B2AB7D60274196FBD6BBB149
      D7D5263DB223445D6871516E3C9ECA8C6C58DACD4F47AE3696EAD74DDB7033FC
      09ACD31FE72F70469D1DD40BEE3A2FCC885639BDF987D654D91503C8D8315C78
      9C9896CB34236B2DB76D643A8549FD544FB8F07BED795EF13A4751AA93EC136F
      3045A7AB728B71BAE2F3DA472F412E3C9E6ACEE72D97C0B74D76EB353F33D237
      5C9F5E7A466A99BDE1EC782B29ADEA732064ED5E12CF1F5D212E9ADF25EF4652
      AEABA4344D54295A9611E247959A13AAA90ED33B82722327D7454E9E5F2E6DD4
      4E968FF5B2CD1E41D9E3B7A5390227C304AD12A35B1A056EDB31B8AEB3E875B1
      F3DE5928FC9E190B090E2C86AC60CA42A9BB6735111595849BBC4C763B376396
      60C3497F7D9A77E6B2318706FB18061EE3476E84534D84D3F6D6BE84274865A5
      F1227105CF12437D0337C878B22F4FCEB28361CC1CE1C6CF075ACF7F21E136BF
      450CE7D107D9D28617A8190186FB666CE43A893B3375DB405FC990C0D53DDE59
      DA436188DD7C2F01D99D1483485627A9A1822647E830D14169A2578C092E301D
      1749BC989B221EE5EC1F1E1FDB8E36E5FC747A7CC0690BE7F4F0F569F17B5CB5
      6B70A2228D198D2AB995E7DAE72439FBA2B8BB825CBECBFF2CFBAB239C241AB5
      8EE9D244B41C54D7B31DB83288D350D5D464A6FA13A74FA5E694567E93D7F0BE
      116E46BD5109F2CC8EF0B6FDE340D4013C72FE36B6C5D2E2B6ABE44267320B62
      27575B0122A632462CDDC5DBA995F7DB48FE7595FCA511A78F5E2B3BBC91D6EB
      23ADCFE31CCFA8312B76726686D5DA495764D565B7CE0E54BA0CA5CACBC06598
      AEC5E083A04C629EBFB5FFC32E8FD4828C2F066615782B104E6CDC69EF9182A4
      CD21FFE687BC7114FD9D542E8A476669994536D6D77A9DE74F6E94B39323775A
      AF73B5D1D74C6942C2D25EF238E2DBF6D6DDE61253306D9296B80F5EE9E8C082
      29BCC94DBFD429F2BB6C265893628A57F8BB34E8D94B77FE25372CECAF6C41B4
      B273486DAF63E9AE320690A7E6911BCEE0282E2E32F832E6D5E689F6838F4F98
      BA3ACFE11982D5147A46B6A30C0AD73C2681DFE5F13B4EB15E7A158E13C0D6C5
      B42AB256016F27FEB2E2097B49665B6FE4DD77AD43253076D6847E9A9BCFCD34
      78A872330195B9D599CCA55E9E016A6C39A177935B2079C25761364B88833EAE
      3ECDF12795C08E7D299503769C3773D19BB7E78E9945A9A25BC6ED4BD0E521E3
      BFD8449F99594045B9C0EBC767D5F1AECBE54162389F1E926EACCEB55748C6A7
      748D4F994B851D993E42FFBC4902F459EC6EA204EBA8A7EEEE5323EFA45C6EF3
      33724E46F83DBCF179FCC08A8ECA82E78D190ED81449B22C7A200EED5B6A69C4
      31F3E4CB2D37F9ECD52AE5B785D031DEF05366360B31EE25DFB54A02257D4608
      0E58F8A1BBAFBCF470592638F482C71CA3913D4866A2CDBD4085F1857445BB4C
      65BFA40ACC8045286AFB2699C5B932DFE4C9C317811D0EEF5EC681CB1E43E33F
      E8570C701B860DD6948D3771FE8BEAA56B156866F017252A590021F8A14C6326
      26F248EA6605C5EEA5411936F811629860CB4E697B9609CEC002E66B775F63D7
      02077F7ADF8AE7259A33A54FCC128A6DC57383D858AC40C9923DD944FDC57298
      0F07F34902594A3AB8506F39726726D6CBF4D1A699061E9AB78D65D67D90E511
      2353FC67086376B1F802C6001627989EB64257194D0571B3B44FA93555ED557E
      85805FF8E815ABBB6D774F00FEDE1B477ADF38D212215B76C3E9B5F67FC0AAC4
      6157CE3C5C5C0451D9DACF217E668BB03CE07E63D0ACAD41C39824C6733B3A10
      D9787876BCB15AD6C86A612F29B70F321E49BCEACCB2B8CBFDB87F75FECFEBD7
      AF59C028528EB3B95475146EF14CF04D7D729B8B6FFDF3BFF0D75ACE9151CF3E
      B9EDCB63D8B318679D9CA1E8AE232D72F3DB395E8F27F1368E576DE5D4A926D2
      4D49C5E4828A94F8C6BD5A43413537C9434C8DB4164F7EBC53BA290F547F9616
      A1F8521DC7A703896CAF3FA4B1BE85E079BC8BAD1482FC84E0A900E7103ABD52
      4283DF168E010971D454B3D1E8FBE5A8A59302CB02C327805CE103BEAE64388B
      0721676A838A5A0309F89D8E744296F8AF9ABB7D887BD80701F7BF7DB3779257
      2F6FE4E16F6B86FFF0C51B689FBF0E3EBE83A345F22C72F5236DB458F96710CA
      2FBE45ABF0F337F1B7582BD4C33759AE74B8E218FED137F5EBAEB32CE8CCA811
      E742E4200AD94B594549DD9112E4D25568DAD909DB0D66BE3158239B1D9E9D04
      FE664ED2DAEBBAFD380CD55C929A6FB88935AF34579B39C86B64F0E79B536E1E
      E7636A0613FDFCFC1727BD9D4DE3D094342E0F817365A3252451D918B6EC81A8
      6C4246FA9C4EB704830DECB0D41160EE669CE83C808DAAEE0A6B92366E444EE6
      F330D0A9B4900BCA24ADA0407FE638C94CDD9A6C03CA0BE3E42246326219E313
      AF867EF07C749B31D0F1103766737CAADC2B0731D3A4E5EC4856DC94A99B68BF
      29497738428CB00D63604471D63445EEA5B276FD51719DAA7C60BF69879832A6
      06FD2347B49BC59EE066F20D2B449BB347AF68ED56CF2D71E5AE8502B5955C02
      2CCA130DADB70256C274C2248EB2223BE7E9A6ED3E104EB21CC1F1EC3B3CC0AD
      0074D6793A6A1C9535073E3E34B42A6F3F0265E46C1DDA9E02BE5465A5BB20F5
      04CF502BCC0329C6D1DA220CEF0E3B4C757603D27B558A7997471055F719B7B7
      8E78CBCBF5217C2C734258A2092B72FE424E13D1C50BAE036F41BEAF6DA66882
      B4CBDF978BCB5FCFB7E19E1BB404FBB038AF743FB738CA4AEEB953028635DC60
      C6DD9AE94402FFAAB80878E9191568B9B481FC389920A4B985979112961F6397
      5A3D33C8089181056EC839D8749B1013370D2E0344214B8E6979237281463F03
      FC365E4CCB07C176D1E9340057A3C587DB61B8F5A62DF53BE5112F5CD52C9547
      E9BDF8E3A6EE068D5D06925D8549154A2AEF568646955F313F66E529335C9624
      795E03428995E5BD37467FD086D06A36E387D7DE387B83C23DC9193812D57A0D
      59FD3D71C4A6C87A9D8C331ECEB2BC5B8D5CC3D9A449B17516D8A798D140D77C
      AF3F3E0DD916700802A2CD5890C6DE3302F6DF58992E0D67C22702A0F0B8D951
      EAF358E23F7C70C2C927E72F4E672340D65C802CF15C54C2C42F6A8053A3A136
      E264BDC449EEE2E518AF9C8358952437D65C2B0A6C4AF5DD69BEBD79ADF7DD42
      6E037E30E364370988B2112B00F94B730624410333944167ABD48E67775FDB94
      74DB9A9CD85AC35AB997A515E015780577EE808F3716CCBA0BA01CFCC527379A
      3D6F53C5CE86725EC5BE9934B746D2E7E0DE1D226F711188AF986876935D8E00
      2438B126348C8CA712C07A816CA2AB9B4EABD5123896195A072EB48362CB5CAA
      99E85523CDF09B0AAFF773FE4EBF70A6DADE3507318D62832D603FC9C32FF4E0
      0B832ED869936021A7D7D4060A6C02DEDEBAA2C4B717E4AEA6E56559216A46E2
      BA4A305FF2FBDB81BEC81C3E197F81C79D5DC4EC8C4BF110E328C432BA737537
      100C2B5AED6821D73A31935059CC5799E497DEA6999EA105642348BF6272F349
      82F5C114114888D6A16AE9A1CF22CC11419DB1E2A76D2B12461BD9BD2EB21B76
      63A57C252DF233672C2BB2E367525105F3153D1CB9796CFC5309BD95EAFBC1B9
      9CB3E48E3B085529A334D54608D799F0DC52EBA0D45EA7ADEC63C669080E24A6
      57C13CB54FFB8EB1288AE771487BC9F5C613A590F45A8581C75F7ABC770D75F2
      1BC9BCEE26EE77C488C74174E5BC705EBFED033703FFDA08C575118A7BE56DB1
      9D1430015FF7CF0E6D242E88DC70E13DC16A3B32990DDB9991F219673F1BEDC6
      6FFBD2D4621E2DD93125F3A7D2A2990C43F3EC2F2EE817CD9566B3A237D8F4BC
      0477D24C2CB29042C9F9F0A121CF951BA91AEF5476D960D071E3BA23B860EC62
      8B0C030BB87A1F359C05FBA65E1356BA2AB911F7C429E8D5D358BAD885302544
      9A65D95A6A40CF6326081B903A103A289BCF7B9A499E97AB021832C75893A1BB
      79390CF311361B1DD252AF3AB5AE4866FD102CA0E8815FA04EB47A35EAB729B3
      0289F1DA2440AEBED2108A42A5AF0E80436E752619E26F468CEAA6F6EFB6B221
      37EEE1F3BB079D38EA343F433384CBCC71D5519E667FA5DC2B74DCD16F8E21A0
      1EB73A3616C7DA5B1C5297676B5BCA3516126E9BE585357EF0516F826B6B638B
      60146688DE53C7B4D8A0CDF5DE3D2B057766CACBC1D5EE6C79DE626D519E48F1
      5C3CA9DFE12892363357A5D2C39DEABC4FDF7420D3EDC9462A759B2C22BCC845
      C425F247E7275CBAC3C51516E7B9F4F9E3C5C4F4A0857B0943EC0915377B529F
      1AB864DEE07D837456688E12F694A92A4202C54C1D26A21BE65D2A8BB88FBA4D
      278D4D090BA0654C8EF56E5EF5C636E29B9CEF6AE18BD164F760ADD29BD2AEA1
      AB9FA7131770AA06CF267F55BA6505350A4E98DE66D83B6D872B5BD09744A7B8
      1123298A1F7AFDA4812F9FA4786EF308AD1B44CB059D8D6BDDB887AC86123CDC
      0697A7CEFB93BD03E75D820867C69580BED0AE7196250B376B20D4DCD8E3D154
      F491FD25D7354A5FE24CE340957DF90BFCFA81FB54A0E4F2A39A98978DD525D3
      204B0080232758A6BF68E9BD62F5857AC22780E21C65D60759B2EA016E0E9AEC
      3A676E12CC8D682811A89C92FBF1C8D99992AD094C74AEEFC2DCEC445D3C8B9E
      0104BC3ADED16A73FA51E4C779B102EDA267A2E7E032B16AB973FF123BA8BE8D
      75764BFF7B3E9B3D2782FD98EAE4A5F391DEDAD31F5F3AB7CBAFB3BDF56564FA
      B71A12F7268EBE52B387B3134815607B5333B6F6C6E18FECFDC3598E93A3039E
      F515AA0B51D28AFB3C49BF30D2C4C62C5C1FB3908CB0F3C3B3C18BB3B3431B37
      7AF1FAED68E81C1E1C9D5B095C029281B1560C0A685AC419C0DA84819B91AD16
      C489811271E76F0D54CB1302207991B5F41258DC26B142F9E9A80C8E38FC9290
      6B6A23F1535D36FD18E757BEDC725E2D1EAF66DFDEB23E6C1E1F93A2F39CA125
      DE4FA220118393C19D13313D4C2E992BD79282185216430B899C468E5A632B50
      EC55D59B9AF78A781D79DA17C885658956A4A2ED4B22D47F8321F376A788418A
      BD627AE4213A4BCA554272E297DB8C8BA729CE0573B0E9B750526E8C3A1F134D
      8B62CE2B63D81416B0D430C10969921A1B89BFEE129FABA2A4B3C43580562AD3
      2F78C7810340876223EAD745D46338B358CE8587276948A97A7B601F0318D7AB
      030383BBAFE8A6DDE187E0B3BC2909A0AF94CC2D5AD4C4EB2821A2EE402B4AB1
      213AB676CB6980427A2D41B05A248CC7CDDA4F11DC1C9C8DF45B77E9B7BD659C
      5E80A6610CC40EB8E5F42D5C67E229CC8290545C916EDAC15888A6B3B7FFFDA9
      54A7359DE3BD3774D9BBEF4ECDC56FF6DE9FE0EB7CC7EB40E56E76CC83C77676
      4BE9A10855B270D1773762765DC42C5BD4B2674D3BF1E39E10CB32C3602B49DE
      F473C629A5522B884B462FC55D916E7D4250CD94A758F339C7A0E418A1CF188C
      02EE90316CA446C01001A8BF381F9BCE6D75937E158127CB0755A55A2528BB46
      64A704262AD401DE63205D6D4B50AC62BE4A625444296A2F2D3EF42E1F23CE96
      4A49E6F25D4D20D5E7C49424BB18E70C2DBF30EB1F8FCEE932EAE113A26C5CBE
      B3CA07F71E7F8BB966C5C072C4ADFA5C15A22AEE2F013C7A84B3C345EE24AFCC
      002FAEFC0C6FADFB623AAB8D214EBB2F836B9A8531FFC07E2DF53AAF82E796F6
      06A42807C8555A4157C6F21AD5F30ADCA3A44C40F253D257F0F10ABE6628A8C0
      3CAFC930A01C37A6D345FB16D89CBC896F3317D23A129D07DDF1BDDF96EB17F8
      4DC4EBC125459A5F3A21380C5BE6829CF2DF22FEC76AE82B0500679A9CE50DC6
      E8DA1B430CC162DBB9697772794B47834F60A5C66D579B2E7A2B303676CDFAD8
      3522563F294F23AD456D2D04918721004B1C6166A7E5C25402745EB36C6970D0
      38FF806F5BF85D3C978FE1FAC2DB7C2E588198A7A618198CC87310719BBDCBDA
      5AC24B5C23C5125A442F4B5A49799775D974411651056EDDDE62377A29A6962F
      8CE36A85622968E605D259318B8DD3587C64558A64B24BDF166B881575DE7467
      11E211E7135A71C5704146E8626E7BBA31557E3C045BF6C56B16600ED6502A48
      C417AA30E1EE7F260BBE001B099FA4CE8D6694A6AC4A69D5A357C806792BC77E
      93ED597B814FDEAFAD4510AE329EF03D6D9EF06ED0AC65F132524E6C2F504864
      C2FB1B31BF3E62FEFCFE5EDD4202EFB05B85AA117265C220C55481E5BA1423FD
      69AB49BA710F2DF23577B75DEC6F1384B46911692213793653910C0B12EC9447
      DF3EB5350805FE0C8B65C5AE62B971B74A99753E470175B866EE824AC55B4C72
      0747660E14EB80BF624612D3A3A543A388B816773423D3976A7C2D2A4C335779
      DC5B4277008691C2352D67E79500BDE212B5344FB484B55510413C13D1BC0622
      B60AFCD3D2F0891B7AD1C5FC29804F32D55E0AA497CB8E887502571BE7E64273
      9D725E7BAEEE9529F8449CF7C294281B22BC42D0622619667896B0040C18D15D
      CDBC54006EF5E70AC259F3A1AEF5B22D6236C5B60071C1376E5D81C28FE30AD3
      EB2D220650801905B6134B4070B3AEB49E97CACCED822AB4DD6FB4EBDA6BD7C6
      294FEE68D85DBC14E881D5917A657EDDE8D0F5D2A1F91696E3F515F7D2C2745D
      F2A8421DD9412EF6167395A2DDC3557081480F3C1E468B671AD9A534BF137793
      5FA2D1C56847D110AB28AB4B4064769CB6290A21D749627E45B88A4B1F49BC6C
      04CC9A0B98E3B707DF115F197F70233BD64576BC57090F65978DB9AF18DFEC1C
      BA6E189332BA42B5BC4EE3E84F9B53B7E6A7EEEC928BE962B16CE771600235A8
      709EA196806BA0C9AF88938D4FBC3667F244D05CD2C2F09764690543E026D7FA
      48B4FA0C869A248B390CF4153E300D213BB9BB852CDA1BF566C92FC93BF4603D
      04D1822582173B692C8DA065B09BD28303761FAA57E33FB4E29BA8E83701933A
      B18B5E0B0BADB4CCC6280035FF2CA62C3F213B66C7515D45782EA85581E02B07
      EBEEB1B2648989C9038C7D79051734F594143A32C6988C99F41557404A7522D9
      59E6FB7825218575018DBD94D257D9190C2E22862356F94C96BC110695AD520F
      AAA2DBEC924114C96DC535D324BE12673532AE7DCBF98F782166D8152790A788
      8F70F5E4CDC6855B7759FF539C309A2F83739E708F90F3A28AF3F0CE74BBD92F
      416A9CFE1881857774EBA2E5EC8501D7D33BFFFEE3D9F9A6F4676DF4C4F6D6EB
      BB8D742BB809D84C2F47FBE60631888EC5B45CF4C152D56EF6F1D9B9F32FA576
      6BD9FDEB141FED9FD14740CA37F82FE5CF8EF1D9716CEA0BF993DD070A92D29B
      00A0D816B09C7D3E7EC70A4BE6E2A0B9A4DF8AA2A532D34BFBD8324FDB6F1498
      0B777C61C3F2869C1B79B7EEF2AEB1379F93F293A641C6C7B3D38D4B6DC61B61
      B53EC26ACF91513F0CE7BCDA4E6B32E9A8FBE20DB5338F91B48F67D3781A7F34
      6974BF74133617C360463FA2302A281A9C719747DF699EE5376731185984ACF2
      0850F33C9617644419296BC7EE61E2DED30AC59612F879F45C56DDB499715B6D
      68887167AC46F381C9DE2ABDCAA77BACB4B6C3A2560C508A4AC896B37366ED47
      2F485D3A1EF491FD4AD1005FDD86FFA952058395F6760EB91BC6A9C1C9F9C2EB
      2EAF586668C7D9721DBD7D6A79F566CFE82D6DAA8F11D818CCB7697B1A64D289
      F9360320D9AA53547982A39EA5F4942A599AC7EB41174FA906E5B797B745BDA5
      BC610E038AB4CE52E1450AFAA28A6361A69FDB525D0E0619E76275143C6EB351
      97EBAE2E454FB203B8D18FBF7793BE42D1EBF616ED92ABBD059DB83DCF93C173
      47FE49904212ED288D66B897CED1CD143FFC9524A05C827F4129BD44FD035D49
      9F9CC549261FA62F9D57711C2228F02FCE79B2D0BB7FFD1A9D4FEC009811E391
      D8E2159405822553F3B6F31C326BC73097B4E86209FCC3224100C82F25F4ED58
      1832EF65DA2F3DDCC71D4CA5F6B7A864BE7753D37B3633DFAEF333DEC5F4EB6C
      D4F6165E4BEAF7EC04604B3C80A998D7E23A1A7EE716EA562CA579C098A4EEB8
      C0711E062E8FEB80328C9D121B3EFE2641A9D024572EDF60C78AFD7AA5C96A93
      C98F3BCA4C3CE12D333F7F961DAA52E3F8AD269216A4388CBCDF4388CF55ABBF
      32F70F661B6C47530584BA1FDBEE2893DD9DE9623AC5386346B8B9E466766DBC
      0ADCEB7271A1515B33D7120FE75A515CFE428C3C6E0E62502B122200E87902F4
      D4F294C230B87ABC3A9D5E31485F7EDAB0EA2F69E8420B671F279D21FDD919F7
      BAF45777D41FD35FBDE1B04F7FF507E336FD35E84F70C9B0DFC125A35E17978C
      BBFDBE7C1B9790AA1FF16DDA93092EEA74266D5CD5E9D275F8BB37EAF375FDE1
      60F825553F43DA181E7F40F90B937F42F5772DC9BBBF4BF5DF69431EF111FBBD
      A7EB5A25770F35D6BD2C411E7DD02A473EF43CA704B1C4A7775F7C5E9DFCF541
      71FB85963E85647DEC699F75E9159636FE2C4B7BF1A2D56A7DD5A595D554B1C3
      BB7FFDACC4F93CFB9E25B75F95345F75DFA53F9664BED984DB3C4245AAAAD898
      CF428035DC5B3FE09E99AFBCBF8561B2E6ACAFA3BB18BB4F27CDA38FF9EAA2FC
      6BAF6B13B758B7B845E12590331B27B3A38343D431EC5F6AF7EA3876AFEE730E
      EE58399F095BFADB7A4977D7FF6314DEA5C017436B5C718FBC20E592597929F2
      92B44CFF95B42FF772AC74D2E7FD28453B491A2F1257DBFC48CAF0B8691C5EF3
      9D519F83F68A9B8081C00478551E97E6ED36BE0AC202B57FCE09866FE8DFA3B7
      FCA73809BDB3B97275D3798696879FDFFDF2AC29F1B1AF121E635CCD55CCA36F
      B0FAC735A490A7D31C7C4E0255097AAC30338C2BC5183589E6D85FA9A376F741
      1C911B2C35C5520DCE05DAA87ECA7FF92DE34C267602CCA7F728CCFB2A7C7757
      4696FDECAFB0DC370A40815F6DC1DB5B061885210B891BAE64AC45A82E524C50
      C7B07644884D22913BC397FAE580C4116322E7A63EE4B3D9245F2AE1F56A71B1
      9909B0562520A58900158EAA191A906883F53F5D5C94DB13B81BA8E5EC58A079
      4E5704110A70439DF1AC2106FBBFEF6B36936D5B1AB902CCDE037D9D668251DE
      80FA5F1FF0114A404A5C6498E8FEFD5B757AEE959B8EDDB21531C9C4F17BCE87
      67D3D1874C4DFFE75EE605E3FAC1F3DE10DC35EA3E818369557F777945240AB2
      8FF86E059E0ED3CEF05EC6C6F79759BBDBEB74FADDE103A4F94400B7FB29C606
      71869673E41F4F61F03B06D60A8BAFEECDC30F122EE50F9C7F1A8CFACE73947C
      B857DC810E00F958A7D1B34C348C001687D95F8ACED835E1AAEA2B1CD20A4FC5
      178052E4A2742CD074A917C330B85A1F80FC17A6550FA8FC857DF7C893E67967
      587D483322D21CA84CDD4B987BC951BB556E6FD13A27B44E8124B5DCCDC83873
      B2BF4DA501F094624EAD9390E22917F362880309D51FCF5F3F1F3BC8D139CFDD
      F9CB45E6D33FEDC4907A51E49F06E31ED103E4C80BBF4CC3854AAEA415435077
      4C6D1833428E2EC1F568B55B31C49C47C6A729FC0A2A734F7461F2AF0CA044DE
      18106E31E50BED2D3B29ABF75D27CD5B86D1309C3AD94D9C87CCBD981B9BF2D6
      974EED8837B8737C122D835C0C78C72C8E00A96E513642745C1BC80E69E576E9
      2441FDA741B6B0A3E46B470628922B7D3B8D15803EF212DF2062C9C8DB8CA5A4
      4B2AB476AB844EC88FFE340EBDAAC6C4F6961F47058BF80B488B0B9DD92EFADA
      51620C99617796C73109D66BE0A2A48BEB8B62A2D4B3B4AC2B6ABDF793F28AF1
      D2B4B6CB38097E45C83484AE88C31003475DC459535B8A328DB32C9ECDE2542A
      D96FEBB6EE499BD60D2B17FD9924C666A6C2D42997EB795A542557E4B871B898
      4588B5202C1CFB95AD44A2D522AADD5198407D36D01F1506BF6A334DB7B1347B
      553A32EBB5B0EDAD9DDC43E772FC54303B9EE75581B67E10115C8117B29ACC0D
      12773103A491CB402176669B6959363DBD2681F047218B549FBE60818E1FEE23
      53A8956986B90E12D2F6A1D328A2D40D6E51ABF81EDC186853313B795BB0A130
      6C30DCDD23FF655D421DD5092C90DAD35B122BD73A84F6007D8FC9E75FA01DBD
      645DC8A2D58D12E8E496F82BA9345F83E35AD354BD684D55D701DC7470ADEBC7
      6EF753837CAE71E19721D81D1A09E439960A02A24A0EAC826272AF4A330F4938
      DBAB9480709A718A3F9E577CB3D7E37A51F2013A26DA77A68B2064322E526D7A
      E8C9828F01848706FB550CE19A2CF841D63149108332589C2662A219641A5DC7
      C078E8D1D21F952B33C3B5982F1CEC90E65F4E341B8841999F285013A4F8E493
      3F0ABD221ED185B4A35B6A4434088910F52590C8DBB9992899776F9BCBAF7344
      AE1CB75E1ADD04B625ADF896D6CC72A63A644047865DAA998CFFA761BBCD81C7
      B9D191CA89C823327EB49ACF9D6B33C5532694D66B750F9B087987A829D5884B
      D0A0B90A67044860349A8B16511684A6C3C536FCF12C18CE65D03FEB459D8768
      F3F3EBB7FD5F9CD76FF64E7062BE3B7EFB0A32E62689EBBCC0CA1C53A6C483A6
      21973D44F78D99103C6D5898CC3DD62E642420C33AF7F01ECF8711F6AB17891F
      3E61DC162BE811FBAB554F3B9CB02935B9EE369DC69B18FEEB5E18368A1398D7
      0F58248DD2D44AC4492BBE6556430DF80059F798854A7465A4629E3A94C37F70
      85582988B9BB0C443953B7A4FA222781BDC983DA7751F7330D5554B358D04344
      E26A136068E53C44CB65EC919A391D0FD841FB364E7D49AB77179929B4111061
      0108633CD2BC4F5EB995433FA816CA6712DC9A0EFFE859F68720DC299D9378E6
      ECBD5FD6E2372500829AADF3811370FE76BF70A696C5295DF853108DEAB5CE87
      05A2303D1D86C66BB258597D98B0E74DE065970CAA594C6DCB964092F26C2139
      16895666F6C84DC577E2DB33221E1E5733C9F23041BF3F3A3F394C9D1D639DBC
      23BF3CF848BFE531C8002775A4C3D83994CCE12E5B89A73FBE734245AE501E5E
      330DA331D17AF68721CE7E3C9B436D9E595099FC6C99A962A5193676EACBBEB0
      E34F393BD68B180F91E2152D368E2B533472BE078223DD80D6799B3AFB6A6EF3
      92EC5A3848CBBDA0B3142F1211C862E4B88B3423914D049DD53064F800ED2C24
      7090A60B1993E17C3C58CCE6B2F0641171D8072109419061C42423C0F201DE12
      CEAE17491ECE6460AC38BDBD44415D4E57F9608EB72697057164904A1193006E
      0E7912E96D65C3868835632633F3FEEA45B8877969B9E4C1145EF3B02CE41C9C
      B922E62AAAC7025F465C8461013D2F28A971E8D58D9B1E0C14EE878174DE6079
      6F7F008E6E56A0F59F48BCF52C8FB7326FE592DC9070AA2F6D8A88E7642AC6EC
      6268986FD3BE805AB0C7FB9A56285EAF0D95EDAC1EAB59DDF79BE95BDFA7B38D
      6A4152BBE93EDD8E432E6492C8648584812B382CCE810589BD4BEF94C369F45B
      3E3775A4DB1D722C2281A393A9EFA0C4B50A59FC5D56169B0C10CD0A3A88F21B
      5E0612004B6F215553C18BBB5800960644ED742FE59946DBD78B980F4A955265
      9E96EAB19D7FC1CF06D43A8A25F24216317195CCDE3060DBA8D1C0B0B46B54E5
      D1873299A366E6CC8321294EB737197C887F40306A1F9852A0D5C972D25DFA24
      E58055AC4529D52AECBC0BD94D93F30BD0A3FCFCF236DCC60BC1D12B4D23B359
      7F3EE1BD56AF35FCD39FFE54B334CDA7C2AC8C7CF846DFB0CF7F8F3BC271E892
      01203AB0F43DC4044D2612B7E0D248ED679C7D2C0135E698868D83189606DF97
      87C398C408685E793D17DA6BC8360219B4C861DEF37EAC9D153023E38B44CDA4
      73E48FB27F676787B9FD96D78DC84E19E1E9BC371938A0C72471E81C457EEC74
      96C2E2CCDBA093BDB6DFAF1781EE214F65D28A107A6F27161473D36C00AC5EA4
      789857245CE5B856B4C6BE73A06E508B93782D9DCE4C096BEAF4A57422871F47
      D046BCE97F2CD043C377F8A350E5320EF3A990A632920B43AFB4E995912AB012
      883B0E8B9B25A12DA45CAD0B80AAE252B9AA2173DC6169C24B4D88FAA0376ED1
      6C39F83023A33898230AC1AD03A6B1CFE2F58AFBC9E574E9376AB167745C18A6
      2D9460E02D1FEB74FE6D7D68A6988D1C4378D7866BD8C9B6CEF31F63FB8BB9D1
      5C2C6DAB88574E49B0E42DD379097E054445ED88708FAD5FDD017DEEEC932071
      FE221107D091D3ACDFCB3CC07B943AD3C9C687396FB03428D0A4A57878030B35
      33401C77977DFA635509FC988F9798C570CF49606B463235089325B4FA1C46DE
      30627936C14A0407E94F3374F886210538585FF1656DB3D91F85C42CBE9F9BE2
      42B68FC42A7878986C69947CF1359E5984E243C3AEB9635000ECDB3BE7FB6087
      4697C446BDA8FA6085B9A01C8303CBB0EFCD7B25643190B1A29AB1383E05F155
      69C08CA952E311037F0C6AE6E6C652D578C14662D62E4F0260E0109F9BF9EAA6
      713ED1B8502A4A68E627AC1CCC309B6FE6CD4A3F34179B65F96471A032182AD5
      8B2EFF34EC7450BCC3C3409E100306FA048E0B1BFBE407CD2587544C5D9001EC
      B52346D7B43F5B1DC7DD5D1932CA8767C7B4EB734604932E273047CC95A84980
      3863CD72CC9F28D44D547A29ADCDCA754DFA45716763604A3738D0C5ED16723A
      9A12EA679B8EAED4520F3E5788590B7CF554B343F851BB0B1EAB8EE25F8C38C9
      C72C120755B51630D3C5441E20A0F2D751B6B98AAD697EB1CC34EE2B59D51F65
      8B1A3F1F683DFF252FF3DC796BEA3CFF1BD13BC1B4D86D3CDA9C8672D0308EAF
      24176CA3B69CF946FB0CD87FAACD2823631667C0BAC9445B18B7D462DE217A99
      D4110964D84117E3BB8A979BF21A13D3883D3D07FF66898AC2F2E21F4066FAF2
      105AEDCF01A1D51F7F1A428B3EBF0FD2E64A27089301604BB668BDC1B44CC41B
      FD06B4491256E9B5BAADEEBFAD0907AF0B42D2688390B42A060491D9CB9B7530
      5324F69028E0AAA28F6787D64E68AD09333D6961568DEE9F1FECE5EDDC358BB5
      9A95B8319923D2E48775F0DC0CE023BEED359DD76FDE8BEB5DDAAF7A2DD20CB2
      27A1D56AD7EBCD3F0EFB4E19CBB026AF7D2AAEF1226283F75A25013B05E24862
      4D127CA8D9AA8A416AB57C7D98BD16B0EAB3BD79F7FE37376FD4BDEF6DBA4E5C
      52DCF7ABEC4EBFFFDB75367FB9AAD20EC2EB071055F936F7EBEE2F92C7D9F3BC
      2268197001137751B9763CCBE75392BF63D72A2EE63572518767EFF24080605D
      65DABD8C02975D6403ECCC85318767C7EB62027C8A2DD7D392FC22DC28EDB6DF
      A1DD1661ABA337AFDF3ADFA13C6C4DB6A96A2044FB74749C79D58E8034B0E5FF
      AE69BC49B444CC9DFD7D4675AA5B5C17AF8DC4539C20C861721FEB204936F27F
      3594855245EC97959992ED16AB890B3B0F8EF79BCE5BEEA345B0B5F4C9E1D9C9
      9AB0E5467E8AFC3C3F3C1BBC60216ADDE07787A73FACC926555702BD17E4FFFD
      E2BCD97B7F628447BD967018A518C9A2ECB808813C409732E2B9696ED2D7D47F
      175473120309C25F378A3375FA824BCA2AD70F617C8B070D11886F5F2F126C6F
      1D980137DE6DA466814B16B3F457F8810EBDD4EA3C69A7B6933D9533D309301B
      E62A732F5BCE4F0855A334337B0E100238B02A943EDAA59B05BEF3AB4E62EEDD
      E5840E108E53E057C662E58612E9E789A14095CF0BFC4C76C03C56722F2DCC07
      455E274C0516003905207405A814C5A5DC6C1893896C7CCED2CC9447E8823A74
      F3F2F4DA19B916BEA93C34B7C5D4DE38D2EB6278575CD6ABB33D7AA473DD6E0D
      EAF5E2F0BFBF4087566986CE439588CF53FACE17AA3EDCDE2A8DE866F69A2B69
      72B3807AD2ED70A59D6910019426F0E838C00734858BB63199DBD9B86E11C948
      F9724B10D62F557AA94D0FA60ADD45C8FA546A874F0E0692883D7F1D63C64418
      4C93F2E8E84D8EE9435D734C9D4D8E69D9B21D6F724C774CD4B3B34332B32B5E
      4DD6F83E5B00685C091753275DCC513DE0ECC09F327ED76E132611F0D74B8E33
      8C24EB9711135412E4B4E2CF5B52FEE796EBBA5FB08A7C4D8E5B75176BF082B6
      FF17A7F19D8E5057C1EDD06FA77FD76E96366CDA279ED7AFDEA270BCCC22F6B2
      105065F31ABA2806B8EF6DDF2CA57E58236757B7493073DE9F721AF435104616
      591FFF36E2E32599F391E9C687DFFFFE143AACA53FF2684C5A7A65A3BDF86613
      5F35C5605248F39CCCFFC17582DF3FF7E33EFD945B5E356389ED2D9FCB29C946
      79098F6AFCDC23D7937CA44BFD5179DA0D66641D1AA41F41F884B3324FE2EBC0
      9366CCC62B8467CD6422902C4E30DAD44C276D88B7D6946A7173236E7A9EEA52
      4B274F15A917E5B86C7E697C469E6009220F75B611BCC75910D26B9373973625
      8AF884BE666E1921977561C58D5494C38C2F1E1C4761CDFAE71BA73A9589450B
      375B24BA61C2ABA5F59ADE03F93DD7CBCF55A4EDD4D15920659E45204045B7F5
      0B96342C5894CD35DE4F8853DBAFEA39AF6EB96FE0463A2FAE49D1867953459E
      B034B530ECC401E4B86E644155B6B303E1FDDF6452EC9EA8F909063A25692BFB
      98F1A92A3EFCF7854EB3732039F387C409806041092FD7C2F3F01E81AFE168A3
      AD8314C8281C4A20BB850B2E0086D32357D58B62C10CE2380F6449A22DA8A179
      726D40AFA68B0B29B5E1CD86E89B9972E99A2D282AD579B036C863DC7BEF8E38
      1A534C27FC7B1A474D270A7CD21333048F0315D28F61EC4970661344A97B1065
      1342590EA14C362194FB4228BF5827E70C53BA48C11F9A7A50E3E1AC09173D6D
      456787B575398DD32CAEA6D337DB5015F9A15E6BFD84292193328061216E5BED
      6053FEC8D6C5C638A8B971D069F536E6C19279D0BD9FA736E6C11FCB3CB857B9
      D66C113245DBE6AF909E427F651AAA8C6B612C6681448EF3A9DB6E3C9B550739
      24551572F9AC8D33D78B448DB30C21AD2CAE1CEBABD7FA1E8FC16C74737D75F3
      C6755FD1CDF79769FFAFD6CD7F64D7892BA8F3047859D15D84F10D4FCED5280B
      ABD9AAF2CCFE6B2EDDCD07BFC856C9A405AD3837404BAFE51AB7B7CCDEE14FB3
      7FEA3A0EBCD4B990420DC6254934B9C35823F6D45BCC4939A384C3A46B317855
      72BF6993DD67123EC6083575B718BE8170360F45646C3A9ECE20F3E40B4C6124
      6236EAB08EEAF0D16BB7B79634E6A65E70456376371AF361F9BBC7983DEF5E1D
      EED512BDF20F93807D7FB27780D828AB013D9B67B70E890C755BB3657C348A0E
      2BB10AFCD5D95E4DE7CADBD5109719263378D5C070D1C03E5340C712E42C3AB7
      5EEAAAB98636AFD73A4912580305A57D6F7BF2AF8DBD50477B61C918686F8C81
      6563A0B73106EE74FB57BC6E0EA4BF1A27EDA44B7446323CB90528FE552DDF3F
      95493E504180A3E03E8C83A3BDE33AAEC50F6395D9F2C00458EFB58BCF28EF5A
      717DE849EC313248EAF85AA1B4B65EEBF01275F17FBD249EB309D030D855DC52
      B88A21DE580A4305B469D78187E1270C795CAF6563E6A469A9642067CE1A1593
      2DEBB598A22AA1C6BDFCDB5BC5321C686DD3FE813C2B2A984C2E4F2E78D9C874
      9AB5E60A4C69825F79F810BD280C478B9AE5FE7F73E132D9B6FF4DD6EEAEA098
      A1C3A45ED411CBAE2A00729AC66EC0FDF2B6F31DB4BB674EE5571804F3E7161A
      7768A7BE4CE75EF39B3523D2B2FA7FC065F971EF8BAD8A75CC375B5874FDE516
      46F2434769FDA42EF7F89209E3BC4D2E5414FCAA1367A7D3E4A4427717C904C6
      F1E631A59119A42E981CB399BA531FF18D464D3D9FC5E6455FFEB3F9012AE05F
      9FB8D5F5DA389FB1D8BFD1617ACE23EB30D9024366C3C0CDBED4B932CA9DB6D5
      CC19A8D72E45DF0EF5E4EDCB2FB425C571E79EC88CD38CF1229B2F3233738DFD
      03D85E26B868D39E18163B5BB897867905698044A79A6192DDB761E50611AAD5
      FAF08164602E023F7C208333FDF0C1F6D57BCE4180890819ADA7F187962A457E
      481C2172EE2E03CF841D324DFBC4E4506E165B4CA8BA2D108B9361B908DF87C4
      C848B6F3C4B7F3D3C3435333483B9DE7DD6D1ADDD12C7E2A26A8229D2364D571
      B4C89D1A86264871A790F0F9BF1A4446FA2187A1A85D1EC42CF627ADE671F462
      2F99C5C98BBDD96C119932DF39525AE9A5D659CDD83DAF4579F5F6E0FC05FDD1
      6513BC185CC6E9C77C4281608798C1E9376CDD79CE62CE62DA6A7A0C348AC345
      0D514584124736737CF0F6D5FF732E891CB4CC8AB7A899F561567C7ACF7C324F
      63065331BBB2DCB5BEC9FBD535EFD76EF53675B32B89BFFE26F177C73649D385
      768693971C679D9165EE0AC0A631F456403F19D6C1472EC00C194585A1A366B8
      0A97E7189FC00DB770FD35539442924E9F68622A3003B20E3F325885997B2623
      CD8C147D0B6878528BB37AAEF3532CB96C3F7481EE64C0509C24CEC48D23260D
      612324B362ACDE4EC9E3434E8599A9C04C814BB55B2F625DC6D995BE4DCB3843
      050690411CDAF9366EEB210EE81772F09FB3AD1724B3264A90E7EA5B856CFFF2
      A5624ABC874008FE4251F6E75FF6C5A338D215DFFCB38795FEFC859616442425
      B29AC987EDADCB38F49CB3CBC0CF0CF8759A2929D310930C11B2AB60CE436063
      9E476AC4065D478EF20E1CAB450A88EA345BB8069646BE4A8631BD398F594383
      9E407CEBF42A43AA9EFCD1FAD38AC308A0C9DB1F3E296219A11D48640130EB89
      9C7363A700B0DC93F1E94643C9E036607FD772549BFE08602CED4C2B13F5010A
      585A3206BBBA5641680B1C6A09A2292FCDC3968394DEF1963352176487991A22
      6206F16BB9ED8BB4968937A7CE0E9A62A6B78E71146A766AF6B324FCCB3E20F5
      03AC320A6F9D37A885C08B831C7484E6D35861BEF261EAD23F63D31AE4BC4753
      AF1CA07A2DB9DCC4676617D8338D20AC7147BC0599A3BE0AABD6306E6F610C12
      E61B01935D862198BE404942A0FFAC66A7C240EA49458C66CC3241156D121167
      B1F36C8F912BEFBF0CB533CFEAB5DE7285D052A15309E82D7D8928AECC08625C
      545B51B4C347E9A7DDA6F3539C90573B074AE1AB24BE4991F2DE0BB3BFBCEED5
      4C38E43B3A47FC965C544C518FE3AB994AAE8C8634957B2F459054A673A7D51A
      D8EC9ECAEFD9744026FBD945EC4C957B552F92951A397C2CCE0E5CF8E9F4F800
      20BBB1CD7A45F14DD3791647CF4ABAA35E4BBDDB84BA33D5B45A13EC6F62AC44
      EE9C7358A06EEE799EDCB0257F0A891BA0D592AD10919A24ED2FA3E9D310C365
      A49D9624C03CD4C04F36DAE5365E24396464E09B21343525C5E9DD4E78B3CC9D
      9FCEBF3F6D72D6A3C903AD9A92FC99ABF96DB248F928349DEF7476784D828407
      8FE47391896679C3DD1B757DC25DD9CE4E76A9A22B56C87F8FA31B6F5433FE31
      24934E48A6C58E214665AA5BBED90511903E9659D1C7EF8FBF73762EC278AA42
      FE887EF1A6E59C5F6A1EFCF92C0312B726DA0A9CF7FE0FC8356718AA642AAC4D
      7B37EE95F19724202365AD0C604A5F2BB576D788E27D4BF1BF9D7E7740EB9DDA
      0454EC9C1EBE260EE5619B62CDD771E41A4A285061C035748994D3BF3B3EE896
      964A7BF76E6FFF07924E1C5B445D72DDD6882A8A57EFCE0FAA9F142386605598
      2E8269ECDDA29A28939A0BA051D12DDF3851FDF89AE971AAE9775C1FB37F787C
      CC8797ED8A0B690F51923EE1B4AB5FC38123A263FA2FCC68475327C42B2C5B53
      6F5F9F9D97F48FB3C3CED6B3B3808BBC8C41FACCBAF4B0B97C7F779379AE7FE6
      79833FB192791E6C32CF77029CE9DCCCBD33F3CF517F4E0273AAFDAAA1C08444
      683A5B13567B5AD6B5377C8951DA69467EB3437641E287666609D9D617894E53
      EEAA73259F8AB05418C3579DDB6866BD56BDBD65D73D7AE98823260017B92544
      8A1F13C6330C2583FF963A47E72768D1E59836990A4BF850910696B04B1F47B5
      2B0497BE571494B23A1CA3ED3061EB2FFDC702F576D384984267772962CA112E
      028E5B800E956B50E5011684990773A4E4C9B574CBF9F9FFBC0BB2B32C9EFF52
      2F3A6E6F7124EB601AEE73116A1C2D4F4A927A0D3A49EA02A1623545314B8803
      A6AF4185F096ED7276A16233065986B7D44CA4B09794CFA131BDE1644DA16E33
      8F6299214F58A12753826B17D700888C680C9C12AB2E6ED135E06698DAE15E4A
      5A35BB34592FF61F52DB8330108F1C6E06907BF32F7096CC30852416EA469907
      82E14DE7C7232EC34AE2702532BE97A690303315D1E9489AF6DF531B05E7A355
      BB30B809E38882F9DBFEFF77EAECE8C896B0FD8AC4719E1CFDB7DD5CF75416A2
      ECAE23325163AABC3B393AAB25CC571EE09D71EC319EA631776CA0213C2CD911
      2F9D93B707AF9AF4E7D941D379FDDD777BFCE719FE3C3FABE59A255EE239C7FB
      E76F96FC69B4DD69036ECAEAEEC7B31FDEC18226D3B89E4737D757A6DB8F33BC
      B4D3D7DA5161A090D2E6553BA4E621D020E0EBB9523103B175554D3893AB8EE7
      B790F21C36B407B95E14C85314CF0EC4737EE6DC60E69673A9B9A9A864AB3C7B
      DEEDF447FD716FD81FB7DAF8DF33983653CD83D559A2118B20C866BAB5E44608
      A1937BF5B7FDE39F0AD1502F22AD24B41A88AE7DF820337D9D298072D286ADB7
      5ECD63D53C8565963ED3C90552DAB0D36CD249AACB71F279884CFDD6D537E2BC
      7AB18A5736F0CBE29F189FD122EB07B963082122F0DD77A7A7A58C08FD912CE6
      F95057955D223A650A7552755D3B7F7F69B125706B2BC84FBE3B7CCD1C0DCB52
      84D8DF8EDFEED7596EE5CB6DFC182D52FADB1657FCEDECF0A041323AA95FD8A6
      E88796A5499DC4F256563ED46FDEEDFF67F39ED47C6B93FDA87FF66303B8B992
      FD186EB21FAB22C0606E27FAFAC51BE28F13CDB3DD118932653B8B88C442CBF9
      918C3AE5C3A42563976D5E66B858A6719B2E10E492157AF192A02443BE35F755
      A4C4990630342F3DD1FF580409003AA5CB8E91943CEE3B2795E1D56C61B2C58A
      3609C5530FE1246117314ACCBFCDC1259EA59523522479026946E47A03B04CBD
      88C471C6BD122FA3B89BA495968A5DA95AAFD99A1AFF6F319BF3B0AD38B763C5
      922375619A46E7F17C3167DC8C9A2DEE3042EEE085C92170D73019E5D21C6B1A
      4A6AB6A2E3F8428E100A50AE75729304F4D2118A747A27AF6AB6989F3F1E10F3
      61A65FA6423411E9B9A98B4F10FC46B11542269749BCB8B8245D835FBCB31967
      3A85970A91B6EAF2078D5869A666F396739439330EDF4C351AD9FC45881B6648
      663A7488053C87ADE6BAD1D4E0A6D0EFAE52AB874B08A5D2058F690D08481663
      615BCE3B1395A1FFF67FE0261D4EE6728EB155B7A8DD7D255F9FA83196242C63
      549F9F088E00F24DB7066577F7115767F2657C9DDFEEDD18D2F71F766DF8D34F
      18A25FCC9DF9BD9ECC994D1DBE5C138E5C17C765B4715C56A5C01B916F55AB9D
      1085E6307DCD64FE9B07DACB7682087DB9D2677BB10815BC9439B4273EDEADE1
      2ACB25023BE7C76A4A76B8876046D339DF475FE431ADE455FCB16E6B3B333910
      535DA85CA08692EDC301560BE721750EDC89FE97D7ACA0E17F888F4D2A8DBC36
      4DFF367A1E9D94BBB553DBA726619EDE4699FAE85C92280B21CE106E48F26650
      E3706D94F2DA28654CC54C370A7959218F370A79F57CBF57492083CE835F010B
      9219C40CE4D1786647CDE4F6DB0523894986FB0FB09E23C91375BA8326FD31C4
      1F13FC317676F0C78D4AABA78D1A2856E5EE5650A7B1F1A1D6475C9F04A9BB91
      D6CBD27AB291D677E2DD806C99C55EE007C0DF6030DDD95C65C1340883EC56AC
      D3694C7F1C68226AE0FCED90C34A7F3BEC59FCE914F8D369BC48007B8272E89A
      0944C98BBC52A97E8395E4D1B3347616512A014A997BCAB6BB819174888D162E
      866A99DC58DD96FDEA36D37B589613EAE88236983CC904E141AE601BF69D6990
      A59BFC7FFDF3FFDDC926FFBFA4077AF733D5FF6A3DC05C43A20DE2EF3A308D2C
      B33898A988F600888E8CB8FBC10F3D78E6FFF5E1CFF81185B18FF1F76F7B9FED
      2DE7FBFF7877787A7CF4E607A7719965F3F4E58B17F90BB53C7D1DA80888862D
      52582FE8EF17E73A1DE0DD9E1FD13AD2E7FDE168D21D8D27C3C65D3CCAFB5FB1
      D3EB0E3BE3114EEC9F3FA0428C974CAFD26E7B6D77A2D568E24FA6CAD59DCED8
      1D77DB6DA5DAEDFE544DDAD376B72DFFEBC95FFA91EB410BFC6F386EB7477DF3
      1FFD7B44DFEFD1555D5FFE1B7AF41FFE9E989F69ED434DD774E451F8AF4BFF1E
      D2F78703FAFED05C6BAEC37DF133F136FFCCD7F6CC3D3DF38CF2E7F4EF81BD17
      DE85FEDEDEC2BFF8091373157DB33F29DD49CBD5F87D8F3EA7B3DCEED1727A74
      4DAF6B7E1E9B7F0F65E5A3C9603CEEF8FDDEB4E38DFCFE58F95DA2D1C073FBE3
      4177343474249A0DD4140BFD9FFF010F865E92868FB29C8B13B8083FB87EF737
      B3DFEF62397AD90F2939871EBF177E8280D11F498170BAFD76D41E7FF0E33833
      3FBA71987EC40F3AF2A24B9D68FE36BE025900D1C87713C1E6861F523F8BA67F
      7FE2C95B1325F0C49A6B34550711E0AC954565F0B41B4342ED9C9A1EC3BDD393
      BDA6F3E6FDD911DA6C0EBA4D80DABCAD5B80D8ACF8F0BA7A2976720B3314C17F
      069B742ED03387D4F6D1811482A20A270C7EC515D281584B92BC7EA854999191
      6C73818C7FCB87C6D66BA5A61DBDDD775ED272D1531A032910604BE473009B80
      E143D399B3831F2E2EE334DBE5228ABCE2A176912859F3784C4B3E9069479C00
      804F09586167AE30A8280E17337234830CB0BCE47BD1AA30D89747FC541F7994
      E65DC6CE8EB7E06245E59085ED494717593D0CDB395D5CEC020C8BAE0F301D09
      F12D096EC9E0418562EB9A9139C73AE84C88D2167BEF924B4094E7E1E010F5D3
      D4F9DBF1E971DEB76D06D602FA5ACA3CA54C02C489532DD7F28C62527C642F26
      8C94110517914506B30D2247E72735239825579BC8C519C7120C2B37B1333C2B
      B77157B76683884474E0194880B4E5EC8569DC64BBBBB1FA9006622A802412D1
      5633F2BD2D557899E1884873829F18308E147986166F3E4F522C3CD5A49AE06B
      D76CA94682758B73B5AFE6E443E68327B835E3294C22F0C98CBAC12D8525B40D
      2F40540AE62671CF8136D500FC109E85C2A711E55D29C6BD024D18CCBA09C9AF
      4D487E53D6F4403CA6B389C77CAA5A04E59A6C0DE6A62E47E531F6D383053357
      2959F94E03131D1BCE95BE25ABA56EB6202A7F4AA0D9762C400D57B1A4BA1F0B
      A06FC4EFA680E59B8ADEEE46F4DE4D89CEE6EC58C72467C390ED54DB87A11D78
      E31F89D05C86498E3AECD8442E0C32E0C35D6B9E461C13DD6E0D3CD4545F0651
      DD24B2F182684BC90BB268DB06E242A6B0320420DAE2809C57B3D5E54E71B7C3
      5E9E190A6700DB62DF39259704553E322799C1E8393C40B6F7693E742E9FF2C3
      51C950DD4AF2541A24E1D888D3CC1F57855589C8C77EC3C34FF9058A09777FDB
      3F3EB54EF5F206180CA2DA6E41FB45A783285041589C398B32241399F27653E9
      C52CEF4218C7578BB9E32D3812CACDA79E6157462C04921E0F685A44890E831A
      DA153622312222BD92C9DFA64CF6473B281C519703D304979326C52895FA2DB5
      7A009C6802E75B420E4EC320394B5EA041AC125A9BB27EB185226C0709B5F7BE
      0C38B20453CAF082242638482E852A2DE74C82FEE08A19490752452AB42DB92C
      3D3CB46C4BAD4B786BCF0EA4DCAD4386425AD313D2861879CF7911E0D71A6A89
      3C46E404FF3A3C3B618C9A96F34AB957171CDD2D66CC86C12CC82AC795253233
      5BB897F83B878435E4E446D49A113267BBF68815BF245A94F38F854E33AB7E8C
      56A4B5244AA06F8D38F21375014824015821553845522A024830E9A74F73651D
      5B312DAD8644AB43CE4F2DC12218DC00A0050BFE271F5624E822753DE351252D
      F24BE838FE8812326436114B776E2A33601E5545A040FB3E8A93AFE940E7271B
      190C89B50A0C5FCD085CB023ECD0B7C60C078585212DC3A50ED1FEDFF9577B06
      970FBD9D36AF53341EB79C03399CC821362D1B22DF838651446EB557504F6866
      62B1400EAA19F92CF190CA781F074489F3DBB936F3C7C8D045526C3ED7E4E2B5
      9C132145CA67F409880FE563BB09737CF330C70F11E40BEFCA26D8B11CECE86D
      821D0F79F93D12103F7201C59D8CA7584F288436FAAC69C5A235AF489D936315
      3334FE4B76C0F6D1A6E88B339D0751A6160F922C010CE8CA24C79ECF4DE557C1
      20D1BA55EE144A8A9D1186C4CC0D73534D2EC8DF060754919D781191A2313362
      C9187F96E5840001F9F2964DD37BB14E99842987972EF5F27D6D25BE3132F85F
      445D4906C6884B11A14DBFD24652AF8DA4DEB4E8DC15D1FD8D887E28F80303B8
      019775313727BD219528D3F823C960F7324E24FC388D334CD5C5242F92C03593
      A5EA3A0E00A65BBDB4863D6D0CCB7001CC8B42416BEC9396891D46BCF1F47471
      8108EF632D8A9B8E96CF231BBF6C47CB78D3D1B22C3637F3BCEE08869F607E65
      A8E43463858D1D14203797A9C80CA9D72A628C3F92963C6D5724ABB57A139D92
      A36CD30AF4137DA642E78DFEB8E088C359A6D58C632CE9656CE68791717BC0F6
      9C4AAF1C35C5EC487E0D63A4914C5ECCEA3922E09D99C7BBF3BEB270E6026D1B
      ACDECDE76BC26590929619194136AC28DE012865316D0E12751147D338899C83
      E3FD5A12AD013C55E3143847078DFBEAD84D2CBF5EEB3BC7BA4CED618E28796F
      1922AFD58E37AAD722F74C1F346485E472F3842CE3139A84F13F3BE376FBB25E
      4BE3A4B7E6842166388741E5434D8CECC621C70622CF8EA0B795FAA4CCB899D8
      A26FD68B28DB5B8DE571B03968AAF4C6476E0073523C751C5DD21BC77B6F0E64
      6E39D3837E38CA4FC30E19A3393E97659CDD96F3364283A5259D80EE32B0B098
      394DC7256D1ECF825F797FEA4ACD233B99FDDE6160B0EB8061656BE5369679FD
      2DF3D1C6325FB6CC3758F30F19463F9AFA1E2F5061CC250DD9EDDC4C4794193B
      9DD6784DB8A9B2F63896864BFDC2D3A6F7523B8BCC1F9B3E4D84741315A561D1
      CC6ADAD29A828477CB9A6336139C79D20B28FE3ECB123E61441853070E847693
      ABCC6220259A1155F5229781DA27452866D48B3C2F995E05F39428E27964399A
      A1521BFDF007D00FC38D7E58D60F1B48DF87F4C3ABB707E790906430B2A7E239
      3B59122FA6A8A8E6DCDA81BA892E16AA6AA4D86BE9B4A68197D76644776535C4
      25A2A77BFB87A6554850ACA6C19C27957228C264188F38EE55408025CAD5CE6A
      6DA18C22367134B2DCF326FB7B6E294DDC45E59384D0728CF93A517FCF9411F3
      B86A5A0E7E28352931822FD7FB95806BC9E55BF56B76378AABFE8A6BB0515CCB
      8A6B037DFB90B43E9ACD31009E4B60539D3947EF0ECEA0C8001D2092784D58E9
      69CB129CC483C3B3F3BCBA77EF78FF7B67070E5BE3400B2022CB4364A0494D37
      6AA66DF339C06C7A14234051A6B48012A3F7762D643B5DD3858C10F021FAF3AD
      0CCD84D2B5FA1351E398C18B50C543EEAC234046F5224BB1FF561B320213F73D
      450EE600DB9557A6F3217BF9AC28F994A86B4B56A153BD0894F38D1C9129260C
      9558E044E606BFE398C68E1D184FA463C5D2DFE5AA30D4BDE520199833161589
      21E752417AACC4496B429C9F79308F0DF6CC8294AB0C7984707D27053F884875
      F6EEF0D8A9E398DC770C22F07CCA00B045B83EBD253BBEF23198B12068ECCDE7
      C4CC0261D010A4A61DAE542A1AFB970C64627EE792946316D74C61340CD68D2C
      B266EFBE4792FCF6578D7973F2FE483A25898E32DA3C93A84F3F1F6A60F7FE45
      9997EDDEF7A25D272E99BCF71BBB9D7EFFB75BBBFCE5AAE66E105E87F72395F0
      6DEEB77ABF0838EAD9D56D12CC9CB929C708E3CF9754FF1DBB54F1E5DF4EC3E0
      1AC1EFD34584AE5C1113EF9218C5330916F344B4595AFBEF27E92ADAECCB172F
      6E6E6E5A110A7D66B19732E4676C5EFD057EF3A2DF190F7BEB082E3BEADE0F2E
      5B06961D8D8AFF1814561BD0577CC780BFE6E0B37D03EF7A1F782CFEA3E70D5D
      030F6B01680D2CEC1288ADBD8F6F60623B009765605800C6F6EA000CBBCC1B95
      15E3A799680317FB58B8A34E818E2F84877D22851468D156D24F93C64EEC6332
      2C1A135983B3BB01FFA1F11679C2067C5831BF5E01A90225282F12ADDC4B9860
      CDC231A1B76B3A67FA1F0C3DDA744C129373944D47676EAB6676D9EB458861B3
      7358A357801C94E876E2D84C02C72ECE3771D9FAC765FB9BB8ECB2B8DA0CB979
      ACE0049D8A4E55389E04FDF82435BC10EE30FBFAA644BC957DE48272863F9259
      CBB1F3EAEDD919E39573D0D07ABB6BC2A2BF25E948722A92CC5E69AA32CEE0BF
      FF78765ECB75ED1F1E1F3B370AE94996C200695DCC392039D580A635E5B0E8E1
      CCC7BDD56BA5454092C3D6B398FB74437DA1DC5BE7F4CDDE89C9D22276FB57C3
      C00637D27CF2E6DDFE7F4A549BFE3CC19F3F1DEEBD6B72C49F0C87A3B39A15E3
      E714B1E347EF5F601EB665222C076E1751AA7C2D31FDF96D01F66283580C290E
      0525F2A16626D3CFAFDFF67E71DEC49CA13285CD07477BC70E0072E6358BD2D2
      6EE723E1458C25AB83E1F9BC27EAC28BC31068E7745FC74D548A06C20B483B69
      00E206210E841AC3FBE078BF66C400868FD328500DC92B20F313932BB95FC9BA
      0C583459589C8FF1E3106A2FF04DCF14BC0D381435536479F939B0F4C822BA2D
      143931C0C7615FC2DBB39A6DE8F77158F91C78CEFEF9E9313B416CBB88536410
      8A30FB0FC7C02FDCA58D4B547F97A8B77189965CA2FE66DEDB43B6B0B170A4DC
      DE026E4224488AA19C1122EE9AE1EAF4E5262794F3D5FAE4848E213DC5AE4D9B
      CE11B45AD3399B6BB26ED661BB2AAE82DEFEE5F2CB379DEFB5E21865463FBF56
      EEE76D83FBF24B3A55AE7EE97CAF8284DEFFF056D7715BF665E6AD4EEAF4D2A7
      5ABA6CEAF4CEE883718EE935EBF4D23FD8C8411CBD74F692599C9033ADD51CC9
      83BDD92C6EE258AF9549522763E40BA593D8008087FC821DFF9F38B0A913D427
      C23BF8F1E0543C3E816F9B6A0C43536C1F931990A6EA425C07419F26B5A3AE4F
      04CF744D36FAB78586EF8409D2D6C6DA59436B677BEBD5BB8373E2C834EF6DB9
      250EB52D979E04AC25AAC3D02B3CA68E7CFD2823B6AD1AFA77BCC0E79EFDCC81
      4DBE20A6477B475EC62D0F65371ACFFB7C11BFAF626891EF980540CE956102E5
      45E1F744344F7FFC5A61F12FBF62E42B1C65B08197E727140BE735D76D5169C6
      8C79771BF983DAADE96856F14213DCCB550F838A46571C893F08AE69F5599CAC
      4B187E63782CE516C9297AFD37677E19471A3D83376C6A984CAA04DE4D4175A9
      9F824C8B35D9CCA7269D6CFFE645BA5C2DCE8B43E698CFF18EAC7F46FA2464D5
      E69AE18F90C1B8F4AF725D98CF7130D28CA79C640BB1CE4874A3E9D2276B1C48
      33F5A2984DD1F2C221BFAAC34066CF7524037E19191E337BE807CC87393BFC77
      C974ECA0D31540F99200C9733A32A549A109C3D53525599EEB90A6042EB7AFDF
      D0136916D9FF7ECF3651F039B04D2382F279A9C2500389CBC08520537B8018D1
      0971FC2D1274B55CF4819D4FCD595793856D8A1C5032DBDC00722F89106EA461
      5A5586ECF7EAE6A4BD89B9FF8EC7A9C8EA1B38C957B0766E80748D7FC9501B22
      49A366ABB399596E7FA397953E73C0BA58E8B120E2890DE80AF38A89BE3559DE
      F696E9077A1D8450EC5066FB26AB2E7D2798779669C12C973496ECB42F5F48C9
      FB00748EEC3CB67A9E605CF9DB1FD03897097DCCB542A126A39E0BB081207C1A
      6474A85AFD911E50F1DD0DD2FA45A2664D8107BDF34E263A8257D249FD86B099
      4D2961DCD9888EA984A9D97ACE6424810951B12BB014E97AC1FD7B60B2FF0CE3
      0B2EE15BCC639EE958B739EBDB5B6256CE024CA024E3520E081F2032729E019C
      33F26C5D87947458BC8FA42889C85999E32432A4DE5B682967127C5BDC1B4787
      6FCD882CDCC24757F013F87E784CD3992F322E1989CA2525491C67B6A4440C7D
      FB21915DBB8B8CEFC6161ADD7CC73608B5E8C3A643FBF55E7ED299BB41EFAE69
      7DC2A3176F6F2D95307437250CCBCEFB6644FA5D512F5D9067D2A95A33E18D49
      E1C55032A94B23F15CAF4548F73319AB539E4AC130D0803C01336640C9C5C099
      38A9DB6CE0533DD3B32929AB799C9AA9C7A4E5104ED4A88A85F29A291EE65743
      733C0F45997A403314939D8FB3CBC0CFFE72300DF7C3C0BDAAD9C27EDE0BC35F
      9C9F925BEDBC52E9A5737119A7B0632DA0FFCE9D46DD2EBF6C7B5503D3A763D2
      49F7BEF4C35AB077AF62EB397F6EE974DEE297A9D829FC4431B88B53C78BACF8
      051BFEE2F9C87564E19FF78E8F7F715E1F9F9D339C8E8397962AE5E5844E2D97
      75787074E0281EE499E619B722E156B335E511F0724B290B1D148918AF3C2C7D
      56E0E62AC3A018986AF54C5660E7D68C10860CCFC3973693EC00E6178A05BE85
      93D242DD4B193310F3C02241865F22868C17A9E5C2F7642C2E22B9B94C367177
      0EE0967AEA5EA03F2F46DF1DBBE7A63D416362886FAFAB3E9E1444AA1BC9381E
      2C155427B1F703394547276F0F6C44DCCE5041B0E65A250CCD59CC03AFE55ADF
      1D1F7497F1D60A595EC2CB9A93994927A7864B94222B994F2C59F9F200488716
      98F81858EE071FEBB63A1BAEB159CEF80675A297C1DCF22B1F656C1F1A2FEBBB
      BAB328BEB9756EB442595C65F5B7D471167C2C9728EC25D9E52C8E934D50ABA6
      41AD72C4AA33D944AC962356DD4DC46A551C04453FE26A9929048204813897CD
      A96CE0959BDABB8D84A8BF84D88C3E5891109B71EC77A3732A0CE9DCBD79CF67
      1F6DD733955C91C440158C85E80F7CC75BCCC3C0E5E230E9CF27E171AD495860
      D01EF7F4AD09AF555CB7CFA623F7DF4B5C328CE3ABCA01AD0BD46E01B9D4D11C
      3829E629D68B0A0D404C403F084C55DAC867235DC68BD02B39456A3ED78A1BF4
      3D9DA92074AE03C81B8EC023BAC245841BA5517FA5B1193BB0A2343603E2EF88
      0D8F87E2382E923600B650762AA929C3B0FD5A2C236E2E51677119871C8F6370
      88BF2F6673831CA8B25A8257DF511F2C40B1C0B94EAEAA371519F581C252D0E3
      304281CCBB38886A86D8BFBD25A1A6330E3509D22CC285F2DBBF98DFBF036D0E
      65C9E75832EA290135AF1C9EEDE3C53726008F01D9B6CB2447F0C60DC15E399A
      0CD75DD78B5028AB5D3A3A28AA4FC801BB2D83E468D6BD374E3CD7F0D4108DE6
      0C86A32E6855F55AB11C95207ACEB32CAAC7B1CC8AE954900F4BA72ABC755C84
      2D991C6E8C91B99965356435D81E0DA0D44012B42A5CA0CA4EB9C092B891D9EC
      5A3E8B301323A45F9BB1BA75335EB7B74E78DA953491F2EAE517A766F4158C31
      E9CF32B17BCC32FB49BA695FDAB98FFA235135C0A04315366D2C8009E5D23737
      33A4EA6DCC755B83D6069767C5961B6C6CB9FBCA734854A4A94E32A7AA78BE3B
      86C4A5AF6373EFE6053702A4BE02A4B31120CB0264335CFB1E63E4D5E20262E4
      A5E387B1E2E2BE393C1836D25412A432771AF66C88369A86BFF8F5D7DB46CB39
      BF0C52EE8E4C748AD213880F34DCADDC867660AA13B981B9250270E80AD0FF58
      A8901183C9B88B17176CE3DD3AB6B9C9B8A36130C32C6B29A454AEBB48804A4B
      FF86315E799568E7EC3BD3DB4CEFAEBE21E7D4D396F34A9A11B84507434C81E3
      E04AC32C7721F0D752F17A4D846DAAF365C8DA24F4CABFD948D0FA4BD0F6BF7D
      7213BB5F7E13EF2FE47FE226D2367C7213B14D0FCBADF5DEBAC6A9161163A258
      5220D66AB51A9F3E7F932FB377BF7DB78C7AE93FBC55FCE9B7D8A8DFBB47DB5B
      408483EFCED3454C69A220E1D0A644EA3AB89092C52CD19AE38ECFFFD5796863
      CDBE3EFAD4FCFB15DEAFFC08D1009253E15096FD90748EC5FB9E6A6456A0436C
      1C541003309A11693815DD72951611BE341E1BEFE1CCC01BD01CAE41C9F324F0
      6AEEB18B6654FE172B43601A648EFCCB49E7DA959C1EEBACCA9460558D46BC54
      FB8BD0B6BA72C86546BC1CCC430E3A2C505E99D906693A30115627309FF28E15
      28497A72912D12DDE431952AA4D5DCA888EB325578A36E53C661015994493DDA
      41E1CE8E6E5DB41CE95D7FFDB6F74E70D14931DFC2C3092E18AF22A20B41D950
      CDE77CA1D91C53F75940309905351D8BE230535788A824A675388A6DDC3BD172
      7B0453B0C9B68CBA7C7BC439F108DC834361E240610525D884D592FDE9DDF3E4
      C28E9E7E46D5B577FAE6E8CD772F1FEB16F81CE7D829EA683FC10179301DFB51
      3A3B8ADB665326AB6C8E9C34DE17D3C5CD5D9E80DF22634A6603233C265DD3B4
      4D5772B05052676FC17BB948997383D4FE16F96F8EA9E513EB99DBF16D4FCF75
      E4A9550E89B4CCF9E1EB307C9E8F3E6A8BF980D227C4926C1898C3886174C25B
      222932C34F156874F0E815E9B214600228691DB7B0BB640A93544140FAB6B220
      D8A3E3D81442D94307C6E63A00D03C08ED5C5D9E0A15AA0422D0F3B8815EDD90
      7DDBE029ACA55DA1CF4D732F6D02BD1C7EEA7FF74A8E47B290B9B48B08359DCA
      19F6A74440FB68E2899FB8A164136DA8BDADDC6BB59DC3BFBD3B3C3D3A397C73
      BE77BC093D2C871E469BD0C3AA532ED2456CB4EA892538FE48FF70668A75F29D
      EAC8A609499889E33348FD19122BE2CD97CC38FA133DA7802BF748F98B6D4502
      B121FF741958C56892060B3D05E975CBE5F874B50B35424EFFC2B5C02BF318A0
      910150A2C8F6D1A62714F024269CD1D8E7C9C6C8861E323E0F49D44554C766AD
      5816E4736A2F2A097512AC505195F7D42B4F3FE70A8438CD2C943CF7ECA9CCC4
      9B665A45251B955550AA4D22314558E6063AA85CFE965FEC051E502EF8835B46
      A14875E83B3B68CE0507444E012591CE9ACEFE5981A8C69D4726E86333BE53AB
      EEB05832538FB8AB309FF3830F04A34914AEDD6583B42853736053540762AA4C
      510E6391167F1EC532AD8A08020933D36212F19BB26D5E7E5DC827D03FD5867A
      821B978A5B43861B11FB4AEBB96C3BEE9BEE2EAD0660290679080FBF0C7026CB
      8FE7A79F2F5123D16C4E4B9EFC395FFEEEBBD303F1C4B44A42CC6134CC55B3C1
      2B68DACFD769E740051E1BB5C1EC33838D7F9515BD5A5CA02B85B3FA12203515
      87EE651CB8B6396FAA057DCDE28A8A0F50AF956E6F9D133FFE1809BC118B7E83
      B8566CA9913EE20EBC432542E2ECED7F7FEAFC2C23873BFD5FC0F987027FF34E
      B1382BACEB33FAA6F9EC8CC10288AC6FE7AC30183840BE600C6E7A4CCBF92E90
      58B9F140E6F2485BED097442EE7BA40337AD2E7DB157465079CDA5E8765EB921
      3D75E215F10E5B409E9B3809E94B1CC20FFC227C3FC77915F8E444B33F0EE600
      11A5375390EB0422812B8872914A37E22208CFEA4BEB15D64C3956E61F96C248
      8EE4D4E6FE745838D2D6CDFD1F96864D11D2617025A8480D994FE73C3B2A1B2C
      524EF2CC3965B55A18188E17D7AE2158085940101881038AA1F8FD265DAA67E4
      DC52441C9625B7C6D1152A93190E89EB72E190C1F3645E974BABB6077BDA7C17
      FBC37108616B374417B604A0F8FD88A9E5409470E72E95271CCE807405E0C0C6
      EBADABD7DBDD14E9AC3ABA4F1D7FFEBFC0D1FD0E41CD338B9BB7F3DDC9D9F9AE
      882548314683CC156D1A87E8E840778A070FEB90EB288F0E9A9C56104BAA6612
      7CCF94791A857EAA2FC4EECFF17AB9CF5108C04EBCF8E0CA798D84BB53D93DE2
      A76C646AFD65EA2359F74DEAF6ABA66ECFCBD90293B364C08D99FA7B9CF0EE59
      FB528541766B127F26B0074766CA5E234A6C4CC933DDD05431430ACC66E4B46C
      ACA1BA9FDC4E6B83C2B9620B4D36B6D0DD82650048DBECB01F24083922935A54
      D491A1437E1A7BCAECC7AE09533D7981CAE922E0B1BC38942E544F76A89043E1
      F4C699C254D57A9102F1CF1C920EDDE7177172EB34BE0F3C4F7318FC24F69CEF
      D08FDEB013D5C9779F6A839ACE0670BD56CC63F1CC2C062CD05AEF0E29CA37F0
      0284E9914CB8D05929448ADF4552FB402CAF18BB0CB507828654B7C6F47CB8C8
      1CE20DE3D311CDCC2E69B303AF6621EF3DDA07AE0A6A2C224C90881A36D984B8
      0FC766A580B87AC5B5F44DA21CC5787E3C0EAE5E64D9DE3A5B0DC9ED2C52337C
      8839BC695DBC2C76D2AB60DE4452C9C04F349D566BD7F48EBAE5D2408E8E37CE
      F2185BA399FFEB4D1C69C9C1368E906DCC9CFC0D1AF5A29DF2505384952FA4F2
      4E7AFE2C34876D948D7D3F7091492E400C6BB4486E2CF0D15750684497B5E04D
      12A368C9CEC62013BCA890E4FEC57C6EA0445083047204B9049BB45496B576B8
      D65208B7CBBC6192BCC64F11F6E2BBD58B7A6447EA04488DD98D565745625CA3
      D82C4867465F4ADD6209F8D50DF1AB3C735BAF45B3F6F4736E09EEE4D31BAF16
      55415EB6B7C252DE84D4AA94114058383B740053E71F0BE4D9943395EE12FA5D
      6060634928BB5A4648C17ADB6D397B3C638ED30979BD9C47F2086E2E1939B446
      6462CCC33CE7D56D837935EF7D37A90053D21096BAC50B08CBA4F83EE684E675
      8EF504EA3C29E41912826A3E0F518C6146834A3DA0ED3A74ABE72A137731832D
      ECD6308FB59AA762E88D24BEB18151F6129D14A5D179193C478981238079CA5C
      2B9967686FD2A2259EBBA3B880DC045A9514760B58F04CCFE2967316E795D030
      40B44A030EC0909199BA493027798BB930717C5533B181BCF72DDAC52E9CA367
      D70C34711173C24D4DA15CFEBA6986AF7B6469D3C9BA1C591A3C7538EBFF82C8
      D272960D4A474031BC52952709BE3561A4AAD1245BB9C1803B3070DFA18E8EAB
      49F7E3C83368A03CCC90EC048F572BE02A758B16E5C1A0D4D9619748A437EBB5
      5091D5B02EA3992BAEA748F896AA5BEF3AC262EFEEF2164AB7C90B01F5E39E13
      E5B4329DF6610BC8E0B5CAD9D08B545AD2F27AB314E7638E280CD888834D2A35
      75643998BEB3639C4F3B6B01B54873959A6CB401EFC9E710D46C4BDE595F22E1
      8E1D1E7A6B06E01A1449E549E4B6209D19A25A44702FC8EEDF1814B53128FE83
      6CDE1F60F0C2B2E07FEDD1493BC0E4D74D96795DB2CCB42DB0DCD919818CB9B9
      8CE9FC195B10698483981C3F729D5BA422B4CAFE54A1C9CEF99EFC267F817ABF
      EC9ED68107A601C344A8DC4E675A0BA547F76351F9AEEE3482DE3B3CEA338F8E
      7A7E043E07D18E66CCDF8FB48482613E4753E8DC36163473F80C460B31B3952E
      D967D54E83E96360CC72A85A6892457429FDC03EEDF4A56487DE9A4977F8DC1A
      419F6E135C3AADAA43C6781A760713FA13AEF0D73EA50FD9D6724ABFA4755DC9
      B61E752793496F7C67B78B3EE63F7F40B9B7F654A69C41BB3F6DF7DAFD0E5DD3
      1ED27F632970EF9234D4134FB7FDA9EFFBA6E8DD6D77F9EF9EFC7B30EDF786FE
      508FFAC301FE1CF883FE68326A0F07A3DEC0EBEAD178E80D5DE54E3AEEB4AFDD
      5EAFDD69D345A3FED877C73D3DE87A7DB5BD3571A75D7AF8B83BD09371D71D8D
      B53B52DD91EBB6DDF164D2ED7786EEC41B4FBB6A3418D0CB8CFAAED71DF4FB5D
      35EEB63BC3A1DB75BD49AFE78F26BA37D5BD5177EA75FCF6683A707B93F1C455
      A3BE52BEDFED77BBF4183DED4CFBA381A7069EDF1BF57D6FA2BCEDADC1703C19
      773AAA33EEB9C38E1AB4FDC9D8EF4FD5544FDDEEB8371A8FC6ED3EDD6CA2065D
      35184DF590D648EF31EDF6BCB19EB447DD8E3F69ABBED7F5556FDCEEBAD3DE60
      34EC0EC76DDF23726AD7A357EF786E67ACA774974E6FAC7BEEA4DFF3467AD0EE
      4D87DB5BD376C71B8C7B9ED67AE04F880C7DDD9DB4A7F40E3DBF37EC6BE5F655
      9F1862DC9BF6DCF68408A75D35F6277DA24D67486BA37F4E27DD913FE86AD5EF
      D25354C7F506139728E513034CDB7A3CD0C3016D4BA73750634F77DB7EB73D1D
      BB9DAEDB9BB6B7B740EC81EFFA4372343BF4003D9CFABDE9448F27F4FA536F38
      980CDDA9EBD17AA7DDB11EB9BDE140BB2EBD46C7F73BFD61DB1FF47C3DEEF4BC
      9EEBD26B4C47BEF08A0FEE217EF9149FD16E100DD4886E2BBF6C93BFDDE11FA6
      86D3FC519778CC1DF5BA3EF195F9790C46F2870A9C45EF3FD2FE7830F5888C9D
      9147F4A6957588AB68277C3598B4FB3D6CCFC8A30DE974C7237F38EE763B538F
      3842D39F7D7F7BCBA56D6DABE994E84CE4D6BE3F52939EE76BA5C7537FA2E91C
      69506738514AB5876E4F77FBC478EE7438D69DD1B0E71173FAC4C193F140F5D5
      A83B68D3EB10F3B4C7437A2E3D630A0676076DAFA37A44268F1CF8A91AF4C7D3
      61AF3D1974BAB40BFE78EC4DFAB8AAAB3479F77DAF433BDCF6BAF442036FDAEB
      0FBBDDFEC857A34967D419F8DE88386F8C57D344333A193D7FD019D2C11AF546
      B4143DF6D5D89DF83E710DD1C87527BAEFBB1DFABEDF75F5A04F9B32A42333E9
      F7DD217D34A437501D3A57BEEE0D7A538F787A3C1C28E5F53BDA6B4F0753E238
      6FE87BB237557676381D4D26C3CE706C24C658E59284FF4792839E405262D0F5
      E5E7EDADF2BFF073DFA31B68FA6F4472A56BA50A2DC6ED7B6DDAFB2EA40AEDE9
      C8539DD168D22669409B312536ED0F8674E8DDA9D2D3A94F6FD6EF4DDC8EEA77
      48BE1045273EF1359D40DD1BF77A23577BC4C77464A6DB5BB41EFA8136D26D8F
      DADE580D072472F4780CA61E91BC5123DAB7B1A7FAE38E4B1BE50E5D4DF7ECD0
      01D393D1B843149FF6C774D03CBF3F21B6EC0DE8DD4854100F126778D381E775
      DBDE703A205135E87634ED85E70D349DDF3E310A893A7A83D160A4C7B49B24CC
      89CBE8435A086D68BBDB1B3F85FE7DDDF1FB6D6FC49C8D8FA61DDE81CEF021FA
      CBCFDB5BC5BF7A1D4B73ED9244F1C7382DC34E7FAAC1483DBF3DF63C126ED3E9
      50F7E969D3A9EB7626434DD74FA6B4D2BEDBEFEBBE1AEB219D8121EDD96848A2
      8C4EE788242BADA98FA3D2753BF4B7D7A3CB7B24113D9FF880CE099D327A389D
      619FC835A5C3309C0C7A2E1D46AF4DDFED0D261312E8EEC8F348057449D675E9
      F47506245DB54FF798900CF348AAF8AED71F4F46CAF7DCB6AF26A3C1B84F7B4E
      4423EE9E4C465DDD9BD0111E283A8E9DE9A437A49DA505FA388D234547580D49
      E1745CE2A65EBF3F988CFB13705397A42DBD8EE7B5FD9E3F1D8FDDD17034263D
      D11BBA63DAEF0924745B0D3BDEA8DDD3DEB44B727A424F68BBAA4774EA4E887C
      EDB1AF27246EE8658829BB5AF7869351A743570C89AC1DE203AF3BEC7AF43BA5
      DC41A74D7A94640549ADFEB80BB93521B1D1C1F19A76DBC4A224B9685348BBB5
      156E4327BDEF92287387234F93761B4E3B444D5220BA4B2AA4DF2775381ED179
      202D4E2FDE1B0EBDC978486A77ACDB24C67A7A3AEA926E1CAB4EB7AD477EAFAF
      BDC17040ACA45DDD859EEA763D52ED63D2909E3FEC2A12BC93C1C8F5495E91AA
      27B5E9D3E3885F20367D12B71392899A0EE2C41B90B1406A8E2848DF7489D569
      9BBCA12251A17CACA9DDEB771431841AF4BAE48E4F95EBD3B1998C46BD9E220B
      84F8C5EF28626962A409591074C67ADDA9AFBBA0883B209DE58F8750D9933E6D
      F9947E4B6A41BBFE68447B488AAB3F25C1ACFC11992E6D3A58642ED06A6827C0
      3EEE804C173AE5A42349858C88B213B250E817240ABBE3F1A4ADA140C67A3052
      9E3F76E9FCEAE1A4DD9E40BEF769FFDD1E7D9DE43C311591723C1877493B8D89
      9DA67D524643623062ED21ED17091077A4E9F0D321EC4F8814A4F0BB64E4F843
      7011098241DB1DF4B4220DD0196F6F757AF4263E6D2711764AC76BAC06B033B0
      29133DE94D48158CE9F6FE60441CD5258A93F826DD47D27ADCED8C483880ADE9
      AC757CA212116908814F5C4CEFD0C67E74DB437FA07DA21CC93022819E6AD23C
      63DA8DFE88549FBBBDD573A19E49F992F2F7FAC4CC24BFC664A7A9C950F90352
      28F4EEBEA6C3A6D4C42736F1E90C9268F5E9CBA482FA6419FAAEA693322266F1
      A6F8CA448D3B2468BB03E849BAA9EF6977EC77E821FCAF1ED941F407292E5216
      033A0B747848EF92294A078176A63BF05C62028F0E4807462051AA3D1EF589EE
      2481E99D3D92CCA41788CFC9BC23DD4944E893AE755D3207DAA4D40774D9708A
      85B63BFD0EAC56626752AD2433DB6415914A8641EAD16B91DDE593B0223E18BB
      640FB91D3234E9DE245448808E5D12F4C3F1744C16C794B69B8CACFFBFBDB369
      72DB38C2F05D55FA0F7B4C0EA902E60B40F9645976C915CB4E2225B9E4320006
      1223EE72B3CB75AC4AE9BFE76980E412240062A08D93940D972C91EC1E4CF7BC
      DDFDF6901C3217E85D0EB0993E0537B55489BA36F80EDA6BA0048D2278C862E4
      A8046A5C90546CD57848A023FB0883CB03F431F70C54290A530A17AB0CF9202F
      13786999939D330A8C4A3C2C57C1862A456541C6A1C37252EA995D85EDDE7AD8
      015D400AE383B12669CAD42AF2694ADECBA994362DB4D4259F535C32A34C2D49
      34270621B01A7C54E46A8CA875414E149A4B8650B9E75E24D44C06369582B450
      20799640F449C152B0EA601E746578A9D0CCCDC0DF740ED49497240AE8C86F10
      2DE8AFAD73A33D014F15A99380243693B414190B064AB9832A53A8E10769230D
      03C429483CB77097D081C9F007BC33670A0429AF860D2419ECB43635F3AC7345
      649AA2F1418889213B594B7750522A61B12043C31183976CE64876B0391235F4
      0D1A5E2469603C7A7162010FA59EBA5CB2487047B223FF240793E11A1230B9CC
      020763894A23A1466D2066EA00E22BD754DAB38C25380F4A93B21AEA0DE860DA
      4C9E28AD4B674B4D6C90F242206094AB09AD463A0F014DC30C424878046F2639
      77D997DC4D820E16232887D4ACA668E0454C28AB183B25D9A892F1881DE35DC6
      9A25D4BC02BA2E05015248EA4ACA90F88CE6413BFACDA4A6F30137242FA28D71
      1B956A0220C91C1989B52BC9D6E0B8A0CCB0BA84AD16494449454C94115D43B3
      4EE878EE462BC4FAD53E148E0C4EED2DE8E8481F345E0DCD4F29559B8401E122
      00298FE0D696D23465509342611C2C9448C91243FDA632D56501F7C1399A0032
      4925EC896022C7C290292364273A19229EBA4492078A09B401CF73F712C4D674
      DF894095944B82A1CB926E525A27984C467359C0E45272BEB7D88D1D8554A4B2
      AE2A987915A46B83EA40789C4B9CA77D4F840690B8AD9052381135991A4A02F0
      D476E2DD6A28BA253E0948E00F2B62CA100D07008D491CECD45277E84221DB79
      CDC2D137F2ACA53091E629E59453628D4ACE30DA3283862E16728C249D5DEE61
      495888A7701ED3870AE0105F3237D1220D3A3854C6ED0024B99E4A103CCB9952
      14A41BC888AA8A346D1CC11A5CD3E40DF586369747D4533A1ABC8BF754A13D44
      BC96BE1154C08DAA36214376F0326D2239D34055BDC4A6B2123D554E2039B881
      66A9A837811688B5E1A5E08829881C79C966B5F6922469ECE87032818D2F1836
      A78C08BBCEE0E3C0917C9BD1BC67C2315805E96849355201897E45C3EC991355
      43A7867103FC4315A4550759A180938C21398437CD19843267AD7071D1A8ACA2
      F931D4E5342DEA04A74BAB4B39632E6273B0D459524A612B1C05D5C0DD499530
      03B2882AA0A32C736A8D3674F2F4D82C11EB02277395178E464F5613E7703D90
      26DD3929BFA62489DF0DAD1D7D46A135BD4049BDF30A68D19D90A448EE659A40
      58A8F1965454B30E654668C80E052E33746DB5B09784B45C347446966CC7CCC8
      293E2DE956E10D921F92B2527025A34A4820D5AACE32E832C9999E978CC39215
      B285236CA5CC489029F0A5D25067DA9D113A12FC4F2745478871AC251369C470
      E189DC9202425FE9EA1CEE4AB7649086DF2848032BE00C0D6D5AE11E72202C19
      0E9165E40F9E70AC3DF4A6A24BB5E097968CC2CFBA10E5D4D720D384C7D184A4
      5951B5F6D725F54836BAF0412D25AE068924E18A6C4E4B409600B1CCB44A13FA
      9D3269305C1519B959076901854551DDEA4000433924D6E8792147AEA00C821D
      E20FC656064B9B086D954D07717721D00E646F968DDE498286BEA73632037080
      818EC2C08AF986B58050407B606924619C5FD4DEDB26907AB467E48CF892BE1A
      14D1E0E372AA82873339F1306B64491C257929234469E3798E2403864103F64B
      91019600CA91662B88141C98BE115E4385450FCA43596206F8706EB79890B48A
      A490D9765D7AD9759A2A9BEE161F7767A88D173BF7FEFE4DDBC30B2B21308868
      95C97649E3C820A5978E073CD5798E10A1238D52309AC6501A24DAE2945EA4A6
      4D948E26875E91CAC807A12820B76591C1010BC8194155071213B10C1AA84608
      C0ED0B7A0CEA540EEB8403D2885301F2A22E34A5A0C4353909C0915F439D4261
      0A1A5E951B69C80CAD0F77D3D0F08CA053145428381C05566E1A3812014583E9
      6153743A4629AF3D349EDEADAC295E3422442DB94DB6E5A0BBF05450EC5800EA
      3B552465FA969642766D70033C2C2F1CF8A44CD27FB1C0D05552099451729497
      ED878A3083CC79897453D1B158E004C2A13DDDCAF5569FDAAE6A39C2247EC777
      EA3ADE0D86A58DEE075F9A83EC064EED050E5D3AE964FA487C44DAA57B5EDAA7
      1ABA0815351515C77B28C39170695697766F862E6AD26156ACC2C0BC8676762E
      CDE45266189C09E13BE59FE33DDDF939A39DA94D1E3D60BB3F76B72B565589DF
      BFF4E9F93379B3A3DAAC3777F795BCE571BD3B5996AEB2D98D4C9E963B659AD4
      0A7AE9A994F885F64FD11513C04E506D7895D6525EB5947B43D7A97391A0DF37
      ED8CE5FF958C805F91CA0A413D6341EBE19D5EDE59200D90AB33DA07E962E014
      4937076245F39AF473340099E1BF0486D528D9A4D03BCF10F334474DD6CE69A7
      E79CF8505E33BB5795640AFA2CC5735937E7D64A889C264A680D1B9177854468
      6B211ABABB33B406CBC52603B5EA9E33AEEC9E6BE5D4414E1DE4D441AE7D8EB1
      65CEEDFB41BB317ACF3CCAB4E894E7D499D4F948FA4C469FC9983319732663CF
      64EC998C3B9371AD4C8EC7C5A365B74EFB47ED6BAC84AB4C5FE2E439E4C0C20E
      93F2A9A79BEDFDF6E33ADCFF6D7D5FDF6F57D7FE279D5979B0DE541F425D8726
      695F0AD7ABEE9DD3FD33DD9BAAF2959CFD33FFE83E02BF7F787BB7DADCADB61F
      795C14FF7A1C32FC5485DBEDD591467A752C9F5C3DCA2657DFB73FC6F5C5A874
      D1937E1FBA0FD8A45F3C7FD69F76A7F538E9747C02C343AA2F9E7840FDD4039A
      A737DA3EF51CDD530F983DBDD1F953CFB19835E05E6B4588FD341BC17DAD7920
      EDEBCCC3615FC72CD0B18B2C9A0798BE4EB64067DEA2F7758A9916EDD1A1FBF0
      D86E2A96F9330798B7E21303E8CF37621E1A26069897662606709F6FC43CD04C
      0C300F411303C4A589AE305E7D7B2307F3458656B3D96C6F36DBEECB3D5177F5
      37E8ED7E4A235657D261B88B529189A2B22471EC92EFF25CAE6D6FD4CAB79F18
      8B9AFEB6FD72DEA6B96A56EF1EEEC27DA421E1E6C7B0DEDC1E4EC88FBAF741F9
      2E6C1FEEE2E67DC0C7E13B834B41F238409CE9EDF7CABA137EA26E7DEBDF2DD2
      83D77E86C17BED3624E20C3D40C43F6CDF0BEE56216E9DAF7D75B78943E5C647
      45C75EEFBBD57DAC75A272F5E261BD0E71A9A2D5FB3E7E195BBD3812D4AACC2D
      823DA53812D4AACC2B7403DE5B62D44E73916D3BDD0526EE341758DAADF7124B
      779A8B2CDDE92EB074A769C79BD3B4DFCBBE5D6DD77189E5ABF546BE261E69D7
      9BD5BB1B2FBF9114C548FA63BCEC3EBFDC7E1DECDD9DBF7D7FF5CDE6262E885F
      6CEA8F576F6359C2416B19B56957467E0D6C75F310E7EB9EE612141E74E33AAA
      BEEEDC267E583B2EEA5EC329A45EBE7A2466C3303E81D743B98D46F21BBF7EE8
      3841A4812FFD36EE4E8F00FAA63DFD6B07A3CF1F221213DF0B2378B5ABB37136
      3FDE3FEE968F7A71103C8DB9C5B7DDA9C726E217F28FF854F1EAA31CEABABAF9
      10A5F5CD468EF50E755F7B10F8EDB7088F30BC95936576B60D2BF413FED7D7B7
      EFFDFD2A8ED0EDBF8A74F5DADF4629FEA1FDBA4AB417BFFEDDB55FAD8F8A46DC
      DABD7AFBFABBABB79B5BE1B0727C70DC0A8AF20B394CE17A91FEAE09FECD5F43
      F9DBF81B7F0973BEF978BDC4E02F177464ADE257ABC874D6696DEA055A2F0FBF
      58B4C4C4DF878FE5C6DFD5F1F7FD035D541B1CDBB040FB8D97EF97C7EBC937D8
      FF491046EF17B4DA7FF1772B69C59636BAF70FE5DF43151779DF6FBA9E2A46E7
      87EE5BBA5DDD8FDD24EE29C7E5F89E6A647591DF51D81C65A6913DB0B76D2B2C
      47F88D987594E8AAF07EB396337E0E830E3397537FBFB9F5D5BEEFDD0BB97ED2
      FEAE3D26E7CDFBC706F920784ABD44F0B082072935207564D5414E9F90B17AF5
      70BDBFEF6E63F8206BA664555FD60EC9EEF0D21374A382272366438262D2E988
      F9A8A03AB5BE1815D5BD31B3FEEABCF4771FCE7D9E9DB44DF266BBFC12EDD02A
      666A58F67C503D2CD8AEE55C0051642A29E6E9A9FD63587A549805AA11F1696C
      8D284D836C4469026DA7B68FC5F39FC28FABFBFDDEEAF05EAC3931FFFEA8339D
      E06F7D90FDF161B32BBEC337E92FE3B737DB70731F8EB4E604CEE87A4FC4D088
      67278269446322A68635C6826B447A3ACAC64C9F0AB8911B4D44DE88E9334250
      CD4BE623E29702F02CC1CD0B41B52404E727FC118D19003EB367068055348055
      3480551480D512009F9A3E07C02A1AC02A1AC03A0EC03A0EC07A1980F51200EB
      6800EB68009FD93303C03A1AC03A1AC0F3E8CD88F43C009F9A3E07C03A1AC03A
      1AC0260EC0260EC0661980CD12009B68009B68009FD93303C0261AC0261AC026
      0AC06609804F4D9F0360130D60130D601B07601B0760BB0CC07609806D34806D
      3480CFEC9901601B0D601B0D601B0560BB04C0A7A6CF01B08D06B08D06B08B03
      B08B03B05B0660B704C02E1AC02E1AC067F6CC00B08B06B08B06B08B02B05B02
      E053D3E700D84503D84D6CDDF5FD206F3AAE43FF1D95E19EBF6FDFBE8B3F284E
      BC7BA3CFDFE75CCBEF091E7F246858510DDE738E66DF492F369B0F111F13388C
      D2C7E58B55B95E6DDABD918F9FF3F1E8D3FDD91FBE3ABC9F792C6606DF866A37
      73FB4DBA51A382FD66C8E851C13EE9346654F09442183B2ADA4FA3A61F4E2D5C
      3BB936E1F565DD986C3A249D8D499F989F8FC99D585F8CC99D1A6F476DB26DBE
      E80D6BD331617788E2BE821A53C886152EBA6D789367C27F637B4F13AE1CB9C7
      B84F87152EB976446B868FC76C9AE3EE11E3E6FA5DC5FA7D3680C7F65866F85D
      2DF2BB5AEC77150DF251E3E6FA5DC7FA5DC7FA7D760619DB4B98EB77BDD8EF7A
      B1DFF532B49F958ACB7E37B17E37B17E378BD07E96F823FC6E16FBDD2CF3BB8D
      45FB695735C3EF36D6EF7691DFED62B49FDA14E377BBCCEF2ED6EF2E16EDA7DD
      C30CBFBB457E778BFDEE16A3FDCCB8BEDFDB8E6836093C929EACA147729329FC
      486E32831CC9ED28E064E238129F47028F14E691C073B7CD2281C7FE1B511877
      E4286B1CF7E92C1278E6DC592470D0C7239A339C3D6ADC5CBF4F92C021BFCF06
      F088C265AF9F12ABB97E9F2481937E9F2481937E57CBD07ECAB766F87D92040E
      F97D760619A16433BD7E461D23FC3E490227FD3E4902C7FD6E62D17EC61A2FFB
      7D92040EF93D2E858F684578FD8C3E46F87D92048EFB7D92040EF9DDC6A2FD8C
      355EF6FB24091CF5FB24099CF4BB5D8CF633E3E6FA7D92040EF97D92040EF9DD
      C5A2FD9458CDF5FB24099CF4FB24099CF47BDCB904AF5189FF18F69B6BF9DD8F
      65DF7278E5EFDF6F7DDC173CFF7C7317EE376BF971A8FD843FB5BFD4203FD270
      BF95DFCC4AD2F6ACA3A43BDF2949D2DDF94CCF9F1939EEBD3D11482B15AC36A9
      CD6D6E6A535939352975A63B4B493B39D768F072DD48755235691A129F9669EA
      433A7EBA53776939BF98219BD034ED694F632753A5277F9FBC20FACDE1D4B1F3
      C787E7FF83979CA6F9CBBD7EB5FE977B0D585FEFFE0E3FEF4CFE1BD7AF6BFFCB
      BD7EB57EFAB2700DD7747F32D3510F030B71A17B9CF144565C6209CBAFF6A44B
      3B5EF793CAF9BAC8F34235692D87533BCB4C4D5238AD6C1AECD8B83E71EEF933
      5BEB3A73159A493AC638FE57AE510F2CBC9E3F7BCAD9FD1CD7537AE0FFCF7AB9
      9ECA030BACDFF71EBBEBD3A77F035AD3BC37}
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
end
