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
          ExplicitTop = 28
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
      Left = 931
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
      Left = 961
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
      Left = 992
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
      Left = 1068
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
      Left = 1149
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
      Left = 1215
      Top = 3
      Width = 70
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
      Left = 1291
      Top = 3
      Width = 70
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
    object lblPath: TEdit
      AlignWithMargins = True
      Left = 30
      Top = 5
      Width = 895
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
      789CECBDF973DBD69620FCBBAAF43F6054F395A9F72899FB92EE748F2CDB89E6
      79C9584ED2FD85A929900449C420C0078092F852FEDFE76C770148C85A285B0A
      F1BA6391207071EFB9E79E7DF97310A793FAC01D7B93C00DA7F55AA33D70C3C4
      A77F468B69BDD16E0C9623BE63D2ACB76BDD017EAA0D9234994DC6C3D10C2FB6
      F96B10F1D70E7F9DF999AF435F3F8FEF6AD67A75F579E2C19B7B8374E6CD3DFD
      9BFE96FF7594D4FE1C4CA2304D87017CA80D60E8B1EF0C26713477C3C1643473
      E3C44BE1FA22FE67E3CFC1DF060B378C12CFA935E0FF3AB566AD5D6BC17F0DF8
      D4FAFCD19F7B89F3CEBB743EE0E3FFF619866CE821E7D1D88BF363D6B3637661
      9C3E8D8D63B660CCD36819FB5E8CA3FEDBE7FD3D18B15930C9C6FA24019C3558
      30FCD785C9E2A0DDCFE7ABF9300A686E75B3DED00FAE1F68ED7F9F7FF5C3E918
      FE4B645EF556C1C4EACDCE66F8E546FDFCD35B18EE8DFF33DE377183D4193C1B
      7607CFBA4DF8DB183C1BC35FB73F78367107CF46EDC133AFFF9996D12C7AF1C6
      6DC3EDE26DC3ED6B2088DDF930F65DE7AD9BCE148CBB7AC8E4D24F92EB879CD0
      6E3568703564E0C39834BD56F35628308479F5B383456112056EC27BD668DE66
      6A434124FE0FD0F4F3B9378D3CE7E733B56B9DFA7DB7ED7FA97DA3090630C81F
      513CA023BEED0345531E0FAD37DC7BF67744BA996F4DA2713B6C696EC616E78D
      3F9DA5B2C8A13D7ED191BF075D826DF24335FEAD0ED02DB6C9BCA1FDEDB6C94C
      A2B3A543AD36C88CDCDDFE06B5DABD2242DFECF1B04EEE39E7F4953CDA2F7A14
      B77AF3A3AB5816D62AA608F8CBC6A77F883DEF13BFBBD3287CBA51F0F4C7652C
      CF16217ABDDB2D78B6F2A3378CBDCB4319A09007758B60563989DDA13F3AD4AB
      2F44D55EA7608817808FFE4866D0295C7EB36806BFF85E1ABA70D19365747B45
      2C43ED7DDDB10403BDEFDD7EE173B2F1B9E7CCA6F7EA458FAA5DCF3E6AED78AF
      50C6515B9E7D546F77AF9033AAFDCE3E98DDEB5EABF8E94D40CA6F74AF5DF8BC
      EC74F6797B977B9DE2253737BD3BBFC59D2FB14647113CE7572F49E10DB7217C
      B4C06EFFCB04C4167D141675FB5FA61ED9E756BC9FBD6266AC0947E6418343BD
      DA97A946E651C2215A66AF98B7E8039B79D4DAC75EEDCBA735F3ECDA3EF61ABD
      02A6620399D9BBC0B7D7E8173D62C1571ED107B4D7AC173C6503979FB2E0DA2C
      124D6CB8F253EA58F69A4512A6A1C2EA99CC89EC598278FEC13C2C7287B1D76C
      173D6A6D223F6AEF5FB388A5DBFB276F5CDBBADE8DA82CCBDE7AF37A3722B1EA
      21B37DFD1BD15779CEDAC0FE8D88AB3CA7B7B07F23DA264FD900EDDF88B0C983
      59908A3AD1FBF281502A88022A3CF4E523611E127253EFF4BF7C24F45306A4F0
      DC970F857ECE101A78EECB07433F973919F0E8978F8679549F0D7EF4CB47433F
      6A6D253CF8E5C361DEB9BE95688DF8028FFA5F7926B5AE01DE5988CD8C721F79
      D61EA87E1FD13633D0DDA5DCCC30F71178D757771FE9373FD6BDC4E0CC48F795
      88D794FEC643CA4E39DDFE16FC9DD47785BE99316ECEF0650C8DBCF630B79000
      781883BA99616E2E12F0300A713383DC5C46E04172689B19EBE662838C65236D
      66A49B4B113C9285B299716E2E56C88CD611D636E034EF4C0533A3DC910AE686
      69DD9906AEADAB75772A9819E69E6A7F66AC7B5B0032A3DD8B0A6646DA825DC0
      B6D9B5EE86528A679871EE8E54F630ED7B325633D01D516A6D61ED7B225566AC
      FB335633D6DD516A7D8D5B402ADB4CDB7978C66ADE753BC559710DF3FC2DB5E8
      DCE3DDBBA8D399016EA959AF2DA07B47353B33C65D34EEFC18B757BDD7D7720F
      3DDC36A477EFC328CD28F75117EC817AF7A16A9981EEC528CD30F7561732A3DD
      93AA65C6BA2FA33423DD97A6D142475110C5E930F8B741EC8D6B8329EC4A581B
      0C83A5575BBFD468B7ED8BF0F5BACB3C007EDB3044EE72EEDE82210A5EC843D4
      1B3DFB227CBDEE72EDDFF6F7F0327EDF3048EE722D7BD10CB2F1B21EA4DF901F
      E003FDD06FDC08CE35DCECBF61A4C668B64052D1680C30D063E08A7B0EC33CF4
      178C08912F6D473DB870170EACF09F813308FCDA2086FF12B70E7C2B091AED3E
      FC3B5F06697D70E98F4769B070E3C165EC2EE039172E0FDC64E1068B998B1FC2
      E51C3897BB4CA3813BFE6399A4310AF23020CC35C07FFCD45DD49CCF8330FA27
      605D348F52CFF97390A4ABC04B669E97FEF9F5263188D30060311925755CBC2B
      2E479700E8AA681B984C1AF36D35055C150063C5BE10C0BF04EFC1681AFB637A
      2C5C5823840B1CC31924A17795C25B927F4EA278EE02FF4F16B11FC57EBAAA39
      EFF0124698C05C937A164CC37A8D8085FF0E71E175F8C67F6F05AE68990280BC
      C0BBF082DA8D81377087B0C21A420EE4E702C80D07F4EB26D87D029107042050
      0FAF870F2E7CE826DE380A6B022C787902B3FA546F6F845ADF41D48A137FDCEB
      F7FAF56ED399792E46D738753C3449E3E1C158BF0B180114068CB0EC3C20E1F7
      4D80FC127AE580D750C0EBDC12780DC1C2E6C383AF7117F035BAD76121FC7A7B
      E06DC0BDA6025FF796E06B32C18649C350EE78ECA7FE85077727DEDC9FF9E3B1
      17C29765081FBD25BCD11AB3EEBC64D0393FB9B13B0550CE9CD75198D28030C5
      34A9D7E19F38BA1C0FD2789226BFFAE374F6A2095F16F0A2A05EEBC9C7D87C9C
      04EAF749AA3F0DF5A7183F8D860B17682F7C98F08721AC1CD810FF4D570B0FEE
      4A2EBC3805F1033E0DE371ACFE06F277287F63F93B9E06FA93BA3693BF17CE97
      F800ACF64138C1A3E103F5FA3528B1BFC7ECC0F9E80E034FE353DBC6A7220ABD
      76226A4C9A35193694021194711CFF46A34F196C5CC7F01F1575754E41BAD4D3
      EA7C795AF8D60DD382CBD6C9D3D369DC6E3A8DEC74BA5F9E4EA3BB713A78796D
      32CDDB4DA6A926437CBCF73024F416D8CEEB6D5D83E9ADEDD0CB7A2F23CFE4E1
      334FA2508938BC4FFDC27D9AD4B2935C0683D1A491DB9B62729ADB18A05E316E
      A47A71A376BB17D71B6B487AD377BF8E8220BAF4C69939248D0712EFB68615B0
      DC3BE2C5BA10721D99CB834B885EE5576F78A877AB51BC5B0D5A456ECF30789C
      2EDE69C7F6F77EFCF8F68D731A8D3DDEABAC1064F623BDEAD73BF06F1DA345D2
      AB4617486C7AD5EC745AF0A7D5EE01F3BC6AB7FA784BA755C75BBA4D0CA2BFEA
      355A2D7E1A6F814DEFD230B57E1F6FAAD7FBC8B9AF406D6CE06DF566B745F7B5
      3AEDCE969140C0572C8B0A28B782074A9C6AB46E7376712F7E8A3D96BE526FAC
      B1A27547ACD8C86E32243E33B72F4C27C3781AC5ECD95F272D7E0E41D725CCC6
      3A117D35870D4FFC44BFB298F5E6DE975F7731A15E0447865416F3D2FC7A6E3E
      FA488FDEBB9E53E778F49701D6587BDD791A47E154CC5B7F83B390A4298A547F
      D247FEEECD17819B7AFEB8DB68C2316E756AFC2B292803FA379C8C8010A88FA1
      FAFCC7A8A63E84F26942145FBE24A90B1233C8D3FC6DE18E3CF905A46A2F4CF1
      45F82D8503327856AB0F9647CD7EBDE9FC274288DFB69C0FBD18F69B325812F6
      E1BB84D0FE51B383A7BB0B17FF18C9CA90CC34E8CCC31FB4FFE885E0D1FE8A4B
      89362DA151B0847AAB955D035D8091F16F6615775C835ABC59C505CC34848F80
      7AB7DA9D467FF3EED46B056B6B209DB7D74617E015F8771B6BBB66657AD90FB5
      B65E2FB736BC806B83BF0FBCB69BAC0CD67FE7B53531D8D85E1B5D8097E0DF47
      B0B62FAC0C45B8C2B5B59A399A4117E025F8F7F1AFED9A95617E082CDD5E1B5E
      C2B5E1DFA7BDB66E8E92D0055C5917290972B827BBB64E2B4749E802BC02FFAA
      5D43679503C3E0677FDC6AF7DBFD5AADA3179EE3E6BD5A0FA48056B7F157E4E6
      D6422CC6FE7576B864ED256BFFE6A4A664ED256B2F59FB5358DB1D587BAFDBEE
      D5EABD5E116B471353BFD1EEF67A256F2F797BC9DB4BDE5EF2F6C7BFB692B797
      BCDD1FF71B9D46BFDFAE15F1F64EBBD1AA75BB7F4D23FCD658FB53E4E6D935E0
      FA77829BDB2B539B5E72F3929B97DCFC49AEADE4E636376FB4EBBD4EBBDFAA17
      AAEAED5EB357EB366BAD929F6F778F1F17732F55F552552F997BC9DC9FF6DA4A
      E69E61EEDD76B3D96CD50AEDF047BD76B7D6E8B4DBA58FBD64EE25732F997BC9
      DC9FC0DA4AE65E32777FDC6C34BAB566BFD72D64EE5863ACDFECF4DBA5EA5E72
      F792BB97DCBDE4EE4F606D25772FB93B72F77EBF5EAF755A85DCBD59EFF66AF5
      66BB0CA12B997BC9DC4BE65E32F727B0B692B997CC1D987BABD3AEC39BDAC5AA
      7BBDDB6DF5BBDD4EC9DD4BEE5E72F792BB97DCFD09ACADE4EE2577F7C7ED5AA7
      DD6F779BCDC290BA7AA7DBEF779B9DD22E5F32F792B997CCBD64EE4F606D2573
      2F993B30F7460D14F35EBBB06ACD51BDD96EF69BBD66A9BA97DCBDE4EE25772F
      B97BC9DD1FEFDA4AEE9EE1EE1DE0EEDD46B330B9FDA8D16DF7DA8D321BAE64EE
      25732F997BC9DC4BE6FE88D75632F70C73EFB6DBAD7EABD728AC5CD3AFF53B9D
      D22A5FB2F692B597ACBD64ED256B7FBC6B2B59BBCDDA3B7560EC1831576C95AF
      75FAED46BB5732F792B997CCBD64EE25737F026B2B997BC9DC81B9F71AFD6EAF
      D32F2C517754EF367B8D66ADDB2FCBD8DC7F298F8BA167D750D69C2D197AC9D0
      4B86FED4D65632749BA1776BED7AB75FEB5D93FED66CB55BDD5AA9AD6F7B8F1F
      17732FB5F5525B2F997BC9DC9FF6DA4AE69E61EE8D66B7DEE95F1720DF6E761A
      ED069CD792BB97DCBDE4EE25772FB9FBE35F5BC9DD4BEE0EDCBDD5EBB51AB57A
      B1A3BD5BAF37EBFD6677A3EA5E3370A9DD162C37824403FEAB1DE7A180208225
      C469309A0D26A3A4EE0CDC0940224863BE70073E6F31F7FBACEAF69B8D4BACDF
      6F897760FDF61AD5D21F7A958DFBADF20E42C01776522D7CABAB6CDE7395B717
      07EE8EAF77F3BFE02A5BF75BE51D0483073895D77A627095EDFBADF20E22C257
      A43D24D8E12A3BF75B25C906B71316BE3E85EDAEAD91E5DA9BAFF27AC1E171AC
      B277D39D44CCDFB4CABBF48607CDBF5FAFF55B9F0BCC038D0E8810ED46B7F32D
      CC0396F6F2F00682AF2C25DEC03C801ACC37F2ED7F65F3404E61F946BEFD0758
      DBF5F2C0935658EE6D1EF81A92EB1DD7F6E0E6816F688EBB03C77F32E6B83BF0
      F927638EBB0B77EFF5FAED56BB55C4DDBBED76B3D96BB5BE5E711CA2786BFBBC
      0BCC1D99F92309DC2B997BC9DC4BE65E32F792B93F65E6DEAF75BA9D4EBBDBDD
      CCDCEBF55AA3D7EAD6BF62E5BB92B997CCBD64EE8F7F6D25732F997BC9DC1F37
      73AFD73AED7AABD1D9CCDCDBAD6EA7852DE94ADE5EF2F692B797BCBDE4ED256F
      2F79FBD3E0EDF55A0D387BA3DD6A1698E5DBBD7AA30728FDA00977374864FE4B
      7177DEE4C71594FFB0D4E6DA00E8C7924FFF30DC3D2FB93CAEA0FC07E3EE4F5A
      72B937777FC492CB8373F76F29B97C43EEFED092CBDDB87BA35F6BB46A454EF7
      46B7068069F6B7A0BBAFEFFA2D80F1F4B9FB9A4DA2E4EE25777FC26B2BB97BC9
      DD4BEEFEC8B97BA3D66E753AAD460177EFD45AAD6E1BEE29B97BC9DD4BEE5E72
      F792BB97DCBDE4EE4F85BBB76BBD5EBBDEE817A5C3353BED5EBFD6696F211DAE
      64EF257B2FD97BC9DE9FC0DA4AF65EB2F7BF047BEFF74173AFF5EA0521F3CD4E
      A7D96AB45B5BA85C5F72F792BB97DCBDE4EE4F606D25772FB9FB5F81BB6311DB
      4EB7DD2930CDD75BD84DBE566F94DCBDE4EE25772FB97BC9DD4BEE5E72F727C3
      DD81C8B48077F68A4CF3BD7EAF556FB6B651A9EE2FCCDEBFBC903250BEE4E825
      477FC46B2B397AC9D1FF0A1CBD59C346F1CD7A0147AFB7BBCD7A172DF22543BF
      E7D12CF5F592BB97DCFD69ACADE4EE2577FF4B70F74EBDDFEDB43A05A174F566
      A3D5EC775AEDD21A5F72F792BB97DCBDE4EE25772FB9FB93E1EE5D74A5B73B05
      F5E98EFAA8BCC3EF65927BC9DD4BEE5E72F792BB97DCBDE4EE4F85BBB76AFD5E
      AFD7E91476856B036FAFD5DA65285DC9DE4BF65EB2F792BD97ECBD64EF4F86BD
      B7E1D166B7DD2CE81C73D4C3C6328D7A99E45E72F792BB97DCBDE4EE25772FB9
      FBD3E1EE9D4E1D5E55AB1570F776A3D668D46B8D32ACAEE4EE25772FB97BC9DD
      4BEE5E72F727C3DD7BCD4EABDE6914F48EA9777ACD6EBFD5EB6DA1EB6BC9DD4B
      EE5E72F792BB3F81B595DCBDE4EE7F05EEDEA9B5FA8D7AB7A840DD51A3D16E36
      DABD32AAAE64EE25732F997BC9DC4BE65E32F727C3DC9B75CC78EB17E5BB776B
      BD5AADD76D97DCBDE4EE25772FB97BC9DD4BEE5E72F727C3DD5B9D5E1DFE2D6C
      1DD3A67CF75ABBB4CC97ECBD64EF257B2FD97BC9DE4BF6FE64D87BB75EAF35DB
      459DE1EABD6E07D847A7AC3E5B72F792BB97DCBDE4EE25772FB9FB13E2EEDD7E
      A35D6BB48BFCEE9D56B7D66C96CCBD64EE25732F997BC9DC4BE65E32F7A7C2DC
      BB8D7EB3D6AEB58BD2DD5BBD76A7DF6C977EF792BB97DCBDE4EE25772FB97BC9
      DD9F0C77EFD59BBD4EB3DB2CAA445B6F37EBDD5AAD53E6BB97ECBD64EF257B2F
      D97BC9DE4BF6FE64D87BBF5E6FD67AB57E41BEFB51ABDF03F6DEEF97DCBDE4EE
      25772FB97BC9DD4BEE5E72F727C3DD9182369A8D8242F38D46B7DE6FF7EBA565
      BE64EE25732F997BC9DC4BE65E32F727C2DCA9CC6CBF03FF14A8EEED5EAFD56E
      F64BE65E32F792B997CCBD64EE25732F99FB9361EEED369AE5DB0555E6EBC0F6
      BB8D7EAF5686CC97DCBDE4EE25772FB97BC9DD4BEEFE64B87BA7DB6ED6DBFDFE
      67F8FD6F7435BAF0E2D81F7B3046E0FD99B9A4ACF9CD4EBDDFEDB43AFDCCAFA3
      68094B1904495D9FEDFC833A866FF3838DCF1B1FEB63BA7DA7DDED6E7EAAB9F9
      A97AAD566F351AED5673F363ADCD8FB53BB56EABDB68D6363FD5DEFC54AFD1A9
      F5EBB57E0B3779D3739D8249366192FD56B3DEDBFC58B7E8B12E082AD80168F3
      63BD82C774FAE3E6C7FA058F69EF4DC17ED78A36BCDD6DB76179BD46C183F5CD
      2F6C36FAFD7ABDD6297A5F019EF47ABD7EBBD56E153D568028AD76BFDDAFD50A
      40592FC0930EEE5BB7DBEA17ED78BD0055EA3590A95B9D4EAB082845A8A22364
      0A9E2BC215DD49A2E0B92264A981E0DF6BD71B45A7BC5F78CC75DFC982635E2B
      7A63BF0F60A9F5EA05CF15A00B9CD66EBDD36F17519522B20218D6061251F458
      01BA747A8D7EB7D7E9D78B36BE5144591A4059FABDC2691691966EBB57ABF70A
      0844A3005B8CDE56F05C01B63460DB9ACD56ADE875BDC24D4779B5056A58D193
      45C445676D1550F72264018A8BDCAB53708C9A05C8624AAF173C57802DA6EE5B
      D1BE378B1891EEB25EF05C01BE746BED7AB75FEB1510EB66117DD17DE10A9E2B
      C29876BDD769F75B4570E916ED7CB305C708C495A27916D017E3362878AE0861
      74859E02BE5E8430BA2C6FC173450853AB35FAB546AB56C8DB5B052863A4AB82
      E70A10A6DBEAF5800CD68B1E2BC09766A3D1AD35FBBD8283D42AC0973650C17E
      BBDB2C12933A45FBDE6F74804F171198569745CAD8BB488781F3E7CFE1A730BA
      0CFF8DAF2EA60BBA8A1F063EFC531BF8A9BBC0B16A8318FE4B86F09F8B5BA9EE
      A817DCC16F49FC310E481F3ABD6613B0843E0375E9F78126E1E75EBFD7AF7711
      E8F3B99BCE7E8AF9EFEB284C9BADC17C187F7AE183382F1FCE97F08279327783
      E075EC82C03F1FFBC9E2A53741C23F0FDEBAF194EE8EF5A7B137F9DFA3FA607E
      19BB8B3312ECC90633F7C3F48D3F870FA11BAFE013229A1F4EA23F07EE329D45
      B1F311FE49404F705E85D3C08BE1E768E1C56EBAF1A751EC813A311FAC624091
      DE601ED51B83F1AA3798C53D7C15A13102FD9A5B101360BF123F0AF16E6F0C17
      491E0EA3C9C29D7A0915B7842F97513C06B9A90128874800574633374EBA20D4
      D53F9BEF9709080AED1E8F1AF69BBC2757F3204C7897E963DD99A5E9E2BBE7CF
      93D1CC9BBBC9F1DC1FC551124DD2E351347F1E4D26FEC87B8EAF7C0EC4AB499F
      E6C1E7CF83850BD0B8ACD7410FE0CF33EC7E054B01C0070C62F814EB4FA9FE34
      A44FD3659A7A31604E1A27DE287560FF2EFD7174394AE3603049C3E11F03D70B
      C7E368344861A73FCD0199931A7F9E4431E048EA87D3FA601C8551EA8122364E
      56C904B0A60E800E565178310F6AD6AFA0724DC76EEAC29BE3098C0A0A5C98C2
      80176EE0C3750FA0511F24B3E872118026388B82312A7E7002A661147B73FFCA
      1B8F6074540C01C32F3C3FA427AFF02DF8187C80C3067851871DB80A607AD1CA
      0B6155DED52299C569089797B058D034478371085B1026C3F110AE92EA094B5A
      C2BA6161C9CC85D30C18F62F5CFB783A274C860F33BAB10EEAE3787A617D865B
      FD299B14F197CCB7194EAD4E0FE007B46AC17CDC703CB8F0BDCB4FA0E9D6E953
      327203AFD386733D8CC7F1CC73C7F2711245E9205904ABF432F4430F77467F9E
      A573382BC902D61084B3D41DFF01AB1A2C13D099876E100EE03FB800EF18C023
      F082117CBBA42FF0214EA7F12008E158C3C23D18023E5DC648800649E82ED268
      0A94CB0F475E10C040A0C54F7C2F80E33B86E10770E362198E52588F9BF8AE1E
      05094A0C3316A23208BD4B18304957F06B02EF98C6D1254C399AF829CE334470
      A72B803A524BF81DE61A02A54993C1C4C3B979A0E7C3E5D155B220CD1B28C418
      76F012AF7BB8A3EE6404C70927ED4EE8E62560653098D11D08B71488A41BC39D
      E9E8C22550A530597C6812233CF0C2859B5E0DAF069FE2701127A1970E462E1C
      4640B700C0E820DEF87016176EEAC0B4D824FDB7C125A0F1649E4EFC008E91D3
      68B56B9FF1E803195AC65E3A8BA3340D3C20CFC1249ABB23371D05E17241C70D
      E6E30CF0CC8D1D75FA807E87DE556D801BEFC5AB2E489AB8F1F21126925CE107
      807E38F3628F9EC647708FD0CE41A3791317107C04FB47C7D7219612C24FC105
      1CAD45B81CC573BC806618FCCE661634F12FC2991B4E91F184E955EA3AC7C28F
      E4E1066C333E0E93BDD3F34DF8044CF04ECFB6E05370F3371F669F6EDFFCCD43
      A7F2B968980E01E0C6D3B86EA82E0D74B38DB86E9CDEB626D4BFC98410E5378E
      04AC27065215B87EE8086E0FFE0967C6C823202902BDA67F8778F481C8BBFC17
      D80D60313E81B281A02FD093851B2C662E7E0897F3C184EE1E444B4278B2FBD5
      0640EA96490A847696C26B4232E829610906742DC106A49F3418CD069311F05A
      A012207AD6BAF0173460A06BB0B87AADD1A6B9F34D35E484F42BFED824BD1B3E
      4C3CB80F84E408EEE2413A83996F7D190FF597F6608407939E0B17D610E10207
      815DC94C69088FD57046AD5E661E83E160526FA0ABAED51B006866834F204800
      1B6D76800E26D61A072870D86BFE75E6A6CF1207C8AF031B73F56AECA74EEBB8
      765CFB4FC464A03FBC715F6FCBEAB7DAB22200353B050002881080BE0096FD3D
      01CC3BEFF22B02E21E4BE775375AD975CBAA1BAD2F2FF8C439306B3E7040A459
      CEE16C3B333771861E88D024397B63076412C74F1C92D5C6F01D4606CDC54967
      9EE35D790EF039EF58607696E29DB83490027D102C829583E24DE844A1B38881
      CBBB738788C9B1F362E5002F1D81A433A5B10E5E46E1B3946E774029F203F819
      CE86373EE0FB86D155D5F1E90561E40411FC149BC1274BE4AE3C7622CFE3A866
      89D915CAD84E65E88D5C1038E4285CC24FCB054A9DE3C3E36F74221A5B39118D
      6EC18968746F78223EA25CE54413E794A5EB64470EC647409B8FEF4F9D21E841
      805940261191D268E104DE247546511C02E6015C72F8F51A6456A7E20649E45C
      CEE0FC00BE7DA2E392BF11007BE88CDC108E9903A83786B119ED41819DE1D172
      9D35D86B64CCAFB641ABADE556DB92388E2F2CF665B4C4F79C06FEE8D3DAC8F7
      83232E66BB93DDDF7B05B088B73D4FD91FDCF14B3F089C04B4EC808907283420
      3EC306B1F40DB7C24EA152A676E3577F9CCE142AE00848FD087569FF2E7DF8D5
      7540D9F051A5564F9DA7405F9CCA859FF8B4CB3110B4F490E8ECE5860151A765
      2A1C7B490A2AEF98F10B6F219C43DC81F74E41D4DA6D9A75EEB9F0F0FEDE8E10
      AA1340505CB0E321EBD27CDB252E0D989A233BBF00E21A24DCEED93C79F3D1F9
      BB73FEE869C8E9C70F6F60A2AFC93EB7D5A94E40BA48846AE84D791860BF6E6E
      1BCE9A9ECC515D43F31A121E5A12A0D227CF5B24B22C94D6267134A7BB47CB38
      46810AFE26B0558B28F1533F0A1F66D50F41FCF7F7CCD2EDB3749BC5AB553BFE
      C41E8780886732F610A830D23214A1B38A782D92EA043ED253F8B56808796EB7
      89FBFF1F45F31D22EDFF8A10CFD0A63E84F5DE92B823AC948489B6719468506C
      4079E441086AADEAFC9DD0FA68CB27F45BE1FCE3304BFC7CE6803632F7929D41
      7C56C343508692E562112189741D0EE743B178B8F40352A934648EF1EF4A21BB
      3B4AFD0BB25A7880EB1ED2D6385A4E676C61A0270E60E4A133F7C2A512FD9355
      927A73BE54F1E1BCA0416183CE77A80473E292977E388E2E09E92F7C97AEAB49
      3920FEABC1DF2F903968FDEDE3F5B7A191E40254405CF522F650D7502FD5CA48
      8ACF6A8B0B2C3B4A797D3C282D03B585FC8CAABC26829AE3A2B1C4C3DD4C4947
      058AF20637DCA98CDDF813020E990FC021C0ABF07D0894680AB00CC7ACA9BC84
      DB9C8AFA55DD2D0FDB37F30BADF5E3EB63EF9F4B1FA6002BFD8450462F8AE2A3
      3015D8492F44156A4CDBEB440BF50B4341AD02F83428CC63CF305FDE4A191EAD
      3DBC5450B00030E96E5313326D002EB8970092D04B58FA007C9F80FE8F481E44
      CB78A7E80CD9122F1920EA9C69A196C0E190F7DD433B211A1F45540BC7081CA6
      0089DC99202520E910489177053AFFC84FD1FEA9CE2D01FF10444EE0E50F74D6
      D884100439132CDA37E7D1D89FF868F194719EF3F3873C1E3E6946D24B1ABA28
      030B395417938537E2B172C40BD129F1A721BC1445658D5900B174892460C78F
      DF1B6FEA0170379CBA5DB1AD9EA49AB1D20472D6549462992BCAC1740464628B
      BD44C71A3C3D9D061E2BDB6444F3033F5DE118FAFE348A02399FF29018C9E06C
      00A361C31B309DA11FBA8CBB6C6BE53DF93883F757E85CF0F6F0C9D2BF9FC028
      95B5D3A21D06BFCEFC80FD2366C3E7B8A468E18555D63849A553AE0FA56B6248
      853A530C8AD82319A02A6247CA3A28DD57C94CF7B93DB9433588BC5F0061B4DA
      5DE7833FC2FB8F5EFE74C6947F47CE5E86E54D02778AFE2FE0455960D8A2239C
      992588DB80435ECCBE3C0C46C2331B6398C9CA329ED00F1310BF81B6A1CDDA4B
      515AFB0F0720F6FF296C54FC127EC4083110DD4F1C8A7204C637F75397AD2878
      AEDD54E1ECC865D10F94E084A69644C08D2392ED01A7B2121ECE82194F668280
      F229DA0E6CD9B73C05FB7B073FBAF3E1329E7AF181F316B4861D3907278E5938
      ADFB40B197CD569602CF9FA5041E33C7905190CAA3FE468A18995C2A225306AB
      43A1F7183687980A1763DF4BBE13D073E030E5B599F0191D199603430E0037B3
      D7E83815159652E3609509FCF46CD81D00F3FDBC01013279E037C6845CAA2E3E
      7B03DC0892CD07041FFF1A18F2264232F22F22478F6A5F7E70E7DE1B3F045500
      B4DD45EC25803D878F6A86E7EE85F7A826249AC98E50B6B7512CF61F3FF5E6C2
      4889DB85A1370285DF8D7D608A95EF895B8E3D205463A44240B42882FA2A25C9
      1114C589273A305DA53113A0782B9005E05B74A1A823503DDB92C65138BBCE57
      5F9DBF51D6CB1D413C63B59D2C494E54B65B440A04078A9B1A49503B92888A0A
      70DC4BD4665CBEF7D84B0207300E38A8AFF53D7FAE8D296E70E9AE4882CC8EAD
      752F750165DB79345EA29E481691A1E704913B56C64ED739203BC8819304516A
      0C2733A06038B21F536CC5D94B44FBC5423D463117AFAEAEAE1C0AF33F765E5D
      B9246806FE2756F9A69831EEA16EE7895830F75C90078CE8ADF54F188F5EB75C
      E0C746BBE91C20F80EF4C42BB51AFEF2FA25EA9FFB7B63A755EB77F4C4F55DAF
      5FD5E4C657AF5FBF3E54EB74C55C85134A7D6332FE68EFC938F212A2062E9C79
      D01EF159278A696FE83DFA356861A75F879812E1D14EAB1FABB2B1710264C59F
      FA69A2A424062211A177EF3F02D8632FF0393806A809CC79ECA55E3C0768D9AF
      76C3D51CDEA1775582F37083D02A8EA409B128617BDBD04322C66132246FA1F6
      61B08E26B2D24A0207ECD3065490BEA11887E1B0A03160FA8E04ED84CEFBE11F
      0090B3975522A3CF18DF02D7ACD00FAD155641D7F99F047D8D4AA04D912701D7
      8513F443A3976C40531B83E5FC14B9F0D2CBC8C1233D47D825DF6DD9A5777446
      8935308F07F0B6236068A35D833D7CB4089FF0300236516A8FB28EE89D549A69
      8E486C79F53F25DE721C7D85D5E3BA2C64CC00838F9E4003119E361E98DD4D20
      2274E7328A3F25FC305A1C91308948308EE82410F1B1D14D30DA26613BCECA5F
      63821340BDDBD9318E6E2D1C10D3539448BC72CE7005F43274E7EA8C622038A0
      ED96E39CDE773B48F88F61F407882CA3901B22CCA98A8C80CDDD26299944DDCE
      B6270E829226FDEA74A23D5AB12F3AD478F4716580607EE8B303DAF9E091543F
      F2D88B4E2B4F145AAB387F92526C0985053A225AE7C47957E7FE15D09B39C38C
      7F66B77CAC5E90686AC589976A9EEBA709DF66CC8B3108852B65765944400945
      850957110808628E4437BF4C0E1D5B3E591A8328FA8412CF8639E21BE7CBD18C
      1D0468781F7944116972209E815E34F5C87D378ADD646658F10B7812FD59FEC4
      07FC8779CC315D1BC741004B6457C2508AC9241923C05910E40DB1B780218C09
      54FE642536A47045C2C781E47B1F38176EB054749AF6D218A4769D186B041E63
      F2C8A94BCE901DA1C7D9B5633A3C265A8BC11CB50A1682393F1584797223D325
      3A9B1C4641BF8AE41C8501A21E2BF243445789AD61B9FDF4C3A93674926082C7
      03142150C4F8B51C93A88F0ACC8F0DEB342ECBE23030BF11C684A3CDBE2B8C94
      89BD04D3B8F10528E623B2874E1B741845C46C4D31A25395A159A94BD4CD3CDB
      00911F84E47126CC460E369086A978FF681E1A8E3920F2F2E16DAC3E55F9B4CA
      8BABF8C90EB2A6156AFA9B385FDC1FD15CB38E797EA78A011DFC8992D7E03351
      2E5ABB68C7B67AC581A2BCC1B0724E5622F60C50C1D491099013E0CBCB14D5B2
      2150309435157D92A853A5112B3A8A8457015D5028B38470137C6D6C526AB325
      961F03A8F9160424C51B71F202C80E72D070E083976EEAAA95D3A1F60E185B41
      B15EBA0167C8F040202ACF886751D697CC57D36FD8E7F5E9494050912205C4DE
      7B4855EA25BC90D6B46D31E07B521D026F7F2FF50091C67E827B99D05119C951
      7BA8B5BC8103B27DE5E87B504B300190440D1BB78CB19BF1198F1E5D5452CA43
      AD13ADD90FB74E5A86BD4E21DA8ACEC54851B7BCB4D3EF067FE2211A7CDE3E3E
      D2E114998C225CCCD2765C6E790BB7F947C8F6C82EA77718E9A2320E012B2C64
      213B22E220D15EC411FA2974A82F8126D6502AE6B2E325D98B248D420CAD5E8C
      37709CDA1C3761417139B80F89B1D371EC0259A11553B0228E4F7FFA191DBF78
      3E2F5C3F402A2BF615E42996768062CF02E5A9E582A781665DCBECBAABD87F62
      098D0873112741C06C367614CB79ED225EDB4235097D5AC0714DB09C12C52D59
      C7C98C24367F6D445463C8B920DBB51C22926B59760ADD0B7FCAAF56A166BB8E
      AE67730CC1075062618E25EA0F2E45F88D3D2CF5B56356C0B77C56C5D7A252D5
      B4C5884DCA24D68BCF0C271A4E6D9BCEC9BBF333A782E69BE10A1415A0C9A83A
      C620DC63ECB1DC2F1455C2F6C5FAC121C7E43131F0AFA0378ED45A2FBDF43890
      92074B94351CA641AF624BCA219E058AF6727EC2848A68993818A410272AEC93
      9D4B33903A2FBC78C5B168B03865A1C265BB23E44AAC735A106163BA3F46710E
      C51EED6EA345EB398B6F535491EC6F72B0038C39913BB24E2FABD605FA412998
      BB783C9690615F53D4E8E85689D61E39C037A331ED0E89675E4CAEAF51E02678
      1B4C446D8651A2604DA2E73B54E94BC7B52B4D8A6C6A8152D2641209EBCE73D4
      476911CF50690615D1C7807A2C21848107E4C453C994B408A5AB6D84CDFBF3DD
      4E7FDCDF3BA7ED511BB62314E823563523EB811595B286B2C8CF626FEAA2ED08
      AD4E824165585D26AC6E33227FADB0BAFDBD1F9829E84D3B121283BB2B666F0A
      A32029082BEF032119E3098C886B44738AF6ADA287D48B431828342E4DF2EEC3
      BDB1A3CA6A283742E0AE8CA7E47160C22F6F4F5EA2AAB3403E94FA8CCAE96AE1
      0968C8D61AC7EECAA0B80616D957BD2B580522FDF9A755ECCF599374D123C4D9
      906C6D63288BD54D59CB0CFF52BCC271D17C94FA214526986346011A183F1D89
      E930C31D1E0724255613D9F506A45A07019A2709756E6458C17A6F3734AD1CCB
      BBB66D57614183C2D85DB5797EC23C11D7FDB8B603E875EC8609A02259966FB6
      2739B494F32C07570901149330A7A88829E716241E28E2AFE1A4BC1F063E8816
      6155FB179B2C80A8AF941F0FDC81C39432F370A8766962E7EBCD312D8E122312
      741ACA045918B37D7AFB7BCAB18A93B00E628899F8550E8EA46A5070B28225E5
      F4862BB573167C9C8A8289243EB06D3E0BA0DB21EEC3A02D359DDA16E21E2A4F
      93F98DC2D0C8E81FACD631FCAF2EE9E4B9A3E534B2B013D50C2D20D71BED8653
      21D9F9C879037A7CE89C1D5AD629C02229348E29D2CBE4019C02A3C591E87ADF
      FDBB9AD77F6C1F9B2E490CDCEEDC6F39DFDB94144B54F981C2196371FC3BCC79
      994E7A0F100AE31A9C62CBE731967294780BACC54C4792E5AB210A5A1C4C4EB1
      1AAA943D113C75588D84C3F20D2596AD21B3903820B53F7F7CDD23D925164AA0
      C243B3A353A44BDEFE60C695CA0089E132ECDBC6D1D90B090498A519BDDE4B5A
      63EC25E28FCC46ACACCB17B4123207A029DF4E8FD606236A1A2541A30BB4470B
      0F439248BFC9F72745CA775BFB7E237BBB3B85582CA1A6828CF9FC15873647C1
      98A51B3B8D2D83FA7C4650549A8678744A2D3CA38537BFA9160E830FFD11880B
      203B741ED5C660CC0292EE2322D78F6B6AFFF240132098D51ED5C4C66EE82732
      B3C6A39A99174E83473A35D0DD1E2BD426E8DC7E94339B7A2004868F7266B1E7
      7DE289351FD5C466CB70EAC6BE82DAE3A21CC06B02FF716EE81FEEC27DAC9C00
      74A14B6FFA4801B7880CC97D5CD886FADA72BAE44D7D74708B9749A2B7B4FEA8
      A60642E463E555C9A5377EA4534B97F1273DB5D62E296CE7AF4AD5ECEEAA59EB
      9BAA661B45E65DC05AE5A76965BC36DD4E89CA7747E5F63746E5AF8FC58FCF68
      B8BFF79292FFA82299989B31F44AE331E5D5702D3432B2EEC8993F5B4B32A572
      7133CBB345F164147967A055C14449B8A45C5A9C4DA652897428191E16C71DC2
      5D87986A44754F572A0636036EA72271B68973F03339C7323F7F77B029C508AD
      FD14DE7D68C5C9B1D74257F942FF0596CFB32208D17DC10117EBD350AEBA8517
      B2C3D7E59AACD88A0041808E8B2D3B0B7E1B2D9467E5F7ED3B0CB0E924E5084A
      516EAAA686A9B6AA06AD544BF175E1B36B50DEA0757AD5AF77E0DF7AAFD9803F
      8D6EAB077F9AD8293CBD6AB57B35F8D36EF5F1964EAB8EB7749B0DBCA5D768B5
      F869BC05CE4E9786A9F5FB781376CAC5BBEA0DB80FFF36BB2DBAAFD569771EF4
      2C6193D4EDEDA38052C488EFD15528973E6155C428FCBE03FFDB091A83A1F1A6
      4A31C5963973980B62E3B6B3FC1FCC254B5D8CADC8672E86B4EDC025C489EDFB
      BFC3676955C25980BA221A70556C1773166DCA696D9371C952056BAE47841E5B
      EAFB2C210096A71A28EED88B7D8CD527E2AF18C56E7B2A49E8208EA8E0B11327
      5ED52053FDF4242840490770E5E01513C603A7021F0F882B6BCDE31085002397
      4D2816C98E54D058AA6BA1CFE7147589E51E1E24B226F8EEDFD5848A0354F261
      24376EAB2245AAB9DE4792FA765D6C49E2A4E39B5CFA2995DCB62331AC5807AE
      6E4FD17756912E8A5D02256CBE20D04FBD6C36877E5A0B6DDBA66AFF8EA121FF
      710CC2F743046456CDC47D1519E07CF2568453261C5155674AD6EEA140408CD7
      E510965DA7586B51363B45B20A1A366C4C7F22F5310F2D55214C15E336742C91
      F3CBD500636C8B3B57E44AA7D648A9DB4CB14F9B434F604A58EC7EF3CB515F59
      8652C65B45C9501F4CA6C01CD95521CBE4EBF72D89CC7DDFEDA81B70AD14A025
      0723A5DA05DED5C803E221C2ECF1A1359F0C3038DC8B834DD7431E290F8CFA18
      4BE9115C1FE95C3AD397F2B5282A4BD2B49E525496D1281FAA1CDEB15130B6DF
      7895B2D48E1DEF787ABC75B19C6397FEAF30FD875B06D72A219C9278495554D2
      75F09C051ECB081AE1C65EE2C796B8AB8B636D3EDA97D24CC24F6CA69B324293
      8CCC688B45A65CEC991DF9238A30BC85BAF0ADB31CF6F754098CD893AA45DA00
      644062D51A35F1CD23E9E37D37F2B6AB0C775396C68EF0DC0D4BCFE6EEDA69BB
      1BCE2312DCCD61BF9415C2A8986975EF542418FC76D2EE3665DDBBAA096888C8
      241F7C2B3DE7AEBB7D486495E3C4A56E313386AAD97032186309859C7BC94AFB
      4F0819E03EDC5E342D73D506EC3E786A37F2D143D86D070BA99054FC51F9E709
      A38B276549F2B0F08B8506FFE62001BD76DB7C9C4970D67E9F23E2A97DE82A78
      8450BFB67281D653CF37F802D24DB965C207A6413424D1D992FE2A08D345EC47
      31B587BAF0E202DDF5D0E2195BCF8F79D0BC98AD37C8C6841E82F36DA77D1B84
      B16D270B557C4DE7F86C570EFCA6593E779AF1FEDED7CBF2D93AF26C1FC53335
      6A910CA02E7A89328A2A9E4DEDDFAA0F7510B62FEBA2F393EA50C626BB3143F1
      90A6A98A8D5985166B28510D15C99A0449044B57AE6C25F7A9288022F55FA38A
      F322ABEC2E04BD6914FB43CD81275BA77D0F9AC3FD406AEECBD89D46E1308AC3
      075471759969CA414E7DD06456D52CC3BF963F737DDAAC6186BC3A8AE99248B4
      EDECCEC57757F0BF0760BAD8828E9995C407306A72A3BACA7A9793C36C25DD6D
      535D5CE5F6172972D576A7FA508C2D5CE5BDA5CCE0AA0F73E830B269EB6624A3
      6B10410CB00C2215376EA98623E4C1465D35F0B8925B2DD10BDC6E9A311E9E5A
      BF59DBB6CCB4EB769737916EF9B72BE6964DED0E9DD073E382DA8614638525F8
      D0D56857F804AE2FB66E52083796E72BE389EE49D9380C4EC1F63B47522304AA
      FCEB3453A8429795FB8ECB51ACD5A3C83CBB4144C80E5037039CAE623F08FC51
      7604AA2CB0F664A75DABD59DCACF1F5F1FF50E77E268FD8ADEBE6DD3FD87AD62
      84D67D555C5F9F63B5876B75DD810E94A7F99ED181B5DA77B5DAEFCE0BD3AA1C
      6BB77BF177CE6FE21F93037E7CFEF1C3D9BB1FCE7F975376D333B90367EC1A85
      FAAEA7EC017DAAE48FF7C82F5875A8F2A6AAFFC9255CA2D4A44A94C7EA8EC7CA
      28DDDABF5C707E9C0A397DD4761FEE2CA7D235C0D026EF6E5D237BC023C59E1E
      0A2AF4E94C39AAAE1B57833335DA4A8EB51D8ED5DACCB12C539797CC7F775EA3
      8545EA9E57A810FA7727FDD7BDE68BD7AFD5C1BACD707739B8B719FF9C7CC1D2
      E060571A57AD9FFDCF5BC6183455FC17FC6FDBA60A13F10BA79B18A965E52BC9
      C0C393817A63F3B93A5DBC9743F9D14B52385B8B82B34BF4E147EE33FDD2ECDD
      37E4C18FB1DFC11BD37579E686E3605728139BA682F5D59B1E6FB17719FB698A
      4D06A8D71675DA22D4026472312C1E6D4FBA4A2256C7E766E0739F3A4B223130
      75EFED42B6DC5C97235ED72B1A2A2BE9B925B957E9E68FAFCE5B1846AB0ADCBE
      FBC55E413E21865C109CFF489D68A4542D0CD27E7E7EFE4A22715B262E4986D9
      760CE92258C27293E3F4EA66B127B7F1539825A90429DDD15CC561FA21EC0A40
      C5EAB0CC04DD9AD7A1EE9022404068AF3FC8AEE8C0C342E40ACADB76FEE32468
      0E3786D7EDEDEF522B4261405555EB559ED82DFB5541FED9BA540E33DF7A0D6F
      2F09B63D4F1D979DA9819AA2B79E2B9F2279D08DCEDF725BEFC44B25A69FBB4E
      02DECD7DEE3F627917EDD0810C15B84B29847B6D30D73F70F1765D12818A24C0
      15A77EFC382A2274EE5911E17E10B25A7B6E9D063EAAED6EC8766F157C3F5397
      D36B8177E710D723A4845B281E822FBC21E0F0D61CE4E092D364D0BD9F00CFF7
      DDC079F9E614CF3B0C324607973AE04736E97E547BDF7A88BD5747E7FFFEF261
      1D0148D5B827893E9290E05F3E64EACFB49C5F3E3C0AB46833544F29C22B0A9D
      D3603954AD51B78F1DDB9F7F87E7AFB81B666BD85D41BFEDE4BAC752D72F3C2A
      9AE05F5D0F3A9BA82E815633524B56A6741B462EBB930387788BFD0DC56516BF
      B1D31B95FAA0EA4CD4CF0D5B8125A9095A54AD1E026CC4B9B25D822CDC98C7AC
      B611FC1A6C812D0D0EA821198EB461E7A4EEFB6249AD9E6172142FEA87D21308
      EF1F020E7C3AFEAAE5BC1FA3FA8FBD51A4CB9F0E8777C6C07DA2DDC9089A6D58
      3B61B43A04159D8220F7619C6D5635747567764CFA76634C7957BFC9E972B964
      119F85A4EA1C8CA2C50A5580E3E363C2CD03B627F8733F00B063EF0422F8C9A1
      31495886086D9D507AC0996E7CCBD90CAEEEE92947534ECC2A5A4AFF9CDC69E3
      8965CB1AA1D2328A82E53C64909051ED3D1183CAD4D7AA0B593EB08D7C825D4C
      C5F6B188125FF58FD7E685C3AAD673F0D31BD6782A93AC460A7791614ADEC43D
      186D8073317AD063E7672FB1B1E3C4BFB2F521D5044C6D81443302718025628F
      5E865048359624A098E291725D50DFCAF3A4192B1D4C00C56D842864817EBE99
      EA38F670FFC6B73044C3B1F8E41D4946D143E8D1009C672927537AA34F2626FD
      7506E1152899B42AA22D8FE85F2975091B554ACA18FD4E46AE3C9EA9EA5B04BB
      DF8E7FD75D2B81FBFCF65FBFEB2231FF0DE84AAAB3AA15867DD355EB6C0A171F
      737FF894DAA8E526A44679192DF1F95398D727E44FA7691CFCFD554879273865
      9E2735574B353D302C886A706552F447412459834C31781DEFFFA15E489E0F4D
      370E4EF3671DF89D076002B54647C5718B4D753CC9F8B7CAA40C9B246FEEE10B
      A70BD404384ECFF541923E7A5C3A0D0BA6D996821BCC897A704B9B544314A937
      EBDCC390DAAFDB90E931B2CCF7E44600C03F3BD7004242A4FBD73AB3883B979F
      7EFCF086403D66EC1B21F63DDB11B67A42E8177154FC1D4165181FD5903B76A4
      B61151A1891B2406B5D97489922ABF91D945950756B5BF665E3086375C328FCA
      D004266BD8D967911A5FDE5BC94081BFCE0F4080176C78AFC0AC8130AF02EF50
      52FFF5F23060F59B1574792C47E4F5124924B201652A3F9ECE22D883DD6A9F2D
      8B36D18FCAEE8B8DB4569C4252914A2722E22C81AE1046718F29AA4BC58DF256
      AAD3F4CC15614586D75C410B8213A4FDD4B54BC6A20A92D66CB88168D51E45B5
      9EF7A7616411F9573C3B390EC47B99DFF1C33F9F197F0BB2F36BE7B5ABA7E134
      23B447D45E12080AD19364C78E845937AAF0CE04CEC332965A639AD803B67152
      BC54808D50CBF0E752EE066F9B46E4979586ED698A488E576C75630172A6D109
      7C6CFB1E93F09446A94E159F01A01245EAB33B52351A5BB862598A674BD5002E
      3DACDA9448AA02D7F8E56DC643812D8AA7ACBE71B77549CFAC92C2C1BA074AC2
      A14BB503F4BB75AA9DBEC470926E7829BE944143101BEDEF491BF70ADA412EB1
      B34D383DD4614B2411BBAA6DA9284133C98E1F7A235757BEA00A704A6B124025
      4884A265986A4735A5FCE986F064BE393C765EAC704C5A94F40C4EAC31887499
      2EF6B03A10A1FD050ABE3ED5439800FF4D41C64D8583B2B22A9355F5FC5028A5
      8EF1C8F445B3BC8059ECEFB1437EC60926CBC50608520A22F52E9CA9FA750229
      53D44E54D6084E858FB29D58AC1872664CD03260402945494A0DD6DC9135244C
      9A2576208902F4C463A623C60A4845097C28BF8699CE893438484A0951545452
      E78B1460E85EF8534629ADD87305090C51A412C7EEFE9E73F09A945CD221F079
      3DBB83634B4A920C5BB259E0938B085056633C1AF110E141FBA1628A21330C29
      918C10C08180103D4BC4582833367D14B52A65A043E84610C1EBF82A5A0C0546
      00325B2FA48933A043ACEB437B75DDC2E87CCFDD4FDEFE5E821E53220C9E9B48
      076B5C0311BD9C9BBFCA07D353261B542565B3D248ED616E9359029C2096C00A
      DD299E3E1E855660B61046207CA343812424B7EFBB9E0CF7CE8296739E33C0ED
      083BFC55D9BC8726D28D4C2B14CDA3384A5574F94268E9E4193909E62A1D0465
      5214F377A86DBEC9FA4888DCC861E71157C5A14819C5F86C139B79872E87642C
      8E552789C89281B477EC6311436A5BBF503531FD70EC03DF4471377362C42AE9
      C75C29274C13DB0E448511840A58D63A7C901C0E70E27D8CD1F249E055990FFA
      0D161D5F01799FB34997033094458988A19893904E5EB800BA61B0F355855F85
      0885E72FFD840C7108AE0F1E5152BD7F3B7266B9548755C6490A81FD4298A850
      12CF109B2208AFC702372CA845903460ABDAE22488C4CB505B1280F5289C44C1
      C19C14093CBCCC48AE6B5E0CE64EBB8EB9A7AA34CA6E212AF96F401E24BBC325
      35D4264C1459C552C44251E533455FD1D3EA706D19E3036868D76EC63FEC6D92
      4D75FDE3D0AAAE75709A7DFBF1F1F181C1785FD5D63687AB8A6F447A4C4390D5
      FEAD8953DC24124FA2118A99C209D9B81F839E84AFCDB15178512262AD44E72A
      DB77B0CABB00F8CC618F0E8AC80BB327EF15B5EAC8D4B507CD018DF4090BB141
      147DA2639C5AB4C21DF252E06200AC2B759AA270245A15AB8822F27784BDD2EA
      0E8F9D2222C41547D4722EF22409F1E1FA4DA85AFA17A537A05FC8253F3AAA32
      F99D90EAA479EAE727B97DD07B4C1B4258C1DA8DF23EAF092281EC0C123EED7B
      22A537427FC970997A467D53601309473AB1F0A470DF586303810400802B6377
      8FA9C922434B2CF7D0B3FAB6A34FD5429A63E784742ED407FC78AE105BB96834
      B264318D563DF4B4BAA1C4A01C02E9FBB817CCAE53EE1C7476826CB37C91C70B
      3C2B89696F6405E810DE228D3718EBAD09BCEF58B5B65DE1DC94C73ED26761E2
      C5E9B1560DE4C67984660C980A39672EC3353200B4E9741927F0F3CF0BE7B9FA
      BCBFF792F491D30FA7B977A232AEEB9759639DCFFC49FA779E852A66EEA65610
      90A2C8C413489B979BFD09871D4D2416412807BDDA9F140D734CF69CAC9F173D
      C31F4ED57CC5579F99E54BBA6699DAED80277A63D66725F61355CA4C0739E16B
      64C2A66F948439C964C86B35A74413B3BC84DF0230C0F27097BE18F0CCF2ACD8
      728E1EBF74B11D0B2B35A1B688BE7261D84C4E2E974CC2D7A027F94E51E4F9F8
      BCBF5043BDEE376DA8A77DCE47CE89C50FDFBDFFA803DFB4BE81D64BF177CA9E
      EB881CA40BFB7B4458D8DF4955B38E1FD54E7FE4E0A923E77D9EB9AB5844C1DA
      8C39FB71ADE13C5AC623EC757C921751F28B60F954DBE18DE17E7F2F5B175142
      9D78DBC4624CA66F5B3EB27041C0C87556ADC2C5F472999F9A4B9E5D3C0E20C2
      8A87BCCE23A4B336D4744468352B4551F98B4788D367E45475DEBCE7A5A0B754
      B6CAE20836D5D71156C6F33A57F979FB7BA618F5DA0E5A617BA8F4E99E3E0A33
      ACF8202EA34FB17DDFDD2587240FAEC6AD12081AF9686CD06FBE48E9EBADD6DD
      493D3D7C435AEF071705EE631AE56B90FC134E153BCAE777656A491AEFFB1CFD
      9F31AA9240104C5CF323D850C0D117186C0D4B415A854AB7375A66A2672FB55F
      8A82D830860604127A0AA4B470A5C3F074A026856FE7CF0A567807F6E691B745
      918AD0DC9F1D6BA2CCC81BC712CF5AD1401F67B60D24517E451E0A3913ED1876
      018111389D7387D417122015834EA3E954CC0764131095794EBC49CBD5B09091
      47923D5633C6902C7644F2AD9A17CEA3A509FA7AC115FDDDACAB77C8712A632A
      D2A07675EA5F50250A8C17CD1349659B20F3013A111915D199E0C5A5189C218D
      BD6F2A06EFEFFD943140BD13039424D16AB552AB75EC4697F673545A3AA7216B
      9F98F59B0C5299FBE13231614C878F4BA620009C66E224222637221BC832D0E4
      8B81BEE4C8A3652A2359E02F8611A293B1F8913032E4D819CFCA987947550BC6
      7EFA753366BE69FCEA2633DFBABD8E82BEAB9BEC98CA966785B9AFD9328B0C37
      EC0AC5919087F0FE1CC3935336D94F744F28E3FBD1A64B227EDAD549AB503E4E
      6B7C34C6E71D780739332D9A6C3241EFB815534AA05006CCD0BBC42808B274E8
      C1C99E9079909357B2E905BB6AD5CCEDE36E78A3D6974DB89FAB3B91E900E06A
      A3D97A933B3398E5734984A5AB267F96BFC0A5882463A8D3A82AB917B6E78673
      99B8F030D754518D07541E53489D4B665EA035E6F718EDB4B642896ABCF08A17
      C7F770470832D5A883C762A8958724DE3AD2F937BF691C912630F4386012CDAC
      45A645E9D22A41BB1E96AB3171C62E55B6CFA8D1BB7A565F49B4E66EB98E81F9
      251C75EB26C63989E7C79C1B34B263E8827340E1A8050EDD5C4DDFACC77252E4
      C3B5321AD90FCDEE0F8B7DE5BD85624641244FB2095CC636A464193A877946EE
      52B48FCE8DD2ED5432217DBB7E1AC8F7511E87EB8F033B882CA4D9E689C8F806
      CD21504C44FBD54395EC6BE4C84DEC8F0D81E4E6FA86791A8F05BDA9CA8C721C
      9698BD86D95C85873C9780BD0F85E076B0C81AF5CF6B585FD2A9EC807AB857FA
      B58511BB5F639DD26D078DC04F59ED8947DD74EEF462F54CAC605635978277E0
      F4EC33F9E508A4ECAC46B328A271593BCC44D12E69A7D839A25E4FBE69ADD669
      D7B4CA7DB67392CA84ADF90277EE5C36604768013297FCD2B3E717B5A5159598
      300129266CC0281B1A7395EB76ADF0EF7DAB42ADCDB37275B8FDE2923B7E0E4E
      60625826200BEA831D390ED904F6025870A0D21C96E01F993859D3BCEBB7ABDF
      D521B83E9BBD7DEC9C4AD411878A8F39F4963BBD93324FBE5B2799633466CCC3
      3732A51D8AA7417A8FAE686D8E6C26B4A2208C97E376D7166E73FC022B6155E7
      E5655432F552F29AE122B9D59315B1EA0EB3EBE2625212E2B9BE9EC09FFBCC6B
      4D88D88619A3819B131DD12BA54D9917BEBB4152B90620D48E92BB49EF3A85F8
      A04B247335A3DF08051781F7BBD13CCC8EEF0AE5F8C82766B1DA080473722A3A
      BBE83A693913C47DB8A13CB5652E51DD3629FB52B9858844C10B361C09902CBD
      63E70C074B9731D7B5E76E9D68B64C74456B6D3781978F6377AA3B9E334DD215
      A425E8DB19613A8BD85B285091AE2499689618DE9339F54A15602580722FA928
      8EA948B3882300D6DCB2182B581ABF14936D06BFC2C6EBF7211FB2495010FD79
      E1C56809A6FCD36B7694F2D4AD22202A300BFBDBD181D5457ED4468B22A0D2D7
      D0E7C6AF623B336906AA02584965141F94BF09D267CA5DDE098AC219FF2AB601
      974DAE6DAA39B6DD3E3A479CF92850DE76B131CC88466F081EAF8CC4406FE552
      F8F26A85F23F4A7D200E0E279FF74920E1E13A795D2A223047474B814A7F4B28
      88C49F6486B65CA5F45E4D3E43651F18B98928CF76DA3B3FACEAA470F94B4CDB
      E5E87895DCAF6F7463195FE8A08F8636423009C2DBF5537D42E5CE3839583CD4
      3B719A39F37D14CDE71C9C1B92B90A382255C5332524C44633738519993C6A71
      E763B070A63603E166C5AAA32737FA949AEDCD1711AC6B656A025DBAECDD5A86
      2015CB29C298502C6D37E60A081C3032634FEDA1644260250E250060E432A6A3
      7820A403C375170B558455E3F75615FF23429B97048A7380D5B6691459C8282C
      C22517697814A97ADC15FDE97B6EE3C1B97955475F1F07A3A4EA9C9E268762B3
      C3721448A8B1A03447BE6D00D48070E061C1F49D8BC5B3AB43EC71501D61D79C
      2D036E7FCF029D2EFE910945BA012838B092729CE6EE0A1077142CB13A8B0270
      CE12BAABA4F3E01CDDF63F8714EAE3FCE887E9019CD545E08EBCC448CB0764B3
      C0DD3F1033C68ED057321A6C8211123731768B1CFE5E52F42B1125B6C9A20ED9
      93C6011112298A91754B194DD54002E1445962EA3507E30553CAFD1C22C18611
      67F056232CB0AB60198E25EEF847773E5CC65814E92D653AAB8C5722ABF22609
      95C1A21CB01A0EECC0180DC326E44E75244E55E82C6503FB2AA244170B582658
      73830AB9E5CB056C1CE2B7FFFA5DC18A46C3BE3898CD407C85338BEA6DC9764E
      8493C0753462C1B1866D46519D620FD94F827309A3E85F9E7E5A036ED74F35A9
      39E88561AB960A85773CAEA24890C4D3BC23A7F80403143310A9BC800377A8C0
      702087379F7059195B66D5345E7A3A70B7B048A8C849AA8495C40BCF8B77A2A2
      4266B93E1986A8ABB25498EE80D3DC756C56A153008F8C796747B037535C7693
      998BEC6C84806EEAB12BCD0F8F888753A475C44DC8CEB09220D640175928914C
      C0C3AAF31A64AD543AC11186FA5E3096FA6458408007356371BD23AA3D0A8700
      1B265A0574CF2D4BFDA679F0E06C750830B7D019C7D18233C291715121B84544
      351881C1489E59C5232B3D29F93C6FBB9AFD6C39C5A298156DA6A344192E29E7
      4E433F85F51EA29D7F6C15F6DBD9F3C4B44705AC213477E428A14AB061F520B3
      51950C94DB369DB66C45123218C6AC2523261FCAF9C3F2B689C395E0B1C53357
      14208D6C187BEE27A9B5C42541134E3B79CD56601756A35E8656FB5DC7D0132C
      4329F5D97604354F88862189622B205A5A5431CE9194666580D84E86D1CCF72C
      91FD8001972B6F79AA2AA3BE8900259303DBF1C35D0FD0217DEDA3097714616D
      45DA552A8FEC6FA354DD862F487E574FCB8F6763A4E42337F818BD2533C7AF00
      0CF544D5314FE375FB3B8F66072C36B3D3C478B1FD3D7671F9297A736C478C52
      6B28D67FACECDCEB433815ED86611D096D0E879653E7585202D89595F160A576
      A557FD40D59152DC6472231346EE15A406AAC8A9D42E40C8DE6065284BB97C23
      6B7DD23FDEAE4715462900607F8F37C67E0A8EF5289A7BBA6043188D337904D9
      BA22F61498EDB37E8585D7B5A14EC6D01D6165B84BD06BB12C88881526D13CEB
      C4328575D50D5CE2559643E51D63D758F2F549B016253DCF8F1DEF787ACCA67B
      3A24FB7B9C9424B751DC75E0B921D549E674B508CBC2E2C368B7C4200842025A
      C044E33CD556E5AAE6B27F1EF9CF72259D686C73EAA435B9D92ED9A86A91E31F
      EF399860427DE0FF0B9DA715E9E6A90F2603D65D1DAA82B4F042150848DB3E36
      0E40B36F17FEFE1E27E947189A0887CB6CB5AE17C5ABC222D836642F5D6BDA2A
      25CB74FD51491E30C888DC10402697A37419633D5B316154289A41EAFEA2E7D4
      2AA5E58AD5D754F992F7C6DE1C285B92C76D97778C6A1992992349A388F83355
      135D221D538113CE4753D479B4BF07C4639950F931575B4D549C5968E57D6FDA
      17EF8A3230597AA5826B64E0B6B796F4BCCCCE1FD8DC8A70EF54708FCC44DE15
      E6A82358AD3A8D6C52627248E07EE301FB3860D01FFC9F250A1FE7360166073B
      D38D8CC34BC5F8D864F2E0C5CA79E126DE07DA8003A95146B6D06174A576537C
      FB2AA9C98A8A610F21F71060EF3F1666D57754BE7748A8E7AC74E7F4D59B37B8
      33581D7C82B460A46E3DCC9D90DC3C4C69B7AAF3F7AA73C4ABFF9BF3C95B25F9
      AADDE29203C0710CFA49101C54F5B777704815F0CEC20B94BB7468ED41A69901
      176435074DD365394CC2FF94314FE584A813A1EA705AE74A582267F9AB1A9B12
      7F4BED775D95FAE9DA45E9F426E8BC4E4AAFA51BC55C98787A74F5DE5C6E2679
      0D4D3ECA22E385DC55E1F103D0A89984C270EEDDEED8ABB341EF1ACB554AE0F5
      ED10120F4528E55A1F7A243FA0DF4A0DE806EB1DE2745D180C3D59FAC19878C4
      1AFC75E17FEA4B6FF5A907C241533215955579A384AB6A8E29B4EE408F7A405E
      78D5950408D10A1D67DA830FC41A163B63B79A0EEE51413276C17696726C3792
      C44D251173500E37829D1C7D02928DC41F17A52D130187F00090D85807E71F99
      A3BCD34D7325FFDF335DDC041BBD4F04C0AA34EAB6216B31173DC4F365688653
      B4D92C84CDF36BF2B21DE7C436FA2826BFF9143460E93341E19C9B262ABD9612
      C21D4A8B98A07A9B2E43ABF2A9EC1F9C12EA2B46DD1FB87E29874CBA0E762E41
      5C04716E1A933C8701673AE61B7FE6082D9800B29F8411F6FCFCD5AED336650A
      3D10D1019B28826E862179D44FF1472ADABA2BD1913F29FFA4693382BE6A9618
      800CA04990DA32DAD0B238BD82D7B1F3423A98A8AE1524984664CA7F7B72FE11
      E8D5501F311D3C6149C512074DE39271F219623BB63FB26BFAA00C5C15C992F8
      7880D11514B3877547A265ACF3EF9621C8A2928F80A76709923D4B6320F993EC
      8D558F602921D5D33FA403B2F0A2854A041F47BAC3930BCF780B2547C368D661
      25B285CA2B1E3A0E4BD2ED4AB3C117CC388CD8A25D9C5AF846ED498270944E00
      6BB361AFAA0D33C591563400734C62E7DB7CCE3A9222760727F01B0FA0A22C41
      D5DB5CDFF9BA94B04DAFA50DF6F26FA6A23DC9D268E09ED5714644E58456AA85
      5D5D2B580D143AFF5CC226A9EE8A7A31A416E49653B0182DCD4799881DDDF347
      15F9B0F19A4AB457659FA85A91122FB3717EDB0F0EE169D02CF0E55BCF9E213D
      43357901606F790D67FF0040FD0A87E66CFE3202E86E3D9EE5D8F909F3213D56
      B8181FE088EA582DE94EE34904A37437956AD32175BFD0CAD838723EE1BE5EE2
      082BE9683AC669EF3A6F3C9B63072D71AB325D21FB4F12C5DC308B2C98A29AAB
      DEB13BC2296D424A52203777166FA169E36265A4A2D4A7EDCAE7004343B936DA
      8FED5B9C0A9152AC37BC2E791F1E6842CB2D61141DA4E41CDC205DE12E4F3237
      BE38730F1A273E086527DB111910E4C75BBC196BE3362D73B228DE12590FE415
      963631E61B3CD3748D12A5381C8DB88E480954FFDE301278D385F64489C925F4
      3C31C60E0D5B46724119B82006A08AC6C102166FE770E00B9F847D4EA1109BC1
      A15C0D302E8E3A05522F1E0E44D8755AA1AB20B321CE9205C901BE33F94592E2
      52000415DC92CB36B48D7A24CC6ABB285BBC5F9DBFA586EC4C71DF442397CCDC
      52CBD1F43AE76080C0CB9AB3AF49E9DF556CFD898C1C1FBC89F3DB4F6FFEFBC3
      7735FA5FBDF53B1E69D5DFC354851EFC89C68FC1E763EF6A5722BC0C842A52DE
      5AC1E85019AADC0D90427CB3A1A50B365A91EFEC7BB36AE14B3B30201E308DF1
      281AAB62C816D53E34E678692748CD046D934E1ABBD238E483D224C6D800336F
      34A313963525EDEA39F851C1FB78ECAAC26CC21E7702CF518B2DD47D000277D1
      7E3230DD760A046F9115612CB20C85C770407E26235BDC2C5C380E0FAD371F7A
      E371D68A02E7346B86B64F952E928F77C2CB5CA5B41B170F9E73CC3E09DC111B
      8CB7AB4E0EFEFC01E8C93BA62906BAAA07C18DC17C2B0579E86D02CFAED2898F
      FE62B7080347B6D1B2C5CD9DB271DD9DB3F567F3194C491342EFA16ACFACEC76
      73774CC729E39AD1EF308A8C182B04F1C49448321D3E88371FA757DC3B62C391
      2EF1B52E5582381DFC54D7518EC24D72F08EE0B2D4A32E2E9C21BD4E086ACA70
      1A72DC305B6DB1D617F7A350D7B49F5FE2A07285AB8F1D95100C2FCE8E3E89D0
      C4899C82853C19B0896DD0E915BB8EBDBFFDE2C5ABDF9D0D412BBB625D2BCEAA
      CF229036F8EA96585BB664FF13F7003980EE31BEFDDCCC230975B1EA99EBA279
      91A9375CCDC529E94458AA064CEDD9A7A603EDE6E853D3979D238D44EFAA8AE5
      AD4AAE9C2D8310731A368171AD3AC23D45E3231D434A21691C81B10EB244E50F
      712FC8C4AA55840EF460398517118F55A10C76A1A44C13032BF8A822F18DFEC4
      39FDF8E10D0AD1332F18678B211CEE385D6382F61BA6BEFECE217D2539FB06E4
      8C3C360F47C64C8D33A02FF027F074B178EB04218DD28E39711D9144AB89DDA6
      D863ABA0D9FE9E1C6A0974D571D96B7D23C36025918C3F87DC3692BEA976E9DA
      582421F907E2ED38D061F6C6E97E60EA0AE15C55246AD1BB8FB7BC7FFB7BBC83
      088287D8C5CD34945CEDCC48AACECF2F3F54953FE8ECE3DB0358F23F9714A14A
      46B5051BF59A4EEAEFEFCDBD24CFB4249B53870230CA606814E61B70B4146FD6
      C4676FCDC18BF7E7E7CFDFBC7FFF514701C3FB31D62D130CAC6446A631ECC1E2
      00DF6CFDBB651CA2583B710ECE31141FB75F36143D6C5EA8231528910E5DFEBA
      209FB68AC0BA550D9951340DD1147FC8A9481EC8CC07670EBABF1DF47F3B67CF
      E60EB9C025DC185FA2A23B54062030DD1897756822F6301C1BA1C9117D1CA5CE
      328202C14BF7329C2E51D0C6DA115454578BEB49B4C4C6857E1C62104A30A6FE
      4DDC8240FBCBA40516DE3E95BE4BE2770831751E3E254BF6AA3FC320A0D873C7
      2B3BEAB179DC38AE4B9B281D566697DDFB88317657CA9D0183554D1513040FBA
      D0540F694B6E99DB91D3967F4DA571A87460D3BB7C9DABA8BED6513C627F6CE2
      99F460E50E1CFB17FE78A990922A8B59C559384D038BB85170889C82E12A55E9
      1AD93C1540E5AC7DDA6417D89364B4D4113F00B9F17244E144FE848810571FA6
      A20526EE10B763EE86E88F04E6300339AF8261F5FEC84F85FCADA4C28C729E5A
      3F5B45D2E0E80AD955A777E713A15FC6EEF459F8EC25A6CBC2B65FCEA28C3763
      1793A3CF36E443AB00DA7C7872A1C12003480C6CB3EB12CED8235AB1E56AF65A
      02213A54B5B795B5818C6921450EEF3AB6BEC5067BA88EC429F03C123A0EFEF7
      72BE005A7BB0318FFD89A0ECFDAA4D4B9B734C2FCE8A43B0FA7B0B44D1A6EA00
      82C0425AD17F69B641757C28FD8B544DCDBD009E9580706785923D11ACBC1FE6
      BC86C3F9F1D579FBF9F9F92B2E03F1BE55C5D4079734A2FD3D6F3C55EDB5F023
      A6B57F4AB44DDF4AD400F91A38BF6A00051218165F55F65612D7F5A822ABDA95
      5CB50F2194ADA8629509553FC9BC1A0B3B536EC2D8BB3281D65C3E051B6D2901
      E5D8A97C50390B6B2234CB5628636386D564727CE89CB0BDE5F41F14F342E4DF
      1D0237D9DF8BF6F740D09A2D279380E4409001554E98DD4C37579C35376159CD
      A5346A06E861F22C0ABA1CDF69C74D671E4F54D83867E582143F011581B225FC
      10533B39C638B4E4FF7727BFBC65D99F4EB851EAC7A05262E2F514431A28E014
      C43A2BFD8573C541B398A01C8ED5F839DD1533ADA3B18E07DF8C32232A0CEC27
      9C45829978FE48C021DB9E28D68C3985634DB2E04ED8CA5104D0042135E566B8
      4AC0B5EEE005AA497C58CF35319E2E39C51C494B81EF7082391229938C4458AD
      10CE04BC6FCE7162E704558780A97FCCE2322D94005F19820C60A2EBD3FC7D80
      5D94DC0A7FADF36481892E2787F8CA3F905AEBAC039DAD2DF759E1E65507E907
      5715A74549A1945DA7EB3F2957E86C99529919B16DD1F6C4CBC5EEB8897F552D
      E2C5108C074174545DDBC197332AFD68F009ACE369D25A099855EB22A69BF078
      5CD5D374A9B16ABE61016B5A3426628464BD579AA5DE0771CAF1B8BA8D8DBC2F
      1393257D7A09D5F1AEF7FF40E34F9A4F7A4CF259FA21B72884BB1654D768BCA4
      4A2EAA0E6A68DCE6822BD56BE68450B27068834A8E9A861F2ECBE8FC3D5D323E
      8DB86CC70E9C37CAC5CFAEDBC49CEFEF21EAC3A11BE379CBF4AFFF11D8F6AB44
      8532CA456A1B75F6127E9C625AEAC7990E7AC79A4328741C02DEA7A9618E6756
      BA560CC2AC4E510B5CCAA8A49293159248DC510C3CCE49F0E85AFDA977175929
      DC13FBD9A5AEB3A04406B270ED0CEA52D1446BF964BDD6AD6625A68E49A614E8
      CDD48F20214C7114C0CA4B2A6A7219994C4DA091622751DE075BEC0241192478
      8A294777088F8FCF92407AF0D6C3B27114B9249E8E632CEF80E9509C15A1DE84
      E540F85DB627C7B2649A154AE34F63C8DCF016558086EB54C7DA4664E389AEC6
      C06128B2E05C4778551F12D327853F3660621B6FD689DAAA936866DA922D0DFC
      C60FDC989327A5C7844D778EA5D79B5DA0022DB5D61B358838B55EC1FDDAB360
      C8999B7C4AA4AC40E88156935F0BA977D61E7068CF5CC7D3B032A6AAD4582FCB
      5333DA25CAE171D9A2A7F23E336FD5BB4031A04CEBAAD6E65A2D8CC88504333A
      86ED20795CF786AE7CEFBC2222790EE4119B8EFC2CDDF0DCD0BA8B101E34A1D6
      0FDEE81306B6A68C5E63D51253AD042874C6EC0EB3F745E0B296A62328ECD912
      F0D89A0E335CDF5BCA472555489770572DA6833C5AB11EA7F601F3977DC9E3C0
      5C1075AFEAEF2793942D0B298963CA81F0EC9D1C675EAFF2977DED8DACE49611
      AB48066072A28B22CB315462C6E7D770449E08FB01C6C69FB1014708AC945C95
      AC9D4B62A2B7A156336F8D62AD1F4A561271B4F99CAB8CD1886B442191822D08
      4751C5B936BE38CAD4D936D1966FB4169717216CF66D4187F83B268A5DC7D1DF
      879E59080CE363297F508D53CE062432909B3897D9CA7419CF526E7E14BD5F2C
      8E68095C424D7561502CFA01145C936910684E0822F0E105FB515DEEC797FE84
      6F3F7971CCF74C014955DC2ADE85235CE2A4A934C6149DA0E8F4C27016FB69CE
      82C62A42D9890845CBAED4DE773C347438AC03C13D404F844D00EDA6B85ADE4B
      6ABF0087F63BB9E5258ECB93A8CAE2B2CB5A3331786EE2A3FFCBB2344C9180C5
      D1723ACB602C1C566B785D3F58A5A65F83E1997A45421E145473AB540EE2FD3D
      8F9AAA1D0D57473AC29C480A5765E5EEAD27554581D7AE2B526FAEE7F6F75734
      8351FB0989AF44ECC99F458D2819C012CD929C476978173371A27E1644286C50
      A1F566D32E5CCFE1A81416A66FDAD5A89631E992D8FD4095CB8F25925A2812FE
      5291AE17809B043C4196FC893F74540D6853F28A12DD17EAA86AD72D0E9B2176
      1853600AE3C2A393658050C6C633747463530290C86F66283142126D0152A71A
      C8669625EA079A54011BC8EB6BD262539585AE64065CC4B39473DCA3A9477E30
      CC6AA21D557C20373EC14D432D61CBB10D0C21A86C3DA6C27532B4894ACA42C8
      A9BC755799E07406B7083A42BD84C2D9A5F975C09F4D0E124F199441674B152F
      7774D6AEC82E62EB1E1FEF7AE09C12A40015315C41977AB2AA8A18F16927B429
      8288507A2CE4A220E226396858D557500702FC05FAE631A343CC1668A9F1DCFC
      E35AF8A0F2571E1E390CA5F1123C943AFEA72A0447E725264B9F1D2A2A253761
      CB5A467875AC2A98389C3EF24662D5523705E9ECF8317841F648F2E5607969E7
      472F58549D77DED532017E06DBFB839FFEB81C5631B40F597515E92FB0A6D843
      33A43BF576C3F56800555497366738D6F22BC65E5DFAE138BA54305671A87F0E
      B0C82456D321D00DA8AAA7C0CFC9CF3E37EF1B66F905113CE2C2DDE3217DA80D
      F048C1E3CEE0D9B03B80E3F479C3BE4DFCA3660781DB6DDC620361557F8C6845
      809FE9153E7B832D0D92FEC66DC5C7BFC6C622BE3B47A0715009F4197E43F292
      49297B1C1BA5CF244C176DB6E63B1E43336B1067099EA2DA63091E125DA762DB
      F0ACCE67BA9A5DBC0CC950E6268F6BD14C7D60C5248193108732D7C417893D40
      276C0A2C00486AB4A092F99692A0E061DC981CFFC9C1938F6CA942606577798F
      D4B5C48B2F5046FDE0B9C111099723AABD4CD6021213F97E2E398C3A8840042B
      E938AF305D04E3BF7C020456CC7C5C4BDFDF531CE5C87915CCC943159FFCFC2C
      C9701AEB603AFF8D65E84444E1A29720D62E53AAA59724D294C3041F47E134A2
      78CE25D6A1CBA08B42935D1704D86AC8D58FBF11281A5B0145A35B008A46F746
      A06092A3FB2BFFD5E51AAB626236AC5F55915215B1379ACD430D2ECB62CC4AB1
      0E5932FAEFC14BAA0965C613F2CEF61D55C9C72E85ADCC7374C655F7F06ABEE5
      9CB22FE63BCEC9F0E273573D94BFD5497F1CE8ADC58612C36F88E116C4EE84E4
      46507B283C376F2840F5B38911FAD02D84B67760B3915967859A55B48E6BC757
      55F8D3C03FC7C7C7876C58E72755969D32D5B1EF90C4910ADB0BC9D8C97651E9
      29B9B4D88A04AFC8A9A4B0145F6A54AB06015C402E075C5D7C540ADEEFBCE75F
      4945B137F709096C2CD991537DB2D67554372898C18402D2C5116914B0F86858
      2782B28FF8BC5017689F1AA50A6ED3A0E2FDD247FBB7ABDF19AB4D8DE1D49C47
      2A6D2B44847A7264BA5D60D61A59A9623C9F3196478C625DBC2ED748428E8399
      896FC50D2C028CBAA473A1D686E3A9D04B18989C2536E5C23181DACDDD90D5BD
      FCF86AA6520156454A2B09DB349DB724E763E7354BD37CC413CB2B7D216D87B0
      F3249AF6F4D4BC8517EA685A3A5214862672BC769A82964AFE7FF4572E8146AC
      76FDC09F72E20EAC03301175F85DB1BAE1D1595FBC53611E43387CE1BBB912DB
      1BF24B0E2DBB1DFADD66B060E36AC53AAAFC9644152307C2EACF9773792B20E9
      CC0D24464462B4E5A74CA90361507A5CC5C9756B14C945284D80191360BDF64D
      6D80E76A478F0813F6F746820BAA28BACFF6849BEC7C165B85AC6B839CEE5946
      0E70EEF243029694F127D7AC495C65EFF8A3C295D73EB535122B55EAA7814E2B
      ACD8258D0E4DE1E62CD8549CDC5C42F338911A3DC4FF5C2A5110F060483500DC
      79B4BF2709CDB229AA4C3EBD32F1FFE559F50B54F502056E49C811F33B85C0E0
      138F0BA2FB7B08D38F48BE18A89AE4A47AA1C9358BA4E812EEB84634D0187555
      2951D406464008C30CECE8354C9174D44AE60D5C678582CAACD0F0C704B4F339
      46B71C61C0C410F371C4ECABE149093F8CB0C70F0EDA3315229862A30AF5220B
      73A95F9F27C572804C7AA4D1591332A9C12464E61F5DA8A6782925BB6D3E75B8
      9D8B3822A92DE26A0FC92C5E869F9C2472746B3E352CAECE2A5A79DDA4B6813B
      BB2ABEFD88000E2393B7460505E68B14784074B94BB2DCC11740915788BC90CC
      02CFB57D20D3036BADAD4A46E6CBE6D4509876297765E5AECD07E46BC95D4031
      E7DC46160BA484A64A84EA25BBBF07FB4ECDD3B0781106A3038AA84413DD3018
      C5119031D2254586BEF0427F1A9A5F230C27478B1E12AB993F1E7BE1E3626567
      1396067565A73C14340C541825B7659AE149524039AC5A878896CACFF28255CE
      D7A35BB88A193ED70D2E4D91FE1BEEF75BC0701F33A6D170681396CD1BBFE39C
      88D5143231798053CCBDA96C28552CCD706D1DD8BBBB455EB9F384B0A4839759
      90FDA241B6A9FAAB2967A8D2E5872B3220CE136F7490EF56E1BC9436657C6CDB
      B54CFCAC54B762C9915ECBEDADC9641973ED260CB1C38A931BF68FB358D6A7C8
      367F98D62C0A74BE0DC8B8091C9DE5828D94972176BA3DE44E6AB07CDDB891ED
      FAC277794E2A8257EBC5A0BE2DD9C58E4E021D61EFA512538C785853C6485E9D
      693247510C9195629FED7AA65A542BF913DF8E712E3AC983E140B90E04865D17
      424D3799930039A48BFF92710AEE04BC56D5BC762775D03EDB5F8049D179E522
      18F1D2DB206C569D659848082D8E96C8810346C65DE29243EDD1A317DB0649F8
      4AE1293EF71897F660FF43FDCE6EBC2B176B85547555558A315F48BD3F750E88
      7D3674CF8104B862848E0EC94AF74D5DCCE20D379B9A5EF5EB1DF8B7DE6B36E0
      4FA3DBEAC19F66A7D3823FAD76AF067FDAAD3EDED269D5F1966EB381B7F41AAD
      163F8DB700E67469985ABF8F37D5EBFD1ADE556FC07DF8B7D96DD17DAD4EBBF3
      A09844158DEE552DE9C4715EE0FF0B18E1F3A9E39CA82C9E1D394D2CA469B455
      27C06EC689785762DDD6B0CEA01BFEBF7CE3FF69E4737606FFB0D00F5359B29E
      F931A7CC56545D0F63A876BE77B22633425072FB6CB7B26C8589FFE1B60BCA46
      F912C6F747A68AF09FADCF9563E4C50ECF3C153DF5CC15A9BE5186EFEDAA6CF6
      DA94652651FAE36EA959EF43A345A4EEB0CA9592D76DE2B167FAA40D5D49AC93
      1AAD51D6F57A8635763734A7073DE69DE4D23F47686362A61DA721B71927DD27
      EC4A2DFD38D07C2E39AC120085378BF2C1C9A3996873264468E140E5CDE5E479
      D5DA99DC60516437AEE1F5A1314CABE9F47AD2CB40C31BC340550797844DB039
      6F9547C74EDE7219D52D9E2FF536B5AA815A55573E46A296C2D447CBC484B880
      B2C7CD5D9649692DCD594B3707707E2D6B29B67D798734F33F09DD14220BC262
      D1EB47B55D2769F0F75FD44CE9983DDAA9BE0AA59F07D6B0FB4E43F6E83F1495
      804F7A11F0F9970DF5601FC74A4ED978F332BA0CBF631B915A4CC13EE0AA372D
      675719F199AAC6384212CEB491AA5F49B1920CAC6EA0C2FC25D83317E5798B2C
      F9E7C573442EA7825EB743E7B9549A64B4D33F2A2672C89C47380CF99D630905
      4C527765B80E174D116B8B3682D06BB127B87EDB599878717ACD0B861EB54C34
      253B590055236F8EDDB682B79539E8350D197A97140E600D91282C38702AE39C
      0DE8303BF3315640FFD2FCF0A6C5FADA77F5FC49F4548251A46841400F9013B8
      432F48D68EDF8E9CBE8FB30C142A26F25E29B0BE2D3E67BACFF1BCB3456C5508
      0757F3D0112DAA943021EB35D53B624418971B568CACB89BBC0128B48E0CBF2B
      5D2DA49A1332248E054E74B4A66A5B9744C8AD28A7B13C137C265850C77E63D1
      321E711E2456EE94761452FC4A95D29162A107BFBD04D5E17787DA36C2DE2AFB
      EF73B47A6309849DA912482679AB67874BB0D9DFB3A153C980874179A8C18469
      FBB1A9CC922F2386067A1DE39EE9E4EB525D000E74A7862CE202709DD3576FDE
      A8D02BD7F9F5C39B97640E713EBC7AFDC15CC7BB0E55A3080F8BFAB9F12AA387
      524F1BE9EC82EAE31A5A10A9D0F1FDB187CEB524532F4CA70E8F55B424D74C54
      4D8AD9C7976C1ADC6A2AC3B8A9EB6EA3EC898A3ABA22AC042CE5CB5391B598AA
      8109DCFA652AB04E9555C08E41DC45DBA96832E6A3BE2B0DAE0EA5DB79E6F5BB
      4A2AAC62900C9E9D38E0C023239D447230CFC3C0D47F04F694AE9C0AD24F2EEC
      A4BDD95CB25325C3E1D98A232A5175FA8F43AA3A8564C15494CA946F672EE58D
      BFA63AF01891EFE02CFC036820D5734FEC0DD8194EF3051838159DDAA964B67C
      10A3D44A42FB9DBA6543E486F82CF6F7C48687B77119661572FC4E7331DDE581
      06A69EF64C82A9B4FC1F1C76A56EAD7CAF09B1BAA47CCBAE2A9C685A39E951B9
      821B5544031935421E3B1A518F044A6990A92D626FE25F99228F0B1DA1ECE78D
      B5297039AE81EB51E90BCEFE1CE26C6120128191E952C735EE6CC1E2A44B95CF
      E254C5A5F09B0F954CC419698A9767845C8A34C131B9C7054C6AE5A5A6199381
      A530A6B93477C5A833AA7165D8330BE7F0B32E82F72B37A3FB8E2DCCAA182DED
      E1BBF71F1D29C0E786AB6C7B72B138CFA5AC90B13B0B40F99B1F9B4E4F3BDF44
      4149BDA39CD4EB54B8560A7C95067487BB25040368D64170605AB96442AF54B1
      62AA9DE614C2548BC70AA515F6BDB36A33BB690EE3F190A949781CC622C580ED
      80155D4A3183EB220FE6927837AEECC2C5DE23743851B4553915EBAFCB8C2C25
      8E6187A654ED53FA47BB765F620A9E1C110026167190A2734857D54C52957223
      4F5285CEA9AF0AFF8E6691CFCD6B0EFEDB4B54BF17E998FA2ED21772CB152DD0
      8409AF573B56ABDD387F3B55FA0B0B1131BF6281360B2C8ACC95C7D6A771A8B2
      A9AF87B9799F944FCEDAD1984B51F99E3C57AD522F8F8C6A87B87AABE3CF7672
      72CE6575B54C497672B6EDEF599D78232E52ECA789E9B59B58CB923D300F60F9
      3783F7F0BE1C54B870D3CC7473E57112C5D3D55DEB705670E3DCBA5F448A3D15
      2996D5A6AC0C0C439EFE0367C4D2B22B4DBA6DD8EA148CF93290BAC4BBCE5C28
      5C5DA43B6C798107F4D5F99B5DE120DC015611F394EA72E6854D3A675A52FB0F
      E77FBE7EFD9A6B6603359C2FD8586EC4D639A7BC4E40B0354FFDFBF7F4D8B1AE
      A63F01A9395B02378D104D41600AD705DD6CEDF352F6FA6AC7E383278DDDF4F9
      00CABA4312968ED547131B56A253F45DA35D02CF50315BD077B4E5C0B29F5FAF
      3E925C504483BE1DBE633E4ED3328E70FBBF1945E9A0539CF817354AD19A2675
      0774B17A48A29A505B5C9C4511C6A5327B74EF072F048D35A09E80F8D6B947C2
      066EFCFB77276FB57FFA899CB27B052A1EBDF6AF7E42F9060E4538F2B6DE9CF6
      F97643408FDE45D74DF8DED3458AF0F94F58F776418CE121885A5B9EED9681BB
      BF47E07DA0C9DA474D75909DF249C49800CB90A7DBE991AF1509E59C3B314949
      4DEA2E317F75FED69FEC7821A3D32808DCFDBD05DBF9DE5190A2F6EABBC32742
      C0EE2B26E875DB31AF0EF7D9A3DA43BF1DFDEE24ABF9300AC4D5972D0E364228
      2ED88136D7DD62F82229A631B0F605601D6BC49255CC26E524DB87D8B8E84944
      5F2C026C0B4C71AF9CCD076F3789D92490CFDD95D8313C6A973E8DD0CC91CD83
      C4F762942BC87FFB7B73DBB480AF1945C4E587EEE813D56F8E8F9D0ADB602524
      40F551E6B939A403A3864011E36194AACE0056088177E592F7957F504FAA8287
      1481EEA726890B5404CE50E40175330C7215AB6C48E505E2DC4AAA0FA73B861E
      51C750585F981A6BD9D8ABAA080BDE20B513A08EEFEF85EBD0A78808D31638DF
      4CF8952CC3DE1B549740BC7AA5F68D6EC5D6A67A14B438A124E7B961A2F36F30
      EE486CE9E3B5BD525D44F28587724D866D033D37B0534B500BB63A70310662EF
      6BFFC21F63D768DE94FDBD34A11E02D911F8767B000DC4B521D2E49837CA6039
      8C373207C0E5312B5666ABECA514A594AA449CBFEA925B7AED1D1AB23416D70E
      F2285E92C2AAB363A8756880519EA0AF82B835EE48B00BA0CFFE5E55A2B4EDD6
      3D0690FA106383212CEAB71CDA48A8A2C7BCC4477C8AA93FAD0AEDA9B187C42E
      CE445E72F6CC241BB3EEC5F58121575265C00D62C0C515D771B2DFEFACE7D484
      ECB461ABA9E42AE2B475648FD03B00274CF5B03425BD43A71F1B3C1CD6AE5E23
      91F91120BE3B4E7B34DD670171A0699ED23E0D5454EA872987E163BB92AB4CE6
      2DC634736E39E51E0AE79483FB9F443D33758AF0178E82B6A351321B833FBCE5
      A6407F77EA3B8DB7B01BD86B4DED47689540306EEB44A8CA0E61B116E274AE2B
      993FF2087CA9788F713458DEFE4443EE1ACFBF4430EB9E48364FE6820799AA0F
      6CD9E1C67FD127D5A22C332771EF2BB743246C677FCFF1DCD1CC9A20BE8126B8
      3606FEBCDB8A8D953830013995445B893920A6AB630E76A3D6D74BBDF4FD3D7B
      F158DDDB67812CF648D41C91901C23AA89368D4640974B18709E0ADC2DA5C8C9
      B88F411653ECE53535A74DF4A68324C52BBFE917FE4E6653F588CE450D230930
      56BF68BD00469D4A3A5FBD06E80E62A3B8E538341AA7A6E43DD8EF698C6D96AD
      39AB932B152747EE02E45DBCAEDFA08A61A2352F1F654D55B0B85189784854EF
      5B94517388448A98D531330A2FBC38350DA9D03192AC409F986324CB933D9E1B
      2D44436323BAC9E93CC26961ACD0E7FDBD87A20054AB9A082DF691D2B6A39D38
      EEC8020B4D7B00813B5921F59E3D9459CF44A368662D62DEB92EDDA4E236605F
      11B8C01429E40C8FA3EAFCCC3535D12DC9DA5326F28DBDEAC9717A9592F184F4
      BCE493CFFD43F17D3F5054B87923E9FA191115DFC87E56D0A4FCB17E68E7FD8D
      3FC03EBEF1C34FCE73E7F5FB16C698E3B79D387158BDC85AB38ADE40BEF5BA75
      FE4AA94A7E380A9663C368CEC4A4A1823D924C4B4C189053CA6564BBE58744B6
      98E6B672019BCA5573115B262A534260FC35F3119D15B49DE83DBCBEAEE7C14F
      6E3A3BA09C7F9161ADBEC32ABD0059AEE9203EF2F45BC655E4FAAE25736C10B6
      B1E741C481B9BCA8C2B63156D0AD16FC5138062AC26B7095012DC3E0B52F36D3
      788F4B3F6A6F02ED20EE03C695B23376E8994E932CB6E0FC4C582F3561D0BED8
      2DD73021328CEF03D4FEF470A4385F5DEB2CE5641358E68DD603ABFFE68C45D7
      76CF62CB3AAAC3C67DD098480D1905A7A93706E3F40BD02030080DAEBCC1231A
      EF3CB167D79BF223D84673D6BC8C1B63E25FED4C7F8C1327C0204147026F301E
      7123382C4D61EE8E757AD51A347514AAD5117B6A077B9C851C77C5ADDB392F4C
      05114B1C27B6E5B9B4E36096A16EEA3C76CE3EBE4DA417B9C906B77EC754B2E5
      6886FCCB103572BCFA23E009F82E3F991B8A6125E0887304CD2F526212E0219B
      9731436F5A785517484FADCEEEFA2CEFEF697BE1A50A24165365DE5120346C43
      EE2CCC15408A51C954ADD2A4C74AFA849EACB825862BECAB23D6CB9AC95100B5
      13EFA20443160A2FEC3A36D7C24BF31286D40140621963CB9E830D40915550C5
      1DBC3D0194FBE5EDC94BE7A71835D194BC85135EF9C1791A2F47E9012AF40727
      54EA097E5217C96FC95145730F71D5969CA971D28DC6A96261529C7C3CF4D318
      B32D18F3B9EA8DC7E15644B8D09D683230CE52251365C410AC2D80EB3974CE47
      B1BF9013632DCE36A6FD7CE65486C081B12401B999B04069EC4E9F85CF308B5F
      27B6E4E36FCFC249A48DD700E2B1581870879995E348283E5004F17619F80AFE
      77349F1FC14A7F4EBCF83BE70AE633F6AEBE73560F52976CBBB128EFA270DB21
      334EC5E7C355DBF936723F93CC8D626E149FBDA42259813B650AED52F82136D2
      C590F11DE1A6C0DC3EBE3A6F3F3F07154A14A1E7AFDF773BCEAB97671FD511B6
      C2EF91099A5A1555950FA14B902F623F8A25DC7EB4782FC908462BD06E7A0EF3
      50B938CC9B6970640421A91C310892CA6831F4721CD395878F9D1798AA976695
      358E4AD0FBCC760FEA093E34BDDE98298825951C61B159083B2BA84EFF81CEA9
      50AE0375970E413D31BA21C8B4533488A5B1E702755573407BC62556C4554084
      AD3160A4B568755081210F04B28B5258A9791BB73761ED290F057E8A8A48B36A
      17466453C5D24F38BB4C980A1963E120EC3A8920370F47CB8C2489087499E704
      4F8C670674D911DA800546995B1B718D6D80EC232B0092BFCED0FDA2D9F8379F
      0F20FF96F9E2FE9E1560C6828B955E5B41BAC88E448CD83AB4AD23E61C65D275
      4DF4FB977168D78F99489498958575412A08E80FEF512E85EDC0E2206C983306
      AC0AD609A93A27A73F7E60E758D57973F20E6EFBE9870F72F3BB935FDEE2E334
      22364954326C4445B52A8796458ABA3EA0FC7BB823A7F92C1470545575950DAA
      41762F104A700A5A7A4F2C9BA564CAE24368B6348A983810B28D9BD158483D12
      28779143C3A95F09664845A4D5FCDDB9AA3A2BBB2E69269323D535A012CF8DD1
      4D8FFA8495DBCA53C734489F63BE3249BBCC58D906C9C713BDA22A81FD90D087
      0C93EC2CCD8E2A9AF1848C536CF0E24AFAA147F204F252CBE4ACA14BBE8F3C88
      3722ADCAE752C89B55C274891958323ECE2A1B8CE0542862017B71736D2BF2A7
      062B25D464DBEB00E4B9BC4ED5880905C0CCC4AEE673A02DC0514B6BCB1CE1B2
      3505DFF2FFDA7BF7AEB6B16C5FF47FC6E03B68B3EFB821DD84584FDBA9B3F71E
      0448554E918406EA716EA5C7194BD212A8B12DB76543A8BDEBBBDFDF9C732D59
      061B6C1755513A50A388B125793DE69AEFF99BE54C96923206E47D075A0AE3A6
      14C1D53AB979DC0E979D9AF6D9B4A8B9F52C1B67016F304631D2957B82EE9BEB
      90968A50725CD00E4D7DD19252C256717D07AA65795C439559D263DB7A7D0D15
      F5AB4797FEC176AC311E98EA288334A6142859C19696BF123920C7F1BE7308BD
      68205D1B0BDBF486CBF76A6B6990BDAA6328B658BA53E7EE6C59571FF001AFF7
      46205B7B246028161A6B5A5067D0B009C37AC099C1C263C560E118119F6D39D5
      7C88C5E75BE761F1E4DC28AE33D6553566B6B0A6DC66BA20E9E6462E49287D8B
      C93DFDD0721A71E4D6EE17F9C3DCB7CA7AB3F00E64F3C94298B6E4768D88C172
      EAD4B5892E3208AB69F0B3334D0DB7A2693A7FBED0262CF39CE906924AF40901
      728F0431C648A75BC4FED57B82F6AC9B7BDADD8AFCA9737A464109A26C2D9BD9
      5EB25B76429119E3BEF82A18C7D9EDECCCCD8D3AEC269DE86DD69DC8D30F8DA7
      97978486311B1934DC04AB8803C58995E4EAB9BBA2A209185BB3DEEA87F89214
      240C04B2A85E0341F89B557D041F75068A9F49D67C5B0333A4A8B441FB50A528
      74A34ACD11B48CE92848AD31A09E78B2E4B04CCDE2E9130DD6ED4CC4DB96354C
      9BC370FE0D9E40E52F8AAED975B65F4B55305DA266B00F6BF54FD3398A86237C
      D8D413CFE2995C53EBD06155E72330C012C79F0DD160CBF2441BFDE75C73BCBD
      4A6F50738F097D229AB1150994F558172A3C3A9A475F1CAAA41B124F37752C77
      19F14CA6826596B72AC67616E508D7A58A59509BE2C49909F6D1D0DF298B9B84
      196DB7B06C2976A2AE03B55C067BC71209CA4FB51D848340A272CBAED2856449
      CFCB6BF9CA2A1FB9E2C3AE4EDDFBB0E432D9D2A40B86AFD3038B7B631F31A4FE
      87B14E14E950F998B184C9CD5456177272EE05E5F91876283CE37611EF4C6D95
      058335EE7FA856620B4E2D250E607EED3AC4D187836FB125465DFB4A28FA4735
      623C5D99F5BC340BB32C94E7C39599834B4A94D06531F8B7AF9C604E2F389A56
      88201D16B931012846DE27573247D1A18014A3AF43AB24FC5E2E4828A722BC72
      1A1A1647DEC48CCB5D47A3C9901B9FCEAEA0C973D9AE941E7243BD57EF67D487
      2A578DB86D3E9830A5A604302EB1B37AA545ED8B1985FABAB296EE196D952343
      BBE71409E598D88A98D9FDA5D0A8F9730A443ADB138972442E07F4D839D47297
      56EC880BEC614EF836AF498D2B53253142AE891258BE4C71F050627F1019E67E
      FA3E998655A28C6C80222F3A6C7E3EE03A6E55C1D754B93914D0954829B4F931
      B75FA2822DBA261E1597A2EE0D8C62BBEBFC9F622222E7927DA431E9F61C9BBC
      7E52A47E2A465CECCC35A2EF386BC87939C53037EFD06938F96140FB2FE0EA7B
      BD9CB3179CBFFD707AF6B50434DEDC4D28BB95764DEB34ADF0E7542B22E9495C
      F9DB373728C598CEAA5DC9A3D333E73F6AD9AAB2B457257DB47F8A8F0876C254
      2ED43F3BA2CF8E0A13EEE34F9E2F08B494B0AEA0D2590C02D6BCAA519AA66EB5
      484B9D1624576B961AEC1D0BF095E93D432C4FDD25C45AD91B0EC1D124FF8DEB
      E52C4C682D91F42B39447BCE9B5A6BAC5B2993D39E841215A977782FFA711117
      9F8C0BB6DE5F8B45632FEFE3258563F2690AAA798ABD97D3FB078BBB0C3A4CC7
      9029E6705B3C3682629B092ECDF8772B8B5DBE6DC7BA4D6DF0CF0CE20E30CACE
      02EC58555E56F82CB7D27E49F6ABABAAE384B37D6AA5659A9709E886BA6A995B
      A6C9C1CF67C62EA7DFA2D426BDA234C51B7FF098EBA3158CD6627C2B8BC17C6B
      7DE466BD314AEB71E36A32AEA4DEB10922823353269B1B7C3FD7D4D8102E854C
      69BB9F95F81E9D4C6A71537EB43C8A4297F2E555212AF96866DCDDD40C927DE7
      13037E6B23CE6C86181DE5368A2F3DE66B677FC2F7584BFBF2F8DDEF844FC37C
      130DA55C53F05520CBDE66EFF292C8795B69CAFD7AE5BCBD8EE9C53738467209
      FD454CE715B9AA71253E392D4663F9B07CE5BC2E8A1EE9C0FFE19C514FB46F1E
      3F4F895408833E6B5BA542CB8FCDF70EABAAA2BB0DDAF8C56434E0A66F536FAE
      45AC818250413933F4B409D43F6EA47BCEB2977396BB5AD0B3535EE79296F24E
      7AF5EF0C906304126AB3409D76FE545B6046C0F1071EDE2E450CEC62316097B8
      C838D028BD819C4490B49D1A4DCC742FAA18CE1FB4A6AF35849F20EF6D2B8326
      C3CB6A5E3F3A411A10C6C7AD529BCEE77090FE99B3C1F1BA053747128FC4AE09
      975080C426F295A6C7E824E6D6C35C9B71213D9B6BAD162F26E79A4210432DFE
      088EC1D2E52F453E728A129731D916EEB5E4A1FA607AF925C9CBBC5CA2D3CE94
      078F3F75DD08BFDD8EEFE11FAF1D74F08F1F4501FE09C24E0BFF8441972E8902
      972E69FB1E5DD2F18240EEA64BC0E8DBFC9856B74B17B96EB74557B91EAEA37F
      FD76C0D7055118FDA18CFFF7B77BBF521698C0A915BB305DEDDBB662DF982B62
      3A4FD5D52F5FC244A8FEAA9FB5E9739E7F535D30AE12491CBE5932E4B0A5E6EA
      9B4A2906A14D9F50DD93E59C13517BC6F438CCFD423D48ED1FB597FFD2727CCA
      2A203A18ACF990DC58FB173AB984097EF9CD5DD48B3F8DE33DCA247E18F4781A
      CB4C8258ECD2D3B8C5E860A67034C7205E27F4DDC49AC417C281E75BC97F55F0
      7C1AFB36CD398CFD5672ED6359F4AEF8C9E40AA588F275CE250F52BA6781BC6D
      649FC0EEA7B5F0C35A72CAA3E7DBFD548C7AE9E950257AC77946F1DF5F8EFFFE
      6C47F4B63FA43AEC7185E4FC29B83BE11F36895B1443DC4C7142F548B35A59CB
      B87ABE30B7F7BA00F7EDA5250DDA24B8526A05CF84DFFC6336DC680C94B7CF6D
      C0BF0435C88CF9BDA2C2A03F64D49299CCB548D8974B0160E8A9F392E03909EA
      933BD088F38073F866725928DBD640C87ED576F4EBC9B9A9BAFF4224EEE3D7DD
      8FB429978F27E7F53830E70B588463425CC919249CC256D4BB87E40917D4CFBB
      CD3A6E6C3A0E3BB0ED33289FC8C0B354794DFFFD913E224F21AFFFC7610F42C8
      6C82737B096E4D7EB913F911B2F80277FB1FD3985FB43E524A066E773E3E8BDB
      1FC72AFE6DCEE667F90B3FA21D6A7B2B500166F58F84670452855E8E7B97A08B
      5EE9FA738983EEFF33C8E3DFC376E0BC203F5F72C9E97D54F85DE872F06C2C4C
      C6F4CA1EFF759A40D5A80DC404224CE064DAD78B83A2347E932338856EE0482F
      95C19F9BB418D3D1BE69136A6342076AACE64EE74B9944179390CA3B4B4F9C38
      0E137D6CBC71307B92829D5604CF4A500DC3299A0138C60F676F5E741CB2E89D
      17C9F0D5649CE14F0B5AD1B0E9767C4C97665BC52F4C885D8D2E25F82E69E9C6
      C7CE9B58E5C2B25FBF691322B6C03DDB4C37D2C1B971A170D23F34C41E378C48
      C69486B05DB240795E4B63A324B692FB115BBB3995DC902A45C16DDA94C33B24
      3BD28200623288FBC5808AC26DAA6F8F72F84CDEB0240726A05E8A8595F97832
      03A2DA983912B3BCD4377141626F1A16CC07CC47788B68A4E58C1468DA248841
      5667292E7A04523298EE5A36A153454D1F4C2E65D3C6DFA1B365979BA171A4C8
      324FAA96C005E6479D86A71CB1C91BD2AD4F88C684A15F14A3FC57F22DF40CDC
      3341E225E49028ADF7352EC6E3A2DF2F4A8938DF346C5ADD16A645BA0FA584E1
      D8F74DCCCDA9076B522DFC9E7DCCA6C3008C30728F601B632A3D6DDAB488B56F
      51CA0B35EA32088B5B33A07F92FED5A8716F57560B87CB4BC9747E51C5786C34
      88FC1E522E609971928F92499FCA0B124EAFB68054262FD164F619DFD6173167
      89F5BD64EE462FE6AD414FDBAE2557F988FA843B5B53B7CD569580B5B95179F7
      B6ABC440B332A6C1386120A866996DDB52D24DDD46C8B3403C92D6E5480DCE27
      94085A136CA65FC8B592FAE25DD13D4B83370F32D88D4BF57237569E4315D5D4
      F1F84B982A94E3CE5481265750CF1CE8D4B15394625098118A982F0CBC29C61A
      3894BD4A997A4321027A6EE51A69F40A8C34D8ABC568E7CE2F9CB90A85ADA0E2
      2B4A6BBD5D22DCE8F918CF9D295B9B523021B6D3F9C7755CC24BC944DC436A73
      834159B5C84EE91D35962A2C9D5C9AAA35C16A93D46A3078F9A451CBB1B9B168
      41060CF8C4DD086BC968D3CAC197B5AAC19BA101A7AB324BCDE5575541CEAD2E
      A692BF5F096F27D63DAEEDE39A9066B1BB7F8F5A2D76720C0DA357CE003AAE31
      56D470E85C19203F71F2356AF08B845895FC67825845ADC2B392445C0C48257F
      E6A2C9609CF74CC68B4D3963B419762F4E3B8B367BEABFBCF910FCDD79431D51
      41A5DF1E7D784DC7F67A547C21E3BF4FA3E07E5F77A140A4B89D1413DE52D239
      C0BF2C1CA8D9D13924C1E83542158D5A1A70AD058BC3E9909205BE7F3B0ABBCD
      EED45A72E3F31D67EB7D4176C45EAFB735A5FB2AC06313DE6B507EEC95691813
      5FB4187BBCAFB5D5E0E26C062AAA32EB05297CEA32793E5B4849CD43B6A9969F
      1415C6F27D4E81CDB8A70841FF8B58058ED251D152B5B5980FA7F67F11BAE6BE
      F56AC1A41F2793B1893F4AFDB5145CD9AE6792306CFA4B58388D1B93C33C7836
      FE12A67B02EA2CFACEDE8FB372E6BA9641DDAC692CA0BAB30FFB53057996B3E0
      C29FF241BB51D358CC5185D040805B6FA0EE30A3348E96EB3C1D5F70C1EA141C
      6DB6D358E564873639D2CA00D6C87D5CCF47CF69D8295CB00CDFBD3D7B77583A
      DB46381EC300CA3FE15DC63FA5725D4792589D4371B83F67E5E2E48763A7A762
      DDABDC022655B2C00AF5BF8C99DFE9025A51B3C115AB611159809F7DA1909F2A
      0AF92266FA9AB0CBF1D67754336ADA4796CEBE1A5A2F3D2B89ECEE7E09DA2D26
      A6559F48D864528E0B6E62DC6F9A1763C17C6D517A5E9613418C713E1D4CFA43
      99D56832189816B24A2A49B8E2C81CF30A4A57DC5E5FC47C293EC6E551E27749
      D84B9CD1C67E302E643ADDA62699AC3A2A8FA14E95D21E8DC31C029DF7454C77
      369A669297181A8C7C8ACE5061BFA7F179EA7C4D3030BDDE142743EAA08B5EDA
      B40D5EA02AD55B6F7FF89E2AD4C753DC903B4DBB78B32B6666D627D655C36986
      7A545C84C6A52E8F8E5A7F4831F947CFCB6FFE3E5DC71FB20CA788D22C2029CA
      7D5CC5162844A460B28CB884801D666C88D9266ACCA338FC73C344FC25CC7632
      9072478179A689C2EA663E2208082C53F24175DD452E76BC709D524A15CF2723
      DB6FD2BB90471901D5342B6CFE22D49219B484EEB7FF835E1BD406DB69136A13
      B65AB0762AF0F65457BD91F0A120F17C190256E09A77B8C6895F90E9BD4FD567
      82FDF56E366424D9E5C49B6BD1B1EDE31E6BCE7218EA1D052599FCA69848F166
      0D05CE86A2F8B8F8BBFE6EF46FFFF66FCDF2AADEE7C2E142D7F7FA9A8DA839DA
      263BB16A924BF87BED3EF25C188F3E3D82D3457436662F7EBDE190AD93DD3A28
      4844F273A5C98CB83A0DA2DA962C3E155F4F1DFC73BE96050AB5CDA38EAFAA2F
      59978D5AF5456B7E7A7A58290B55105256D7B099F9DD6ADC193719931B2D82BD
      3608BE88D9EFFD682167A61076D676FF22262076B6930867E1FCDF03754DE1D8
      51BAABCBBE49C5299D40C274157036D9AD62BDFC734249A8FC84464D79319FB8
      287A1566A5C911E10C984B6D924D253E5F433B21F24CC6A39E4D29B91DA42236
      3CCD509801946AC6622C346C6CFDBFB450C004F2614FBA9954C043167E40AC02
      4E5078FCA6898C14C08D1A289047DFFFD875189239002D9DEC18B3812C329B68
      A62CD8AE291E31675FD9BCA55BD498CFD825A0CBFC572A0E6BD40C17868FF771
      CC9CBF8A4546B3E780C27782DC3847C8F0ECAC0B899D8233908EC615CC0840A6
      63325F4A4F97D56D6090AAB6FB9B1B33FBFF438552D42FC8DA01B7D25C0B9F4C
      3BC6DE467D31D45107E1B965C072171681FBBDE692A3194497462DCD62A6CEBC
      EB85C9BFA85A2A54F9047380646B78DFD3DB18298DB2330C15553ADF7459EC93
      ABF5B330CBB533D8A8455B988F26081444187510989DB9DCC464585445A4D325
      5335382D9308C0003D4DB32F1F1281333966F55698152C7D95BCCC757A19A794
      7F1173AC47C4762A9AAE1B7E66E30C44AE54B070D87F5CE167531D995980464D
      FADF23D7A568AD805871951B11286B72D06187E2B39D8219093878D3A6E0994A
      14CBA23947794C2191C3536A8933E4FA6EC9FAA51D2B387B669473CCB6519359
      98393452E58514A3A824D9DC30BE51C5C9F3A67DAD58EA9C0E2914B9237E3DD6
      1370A596BCB1A1225797A086C49A7575836E257DD80994AB421735A547D652A3
      835C7D8FB279C45330F7B1296D5232E02F6269B77E39D07AF8F72A7365DB7682
      FC1FF22E4895DDF3AD7B92AC373724CD9A725C7A457129110FEB0DE2F08DED05
      50EF16CF582C54A66A9A3CD590F119CA8094BA06161F462EE5D21F9B58AA31EF
      8A540F895EC62335E8D507FD67175CB71EA5E03AE8DC36C5AA92EBA02325D797
      7A4446BF1F3DB4A8C6533590EE1C6207FABBDEAEF75F8DDAD7CF5F151C7CD6AA
      E01F8C8A66B34A096CAB48C9DDC6B1D94FA787567EEC366ADF64DC55A38BB383
      BD696BA2260E3429208524C99B86697BDABFF9E0EF386FDEFF2876456DB51B35
      0783168FC3BBDB6AD4C03E458163201E1A342AE92501A9C94AC8951AE5D28F81
      156A1AB2C1E56FD4A0A790934D1C1DA924B6D8FA1106E62D37301E06B929AB81
      F15033CF291E141E6E10AC2F3DF8E665C547DEBB5A00B8C28FF933A4C85E9AD6
      DAF0702099B37F138BDBF618C2E39136ED0DF9720F4F8F2BBBC8B48CD2C9C5C0
      F4C032804A1CE88425D52CC9F7B56B2C5251F12D5554908DFEF6FD9B0FD2EBAB
      51BB8455A40EF3D326A803E9192F5908EC1F73F6F7B980BA51E3A6314D1B6C1B
      2F65730EEF13C7354FA3240F2220CBC424C2232A0667BC1C1CEDEF381FB8DE82
      9C41B54F0E4FDF35CCCDFAD5B334EA63FF92F99AB5C78E0F4FBE6FD41E81EDFA
      2F61A9FC5DBA610B6768D4080F072541752A0B7B28E56654CC427EA9B2D26F9B
      69270AB41A0EE9887C6CD78A9DEFFA5C9209C8542CD2D4340F6AD6C00F0C4069
      7A3350FD3C81CE27F99559AE7BA9ED41664A6A2CC6F2E68672FA7A44556E4335
      4E2E769D9FC89F466930E317B9E9A0A77A52B631F3B83C737ED5A3826B40D8CB
      4BF85125E1A614A2CAF5C48DC8E8CD044857256418D7A3F95AF1DBEE9A4EF0DC
      9E980237E4B0A428664E593974A934A8861E687BA929EE4FC5632AA9DFB9EE65
      2601C45C4D08E4C540374B697C7DBA87E73A57ADDDB051E322BBEE7101455F94
      786371220866BF5E2AC8B002F0E7DD1E2A49FEB64012920879A99D381F50356C
      9E52535598132687C4D6AC709A37A79050B8406EDE1508B80B451DF8A45840F5
      92498F0581244CBD3B08250A72F6A62084C75E1E8FEAB0F54FEEE605EE66F7C9
      DD3CABE9849F55D3D9DCF8E5F4F450549D7D960694E4D99BC44E39195298CAD9
      266DD568B5CF7748F211E65ACD26215968B55E6CF5E3728FBFEC2649F2476491
      358A0AA16F862FB10F7F77B6BED5030AB771E9C987F81F3A19975BB63BA83431
      69D6C82B2DD48C716FDCA3AAFB61F3143A83FCF021A8F55A6DD4004F2F6F4679
      DFF9F1C4A12CDCD479430589937140EF98D3F80A7AD2C01426918DF2E30931D6
      5DFD8951E331B7E91B3BF48E89A84B74F405D4A5F06A44EFBFC88A00AF2A19DA
      AC9DDADC9066661034AF48C1ECBC48A1664365BCD09F54AA93BC0F316E4A710D
      B472CE787D57792AA9F95BAFC9B763906969458A1161F51BB8FD2D515E77246F
      CC3CC8B6C29A26F8335A66A31686F3E36690232B9F693E480BE9D85AE6FDBC87
      51519BB81DE387E05C49D3DED0143B72CA18B756AC9E570C7ACD826BDA3AD1A5
      60D64E1298907AEBEE744C6AA0BCCFF96E4335D01676BF2F6DAA6AC68A1A346C
      8AB6C0DABAEBE7CFB16AAE993AAF6F38A5EF5A721EAF202D7A553A63E5F33771
      58D66E09A0A95173DEDCA0342E679B38D8FF40EC3D7FA786EF08AD7754EE8E3F
      4903BBE9877F9BE8727C462053FC21F6904A32B93B29E54F3108ACD4AA9AA6C6
      920A22F5D8DC2B11C6636FC23947A48ECA558D5A10D3542EAD3098C8599D374F
      845E9992F178722E615EDE2AE2287D9386D5ACF10E6A514A668D95CF69EFF82D
      9B8853A0F57F94C560C719E41998669FBC3DB9EAE165AF48C5627CB2ECEEB7EC
      9EECBA59BB2EFABC1E6CB6268C46794A08C790128726E3C528938DDA3033E0D3
      C3A66AE7C67C109DDC091AB988F7C8110168A4A2B6AA6555A386FE058B9627C9
      70AF647077FD27D9302B1BDA4FB2E15F8DF54A8B14EB34259F28E5A0973D35E6
      609C2D4B12474CD5522529FA7DE2733DCE4DB1DE98464D6CEBD434285ADAF86E
      D4F01F36AD9EF8F622BEFDA4D3DFE2DB9DCFCAB7BF60ED8E136AAA18419D4B9E
      F78A6BEE9FA029D8DAAC4157B18D379C0B52615BCA420B4C9E56EC58C2CC9A38
      85CD0DB3F2F4DBACBEBA2AF2B474CE25D0C4D574230D7D9BA6403B924EA8473B
      85A08C679CD0FEC5CD5EEEB07E0E2661B40793F141A887E44D61D870AED36768
      3DE9A033C5E82127DD13D37D80E93E05C86F31DDEEE7CE6E364C608F0B268F5F
      1FEE35116FE24B712173B34102CF2556A3FBC3F18D8387A89B668DF293E19534
      50CBE25F9FEE35B34D8D1D2C48C05080C13EA2DA414DE5DA8ACA82A568B8074D
      A14CD45013BF6FD43470C8AC8482328363277F3D098C070446EB4960CC080C6F
      FED6FD5902A31C528D7D731D9792D76C5A35F5B4BA6CE2F06C57357030AA27E2
      C4B283B77B470D1C6AD62BD4D8869E470487D534E34BA5578A3307DE15291766
      954EA615E553346A98D458F9FFA54E96CCFFB74CD12E27D9DE866DDA9A312173
      2CF9559E12062263DE346A56041B6E728819A887BD8153CCF1468D751AD3686E
      59C6748C0EF17B93E1469E6B8A181AFFAA5CF06A6BACCBF1EE5011BD18ABB432
      DB298B8EE14F28D124F81FCE3681CEF13FD0429E4BE93525D1356AEAA6E55859
      1649CEA50FB6DA81E6FCD869B7942B88959B037AFEFBC4E3CE1F31D28047FAE8
      E37C5CBCF7BFEC6685FFF803656EF9D86B9A0DAE68A49B1B8F3C56EA4936281B
      C754389B1DD2D1F9303A5783FC57D849DBEE0EBBB3BCE7E4C6CAA40BCE18BABA
      E978227548F3A2378F0EABFAA25F9821BCFA5FE60571AFFFFC57EE1D90493B9D
      472E45629863C2C12354FD5E9E8C6F1D462CC1EF26712369B0518980A3356A5D
      078F5FDFF5E1D51F59DCC509CAD27006E6F970323650BFACF991E8363E03EBCE
      26CCFCFE2421A707519054AC50D356EA40FAC853DFC2DC77773F7E04E7A818C7
      C78FD043CA8F1F37376C2547EA1CE4D4017B8C916EFD2B9FD9A9AB54945BE8E3
      17796ACC38EA4B2905742A1917B67CB461E3A7B14B3300729651AB470A7E301A
      F1D9C9E1A109DF631FAB3848D5274753F74C5D95C0361077F04E246887267027
      A6FFE23F0D4A015E54C5484DF3159AB9FCA4D5B018BCDC1BF58BD1CBBD7E7F32
      30492C4372DA96175A8F1B466232EED71F0ECE5EE297279D902BE45D768E57C8
      6F52FD653AA45CB39691523B6962685680118068D19B34AF2E4C26FAD646250E
      3EBCFEDF0E0CE0B4D7348968467A32073B37D584553A0518AF57523CF9A3E7FB
      A35BBBFE53DAC82D87F47C689A3FAFC4573AFC45DD57EC32E9434B4A043EC1C8
      E65B900E5C569391C7CDA0A75314DF517DBA8A2EAFB779AF00C59AC56765C66E
      80299B24861C02FD9374B217445C01BB35E7FD03A15781AF36AC29A79946E4BD
      AAF5A6191563D173D5E0BC47A261D49FA2206FD75462DBD1BB98D689916EDAAC
      4E5017C5F852DF94F55AC66941A2A96ADC7E5CB55D1AEF3DBA6FE385F46A1BF5
      77285B66A81EDB2BF3D747B71DCC4A1384CA63BBE55E3CB697CB0C75500CF492
      635DC1C3F297C71E6D3EC0791B37EBA46D6E50CF24E7F422CFC60698875B944D
      DB0291AD7D990F1994BE609C757300711D8C806D523C61DE8CA8D7F824317573
      722B5495929AA5423C501EB00010E9F2724CE11C28E3CD5A8A3B0B91D8DEA11F
      BEBF971331EED3407A2BF15A0D8D08AD9A7D577C5A40A2089DA842106ED41AE8
      4F5414AB178EDCAE018336A92B95F76CE8AA89E00E32266EB8603AD691B7F61C
      A2DD4466B147A2D473A62C18B4F11695CE36A52A720723D6E39A45A9D449E9AF
      FB84A095D32406BD1BE73DC5B9685CDC33A8970FE342518F85C332E1365F928F
      29AD93846C1B35A37AD6B2C122B307851C2946FD4C27D07432D52B2D64E795B4
      BC1C54F9CDE2D76B5E973653782E2148CDC5C30265B1030AEB17CE3369E234FF
      320A563E6BD47416C4846BE5D4E52BF2C308B025236DD8F8EC3613EF4FCF779C
      9F8A110C8B2115EABF1E15D725C557F67AE3BFBEF19B75DAAADD18920F065602
      B526298ACBBE1A5D1A466F32105E718FB3BFBABBBBA17551ABEAD21D8726673F
      3B2F9C5825978D9A682D45905A315700683F9D1C1D10964A611DB883E27AC779
      560C9ED53864A3667237BF7D3BD66365BD683B84E256993F6C4F35CC003213B0
      19098A7C99845D02693600A7877C924E2D658FE010250D1F476A287D810D07BD
      2926A30AE920CF0C6C6213E77952A5276F6EDC9603DB3F9D7D77B2C3BEC21D46
      35DD118FE8500D6F469392A974C7F9568F0FA969D081B44A366D1CB024550AF4
      7B75F58E6B319C6DEA717AC932E51FC5E03A6D376BEFABF20CC92DE7C96EDBD9
      9AED7C4E83A7E883B4A438FAF1E85B67FBBC57C4AAC71FE18DF7BBCED9856698
      F467D44BC9D158130142DAFF9E42156342E7342953A65AC3B4CDBBB146AB24C3
      301C066EAB556A3463A5689D02BB4E3F9F7C7B80E9C4D62B5B3827876F40380C
      3D2E5A5E03E170293C46E1A57A43BAE3A303AF3613ACFCF1DEFEF738F2EC10A1
      5CA4864D812264AF8FCF0EAA7E8945958A1717E90DB7012BABFE82B8F2BD3368
      1C2DF12C4E342EE580E4FEE1D1119F07967ED2609E1A799316CDFEFFAC918881
      A7C14B03536DA2AE3CFCBA40FFF0E6F4AC5608E26CB302FDEC34E758B8D1649E
      1961CF623FCB9E3FC5371E8A6F3C5568DD8A6F789F35BEA1CBA1C1F4356D4228
      9B8B9A0D4A1F3B5DF61BB55DC6A7EF47AFA8E5443956D42219EA69D633F87D50
      62CE47BA2C39AF3911B73ED9BABD82F475DB8CAF5946AF9D54FB95E92B28955D
      95648348A0361B6342982525B774DE9EBDA3EA83D434749EA9AD1D686E6C6AFA
      D9376AA292F34FC91FCC4B3B94D53D62615DFE734291FA78840DD5E3BB133671
      A8F35CDAD2B3E382EEB3C0378C6357428BDDD5BBCE2FFFCF713E3E1D17C3BF37
      6AF66CF31EC4BDAAB1F70C08A704D7A46367C918854931E9A5D3F6CB37ACFAB0
      8E59982E008253D8AC13CA6A6485A8682A51B843CCF5D43036F0A034815400F7
      9B656E51B5A27045A24ACB12A975AE4AC6047027BDD4D9852FAE5E56D44A9B57
      178AB93194B6AED31BD8356C7B0FB3C3AE51D35EE0AEDA717E78CBB1EA51D1BB
      E5BBDA2B4B3AAE7D3500D98E76ECDFB1F55331CD37CD5165CC46E1B53FEFFF7F
      27CEB61ED830FEAF14A1A8BCF9FFF57CD6C02053A9B973397EF7F6B489E5D595
      97A6CF1E86222E0B4E0FA4A2935E4DCEBD72DE7D3878BD83DFA7073BCE9B6FBF
      DDE3DFA7F4FBECB48953B23DE18FF661ABD58D05CA93D6694D52FD70FAFDB1D1
      AA1A791A2ADE6C52B03990807DBAA2C6E1B9A2C0084FCA81C4221640FCAE9113
      1125A38632621BA8B073A0B9A7E3D981980ACF4CBB9C0BCDC9A53551F9EC85E7
      06EDA0E3474167B7453FCF48B24AFBEFAA233519E426D7561E441E2C28CB3FEF
      1FFD343D6B0D8BA7DEF2E36E9135FEF1A340F83B31D585965B3675EAB6FBF68B
      F0DCD6FB03595FABE481D1616A5ED757E332B4FCADA6D5D5D91CC88DD1281A57
      386A862FBCE0F8DB93939A18C7AFD1645861C0ABF1C5F988307D04135C5D35CD
      6A9A99CB1CBEF6EEDBC3374C45A49CC8C1FFF9E8C37EFDAC3775365B3F485761
      1B41FBF9F4F0600B6C6BD438D3755A9E21239760D8EC46BC3FDEFFBF3BCEDD10
      FD535FA307BD824F301CB7BC82FE67CE7A36784DB0555FBEC766BCD3DC2884EC
      5713839C0C40E1BBCE0FA56D050E0584F510DEDD42BA4898BC438A0528CA841E
      E5B5E3D08CAD3ED5044BC4331BE97F4EF211E17B488E33D7DBA65C3602969436
      6BDCB2410A4B4C51DC45D5B4B40784519BDD54C556CFC81CC925819B8338B48F
      8D9A1A3B0DF66AF443E94DE0175A1264242DAB5943DEFADF93FE90615E8B4AB3
      10E1FBACB469F2C3623819729958B3C67E382007DC4BE388E32A07684192ED6F
      B2159B35E0A3E25CC897826E577A743DCA31A601451DFD77AF9B35D6CD8D5F3E
      1D80360881790CEB5A7F4AB4ED2134224713457FC970BB181593F30B70577AE3
      D8463170062E1499E09C345B8E557FC85D3EFB6C1BC69A328AB3498FDB8192EF
      DCC1C990BA4A56509AB516B67E0F975E96565ED42049A4568630EDC8BF308588
      DF758E8DC187FF61C353E6268706D8FBDDBC39DE0E2D9FDC459CB5393BA60117
      21359DBD935222F2A6DE18BC9BE77FA6EAF83B94C5DFA96E9C5A9FF3AB46EDE5
      E7D7023F6F23EFF7F50640A46E34EBA8BD5F905CBB3DED5835D2E713EAE6A63F
      51D72B864E79DEBC49D4A32BDB67472A86D693926DB4E39CED53C2F61106FABA
      F8D4B0A19F1AD23089032A21C80E8832F640D8CA34890071B5C85FDF30E72665
      4E8C04B04328AE1A7F1B014029DE0D9BE4898959943783B1FAE45CE020F6E830
      923134AA52D08D6AFA75706BC2F32E9F38F52CA7FEBC8D887F54B0ACB95346FE
      2B958E8D4DE115B93A19FBAF5987EAC3844BA1C5AFDFFCE1BE155F9FEB853BF8
      15D1AF2EFDEA38DBF4EB5A95CE16E56570023ACD69EB2BD1DBDEE565F2C40866
      19C1E7ED5CB74FE56DFD22CDB39CCAA218EBA43F54E33CCE7B392C2B96CD7181
      5F071AE3CF9D9F0FD9DAFAF9D0B7803C9B1BDCF7B42C2623AA22A32C98661D47
      F17C518FE2F734D0CA6A2C0B673228C59C165474564D0CC8C2B40FAEF15D366C
      56AF6FC67A8F46EDF4F4E01C1B042D7644562F0775A3C089F371F91449782892
      E0759F2209B30CE9F3B64BE30DC2119C36188F6FC0A0F2BE1A60BA8445C0B829
      1FB35E4A3AF47F7FFC0BBDA4A407E7D1C105BFFB3FC78727476FDF7FEF6C5D8C
      C7C3F2D5CB97D54876537D95AB0195F4EF8265BEC4BF2FCF7419D2A05EBCC504
      CA1741D4EE7AED4E37DA727EA371F7D251D91BAFBA5E93DEC724F31E0EC0FCAE
      11FE06BA2BA14909E1D12BDA73FD0904CABEE89B76ABF3312B8AB17999C0F4FC
      442FF4201D5CE891E6BBE9160A8D13B5F2D384D692DEC7321B0FE27F3C7AD0A9
      41E7D6A66D50127C3E20701B65EB3C529D1444C8DB2726CB75EFE4DDDE8EF3FE
      C7D3B794BA76E0ED5059D9878619B266428757D872D3504FAAFB9D73CAD824B7
      F1DB0389675354A897FF4A5748726B1327F266513A04D7015AB79540CD56E0E8
      8D9A8849FB6F05CE2BCC86928D0BAA03A71243A82D5498C1680B65DFD9A617E7
      1745397ECE51832A16D0344BC9A265753A98D3816040B29B8414CBAAC521B6AA
      37E943DBCCC7841E02FD0CC326007A698B585639E1CE763AE138B2722E94D42A
      8E340409E31BC493F3E754BA89EB73C28C240B4CCC2FC11E5694A9D1ACE5313B
      EE76B13AB6F4FA82431A2A4D8958B16265E9FC7C747254A5D01BC47542C491F0
      BA440668E645A9E55A06C88700807C1D71EDCEE6C6203F1FD832559BB8F5F6EC
      5D33D7A385F56047670D96820B0618AEA2347D0AC0ADF2D4144D94BBCE5EAF2C
      7658BFD8BA7DEF96530A62ADB081664DFA432DFC67708EC9694ADBCC25C51034
      634AA5671A96DC89588309935EDCAC9998B3EE4DA9795F0DA15456786A26556A
      20802B5CE0A34DCB3CCA2ADCDCA0D29E3427E38DB4186CEA81361E7DBE9B01F5
      98B829FA5712F839619910697C1D0E96A7C0D802A3E6F3F612AD473E2826CD72
      BBD239D8C74298D5292DD25095D0A69C2D4236DE722EF50DE454C3A436C5A06A
      D83416ADAA79839CE1EA7FAA33E429DAD2A8E3FF79BB5AEE934B75C48AE975DE
      EBB1A4B67948DA21DDFD13E6C44169A8F524C94772613EA6AADD2BF2B112A27B
      8141DE983AC3585FE48386F105A39E7921A967162AC6149A08AE3697556BD38A
      B25983B7A688EBB9AC5D1A385753735B64CE09942A8A3909E63C831CB151012D
      E4A4828BADF0FDD8EEEFA91B71C74AC62BA966A28DF3C7C5005AF97BC6BBE627
      4F41677FDE3F3AB14AF8ECC29992B8662D9D5DB8D6CBCD0DD725536EBA2044EB
      B62844D01FABBC5FC99AADAF5EAF282E2743279DB0B781B3805343455CE04D45
      CC0C0639198C742F6F9ED0B1064A1B6BF05A7A169880FF0FB6C501D958072675
      B29A794950748D9C0929EB6281385B06CA44DC585BD8BF9ED5021A6A6AB82E9D
      E5BD1FEBA53A4E39D9DC9802257045364E1E5B1E1205DA754EC599455B655A37
      AA9E4D7DE603496777DA70DBD0AB665719E44FD94CAA6CD1C9FC91DD79847E61
      964358139953F4D7E1E93BAECEDA755EABE4F29CDD2353F4F25EDECF0DC00277
      7DC1BF1594845904CE046EE6F4DB2C96C4E9A79C7F4E7439B64CD63075BDB9F1
      693C528288610E6E3652E75478273547E0E5B1B6ED6FC087EF279506E6D45662
      AE1561390ED91D3A5389616A19082544800AF88890BB77A0AEFA0CF4B60B2513
      87E0078A8A92779BDC4835870459393ACB2847E30AA7A33A26E4701337859435
      376B61ECB290F2F2C12867B42A4227A082CD8D7329C0C48AFD8DDFDC3375CE94
      7F6BBD8CD37CED5DE7408E04399A772C75E45C4D41280FF9AF3A9D2E8EC1CF11
      7F07D5B8357375C8F3F6639163A26737436D2048A11F91077638D450A2779D77
      32D3524EC6CC19F8D736BDBE1FD031E1093F1960330698FF79BB444F757B1FF4
      FB03C778EEF88F4510523E88E1813BF6505A4939A096B804EE420E36564FF729
      19351313A132ED625B690EF14090986389375450D93C1402976E58C4CF9E7156
      F94C3B24A31F998C19C1AC31F8000A82FF9C9A2419CCEF945B79D959D2EAF0E5
      BB36649116BAE4F5A184A12B5DEB76629E6C138A8CDCE1BFB078E2CB2DC818C6
      3A9A94BFAF83A13CE5CBDDE5249FB7BD8FB52B484BD8221519E6AAD0EB96049F
      E2E213184572518CC4F28F8B31218F13AA25D844B30EBCBA2A72C29210C59D00
      C212829BA030B9D562C0C00A876BA9521D4FCEC925F2A7E6AA7EA149659DA7A4
      B2D953FB79412B37377E223936A6D8BF6DF827E22427AF2AB50B95F60E1AA60B
      D59BE0B832C8B76DCB21BAC1B4530B3748C55C7202407AAF3F4DD82A381D6BD5
      6733A7BC280C4C265400E971A9CA4B47C584D3CBC330B20E4C61D26F242CD2B1
      01C6DE96FC188B0DF2BC422026754802597D88296B498BE643F3B335550730A0
      8B415C8C06CEC1D17E13A7BA45880546E571DE1E6CCDCB12320EA3460DFF8C86
      6DA2DE55FDF8DC00384FC5A20A366A0E7B26D19C8E9FB8C66B9D71F0A6F1BFFF
      2FA7D36A35ABC32B870834FB71ABFEA049D163536290DAF60D3677092C9473B4
      1BD9CF6773636B16A6BA822530DD4F939C340051ED4D6B8EA3BDF707D23780A7
      8B176F2B0ADC967647B37D8E9EEF3A1F06B5C616066B42BAAC7E92F245E9D392
      FFDAE4E6475597D5B9C897A40B70E71913747ED2951ED295DA4FBAD2ACAEF479
      A17C8C4CFCC1C4ECD25CF50A0A9AC4D48ED7342B63503A77B7D3A88D3B922C64
      FD32D52621593B9371D671CAF1E606696DE48A18A941D99B66669BBCD11DA9D3
      BD6106D6EF0B880FD813E5EA9C8E47D2736F64D376081FC7B86FC705D5601BC8
      C546AD86812902BB1509FAB272D55223BD927AC5A7D0096C77D92736F5109B8A
      9ED8D42C9BFABC5813B5DEEE74922180591D4B9DEDF1A898C49422C3BECB0375
      3D389F101A972E9B6968BDA940EE092F7A6FFFD024044A61629C0F1901996D13
      E3507DCBD629E8BC2ADC1C51B3B7DB316D410D37F62E5493AAAA61CE4325EB7E
      1AFB1353B78980397B26238451E1315A7A514B466450090E48D7E016A091DED6
      CB9E3AAF3CC8F1C2278E37CBF13E2F66836117303FA8A700672350EFA1B7C707
      A7B65F82F08C46EDDA4CCBB583436A9164F228F68EF6BF932EC75B075A8AADF9
      DC92C71CEC7BAB91CC9AE54D0DE1BF64F8BB91E67E2206CA06D7787494A4CC0F
      BF3F08DA2EB176CBA3C9DD5170992085C6A04A3B5232D8C439D7382E97327254
      DF74AFAC2646FBC83C96E9525DD9C590D935745A245F0904AFB62BEF0477FB98
      4D9C6DDB8100D36596183CE7E8277706B6092F842F3998BA08B905E6E0B6FDDF
      909933BC9C35EDFA79C991F06923BF660D56809F17D66D9E1E1F1E35119EFF98
      0B385EC40CC530F5119537D0ADA413E496342596AA902DA962DCE6E861ADF577
      5D59A1063ED44A615C348B296E99DA349943B386B6077E75F3AB768E8A73191E
      7917472318BBBD9B6977CE4718B3B7DC9879840A575763E659649E533CA8DEB8
      41B0BE7EC3372FABE0E4BDABDEFC083B3FE64F2996BABC19E5FDAA0D6DAF788C
      80C5236DD287B8975F91F3E86432A0447439C2C7A382627DD434EE7C79848A05
      0B85C9AE8D50F1EAE5CBEBEBEBDD010524611B968CFB509831BFA4775E066E27
      F2FF04408A5586F3DB6FBF61D64FF8134FD6D1EFD98C77129431CDC729D1AC2C
      9C2223A067EE19413280553CD2D9B63E902F778B547911BFAFA97087A2552F47
      5AE1E131156255CA2006B4E39CEA7F32EEC28E635CCDEC47DE71F438D96D965C
      7E33E91172F490948D4B2A11173FD1C8B14E3236BFCE9E5C200FB940822717C8
      EC21FFBC68755507776BC25032AE030380DA5F81D87BDC64918C0493B8B33BFE
      C4693ED2209561C20BD8E7A7A78CD1C3E6BB55B81BB5D1B3983557547EC219B2
      B5564A20D4BFFD707AD6C461738B6FE925C6079E701D26437611C49AC02AAA84
      891A98671327B2C7BE9D7EC1E9DF3D7DAE921BE7E4FDDE3BE32E270FC83786B6
      4CA1BEF9443AFB90EB07BFDFD1EF9F0EF78E77D8E705B1F2F6B491795016BB78
      FEE82B2F09CF70D64F3219942AD3E2D51ADE4C8BC2ACFDCA903CC45EE55C364B
      5A52ABA6BF3BEF8BAAFB6C9139076FF78E4C73FAC68D559A04086FB8DB628D1B
      D3A8F3B4E8F5080C080F7092912A29AB97BAB9985446DBEEB9D2970E8EF69B35
      53AAD473B6A6A5F35BA6B90BC1945219B151E44C871A763B66458F24419E99E4
      4ED20149CD6B166FAFF287A8EC1B92F4662ABAB07D9FA2C0B88A9AB51DDF616D
      9DFDB39323562859C68A82692A07094796482F9BAA9E4FEAE543EAA5FFA45ECE
      AA979F177BD488C177F5D69B16BB80685B3C53753F2236921B7596AF9E3C89B7
      36B2019EC4236207A2CF943BCE5BE2A9B0E2871A92B139BB85C1BD9A1DDB8EF3
      1D35F03D56A3315EBF51C963E5C03ED2884F54A25F39DFA97C84E11DDEE8062E
      EABE6078EB5183C674A225F1B04143A2D440879AC534684CDF5B43AA18BC72F6
      46FD6204F343AB2179DAF6FAFD62878EF393D86C90D8345E19324B5EB229F513
      7B60F488521A483DFCE1E044F470A991A6DE3FB6672FC46759AA73D11D052107
      FC5A5DBD13A08946EDF32DDFD31DD3ABDC7D52029AA7046C6EBC3E3E38E3A62B
      36A5F206F46753C45371AC89A1CC75790C8C0B036C3016A2CC33AE60193B3D45
      99A450F69CED69B2953C8DCD1F7AD06378361E4FB180D131CEB9673C8388D5C7
      4CEF63B2A9FEF4C7FBE51E6942E4EE7494C15C9985459BCE8BA7D4B0319763A6
      9ABB9BC01F346DC8957FA262C38C6231B86437DE417E85518F8B51B37C785FBB
      0CB60103A8E66F7E768617C540F7A5DD3C88CE443FC4F167B2A76AD988CD92B2
      558CA7CA8B2F67F3BE78E414CAE1B3B52D93EB8301F798C94BA75731D8E9D26F
      E4BA297C9B61200C28389E881602664839EF19F5216F5AC7471B54910EB625F5
      F378A1078277CFE0540446891704A0787AF837F18E6E5381000171998ED8D6CD
      2BE0A18A521813DDCC8956FC4772FE382FAE71F8829249B9FFDD9E4D4164DAB3
      199582A571A17AD49A095426957314363920CBFE1DA8EC863CEE4D9CD381EDA5
      C021101312D991A3A5A43D86014C9A39959C446A2244CD9AD6FBA2D6A29CC7BC
      4587E39244F135010CD15F02EA88896C356BF036FEC1B9D4188BD4BB50D961AD
      713C3B941BD9E55E125DDFE43D02301E314FDE37912749CA24005CEECB8D7D10
      C7B8EC13F814A371412DA5CA4DD937DA28EECBEB7CF89EF2B0C7327D73AD2CC0
      0E4345498194E079183829EE8DF2291F5BDCA9F391EAEF08CAC79D2F33562A7D
      971E350E6EF78D0CB756A16F0DE7469EBF53414F33863E2B9133FE82979CE74D
      7BFF7F7BC539676C4C8605836237AC13C7E686E824FD9C10BAA9628FC992C916
      B2F6D9583A149B90A444236DB5DE681AEEABE88CCD4DE95252F5AD110C197A36
      112C3F9ACB1B39271C57F037F0F3E86B769CE164CCD1CE413D1A3A2A8AB18D86
      8A0A683FC4AAEA6432E6A7B1A280876FDBACD65D7CB8E3603B7E94577A9C3C81
      3D3D1CC5F39EA278B3A6D0676EB621F9E3A792E2DF2C0E424D29A608B112F8D7
      A3668D516A3AA065C40C6FC7D042546A48BB36261418C25F2C460D83EF3F81BD
      DB8FC1EF864569FA0E805192AB42533E0FF1BFBE6234E3E6A949D30A70C9AB30
      58DCACF39D5EE4D9F8AF07716FBF972797CD1AF72F7BBDDEDF9D9F46379ABAEB
      5E48C7398A9C1BD4B4EDDF6E9F6C8F4FF6ED1105CB0D6973E32FBBBA1CEEF2D7
      DC79F4EF631ACF89CA8DA6282633371D6820B1FCB27774F477E7CDD1E919978C
      3A342649769A75863671D487076F0F1CC5D0E0E51434AB7235376CC8E28EA8E7
      FAF3D1A480A4A1945EEDB329EC8C32B443B0E996978EA7C0338D9CE58BDE2B1B
      DEA00EE07D629EA48B3925E6915C083C5BC130A002DE3533D70636FDAED52E93
      F19173D33CB36DE204637F4C2D4FFC252593732E39DB2026BF5013CA6156B134
      9A5AC326CA5E1B8990BF2BD2EFA195BE7DF7E1C0BAA52C5A239989576AC49020
      55FD7AD3F68CA7727C74E0CD96D8DF697FC3CC1ADA09A8B579339018B8740890
      004F1D279B1B3F65D47FA371DD467FB176A0F5BD17D7944173910F2D3149A505
      169F32FC1B3BF8D341717DE35C6BC5705DF5D4E8FC533D94B5371A5FF48B62F4
      64E33E68E3BADD271B77D6C6FDBC1DE5F2690EF9ED2414A26CB12B39D8C0B106
      C2BE3221FE27527F88D49F80DE66493DF8BCBD3BDE503FA5C9F8FD8F4CC454D2
      D157A34BD384CAE29FE599934E86B02638F42B753B380557D45087908F39A37B
      73A3511B2B2DC7B83647EC7EEA7EC7D5146387C0434C0FA546224F6F51C117F1
      1F29282EB72A9CD08B62D24B6B1A9B7405E20DD26395F7A4ABBB00A09335C591
      FB27A6F410537AC262BBC5943E6F1B90CD8D9441269D84BC7254B7A52C52B989
      C4D8BC562677697C7951486B50AEA2FAC7A43F3468046ADC4418A33BEC29B12D
      51877A74699913A536D02C0E0714D93A2EF241B320CCC40C3B65338C6159D810
      9677FF6ADE3FA6F91CCA7CB8AB196506108A9772182D33A5AE5EECCEA1D61036
      99AF026AA207D28E57E5899C94D3306143791B33E44A895023E88737F5B24ACD
      ACFBDA29869A1449727FB0C3CB51E71874A32624E4990F5E30F29E1D27752DB4
      1DF512B2B4A5E76E41D8F6634B01E4DB62DD20275E4B13A1A4B0738A38AB84AA
      BA3637AEA55D88964F0704CDD7A3469F8280DF3088C5778CDA2A69E93C3979E3
      C440B8928095E453E30B2290DC9F24FDFE9505BED69FB068394141ABDE8EB51F
      781512DCF904967A9F80F676C3DDA74ACE5BF2F9F336FC21FF55491DEAF4683C
      0F3B30C1FB140DBCEB097D22F14524EE3E91F82C897FDE3E0D9B1BD4601C84FE
      CAC97A85F4671E92FEC5E24E8DF2527A1C903CEF51CEDC5636F9F5D79B2DEAC7
      487D1415350C2A299443E78012566F3D06938DF5481E601E49C6292523E97F4E
      548F716920248BC9F98534FEB5898A4605E66ED136F8AE92643222FC14FC6D94
      91EDC0896FC6FAF9ED2F967E92BBCE6B496DE26C3C8233A71A9C4472B7373738
      AB896F2C458536962735DF34E393418BA780DF793AE30F9DF1D67F7DA6259A6F
      CEADBA447E347B98AA05C28AF0023D78A6B64EB4D0BD31E7244CB8BBBBBBF527
      2ECCE76B38BAB94195D3A4F3322A9E09ED4A795BCE1DC0F37309F98E475AB36D
      FBE23F9D456B66966CEEC772ACC57DC47695FD10FCC1020DC59A9C48DC6FCFD8
      C952DB200D68A903DD0D87D346795AEB7EC0957C7D5A3C620689A9044FAB7EB2
      F48CE79425CC7F31E3E2A20A47FE92FE2EEC5564466467C15C9352314B9D4D7A
      36C598ED883EF632A7EE5950B527145A1EDBB47288C601379219C26420F5DCB6
      FD9B8C2723BDC360D2AA87B15C9B1684AA77AD6E4A3262AE6852CAB82EABAE85
      DB7AF77CD79134FC371FFC63815302AFBC31FD78E983012EA475E9A9E1902F34
      4B6B42DAD38A4633DE1DC7568BF4D52599092393913DA8FAAFC154E4C7938540
      5B649337EA8F279399BE829E215699B49DC30CA47EC31EA145C7F736D9C633A8
      A30F1FDF9FF64EDEBF7DFFEDAB47CE0DDADC98FA3E68FD6A94AA384DB9E46590
      C514BAE67534C9ECE7D2DA98A59120DC938D2639E658D64B216369A4288FE0B5
      9F944C487969DF257F371B76550310263EBA3BD530D853757B47075AA01E2F4C
      BBE53E1F344A73E0E340DDF53EF8CCFB0DE913A4ADD0829CCBCD8DAA035F397B
      6278F84AD2E42D440A443C4E20C9F62A37700FB4BD33DB7793A8849DF2B42079
      CFE2C43328674F8D881BA42927F9AB6B48EF2D4626AF2D193E37A9D0D49D6932
      A457C1B7AF85D6461381629F0C2850AD9C2888313BFBD5D8B09F38A3EB49DB7F
      4013F0775BCEE1CFC787276FDF1DBE3FDB3B7A52FD6755FFCFDBFB488E8911AA
      A44F93778AB21BA4BAE24E4C78C768FAA671431FA268402593A64FE88CCC35FD
      D509DB2805AF17418823BB257F265C7D6418D1161F4B45E7EB86935C7075425C
      084AF724B1D549C3826AE9732A3E84A8D32641F74A573D70B7F619FA9EFCA887
      5C59B65535F469568E496184373B170735AE82235EC784A8246DBF28C7162DCA
      34F830E6575FAB81D113363788E332732BB5B6FD5C4BC2FB0777AB47392BB522
      CD53AA36E10F6EB81AA4D4BDCCD9A60C67DAB981332DE928FB3BCEFEE9B42C96
      73DF8CB1645DC0B165A4340B68136F39A3B44271A40FA42A5058B9DD1D53C22E
      A089569430377F312804F313C3A7B3D0D722B7F8B9ACF0D41E0EF94A678956AC
      D466B652AC5B8AAE07F98AC5B9D47A28EB4F4F2E9FCF7C3BD510D5BEFE2227EA
      AF0F80BFFF6C66F4A66B8B38BA5FF0E5C7DF9E1C887AAAD5A84788C9B67D56A3
      0891CA08AA6958D0CD3C65D522EF3F1ACAD0E30DF8F5E49C92AFD83D2F86BC89
      172717459ED864CC584BF1AC854710CDA35113D9DC3803B1FC30908A3BE67FA6
      6076BA21E6288B4A754CF1022842FBDF9D38BFB4F8C70DFE4E647928355DC78A
      B9C354093AC59DE6B3532E5FC0AA7D1832D7E45206B9C1E845F89A5DE7DB5C3C
      31468B1BCA57DA503C557E731A2B4E83ACF0B4ED65DD7352054E24C9521446DE
      175B3CB6B9715D8C7AB88D3D3F7936F5FA0CE99408664AAD7D33AD8EE4D04A45
      B154637064AD623C78108729522B0DACCADC2CD6BFF4BE3373239759B59C9CA0
      4F025A12DF594AD825DA11CED7CB2FA5446F4B20789D676FEBD256E239CF6048
      9374994A47272D9A96762DEB34ADA030C79C1684F278AE4BA71E386787224C28
      0A1E1B334116116A16B1B184A36E06C28069D55C9A6AF326AD2BDB4E426D498F
      72D4C5C8E52F06AD099DD64A862F542A84C7B5C4D34A89276360BE31E03D45B7
      6EEBFF9FBBD7C5B7E45338B575C4DBDFBE3B3D7B2E47874E1A97AE57CCBC2C7A
      57DCE88C2A200A2957A646C03BEC431319DB2C26B26702F546229CE87351D72A
      9C0D4E7F95F9B19523268A72DE503C406E7E3AD40F1DEA3FD5D7FF395DDA6775
      F793F1077351495FFDC3742DB41255F5F2F18D71CBD60CEC98D5578A49992C8B
      BC9CD331FC89E4EE233977F7A94EFE9614F9BCCD540446C43AB5B37C44263839
      80A791540808E860ACE4B20ADAA8FD9B8E5F391E591AB363E7EC2FD563170C35
      5F5304D8DDA80990155F15C152E6FA7931BA71B6BECB5328FF64FFBE2B52E75B
      CA65DFB28D1CA02CC7DAE0D5B0346FD48418F7D536D1C0F8ADA6E180CBBE278D
      45088D1C50E77A5C33F4E9BD81844940668A2B2EA7AD7D1A35C70A9D6C484753
      9A851C2BD8EEDF8EF28625E9EF610D3958B7351910DAD560CB3A17C95462F781
      A45A9884570A2619C591B14C1B3599CD8DD3DB46E536B775E3A61339C7BC8C86
      088BB9BCCC873BE44A34B5203BCEEEEE7393D39BD423DCEC76D93AAD8CC9AD9D
      EAAFF7C5408B877BEB2D397BC74E3582AD462D8DE246C634B18904A125E9D396
      C1D8FCE422CBF284DCF0A696B951731007E1AB9A504A98915F8F0A8A275A88AE
      62B2B9319E86FA393FB582AC15433F1FD1D1244F9475352B4B18DB9C3420EBF2
      9C77D638D28D5228C4C14F6BD4E2406BD0232ADC1E5F6B75398D2E680AD3E665
      DF480789D0D78015921EBD5539D31B35A7CD0D961659B5DFF99D98C356D59351
      BC65DCB36D24EEED2D671B645F3AFF9C90575439B1649AA969AB7230B2440B1C
      236906CF779D3D0640652F5315844E71C84D6B2A8C8AFC6FE6CB52E7F5CDD64C
      8338EB48AA7511B699F3D352F5D1F47E0286AE22FB8DACB77F376512E4C455C3
      618FC24C060B5A62E8365336C947C9A44F6A54D23C9FE36D9F22D7E38C8A6BEB
      416005DB2929A3A6CA5B626F09153A10183D670554DEF0EB729AFBCFE98BD6A9
      2050489CEE23E8187DDD2F769DD3A24AA02149AA5599B365A8D26903EF911317
      C565B3CE2045066E285DF3DC79FBEC8A2B59CE0B7691AA1806A6F3CD53DEFFFD
      16ED534AF42D8BF6F38260CF7A4589A549214B5ACB6AC0016DD49EBDB1B11CAE
      3C239DE498C2D59C1CB15F0C5253D4CFF8B49021294F46CA991A66CE56D66AE9
      6CB30E2A4C84B9678F9A81360B319E0C0AEB3FAFA56DDCB51C444579CE5B20B9
      732FA5F69933E894B33BD6654022A5C2F5E42CD52AA05B12550EC944E4FEB3DC
      83B13481DA6993DA6DA3A55B64290A1A0E55697CF6A68AAD82656AD6521E5BA5
      6DC459838CD85DAFBAA155133FCD74650C86F4D45F730E4D6C0971A35C6AEEDE
      F3C22E7E93247E3C47F41D6EE4BB61AB3DBB6A66B5DA5EB7DBF53BB6DFCB6FFF
      FDF12F1F295EAEB90F65D80AE296DF0ADCA0D56A45F8BF23817F0F4C577753DD
      CAE22CCB4C3240D2F2F85F5FFE0EE3C08FB248B78328A4DF611606ED6EBB1585
      6D3F4C3DDDEE446994A8A4EB2671A013DF6FB92D5CD40E3A59D2F175E8A581DA
      DCE826B1872FEF78A1EE76BCA4DDD1495B79ED2469259D6ED70BDC28E9A69DD8
      53ED30C460DA41927A611078AAE3B5DC284ABC24EDFA7ED6EE6A3FD67EDB8B53
      376BB5E330F14116896A074A659917781EBE46C76E1CB4C3548569E6B7832CED
      AA7473238C4041AEABDC8E9F44AE0A5B59B79305B18A759C781DBFDD69775A01
      1ED655A1A7C276AC23CC11E3883D3FEDE86EABEDB959B7A582D4CB94DF697949
      EC87EDC88B3AAD2CC572EA24C5D0DD34713B3AC6535CBFA3FDA41BF8695B872D
      3F8E3637E2969B861D3FD55A875917CB1068AFDB8A31063FF3A340AB245081DF
      EA74FCD84F5A5D2C9C4E5427EB06581B37C2DCF067DCF5DA59E8691578F816E5
      2669D84DB05259D7EDC62DDD097514625B5C3F549D547BADCC6BC59DC4F5123F
      6E6D6ED0628759924510802EBE404771E6C75DDDE962F8711A85DD28899314F3
      8DBD8E6E277E14EA24C130DC2C7383A895857EA63BAE9FFA498261C4ED4C6825
      23EA01BDDC4767D80DAC816AE3B1F2660B7A80CB2F62436959DB038D256DDFCB
      4057E6758708298B145116C6DFD659278C532CA3DB4EB1DE98990BAAC24E642A
      ECB6029FB6A79D62435CAFD3CEA28EE7B9710A8AD0F81D649B1B09B6B5A5E218
      EB8CE5D659D6565D3FCDB4D29D38EB6AB71B685A9DA8AB946A4589AFBD008497
      C45147BBEDC84F419C1928B8DB0955A0DA5ED8C270403CAD4E84EFC577C444C0
      49D84A5DE5639952DF756315069D38F25BDDD0F5B00B59A7937603BACA533AF0
      A22075B1C3ADD4C380C234F683C8F38276A6DA60786E98A56D505E8786A6B166
      38197E16BA110E56DB6F632ABA93A94ED2CD32500DD62849BA3AC81217F7675E
      A2C3009B12E1C874832089F05184112817E72AD37EE8C72968BA13854AA581AB
      D3561CC6A0B834CA52D99B6576368ADBDD6EE4461DC3313AAAE224FC03CE816F
      009708BD4C5E6F6ED4FFA2D7418A0768FCDF065FF12C57C16492206D61EF3DE2
      2AD8D376AADC76BBDB0237C066C420D3208C70E89358E938CE30B2C0EF26AE0A
      5CF017AC6837035DE3046ABFE3FB6D58C1A0631C99787303F3C10B6C64D26AB7
      D28E8A42B01CDDE91051B7C16F541BFBD64955D071136C5412251ACF7471C074
      B7DD71B1E271D0C1414BB3A00BB2F4438C0DAC023408CA48E3304DBD561AC521
      5855E8B91A7B91A6A1C6F90D4028607518413B6CEB0E7613CC1B54860F31116C
      68CBF33BABAC7FA0DD2C68A56DA66CFA28767907DC68D1FACBEBCD8DE95FBE6B
      D75C27E02859874E4BE406B12642F2B356274DC1DCE238D201BE2D8E93C4ED46
      1AD77763CC3448824007AAA3239C81087BD68EC0CA703ADBE0AC98534047C54B
      5CFC9BFAB8DC07474C33D001CE094E19BE1C6738C372C5380C5137F4131CC6B4
      857BFDB0DB05434FDA690A11E081D779387D6E08EEAA333CA30B1E9682AB6449
      1A74BA6D95A5492B53DD76D809B0E758345077B7DBF6B4DFC5110E158EA31B77
      FD083B8B0966741ADB0A47584510386E026AF28320EC76822E5193076E8BE1A4
      692BF3B3B8D349DA51BB0339E1474907FBDD250EDD52919BB65BBE4E630F7CBA
      8B6F6825CAC73A795D2C5FAB93E92ED80D0603A2F4B4F6A36EDB757145846575
      4107A9177929DE532A09DD16E4287805B856D0F1886F75C1365C3A5EB1D70289
      8273615320DD5A8A1E83931E24606549D44E35A45B14BB584D0810ED41840401
      C461A78DF300298E81FB5194763B11C46E47B7C0C67C1DB73DC8C68E72BD966E
      677EA0D3300A414A3AD11EC929CF4B21DA3B90906916790A8CB71BB6930CFC0A
      A21E6233C3D7815E886D6660B75DF0448D83D84D43280B10735841DC9980D4B1
      4D69A4C02A5446736AF981AB40102AF43DA859B14A321C9B6EBBEDFB0A1A08E8
      257315481A84D485068133E67B71A63D5A912484CCCA3A1189EC6E802D8FF12E
      C4824EB2761B7B08C115C460CC2A6B437569E160415DC06CB013443E4908D505
      A71C321222A48D95ED4243C11B60855EA7D36D6912201D1DB6559A75129C5F1D
      755BAD2EF1F700FB9FF8B81D7C1E4485A5EC841D0FD2A903728A0308A3080406
      D28EB05F6020495BE3F0E310065D2C0504BE0725278B888AC008C25612FA5A41
      02B89DCD0DD7C748326C271636C6F1EAA890F40CDA94AEEEFA5D88820E1E9F85
      6D5094871507FB86EC03B7EE78D08CF115206B9C3537C32A61912262F8A0628C
      A145FBE1B5A22CD419560E3C0C4BA0630DC9D3C16E046D88BE6473C34F483C43
      F842F8A7018819FCAB033D4D752395851028187BA671D894EA6620930C6710AC
      35C3CD10410134C32CD138296D104B1AD32D5DD571C168BD90E4241E9AC166EC
      642EBE84FFF2A107E1170417844588B380C303B90B551407013BE38569022248
      71405C5202B152AD4E3BC0BA830363CC293833E402E81CEA1D6427162180AC4D
      12A8032D08F5109745314DB4E5062E69AD20678856F0CC16B42288645248530C
      0B7A570666053AE824D08712178A269E0DA60206DA49C0E8A34EDC81C61163BB
      A164612C50EF3A206C0C1F02D70D2125D234C0DA41ED0DA012641E0E0FB81878
      540BAA71174C254C3205253002F7210DAEA3A13E76141E9478104C2E74B12400
      3FE8C42DE8A57107DCB90D01E3B514B45C0FDA50E241B2E09A08F7603B21EA31
      BA047357A182769076C17AB0F91E747017434BC04F5DF0BD0E2465E8767D924B
      AA03E1D20EBC202526DAC1198402EB833E12F06A4C22F5BBE089A4E68243781D
      85EF02436DD38383C483D202018977711055AB8BADC0AE83E6415D6DAC52D7C7
      D802E86F7E07A4E62962A2203AF037285A507FC3B413F80A071E52246D695C89
      39836979E058D04021EEA02A4350433F70333218A038693ACF4CEE7474A0C9E0
      7FD03BC60C01019697421B68B5A19DA6418A71A61D0F2733E8664A936212803B
      8521AC8318A2125A2C28C3878EA81571B308CC0EDA1C1835D437A8E1DD96ABF1
      BC2CF07116B042AE825C8EB149D01DC11DF1123C181C2E0303062F0B410E4188
      5319D051836CC0994935283E89B2C457D8C61874AE3D1F2C2B83BC017560D818
      3C4E691A4761ECE36C80E5698D03E345298E56469607114D861168DDC25FD09B
      C19C85FB82778341EB1093803884CCCABA19F4220CA89DE0D92E988D17E37938
      3B818ADAD8B316645E17EA3A09042885605DAD58B7541BC6831FB9D0DE53583E
      A01B302F9C363C37F35C1F07A0D58EC091B07731B835E8B80B3183DDC5B1F5E9
      4A5C0A568481E289510613184747E1DB600A61FF52A5BB113838646F17161DD8
      070CAF0CC64F4C521B0C030A170E20C423E8368CC9686A4335E97A981CB4509C
      94762B80FC86644AE32E741F2C8E8F0314B412D29E7098C063A121438C803BC1
      92C189875C02930729B6A03660E5F1ED3128360DA11311A982E582C1C0CA226B
      924C2768326D18975D68722E78BE0A316FCCA34B12294E93049A79A2C96A83AA
      0385278A5A9182F9DD2235008C3B24A5143A11643264281880826CC7790F7DA8
      E821CE270E24C81F5A11860C4523020106412B82761A42EEC00A85B2DD49B171
      B01BF16E08C104360F510E718AB306498EC7F8214690C18A85728C2B61D97514
      B424CC102B85C5C3F0A10A6041548CB1D15D60831174A836BE0E04095E0F49A0
      15B6D38550206BA08D5395804D07110EAB8EB2AC9341DEC0CCC55F90A7B068B0
      BA583DAFEB2B28E229D98DA00AE846093364283B58659889E0990154554567D3
      0BE9F4241D1CA408BA818FAD82BCD13081B037F84847385350E4C097C276EA2B
      629230EC60E1B4896C54178FED408C9076DD863E0E7204BF6DC3786F938E815D
      208B16AC8624204EBF078359614C901ABE1BE0B91AFA87D7055B8DA0AC408083
      1943C9C1F186710685B283BDC2127733AF9DC0F80920975DB79BB6B0E864EA42
      9C612C34671D42CE82A574C3040B055503CBDD4A5A1801B888D7853A8A6D76C3
      C00F60C9C3C6C616615FA0934589221D0D36598A730E5D0F9446D639587E0A91
      44EB1EC0B4839DD1F57DD80231E49DF2405AB04EC0A4C0DC63B7058505323E04
      2B4AB10F711B47833C1458B200565B4ADA4B0B6CB99BC1320AC1ED3032F014E5
      C6B056A137107F68C589075D29F0622881905669BB0D7519CC19362F380EB6AC
      4B2E1CD256E23618A40BF285A4819C61CF082C12AC3F2C295884981CF61203C9
      68E2A427E22B21406057466907BA2BACA5005743BFF1A0346007A20006AD9B60
      79C003A125438768B7C13FF04684BD877A93C04A0D41BF30C920F8B12F38E590
      AF9A86093D0E4688DBEE263CFF34863C22C716D6202511978212C18413707398
      04E012A0588C34715BB077E25686897BDD3678B3AFC904242D0AD22DD538C050
      39E8ACC1E6857214752106413B387FD0D8621DC24C84DA4A4E075AEE2E91B606
      F7C6B6C176A24303BB270D6804A0034C308260C08EA90C7B0185026A0FB43430
      612C7E37552ACC34588FAFF0E436CE17D9D5A02218F858724805059D29A215C6
      1E85601C31F8521B4714663CDE0393010D831A307F1232204B105404369B4091
      820E0CBB117A0D242CEE83CA03B18411600D97B5165B605ADD5697462B567A2C
      96A6D7BEDF5A9C7A67201B1FB4DC67FD376CC3935682838113EDB5C95D9245E0
      20B1228B07F494763AB80847870C251DF8300CC9408259ECC2164961269245D3
      817A0556067EA0BB5D28B771B70D1DB00BE50C872AD5604C38CBA00648235C00
      DDBE0B1B0372AA03AD133A200C7148804E37EDFA10053196A603061081BFEAD4
      850AD385C1EB750232C802983EF8361F6A781B87CE8340850A0E1D055A799041
      47C2818281A9A04DC1D2093C4FF90A6A3C6CB73885F0822182530BDE466E39A8
      BBD05341C5113600F21D52C4C5F0439814E4B5C132400FEB7423D027C424EC2F
      6C30D455B012A88CC4A314B91F121C3328738A4E7A90C06209414EA070A83DB2
      7333BB0FD9EEA554DAB5BAC7F7BE9FBA37185ADA427FF04363206FE07DBEC079
      3F7E4BAE99A5C429A53DF49D0FF9A9E6FDE0A878F79D8ABA0F65FE497868540F
      796FE6FD402655A3C22ECC19D73CCFCE4323798833CC1D098EEF7DEB53F7E92E
      CF3378A4616BBA02A1FC1F1AAF5892B494FDE8B7CD0D0A762445AF189509853C
      FA0665045665669E0C3E4DDFD4F6C15A41BDB0A93C5A17987F1EAC621CE088A8
      3AC0A7302DE9D310E23E80D5E977E80AD8FB018F987E27F404AC2BAE6A7789EA
      F12CA8F5D03B154516C006C0ABDB301FC88A814ED19231E0ACF8F88CEC391800
      ED00FFB5A061651E39297CB33238F3308EB2368FC9DC1745B486F459603EF588
      53C0CEF2F05E5BC6CCB38422E7E394C034CCE8FAA84B279467883B7CF966A835
      9839CD29806A25EF05512CEFF1755E759D575DE755D7F17B78368D99E341E619
      33EF4CAF61EAA4F7BC3B57DD7D927FE71AFFCE35C19D6B823BD78477AE09EF5C
      13DDB926E26B3A58715AD158F6C9FEC59F6127A22498BDE2D67BB80EB4606892
      82CC837139BEE9E9F263AF4CCB71DE579FFC76487FF48AE452A7A9A676E7F848
      F7F30BCEB3B6EF4C0654334E19A5F69D7F4AB299FD7338CA8B513EBEC1DFDDEE
      7F4F1F29EDDC9CDA1DAE53BFBEE54CAF6D39EF194AF49B85577767AEBED01238
      75BFD9DC981DB6DC351DB4BB7800F31FE97DF3C80FF41FFB81C1E34F3A7CEC31
      468FFDC0F6E34FBAF3D863EC2EF5407B578E23F669690A9EBD6B39229DBD6739
      3A9CBD2758E39E70AD192D4730B3F7B4D7B867B94D9FBDA7BBE48C2C75F8B3E4
      312E126CF3EF7CC0723B7ECF03FCDF3F89E5A8E19E072CC766EE7940F4FB27B1
      1CD1DCF380E528E89E07ACC62644303A6F07047CB0E2D1CA8A623CE036E2FAD3
      78A56F5503DC67000D57BD97D8A11EAD740B0D14B7ACC3380CF35D9F97FBE1CC
      5313C5AD09571ABEB48D2E3227CBCF27235DAE38113DB8D2BD625801BCADF4DD
      D5CD233D9E8C561B77451F5576FEBA44327DC06A53E76471A9275EE9AB87EA7C
      ADFBA0D7FE8E09DBBBF948AC36D18A44D4647C417497EBD5F6B9AF9251B11A55
      166AA5D361EF3BCACB556747B738AF27BD9E5E8D55F07DEF57DF46BE6F352588
      6F595608CEDCB49A12C4B72C27E8E6ACDE3A933277AE353773EF1A533477AE31
      53D9EF75666AEE5C6BA6E6DE35666AEE0C171BA7EEAC2D7B968F7BAB3196FD5E
      4105592BCEEB343F1F28C2CB5D4923997DC681695B4BC9F5E72335BC70DE1483
      D50EF1EB22BD71CE56D512AABBD6536D78670893391F4C565BEB993BD7A1C2EA
      DED52CAAD97B9735E2E7DFBDDAA97B675A2E7D3755CCE693F12DF29AC4E39529
      F954F526A213AC38C103355EED9BA604F486211A0C19FDFE47AC4813EF4923F8
      CEC8D9D5E63CFDFED5BE727ADF6A2478FBCCADFDB5E6F65519F16B7AB13AABF8
      EE86208DF2C1E54A77BD2908574DA7B377CF257CCF9BA5E13115579BB9CDBF61
      96E11FF68717AACC5753E80E8A64C2A8E1EFD470A51B8FA99665F5553C7CD1A7
      368353A1B1DADE7D77F6EEC8392B86A4C31236D66A3B4837BFA612CAFE5AF71B
      2378FB271D3F5FFD8BF7A0390F6EFAEB4C786F0D8B8C6FDCCF576467725791AE
      71D7410568BCCE14BFD73771A146E9EADF7B0C2B8A0FC758AF71F7A9A26ABDD5
      EFA37AC06B1CC295FD057CF78F6A949329B60EF99DAD7C63CD422E27F13F74B2
      DA917D5FAC638C7D908261511996733CCEBD7535E13073EB6A62E94C305D73A2
      87951DE23337AF36E4995BD719F23EE3482CEBDD9D7FAFB7D67CEDDDBF67D4AB
      9942E65E0A6F539B8FB5A66C6F5E73CEF6F6B5265DF426FD41B9EEB8F9DE75A8
      CBDEBBAAAA347BF79A5BC5F7AE662BC8BD84D9B4D652F18DEB6D2FDFBACED6F2
      8DEBAC10DFB8F6F22C1B8B9873EB6A81ABDA8DAB45AFE4C635C440EDC6F5F672
      6D21B086C3AD76E33A7BC937AEB7977CEB3A7BC937AEB397FE81E92FBC1E23AB
      DDBEDEBED61EB01E131E8C757F588CD4E8668DDB0F7BFA5CAD68E2CB9DC7A322
      23CC2302405A4FBF98C463564ED6BE751DE1017367ADAFA4FBD6DB60BA73459F
      02C19717357B7441E473CAC5D698D019E5D3CDBDAF6614279A1A89EB910CE51E
      EBFD8E927D3A54898D92D88BA25913FF8891924E2FA6E194EA4277CE85ACB6CF
      5CE5CDB9AA5A8DEA2A7FE6AA773ACD277DFBAD8614AA6B83FBAEB5DB5F5D1DCE
      BBBA261BAA0BA385177AB317B6E75D58D31CAA0B3B0B2FBCF5C4EEC20BFD990B
      DBB37B73A046977543A9BA6C76672AFD71DE2EB6BDF9D7DED9C8B63FFFC2BB7B
      790F01397B4942AE1F77394A9A5E7E6B531711D582E7DF4F5D0B6EBA9FCC16DC
      740FB5CDDEB1E83C9FE8ABBC9C7A34E647EE835BD32F6B718C7BBC7DB364F6B7
      49615C35F3BF64761BDF42820D4A5DBB6B9983B36095EE39410BB7FC9EC3B4E0
      5BEE3955F3EF5874BC165C7DFF295B70D33DC76DD1D4EF3B790BA6BEC411F456
      3B82DE725C7DC1E5CB1DC03BBC7BB923E8AD7C04BD9509787911B0E08E25C8F7
      CEF49720606F2502F6D621606F6502F696161C0BA7BE0401FBAB11B0BF1A01FB
      EB10B0BF8E04F157D058167CD11204ECAF4CC0FECA04ECAFCC7F6FCFFD2102F6
      D721607F6502F65726607F65FE1BDCDEF6870838588D80837508385887808395
      F9EF9DB92F41C0C1CA041CAC4CC0C1CA041CACC47F6FCF7B49020E5626E06065
      020E5626E07035FE1BAEAAC387EB1070B80E01872B1370B832FFBD33FD250838
      5C9980C39509385C8980C375F8EFEDA92F43C0E1CA041CAE4CC0D16A041CADC6
      7FA3DB1BBE1C0147EB1070B43201472B13F09DF92C41C0D1CA041CAD4CC0D14A
      041CAD43C0B7A7BE0C01472B1370B4D8167767D7C1785667B26FE65BFCB3F3B3
      367C75E37D3E0677DE579ECCA48FCFBFD19BFB9DCBDC39BB48AF8BE2728594D2
      EA29B374F93A8F7B79C19E919BDF534A77DBABFB61BFCA7DAB5F16DCF1CE52CA
      12FB72674DF4C05B78E1ACF914F80B2F9C553A8360E185B7F58E205C78E92C1B
      0D668F1393AB0DE580E1CD5E1B2DBAD69D77757BD1D5B7A6DF5974DDADD97717
      5D777BF2E1C23985CC2F661E1BBA8B2E8EAA533C7B83B7E886F6FC1B1E5CB6F9
      2E9E7BD66F911FE99EA55CF01D8BD774FE0D0F2DED82BB9658E345735A66B917
      4C6ED975F7565DF7A5097891F7638975F7D65A776FED75F75626F285935B76DD
      FD55D7DD5F75DD97E6208BDC15CBAEBBBFF6BAFB6BAFBBBF1EB5DF11150FAF7B
      B0EABA07ABAE7BB016B5DF61FC2BAC7BB0F6BA07EBAD7BB82AB5DFB6AA9658F7
      70D5750FD75AF7706D6ABF3DA755D63D5C6FDDA355D73D5A95DA6F5B0F4BAC7B
      B4D6BA476BAF7BB436B5DF99DCECBAB345B4B41258BBFA5E195ABBEE5E165EBB
      EE5E0E52BBCEA880F7328EDAE5CB2981B51B965302EF2EDB524A607DFD16DCB0
      7821176A8D8BD7742925F0CEE22EA504CE5DE305772EB1D80B27B7ECBADFAB04
      CE5BF7A50978C10D0FAFFA6DC56AD975BF5709BC77DDEF5502EF5D776F3D6ABF
      AD6F2DB1EEF72A81F3D67D690EB240255B72D5EFA88E2BACFBBD4AE0BDEB7EAF
      12B878DD8355A9FD8ED6F8F0BADFAB04CE5BF7D558F882BB5658F53BEAE30AEB
      7EAF12B878DDEF5502E7AD7BB82AB5DFD11A1F5EF77B95C085EB7EAF1278EFBA
      876B53FB9DC92DBBEEF72A81F3D6FD5E2570DEBA47AB52FB6DC56AD975BF5709
      BC77DDEF5502EF5DF7D530ACDEE196D54BF64EFB6A345EB322F63B555E8CD56A
      60203F0C46BA2C7AD4D6CD0EF837EEEA450DBDCA31B5B36BB98C8BD9122CD056
      CB35589E9B1B01B50662F448DFF374E8076ED8093B411A2421216CBA5120B89B
      7E441898737F227952DA4A32D7D52DE5C6AEABB4BB1809547E7CEA758147663A
      CB181974118AA97BEBDF5B1FD0FD5985507BF7EFEAFD3FF08790D7BFDE9FA7D9
      7FBD3F73669F9A7FF59F3B92CFF1F3B4F75FEFCFD3ECEFFF09A16B4499FCDF0E
      44F508A085445AFE6EE38D76F7212D61FD1F46450F17CBFD5612A9B4DBE974BD
      CC4DA991491462A441AB1BF95EE8EA70D173D3167597505E5BB77547A741CB5D
      A47134E567E10AACF9B3B9F198A3FB337E1E7305BEBCD9D3CF63ADC01AB3B7B6
      87F9F9EDB7FF1F2D27B557}
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
