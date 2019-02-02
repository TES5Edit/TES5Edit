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
      789CECBD6B77DB469628FADD6BF93FE0EA9EBB4C754B0A01BED39399E3C876C7
      A7FDC8B19C64E68659678164914404020C004A6267F9BF9FFDA82A1440420465
      3DA7AB67625114AA50B5ABF6FBF5E730C9A6EED09F8869E84733B7E975867E94
      06F4CF783973BD8E375C8DF9896973C8FFA6593A9F4E46E379CBED343BFC6B18
      F3AF5DFE751E147E1D053416DFD16AF65DF5792AE08DFD6136170BA1FFA67F2B
      FF759C36FF1C4EE328CB46217C680E61DA49E00CA749BCF0A3E1743CF7935464
      F0FD32F9C3FB73F897E1D28FE254384D0FFEAFDB6C353BCD36FCE7C1A7F697CF
      C142A4CE0771E97CC2E17FFB02537A7ACA453C1149794EB738670FE619D0DC38
      671BE63C8D574920129CF56F5F9E3F83195B158BF4361709A06CC286E1BF1E2C
      1627ED7D395B2F4671486B73F3FD464178FD441BFFFBF24B10CD26F05FCA73B5
      2B96E5B6BADBA1579AF3CB8FEF61B277C14FF8DCD40F3367F8C277872F3ACDD4
      FB385EBD145FD4FEABDEB4F594F074F894F0B43C84A8BF182581EFBCF7B3392D
      BDD5D313A697419A5E3FE1948EC6A3A9D584610033D25CEDD61EE7BDE57F70DE
      511A877E2A37DB6ED75FDBB6E9CEC42C16CE4F6F79719D7DCE68DB74FF531D12
      CD17C224BFC7094010D0F2B67187B63F19196F70EFE186C13BE781F14E6FBFAB
      D1DA7E359C77C16C9EC93D8DCCF9AB90F92B280E9C4A10A9F9F7C2953D4E257F
      C35E77EAAB4E257F67F79610569D473E73EFF6CFA3DDAD22D8AD3ECFEA948639
      A7AF7964D56A3C3CD7ED23D789A21C83AA83E9BA1583FF9E08714E6FEE5461B3
      DBF52A067F5E253CB4124D7BBD8AA18D1FC4281197873CDEAB1C5F05AEC6CBC4
      1F05E343B9F34E1552B9FD6EC50CDFC3BD0BC6FCFE4A46D66D55BDFFE7406491
      0F5F0ADE43B75BC505D499BB8EC1D8D579777B95C3E4819786E9C3EE0EAA46AA
      D32E8ECC4FBAD7AC1EE96D19A98EB9E7568E93E75C1C5738E35EA554A40EB934
      B878C0BD4A26AB4EB838DC38DD5EBB7ABBAD6D6F2E1FADDBEF5F4F221C45CF9C
      5F449AC11B76CA33FDDD04C29459D46D69F5779387E2B8752207EE260D8581F9
      6D690D761386C250BA2EBCCDC16EB42C0C354EAD35D88D9485B11BC7D676AB78
      86096466D68AFABA5572A1095F392427BBEEA06294095C1E95C3B5ED352B4779
      A5510A03DB9E5B3546535A35A6807D6DAF4AAAC949AC1E58C4BCB6D7AA1A6A1C
      220F35CEAFED5589B1E6F9C9376E1C5DAF163565B139679DB568A91A941F5FAF
      162595E38C03ECD7A2A3729C3EC27E2D4A26479900EDD7A263726011A4BCCFFE
      6E7C50BA8386697F3742E463D66A8BBBF1410F32E039D88D107A584E64DA83DD
      38A187159162B01B29F2911A2B68E46E9CD023CD331CEC468AFC8D5B8E70B08B
      13FDCF322BDAD4DAAAA6D8299B1666A9E22775E4547322B75276AC21B31626AA
      142277CAAF85692A59560D59767377954CAC86645B9EAB52EDAA23E31666AA92
      3EEACABB1B8ABAB7C314B08F8454D2C7BD7E6D2E4E2AB7BAAD8539AA08D2265B
      9773E8BB6A4ED3AAA4341B7C9EA7C96F6A619A4AB2B3C1F8791A754F0B935452
      A00D49802729DDD2C25C955469433890739977B43053A7B6ACC0331937B4304F
      15ABDA141EE48A36EFA7697469DD98E81566B921D12B4DD3BE31C9DBD857FBE6
      44AF30CDD710BDF25C5F43F23637F85544AF30D3D712BD929DAD7DB32BA55844
      3ECFCD2F95394DB50DA61E1FCD27BAE195DAD858B54DA6DEA52ACCF5F57C349F
      EBE6576A738FB770A94CD36AF7D6F9683E757D3EAAEF69617C7D1EAAEEA739BC
      579F7716B8663E417DAE99DFC7C204F53966E11E16E6A8CF29CB3C329FA33E8F
      2CDCBBC21CF5F9E3C67D338DDFBDAFE18BF92C5FA30C9813F5BF86881526FA2A
      BE984FF3D5CA4061B6AF246285B9BE962FE6337D2D09A38D8EE3304EB251F8B7
      612226CDE10C4E256A0E47E14A3437BFF23A1DF34BF8F5BAAF7902FC6DCB14A5
      AF4BCF564C51F1429EC2F5FAE697F0EB755F37FFF6FC197E8DBF6F99A4F475B3
      F8653EC9D6AFF524034FFE013ED01F065E2D3837F1B0FF826112E3F9124985E7
      0D31C262E84B971AC657E85F301443FED271D4C0A5BF7460877F84CE300C9AC3
      04FE4B7D17D8541A7A9D01FCBB5885993BBC0C26E32C5CFAC9F032F19730CE87
      AF877EBAF4C3E5DCC70FD16A018CCA5F65F1D09FFCBE4AB304E5769810D61AE2
      3F41E62F9BCE976114FF01B72E5EC49970FE1CA6D93A14E95C88ECCFFB5BC430
      C94280C5749CBAB8797FDA84FF1078BE0A6F818564093FD2548055912746D009
      017B17AC87E359124C6858B4346688963887334C237195C15BD23FA671B2F081
      D5A7CB248893205B379D0FF8158676C03A53B708A291DB2440E1BF23DCB40BBF
      F1CFBD4015AF32008E08C585089BB50137F4470A72202A6F871C2C7A34A4BF6F
      83DE39C83720ED802EC8706C2A1836F783DFC84FC5248E9A1294B0B414D67CEE
      76B6C274E0E0A54BD260E2BA4DD76B0F06CE5CF818F5E2B812CEDEDDC3D9BD09
      9C0152D7C2192159794B6F09BA9E826E775FE87A12BAADBB87AE7713E87ABDEB
      A10B7FBF73E8B614747BFB42B7C5BC00F60473F99349900517021E4FC5229807
      938988E09755041FC50A5E694CEA3AAF18B2CE8F7EE2CF00D273E74D1C653421
      EC3D4B5D17FE49E2CBC9304BA659FA4B30C9E6DFB7E09725BC28749B7DF931C9
      3F4E43F5F769A63F8DF4A7043F8D474B1FC83A7C98F287116C1D381CFFCCD64B
      014FA51722C940B2814FA36492A89FA1FC39923F13F973320BF527F5DD5CFEBC
      7076B118D8ED9D309947C1625CF79AEBF0FC19731AE7B33F0A85BE4B1DF32E55
      11FFE24E46147389345FD3F7FC9EE3E5E40B8E3FE3F179E1266EB9DE3F28D2EC
      9C82D4AAD7D5DDBD2E7CED9675C1D74884CAEBF1F65C8F575C4F6FF77ABCDED6
      F5E0D71BAB69EDB99A965A0D4909FDBB21B07B5FF6F63597BD7DEBB4D438552D
      09F40BB2D406F816691C29F98ACF7150798ED366710FAB70389E7AA5B3AB26B6
      E58303E296E049AB377BCDFDDEEC7A1BD7B8F6CBDFC461185F8AC9E622DCEA45
      7874A4A5A56028347D7943287C7EFFCE398D2742C95D7724783DBD9BEB79FBC0
      5192EEC62F62449684D42BCA581A58C8CDAF066E17FE75FB2D0F7E783D20D4D9
      55ABDB6DC38F76A70FECF7AAD31EE023DDB68B8FF45A185E7FD5F7DA6D1E8D8F
      C099F4689AE660800FB9EE0079FF15E8B41E3EE6B67A6D7AAEDDED746FF98CE4
      55AC96D6E8AFD5A7E4A953F2BE4E1256C29AD7DEFBD2FF980816EE3231D1D8D7
      BE21F66DE56705165258DCAEF514389B572D01049BA4292851824D09D6DB4286
      5F2FE03AA441AADF59CDDD4B2F2CEFFC1A5ABF0C8F733A57CDAECB3BDA63FAB1
      9EBE7FBD3450920376C3CCDB7CDFF367675912473346F78144F79E7787D6139C
      9CF0713806ED001060E587307ABC09C26B455DC6CFBB1476CB783AD80AD5563B
      876AD773BB03B89AEF82D4D082FEF6850E34842F33948AFFA48FFCBB582C433F
      13C1E4B8D76D7B9E371874F9CFA47F0EE9DF683A0642AC3E465E0BB64EBFFD3E
      6EAA0F91FC34259E2C7F49331F741E3833FE0D612CFF027A9188B2E69FFC1B1E
      C2F045D31DAE8E5B03B7E5FC07DE067EDF6A3112096014E516A51CBEE113D108
      8E5BDDA6BC2BBF8FE5E690CC7BEA94D138B86B2BFB6D04377E01CB8DE017408A
      BAFB8AB7EDC7ABD88FDB6E1737445FC0CCF8F3F6B7546F43683ADF3C2AB8915B
      8FCA6D56ECCD437436F7465FC04BF0E743EDCDD8199CEFCDF7D6EF97F6865FE0
      DEE0E723D8DB8E9D2139ABDC1BFC5BDC1B7D012FC19F8F7F6FD7ECACDDF2E072
      17F6865FE1DEF0E793DE1B66FF1476465FC02BF0A743EEB0A7BBB75E8992D017
      B8B75E3D4AB23F0FBBB7BD75DB254A425FC02BF0A7DA1BBA351D98063F0713AF
      E3F6FADDAEFB653B6F6F0FDA5EC783D90DB828007CF5993F25DEAE367D7B47FC
      6478BBDAFA5DDD5ACBDB1F2D1DB5BCDDF2F6A7B437CBDB4DDEDEF13AFD2E30F0
      6ADEDEE97996B15BC66E19BB65EC96B15BC6FE78F76619BBC9D8DD56DBF3DC7E
      BF426BF75CB7D7EB0F065EFF2E0EDD3277CBDC2D737FCC84D43277CBDC9FD2DE
      2C732F58E43DAFD31D0077AF50DBDD6EBBE536DB3DB769B9BBE5EE96BB5BEE6E
      B9BBE5EE8F776F96BB9BDCBD351860E071B357C5DD3BDD5ED7EDB5BA5DCBDD2D
      77B7DCDD7277CBDD2D777FBC7BB3DCDDE4EEED66DF1D34BD5E673B771F78BD6E
      ABD7EAD9683ACBDB2D6FB7BCDDF276CBDB1FF1DE2C6F2FF0F64EC71B74DBBD4A
      BBBCE77606FD9E55DC7730F7FF66FCDCDC90DAB9E5E7969F5B7EFE14F766F9F9
      BF0C3FEFB43075BEE75658E25D50D33B58BCBA6DF9F96D9FF19361EE5659B7CC
      DD3277CBDC9FC0DE2C732F30F72EA8E39ED7AF60EE1DB7DB6E7B83A635C45BDE
      6E79BBE5ED96B75BDEFE88F766797B91B7B75BAD5EB75369886FB97D17FE3CB0
      E96F96BB5BEE6EB9BBE5EE96BB3FE2BD59EE6E72F76EDBED0E5CAFD5AAE0EE03
      E4FC7DAF63CDF2D6CD6EF9B9E5E7969F3FC1BD597EFEAFC3CF3BDD56BB0D7BAF
      D2D607C0CB9B6EAF67E3E6ACB66EB575CBDD2D77B7DCFD11EFCD727793BBF7BA
      5EBB0BA75A618B77DD7EB7EB359B7DEB67B7BCDDF276CBDB2D6FB7BCFDF1EECD
      F2F6026FEF797DAFE5BA15F5E3A98C4DCB6B77ACE26E99BB65EE96B95BE66E99
      FB23DE9B65EE26731FF47A8341BBD3AF6A0EE335DBBD66BFDDB56E76EB66B7FC
      DCF273CBCF9FE0DE2C3FFF97E1E76ED3F37ACD4EBFD5AEF2B3B73BED7EA7D9F3
      2C43BFED437E32DCDD6AEB96BB5BEE6EB9FB13D89BE5EE25EEDE759B1DB75DD5
      F1ADD7EE7AAD76DB3277CBDC2D73B7CCDD3277CBDC1FF1DE2C732F32F7AEEB36
      9B1DAFCA16EFF63B5E77D019F4AC31DEB277CBDE2D7BB7ECDDB2F747BC37CBDE
      0BEC1D787BABD7E956C5C81F7B837EB7DFE9D96A3596B95BE66E99BB65EE96B9
      3FE2BD59E65E64EEAD56BFDB8507B633F7F6C0EDB79B83B68D91B7CCDD3277CB
      DC2D73B7CCFD11EFCD32F72273EFB5079DBEE75678DDDD0116ABEB776D4C9DE5
      EE96BB5BEE6EB9BBE5EE8F796F96BB17B9FBA0DD1E3407D7B8DD5DAFD3779BD6
      306FB9BBE5EE96BB5BEE6EB9FB23DE9BE5EE05EEEE79BD7EBBD96A57E4C3796E
      DB6BF5BB2D1B5367B9BBE5EE96BB5BEE6EB9FB63DE9BE5EE45EEDEED36DBA09A
      5758E68FFB5EABE7755A5DEB77B7DCDD7277CBDD2D77B7DCFD11EFCD72F72277
      1F74BD4EBFD9EF545BE67B03AF3FB01D5E2D7BB7ECDDB277CBDE2D7B7FCC7BB3
      ECBDC0DEB17B7BB3D7E9F7B6B3F77E1F94FB81D7B4517596B95BE66E99BB65EE
      96B93FE2BD59E65E64EEEDA6D76AF7BA1596F95EAFE9B93DCF86CC5BE66E99BB
      65EE96B95BE6FE98F766997B91B9775BFD41BFD5AB0C9907EED16AF57B3666DE
      B68DB11CDD7274CBD19FE2DE2C47FF57E2E89D41B3DF76BB551CBDDD1E78EE00
      58BAE5E8B77DCA4F86BD5B85DDB277CBDE2D7B7F027BB3ECBDC8DEFBDD5E0775
      F2EDECDDED7B6EAFDF1D0C2C77B7DCDD7277CBDD2D77B7DCFD11EFCD72F70277
      6F37E18F83BED7AC52DEBDAEE70D9A4DCBDE2D7BB7ECDDB277CBDE2D7B7FCC7B
      B3ECBDC8DEBBDDFEA0E3762B6ACBB7BC96DBEC745C1B4A6799BB65EE96B95BE6
      6E99FB23DE9B65EE45E6DE777BAD66AF55194AD769F7DA03B8D296BB5BEE6EB9
      BBE5EE96BB5BEEFE78F766B97B81BB775B5DB7D5737B1529EEC79EDB76DDAED7
      ED58CBBC65EF96BD5BF66ED9BB65EF8F786F96BD17D97B075573B7320FCEEBF6
      30ECAE5BC1DD9B39689AFBC2A516283CF8AF79520603C208F69064E1783E9C8E
      53D719FA5300459825FCC5D730FAAD7BCA8FFDD64F1BB7E87EDD166FC0FBF739
      39CDDEBF7297DED7EDF20652C0D7DCCF9BC837B8CBD657EE727F79E0967659B9
      47C2FDD22EDB5FB7CB1B480677BDCBB23C87BBEC7CDD2E4924D84F46B8C75DCA
      3D7637F6C8E26CED5DEE90171EC72E7B754F12717DEB2EF7971CEE7F97FDAFBB
      AF282894A4DA1A3244AFD919F4DD7EAFC2BBEFB63B3DF8AFDF6E3F01FB00AA33
      776621B86D31F136ED034F5AAAFF6AFBC02396EAEFDC3E701BD2DD0DF7F690F6
      81BBB659DD80F73F199BD50D38FE63A224D7DAACBEDA42F06829C90DB97BA7D7
      EEB7BCFEA0CABDEFF6DD4E0F56D3B4ECDDB277CBDE2D7BB7ECFD111010CBDE2D
      7BAFC7DEFBBD8EE7B62AFCFB9E37E8769BAD41D73277CBDC2D73B7CCDD32F747
      40402C73B7CCBD0E73EF77FBDDD6A0D9AC62EEA0D6B79AFDB6D5DC2D73B7CCDD
      3277CBDC1F0301B1CCDD32F73ACC7DD06AB6FAED815751F076E0B5BAFD41B3E3
      59E66E99BB65EE96B95BE6FE08088865EE96B9D762EEDD5EB3D969752BD3EE80
      B177617CD7EAEE96BD5BF66ED9BB65EF8F818058F66ED97B2DF6DEEF77FAC0E2
      2B42E68FDB9ED76CF65D6B99B7DCDD7277CBDD2D777F1404C47277CBDD6B71F7
      41ABD71E74FA15BD6A8E5B4DB7D31AF4AC69DE7277CBDD2D77B7DCFD511010CB
      DD2D77AFC1DDBDA6EBB65ACDDEA0CA34EFF6DC76174BEA58F66ED9BB65EF96BD
      5BF6FE18088865EF96BDD763EFAD5EA7E90E2AC2EA7A7D6FE0B59ADDBE65EE96
      B95BE66E99BB65EE8F808058E66E997B2DE6DEF69A9D667750D545DE6D61DC5D
      CFB3A5EA2C77B7DCDD7277CBDD1F0301B1DCDD72F75ADCBD03AA7967D0A9F2BB
      7B5EABDF6BF7AC5DDE3277CBDC2D73B7CCFD311010CBDC2D73AFC5DC07548776
      D0F9027FFF0B7D1B5F8824092602E608C59F85AFE428D71B74BD4EBFD9EF14FE
      3A8E57B0996198BA5FB60FD38573B60FF32A86E9C0BFEDC35A9ABB9506F67A5E
      DF6BB9AEB77D5CBBE275ED26C06BD02774DE32ACB37D58B7ED7607AED7AA5864
      B7E265BACAFFF661BDEDC33AAD56B3EFF6DC1E92B96DE3FADBC7E5969AEDC306
      5527A08A22549C77B3EA75CAEB5331AEEAA2B8CD260CEC362BA0E27A5547DE1A
      0C5CB8CE5537CC6D552D54A141C5B8AABBD2EA7606CD3E1C7DC5B88ACB92977F
      AE1857715DF22899AA83772B6E0C8EEB7731B7B5625CE58D51D27FC5B88A2BD3
      E9BA9EEB79FD2A54AFB83179866EC538B7EAE43DCFEB0002F62BF6E755111797
      488BE7BA15E32A6E8CDBF4BA6EB3E3B6ABC655DD189DA35431AEEAC6785EAFDF
      6EB6DAEDAA93F7AA488C3B68B707CD81574106BDAA1BA33B90578CABB831BDAE
      D7EE82A050B5C18A0B33E8F50683369C4405916F561D7CDE4BB562640591E900
      07EB0EDA55EFABB82F9D6EBBD5EA753B15BB6B555D9776B7DB1F74DC6ED5B8AA
      EBE27501962E10FBAA636F555D9826DC982630CD76C5B8AAEB82DB6B62FDDA8A
      7115D7A5DBE9C2E50429AA6258C56D715B6DCF03ACAD40A3D6A0F2D85BEDA6D7
      6AF7BA1523DB1514A6DDE980F4D2AE62B8ED2A9604D4135BF655F1F776157D69
      76919B75AAB0AF5D7561740BC1AA836F57F3A416882FAD5ED51B2B2E0C60AC3B
      687ABD0A16D8AE946054A9E38A7115F7C5EBB83D604855A7D76779341117D928
      74FEFC293A8FE2CBE86F5FE83AFC65B89C2DE97BFC300CE01F6F1864FE1245B6
      E63081FFD211FCE7E31D504F342B9EE0F7A4C10427A40FDD7EABE50207C2CF3D
      6F00E2679F3EC341BA5E7B30E05FBA1E087CC4C7160B3F9BFF98F0CF37719401
      CE2D46C9F9F701E806F2C3D90A5EB748177E18BE497CD01E1693205DBE125377
      B808DFFBC98C9E4DF4A78998FEAF31FCED32F1976F494B40430EDC85451065EF
      82053C12F9C91A3EE1850DA269FCE7D05F65F338715E87F04C9A89E4E54FF0A7
      7829123F83AF3FC3DFE0DBC8791DCD4291C09FC68900BD64315C272057F4878B
      1824E5C91A649979025A064C42CC1D8F60F3A1013E34C087E880E1FCD2208E10
      09C4045F8FD73A8AA74B7F26D24E937FB98C930988609D66877F1FCFFD24ED75
      41D4367EBF4C07CD5653CE190D5AEAC4AF16216C8ACE9C3EBACE3CCB96DF7EF3
      4D3A9E8B859F9E2C827112A7F1343B19C78B6FE2E934188B6FF095DF78204DD2
      A745F8E5CB70E903442E812B36BBFC790E54194E7801A00FC96A869F12FD29D3
      9F46F469B6CA00B64D6CF5958A718636C5CB60125F8EB3241C4EB368F4FBD017
      D164128F87199CF4F9022E77DAE4CFD338813B9205D1CC1D4EE228CE04E87593
      749D4EE1D6B800EA701D47178BB069FC15F4B7D9C4CF7C7873328559411F8C32
      98F0C20F03F85E0034DC613A8F2F97212896F3389CA01E09B77D16C589580457
      623286D951CF84FB7E218288465EE15B70187C00E483BBE1C2195C85B0BC782D
      22D895B85AA6F3248BE0EB156C1614D7F17012C11144E96832826F4993852DAD
      60DFB0B174EE0376C32DFB27EE7D325BD05D860F737AD0055D7432BB303EC3A3
      C18C2D94F897C26F735C9A4B03F0032AB6B01E3F9A0C2F0271790E8AB34B9FD2
      B11FC2741D40F3513249E6C29FC88FD338CE86E9325C67975110093C1AFD799E
      2D0059D2256C228CE6993FF91DB6355CA5A0838FFC301AC27FF005BC640843E0
      0D63F8ED927E810F49364B866104780D3B1730057CBA4C901E0DD3C85F66F10C
      4859108D4518C244617C390D4408183C81E987F0E072158DD13EE3A781AF6741
      9292C08A358D89C425CC98666BF8730A2F9925F125AC399E06192E344280676B
      803BD24FF83B2C36025A93A5C3A9C0C589505CC0D7E3AB74498A3CD088099CE1
      257E2FF04CFDE918100A57ED4FE9E115DCCB7038A727107019104D3F8127B3F1
      854FB0CA60B538689A2040F08B0B3FBB1A5D0DCF936899A491C886631FD0112E
      5C087074F0E604808D4B3F736059DCF2F22FC34BB8C8D345360D424024C76B03
      7D40F40762B44A44364FE22C83331D06E1345EF8633F1B87D16A490807EB7186
      88751347E11FD0F3485C358778F22259A3608D272F3FC242D22BFC00E08FE622
      11341A87E021A1E1846613531FAEF8180E9010D8211613C19FC20B40AE65B41A
      270BFC02AD3AF83BDB6DD063B08CE67E34434614655799EF9C303F5183917BE3
      7058EC8DC6B7E013B0C51B8D6DC3A7B0FE9B0F8BA33BF5DF3C721A5FAAA6E912
      006A2FE3BAA97A3451BD83B86E9EFE6D2D6850674178E5B7CE04CC27015A15FA
      41E4C8BB3DFC037026974F406E048A4DFF8E10F581CCFBFC13180EDC621C81F2
      81BCBE4050967EB89CFBF8215A2D86537A7A18AFE8C29321B139045AB74A3320
      B5F30C5E13917D50894630A16F0A3A4EB9C125FC079A345035D81928189D42C3
      4BB4BBE25FF18F689EA20F5301CF81AC1DC353FEB4E57680EBCE03E397C948FF
      D2198E112B695CB434A6889638091C49613923B5A276BFD87873349CB6DB43FC
      7E0860990FCF41900026DAEA020D4C0B821C4A1CC50DCBB5C1F8C2C268FDF0AD
      F3CBDCCF5EA40E506707CEEDEAF524C89CF649F3C4FD8FE7CFF0AA0381E293BD
      BF3375F73BD32A28B6BADBA108602328EE841D6C7F17F4BE5FCDA62090A41252
      AC1890D93B47064DE7AF6FAE2A1DBBBB4F545DBDE29268A5D396337C31EA0D81
      417ED9726A055771EDE32BD9E0716C8D030DD3EDC788C3EB1DA4C4CE76094E74
      865EFB16AEFEF367FF6FD7ED3BC74EEBA4E5802446F7BEE94CFD2074B2D8592D
      511A751250E240CC772EE7A06A8C910402EA39281F3A6F5FA54E032413FF3C75
      70D3C78960C7063C71E42C048A8BB3C3477837768206003300C0BC4C539164A0
      0711504098612824AB08E98FF3E9F58FEF5E9EBE76DE7F7CF5FA9DF3E6EDBBD7
      CE8797EF5F3BE9380996D953DC772311CB38C9C4C4813DBF0A523CFA4300844F
      F121F83D3F80BB8FA78E88C6F1043F93C2E12CF0A6C31329E005525390D16AD0
      9050A4A913C6F192EEE038F1D3F97F27D08D404DFC06D0E512A9D1220651DF19
      81C61947A933891D10B91DD064CF115CDDF628F86F756BDE89195C01E70DD28A
      B11F39A8F90159712E836CEE349D34F8A77056205F254E1A2F84035A2D705FC0
      B654B3DEFF1660F8F5CD879F7F733E9FBEF9094FF9ED87371F1112AB70E28C60
      D3A051C2888337E46D767E5A1E3CCDADD7E03615D0F9FCFAACF3CDD9D9EBDF9C
      831F437F2D927F44F1657A905F07C0139112A6F8E3B15866CE2F1F3FFEE820FB
      5C08D00B1FA3F071736A91C4E7C061BE9465018F6481E6867CDEAEBD72B5A2D6
      D615B59C9351EA6FBCF6AE45906F1E64A3BE77EF1B65BE06D7389B0B60763E71
      4DB2EAFA13E4A428283AB3E002BF064A29F92970467F26FE7B51C34F020DA8CE
      DBCFEF151524CC5E2EC3354A9D41F4BB1867A286DC3051A2E95384CEF36755F0
      397815F8613C733EC7CB607C4032D1C12F71124EC8D07AE0FC3D8957CB94F829
      B08F0B91AC9D143907C08E0DAA5F77B79DDB87A674ACE4D0945FD457E56EB6A3
      EAF7DEFC74CE48B4274604522BC0FCF399F0610D9FC4D8095245BE9530775B0B
      BFBBB3F97A35FBFEB5D6C63406A9D119AD9D099A4BD02186478394F5E7400026
      F8233C8B2002E901A4ABB57311A4C128142477C62B383D49399CB94F047724E0
      CC521122E199E0E1E15411FC6DE693FC912542A06FE211827F3719DE0EAC0559
      2977C35A69FF5255815F12B4B7AF1DF20B00A0FC0CA1B546500AC70F13E06740
      9008270096A0F700B4C7F300C8FC0C09D7530461E58D0BA67453A6F118B4BAC9
      B61B03409B08BC8CC8F38096AC3258A1A051E3158032CAF4E5C427D32327C8F0
      7184753A4E62D20D8208E80CCD86469605BC019586F55304E55640EE1C75EC8C
      4592E18D65CB4ACA1AE4973F0104BBA5C7DB941DE13EDFBFE888B691D4014C2A
      BE1A3D8E77BEE1B19F8AFBDF719AF99958A05B5CDA94C826F95087FE36CAC44C
      24C034FE580589F84A01EB462C4F2A04245738B995C87A262A61F6A3BFFED10F
      3714E9BDD7505B661C7DF5ABBE66BB6451BCC75BF135F7E06BF1A58E5F6AED2C
      E3E52A04684CC40294A2231043E49560EB2B082C290B7EFE64222595A58897A1
      146A96899802CE03E75DF8E720D9801E208EE3E91424A18879BCA1BDC3A809B9
      45E0EB1F7D60FE7174F2B851545DEB5B428F4D1DABC6217D1057ABF47D0CD225
      2AB97F0FB21F5623651BBF2DBCADD4A11E0D92549CC4D7EAB835E0FF0BFAB27C
      727D4B5F1F489EFE05B05A8C2F3A6229D55FD2658F59D4BDEEC8803F872148AE
      97689718C520F1E33364DFC7DB3939B9236DF8BE316CCF908B9A410EB0993B0D
      73D8F9848A83D8F9602950A2F91F8F9BD23D06614406997CD0268447437D1E8E
      45BF740E72B01C005B1DAF50E2CFF93245330BA622409828767642EAB0D6A1C5
      1568DF412814B3DDF9D2B7A45D17D468F24A46C8B997493C4BFC8543B15F2728
      438CE7627C8E7C1D5F76F02A8E5E64D2891965A090503484981CF073A3F82A57
      DF41698B5067D0934F57180CC973A7723CCE0A30A821FF4B3015A1245FEF3446
      62ECA35F9991F212FEC4F47C72F8505288773BB8E9F5B6E3A6D7BB3DDCFC8CCC
      0EF9DB290755A716453568E07E7EFE78AA24666918CDE2A5138A29190323B8E2
      5234C891991DFE0D3F4C638E97815B7B9E1B568D0701F687CA9341263410B709
      BF40189F2392FB9BC7A3AF741DCFE16D9A015EC52B5CCA69188CCFEFDF2442E6
      9F7B377DBC0698DFBFC5EBF9337557F0F69158C9C650FA4E1BEA39423C378FD6
      E602BF04936CAEEE2DBE027902A1225CB69DA3D98F0057335D8601A68ED47EEF
      199AB59C86B2F8C291467176480CEE72CB9230B983D95F22D22C4EE01742277C
      84500C5105563EF3830753379F10A167479DA5EEB900C66E1A47A0D450328700
      4A956835BAD6F2BB7EEFD4F7E5BBCFCE5F9DB30722BCF76E773FFDFCE91DECF7
      CDFDEF97BC5992D0EAEBF160C7FEA6F510DC4793597293A26F0DE9B1F2F39D0B
      B14C257428163A891705971EFC4CD19C18A714BFF660C07B30EEADE16752987D
      20A840A75CAC721E3A09A45489C09311685E925AD01122AAD4AED0964BA3F0D7
      AA2968DC6E663FB19C752790FEFF385E58BE9AF3D57FC6789D313F780420D993
      B3D682B6529A301158460948EFE83D9318C9A79A47CE5F09038F6B911B0AE8AC
      0BF247EE49790CF6C59FDEA2AEBE10D676A141C2B630F446A4AB2586F2A5E8EA
      A0EC2454B3462B0C4902E6AE4177823FD70AB1FC71165C90F951005EA123709E
      C4ABD99C2D8134E200661E390B11AD94B69AAED34C2CF8AB4600B8598757C65B
      AD2A874A172409E4328826F12521D845E0D3F76ADD1CEDC6737C245F4D5A9B92
      7CBE7E1E34885E041381905B261CCF144F8B3A788663EB9B5F01B671C640E4B7
      12AC50C52DEF89DD4F343DBC1F2DA7026F55A6E2A1DE515C4863E227E7783AC8
      D5E31A116D210E83019895830169D184F5EF57308FD3507F55D3C9D9CD877945
      FB8018372043471C00E6399E34E6D02B11073603174E4468E89AD02D74E2A5FA
      0B035AC10144A879005C24978BF8C6C9E93962068185F1630B9159D259EF801C
      FF12A01661482FCA8E80B9D33018232E86F12AB144B54854C9C171C930ABA30E
      489AA1B52302AA43655E043A2FD06922C5F5688220667297CA2729F48D34044C
      8CB85AC2C9041881AA69101D21A0715A4114BE1AE7D940178625C711BA5C16F1
      249806E88491F37CC3E30F793E1C5903AEA39D4FE8D568A08CFC94A3D309B6F2
      CB7429C6BC9E1229C76B9D06B308168E0A97BEE11869B74A2D9DD87900329771
      0B79B04257AEFA645A96A135965C4466743E51100555E960BAC4F961F46C16CA
      4C293295076190AD710EFD7C16C7A1A41272903485038ED62048C07AD9020F6C
      78147038572A7D4C7CB29FE7B0C406A1301F321301FDF797F0A2C6A88C9487F5
      3D10F3206417767EAF1608967829A2A352AEBD19638E4588146E333865A4F991
      941633B6A8D0738DC27EBE31577FA82691EF97C0CC6D349624EC3CC41F763E01
      7B387EF5E35B6695964CE418581024A6A13FC3380660E03F1420662A06325710
      2EAB48386C030B85190929B9CD91FE30050D0E23A6D1CC98A124FDEF0E80F5FF
      53D75E8918F0472C6600DADF4B872A1282B4B0083219E199722CA8440E150B37
      02F8D1D2286B3D26F5102E6F51FAC65530A7E505D6008BDC03A05FC6E650A5FA
      587CAC75AD0E7EF017A3553213C981F31EF44A8B7046AC95860D81E6A0220A5A
      1A272B423C0C5BC409B348390B722DB41290364F86C88694F6C3F5A1E45F58DE
      804A85440027917EFB08D3971EBC64D0769BFF232A19F42E46B2F64F228F8FF0
      0077AEFFEFFE42BC0B2250FB8229DAB452B88D4FB240D1997F219EE2BAA53E6A
      49B302C8FB389156D020130B297010D38F228149E67E128074D3F88EA48A8900
      4ABBBB32824C45A132B15719C9FA93603A15D2FE42DFD24B53A0E96B10AA3299
      A04AF41FD3550DAB3647AE5AF96327D85F9FBD53CE067BBF37FD30D31589EDCA
      1B83570B2186D2BFBE6AA815CBB0BE06482697A8C5FAFCEC89484307EE2D481A
      81B615040B6D0EF4C34B7F4D027D71EEFA4AB91A81BAC8229EACD0084166BFDD
      E6B9E7CFB8AA8BF24EF8CE01D9030FB03647961B10294B1E56172414C18705F4
      16FE72A9865164DFEBABAB2B878A7D9C38AFAF7C526EC2E09CCD0533ECF623D0
      2E20A408B6103EC85EB936A58D1B301FBD6EB5C48F5EA7E51CE0111CE8BD359A
      4DFCCB9B576CDC6837075DBD6CFDCC9BD74DF9D8EB376FDE1CAA5DFAD2648BCB
      C98205F0A2BDBC4EFAE0F3D24E409EC6194DEFC4095D005A8A5E093AE6E8AF23
      2C512DE83AA93F1EC9DB93A44022835990A54A6465281341FDF0F133557E0803
      0A2986DB82DB9A6009A90580D37CB51FAD17F08EFA574746DEE311A3A70CC92C
      DEE594EDD623810499C339493A469534BFFB53AEA0A03447AEAF5CE3CAD12937
      909CA35C8E695CBA562305A846CEC71116D379FBEA88D8CA0B597DC8CFA11444
      06948E4047FE1F74C8FABE82164ED90B79C5A25CE1DE822E7BA19AA40455A10C
      D9656CD4F8FAF6FE431B8EDF52C17558EAEDC734EC0EC323F0D395F4F37BCE54
      826E3ED2152C17816B0C768B04B322BD55869512517D806A5CC73FA6623589EB
      42F9B603D50A5046F030F6116A1580CEC448421D315C5793A9015849AAB1D063
      CA83D18F80B45C0A7CB2BC0AD16B1337247E9A54DFCA61BBCEF50D16E98783E9
      75AD3856059B9D0F02F01658BB465267199E80955B4089F017CA2F811978801D
      F71F17FCB1D7459E7B020BD89217731F51E1145D4A4C317BA0E0BBE369DCEB3E
      C4EE4124D7ACB936CF479F99125088D0213944F8014651AD2E0C5D723E095253
      C78243B408BEA9C263950D4AC2AE29E8B26E4184FC8CC4AFF55970053478C127
      C37FE698AF44BD20D5145C24BBCB97C6497DE9669300E17A73D70517C992F2FE
      3206FE22D5FE681D83209A1787F5E5F630D220202F4618C7E7287C6FD925BE71
      B11ACFD9538ADEC3B1203E53282649D114B21865ED0D7D0F5363F440300D801E
      C04217D8D7095F44B58B391A3BE58348C81F92E099B2CA226BAD19A7ECEC4E79
      C553C6C60BC1742D4DCFD19A44DC03D939EAC0B9F0C395E29F749F723BB66592
      3B01ACF16C8289CEA73EB98D2D9FDC0E1E6CC7858D9EA453906B5C90778FBAE3
      80F24AF145F41551190EE3E31A79AC08C6518817986D6C23C40A1982CA7AEAE9
      A753ED6521B113D1148BA202C2D16B39CDA13ECAC206D879482F4E77639C34FF
      F19A615540A4389400E34D139162232A5C222AC6887491D369363541370D3831
      A17F817E673E51FA7CAC073A301678DE2F5855D23007EBA372C4072D541F55E9
      9C18C2B01C365A1C31F3902B3BC24F66E21BE9E7F5B9597AED1DD9CD43290086
      6D56C5B0325EB5CA6119FE89C2FFF0CBF36744E809C0D232665A3D38D585EF21
      8057D67341E12DE3F24553A09D20B5AD32B4968CB00826B06345AD65DE0C1BBB
      72B6837C4A9DACBCE9855D46373A44132B943DCCD0414FE03CF9113CAD5A2186
      323996AA0A12D1C1A51DBCF2335F418F089C3860B4F4C7D9CA0F39E19CDF041A
      DF9CC40CAAD62077AC1926DCB61B6C5086E656593780FD8A07B66FBC8235115C
      1EC2BEF11D69DA216C1EAEFC2448F1CEA54437C692EE3C2040DE01BDD892F479
      E772F577585DEC85B4829A78927B2B19799156D1974A06BE6D60192C7237B8D0
      1979FF89AA0A58040B1358921B2BF69320277C08CBD6E9B7C33F91B20CEFBF48
      320087689AD41D286A358790958E777A6561A6E018E51EF276E8BB842C49D9C2
      4116AA9400AC206D32C4651253B9F4D8100AA55416D4B0D262A7A54A516BB24A
      C8B9C2A9BED20526127C80A3E01778945CD6114F33CD9D1B1C28483E46C5938D
      0CB1D31F7FC2F0276194C493665C6A65936BC3285E2F51B05F2D7919E8700B16
      D6525B232ECD5070F058A4EA03CA50CBB3E854854E0C1EA92D9A3AE274774072
      287239D7CFA3F595EA6988BCC55749B7AF7689A83924FA995D4D48C9AAACA16F
      B1627796E402132F01DAD82C7385FA2E35468B2702BB6F5B9FC6660815510DE9
      7057B51FB4C598DD6CA423CAD00BDC4B34332DB22F3F9CBD751A687C1DAD416F
      060652C77B888B056512B3BDE4949243C87CCC54F7475061E0F9293630EE839B
      4F649782D33D78B254391161A5B41A36741E22D25124B8F32326E3C6ABD4915D
      DA89B37208C21C1407EA094361ECB07B6580A64E0CD4B5840D3106C8D803194C
      509846695107761054F48A651C8ED46B5F7EA8537269F75DCFE7973428C41053
      F9963DE32F8CB28B181844197AA5451B1B624D4A5571A64765FADC58373694F9
      A0B2FBC038F4537C0C56AACE7B0FBB0040561AF11CEA22AE73199571800CF7A1
      324CC855A66CB5A222D4B4CB1768AEC2C625984489DD8997825A1463A8C9CE65
      7095150283B24F6C05FFC7335BF6A4463937E27DF256587A6CDC75CCDDC174F7
      3CE8740375504648C4CC47EB31DA9DE53DB479015BF2025A8F3D2FE0F9B3BF33
      2FD5A77B2C491E5E03E9A9A32046326047C8928FF21E30680BA4F4A9230CB611
      4904134579740C45C6C1B3896E96A37CA7D42FF2E4115E999D10FBF9FDCB57B5
      72551304501630EE64EBA5902026075192F8EB1CA734D0C9E723AE001A886567
      E7EB2458B0EDC2478F3D573AA1A21AF2B4A4055D59BE73E9403149C747236D16
      4414FA97E335455162D65A2C1D0905B6F8A44E44E6B6A0CCB4E50E6F420A5D16
      74532B6D8B00853B32559FC8E53C40794012192FB97580BC2841CA620302EF49
      1EFDF3679F133F4A013BC8F555EFFC4B98224995A4494A9CA2C83DEE6134E33C
      D45488130CB8753E8EC200A4B8E848C78BB458D653BF526D30E0901CDE5C5807
      BC5184C0388D72180BAC3B4149B4290681C80582C858279238DB12A5C1AB3488
      478465CA8E3841848A3B03350857541F285AAB1B6000D06928A0C92C5AF62E16
      21B81B8BEE1E87EE3F806A17161DAAB880FC6FDCFF183D97E17A13DDACD8E994
      2510C3C16EA0C96AB76B5EE44A91EB753CA741FAD2B1F3CECFB07FF7A1610686
      EB1C835C927051A6557A177ECB3AAEB8F1F2581A33BEFD37B5F87FBF7FE67049
      92FF0300E021378DBD29B846DC036C7C954DFB0F5213D9CF91847D2627D85C43
      77744E1644A7586A1FA1F8CEB98C14F6285146102BA96D422189D91087A940C4
      067E4BEE026CF0A7CF6FFA275219ADC303A96D87CC0A2AAE904257CB06C5FCD5
      B2405B9A0B091CE2850BE02016608F2C1F6B985D129C1291CA68158AD1AC0F8B
      4D5995A041F63DF4579AB5A1B41539A2642D4E045AA2BB4CCA28C88CE86FF2F7
      7F3D4E6C8D5DBB6F9CBC45D6CE958779C7BBBD044A7E6EA0F876F69A53EBE270
      C282B45917A380A68CCF2893CF2244736B15DB62156B3F76AB18BC7F148C4172
      0431B2FB084F70E70630100FF9DA31F1B227B9837F0A5086E9049A4F71FD133F
      0A52B901EF296E4044B3F069EF601A444FFC0CA6183AF594373013A04F444F79
      038910E7BCFED6535CFF7C15CDFC245067F0244929080561F0A46FD1EFFED27F
      E2FC388A934B317BDAC7B08C738EF6243101ED18ABD98A6FD2533D856495A6FA
      1EB94F7107A0D73C71C122BD1493A7BD836C959CEB1DB4AD6DC3B06D386767AF
      AD91E26B8D149DC76EA4D8AAA0590C200C509EF876C12FDFEB1EEDB6FB59BCF9
      3ABCE93E7EBCB97F9479A2BE8357145442C5D0A5FB0BA3AA354E501E39976127
      778CA5413A3A7EA3D00D15B39F1B110A142C4EC1FD12A0355C9D987E80B55460
      948A5EE0420F2A7D5EF7E344C475FC113C7588E9F5D4ED66AD127E0A87E63464
      5251EA1CFC447110853F7F7BB02DAD1E5D94943257BFD222FB7331FC42151847
      B72D360830121DD06BCB918B9BEB54611B4B11711492CFAD7AB047298211FDB5
      F7EF02FD75BC8C2F6AF8FBD92DFDDBFDBBFC5331E63A24B23F1E958BC7B242AA
      01922C511AE8CAEED7E06F8EA3D9D5C0EDC2BF6EBFE5C10FAFD7EEC38F56B7DB
      861FED4EBF093F3AED013ED26DBBF848AFE5E1237DAFDDE6D1F80810821E4DD3
      1C0CF021D71D34F129D783E7F067ABD7A6E7DADD4EF76E09C3F3FB680F4DD745
      DE8532E6545E1D16F4BEC39091BA63CEB187451C7DD785FF59B26C2661E69DB6
      28BADD59C0821131EE9D72D48E00BAE5021EC47260EF81919AD8E0AACCF70E03
      BC9E9530D888C2BECDD0AFE8457624C35B81F3E1ADE52E753ED636D98BAB1937
      2A8F12A2A6735C191983884023180B19656704600137DC1DE52B9200734A89B5
      2BD1CBC6BDD4915D49245220B354B0987349F227563CE770382541C23707AF99
      E11C380DF87840829956A8A95D63AE014C29BCD90CE3D3C8A03B1C2E1694C182
      65051F2ED036FCF6DFD4AAEF3FD4F444F68DE3FA976946E5C60DE58093778116
      A59741469DF4CC40462312301535CE376489EFC82C6E4E31D55926164B3AE299
      286637EB176805E2DE59C1BF6174E6BF9F80BEF9100C8153A6F4EE031535E79C
      8B3521409EF4A12A45A71BCF503605266A71A4A925D2FB87C35A2A5DA4D215DD
      6BB7562620DB4C19A0AAE6B96AB29793EE54521B6E0A91AC22AC7D2329B44E28
      972DA30ABD67F6128EA6B066ECB7B97D75A8C6AF22D9BF4F05AA3A810ED2E650
      F0063934DE7C6CCB34AB8FBDAE7A60B5DBD525E3B925826654A24E5C8D055042
      A9599D1CEEB3A302BC397C9CB38236F34AA80AC438117E26EB712208C998A1EB
      1651BD060AE296651AFEE582B8737BCF9EFD0C6E1308CF9F9DE49AF903A4A270
      318B13479CCC4E1E62F71CEDFC7FA4E4F790B0E0529F8424322945354AF11DA4
      4D618DA4109235358A4D441A24867656BF1CF876827A297B0007A92998658CE3
      A4F33126633EA61F3AE3791C8C2947E38194ECED39C7F753185316764C842CB2
      ACADDE395C8D564079721E175CB92967B2125735072BE74BEF8EFCB252D935E0
      E33B9DB372B3EAD216DA81AC6E7B92172570F38D5F26F12CF117B23662432629
      DE996A56274D73B7727697398B8534E0DA16845BAE0AFBA01684E7CF0E891D71
      0AA3ECA4C64CFB28BF7CE4F5C3A27FA5A805A30A5D8A17B306034DA967073A10
      B95221A8B3CEA9D9D85EBF239B27F16A36BF9E32CBDABEAAD659CA775BC8829E
      657006D54A7F709B508DE2EC219A5731732BBA834BEC3133E94C03A906DAD98C
      320337A863B6C5F79C6DAB9E2159F02C8C47A4709228B83B4A9B349E069EED32
      09E224C87864D98025AD5387063F7F086C1E2F1F34E13EAE99747EEBBB3EA623
      7FD0BD172CC24B55497F6B0D827BF1C93EC61A04F7B2F1C75483E001B60FD8F0
      10D4BFD0150B89309AC72E51B0562D0C831088E7D103F45150E4E1B6C15243B0
      A67829EA0893ECD1CCC5E46A35080F3036D539A568A8C332D6583C5695ED0111
      1DDBD0AC4DE3DDBF9A4D6A879D922175C4E14313918E9360A445C6E9C3F0B707
      AEAEB68FF9EE7637FE2AF16771348A93E80EAFCC1E0D03A93458165C88705D33
      E4BA6855AF124BB98157D1C44EC1154A942485E341EA182DBFBD82FF3D800891
      C60BC1B2930CD464645C920ED6D86CD07E58EC5776CD7DBDBB328808AA07103C
      59B17900FC7C38492B5A9763BD58E23ADA41ABEEEEEC31F4FE01BC0AB9018478
      5A887D4DA8A35D5BF554A748C055AD100B18CE3D139AE92E40DE9DD6B2FCB639
      68356F9DE20099B766F4DD810B334744B0525B57A9E4EFD7A953123C4E24FCA4
      A25F09A51260CF0C0C74329B038114297DC264AADADA4FC3C6ABDF0395E18C10
      05FF6F55F276DD30741E3E2B14F8D43D1ABEE52A9D1B653AF79B7C5356DC39B0
      B404375FC2E93A09C23018EFB906AA70B8B1BB6EA7D9749DC64F9FDF1CF70F2D
      955054E2170C457A244EF0FB316DE44E70D5CF565336755B369A980265B4F4ED
      1EF2719ACD6F9BCDDF9CEFFDF1F92C8957C05FB087A848BE757E95313192E49D
      9C7DFEF4F6C3DFCF7E93385F9784588C678C7F00039AB285EC7CB0AEB1E49633
      71028A7F14143274E4508720D5C8888BF0C6599E646EA9C01D5281DC7EA643E0
      2AD0DD69501C86B2B11D5A367F3DD24B833ABA851F90023C108273E404A5D904
      84E18EEAC0C05D1BF26E0A96DDDF1FBB6F6F67F7860D5DA48BDF9C37683295ED
      331BA79F76CE7DDAF2BE7D3978D36F7DFFE64D6DFD619F05DD8410DDEA02CE28
      1E4D360586255862574DEC1EC41EF89FF0BF5BB707D6D87E9EF407E48CE418C3
      0761E9DE23A07B3B9F0032E07ADBC9C0E9F2A324329F459A01295856D022A298
      3F9093C979955F800794919E68236104BD837892002D8926A1A5B5252B73B809
      20A2BA236CC89B88CB24C8326CCD1B63367F264097A20B0A57D2C7FC5A3423EB
      8E27D8CFD5A7EE788B009B79105DCA3BB59AFDC00486BFEE4ED8E75CB3CDD623
      B51DE86786167844B37D7E7DD6C61438D569ECC3CF260CB08E80592680BCBD5C
      F3873ADACB96603049E79BB3B3D7328BAE9D8794CB696EDF2E57C375BE0C5700
      D5F424BB7A8860DC1C32AA08C62416DCB44BE51D05115C0F006EDE445D323963
      E587BA93BA84251EDAE6400EFD0A05F6CC5487F5007145B84E5AE65D007DAFF4
      2AE3361EA9E66A2AE4E8FEB54590721F444D04003CC466C387D8AC4EF22C3482
      CA30CE8EDB3F21E195D13CAFCFDE3BD3D0A79264329139984A71721170477423
      C065AFB0C102F9BC5125C73B3E20F7E4711474EC7D6D41C7AFBDC97FEE76E801
      771D7EB9167D6F5C3BE211DE0C4FDE8CFBE7D53F2D2780A6B5E9E4AD128E6364
      16B75071B57D1BAB699DD42B53FD710A625CE087CEAB77A748AAE045130C6050
      A4E7D8E4808FF0AAB5EFE6AA0DFFAC71D918ABFFCFCF9F1EECBE9103F0E74F85
      22C26DE7E74F8FE516766ADEC2538A628F23E734DC5D306324E5B0DDB7F5B180
      A15B130C4A9CC0C472DAE363D940AFE606A2383AAEDA84B50C386FA7CE644541
      3828DCE14F50DE0DA58D0A0CF04D369B3773EAA5B4F4A3DEC67A601C09AE934A
      35BFFF58510D89859F66799A88EAEE1C027E4DD66674070BA5F930A353343C53
      432FC5C34DD24CB62C46DA73996E3F7FD9B474B90A435E3FE51205117CAD64E8
      114C7CFE50C5119E90DD0D1BB7BFE7A3D289AACE04D8776C6B20946A5E96C143
      88A370ADA1138CE573984055348560B13B72275139353FC18A74EA6F12897DAE
      6ECD28971E3907E378B9460DF1E4E484EEF7010DAE814C69B00842383C6C414C
      8C303DCCCD858691505B0E6B6B925CE81B8D889CCEECA3262B2E02B8484C4524
      E6AEE31557011725C2C09BDBB38A362ACEE3385C2D22863B19DE3F12616BCC02
      AD3E935D13DEE5A7704EB25A15D61D0CE8E0A4E24CF4F0F0483347FCF48EB5EE
      C6B468A181A7D032BD5B74924B213368E1D8B98DEA9B3859BC7DE5FC98886970
      B597D27E1170CD447553644607D041802280531E424445C1652E1A851ECB43A9
      FDB2F7F205648C52A6067958047E0ED6A33FD7134D27022FD9E4364554A411E7
      E25816607828CB159CC18B8C6BF688F1F91EC99B6F0AF4411D297333C54AE59C
      FAAF542E6277CD9A85AE1742139031BE8C73AAF03D9DE1AF27BFA9225C2834FC
      FA9FBFD5AF01FC5F80DB64CA52A5FEFD0B8E54271313E64C4E30B53515598A73
      97B654FB35AFE215BEE01476768E82C96996847F7D1D51EA3C4285771A47B0E9
      4C53E85CF6A0FAF8854282E33096956B988633243EFEA3F68AC8EBAD49FDC16E
      35A44CBF41541270547E2674B600D14B4D2EC90FB22E54F1CA8BC4E18EB0C616
      AAD740BDBED1748B0A7BA7B2B902F64BD8CB3858DAD5B64523194D04FA875283
      13022348C4426076558E0556DAAAB68D9077180EEFC5998621B28654A1AA338F
      4312014E3F7F7A47A731211CA891E98748F2C28A6C3A2397D020E69CD07DC12D
      A1994B4CD443E24455D826923DF5C3740F1463170F6A63BC2496128EF8CDAA22
      FF5C841358C225CB2E05F2C74CC21F6315CF3C98E4BD4C49879FCEDF81272ED9
      59DA806D01AF5C87E250D615D4FBC78CA307ABD3FB8450F5CD0A1946B0C85D97
      27B3790CC7243DDC16D374A229C3254FF9509E2D38F164CD79DA0D597E56CAC7
      2B2081742FF13EA72955580F28EA600D9C7982D2D5DC9782AC9C5E33C1FA8ACA
      14792126D8A99751BF1C63B93069906647E66BE86B8C529FC1C83D24BBD7BC3F
      8996240FB188C1B3FFF4563AD9774E146724685FBB758BB6D7085CA66A1B2728
      76027124DA985ADCDDA2F449D0A0C9CD9902E2AE1259995F333FB8D45CC54EF6
      EE8A51D90E16B28C313E368B29F808F1DD09832C4364C36F4CAD7B093AC81E9A
      2FAC07A623A9378B335D956D0EC04E15EB2B9EEA516E3E89D62C04E37676BE2B
      E10A819702EB8EA73239975BC0F15D42EC053958CCD89242605055728E48EF66
      151CF5ACC8A772817A71F52B88E8317C1497FE1A797E86AB62E8D3A18C454211
      3A0D348C5E0611F6AA3BD421D1A46DF932E454990AE6B24EDD488C7D5DB8931A
      3228DB8204748AE4385E45998EE6A2322554BAAF4605C5E7CFA455F8F0C4F97E
      8DAF25B0D046A866B87E0DD1F928A69B04BA1CC00714B460894A51404514A720
      F264A0FF64526861C392DC8F6AE381FA88C0C5A220268D3C17A80451DCDB9C53
      B257CB9B9C00155E41F685BB60884958E75D2AA4712906DC0E50A497767286FD
      1E2F052519DE281BE590D28E1594010635008E604A9955CA38C0340E31260E6B
      C460DC9F2C8589F396C134D7D564724C22AD9AD80F1A9416CB0C8EC9BF08667C
      EFB59D8F2B5B62AAC79A2D80076FC81C450A2C8E5647981E9C1892AF2CA34446
      501CB78C01AB34D6A2F301911694776AD212317796EDF91044381110E417A974
      72A47532516B4091760DA0C366304194DB13F42E1C421C822A7E8F0B268050A0
      2420A5B16CDA3E9F6784759CE9CE5C071EA2740BFF1CFD35195350E1A76BE951
      0138100329C5DA1D31FD11CA8E8CE61679DC59AC6E417E93E85DAC194CF1AEC2
      FEFC1952119AA506146BE89F113B12E445825510E610F623392EDD3E5BB6BAAE
      678609D259C9F960259882ED8AE297F3387E32A5528CB062E147D22C5609509D
      8D2E3132FF965052B953A48731D25EB37473264433148A16319726A6C0592959
      ED57BD365F842EA09D7B5B8E9C3426AB2132AB49808D5100AFC5D55275EB09A2
      4900920CEA5A05C4941E9920E172C551567F51FF255F3795F4CCF033E0CCE438
      06EA1560F47940DA96CAEED54BD88733AE81A32ED8A9C61192CAC44CDC43DA97
      91B15CF8703AA3D03689DB8D2FAF2304D437AF82948CF708D14F228C778EF30D
      3DCA529F62354EA3E8B7AC71FF336184420DA4066CF623049C48D86399773A8D
      1CB247A62602FAD82AD2563B60E7EAEAA33897A3B44CEDB82C68451BEE6AE6F8
      16416A468E993A9CBDEE9BBEF8EC3276388C3D96B2A8694B6024D839DD4F6F6B
      7383E7CFB8474E9252F80148E2B91FD5D3414B85C827B14D77D1CDEC22A31AFB
      C16971072727270739EE05AAAB638EE647F84664403405B925DFE7591CDB54A6
      693C4615424A17ECBDE497960413784D2AD51E998705EFA97134E49A0BD76527
      289307EC204E4904519148BCA646E2FBB57E05FD16BD9029AB38611C9F1349CA
      0CBAE78F1818F06508E240E6B4A45A9C6A934343AACB7FC5D353D68BC3934A82
      CA853C15482E36C8AB7FFD211E2913420D483E7F06120EA5EEA287DFA71833D4
      A7CBC72D7B2295897D90960E5B5F243A75BA7AAC62ABC0AB0D0932941700E9BC
      0E1220EB4F8C3EE3D12A13B91D4241568AA6B2D73C2F0ACF9E2D0B4A50649779
      5E0B554E2C530347549DBE068CB21AA538A7ACF59BB7FBC47949A603544A8364
      A1F04F39BAF5952DA204C16D24B4CEAB04DCD235D6CFE16D7F3877F413627525
      005A3E6712BAF2ED429C650396EA3953C020648A68C854246A6F7DE7031B91CC
      202FF23A2BDA532BE80F10EA6D948A243BD1FAA99C6B11A35D10B6434EEECB68
      83A401293E5D2529FCF9A7A5F38DFAFC8A54E2D34FA7A545A1654A978E37663A
      9B07D3ECAFBC06D582D3CF8C6860C59F888592694B3E1C4C39FE782A03F9240D
      A45707D3AA694EC882CA9F6FC51C285F81D1469F4ED59E65245B61A7AFE8BB7D
      BC916678356DAB185E20AD9EAACABC0EA9C67548A88C77BE86A97FA822B3D576
      28C0604199E03990535E069C04F607B80CA46F2007B291A2C84988973E769167
      D53BAAEFCD79EDC37B0B6591B82233AE03C3976E968C58C2FFDA8938B42C5863
      71B1B48769CB19BE18F51E471662FF6BB310EF3E955CC7331D3B2F0D59E5C3C7
      CF3A605FABBEE82291612EF2FEE8005D4D6A39C885AA779F3CC22BB19B6F7054
      F7B1F3B12C9DA95C0C890505D7DC93DCEAF36767F12A190B3CFAB2305ADE2DAB
      3BDAF9987B2B8BBD366490345F02E99E22679E29071BF74A429B1B2B19DDDBE8
      D572756A256576FCA4600D801931388E9DB7354E665A80BE4AC19145584D3773
      103D5D5C7BFEEC2DC5E838EF3E2258A69497246F87C13D4D06A8A3ACF3389D85
      AA0482CD2BF9126D5C9992D96319A7ACC3AAAB6804DF724357CA53F8F64679D4
      25A87A7B66B57ADB80051AF64E8EE6B6DB37676934B8264F0BC28B8A78229AE5
      D1B0B6975CA5E1B85C39A1D0490483BA76E72CD0CD5C60404C822611A066B781
      70B77A356A0004D0E27B4CAA0390203D463B9518AF0A194E97DAD54F41E9186A
      0AB21E8D02393D5AEBC07C9DA542697A65E494BD3EFD7C8044D7D1E64C53E587
      DA3A930C54A89AE8F3DC3419A632D4A38E1AC16F432E4E57035B75C34BB8C08C
      55A34D359AE47B25EF64F16C26CD6964239306A005F170AD59C15EC782F4436C
      4786D1CF1C1FC28F6A996111AFF608C0FE5E5EAA6290CF8863352754B14F5D9E
      597041B50D318FA54CFC95318FEC6D18B6C1F71D9D9E22B16ACC16923F78EC6A
      CC8F05C3EE0736ECD62102B26C8FB68368D33B8751894C7A0316A26C14D27104
      C6DFE4248D4510ADD23CE6F7F0890A6704CCD342CC5ECC54528A5972BFE83FC2
      7C238A922078284376182C4731DEDD3CFA8FA4BA11C7920A23E3FB0395AA9B04
      9925BE79FCC4364BBBBA80350E30B7AA538ADCD1367F85B2B81B69851B3E8B2A
      C32887A2E04CC83EF98C4F60E48C7D8853F6AE1872B8E1A4209A5D3F928420A1
      42488C05A0EBEF1379D573E7E541C95F8316CF420E219EF88C526FC90FB1F3ED
      1C2E84217764E4D36F2743586166CECD2EA6945AEF4575DE49F1B258377D2564
      08074BA5060BDD4D7D6D751EC9265479CE693ED93E7EE2548A4CE8C795353B94
      03D3A718DBDC14AE314226C4EEE58EE6847F6EA3C54541555BD69DC355358088
      BA72CF4558DF57F311438437A02CB326A46AB315C0FC0C37FE2513A8A231ACB0
      EC93AC2F632DC840B67D29939834CF91E08C0DF4D88C2BFC03B48C48E51E092C
      0A9B6764F9D468B36029B264A9DAD921F3416CF8D026234E3979C84FF3D010A4
      04390540AF1F06C1390794F2521190536A1C558C1799166370765798DABF54C6
      DB4C4622B14FD81029CAA11CD21089C896166B14E4665825C412C1287B9D7D0A
      70D5B9F9BA397721DCDE62E5EE5212E8ADB568F9D568C95E6FE3EA6D62E6EE14
      D79AA87B03CC2C046EE4C8A8B8AE0EBE8A5495A25C09D92692B0519FBCFF0F98
      7EFB84D08CAAA5AAB00D8B6137C1302E384B511F8024D7219AC6A3DDF95B7780
      686664E306372C9B09761906CC144478560418918229A214FC92E87A54668423
      FC694F1300BF761B81D0F0D44B355266D462D5227647471657891B34A94B1ED7
      5B15B4BBE7BEC6F338A695B115A590EDB3A2EBC4AE5FB5010A3ED2D60D1D7BA4
      2A2A9929F3B6E440AD9203783DCEF230344BF634372E43A7488950E55F5331C1
      3CBC328F0DD3DAEA6E5BBCC620157073070DA96A1470DED86DE3EAF0AEBA4D58
      94AC268BB076AC63563C8C038B99DBAB6355808BE37717B0CBE038CFB601F644
      3C31727EBDFA4DA1DBF5A5B23A27CEA90CA4E5D4B70927F064342119A62886C6
      4917986E91F0F4DE7EF5EB36D659C3C7A1B742FAB76EE99653A042F85E454211
      67106D00CF94D52A3C0847BA4C45C134A05E4A01090828FC29577021136CF684
      0D57749689229B1B0E8345C0324E1E9E6D6C69E74BD49ED147C7A545D0D9AF1D
      251781BF45DBBB06A461702E641888A5763BA1FF4977FFE27AC1BF122A2C43F1
      5BAEDEE6D7CA52C1827CC2D52EB7C129C7E0864E30BFCE6E51484A3BDCD29C6D
      0FFB621DFF2C15A901C989EA95281F3B916C58E4168204BA853871DEE282B255
      C24D2A713C357E13A9EE09A76D91B08149E2CF668A40318DD61DD464969B33C6
      746569C3A44C02FA262DC45826F09E020553FA262B9254AF842AA1E655469749
      0C005F182E2B751E27BA0F432D3E57A7028CBC060A71AEBF0FE5C40D82A4B427
      2D4582CE28AAFA72CDCDA2425A46514615E59CC54B87C88FAE0EAB2E9C542755
      A9050C82E05771C42AE997AAD6B7A5993568A6123FE4CF1419129526B2F45101
      89EB8EA93839840D05376D2B007ED7BDDB8EB9DA873CAB8728FC8D258DD0B78B
      B85E10E76865DCFC522EAF36A1FF41969FE5AC390A997A19CABC395D264B567F
      63690AED6BAAA0434A7191C1B4F06E234A8616569FE944CAEC36F6536930322B
      70F1ECAA3E267710C19A3B9C5528AB8CD551D4E54C7E2257287947808676C216
      19506FA9D86EF646A5C3B9F88F0C70B2D4CB4CA81DC78B05E70745646C065984
      0AE1E725F3A4F973EE4B169E975292016398AD54A8464728D0304AE7CB0703AA
      CE2416CB18B6BECE4BCE5EFA1C10B08A403392D88C5922588B7EC2F5DA38EE51
      F6743CE434D33A65D9B0FEA192CE30BB0A939205287B20C9F8CBA56A97A311E9
      DE8936DDCF5704D03380F80334BB65333785F8F914E2121DC7AA415D437FFA8E
      9B1D734D8A23477F3F09C7E991737A9A1E16721CB0291A07AF6F81F690EEDA03
      B4B82D43FB5B1FBBC81D8DB0EDE9D1189B98DF7F47B91CFABAAA6221FC77039E
      758C369B179C937402CA715E03228EC31556E854C758F2AA58865209DD83338C
      FFFA29A2005BE78720CA0E803C2D437F2CD25C353B208321DEB1036943B45CA7
      606FDB064624F9D2BB2675BA8FB2245823A66A0C72DF871CA5C0C17732F304C3
      E6577236558F1744476529759B0E660D64543A65846C0C669CD7E8DBFEFC5996
      0B73EC005D45139951F583BF18AD122CD0FB9E4A1EA9AA34C46CE46264782956
      3C840D739C21860CE6FC553E595B0C3D55F93E54F527502192BAC0D92AC58286
      5460BD5CE2EC66EFF8F53F7F530742AFC32EE698584A2C9D73D4DD8E2C7B944A
      260EDFA3251B28105C37541C297B21BEAC116CC6BB89E2F89F424FAF8FCF52A8
      7A8A3BFAA7D972AD120D1DC17D1AE8349032598A94DBC00E4A406B7C0FC4E350
      41EA4012A2723992C6C470E164C94AD4EF0F55D9ED448ACAAAE2B24C915A549F
      664325FF70D56F4C005455943121757778276CD46255EDA0658069C13E6BB148
      07909ACD78B699B2C9964EF7DCCF04473204D131894E949A06B71A6FF65B6C24
      80AD02A5949ACAB2178747CE1B1094332E50F886102110E144D6EDC69A663C69
      3E1797C6A52E2B806B707A629F8E446786EB71DB42F9ED6CEE0BB1D2863349E2
      A5B3BB17224A11282B5099F6654C6D208065CB2A090D416E47B29CF1CECDCE94
      F3D50C5B7734B4219E52AAB9E0BB3F8B820C2076888ECB8951D9DFE275355E33
      1D55D1E408708BD2A6FB6F0B80401EA7028228936FC3FA62B947F21A246C1742
      8439947400DB01A50E372B048E15709133B20D8C12E19FA3D4BC738513D5DB24
      E5E4E437EC4EF201206A35E886B488B05B08C26615B26EB9C5805C3444828BF4
      94ADF868C2545D3D54A7198699E9F31CCF03B18F4A77C0C02F35C138556D5EDE
      C5801AE981E930E70EA2189474EDD094DB21B3463C29367EF9759CA9C7F00529
      C742D4D088F3F16F27C8BAC67EF8397E4F96C15F00E66AD223277F017E6FFECE
      2FDC2B69A155DC2A457B53704190A10FDC743D2BCD9A523427CA23B73981D3D0
      8E6756D3D1047768B8B14F64A226070014FCFE99D9D9460F3872641BB70C2E7A
      1DDB0219FD4AAB207B868A39CECC0E02B2EE8BB48367DCC1816D13782B8362F9
      64CC56E493374700791AC70BA14BCB45F1A49099592CB768BE9EE52C56CFB1ED
      DF5A3718E239E87619D9959702EEE98B4C591BF39A52CA2A712BE5289F3F2BB5
      3352AFE17E351220D40222F1739FA4C6680334CB24C6667B278E38999DB08FD1
      68E1231FA224B350F811F5B6E2A20C3176B8C1A1E8D6C0683DBA670484A9464C
      6AF2C23DF5E415111494502A2F4C73EF413BC89CE61BF741DE84A372F0589DFB
      6894683E986215AF30F82746C6347C2EF6A429101FB0BF3E54FD7960D12A1180
      AEDE248FCCC8EF8FAA6D1D63E6021088FCC2E9CAC50C176C9E669ECCA56FEC4B
      5537CEBBAAABDB0E938CC95B0A1C6535CE5609B6F791D6C00685CCC9564A18DB
      699485F6D9AD744BF731AF7B2D579F8805F089B48CA33EDF1C6A664046C5348B
      6312AAA831CA0A89BE8AF1733EE7EDBCB062C52AA59ADD3E5BE464BB7999B7A5
      6B476D2BB32EAEA82C0AEB3554A39CBC70E6FD214BC47EF7EFC0941E08454E25
      8A9059575C61212C3C3BA38F434D533B33163AF47702D8FD015F8083FFBD4289
      F3CCE4761CC1C5F4B31080A0826AF7623807DFAF9DEFFD547CA27B72200B8393
      0F65145FA94B27A3CB54DABE1142CA7121DCCB93E3CFB0478D7EA2F19D431A25
      D7C6724E5FBF7B87478FBDE9A64838C7EAD13D8C4A4C0A4A0B95E5D6775761C3
      F3F9EB9173CC00FE8B732ED669B9A59C0CB280B3E19CC097610807A27EFB00F4
      4C9DCFDBE802E5799D4174B04727036A4CCAED6B7292A3B9A4242B52E4513E02
      954EACA8836A2762D018290571CD33D52A44261AC1AB109D643518DF2C36AF4F
      5AD771A1923CF4A0F442A442CFAEDE5BAAC5429120792AF3B2107A62D5926BAC
      D9204DCBC0522E62619D699559861A5754F18CEB1B93A602256715B635122417
      6200809AD00FF788C8555C4857FFC420CC55104E882D6F9CA16EA1898105BA45
      291B1568CD7BF4C1524575536E0E32A198FA03FDDA030A01539D8E81EAAE3186
      41878F01F30370CD61213548D342E4E1B62AE4D46C3BC822B2E9B197D1D069CC
      820F0700C38D1A9F0313447E8B80D156C0900362E124D8820FA40A651AF94E3F
      DBB77DE6476624DB0E40DF163A258AD1C5BA2BC6F119FC5C4FF1CD2ACAA753CC
      2CDF297B1F0F6A9A1B0C5DCE885DAEE9A38C138AEA9A894846F5723ECAB6ADCA
      6EF629E100E5D34ED1CE94AD22A38D8CBC454010403E6222EE732317CED8F01D
      6C978C38058AC22C214D01AE7D5E3106FFCC61D9B000E4F82923DED9D96B4BE9
      6B7B580EA4C4F70635C9030AD5C78FCE0FD4E0C6266798651939DA84DA06D7A0
      5D74A331048A6539A07AE84A105447C680B9216029A89F38DFCBDEC8AA172D69
      3531F92ADFBF3CFB0CF47BA4A9810E10341433993146F39253E305A215769037
      0ACB921A76241513129F428C20A4687EAC2519AF125DA96215812A235348114D
      89F0A0AC2F58F9C3B2BBB09188BA4A1E221EDE8A7AB714F15255A99AC468DE20
      E6E9C37BC552A971B01E83AE1011473311D2078E11A64477AA0150883FAC196F
      9E0BA43A26462B87686590E1AE4AF305F099C7AB5A4831F5945DB4E158B10417
      3F16705EBC2C467FF012FEC613A4D737FD32CA26D429975CAEACB06D5D74C944
      79695456365DE5A6306134CB96AA584AA0D0CA946EFFA4268A9C3F567055C8F7
      4ED747EE9614D77AFBADAF4EC685D059DD115D157C34918FBA101EC9935EAC76
      1B6433AD9BDC65FE418DD46E0EAFE4CDD05E700BF71F51194479FF6938F35A80
      A04C88DB8BEA7DFB0F38925F8044BC5DBC8AE1A01F20ACF7C4F911ABA808364F
      F0ED0692A523BC65FF6D211334483C9AA87668117543D3A68B49EC9CE31DBBC4
      19E82F091676878D59B166B762B40081F04206EB30A525CB711A93F6C11A8332
      284BEA640B0319AEB19CFB909E801711AEB3AC84A1DB4C1BA56A50ECAFEF7A3B
      8373C8C9FD56179BF988D320FE837DA236D5BFC303CD9DB8A7B5621E945E8E87
      5CBF956499116D5D59E11934297E92FC924CCA64B4937FE4A5ED7CEBEDAC1D9B
      43844ECB70CA496B98CCC804BE06F09BE6965DA44FF41DD54EE09C019207A40C
      49CD2673160F8BB9D09109D2D81A09217D56A35CE442D247E57D4048448B07C7
      CA19721BA7555D04A4B572FAAE34E41DCA6F438CA44FCEB9A18E8AC3B3746FB7
      E141F5B46233BEA14C50EC96CDB22FD71AA982938A102DD50FD9CB29401A95F6
      EDB06BF0F5D9FB23F8E71D73A077F1D827679FEC4741A52EC8D8CDA16EA1283A
      F5AE298D6691A25A6527DBE32731757EFDF1DD7F7DFAB649FF73DBBF217151DE
      D1BC45D8F04F348E0EBF9C882B1BAE6D0071E7230ACA0DD9314DC1F95019A9FD
      2DD0C66B6D425C379C30321939D8C268FBE83B325A13F033998CE3896A7765F0
      A0FA1E3CF6A5030F4ED11A6B9A62B3C4976D893F299576E27CBFDEB0A813A617
      6DC4161FABD3CBD5999D4C7C55865D0A0C16DF4C67F8BD676BFEE0EF7CC438BA
      872877C0B7C5C8E3928226C5B2727E65A1AA94744C73B578A4416231129349D1
      000A64674F979B49247497499C0A56E32B6358EE3547BA86D9D3A13F66DFD7AD
      9FEC9F3B0FEEEF40623F3099CD11503504E5E30418DCB3D96824B61D82A59DD5
      6421585A62B995581264643056C6CE427FC1E6D9EDF42223AD1B6343FCF1385E
      45B9ED7EE14F08B3F7F388EB45E42AB334F1C9FB2D1D1224D6E3CCF8F04976C5
      AD62B7D0278B16B52F80AA6975AABB73C5D1366DC9A28C86183742AB2877B873
      B88E00A5D27EDA4713717A153B88B0F836379D55DFE9683219FF5C6AA976E2A8
      5A43B0B2E2ECD318DD1CC83C59CE9713B692897C8545929D67F6EBCF2259FFE6
      6C89E1B4A6EF1AC5C58AD750FB7452D55EF3FEEBD8FC8127892C6FACCEF1FE1D
      7FC732B2735C03B679D33F5D713FCEBB4C1D95E28775751C6AF184431CD94C8A
      425DB7A6E08CF3141C0AF09566822369F63E220FF7437869311BF6111CD7F367
      70602A9B8662D639287113F2A94A81A77382A7F3B2BC188B15AE66B01A925E54
      E09D4A06A9D587A0D09BD408FB6DC83C8D60EA9C7EFEF40E75ADB90827C5DA73
      8796D6EF823113F95FB122CE6F9C166049FC9325F1E4A87E185AC1C43D2F5F0E
      24157E84427766349019C9B20E6A903E75D26B347DDF96CEC585C8EBE4491914
      4A26F5E87CBA52A7128ABF9029113F45136E0E85BFBDE29C94DC9C2B73350FA4
      0BF7402757E6015C0779815CDC8C4AABA97AF7C983F017BA27887C0F7357B673
      150AED620E7DE4FCF4EAD391F294BFFDFCFE00E0F6C78A326EC876BE14D2A4B1
      F3552D0AA64FCBE282ACE1A263D3F8E662603226AB72AC325F8969C04EEA83EF
      3F9E9D7DF3EEE3C7CF3A710A168801F185FCA9DA0600A6B91C1DC03951C5FAFA
      AB2442ED68EA1C9C612627DE4279AF30BC41443AB68EEA5A80F29417FCD7F646
      809CAA513A8E6711FA0E0F6953588616AEAF834150CE2F35126133E7ED8B8543
      915232850B57A1221A55490F10981204CCE15ED5AD318B0ECF94730B384191A5
      4405E757FE65345BA1CE87C500A9E192D61CD378059A9F1F2411066F86136032
      63C16D43752C02CA86D24282BE2399DD87A424C21264F0295D71F4D50B0CBF4D
      843F599B091AAD13EFC425C01991E36661FF3AE185D3E04A3979D33A144C1CE5
      7536F19830C481882A2664E4A2EDC2CC6933E21F5426B2AA56842211E7006C72
      7B0910787ECC513BA9C8AB17A9708D4970114C560A7BA862B8513E94B38DB148
      3C454D4A7C1EAD3395755CCCC6069CDBD3E39667AF9ABB38DDED684404D3E1B8
      707E93D598828183295175EE6E4525E8F21409BC140B3FC28813E0E97350261A
      9895198C834CF293B5ACA2AAC2638C3F1BE5D3818C4946A728992DE454A34C51
      E2CF5E442F5E61A91EB85B97F3B8E004B6C59DAA6A5F6FD473521943E5A4AFED
      76B89DAF800185C3C0E076B3B9C29C83621A6647188E4B01AA7BA85AC8292B1F
      19D3234AB6B248B113F6EF638CC003C82619081A244F1EFCAFD56209ACE5606B
      2DAFA78219F7D0D02C4B42E7AF5C00E9FE85DD785B9D3589299255608C4A7E98
      AAD7AB0D11A9891A1FFC0B60D32988EE4620F753B9FE77CF18DE00A9F8FCFAAC
      F3CDD9D9EB3A05BB9E3F9B386F3EB68F3003D627F55D4C66427535858F5801EC
      3CD54E4823A1179434109938E19E9A4A604F1CE5B9219D4FCF29D515B3C18E76
      7A46F2408FA83ABC9C2F7F35F60EA3ECD189B8CA33D4B8B06690E692DD89D3F8
      A4B24A37B428166B51CDC28A00D3E9C92176B8C5F79CD680E93FEA1844E6B208
      D1DC1F0594D19ACE57D36948423C08F0AA0A0286A52B6DA6D431A7B465098F4B
      8E17C5C2CA58C007351D4E0431F3C90AC35395B1C7958140159C829E4919B141
      84855D38B52A3294C80F2F7F7ECF0A2411A3DC0C361199C0D251338CB0A3CC14
      90A88D2C6A2E8895AE6A4031D9F9C4149539ECA2C9257750BBA99F8A57BAF8F2
      568FA9A9549072323256C008C612E2F26EA64A64C26A20134DC0E149B86FE318
      0E0C94988CC66805C8788261587B959F36739AF3080449D138ED87B216819A71
      0C7021379F7053A1CD1ED98A5B6B02D4B9DBEC11A69282009FCF45AC2668D205
      6A8C40BECBD32BB3F2738021545C077E1A94C5380BA63D8778A37F4706A91357
      75E52BF99C912D78E4203DE6067C041859A3D3B2D21A09CB321266BECA26181D
      230DDF7482C96A69038936E3F6857247214A4A738B2EE75727E95B521CD9BC1B
      27C5BE2A79E51B3A9223E34B4C6CE6578ED84EA51F360AC1631B36021D26EC46
      E4CE5456107D9A32A282E7D52DBDE5FB0A31D573DE17E1143EF5F11F68B4CDCA
      154DD2BDCBA2450E2C050037C74AF458246845854855E39A280FCEDAAD9EF29D
      3DBA66570867E32E6F3161A1461C442B9B39592BF54F7568CC62CCFCB3A4A150
      9DAC089C3C5D0F5110E8C304F1DE6C21E3FC00F2D6EB54A544C82F7D4C9F7CFB
      0AFE38C3B2349FE73A9D102BF3A2B47808F897657B881C6F8D020509A84BBAEE
      43E8533D14EACAD12059D31F2720183829D29838B2D6CB3A3841A92720D08599
      EF2C290F952CCB16434A1D1D0C08910FCD570E591912CF0C805B2EEDB6B314EA
      FA9104AD983060C72555C4BC8CB9104B4CAE35657C54AED8BD646650C540CBA4
      5C3D741E7371229C9CD49583F7028BCD53BCB0F40B9F386FA79499CF49ADE5A5
      986E71C3499143E88815B4DC47B1E51DAA3C2AF7504BB45DD698A68E6CAF4BE0
      7154A65CA7E2A472A1AAFD055636911287076BDFFA70FD8251883A1C3960A20F
      576D02061D847EC2854F64735A93C09E382F37CA06A223C758920633171A5327
      772DCAE674DB4FCF5359A62D12BBFBE43C7F068B29C183EC1CC6517338ED4287
      A8B25542955A35D6B3376DA7DB42B9E23E9BFB55E51771692C4B1F35A5A230E5
      3F322E99D14F9E3CF6B0E4133873D2D7B074334DD2F8CE794D2CE30C9805764D
      FE89E2E68FB8E3A07A8AF012D4F1F6DFC5F81C137032BEE6935A0584E3C48406
      F0BC3D32DDB9BC70BC0C64FD6603403A9ED0DC339D11BBFD609F9BB78C8AD690
      D2AEFB294A0C285DB752B80B96590A64A62FA613AB272F65B379B944792F224A
      F39D710E2347A54C0A2F576596021D85D258A535286F619F898AD803D1439A76
      90CFE73473CEC42A975378ADECD19CE4BEDD9BDC553A18AA149096E760D94737
      DCAB41DCE79B54F50614880D22F8BAC5822B93D32BCBAB43758D6A86EE0E9D80
      D394C6336E9629631B14A5DB2367E49D366894454B536E334E88043B2CAC709D
      2857A33EA1C88109EF09B03B68E6471917F920B25A820D17E656779F433A0ACC
      968762B8024BB25A89942937F53BC060514A60BA9AB382B0FCB2DEA9C093DF73
      8C8FEF103CB31F71FD2FBF3FE1496680AE2A03089FC2575CE2B6A9ECE20CE36F
      30CE01834FCDD158112AA382BC7B6E4532A12230CDEB8DD485E888413B00FAB8
      58291D003FA61426BE70D43416A8DBB7F29157382FAFF248EEBEB8EFFDAD86C2
      4F0340D11A44D8743FCF90E724F16A362F2037D0466389BA6D962A16760D3128
      140F96B4581D5D09522A000AE81F10CEE3D1FA58271512F5E60E3F3087062BC3
      BBF4BD62DEF9F7A52BF40BDAE7A9ED2E3D53832ED79071114DCA848F2F3C862B
      9AC74B4C46564B61131E79EAD19C8D8B22B26D021BD3A16E7417AE979DA8BE36
      5686310B54AF12B2FB603757D5983391B9759281E05F1AB2A530E0189D90BCD3
      65EA79E8A8EE6ABA0A763D9F2C079714C292F0BDFBCA1518FB97778382D74F57
      215E076C404E8430C91B3910C72DBC4DBA71889403F3A2A283F0B9001A6907C8
      0396F29A3D992AF7A5E45904C38B8C8B89C53341B1155883802E8D62FCA5D909
      F21AEE29FBEE189C75222CE958258B64171F7506906FCF43A58B50761AEFFD75
      21E591CF54CAE99259488662B611D5E91026694C85011E29213ABAE69094AAA5
      3B7272623302769EAA12F2E13263BC9FAEFC6C94C4CC457B6BD428804DB57AD0
      40433802C076A352AE2CE5E547D1D2004802A45CB0E881E8539746A9F5F8A513
      CB855AEA192E903660D0AC48917AE868E123495B75B9937415B0EF5D551C4AD9
      235050CD1CA35D0A4EA76953AE6C69B593C2712D3AEE3AC7EFC9D5427E7DECEB
      E6FC20C2E591F3415CAD5260FF7045FE1E643FAC464798B230DEEDBF4D2647C8
      6A80D527023D2CFE4CD878990D6057F55A2AF9D5B46E8481D8974134C126CF7C
      4E2A13E8CF21B6FAC0A2B404DD21F577912076CAFB2BEDAC767610AD1F3653DC
      156D76DA72862F46BD21E0EE972D073C0D8E5B5D3C859EB7C749C3DE7E1FD3BE
      0017B22B1C5BE3ECC3D46D6EBD0038FE7EAEC0EE9243805DCE31E8BDD4E9708E
      BF21BD2B1478784C475A4354D5A402F685BEA9FC7744FE7C7BA0D8D0D9C80013
      2C274B4ACC4CDA2D459E939017D54F5611D9EAFDF4894287A9278086943612A8
      51FE9D0652C90B31DA27032E075C235E52AF4D43AB5480CB4359389985D34A9E
      264C888F0099E0DBC267AEBE4B4572816AC527E187C724EC8FA9D5581DD323DA
      F448B2E729B981162AAF12B65842D6798DF9CF18291E1048B1E7C99304E2F367
      8AC31E3BAFC305C51A242F7F7A911638AF415B9CFFC2F2F95270E4C623A0B2AC
      32EA0190A6B209719EFE1547B398F250565841BF703FD5BDB4C2D5CE63626F05
      F7E47A206879B7032DAFB71D5A5EEFF6A0C5B4D24A8BC5FC702E815CC8E05485
      9455B7B7690DB99C3D8BA6DB302A02BC9E4B45DAC27470736E843978458595D5
      8A1239BB3496AA42B6F50DC168AA9183895E5DF841C891CABE33C2860A182086
      FD0F95578283DCA809072D48BE5FC692C5B26CC34351AD2784875A82B3A87803
      542C62DA6EB985EF6619E6B78E8DB958FE6008992FA10227EBAC412B09180180
      BE47107EE29CAA35A87B6FFBA4797275043F3CFC71727272C87E431E99EE4E47
      7CFE8CAB7128F33A87AB9044DA603F017941D8617228E3670C662F034C2509A2
      C8D040367853ED48B9267DE90475A719D9D8D246C5D5082C97126F221601DD35
      F3325A129647C515905447856307485873487627BC7A0A9E8CA4FBE026E5E533
      6A2372600A075E6A46A1DD31D6B82C19C9A0E9D8AF57BF3176E59DAFB29CB650
      BB244973A997F17E3D7EB1F004D99613244609B68688135D72BFD4FC56E22DA7
      5D11048DA0BB6588C92484C00A7C389FCA288189C9616C127A9C13B8C7C28FD8
      D4519EBFF65664AB1F952B2795BCDD75379046313535B4BB13E70D6B7C4CCD52
      231CEB82CAAA10DD430D3ADF9C588A48E73211F5A0A077A96BEA309E45CCDDE3
      30FE6505E4706D695B8D7AA294D00E5B057C40239995C90A28BC091FA7C14C99
      70E922F04B3DEAB6644C1F1AE6788C6098034CF688ADC16637B48CDD8141A96A
      17088C2A58AC1672DD802C733F94519C32114FFEA950EC4ECA04F557A62434DD
      965AE6D55AE7C136E7C176B2F0889C07CF9F9DA9DB714CD78ECB5DA4BA7D61C0
      563C798776CE77ED252BA296E485DA82CF8D8E61091439C5BDDA49C2965D4129
      E0268F9BE0B0AA4778EB6AC0FC4D408DEEA5BD3A0BB250D7196998B5850FF3C6
      6445245621FC0B9977C065A430B8E78F95D208E0D28DA8989BBF8865212679B8
      AA3126BD300DFEC9BA574107D5A722B3D9A5A790824D71C493043C82FD33D26D
      86BBA6949986465A01891AAC43565E9F62D417C66BE37B72A7936A0E83EAE918
      98445438035A0993521DC25958049708A5787523D5EF49019F6FFDD902033E8F
      317A6F8469E9D229A54F86F2DE193B4EF63DA4BD4FA0C69ADFAA44870CDBEDAA
      B518B8E4605157214BCA028F1064AC30D69C1737229DA33C5466B55E4703F05A
      2C9318255F6A8086214EF364159D3B692CA3958D4971FB46FF8FEB96B4FB0ED6
      B9F7BB4B23EFBAC75658AF76EEE33946715EA982AAB72D961970C8F8D24AEE45
      E57B07B4CA6AB888C86AF68D369FE55935DBBA501724FC3DF3C629F5CECAC8DB
      64E4ED5E8C4725230317A04067AABB88860A55DE2F95FDDBE0062DB1131F1602
      C64443B86C2A1D5AF521D81D4F8912218879D98AB254BE1751308BF470B4FD84
      31BA009042CF83C944444F540E783B65115FD75BAE84A64AAAB8A45EAF73C46E
      05DEC32303B109263C9621A32A253C5D08A994A9335581D968B65975C54A37E8
      3DE05D8055A4D029A0A8E26EE7D1F577CDF2EAEACCB3A56A113F11707D598CA2
      B62ED451A620FAE88C22DBC8E75AFF02263349A67DF0AA08D59F3554B7C0D0E8
      BEA0AA8C8DD664F95FA4627C50EE7DEBBC62384922D269EE97142A2B4BB31240
      EB220BF594BC1535F03DE19AC718F48ECD3CB65C13CEBCDEDC26FB26616BF338
      D469E4A0F4A480C2AB253B202E23E75CAC0FA9FE2982503D269D8B52BAE165AB
      D41F6DBEF117D43E0C1F0A16F57D21672293194F880F4DE5896008717D1E0C1E
      A358BAD8A84D4629E0BA58386D31D04DE176B3505C3F4680EAAC638624E5C512
      202D19AB49C6B0CFF6CB1025101FFF25932FCC0508A84A6DDBEA2015746A07D8
      AA680FD7414C56F591CC502D8E9C5594CAFC1D7C5D2A29038806132ED377A863
      2868657B7923E0790AD3A45C21204F31B5AAF97F6A4FC09115573B1FF4B1E8E5
      91EEBA4379784BD9DC406134C93C9EEE4C9A82A412A34B58D6FA0AF28626D5F7
      32BF7BD9D5C0EDC2BF6EBFE5C10FAFD7EEC38F56B7DB861FED4EBF093F3AED01
      3ED26DBBF848AFE5E1237DAFDDE6D1F8085CF01E4DD31C0CF021D71D34F129D7
      83E7F067ABD7A6E7DADD4EF76E2F3CECFEEE7BB7BC749CEFF1FFCB37A0EA7978
      F814149CBA8F9F5AD2A25082457C8D810ADB03A326162280BDFEF77AFDF7B8F7
      F8FF751FE7FFD54713C7624AB17E2EF33E32B5070917016AA80293B985DDF9CE
      295AD80995C88F7EEF5DB01ACCB50F2B2BBDC3CEEFACD6FB0374FD6A48E9A37A
      C3E69B9FDF6E8775CE8C942E4D16CB30668DE526AA505C908CAC92708D2B5537
      3B23C5F1B3B55D6CD421CAD5EACC1F1D71F3B04D976022540A3E863CCB0A14B2
      554FBC6774CE5BEC086596AEA1796A24728CD6CE075931ED1B3C52ACC4B257DC
      A35C701EBF712EC452B5424617A5AC8B23239FF161190ACD25690A09894CBDD1
      FC8936159FAB9F517B5399D49CC4F15EBDCB19C668BBD7263A5A1F194BE64138
      81371D390835506B522E97C3AF7F91EAAFD106C21B5A60E500A363CC3EC54C3F
      C7D22055C798315EA579D8EAB95873FBEF556A3D495B3D49ADC7EE49C2EEDF1F
      90D1FC075D7D85751279B0279DEE44F7984E76F7BEB2F0AF3FAB2D11F128EEE9
      E9EDE875245B2F6319FF6FF5491DFFBB2291F049EF153EFFBCA597D193DAF029
      DB8C5FC597D1B76CBD567BAE385504CEB65D5BA1A99A3DABF6186364744CDEE7
      355ADC4C4259B4B300EF1A8AFEBF8AACC59574DFA37CF5D3F21BBCC34E032337
      0E9D6F64EB0FBEDDFA8F8A971E320B978C96A2A81299829066206F68E6CBE543
      A50DB7BEE594D6F57232C997F3364A45925DB38211667EF8E3BC930B2B2DEAD5
      DB93F48C2C3D65857E435346E292C2E38C295275930E9CC6A4647AAE5F6693B7
      36C1A687BB36800F2D37A16709C5AE148D145364D0DEB75B564CD00EE88F4498
      6ED0094B264C45C5005423CFC25486A0C054DA948F955374696BC51E4B2A7292
      2B3AEA4853D5488B70623F4772B13C638217D7E7A6BE632360B66C138E0CDCE6
      C564EBA52CE28C1C9CB3A9529DA9E2EF8E0259915F388D91FF5305148BBCB591
      97D43BA4A869BC4AC65C3105BBB5C886BBB26EB62A0B2B3BC81CFCFA0A34D2DF
      00F5976BD481957FEB1BF42C62013ADB8F61C3F569B42EF63700D8284090A17D
      A8218905CF92BC8067B948397A397532A2345D702E8B4F15D5382391FA5AD708
      EF90BE58DF397DFDEE9D0ACEF69D5F3EBD7B455647E7D3EB379FF2EFF1A943D5
      0A576087043F5917AC28D4815CF6D046DBC6C6E522AA563FDB3311188E9116AA
      91EB9247139500C21D2E245465D848BAEDED467F6F4681FA3DF050F1405B18BA
      7C8D02092A3C04B3927647A453B6EB6C8E45B0F47255F8BF2A8B876DE833AE33
      D9D0443D407B0FD7F84E0F71F97E690396EC5542DDE8EFC110B4C4CAB0F9A9CC
      E58345194C79C70EE0E8D9DA6920BBE072C73A508BDBB4A87A1448049298CA36
      9FFEE3902A312389CBEB2C171A3232DF1693FB54179FE8153E781BFD0E249F1A
      3072A1E9DD82371FA265CE458EB7094903504E43D77951027739DD4256004673
      BB7A644BF4A374DC8EA5C0050F712B3295A2F541337EDDA296A6CD62CD50A859
      E4EF1C61AD1E6D7CA7B986FA4A4524F9AA03840A593766AD13CC41AE08AA580E
      1A0865658EC7D4A095D25BE5EA97899806577B74BC58EABCB0A0EC00CA4072E0
      264D820A2172219811EE18DE441A10CA3A58E858B6F66565C1A7CAE449A6A243
      7969874A5AE58A0D4A84DA4FC7A1784F7C2977018655AF45C64D7F8AED1524AB
      66881F51143B15875632D1CED7ADA57607E3EB17CAFFC54F50D0F996DD5AAA99
      125DB40F1F3F3BB2CCBF1FADF306D05C5A9A04B4852CB59B3BBBE4A1F26F4122
      2F36B6C1B542C56E8A2C85FA71492B721ADC70077EBD4C020C463CB44AD226F4
      36A1749037DD2E0462AB765B54FCBC12ECBBD9A1D6AF14E6D4C6BB0F468F333F
      2B611E920BB50DC1C1A4B295951915AA7B3A14704ECAFAFB161DDA0ABC0B1F1B
      38131D42CD48E5F46EAEA7F06AD9C10BEEC98C3AAC60224E902C9899C9D6B894
      3532C6AB2DC35360A21A8C9662DCA9763DB232B5D84CE597CBC9A9A7C92C508D
      ABC6F338E046E507FF2552D59BFB8018C5C187587FB12FC8A4BD234FE7DA6C09
      A620B6150666FDA80D6014772A35CD86713C45805362941C5623EBE9F9B3F24A
      0F5591A9EB8F365F92EC31B6A7059DA50F2A8B5B96958EA85F72C1C68168B917
      3164571E855014CD16853E8E47B2CB50289712730FAD20D3DAB00CCBA891ED8D
      65EE0030F2A0F339B1C87C8EC1B0A0125CB9B0B26CDC9C033855C29C7A6AF34E
      29C873518C9FA596742AB52456EE8B3A164C79FA0F5C116B63BEB30C57B32032
      81AF738417ABD0EC8B65997535BBA19C4529F5634360A423AFCFDE598E5C1480
      356BDB8D4CD4C9A4ACCA10B66B19FEDF9DFFF1E6CD1B6E0C07847FB1646F5EAE
      142DB872CE1494A67CD4BF7D47C34E7403CE296864C5D645598CB800726EB4A9
      46EDD9A6F0AE65EA9D0BB042F73E78FC09B4706AB2AD1119988815ADB7A67DA2
      DD1CEBDD2B66A66F770AB3521B22D0C8B519CEF0DF5D6F222151AC8A9E3E1ABC
      DB44AB5AA5ED5A86AD9216B373148A8540C3309E8AE4016A66AD4D364E8AA976
      58621213EBA658A9C1109B587EE41B6D8BCED42A9A2F229180A4F44F4161B0FF
      B7BDB76D6E1B49D245BF2B42FF01ABBD712DEFC8328937929EB3BB214B72B74F
      5BB64792BBE7DCE98E1305A0206104121C0094ACDE9DFF7E9FCCAA0240891441
      B5DB167AE98EB6F50280A8ACAC7CCF27B1BF6C0212FB7D787F7042354B5C92D4
      1571F01B7B1A1A145BD6D5F0E24DF2F923199E38C09350B6EA6DF89285A52FBF
      741F479B35BFCFBEF1AA49487E8B85ABE6073A0AFF7336FA9BADB8298134D6A8
      75A1041455B63532092AA20FF5C0953AA4A4C627AC51F5C814316921FB22DC75
      7C7692C41B28E156756AA998AA64C37B6E8DA88ACFC466E84A23B4A949D36C08
      6246D6D8BD7F7BF18B55DC8E832CD5651EF330E1A122B3F2E6DA0FE8D69B43F1
      9C1C06DE14E252859134EC92CAAED1EC822CAF0751579564EC514EA76922F530
      6B050E82D7AB11B0D87F1C8B5B1D61A48A8A2CBFC8280069A0595A048C54628F
      5E8D7A7C2A706F6DDCD17B84199B728108AF78BC59BE6FEDAA64922E6DD37142
      FDF216078EC8E3E5B6BE49569AD9A08D5238F95970798FFA85B9D30C82E036C1
      A4ACC11AE0F22A4414F5C06A2C6FBB522503CF6272F70AEC85E1EC8D8D4A4C40
      C8F3793629EB787C24F74CAD610B4A2A3631DBCD71B07B1BCCB58138503C3E22
      9B340527FDFA5813A2B9FD144080997E6C58832F1565E329146E2697418A4951
      35A75325B0CE3B46F3483DB4977A1EF25D44DF75BADD6871CD6C271FA76A8DE6
      D84466FCF9449F8236906F090ECB7512CDE0129913C15348E73F423DAFF909D5
      595DF0807DC50BF551C4F3C2FA940AF5CCDD069A8F66173D0D44E3002BCC1EC1
      6551F73EA3DA1B7E96C2EB95DCACC15D6BF3CF30EB684F72062D494C135DD886
      27936A7489E6F23DDD46D79CB65EEF5525AB68683C8D399805CD93626ACA6591
      104F53392F57C772256E4F65B49B60AA5CC6A552EDC54250359D89A651041A6D
      4EA439CEC3ADC25E6E7EBE75BF957CA292EC2AB3A37151E8B5759DED4CB6810E
      5E4DF744CF40C67237E35B5A4D9B2A75ACD352F18A37246EBFC7B66EEAD2EE60
      A6CED36AA792FF26E45313CEF429D7F08C09CD76FEBC1E5E11F58E2964304631
      D1A68E9651FFC9AA660EDA997EA3BACD9A759D739B4BBF3851A3DEFF64F537C7
      A345F37EBDA79306905E5D74B57AC89816A19BD3546BBAF3A6795FC1F370ECF2
      EE51BA31FABC4ECB362ADE0A9D37AD8DB605D56FBA15AC9A76DF348414ECDD1C
      7AA00AEC929DC27841A2BCFF4EBAC8CDE46033632E49115E365E8F9ECFAF679E
      D08238D587D013361AAC7DAB680C1F86DD1E5D79C7A64C5579B70100AF2876B4
      903E34112F51B6742ED9CF08D93FCA89A775DC88120542A1CCA9FE665CAD27FC
      71AE938A0D2FA445152AD5A1D68EFB4E51D24FFE567DE02F9CBD31B754783393
      4CB75199DF546E259E7AA19130FA3D9CABB0C552B389AE96505D66F4F6C69A07
      D75CC0E22F9ACB323244CFF00885EA10AD5EC18C16A178FFDAED6A0C88ADE63A
      EB9433B79D656A28C1DDDDA050415D9D0EEFE65AE67A6C034B39026EBD853B3A
      A69AD0EE8A898531D9A08ECAAE2D26968666E9E5A978F76E58F6CB09ABD5DE0B
      0D5F63BD0202D6D1DA8D646A9AD95F1D676B29677C8505D74C50576F56569036
      D4CF2A7C6653A3080EE2C03DD7A293F05045263A194D6EBB76D3E76AE655E556
      B15F7E2E3918C90185E22A9916E6D3BEA372B7C6E771606BCEC5A04F54653670
      D993A8BA69532CD222578C8D7E974CAEAC97D69B0F2E75ECD1779BC35F430337
      C862EA0C49DBBF71CF8E5B047E94CB9D4CC27416ADA19EF5E4221C1C53DA5830
      9BB34741AD261F5C55F4A9DF4E8589D580625DEAC995D43C9E58FFE0023FD8BB
      53695D378EE882CFE45E50964F2D051C2B567978CCCACE47515EEE30169A7652
      C847D2BF343DA164C9B46F9021A34FBDC6EAE651AA234D544BB0B11717F86334
      193553FD4B8A2C4BA77937BA932ADF903C28C84345056122DFEBD95E55390FC1
      8154D8036AB04695146546A3ADA6E61955CF1318B3B43436292DA06E90E251AD
      EDCB79BE9166A377C641BFFAB6DAED2E92376524C62A65F2C415FE9706D634B3
      1BE779FFFED107979D56E78A86AB9A33CEE37ED5197F0D77976AD4F1937724B2
      56E3176EF474DB9A2E93546DE6FF54A8A14EFAC6C9E7CD4CE0A6884BA913C1D2
      35B1D417B190620DC7762CA20A69E01EC1AB861BD3140E597CB1560DE5DB892A
      CC0E859E0E4AA3BA755B97EE47A1B1EC37CD02D5D9845EE462C2457D6FCF4F38
      A9CB89370378D5F8FDEACA2B7CD02CBC24DB640D93E44015EE2421F43DBD6F52
      8C6B11DA6855D7F9668A9DEA312220BA66229D5533EAEA3E75F7AAA988DC676B
      A6CCDECB29DC98CE2D9DEFB89B37D5227D012C0FDE14BB466D603C6EA446DED1
      CDBDD5ABE2912DF88B3821B8A5B9E83A09D2AB5B647359D083187744F926D76B
      41B33E48F1CA0C50B4DE012D6739CD64DF5940564D09C6A9A5CB0BEBC7938323
      EB634ED19D926B446245BB9DB3329F85E50E85D9760E186419BF323FE4721655
      513C9674A09AFEDD05FD78C9735A5072FEA3F668000EAD2E0F92322708157582
      1590AB54E5DA2CC6A98C648D0EE1B7A531CBE7CC5C4279239A3CB7CEC23C996A
      D1D02050331AFFE9ADB51BC0FC227038CEFDD3209C5C5C3C9B3C23B8B4F6CDDF
      77DB9DDE4EE2AC4AD46117231D5C242E53861EB77A5DF2D4B46F60A6DCE2CF8B
      F1F805A8F5A990F92BEB335E39929F5F59B7F3EFC240FEBF7B71E1B780407F9F
      4D96D7CAFE8E70EFBB89AA1AE96D4A0856CB924FECA3925397E56F8F184B3B15
      174A730AEED780D0E786C28DA5D4B04BCE8FCFBC976767C726B6F0F2CD87816F
      1D1FBD3D3742A9D1BF49F64B0D72B867BA76ABE9ADD33CC972DDAF194E3FE876
      D735DCE4AA224D55559ACE776598F1A75321D5849DF41CCE8A095806B2690D31
      0E94BA79DF7A3D6BD3026BBC9A2A86A28AF82A765261519A54A66C3086FECA95
      36D6A925AE74C86B62A824314F20DDA93A7F4DCAD65CD5BE35E8A08EE9C0F7BA
      A0D07D994B01AD655E9222A2373449CAEC1458A4DE2BA64715C631A4BC4B48CE
      0371B34EFD696A5E3587241E4349F5609E13A7622E938CD34C04D74C0B982B1D
      E5FC14CEEC46E0B52B0A5145AEA1EECA87E7FE92494EED6CE0CA8DA4AB889599
      B0596DF5AB7485AA935842C7E4BEC1952C7BDFE44BEA7E9CC36F1116AA0BD895
      71DA8019DA254DA1CA51A89EFB7933805A9FE839D822D363B9FA731FDA03CDCB
      1B89B05A4528D784C01208B7729736EBF4033938D85202AF5419843A4EBE4B38
      967BD6C1E1F7A7AA7E62CF7A77F01E977DFCEE545FFCFEE0C713BA9D9F789D88
      CA19CA18277BF77923AECDE372C9917ABE113C0D134B516CCF00842E7043E7B7
      8B0889C3E656DBD6C8BFB4101C0C08444FA51CCD1A81079DD635F65405ECA246
      CB32B0896A1CE471D3045C90B193FE27EBF39E75DBDEC6BBDBD85C56A0CE8514
      3915AE91F7DB40E851D421109544558557D6540539A6F3294A8E50F98E41617D
      CE4CCC491655D533FF541D6C8A3976ADE2E16A32E844B29DB73A82219B58236B
      442238ED7D970F161E3E83E4600EE17C54A23D522BA84ACF57410E7C84B5CB65
      8290161A0F9B2B83D25B63CFCECF7AC7EE2B9CDBBDDABA5BB25F736D4077906F
      9A7B43A4680611C5EA1A56FE2C7A8DF6B157357355076D1E927D0A75A3E66BEE
      B04FF4E7ED31B60EC7D670BAB06F8949E5E918207321D691CB2A3049F73D2E45
      A8406F28A6495C52670755A12887AA9A5C5051FEAB474658037C8BD0C858C28F
      DA60FCB4088B98E9EB3A885B893E70291F86D595C0745A54339839B91BF55EFB
      BB4ABE3C285826522AF9AD07B833C448633F18DFCBDAADA48A0A5D447B4D95CB
      C1ACEA17FCD8E648590A6FE50A5274A6FA4E1B901D7A901D4D979B70BF56C86A
      4B39DE5C63C0A24AC92016392A3FD614EAC10CA6412B82B07F35176DA816C611
      875AC2D6348B1255823A3613F7EA5F19D9AAD25E8DBB9559C01AAB2ACE37E082
      140151B4E292B39A8CA494B83AFB46D7C8F0641F3DAE7EAFEE0A3416434D22BE
      D0749A3159E8063216E837340B8F7BDDCB2FD23EA63628BA73EC3661E0163E90
      C91BAA4DD5FED0826E0CB2B2A9A8DCB446169C849A51CA5DC71D3752AE69B42F
      2261257E76D9B8A6FC2A0CDA3429088D713E83AB451F088DA3CDBD2814C6BD4F
      746585E9D04C73AE3C0951D5153B5120C4CD465CEA79A99A7459E4F030C8B9E6
      9536A098150225D56869C44A51289720AFAC5885D658BF2619A56443B7118EFC
      76AAC2B58E44D51FAA0731CD958899EEDA7A8838D7E6E209D4092EE89A7D6BF7
      B5C251A24BC4DC188A061C414D2765A12AC5A31198E6613B6FF016B369FBA679
      35E54A95CECD67DFC1174928B5FD7A21B982ADAA49140B8F6B9B38336E562E5C
      AD479B5A98D7479418ABB40FF917A406754BF77DB534573D6894C71D0888BD65
      AD5D4D45ACB7C4145073B5A07934DC4C6AE123FD4F3CA554988216A0F9A68DFA
      4273C7B2BEB2365D27AB83053532FB46B5B481D923FB64C76CC5A56A905B5412
      BB815459D8BA6C08D80C19B6A4A4E9F5BFE4190072623064CD23A682867DC950
      90F90B214893B0287C5C54177247D525D5006BE5A0A4DF5D18A239B0023384A8
      152800274B6138ABD047EDB57395CCE67CAD24E0BB0F47DF6163B531BE393A55
      C590C879D89322CCA2B2454D392ACF655C97C915D515CA229BFCCB86ED5691F7
      EC928B1C32657D4CB344BB89548C35A67C16976BC1F2CBF28D4B5051ED44F5C5
      16B5E553E50CB444A66442CC8039793E9B92097387C8BA3074B7B2362952FC5E
      BC6F585D2B5FE3A6AE6427ED914C667C20229AE5A79A289A1DC18D37E3516D37
      EDCBF61E586F55984A2C62652115659AEEEF7926A2B218FD6D3DBE668D10B141
      7ABE9AD0E72EE0D9FB1C6BD69C819312C28B7D4D1678110955DBC120036AF440
      2CDA38306555AA0B3DAB3F825E4991C258C05AA1C217542E4C723161442B51E1
      BD5615B354EFA3AA64E01096978C3402AB9DAE09F2EC4AD9EA13EDD7EC5BFF27
      9B293D7DC5599480DC43AE29B9D968D8D5B9902C674C26869039E16A5EEB653D
      4D50FF840EEDE9A709F1909A837890265C4167FDE5D3D9F926B73B9752BB534D
      DEE8A66B71984CC7570DA9C685D47472664133F1C742C5ECC6BBB373EBDF1B5D
      396A7BAE0BFAD5E1197E454082BA77B6F9BB77F4BB77992EB0E0DF3C5F92942E
      E0A0C3D836906F6C1357EFA80656178DAC74939F540DF53C47993BEE0C0F6B41
      E2718BF444E52B68A6DD4CBE6DEDD11E4CA790CEAAFC9D8130CC609746C3CCE6
      BC375A83196E8421B1EEB665E8240BE5C6999C66924AA646416741F6596758E2
      C643D89A489331BEA4E4715237CAE8A7987B590A4C4C737D13E35D3F8E4F1454
      A8964306F19DC0DED7CB95AF4E4E34733B557C4ABDEF9E499A988A0CBD8C7BA8
      9C7B4B460A89E2AA0207BDD322450697B8AE86E55ABB67C6BC8892220473E257
      E696BA91AABD89570506EBE946619A15BABF78ED45B5415A5C6BDDCD15ABC93C
      59395F68675EACB97AB52C5A88899433BA034346ED993A480594AAEFE6CE7253
      99439530C472CF0A7C8A0C67EB54BBF027AB4FA27A12F5F40A0687829E73F9B4
      82C847C9B9991E99644A91566B09F283B5617977C0147DCE4615ACF6827977D8
      FAEEA0ECFFFD31D5419350C2A99354F3A250CADFC6274941A76A57482AC67E65
      BDBD09E88B3FE334AB4BE83B92C0AF28D3852BF19BB32C2FD52F8B57D6EB2C4B
      C9FFF977EB3C9FC9E77FFEEA60EDDB5B6CFB956A6ED1445B6A701303FD66D3AA
      777E576FA0EAC7A0D7E52F6639F9B57123936350556195D18094D5161CB9903C
      5B4D97697D03C8FC05DB5B2CD8D66AE3CECF783F8B6FB365784755BD60E6AB98
      A16FD477AADF9113A9BC807DCA6C9A4D61086E15DDE6F20E350ADE0AD5C439AB
      C19D73D3EC2B09FAB52BCCEA8D792D6174A8C900BB42839EF2DEE8AFBFFC56B4
      09FAFF1E232DD620CAF124FA345D79FD6368F63B16EFDD41CB276B85AC2A9D3D
      A67CB169035093ACAC60160434BF861B842FB9F1496A639A9E7539BB9094709D
      4A1546E4EA19BAFCA5B26DB86E9831012062A8BF792DC8F2E6DBA6C915994349
      D162387BADFDCACFA3BE8FBFFB43C7C63FF6C01DE21FC7F75DFCE37AC31EFEF1
      DC115DE2BB7DBA64E0D874C9D0765D75375D02153BE0C7F44623BAA8DF1FF5E8
      AABE8DEBE85F67E0F275AEEFF9BFAFCAE55EDFDF9BCBAF457E779B965D6A35DA
      B699BF0F958324F33FB77D4440E2A5FDE7BD7C097FB9FDE54DE155BFEAF3D66F
      67D160F0F617D3FBA91E0030AFFEBCDBCAC3C499ABDFA1FD43E3840B0CD7790B
      164FBF61D17212B5BEBA71EDC65E6DA808182F3C05EE9882F5879732BC7A9785
      575FDF6E69AF2AB9A9ED775096F729F169927E135AC086BBA304A3A4E062013D
      B12FA4B723B5A562BE5CC445AD142B9FDCE8B5A88AD9EA42333DF059878F0A06
      9929B2F49A3F9A9257549D759370EFB0822F31A30C4D291E8D1DADC1E0A68D9A
      D46FD17BF05396A7D1D9548472CF7A46D5547FFBF8CBB33DE54C7D0B6BF05BA0
      532CA6437FCF5B8F125FB893F40E7B932E12DC34984B76191BB5E5CF97B696DD
      ACAE71C3BA0B5AB7EE8DA2AACC9FAA1F7E33DED4E63575C8FE4859EE6F256CB1
      FE6FB2F0F7824007BECDD27548436321DC64F99542554CC54541936C68AE0E0F
      7257C1566EAC98ABB7A58E2E3D336A13375C45EDD7B38B0DFCDC0AF8B95C6AD4
      B86076D12CDFE2624133188DF05E131E8348451CA92C19C69561E316DCB6F22D
      22130F3775C59C23351F4285D11A3DB62AF1FEAF9FE9579446E23DFC799AC244
      D01B69DDA5E21DFAB5961FFC7E78D9F9B7E6C5C48EF5F3B360F07329827F2E60
      A33879E1F8B4D7037B0D7EC2DAFE1EF2BA702CE057E3DE161C96167D77219BD1
      FD5F87D15A88B97FF506AEF5827235E1153756108258268BC9B352893D05CF93
      967FAA2BD69FE05EAF5C29D6E9639DA7CA982579CD2547B44CDDA3516322722D
      16E1B25DE8325C02679B56D5A45D5BF700EB3E12A558B8EA3FD25A999B4758AD
      4215316CCC6D8D53988C3A7F42CDA819E708680C12E1194E6BB83EC8B44FE76F
      5E0C2D0A275A2FC2E9AB5919E35B830DD945BAFCAB37744015224A95A0D57573
      22BF521575AA7152E7709929AA1E29CE1B7771DDC40F43926E112C229DCBA57C
      8B8A07738B2BBC8494A70487251521EE16AC639F372AFFA9EEBFB0CA9BAC8A7C
      45AA3EB52A50EC779136A08C77EFA4E452A1736A30877136215030D30E965277
      84EE2D536D17210E0D559014499B8ED5D9DCF0A2AE518BB4C795BC0D32B229EA
      B29C64C2129379821654CC69CF8EAE953446250C822C2530D149CD26F18CC402
      CDFDD56D311D5DE6904483D93C46DB5530354948196BCE896620C3B3A2A920FE
      00DB3B6AAE9B5E1D2BBCCCF2E4578AE8A57A8C1C4D6208290C5898845990956D
      8E79361E6785AA44BBED2681463D10884C5E2AC287FC1BEB4A16AB59BC1049A5
      4839C1A8A7C226609819F34D4060401D5D3D69CC1D2AF14D935FA59E24B23337
      7942D5D4777179DB5BBB9523CD7573856ACE7B51D536982A088A3DAA4E5BA3E5
      C2240F6763EACC0DB923D08074EBDE14DD9BA163DD5D244E93346D22640DEAA9
      A29B97AC0FE88B45D44CA599A27D9DE4258DAFDEA9A3AC3B7511BCC91AEC56ED
      1D9AC264A5D16D119C99A7187068C37D0A258C465C538C8EB40A91EF9D985CCC
      A8B9A86158E821D53742A141ED2BE7A5D0233DC177FB41215EEE07C2B608412B
      B996DD64BAC5148113061FAC0D1B6A5F8EC2B3A9165A916588A55073E0FA0AD2
      68E15503111FC2DA5C2514EA8A06DBA78FFE035132975047661C264F37E7BE28
      58FA19213B50D3D45D4CA64E2D7BE9A1D2B1798DAF519F2C1A9149C21FD731E2
      035560CBCF22549394A4B25C3816A2FA5AC2CBD591D2F04A436B288C7DD58608
      8D4919D86EDAC7CBC93A61E46ACAB4858D56831A49E5650345E576AA670F34A4
      BB5601A625BF42EF13D5A0BE866D650532659C12EEE7EEA4D4FF57BFD7E3D0E3
      542B45614DE04169DF5B4CA7D6B51EE7A0A2FD5D5CE342ABAA8D0DF1A2EE04D1
      550B590341A7B200180785D04EF445B34999A4BAE0D73407302A2D2724F0ED1F
      8688A0D0DFDE7C707FB1DEBC3F38A1D3F3DDBB0FAF492CDDE4593797B9DC067F
      C82EA44B17E06A2ADC34322F99458CEDC86DE19A3FDAF722D51CC888B98A09FF
      5824E6761AD574797817577597733D8DDE97E77BD6CEFB8CBCDD8334DDA94F63
      950F37DDA58DF10E1C6BEDACCA5B42B50366A406D918BB8BC196AB8E573556B1
      484A1DE77C3E0F3DB3BA0955DC42194EAC9CAC511EF2F59C8A5F82544C3A1968
      5A464BAEA12070858A93B0686EBAEDA4FFB2D44E3A34C1F14B50219C95BA8C44
      0175290409062CAA3AE5F4A063834379AB5BF726CFCA2ED26509554E7166B2B1
      75F0E3BCF2BE69F4177672B515B3B76098F9F370FEE1B0F6CFE6452C2EFC2999
      0CBA4890E5B2541D001C8C9D37307F59B1E8F0E94D1295970C4054E3DC977390
      02554E124E482E8506A955F7312E0A3DA7AB626409BDBE7F7B7E725C58BBDA38
      F9087F3EF98C9FF2A020C269B254AF9575ACF293CFD9483CFDF4D14A4520D32A
      F6A6DB64329072FC0723D161369E92D63C337DE4D531D260EB0D446383017CA8
      78EEA78AE7BA48926504794DD31AF1A3EF09D3073FC7226E0BEB7075E5F7F6D6
      D4A435D9BFE0C4DF4B9CAB6C962B21AD8CA070569410E320E8B89B61C7E5CC64
      90D292A29829F458EBF3D16C3C55CBCF67130E1A51A442B59F3396829655D5B8
      2B15F7FE6311866A22182142054C43CE74C5C42A1F741A8C449446B2A2980635
      DFC3AD286E418BB14A21AB59077F2CBACCD750E892614649A744853515E0A0BA
      B82C8915BC6B9AD6B8930A452B4BA3CEB2CC1213384D54030A2DF2C30F04A556
      D6809D272A307B560566997D2AD1AD0919C84B9336E27921827139B865FE1B94
      E45329D9979F58DAC54D5FB2E5ABBB2DB6B7820F710C29403589D0C2C5211E44
      F60BD9290A7A35E71E5E0E9E73984185F055FF90C529F85B3E5B5DA4DBD2C332
      9B28601A35338E28722D5216980A2090D57132A9AEBB4C54504C89D74261C65C
      CC723DFAB76F5FAA4769F5FF87A255A3A04FAABAB4DD7FA7AF35B4E12453D118
      D8C2601D05D15B4DA68C18AFFF9AAAFEF04B05E0FB073361D40CB73D0662E02F
      28507548501C44B393F99CBCEA1C244DD52864D8FD98B27BA5CE20E13A546790
      A97C9BCD14604E03715FE7FA57B715F13176F69D7DFF5FFEE55F3A99D27928BE
      CA3047EFE50D3BF60B1C118E5337EC01A50C1BF751B450E72EE9115C7A29E392
      F3950D54A60A0469E72823C3839FAB86A9ABEC88C69FDF519B48F05F2A994919
      C9051FCBDA5710EE5376918BB16AEDE8E2E6D0D6B489C22CD8BDB3B3E3CA98AB
      2A4FD43E6931BA78F47A7F2E1ACEFC4DE434D7BA6E57E9B850BAFC688069EB09
      032680D5C5752E3FCC2ADC6485467266B175246EA854278FF66531D6F5AF85E5
      AA9A8A0A6C93A232E428AFFCEC0BEB1F33EABCE18FF86311EF324BAB492ABA90
      920B4EAFA4EEB051A5620DF0533A366199A7A6EEF26EA90029ACBAEC6E0E4CBB
      53345BEA601B943B35C916EB4CA6A99A7F5D411E1B0C3EE57472495D61FD737B
      EB6B7B428C88C72375A930835EF1EBB727AB4A3838888CB9B2BA9951F313DB3A
      9DF6B697F04F3D678C2BB04D51F29D5394CCB9D7384FC9AF84DCD051522C093C
      408A587F52F10722126761BF57034216E8762682090F730A616E7288CE54319C
      314B343D4D8E9EAE36A1BB9502BB2D88BC84DD3E55D0CDE38CBC760875C9F86F
      1A836B1100AD66C62664F09DB00F4F0B57B3BA6EB88F7E0E1AB68B247EC0BE20
      11FF42572656436FAB1AB90533A21AD305EBDB18CA9E2A1735D3C24758F952CA
      89A8C96B3EBADA07336BAD213AFE58C4D76891C4894D6CD9BD85D252D71F5608
      3635F14503D45C57AD31B4701789B5D230992B42AF794599C1F338C0712A5A28
      6555B79D74925AAB58CBC0231B97BD192BD19CA26756A9C66C2E622BABD17C04
      DCA089D945EAFCABDFEF53B58F021667F4093A386CF9C3779AAA24528DDDACC6
      137674A5B66EAF362A8DFBC34A4A331F9FD180F8296363A9562ADAFF8C2B55F3
      842B7EBAB8E679CE6F7154EAC311E6A2B8542DD8220C75264770C765A26B3B38
      54C67D1CEA9CECA9BC00DB79B852AAE2F2A9A008B882FD0C24BB921A5C9CC267
      8227F454437B74FBBE895C90A8AA3E4798DEAD7A7A65A9E101847ADDEE6F514D
      FF9DBF1DAD360FB6B7E4F497AA4274F7832E11FD6F0A142A0C8DE73B2B5BE4A8
      9234CDB22B953936AD609C2F37835803A9F745DBD425A1DE944ABD34468A326E
      1D19F7DDC51FF1FBD457F951D7DFE8604716C929B167998B49DA5CDBD7068BEA
      7D19B028773847672CC6C045B94305177525730AA539FE170800E8E0F544CD61
      56111167DFDEB7FFF30972C8B74723F29E3A1AD1276D649B7618C224CF220AB0
      1FCDDA8CF9995A9FCF8E8D96DD7F823CD0920246151D9E1F1D547DD79D8C74EA
      F5841934B6EABDA3D5302437A1E97D70F6AC37EF7F544E6D63EFBAB8543D3E13
      D267BFD7C5F7FFECBB561384AF532FAF6602C318612BF15AE4891A9ACB7E18AD
      4C8F3DEDE2DAEAA12A1D5E04D98D0678EA0BBCBFBD661AC35EF45AB695ADD4CC
      7DD77DBC6AE69BDBEAE624BD5E02D9C98F79222A7A7BEB208A1AF3E4B9F2889B
      A1420396FF2514EF17DDDF958B7A43B59AC7672BAFFB5879F00A1F0B0EFEE524
      09D969D550C55C13039F1F447882C7746383AEDC63D56BFB1DF5DA527CEAEDFB
      371FACEFA844EC096EE7EA94A78C7122A983263155FDA16E9AC9A50A6D5B8787
      0C01D5C5E5D1AB53B628CB2906A113164F4DFA6CB4CB3ADA852A16695F8DA055
      E96C65C7719DE7D1BBC33DEB03B7DA5268B5F19BE3B39327C8C41B91BB5AE49E
      1F9F792F59EE9A08C0C7E3D31F9EE066B6D11ECE4B78B4BF58EF0F7E3CD122A9
      8B0B399E1434EC4498490B0A4F81BA9929945B542E49A7A3130C9D0E2B2ECF29
      767D233869272F54351A0528B228D233EF3BB9BEEDAD233D1026BA9D887112C2
      4857AD167122D3A8302A53355F9B7967C21ACB9CC01CA6A20C2FF7AD9F28524D
      F59DE50B4227204F5BA4AADB76EE61496CFD2AF38C5B77395D4360CA05A16666
      CA624E551C9FE7A8117E7C55F8A763FFFA635502669FA6A651D6262D14520065
      0CA80C24A17253BA94DB103398DBDA2DE62A75FD4E789B124E4A8BA061DCA25C
      9D8B15F527D2E8C36C223B195D7C7D76808FB7AE7BFB5E175F9F6208DF60F4D3
      8B02B77C930924D36A6C2AB3E054A8663A83F6A77A2EAEA4152413C2C449229C
      2672477561A4E978E6B6392E7AA484A6BA795F21C25F8AE252EA764E9186B394
      B5AF6AF13D39F25496F6FC4D46A328D224C89B433C3719AAC767A8FA9B0CD522
      53D57FF2A6EAD9D9B1B2540F595D521F483A0BACA24D7E6A4AE9786B97DC16ED
      DE3CDF233383F0D41B7E2C191EC6FD01D37CF51ED77FDB0FC3F05B4CFB22A9F5
      048F451BFFC57B09C6F8C5DAF94E4EA84681BB943F047F976159EC98CC909A8A
      DDC905565E8D5ECA4199126ED8B4B396BF46D4FBE0EA057515FF637BEBECEA36
      4FC6D68FA79C437D43B81FB3D2A5EF8B190B9C5730A827BA719E1CED1F4F490B
      EDCBCF3CAB1124A87FB0473FA11AAA959F3B2B3532C60B18DEDE754E37BE8833
      175F55464B2719637B2BE682451800AFC8A319BE88E0FEC147B9949F4524C364
      0CF34A23F1E8D95C098F07B84E22D555B9F39A22AC7ACE105136CB6914A71E96
      B9A3BCA53D55C2AD1FC4ADC9816CF466F26C912ED28F2BDAE7A6635429936412
      5155EB847CB87192E2E5E147157B3AC4C7CD14F0B226B3865C59A932B87A9BEC
      E0FA23B349DAD15EF79D5359A82145B3B09CE572E73E69746380FA39D7A84FC5
      449AD998E3441553D60EB99874951606D2C9A41A1713E3D434A046D6EB5BAED7
      BF51AD11D750C369D5D450E52B75610D7B44844DDC45E250C1B4B54BA2FCBF61
      743C3F11D3139AE29417FBE5E792CF579BCAF5EAFEBFCC64519E134E33DF0FA6
      217815AAA9E532759EF7A3006A3806682A1715FE139D60C2624B675C914B7E8E
      BAAA8B844DC624C7AB0894CA9E259DB571AE358E5530BB50853DCC1B245CC7BA
      E4B993CB9A342A49589954B1E8838F6F3926528F2DFC7B914DF6AC491243CD8C
      29BC9B88145FA659A4422455927E13CC583398B17A9BEA68C726D6B128D631E8
      42ACE3174BFB176734180B1AF558D7716AE7E24956B9B45DD9D971C7BD3FEDC5
      2A9FCF72EB4DE9DE521ED0BD6A7C04813D2807A9A328237F7C75BCD1A5BF3531
      D0DF7736CA7291B21C6E94E546C9FCE6A5A849CE7A019C67A1BEBB2215251749
      98DE7615D8AC263F87D9784CA23AE5524A13DDECE666EE9CE939EFAD634B5D5C
      E56A477EA3A37E838EDA38740B75D4E8A9EBA8EDAD3FBE95CDB5A4559EB229EA
      2FD2EC8627924A2A79E9E4DAAA34EC1B2E5CAC0663A86D53F0F45270241604E8
      F24AD52ED2DF7A27C57596448575A1F2EB8CE0904BF850B44EDADD68368526A3
      CCBBCEA9D1D44B95A06B9348DA63B70C524E5B70BA7E91C61B50449127D031FC
      1723DEAB69E035762B45C7378AE5B72B964D55D422C5622FDEE327A4586AC174
      C0581E1F5F1F1F741812EF0F9607FAF1E4E088224E2C27E5785ADE5AF82871DB
      C9C57CD6FA80D66374DDEBB3834E4FC0366B02DF69B6D3C8B8847F21092B4910
      9A8E42DA4961A715A1984A527D5D5C2DE484D1E954B0F4C151DF6DF4E76FD79F
      BD8DFE5CA43F17F73D3E21FD594C090DABF3A900D54EA5E7CAA7525C75781585
      1ED50D114C2DE05C897DF4F6E05D775714A799284D0D4F4EA8C91D75F145742D
      B8E2EB248BB833BFB06229A860AE8BAB897271F1FF46798BE04D36658DB9A3B1
      6EB835E72E7CEFCE5CC823C11E5F27118D306084D12ED287A6C6E90625464FE5
      487D3D72AE8B4BAA53A69DEFA0DDDEAA176391BED5109C94F5A2AA0A9D4B5117
      BCDA296551EE4F05B1A98EA654612B2A51671448AA4C74FF9BCB13611CFE37CC
      C5E70A01892AD4BB4823659F89A2C8C244942B2F97BA773556B45B306CEEF76F
      00A2A27E6CD357EF79DC5BDEED8495FF9ECB759FD8727FBF76D67FDB8F33E75B
      AC96B5D7B759F0E4FA9B2C18F2494E8AAECA766E49848D657DC82FC424F955E6
      D66E7F8F63E1F6738A81C76A8E7709CF564F58562DF98BD2E5D878D0E0EB3632
      BE1867FA2D5FFD2FFD056999FFF8D28CD0C5CD8DD5C8F06FD14ECF03AF08E19E
      0656A649587E8393A9CD0F70850620EFE21E4EBE111EC287575F7FC36A41C2CD
      5E6AD276365B6D4E6D6F4D67A59EF6C44E1199973A0069B28934EF723C0B2FF5
      A9505DD990DE624CE3B7BE7A03F60E28BCBFFFF3CF90BD95E8FDF96798D3C5CF
      3F9B06E3C83A4A0866BDC45276966EC73DA3E98F2CD2EA2C94F20DE1F55E2691
      0EE294127BC97413619919CC9A6E2E9396A8467E524A20C5A9A06C378FAC3A3F
      3D3ED6056C608C2AAB5DCD1897930B52CB069EC70C37E8241DEED608ECD14AEF
      55B5BDF80F8D16872FAAEEFC8EA64EF4927F92629A4D5E1EE4E32C7F79301ECF
      26BACC744A19B1E252CAB29B9CAD96F7FAC3D1F94BFC65B3C3500F57E23C6605
      0DAFC015F4B4E79B36BDC2649046D66CCAC2DDD81E3487254B679D456650247B
      6B32D6471F5EFF6FEB12744B3B6AD3E8059D2E188F14491AFC524FDB6B36F06E
      D2868F4E1BF6F69D4D41E7C2BCA1FDD4F3863455A99849CB1FBDE2E0EB18B66C
      A8E0F0B4D97307A28F3BBA634A19E8398154C76689315D459757887C04146CF0
      BC3BA94B1461FA2E28A30B0213D84A9FB95B5D4F22524386B488F94080CF500C
      E34EAED63042DFB75F358672E759A9BC1B31B948494FE6E37ADCD56EC311A2CC
      0A734C0D9D40EEC6F32ED2E2325B794979256F8B2636498D1EA2514A76BF41B8
      EA984EEAD7F7AC5FB02D94E4E33DAA979D8AE85B84EAFEF40D4240BCE7041A7A
      370CFF25922C2FBED98226D9447E9BC4C2D75F723281B02A3B29A6B6B72EB334
      B2CE2E93B8D4E0B8452954D18932CD28D075954C795264C6430BB570C275F061
      77C98D811B9F437C95B350235EA85B61AAE2A5798E143572290860595C955443
      0027B19314BB472FF6F2892E1F7E68652B3D20EF19EC9980941242B706D5A7DA
      8022DCE3488D66D65A55214313D670878755C9CF04D923972ECF108A719AC5B5
      48525377D161D03FF5EA3C9B3529F0A6B79CBCBA80F5A7ABA2B0DFCAD5E45E28
      68431D1D2EAC5D6AFBE021F3EC3474F2FC1C9679FAA74382E04E68AD93F4B6CD
      A9794F551CB4421EEC9E26D320133490F5B808F16DA6BB64AC1FA95F541DA62E
      D2667BABD90AA761D1CD39A7C8A9F69DA219CCEA58A48519AA4230CC0A3E5D37
      CDA9D401356475F28C685C2F55B023192649A121EE81F7C799F5EC8011F7165F
      46A53DCFBAB8EA2515590D7CA9E215855DD5D8916835FAD1F6162519745DD42E
      9FBC9F9EEF593F6539DCF02921AABDCEB39B8252EA0769F9A7374E2725CAF656
      C500538ACBC2ABA651CC59763516F995D6A0BA32F195923FFDFD7DCFA4F04475
      E99E455430BFBBC8AC4084575DA448A37523A6251AD4F59F4EDF1D1150686632
      5393EC66CF7A964D9E35B44A17177CBF5373379058B38ED3EF11C27C15536873
      6E288ED1CDC0C3F696268629661494A021604E181D13A85198116AD67591D23C
      0BD59C0AA9304D2541C66AAD739BCDF20AE02E89F5DC8B4E13E4F47EB7B95EEC
      EE4FE7DF9FEE71DA628F47E6ECA934CF544C6FF359C1E767CFFA4E96C734E59D
      471654B36441B9AA53EFBDB83EE16E676BB7BC14932B56D77FCF2637D1A093BC
      A409A7DA2989222D886DED1AAA69EE794E44A08CB09AAFFBEEC777DF59BB1769
      1688947F851FBCDFB7CE2F254F2F7C561204B1046D158EF1E10F943E2E699A8B
      AE29D7FDD0F4AC926F52712355B6CBA08BB8ADD10BDD398ABB86E27F3DFDEE08
      AB0E4CA229B34E8FDF804F791AA07211BA3BDA89EA24A880802BF972D54CF0F1
      DD91DD5830F6F1E3C1E10F90571C26A51AEC4EAEB4C5A9E16A8AD71FCF8F8C48
      22E344F7500459744B9547A52AA920FC235CF9DE9A7495C779B1A7123FE05298
      C3E377EFF838B37972A17A6984CA0D71AA35EEEC4C06A57BDC977AB49C2E0CE2
      75364DB30F6FCECE1B7AC9DA655FEED959C2955FDA747D66220764C0C5F1F34D
      CEF90BE49C37580F0B73CECE53CF39CB62AAC74BE989C754260E5912C838CB21
      368A7137CBC97402D5F15FD150DCA284036A4133E671AA8716C0D2BCC8655170
      575DA872A814EB493372F7A62654D8CDB5B771CC983C835796F2611490446532
      4043D248E192A62291EB53586FCF4FA80998A3CBD0A9736045134948A8217E3D
      E9689D12CD09A1AE5A2AB0649D31A4FEC49CCDA5E21F332A4B0B72F0902CEF53
      4617245C241C2950B142BACF20C432E47E01EF665FEE5B7FFB7F3E26E559994D
      7FE9229938E67314A4875C90994DE647A7A8620C9C297141015688CA165E4E98
      CD523A8DF29A8895DEB219CBDE47A6A793AA210FE32ED28B1D8C6A6A85EE41E7
      39DD3775EC488F87A175466ABE6747C30304DCA274099D17A3486EA9F23E2C09
      B03FBC5469CFF25267A4D8F42E4C1DBFA71C5BB2D0096EB5BA8133589A4154F4
      BE8BF4591294DEB33EBDE5E2AC3C4B4D84BA05AD7510FBA02848248DC504672E
      DF33DF07261ACD07B6A3E1681D3451FAE9AF87FFDFA9B52B27A602EE574AEF56
      59CEFF7C3EEFED927BDFF9257F3C797BD661D8AD2A7A3AE6905E161419F73650
      1F79DAB0345E59271F8E5EEFE1EFB3A33DEBCD77DF1DF0DF67F4F7F95987573E
      D3C3CFDF1D9EBF9F734AA9598E4CAE36C7DC18139FCE7EF8A88DF22E1FE64AE9
      E98E3DCEC28231AEA525D24450FA99C963C1A8205948FAA1CBEB55566503D0D3
      4CCCE6785C770F77950B7876A47CE0677ADEFAA5E48E9D864DF3EC85DD7707EE
      D0F1DDE17E8FFE3C231328903CFB98251DB8806257BAD3493D8862D5F0DCFE7A
      F8EEA75A5874915420D4CA6B9A69A61D8A6AFDFCF3F6961A386A0584ED53EC98
      62EEBBF9A53F446A4933537350BD4906A9027692053C65A3ABAB736B7DD0700A
      9A6A018780511DBB8AECA357A924DEC7EF4E4F1B2619FECA67D36A84A4282F2F
      72C2FF55D3FDC47547A306734B86906F2136EFEA8193EF8EDF307793C9AAE4DF
      5FDF7D38ECBCC8ABE9B2F369322BF0AFA99DF8EBD9F1D10E847CDED55851DD98
      AC16C8A1C6627E5BDF7F3CFCBF7B0B32E4FB9B64C31748366C803117261BDCA7
      9E6CD8DED280D2B9BC7EF91EBB762279E43205787451C96C82D3B26F7D828123
      62B2036121B2A1C86C90A9E1B8BA3582F29A829ADEF2A471B49E124FAC36FC24
      211D330172F98F599213E2A66A6763B4A1885B9C212CA34E2E4F6DB7C0865199
      CF322C21DA511AB114DF56C806CFC8E94D544B1FA7B7892BBA9989E210DC4183
      6DA90619F24CF22C712AB25EF98828BBE9E4F6EFFCEFD978CAD389B2CAF85356
      CDB3C2746A4EB3E96CCAD80E9D5CE2F18402F62F75E09EDB7661CFAABE54DD5B
      D1C975BDCB2ED4E9A322896B99DFE4095E7D42E524CEC9EB4E2E697BEB6F9F8F
      C09034FDAC142935CDC8A92E0CCF29984C4542148DB8CCB3D9C5253412FDE0A3
      C913E3005F0A8A53715751518AF174DF7A5B5A630E7804929AB7E2594AD79594
      2AA453ABA05AD840EC2AC93488077E74551865DC0009553DE7348380A275F5F0
      C87DEBA30E53E0FFC31FB8DB8453A69CCBEB24311655203D500AAB72A28C387D
      7EA23AF7295173AB816F9FEF7FD569D5BFC5FCFF02807A2BED2093187BF50439
      E3DB5BF6DE53B7ECDF37A7B893D1D7C913FE7E49DFD06E32A1FE4AD55879314B
      0559E7536885367536F484E79D25473339BD7BFE4E04B06123F2C4F7ACF343EA
      917B87F5BCCE3E777385DB5B679A6975F59B08094012460047E22E33052DA1D2
      E8DCABFCA737ACCAC886572E29043F1C1B89EFB546A4BEBA6E52E354A76A8BDB
      49293E5B97103629091CF2D0F3AA3D503B2E5F3392F5C495178DEF2B368A6B91
      E2F29FBAE2FA51E4899A169CFC4AA00AA50612A08C058F62E868D4E1C38C11A0
      54F270C9BABAB7AAB72AD4DEB7BD3DFCE5D35F23FA6B68EDD25F37A2B076A876
      90BBF568E93BCF3772AAA2DE4952841B31B5484C0D9EBA98DADE3A24E0867116
      2571420DFA8C79399E8A3209923481FFCD064B90E1AF23894526D65F8FD927FF
      EBB16320630B828C2DB2594EA00754A7D94919A062CAAF4521DFD37AAA004491
      59B349A142386A20221B751AF78EA6C1CF429A2AA4730CDD5CFCEBDB521ED0E2
      AC544E2EB0D9F04C728AB370118DEF5A4152169B24E3174832DAA34D927191A8
      1C3E7551C93B89534F92E13AD125E8E32C198B092862FD737BEBBF7E66FCCC9F
      E334225FE6BF7EFE37FA924AD6BEFACB5ADFFF9F8FC7A7EFDEBEFFC1DAB92CCB
      69F1EAE5CBEA5DF723799D8809C188ED43D8BFC4BF2FCF65E1D14BBF788B2516
      2F5C7F30B207C391BF731F226ED1BB3344DC9DB7F7EDBE3FC2FEDD7B7B220C55
      6D30B5706BAF17F5C2911483513C0A4428FBFD6138B47B3D217A3D3710A35ED0
      B37BEA8FA3FE912BAE1FB9EA3A7FD8EB0D5CFD3FBE1FE07E0757D9B1FADF8FF0
      3FFD3BD25F833ABEC4357DF551F4BF8DEF7DDCEF7BB8DFD7D7EAEBE8B9F435D8
      94BFE66B1DFDCC487F46F3F7F8DE33CFA277C1BFDB5BF41D7FC2485F853BDD51
      E349525D4D3F77F07B1CCB9E83E538B8C6B1F5D743FDBDAF563E1879C3613F76
      9DA01F0D627728621B34F2A2D01D7AF6C0D77404CD3C11D042FFF94FEC33B835
      2FD275B97596FE1CC6F617B1249955575EF5585EC61A7F2EE0A42839475F9188
      919F7B3FAB9CE1EDA037FC39CEB2527F196669F199BE909368722973C977D32D
      546546C2919FA6445B98FE5CC4E524F8FB52EAFDCF9AB2A02B2FA9D933991062
      AE30BDD1910C33129FBBA7BA81E9E0F4E460CF7AFFE3D95BAAD63FB2F70872E2
      4337635D7ADDC7D7E021B20D29B6CBB071D60535D050EAEEED91AAE9A2FA8334
      F995AE505D4B1D5EEF9B65F5E80CD36222F86AF2931E65994DBBB85EDDFFDB83
      14C2A2A9272D23B42FC23C8153405DCF0C0A588CAD5DFAE2E2322BCAE79C07AE
      B2BB1D8D9118F0E8E1104B3F52F344387C4B2E20C1875A53413343B27436865F
      989404BD092709ABA3C9A23C65834EBF6E45B476A319175D09EB5228F0945CC2
      B462E8BC6076F19C2067707D42F34728F6A2022F6AB098A012C94E5251F34F7F
      04221A50AC4BCE648B28A213D2621F40FBA2B0FEFAEEF45DD503AAA76312CCAD
      AA6A53C960A2615648752D0F47854284ED9A7327FE24B99818981E5338FEF6FC
      A49374ADA0CDFB3D509633480D88456E8C65E8C5424FBC854C4E22DD665CEC5B
      076991EDB189BF73F7DE1D8A6F10CC8792629DA4CE87463D8A1E6646B928621A
      866882722EA9CD93CF161740B699941248282D72983B49934A9ED9F5513C1453
      789B15F6BDAEC39E2860536ED6E7EEA246937E94508C88AC4D70D191D4595EBE
      974729F0A1A37A9582463C121028F1E22678BCA9D0681716193DF5B0C87CAA9B
      AAB2D820AA6C3E8E1FD308BA88283915058C5E6B87E68AED5857F2169ABD9BE6
      1015313410600DF67567D732A7E4BE6AA8F7890BA84D167E9970721607E69F94
      703AA46456CE8EC64D92A66CE198BA636991CBF6190BE7B22C78736401E5EAC2
      A42458A26BC9232133ACE356639004F232997453666913D9F6C84436F8A8BA57
      5A4DC86398AA95CFA12E12C275EA680D43E52BD87DF615F454238D3994C5D629
      0C5BAA6950E32F1996987D529878A7D5D4A46A260287B45271AB7265AABB883C
      2AE582F1AFB3095CB1F73C928E9F5CCF5EFAEBE1BB53E37B35B640E606E0A2D3
      8CD67BD9EF53B8A0A61A9D3FD3B0ACC673548D58AA3FA926710BD94C4D3CD9D5
      6C6A45338EB471E756A4F99AF1B408E989A775CC26B94C93CEAA68E3DD0E40CD
      D76A5AAB2E9BFB6486BB92277FA4FB452A821704B6DFE5059377A6DC576B47E3
      6DAAB8F10E1826351658579D50B34A1244073F36FBD6E730F318D90A4283FD51
      5584B06F9DA9D8316DFB18B2020A4AA469D6E2D46854421237249974A9437A6B
      4E91E4E035347ED1CDB352C9F71EC99E1F39124FF08C9AB04A4293CB4EDF1D9F
      9D3036C2BEF55A8457171C64AC6723A6C938D19E3E4FFEC6BF1542A1A616B765
      759C4E03360854C45E58FF98C9A2344A492B41AC28170A8F51CB9D38171704A2
      A11AF0A1F9026926A5436B5967AB797F11FB86264DD4DDD62643541F443DE68C
      C85CAFB16EC325AC4B8555C7A79B124313713D6674FA7D381D389C9FA89E88D2
      6514B16D44EBC8D196714C9597D738B5D5F1A528B98AE12940A74ED2CF508F6C
      D40FDA5027E229A6344C575820EB5FF847071ADF895AA04CFEA06AC16B210D29
      6EA74E32E5ACF60C3326DC294C8081C9AF32AA89AC016C55209000283A4D650A
      96FF982520D9F9ED54D2CC9A32CB61045396663A95F0DEF6AD134590429DD7B9
      93B9090F583F4CE8E83255364182454182FED30F121877C5C169F8C439EA7B09
      2465345019A816E07B461218AB027A0C1E46C648C6AFD81339A4EE9D58799555
      F061E5EB0406820B4A94A694942A055ACDA2E377A5B16CDD2C90A8F5235BF68C
      455659B8BAE456A1B76AA4360173EB620211ACA7EFC1647D5656E4203AF3E5FB
      268F1A65B2604A171CBDB994F3CF3545CB5AF9F277A0B1CAD16414F601B97537
      C346CC6D6AFC57CAB7273FFEDDF8986451ED9093339B6AEEDFB1C2CB365196F0
      2AC83E43C2859759AEA25C4156D2603F9AFC01F9D6494124AEB384C0FF941347
      80E021E103521993B11E217F338BD1062219CC2E284AF855FB7EFEB845F0C34D
      11FC2259F2E4C77A6C6FFD449ABAA4CA2C3DBB4FABCC84B224A598E801B0123E
      2A35334342F0A43A332958D951F5AC6A52C5F80ABF13A9F55E7E9EB16777564A
      31667FB6B8CCF42011584347ACFA4571658980A62CF16B687D0E39341B7712D2
      B70243F9A8E7B2EDAAA24913FF7B5E0D9A221B5365D7C750C72642A3AC452284
      01133882979C4D822C9F5847EF0EBB48134D911D0273D346A2F5F668675185A9
      0E92767195E7B43A5D285441582DAC19E2159BC1055D5CEA816E2724E1A0F262
      8D51E2F8A14EBEFD2F6BD8EB5D7671819C46949C7CA1818769028E0DB3947DC7
      496466B79AF258A80A6EB2EBF29CF49DF9F16715189BEA216D21F6266142A695
      F2E4F418E07707EF8FD4884F261BBE785B9D8B5D358E7E7E0EFDF37DEBC3A431
      1D57A3FE31BEA1B238F6F418EAE4D73FC070FAB76694E9C2911F6468F1FC6D5D
      C6B3B155BF80AD3AD8D8AA8B6CD50EA0C26A2BE293AE37881291669C582D6FA7
      7A3C90C284EFEF0F9FE01EAF5CE1BB1634504D46F2652475BF91B466653CD4BD
      491436CBC5A448EBEE2CDD9FB1A7707A6E59FA8EC70A3216B2952A3CCFCA9C8F
      07E8A78B3D096655674ACA8C309DF4A0862E525563E742A528A3E465951529AE
      926901BA4411AC313D37612363BF848CF5373276918C7DF2F87C3590E787A373
      121FB045D8108EACDD32CF6601554C7270FF48DC4C2E66B4A5AB9EB92F8B8E3B
      F26FAA998F3433ECE0F05857C12B10912099F2DC2A766A75EEE22D87496A1C96
      5C84D2BA5BFEA306D5E9B00BACBDAA9172C123556B5E5D6BA0222E1D46493DD0
      657D3CD8108BA22F1AF5F78CAFC765390D4839B80C772DE2CD54E675C5F5EA02
      8A05F2DCDBC8F345F2FCC9C3D655220C7E260DD7E4DA2E1A83FEF6E3D1999930
      AAE4D813DCE0B6614505F574744C43DD75F1DAC1BBC3EFAD5DF208768EA4C274
      626942892EE8B09D6E2B24D6CE8D49960503CAE79247086B50525C63D3295668
      0CF8FB839A1F44EACB68228ADE658CE6409976784D964276E822716A5E307A85
      8129B8C66962D1B0B47AFDC417AC49F838886B433345846EAF9E2C1282956FEC
      F1899A97F6917DE35D3369135461D9EE3EE7D20C2A41B16E5AE58F5586E64635
      0B9BB4C5A5287884FA5CA4AA5B3464A876135D182705970EF118B6AE4F5B5B8A
      E771F6F1F85DA7E74B7EE40ED4170163DBD541D4E21696F2984FFCCEC1740AD6
      566DAD3B0AB86297C103EA36CF399B92268AD36CD132EBA496D8D1E8006AA99D
      5CC101C4F7EDAF92A68BA85550CC7FE56D792E2725765AA7578B2F01B464B75D
      BB7E397BD1BBD956B6D260EDBBEEE32D56BEB9ADC99AA4D7E9E2224E7ECC13B1
      5CCFAE6EF3646C4D750E3DCDBE449AF48BEEE66A948E204DAE290C7B3A9B50CF
      9A92401FF38CEA1F725A1281F1B5C318C4E2BF3ECAE0AB972F6F6E6EF62754C6
      31CEA28211D932BDAA97F493976E7FE83B2D41059F14A4E0C05E0C29D884131C
      0CEAFF190A506AA83FBA4743FE559083AE06F55B041948FFE3F3FC5083021AD8
      410D0638075D689E136B70C03E410A321C20C1043A4F160E702577ADC351785F
      70FC3704F77B7CE5ED53D3B69B28C9EA62689581A73E49B88D6D9A8CA81C3DB3
      B298469DF1D45A3252D8D722CF68E70365D176C84357D6E66BEA2DA7228797B9
      1478BF80A0092AAF0C6BDAB3CEE43F18806E0F464F584116ED59B20CF73B6986
      BE99A5343B6D4A26F8156152A958786E9984024769CE37F1DB2F906E7337E1D9
      4582A70370FD774A1AA8DFC8822F8E63825312A5E4CAB2BFAEEB6DF7CBCF5C9D
      CB701D6A965E66BDFE70B6BA3B97515B3952687CDE27C8326DC35C3A9C714DED
      CADC04540FD6A393F1974F67E71D5EDDE1F1BB77D68DA04C1FCB2AC2AD9B4D39
      68194802F6AB2A121B135BBAB8DE8AFD0F387A3DCEB8F32E951722BCB54EDF1F
      9CE8B427056FFFAC795E638CE9DFA8F9E914DCC6DF27F4F74FC7071FF738FC0F
      0DFBF6ACCBD5D266CE5663912D48DAA0431503665ACD4781679342C4526500A6
      B7350A82898131922B691A25793A6982FCEDCD07E717EB7DC6192E5D907AF4F6
      E09D45B010D34EC6737164AAA1A24A0AE677478BAA29E1E222CAD2949064F144
      2BCC4541AD5034335BF76C704F07874AB5DD7BF4EEB0932421A00B6BA70606DB
      D103B469FC0D011269A35C8F0BE7944F9CA5A462935837BB507B2999ECB29B00
      58551131C151C1DCB9AD8D07B0C367DFD5E1F04E6EEFF7D82BEBF0FCF41D7B11
      6C0C29AF424370D0BCA3B84DE1646EC5B54BB2713BBE80DBE16CDC8E456EC793
      1F7D53D95DDA245045D306C68DD4878ABE53D6C52455B0E763BABA78B549AB2C
      DCF36EA455DE9114523665B167BD25A5B0679D4D254C852FA2FBBE6E8605AB78
      35BF883DEB7B2938A856E2EB3722FC529D415F7761A72294AFACEF45926315C7
      B7B2B1491D5BC9A19AAB27F3EEBDFAA9546D14DD7B736A74B068E276F75EFD07
      EDDFAF0E68659357D6413ECE7238BB524C29587E301E677B241536764987ED12
      F26E5FB2EBFE13873E654E558964EE7F3A3A557E9AC25FA241ECD68D604B17D6
      4951880B060EB014822AB49CB83E51087C4F9021DA86814C6CF89EA35FEC6F4C
      B10E9B62DB5BAF3F1E9DF3306AD349720B7E366D7D918A6CABF80DE362F0B01F
      F8F1935231791273D37469A5825A71609B5BBB753D770B64B25BE33FD3277D89
      08DF57B7FEE0969609C1472AACED9B0625E9E7205A243FFFFE91F3AFBB6E4A6F
      5842C364CE838CD7CBE79577736945C9BC7C7F4BF9171D5D5915A3AB7412A301
      4EAE38D47E945C637165963FC538FBC672699D9784DBF6E6AFD6F4329B486ADA
      BB615B458EA72D4A4A289FAB02F3BA34BBD1A9D149F3E57EFB64315F7BCE0BA4
      1C369FFA5D95DF1B431FA5AC14433D958BA4375DFA67755D6A30A58D04E4B900
      E54C598110FAD41C19C33B202C914ED3ED900940522F2F5FC8891AB3C8B8C934
      C4025FD00086B3E3BFA834C72E359C1294B4CA7E54691D35E54450834728BB49
      91BA874D8950D5C7C025FC5D1D14A07A4D0EBF3F30DD17CCF2A6E744C1175E8A
      349504ADA4E12D28897B44D1AD1330F72DE5EB3ABCF42333379413B23A41BBA7
      0EBE5083653554EF9CCCE06E1C9DD6EEE4EADF67DCABC75306D4D276E8E05E91
      A57343C8B5F49D1AE580F5EE74728D2617CB3D757865D5DD4D402206532A9930
      3639F59045F5F8C44E2D72E7A08524E7CEA337494A7A9DF4D8A14EBAABAE169A
      21544A0558ACD26A8A2D627543019785305D149B105F4C739A14FBE1076AD82B
      1519F5B58A907B0C79ACB0071466A38645E621C69F93D2E0275FE462BCA7901C
      EF7D988EACD067C9BCAB138B34CD1B10662626D465E171A6B0C975A88B3D8775
      836A2FB9219098EDFFA6D905D713CEA619CF4DEBE62CDCED2D655F8E139AF546
      201D7C5CF838C11C7A46888C93C8947FA8CA0F03D091D7151315FF73A8458D13
      AE265A2BFC527A361D247E3463A370EB20AEE04FE0E7D1C7EC59D359C9952593
      66E5499E65A5A93C518E81F925882FC359C94F635B2E69B16AF88FA6C1681FF7
      EF59D8D81FD557B20C37B8C65FA4C2C1DE54382CF2C79FFC145BDD3D78A63A41
      3B29D768886B855C5EA88A2E48AE2E2E453524C3040C18AD9EC171098684D8A4
      24C4501ACE90E5B79D5CDCA91CCB7100993ECD0A3D8013CA80A27992EA4D49C6
      8F058F85EAACA95BE35FA9F23B3D6A8DCDFBB3CB242EFF7414A48769125E7572
      797F3B48D35FAC9FF2DBD5C817D66B515C5A17975941A6A40141DFFDE7FD5E5D
      9B25DCDDB5B9AD17675EC559F82A8EF56FFBB298EEF39B3CB2F9F6F1D2F5391D
      60ED59A86813CFE7340CDE4D1E78F7EE17EBCDBBB37386C0B1E8D55565F07C6A
      A5A30C4E8B3B3E7A7B64099E3357D498D6551AAC932BAB62A5CDA64916505416
      A259346DFCAEC64D159A6969589FD14F658D9DDA49726862BC485FA5A205ED54
      D6D8223C58D25964C35B0528125E2A5CF78C27A52818EE39AAA9010E5DA450DD
      72A4663852C4B592E43A56CE81D646C3DD4BEACAE3A63C7697753F81A4E10D71
      A50388069DA4880AC7AA0AAA932CFA01AECFDB930F47262C6D66555008E55AE4
      0C59598FB2EDF08A3FBE3BB2E731D4EECDEA663507931587A4B30B5585546AB4
      A6CA9F37C7AF5958661ED330DD38F9DCCD359A2088C9336637546C7A994C0D07
      AB765A6C25F555767D8D6793ECE6D6BA918271BA4D2D589BF617926E9F9B3507
      07797939CEB27C132AFA12A1A2FE68132A5A102A72176FF2130A156D6F2575FB
      DCDD0A4B3A272AF2C299574EBC129EB52E27DB1C9C2F70703658F10B0F4E07E6
      ECBEA109EFB3F2FD8F7C24A889762CF22B1C242A6530D0E7496C45B3297C4D2E
      E6519DD73853D734739B8660710BDA13E48095EB8FD9DCE0CE6A15174BB3EC8A
      9B524B2B10AB1B18A41EFA5E4F3CEB22157608488084A782F52976AAB12C97D9
      2C8D1A46B51A40CEFC204B91A4D67542B280A3C1E4B173E95745848D4CFD2D32
      7583D7BE50A63EF9D9BEDB5B110FD9B0428AA653F7BE30A3F47432D9B4B9F0E1
      B9B9A46CF16596722C839BE4FF3E1B4F351099283B8CEC7B4FBAB27CA1654E65
      7E654467B93A66BFBD35E51CFDF184D2FC1FB364D24978F3ED2DE5C39FB10FAF
      70312926A37EFA27FDF38F449B63459BF3DBA92AA027646E61F1609108DEB18A
      79D2305753685FA120D30389C92A000DAE36ED22B9A88070EE1851BD700E13FE
      B6890E225941DD58D95492AD4F513D0E1D5BE2026BEBE2BAD5B149262F781480
      590ED81F2E0E0E4E7A6B8514F2B1CA160C77C9A1E129954D695A5194984DB784
      D40E9184AAB02FA87A4884841270A3A6094BF5BB090D1348F1633D13B29B76DE
      090FDD515D784C01F58316043CD5437AC8B051FD2C3A9A4AE3947E527D8BAFCC
      5C36F919FB93D0083291EE19A793E919E2CECD9C9BDF6816D9FBDEFE06AF64A1
      55D48129E514DAC5092A0A99978BC61884F8391559DCCF4C6C0ECC6F3830FDCD
      815974609EFCA8D4D7B30BCA86BCB2E2341365D2A2FB8C92C1D6948C63D6F922
      4F0A353F94CCA394AACE77E2D9AFBFDEEEEC5BE79749C18D46B92C28334CC78E
      FA55D467558F01C90299AB07E847526C84CA66E53F662265F84ED80AD9EC824D
      865BCBB40C684F274DC6349354955089309CE5040B89EFB56DB74B1DCCA57C7E
      F78339B155EC83085C84CBF5EC346D8F3AA543D531C6D5B77C5BA1FCA4A2CDDC
      9BD533B029E011C86A856AD92A1EC63FD908A52F20947AFFF98DA8B83822BB36
      151D7FFEDC1B1A82684CC33620F32BA372A7529D3F1D3D50450DFBFBFB3B5F91
      76BF855A5F0088BF0D321179290CD1AE8B5A141C02D86D22AE930B55EC52E652
      72B4E5C57F58CBC8AAA9DAA25874C1FD4A44A9F829FBE5E697907506C1359014
      45252167423BAAE993267751E05D4C5A88F85B4EF7E749D49845CAF01263DA23
      925CA1466B8A54B8497FCC736A2BE2EF584E7343AAA5BE53A3A239D0CF72B735
      25588B50134521E3596A9A96D8B91C83A712B89DE437CDA820A7347D71303B26
      3CB45A39635A51C4B37296CB3D9E622652BCEA8D9870998E486FC46D41AEEF35
      AD59E8648319B96AEDCAFD8B7D4B351BBEF9E07C5448B7FB2D2869BDBE256B14
      AE2FDD3BC1B388B2A9984EF9597AFF74A5500DD4A117B467995EDDB1B822A730
      D74D6093CC44FB72A91E4FFE20F181A9D76B3E9EE23AF411F40CE5EEB34D4C8B
      6CB4C5DEAD0E0D961DAEA03E5EEDE4D06A097E70FAFEEDFBEF5E7DF502556C50
      152EA41D681C28C1AD4E0513526D873A7EBC13BA038F7B72086F05EA5B8D8D24
      B7BFC5A7AADE39ECDD15EEB8D5C3D4F5A7F006CF0A66E7A4303FA54C198713AA
      99C17C04E8EE484EE5241277D96622D5EC04BE8EC6FFB2C8A012353EB5F80D58
      9995A53EA1347A48319C92306556D163EE58F3CB0BD5FC67B0206176414C90BD
      75DBFA641FE008EEA9459A83469CCAD93E226992AE4E8D45752469271539C9C5
      28E2E64771038B6A8707F2F1AE544050BA158BE6D9CFA6F495FBDD6B7520F299
      1A54389B502190B07C370075CCBB81277EE2CAE58DCBF8DBAD3367BF671DFFF5
      E3F1E9DB93E3F7E707EF36FEE322FFB10363E0D5A1D3C60AF95C14C8E5E872A1
      C68FDFA994D9D3DEA01EB73A260136A6D8A7F2B81A960CFE6E133B951C4F86DA
      9E94CABC8008D951DF86DC4CAEE5E60E4B0141C7F9964B1B71754842137ED72C
      34CDE6D38C60B31282C380852075AF0EF55A6B1B62E79007425202E498610776
      AA69E49D2C19E4823F368E38E43F69483B889E26A05C65A68CB3A23480BF7A0E
      B076F6C7524C1A56188BDC42EAA4404199FE1B92B92D5EAA5918523D2F4A226A
      D3E55FDC721B6D21D3D8DAA5B629E281895537BA16E33DEBF0ACC686E1826D5D
      6A60123C81D100B4CCE750ACDCC9514D38A05F28F009A5A4CC3E6B84293529C0
      E85056432F26991AC181D7A7B339964A61F373D9E26C3E9C4E3611B4907AAD0A
      AFA680B1DEC22B593DE692EA786907AEA49CAA2DA6772B9ECFBD3F7579371670
      99D0516D2E8157703EB77E3D3F5A25C25EF0E51FBF3B3D523E8A14794AD39B34
      2375124A9E5A2AABD59AC91749C4F65D32FE6258AF5F7D5DAF671754DBCB593E
      15E7D23538E1659684A6A321900A5AC6A0A92923B08BEB3D077F7E9A284087B6
      A6B9C69BA9F75F4B3165237FA4EC646E1D1C7E7F6AFD4D8D4EECBBBFD0613956
      4DFE1F058BC5DA2A3DC39DFA7767DCEB09EA7F98B25EE1BE4F75833654F131FB
      D677890A786AB37CAA3ED29449115A13F794E08CAA9DD2422ADA33214ABEB0CA
      E3AA1E05E501F0FE1A34819B2C4F71138757935887565B489ED55A5952ED8581
      A0CC253BB5C45EB405AA254641FAA8E6572E3BA844325E8693A191D1B8C6D1EA
      A87ABDC7838B198CB50385C0AB7DE3CE4232A6542B1EEB6143C93DA53CD2E44A
      8143ECA81140D6B3B74DC347E59F9F59A7ACBF6B43C58AB2CE76659D575527BC
      1025BE886E54627A5358CDB228CE23C08DA7821EED682A5AC3BC26291E72CD81
      8641E3B3A32F8DA4FE21919F9D73C5BB614A9D6E2A54C31F0CCE5527A781B573
      2922C5C60CC25377826EBCC5477B8BF62623BFD8417CF21353B7B7BEA318D999
      01CDD9FDEEE4ECFCB93A86746A193FAA525445B63AE44325C481A05ECC4C81F7
      64F9DBA33D8E6D2B43A59382ED40174E699D772A2F94A15D21FE71EF89A2133B
      D3CAD115D61B4A4EAA9B3782E60B089AAF9A347CE289AFF3666856677CB8FB75
      2CFE9EE54C3B63528834296F7566A5110D0AD8E1A024BB2E8BC30375191BF1F6
      780C4376A3217F13E3AEBC8138BBBFBF01A85AA8403B30F95721149A0C559CE4
      1435A2548D76F4024A469331CB4E059BFC4F70AB5B0231AA597D36F989F34BE4
      62649172EC112F550A1A36D6C575526CA90255A15EB78B2CBFB576BE4F22B86E
      146E39C922EB3BEA7EDB313339E1C30452E36FB2DDD3C575F38816335F15CB34
      A69B054DF29E6C44C5DD14A6BD906523FC443FA3B9132D14167306011F43F5D4
      13B2BB48AD0AC27A4AE2474DA4FD28CA4B7046127532F678801DE10A859DD984
      408C273B262D409E3547BF54419E6E45A1E4B6F60D2CBDFD9D5BF3F6D6D9DD50
      C5EEACD050F5CCEB7BC6C62F33ABB84AA67B940AD0CDAF7BD6FEFE73DD941336
      6B9038B8B87356852876F6AAEFDE6713A9325D3B6F2997535AAB27BE9B57DCE9
      22894544E50C44A099AA04526D14A67FD8342A65719C8494D6D3303C5D5CEAF6
      968ADFBF6AE8CA90F5E34D9E51E5858168868D5BD76D71634835CC4645AB929C
      E40A05674D5E4A183EDCE5223145BEE7CC483AEBA6ED7FC58BFCB42ED210D69F
      CC099AA8BC91E2AA4E694AAA79498AB156B92DBAB2B7B72889DC00480B53AAC4
      AAB2785DA4CEF6166BE9B862AFE45E4674E7F52C491BA168A85C9502260162ED
      E23816D63F6694DB1056A0CAB2F1B344E3A6419E87528D2E20FBEEF9BE75C0A3
      4C38365B15FF4410627AA83C5E9B82DBFAC322EBF5ED0EF36CD589A8C3AFF5FC
      D9AA6BAFC66BAA5E366A6343D0B4ABAA26ABCBF05527B518A48A79319DA6944E
      D703AE549193E98709933C9C8DC9AC0E3B9B1AB81BFAE7A6E83CBB314135F6F1
      AC822A3CAB525D0E445257270D08E4EAAE2A897653D40D8ADC5C60E26C0A9596
      8B4F1514DE588EB37DEB2CABAA35C98291A24838CC0133B408F3640AE94BB8E3
      5976D549D94079C75BEAB9B8B0DE3EBBE616E08B8C131E222085F3E74DE7E16F
      0C3FF6376D548B83344F7EAAD77C8E8384AD6ACB8DB8884D55A841267413B8E5
      8DC91A334E0059841FA92E882BE20EB349A401B078140DB465C4AB56DDE0DD8C
      D0540198C2DA657F4209385600A980EE7C8AB3F75AF9A22609D728E8BBEF742A
      EBEF396FA8AA167FA9807BB8665C58FBA52C5C529ED5240CEE30A92A5E0A3A0C
      538A55AC76DE267A78A92874A94B85A56AED6ACFCD60F35235C454143AF1575E
      CEC3D176724B3E1ABB3AE77A7B9E53D66C5A26EAAB80684D613DEBAA0E8C5EC0
      586EA179451F02BB486D6F84BFC976F972A9AAFBE2769EB09AA0037B341A3943
      338AF89FFFF5F3BFFD4C45493212A5B0BC9E1BF49C9EDB777BBD9E8FFF87AABA
      CA864A91A348F6E2208E635D7115F66CFED751DF7B81EBF8B12F07AEEFD1DF5E
      ECB983D1A0E77B03C78B6C3918FA911F8A70D40F0357868ED3EBF770D1C01DC6
      E1D0919E1DB9627B6B1406363E7C687B7234B4C3C1508603610FC2B0170E4723
      DBEDFBE1281A06B618781E5E66E08691EDB9AE2D8676AFEFFBA11D4623C78907
      23E904D219D841D48F7B83C00B9DD170148A812B441CDBAE6DE36364D00FDC81
      17092F8A9D811B472301DFC4F387A361BF2FFA4327F4FBC2EBC5A361EC062290
      41680F9DC17030ECB978D84878B6F00681F4B146BC47603BD1508E7A03BB1F8F
      7AC28DEC5838C39E1D068E37F06D7FD88B23905386115EBD1F85FDA10CF094BE
      33944E38729D6820BD9E13F8DB5B41AF1F79432792527AF1086470A53DEA0578
      0727767C578AD015AED31B0E9DC0097B23104E8662188F5CD0A6EF636DF83618
      D983D8B3A5706D7C8AE88791370A41A978D41F053D39F4A4EF615BFA8E278691
      B47BB1DD0B8661DF0E9DA0B7BD45C4F6E230F6A1DEFBF800E907B1138CE47084
      D70F22DF1BF9611046586F600FE520747C4F86215EA31FC77DD7EFC59E13CB61
      DF899C30C46B048358F14A4CDC037E7988CFB01BA08118E0B1EA873D58397DFE
      22D09C160F6CF0583870EC187CA5BF1E1223C5BE20CEC2FB0F643CF4820864EC
      0F22D01B2BEB83ABB013B1F0463DD7A1ED1944D890BE3D1CC4FED0B6FB41048E
      90F8DB8DB7B7426C6B4F0401E80C72CB381E889113C552C861108F647FE44AA2
      8E3F1242F4FCD091B60BC60B037F28FB03DF89C09C31387834F4842B06B6D7C3
      EB80797A431F9F8BCF08888143AF17F5850332454EBF1F08CF1D06BED31B797D
      1BBB100F87D1C8A5AB6C215DDB77A33E76B817D978212F0A1CD7B76D77108BC1
      A83FE87B713400E70DE9D524688693E1C45EDFC7C11A38032C450E63310C4771
      0CAE018DC27024DD38ECE3FED80EA5E762537C1C9991EB863E7EE5E30D441FE7
      2A968EE70411787AE87B42446E5F46BDC00BC071911F476A6FDAECAC1F0C4623
      BFEF0FB5C4188A4A92F01F480E7C02A48467C7EAEBEDADE677F4B51BE10112FF
      0F20576C2355B098D08D7AD87B9BA40AF6741089FE6030EA411A603302B0A9EB
      F938F461206410C47833D719857DE1F6215F40D1510CBEC60994CED07106A18C
      C0C73832C1F616D6832FB091616FD08B86C2F72072E470484C3D80BC1103ECDB
      3012EEB01F62A3423F9478661F074C8E06C33E281EB8431CB4287647604BC7C3
      BB41548007C11951E04591DD8BFCC083A8F2ECBEC45E449127717E5D300A441D
      DE60E00DE410BB09E10D2EC32FB1106C68CF7686EBD0DF95FDD8ED4503E66CFA
      55D0E71DE8FBCBE8AFBEDEDEAABF73FA86E63284448987745AFCBE1B48622427
      EE0DA308C22D087CE9E2D382200CFB235FE2FA518095BAA1EB4A570CA58F33E0
      63CF063E44194EE70092156B72E9A8D8611FFF460E2E772011A3187C80738253
      860FC7198E41AE0087C11F794E88C318F570AFE38D4610E8E1208AA0026CC83A
      1BA7AFEF41BACA18CF18418645902A7118B9C3D140C451D88BC568E00D5DEC39
      8806EE1E8D06B6744638C29EC071EC0723C7C7CE6281319DC681C011163E144E
      3F043739AEEB8D86EE88B8C986B4C5EB44512F76E260380C07FE60083DE1F8E1
      10FB3D2209DD137E3F1AF41C190536E4F4089FD00B85033AD92390AF378CE508
      E2062F03A6B4A574FCD1A0DFC7153EC8DA071F44B66F47F89910A1D7EF418F42
      56406AB9439BE4D60862A34FC72BB07B6051482E6C0AB45B4FD06370D2DD10A2
      2CF407918476F3833EA80905226DA810D7853A1C0E701EA0C5F1E28EEF47A3A1
      0FB53B943D88314706031BBA7128FA764F0E62C79591E77B6025194A9BF4946D
      4750ED4368C828F66D01C13BF206610C7905550FB519E3E3C02F24366388DB11
      64A2C4411C451E8C05A8395010778660756C53E40B880A11D39A7A8EDB176008
      E139364CAC4084318ECD6830701C010B04FC12F705581A8C3482058133E6D841
      2C6DA248E84167C5439F54F6C8C59607F829D4820CE3C1007B08C5E50610CC22
      1EC074E9E160C15CC06AB013C43EA107D305A71C3A122A6400CA8E60A1E00710
      85F67038EA49522043E90D44140F439C5FE98F7ABD11C97717FB1F3AB81D721E
      4C05520EBDA10DED34043B052E94910F06036BFBD82F0890702071F87108DD11
      4801856FC3C8897DE2220802AF177A8E14D000FDE1F656DFC19BC4D84E1036C0
      F11A0A8FEC0CDA94911C3923A882211E1F7B0370940D8A437C43F7415A0FEDFE
      00C281D81A67AD1F834A20924F021F5C8C77E8D17ED83D3FF6640CCA41868104
      3290D03C43EC863B80EA0BB7B79C90D433942F947FE4829921BF86B0D3C4C817
      B1078582778F250E9B10A3186C12E30C42B4C6B8192AC8856518871227650066
      8902BA6524867D085ADB233D8987C6F06287711F1FC2DF39B083F01714179485
      87B380C303BD0B531407013B637B510826887040FA64048252BDE1C005DD2181
      F1CE112433F402F81CE61D742788E042D78621CC811E94BA87CBFC8016DAEBBB
      7DB25AC1CE50AD90993D584550C9649046782DD85D318415F86018C21E0AFB30
      34F16C081508D0610841EF0F83212C8E00DB0D230BEF02F36E08C6C6EB43E1F6
      3D68892872413B98BD2E4C82D8C6E18114838CEAC1341E41A878612C6004FA90
      3E64C10D25CCC7A1C083421B8AA90F5B2C74210F86410F76693084741E40C1D8
      3D012BD7863514DAD02CB8C6C73DD84EA87ABC5D88B50B4FC03A8846103DD87C
      1B36781FAF16429EF621F786D0945E7FE4905E12432897816BBB1109D121CE20
      0C5807FC11425663119133824C24331712C21E0A7C1604EA801EEC86368C1628
      48FC140751F446D80AEC3A781EDC350095460EDECD85FDE60CC16AB620210AA6
      837C83A105F3D78B86AE2370E0A145A29EC495583384960D89050B14EA0EA632
      1435EC837E4C0E030C2749E799D99D8E0E2C19FC0F7EC73B434140E445B0067A
      0358A7911BE13DA3A18D93E98E6221C93071219D3C0FDE410055092B169CE1C0
      469482A4990F61076B0E821AE61BCCF051AF2FF1BCD875701640A1BE805E0EB0
      49B01D211DF1256430245C0C010C59E6811D5C0FA7D2A5A306DD80331349707C
      E8C7A123B08D01F85CDA0E44560C7D03EEC06BE3E5714AA3C0F702076703224F
      4A1C18DB8F70B462F23C886962BC81943D7C07BB19C259495FC86E0868E96111
      5087D059F128865D84171A8478761FC2C60EF03C9C1D57F803EC590F3A6F0473
      9D14028C4288AE5E207B6200E7C1F1FBB0DE23783EE01B082F9C363C37B6FB0E
      0E406FE0432261EF02486BF0F1086A06BB8B63EBD095B814A2082F8A27FA31DC
      5F1C1D814F832B84FD8B841CF990E0D0BD237874101F70BC62383F01696D080C
      185C3880508FE05B2F20A76900D364646371B0427152063D17FA1B9A290A46B0
      7D401C0707C8ED85643DE13041C6C242861A8174822783130FBD04210F56ECC1
      6C00E5F1E9013836F2601311AB42E442C0C0CB226F925C275832033897235872
      7DC87CE161DD58C78834521085212CF35092D7065307068FEFF77CD1F7C0A230
      0320B83D324A611341274387420008E8769C77CF8189EEE17CE24082FD6115E1
      956168F86040D7EDF9B04E3DE81D78A130B68711360E7E237EEA413141CC4395
      439DE2AC4193E3318E873788E1C5C238C695F0EC8602561256084A8178787D98
      02208808F06E7417C4A00F1B6A808F034342D643134881EDEC4329903730C0A9
      0A21A65D1F8755FA713C8CA16FE0E6E23BE8537834A02EA8678F1C01433C22BF
      115C01DB2864810C630754869B0899E9C2541574366D8F4E4F38C441F2611B38
      D82AE81B0917087B835F491F670A861CE49237881C4142128E1D3C9C01B18D18
      E1B143A811B2AE07B0C7C18E90B70338EF03B231B00BE4D142D49006C4E9B7E1
      300BBC13B486D377F15C09FBC31E41ACFA3056A0C0218C61E4E078C339834139
      C45E81C4A3D81E84707E5CE8E57E7F14F540747275A1CEF02EB466E941CF42A4
      8CBC108482A90172F7C21EDE0052C41EC11CC536F73DD771E1C9C3C7C616615F
      6093F9A1201B0D3E5984730E5B0F9C46DE39447E0495447477E1DAC1CF18390E
      7C8100FA4ED8602D7827105210EE41BF0783053ADE83288AB00FC10047832214
      20990BAF2D22EBA507B13C8AE1197990767833C814D10FE0ADC26E20F9D00B42
      1BB6926B073002A1ADA2C100E63284337C5E481C6CD988423864AD040308C83E
      D8179A067A862323F048407F7852F008B138EC255E24A685939D888F8402815F
      E94743D8AEF0965C5C0DFBC686D1801DF05D38B4FD10E4810C84950C1B623080
      FCC00F7CEC3DCC9B105EAA07FE854B06C58F7DC129877E95F49AB0E3E084F407
      A390D71F05D04714D8020D22527111381142388434874B0029018EC59B86FD1E
      FC9DA01763E1F66800D9EC487201C98A82768B240E304C0E3A6BF079611CF923
      A841F00ECE1F2CB6407A701361B652D081C83D22D69690DED836F84E7468E0F7
      442EBD01F8000BF4A118B06322C65EC0A080D9032B0D4218C41F454278B184E8
      71049E3CC0F922BF1A5C04071F24875610B0997CA230F6C883E00820970638A2
      70E3F1330819F030B801EB272503B60443F910B3210C29D8C0F01B61D740C3E2
      3E983C504B7803D0B0ADB7D883D01AF546F4B6CA4B0F94A7690F1EF616EBE80C
      74E34ACF7D3E7EC33E3C5925381838D1F680C225B10F091208F278C04FD17088
      8B7074C85192AE03C7901C24B8C57DF82211DC44F2688630AF20CA200FE46804
      E336180D60038E609CE150451282096719DC006D840B60DB8FE063404F0D6175
      C20684230E0D301C452307AA2000698610003EE4AB8CFA3061467078EDA14B0E
      990BD7079FE6C00C1FE0D0D950A830C161A3C02A7763D8483850703005AC2978
      3AAE6D0B47C08C87EF1644505E7044706A21DB282C077317762AB8D8C70640BF
      438BF4F1FA1E5C0A8ADA800CB0C386231FFC093509FF0B1B0C7315A2042623C9
      2841E18710C70CC69CA093EE86F0583CB013381C668FDAB9B9DD876EB723EA9F
      5D3FE2FBD09F66341856DAD278F0AA77A068E043B1C0457F9C9EBA669E136B4E
      5BF599ABE2548BFEE0A8D80F9D8A660C65F14958F556ABA2378BFE4027556F85
      5D58F05E8B223BABDE64956458F82638BE0FD1A719D36D2F33F84DBD5E4D014F
      FDEFE9A85818F684F9D53FB7B728D9116669961721A53CC61A000C5E65AC9F0C
      394D9F3470205AC1BDF0A96CA20BDC3F1B5E310EB04F5CEDE2B7702DE9B71ED4
      BD0BAFD319D215F0F75D7E63FA3BA42780AEB86A3022AEC7B360D6C3EE149459
      801880AC1EC07D202F0636454FBD03CE8A83DF913F070760E0E2BF1E2CACD8A6
      2085A32983330FE7281EF03BE9FB7C9F6848BF73F56F6D9214F0B36CFC6CA0DE
      99570943CEC129816B18D3F5FE884E28AF107738EA9361D660E5B42617A695FA
      99EB07EA677C9D5D5D6757D7D9D575FC333C9BDE99F341FA19733FA9AF61EEA4
      9FD9F7AEBAFF24E7DE35CEBD6BDC7BD7B8F7AEF1EE5DE3DDBBC6BF778DCFD70C
      4171A268A0F6C97CC7BFC34EF8A13B7FC59D9FE13AF082E649CA674FCAA2BC4D
      65F1735A4445998CC56767E0D13769165EC92892718F7F25C7C9257729989FCC
      2604174205CDE627FF50B580E6DB699E647952DEE2FBD1E8BFEA47AA71E556E3
      8EBED5BCBE67D5D7F6ACF78C0EFFE7A5578FE6AEBE942A69DAFFF3F6D6FC6BAB
      BBEA97EE2F7F81C58FB4FFFC851FE87CE907BA5F7ED1DE977E47FF4B3F70F0E5
      173DFCD2EF386AF54073578223F6B93507CFDFD58E49E7EF69C787F3F7B88FB8
      C77BD48ADA31CCFC3D8347DCD36ED3E7EF19B55C91E10E679E3DCA2CC436FFC6
      07B4DBF1071EE0FCF645B4E386071ED04ECC3CF000FFB72FA21DD33CF080761C
      F4C003D613134A315A6F2704FAB2E6D18AB3AC9C64A5AA6F5EEB53C504F769C4
      E375EF257128F3B56EA117C52D8F111C5AF83E5E963BDEDC5343C1F3DFD77AFD
      92BB14B2D88A938B592E8B35172227D732CDA615ACE95A9F5DDD9CCB7296AFF7
      DE157F54CD138F6592FA01EB2D9D4BEB1594C05A1F3D15178FBA0F76ED6F58B0
      B99B8FC47A0BAD5844CCCA4BE2BB44AEB7CF6311E6D97A5C9989B54E87B9EF5D
      52ACBB3ABAC57A3D4B53B99EA8E0FBDEAFBF8D7CDF7A4610DFD25609CEDDB49E
      11C4B7B453740BA8F79845E93B1FB5367DEF2396A8EF7CC44AD57E3F66A5FACE
      47AD54DFFB8895EA3BBDE5CE697FDE973D4FCA743DC1729866D42FB7E6BACE92
      8B8920B4FBB52C92F9671CA98A602EF7BFC8C5F4D27A934DD63BC4AFB3E8D63A
      5FD74AA8EE7A9C69C33B43431B92C96C3D5ACFDDF9182EACEE5DCFA39ABFB7AD
      13BFF8EEF54EDD899E12FA7D6D982D66E33BEC350BCAB539F94CA4336513ACB9
      C02351AEF7493503BD61B814CD46BFFD116BF2C47BB208BED77A76BD35D79FBF
      DE47D6F7ADC78277CFDCA33F56DFBEAE207E4D5FAC2F2ABEBF254CB46472B5D6
      5D6F32028B94D1FCDD0B19DFB6E779B8A4567BBDB6C537CC0BFCE3F1F45214C9
      7A06DD5116CE78A0C78998AE75E3476A77599F8AC72FC63467BB561AEBEDDDF7
      E727EFACF36C4A362C61F0ADB78374F36BEA241D3FEA7EED04EFFE2483E7EB7F
      F0012CE7C9EDF8310B3E788447C6371E266B8A337557163DE2AEA30A78FF314B
      FC41DE0699C8A3F53FF723BC283E1CA57CC4DD6782FA07D7BF8F3A146F7008D7
      8E17F0DD3F8A3C2157ECB18E6E310BFE2EC3F54EDEFB4CF954EBDCF341353F2B
      BDBF6E9078EEE6F564FCDCAD6B6A1742E7CD1A9269490CEC9C5D61C2385AB2AC
      86A00B25CD3387F55D3D74B1E57297DE6753111ABFD75CE4CF0BED778C147076
      593BC8D585774D2FBAB0DAC1EA2A7BC1558D5555D739778CB128998DCDE7EAC0
      7075ADFBD0B5F6FCB5DEA26B35BFCC5DE82FBDF0CE13078B2EA425DD7DE270E9
      85F6DDD58F965EEACC3D7330BF3B4722BFBA4FF3C11DB78992ED34306CD12E0E
      ECC5D7DE7FA8B3F842DECBB60C0425139232EFDF5DFF325EAA6F68C5544B2E7F
      98B796DCF430932DB9E9016EBBBBF665E7F9545E278589AD2E8EC5BA77965F34
      3CD307ECB77926FBCB2CD3CA77F187CC6FE3DB492927856CDCD5E6E02CDDEF07
      CED012CA3E709896DCF1C0995A7CC7B2C3B5E4EA874FD9B2A53F74E0967CD003
      276FC9D25B1C41BB9D305F72F9AA03784FC0B53B82F6638E607B81BFE48E160C
      7C6F3D2D18D85E9B81EDB519D85E8B81EDC730F0DDA5B761607B6D06B6D76660
      673D0676D66360E7710CEC3C86819DB519D8599B81EFADA705033B6B33B0B336
      03B7336F965CDD8E81EF2EBD0D033B6B33B0B33603BBEB31B0BB1E03BB8F6360
      F7310CECAECDC0EEDA0C7C6F3D2D18D85D9B81DDB519D85D8B81DDC730F0DDA5
      B76160776D0676D766606F3D06F6D66360EF710CEC3D8681BDB519D85B9B81EF
      ADA705037B6B33B0B736037B6B31B0F71806BEBBF4360CECADCDC0DEDA0CECAF
      C7C0FE7A0CEC3F8E81FDC730B0BF3603FB6B33F0BDF5B460607F6D06F6D76660
      7F2D06F61FC3C07797DE8681FDB519D87F2074374F074A3AA6723EA3B2D8E79F
      5F9FF1E2AB1B1FC8DE38F7F39C298DE36996042DBED15EF8996DEE9C27D2EB2C
      BB5AA34CA07ACA3C5FBE4E8234C9383672FB5BCAA3EFC6673F1C56F9CCE665EE
      C234140773E79D74D75E7AE1BC33E43A4B2F9C373A5D77E985774D08D75B7AE9
      BC1875E78F13B3ABBA8E05DEFCB5FEB26BFB8BAE1E2CBBFACEF287CBAEBBB3FA
      D1B2EBEE2EDE5BBA268FE5C5DC63BDFEB28BFDEA14CFDF602FBB61B0F8869564
      5B1CE479807ECB624F0F9072C9672CA7E9E21B569176C95D2D68BC6C4D6DC8BD
      64716DE96EAF4BF7D60CBC2CC6D282EEF6A3E86E3F9AEEF6DA4CBE74716DE9EE
      AC4B77675DBAB79620CB62096DE9EE3C9AEECEA3E9EE3C8EDBEFA98AD57477D7
      A5BBBB2EDDDD4771FB3DC1BF06DDDD47D3DD7D1CDDBD75B9FDAE57D582EEDEBA
      74F71E4577EFD1DC7E774DEBD0DD7B1CDDFD75E9EEAFCBED77BD871674F71F45
      77FFD174F71FCDEDF716374F77F6885A1B818DAB1FD4A18DEB1E14E18DEB1E94
      208DEBB409F8A0E0685CDECE086CDCD0CE08BC4FB6564660937E4B6E584EC8A5
      56E3729AB63202EF11B79511B890C64BEE6C41ECA58B6B4BF7078DC045746FCD
      C04B6E584DF5BB86555BBA3F68043E48F7078DC007E96E3F8EDBEFDA5B2DE8FE
      A011B888EEAD25C81293AC25D5EF998E6BD0FD4123F041BA3F68042EA7BBBB2E
      B7DFB31A57D3FD41237011DDD713E14BEE5A83EAF7CCC735E8FEA011B89CEE0F
      1A818BE8EEADCBEDF7ACC6D5747FD0085C4AF7078DC007E9EE3D9ADBEF2DAE2D
      DD1F340217D1FD41237011DDFD75B9FDAE61D596EE0F1A810FD2FD4123F041BA
      AF874B70825BD62FC33E1B8BBC7C6497C3F7A2B82CC57A0D9E9F26B92CB294C6
      7D9817FE274F6AA0210D4549D3507A7DC63AEA297CA75EAFAFF199B6B75C827B
      674420C7B6A5E7B87D6FE80DDDC80D3D424DEAFBAEC252727CC2355AF8C7574F
      8A7A61DCEFCB9EE807FDBE90FDE5E84EEA8F43F8C578642CE398D19E962153F5
      EFFC7BE717747F5CA18EDDFFBEFAF9EFF887D034FFE7FED9ACFE7FEE9F05AB8F
      F4BFF2EBBEC9B7F8B3D9FBFFB97F36AB7FF88F075BC38FD5FF0357991E2EAC10
      5FAAEF07F8C160B4CA4A78FC1F46BAF496EBFD5EE88B68341C8EECB81F1138B5
      EFE14DDDDEC8776CAF2FBD65CFF57B71B4BDD5F3A43F884783C8EDF597591C4F
      E5CF520A3CF20F56DFB13F5F9202DD5B3DFDF9521478C4EA8DEFA1FFFCF39FFF
      3F1CB9B880}
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
