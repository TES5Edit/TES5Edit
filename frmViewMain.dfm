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
              's and plugins in their correct load order. By navigating '
            
              'that treeview you can look at every single record in any of your' +
              ' masters or plugins. Once a record has been selected the '
            'detailed contents of that record is shown on the right side.'
            ''
            
              'The view treeview shows all versions of the selected record from' +
              ' all plugins which contain it. The left most column is the '
            
              'master. The right most column is the plugin that "wins". This is' +
              ' the version of the record that the game sees.'
            ''
            
              'The navigation and view treeview use the same color coding to si' +
              'gnal the conflict state of individual fields (in the view '
            'treeview) and the record overall (in the navigation treeview).'
            ''
            
              'Previously colors were listed by background and text color. Inst' +
              'ead, click the Legend button in the upper right corner. The '
            'Legend window will summarizes the meaning of the colors.'
            ''
            
              'Conflict detection is not simply based on the existence of multi' +
              'ple records for the same FormID in different plugins but '
            'instead performs a comparison of the parsed subrecord data.'
            ''
            
              'The navigation treeview has a context menu where you can activat' +
              'e filtering. Filtering is based on the same conflict '
            'categorization as the background and text color.'
            ''
            'Command Line Switches:'
            ''
            '-cp:<encoding> [utf-8 for UTF-8]'
            '-l:sp For Fallout 4 [Set Language]'
            '-l:spanish For Skyrim/SSE [Set Language]'
            '-edit [Enable Edit Mode]'
            '-view [Enable View Mode]'
            '-saves [Enable Saves Mode / View Mode Only]'
            
              '-IgnoreESL [Will load all modules as full modules, even if ESL f' +
              'lagged]'
            
              '-PseudoESL [xEdit will check if the module falls within ESL cons' +
              'traints (not containing new records with ObjectIDs > $FFF) '
            
              'and load the file like an ESL (mapped into the FE xxx namespace)' +
              ' if possible]'
            '-DontCache [Completely disables ref caching]'
            
              '-DontCacheLoad [Don'#39't load cache files if present, but save if p' +
              'ossible]'
            '-DontCacheSave [Don'#39't save cache files after building refs]'
            
              '-AllowDirectSaves:<filename list> [File may be an .esm, .esl, or' +
              ' .esp. Without a list of files, this will load non-official '
            
              '(official = game master, official dlcs, CCs) modules without usi' +
              'ng memory mapped files. Optionally you can specify a list of '
            
              'files. Which will only load the listed modules without using mem' +
              'ory mapped files. This optional list may include official '
            'modules.]'
            
              '-<gamemode> [Specifies which game mode to use. <gamemode> can be' +
              ' any of the following: '#39'tes5vr'#39', '#39'fo4vr'#39', '#39'tes4'#39', '#39'tes5'#39', '
            #39'sse'#39', '#39'fo3'#39', '#39'fnv'#39', '#39'fo4'#39']'
            
              '-moprofile:<profilename> Opens the plugin selection from the MO ' +
              'profile named in the switch.'
            '-setesm [Set ESM flag. Plugin selection screen will appear.]'
            
              '-clearesm [Remove ESM flag. Plugin selection screen will appear.' +
              ']'
            
              '-VeryQuickShowConflicts [loads all modules according to plugins.' +
              'txt without showing module selection, except if CTRL is '
            'pressed on start]'
            '-quickclean [cleans 2 times and prompts to save the file]'
            '-quickautoclean [Cleans 3 times and saves in between each step]'
            '-C:<path> [path to use for cache files]'
            '-S:<path><filename> [Run specified script]'
            '-T:<path> [Temporary Directory]'
            '-D:<path> [Specify a Data Directory]'
            '-O:<path> [Specify path for generated LOD files]'
            '-I:<path> [Game INI Files]'
            '-G:<path> [Save Game Path]'
            '-P:<path><filename> [Custom Plugins.txt file]'
            '-B:<path> [Backups path i.e. Edit Backups\]'
            '-R:<path><filename> [Custom xEdit Log Filename]'
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
              'ach record that is contained in more than one mod of the '
            
              'modgroup, only the last (in load order) is visible. That'#39's it. T' +
              'he invisible record versions simply don'#39't participate in the '
            'normal conflict detection mechanisms at all.'
            ''
            
              'A modgroup does not perform any merge or make any changes to any' +
              ' mod. All it does it hide away version of records that '
            
              'you'#39've stated (by defining the modgroup) that you'#39've already che' +
              'cked them against each other and the hidden record is simply '
            'irrelevant.'
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
              ' modgroup is only available if the module has one of the '
            
              'listed CRCs. Source means that if a record in this mod is found,' +
              ' then it will hide the versions of the same record from all '
            'mods listed above it that are targets.'
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
              ' in the selection list. Mod groups for which less then 2 '
            
              'plugins are currently active are filtered. If the load order of ' +
              'plugins doesn'#39't match the order in the mod group it is also '
            'filtered.'
            ''
            'What'#39's the effect of having a mod group active?'
            ''
            
              'When a record for the view treeview is generated and multiple fi' +
              'les of the same mod group modify this record, then only the '
            
              'newest of the files in that modgroup will be shown. So instead o' +
              'f seeing 5 different files with numerous conflicts you are '
            
              'only seeing the newest file in that mod group. This also affects' +
              ' conflict classification.'
            ''
            
              'It'#39's worth pointing out here that if a record is overridden by b' +
              'oth plugins in a mod group and other plugins that normal '
            'conflict detection will still work perfectly.'
            ''
            
              'Basically this system can be used to reduce a lot of noise from ' +
              'the conflict reports.'
            ''
            'Reference Caching:'
            ''
            '[GameMode]\Data\FO4Edit Cache'
            ''
            
              'Cache files are based on the CRC of the xEdit EXE, then the plug' +
              'in filename. For example '
            
              '3917E178_DLCNukaWorld_esm_43D25C56.refcache. Once built xEdit wi' +
              'll load the cache file rather then build the references '
            'again. This reduces load time.'
            ''
            'xEdit Backup Files:'
            ''
            '[GameMode]\Data\FO4Edit Backups'
            ''
            
              'Backups are saved with the file name [PluginName].[esm/esp/els].' +
              'backup.[Date Stamp} For example '
            
              'PluginName.esp.backup.2018_07_25_20_52_10. These can be renamed ' +
              'and copied to the Data folder.'
            ''
            'Show Only Master and Leafs:'
            ''
            
              'What this does is, similar to modgroups, reduce which records ar' +
              'e being show in the view treeview (and are taken into '
            'account for calculating conflict information).'
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
              'C will be shown. The assumption here being that whatever the '
            
              'contents of A or B, it'#39's already being taken into account by D a' +
              'nd/or E.'
            ''
            
              'This assumption is obviously only true if the author of mods D a' +
              'nd E did their job correctly, so this isn'#39't a good option to '
            
              'have always enabled. As long as that assumption holds true, it c' +
              'an declutter the reported conflicts significantly.'
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
      789CECBDF973DB489620FC7B45F87FC068BE0D4BD3920A17AFEAE9D9B565BBCA
      3B76B9D67255CD7CC58A0D9048926881001B00757485FFF77D476602200911B4
      0E53DDD91D65511490C7CB97EF3EFE1866C5C41906A198C44132756CB7330C92
      3CA27FC68BA9E376DCE172CC4F4CEC21FF9B17F96C128EC633CFE9D81DFE354E
      F9D72EFF3A8B6ABF8E227A17E7F0ECBEA33E4F04CCD81F16333117FA6FFAB7D5
      BF8E73FB8FE1244D8A6214C3077B08C38691359C64E93C488693F12CC87251C0
      F78BEC6FEE1FC37F1B2E8224CD8565BBF0FFAEEDD91DDB87FF5CF8E47FFE14CD
      456EFD28AEAC8FF8FA9F3FC390AE1E729E86225B1DD3A98FD983710634368EE9
      C39867E9328B4486A3FEF9F3B36F6044AF6191EEFA220194366C18FEEBC16271
      D0DEE7F39BF9288D696D4EB9DF248A6F1F68ED7F9F7F8D926908FFE53C96DFB0
      2CC7EB6E86DECA989F7F7A0F83BD8B7EC6E726415C58C3E781337CDEB173F7C3
      78F9427C56FB6F9A69E329E1E9F029E169B908D1603ECAA2C07A1F14335ABAD7
      D303E657519EDF3EE0848EC6A5A1D580710423D258BEB7C3796FF81F9C7792A7
      7190CBCDFA7EFBB56D1AEE5C4C5361FDFC9617D7D9E58C360DF7BFD421D17831
      0CF2D7340308C2B5BCEFBB43DB0F4795199C47C03098731655E67477430D6F33
      6A58EFA2E9AC907B1A55C76FBACC77A038702A51A2C6DFE9AEEC702AE50C3BE1
      D49D4EA59CB37B4F17569D473972EFFECFC3EF36116CAFCFA35A2BAF5967AFF9
      CDA6D5B878AE9BDFBCC914E518341D4CD76978F9FB4C880B9AB9D3749B9DAEDB
      F0F2A765C6AF365ED35EAFE1D5C31FC428135747FCBEDBF87E13B80E5F64C128
      1A1FC99D779A2E95D3EF368CF012F02E1AF3FC8D8CACEB35CDFF4B248A24802F
      05EFA1DB6DE202EACC1DABC2D8D579777B8DAFC9035F794D1F7677D0F4A63AED
      FA9BE549F7ECE637DD0D6FAA63EE398DEFC973AEBF573BE35EA354A40E79E5E5
      FA01F71A99AC3AE1FAEB95D3EDF9CDDBF536CDBC7AB44EBF7F3B89B0143DB37E
      157901336C9567FADB0944556651D8E2F5B79387FA7B37997C713B69A8BD5862
      8B37D84E186AAF12BAF03607DBAF65EDD5CAA97983ED97B2F6EEDAB1F94E13CF
      A8029999B5A2BE4E935C5885AF7CA524BBCEA0E1AD2A70F9AD12AEBE6B37BEE5
      AEBCA56EA0EF3A4DEF684AABDEA9DD3EDF6D926A4A12AB5FACDF3CDFF59A5EAD
      1C22BF5A393FDF6D1263ABE727675C3BBA5E2B6ACA6273C93A5BD152F552797C
      BD569454BE5739C07E2B3A2ADFD347D86F45C9E45B5580F65BD131F9621DA4BC
      CFFEF6FBA074070DD3FEF60B51BE73A3B6B8FD3EE8972AF01C6CBF10FAB592C8
      F883ED7742BF56BF1483ED97A27C53DF0A7A73FB9DD06F56CF70B0FD5294336E
      38C2C1364EF4BF5659D1BAD6D634C456D9B4364A133F6923A75607721A65C716
      326B6DA0462172ABFC5A1BA69165B59065D777D7C8C45A48B6AB6335AA5D6D64
      DCDA484DD2475B79774D5177B7980276919056F471B7DF9A8B93CAADB0B53646
      13415A67EB720C8DABD561BC464AB3C6E7799812536BC334929D35C6CFC3283C
      AD0DD24881D624011E64054B6B633552A535E1408E55C5D1DA489DD6B2028F54
      C1D0DA384DAC6A5D78902B5AC7CFAAD1C5FB62A2571BE50B89DECA30FE1793BC
      B57DF95F4EF46AC3DC85E8AD8E751792B7BEC13B11BDDA4877257A2B7636FFCB
      504AB188729C2F47AAEA30CD3698767CB41CE80B516A6D63CD36997648551BEB
      EE7CB41CEBCB516A7D8FF7805455D36AF7DEF96839747B3EAAF1B4F67E7B1EAA
      F0B3FA7AAF3DEFAC71CD7280F65CB3C4C7DA00ED39660D0F6B63B4E794AB3CB2
      1CA33D8FACE15D6D8CF6FC710DDFAAC6EFDE5DF86239CA5D9481EA40FDBB10B1
      DA4077E28BE5307756066AA3DD9188D5C6BA2B5F2C47BA2B09A38D8ED338CD8A
      51FCE76126427B38855349ECE1285E0A7BFD2BB7D3A97E09BFDEF6350F80BF6D
      1862E5EB95671B866898908770DC7EF54BF8F5B6AFED3F3FFB06BFC6DF370CB2
      F2B55DFFB21C64E3D77A90812BFF001FE80F03B7159C6D3CEC7FC33089F16C81
      A4C275871861310CA44B0DE32BF42F188A217FE958EAC545B0B060877F8BAD61
      1CD9C30CFECB0307D8541EBB9D01FC3B5FC68533BC8AC271112F826C7895050B
      782F80AF8741BE08E2C52CC00FC9720E8C2A5816E93008FFBACC8B0CE5761810
      D61AE33F51112C6CEBF33049FF065897CED342587F0CF3E22616F94C88E28FC7
      5BC4302B6280C5649C3BB8F96062C37F08BC4085B7C0428A8C1FB1156055E449
      25E88480BD0DD6C3F1348B427A2D5954464816388635CC13715DC02CF9DF2669
      360F80D5E78B2C4AB3A8B8B1AD1FF12B0CED8075E64E1D4423C72640E1BF23DC
      B403BFF1CF9D40952E0B008E88C5A588EDD6801B06230539109537430E163D1A
      D2DF3741EF02E41B907640176438DA0A86F66EF01B05B908D3C496A084A5E5B0
      E60BA7B311A6030B912ECBA370D00755DDEB5A331160D08BE54830BB0F0F66E7
      4BC00C80BA15CC08C84624BD27E0BA0AB8DD1D81EB4AE07A0F0F5CF74B80EBF6
      6E072EFCFDC181EB29E0F67604AEC78C00B6044305611815D1A580A773318F66
      51188A047E5926F0512C61C6CA988EF58A016BFD1464C114003DB3DEA4494103
      C2D68BDC71E09F2CBD0A87453629F25FA3B098BDF4E097054C143B765F7ECCCA
      8F9358FD7D52E84F23FD29C34FE3D122009A0E1F26FC61043B07F6C63F8B9B85
      80A7F24B911520D6C0A7511666EA672C7F8EE4CF4CFE0CA7B1FEA4BE9BC99F97
      D636FE02BB7D100EB317FCC5716E418767DF309BB13E05A358685CEA5471A989
      F2D77732A2804B24F89AB897688EC8C9F88D3FD3F1450D13D7B1FB074597AD33
      9058F5B2BADB9785B36E58167C8D24687539EE6ECB71EBCBE96D5F8EDBDBB81C
      FC7A6D31DE6E8BF1D462483EE83F0C71DD19D3FD5B30DDBF773A5A39532D03F4
      6B52D42AF4E6799A28C18A4F71D0788A13BBBE85653C1C4FDC95936B26B42BC7
      06742DC3635613BBF66E133BEE1A0AB79DFB4D1AC7E995086B6BC8DD07122AEF
      0D6760BB0F8235EBA2CD6D2472159892601EFE2A4647FA2CDDE6B374698F2B27
      8A91E4F8E5979EE80F9FDEBFB3CED250936CD76B5C41B48E50D10A12AF4B1CEE
      FAD5793D87B3CEA39C91C7AF218F4610141CAE074E17FE75FA9E0B3FDC1EF084
      E2DAEB767DF8E177FAC0E9AF3BFE001FE9FA0E3ED2F3308CFFBAEFFA3EBF8D8F
      001EF668187B30C0871C678062C635E8CE2E3EE6783D9F9EF3BB9DEE3DE3A53C
      B35BF1D2BE052F5D8597EEDDF0D2577CAAB32B6EFC94093ED342841A479AD9FA
      6E584A4BF2ABECAAB6B62DCBA93151B799A7AF226D6D09CD147E119F9434B699
      45AF8CBEBAC55BC71FEBF1FBB78B002BCC7FFBAD73D7A63B2FB23499FEF933CD
      18477951A0A4F6077DE4DFC57C1107858842D7EFC24582FBC67F258D6848FF26
      93B1EBE98F89FAFCD7B10DFB961FF142E0A709310BF94B5E0420868390CEBF2D
      82B1907F01515D2485FD07FF5600B60E9FDBCE7079E20D1CCFFA9F08219E6F39
      1F890C8806E5BAE41C4E10107645275E176F610FBEFCEB58EE0DC9814B77137E
      A0B1AAF5565A6EE412169BC0473832B5F9EDFB4A37EDC76DD88FE3FBF50DD117
      3032FE7CE02DB5D9106C5B1D953BD87C548EDDB037178973756FF4054C823FF7
      606F5B7686A4BB796FFDFECADEF00BDC1BFCDCFFBDDDB233F8176F7A756FF815
      EE0D7F3EE9BDF9DE0AF9A02F600AFC69910BE3C9EE0DB3516A7BA32F600AFCD9
      E6D44AF2BE7F7BEBAD5012FA02F7D6BB1F4AA2A9FBE3EFADEBAF5012FA02A6C0
      9F6A6FE866B36018FC0CCC7B30809BE8D89F37B2F613CCC9F3BC7EAFE73EC4A1
      FF833077DCF8179CF1D367EE44E4EE8EB6FBCEDCEF24B83C6DE67EABE042BCFC
      1F96B9AF082E75F6FE84F7B685B93F6DC1E5AECC7D8F05972F60EE8EEB0D3CAF
      EB761AB8BBDB0502DB77EC0A5C1400EE7CE64F89B7AB4DDFDF113F19DEDEDE16
      6178BBE1ED86B7EFF7DE0C6FFFE7E1ED1DD7EB0D6CBFDBC0DB075EC7775DD7EF
      3FC4A11BE66E98BB61EEFB4C480D7337CCFD29EDCD30F79A55DEB6DDBEE77B0D
      CCBD03FF73BA4EAF6F14F77BD8CA9361E7D50DA99D1B766ED8B961E74F716F86
      9DFFF3B0F3CEC0F3BC4EA7DFA0ABF71DAFE3F5ED8E6B74F5FB3EE327C3DC8DAE
      6E98BB61EE86B93F81BD19E65E65EEBE3BB0FB7EAFDFA8AB0F06FD7EC7364E76
      C3DB0D6F37BCDDF076C3DBF7786F86B7D778BBD7771CB7D369088F775CD7F65C
      1760631477C3DC0D7337CCDD3077C3DCF7776F86B9D798BBEF387ECF711AACF2
      1DA7D3EDF43BDD6A5ABB51DC0D6F37BCDDF076C3DB9FE2DE0C6FFFA7E1ED1DCF
      7606BEEBF71A3CEE1DDF735CDFEF99E878C3DC0D7337CCDD3077C3DCF7786F86
      B9D798BBEFF4BB7DD76B0AA7EBF8BD9E3FE8B8C62A6F98BB61EE86B91BE66E98
      FB1EEFCD30F71A73EF0CDC8E637B4D2E77AFD3EF777A76DF3077C3DC0D7337CC
      DD3077C3DCF7786F86B9D7987BAFEF753B5D7BD0A0B9FB5EBFE374BB9E6D98BB
      61EE86B91BE66E98BB61EEFBBB37C3DCABCCBDEBB803DB1D749B6AC977DC7EA7
      E30F5CC3DC0D7337CCDD3077C3DC0D73DFE3BD19E65E63EEBEDF71ECBED31050
      E70E7A7DD7B6FBD536312658DEF076C3DB0D6F37BCFD29EECDF0F67F1EDEDE71
      6DB767F7DC06C5DDE90FBC4EDFEB9A6079C3DC0D7337CCDD3077C3DCF7786F86
      B9D7987BD71FF8DEC06EEA13E3DA5EDFB73BCEC07077C3DD0D7737DCDD7077C3
      DDF7786F86BBD7B97BC7EEF77A7E538757C7713111AE639BD2F286BB1BEE6EB8
      BBE1EE86BBEFF1DE0C77AF71F79EDF73DDBEDF6098771CBFDB1B743B8E51DD0D
      7337CCDD3077C3DC0D73DFE3BD19E65E65EE3D1B8ED4F6FCA62A367EBF6B7B83
      8EE91B6378BBE1ED86B71BDE6E78FB1EEFCDF0F61A6F777D077877A7D1E9DEF7
      9C810DC31BC5DD3077C3DC0D7337CCDD30F7FDDD9B61EE55E6DEB707FD4EAFE3
      3676731F786EC773EC06E66E9790B177054B2B48B8F09F7DBA0A0504116C212B
      E2F16C3819E78E350C260089B8C8F88BBBF0F98D7B2A4FFDDE0F1BB7E8DC6D8B
      5FC0FA773939CDDDEFB84BF76EBBFC0221E02EF8F925E20DEED2BBE32E771707
      EE69978D7BA4BBBFB24BFF6EBBFC02C1E0A177B92ACEE12E3B77DB254904BB89
      088FB84BB9C7EEDA1E599A6DBDCB2DE2C27EECB2D7F624F1AE6FDCE5EE82C3E3
      EFB27F377C45396145A86D21423876AFE3F41DAFC1B1DF19B8BD7ECFE93E01E3
      00EA320F661EB887AD3C903DE0DE5C318F26E9DE9F3DE00105BBA7610F40003C
      DADEF6C51EA04EFDBE2D02FB6C0FB88B8DEA0B58FC3E51925B6D5477B608EC2D
      95FC3276EE759D7EAFE335C4E975FCC1A06F03BF37ECFC7E8FF83E79FB93B6D0
      DD99B7EFB185EEC179FB7D986A9E206F7F68FF93E1ED7B4B490C6FDF81B7F7ED
      9EDFB5BB0D85EF9C7EC7EBF61DD736BABA61EE86B91BE66E98FB3E1010C3DC0D
      736FC1DC07AED373FD4EB7B1F25DA7D7B3DD8EEDDA86BBDF792BC6126F2CF1C6
      126F2CF186A11B86FE600CBD637B1DDF719A32E6BB6E8FB475D7F0F3FB3D63A3
      AD1B6DDD68EB465B37CCDD30F70763EE0307F6EDFB0DDD63E18F7E174EDDF50D
      7337CCDD3077C3DC0D73DF03026298BB61EEAD987BCF1974075DA7C914EF3BAE
      D7ED799E89A233DCDD7077C3DD0D77DF070262B8BBE1EE2DB8BB63DBDD5EBFD7
      F51A0BD5DB9EDDEFF69D8E51DE0D7B37ECDDB077C3DEF7818018F66ED87B2BF6
      EED86EA7D3E937B2F781E3028BF78DDFDD7077C3DD0D7737DC7D1F0888E1EE86
      BBB7E2EEBED375079D6E43395BCF715DD7EB3A86B91BE66E98BB61EE86B9EF03
      0131CCDD30F756CCBDD3F51C7FE0353077A7E3793DD0EE6D930267B8BBE1EE86
      BB1BEEBE0F04C47077C3DD5B71F781DDB7071DA7A17CCD89EB7803CF75FA0313
      5667D8BB61EF86BD1BF6BE0F04C4B077C3DEDBB077C71978B6E73B7E137BEF74
      7CDFF58C65DE3077C3DC0D7337CC7D1F088861EE86B9B762EE3E56A71B741BF2
      DD4F1CD7EBF4BD6EAF63D8BB61EF86BD1BF66ED8FB3E1010C3DE0D7B6FC3DE5D
      67E07B3DDB6BE823EBDA3DDBE97A7DCF38DE0D7737DCDD7077C3DDF7818018EE
      6EB87B2BEEEEFAFD5EDFB61BC2EA4E3C50DE7BF6C0F47835DCDD7077C3DD0D77
      DF0B0262B8BBE1EEADB87BD776F03A3699E607DE60009ABD67AAD918EE6EB8BB
      E1EE86BBEF030131DCDD70F736DC1D3473BFEBBB4E0377F7BB9E37F03B1D6398
      37CCDD3077C3DC0D73DF07026298BB61EEAD987BDFE9F57B8EDB5068DE713ABD
      81D71B18E66E98BB61EE86B91BE6BE0F04C43077C3DCDB3077DF1EF4BAD848A6
      291FCEF1BBA0B83B7D13326FD8BB61EF86BD1BF6BE0F04C4B077C3DE5BB1F78E
      D719B8DD4E53BABBD3F17B7DC7E99B8477C3DE0D7B37ECDDB0F7BD202086BD1B
      F6DE86BD77DC6EBF6777ED868CB813C70384EE78A6C1BBE1EE86BB1BEE6EB8FB
      5E1010C3DD0D776FC3DDBB3D6C1303DCBB2923AEDB77FB834EDF7077C3DD0D77
      37DCDD70F77D202086BB1BEEDE8ABBF71DAFE3FA1DBB81BBF7BB6EA7DBE9F58C
      65DE7077C3DD0D7737DC7D1F0888E1EE86BBB7E4EE1DDFED3559E6E18FBEED0E
      6CCF54B331DCDD7077C3DD0D77DF070262B8BBE1EE6DB87BCFB3BB8EDFED37E8
      EE6EA7E7F4FB03DFB48833CCDD3077C3DC0D73DF07026298BB61EEAD987BA747
      D56CBCCDCC1DB5FA816D1BBBBC61EE86B91BE66E98FB5E1010C3DC0D736FC3DC
      FB4EC7EBB99D7E03733FF11CDF76ECEEC0C4D4DD7D2BF7C9D02B7B50A4EEE9A0
      EA9D19BADE59C9D9F7666F0FCDD0EB3B4300FC5330F4EACED4A91B866E18BA61
      E82B0CBDD7ED76DC9EE33698E2FB2EB0D37EDFF8D9EFF98C8DB66EB475A3AD1B
      6DDD3077C3DC1F8CB90F3A9D81EFB8DDA60CB8EEA0EB77BD81671CED86BB1BEE
      6EB8BBE1EEFB40400C7737DCBD15771F0CDCAED3B31BA2E83C50EB7B7EDF98E2
      0D7337CCDD3077C3DCF7828018E66E987B0BE6EEDA03DFB607B6D794DEDEF3DC
      6E6FD0ED9AB63186BB1BEE6EB8BBE1EEFB40400C7737DCBD0D7777BC8167BB5E
      53185DBFEBF50683BE6DBCEE86B91BE66E98BB61EEFB40400C7337CCBD1573F7
      FD9EE73903E733FCFDDFE8DBF4526459140A1823167FD4BE926FF55C1F84824E
      A75BFBE3385DC25E8671AE9AC7AEBCE5D803BB6F0F3A4E6FF36BEEE6D7BA3DBF
      E7BA7DDFDDFC96A779DBEA7BBEDF71EC7ED36C7EC3227521DECDAF751A5EF33A
      9447E80C36BFD66D78CD05D9CAEBBA9DCD6FF536BFD5F16C67E0BB7E0F89DCA6
      F7FA0DB3E98488CDAF0D1A5ED349920DC76D37BCE73820387ABED3004AA7014F
      BA1DD7767B76AFE1C01DB7E9C4CB06870D6F7A4D8869777BFD5ED76B3806A701
      57FA8EDDEB00509BE0D2802B6E07CEDCEB74FA0DAF35E04A79559B8EDD69C297
      CEC085ABE0D90DAF35A0CB60E0004DF4FD0694761AD0A5EBB803DB1D741B6673
      1BB1C57780AE0CBA0DD3B94EE3B1EBB0E086371B084B1971D4F05E03BAF85EDF
      71DC4EA769834D9445BB401BDE6B242DAA2777D3B9BB0D18E3FB00D49EE33420
      9ADB802E653DB386F79AC88B6E40D6F05E137DB13B5DCFF1075EC3B5F5ECA693
      EFF4FA5EB7D3B51B50C66B2030A546DBF05E13C2D88E0DE7DEE937D009AF0161
      062E6276A7DBC4C11A100690DAEE03E5ED349DBBD78431AEEBF77B7DA06A0DEF
      3571235DA6B6E1BD268471BBB683327DD33934218C2EADD3F0DEA0F1CAEB6638
      0DCCBD81C8C0E5F36D60494DAF3571A4AE3FF0BD41133CFD067C01E404DAD4F1
      1ACEDD6F4017D7B6DDBEE77BDDA673F71B1066D0B1BD0EDCF9A6F91AD005144D
      60EFC0021B5E6BE247DAEBD3F05E03B68008D8EFF43A6ED319F41B6FBBEFF4BB
      7DB8B60D2F369217DFE9BA834EB7E1F43A4D0CA9E37ABD81ED37BDD6802B8301
      0A2083AED3F05A136D01D1D1F77AB6D76F3AF54E13BA0C80D702656A78AB0157
      7C60D27DBFD76FDA5D87F5814C5C16A3D8FAE3E7E42249AF923FF3B78BE982BE
      C50FC308FE718751112C7009F63083FFF211FC172060D51376C3133C4B1E8538
      207DE8F641C80164C4CF3DD8DC804082BF01DE782E7009FC0CFCA2E77B547273
      3E0F8AD94F19FF7C932685E70FE7A3ECE26504AA99FC70BE84F9E6F93C88E337
      5900CADB3C8CF2C52B317186F3F87D904DE9D94C7F0AC5E47F8FE16F5759B078
      4B4A1AD9D3E65152BC8BE6F02109B21BF88448102593F48F61B02C666966BD8E
      E199BC10D98B9FE14FE9426441015F7F82BFC1B789F53A99C622833F8D33014A
      E17C7893B93670E879EA38C3F0C6ED0D67998BF3B84CFCF000363FE5E1533E02
      000E2F8FD204314B84383D624A924E16C154307AC32F5769168204ECF8F28FE3
      5990E53D7FE0DA95DFAF72E01B7D396632F0F878AEE7316C890E9C3E3AD6AC28
      16DF7DFB6D3E9E8979909FCEA37196E6E9A4381DA7F36FD3C9241A8B6F71C26F
      819679F4691E7F46C57C110044AE4031005A4A9F67C074E046CF01F03183183E
      65FA53A13F8DE8D37459006C018D8A2C17E3020DBA5751985E8D8B2C1E4E8A64
      F4D7612092304CC7C302CEF9620E989DDBFC799266802145944C018669921602
      94EA30BFC92780330E403ABE4993CB796C57FE0ACAF3340C8A0066CE26302A28
      E34901035E067104DF0B808733CC67E9D52206AD7E96C6212AF180ECD324CDC4
      3CBA16E1184647251FD0FD524409BD798DB3E06BF0016E1EE0860367701DC3F2
      D21B91C0AEC4F5229F6545025F2F61B371BE180FC3040E21C947E108BE253302
      6C6909FB868DE5B300EE3660D9DF71EFE1744E980C1F66F4A0033C369C5E563E
      C3A3D194CDC3F897DA6F335C9A432FE007B42AC07A82241C5E46E2EA224A4287
      3EE5E3201630DA623ACAC26C2682507E9CA46931CC17F14D71954489C093D19F
      67C51CEE4ABE803DC4C9AC08C2BFC2AE86CB5CC4C528889321FC075FC01C4378
      052618C36F57F40B7CC88A69368C13B8D4B0710143C0A7AB0CA9D1304F824591
      4E818C45C958C4310C14A7579348C4707D43187E080F2E96C9186D63411E057A
      14A42719AC58D197445CC1807971037FCD618E69965EC192D34954E03A130477
      71035047D2097F87B52640678A7C3811B836118B4BF87A7C9D2FC88602142284
      13BCC2EF059E683019C385C24507137A780958190F67F404C2AD008A1964F064
      31BE0C0854052C165F9A64080FFCE23228AE47D7C38B2C596479228AE13880EB
      08E81603182DC49B086EE322282C5856612331F9B7E115A0F1645E4CA218AE91
      451D09F0F203295A66A298656951C4C21946F1249D07E3A018C7C972D1E9E07D
      83055943BC74A1A5AE1F50F3445CDB433C7991DDA0C680272F3FC24AF26BFC00
      E04F662213F436BE828784462B1A4D4C02C0F0311C20DD5F8B184C027F8A2FE1
      6E2D92E5389BE3176851C3DFD96686DE9A45320B9229B2A1A4B82E02EB547227
      F9B28BF4065E87C57ED1FB1E7C0296F845EFFAF0296E3FF351FDED4EFB9947D6
      E1E7A661BA0480D6CBB86DA81E0DD4EE206E1BA77F5F0B1AB45910E2FCC69180
      F76440ABE2204A2C89DBC3BFC1A529A513C746824DFF8EF0EE03950FF827F01B
      C0627C03850389BE40501641BC9805F82159CE87137A7A982E09E1C9886B0F81
      D62DF30228EDAC806912B2CD2AC108060C2A420EC842453C9E0D276360B74026
      E0E549EEBA40D46063A886D2BAF901F66BE25FF18F201439F46122E039109653
      782A98784E0778EE2CAAFC128EF42F9DE1182F25BD972C2A43240B1C044EA4B6
      9C915A91DFAFAD63381A4E7C7F88DF0F012AB3E1058811C04281A882585295E1
      50DCA86D57AE0CDEAE2D8B560FDFC2167F9D05C5F3DC02EA6CC1B15DBF0EA3C2
      F24EBDD39EF5F2F5A717FF93A48BCCE2B37DBC5375763AD52638220436C11120
      4570DC023DD8FB36F8BD5C4E27208EE48F08A63B0046E2BB5F870AC3C4F5EF01
      993ECD84C51E1B404F2B138B342B44684579BE14B9350351CD1A0990D71166E1
      771268AC49919BA624209A37AE6C6065E9321061DBCAD56DAD2F9CF633F1ACE1
      F3516F0832C5E70DC7570B6C687D8E2B1E237CB7C5C9C6F966B4C7D7F7E37C0F
      F591A68905BADE18749023EBC47A118278383DB6CEE18FF401A45AEB2C160192
      29EB7D80AA5B6E8D83C482EF42AB482D14FF2D783D5B2E0AD0B2ACC39FE02FB9
      B040D81A5F5820645AF334043132B7AE50C8B16ED2A5350779081E000A0A5FC3
      187339EE5554CC886675FFE55FFEE568EFB0EA0E7095C4F94720CE9F3E9C5961
      0A1B0721152875544400A41B0B550982230A813748C20BB883FABD16735F59B0
      482B9AD08B38CB5590C3314D0A0BF4ECC45A80AE1CA5CB1C06C743C5870E5EA5
      C9F382A70EA6C8ED974911C5F268C2033EC4517A0D179F3F230D5859D995F506
      247E0B04E94506BA4030B748E2F87C1794B6EEFDEC9541441FBEFAA23D4DF9A2
      0DDD32EF9763D3F9F96B62EF1A8D4ABC41BB4D1CDC58BFB0D1C33A03F53A4B63
      EB6D32492D07687A06D41CC791B70DCF4E3D4B86D3FBD8E3CA291A9963F301BF
      61BD32DF3B42F7D5D9A7BBE7ECF3E08CB81BDEA6D7649F3A806B788504F0320A
      E14E8E04DAE198208A3CB7D0068AD635B865A75FE952ECA65E3DB842D3E27A34
      29345DA3D0B480DE2734AD59E9643B3A9FB1053627742ED9BAD184B42684C2D4
      685914C023A5F453A40B16AD80952670D3D3C946A1E83088F314055F60DF6983
      F40407754412F54858CB5C90504D12199CC60CA889159467A98E4A13915568B8
      048D55EEE0B7640F0A1ADE466878D6AB74890B398BA3F1C59DE4BBDD0F02A151
      9F12CDD40FBCDFD700EDEC9137FAEC1B852324C247A040E56390E062FA2E0722
      344681906DCAF028600BFA1A14466CA7AA5108F4653BB84B3502647FBEA08485
      24350616489911F2B8D6F39E174121ACC3CB288F089933145C8F4815B9C225AD
      CC88DEA090FE0A0CB44833F885AE113E42570BAF48CE5ACBD762A94F8515BCC2
      C5A2AFD59A8330124C81CE2CD03B171A12AF497CBE106350C4417F0AE2746A05
      1394DF10D914C80AA0D8A4518BEB71BCCCA34B6402F4441CE4058924D62CC8D9
      2C9609F4AC86AD2F07ACA00D61908B435113A70A3628F0C8C303B82A512C4AF5
      FD14F80DAC4A6AF0C7B46A39161118542181FBE03049CD1010A0F40580902E74
      BCA32C87492A200D051A481A00E8E40FE21827830539BE150637D26E28AE1751
      265A83062EBBF553003A6C92F3C2AB36898D068CAD43562D1C4861683F008634
      5176181E4B139CEAF6E49BBB1CAD7E9F66D1800E23A9B3EB793EB0098DE81B5A
      5CE234974490AC356F9FCF01E60C0C042B6C3ECD2A461A0D7D752CA874004494
      E506F0557EDC69F5A891D2D880D50016180887943364E9D631E62BB7041DC041
      DE1E03A441512A57D64488701480F69532D018215FB17544F1CE7FD54FE14A81
      5EA35D0C4D8FC52C4A2E00A437CC6F90D3CCD2651CE2B1A84D8D307040D03872
      AD38D78FE27A99BF4FC3DCB09BDBCFEB87E554A005738E2706E004C643DA6F32
      16449E0ECE30B647005B8A0B42E7F1ECC07022E644D15C00C915215F5E8BA3A0
      12E0475648D05A20B4E84F889DDD8EFDFEA5754E513737E7D1F5A9C8E7552614
      2EC77C47E71686B0599857368F92652172EBD0B12DC0FC2C3F42BA108C00D3AC
      8EFAAB41F1DB4FCA780B8DB7F01ECD9DDE9E9B3B9BFC106C178962F41996CE88
      AB3423E6FC2B6C61EFCEFA0EBB25A11A058C83372070BC886310BDD278394FA4
      023B4F43718CC264C47058A439EBBAE4E14C96E4E68B12A4E9394B175AF1E571
      F6CF11700768FDF0F6D3FBD7C06650987DFBCAFA291370FBE1DBE94C60BC6F90
      486F321A59B248001B02C87EFFF1E79F40521C89B8EE6406490200397F82005A
      074F0B983204CF303C11E4D07365F3D9E0355E4A4C920E40788710F2578D904F
      0F62CD28F5124356E1AB1FA2A4508ECEDC3A0B586B42850D14A3A985F1CADFC2
      8D02E186552BD0D6E1EB3110D8947491F91EBADCBE00911828BF04197AF599D9
      B25E7EFD6A395FF0D6B36542911BF04E00EC37663B460B0947113144AE29E644
      738CC6D3835B333AE5E99C95DBDCC26B360601389D4C108F580FCF5911273806
      6802B941820DDAFB0D40624E6846964A51FC2341E55A4716A0652588AFF08E4D
      A224E4481F504066D530954969EA51BA37A10B8883E1534497C349BA84BD8E6E
      40E1925653A2C5710B9046E30BBC6B64C9F9CF1587D17B0A8292B45C1B793445
      97701E091296C9D28F5004556E810E641CF6917D3DED7D1F185DDB52D67C7AF8
      00176533465C8D3E4C2670F75FC1AD00AE9B9F616E18883328B68C03E4CB195A
      93641C1C6AEC3A0E0E693469043774A79E1E501A40B24CD86B53A0152342685C
      06B1C526B6ABA48D5ECD0C9CCCB83CD40C593DDC16A6B92014A6C9249A2E3369
      1F71DC19CF26A581A707CA46FC0A8152148A9C90F1F4F02FF819381572AB24B5
      52FC0DE466C0AB69962E17A52D3F140110994B34B2C11F2DFAEB63DA2A9EA249
      E7677289C9EB5A35F71A1B0FA1A9F2FB008AE15A3198694C2A8834EF92374891
      BA9ADF68EBE0E8CD5807780BDF4494ABC0896299A163025469A2AE95E0D67251
      7A02E9FE3CB0D24535226BEB846F2716CCC62F9357FC328862748A1FC3864752
      39218A5577F4C0F596CEC47209523A40D286D1B2BBAC814F02E74F2C34FDA2D1
      362D7D7487E2747A6AF9A7F6E9F531FC70F1C7E9E9E9110BB2FC26CCD9460D2D
      2499C5A54FA20C681011DB43E51D8D943BEC081FD1A021904BADE3FBA8F86139
      C2394BA5158835422DB40E010AAB27A8252629841F195BF4966B102D72E3D05F
      8FD942B0488FF64A687AC5222DE146AEFCE042703C4D30A6447F9DA140E90AF0
      3D5DBC9D5CA7B40860D5DBB507907B048666FF6D1949D723482F224B408022B5
      1DA7C6D14E8BEB823CC22C045C01DDE1B032198C20AE85B930B783FA23C5BF83
      9034219294EEA1DDF5AB7B24FC3DF7486C4C6F2093D59585753A940315F38FD0
      1E91D39D913163F963EBD237F0BF93F9FC240CAD9F73917D675D5B5835E3FA3B
      EBE6BE35EC1686BD09E908B60944DF25107DEB439B22D53B2652DD8427DE8B34
      13AEC14887794860B5974B80502697515189A4E2E80F405A16F6818E22DE1EEB
      C0B895D840523AD0F2CB019195C4427E0A44919B74B95384DF2A198C9AE01ADD
      1F64F5462B515E713B82BC8BC1732B41C6B03405E62047698EF4ABAB0093F418
      CC658C5AF51C120CCC238D0C991B0E8342E13425AB515A0EC70E540A9EC3C0B7
      31483C45B6440B510507282F17F19FA5638512CFC9E6C6F9216946D668AED7CB
      CAEB5A009E113E6F3F6D1339F4259143DB2F91092DDA2CC877F65C906F724392
      EE8D3821E347D28915C8CCE5D26B46B1DA894CB6828764D03A59A7F2E0920227
      65064940F50CF60E3FBED8EDFFDB9B0FFEEFD69B1F5FBCA7B899771F5EA2FA43
      FE937F9C4D5E4659B10C62EBE0D7348B43AACE766001BD9F0BF60A61979514F0
      F7868D251146CC8A386E4186D9704CF8236BCE59F0EF5248E4D9807DBF7E7CF7
      4A22E0D303F06D85297480CC59BAB841E55855BBB40EC9968EBF5E65115E9FA3
      63EBE0C714E5098A7EAB47FC554B0B4CE2608A91F4301AF9B1C4138459638914
      C2900AC8C8F67688844647FCA52D5010BD77561E0182B39D9B64A95F22C1653C
      E6C18D7508373BA3D014104EE10110E84671905CFCE3C0F20DE009A0485A6211
      6CF9E7642F6D725FEECA3D135981F23A909BAC182F4192A6AD723C29B977534E
      E644C70C39D858365779413752FE4F9E3FC148A306987C84FB92CEAD17BF2876
      DD02BCCCD1092A981A55F273A36C34E4DC8A00862719E8FF4F01DA808326BF7F
      05A95E58394349A0168BA0FA3B828A4AE28E003EA5AF280843E929AA27F023CD
      2E13A11FD9B4FCE2DD27EB4FD6F93F4336FED9A78FEF60AF6F1E7BAF9374BCCC
      65F6BDC694D6D62DBA78D2C73D666F05BABE49B47A645C9100B48FAD3F515AEE
      C97D3B1FBED21D78E33D364A9499C12DA830B27ECAA18D72C62538FE0B21D03D
      4DF8844C8D72F428907F9965A8DDC0CF1CED6DC0E66A5583F63508F45E0B6068
      F05649F32ED0536053D5F0E438B76432D385203341AE435E3858A06188953C70
      2382348820C83EA31606BC1F82F968996110C47B912C8D70C275C6107C07CAB1
      ADE3CD5488541D6606156F07E7C1399A7B7E9691C5984474801667EC4C503AB1
      AC8317B03F8BE1CEF1810617657D6920CA9B60B85E1B54E5CF1C020526C58F36
      2D8304999ECA3066F447A9586F156E45992398A794584E99AFAE232CDB30100A
      C28CD0418AEC61350AB37E6D8E2D6AF92223ADD56230E88A834670C371CA7FBE
      A9868EF193AD0541AA9AA5A629A344C9064933E768EAC4316595A7886C2558A5
      E5CBE6F8EDBF7E5707C261F499457D37F0EFD2D7EB74602E904A3126966CE711
      25D6058B0570BB9C82318BE72D8CA9085FDE4D92A67F177A78DB141468479BCE
      8A2C06D19CCE0FC14E76C01FB8C617081BFF1B13FA3EA54F84123DAC4CFAEC9B
      2AB01E5DF14DEA765A794632089EF9B43C2D7E3628A455DC5C81DB412B6B6601
      75CE420AE03B0D83E28960FC43F3DED72A16B8061CC5A4381D28AE851087A714
      804C399B527CC47637515C060B6F9DB7164DBC3D3381386EB5E8817624156A25
      680061C54B32269800250414C2B8CCCDF08FEF83B9F811FE1B7E3E2D77FB410E
      45DB1E895C8D6AC29D5B452F4A4B651D030076E67AC92814C0DC0A9CC274BC24
      1F73C3CD61BC45E1B0BC77E4C3094B53840EDFBF8271F3647B7DBFABD3AC9898
      98DCDDB07A2DE4D63721B7260ACDD4AF7ADC20B3EE5E0799FD6B67E05B27D6C1
      BB741CC41168A78B78398D92036B82DD0EC94A9C5BA32CBDC0CE927B77B8772A
      7042416FBABD0E7AA1D80A32961109E328034E9717589B11ADE2391C33D2D34A
      3F9F742283A09E604486024C0B18AEC22EA04648DF9252821F36C13216AA58C7
      6D816AB98E303BACF56B01F862A007BE86B2F1D36C77B439B8E35D904C9798A4
      501AB26439A1E00AB515C0A953A416C934973A0CE0DCE9280FBE3D1D05AE456E
      9DCBA758A4A911223F7F7AD3B74402CA0CF9AB529417991A85968204D6FD443B
      E72488630AC99F0B348946F91C6DA6EA29D6F60A8B510AC77D7A606A00522626
      6539C1658E99B75887770E7730BB61837022C698FF923DC14A1F0D9B96EE452E
      0E535E9836566E2ABB80247A21A8C8D78CAA93075498294D4005498AEC4655B8
      2EADF4C732A3E40AD3C6D1BAA82B443F3DA0365EB828C13497089B8A8F232630
      5C272F8E8305868E7DCB2D9BC9587EB390B6FE0AC996745D9AF90EA3F982FFC6
      A92FF87028F2711631971CC1CC572A15EB0992F27FC5D2C027D647E2976C89D9
      8E82CB38969A57B058E8FA1320198EB0F29751C16E05DE1BF4662D0BABD7B5F2
      E502C16E9431BAD0DF63CDEBB27596CE73C42A0CA71878AEA3CC4931C3505A2A
      3F5BA6F3A3CDE614707922328145C7354FD16389840B9094B491DA77556C9793
      25562A41A3CE6A7D6D2EDF457FA681916DAD4E84CFE0E162F3FAED86EFBC7DAA
      E41AD2E0DAA7221119555601D085372A447191A2D78F3C104172830CA14C230C
      E436B14E1900A04033567A81953236EC16679C2FC7334EC24199445672C7EDE9
      8C54CA0F1C67413E13ED37F41286CEA369124D2290A861A173AABC81757C3044
      9AE374723E908C22E6B18E6CA28AF3AF1672808D6E9D124E1CFB6047931B66BC
      E8824633D2C1CFC9056001E88594099233E456C23F8DB1F976E04A2BF31C2F16
      2EDEC2A5CD05AA4C86BCB1ADE92A25746B80D22AC27D89B569B3FFF51FCCE6D4
      BBA3CDE9619DD427B84AE41E8DFE69D8F7C378A84FAC5F551D401D5BB2567D54
      B5390204442032A3AB366B66B681113A9C8B823591B25066969301AD05AE2754
      AEE8145D83D4082FBFC07A487241DF53CDC2724954D4A856590E1795D3AA58D9
      552F7D8961E051EEC4630742109661791BC0FC478F8438B1DE824E84BAD523EF
      5BDFAD67DF3CF29E4FF96AD5B15497DA44C7F53BEC2E04CA63297C62117694AB
      C8279884AACDDDCB607C817539E19B7794FD65248BDB617FA0A3F60E4C847035
      7DE9A01ECE78005AC8F6DC53AC3DA9B5A15A62534367D33935448B9210552BF2
      97AB0A960B8172376801C99275A34319851FDF704E6BE95913DCEAC178D0D6A4
      99FE5E7BD0A4E72CA84443EFCFD96D5DBDA6CB87D14415B07982263A19546DE8
      1ED1BDF7EC19009A135161702DAF2E13E5238880391FFE4516C4062A15CA92B4
      54CFE8BAA0863361342146BD9D62AAD768D29CF2F3A7027EA39845A29D401379
      416C3B9E2C8B6566A2D3B6053E8378B44057A10E16E4CA0AAF2AC67500E81B4C
      95E7585B730174CCCA58018F32D6B220C9E380BB342B6FE1612E84744EE033A5
      A98C5B8E5301590DFB5024D560CC42F5FE7C64F9FEDFC78BEFAEE17FFFF1F8BA
      33B684B9A2E4147989AB3E9EB4EAA93B7D6CA820443EFF013B7F54254F262E3F
      F25E97C5A4BF21BDFCE173DAD116CCB6067DB5D89D756C5155F5478683E376DC
      473FF353BD77D9AA2446370C79DF7DE097D3A8003EB7DC5EAFA320E702767043
      6262E7BB809072CEEF919CD803CF6E26275F0447C3D86F3FFE73519023B9C6A3
      62151884D570F8018E00324C9D98FA7A0E054049062E483052023CF7D8D0D03C
      4487027CA5F8B8EA184C702843D251D56161E008F93C30B26872A3387DED3840
      6EE03AA3B975F033C963B53F7F77C0FCB1450689760EA2B95975BB38DAA5887E
      46BD36B44D0143EE7F7EABDD9FAA62ED31DA23366C443230B45270D649C0320D
      961420821FC2378F6EB8FD6DBC50F2EEEF8F6DB7CDA5BD5D42868D3FDC9E2A9A
      44023D52178260FADDF65B59DEBCE27AE074E15FA7EFB9F0C3EDF97DF8E175BB
      3EFCF03B7D1B7E74FC013ED2F51D7CA4E7B9F848DFF57D7E1B1F81EBDDA361EC
      C1001F729C818D4F392E3C873FBD9E4FCFF9DD4EF741AFFB2354B4A9A2C1EA8D
      687A472453B8C7B3BFA08CD4F69D0BD8F3344DFED285FF194AABD5A77C21C68C
      F25CFB71BE24FAF8F5A5DD47D83F49BBABB2EEE115BEF8D8FB47AC7CFCFD47D8
      DFF298ED4658C59CDCA0D851E93AC050BF9D58540593342CB953D664825D7951
      ADA03A13162B9741F958841532B3E852A58E299E6EC4CB6D76A37A736443D634
      595BEB1B5DB55CCAA06034FC7008308A4CACE35223722D66E5EAED6CBB94C7E1
      788FDF57E5D9376B7B3DBC3EFAC7D0F3FE7152323D9392D9027A6FE7D8A301C5
      6F9D3C63C2826B0E1F0A61E274215DA18D410450E3264F799172F7B428D326F0
      323AF6C58FE76FB12611961C2804D6ECC060D62C00C2911DA9E7A5775B965190
      8E25D6C0A9E975455A9A078B05EAC623515CA11F1D066BB1119E8FF30D78A5B4
      1A0E3A3D42810055FC53EB2755914A06D6E7489FF956CD8290FB91C7D13CC2DD
      57B5E1603C961DA3E75590D13EC2088B0893614EF79826A8E84D05B2D225F738
      AFFF4D1AC02973493ED15A4AE28597E9F2392654DC7096CFC609B797559C0A56
      FAB101B90088D05852121BEB642B46169DF01807393E96EA84AAD3BDF3047FF5
      6084C15E07233CFBE67BBED1FA869FA00C9E73413119BB4D360C32002548188E
      2B0D9430F016737C8EB945359668A0674A177202CF66D665A48D70144D1F0737
      6594D6FE60CB5678FDF2FEC52B4CA780BD1711A33E263C01F4DA102BF2990351
      C9B2E0A6BC351AE4D831095426342CC2ED3ABFB8C9A23951B63800D8520D9A1B
      82A93A2BA2D0BAFC4B8542A9BB8C864BAAC746696CCA3F8F3ADA0DD78F4BB970
      FEBEDEDEB6C13495C4CF2AFEAEC34917126914AED7DCA1F7245EAB1CDD472FB8
      4C0C8B8AC0060A45A2BCCC987D82870E9AD926F7FCED27BF7243248192944871
      63147C64E32E8C4721978138A5A66A1F467104224472ACF386BC63BA9CEA57AA
      5EDE263B7E1AE4682AA92F151625E210534E1771348EF0BACE83EC82DB7EE498
      2F14551B84AD67EBF02A2B44839A861F73280D058C03158897212567DEA8F3AF
      00D03A544063338EEA555783E0F6FBF3509EC77DBD3F472B49C751DEA64D1DA5
      EF53BD82F866FD2EFEB3AB27AB3209D5EB8D8169D5EE070ADE5A9C46EFBE7548
      122F964C009667BD3D3AADB5B5AF04E67058D46387DA8F1727527FFAEEDFD5C2
      FFE3F14333D86CFAE871489B373C7C84402440011191A0B3AFCE887BED494CCE
      8895901B4A1B9219AB499ACD89EEB0683E126521887AA1C1AD53C1E56AADB3AE
      4ACE940EB576A725B7019E87C5384E4B973528BB24B4D60A21C2F494C3BC6AB9
      28C7451B03B35ACDDCA897279510217F35F04216824B670341A9ACDF4389B9ED
      37BA2E9272E6178218BE1C0539D71622ED5F99A75069DA7EB2051B051758495F
      4A2CC89EF065F5FBFD62788595ED255FDEA92DAE948D0E91F79EBF3E3A5EC9A7
      A89D051F1A4A59D304CFD26459AC19369CCD46F57DB16C48D73E4803281AECDD
      F16D5DFF0433DE9EEEF21769097DFBE92D7FFC77317EBAAB0FB1D0D5D3C51DD0
      699FF4FAA70204ACE4E92E3F13E28257EF3DBDD503EF892380FED6079FEAF1FC
      355804094AB4274FB4601DE81F57621A3DE11B82CAC672BAE443789A5B00A9EE
      49D3D8FC4A844F79FDC532BBD0EBF79FDEFAB3659EEB2BEC3CBDF563AFBB9288
      FEF9E96D60B64CA641A68FE0094AA9A01E8EA2312FDF4452B3E59BEC14E7AF8D
      6DE28EB689CD816A7B6D9B30A89F695FAA5FF3ACF6BAE63EDCF13EB87B7E1FCC
      55580D3CD785CB31E26EC9D53435DEE756A4BD1CEC283924AEF1E6832F83123E
      F4BAEA01F49392BF63C249D9C5AC450BD9A925AEC76251285A757AD4D6D4CE01
      0A57EBB5BD54A0E45AECE7C60AEEC716D64E2DBB1797D9AE3908FF51319EA19F
      A800413429A2B9AA74A1432A65819D5AB8FE4E5928F57210E442E25080756F32
      859C8EB1D22EE78AD28414644229DFF0728B4442F4E1902347068DFE533972CA
      84530C3049A8F4F5E303A04C207C6C18C8A8DBD387288CD062E7EC19FBBFAFE5
      55FF6A70E0367B7473A4AF5AF6B8834B85D73B165CE1555D2BAC2882EDF9F465
      DD31829AD2BF8B54114A95E30DDF1C48581C5887F0F1808880164E8EF08E96F4
      6842D13CE4C4DEAE76B2975B67B8A5AA927EA57EED0EC129F7196075127FF7EF
      6A53F75CDEA105CB3BB57E9DE1B97301F1BC40F6514DDD67E601F49E69FF5A47
      C478AD4BCA719513510411C882F3051DEF54D4D310F4DB3ABDFFD193AFFE1D43
      17FEE3344AA2AF4380F5CE23DD70E642DC10E297A18F80A36DA214E014D606A1
      A0438C63E6188D9D3CF71B8483AB1907714679F5E8B94A06278A321BC5F0C820
      B6C6B3341A5390C457C9CADDCC5B1F23D8ABEC6ACAEDBB75C58B12A6B24AB10C
      1595E2CD98FA873F9C84A50278B73E590950AD65DA54936C36E007CA139B436D
      28669677467D118239D7D1B00E6590D86E34E05EABEB7C351A80FD07AA9195FF
      841CE888480D07908DC40473DF582E3A2E918E8ABE001159B53F2461A5CE1322
      24F6CA01141B018FDA3E77B0A0D2CFA7D6195E3A7DC9D41CC52C4B97D3D9ED37
      0F881ED25695D296334EC31A88FDAD0233AAC07325EC32BA3F988258F4F8A508
      9870D5CBFCAC90BE5A71BF43A41428C05522BA57F26176D317374FA362012579
      9DC6E98894E28A1A7988C7B6C8A2348B0AFE438364735421C58FAE2B9C8C178D
      D1CB8F42A7BEC68E4FE82CBFE2BE3737B8D82594FB7EABC07D2D38EC18CA7D9F
      9BFE0A95651A42B91F9F318F175FE1A0CBA8EE16741F092E9A4BAFD0708C2DC6
      81458EA21828E9F1D7C8F3207A71BF306B935684F5EEA88356562613EDC6BD90
      3FA9EE50752B277615A1347F99E804D23516AEBFA95A3E1F5BAD6A61A97AB0AC
      929A8177DD7ECB503AE6E469AE7C3BD222E1E46BF0B1AF1BA9FF954C9BAFB260
      9A26A3344B1ECCACB9D345231FE6D627AB0D1EAC440499EE26A1EA267325482A
      0489A54ED00C1625D8C354B6D41CA5D2A04EE2A8564E4C15C20726495CE053C9
      ECDFA938A9B6C505F9F5692DFF5157DFF88EB31CD7D21C771B7C835A529FC129
      673803FD378EA3F18E5350AED7DAD0DD8E6D3BD6E1CF9FDE9CF48F8CA797C496
      5FD1BDB917C6C8C7D0CD4B6324769CC2E6C99A42E976DE28F851B95C99710E14
      CE10AD872E9D6ADBDFD9F6EFEB7DB4BEB37E93BE4149C74ECF3F7D7CFBE3F7E7
      BFCB9BDE4838B6CEB942590C21A002037B28403F183588A833B820670DB6517F
      5E169CE2F4E4B42883B9CCDD7FA8BB5F4AC83A00A0E1925B87E41A5118736458
      FA2D37596AC968D3FDE7BAD6ECCDA0B88A88EEB5A50AD070D19AB2988C61ED8F
      C4DAFDCDAC5DDEFCAD63A0F22CF2F9EFDC388A4537EBF0ECE399E77EF762F0A6
      EFBD7CF3A6B586D062417ABE2F213FF7BA8073720C83822DAB401A12A7E25373
      1522403D85D32BED3E26AF6496C6D4DF3E8E57EC0F1C9D3A0F2EB6C704B32FF3
      393A63670116EFCC806E70EF392C61A7BDF42471CA8A979BAB6B7E383705C06F
      07F672110668686761FFF407001282323C85AF4DC9E696406C2AD9EC9A92CD2D
      A0F772399D44D7C2B4E4ACA400E87C974C484F5894E758911508A2E076C30833
      93F1B221E3C5DBEB8C9767DFFC6BA7EF59271652098C5BA3C6883905A294751F
      E937D549883221E641B2BD213569CF39A048B87778D10E30589C2104F2557094
      0B179E467E4F118062BEC04052AC9F9866D89593AEC611F59BC440C59CFAC8E6
      5671956A1F4AC81645AE6D0DC2C113CC5826C8740032CC59C25460D315200D73
      410D2738B0759E26D48B2BE2462C719017DC2D850221B168B72CDE9D47C532A8
      36417E42A0004074011017E266942299D19151D485384B1774DCB89D5CC3E92A
      CD2E9EE44E7BB0534D0446698CC1654979FE9325DE760C68074C489FE49D874D
      F6F1C6AB83E37C0F557B7E21ABDDA500042C7E274B08B61029C43FC0E90FAA80
      C1850308666916FD1D136362E41B29E60962F9426C6D00923C293EA3B428D2F9
      3CCD0BEE51F314F73EB061EF415CFC69BCCC72EAA97729B0D8BCCAD3A15A8E95
      9EC239C0205ECE13CCC841EF37E0CC08D57BA3C0DC5181718C02631498075560
      B68E67349C750DC7DF7B0DA787827C5E44E30B24D5597A55E3C71C3C87043E09
      2EA32909A37B77CC2DF8540F65D18F5C907F12075CF01737394E17DCC590920C
      414A23152ECC82296556252171F6C5D314D97A2897BE0A8A60E39EFF71764A78
      3C5853BBA8DDCD2203B17B25CE0959E75AAD6BAAD270D2E792069841B12C26F0
      2B3AC6B063B0E1ACB71E415907C6B471AB61E679344D285C2291B98C22CFC9E3
      4C9C751E84D853888DFBCC84579B86D4F2DAB1CC0E2643CD976447C804536950
      2BE172AAC2E9619AB4CFB2AF1C1C286FC21A6F375D51769448303831C4E0F20C
      AB9BAB6427714DB9E08FEC4DC75A2A78F74F61FACF7FC0DE1F3B058452F988B4
      14CC331F3BA16192F6BA8FBFF3202F339D5AA3DC0B99D8CFAD571174EC0D942D
      CB507F3CB616B10872A1FA03C469418DBCA8CEBF8AACE6A44E598100731C827C
      26A415324A30C12486756DEAC36388791B2513BB2501FF35845C2A4B200A1C94
      A039003ABBBD96C892AC2191EA8F93A7F5C8D9DA78006BD37CF7AE8610DB1842
      5A40EFE7B798E93237961079B955B7D62B25BD624460D9257CB48C620A89D370
      939D1E65AA78302EA24B8ACE9099AFD57A0007F4C6018C3CE23200F2EECB7818
      FAEA301AA7892A83813944B198A0A29625D8A9572514A14FE82A4AC2F4EA1865
      8ECB28A0EFD5A29080A8C13F2C6A9CAE55DED32DE3C804A636E6FC00D31B2F23
      B89772D9BAB17A8183B75ED1DB042DE40C425E16D750E02EC2B5C5728E020DCF
      A90BB94084225B5602C2E83BEA167818A2D336E3D26F295AEAE15BC129A91C64
      7644A3BF82C7AC43F557F5B47CB9FA304FB80B88717DB2D1325AC52FF0A4514E
      4973124CA4FC2E45EBD376A7962ED4AB0C680507E03933CE0A95CDEF24BEC9F9
      A9252C777F450FB6288C50D4E2F8ACE00A8D28A8C35197E53499C411D5490425
      2A33C4B4424C95CC830053A44089FC0C2E2B1F134C0F4754538C70B4801B88C0
      633297CB2773247724D70749AD1599222D743854F36DEDAEB758F0FD90037CB8
      A1A4A6F60DAB71BEE5F78F783C7CB31C49EFB9561B497D59D6A55BA1D0888F79
      344D6052D443356A02488BA55179B620C13B311549B8E9521B11892F89D4DA91
      65D102A574A2AEF62F116B8BFADE2B908E9645912632F4A548A7D35870F63DF5
      1BA7F20F1487AC9E2FD23496D75FBE841A13853097D50681698EA2846363F0ED
      337566A4A51DD2ADE2E3E37BA9FF8EAD080FD7EEDA516B26FEABAC69272A1833
      C73DA70B911C5B575B0740A3FBB85A436A928E39FE5AC0D2E49D66606682E4A8
      6329FC15D80F61CACF1DD636FC6D757B476A10B94009CA285733195270FB09FD
      00EB3B79F5D35B665DE6F6AFF374F4264D39FCB10EACAA742EABC3CA3C7964D6
      C00FC5AAA78D983EFD6142B182945BDC623DDCF9FB3F2C00FAFF5008AF640659
      63121B8F5AB2267734073072F499EE9D4DD7621CB0F83C02E8D2EA314251761B
      05B4AD4BC9B850E6ADB53DC0AD2A38D141E91FE69A6DBF66AFCFDF1957518311
      820306B52902911BC185F74E213B95B699094C8AB20EE1225E215B90756D4E45
      1E5B2D245F55C69BD96C34D772B52CB60C17A93E797B3EA9DE9896C54B75BB7A
      999D46AA79601D90487C60E5715A943234059FC0D45186251FE76F5FE5C001D1
      3BCDAFE1A2DEBCBEBEBEC6265963716ABDBE0EE84252291FFC2B1689C4C2F870
      2D648BF1B908405828A958B574314D877179A9E5763CEB000FE0402DBC4D55A7
      43DBC697DFBC6279C3B7075DBD33B5FFC337AF6DF9D8EB376FDE1C2940044559
      9E0883A37732DA68BC40AF37F7ACA76C6D1ADCC25CCE4C6A1D7A1D68B4A2BFCA
      129AB8D96A855944AE2C2FAC309A46EC762170D3311079FBF1C32738B84CC411
      1528914D9F437402CDB1F85D65EA20B94137657BC4C14BD04A65233441531365
      9A51D50AD210B9902485D6B3270EB0B8727B6833379AA4AB3264586552153247
      9B323B8D7219FF92581F467F05A0BE7D75AC1A3C73D9C7124AF25A32948E8133
      FD7F74C41AA1813D92810F61C321082517D9705976BA689250E8BAC09CDD17B7
      A9CAC6C5B1AED2D28D977FF7E8BECBB7D304700476F2F8B597E96C085F83F212
      308DA16B8154092E45842B5412BB462625ED487ABB5357847BADFDF7532E9661
      BA06C047E0592B0044D054AE540D9E4C842440B97108209FAA81B505A8928663
      B443CE2F4F6425E0AD8B94025F98D285274A5FBD34F2E256F98591DC6E05E847
      AC5E2812CC577979639D05A4971A198EEE431D36D5726F52EA60F6340EB8370E
      1584E6AFC8C7C4DD35E8AF92A7A5099659115CAC6184D10CD219C55CF9ECE399
      760F71350BAC478AE51DC6B200356780B7E627B001D661686266A330332F69EB
      DBB0AA4C304260939D5926400D8C299D8BA295E0262656078420C55FABD22CAC
      3C13D2D926CB4C15C1057E2ADF75819D037F0B77F36C554BF1B1358916AA8F6A
      E59C18C254809F4B60214D8AE4CA8EF1932CE04D315C04A3F6C12FB9B51547A4
      F8BDBDF07ECDD0CCAB96AD90ACE11F441C3F3FFB06CB243080A59A5095F1B8AC
      3EE36120E3D0B8C228801EDEB026200C8150B72C84ACD88F645E551FA5B74BC1
      3E90D27486197CF26425A6D776997CD121566F85520F2A5CF714CE931FC1D322
      2F6091661CA1A6BAC6C0CC07180FAB8043C44B1CF0AD03056219A862083410B0
      B1D95AB1331D7C04C8F405EB575510D6443555A634175F55167B052B22A8B412
      25488AB92F59EC2F968AD9026C0EA31CD1292792309624E5D181B1F59167DF28
      78618192C72EDBFA178CF57C2E75BDEAFD001205AA514E917478699146D1974A
      E77D7C195523D639ACE56B018AE0500594E4C08AE564C8FD3684513E309E9D7D
      37FC0389CDF0F3E30BF07F613227FB379103AC848F91846F05DF7B18273A4131
      870C391A8DA80D8054F441F46964F84668D67968B280938EB6DA2E6A226C330D
      E666A12A5C92E6CE928EB2FD890C1F602FFA1C4F71416E3D3CC8BC34DAB06782
      4CABBA8A78191576F6D3CFE80A402A72194431B22BA9A62277CFCBC07F6E2707
      932D17BC0CB434B2A1CF5CB0DBA5E58A264355A958C7A1BA66E6226DBC480C1B
      A9136E57212A00261D418BBB41E9EFAF173427C9D7AA4D250DD9DADCA3C69057
      8FCB7C059A344A49BA4C29D4BE6E637AB9FDB4DE959675D086C3D8185EAAA81F
      AF43A754D3337195454581FEDA52CB208F413ECE30B882DDBFECB54EA85A1EBB
      94E6DBFD11949542351D741D3C79672A66456EB1885C45374DD9ADCDE279A5F2
      EE318DF6E9F5B98F1DA53DD951FAC75FAA3088B05D6A16A10587F649F79B42D1
      6E88FDE4A7D44E0D06E97C7B7EFE5A36A5F6CBB27D7298AFD0E777112F0164F9
      6971FDD8EDC94A985887EC17D58E35E51F8A128AF7AE9AB7B934720B34AD6CEC
      48D34509683CD1F5B1B9C90E8722A8937C643D18D7484B6C7D1E3BD80576EA32
      5A41D363A9C169C1ECB10BF88A7CFEF83612DCFCE36F347EFC8D6AC31E5BA3A5
      49B4C03E461C798484563BE4DEB3EF281785742DB18D16BDFE115585AD1A9A77
      B2DAD5E8E91795B878D0C3714EF7A4D245E78E952EEE86C37F6C05141B7C6FBD
      B45FD8866AEF70C29538F1D84CFB67721EB4A68BF7482C4E9031DC43DD0AFFEE
      6BF14EDBD5ACF83001492E0A62EBD5BB33244E3355CF57129B932AAFDB3B14F3
      1F02C5867FB44032BEC7FFF7978F5F09CFA8FAF22F1FF96464ED04DFFAE5E37E
      605FA725F69D513F4050BCCFE2E548F90C1E0009EF7F87DD963B543201C65455
      4DD95F79F9BD96CB4FD2E4A4690BFFECAAFEDB89322C556CEC155DAC4013AC0C
      3F541643F4EA0BF58A6CFECCEA5D9A50E4018518C8DC48AC7E9F17651BCD4806
      56C6681EBEA936C662A1B27C4D3FAFA64127BB340A530DFE7CF3C9CAE08EC592
      5CC1B038EA91AA435DF1F91140E0C2588CB7A1C78F627B0E8EF59ECFA9AC491B
      02274EA7E68295B6B435D8D095D1A1CCBA83BA7C0E2DBB75C345A0834B30A02F
      C8B0FCADFA9BBCBE4148B7972F5B7E6C1D8CD3C50DEA76A7A7A784FC076C938B
      E6510CC782B5BA38E5EBA834EB558C79DAC2D73EC75C3B84B85B7BA00DD19238
      C09DDD3A085EEA9B74C919D8628520F0D676D13851D9CD84AC932AAB3FA1E1EE
      0387724F23ADF6928112836DF234D1713F3A975C2ABC44078F8E353F3C2E232D
      0F27758B0A3C45F6653913992B6B67CAE1CC3210FCA74C4CA2EB9D7469CAF8AB
      8485CA2018A0800024748FC1216C1D684A39C09829C17D7AC949B1E23ED8EEB8
      D52909C54C9B08E46171EC10F92F365772DA78FDA816BA08EFEF1A2271B81027
      B292C4D7B134C1013D2F284E6926C6173B44B9BDA9510675DECCE414FB9463D6
      D3432A4928F4773298AF5E27EBB0723CBF9DFE5EAD1AFFDB7FFDDE3ED9E0BFE1
      DA92754906AE51788872DE53ABE890E368380D6265C5ADA779952E7182B318AB
      6C0264CE8A2CFED36BAC4EC89BE69D52C065AD60861427B63BF130E0AD160B38
      8ED39CAF06536F06D587FFDC21CF1568AB26F20767AB84F9B8ACF1AFEAF7738F
      214509C957C1FB09454EA757C6EAB11310E8548021E3EFBFD524E93288B1F42C
      911ECAC3D8C95ED762D1146920D04593574BD2E7BA46BF49DCDB6AB9A08C4938
      B9E7E71A80C813CAD22618F28BF7FEECD3C7777414215F80315E80E746C8E27C
      7AC26F59BDE50B41598A4154A3F4D47A5529BB3E09E27C87BBC36E14CA64E770
      0B62FDC73CF31CC088B47B26E2901B75E05A6A748D897B301E8B45A1AB53B415
      C58FF1A7F53DB0BA05BB320F316A3C2F6E6271C47ECBF2B262D087A967B18D01
      5306297253E5383C9DCEB0D58049B9AD5E420994B2E9B57230C159673757248D
      1F8A6BC4694BCAC31823CED1F4630C58A3A2332AAB308C4214987474BA1CBECC
      626AAD9860418C04A39BD464C8E2ADCA7261D0282F8E2BD36CBF6B2AC087B2D9
      7690E65E330054DD32DC1D8B15C72AD95FFBC85130BB75EBE6C23658646B7A6C
      4AEDA580261249CCCDADADDDDA122E6856B3267065979C205449CBD155215998
      8C53D49AA3B9E080787C6C9A523810DE742B8E8A02AF197E53559F17A071ECA0
      E3C27AB0C50B17642BB60BEE48A4B129CC0C8E82738AD7CEFCB8349324372C13
      F37E73AB92F6CFF5F9B83885AC7B0BD7122BA04FB340B14D6B4C66FF04EE2D2A
      D02A1C0F060EA81C8D9EBB7D36937E878F42A68217B82A863E1D8A6A687588C6
      CFAB28C12AA047BA4B6CCEF57F649D5E691490B5EB0E47621C6C6FA7F6EC1BA9
      EEE4052A54CAD020CF22475A9D2E93428760516692EE8D4A66DDA3530C1C9E31
      1003DA0825E3E83188C227296112686E0B2CF83C8E16A80261CF2E558207D3E0
      5950611392DC0FA925001A9DB18ED299B4D65CAADC75A49E38FD72F125278033
      25C8B8701742954449C8402E41BD7D3C69464AE1E64728E44B4B381F4EEB55A1
      780B5A332C8A79286BF1309C0253B5BD08A0721A5F72A6D60223F1646567CA34
      5B0193440B78B2BC281CAA8D8C072D43F34571B329B45425B92D16F10DDBFA0E
      DE90E189D4557C5BAFEDE0B4220ECB9A1ABAC0F7228D30AB266841D39F7DC337
      175D0C7871419FC7C9A8861D306F8A4A6720E16C40B29FE7D295213705909169
      6BDA38500210EE45CE40A348DF3064BB1F051EC29DAB4C48BBE3B300682F1925
      6EDB3DD7CB082E04D5CB20022982FC467A3C6007C41C56E2D78E99BC0865ED85
      0F2D60B4D8FA84C408CA2B244459C12456182688AD58BA648A848657423028F1
      04EB7CE01DA0CB8DC47405B9BE9688E2DE8B88E2F6368B286EEF1E5D2B25B139
      5FF10F18D1842EFCAFCA2758A93147064F0AC755BCF9585AB71AA1A943E8E55D
      2CBFA5CBA83C22D23D986CD7B3AFB4C97B6D2ABC3D280E5127BA74C2A1AC4AC6
      D8C9BE5FAE5297AE0C2A65ECF294AC83C8A6C248963E11D70B55F0214AC20864
      18D4AF6A77563A5522AACC88E259FB45FDB79C6E22495DC555802393CF17085B
      8491E0116958BAA5A15AC20E8C58A6F692578C8213DB19D995135B199AA36A3E
      912149B76BA6542AF9DB579C2C4CE0FC2888256914328449FB74E9FE5C175C48
      5BD695FD657BA25DA51625118A54569CC59A4F12F080F25CB5BA84FB71553D01
      256D9968F31D968E52E94071F5B6CB0C8CAB9A26B4E68A661E6FAEC6168382D4
      F5CC4D58BF09D2C78E75AF38AC3C551263C5B49048E3D64E2C90AB6A2007BCA9
      38405D1961D4A6B0653D92696396DCB12A9294C8B8057CEEE0ACBE83D3D3D383
      F2D6A96A1C150A403D0490E9D010E4937C5F4973DDA041A902B2B21613B92E79
      D2157106A6C9A58223F3A094D3AD5AB45B478AC066B07C2EEA1A2D107B7B3A56
      52A71F688748DBB72752F12F58A1044F92B4A6384DA9128DCC8AD4D58EB93E5C
      6161B7A2C2F2745D1B65813894FAF39F100794BDE34896F9D9408E65454709B5
      CB35DA1BDC7ECEC715A303759B41DF7D10CB465D6B87DD4A87D5158F6B5589AB
      0585191F34AE11621076B252AEC2ADD624CF58E248B5F41ADB8BB02C4A345AC2
      36B5E5424156CABCAA943C2D8A12B6E95A2B01935DEA65592439B04CEF1B09DD
      B29A74FC2AF29E5A2FC85080FA6594CDDB34B16E13B45275846BC4AFDF1A5546
      47A9D14A305E4164FD1CDE99AFE7AE7E2A7C70057A86096A12B78A575C198B8C
      3A11AB82B5BB831CB3BC3562770DE947B6485543BFC86D5D234D6F935C64C5A9
      5657E583D8589CEA276CEFB9F5EC9B8C5DD4AB140F88F019B729FF79617DAB3E
      BF222DFBECE3D9CAA2A838AD8CC0A98E743E8B26C59F7899AA86755054427F15
      7F23FE4A7632F930F63C4F742F0C6D02A4A9A349D33058C57A35220863883E9E
      A9F5CAD033BDCAFBE1A153EB158DBB8BCFB21A4B4DDBAAC72748E3E75CBAFC75
      FC74A5889D24EBF14DBDA6000720500DFC0A0C739EE598EB755F45D20750C2B0
      922EC809815701758695B591DA3B40036AB749C332172EAB80506B5DD3FB7A3D
      23B0BBD7BDAF7514D309F5845074094B1B4F5A5CA0B2027EAA0652313212B974
      44AE26B31C217319C49166DAFB832FDBB51B0EE13EB13EAC4A642AE5425E909A
      03EF096EF4D937E7E9321B0BC48C55F17375AFAC03A12386BD66DAA3A9F528AA
      EA2D43A61901A40B8BDB195550AFD255E1D376CF311D06990F01AEF8960C8686
      B5C9E5ABA5AEF2E927741400B71143EB04D94B15F23AC7E6B87EC930BC2579AA
      77ECD9375C0ADB7AF781778C2135122F2AFCB2CA13ABF5F44B8493D94FB9C28E
      355CA8641A50F56F55175021E1E576B79C8ED4A591395FE1BB2FCA865E01BABB
      538EAABB697DA06C6FE5828EEF7F391BA497DBF2C128BE6C8843A261F6811D3E
      FBE60557583859AD7A50AF2EAC03BDE6182A93A1E90368D87D5CB57B3CF516BB
      850BF11213EA60BF4883D16025C6CB5A02D3950E01A0D0746AF414F05B209327
      373A3C5FA7A1508ADEEAB5944D1682F205795147EB234D94976AE348AA4A6FC3
      409F6655DB61AE42407828DDF321C2E8FB9B362D2D5A848A8465D76FA35033F1
      D45A24B73A23AD8CEC64D24E3BE7A6E54A9BA4F625A4298E6E38A89B0346F851
      2D45CCD3E50EB1DC2F25CAD54383461CBA8905AC0B8D5AD308ABA50494EBB2CA
      1494418F6C6E180DC2B7011DA622331ACF3AA5EFEDB5C6F3EC9B9F6AF6DF1FD1
      564C0AED25C743CDAB59B15B8713AA46A628A4C3602E564D433A40A1F23739CB
      211615CFCBF8E0A32729AE1120CF6A317E94DE74A3042FB95B7430613612C556
      103494193B8E16A3943A9E6AC33DC979238E3DAD363CFA916AC985D1A3B6EADD
      679A5B37D44B3FD8BAB59C32DF8E37F9219425BD924EB8E68B68327B563A2EB7
      A8552B8FF714869EB27F71C26E958A505EF14EECD85380E090AB7B5CAE10DD82
      ABF110072B8E1A3478D67207F1B0A7948FAB1C1089B8C2C83A32E1E9C1C90E56
      6F4040F9D8F54C51E395682833584704E39BE71BBD0A16BA7DB53A7FDBF9126B
      C04464C954ABCCCD23D969A8D23242CFB68B8F3F971212BA6E65F10EE5B30C28
      52B7B481EBCB227364770A25E0F47E2E71CCB53CF371168D4A4D3F4D10ED3127
      AFBD0FE603C611AF4159664E48356623FCF89928D7E6CD5A37BFADF3B6276665
      040659C836AF5536731A094EEB40574D93E780D6A9539304966ACD6B6DE056CC
      45866235F84064C68809275A114272CE2D0AF2320E04694079F7D1D187E170D6
      0165C43404E8ACB499A907874C2A31395BD7B4B1A2769B5A28B22510B7DB6E0E
      4E969648BC6679BD6041698555322BD19255912CA020579DA8AFB292EAE1FAE6
      3EDE7E5EE49D3517F26E17925DDC15A45BB993DBAD642D2FED97DDC95A944679
      0D152BD63156892A2E56EA249BC41036D753B8C057CCC87D2A178CCA99AA000D
      73B776BE5B5C0E96823BE07A345E317D83B6DFB587B962D5D0C5350EB86A2FD8
      6621A86625C2B322C2C814CC1AA518974CD79AAA8630C29F7654F579DA4DA441
      C3532FB5924BA3164B8B681301B4B24ADC6095AE6C8FEDDD715FE3599A1278D8
      5A524B03E2D684ECED5550A418236DC5D02146AAA4523585DED41FD87200B070
      2C99345F20869CCB733C30746F43B19E065871342075933A2963FFE116B41023
      A8B9E96FD7BFABA09ADB4BFB744EAD3319FBC7093821E71B143423A9C35449CB
      CAE718FC9DF1F0EE6E85B4366D840722C19E13E560E632146EA5A9EBC6CC054E
      5558035D95213498238F757A7C4DE7509392C313A1803FE50A2E6598FE8E1BE7
      52B032DC7C7DC371348F8890B6900E752CE8863D5397B04252AFD2EA7A19051B
      38DD2D208DA30B21DDCC86CADD7E201F751320AE35FA9BEAFDF67B293A973865
      A85FE9DBE66A7A9B8054DEDD439DB77A9B42544B6A39DA3EFF7A07A71D5279DE
      165C1623BDE2120ACA4B47A41ADB01AF5F4B105DC4A9F516E72B965942EE72EE
      DC8D16D25CF785D2E60D585F9805D3A9224D4C7A7517259925638D3117529A45
      286099BEC96B715B19CC53A35D4A9C653995CA1F50A5C5B28AE1224B01E0F3BC
      55368F8A275047B643763332404682B25FE26DD8B01AFC4D70946AAA6CBF4865
      286EC12B2ADC5329FCA62226B1271D911D5D7B52A19B94555582373A51AB9D1E
      49785555840DADDC462B9540217F62337AAC83B23D36D514AA62EAC3259054F0
      0D5690518DBE1FBB9335D71690E778BF6D33DAC49261E9156A415DAC4877B42E
      EE8A2717D79A24FD204B6372420E4562BC88654A8EAED6238B50B170853ABD4A
      21CF29D02A9AD4E6AE78E06961ED8DE78952F5C7412E95D46A8D1F1E5DD5DFE3
      4E04582184739AD0CFDE22DEB6B2CE20932B940C25CA748F7B2EA16B88DB167E
      46C58AB90C898C9C30348B681666E98DD3F99C730B12326D81684275B7CB9A5D
      D2D8320B244F2F2BBAC830144C85A855BA22E43FAC54EA960F46542446CC1729
      ECFBA6AC767915B0BF7199808A24EF31C6996365EB90AB41712095ECEA7604CA
      5F8BEDA9026C4A58C3D40DCC7414A0F58168132C16AA2787BE428F4CAA09355F
      1138CF01DE8FDF119E0C6A14341490EB3C394955B3AA43FDE92FDCDA94D3DB8F
      2DFD7D188FF363EBEC2C3FAA0552639B248E81DD00E921E1D923C3F9D937AB90
      FE2EC09E52C7236C78783C867F178FDD5FAA84BCAEF7568B23ACC3B2C5596E04
      37878A538EEF3CC05EE9E378198AF208576CB78685DC1E100104ACA6AB193E42
      A8572B0EBE49A725A59AAA8C0785E04082283959C4C198A35C53EE88FB166B98
      623F1289A7B9CCA63B3AB6DEC0552964EB634AD188441CCA7A80581C81072DC7
      E2DA5C54DAB998E1D1895D2AA49F57AC8F9B16CAB3B3781F63B2A41566A0A852
      2A3A5E36AAEDB848A9C02CDC32D9EAE0509061918461DE58B5BBCD6C39C58AC0
      875AE5A69C0BAE12194C93A800801CA16932ACD40C3517B6E1C2722D74158582
      D03677551BF8364007D83D951841B3FAA6EB5C2F089326ED9ADA24EAA21E490A
      80C5C5738BFBA1805C1771B50492094699082E645D302E879C73F2C21B361905
      000EB51A34349A2BB045EDC1EAB7B21CA2C17DE9DA43228B34949571D447548D
      6055B79A0156B5688E6791D82544FF8021BF5273F74C158D7E074A4D961F546D
      DDDC7D081D8D9B5F6DB1355DD1979B3951BDEBB05E69FAB771A116816BC87F57
      13C83FBE0D915D8D83F853FA9E44FD5F01E2EA8D63AB7C1BBFAFFECEA3ED14E9
      E4D5B74A8122E438880AB46F570DCB4A0DA558EE5019D5D607B00EB55999A387
      51AE3EAA18A951166E53952D17D2FE5F33FB17D54AD97ACC634B768C20F59824
      F9955550CF2915AE50AB4A2AB345A5525B70D958B617215646F5EA6B18D6CCC7
      5A7D03081328F04217A048D2B016E35D2FC8529D9E45274EEBC2DE2137525B6E
      4159B6278C8166C92B2104AC04735F09C0F6E7855244CA4CF6BAE5BF2C8EAE1E
      E0F2D812205456360B4AD3A2BED115D02CB2149B769C5AE2747ACAA6C24A4170
      F910C5A4C62248A8523EA76CA558501B5F451B053AD809CF68F9137D31A9A634
      F7E690E72FC8E5204B8FB580E2F6EA46D23C49EBDB81FEC8CAC44105AB243E1D
      373996F1998309160688A3BFA363EC30E014714DA4F8F4829B2355311CD6946B
      A3903C6DC59D358AA9D27829C645010D297152173E63D061B786EAE15D059545
      ABDCA4B261A3BA10300850D4A2556DBB142592E5B8586658515C3604382487BA
      ECBA806EAF4AE9B940DA9AAE74553CB9B84CCC8153E4ABB73460DCA13AA8CB04
      65F7224D49A0A272CB4B24FBCA776F7D2ADB036052DB32A78A7E8105BA8A6E54
      29C33D75CEF9A68313D79434C9CA0A553024A35AF5ECA9B953D94DB65D60C441
      557CA06B7226AFC9010E2AAE31851E0FA75204F600D5268B79071DDA3B01FCFC
      800FF0E0FF2C519C3CAFF24276C03289ACB90A54A8CB4E3CE5E0E58DF532C8C5
      473AC2035917906C1FA3F45A218D740EAB149E4AEC077B6FB8ED0FBB8FB1B4B5
      7EE2F02F16E9819C57DF8229BF7EF70E0F1FBB5D4C90EC8DD558ED9B16CA8BBC
      B293B21CE3B1F5A763EB8401FC6FD685B8C9577B504877089C0DC70ABF88E383
      63FDDB8F40B2D4F9BC4D2E5116D7F18507BBB8DEB1A90717B52E49866684922C
      48A9E6832C29AC120CD4ED56A5862B34424A315C0C4195119661883015DE1799
      111A546B4DEA93D6E99E94934B0FCA74A05CE8D1D5BC2B1999E4B329931B1635
      2791D1399AFCC8202DCBA010CE6603D01AE5432ADED5E8637D4B548EDDED3D8C
      728162B172AD8E04097D68AE570306F12ED93F92C1E85240183FB18CE29018EA
      DA01EA563AE806D0CD8AD856406BDE21B444D5D6CAB97070486170077ADA0372
      D3AA7668406F6FD0E3A05DBCC0D7005C33AB4566D4B36FE6A22CAAA1A245AA2D
      4C58FEADFA2B6418539EB2C8C2913B804EE30BE06EC84A1130DAAC17732C0B9C
      C48C42798048A13422E70C8A5D1BE97C600EB1E90034B6D02951780DA667568E
      AFC2A8F510DF2E937238C5C6CA9D2E73ECBF70D0D2905051D4768E283A4B3372
      BE4E45220372388474D3566537CC9CEE00C5D94FD03A542C934A89698945400D
      A8B52CB57DE20ACE1C641958D8560DEF146801D38CD4000C0FD379A3F8678EA7
      820520AFCFF9E29D9FBF3634BE9D2FE4400A7AD8B13C3FA0003B6A5EFE0395B5
      36F1941355878563F7A8B7582B438E6CAFCCF21BD03BF40A5013F42AC02B4295
      02F9A9F552707D42A9CF102D98A7E47A7FFFE2FC1350EE91A603DA895F51A664
      78378D4BFE89E778A1B07F64B5CA146A45C752DB209129462F3F85E0617D9974
      99E9ACB56502FA090B8187784189E4A07C2F5817C31A5CB091841AD01CE10DBC
      976A550B912E541A7B98EA369D01CC2B164A3783F554280A916F34ED2065E008
      1E4A7DA1ACA05A8CC0D6D9998D9742E88D8ED7511A1F1A0F643C8A5244017CD5
      E35555E3996ECA567B70AC98A3CF8F459C2923AB511EBC80BFF100F9EDAD002A
      89546D6AA7ADE65A6D5A172199585D1A5591CA97A5854B543AEA49F52B275068
      FD48577C570325D6DF96802AAA8FB8DE2DE9A2EDF6DB5E854C6BE12DBA6DA2AA
      0553BD7CD495E4589EF47CB93DE9A3D0FAC8C3450656AECEED0127BC15DA096E
      E0B1231FA2A4EC6007E7DD0A08B0B7FB8BBA79FB9F7018BF0271783B7F95C211
      3F7AD8CDA9F513E6530A3645305603A9D2D157B27B9F906193241085AAF34142
      8D0FB499224CAD0BC4AD2B1C81FE9261E946D8961164B6E84173ECA44A9ED05C
      9257B202E769C68D53C99322AD5E922499E460C6E02ABF219D0051707BEFD65C
      067FC8EA0FF58C5BD401DA3BD9CEE1944A0EB0D199567DC43A24968445E5D775
      C1A303CDB0B8239EE227941E8628D0BEA5CC2A6FDAB8B2DA336859FC28592899
      8EC97627FF78DBD25AD447DA6DED581936B6BC8AFB4D1AC5646605B03A80DFA4
      34F022E9A2EF286190E3CF4844906225F5A529B93E2CE652471F489B6B2284F4
      4E8D4A290CA922E50083DC88E60FCE11AE88721C077D19910ACB4938D29E7724
      BF8D31108E5A6B53BFC390F2F90C49DC62825005EED9942F958BEDF1EA583C18
      C3B24C1A5D2D89B806C50A905476F14ADEEF4E5E01D2BFB47B873D7BAFCFDF1F
      C33FEF9875BD4BC701B9F364B15A140CD81CCE216CB1A8BBED6E29AD60EECBE6
      93F8890C941FC5C4FAEDA777FFFDF13B9BFEE7F8BF23D151CECFB29DC0F00FB4
      A00E3F9F8A6B612E0ADB4734040F65E70486E1D6571DFF4899B1830DA04684AE
      825BD7A2AD642570AC45A5718CEC090BF40F36128E53644CCC5C4AC6D4DE7957
      EFAC5D35D61659203B967D54AA6F881DE9576DEE74C7EB566473131B32C4D481
      9D8681AAD528450873D374E0A7BE116BE0DA2E4B563DB34A38A3104E4E29A855
      52903EDD88D94C426EA3F26D8A3732F2589BC6AE3261FA4C978E4E934D7CDAA0
      78B5447773010DD9C487A0AAEC840947EBB391124B42717B13F59D8E6290A175
      2BB5BC4F2D958D0A136F5D627DFA498AD638E441CC64E48C1E1C21AFC15C8FDB
      C1F9DB2F22BBF9DDDA105964EC34932D59E97504D4A647DDDEEEB15321FF8687
      88EAC9581DE1E367439EC850A34A99795DFD2D2DBBB31CAF44ABE9FC492A2E8C
      AF58D3B2C9F9E698EE7119B04DE16452F03C96D69563F2AD3CBE7F00F3A5BEFA
      49C039A8A86B0A7EE410987598B32D5177D8CD2B759BD0F31F2FA7B092D3E2BA
      90611E6D429B6B85A76A5D322A01668732E8379A58679F3EBE433D6426E2B05E
      8FE0C810EF5B41CD54FB372CB0F63B07971A9AFD1469367948BE1EAD2E8BD601
      11851FB1D05D002A571809B176A449570E19C43445DF9411B05EA14E867CEB7C
      8BB56EBD497C23E3697F4EB8592FFDF68A039A4B7D5F26EA1C48C3FF814EBE29
      23010ECAF248B85215724D73DF4B96C6FAFA4FBF0E0A218CDBA311F982EF1391
      36301B8A3260967D6CFDFCEAE3B1F2D0BCFDF4FE00A0F6B725C573937966C1F6
      238FC235F355E14096BED031108CB518FA86B94E1C0DC7183389D8F371F0F2C3
      F9F9B7EF3E7CF8A463EE61760CB9AC85DEB7B64331A1659713C7DBD78B2E2EB7
      3B9212549126D6C1396AEE88C5122FD1A926121DE441A9D0A041956522B5D50B
      E0A64AD98CD3698266E923CEF514A07F1DBCB5D0276FA153DE7AFB7C6E915F5E
      A607E0242A7246257983789421608ECABC06C3671B8AC767C1F479F2FC1526A8
      C3895CCDD29AA1D4D433D890CEB0A184810ABA5D8D9BAE1813B65FA39AB5A176
      121825562D2C38637FD161551C65970D10AB23559D59992A12CA48A378656333
      B8FD0C7E0C2EAD39C6904795F00F83F784F76F40B2F8F4FABCF3EDF9F96B2EB5
      F1C13FC600F880E42A114E557326FC8869FB174CD413D668553C3FB047106454
      E39D4C502D4B653A236EABC794ACA22C8CD92643977281295A3391A7798CA53E
      123965B93A2C084CF1E5A1B82E2359F19939B5598A26248E15A7D6E1471577BE
      C6E458F5C7FAA0982D34999C1E592F58F53CFB4F72E1D27D0D461145ABE7B3E5
      04B4669447B374A9729BAAED75570A59AE2C56EEE44A368006E062CE2C065170
      C897356E81E4DBF39C75D4696D09B98AEBE5B460E0D313901228623E4A306593
      0330930A87FFF1C52FEF99BB533847A9BC8420FB62DEF814FD6B14C7162EC795
      2C0BCE8607D96182C555602499E78A4CBF7DB0ED66941D53A5D728E74403CC6B
      8BC612E212F17245CB31C72F5426637C1230659CC2818134566C0F7DA0FEBBCA
      A158198201D47A1B1FD7131A4A7F89A4541C014881CB40A5D8B15F4BCCA19BA9
      6EC40E01CB9B1382D8984E3540003A9FEA17966049477F3802B653864F17ABCF
      C1FDA08C58F859211A959360B2728453FEB5C5E55FCE1765ECBACE6997435502
      868F2DA4B35C309B00232BEE18FE783B847FC284990053F09705D5339286083A
      E16CB9300E558589320C4728AB205E46A9EDE9FA1B91A434B25107BE81550DCB
      3C5602F671E54B4C59E0F1463765EF687CF8B7FFFA5D67D8832C4F40C150FC84
      CCC52ADD00CFA9C5E2E928A52B8BA7D61D3EE4926A8112B27130DD267CEAC37F
      A29A5CAC2632E6BB463161D5486CD307C32CA88A57B8A4AA41AAB264A2D6A3F1
      F1F8964523A42B785ADD82AC71811EBF28599AE8E81671ACB25A7A916280AFB9
      F3D5F2F855C86C7F4DC7ECE2FD04CA102251A85679B47E0001EA75AE42A0E497
      D4F4E7ED2BF8E314F3503FCD74C83016D04211F2086E5E51EC2066BCADE42565
      A0FAE874AF38A004C898744E1240837106C200466CD75A769BEBD2745D288C0C
      3BAE1581B5A040734AB53597475F9E17D641053C64CCD42D67654218137D590F
      B5569B83C4E1718B0E12C478E15E5C51D99AAB94332F5332612A23893277EF24
      21836606EA2285DBA2919F57888393F672F05E601D482A1821EDF7A7D6DB09A5
      E470C8FAEA52AABE096060A01D718AA286906CBE59666C6F98439539E2C2C699
      B61F55F15017B1E0F8964B4E63D9DA3F22D53130D5F6BA5C884909222EAC5D6E
      AAFE70FBDC70D511B4B67599A00D5C3B8A838C331D650B892AED3D95CDC4AAB5
      4180885597A4C1CC3505D4C9DD7A5F4B8A1DE417B9ACC8900850C457379B072D
      2039AFB9A1383469AEC37DD8BCA0EA2155D6B33355276CA1549180CD922AD5B3
      B6728D0D61003331CD3FAE2059A5DB13F94560C9A770E6A4C0E976DA877FB15E
      13B3380736819D4D7E962DDB82A4F2145D5CD0CEFDEFC5F80243050B46F35035
      A7545B0556B643920AD7004B179194B02BBBD7311AD50D51F16A51CC520AF25D
      47214A4125FD5B5730576DB7E306F426B060D2742423F131DC5F3DA9BAD4C925
      CA434F280C7FCA91C6EC1A0C6B93ABA4E948BB020F57369191C4D002E3B697C7
      C8D166236D34C8DF4B8A39635255CA27BC194EF20DCB5E375F82A97472940594
      AF512992796EA3FDABA47DB64E53BF80FEB0F103A79BCFB9BE204DB946437359
      16084F531AB9B83CBD0C1952646C876A28EFB46D6255A4AC8A63950320790D73
      A25842DB3AC16611AE452112510213161261C1FE2248A88699E45D2BB0E1F27A
      B5FEF17556CBAF622A164BB05A6D94A1C4ED4B3363F51960B99AAF8290FC824E
      053EBC644F6A60113C8B9F70792F5E9EF23353B8AE2A70199FC211AE7057543E
      658A4E4C2C0583413DD5B731BF1BDBCF6F5FDAAE5B912CA80ECC2A7A23F92142
      53212EDC78F485940D801B638088C448EAE300E4EF3BF9C82B1C97B7712CC153
      07CCEE164211E411D68AAC180AA7C84EB274399DD56E2E50C6CAFCD621E7F0E9
      C4FF5B6E3A17FF6AC108244590C45A9DED0AA4949B5950BBC093D1CD89AE6441
      E49D6B7373DBDA17C73A3D75F57BC5BACBEF5770EC5734D653270C19CE8B28BE
      4AB434B2D68E863888CC6294BD1E336615D45A83486E1596689D85C9EF8511EC
      8C0BB74B4E54420FB33EAB35E89619597AB0CD02C64B6015BD8CE510C540F02F
      87B2CB075C423A2189D3ABE4F5486683560BDD51258185225ABA4C2B0EBB1B6F
      C2F88AB2483B8C3D59C678D6D8EA87A85C56D65A25965C9BAB5565541A83683D
      302FD55EB7061AA9FF6BEF54251FB75059FE4A9A45303C2FB886403A15E401C6
      5422423C253CAC8C4E90D770CFD94B5705A7E47FECA9A3CA9C72E8320CAD0E63
      EBF07DA02B15B0818E0E4C8AE09213D094F752E085FD7C128E3A4CB54A3B7351
      819F9431CB846329744BCF64786A62356F87B75200E0366048932E0057A98F53
      8AFDC6DAC1453E1066AA92AB865890AF40AB5267082D0C7083801108964AF06E
      B5255F6ABA60757C2DCE52131F8154010B84881CE9468BC6B6325CEB58925D9D
      D0982F23F6AEAB6CE29CDD0335B5CE92F590B18A00CEA7C956A9A8697D14D767
      CC8CB71FC64B72BA90E31EFB35583F8878716CFD28AE973988168040DF47C50F
      CBD131069CA258758C1C06387C26D095124C850975E1DBA900D954257DC5C1A6
      F521AC197C1525617AA5CE40055FFF31C402BD58778A403BA4BACC12BED6EAEE
      56F6D5329A96D60F9BA9EF8A363BF1ACE1F3516F0857F2F386B39D44275E170F
      A0E7EE70C8B0B3BF8E695780E3C535BEDBE2D8E3DCE96F3C7B7C7F1F4E1F2F8D
      75026A2EF51D99E16F48C36AA54CF7E7345B20B3BEFFB02BF45095BFE3952F37
      075A0C1D8B34C061C928D258B8BD5BAA656E34AFE95299D93221B37C903F49D8
      304104C0907E46B2338ABA9348EA733176A42A806B01174817D416A7A2402AB0
      95412C1945620388F24AEBCD270411C91824A6F079B700A37A2D17D925AA181F
      45109F906E30A6CE0064BC23299F87E46AF7A8E94AC862A128EB35E69761E06A
      4400C52AC64F1084CFBE511CF5C47A1DCF29CA207BF1F3F3BCC6692B34C5FA6F
      2C8A2985402E240C8AC7B2A0CA9E792EBB8495B1F469324DA977D212EB62D670
      53E1A411946E3F23F647C8CAF970224C068CF053C930BBDA5E8E16495E2D5944
      1502533D0936BAC656A0DDCEF222ED0F3ACCB634351CBCA2BA5FE58492A4B3BD
      4F15536A6FCB4483847C99EEE26510C51C791B58232C018A514DD8864359DE39
      788BCAC6D282E4FC32002A95299FE646DE0E77451B33318F089455589B8B2923
      246A08A80307B1F03F2C38268D0451500193717017DCC7B725E6528BE5883A93
      4B9326CD2AFD5AFAFEFD76FD3B3B1BCAAAC645792DA814AEA403D47C66B79E2D
      98EC45D6820CAF528635FED24C17485B696622DBC2944B8D2AF1158B180389C9
      162CA1B3DDD08813AA58629899DC07F07E293FA3A15464F3206159787501ADF7
      2AEBBDAA1C09250B946DEB2B3CFED47AC37C9F69545EF1BC5FCA5664514EE93F
      E5DA0528A23A8A9DC802053D4A8943FB6C41C6A7380974762E93A8B83144EBF6
      733BE3042BD8275C06D4908CFDA40C84AC0267FB5D23E85987EC11A35B741905
      2BA5C937E4DD1D554C34E80D9B01C476F0B16241535E67AE8AC003FB89E6CBB9
      3C54B826B32096D13C32B742FEA9564E42B62D6A3FB1122B748321992865EC45
      EBF6A2C15EDB8B9E7D73AE10E384106A2C114AD5A38F5881BB057DB65F0F855F
      75922319A036DBE89E8DE43EE7865B147B21DB3C904BB5747CB16F7DEF10AE4D
      2A6244BDCAA499A2888A5867BB1E56CB741D7160C9FAED55019A7319550AB8C7
      09FB949CC8BC1CF06D4425158239B65B0ACAA3557D0E68C23CFABB582B05B1FD
      44F5A1C9AC446936A668231CF2C99ECB2724D87C309A86161A5CF986AA190A12
      1469C31D2389EA975646DD2912C03D06D29FD44E80A6610AAA23786A3370E51D
      8A45ACE4763C21C8225CCFE718CA7382B11D23CC3E9436480D724A6FE47B01D0
      69156AF0A007F45605B016D837454D54B945D41C55C83A4DC0180429D5950595
      C9F5A460ACBEBA50CD419B6F3FA2C4224B49984EB97E463ECB96C98595A7F712
      6AA05B9CAA85217C2ADD706EDBD67DE0B091CC1B9C387800495A6612E3ED10F3
      45016C31BD32627A29A61F6C01D5AAB62D12EABDFAAD6AC25A6F8EB7D6480810
      7D7BDDCBB58AE22DD30329DBC248CC6B12333CB7DF1233F0863977370F12B255
      948D1FB9EC366017B577C4DA5B98560288A8D2DE5411CFFFD7DEDB37B78D2469
      E2FF3BC2DF01A7B8F859DA9165120041D273BB1BB22477FB5A7E5949DD3DF7EB
      EEB8280005092392E000A464CDEE7CF77B32B30A00254A0465B75BD8A167DA96
      48BC546565E55B653EC90620ACBAD99C938EDFE8497A3EA9BECDA8EE8302CF24
      522FD238D693162A7E26155BF3257ED9BDA4B249B4D276ED82B6B5A5DDCE6E6D
      473345E45EA18BAD846D2B7D6C7AFC69D952B86A7CD0907BDE633FA584EB41F0
      5E7561F8001B6D74EF3D050253DBBC2BD6604CB16718C798319617EC9832377C
      035B7D7FD49F12CE8D12DE3A5C24E94F254997E159137EDFEA0C3ED1EEA6D360
      78C311FD71A1A3ADDB1D489C43D3A9508447AFB35EF6B44169137B9F07CE91E7
      840F19B8AE5FDAD313C6ED120E91CAB8BB93DCD67BE77B34EE8B6C5496F9C133
      29B075E7533935B89E50FBF31DE9B60802964D6EE59CCFD82A32269BBF5DC667
      E0FECFF90C6AF58141C209D1CDAB55F4CCA4ADD36EE9D80304A150D52F93F324
      325D81C92C364F642AA46543039E0125EE94A563424BAE5D62526E0458130146
      7D8EF647645328FA9B83B57814769F362DAA3695DBCB24D40A9ADD2754046E2A
      9F37DF3D351F60D7994F0A93424DAF2B8C5480B6975692C54E795ECF235BEB8C
      00D773760DA76BCF6C07C0FFD1F80185D4BD2A020EDB2D9B8A739DC4D4007CDA
      ADCA568ACB4719794A2722A32CA3135803AD925660BEF7F35CC557B3CFC36E80
      BFBB03CFC53F6EDF1FE01F2F087CFCE3F7061DFCD3F3877449E077E992BEE7D2
      2503D7F7E56EBA04CCDBE7C7748643BAA8DB1D76E8AAAE8BEBE85FAFEFF3757E
      D00B7E5766C6E47F6FCCD97DC77983FFAFBCCEB9BDFCF75D88A71D38CE7ED3CB
      0F364285858AD8EBE5DEB3FBBCDE3B99F6C666677CBB9DB106C7D3FF9B5E2E7F
      9A6F1067B347EC710BE5D5B0BEE310799A0B28C3B6C501AB22E3CEBF3A8B9171
      DE447CE4FD8D31BDB7454FEF7C73306FF204BEF55C8DADF1074C56EA55CCD9A2
      9860942F263612E3422E58411B57E0BE83B712F69FBDC3B34D6CA22E803E4E2A
      C7797575B30A770545FFEEE95EAEAB768DA13295C4A6E742B6666ECD3BEA845C
      872030CF81F3FFC160D6BCA2F5A48AFAB5D211CD73AA0C8B4BADA7B6F3171D04
      1AF80283A644171B775C6001162A45445E53DC9242224A206AB8AF8F2932CBB3
      AC7906E1992521C5D3CBF81B8D6FB5A8E078C9453A8A31945D87A806EFA6104C
      0319DF8BA2FC98621C32636E975D031F5F0769EE2C33012750279A175536E9A5
      BE914E76F36273B0B3E46067B9DC7C2A073BD4E7EE0369977F67AEB71BCEEC1B
      EACCF0E49674F59C66A33FFD64A7C332A3DDF3399A9846637F9D8FA7AFCB357A
      F96F562EE2A772A6F8F9A7251D205A34DD0309041F66D793D7126FB633BE6745
      8934CBE6BCB190EED1B6167E3C22C526E29C514C0D50DA022D1BF8E8FF147693
      E012BE2753E8C7E92B624E679BB226769C5706595DD8B6FCD2EAC51DD1B64669
      72DE516EB2FC8B196C8752910A1C9B89BA368F75F2B8F6E3B81ACEBB49A1F3D9
      032308A9B84245154CBEB81EF6D5CBEBB76A055C366EFC961F39D1D79C71C68F
      585D81264165CB675BCE767C2B9ADC1CD74CE61E53239C5533A48BA677C9BB11
      110F96491454A342513C3A9077462AD4A3E28E84D808883233AB46A5ED0A9FD5
      0670D2BAEBB5D0C058E6B5D8BAC266190A365699B669FB9380D957E3D735F7C0
      968065E5C4B204A7477059B50CD6DB61DE49B9AB0A33DAD9CDD4006A92D6965A
      A6A22C06B1AD918B8C543A97986F7665B35D290E18B59CCDE6792415E9DC7B3D
      4A670C86CFF8A41680CF40EF6FFD7208A7F237E93D0EEEB12755AFE80890C07A
      3688D6E526E6034A53132D18C6867A0DEE2D09BCBD4061598D9D92D284319357
      506AB7C162E9B8B22C0334D1092958520C6223B580DC8ED89C982AE7E0E8F8D8
      A6302BE7E793E3438E173A27476F4FAACFE9AA1DDBF44C13C6B4CA6F16A220D8
      8996772877EA2E67B13C6B5E23996BCA862816105D3FAF76770CDC446C8B2C04
      44DCD0D4647E14CB86570EBE301BA479D721723328964547BBB69A7E342AD337
      6C611015ED12BA48391A9B456F6186A861E24C10BBB64B719E5238C63429DDE1
      C694B7C6B71178CB97A5068F2EE4DB8829B135B2B214786B7C9B4615DAF96AB0
      D0513ABB71B6498D089A6499652518F8160182E4439E3170E6C10F3B0C7449A2
      AD82B15CE86D25CA5CC7DFD2756C23776FBD9BFC15729E1B5915F515DC28E492
      D31FA491B35D627D58E3FA764183414FA4F8B7BD644946A2395C35016EBA481A
      B7F0131A8C12F77E28557DD90890DF3CCB4A25C24DB7FE2AF9CEF6D2ED7F2D55
      89FDC8661B290BAD5DF5762D9F2AC0B58CF30A6F836B1DA3887BDC71C9A819FD
      34D749FA790D9CF069597395DE3E9199C15690C6169A21A3782C1F439A0EDEC4
      DE0E992E840169BA238ADDAF18AE3567A0A306B55996F23BD67A156C046B32AD
      E7CF7006268D4A3A2D625A377A563578AD96CB686FA1B7348C66E4CDCA4C124F
      0E5F37C71FFE593A1ABF968328DB808219EDC3C733C78023ABC94DD5FD525037
      D9241B1BB0C2EA78CA2CAAFC96E655F7D84D0BBC5582D6784051DD035A8D494C
      ADAA05070DD75FE729A510EE6C3CA65B02FA2E89B6CAD4F4C5A468DBBD842163
      972F4A1AEBCA51B27BA6F18EFB50EB08A366B7F61CC9013B4A2DE99DA637483D
      91B384C95ED86DC6AE5F179667296DAE1435B76401434E8EAD94BD3B9E85579B
      9628E0817346A4A76A97341F8B1A33FD05B97C23621226350167D07A49FDC848
      1AAC6A3A9BD98A6DF370C6803F4F6DA38FE8224BA5CBEBD6FFD185ED5BBAC52A
      62EB43567EB02EC94C60A3AA98BADB63C5526C290DEA084B2B88619CC6EDDAF2
      2C129CAB8FCC6D7787B10335D7242A408F7C7869AB21999E2C6B06C0C5A8607C
      C1DB56D22E379D5C8867D0AEBBBBE91E10747206C7E90E8BF18785AE57BBA62B
      C3C80C25939E23E9ACF47C4D0A8599B559457B430329CE0C5EDBC118D02DBA0A
      3EA5696D59BDAAB055ECF6AABB8B69292F20133F19B7E7C0B83DE2C8975E153B
      4D78E4C10F3422F1BF94331DCDCFD3499DF865FDED783EAAF711D9A8E97BD434
      57051A639FBA269210393A3DDEA85A7BC240F2D02AB519E3B6AB45D76375EA10
      EFF3D26EFF37E77FBE7DFB567AEC40E48FA7720C5739426341A049E0285577FD
      AF7FE5DBF6CA466509BCB0C51E0EB38C76016CDBC95DBF68CD864E1B3BFAC96C
      D013CD5DC0575E98575B18BA63632D2F6EE1A9898B1358B05560255F177828F7
      6380FF5DC6D26A076F0F0744D8FCBA4F8C3EE11DD7204F6D752CD3F16A11491E
      2D9982905E94FAC43600B7FB2CA32F4E41056F84CC48E56D09A11BD44C25B119
      A5EBFD06BE6525F5BFD3139DC334FABBE614542C2EDB7CC47B1F3FECBF2F138C
      5A22087EDF2A83E7CF5EBE4D3F7F2233135B7712E946D5065F4F10BDFAC65515
      2F3F648BF37DFEEC1BCF9804E3B79EB4542210F7FFE36EE1D77FC3055E3EDBDA
      5C31F1DF65B675816340399D7391479499563B2390403C5401E7DBACC64B87C6
      1A4B6366833FCF5D03C747A7EFD36483B5BB3A896CA4A67282F0810B10CAD431
      B541EE1783B0A44B9519A6426660036EFBCBCBDF9CE2661C662393AAB188A01D
      098DC5576BDEA8D4AC0CC56972187153B0B584870C62919C97154E31CBF2AA21
      6799E6C5FEE2743A4AB5E9FB29101C185E850CC5DEE158DD98C8E16AA7E1F933
      6A919B9F67147B5C4448A1A1519D4D897B6D0C381A4794B1B916AAE8927BBFE4
      7BCEB69CFE98BC3313FF338377382044FE2C17D54DB2996D8456CB53D39F15E7
      DFC817F64E499DA177A614D8AA6011E0D00AEE883CB0EC3ED80C0FC182A0D843
      7681546120776B87121310287B9E51C7900694B491F658EFDA64426113BBDCD2
      39FCF60273E21E76533A610886BAC0A4AF8F0C21EACB4FE10158DA479635F852
      35AB3D85C2C8E416683529CA62704AD0352789F19DB5B66D1F6FE3DEAE535046
      93AB9F5FF2762AE768E8D18092F57EDFB251409538BD4AE339DC1EBB23B82DDB
      E22BE4E2FAEDE5222C79C09EF042B515F1BCA8DAA54A9EB95DC3CC31ECB223CF
      3678B9828CA33873E9CE3BCAB5E167096CADE6EA092E0C5B7C8699470331DF3C
      92F3FCD93BC610496DB55BC9E42637147CBE6B6AD5EA7D672DE1E24A5A510B5E
      82F89F87F5BD6293BD75911257533A2E27AF72266D474EA9EBE0A39C8C25C7E7
      C5524C3273784C19D006AA4D8D72EC881B4129AEBFDFB95BC23D91837339B329
      B2BC013185FF6FAA4C59A31CB06A98CDCEC6E478987C1F28F743E2948E441CDE
      9230FD1E4BB6491EAB25AA6F2D126AAB14ED36625351CD56F956A08529B5A9FC
      BC1EE80FD569096E160382182BC6889F7F672DB2809D4BDF4865573DED726165
      E98BF7D2AFF64F4E77B3311E4E70AD2F2859E1ABC5BA41A9ABF2A70A231837FB
      A8DC47A5C55E22DC70C8F1F616BAB62ABA3A41ADA5A51525651F485133555965
      B7DEBA6D2368710BB07B128F25D38321774CC7E085319934337B5C9A59F346AB
      E8A21C5E13FDCF43E019DC79094D70A3B356D8AAB61C33814FC26E8C497D63C3
      A44C7DDB2060CBB63B5C4A1C98C6F3540CE35CB3D310B1B39313379BE00F45F6
      95A0B749F530AEDE75F6F6F6A440724CA97EE7D4C6FABCDACEC60BDF2A66F4C9
      2FE50B7FE3E3167B4B09DD32C94C4593FDC6F8880DE635A1179F1BF4896E073B
      0A16BE496990822F1ABD35CDC132E730DF8BFAB4ACF4307D292225659AA59B6A
      FB69508C7EEDC230467D962E96E674980BBC32C1D2BFBD1AE4F75739E198C895
      CE675537663A142E6EE05B8E29237323201E5E82EFD4581FA7934BE795F3F6A3
      4FC529F4DB461C1824CB1A4D6C120E6DA1B7FEE991B55DD349349AC76B70FD3B
      E329DBA49E62A1B93DDE28E94EE6D5124851026659543984DC4ED77C70AEC64D
      A20DBBB7D210AB7C6A933095DE896CB07F4A5E7BC9270FE3FB6F7D52B38B2DC6
      EC3166015925E64B5BFB4412A479DE38095B3B8C789704A1AA89E125060EF5CD
      CB246B9F7A552FD45C2D3A02B59CFCD2D85A8D5B94B11D265450367CB49ECC2B
      CFBD179A670BB07B79A2C08C46DC4029E372F01DEAAAF3BCE8029A615514C0AD
      0037226F85C893D31B1BE7AD8724C55AAAE2D049FA79D3C4AF148623CA787424
      6B81F32F9792ABA69BC72A2EAB17EF509BCEEF1B24FB900560EAD1C0F7E76B25
      76BC9B489E58A44CDBAF4297E9E32631963AA85ED7B366E6131AE9F984930DDE
      9DBDE72834C7092DB246ED7B2A069DC3A399AC21D0F6E5F8308D203869306931
      AECCA85A859B897E93DB6770C14172C33F0BE1BB65B4DD758ACCC463A98EC784
      441AACF2DD48C9B54D2137519CDB815E83DBBCA4C81F93C1AA513E3A63905775
      FCA6BEA89C8D092B8737D4C0D4C46D3A55850D6C51BA8ACB9431F13496E97F1D
      8A97F25468BD055ACE736A9EBAB584AC669A9326C724D7F2C4C2F9E9FDFEA1F3
      29270B76C6875A89D06EEB7496CFA3D916B9125BFB8CC988AFEC877CFE26694E
      634D3BCE6440511459DAE8367ACE2E81DED3ECF2309DE5546D24FB5790DBB424
      88B1F8A643AD352A90DECDAC01B4602F10560C4D78C7398DF2746A04436DF6F5
      40C28FEF9CED952F0AA1E80883868F2A08FA3E57E72F262F08746513B25E41BB
      1FD95823F327CBDF1D32F8E1489D8B58539CE1871DC969E71B2567CF90CE8E4E
      7BAF4E61DF1B23FCD5DB8FFDC0393A7C776619BE96E24F9AA542B2D9B5851D65
      BF98699E66B949E98FA61F4D45C41AC66279B82907F4B6F649742ABF9D84E784
      6DD91C66B205A40CF52D3D8541ADEEBB0BF98FE7EF396FA84474B6E86CC8616F
      C94B12C5A0C612A21DA557B5885213D8E0C87A5E11438293DCE469AB2C0EB1A1
      427B55F34CD2FDD2F9A1366470A518445441E4D841520AFB35C1FFDB95028354
      6BC5C42C9D194BCADB84E42804E776566F53AB9D84E7CF48FC8BED7E9B92F260
      EEDA21AEC924E3200701F1D10416B210383A820DBB11750D0E2124592232555B
      70185F31BD29F5192CB99171254CB8B88D95252665131299BF8788107EB793EF
      D2FB469B7EBDF162FF7DDD74CE269D7BAA0C28499BA9559E6F937E90C30F4A08
      DAA94717AA7D5CAF645FFDBA2A537F35136FE4C00AAD20962295D01172D136AD
      D4C9473248B19E045F24D1B52A82B44D4846BBCEFEC1F72712B0DF758EF73FE0
      B24FDF9D988B3FECFFF49E6EE72752237A6BBC668C8EB8BD530BE8703733327C
      7736E2C69A5442AE5D8B0FB5C467585C2BA222B6995FAE99335FF9A2322C694A
      C0E9A914995CC34B3465BED67E2A6B7DA5F717D7BA4A8E39F701A48AB68C3DAA
      3F399F779D9BB5A0C317EA5E2A34BF42AB9C0E48A9C0B956B42DD4A1BADA54D2
      8916EAD9C57E9128A248103A2CB2E8123BCCC11C5A9433A4C5A79AC84092CD6D
      B37842A6B85E2DB32819930C3F3258D6097E972CC00958B7F960E9CEB3257E76
      072EBA90CD71B840557ABE78A47885B3CDC7D11015060891CFA14637D67E5DEC
      B089D51798B3DDCA9ABB67BD1632486F2310D4D68648C1119F95633721212545
      2F348CE65130698C651CE887049F9463567CCD0558A979DF2E975B732004BB0B
      EB96DA00B609D830176298B92E434474DFE302E352074DD125E2922A262E0909
      1C57A8734149F96F5C9AC0C2FFDB77F3186BF84C9B92EF55C10FDB15D3C4D14A
      9907F6AC7681E407DB1DB9D1D91554E5C3B262A2B58864D334938B4A6B943628
      92A5A090D045BC5BD7A21C8C2ABFE0C7D61B7A51782A17C8288B9158D5609ACE
      21D4CE63C2B9BBA289C477E6C332963E8D0B6759D0C801465D9487F373E3262D
      840BCA6971C8A0129915C5E2543218C6B6C149F595159672A250BB5BF43CABA0
      32ABCB02C85008432845F7D788485A86337BAECD693023AF9BEE9FBB5586B835
      012A02F1851CFA5B790CB33A518BF296996AF452CAC1A0A7537F935CC0BB8CA1
      706BBF6D22B8ABAC527B1E5335F9A5C0FD92C6B7B0992921C9A6BF171CFF9FD3
      41A7891A6E645B995AB98C7EA5D8D9663B990EAD609B8ED282E078168FC58CC8
      0395B1A939379122B077292E069589AD5CAF4E8BAD3A81927495E2898980CBD5
      EB35288FB2ACE56069C46D791612229B64A1940044948560008B5421DD5BF3D2
      6215B09E6A1E64801A286EBCFA3B16F35520A97AA2C1C85FC870B0F51555E346
      4E69C513A81A48D1357BCEF61BA997A74BD4029CB029496BB0C8540953D149AC
      51D148A6187F11B5E91A039D4F9BD756491303C91E593CF304E3A49136B6EAB9
      E61C8D32EB462DDDCCF48DF86295F6ACEB5E1E3C51622C8735E40790F233653D
      77D5D142768C551AB7CA00C5896920801EDC2AE5AAD9D464CE87B16F874B4919
      E16418104F8976930A346A4555CBA0B17734C855DE688CD5402A64736C591A5E
      48B6F4B26CAD4DBDECDDE2154BBD7A446F151957C33D9AE43253E775C180AD7A
      6291C1EC3BA6D4EA3ED4912273379D7117038AFD16E5859C827B41D96D46E68B
      50BB5D7CBE50A86631E2CDE1254C5C094D545E35E713605F6D76D683AB78FCF1
      F03B2C9A31AD379B8637CD4F2A671C7EA1CAB2EC2F43B631592774A23DB9A4EC
      2B5D6493FFB161B807A97B7AC1D906199B0A0D902AB2D4F88331F6FC98CEA0B8
      141B765C966FCC7FE1D7F7523C5154464C19EA375298CE00122E91CEF3F994AC
      11BB0486C226F96EBB341C292EFB417D58B0B1948DA793C6482773DE0A317557
      91A4807A5548EDC5DC3FE3BA39ACF603D32913F768F99D2CA2BC365BFE13AF76
      E8EB1C44D92BE6D70A5F7CCD6EA494B87639A181DD22A7015AB8C5AE962819D8
      282514B037644C17B192140CAE411310D944716E86E44D40719AFBE97D42086B
      A91A0D09A74EBC91F47CC20005AA84E82A530E29E7463255E0D9CDB8AF2915C8
      D135619E5D8AD94D09F34D4E9361BBEF39FF279B8B6EBEE4C38F903C3D4EFDB8
      DE18B42BCE2FB29C0BF0B9ACF83DE7423AAFAA0630E613DAB1273F4E8881A475
      CDFE28E51437E73F7E3C3DDB1CC656B91FB712716F157D101D2B6C0C4E30A53D
      330FEBC7702C4C2C9D8F4FCF9C7F754E4A274E087F55D05707A7F88A1061B418
      D3F5EF8EE9BBE38C131D1AD5B0F1CD3BF79C2217F0B2615A5B780FB680CB6998
      9ED1B5E2953A334986EA223BD93BEE69FD409F196EDBF4176BE696EE4FA790B9
      9215CC058E1655BB5645B0D9A5B6EEACD681F656AA7AD5325D4E422DCC359DB1
      ACAE5D1A8759987D3679ECF53EB76C3F8CD2317EA443DCB4AA2E30AF89CCBDBC
      FF27F7F7387778A3406D1AF1628139099373BD33EB851397323424C3D9B54719
      36F1C18CF20E6ED2EE3D60EEAAB82CE19B6ED5843400A1E5542CDBB3CCD93EB5
      26459C16115897FADF9A6756A525CD8DBA32AE5701CF47A3AC30E56FBFDBAC65
      52F5E908227A668ED5CA4331F3D6FAD4CC8A619436444D665403B9503044C0AE
      CD4214AC2BF3022E7DB419329470422CF7A2C04074345F27EB8407276FA2BC0E
      797A59FC4C01490BBDC373A46EF77CA6363768F63625885D5A632BDE86F6A7C7
      6C94C00A879629CFD674FBA4FEEF0DDB0A82441AFE99A6B41201867C97BC4F0B
      DA51DB4A5382F36BE7DD75483FFC193B592EA1DF48B4BE768A95EF9891EF875B
      4FB37C267717AF9D375936226FE75F9D336A90FCE76F0C9EFAFC199B7206717E
      620C2FF87BA119D7D4E26F2EE9E6CC3FCCF309B790AE4E570ACCCF1CAE94FD21
      B89B85C982FAC659424B97B658B2A4E59A9C9DF25215DF7C35687C92456071AD
      2D01A9FACE8C8F8F3579F00D56778F4E1AED823072A284A539C9429A6C3A9134
      00716A7CB9D048B414ABDF76DDAA557BA36187084AEBB6327056BC70E6E7AFBD
      4E4DA20A7F00EA704590A349FCE5E4F8AA3971B7B04BC9362103C91CD2D2B1AC
      CDA997C6014E380F43020DE702C90BAE1DD2B5F6F417F3734DE79A533A895F9D
      7E3C9504177ADE2BB1633857974BA62177A82A732D84C9FA7446E925993E69D1
      A0E965A50D679F87DD007F77079E8B7FDCBE3FC03F5E10F8F8C7EF0D3AF8A7E7
      0FE992C0EFD2257DCFA54B06AEEFCBDD7409546E9F1FD3190EE9A26E77D8A1AB
      BA2EAEA37FBDBECFD7F9412FF85D5530435BFFBE0C7EA5F2DB6B74DFA54EADA8
      9579FFC0F639FE73D3478424559ABFEFD52BB8CDCD2FAFCBAC6AA83B8D47E750
      5BC6E617D3F824E91E9C6BDE7753BA92D891D5189A3F344939FD6F9D515492E9
      7193D693B8F1D5B56B37C6AB550DB066B825C71185E10F2E7474799C4597DFDC
      90F9FAEAB1A694572BC8BB54F87132FA03E800F3FA96668CD3820FFD4DE39488
      C646AA4AA2B99C6375AB64A1CC13ABD2BC4C2B3D13FD291835A3C84657FC643A
      6DA2C4A7EB944B6E05B2C1368CB1F5BED4D6A942129AD63241BF7D0AFFCF593E
      8A4FA72AD2BBCE0B4A53FAE5D36F2F76C51FFAF6EB953D111A74777BBF13159A
      98B7B7B896348BE282BB5CB3C7574BD2DEB9B732EB9A2655D0A44CE510E531FE
      5C7EF807B19CB192A96EF4273A4AFE634423E6FE074CFA83A2E2FB3F62DA26D0
      601001C0199782B03552E705018313503977BC4C9A15ED72F1C242762B154219
      94FE3F280ED8F92A71407FB03C0E080782E380979A5B786111BEC2E1AE447427
      92C02EB5D4DE9EBBE7FEBB21E17FFE4A91083A53605AFE3A1D41E118823AB719
      E816EB34645D1E0C46B638441E79E239BFBE08FBBFCE54F88F258B99A42FBD80
      68DC77D75855CCECAF11CF0A3487DB857B1BACF3A870DDA5CB4BF73F8D732B31
      BC63E7CAF438A5F05116BF9B24D9E17C3C753E9F1E19D0C3D2157E3AABDBAC9C
      AC6C5F707076B85F5523B5763604032B99E33C17416523D8416FD779FBE12729
      1FAAAD5BFB266AB20F2151F63AED1BFDE7C05F00216CD1D025911A9E019B70DC
      999C738D39104FF33219A3ED9B59758AD5DA29505B5F5B48FD1546EFAE6523BA
      CB06E53AD94A2DDBF5FDC7AB59BEB9A99E4D4757F71CAAF2639E82BA85D356AB
      9781CF633AB646360E5925F43F91A56D80E1046D7374FAC96A1B5B67A6A38B89
      85EC15B7900FE28F4E8F9F9E1DB1B1121F5EE35FDE7EF47F73BEA3B6AD94A1FB
      EEC3DB8F5244F8E45672E5541818B4567C47EDA09414AAE75A72149D83033E49
      6DDFE468E025EA5503C42CB1279F96C0D9E892C6AE1B1DBDD39A5BC92B080162
      AC8DA82CEDF0F860D7F9C8F5AC90BBF56F8E4EDF3F39F6DE48E1155298514E59
      145BA7FDD3D1C90F4F6E1D9BA813EF153CD5DF042A4AC450FBA6713429E8D448
      D9E836971831985C36B619B80C10D8DE8883149E426AE4942F7C4DE089B05FCF
      A51481820E591C9B6A9F16CEEED09CAAC53713354E2358E17342AFC1ACF5282E
      9A4860A341B96AABCC2551CE58E7E7DCF67E165DEC393F13940075239ABD4C4D
      F9B01A4979D6C2FBD2C4F9BBCE33D30F8FFB49AAA2A0D3F04CCCEA919CBA718E
      0A657A954521069CC6BCB6D66ED762E4505E2FC153509A6E4AF51E74A9C02CC1
      26B765A08A2BDF784CD4520C8E4A2253B357532A5836D14FCF805FB9546F4EF7
      E9E52B4DA2ABCE5EAF7DB3A3C8C0373F377F59E09E3FE040A8CA2D65DE9C2A39
      0A2750BFF44AD25618A6394C270CD7171302071C51D302CFA252311620F85E71
      96A4DCBCE71CD207178A4A9DD9D5C17DD17CC4BA56EA90DE1FF62415EDEC6D46
      9D35466998D7B31D3787478F3C3CEA6E0E8FEE1AA4DE9336489F3FFBE5F4F448
      2CD203D67E70A80F46F3D0367F71B6C9ED30EEC9CE2E590C042F041F75B59F6E
      A09BC9C8B0FE0DF8E51B9FFAFFCB5E1445F78A382CEBEF73D84F92EAC9ED8626
      FE093761F8CDD992764D336E76263D7A8B2D7BAA23C5022D9C5EE9B59889ECCF
      469471356DA96D2F413DFC55C3FA68DF2C4E2F6FF274ECFC7422AD3FA87DCF7C
      E6D3EF4606BD863D3C51D277EFAC8148838FFDD30969A53DFD99D3E240A1EA83
      5DE938CFA56C8211F6129673EF2AA7CF5F26998F9F4A03A5854CF1FC59D909F5
      3539248397319C3BB81817FAB38A7594124CB7C942344DC5A8103DCFAE52E986
      E86CBDA170EA89241F969D476CD2E196383BA677A17990ADD4E3B4467E0AE33E
      B4917A63E8F3B42AEE053DCA631169C24A5C5AA4E37484C15345EEAEC5F51CA5
      D1A529553765EC8A8BAFCB5ECA9C9C312913AB5B4496AD134D695682B5D8C4AB
      CEA991D76DB2D8BE69FC3943DA4DD5A404211F4BCD5DCD9756931692EAF9B3AD
      836C3C651C14734EB89C14257443ECBCB9918EE35C2F4BCD7DCA3E89B53E9B26
      0546FAD9DC4C5B28E9A9D6573A79FC178C8C9DF76AFA5EE5F04C8ABDD967290C
      AEBEFC8FB92E666798A67C096EE0E61E13063DCF1B78299A913005B6C64007B1
      B48F608CC3F9E35A7A69224B4C47CE8C5CD53EB2A6B6DBF8DDCE79ED9BCC9501
      362304688B0B1DB3401DA77F572D9DD4A496F7C1EAA38C2CEF7F7AC7F10E4E8C
      65FEFC6B41DDCC276902C532A6706DAA46F87194C512FED88429BE2C4CB10952
      DC0D52F84F3A48F10B7BA4C64D3815CC5FB64B1B3001995CC68D7872EBDE74E2
      A747ADF6EF8C972A7E9DE3B777391ED0B3827ACD887FB6B2AB7DF3FBEFAE7A37
      9AF38B346777CFDBE8CEBBBAB3D74EDDB9A0189FDCB2FEF32895F92C7939284F
      5BE8AC6496AB493152334E6C280491C6042AA3E96BB93ECAC6636E86C9999036
      5AD9BED96F9DCE282432CB1A478BDA37C7D5EEF946233D56236DBCB9251A2978
      D21AE9F9B3FFEE7634677996678C75D17E3ECAAE29EA33D6949ED2C2999507A8
      6F39ADB044029625E3F8350579698E987E6BE7F9FC995943FADBACA3BACAD2B8
      70CEE55C9C3134720D1F89E6C9E8CD738255A31373732696EBC41CB015BBEC53
      41721943CCE40642BD8D9DD5C72992FC67909609726FCA103B04A52E2A9262DC
      1B55F285AA6493BDB44495F49FB42AA9C4D13E63347F7A73B46F94CA935BCB7F
      AE539C9FDEEF1F520C8925A31E4F6737068CAF7D53F96CE43FCDC6EAB637A7FB
      65B66A7B67048E330C37CEAE2C702B3436B5F6A0345BEE2337824556446AAA49
      D1B56FAE900EC71F579711B082A7ECA38F9E1067A34EBF509D7636EAF4AE3A1D
      3C69752AA0AB2D8FF74BBDD318222DBF71465A5DB6760E35386D2AD7E6E4E9C3
      77FBC76D9D0FF79FB2A9387936E746BAED9B8C8AAF14276DBDCF62AEA02F9C44
      ABD93C6F616832CED5F9FF17C39B64E5679A704A714C997666F2D0B616021929
      16EF2A8DE7549343486EED9B7A9251D99DB21DE6A5773076D8C7B6268357079D
      2DAF587DFEAC9A0A771730D9DA7462451910E62C442E78BD35D3C56C6FAA8841
      4D84A40C4451D238C358525AA1FF5F9C5B080BEFBF6014EE988E487874FB2824
      56962A8A2C4AB9ECD3567A12611AD5D73006FC57ABB0A1FC79ACC0372E24DCFD
      83A6EAFF934C35C9BC6F3FD3E600D25F79B293AB3F60B210367A52B4534C334C
      0D6C20E7637EAE26E9DFA9534C779743D5EE0E85A8B9C1534AA5E88C266FAA6F
      979F5C7F7B60DC97E3CC8CF1F5FF323F90BAF8B7AF0EB9DCB2654DB811CCB7DF
      822FFF364FA34BEA1C4B0DD4466934FBE6BBD1D80F8C26CFA528ED5BBDC91F02
      23F0F1F5B75EAA4A70343027B9FE4A5A3F67F3D99450F0B391AD4C26CBD0C443
      EDD11EF5B21DCFA30BB317A4EA19B25A8DA79068DFB87E790BD4DDDBFBF55748
      DA52D0FEFA2BECE0E2D75F6D8D6E4C382833359961225B8BE3E3EE2DFF6422AC
      3A16FA68BB9A5DA4B109A5104ABDA041A8689659E496364E922678984D5ECC38
      523FC26EA023E78226797672746472C6C012E5E9B33D2B763435F8D4F618BA41
      94573951AE8A8B1692E9F639FE2E11E24EAED9CB7F33206BF8A1AC7C6FE58187
      99F0CF5A4DB3C9ABFD7C9CE5AFF6C7E3F9C4A47C4EE90CABB8D07AD642A62FF3
      32DE7C3C3C7B85BF5CF617AA8ED37CEE58E2A00B6C010779A80701999C31F51D
      23716EAD0C873BA8CC5B0A6820D478678F8E0F3FBEF9DFCE0548326AA5F562A6
      B3F23A539A7E014E262D4E014827D6534DD50A137B7E2E25B29B73BC2F3AC7EB
      EC799B14CB250779C3277D90F7FC595A1473ED04C3D7B5F6AC8C1167ACA05BB8
      755452AD130AF8B38D20F9658E1AD355747909534758BB16E8BA85FA43C8D2F5
      411793A497C274FA2C4DD7A5E5AAF4A536A2E523E125435B8CDB3BD7C025F814
      411A68C038B021B399F8406A723E22C5998FD5C89C074B20DDB84BB64D7C5661
      16905BB2D33E525D64B34B7D53D4B13E2AC00E83FAB1FDCD232247B443BFB563
      FDD2F6AFDFA5DCD5A9FA0382B17FFAE6711F5E6BC2CEFCFA71F6977FD06426D9
      44379CCDD70C05FDCBB79E6E3A81E499B552E68C62E7F4224D660617B69829C9
      F710DB8B825697E994DC93594635605610E13AF8A6DBE4C3C07BCF21AA66F348
      B0239A34F893A7C3562DA8C724743B55560986AE2E2E67940A000FB185047DFE
      EC0E49D9C127D27DFCE141D9CE30C804449412EA33A83E35661241FE72E0C86A
      502D98C904B3DBDAD64CFA3381DEE87B2767C9C400C5EA4AA5239B1BD15AA03C
      19B869C38A71DEF0B914B50837E948586B7123B9FE089ACF04820B679B0A2EC2
      1BC7F8042DDC1807B37CF4A703C29DA696D0843FE67CA0340A1A3C379E1DA5D3
      30C324769DA322C2AF99A94D717EA2A24BD923ED9B76BDAACC807CDBAD4B3150
      E3F4C4F3089FAB51611B8A10FEB08081DB0EBD1CFCA7FAA6A28D85D206EE4AB2
      6534630835017063FCC05D10719C392FF619C66ED993744EA9372FDA47967A92
      D142BE540D9FA9784D6154E9BDC128883629699BB7D4CF3BBBB5A6B6CE9B3CBB
      2EE8107C7F34FBD35BAF8582A25C59DBD7B70915674E98659763955F1A9D69F2
      055F8BDCE9EEEDF51C7300A7CA4B771D2292FDEE3C7342155DB68F60B5C28984
      2668B1C87F3E393E2450CDCC1E3F4DB2EB5DE745367951D324ED9BEEDD9AC8ED
      5063C626DEBE4BA8EB652880C30F6D0C069859DAEC41452728844F09FB6102B5
      098B4071B15931A28E0C52DF0949301D69D5C0FE2E6CAF06E7269BE725285C9A
      98E60EEDA35779267372B79ADB4C75FBE7B3EF4F76F97462971BC6ECCA41CD54
      4D6FF279C1FB66D7F94ECF8EAEF464C600FE65875490B6AC8CFBA0AEDE7345B1
      B33DBB50934BD6E17FCD26D771BF858C56124E8A179922DB9624863176688674
      9A2B2D618F7F3AFECED93E1F65A11AF157F8E0C39E7376A1B945DF0B08E3062D
      B435282B48BF073FD0D9F08CDA9598EC6E53944C2F9BF153251A2469B40C5288
      DB6AF5C62DA23751DBB7D4FECBC977879873680F8B32E7E4E82D78941BE3892B
      D0D6A64694FE4099019C8A974B4AFFA7E343B7365DACE1A7FD831F20CA38E849
      F9D06D9C276540BCF9747668E50CD919A64821CCE21BCA129A491A048104E1CA
      0FCEA49DACCB533DD1A30642258B38BBE5E0E8F898B7311B23E752A8A2E47C87
      0F4A9396F62810B1E9BF32ADD44CA60FCFB26E867D7C7B7A56D345CE363B752F
      4E534EE23246EA0B1B1920632D497636A7C55F7A5ABC4151B87B5AEC2D5FDFA7
      725AAC8BA969AC64BAFC5266372448A8932C87B028C64F6E499B1E7E7AC16BEA
      065BCCE05E3AD08379323200FEB028CF735D145CC90689D9E44C1D72826241A3
      8C3CBEA98D10B68F38363DA0EBF55F3BE2CC08444369204069522FDD19750422
      1FA870DE9DBDA76A5A8E1743CD2E00FF4C34A18646F87AD2CAB423EA984105AA
      9425C95A62403581399B46C5DFE6943E16E6E0203DBB4B179346709E721C40C2
      84749FC5526510FA023ECC9EDE737EF99F9FD2D9E92C9BFED63E227134E7301C
      1D70D264469D3F1A10B6D66544722CB0E5D439055F5548492823DA89FA8A4835
      BA6183957D8CCC74E09496072D943FEC46941D1C4C2137B7A6BEAEA242A6490A
      CD32963E96AD74FF090C45F407ED14AB3C6E28613E9A11847D7421C797B30B73
      B6C4567861D3EF7BE2DB92B14EE0A4E50D7C1665984342F66DA4CE3D61E65DE7
      C7779C4A9567A35B31E7FDA22049335613EC947CD7FE1EDAF832EFC45606984D
      BC4354CE5F0EFEFF13675B4F6C2ADADFE904B63C8AFCF79D521B353047D9A325
      07BEE534F9F4FEDD696B01ACCAC0E99883755958645C944035DBA39A6DF1DA79
      FFF1F0CD2EFE3E3DDC75DE7EF7DD3EFF7D4A7F9F9DB676DE73D3D0FBF8E0ECC3
      82E349356D3AAED9063F9EFEF0C958D7EDDDC4A5163355737C9A8A15BFD28E1A
      A58A8E9079E60E0C00126F24F2DB3B5B31106909571F0A99E363D3E699E36C6D
      DDD26588FAC5A138B92F4C07F10BCD1534350BE6C54BB7EBF7FD8117F883BD0E
      FD7941064FA8B9B32F4B37B00845A54C61923C88A2CFF0D0FE7270FC732522DA
      47A85B87465B148EFAF557E99BE9848475536CD92C6A392BAA0E82FE1B9C0199
      E9D79BA6DB539BF1EAF8C3C47445E29E13ED9CBC5FC9FF9AE95F5703607EC643
      6C275A8E99A388C14FDF9D9CD40E13F0573E9F96CD12D5ECE23C27A45CE966A7
      AE5A19135898700DDDD88AF5F7DF1DBD65A625AB5304DA5F8E3F1EB45D869553
      DEFA71322FF0AF4D69F8CBE9D1E1166476DECE108F29096EA0F07EB214900486
      C555FFF0E9E0FFEE2E39E1DEF48EFFE283830D5EE4928383EE933E3878FECCC0
      2EE7FAEAD5072CD87BCDED842970639241E613EC923DE747583B2A217B0F9620
      1B84CC0199347F35250B7432A9A8F42C4F6B5BEAE9B0C34A7A9C6AC204E6E9E7
      FA6FF33427204A292A63A09F98AB8F2143E3164E4E965A61B12835E7368C4F93
      50B001ECA005A73E44C94D8947F082DCE2542AEF46747E4D4CD33E1271606EBF
      C6D1946B0C29A725795412A95B38AFADFF3D1F4FB9474F569A7962E4BC286CA5
      E4349BCEA78CA5D0C2091E4D28F8FECA04E1B9641676AB54859A9A8716CEEA38
      3B972D45C90D573ABFCE530C7C424920DEFB372D9CD0F367BF7C3E042B52DFAF
      991A51218BB68DD6738A1D53E60FC5192EF26C7E7E011D441F7CB227BDD89717
      8AC2535CE753CCD478BAE7BC9B39630E65849ACAA992F988AE9BD1719F83DD2A
      98296C0AB69360062E031F5D1656F9D6E035A5D29BD0F9294457B54ADC733E99
      1805FE3BF881CB44F8D093CFE35A488A6539437713561B50B4CC6995534D4667
      3E7B2F05F574687363F06477BEA54FF0055EC0EF6E239EDAC3AFD74F8E6BFE78
      03DF7DD206FE877ADB72B2FF5AB8F13FDC53E6B39D4EA80C52EA1FCFE7234546
      FA9414057DBDD3D299D60F95B7CF8E5508433426277BD7393BA082B663CCE64D
      F6B98DF33B359C68B2D45444288D50F71C7CB3100E723ACE45C07F7ACB6A8B8C
      70713721E6E1B834085268DC62142415C0B5915827E614B6B899CCD467E702F2
      65443286DCF3BCACE233AEC9465589AAA2A676C5464DDD5553DE9356533FA93C
      9566B9E9DF09C66066AAFBE960827B18B470FF7E9C33F0921C1DFE3799D33B89
      A877DDDE2EFE0AE8AF21FD3570B6E9AF6B55385B94FEC7557734F1AD8D116D24
      D3FBB4883682E9AE60F29FB4607AFEEC808016C6599C262955CC33EEE478AA66
      69988E52B8DD6CBB8419FE3A6C50DC33BD489DBF1CB1AFFE9723CF22BA1684E8
      5A64F39C900C280FB385A241A2CB6F54A13FD06CCAB0449139F34921611D6920
      C8E69FC1A0A3EEE8F3885AEF989386364EFDCDCD4CEFD3D49C919E9C8313E098
      E4147BE18499C077C274566C0E18BFF480D11D6E0E18EFCACFDE93969FBC88D8
      EB240FAE5293563ECED2B19A801CCE3F9E3FFBCF5F19C1F2D76414932BF39FBF
      FE0BFD486969DF78A8CEF7FFE7D3D1C9F1BB0F3F385B17B3D9B478FDEA5539D2
      BD585FA56A42005F7B90FFAFF0EFAB335DF468C82FDF6182C54B3FE80FDDFE60
      186CDD056D5B367286A05B1C7BD71FF67DAF33B83378A20AE57130A97067A713
      77A2A156FD61320C55A4BBDD4134703B1DA53A1D3F54C34ED8713BF2C7937FF4
      8AEB87BE5C170C3A9DBE6FFEC3EF7DDCEFE12A3791FF8218FFD1BF43F3338813
      685CD39557D17F2E7E0F707FD0C3FD81B9D65C47CFA59FC1A0FC335FEB9967C6
      E61DF5EFF17BCF3E8BC6827F9F3FA3DFF80D437315EEF487B52769B99A3EF7F0
      3D3664C7C3743C5CE3B9E6E781F93D9099F787BDC1A09BF85ED88DFB893F5089
      0B1AF5E2C81FF4DC7E60E8089AF5544813FDC73FB0CC60D5BC18ADCBAAF3D1AF
      51E27E0551F9457C8A09FC5AC01311F1453F91E4D09F3BBFCA89E04D1F9C9864
      D9CCFC1865A3E233FDA027F1E442E79AEFA65B285B8C641E3F4D245634FAB548
      6693F0AF8D48B3642F3C4095A7A5021AA7565229663A212C5A652B96631D6524
      14B74F4CA1D1FEC9FBFD5DE7C34FA7EF28BBFED0DD257C888F6D0C5F99591F5D
      817BC8CAA3302D43B539E7540B430773EF0E2537AB81154E3905A3F4EFF41029
      406A2D41DEDE978FC8E82136562F9D96CAE68EED9BADA94FEDF8CE6B4C994ACB
      3282E122701258FF54B0CC387DC5D8D9A61FCE2FB262B6C387C0E5D16E2B2324
      B6327730C0C40FA5A707876BC9CF23A04E67AAA86F47369A8FE1FCA53302B984
      2F84B9512B4E6E654182C154133ADBF19C33AC9473A104E524D7D37CE5303246
      C50BE7E73B842D8307E2FF8A2B33252E235DBE14254AB698C8DDEE1054B6A056
      177CCEADE298B60F285F14CE5F8E4F8ECB224ED35292D06625814D8E79894059
      A1E55AEE260A2D095335E702FA497A3EB1583A3627FCDDD9FB1612CD92AC0392
      F141520D1691AB5A192EB130CD6121AAD3D8D446177BCEFEA8C876D99ADFE27B
      9BE0D4568FDFA20807817688786B21F13ED6B2544C77313AB7228E629025A8F4
      19557AF2AE9244C850434D9153DCC2E99652CCADF6D7819AC2A32C71E44D8AF5
      444048B9C29E0B856A95F5714A0120323DC14187DA9CE1F2BDDCB380371BA5A8
      14D44291803B890F3701E34DD6C5CAA847F0A4A31EF5736E4ABF62D387845F03
      B1C937725099FAC1C544E7A92A60FD3A5BD4EA6BCBB9D437D0E36DB48D28BDA1
      86D26A71A95B3A930595F64DC3BB4F596A6D0EE0EF9158FD272DB1E89C6B3C65
      F72B83F4198DD892B139C7DA219FED3366CD195870E7C8D2C9E5C27446B04257
      9AFB326698C48DC11209F5453A69A39C3296B2DB234BD9A2989A0A68E944C708
      52541442A04B2D9C61E940B95DF6064C1F2003859425CE098C57CA5590F6928C
      08CCEE240CB9130BF051B51FE048D648DDC88197940991092C0E167F9D4DE068
      7DE0DE6EFCE41226840AC74FAC67B5485D8343D142FA5AEA765E75BB1408A868
      46DBCAD6194B8B8BB29E4A0A8DEA041E65D9E57CEAC4F346860319DF17F23C69
      8D416B46204CDC14633EC9F5286DA9BEB5BE6B1FB47C239D504DFADB8FB6712A
      F9E887A6FCA3A46041D8F6ED9D2E795FE2793A5B06F65202C55B60969135A5DA
      ED6276BB2482F67FAA179B2FC0D831E814C405FB9B9241B0E79C4A2C98167D0C
      29019DA346B6EE8CA508091C938430BAA11DC4E06E1C8C867A2EDAB8094A8A75
      48A4FCC471750243343413B14BDE36FD7674FA9E910AF69C372ABA3CE7A05FD5
      3F70948E53E3A4739B6CFC5BE2011A5A71F9540BA96469D46F62F4907E97E8BB
      72FE36D7C5CC2A22A3F830E15C0938A2913749AECE090244CAEAA1ED426DBB8E
      43533DCC97ED2D42B2440DC078477C74B150056C4A64095552D0E178D3D211CF
      445D8D19EF7DCF799B625BFE48393E74EC4501D65AFC8C3C659D2494227985FD
      5A6E5C8A584B544DD0965A4D3DB2273F1A939A88271C6739AA7040D6FFE08FF6
      0DFC12D52281141CCBAF4AE5F69C43D9A27472B46BF92CE50A5CC2DF4BFFAEE3
      8A8206035682730408D142125A0252E8FAA72C0535CE6EA6DAB47481C14AA725
      D3A986FFB4E7BC177214B21117B6DC3FBB6FFEC384B6249364E3A1DFF5D0074F
      DA43B72E85873DF0239F0EDB439C06BE4179CE234602A5631AA1BD6B0584B522
      A0B9E028648C13FC9A1D8A032AA649C4352C4303A105BF82D2A3561E3339612C
      9BB3F168A953591B73172A91CD16B869426F2C5193D72A00A806FC4CC1763AA7
      D6F4A6191DACCF17B392184444BE7CCF1E52C6992E988C05074E2EF4E2739D74
      75629DDC25EA96D388B104729892514806AB610A0D36D26F9380FF90D86B4723
      F46E97ACA72D7266E653C3F75B72641D669F21B6A28B2C97F85398CDA8CB1DB5
      C780D06AA1F85157594A587AE287118A7644787C9436648D40C8DCCCE1F2FE58
      87F3738ADE7DD34A9BFFA619E6834D86F91D01E13FEDDE17CF9FFD4C7A794649
      4EA68D9DD17F291D47CCD4C4B448D57031A992187261E543B9B39BEDA22B3653
      D5C599142F7EC2776AE47CD09FE7ECB99DCEB41AB3BF5A5C64A61D074CA343B6
      045471E9A8905A18F1384DD90FC4D37CDC4244DD1294E4936975B62DB98B3668
      B753F670226B520EBFC7D0BE36B822862391C1D6EF1FC207CE2661964F9CC3E3
      83F651C4D0638B20D48CBDE8BC3BDC5A96E669E29AED9BE319CDCD64EE94F051
      4B937878BEB60940FB26BA6F2AFB486AC80156ADBD363E34A764FFCB19743A17
      ED9B1E9FF6693E27A1D680A314BC1A6523F60E27B1ED6D6A3354A13EB8A0ADBD
      9DC3B7161B8695106852CA39891A99A0DA3A73A645EEF1FE87436984C944C30F
      EFCA1DB12DEDD917FBB2EFEC391F27B5DEB106448FF104C502D935ED99D3BFB7
      BE59FB3BDBEE7369DB0C32BBB82BB5499DD998AD5F6AB6F63766EB5DB3F5A923
      AF1A9BE147930C10A76A94F1C9E7EC666A5AEB080C7B776FF0E49677E5FC8EB3
      2682950F2B5EC5DA94F768673E4B06A65A88A265B99A14A3AA5ACA1445EC0A18
      CE0D4BDCF1586059214F29D5F27496F3BE00F54CD62521959A43915946A84AA6
      E541FB686AD069A144C40479551E801497E9B40055E21896976952B091AB5F2C
      57838D5CBD2B579F36E05D0598F9F1F08C8406EC0E367863677B9667F3903213
      39927FA8AE27E77382725EDD70BB68B59BFEB6EC8D483DB6F60F8E4C7EB98072
      84E9947B3DB1D36A8E29DE251402A9604F721569E776468EB475333117D87565
      B5E292474A0D5C952720D194D66291EE9B1C3B6E018829D10FB5CC76C6B5E364
      9A1A521B1C83DB96EFA65BF19A22BA19DEC4820CEF6D64F85D19FEB4D1E08CD8
      821749ED2739D18A9A82BFFB74786A3B708AEC7AFEECC9AD6DD3C9095CD2E111
      B538379964FBC707DF3BDB64F76F1D6AC145621942E759D05A5B6D5641AC8DAB
      8643942B302705C0CD750D0028AE7169F30A0602FEFE28ED79486159DD4331B9
      8C3114E8181D9E9123780AED234DC5075693C4BA89CB9449C6FDC4A106651581
      886D58BDF06E515796A842A5F691A7E41CD92821A1B9D798E0BDF429FBC40EF2
      B66D5809AAB0CCF777383183D24FCA1C436ADE30A902F0CE852AB8B1F8420CAA
      4504FA8501D06DF4609C169C13C4ADCBDADDA1EC5E808CD34F47C7ADEDC3F889
      6B385F868C0A5785458B1B58C463DEC65BFBD329F8556A47B70409629B131C1C
      75D5C04432D5940B0626B5E1A60E9EB3AC85CA63CB14DD0B2D5A38FE7D48F59B
      BF6B6AE32173A0107F9EEBC90CEB6C8E488BAF0168E4369B9819B0BB6CBCAE93
      ADB44DBBBEFF78E3946F6E6A9DA6A3ABD1F2F82D3FE62918A9A79737793A76A6
      E6087C947D8D93CEAFB890AB212DC2517A4591D593F9842AC444F07CCA334A5D
      C869428463B736381FA8F0BBD0FB363CDFEB57AFAEAFAFF726947F31CEE282E1
      CE3233A757F4C92BBF3B08BC86687C4F098BAFEF2EC7E2ABE3F0F5FBD57F8CA1
      A70D461EDD63B0F24AAC3EDFA0E12DC3DAA3FFF0BE2032687A16AFCFA0E82D60
      FED9E7240655AF4B587C8CA347F87ADE13C5D15BC95AEBB013460B0E7F22B079
      ED05CDDB844056B93FEFE5009D4A1695A4DC17999325D4FE8BDBBA923DC1AE10
      F9365B1FE9AC6B8B3C6CB11BDF506936A51FBCCAB5C2DB432AD92F9D260C78D7
      39D57F6364B65D3AAB2B717D761D3D8BF65A682DBE9D8FA89FD8944CE94B4264
      CAE2D5351590E1B963CF07380473B609C97EE9A999BF89B8DE15374F1DE6FE56
      360215003970B4B13DB03BE211F9AAEC8C9BA4D8BDD967CEB165000C693D9739
      6F3E9E9E32C229C7F72CBCCF936386A6A1391388B8A26A5FAECAA9F58207C7FF
      C78FA767AD9DDBC1D1F1B173ADE8348EC50FC1B9CDA71C450C3541D995B981B5
      D625ED9C6D03E6A7302387A3C71917C18DF4B98A6E9C930FFBEFCDC925055BFF
      6CB8DD0070996FA4A13845ABF1F77BFAFBE7A3FD4FBB1CCD87CA7D77DAC274E6
      521CD81E54CB2759066499108B21D9F9A450899678FDF4A64217B08129863425
      DD2102A585060735A4FFCDF990F15994490B3D7CB77FEC10D8C2B48DF157DB56
      B3017F18E198DFEEBF29ADB3D5799C8D4684B88A073951AE0A2A5EA23ED1A698
      82AB3138FE69ECDBC3E38316528CC0239CAD0A396BCBB48DA6463104ED63AC73
      D3209B8F66926C444A354D4C910A19F664BBB7504D9659BE04E904CBE6A63215
      C0089F03DF44B75BB8B0DF63959C83B393637625D8F011D7C2605E504F20E2F4
      849D8E958FE35BCBC3EA8D6BF168D7C2DBB816775D8BA7DD01A6B4258C7D2039
      CD16028D369144D2EB672358EE315D5DBCDE9C8E2C59EE169C8E1C93E011C3B1
      D875DE9116D8754EA71A56C1D35AD19533C10C5E2F4E60D7F95E2B0EA3CDF0F3
      5B157DAD2A9D6F39AD1315E9D7CEF72ACD3187A31BDDD6E539903E723A6FDBC0
      4FB41436B46DDC547AE0500FEAB60DFC07EBB66793D7CE7E3ECE7278B15A4D29
      E6BD3F1E67BBB4D537E6453BCD0BF25B5FB143FE334729754E798164ADFF7878
      220E96601751DB71E75AB1AD0A23A328D4B998F202230A8DA5AEDE0B62DD93E3
      85A6C13D1BC4BDE39D177B1B7BAA9DF6D4F3676F3E1D9E7183655BB6710346B6
      7573B104A825DEC20013DCC406DEF76426DC9D265C893C73468AAA5E605B3BDB
      93EC7A75DA45FD75ECF7D29BBE46B8EE1B1B71F0276729A12C0AC6F4756D62F4
      394816EBCFBF7F00FC5BCE9A4E281C65B02417A1B5ABC9F3BCDB38B162C65C7C
      7739F98B56CEAB8CA8954A88B1F526971C2F3F4CAF30B559963FBD60F9C64A69
      64A5FC46DEA27EFB17677A914D3495C55DB365624E5125346EB29D6B650F2DB4
      44EED61E168BC9DC3C3D3A37E6BDBC2D141843BF8C58C945A68B14C963BAF4CF
      72DDA884F836528D31EE677331E720C6A9B23081854F801BEDA39A3D9CE5C943
      8E35A9A0CF672FF5447A05329E30756BC00FD43EE0F4E83FE41C629B8A390962
      598E27CA5317E9D3A1A85222D22D26582937A56A8093E6DB898A2F551D07DFEF
      DB4A07DE0DB6BA43B0002FD488FACC83EF0528820E5F0F2922F51E7C7F434769
      AD9DF8A16D7BC907A9E66075572482929EA806C876419870D58B398C6EE1DC3F
      645C0DC788FB32B12DDAB09764D65C13AE2BFD264D0D30DBAD16CED01E917249
      1A062C15D304C761D198D209C3795395565CF5006CD1144DF9CEDB74445A9CF4
      D68139E496DA0FEA7E33D382D32B275AB2DE89DC50C0E920D0135EFF26DD3589
      27A6393539FDF80355BBCD8488E67142C65D0603965A7E01403480C1DC7BF773
      3AB3D0C3E7B91AEF0AEAE19DF198A809BD4BE7ED6CC76316A506FC65A33DED15
      1AA782D76D4258EC202C44C25E71351D31DAFF1D65E79CAF379F66DCC6AB8D0D
      58C58E1CA7D4768C902C584CF236825DD3C04E7A41D88593D8E662481A8605BA
      C8AB148692EF398A225D70CB16CC82F149AFA70DC46F678411AEBBC315FC067E
      1EBD66D799CE679CE631A9A781E45936B3692062FEDB2FB1363A9ACFF8696CB7
      E1E1DBB64C670F5FEE3A58D49FE4273D8B3688BF5F9E51E06E320AEE3AD34FBC
      BBAA54DE9DCEA7D3062B0F1BB285E28E1A8C561D5F24B10AF2AA7D13911A5E18
      7B2123B733742CC179100BCD0855935A1464791B9B289EE8B11E8790E2D3AC30
      2D2221FE2944A7291794A4FA587133A4969AB4156E9464C099D6626CC49F5EA4
      C9EC4F87E1E8609446972D9CDC2FFBA3D16FCECFF98D76DEA8E2C239BFC80AB2
      082DEAF7F69DB25197A5DAE2B031EFC46F38723B226FE9883CE75FF67431DDE3
      713CAE64F5D112758776A5710D2444C4FD23DBCAB7BFEC1F1FFFE6BC5D9DA474
      7AC6F0310ECD4C927117CF475A3BF7A3C377878EE27E6A4585F25C9E63B5705E
      6540B95EACC82289F2380CEF8E6ADF55A8A2CA7033B5A4B3DA6856218BB69018
      86142F47AFED69AE4340A8A47EC846770A4C36BA1000F38C7B8408E6F40241A4
      43416B27BFDF8065A44721454F4BC16E62DE1C34ADD5B2BDA28237AE77634FD9
      24EE6B6A5F90942A8148D44682716855529DDE67F10F707DDEBDFF786803CCB6
      57038545AE54CEA08E55FFD5D6CEF7D3F1A1BB883876A7B1346B3D98A5D83F2D
      9DA6A43C49D34839F6AEF721E3FEED09B5884DD2CF6D9CA18D7DD863C4EC9A12
      3D2FD2A9E55DA950C532523D63BB67783AC9AE6F9C6BAD18B5BA5E51957EAE67
      01ECE7B38B7196E59BE0CF17077FBAC34DF0E76EF0A7FFA4833FCF9FA555D9D9
      EDF446DA1F122AE103513E0F85533536295D9B0DF3A51B660388BE64C33CEDBE
      B1CF9FBDA516E4F3D9879F782B50C1E958E597A6FBBB45F84E13279E4FE12672
      DA8D9430632F5D51E768EAE6C4C55B4F6EF157CE3E61BB812B90258835CAB24B
      2EE29C3984C5689A8EB7B72BD71615DA933414149B62AB6C247291CD477169F4
      36E093DC9126DACC0B7AA6D29173959208E0A02DB9DA9CA0B591A25F2A453790
      E44BA4E8536F431B73EF0827A27037D5B72BDB07CE9CEEDA5A12DE32D717747C
      7B918D3800C185E47F9D8FA706AF4BCD5A0B637B479EB2D8A1494E757E69A529
      25A6D1548F2674A4FE294B272D04E816AFFA94BD6AC17AA408897CFA27F3F927
      9D37609D4BE748E8724674A1AC2E029F560EF7CA88E1D44A70929A93DAA4760B
      9EC4EF24F62A812538C9B37DD4A4DCBD85ED4339BC398CF49B3A6686668D75ED
      64534DD63C85E038C2EBA873CCAC7DB37EFE4C364C3A79C948F7763AD81BD2F0
      7D74E34414A5E1B94619352A9C5976A3702E5B6029A9119A2FA53D9F530A8F8A
      A84CFE5A1ADFAED6ED72F38490F247B8CFB4326CA33DF7FCD97BEE2123256E4C
      22F9E0C43494210B458A424C5C931AFFFC2CF57EAF6DDF30FD19A44FA949961A
      ED5A8F91A919E1CE4D57962FB170DCBDDEDE06A6E3AE81D37BEA6DB429C48A9D
      53143A9F2D83DF8FF039A533DC3D1BD86C94C76E94EE66A3DCDD284FBD71E79B
      F9399D47BC769251A63823664A162EAB6F95A78534AB24336644E9D95BC9FCEF
      7FBFD9DA73CEA8F53B55E1E4BAA0D358DA4B54D071EB312046A87379807924C5
      2B28CF54FF6DAE468C4809B59FCDCF59FBDF3836B3DE7822A3744C0D30250349
      45D13C273043FC6E6CB06DDF096F667AE7F68BF9CCA8D873DE48D62A277E539B
      37AA1A8EA4DACA0095ADB43756FB11F4EA427C2113A90875394399B644A8F893
      8DA4F95249D3F9F73F8884CB77F3BA246401B68484201293F0CB09B775A265E7
      19BF5E7204F6F6F6B6BE21E1BE8054BFBBD823A41D72231860DCE48F08220018
      6DA2AED273C92B99E55A7310E4E5BF39F7D1D490B4418AE592FB453249BC939D
      66FB25449C45240D35453D49B6D9884BD2E46889A423758EA220B99ADCF0017A
      9EC6B5DE978CB030A60522811519F4A158A240F41A3C6387CA6EF83716CFF0E9
      6151C96FD28E9823EE2C6E1B53829507151B143A998F6C510FBB876330544A1D
      EEE1FBCC29B965666BC660454CB831B2784B463F24F3D93CD7BBDC224B8D30D4
      6B35E1941735BA56370579A657346765A2FEB6C5A7B3ADF7CEF73082269404E5
      DF7EF43E09B82B74CA0D5996705EE98B099E45941DA9E9942F34EB67B26E2AAC
      0A33A15DC7D6AF8ED5253976B9A9A39A643608976B793CF974C40736E7ADFE78
      0ABAD02BE819E28DB37D4B93AC158BDE4EBD0CEFDB5A61B5B99A88A0D5927BFF
      E4C3BB0FDFBDFEC6B99FCF9F55313CA27E6D3329AE162A9888B214B2F578154C
      011BD7ADA44D2A7058A94B474372DBA5AE0CEB76293B8DD31ECC5B7871E705B3
      725AD84FE9B88A7DFDB23F2DB33FDD1DEBA99EC4EA36CB4CB4C0FAF375D46A96
      C505A57AF18EC537E05156916677521F1C6136912EB3ACA4C7C296E6C12B298C
      B35086B0B42022C8C4BA69BCABF7B1FD7665927693ADBC87D898CFE488A0E9C8
      36FAE336102395934C8C632E0C54D730A2B6B81D5C8DE4F8DE942B51BFF4F994
      7EF2BF7B239B219F4B93BCF984126B9413F821A863C7069EF899938237AEDF17
      1A64DE5EC739FACBA7A39377EF8F3E9CED1F6FFCC0BB7EE0536F342E9BCD1828
      E45E5174954F480A69717D2B3D65D7387EA67FE79804D7986296E25C357863CD
      C0C1DF54394360A931749E9814900C5BF26BC4E5D5465E6EF1EE57B48D6F3841
      105747242CE162CD235B7E3DCD082D2A2558085805DA54B55089B2B11BB60EB8
      19219D481C7111FE56D9F3BA85A977A0A6318738063FA9C938089C3A805A6998
      8CB36266516A4DDF59E3D58FB59AD4EC2E16B485D64DD69463FD0539C1D7248C
      EB3919E5F3E2349EBC98C917375C605AE851E26C53791171C0C4A9AA448BF1AE
      73705A01A870BAB371B1ED894B68E53E4D13D6D93BAE7E2831FAE90B016210D5
      6457D9802B09DABDD59CAC7C5E4E32692081E1D3B61C6B51D3FC5CB631EB0FA7
      4D4D0405938D9B54F0ADBC226686961430B6DF61B360052EB59ECA12D3D88A9D
      85F15379746D0217296DD4FA147806670BF337FD8AE564EA255FFEE9BB9343F1
      4AB4CA47D44EC830520B7349A8E8B09CABEDDC90C66CB0A5E3AF8656FA8D67F5
      667E4E29B47CE426C12C9321135D6469646B01422D002B16444CCCBEF6CDF6EC
      A281CCD1CE8F13414060CD605057AAB537F24B6CE24F7454983BFB07DF9F38BF
      48EBBEAEFF1B6D9323297CFFA458205656E829EE34DF9D72352468FF71CAFA84
      2B23E5066398E2357BCE77A9C4348D193E9557DA1426422BE25A0CEC4E592723
      9EE2DD85086279A42AF9FD62F1F3EADA0AFBEB2C1FC5BB5F2582C951D834A922
      B053DAF782B8986B766089B988BE524A22C036521ECAE7FFA530C683F8F032B6
      9AD63A56AD54AB67178DD88BB502C5B8CB55E32A3C32A1A4708DF5AFA5E3AE28
      8D517A2970095BD299C679F1AE6EEEC851F00BE784F576659E3871D6CA522721
      665591690417518D723AAF0BA79E95C4C70470D929E9C638954269D8D324BD23
      3EFC371060BC6FCCA5B1361F12F1D91117BE8D46543C2621197E31B85638BE86
      3973A162616106A3A96A26379EE1E33C4377737ABECC197CEAED3ABFA338D8A9
      058FD9FEEEFDE9D98E6C3FDAAD8C9F6495D36AD55264234AE99566F199E0DC64
      F9BBC35D0E4C8B69D24271B66F129B8C963BD1E762549738775CDA215462B759
      5C5AE5BCA5D342B979235EBE54BC7CD393C0A77CA075560FBB9A931CAE121DAB
      BF663913CE1A106A94CE6ECC89492DE213B26B4167E6261F0D0F342966C4D5E3
      318CD68D46FC3296EDEE6D209A96E8C3A7DE4F5620F7ECA15292E614F2A1D395
      2ADB03BA0C36297B066CB73FB9556E882B283DE15C72F41627C889BD6AC46143
      0C69A6A8B955FB664961A11243246AB0F69084E7597EE36C7D9FC670CF289CF2
      3E8B9DEFA8A86CCB368584A7126A8336C9564EFB08F3FC19371BB1FD3F314D6B
      A839D01F1FC82214E6A710ECB99ED5C24BF4D9448E4EC1FA8A6126AA9ECBED23
      4589C03C25A923CD503FA9D905163D6D6359DD3E56831309B6E613C2E19D6C39
      26504F8E3107AE245DCE9473D039B431F1B94146FB66FCFCD9E9ED38C3F6BC30
      10ECCCC2BBD6549F654E71994E77E940C2948AEE3A7B7B3BA6AC25AA270A7154
      70EBB48C2F6CED96BF7DC8265A8EA6B6DED1F1CBCC2947B0D53EFAA998920A68
      F673C9C59162045B4A6BEB78B22449A35435395EB4B833EDA305E7C82694225B
      69C888B5E2759E518284451986B95AA55671FD45D97445024D694E128562AAF6
      2049592EDCE6242DA1EF0EB391392633A6BC70223FAD7D1484B1A77342E2995D
      6B75599D406A4A4C498BB1D1A292F45483F88A46F451791AD6BE89B3464D4AAE
      49CB93C9264967E67C71EBCD3C1DD5A2C750B2725A4B92C5D9C64E2D9CBFCDE9
      304239A1A44AE3B3D44083418A475AF0F6C99EDBD973F6B931070754CBE49B18
      C2CB7430C7BC281E6D5E163B6F6EB6985BCB1A3E1333ADFA9B96156F1538515E
      DD4FAD96CA8CA8F6C230BDAF841F1D8FA8E9744487DAA6BBD27C123739A8CACB
      B29328CDA3F9988CE8A8A5B1FCDBB17A2E22CEB36B1B0F6357CE2928F5B2CCA1
      E50822554352D73A4EBD2A4FBCAEE5189A552D27FBDB109940AC7256A8C0C18D
      F538DB734EB3328D926C16AD8A94E314303A8B284FA790B984AD9D65972D141B
      744478431510E7CEBB17575C367B9EF1F9840A49C9FC7953D4F7254198953775
      37A54CCBA2344FBB2BD5E29905096929858D6BD965101565E3FAA7B3B2AB2333
      F6E4974BEEC938FC44393D9CCB76904D628317C54D55A061639EB3545FB73144
      5386570A679B3D0F917AAC13460AFAF6E9B58C6BE490DAE3B45A22DE5DCF53AC
      C51D5E4CC9ED7E2590389CE1AD9CBD992E7CD2A6656F072E5D29F3550ADA0653
      0A56109F70544615260FA5040875B68D0367A166295961AA0A734267CAF74B08
      D616D2FB93CDD0CB39F59D9B68D5EB8089B412EAACC8679A3149C8B3495A4DA8
      9D7358CE0D94B1EA424E1723B737C4DF64CC7CBD93A7BB627691F286E27D7738
      1C7A03DB32F71FFFF9EBBFFC4A29453A5633E5F43A7ED8F13A7ED7EF743A01FE
      1B486E940B4DA287B1EE24619224265F2AEAB8FCAF27BFF742DF0B9240F7FDA0
      477FF7929EDF1FF63B41AFEFF56257F707411C442A1A76A3D0D791E775BA1D5C
      D4F7074934F074CF8D7DF5FCD9300A5DBC7CE0F6F470E046FD818EFACAED4751
      271A0C87AEDF0DA2613C085DD5EFF53098BE1FC56ECFF75D35703BDD2088DC28
      1E7A5ED21F6A2FD45EDF0DE36ED2E987BDC81B0E8691EAFB4A2589EBBB2E5EA3
      C36EE8F77BB1EAC589D7F79378A8B0DEBD60301C74BBAA3BF0A2A0AB7A9D6438
      48FC50853A8CDC81D71FF4071D1F0F1BAA9EAB7AFD50079823C611BA5E3CD0C3
      4EDFED26C38EF2633751DEA0E346A1D7EB076E30E82431C8A9A31843EFC65177
      A0433CA5EB0DB4170D7D2FEEEB5EC70B83E7CFC24E37EE0DBC586BDD4B862083
      AFDD6127C418BCC40B7CAD225FF95E6730F0422FEA0C41381DA94132F4419B6E
      80B9E1D770E8F6939EAB95EFE22DAA1BC5BD61044A25C3EE30ECE8414F073D2C
      4BD7EBA941ACDD4EE276C241D475232FEC3C7F46C4EE25511240AB77F1021D84
      89170EF56088E18771D01B065118C5986FE80E743FF2829E8E220CA39B245D3F
      E8243D2FD183AE177B51846184FD44782521EE01BF3CC467580DD040F5F158F9
      B003E3A6CB3F8486D392BE0B1E8BFA9E9B80AFCCCF0362A42450C459187F5F27
      835E18838CDD7E0C7A63665D7015562251BD61C7F76879FA3116A4EB0EFA4930
      70DD6E18832334FEF693E7CF222C6B478521E80C72EB24E9ABA117275AE94198
      0C7577E86BA24E30544A7582C8D3AE0FC68BC260A0BBFDC08BC19C093818224D
      F9AAEFF63A180E98A73308F05EBC2324068E7A9DB8AB3C9029F6BADD50F5FC41
      18789D61AFEB621592C1201EFA7495ABB4EF067EDCC50A77621703EAC5A1E707
      AEEBF713D51F76FBDD5E12F7C179031A9A06CDB033BCA4D70DB0B1FA5E1F53D1
      83440DA26192806B40A3281A6A3F89BAB83F7123DDF3B12801B6CCD0F7A3005F
      051881EA625F25DAEB79610C9E1E043DA562BFABE34ED80BC1717190C4B2364D
      563608FBC361D00D0646620C542949F80F2407DE0029D17313F9F9F9B3FA6FF4
      B31FE3011AFFF521575C2B553099C88F3B587B97A40AD6B41FAB6EBF3FEC401A
      603142B0A9DF0BB0E9A350E9304C3032DF1B465DE577215F40D16102BEC60ED4
      DEC0F3FA918EC1C7D832E1F367980F7EC042469D7E271EA8A00791A3070362EA
      3EE48DEA63DD06B1F207DD080B150591C633BBD8607AD81F7441F1D01F60A3C5
      893F045B7A3D8C0DA2023C08CE88C35E1CBB9D38087B10553DB7ABB11671DCD3
      D8BF3E1805A20E23E8F7FA7A80D584F00697E14B4C040BDA71BDC13AF4F77537
      F13B719F399BBE0ABBBC02DDE03EFACBCFCF9F55BF795D4B731D41A22403DA2D
      41D70F353192977406710CE1168681F6F1B6308CA2EE30D0B87E1862A67EE4FB
      DA57031D600F0458B37E005186DDD98764C59C7CDA2A6ED4C5BFB187CB3D48C4
      38011F609F6097E1E5D8C309C815623304C39E176133C61DDCEBF5864308F4A8
      1FC750012E649D8BDDD7ED41BAEA04CF184286C5902A4914FB83615F2571D449
      D4B0DF1BF85873100DDC3D1CF65DED0DB1857B0ADBB11B0EBD002B8B0926B41B
      FB0A5B58055038DD08DCE4F97E6F38F087C44D2EA42D8613C79DC44BC2C120EA
      07FD01F484174403ACF79024744705DDB8DFF1741CBA90D343BCA113290F7472
      87205F6790E821C40D0603A674B5F68261BFDBC51501C8DA051FC46EE0C6F84C
      A9A8D7ED408F4256406AF90397E4D61062A34BDB2B743B6051482E2C0AB45B47
      D163B0D3FD08A22C0AFAB186760BC22EA80905A25DA810DF873A1CF4B11FA0C5
      31702F08608B0550BB03DD8118F374D877A11B07AAEB76743FF17C1DF7821E58
      4947DA253DE5BA3154FB001A324E025741F00E7BFD2881BC82AA87DA4CF03AF0
      0B89CD04E2760899A8B11187710FC602D41C28883B23B03A96290E1444854A68
      4E1DCFEF2A3084826508132B5451826D33ECF73D4FC10201BF245D059606230D
      6141608F796E9868972812F5A0B39241402A7BE863C9437C0AB5A0A3A4DFC71A
      4271F92104B34AFA305D3AD8583017301BAC04B14FD483E9825D0E1D0915D207
      6587B050F00144A13B180C3B9A14C840F7FA2A4E0611F6AF0E869DCE90E4BB8F
      F58F3CDC0E390FA6022907BD810BED34003B853E94510006036B07582F0890A8
      AFB1F9B109FD21480185EFC2C84902E22208825E27EA795A41037407CF9F753D
      8C24C17282B021B6D740F5C8CEA04519EAA137842A18E0F149AF0F8E72417188
      6FE83E48EB81DBED4338105B63AF75135009440A48E0838B31860EAD87DB0992
      9E4E4039C8309040871A9A6780D5F0FB507DD1F3675E44EA19CA17CA3FF6C1CC
      905F03D8696A18A8A4078582B1271A9B4DA961023649B007215A13DC0C15E4C3
      324C228D9DD207B3C421DD3254832E04ADDB233D898726F0600749172FE1DF3C
      D841F80B8A0BCAA287BD80CD03BD0B53141B012BE3F6E2084C10638374C90804
      A53A83BE0FBA430263CC312433F402F81CE61D742788E043D74611CC810E947A
      0F9705214DB4D3F5BB64B5829DA15A21333BB08AA092C9208D312CD85D098415
      F86010C11E8ABA3034F16C081508D04104411F0CC2012C8E10CB0D230B638179
      37006363F850B8DD1EB4441CFBA01DCC5E1F2641E262F3408A414675601A0F21
      547A51A2600406903E64C10D34CCC781C28322178AA90B5B2CF2210F06610776
      69388074EE43C1B81D052BD7853514B9D02CB826C03D584EA87A8C2EC2DC554F
      C13A8887103D587C17367817438B204FBB907B0368CA5E77E8915E52032897BE
      EFFA3109D101F6200C580FFC1141566312B137844C24331712C21D28BC0B02B5
      4F0FF62317460B14243EC546549D219602AB0E9E0777F541A5A187B1F9B0DFBC
      0158CD552444C174906F30B460FEF6E281EF296C786891B8A37125E60CA1E542
      62C10285BA83A90C450DFBA09B90C300C349D37E6676A7AD034B06FF81DF3166
      280888BC18D640A70FEB34F6638C331EB8D899FE30519A0C131FD2A9D7837710
      4255C28A056778B011B522691640D8C19A83A086F906337CD8E96A3C2FF13DEC
      0550A8ABA097432C126C474847FC08190C099740004396F5C00E7E0FBBD2A7AD
      06DD803D136B707C142491A7B08C21F85CBB1E4456027D03EEC0B03178ECD238
      0C7AA187BD0191A735368C1BC4D85A09791EC4340946A07507BFC16E867016E9
      0BD90D01AD7B9804D4217456324C60176140FD08CFEE42D8B8219E87BDE3ABA0
      8F35EB40E70D61AE9342805108D1D5097547F5E13C784117D67B0CCF077C03E1
      85DD86E7266ED7C306E8F4034824AC5D08690D3E1E42CD6075B16D3DBA129742
      1461A0786290C0FDC5D651781B5C21AC5FACF430800487EE1DC2A383F880E395
      C0F909496B4360C0E0C206847A04DFF642729AFA304D862E26072B143BA5DFF1
      A1BFA199E27008DB07C4F1B081FC4E44D6133613642C2C64A81148277832D8F1
      D04B10F260C50ECC06501E6F0FC1B1710F3611B12A442E040CBC2CF226C97582
      25D38773398425D785CC573DCC1BF31892460AE32882651E69F2DA60EAC0E009
      824EA0BA3DB028CC0008EE1E19A5B089A093A143210014743BF67BCF8389DEC3
      FEC48604FBC32AC2906168046040DFEF04B04E7BD03BF042616C0F622C1CFC46
      7CDA83628298872A873AC55E8326C763BC1E4690C08B85718C2BE1D90D14AC24
      CC109402F1307C980220880A3136BA0B6230800DD5C7EBC09090F5D0045A6139
      BB500AE40DF4B1AB2288693FC066D541920C12E81BB8B9F80DFA141E0DA80BEA
      B9434FC1108FC96F0457C0368A5820C3D80195E1264266FA305515ED4DB747BB
      271A602305B00D3C2C15F48D860B84B5C1573AC09E822107B9D4EBC79E222109
      C70E1E4E9FD8460DF1D801D40859D77DD8E36047C8DB3E9CF73ED9185805F268
      216A480362F7BB709815C604ADE1757D3C57C3FE708710AB018C152870086318
      39D8DE70CE60500EB05620F13071FB119C1F1F7AB9DB1DC61D109D5C5DA8338C
      85E6AC7BD0B31029C35E0442C1D400B93B510723801471873047B1CCDD9EEFF9
      F0E4E1636389B02EB0C98248918D069F2CC63E87AD074E23EF1C223F864A22BA
      FB70EDE0670C3D0FBE40087DA75CB016BC13082908F7B0DB81C1021DDF83288A
      B10E611F5B83221420990FAF2D26EBA503B13C4CE019F520ED3032C814D50DE1
      ADC26E20F9D0092317B692EF863002A1ADE27E1FE63284337C5E481C2CD99042
      3864AD847D08C82ED8179A067A862323F048407F7852F0083139AC250692D0C4
      C94EC42BA140E05706F100B62BBC251F57C3BE7161346005021F0E6D37027920
      036125C386E8F7213FF04180B5877913C14BED817FE19241F1635DB0CBA15F35
      0D13761C9C906E7F18F1FCE310FA88025BA0414C2A2E062742084790E6700920
      25C0B11869D4EDC0DF093B0926EE0EFB90CD9E261790AC2868B7586303C3E4A0
      BD069F17C65130841A04EF60FFC1620B750F6E22CC560A3A10B987C4DA1AD21B
      CB06DF89360DFC9ED8A711800F30C1008A012BA612AC050C0A983DB0D2208441
      FC61AC542FD1103D9EC293FBD85FE457838BE0E083E4D00A0A36534014C61AF5
      203842C8A53EB628DC787C0621031E063760FEA464C09660A80062368221051B
      187E23EC1A6858DC0793076A0923000D9B7A8B1D08AD616748A3152F3D144FD3
      ED3FEC2D56D119E8C6959EFB62FC867D78B24AB031B0A3DD3E854B9200122454
      E4F1809FE2C1001761EB90A3A47D0F8E213948708BBBF04562B889E4D10C605E
      4194411EE8E110C66D38ECC3061CC238C3A68A350413F632B801DA0817C0B61F
      C2C7809E1AC0EA840D08471C1A60308C871E544108D20C200002C8571D7761C2
      0CE1F0BA039F1C321FAE0FDEE6C10CEF63D3B950A830C161A3C02AF713D848D8
      50703015AC29783ABEEB2A4FC18C87EF16C6505E7044B06B21DB282C07731776
      2AB838C00240BF438B7431FC1E5C0A8ADA800CB0C306C300FC093509FF0B0B0C
      7315A2042623C92845E18708DB0CC69CA29DEE47F0587A60277038CC1E59B985
      D5876E7763AA7E5D3FE2FBD09F7A341856DABDF1E05563A068E043B1C0657FBC
      8E5CB3C88915A7AD7AE7AA38D5B23FD82AEE43BBA21E4359BE13568D6A55F466
      D91FE8A47254588525E35A16D9593592559261E948B07D1FA24F3DA6DB5C66F0
      487B9D8A023DF9AF67A26251D451F6AB7F3C7F46871D5136CAF222A2238FB181
      EA8257999827434ED39BFA1E442BB8173E954B7481FBE7C22BC6060E88AB7D7C
      0BD792BEED41DDFBF03ABD015D017FDFE711D3DF113D0174C555FD21713D9E05
      B31E76A7A293058801C8EA3EDC07F262605374640CD82B1EBE237F0E0E40DFC7
      FF3AB0B0129782149EA10CF63C9CA3A4CF6332F70501D190BEF3CDB72E490AF8
      592E3EEBCB98799630E43CEC12B886095D1F0C6987F20C7187276F86598399D3
      9C7C9856F2991F84F2195FE796D7B9E5756E791D7F8667D398F93CC83C63E193
      EA1AE64EFACCBD73D5DD277977AEF1EE5CE3DFB9C6BF734DEFCE35BD3BD70477
      AE09F89A01284E140D659DEC6FFC1D562288FCC52B6E7D86EBC00B8627E9347B
      322B6637235DFC3A2AE262968ED567AFDFA35F465974A9E358271DFE4A8FD30B
      AE40B09FCC2704F34159CDF693BF4962A0FD759AA7599ECE6EF0FB70F89FD523
      A515B753BBA3EBD4AFEF38D5B51DE70303ADFFF9DEAB870B575F683957EDFEF9
      F9B3C561CB5DD5A0BBF70F60F923DD3F7FE5077A5FFB81FED79F74EF6B8F31F8
      DA0FEC7FFD490FBEF618878D1E68EF4AB1C53E37E6E0C5BB9A31E9E23DCDF870
      F11EFF11F7F41E35A3660CB3784FFF11F7345BF4C57B860D6764B9C35B648F59
      166199BFF001CD56FC8107785F3E8966DCF0C0039A8999071E107CF9249A31CD
      030F68C6410F3C603D31218AD1793721D09635B7569265B349369384E7B5DEAA
      26B8CF6013AF7B2F89439DAF750B0D14B73C467018E1FB7859EEF5169E1A29EE
      77BED6F0675CB290254E929ECF735DAC39113DB9D2A36C5A8290AEF5EEF2E65C
      CFE6F97AE32EF9A3ACA4782C93540F586FEA9C6B2FE0006BBD7AAACE1F751FEC
      DA2F98B0BD9BB7C47A132D5944CD6717C477A95E6F9DC72ACAB3F5B832536BED
      0E7BDF715AAC3B3BBAC579331F8DF47AA282EFFBB0FE32F27DEB19417C4B5325
      B870D37A4610DFD24CD12DA1DE632665EE7CD4DCCCBD8F98A2B9F3113395F57E
      CC4CCD9D8F9AA9B9F711333577F6EE774EBB8BBEEC593A1BAD27580E461915CF
      AD39AFD3F47CA208977E2D8B64F119879211CCA9FEE7B99A5E386FB3C97A9BF8
      4D16DF3867EB5A09E55D8F336D7865A8BD423A99AF47EB853B1FC385E5BDEB79
      548BF73675E297DFBDDEAE7B6FDA6C7E5F1966CBD9F8167BCDC3D9DA9C7CAA46
      73B109D69CE0A19AADF7A68A81DE32528A61A32F7FC49A3CF1812C82EF8D9E5D
      6FCED5FBD77B6575DF7A2C787BCF3DFAB5E6F67505F11BFA617D51F1FD0DE19B
      A593CBB5EE7A9B11DCA38E17EF5ECAF8AEBBC8C333AAB837735B7EC3A2C03F1A
      4F2F5491AE67D01D66D19C5B6FBC57D3B56EFC44F530EB53F1E8E598DA53574A
      63BDB5FBFEECFDB173964DC9862534BDF556906E7E43C5A5E347DD6F9CE0ED9F
      75B8B3FE8BF761394F6EC68F99F0FE233C32BEF1205D539CC95D59FC88BB0E4B
      B8FCC74CF1077D13662A8FD77FEF277851BC3966FA11779F2AAA1D5CFF3EAA4E
      BCC6265C3B5EC077FFA4F2945CB1C73ABAC53CFCAB8ED6DB791F32F1A9D6B9E7
      A3D4438BDE5F3748BC70F37A327EE1D635B50BE1EB6635C9744F0CEC8C5D6102
      39BA675A354117696A080EEBBB7CE872CBE536BD4FA72AB27EAFBD285814DAC7
      0C1D707A5139C8E585B74D2FBAB05CC1F22A77C955B55995D779B78CB1389D8F
      ED7B4D60B8BCD67FE85A77F1DADEB26B0DBF2C5C18DC7BE1AD27F6975D4853BA
      FDC4C1BD17BAB7673FBCF7526FE199FDC5D53954F9E55D9AF76FB94D74D84EAD
      BD96AD62DF5D7EEDDD877ACB2FE4B56CCA4050321129F3EEEDF9DFC74BD50D8D
      98EA9ECB1FE6AD7B6E7A98C9EEB9E9016EBB3DF7FBF6F389BE4A0B1B5B5D1E8B
      F56F4DBFA879A60FD86F8B4CF61FF3CC28DFE52F595CC67793999E14BA765793
      8D73EF7A3FB087EEA1EC039BE99E3B1ED853CBEFB86F73DD73F5C3BBECBEA93F
      B4E1EE79D1033BEF9EA937D8826E33617ECFE5AB36E01D01D76C0BBA8FD982CD
      05FE3D773460E03BF369C0C0EEDA0CECAECDC0EE5A0CEC3E86816F4FBD0903BB
      6B33B0BB36037BEB31B0B71E037B8F6360EF310CECADCDC0DEDA0C7C673E0D18
      D85B9B81BDB519B8997973CFD5CD18F8F6D49B30B0B736037B6B33B0BF1E03FB
      EB31B0FF3806F61FC3C0FEDA0CECAFCDC077E6D38081FDB519D85F9B81FDB518
      D87F0C03DF9E7A1306F6D766607F6D06EEADC7C0BDF518B8F73806EE3D86817B
      6B33706F6D06BE339F060CDC5B9B817B6B33706F2D06EE3D86816F4FBD0903F7
      D666E0DEDA0C1CACC7C0C17A0C1C3C8E8183C73070B03603076B33F09DF93460
      E0606D060ED666E0602D060E1EC3C0B7A7DE848183B51938782074B748073A74
      1CE9C51395E53EFFE2FCAC175FDEF8C0E98D77F79C7344AD75EA2941CB6F7497
      BEB3C99D8B447A9365976BA409944F59E4CB3769384A338E8DDC7C497AF4EDF8
      ECC783F23CB37E99BFF4188A83B98B4EBAEFDE7BE1A233E47BF75EB86874FAFE
      BD17DE3621FCDEBD972E8A517F713B31BBCA752CF016AF0DEEBBB6BBECEAFE7D
      57DF9AFEE0BEEB6ECD7E78DF75B727DFBB774E3D96170B8FED75EFBB382877F1
      E20DEE7D37F497DFB0926CCB833C0FD0EFBED8D303A4BCE71DF7D374F90DAB48
      7BCF5D0D687CDF9C9A90FB9EC935A5BBBB2EDD1B33F07D31960674771F4577F7
      D17477D766F27B27D794EEDEBA74F7D6A57B6309725F2CA129DDBD47D3DD7B34
      DDBDC771FB1D55B19AEEFEBA74F7D7A5BBFF286EBF23F8D7A0BBFF68BAFB8FA3
      7B6F5D6EBFED5535A07B6F5DBAF71E45F7DEA3B9FDF69CD6A17BEF71740FD6A5
      7BB02EB7DFF61E1AD03D7814DD8347D33D7834B7DF99DC22DDD9236A6C04D6AE
      7E5087D6AE7B5084D7AE7B5082D4AE3326E08382A376793323B076433323F02E
      D91A198175FADD73C3FD84BCD76ABC9FA68D8CC03BC46D64042EA5F13D773620
      F6BD936B4AF7078DC065746FCCC0F7DCB09AEAB70DABA6747FD0087C90EE0F1A
      810FD2DD7D1CB7DFB6B71AD0FD41237019DD1B4B907B4CB28654BF633AAE41F7
      078DC007E9FEA011783FDDFD75B9FD8ED5B89AEE0F1A81CBE8BE9E08BFE7AE35
      A87EC77C5C83EE0F1A81F7D3FD41237019DD7BEB72FB1DAB7135DD1F3402EFA5
      FB8346E08374EF3D9ADBEF4CAE29DD1F340297D1FD41237019DD8375B9FDB661
      D594EE0F1A810FD2FD4123F041BAAF874BF01EB7AC9F867D3A56F9EC91550EDF
      ABE262A6D62BF0FC7192EB221B51BB0F3BE07F70A7066AD250CCA8174AA7CB58
      471DC177EA74BA069FE9F9339FE0DE1911C8735DDDF3FC6E6FD01BF8B11FF508
      35A91BF882A5E405846BB4F44F204F8A3B51D2EDEA8EEA86DDAED2DDFBD19DE4
      8F47F8C57864A29384D19EEE43A6EADEFAF7D617747F52A28EDDFDBDFCFC77FC
      43689AFFBC7F36B3FFE7FDB364F6B1F9577FDB91FC117F366BFFCFFB6733FB87
      FFF4606B0489FCD7F7C5F4F06185045A7EEFE383FE709595F0F83F8C74D9BB5F
      EF77A240C5C3C160E826DD98C0A9831E46EA778681E7F6BABA77DF7335EC1CD8
      4DB088C2CEA017FB9DEE7D16C753F9732F051EF9E7F9B3AF39BA6FF1E76B52A0
      7DB3A73F5F8B028F98BDF53DCC9F7FFCE3FF0146B4BE2C}
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
