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
      789CECBD6973DB489628FA5D11FA0F18CDBB61A99B92B171734FCF5C5BB6AB7C
      DB2ED7B3ECAA9957ACB8019220893608B0015012BBA2FEFB3B4B662201125A2C
      AA4C37B367CA2241209179F2E4D997DF0659317106C1389CC44132756CB73D08
      923CA27F468BA9E3B6DDC172C4774C3CA76D7707F8C91EE4453E9B8C87A3195E
      6CF3D738E5AF1DFE3A8B2A5F87917A1EDFE5D93D477E9E84F0E6DEA09885F350
      FDA6BED57F1DE5F66F83499A14C530860FF600861E47D66092A5F320194C46B3
      20CBC302AE2FB27FB8BF0DFE345804499A8796EDC2FF756CCF6EDB3EFCE7C227
      FFF78FD13CCCAD1FC22BEB033EFE97DF6148570D394FC761561FD3A98ED98571
      FA34368EE9C398E7E9328BC20C47FDCBEF870730A2D73049777D92004E1B160C
      FF7561B23868F7F78BD57C98C63437A75C6F12C5370FB4F6BFDF7F8E92E918FE
      CBC5BC1CBF61628ED7D90CBFDAA8BFFFF80E867B1B7DC2FB26415C588327C3EE
      E049D783BFEEE0C918FE06FDC193493078326A0F9E84FDDF69195ED38B376E1B
      6E176F1B6E9F8B200EE6C32C0AAC7741319330EEAA21F3AB28CF6F1E7242BBE5
      D2E072C8388231697ABE772F1418C2BCFAD5C1D2244FE320E73D73BDFB4C6D28
      1089FF0334FDFD229CA6A1F5E98DDCB58EF3D06DFBDF72DF6882310CF2F7341B
      D011DFF681A2298F87DA1B1E3CFB2F44BA59A44DC2BD1FB6789BB1C57A1B4D67
      8558E4501FBFE9C83F802EC13645891CFF5E07E81EDB54BEA1FDF5B6A99C4467
      4B875A6E50397277FB1BE4B77B4D84DEEBF1B056ED39EBFC9578B4DFF4286EF5
      E64757995898DF4C11F0978D4F7F9785E1677E77C76D7CDA6D78FAE33213CF36
      21BAD3ED363C7BFC7D38CCC2AB133140230FEA36C1ECF879160CA3D1895A7D23
      AAF63A0D43BC007C8C4662069DC6E57B4D33F8290A8B24808BA15846B7D7C432
      E4DE3B962618A87DEFF61B9F131B5F7BAEDCF49ED3F4A8DCF5EAA3DA8EF71A65
      1CB9E5D547D576F71A39A3DCEFEA83D5BDEEF9CD4F6F02527DA37BEDC6E7C54E
      579FD777B9D7695EB2B7E9DDF52DEEDCC61A2D49F0AC9FC3BC8037DC87F0D102
      BBFDDB09882EFA482CEAF66FA71ED5E756BC9FBD6666AC0847E5C112877AF6ED
      54A3F228E1102DB3D7CC5BD481AD3CAAED63CFBEFDB4569E5DDBC79EDB6B602A
      3A9099BD0BF8F6DC7ED3231A7CC523EA80F63CA7E1291DB8FC940657AF4934D1
      E1CA4FC963D9F39A24CC920ACB672A27B2A709E2F507EBB0A81DC69ED76E7A54
      DB447E54DF3FAF89A5EBFB27DEB8B675BD3B515996BDD5E6F5EE4462E543E5F6
      F5EF445FC573DA06F6EF445CC5736A0BFB77A26DE2291DA0FD3B1136F16015A4
      429DE8DD7E20A40A22810A0FDD7E24CA8704B9713AFDDB8F847AAA04293C77FB
      A150CF9584069EBBFD60A8E72A27031EBDFD68948FAAB3C18FDE7E34D4A3DA56
      C283B71F8EF29DEB5B89D6885B78D4FFAE33A9750DF08B85D8CA280F9167F581
      9C8788B69581BE5CCAAD0CF31081777D750F917EEB633D480CAE8CF45089784D
      E9771F5376AAE9F6F7E0EFA4BE4BF4AD8C7177862FC650C8AB0F730F09808729
      51B732CCDD45021E46226E6590BBCB083C480D6D2B63DD5D6C1063E9485B19E9
      EE52048FA4A16C659CBB8B156246EB08AB1B70BC2FA6829551BE900AD686F1BF
      9806AEADCBFF722A5819E6816A7F65AC075B002AA33D880A5646DA825D40B7D9
      F95F8652926794E37C3952E9C3B41FC858CB81BE10A5D616D67E205255C67A38
      632DC7FA72945A5FE316904A37D3761E9FB196EFBA9FE22CB946F9FC3DB5E8DA
      E3DD2F51A72B03DC53B35E5B40F70BD5ECCA185FA271D7C7B8BFEABDBE9607E8
      E1BA21BDFB1046598EF21075411FA8F710AA5619E8418CB21CE6C1EA4265B407
      52B5CA580F6594E5480FA569B4D0511AA759318CFF32C8C2B13D98C2AE24F660
      182F437BFD92DB6EEB17E1EB4D977900FCB66188DAE5DABD0D4334BC908770DC
      9E7E11BEDE74D9FECBE1015EC6EF1B06A95DB6AB17CB41365E5683F45DF1037C
      A01FFAEE9DE06CE366FF09233546B305920AD71D60A0C72010EE390CF3505F30
      22447C695BF2C145B0B06085FF88AD411CD9830CFECB0307F8561EBBED3EFC3B
      5FC68533B88AC6A3225E04D9E02A0B16F05C00970741BE08E2C52CC00FC9720E
      9C2B5816E92018FF7D9917190AF23020CC35C67FA22258D8D6EF8324FD07605D
      3A4F8BD0FA6D9017AB38CC676158FCF6C74D62901531C06232CA1D5C7C205C8E
      01013090D136309922E3DB6C095C1900A3C5BE10C06F83F76034CDA2313D962C
      B41192058E610DF224BC2EE02DF93F2669360F80FFE78B2C4AB3A858D9D60F78
      09234C60AEB95305D3D0B10958F8EF1017EEC037FE7B2F70A5CB020014C6E165
      18DB7706DE2018C20A6D841CC8CF0D901B0EE8D74DB0FB0C220F0840A01EDE0C
      1F5CF830C8C3719AD80258F0F21C66F5D9696F845ADF42D4CAF268DCEF8186EE
      75AC591860748DE5E0A1C9DDC707A3F32560045094608465D70109BF6F02E46D
      E855039E2B81D7B927F05C8185DEE383CFFD12F0B9DD9BB0107EBD3FF036E09E
      27C1D7BD27F83C26D83069182A188FA322BA0CE1EE3C9C47B3683C0E13F8B24C
      E063B884376A633AD64B069DF56390055300E5CC7A9D26050D08532C72C7817F
      B2F46A3C28B24991FF1C8D8BD90B0FBE2CE045B163F7C4C7ACFC3889E5EF9342
      7D1AAA4F197E1A0D1701D05EF830E10F435839B021FE5BAC1621DC955F865901
      E2077C1A66E34CFE8DC5DFA1F89B89BFE369AC3EC96B33F1F7D2BA8D0FC06A1F
      8513EC0C1F709C1B50E2F080D981F53118C6A1C2A7B68E4F4D147AED44D84C9A
      15192E29052228E338FE4D479F2BD8B88EE1DF4BEA6A9D8374A9A6D5B97D5AF8
      D60DD382CBDAC953D371EF371DB73A9DEEEDD371BB1BA78397D726E3DD6F329E
      9C0CF1F1DEE390D07B603BAFD7BF01D3FDEDD04BA7579167EAF099E76922451C
      DEA77EE33E4DECEA2497F16034716B7BD34C4E6B1B03D42BC38D942F76EDFBBD
      D871D790F4AEEF7E9DC6717A158E2B73C8DD4712EFB68615B0DC2FC48B7521E4
      2632570797207AC73F87C313B55B6EF36EB9B48ADA9E61F0385DFCA21D3B3CF8
      FEE3BBB7D6793A5664D7F51A6710ADA34C547BF1BAE4E0AE1F8E5773D8CD3CCA
      193DFC0A7A28144001E0BAEF74E05F0743548A6BB70B74BDB8F63A1D1FFEF8ED
      1E70ECEBB6DFC75B3ABE83B7743D8CDCBFEEB9BECF4FE32D80695D1AC6EEF7F1
      26C7E9A3B8700DBAAA8BB7395ED7A7FBFC4EBBB365CC137B7603E6F1FE6D05F9
      7CC950DAF7211888003F66216F5C118E152234F3DF9B5171238FF375BE5299DB
      2DD3A9703BB799F9D631B332856642BD884F4B52D9CC4B6BA3D79778E3F82335
      7EEF665E5DE3D2B71F2D77ED7517459626D3BFFC4E6F8CA3BC2850A4FA8D3EF2
      F770BE8883228CC6AEDF81D302878A7F25056540FF269391EBA98F89FCFCF791
      8DDA1B7F44ACC74F13A2F9E24B5E0420338344CDDF16C12814BF805C1D2685FD
      1B7F2B005B074F6C67B03CF5FA8E67FD174288DFB79C0FC30C2803E5B0E4ECC5
      0F08BBA253AF8347AD0B17FF3E126BC333EFD201843F6801BAF352EEB8904B98
      6C021F61CBE4E26F5F57BA693D6EC37A1CDFAF2E882EC0C8F8F79197749705C1
      B2E556B9FDCD5BE5D80D6B739102EB6BA30BF012FCBB036BBB6565489F9BD7D6
      EBD5D68617706DF077F7D776C3CAE05F3CE9FADAF012AE0DFF7ED36BF3BD1AF9
      A00BF00AFC6B915FE09B5D1BA68B54D64617E015F8F72EBB5692F7DD5B5BB746
      49E802AEADBB1D4AA2A8FB1FBFB68E5FA32474015E817FE5DAD07765C130F819
      9877BF0F27D1B17FDFC8DA4F31ADCEF37ADDAEFB189BFE2FC2DC71E15FB0C7DF
      3E732722F770B4DD75E6FE20C1E5DB66EE370A2EC4CBFF65997B4D70A9B2F76F
      786DB730F76F5B70792873DF61C1E50B98BBE37A7DCFEBB8ED06EEEE7680C0F6
      1C5B838B04C083F7FC5BE2ED72D1DBDBE26F86B7DFDD166178BBE1ED86B7EFF6
      DA0C6FDF1FDEDE76BD6EDFF63B0DBCBDEFB57DD775FDDE636CBA61EE86B91BE6
      BECB84D43077C3DCBFA5B519E65EB1CADBB6DBF37CAF81B9B7E17F4EC7E9F68C
      E2BE85A57C33EC5C5F905CB961E7869D1B76FE2DAECDB0F3FD61E7EDBEE779ED
      76AF4157EF395EDBEBD96DD7E8EADBDEE36F86B91B5DDD3077C3DC0D73FF06D6
      6698BBCEDC7DB76FF7FC6EAF5157EFF77BBDB66D9CEC86B71BDE6E78BBE1ED86
      B7EFF0DA0C6FAFF076AFE7386EBBDD101EEFB8AEEDB92EC0C628EE86B91BE66E
      98BB61EE86B9EFEEDA0C73AF3077DF71FCAEE33458E5DB4EBBD3EEB53B7A5ABB
      51DC0D6F37BCDDF076C3DBBFC5B519DEBE37BCBDEDD94EDF77FD6E83C7BDED7B
      8EEBFB5D131D6F98BB61EE86B91BE66E98FB0EAFCD30F70A73F79D5EA7E77A4D
      E1746DBFDBF5FB6DD758E50D7337CCDD3077C3DC0D73DFE1B519E65E61EEEDBE
      DB766CAFC9E5EEB57BBD76D7EE19E66E98BB61EE86B91BE66E98FB0EAFCD30F7
      0A73EFF6BC4EBB63F71B3477DFEBB59D4EC7B30D7337CCDD3077C3DC0D7337CC
      7D77D76698BBCEDC3B8EDBB7DD7EA7A9967CDBEDB5DB7EDF35CCDD3077C3DC0D
      7337CCDD30F71D5E9B61EE15E6EEFB6DC7EE390D01756EBFDB736DBBA7B78931
      C1F286B71BDE6E78BBE1EDDFE2DA0C6FDF1FDEDE766DB76B77DD06C5DDE9F5BD
      76CFEB986079C3DC0D7337CCDD3077C3DC77786D86B957987BC7EFFB5EDF6EEA
      13E3DA5ECFB7DB4EDF7077C3DD0D7737DCDD7077C3DD77786D86BB57B97BDBEE
      75BB7E538757C7713111AE6D9BD2F286BB1BEE6EB8BBE1EE86BBEFF0DA0C77AF
      70F7AEDF75DD9EDF6098771CBFD3ED77DA8E51DD0D7337CCDD3077C3DC0D73DF
      E1B519E6AE33F7AE0D5B6A7B7E53151BBFD7B1BD7EDBF48D31BCDDF076C3DB0D
      6F37BC7D87D766787B85B7BBBE03BCBBDDE874EF794EDF86E18DE26E98BB61EE
      86B91BE66E98FBEEAECD30779DB9F7EC7EAFDD6DBB8DDDDCFB9EDBF61CBB81B9
      DB2564ECFB82E54E9070E13FFBAC0E0504112C212BE2D16C3019E58E35082600
      89B8C8F8C243F8FCC63595BBBEF5CDC6253A0F5BE217B0FEFBEC9CE2EE0F5CA5
      FBB0557E8110F010FCFC12F10657E93D7095F71707B6B4CAC635D2D9AFADD27F
      D82ABF403078EC55D6C5395C65FB61AB2489E07E22C21FB84AB1C6CEDA1A599A
      BDF32A6F1117766395DDBBEE249EF58DABBCBFE0F0C7AFB2F7307C4539A126D4
      DE418470EC6EDBE9395E8363BFDD77BBBDAED3F9068C03A8CB3C9A79600B4B79
      247BC0D65C317F98A4BB3D7BC0230A76DF863D0001F087AD6D57EC0172D7B76D
      11D8657BC0436C545FC0E2778992DC68A37AB0456067A9E497B173AFE3F4BA6D
      AF214EAFEDF7FB3D1BF8BD61E7DBDDE26DF2F66FDA42F760DEBEC316BA47E7ED
      DB30D57C83BCFDB1FD4F86B7EF2C2531BCFD1EBCBD6777FD8EDD69287CE7F4DA
      5EA7E7B8B6D1D50D7337CCDD3077C3DC77818018E66E98FB1D987BDF75BAAEDF
      EE3456BE6B77BBB6DBB65DDB70F7072FC558E28D25DE58E28D25DE3074C3D01F
      8DA1B76DAFED3B4E53C67CC7ED92B6EE1A7EBEDD3D36DABAD1D68DB66EB475C3
      DC0D737F34E6DE7760DDBEDFD03D167EF43BB0EBAE6F98BB61EE86B91BE66E98
      FB0E1010C3DC0D73BF1373EF3AFD4EBFE33499E27DC7F53A5DCF33517486BB1B
      EE6EB8BBE1EEBB40400C7737DCFD0EDCDDB1ED4EB7D7ED788D85EA6DCFEE757A
      4EDB28EF86BD1BF66ED8BB61EFBB40400C7B37ECFD4EECDDB1DD76BBDD6B64EF
      7DC70516EF1BBFBBE1EE86BB1BEE6EB8FB2E1010C3DD0D77BF1377F79D8EDB6F
      771ACAD97A8EEBBA5EC731CCDD3077C3DC0D7337CC7D17088861EE86B9DF89B9
      B73B9EE3F7BD06E6EEB43DAF0BDABD6D52E00C7737DCDD7077C3DD77818018EE
      6EB8FB9DB87BDFEED9FDB6D350BEE6D475BCBEE73ABDBE09AB33ECDDB077C3DE
      0D7BDF050262D8BB61EF7761EF8ED3F76CCF77FC26F6DE6EFBBEEB19CBBC61EE
      86B91BE66E98FB2E1010C3DC0D73BF1373F7B13A5DBFD390EF7EEAB85EBBE775
      BA6DC3DE0D7B37ECDDB077C3DE77818018F66ED8FB5DD8BBEBF47DAF6B7B0D7D
      645DBB6B3B1DAFE719C7BBE1EE86BB1BEE6EB8FB2E1010C3DD0D77BF137777FD
      5EB767DB0D6175A71E28EF5DBB6F7ABC1AEE6EB8BBE1EE86BBEF040131DCDD70
      F73B71F78EEDE0716C32CDF7BD7E1F347BCF54B331DCDD7077C3DD0D77DF0502
      62B8BBE1EE77E1EEA099FB1DDF751AB8BBDFF1BCBEDF6E1BC3BC61EE86B91BE6
      6E98FB2E1010C3DC0D73BF1373EF39DD5ED7711B0ACD3B4EBBDBF7BA7DC3DC0D
      7337CCDD3077C3DC77818018E66E98FB5D98BB6FF7BB1D6C24D3940FE7F81D50
      DC9D9E099937ECDDB077C3DE0D7BDF050262D8BB61EF7762EF6DAFDD773BEDA6
      7477A7ED777B8ED33309EF86BD1BF66ED8BB61EF3B41400C7B37ECFD2EECBDED
      767A5DBB633764C49D3A1E2074DB330DDE0D7737DCDD7077C3DD77828018EE6E
      B8FB5DB87BA78B6D62807B3765C4757A6EAFDFEE19EE6EB8BBE1EE86BB1BEEBE
      0B04C47077C3DDEFC4DD7B8ED776FDB6DDC0DD7B1DB7DD6977BBC6326FB8BBE1
      EE86BB1BEEBE0B04C47077C3DDEFC8DDDBBEDB6DB2CCC38FBEEDF66DCF54B331
      DCDD7077C3DD0D77DF050262B8BBE1EE77E1EE5DCFEE387EA7D7A0BBBBEDAED3
      EBF57DD322CE3077C3DC0D7337CC7D17088861EE86B9DF89B9B7BB54CDC6DBCC
      DC51ABEFDBB6B1CB1BE66E98BB61EE86B9EF040131CCDD30F7BB30F79ED3F6BA
      6EBBD7C0DC4F3DC7B71DBBD33731750F5FCA3619BAB60649EABE1D547D304357
      2B2B39FBCEACEDB1197A75650880BD60E8FACAE4AE1B866E18BA61E83586DEED
      74DA6ED7711B4CF13D17D869AF67FCEC5BDE63A3AD1B6DDD68EB465B37CCDD30
      F74763EEFD76BBEF3B6EA72903AED3EFF81DAFEF1947BBE1EE86BB1BEE6EB8FB
      2E1010C3DD0D77BF1377EFF7DD8ED3B51BA2E83C50EBBB7ECF98E20D7337CCDD
      3077C3DC77828018E66E98FB1D98BB6BF77DDBEEDB5E537A7BD7733BDD7EA763
      DAC618EE6EB8BBE1EE86BBEF020131DCDD70F7BB7077C7EB7BB6EB3585D1F53A
      5EB7DFEFD9C6EB6E98BB61EE86B91BE6BE0B04C43077C3DCEFC4DC7DBFEB794E
      DFF91D7EFF135D4D2FC32C8BC6218C1187BF552E89A7BAAE0F4241BBDDA9FC38
      4A97B096419CCBE6B1B5A71CBB6FF7EC7EDBE96E7ECCDDFC58A7EB775DB7E7BB
      9B9FF2146FAB3FE7FB6DC7EE35BDCD6F98A42AC4BBF9B176C3635E9BF2089DFE
      E6C73A0D8FB9205B791DB7BDF9A9EEE6A7DA9EEDF47DD7EF2291DBF45CAFE16D
      2A2162F363FD86C7549264C376DB0DCF390E088E9EEF3480D269C0934EDBB5DD
      AEDD6DD870C76DDAF1B2C161C3935E1362DA9D6EAFDBF11AB6C169C0959E6377
      DB00D426B834E08ADB863DF7DAED5EC3630DB8521ED5A66D779AF0A5DD77E128
      7876C3630DE8D2EF3B40137DBF01A59D0674E9386EDF76FB9D86B7B98DD8E23B
      4057FA9D86D7B94EE3B6ABB0E086271B084B1971D4F05C03BAF85ECF71DC76BB
      69814D9445B9401B9E6B242DB22777D3BEBB0D18E3FB00D4AEE334209ADB802E
      653DB386E79AC88B6A40D6F05C137DB1DB1DCFF1FB5EC3B1F5ECA69D6F777B5E
      A7DDB11B50C66B2030A546DBF05C13C2D88E0DFBDEEE35D009AF0161FA2E6276
      BBD3C4C11A100690DAEE01E56D37EDBBD78431AEEBF7BA3DA06A0DCF35712355
      A6B6E1B92684713BB683327DD33E34218C2AADD3F05CBFF1C8AB66380DCCBD81
      C8C0E1F36D60494D8F3571A48EDFF7BD7E133CFD067C01E404DAD4F61AF6DD6F
      4017D7B6DD9EE77B9DA67DF71B10A6DFB6BD369CF9A6F735A00B289AC0DE8105
      363CD6C48F94D7A7E1B9066C0111B0D7EEB6DDA63DE8359E76DFE9757A706C1B
      1E6C242FBED371FBED4EC3EEB59B1852DBF5BA7DDB6F7AAC0157FA7D1440FA1D
      A7E1B126DA02A2A3EF756DAFD7B4EBED2674E903AF05CAD4F05403AEF8C0A47B
      7EB7D7B4BA36EB035978590C63EBB74FC9E724BD4AFEC25717D3055DC50F8308
      FE710751112C700AF62083FFF221FC172060E51D76C31DFC963C1AE380F4A1D3
      03210790113F7761717D02097E03BCF15C225EF37950CC7ECCF8EFEB34293C7F
      301F669F5F44A08D890F174B78C53C9F0771FC3A0B405F9B8FA37CF1329C3883
      79FC2EC8A6746FA63E8DC3C9FF19C16F5759B078437A1999D0E65152BC8DE6F0
      2109B2157CC27D8F9249FADB205816B334B35EC5704F5E84D9F34FF053BA08B3
      A080CB1FE137B89A58AF92691C66F0D3280B410F9C0F56996B03539EA78E3318
      AFDCEE6096B9F81E97E91DC2FC86BB883BC17EE5519AE05CC231BE1E91234927
      8B601A3246C397AB341B83D0EB907C00DF47B320CBBB7ECF75B4EF5739F098AE
      1833E97BBC23D7F31896447B4C1F1D6B56148B674F9FE6A359380FF2B37934CA
      D23C9D1467A374FE349D4CA251F8145FF814C897479FE6F1EFA88B2F0280C815
      E802403EE9F30CF80C1CE239003E6610C3A74C7D2AD4A7217D9A2E0B802D604E
      91E5E1A8401BEE55344EAF4645160F264532FCFB200893F1381D0D0AD8E7CF73
      40E6DCE6CF9334030C29A2640A304C93B408418F1EE7AB7C0238E300A4E3559A
      5CCE635BFB15F4E5E9382802787336815141FF4E0A18F0328823B81E023C9C41
      3E4BAF163128F2B3341EA3DE0EF83D4DD22C9C47D7E17804A3A35E0F187E1946
      093D798D6FC1C7E0031C36C00D07F6E03A86E9A5AB30815585D78B7C9615095C
      5EC262E37C311A8C13D884241F8E8770952C07B0A425AC1B1696CF0238CE8065
      FFC4B58FA773C264F830A31B1D60ABE3E9A5F6196E8DA66C11C65F2ADF663835
      871EC00F684880F904C978701985579FA364ECD0A77C14C4218CB6980EB37136
      0B83B1F83849D362902FE25571954449883BA33ECF8A399C957C016B88935911
      8CFF0EAB1A2CF3302E86419C0CE03FB800EF18C023F082117CBBA22FF0212BA6
      D9204EE050C3C24318023E5D6548800679122C8A740A942B4A46611CC340717A
      3589C2188EEF18861FC08D8B65324273589047811A05C9490633162465908457
      30605EACE0D71CDE31CDD22B98723A890A9C6782E02E560075A496F03BCC3501
      3A53E4834988730BE3F0122E8FAEF305994D80428C6107AFF07A883B1A4C4670
      A070D2C1846E5E0256C68319DD81702B80480619DC598C2E0302550193C58726
      19C2032F5C06C5F5F07AF0394B16599E84C56014C07104748B018C16E24D04A7
      711114164CABB09198FC697005683C991793288663645113023CFC408A965958
      CCB2B428E2D01944F1249D07A3A018C5C972D16EE379830959033C74634B1E3F
      20E049786D0F70E7C36C854A02EEBCF80833C9AFF103803F998559484FE323B8
      4968A7A2D1C24900183E820DA4F36B114F49E0A7F812CED622598EB2395E4023
      1A7E6733193A6816C92C48A6C87992E2BA08AC33C190C4C32ED21B781C26FB45
      CF7BF009B8E0173DEBC3A7F8EE6F3EA93EDDBEFB9B87D6F1EF4DC3740800779E
      C64D437569A0BB6DC44DE3F4B635A1FE5D268438BF7124E03D19D0AA3888124B
      E0F6E01F70684A81C4B19160D3BF433CFB40E503FE0BFC06B0189F40E140A02F
      109445102F66017E4896F3C184EE1EA44B4278B2DBDA03A075CBBC004A3B2BE0
      35099963A52C0403069A5C03E24F118F6683C908D82D9009CF69DB5DF89BBB2E
      1036581C6A9F3477BE89DD99F82BFEE8D93D873E4C42B80F64E414EEE2413A83
      59A47D190FD597F6608407939E4B16DA10C90207815DA94C69088FD93823BF57
      99C7603898382EBA5A41B302D0CC069F4196003E0A941564136D8D039439F435
      FF3C0B8A27B905F4D7828DB97E358E0ACB3BF3CEBAD68B571F9FFF17C90F99C5
      BBF7C7ED9B73AF7D6B82126EE94628011C084AB7C0E6C5723A0171223F3CF803
      C1F08085F3AA5DBFBA6AB166D7BF6DB987071F67A1C56E14C01D2B0B17695684
      632BCAF365985B3310A6AC610812354265FC4C0085D51BF29D94475C71AFDA04
      6B5313D101B74C4C9D2579746C3E5013CF1A3C197607C0F17FDFB0359548833B
      EF51CD8583CFDE61D7E27C33CAE2E37FCCDE1DABED4A130B34AD11680027D6A9
      F57C0CC2D9B4655DC08FF401644AEB3C0E03A40FD6BB0015A7DC1A058905D7C6
      56915A287C5BF078B65C14A0E358C73FC22F796881A833FA6C818867CDD33108
      71B975852286B54A97D61CA411B80168175C8631E662DCABA898113DE9FCDBBF
      FDDBC94E614C13C00445FC0128E2C7F7E7D638851581EC87FEBBDB778C7C9F77
      DCB328898A08C0B9BAD3C8F7C1050B7508DA4294FE5648D90B38DADACA000056
      34A1ABB8C8AB2087ED9F141668CF89B5000D384A97393C89C882371DBD4C9327
      058F1B4C91872F93228AC5968F8F183986E935100BFE8C7463EDB5AF418EB740
      3C5E6420E107738BE488BDE631AF590F2879CC6E1C8EAF4E4EDDAF4A4E8FCE89
      D64DD0BA44B6822320015788B697D118E8C130449B08A37198E716DAA3D0D201
      E4F2EC2BA1F3FD44DD3B0A96B096ED8B961D235AA2AC85660A2B9D58E76CACCA
      09DB4A5AB947222772A0E1B228800F0B9651A40BE647C0C3123868E964232739
      0EE23C4529041878DAC07200CE2724DE0C436B998724E1101B0368CFE0305B81
      B5B615EA0CD757EBD26AEB64D7BF1BDD7D992EF13DE77134FABC65968F8BD9EE
      640F0F5E012CB26DCF53EC0FC91C114892F928037D83AEE5703E47288EB1690B
      6E859D4293A7DC8D9FA33108936929B580A8C1A84BFB47A26660E58B3842E22C
      9FBA288222B48E2FA33CA25DCE50983B21C1E66AC38068311ED3AF40D88B3483
      2F845F780BE11CE24ECE32D0D722F5BB42C25EE264D0DF62CD8109065338600B
      B4D08FF7827621E5CA17E1084478501F82383D3C985AC104E502441609920248
      11C9D7E1F5285EE6D1255237BA23061D89582168D6392BD65988DE93B1442C7C
      050D3D25F1036F0B3688E2C8380240D3280E4B41FC0C88208C2864F116BD518C
      45270F551A2089384C5211E903E4D8B008E1E2C2F3C1BC5B1C3021F2AB05AAC9
      A3130ED4197C194CC8F141915C09AB4178BD88B2502E0BCE91F56350646992F3
      BC74E5E1564D03CF26CD06169126A0A368B7AAA3AA4F4E3CA90355FE4C832828
      8C23A12FA961DEB3064C071F159B38CD057520A5E8CD13D066C45270CD30F534
      D37421051A09339412613D52410244101FF5C9A1EC4F8F0236C0A2E03E7C420C
      90A5F31AF2A0EF03D473398250D685A86A4DC2703C0C40964D7945BC952F59DD
      95E4F8DFD55DF81EA032A81BA25A5FCCA20454FE64C55412E9E32C5DC6638499
      9CD2105D62218D23A682EFFA21BC5EE6EFD271BEEF44F2FBE53444157C8E3B02
      E0027249BA42320AE9E01E9DA3573AB45E867141B8349A1DED05FD04D92F9A87
      406CC2319F0C8BFDF30950516B4CD0582034E827C4AE4EDB7EF7C2BA207FF0EA
      22BA3E0BF3B94E3AC7CB913C21184F616192C33C4A9605286CC78E6D01E666F9
      091EBA60089862B5E5AFFB8DA27B66E56EB6711F1E182BF76D6619EFAB9A659A
      4CB6AC4046315ABA4B83ED559A11DBFB1926B853BBD86CAC27190EB9F2D16BE0
      D2CFE3188489345ECE13A1ABCCD371D842E927E2252ED29CD51A32B9274BB426
      C3E348487366C94AC7E171F29D02441318BE7FF3F1DD2B20DA2877BD7969FD98
      857016E1EA7416A28804CA3CFB2D2CD051B32804A20E20FBEEC3A71F412C1A86
      71D59D017C172034FF36567E8EE123204D5D48655861B3F216A01583A566B6EF
      C33384213F2B0CF92656FA026385E0D2F7A0E7E375981D680BE7014BDC28CB83
      503DB53050EC29E02EF06E16CB418582CB23A0412C09CFC36F63677F0A32F4A9
      B0339575A9EB97CBF98257952D13F2C7C13301309E58E88DE298E36E4F316F8C
      DD6ADFC47AF374CEAA0CE8AC80D02310B8D2C904379695AA9CB52A5A7D80CAE6
      0A6915A8622B58E29CF69DEC3161F14D2C97F52A3CADA8BD06F11562F324024D
      91DCA920C9CE7487DCA4D496A512461B0C92C978D73678922E6119C31508E5C2
      DE43940ACD9888B2A427FFAD66C07D471E6241C6940AAD889980CF3024698BAC
      7FB87A90E517E84FC1617FFF0DA38EB767D07C0C73E6B7B04F57C3F793099CA2
      978086C029F2730C3107D6892C7214202FC9508F17DE7DD4B594771F6914C983
      2B42E26F61B5CB840DB805AA96112EF432882DB65B5C499E423625BE6F86DC07
      D093A90E080E693289A6CB4C68A48E3BE3A10483DA312F6D031040790E0B7934
      C95074FC57FC0C64184971925A297E03B109B67A9AA5CB4569121C87011CD84B
      B448C08F16FD9AEFB57E7C78F089ACDAE284E8B6ADBD50980F0FA4F9175004E7
      827EEE1149A2C296454661493DD6CCC7EBF0FA888644E1922B96195A38414121
      72A3C59A9443AAE7857FE1C84A17BAABFDCDC482C1F837720A5D06518C3EA116
      CC6628E44C3AE9557B2F9C1D61AC2FDF20D81892048C4DD15EC150C0E1130B6D
      50683D4ACB751E8767D333CB3FB3CFAE5BF0C7C53F676767272CE1F09334A420
      2DF8DA4994C1E12402732C3D079134589FE02D6A59040D21217E1715DF2F8738
      60A9140081C2158FAD6358411DB88A2D0BD1EB64BF2D5E68795CE47BE5AC128E
      765CB6F0F8D482B034BB97800BB9A982CF213B628311E5A6A9183F0AF883EB74
      2A74EF05BD03584C0C9C16103A0BFFB18C847B00B8659825C08F49C1C107F1E6
      B3E2BA20970AF3A62B38B1ECC9176EB2F03ADC7774FD1092B706664E073EDD31
      33CE57B74AFA5FD52AF993E000183D92A5B1F52699A4ACB95F5998D229DD1B18
      398B4A5E4ED82EE208F2AD2B3A2BF8DFE97C7E3A1E5B9FF2307B665D5B984E79
      FDCCDA76A029AAB12833DA26E6EDB698B7B68979DBFB8011E6C1E335182817A6
      0086E2A6404592CBA8D09CF8ECB8049C620912880CA2554BC543D4023A484C45
      5B1347A06871DD7C1770D855BAD4C332EA14226A5A7574F775AB796AF1018F11
      F48E010B120A418E3204C9D4578052B9804219BDA08329C1800B92C29130E330
      288A4C5352A1D37238762650580586448C800F17D912D5656D8B281B02B18B25
      2AB9634FC8B6C0819E6946662E2E4BC6CAC65A68C67E8B3C7BE6933699570F91
      FEDA3BE99326450937533831D38915C0C6B2202FEDE014BA967038F3E101DE26
      62F0C818900797140D238251034AE0DAA9BD6F5AFC2FAFDFFBBF5AAF7F78FE8E
      3CB36FDFBF408198ACAF3B35FF664FFC6594154B50558F7E4EB3784C451C8E2C
      2091F3900DC6587F3905BC5AB1561B61F852180BD7336DABA83B61C1BFCB50EC
      E806A4F8F9C3DB97022F760A348DE9718707A51BF63C5DAC508791F56BAC63B2
      E2E1D7AB2C42743D6959473FA4C83A299AA11A9C81520C2F3DB7267130C57042
      188DECD7E1B7018EE7B4AF1A34C86E718C6756056790B5DDCA23402836BF11BB
      FF29127978F360651DC331C9C84F0AF211DC0032C7300E92CFBBE6706880C26B
      D83CD8B7B4DC5A58CFA764E72C154DBECC302B501084739B15A3258868B4068E
      C621274ACA290968C22533380B7D324E782504CBE4C98E39AB372FF70360673A
      B79EFF54E533B41A0C712EB9CC7E4A9F87071761008F13E7FDFF520015E0C6DE
      65663DB7728642886A0982E29F080AAAEB3484F5974269301E0B737135F50A29
      5C9988B3DDFCA4E76F3F5A7FB62E763E8FEAFCE387B730D1D75C596C9B539DA4
      A3652E32A7D43E496013D60A2FD088ED92E81C22EEFC280BB45BD69F29EFE374
      CB5BF238E8F3DADB36E694A927C849288723CA799300F09FC3105D2FB451486B
      551EC76899652852C2DF1CED02407D2B59C45B5DF5E3C4C0944BD709C67D162F
      572D4B1288716E4884215423952857DE54F663350C514B02DA5BC686441BF0F3
      FB603E5C66E8A07B1726CB3DE16847B8FA23E99A515102D2395E85C9BE63CAD1
      052AB19F449C1446E91EA15D0A6B2E969664EBE839CCDF62B87250C69EE01225
      576E82D17AFD1319EF7A0C048E44715A9408EF60722522B3D0AA2C23D3A4A39D
      0242311A38B19C329FA916D712A10701496B3DB0A58AD32D8B8ACF8AC830F926
      F4C6B34F1257837E7BD669B48800BE531E894AE867195743560F1A3847CB093E
      2292BA23D21631F774E310BFFCF7AF12561C8F079A1616F3C4DF85AFC369C350
      20C8600C1059C8220A1A0F160BA0F33945B8A0D449317E3497244DFF19AAA76D
      93EAC5687B5E6431486B047E841A1921BEE7847BE092FF0703D23FA6DFC8197E
      98DCAA41A22A1261ADD207EB1149D5C623402C02E698010960F3BD41212C61FB
      8EA122051E285736A6D889B371F0479688FA9A4CE5950C90AA2C5E12680EDDAD
      C6558DCFB84800E61808B9062BD046714304D51BE2157ADA9832DD16721CD417
      59DC1644199E47C685BC9FB37307BF7D17CCC31FE0BFC1EF67E55CDF8BA168D2
      C33097A39A08AE03CD2A52DD1F80CD9E203745FD6A7018837648DE949BF096C4
      9212EBC90EAB554150118557306E9E845767593131C148B70423F92618C94418
      980883BB471874BE6A84C1BFB7FBBE756A1DBD4D47411C8156B38897D32839B2
      2658599FCC66A0FE65E9E730D9A96D6BCE0CA54006552316CDD4ACB18E841F6E
      1465C01BF2028BA4A0F52F87DD4112A615A54D27C287BE5B0EC6E6808280EAF0
      3E25F1163F6C82421CCA74C89BC20F72155A70ACDCE90232E898C4C7508EDBB1
      6ABB9B5D916F8364BAC420C8D25020729E832B1478619BCFF0DC25D35C88C180
      0667C33C787A360C5C8B2CCA97BB9601BE79A99F3EBEEE596102A232D9C05394
      66F8408F2DB9442C8683C69D4910C7144D380FD10E14E5733414C9BB5813282C
      46021C77D7C2043643200B2765998E658E592458396A0E47225BB1892B094718
      159BADBE85F5085703E7CB6A184C397148A3162125F5CFA8FA5B4099DFE9E141
      02726B52642B59C9ACB418B6448CEA152627A13D46950ADB297000916B004882
      31B111765D1A457C56B950451C070B0C2B78CA3D6DC8F0B75A08ABA346D604ED
      134693E368BEE0DF384E166F1E87F9288B98070CE1CD57326A7AB7C8DDBF63F1
      A953EB03F102569A93651C0B213C582C54DE20B716DE6B59FCF0E0351AB39785
      D5ED58F9728130DB13A9FC3B2C7956D69156A900985E778621732A3E8E24740C
      4BA21A47652618EACE67806893300BB1A69C22B06AAC30E1CCD092DC502D6BCD
      063459620A292AD7F5F26A5C03807EA6819186D75F84F7E0E671572D954DB0B6
      A5F8E66998841925ACC2C2C72B1934B248D1EE4F56D02059A549A845EA076292
      58AA00A65FA03120FD8C098C1BE68A6F9C2F47330EB745DE29CAECD1E464CA05
      85E08FB2209F951E8117F0641E4D936812812806F39853BE232626632C18BBA0
      73865646017D58952891850FEB097A0C6D6C8E134D56222E2059912E7E249AF9
      1D716868CEEBAE85D3ECBBC14C58CAE608469C9C85AF9E87282AEF0969F87895
      12BA3440A18E305FA2B26F76A0FC0B29EEDD072AEE0FF2309DE22490A86EBD73
      088661CB821DCAEBBA56724754FB45DC4118307DD7DBB730BD45BF3387B3628E
      773616594F6C64A0ECEC33741B50A9F5FC3366778BB77D479543CAF7510E77A5
      3E04BE31A757B2AA221FFA127DEDD17175FB7B8FC9BE806E8FE05E3CB5DE8068
      8C22F6234CFBCE287B1F6A76C6185BC50F556A06DD496FB1D430A800A52883B5
      EC90CF93A53F19CB4AED2F4031C6BA3470E52DC565EF3BAF3C52511E47FB14CE
      F5DC3AAA86B71CC9EA2D4AF4AD4426373495A078CDAB2819A31C4D4E2A590306
      D47734C68002BA6441F858042CC62B4EE128EDE92117A23476F30AFBED7D55BB
      B9B097075A54DA6EEC8BA276C7D1446602EF96F94284ACED092179C7564838E5
      1115815372D13291F6C808B8D5F15F458534A00B63518A8972BAAF0B2A403B8E
      26C4B90A7995C6CC29BF6B1AC2378A6B2162044486DFC716AFC9127B80ED3B1B
      3B07768FFDD3CB90144EAB7BA999FC0060AF31298BE3A9F6043F3F920D550087
      A2DDB320C9E380FBDE48AFC0711E86C2248AF794B6086E7F449595146CC761A2
      87F414B2EDC476C5C9FF182D9E5DC3FFFE73FB1A109697E5F693E20CE986E154
      37CC9F6D7951B8A0EDE750885C9DED4E75594C7A8F902185862C56E81456B215
      BB655111BC3B2D0277FB8ECB70DCB6BBEDAC22357551E73446F32BB9A07C20E4
      D3A8000A8D4A335A1DB192389E123B7FA405E239B1FB9E7DB773F205B9537BCA
      512EC2829C2F15E2194B973326FCF20DEC5BDE136EB21E020A50107E3A0126CA
      DAE2629E0A5AC7688B844B9281C83E2DB44EAD2F1148AFCC854E90C100098E26
      2BC9622AE00686C5357872EBE81331FACACFCF8E246557467BB466C9C29C275A
      CDC18CAA7E2ADD0CE3053FBD515E07592AA9857ADD866908CA8BDA1E87BC06CC
      0A318B8D88DD18AE6C972EFF325A4819E7D747608DC21E2716C63A30D7758E26
      518896E4CF2181E4D9ED285FA27571DD773AF0AFD3F35CF8E376FD1EFCF13A1D
      1FFEF8ED9E0D7FDA7E1F6FE9F80EDED2F55CBCA5E7FA3E3F8DB7C0D9E9D23076
      BF8F37394EDFC6BB1C17EEC3BF5ED7A7FBFC4EBBF3A867890C715BDB4701CA30
      99C21198FD1559AFB8F41926344D93BF76E07F7B416354673CC236AE7F42CC94
      049CED563B7C2C11A72EE01C5FA192BC75CE8F38B1F5AA8CD882A055361E24E3
      3F162DBE0E309E42A79CDA36A995729D67506547E48C251D2114ADDE83F2B608
      EBB464D1A50CC7968C62DF658E7A0797BD38F1ACA3AE35AFD1ED2022E609D550
      8E70424ECC6A03B52752DC5BF58195910FC1B6BD1C6BF33CBE3ED93A1B363551
      E53B9AD2103C938680E2B86C0CA924EDFD8A80126E6B0EEE55A51C180400152E
      984C9D98F1972853F6AE3294E8F90F176F30BB1AB3D48A10932C31F2270BE06C
      6727F27EE1DB117973C2C8ABDA681D1E8C0A8DD9CF83C502359261585C89FEAD
      3C5C2E9BBFC244E8651CC27382EC10B5A6336C56C6A9F122C02F2F1BE8CE8231
      373A8AA379848BD355946034129D6FE63A44689AE3084B4BA9C65FD42B8716AD
      661C884A30DC3CA9FA9BB08651B4B1B84312279E57995F9563C4E58A63739BC6
      633D0ADB17618335BA5548112315DECC3BA9C2F9E320C7DB5215C27CB653DE8E
      AFEE27EB7F553FD9E1C1777C94D4D13A45D930E79A0422468D7446D297133C91
      2DAD8E31062861FC6E8B1BEE603A1EDD53FA519210FBB1CA16EC32E62F0E56A5
      EF7E3730E1A777CF5F6234262CAB881863314E1900737840E508F0A06659B02A
      7159018B7A5187D768FF009CBFF8BCCAA239518B38C076F478D78AA021A12CDA
      CB4B2B4779EAE50943FB0AD56BA0C8F1D2BD7415ACB87884282CB88B67EAED5A
      6E838E54EB2050999CDBD6B064FAC8B6B52C26CFA27D9DD8BC282F733A766B3B
      4040DFE433BA794F6A6829CEB338B892AD705F422A788D4E4E32278667544CFC
      FD308E8017262D150CECB5E844C8AF54242E9C06DC06BE320F7863188F316F62
      1147A3080FC03CC83E7381D01C237C23BD6AF67A002E4F018FE1E1813888D498
      A8C5EE570A678393152FC79486B0923BA7C1C73A9630615D5A5658AF00E87E88
      FB38687B2FF3E06D887B52CB6B91F958945916AFD631FC5F5D42AD73472A1EC5
      0D0C35EC44E14C895CE8B1B28E496CC21C3720E1D69B93B34AE32BCD11BB140D
      0FB71AC9375A9C0A09F9D97FC8793D821F96ED42DB761BDF6BBEF7328D596144
      4CB371C6B0FA9DB243D65CAC148B2B922392349BD39164F96A1896E973B5CA1E
      91920EEA120E85FFAE21B32071406A31BBF0AC74B280AA40D2477D744A55A96B
      6DE5B8684B640AAF282AF555A09C48F2B000016669A6B443D21ACBE4DF6A7AC9
      BA7CC181CCB87EB8380C72CEC0E5168842B346B19468F9931C23E90BC9C39024
      D26FE2FB3745CAF5F61D42EA3C46827DF1EAA4558B52AC008221868C739A2020
      4DEC62452773361BD2FE28A54CF891807D202FD9A9AD996074F64ECE6C919630
      B3776A66A37F86A39D9CD818B3CB7772334192DFD5A94D4360BCC94ECE2C0BC3
      CF3C316FA7260634338E7613667F0F164182B2C9A9A8A5B043730311EF2A9CEE
      28E050D85B4E970CBA9D9B1D30F65DA51FF95538DED1A915CBECB39A9ABF5353
      CB9679AE4E82B35353C3BAE62505F9CB4ECD6DB64CA641A600B75BE207C8D0C3
      68C433DB8FE0A8C30352D42E5E19E5EC01CAD966EFFD5755CEF6016DA5E1DEAF
      98F1BB1D83CB0FC065F72BE3F23EA13155C10CE2C3032EAF86510A4BAEC6A270
      36B72265BA64EBE73151EBD7EF7DE1BD7ADFEDC81BD0EA4F46CC09E7C514D4E0
      24BC1E858B4292893399DBC9AEAAABF53C7819D841A1287A20CAC62A712DEEEB
      ABBAAE94090DB9955F45C56886A6DBC2CAB052FE5C66D1A9101091115B09CED3
      4342AB996664B46597D1BAE38222604658C288B301683C7215524E8D8A5521DB
      AA0851F9966CAB65CA007AF912AAD7B5E5F99711E45BF7757084CE994C59DA6E
      DC355B9AFFEF2B81E28FB60CAE6F4E3825BC1EA23C39A01BE2751C72611C8570
      E330C7BAE80A8DABA14E94D952A4F2F8CAF415B872249672641DC3C723C27EC5
      EE4E107BCB73C66DEF757F890AA34E65C93BAD68CFA3F8F7E267FF2127D4EC26
      AB3BB3EE0EF59FA9F721970BE39E877AC610132CA0314C6FD6EAC8C76B653D5B
      3AF5230F6A812D5409F4D3B0A8903FF5B4CA2ADA7AC21D3AA8FEF32C4AA2C708
      0B6995138F5481D3CFE18A70AA0C8A10918456BE760F852360D4103BD2740FCF
      066E20DB5446B90E77CE7CE3387EA6BC181911C4D6689646237275DD23A5E1AB
      87DB1C1E945D10B8D58D4A522B41220A1B89100FD9FE8E3B7F7D29475C0F9BA9
      C661EA21981B360719C8666724C5AAF0BCA8FE5F30171DCC8E858BFA7ED8BF4D
      DCFF52B2811EEB4A48C4D7A27B5FAAE39CD01963EFF5309C60D03133BA56B9E1
      94E108A7A7AEE324632DA7189101EBA0C2F60E532CADB5A0724D67D6B9EC005D
      C1856296A5CBE9EC669414DD5A652C71CEE8425D1DE3F5F0A3A859088AEE0E12
      E073DB3EC97C1EAB09A7B5135DA96F708C4708F9AD16A1540B79AC88AD9B4791
      510282284CE37448A2B726CD1E234C17D8CA3B2AF887065E76A21190AD47ED3C
      6AB4CED6DB9B629811C1F9BED3BE0FC26C2C80A8228FB62BD77ED5D8A32F9AF1
      E1C11F177BB475E4D93E8AA3BCAAE290900CA0A27F85260D6C3003547518C570
      BE5B8F7510B65F1A24A27E8B13A05365CC6585E2214D934569AB0A3A5665A47C
      1811CB099208D6375BE94AFBB7A2D002246E312DF0225B9CABC0F560868A034F
      B64EFB1E35B2FC91D4F69759304D93619A258FA8B26B38BA5621CF4AC22053E5
      F864A11EAEF040051E301B0ED5C828C132FAA2F0FB3015761862EE4ACC32F50B
      1E860D5C76430A38CF2CE1611550E55FA795E86795E1F58C639CD7829C2BCF6E
      90C0AA0338E500E72066C7A0395447A070D5B5273B6DDB76ACE34F1F5F9FF64E
      F6C26E4DED66B71DB3FCB8A931A8A973BFB656797455FF1364D354FE45A451C0
      D137A7F981D5486CFB996DFFBA5E1FF799F58B30D78A037E76F1F1C39B1FBEBB
      F8559CB2BB9EC93D386337C8435F7ACA1ED1C44F3D5342B2F1B5B803B24CC5E5
      BC80B428DDADE6587DE1B12A6526E5EE68383FD631D9ECE4769FEC2DA7528965
      685209B62EC53EE29162431DF988223A53964C16E414C332F1CF70ACED702C7F
      33C7D23495309FFFCA655F45FFD7E3F30FE79EFBEC79FF75CF7BF1FAB53C58F7
      19EE4B0EEE7DC6BF20533E2833A2AAC35E9C7D2A03944B970B757E48AF944780
      8CD9591A536F9E38AEE972EC0F9B079F454AEF13B4C0CF02ACA591C191E3AACB
      98FDAEDC2224A4880A159B8B5DBCBFD8F76A54A2399AF06268BDBAFFD8A6EADF
      668122D71428327D924D9FE47B84327A5FB95172CF03AD15CF2FBAE0A91C3817
      2F284B47D03759089542E8E641C2850D72D8DBF18E7552852561EFE731908482
      5D8E5C5D097920852184F305468A60798634C322F084AE27541F1D631D726A3B
      905BC555AA4CB063B6BB7001276098BB954B014B6EC392990C6383632C7D9585
      F3904A0572CCCA3C4DA8386FC4152EE3202FB84E25855960C929517A2A8F8A65
      A0F7B2D8993576608D9FC3D530C523AB753F4EAC71962E688B70A6B90201B621
      DCB545746111EA340DD3183D6E49B96BDC3812C3BBA8EDF58EB5B185F9F7F06C
      4970734CA12C65B610F50152581F960B284B26ECF286F4F505E19C60EAB3348B
      FE89419331D2C4143B4B639905AC4F876D86515C1EA64591CEE7695E7099CE1D
      5B561F7BE90671F1E7D132CBA992F525B50596F19B544E426B009163CBE1E53C
      C1484DF41CC1360E515D3312EF2D12AF63245E23F11A89F71E12AFFF9525DE2E
      8A8779118D3E230DCCD2AB0A7BE26009A49C4970194D77AF151A2CA0437DD2A9
      7CDB240EB8900FCE7F942EB82E390585831C41D2FA380BA653D1CC1A19DD62E7
      848A2E0A452F8322D8B89C6F6511FD35119C8A7B2E3210E66AFE7864216B65A5
      2877EAB4C7A94A18D6B82C26F0158DE9D88F62AF39CC1EF7BBBFD03AAC6FEE7A
      8F0A1C592D9919ADF555D7F37230F174283BBECF315ABBDEAB7D1802FE26E186
      A6F4D45C564403870946A88C31302EC3426032B837BCA66C97ED868D61FA201E
      AC3318FD11A23629289C4E65C1D47FDBCEB7D349DADD7ACF8A202F237BE5663D
      175941DC190017C6F67D51791815801668FD619087B2C65C9C1654B4976AC595
      8D8390CE8AF4250C7D0CF259286C28518251A131BC765309D13DA752424BC02A
      ADC015F68442518DCEA372E9474040464BD2362359FB133BA1EBC14B95DB0154
      A6F7C36D8AA66D144DEC5106AAD77C8F344DD96EE04A4A3D181C52F680192EA3
      98C22B146444D574D9C94CB48B1FCB440A3D6DEA889E3882918795DEBAC2414C
      978EA3519AC844BC5A3BF0930DFDC05BC8502FA380AECB49E10197838B3EC97A
      C4F30DB7C9D8665CF502DB446047BD896849275AD114F8AC1CEF4D8296395E1F
      0FCA79602271547F15C758D2D31C7A9987B89BA4C82720C3BCA50ADDC7637484
      649CA89FA28510AE869C23C1110D2734FA4BB8CD3A96BFCABBC5C3FACDFC426D
      FDF87AD163032D729F11CAC862D39C78AA90C984C0C5C9DDE942FEC25090AB00
      723BE3340651905A6CA5189E7A0E707B01F4E984C5BEB36BC685E00A154E14AB
      A905479A4CE2884A4A80E0BB2F0D9399CE48768D0091E74C0A930C0E2B1F11CC
      8E8794EA4E385600FE23700E0F9806E4E2DE1C6901C98CD44AAD4CFD972797C0
      4F85021EE9ACE1CD0DC543940F468EF3949F3FE1F1F0C97224B5A04A5EB2BCA8
      4A1960E651957C2142E5A0C0C16BB9ABAAC02D8059B1DC7B69F96D380D93F1A6
      5397EFC9B1130A1B927C9A80E0ACF2ECFD14B122A10EA62540062A7C9126C2B5
      5BA4D3692CDA0F51C7184AD7A39831797F91A6B1E0D0E221EE2817E8552A80E9
      0CA3847DBFF8F4B9DC1312F08FE95CF0F6F0C952BF6325F3E3B5D3A2BA26FE2C
      AA2D8456B9E1735C1236906DB17D6FA427794F407DA048B7100616278A419185
      2403B484D8518CA87810DD775C99EE537D72277210F17E018828976FDAF783F8
      3DBCFFF4E58F6F98F2EFC5D9AB30BC491C1C1EB07D39B7AAC0D04547514EA76C
      A396033F09EBF676E289F4C384424C287187FBBCFCA70510FB5F121B25B794CD
      95CFACE79628AC85DDCE38912F52AD54086747018B7EC3403456C3A815D10700
      70AA2AE1E12C98ED542608285F7040A8947CF10C1C1EECFB297875F176CF6CCB
      A576C971274AC744F44470A03F46A22BA512CF428CDEB68EE19C5C21D51579C4
      67611E6B15BF98C560673C21F289E25180E9D5B1158F9017A6654D1AD53D4884
      B0935216584724AF81D61AA74529E091CFB5A02683AF81BBBC79995BD891503E
      86EF7CFDEAFAFA1A84B560149E59AFAE033A10A2B1B768CA14220F0A45D79979
      18001F2C89845ECD895E879120A9E5B63DEB08C177A4267E6CDBF8CBEB97CC27
      7DBBDF51D3E67B0E0FE0AED7AF6C71E3ABD7AF5F9FC8758A268B94AB8DF168BA
      AAACF6045D4CDC6488DB0EE3B316265B6442A05593414B00FD2AAAB3E054F5B2
      3FB8B1598E1D13A7119B8209580444220E3FBCFF0860CFC238A2A454D1CC648C
      76E739D697D05E1D242BF4299C542B88D106A1F64EB1E8DCB512B5022E614231
      846C77472A59621D4D64A58899AC4580F54D6441333492C99EB7ECB74DACF7C3
      BF0340DEBC6CC9B6255C91A45CA140675E610B68F2FF43D057A804549F2C1EB8
      2EF6D595F473039AEA182CBB53CA3A4A1CBD1FCBF56144A1B2D9E7CFB65D4FE1
      CD3401E0C33CB65F498A00431B1D94D8C3478BF0090F237633C41948294EEDA4
      E4A03522B1E5D5FF9887CB71BAFDD58352575D3DAE4B43C60A30F8E8096870CD
      49D878998A7F0B4404DD41875CCE0F4F5469256E6A9AD24920E2A3A39BC0689D
      84ED392BFF1052E3478C6E7DB1B2CE03D213F684A957D7AE1785108C8CE9EE28
      E0AAA754218B2F9135992D8CF4AB20D6D4A6330939C56F886E3F6176665671FE
      E15C19823985112BE16052E04854E4E2DC268993303F963A695C26FF3030BF11
      C6CC42DE2EAC8E3ACB4210BA638AB99E73436320AD6D609B92ECEBC209BC370B
      85515C64CC17C1676E102C9F7581CB005D1E572CD07A350D568C691E0A8E3520
      F2F2A98E1E27EBE3798EC48B5BF849941B23173DAD50796873EBD6FD11C252D5
      66C5EF94DD9E07BFE1611FFC8E9973BC762190E91C9D6BE3F106072244801DF8
      05E68C05D604D827B0F065118AB27B48DE64591C7ABA14C20221F96418012F80
      2E50A8B28464137C756C92929AC609CE00D47C0B3536CB54C3C8E14AD51B8581
      8F304448AE9C0E7578C4D8CA9D16457A1C0D04D479B656314179B7619FD7A727
      F3E21A7837A5E93D22F77E092FA4356D9F7FFDD5922E7B6A8A9BE35EE6745446
      E2A83DD65A30D9F331D6334E31BE8A58B28E5B70F240CECC29CC01F1198F1E5D
      94A2FB63ADF3025EF478EBA465E8EB14445BD2B90C29EA969776FE6CF01B1EA2
      C1EFDB9626FFCA8753D4C425E36FB9B43D975BDEC16DD129B23D5205D50E5331
      3FA18F002B6C64217B22E220D11689E2CA0B2E7A8D4B283573D9F1925414E68E
      52B70F33BC814B15CC71131664B2C67DC84BD590CD7A64F85035D54A67FCF98F
      9FD0D486E7F3328862A4B25A03DBBC8CE3E3F2D7F0B2E582A78196044DD3DF57
      EC7FAE098D94DACEE224952ED8532CE7B50BF15A17AA49E853024E50FA91AA05
      E248D6B12A23093393D25BE518E25C702D8040911D213B95D1F0CA0BB3EFE8FA
      B6347C8166318EF747C5FC38AB98FDE4EA4B9D270BAFB2A828D0D9504A9E64F4
      CB4719BAEDD877219B3263C50BB6C7CE238A43A50C3B55CB42A0B466DFE09AEF
      EB0D94254A5E68359D5A74F3C757173E7624F14447921F7ED257106163832C42
      55946649A78B4204564499F3332A730D83B49F5E5CBC124D4DFCB2B2861866DB
      56AD45BC84E5E667C5F5DD8A4ADFA7EE6BB924EB980DF6CAA82CEDAB51420164
      BA918B6B6669F33A5114430001A1BDFE20D798650F9584F2B6ABFAE224680E77
      86D7FD4B748A566412035A422257E2C0960BA6827EBFF5C07198F9B6BB43A021
      73DBF354F6814ACBF502CBF0B2A316C983B235BF63CB6A1E16C2F0CA5618F4E3
      44544E48B714E9CA7F850A7C49AEDE833698338902BC5D251751BA115CB19CB3
      1D49D96B3F3065EF6120D26C5D5B27823BB5DFAED8EFAD82EF1399FD6E04DE17
      37AF384552B8853C3C7CE11D0187B7D62007972C8F41F77E024C3F0A62EBE5DB
      733CF03359BD499CF0539D76EFD4DEFB8FB1F7F2E8FCDF9F3EAC230015A37B20
      8D3E1565B27EFA50696FE85B3F7DD809B4683354CFA9763BA82EE7F172286D85
      DBC78EEDCFBFC3F397EC0DDDCEBA99ECEB4EAE7B261A6E27A74D13FC575784DE
      4CA4DAAC59E7346199BA2A89D80869CE400752281F111D1758FE4E13F26191B3
      4A84EC637DBFBC28DB114422EA2346CBD44AAF16CDD24DF998BA5FBE067D42C2
      1E45550671A40D3B279C7C8B25F93E6072D4094245D1E0FD43C081CF677F680E
      CE2EEAFF98E5F78EC15C56231A03F749A7FB82FF1F671BD64E18AD62A1547321
      711F9A95AABA61A05C951816116458FD48FE264E5730A6C3C567216F5947A374
      B1421DE0ECEC8C70F3880D0AD13C8A01EC9854CF71CC27A54D42B34428F3844A
      1B529660EE5314282397389AE2C4ACD22567DD84B5D3C613D3F40AD458B25054
      D51139D8685478CF315AD348E92E64FA40BF6A9E26CAC1ABB27F84D64234E4A4
      A5149D56194C723CA9AAA4701759A6C49BC852520138C73A8908AF1FB370125D
      EB0A1185906B812DC2210AC4019688466B8650628518DCC5AD42C8F858330BBE
      53617CA01A4B254C008A9DBC64761419D777414CAAE9168EEF8EA0782C3E87A7
      22E9ED31146900CE93827BE685A3CFA59FFF7505E1252899B44AA22D1EA9C63B
      6A4193F43B59B9EA78661D6BB0FBE5EC57BD34DD2FFFFDAB8ABFFB1F4057D29D
      85F39E1C89D297448D60C6EC30E5C0BFDA84E4282FD3253E7F1E63C91458D779
      91C57F7E955047299C32CF93A2392A89798205914FBF12CB308A53D10F902906
      AFE3FDDFCA840138AE8A6E1C9DD7CF7AAB2CE2270BF471DD5C793CC9FAB7AA34
      372DA30DD8A80DA72BC058AE774FD541BA0C622CDF430786420B7553C11DE644
      4EA9104D96B95E9E2E57A5F84CA201E74501E09F5C280021212A332031DA078F
      CCF9C70F6F09D463C6BE1162DF933D61ABCF09FD4496E71782AA647C543EE6CC
      7AA9557E9B04715EA236DB2E2921877D6FC42E5A3CF01CA080546B16C663AE83
      89AFAAD004266BC1085B7897D5DEDF89DE52F0D7FA0E08F0822DEFC718CE9517
      AB383C114D8AD5F2D0C1B7F74971AF29121FD980B4959F4D67586670BF5213C4
      A2CBC638D2F00B7B95ADB893E1B1E81A2F441C0C01E358B81146065062A98C22
      1F476364D42AF84C0C5FC6DE4A411093E6127434CBB1907B59DA6CE019D0B95B
      FA28D2174BE1CF25917FC5B39359F5F86AE6772D9950A41C2EC8CE6F9CD77E9E
      86F3C3838AD09E524D622028444FF23D3B12E5BA5185B726701E9699E82AAE88
      BDAA19C2624C9CA29611CD430E88C3DBA6293966F1185931684188E478455737
      162067963A01BC0E4B9F72C9814235819D01A07249EAAB3BD22A35B664C5B214
      CF36B7B4CC212EEEC0196AA2A4101C0AAC9A36CD02C91154E3C516291C322C01
      060E286154BD5B85D8AA4B0C2791B052E04B1934043159EFF818AD20575182D5
      594E543F8B9CD3674585A3117678232628FADE0EC351A07A5A53AF77A9350940
      E54884D26552284F3505CCAA2E0F64BE3939C3D8A4198320A0795294A91A8348
      5792D22E82B4BDC03A55A36881826F949439D3988BC31C949555A1B191B40A2B
      57A937C8F485667929937090F25027E1C506F8E14009125C9C6428931613B273
      C9E6F542614DE14C4428D9097B1543AE1C13740C1890E936AB34D8585DAC40AF
      99093892C6971CFCBBC05001518D8A62936B2B10DB01779618C8815A484F5145
      9D2F8AD5A6D8151916BD58C42B56F88F5E93824BFA033EADE67674A6494822DF
      EDF040150D5BA45152E23B9AF010DD41F7C191A8F001B00B0A386308E0504086
      9EE4C25428660CCB1661CE4A912AA143C84610A130A0F1986D03141701A8ACBD
      90A6CE804EB0793BEDD54D4BE354B7E07348A96E4414C2205F098B22AC80085E
      CDC7DF02008C043F66830D2A9262B328489CF6B0B6C92CFF4D104B3025708AA7
      8F47A115945B880976885A74249080D4F6FD6B3145772B4CD1ED363045B77B3F
      C3239FD18B9AF96D4F98E1CFD2E2ADD51D20C30A05F3487ED2129A7C23B454F8
      9B3809E5553A0AD2A0288CDF89B2F8E6EB232172237FA59AE0E984036524DBD3
      0D6CE53B543991402B6D90A764C740DA3B8E44DE6178BD90396351328E806BA2
      B05B3931C22619512D0D64E7B96E05A286C7820A68B63A7C90DC0D70E6230CD1
      8A48DC5525DDE51B343ACE591264D0E5F80B3D36591A93223D0676CF4FEB2BAA
      DCF4F425E75D10B83E84444BD5FEEDC999FDC84C8D0A895059AE74436D0F3A43
      A9A89F8389C6026E80705C03AB045B4B172641205E26CA8E80F9CA328835D64F
      8A883BBCAAC8AD6B3E0CE64EFB8EB9E7B2E5F91E22AAF0DF60CA36C79DA55256
      D1D4B04428F28ABA1F1EA8EC3BEE1A5FFA005CE5DAADF887374656B764867022
      BC2D78DFD179F5FD6767674725CECB943CED78512D3EA4C8340459EDDF69790B
      1B8462590E47242293719F5F5A63A3F09A5C88B522385758BE4130D62B7C2917
      1F2C07ABFD50485E523D7BA892A599CE203983102148626C9CA694C42982DC55
      5124CEF82F2CAC675B589E4A0995AAD8B15045FE8CB0977ADD89C86FDD408644
      6D0BB1A0CB35A214DCBC052D4DFB0A6200045945D1E3219499FA4EA8B24855FA
      A79525E27D507B4C1B4258C1FA8DF43EAF8922B1D81B3D599F955ECC6A8C864B
      588352E024D8848C23EBBDD1A428F3850E831449D8D95326FB8A814528F73054
      5D600E0F4861D2D1E6CC7A4E5A176A0451A66A464B178D42962AAEC90C54A970
      4841A88640EA3EC4B3AFE769D915DA5D83CEFE10EE35BCE0846E52602396CC2B
      988B545EE2AC8E5612817E60E55A77859343A572A4DF24799815674A39103752
      072754C7C9397395AC9101A04DE7DCA0E7D3C27A2A3FBF247DE4FCC379ED8D54
      FF467855CB910E0FA6D6C52C9A147FE659C82A5441A10501498A4C3C81347A71
      33F6FB4954B14765ACA0974793A661CEC8A253F5F3A267F8C3B99CB1F0D55756
      FC92AE69A6763DE089DE58F559090BCA5C389254909356714050AB78554D6B62
      AF151588D39697F35B5A5C2FEB2A1206BC72795A7039878F5F05D4C84124152B
      C37E40C5F3B576CD65122075B0302D5FAAF1E39DAFDAF245733B9F52AD42799C
      B1B2918C7D534A079A3085CB536CBB0ACA5194851D9E97411C293EB31B5BFD91
      A3A74EADF775EE2E831105DA8A53CA06D4DD5AC3E1C145BACC46216E565D4AA9
      2F834554658A2FADF74ACCA5325A22D689B74D188DB930AD860D1A2608309265
      03208217459813BC5ACC4ECEA4CE2F760388B0E221AFF31409AD0E331512DAAA
      22353A30931DC4E9C3032E6C65BD7DCF8B4187A9D82C8D29E8845F2F1A576281
      88C3CDE59EAEEDA016B747A5BA64D50889195A80103DC8C17DCFBE2489A40E2E
      F75E19046E3D1C1B149C5B49BDE3FB5F4EEBE9E1BB12FB28BE6C7020D3307F04
      CD7FCED962A7F514AF6AA122E57F9FA3073443651228C2D9563ADA6E69470F0F
      004D5F60C035357424770AE8C7CB4A04ED95F24F51201BD5D70DF82990D49295
      0AC553C19A14C25D3F2CA24260503E208ECF707DA48934256F1C49161D6A18E8
      E34CB782E4D2B7C843A98285D85D34591D1EF0D6FD910ADDD75661B80D9AE0D1
      5CDE992469B20B08B579CE3D7AA46C4D752D49BA1FAE38028CDD917CAB6287F3
      7459067EBD10FB5D75F80E3956050B59156A5FA711E6540614335AA793D23E41
      26047425322AA24B21CC8C285CA58EDDAF2A0AFF58B141FD206C50229156E996
      52B393A50FA97A31990CE7615D4D56AE31ED3731CC31D616CBCB58A693DD922B
      0804E79560098A0E5E49F9402C032DBF18ED4BFE3C5AA6B494C5D1829B519786
      3F1247861C40A3179FFD816A17600FB3BD695DB3D1D6B76EB4A3C8EFD62663A6
      34E869B1EE6B06CD26EB8DD61B2592613167F0E4942DF71336BD6AC29F66C1AC
      16ECA3554857A7363E5AE4EB7EBCA39AAD162D3795C877DC8A296551482B6612
      5E613004993BD4E06454A896FFA30C966A8EC1BE9A366BFBB82F4EA9FAB209F7
      6BD52748CF211A45662969391B8A02B45AC9453598E678C9054F47C788C80594
      4E838002934A6B9D42559180A1BB6F38A189AB357165156C333E2CB5B134419C
      C28872A535BFC7A0A7B5158AD04621B36E5C1CDF13E5CA5853AD1AAE252309A7
      1DE9FD9BDF24EAEB0E438E9A446B6B937D91DEA22277A979625E29595D53A5F7
      F5ACBE12219BFBE5417E9E73E06D9097FE49383D204F95E7062DED18C1601D51
      4C6A8357B756C1B4EAB69C343972B5B446510A96BBBD34C74109430A22795ECD
      E22AED435296A1735867E40105FDA8042919B45B8DECDBF7D3400E90FD3B0E20
      0B6E3E101B8F037B8934A4D9E689A83808CB4320998872AE2732E3B7942337B1
      3F360692AFEB2B266BEC067A7FE216D4E88E442F9BC1EC35CCE6523CE4BE04EC
      7D2C04D72346D6A87F5DC3BA4DA7D2E3EAE15ED1453449D9079BA9BC6E3D7204
      7EAA6A4F3CEAA673A716AB66A2C5B4CAB934BC03A7A79FC96A20D2A630A4EAAC
      46B334A571593BAC04D372AD74D1664CBC9E1CD44AAD53FE699900AD2726ED77
      D6161C0A9818E648CF17B87F17621B8EF6852454B2771B60C1511A546AF8B40C
      128CB1A231F529F8E5FA57E9BBBD3995B77D669D8B900B8E941D73DC21F51463
      2586FC56563EC750B48C87772B79EDCDD320794FF6B7D4C21C6AED1736C63072
      D0E2DAC2754AD7601D69A9B4A48A282A5F4A0E035C24FE1533B8145181D57571
      251D11DFB6BE1EEAB3267AFFCAF8980D33A6F2CD8538F9A50947B639DE144BB8
      1120D46C8A9D2CFB4E213EA802B15CCAE5175974FBD752E22A777C5F28C7473E
      318BD546209427E7582557DC24255422584F3614E7D5D444CAF44BAF38F94C9A
      C3894461E38DF523011C353CC36EDB59582CB3847C45DC5B06CD35B9AAE7ABF4
      4578F9380BA6AAC727D324553FB7D2F253E899DCD510AFE4153F7E86BD3B93F5
      258A70594A3D13AD4D65398E459602B0E69AA54CC2B2B4C733D966F09725E06F
      DA877ABC1A4141E80DA2A23CA5DFDDB0A394A4AB5540904129DC6A1D0EACAA70
      22375A0840327B077D0D7AF17A928864F9234365241F943D36913E53EAE65E50
      144E77964E5D5CB66C67F3FB6F00806DF60BE1C42F01E56D575A921D17F17855
      24067A2B1702974D54C5C67E2F8AA370642CF9FA9EC7223656E5EE8A7470E6E8
      A821C9EC9F9CBCE7D1A432B4E622A2F72AF29948BD6814E44269D0B37EF96159
      2442B4DA0A4863006548E636AB1B834C8C2FE86094A926481C80B4EFA7FA39D5
      7AE2DC48E199DB8BD38C91E8A3743EE7B0C44476A33A3CA092606506BDD04D67
      816046651AA9706362986425359D70F3582B22266E8C2833359C2F5258D7AA2C
      887215B0557F9980545CB652A6BA5E634E006747B9A8B77D22C2C0B10C811400
      30661363F14310D257B2592B3963147E6FB7A311A1CD4B02C523B46BAA3589C4
      A212A92C467C9C4E0E0FC4E7BF721B034E4D6A59EA9E713CCA5BD6F9797E5289
      EAC26ABA1CF2B3015003C282C705D3B3002B07B78658E1BD35827F175BAFC1AD
      814ED53EA88460DC01141C5346091EF300FBFD8CE22516A790E0AD5980F69574
      4A771C1CEC8AE8BC17F4F3F0A052B56C930AC1FD17B1FC595084EC088B92D345
      1C8C387A27E5F6166FB0440D16D71478968B08F39396F51AF0B8103D46281633
      0AE3B1287D8199693C683916A7D25351AB825AF1855A65B60BCD0AB2691E3C38
      4B7431C6AC838E058AC3987BC8E75CD5719152711F3804227EF938240B080950
      A259B6A61DCE9653ACB674AC54208ABEE46A25C134890A58EF09DA50C65ACD98
      BD3D4F5CA44D3A41119A7B729490DC6E583DF03A4ABF4486BFE9B455535D4919
      CB5802414C3E11E70FEBA6E5169718056922E25435E276C32C0C3E8B347ED9AD
      9EA4FBD7AC610719769EE797A14564DF31147BAAAD44E98F3D41CDE744C3CA16
      7B28C5CA3A4FB2EA17034437E08C6651A8C5FD1D31E06A9593CE65C9ADB720E9
      66F9916E54E372BA68ECBFF1D19C4B557329B071B508D72FA342DE862FC87F95
      4F8B1FDF8C919283EAFB317D4702E4CF000CF944CB2A9FC6EBFA771E4D77827B
      D569920F928C8751817632DDC425F50A8A1E43D502C405E438EB4358C7CAC455
      B68E3ED10C666722CC8CCD8415EB60A11711530FB42C51E391D419EE185D7D05
      D53796DEB84A6D1B91CE209490822B03B1FA4D9DF4AA850EA8EF156D8AFE041C
      6950B942950298A4C8ED8BC383D9E1818C4DAB26ACEA536869AD23B1A2A75282
      C438AAD798F0765E61CBCA2785145FCBF4A5AA81B0ACD9266FE0EA615AB7C931
      6886CA4AA24E82B630D13EF3CC0ACFA6676C16D18AA1899B2892270E8384CAEF
      7100748AF5C6F051004046664D7A8E173051384F65BBB85CA6D8BF906C93B56A
      01347A79EAC86B1368DB2536AAD5E454C17B8E2698A81547FF44C3F4B1E813A5
      0E260336589DC85A67F0C25C69C7622324C350FB266B48A4E8EC86A3556EB42A
      43205A2E46C0F12B28731568D39661BE653979896BD8E69C4C3C402697A36299
      61A934511FF0983C45A2A41C5AA5B51A0D81D0A8CBF211E2BD593807CA96D771
      3BE03DA33239CB0445B9224D893F53A1AA25D231E994B23E96D50231707B9953
      5D8BC002C95455C817E1312A9528090E0FD6F725BCA6A87E965EA99207190FF4
      ADA52AC3959D3FD2B91561DFB9C0BE237C22BCC6C42704AB5602E80885648BC9
      2181FB6D08ECE388417FF4FF2E51F8B8D009303B2F986E548C89D27FAA93C9A3
      172BEB4590871F68038E44F90BD23387E9B5DC4DE1379181B29AC791ADAF5C9C
      963D2B58F34BDD71FC578B847A4E76B2CE5FBD7D8B3B1394CDE7C5AD27B51352
      9B475933A465FDB9659DF2EAFF647D0E5779BD1CA4307702E038AE0914FEA396
      FAF6031C5209BC37C925CA5D2A5CE3A85225976B7D697DEE255D168749F0BFF7
      A294938C339427429678D24E9660899C3C26CB3789980E6AEC16C8748240AF76
      A23641E50A50CA06DD286272F3508D2EDF5B8BF7278B6C19E3B8A85878F75578
      FC00346A26DC8CFBD77D570FA452582EC3CC6FAEB39B87284449B7C530241902
      6D8272C0205E6F3DA2F28DD1AD872DAD8947ACC15F5594A58EA75A0754201C34
      A5B2589F4C9ACFB960D398C2168ED4A847E4E190E5AE8110ADD024A9BC2340AC
      61B13336582AC7A97440EAD54059CAD14D74C2279DA7CC43D9950B3B39FA0C24
      1B893F2E4A592662768F029066E4DB85F38FCC51BC33286AD564DF335DDC041B
      B54F04C0966801A94356632E6A88A7CBA41C4ED2E67221CB1CAB2DAECBCB9A0F
      99E6759E66E4939882062C0A1853A8CCA6898A22FE39E10E85DA4D50BD2D9689
      56544BEC1F9C126A58416585B9301687A3041696C4465C04716E9A913C87CE7C
      95B4803FB3F71B2680EC276784BDB878B5EFB44D9A428F84E880DD794037C370
      076AD4F33D5503DB97C8931F65A44459BF1AFD002C310019409320F5FBD1A1A5
      717A09AF33EB85288D2D0B2293609A923BE9DDF38B8F40AF86EA8829C7942615
      8B18331A978C934F10DBB1AEBE9E2A8E32704B4896C4C763F45C513C84EC1A4D
      8403345538C90948A32C9B1CE3F9A1F38C025FC8B237A6D2C352122AD57A4207
      6411A60B995C344E55EB80009E0917528E86B1B4C34A640B95573C74ECF2557D
      B0AA8E2D661CA5D8B2520E5E297CA3F6241C9C522780B5E9B09765EC98E2881A
      E700734C8CE2DB228E64E5D228870740BFE0571E22BFB970E04D61C69B5E4B1B
      1CD6DF4C99E0F9B2D4C043AD94B91095735AA9127655113A395062FD63099B24
      DBF6C83A2F47A416DC6D316580CFC7B4E20F55E5E465EAA88ED954FFB325768A
      92E0A580598DA2D8BEEB8DA741B3C0976FDFDB162565057100F796D7F0E66F00
      A89FE1D8BC99BF4C01BA5B76B31E1E9C593F62947DC82A1763041C52F68593FE
      4DA5CF43111F221A6789428609D53154EAD838B53EE3BE5EE1082BD12C6B8CD3
      DE77EEF8668ECD19C8BC9F0BCA4236A03CCDB81703D93085722EDB92ED09AFD4
      0929C981DC3750F80BCB1AE15A9E03CA7DCAB27C01302C69D7460BB27E8B754C
      C4144BD9ADCBDE27478AD472BD71490929F4193748154EA913CD8D2FAEDC83E6
      890F82B693F5884C08E2C77BBC196BAE799A4959A8DE226E11C82B2C6D521A70
      F04CD3350A4367673FF11D212704719E6AAC04DE74A97C51C2E89284A130C70E
      4BC68CE482F23A400C40258DF33E34EECEC156971189FB1CA02AAC0627E26A8C
      5107D484860ABD8F298C7CDF6985AAAEC7A6384D1A2417F8DE446F8B00E20620
      C884905A2E876ED62371565946D9E6FDEAE21DF5FA648AFB361D0564E8162582
      CA369A1C0E10875583F60D8962FB8AAD3F9299E34338B17EF9F1EDFF7C7866D3
      FF1CFF573CD2D2EC5F561B942DD4CFC2EB704FF0B884D0B1289C286174224D55
      C1064821BEE9D0526580B4B842F6BE69655645AF09201E653376A6BC25D53E29
      0DF27AAF1ADDA8536481A84AFD41EA1263ECAD54379BD109AB1A93F6F51C7C2F
      E17D360E64B90FC11EF702CF3F6AE80A5AC5267094AE09293750300A87165672
      CB845323621A9C9061B67C9A7CBF4654C08E122213E65C95CE4A934D4C6A2F30
      10C0C125C89A730645815B829AB46B241CD6C746154CEFE632A4F29A72C38950
      855AADB2334BE642C08BABA34F52B43F2081660A2C06F4B0011EBD62DFB1F797
      9FC26CF5ABB5C1A7BC2FAA6F73425115819435469542DFB299E91FB80728F9AA
      EE725B373461BDD57A09BBCD8DDCAB61042A07800A405163BE69D97B68737058
      D9918F03018450D4126A718B2CAD5B0621861C6F02E35A62D80313234E558817
      C58CB083741D646C3D513D40722D4D1BFD5BF1720A2F3A2BAE0BE569D473C42B
      952BB5D800D922389A70376B10FFA89175250FEC64CFE91A13B45FB052C1AF1C
      7163C8D9572067644E7D3C3256967700FA027FE250D507D44E10D22865351776
      5D32332862B72938B056CBE1F0006B5A721C9A0A9D5CEB1792C42B1168F429E1
      7621F44D36CA539A9C88983D12A6C82315055BFAC48ECA946A9CAB0C146B7AF7
      D9A3EC1F0240ECE11F4243C913C68CA4657D7AF9A1258DB56F3EBE3B8225FF63
      490164A4F12E58E3F62846256F015A5429B048F8539E3A46198C5CC080600E66
      A8F66F3D7AF1FEE2E2E9DBF7EF3FAA203D783F86A25462F5A4CCC83486CDCB1C
      7F572DFDB1CC12146B27D6D1056A4BB8FD6243D1FC1D26CA9148792EE88F53B5
      48942100D62DD36747E934413BD909670A604FCAA33716FAA62C744E596F9ECC
      2DF24F8968C063AD4FB24CD001A69B5157E87D977B5F66C1F449F2E425E61601
      BCAF6669C5F0B38F99646F36248FC968A37A2C57A3FA5601244601E805324437
      BA635DCA61032F50821359FC4AEA7E09855C5398D5BE63EB0FC1A535C7B8B548
      F361EE095ABE067EF7F1D545FBE9C5C52BCE417CEFB730EE2E207E1F8EA7B25A
      307EC48CAACF4C31135642648C20F00E60AFB29EAD6CE7ADD7FF54630A3A8C06
      60EA7E49BF62AA08C5C22462335A98E2988811CB9763C5260A8C1B87D765940F
      DE33A7CAC1D1846480E2CC3AFE2003E6D618042B63C84130BC7732393BC102AC
      F89EF3BF91BB858E53308C28CC2E9F2D27A0EAA018C45DA339F1446B0E52ABB8
      529BAC588968B2867D10306B03FD91C1E8F000030BF4909DCA00B98C58E28410
      E05013607F14A817259857C0E12D89C6DB7E78FED33BE66BE4D72C05D631884B
      98F333455B3A453A8C97232DF292D394806B4E30671446129916D4725E9288CD
      E832A26A3F51CEE18B18021E8D0438C4A6E792CCA906D6440CE14ED8C6510AD0
      0421A1E0E61ED2F4AFDDC1CB9393F8B01EE4589A4EC519E6000E8AB882F3CB0E
      B04A142CE1B444B632D26A73702D9BDD282D11A6FEB18AC9B45002FBF110E869
      19D655D4EFD39A0F6BA74903139FB7137CE5DF97F34519EEA6D284C47D5A9C53
      8BBBF35102082D4A64E8EE3B55FF11035C03CC7D5A1694DF2CB436DA9E6CB9D8
      17B785D6F95E9838B456EC2AA93012675414D7C427B03847994F41C06C691731
      CE91C7D33B36E2CDBFFCF7AF2A3F0A04405A34460026649792418C6A1F84B999
      C7553539C5FB2AAE40D17684501DEF7AFF37546B8A7AB47D5E4F0F4BB8DE3ADC
      B5A084FAF192528865719344BE4EE14AEB863971DB338543FA0C45CA1E4A6D51
      B2DCFBA03051058EB2DD528C7BDA93F3F6512F63C92B2F839D10F5E1D08DF1BC
      55BA717D0F4CFB552E3DE8E222D5C07DF3127E9C623EC4C7998AB5C26477143A
      4E00EFB11599C6C0D411CB409455B1D17140A1FC31E908249104A30C781CE8BA
      79A5D9CE7E22EBE181ECD53D0EE322B016143F47291D7B84BACFAD236DF96497
      517D33440436934C5175A792B8484298E428809557944D7B95962902402385CE
      29ED6ABAD805823248EF14CA84863E1E1F9F2571F4E81DD62398869C7227AC78
      6798598871B81C8E577F976EA304F20D022F47E4AB158A2E0665E60EBEA5F60E
      99F9CCC5A732A56FEB78A2D200D9C12A26516B6F45E79213AF257F7461621B6F
      561942B22D4265DA224D07F84D14071947ED8BC2913AD591EDD3F5CC482000FA
      1B158838A74BC2FDC6B35012B320FF9C8B7CB62404ADA6BE1652EDB43D60A775
      D9F78B15319920ADBDAC4ECD689728743460EB884C38A8BC55EDC238808198D6
      B5B4CDD5EA12937114667406DB41F2B86A7473FC57EB1511C90B208F5849F493
      28ED1D24DA5D84F0A009F9DF85A3CF18E351307A8D657D7FB912A0D095682498
      7D24042E6D696523446DB604BCB098A514F8B4BEB79408012A242A43AA329BEC
      9813372016AD1A13676433530C419477CA62E5629262CB12BDD3AD68D3AD5E8F
      2F97CD102265673FAE2D23933E3A607242134596535289199FDE9223F2443851
      645C967DDD802304568AE9CDD7CE2531D1FB50ABD93A15593F94AC24E268F339
      17B8A011D788422E3285118E4211E78277C24D2CCF769981F956697175014267
      DF1A7488BF637CF24D1CFD7DA275DA836122ACCF07AA71C141E844066A13E7FA
      0E95964955CACD8F6250338B234A0217914FAA2215669B020557441A049AE704
      11F8F0823D0481458B2D7EC4B73F7F71C6F74C0149651815DE85235CE1A42927
      738AE67D74EAA2A3567F5A75A0AC4D4450B4EA4AF57DC7234387433B10DCD0E0
      B9601340BBD1E527F692AA2AC2A17D266E7989E3F2245A6271D565AD9918B0E1
      2596F8D02C0D53246059BA9CCE2A180B87551BDE3A16FD03654ED40D185E4994
      A7DEB094A02AE05A5BA7747E845429FD74B83A55F9734450B81C18B7A278DE52
      D90BF5EB92D497D76BFBFB339AC1A8A6A4881C42ECA99F45852815C012CD12A1
      F6A28A7DC6C4898A5412A1D04185D69BF2E520E1BC28D31B6EE271548501F306
      F44208CB8CB4492C6A882E322CC49031D79134097F3916C52C013B097C025DEA
      67FE44EB02A9F5932CD86752E8D56D70D80AB9437F5959930D1E9D2C638433D6
      93A5C39B951568442B6B6D28618614AA19903BD911A3B230A1822893AADEB655
      A63F49A90117F1A4E0E4AA741A925701C369694F2527A88D4E705350CBD972AC
      03439054B61E47F372E8D2E35E859075FC2E50295CACC213B885A823E897A071
      04E2C303D1965685B3E824210FB5D50B6E5EA68B08E945D8BAC767FB1E142245
      294045F40FAB2A035A426B2940ED893E4530916570144482BC060D2DF117B520
      C05FA07021B33AC46C012D395A507F5C891F547921C423C7BDCAF1502ADF764B
      101C15109F2F2376A7C85C909C6D6B15F1D5D20A30E170EAC89732AB92BBF1F5
      FB6E4678411649F2E5606543EBFB305EB4AC1FC2EB650E1C0DB6F7BBA8F87E39
      6C61D80A326B6AC10DCC290BD110194CF7A43DA904D386826887079B4CC74A82
      C582495751324EAF248C4DCBF06ACBF0DE576D198E086F9D628356D9B395E84B
      A5D2CC6EEC943A94305D34DA96DFF11C96B3068996E029B47B4CFE26E9752ACC
      1BA156D15C5552C99609D9CA827CB716CDE407564C4238497128744D2221B4C7
      E8872D8007004D4D1754AE55D312243C4A4F6646215CB0F65CEB34B01B4B1514
      56EC2EEF91BC9687D9250AA91FC2203E25E9724475FFC860407222DFCFE5EE50
      0D1110C11C6EEB15C64263384D4480C06A4DBBB5F4C303C9524EAD57F19C9C54
      D9F34F4FF20AABD10EA6F53F580245C8285C7009E4DA6541755CF25C14842E23
      EBD2649A521DDE25D640A9A08B44937D970444F746AEBC0710E793B717DC5D46
      4A73FA7D25705326F1CB92841BCDC73560A92AA57AD84EA9051EBDA494FC723C
      41E3D8CA2113A9F55A84D24C45882E5B6361A8F2100BBEA04339D23A83B3539C
      6AF8D0FBC4F0C2F72C1B04ED3BBA4BC29285F38840A5C3724FB0FE7915815440
      0516F68309C524CF220A4960310E69A8893F0AC4A2062911B5FD11A61C1A54D8
      9015F663E347324F9625A28A126BA92E9138645452B552AC14A39A49D3CB1091
      33AC6D9166AAF240AD0EA828775ACE24D27C6F8B186397C88225D786E3C90026
      18980C8E70B994B2D0FE13823699B0C4541F5FCE5494EF91D186924995FD9834
      E67366BD6686C4E73BD77C3B97A26A749453206C39B51054081593C63DD43098
      43B042E57A00418FBC6868F55F2651B1DAF7037FCEA1C4B00EC0441483F74373
      E5008FF5C55BC76CC1261CC6569F9BDA7CAEB55894DA2F5AAF67B0E0D2618145
      70F82DB9AC250784359A2FE7E2AD80A4B320169E5611E9287EAAA4C28982BA6A
      5CD50A5256B615F1BC468DAEAAD1FDAFAA461F1E5CC83D3D255C18095C9035ED
      2216C9EFB2F3556C15645DE9B4AAE43CB991B84833371BE62A8CE4DE280DE1EC
      63DA295C393C781D515D6AA1EA155111AB5487633DE9FDA4ACBB55059C8C3799
      8B1017C00A4E85A2C876E64E800943CA120BE6D4C1BDDC1459E5905E9847FF0C
      D77B152B708B907661C22247323EB15B1045787E44E2C5001504E7F06022C2C5
      19159B17493E5A2E984F34B0B48BA842F900A81110C2A4023B7A115324E5FBAD
      BC81F3702934430BB0DC0DA0311A5ECCD1477C8A6EC72146B50BCB89822885CD
      33BA9EE9C07D14D0BE91813605D619952FD23097DA2D8422991AC864487A8F36
      A14A7BEE64EDD185EC6A8027EEF060F399C3ED5C6429496D296703E6B36C997C
      B6F2D4529D15E4B0B83AAD72EB4D93DA06EEECABF8F63D023849CBDC0F44CC70
      BE2856D830799F64B9A35B40515788C284DA3E3C95FD1FAA25CC6F6EAB5D8D4C
      A76047237755E42EB8EF6BCA5D4031E7DC0528E0E6D8654D7C2E46767800FB4E
      B5EF31B91D433AB17DB708D756FD9E50180109A358527CD58B3089A649F96B8A
      419968F14262358BC6E3B2B7FA6E60C19B094B832AF3BF0E050503198CC455B5
      67789224504E5ADA21A2A5F2B3BC609939B1730BAF37AFD72B2CDE71BFDFC95E
      889876AF1396CD1BBFE79C88D5143231858053CCBDA9AC1455B4AA706D151EB7
      BF45C0B86CA86049472FAB20FB49816C5375B0B2DC8D4C391DAEC88038CFC3D1
      51BDD4A8F5525499E763DBB62B3168A2FA014B8EF45AEE4E46264B4AB0E2164E
      589168C3FE712CF8FA148FA9BF184C6B261AB2135B5D66391C9DE5828D945709
      362A3AE142F8B07CD577838DFA82EFF29C64149CD28B41795BB2970ADD7E2A4E
      95BBA9A31115F0D096C6485E5DD923801C81A996A85A2D5A2F3B8C49F953B56A
      95F493E14011C304867D1742CB52C0CF63E49001FE4BC629B813F03A14559AF7
      2701473FDBB7C0A4E9BC722279B60C37089B2D6B99E4220C0D47CBC5810346C6
      25FEF313E5F7A217EB0649F84A1EDE885BC489DAEEFF267FCF394722C06CFB96
      AABA45719A0B510F469E03629F2E593DB3088DA7719AA2A343E4764665DDA4E6
      0D2F37B5B8EE3B1DF8D7E9792EFC71BB7E0FFE789D8E0F7FFC76CF863F6DBF8F
      B7747C076FE97A2EDED2737D9F9FC65B0073BA348CDDEFE34D8ED3B7F12EC785
      FBF0AFD7F5E93EBFD3EE3C2A26C1E21F5861E8B965BDC0FF176084CFE796F55C
      C6C2EFC96962214DA1AD3C017A2F15C43B83755BC3BA12DDF0FFC537FE9F423E
      6B6FF00FCB65309525EB599471E2D9B1CC8E2FCDD4D65FADAAC98C1094DC3EDB
      AD3C76CCC4FF64CB65E3502EFB7DCBC8742CF8CFD6E7CA91A6C20ECF3C153DF5
      CC15A94A4885EFEDAB6CF6BA2CDB47A2F4C7FD52B3DEEB0DE883614BEB605BB1
      89676159E47E1888E414D90DBAEA7A7D837D4F36F416043DE6079191FA14A18D
      E94D7A9C866C14AC9C749FB1A998A8D74C3D634523D942DD2C940F4EC1AA046C
      3221420B072A6F01A7A0CACE5CE4044BD3427B3BAF0F8D614A4DA7D7935E061A
      DE18066A59B824EC61C6D95F3C3A3662139751DDE2F952631AAD3E9956BBE063
      2A1B6A536FDA32C405943D2EFEBDCC8DB5B4662DDD4C2DFE286B299605FF0169
      E67F11BA494416088B4511776ABB9E17F19F7F9233A563B6B3537D95887ACF58
      09EA9982ECE97F4A2A019FD422E0F34F1B8A2AEEC64ACED978F332BD4A9EB18D
      482EA6611F70D59B96B3AF8CF88DAC69364212CEB4916AC88884FF0AACEEA0C2
      FC4BB0672E6DF10E59F2A7C553442EEB18BD6E27D65351AF8DD14EFD2899C809
      731EC161C8EF9C8950C0BC085625D7E1D203C2DAA28C20F45A6CE8A6DEF626C9
      B1EB79F30B86A16CDA2EA2C0580095236F0E6FD6E29BA539E8350D998457140E
      A00D914B2C38B28EC7351BD04975E663ACC97ADBFCF0A6C5FADAF7F5FC89E8A9
      1CA348A9F76B8686836018C6F9DAF1DB93D3F7715681C27159FB462AB0912E3E
      57BA93F0BCABA52065080767C4AB8816598C9390F5860CF80C1126E02EEB232D
      EEA66E004AB423C3EF2A560B5113051912C702E72A5A53B635C14EE3222DC89C
      093E132CA85317F66536E254226A5B348A0A2A8247256454E3662EB977F4CB4B
      501D7EB5A8AD0FECADB4FF3E45AB37A611EF4DAD2D32C98B5C18AEEF84B0393C
      D0A1735C010F83F2448109535FCBA6F141BD180F1AE8558CBBD00F392A34A0DC
      5A0E74A74623C2051058E7AFDEBE95A15781F5F387B72FC91C627D78F5FA4379
      1DEF3A91A5AB432C8D1564AB8A1E1A6665A32B541FD7D08248858AEF5F6B252E
      33C844EA01474B72E5310111E1E3CB370DAE5E9D0BDC54D56B51F644453D559D
      9A8920495F9E8CACC5540DCC81542F938175B20C2B5694E79E5FD6B12263D4D4
      5434403811ADEA2AAFDF5752A1955463F0ECC501071E99AA2492A3791D066515
      35604FC5CA3A9E50E3FBFFBFBD376D6A23CBD685BF13C17FC897B8718D4F632C
      E524C97586C080AB7CCBD86EA08673AB2A6EECCCDC09D996946AA5649B3EA7FE
      FBFBACB5F6CE41488064AA9C7D808E768194C31ED65EF37A16E96165345B80EF
      6C511C9DAD69CE302F87DF3F65DC16620B152A4B030459A4944EFE4C73A08DC4
      B7F37AFC37EADD4EB09A457D031E8CA4B9650D9CDDB200D2EA6C8B498CAA6A14
      7B439F5813B3D8DE323E3CBACCB4033529C76F4B295662A5F383B949A2B06006
      68FE9BA45DD94B77FFAD64C4F6231B5B56167EACD95554D0F5D875C9A842D051
      39613F8E19699C4B1ACCD026539D669F2BA8B44999A19C2D3A6B6790728224A9
      B97A9C5FF52EA2D1E241AC0293D0AD7A6D1B7552317AD07466F352E4CD4FAD4E
      241569569637945CCE34A167960DE8AFF4AC6A0F51ADA5114C23D3FC8BB2CE18
      27A612CFA29CE3EB1248EA276956F2423CCC16D291F7F0EDBB73D3E41B13BEAA
      C0F905238625FDC84073547E67B3A0F25736AD7A4F3C782872ABF5C60B5AAFB3
      2B7003F8F3D334E3C6620F4B09C6D25C5F829DAA1D4223F5CA427E32FE90B372
      4D4BF5D892B4A5BEB7358453355BA0783A6476105AD2580CA0663D61A584236B
      D0BAD107178A7897CEECA322047F3E9CA4DADA9A8AEBAF6B3CD9008562872E18
      33CFF41754F5BE759C3C19F302A435E660809B88AFDA91CC6CC98DB99351EE2E
      320B9F195FE6993480D8F94F5DD8AE09A6A3D6DBBCFC6061BAC60AACD284AF63
      86DAD92E1D7FBD54FA968918357FB7B6B4CDC5E2CC5C73DBF5613CB5D5D437AF
      79F53E0342DAF4A3899462048C45A9BAC788F80DD38E6875ADE32F7E720ECE35
      6DB506B03107DBB6B76A9DDA7281FACC6645D58BADA84DCBEC41750341285574
      8FF72DAC8A609F5C56DDBEE4398595E9F6AAEBEB6CD74D2AEB7E345AECA1D162
      C56C6AEAC078E4E1F73422D1969569E2585FDBB20463341F1A74CF872E5C385D
      DD6877041C4F07F4F8ECCD439120AC2895CC7CC6D8768BCA269FB35253FB77E7
      7FBD7AF54A9067C10D47137196576AEB484A5E5328B6D55DFFFA6F7CDB7E8949
      9D426B363CCA8048CE722253284CE3EB8A6E1341F851F7FAD38EC7A936CD91CA
      F301CEFA8034AC32579F5C6C04E664F97B497605EE614048D83BA5E7A0E63FBF
      D97C64BD60150FFA7AF44EF5385ECD39222DB42E394B8782E22CBFB8DD406969
      72872D45E82194559D5211584D8A8B2A22B4F4583DBAF5AD1EC3621D7267AD49
      D9ED9637FEDDDB8393323EFD4F72CABEAC9BEBABECF37BD26F7028C6B15E9207
      F96587F8F93D379F7D9BDF34E02F1E2E7184251D6DBF7489293D8448EB9E477B
      CF8BBBBDC5CBFB070DB67ED46C17C60B398994135073E4954DA938D64A8C7224
      FD4C0C2A1D63B48F8ECF4EB2F411C8281F0ED544FC7C6F3949B18CEAAB8782D7
      57CEBB9EF36ABA5531F6D02FCF7E738AAB51940F4DA8AF090E16CB1A8AFE5CF6
      5C300B4B86E914A27D02AA6BF413179772D1ECE45985E85945E7AEE0A6C78154
      F3E1ED5561362BE4237565FC181497CBA71739B9399A7590F45ECA722D01BD8C
      D4A797C439CBF848C51F180075BAEFEC8A07D62404D83EA43232872D60B20F38
      5F7C9CCF2CB636AEDFDEB22904FAB3E2E8AB7C65EF95C029BD352343BD2AE282
      8920158AF2C812509E43C5B61AD24681A4B692F1E1CABE7BCFB8EF1EE6379E55
      DEB2C4B46B2F37C8EE84B4CC595C7BCE87A85A6B2E36E43C3693A8EF0C194B50
      AE8EEDAEF1A56AB6BD557B0E799C4893D36A5C94F5379477647CE9C9B5BDB238
      FC8BC0430BAD3AEB0E7A6902652761275CEB63231448DD63B38F59429D572DA9
      310A77F37EB9B87E7BB9844B1EB02FDB54D13835BBE7EBB7B70AA1797EEA6EAD
      B2D5ECE55379BAC12492FA55C561E96B6FB16B2BCF12EC20CDF9929C56DD7C86
      9D49B9605C2798D924EE92764CB20BC867CFE468D79B5F54CB581E612DCDA7F3
      795427419B3BA68B8CE869CA3D1E6D624FC7D935B0DE3568268E924B64A6585A
      756F421F9472655006D4700A6ABC1214A7FA089CEB35356309DA88D7D4D42AD2
      C0CBCC1EC3EFB09C18EC83EF7FF796427EE2EE70C4B67A452CE63B6E2BFE40A4
      20A3C1341762A7E479D6F6AC56C5167E5460181901FE7F6ED4DD5246B3549673
      E5A1919BE6D8FE0773CF064A117D2339D0F55C94C6C6D01727D256E32F4EF781
      D36D633FC63500842A685D189EF280A8B854E1CA4A57767E2C12B0ED4A4E4D17
      CA40432DDA5F946B7743E4DF6430977D45EA3259000F1AA80FE2D991F659F907
      DBE6A7312A13DEB76187DC4A6EADE2CBDAF0E8F93CBC6B4FA0AF1F3A432FCB06
      52E8A9ACDA9A8C0316B965C6C14341FA3A5A3A792864F34CD4B1A96645336615
      794AA4666C6972012A0130902A155CBDE7ECEFEF4BA6FF88522CA89D7B7E519D
      366335ED1433FAE497F285BFB1D3D4DE5256A28E73935E6CBF29AD023CF5C214
      F3753B2077288D26282789D134B4468B6A6A555A1BB33DB7540DCF8893B19272
      82F20D1608937C798B39D68C812548FF263E62FB479286BAB8966486D5BACEE5
      E38F7A6A200B99751002CD15EC8911E5B13CF4E3F9AD1AE937D9F883F3DC79F5
      CEA76C54FAEB811CC683FA9C6D9C9768FC957F766CD5AA6C1C0FE7494594AF8D
      F163C3C245A301151E28C5A7E6C962DB2ADB71ABCCDDE0661FE603EAE0B2B790
      DB51E56F99607976CDD0649B84ACAC720F6F4600DC79AF66973B5C1D6CA45DAD
      CB9F4D44A6C35975ECA44EC5E62DC91E710855E34F4BC432A1A3E792C227935A
      D980A1969E572A092448A11EC81C9435B51BCCA08CDA34BADC08485CE977E41D
      A47DA00C3409DB44BAEAEC242C8EC6572500325CFB83E705E2C3B52EA9BAFF45
      8478E50F4BB3CF0F0668FDC01952B6896322B894D8B274396A4267A492324FFF
      DA6A96E94CB5667C17F5A8E1EBB104F0A58FA61418D86C34931044FD1D3ED503
      AAF371D9612FA1FEC6856D6B5D9615D6BEA79A843974D87175D60FC4839FC560
      19F4AEAC1855B2B996C96DFC6CA4C91BAC32AC87D9BC863F63D9C4F74AA4DD59
      ADCDE675C3F393CD473336EFA2BF898EF2F656B2BFAC08AB6A2BCCB067559D95
      C9C32D076BFC5BD1153568308670A74A76AD5AA4737BD8CC349EBDD37A95AC46
      566A072B319F52EF879D258B6266C1D00D7479E1FC787270E4BC9F924A33CBA4
      3532CF7CE76C369DC7B31DD20C770E1831244FB7B71CFB313BC0253C2D2D994D
      E49A1C5AD281E3C627D9E7EC11C21D0D7E1A65B329A5ED0AE50B7C8296B83D33
      2EF24C57A9BC554BE18694A222559AD153EA659E4DCC89A94DAF6E95FDF01AAA
      301834D5B6B2BF9290EEA6EAE2C9F80995833E78F7D80F2CE149A8E6D3D7470C
      DE31541772E015A745508F2C4A657B20CC19BCF2FCF82C787E0685CDA85DCF5F
      BDEB85CEF1D1EB734B8FB5B440E2A9550DED9ECDD32CA15127D32C9F9A34C078
      F2CE2449563A48193E90F093CD111656CF0FE726BFACE04CA13B351AA5D719B0
      3237EF5313CA6B5D86255A52EEB31874DCEE2FAA7AD0088F31361EBBE8A6D544
      C489C2F8C13B65AEA77569D8ABCAD498834A13B59D5B67D4B5B828C740F96C9F
      08A9CF2E22B6A65AC6468BE572191617812D364E77A9DE26B0EBA2AB5DEBB5CC
      7731B8A528923050C9DA23480A1A5D2380C666220EC2436711EC8092285E6C92
      9BA1BE3FE7F5A43C2B90CB03E10D047C266A7E25FDEB7DA0572C1298C662C244
      B66A34D9DDC703E2BFE73C0C88FE2AF02D01D95AD9CF2EF1457170522CF969DD
      16ABCE51A38CA8CACABB9D861EFA31330A0A658B53BDF22E2DF4E93B5273B01D
      54B42C6E80CA5CDEA5FAE53DE7E0F0BB5371DBED396F0EDEE2B2F7DF9E9A8BDF
      1EFC7842B7F313A9799355897206FBD87D5AB37F198D9AD4A93FB3E3FB5796F4
      B21C7BB6EA7B89A6D9DC0B5A259C02BFDC939A87C454F0D04DE424A9F47A530A
      D26CBB48AE09C66EE69A0A4959631C75CADCCE5949FE8BF379CFB9AAE3A53532
      4C2B6C8A42AB290510C808ACD5DCC8D0A93C431AF6368B8944B08AC7438E27F9
      6B6D61DD53261F7683881BB7F9546368A5F9DC36595282F03BD6AC4F902CAD39
      B8CAD5E5E8FBE2122F255A9B676E89B7A9D397A5EF9832DD2E16009EE0EC722C
      85DA680AE6067B7A875756A969C2FE63E5A5EC7FAF5213562C6623AB66B136AB
      B67034D3BA75ABC438A7B7148DF8A932F6C84D075A12F62B8AE02CE2CC3C6E8F
      CB61D8E803D9615133EBC732B6276F304631D5A5BD4BF72D757F49A50A59C2B4
      4395E74B425D6C64D577A05C96FBCD32649674DFB985230D15F5C1A35EFE6091
      F48D415F1E659046458192AD6469F981C801398E379EC3B1F492CACBFEBA5454
      505B49833732C9292BAAD68820D9AB7377B6ACCB2FF8C175CC66B2B5A752A46D
      213BAA447F83D2994B4773CAC2621E2B060B7BA4F96CCBA9E6432C2EC43A0F8B
      E61746716D585725EB600BABE236D582249904C7461629B4FACAF219F10A3AB3
      EDADF27E913FCC7DCB78BC2D3B259B4F16C2B44BB56B440C9683BA9F4C2C83C1
      E14CE381BD2A69CD8AA66AFE7CA14DA4E239D30D2495E81B020A9D4A25BB914E
      0BC4FEE03D4107D66B5A75DD20F7DC925E16D998E3C836E3AE602FDF9C1CFDC6
      7DF14018C7F9F2BC91EA44EFB2EE448E63683CC3ACA02ADDA673DAF013AC228E
      14A77C90ABE7FA8A8A26606CCD7A0B02E24C922839162885B84A4EE6D4923273
      938F3A03D836D2485ED74096280666AA9055210ADDB45473A48AB71A05A93506
      6C0C4FFE9639606516574F34187C8DF89A4DB8AC40EB398D074FA0C45C45D7EC
      3BBB2FA55A892E510D4CA65A5E763547D17084139B3AA7669DF5276A693629F3
      8F059E50A28619F876DDE78F4DCB626D34A00BCDF1BD329CAA961E14FA4674E3
      4A2CD4850A8F8EE63112872AE986C4D34D86ED7546DC888B5A66B990C9BEB72A
      77A92E55CC82DA4C298E83DA474BF77788335A00DA7061DA92864D78C8B5D8A9
      BDE70EA9530F9E99EE9C7295F88E5DA34BC9DF5A16457F6015199C8B6A57A7EE
      7DB8E332D994E94B86D5D1635B8F6F1F31A1BE4C918E15E950D98C310EC9CD54
      9417D2559F2E29ABC0B043E1198BC5458DAC6F0B5267DCFF50ADC416AC2C258E
      873D74B27FF3EEE85B6C8951D71E0845FFA8A68CF327B35E16B537CB42FDD4B9
      6264FC81E2EEBAC8C7FFDF032798B34B8EA6E522462779664C8004076E44AE64
      2EE78102924F1F8A567922A9924525C24BA7A16171E44D4CB910673A9D4FB821
      5B73054DDAC46EA9F4901BEAAD7ADB501FCAFEE8C46DB3F19C293521E053899D
      D573406B2F6674CC4AC0DF30DA32E98276CFC9634A59B0B9BACDFDA5D0A8F9B3
      02486BF66AA094830F637AEC126AB94E2B76C439F630A3BAFB97A4C415899218
      21E76A0B5C50AA387828B13F880C733FBD4FA6619528231BA0C88B0E9B5D8CB9
      C24C9565F565AA07057425520A6D7EC66D2128919CAE89A6F90751F7C646B1DD
      77FE339F8BC8F9C03ED288747B8E4D7E7AC481F9299F72191657AF9C70128AF3
      BCC256359FD06938FD614CFB2FA0AF07C38CB3179CBFFE7076FE50021AAFAEE7
      272D2479D23A5595879CB943243D8FEAFE763EA9761DDF9C9D3BFFE69C42F9DF
      DE12F55F96F663415F1E9EE14B2A8735ED37EBDFBDA1EFDEE426DCC7DF3C5D11
      6829605B41A5B3B591AC7995A334CD666A91963A2D48EA4F931AEC1D2B701FE9
      33432C8FA8D762AD1C4C26E068924EC599FC16BEAC9697F8400ED181F3AAD6B2
      632103AFEA952451917AE7D97C14E551FED9B860EB7D3F58340EB3117EA5704C
      5665349AA7D87BF9F48D57773F72988E2153CCE1B638310411D3082E35FCBBA5
      BD2E6FDBB36E531BFC3383B856B0BDB702D34E151FCACAF1852C5292FDEA6389
      84EDEC9E59699964450CBAA16E1FE6962AD7F46963EC72FA2D7A5E3CCC0B932A
      FE078FB93E5AC18ECB670B590CE6ADF5919BF5C628ADC78D5B887285D79E4D10
      91FA777337E7EFDB002E054CA5AAFC4981F7E8785E8B9BF2A3E55114BA94DBCB
      1219F2D034DCDDD4A48A7DE77303CA6723CE6C86181D65115D901EF3D0D99FF0
      3DD6D2FEF9F8DD17C2BA60BEB14EA8D1F341920894CAEBF4242B889C7795A6DC
      AF17CEEB4F11FDF20D8E915C427F11D37941AE6A5C896FCEF2E94CBE2C5E382F
      F37C483AF0BF39E7D4ABE59BFBCF532215C2A0E2D9166ED0F223F3DE89C59359
      D238867F994FC7DC8CA6F2E5DA4A7A280825C42443629A40FDFD46BA972C7BB1
      64B9CB053D3FE3752E6829AF41107D61801C2390509B0510B3F3A7547533028E
      3FF0F0F6296260178BA144C445C68146E959E0C482F0E9D468A2D155A164387F
      D09ABED4107E8208B4AB4C9D3B2FABF9FDDE09D28043DD613698F9FAF3391E27
      7FEA6C286B667BAB068343128FC4AE09975078C426F215A6F7D93CE296889CEA
      7F29BD246B2DA02EE7179A4210132DFE088EC1D2E5CF453E728A1257C5D8D6B2
      B5E4A13A26CF634FE30A7EED8B4ECB4765D12F9C5AED04D3D5A16D77F28DB922
      A2F3545EFDFC394C84F2AFFA59AB9EF3F49BF282599948E2F0CD9221872D3557
      5F954A3108AD7A42794F9A714E44ED19D57158FA423D4EEC1FB55FFF47CBF18A
      5540743088E431B9B10E2F75FC0126F8876F7EDFDEFA5A1CEF5E26F1C378C8D3
      B8CB2488C5AEC5EA6A8C0E660A47730C12674CEF26D624DE100E3C2F24FF95C1
      F32AF66D40C38DFD5670295D910F3FF293C9154AF1E44F19973C4825980518B5
      917D02E1AD2A6F27B5E4947BCFB7FB299F0E93B3898AF59EF384A2BFBFBCFFED
      C99EE86D7F7837ED2F1792CBA7D0DD0BFEB0492C508CDADE023F539C523DD5AC
      58D672AE9EAECCEEFD44832E68D026C195522B7E2A3FFC6336DC680C94B7CFED
      49FF19D42033E6B78A0A83FE90514B6632D72261573E48B9F75051D7E7314390
      3132BE380F3887AF91CB42D9B606DAEE2BD9D19D7BB1A3FDFEE20E959634B425
      B6A43F68C63BC61ADEDA064E5186A4B4BF337522DEBEBBEFFE47AB5AF87EFD36
      D7EE576D732D5A5452F6E222DB2F4F5E8FD3FC683E9A389FCF8E0D2845A98DB7
      63DF0CD8ABCDBA3A3F3AA83265DB385002B791CC2E1EA6ADD87FF5CEDB735EBD
      FD51D25A6BABDDAA3998E4051CDEFD4EAB060653AD011BD18E51496A13743E56
      10B8330EA707B12F89866CD2445A35E8CA03DAC6D151CF0B5B85720F0373EF36
      301E06692FE5C078A8A9EBE4B70A8FAEEF6F2E3DF8E6BB8A8F6CF871851F9D1F
      F3674811EA1A5EE58442C335DD14CAAEA9F7213CEE69D35E51F5C4F1D97BCB69
      6D06B38E2FC7164848F47B0E9A1C9FBD6997E47BE81ACB2FAFDEF9BF39DF522B
      06CAD079FDF6D53B493D6FD52E31184B2D9F9B00839594F44CB52440388787EC
      6F6FD5B8694C55BDB7A94D68CFE17DE4B8E66914572102B24C4C0AA044C51852
      FEF3D19BC33DE71D972D8085D5BF393E3B2973CADA41740F9EA531DC0CF3356B
      8FBD3F3EFDBE557B04B6EB3D87A5F29B14670B6768D5088FC705798E95F5C171
      0A2C831AE4239B67536F0FD52E0D570A0A7048A794F0F389E035A0525D48261F
      998A7992985CD6760D7C7BEBC878CC93ABB11A6531B4BE39D5B1C232D3C3C426
      C54B2E7019F453D20A915A2CCDE2CB7DE7272AAD22C0DAD9B3CC1474A8A16405
      371E96A5CE3FF4343780E30C96AF8A820240B9A87243719773309182D96536A4
      ED248CD76E6F9539C6FB069A80EB65296F87AAE9285327A34447BA582AA6A109
      DAE47EC509D33C2A028586DE9BCAE4ECD5DCDF78ACDBA536BE3C3B2050838F9D
      FDA055E322CBEE9EBB4071DBB7951E62CC7E331F719551C2BB3D51121722AC08
      E9319B0BAC54948D190522A12ABFB86CF8660BBA19620294A438B9426EDE778E
      E8834B452521ACD6E2BE581A819AACD793A340C2ECE7AF72428E1C66D1B49E47
      F1E8705EE170EE3E3A9C9BBA8EF755759DEDAD5FCECE8E45D939646940BD7387
      F3C822973ABBA4AF1ABDF6E91EC93E2A1EAE5925240DADDE8BADBE5FEEF12FFB
      711CDF7778893840ABA8101A27E31BFEE6EC0842EF8C91A3A51747B163CBD524
      ABAE5D232FF55033C683D99082F193F6A974E2A9C03FB5E2BF560DF0ECC3D534
      1B393F9E0ACC2541C5CE673EFD6DCEE28BB28169E19C6F6FC14AF9F19418EBBE
      FECC690C985BF5C19EF451E2046629957F067529F838A5CF9FA5B98FDF4A19DA
      AE9DDADE2ADB1FBC2015B3FF2C81A20DA5F1527F56D4B49D60BD4C4288816CE6
      DEB3F9C74C50DA9D9D97E4DD39953C901263D3E67FEC88FA6A60D7CD836C6E36
      6798F053B8C2AC550B338228C9AA0A074CB4F49A4ACF05229C221B65438C8AEA
      16F62C140BB7AE927A1B538BA3B8C2A4EC6CC2D1C67199D5D58EF9EE9C72DB31
      8BBE41E0CA8BD3B148D4FC39032D4CD4B844321B49DE74CD5C51E3964DD1F623
      B30EFBE5733CB5600F89F3F24AFAED702D0201C69678EE35B47E1389159CD5AB
      49BB181D954840F360F8CAFF86D87B7AA226276A0ADDB2D89F7D968A8AEACBBF
      CE75313BC71CE44BEC21235A8E6702D2C2682652446AAA6C99D9C550A9A09E73
      F18EF477203A207554AE6AD58264B683CE75ECF0568DF3A329AC27DC2A8B6695
      30471965FF50ED1BEFB816A764D6587A9D0EDEBF661391D38B9860FE5650DF9D
      719682698EC8DF93A9217E1DE689588C8F96DDCD96DDA35DD7B4EBFCAFEBC366
      6BC268946702A3C48A10C979A34EB66AC3CC80CF8EDBAA9D1BF341B472C76FE5
      22DE204704978B811F6C0E75AB86FE4F2C5A1E25C38D92A1BBEF3DCA86A66C08
      1E65C3FF34D63B9FA5CFFAA5D394FBC74FD5B818AA1907E3A42AD7D826CFE2C9
      0BB93ECE4723C6EFE7EC14EB8D69D5C476CE666488CEF23B1BDFAD1AFEEDA6D5
      23DF5EC5B71F75FA05BE1D7E55BEFD4FACDD714A4D1923A873C98BA1B4831C69
      0AB6B66BD0656CE3156783940049B2D0EC802357160D1F336BE314B6B7CCCAD3
      BF66F5D5C73C4B0A696E27D91F541A5EF014188E6A4EA0011482329EF1A94E6D
      7FB83DD6CFC1248CF660723E200446E44D61A415818E222C870917031332DBB8
      EC06F5C8746F61BA8F01F205A6DBFBDAF9CD86091C30E0D4FB97C7078601B76A
      9FFE595CC8DCF91206BEF4EE1C4D6657065EA255A3FC6C78250DD4B2F8976707
      6576512B074B7D51850246F9478B9C039944889A94F1C4C8E243680A45AC269A
      F87DABA681436625147779F4E4AF4781718BC0E83C0A8CA6C0E87F558121883A
      ED755C4A66F3083C627AE50CB5FAD0C6E1D5B0BFA8A28813CB8E5E1FBC69E150
      19FDD8869EA7D47FAD6DC6974A3E2ACE1C38C9132ECD2A9C542BCAA768D530A9
      09F4FFA616D0CCFF4D470249B22DD31A4C9EC34EC384CCB0E41FB3644EB9BD04
      12D1AA59A5397790B72D9EA48509A8F95D0B33E4AA98467B0B33AA313254A0C9
      7023CF35450C8D7F552E78B133D3C56C7FA2885E8C555A9AED9447C770319468
      E2FF37679B40E7F86F68214F0DEC2E1EDDAAA98BC8574591C719973ED86A079A
      F37DA7DD52AE2056EEDEC10DF7FE8891FA3CD27B1FE7B5A97FE148D3DCBBFF81
      FE01B85F18E9F8238DF4DE31CAA85FE6B8681D53E16C764847E7DDF44251FFF6
      A9B3DBDD637796FB94DC58D28EB5DE0E50EA9096456FEE1D6FE9D928374378F1
      AFE617E25EFF7EEF18AE2DDA9194414AEFBB14E9EFF32CFE404D2408917A98C5
      B385C3C8208E5F48E246D230761E279FB66A5DC7F75FDFF5EEC51F59DCC509CA
      D2FB04E6F984A0F8F2A12D3B21D16D7C06D69D4D0D274673EA17CC1424152BE0
      3B8A5A00DFF3D47730F7FDFD5F7F05E72819C7AFBF420F297EFD757BCB567224
      CE51C61DDF30D29DFFC967B67295BEB3F0CF97996DA14E387B5240A7E2596E0B
      485B367E1AFB513E7E326367D9100448C18F82C67F7E7A7C6CC2F7D8C7320E62
      C31A8E26787F5D16C13AF1541597ED9ADE6224688FFB862EC6F49FFDBBC129C0
      2F653152DB7C85662E3F6935C9C7CF0FA6A37CFAFC60349A8F4D12CB849CB6C5
      A5D6B39691988CFBE5BBA3F3E7F8C795D65A656715768E97D86F52FDC5B62301
      229296C150CDD2694A0498C340A6F3F6D585C9445FDBA8C4D1BB97FFC781019C
      0CDB2611CD484DAD90E977C87E0427D1134D4988631B54A955523CFAA397FBA3
      3BFBDE63DAC882437AF0954B7CB3A2986B271CBC58D1297701D4A1D6FB98FB77
      7214DF5123BA8A2E2F311C0845C9428AB58BCFCA8CBB3EA66C92183208F4CFD2
      E747BA2948BF1673DEDF117E15F8EAA895D308DD17B56EBFD37C267AAE1A5F0C
      49344C476A68420DE2CD322AB16D3994577562A49B3E6DD5142FF3D9077D55D4
      6B19AB824453D5B87BCF98CB44ECF7EFDB7866FB1CED51B6CC44DDB757E62FF7
      DFB345569A2054EEDB2DF7ECBEBD5C66A8E37CACEF38D6353C2CFF72DFA3CDC6
      386FB3B69DB461E29C5D66E9CC00F3C02895289BC86EB2B43F6413D22861A0D1
      E7E6F8E13A9800BBA476C2B89952B7AC796CAAE6E456282A0541EF43385016B0
      C00FE9E2C32C9F601BA0C0AA962F05DB3F34E577DFDFC88918F989CA8B33C2B0
      C26A4D8C0825AC2436754B3E2D3051844E546208B76A0DF4672A8AD52B476ED7
      80619BAAAEDAD9B895E00E3226D3300243B8626F2D35AF319159EC9128F59C29
      0B066DBC4585B34BA98AD19563F4B87651EAE16C3AFCCB216168513F162AD077
      DE529C8BFB0E12A4EB309B4439C6B7E71C17B134E72BAA96C242B6AD9A513D6B
      D96091D983428E14A37E26F3983A010F0B0BDA49904E8259663B80B05FAFDE87
      BA1DF33385E71282E4C68B06CA620F1436CA9D27D2DA73F96514AC7CD2AAE9AC
      8809D7CAA98B17E48711684B46DAB0F1D95D26DE9F9EEED5BA68382FA7F9A782
      E22B07C3D95F5E79ED3A6DE56ED47A844479FE61A4A4E7319888C94078E1F0E4
      BAFBFB817551ABF2D23D872667BFBBC8B90764AB265A4B114C69EC1600EDA7D3
      374784A552F6EF1BE79FF69C27F9F8498D43B66A26D7F3DB77238DC9182FDA1E
      7724B5E60FDB532D3380CC046C4682225F266197E4D4E83CA1A6F1D2E9B61812
      1CA2A4E1E3484D869A206E0C07BDCAE7D312E9204B0D6C621BE7797ABD76C5CC
      61F7A7F3EF4EF7D853B8C7A8A67BE20F9DA8C9D5745E308DEE39DFEAD93175BE
      6384BEB28D0316A44C807EAB3E9E702506418C50CFF70F2C53FE968F3F25BD76
      ED7D599E21B9E53CDD5D3B5FB39DDC1E93A20FD294E2CD8F6FBE75762F8679A4
      86FC153E784B7DFD3403A53F9911861135391620A4C3EF2954C1DDEB4DCA94A9
      D6305D6BAFACD12AC9300C8781DB6A951AED58295A27DFAED3CFA7DF1E518F74
      EB95CD9DD3E357201D061F172DAF8580B8141EA3F012A7154C25BBEDFD9B23B7
      3613ACFCFB83C3EF71E4D92142B9482D9B0245C85EBE3F3FB28796649F49C58B
      F2E48A02B7B3AA6B1AAE7CCBBDB05B388B538D4B3920C9DDBEE83CB0F4BB900C
      4925CE4FF6FFA7AD440C3CF39F1BA06A1375E5E1D705FABB5767E7354EEBECB2
      02FDE42CE358B8D1649E1861CF623F4D9F3EC6376E8B6F3C566835E31BDEF2BD
      FBB3E21BBA98184C5FD32884B2B97462FBABEB62D4AAED323E7D2F7C414D278A
      194C03EE5D990E0D7E1FD4988BA92E0ACE6B9696BE6CEB0E73D2D727D66FD1CA
      49F55E38A2AD4A655729D92012B8172721CC92925B38AFCF4FA8FA803D4FD4CF
      B85E5B3BD684041353E3F0B6458B25E79F923F9897F629AB5B1A73177F9F53A4
      3E9A6243F5ECFA844D1CEA2263BB4B1C17749F05BE611CBB027AECBEDE777EF9
      5FEFB3D9D92C9FFCD6AAD9B3CD7B140D0F395D241F37413825B8460DC52FC88D
      A3220A2C0E13EE554D531C5EB1EAC33A666EFA00084E61BB4E28AB9125A262D5
      589D92304AC3D8C083D2044C8BDA76995B54AD285C91A8D2B2C42BCA848B6704
      70175F8A8B7F76695CBDACA81536AF2E107383F4398287296F60D7B0D95071D8
      B56ADA2BDC557BCE0FAF39563DCD870BBEAB83A2A0E33A526390ED74CFFE1D59
      3F15D37CDB1C55C66C145EFBF3E1FF3D7576F5D886F1FF41118AD29BFF1F4F9B
      0606994AED9DCBFB93D7676D2CAF2EBD3423F631E45191737A20159D0C6B72EE
      8573F2EEE8E51EFE3D3BDA735E7DFBED01FF7B46FF9E9FB5714A73D3E2E6CD21
      6CB5BAB14079D23AA949AA1FCEBE7F6FB4AA569E8692379B146C0E24509B6FED
      A861A62830C2937220B1880510BF6BE54444C9A8A18CD8162AEC1C68EFE97872
      24A6C213D330E7527372694D543E79E676FD9EDFF742BFBFDFA19F27245923CD
      AD3B980360D7C82037B9B6F220F2604159FEF9F0CD4FD5596B593C75C18FBB43
      D6F8AFBF0A84BF13515D68B16353A716DDB7FF149EDB7A8720EB6D953C303A4C
      EDEBFB6A5C8696BFD5B4BA3A9B03B9311A45EB0A47CDF08517BCFFF6F4B426C6
      F1CF743E2931E0D5ECF2624A983E8209AE3EB6CD6A6ACC65095F3BF9F6F81553
      11292772F07F7EF3EEB07ED6DB3A9B9D1FA4AFB08DA0FD7C767CB403B6356D9D
      E95A9567C8C82518D6DC88B7EF0FFFDFDE92E0CC635FA35BBD828F301C0B5EC1
      E52D39FFBCAC6783D7045BF5F95B6CC689E6462164BF9A18E47C0C0ADF777E28
      6C33702820D20C8F7637972E1226EF9062018A32A1A759ED38B463ABCF34C112
      F1CCA6FAEFF36C4AF81E92E3CCF5B609978D802525ED1AB76C90C212531C7755
      352DED0161D4A65765B1D51332473249E0E6200EED63ABA6C64E83831AFD507A
      13F88596041949CB6AD79077FECF7C346198D7BCD42C44F83E296C9AFC249FCC
      275C26D6AEB11F8FC901F7DC38E2B8CA015A9064FB9B6CC5760DF84D7E21E44B
      41B78F7AFA699A614C638A3A7A272FDB35D6EDAD5F3E1F813608817906EB5A7F
      8EB5ED2134254713457FC970BB9CE6F38B4B7057FAE0BD8D62E00C5C2A32C139
      69B698A9D184BB7C8ED8368C34E514A7F321370425DFB98393217595ACA0B46B
      2D6CFD1E2EFD505879518324915A19C2B423FF420511BFEFBC37061FFE0F1B9E
      32373934C0DEEFF6CD7131B47C43D68E69C045484DE727524A44DED42B8377F3
      F4CF541DBF4059FC4275E3CCFA9C5FB46A2FBFBE16F8755B79BFAD37002275A3
      5D47EDED8AE4DADDAA63D5545FCCA99B9BFE4C5DAF183AE569FB26518FAEEC9E
      BF5111B49E846CA33DE7FC9012B6DF60A02FF3CF2D1BFA99210D9338A06282EC
      8028630F84AD4C930810578BFCE515736E52E6C448003B84E2AAF1B7110094E2
      DDB2499E9A984571359EA9CFCE250EE2900E231943D33205DDA8A60F835B139E
      77F1C8A99B9CFAEB3622FE51C1B2E64E19D93FA8786C660AAFC8D5C9D87FED3A
      54EFE65C0A2D7EFDF60FF7B5F8FABA6EB0877F42FA6740FFF49D5DFAE7932A9C
      1DCACBE004749AD3CE03D1DB4EB2227E64044D46F0753BD76D6F1D5281DB284F
      B234A3C228463B194DD42C8BB26106DB8AA57394E39F238D1964CECFC76C6FFD
      7CEC59481EEE7B5AE4F329559151164CBB8EA378BEA847F15B1A68693516B933
      1F17624E0B2A3AAB260664A1EA836B7C972D9BD5CBAB993EA0513B433DBEC0F6
      408B9D92D5CB41DDD077A26C563C46126E8B24B883C7484293217DDD7669BC41
      38825583F1E80AEC291BA931A64B58048C9BF26B3A4C4887FEAF5FFF857EA5A4
      07E7DEC105BFFBCFF7C7A76F5EBFFDDED9B99CCD26C58BE7CFCB91EC27FA63A6
      C654D4BF0F86F91CFF7D7EAE8B8006F5EC3526503CF3C3DEC0EDF507E18EF33B
      8D7B984C8BE16CDDF59A0F7F8D53F7763EFE4523FC1D7457409312C2A3DF68CF
      F5671028FBA2AF7A9DFEAF699ECFCCAF314CCFCFF48B1E27E34B3DD57C37DD42
      A171A2567E9AD05A3CFCB54867E3E86FF72EBB5A746E6DDA0625C1676302B751
      B6CE23D1714E84BC7B6AB25C0F4E4F0EF69CB73F9EBDA6D4B523778FCACADEB5
      CC9035133AFE882D370DF5A4BADFB9A08C4D721BBF3E927836458586D93FE80A
      496E6DE3445EAD4A87E03A40EBB612A8D9121CBD55133169FF1DDF7981D950B2
      714E75E0546208B5850A33186DA11839BBF4CBC5655ECC9E72D4A08C05B4CD52
      B26859FD3EE674241890EC2621B5B26C7188AD1ACE47D035B319A187403FC3B0
      09805EDA2216654EB8B39BCC398EAC9C4B25B58A530D41C2F806D1FCE229956E
      E2FA8C3023C90213F34BB08715656AB46B79CC8E7707581D5B7A0D4ECF410D95
      2444AE58B3A2707E7E73FAA64CA23798EB8489230176890DD0DCF342CBB50C91
      0F1100093BE5EA9D717631B665AA3671EBF5F9493BD7A383F56047670D96820B
      0618AEA2307D0AC0ADB2C4144D14FBCEC1B0C8F758BFD859BC77874C18AAD213
      36D0AE49BFAB85FF0CCE31394D6993B9A418826646A9F44CC3923B11693061D2
      8BDB3593F2B4BB153D1FAA09D4CA1251CD244B8D0572854B7CB4699A674B7B92
      8C8C37D262B0A947DA78F4F95E06D463D2A6E85F41E0E7846542A4F1301C2C8F
      81B11546CDD7ED255A8F7C504C9AE576A973B0878530AB135AA4892AA04D393B
      846CBCE37CD05790532D93DA1483AA61D358B4AAF60DB2C1D5FF5467C863B4A5
      55C7FFEB76B52427EB68C28A788ED33E1CB2ACB69948DA21EDFD3366C5616928
      F624CBA7726136A3BADD8F9A11DD730CF2CAD41946FA321BB78C2F18F5CC0D48
      3DB36031A6D04470B5B9AC5A9B5694ED1C7C97754B03E66A2A6EF3D439854A45
      1127419C6788233629A0839C4AF1DFF6565CC3F763BB7FA8AEC41D2B19AFA49A
      892ECE5FE763E8E46F19EF9A9F5D81CEFE7CF8E6D42AE1CD85332571ED5A3AAB
      D775DDCEF36E974CB9D3722A44E9B62844D01FCBBC5FC99ADDAF5D3CCCF30FF3
      8993CCD9DBC059C089A1222EF0A6226606839C8FA77A98B54FE85803A5873578
      293D0B4CC0FF07DBE2806CAC23933A59CEBC2028BA56CE845475B1409C1D0365
      226EAC1DECDFD06A01AD3535BA5D3ACF073FD68B751A40095C918D93C7768744
      81F69D337166D15699D68D6A68539FF940D2D9AD1A6E1B7AD5EC2A83FC29DA49
      951D3A993FB23B8FD02FCC62086B22738AFE3A3E3BE1EAAC7DE7A58A3F5CB07B
      A4422F1F66A3CC5861DCF505FF2DA124CC22702670BBA65FD242A7C78249DC7E
      CAF9FB5C1733CB660D63C750A74A1031CCC14DA7EA820AEFA4E608BC3CD2B6FD
      0DF8F0CDA4D2C29C5ABB142196E2989DA18D3A0C53C94018210253C00724DFDE
      FA4488051F470CF5B60F251387E0078A8A92779B9C4835870459393A4D2947E3
      234E47794CC8E1266E0A296B6ED7C2545442EACB3BA39CD1CA089D583A28A8AD
      E15FF9A30353E74CF9B7D6CB58E56BEF3B477224C8D1BC67A923E36A0A4279C8
      FEA1936A710C7E8E783BA8C6AD5DAB63D7863C6F3FE619267A7E35D10682141A
      12796027130D257ADF3991991672321A67E07FB6E9F5FD98A2223CE14703AC69
      807DDD2ED19582EA817E7FE018CF35FFB10842CA07315C70CF1E4A2B29C7D412
      97C05DC8C1C6EAE92125A3A6622494865D642BCD211E08127326F186122A9B87
      42E0D22D8BF8D933CE2A9F698764F4239331239835061F4041F05FC0EA011733
      A8DF0937F3B2F3A4F5E11B182F93421649AE0B5EA1822DDA4BDD7CB24D273292
      87FFC2E2892F37275318EB6852FE1E064379CC97BBCE49BE6E7B1F6B55908EB0
      432A32CC55A1D71D093E45F967308AF8329F8AE51FE533421E27544BB089761D
      78F531CF084B42147702088B096E82C2E4568B0103CB1DAEA54A7434BF20A7C8
      9F9AABFA4F9A54D67F4C2A6B9C5AFFEB82566E6FFD44726C46B17FDBF04FC449
      465E556A172AED1D344C17AA37C17165906FDB96437483AA570B3748C55C3202
      407AAB3FCFD92A389B69356233A7B8CC0D4C265400E971A98A0F8E8A08A79787
      61641D98C27CD44A58A4F706187B57F263ACCBE46989404CEA9004B2461053D6
      8E16CD87E6676BAA8E6038E5E3289F8E9DA337876D9CEA0E21161895C7797DB4
      B32C4BC8388C5A35FC731AB6897A97F5E34B03E03C158B2AD8AA391C9834733A
      7EE21AAF75C6C187C603FFAF4EBFD3695787570E1268F6E396FD41E37CC8A6C4
      38B1ED1B6CEE125828E768B7B29FCF4E13A4BA042530BD4FE38CE43FD4FAED2D
      28F6A635C79B83B747D23980A78B5F5E9714B82BED8E9A7D8E9EEE3BEFC6B5C6
      16066B42BAAC7E96F245E9D392FDA3CDCD8FCA2EAB4B912F4917E0CE3326E8FC
      A82BDDA62BF51E75A5A6AEF475A17C8C4CFCC1C4EC924C0D730E99503B5ED3AC
      8C41E9BAFBFD566DDCF6D61BC943D6CF136D5292B5339FA57D93BE4C8E88A91A
      17C32A33DBE48DEE499DEE1533B0D148407CC09E2857E76C3695AE7B539BB643
      F838C67D3BCBA906DB402EB66A350C4C11D8AD48D0E7A5AB961AE915D42B3E81
      4E60BBCB3EB2A9DBD854F8C8A69A6CEAEB624DD47ABBD349860066752C717667
      D37C1E518A0CFB2E8FD4A7F1C59CD0B874D13243ABEC47F4AA84B927C4E883C3
      63931228A5895136610C64B64E8C43F535DBA755D9E6949ABD2DC6B40535DCD8
      BB504DCAAA86258F94ACFB2AFA27A66E1B01730E4C4608A3C263B4F44B2D1991
      412538205D835B8046BAA8973D765EB995E3058F1CAFC9F1BE2E66836116303F
      A8A700672350EFA1D7EF8FCE6CBF04E118ADDAB546CBB5A3636A9164F2280EDE
      1C7E277D8E778EB4145BF3B9258F39D8F74EBB98755DDED410FE0B86BF9B6AEE
      2762A06C708D4B4749CAFCF0EF3B41DB25C66E7934B93B722E13A4C018546947
      4A06DB38E71AC7E552468EEA9BEE95E5C4681F99C7325DAA8F763164762D9D16
      495702C1ABEDCA89E06EBF671367D77620C0749925FA4F39FAC99D816DC20BE1
      4B8E2B1721B7C01C2FDAFF2D9939C3CB59D36E94151C09AF1AF9B56BB002FCBC
      B26EF3ECFDF19B36C2F3BFE7028E67114331543EA2E20ABA957482DC91A6C452
      15B223558CBB1C3DACB5FEAE2B2BD4C0875A29CCF27631C51D539B267368D7D0
      0EC0AFAEFEA19D37F9850C8FBC8BD3298CDDE155D59DF31EC6ECDE6DCC3C4285
      ABCB31F32C52D7C96F556FBABEBFB97EC337DF55C1C9861F87CBFD4FFC983FA5
      58EAC3D5341B958D6887F97D042CEE6993DE45C3EC23398F4EE7634A449723FC
      7E9A53AC8F9AC65DDC1DA162C54261B21B2354BC78FEFCD3A74FFB630A48C236
      2C18F72137637E4E9F3CF7BBFDD0FB130029D619CEEFBFC3167EC49F78B48EBE
      68334E2428639A8F739A59EEE429013D73CF089201ACE291CEB6F38E7CB93BA4
      CA8BF87D49853B14AD7A3ED50A0F8FA80CAB540631A03DE74CFF9D7117F61CE3
      68663FF29EA367F17EBBE4F2ABF99090A327A46C7CA01271F1134D1DEB2463F3
      EBFCD105729B0BC47F7481340FF9D746AB5B884E5132AE030380DA5F81D887DC
      64918C0493B8B33FFBCC693ED2209561C273D8E767678CD1C3E6BB55B85BB5D1
      4DCC9A8F547EC219B2B5564A20D4BFFE7076DEC661738B6FE925C6079E501DE6
      137611449AC02ACA84891A98671B2772C0BE9D51CEE9DF437DA1E22BE7F4EDC1
      8971979307E41B435BA650DF7C239D7DC8F5837F4FE8DF9F8E0FDEEFB1CF0B62
      E5F5592BF3A02C76F1F2D1975E129E61D34F321F172AD5E2D59A5C554561D67E
      65481E62AF722EDB252DA955D36FCEDBBCEC3E9BA7CED1EB8337A6397DEBC62A
      4D0284375C6FB1C68D69D445920F870405840738F1541594D54BDD5C4C2AA36D
      F75CEA4B476F0EDB3553AAD37376AAC2F91DD3DC85404AA98CD82872A6430DBB
      1DD37C4892204B4D7227E980A4E6B58BB797F94354F60D497A55892E6CDFE7D0
      37AEA2766DC777585BE7F0FCF40D2B942C6345C134B58384224BA49756AAE7A3
      7A799B7AE93DAA974DF5F2EB628F1A3178526FBD69B10B88B6C53355F7236223
      B95167F1E2D193B8B0912DF024BE217620FA4CB1E7BC269E0A2B7EA22119DBB3
      5B18DC8BE6D8F69CEFA881EF7B359DE1F7572ABEAF1CD87B1AF1A98AF50BE73B
      954D31BCE32BDDC2453D140C6F3D6DD1984EB5241EB66848941AE850B398168D
      E97B6B48E5E317CEC174944F617E6835214FDBC16894EFD1717E149B2D129BC6
      2B4366C97336A57E620F8C9E524A03A9873F1C9D8A1E2E35D2D4FBC7F6EC85F8
      2C0A7521BAA320E4805FAB8F270234D1AA7D5EF03D5D33BD8AFD4725A07D4AC0
      F6D6CBF747E7DC74C526545E81FE6C8278228E353194B92E8F617161808D6742
      9459CA152C3367A8289314CA9EB35B255BC9D3D8FCA107DD8767E3FE140B181D
      B38C7BC63388587DCCF439269BE8CF7FBC5FEE9E2644EE4E4719CC95262C5A35
      2F9E52CBC65CCC986AAE6F027FD1B62197FE89920D338AC5F803BBF18EB28F18
      F52C9FB6CB87F7D065B00D1840357FF5B333B9CCC77A24EDE6417426FA218E3F
      933D55CB466CA5942D73E2B7B78A66DE178F9C42397CB67665722330E02133F9
      D8204573EB715CFA8D5C57C1B71906C28082B3B96821608694F39E521FF2B675
      7CB44115E9605B503F8F677A2C78F70C4D457094F8850014CF8EFF2ADED15D2A
      0F20202ED311DBBA79053C54510A63ACDB39D192FF48CE1FE7C5B50E5F503229
      0FBF3BB029884C7B36A352B0342ED5905A3381CAA4728EC2264764D99F80CAAE
      C8E3DEC6391DD95E0A1C023121913D395A4ADA6318C0A4C6A9E4245213216AD7
      B4DEE6B516E53CE61D3A1C1F48147F228021FA4B401D31919D760DDEC63F3897
      1A63917A172A3BAC358E6787722BBBDC4BA2EBAB6CC8FD4F719A0F4DDC697B4B
      9232090097FB72631FC4312EFB94CA2D05D452AADC947DA38DE2BEBCCEBBEF29
      0F7B26D337D7CA02EC3154949447099E878193E2DE289FB399C59DBA98AAD19E
      A07C5C7B99B152E95D7ADA3AB85DB39CB51A7D6B38B7F2FC9D097A9A31F45989
      6CF80B9E739E37EDFDFF1BE6179CB1319FE40C89DDB24E1CDB5BA2958C32C2E7
      A67A3D264B265BC8DA2733E9506C4292128DB4B57AD32ADC57D2199B9BD2A5A4
      EC5B231832F46C22587E349737724E38AEE037F0F3E8357BCE643EE368E7B81E
      0D9DE6F9CC46434505B45F6255753C9FF1D35851C0C3776D56EB3EBEDC73B01D
      3FCA6F7A163F823DDD1EC5731FA3784D53E82B37DB90FCF13349F16F1707A1A6
      141542AC04FEF5B45D63949A0E681911C3DB31B410951AD2AECD080786F017F3
      69CBE0FB4F61EF8E22F0BB495E98BE036094E4AAD094CF43FC6FA418CFB87D6A
      5255FF2D7915068B9B75BEB3CB2C9DFDE5281A1E0EB3F843BBC6FDCBC170F89B
      F3D3F44A5377DD4BE938479173839AB6FBFBE2C976F9642F8EC8BFDB90B6B7FE
      655F17937D7ECDB5477F19D3784A546E34453199B9E9400B89E59783376F7E73
      5EBD393BE7925187C624C94E4D67681B477D7CF4FAC8510C0D5E54A059A5ABB9
      65431677443DD79F8F2605240DA50C6BDF55A033CAD00E01A75B5E3AAB80675A
      39CB67C31736BC41FDBF47C43C4917730ACC23BE1478B69C614005BCAB31D716
      36FDAED52E93F19171D33CB36DE204637F4C2D4FFC392593732E39DB2026BF50
      13CA615AB2349A5ACB26CA5E1B89909FE4C9F7D04A5F9FBC3BB26E298BD64866
      E24735654890AAFF451BA7F2FECD91DB2CB1BFD6FE869935B413506BFB662031
      70E91020011EC2C9B628D9DCF629A5FE1BADEB36FA8BB503ADF73DFF44193497
      D9C41293545A60F129C3BFB5833F1BE79FAE9C4F5A315C573D353AFB5C0F651D
      4C6797A33C9F3EDAB8B7DAB8DDC1A38DDBB471BF6E47B9ACCA215F4C4221CA16
      BB92830D1C6B20EC2B13E27F24F5DB48FD11E86D81D4BF6EEF8E57D44F693E7B
      FB23133195748CD4F483694265F1CFB2D449E61358131CFA95BA1D9C828FD450
      87908F39A37B7BAB551B2B2DC7B83647EC7EEA7EC7D5143387C0434C0FA55622
      4FEF50C117F11F29282E764A9CD0CB7C3E4C6A1A9B7405E20DD233950DA5ABBB
      00A09335C591FB47A6741B537AC4625B604A5FB70DC8F656C220934E4C5E39AA
      DB5216A9DC44626C5E2B93BB34BEBCCCA535285751FD6D3E9A183402356B238C
      D135F614DBA6A8133DFD609913A536D02C8EC714D97A9F67E3764198891976C6
      6618C3B2B0212C9FFEC57CFE9EE6732CF3E1AE66941940285ECA61B4CC84BA7A
      B13B875A43D864BE12A8891E483B5E962772524ECB840DE56D34C89512A1A6D0
      0FAFEA65959A59F727279F685224C9FDC10E2F475D60D0AD9A909067367EC6C8
      7B769CD4B7D076D48BC9D2969EBB39A1DBCF2C05906FEB526D6F413BC888DBD2
      54282DEC8262CE2AA6BAAE4FD22E44CB776382E61B52A34F696DD53288C51346
      6D95B4749E9C7C706A205C49C04AF2A9F1051148EE4F927EFFC2025FEBCF58B4
      8CA0A0D570CFDA0FBC0A31EE7C044BBD4940BBFBC1FE632567533E075FB7E10F
      F9AF0AEA50A7A7B365D881313EA768E0754FE82389AF22F1EE23893749FCEBF6
      69D8DEA206E320F4174E3ACCA53FF384F42F16776A9A15D2E380E4F99072E676
      D2F93FFE71B543DD18A98FA2A28641058572E81C50C2EAC26330D9484FE501E6
      91649C523292FEFB5C0D19970642329F5F5C4AE35F9BA8685460EE166D83EF2A
      8EE753C24FC1DF4619D9F59DE86AA69F2EBE58BA49EEF30C39B989F3F108D09C
      AA7062C9DEE6AC26BEB11015DA589ED47CD38C4F062D9E02FEE4F18CDF76C63B
      FFF1959668F9595A77899875D40E53B94058025EA05BCFD4CEA916BA37E69C84
      09F7F7F777FEC485F97A0D47B7B7A8729A745E46C533A15D296FCBB803787621
      21DFD9546BB66D9FFDBBB36ACDCC922DFD5A0EB5B88FD8AEB25F823F58A0A148
      931389FBED193B596A1BA4012D75A0BBE270DA344B6ADD0FB8926F448B47CC20
      3695E049D94F969EF194B284F92F665C5C54E1C85FD2DF85BD8ACC88EC2C986B
      522A66A1D3F9D0A618B38F7184BDCCA87F1654ED3985966736AD1CA271CC8D64
      4439B74DFFE6B3F954EF39D17C7B8B2C0F8CE5936941A8869FD4554146CC479A
      9432AECBB26BE1AEDEBFD877240DFFD53BEFBDC029ED3B2FAF4C3F5EFA628C0B
      695D866A32E10BCDD29A907655D168C6BBE7D86A9191FA4066C2D464648FCBFE
      6B3015F9F16421D016D9E48DFAE3C964A657D033C42A93B6739841AD7E633171
      275A45B4510373F4F6C3FBD3C1E9DBD76FBF7D71CF994195DF036BB7BD55A753
      C549CA052F822CA55035AFA24965BF90C6C62C8B04DF9E2C34C930C7A27E1022
      96368AF2085EF979C1649415F653F276B3595736FF60D2A3BB130D733D518BFB
      39D602F478699A2D8FF8985192031F06EAADF7CE63CE6F089F006D8512E45496
      DDF78AEAB46C6FD179E1E12B4992B7002910F0387F24D9CBCCC00350F65EB3EB
      26D108BBE46941B2A145896748CEA19A122F48124EF1579F20BB771897BCB664
      F8DE2442536FA6F9847EF3BF7D2994369D0B10FB7C4C616AE5847E84D9D95763
      C37EE27CAE475DFF163DC0DBEF38C73FBF3F3E7D7D72FCF6FCE0CDA3E2DF54FC
      BF6EE7236AC24807C50855D2A7C93B45D90D525D712D26BC67347DD3B861444C
      63949B2EA10D896BBAAB13B251024E2F6210477647FE8CB9F6C830A21D3E968A
      CED715A7B8E0EA98B81054EE796C6B93263955D267547A0841A74D7AEE475D76
      C0DD3964E07BF2A21E735DD94ED9CEA75D1926DB5BB911DFEC5C1CD7F80A0E79
      1D13A294B4A3BC9859B428D3E0C3985F23ADC6353D81995BA1B5EDE65A10DA3F
      B85B3DC6595E9C6409D59AF01757F4C9F6D6B4D0C3D4D9A50C67DABBB1539574
      14A33DE7F0AC2A8BE5DC37632C591770645929CD02DAC46BCE282D511CE90BA9
      0A14666EF7C794B00B68A21526CCCF9F8D73C1FCC404E8348CB4482E7E2E2B3C
      F587D359A2F52AB499AD94EA16A2E941BE62713E683D91D5A7E7164F1BEFDEDE
      A21AA2DAEB2F33A2FEFA00F8FDE78DD19BAE2DE2E87EC697BFFFF6F448D453AD
      A643424CB6EDB35A458A5446504EC3826E66092B17D9E8DE5086EE6FC02FE717
      947CC5EE7931E34DBC38BECCB3D82663465A8A672D3C82681FAD9AC83948E587
      B1D4DB31FF33E5B2D57698A32C2AD57B8A1640113AFCEED4F9A5B3BDD5A19FAE
      FF1B91E5B1D474BD57CC1D2A35E80CF79AEFCEB87C01ABF66EC27C934B19E406
      A319E145FBCEB79978628C1E379197DA503C557E731A2B4E83AC70D5F6B2EE39
      2903279264292A23EF8B2D1EFB944F87B889FD3E595AF97C2674460431A5D6BC
      9956473268A59E18A715E68E96C85AC978F0280E5324561E58A5B96DCCFF8E3B
      CFCC8D5C66E57272823E0968497C67296117694F78DF30FB20257A3B02C1EB3C
      795D97B712CF7902439AA44B251F9D246F5BDAF5B909846E6F9911CA31A705A1
      3C9E4F85530F9CB343114614058F8DA1208B08458BD858CC51370361C0B46A2E
      4DB4F990D695AD27A1B7784839EA62E4F28B416B42A9B592E14B9508E1712D71
      5529F1680E2C3707DCC7E8D6A205F0B57B5D7C4B5E85335B47BCFBEDC9D9F953
      393A74D2B874BD64E6453EFCC88DCEA802229772656A04BCC73E3491B1ED6222
      0726506F24C2A9BE1075ADC4D9E0F457991F5B3962A428E715C503E4E6C7437D
      DBA1FE537DFD5FD3A57D5E7740197F3017958CD4DF4CD7422B51D5309B5DED71
      8F3F5533B023565F292665B22CB26249C7F04792BB89E4BAFB8F75F20B52E4EB
      3653111811E3D806D39C92114E2EE02A920A01011D8C955C56415BB57FD5F895
      E392ADD11C3B677FA921BB60A8F99A22C0EE564D80ACF8B2089632D72FF2E995
      B3F35D9640F927FBF7244F9C6F29977DC7367280B21C698357C3D2BC551362DC
      57DB4403E3B79A86032EFB963416213472405DE859CDD0A7CFC61228019929AE
      B8AC5AFBB46A8E253AD9848EA6340B79AF60BB7F3BCD5A96A47F8035E460DDCE
      7C4C6857E31DEB5E245389DD07926A61125E299C641447C6326DD564B6B7CECA
      B27C63DBED725B376E3A9171D4CB6888B0988B0FD9648F9C89A61664CFD9DF7F
      6A727AE37A849BDD2E3B67A531B9B357FEF5361F6BF171EFBC2667EFCC2947B0
      D3AAA551DCC89826369720B4247DDA32189B9F9CA769169323DED432B76A0EE2
      207C51134A3133F24FD39C228A16A20B6A4F15E8A7ADDBDEAA206BC5D0CFA674
      34C917655DCDCA12C62E270DC8BA3CE59D35AE74A3140A71F0D35AB538D01AF4
      940AB7679FB4FA50451734056AB36264A48344E86BC00AF1903E2ADDE9AD9A13
      CB8AB4DCEDEC5AC461A7ECC828BE32EED83615E7F68EB30BA22F9CBFCFC927AA
      9C48F2CC54D5A87C02A991C75AE018493378BAEF1C30002A7B99CA307482436E
      5A536154E47F33AF4B9C97573B8D0671D69154EB226C33E7AB52F569753F0143
      97B1FD56D6DB9F544C82DCB86A321952A0C960414B14DD66CAC6D9349E8F488D
      8ADBE6735CF4287235CE34FF64FD07AC5E3B05E5D370D6D2F616D7E490B7840A
      1D088C9EF3024A6FF8A7A2CAFDE7F445EB541028244EF711748C911EE5FBCE59
      5E26D09024D5AAC8D8325449D5C07BEA4479FEA15D679022035794AE79E1BC7E
      F2912B592E727691AA8838ED378F79FF375BB48F29D10B16EDD705C16E7A4589
      A549214B52CB6BC0016DD59EBDB2B11CAE3C239DE43D85AB393DE2301F27A6A8
      9FF1692143129E8C9433B5CC9C2DADD5C2D9651D54980873CF2135036D17623C
      1914D67F5E4BDBB86E398892F294B740B2E79E4BED33E7D029677FA60B9F5261
      4B5C4FCE522D03BA0551E5844C44EE3FCB3D180B13A8AD9AD4EE1A2DDD224B51
      D070A20AE3B337556C252C53BB96F2BD55DBA69C37C888DDF5AA1B5A35F1D354
      2B6330A42B7FCD0534B13B881BD5A5E6EE433718E05F92C4F7E788BEC68DBC6E
      D0E93557CDAC56CF1D0C065EDFF67BF9FDBF7EFD975F295EAEB90F65D0F1A38E
      D7F1BB7EA7D309F1FF3EC7FD3B2E98AE1E24BA9346699ACA67DDB8E3F27F3DF9
      3B887C2F4C43DDF3C380FE0DD2C0EF0D7A9D30E87941E2EA5E3F4CC258C5836E
      1CF93AF6BC4EB7838B7A7E3F8DFB9E0EDCC457DB5B833872F1F2BE1BE841DF8D
      7B7D1DF794DB8BE34EDC1F0C5CBF1BC683A41FB9AA1704184CCF8F1337F07D57
      F5DD4E370C63374E069E97F606DA8BB4D773A3A49B767A51107B83FE20563D5F
      A934757DD7C56B74D48DFC5E90A82049BD9E9F2603956C6F05617FD0EF7655B7
      EFC56157059D74D04FFD48453A8ADDBED7EBF7FA1D1F0F1BA8C055412FD221E6
      887144AE97F4F5A0D373BBE9A0A3FCC44D95D7EFB871E405BDD00DFB9D34C172
      EA38C1D0BB49DCEDEB084FE97A7DEDC503DF4B7A3AE87851B8BD1575BA49D0F7
      12AD75900EB00CBE76079D0863F0522FF4B58A7DE57B9D7EDF8BBCB833C0C2E9
      58F5D3818FB5E986981BFE8C066E2F0D5CAD7C176F51DD38090631562A1D7407
      5147F7031D06D896AE17A87EA2DD4EEA76A27EDC75632FA26C0F2C7690C66908
      01D8C50B7418A55E34D0FD01861F25613008E3284E30DFC8EDEB5EEC85818E63
      0CA39BA65D3FECA48197EA7ED74BBC38C630A25E2AB49212F5805E6EA233EC06
      D640F5F058F9B0033DA0CBBF4486D2D29E0B1A8B7B9E9B82AECCEF7D22A43454
      4459187F4FA7FD204AB08CDD5E82F5C6CCBAA02AEC44AA8241C7F7687B7A0936
      A4EBF67B69D877DD6E94802234FEF55398E7D8D68E8A22AC33965BA7694F0DBC
      24D54AF7A374A0BB035FD3EA8403A554278C3DEDFA20BC380AFBBADB0BBD04C4
      998282C18E94AF7A6ED0C170403C9D7E88F7E21D1111701C7492AEF2B04C89D7
      ED462AF0FB51E8750641D7C52EA4FD7E32F0E92A5769DF0DFDA48B1DEE242E06
      142491E787AEEBF752D51B747BDD204D7AA0BC3E0D4D63CD7032BC34E8863858
      3DAF87A9E87EAAFAF1204D413558A3381E683F8DBBB83F75631DF8D894104766
      E0FB7188AF428C407571AE52ED055E9480A6FB61A054E27775D2898208149784
      69227B73979D0DA3DE601076C3BEE1187D557212FE01E7C01BC025023795DFB7
      B7EA7FD1EF7E820768FCBF07BEE25AAE82C9C47ED2C1DEBBC455B0A7BD44757B
      BD4107DC009B11814CFD20C4A18F23A5A328C5C87C6F107795DF057FC18A0E52
      D0354EA0F6FA9ED783150C3AC69189B6B7301FFC828D8C3BBD4ED257610096A3
      FB7D22EA1EF88DEA61DFFA89F2FBDD181B1587B1C633BB38607AD0EB77B1E291
      DFC7414B527F00B2F4028C0DAC023408CA48A22049DC4E1246015855E07635F6
      2249028DF3EB8350C0EA30825ED0D37DEC269837A80C5F6222D8D08EEBF5D759
      7F5F7753BF93F498B2E9ABA8CB3BD00D57ADBFFCBEBD55FDE575ED9AEB181C25
      EDD36909BB7EA48990BCB4D34F1230B7280AB58FB745511C7707A1C6F5830833
      F563DFD7BEEAEB106720C49EF542B0329CCE1E382BE6E4D35171E32EFE9B78B8
      DC03474C52D001CE094E195E8E339C62B9221C86701078310E63D2C1BD5E3018
      80A1C7BD24810870C1EB5C9CBE6E00EEAA533C63001E9680ABA471E2F7073D95
      26712755835ED0F7B1E7583450F760D073B537C0110E148E63371A7821761613
      4CE934F6148EB00A2170BA31A8C9F3FD60D0F707444D2EB82D8693249DD44BA3
      7E3FEE85BD3EE48417C67DECF78038744785DDA4D7F17412B9E0D303BCA1132B
      0FEBE40EB07C9D7EAA076037180C88D2D5DA0B07BD6E17578458D62EE8207143
      37C1674AC541B703390A5E01AEE5F75DE25B03B08D2E1DAFC8ED8044C1B9B029
      906E1D458FC149F763B0B238EC251AD22D8CBA584D0810ED4284F83EC461BF87
      F300298E817B61083D2A84D8EDEB0ED898A7A39E0BD9D8575DB7A37BA9E7EB24
      080390928EB54B72CA751388F63E24649286AE02E31D04BD3805BF82A887D84C
      F13AD00BB1CD14EC76009EA871100749006501620E2B883B63903AB629091558
      854A694E1DCFEF2A1084825607352B52718A6333E8F53C4F410301BDA45D0592
      06210DA041E08C796E946A9756240E20B3D27E48227BE063CB237C0AB1A0E3B4
      D7C31E4270F91118B34A7B505D3A38585017301BEC04914F1C4075C129878C84
      08E9616507D050F00158A1DBEF0F3A9A04485F073D95A4FD18E75787834E6740
      FCDDC7FEC71E6E079F07516129FB41DF8574EA839C221FC228048181B443EC17
      1848DCD338FC3884FE004B0181EF42C94943A2223082A013079E569000DDFEF6
      56D7C348526C271636C2F1EAAB80F40CDA94811E780388823E1E9F063D50948B
      1507FB86EC03B7EEBBDD1E98039135CE5A37C52A61914262F8A0628CA143FBE1
      76C234D029560E3C0C4BA0230DC9D3C76EF83D88BE787BCB8B493C43F842F827
      3E8819FCAB0F3D4D0D4295061028187BAA71D8941AA42093146710AC35C5CD10
      413E34C334D638293D104B12D12D03D5EF82D1BA01C9493C3485CDD84FBB7809
      FFE5410FC23F105C101601CE020E0FE42E54511C04EC8C1B24318820C101E992
      128895EAF47B3ED61D1C18634EC099211740E750EF203BB1083E646D1C431DE8
      40A807B82C8C68A29DAEDF25AD15E40CD10A9ED9815604914C0A69826141EF4A
      C1AC4007FD18FA50DC85A2896783A98081F66330FAB01FF5A17144D86E285918
      0BD4BB3E081BC387C0ED06901249E263EDA0F6FA5009521787075C0C3CAA03D5
      7800A612C4A982121882FB9006D7D7501FFB0A0F8A5D08A62E74B1D8073FE847
      1DE8A5511FDCB90701E37614B45C17DA50EC42B2E09A10F7603B21EA31BA1873
      57818276900CC07AB0F92E74F02E8616839F76C1F7FA90944177E0915C527D08
      979EEFFA0931D13ECE2014580FF411835763128937004F2435171CC2ED2BBC0B
      0CB5470FF663174A0B04243EC541549D01B602BB0E9A0775F5B04A030F63F3A1
      BF797D909AAB888982E8C0DFA06841FD0D92BEEF291C784891A4A37125E60CA6
      E58263410385B883AA0C410DFDA09B92C100C549D3796672A7A3034D06FF07BD
      63CC1010607909B4814E0FDA69E2271867D2777132FD41AA3429263EB85310C0
      3A88202AA1C582323CE8885A11370BC1ECA0CD8151437D831A3EE874359E97FA
      1ECE0256A8AB2097236C1274477047FC0A1E0C0E97820183970520073FC0A9F4
      E9A84136E0CC241A141F8769EC296C63043AD7AE07969542DE803A306C0C1EA7
      3489C220F27036C0F2B4C68171C304472B25CB838826C508B4EEE02FE8CD60CE
      C27DC1BBC1A0758049401C4266A583147A1106D48BF1EC2E988D1BE179383BBE
      0A7BD8B30E64DE00EA3A09042885605D9D4877540FC6831776A1BD27B07C4037
      605E386D786EEA763D1C804E2F0447C2DE45E0D6A0E301C40C7617C7D6A32B71
      295811068A2786294C601C1D85B7C114C2FE254A0F427070C8DE012C3AB00F18
      5E298C9F88A4361806142E1C408847D06D1091D1D4836A3270313968A13829BD
      8E0FF90DC9944403E83E581C0F07C8EFC4A43DE13081C7424386180177822583
      130FB904260F52EC406DC0CAE3ED11283609A01311A982E582C1C0CA226B924C
      2768323D18970368725DF07C1560DE98C780245294C43134F35893D50655070A
      4F18764205F3BB436A001877404A297422C864C850300005D98EF31E7850D103
      9C4F1C48903FB4220C198A460802F4FD4E08ED3480DC81150A65BB9F60E36037
      E2D30082096C1EA21CE214670D921C8FF1028C2085150BE51857C2B2EB2B6849
      9821560A8B87E14315C082A80863A3BBC00643E8503DBC0E04095E0F49A015B6
      B30BA140D6400FA72A069BF6431C561DA6693F85BC81998BBF204F61D16075B1
      7AEEC05350C413B21B4115D08D6266C85076B0CA3013C1337DA8AA8ACEA61BD0
      E989FB38482174030F5B0579A36102616FF0950E71A6A0C8812F05BDC453C424
      61D8C1C2E911D9A8011EDB871821EDBA077D1CE4087EDB83F1DE231D03BB4016
      2D580D49409C7E1706B3C2982035BCAE8FE76AE81FEE006C3584B202010E660C
      2507C71BC61914CA3EF60A4B3C48DD5E0CE3C7875CEE760749078B4EA62EC419
      C64273D601E42C58CA2088B1505035B0DC9DB88311808BB803A8A3D8E66EE07B
      3E2C79D8D8D822EC0B74B23056A4A3C1264B70CEA1EB81D2C83A07CB4F209268
      DD7D9876B033069E075B2082BC532E480BD6099814987BD4ED4061818C0FC08A
      12EC43D4C3D1200F0596CC87D59690F6D2015B1EA4B08C02703B8C0C3C457523
      58ABD01B883F74A2D885AEE4BB11944048ABA4D783BA0CE60C9B171C075B3620
      170E692B510F0CB20BF285A4819C61CF082C12AC3F2C295884981CF612034969
      E2A427E2951020B02BC3A40FDD15D6928FABA1DFB8501AB003A10F83B61B6379
      C003A1254387E8F5C03FF04188BD877A13C34A0D40BF30C920F8B12F38E590AF
      9A86093D0E4648B7378879FE490479448E2DAC4142222E01258209C7E0E63009
      C02540B11869DCEDC0DE893A2926EE0E7AE0CD9E261390B42848B744E30043E5
      A0B3069B17CA5138801804EDE0FC41638B740033116A2B391D68B90744DA1ADC
      1BDB06DB890E0DEC9EC4A711800E30C11082013BA652EC05140AA83DD0D2C084
      B1F88344A920D5603D9EC2937B385F6457838A60E063C921151474A69056187B
      14807144E04B3D1C5198F1F80C4C06340C6AC0FC49C8802C415021D86C0C450A
      3A30EC46E83590B0B80F2A0FC412468035BCABB5D801D31A7406345AB1D223B1
      34DDDECDD662E59D816CBCD5726FFA6FD88627AD04070327DAED91BB240DC141
      2245160FE829E9F771118E0E194ADAF76018928104B3B80B5B24819948164D1F
      EA155819F8811E0CA0DC46831E74C00194331CAA448331E12C831A208D700174
      FB016C0CC8A93EB44EE88030C42101FA8364E0411444589A3E184008FEAA932E
      5498010C5EB7EF9341E6C3F4C1DB3CA8E13D1C3A1702152A38741468E57E0A1D
      09070A06A68236054BC7775DE529A8F1B0DDA204C20B86084E2D781BB9E5A0EE
      424F051587D800C87748912E861FC0A420AF0D96017A587F10823E2126617F61
      83A1AE82954065241EA5C8FD10E39841995374D2FD18164B0072028543ED919D
      6BEC3E64BB9B5069D7FA1EDF9B7EEADE6068692BFDC1B78D81BC8137F90297FD
      781DB9A6498915A5DDF6CEDBFC54CB7E7054DC9B4E45DD87B2FC24DC36AADBBC
      37CB7E2093CA516117968C6B9967E7B691DCC619968E04C7F7A6F5A9FB74EFCE
      3378A441A75A8140FE1F18AF581C7794FDEAF7ED2D0A76C4F9309F1631853C46
      06650456656A9E0C3E4D6FEA7960ADA05ED8542EAD0BCC3F1756310E704854ED
      E35B9896F46D0071EFC3EAF4FA7405EC7D9F474CFFC6F404AC2BAEEA0D88EAF1
      2CA8F5D03B154516C006C0AB7B301FC88A814ED19131E0AC78F88EEC3918003D
      1FFFEB40C34A5D725278666570E6611CA53D1E93B92F0C690DE93BDF7CEB12A7
      809DE5E2B39E8C99670945CEC329816998D2F5E1804E28CF107778F266A83598
      39CDC9876A259FF961249FF1756E799D5B5EE796D7F16778368D99E341E6198D
      4FAA6B983AE933F7DA55D79FE45DBBC6BB768D7FED1AFFDA35C1B56B826BD784
      D7AE09F99A3E569C5634927DB27FF177D88930F69B572C7C86EB400B862629C8
      3C9E15B3ABA12E7E1D164931CB46EAB3D70BE88F611E7FD049A2A9DD39BED2A3
      EC92F3ACED27F331D58C5346A9FDE4EF926E66FF9C4CB37C9ACDAEF0F760F05F
      D523A59D9B53BBA3EBD4AFEF38D5B51DE72D43897EB3F2EA41E3EA4B2D81D3EE
      37DB5BCD61CB5DD5A0BBAB07B0FC91EE37F7FC40EFBE1FE8DFFFA483FB1E6378
      DF0FECDDFFA4FBF73DC6C19D1E68EFCA70C43EDF99829B77DD8D489BF7DC8D0E
      9BF7F81BDC136C34A3BB114CF39EDE06F7DC6DD39BF70CEE38234B1D5E933C66
      798C6DFEC207DC6DC76F7880F7E593B81B35DCF080BBB1991B1E107EF924EE46
      34373CE06E1474C303D6631322189DD763023E58F368A5793E1B731B71FD79B6
      D65BD518F71940C375EF2576A8A76BDD4203C52D9B300EC37C37E7E55ED0786A
      ACB835E15AC397B6D179EAA4D9C57CAA8B3527A2C71FF5309F94106F6BBDBBBC
      79AA67F3E97AE32EE9A3CCCEDF9448AA07AC37754E16977AE2B55E3D51171BDD
      07BDF60B266CEFE623B1DE444B1251F3D925D15DA6D7DBE7918AA7F97A5499AB
      B54E87BDEF4D56AC3B3BBAC579391F0EF57AAC82EF7BBBFE36F27DEB29417CCB
      5D8560E3A6F59420BEE56E826EC9EA6D322973E7467333F76E304573E7063395
      FDDE64A6E6CE8D666AEEDD60A6E6CE60B571DA6DDAB2E7D96CB81E63391CE654
      90B5E6BCCEB28BB122C4DCB53492E6338E4CDB5A4AAEBF98AAC9A5F32A1FAF77
      885FE6C99573BEAE9650DEB5996AC33B4398CCD978BEDE5A37EEDC840ACB7BD7
      B3A89AF7DED5885F7EF77AA7EEC4B45CFAAE52CC9693F10279CDA3D9DA947CA6
      8673D109D69CE0919AADF7A68A805E31448321A32F7FC49A34F1963482EF8C9C
      5D6FCED5FBD77B6575DF7A24B878E6367EADB97D5D46FC927E599F557C774590
      46D9F8C35A77BDCA09574D27CDBB9712BEEB36697846C5D5666ECB6F6832FCE3
      D1E45215D97A0ADD511ECF1935FC444DD6BAF13DD5B2ACBF8AC7CF46D466B012
      1AEBEDDD77E7276F9CF37C423A2C6163ADB78374F34B2AA11C6D74BF3182777F
      D2D1D3F55F7C00CD797C35DA64C2071B58647CE361B6263B93BBF26483BB8E4A
      40E34DA6F8BDBE8A72354DD67FEF7B58517C38667A83BBCF1455EBAD7F1FD503
      7EC2215CDB5FC077FFA8A61999629B90DFF9DA37D62CE4621EFD4DC7EB1DD9B7
      F926C6D83B29181695E16E8EC7A5B7AE271C1AB7AE2796CE05D335237A58DB21
      DEB879BD21376EDD64C8878C237157EFEEF27BDD8DE66BEFFE9251AF670A997B
      29BC4D6D3E369AB2BD79C339DBDB379A743E9C8FC6C5A6E3E67B37A12E7BEFBA
      AA52F3EE0DB78AEF5DCF56907B09B369A3A5E21B37DB5EBE7593ADE51B375921
      BE71E3E5B96B2C62C9ADEB05AE6A37AE17BD921B371003B51B37DBCB8D85C006
      0EB7DA8D9BEC25DFB8D95EF2AD9BEC25DFB8C95E7A47A6BFF0668CAC76FB66FB
      5A7BC0664C783CD3A3493E55D3AB0D6E3F1EEA0BB5A6892F77BE9FE629611E11
      04D266FAC53C9AB172B2F1AD9B080F983B1BBD92EEDB6C83E9CE357D0A045F9E
      D7ECD11591CF8A8B6D30A173CAA75B7A5FCD288E353512D75319CA0DD6FB3525
      FB6CA2621B25B117854D13FF0D63259D5D56E194F2C2EE920B596D6F5CE52EB9
      AA5C8DF22AAF71D5894EB2F9C8BED5904279AD7FD3B576FBCBAB836557D76443
      7961B8F242B779616FD98535CDA1BCB0BFF2C285270E565EE8352EEC35F7E648
      4D3FD40DA5F2B2E6CE94FAE3B25DECB9CBAFBDB6913D6FF985D7F7F20602720E
      E2985C3FDDBB515275F9C2A6AE22AA15CFBF99BA56DC743399ADB8E9066A6BDE
      B1EA3C9FEA8F595179349647EEFD85E917B538C60DDEBE2699FD759E1B57CDF2
      9734B7F13524D8B8D0B5BBEE727056ACD20D2768E596DF709856BCE58653B5FC
      8E55C76BC5D5379FB21537DD70DC564DFDA693B762EA773882EE7A47D0BD1B57
      5F71F9DD0EE035DE7DB723E8AE7D04DDB509F8EE2260C51D7720DF6BD3BF0301
      BB6B11B0BB0901BB6B13B07B67C1B172EA7720606F3D02F6D623606F1302F636
      9120DE1A1ACB8A17DD8180BDB509D85B9B80BDB5F9EFE2DC6F23606F1302F6D6
      26606F6D02F6D6E6BFFEE2B6DF46C0FE7A04EC6F42C0FE2604ECAFCD7FAFCDFD
      0E04ECAF4DC0FEDA04ECAF4DC0FE5AFC7771DE7724607F6D02F6D726607F6D02
      0ED6E3BFC1BA3A7CB00901079B1070B03601076BF3DF6BD3BF0301076B1370B0
      3601076B1170B009FF5D9CFA5D0838589B8083B509385C8F80C3F5F86FB8B8E1
      7723E07013020ED726E0706D02BE369F3B1070B83601876B1370B81601879B10
      F0E2D4EF42C0E1DA041CAEB6C5BBCD75309ED546F6CD728BBF393F6BC39737DE
      E463E82E7BE569237D7CF98DEED277DEE5CEE622BDCCF30F6BA494964F69D2E5
      CB2C1A66397B46AEBEA4946ED1ABFBEEB0CC7DAB5FE65FF3CE52CA12FB729B26
      BAEFAEBCB0693EF9DECA0B9B4AA7EFAFBC7051EFF083959736D9A8DF3C4E4CAE
      36940386D7BC365C756D77D9D5BD55572F4CBFBFEABA85D90F565DB738F960E5
      9C02E6178DC706DD551787E5296EDEE0AEBAA1B7FC865B976DB98BE786F55BE5
      47BA612957BC63F59A2EBFE1B6A55D71D71DD678D59CEEB2DC2B2677D77577D7
      5DF73B13F02AEFC71DD6DDDD68DDDD8DD7DD5D9BC8574EEEAEEBEEADBBEEDEBA
      EB7E670EB2CA5D71D775F7365E776FE375F736A3F66BA2E2F675F7D75D777FDD
      75F737A2F66B8C7F8D75F7375E777FB3750FD6A5F645ABEA0EEB1EACBBEEC146
      EB1E6C4CED8B735A67DD83CDD63D5C77DDC375A97DD17AB8C3BA871BAD7BB8F1
      BA871B53FBB5C935D79D2DA23B2B81B5AB6F94A1B5EB6E64E1B5EB6EE420B5EB
      8C0A7823E3A85D7E3725B076C3DD94C0EBCB762725B0BE7E2B6E58BD902BB5C6
      D56B7A2725F0DAE2DE49095CBAC62BEEBCC362AF9CDC5DD7FD462570D9BADF99
      8057DC70FBAA2F2A56775DF71B95C01BD7FD4625F0C6757737A3F6457DEB0EEB
      7EA312B86CDDEFCC4156A864775CF56BAAE31AEB7EA31278E3BADFA804AE5E77
      7F5D6ABFA635DEBEEE372A81CBD67D3D16BEE2AE3556FD9AFAB8C6BADFA804AE
      5EF71B95C065EB1EAC4BEDD7B4C6DBD7FD462570E5BADFA804DEB8EEC1C6D47E
      6D72775DF71B95C065EB7EA312B86CDDC375A97D51B1BAEBBADFA804DEB8EE37
      2A8137AEFB7A185627B865FD92BDB3919ACE36AC88FD4E159733B51E18C80FE3
      A92EF221B575B303FE9DBB7A5143AF6246EDEC3A5DC6C5EC081668A7D335589E
      DB5B3EB50662F448CF7575E0F9DDA01FF4FDC48F0342D8EC86BEE06E7A216160
      2EFD09E54949274EBB5DDD51DDA8DB55BABB1A09547E3CEA758147A63A4D1919
      74158A6977E1BF0B5FD0FD6989507BFDEFF2F33FF08790D71FEECFE3EC1FEECF
      92D927E6BFFACF1DC9D7F879DCFB87FBF338FB9B7F02E81A612AFFEFF9A27AF8
      D042422D7FF7F0416F709B96B0F90FA3A207ABE57E270E5532E8F7076EDA4DA8
      91491860A47E67107A6ED0D5C1AAE7FA9DC8DBDE829EE32AA84A89DFE9AED238
      DAF2B3720536FCD9DEBACFD1FD193FF7B902FF7CB3A79FFB5A810D666F6D0FF3
      F3FBEFFF3F3565E169}
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
