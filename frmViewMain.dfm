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
      789CECBD6B73DB489620FADD11FE0FB8BABB61695A9209F05D3D3DBBB66C5579
      DBAFB1E4AA995BACD8008924891608B001508FAEF07FBFE79199004842006549
      14ABB22A2C512090C83C79F2BC1FBF0FE2746C0F5C4F8C03379CD80DA73D70C3
      C4A71FA3F9C476DACE6031E23BC68D01FF4CD2643AF686A369D36E37DAFC6710
      F19F1DFE73EA17FE1CFAF42CBEA3D9E8D9EAF358C01B7B83742A66427FA7FF5A
      FE7694347E1F8CA3304D87017C680C6058CFB706E3389AB9E1603C9ABA712252
      B83E8FFFE9FC3EF8B7C1DC0DA344580D07FEEF349A8D76A305FF1CF8D4FA76EE
      CF44627D1457D6177CFCAFDF60485B0F995CF94972FB904318B24543F3FFAD6F
      AF62DF0DFEFAEDF93318CAD143CD224FC4CBD3B38B6375614A7D1A05A7D782B1
      4EA245EC8B182748536B96ACD6599D1AEC49032007FFBA30451CB2FBEDEC6636
      8C025E6406B8D00F6E1F68E5BF6FBFF8E1C4837F895CA7DD2A9998DDECACDF88
      A551BF7DFE00C3BDF7BFE27D633748ADFFE773E27C1A2D5E896FBCF2B237ACDD
      15DC60DE68DC70DC95137736848DB13EB8E99407EC6EB2CD63DA12DA603D60E0
      C3881200ADE6463B8D58D32F0E17854914B809CDADD5DA0C05195D1C8988CD6F
      67621209EBEB3B1EACFDBD7BF3BFD5E6C8C50630CC3FA218600867FB010EA037
      CC8D6F3F2866D17AA67EEE7DCE6668D15C8F16D67B7F324D6935C3FCE86507F8
      AED052FBE187EA0D1B9D93DAFB918DFFDDD8546B3FB2F775EEE998F24E64E376
      EF1F4EAD4E19796EF678546BE931EBE4AD222065F3717047D73F7B13F36BFB65
      5BD2B14B1EFD3116E2821E6E979D5FBBE3943C7CBEE0F7B64B8F66B75BF2E8FE
      4F62188BAB03B9E8B6533A4219C0F65FC5EED01F1DF00CCA8E93DDEB943CFF1A
      30CE1FF1D3A54CABD32C7BFBCFBE4843172E0A398332F4CCB69CE4816CA3DB65
      7C27DB68F984DCDE76BFE4816C7BF9816C533B8DD2479CC2236A2B3B65324FB6
      95FCC0D20676CAA865B681F2B9FCB6759A654FE96DE3A7729BD5296389D966C9
      372D6F51A753C69AD51ED9564ECECA76AAD32D7D506ED5D28372C33AFDB2E7D4
      8E159FCBF6ADDB287FD259F3A4DABEAE5DFA9CDCBFE2734BBBD82D1553D5362E
      3D9EDFCC6EA9E4A376B3F8706E4FBBADF2E536D7BDB7B0B52C78F67AB7D3714B
      B11BEB1791A4F08E5201B3574DBDF34224E1093D574DB98BCF493469F6AAE976
      E1418927B4EE66BF9A6E171E56A8D2EC57D3CCC283B9FD6AF6AB2966E1D995B3
      D8B2ABE9A592A032D66857934CFD90E2897635D554CF64E7AFE554134EF59402
      68CBA9A69DEA99A573D772AAC9A77E347FE65A4E3505550FE6F6AFE5541351FD
      BE95ADEBD6A2A3ACC5E4E59A5A54543DA6B6AF5B8B86CAA7721BD8AB4541E573
      7A0B7BB568987C4A019497D7AB45C3E4A3AB40ED559F07A5CC2982D3EA551F87
      EC1905D05EF579D00FE5094DAB5F7D24F4831AA0FDEA33A11FCA0E053D597D24
      B2270B67A25F7D26F493C53DEC571F8BEC9D2B5BD8AFE240FF7B9905D1730525
      BA6C881A8A43619C328E52AD44E487B14B05FB1A0A4561A052F9FE76E5626561
      7629D3AAA16A2C8F55CAC4EA291D85B14AB5E14A0564758D65F2C706EA48DE72
      E25458666A4B4679F388D3ABCDBFC90292E16961943262B4CAD0E528124BF383
      344B69CC0A87E741321C2D0C534A7056583E0F936168619852EAB32205F03005
      FC2C8C544A8D56840239521E3B0B23B56B4B093C5201370B2395B1A955C141CE
      691933F356B0E6DDC8DDF228772476B4B8FC40ADEF21778581EE48EE9687F91E
      62B7BABAEF247785B1EE4EEE9647FA5E62B762F86CDD19A90AA37C1707D5C394
      9BC6AA506A655DE536B24AA42A0CF3FD1C341BEB7B506A7581DF85548591EE87
      83EAF13AF7C241574CDA9DFA3C546268E1E9FABC33C735F5E3DDFA5CB3C02FB3
      01EAF3CB02A7CC06A8CF2997796436467D1EB9CC1DB331EA73C765BE988D519F
      2FAEE388D938DFC311B351BE9323EA817ADFC911B381BE8B2366C3DC0747CC46
      FB7E8E988DF5BD1C311BE97B89172D741405519C0E83BF0E62E1350613D895B0
      3118060BD158BDE4B4DBF98BF0E76D977900FC6BCD104B9797EE2D19A2E4853C
      84EDF4F217E1CFDB2E37FEFAFC195EC6BFD70CB274B951BC980DB2F6B21EA4EF
      C82FE0037DD1776AC1B9819BFD6F18EE329ACE915438CE00236506AEF470629C
      8CFE03436AE41F6D4B3D3877E716ACF09F813508FCC620867F896B03834A02A7
      DD879FB34590DA832BDF1BA5C1DC8D0757B13B87E75CB83C7093B91BCCA72E7E
      0817336051EE228D06AEF78F4592C628AFC38030D7007FF8A93B6F58DF0661F4
      4FC0BA6816A5C2FA7D90A4378148A642A4BF3FDE2406711A002CC6A3C4C6C5BB
      E306FC43E0B92A4C092692C67C4B4301564510E5828708D855B01E8C26B1EFD1
      63E13C374238C731AC41128AEB14DE92FC731CC53337854FF3D88F623FBD6958
      1FF11246D6C03C13BB08A2A1DD2040E1CF212EDA86BFF8F746A08A1629004704
      E252048DDA801BB84305391091D7430E263D1CD0F7EBA07701920DC839A00332
      1C1B0A868DCDE0377413E14561438212A696C09C2FECF65A98F62D44BA38F13D
      BBD5EC384EA7614D858B4147962DE1EC3C3C9CEDBBC01920752B9C1192A5587A
      4FD07514743B9B42D791D06D3E3C749DBB40D7E9DE0E5DF8FEC1A1DB54D0ED6E
      0ADD26F30258138CE57A9E9FFA97026E4FC4CC9FFA9E2742F86311C247B18057
      E606B5AD370C59EBB31BBB1380F4D43A8D420A32FA37587B9AD836FC88A32B6F
      90C6E334F9C5F7D2E9EB26FC3187170576A3273FC6D9C771A0BE1FA7FAD3507F
      8AF1D368387781ACC387317F18C2D281C3F1EFF4662EE0AEE452C4294836F069
      187BB1FA1DC8DF43F93B96BFBD49A03FA96B53F9FBD2AA6231B0DA0761324F82
      C5D8F62DE8F0FC19731AEBDC1D0642E3523B8F4B65C4BFB89221C5CE22CDD7F4
      3DC373444E4670FC1D8D2E0A98B806BD7F52A4D93A01A955CFAB533D2F7CED9A
      79C1652442CBF371369C8F539C4FB77A3E4E77ED7CF0F2CA6C9A1BCEA6A96643
      5242EF6108ECC6C8DEBA05D95BF74E4B73BBAA25815E41965A01DF2C8942255F
      F13EF64BF771DC28AE61110C46636769EFCA89EDF2C601718B71A7D59B9DC666
      6FB69D1534AEFDF2D32808A22BE115269138205D8E32B4C95083C92CFE4CE8E7
      950DDA559CCC71CAF78B3636A28D7D8B907339A0EFCB51C756A8637F171BD654
      013758C3B4FEEE9E7F786F9D47732B1A03B0E399DE64A77C93E5DA8B5B7D4949
      0378792DCD2A10D1C2EC9626F4AFA3DC6C34E54A9CE62D5B9EFE49B7BC75F72D
      7F1DA569345BD9F5D6FDEE7AB3FEAE172794DBF8F6136711B0F0076112ABEA4C
      FB7616318F12D8B8283C8A45E0E20E2A15B1F3C421F8684CD6E9DC0E412F8EE6
      5E7415EAE3502E2B2D73BA02EEDFF68A233F44DDEF6888E742BFA877EF2F7AFE
      4CADE668E4C622D5AFAA2F37D47D1560C334D20266B3BE7850F705A0724D8F3C
      FF12485AF61AFB763916F7BF20C32EBD6E5563250EBAF4E6B3348EC2897EE72D
      4CF18E4B1B458B30CDADAA59F70DCBF4F69677C4621E1DC551A471A0790B99BF
      E33AFE911CD12E2562321361F6A672ADECEE889D08A0506E9A43B9721DEBCE28
      171FCDBCA3967EC3FD5382B11F082006E32887D96473323A91B230F536116BA4
      5160FF17313CD0DB760BB17368914B9B87D9AA74F18EBA128A562791475689A4
      D528ECA4DE2D34545DF741524CAFED5ED3815F4EB7D5835FCD4EA705BF5AED5E
      037EB55B7DBCA5D3B2F1966E133380AF7B4EABC54FE32D80145D1AA6D1EFE34D
      B6DD47B3D6B5EDC07DF8BBD96DD17DAD4EBB73CF4822E177AB54D4B8054D1C85
      26CE7749452D256CB66EB319ADDFA9CFB1602E900A4FA14CAB9CAFDC8E32EB04
      609E5C1D0178653E05A34DAB9CF1F8AB14C8AF66756BE8D1DB19A043E227FA9D
      0FC18AE6C191167A5AF7CF8560F89124A3ADA7AE373C1A196D55E80DB3F8485B
      E45BF7CF49C71D26865DB91F5DE7416DDA383CEDC660148164759D2EDC009E1E
      AD2E678B56EE75BBB4DE8D82A29A8268A3DD6BB6FA2DEBBD9FE41C207FFD467B
      17C0C5140DE2BFD347FE5BCCE6A00A0A78B66703A7E8F51A0E7F4DAEA701FD0C
      C723A7A93F86EAF33F460DF521949FC6648C937F24A91BA7E80AE1BF10C2F21B
      3F040A97367EE7BF700B60B92F1AF66071D4ECDB4DEB7F213EF0FB16B3A18881
      E250558784A3B55D82BE7FD4EC3424B6FC632417876CD051BB8C7101F7BD944B
      986E9892F25C675DB8AA68DD6A9CC26A9017AAF5D8AD5671417401C6C6DF4F64
      49B451A027AEDD28BB51B2530E1C6758697E6D7809D786BF777B6D70728A2BC3
      0BB832F86D51D4D1CEAE0D7E16D74617E015F8BBCEAEA1A2FD44D7D66A2E910F
      BA00AFC0DFF781916AED5B581B566228AC8D2EC02BF0F7039F36BDEC875A5BB7
      B3B4B62E5312FCFD0428498EA16DBCB64E6B8996D0057809FE566BC388460B86
      C1CFBE076AA1DDEFDADFD6B2F6A35EABD56DB73BFDDEA3B176A2772BBBFC6760
      EDC8CA9D92F518D6BE936B33ACDDB076C3DA0D6BDF0E6B6F76ED4E1B94F3F5BC
      BD6BF7FAAD7EC76919D66E58BB61ED86B51BD66E58BB61EDBBC1DADB9D9ED369
      F55BEB59BBDDEFB580F1F7DB8F679137BCDDF076C3DB9FFEDA0C6F37BCDDF0F6
      27CDDB9D46A3D9717ACD12BDFDC8B181F5B7DB7DE741B9BBDAF45B36FA0FC5DD
      79936B78DCFF30DC1D05975BF9FB1F97BB2F4B2E05FEBEC36BABE0EE3B2DB97C
      37777FC292CB8373F76D4A2E5BE4EE0F2DB9DC89BB63B1B876DB59CFDDFB6DBB
      DF70FAF63DF0F6D53DDF0014BBCFDB572C1286B71BDEBEC36B33BCDDF076C3DB
      9F366F6FB63BDD66C32E8BA66B76E1D17EC7F076C3DB0D6F37BCDDF076C3DB0D
      6FDF15DEDE6F751ADD6EAFC4E57E04BCA3D9EF767A9D7B089537DCDD7077C3DD
      0D77DF81B519EE6EB8FB1F80BB371B8D96E3349BDD32CDBDD5B2DBFD46DB3077
      C3DC0D7337CCDD3077C3DC0D73DF15E60EE8DA6A345B65CCDD76BADD6EB3ED34
      0C73BF658FAB176242E80C3F37FCFC09AFCDF073C3CFFF08FCBCDFEFF71C7855
      49F65BA3D5EE021DEA193FFBF79E4CA3AC1BE66E98FB6EACCD3077C3DCFF00CC
      BD65F7ED5EABD52C89A1B3811B76BBBD6EB36398BB61EE86B91BE66E98BB61EE
      86B9EF0C73EF769C7619736FB6DBED4EC7364E76C3DA0D6B37ACDDB076C3DA0D
      6BDF15D6DEECF4DB0E50D1F5ACBDDFED369ADDD67DD4AC31BCDDF076C3DB0D6F
      DF81B519DE6E78FB1F81B7B71A76A3D3EA9738DC8F7A9D66AFDBEB1BC5DD3077
      C3DC0D7337CCDD3077C3DC7787B9777B8ED3EF94D592EF35DAB6D36DDC479F18
      C3DC0D7337CCDD30F71D589B61EE86B9FF11987BBFDF68B4DBED5E09736FD90D
      DB69D91DC3DC6FDBE3EA8598D437C3CF0D3F7FC26B33FCDCF0F33F003F6FF73A
      2DA7D96EB64BF879C7B69B4EB7D530FCFC7B4FA651D60D7337CC7D37D66698BB
      61EE7F00E6DEB13B6DA7D3E99684D00132DB5DE0AC86B71BDE6E78BBE1ED86B7
      1BDE6E78FBAEF0F69ED3EC749BEDB2F2F17DA767F7FA0DC7A4B51BE66E98BB61
      EE86B91BE66E98FB8E30F76EC36EDBAD8653E6656F767A2DA765F7D6C6C73732
      B83436DFF25A9070E05FE378190A082258429C06A3E9603C4A6C6BE08E011241
      1AF385EFE1F39BACAA261ADFDA911E97687FDF12EFC0FA1F6095656BA408035C
      A5F37DABBC8310F088AB946B6CAEAC91032CEAAFB2B77488ABC581C75F65ABEE
      4E22E6AF5B658568F03456D9FE3E7C45496049B4AB16121E7F959DEF5B6585B0
      B05EC87BFC5576BF73959B8B0D9AEA3FE22A7BDFB7CA3B0910ED5EB3DDEB387A
      A797448876D776DACDE67DF49FB99304F158C681FC6E3F8ADEF2B48C035B14E9
      B7691C786891FE0ED2C0A32AD02CDC3C887960EB6BFB1E83D5779B07B6BBB60A
      E3C0925473DFE681EDADED762EBFD306ABBBF076A7D369B4BBAD7E196FEFB46D
      1B2DFF86B71BDE6E78BBE1ED86B7EFC0DA0C6F37BC1D787BA78721F776AF8CB7
      1F757A3DA761F75AF7D05BCE3077C3DC0D7337CCFD691052C3DC0D73DFA1B5DD
      81B9F7EC66DBB1FB7DBB94B9379D8ED370FAAD7B08DA33CCDD3077C3DC0D737F
      1A84D43077C3DC77686D7761EEED66AFD7EA745B65CCDD6E349B9D66C7768C59
      DE3077C3DC0D7337CC7D07D66698BB61EEBED76F74ED76A7D32F37CBDB9D66A3
      DB755A4DC3DD0D7737DCDD7077C3DD77606D86BB1BEE0EDCBDD96DB4FBC0F3CA
      B83B1221BBDFEA1ADE6E78BBE1ED86B71BDEBE036B33BCDDF076E4EDBD7EDB69
      75DBE59A7BCFE975DADDBE6D9CEE86BB1BEE6EB8BBE1EE3BB036C3DD0D7707EE
      DE6BF6DAAD6E799ABBD3E834DA8DAED3BB8736F186B91BE66E98BB61EE4F8390
      1AE66E98FB0EADED2ECCBDDFB27B7DA7531E2EDFEFC3D3DDAED1DC0D7337CCDD
      3077C3DC0D737FBA6B33CC3DCFDCED46CB6EF7FAFD5E69BCFC91D3E836FB4DA7
      6DDCEE86BD1BF66ED8BB61EF86BD3FDDB519F65E64EFED6EB3E3F4BB9DD274B8
      66B7D3E9DABD96B1CC1BEE6EB8BBE1EE86BBEFC0DA0C7737DC1D78B7DDB25BC0
      E07BDD5BA2EABAAD4EB7DDEE9A3A7586BD1BF66ED8BB61EF3BB036C3DE0D7B07
      F6DE6A369AAD76CF290DAB3BC2E6312DC76975EFA177BC61EF86BD1BF66ED8FB
      D320A586BD1BF6BE436BBB137BEF8302DFB4FBB7B0F75EA3DD6DF79D9661EF86
      BD1BF66ED8BB61EF3BB036C3DE0D7B27F6DEB31BFD8E539AF2EE34EC4E17C6EF
      18D7BBE1EE86BB1BEE6EB8FB0EACCD7077C3DD81BBB77B4ED76E777BA5C5EA8E
      EC2E08004ECF28EF86BD1BF66ED8BB61EF86BD3FE1B519F65E60EF1DBBD5E83B
      4EA334B20E987FBBD56F774CCEBB61EE86B91BE66E98FB0EACCD3077C3DC91B9
      777AAD66BBD3EE97EBEEFDAED36D366C135767D8BB61EF86BD1BF66ED8FBD35D
      9B61EF05F6DE6D341A3DBBD32EAF35DFEB028D75FA2D53D1C67077C3DD0D7737
      DC7D07D666B8BBE1EEC4DDFB76CBE99457B439EAB4BB364CA6677477C3DD0D77
      37DCDD70F71D589BE1EE86BB23776F369BB6DDB36F2D47DB6BB67AA0BF1BF66E
      D8BB61EF86BD1BF6FEF4D766D8BB61EFC8DEFBB6D3EC751BE5ECDDEE8386DFEE
      023132ECDDB077C3DE0D7B37ECFDE9AFCDB077C3DE81BDF79CAE633740812F63
      EF1DA7D9B69B9D9E71BC1BE66E98BB61EE86B9EFC0DA0C7337CC1D987BBFD1EB
      B67B701ACB997BA7D76CB74DCCBC61EE86B91BE66E98BB61EE4F776D86B91799
      7BDBE902EFEE95D7A2751ADDAEDD6E19BBBCE1EE86BB1BEE6EB8BBE1EE4F776D
      86BBE7B9BBD370DA4DA703FCBBB40BACDDEE373B9D86E9F17E0F4B795A0CBDB8
      065CFF9F82A1E757A636DD3074C3D00D43DFC9B519865E64E83DBBD969B7DAB7
      347EED60947C0B6E321CFD7E77F969B177A3AF1B7DDDB077C3DE777B6D86BD2F
      B1F776A369B79BE5FA7ABFD3EE369CAEA960730F4B795A0CBDB806A3AF1B866E
      18BA61E8BBB636C3D00B0CDD6E3A4ECFEEDAFD6FB4F67FA3EBD1A58863DF1330
      4A207E2F5C526E79BB658392DFEC750BDF8EA2052C661024F6B7B58F39CD7607
      ABD7DAEB9F72D63FD5EF357BED56B7E3AC7FAAB9FEA9AED3E934DADD567FFD53
      59A2DFF2D27411DEF50FB64B96D668343B4EAFD958FF5467FD533DBBD976EC7E
      BF0420DDF54F75EC4E1B56D7EDAC7FAA57029046BBD76CF73A0E72B175CFF5D7
      3FD7ECF7FB3D07D0B164AB1B25BBD6E8DAED4EA7DF2B79AC0445FA4D98679FE5
      AF758F95E048D6B3B8E4B966D97E371B8D96E3349B6598DC2A79A12EF754F25C
      099E6485244A9E2BC114D8B8161C9F66BBE4B11254E9F75B76AFEF74ECB24DB7
      4BB0258BAA2D79AE045B6C38737010FA6570714AD0A5D76EF67AAD4EB7042C4E
      09BA6435354B9E73CAF6BD65C31C1D50654A1E2C212B4D60EFAD46B355822E4E
      09BAF49BBD7EDB6975CBA6594A559483B4E4B9126C81A300736CF79CD2C3EE94
      204C96095DF25C1975E9C02ED880D8258F95A18BCECC2A21EE25E8D2E9E0FE95
      3D649712F746CB6EF7809E95ACAE59465E74185AC97365D8D205D4ECD92567A8
      59822C4EC36EC3496F97BDAC04593A3DA709ECB5DD2ADBF36609B6646A7DC973
      25B89259FB4B9E2BC19556BFDF68B4019A258F95E04A26AC94B0F446E9B6EB96
      B7254F965117DD4CAFE4B9127471FAAD4EA3DB2DC3B25609B6B461073BAD7ED9
      5325D8D2056CB15B0DA757B6EDAD127C69B51A7603DE5706CE32DAA25B10953C
      57822D7060ED5EAB558664AD32646976E0F081A25FF258BF94C0B7BA40FFFA9D
      1270B61BDFBEA1C01B8BCB741858BF7F0D2FC2E82AFC2B5F9D4FE674153F0C7C
      F8E138033F75E788088D410CFF9221FC73913C6D704BEF3E066956DE612309B8
      8737F5EF6390EE7D0C0227B772D1B95B60F9EB6FAA1EC6A906AF53BDA4CEBD2C
      BAC62DF6FA5B9E3FCB43A67298463574AB51D7AE066EAB7A41D577540F62F76B
      E0BF5DF62A260B89EF2105A00F9D1EC8EC9D2E7FEE77DB48D9F173D701DDA8D9
      E3CFFD167035FE6CA3AA85849CFE000AE6381D7CF56CE6A6D3CF31FF3E8DC2B4
      D91ACC86F1C56B3F6CA80F670B98C62C99B941701ABB23F8ECF9C9FC8D18DB83
      59F0C18D27746FAC3F7962FC7F46F0DD55ECCEDF9135010DBEB0FE991FA6EFFD
      19DC12BAF10D7C4226E787E3E8F781BB48A7516CBD0DE09E2415F1ABAFF05534
      17B19BC2E573F80EAE86D6DB70128818BE1AC5C24DFDD9E02606D1A43F9845CD
      8177D3C637B4912921095DFEB63F98C636DE41420010DFC48F42E47BC2C39722
      6F09A3F1DC9D88A4DDE63FAEA2D8037DAB472A09FC3D9ABA71021CA393FFFB2A
      01E1A127C70CFB5D65B7B89E05B01422D9F4D1B6A6693AFFE1E5CB6434153337
      399EF9A3384AA2717A3C8A662FA3F1D81F8997F8CA97A8BAD3A759F0EDDB60EE
      021CAE6CD07F3AFC798A110BBDC10C001E904D1D3FC5FA53AA3F0DE9D3649102
      4401ABD23811A3D4829DB8F2BDE86A94C6C1609C86C37F0C5C117A5E341AA4B0
      BF1733E04C49833F8FA3183023F5C3893DF0A2304AC56C28BCE4261903AED800
      E7E0260A2F674123F76D00777B6EEAC29BE3318C2A2E010560C04B37F0E1BA00
      68D883641A5DCD037724A651E0A195090EFC248C6231F3AF853782D1D10A05D8
      7F29FC909EBCC6B7E063F001382760840D7B701DC0F4A21B11C2AAC4F53C99C6
      69089717B0D820998F065E085B1026436F0857C9CE054B5AC0BA6161C9D405DE
      0CB8F52F5CBB37991106C38729DD688390E54D2E739FE1567FC2FE0BFCA6F0D7
      14A766D303F801CD95301F37F40697BEB8BAF043CFA64FC9C80D04281870EA87
      B1174F85EBC98FE3284A07C93CB849AF423F14B835FAF3349DC11149E6B08820
      9CA6AEF70F58D6609188201DBA4138807F70015E328047E00D23F8EB8AFE800F
      713A89074108A719562E6008F87415A338314842779E46139043FC7024820006
      0AA2ABB12F0238B71E0C3F801BE78B7084567737F15D3D0A12921866AC88C920
      1457306292DEC0D709BC6412475730E768ECA738D110019EDE00DC51F881EF61
      B221509834198C054E4E04E2122E8FAE933999F9803278B08757785DE09EBAE3
      111C289CB53BA69B178097C1604A7720E052A0A16E0C77A6A34B976095C26CF1
      A1718C00C10B976E7A3DBC1E5CC4E13C4E42910E462E1C4740B800E06821E6F8
      701AE76E6AC1B4D2061FE52B40E4F12C1DFB011C24CB6981A486C71F48D02216
      E9348ED23410C0D382713473476E3A0AC2C5BC4D270E26640DF0D879963A8040
      DE4371DD18E0D68BF8A60B241AB75E7E849924D7F801E01F4E452CE8697C0477
      09EDAA349A18BB80E323D8413AC1168988217C155CC2E99A878B513CC30B68F4
      C5BFD9AC8B56AC793875C3090A92617A9DBAD6B1942FE5C3A89FE3E330D93B3D
      DF844F20D4DEE9D9167C0AEABFF9A0F874BBFE9B87D6FEB7B2613A0480DAD3B8
      6DA82E0D546F236E1BA7775F13EAD79910E2FCDA9180FBC440AC02D70F2D89DB
      837FC2A151E20A7015C054BC8AE46C483F13FA790592D8304EE64EC31AA05820
      D11728CADC0DE653173F848BD960EC22C51800795B242950D7690A0387E43250
      02210CEFE685189087D260341D8C47C061813234E05F0272AA1BC05AEC86D3A6
      A9F20D0DE47DF42D7ED96CF46CFA3016701FA8FE11DCE58E9B761B18EDD4CFFD
      E10DF51FEDC108CF213D17CE734384731C0436A1381D1BA763770A93185C0EE0
      3A5E061A97E4453814280A8B435C040AC2A0CF803E2A037AFA4840BFDB3235AF
      58B74E0971BB086DDA94B16DBD061A1BCDAC686C9D0223D9142C8F858B8F0E96
      F3687E5798FCB9512547B692A1DD4049937E0E7181209EBAFC3B03590DB0440B
      E2D3E41E6D7C1790868A90B57ACBE46B3818B75A03FC660053990E2E40E90081
      BB5903720A6EF0FC1AC0B55AD62F53377D915820C95940E2AFDF7A7E6AB58E1B
      C7CEFFDA1214EDFB81627309DB140C016804C30D70AE14767F8F8E4EFD4704D3
      779D416692AD2254182668CCB80770BCB23840008F2148FF7162B9C985F02C90
      FF2DD7BA726FAC34B292C57C1EC5A9C4340F773C9ACF401AB1AEFC740A88008F
      026E5B9FDD341651688136F5129EFFECDE7C76836309ECCAA9BC4B2D1F903ABA
      B2E65192F8A05A54BFDB1A46F0230AE1567F26F0C5D60C74D269706381A2EBA6
      7E1426D6A5EFF2B61F5A08A2092CCFF36394D66975AE358A050E3E4264E095E0
      8ECD052AFCD63EACE4B272F2F00A5EEE011EC9575FFF47ED659F4F05CF0E0698
      08040160086E014E3BD55F0E17402D431C1CAFA5C04F08A7AC511487BC7D787D
      86321FEACCC786125401FE477726E2CF914813EB67DF135162A8428E2A006FD9
      63B0EC29DC9BBA89351402CEB7E7017E6E8A8A354E0220FF951F045634C7B758
      FF1D2DCE174361812A7383D6083EF24C0992B918F963BF72D0119C235C8535BC
      C9EDB8391E95807BBD988CFD6BA14E057BCA28CE2C532FB5E564094197505306
      4F570B3E4AB52B4E89663A6E5A8317C3EE207587DFD6EC5A2120BBF6F62D052B
      E2B335363448D66F233E5EDC4869DABFEF135CB977FF6FA7D9B28EAC5F4F3FB5
      7EB3A47FD2FA2CE20BEB6D98C637F3C807FE69B7BBCF9F3DC1DDAD5CDDF367B0
      BE0EACEF95E721B376AD6404EC3AB5C6B13B21D180B8FA7F2E448262F2CF1F5E
      BDB180DD4780325E2492F005C82B73B470139D520F9DA07FD72293EA2E02653F
      162827015D064AFDC64F70B9070023A696B198098A03B5F617E1951BC27DC10D
      882A4BA41A04BEC49AF9A13FF36B50887FC1CBAEA640A9E105F860E002891E05
      51221292C462807F043FE01D2E10EC1420FE4782EC2FB874045F8291B1633F20
      E12D716BE0EF250C965EF923411CCDCF0D93009E86DEA1457B9600114A90CFBA
      A145AE140037BE2616A13B43CC3F46BF0BBD3AC1C925D345EAC151DF45283F7F
      5606E75F4F3FFE8C540CD413CF0244425809402F90335E7F78738E40BF8AA370
      8232BF1803A785BB40E877631FDD1356E2FF4B58FB09A829017C11804A83528C
      D504812015C9C12EC2AA0C52275110B8735260A2710D882BAA88C714758F7D02
      311D699748EB4BA01BD1257E48E07D38EECC45B76F7200CA52682D420FE4BD91
      88532420233F1E2D6670CCC311A02363AF445E3701D53295D80B0C084742DD0E
      B19768305EC73CB07817B7A31C75F7DE0831876D99DF204A7E9291447BC48640
      D3056A3915A30BB90D74D2470022CF9AC4D1629EF04E04517481F0428D7C564D
      5C687B98E28602C94C84D8CE123B7C26891D75E07417217D2B2966CDFDDBB2AC
      E590AC559C3ABA175AB567AF66D55C3BABA6F52E44EC5E79F1430B79707E2FC4
      8D52C37EF6C515B10D9F312B6F4381636D9DA471809FC7813FA707F64EA3D182
      8C884038193F40474149881011C7DB03450C4D287F2454F9F5ECECED6FD69B57
      E7AF7095BFBC3AFF821063EEB2D3EBAC832F4BA7461AEF001B66E29090C21FA1
      C1AC4CB39F22BD76AD61E002D11AC20FA453C089F781DC841720FB4C5DAF7105
      3F6FBC26D12BA6EDD7BBC964C7B4B6E18D323A8A188176E65E6E89CC1C8B64F6
      E844C6825DDCCE5A83C75F2B0BD2CAA6FDF6EC03504B97392F500D360ACF81A2
      7CAAA11C7D7CF5C1A218399724D5ABD827F90908B48BC2D13F177E2CE8E4086B
      82827F8A9172496E0A7878806EC361112186C029D9151E9F320EC204FF48276B
      0B68F6CAF33EB040BB7FB00DFE8D4234486723370850F0C65DC7344B29BFB9B1
      20564E6175D62CF2168154F6FE40BB8EEE8F10F07942CE1A3C0602C3EF40B708
      05E811498DA3069A1E8830244AA3ECE3A1324C868D195B36E87C49C5850EF308
      E367FE5050FCF5FCED59FB258936BF902A0100F81C5D01CF86F59FFDF4E9AB25
      1560C427D407027F12A27ABCAB16C032389C7E6ABE247BC15984D614A0D8E124
      779CD2D80D135034C932A0CE1712F9095B0D92C568BA8B0059078E3A04A80831
      50D14FDF9F9D2B5C013CF1FC0441254726ABF82E82A7145FDE2CE6813F4253F0
      DE096ADE31E891D178CFFAF1CBD7CF8982034BD820F88651783406E409A4352E
      C7DFD9C201C8661C4B559BF1C10D1700C29340B8211936306C991CF578203D31
      8F05EE8867DCB1D510DB7FF16A3E07E677CA21CFC8DCD45D2F6A9C8A43EBC5D7
      D0030C4A3976E20D1F77EB8B180B380AC07F5F1CD2172FBEA021104EC93B0C42
      851343B604969DF694FDEA056D206A90BE2750BA8D864944632B79164E4C1A83
      1C43B3C763F3E23F173EE892AF601378E22F50CEE1C9902718C341A2105688D1
      FA700441384AD05429AE89E0902171EA27B57DCC1FA21867C1F91224550F51D6
      5F9E8692CC986A54477F84340B1598F511E4172F1A2DC817B50F5FCE00F7FC79
      409E6C348E0E81025D1D925D862CFFC205CCD1DB7A705C4B162551783D9695C5
      A33E112A24939CBE9B0AA9716A1C21691A07A43C8942CFA7D3B30CE5BBBEBF76
      38F0D6485709C06B92AE95657E27DCE950636E5A80E165532219FC15B90B2CE1
      2628D08342EC1135A2448F516AD91819252C3EBBF5CE488DC52CEFD93DC3A806
      84345C5820BD82052BA06562D7B1F52A94E6D8E5401C205A988815470151A13B
      138F52D0986899CA5DFCF56711DFFC26F9C819F22AD8D731C896697228AFFE8A
      ECE537E62FCC5589DF605092F5DE0FE1B1C510F893274C205A161256790719C9
      1280DC4C29FE14F040520432713C4FA8F08ED09820547C674A560700BC0C5613
      D782688F27E990749AC0B795134028CD04DA16EA07BA458AF5C34F9AF7A17513
      2D68BEE4DB67B1004EB9389E1CFFF00435AEAD4760394F3C020BC9C15A6AF0C3
      1287C17CCDB596CEFBB473828E8FA702274573C229E9191D03F26FC9AF80D516
      2A4DBEF70988F3B7672D82C47F9E9D3CC4BA9FE051ADDC8A3A58FA28D6F8B3B3
      B7B8374F0A434B808015731E0C43DB040583A04504CD94F3AD20E7E9C79F3572
      E25468264F0F311F10009F8872FEE72B839705BCDC1E4A2A6646F3F8D3E1A3E2
      16061DE53E14B5C9ED1049A61138139C08CEE3CF84926AF93FBE7F409C345601
      8C192828FDDA53404E0219BDF68B1F7A28D2BA73E56CC0AB1F302080BF3A442D
      7FE65E080CCA116EC2A9AE0275EFEA90039590AA4D7154A783B3E2301D955FA7
      D47B6340AB47BDDE472EA71EAF5ACC0CF6E713866B11B7FB246D47089900B6E7
      01A85A2535D72636E596A33C85349A083863317B171F1F22FF441C45B08C103F
      BFD765F7905CEEFE97BDB525DFC1DACA7505524C11E090323766524F19C4EC81
      92C1759CA8A6A35F68951C41CE6EAAD90CCDF6485E6BBF9D2CB88FBF4D523A46
      39641953B3B32CD3206B07166FB49786E5D562796FAFFDD4F0B63C6FC3D203DB
      E16F02F6E2A9F2373757A8C5F3C7149F934AF9771F89CC8ACC542DC48687D6FB
      4F6F7E14F0FB8C32A80F902E5296074BB708148C93C100E51B4EEDB5DC314E14
      E921D77D25B73D06AE877E32159E11752BE1FE16D326DDC09C7ACDA1433FF5DD
      40D7FA410D40026929D6A136DB65FC95C7897DAA1428F1E88445AE4331E32D89
      894A3BDD92A82C1808DB583CA08F26AFB5B1E795C52533E671340CC4CC1A2D62
      24B740037D194CEE8FADB735022C25126375040C16E63C0F692280DB640822C8
      94249E5206B48581961E97B0C808BDBE9976F02C15EEEC907F65C9C4B9A216B1
      98F870E06FB2C84B2E164753E081E62E721578351F15B2A120EBA1B400CA14F5
      E14B89BE2F12EB8D9BBAF490A1F0951B7F8AE59917A9D5ED1822AF60F2066B33
      C84037123188AA33CE02BA573E1F610C0FD768A1D07B2C2D9F70A5BA9925CBC4
      E3D1B28F1BC72D426CFCD446941D4D8D09AEC60E9DC91A0F2061BEFB78FA4985
      751B145600FACCEC40E667128C545D8C0CA3B1689647F857B8011847519A16E1
      72660D175D04323CA11CC02BAC2A4E09A3F379E003065BFBE77449A772C5331A
      29043C8B29C88D4B3ED4E04B5809621153E59E683CE66844BC205354E19A0C46
      53453C382F7528F006CC654DA9F68D9B2ADB7B9ABB976D2531565864180016A1
      1A832C0E837A71C93AEF5584130CEAC5C485BF1F1FD465D0AFB3E4F377E138FA
      A180B0389528E0D2227E6C7DC654DCFD792C2EFD6891D09D07708BCC70501565
      6611578E9A8A1B8AC345FB48B50AF5FC99772833DD513288ACAB28BE508B0F6E
      242F96AFF2F2B3B46680E939B4A1F7A1D5094613C71822E88EA6BEA055F8C961
      7181B9CA1E09173940DA187BB2AE4A6EDD3CDEF2C645B49F1B95A8A4EC30DECD
      A520E404B013F71D46DDD377ED59FB0AABE1FA795C03920B714078B8778A2835
      F313AE290AAB280E06CC3511E4BC813D4D442C6BC8E80D1E0ACC8F8E16807178
      5AB289A31486488E163D40F0ECE01D6C048975D9AA14659A1D64F44391C9915F
      3CCA52CBAC37EF5EBDCF177C21459ACE07FCF351F21BC7D12CBF85976EB04025
      5FD688AA014935221D508DD100B64885DDB3147AF277257BCA07E0DA150E9F3D
      0412B00C9CCD1DDA837CE69B4440F81ACB38BF7B73CC751C556A33A5DAE6C36E
      A967C8756AC1715B28CB2A3F8971EF8B196016355C501EBB0CDC898677EDFDC2
      4C9CCC649C3B6EA84D563EBD145A8FEEBCF42A9207007644B606A3A305A02632
      9C1D0BA189A17AE08ACBD408EF602BDEF9233C0A88908FEE8F3FDCCA723F467F
      B20523E14492B185E5221DD9CE1E3FD4A28DC250B9ED9F00EC5FD9E880792B46
      51C858F027AAFFC2324082B516B00511258A63DC8A1401257BA0EA7792E9A59C
      412A1D0016553D469540B21A8F44E84C7810B37914A33FF3E4EDFBF7999C21EB
      C7E5C63F966E505D79866CACB2C20D326816F0D1EA849DA50AA658144D897BEB
      B7A92944E19127C827BA24D2D7805175E9E610662DFD1001EA0D37CBFE082D66
      A3600BB327A0AF5D586D812187D23A852873C8E47D23E305CE61694658C447F0
      3CF436272C7929E52E049967757E2459CE17F11C5D2CAC4AA82D70C97627A56E
      2CE771F6161BECA1D6748A059AEBD47950914E7A8FC8FD8BD3E17D47FBE498A5
      3E129A65B59463EB7411930F6A35653ACD49799C26BD666E9B08D6B1E0DA75A8
      2326590ED6F28EC03C31570A84532CE43B89A4CEC309556EAAB3A8BF6F3A308B
      856AAD01031526512D378A2C9F4BF8043F99D6E5A75B71423C7F0690C8D6B0B5
      984C724350B9606596BE6F50E4084FA9CC9001E2F18170175F041EFF4F7CFCF7
      5E711130AA9CFA8954E3A56460A5291309496350AA8F55A562385D72183446C1
      21B9043CCD59FF898A32F1224D25E1326368DC5943B0F675F9C01A0408769A5F
      7DA846E56A2ACBE3F244A8D09A8563E364EA5B85689D706EC98CB544370E1900
      928C2A6F873207B013C667C06AC60C2A5C4AF58336B696C8D768F2188FF82D99
      1AFCF84E38469D3358E0A7BAE2F243056F19D9BA1258C7C3C47D793C741DEB27
      40CDE0712B0B3D71F1BAD00164548D7723941BC6DB8896C45DDCC2497BB98585
      BACE36488AE67E5824046B0D51E1102AB3E36552062300DA551F1D30AFCF5EC1
      B86B529DEFC93C51831DA19C4E6658141192826A77FEF6ACF9A7391516565902
      A187D49D2B0112805B8406A968B2040456B812D7A4B5B3E6C3A5234F3FB16FF9
      F453B7A36FD882105BFBBC3D08003789BD66E517B52F2BC19A8C7E922CB47793
      7B07545B029E188EAEA47FDF770D628EE804F48A5DEB32F2474235038063BCA0
      3671A18CFE29F81B40E4FF1C057E325587BB7D00B48F6B18E6DA310810284492
      606B81B96CCA409A19CAA6C45B8D7C561DC4793DC79616ACD59818895C10C94C
      E97A797F5B2EA80DD559861EE8A8EE507A1C5137C33A7F973EB72D90669EBFA3
      6715CBEA613338EB15908C37D5F617C06383C1D53B3585E9516B91B3B910DE6B
      6AF26730396FC46733C0DED777D6993405EC21CA1E4A2CDE631016E057BB2DE2
      9E32C62C4538E7ED07BEB41DBB97AE1F505CA60EAFC93BD17964EED2C86142D4
      8E016DC8CB1D19FCD93CA68E3E5C8E7336AF0108EE0A42B6DFFAB69833380FA3
      54D5E72CD85D62AE254AEB7025A550410FD64F22985B2F65474EF8F0515C2F92
      0F91879F7FF4D39F1643F8209B58C027D572F6A56C93FA52B661D5D0D8121DF8
      43F595B64D5FE9EA8834D32EB3B4585BF389176BC3869276CF3AB29AC74DD2EE
      10E91BD618882EB996D88AACBC79248893422DDB72CDAC776F92EAB7EC0F63E1
      5E7018E8512C389D0B8638042A1EE3583BD9CC0320D7C7569C5CFF1C2831420D
      95E2ABBC31FECBDBCFEF5F9DBCB53E7C7AF3F6BD75FAEEFD5B6C90F25636EEDC
      C57597377D73537494E375BE4186548B7014911B9D6BC7CF4836C8D4B2824E86
      38388ADD64377B1194C0051B46BD84E37285C46816A1C3563269CB8BC8CB44C1
      B3008B4E6BE8EF2452942DFDBD9860C74A0C73249F10D52959CCD940D9E01695
      DC4C914C24BA1E72B29BED396EEFE4797E72FA157799C3E3B3647B4E8EDA3B8D
      2800E5EB7C6F17977E4B1BD3AC45CBDE670CC18D51B7058522AB7EAD33B9B05A
      ED3CB57EF9F4E9732E7C7517E141D0A8BC6B1DB588A30BB16CF77B9462A9B5AD
      D38FEFB1B9DFE0C9EDD89089AF098E8C539165B970729413AD89CF3102AAEDB1
      ECFAF0C7A286B2A5C6BBF30FF9E64C2EF5F300A9D30FFF010A344911F934AC9D
      5AFA6D9D717D378826D67934F7477B9CF7F14B14071EE81023B167FDC8118C32
      80E212AB2927C8160030D571FBD773186F17E155062DAECE208B985342CD19B5
      0CF92246682392B4729725A7D20E4DAAB72D998A7D34AF51AD809CA558F56B74
      5566956C8F28BD22019F2269385B93BCB38BE02A01161917959E2A856A15255B
      C3867103E76D3415B9BC21EEF82AA36FB94D8D8C1D76F3ADAA771184A518C781
      B0B0C81145FDAE4FF7F2285895BD1A807C304369D0E44A011A3943AEEE9FF565
      068D37925500E01CD3688518E25D0465092055637856F2930D8A4FDCAF9C03E8
      FAF8620EEAF1C996EA908EDC640BA1AD49EAA6B27F381B37C87E76FBA63F5C1D
      F577610A4A77AC131E1E1F1EAA472030656BF8A845BE76D4842E3D37EC48337E
      48ED59B8B1E6D17C11B898228CC936E87E2C78B99663C0913FCF453457150DE7
      9482AE93405C2C3F738429D05E14CA025E9902064F7964D986CBD2BB669CE935
      128D959B125519E9A81C1A97FA4A807E8D582F76AE4BAF0BBAC095F7FB30EF33
      566EEFDB209F558606257218055C97832CAD88645B2B56F787F20E378C77B82E
      EC3E6A6DD31003EB95B59781652F6B989A85745336A5A75273C46C2888BDF9A1
      56B7B0BCED46C9399C055BCCDA446F0C9664B3E63594C6389AC4EE8CE3258F91
      3753DF791550B3F726C2AC44F6EF8429C8BFB200C61EDF378CAE336510748410
      4554FDFEF182C28969EC443E4FA5ECD7B4954528A9E21AFB433172D19F2693B9
      E02B5957EB605B146E7D7FB68DCFA6D35D7F369DEEFD9DCD730AAC026E728241
      55A0BE98239A4F653BFF74A2C4CC5C685B20C6CB916D392C2547E73E85AE5118
      0060ED456683CBDD08B03F58CEB1A6C30312EC140FB9BBBA3D1AA51F3B24FC4D
      B4C0A99C04FEE8E2CFD230EF2DC0FCF1AD27CF9F295C41ECE39C50B29BC9B44C
      69D3953513B425AD3617F8C5F7D2A9C25B7C05F2043A8A806C954F0B5591992A
      5F6D92CB7B8626126B5F1907614BC3283D90DDCE57A7C4C9A8F86D2C9234C2B2
      0D579CCACB2593649D2977E2FA5BD3D17688D0B3CFC450F74C00938DE745A193
      8D6E2ABD44ABD10B934BDD7D6CEAFBEAFDB9F517EBEC09F4927A94288493F32F
      EF61BDA78FBF5E727C4842ABD1636BDB7EDADC06F7D164963C6A146A8F35EEA5
      4BE84288798D804F061F0589AAE876E51E82DF091AE9A284227FB606DDADB177
      0DE03C095A01F12D1054A053EE3A390E6D1592B258E0D661E5C150AA4987BA02
      49224B760A559064FD10F239C3592B37F4FF8BA299E1AB195FFD5784D81ABBA0
      F0BB7181B3560B97D5ACB7D676E8029C5CBE32D85AF17FC9C81A87D65FE8041E
      DD7FE6B7F14F54A2C4D777A8CCCF84316E2C551109B3627749A1C9CE7081E12D
      C0FD35E82835EF461D2C2AA044F64959E22B9DC6D162C20527F6E8893DEE5189
      397AAAA2D04D928A195FDAF74751A82AE02ED9540E0AE9823518EA956C690907
      ECD277E951356F8E9CE2D7C8C4DC8D6A19DD328E45C984D882C8E5FACB58A86E
      5C54D2537CB6BE7D16601BC9AA1DFC5682952A539C9F0B7B8368F8846A152702
      B12A55B135EF290861DF73E30BDC1DE4EA00EC00AF62B9745D419CF5EF37709B
      B52FBFAD1692D57072F4FC683CA34D408C0B90710A1600F3029101EB99281187
      2B7DCB82F1850451EA588A80567000116ACA65229550C3182787E7F00C0416C6
      22CD84C9F4AF6504058473AFB0E220865FA2EC0827771CF8233CAE41B4880D51
      2D1255726F5C31CC1441D0AA0F41CC4A4604D6FD211745AC57430EC4F5D04310
      33B94BE4601467451A02468C5FCF61677C2C0BAA69106DE101967BF90EA270DB
      99670B1E569429789616DC00D81FFBE8A591E3BCE4E70F783C2A9E9A7533500B
      1A526F13DD78122ED6007E35DD4A54D5ACCC1AAF4839A23555AA0DB0D85886E1
      18D6B530ED53AAA12F93BCD69007237465BA517A6B75847CA43751100555E981
      92DD09A2C924902924644BF7033FBDE1EACAF2FE348A024925E443D2560E6714
      F82ADBDF81C70EFD50F616600F136FDBF9B4BA26D1F367D893018F306F321301
      3DC42B78D1FECAC1AEDF69E2172ACB832BCCF06A465552E6D8AFB198849C8F57
      1E61612B79B6199C326AF9500A94295B54E8BEFDFC929397F9D91FA841E4FB25
      30331B8D2109959BF8134CF1E8CDE777CC090D15582B25A8FAAF6EAD4AD64590
      E61503994405C88A1DEB90FD031316F92AE1DAE6485F8C4183C300DD4495CEFA
      0F0BE0FE3F15DA2B114315813DD65D01037FE6A7BAF1A9EC8244874385A60D01
      C034354AE78D483D14C192F48DB3604E5B98209CAD946D9D4AAF9187CD1CB72A
      F4D8FBC99D0D17F144C47BD607501BCD81CBC55A69D81068F64A4287A5EDB124
      C483AC118CEBB2CD8F1C0599121A014859273BE3BEEE997920D913A67553FD83
      10E024921F9E60A6CBD62BA5B49E78A594F71112AD7F11F17B82FB5739FF1FDD
      99788F25BBF6FD31B70F0BD39D2CBB8265BC7771DEA65EE212403E607B3E3611
      A7D85A92C409E2FA612830DDD7AD56FB7D901DF6FF4642852780127B327D4356
      8923493E6B259CAF1D970049BF019129CD0A3452B9B6BCCD9AA3528DB45F5D12
      F4ECBD722518FC5EF5B270C31CED6B41D44288A1F8BFAE13D27EAE48337E772C
      92002BE282A0E16B4B803FD3C63E5776C6104B63D757B9D513931A7A88C01246
      DE02AD10AA9784ECE049BE07D7DA236BDF1E562D4833F320E553736F47EE7988
      07703E578F5160DFDBEBEB6B8BCA201C5B6FAF5DD20C023FDFBC877BA64A096C
      265CAC3AA9D5296DDD50ED8A1673FCE8B49BD61E6EC19E9EF87EA341FD34DFB0
      E9A2D5E877F4B4F53DA76F1BF2B6B7A7A7A70772953536BE1ADEB2F36A824B4A
      FD0D9C44E779D4C98AE600811BA5DCD988DB59B2C555AF051D77F4AD6C8A8AD0
      505F1E4AFC8B13A0A1FEC44F1325F3CADE9448923F7E3AA72A03814F31C9806F
      08180F8BF3CCFC50E45FED86373378477DE4CBF561414F1A126A2E054D766DEE
      DFCAF1A0245EA3CA9A9D1E9C691DA4BDD1CA27BA97408AC365EC234340C11E33
      7B74913B8A700DAD4F43AC42F2EECDA1EA4C46655BDC0C4A7EBE83E721E8D0FF
      83D044633C68E9E4E4CC4ABD64FAAE3E70D969DAE8B0AADAED25A10ED8AB73AE
      AB27D56CB9799FA10F47EF262120014C751BD5EE09FCBACF973A044467C68BEA
      A2AF01912EAC5D808B5056468D73CAF0B24496B7D103F27322165E5417CAF71D
      C8568032822777B40A40676224818A275C572EA9015849ECB1425EC20FA39F81
      1B8593C828AB7D10C5CF9F0D793EF37CC3487255FB7A8A4D106163BA9D1A650F
      8CC45706BC420BC55CBF7B6A86A7280AA6F06DA3271E76F0A05E07759BE1DD33
      7956C1A8C414D32D05E71D8DA36E672BAD5892BBB4C2A3E2E12CA010A1437288
      F083034375A1A8FCF917418AEE48700817C157F77951E9A4242EE74565D64E88
      909F91F87573E65F030D9EF1CEF0D71C1346D514AA033943EADA21493C1503A9
      2FDDE4CE9026E449CEB5C10599A4C6308F80BF48C341781381209A55D574E5F2
      3012819B4F06517481A2F79A55E21B678BD1943DA9E85D1C71DFAC42153E8AB6
      9055FC6A2FE8350C8DD105D8B0CB85D9BAB36801BFE04554F495A3B513DE8858
      76CC1CA34C8D0B843DAF7C0116FECAA101EFB2072BF4C737D2761DDE70D5FEAF
      21F971F6AC4B375828FE596C0D6F9C9BD5745E9F330FD3A04F5C722B1B36B81E
      3CF9FEB95251679D8E2AAE01511A53FC115D222AC3617E5C8F8D15416A8F120A
      B6D20DF154C81055D6534FBE9C68370D899D784CB19A241C386E4649E90CF58F
      2C2C80FD8FF462D63DE1CD3C257829D0208E24C070D35800CD09A8800CEABD78
      A642ABDD6814BA552B0B4F44A7BB409E53970879F6AC032A2E56C6DD2C565592
      280B4B4B72C0074D54EFC4D2363000658B6BCC1021AA216776889FF289710482
      FACC2AC9A3409D2A3F6B70441AB58A51653C6B95C232F81D65FBC1B7E7CF888E
      1380A5E92C6FD4E04C17463300AFACAE82B259CA3581C6401A41285BA4680C19
      2EB8EDB822C6326D4699BA14574136A45B923022171611DE6913F348AF0C6639
      15F3B8DA202EC63C066E27450673F22C15A8239A8253DB7BE3A6AE821ED12FB1
      C7A7CE1DA50B37E084741E08143A6A51C4A51AE48A353F046CBBC30265646E99
      F102B8ABD8B2F9E20DCC89E0B20D09F16FF9968E9E9F20CE2544374692EE6C11
      20EF815EAC490A7DF0DCCCBF61C9AE17D2C8993F27993B930F2F3588C68B4AC4
      DD46A36D0D2EF4563E7E22AB0216C1220F2CC96C15FB8991D16DC37075F2C3E0
      77A42C836FDB000ED134A91A50D06A062123FC56BA6D6124FF08E51E72FA685C
      428EA34CDD200B950A81464ECE33C4791C5165EB2827144AA98CBAC7948AD2DE
      822CD3328D573AC0448C377084FB0CF7890B21E256259963828300C9C3A8FB04
      67D95F279FBF62EC93C8559F932658EADF9169B2355688D2337688434F1CCD14
      3D72397F973966E542744E7FC19D939A0DE83A4DC71CA7B2E3C4E091CA605E05
      24E5408BB16E168BAF14C79C445B1C493AB7B543438D210F60BE9903E950A5D5
      D60DD257E740528F4680B6EEF64BFDA0224F5417A8C3BB8D4762C54DF781E986
      F4A8ABE20FDA24CC7E34D212657406AE269CE44DAEAF3E9EBDB3F6D1BA3ABC01
      CD19B80C5A5462D01531974BDE2F7984CCB64C74257D15E4CDBB889BB48F711F
      DCA620BD129CCCC18325CA0508D3A057B199F2000F1D85825B9F31D5365A24D8
      172351C92B1C403005BD80BA65047E0DC0CC7C5C7DBE053AB79860534C0E64EC
      62F43D14A7515ED4711B0415BD2819AA2335DBE27792C40418412AEFD8303822
      573111E37E28BDAEFC85AC07A9C2C674ABCC7D1BE95E6C329953D6A91F056E82
      B7C14CD5766EA0D527D5A56D95090E4D2B20A8A84C45A5FB93D93D507607B98C
      848D5254B899C0F002AD51D8E202B328FD9003FE285C449548213028EBC25AF0
      7F3A33454D6A146B23D626B1C250D31CAE63E20DE6AA6731A52B47C7A24E2413
      176DBF6835967868A2FED744FDB79F78D4FF8FCC04F5D61E31BD231C903EB43A
      6A10C63092041A22BB3DCC9A85A0A58F72A30E315246C421BC2BCC425B28660D
      EE8D755715E5F8A4367AC74F10A56A88243F7F78F50615DF39F64DE5A393DECC
      850432396FE2D8BDC98E94063BF963C4352C160FD9D9C54DECCFD8F0E0A2379D
      AB94B0D99BF74B9ABF95D93A63EC8A475A2E5A58533FA4B0BCEC58572E834220
      316B2D926E8202DBDCA91D91A92D280FAD41F35550A2438230750BCD4D8EE574
      B6501C90C4414A54741526F9098B1508BC9DDCFAE7CFCE63374CE0F89063ABDE
      FE2F1D2549AA244D52E21685DD71379C09279926421C63B4ACF56918F820C485
      8718EC51638A140FD26469508587506D3060B21CBE5C982A4C4A04C07B73E530
      66587702F36C41E2C7D8795E03CBD6B2755A2190066799A32E21D6203BE4FC10
      2AED0CE4225850F19FF04661400E80D6BE029A4C9165DF611182E614E54F510D
      2EAA0EDA81F2FB678F73E758745D0637AB27D248AE2B724CCEC39E3B26A8DF6A
      B5C976DA8EB54F1AD591F5DE4DB16FF141CE120C081D81641273CDA545B215BF
      E4F36747A3F9913455FCF0EF6AF2FFF1F8887D45BAC11600B0CD45636F0A2E01
      F7E80B5FA4E3DE9AAAF08F5113D9CD0E09BB4D8EB1B986EE641BCF880CB1DC5E
      39E010257CCA768C29AC519E2941DCA6B6156659A4A602112BE75B322060835F
      CF4F7BC7529FE58E1C32A5A7F87A8A3B5D361666E3CAEA6B492624707C168ECE
      1128C01E593ED610BB2228C52291B1281B8687AECAAAB454B2DDD509362A5497
      D256E69012B138CD678E0E3529C420B7A2EFE4DF5B0825D832AB36D6B26A9494
      58640C65591077263FEFA36C76F696F3E2A2C063413A5F15A3700AF93CA34C3E
      09F1981BABD91AAB59E7895BCDE0F5437F046223C8909D27B881950BC0283B64
      6B47C4CA767205FF12A0E8D20E347671FE9E1BFA895C80B38B0B10E124D8ED15
      8CFD70C7F7608CA153BBBC8089006522DCE505C4425CF0FC9BBB38FFE9229CB8
      B1AFF660274929C80481BFD358F40F77EEEE383F0EA3F84A4C767B1BE651C6D1
      76F224A0196331593026EDEA2EC48B24D17864EFE20A40ADD971C122B912DE6E
      AF205DC4177A052D63B928582ECEDE1A1BC5F7DA28BA4FDC46B1563F3307800E
      8072B2B70A2EF76EC79C8AEF3D15BD277F2A1EFF40ECA8D9FF0D058C501573E9
      DAC2886A7D2428039CEBA79327C550189DE4B1528186AAD04F73B10714074E41
      F91940F7B182095C5241075C7F4165B5EB10703C94963B84BB0E30EB9D7AD0DC
      A8449DC28E58FB321928B1F6BE52F842E1EB1FF6D665BBA3EB9032D9EAD73794
      5ED66AA1D2D285C3D1218B75FD73E909E88FE5A0C5D585A8708CB90839BEC8E5
      0E3BD85A1481889ED86DF82E7F1DCD953FF9B7C7F75F2662C4D53F64D73AAAF2
      8EC57C545B22595AD4D705D96F399CD9014CAFFB76077EDABDA603BF9C6EAB07
      BF9A9D4E0B7EB5DABD06FC6AB7FA784BA765E32DDDA683B7F49C568B9FC65BE0
      9477699846BF8F37D976BF8177D90EDC87BF9BDD16DDD7EAB43B0F7BEA9F3F46
      57E73C2E2C9F9CB267A48CF6378CF5A8FBCC05769688C2BF75E03F4373F3B991
      59FF2B8A5CB76630613C185B0ADDD94ADD3917D7EE7BB96434AEA6FCE83040F4
      2C85C14AE0E7FDC1A0DA5A9C842FD24319B80AAC11D19A9BCBB958936423B697
      43B92CFE877AC571C1620C0F0275602464F45C2EB00A24044FC43EE682126B57
      62808947A923989248A44066A860319992844BAC54CE716C4A82842B7B6F99E1
      EC59FBF0718FE42EAD0B5313C54CBC1F53D0713EB84EE3BAEE5D389B81E8557D
      2611C93609A0BDE75A2CC10FFFAE96F5F821A4CF9F1DCB866F5C983249FD7C9F
      3A59A485A85172E5A7D4022F1FA4980BE2E39E979457902B294E91CE692A6673
      DAE289286625EBA7B502B10539F9DF31B0F23F8E419DDC4E94DF61B67A5F45B3
      5917E2860E4096ADA1EA33272BF7501A845BA7228890A59B0D1DDF3CD4D510F2
      22212F693BBBB6E800D9669601AA8A91ABEE7819754F24B5C168E9D48A172156
      AD91345A2793CB6E5085B6321B894763983336CA5C3F3B54E417A16CBCA7624C
      2D5F0760730C77E58BF6C99D71FAA92513A83E753B6A048416C56ACB339C5271
      39713D12402CA5F2757CB0C98A0AF0E6D070CEF859CD18A1020FA358B8A9ACA4
      89202473862E4A44751628FE5A96577874313D8BBE7EFC4C832C4DB55805720B
      3926C799F2BE8524132E64716C89E3C9F13656CF91CCFF570A87DB840517E91C
      572B7181AE84AD5A9CB81612AF40B0B4A98F9827123FCEE967F5EB74AF27A857
      B279AF9FE405B394CF38697D7C9231D7D20DACD134F247945EB1253D7C7D7AC5
      E394B49425196321AB1F6BAB7706D75C8F9E2CED8E6BA9D4E44CD59100CBACCB
      8864E52C6E4DB2B491CA6E814EB16452BE5AD21ADA81AC6E7D7E16256733C6CF
      E36812BB3359F8705FA61FFE59B537EC5090CFDFFD93DA100E881D717AA26C71
      C64CFB30433E720C623DBFA5A0853057718A1013EE43544317229710046DD53A
      C9379CD743A4D3385A4CA6B7AB04B2E8AEAA529630EA0A598C73195A7EB92DDC
      BF4FA08551BA8DA651CCBB8ADEDE25EE97E6C9C83E1205B4B4297A519D397270
      971A666B7CCFE9BACA1892054F8268480A674EA1D9C7BD9DC77E14FB297F5162
      9F3AC8B1EB6D14A71ECDB79A291FDD7FB678BD551FD18E6E75EDD226CC42F85C
      95B8DFA478C0FD12EE1D2A1E70BF0BAFED83BC7F0FE44AF1806D30ECD17C0B1B
      5E8341E4DB55211146F3D8150AD6AAB7A01F00753DDC420704453FEE1B6E3504
      6B8A97A25E2EF1066D580A5C0DF9966A6952B4C3617D69AAE92ACBE980048EFD
      616EF2B6B9C757CBCB8C2C8FA799DF628664481D720091279251EC0FB5C838DE
      0E7FDB769D8887B1CED558F89BD89D44E1308AC30C69AA238BEE1B4C1B74F2A3
      B25FA97F29829BC3A2207CABD4C98DB38A16748A9E50A224291C8F7E52FF1DA4
      C96BF8EF3FB661224FA29960D949866AF2619C930EB6BFDA5AFDA0D8276C2BAC
      1781B505C193F5963F95A415DE2C477BB1C4755841AB1EAEEE1E46D66F25C422
      B37010570BB0E508359B6BA96EE6140D88D6BA40703383465205A78724298D7E
      B3514F27D92848D0D8B86B841D4C2C11C24C4D41A3256FBDCE7B92E0B142E1C6
      258D442857009B59609852BE6F0F0889D2A34B86A6D54617784A4D40FAC35319
      4EF950F0FFC18A17958F50E275DD40741E7F5228BCA9DB2FFCC0E53557EA6B6E
      36F81A59B1F8063B7BC3C94DEC07813FDAF01554587065E84EBBD1B0ADFDAFE7
      A747BD0343251495F80503899E880BFB710C13990B5BF591D5944D61CB4AF350
      A08C86BE3D42C24DA3F143A3F19BF5DA1D5D4CE26801FC057B7756ABC6F10FD6
      AF32E445D69A383E3BFFF2EEE38F67BF49A25097C61892C024E12919D01ECD60
      89B55D29E0E7D0A2D63DAA051117C78DD22C43DC508107A40299794C07B0959C
      666B9FA22814DA1C18367FFB9996F672F4FAEEC001BFE75C3A0E8CA03C1A9F4E
      380526573E87CD13B8E142D608C1C8038F270FB456E40162F7391BBA4866BF59
      A76832958D2FF7A913E60FAFFAA7BDE6EBD3D3DAFAC326EFBB0B21BAD7099C51
      34996CC60B5330C46E89D855DE97A3865B3118FE17FCF70006C31AC5CC54DA1F
      90331274723E084D180DDDDB2ADDB39DF564E064FE4912997391A4400AE625B4
      8808E24FE443B2DE64FBBB451969473BFC22E82D3C0631908AD00B0CAD5DB232
      07AB0022A23AC44EB9B1B88AFD34C59EB995834598AE9F0A50B6088301675D4C
      9F453BB36E55829D585DEA7C37F3B10F07D1A5ACC76ABE9597C0F0577651BBAB
      4D416ABBBFCF725AE0218D76FEF6AC85F969AAC1D7C79FF33058AE0340CE5C2E
      EA439DE465B32E18A4FDF2ECECAD4C716B6501E17298FBB7CBD5084D98070B00
      5A729C5E3F7EAC6D06176BBF868B90D36FBC4870332D9535E487801E00FDACFD
      B96472B9A51DE81EE812D8B8ABAB0F72645720B0DDA5DACD47971470963449DE
      93FB8E58D8287B2A87AE87AA2F9A0A397A7C7512C4E0ADE89100806D2C36D8C6
      62750E678D5A60B90E4E2906E271DF26A4CC32DCE7EDD9076B1CB854B54C2632
      FB63296FCE7CEE649E8B80D9286CB04080EF54C8F18177D03E7E1AF51CFBDF59
      CFF17B31FDF74A48217B1E7CBBF578DFB9DCD013440C4722C6E333FBAF730F4E
      696D3A7AAF84E50899C93DD45B6DDDC76C9AC7F54A507F1A831CE8BB81F5E6FD
      09522A78918711108AF21CE539E41344B5D6C3A0DAE0F71AC8C6A7FAFFFEFC65
      6BF8460EC29FBF142A04B7AC9FBF3C152C6CD7C4C2138A728F42EB24580CA518
      F610C8F8106BECD45CA3121530699C56F85416D0ADB980300A8FCA1661EC06D6
      BBB1E52D2844070537FC0D9A7B4E63A3E2018CC7F9A6CB9C7729CDFCA8B4B112
      188582CBA45239EF7F2EA83EC4CC4DD22C4744B55C0EE0F0D4502EBD9B7C7808
      CBA4D9C8B956EA3C133F4E52D9681809CB55B27EFF65B3D1F9220878FE9427E4
      877059C9C74398C4C5B6623E77C82A87DDD43FF03EE82C55CB03DE1C99FA064B
      152D97C14307479DB57D9D3C2CEFC3ECA9A21D040BD991B389AAA9B93116A453
      DF798B1A8789CEB9CBF5AFF9542687D6DE289ADFA082787C7C4C47608F0D7DFE
      CC0F60F3B02F3071B9E42033268E320BA1B62BD6D612B988375A103997D9452D
      555CFA80484C45E4C9BD89165CE15B2C9D7A9EF98645B451291E45C1621632DC
      C92CFF8908DBFEC4D7AA311935E15D6E02FB242B51614D419F364E2AC5440F0F
      2A5F7CA8B9277E7ACF2AF7FEB868BF393864C3B69C0A19490BDBCEED4F4FA378
      F6EE8DF5391663FF7A2385FCD2E77A880A53643A07D041802280536E424825BF
      65221A0526CB4DA9FDB20FF2056489526604B959047E0EE5A3AFEBC99D9E4024
      F3EED5E70634E2421CC9EA0BDB325BC11EBC48B91E8F185D6C9098795AA00F35
      3DAB8ADD29462A5FAABFA56212FE4CD702A1EFC954BF7CE654DD7BDAC35F8F7F
      5305B65068F8F5BF7EAB5FE1F7BFE16C93994A95F1772F398E9DCC479830E961
      DA6A22D204C75E9A71EDD7BC8916F8821358D9050A2627691CFCE56D4879F3B8
      685E6914C2A2534DA133C182AADF674502AB435400764124CBD6309167507DFA
      7BED2993D35CF382BD9365E20C729080AD7253A17309885E6A72495E929B4285
      AEAC001CAE08EB67A1EE0CC4E9A5264B54D73B918D13B05DC24686BF1A934632
      1A0B740E25394E088C20163381A955D92930D256B9E1837CC7B0792FCE44353E
      4A2023EF48D459B6A6514002C0C9F997F7B45D1E1F92111E92174664D3D9B674
      0C224E084570DF019A99C4442D248E55816DA2C8633748363862ECDF416D8CA7
      C452C221BF5915E49F8AC083295CB1EC52207FCC03DC1156E8CC22493EC87C74
      F86DFD583909609A73F6B5EEC3BA8199DE04E2801DABD999C684A5AD15E9DDA1
      B37CBAC07066E4BBCAB1793C9946B08FD2416E8EA27648335CB28C11E5D6821D
      8F6F388B7B5FD69E9502F4026824E125227C925005769F62126E80337B287E4D
      5D29E9CAE13597ACAFC98C9159627E9E7A19B5CBC94D1706F593F430FF1ABA8C
      41EE13787203D1EF2DAF4F9E5B129858C4E0D1BFBECB5CF028A4DDBA32732ACB
      8DBA05D5368A51EC04E2F82392BEC41CCD354A9F040D9ADCAC319CCB452CABEE
      6BE60738CB25EC645FAE08956D7F264B14E36D938842932A5F87E7DD0AFC34C5
      C3868FE4D5F23928291BA8C63061188EC4E2344A7549B629EC46A2786371DB0F
      33E34978C35232AF97AAFF5D09AC299EC8D45D6EEFC6B8848713E46031614B0A
      814195C83924BD9B5570D4B342976A05EA77D7AF0EA29FE1ADB8726F90E7A738
      2B863E6DCA48C4149EB31FD6882578FEECE8CA0FB155DD818EA92685CC9521A9
      CA9A309575EC8662E4EABA9DD48F41991F24A81324C8D1224C7538189531A1D2
      7E095B85BD9B8363EBF50D8E4960A185503D703D0691F130224C025D0EE0030A
      9A3F47A5C8A70A8A63107952D07F522993B061494E5675F1407D44E04C501093
      469E4B548228E86D8A09DB354EC0A45AE55FCCEFB28B54B905391C4282412A37
      23EB62210D5411D0071FD502696BE7CDD9E0A5A068C31B652B1D52FCB1C2B284
      63C2AC5286112651802175584106A302651D4C7C68198E535D6B263B49A47613
      7F428BD36C9EC23EBA97FE840F86360472DD4BCC14B96113E1DE29D9AB60DB6A
      202DBF404F7FEF38273DCB3A4C6448C5A1E7119C4C7DB0D18181E77A16719F97
      9019B8ECF08720C28180A8BF48A4A3442E09E0829D60FC30B32664E0A3334120
      C3EBF82A5A2DC548C291CCBD9026CE3B11628566DAED6CEDAB0B233236732FD0
      5B933279143590B6DAF592DC48870B408158D052A8DE215330A12CD168B091F8
      90460A4D96F088558731622AC0C89D201DE25108061996C00884F374F691D62E
      A196A9C551D72FC3A4E46CC9F560E49782E58A4297B3187FB29352FCB062E087
      D228B616A0D5870DED802A955D1E59691D6419E4467B5BA40332D44EB56465EF
      E80CA1CC348BB82A3105D52A416423D74036095D3B3B73C61C5A49444645E443
      9E8F3D51E0D08AEBB9EAE5E3879E0F820E6A5A85932B1D367ECCA58CC3B4FEA4
      FE5BBE6E2C095ECE0D8123935FB9DAEAE5263E86AEFBA48CA9DC613DC74DB8E2
      0D70D3193BE5387A5299A8897348FB3432954B17B66F18981E73D527EE6D8880
      7AF9C64FC8F88F10FD2288AF682C32E4A958883357105C96B7FF994E843A1A48
      0DD82A4807D093A0C50AEF04EC0CB287794505D4B545A86D76C0AB1566A33097
      1DE96A5981F342AE0A4AD38ABB9BF9BD392035C3CAF23AA0390FABBEFCF42AB2
      38C43D523264CE16114A9BD8663DB5307AC8E20AB69993D5D1114D85B028B14E
      6FD18DEEC25C9DF6BD93E2F48E8F8FF7B293E7AB8E8FD9213FAC53980F26850C
      88DE426ECD0F590AC83A8D6A1C8D500991E2077B3F795E4BA20DCC24912A8F4C
      E2527EBBE066D943CABA1F360FA7EC81B04801DE520FF1CDBABE82E28A2ECA84
      35A0208A2E8820A539AAE70E79A57031005E9F5A4DA9EF26DAD8B02FF5E0BFD4
      81A49399360E8E4B292E57015520B95CA1BFEEEDFB7C983341504A2F3AFF5D0A
      3F434D7A7927652BA46542EF274BFBA8D1883694108F956B1593B5223D06726F
      91C6D326D63875D59D13B0FA369B9722744A0F17A9C88C146A77A4702B5BD5F3
      D2107FD8ECA0444DF6C9679556E5C032F17048B5EF53DE070C23CAA1EEB1F58A
      CC06A86FFAF14C9D3FE505D7285BC47782DC5068755689B74B68ACEF436CDF9E
      AF7A87F8D812000D13CB13BA65ECC253CB9629D56CA680FDC8F132BC179B2B33
      1FD9C6948F0023977481FABC0B1311A7C75AF59437CE2234F8C15CC9BD7D15AE
      502CA0B3278B3881AFBFCEAD97EAF31BD2764FBE9C2CBD112D4ABA627C6EA4B3
      A93F4EFFC273009A5083E690EAEEA6B93860C59F0E71AE64B592E3F9630E4E1E
      CB283F49056976FEB86C9863328D168382308CE8CB895A920C512B2CE40D5DDB
      C48B988F9BA62915E306A42952D58ED781D0380FB922495403152EAD664B8101
      334ADFCED69FF05B004858D4FFCA9706FB6CFDB9B4414E0CBC72B1B73BABBC61
      7D27CB5B17DE5B2876C46594711E187674B704C1A5A3593B3B86A605732C4E96
      D6306E5A8317C3EED3C80CB41BDF991AF8D0493C3A0AE9C87AA5C40820171F3F
      9DEB307BD4486B904235908A5F9108A6236F3599E4E815AAC97DFC0471A69AE6
      73B8F691F569592A524916F298141C6A3BB9D4E7CFCEA2453C12881DCB42E0F2
      6A590FD12EC3CCC758ECA021A39F1909A45B89BC746E0EFD72A827A1CDED926A
      C404EB0E1C3437397D35D5655EBB539B01901B32BC8E90D1E461AFD3660E8B47
      8D0A30EEEE497BFEEC1D45D658EF3FF19A312246E2468E77E6F9A38E8DCEA26B
      66AAFC47D6D66F051F96AC11F32861ED5321622EA636AD9C363569A5FC841FEE
      941CBD047667C3545567DDB44033AEE48876AB757796480FD7E5897E70591248
      44C33C0DD6F8FCD92BAEBC70B45C0DA1D03E248BD59A61184B8CC60CA065F771
      E0EE75E76BAC178EC56BCC958315233546F391182D0A894B57DAFB4EB1E61820
      0AA2203D05127678A3E3ED75F20965DF2D1F4ED99ED3CD1E90C775B83AD258F9
      8FD68E24C30BCA063A9FE68D7D898ABEE0A19041D3B66267ECF0A64E49DBEA82
      4B5457C668C8056B2CEA074A1C4AA3C944DACAC800266D3B3362F15AF182B58E
      04A97ED8830CA39E39A6836FD522C52C5A6C1078FD5A625D313067C821981E95
      E953D835F12FA9E221E6AF2C730765A9233318066CF0814067A5888D1AB48EE4
      AF27F64F470D7AFEEC73C16EFB51DA6D65A51D6DE4600B42B59555B6F54D442A
      ADF833B16CEFD10102B9EFE45BF6677EB848B258DF831D95DE08942785583D4A
      5CBA5172985C2FFA7D30CF88C21F081ECABE1CF8F36184B89B99DC49EC1B7288
      A8C8657A7FA4FA749E9F1AE29BC53DAC33A2AF5AC329ADED507A1A6AEC6BC119
      A18CE9B974C2BC2A77ABCD93634C702464C1BCC7C7F0E4847D7F63769DE404F5
      9CEF806876FD081082840AFDC84D00BD7ACB410B7B4BCE18B47766B983181308
      3B3EA1945BE56208C515C6C191894F8D532D4D9021AD3032E7641753498D63A2
      3C9DA4882CC6BD5E0A193A834BF5050B2D4D5D6D941ECAD65459AE6936D8262E
      E0448A4CE87F95B53A945FD1A5E8DACC52AECFA34C84DDC8D3CC89FEDC5C8B4B
      85AA5EAC2AC93FA44EDB5311D4F7B27CC2D8DF1520CA6408A9DAAC851FDFC3BD
      7AC900AA48082B2C9BE4E0CB1008328FAD9F8A1791E639149C8881EE9832F701
      4D43A714092CF49AE551B9D43CB360293254A7DC1722D33C4C54CF2A9F4D3827
      C84DB2A00E3CE81FAA83FD150540871E46B7597B94EA52126BB3D44EAA18E731
      2E8B9DD9A4B209C710B1373727312C87614843241EB6A4587A2033C32A199508
      C6B2FCE552DCA94EB9D70DB70B71F4E654565788405F2D00AE5AEC32E7768373
      BB7A2CD9299EC3CD473D9985908BEC302AAEAB03A742557C28D331D6491C6CD4
      27DFFF16B36A77E8985185531570610E50E100558757D73B615C45968242E014
      6DEDA0E5A31257B8E162C90A50A5F7E71307E15EE163C00A667E52E84BACCB4C
      E1B42BE7A6020FE1D90D4D003CAF751444C353AF25970BA356939F656E12B8C0
      3C75A90EB7DD70DAA36914D18BD94852C8D25910B6B0EB57CD8F428FB4F14247
      1EA94249F94C785349A0562501DCFD33B98986ECE5B9F132748A940835FA1BAA
      1198054666A16399B6AA0F888AA6D9460FA9E7CF5616B37F7D70DFA595CD89AB
      A67A3077AC3E56DC8C3D73F0D6D7B42A0117A75ECC6095FE51960603DC87385A
      68FD7AFD9B3A6E6B0A5C55BBB9B20A58ED63EB4486D172CA9AC7A93729BD910C
      5314436325334C9588F9FDCE6665E9CA1742CAB5EEC196919742645E499E0F27
      F6AC802E2F679558FF0F6569894951EF572FA5680380429D940BBC554EF252A6
      C66C081B2ED42CD333566112F8339F45982CB07ACDAAD1C3C6D53ED055AFDD1C
      97BEBB46C6BC05A8817F21649487A176953BF84577F4E212BEBF12A6CF03F15B
      A6BD668865A86041FCE01A954B70AA13A793F7F3EDEBBCEFDBD4A942AED8C19A
      8E6C9BD817A9280C8845546544F9C78960C30CD61C4D501CC4B1F50EDF962E62
      EE2A89CF53A73691E8266EDAD008B3F362773251048A09B0EE8926D3CFAC11E6
      104B03256511D0154933EBA46EF0DB62984A8182297D9315492A2242054EB3E2
      A1F3380280CF721E29B51F1B64F6231B6414508766ED99C945ED14191DC1519A
      8AE622463712556A59875572242A7D95AB92A8C297D3686E11E9D1F55C152E81
      945B2B0926B55481048C70E0D9B01F8BB44B55C0DB90D41A2455091FF27782FC
      8A6A0519F2A980C4C5C454101CC2862297D655F57E68CDEB884B70C8BDDA4635
      6FAC54849E5D240705798F66C6FD2EE5F46A93A79F644D594E88A378A85741CA
      543EA97C5A15B69235DF581A43F39B2AC3905054A43F2E4C2E17234333AFCF93
      4265951BB989B427E56B66F1E8AAE825F70DC15A3B9C51A84A87E91BDD584E40
      32171FCDEC745A6438BDA162D5EC8DEA8173C91E19BD64A8573E117614CD669C
      1B1492A9192411AA6E9F95B993C64F32E0D6896DCB008E46290E18C364A64205
      393A04FBB992F9F2469FCA2E89D93C02E8DC649564AF5C8E185884A05BC9F38C
      59225862DEE32A6B1CF738E5209D0399858A450D95F8869955984C2C40D50361
      C79DCF550F1C7D901E9D68137EBE21689D01C41FBD07D9F3676CE4A6F83D9702
      5CC2A348B594DBD79FFEC6ED8BB996C4A145D72B07C707BD60941C5A2727C941
      210502FB9C71E8FA9AED1810326EA1F9E0F276FCE06263B8C321763A3D1C6163
      F3ED6E90AEA75808FFAD0151CEE3A074FA997B03A76C142CB064A6DADE259F8A
      6128A5FBB17786D15F5F438A9EB57EF2C3740F68CF3C704722C914B33DB22722
      0AED4913A3E13A194693BD6D1D2091A24BEF9A54FC3EC9525EFB11955A902B3F
      E028050EBE9389251815BF90A3A91ABA203C2A4BA9DDB0302920A5A227435457
      61C429BC3513C5D879B9083D992EF5933B1B2E622CAAFB812A11A97231C44BE4
      9B646828962184D5701021C60366EC53DE595B883C51B93AD5D22D96E2F15580
      A4AE3AB648B00C2115455FAE3BB6F92470C05FFFEB37B51DF43AEC4B8E69A5C4
      AF393FDD6ECB724589E4D0701DEDD8408100DD5071A4D404760EE364C328FA97
      D04FEBBD3104A89E5E8ECE67364BAB2C424B70EB040236121E43703213D7DE12
      D0F65F0365385090DA9354A6FA582C9522D9F7720E9C345E88FA4D9F4A5B9848
      3958155296F94FB3F2EDDE57993D5CCA1BB3FB5471644C47C5859A53553B2219
      405630BE9A53A4A343F30D74D6D9A9C9964E68ECA682C314FCF08824234A2B03
      A445C47D87C5FFB1BD1F0AA1956F5D60010C2E797170689D82149C7261C1533A
      08BE083C594A1B6B91F15BB39771BD5AEA8C02670DB6576CD266E82CE79B5CB7
      127E3B9BFB02ACB261797134E7B250282B5059F479449D198023CB1208FB827C
      8A6418E385E5BB494E17136CB7B1AF4DF1940ECD05D6DD49E8A7009003F44A7A
      B94AFAE65C979F6B269335CA33F1BEE28E98339FF70E2A08E60004D23815FE43
      897C1D5928166A24AF41CC461F3C30079250600B9FC4E20E84C0B17C2E4E46AA
      FF3016EE058BD5B2DD48C269C5A7EC507261BDEA65E8633407A15A08C2FE11B2
      98B841F04C3444828BF4946DF0687E548D365477188659DEEB399AFA6213956E
      8F81BFD4BAE244B566791F01E6277B796F3877FDC490A45B1F4DB83F31ABBB5E
      BE59CBC4FA7594AADBF005C96FEA69F9E53B0FF9D2C80DCEA30F64D5FB0500AA
      9E38B4B2A7F17AFE6F1E6DA3748366711D14864D61017E8ADE6BF22CD729AFC2
      CE67A559537AA5A71C6EABEFB0F6B5EB99D574349F1DE41CD9C732C99203000A
      7EFF34DF49463F7068C9CE6A640D276BDCD22BC812A1A285D37CCD7E59B1451A
      A8536EAAC086074439BF588F18F30C795BB3276AE0731D27B905146C14CD842E
      2C17465E2133B3586C31BF0896B45883C7667DDAC42EC72004CC65575E0940E5
      17A9B2376635A58AAE7F85957C00F1066E212301424D176237F327EAE39A03E6
      3C8EB0B9DDB1258E27C7EC1FCCB5CC9137E18A6B40B1DAB21D0837A486555C71
      21C2C635F87AF45960AC1E21228160AC4F2EF56EE13E7812870405252C95F41D
      E1D81B101732A6B9399C92D87458165B86F7EC8DB14057E0FF0BE362F65D2ED3
      A4E90FEF9D7B73A07AEAC08C54083FE1A697456664A8A10A4E47989400140470
      A956F00B67ECAB2A9B0C17EC8896DFDD2B37B72E5532206B95AE4E0C0C32226F
      29B09CC5285DC4D87147DA02F729A24EF636C298975C296657FA8CB25AD3F2BD
      B198010B48964FA8CB7B4ECD03C85E98A45144E210352259203D57C17BD679D6
      5D0B0B492C122A81EDB22DAD0636D628DAA7A3C3C35CDDA8755B2FAEA9E2096B
      3554599C1C6C79EC213BC466D8B797172EE8909DC80342265D718D45B070E772
      BD17D8FCCB9C8776F4BD0066BFC7BBBBF79F0B1427CFF2BC8EE3B798C016A20B
      54BCEC461C69EFF58DF5DA4DC41742823D59699B1C2495CF0FA36B857232F84C
      65E4E7C247392A84BB6F72781AF695D177ECFFCD227D924B6759276FDFBF47F4
      C15E7263249A2375EB0626252604B995E044B332E987D65F0EAD2306F0BF5917
      E226596E02270324606F38DDEF5510EC1DEABF3E02B152FBF32EBC44615DE7FE
      ECD59EE5F367D429941BC6642447B3514956A4C0A3CCFF2A53581D7DD5E123E3
      574A06E27266AA7B87CC218257E18993755CDC7C0D78BD91BA020B15D3A11BA5
      8321117A74F5DEA52A2A14C5916529CF0B61234629B9C5960DB2B48C19E5F213
      C653569A40A8CF8AAA8B717B2BD144A068AD62B28682443EF4EEAB01DD609360
      5B9F998C2EEC8911960B3FF088E7AEECA1EE68895103BA67285B0C68CE1BC4A7
      AA6AB909B7E3F0289E7E4FBF768FC2B754EB6120AA3718A0A07B1A026F03704D
      61223548D34C6491B42A3931DFE68FA5DFBCAF5D063A27110B3E1CFE0B1835BA
      001E87EC1401A36D800107C4C24EB0791E48150A2CF29D6EBA69B3CA4FCC27D6
      6D80C616DA258AD1C5922AB9EDCBB16B3DC4CB45980DA77855B652762DEED534
      36E494BD8DC3924FA29842B626229421BB9C8DB26EA9B2FF7C4267805265C768
      444A1761AE718BC422200820FE301177B9BB0A676BB8163638C633059AC42426
      550263CC757A1D7ECD11D7300164E8091FBCB3B3B786D2D7F6AFEC4989EF1495
      C43D0AD4C78FD64FD452C6246668807D56A124D4E8B706ED228CC6F02596E580
      EAA123415005981CCC73029682FAB1F55AB62A569D5F49F189C811F9E1D5D939
      D0EFA1A6063AB42FA775C97C311A975C1A2FF058614BF77CCD58D4B10EA5DE41
      E25380B17F14AA8F6522A345AC8B502C42D05464FA281E53223C28EB0BD6ECB0
      A22E2C24A4468F07780EEFA5F6EC5C44735580CA8BD07241CCD385F78AB9D2F4
      603E39BA42441C8D44481F38BE9772D829BDBF105C5833983C134875B88BD61F
      D184206359955A0BE0CB6FAF6ADAC4D453F6BD866DC5EA5A7C9BCF29EFB2CAFC
      DE2BF88E07486EEFC495AB8850C754B75C3461DDBC08C9C4F2D4A8206CB2C86C
      6522D7DE5A6A5A098142EB4ABA9F921A28B4FEB9005421C73AA18F5C2DE9A5F5
      D65B5F9D8CF8DCA99D513DCC55A9C6FCE1A3BE7F8772A7678B1A11EC5A3779C8
      E482DAA191BC185A0B2EE1D1A321495B563DA361CF6B0182D21CEE2F64F7DDDF
      614B7E0112F16EF626828DDE4248E8B1F519EB9F08B63E307603C9D2E1DBB267
      B690D917241E79AABF5848EDC5B465C28BAC0BC4B12B1C81BE89B1243B2CCC88
      35D58AD10C04C24B1989C39496CCC24944DA076B0C23690C93D4C9D4FCC939C6
      32EE437A0222627501DD44869764ADA1735568502FA8EF993B838DCAF8C15A0F
      5CFE166B9F1814B6905AD50F0FF634FBE23ED48ABB506A396241FD0690CB9C6A
      EDCC0AF7A049F18B64A8649626AB9EFCF2B6A9555729D870EED8F721B09AB984
      51692E93F998C0F8007EE3CCF48B048CAE513D020E5F2781410A99D424329301
      6032973A2E411A5B4321A4BF6A98C964481BA9B40F48916812E148B99C60C749
      55973EA9B59CDD2B2D7D07F26A8071F4F105B7D25151788630565B2654372BB6
      F3E7B40D8ADC3229F82B19D8257052F1A14BC54536720A90CAA57D3BEC187C7B
      F6E1107EBC6716F53E1AB9E40D94AD26A8CC0559C339D02D1045AFDF2D65D1CC
      A128D7E9C938F9458CAD5F3FBFFFEF2F3F34E83FBBF51B1217E53ECD9A830D7E
      47EBE9E0DBB1B836D1DC392056DEA2A0BC2F7BA529381F282BB6BB06DA54362F
      0771DD4B2297A4C8E11AB98E90AE258339E17CC6DE28F254ABAB1C0FAAEFC163
      673B30E904CDB5795B6D1ABBB211F017A5F37AD6EB9B15933B9DF4A211D99CC7
      F2E472B567C79EAB2AAC4B81C19CB7BCB7FCD1F3627F722B6FC96DDD368A1D30
      B6E4D2BCA4A04991AC9C5D59A828253DD75C291E6990980D85E7152DA4407636
      F4C9E58984EE2F8943C16C5C652DCBDCEA48D730313A7047EC1CBBF79DFDBD72
      E37E0412FB91C96C7600552B50DE4E80C123DB958662DD2618DA594E16FCB921
      966B892541460663A5EC4D74676CBF5D4F2F5252CB3178C41D8DA2459819F767
      AE47277B3397B99E44A6324B1BA0C46FE9B120B11E47C69B8FD36B6E12BB863E
      9963511B0154D1AB13DD782B0AD7694BE6C86888718FB3925A88D5D1912AFE93
      EAFE69274EC8D957EC41C2C2DBDC4F565DD3E16632F679A95BDAB1A52A0DC1CC
      8AA38F23F48320F364395F0ED88C3DF90A73482AF7ECD79F457CF39BB526C8D3
      D8C66B94162BA2A176FA24AA73E6E357B1F927EE24B2BC91DAC7C7F70C1EC9D0
      CF510DD866FDFC74B5FD28EB3075B81460AC6BE3507B277CC4928DA42816766D
      86CE28CBD0A1005F6926389466EF4372816FC38D8BB9B04F60BB9E3F830D53C9
      3614B3CE518BAB904F54023CED13DC9D95E4C560AD603181D990F4A222F3543A
      49AD021A85BEA4B9B8E07D99A5E18FAD93F32FEF51D79A8A403A505574E181A1
      F555306622FF2BD6C3F98DD3020C89DF59124F9EECEDD00A26EE59E97220A9F0
      2B10BAE962EE302359D6510FD2E94E7A8DA6EFF9E057ED9EA73AE5356693A750
      323148E7D22D7529A1000D9933F135F4B8EF13FEF58693563273AE4CE5DC932E
      DC3D9D9E994578ED65157471312AADA6ECDDC75BE12F842778F8B6832BEBB90A
      C57E31873EB4BEBEF972A83CE5EFCE3FEC01DCFEB9A08C1BB29DCF85346954BE
      AA49D1F6C9B2B8202BB8E8E035C65C8C5CC674570E66669418FBECA4DE7BFDE9
      ECECE5FB4F9FCE75E2144C1023E60BF953B50D004C73393A8093A68AE5F71771
      88DAD1D8DA3BC32C4EC442895718DE20421D7C47552D4079CAFA01687B23404E
      55281D4593107D87079CB02F40F5DA7B67619494F5CBB43AEC3EB5DEBD985914
      4A2573BC70162AE45115F400812946C0A037A57EEE0066E2E19E72F2016730B2
      94A8E0FCC6BD0A270BD4F9B0D21F355BD29A63122D40F373FD38C4E8CEC00326
      3312DC3254C722A06C282D2413D9EA5E3A5B432C3F069F92058767BDC0F8DC58
      B8DE4D3E83A379EC1CDB04B85C6879BEEA7F9DF8C3B17FAD9CBC491D0A260EB3
      129AB84D18E2404415333632D17696CF69CBC53FA85C6655AB0845224E1258E5
      F6122070FF88A3761291D52E52E11A9E7FE97B0B757AA8A478AE3228671A6381
      780AAB94E7797893AA8CE362B2369CB90D3D6E597A6B7E1527D58E463C603A5E
      17F6CF5B8C285AD81F1355E7CE56547E2ECBA140A498B921469C004F9F8232B1
      8F5999FEC84F253FB991055255784CEEEB5C7D75206392D1294A66EA3CD5A862
      14BB9317E18B3758A80770EB6A1A159CC0A6F6535961EB95724F2AA568392B6C
      BD1DAEBAB49A286E0646BFE77B2F4C3928663FDF3086E35280EA1EA8F671CACA
      47C6F490B2B1CCA1A884FD870823F000B2710A8206C9937BFF67319B036BD95B
      5BEA6B574EC6C3CBBB6827B6FEC2E58F1E5FD88DD69561932745B20A8C51C936
      53F579352122358FC647F712D87402A27B2ED27B57D0FFE119C329908AF3B767
      ED9767676F81E0D6103D3DEBF453EB1053645D52DF853711AAA3297CC4FA5F17
      897642E6327E414903918933F2A9A504F6C3519E1BD2F9F498525D51C566F03B
      EDF40CE5861E6259405542387B35F60DA3F4524F5C67296C5C56D34F32C9EED8
      DAFFA2D24E57B428166B51CDC29201E3F1F10176B7C5F79CD480E9DFEB1844A6
      B246D1D41DFA94F29A4C17E37140423C08F0AA4C0286A52B6D66A9A5CED29225
      3CAE385E148B2A63F11ED4743853249F7056783C51297D5C150854C131E89994
      32EB8758D68573AFC29C12F9F1D5CF1F588124629499C13C910A2C3E35C1083B
      4A5D01893A9766CDF5B292C5BD54421AA332871D34B9E00E6A37F573F596105F
      62F5887A4EF909672B63890C7F24212E71335122135603F13401873B01DF4611
      6C182831293DA315A0DC1D0CC3DAB3FCB29AF49C4520488AC6794194D608D48C
      63800BC9FB7436D5B1D9209D716DD1803AB8CD1E612A2808F0392F9E6A822621
      D0FE10E4BB2CFF325DBE0F4E0815E881DF39CA92DB0BA63D0788D1FF4006A933
      5B75D52B795F2E9DF0D0427ACCDDF90830B284A761A535329A6524CC7491528D
      5469F8A61D8C17731348B41AB72F943B0A8FA434B7E86A7F75B2C225C5917DB9
      71506C999295C6A12D39CC5DC4CC677E253750C9BA75E7CAC0639F36021D66F4
      86E4CE545610BD9B32A282C7D5EDBCE5FB0A31D5535E179D29BCEBD3DFD1689B
      2E973C49362E8A165A301500DC14EBD06315A1059521553D69C22C38AB5A3D65
      9C3DBC655508E71C2EAF3161A146EC870B935A592B375035704C234C0D34A4A1
      50BEAC089C2C9F0F8F20D0070FCF7DBE3B8CF513C85B6F139512212FBA983EF9
      EE0D7C39C1BA35E7539D4E887579515A3C80F397A6FF3F7BEFDA153792A50B7F
      F75AFE0FEA9CB38E613A8DF37E719F9E5918B08B53607B0057F5BCE55A6785A4
      10A8514AD992124CCDF47F7FF7B37784A484C429AA5C36AAC95E5D988B5252EC
      88D8B1AFCFF30093E3B082609092BB540043448A01539891638B6D4DE5A56418
      A09B1390789BE8659D3DC1AD2764D045B972E6DC87CA91E5CD0EB945F8509110
      E7D0944DC89A92783900844D697D9C6509D78F2D687B08D3EEB866C8CCEB4490
      5A124EADD9E0A34DC53EC86626578CBC4CEED543F258D08B707376575AC71A50
      F35C2F6CF2C23BCE61C0ADFBD2D47AFB55AA69F14A92A294505B1CB43247B1E2
      1916605518D4D2222E5BB94D1DDBBEC0C893AA4CF39EF624352F6AC92F007D62
      2C8E1EBDFBCA8BEB234A61EB48E54075FB08AC131DD061A452414631ECB55505
      BBE3ECDEC1154422A7F24A85980589CCCEDC67B76CA9B7557699191CB7585FD7
      49E1A5B7E5C1718ECA544B39EDAC285195A884055AADBCCF83753BAF166E2657
      12EEB7D030FABAF25AC554732B8A68FE76659155E8E639634FAFBC4373CEFE1A
      909DF9265B7F750EF8C838A5C302A4CA1FB86EBE2D6482F62ADE97E48E0FDE68
      EF120D38B92C73BF4E7109A45E91069D790FE8741780E2641E1A04E88A808A7A
      C2EA98798E24ED47E3BCBBCA18D5869DF6822AD1EC805BCBED56B90B709842D3
      E98B76627BE5B561A237AF68D645CC6DBEE7D2C3285529FED2C32D0E535854A1
      6C2DB23A58B5D571A6B6628F4C0F13DAC1395FEACC0B5156A59D22EF2A194DBF
      CCEDFE9AB5CA13C34801D9ED7B88ED5370E9D550EE1777B5EAAFD0401210C1E3
      6633012EE747DE7E3BB86B0C2ABABE748266D304CF8407D3D436584DF7809E91
      A322A071DBB4ACDA6D951962C30EC00A9F33E56A0018EA5298F49C10C49FB98A
      1943D99C5EB76423D0DE76ED4B49C7D2612B1F45B98258B28513695A6EEAF3BF
      00B5920EDDE264256379B7DEACD095AFA4C647392CCFFC3DDE7FF7D58EDCE49C
      B6ABED00C25578C43586CDB88CE7A8BF419D038A4FAB9F066454CE88BD0F1C8A
      39849685595DDED02EAC472ABA83A48F9735D6019DC7DCC2240B8E296349BBBD
      3497ECE3BEF2966D33FAE5713F3C6AA85516D216ADA184ABE9E7739C3969B238
      BF58DADCA41B2BAF5890665934B1CF2883257461A38BEDD4DD92942D8022FD47
      8AF3B97BF3BC682A64ED2D0440748F42AC22EF5BBFB78777F9FB5B4BE847C4E7
      995197AFA9A1976BD8B8D826B7159F2C78942B56A7970F19839622213CCED423
      9C8D9762B55D1536DAA17ED55AF8BCEDC4F8DA4086A922582F528EFB80AAD5D2
      72A6A6B7CE1C20F8CB96610BA63DC63364D6F46DEDB9ED586EB50226BB5E4E56
      8A4B96CA92F0DC87DA15A8FD2BC9A2E8F1C122C27200BB382BC2B42471E01377
      E969268DC3AA9C0E2F4625A4EF974463E20065C15289D9935B3C306BCF420CCF
      72411B4BCE35D756008380178D3DF86FDD9D255FC83D93DC9D88B34E85254FAB
      392225C5C7BC00E6E965A9F4B2949DAD6375B3D4F228736AEC7473589803A54A
      215AB443545563A62BE23116A253600E19ABDAA423FD9D4D47C0DA59B5463E2D
      66D4FB15D0D015CCCCD2B4DF043596C4668EC652689023096CFD562A9DA5129F
      149106DA24A4CAB5981ED83E7575947D1F756BC64AA39619C33574038A667506
      ED51540BB78D6E2DE04EB24528B9778B3894494660C935732A6429B85DA19B4A
      67AB703BB91C77B31DD7CDE32B4EB5705E1FAC6ECE773A9AB79DB7FAD322A3E3
      9F96C89B30FF6EE1B6D1B2E0ADCFDFA67E1B470D1DF5A94686459DEB4DBDCC1D
      61DFC7B3742BAF56F84628C4BE0E631F14CF324FB613E8BF3E82EA03A8B52CDD
      8FCCEF6244ECDC1EDFAD91D5EE0EE2F7A7C12C8F8A071BF49D8FCFDCF147DABB
      FF5C31C141F8BC3FC22C8C7B0F98691ADBDF3D1E17ED85FC133E5B63EEA3ACDB
      5BB900F0F9E525309E0EA69DCEE44BAF80F58843B4B99CE7E4F632CDE1057E82
      BA5BC277784C33BABE3E0E7AA2863D0B55420347EEAA502DAC1CCAF193E3C373
      670A508047CB4ECEB9896BEAB267A144E54F1731C7F255D648F13D7D22DA9544
      C34E1D1BDCB08F83D0388111AA81723A05E95449E6CCC459F13AADE0CA521769
      7691B69366CA84CF195223B25A64CEEDEF329D5EC1ED38D12A7ACECE80C75C65
      1CD0ABA17FD9F2975B0A49179C5B235B60D03A07E88F462579C82205694A2385
      F8F4893D819F3B07D18C6B11D2DD0FCFB2A593B9A27C9CFF04FEBE312C85B984
      5C9A45CE24025966388CCBF6B0243E4FB84F650108FEA5F569D7E5C6F85A3B4D
      92CD10CEAE6F24ADD547E683A5D51BAF96566FFCE5A425BA72634D2EF78F0B44
      F25287A7055AB66C7026B1B83E4C58CDDFD1FF97045E2FE562626545F17319A4
      69ED33F072F946E6E89360AA05BAAD1F284628C77C98F5D5950A23A964568E0B
      460614908163D1662DA4088E593CF885CCF34DAD5962601DBE95D66AD03E2C2C
      B8CD56FCB55BF1F64EBB2DD22FBED94AABFB9BEDB7F215EED97275DEA1F001E8
      65EA9449203B49E64F524A7B8B1982073B9D9D4F6DFAA7877F767676B625B328
      37B7601C36BA2ED52A6C706E499A809320922FD936E53395B3DCD4971A0DC385
      A1A12180B374A502497F6B060B261A437CB9298AAB51576E0CDA54CF425E6BD5
      C5B8D1506551DCD2262D8AC2C11049EFBCBED99DE352589B56E0B28B1FB279B9
      6F5FF63E760F5A3CB0EA658FF16B994286428FFDF4E967D95D2533565EEA16A6
      53322A95A98C1FC6010CDC090E2DA7504629982192B440DCBF458E6BF66DF9AA
      61A5E66E1EA1978437B0950EEE671B4AE8C69C2FAE28FAB56FC811593A3D662A
      9650C7ED17A83D56C315647BE9AC93071D25DAB4E2BCED38AFC5A1136D9655AA
      B1AE185585F51E1CE472707AAEE3A29589B507D7BC1B57B2A8E29925C22E87F2
      9705A9C39B8D6EAB0127CAFDEC3454DA0F88816D4CAEA52D7C573ECE961CCABC
      55AE425572BAADF77E4072B7A2A37ABB12AE4785C30509ED01B53720C391F7CC
      2C9D201D54E16C3133EF4D9BE54245A688D3F4E1993F2D61DD199BA0FE83AD85
      56D0569BB6DA4DEE6055EEA0FFC873074F9F9CDAC5F19C179567169565370C25
      465767092D6F1C73D215E177A139A62770599430B5B3716C3841B99AA62C8A90
      9AA947B8A66A88F475C834F726D89C87795480886C558183B7A5AAF0EE16B5F5
      F933D354201851A8DC41BFFA7AAB8ACF755A732E43B9A959626098CCE45ADE4C
      7EA32CFC455CAF250FB39836D3CB6EF2845C6A8A4F347866CEA0B8656A0A5599
      17F2C83E230BAEA3CC5992ACFDCB8C91657E81F3E991868F9744CC8F114559D4
      672E3DE1BA46BF08DF3989A24AA35F03857F3A43B9E773D4EEB9684A3729A762
      5EB8EB5DB6CFCEEF3E4587B6872107D5AE7D5065A338C06BD5062D96F4BFE640
      44E5854ADC22F6276E7DB44E0DA5E969FD9C92C0BA99A7099BD78980FB6517E9
      22BE74B2C4D42A579E8BE157D83F3EF7D60F5EA42BD6E0C6CEBE3F2F8F398893
      12638271D766F39C8EBFE47A63742FFBCD6BA4D5AA5124BBE462EB9823622F8A
      D058D930B38A817AC9387F604B3877D56DECDF55F6EFE0D1DBBF740870093323
      2A22066181FB32C3CC460B680E8E3D40FCA2859016A36D74B60C036CED910997
      2FB8BDE4958EC3F3B8FC6B821E3FC4E6A15C2F42DFD771238FF0C3408CF70226
      F95E51D5E9DA34ED12D7CCE27A81DD6FC5BBDDAE6C7C169ADC5E446731101A29
      425E6FB619EAD4622B5768346B2EB163DA7621F0A110EFAF6ACDCFACB5CD517D
      7FCBD8DC92BFFB9A16B05840CCC7C254304B964FD10A74978167ED731A0372F8
      B5186ACD99DDDA5F16FB0F85D857D01C5578152C7E987BC341FD59A6BDD66D56
      5B675FE46494C8B0F3B0764F83192D3E00BF17079F03CE33A402558C5A757070
      AC5824D2307D770C9230A4F7BE48A2A2FB9BBC958C36F0622E8983EB3AD877CE
      A5BED966645388D0DEC9E40D8D7123AF6D9B7A8AD88D9A3131182E0A67F5D31C
      A73A37BD4CD8301D9B43100909F20ECABEB80A2EA9A08E7173770103CE52080B
      BA377E3D946616EDC2224B6E6865516ED4584D350682ECDD081688C2570ED6D2
      BD687F598CEC0DACC73D6A0862AB1189B957AEF7E91E41384C17F53759C5B368
      3B8B38339D39785C6694079906BE00F06D17E511FC660FCA23D0F55C60C95D40
      A4C12489F7A7DA37C804354101ADB25DD0E57003DDDCB012D81DCD264DAFA014
      CDC8524990AB35205D61C94472FFBA2CD75EFE69DA1DD1D7EEA4DFA37F7AE3C1
      84FEE98F4603FA67309C74E89FE1608A4B46832E2E19F77BB864D21B0CE4D3B8
      8416F8986FD3994E7151B73BEDE0AA6E8FAEC3BFFDF180AF1B8C86A3DF77C1D3
      E87F7FD2955DC77985FFDF9EE0FBAEA78BF71C67B7EEE57B1BD552187B6CC117
      1BCC6EE6B00266850DB059FE5F75F93F60DDE3FF752F97FFD5DF26CE66A72C03
      DFCAD1C681F43015F49E2D8B0C5906C79DBF3ACBC171DE4A9C01FFEAF4555B72
      286FDF0BD14E23FFDD40DABF015DD796312EEE1F70F5C94FBF2C35BAB4349A6C
      A4585DA83613B388A185970C9F8D9370FF662B59CAD82F3C6B18FFC2EFAF8EDE
      C5A5D79C2BB72DAC5FF4BBF5E9BCE58C60AA6D733DAA990DB68421E1491E5878
      7308AEA72A288DB90F79FE6F0DD4D90B4C2920541E54B168EE53D6665C6A3DB7
      1CC6C82E1A401B53B38C8B8DBB2E58324B9D82A2BD11DD44C844096C19F3929A
      6EE434491E443A2E224468BE08D1F1FB71B8E4228CFCB446EABCED406AE4D664
      028423EFF72C2B7E8D18888C78064C800A17CC43604ACF12139022E9788BAC2C
      38BDD437C2DBBDC83679A29579A2E123CF1381B5FB2DCE997FE7956F379DD93B
      E0922B18E41ED3C4AE1F571EFDF9073B24D61DCB636ADE880E6243990CF8FD97
      C54C3DFF37AB21E9BB62ACF4FD0F2B38881A35E03D091AEF27D7F14BC4A66BC4
      8C678558EE9978C86F95603666D5FDE7B365BEF07014CA01C0A0D9066E73499C
      353CFDFF29C69660E0AEBDEC1816D887F90B2C73670B951BDBCE0BC3EA211BA0
      F8A33D6DB7E50C3747319748A5A6BD20CBC922298E6741063541DCFAA1537EF1
      5DDF2F5FE7ABBB648771A6D3FC4B7384D54151BB5FCA2E3A57945712D188EB66
      C5BBBAC9B0D2656863F1AFF996B1BEE6FABECA2D6A28B8CCEEB896B3E5DF0AC1
      6F4BD9DBCC70B59A14D9BBA5E2A130666E1CBF9AA0FBEA930B8AF86FE16A4B3E
      53CAA5B0BC1FF7BA7ED0E01FB8B97D307AAE5BDEB8687E577F6C8ECA750D4819
      1AC0101347C18B13295747D99D93727350567DF58AA0B6CA16621B0B0DAB710B
      5B6820EDE33CB4657E305BF72B68A4459DB42581E325FFB052896568D114EB52
      0921B55729F7BE9D1689FD92BB595E26BF991B007298A8D20A98155D546CABA2
      173081FDCAE03B9BAD577BEBD5E04E470083CECA2C59A49EA0F98069C890451B
      CC770B696CD88F5A3FED6B3DFF9976F6FC0661209BE27D81E43AC013375C2277
      92FB15DA6D7547805B4B1214696F179204585F5A82CFDE06D8471EBFE8A435D1
      3B69D5528C0628EDB4CCC96E4A0994B377707464FB0694F3E3C9D1BE53C79344
      93F4C9C1EB93F2A3B8D1B6A571D660F750E9CD522091366CC1FF8EF0DE9DC5C5
      5AAD7E2772AA5170942D21E917705CBE6D5F1263CF48D5587DD9AAA757B8E965
      0BD4E76F446118A2BDA87AA88077D80228DB5387D678E0AF156F637B53D6438D
      194847959EEB5C3052B70AA51E22A229F8F4D9365E5FDD1AC0462FDEEF5E96DC
      3422C18DB2AA44B56DDB7D6B765B4C25DB0C9DE8F98DB385E342A0BA8B5244A1
      18B24829500269C290E37BDF6F338A38545C8911BE44262A07BBF6BF66C0A4A1
      4BB87518FF9D543E938766D539DA9CBD9F15538D53AE2A4967AB0029B206F7ED
      7E22835E8D8492BD644509B0A95D3019235C24347AB607F16D71F017F4CA7CDB
      3C290E148E54FC5D7A08ECA55B7F2D8E15FB2B5B94A72C7B89EDDBA8DC5580FF
      194A9FDC0B6E18F63C660E3EAF23D5F5524CECF0E6A90EC24F0FA07399176D8F
      E1ED1C684EA68530906946F194508E0B91D093D845823104146FC35B2DDE8462
      D8FD34B7D11F79B56D6BCE0A1E89B5B11EE60471C9331E2A14D7F4D6373A1746
      AB65EE107396CB94B4B9918391CF4BA349BC3BFA737D92871F550A43E7A56476
      17EB6D7D2F2F189DDEBE3B730C87858A6F4A7673C14D670B6E6670A4CB84B099
      54F9294CCDCA07C7F3C6EA58AF8B8CD5EFDD729B9C2D019FA51FAFD310F5B8DB
      1B2FEAAEF4EE4AA95532CA2FF522582E3946F6BF5FEC857F65AD91DAFBEEADE5
      E75B1F5EE58D5470F415F85376185AEAA90D4F5BB572BA202C59DA73C6197828
      62D64AE15D29B093B31E82EB64BBDAEFBECFD2A30D3D1DAD9373A60F422F5A98
      CEE4B433BCCFDC59E5B18C838A1E34AC0B38C8EC9BE4029E500786CFDE9C097B
      CE43CBCAE65D24A127B496FFA9334B3CDFE283A2F536297EF15091998048D9F4
      7897EFCE4A6CA50CAAE8686B84615CD1ADCAF42C0B9C7B03CDC7EEBEC6B6853F
      C3BCD539BDEF9DDAF2950C81DE0323E8629E30A6F36DB3B4CD64E04B41106CCB
      072943E9C5E232A3E5B8C6124969DB506845E6551221880BF3C25D36A54B66D4
      6616CB0F801EE18A7DC2B535DFB283E9856E6D19410537ACE4E5A3326BEDD9AB
      EE4EA695BC80C2FC60DCA83DE34689F7BFEC84D12DF7BEC74B8BBBA69C79B438
      0FE3AAF08B2EF9D922AA92BE6D0EEBFB8F1B6EDB359E03D8AEA1470E4E8F3627
      F2B2015C1C6D39B3F0DC766578339389BEBE96926DF87F73FED7EBD7AF85F590
      CE86D95C12B9A5D73413E4A880BCAAD2F2FF3F7FE58FED14ECB201B96CCBBC5C
      7982BD40766E7CD7CF7A2007E72DA37B63537FD36D7A425E3813C417FB94CE88
      8DE5BCB2B11971737031D8B3AA58BC19DD9529B4C8E12EC27095FCDD67834D62
      69DDA72E1FD9B65AFB1AD57D570B97B15F0966F2DBC2EA2315859A423EEE9988
      BD08D938199A49818F8AD6D100582415AB48CC4359D11BD8A55A840E3AD62919
      42BF682EF4A6E9630B0FCBEFDDDBDDE3A228AF29EAE037D6DA5424765FB5CDF3
      D7E1A7F7B02B6903C79EFED2E5646B67ECC597AE2FAA33E6B7C9371E3594E4B7
      18B8F4FF602BFCCF99E86F36E2AA063240B9CEB92828943556320912D1AF9373
      0F1C2EE6C139363BE643D730FE30C7F3ECE0F4380C3638D8B5CAD02235975CC2
      5B6EFE298ACFD48610A812DA34A2A9F6C4F14236C0D33F3DFFD9C96E666E1299
      328F658C7B4FC42CCE5A7D7279333908D7A464E0CD69714B94C8608F49760DAC
      1A495A92A8179564EC30CEE751A80D11BBC0DFD0EB95186FEC1ECED44D1D941D
      8931A2E82249CF13442997F189F06A68732B90E98D7187F7F01236E55CE55D32
      F55EBAE36C49AEC894B69930A0797987E3427068B9B3354E72CB6B5B2985D39F
      1497F7C81FEC272D8B0977CA86790947421EAD60FEC80D0B4AE97AA54AB604DA
      E6EEA54298A916AC8D8A4510D6C22B2209C5791991F775DB9623CA32B1D3CD61
      AE3B13CCB581B4A198FB24894BC529F73B3082A84E3FE20364851FD8A5C197AA
      BC7217049CE132681567053E030A7D4D5AD1BF33D796CBFB3660F543FA3931B8
      6A3293B7931D631D495A91C92AE398A56C14928A1F5E85FE825C22BB23984177
      E911E6E2EAC78B495871831D590BE556A4FB79E52E5572CFAD4AC5BC592E86CA
      C6C05C0B2A95E2B2A83BCF28E686EF2568D39ABB91B82F73E91E75BA14D647BE
      8D2C6A4FDBD327870CEE13DA6ED4621798FA54DA086DD34B0A45C87AC3D595B9
      2AD499B417F8C9C2AD6E265B55AEB310CB1E15BF5C40CBC5BA1DC96957D182B9
      D24B12F6D94A6441938B469DB5815C54514A5BE646D0C7ABCF77EE022EC49266
      0F6B489BD33F063F08232BAA75CDE941D34AA3D9B00FD5E242CB4D30D39188C5
      6B28DCEF68D6369569B770839765D52A4E001BF42905677BF10B94525CF39DFE
      F4304C2EB4470AFA1D43F91863C768A97FE7C36609361B7F9186CA6AE9E7D2E4
      E20FC71C7276FEEC7437DBA3068285CCE9FA1C425AD8F47C8297755999D1909B
      DD54DD4D85795F205471ECF2F646BAB6E7799975AD54BC6585703F53FD66FA00
      679C23A2FD51358404F97109425302BBB05318324BE577DFC914B9D9146B626D
      21ADE8C8AB31FE720478051EC19D87E0CF9BF3AB7E2F74403E0CBB3DA6B08EED
      94A2B06E03815F486C7FA57C40E7188A2D9D6AF6333CF68F52AC69133742A240
      09D0A234F0D3D5867B925399A8253CD70E0A508A4D6D1CF75696E3373F150FFC
      99B337F62305E4529C983E2BF3973ABE49E179D283CF0D5E4CB743FB8A9C0253
      0C215D66787BEBBDD1AA39278B3FAB0ECBEA10C340E32969D42DEE6F997310EF
      7F70BB1A43BE0BE7B8C92873DB5922941AB76763A66E2AD5E93410D3246CCE76
      2492B31B72476728F96CAE9A58199375CBA8EC83D5C4BDA159BC3C6A736F8765
      BF9CB25AEF22823990CF15126019ADDD68A672ABD440BDFAEA0DE2F72E9DAFD0
      204FDAAD582765FD666128194BFEB40029B7558AB4C83870CFD5E8D02F526662
      F2D570DB8D9B5E56DE83AD936BB7B29DFC53CEF14A0E286497E13CB34F7BC38D
      7CE5F338F6B5E483E089528943FE78E8171FDAD493D44827D3441F85F1A5F3C2
      79FD6E80A63EFCB4D10F258076452CB25A6B2068C31C783D383DB03E79187BD1
      C27FC009CE441ABC716C7163C6CB9C9D0EDA36F45252F669DEAE4AC06D8A3DB9
      969AE9B7CD2FCEE917ED5BB5D665EB88A90A0DEFC46D79D72226592C95CF530D
      B5DEABFCA2C58080C68F811B65FE68DB4661ECD46F91815D685FC36FC3665315
      8B71854706DEDE443A9864D4F772CD57FA930AEF100E12A93B19A4B2B1EF0759
      5FEB0FE6A2E2077031053C8110D01479535E47986AB4CF48C98F6B2DD7DC9AAD
      1861D943C554C4F50B7ABED1D98677A68D7EF92DB07DCAD3ED369C3D921633C9
      AAFC8F3AF24BF6D2E5CD7177EBD32A3B29361EC883ED1E673A6BD9E3AFC82346
      953AFDE6082A2BDD1CC3EB8FE1F556285755D8BC6B354528D188322F1C849F36
      9CD7551517A117C13165B3E88C5829B18AEF3B531226AB24BA4B81172D37B66F
      9C74F1F983AA280F6329CDF694E1C705D3BC69EC321D29747B321B2A35AC8B18
      2F721E73DDDFE1D931E77D39F16641DF2A7F07B6C3DAB7587817B04D1E6092EC
      4A6D4FE8D1798FF70DB359A9422BDDEC26258DF0AAE1D221A19B45B494325B25
      DD7641FBC9DDBA9667F94ED2E1DAF66E9984C8EDD4AA51E92B907BE84D69D6D0
      08C6A43C25388F69112E5ED524726BAC31F726C7DC694B19649B64539DE1460C
      4D22BEC9D583008C3F2BF1C20C1059B748960BDA1C57BAB542AC46120CD68CCB
      33E787E3DD7DE77D8A0050CE652481C8AE759AA70B2F6F2112D7DA652872FA93
      FD2557BC48D1F14C634355FDBB73FCFA33F7A921C9F2516D10456174A91BE629
      1A8665070B9AB1968A6ED6F3A834794013F1616ECDF2253317488790C9B673EA
      A5E1DCA8868A80AA01FB0F87CE964BE61710E4B83C006C50A93A7F163F03605A
      FDF6EFDB0D4F87719014993C9A45DF0417B110C5D0E366AF0BA60EFC0666CA0D
      FDEFF96CF69CA4F521D3E94BE713BDB2AF3FBD746E96DFE5E993DFAEDDD71B2E
      DF8228E06D12DF5F4EFB3B92226C85A28F3A9B1A83F57AE403FBA8F0FA92F470
      9F01E523752E27A7E2960E52FADC52B8B1942A76C9D9C1E9F0C5E9E9818D2DBC
      78FD6E3C720EF60FCFAC52AA7470C27E29610EDBB66FB720EB9CA761929A8E4D
      6FFECE34BC3EC08F2E8AD6A4F0D2F6BE8B61C64FC7111DB3179F92B3620396AE
      BE650D29F3E11DE7158042F23AD6CE520C458AF88AE5246151F0F9890DC6E860
      A99CC626FBC4A51069290CC923330D6FABE8FDB5595D7B55FDEEA1DD32A643AE
      C139A2FB79AA159D5AF6251111BD069D9A9D295A22E55CB13C8A308E15E56D41
      72AA88FB79CAA70921BB84247E8524E5C64C9628419938E14C1450CD3180A5EA
      524E61D19EDD28BC7A55235207EB99BE7CF2DC5FB0C8D1F146AB72A3E90A6125
      366C565AFD92AE903A897BE418DE35B8C2FBDE37FC92673FEDC36F11162A6BDC
      C538AD000D6DE1A4908A15947C6F5723ACE58E5E022E2ADB30C3A846D2EDF36B
      79A311D61F11E29A002E01E8975B98AC93777070684A01812919843290BE05A8
      CBB6B3BBF7DD899458B49DA3DDB774D9FB3727E6E2B7BB3F1CE3E37CC7AB5015
      CE50C258F15BDB95B836934AC391DADE289E8A8925126B5B0CD1156EE8F27441
      90B4D906C5B455F22F40FC59DF8917F15D91A37940E0C1A475AD3D5540BB08BF
      32439B486F2193B203BA206127FDCFCEA7B67353DFC6BBDDFB9C17B8CF995634
      0BE2FD56307A443A805109A52A7C09DF48EC19C9A7882E47858FC51CDBE645CC
      491629FC59BEAB0936051CBB9678B8F0E7C69AED3CD827EB3557FD4C511989E0
      B4F7ED75B072F3592C07BB0997A312F5C15C49AAB8BF0439E811CE16571292B6
      3090D95C3C14DD587BD6F42519CB8C665FA070DB652EF19EF95AEA14BA8D4855
      991B88A21A44541C685D7F48E135EAC75E8578D8046D3EA7FB0477A35CD7DC84
      4FFE0C3FAFCDE83A1C5BA3DD45F316DA549E8901F22AA471A4BA084CE2730FAB
      E05A86BD414C13ABA4CC0E4A2D2987AAAAABA090FC578F8CF009F02D4223334D
      7ED406E5A7465804ADB4B679498571A1FA6895169B61BDBCA55FCCEEDCCDF15E
      FABAA25F3EAB5862AD457F2FA4AF9951482AF36190CB0BAD22A10BBF5D3D7239
      9855FC816F5B255E46782B1550518BCA5D827618BA47502CC6DCAFC5E79A5CC5
      921555253A88558EE4C7AA4ADD5D9C8BEB544B28CBD18662601C7128356C2933
      3F942AD559625C87F24F56B74ADAABF269310BF8C42AEAF72DBC202220222B2E
      392BC58843890BB8AF4D8D0CB35BC9BCF8EDB271D05A0CA588F842DB69C662C1
      07602CE02F608C4C059CD5AB25A3F5B40579D1A65918331B7DB7DE8EB5794399
      54E30FAD68D880958DBA73DBF79871126A8194BB893B6EB45CD5685F25C242FD
      6CB1718DFC2A19B4519801B27139836B541F099AB636F7A2208C7B57E8628599
      D08C8D964A35BA6CE6998A0586B8DAAB8BB698A28F97550E33A22EF5B7D481C5
      2C302851A365302B55262E415A58B182D758BE260C60D8D03514A3186C52E15A
      46A2CA871A2AA6A51231DB5DDB2E343ED7E6D21DD02CAE70CD8EB3F54AA09670
      895A62AAA820169472120B550E1E03D2B40CDC794D6FB198D7EFAB171634A9AD
      5BCEBED3BA083D6DECD773CD156C454DA25AB95DEB6098D387C5852BCFD1EA29
      CCE383246692F6817F8163D0747DDF3D9696CA0BEDE1710B25A27D5FF757F520
      3653620BA8B99CD0DE9ADC4CB4F0E1FCC79A92234CD007C0025C2940B49FB8AF
      F5AC4E66BD46DD6A01DEBE395AEA20F1C13E69D9A9B8901EBA5525B11BD49595
      BDCD5680D590614D49DA5EFF0BA609D0B14591B5B7982BF081694FC1FC252508
      362D848FB3E2426EBABA4091B0391C44FB550037B89B6109ACC0F214D5011D96
      642919CE12FA28BD76AE92D9ECAFB5023C7AB7FF8626D618E39BAD53540CA994
      F9A04430ABCA168DE4509ECBD02FF125EA0A7596C47FDA2CBB75E23DBDE02287
      44AC8F79121A3711C55833E4B3B85C8B2CBF24DDB80485D48EA575362B2D9F22
      6760343292090163EAA4E9620E13E696904D61E856616D2202FC56BDAD585DEB
      F1C9CB4A769C1E61BCE00DE183EE4F2A16AA4DC395376336B7EBFA657B9F196F
      51988A25E2241E8A326D83F8F22242598CF9B164B8794088D8623D5FC678EE8A
      357B77C5DA3127B4924240CABE82059EF94A6A3B18874008840355C781C98B52
      5D3A67CD23F04A220A6B019B03957C417161C2F39841AF5401095B54CCA2DE47
      AA64C821CC2F188A84AC765CE3A6C9A5D8EAB1F16B769CFF4C16724E5F7216C5
      857BC83525D79B13767D2E244919938931668EB99AD77951120E9ADF60D39E7C
      88B186844D71370AB982CEF98F0FA7679BDCEE524AED563579A59BAEC666B21D
      5F25EA1A175263E72CDC6AE28F958A9D8DA3D333E7AF95AE1C999EAB0C7FDA3B
      A53F016BD0F4CE56FF7684BF1D25A6C082FFB27D4F523A23079D8C6D8B0AC736
      71F18E42689E55B2D2D5F52435D4CB2BCA7EE216BF580D11AF4F76577C05B368
      37ECB9B53DDADDF99CB4B394BF335686A576A934CC6CF67BA5359811491833EB
      765B8649B22037CEE2B4742B89B045276EF2C9645882CA4DD89A88C2197D8BE4
      715836CA98BBD8CFB216886D737D1506DEDC8E77141DA1460F59507860CA3F2C
      57BEF6AAA5DC4E119F92F76DDBA489ADC830C3B803DCD9BE8754486597057EE8
      AD1629185CEAAAE0D375B64EAD79E18799478B93FE643F523652D537F18AC060
      C96FE44549661A901F3CA81AFAFF61E3AE8E58D88392FC56A19D79B1EAE86558
      18888D9433BA03A34AB56D1DA460A99A4F7367B9ADCC41250C96DCB38C9EA2BD
      45FE806A177EB23C09F52472F702290741CFA57C5A06F12139B730A449B61469
      FD29013FD81896B729A6F09CCD51B0DE0BE6D961EBBB81BAFFF7875D2799789A
      9C3A8D9A1741293F0C8EC30CBB6A4B691463BF740EAF5D7CF317DACD72097E82
      067E894C175D497F394DD25CFE98BD745E254904FFE7AFCE59BAD0DB7FF9EA78
      EE4F9FB0ED67A88D6263A9919BE89A379B17BDF35B6602A51F03AFCBDF2C52F8
      B5412593632153C92A03874A0D50437A34B3AB9932AD6F80AABF627AB315D35A
      4CDCD929CF67F66DA68CDE51AA172C058BA57D43DFA979474EA4F2007690D9B4
      93C228DD12DDE6F20E618B773CE19C732AAB7389F0BED0A05FBBC2AC9C98579A
      8C0E6106D852061595E7C67CFFE5A7A24ED0FFF760BD7880500E62FFC37CEDF5
      BF4666BF63F1DE2D407D582BB0AA4CF618F962DB062064578EBB705D50DC7083
      F005373E69634CE35E178B738D84EB5C4B1891CB9B70F90BB16DB86E98310148
      C5A02FF941A8E6D5B78DC24B9843615683BFBD3CFDF24FD3EE88BE7627FD1EFD
      D31B0F26F44F7F341AD03F83E1A443FF0C07535C321A7471C9B8DFC32593DE60
      209FC62574C48EF9369DE9141775BBD30EAEEAF6E83AFCDB1F0FF8BAC16838FA
      7D8F5CEEF5FDBD57F9954A6F4FD37D973A95B66D5EDF7BE220E9F42F756FE142
      BDD47FDE8B17E42FD7BFFC955E7B51A9DDCAB16CD77E7D07DCE1F52FC600A449
      8056B779DE4DE182D2A62CDFA1FE4D83902B101FF216ACBF7EC3A075ECD7BEBA
      72EDC6A0AD9C2164DD3093DC01A2F97B17DABB3C4ABCCBAF6FD8D43F4BB9EBED
      77384DEF4AE2431C7D1359A08476F994F4C38CAB090CEB9F87B7C3B9264161AE
      F2B2BD16352C6E6EC628AADDCA4A34C3096DE24B19A3D0644974C58F46760BE5
      5BD72137170BBE89A543B4B57A60262DD1E2E695A2D56FD19CF0639246FEE95C
      79BAED3C43B9D54FEF7F7ED6166FEB5B988BDF02BE62B51CBAEDE1C324F1855B
      4D6F2D6F9C458ABB0A53CD3E65A5F87CFBDEDEB36B0C6BEDB3328CDB344FA16C
      9385C1BFFC666BD3D8DF68A1FD0169F06FA56C69FCDF64E06F155009BECDD04D
      CCC38025D012BA14D8C5489D67A0BA01370F73BD4B34963B2F960A72D1F26578
      A73681C575D27EB538DFE0D3ADC1A74BB581957317E7D5FA2EAE26B4E46A0084
      0D992711551E91CE19E79571E5567D8CBE5DFB261C30B785C79C44B50F41E5B4
      81972D6AC0FFEB23FE843C13CFE1C7794426829948E7B6146FC9AFB6FEE077A3
      175D7E631E48D0773E3E73C71F73E5FE73C5320AC2E7FD11E67ADC7BC07AA2B1
      FDDDE371D1B620C79B3E5B6385451939F4AB96193EBFBCD0C6D3C1B4D3997CE9
      755643CBFDCB703C709E2397E35D72E30510C6129DC5CF72D17A02DF13E57F2E
      2BDA1FE154AF1D298D7344E33C115B16EA9A4B92304CD3C351622672AD1670DB
      CE4D992EC0DBE645B569D3C63DA671EFAB5CAD1CF51F6CAC531AAB608ED845CC
      4D8FF3B40E7F476E12308E26EDC94906F0280110715EE2FD91CEFB70F6FAF9C4
      413CD279EECD5F2EF2807EB4E092CD14DCA44F8283DC8A0CAF29BC53E9A594E4
      49E7A54902F3AA299AAC38F1DCC47143FD4DA0FE7CB2984C3218091B0928738F
      2C791111D30C7B39AA18B7323E83B72BAD03681CC89CFC3A292263BE14B81615
      8EDDC6CA6678673BA55A003E0D1EC42C89812B663BCA22345898F634E9DCF068
      DBA008250BF3C512FF51A38441A2C0E971A96FDC04264559B613C6AC3179CA31
      A06CE9F46CE6586BAC8D090E95421DB849043CD2B85C26C1028A01D4C1A6B3A6
      9992984CA01CECFC3260AF20DD841E92DE9C564D480CCFB2EA11D1FC15309956
      C78D57A7115E2469F80B627E9121AB03998387529ACCE6DCDC24CF93D92CC9A4
      52EDA699A39F7668F4307951A44FCA6D662A5D9C6A7183AFE59CE404245863EB
      14AAC6881720004AEBC6059E5043058433B3852AE128FC451B3292D612798594
      E53771784F9F6C15AE3697DE65D2DFF7BC288FB08514884E4AB3AE3DE5BC30F5
      163334F77ADC546871BE4D7B8B69EF30D1F03F9670A42CE705AB7B7CB34A5891
      B654DC57619A8303BB5586595B6599BC4D1B6C150D20468030C3F0319FDC99C7
      1871582BBF2D4111736FEA04207D44F170AA40BE472A3E5FA03FA9627B189EEB
      6B2580523BE2BE64863894D6DD8E9BA9173BAEEA3900E10AAF7453179D15DBB2
      4CC8119B94CE1AE2B391D149BE636521B83AE4FC2A1C58DE6505339F74B1BD4A
      195C165977B86F1305758F98524DA78DE5D464FE73EE9C22433EA97168011E02
      9D57B7819D1A25997B979089DF1B908E726F818A131A8EAE63D8089471EB4FCA
      133A262DE60D074CA4398653AD067E4370F8A555918E44F9CB1F4B6A31A35B23
      D9E655DA114AB4951715A4959BB9E127A8E8777308D8B6FD707D0B8F81005405
      DB5FC500735C1D31D809378537F260F89751A7C3F1C9B939379513930F65BC6F
      359F3B5786134232024D1CE3FDC643D12D620A17920ACA4E610330560A1051CC
      458B380F2353146C1B0818B9967312F4631365749F847E7AFD6EF0B3F3FAEDEE
      3176CF9BA377AFA0756A88FC3A4D9A2989FB57CBE78C475CBA029E53E0D76083
      F22AB2062677979B25B4620D32AEAE2CC33F9604B9E9465A33F76EA3AF6E71C6
      A7D221B3DD765A6F13F8BCBB51D42AF76391142709ADC71942936A85258223AE
      8D3D15EF11EB2E2FA48A5C19028C319B8BC65961672CC3A1DBCB0836A0DBDE02
      EA1C2C52A602DB46058C1BA9B891B1A4FB44C5851480602856120D9A5B731BE9
      A2DC6327EDD9E8F705C9C05BE4A69244C0BCF28B1AD6B790B1A2D0C436DC19BE
      640B6779633A00E367F91F487027B4679299B3FBC3F2F97E5D69536CE468EFD9
      0D67EFF64A0F6D59C1D2853F86F1B889A3BD5F51CA06A08DD17A4DD62D1F2B08
      A1CE80F6EEE7170C525462E1E74BB0033315AF7DB2E425C94B49B53248B77263
      0657C1831AA965EE17E8778767C70799B3656C97F7E4F2879FE8B7CC3604B027
      471AB69C03C9516EB31579F2E1BD132957474578CEF4DA2424EBD91F4C447BC9
      6C8E43F5D436A317FBCC20B65760912D90F09E2CCA1F8B45F9C712C92B903ED2
      AFBE033410FD9E867193397B6A6E539BEC3C7066EF056D9B64918A06160BC75B
      6439E96892D7AC9971C5FBC462B1D4C22C5B08BEACF3697F319BCBE0D3451CD7
      38B8B95A0E09C340CE7A5528B382334B42E34D94DCE7722460F4A251484CD5E3
      5C5780B5F4CEE4CAA0A20C1C16621AE8E027AF23BB2159CC24892C84097F2CB9
      2C575198B262865A472EC3992B5A6465055A1808466C1495E09502C595447E33
      978C31F46A88F08E111D85D2C50229BCFB1E806D79090B7A2C91DBD32272CBEB
      ABD0ED46D2AEBEB0A9276625518CFEC18DF9DFA0AE1F25695FBEA7B689ABE2DE
      08F3B5FB2E08480BA070914EE16C8FAEE2280DD92982DF9A72233047D7390A21
      217CE93172384F7FC37BEB0F2596452CE836423C07895CA98815A6A00CF2791D
      C6C57517A184C444BD66023C73BE480D7F70B77721B732877F1365758FA42A25
      7D756A3FA5746DEBAFB8DC0028C689046BC858A6B52540C005FFA5CFAC005728
      0DA43F0A4C70238DA0CF44B338A3DF66B807FE0671AC3D007E40ACC7CB797D69
      3FC45156A975D87A1FB1FF259B14E811C5266529DF240B81E5A9E0FADB7A01DE
      C6FD9DFECEE84F7FFA5323533A77E45A632E8AF82C8329BDD5D71C1A58E1A970
      18BB6230C86158F91C828926B9895B7075A60E724E6856B09F0AA8A5D67E02CB
      84EF2B94ED925F3128F72D9944808C95D9CE158FE5D357015D2A394FD54CFA43
      FE10B367A6E6F4F4A030E5684E6A959597F364F4EC6A82F7AE8DA673B09C3700
      C469AF1D0CFE4872DCFDC1C2DF963C063604D6C471DEAF47A54EDEF1ACE64C02
      675F5DA39A27F57774363325B2993390BA8C02D213611B71B5FFB1407B0EDFA1
      89B25921991AF264E15D2451C1D762CA31B926F5529B3E1D2937AB40AC62DB78
      791AD9EACDDBC50638B0CACABC25C8EEA60B553C708BA5279CC534CE701E09CB
      7601AC6C91FEC42BE5B2BCCCF9E7D3275FDB1362DC3D26EE45E5065EF15B34FA
      4AB91CB98870C7CD726153A6C1DE766571D42A352CD74FC966C675DC262E7F7B
      17854BEE35EDA7F017C03F345156F73A5B7BA4459C3F4BFC019B8C93B4DF090D
      C95265AA9CED2C041B3FE61CC3123F8949643168326B34C35987BBCB266E6EA5
      C17DBAE84381FE3CAB6329C1AD27A5AE1965CE207DAD82B9358BB10A4C7C2BEC
      C39CE4C20876CDCDF84B00B44D14F167EC0BA8F8E7A674B1A0D62DAAEC563051
      55380CCB8F31603E4A1BCDA22D7C84527AF6CE859817F3B5EFED5B12C9AB65BA
      A33F88F00D2625566215C1B6BD525B9A02C50206A714BEAA40A79BBA370630FE
      6309AB304D962AD5CBE52486F032DE30236B04DC62D84461DC278A1A52AC563E
      B48BED588D9598956298B1A4BD9B6BDCF2820010E80F46944D14DFBF8CBA5D54
      0B097C39435860E3B0E54FBED35CB24C2542B490203674A43DD3836D8F34EE32
      CB91873E38050DFD9C01B6A4DB0AF39F70AD6B1A72415013C77C6F3970AAB20B
      69C2569E67D2344892D5D835A90990995019F782C83E694BE280ED3CBA9996F2
      F4B942885CC0455DCDAEA4813047F84C310F50410D647AFC6DE4028AAA788EB2
      ED5D2547666E3004948CA8895374BF326FFDB4AFF5FCE7A28074EB9DA920FD6F
      C401056863BBB5B6490E85A651925C4AE6D8467F395F6ED95C5D6DC46E4CE61C
      C838B99C1D155E52C6B683EDDE5C909251179D95EF4DFD8D896524BE9E63F5E5
      A98AA3EAD8BE36A054E7CB004A0D264B72A6C15848A9C14420A52E758A48597F
      F405FC7B139B8E85CC59021EFD9DDE4EEFDF1FE10AF9F68845E3478F58F4C118
      D1B61F06C8E6898F003AD7E87C3A3DB047E4CE239CE1B50394E1D97364EF6C7F
      B7E8AB6E6498D28CC74BE8B895CE3A8C8651BB81A7F7AEDF765EBFFD413CD2CA
      DC3571A886619374CB4EA789EFFF693470AA307C8D7A79A10D2653834DBC2B95
      86C2ABCB4E14466698519B38B69277A5C183805568A1A5BEC0FBF71E9883E8AD
      7AAD9E93AC3D77BB83C1AF3F78F9C3754FDE30BABA07B4936FF3380EE05DDFAF
      F0CDE7755A586699344279166FFF4B1CCC5F74FED78EE135524307A7EF0BEF5B
      E0AFC839BF88438F1D4E8355CCF52CE4AF3F46E363635EAE9B6769B37D83365B
      04960EDFBE7EE7BC416DD7239CCDF5A1771DD06E43F34C680BFA3DD30E936A89
      493B7B7B0CEFD4C4E1E1D591E649524417E464DC9C2CCD3D599E3E41A521A6D5
      2A5949438B09C7F599FB477B6DE71D77D022245AF9CBC1E9F1235CC31B85BB56
      E19E1D9C0E5FB0D6154FB18641E13BEF0F4EBE7F84D35DE778E9BF2077F767E7
      EDEE0FC746673571200771062E146589180448019DCE88E26685BFD2E8D08540
      A4938A4911B6BE569C8ED3E7526786E845E2E3F4099B1AAF78FA64DFF0C5F837
      B19A851E59E8D26511843AF2337BA64AD7B5E54B53CE4CA7407198ABDCBBD871
      7E44901A959BF973E016C00D579134DA2EDD2C0C9C5F749A705B2F276280A59C
      013233117B3A92103EF3B0015EBE28E933617FF35849ADEC80750DF99828130C
      01240B50E011A2901497728B6242C6B8F199B9FEDCBC13BD4D4E4E4C0D5D13AC
      BDC294219A27823A3189F563B4FED78EE4D5E92E3DDEB9EAEC0C9BF8FA08307C
      0366A8E7197DE49BD42DCE0BDA555E8273256D7216EA4FBA292EB5E38631C070
      429F76139C5553F0689B9DB9218EEB1D91AA940FEF0862FC85CA2EB4E9E45491
      B78838F22E35C9C7FB4349D19EBD4EC05411856E5A2501DD24A77E7D72AABB49
      4EAD3266278FDC987DFAE4A7D3D303B166F7F8BC448B47B4709D6C314712DDD9
      82DB62DC9BED368C0840A557DC589815D6FDA125F1D57B53FF75C7F3BC6F41F5
      059DF408177D1D0766F88266FD67A7F546C7283EE0EEE277EEDFB597672D9B14
      12CEEC460EB0F059CC5076F3087861F3C6DAF5064BEFDDC00CA8A9C01EA79737
      6938737E38E1E4E96B80792CF2017E36EAE62519CBB16977879FFDC3094E981D
      FDA98E97ED707A76507EA68DDF98E228294D794E66F5F02AC5EF9F07C980BE2B
      4C92462E8CA74F022E34A4E3FD25FC95C9739F9C3BF2402EF427E56B2F9C91F1
      6420760C3157C8C8FF57A12FDD90AD5708B01A9621082E49C1C36998325BE20B
      B5A5F4DADC885B8A5D5DE9A964E29026CA8F2BD197B8318A744918FBA8468DE1
      A1CDC2885E9EBCA4ACC68CB44D1490FB24C8CD8A1756F548D535ACDCF291491C
      35B289FDE993D68906652019370B2F5FA4BA7577DCA6A05F7ECFB5E573156B4B
      8C390BA54EB274B755DC545958AC269B685C2D8C13DB38EA3BAF6EB8CEFE5A5A
      1AAEE8188E8A6E85225B696A6AD8DF012A71138583426767EBECA04E347DF8DF
      64976C1FABF931589CD26C27FF94F316DCC261C07FFC8F85CEF2332034F31F69
      D1001605B5B05C5ECE543E823CC3113E5B9228C84FD8C100598B165C490B2F46
      AE6AA260C319F478115F92E459D8581BE7CA6058B98B73A9E9E18987E69C9952
      E5460E2BAE1491F06152449A77DF1F72C4A3242DFC7B96C46D270E83AC0DB656
      3AD6550DB327A2ABA3C49718C92696F19B63199B48C6AA48C6F49147327E628F
      D63818A7A0BCA203F5C054701AEFE2E9934738B57547767AD070E7CF38B1E2F4
      398372529A3794CF1CBDC21B018C06F18F1A0A0EF2C73F8D3727E56F3D29BB3B
      FDCD59B9E2ACECAD9EE3CD59B939631E30142169B669186459D04E97452AE702
      08DB8F2E61CD82D4D94B663368EA88EB286D6CB39993D93A351CEFB5234B4D1C
      E57A377E7344FD86236AE3CEAD3CA256D7D63E9E23EAE9933FBE8DCD95A44592
      B2AAE9CFA3E49AA94835AA591A39B62207FB9A6B120B3E0C9936C1A5D78AC3B0
      2480068FF4E913338FF86AE6525D25A19F39E7925E67E08554930F8591627EFD
      C59C8E3224DE4D4A0D8497929FCBDAEC73910E33F699A93C046901A285CC2BC7
      905C0C532F24DE259E2A22DF9B63E3B71F1B9B7AA695C746EF911F1BA5DAD965
      FC8DF7AF0E761B8C52F7074BF1FC70BCBB8F6812EB403D9BE737EB6794DE45DD
      3472B49FCC618001DBA3EED5E96EA389ADED9868619A7569D06C8169A10181A4
      009123F03911996999A7E61AE75E13474B8AC41EE828577AD7979F36E7EB6F3F
      5F3B9BF375D5F9DA7FE4E76B3607C255E3D300D227053AF9F40660D2970D1E45
      66E8B74903A3F99B8BB0F70F778F9A3BA2204A546ECB7752001D37D4C157FE95
      E262AFE3C4E79EFCCC09B442AD5C1347E3A7EAFC7FFBE46FF269D832F035DC50
      731B6FB7B514CD086902AF421F94028CF8D9C4C183E6CDB415319A29C7E04B8E
      B8260EA9CC8536BEEFB51C8A8393D4D47C239B550BC5DBB7D5E1728F97AD5C67
      F9CE5C611D9B504B11B242753AE33AA22471F0DF5C974896E17F93ADB82DA847
      A65ABD714214E34C6559E285DC7ECA1DA78188E61BB429FEEB0E8AF56916BE7A
      A762FB9B0D77F03F68B841D2FF16A3E5D3EBDB0C38BEFA260326F5A3E3ACA9BA
      9D5B0DC98072DEA5E72A0E7FD1A9B3D56D731CBCB78DF87720CCDC3979AD8612
      591AE95725C269E249065FB741F1F92C316FF9F2FF986F7088FCDB975E084D9C
      DC4038BEBF45133C335401711E0C9351E8E5DF60671AEB825685C10C6FE21CC6
      DF08C5E0DDCB6F0B61C06D5C428E9D2CF2F92237EC4BECF3C03834B1439B0504
      BDE46CE15D98452FCDD4A49CD50C6C575FBD6FBA4502DCD9F9F8F178ED95895F
      A85E9AC28FB3C4CF3E7EB4ADC3BEB31F02193DA7D1B6362AAD9A8212DF90BCDE
      8BD037119A5CD364B3D49497271669A699C3C410858213E1FE88F604D2D84C21
      75767270604AD368591419ED82145CC7E738962DA88E251B68A41C6E27FFDB18
      E99D7AB5E7FF6650E0E89BA2EBBEA1691133E41FF57A768B7912BFD84D6749FA
      6277365BC4A6C2748E745876A135AAB09B2881A2E6E3D5BBFDB317F4A5C75E45
      C988C499CE02EF5D90150C45F3359BA4BEB398B3FEB7D60798519268D158CC05
      91C7A14D58EFBF7BF57F9D0B124AD450ABC60CE864056191AF41C552F2DF555B
      733749C15F9D14ECECF437C59A2BB38283479E157CFA24CCB2857646D3971C7F
      9D91B5EB098A9DB17B6E21EB71AB76809C8121EE43119BA366B80A9717407A00
      00B618DC8D34934430DD0149C694FA85642C7DE23674C31D24B44046C3BC0390
      339D0BB3268F76D47B59E1C84E935CBC1F159F473801D359C93EB5553A4A7510
      5E907BE125558226C01DD96EA2B02E92FC52DF6455D0911216C4C08F6C7D03C7
      FA003BF5EBC7429EB32914A6B3362A61E7EA9B0469FFFC0D62403CE7C0FAFC3D
      E2F0CFBFD980E224D63547F480F15494C4BD81F6AF3FE430265D9437520B3D7D
      02C27AE7F4220C7283699BE54A4A4AC432439CEB329C337563C22C824639D175
      E4C46EC18B213F3E25F5952F3C0365211F254B955E9AB9A1D0A325C8BD3ABBCC
      5144404EE01F4562ECE84332EFBEFFAC3A6708E658A8ED59A873631F018DD817
      2A64736C0A5E3310801BCC2FA53F016A47DF3B3C2B28464F56572A8C6C5D4583
      C1FAE4D5990B35CCE84D6F3839754EC69D2969A2F9164792DB98E8B033E1E1CC
      D9424B877B53C712325E4323771068EAFFBC07ECEC10E288A31BE72D70AFF1FA
      4CA41E8573375120403DC83CFA31311D30C24B2F9BA9890347A949D9C566C0CA
      ED3E4764D4B846FE82ECE6404599E5420138B2809A9B7E37C91DA097AA917BC4
      E07149BD8D66EC2241316CD3C29E25CEB35D46CA5B7D192A739E3571D4772AAE
      6A2C18AFEC7834C0152F1179154611866BB4954F5BBCAD7EDC6E3B3F262979D9
      7320A1BD4A93EB0C29F3DD28FFF3EB7E23D5C5D327C5029823A44A4E33A88F93
      E472A6D24B73829ACAC397A25CBA3B3B439BA053C5A56D0752B07F3B4F1C5779
      974D9448A5ED22C0102D16FA8F2747FB00F84C6CE6294EAEDBCEB3247E060A69
      73643471C0B7B22C35960CE9CA2D5793584C14BE0D68F82268C0818A66860D8A
      DC83AD4554C8AF0050938C8E988E513223847C3A8BC032215DA5A415E69106D4
      AB39756E92455A00D3858161A368B4404EEE368A9BC16EFD78F6DD499B93126D
      26B2694B8666AEE637E922E3FDD376DEE8FC00ACEA4C2450D0BF92E48A36BCB7
      EAEA981B959DADFC42C597EBE160A168FE9EC4D7FEB8D98B4DDA2959685B566A
      66F56C638CC8F80A25EED10F476F9CADF3287155C47FA25FBCDD71CE2E34330E
      3E0369BDA349B6823FBCF73DD2C33938564CCDB8E975C6BD72FE908485A4EA96
      C112E963953EE7460914E21C5871FEEDE4CD3E8DDAB569A4C43939784DEB9449
      FCC445682EE112EA205020C0957AA9340BBC3FDAEFD1806B2C3B2B139AEAF7BB
      7BDF934AE34029AAAC9B290C544BBC7A7FB66F55128C13D323E126FE0DEA8A72
      29990072115DF9D6899BBAC679B0279A7EC1A52E7B074747BC9DD93C39974618
      25A91F4EA4068DE55210FD38786138E14CE10F8FB36A9ABD7B7D7A5639979C2D
      F6E59E9D865CFA654CD767367200032E08B63719E52F9051DEE038ACCC280F1F
      7946596773C3F964488A51054EAAC4D5419292D6C866CD2C1C3209D2FEE825A8
      6CB39CFC4F870EC634880CD700199AE7A9CE326E9AF324478A504F94C0DB9BDB
      486193C73E7EE9887F52130182DC7F6B22D1010922E01C4C45F07C32E7F0EC18
      0DBC1C5CA62375096628D64030F5E8CF71438B9040EF818E58D44FF2913141FB
      61CAA650F68F050ACADC94D690CEEF4AC6941B9C871C289050213E67915D1929
      3F23E76647EF383FFDAFF7617E9A27F39F9B28260EF9ECBBD11ED75B26F132E3
      89945AD09E52E788AF2A17D52811B69ABE8224A21B98A87562EEEC7C24863254
      B819664D9417FB1705D984E91F6776EDEB327464585D304E5F48371B1A1D00E6
      8A9C25D82FF620B941E5BD970367DFBB90A4667E6112526C7967B68E7F287E2D
      0C74E0A4161FE00496594312BC6FA67CEEE9036E3B1F0EB9F82A4DA25BF1E7DD
      2C83C699A998B654DAB63FBB36D6CCFBB1A1C16613EF9013EA6F7BFFDF89B3A5
      635BBEF60B92B7450EF3DFB70BE7BD86F6605F16FE7DE3A5F2FEF8F0B4C1A05A
      45F874C631BDC4CD126E5E00AE7E548663689D1FBFDB7FD5A6AFA7FB6DE7F59B
      37BBFCF5145FCF4E1B3C728940F8CED1DED9DB25AF14DD70DAAFD80A1F4EBF7F
      6F6CEE266FE6E24C33FD769C63A559BFD28E8A4285E4328FDD219B018A0EEABF
      C9E315A311D3B83E9364D2CA86C69A636D766B37510245C0FAD9BE38C1CF0C0D
      FA85E6969C8A55F3EC79AF3B180F26FDD160B2D3C1FF9EC10872355312B3A6A3
      8582E0956965921B21584DBEDBDFF68E7E2C95451345752B8DD442D4EAE347A1
      01755CC0EE642D5B897D3B7BB42271D4601154E9E16DB267B63E46111B4A27E6
      C768EAF007E57950710BAAC7026D02C66C6C2A748F19A528C5F76F4E4E2A2917
      FA922EE605F7A3CA2FCE5320F70A2D9FBA6A68DC6069C815C465ABE68FDF1CBC
      E6A50B7B5494DBDF8EDEED355F9F15836E7D881719FD6B2B23FE767AB0DF220D
      9E36351454B615CB00A58261795ADFBEDFFB7FED15F9EF0DC3FD9748256C202B
      57A612468F3C95F0F48981824EF5D58BB73469C79A799011BE3115238B9836CB
      8EF381EC1B15C0C623EB8F8D405E058930D69AB606242D151AD6D2B0B2B31ED3
      92582B91530D08621640AAFFB1085360614A2B1A4305F9DC9D4CBAD26FE4F064
      BA154D186A780A20A01A0BE5165610261DE448C14D815CF00C6E71281D7B9CDE
      C6C269A2903844B75B59D7A840267DA7A5A4544AAC1B39B2D6FF5DCCE64C1A94
      14869D1835CF32DB65394FE68B3903333472880731C2F12F4C589E5B6EC95695
      9E52D338D1C8711D25E7B2B5500171A5D3EB34A4578F512BD23F7ED5C821FDF4
      699F962328C97215A11F465B2AF81491E47992D6D04B70CEF28B34599C5FD091
      859AA1F7364D4C1BF842218EC53D4559AE66F31DE73077661CED70353AB38245
      84EB72640A1DDAD602C4C2066423655AA26FD0AF2E337B5A574040A5A13CBF91
      685EC9F9B8E3BC37610CFA6FEF7BEE35E18C29A7F21A298C55F5479F29849594
      2883459F1D4B5B3E12393706D6767BA708E47C0D67E1B7B8075F005B6AADA164
      B3622F1FE1CAF8F696FFF8915BFE6FABD4EB300A1BB9C1DFAE4ECF3A5B618CE6
      4AE9AA3C5F440AD6FB1C8742586369D31DB61B2B8E6A627AEBEC48B964C2FA70
      D4DBCED91E1AE48E683CAF924FCD1CE1D327A766D19ADA37E5011D926C000ED4
      59D808C9B27317F29F5FF34906135E5C56D2FBE4F868FAD91C8868AA6BA6344E
      4C9A36BB8973F5C9B9205D1341DFC0834F8BDE40E3B77CCD40D7233FBB40BB97
      6DCEAD55E7D6E4919F5B3FA834148EDFF017E025E4064400C90AA659D86966B6
      EDDD82C19D24B578CFB89A37AA4309C4777BC3367D19E1CB145F26CE16BE5CAB
      CC69A170903BF530F4D6F6464D15D23B0E336FA3A55669A9E923D7524F9FEC01
      B36196F86110A2379FC12C677395876E1885E47CB3B9E226F4655FD31843E76F
      07EC90FFEDA06FD16033A0C166C92205DE016A341BA90224E2FC4A65FA2DC653
      441FB2C459C4A8AFADD3AFEC1BAA43B6FA0CE81D58DE171E08834C92A299F279
      7593EB5D0CCE89747C4EEB815C97147118AEB0190D1C37CCB34D92F20B24297B
      D34D92728532EDAF9EE4C7A34C792269D343775C85A6407D9684331593409C7F
      3E7DF25F1F193BF36310F9F075FEEBE3BFE25B94B37DF59775BEFBCFF7072747
      876FBF775A17793ECF5EBE7851BCEB8EAFAF421503426C878E8317F4EF8B339D
      0DF1D2CF0F6988D9F3C1683CED8D27D351EB2E3CDCAA7767C0BBE5B71F4DC7C3
      F16470F7E52117D47CB0B0E8939D8EDFF1A65A8DA7C1D4559EEE7627DEA4D7E9
      28D5E90C5C35EDB89D5E47FED7977FF49AEBA703B96E34E974C603F31FFD3CA6
      CFF7E9AA5E20FF8D7CFA0FFF4ECDF7249C91A66BBAF228FCD7A39F47F4F9D190
      3E3F32D79AEB705F7C4F8B94BFE76BFBE69EBE7946F5EFF4F3D0DE0BEF42FF3E
      7D829FF8095373157D124BBCB89396ABF1FB3EFD9D3665A74FC3E9D335FD9EF9
      7E627E1EC9C8C7D3E164D20D067DB7EB8F83C144053D92D1D0F70693616F3C32
      7224990D952B03FDE73F69A269B9A659F4D0E5BA883E7A41EF8BD89ABF69ADD2
      103E66E4A5881AC377D020FA53E7A3E4146FC69DC9C7204972F3AD9744D9277C
      A3633FBED0A9E64FE323A83083EEE3BB89E6F2A28F5990C7EEDF6B0967C57EF8
      AC5C1EDB7150BB2C13AD9E610C345C651BA37DED25508F5B27A67D69F7E478B7
      EDBCFDE1F41095FAFBBD36F026DE3533D665C67D70456B08A61F62BB8C19E79C
      A3BF0699BBC37D29F942F14114FE822BA467A9C1E37D7D5F9922C38DD808BED0
      3A1524944D1CAFE980ED0C9C97346874A425C0F102E009D9FCE8796644C06CE6
      6CE19BF38B24CBB739535C24771B1A2491914F2634F07DA10AE1E02D5C400083
      3A73053A90245ACCC82F0C73406A92074463ABA1D6C12BCA1C1B500FA653D1D9
      F2175CB5A59C0B25D02AA926DB8A81F5DCC5F9360069E8FA10EC2388CE486846
      68C5144A2C1B29660BC4DEED4E49D21634EB8273DDCAF7B18948FA59E6FCEDE8
      E4A8E80035CC9680B095AA37C905434449A6E55A663EA503916CD394FBF0E3F0
      3CB6183DB668FCF0ECB89162B342EB90D0387F544157E4A658AF86E4F1B9CCF0
      DD92D20E7DD3859CED38BB5196B4D9C66FDDBE7D0B21108080889A6BA4F8DE55
      4A5A0C9519925558550CE044A7778E3651DE5B5241E96A3AB2E00D3772C0769B
      4D7AE52EDB537372250B5C7B53A41D0BA62937EA735F51A541DF0F112382AD49
      4B645F9B1C2F7F96491278CBA15825037B2330406BF89165D1DE26B8BCA9DFF8
      7C50A4FBC88322CB8970946CB1B95458841C5F06F79C0F41CE554626B1D302A5
      58CBB9D43774AC37D35842894359E751C06237762C4B27DC578DF33E72FDB4C9
      D1DFAB9B7A8F5E37ED21D795B293711D46115B37B668593BF0E73ED1B8B9668B
      5C3D583FA95C18E6402CBAD24C0699D0306E0C3C89AB2FC2B8992ACB58D0BD21
      2C688B9C6A9AA885F68E11ACD06102D0A7468EB170AE7A5DF6130C1591C11A4A
      02E7848C5A943308AB25430DB3B349E6DD49C18654502170302B5237920493BE
      2398C6E27CF19FD7B7EFC7E4A5BD65223A7E7449BAF4B7BDA313EB962D4F80C1
      BD68F814745E74BB88269482C5FEB39DCCC2CA5174714973537516A224B95CCC
      1D7FC13136EEE9F2CDA2651C2D203C3149C7224E751436F6F8B59EED9844F54A
      48584DC1DC07CBD90A1F7EDF74921402CA80B1DFD401D7C9B6934CE0BC89EBEA
      B40C12A704955BB460226B8035DD47ED76A1AD767FA8B6B43B55403D86BD22C5
      C10EAB9420EC38A7125AC6DA9891BEA0234A45B6DF8DF5898FAE482974886EEC
      3ED21CB8A6F33C6BF46EE940B1FCC03178C0321A99898686BB8E9F0E4E8F1911
      61C779A5BCCB738E1E968C8751380BEB842E2510C0A4E0F46F015E68C4C93D5D
      8D1464B1F83A633608249CAF9C7F2C7496DB63C99C9334A2540954A3514D41AA
      CE013A22CDFB7438BADA92A8D3B9F5F9B5D9E4AE262BB311C9EC80B3214B7DC8
      A6451728978252C75B1749A1585DCD18967E875C0ADA9C1F502A845419A2B5CE
      F5FAC4A88DD4C1CFD64180BACC2BDAD6C5FE46845CE2770206D57001C34A7D67
      4C75C85796A55D76994392FF0FFED5AE4187428394CD1E943D7C3BCEBE6C54E4
      ABDA763186DC220CA8C0F017ED973234D0B51206043645238568458850F90F49
      48F238BB996BC3444366301230F3B926DF6CC739168164BC5FEBE06B2E6DDE4D
      7CC0F93EC6EE66A96CA204ABA204FD471F25B0FE4A9FF6CB07CE60DF49308961
      813251A3E2DB565758CB834E3AF2421246397EC9DECA1E7A7B02F13C8BE8836B
      E1B9E890043F492EE9CD82858E5F056C6BCDAC8EB0AA87ED7646292BAC57536F
      2BB0AD06A04D9131751E930636AC7B64B13ECB0B61E41775CC33B9E38E4DA1FA
      89CE58D219876F2EF4F2A36D51B3399EF9279A04C9E12488FBD07C9866878D96
      DBB400AC556F4DE17DEF766151B5E0092DE666F9B784AAD04D3E91FEF22E9254
      E25C6E9283D10F941FA4BD1AA987D4551202F44F7C3440817B000E440993350D
      49FD260E030DF8DA5D9C234EF8559B7EFEB8F5ED934D7DFB2A4DF1D8F93C9E3E
      F91127758E9A2B43C867CEC31039905CC586F85593078A3E665210CC50671982
      C5482A29A871CED277F43715396FF5A7057B6DA7B95633F656B38BC43088902D
      B4CF47BFCA2E1DE5825D895FC31CD6A48616B34682FD163028EF0D1FDB96D44B
      DAD8DE76413005035252E7333A6B6DFC456C4508C2E208EC93079CC46E92C6CE
      FED15E13656224D202CE9B31129DC3FDD6AAE25213006DE228CF303A532554A0
      5BAD2C18E2115BC682260E75D7F41242394862AC42214EBF34D9B7FFE34C3A9D
      8B260E90F3889AB32F203A8C425AB15E12B16318FB96B3D5D6C6D249C1ED734D
      E6476F2DD39E15386DD2405A43EDC55E08CB4A3C3943FF7BB4FB765FA83D596C
      F4CD61B12FB684867E997F7E7BC779175758710DDA1F431F8AC1D136F4D3E12F
      7F0052FA434B61BA92E9037616F36E9B1A9D8DA9FA054CD5F1C6545D65AA3E7E
      BC5863447C30C5047EA8A28473A6F9CDDCD00209547C7767F208A778ED088F6A
      C840DA8BF40B5F9B4E23ED2CF26062BA9210124B559C45655F9669BC680B42CF
      0D2BDFD94CC06449B5A27AF3344F797790FC4C2127D0554D9E244F80E664E819
      9A285583AA4B278AD8242F8A9C487619CE33928BEF9331660815362AF64BA8D8
      D146C5AE52B18F1D98AF04F07CB77F06ED4196089BC1BEB395A7C9C245352487
      F6F7D5757CBEC08CAEBBE78ECE1AEEC6BF2EA81E4114B6BB77600ADCC983C7EF
      C3399355B14B6BD212871C2429215852E569E776618FF0D399A00BD97A4507E5
      8A5B4A575E596820F19606A3A3EE9AAA3EE633A441E19B4A693D03EB71C94D05
      4B8E1C86DBF6F0868BF9A1DA7AED55ABD4F970A3CE57A9F3C78E575768307232
      41A9C9655BE03E3F7CBF7F6A7945458D3DC2F9AD1B531490A7FD0330B99BBAB4
      DDA3BDEF9C2DF803AD7D2D504DAC4C90E4A223ACD5ECF3880FE7922A09B5040B
      9C064C1C6CC048E99A1E36B1A030D0D777422B84D3CB1E4408DD258CE2801C3A
      F94C8E203A345138E55AB0C70A0352703D7FEC8041AD1C3FD6051F24BC1DD495
      959908A1D9A387410234F9CA1C1F0B89DA7BF68CB72CBB26498555FB609BEB32
      507DE25CD7AABD90F4CCB5B409DB9CC585CA98387D294CD52C193242BB8D2DCC
      C28C8B82987AADE90C6BF7E2789CBE3F38729A4B2CF6F4C97BEE2D7DEE32645D
      1941CD6EC8509EF18E6FEDCEE7B4B4A561B52578145B5C015136702E9994E011
      07E5689E34F2946899A67F196A2347B04BEAFBE6170DD611190502FE69AAE39C
      26D2A44EB32F819FD4AB3B34F3CABD556FDC7392B5E6687730F8F5F6287FB8AE
      411A4657D1EAF671BECDE3B04B4F2F6FD270E6CC4D7A3C4ABE4406F48B4EE67A
      680D370AAF10623D59C4E84713FDF23E4D50DA90624880D0AB870C4883FFFAD8
      802F5FBCB8BEBEDE8951A1314BFC8C71D61233AA17F8CD8B417732EAD784027C
      4C4080E3DE6A20C02A08E0785CFEC7007EDA00F4E13306A8AF000A1C1828BE55
      407FF88F9E37F20C949F050B34107E4B8083F63E8181F4EB02089041FC00EED7
      7FC4207EEB3B551EB0A4E87D69C93F12CCBE6623F66D6220EB6DC46349AFA307
      52493D7E96384900FE3266A28585C18E12DC9AD63B24C05A70AFC5547C85B670
      9427BC48B5A2C7BB800C285C2A7AE5B673AAFFC1A8716DB258BC0269A8EDE8DC
      DB69A40DF97A1181126D0EFBF912385112C74E1D9B0CE010CBD926F6FA5B3365
      6B3F06077D137B5DA5771E3F0AFFAD6A05B40939E468D336A25DE447F053D919
      3795B43BF927AEBB651C0EE1C74B9C57EF4E4F196995A37CD65F7D840BA26E88
      CA8422AED045CCAD39153E7BDA18FFF1E1F4ACC1A3DB3B383A72AE159274ACAA
      8036B79873C0D1D5C0DA2B4A092B342B0D1EEF2EC79D670977C345FA5C7937CE
      C9DBDD6393AF44D8F52F58D035760BAD79030D663E2C9CE9885CD3D7637CFDF1
      60F77D9B63FB74021F9E36B20EBA500B963E6BF5308BF82D8B623982BB883315
      6889DECF6F4A70021BBF6270551C34A2581A6981FCF4FA5DFF67E76DC2D92953
      49BA7FB87BE400D061DEC8582CCD7CC1032A5A30BDCD062ACCDFEADC4FA208E8
      AF7447C74B55861626905C9B660B6EC6E030A7B169F78FF61A2912E04F38AD12
      AFAB6538AF415A039C2063931B7E6F4ED704498413340C4C970ACC7958ECBA99
      CC5B45F52F70A2C898B9296D035A0E9F460313CA6EE4F47E4773E5EC9D9D1CB1
      13C1B68E3815063A032C4558F141E96E6C5C8A2F507CD7DF780C2B3C86C163A7
      9A294C0373DC4B29B3454EC34691B879351B42533EC3D5D9CB4D3E64E5943722
      1F72041D24B660D6760EA1EFDBCEE95C9315F0458EB5AF9B1AA151BC5C1E44DB
      F94E2B0E97E5F4FD6BE57DA96E9DAF3BB013E5E997CE772A4C69140737BA3249
      0D1BC99EB0D8E9747D3560E3C676A2A5F9A1796F8EF604070CD9CD7BF5EFADEB
      9EC42F9DDD7496A4E4C76A3547187C77364BDAD00A1BABA4B95609FCD617EC94
      FFC8314B9DA2561086FC87FD13F1C004EF08B4E8CEB56233976C932C53E762E5
      0BAA291D72EAEA5830F11EE17AA81BF8B241DD3B2E7CB6B331C49A6B883D7DF2
      EAFDFE195343DBEE8E1B5ACEB6D3CE9790B5046618A9829977C8418FD733C9CA
      260803EE73CE9D48A17F862C7767ABACC296C7B1638C277D89D0DD57B7FDC825
      CD4380350ABA757568F83D09CDD79F7EFF90F8D71D37F2168E32A094CBB0DEE5
      F079E4CD1C5A96F352BD3BA5FC87868EAC08BE154712A3F3C5971C43DF0FAF68
      70F97ADC83F43146D837864DFDF63E72EB5EFFCD995F24B146ABDD351B33260D
      2B0177532E5DE99E68A4F172B7A3315BAE07E70122F5CC9B7E4B6430A3E328E2
      33D1331C5950DEB8F42F725D54E08F1B05C848FDF9426C40D2F9E8570CC83500
      B847A3E5B6C70280D24BF3E73A164643062906AD047D030A83D383FF90F4C516
      7A4081DC2C598D225D23A4220A4D179E6EA644CABE32D1A0D25BC065F5E1DA0F
      3714B85F1A44F6BEDBB52D13BC276CA388E00D5EA828D20043328814C8DEEE23
      F6754CABFF0689BA060F7DDF72787226D66466DBA21994B0C01AE4DC25A5C22D
      34269FDDC8D1BF4DB8C18E51FF65682DECEC4B5842D70092C54FC2BD40E36D35
      728C3609CB8D70F4CAD2910DEC0F8B0215C60C268EC62FBF24336CD4209F3E31
      DD40AFC308E73ACEB13D934C974E1390F6E45AE08125A326B31EC80732F25880
      B222AB00D33E4FC1DAFAEE7B34D1E5222573ADC8A9CD00C3020720208A068498
      09853F85B9452B3E4FD5AC2DD08A771E66E22A78964E9B4A1164645EC114B311
      A126EB8653410237812E761C96E2652FB8030F2BE9FF45C939D7F82DE6097390
      359353F6E913311E672178D3008AC17B81F70AD93ACF807F18FBB66643CA352C
      20465A9639148B9BC32842CB5B30430B5A28EE8D5DC2B7662C12EED5A32BF809
      7C3F3CA6EDCC17399783C4D572913449725B2E2226BDF9638D21824C427B8B9C
      1FC8B61C3D7FCBF6FCECD01FDB0E4DEC0FF29DCEBD0D88F017A95CE86D2A1756
      B9D28F9D0FD6F4F39D4A6B6623D51AE8504B0219A9C222C5D5C4A1480330596F
      2EC3BE33122D603FB04A72C07382E620499BC9F578A2677AE6924A9F2799E1B2
      A4B300813A8D1A51A8F899620AA6C65AA925DC9494CC196233B6CC4F2FC220FF
      F3BEBBF626D15E147A973BCDAC8AFC69378A7E767E4C6FB4F34A6517CEF94592
      C150B498E35B775A527BACE13AB70FB16050FBDDED3BF557BE53DFF9D71D9DCD
      77F84D7E5D43EC6FD0AFDBD8C2C66F905812F361367789FFB47B74F4B3F3FAE8
      F48C21671CBCBA54F32E674D1A3CB883FDC37D4731655B5602481719AE468EAC
      888356FB1C5941A1DEC32CD0A8F2B712A55499250B623C7B3EE506A974ED739B
      2A2F23ADE7D14B9BED7580BD8A130B06BC93913CBC0B81504F98934410AF9764
      265C094D1C7EB15C76852D11A1D2428B9B283847482B1D702FD026C75D72EC2B
      9B0E000D9E84A0D0FF90412325227154298C3A4EFCEFC9EF393C7EB76FE3C996
      1602C1912B95323E64C908DBE011BF3FDAEF2D2396DDA1BDE6238E0C56DA248D
      1DA814480943A524C6AB4C674C421F80B836083F35738C3602623388C975ACD3
      EC229CDB152CFDAD3495E8846CFA184FE3E4FAC6B9D68A31B16D8D570DB5C75A
      FB53B5986037CD2F6649926EE2445F224ED49D6EE244ABE244BD471E277AFA24
      2CFBDD6E174E629B48D88533A69C300576B42913DBEC9B2FB06F36B0EC2BF7CD
      E367AB7D0D26F545FEF607DE11687A9DA9F4D2B0D45B94F13070FCC59CFC4C2E
      D2914E69DA5257E0B606DB14B7953DC205B076FC011B1BDC092D31B128492EB9
      8934775C95ADFDBC36DCE925B55813A5D042E33F74A7A0F064AD8200E5225944
      7EC5A416A26F5E0F3A5761E45C8550051C0986B7CE255D8510362AF5B7A8D40D
      34FA4A95FAF819727DA6B3703CC4C9D16CAF2C659D4923DBDE15DE3BD7174802
      5F24110732B8A7FDEF8BD9DCC086A9BCC120BA77942BAB170C73AED34BAB3951
      CF86C11EC4C8DEBF4FC2B89130E14F9F88777ECADEB9405022DA22BFFDB3F9FD
      7B0CFC40067E8681A3D20B08D7CA617E0E9FFC5E89658211D5D6C61768C2B821
      5650A6D7A76904ED824B489B284F14FD2D6D221401A764BEDF54A13C349F4ED7
      4E32D7B0F311D0E398B1A3CE696C4D1CF7D327B26DC2F839A3EEDB01D10E11E6
      F9E8C6F110EFE1D17A09781573BBE010FF65B32CC4918211A372FA1C4541CA43
      57FFB550F26AF95B0C50FE887E6D88159B69C31D33778DF4CDB104E4172786C8
      061689F497648B1AD2E7382958897E944EC39796DD4C7F22E18720F25251DBFA
      932C4F8F6EBEA18BF98D264F6F67B8B381175969F13C7EA66FC46C698F65994E
      F3556C001EFD1EB51377530E9BFDF21BF64B77B35F56ED97C74F37FA6A718E3C
      C74B278812C5353873D8BD7C9CAB34CC846013864D8422F056B0F8E5979BD68E
      7306167BF4FDA43A433A175B0ADD21B76E43E270752A3730B744480385AEFA1F
      0B15314A269901C9E29CAD811BC716E81B0F250A6720ED94AA27E5798B14F88B
      F4B3B1CAB6068E7B93EBEDDB0FE66C54B6E3BC92B2592E2F071F1DDA923D69E0
      1244B5F53DCDEBBD0B3C3A131FC9C4295C5D8C50862D612CFECD46E17C0185D3
      F9F76F24C5D575AA0F96627FB4BCA9AD0C49682CC33A40ED6B8369275AF69FF1
      FAA512616767A7F51565F75BA4F505C0ECEBA004C101612074538922E004B4DC
      6275159E4B854A9E6ACD5192E7FFE6DC275623D51AF59D2B3E2F2A4AC29EEC72
      DB3F92AEB340A9AE46F0134ACE8664823AF928A849F05F21A4AEE21BCED1A7A1
      5F61EB64B08719E6089ACB33C849BE8489F018BAC736BA7CF827D6D3DC1FEAC8
      4FC2A5CCF179D6BBB525C1A708DA1E321D2C22DB43C47EE38CD654481E25BCA6
      05AA6872DB85462645CCACCEE26799832258E48B54B799E84B45F4AAD72AE6DA
      1A155DAB9B0C2EEB15C6AC4C8EC092923A5B7AE77C87DEA08E2449F2AFDFF5DF
      0BE62C1D2E37B034C9ABC51F62BA17241BA9F99C2F34F367CA7B4A540C33A0B6
      635B6767EA122E616A7AB2E2C446E9522DB787AB8775604BECAAB747C8068FC0
      3DC44D677B17830CCB26D4DBE59CEE7D9BCB2DB7573D3DB45E83EF9EBC3D7CFB
      E6E557AF287DFAA40CF361062A1B4A717352C68294E990EDC733611AE2188C96
      6CD7F58FE1135EC817E1F44B2B1BCDDDA5EC36AEAC304FE1095E64BC9CC3CCFE
      16092E8E1414ACBABC05F0695FCF75ECABDBCB26D6C250C0D78120975506EACA
      78D7D25F689DF261697628F87B64C18986C993421E4BDB9A5F5E492F9E856524
      B38BD404ECAD9BDA3B7B97B6605B066937DADACF602973160F020D234B59C894
      15914AA1177D9F7B11D53559542DE6ACAB889CFE6E9AA740F8BE98E3BBC19B57
      B221D28570F92D6254EF28673470493AF6DD684DFCC8A5C61B77F0B75B67FD9D
      8E73F0B7F7072787C7076FCF768F36BEE12ADFF0F1F3A4CB9E33B60A5C2E8468
      399792093FF7ADF296B671060D21E90CFA6B86C0A7385C758ACA4A5B87BEA287
      07F8AF3E1D7F625D908268C98F1E776E1BB5D96225A0B09B6FB81C91AEF6A033
      C9ED5A78B6B37B9E00C32A0438051908DA74D7A0F3D99810AD3DA64C446AE380
      7BFC5B055D7723CBFCB8488F6D238ED4C71565479AA70AEE565829B324CB2DF4
      AE61CA35BEFE4CABB86284B1C6CDB4AE33AB9C11C8E01A5F432B57CB398AFBF9
      A18FBE5AFEC30DF7BD663A0A9C2D343A610DC44ED9999ACDDACEDE6989D4C245
      D6C6F1B69919D71E001826996A87DC7B51F008E00F82F42067949D6703F72478
      FCF608E553E8799C08D105BD3EB6E64CCB79CDF76583B37A736C6C089496D9AC
      8617B21E80C9E7252D45646CCC93F1423370A9F55CA618EF966D2FBD3FDAB22B
      03B808B155AB43E0119C2D8DDF302C4B06EB395FFEFECDC9BEB8285AA5112892
      CC426A24603B9A208BD15A7E89D067DB2D9C7D3154D5AF3EAE578B73D4E37272
      4EC25CA672C6BB4842CF7621B85A705C2CB499D8804D1CEFD945AD1EF70FB120
      30F00961C05DCAF9375A4C4CE4F7C83BA6CEEEDE7727CE4FC23FD81DFC8CCD72
      205DF9EF15ABC5D2283DA54F9ABF9D72772649FFDD9CCF15EED4940F183B951E
      B3E3BC0925DE69ACF2B93CD21637013B89FB40688FCA4C1925E5B797A28B45FA
      55FA0AC401E0F9B5D800D7491AF9ED2F12DDE4086D1894D1D939763FE34102F2
      0A3E2D9617E42B6D2C829F23EDAA5C5050A864BA1167427D7BE25A3FABA1C7EB
      D945AD05C6A70322E0C5BC712F208C29699EE373D84AB22D8747145E0A9A434B
      58749C678755C34732CBCF9C133EBF4B43C5F193C676529D713D896DFD34EA0B
      724361E875E654AB99388D405E3C4A758C9F29B226EB1A5ADCE36A02034AC67B
      C75CEA6BF34B889F7D7359BB5E84EE3489D4F08369E5CAAAAF20DF5C285F9631
      43E294BD9B1B67F1573B8BBD4DAE7DB57FF8F84947DF2042766A416EB6DE1C9F
      9E6DCB2EC4A66530A7E29CCA9268ED1D51F72B2CF78980ED24E9E17E9BC3D662
      A73452AFED9A8A2873E49DE873B1B30B743DEE171139B12F2D7EAE725E23AD28
      1FDEE8992FA067BE6ACAF091A7BDCEAA815993EFE186D599FA7B92B2ECAC45A1
      A230BF3179954A30C8657F03297653EF463734F56958DBB319D9B19B03F2372D
      DC1A4181DCE9EE6C00A5569E9F8F9F3C57D0026D7A2A0853C48C90A7298B48E8
      EC2353965D0A36F81FE14CD70445143EBC1EBCC4E5217205B18A38F2482F952B
      907E35719C882C152028E84F3B4FD21BA7F55DE893E38660CB71E23B6FD0B1D6
      B2BC97E4C1B8DA6061B2D9D3C47133598AE530A5615ACBCDA183E42D4C4459DD
      08D29EEBBC127CC2EF400151274C8195018C613A794A92E9264AAB80939E43FB
      08EBEB7B955FD0CA08FD46461E776946B83CA1B58881171CB71C13F1875FCDB1
      2FA9C6332D26C86C1BD7C031D3DFB8313F7D727A3B50B1B5C80C6C3CAFF5B635
      F1F3C4C92EC3791BB90DD3B0DA767676B64DB38D572D40E2D062EBB40850B4DA
      C54F6F93584B9EAB75884C4EEE9CAE0FDD99576C3551C4CA472D0304B4903220
      E9A0B03DBFB601290982D04352CF00E73471A85C861BA00AB73C2B3D3E1FAFD3
      046517162E994CDCB2688B1B3E0A5E1989558529F40A42B3362BA5EC3ADCE2F2
      2F11DF362F24937333E6BFAC45BE5B136548C69F4E0126945F6B75592634350A
      5EC26C668EDC1A9DD44F9F20855C0134F322946115F9B7264AE7E9133EA58362
      798577F2A1AD578B30AA04A2E9C89504301488B345DB3173FEB140664339AED4
      64D3EF42837346FADCD3C21200FB6E7BC7D9655A118ECC16853D3E293143DC4E
      AF8DD0B67998EFBCBA69F19A2D3A0C4DF0B5E4812D9AED4A84A5E265FD3A3604
      88A78A82AC26034E1D976A100919359F4748A61BAE29A970B28D2E5E987A8B19
      CC6AAFA18981DB617FEE634E936B1B516307CFC950DC5954E95E873516041200
      738DBB09CC649163BBCECACE446E3DB071388199E5D25441B79BE959B2E39C26
      452D274C1CADB290C32064A7665E1ACE493D03473C492E1BA93C9096BC4147C6
      B973F8EC8A7B7FCF13CE87281727D25F362D87BF313CD9DD3450AD0CE20C1F3B
      C1D6720A04CA58DA71FD4AFD1AA9846682B1BCB63965C60780C5F81E55435C2F
      B797C47E1D9838A95862E2183A707D168C348A3733C853C47032678B5D125181
      7C44448A8EDFC7489457CB9DB569BC4A45E05DBF550CC86D9E50A9367F21783D
      5C73AE9C9D5C67039CC005F70537D414253319F6CB1CE10E2C27661A55992985
      29F0519D2DE3DB59B45D544BCC55663283066DA080986DA4C4DF5BCB3BE5727C
      6615ABF62B43B812322D056888A7CAD0E93999D39BA3B7BEB6FE4F32D2BE8785
      8633987FDAA575BC0F46AB4D6AB0222418796CBD62AB5D5F24B4008DD58218F7
      7E420E05B9643BA408B5CAFFE47C475674B040BD4DBEA252F81E0A311C8BB5BB
      494C578CF49C7D2A6B5AD59DC6A69528F91FBF2046FEF343AC2088E3708695B3
      F603E7F7363ED1E87F27B3A4AC506E17DDCFDCC36D80E72FD8D9D14E8B4569F0
      450AAC3528D6457C21DD7201CDF885A430DE19E210FCDDDA06D9CEDDE1DDDED2
      663CE3DE743AED4F562ECAB9F4A8FDEB4794326A5FE5CA1976066EA7DF197407
      9D4E6744FF4DA426B3471B504F7DDD09DC20084C9DA6D7E9F1BF7DF979E8D2BD
      83911E0F46437C1D06C3C1783AEE8C86E3FED0EFE9F164E48F3CE54DBB9E3BD0
      5EBFDFE976E8A2F160127893BE1EF6FC817AFA64EAB93D7AF8A437D4D349CF1B
      4FB43756BDB1E775BCC974DA1B7447DED49FB83D351E0EE965C603CFEF0D0783
      9E9AF43ADDD1C8EB79FEB4DF0FC653DD77757FDC73FD6ED019BB43AF3F9D4C3D
      351E281504BD41AF478FD16ED71D8C87BE1AFA417F3C08FCA9F29F3E198E26D3
      49B7ABBA93BE37EAAA6127984E8281AB5CED7ABD497F3C194F3A03BAD9540D7B
      6A3876F588C648EFE1F6FAFE444F3BE35E379876D4C0EF05AA3FE9F43CB73F1C
      8F7AA34927F0499CDAF3E9D5BBBED79D6897EED2ED4F74DF9B0EFAFE580F3B7D
      77F4F489DBE9FAC349DFD75A0F83298961A07BD38E4BEFD00FFAA38156DE400D
      FA9DC9A4EFF6BDCE9404A73D3509A603924D774463A31FDD696F1C0C7B5A0D7A
      F414D5F5FCE1D4234905D3EED4EDE8C9508F86342DDDFE504D7CDDEB04BD8E3B
      F1BA3DAFEF769E3E81B08781178CC8EAEFD203F4C80DFAEE544FA6F4FAAE3F1A
      4E479EEBF9345EB737D163AF3F1A6ACFA3D7E806417730EA04C37EA027DDBEDF
      F73C7A0D771CC85A09B07A68BD7C6E9DD16C900CD4986E2BBFEC90F3D3E56F5C
      B3D282718FD69837EEF7025A57E6FB09165230525859F4FE631D4C86AE4F62EC
      8E7D92378DAC4BAB8A662250C36967D0C7F48C7D9A906E6F320E46935EAFEBFA
      B422347D1D044F9F7834AD1DE5BA246712B70E82B19AF6FD402B3D7183A9EE4E
      071AD2194D95529D91D7D7BD012D3CCF1D4D74773CEAFBB438035AC1D3C9500D
      D4B837ECD0EBD0E2E94C46F45C7A868B05EC0D3B7E57F5494C7EBFDB75D57030
      7147FDCE74D8EDD12C0493893F1DE0AA9ED283DE68E07769863B7E8F5E68E8BB
      FD01EDE5C13850E36977DC1D06FE9856DE04AFA64966B433FAC1B03BA28D35EE
      8F69287A12A889370D025A352423CF9BEA41E075E9F341CFD3C3014DCA88B6CC
      7430F046F4A711BD81EAD2BE0A747FD8777D5AD393D150297FD0D57EC71DBAB4
      E2FC51E0CBDCD499D9913B9E4E47DDD1C4688C892A3409FF8F34073D81B4C4B0
      17C8F74F9F547FC2F7039F6EA0E9BF31E9959ED52A34186FE07768EE7BD02A34
      A7635F75C7E36987B4014D864BCB74301CD1A6F75CA55D37A0371BF4A75E570D
      BAA45F48A2D380D635ED40DD9FF4FB634FFBB48E69CBB84F9FD078E81B9A48AF
      33EEF813351A92CAD1930916F598F48D1AD3BC4D7C3598743D9A286FE469BA67
      9736989E8E275D92B83B98D046F383C19496657F48EF46AA82D620AD0CDF1DFA
      7EAFE38FDC21A9AA61AFAB692E7C7FA869FF0E68A190AAA337180FC77A42B349
      DA9C5619FD91064213DAE9F5270F91FF40778341C71FF3CAC69FDC2ECF407774
      9FFCE5FBA74FCA9FFA5D2B73ED91460926D82DA3EEC0D55848FDA033F17D526E
      AE3BD2037A9AEB7A5E773AD274FDD4A5910EBCC1400FD4448F680F8C68CEC623
      5265B43BC7A459694C036C959ED7A57FFD3E5DDE278DE807B40E689FD02EA387
      D31E0E485C2E6D86D174D8F76833FA1DFA6C7F389D9242F7C6BE4F47408F745D
      8F765F7748DA5507748F29E9309FB44AE0F983C974AC02DFEB046A3A1E4E0634
      E724345ADDD3E9B8A7FB53DAC24345DBB1EB4EFB239A591A6080DD3856B485D5
      880E9CAE47ABA93F180CA793C114ABA947DA965EC7F73B413F7027136F3C1A4F
      E89CE88FBC09CDF7141ABAA3465D7FDCE96BDFED919E9ED2133A9EEA939C7A53
      125F6712E829A91B7A195A943DADFBA3E9B8DBA52B4624D62EAD03BF37EAF9F4
      3BA5BC61B743E728E90AD25A83490F7A6B4A6AA38BEDE5F63AB4444973D1A4D0
      E9D651B80DEDF48147AACC1B8D7D4DA7DBC8ED9234E900D13D3A4206033A0E27
      63DA0F748AD38BF747237F3A19D1B13BD11D52637DED8E7B74364E54B7D7D1E3
      A03FD0FE7034A4A5A43DDDC339D5EBF974B44FE884F483514F91E29D0EC75E40
      FA8A8E7A3A36037A1CAD17A8CD80D4ED9474A2A68D38F587642CD0314712A44F
      7AB4D4699AFC912255A1028CA9D31F74152D0835ECF7C8F1729517D0B6998EC7
      FDBE220B84D64BD055B4A469214DC982A03DD6EFB981EE4122DE90CEAC6032C2
      913D1DD094BBF45B3A16B4178CC7348774700D5C52CC2A1893E9D2A18D45E602
      8D866602CBC71B92E942BB9CCE483A42C624D9295928F40B5285BDC964DAD138
      40267A38567E30F168FFEAD1B4D39942BF0F68FEBD3E7D9CF43C2D2A12E56438
      E9D1E934A1E5E40EE8301AD102A3A53DA2F92205E28D356D7EDA84832989820E
      FC1E1939C108AB8814C1B0E30DFB5AD109D09D3C7DD2EDD39B04349D245897B6
      D7440D61676052A67ADA9FD25130A1DB07C331ADA81E499CD4379D7DA4AD27BD
      EE9894039635EDB56E405222218DA0F06915D33B74301FBDCE2818EA8024473A
      8C44A05D4D27CF84666330A6A3CF7BFAA4EFE178A6C3970E7F7F408B99F4D784
      EC34351DA96048070ABD7BA069B329350D689904B40749B506F4613A82066419
      069EA69D32A6C5E2BBF8C8544DBAA4687B439C9374D3C0D7DE24E8D243F8A73E
      D941F4850E2E3A2C86B41768F3D0B94BA6286D049A99DED0F76811F8B441BA30
      0249529DC9784072270D4CEFEC9366A67381D6399977747692100674D67A1E99
      031D3AD48774D9C8C5403BDD4117562B2D673A5A496776C82AA2231906A94FAF
      45765740CA8AD6C1C4237BC8EB92A149F726A5420A74E291A21F4DDC09591C2E
      4D371959F42E64DE4D6861D3EBD381DB1DD229E1FB03921D99BD033209821E6D
      1ED262A4A33A641A4F49A90CBD4091113822ED030B6EA2C97C9C28BA91D7A383
      A94BB69837207D30713B6497BA13D2CE633A607A1D45566E8FAC21AF47270B5D
      33A2CFD074D2514F6FE7D1D8D5509175E04F49F5D0E4F7C806EFD2AB79A44FBB
      A4F72674520EBBD33ECE2535A1C3653CE80D7C28D109ED413260FBB43E3CD2D5
      3408BF3F259D08339734446FA2E859A450C7B8F1C0EB91D1420724FD9636A2EA
      4C692A68D669CDD3EA1A9394A67D7AB701D96FFD092DB59E8212A54547FA8D0C
      2D327F87FE64D057B4E1E914F13B9AAEA43193D2EA91C6220B948E3B3295E9A0
      26FBA01BC06120C349633FF372C7D6214B86FEA3F54EEF4C0704A93C9FAC81CE
      98AC537FE0D37BFA931EEDCCC134501A86C980B4D37048DE814B472559B1B432
      FA64236A056D36226547D61C296A32DFC80C9F76BA9AEE479E26ED85FFBFBDB3
      6972DB38C2F0DD55FA0F7B4C0EA902E60B44F9645976C9154B4E2225B9E4824F
      891177B9D9E53A56A5F4DFF3344072091003CE401B27291B2E5922D93D98EE79
      BBFBED2139C44369415D2E5924B823D9917F9283C9702D09985C668183B144A5
      9150A33610337503E22BD756BA60194B70DE284DCA6AA937A083693379A2B42E
      9D2D35B141CA6B1A0246B99AD06AA5F310D0B4CCA069121EC19B49CE7DF62577
      93A01B8B1194436A569BB7F0222694558C9D926C54C978C48E295CC69A25D4BC
      1CBA2E05015248EA4ACA2629329A07ED52D87B4DE7036E485E441BE3B62AD504
      40923932126B5792ADC1714E996175095B2D9288928A982823BAB680B6AD74C1
      DD688558BFBA68724706A7F6E67474A40F1AAF96E6A794AA4DC2807011809447
      706B4B699A32A849AE300E164AA46489A17E5399EA3287FBE01C4D0099A412F6
      4430916361C89411B2139D0C114F5D22C903C504DA80E7B97B09626B0B2712A8
      927249307459D24D4AEB0493C9682E73985C4ACE2F2C7663472E15A9ACAB0A66
      5E35D2B54175203CCE25AE482D10850690B8AD9052381135991A4A0228A8EDC4
      BBD550744B7C1290C01F56C494211A0E001A9338D8A9A5EED08542B657350B47
      DFC8B396C2449AA794534E89352A39C368CB0C5ABA58C831927476AB02968485
      780AE7317DA8000E294AE6265AA4410787CAB81D8024D753099A82E54C290AD2
      0D644455459A368E606D5CDBAE5AEA0D6D2E8FA8A774347817EFA95C1710F15A
      FA46500137AABA840CD9C1CBB489E44C03552D24369595E8A9560492831B6896
      8A7AD3D002B136BCD438620A22475EB259AD0B49923476743899C0A6C8197645
      1911769DC1C78123F936A379CF8463B00AD2D1926AA40212FD8A86B9604E540D
      9D1AC66DE01F2A27AD3AC80A059C640CC921BC69CE20942BD60A17E7ADCA2A9A
      1F435D4ED3BC4E70BAB4BA9433E6223637963A4B4AC96D85A3A01AB83BA91266
      401651397494654EADD1864E9E1E9B25625DE064AE2A84A3D193D5C4395C0FA4
      49774ECAAF2949E277436B479F916B4D2F5052EF0A05B4E84E485224F7324D20
      2CD4784B2AAA59873223346487029719BAB65AD84B425ACE5B3A234BB66366E4
      94222DE956E10D921F92B2527025A34A4820D5AACE32E832C9999E978CC392E5
      B285236CA5CC489029F0A5D25067BA9D113A12FC4F2745478871AC251369C570
      E189DC9202425FE9EA15DC956EC9200DBF51900656C0191ADAB4C23DE4405832
      1C22CBC81F3CE1587BE84D45976AC12F2D19859F7521CAA9AF8D4C131E471392
      6679D5D95F97D423D9E9C207B594B81A2492842BB2392D015902C432D32A4DE8
      77CAA4C5709567E466DD480B282C8AEA563704309443628D9E1772E472CA20D8
      21FE606C65636913A1ADB2E920EECE05DA0DD99B65A37792A0A1EFA98DCC001C
      60A0A330B06245CB5A4028A03DB0349230CECFEBA2B06D43EAD1052367C497F4
      D5A088061F9753150A3893130FB34696C4519297324294369EE7483260183460
      BF14196009A01C69B68248C181E91BE1355458F4A03C942566800F43BBC584A4
      9527B9CCB6EFD2CBBED354D97CB7F8B83B436DBCD8B90FF76FBA1E5E58098141
      44AB4CB64B5A4706290BE978C053BD5A2144E848A3D4184D63280D126D714A2F
      52D3264A47B3825E91CAC8074D9E436ECB3C8303E6903382AA6E484CC43268A0
      1A2100B7CFE931A8532B58271C90469C0AB0CAEB5C530A4A5CB3220138F26B53
      A750989C8657AD8C346486D687BB69687846D0290A2A141C8E022B372D1C8980
      A2C12C6053743A46A94217D0787AB7B2A678D18810B5E436D99683EEC25341B1
      6301A8EF549194E95B5A0AD9B5C10DF0B055EEC0276592FE8B0586AE924AA08C
      92A30AD97EA80833C85C21916E2A3A160B9C4038B4A75FB9C1EA53DB552DDFBA
      8FDFF19DBB4E77836169DEFDE04B7390DDC0B9BDC0A94B27BDCC10898F48BB74
      CF4BFB545317A1A2E6A2E2740F653A122ECDEAD2EECDD4454D3ACE8A559898D7
      D4CECEA5995CCA0C9333217CE7FC73BAA71B9E33BA99DAE4D103B6FF63F7BB62
      55951487973E3DFB42DEECA8B69BEDDD7D256F795CEF4F0DA4AB6CF72393A7E5
      4E9926B5825E7A2A257EA1FD5374C504B013541B5EA5B594572DE5DED075EA95
      48D0EF9B6EC6F2FF4A46C0AF4865B9A09EB1A0F5F0CE42DE59200D90AB33DA07
      E962E014493F076245F39AF473340099E1BF0486D52AD9A4D07BCF10F334476D
      D6CD69AFE79CF8505E33FB5795640AFA2CC573593FE7CE4A889C264A680D5B91
      77B9446867211ABABF33B406CBC52603B5EA9F33AEEC9FEBE4D4514E1DE5D451
      AE7B8EB165CEDDFB41FB3106CF3CCA74E894E7D499D4F948FA4C469FC9983319
      732663CF64EC998C3B93719DCC0A8F8B47CB7E9D0E8FBAD758095799A1C4E839
      E4C0C21E93F221969BDDFDEEE3A6B9FFDBE6BEBEDFADAF8B9F7466E5C1665B7D
      68EABA6993EEA5E67ADDBF357878A67FD750BE087178E61FFD67880F0F6FEFD6
      DBBBF5EE238FF3FC5F8F43363F55CDEDEEEA4423BD3A954FAE1E6593ABD7DDAF
      457CE995CE07D2EF9BFEA314E997F286EBE9B47BADC749A7FE094C0FA9BE7CE2
      01F5530F689EDE68FBD473744F3D60F6F446AF9E7A8E79D08007AD3521F65330
      82875A61201DEA84E170A86316E8D84516850166A8932DD0095BF4A14E1E68D1
      011D7A088FDDB662993F7380B0159F19407FBE1161689819202CCDCC0CE03EDF
      8830D0CC0C1086A09901E2D2445F18AFBEBB91A3A22243ABDD6E7737DB5DFFB5
      87A8BB1637E8ED8F498FD59574D8DC45A9C84451599238F6C977792ED776306A
      55741F898A9AFEAEFB76D3B6BD6AD7EF1EEE9AFB48439A9B1F9BCDF6F6781672
      D4BD8FCA77CDEEE12E6EDE477C1CBF74B514248F03C499DE7DE3A63F8124EAD6
      B7C5BB457AF0DACF30F8A0DD85449CA14788140FBBF782BB7513B7CED74575B7
      8D43E5B6888A8E83DEF7EBFB58EB44E5EAF9C366D3C4A58A4EEF75FC32767A71
      24A853092D8203A53812D4A98415BA09EF2D316AAFB9C8B6BDEE0213F79A0B2C
      EDD77B89A57BCD4596EE751758BAD7B4FEE6341DF6B26FD7BB4D5C62F97AB395
      EFD946DAF566FDEEA6909FC8886224C3315EF41F6CEFBE06F4EEAEB87D7FF5ED
      F6262E889F6FEB8F576F6359C2516B19B5E956467EE9657DF310E7EB81E61214
      1E75E33AAAA16E68133FAD1D1775AFF63F09FCF291984DC37804AF8772178DE4
      37C5E6A1E7049106BE287671777A04D0B7DD314B7B187DFE109198782D8CE0E5
      BECEC6D9FC78FFB85B3EEAC541701C738B6FBB578F4DC4CFE51FF1A9E2E54739
      4A717DF3214AEBDBAD1C31DBD443ED49E02B35C4F04E8EE8D8DB36AD304CF8DF
      5CDFBE2FEED77184EEF09D9BAB57C56D94E21FE44B70F15EFCE677D7C57A7352
      34E2D6EEE5DB57DF5FBDDDDE0A8795A33BE35650949FCB17CCAF17E9EF9BE0DF
      FCB5297F1B7FE3AF60CE371FAF9718FCD5828EAC53FC7A1D99CE7AAD6DBD40EB
      C5F1E73A9698F8FBE663B92DEEEAF8FBFE812EAA0B8E5DB340FB4D215F1A8ED7
      936F2EFF93208CDE2FE8B4FF52DCADA5155BDAE8DE3F947F6FAAB8C87BBDED7B
      AA189D1FFA2F66F6753F769378A01C97E307AA91D545CEF4DE9E6426CF1ED8DB
      AE1596B3D13C669D24BAAA79BFDDC8D927C741A799CBD8DF6F6E8BEAD0F71E84
      DC30697FDF9D31F2E6FD63837C141C532F113CAEE0514A4D489D587594D32332
      56AF1FAE0FF7DD6F0C1F65CD9CAC1ACADA29D93D5E0682CE2B381A319B121493
      C623AEBC826A6C7DEE15D58331B3E1EABC28EE3E9CFB3C1BB54DF266BBFCCAE0
      D42A666A5AF67C503D2DD8AD65288028329514F3746CBF0F4B8F0A41A0F288CF
      63CBA3340F328FD20CDAC6B6FBE2F94FCD8FEBFBC3DEEAF45EAC19997F7FD299
      CEF0B721C8FEF8B0DD17DFE99B0C97F1BB9B5D7373DF9C6885048E77BD6762C8
      E3D99960F268CCC4D4B4862FB83CD2F351E6337D2EE03C379A893C8FE90121A8
      C292B947FC52009E25B8B010544B42303CE17B3402007C664F00805534805534
      80551480D512008F4D0F01B08A06B08A06B08E03B08E03B05E0660BD04C03A1A
      C03A1AC067F60400584703584703388CDE78A4C3003C363D04C03A1AC03A1AC0
      260EC0260EC0661980CD12009B68009B68009FD9130060130D60130D60130560
      B304C063D343006CA2016CA2016CE3006CE3006C9701D82E01B08D06B08D06F0
      993D0100B6D100B6D100B65100B64B003C363D04C0361AC0361AC02E0EC02E0E
      C06E1980DD1200BB6800BB68009FD9130060170D60170D60170560B704C063D3
      4300ECA201EC66B6EE867E90371D37CDF01D95E99E7F68DFA18B3F2ACEBC7BA3
      CFDFE7DCC8AF789D7E24685A514DDE334473E8A4E7DBED87888F091C4719E2F2
      F9BADCACB7DDDEC8C7CFF978F4787FF687AF8FEF679E8A99C9B7A1BACDDC6193
      6E945770D80C19ED151C924E63BC82630A61AC57749846CD309C3AB8F6725DC2
      1BCA3A9F6C3A259DF9A447E6AF7C7223EB739FDCD878EBB5C976F96230AC4D7D
      C2EE18C54305E553C8A6152EBA6D7A9367C67FBEBDA719577AEEE1F7E9B4C225
      D77AB4027CECB329C4DD1EE342FDAE62FD1E0C60DF1E4B80DFD522BFABC57E57
      D120F71A17EA771DEB771DEBF7E00CE2DB4B08F5BB5EEC77BDD8EF7A19DACF4A
      C565BF9B58BF9B58BF9B45683F4BFC117E378BFD6E96F9DDC6A27DDC5505F8DD
      C6FADD2EF2BB5D8CF6B14D317EB7CBFCEE62FDEE62D13EEE1E02FCEE16F9DD2D
      F6BB5B8CF633E3867EEF3AA2601278223D5B434FE46653F889DC6C063991DB53
      C0D9C471221E46024F14C248E0B9DB8248E0A9FF3C0A7E477A59A3DFA74124F0
      CCB9412470D2C71ECD00677B8D0BF5FB2C099CF27B30803D0A97BD3E2656A17E
      9F2581B37E9F2581B37E57CBD03EE65B017E9F2581537E0FCE201E4A16E8F533
      EA18E1F7591238EBF75912E8F7BB8945FB196BBCECF7591238E5F7B814EED18A
      F0FA197D8CF0FB2C09F4FB7D96044EF9DDC6A2FD8C355EF6FB2C09F4FA7D9604
      CEFADD2E46FB9971A17E9F2581537E9F2581537E77B1681F13AB50BFCF92C059
      BFCF92C059BFC79D4BF00A95F88F61BFB996DFC058F62D8797C5FDFB5D11F705
      CF3FDFDC35F7DB8DFCC6CF61C29FBA5F6A901F69B8DFC94F20256977D651D29F
      EF9424E9FE7CA6675F1839EEBD3B11482BD5586D52BBB22B539BCACAA949A933
      FD594ADAC9B9469397EB47AA93AA4DD32629D2324D8B26F59FEED45F5ACE2F66
      C8B669DBEEB427DFC954E9E8EFD10BA2DF1E4F1D3B7F7C7CFE3F78C9699ABFDC
      EB57EB7FB9D784F5F5FEEFE6E79DC97FE3FA75ED7FB9D7AFD6CF5F16AEE1DAFE
      4F667AEA616021AEE91F673C91E59758C2F2AB3BE9D2FAEB7E52B9A2CE57AB5C
      B5692D87533BCB4C4D923BAD6CDA58DFB859A2D2675FA4A6692A53DBDA24A98F
      71FCAF5C5E0F2CBC9E7DF194B3FB39AEA7F4C0FF9FF5723D950716587FE83DF6
      D7A74FFF063BC5029C}
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
