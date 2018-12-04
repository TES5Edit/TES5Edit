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
      789CECBD6B77DB469628FA3D6BF93F6034F7AC48DD124380E02B3D3DE7D8B2DD
      F1193BCEB19C64E6865967814491440B04D800A847E7E6BFDFFDA82A00242180
      922C5299EA5EB148102854EDDAB5DF8FDF464936B5479E2FA6A117CDECB6D31D
      79511AD03F93E5CC76BACE6835E13BA6ED11FF9B66E97CEA8F27F38EDD6D77F9
      6B18F3D71E7F9D07A5AFE3809EC57774DA035B7D9E0A78E36094CDC542E8DFF4
      B7F55F2769FBB7D1348EB26C1CC287F60886F5036B344DE285178DA693B997A4
      2283EBCBE41FCE6FA33F8D965E14A7C26A3BF0FF5EBBD3EEB65DF8CF814FEEEF
      9F838548ADEFC5B5F5091FFFCBEF30A4A3875CC4BE48D6C7B4CB63F6619C218D
      8D63BA30E679BC4A0291E0A87FF9FDC5573062A76292CEE62401946D5830FCD7
      87C9E2A0FDDF2F6E17E338A4B9D9F97AA320BC7BA08DFFFDFE7310CD7CF82FE5
      B1DC8A69D99DDE76E8AD8DF9FB0F1F60B0F7C18F78DFD40B33EB5F7E489D8F93
      D54BF1BB5A79D53BB6EE0FEE0BEF0FEE9383B0F416E324F0AC0F5E36A74977FA
      7AC0F43A48D3BB079CD2A63834B41A300C60441ACBEDECB0D35BFE073B1DA571
      E8A572B1AEDB7C6EDB86BB10B358583FBEE3C97577D99D6DC3FD2FB53D345E08
      83FC3D4E008270201FFBD4D0F2FD71E10DF617C52D78DB3C28BCCDD90D293ADB
      91C27A1FCCE6995CCDB8387ED5017E009581FD082235FE4EA76487FDC8DFB013
      36DD733FF2B7F51EE990AA9DC847EE3FFE4EB8BD2AF2DC19F0A8D6DA63D6F91B
      7EB26A360EEEE8F6276F13452D86555BD2B32B1EFE5B22C425BDB95B7582ED9E
      53F1F0E755C28F561ECD7EBFE2D1E3EFC43811D727FCBC53F97C15B88E5F26DE
      38989CC89577AB8E933DE8558CF00A302E98F0FB2BD956AF53F5FE9F0291451E
      5C14BC865EAF8AF2AB3DB7AD021B57FBDDEB573E26377CED31BDD9BD61D5936A
      B7CB4FE63BDD6F573FE96C79526D73DFAE7C4EEE73F9B9D21EF72B6520B5C96B
      0F9737B85FC958D50E971F2FEC6EDFAD5E6E67DB9BD7B7D61E0CEE261196A264
      D6CF22CDE00D5514AD33A8270C45F984B084A59E413D61283F799BC857D61385
      D283399E7486F524A1F4A84294CEB0FE38961E54BBC54B1DD61FC7D2D31B1BE6
      DA55DCA2086666D08AEEDA55526011BEF211095AD71E563C53042D3F23A1CA64
      DA69573EE7AC3DA740EA3A76D5339AC6AA674AE7CE75AA24999CB8EA07F599A3
      073B550F1636911F2CED9FEB5409ADC5FD936FDCD8BA7E233ACA4272CE341B51
      51F590DABE7E230A2A9F2A6DE0A01105954FEA2D1C34A261F2A9020173078D28
      987C7013A483FAD3A0F4849CE0B883FA03913FA5403AA83F11FAA19CD0B8C3FA
      03A11FD3E01CD69F08FD507E24A4A0547F28F2674BA762587F2AF493C53D1CD6
      1F8AFC8D1B5B38ACE340FF6B9D05C9959674B4AA416AA5D2D22855FCA446425D
      1BC6AE9419EB64D58D75D995E263ADE45A1AA692693593624B6355B2B0A6126D
      69B44A55AB89745B1AA94AFED841D22D2AE54E8DDADF4C32A20517B56F67D098
      7F9382ADF0B434461529DA64E8720C89A5C5413A95346683C3F320451C2D0D54
      497036583E0FA430B4344825EDD990017890127E9646AAA4461B42811CA98C9D
      A5B1BA8DE5041EAB809BA571AAD8D4A6D820E7B48E9945034BE77EC46EC350D3
      B93FB92B0EE3DE9BDCAD0F744F62B7B130F781E4AE34D643C8DDFA58F727769B
      6B7C047257B4AAB90FE1A0F928F74429C517F440D576970648551AE8411C341F
      E62128B5B9BA07225569AC8772D07CA487A2D48621B5F7283C74CD5EDA6BCE41
      73DE993FDD9C77E698591CA0DF9C6FE618591AA039BF2C70CAFCF1E69C720D03
      4BA334E79225CC2B8DD19C3B96F9623E4273BEB805D38AA6EEFEBDC957699407
      71443DCCE0610A4069A8FB93AFD2300FE788F9580F56004AA33D887C95467A28
      F9820127711827D938FCCB28117E7B34835D89DAA371B812EDCD4B4EB75BBC08
      5FEFBADCFECB8BAFF0327EDF32C8DAE576F9623EC8D6CB6BAFE4216C6750BC08
      5FEFBACC23E3B72D43AC5D5EBBB76288E20B79E9F6D0913FC107FA69E8348274
      1B37FB4F180231992F915838CE08A327469E74A061EC84FE826116F24BD7520F
      2E3D78F01FA1350A83F62881FF52CF06F694864E7708FF2E5661668FAE037F92
      854B2F195D27DE129EF2E0F2C84B975EB89C7BF8215A2D804179AB2C1E79FEDF
      576996A0BC0E03C24C43FC27C8BC65DB023C1F45F13F00EBE2459C09EBB7519A
      DD86229D0B91FDF674D318255908B0984E52DB0288B4E13F049DA70257601A59
      C237B42D98320356459514024A08D875B01E4D6649E0D363D1B23042B4C431AC
      511A899B0C2695FE631A270B2F834FCB24889320BB6D5BDFE3250CDB8069A476
      194463BB4D80C27FC7B8681BBEF1DF9D4015AF32008E08C59508DB3B006EAC60
      07427225ECC623FA7D1BF42E41B2013907B44086635BC1B0BD1BFCC65E2AFC38
      6A4B50C2D45298F3A5DDDD0AD3A1854897A4816FDBEEA03BECD8D65C7818D162
      D912CECE9787B37D1F3803A4EE843342B2124B1F09BA8E826E6F57E83A12BA9D
      2F0F5DE73ED075FA7743177EFFE2D0ED28E8F677856E877901AC09C6F27C3FC8
      822B01B7A76211CC03DF17117C5945F051ACE09585416DEB3543D6FAC14BBC19
      407A6EBD8DA38C0684B567A96DC33F497CED8FB2649AA53F077E367FD5812F4B
      785168B707F263927F9C86EAF769A63F8DF5A7043F4DC64B0FC83A7C98F28731
      2C1D381CFFCD6E9702EE4AAF44928164039FC6899FA8BFA1FC3B967F13F9D79F
      85FA93BA36977FAF6A391DAC763F4CE629588C6DDF810E2FBE624E637DF6C6A1
      D0B8D42DE25215F12FAF644CF19448F3357DCFF11C9193111CFFC693CB12266E
      41EFEF1469B6CE416AD5F3EAD5CF0B5FBB655E701989D0FA7C9C1DE7E394E7D3
      AF9F8FD3DF3A1FBCBC319BCE8EB3E9A8D9909430F8320476676477EF4076F7D1
      69696157B5243028C9521BE05BA471A4E42BDEC761E53E4EDBE535ACC2D164EA
      ACED5D35B15DDF38206E09EEB47AB3D3DEEDCDB6B381C68D5FFE360EC3F85AF8
      A549A4CE17922E1F0D6D58107F7CC4D91471EE22941BD09474F3F867313ED1BB
      E954EFA6438B5CDB538C17C78BF7DED3EF3E7F786F9DC7BE26DD4EA7720AC126
      4E056B88BC297A385BCECF9B056C771AA48C3F6E097F348EA0047133B47BF0AF
      3DE838F0C7E90373C86E3ABD9E0B7FDCEE0058FE4DD71DE22D3DD7C65BFA1D0C
      D7BF1938AECB4FE32D808A7D1AA63D1CE24DB63D4479E3063469076FB33B7D97
      EE737BDDDE23A3A6DCB53B51B37D076A3A0A359D87A1A6ABF8557767ECF82111
      BCAB99F035965433F8DD1095E6E416D956697275F3297153A79ABBAFE36D690E
      7750FA65789693DA6A66BD36FCFA22EF7EC144BF6070B734B02607D41F3D67F3
      7D175912473332CEFD09D036CD3294DB7EA38FFC5D2C96A1970978A6DDB73178
      B9EDF0CFA4218DE8DF683A713AFA63A43EFF7DD286A5CB8F782CF0D394B886FC
      92661E48E520B3F3B7A53711F21790DC4594B57FE36F19E0ECE8EBB63D5A9D75
      8676C7FA9F08237EDF6A311609900ECA6C4939ACC023140BCE3A3D3C8B7DB8F8
      F7895C1C1205874E28FC41F355E3A5345CC8154C36828FB0696AF1F5EB8AB7AD
      C7A9588FEDBAE505D1051819FF7EE1253559102C5B6D9533DCBE5576BB626D0E
      92E8E2DAE802BC04FF1EC0DA6A568604BC7A6D83C1DADAF002AE0DFE1EFEDAEE
      5819FC8B27BDB836BC846BC3BFCF7A6D6E678D7CD0057805FEB5C8E3F26CD786
      D928A5B5D1057805FE6DB26B39793FBCB5F5D728095DC0B5F51F879268EAFEF4
      6BEBB96B94842EC02BF0AF5A1B3ADE2C18063F03F776DAED4EAFF3FB56D6DEED
      B9CE70E8B6DB86B31BCE6E38BBE1EC86B31BCE7EB86B339CBDC8D907FD4E7B30
      180EB6B37667D077FB7DA76B58BB61ED86B51BD66E58BB61ED86B53F13D68EF4
      73D01BB62B78FB19C6DBF76D77D86FC0DD77DFF53F0877C785DF63939F3F7727
      2AF770BC3D74EEFE20C9E57973F73B251762E67F58EEBE26B994F9FB335E5B0D
      777FDE92CB43B9FB014B2EF7E1EE4EBB3DEC75DDFE76EE8E55171D0C4171BFC4
      A63F27E6AEB6FDF1F6F8D930F7E6D608C3DC0D7337CCFDB0D76698FB7F23E6DE
      45FEDDA950DD3BDD6ECFE9BAED41012E0A0086B71BDE6E78BBE1ED86B73FA7B5
      19DEFEDF86B777ECCEA0EDF4FAC30AC57D6077874E6F681BC5DD3077C3DC0D73
      37CCDD30F7035E9B61EE25E6EE7487AEE3BAEE76E63E1C3AB68B2E79A3B81BDE
      6E78BBE1ED86B71BDE7EB86B33BCBDC4DB7BFDDEA0DDEB77B7F3F6BEDBEBF7FB
      EDAE6378BBE1ED86B71BDE6E78BBE1ED87BB36C3DB4BBCBDDF769CA1E354F0F6
      337BE0D84E67D8E90D8C55DE7077C3DD0D7737DCDD70F7C35D9BE1EE25EE3EEC
      3B6E67E05466C2D93668F6FDBED333DCDD7077C3DD0D7737DCDD70F7C35D9BE1
      EE45EEEE3A03B7DF1D0E2B7CEE67C36E6FE8F4FB5DC73077C3DC0D7337CCDD30
      77C3DC0F776D86B997983B3CE9743B4EAF2AA0AED3190E86839E71BA3FC2529E
      0D3B2F2E48ADDCB073C3CE0D3B7F8E6B33ECFCBF0F3B77DB1DD71EBA4E45F25B
      C7EE77BB4EB76B92DF8CAE6E7475C3DC0D7337CCFD80D766987B89B9777B4EAF
      0784A6C210EFF686837E7FD0318678C3DC0D7337CCDD3077C3DC0F786D86B997
      987BCFED0EFAEEA042733FC3FEC7DDCEA0670ACE1AEE6EB8BBE1EE86BB1BEE7E
      C86B33DCBDC8DDBBED6EBFDD75FB76057707D63E6CBBAE71B31BDE6E78BBE1ED
      86B71BDE7EC06B33BCBDC4DBED4EA7DDB6DD2ADE6E0F9D5E7BD06977DA467337
      DCDD7077C3DD0D7737DCFD70D766B87B99BB77DBFDDEB05D6197EF0DDADD6EBF
      6B9B8AB386B71BDE6E78BBE1ED86B71FF0DA0C6F2FF176D776061DBB5F155067
      C30D8361C7B68DE66EB8BBE1EE86BB1BEE6EB8FB01AFCD70F72277EFB5817B0F
      FAED2AEE3E74EC61A7ED98BA3586B91BE66E98BB61EE86B91FF2DA0C732F31F7
      8E63F76DB757E174EFF47B6EB7D3A9B0CAB773B8B477054A233838F05FBBB50E
      0304102C20C9C2C97C349DA4B635F2A60087304BF8C243B87CCD9A1E9DC7E312
      ED872DF11E8CFFFE3B8700B8DF2A9D87ADF21E22C043F0F33E557C70959D07AE
      727761E00BACF24E310757E93E6C95F7100B9E7095728DDD8D35B294D7789524
      0FEC26203CFD2A7B4D7712317FDB2A6B8485C35865FF61F88AB2C19AB0572F36
      3CFD2A070F5B658DF8A0C4BE3501024DFB6DB75B51B3BEDF1D747BC3A1ED6C83
      D0219B06D6B6FBC1C681C79610BF9069E0D1622E9E4CE87D3CD3402ED91FCCDA
      9ED634703FD9EE9E6B3B14D3C097A8CB780FCEFF6CCC55F7E0F7874449EE3457
      3DD83870B0541259F81A4B6B601CE80DBB4EBFDDEF54F9F55DD7756CE089CF80
      B9E3BE7F31CBFF2133F7676DAD7B30733F606BDD1767EEDA29F3F46BDB2773FF
      D2BE28C3DC0F969218E6BE03731F765DC7ED772B5AC9DA8EDBEED9C3EEB3D0DC
      0D737F8E686B98BB61EE86B91BE66E98FBA333F7BEEDD8F6A05319B3670FDA4E
      AFED0EBB03C3DD0D7737DCDD7077C3DD0F808018EE6EB87B13EEDE693BCED0A9
      EA130FF4B5EBB82001F40C7337CCDD3077C3DC0D733F00026298BB61EE4D987B
      B76D773B8E5D55C0BED319F47BBD6EDB38DD0D7337CCDD3077C3DC0F818018E6
      6E987B13E6DE1B0EBAD829BE82B9F7019DDD5ECF36CCDD3077C3DC0D7337CCFD
      10088861EE86B93761EEFDAED375FBFDDE76E63EECBA3D7BE0B8AEE1ED0F5E8A
      C97E33D96F8F8D7B26FBCDB073C3CE0D3B57EC7CD075E04760DA155EF6B6DDB7
      BBDDBE898F7FE42D36AABA51D58DAA6E5475C3DB0D6FFF62BC7D807DE0879D8A
      CC7650D37B1D776002E80C6F37BCDDF076C3DB0F828018DE6E787B03DE3E845F
      DAB6EDF4AB72DFBADD5EBBDB1D3A467337DCDD7077C3DD0D773F040262B8BBE1
      EE0DB8BBDD6EF7FA03587A659B78A7DFB5BB4350DF0D7B37ECDDB077C3DE0D7B
      3F000262D8BB61EF8DD8BBD3735DB75359966E30E876065DDB44C81BEE6EB8BB
      E1EE86BB1F040131DCDD70F746DCBDDFE9F6FB9D4E454CDD99DD759C4EDFED74
      4C90BC61EF86BD1BF66ED8FB211010C3DE0D7B6FC4DE877DBB33E80DDCEDECDD
      1DF6EC5E7F3830BABB61EE86B91BE66E98FB211010C3DC0D736FC2DC6DC775FA
      98F55665991FF6DC76A76F1AC618EE6EB8BBE1EE86BB1F040131DCDD70F746DC
      DD6DBB8ED31E54D4943FB3810EB96DD0ED8DF26ED8BB61EF86BD1BF67E0804C4
      B077C3DE9BB077C776DA9D8EDBAB6A19E3F4BA9DF6D024BC1BE66E98BB61EE86
      B91F040131CCDD30F746CC7DE80C7A76BB5FA9BBDB6E6FD8ED035734ECFDC14B
      31A5674DE9D9C7C63D537AD67074C3D10D47D71CBD03DC72D8EEF62B02E9CEEC
      7EAFDBB5075DA3AF3FF2261B7DDDE8EB465F37FABAE1EE86BB7F39EEDEED0D87
      FDBEDBAEE0EE0EB0F60128F52609CE7077C3DD0D7737DCFD100888E1EE86BB37
      E1EE6EA7DDEBB9DD416581BAF6A0D7EEB51DC3DE0D7B37ECDDB077C3DE0F8280
      18F66ED87B23F63EE8750603BB53555EDEE9763A9DBE3330A679C3DD0D7737DC
      DD70F743202086BB1BEEDE84BB77BBBD616FD0772B43E97ABD61BF6D0F5CC3DE
      0D7B37ECDDB077C3DE0F818018F66ED87B13F6DEB77B83F66038A8EAE9DEEFF5
      FAAE63BB2650DE7077C3DD0D7737DCFD100888E1EE86BB37E2EEFD361AE6DD61
      85F2EEF6FA58C1AE673AC319EE6EB8BBE1EE86BB1F020131DCDD70F766DCDD6E
      BBEED071AA1CEFB6ED0C7BAEDD3505680D7B37ECDDB077C3DE0F818018F66ED8
      7B23F63E1CF63AC3C1B02229CEEEC3A3A0BA9BA8F947588AA961636AD83C36EE
      991A3686A11B866E18BA66E883F6C07586FD7E4527F7B3AEDD71FABDBEB1C63F
      F6261B75DDA8EB465D37EABAE1EE86BB7F39EE6E3B7DB73F685759E387B6E3F6
      5CBB6F22E90C7737DCDD7077C3DD0F818018EE6EB87B23EEDEEB767A76AF3A4E
      BE3DE8B4E1B81A57BBE1EE86BB1BEE6EB8FB211010C3DD0D776FC6DD87C3AE6B
      DB15DCFDCC69B7FBEED01D9AF2F286BD1BF66ED8BB61EF0741400C7B37ECBD09
      7B1FF6DBED41B75B59A1AEE3A2F1DE04D219E66E98BB61EE86B91F040131CCDD
      30F706CCDD69771D0C946F772A98BBEDB6ED2EF07FC7E8EE86BD1BF66ED8BB61
      EF8740400C7B37ECBD117BEF0DDABD7ED7A962EFC00EBB43DBEE18EE6EB8BBE1
      EE86BB1BEE7E0804C47077C3DD9B71F7A1DDEE39B6FB3BFCFE27BA1A5F892409
      7C016384E2B7D225F9940B6F74BA1DA757FA7112AF602DA330556DE6D69EEA0D
      BBAEE3F6BBDDED4F39DB9F72B1715DDF1D38DB9FEA68D6B6F65CBFDBB6618A76
      C573EEF6B7E54904DB1FEB563CA62B016D7FACB7FDB15CB6DAFE58BFE26DBA9F
      1F52B96D0F0E2A60E90C00FEC3A1BBFDA961C5EB6CC7C5228576BF62BBDBDB9F
      1BF43BEDC16038A878AA024BF27E0715CF39553B6EB7FB9D6EBFDFE954A16567
      FB1BFBBDE1A08B085DF15815AAE8DA8E15CF55E04A7EE42A9EAB40969E6B0F86
      6DD8F5AA4DB7ABD0A503E2F1B0DDED57BDB0025BF2A09C8AE7AAF0C569B73BBD
      0A94762A90C56E3B3DD7753B95D4C1AEDC765DA6A3E2C90AC29257DEAE78AE02
      5D065D98E9A0EB563D56852EBA4B57C57315E8D2858D6B77DD7EE559772AF0C5
      7686CEA00787A2E2203915E8D2C10468A44A158F55610B90DA76A7E3F6AA5E57
      812D8060CEA063F72B76AFD3AEDAF74EBFEDC012AB8E6DA782BE749CEE10D890
      5B71183A55D8D21EF6EDCEA037A87AAE025B865823062868C5AE772AB0A5D786
      D33EE8B7DB55BBDEA9E244DAD55EF15C05B6F4810B0196F52BB0BA53812CA881
      019968576C7AA70259FA802DF6A0D3AEDAF461D5A63B405B863D98680557AFA0
      2E5DBBDB06325FC5D5DD0A5C01E46A0396752A56E756E18ACE55A878AE02577A
      2021397DE062559BEE564A2DAAB041C57395AC48B96E2A9EAB4016D76D775C1B
      8E51C563558CA80D64650072B65DF1DCA06ADB7B20C8F56DB757F5601527EA80
      2C0160712BF0AC5B812E1D38E9C08FFA159CBD5B812E20EF1045AA40976E05BA
      748141038D702B297CB7025F6CDB6DBB702206552FAC4097CEB0EFB89D41E53C
      2BB0C5EDF69C5E8FCD13DB1EAB4016E079CEC019762A70ACDB67CD231157D938
      B47EFB31BA8CE2EBE82FBF132EFC69B49C2DE93A7E1805F04F7B1464DE1227D1
      1E25F05F3A86FF3CDC497547A7F68EFA31EC8A3B78AE69E0E3A4E84367600F60
      0BE9736FD0E9D8BD3E7DEEC3D11A02E9C0CF3630F1E100B403FA02A24077D8B1
      F94B0768854D5479B1F0B2F90F0960017D7A1B4759C71D2DC6C9E5AB00944CF9
      E162053359A40B2F0CDF261EA8A10B3F4897AFC5D41E2DC20F5E32A37B13FDC9
      17D3FF3D81DFAE136FF98ED44DB20C2E82287B1F2CE043E425B7F009713A88A6
      F16F236F95CDE3C47A13C23D692692973FC24FF152245E06973FC36F7035B2DE
      44B35024F0D32411A0DE2E46B789D3B607A3450C3A977F6B8FE649075FE3E0C8
      B8BB1BB774E1962EDE42CC0C10230DE2C8A57D173EBE1CB947144F97DE4CF0E9
      812FD771E28328DF1DC81F27732F49E18877FB85EFD729B0A49ECBA346C30E6F
      DBCD2284051132D147DB9A67D9F2DB6FBE492773B1F0D2D6229824711A4FB3D6
      245E7C134FA7C1447C832FFC06455AFAB4087FFF7DB4F4001AD73608D53DFE3C
      07620F5BBD00A0870C5EF894E84F99FE34A64FB355067005E4CA92544C32344B
      5F077E7C3DC9927034CDA2F1DF479E887C3F9E8C32D8E3CB059C9AB4CD9FA771
      02D89105D1CC1EF97114676231167E7A9B4E015F00A744781B47578BB05DF835
      84BB7D2FF3E0CDC914461557800630E0951706705D0034EC513A8FAF97A13711
      F338F4D11401876416C589580437C29FC0E868AA8043702582889EBCC1B7E063
      F0014E35E0850D3B7013C2F4E25B11C1AAC4CD329D2759049757B0D8305D4E46
      7E045B10A5637F0C57C918024B5AC1BA6161E9DC03BA0118F64F5CBB3F5B1016
      C38739DD087C0E3E5F153EC3ADC18C8DDCF84BE9DB1CA766D303F8016D23301F
      2FF2475781B8BE0C22DFA64FE9C40B61B82E9CFD71E22773E1F9F2E3348EB351
      BA0C6FB3EB2888046E8DFE3CCF167050D2252C228CE699E7FF1D96355AA522CC
      C65E188DE03FB8002F19C123F086097CBBA62FF021C966C9288CE044C3CA050C
      019FAE132474A334F296593C031A19441311863050185F4F0311C2D9F561F811
      DCB85C451334F17969E0E951909C2430634D5F22710D23A6D92DFC9CC24B6649
      7C0D738EA74186138D10E0D92DC01D0933FC0E938D80CA64E9682A7072221457
      707972932EC91604F4C1873DBCC6EB02F7D49B4EE040E1ACBD29DDBC02BC0C47
      73BA0301970125F512B8339B5C7904AB0C668B0F4D1304085EB8F2B29BF1CDE8
      328996491A896C34F1E03802C28500470B312780D3B8F4320BA695B5992B5C03
      224F17D93408E120598E0B9C1C0F3F10A25522B279126719ECE92808A7F1C29B
      78D9248C56CB6E1F4F1C4CC81AE1B1F32D750081CA47E2A63DC2AD17C92DE8F5
      23DC7AF9116692DEE007807F341789A0A7F111DC2534BED16862EA018E4F6007
      E9045BC4BC22F829BC82D3B58C5693648117D03288DFD9F6875EA76534F7A219
      B2B828BBC93CABC5E44A3DECC046E3E330D97B3DDF814FC070EFF5AC0B9FC2E6
      6F3E293FDD6DFEE6B175FC7BD5303D0240E369DC35549F066AB611778D3378AC
      090D9B4C08717EEB48C07D122056A1174496C4EDD13FE0D0E4520BC8DC40B2E9
      DF319E7DA0F31EFF058E03588C4FA06820D11728CAD20B97730F3F44ABC5684A
      778FE215213C19A3DB232076AB34035A3BCFE03511D998954805037A45C10684
      A42C9CCC47D309F05BA013F0F4340549C80B616576DBE9D2C4F90676D0E2AFF8
      63A73DB0E9C354C07D20ACC6709737ED802ED71BCD83C2177FACBF7447133C95
      F45CB42C0C112D7110D892D274C66A46EEA0348FD1783475DD115E1F0158E6A3
      4B9023808B767A4004D3E2FA46287014C53A4BCD0D9E2F4D8CE60F57AD9FE75E
      F6756A0179B660DF6EDEF84166755A9DD6EFBFC1F21F797AF5B32143ECFE8162
      BD7AF3F9E5FF7CF1159E75A0D08CDA4F87D4F66E485D053104F8368801480862
      B57082E5D741EAD56A3605912C7D42483D0436F2C4BB65C030581CF75120F279
      2E2C76BF01365A8958C649267C2B48D39548AD3948ACD65880CA8260F3BF9570
      6365957C6E3915D502C2DA12D6262FA34AE4DC9506A8A62EBF5B9A6295A74DAB
      99C2CF5F8FFB2310AC7EDFB283A52895C65BB9E6FEC3671B6C6E986E477E7CFC
      31B7B8124C75DBFBE2AB7FEDD9B67566BD65716FBC9AA5161C5EEB7A0E9BDA12
      E932B5BC44585E089AA87F6BB1942FFC75BAB61B265A8787277B00BB03602706
      75314982656665B1E58B0C95D63717EFAD89B744C5C05A862BD0BB52F83586E3
      8788344187F78326FCF8F0DFA4319A497ED11DB8E3BDF57B70ACC9591C597E90
      4EE2C43F814D99245E3AB7A649BCB0BCC944A429923ECF02A06401A88CB7205A
      04F829F8273C9A087CEC14F60BF43EDF1ADFE29DA0CEE0334B006766914900A8
      245E113762B222023A85FBC278662D60FCDAB97A330124D7F27C387A96BF4A70
      A80C28B39E889705B086784A57794A68C74021C8E3F594E18B0AEEBECFEC1F0A
      678E7E792DC4F257EB3C5E0206A4D6F147698DFDFFBE0759F413EDC8C9116049
      64AD808026D6442419EA16932099AC16A0A044806916DA70C338BEB4D27821AC
      8587464238FB20D5824C0B2F051A3116120FE033EE36A836339101030E91154F
      63A0D67879821361D322A0C6E3D0EBFF1E926313B1E8ADA83FB3682F492B1580
      C710670FEE3CFEF790B61E44408E3E89148EEB87D80FA6019CE2E35771081404
      A8C90508D347D6C72591F239D01012ACE9AC3FCFE3DBD09A211D384DED07B098
      7A655939851ED382F0689ABC5A70BDFDA0BDC9B51FFEDE0758100E990BD4A151
      53825B09A5676C3FA8804D4332F21088ECD97E7007CEFFE178DA17DAE4DA2DAE
      1289EFAD716C4CA531C1FC31559AD12206750CAD182244417982C67E168C53D6
      B627F1621C8FE31BA4F278F9E572099A9D54C5DFC6C9C2F263C0D028CE404DF3
      7CBA079802DC9302599AE07279A446BC198DEF15CBFC02825C3500BFAC6275FF
      8DAB56AC167038823386399310FC2555DB167957C18CB5DF2C11029DCEA79617
      D17E4556FE189E201859281D7999C0BD802361BE9D6A64BDEFAB257AF0E9761C
      D742C83C083066ABEFDC6A6F8A26480F0F225B5CF8809D967600ED20F9E6F8D6
      7590CDD16099D66B640A173C78E9742A1234CBF0A603FB49D26627D96CEEFD36
      3785834AB06F212B8B66295B2CF4614B0486E248DA2D75A369E8CD407A48ACC0
      ECCD63EF4DBDCCBF7132790B4F35ED945C156DD3EA1C7198076D5C4AC6AE340B
      42A0B1F3F81AAD626A671F6BED6BB690035570D52C1F53C15581488FA7E00E9F
      83925707CAA64A5E25F89EB19257019B8667EB2110D9B792577D18FE704ADE17
      DAE48708E85EB4F2426B120A0F69140AD8AFBDEB68B60288B644BA909C3DB55C
      20FF89B092DA7749393C9BA3B38434BA7FAC82C925BFE200B1E701C0C38060A5
      B24E56490AB28E1F5F47D6A5B865173C808EFC86A15860603189BB160633FF59
      DE2EF5202D1E23D34D440AD8863F71ECF0738459AD1C49E22369874BF890050B
      912AFFD7248C096D98B901D620FA51F07B79910E1D9AF5A5BA8DD7AAD6D0D9BA
      860E4DB18551DD2DD4556A6FC735DC53327A08F5A66922ECE601E8CD129F30A6
      1D693A4873CF117BAA4F1C39C891CAC2D14AD10C14AE16D1C629924AA6175E7B
      B7299EA7E09F188DF14C41318D57118526F8286AA1531821710E54C4FAB3751E
      226D0520FD848BFF8E0578AD9601D8120CC9BE652028DF32022D55B6147A50AA
      08409F2673A268EC9D9EE0E8BC09AC2218F9B26EC35EAB4DA2D8100CFD90B60E
      237016054E7F034CDA679A86387134D56689F01688043E190503D47CA620A75A
      C162998054E2B7ACE3CF20675CA6D6DFBC45BD0929F92116D9BF9C187DF3E1FA
      E6C0E89BCD90FD5CFA2E62EBFF9018FCCB4B58CCAF40B77369D89004EB25A80A
      400B34D7A79829664A5A3529E925A714D0A799581AAF4089F18224B2AEE324F4
      29130EF82070412B8C610312F60349496106D4A205740804050CCC8B2C109558
      E1A53703C2AB90D925304EB434C3839D96D3B2891001F1198340714B126B0316
      9E8896DCEA06377F8E51D38679D0E4604AA7F2D89154730D1A5B72493274185A
      B3245E618C2FCC6981E168CA095230D629A95A4ADEA496B05AB6898F1224703F
      46B301A05291EB2E1CBC0642667015F82B8AA444E1D83FB5281B16800B7B9102
      65861FAE93806CF568DA47788F6F3318906232F12B672382DA49227653D0D0DC
      1630CDFA884BC69FE232697DA07F01D01088B083FE0A30A4E84C38FF745ED45A
      69A2A1AF34E485C8E6B16F1D8B9B25084501F227EDEB90D976B80D859F81B961
      EA26DEF0E3EB4FF4AB3493BFFBFCE1A465B8D0C3B950DF336CC8983D8DD9733F
      664FE7F99A3D5FFEA402F11341E41F78C178159039CF10E64720CC862E1BBA6C
      E8F27EE872E719D365DFA720850BF8913EA0D47CAE34C00F32A306BD24216A1C
      987487A66EB473AE38F4FEF807F805F496C95C80D88F4A1268422B34915F6389
      0AEB365E8148EF8B62F883CAD421F70C92AFDEBFFC8B36131D126A3D00B29252
      633ED3E78FE7B9895826A1A13687611EB9C558AACAFAB906EF96D67756C9F12D
      D7A08886629A612A539447EDDDAA183FEBE8751C7D9DC9089319AAB0AB280B42
      B939FE116F23057AA6FC59F81B33BBE6884FD0F840AD9B25DEC2A28A117FACFD
      BBB87843DC758B6D1FEB5C85DEADF513178AB2CEE3284BE2D07A174D63CBA610
      2C6518200C4768A97B6B67E4BA8689D7E79371BAD80162DCDE99917BF8CCE8E8
      9C78059E9337E4713F5236A2ABC027DF2A562563E222520C5EE65A63707E8C15
      E71194859E51161A8AC65453209E128527A32CE26CCE078D12515422500019AF
      B22CD6010259BC647104986104275A3A0FD60589632F4C63B694FB7185C4015B
      714272E85858543A20AB7704B098033B3607B262799BDBA9A9C95387BABC8E57
      38150A2678EC18967AB0C4B8E2F50A4F5F7CCD6F00E6C9932FF6C5570A99483E
      A6F0EA09086B21BBB154368B8CC40E22D04E30ACA5B193E4E7C007092FCE4570
      2A3C816795908DE43FCF027931409ED678D88B0C73698EAF8234209C4D50043D
      2131FE7ACB1BC931243D1E69162798E981C7096FA12386272165897F5F2CF419
      D17D8C29A9CF8F314127751C215D8A09E8BAA0307958BC85FDCB94B322A1466E
      43545AC5CD245CA5C195509150A1976624A6E4712AECCCF377F05F0AF566142F
      711C6F8B028C2CDD83E3128422577F5BC07BE0955203E69C2A3996F469628D1A
      1A262A29D21E8A5BB04A594418CF290B5ED70D4815130BA98B6F06EAA0DFD70B
      439C0FCCD9762D1FC3EDC842276E96C10E5E6FA009D60F1E28AD51CA6B2BAAFD
      B536028E0D6240C491B264F0AD9AEC14672F9FDC69E7D4F3F4160D6A3F903AB8
      7E8FAC0041540E6D16619C4A5248F68E775F2F00A4BC56841AAC2D4E0A660E0D
      5C0575543560C1CAF641D9B0F471A7D9A3324A6303D27A14508543CA3728B77C
      8EE358E1D64B9BEF9FB4B9498DC99A0AE18F3D8E4BC48119E35EB331A37E34C9
      20FF550F833305AA8D962534DF65F320BA0490DE32D7417E338F5721863A68B0
      156AE9C8C5E064BE1737ABF443ECA786E9D4EEC277AB994033A00CB553E10C58
      E98868D4D139963717C09CC28C307A323F32EC461FBA6021A8E8131F618B6BC1
      73FA2A016C8900A39F10477BDDF68757D605151BBBBD086E28F5A2C069305845
      9E542C3265619FC045509F06B8C2B89B63BB6DC10149D213241FDE18A372BAF8
      38FE6A4E82F1D1191FDD939B45BB876F16ADF244B05D8563257277C4759C10BF
      FF195671801BFE80F592288E42C9D15B90625E86E191CA3B61D57711FBE2D452
      019A99B58C53D692C9B318AD64D149E4000DCA1C103BD03AB5CCD5F86301F4BB
      779F3FBC01B68432F2BBD7D60F89C080D7EFDECDE602DBA8789174F4A2892609
      04B02D00FEDF3EFDF80348A8631196FDBF188B1B8AC51F0C44E7D8D801E4D70B
      6510DAE2AFC512399CCF438E40788690F2678D94CF112455006900CB57D81004
      9EFA0ECBB64A9F686A9D7BAC90A12E083A1756A488B26FE05C8140548C869E00
      31663D6871908EBC0720D34F5E42051F38C09D4C8037AF578B252F3F59459CF9
      1BA9B44CB2824862A6A2E5658CC41F0B3054A61557C165B2272017C7D329A20A
      6BF129ABF104260F4D28B7489941F7BF05582C0893C8DA29FE60B106373AD200
      0D2F328D728AF9A5146D03AACBBC182832CD2D41C5048B679C805A957389FE11
      951BF0F13F4ADEA50652B3C0BAA1AB5051756D26D2B45D427A2C4882268700C2
      11D4404C432132F5E4AEA1BBDD24D899EFBE4AC6B3C38ACA5CDCEBF1C7E914A8
      C06B381DC085D373ECE187A94B20A75065712BA124B0898E33D03169488C4955
      B8A5B3F51CC152019455C45E20CC8B47479648AEBCD06263DDB562C664CCE5FB
      E6C8B6E148A40D4E12D15F9003E3681ACC5689B4B1D8CE9CDF2699FF73046625
      8EF9403332457BC8527BFC57FC8CED1DE0BF28B662FC06C232E016E585E59E01
      5F78D87600AD75F0A3CC1A33769FDA7A945C41904F6DD17A6C0C410A44D29784
      8886D3C5A0A8092927D25A4CEE2345F4367C519B206D96044871170DD86DB64A
      D0D5017A34D1D942C0693E293D03E9323DB2E26531B2ABF635EFA698402AAB4D
      A2B7FDCA0B4274B69FC282C7522721E256761D7123019C533E0529502015C408
      D65DE6A073446132684646FB6E9CC3FA58B4662DCB6DB55B37A7F0C7C13FAD56
      EB84855B7E92DE296929CE8BCA2A32453D56BED24079CF4EB846E7AA7046A416
      F1B720FB6E454538725D15283282C4B78E61892A6E466D8F8ECF9152F7DE7223
      9F116DFA1C2C53E3E4DF1AF68590918EF0B588700BD6533784325DAB0AA5E8FF
      F72E0587E278136ACFAC7307289100AED3E1DBC9214BB3CC93D313F18F5520FD
      9520A888446547538F21BCB995DD64E446666E7F0DA48523D3648082B811E6D8
      D4829E5BB980403425DA141FA46975EFCE89DEE13B27B6E63AC80A09D8445DF9
      5DA94A8287D5C5F0ECC8B0B3F4E9D5E85BF8DFD96271E6FBD68FA948BEB56E60
      CA7EED63E2E65BEBF6DEA5D81F1093194C4973689B00F7470870EF9A00F7E681
      8E268EB13E8AB0BA78968457735904A86674156485A02D0E1001D4653D00882A
      62EFA90EB15B8B332465036DC01C395948F2E3BB403EB98D573B8502AE53E7A0
      0AB2C163D23CBDD442C458787BEF06110F20BE18E446A06EC008B1A15C8A9220
      6968D71E7557A0DDC883E28ADB15612420E974C810F14D2850CE6259F54F0FC7
      AE550AE7C348BB09884A59B2A2EE9539AA50322D9563248BB5C29CAFC934C719
      2A71A26A28C92E875B42028DE06A62904C0CD2938BF9FDC317F32B9BBCA2028E
      FB2E6348626CC82ABB1868771A85814732AB0B6E9211F1856E083A45C5A37203
      078824F70E98F8E5ED47F757EBEDF72F3F50F4CCFB8FAF503D22AFCB735C6635
      2A5C05498605DA8E7ED685FF8E54D53AE2366201CF79C92D1B56020CC615A18C
      22421469A00C45575E18F816FCBB12AA2CE12606FEFCE9FDEB729DDC3F08887F
      CEC3645487DC5836C8B58EC9B48E5F65D1BF9353EBE8FB18E5070A952B070816
      6B11609B110CD587D1C8B9259E25D408664D6A406E2976428854802B19F38EA9
      C2A48A2124A79E950680E26C1BCF6B3663AD8D85776B1D63E1478A5F0199156E
      00116E1C7AD1E5B385E61650BDA5963454CF5362122CFAC7E8400D780FA8EA2D
      FB4A035D4AB2C90A5B06E0623904953CBF312786A6B2378FC71239A71FD5BE77
      2E6EA55A107DFD2C63962AC0F609CE4CBCC0AA6E25EE4E5091ED048C8A519BE3
      2B3C78018944FF6F0CD0043434A50536C1F4D24A195002355884D63F115A5902
      0AF11840946B1EA546EF85DA0148BDF3DCEB273745BF7CFFD9FAB375B1A73CFF
      0D53F6975EEEF9E74FEF61BD6F9F7EBDD378B24A655EBFC698C686303A83D253
      3E612F47283B263E3DCE4820B64FAD3F53B2EFD9E39BC5F6761EDE76F6510522
      4F4C467E4FF9B9547A7B42D5442E85402F36A10D55985639BA935542C5AA65FF
      20901383521DA2C30A0F7D0AF815A9F12E1054A053F5EAE43877644A13E6D7CE
      8D8C09A90EA2E1C0838A77AC25A21BE1A45A3841AE0A07E53B6F315E251832F1
      41442B239528F81C21808E94075CC7A0A9C8AA32D80CBE3580271A0F7F94B1C9
      9852748436E6D0C3CE08BA85EA11364FB018F41C3668303277860381DE06C6CD
      4A9E2ADBE618A831A976B46E196188A4B30143D091D0E8AD5231E52A4E8B1251
      B8B983DD5699EFEBE19901BA509155ACC767960FCFA985FAB28AC4566FE22E6C
      A80DE08231AA0B7FBE2D6803F2CEC6F25F29D9248F1F25A336BD3945AB278EA9
      1AA593C9046BC2DCEF1DBFFCE7AF6A43E60D6A7464C80D835914531975E92EB6
      BB30199056319C96ACED01A5E279CB2570BE94423D510BA204005A4D14C7FF14
      FAE9B6A94AD0F87CDDD5000E448BFF8D097E9FE3E7428F1E28A716E055A9C214
      E0B507DD372A1B6EE546C93079E6DA72CBF85E4F75B73747A116BAB2121710EA
      C4A7D03FECD8F95C30FFCB73E2372AA0B8041F6059F535E544AAB28BCA81CA7E
      8B0391301D54CA9C9378B10CC28A90E4FA0C06E2BFC5D209DAC3A41B9AA21584
      5532C9A6E005282FA054C6A57546BF611FC0EFB117E0EFAD7CB51FE550B4ECB1
      48D5A82666BA9920A72D97E53D06F09943564A4C2A80CA8F272B7241AF1D8F26
      DEE6FCFC904459EE6157ACD8A65305AEE1C56924AE5B49363511BB0F8FD8754D
      C4AE894B337169FB894B1B1C7E5CDABF7687AE75661DBD8F275E888DB597E16A
      164447D67415B1268ED68424BE14D101EEF0834AA650A49C6E99830E2AB6944C
      64E8C2244880F3A519168AA4E6EBB0D7485C0B3D7AE2A98C9A7AAEC11B15C0F1
      A87BD137A48EE0876DC00A85AAED7157E05AAA63CE8E4B0D5F008018F2818FA1
      48FC2C7B14E9188E266E9E5298C77B0F1B00CF8A062F59A6C8BB463505F0AA85
      64239AA5D2200778D71AA7DE37ADB1E758E40ABA7AB6D59DB687BEFCF8F9EDC0
      1211283AE4E58A5148649AE45B0A16588714CD9D532F0C296E7F21D0321AA40B
      B4AEAABB58D1CB2CC63B1CF73902AA024C8998E6450B5729E6EE627DE0051CD5
      2606865B361E4762820937C91FABB488744E724D9AC2D9A2020E48AE97822A84
      CDA930BA47459FE208B48F284B6E55F5EDDCAA7F2A934FAE31411D4D91BA7AF5
      1F0B6A11E6C4C042E0F0054C6AB81A5F187A4B8C38FB46DC2C0138645EBF5D4A
      EF4081BE4B26200D82C7C1A2762E4B7E98136970345FA4932460A63A86A95DAB
      FCAF67C918FE15AB1A9F599F88B9B241275A85A154CBBCE55257B3007171AC2B
      8B19EDAC3A990EFD5BABCCEAF7AC74B544B01A3D4DC1E66F58913B6FEAA53328
      B1A6430B63D775A03AE96C18874B056FF3D20168D76901BAAE3710CEC7121157
      3DC9692435162B5839A72B2C8F82769DF5EADF5C1A8C7EA681B7742AA67B707F
      05B52D6B9E63B9811638B599884442D55A0032FEAD0C5CACB7572D63740692C7
      C28B6E9131E499879E5C26D64003006468C98A2FB130C796D5E29416ABC99CB3
      79504291A5E669792AD795520A278997CE45F315BF82A1D3601605D300847098
      E882EA786065208CAFE6589F943724A1907B2C4A1BA90602EB452378437D5840
      30BD95515CD12D99918E7E8C2E61934115A46C919401B343E1118A1A3566E95A
      78497BF402B702E76FE1EC1602152D43E4B431EA3A26ACAC00D47AB0F27DCC51
      DB3DB77F38A3D4F0A146A92F1D897986134546F2F8C53AEB79C099F5B32A36A8
      0354368A9DAAB64B80870849E67AC50ECDCC43308687B35AB0DC52E2CBCC74B6
      B0511DA416BA0BA9495F7A897594E4DBFE46550FF3F7C18B1A1C91B5C27538A9
      9466C57AB01AF73E5683273A1A4F1F4B41B8866575E008EC2198E2CC7AB75886
      A874ED6BED779EB32FB5EE161FB232BEEACA9EE8F97E8F8D9140B3CC6552AC03
      8FE216790B235FF5E97BE54D2EB10C285C794F196546E0A80F09D571804726F8
      782D25EAA81C2379A42A596A4DA8940BB5B50F6B837A9E942A711D443EEA5DE4
      70570533970285725011A2152B4EC732CC3FBCE58CD9DC2327B8A984F1BC6D11
      72ECED4EFC0372BD49879B5788B53EA41DACB73A282A7D1C4C55619C6769AC93
      31DB86082A807C607F0210A0808A936B61761529B74100FCFAF8AFB22437902C
      5F56CCA562493719F5B9F18329F1EE4C5DA53153CAF49F09F846918E444881FE
      F1FBD8943C5D65ABC404B435889C069968896E441D62C835185E17ACE900D3B7
      9873CF71BA06CB8BD12D13053FCA714BBC280D3D6E2FAD5C89C7A910D22181F7
      E49633EA995E2FE0537D5BBD3FBE888A619E99EA67BA07E1FFDF26CB6F6FE07F
      FFFEF44A0F36ABB9A62C1779DE8BCE9FB8E8C26B35830C65E73E9AF901A1F2F4
      4091F9D17B58EF2A9B0EF692428F8666364DE873C8EEB0538B6ABC57C262C3FC
      F368B0B09DAEB3871CE09686806CA412A223871CF52EF0D1599001834443137A
      1FB05F1C528F765A07A72F0525A41DED61A7DD8C76DC2F77DE30FDEAEA2619F9
      944BCC2B5401455872A75E01A51138B4C84804D5991BA9C8642884043525E473
      07100DF163744BC025C5E3556F640245A1273968442C499CA00C000C2E98DE2A
      29202DEE08081D5CE634B58E7E2479AEF4F3B7478A6F6A3F221AA355AB8D935D
      AAF727D4E8435B183040FFC777DA95AACAE69ED693736C86B1B910C9D4D0A8C1
      B92E1ECB3B58E28018800F57F620FCFC32592A89F9D73DC83FD2AA2FA1C30625
      6EA5154C0381BEAD4B4180FFB6FE70E60730BB19DA3DF8D71E741CF8E3F4DD01
      FCE9F47A2EFC71BB8336FCE9BA43BCA5E7DA784BBFE3E02D03C775F969BC054E
      799F86690F8778936D0FDB7897EDC07DF8B7D377E93EB7D7ED7DD953FF245575
      8AB8B07E722A8BD9473338CEF3BFA2E8D4F4994B58F62C8EFEDA83FF199A5BD4
      C2D2A59830E273594A92749ACAC27B91841FB94A36F1933549F8F81A1F7B7A18
      207AEEC3EF1A6087CE53B63561F575F2AB6207A81B6FB10CC50E5CAD41EDC002
      CA698073EBAFE9141B10A3664215322CD653BDFCB6006B7C26C1954A5E536280
      115C1B58ABCAADA00D152C52C18D46D945ABA98C50466B12C723A3ACC5CA3235
      57D7025CAA9E56217FFB6811F3E2AB8DC51CDF9C3CB6A0651ABAEC405FABD243
      3B263DB4A172B8C02612289CEBD41D1387BC6EC79281529CB1A4EBC6319C0074
      DCBE2ACD62EE0F1724DACC9E47ECBEFCFEE21D964FC27A0899C0B222183F9B78
      4045921375BFF499CB120ED243C58A3AF5F22E88510B6FB944157A2CB26B74DF
      EBC138F495A741AFE228D713E4F0A8E6B7AC1F54712C19AC9F22A9E5A333F77C
      EEA21E068B0097468B6C927F537B07ABDDDE6422FB642F8A30A585FA01163D26
      5BA0EEAC4D60D3ABF664B14EEEEE5EFE4D1AD829B74ADED158B6E2C5E759FC69
      00B2D92D672155BDF0946C03D8575D00D0E856297D4D74B617238BCEBB0CBD14
      6F8B7546979AE021F995F71FE2B09D7A1E5088C3DFF854AB5D6C12C27886B250
      CAF5CF64D8395943C89C1421FD382D348DC26060CC413AE5B6DC583F82EEC95D
      D611DC9B58578136E9219A624BED3C50EC9090AA018DFDE9C3CBD798EC01EBCF
      023E25989425814CBA649278B7F9E9D130C52650A04FA11D124ED9C5E56D122C
      8808861E008FEAE0DC12D01455264AAD6BD41408913AD368E7AC2FB08635E628
      D52E8F08B8F66EB9269EEC0A70B8C7BC691C4F2149B588C39BA0D4954EF6E0DE
      5239C57BA8204DEC8B4ADD7A0A938234CFF07D965BFFE2ABCFDB6206EEDEFFB5
      A3244995A4498A3BA3A424FB9161A80CB9221A4C47B4A8EBDCC7711880E4129D
      EAFCA8CE291D74F5956AB78B9997A2C1A53C559894087D4C8F5D86C124C063BB
      F0924BEE6E92624E5350EC7BB69951C4532850176A957ECA513E14EA0ED4205C
      F994467AAB30A00040EB58018D8D41AA535F098285530498F3B4EAED7E4F5103
      2E7AD7413B594B92566507A8144378BB79228D62B32EC77061E2107858E998A0
      3CAEA56C0C24B08E4910C66A0FC001AD7727526D515EB13C2688A3B6F660A739
      9B2CCFA4EEF5EDBFA9C9EF212488CDAC7B00C03E170DA82002927FF6E4E9D8A0
      9C4F12F5B31EED433950697DD43C65E24671B2203AC582FD58E4952CD64A2D06
      CD736AD7456A4ADCDA38DF9201011BC48A22ADDC7D0EFA30C9B3EBAFA7D4EB75
      EB473E2EDA2998FB6A7E475D4BA90E0AB9C6813DB27C9C3B2908087929A21DD3
      A50BB26ABD1D22AFA5C2C608786AECA55C2A882C08CA10862A17F1EAAF53CCC8
      CC941083DC8A7E93DFF7E0E8DFB3C0BB53AF6029321D233BBE787372BA96ED51
      0237EF0B0A5FB308F7D3E4806C339038876E209171042022A0BC70807B58BB82
      2926E73DE7052CE37C07DACF7101937F8AC9739EBF8FE5BB9E330681E62B5750
      7BEB735DE24C80D4153DE33D9A25425CF2FC3BCF71FEC0AFC2E059EFC0DFBDA5
      17A1B07BF66C0BF281EE712D66CF7B1B501759CD56BC11CF751120F03D739E91
      5E0BFF79AF205B25977A05EE735C41B24A537D98EDE7B802EC079893D4BF3CC7
      25CC57D1CC4BF4363C4B0916B4C87130E10598D0EEB24DE3E28DB1633CD88ED1
      7996760C7304E808289FAB5BF2C0F67BE65C3CF85CB8877F2ECC91D812EAAEAB
      B763D4DF8AAB8C6AFC4FAD407B49D8D1724C5CE4ED475706317CECF7D40DE873
      257FC994F3C9339088EA8D0196B8998865A6C856EBA4A9999E631EAE376B97A9
      58CC8DF8D3AD65EC4F2D2C199B377ECE937753D00C826C32473F5306126A9405
      0B55D443476DCAA241A504815D923ED7CA5E900B8AE373363DD314193BC102C3
      9CD64A2FA4B815CA536F5456970254C91124E352FFDB39824E757E2CC6AD4454
      F97B0F951E5A79AAE31EBCDD1C01DCDAA166C1E3AE9EFD6BFFF78D3CF47B8405
      167CF82C1DA4AAC4B46C0908470C0F7B28B8C0AD3A645822059B15EAA3BB63C8
      36E5AD67B1229B2A391DAE1C49781C59C7F0F188488216594EF0C4E6D4694AA1
      42E412AFD74DD967AEF3EC62D554A050BE7787B097C74585B3F0DB7F53CB7AFA
      C00FDCFE9FE7B8F75C493DCD90A114EB0E303B010EC0DC60A38964B8D13EE6B4
      C89B283E09A4C4C592B67826CAC911FA695D9B601FF587301CE2DF5B4114EC8B
      24EBD507BA1BCFA5B8A50390075002AE36D84F4E7ED81886E21B31B69A633F76
      8A06D822345CCF395E34488B08C0C540387195D92B46627AA13599C7C184822F
      F6944ABC9DE75252FF13C51BA312C59DD075E18E1CAEB256B38C4C95A2CF84FA
      AC7F39E94BC50BD7DE5988872D25FA14737CB6E008CA19DBA3742844975746AD
      22BC05D70BB18E6510DA6ED4E07109F23EA901B665284671DEC993BE5C6CFEBE
      79D209911D0E521B8B29E6E8B1C4749A231FD5B00182B26EAB88FC42012B444C
      6C2604A83606AE55FF6E6F4925B05BD6391E3E7DD8D43BB27912AF66F3BB4F20
      1040A4B32A3B2F65DC863910435C07675080E8DA8E068F09551097F6B0939288
      952B17AD91C152B1C363A41A28DA15A2C4D7527276D32BB7BF4685394A523B0B
      E33129CF0575F318B76E599F2419C44990F1931502D149816EEF43C29C2CF71A
      501D370C2A7EF4559FD196EF75EDDB5B846C8D317F920A43871863FE240BDF5F
      65C9CD18F33D2C1F4EC33EA83F6A943AE81C89309A5AAFD1EE8C9DDB81758E83
      1088E7E9D32B049A3C3C36589A641663693F6A3C96E4B94DBB7135E45BAAA956
      BDFC5E32A3620F17AA6520B3AE4044C79AFFB745D3EA1EB25FF66A102C599137
      8DC40CA9534EFFE60AC1632D534EF7C3DFF69D4EB037DBE9EBC49BC5D1384EA2
      2F88323B9DCA8D36185624BC4437E55065A4B9422615C8C4FA2D68400B226C07
      2B5B8F8E6369985F35A89A5AD0724C65C62F4F9FB8F6A912EDBF55015B4D0B2E
      F2E3B352EEA6AE38F22D67686EA468EE36F816F5A6FC063B7FC339E8D261184C
      767C05E5A66D0CDDEBB6DBB675FCE3E7B7678313E35C5627F467F4A81E889DF3
      69A49ADCCE898DBCB065351333A055BA953A0A84545058E6CE033134E4EB090A
      CBB6DBDFB6DBBF6E7628FBD6FA45FA2225456B5D7CFEF4EEFBBF5DFC2ACF7C53
      12624E3C9FF83DC8CE5F500C6AA8CC60F62F397DB04BFDD779512DCE8E8EB33C
      68CC1CF22F78C873C9584716549C66EB789AC4B5032EB4A7F7C4B0F9BB0FBDD4
      A5D164FC0C28C023D78C66A70905750444022C555E874BF2E4A5720CBB7F3A76
      EF6E67F705F559A48B5FB921170B6CD6F1F9A7F38EF3EDCBE1DB41E7D5DBB78D
      D5835DDEB7851095E94CEDDBB610A2479DE105B9A2414597652F0DB12B183B52
      159740ED9CE36BEDAF261768128768EEC046CF24F76B1B0587CB2EBC4B59ACEB
      6B74ECCE3DAC699A0071E0C67D588D4F7BFE49CE94453CB7170CFD78610A9DD7
      6ED96AE97B687C6729BFF51DC009A1E9B7E0B2295ADD9CC9C9A2D5F56EF6F5AA
      D68EA96ADD0C535FAD66D3E04698E6A715B6E544483F5A90A6588B16A8A7E036
      D008369396B3352DA77BE869392FBEFAD7EEA0639D594830307A8EBA4F7221C4
      BCD8257D532D99285763E1455C24310534F00F70EF6B570EEB7661DD3E10AA8C
      A363B8FA360A00146628164B8C58C57A907182ED4F09FD4FB0676783C3233060
      32A5CEBEA9955DC7DA37E3B3F9916B808340F12CD3AD096DBA003E66347E2CB0
      670DD08885A0461C1C66BB88236A6E16701F9BD04B33EE2543219958DE5C9639
      4F836CE5155B4F3F2B6000287A008A4B713B8E91DEE8C02B6AFD9CC44BDA725C
      50AA21751D2797CF74AD7D58AB2606E338C4C88A28C781E90AC90206DA0336C4
      CF97380C90383438086A7F39614595F35FCAE27F31400A6B01E61515FF001830
      44D014F11A56388F93E09F98B813220F8931AB118B3562BF085002486D1AC759
      162F16719A710F9FE7B9FA611B56EF85D99F27AB24A5568557022BEFAB4C22AA
      5D5968E39C0214C2D522C29C21F4B003528CD10060B49F9DB59F0DE5C636CA8D
      516E8C72B327E5A6F71C949B3E0AF969164C2E912E27F175890173D01D52F3C8
      BB0A6624831EE05E37604B7D14413F710B8269E871B9625CE6245E727347CA78
      04D18CF4373FF16694DC15F9C4CA97CF554EEBA338FADACBBCADABFE83AD75B8
      A171D5671FBFF80AFB012D1310C8D762A790976ED4FBA64A1367032ECB80A91B
      AB6C0A5FD1A386CD990DABADCD58D5656D4C5BBC75D85C04B388023322997929
      D2949CD6C46A179E8F9D99D867C05C79BDA34A29271F0B0761BAD66245B68644
      304907B5134EB12A21EFC751F30A0185BD03BD4D376D17114635FA18A49E6019
      F7FA9C2C996D256E2887FDC91DF2581706C9440B26B0A7DE0694744844266326
      FBF42916D3B8DFDBC7EABD344FB56A8C7A2F6561026E5F8BE0637FA3ECF0861A
      E6A9B50C85970AD531218C33EA79469D0F547C37A7A0CA0A0A9854E1A57321CD
      9A4184692F21CC6B5BB32243DA1BAAA1D8320A38B621EBB92E05E2C1510E9D23
      A0BA9315194502D522288DCB91B7A5DB019AA685F123D843DAC61ED20C637F7C
      870680853188AC5747A2B6EA2CB6622861DE577DBC0A428AA3D3A0935D32A58C
      E44DB2E08A423D64926DB156C1113D7104238FB94481240232BE862E1D079338
      52A53A306F291453D4E39208BB1DAB2426F4165D07911F5F9FA294711578745D
      4D0A29891AFCE352F1B55D92A9EE1849A64DD5BBFE10724BEC980CE7534E5C37
      A3CF70F0C652C1BB08ADE60C449E165778E076CDA5C972BA030DCF5910A940AC
      22A3560442E87B6AA178ECA35337E1E275315AEFE1AAE0C4580E4C3BA1D15FC3
      6DD6B1FA55DD2D1F2EDECC2FDC255F0DE727DB55A39DFC12F71AE59238254144
      CAED52E66E35DBB578A91E65402B3800FB9973DAA96CF527314EBE9F3AE67273
      5CF4708BCC0841CD76D0F2AED1D082EA1BB5AB8EA3691850B147D09F124354CB
      445509410833451094A0CF10B3D20981F5784C95D00853333887083F2677A9BC
      3345B247D2BC17955AB2290243FB43D5EA364E7C035BD1E31005BCB9A234A8F6
      1CAB71BEE1E74F783C7C321F49AFB954C7495DCC2BEAADD16944C9349845F052
      D44035760248B3955174EAD1F6BD9889C8DF76B48DC0B4AEB123FBA2394A5945
      1DF09F025613F5E957501DAFB22C8E64884C16CF66A1E0347F6ACD4E05292888
      59DD9FC5712889807C0815298A7FCE2B2502031D0711C7D0E0D3E76ADB48373B
      A6B3C53BC8A753FF8E8D198F374EDCC90E52D3CFB2169F28A0CD02571D2F4574
      6A5DD70E8036FA49B1DED514B4470ADF16303979B6199C8920A9EA540A8319B6
      7D98F17DC7A5257F535CE0891A444E50023348D59B0C49A8DDA4EF608A67AF7F
      78C75CCC5081AD1C1E5D50330E992CC3AB28B1CB2AB7321B1F59377047B1EEA0
      2311807E98520022A52E3760E0DC22FDDF2D80FBFF5068AF2408592113DBB15A
      B2D278B0004872AC9A6E324E8763E2B1483D0600D3ECD318DB97926A07C85B96
      9C71A2CC694B6B80B395713A85D249CC616B84546F2EDE1BE751B58182430CB5
      9902511C2186A74FA13C55D4990B4CB1B28EE1385E238B90E5745A220DAD06D2
      B02A4FCE4C375868595B968E86E3547EF9496335583D31CB8BAFB2C03CD6C970
      A4B47BD61189C947561AC6592E57537C0ABC3A48B054E5E2DDEB14B8213AB6F9
      319CD4DB37373737D81F6C225AD69B1B8F8E255510C25FB1B82516FD87C3215B
      B12F8407A2434ECB8A4598E97518C5175B4EB7631DE1061CA9893749D23E6EB7
      F1E1B7AF59FA70DBC39E5E995AFFF1DB376D79DB9BB76FDF9E284078595E1509
      83AA77AA8DA3F1021DE644ABB83C300D6E6172682235113D0F3468D1AFB2F427
      2EB6582117912B4933CB0F66013B6008DCB40D44E4BEFFF819362E116140C550
      64436C1FDD410BACC35778B517DDA2E3B239E2E02168A4C6119AA0118AB2DAA8
      3406698D5CFC92A2F6D92F07585C383DB4985B4DD8559934AC8CA9CAB2A3D599
      DD47A90C9F89AC8FE3BF0350DFBD3E55CDAFB912650E25792C194AA7C09FFE1F
      DA628DD0C024C9F887B0E1D0849C976C392C3B1D344928745D634E1444876EED
      E35C93EB3ACE1D7AE9B77BF064BE9B458025B0967DD48FA6FD219CF5F283C074
      868E065226381801CE5149F01AA194DC2369EE1E3B3E9CFD908A951F6F00F109
      40F8E2AB352022780A47AB0453264612A8DC1C059050D5E6AA01ACA4E5180791
      F2C35359C9B8769252FCF3633AF844F18B87471EE022DF30725C1D4C3F619145
      1161C2CBAB5BEBDC2375D54874DBC1532C462765106656138FBB0051596BBE44
      DE28EE1C42BF4A0E174758F045702D8831463948B715F3E8F34FE7DA91C40533
      B0402A568F98C832DA9C5ADE98BBC00258AFA11733538537F394EAA384A63041
      C6096C27344F04A8862125855134139CC708AB0D686E5B946D61E689906E3959
      D92AF32EF153FEAC03CC1DB89DBF5BE9EA62A140B634D144F556ADED134398DA
      0970D52DA44C819CD9297E9265C829C68B60D43C2826ADC711298CD7B7112899
      A279D6B2E99335FA8D48E4EF2FBEC2120C0C60A93414253E6E12C078E8C93835
      0E12CBB0B280674D413402116F9509D97F0089BDAA934A4FE762BE2765EB04F3
      00E5CE4A4C2FAD32BAD726164F8552160AFCB705FBC9B7E06E91B7308B130E71
      531D71E0CD471858AB8043F44B1CF1A9037562E5A92A0B341030B3F9467D351D
      9404C8748FF9ABFA0B1B829BAA959A8A3D4B66AF614E04977D14BEF9ABA5E2B9
      00A3FD2045944A892C4C2459D903401A34BC5130C312284F5F3FF6AF1813FAB5
      D4008BE7044815284C2945DAE1E1455A45179526BC0FA95523D805CC667FC022
      58148125B9B1623F0972C22DC1965F1CDFCEBF1DFD86A467F4FB3EC4FABF32D9
      937DAAC85F96C3C8C8C77510FC0023056728F990A5476313B52C90960090862A
      6500234A1779A62C19A5A3B51A20300138D1B0AE16B6FC15E9F62C01290BA148
      F006F6BF2F702B97E408C4DD4C73D30E7B31C800AB4B9CE77165E73FFC886E03
      A428575E10220B934A2C72FD344F18E0167AF0B2D592A781F6C88239D01CB36A
      31BAA0E2501D2C567EA8DA9A394E55C789C123F5C57AF5A20063D21FB428ECE5
      7102E552EC2415975F254DDEDA20A4C690C78F8B8F799A464A293BCF5DD41E72
      732AEA835C72333C28CB7E684C336B0720DC0450AEC827E23A09B20CBDBCB90E
      421E8674926060063B8DD9D71D51A13E76412DEAFD1794CF421523748D3E7972
      0AE6476E2B89FC457778D9ADB5E445A14AF0298DF6F9CD858BDDB53BB2BBF6F7
      3F15611060B3D824401B0FAD934E3985B3DD12234A5BD4360E06E97E7371F146
      36E876F392827298C72FCBDE40E55A862B005ADACA6E9EBE0D5B0E17EB987DA9
      DA19A77C4A4144F1E345533897726E20C3149676A229A40436EEEAE6D8DC1588
      8318D46E3EB9A68CB3A44936DE939DAC073B75582DA0EBA9D4EFB4A8F6F4D584
      45BAD84B196100C03E161BEE63B1DA14C8F66B6944CDB00513C72F21E1D5CEBC
      0FEC734A45265D526CD5C5A881806AD4164DD33BD9F94AF4F55E6536BEF006D9
      AD03A9B6D17F68B58D87A2F26FB5B0623BF19DE7F7C57AD3D81D649643430D47
      A2C6D373F31FC9F3D098503E2AE538436EF108F533DCC7984DA7D5AC76C6C729
      087A81175AAFDF9F23AD9AAB3AC492F69C1559E001A29AFB65506DF45B0364E3
      53FD7F7FFAB4377CA3DAD13F7DE2FD91251A5CEBA74F878285DD8658784E1D0E
      414B3F0F5763E574F802C8F825D6D86BB846252C60B056D10ABEF705F41B2E20
      8AA3B3AA4518C380F56EAA8C5105037D416BCBD0741BD7B7AD7EF115C53F2A5B
      2406120835AA6CD6CABA621C51B0034535C8B44DACE49F66790BD14046768668
      79BE2DB6FF62A9347F4CDFAF5E837E7D696FA67E02E9F6FD97F124CB15799F61
      72D44456C7DAE2FD6358DAA531BBD56E3C56CFF8C0FB9017CAF58137C73373CC
      4ABA91064F134FA484201D1C1D51AD9BCFCBA1D06C5CB685783AAA05E309BD04
      EBF6AADFE439F77C3AE67CE4D253EB68122F6F51456CB55A74048ED8D4172C82
      10360F4B89711EDA496E2D2CD808B5E1B07912BCF638711F7B4F5BB925899027
      F7365E7106B8583BF53CF31DF4D2FA147FD49913214BBBCAB254680FFCC811E5
      B3406BCF64F7C4289F348E74C0914E76977A3331FE9353CD3D4FF340CFE369D9
      40037791E55ABE89ACA0A53DE5A86A198FFE4322A6C1CD4E2A39A52116A25265
      F40DD0418022FADF7813224B603E0637212607C79AEBA1DEFBAB131FB2B93624
      C8CDE29824F27D6CAF1EB5F508523177E13FA6FC8934E2529CC96A16FBB24BC1
      1E7C9D510CD45C4C2E7788A07B5B3AFC6A4B999B293E29C72C27A214D25DE877
      32B5AF1F29EBB8B045BFB47E2DD6B5FFE53F7F6D9ED6F05F7074C90E2583E228
      DC444501502F6C9F637338E1A276BCB525359EC7EB788533380FB15E2880EE3C
      4BC23FBFC1028A0C150605457B96AA7A48C18282E94A718693304EF978308166
      507DFC8FC633A2066F9A8E1F9DAFD3DED3BC5181EA30C08D911435242F074FD7
      1729ED5E1E07C84E4420451E06A57FF846539D2B2FC43AB8445D9A759DD9C9F4
      D7605514D020D0FB93162BEAA7BAC980C9246C2047704904D8DDAF2F340C9135
      E4255830E41869C3F9E74FEF69377C3E03133C035F1B894C07511096CB4233F7
      84662E105131D596F5BA50337EEA85E90E2708E9487D0A2369633C6796124E79
      6A0B0035F280B9087D6E4982932D913F6612DE642296595E638399F629FEB5FE
      063C71C9BED2630C5C4FB3DB509CB063343FB2185E628A6E34281C4B59ADC877
      9563B2359B63B3049309BCEE5066B8E40DBF95DF0A763CB9BD9EA3747E2C6E10
      712D291F63B03A87F54F30468EEAE3A864473FF0A3AFEB8F521E472FDF9F675D
      35D664B0AC4784E1566A36283014D703830669765A7C8D8A26A204BB1D44BF37
      0C00556A0D27CF32C8A9AA44A0DDF028C5DDB932736CAB8DBA25D536A6965940
      1C8936A6E6EC6E51FA2468D0E4664DE1E0AE385FA99025A48B5A4E1B58126194
      3046653B58080EDCC771663105272141B0C220CBF0B0E195A2D6BD042D6607D5
      18268CED6CB8D05C46E23DF6B799C36EA48A3796B7FD34379E44B72C25F37A53
      AB509380CB0A72FD0C599E170E27C8C16296788A855A13721E44707A51EF5611
      8030B0477573F4BB9B2757E967782B384FBD89AD29C389F306D1BEA9365EC768
      3BBD0E22AC737AA29BEAA65CCD48561C96D6045995EF782C26DE4A6A4869862A
      96323F4850A748B1E35594E9782F4A94D23D60C9E47BD2C278E53903D1A38550
      6E901E83E87C1413A2802EB7C4DAD49360895A13B62153B58230479F8516362C
      C9C992A202E210A7D33740F2AC1E6949DA9376A02B959C8F741897B05ADE6717
      71B611B240848450955F22B2D1CBBDB0A4FD2906FA10A05A200DE9BC393BBC14
      34717823B35AB60CC0600A8EC5FE2980EB7178C599654B8C0B9415AA29336E0D
      061229E0CEFC24710839F227B4382D96D9ED9670D706487BADF2F696CBF096AD
      88476FC9A4455A32BE404FFFA8C5E23549CFB26888AE67BE8C83283FD8E89DC0
      73BD880943A8261F30708A956710E14040D4BF4EA5A3442E09E02293ECB43521
      071F9D090219C51EFB3E1B0B290812CE5BE1853471DE0980F58A777BCBC21A20
      EDB4F60E051CAE17E25D0AAA1742245678E9AD74B800148805ADC5E29D320513
      CACC8C161D890F94054968B28647AC5B4C1153B1ECCA0C890C8F4230C8B1046B
      94207AD3D9475ABB865A7939B3A796649CC791649CFE7649C6E93FBA678689C9
      C59A6FC6483025DB154527E755F3C8944A21C28A859FA2A47F17407570BF3C4F
      F9553A50CA9D223D8C91F69AA59B23E1214199875AEBC5538E9C5592C64EB6FF
      7C12BAE2A657A8BA97C664564446E307B23A8BB859AA5A1441E40720C9A0AEF5
      A15E90289C5DE9B209A8DC240A69CD67FD5F723E5349F20A8E081C99DCC6409C
      028C4E0F48DBD23D1AD5D6ECC2F63821995C6A1C20594C555316EAA098CC64E8
      4EADA24AA59EBF79CD09CC04D14F82188726F086FA9492E3F190DC645C0B3CDE
      521F93A8412CABE162ED29095A405BAEAB9D43F6B4A889803EB68AB4D50E4B58
      A964A3302C705B99D9715D527A36BCF9CCAF0DFE370C0B2BEA7006DD0BE82E5D
      ED58858B83D4632503166C0991B469EDC4ED28FAA789C28BFCF0B6E047757444
      5229F2696B26DEA92AD51449CF39DE77745E5E41ABD53ACACF9EAA065238E6D4
      ED00F90B0D416EC90F8574DACDD7EAD2B6B22214792FF9A56B8209BC26952A8B
      CCB2527E375956BCC1364D1A1453CC1DCC08102C0E4C390451998AA055216EDE
      3689E364B03E0A6E126941611C531D1C9977A9EB3073ADBACCC21E4A99D5D155
      7594C1E158EAC27FC6ED55B68B935625C595D52525CCAE36E8AF77F72E9F166C
      0CD41E07BDFB5E0358BFF82A94CDC836F04157622E738342A163C6068D698416
      849BAC62ABC8AC0D11339418522C01C7B61F2CCA128C57B04C6D64509095B2AB
      2A754F93A2B4703AD44A92649F7A5E94490E2C5307C742F7D226751C50B749C1
      C9C676C896F592EC02A87306589F715672956B942D9F1955C447A9B44A025E43
      637D1F62FBFEFCD5CF8817AE01D030C222A15BC72EAECE4566968035BFD20942
      AE999F1DB1BBBEF33DDB998A5160E4B72ED19E77512A92AC419F96175F7D288F
      859DD3A99C03B9C9AFA30D9206A4F89C9BACFFB8B4BE519F5F93CE7CFEE97C6D
      52542E5706E21447BA9807D3ECCF3C4D555BDBCB0AB1C02A8A87782C59AEE4CD
      D8B13DD21D3BB4618F5E1D4CAB86699179B41C1884A1449F9A8882F5944DAE59
      86BA9556FA9AAEEDE28D2C0657D3B2CA010AD2A4B9903E7F1D505D28A427897B
      785BAE5DC0010654A1BF00C394DF72CA75C4AF0369F8CF61584840E414C36B8F
      DADCCABA4CCD7D9F1EB504A5619917E71547A84FB0E9E8BD2DC77070E81DBD3F
      2E9BC8EB1CF17446BD2D14FDC2A2CC85F2FCB18A8B52813012C37484AEA6B51C
      0673E58581E6DF878434F58C8383BACFAC8FEBE299CAD690E7A4E4997B964B7D
      F1D545BC4A2602B77E5D1A5D5F2D2B44DAF7983B2BB5524505C76518352381F4
      4F91ABAE76324549B98078723BC86C0890C58B32821AE626A7AFA6BACEB09FD5
      6600E4C60CAF33E43445D8EBFC9BD3F251C32097E8F99EB4175F719D6EEBFD47
      5E3386D6C8AD2F30CF22832C96FBCF914ED6864F15866CE083328BD4575261BB
      89AE60A810B110DE4B23731EC3B7F7CAB25E03BBB363CEABB36DEAA081D7B244
      DB75EFCF13E9E1A64C3108AF2A2292689803E18D2FBE7AC9551CCED62B2B946B
      1EEBA8AF0506C4246812015AF51827EE51B7BE51F53AEB1566DDC18A91DAA221
      4B4C56A5FCA66BEDC7A7B0766A4DE5F15320A747B73A725FA7B1501EDFFAE994
      AD20BCFC01795EC77AA4267644F5B2A972556D7D992A305CF1AECFF3A2D93155
      A11E3C946E5E114434025798316A74C9EC8B0A801277B8011BE95164239306A0
      05B751579A15B55121FD707CCBB1DC1CFCC1B76A916111AF7608E17E2591AA1C
      C133E6584D2C9DDD202655A1CE2CC0B22C1EA5CAB4D6ACE6CADA4706390CDBE0
      03815E51911845681BCD1F1EBA22F4E2AB1F4AC6DFEFA5F15796EDD186106D88
      E0382A91497FC142AC5B8574A441E13739C831D6344FF3A8E09367299E119CCE
      4B317D9401D588724B494C02045D5098B2448116043065EA0E83E538A6AEADDA
      B84F82DF98A34D8B0D9ABEA75A767EF0A44D870F9C3C6FB5C56F1AD52985EE74
      9BBB4219DC0B79891B2E8B2ABB68A17D74A022405BF0E48C7D8C1487DF00574A
      A27AC18DB163EB0382840A3229CC11BD87EBE111476B1E1DB48996D21071C767
      94BDAB3C1591B8C6903AB2F2E9C1C95456EE9340D9DBE5A453E3BEA8CE4C29A3
      8B71E45742864EE15AA941527E899C92C956999D6BC71ECBE64885FE16FA6DBB
      7892532933A1A75796FD502E4E8F02757363B93E3232E9762787359704E0B2CB
      5C56349D24C138B702C411223F26E73577D67CC430E20D28CBBC0AA9DB6C0530
      DF13A4DA045A6E44B84B3ABF8CC62003999C4AED636B7395FDA7C682733AD0A7
      53E562A079EAF425815563D35207BB356392A15BD5FE129952622290361971CA
      E9455E9A078F2025C82900FA05318ECE3AA294988A989EB5CE38E58892695518
      CF2E45526493A2DA5BB97B787564B2B455E2614BCB650E724BAD126289A2AC0B
      681E85C0EAF47E95B9548ED937A7B2BE1A05FA73CDB17CF0B164BF7801F59A9E
      CC7AE6F51847B714DA911F46C596757856A40A1DE57ACA369184CDFA141FB0C7
      0CDE6774CCA89AAA0AEC3027EC3E278C0BD2525C089CA2DD0F9A3E47F5A5661E
      74D08AB18F925DE6DC70DD9250673B282629C2BD22C0A016CC32A5F0984497B4
      2AC640C24F3B9A00F8B5DB088486A79E6A21214E4DB66212387FD8CCFA702345
      5DB6870617629C76483C6623CF3C8E69666C6829E5F2716745F60EAB05507892
      B66EE8E8245594A998756FAA16D4EF01CC1DEB2E2D96882417722B8F0CF5DB5E
      EEA7025C1C4E48ADAFCEF2EC80109B705103D65F6E7E55D136AAF64F7D69C1AD
      C581BA2DEB5C06FE712E8FCF190919BD91D464F2E95BE9028E04938DC872762B
      C855BD1012F5396F0EDE9CC7D2AD75A6DD9AFEC0F90E1BA02BB2850A63E5A94E
      882F6921EAA5E4FA4428E05F39832B19EDBFE3C2B9B8AC8C5ADF5C70182C0222
      A7F5F4320F26DDB2666A6996491A96DB64AF026F0B43BC03A4617029A44FDAD0
      BADA3DF9A45B1571E9D25F54AFBA5F73493A472B43034B8A09D7E6DB06A7FC04
      1FEB6CD7BB44BB5286CC49FDC9DC6C35D5F850BFF8EA5DC6E530E26BAEAFA03C
      7E44B0B1B3F1E6E1043146B4AC77F8BE6C9544A7187ECC4DC8D17E9AEA0656DA
      EC01F3F3136F3653048A09B06EF724536EAC0926574A7309C53DD395B414F195
      C07B4A144C89B62CB3526D042AEC98D7445C2631007C013251839D541676B565
      3BA43C231B6424C85B3CDE850DEB31E40447A9B8CA8E9154A3E20EBCA2A29385
      02720851AAFC122F2D223EBAD4A5423729D8AAAC6FF4B6169B53929AACEA121B
      8AD980622AC942FE4D911DA55983804353EA4AC3822B24A9981EAC1FA33A973F
      7D5B6EAE4C2037731F558CB1420BF5D3CED6A43D9A1937F293D36B4C9CBE93C5
      3639C387E23B5E8632C747D7EB9175AA58D8424D5F65A7A714C3154C4BEF2EF8
      EB6962CDEDEF9132004CBC54AAAEC552403CBAAAE5C7BD0EB080086740A157BE
      5144B91EC94BE40C256B09D0E447A74506F71A3257CFDCA85032573291A11686
      7A1593FF26F162C1990A1199BD4054A1B2DF79792F6988997B92C7E7756164E8
      0A265694CA62D111382E140A973706546A462C96312CFD362F8F79EDB16B7215
      81E2244F3346AC63616D9F4B477104966C3F77022A6193882E2EE69629E10D13
      41308152802E08A28EB75CAADE1FFA203D39D126FC7C4D00BD0088EFA3C13D19
      DC28D8C823677B7416AB565AC7FAD35FB92F2BE7CF9F5AFABA1F4ED253EBFC3C
      3D29C56363FB260EB4DD02ED11E1DA93C3FAC557EBD0FED6C37E57A763ECD078
      3A817F974FDFFB2A87BE2E12570A442CC3B3C17E6E05398794530AF1C2C3B6EF
      937085A502D536AED9770D43A90DA3005A5652E30C57D12EED6285F16D1A2FA9
      DC54AADCCB04871F04D1D932F4261C2C1B7353DF77581D15FB9F486C4D65A6DE
      C9A9F5160E4C263B3853CE4720425F9612C43A0C3C683E1697F3A2D2D1D91C77
      4FEC5287FDA260A1DC36517E3B8BFD21E6FE597E026A2CE5BBE391A3B290CB98
      2AD3C259938959B5AF3D16649D24099A575E6CB7335FCDB01EF1B1D6D8290D84
      2B507AB328C800622768DFF40BA546CDB9AE3ED75C925DC5B720C0CD912E5A09
      B70008E4032A7A8216FA6DA7BE5CA286CC0B09CB8778604E241DC012E6A9C51D
      5840D60BB83003C908E3447897B21819975B4E39C6FF2D9B953C58AFD5802BD2
      6CD05A690E42BDC684D57365AD457302722329125CA4A7ACCDA32AA3CA0CABDA
      D80CB3A27174320FC42E1901470CFCB5DABEE7AA76F57BD08792F4A86836E7BE
      49E8B9BCF3D1941BB8714D6DBF5C89FA9749A66EC317A4BFAAA7E58FEF7C645C
      132FFC1C7F20F1FFE7467268AA063DB5F217C0A369F13BBF70A730AA4E79A914
      7F423E8820435379D146AD34580A1AF795656E7300EB585BA8394C1945F19382
      BDBB2543C7D94F50720F64C552DBFA81534BF6A620B59924FBB557502B2CD0AC
      1B5503F3957341135399AD2A35E28C0BD3B2C909F132285785C3086ADEFBE213
      40A040FB17BA1E4614FBA570F2729198E2EB59D2E27C33EC6672AB546D3906E1
      5721E2FB5A00A67E9D29BD234F852F3B00F2DAE8EA062EA1FDE2AB563D89A7D5
      52D9DAC4CB4D8FFAC016D6BD4C626C10D2B2446BD6625362A164B8BC89A25A43
      E145548F9FB3C062ACCB8D8FA2F5021DF28446B4C2A93E77549A9ADB7C480C10
      E49C58AB784663EF401AC889ED15365B6EF369950B19EF399A62558030F8273A
      BF8EBDF0BADEBAFFE2ABDB0205E3DDF36E4F5445709874AA6D4172B7E55EE5C8
      A1CAEDC5182A05E73FC7265D4C8DE182FD1C8A3B73ED15D6A5D298F24E900A95
      61900919458161AC26D92AC182E2B25DC03139CE65E976746C152AD579D27A94
      17D193EF4DC4020838BFBB89ABAD3EC2431F3F8FF186CAAFAE2214D1B3382689
      894A39AF90A22B3FBFF539D6070913E456291511F42CD05974834C1926AA93D9
      B76DBDB8A1344D565AA8682299DA8AD8439DA276C3BEA3A2684007E45C1E9023
      1C52DC60663EEE5CA1F2EC112A4F16F30DDAD1F70258F511EFEE51ED7BFFCF0A
      C5C98B222B632F2ED3CF92974145CDECC44D8E5EDD5AAFBC547C222C3992950A
      C950328E6F14CA490FB3CA122A8491B0F387BB0FB10F1AAB6AEB3B8EFF6A91BA
      C8C9FAD6F99BF7EF71EBB155C61469E244DDDABC8FA224046B13CDEB3F9E5A7F
      3EB5CE18C07FB22EC5ADCE835FD58E2DCDADD293029BC721C82FC3F0E8547FFB
      1EA899DAC077D1150AEB3A60F168B73E495C4D3B27379A474A9222A5998FB2CC
      B11F34A15F94DEA08887AA905C20415206E2120CAAFAB10C7C84D9E07993D9A9
      5EB13CA646059D7A4A29C274A34C494A851E5DBD772D3794FC41796AC5B2E480
      324AC91DDE6A90A565F40927D505D4F0C268275BA29EF57152D97EC55E4BC556
      4AB5E372AFA554A060ADBCBB63414223FA09D41BBD70971C26C9C774C1220CE6
      5805A14F6C7D6393754F20F43FE8AE4B6C73A045ED10E7A2CA84A55C10D9A7C8
      BC23FDDA23F214ABE66D40B76FD1D5A1BDCCC03E019E737684E88456159752EC
      82C2C271D10B427736A05D30AD9805270E2302949B5C021B458E8D80D156C490
      036B6027E6145704B40C6522392D2FDBB5DDCF476645DB3640A313ED12C5FA60
      266961FB0A12811EE29B55940FA7D8610E8C558A2D243635B99DA397CEE3847C
      BB3311C9E01F0E5AC557D76715AF2D55B6F84CE9905002C014CD50D92A2A94CE
      9658041483DAEA52FF2AAE4DCD719F9E852DE2F0D081A2314B48D3C058359DE2
      8A3F73701700076586944FE6C5C51BC30A1A3B608EA450893DD9D3230AF8A3F6
      ECDF51CD6E13E2A901F6830A27CCDBADA11B94453D2069E846A03EEF45801624
      3002691323051C61EB956CF6A67A67916E1593F7FFC3CB8BCF40BFC79A1AE838
      82826227E3CEE9D5E4F3F81A8F1536C52C16C24235EE54AA36245F8518684051
      81581D275E253AB56E158132C442E5311E53223CA82D08561EB19218AC35A24E
      3A27740E97225EAA9C793F46BB05313E0F9E114BA5C4C158059A0004B8C14ED4
      33DC04AD48481F38948832732869A914A6D0603398DFE732EBAD0E1D520A26DA
      29645C8CD29D0180451C5075F199C072EF40DC582C2BC0B7059CCA230B6C1EBD
      84DF7880F4EE560777A5546E7B29E19028BEB7498178550A2B5DE59632516811
      28D5B99440A115325DD35EBD2BB2FEB1026451BDD4F56A49F96DB6DEE62A695C
      8AB1D17D2055199BE209A5DE2BA752B2A322614A3BD96F1C220559F04C69A238
      BFDF7F03083C71644510E9B67A8D70E5B1215540D14A58BDFB0FD8B39F81D0BC
      5BBC8E61A3F710FFD3B27EC0C44FC1260EC66E207C3A144CF61D143292930424
      5FF57888A8C583367FF8B1758948788D23D02F0916A3848519C1A65E355A6097
      5872B2A692D292ED398D136E0A4B1E1C697193D4C9E432177C6739F721550211
      11D03955B5B036F37F51F06FEE9BBB807DC8C93D6945F51C7FCD49571CC33A26
      0685E5F33795C89323CDBEB8D59FE22E94C78658D0BC81CE3AA7DAEA3E2CDD83
      76CB4F92E792DD9AB25CE48F8F39352CDFDE29F8ECA4B94C6676005703E04CB5
      F1B849342312307A8C321B39148E640A2966521F9E5C0680D95EE9D80669D18D
      84903EAFB160D59A9B9372CA32C8916814E194E68278C801DA570129B69C2724
      8D8127F26A883179D43C9C1A39FA9478680863BD6D4215F267674241CBA3E82F
      93CEB791CB55012795EBDC9C76719AF24EAE09D2CAB48789DD936F2E3E9CC23F
      EF9987BD8F271EF92465995E1412D8A2CED174A1283B16EFA807614E4DB5DA4F
      F6CB4F626AFDF2C3FBFFFAF46D9BFE67BBBF22F5511EDABC71C2E837B46B8E7E
      6F891B61CED326108F659B0805C61365C7F6B60093CA9C1400AAABECD67B8EF3
      A4098EE628B4CB917D6D8110C24AFC49ECAB2AFF0526D5DC8F58EEF05D34E766
      8927BBB57D524AB16FBDBADDB0CAD3492FDB99CD79ACCE64537BD6F23D557B52
      4A14E6BC155DF2FAE06C8358EEC755D218858C723A43A9C683F400070D8E020E
      1D917B291F9EE29A8C84D66CDB54A2F7B9AE8D1D47DBD8B641F4B54AE5D51540
      64F72202ACB226469C4AC0A64CAC6CC53D5DD4351D3D2103F9D6EA95B72C953E
      0B2F2E8F3E8DD16687EC86F9891CB0039BC4AF3067A076477FF94924B7BF6E8B
      5832469A06F9F26534D4D647DDC5EFE9EDD8FFC09D44BD64A2F6711FD9996732
      50A950305F57AB8BF312CEA76BC1703A9F93CA23E323D62CEFECBE3D587C9207
      8B53B49A94364FA505E694BC31FBB09263DE96DC8DDA9BF7BE5D2A309C223439
      8066736BD828A93B0FA7854254183710AE66309B567693E938926299AC52E38F
      4288DAB10C390EA6D6F9E74FEF5143998BD02F574B3831A4BC59D4E92F5811EE
      578E713514FCD952F049286AEFF4A2C7A6158DD23A3471CFEBF101D5853FA1D0
      9D110AE71D29B776C049FF0F19CF340BD896BCB0597C4F46D8EBBC8F8D4EC651
      782BE37B7F8CB809317D7BCD01D6B9554066151D4957C191CE14CA23098EF29A
      4F385315238EEF6EE4C2DF9C5E6B5F88844024A0EEA1B64E1567A1400466E3A7
      D68FAF3F9D2AB7CDBBCF1F8E0072FF58518C39D969966C48EA50E867BA2E30C8
      121D3A4C821113C3E830B18A23EB1829A601BB438E5E7DBCB8F8E6FDC78F9F75
      1E00BC1DA3334BE9008D0D524C75D90FC521FEE59291F595BA9308F5A3A97574
      81CA3B22AA443DF4B48948C781509236C64BE82297DAFC057053857726F12C42
      2BF509E79F0A50BE8EDE59E8B0B7D0636FBDFB7A6191D35E6624E04B54708D4A
      3F07912941C0A059CEF0DDDACA018937FB3AFAFA3566CFC3A65CCFE39255D5D4
      5BA82A4BB551624145E9AE075A6B8DBF76D47583436933309CAC581671CE5EA6
      E3A290CA7E1C205927B210B5B6564494254701CEC6AE505FA4C9BBB21618771E
      14E2430CF62BF0BC0521E6F39B8BEE3717176FB820C847F714E3E63D12A3843F
      53EDA7F0239615B864021FB1C6ABD200805582DCA25A0B2582EA712A1B1A715E
      3DA6641B2A87B501F3A6368037ECA341631F6DE829162489E42BF3D96169630A
      4BF7C54D1EFA8AF72CA891543025E92B6B59C79F54B8FA06C363D300D638C55C
      A4E9B47582B5FEF13DE7FF41EE5F3AB5DE38A020F774BE9A82CA8CE26712AF54
      E654B1AFF05A31CEB5C9CA955CCBF6D7005C4CF8C5280B8E0C6B22E9D513A43C
      48B53485540502733632F0EC29480C14681F44986FCAF19A5181DB7FFFF2A70F
      CCE929DE2357697C107531617D864E370A77F357139DBFA1D2F0418E98620918
      184966F1A200D03C3A773BCA4EA85A6D90720203A6D5051309718978A9A2E898
      62E82BDB31DE0998328961C34032AB7D7BC63D859597B1300403A8F1323E6DE6
      41E4EE1349AC385090A2A58150B1CFBF94CF4327539D881D229CB7E711B1559D
      4A9000743E970F2CC192B6FE780CCC473B4DD70F36D963285F17FE1688466127
      98AC9CC02B9B48EE7F5F2D9679B0BB4EA5974315E28B4F2D24B55CFA9B0023CB
      FE182ED920C9219E251E961058655478495A28689393D5D2785937E37484B21B
      E29194FA9FAE1012487A23DB8FE013588F31CF9525789F162E62B6048F37BECD
      DB6AE3CDBFFCE7AFBA480088F604170CF18FC8A8AC72141A551591BB293D5BFC
      6ADDB7444E2928C650C86EC974A6F0AE8FFF818A73B69E2699EE5C8A21E27684
      30CC922A8EF92BAA6DA46A62466A3E1A254FEF983442BA80AAC525C8021B288F
      07D1CA8452378A0556A5DFB3184381CDC95F2BF75F004E3D2CF3005F3CA5401F
      7C240DC5EA94D677204CBD49558C94BC480D8DDEBD861F6798CAFA79AEE38BB1
      D8178A932770FEB26C0791E35D21A529014D48E78A851EE55086A4859230EA4D
      12100CAC14C950A19DB93934771C1A0A35C3B67299672D29309D1276CD112A87
      D81E152044A64EDD66576694310390D55C4BC5425040AED785141386D3714D55
      78AEE33C79135882349E2883F84E3233E86AA040526C2E5AF979863838E93347
      1F04D6AFA40215D280DFC2521D98CBC351EEEB53293A27809981BEC499921A42
      B2D5689EFABDE51DAA241397674EB45DA9888ABA680687BE5C35A99C45F354AC
      B6D85298EB4A29A1C481B9CB45956F6E9E85AEFA9F96962E33BD818307A19770
      AAA46C8C51644F2DD92EAD588B044859714A1ACC5C9C40EDDC9D4736A7DB5E7A
      99CADA0F9100D57C7DB10D20491690C25673D4D242870AB1C14195772ACC6767
      DA4ED842D9251E9B2B55AE6869E61A1B7C0FDEC494FFB48064854E56E4358129
      B760CF49A5D32DC48FFF6ABD21967101CC02FBB5FC289BD27951E12E3AB8A0AF
      BB7F13934B0C36CC18CD7DD584532D1518DA0E19BA5CAF2C5E0652DA2EAC5E47
      751417441B20B2794CB1C09B284439ACA491EB3AECAAD5785881DE0416CCBB0E
      64D83E260FA83B551F3E3945B9E911C5ECCF3820997D837EE9E52AEF3AD0BEC0
      E3B545242837343109C11B40AE90461964E239419C3325CA85109E2BE709FB79
      839EFB20226D0CE505A51B4488049B6AD2BE49B9E79B24F31EE485AD1DF8BAC5
      822B19D22B3748642AAB0CE16649AB16D7D09731448A4AED5035E5BD3646ACA1
      5C49E62A6C0009659825C56258BD5D6FAB9CD6A06089C881091309B0AB40E645
      19E7FC11CD5C830D57FA53B8CF45EC4A9C941FC5E42C1653B58628638D9B578C
      C62A35C05135DB0449F825ED0A7C78C56E54CF2278663FE0F45EBE6AF13D3338
      8D2AB219EFC211AE7155546665861E4C8C06C2089FE2D39CFF3D6EE0D7D97529
      92C3948159446FA42E44470AB4833BA7BE94AC1F982DC689488CA4661340DDBE
      95B7BCC6717919A7123C65C0EC6E12145E1A604DCA82657086DC228957B379E9
      E402E12BBCDF3AE6AC3E5D18E08E93CEB5C41AD0794911242D567BBB0629E563
      16D4E9F06C7C7BA66B5D10F5E692E1DC77F7E5A9CE685DBFAE38737E7D0DC77E
      46EB3CB5EB9091BE88E2EB444B236B696B8841C8BC46D9A632614E40FD3F88E4
      166189E65878790342DFC066BD2B2EDC2D1851C93ECC03552DE35096582564D4
      C12E10182C8155FB1216331403C15F8E652B123884B44312A7FF7FF6DEB5B96D
      244917FEEE08FF071CC589D7D28E2C930078F3EC256449EED669F93292BA7BF6
      6D779C280005092392E000A464F5ECFCF7F364661500529409AAD5B6B0CBD96D
      591700446565E53D9F5C14AF3BA63FD422EFD978BD24B6A755CC587AEC7ABA89
      8A2B4A68783C3B9E0D69AF692A114BB9ACC474658D3BF759350A29C0B4F40C96
      F5505E763EF01C698C935FA4A32A4DBC53DBFD6F8D5522C38BA9600BA4179A13
      BFD450C48C676D8385A733E50BBAE79296AB92D3E83F49CD318EA87974598D36
      4F6367FB9D2A100C2416C71B662C6CA309F8231F256125893D43C7A228B52A3B
      735DA19F3121CB166463539B5464B4B729DC5C49726BE2E34050495381155701
      D1290DFB4D48638E6C165EB6209ACA170856C123A23002CE11D48116DB844E58
      5D21663F4E2D3EBF306A19624F936C20F8109D93F4A83199D7546CED1AE15B34
      37E6B34492EAB6BF38977CC09CEFE654009AE9F30AE1557A6385D349EFB78928
      AEDC8F379C68E1943D0D8A70BED7C3C9AEF35E7F9EE5B031C043DF25D3EF67C1
      2E5596927DB54BAA06AA3ED3943E51177A53E7728796F721B32FE4D50ADF88F0
      8A6F927194DED86DB0F5D8FFF844E8C18451C5D4FDC490D186C4CEE2FA165656
      BBB496DF1F8B995F152F36F69C4F2F82DE271CCD7F2ED9E03879E97569177AEE
      1A3B8DB5FD2DE47581D5A79FE9DE1A7B3FA4C52C6300BAFFEBB0C0EAFE611C1E
      E725FC5E9E8C72493F91389BC3407D4A5B5AC3CA2C2401D64599A9F2673AFCE5
      F2E0D8F0DE98901BA14BB11373618292BA3233B040D9CC66630EC4ABBCA1D411
      E108D2B0D3C60635D9BF71629CBC214DCF9A42894129A4139ECD53F12A2DE1CA
      52968C6BB341A4BC323AB45134316AC2708BEC790D42DADB729D5D93E771AAD5
      F025BB0C218F37E0981E1BFFF248C1E42707D8D09610A59C23EA42A332D68449
      4A20C88D24E2F36756C3BE748E8623AE34C8F67F7C91CF69DE8A6C71FE93F034
      8D5D2848C4F0486653C60DCD7333D5ACACB04FC717294F799A11A4E61C7F5ABE
      DCD84E2BB749521106E61F9B22D260630FCDF7A1DDAC065421E137D74862C1C5
      EC0C85A589B10582D70BCC98F04451765B4622B60E1928ACFC4023DC251C6881
      99D61A9E60A3D27C22AF5532944A5CE50484204AF54D3434C406E6A58C8BB16B
      F985CCE79B52A8D4B4876ECEE5EA42432324333D4A989A55726F8E67592531C7
      864521214D11C03B0FD9552146B4F4144E5CE704D0DD867F795874C293D64DDC
      933FD524BF8A53F8CBE75F25235142234FCBC3C178BA461AF0C09CF506C9503B
      180713323A50194103A65901B9568D5C820666564DF9AA49A5C66232A4F2620E
      181BEAAC8E46D207DA0A637C32E718707F695153345567233516EB78F1056AAF
      D580C5DACE096B1790C217915CD1F77BCE5BB1014452E595ECFBB5199E96E4DC
      1A54BEBB86875AD4B6B370E02248637D14895D58FD5C2B4119D1D93899DE6E44
      570D941EEEBFC252711EC86DDA8457E68E70953EAB4F1C13D0D996E4199FA5EB
      442DA09C2FE9CCDBA9447028717609A2AD918E25C05479CFDCA2D2430F25A3D9
      C8EC2B0ECBA51A1A4020D37761FE34873161662AD5FF606B6214A38D4C13D526
      9CB42C9CB45C2C3CA170D2F36767963B5E32578586AB2CBE7D227EDD177868F5
      19B14C362F7A8C2E2C623AC52C494EB7CB4830AED530832338055B26CA2417FF
      04B9AE06CDDF263C4DCD4430A6C97458B4C56E5721BD764AE4EAF90DB0159B23
      53660A0694FE7EEE5F14C50EA60B1864418D68D2932A37D70E57E00FCC93DFF4
      1D70881A555976DB4CE3A2092E737D123DB2C13B734E925BB6A610A6D38260F9
      12240D4B0BAECE9199982CFECB3064310B13040FA103C6737BC01F23A2B4A8FA
      99FB0481EEE1F2C44AEB47A3684B943D1B5101D04BAA0809927191742F88CE5D
      907236409F5AE0297FF0261DDBBAD6294D64B11F54394B3CDF551B2427E808CD
      DE76E585CA5E7CF639166F9DD811A8F7CB00628B4996B27D9D0AE8467E99CDC6
      574E9E3E4A894231C8D5BE18D1A73267E74BCB7A0C3EDE18EBF7A77B680FC669
      D9754C47448F265368C8F46663B9CF3BDF2BA8B5E886EB314F8A7D6547C656A7
      F42D195304765FF91A3777B0C96BF611722BC6C6885E6644BB4FDF88869A18C9
      207635E64846396352F0BBC1623C4992E0B9A8F104DC68DBE32C3E285B8430F3
      A633AE5B7EA3C7C9C5B8FC6B4A9D21149C26E97A9944911E37D20E6062B1895F
      809CDD4B2C5B892BD3DD2EE9745BEAEDEC560E36D344EE15CAD8CED9E652C856
      D99F15B390CB590A3539E81D8E55427820041156958A5F60A58D2ABEBFD54074
      07856D35B8532C1C064B669CE639CBA6A832DFA05FAF1C536274F2D6E13C557F
      2AA8BA0C169BD0005717028AB2378831C12D47FE47B90E2BC38F64B4897368C6
      228A10E9B4D62BC536786FE204F08B73843AE66404E301702681117497308974
      D1DD5DE4B6DEBBD8A3F7BE4C87454B20DC951C07783691ECC2CD9886BBEFC868
      4710B098AC2B594163BAC83BD962F02278A346E9ACD6C84A7E4E32AA9F0B39D3
      5353034F07A665130D42A1723C275757A415289AF9498D4C85A41890C02BA092
      9FA2CD4C68C98D504CCA8D18AB29C678EAF2900C0C455F39A28B67E1006A3304
      6BD3EB7D8F9C5A41B6FB448B405665B3FA67A8E218EC3AB3716EEAB1E9E37223
      1BA0F965B465BE53E4F8F9CDD6CA25E07AAECBE1DAEFA99D34F8BF6A3F20974E
      5945E063BB055435B75E4C0C60A83DB06CB1B89CF2C812CA9C0CD394F2B50698
      25296182EF67BB92B5A69F07ED2EBEB6FB9E8B7FDC9EDFC73F5EB7EBE31FBFD3
      6FE19F8E3FA04BBA7E9B2EE9792E5DD2777D5FEEA64BC0BF3D7E4C6B30A08BDA
      ED418BAE6ABBB88EFEF57A3E5FE7773BDD3F969FB1FA3F1EC876DF71DEE0FF57
      5EE72C72C07D17E269078EB35FF7F2838D6829E2056CC11727D09EF6EAD0663A
      219BF3F155CFC71A7C4FFF5FF772F95FFD63E26C4ECA3C5CA2E83E8EA4279940
      3A6C5B44B13280EEFC9B331F40E7A3C469F2AF8E19BE2D5A7BE75EB070ACFC0F
      8A4A917FF0F5D76BAC8FFB17FCC7A1A39B5618939014B38C2ACEC46E62BCC939
      CB68E3247C2159570C1060D7F17C13BBB8033C513AD6AB5BA955B02B78FD7753
      82992E474806CAB42D9B010EE99AD539C73488B98A77609E13DC3AEF0DFECD2B
      DA526ADF5FABACD13CA72CCFB8D27A62078C51F6D06025186426BAD8B8EB8241
      30D78122D29BA29B1432510277C353854C175B96A6F52B11CF2D0929F25E84E8
      E8FD560B0C8EA75C26C308AFB2EB10D5E0F7E402A020EFF7222F7E4D31105931
      4FEBAE009CAF835D779E9A8014A813CEF2B22AF54ADFCACCBC59BEC9032DCD03
      794F3D0F4433F5DE93A2F90F667D7BEACCE1A14110C5F887A7B4B3ABD7351DFE
      E927BB24161EF36B6ADE8A8E0864B54E620FA284709B5F179BF9F2DFAD14C577
      0539F0FD4F4BC652348A260712583E4C6FC6AF257E6DD77CCFC6939C5DB6EA8D
      5D75BF82B678E821E942D1000CA56A70DAE6C859C3D5FF9F626D0932E23B32A0
      7E9CBC221675B6A93463C77965D0DE85798B3F5A6DBA233ADAA85A2E71CA4C8F
      C16AB0C3294C92423F0BA49C09F3D60FAEF28BEF4751F9BEC7E35C67D32FBC62
      40BD1F2A2CB1FDC5AFB11FBDBCC9ACD2656603D56FF991637DC3D56F9547E496
      D5B69CED68213A5D1F7A4D9616D1949E550BA08B563E6F7297BC1B49B2AA8B23
      A72E1A8A195241803354811EE67704C9468E547D990AA1B64B20591B2B4AAA7E
      DDDC106659DAFCD40D5BF728285F4521A91DADC267E2F7A07A65C49784FB47B8
      5E95A2D9C5B0F1B872B6E565A6B7AB4F9C41FE24152F0D5779D1AB62E73FE729
      E97FEE8ADF9CCDDA67531C3C1AA89BCEB250BAE879907C984C19C49FB1542D9A
      A01919B0F5CB219CD65F658A3A18C8E6C85E51F29130873600DC77B2A3A6895B
      20971709B83D4741A1F64E414902C1C94ADCB745E05A4A8416ED8875001E2500
      225D558A8178A46D91E72D9B74AD720E8E4E4E6C69B5727E3E3D39E4C0A4737A
      F4F6B4FC3D5DB56367B76982C456D9ED5CA005E7D1B20F1571DD652E966AF5DB
      39334D0519F91C426D018311D90E0F8134375435B525F9B24F2FDE2D3747A0FE
      5424723CC6AB07EADC389457B6EDFFC3615141621B97A8BF9880518AD7B5D5FD
      162A89A63F4E057B6CBB10EA09457CCC50D51D9EB2B9B0808DD8BB774B2A80EE
      42C18DB0AA44FD6CEFF2D668914C25443B34FAF4D6D92675211098453597E0F2
      5B5C0A120259CA689F073FEC303A2789B8127BB33A816BB5E12D8A5D475FD3E1
      6C288F6F1D8FFF069DC023B9F2EA266E94736D3239DB05508935B717DB2D0C26
      2485DBED254B0A244D66D7C4D3E922993C635BB4DE176ABF1859C88F9DA685B6
      E0D9607F930A6B7BE9F6BF153AC3FECAD434D5A994541636BC9C585B7CB080F2
      32862DFC0FEECA0C431ED8C7EDADE6ED27998E93CF6B60A04F8ABEB064310134
      85DD20333934E35EF1BB7C0868C5F824F67FC8D221644B33EA513C01C550B4D9
      D41690CAABED585B55101BAC01B59E87C3F59EF4A13215126F7DABA7E548DA72
      C3F0FA355AD7B4A1B74CC2663CD1D26412DF0E7FAE8FADFCB38C6A7E2D792F3B
      3B8319EDFD8773C7003FABF16D39CA53B044D93C1B19F0C5321B6636557E4AB2
      7220EE669E5F0D39624CFA70C12772B605AE0D3FDE6409552BEE6C5CA4BBD4BB
      4BA5AD7280EA5C21B69DAEB2DAF02638DCFBF7A5F0AEECC9A97DEEDE5746DAA8
      E9C2C923716197A1A5DAD40C37A9D6951640E07367CE58FAEB620A2D25DEB5A2
      799D2C66C82FDAADE1179AB6DFBBAF3CF77666EC0B58E98261F9A95727C946A2
      EFCC3C45EE3C0999CA7145541AB0625265F665A7B6BFDCDCC928F717891D6512
      5EA6890CAEDDFA4F9DDB51AC5BAC28B6DEA7C52FD62599897694ED5C7787C4D8
      2EE83B0BAC41495A4915416A05318C2BBA5DD9C1798273EF94B9EDEE9BEE580C
      A92FEF5BF97966EACC9AF173B13E182871D156DAE5099A73110E3A75AB84610D
      4ACEC94BC9F57119C67CD0626EB2D7AE194D31346F9BCAE095645AB8CBA6B4C3
      10C66C747903C10E9727189FB6405781DA34733ACBE7E4D698B357DDDD294B79
      01C5F8C9F84807C64712D77ECEC37A94A679BCD6C10FB42AF1E714DCA8D94532
      AE6E60D1673C9A0DABD356360AFF7E95C57D8FC673A01992248B8ECE4E365A7D
      DE882ED4E394D1ED17BD1D16088599FFEFCEFF7EFBF6AD8C1B826E184D24DD57
      FA4D2301D789E1579577FDEBBFF16D7BC548B6184EDBFC388B694AAC0E53787C
      D7D35A73B6D5CFAB35C0C62E7F3AC7F454CB94F4F29C42896CACEFA59DA11458
      279064ABEF0AE6CDF1541E4D01A79D62E81C86AB24F8BE1C45616B6DB9B85CF9
      6E27F56DBBAFEF0FD742BFF32AD14E7E19320B21C3A8E08A4D061E6F5A44759C
      9CDAF50885929AF362C26AA85856623F0A476F7069EA30F7777AAC331853BF69
      AE94C5F6B10948ECF7E1FDFEBBA2A8A929E2E077F6455428765F67C4CBB7C9E7
      8F649BE2008F435DAB3FE2318B535F3D762F489D35BF4FBFF1AA49487E8B854B
      03051D85FF391BFDCD565C9540068ED4B9100145A56F95648304FDA11EB89487
      74D048664F1B9C7D9E9C383A3A7B97C41B28E15A456843359164C37B6E8D284A
      CFD466484125B46948535696A980B9D460F7FEF2F25727BF1D05E9D01479CCC3
      8487426676D5567ED8688DE1D376FF289E93C17E9B80FF25D26490992401973B
      F934CDCAE9A545A9197B9493C930D16648AA408C6005250616FB8F23756B8290
      547291661729C528E7E15DE873A909A800F736961B7D4898B29D16A8F08A07DE
      647BCEB624934CDD9A09029A3773387044EE2CF7FD8DD3A91D0657A973ABB171
      FAB3E2FA1FB9D73E5CEA72E8B5120A8095800F70790557453EB318D558AF96C9
      82BCD8E4BE40C630A0BDB551894F089C3E4BC7D332641FE95D5B8C286C62F752
      46A42FEEDEF47642F57E713266E488AA54A43F1F995556F796A20330B18FECBE
      F3A56A6A9F52839294098007411E8156E3BC6870A75261939A8CEEB0839D91B9
      08FABB4E431CADBF9A10E5135790C192AC32D85C4E01A81225D74934833B63D9
      9DE7D2CDDF2F17576F2F3661C903F664A3CB7386E785E51154B566B2D2C76E57
      30810CBBECC8C71BA86041FE515C1675E7358AEDE3250862AFE66E0E6E6C9B7F
      865D6A7D9233F049621BF10AFE3595A560E15DD346579DBF5B6E442188681431
      4D319805D563602BCA759E104F53312FD7C6721D6E4B32DAD40B5E8392BA28FA
      558443C243C296E2AE99643555591B403A35CC70646E059EB9FA8ACEDD76F4B1
      E4E125B363B0556865459DAD510DD810AC66676376ACD6A7542A22714A474209
      6F49547E8F2DD9149D2D40A2CED36AAB10EF361A5312CEB62197E88B09CDEAFC
      5C3F52B4F20A967E516290C118E6C4983A4600FD07AB9A39C860FA8BF49A55AB
      3AE7769FFEF04E66FBFEC9696FCE4F8DEEFE72D3C715A4BDB2E82A37E26F739A
      AAA7A9B0DD0B701E8E3A2E1EA41BAB89CB846AA59C2D2F88FB85D2B61AEACB34
      8215E38DAB568EE0E2CD010C4A5096EC140614322396E75EDB0077D91C6C6A6D
      21ADC2CBCA0AE8F9BC823B4FA03F6FF457FD2ED0180E0AFB34A6AC8E8D90A2AC
      6E83EE5D50EC70297D6007CF12B18233CD1E42C8CE4F460C6B223E14E2AF7198
      94E0D44977331EB8EBECEDED4967E6886A092F68FAF74579EE8DE3BE954FE937
      BF14EFF42BA766EC2D0520CD38354D54F62F85CF88A75E18A88C760BE70AE6BC
      29859006322A91B17638B8E602B67A6E96A58CFB66BB3368FE46A8A4F9B378BE
      9D1B4291FAB53BD118CC5AC6789A6431378CA5322D607137C8C92F0BCFB1906B
      9D4DCBD9D49423CE6FE16B8EA8E073232656E758D4489F24E32BE795F3F6834F
      9D2EF4D3462894B09C15B2D8F21B3A486FFDB3236BCD26E370388BD6E0FD63E3
      1CDB729E9C8BA359595389F6075F2AA1CC474B78450932675E5620F25C61F38B
      0B55470219E4CCF211654DB6A9A54AEE0433D8292547BD60952F4F30D8FAA8A6
      975B0C3364F43F5928E68FB6978AE448FDDA7312B9F635A25D9275AA228C9718
      3B34323095CA7F1ADC3DD7C3356FF957EAFA0BC36B758424659B4CA8A06CC468
      3DC95764B9E726890B667D914C6046236EA0B27349730756E24FADB8A71596BD
      073C057123F8EA26976D00B81AAB14CBA98C3EC7C9E7CDFCC2AA481C52D5A463
      8A73A8407329C52A7A7AA4A2A227F20EC129A3BFBA2E8BAD01D3DF06EEBF58AB
      98E3782C2564A132A3CE725DD4A89BE25A1A217B532DA5998DE94D2FC65C7E70
      7CFE8E23D41C45B4E01E95BF530FEA0C0ECC780DB1B62FF9C32484F8A49749F2
      51695215A53A72D2E5ED7203780E921B169A0BEE2DA3EDAE93A726104B1D4126
      1252C758BD1320B9B135E626BAB318E13550D44B1006B018EC1AD5B433B87A09
      22603A958AD5987872704B135C4DB8A65536F3C02EA5ABB8F9190B4F2259FEE3
      50BC90AA42EB2DD07296D1F4D8AD256435CBACD1CAF0FCD98D3C31777E7AB77F
      E87CCCC89A9D72362B16DA6D9D4DB35938DD22B7626B9F2125F127FB4BCECD49
      69D348D38933554F14409639C2B59EB34B68FEB4BA2C48A619F52DC9F915C839
      2D55632CC429E1B5462FD3F1D49A41735603A1D1D082779CB3304B2646305456
      5F8D1BFC78EC6CAFFCA000EA8E506E388D4198FE99BA78317E41B82F9B80F66A
      B1FD235B6D6407A5D9F12103370ED5854836C5957F38945CBDBE517515BD717E
      74D67975065BDF18E4AFDE7EE8759DA3C3E373CBF6956601D22F255CCEAEEDFF
      2886E24CB224CDA8FD1A672E9C7C30BD156B188E456E5352F8B6CD4A342B7F3A
      89D031DBB5194C668BA719E8056D85975A3D78185A00CFDF73DEC0FA34B67CE1
      78483AB86027095AD0DC0CD19132B25B04AA896370583D2B8921414B9E66B555
      B499D8F8A0BDAA7E0DE97EE108D1D035B8558C81AA2078EC4B5209FB0DCD35B0
      3B051629F78A8959383696948B84E4B804977D969FA6EAA4544909881DBF4849
      79300F251137659C72D8031FC90B98AB53E07809CEEC46E0D5CB4048B944685A
      C0E03FBE6292536134B87223E9AAC8E7E24896569974574850FE1E3A42042E56
      E225F7BD6FF298E5783887DF02FDBBAC9692FA994A4FFB36690AC97D50F1D04E
      35E6509EE86A8FFCEA8F2BCBF957F3F24622AC5611623C52571D41246DD3669D
      7E201B155B4A384912762B434BDB0499B4EBEC1F7C7F2AC1FA5DE764FF3D2EFB
      F8DDA9B9F8FDFE4FEFE8767EE275A20A7B366548C6ED9D4AA48787B7912DBCB3
      113C15134B28B66BB1A8967812F3DB4584C461F38B6D7366AB7136AD661F730B
      383F95A2966BF88EA6CFD9DA53458BB08C3AE32E5A2941E7E187D40297B29FF5
      27E7F3AE73BB1612FA5C074C891F986B955196945AA72BBDDE421DEAD84DA4BE
      68AE535EEC1989308A1CA15C9145AFD86126E6B0A3A490E69F6AE205713A1B47
      267C4A3996D5928B6A33C9102403669DC078C1025CB4B5C8074B0F9FED09B487
      70DEB1AC0F0A06AAD2F3C54FC54738DB9C9386B430D08B9CA91ADE5A7B767EB0
      28765F20D5764BEBEE9EFD9AAB395DC436A8EC0D9182E340ABEB712550A4A439
      865EA37E6C4C268019B7FA4BB24FFA374BBEE656ACC47CDE2E7769737804A70B
      FB96D8E0B609E33017E235335D048EE8BE8705CD05C38A624EC42565BC5CAA12
      38DA50E58282F25F7D54096B806F319765A4E1476D9AC16B8445EC2C5013642B
      441FB8B43C0C52356C0FE6467BCF0B8F2F4A8DB1D6229CCDB450EE44AD10DB60
      57162243821AD16E559F72A4AAF8033FB63ABD8C62579980535964C6B271D38C
      44A1392563AEFC159D245E35A7D4580ED559EDF3672C8558E8488AA32AD683D9
      85719EE64209C5C2389C508ACF92665122F50E233BBBA5FC93159C9273A8DC2D
      3A9FD551510966616A28BC21B4A2FB2B64248DC3A54037266BCC08F166F0E96E
      595F6ECD8192447C21470657266A56373C505133538D3E942A36E8E934BA2513
      A03063342C1CBA4D8CB78683639336E588638AEE2F19FB0B139A2A986C057DCE
      49821925444D507123E3AA16F9321216E2679B2D674A6EC15A1D2639E1FACCA7
      CF8CE803A171B4B9AA9162B477892E269689BBDC24350452390695E4ACF4578C
      05F1AEDAF54105964547084B259E3C34574C59A76AA5C032A2AA05837DA47219
      5D9B1556ACE0FE942B21A3D42086E3A3BF63815F8699CA271A40FFB98A08DBA7
      51CEABE472583C817A8A145DB3E76CBF91767BBA44CDC1199BC6B61A94A47E9A
      924E62A18A6E32BDFCF300503778D1D9A47EFB950C54906A93F9EC28582709B5
      B15F2F34D77414553A6AE989A6BF887F56EAD1AA16E697274A8C24A743BE01A9
      41D31C74572DCD55D358E5B1D04C288E4D8D03F3C5C352EC9A2D6BE6FA19FBE9
      7033A95E9C4C04E229D172D2A446D3B62A1537F68E1A75CE1BCD510B6C85CC8F
      2D4BC64B29B65E56E0B5E9BD5DDA046309580DF7ADA2641D18355394669AC22E
      194F568F2D1E99FD9489A2B1113A54640027539EA940D1E1BCB8900B782FA92A
      CEC87E116E8BFDEA738D6F16CEDE243A61F24AD8A2F4B8B9026173BE5683E17C
      38FC0EBB666CEDCDD1B174F949653C134008B3AC66CC506E44960A65C0C75754
      B3A5F374FCBF366CB78ABC67975CA090B2E55003E3224D8C9B18E1E88F2859C5
      FDDD30EBD26CE31254A6107087455E9A354542C0C863CA14C4DC7A9D65B309D9
      2776170C914DE1DE76614A52F4F6BD7A3F6775291B7527ED918C677C20221AF9
      22A504D5D691CA07F3448F9BFAE0DE5F584E51F4471CE0A421D5C4D94EA268B5
      AB5F6522AA79313F9640E86B8E60A5A2B7AB31BDD802390D80C302C75AA2A4E0
      A48450C3DE90799D474A0A37B85D4D406C63C5151D526D01156AEEA7CF134258
      DBD5E84A387AE29F241763063E5005E65751AE48953A52DF026F6FCAC35CA997
      8EAE09B2F44A0C712AB9AF83150A6B7ECFF9CF74265AFA8A532401F97E5C3072
      B351C1AB639569C6DDFDDCADFC8E4B299D57E5541AF31B3AB4A73F8E8987649E
      CEFE30E1F238E72F3F9E9D6F12B773F9B28552DE85E611226509ABC125AA7472
      66413565C722C592FAE4ECDCF937E7B470EE84F6D739FDE9E00C7F2230192DE6
      75F56F27F4B793944B236AD8D4E6E69D7B32CE39BC6F98DA1619842DE2621966
      5C76A509A6CA4F52E33ACF51F68E7BC650D0EF0CC36DA69FD57657F72713085F
      292DE67648939DAFB6226CCE6AA58BAD325277A1E4BD9C192FB9538BA74DB998
      D59D50A3200DD2CFA61EBE3AB8976D896132C2B794F64DCA2E05F331A1B997A5
      C0F8FE21EF0E1F17A85023642CA827E179EE15C3AEEBA5AAE6323345E8485E68
      D7A63C6CB18479CF3BD04BBBF760E7ABFCAA00895AE82E096A147B5111979DA9
      E66C9F5903234AF210FC4BF37CCD33CB2695FA265E11F7B3E72477C2619A9B76
      BA3F6CD5B2A8EA72049F3D3509B82279663EB5BA34B363784B1BC226A3AA06B7
      E78C2DB06B6B18052ECB7C00B752DAAA1A2A5221A67B91E34574385BA752855F
      4E3E896A41E4E9454B35052C2D7E0FAF3127F251EE6D66B0F56D1911BBB9C672
      5C9C22408FD92883D54E2E139FCDEB064AFF3F1E38133409357C364DE5280245
      791CBF4B723A57DB4A539DF46BE7F826A06FFE8CF32C97D04F24625F3BF9CA4F
      98923F885BCFD26C2A77E7AF9D37693A240FE8DF9C739AF9FCE7C786ECACE335
      916967D0EBC7C61083171898379B5848CF2523AAF99B5936E6B1D76516C6626B
      C1702B4652F08C0D5341F50D7051976C6FBE645B8B7D393FE3EDCA1F7F4756EF
      07DE502A0F2C84B62522F5F49937E42428BF7E8D1DDEA3ACA4DD14C66A94D035
      1766C8C4502794B9234E853BE7869E1622F66B5787953BF746C32A117CD86D65
      E0B378F3CCF7DFE6F4FC11C0C66B10E5681CFD7E923C7203C0026A2AD92B6434
      99C42EA5726D85BE8C2B70825910104839B75F5E724F9236D6323DEB7276A129
      173AA1ECFDEA32E68914C7D0F35E896DC335BFDC900D19443D9F6B0157569733
      4CAEC81C4AF21A233A4BF538FD3C6877F1B5DDF75CFCE3F6FC3EFEF1BA5D1FFF
      F89D7E0BFF74FC015DD2F5DB7449CF73E992BEEBFB72375D021DDCE3C7B40603
      BAA8DD1EB4E8AAB68BEBE85FAFE7F3757EB7D3FD63753256FFC773F9B5CA16B7
      E9BE4B9D4AD72C1F80033B9EF9CF751F119078A9FF79AF5EC1A5AE7F79557895
      AFBA53FBED1C9A2059FF627A3FA9DF07F39ACFBB2D7C4C1CCAF21DEA3F344EB8
      7E709DB728C5D3C316ADC751EDAB2BD76E0CDA8A8A8075C3A33E8E285C7F70A9
      C3AB9334BCFA06864D6D55C9FAE80F50967729F1E378F84D68F1FCD9A2968C92
      9C8B05CC589690DE8ED496447DB9466BA10DA2A8332BCBC4CCE03F131FCA199F
      234F87D7FC64CA4D51E1D44DC26DBD020E61E7D5D89E629A2D5522174D2A15A5
      DFA22DE0E7341B46671315AE3EFCBBCE0BAA84FAE5E3AF2F76C599FA16A64FFA
      AD0955D0A1BDDB594D893FB0B96281BD4917296EF8CB34BB8C95AAF09D7BDBC2
      6E6859392DCBB42D51C1E4CFC52FBF196F1AF39A9A577FA21CF5B792A558FF37
      59F87B457800DF66E9109DD2FBC63005E0902B81001BAA8B9C10CD093C9D077A
      4AB895DB224CB5ECEA5CBC145DEAA99D1CF08D028BADC7092CFAFD455967438B
      704038B478A579A898D77D848DF959A2C463A99C97CE6E6FCFDD73FFC350F11F
      9F28A241990A26E7A7C9104ACAD0D459E4A205FEA9CDC1FC3A78B7F997E4778F
      3DE7D38BA0F769AA827F2ED9D13879E97589D03D778DADC5DAFE16F2BA407738
      6EB8B7C6660FE92C2CDB63BAFFEBA4C46A1C3431DD23E7DA8C72A558541A1D8F
      E3F470369A389FCF8E0C3A63E14F3FA52DAED7D6560C5738383FDC2F5BA21ABC
      1E42AE95B2755E8D80C71146A2B7EBBC7DFF93F43055F6AE894B35058F102E7B
      AD26BEFFE7AE3F0799D8A897972A6E38176CDCF128762E73E6183FADCC14AA36
      716D659EACC18BA009C4B6C7FB11DEDF5DD37A7497BD96EBA42B156FDBF71FAE
      79F9E6BAAA37195EDF93BDE5C73C190D0CDFAED2BD03C7C88C9F0D6D78F33114
      EFA3EE6F0DC829A89FA3B38F56FDD8AE371D5E8E2DE0B0F88E9CF63F3A3B798A
      C6C5C67E5CB9D1BFBCFDE0FFEA7C475368A944F8F8FDDB0FD2D7F804B773E562
      18D7B4D21148B3AE94F4D1675A0A249D83034ED9367179F4EA054C570D882FB1
      349F9AECD9E89675740BA5FA69E3AD1C161403B1E286D42A777872B0EB7CE05E
      5B48E1EA5F8ECEDE3D412EDFC8E4D53299A15A59305BE7FEE3D1E90F4F7033EB
      A817EF15FCD95F05E14A445213177234CE2939A56C649CBB9E18082F1DD94260
      C6376C726C42FA622140322A5CBE21F44718B617D21941E189348A4C0B5223D7
      7768D277D1ED588D921006FA8C0077B06E3D8CF23AE2D8E8546E262B0A589433
      D219E10C4C6822E89EF333611ED0B0A5E9CBC4F437ABA1748DCD7D5E123BBFE9
      2C3593FD783AA6CA73CABFA762710F25BDC7853154665674A918341DF3B195D1
      C116D4870A8C094783EA85136A40A14B051C0AE6BAED5155DC90C7EF4443D1E0
      C3C4B2347B35D5A1A563FD146DFB959BF5E66C9F3E7EA59974DDDAEB34717D14
      3FF80689FA97396EF906B9B4B2C4953974A224F34EB884C9B594CB30F274908C
      551D74A75B2789085304CEAC99F66711B718F1100744712DA73C7FCF39A45F5C
      2A6AD8664F09F785B3212B67E9A07A77D89142B9F3B7294D1519264156ADC9DC
      64A71E9E9D6A6FB253CB2CD9CE53B7649F3FFBE5ECEC484CD9035697F0CA0F86
      B3C00EC071B6C96931CECDCE2E1919049C5441A326B3C33A3FE089AF5E45F02F
      7B61187E8B2A9558EAC69F1AD7D7F15E78CEC4AFCE968CA69AF26C379A41BCF2
      DE709A6FD9B4913439146D71CDA241E1F698C5EC4F8754153669AC6B2071427C
      A9A09834711D6757B7595267C2A0F3D3A94C4AA19947B3A94F3F1BA1F51A16F7
      58C9C84272D57F3A2545B5A73F73F91E6854FE62977E635AF2040BED250CEFCE
      7546BF7F19A73EBE2B2C9B4632C6F367C518D8D7E4D1F45F46F00FE1A35CEACF
      2AD2614220E5A65ED20C5AA3D6FA2CBD4E644EA4B3F58662B4A7522659CC61B1
      E5915BE22D99A98EE641B6E7900B30F9298467B13A3EDC4C028F600524652F33
      48566465648E2DF1699E8C92215E9F1A90772DD8E93009AF4C7FBEE9DD57DC6E
      5E0CA5E6829171512EDE30C26C9D6A2A03B3F09334E06C71DD769E1CFF9E01FC
      266A5CC0B08FA477B0E290AB712369B175908E268CF162F290CB4951005244CE
      9B5B99CD8E5355A7832AA78948C594C9CAA05253982343806E278D540ACF9F51
      83B30C3EF92F982E3BEFD4E49DCAE0D9E47BD3CFD20D5DFEF12F339D4FCFB154
      F923988667A18CA7028BCAD89F02CB63A09158EE87B0D3E11C323E808CD925C6
      234F47AE6A22DD123B9AFDEE5CC1262EE7DA40B811FEB545C58E58728E92DF54
      6397352E0A4D6A1C04597319CFDEFF78CCB1152EE16546FE5B4EB3DFC7490C35
      33A21071A286F87698461247D9C43B7E77BC6313ED5816EDE83EF568C72FECF5
      8A87E19C092C321BB4646519DFA1A1FEACACECECA8E1DE9FF162C5A573FC7253
      9AB7942FE85E41FF669C43DBA1D6C415DEAB8E6BD0E6BF87BEDEE8D2DFAD4BDB
      7BDE469B2ED3A6BD8D36DD68A1DFBD94D9347ED92F923994AB99666A9C0FD594
      0B2D7201E83191CF70F25AAE0FD3D188E78B72B5A60D7F367333B7CEA6146199
      A6B5834F4D5CE56A4F7FA3A37E878EDA787C4B7554FFA9EBA8E7CFFEFB9BE15C
      8D5A2432ABA2FE6298DE508C68A4A92AA6916B2BF2B46FB9F4B1004F966DE34A
      230A0DD32A418006AFF4F933B38FF4D5ECA5BA4E9328772E244BCF802299869B
      452B65C8EB19E1CE51FEDEA4DD321D9B1C5EBECB6E19849831D04CFD22D4DD88
      C285547F68D0A7097670C2B84204322F1A91A2E31BBDF1FBF5C6A62E6AA9DE18
      3C75BD51CA9D7D46AEFEF8E6689F35489DCAC54666B1FF9BA58A7E7AB77F4841
      2996937A3499DE1ACCC2262EE6B3D107B41EABEDDE9CED17B5B54D5E13F8CEB0
      DD28BDB678B7D0E23427856A7E794CDF10965A1EAA8926D5D7C4D54294589D4E
      254B1F3CF969A3627FBF8A6D6D54EC1215EB2DDFE327A4620588B6F1C97B69C9
      1A417A65B7CE50ABAB66AE62B57D40CBAC609253233A177C1F1EEF9F3472C9BC
      221EEE65EB80B274C6738B9BB81C155D2BAE1B7B97468C0F903BB1565474D7C4
      D54499BAF8FF2238A5AC2FCDC453E9DE290ADB4CA5DBD65CC823C1065E27D18C
      9A8608CBAE898B8F536A21E41E2606FBE6483D4EDA87E656A79729D3C6F7E03E
      7F562E86C73598F271CA7A51D985C9A5C805AFB7A63A9FEE4D14B1A909B71461
      2B2A5167584F2A5DF4FF8BEB17611AFE178CC51D336F0A8F6E228DC43A53799E
      860937B2DADE5522CD37E889FC973D2AEAC72E7CF5B6C8DD6FB65CFF7FD072E3
      D4FB16ABFD5658DC58F0F8FA9B2C18E2478FF3A68A6EEE5A847DE47CC82ED438
      F98DC6F1B4773916EEEE500C9CA76925D46ECF18FDA671787936FC5B0007BF1C
      A5E62D5FFFABF98694C8BFFF01235B1AB7B931CFDBF9261DF77F9F25E1150DEF
      A5A975C3249C7E839369AC0B86E9E79E9926EEE1F81B41267C78FD2D00B84B51
      C2ED5E32643B9D4D273441201DDAE66A320E4DF0D066026964F068165E1AA697
      BE6C0867359A40807DF516EC2D10706FEFD3A7772BAF4CA342F4620B3FC15ECE
      3F7DB25DC811E1BF4CD5788AD56E6D445A350BF5C10E94BB4C221380217C7F81
      B750E134B59835CD5C262DF1301DBF9872BC7F883341A9EC9C96797E7A7464EA
      D3C0164556DB26A91D4D53567501CFE38499CA2F9B59A976A7006097567AA768
      EDE5BF1B38397C5334F037342F6296FC738DDEE0493A7EB59F8DD2ECD5FE6834
      1B9B32D309E5C3F24BADA916BB891428EA3EDE7C383C7F852F2E7B15E51870CE
      6416D8F1C1DF7468824334BF814CD28806BE91FCB7D687C3E36A6682CED03C8A
      187A1CDB84F4E18737FFC7B90451860DB56ACC824C03FD251896343B45279D48
      4F34F54C8C6DDABDD2A1BBC90A3E382BD8DAF336159B4BD382CB21559F505A30
      C9F39976BA83D71C5BAD516E23D3721931CF58460B287EDCF41D53D280AD0629
      7573D488AEA2CB0BD03E4223B688E08D34A484766D1FC433058109CCA9CFDCD0
      6EE6DFCAC07023833E10AA3434C7A891AB7DFECCACB7EB12E08B014E70B2742A
      1E921A5F0C494B66233534196689B41B678A722BCC31E3023C81FC919D26D2E2
      329D5EE9DBBC801E59ED69E71580118352B2FD2D4661D149FDFAD192976C2C25
      D96897EA6527EA9B8C01FBD3378812F19E13AEE862A4FEF923CCA27DF9CD1634
      4EC7FADBE41EBEFE92933184D5B49162EAF9B3CB7418396797493C35F8B9F954
      494D89D86E1409BB4A26E4C24C53EA4DB3C209D7C1CDDD263F079E7E06F1359D
      8506F1426E852D9BD3444FA8746AE51220619D5F4DA98A006EE27F178A712880
      28F3E1872AD4D41D71CE78D004A594100036883A31F611211F7314A9509A021E
      4D68C30D9E66A53F13688FBE777996508CD4ACAE5532B485150D86FD935737A3
      6FF1A6B79CBEA211EDA6A609FB2DAE26373B41D9990072EE6C53E34770EB18A7
      A191C7E3609A0DFF744020DC34919B80D29CF7548341AFCFE37E87C92448B18C
      5DE7280FF1636A9A609C9FA8DB534E4A1317FEFC59B591CDA09EDB434C8151E3
      F7443398C4B11AE676EA0A41310B3ABA9D8DCCA9036AA76AE40130B05D526EA3
      19E2A80E8C12E321EE82F747A9F3629F31F7963D496754BBF3A28984A9D629CD
      155D5500A4F2D7147A95D9248CEB68EB9AB6F960FDBCB35B9913ECBCC9D29B9C
      72E6FBC3E99FDE7A8D1418CF9F15FB5B19971CA4E9D548655746419ACAC2D722
      5EDA7B7B1D9BA153C5A5BB0E51C1FEED227502155E35912295C68B38AF7372A6
      05F6FACFA7278704169ADAECD438BDD9755EA4E31715BDD2449ADC6DC5DC0E34
      D66CC2F0BB84335F040D380AD1CCB041917CB0C5888A122C84BC099B620C450A
      2B4171035C3EA48115D25A0AA930196AC284357AE7369D65C5A8C42436832D9A
      4890F950FD1215BBFDF3F9F7A7BB9C93D8E59139BB9CA0A983D0395193DB6C96
      F3E9D975BED3D3A36BC81E1E5B500C9B05698B46BCF7EAFA1DB7333BDBD34B35
      BE628DFEB7747C13F59ACD6CD252C979AD6D4B14C33D3BB4464AF9CA7CDD939F
      4EBE73B62F8669A086FC27FCE2FD9E737EA979BCE18B29610C6B904E808A0F7E
      A0FCF094C6B5989A70D3F04CCF9AF24D12F591B25B864CC46D9566E7461194C8
      E95B72FEF5F4BBC33A5527F92CB0A9A6D4393D7A0B66E69982E2243477FE13D5
      4A50110157F365D22FF0F1E4D075CA0563AB3FEE1FFC0091C681522AB36EE64A
      A95CE2CDC7F3432B94C838313D10411ADD5261D1546A2608BF0857BE77C64DE5
      715EECA9C62FB8D6E5E0E8E4848F33DB1E17D2E8A224B3C399D4B8C97319CEFC
      5766B49CA9FBE155926166ADAE0F6FCFCEEB1CF3527539DBECEEBD384BB838CC
      D8B62F6CE480CCB738DED9E49C1F21E7BC417B589A73769F7ACE59E7133362CA
      CC4CA64271089B40C76906B9928F9A595B64F2A35EF7350DD6CDA7F0501DE8C5
      2C1E9A9904B0342F329DE7DC36174A8A94C241C394FCC1890D153679EDBDD78E
      78300202515803D08F3473784A438FC8F1C99DE3F377D4C0CBA16368D41A26FD
      1C1AD15813166A88278C1B5AA7449342A827964A2C5967F4A90131636329FFFB
      8C6ACE820C3CA4A7778967EA0D2E120E25483891EEB318B10CBA9FC3BBD9D37B
      CE2FFFFB63323D9BA6935F9B49260E0B1D06C3032ECA4CC7F3E353A4DA02A74A
      5D50145605549032A4C3A6AF8916C35BB651D9FB48CD7C5219D2306A2239D87B
      28A64E5083789DD0E4854CFBBE2963473222862DB848C680363282F0FC1921B3
      8836A1136355C92D95E787532A570A2F25AF39BD343929B6CE735BECDF11DF97
      8C7842542D6EE01C96E12109F137933EF784A5779D1F8FB9FE2A4B870B31EAFD
      3C27993352631CA96CD7FE1CD878349FC78606A44D4C4474D45F0FFEFF53675B
      8F6D05DB6F94BF2DD298FFB133EFCC92F7DEF8257F7C777C66C44783D7220107
      08AF204FB97D813AC187156BE3B5F3EEC3E19B5D7C3D3BDC75DE7EF7DD3E7F3D
      A3AFE7670D5EF9CC0C403F39387FEF54BD4EEA87D351C514F8F1EC878FC6A46E
      F2492D1496E9B8E3342B76FD5A3B6A9828CA2FF3DA1D180424C548B63779BD62
      1356F036EDC46B8EA535FEE4BE3814FFF58519A77EA9B9DFA6628DBC78E9B6FD
      9EDFF7BA7E7FAF45FF7B41C64BA079BC310B31F0C0410D7FE1E8E4C4B432C967
      51AC1A8ED95F0F4E7E2E4545836969B3485B14B6FAF4E90337AB3801A1EAE45B
      B6CE7A3179B4246FD460125407CDDB548E5497932CE029194D5D9D5F0AFB8ACD
      5F95F938060CB9D854E01DB34A91781FBF3B3DADD85BF892CD24645AA7329D06
      A04F2F2F32C2EF65A999ABEB868605E6A8B2440FBCFBEEE82D7337D9A322DEFE
      7AF2E1A0F912AD58F4D68FE3598E7F6DDDC35FCF8E0EB720C3B3A6467ACAC662
      59A09430CC6FEBFB8F07FF7777490A7C6F932A788454C106B57269AAC07BEAA9
      0203079DE9EB57EFB167EF340F4C8E6BE142DBB292D918C769CFF91136908AC9
      0E8411C9B624F3492AD36F4D6303E53515B5AC6549E5EC3D25A659B9EE334D38
      C51CBECAF4DF6749467899D28CC67042117730439A468D5C9E7084C2865115CF
      7D6041B4A3342229BE2DA00B5E90579C48431EA7B7892B9A69FC72006EBFC2B6
      54850C81A7A5A854CAAC1BB9BB5BFF67369AF0F0A0B4A6F197D85EEE17B9EDB3
      9CA493D984C11B1ABABF47638AC7BF327179EECC853D2B7DA5A679A291BB7B92
      5EC8F9A32A886B9DDD64095E7D4C0525DEBB378D5CD2F367BF7C3E04CFD2FCB2
      A91A52578CB6A3E5330A26539910852C2EB3747671099D44BFF86813C138C297
      8A4259DC36944FD568B2E71C4F9D114745024DCD57F16C48D74D2917E8E0600B
      1A0BDB904D259981E0C0AFAE72AB8E2B309FD2334E330428A0578E7FDC733E9A
      5806FE3BF8813B4E3827CAD9BC4612635915D217CA6125E5C980D0E7EFA4F39E
      1235B706BA76A714785FC35FF83D1EC223004CADB4846CD6EBF513E48C6F6FFC
      FB4FDDF87F5F9E7C09FC36F284BFBFA72D683B195303A5744E5ECC868AECF309
      6985A4066FE3093B8D254735F3BC7D7EA20258B11139EBBBCEF901F5C99D603D
      6FD2CFCD5CE1F3676786694D799B0A092312460007EB2C7684A4D1B9D3F84F6F
      599591152F4E29043F5C1B8D9F8D46A4C6B96652E3D4A46AF3DBF1547D762E21
      6C862470C88DCF8AFE3FE3BA7CCD60D713575E34802FDF28AE658AABF3D415D7
      4F2A4B64DE6FF21B81224C0D5200253578984243FDD20F334670920CA313AD2E
      F45DB6F0E62DFB58C2F56DB7B38B2F5DFA32A02F7D679BBEDCA8DCD9A2F2426E
      E823DA6CED6C045941BD77491E6EE4D83239D67DEA72ECF9B303427718A55112
      27D4A2CFA897A3899A2641324CE0A0B34513A4F872A8B1C8C4F9EB113BED7F3D
      F22C6C6C4EB0B1793ACB081981EA341B290324ECFC46E5FA3DADA78850E4A933
      1BE712E39189876CF519603B1AF83E0B692A9049433473F16F6EA77A9F16B7BA
      EB76A8C717E006F83619456AB856A7EB3B4132CD3799CC47C864BA834D267399
      2CED3D7559CA3B09B140A2E33A3135EAA33419A93128E2FCF3F9B37F7C6204CD
      4FF130226FE81F9FFE85BEA5CAB8AFFEB2CEF7FFF9F1E8F4E4F8FD0FCED6E574
      3AC95FBF7A55BCEB5EA4AF13352620B13D688357F8F7D5B9CE3BF4D22F8FB1C4
      FCA5DFED0DDC5E7FD0DDBA0B12B7ECDD19246EE1ED5B9DDEA0EFBA77DF9E0843
      A5214C2DDCDA6A45AD70A0556F100F0215EA76BB1FF6DD564BA956CB0FD4A015
      B4DC96FCCF937FF48AEB07BE5CD7EDB75A3DDFFC879F7BB8DFC3556E2CFF7523
      FC47FF0ECCF7A04E57E39AB67C14FDE7E2E72EEEEF76707FD75C6BAEA3E7D2F7
      6053FE9EAFF5CC3323F319D5BFE3E78E7D16BD0BFE7DFE8C7EE24F1898AB70A7
      3FA83C49CBD5F47B0F7FC7B16C79588E876B3CD77CDF373F7765E5BD41A7DF6F
      C7BE17B4A35EECF755EC82469D28C41EB8BDAEA12368D651812C34F6FEF94FEC
      353836CB87EB72EC6CF8298CDD4731377F17BB62099F72382A22CAE83B9222FA
      73EB93A4166F7BADFEA7384DA7E6DB301DE69FE91B3D8EC6973AD37C37DD42A5
      6824FFF86922BDC2E1A73C9E8E83BFD522CEB223F125BA3C359550BB82935A3E
      9331C1E22ADB211DE9302509B97D6AFA9CF64FDFEDEF3AEF7F3A3BDEADE5727C
      38747709BCE243336366863447D7603332212946CCF872CE0535E2500AF0F850
      CAC7A8926198FC465748735383D7FBF6BE9247C62EB199001912554CAC6CE27A
      4DB36CCB775E63D1D4BA96122818A1A7C077A0F668460FCC47CE367D737199E6
      D31DCE271759E28686522C8874BF8FA51FCAE8110E0393A74830A2CE44D17891
      74381BC17D4CA604C0095F0AABA319A33C90830484E95874B6A319976F29E752
      09C64AA66160310C5F30BBD821F01A5C9FD0A8120AD1487C46669029AAC66C24
      150DFFB40720A2C5CEBAE48CB88A223A21206C1D6C9ADCF9EBC9E949D14D6AE6
      6412DCADD4C74952996898E65AAEE531A9D099B060336ED91F2717630BF8636B
      D48FCFDF3592AE05C479BB05CA7226AA02D7C8FDB30CE3989BD9B790C94964BA
      91F33D677F98A7BB6CE86F2DDEBB456110C2031129D648EA7CA8D4B598B96794
      D322A661B027E8EF29B58BF2D99252CA40D7D0D6505AE436379226853C73CBA3
      78A026F0390B0C7C53F23D169054EEEAE756A64A377F945028890C5270D1A136
      D962BE97472AF0A1A3BA979CA64112A828F1E226C6BCA9F4A8171CE93FF5E0C8
      7CCA9CAABBD8202A6C3E0E33D3ACBA88283951398C5E678B46906D3957FA169A
      BD99E61015435480622D487663D76295DCCA8B4D3DDF46826DD2FD2BA5D7E0E9
      4BAF034A8A65EC89DC24C3219B40B6C0593BE4D37DC6C2B9FE0BEE1E9948995C
      984C0903E95AF378C914EBB835582681BE4CC6CD146AC686763B64435BA455D3
      B92D83F418F08AFA510823AA916B2C3C05B7CD9E82996D648089D2D839D5175C
      F820733219BB983D521878A7C5ECA4627402C7BC86EA56F265DCA5B43A464F06
      B678687C7F3A86A7F69E47DBF14797239AFE7A70726A5DB3F90D30381A0DDF82
      D6AB769BE2092561E9FCD9E66999E251F47C492B54751786697A359B38D18CE3
      6CDC011619A665D82D428CE2A11EB371A687496315B4F56D7B20D51B19EB6A8A
      EF7EB45360C98F3F345D27058172C2E46FF282C93713E7D5D932B09C1258DE02
      370CADFDD57417B4DD2651B4FF53B5FF7D0E7F8F01B02015D81F955A853DE74C
      62C7B4F1230803E81F35B4DD712C2C48AE987287E1AD3D249A23D3D0D679A38F
      42AB5F47B9BF767EE2383CA1381AB24A1F2939ECF4D3D1D93B0661D873DEA8F0
      EA82438CE584C461324A8C9FCF33C4F16F016468C8C9CD5D8D2464C17CAD1E6B
      7B89D72BE7EF339D4FADCE314A102BCA94C0361AB91367EA82D03AA4D31F9A2F
      D076E63A94D29779B3B9FD4F96625D50EC88931D6A7529E5F367959E65D3CE0B
      8219403B3EDB94161AABEB1183D8EFC1A3C0E9FD918A8E289F46F1DA4AAC8EDC
      6C1DC7549E798D635D9C6F8A914B044F90A31A49E09229C904FD60EC70229FB0
      A565BBDC01EDFFC2BFDA375052D44A65F307652BDF9E732807951252BB961913
      6E2826D0C0E4371D95343430B681AE3116F282821DCDB4BF2C8D2954FE539A80
      60E7B7136D06DBC008A61CCD64A2E19AED39EF8462B91CE8B9A3BBF1FD9D1FC6
      7474992A9B08C0920880BFBC82EF494500AC2FE2E134FCC819EA3BE923311AA8
      56D408F05D2B2AAC550145070F23654CE4D7EC891C500F502C5E651159082C98
      177424CD2A994A7EB39848C7AF42C3D99A59FD60050BCCF61A847704F6ACB06F
      4D5DAE40BC1AC4370573EB620C196D86F4C1A67D312DE84574E6CBF76C16354A
      75CE94CE393473A9E79F6B2B9B8DF2E59FB00992A14929A683FD302D0F1B31B7
      69045829DF9EFC94F8D2C7248B6A8BDC9CD9C4F0FF96E4C483F4330458789966
      12C40AD2298DF7A30121105F8D1444EA3A4D0844507C34C20D0F550D524D418F
      A8B41E21A25387510B221DCC2E284EF855DB83FEFB96C2F737A5F0CBA4C9939F
      FFF1FCD9CFA4ABA754996546FC19A599501264AAC66698AC86974A4DD110223C
      F3CE8E14164BAA9C594DCA18DFE16F6AE8BCD79F67ECD99D4DB51AB1479B5FA6
      66E2080CA64356FE2ABF725440F39AF8358C4687A89A8D1A891E5C80AA7C3413
      DEB6A568D2C6FF768A915564654A767D04856C6334625012212C28C121BCE474
      1CA4D9D8393C3968224D0C45B60839CE9889CEF1E1D6B20A5313246DE22ACF69
      75A650A800C35A5A33C42BB6F30D9AB8D47DD37548C241125F9599E3F8A549BF
      FDABD36FB52E9BB8404E246A4EBFD0E8C461028E0DD3217B8FE3C88E78B5E5B1
      5015DC6AD7E481EA5BF373D20ADC376935AD21F6C66142A695F87266A0F0C9FE
      FB431917CA64C337C7C5B9D896B9F5F303EB77F69C0FE3CA105D831FC8488962
      71EC9A79D5C96FFF0DA6D81FDB99A74BE78290A1C583BA4DF5D5C6567D045BB5
      B7B15597D9AA4F1E80B6B0AB7E34E50451A286292756A7B713334548E0E7DB7B
      FD27B8C72B5778528306D264A45F45DAF41B6967368DFBA637890267991AE7C3
      B281CBF467EC0ADECF2D4BDFD148C067215BA9C2F36C9AF1F100FD4CB12701B6
      9A64CA34256C283315A289543528BC50296294BC2AF222F95532C94197288235
      6686346C64EC63C8D8EE46C62E93B14F1EE7AF0404FD70784EE203B6081BC291
      B33DCDD2594005911CDE3F5437E38B196DE9AA67EEE9BCE18EFCDB623824CD1E
      DB3F383255F082351224139E7FC54EADC95E1C7398A4846BC954A89DC5F21F99
      6767C22EB0F68A46CA258F94D6BCB2DA40222E0D465BDD37857D3CFF108BA26F
      2AF5F78CD3C7853915683AB80C8B16F1667CF3BAE27AE555CBE4796723CF97C9
      F3270F7F578830F899348393ABBB68A4FAF1C7C3333B8854E4D813DCE0BA6145
      41843A3C3A3B2FCAD7F64F0EBE77B6C923D83AD402FDC4D2847261D0615BCD56
      48AC9D2B13317306A6CF34CF1A36E0A6B8C6A5532C800DF8FA41461591FAB29A
      88A27729033E50AE1D5E9323E00F4D244EC90B56AFD429E523780B2E841A3B34
      BAAD2411B10E2B1B3E31EADA9255E8D4440215DC23C725200CFB0A23BC93F96D
      1FD981DEB6633D41175600FE0E577050294B51BB48D32DC665C8DEB954394F5B
      9F8B55358A44BF30E8BB8D2F8C929CCB8778E65BD347BBDD8BE871F6F1E8A4C1
      C32C3F7207EACB8011EECA206A7E0B4B79C4C7796B7F3201D74A5BEB9600576C
      73A184A3AE6B14CB984ED039B393C697D3A4D369DA4845B2650004841A8D5CC1
      3E24FCED6F9A0699C82A282D90657A3CC55E9B046BFE18684C6EDDA599577697
      BDB1EBA42B4DD6B6EF3FDC66E59BEB1AADC9F07AB8BCD0891FF3446CD7B3ABDB
      2C19391393451FA68F91287DD4DD5C8DD3110C936B0AC49ECEC6D4B72632E863
      96520544464B2250BE7A588358FCD7471B7CFDEAD5CDCDCDDE980A3946699433
      6C5B6A56F58A7EF3CA6FF7BB5E4D70C127052DD87397430B5661057BBDF23F86
      04D406F28FEE31D07F05F4A06FC0FD964107D27FF8BC6E68C0012DFCA001059C
      8330B4CF890D48609BA005191690E002BD87C202B6BE062CE04A0E5B87ABF0BE
      E0FA278202D86C0CC04DAC647551B4E4E1A9A15249757F9E3A694C53D178066E
      0D5391EC1076A6C83BDAFA40B9B42DF2D3C5E67C433DE654EAF02AD30AEF1710
      FE40E176614DBBCE99FE3BC3D0EDC2AE090BE0A25D474FC3BD465A9A6F67439A
      C4362143FC8A90A924229E3936ADC0B19AF34D14F711926EFE2648BB4CF03400
      DB7FA1B081FA8E1CF8E338263825D1901C5AF6D94DD5EDDEF433D7E83268874C
      E64B9D371FCECE18BD95C38106BF68E567EB27C83275437D26A4714D6DCBDC0C
      548EE9A393F1971FCFCE1BBCBA83A39313E74651BE8F6515A1D7CD261C970C34
      C1FB1575897939D7A689EB2DE3921CC31EA5DC8137D4172ABC754EDFEFBF33C9
      4F8ACFFED9F0BC411A337F9181ED14E2C6D777F4F5E7A3FD8FBB9C0480863D3E
      6B72CDB49DDAB57C9112B9ABD3B36E68351FE69D8D73156BC9034C6E4B34041B
      E6623C57D23422791A6982FCF2F683F7ABF33EE53C97294B3D3CDE3F71081E62
      D2C8982E8E4C31A254A460B638A854A68EAB8B281D0E094F164F74C24CE5D410
      4533B84DE706777670C0D4D8BD8727078D2409015E385B25FAD79619C84DB372
      0875C818E566FC3867756ACDAE1F92164E62D315435E0159F58D549B45AD31C1
      52C11EBA2DAD0BF0CBE7AE6FA2E68DDCFFEF53F85607E7A727EC66B0B5246E87
      C1EAA0E9497424E2D221D9381D8FE074781BA76399D3F1E487E01456973108A4
      70DA22B5D14991F87B35AD823D1FD1D5F9EB4D6265E99E3723B1724252482CCA
      7CD7392689BFEB9C4D340C85471986F975732C58C5EBF945EC3ADF6BC521B529
      BE7FABC2C7EA0EFABA0B3B55A17EED7CAF920CAB38BAD5954D6AD84A0E64049F
      CE9AF7EAA75A5A299AF7E6D4ECE0D0F4EEE6BDFA0FD6BB4FC7AF9DFD6C946670
      76B59A50247C7F344A77E9D06FCC8E269A1D6C7490E3FA0A0E6C0DF7EB57589E
      14F8D4195526922DFFE3E1A9B86082C24443DD9D1BC5962EAC933C571762E80B
      8E2AB49CBA7E27387C4F9063EA06816C64F88E9B9FEF6D4CB1069B62CF9FBDF9
      7878CE73AB6D37C92DF8D9B6F64512D796E80D6363F0C01F38E9E3A930791273
      E3F4D4192A6AC7816DEE6C9735DDF234F67DE9418F11BEFBEAC61DBCCE694208
      9182975D2CAD066DB17ABA15648BF4E73F3E72FE754943E90D4719B0CC792CF1
      72F379E5CD5C5A3E656E5ED8F5E056FED0D0951521B8422B316CE0F88A43ED87
      C93516374DB3A71867DF18376B340CC2757BFB576772998E3535EFDDB0BD62D2
      B5127737D5D795768C26DB279284A823926717F97CFD39538072D87CEAB78548
      23A8AC21ABC5D0CCE622E94D97FE59AE1B16C0E84602F27C80E94CEC40087D6A
      918CE14010A24813095BF0D2011380A45E367DA9C7326C91D193699805BEA1C1
      0967477F9134C736B59D12A4B4643F8AB48E8C3251D4C111EA6652A4EC641311
      2ABD0C5CC8DFD48101D26F72508319BEDFB74D1A7C2A6C6B8A40215EAAE15013
      0693C1C1A03CEF2185C0DE81FF6F29A5D760EA1CDA01A39CB33539DC5D910D4A
      26D01A54DF39B1C24D3BA6BDA991AB7F9F72531F0F2490A56DD1D9BE2263E886
      406EE927190B81F56E35728D365DCB9D757865690327C4110B3E958C19C69C5A
      CDA272CE62A316F9FC99E9407A9B0C49F593263B306977695DA16141532DD0C5
      925A935D8FE5861C4E0B61BB0817D0B64F329DE7CE871FA8276F2A5432D70A9D
      7619FC58300804BBD10024F330E3CFC9D422295F646AB42B888E773ECC4457E8
      B374D6D4D1446F5723FFF3B22B58673670D464E1712630E6261EC6CEC55CE4ED
      15370512ABFDDF617AC1F584B349CAC3D19A3911570CD05142E3DC6063D63894
      729AF8B4C15E7A41C08DE3C8D687C429D57D581C8FACAC98288E07476364EA70
      31F85A604E092784CE193F9A2154B87D1057F027F0F3E863769DC96CCA7525E3
      6A694A96A653F3F9C66FB07FC4EEE87036E5A7B1B187876FDB16A33DFC71D7C1
      B6FE24DFE969B8C1367E940A077753E1B0CC1B7FF2936C4DFFE099F4823652AA
      D120D772F68D946B412C357129D2710CEB2E60C47A06C8252812629329A186D2
      8886346BE60CCA533DD2A300027B92E666C626243DC5F234559B92001F291E0E
      D5582BB6C4C092DA3A33708D2DF7B3CB249EFEE930181E0C93F0AA91CBFB657F
      38FCD5F939BBD5CE1B955F3A1797694E46A0C539DFBED3DFEAB2F86A2DAAA8D8
      AFFDEEF69DBCA5EFE439FFB2A7F3C91EBFC903BB6B1F2E3C77E87C1AA7414249
      3C843319D7C8D93695C57FD93F39F9D5797B7276CE30380EBDBA14FDCE27561A
      BCB8A3C3E34347F1B4B9BCC4B52E92608D5C591129ADB64CB280A2BA11C3C3C3
      CADF4AEC5465B89A46F659FD342DF1531B490E438C97C3D73625EC10E02B2924
      32D09D1CCB0D2F05B83DE5512882B33D4712B817350E7A436B2AAA4048EC2527
      795E887A1329E7186AA5DDEE15F5E4714B1E3BCBA69B40D30087B85012448346
      524422AD5262F52E8D7E80EB73FCEEC3A18D38DB7915141DB95619C35696E36C
      1BBCE28F2787EE3C8EDA9D81DCAC0761B2E21C3576A1AFB8034AC66B4AF6BC3A
      846D352808E890C53473374E3EEF3D4A89F0D727838D93D85C657A43F5A897C9
      C432B9F4DB62B7A9F1B2995B5DAEF16C9CDEDC3A375A319C77B52B2CF95CAD38
      D8CFA697A334CD36A1A2C70815B5079B50D1B250D1E0A9878A9E3F4BCADEB8C5
      0A4B3A271279E1A42AE75409D3DA14936D0ECE231C9C0D5EFCB283D369C0B4DD
      B734087E367DFF131F09EA8F1DA9EC0A0789AA142CFC79123BD16C025F934B79
      A4EF1A67EA9A4673D3202C6E417B821CB072FD31DB12DC572D71B1619A5E71C7
      E9D421484A33D9BDC943CDB608238024A320F6E45BC5DC95CB74368C2A16B3CC
      18E7CDD653950C9DEB840E3A877AC91DE7AAAEC27CDC08CCDF23303780EC4B05
      6603C6F7463C45C30929544E7DF7CACECA336960DBC3C287E7E692F2BC97E990
      0315DCDEFEB7D9686230C6D4B4C1C0BD774427CB175AE6446757567052451B2D
      F6684CD9F78F69326E2438F9F367E27D9FB1F72D9896144D91DFFEC9FCFE232D
      FC48167E4E0BA75A2F42D5560E8F0589E0B44AB49246B1DA02F96B0B504C0F24
      0E2A802FB84AB489E4A2AABEB9334275BE198CEFDB2AAA8766ED73E3A4134D56
      3AC5E338E8EBA80B9534120A49CE44327EC940FE7639607F197A3FBC75428AC5
      F05AC394A6354E2D37A91AF1DA71244657423A854842D5D31754F5A342EAEFBF
      9159C05AFE36A6510043FCDA4C746CA685F6FCD93B1E9A231D749C97955F9C9A
      093A6494489B890973D2ACA39FA5A1F0B51D9AA63F83FC09CD0753C35DEB0D32
      B942DCB91942F33B4D1A77AFB3B70112596AD13460843805547182F25C67D365
      130642FC9EAA1FEEA60C3607668D03B33A1DB770A2DA9B13B5EC443560D0E99B
      D905A5295E3BF130555C673321CB9775BECA925C467B92ED33A442F0AD78F6DB
      6FB75B7BCEF9659273F74FA673CAE9D2A1A30E9185C7801E81CEE401E69114B2
      A05255FDF7991A32A6260C817476C1F6C0AD638BF48D8F324C46342E542A9B54
      18CE32C26AC4CFC670DBF69DE076AA77163F98F34DF99EF3460A5FB9C49C06E1
      510373286D5C065C6D654E6AB52D451F9D8B97644215812E5628CB963015FF66
      23921E4187B7FEE31B5171B9DFBF3615BDEEFCA1B63404D198867590DF57C6D3
      4EB59C3FE3F74BADC1DEDEDED657A4DDEFA1D623A0E3D7010C22178471D3A51C
      450B8C01D86DACAE930B295399665A739CE4E5BF3BF791D550B5460DE792FB45
      4449E4939D6EFB47C83A3B3B2BD014FF2421678332719D841389491AA9452173
      35BEE5247B96449531A18CFA30A23D22C9151A10A5480245F43178C60E75FAF0
      4F2CA7B94BD4919F648A33C7DF59EED6A6046B116A5CC8753C1BDA3E22F61C47
      E0A9046E27794D33AA9399DA4E34D814639E272D7E965114F16C3ACBF42ECF0E
      5343BCEA8D1A73F58C1ADEA8DB9CFCDA6B5AB33239003B0DD5D9D67B177B7883
      3A9404E5DF7EF03E0A422D94CB2DD9A2F06BE90F633C8B283B5493095F68F6CF
      14F094F8196641BB8E6DA01DA92B720933D397354E6D9C2ED3F278F206890F6C
      195DF5F114B4A18FA067882FCF16312DB2D2ABBA58D519DC77B882F278D59343
      AB25F8FEE9FBE3F7DFBDFEEA85A5CF9F95813EDA81CA8152DC7F943321653BE4
      F8F14E98A638EE834956DBC2CF9FB18697A18FE4F44B3B1BF6EE4A4E1B174698
      4FE10D9EE5CCCE496E7F4B092C8E1414E37CF908D0DD919EE871A416D966AC65
      A0015F479379596450E5189F5AFC057CCACAD29C509A09240C2712669A16F498
      3BD6FCF24AFAF12C4423CC2E8809B2B76E6B9FEC7D1CC15D59A43D682BEF2156
      E62C1D113419DA39883CE162A832928B51C4FD88EA0616D5164FCAAB901C7F37
      ED4F346A7E36A1EFFCEFDEC881C86632417036A6E21BE574FD00D4B1EF069EF8
      992BE6370EE3EFB7CEBCBD9673F4D78F47A7C7EF8EDE9FEF9F6C9CC365CE6103
      26B4CBA133C60AF95C14A5E5D0712E93C1170A58768D3768C69C8E48808D28F2
      291E578D4FAC183BF84A8D3A04061B41FF89790109B1253F86DCBE6DE4E6164B
      0145C7F9962B0E71754842137ED72CB4EDDD9394D0AC12C2A88085A04D0B0DB5
      3F1B1B62EB8067355276E3881BFDB78A41E18D2CD3033D8D71C4F1FC7145DA41
      F45471DE0A336594E6538BC36B46F41A677FA4D5B86285B1C8CDB5AEB3AB9C37
      C8C937BE21B15CADD7289E172511B5C6F21F6EB97535D7C3D8D9A66E26E281B1
      53F69FE6A35DE7E0AC046CE13A6AE379DBEC4D6035002D13B6DA313758146307
      E80F02F7204ACAEEB3817D12F87EAB43590DBD1CA7321703AF4F6773A44561F3
      73D9E2AC3E9C4E3611146C36AAE186A4AB5B5D98A5A54C8CAD79582FD8812BAD
      27B2C5F46EF9CEDCFB53EB75650197091DD5EA127805E773EB37A39D25CBF592
      2FFFF8DDE9A1F8285A65431AA96418A9915526D4E958ACD68EA3482236DE92D1
      A341B07EF575BD995D50C92DA7F024CE65AA67C2CB34096DA341A005CCC5429C
      8911D8C4F59E5FD6903CDAF9712C280BAC210CC24BB9FF468A898DFC91528F99
      B37FF0FDA9F38BCC346CFBBFD2613992C6FA8F8AC56269959EE14EF3B7336EC1
      04F53F4C58AF703BA6DC600C557CCC9EF35D22014F63964FE4236D8113412871
      AB07CEA8EC941152D1EE5C78B148D24AEB807800BCBFB683FF26CD86D1EEA384
      3739449BC465787642A75F902133CD4E2DB117D1573A550444477A52B9A6A010
      C97810A74223AB71ADA3D550F57A7E598BC1583B5008BCD8376EF823634A3AE4
      580F5B4AEE8AF218265702C8B02573799C17C755C34752CB2F9C53D6DFA5A1E2
      4469639BA5CE8B92125E88882FA21B557EDEE44EB5A089F30870E3A95AC7389A
      426B98D724C5432E2830D8647C76CCA59136BF24F2B3732EBC1B0EA9474D4235
      FCC1E05CE1FA0AFCCDA58A848D1917A76CD0DC788B0FF616DD4D3E7EB983F8E4
      C7983E7FF61DC5C8CE2C50CDF677EFCECE77E418D2A9654827ABA86AB478A643
      2AFEA562E68842F1475C93747CB8CB816B31541A29D8F64DE194D179A7FA420C
      ED02638F5B42844EEC4C8BA3AB9CB79458949B3782E61104CD574D1A3EF1C4D7
      7935346B323EDC943A527F4B33A69D3529D43099DE9ACC4A251A14B0C3414976
      53F186079A2236E2EDD10886EC4643FE6EC66DEF6D60A196EAC7064CDB151C46
      9B808A938C8242948929CB44A0DB60ABB2CFC016FD13DCEA1A883D7699CA71C9
      0D9C5F221712AB218716F152534523BE9AB84E0A1D155026618DFD8754BC48B3
      5B67EBFB2482F34601977769E47C476D695B765426BC98401B504CB67C9A489A
      E7CF787A8A1D7C8A855AF3CD8136794F76A21C010AD55EE869250445BF1B4BB2
      15074031CE453997BA89C42880A3272480640EEC4735BDC4C627CD6CCDDBC78E
      7009C2D66C4CB8C0E32DC704F5C975E6F09654DC994612CA5E1BE39FE7813471
      CD67361251A7D2C0C40CB667B94190674EDFB556FE3475F2AB64B24BF90DD395
      BAEBECEDED989E9BB05A85C4E1C5ADB32248B1B55BFCF43E1D6BC9756D1D5336
      675ABEE4561349AC22AA57A0F5CFA4D447BA246CDFAE6D334AE33809296F67E0
      6F9AB85409CFBFAEE8CA90F5E34D96526185054586095B966571D787D137354C
      7A1BAF4A32123C149EB5992965F9709B6BC084BE3BCC4826EF663C00E145FB81
      8D23320C449D1166D0F446ABAB32A9A9A9EA25C94746E54A555505962C1CD2AF
      8A045B13976E14705CB0577227E1B9F566960C2B9166285CC9F092F870B67118
      73E7EF334A5D282790AA6BFC2E31686590E6A1AE5325C71A8F4CC09D3D679F47
      907074B6A8EE8920C4CCAC77AC8CC2DBE67D22E7CDED16F36CD1686802B0E560
      D8A229AF0452CACAFB6908555172D564D0A877A510A48C8B9A4C86942D3743A5
      A486C936BB844916CE466456870D8DFC2FC6F5B957394B6F6CC48C3D3C27A7F2
      4DAEC3AD53AA492DCD1488A4964D9ADBC7D55D4512ED262FBB0FB9B9C0C6D904
      2C968B4F05C46EA447E99E739616D59A64E06895271CE680959A87593299E664
      E606697AD548E14179C75BEAB9B8708E5F5C737FEF45CA090F159046FAF3A6EF
      F0774771363D524BA3384F7ED4D67C8E83A4B134E546950A35C8846682D5BD9D
      D590A526B1CC380164327EA4D2212E9A3B48C79181AEE2F930D0B81113461AC6
      9B19E5292234B9B3CD1E89C840D6114305FDFB1467E6D5D8C6324F57A9F9BBEB
      958A05B9C31B2A05E5AF049587CBCA95B337D5B94FAD30C5800AEE99298A6272
      3A2F138A7610AF706047E5A6D8A5003975B68D6B67417357BE3F154C4C546E72
      830696A0C09A6DE4967CB4B679C625F93C5FACDAD54CD497A06A49613380AA0C
      AE5EC09AAEA19C551B323D1FBA9D01BE9279F378D9ACBB12799EB086A03D7730
      18787D3B44F89FFFF8F42F9FA86E49476AAA9C4ECB0F5A5ECB6FFBAD56AB8BFF
      FA5280E542EBE841A45B7110C7B129CA0A5B2EFFEBC9CF9DC0F7BA7157F7FC6E
      87BE76E28EDF1BF45ADD4ECFEB44AEEEF5BB513754E1A01D06BE0E3DAFD56EE1
      A29EDF8FC3BEA73B6EE4ABE7CF0661E0E2C3FB6E470FFA6ED8EBEBB0A7DC5E18
      B6C2FE60E0FAED6E3888FA81AB7A9D0E5EA6E78791DBF17D57F5DD56BBDB0DDD
      301A785EDC1B682FD05ECF0DA276DCEA059DD01BF407A1EAF94AC5B1EBBB2E3E
      4607EDC0EF7522D58962AFE7C7D14045CF9F75BAFD41BFDD56EDBE1776DBAAD3
      8A07FDD80F54A083D0ED7BBD7EAFDFF2F1B081EAB8AAD30B74176BC47B04AE17
      F5F5A0D573DBF1A0A5FCC88D95D76FB961E0757A5DB7DB6FC511C8A9C308AFDE
      8EC2765F07784ADBEB6B2F1CF85ED4D39D9617749F3F0B5AEDA8D3F722AD7527
      1E800CBE7607AD00EFE0C55ED7D72AF495EFB5FA7D2FF0C2D60084D3A1EAC703
      1FB46977B136FC180CDC5EDC71B5F25D7C8A6A875167108252F1A03D085ABADF
      D1DD0EB6A5ED75543FD26E2B765B413F6CBBA117B49E3F236277E230EEC20268
      E303743788BD60A0FB03BC7E10753B836E188411D61BB87DDD0BBD6E4787215E
      A31DC76DBFDB8A3B5EACFB6D2FF2C210AF11F462E19598B807FCF2253EC36E80
      06AA87C7CA2F5B3084DAFC4D60382DEEB9E0B1B0E7B931F8CA7CDF27468ABB8A
      380BEFDFD371BF13442063BB1781DE58591B5C859D885567D0F23DDA9E5E840D
      69BBFD5EDCEDBB6E3B88C0111A5FFDF8F9B310DBDA5241003A83DC3A8E7B6AE0
      45B156BA1FC403DD1EF89AA8D31D28A55ADDD0D3AE0FC60B836E5FB77B5D2F02
      73C6E0E041BFA37CD5733B2DBC0E98A7D5EFE273F119013170D869456DE5814C
      91D76E07AAE3F783AED71A74DA2E7621EEF7A3814F57B94AFB6ED78FDAD8E156
      E4E2853A51E0F95DD7F57BB1EA0DDABD76278E7AE0BC3EBD9A06CD7032BCB8D3
      EEE260F5BC1E96A2FBB1EA87833806D780466138D07E1CB6717FEC86BAE36353
      BA383203DF0FBBF853176FA0DA3857B1F63A5E1081A7FBDD8E5291DFD6512BE8
      04E0B8A81B47B2377576B61BF406836EBBDB3712A3AF0A49C2FF83E4C027404A
      74DC58BE7FFEACFA137DEF477880C67F3DC815D74A152C26F4A316F6DE25A982
      3DED45AADDEB0D5A9006D88C006CEA77BA38F461A07410C47833DF1B846DE5B7
      215F40D1410CBEC609D45EDFF37AA18EC0C73832C1F367580FBEC14686AD5E2B
      EAAB6E072247F7FBC4D43DC81BD5C3BEF523E5F7DB21362AEC861ACF6CE380E9
      41AFDF06C503BF8F8316C5FE006CE975F06E1015E04170461474A2C86D45DDA0
      0351D571DB1A7B11451D8DF3EB835120EAF006BD4E4FF7B19B10DEE032FC110B
      C186B65CAFBF0EFD7DDD8EFD56D463CEA63F056DDE8176F73EFACBF7CF9F953F
      796D4B731D42A2C47D3A2DDDB61F6862242F6EF5A308C22D08BADAC7A7054118
      B6075D8DEB070156EA87BEAF7DD5D75D9C812EF6ACD78528C3E9EC41B2624D3E
      1D15376CE3DFC8C3E51E246214830F704E70CAF0E138C331C815E03074071D2F
      C4618C5AB8D7EB0C0610E8612F8AA0025CC83A17A7AFDD8174D5319E31800C8B
      2055E230F2FB839E8AA3B015AB41AFD3F7B1E7201AB87B30E8B9DA1BE0087714
      8E633B18785DEC2C1618D369EC291C61D585C26987E026CFF73B83BE3F206E72
      216DF13A51D48ABD38E8F7C35EB7D7879EF0BA611FFB3D2009DD52DD76D46B79
      3A0A5CC8691831ED56A83CD0C91D807CAD7EAC071037781930A5ABB5D71DF4DA
      6D5CD10559DBE083C8EDBA117EA754D869B7A047212B20B5FCBE4B726B00B1D1
      A6E315B82DB02824173605DAADA5E83138E97E085116767B918676EB066D5013
      0A44BB5021BE0F75D8EFE13C408BE3C5BD6E371AF4BB50BB7DDD8218F374D073
      A11BFBAAEDB6742FF67C1D75BA1DB0920EB54B7ACA7523A8F63E346414775D05
      C13BE8F4C218F20AAA1E6A33C6C7815F486CC610B703C8448D8338883A3016A0
      E64041DC1982D5B14D51574154A898D6D4F2FCB60243A88EE7C2C40A5418E3D8
      0C7A3DCF53B040C02F715B81A5C14803581038639E1BC4DA258A841DE8ACB8DF
      25953DF0B1E5017E0BB5A0C3B8D7C31E4271F90104B38A7B305D5A38583017B0
      1AEC04B14FD881E982530E1D0915D2036507B050F00B8842B7DF1FB4342990BE
      EEF45414F7439C5FDD1DB45A0392EF3EF63FF4703BE43C980AA4EC77FA2EB453
      1FEC14F850465D301858BB8BFD8200097B1A871F87D01F801450F82E8C9CB84B
      5C0441D069851D4F2B688076FFF9B3B6873789B19D206C80E3D5571DB2336853
      067AE00DA00AFA787CDCE981A35C501CE21BBA0FD2BAEFB67B100EC4D6386BED
      18540291BA24F0C1C5788716ED87DBEAC61D1D8372906120810E34344F1FBBE1
      F7A0FAC2E7CFBC90D433942F947FE4839921BFFAB0D3D4A0ABE20E140ADE3DD6
      386C4A0D62B0498C3308D11AE366A8201F96611C6A9C941E98250AE89681EAB7
      2168DD0EE9493C348617DB8FDBF810FEC9831D842F505C50161D9C051C1EE85D
      98A23808D819B7138560820807A44D462028D5EAF77CD01D1218EF1C4132432F
      80CF61DE417782083E746D18C21C6841A977705937A085B6DA7E9BAC56B03354
      2B64660B5611543219A4115E0B76570C61053EE887B087C2360C4D3C1B420502
      B41F42D077FB411F164780ED869185778179D70763E3F5A170DB1D688928F241
      3B98BD3E4C82D8C5E18114838C6AC1341E40A874C258C108EC42FA9005D7D730
      1FFB0A0F0A5D28A6366CB1D0873CE8072DD8A5411FD2B90705E3B614AC5C17D6
      50E842B3E09A2EEEC17642D5E3ED42AC5D7514AC836800D183CD776183B7F16A
      21E4691B72AF0F4DD9690F3CD24BAA0FE5D2F35D3F2221DAC7198401EB813F42
      C86A2C22F206908964E64242B87D85CF8240EDD183FDD085D1020589DFE220AA
      D6005B815D07CF83BB7AA0D2C0C3BBF9B0DFBC3E58CD552444C174906F30B460
      FE76A2BEEF291C786891A8A57125D60CA1E54262C10285BA83A90C450DFBA01D
      93C300C349D3796676A7A3034B06FF81DFF1CE5010107911AC81560FD669E447
      78CFA8EFE264FA835869324C7C48A74E07DE410055092B169CE1C146D48AA459
      17C20ED61C0435CC3798E183565BE379B1EFE12C80426D05BD1C6093603B423A
      E25BC86048B8180218B2AC0376F03B38953E1D35E8069C994883E3C36E1C7A0A
      DB1880CFB5EB4164C5D037E00EBC365E1EA7340ABA9DC0C3D980C8D31A07C6ED
      46385A31791EC43431DE40EB167E82DD0CE12CD217B21B025A77B008A843E8AC
      7810C32EC20BF5423CBB0D61E306781ECE8EAFBA3DEC590B3A6F00739D14028C
      4288AE56A05BAA07E7C1EBB661BD47F07CC037105E386D786EECB63D1C8056AF
      0B8984BD0B20ADC1C703A819EC2E8EAD4757E2528822BC289ED88DE1FEE2E828
      7C1A5C21EC5FA4F4A00B090EDD3B804707F101C72B86F31390D686C080C18503
      08F508BEED04E434F5609A0C5C2C0E56284E4AAFE5437F433345C100B60F88E3
      E100F9AD90AC271C26C85858C85023904EF06470E2A19720E4C18A2D980DA03C
      3E3D00C7461DD844C4AA10B91030F0B2C89B24D709964C0FCEE500965C1B325F
      75B06EAC63401A2988C2109679A8C96B83A90383A7DB6D7555BB0316851900C1
      DD21A3143611743274280480826EC779EF7830D13B389F3890607F5845786518
      1A5D30A0EFB7BAB04E3BD03BF042616CF7236C1CFC46FCB603C504310F550E75
      8AB3064D8EC7781DBC410C2F16C631AE8467D757B092B042500AC4C3EBC31400
      41548077A3BB2006BBB0A17AF8383024643D348156D8CE36940279033D9CAA10
      62DAEFE2B0EA6E1CF763E81BB8B9F809FA141E0DA80BEAB9034FC1108FC86F04
      57C0360A5920C3D80195E1264266FA3055159D4DB743A727ECE32075611B78D8
      2AE81B0D17087B833FE92ECE140C39C8A54E2FF21409493876F0707AC4366A80
      C7F6A146C8BAEEC11E073B42DEF6E0BCF7C8C6C02E90470B51431A10A7DF85C3
      ACF04ED01A5EDBC77335EC0F7700B1DA85B102050E610C2307C71BCE190CCA3E
      F60A241EC46E2F84F3E3432FB7DB83A805A293AB0B758677A135EB0EF42C44CA
      A0138250303540EE56D8C21B408AB80398A3D8E676C7F77C78F2F0B1B145D817
      D864DD50918D069F2CC23987AD074E23EF1C223F824A22BAFB70EDE0670C3C0F
      BE40007DA75CB016BC13082908F7A0DD82C1021DDF81288AB00F410F47832214
      20990FAF2D22EBA505B13C88E1197520EDF0669029AA1DC05B85DD40F2A11584
      2E6C25DF0D6004425B45BD1ECC650867F8BC9038D8B2018570C85A097A10906D
      B02F340DF40C4746E09180FEF0A4E0116271D84BBC484C0B273B111F090502BF
      B21BF561BBC25BF27135EC1B17460376A0EBC3A16D87200F6420AC64D810BD1E
      E4077ED1C5DEC3BC09E1A576C0BF70C9A0F8B12F38E5D0AF9A5E13761C9C9076
      6F10F2FAA300FA88025BA041442A2E022742088790E670092025C0B178D3B0DD
      82BF13B4622CDC1DF4209B3D4D2E205951D06E91C60186C941670D3E2F8CA3EE
      006A10BC83F3078B2DD01DB889305B29E840E41E106B6B486F6C1B7C273A34F0
      7B229FDE007C800576A118B0632AC65EC0A080D9032B0D4218C41F444A75620D
      D1E3293CB987F3457E35B8080E3E480EADA060337589C2D8A30E044700B9D4C3
      11851B8FDF41C88087C10D583F2919B02518AA0B311BC290820D0CBF11760D34
      2CEE83C903B58437000DEB7A8B2D08AD416B406F2B5E7A209EA6DBFBB2B75846
      67A01B577AEEF3F11BF6E1C92AC1C1C089767B142E89BB902081228F07FC14F5
      FBB80847871C25ED7B700CC941825BDC862F12C14D248FA60FF30AA20CF2400F
      06306E83410F36E000C6190E55A421987096C10DD046B800B6FD003E06F4541F
      56276C4038E2D000FD4134F0A00A0290A60F01D0857CD5511B26CC000EAFDBF7
      C921F3E1FAE0D33C98E13D1C3A170A1526386C1458E57E0C1B09070A0EA68235
      054FC7775DE52998F1F0DD8208CA0B8E084E2D641B85E560EEC24E051777B101
      D0EFD0226DBC7E072E05456D4006D861FD4117FC093509FF0B1B0C7315A20426
      23C92845E18710C70CC69CA293EE87F0583A60277038CC1ED9B9B9DD876E7723
      6AB15D3FE2FBA5FF55A3C1B0D2EE8D07AF7A078A067E2916B8EC7F5E4BAE99E7
      C492D3567DE6AA38D5B2FFE1A8B85F3A15D518CAF293B0EAAD56456F96FD0F3A
      A9782BECC292F75A16D959F526AB24C3D237C1F1FD127DAA31DDFA3283DFB4D3
      2A29D091FF3A262A16862D65FFF4CFE7CF28D911A6C334CB434A798C0C4618BC
      CAD83C19729A3EA9E741B4827BE153B94417B87F2EBC621CE02E71B58FBFC2B5
      A4BF76A0EE7D789D5E9FAE80BFEFF31BD3D7909E00BAE2AADE80B81ECF82590F
      BB535166016200B2BA07F781BC18D8142D79079C150F7F237F0E0E40CFC7FFB5
      6061C52E05293C43199C793847718FDFC9DCD7ED120DE96FBEF9AB4B92027E96
      8BDFF5E49D799530E43C9C12B886315DDF1DD009E515E20E4F3E19660D564E6B
      F2615AC9EFFC6E20BFE3EBDCE23AB7B8CE2DAEE3DFE1D9F4CE9C0F32CF98FB4D
      790D7327FDCEBD73D5DD277977AEF1EE5CE3DFB9C6BF734DE7CE359D3BD774EF
      5CD3E56BFAA0385134907DB23FF1DFB013DDD09FBF62E177B80EBC607892F2D9
      E3693EBD1DEAFCD3308FF26932529FBD5E877E18A6E1958E221DB7F84F7A945C
      721B83FDCD6C4C882254F16C7FF377A927B43F4EB224CD92E92D7E1E0CFE513E
      52068D3B953BDA4EF5FA96535EDB72DE333AFC9FEFBD7A3077F5A596A469FBCF
      CF9FCDBFB6DC55BE74FBFE1758FE48F7CF8FFC40EFB11FE83FFEA23B8FFD8EDD
      C77E60EFF117DD7FEC771CD47AA0BD2BC111FB5C9B83E7EFAAC7A4F3F7D4E3C3
      F97BFC07DCD379D08AEA31CCFC3DBD07DC536FD3E7EF19D45C91E50E6F9E3DA6
      69886DFE9D0FA8B7E35F7880F7FB17518F1BBEF0807A62E60B0FE8FEFE45D463
      9A2F3CA01E077DE101EB8909518CCEF1987061D63C5A719A4EC7E9544AA0D7FA
      5435C67D061479DD7B491CEA6CAD5BE84571CB43048711BE0F97E55E67EEA9A1
      E2C9ED6BBDFE94DB18D2D889938B59A6F33517A2C7D77A984E0AE4D3B53EBBB8
      39D3D359B6DE7B17FC5174573C9449CA07ACB774AEBE17B481B53E7AA22E1E74
      1FECDADFB1607B371F89F5165AB0889A4D2F89EF12BDDE3E8F5498A5EB7165AA
      D63A1DF6BE93245F7775748BF366361CEAF54405DFF77EFD6DE4FBD63382F896
      BA4A70EEA6F58C20BEA59EA25B42BD872CCADCF9A0B5997B1FB04473E703562A
      FBFD90959A3B1FB45273EF03566AEEECDCEF9CB6E77DD9F3643A5C4FB01C0C53
      6AA85B735D67C9C5581120FE5A16C9FC330EA52298CBFD2F3235B974DEA6E3F5
      0EF19B34BA75CED7B5128ABB1E66DAF0CED05C87643C5B8FD673773E840B8B7B
      D7F3A8E6EFADEBC42FBF7BBD53F7CE8C00FDBE34CC96B3F1027BCD82E9DA9C7C
      A68633B109D65CE0A19AAEF7492503BD65C815C346BFFF116BF2C47BB208BE37
      7A76BD35979FBFDE4796F7ADC7828B67EEC11F6B6E5F5710BFA16FD61715DFDF
      126C5A32BE5AEBAEB729E149EA68FEEEA58CEFBAF33C3CA5767DB3B6E537CC0B
      FCA3D1E452E5C97A06DD611ACE78E6C73B3559EBC68FD4EEB23E158F5E8E6888
      76A934D6DBBBEFCFDF9D38E7E9846C5882E95B6F07E9E637D46C3A7AD0FDC609
      DEFE59073BEB7FF03E2CE7F1EDE8210BDE7F8047C6371E246B8A33B92B8D1E70
      D76181CDFF9025FEA06F835465D1FA9FFB115E141F8EA97EC0DD678AFA07D7BF
      8F3A146F7008D78E17F0DD3FA92C2157ECA18E6E3E0BFEA6C3F54EDEFB547CAA
      75EEF920FDD1A2F7D70D12CFDDBC9E8C9FBB754DED4200BE694532DD13033B67
      57985092EE595645D0859A8695C3FA2E1EBADC7259A4F7D94485D6EFB51775E7
      85F609E30D9C5D960E7271E1A2E94517163B585CE52EB9AAB2AAE23A6FC1188B
      92D9C87EAE090C17D7FA5FBAD69DBFB6B3EC5AC32F731776EFBD70E189BD6517
      D292169FD8BFF7427771F5837B2FF5E69ED99BDF9D43955DDDA5796FC16DA264
      3BCD145BB68B3D77F9B5771FEA2DBF90F7B22E0341C984A4CCDB8BEBBF8F97CA
      1B6A31D53D977F99B7EEB9E9CB4C76CF4D5FE0B6C5B5DF779E4FF57592DBD8EA
      F258ACBFB0FCBCE2997EC17E9B67B2BFCC52A37C977FC8FC361E8FA77A9CEBCA
      5D750ECEBDFBFD8533740F65BF7098EEB9E30B676AF91DF71DAE7BAEFEF229BB
      6FE95F3A70F77CD0174EDE3D4BAF7104DD7AC2FC9ECB571DC03B02AEDE11741F
      7204EB0BFC7BEEA8C1C077D6538381DDB519D85D9B81DDB518D87D08032F2EBD
      0E03BB6B33B0BB36037BEB31B0B71E037B0F6360EF210CECADCDC0DEDA0C7C67
      3D3518D85B9B81BDB519B89E7973CFD5F5187871E97518D85B9B81BDB519D85F
      8F81FDF518D87F1803FB0F61607F6D06F6D766E03BEBA9C1C0FEDA0CECAFCDC0
      FE5A0CEC3F848117975E8781FDB519D85F9B813BEB3170673D06EE3C8C813B0F
      61E0CEDA0CDC599B81EFACA7060377D666E0CEDA0CDC598B813B0F61E0C5A5D7
      61E0CEDA0CDC599B81BBEB3170773D06EE3E8C81BB0F61E0EEDA0CDC5D9B81EF
      ACA7060377D766E0EEDA0CDC5D8B81BB0F61E0C5A5D761E0EEDA0CDCFD42E86E
      9E0E94741CEAF98CCA729F7F7E7DD68B2F6EFC42F6C6BB9BE71CD2C49E6A49D0
      F21BDDA59F59E7CE7922BD49D3AB35CA048AA7CCF3E59B24182629C7466E7F4F
      79F4627CF6C34191CFAC5EE62F4D43713077DE49F7DD7B2F9C77867CEFDE0BE7
      8D4EDFBFF7C24513C2EFDC7BE9BC18F5E78F13B3AB5CC7026FFEDAEE7DD7B697
      5DDDBBEFEA85E5F7EFBB6E61F583FBAE5B5C7CE7DE3575585ECC3DB6D3BEEFE2
      6E718AE76F70EFBBA1B7FC8695645B1EE4F902FDEE8B3D7D8194F77CC6FD345D
      7EC32AD2DE73570D1ADFB7A63AE4BE677175E9EEAE4BF7DA0C7C5F8CA506DDDD
      07D1DD7D30DDDDB599FCDEC5D5A5BBB72EDDBD75E95E5B82DC174BA84B77EFC1
      74F71E4C77EF61DC7E4755ACA6BBBF2EDDFD75E9EE3F88DBEF08FE35E8EE3F98
      EEFEC3E8DE5997DB17BDAA1A74EFAC4BF7CE83E8DE7930B72FAE691DBA771E46
      F7EEBA74EFAECBED8BDE430DBA771F44F7EE83E9DE7D30B7DF59DC3CDDD923AA
      6D0456AEFEA20EAD5CF745115EB9EE8B12A4729D3101BF28382A97D733022B37
      D43302EF92AD961158A5DF3D37DC4FC87BADC6FB695ACB08BC43DC5A46E0521A
      DF73670D62DFBBB8FFD7DEB9EC3808426178DFA4EFC251407D83D9CC6A320FC0
      0864167349AADBBE7B416C170247209D4BA327698C3618CF5762BF26F527953B
      2A8121EEC9133832609DFA52AC52B9A3128872472510E55E95CDF6A56F257047
      2530C43DF90E1251B244EA9E3A6670472510E58E4A609C3BCD9DED9E35AE7347
      2530C43DEF161E199541DDD3C70CEEA804C6B9A31218E2CE7267BB678DEBDC51
      098C72472510E5CE8A67BBD75C2A77540243DC51090C71E7B9B37D2956A9DC51
      0944B9A3128872CFCB25783643F2FF86FDF2294E63E1530E4F62781F45DE039E
      AF5F27357C7FD8E53EAE177C9E566AB08B340CA35D0D85C09475445CBE132130
      E7331D0FD4C6BD4F89407555295653602D6BA9A43DB3A949C0A9CB52AAB9CD35
      0A16776792A4D7008A087803100AE2E94EAE6A9B5F6C4EA995D653DA532C990A
      16DBC51B76BCBEA58EF9FBB7E33F58364D73BBB577BFDD0A742FE7ADFADD2BF9
      8BDA3FFBEDD6DE3D5ECCB806D7EED550A71ED45808576EBF31079A6ECD12CA6B
      4ABA64F1EF7DD27321BBB6ED2A0DD286537366AE94928ED71503C562E795448B
      E38134AD5DEBA7979440CC38FE4B45091496E9FEC1EA9E041EAF7B5BF72250D0
      FDF5B7C75CE7F3051C995CF4}
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
