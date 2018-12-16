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
      Left = 881
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
      ExplicitLeft = 931
    end
    object bnForward: TSpeedButton
      AlignWithMargins = True
      Left = 911
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
      ExplicitLeft = 961
    end
    object bnHelp: TSpeedButton
      AlignWithMargins = True
      Left = 942
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
      ExplicitLeft = 992
    end
    object bnNexusMods: TSpeedButton
      AlignWithMargins = True
      Left = 1018
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
      ExplicitLeft = 1012
      ExplicitTop = 2
    end
    object bnGitHub: TSpeedButton
      AlignWithMargins = True
      Left = 1099
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
      ExplicitLeft = 1149
    end
    object bnDiscord: TSpeedButton
      AlignWithMargins = True
      Left = 1165
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
      ExplicitLeft = 1155
    end
    object bnPatreon: TSpeedButton
      AlignWithMargins = True
      Left = 1237
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
      ExplicitLeft = 1235
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
      ExplicitLeft = 1301
    end
    object lblPath: TEdit
      AlignWithMargins = True
      Left = 30
      Top = 5
      Width = 845
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
    object mniNavRemoveIdenticalToMaster: TMenuItem
      Caption = 'Remove "Identical to Master" records'
      OnClick = mniNavRemoveIdenticalToMasterClick
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
    Left = 152
    Top = 88
    object Files1: TMenuItem
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
      789CECBD6B77DB469628FA5D6BE93FE0EA9EBB2C4D4B3201BED3D333C791EDC4
      A7FDC8B19464E686596781244822020136005A5267E5BF9FFDAA4201246CC922
      63BA593D138B048142D5AE5DFBFDF87D90E61377E08F8349E4C753B7E1B5077E
      9C85F4CF683175BDB637588EF88E49D36D37BA03FCD4186479369B8C87A3195E
      6CF3D728E1AF1DFE3A0B4B5F87A17E1EDFD56CF45CF57912C09B7B837C16CC03
      FD9BFE56FD7594357E1F4C9238CF87117C680C60E871E80C266932F7E3C16434
      F3D32CC8E1FA22FD87F7FBE0DF060B3F4EB2C06978F07F9D46B3D16EB4E03F0F
      3EB5FEB80AE741E6BC0D6E9CF7F8F85FFF80213D3DE43C190769754CB73C6617
      C6E9D3D838660BC6BC48966918A438EA5FFF383C80119B3593F4562709E06CC0
      82E1BF2E4C1607EDFE7179371F2611CDCD2DD61B87D1C7075AF9DF1F3F87F174
      0CFF65322FB7553331B7D9590FBFCAA87FFCF006867B1DFE88F74DFC2877064F
      86DDC1936E13FE7A832763F8EBF7074F26FEE0C9A83D7812F4FFA06534EB5EBC
      76DB70BB78DB70FB3C04B13F1FA6A1EFBCF1F3998271570F99DD8459F6F12127
      B45B1E0DAE868C421893A6D76A3E08058630AF7E79B024CE92C8CF78CFBCE643
      A6361444E2FF004DFFB80CA649E0FCF84AED5AC77DECB6FD4FB56F34C10806F9
      2D490774C4377DA068CAE3A1F18647CFFE33916E161A93F01E862DCDF5D8E2BC
      0EA7B35C163934C7AF3BF28FA04BB04D61ACC67FD0017AC036156F687FB96D2A
      26D1D9D0A1561B548CDCDDFC06B5DABD3A42DFECF1B04EE539E7E2853CDAAF7B
      14B77AFDA377A92CAC554F11F097B54F7F9706C135BFBBE3D53EEDD53C7DB54C
      E5D93A4477BBDD9A678FBF0F866970732203D4F2A06E1DCC8E9FA5FE301C9DE8
      D5D7A26AAF5333C4B7808FE14866D0A95D7EB36E063F85411EFB70319065747B
      752C43EDBDEB188281DEF76EBFF639D9F8CA73C5A6F7DCBA47D5AE971F3576BC
      572BE3A82D2F3FAAB7BB57CB19D57E971F2CEF75AF55FFF43A205537BAD7AE7D
      5E76BAFCBCB9CBBD4EFD929BEBDE5DDDE2CEA758A3A3089EF37390E5F0868710
      3E5A60B7FF6902628A3E0A8BBAFD4F538FF27377BC9FBD7A66AC0947E9C10287
      7A8D4F538DD2A38443B4CC5E3D6FD107B6F4A8B18FBDC6A74F6BE9D9957DEC79
      BD1AA6620299D9BBC0B7E7F5EB1E31E02B8FE803DA6BBA354F99C0E5A70CB836
      EB441313AEFC943A96BD669D84595061F54CE944F60C41BCFA60151695C3D86B
      B6EB1E3536911F35F7AF59C7D2CDFD9337AE6C5DEF5E5496656FBD79BD7B9158
      F550B17DFD7BD15779CED8C0FEBD88AB3CA7B7B07F2FDA264F9900EDDF8BB0C9
      8365908A3AD1FBF481502A88022A3CF4E923513C24E4C6EDF43F7D24F4530548
      E1B94F1F0AFD5C4168E0B94F1F0CFD5CE964C0A39F3E1AC5A3FA6CF0A39F3E1A
      FA51632BE1C14F1F8EE29DAB5B89D6884FF0A8FF596552AB1AE0670BB1A5511E
      23CF9A03B98F116D4B037DBE945B1AE63102EFEAEA1E23FD56C77A94185C1AE9
      B112F18AD2EF6D5376AAE8F60FE0EFA4BE2BF42D8D717F862F6368E435877980
      04C0C314A85B1AE6FE22010FA310B734C8FD65041EA482B6A5B1EE2F36C85826
      D29646BABF14C12319285B1AE7FE6285CC6815614D034EF3B3A9606994CFA482
      95615A9F4D0357D6D5FA7C2A581AE6916A7F69AC475B004AA33D8A0A9646DA80
      5DC0B4D9B53E0FA514CF28C6F97CA43287693F92B116037D264AAD2CACFD48A4
      2A8DF578C65A8CF5F928B5BAC60D209569A6ED6C9FB116EF7A98E2ACB846F1FC
      03B5E8CAE3DDCF51A74B033C50B35E5940F733D5ECD2189FA37157C778B8EABD
      BA9647E8E1A621BDFB1846598CF21875C11CA8F718AA561AE8518CB218E6D1EA
      4269B44752B5D2588F6594C5488FA569B4D0511225693E8CFE3A488371633085
      5D891B8361B40C1AAB97BC76DBBC085F3F769907C06F6B86A85CAEDC5B3344CD
      0B7908D7EB9917E1EBC72E37FE7A788097F1FB9A412A971BE58BC5206B2FEB41
      FA9EFC001FE887BE772F383770B3FF0D233546B305920ACF1B60A0C7C017F71C
      8679E82F1811225FDA8E7A70E12F1C58E13F226710858D410AFF65BE0B7C2B8B
      BC761FFE9D2FA3DC1DDC84E3511E2DFC747093FA0B78CE87CB033F5BF8D162E6
      E387783907CEE52FF364E08F7F5B66798A823C0C08738DF09F30F7170DE78F41
      9CFC03B02E992779E0FC3EC8F2BB28C8664190FFFEE74D6290E611C06232CA5C
      5CBC2F2E479F00E8AB681B984C9EF26D0D055C150063C4BE10C03F05EFC1689A
      86637A2C5E1823C40B1CC3196471709BC35BB27F4C9274EE03FFCF166998A461
      7ED770DEE2258C3081B9666E194C43B741C0C27F87B87017BEF1DF07812B59E6
      00A0200A3E0451E3DEC01BF8435861032107F2730DE48603FA751DECAE41E401
      0108D4C38FC307173EF4B3609CC40D0116BC3C83595DBBEDB550EB3B885A6916
      8E5DB7E17AAD7EDF99053E86D7382E9E9ACCDB3E1CDDCF8123C0A28023ACBB0A
      49F87D1D243F855F15E8790A7A9D8742CF133C6C6E1F7EDEE7C0CFEB7E0C0FE1
      D787436F0DF63515FCBA0F855F936936CC1AC6F2C7E3300F3F04707B16CCC359
      381E07317C59C6F03158C22B8D415DE739C3CEF9C14FFD29C072E6BC4CE29C06
      8439E699EBC23F6972331EE4E924CF7E0EC7F9ECDB267C59C08B22B7D1938F69
      F17112A9DF27B9FE34D49F52FC341A2E7C20BFF061C21F86B074E044FC37BF5B
      047057F62148739040E0D3301DA7EA6F247F87F23795BFE369A43FA96B33F9FB
      C1F9142B80D56E8519EC0C2B70DD8FA0C4E1017304E7CA1F4681C6A7B6894F75
      447AE54834983A6B4A5CD00A44504672FC9B8CAE4BD8B806C5BF5704D6B90009
      53CFABF3E979E16BD7CC0B2E1B674FCFC77BE07CBCF27CBA9F9E8FD75D3B1FBC
      BC329BE60367D354B3216EDEDB0E197D00C2F3825B1F41F6D66668A6DB2B4935
      2B009A6749AC241DDEA97EED4E4D1AE5592EA3C168E25576A79EA456B7064858
      8A7BA9DEEC351EF666D75B41D47BBFFC651245C94D305E9D845B3F098F36AD32
      158C8DA68B9F0985AB37AF9D8B641C086E7A5B12917611373DEF219012F27BFC
      73303C6161B22C0D69702057BEEDBB1DF8D7C5D091FCD6EB02B1CD6F9B9D4E0B
      FEB4DA3D60A3B7ED561F6FE9B45CBCA5DBC488FADB9ED76AF1D3780B40BD4BC3
      34FA7DBCC975FBC8C36F4187F4F036B7D96DD17DAD4EBBB3E15D1064ABD90558
      A320DE460453255979AD07E3EE0F69C092581E8CF5216A7DE6215ACB784AB4BE
      34B94FCDA7C482BC7A561DAE5298B072A057C54D6F0D357D31873DCFC24CBFB3
      9E0D575E585DF94748F6223A2BC8553D5FADAEE801C38FF4F0BD8FB3ED0AC3FE
      34CCBCD5F71D1E5CE669124FFFFA07BD340AB33C4711EB77FAC8DF83F922F2F3
      201C9F753B2DCFF3FAFD0EFF4C2ACB80FE8D2723A008EA63AC3EFF366AA80FB1
      7C9A10F1972F59EE83080D02367F5BF8A3407E01313B88F3C6EFFC2D87733278
      D27007CBB366DF6D3AFF8930E2B72DE7C320853DA7AC968CFDFA3EA17578D6EC
      E021EFC2C5DF46B234A4361E1D7DF8E390A16FD34BF900D38DE1236CDB7DD795
      AC5B8F57B31EB7D52A2F882EC0C8F817CD5CF75E102ADBDB5A126D95D75FBF55
      6EA3666D1ED27E736D74015E817F1FB4B67BAD0C01F0E7ADADD7ABAC0D2FE0DA
      E0EFE6D756BB32B5EB9B5C5B13A391CDB5D1057805FEFD13D756B73258F367AF
      ADD5AC1010BA002FC1BF3BB0B64FAC0CA595DAB5610A49696D74015E827F777F
      6D1F5B59B783985E5A5B976909FEFDAAD7D6695528095D8057E0DF82A9A13FCB
      8181F07338F6DA6EB7D7E9B87FACE7EDAD7ECB6B7B30FED7C6DB2B9B6C72F79D
      D8E22DF17645C5BF1EACDD1C6FDF41B9E5CFE5ED7FAADCB22BBC7D1B72CBAEF3
      F6C7C82D5F396FFFB8DCD2ADD0927F29DE5E616965EEBE8EB7B7BD76AF030CBC
      9EB7B7BBDE57C0D871CFEFA3B6EFC4FE6E92B1EF881DE20B31F6829FEFDEDAB6
      CDD8D5DABFC0DABE2463D7CBDED2DA2C63DF594A6219FBFD19BBDB6C799EDBEB
      D568ED9EEB76BBBD7EDFEB59E66E99BB65EE96B95BE6BE0304C43277CBDCEFC1
      DC3DCF6B77FAC0DD6BD476B7D36ABA8D56D7FD1A6CF296BB7F8D786BB9BBE5EE
      96BB5BEE6EB9FBC6B97BB3DFC708D846B78EBBB73BDD8EDB6D76BE86683ACBDD
      BF46BCB5DCDD7277CBDD2D77B7DC7DE3DCBDD5E8B9FD86D76DAFE7EE7DAFDB69
      769B5DABB95BDE6E79BBE5ED96B7EF0201B1BCDDF2F6FBF0F676DBEB775ADD5A
      BBBCE7B6FBBDAE55DC37B0141B1D6FA3E3378D7B363ADEF273CBCF2D3FD7D1F1
      4D2CC3D0756B2CF12EA8E96D2C63DCB2FC7CB37B6C9575ABAC5B65DD2AEB96B9
      5BE6BE35E6DE0175DCF37A35CCBDED765A2DAFDFB08678CBDB2D6FB7BCDDF2F6
      5D202096B75BDE7E2FDEDE6A36BB9D76AD21BEE9F65CF8B96FD3DF2C77B7DCDD
      7277CBDD77818058EE6EB9FB3DB87BA785FD97BD66B386BBF791F3F7BCB635CB
      3F7E29D6CD6EDDECD6CD6EDDEC969F5B7EBE357EDEEE345B2D587B9DB6DE075E
      DE70BB5D1B37B7E14DB6DABAD5D6ADB66EB575CBDD2D77DF1677EF76BC560776
      B5C616EFBABD4EC76B34AC25DEF276CBDB2D6FB7BC7D170888E5ED96B7DF87B7
      77BD9ED774DD9AFAF154C6A6E9B5DA5671B7CCDD3277CBDC2D73DF05026299BB
      65EEF760EEFD6EB7DF6FB57B75CD61BC46ABDBE8B53AD6CDFEF8A55837BB75B3
      5B37BB75B35B7E6EF9F9D65AC2343CAFDB68F79AAD3A3F7BABDDEAB51BB6E1DB
      A637D96AEB565BB7DABAD5D62D77B7DC7D8BDCBDE336DA6EABAEE35BB7D5F19A
      AD9665EE96B95BE66E99BB65EEBB40402C73B7CCFD5ECCBDE3BA8D46DBABB3C5
      BBBDB6D7E9B7FB5D6B8CB7ECDDB277CBDE2D7BDF050262D9BB65EFF761EFC0DB
      9BDD76A72E46FECCEBF73ABD76D7C6C85BE66E99BB65EE96B9EF0201B1CCDD32
      F77B31F766B3D7E9C00DEB997BABEFF65A8D7ECBC6C85BE66E99BB65EE96B9EF
      0201B1CCDD32F77B31F76EABDFEE796E8DD7DDED63B1BA5EC7C6D459EE6EB9BB
      E5EE96BBEF0401B1DCDD72F77B71F77EABD56FF43FE27677BD76CFB5C56B2C77
      B7DCDD7277CBDD77828058EE6EB9FB7DB8BBE7757BAD46B355930FE7B92DAFD9
      EB346D4C9DE5EE96BB5BEE6EB9FB4E1010CBDD2D77BF1777EF741A2D50CD6B2C
      F3673DAFD9F5DACD8EF5BB5BEE6EB9BBE5EE96BBEF0201B1DCDD72F77B71F77E
      C76BF71ABD76BD65BEDBF77A7DDBE1D5B277CBDE2D7BB7EC7D27088865EF96BD
      DF87BD63F7F646B7DDEBAE67EFBD1E28F77DAF61A3EA2C73B7CCDD3277CBDC77
      818058E66E99FBBD987BABE1355BDD4E8D65BEDB6D786ED7B321F396B95BE66E
      99BB65EE3B41402C73B7CCFD5ECCBDD3ECF57BCD6E6DC83CF08F66B3D7B531F3
      1B588A6D1B63DBC66C1AF76CDB18CBD12D47B71CDDE0E8ED7EA3D7723B751CBD
      D5EA7B6E1F58BAE5E89BDD65ABB05B85DD2AEC5661B7ECDDB2F7EDB1F75EA7DB
      469D7C3D7B777B9EDBED75FA7DCBDD2D77B7DCDD7277CBDD77818058EE6EB9FB
      7DB87BAB013FF67B5EA34E79F73A9ED76F342C7BB7ECDDB277CBDE2D7BDF0902
      62D9BB65EFF762EF9D4EAFDF763B35B5E59B5ED36DB4DBAE0DA5B3CCDD3277CB
      DC2D73DF05026299BB65EEF762EE3DB7DB6C749BB5A174ED56B7D507A4B6DCDD
      7277CBDD2D77B7DC7D070888E5EE96BBDF87BB779A1DB7D975BB3529EE679EDB
      72DD8ED7695BCBBC65EF96BD5BF66ED9FB2E1010CBDE2D7BBF177B6FA36AEED6
      E6C1799D2E86DD75D672F7460198C643E1722F5078F05FE3BC0A068411AC20CD
      A3D16C301965AE33F027C4DCA33CE54B26601ECAE81FB3AA87EF362ED1BDEF12
      D72F10597C65E76B73E6BEE02ABDC7ADF21352C07A09E7CF5F65F391AB7CB83C
      A059FC9FB8CAD6E356F91992C1DA9DDC621624AEB2FDB8557E868CF0107CDD84
      6487ABEC3C6E959F212D6CE854DE5BC6C355761FB9CA87CB0DDBA63D44F12AAB
      EC3D6E9524303C5082E836DAFD9EDBEBD6F8F6DD56BB0BFFF55A1B6F4FF34011
      FF7E1682AFC43EC0E2FD96F2EA7752F2FDA854BFB9BCFA2FB2B64FD8072AB2DD
      76F3EA77C73EF055DBAC1E6D1FD8619BD5D6ED035FD066F525ED03DBB6597D16
      776F775BBDA6D7EBD739F7DD9EDBEEC25C3660FE5FDDF6BD62EF5579CEB277CB
      DEBFE6B559F66ED9BB65EFBBCEDE7BDDB6E7366BBCFB9ED7EF741ACDFE069ACF
      59E66E99BB65EE96B97F056BB3CCDD32F77F05E6DEEBF43ACD7EA351C7DC41AD
      6F367A2DABB95BE66E99BB65EE96B95BE66E99FBD7C2DCFBCD46B3D7EA7B35E5
      6EFB5EB3D3EB37DA1B48BAB3CCDD3277CBDC2D73FF0AD66699BB65EEFF12CCBD
      D36D34DACD4E6DD21D30F60E3CBF3E2CDFB277CBDE2D7BB7ECDDB277CBDE2D7B
      DF45F6DEEBB57BC0E26B42E6CF5A9ED768F45C6B99B7DCDD7277CBDD2D77B7DC
      DD72F7AF87BBF79BDD56BFDDABE95473D66CB8ED66BF6B4DF396BB5BEE6EB9BB
      E5EE96BB5BEEFEB57077AFE1BACD66A3DBAF33CDBB5DB7D5C1823A96BD5BF66E
      D9BB65EF96BD5BF66ED9FBD7C3DE9BDD76C3EDD784D5757B5EDF6B363A3DCBDC
      2D73B7CCDD3277CBDC2D73B7CCFD6B61EE2DAFD16E74FA753DE4DD26C6DD75BD
      0D94AAB3DCDD7277CBDD2D77FF0AD666B9BBE5EEFF12DCBD0DAA79BBDFAEF3BB
      7B5EB3D76D75AD5DDE3277CBDC2D73B7CCDD3277CBDCBF1AE6DEA73AB4FDF61F
      F0FBBFD1D5E44390A6E1388031A2E0F7D22579CAF5FA1DAFDD6BF4DAA55F47C9
      1296328832579FEDEA83BA74CEFA0755B79CEA633AF46FFD63CDF58F75BB5ECF
      6BBAAEB7FEA956CDCB5A0D8057BF47C779CD63EDF58F755A6EA7EF7A4D3AD8EB
      9EEBD4BC4ED7F95FFF5877FD63ED66B3D173BB6E0D207BEB9F2A2C35EB1FEBD7
      C15F1545A8D9EF46DD86177E9F9A27DD9A37BA8D063CD869D440C5ADC19466BF
      EF023AD7E1975B8329C531A879AE0E579A9D76BFD183ADAFDB75B7065D8A02D0
      35CFD5A04B112753F35C0DBEE053BD0EE6B6D63C578B314AFAAF79AE5FB7F5ED
      8EEBB99ED7AB3BEA8D3A5C5339BA35CFD5608CE7796D3880BD9AF57975A4C525
      C2E2B96ECD733518E336BC8EDB68BB2DB76EE7BD3A9CD1594A35CFD5618CE775
      7BAD46B3D5AA79AE8EC0B8FD56ABDFE87B3564D0ABC318DD7FBCE6B95EDDCE77
      3B5EAB03A242DD026BA84CBFDBEDF75BB0173544BE0E617427D59AE76A10A60D
      1CACD36FD5BDAD065FDA9D56B3D9EDB47B75DBDEAC439856A7D3EBB7DD4E0D54
      9A75E8E27500962E10FB9AE7EAD0A501F8D2009659832ECD3A74C1E535B07E6D
      CD73DDBA6DEFB43B809C2047D53C584361DC66CBF3E0DCD6ADAF8E27355B0DAF
      D9EA766A9E6BD5A04BABDD06E9A555C76E5B750C09A82736ECABE7EFAD3A0AD3
      E820376BD79DBF561DC2E8168235CFD5F3A426882FCDDAE76A1006CEABDB6F78
      DD1A16D8EAD40A75BAD871CD933504C66BBB5D604975FBD76389340D3EE4C3C8
      F9FDC7F83A4E6EE2BFF2D5C5744157F1C320847FBC4198FB0B14D91A8314FECB
      86F09F8F38A0EE68D4DCC16FC9C2310E481F3ABD66D305FE839FBB5E1F84CF1E
      7D866D74BD561F11723EF7F3D90F29E0027D7A99C4391CB4F930BDFE36048540
      3E5C2EE11DF36CEE47D1CBD40795613E0EB3C5F360E20EE6D11B3F9DD2BDA9FE
      340E26FF6B04BFDDA4FEE215290664C3998771FE3A9CC387D84FEFE013E26818
      4F92DF07FE329F25A9F322827BB23C489FFD083F258B20F573B87C05BFC1D5D8
      79114FA320859F466900AAC87C70978220D11BCC13108EC7776E67304B5D7A91
      8BAB43987FEC268F057CD8B22C4C629C4D30C609E0098893C9C29F0659BBC15F
      6E92740C7257ABDBE4EFA3999F66DD4E97C0A8BEDF64A013F4F1711833EE3779
      536EE7112C8AB6993EBACE2CCF17DF3C7D9A8D66C1DCCFCEE7E1284DB264929F
      8F92F9D364320947C1537CE1530FC447FA348FFEF863B0F0012237C0081B1DFE
      3C03320C9B3A07C0470C62F894EA4FB9FE34A44FD3650EB06D606FAF2C18E5D8
      11F3261C2737A33C8D06933C1EFE36F083783C4E46831CF6F97A0ED89C35F8F3
      24490143F2309EBA8371122779008ADC38BBCB2680332E803ABA4BE20FF3A861
      FC0A2ADB74ECE73EBC399DC0A8A000C6390CF8C18F42B81E0034DC41364B6E16
      116892B3241AA3E208083E8D93349887B7C17804A3A3620928FE2108637AF216
      DF828FC107386D801B2EECC06D04D34BEE82185615DC2EB2599AC77079098B05
      4D753418C7B00571361C0FE12AA9AEB0A425AC1B1696CD7C38CE8065FFC4B58F
      A773C264F830A31B5D503FC7D30FC667B8359CB249127F297D9BE1D45C7A003F
      A0550CE6E3C7E3C18730B8B9064DD9A54FD9C88F60B8369CEC613A4E67813F96
      8F9324C907D922BACB6FE2300E706BF4E7593E87C3922D6011513CCBFDF16FB0
      ACC13203A57BE847F100FE830BF092013C026F18C1B71BFA021FD27C9A0EA218
      4E35AC3C8021E0D34D8A246890C5FE224FA640BBC2781444110C142537933088
      E0FC8E61F801DCB858C623EC2DE667A1AF47419292C28C155919C4C10D8C98E5
      77F073062F99A6C90DCC399984394E344680E77700772498F03B4C36064A9367
      834980930BA2E0035C1EDD660BD2DD81468C610F6FF07A807BEA4F4670A070D6
      FE846E5E025E468319DD8180CB814EFA29DC998F3EF804AB1C668B0F4D520408
      5EF8E0E7B7C3DBC1751A2FD22C0EF2C1C887E3080817011C1DC49C104EE3C2CF
      1D98161BB5FF6D7003883C99E793308283E4782DA00E78F881182DD3209FA549
      9EC39E0EC26892CCFD919F8FA278B9A00307F3710678EAC68E3A7F40C2E3E0B6
      31C09D0FD23B94A471E7E5234C24BBC50F00FE7816A4013D8D8FE026A1A58446
      0B263EA0F80836900EB0435C25869FA20F70B816F17294CEF1021A72F03B1B6A
      D049B088677E3C45DE13E7B7B9EF9C0B4B92873DD8677C1C26FB59CF37E113F0
      C1CF7AB6059FA2FBBFF9A4FC74FBFE6F1E3AC77FD40DD32100DC7B1A1F1BAA4B
      03DD6F233E364E6F5313EADF674288F26B4702E69302AD8AFC307604B707FF80
      33538824202802C5A67F8778F481CCFBFC17180E60313E81D281A02F1094851F
      2D663E7E8897F3C184EE1E244B4278B21C360640EB96590EA47696C36B623209
      2A690806F44DD9C6A974B46CBAED4617FE82020D940D56077A45BBD4E5121D37
      F82BFED82435053E4C02B80F44EC04EEE241407A088D2FE3A1FED21E8CF064D2
      73F1C218225EE020B02DA5290DB1CF26CEA8D52B77DB1C0E26AE87DEBE566F00
      B0990DAE4196004EDAEC0021CCCC450E50E828ADFAE7999F3FC91CA0C00EECCD
      ED8B71983BADF3C6B9FB9F88CC408278EFFEBC5D731FB66B75306A766A600440
      21187D12328707DF2EA7131029328104CBF264A92ED05953EA8FF743155FEC27
      5FAA1147E14983B167D274064F86DD01B0B73FD6EC48C9B77BEFADA9B8DFF0D9
      7B6C5694ADDF227CFC7E9BC43BE4B52A30E2FDF15AF7D99AFFB7E3F69C33A779
      DE74404E228C6D38133F8C9C3C71960B94159D14742A10C19D9B192802232450
      70261C94DE9C57CF33E718E406FF3A7370516769C07E06B8E3D4990728CC4D4F
      766CDF61CD7D58F3B32C0BD21CD40F5A2F4811BCC07419E39977DEBFF8E1F5B3
      8B17CE9B77CF5FBC765EBE7AFDC279FBECCD0B271BA5E122DFB1251DA7C12249
      F360ECC0729E87196ED809ACD1A7300BBCCE37E0C2928913C4A3648C9F498877
      E6887F704706D88AD40BE49E28C832274A9205A1C528F5B3D957B2E421A84C4F
      01396FF06CCF13107B9D21685F499C39E3C401F1D301ADEE1A97D9690DC3AF65
      235F0753D815E7251EBA911F3BA8E0C0F9746EC27CE6349C2CFC67E02C418C48
      9D2C99070E286FC08000B7778DE6D6ADEF97976F7FFAD5B9BA78F923EECCABB7
      2FDFE11297D1D819C26A402382278E5E9283D4F97171F4B5ACEAEAC565FBE9E5
      E58B5F9DA31F22FF2E48FF1E2737D951B13F8093414658E98F46C122777E7EF7
      EE070709FF3C007DE46BD9BE619A5C03EDFCA3CAA03C6250D519B5EE3BA5F361
      E6FFF13BC060B36CEFE9E6E7E97B2B633E9E3933DD05FCC8670110639F483699
      E9FC319271941D9C69F8012F034D10620E94DB9F065F09E2BC0FD0D4E5BCBA7A
      A3CE3B9D85C522BA4309248C7F03559BD817C9205FC9AA8E9E877E944C9DAB64
      118E8E88851EFD9CA4D1980C5947CE7769B25C6444C881BC7D08D23B2743CA06
      2B6683D58EADF3F0E07892007B718677CE18950B3410E34211317F0A41E781BB
      9C3083FD02AA06D4FACEF91066E1300A8841815AE2F8B285CECC277C1D06402F
      325055687B81E6E35031FC36F5892EE66910A0AD6EC720510387392AE44A4E16
      3103BEA46837BA73C8BE050BF4735CE51D822070FC08C4E6316C7CE0A768FE42
      811AA0349A857008A688203BB6F45A240827B479936404C2D678DD26023CC601
      E2071E76382CCB1C5E1ED053A3254029CE35BEE09DD9A903DA73C87C11E4ED84
      D87F18C3F1A0D150D398C31B502EB8DB3128D5C06804AA06E2086B0F19CB6DF7
      6243681DB93723021CDA381F22352073003B37CD36477E16D44E17BDA49F39E1
      2C07B5758E1E0F516D48A1BD3FC81FB08457710E92790A67FF1FCB300DC6F782
      3E452ADF7F39CCD74961710A8D658FED493FF8773FF891F32DA9757F22381E03
      80471FC36F81D2398B64B18C60B5E3600E52C229F00B8105ABB8C05932E6ACFE
      782C2C6511248B48B8CF220D2680AC4047E7FE35B020105B82B3643201961533
      C536A44B786A4C961EB8FC830FA43C89CFBF10EE3DD0027D4F7B2F2C661B16DF
      86B5F81E086CDE6AF9ED5FFE781E1E3C03195F2FFB088ED468893CA83893143A
      01A712D501106EC8513F26C1464B43C12DC8516114A883F68AC4A092BC43A69F
      180FE5224DA6A93F77C88F740E040284C760748D4716C73A7A9EC44F72B114C5
      397040B2DD06E323BE6F98DC16721630F918F9981E7CB244C72A8F9DC9F3386A
      B1C4F20A656CE778188C7C34BAF181B8819FD88C3C3EF952D4C3DBCCB9F0BA35
      E7C2EBDEFB5C5CA1571D89EB05475764FB733CAE0079AEDE5D284E251A5F9E2C
      9C289890B61403FE25932A9691C9F3D88FB284EDF38075D785C668DC08B03D51
      2A352922C0E608F98109CEF080F9CE0AF8354A6E582C7C9E2CF14D175138BADE
      BC407E5F51FC41AAC30B80C8169407D927DCF99B308A449DA36B5AFBE7308C42
      C153BBF2733806915D500247405A4858EC2BD3026C6AB688428CAE524F5DA2F4
      EF1C2B851280056AE40951DD9B3503627813D3E434C8F2046478C633BC85700F
      7108DE3B05F56DEF29D825192B0E0FF6876C3D13038D13203BABC8D780AF1522
      84C6B00215374D569EBDBE72FEE25C7E398AF280B91E1E5C5CBD7F0DD37DB9F9
      E992A9496888DE9C6D01FD6573F30BD014860C8768B54252A42C68D741B0C864
      69E46A4F9379C958067F3354ED928C9C48DB5AF9765802A8B17AF9E6D97A0800
      D4CA95ED51C62140E2194D03042C8CB48C45303D451C176916D5627A0ABFD60D
      21CFED3DC9FFFF9364BE5F04FF9F09621B865E0F61C90F24F9082E25856208B5
      18AFB7627C1402DB3875FE42E87DB6F1B3FAA5B07F874C193FBE72407599077B
      A4AAB1EA1E83EA942D17E8E004F1D7E1B82E149E874B745101DFD2A039C7BF77
      0AEDFD511E7E204B4700588FF6C6599A2CA733B64AD0134730F2D09907F15229
      08D95D960773BE741CC2C94123C41A0DF14489EFC4396FC2789CDC10F27F087D
      BAAE26C52E491EE3DD82626114365F7DFC3634AC7C00851157BD48D981954CCA
      2A4B8ECF6A2B0D2C3BC9797D3C282D03758AEA8C4E794D0435C747034B801B9A
      2BFFD66BF2571C8FFDF41A0187CC08E010E155F88EB14DE81A8CC7ACCF3C87DB
      9C63F5ABBA5B1E366FE6171AEBC7D78BCFC281955E239431E85EF155980AEC64
      10A3A235A6ED759285FA85A1A056017C1BD4EB71503063DE4A199EFD30B854F4
      E6CD83DCD294034607FF06A01263A01D0A2480F293281C219E47C932DD376A43
      56C81B86893A6D5ADC25883894B415A08511CD9622C0C563840FD3814CEE2467
      25C98C181573BB00B086E887D7A797E00F4728FBF4793B3CF8BC13C7E68628AA
      186FD1323A4FC6E124445BA98CF3949F3FE1F1F0C96224BDA4A19F719C094146
      2E668B60C4635548186254164E6378290AD01AB9D035BACCEC113C9080CA3527
      6F8F18FDB35CB3589A43C50A6B46F6D0E15461A862C3BDC1E807787A3A8D2448
      8D8C6E6114E6773886BE3F4F9248CEA83C244635381FC072D85007EC6718B21B
      32131B2D6FCBD50CDE7F4C678377884F97FEFD198C72BC7262B4BBE1E75918B1
      77A5D8F3392E295904F16925AADD0C64C1643C75AE181412CE722A0248CEDA29
      DD775C9AEE537372276A1079BF00A2D077ED713CF81EA670F6FC8757CC00F6E7
      049698DF24F2A7E84303BE548687294A4A9824605290B23F10B3598D68B3C2B8
      423F4C401CC7F091C303B4A8E428BFFD870360FBFF14562ADE093F627E0008F3
      CF1CCA940736380F73890BC83882407077E4B330080A724693A3A8F384A47DC0
      ADB2CC87F36026549A22A07ECE661D250BDBB3403871F4BD3F1F2ED369901E39
      6F4091D89FD3F0CC29D64E4B3FAA096C112B4C8DF7D0500DCF997BC82848F151
      AB23F58C4C32C7226346772742FB31C5805263628043907DB363F1855F3C696D
      BD61F24F4C5A7B9D203DF927D1A51DDB9CEFFC79F03A8C414300557891061920
      D1AE65BF5DFA1F762D39409496FDA1736F92546C44611ECC85B512078CE36084
      091C69086CF2F86FC43FC70190ADB144E251598EDB9C644A5023278168C87495
      C6CC80FEDD817C904BB435D14A8CBD36AC6D1CDD6379EDC18BCBD7CAC8B93FE8
      57D877274B92209595175103218282A84615D49E2442E318B8F00D6A3B3EDF7B
      1E64910378075C35D4FA6038D706173FBAF1EF48B22C8FAD75337501A5DE7932
      5EA21E49569321273C29B3A8EF1C91ADE408F364F2C2B842991430729852AC06
      A623CFFDC5423D46311C2F6E6F6F1D4ABC39775EDCFA248046E135AB84532C66
      1AA0EE1788A8300F7C90110AA15CEBA7301EBD6EB9C08F5EBBE91C21F88EF4C4
      8F1B0DFCE5E573D64F5B8D7E474F5BEE393C708E5FBE68C88D2F5EBE7C79A2D6
      E98B490B2794878571F9CADC93225B104E3E6897F8AC93A4B437F4263D19B4C5
      D3AF43ACB613D04EAB1F4F6563D30C884B380DF34C494E0C4422456FDF5D51D2
      4E1472B08D4F095963CC4A9C03B4CC57FBF1DD1CDEA1775542FF7083D07E8E04
      0AB128639BDC304052C661372483A1565260DD84736494F2C0956068038E91CA
      A1688721B73A299D828062E7DD1033C55E3D3F2562FA4472E6FC6285616CACF0
      1474A0FF41D0D7A8047A16F91C8A3CBB425F5983A62606CBF9A973FBE5378991
      D1F9CDC6DD8067AFA86A13CC640B810A001A405ADA6CBFC0203E5E8453782031
      6107E7A02C287A3795DE5A21141B87C00F59B01C27DB8000462B207A6808E0DA
      0CA42C01848FA04004115FA7BFDD032A427F303B3DE387D13889044A0404C92B
      232264A29D60B649CA2C637F8955B400F0DDCEFEF17763ED734CBC13BA24DE3C
      CC4D03A1D19FABD38A41E780BC1B8F9B7AD7ED20233887F1B712B146E13B44AA
      73155FB1922AFE58C23249BA9DCD4F1EC427CD10D459452BB6626A74C49110E0
      EA00D728AD161DD8CEFB8024FE51C05E785A7DA6305CE51690EC62CA2D2CE611
      09BB247E7C7719DE02F59933DCF86776EBA7EA0599A65D5CE94FCD73F560E1DB
      0A732467B58AF0B548802E8A7A13DF25203614551D7C991CBAC442B24B464972
      8D72D09A39E21BE7CBD18CDD0A68AE1F05441F4B49EFE4F893A47935DF6FE149
      F484859310CE01CC638E0542711CAA03C291621943292503668A0067F1507296
      8D2D600863BDAE707227D6A6F88E449223A9307AE47CF0A3A5A2DAB49785E9CA
      92E6038DC363CC59B9F0C98BB23FD4B9BC7CACC28AF53DC5C88E1A070BC85C14
      11047D7244D3253AA11C8CC129E52C5527718408C8AAFE109156227458A6BF78
      7FA10DA324ACE021C10A0B701EE8B51CE9A80F0CCC8FCDF1342ECBE93030BF11
      C68403CE7E2F8CB749830CAB87E20B500540948F9D36E8378A94995A644267AB
      44B9729F685CF1AC07EA0056472905EBC8F176B0A6027B0E691E1A8E1520F2F2
      E16DAC5A9DF29995179FE22733949B56A8A970E67C727F44AB2D3BF6F99D2AB2
      74F03B4A63833F887ED1DA457336552F0E3FE50D86954BB52D64D63967674E80
      A800975EE6A8B20DB18802F00845A524965569CB8A9A22F9554017142A2D215E
      075F139B944A6D88EBE7006ABE050149514B9C284159EE74D670E0A3E77EEEAB
      95D3B90E8E185B41E95EFA1167E5F040203ECF887351BE99CC575371D8E7D5E9
      4958519D9205243FD8AE9AF51C5E49ABDA8692F137522A22983B20D338CC703F
      333A2E23396EDB5BCF6B3826DB59D398521049F03071ACB08E335EE311A48B4A
      66D9DE5AD1FCBDCDB5D252CCB50A0157342F45EABAF1E55D7C33F81D8FD4E08F
      CD0BAB7FE3C32A921A05CC14CBB3D2CC1BB8313C434E48663CBDD1482A952D09
      B8632D57D91FC10749F9224DD0BFA1C388093AA906543DEF1D2FC9BA24291B62
      9A0D52BC81A3DFE6B80F5CE900B7222B2C7B1C0741766BC52A8C68E68B1F7E44
      F7319ED40F7E1821DD154B0CD5D92B340714861628652D173C0D34041B86DA3D
      3E03CF0C6912C12E7226489E4D6F7F719D972FA2B729709340A8851FBF08C253
      62BA210739A591C457A08D8E6A0C391D669D3892796BCB6A59A43D7835C7387F
      8026D68A5EA27A41A54E937180ED27F6CF6AF8860FAD786A548A9CB62CB1219A
      047FF1B8E15CE3A969FB79F6F6F295738C669EE11DA832409F51B94C41FCC7E8
      66B95FA8ABA40764BA2E9A8A0F2BB6E0187D795C2C2EBF09384C9307CB940D1D
      A641AF628BCB099E088A22737EC0C48D649939D26384580E3AA60E0F50F71B73
      D53D8A7083C5294B16D5601B218762ADD480089BE0C3310A79280869671D2D5A
      CF593CA3A2AC947F93E31D61008BDC517699197538D08B4AE1E2F5E3B1ECAC2A
      F6D0AD120F3ED2157E25B740AA8F8D223FC3DB60226A330A350BD6249600873A
      50E8C879A56B91ED2D526A9C4C2263ED9AEA09D1229EA05A8D45FE30641F2BDB
      63F002B9005512272D4269736B61F3EE72EFD32E0F0F2E6987D49EED0F1DBAC2
      961B646530E25B5610D7A1828B531F6D4C689D123CB2E17A9570BDE6970ED73B
      3CF88EF983DEB933A136B8C56229A7780C128BB0BB2CD0145D3C11CD22144E7C
      8A2ED6208D61A0B8F089529800DC9BEA0292CAF340E596CF770C1D0E0F7E7AF3
      EC396A410BAC3DCF189DDF2D02010E9966D3D4BF2B305D838BCCB1C12DAC0371
      FFF2FA2E0DE7AC65FAE846E2144C36CE319CC548A78C6B0533538CC3F1D1D294
      8731053914A78D623D30443B114B638955EC0A2C250E14B9F71AC45A0502DA33
      097D365F3BE75CDEB6854A17247B50BCBCAFB630CC984DE2DA776D53807CA77E
      9C014A9241FA7E3B53414F39D97284956440E10D5CCE73CA690C59009AFA4B38
      31EF865108F2467CAA9D934D964AD4574AD30766C1914FA57938D4682B33D304
      E7988D475918197A1C65822CA1616E4AD525C893300E648C05014E39EA920A57
      C1098B9694501CDFA9BD33E0E31C2B98488E059BF4CB007A18FA6E0B791F58BA
      F453E87BA29C54C56F5C0B1FFD05D1DD2A9EEF81FC53659786CBC940525441B4
      F0EC7A6DCF3926B9FACC790D9A7EECBC3A31AC58804CD21E13D3B497D956DC09
      A3C5996882DFFCBB9AD97F6C03A96E4840DCF4FC1F38E7871541CB542984F2D8
      D8D0EFB1F35EE693DE56C26BFC02BFD85A7A8EE5287595FE744E279485AF214A
      611CB84EB11FAA192BD1407576ABA20F25B6AD20B6503DA0BE3F5EBDEC915893
      0A615041A8E5D12972A66AA728C6954A0559C178D84B8EA3B33F1368320B3A7A
      BD37B446A3214E29026655F0A09590D9003D0066A2B6B62DC514D7CBA1A90BB4
      610B5B430A49BFC9F7AF8EBA5B4DFDE0B56CF21E29E986C4738C1CFBF2058752
      27D198451F3395AE7408F8B46078C834C6436435F68AC6DEFAD21A3B8C3F0C47
      20498058D1D9B1DDC15008A4E56744BF776D72FF0C405F20B835766C6A633F0E
      33999BB763730BE269B4B393032D6F772137415FF98ECE6D1A808418EFE8DCD2
      20B8E6A935776C6AB3653CF5D350416ED7E808B0A028DCD56DFDCD5FF8BBCB1D
      4065BA09A63B0BBC455210E15DC33A54ED96D3256FED0EC22E5D6699DE5877C7
      260772E6EE72B0EC2618EFECE4F2657AAD27D7DA33E5EEF28555E31EA3C6B5BF
      B41AB756ACDE13EC558E9F56C90DD4ED58947E0C4A77BE3C4AFFF9D8BCA336C7
      E7E47FA4AA6A62B4C6402F8DCF94E7C3F5DCC84CBB3FC7FFD54AF62B55BD9B19
      EE320A60E376AB1A60C798C10997949F8C13DC5476938E5DC353E3F843B8EB04
      B39FA894EB9D0ABD2D41DC3996F0DECC39FA913C6EA59FBF395A97F5846E038A
      2D3F3102F3D8FDA10B95A12304EB001A218BE807E1A08ED56928FFDF2288D999
      EC739959ECB98020400FC8C6BD0EBF8C16CA49F3EB363C0F5930E2D445A9384E
      45E1300F5895D695022FA1AEDFF611CC2FB03BBFEDBB1DF8D7ED353DF8E3755B
      3DF8D3EC745AF0A7D5EE35E04FBBD5C75B3A2D176FE9363DBCA5E7B55AFC34DE
      0247A84BC334FA7DBCC975FB0DBCCBF5E03EFCDBECB6E8BE56A7DDD9EE91DA84
      87D1DC4C81A6C8167F43E7A35CBAC61A8F49FCB70EFC6F5FA80DC6E617259829
      96CD996353F661B08562045BF4F4C2D44323F6FD982B396D3E500A91631BEEF5
      F8497E2AC133406F1123B8F4B78F2995262D35B6ABF0F652996E2EA884CE6090
      EF46814419184E70A0C1E3200D316380D881621DD6018AC208B14905927D39FF
      AA949A6A372851074A6A802B472F98521E39C7F0F188B8B5564EA8027D21B24D
      28F6C90C85D0B8AACBBECFE714F189F529B614C6137DF3EF6A4AF591309FDF9C
      FB5CEA717391922C0FCD12E092634A0739BB0973AA2E6E867B1801155CCC9FA2
      FE8C7A63142C05BADA7C41E09F06E5D412FDB416E8364FE3FE1D2350FEE31CA4
      F3ED84839E16930F55E481731DDC116E15A190AAC854B6720F052162CC30C7CA
      58FA75B012D1B36F04ACA653C5DAAC2CD233AB0053E5CE54EDF182AA657292B9
      C4618A9D84E78A78E98C1F29E75BAA636A72ED094C092BFCAF7F396A35CB586A
      96AB581C6A16CAF49803C98EC9A4F9F25D4B6283DF753BEA065C2BC583C9F1C8
      A9E042703B0A808C88AC7B7E62CCA7040C8E2EE350D7D5684B4A4FA3D6CF5233
      05D7479A994E46A634320A0293ECB1AF2D08ACD03DB757E3EFBCD042B651BF41
      D2E8CE9DE07C7ABEF1C973A8D4FF116160BB4BE1922B846112ACA9EA66FA0E9E
      BA2860F941A3DF38C8C2D4108875A5AFF507FD46FA698499C98C73466F92A219
      89313CDEC7A6E34938A2F0C6072815BB907B014821153CD2400A3069C3510116
      A3A46A116C3D9266E89F47F0F69811AF4B1ED9175E5C5EFBE101A78694528DCD
      2CE335271389F0FAE863CA5661845CA4C934F5E75249E358E2D21F260F6F4F1A
      7E20F3C10280664EC497D3883E9FCA9C10A1E5B07529D6CCECE2B4D878323B63
      FD878ABFCA2858901152C07DB8CD68A0E69213D89CF1C2EC6EA48730BB32D6D2
      24295FC45222964C23B409A4B24A151A61FDAE860F010AE8C19BD79D9828973D
      0115B29E9B47F0188F136AE446B6D26AD6FC1AAF42BE2E034E38C3344A86245E
      1B12E231C2759186494A7DB33E04698DA67B6270912DA4EF6C396D670B3DC631
      E788A0FDD0A93F500E28D95D16AAC6DCBF5022D226EC1E7F6622D21610694D66
      D626C05D24262169401DF606C51855419C7AE59D6EEF606CE320A37B958A6FA6
      455E66891222AD53652ACBCA30D687A2B23092EF09D20AD6EBBC3315E4AF4C71
      FC842ACF0B3D658724685AA3341C6A0E3DD9024DDC722EBA569037EDDD7A9EFA
      D3241E2669BCCD0D2BAA6D5336751E82FE73775A160A3ECAC3B9406FD9C0431E
      23C5984974DA3C4F587C730BFFDB0A63C6DE7DCCCA242281D1943BFC1DAFB681
      39299713DE3C35C6956E63A122836D7ABADB637CF15DD533CB0CF0745B871063
      AB367FE60C1D850865841520A9DA734B756721AF39EABA51C0E5EB1AD9E9274C
      71551FD4830E53A3DF6C6C5EBEB2169C83D7896E9DB82F861BAEF6B8D239D289
      033FAD29ED48B15E587E10DD9A669953900BC4924EEAE4DAD28436A6E9F1848E
      23F21478BF7124834300CBBF4E4B85387449BD6FB8DCC64ABD8DD2B36BE487F2
      006E31C0C55D1A4651382A8F40D512569EECB41B0DD739FEF1EAE559EF645F0E
      D8CFE855DC3C1FD876D526F41BA80E04FA44ABAD5C297E0F14C19EEBC7C72A36
      1ADF341ABF3ADF16EDE0B1BA7D907EE3FC224E3839EAE79757EF5FBDFDEEF257
      396FF73D9DFB71DAAA6AF826F6669B7A1D1E272CD442FEC75387CA90AA62A85C
      A726C98B8C0E7BC03EFF80157ABA7667D79C24E798BC4A6ACF4FF6997BE9EA67
      68EBF7B7A0B96DF570B12789421C433A5D8EAA6CC76D7E8A2A75968B6D8C8BB5
      D67331C34E1664F35F9D97689891BAF0C75428FE9B67FD97BDE6B72F5FAA23F6
      90E13EE7083F64FC4B723B4B1B883DEAFBB54A05364F03D0B0F15FF0BFCD1B36
      8A486438E7C45C0D1BA125087F0A4170BDF527EC62F14E8EE75590E570CA1635
      A79828C5F7DCC9FB79B17D5F902FEF686788D7456BEB991F8FA33D22536CCB8A
      560150F4CB4B839B34CC736CC750742C23040394F231661F8D55BA4E24F611E0
      A6EBF3907A752255283A0498D57DB9793107E1AED67454C6D54B43AC3FA59BAF
      5E5CB630B25755FD7DFB93B9826ADE0E7932387193FAF748FD5E18A4FDF4F2F2
      850407B78A90281966F321AD8B68090BCECEF3DBFB85BB3CCCDD512C4BE573E9
      EEF12A20348C6167003246176BA6EEC6CC4E7457190104427CF541F6744701D6
      6A5790DE34BC0E0F701A348B7BC3EC73CCF752FF4261C2A92A63AC9CBC1B77D9
      8264B405A11D66BF8552E741166D7EAE3A6CBC541536C7A000AE058BE4423797
      7FC36DD4B32097B403EEE80938380FB9738BE1B43423144A54E173CA3B3C72A3
      B9A6838F0FE8320F54F801AE38EEF96E5479E83EB6CAC3638164F44EDD0259DC
      B15DF764D7370CC41FA999EC2A083713D77486E47103D551F095F7061FDE5C81
      1F5C729A0CC077131009423F729EBFBEC0E30FA38CD161A6CEFB9949D1770C07
      5ADBC1017590FECF4FEFB788086454FFE97DA9D04ECBF9E9FD8EA0479B617B41
      F16549EC5C44CBA1EA42BB792CD9C60A3ABC02C5F630AFC46CBDFAA5A7D73D97
      EA86F159DD14F7406B7A35513D188D9EAF86544DD9418C6366230C8E3F17EB1D
      0AD62CA863073DAA6642F5A8A84F1EB658CBF222725275CA88B0D9E99DE96764
      D1A778CCE8BAC1AFC1E6E3D21C821ABDE1486B364FEAE42F96D4641B264781AB
      612C0D96F0FE21A0C1350858D664801D66A481A20ED777C6C08F92FD496062DB
      C1CAF209AFD55138D65912721F86FC965549CCFD27233165B0FB29E6F0ABDFE4
      8CF95C9F894F4476EA1C8D92C51DAA09E7E7E784A1476C8308E7610490C78E13
      44FDB393C28C61182FB44543E90AAF748B614EB8F075DF5439A0726EEE92A534
      22AA9C399E58B986132A36A3245ACE63060999E3DE1149389E865ABD216B090C
      E567D82956EC258B24A35E434AB1214A7272AA7521FCF49AB5A2E349597B85BB
      C89E256FE20E9726C0B9703FE8BCF357CFB16DE624BC357526D5574D6D810451
      0289802562376486504C05A524AE99829E2A9D66DFC8F3A4452B3D4D00C5FD98
      281A827EBE9F82390E70FFC60FB263C3D9B80ECE24F5693B3A3700E849CE59A0
      C1E89A42E40DBB4281F60AA04C6615019787F4AF946785CD4025C78D7E27F358
      15DB54C13182E02FE7BFEACEA0C0897EF9AF5F75159CFF06A425255B9547C38E
      F5AA5B39C5AE8F31BE1FB46BEA4E5799901AE579B2C4E72F605ED7C8AB2EF234
      FACB8B98D26270CA3C4FEA59976BAA50B0232A3B56AA37308A12497564BAC1EB
      78F777F54272A068EA7174513DF1C0FB020013683D3A008FDB98AA434A66C3BB
      52C67391ADCEDD92E18C81060187EAA93E4ED2A090ABC5618D38D3A6708F3951
      CF7369455B9046EA7F3B0F3096F7CFED6DB5A3ECF31D792200F64F2E358C9022
      E936C1CE2CE166F11757EF5F13B4C78C802344C027FBC2629F110A2608ADC383
      F873A15530412A9C77EE48FD26A245133FCA0A04679327CAAE9C0EC0ACE39407
      56A5CE6641348637DC30BF2A5106266ED81B6991174EC1379214037F9DEF8014
      2FD8707F0CB306127D17052752BF402F0F2364BF58A59A1D3A282F97482B911F
      284BFBF97496C036EC5DBB725977116AA9ACC5D890EC8EF3598EA5848B083D4B
      20308457DCAB8BCA6F71FFC13BD5D97BE68BF822C36B0EA145C309F201EA7E26
      6351014D6336DCA3F5D41C852E6384DA344E0C82FF8267278782F830F33E7EF8
      C75785C70659FB47E7B5C767E2A224C927D4BC13280B11966CFF0E46B17454F0
      9D099C8A652A45D534E1079CE39C7E29839BA0F611CEA5920FDE364DC8C78B87
      C989403B4254C72BA61AB200C9B3D015E075703789537992EB2CF719C02A5364
      BFBC29A7852617DFB174C5B3A56206370116A5CA244F826B1DF34EE3D1C06ED0
      5356EBB8C7BD64909E9222C23A09CAC6B14FA50FF4BB7506A0BEC47092DE8239
      BE944143101B0529B94A8FD1467283CD80E2E9890E882209D997A017A51ACD24
      AD7F188C7C5DBE830ADD295D4AC004AF3D3C188D92659C6BA737652252A5824C
      19774ECE9D6FEF70545A943467CE8C518880C509ED22C8DFB03A10AAC3058AC2
      21957398002FCE41EACD859BB2122BD355C50B514CC5EECF240088C6F901455F
      72EDCF38B765B958033FCA8BA43E903355A64F2055D4EE134536816311A2A027
      D62C865C3126681D30A0D4DE2425074B08C90A3226CF1285902511FAF431FD12
      A30EA41C063E545DC14C276A1618484A0A5155545DE78B1C20E87F08A78C505A
      DDE7F21718FF78C78680A397A4F89246814FEBB91D9D1BD29224FF921D039F5B
      2480AE1ADBD1BC87C80EBA10558D8C99658420D21D1E4C150C7030A0454F3231
      25CA9C8BAE945AB92AE043084730C1EBF83A5A0E055900321B2FA5C933A8632C
      5244BBF5B1C5D1F99EFBD768CFCC992C047E268DC2711544F52AC102A77C2C03
      65C841D552362B4FD41E9636F9F0005BBDE34E4E104F6085FE14CF1F8F432B28
      3611C6208CA3438124A4B2F3361F4F1926F9A05E566C73FBC3147F5676F16111
      414726178A0F527CE55474FC5A80E9AC1D390FC5553A10CAE02826F2581B85B3
      D59110C591CFCE132EED4371378AFD9906B8E21DBAB653618F3C75B2842C1C48
      83C721566A842313DC2E54F9CF301E87C03D51F42D9D1BB159862997FB89F3CC
      B40F510507A105862D0F1F24A7049CFC10A3BE42127E55A2857E8341CFEF80CC
      CFD9E0CB211CCAD2446451CC4C48313FF800BA6164CB291F1EBC8811104F9F87
      19D9E81062EF0322AA7A0BF7E7E4726511A32295D436FB89F05121269E243651
      10768F0574581F8C805940EED4142D413C5EC6DAC2008C4861268A11C5799180
      C69B9214BBE2E9604E65F1F7E0421573D94F74155F4F7E430DCB091F457A3154
      B35854FC52955BF4CC3A5C10A7F01378DA155CF22707EBE4555DF639364A851D
      5D94DF7E7E7E7E54E03D0E7678503964A7F84EA4CE3408D9F6DF14F18FEB04E5
      493242D153F822BB00F8B515960AAFC950D86517B9691F8FEEAA6E023E79D8BA
      84E2FBE2F2F97B411D4C4AC5FD419B40437EC6626D9424D77498738362F8435E
      085C8C808DE54E539410E0E18707A2A01D8B7AF21784BED2F54ECE9D3A62C485
      51D4823EAC9026FFE39B706A6864944581DE239FFCEEA8DE54F7410AB0566960
      98557641EF316D0761056B3CCA55BD22941C1E4408835C9140EDA322553841BF
      CA709907855AA74027128F34A9E189E1DEB126A70414760A15A563646089151F
      526DB59CA188FE57036DCE9D67A489A19610A67385DACA91A3D1A58C6BB4EE61
      A095102514555048DF474D720E0FBE98476687687805447B45C057F0034F4D56
      F47F32427B087F91DA17981BAC88C16F59ED36DDE7DCB1080FF7E1813ADEAFE2
      2C48F373AD32C8ADF304CD1C301972E3DCC42B2401A8D4C532CDE0E71F17CE53
      F5F939692917EF2F2AEF44555D975F3346BA9C8593FC2F3C0755C7DDCF8DF021
      459B893790AE2F3787130E589A48FC82D00F7A7538A91BE69CAC3DF01934FEC2
      2F8C9EE4F7176AC6E2E12FCDF3395D33CCF166B014BDB3ECDD120B8BAAC3A603
      A4F03532E5A2B5968448C964C8BF35A79496628119BF05A080F5ED6E4231F015
      0B34A2D6392EFDC6C7FE34ACECC4DA5EFAC287614B49C15CDB095F839EE7CF8A
      4FAF06F8FD4BB51FEC7DE9F683869FFACC7966B0C7B7EFAE74EC9C5644D0C829
      0E52D97A1DCEA3E90BBB47A9C6D7F98E6DF715475E9D39EFAABC5E85330AF296
      ACDEBBB68ACB64998EB06BF4B3AACC525D068BACDA605F58F8CBB51D254E8A37
      6E1682B080A665B2919B0293810D0248AE1F6B9467A697CBFCD45CAA9C6357C0
      08AB1EB211FD0C49AE09371D587A5A466D2AC8B19398FD8ABCB0CEEB77BC1874
      AFCA7619ECC164013A3CAB70D5CE555A6051747B650F9D2BD4AB0C6D50F73952
      D861041771FB000A0FFCE6737254AA00F31E9898E05563BB41F1F924D9775BAD
      CFA7FBF4F03D097F187DA8F138D3287F56F40DA7A59D5573C94AE5300B9FFD1C
      FDA5292A9A40198A28C09DD855D0F262E75B0CDF86E520E142B53C182D4B91B8
      37DA9F45A170188303620A3D05D25B7CA783F974D0270584570F8D14B5F78B07
      E4180D65A4C30363AC89323AAF1D4BFC7175435DCD4C2B49A6BC913C14322ADA
      356C8502237022E97E693624592A969D27D3A9D818C870205AF59C789516B861
      2DA380847EACD38C515DECC3E45B35779C27CB226EEC5BD9F2B28F78C8412E63
      2A18A136761A7EA0CA1818787A6E844A23C154060CB22FA0EF91B111BD0F416A
      E5E30A99EC7F79F9F88792A9EAAD98AA247957AB9DDACAC74E78E9D14755B32B
      1AB4F6A419BFC920C7F3305E664520D4C9AE891904828B529445C28447040659
      089A873170981C80B450654C8BC2C530419C2AAC83249F0C39F22630B271DE52
      FD847198FFB9D9385F98A2ADB509AE1AF7288EFC749DD95319FE8CC8F915B367
      9D7587BDA838123214DEA2737872CA16FE89EE9255388CB49D93C8A0F692D22A
      947BD4181F6DF755C7DF51C5AA8B769D521C3DEEC694323394B5330E6E308C82
      8C217A703239941EE4AC189DB3B0EF06D0CA56EE910BABBA723A01951218A53E
      07BEB6AEADB6012C06331C3599B078D50AD17030F814D85458F434C24A5287E9
      EEE154292E9ECC655E547B0595261553C7965910698DFA1D064DADAC5082233F
      04F58BE37BB8F7051973D4F163C9D4487312171FD904D6BF699C9082300C38EE
      122DB2753648E96A2B11C00156D02982967DAAD95F52B2F7F8C4BE90B8CF3DF4
      3A3FCB3884D7CF0ABF269EA2E2F4A0551E631F9C238A6DADF105576A12975D9D
      933AE7AF9136C92E6CF69718ACACEA6814430BA27A56CE0F2BEC474AB4A1D358
      65EA3E050DE9D42BDD3EA6141F68CFC401794BECA1F8E4A160AF92813A9B3C17
      25976271141443D18EF958E5151792E53A56C80643F28D7DC104901D42722A76
      A35C8E16BFD7E137D70322A727E0F0B6D0DC8C3959E10455CDEB53BA9619AB0F
      F74ADFBA3861CF6DAA73C8CDB813F8A9AC55F1A8EB4E9F5EAC9E89111FABE652
      F30E9C9E79323F1DC8549ED5689624342E6B8DA5C0DC25ED143B53D4EBC9ADAD
      D53DEDD55669D666BE93CD07A37C30DCBC4BD983FDA108C868AAAB2F9F62D4A2
      EEA8B24511D352C41D144A88C65FE5F4A582C59BAD4FB532D3E3DB936DD4C1B4
      27E219CC0DCB1394E17DB43F07C3C89B8F9D2735E0E0A8A739AC223C2BC26F8B
      6665BFDCFEAA8EC3C753E8DBE7CE850430711CFA98237A731A90D47DF2FC3AD9
      1C833C531EDE2B5595A89F06E944BA1E7771784BE11935D1C11C0EBCB2705302
      A8B1269EEA14C092BAA65E4AAE365C2437B432C260FD61795D5CD34AA24657D7
      1385F390796F116FB666C6680BE79C4AF4636993E787D05F23B97C0420D49693
      1D94964E1CBCD7A59DB9A2D22F84858B28F8B550498A4DDF1BFA71C5A7060072
      78B00E0EC5F939D6694C1F93A14BF1E1276B2A6B1B0615D57394923D951F8908
      15BC60CDC100793338775EE160F932E5DAFCDCB314CD9B992EC6AD2D2BF0F271
      EA4F757F78A64CBAF8B544943B23CC98118B0C453ED295AC141193C27B4A675F
      2908AC1A50B22755E5294AE22CD2048035372CCB0A9685238B89376F8042C8B5
      F868F88BCBE499A020BAF52248D1624CE9AE34E4FA91282DDEA83FA202BCB097
      1F1D5B5D65486DB4A8072A4F0E9D74FC2AB64793BEA00A91595A03B4463144F9
      9B21A1A68CE97DA12B5C66404546E0CAC9274E05D036DD1BE48C532D05D49BAF
      7C86A9D8E83FC183569220E8BD5CCF5F5EAE90FF7B2952C491E7E42E7F1649EC
      B9CE9C97520CCCE1D192A072ED320A430927A5A10D172BBD5713D258D90F467E
      26CAB50E54D70FAB322D5C9513338539F05ED515D037FAA98C2F143144731CE1
      9984F4D9F37DF08C8AAF714AB238B7F7E55C73D6FD2899CF39E83726A3167048
      2AD357D4B0104BCECC17E65424704B3000062117E521E00261E8B151D84F6E0C
      29273C982F1258DA5D5198E8C66797D832065959CE12C69962ADBD319760E088
      93197B784F24D5020B8128810023A231E32500D11D18B0BF58A80AB11ACB376C
      183823DC794EC0B804686D9C5A1D1EB0358D422B7C72B0C66789AA207EAC3FFD
      8DFB927032E0A9A3AF8FA35176EA5C5C6427A558492C7DCD51746B8035203CD8
      36A8BEF1B1D4F7E910DB349C8EB019D036CA7E17C0D335484A314DF70007C76A
      523AD5DCBF03041E454B2C13A3405CB19BEE31213DBA44CFFF8F31C50C39DF87
      717E04C77611F9A3202B04E923326A200A1C899D637FA82D1916D68109499D18
      C8454A7F2735028E13CAA393759DB00F8EC32A24FE1403F596329A2AC804028B
      B2D6B80D070310734A3A1D22F9861167F0D6428060F7C2321E4B40F3F7FE7CB8
      4CB142D31B4AB18E84A81391953749C00DD60681D5707808467A144C43EE5407
      E34205E4521A72A8E25274B5826586A53FA8B65CB55EC1DA217EF9AF5F15AC68
      346CF683F912C4653883C96D4BA275267C05AEA3A10B0E37EC344AF114CAC8BE
      159C4B9C24FF0CF4D31A70F66CB31284CE1B367EA9307B27E0F28E044C3CD3FB
      72969F21BDAB00E5F85B3876270A12477284AB599EC763C3009BA7CB40C703D7
      D63015D94955D59230E479FD661CAB385C2E9986E1EFAA52166653E0342D4EEB
      302C0049C90AB42F387C7850AA80BBCE2046163942433F0FD80917C667C4D229
      883BE12E6BAFB0C421166D17E92893ECC39353E725485FB9B4BB233C0D83682C
      85D3B08A010F5A8CC52598A8342A1C05EC0D6954F9BD342CFBEBE6C183B36522
      C26C46679C260B4E4647264615EA16091587046623596DC70159F5C908C0F336
      CBEFCF96532CD879AC0D7A948DC3B5EEFC691CE6B0DE13F40B8C8D9A83FB7CAA
      9808A9F83704E8FE1C285415D60000A4382CD841DEB57567AE5C1E85AC8B296B
      D188CF27720AB1066FE670E97A6C70CD450D485B1BA6817F2DE59FB86269C699
      2D2FD96AECC37AD4CBD0CA6FF1F4E01996CA94DA71FB83A0CF889E21B9628B21
      DA6354CD505541966162BA2646B3303044F923865DA506E7852ADFFA3A01C4CC
      8E4C7711376B4067F6471FCDB81D0A6B31E37241D75F46B9BA0D5F90FDAA9E96
      1F5F8D91AA8FFCE82A794366909F011CEA8953A7781AAF9BDF79343304B2599E
      26C59E915B2CCCD103643A6F94B24379046365155F1DC039D6AE1BD69C92383A
      3CB83B315C41E79270C00EB092DF2B370BD2EA074E1DA91A4E86393270545E42
      EAA18AC2CACDFA8892EA2AE6B49CAB4BB23688F810960B64512B56DA14F30938
      D8A3641EE8621171322E6528944B9B98AF67F60F82567878807A179689D7E63C
      1947B7C095216F40DFC5EA2422621429EE65D75751FF57DDC075686539547D32
      F50BABBF3E09C6C2A4E9FBB9139C4FCFD9CC6F14D6959B289A3B0AFC984A3973
      4E5C82956BF151B46D62F80421014D7FA2319ECABF72F975D8BDC3835C324024
      71A3700CD0E8C5A993C6ECC576C9469DD6050DE03D47134CE58FC27FA2CBF558
      DA95EA83C980F5EF4E54D55C78A10A2AA46D1F176EC362EF5471E804831CE168
      159BADCB57F19AB04EB709D71BDF98B44AFA2AA4EE02D7609811B92C80522E47
      F932C5B2BB62DA38A6480829508CFE56A3B2972FB6E1A2F098BC390DE640D9B2
      2A6EFBBC67546491CC1F599E24C4A5A9D8E912E9980ABA70AE8ACAD398C8B7CC
      A81E9AAF6D292A562D36D2CCD7ED4A704B899E2CC75205383282037136B69634
      BFD2CE1F990C8BB0EF42B08FCC47C12D26C523608D02926C6A627248007F1D00
      033962E01FFDEF258A2097260166B73CD38D92734CC5079964F2E8DB3BE75B3F
      0BDED3061C49D134B2940E935BB59B1211A052A68C881AF62872BB038E19C0BA
      B1FA8EE3BF3924E0731ABC73F1E2F56BDC192C623E415A3052B79E544E48651E
      45B5B953E72FA7CE19AFFEDF9CEBE02EAB961617F71D008EA3DA9F45D1D1A9FE
      F6160EA902DEABF8034A5F3A4CF7A8D47781EBC516074DD365394CC2FF94914F
      E59AA833A10A841A274B5822971550C53F259697FA0BFB2ABDD437EBE4E94DD0
      B9A394C54B378A19310BF4E8EABD95FC4FF23016792E8B92C7728F45C8F740A6
      661243C3C97D7B65CD2E87D16B5C5769871FEFDC9005284A2967FC30204902BD
      5B6A403F5A6D72A7EBD260D8CA328CC6C42956B640F72840A798EEE1C0EA174D
      A928FBAC4A2C655CEE734CC179477AD423F2DBAB362A408EEED0BDA67DFEC06F
      60B13376BEE9C02015606356972779A7E46A9298AB2C614ECAA14AB099A36B20
      DCC8027051DA561171F80F00898D7840059045CA3BFDBCD29FE01D53C775B0D1
      FB44003C957EE426640D16A38778BA8C8BE114852E16C2C6FB55A9D98891620B
      7E92929B7D0ADAB0B4C4A080D0751395165119E10E255A4C50D5CD97B1519255
      F60F0E0A3545A356155C5895832E7D07FBAC202E8250374D49AAC360351D3F8E
      3F7374174C009950C6087B79F9C252386D223D1219025B41829286117DD415F2
      7B2A27BB37F195543784DD98456714F46BB3F400C4004D85D45FD20498C1F515
      C8CE9D6FA5E98A6AB541426A4286FE37CF2EAF806A0D412456474D075C1832B2
      4454D3C864B67C82588F7D9BCC924228119F8AA4495C3DC2880C8AFBC37227C9
      32D5F97DCB186453C970C05344A71A85BF80E5702CB9044B89A9F4FF091D9345
      902C54CAF938D18DA97C78265828991AC6328E2C112F5464F1E8713893EEBB5A
      0ED760F671C34A220931DA11AA4571D4A62476476908B03613FAAA1832531EE9
      9E0350C78479BE2DE47C2629A877F40C7EE301B24AF9E907A49AAD7B296D7050
      7D2F950BCA9685361E182D72586C3E3C20BA765788BEBA90B11A2A76FEB1846D
      522D22F5624849B8DF72B46C9F94A27C749B225556C4C46CAA247F2A3B459592
      94B0598E12DC4630094F84E681AFDF42460E691EAA370D007CE3EB78F57700D7
      CF70785ECD9F2700E32D04109D3B3F60C665C06A18E3051C561DE7258D750289
      819456AD52123BA68AD85A451B27CE35EEEF0D8E7027ED59C738F1BDE795AFE6
      5820198E377B6099C49069284B526EF745A64DD1D9552FDCFDE19C265925D990
      BB568B57B1E8406364BEA22CA86DCE9700C6828EADB52D9BB738C7445AB124F2
      AA3C7E72A4092F77B3515491927E708F74B9BD2A015DFBE2D23D68B8782F949E
      EC4A645C901F1FF066ACDBDB348CCDA2944BAC3E105B58DAA430EDE0C9A66B94
      80C5816CC4854466A072FD056381377DD0BE2A31C7C44120C6DA61C1A6916850
      A62F0805A8B8716881C1EB39ACF843482A002765883DE144AE46185147DD0EA9
      8D10872DEC3DC5308A34B39DCE100FC957BE3F794B9238538502C8BF0C071510
      53C96534CD7E24E06ACB29DBC45F5CBEA17EF34C7A5F27239F0CE1525BB268E5
      CEA103515036787FA480C01EE3EC0F6403791F4C9C5F7E78FDDFEFBF69D0FFDC
      D6AF78B69567A0285C3DF81D6D23833FCE83DBBD890D3381742C65B815984E94
      29CB5F032CC43A1360BA82A41147CF3E3AA374BF7435032A02F3188F92B12AD7
      6C50F093C26C6FF646348D3E79EA4BC793F74AC7186337CFAA598DCE59D9D8B4
      C7A7E17B05F2F3B1AF2AC409B7DC176C473DB7562F02207C9E665402ECE693C0
      78A78C5865917028AC8603FC4BF9DFE298E14276787C83F930188FCB961638B1
      6593B579BE74517FBC135EE62B8F58E114C2138F592D913F62E3F2A6D5CDC1EF
      DF016D79CBF4A580B0EA9B706F503F50891E06EB40B4C754E32A5CEC1D99E0D8
      385AB938C97336C9FB73B615AD3F8D39694AE879F4A5FFB4B2F2CDFD311DAC92
      4347BFA35074C4A421E827A64792F6F041BCF93CBFE5AE176B0EB7C55ABD7F2A
      07FD42577B4EE27542F2FE60B414CEAE2FDB21BD5A0870CAD81A731432DB7AB1
      F218F7D250D774A4804453552A6C9F3B2AFD185E5C1E7D92A0511439078B7F32
      6013FBBDD32B2C0E1FFCF25390DEFDEAAC897CD9234B5C7D367F198DB4895877
      F8DAB8FDFB1FB811C80F7403F76DA4D09E49D88C517F5D17F34B8ACAC8A79598
      279D744B758BA91FFDB468B3BB3E92B56844CF514BA29B9D8AA5EE945C411B07
      23664BAC03E54A6D86470BCE673A269582DC389663156C99CA50E26697995137
      095DF1D1720AAF22BEAB8222CCA24DA5EE0B4630D3B1C4BB8613E7E2EAFD6B14
      B16741342E176238B1548EC9DB2F9868FB2B47095AE2F6A5881B397CB649D48A
      CA6B406DE04F14E822F7C659428AA59D7BE27B22795793BE7571CD95326B8707
      D89E81436875D477A58028B9192546F2C798FB62D237D5245E9B9724D8FF487C
      25473A80BF70E01F15758E70AE2AC6B5EEDDE75BDA4304C1888FD1E64D116B29
      2AB9EE99B59C3A3F3E7F7FAA3C4AAFAEDE1CC1B2FFB1A4F85732C52DD814D8A4
      E0BAEC1450A34C8F257B54071730DA60C815E6337014166FD824647FCFD1B7EF
      2E2F9FBE7EF7EE4AC718C3FB3186AE146AACE4492637EC03E3F0E17265BE651A
      A3C83B718E2E31D01F514036157D7441AC631F28650F430874A9406D418175AB
      6A36A3641AA319FF84D39D0290A78F5E39E84877D093EEBC7A3277C8992EC1CC
      F812152DA2720D810DA7B8AC9322121083BD119A1C29C831F02C3528103CF76F
      E2E9128570AC5C41E57FB5289F254B6CCA18A63186B54463EA45C5ED13B4C74D
      3A7AE1ED53E921253E8B1813F6E153B664EFFC130C2B4A037F7C67465336CFBD
      73575A5EE97035B320E015C6EEDD2A57080C765A545241F0A0134E35CC362499
      B919976D78E85492884A3F2E9AB5AF3218D5C83B4947ECD1CD82221D593914C7
      E18770BC544849D5CE8C02319C048285E528D8444EC1F02E57C920E52C1840E5
      B255BBC85D3027C968A9C3A00172E3E5880294C2091122AE934CA5128A7846DC
      8EB91FA3471398C40C24BF630CDB0F47612E24F04EAADC28F7ABF1B351B80D8E
      AE905E757A6DE2F5E1C1F3D49F3E899F3CC7DC5CD8F99B59527283EC6932F6AB
      35F9D72A3CB71AFC5C6B5228C112C3E5CC8A8933F62D1F9BB236FB3D811C9DA8
      5AE1CA1E4146B798E2922DCE1EBCC1AE81A8A5A439303F92408EFED772BE00A2
      7BB43675FE6B41DCC7D6C696BEEE98CEBC8D0A4EC9BAAA0482C84268D1075AEC
      85EA57617D9482B96FFD0FC0C43290F6E60B1DA0F6B560E7E3C9EA4B38A9572F
      2EDB4F2F2F5F70198A77AD534CB4F049570AC653D52E0C3F623AFD75A63D0146
      5208C8DC8707200FA89656209761995865A125215E8F2A12AC597356FB1E62D9
      8F53AC72A16A39152FC742D49409310E6E8B706E2EE282ADC394D872EE1CBF57
      19122B82354B5C28796356D764727EE23C639BCCC5DF298A86D8813F0C29AF22
      9B2D2793882443900A550E9AD931584AC8826EA15C22E5E9CA5A6EA42935400F
      D37551F8E5D8513336BBF478A642D3A9FE520892FD04D406CACC08634C27E538
      E6D8D009DE3EFBE90DEB0374CE0B857F0CAA26A67A4F313882825941D433526D
      383B1DB48D09CAE6D84580136C51E0D531E7EBD16544E58BC38CF35530F32F1C
      49A4906C79A6D834E6308E35D9823B611B47094013C4D69CBBFD2A91D7B88397
      A726F17E35ABA5F08EC931E6185D0AAE8723CC714DA5B427C269856C4550FDFA
      6C2A7665504D0A98FA55198F69A104F6E321C80345047F5EBD0F308B9269E1AF
      719A0C30F1793BC157FE86145BE735E80C71B9CF08683F7590807005745A9414
      69B1B4FDE007E5419D2D73AA7223862FDAA174B9D82B07B3C40106CA5C8CC741
      74575D512294932A1D75F009AC315A24D3123C4F8D8B98D8C2E371C5D1A2CF8E
      51810E8B6DD3BA31E523263BBFD238F55688238FC7D58D78E47DA5082F69434C
      088F77BDFB3B1A85F26A926556AD0D1073DB45B86B419595C64BAA22A36AB4C6
      85C35DD0E5F4237342281968B4465547DD238C9736FA9FC2DB5585FB3CC1E8F6
      FD39755409A0BCF822AA1D0F001CBD319E3AB3E2AAF33D30F017990A8F948BD4
      FEEAD573F8718AC9B057331D548F558F50003901ECCFF38251BECA8B83968264
      AB13E2229FF238A90CE631C926FE28057EE76478808D26DC7B8DB214458A0DFA
      72DF5950AE0499C0F60B819F39470604C8C2AD5BE94A8C1E934F29205CAA6041
      6299E22E809B375456E52629F243815E8A154579294C410C046790E729661DDD
      263C3E3E4B02EAD19B008BD851FC937844CEB1C004A65E71EE45F54DA6BFC7B0
      7516EB9386A685A913F060F52DAA040ED7D34EB505C944155D0F82C358641A8A
      8B985D81B9028FE2951E4C6DEDCD3A495CF5482D4D5C32B581F784919F72C2A6
      F4C63069CFB974AE334B64A035D778A30612A7F52BB87FF4381424CDCFAE3329
      691007A0E554D742CA9EB10B1C1A34D7F138AC9AA94A39C6CBAA348DF6893285
      7CB6F7A96CD3D25BF52E504C2953BC53637B8D064CE46682199DC3769084AE7B
      5F1FFFCD7941A4F2128824364BF9517AFBF9B17117213CE846ADEF82D13506CA
      E68C6063D5E653AD04E874C9340FB30F45F83296A6E32ECCD912F0D8E20E335C
      DD5BCA8125E548979A572DB4A31AB4A23563C674285922986BA2EE54BD0A658A
      B26187073125894C39C49EBD98E3D2EB55CE74A8BD96C79565A42AF601589DE8
      A6C8780A2A31E3F35BF0459E0AFB0AC685CF630D8E105829852B5B3997C44A1F
      42AD66AB7464F550B2DA88A3CDE75CE98C465C210A99948C41488A6ACE35FCC5
      99A6CE7611B3F95AEB755531C264E2067488CB633ADAC7F8FABB38281602C384
      D8720094E59C730E890C5426CE85BE4A5DD4CB949B1F450F190B255A1A978055
      5DA6140B8E0005D7641AC49A670411F8F02DFB5A7DEE2A98FF806F7FF6ED39DF
      33053455D1AF78178E708393A6B21C537494A2630C0360CCA739F31AEB189527
      2214ADBC5273DFF1D0D0F1308E0477347D268C02683745E7F25E529B0838B4DF
      C82DCF715C9EC4A92CAEBCAC15A343E06721FAC80CDBC31409589A2CA7B312C6
      C2713586D7358D9923671FC3F052C524210F0AAA95552A2772400DE1CE867767
      3A569D080A5788E54EB4CF4E15FD35AF1F1ED02F8AD417BF54F6F767348B519B
      0C89CF44ECA99E458D2825C012D592CC4A69D7973271A2BE1B44284C50A13D67
      DD2E7C9CC351312E4C1235EB612D53D22BB13F83AAE59F4A3CB65024FCE558BA
      73006E12F80459AA27FEC45175A98BA25B9458BF504755BB7771D812B1C3B883
      A24C2F3C3A594608656C934347372D0A1112F92D0D254649A22D40EA543BDCD2
      B2440929FCC245EA6DAEF2DD95C4804B789273367D320DC84786D952A3C303DC
      51C5072AE313DC34D432B6239BC01082CAB6642A9E278317114C650839C76FFC
      BB52883B835B041DA15E42E1CCA6013A48D024075960AC5E38B9A33383457211
      BBF7F8DC06DA1D28490A7011631A749D29A39849213FED8F4645605115113550
      FCAC0210A3EE0BEA4180C340E302667688DD0230359A5F7D5C0B20547E2BC063
      87213741864753C7099D0AD1D1598FD93264178B4AFBCDD8D25612601DA31627
      0EA70F7E21B56AC99B8279EC61F8964C94E4E2C16AD7CEF741B43875DE06B7CB
      0CD81AECF07761FEFD72788A9180C8B14F910C03874A03B44CFAD3608F9C920A
      567575722BE6642DC962A4D64D188F931B056615BDFAFB000B5E622D1F82DE80
      6A8C0A089DEAFC2B33BF77FE6094C0433EDC3F1ED287C6008F160CE00C9E0CBB
      0338567FACD9BC4978D6EC2084BBDE037611D6F5DB88D604689ADFE2B3F7D8D7
      28731B6B37179FFF93B61711DF39030D844AB3CFF01B929A52A2DAAE6C973E9E
      3061B4E416DFF14416F3060197802ACA3E16002261762AD68EC0E8D9A66BEBA5
      CB984C677EB66BCB6652046B26A99C443B94C326A148F111BA6A736009406293
      0595F33714070591C2D9C971A31C74B9738B157A2B3BCCFBA4AE6541FA0165D7
      F7811F9D91C839A29AD0644320E191EFE752C8A899084CB08A8FF302134F3066
      2C2450600DCF5D5BFCE181623167CE8B684E5EACF4D98F4FB212EB310EA8F3DF
      58124FC4162EC40902EF32A7CA7E5926AD438AC0E5249E26140BBAC4AA782594
      51A86285830336287269E62F040D6F33D0F0BA35D0F0BAF78406131FDD357A0F
      C41D55C811896529374015B35245BBD7DAD5630D31C3A4CC5AB38E702A14E4A3
      E7549AAA184F683D1B80542921B35AB7B2DFD161576DD14FABDDF29401B2DA2C
      4F861707BDEA0CFDA58EFCCE2039B6961551625FF0FCE3587E78F0693CAF82EC
      A1A85E486FDBC2F6E20D3508FF6A524882E83D42133D70DDA458E73175D5689D
      37CE6F4FE18F877FCECFCF4FD8FECE4FAAC43D65D1631723C927C76C56249B28
      9B4FA529E6D2603112EF22679322594229A3AD3A197035BB0A70755D54A9CC6F
      C3040AF9290DE621E1818928FB72B6314CA0DA3C55F75398C19C2252D7117514
      BCF88018E782D299F8D4506BEB90FABD0A86D3A0E22AD307FC97DB5F19B7431D
      E79217A7926AEF0A29A12622A5E61C980647E6AC144F698A151B935457D2ABF4
      BD904351CC2434820C1611066DD2E9506BC3F154E4260C4C9E15937EE19840F5
      E67ECC9A60757C3553294DABC2AC95D88DC797A988214E9F3B2F59C4E6839E19
      2EEC0FD225095B67A20D504F2D5804B10EC6A58345F16B22DC6B0F2B28B0142C
      80CECD25508A3B7BEC0F2E380D089602C8881AFEDEF0718E695B5DBF73CCFC86
      30F943E8576A81AF495439310C7CE8AA9BC19A0BEF2C1678E5B764AA6A3A50D8
      70BE9CCB5B0155677E24612512E82D3F95EA2908B3D2E32AAEAEFBB9483A83B5
      15566D85EBCFDB9F682B3C3CB8541B7B46083112845005DC43B637DC67FBCB28
      2B145E9BEDB80309BC811CE7DC9F88242E693A402EDDC2FDC75EF51D4398C383
      97213565125B561EE6914E583C36CB299D14A5A5CBA05331767309EBE3446DF4
      2EFF63A9E443408721D519F0E789A44BCBB6A8B2FEF4C22CFC6750A99080C9C1
      0AE092D823E67A0A9EC127760DA608D1AB0074F45C80AA694FAE979A7D649914
      99C2FDE2881816E65FDD270E4035028A1897A047AF61D2A4235E4A6FE0AA2E14
      90668498EF12D82EE718197386C11643CCEE11F33043546ACA09C29E3F10B487
      070F07EE2B15609863730DF52A037BA9E36020C579805E06A4E819532AD28E49
      EAAC3EBA506DFDEA4F1D6EE7224D48884BB89A44364B97F1B593258E6E2CA806
      C5B5190534CD291D1E5427B509ECD96379EE7B84729C14897054B560BEC88119
      24377B26DC1D7D021A553D2988C966F0541B0F4A3DBC561AC29484C0728E0E85
      7A5B41AC2A88ADB75BFEA9821890CF39F7C4C57A2C7151914235C685CDA70E70
      582D09A3DA014F54DE8AEE7D8CB209081CF992424CBF0DE2701A17BF2618978E
      363FA45BB3703C0EE25DE36BAF262C20EA6252B550501199DC556A86074A81E5
      E4D4384BB4587E9697AC52C97670E92A00F952F7EB2C3A0ADC73CFDF00A28798
      8C8DE64593C2ACDF7CCB98587D212B540088C5FC9CCA985205D5121FD781C27B
      5D7796DB6508873A7A5E86DA4F1A6AEB0AD21635155546FEF08ECC8CF32C181D
      551B6C38CFA5DB1A1FDF76A314922B45B5589CA4D772CF6E326CA65C320A23F6
      B0F4E59A2DE4C498D529B27F00A6354B229DC203826F060768B96053E64D8CED
      7B4FB8211C2C5FF7A1641F80B0619E930A0AD62A3368754BF6CEA3434107ED07
      B98429232A3694C9925757F4CAA31088C4C8E32FB76F537DB795508A6FC74019
      9D37C270A0F4090283954C8D3638CF2264973EFE4BF62BB815505BD511DBAB9C
      44F3847F022C75A796AB6DA4CB608D047AEA2CE34CE27271B44C8E1D30356E77
      979D681F20BDD8345BC2578A6F09B97DBA3438FB7FD4EFECF8BBF5B124C9A92E
      F04AC1EB0B2936A84E03B1524F3747C8804326E81491D4F7B028CE59BFE7C5BE
      E6B77DB703FFBABDA6077FBC6EAB077F9A9D4E0BFEB4DABD06FC69B7FA784BA7
      E5E22DDDA687B7F4BC568B9FC65B0079BA344CA3DFC79B5CB7DFC0BB5C0FEEC3
      BFCD6E8BEE6B75DA9DED2213D5507A6485A6678EF32DFEBF40123E5F38CE3395
      21B43F678AC5368DBCEA1C84460A39629FC5BD4DE25E8174F8FFF28DFFA751D0
      D9272CC4FA424C71C9C816A69C977BAC0A8914B635E76F4ED9B646684A8EA24D
      97B93D665670B2F9EAB609D6555E2943FED8E90A47DAC27C390C5F4CF7CC67D1
      D3CF9C92CA2B9578E11E4B6D2F8B72D124675FED9D1AF62E2EB48CDC1F9E7201
      E755437A1A144DDF86BEE4F249E9D8A4ECBA7D85A57FCDDC58B90DF49CB792BE
      FF14018EB9A066B487DC56F8F7AEB1FDB6B41041ABBBA4CD4A3015DE2CCA09E7
      AB9682D9992CA11D04953B9FF3F5550F6BF29E2589D97187D7874633ADC9D3EB
      496F030D700C039D3AB824ECF6CDA9B23C3A362C97CBA88EF17CA969AB519ED4
      28F7729588DA0A531F2DB322500694416E49B3CCAC7175C5B8DAFCD2C6556C57
      F316C9E77F12CE296C16ACC582DC3BB667CFF2E82F3FA9B9D269DBE1C9BE88A5
      030956D4FB4643F7EC3F14B9804F7A19F0F9A735656A77652D176CE7799EDCC4
      DFB039492DA7662F70DDEB16B4C79CF9952A10394282CE94928A7049B59412B8
      EEA1E4FCABF06B2E0CF40679F48F8BA78862CE317AED4E9CA752FF92914FFFA8
      B8CA09B3226139E4BF4E25C230CBFDBB820D71E11631CC687B09BD16BB9FEBB7
      BD8AB320CD3FF28261406D208B42A22C97AA91D707861B91E1CA72F492868C83
      1B0A2B3086C814221C39C7E38AB9E8A43CF3319669FFD4FCF0A6C5EADAF7F814
      4A305686F1A9686940DF9113F9C320CA560EE1FE9CC1AB590910C74570BFD272
      4353AA2EF5D1E3A9970BECAA7010AE2BA2A36354896342D98FD41149116D7C6E
      AF3132A278AAB6A2D83838FCAEFC6E2195A5903971A071A683405503BE2C41CE
      457994F664E893C1223CB64C4B96E988932FB1A4A8F4CF905A5CAAAE8F54313D
      FAE5392815BF3AD48612B657D98C9FA2A51C6B31EC57D542B2E51B9D46FC1500
      1D9720C4D03CD190C2E201695129A65AD60CEDFA3A8CBED4A9D8A7EA041C4B4F
      4D64C473E03B172F5EBF56E15CBEF3F3FBD7CFC962E2BC7FF1F23D5C3F3C905F
      F0BE13D5D822C032837E7A575253A9138FF4A341ED7205378864E824823440DF
      5C56AA60A6D396C72A0A93AB38AA36CCEC22CCD60D6EB4C26104D5B5C1511E45
      3D1E7D1846B6977205AA985DCC07C1F471FD3215ACA7CA3B609F236E17EE1C6B
      7216A23A2CADB94EA4B37BE9F57B4C328C0A950CA1FD39E85789CE57399A57C1
      50D4A5046695DF39C7484AB9E0947689732951957D87272C4DA874D6C5DF4FA8
      1A169287A2D655A9D03CF3AC60FC676A093B8A8247AFE2DF801C52F1F9CCDC83
      7DE23B1A088707EBC0E01CEB8C5225C755C323A58A139AFAD42D6B8240C4D921
      C63EBC890B45AB80E6B79AA3654E61D52402AB883155C1FF8DA3B8D4ADC77FD3
      24595D52EE695F15752CFA50E951B9BA1C556B03A995520246870723EAE94089
      1332B9451A4CC2DBA204E542C7408755BB6E0E1C8F6BF406548283934E87385F
      1888C46264C1D4338E3B71B088E95365B63457212EFCE6132524710A9CE2EC25
      C1978256704CEEC80193BA0BF2A29154014D61527369588B616C547DAB60D52C
      B0C3CFBA44DFCFDC4EEF1B3646AB52B9B4876FDF5D39521ED08FEFCA2DD8C538
      3D97524785895A00CADFC2B4E852659B3E002512416F5491849D632EDB025FA5
      8BDEC91E0AC647AB50382ADACF9462B9544165AAEDE6D482558BCC0AB1150EBE
      35EA47FB7905EFF1A8A949041C1123058BCDD8175DEEB184F12221567287D7AE
      EC838F1D53E888A2B0AB3237565F571A59CA30C3264DA922A974C6F6CD6ECB14
      903922004C0C122145F190BEAA99E42AB5479EA42AA2D35015271ECD92901BEE
      1CFD7790A92E35D2FDF56DA22F54962BCA61117FBC5A9159AD76EDFCCD0CED4F
      2C4404FF6303B4656051C0AF3CB63A8D1395C4FD719817EF9312CF653B1B732B
      2A2554E5ADA7D47B44559110750FB1F5413480EDE9E4CF2B6B70A5D2F1A75211
      5775154EB89072986745DFE0CC5896EC41F10016A62BF01EDE56810A97919A15
      5D69799C4CF17675D72A9C116E20787C908D777E1299F642645A56A5CA12310C
      7AF1779C13CBCEBE341F37A1AB933CE6CBC8AC9EBCCF2C8602E145DAC5FE1C78
      465F5CBEDE233EC2FD6C1549CFA97A6855F4A4B3A6A5B6FF70FEC7CB972FB9BA
      37D0C4F9824DEA85103BE724DB0908B9C553FFFE377AEC5CD7FD9F80045D2ED6
      9B2788AA203CC5AB626FB94ABB95C3FECC43F23E90AE74FA940081DD2F694B27
      02A0010E2BE4295AAF912F8387A8F02E6840DAA26058D93FAA57B38C50478CBE
      1CD663CA4FD3309A70FBC21985F8A0239D78193576D1DA277537F4B18049A61A
      6B1BE65B164B189D6CBE2A62D677410C6A6C448D0DF1C5F380640FDCFB776F9F
      BDD11EEDAFE5AC3D32E6F1EC6578FB03CA3B7034E251B08556BB4F371D557AF6
      36F9D8A4373065A40E9B0F2F3DE3D046C4B28DCF78E3403E3C20306F6DC2E6D9
      535D71A77C3431A6C030F7E9F680E4A545E239E76E5252FB933A64CC5F5CBE09
      27B6BE12C50744FE820D826F29F0514705F8C3AF85A83D16BBDE82422B4B3743
      69A56F209544FAE5EC5727BB9B0F93485C84E5CA65230623CBD7BAEF8DC016D5
      D71498FE02708FB566496A66F37356EEAF5CB8F849845F2CA230903E339C4408
      6F2FF2C249609FFB7762ED08A827FC3441634839FD12DF8BC1B3BADA98C803F8
      925142DC7F88F6E46BAA3A9D9E3BC76CAF959002D51F9AE7E690A68C1A0485A3
      C749AEFA1B182108C1AD4F7E5BFE413DA96A3252787B98175963A0427062240F
      A81B7B908B5925612ABF11A77452F13ADD07F58CFAA0C2FAE2BCB0A98D835315
      A1C11BA47682DB9655614FF11480AA8707D2F2B8DA28F9852CC3DC1B54A740F0
      7AA1F68D6EC586ADBA7132DAA550C60BFC38D3A93E18BD2476F7F1CA5EA97E28
      D552489506CAA6319F5BF1A945A805EB6E62B16020F6F40E3F8463EC87AD508D
      9A20949FE79B0F0FCC013410D70C71CE1B5560398C382A0E80CFA31E1B09B5B2
      975237536A2471DAAC4FEEEC957768C8D2585CCB28A0D84B8AD62E8FA156A201
      468989A18A0DD7B823C132803EA712FA6DB6209225101CF421C6564958717039
      349150C5A0055988189552D75D151AD4606F8A59B486BCEBECC7C9D6A6FC8B9B
      04A3B6A4C8811FA5808B775C55CA7CBFB39AB813B383876DAB921C89D3D69141
      42EF009C30555B62944A05E762117158F17A8954E67B00F95EB9FAD1C85F86C5
      91A67B4A372D00A3B24A8A8A1C21765DB92DA5FB628C34A7B553AAA3704F39BC
      FF4914B45437097FE1A86A3392A5B437F8C31BEE70F417C7B5D85BDA92D828C0
      5078BA33212EFB85CB5A9CD309B66422A9A2F18DE242855BC28811C834F03E12
      2F2011D1BAC793C99DB9E242A9EC045B7FB8996172ADDAAE95E6246101CA4D91
      281E1EF8A399313D1C9FA6E7E487079531F0064BDC8B74840908AD20E95EAB60
      05E2C03A58618F2A903D5FBB7E2C481EB280960693E0F020459B8943015D8074
      A265A3C1D0E72A0A9C0503F74BFD7472076088C6147B944D8B53279AD45196E3
      955FF42B7F2513AB7A44A7BEC689842CAB5FB4A600A34E256FD06D00E2832029
      EE3C0EB6C6A9290910367D9A620B6963CEEA044B4DCC91CF690A7A7C55AA138D
      7E456D2415B74D65B9B8D98AF85454675F945AABD044D5CCE8069AC41F82342F
      5A6CA12B25BB030D638E71305FEF315D6B3E1A1606A4FB9DD2339C59747890F8
      E3AA056983B480EA6B13D5C5C658DAB0B42F071F5962ADF90F80F099D64ADABA
      351BB7014255EC5111D3A259B8888097BAA2948AFE800D26132005AFE1D1541D
      AEB9FE273A3559B7F247460C1DFBE5B3F3FC3627D30AE981D975C87D52F16DDF
      51B479F13EB2049484577C237B6941CF0AC7FA21EBAD3C3CF80E36F275185F3B
      4F9D97EF5A18BC8EDFF6E5EC61492563D92A0A0439D9CBD6E50BA54A85F1285A
      8E8B10905762F650412359A9F9270CC8D13232B2D9B94462648A56BE72011BE6
      9D5662BF8A284F09A609574C4C7462D0BEA2B7F1E315488F7EF0F3D911951B10
      E9D6E8B2AC5217900917FDD247817ECBF814E5009FE4109642D688E1D8B421E1
      405F5E546DFF1B238C57AB0428380325E135F8CAC8568A58D59EDC525341AE4E
      A9FD0EB483B80F18A7CAAEDC615074D3644106E757040A531709EDC9DD783115
      22C8F846C0EFEB2DFA6356CA7EBDCA399905967AAF3501047681CD1495E9CB58
      B38AF2B081EF354652D349C16D6AF2C1B8FD2D281818D406575EE3514D2DE957
      AE74E57828ACE3882FA89B155E8F4978BB4F8D3E9E3911061F3A12C783718E6B
      21F27FDB7BF7E6B6AD255FF47F55E93B6034B7AEE5D9B24CE245D2FBCC4CC992
      9CF8C40F6D494E726EBCEBD402B020618B24B80952B23293EF7E7FDDBD160052
      A44C32720C4FA454648A04C0F5E8D5EFFE75CD9218A8A42CE4BAB3A065766BAD
      EFF5453D71E4F55032B9A46DBD54A0D9E464931F4A5D866EEA3935D361D9CC3A
      715E9FBF2D4C27F6AA0ABDF63915AD4DE34B9266158BE3806D164342D07765C5
      A0E21DB5221F134E21378DC1C2C47A98FD9B715C2F9AF85E09F03EA975B5BFEB
      5B6467CFF61625281BC7E67C68C170B305D5BA182B9694B29D1956B32AC835E5
      19E5604D2023BAA53641C6D7D9AA2A206096D2555CCC288AE2751D50E7DEF52A
      258BACD40E56623AA60E443B0B16C5CC82A17FE8F2C2F9F1EDC1917332263B75
      92C1C697C80ACD7CE76C329EC6931D32F8770E18790A1FD93739D229194A034D
      B45AD7A6B90FD44ACFD92304551AFC38CA2663AAE510CA17F81D2DA95BCCBE28
      0059D577BC9E580D694629214C039AD153E72C1E67237362CAE915334EB70FAF
      9DDD08F298A01038304548AA6375F164F884D003CA38C87C56EFEB619A97AE6E
      2C71623C10B4C322D83961F992A1A657147D6B08BE5BFC3C1B0C9E61AE1F0A3D
      7EE17CC28812FDE98573FB45E0D2B6B71E7A06EFF2E1C3A7DE38BB991CB2D663
      006B7BEB032BE3A4FFE6E3D7470CDCD55717C2AC15673552DF60CA49FFF3C856
      88BAF3E3B3E0F919CC2B63243D7FF5BE133AC747AFCFED81AE25F99348ACE032
      F66CD545899F3E1A67F9D8A4F4C7A3F7A6E0A1B218CA30BFA489D88A1F91D4FC
      70120B433647C6502EAD5323D273F253999BF79D975418389935E424ABA1DC6A
      F18B702FF4A86A642722C2F85D398836AE2622210E6E33B053D66DD88083BDAA
      4C6E3DA8EC46E8B917E4399B8CB502AFB563208FC70D41F8DA45C4E654CBC873
      294D45BB0CF38BC05E544E58ADBE4D9AB5886535BF0A7217635F8BD937CCD903
      4B405434BA99441776DDE22C3C320A89154AC24D6CAA9560E23CE725A5646950
      CC9F87431016AA48F04A85135FA144D896AC537657C867CBC693AD33221C822F
      E144AD52D544A1A915F5EE1287944024E57E3DADFB50AA133553245C65D87F9E
      941E0FDC965136A90C8CE0497669AD4FDF93CA8A1D218C12F1E0559EAE5D822B
      D9730E0EBF3F95B8DA9EF3E6E01D2E3BF9EED45CFCEEE0C7B7743B3F911A415A
      F536679CAFDDA735D71537AF20D5F8E99FE75CBF1E9A15D9B3282F0B0C87D9ED
      A085C259F0CB6DA9F9374D7D2EDD442ECECA4C330187D95ED5E458E4560F5C31
      29A9E7DC7C852AB272B679FEE27CDA736EEBF0A9333523931293AAD06A4CE17E
      B2366A15B532742ABDCC24876CA6545804ADF82BE590524CD516CF3F650A6227
      A6845A679F6AECE6941D58E21493560043CDFA05C9D69A7BBA5C5D8E96CC2FF1
      42BAB5F563967E674DB412EA0653A6DBC5A0C3139C5DCE7CA0F6E382B5C5D1D8
      FEAD557266BB0561E505E667AF521B962CE64C36EC7CE5756DE1B88B77CD59A1
      C4D742DF52CC643C29635EDE77A6A510AFA208AE0BCACCE3F6B8D8D5740CA745
      CDAC17DAB8127883318AB12E9D1774DF42E7B554A1925B8376A8F25B4B620ADB
      CCF51D2897E5A18D40E64B0F6F050E34D4D6C78A595880B6FF8E71D394271A14
      5211A2241B5B92FEF348043998F79EC8A174A6CC6D0F1F2E18AC2DE6F696411B
      2B0FA45869C95E9DCFB3D95D7EC00FAE377820437C2C902C16ACAB2AE233F0DD
      04BA3DE49C63E1B662CA7064894FB99C6F3ECEE21BAE73B3687A6194D919BBAB
      1C33DB5E15DFA91624C92495656021C4AB8F0CC761C499315B68E5FD2289980F
      975974165E82AC415908D38DDDAE11B15ACEC3BA313149C689351D8BF6AAA473
      2BA4AAF9F38536159AE74C37907CA24F08417C2CB835464ECDD1FBA3A708FAA8
      F588571DBBC8F5BAA00F1634224AFCB269F3057B70A714C731BE8D3F0FFB385F
      9CF5599DEB5DD6A5282E000DA89F1584C9311B7B305C050B8983C5099BE40ABA
      BBA8A219182BB4DEBB88F893143C0C053EA95E634189A165FD051F78C6B79F49
      017D5D8359A488B6C11C51852878E352ED11C48E6A14A4E618D0513C59B2602A
      83B97AA241E49D8996DBB289AACF0DE7EFE009545EA3E89A7D67F7A5D423D325
      6A0693B1565F55CD51341EE1C6A692791655E5861AA48ECA3A22012B961C80D9
      800EB62C8BB5D1872E34C7EACBD408B5F0A4D027A22957A2A12E58786C348B81
      785C3194ED2DE6ECA64EE62E3B9EC972B02C73AE226D6F59E6715DB69805B529
      529CD5601F0D7D9ED2C349A8D1760BE396622A6A9650CB83B077AC90F6FCC850
      19858164E68E5DA64B49BE5E9414F367ABAE3415257681EA4E891557CA963F5D
      32A09E1E5AE422FB8811B5768C74AC489BCA268C774C0EA8A2BC90D37D2F294F
      C8B044E11BF3E5C233F55B16AAD68408A064897D58594F1CF27C24FEAD37EF8F
      BEC3AE18DDEDCF43D73FAA3123FECAC417A5679895A12C21AE011D5E5182852E
      F2E1BF3C92CDD92587DE7291AAA33C33560185D707E46DE6003CB4917CFC27D2
      32DF4AB9435189F4D2A968D81D791B532EAF1D8FA723EEEF3ABB88264B66B754
      82C84DF54EBD9B5127CA7C37E2BCD970CAF49A101ABAC4DAEA751CB52F66B4EC
      4AE4DF33DA1B0B01481BE8E43165A8D8A29BD92DA650AAF9B382499D6DED4419
      2657437AEC0282B94B2E76C439B63123A49D97A4D61589929822575E095860AA
      38D828B142880F733F7D9F4CC32A55464E40B1179D36BB1872E5B82A8174CACC
      1E0A004B6415DAFD84BB485159185D138DF32B51FF8646D1DD77FE4F3E15F173
      C53ED488747D8E65DE3C76E626AF4D3EE6FA6A2E497DCB6947CEF30A6EDDBC43
      07E2F4C390484090E00FFA19E73C387FFB7076FE270A7BBCBA9B943697C84D4B
      55E10A70BAD6F61691F634AAFBE5F9C4DAC57C7376EEFC7B2DEF5556F7BAA08F
      0ECFF011815D988A88FA676FE8B337B9090DF2274F9784630AD85C50F22CF201
      EB62E5284D87BA5A3CA64E0E92EF354B10F68E2508D0F49EA1175AADEDADC7AE
      186CC71C8C46606E9248C7857916C7B49691FAE7394C07CEAB5A93AFB9F4CBAA
      D1A2C450EA6DEDF3419447F927E3A6AD770A6341D9CF067849C19BAC4A67354F
      B1F7F2191C2E6F9DE8303D43C298436E71E208226E261435E3032EED79F9B63D
      EB5AB5A14233883BB02C7B4BF06D557155A2C3CCA5109326A0AECB3E19CEEE99
      959D4956C4201D6A0E666EA9128D9FCE8C5DB88045D28DFB7961CA42BEF098EB
      A3151CD97C3297F960BEB53E72B3DE18A5F5C771AD1A576FEF819C4C6A89E0DC
      98FBB95AC7067C29C04ADBFDA4C0F7E8785A8BB2F2A3E55114E8949BCBA257F2
      E0CCB8C4A9C325FBD7A7069ED7C6A7D934311ACB3CD2303DE691096E09F763B5
      ED1BE47ABF1BCA0D538E3514754DE15A014F7B9DBECD0A22EA5DA52979EC85F3
      FA26A2177FC561924BE82F623D2FC89D8D2BF1C9593E9EC887C50BE7659EF749
      2FFE77E79CBABBFDF54BE438914A6130726D1F58E8FE91F9E65159B374B7D91C
      BF988E87DCC0AEF2F95ADC1C280C25EC34C3649BF0FE43C7C7172C7DB160C9CB
      453D3FE3B52E6839EF0010FEEEB03AC620A1390B266AD7806A16CC183852C103
      DCA7D8825D30860E13471A0726A5BB91130BEEB753A38C99FE4B25F3F962EBFA
      5243140A16E0AE32A836BCB4E6F517204C0310F9D0B570D59C8E87C91F3B231C
      B539003C9282248A4D8085422A3621B0301D54A711F758E6DA8F4B694E5D6B21
      7939BDD014B41869F15870EC962E7F2E1293939CB84CCA76AEAFA51FD507D3CF
      AE488666C50ADD822AA63CF9D46B87F8DDEE7A2EFE713B7E17FF7861E8E31F3F
      E8B6F04FE0F7E892D06FD3251DCFA54BBAAEEFCBDD7409387F871FD3EAF5E8A2
      76BBD7A2ABDA2EAEA37FBD8ECFD7F961107E5949C068ACBFF3D85C2B0B8BE0D4
      EA6998B80E6D8FB4BF9A2B223A58E5D5CF9FC37828FFAA1FBAEA394FFF5A5E30
      29D3501CBE59D2ECB0ABE6EADB525706AD554F28EF49334EA7A83DA33A130BBF
      500F13FB47EDE59F49B6439830C0F43139BC0E2F757C0533FDEA6B72BF8D78DF
      DD697C18F6EF4EE441B089E7991ECC188E0319A4EE98BE9DD894F84C386C3D97
      4A5886DEABC8B9693062ECBB82EB2C8BBC7FCD4F26C729C5A36F322EA8903241
      0B406EF30208AABFAAC21FD5125CBE40F6DE4FF9B89F9C8D54ACF79C27143FFE
      E5E4EF4FF644A7FB2295680F2F38174FA3BD177CC189CC510EB137C599DA63CD
      6A672D7BEBE9D28CE11B1A74418396C83D0C4A4AD0F8A97CFB4B6DBCD124A82A
      805B9F7F2B2A9219F73B4545485F68E492F7CC954FD89F2B8182E8AB8B82E044
      099894BBEA88B381F3026732632897D700DE3EDADD2FA7177FFACAFFB13605FB
      D1F4A21E51E6FC038BCA4C083019C39B53E88BBA129194E192FE45B759778F4D
      F161F7B77D06652919B8983257EABF3ED247E45FE42DF838EA4334997D70E617
      616EFAAB9ECD8F90D297B8DFFB9844FCA2F591923CF000E7E393A8F371A2A2DF
      1650409A3DF342DAA68EBB0629605EFF88794EA058E8EEB87705E2E8176D7F21
      85D0FD7F108DFC6BD0F19D67E4228CAF386F90EACF735D0C9F4C84DF9826E193
      BF5499590DDB454C21C4144EABC6651C5FA51998F4C30A438283C6548F7F61B2
      6DA8287F54269534684A1D4CE9484DD4C2097D3BD3E8611A52EE67A98AB3D361
      CF4F8C230F06529CB3B78B606509396254412B80797C387FF5ACEB90F9EF3C8B
      472FA693147F5A048DC64DB8EB61C234DFD2036F62F66A7C25D17CC97F374E7A
      DEC832D9964303CD9B1231086E4E679AAF0E2F8CCF85AB0BA03EF6B9F3453CA1
      CC86DD82E5CBD35A961CE5C815DC84D95AD989A49B94590FEDE64D3AB843B863
      2DA024264D79900FA932DDE613F72949D024274BF6610C1AA6905A914DA633E0
      AF0D9A2531CE2B7D1BE52407ABF86236648EC2DB44632D666442F3A641CCB23C
      5351DE27EC9461B573E9944E1775AF30099BCD9B4197CE985D72C6EC91FACE2C
      2E3B21E798213558AEB863B337A5579F128D0A83BFCCC7D9AFE48AE81BC46AC2
      EE8BC97F5158C76D944F26F960901712C0BE6DDCC47A2D4C8C3422CA38030318
      98089E538FFA245AB83F3BA84DC3045869E44FC1564654F9DABC8911A3DFA16C
      1A6A4866E0207766100A25BFAC6123DF2D8D1A8EC1179258FDAC0C16D9B01239
      49A442C1B2E6381BC7D3015534C49CCD6D11B34CEAA3491E340EB186CD7A7B6B
      D9BC2578F89C791DBD58B40E7D6DDBB15C67636A95EEEC547E9E9D2AC3CB3A05
      77CBEC43B336A6C33AC131A8A6D975BB52594E4D54C80541FC92D6E58D1A5E4C
      29DFB426E84C1B941B2565CEFBA29316063C1FA4B01F15EAF97EA45C870ABBA9
      DDF3B73159A8CDDD4AB526AF51DF1CECC4B193946A5498188A18310CC00A0A0E
      BCCA5EA54CB9A310023DB74C1B6DF81A8C3558AD859BE7A6369C240B352EA7BA
      2FCAA09D2F536EF88C8CA3CFD4CC55744CE0F3C405701D178B51AE926D904549
      3F9C7F88397383A6899480E9F8CA94CC09AC9CE47183D9CB270D5B10B0BB254B
      32643C2A6EBE58CB76AB0A179FD78A166F470649AFC6E00C17B4B54073ED5BA5
      62A014E64EA4FB5C5AC8B5284D637CFF1AB65AEC0A191996AF9C21745F63C8A8
      D1C8B936B883E2116CD8F09709B432C3D044C2F25A91692997B81E91AA0ECD45
      D3E124EB9B741A9BD7C61838EC8DAC7AAA367DF2BFBC7AEFFFDD7945DD6041AB
      DFBD79FF928EEFCD38FF6666709F86C16DCDEE229448A53D292ABCAD560BB926
      68C1A936BBBA802C18544728A3618BB35C5DE3CC4B493C3F9C0FE8EEB2FBB596
      47F974CFD97997938571D0EFEF54D45FC6866C867D0D73907D378D63E8CB96E3
      80F7B6B61E5C27CE184A653ABF009E578E95A7B3F59CD4156597900548756110
      E2A7141D8DFA8A7A017C23EBC0413EAA982AB71733E28A826F44033DB4FE2F18
      FD93783A31014C2907977A2FDBE04D32944DC30C8BF1716B92A6874F26DFC684
      4F41A3F9C039F87156EADCD492B69B369125B477FEFEB0529C67790C2EFC291B
      761A3691E5DC55C80D64B8F30A2A10334DE38EB9C992C925D7CE56086EB34DD5
      4AC73C74CCB156064B47EEE3A2427A4EE34EE39285F8FEF5F9DBE3C2D935C2F2
      04C651F609EF326C2BD50E3B9231EB1C8B93FE29AB1BA71F4E9CBE8A74BF741B
      987CCC1C6B34F856E67EA7FD6949D30600AD069564F1870E854A7E2AA9E41B99
      EB4B0261C75BDF53F9AAE99A593887A60B19F694554776903F0705E753D39B50
      246E3C2D26D2C179D03C4FC79219DB3AF9AC28A60267E37C3A9A0E4632AFF174
      3834FD739514B270C19339EE250EB038C7BE9119536C8DEBB3C43B13B35739A5
      CD7D6F5CCE74CA4D8934D97C549F431D3AA5171C074704E9EF1B99F06C24CEE4
      43318219F91F9D91C29E57517E6AFD4D3835FD7E05E22185D9793F69DE262F51
      9FEADDC7DFFF4045F3930AD6E44E5F32DEF092AD99158A74D9759BD1291557C2
      71A5CD1780E03FA6C8FE172806F81676EB267A9FA6384F94B201C9511CE22AB6
      512134053866CC950BEC5C6343CDF68B637EC581A35B26E66F63BED3A1D45E0A
      56354D15B639F31401676019930DCBEB2E33B1F5850315523779311DDB469BEE
      A53CCA08ACE659698B97A19616A1250560F7DFE9B58194B04D46A14C61BB0514
      A844A24F74D9FC091F0A64D0B7227205707A8F0BADF80599E7875406478BF176
      36D024C9ECC4A76B71B5DD933E6BD4317514C691A8B75094ECF5DB7C2AD5A435
      D03A1BC2E243E3ED7BFBE1BFFCCBBF34CD0B7B9FAB876B6FDFE91B36B11668A1
      ECEEAA4932E1F6B5FBC8BF61A200F4084E3DD1E9843DFFF57E4AB67477E72827
      91C9CF951E3AE2183510703BC291A81EBC0A0A2CF85A162FD423901ADEAA81A4
      74366CDD97ADFAD9D971A93E94214C595FC36E16B7E369CF38D498E46819ECB5
      BEDF3C2EB5ECB8FE6891712AE43D6BDF7F2353105BDC892D8F81FD7DA46E28A0
      3B4EF6753130A93D85E34B90AF441A21CB566C9B7F4E29C9959FD0B0492FE718
      9779BF84DB34F9269C4F73A54D32ABC4F86B902C44A6F164DCB7E929F3012E62
      CA55A6C30CFC55539663A9D963E109A42B04A6908DFAD2AAA54449B2E8086231
      709AC397E814C95006DC7D8202813482872FFD901C04E8F064E7986D6431DA4C
      3366C9A655C0CA9CD36573A1E6A8329BB15B409FD9AF54A1D6B4392E31D570DC
      9CBF88C546B3E740C4F7023CB940E8F0ECACB3895D88338894C6798C83BCBD15
      5F9AC6D17C313D5FD6F71B0B717D2861950639D942E05C9A0BF5E3AA69EE3C3C
      8DA1903A60D09C91CB2D6604B5F8866B9D66A0671AB6384BE51A71B1672693A3
      EC1451E6252CC0C3ADC0CBB7B79CEA468678A35C0F434BA52E582D8C7D76B982
      162FBA7612BF9165333019441C75C49ABD855CC5646B9415ADD5A2A91A069849
      286034A16F46B32B45E24CE65ABD0B6889B55F2648739960CAA9EBDFC82CEBF1
      B4BD92B2EB86A1D93C83F62B35339C3E3029E1C0A984CD2C41C3A6FDAF61BB4D
      115FC1DDE2123B2253D6EFA0DB8EC4CB5BE12F09DA79F326E19ADA17CBAE390F
      7A42C194E333EAFA33E2A273C92BA65DCB391B679C71DCB761D3599A8B3456C5
      A594BFA83836BE54C549FAA67FAFD8F29C682954B987A96F6F716D3634075CAB
      251B6DA4C82926C02691662DDE807249637AC2122B21524DC193B5E3E84097DF
      A46CA67285503F3105554A06DCB0C55DAE29ECFC72A4F5E8EF6526CCAE6D81F9
      DFE485901ABFA73B9F4DE5A68C997E9E5F49A4C47A8D38F0635B1C50E366DBE6
      980163A852D6F4B2AA01FE33C602297A8D2C7D0CDB94B37F62A2B1C6F8CB133D
      229A998CD5B05F1FF61F5DFBDD7A98DA6FBF3B6FA795D5DF7E57AABFAFF498BC
      025EF8F975354EADA1341F1133D1DB77F7DDFF6CD8E67EFDEAE4E06B57277F30
      8A9BCD5A258CB03C21E71CC7773F9D1D5B69B2DFB0CD939197BD3CCE8F0EAA1E
      4CCD1C6A9C432A4932390D9481B5086BE2BDB7E7BC7AF7A3581DB5156FD82C0C
      143ECEF17EAB6143FB14FA4E1D78A229E392961990A3AC9A5CAB71266D2758D9
      A6419BC6030D1B76059FD9CCF191A2624BBF1F6068EEAA43E381906BB31C1A0F
      36759DFCB3F2A4EDFB9B0B14BE79558992F5AF9760C2F063FE20C1729024B5D6
      431C91E634E3D8C2CE3D843C79B09D7B450EE0E3B393D274328DB2747C39349D
      BF0C0014C74B616C354D1C3EEA32A68EE33BAAE3206BFEF5BB57EFA5CD59C3B6
      0A4B890350EB083BE4147A93D5C01E35E7F0900BBA1B36721A55D575DCF8369B
      748E1F3970F53CCA1C213AB22C4D4244A27B7022CDD19BC33DE73D177A90F7A8
      F6C9F1D9DBC6F9671F199CF3CBF9F159F09CB99CB5DB4E8E4F7F68D846810D7B
      CF61CFFC5D1A850B9768D8188F8705618F2A8BDEC80D978811B337AB28F5DFA6
      5A94820A87F33A26CFDC8D62E7BDBE900405322AF32431BD939A36F42383B99A
      DC0ED5208BA1104A1E679AE97E625BB199921E0B21AD9C811E53ADDD484DE2CB
      7DEA29447E384AB0993CCB4C3B41D597929199C765A9F3AB1EE75C7FC259A284
      785510BA4B2E5A5E5F1C900C4E4D687A659A87715A9A2F169FEF3E6155DBAECD
      14FC215727C54333CAF7A14BA575375444DB524E71832E1E53410DE1753F3569
      25E66A025ACF87BA69FAE4CBB3033CD9B96EED070D1B19597F0F9D58FDACC03B
      CB134CB0029BA6988CCA9E05BCEB232529E716EA42522EAFB4136543AACFCD12
      EA370B8BC3E4A6D89A194E2EE7D4140A39C8CDFB025F77A9A821A19429A87E3C
      EDB3609084ACB747814452CE5FE50453D9CFA2711DA5FFD15DBDDC5DDD7E7457
      CF6B40E1D7D680B6B77E393B3B1615E890A503A594F6A791534C4714EE727649
      95352AEFD33D9285841757B35A483A5A9518FBFDD09CE4DFF6E338FE32996A8D
      53C9A18F06CFB11F7F7776BED3430AE07101CCFBE81F3A9E143BB679AAF47169
      DAD84B2DD58CF260D2275C805113D53D8350F1DEAFB5A36DD810CFAE6EC7D9C0
      F9F194A318AFA844723AF1E9EF62BABDC567F305B4A8A12992224BE6C753E2B5
      FBFA13C3E46376D51B7BF48E89D54BCCF51994A9E07A4CEF3F4B731FAF4AC9DA
      B4DDDADE92FE6E903F2F4801ED3E4BA08843A5BCD49F54A2E36C00F16E8A840D
      6E74C6A883D75922A5013B2FC91F64F076694DF231B527301D067644B9DD9326
      A4E641B63B585560C0D89F0D5B1ACEC59B41C12C1DAED930C9A5A96D910DB23E
      C645BDF3F68CDB8233334DEF475380C9A969DC77B27C5E3EEC370D666AE75417
      82C43B8D616AEA9DBB13328988F23E67D68DD450DB2E0303E9DB553368D4B071
      93B4E5DFD6E3BF789665F7D1C47979CBE983AC1317500DC738123679B20C1B98
      D82EEBBE042CD5B0596F6F51BA98B34BBCECBF21069FBE55A3B784423C2EF627
      9FA4B75FF5E1DFA6BA989C133C167F887DA442516EE04A595A0C6C2B35B4A6FB
      B3A49A48B538B7918491D99F725E13E9AA7255C396C4B4DB4B4AEC287275674D
      14A9D7A6A43D9A5E48E898B78B78CBC0A47B356DC4C35AD493D964E9A53A3879
      CD86640527FF8F221FEE39C32C05031D907728537DBCECE789D8958FF6DF67ED
      BF47EB6FDEFAEB7C6DEBEF17B6358CA67946E8CD901AC726A7C618800DDB3533
      E4B3E3E66AEEC6B8108DDDF11BBA90F74816819BA432BBB28357C306FF4D0B9B
      4759F13959D1DEF71EA5C5BCB4E83E4A8BFFA1AC581AC458872BF953290FBEE8
      AB0907F66C9994B86DCA8632713E1810D7EB73EE8BF5DD346C6A3B67A64DD3CA
      667AC326F07903EC918FDFC3C71FB5FE3B7CBCF7B5F9F837ADF971CA4E1963A8
      F3CC8B7E7EC33D2334856F9B36EC323AF28A334D4ACC4E596C81FDD38A9D5198
      5B3327B1BD65569F7E9B1D50D7799614CE8584ABB8CE6FACA18FD32468579229
      35BAA74096F1AB53870371D2177BACBF835F189DC2E493109223795F18221D42
      2FBE64A840E92254210C916BEF91057F9E053F86DDE759B0BB78FFFED8CC6AC3
      0E0EB8A0F3E4E5F141331132BE1D07343762248060623B7A309ADC3A788ABA6D
      DA383F19CE4943B52CFFE5D941539BF5D8E182100C1D18FC26AA6CD45458AEA8
      7C594A9BFBD01F8A588D34F1FF864D04C7CDCA2C0AA8BFF7E4AF4711F27911D2
      7A1421F322647139C21F28428A11A10234D9E52939D5A675555FABAB660ED0F6
      9A033FA30A274E623B7A7DF0A691834DFBB99AD880F698A0BD9A67A2A9E45A71
      4EC2DB3CE172B1C249B5A25C8D860D94DA51FFBFD4EF9325C28E292EE6F4DE79
      00AA9D195333C3B25F6709A13B326E4FC3E64560E9267F99E186D88B5821AD37
      6CB45564A4C90522D5281D120126978E3CDF148134BE59B9E0C5CE441793FD91
      22AA31F66B69E253BE1E03B850228BFFDF9CCD025DE4BFA19D3C9532714AD76B
      D8E44D33B6A2C8E38C8B306CDD05CDFAE1137E293311ABF7DBF6D6430BCDBD2F
      335A9F46FB05C67A77017EF768D3DCFB1283650EFAD06BBBBD85F10EAFBFC878
      A96FDBB06820A3E1CC7A484EE7FDF8420DB35F6155EDB6F7D819E63E2527582A
      DD812650EB4D1718A9915A140DFA0230B2CF06B919C48BFF655E104FFB8FFFE9
      5D14526935F4E085520CF14C687FD45FA09FC513103BA6FEC0E46EE41036CC00
      C0356C75875FA206EDFD8B2F5B80C6A9D2D29007A6FD683A3130C7AC23927837
      FE06EB1CA71E0283694C2E13A225A9A6A1A6B7D4BFF5C1A7BF83F9EFEF7FFC08
      5E52B2928F1FA1AD141F3F6E6FD9FA92C439CA08826E82B1EEFC4F3FC395DB55
      5461E8EF9759628C3FEAE929A57E2A9EE4B6E0B57133A0D14B830472B9519B4C
      0AA9301EF3F9E9F1B14913C06E96D195B29790A6DEA3BA2CDB6D24CEE29D08D3
      1E4DE14EEEC0B3FF30400B7851964A35CFE76866F39356A37CF8FC603CC8C7CF
      0F0683E9D024CD8CC8015C5C6A3D691CA1C9C85FBE3F3A7F8E5FAE74952E9187
      D9D95E62DC497D9AE91F73C33A4842CDB989BD59B146C0A9797FDAC4CA3599EA
      6B1BE9387AFFF27F3B309C937EF3E4A419EBE902ECE044134A6B05B55EAFF078
      F46E2FF56EB7F6BDC724953BEE6DF76BBBB7B7B7A43762D87BC10E9701F4A758
      40208CBC9E03A6E0A29F94BC76064B9EB2051C35A0ABE8F2128782D0A12C665A
      D3B8AECCB9ED63D2265D228390FFC4B54A061358E07ECDC97F4FD85CE0B28D6B
      6B6A2612BA2F6AFD7BC6F944B46035BCE893A8180F2A2CE8DD9AC26CBBA4E755
      2D1BE9AD4DEB9A75994FAEF46D51AFBAAC4A274DFDE5EEC33B45BE4CD342020A
      A70E77E3C11EE5E78CD4C3FB73FEB2D2A0C91BB18E65CB2B4EB0300FEFDC7BF6
      F0AB6C863BCC877A7EBC98F8EF77F03DFC88B3214EE0A469676F7B8BFA4C3967
      97593A31B043DCE0AD6AA444D6F9553662C0FE9C11E8CD91C475301676493985
      2134A65EEED3D8D4F9C9AD50650A6A3E0BB14179C902AFA48BAB09858AA0B237
      6D31EE2C456C3BB1BEFFE15EEEC4C85643E947C5AB3532C2B56CA55E726F81C1
      22F4A5124DB961ABA03F5139AF5E3A76BB0A0C4BA5AE55D6B781B1668254C8A8
      B82585E9F9475EDF0B887D13FFC53E89EACF59BB60DAC6CB5438BB9430C93D9F
      58D16B1ABD52F7A9BF1C124E5846D318F66F9D771445A391718FA57E368A7245
      7D288E8B981BA4495EA8B49B12E26DD89CEA59D40673CD1E1872BE1805359942
      0F4A55BFB070A5D7D23C7458E65B8B4FB0893DEE4CE9BC043935173E0B28C71E
      E86C903B4FA4F1D5E2CB281CFAA461135A1279AE1583172FC87723889E8C1A62
      63C0BB4CC23F3DDD737ECAC7303F460436F0729CDF1414AF39E84FFEF2CA6BDA
      A92B7764447E1BD812D4C425CFAF066A7C65D8BEC97678C1FDE1FED2DEDF0FAC
      935B9597EE39343DFBD945EE442ABE6AD8546B498AD4E2BA047AFBE9F4CD1161
      C3E4D6FD3BCC6FF69C27F9F0498D5B366C2E7773EE77238DE918EFDB1EE1D595
      6612DB5D8D3394CC146CF683223F2861B140BA0DC1F721AFA4AF4DD127084829
      0EC0D11A49BF65C34D6FF3E9B8C46BC8520315D9CC999EDEADAC31B3D8FDE9FC
      FBD33DF631EE319EEB9EF852476A743B9E164CA97BCE771A54784C6D968EA409
      B5697481452913B2DFA9EBB75C25E2EC52C7D82B9630FFC8873749A769FB5F16
      8E48B63B4F78D7CED86CE9531A3E4530A46DC79B1FDF7CE7EC5EF4F348F5F923
      BCF16EDF39BFD48C1CFF84FA4F391AAB22004F873F50B86342A8A42651CBD491
      98C683B7D6B895E41B06F6C06DB51A92A6AC15AD946F57EAE7D3EF8E30A1C87A
      7473E7F4F815C887A1D845F76B241C3005DA284C556FE877F2E6C8ADCD05AB7F
      7270F8038E3E3B5028FFA97193A058DBCB93F3A3B2EB645EA601467972CB2DD4
      8AB24723AE7CE70C1B48513C8F538D4B39BC7978FCE60D9F0B96861792A1A9C4
      6DCA1184D4A023366B16742E9E1BC06E13C5E509D445FCFB5767E735AEEBECB2
      6AFDE42CE308BBD16E9E18F1CF8A409A3E7D8C91AC102379AC22BB1323F1BE76
      8C441723836A6C7AA950EE18B56C945E80BA18346CCF4C54C00B5F504B8E62A2
      A8F93414D7B46F900AA1DA5C8C75517086752C8101B287FB39E9F2B6A561D30C
      633BADCE0BD39F51AACF4A590711418D482684AF4BEA6FE1BC3E7F4B15118969
      953D530D3CD4DC28161F0F9B177F962A044A2C61CEDAA50CF3310BF0E29F538A
      FF47636CAA9EDC9DB289675D646C97898383EEB3503E8CD75740BFDDD7FBCE2F
      FFCF4936399BE4A3BF37CECBC896F151D42F5BA7CF008F4AA04E3AA0168CC818
      E7D37E52B5B6BE659588F5CFDC74471054C6A69D5556314B04495323C3BD746E
      2AF3D980A2D214126943D034838C2A2B854712755A06492D89553C21283FE957
      CFCE7F7110B30A57D81CBE40CC919134CBAD6E6087B2EDEACC0EBE864D7C8973
      6BCFF9F09AE3DFE3BC3FE7E93A280A3AB8033504F18EF7ECDF91F56A31E537CF
      AD654C4BE1BC3F1FFE7FA7CEAE1EDAE4805F29BA51C601FEF3E9AC0142C65493
      6773F2F6F55933CBC24B8FCE807D117954E49C8A48C530FD9AE47BE1BC7D7FF4
      720FBFCF8EF69C57DF7D77C0BFCFE8F7F95933273535AD80DE1CC29EAB1B1394
      A5AD939AECFA70F6C389D1B61A7A2A4A4E6D12C0390881BDBAA6E6EC99A2B00A
      4FCB8104236640BCAFA15311D5A3869762DBCCB01BA1C9A7E4C991D8124F4C63
      A14BCDE9AC35E1F9E499DBF63B7ED70BFDEE7E8B7E9E90AC9516EB65CF6F32DC
      4D7EAF3C883C5E50A47F3E7CF35375E61AA731CD797F77C86AFFF8519A1A3811
      D5B0163B363D6BDEE9FB8DF87BEBDD94AC8756B2CDE85035B193AE71335A5E57
      D3F6EA2C0F44C7881A0D2C72351310AE70F2DDE9694DB4E3D7783A2A11F1D5E4
      F2624C2845828EAEAE9B6757CDCC66018F7BFBDDF12BA62552598405FCFCE6FD
      61FDD437773E3B1FA45FB38DC2FD7C767CB40316366EA0815B9588C8D825A036
      BB19EF4E0EFFEFDE82E0CE6317A8553C898F6022773C89FED7F6246E6F191C2A
      58B4CFDF6147DE6A6EA34256AE89654E87A0F47DE74361DBAD432D915682B4C5
      B9F4D730D98D14495094813DCE6AC7A229FB7DA6096A89E736D6FF9C66634229
      91DC6AAE0A4EB87805EC2969DAC8659314969922C2CB6A7E691F089D37BD2D4B
      BF9E90B99249EA388781682F1B3639762F1CD4A88852A7C03AB424DE48D257D3
      06BDF3BFA78311C3DBE6A5BE2102F9496193F447F9683AE2B2B5A68DFE78482E
      BBE7C675C77516D08EA4DAC0E444366DC86FF20B21630ADE5DEBF1CD38C3A886
      14BFF4DEBE6CDA68B7B77EF974040A210CEA09AC70FD29D6B6DBD2981C53144B
      26E3EE729C4F2F2EC16BE98D131B05C159B85464AA73826E31518311774C1DB0
      FD1869CA5F4EA77D6EAD4A7E77072744EA3D596D69DA6AD89A425C7A5558F951
      0356919A1DC2ED234F440598BFEF9C18A310FFC3D6A70C510E2CB0DFBC89B39C
      0F54DF930F641A9611FAD4F95B296A221FECADC1EE79FA472A95BF478DFCDD3A
      C8997556BF68D8867E7DFDF0AB374A7F576F95444A48D30EDDBB25A9BCBB558F
      AFB1BE9852173CFD89FA8431F4CBD3264EA31E9FD93D7FA322684309994F7BCE
      F9212589BFC1505FE69F1A37F8334320261941C5043502E1C6DE0A5B2B275124
      AE55F9CB2BE6E4A4E6891101E608A556E36F231028ADBC71D33C35318FE27638
      519F9C4B9CC93E9D4B3297C665E2BB515BFF34DC9B60CD8B47CE3DCFB9BF7A83
      E71F156C70EE2292FD4A456C135300462E5246386CDAF17A3FE5726D890B7C0B
      037E2D1EC2B61BECE15748BF7AF4ABEBECD2AF1B55383B94EFC189EF34AB9D3F
      8F4EF7362BE247A630CF14BE7ADFBFEDAD432AB71BE449966654A2C5382D8391
      9A6451D6CF6081B1CC8E72FC3AD29844E6FC7CCC56D9CFC79E8514E22EB2453E
      1D53451B65D834ED608AB78C3A3FBFA3A196D665913BD3612186B720C4B3CA62
      4021AACEC2C6E7D9B879BDBC9DE8031AB7D3D7C30B6C1174DC31D9C71C240E7D
      27CA26C5632C62855884DB7B8C45CC33A7AFDE668E770987B16AE01EDD825565
      0335C48C093381115F3EA6FD8474ECFFFAF86FF49292299C2F009CF8FDFF3939
      3E7DF3FADD0FCECEE564322A5E3C7F5E8E653FD1D7991A12ECC03ED8E773FCFB
      FC5C17010DEBD96B4CA178E6879D9EDBE9F6C21DE7371A793F1917FDC9BA6B36
      ED7F8C537715BEFEBBC6F81BC8AF808E25F447AF68EBF527D0297BB26F3BADEE
      C734CF27E6650C13F513BDD0C36478A9C79AEFA65B28DC4E44CB4F13928BFB1F
      8B74328CFEF105A459A38EB04D09A114FC6C48E03CCA569B243ACE89A0774F4D
      5EEDC1E9DB833DE7DD8F67AF2945EEC8DDA332B7F78D3379CD948EAFB1F1A61D
      A16010381794214A4EE7D7471223A7E8523FFB95AE9074DA664EE5D5B2440BAE
      4DB4AE2E81D62D61E21B36155376D0F29D17980FA538E754A94E858F5067A838
      8471218A81B34B2F2E2EF362F294E30E6534A179D694C5FDEA7631AB23C1B764
      B70AA99C6593486C577F3A801E9A4D08ED049A1B064E70FCD258B228B3D19DDD
      64CA9169E55C2AA9A01C6B0816C66188A6174FA9A414D767848749569A986882
      B7AC2807A4690B6476BDDDC3FAD8D2F04B0E8BA8242192C59A1585F3F39BD337
      65FABEC19E271C1FAC2F07ED25BA40B3CF0B2D5773C3000804C8DC3157110DB3
      8BA12DA0B5C961AFCFDF3675455A58117690D62034B85C81A1350AD3B9017C2B
      4B4CD146B1EF1CF48B7C8F758E9DF97B77C8C4A1BA4161074D9BF6FB5A20D1E0
      3A93B395B69A0B9E21762694C6CF942C391991064326A5B969733167DEAD68FA
      508DB2EDAD49850F67D2B1860212C3A546DAB41BB425464946E61D6936D8D823
      6DE2017C2F43043281531CB120E877C25E21F2F8D338631E036C4B8D9EAFDE93
      B51E3BA128374BF2520F616F0CA17427B44E235540C7727608C579C7B9D2B790
      5B24C71BB6AB14CBAA61EA58BCADA6B11E8E1CD6F9FC1FEA3A798CD9348E1978
      5FBD3B28B967072356D4739CFD7E9F65B8CD76D20E69F79F30310E7543F12719
      3F960BB309D5155F6B46B3CF31CE5B53FD18E9CB6CD8386DDFA86E6E40AA9B05
      B931052F8226CEA5DFDA34F46CEAF0DBAC791AD05A530F9CA7CE29D42D8A5C09
      DE3E4334B1D101EDE4B404C52DD10AD93FD057B7E2C6951C5B52DA4453E78FF3
      2134F6EDAD778CF1CDCFAEC0757F3E7C736A95F4D9A533457A4D5B3C6BE9B5DD
      D6F3769BCCBD6A5188DE6D698A205A96D9C692A95B5FC17E9E5F4D474E3265BF
      04E71E278692B8089D8AAC19E0723A1CEB7ED64421644D980E56E1A5746D3069
      041F6C9307B2C38E4CA26639F78260F51A3A1752E6C54671760C008BB8BD76B0
      877DAB1934D0182909B34DE7FAE0C77AD9D00CA803D78CE304B2652291A47DE7
      4C9C5FB45DA6F5A5EADB946B3E98748AAB66E6866A35BBD6208E8AA6D2668B4E
      E88FEC0024B40EB31CC2A6C8E4A2BF8ECFDE72ADD8BEF352C55717EC4AA930DB
      FBD92033961A77C1C1BF25F0855906CE3E6E9E2A5B5244ABC3824A5C85CAF9E7
      541713CB740D9BC760C74A303CCC114EC7EA828A01A5FE09BC3DD2B62510B8F2
      FD04D3C83C5EBB182116E3985DA833B520A69682704D0450810F0A398987EA7A
      C09075FBD03D71143E507C95BCE2E472AAB92EC80AD269AAE3ED2D58E93825E5
      7121179DB834A4ECBA694B53510AA934EF8DCA466B23B46269A1A096907FE3B7
      0E4C1D36E5FC5ACF649527BEEF1CC9D12007F59EA5908CEB39089122FB5527D5
      F218E41FF18C50CD5DD3D6C7AE0EF9EA7ECC334CF5FC76A40DB82AB426F2DB8E
      461AFAF5BEF356E65AC8F9983909FFE34DB31F86745E78CE8F06DABC81F6D57B
      6F67DB5B4675F540C71F384A74C7F32CA291F24C0C47DCB3C7D3CACE21B51726
      481AF2C9B1E27A48C9AFA91810A5E117D96A78080B82FA9C48B4A20405E7A110
      8876E3E286F6B4B32A689A4419ADC9E4E208D68EC1315050062EA87594C1374F
      B8CD999D27AD0F5FBE6F031E49AE0B5E21A8C06CF35EEAD927DB54252387F82F
      2C9FF880733296B19226B1F04FC35A1E73F216F194AFDEF0C8DA1CA437EC90FA
      0C9356E87647025851FE092C23BECCC7E22188F209E1AC135A271846D38EBEBA
      CE3342BE10B59E60CE6202C7A0A0BBD56DC0CC7287EBBA121D4D2FC879F28766
      C67EBB696BDDC7B4B5F9F3FBD5C138B7B77E22C936A16C02DB1851044C469E58
      6AB12AAD2D348C1BAA79C1C1654873DB9644F485AA5B0DB795C57432826F7AA7
      3F4DD966389B68356033A8B8CC0DFC27D402E908AA8A2B47458445CCC330D20F
      EC613A6828A8D3890101DF95BC1BEB5C795AE22C939224C1B001E496B5B5451F
      A219DAEAAE231856F930CAC743E7E8CD613327BB43C80A4611725E1FED2CCA3F
      32CEA5864DE09C066EA2E86585FBC2803A4FC6A224366C160726B99D8EA138D5
      6B1D82F0A6F1DCFF2FA7DB6A35AD2F2E8717347B7FCB8EAA71DE67436398D8D6
      15362F0AFC94F3C21BDAD9687B6B671692BB844F301D63E38CB40251FC4D6B92
      3707EF8EA463024F182F5E9774B82BAD9F667B3E3DDD77DE0F6B6D3D0C2E8674
      A6FD240595D2AB26FBB5D98DA0CACEB40BF13C493DE0FE3B267CFDA841ADA041
      751E35A8790DEAAB83101929F9C1C4FD924CF5730EB8502363D3C28D01F6DAFB
      DD86EDDEF6D61BC97BD6CF136D52A0B5339DA45D932E4D4E8BB11A16FD2A17DC
      64A8EE4905F12D33B3C140E087C0AA280BE86C32967E84639B1044B83EC6E93B
      C9A942DC8048366C3D0CC41298AFC8D4E7A583979A0C16987292404FB03D791F
      59D60A2C2B7C6459F32CEBABE36258449BF747E774A62194594D4B9CDDC9389F
      469478C3FECE237533BC9812A2982E9A6A8ABD2AA1FD0919FBE0F0D8A41D4AA1
      64948D18E7996D17E3867DCD166C55463AA6267863BDBD351B1F178C74631343
      6129EB29163C5472FDAB08A298C3CD04FA393059268C838FF1D28B5AC223C35F
      7070BB060B015D755E5F7BEC3FB30AF70B1EB9DF3CF7FBEAD8128671C03CA15E
      0A9CDD409D985E9F1C9DD94E11C23D1AB67533CDE88E8EA96594C9CC387873F8
      BD7486DE39D25208CE27987CED60E63B0D65DD2C7F6A9D0D0A86F21B6BEEA962
      0078708D4B674A4A0EF1FBBDE00913A3B776343946722E59A4F01AD46C47CA17
      9B39EB1AFFE5C24ACE12303D3ECBA9D15E32C765EA54D77639647E8D9D18495C
      02F4ABEDCC5BC1183F611368D7765EC084993FFA4F398ACABD946D220D61660E
      2BA722370A1DCEFB091A337706CAB3C6DF202B38AA5E353A6CDA7005E07A691D
      E9D9C9F19B66362538E1F29167110346541EA5E2163A97F4CBDC9146CE5293B2
      233595BB1C83ACB54DAFAB30D4CA889A484CF2A631C81D532527B368DAE00EC0
      BB6E7FD5CE9BFC4206481EC9F1182671FFB6EA63FA00A376571D358F51E1FA72
      D43C8FD475F2CF6A3D6DDFDF5CEDE19B57D57BB2FE757F7112103FE68FAAD9BA
      BA1D6783B2736F3F7F8878C783EDD4FBA89F5D93AFE9743AA4EC7739CD27E39C
      4286D451EFE27E288D15160BD3FD1D501A2F9E3FBFB9B9D91F5264132664C1F0
      14B919F5737AE7B9DFEE86DE1F829CB1CE807EFBED37CCFC1128E3D182FAFDB9
      5812D631CDDB87DB5B94CC963B794A90D6DC3383A402AB7FA4CFEDBC272FF00E
      A9FA22945F52F110C5BC9E8FB5C2D3232A062B15450C69CF39D3FF6474883DC7
      B8A8D903BDE7E849BCDF3469FD6ADA278CEC1129215754C22E9EA5B163DD6A6C
      A29D3F3A4C567098F88F0E93F9E3DE00DCBDB9181725FF3A3011A8291888BECF
      AD28C98C304941FB934F9C42240D6519163D87257F76C6C8426CE85B85BC61BB
      3D8BB3734DE52F9C915B6B2E057AFDDB87B3F3660E9C9BA44B97353EFC843F31
      1DB13B21D204AC51A661D4404A9B399503F6050D724E3AEFEB0B15DF3AA7EF0E
      DE1A673BF94BFE6A28CC8009984FA4CF11B98AF0FB2DFDFEE9F8E0648FBD6410
      33AFCF1A9A6765119A178FBFF4A9F01C67BD2AD361A1522D7EB0D16D559E66ED
      5C0612225E2BE7F369E32AD5A87DD5DF9D7779D9B1374F9DA3D7076F1C2AC61B
      35CE89523648103E71B7011D37E9511749DEEF138C111EE0C46355501E31F5B5
      314993B65976A9491DBD396CDA5CA96AD0D9A90AFB774C9B1B825FA50267A3E2
      996E3DECAE4CF33E49862C3589A454EA400A60D3787D999F4445E910AFB79530
      C3167E0A7DE35C6ADA967C8FF5750ECF4FDFB0B2C97257944F53CB4818B94480
      69A5963EAA9E2BA89EDEA3EA39AF7A7E755455231ADFD61B955A8405A2717166
      D5FD8FD84D6E6B5ABC78F440DED9CD667820DF106F1045A7D8735E138B85C13F
      D210964DDA320CEFC5ECE8F69CEFA9F3F1891A4FF0FA958A1F2AEDF6C1C67CAA
      62FDC2F95E65630CF0F8563772610F05B25C8F1B35AA532D598E8D1A14E5213A
      D439A751A3FAC1DA5BF9F08573301EE463D8285A8DC841773018E47B74B41F85
      69D384A9F1E390E9F29C0DAE9FD867A3C7942E41CAE387A353D1D4A58A9BBA21
      D97EC710AA45A12E44B3146C1F307075FD5680311AB6D973FEAA3B065AB1FFA8
      1C345439D8DE7A797274CEFD676C0EE72DC8D066A727E28F139B9A8B0519FB17
      76DA7022B499A55C4A3371FA8A9257A1093ABB554E973C8D6D247AD04384121E
      52E1806132C9086745B0D0EAA3A6F731DD447FFAF2EEBC079B12794A1D65A062
      66F1DDAA99F1A41A37EA62C2B4737723F883E60DBA7467945C9961378657ECFF
      3BCAAE31EE493E6E5AF0EC512E5B2317F6847EF5B333BACC879A72CA6F58129B
      188A380C4D96562DFBB1A192B7CCCA2F66F3CB78E41410E223B62B931B801BF7
      99E3C706159B1BB8E3D2BFCA7515109DE1240C90B8BD35998A6E02CE4839F729
      F5736F5E774C1B9A91DEBF05F53479A68782F3CFF05A04B28917040A7976FC37
      F1ABEE528902018A99AEE2D6452CB0A88A522663DDD4A996AC48320C3907AF81
      888992BB79F8FD814D79641AB4399C82FE71A9FAD4AE4A3BA69A8F822F47E404
      780B5ABB258F7D336775643B497018C58455F6E49029691062009F66CE2727AE
      9A4853D326F62EAFB57AE751EFD021B922E97C430049F4974055622A3B4D1BBE
      8DA1701E3746239537540E69ABC8B32123CA51FE735201FC3765FC26BDF655D6
      E79EB138D787267E2549A0FBCEBB9C7B9B6327C4AB2E3B95CA0D05F455AA2895
      9DA3ADE27EC6CEFB1F28037C22D337D7CA02EC816CB7B7288EC4BC9011480C24
      167788F9944D2C76D6C5580DF60497E4CED7194B96BE4D8F1B08286C16B48624
      60CDEB869EC333C181330E01D62E67FC0ACF39C79C28E0FFF6F30BCE05998E72
      06FF6E5C3712D15306192191530D211327132F64EF9389F47636C14D896BDAFA
      C171153634B4B6BD5588452ABD5ACA0E3E827D434F27B2E58773D125E7A3E30A
      FE0E7E227DD19E339A4E38723AAC4756C7793EB19155510CED8758571D4F27FC
      34561DF0F05D9B46BB8F0FF71C6CC88FF24A4FE247B0AA95A281EE633470DE50
      FAFAED462475FD4C4A0C9AC64BA8254785802BC9047ADCB4514A6509348F88C1
      FA1818890A2069F326845E43A892F9B8714D0B4E61130F2270BF515E987E0B60
      9BE4D3D0942D44DC70A018B5B989CA5355A52EF91A06799C75C1B3CB2C9DFCE5
      28EA1FF6B3F8AA6923FFE5A0DFFFBBF3D3F856534FE24BE9C747B17883FFB6FB
      DBFC2977F994CF8FC95F7550DB5BFFB6AF8BD13E7FD19D87FF5E16F294E8DD68
      91625A73C3854612CD2F076FDEFCDD79F5E6EC9C0B5A1D1A952454CDFA509B39
      EEE3A3D7478E2238746A1065C1BF4A2F75E3062DAE8B7AB5011F538A6D1A7AE9
      D73EAB007394A120028BB7BC755281E634749ECFFA2F6C7C847AA80F889992A6
      E61498497C29607339839C0A0CD9CC6C1BD938BD565F4DE649C68D05CDD689DB
      8CBD37B51CF5E794C8CE79EC6CA5985C464DD88D69C9E068728D9B2AFB7824E4
      FE364F7E80D2FAFAEDFB23EBC6B22894644C5EAB310399541D409A3999933747
      EE2C18C09D5640CCBAA1B580669B380789A94B77048911D571C1B911564A3D48
      1AD89DF5176B2F5ACF7D7E43E93997D9C89294547B6003A8C2A0C1C33F1BE637
      B7CE8D560C3C564FC9CE3ED5E36107E3C9E520CFC78FD6F02AD670BBF7680DCF
      59C3FE57EFB79755F9EBF3E92D44E1627F72B082631584E165B2061E497E0592
      7F04AEBB43F25FBD83C9F6D62BEA32359DBCFB91C9994A4B066A7C65DA735944
      B72C7592E908F6060793A58608E7E19A5A0C11CE336793376C77A51D1B570989
      8F80FA037245C7C421D013E92C356928D2F60E95A0112F9292E762A7C441BDCC
      A7FDA4A6CB499F24DE223D5159DFB9CEE8E8B11F8AEC2DCE067864502B30A847
      6CB93B0CEAABB743D9DE4A1840D389C997477564CAE2B39B788ECDA365B29726
      A197B9B452E59AAE7F4C0723839CA026CD8462BAC3AA62DB4476A4C757965151
      C204CDE3784831B2933C1B360D906D7B4B8CB53336D61853864D6679F72FE6FD
      139AD3B1CC89BBBE51BE0161922987D140136A79C6EE1F6A8F61B3064BC0297A
      20ED7B5936C9293F0D5B09CA0799215A4AB51A4373BCAD977B6A66E4374E3ED2
      A46292AB841D648EBAC0B01B362521D26CF86CB4BD45788276ACD4DFD1F61D8C
      C926976EC539E1FA4F2C1590378CF5858C582F4D8652CF2E2886AD62AA32BB91
      A6295A3E1B12DC609FDAA20AF67FE3948BB78C4C2BE9F03C3979E3D4C0D492C8
      954C57E3392228E09F24F1FF8505FAD69FB06819015FABFE9EB52E781D62DCF9
      0807FB1991EDEE07FB8F15A67724F6576F8044FEAE827AF8E9F1641122628CF7
      29AE78D77FFA48EAF7907AFB91D4E749FDAB77AAD8DEA226ED20F8174EDACFA5
      BBF588F432167F6A9C15D2E381647C9F72F376D2E9AFBFDEEE50E74AEA38A9A8
      855241C1203A0F941E3BF718CC37D2637980792419B094ECA4FF39557D46D481
      D8CCA71797D232D926441AE5987B6D53F0657B8BFE54713C1D13EE0BDE312ACA
      AEEF44B713FD74FEABA5F7E6BEF35292A738EB8F40DCA91028969C71CE9AE2DB
      0A51AE8D6D4A8D4ACDF864D0E24DE0771ECFFA0A67BDF59F5F699516FBA3D65E
      252F9C3D52E51A6151788D5638593BA75AA8DF987B126CDCDFDFDFF903D7E6AB
      3668DDDEA2BA6E528719E4CF4489A5D42EE326EAD985448F2763ADD9FC7DF61F
      CEB26533ABB6F06339DDE26962A3CB7E0836615192224DFE266E48684C6929AB
      909EBDD4A0EF962372E32C29DB7999AAC201AD1F7185D8D4A927650B5E7AC653
      823AE4BF9883713D87237F49A31B7641323FB2B360F649399F854EA77D9BD1CC
      06C660DAA76EF1D4540C5AF894A2D4139BCB0E5139E49E3AA2B7DBBE88D3C974
      ACF718375BF531961BD3A351F56FD46D41D6CD354D4A193F67D9D67157EF5FEC
      3B92FBFFEABD772258506099B7A685317D30C485B42E7D351AF18566694D6CBC
      AAAE34A3DD736CA1CA405D91FD303629E0C3B2311DEC487E3C990EB4453617A4
      7CFCF6D651C116357D093D8501E04D4F3ECCA1563A329F0F142D23DC68064D75
      9533FCD3C1E9BBD7EFBE7BF1E02947DB5B958384D6B046AD8AB3A20B5E0A5950
      A16D5E4B93417F211DA1593409AC3F197092D68EA5BD1252965E93F2085EFF69
      C1A49415F65D7290B3D55776406102A4BB130D8B3E51F3BB3AD4825D7969BA54
      0FF8B051CE041F09D06D4E84C472C01C0082EC158A90D359B6272C664F0D0F5F
      4966BEC57381B4C72924315F261F1E80BEF7669B93129DB0179F1624EB5B607C
      C619EDAB31718424E1CA02750351BEC330ECB525C3E726EF9A5A554D47F4CAFF
      EEA550DB782AC8F3D32145BB9513FA11E666BF1A1BF613278A3D9A009F570BBC
      FD9673FCF3C9F1E9EBB7C7EFCE0FDE3CDA03F3F6C0576F03458E313A3046C492
      924D6E2C4A9590B28E3B81E53D6300989E1503621E83DCB4539D91BFA63D3D01
      3225E0FB2214717477E4CF984B9F0C43DAE1E3A9E89CDD72CE0CAE8E891B4113
      9FC6B6346A94538D7F463590107BDAE4015FEBB261F0CE2163FD93C3F5984BDB
      76CABE464D4B58C98D28671FE4B0C65F70D8EB9015A5DC1DE4C5C4825C99EE26
      C62A1B6835ACE90CCCE40ABDBDA56DE3DB825A1C80CFD503A4E5E5499650990B
      7F70CB452885EEA7CE2EA552D3DE0D9DAA92A418EC398767558D2EA7D4191BCA
      7A8B23CB526916D02D5E73C26A0948491F4861A23075BB3FA6AC5EB01FAD4861
      BEFE6C980B8429864F0762A04582F17359FDA93F9C8E13AD172D8099AD540E17
      A2F941D26279AEB41EC9FAD3938BA733DF4EC54BB5AFBFCC88FAEB03E0EF3F9F
      19BD6959233EF1677CF9C977A747A2AC6A35EE1318B4ED24D63052A4AA857222
      1641344B58CDC8060F8688F490437E39BDA06C2EF6E48B856F82CDF1659EC536
      CF33D252C56B611B440F69D854B6B7CE41321F8652F2C77CD054EE569B628EB4
      285827145E806274F8FDA9F34B8B7FDAFEDF89388FA5A0EC44318FA894A233DC
      693E3BE36A09ACDBFB11734FAE9C901B8C9E84AFD977BECBC44D6374BA917CA5
      8DE453213AE7C8E24CC81A6F6F555D41EB8E9532CE22F99BA242F2DED8DAB59B
      7CDCC74DEC16CAD2CA2534A2B322982EB55ED7B43A92A02BA5CD52FCC1A1B892
      FDE0411CD348AC54B02A74D344C08AFBCE2C8EFC69E5627215008969C9AD6759
      6197688F3920785F3FBB920AC11D4115769EBCAECB5D09FF3C81794D52A69293
      4E92372FAF5BCE4855AC610E3B2D0A2503DD144E3DE6CE1E479855147536A683
      2C24B42E62673107EA0CAA0253ABB934D1E64D5A5BB6A784E2E23EA5C18BF1CB
      5F0C7A135AADD52E5FAA44888F8B9AAB928C470361A981E03E86C3EEDA045FBD
      B5C7F6D677E46F38B3E5F3BBDFBD3D3B7F2A47884E1C57D2976CBDC8FBD7DCF3
      8D4A2D72A99CA67EC97BEC631389DB3476726062FC463E9CEA0B51E14A0010CE
      AB9519B2E523868B725E51E8406E7E3CDE2B1CEF3F342CF0955DDFE7751795F1
      1B7305CB40FDC3B472B43256F5B3C9AD71DFD64CEF88955A0A6199348DAC58D0
      62FD91F03E4378EDFDC7C2FD3B52E5AB7790118C13EB004FB33199E9E42AAE42
      B01018D0CD580166E5B4619B58CD40392ED921B3A3E74432D567370D35A25384
      45DEB02990A55FD6E1526AFC453EBE7576BECF1298066421BFCD13E73B4A96DF
      B13D2BA04847DA40EAB0846FD89418C0D6F60CC10CACFEE180E7BE233D46C88D
      1C55177A527306D07B4309AC80D814177C565D8D1A36CB124E6D44A754BAA39C
      28D8F7DF8DB3C655021C601D39CCB7331D1234D770C73A22C998622783E46A98
      3C5A0A4119959211591B369DEDADB379C373973BDC71878D8C63654677845D5D
      5C65A33D723C9AA2933D677FFFA949168EEBD17176CFEC9C9506E7CE5EF9D7BB
      7CA8C523BEF39A5CC313A71CC14EC3164771C7679ADA5402D8924B6A2B6E6CEA
      739EA6594C8E7B5352DDB059705A544A595115938F99B1DF8C738A465A4C3128
      4455AA0027BE96E0BBE210C8C67444C96B659DD3CA12C72E271DC8CA3CE5DD35
      AE77A32C0A81F0D31AB63C5025F4982AC827375A5D5511094D21DEAC18185921
      31FE1AD243DCA7B74A077CC366C592232DF73BABE214DB5B2698B053B6A914EF
      1A37AF1B8B4B7CC7D905F117CE3FA7E445554E24696BAAEAED0E96166B419224
      5DE1E9BE73C018AEEC912A83D8090EBBE9CD855191B7CE7C59E2BCBCDD99E994
      679D4EB556CB3635BFAA991F57F713D0759919D0D0D2FFB715B320B7AF1A8DFA
      149E32D8D61285B709B871368EA70352ADE226FA28E77D905CFA33CE6FAC9F81
      756FA7A0CC9C32FF89BD2A544D4138FB9C5950FACF6F8AAABC80E18DACEB41F0
      9A06148415C08E811EE4FBCE595E26E2905CD5AAC8D8725449D5ED7CEC44797E
      D5B49348F1845BCA00BD705E3FB9E682998B9C9DAA2A228EFBD7C7D282CFDABC
      8FD9D6776CDEAF8EEA3DEB4725F6263533492D370247B5611BF7CA4682B8D48D
      F494130A7A7392C5613E4C0CBE00C3EC42A6243C1DA99D6A9CC15BDAB385B3CB
      BAA93014E6A57DEA91DA342C7C3236ACDFBD960072D7AA10C5E5296F83E4E33D
      97F26B464257CEFE44173E8998120697B35FCBA07041B4392213929BF3724BCA
      C2047BAB0EBEBB467FB7F05714781CA9C2F8FA4DD95C891CD5B4C53CB1792163
      CE446410F27A810FAD9BF873AAB53190D8955FE702FAD90AE247B5C1D98ABE1B
      F4F09B64F3C379AFEFF025AF1DB43AB3EB66D6ABE3F67A3DAF6B5BDBFCF65F1F
      FFED23C5DC35B7E50C5A7ED4F25A7EDB6FB55A21FEEF4AFA800BFEAB7B896EA5
      519AA626A5206EB9FCAF277F0791EF8569A83B7E18D0EF200DFC4EAFD30A838E
      1724AEEE74C3248C55DC6BC791AF63CF6BB55BB8A8E377D3B8EBE9C04D7CB5BD
      D58B23175FDE7503DDEBBA71A7ABE38E723B71DC8ABBBD9EEBB7C3B897742357
      75820083E9F871E206BEEFAAAEDB6A8761ECC649CFF3D24E4F7B91F63A6E94B4
      D356270A62AFD7EDC5AAE32B95A6AEEFBAF81A1DB523BF13242A4852AFE3A749
      4F25DB5B41D8ED75DB6DD5EE7A71D856412BED75533F52918E62B7EB75BA9D6E
      CBC7C37A2A7055D089748839621C91EB255DDD6B75DC76DA6B293F7153E5755B
      6E1C79412774C36E2B4DB09C3A4E30F47612B7BB3AC253DA5E577B71CFF7928E
      0E5A5E14C2B668B593A0EB255AEB20ED61197CEDF65A11C6E0A55EE86B15FBCA
      F75ADDAE177971AB8785D3B1EAA63D1F6BD30E3137FC19F5DC4E1AB85AF92EBE
      45B5E324E8C558A9B4D7EE452DDD0D7418605BDA5EA0BA89765BA9DB8ABA71DB
      8DBDA8B5BD458B1DA4711A4216B6F1053A8C522FEAE96E0FC38F9230E8857114
      27986FE4767527F6C240C73186D14ED3B61FB6D2C04B75B7ED255E1C63185127
      155A49897A402FF7D11976036BA03A78ACBCD9824AD0E61791A1B4B4E382C6E2
      8EE7A6A02BF3BA4B8494868A280BE3EFE8B41B440996B1DD49B0DE98591B5485
      9D4855D06BF91E6D4F27C186B4DD6E270DBBAEDB8E125084C66F3FDDDE8AB1AD
      2D154558672CB74ED38EEA7949AA95EE46694FB77BBEA6D5097B4AA956187BDA
      F5417871147675BB137A0988330505F7BA81F255C70D5A180E88A7D50DF1BDF8
      8E8808380E5A495B7958A6C46BB72315F8DD28F45ABDA0ED6217D26E37E9F974
      95ABB4EF867ED2C60EB71217030A92C8F343D7F53BA9EAF4DA9D7690261D505E
      9786A6B16638195E1AB4431CAC8ED7C154743755DDB897A6A01AAC511CF7B49F
      C66DDC9FBAB10E7C6C4A8823D3F3FD38C4472146A0DA3857A9F6022F4A40D3DD
      30502AF1DB3A694541048A4BC23491BD596567C3A8D3EB85EDB06B384657959C
      847FC039F00DE012819BCAEBEDADFA5FF4DA4FF0008DFF3BE02BAEE52A984CEC
      272DECBD4B5C057BDA4954BBD3E9B5C00DB01911C8D40F421CFA38523A8A528C
      CCF77A715BF96DF017AC682F055DE3046AAFEB791DD8C6A0631C99687B0BF3C1
      0B6C64DCEAB492AE0A03B01CDDED125177C06F5407FBD64D94DF6DC7D8A8388C
      359ED9C601D3BD4EB78D158FFC2E0E5A92FA3D90A517606C6015A04150461205
      49E2B692300AC0AA02B7ADB1174912689C5F1F840256871174828EEE6237C1BC
      4165F81013C186B65CAFBBCEFAFBBA9DFAADA4C3944D1F456DDE8176B86CFDE5
      F5F656F597D7B66BAE637094B44BA7256CFB912642F2D2563749C0DCA228D43E
      BE2D8AE2B8DD0B35AEEF4598A91FFBBEF6555787380321F6AC138295E17476C0
      5931279F8E8A1BB7F16FE2E1720F1C3149410738273865F8729CE114CB15E130
      84BDC08B71189316EEF5825E0F0C3DEE240944800B5EE7E2F4B50370579DE219
      3DF0B0045C258D13BFDBEBA834895BA9EA7582AE8F3DC7A281BA7BBD8EABBD1E
      8E70A0701CDB51CF0BB1B398604AA7B1A37084550881D38E414D9EEF07BDAEDF
      236A72C16D319C2469A55E1A75BB7127EC742127BC30EE62BF7BC4A15B2A6C27
      9D96A793C8059FEEE11B5AB1F2B04E6E0FCBD7EAA6BA077683C180285DADBDB0
      D769B7714588656D830E12377413BCA7541CB45B90A3E015E05A7ED725BED503
      DB68D3F18ADC1648149C0B9B02E9D652F4189C743F062B8BC34EA221DDC2A88D
      D58400D12E4488EF431C763B380F90E218B8178649AF1B42EC76750B6CCCD351
      C7856CECAAB6DBD29DD4F3751284014849C7DA2539E5BA09447B171232494357
      81F1F6824E9C825F41D4436CA6F83AD00BB1CD14ECB6079EA871107B49006501
      620E2B883B63903AB629091558854A694E2DCF6F2B10840A3C176A56A4E214C7
      A6D7E9789E8206027A49DB0A240D42EA4183C019F3DC28D52EAD481C4066A5DD
      904476CFC7964778176241C769A7833D84E0F22330669576A0BAB470B0A02E60
      36D809229F3880EA82530E190911D2C1CAF6A0A1E00DB042B7DBEDB5340990AE
      0E3A2A49BB31CEAF0E7BAD568FF8BB8FFD8F3DDC0E3E0FA2C2527683AE0BE9D4
      0539453E84510802036987D82F3090B8A371F87108FD1E960202DF8592938644
      456004412B0E3CAD2001DADDEDADB68791A4D84E2C6C84E3D55501E919B4293D
      DDF37A10055D3C3E0D3AA028172B0EF60DD9076EDD75DB1D3007226B9CB5768A
      55C22285C4F041C518438BF6C36D8569A053AC1C78189640471A92A78BDDF03B
      107DF1F69617937886F085F04F7C1033F857177A9AEA852A0D205030F654E3B0
      29D54B412629CE20586B8A9B21827C688669AC71523A209624A25B7AAADB06A3
      7503929378680ACBB19BB6F125FC97073D08BF20B8202C029C051C1EC85DA8A2
      3808D81937486210418203D22625102BD5EA767CAC3B3830C69C8033432E80CE
      A1DE417662117CC8DA38863AD082500F705918D1445B6DBF4D5A2BC819A2153C
      B305AD08229914D204C382DE958259810EBA31F4A1B80D4513CF06530103EDC6
      60F46137EA42E388B0DD50B23016A8775D1036860F81DB0E202592C4C7DA41ED
      F5A112A42E0E0FB81878540BAA710F4C25885305253004F7210DAEABA13E7615
      1E14BB104C6DE862B10F7ED08D5AD04BA32EB8730702C66D2968B92EB4A1D885
      64C13521EEC17642D4637431E6AE0205ED20E981F560F35DE8E06D0C2D063F6D
      83EF7521298376CF23B9A4BA102E1DDFF51362A25D9C4128B01EE82306AFC624
      12AF079E486A2E3884DB55F82E30D40E3DD88F5D282D109078170751B57AD80A
      EC3A681ED4D5C12AF53C8CCD87FEE675416AAE22260AA2037F83A205F53748BA
      BEA770E021459296C695983398960B8E050D14E20EAA320435F483764A060314
      274DE799C99D8E0E3419FC0F7AC7982120C0F2126803AD0EB4D3C44F30CEA4EB
      E264FABD5469524C7C70A7208075104154428B056578D011B5226E1682D9419B
      03A386FA0635BCD76A6B3C2FF53D9C05AC505B412E47D824E88EE08E78091E0C
      0E97820183970520073FC0A9F4E9A84136E0CC241A141F8769EC296C63043AD7
      AE07969542DE803A306C0C1EA73489C220F27036C0F2B4C68171C304472B25CB
      838826C508B46EE12FE8CD60CEC27DC1BBC1A0758049401C4266A5BD147A1106
      D489F1EC36988D1BE179383BBE0A3BD8B316645E0FEA3A09042885605DAD48B7
      5407C68317B6A1BD27B07C4037605E386D786EEAB63D1C8056270447C2DE45E0
      D6A0E31EC40C7617C7D6A32B71295811068A2786294C601C1D856F832984FD4B
      94EE85E0E090BD3D5874601F30BC52183F11496D300C285C3880108FA0DB2022
      A3A903D5A4E76272D04271523A2D1FF21B9229897AD07DB0381E0E90DF8A497B
      C261028F85860C3102EE044B06271E72094C1EA4D882DA8095C7B747A0D82480
      4E44A40A960B06032B8BAC49329DA0C974605CF6A0C9B5C1F3558079631E3D92
      485112C7D0CC634D561B541D283C61D80A15CCEF16A90160DC0129A5D0892093
      2143C10014643BCE7BE041450F703E712041FED08A3064281A2108D0F75B21B4
      D3007207562894ED6E828D83DD8877030826B079887288539C3548723CC60B30
      8214562C94635C09CBAEABA025618658292C1E860F55000BA2228C8DEE021B0C
      A14375F0752048F07A4802ADB09D6D0805B2063A385531D8B41FE2B0EA304DBB
      29E40DCC5CFC05790A8B06AB8BD5737B9E82229E90DD08AA806E14334386B283
      558699089EE94355557436DD804E4FDCC5410AA11B78D82AC81B0D13087B838F
      74883305450E7C29E8249E222609C30E164E87C846F5F0D82EC40869D71DE8E3
      2047F0DB0E8CF70EE918D805B268C16A4802E2F4BB309815C604A9E1B57D3C57
      43FF707B60AB21941508703063283938DE30CEA05076B15758E25EEA7662183F
      3EE472BBDD4B5A5874327521CE30169AB30E2067C1527A418C8582AA81E56EC5
      2D8C005CC4ED411DC536B703DFF361C9C3C6C616615FA09385B1221D0D365982
      730E5D0F9446D639587E029144EBEEC3B4839DD1F33CD80211E49D72415AB04E
      C0A4C0DCA3760B0A0B647C005694601FA20E8E067928B0643EACB684B49716D8
      722F85651480DB6164E029AA1DC15A85DE40FCA115C52E7425DF8DA004425A25
      9D0ED4653067D8BCE038D8B21EB970485B893A60906D902F240DE40C7B466091
      60FD6149C122C4E4B09718484A13273D115F090102BB324CBAD05D612DF9B81A
      FA8D0BA5013B10FA3068DB3196073C105A3274884E07FC036F84D87BA83731AC
      D400F40B930C821FFB82530EF9AA6998D0E36084B43BBD98E79F449047E4D8C2
      1A2424E212502298700C6E0E93005C02148B91C6ED16EC9DA89562E26EAF03DE
      EC693201498B82744B340E30540E3A6BB079A11C853D8841D00ECE1F34B64807
      3013A1B692D38196BB47A4ADC1BDB16DB09DE8D0C0EE497C1A01E800130C2118
      B0632AC55E40A180DA032D0D4C188BDF4B940A520DD6E3293CB983F3457635A8
      08063E961C524141670A6985B14701184704BED4C11185198FF7C06440C3A006
      CC9F840CC812041582CDC650A4A003C36E845E03098BFBA0F2402C610458C355
      ADC5169856AFD5A3D18A951E89A5E976EEB7162BEF0C64E3672DF759FF0DDBF0
      A495E060E044BB1D7297A4213848A4C8E2013D25DD2E2EC2D1214349FB1E0C43
      32906016B7618B243013C9A2E942BD022B033FD0BD1E94DBA8D7810ED8837286
      43956830269C655003A4112E806EDF838D0139D585D6091D1086382440B797F4
      3C8882084BD3050308C15F75D2860AD383C1EB767D32C87C983EF8360F6A7807
      87CE8540850A0E1D055AB99F4247C2818281A9A04DC1D2F15D57790A6A3C6CB7
      2881F0822182530BDE466E39A8BBD05341C5213600F21D52A48DE1073029C86B
      8365801ED6ED85A04F8849D85FD860A8AB60255019894729723FC4386650E614
      9D743F86C512809C40E1507B64E766761FB2DD4DA8406C7D8FEF7D3F756F30B4
      B4A5FEE0CF8D81BC81F7F90217FD782DB96696122B4AFBDC777ECE4FB5E80747
      C5BDEF54D47D288B4FC2E746F539EFCDA21FC8A47254D88505E35AE4D9F9DC48
      3EC719168E04C7F7BEF5A9FB7457E7193CD2A055AD4020FF07C62B16C72D653F
      FA6D7B8B821D71DECFC7454C218F81C12F8155999A27834FD337753CB056502F
      6C2A97D605E69F0BAB18073824AAF6F1294C4BFA3480B8F761757A5DBA02F6BE
      CF23A6DF313D01EB8AAB3A3DA27A3C0B6A3DF44E459105B001F0EA0ECC07B262
      A053B4640C382B1E3E237B0E0640C7C77F2D6858A94B4E0ACFAC0CCE3C8CA3B4
      C36332F78521AD217DE69B4F5DE214B0B35CBCD79131F32CA1C8793825300D53
      BA3EECD109E519E20E4FBE196A0D664E73F2A15AC97B7E18C97B7C9D5B5EE796
      D7B9E575FC1E9E4D63E6789079C6CC3BD5354C9DF49E7BE7AABB4FF2EE5CE3DD
      B9C6BF738D7FE79AE0CE35C19D6BC23BD7847C4D172B4E2B1AC93ED9BFF833EC
      4418FBB357CCBD87EB400B862629D03C9C1493DBBE2E3EF68BA4986403F5C9EB
      04F4473F8FAF7492686AE68E8FF420BBE46C6CFBCE7448F5E7946F6ADFF9A7A4
      A0D93F47E32C1F67935BFCDDEBFD57F548E943E7D4EE683BF5EB5B4E756DCB79
      C7F8A57F5D7A756FE6EA4B2D81D3F65FB7B766872D7755836E2F1FC0E247BA7F
      7DE0077A0FFD40FFE1271D3CF418C3877E60E7E127DD7DE831F6567AA0BD2BC3
      11FBB43205CFDEB51A91CEDEB31A1DCEDEE36F704FB0D18C562398D97B3A1BDC
      B3DAA6CFDED35B7146963ABC59F298E431B6F9773E60B51DBFE701DEEF9FC46A
      D470CF03566333F73C20FCFD93588D68EE79C06A1474CF03D6631322189DD743
      024F58F368A5793E19724774FD69B2D6B7AA21EE335089EBDE4BEC508FD7BA85
      068A5B36611C86F96ECECBBD60E6A9B1E20E8A6B0D5F3A5FE7A9936617D3B12E
      D69C881E5EEB7E3E2A61E3D6FAEEF2E6B19E4CC7EB8DBBA48F32677F5322A91E
      B0DED4397D5C2A90D7FAEA91BAD8E83EE8B5BF63C2F66E3E12EB4DB42411359D
      5C12DD657ABD7D1EA8789CAF4795B95AEB74D8FBDE64C5BAB3A35B9C97D37E5F
      AFC72AF8BE77EB6F23DFB79E12C4B7AC2A04676E5A4F09E25B5613740B566F93
      49993B379A9BB97783299A3B3798A9ECF7263335776E345373EF0633357706CB
      8DD3F6AC2D7B9E4DFAEB3196C37E4E655A6BCEEB2CBB182A42E25D4B23997DC6
      91E9AD4B29F6176335BA745EE5C3F50EF1CB3CB975CED7D512CABB36536D7867
      08ED391B4ED75BEB993B37A1C2F2DEF52CAAD97B5735E217DFBDDEA97B6BFA3D
      7D5F29668BC9788EBCA6D1646D4A3E53FDA9E8046B4EF0484DD6FBA68A805E31
      988321A3DFFF883569E21D6904DF1B39BBDE9CABEF5FEF2BABFBD623C1F933B7
      F1D79ADBD765C42FE9C5FAACE2FB5B8242CA86576BDDF52A2764369DCCDEBD90
      F05D7796862754746DE6B6F88659867F3C185DAA225B4FA13BCAE329E391BF55
      A3B56E3CA16A96F557F1F8D9807A1D564263BDBDFBFEFCED1BE73C1F910E4BA8
      5AEBED20DDFC924A2A071BDD6F8CE0DD9F74F474FD2F3E80E63CBC1D6C32E183
      0D2C32BEF1305B939DC95D79B2C15D472538F22653FC41DF46B91A27EB7FEF09
      AC283E1C13BDC1DD678A6AF6D6BF8FAA026F7008D7F617F0DD3FAA7146A6D826
      E477BEF68D350BB99846FFD0F17A47F65DBE8931F65E0A88456558CDF1B8F0D6
      F584C3CCADEB89A5734186CD881ED67688CFDCBCDE90676EDD64C8878C2FB1AA
      7777F1BDEE46F3B577FF9E51AF670A997B29BC4D0D44369AB2BD79C339DBDB37
      9A74DE9F0E86C5A6E3E67B37A12E7BEFBAAAD2ECDD1B6E15DFBB9EAD20F712AA
      D3464BC5376EB6BD7CEB265BCB376EB2427CE3C6CBB36A2C62C1ADEB05AE6A37
      AE17BD921B371003B51B37DBCB8D85C0060EB7DA8D9BEC25DFB8D95EF2AD9BEC
      25DFB8C95E7A47A6B5F1668CAC76FB66FB5A7BC0664C7838D183513E56E3DB0D
      6E3FEEEB0BB5A6892F779E8CF394909008166933FD621A4D5839D9F8D64D8407
      CC9D8DBE92EEDB6C83E9CE357D0A04809ED7ECD12591CF8A8B6D30A173CAA75B
      785FCD288E357531D76319CA3DD6FB1D25FB6CA4621B25B11785B326FE1BC64E
      3ABBACC229E585ED0517B2DA3E7395BBE0AA7235CAABBC99ABDEEA249B0EECB7
      1A5228AFF5EFBBD66E7F7975B0E8EA9A6C282F0C975EE8CE5ED85974614D7328
      2FEC2EBD70EE89BDA5177A33177666F7E6488DAFEA865279D9ECCE94FAE3A25D
      ECB88BAFBDB3911D6FF18577F7F21E02720EE2985C3FEDD528A9BA7C6E539711
      D592E7DF4F5D4B6EBA9FCC96DC740FB5CDDEB1EC3C9FEAEBACA83C1A8B23F7FE
      DCF48B5A1CE31E6FDF2C99FD6D9A1B57CDE22F99DDC6D79060C342D7EE5AE5E0
      2C59A57B4ED0D22DBFE7302DF9967B4ED5E23B961DAF2557DF7FCA96DC74CF71
      5B36F5FB4EDE92A9AF7004DDF58EA0BB1A575F72F96A07F00EEF5EED08BA6B1F
      41776D025E5D042CB96305F2BD33FD1508D85D8B80DD4D08D85D9B80DD9505C7
      D2A9AF40C0DE7A04ECAD47C0DE2604EC6D2241BC353496255FB402017B6B13B0
      B736017B6BF3DFF9B97F8E80BD4D08D85B9B80BDB509D85B9BFFFAF3DBFE3902
      F6D723607F1302F63721607F6DFE7B67EE2B10B0BF3601FB6B13B0BF3601FB6B
      F1DFF979AF48C0FEDA04ECAF4DC0FEDA041CACC77F837575F86013020E3621E0
      606D020ED6E6BF77A6BF0201076B1370B03601076B1170B009FF9D9FFA2A041C
      AC4DC0C1DA041CAE47C0E17AFC379CDFF0D50838DC8480C3B509385C9B80EFCC
      6705020ED726E0706D020ED722E07013029E9FFA2A041CAE4DC0E1725BBC3DBB
      0EC6B33A937DB3D8E29F9D9FB5E1CB1BEFF331B4177DE5E94CFAF8E21BDD85DF
      B9CA9DB38BF432CFAFD648292D9F324B972FB3A89FE5EC19B9FD3DA574F35EDD
      F78765EE5BFD32FF8E77965296D8973B6BA2FBEED20B67CD27DF5B7AE1ACD2E9
      FB4B2F9CD73BFC60E9A5B36CD49F3D4E4CAE36940386377B6DB8ECDAF6A2AB3B
      CBAE9E9B7E77D97573B3EF2DBB6E7EF2C1D23905CC2F661E1BB4975D1C96A778
      F60677D90D9DC5377C76D916BB78EE59BF657EA47B9672C9772C5FD3C5377C6E
      6997DCB5C21A2F9BD32ACBBD6472ABAEBBBBEEBAAF4CC0CBBC1F2BACBBBBD1BA
      BB1BAFBBBB36912F9DDCAAEBEEADBBEEDEBAEBBE320759E6AE5875DDBD8DD7DD
      DB78DDBDCDA8FD8EA8F8FCBAFBEBAEBBBFEEBAFB1B51FB1DC6BFC6BAFB1BAFBB
      BFD9BA07EB52FBBC55B5C2BA07EBAE7BB0D1BA071B53FBFC9CD659F760B3750F
      D75DF7705D6A9FB71E5658F770A3750F375EF770636ABF33B9D975678B686525
      B076F5BD32B476DDBD2CBC76DDBD1CA4769D5101EF651CB5CB5753026B37ACA6
      04DE5DB69594C0FAFA2DB961F9422ED51A97AFE94A4AE09DC55D49095CB8C64B
      EE5C61B1974E6ED575BF57095CB4EE2B13F0921B3EBFEAF38AD5AAEB7EAF1278
      EFBADFAB04DEBBEEEE66D43EAF6FADB0EEF72A818BD67D650EB244255B71D5EF
      A88E6BACFBBD4AE0BDEB7EAF12B87CDDFD75A9FD8ED6F8F975BF57095CB4EEEB
      B1F02577ADB1EA77D4C735D6FD5E2570F9BADFAB042E5AF7605D6ABFA3357E7E
      DDEF550297AEFBBD4AE0BDEB1E6C4CED7726B7EABADFAB042E5AF77B95C045EB
      1EAE4BEDF38AD5AAEB7EAF1278EFBADFAB04DEBBEEEB6158BDC52DEB97EC9D0D
      D478B26145ECF7AAB89CA8F5C0403E0CC7BAC8FBD4D8CD0EF837EEEA450DBD8A
      09B5B46BB51917B32558A0AD56DB60796E6FF9D41A88D1233DD7D581E7B7836E
      D0F5133F0E0861B31DFA82BBE9858481B9F027942725AD386DB7754BB5A3765B
      E9F6722450F9F1A8D7051E99EA346564D06528A6EDB97FE73EA0FBD312A1F6EE
      DFE5FB5FF08790D7FFBC3F8FB3FFF3FE2C987D62FED57FEC48BEC6CFE3DEFF79
      7F1E677FFF4F005D234CE5FF8E2FAA870F2D24D4F277076F747A9FD31236FF61
      54F460B9DC6FC5A14A7ADD6ECF4DDB09353209038CD46FF542CF0DDA3A58F6DC
      6E2BD6D46D861AA0F5A028B5DACB348EA6FC2C5D810D7FB6B71E72747FC4CF43
      AEC0B7377BFA79A815D860F6D6F6303FBFFDF6FF035C6054E3}
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
end
