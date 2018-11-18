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
      789CECBDFB77DB46B227FEBBCFF1FF80E5DDEF313543D17CE99599CC5D5BB613
      EFF891B59CE4CE86397B40A0492202010E1A14C5C9C9FFFEAD4777A301120268
      CB923517736F2C12041ADDD5DD55D5F5F8D4EFE3249DF6C7AE2FA6A11BCDFABD
      C1D1D88D6440FF78CB597F703418AF3CBE63DA1BF3BF3295F3A93FF1E6C3FE51
      EF88BF86317F3DE6AFF320F77512D0B3F88E61EFB4AF3F4F05BCF1749CCEC542
      98DFCCB7E2AF9EECFD3E9EC6519A4E42F8D01B43B37EE08CA749BC70A3F1D49B
      BB8914295C5F26FF1CFC3EFED378E946B1144E6F00FF77DC1BF68E7A23F86F00
      9F467F7C0C16423AEFC4DAF9808FFFE50F6872609A5CC4BE488A6DF6F36D9E40
      3B67D436B6398236CFE3551288045BFDCB1F8F1F418BC3924E0EB63B09A4ECC1
      80E1BF13E82C367AF2C7C566318943EA5B3F1B6F14843737B4F5BF3F7E0EA299
      0FFF496E6B54D2ADFEF07837F50A6DFEF1C35B68EC4DF023DE3775C3D4F91F3F
      C8C17B6FF54CFCA1475EF68E9DF383F3C2F383F334405ABA8B4912B8CE5B379D
      53A78727A641B90EA4BCB9C1294DCA809AD60D8601B4486D8D867BCCF48EFFC1
      4C47320E5DA9063B1AD5EFDBAEE62EC42C16CE8FAFB97347FBCCCEAEE6FE979E
      1E6A2F84467E8B13A0206CC8DBDE35347C7F62BDA1FF45D716BC6D1E586F1BEC
      B72886BB1785F32698CD53359A89DD7ED906FE0C2E03F31144BAFDBD76C91EF3
      91BD61AFD5F489F391BDEDF89636A99E89ACE593DB9F89D171197B1E9E72AB4E
      E131E7FC253F59D69B01CEE8EE273789E61667655372DC2F79F8BB44884B7AF3
      51D90EEE1F0F4A1EFEB84AF8D1D2AD797252F268FB7B3149C4FA809F1F943E5F
      46AEF6B3C49D04DE811AF951D976EA9F1E97B4F01C565CE0F1FB4BC5D6F1B0EC
      FD3F05228D5CB828780CC7C7659C5FCF79DFB1C4B89EEFE393D2C7D484171E33
      937D7C56F6A49EEDFC93D94C9FF4CA9F1CEC78524FF349BFF43935CFF9E77273
      7C52AA03E9492E3C9C9FE09352C1AA6738FFB835BB27A3F2E10E77BDB938B5FD
      D3D39B5984A33999F3B39029BCA18CA30D4FAB1983AD9FD02A61ADE7B49A31E4
      9FDC24EA95D54C21F760B64E8667D52C21F7A85E28C3B3EAED987B50CF160FF5
      AC7A3BE69EDE9AB051BF4C5AD8646601ADF96EBF4C0BB4E9AB1E51A41DF5CF4A
      9EB149CBCF28AA329B1EF44A9F1B149ED3241D0DFA65CF181EAB9FC9EDBBD1A0
      4C93C998AB79D0EC397A7058F6A03589FC606EFE468332A5D59E3FF5C6ADA93B
      A9C5475949CE84662D2EAA1FD2D377528B83AAA77213785A8B83AA27CD149ED6
      E261EA298B818D4E6B7130F5E036494FAB77833E27640C67745ABD21B2A73449
      4FAB778479286334A3B3EA0D611E33E43CABDE11E6A16C4B2845A97A5364CFE6
      76C559F5AE304FDA737856BD29B2376E4DE1599504FA5F4511A4469A3BA39535
      52A995E65A299327151A6AA1997EA9CE58A5AB6E8DAB5FAA3E566AAEB9664A85
      563D2D36D756A908ABABD1E65A2B3D6AD5D16E732D95E91F7B68BAF6A17C5071
      ECAFA719D180EDD3F7E0B4B6FCA603B65EA7B936CA58D1B640576DA8556A3732
      2CE5315B129E1BB1D768AEA15286B325F2B921BD42738D94F29E2D1D801BC9AD
      CF5C4BA5DC684B29502DE55767AEADA3DA7A02B765ADCD5C3B65626A5B6D507D
      2AAE4CDBC032FC3466B765A8197E3ABBB39B197D32BB2B36F489CC6E6B60A3CF
      6477B9B63E87DD15DBFA7466B73DC65B6077B6556DF43912346BE5139794960B
      A6A172BB4B8D45956BE8B32468D6CCE72CA9EDD17DE6A2CAB5F5B912346BE973
      97D49621F5F8566468C15E7A5C5F8266B2337BBABEECCC56A6DDC0497DB999AD
      C85C03F5E5A52529B3C7EB4BCAC20ACCB5525F4AE6565EAE8DFAD2312F17B316
      EACBC51D2BCD36759F7C32FBCAB5F25912D13473FA7907805C539FCEBE72CD7C
      BE44CCDAFAEC0340AEB5CF625FB9963E977D41835E1CC6493A09FF324E84DF1B
      CF6056A2DE7812AE446FFBD2E0E8C8BE085F6FBADCFBCBE3477819BFEF68A470
      B997BF9835B2F372E195DC447F706A5F84AF375DE696F1DB8E260A970BF79634
      61BF9087DE3F1BA89FE003FD7436A845E91E4EF69F3004C29B2F91590C06638C
      9E18BBCA8186B113E60B8659A82F478E7E70E9C283FF0C9D7118F4C609FC27DD
      3E8827190E8ECEE0DFC52A4CFBE375E07B69B87493F13A7197F0940B97C7AE5C
      BAE172EEE28768B50001E5AED278ECFABFAD649AA0BE0E0D424F43FC2748DD65
      CF81753E8EE27FC2AA8B17712A9CDFC732DD8442CE85487FBFBB6E8C9334045A
      4C3DD97780223DF80F49E7EAC015E8469AF00D3D07BACC84D5512556400911BB
      8AD6636F96043E3D162DAD16A225B6E18C6524AE53E894FCE7344E166E0A9F96
      49102741BAE939EFF012866D4037643F4FA249BF4784C27F2738E83E7CE3BF7B
      912A5EA5401C118A2B11F6F620DC44D30E94E452DA4DC6F4FB2EEA5D8266037A
      0E9C02998E3D4DC3DE7EF49BB852F871D453A484AE49E8F365FF68274DCF1C5C
      74890CFCFEE87478D23FED3973E162448BD357741E7C793AF73F85CE40A91BE9
      8C942C5DA5B744DD81A6EEF1BED41D28EA0EBF3C75079F42DDC1C9CDD485DFBF
      3875879ABA27FB5277C8B200C6046DB9BE1FA4C19580DBA55804F3C0F745045F
      56117C142B78A5D568DF79C194757E70137706949E3BAFE228A50661ECA9ECF7
      E19F245EFBE33499A6F2E7C04FE7CF87F065092F0AFBBD53F531C93E4E43FDFB
      34359F26E653829FBCC9D205B60E1FA6FC6102430709C77FD3CD52C05DF24A24
      296836F06992F889FE1BAABF13F537517FFD59683EE96B73F5F7AA52D2C168EF
      47C8DC8588E9F76F580E8F1FB1A4713EBA935098B57464AFA532E69F1FC984E2
      2991E71BFE9EAD735C9CBCC0F16FEC5DE656E28EE5FDBD66CDCE3968ADA65FC7
      D5FDC2D7EEE8175C462654ECCF60CFFE0CF2FD39A9EECFE064677FF0F2566F86
      7BF666A87B435AC2E99761B07B2FF6D10D8B7D74EBBCD49A55A3099CDEC8000B
      C4541BA0FDB3981C98893D2B9DD8003B981F575098CA6D063EE86DBFF7E50268
      2D03A9DF39E895BE733A20C2F6B614D4C1982FE75E5F7BE4DF7F7CFBC6398F7D
      DAF772905733CD1A4151707DD63F867FFBA7C301FC199CC02E4FAF87C7C723F8
      333A3A05DE7D7D343AC35B8E477DBCE5648871D7D7A783D1889FC65B60299E50
      33BDB333BCA9DF3F43C1710D47A201DED61F9E8CE8BED1F1D1F12D2F4D45C11B
      95FDDE0D8B73A017E7E0F3D428ADA50E067BCFD40F89E085950ADF2C9AC17E8B
      C62C999DCC30C79D739DABEA4F8E2D0E86E59D2A7427D787ECF8B3F5C2657878
      699A1FD56DBE38C89B5FE091CDE34FB088649AA238FC9D3EF277B158866E2AE0
      89A3D3A3D3D393A3C129FF4C8AE798FE8DA65ECF7C8AD4C7DF3CF3415F9AC661
      18AFD51799BAA0E8801AC4DF96AE27D42FA00C8928EDFDCEDF52583DE327BD01
      FCD7EB2229F845ABC54424122EC221668B1630FEDCDC0787C363DC2427B0D47F
      F3D43871B70E68EBC01F3410DCEEA8AEA0E7117C84C9DA6388FDBA43DC3DC0FE
      68D483C1DB63C44B3848FCFBB58C72F079A31C205BB5C74817E075F8D721E3E2
      D730CAE1678EF2F4B4304ABC80A384BF2533890BFF8E4739FABC51C2BFF951D2
      05781DFEDD63BDEA917FA1511E7DDE2847C302E7A10BF03AFCFBF9BB520FFE73
      4779FC79A3C4A481DC28E902BC0EFF7E51DE6308506794279F39CA9302F7A10B
      38CA93E37BE2B0C4F10AA33CFDBC511E8F0ADC872EC00BF1AF1E25FA4C1C6812
      3F07FEE8E4E8E8E8F48FDDDAC3D9E9E919FCDF68177906C38C3EFA735D02D59E
      F9FE7875383CEB0F9DFF2CD2050680D9869243BDDCCFD2183E67287BEF5A183B
      8C2BDE359E41C978481BD84F3DB8D32199891A9CED9A283CAFF47B2563AB500B
      BEF6B1DD343290F805B5AE5A19782063AB5000762B730F646C9F20F6F323CBB4
      9AAF6E6C9F20ECF79BB5DB506A3E756CFB8BF85B5B917B0AB4BDC7F609827D70
      8C73DA3F2E91ED83FE111A964E7A5F62CEFF5BC9F6A21ED7C8F646B63FE4B135
      B2BD91ED8D6CFFAA65FBA8DF3B1B8E8647FDDDB21D8EED474767C346B437A2BD
      11ED8D686F447B23DA1BD1FE5044FBC9D1D17000F27BB7681FF54F87BDA3E1D1
      4E7F7E23DB1BD9DEC8F646B637B2BD91ED8D6CFFFA64FB31C8EDE1F1E9F1C96E
      D97ED81F1C8368EF1D1F3727F746BA37D2BD91EE8D746FA47B23DD1F88743F3D
      EB8D8E8E4E8F8665D2FDB8777C723A1C3647F746B837C2BD11EE8D706F847B23
      DC1F88703FEB8F4E4E8E8ECECECA84FBE8A47774D21B9EDC42AC7C23DD1BE9DE
      48F746BA3F80B135D2BD91EEFF0ED2FD180EEF8351B9743F3A1D9C1D0D47678D
      746FA47B23DD1BE9DE48F746BA37D2FD8148F73E16451C0CCF4E8ECBC43BDC71
      743C181E1F37E2BD11EF8D786FC47B23DE1BF1DE88F70722DEFBBD93E3A3FE71
      BF571232DFEB9F9E9CF64F1ABF7B23DC1BE1DE08F746B837C2BD11EE0F46B89F
      1E1DF58783D39298F9C10853DD47B70151D708F746B837C2BD11EE0F606C8D70
      6F84FBBF83701F9D0C8E8E8627A7A521F3472747C351EF6CD488F746BC37E2BD
      11EF8D786FC47B23DE1F8A783F3AED1D634CFCA044BC1F0D8F4FFBC78DD7FDC6
      39AE1E488328DFC8F3469E7FC5636BE47923CFFF1DE4F9F168D81F0CCE0625B0
      B383DE49EFE8086E683CED9FBB359BD37A23DD1BE9FE30C6D648F746BAFF5B48
      F793B33EA1CB961BE3CF50FC9F35E7F546BC37E2BD11EF8D786FC47B23DE1F8C
      783F1B1E9F9C9CF64A0EEF87FDB3D1D16878323C69C47B23DE1BF1DE88F746BC
      37E2BD11EF0F45BC9FF67AF8FFA7A77FC0EF7FA2ABF1954892C017D046287ECF
      5D524F993A72B91FBD7805231987B26FB676E1390364BFFB39EDEF2F3C9585FB
      ED7E6C58F29849DFDFFDD8A8E4319339B0FBB1A392C78C19046779D783C7BB1F
      34857B763F7552F63AAD96ED7EECB4E43133DDBB1F3BDBFD9881282E99EF5ED9
      84E3E08E4ADED5EF970D4DBB8B4A9E2B5B26269FB3E4B9927562409C4A1E2B59
      2706D9B16CBEFB252BC514582E79AC649D64513125CF9DF00E4EC4553A099DDF
      7F8C2EA3781DFD85AF2E674BBA8A1FC601FCD31B07A9BB4452F5C609FC2727F0
      9F8BA9B0FA8E7EC91DFC1619F8D8207D189E9DC1E2C7858FDF46BDDEB07F36A0
      CFC7A7C321EC0CFA7C32383B3B1B9ED2E73EDC3318F686FC65843B6074A6BE9C
      0E4F6099C25B160B379DFF90F0DF5771940E47E3C524B97C1E00CB551F2E56D0
      AB855CB861F82A7181292FFC402E5F88697FBC08DFBAC98CEE4DCC275F4CFFB7
      07BFAD1377F99A582F69C98B204ADF040BF810B9C9063EE1DA0CA269FCFBD85D
      A5F338715E86708F4C45F2EC475AECF152246E0A3F7C845FE17AE4BC8C66A148
      E0392F11C0EE17E34D32E8F54FC78BB8DF1FFB9BFEC9789E9CE29B6886719AB6
      EF39C3DF8F70CFC3F4CA208E70F1091F5F4D4F45F174E9CE841C8EF8CB3A4E7C
      790AD4E7AFDEDC4DE411B0A163EBFB5A82B6353AE236A3B3214FE0F52284E1D0
      92A08F7D679EA6CB6F9E3E95DE5C2C5CD95D045E12CB789A76BD78F1349E4E03
      4F3CC5F73D1D80FCEE0DE9F322FCE38FF1D2055AACFBFDB3DE317F9EC3E28689
      5E00D143262F7C4ACCA7D47C9AD0A7D90ACE93092CB43491C24B1D5847EBC08F
      D75E9A84E3691A4D7E1BBB22F2FDD81BA730C7970B58FBB2C79FA77102AB230D
      A219D02F8E6238984E842F37720AEBA50F540E377174B5087BD6AF201067BE9B
      BAF0E6640AAD82788D5268F0CA0D03B82E801EFDB19CC76B38E27A621E873E8A
      65D830B3284EC422B816BE07ADA3D8860D712582889EBCC6B7E063F001F626AC
      8A3ECCC1351C93D37823221895B85ECA79924670790583053DC01BFB114C4224
      27FE04AE926200435AC1B8616072EEC2F687F5F52F1CBB3F5BD02A860F73BA11
      76097CBEB23EC3ADC18C0F7CF84BEEDB1CBBD6A707F0039E39A03F6EE48FAF02
      B1BE043DA44F9FA4E786A27FD2033E3049FC642E5C5F7D9CC6713A96CB7093AE
      A320123835E6F33C5DC046914B184418CD53D7FF0D86355E495069266E188DE1
      3FB8002F19C323F0060FBEADE90B7C48D259320E23D8D13072014DC0A775820C
      6B2C237799C633E07441E48930848640C99A062284BDEB43F363B871B98A3C8C
      667365E09A56909924D063CD50C69158438B32DDC0CF125E324BE235F4399E06
      2976344282A71BA03B5939A2183A1B019749E5782AB07302F430B8EC5DCB2569
      46C01F7C98C3355E1738A72EE88712C73376A774F30AD665389ED31D48B814B8
      AA9BC09DA977E512AD52E82D3E344D902078E1CA4DAF27D7E3CB245A263212E9
      D8736143C2820B818E0EAE9C00F6E3D24D41EF136C32F8D3780D0B79BA48A701
      28908933181DF5FEC0ED0F6C689588749EC429A8B4C0CF41475DB89E9B7AA04E
      2E69C3417F9C31EE3ADFD1FB0F154671DD1BE3CC8B6473D23B1DE3CCAB8FD011
      798D1F80FCD15C24829EC6477092500FA5D6C4D48525EEC104D20676480645F0
      13E8C37DF8B4F292055E403519BFB31A8C2698653477A3194AAA28BD4E5DA7AB
      04987A7800F38C8F43673FE9F9217C02A9F949CF8EE05358FFCD07F9A78FEABF
      79E2B4FF286BE6980850BB1B373575420DD59B889BDA39BDAD0E9DD5E9102EF9
      9D2D81F0498057856E10396A6D8FFF097B26536040ED008E4DFF4E70EB039B77
      F92F081C58C5F8046A066AF9024359BAE172EEE20738808DA774F7385ED182A7
      73596F0CBC6E255360B5F3145E13D1814B6B57D0A06B6B35A02FA5A1371F4F3D
      10B8C026E06938CA0D80ABC1C8FABDC111759C6FE8A120A45FF1C761EFB44F1F
      A602EE03DD3186BBDCE9B07F0452771E585FFC89F97234F67057D273D1D26A22
      5A62233025B9EE4C748F46A7B97E8C27E3E96834C6EB6320CB7C7C098A0408D1
      E131F040698F6F8C1A477EC0AA6FF07CAE63D47FB80A83FC79EEA64FA403FCD9
      8199BB7EE907A933EC0EBB47CEF3971F9FFD27AE77E0523CBD7737B1FDFD26B6
      8C94C3E3DDA404DA11292B0908C3AF22E10BEC2F2AA4CE424809FAA1B35AA222
      738794FB1C5AA95D30CA138AC93418DD0A853ECE85E36F5169EE4A6722407567
      72F95D45B0EAE66258A957412A9CA910FE04F450C79DC0E27160E58202E1A4F3
      40D2E2EDE095751086F01E07F5AEC87167C89F5065708229FD0CBD58C2712088
      5732DCA8BBD2D8D9C4ABDA1D7A052FFDA340D6A08CB2C11EB4AD7CB319AA830A
      922B8513835658ECCBCE8E207BBBBD8E20BD0CA95D79297CC79D82D6B286B52F
      15A981B6ABD02FCE05683BA9038731782CF2A9193711CE0C14C019CE83690E3E
      2F93F80A0EDD70E3C6813300ACF89597065735989CB554F00D0BDC29B000AF84
      5939C002D5B1423A309DB024241B0EE308680A84168A37BE08A40767AF6EC318
      ABC8FE7C359BC2714D368CD066846CA8C6D59D88659C00E37302295742F27A24
      8E8864F3BF5174FB5DF97CAF534BC532A787C2100A9D57DED7EAFDAD159A7CC7
      693CD3A1337E323919C3B1EB8F1D7398F3E8D69ECC82D30D9FAD31BDA1DCBDFC
      F1F1BB99E41ABCA66DE615F886CFDCE2C039743CD49F71DE415C2C5EBF70E2A9
      E3C21AC09F1D3F86F987F3277146D2C5D44DAB280D4266A58E74AFF0716493C0
      9D504387AF5FE122A9A451BB06154B88F8CBABF7A35F9D57EF9EBD456DF5BB37
      EF9FC3EE71D6491CCD6A49BDD2A9766E9D90DA12ABE9A8BED7DF6B9F349ED2B7
      7EFAC2BD0A9274E5864EEBE738097D3278B51C90460B1090241BC5029E73938D
      0354134900E2138D452050DD8817B4B2D139F0EF4AA8D5BC633BFCFCE1CD0BB5
      233E6BF0B73F97C6626E3685BAF08567F386F77EFA7CFE3C47A55B22EDCFE3E5
      06F42B47FB339CF63A48E7F4759D04C85F0E3A4EEB5D8CDAD7B3306C658C6A1D
      2797A46DF37C49671ABAB319AA7D1274FD50C06B3F6FC8B73F89CA516268A9BE
      7FE1292C7DEBA74FE033DA40D60C0611CC4F1B05C33296329884700E008D1544
      46003B17755879402AEC4F018816188BB370374E1B386882CAB6070707B80154
      ED49E846979F35CE66DA4AA7ED15EC10D81C71B67F60027E8C70766EA78F5F4E
      96DD82E6780F8AD8345EC196986C32E3034EC3B948523C7882644A526F05E73D
      9A8BF53C806D839B248CD1F48E7A854CF144EBE22153C00D82CE811B75908D9E
      A48DCAF1B92AC7EE29FA50F928F0BA78E13CFB29AF1AD31479618C9CF176C652
      9CABE6B85F3A2517C28517D0F1E4FFC63039B0C5946DF99D583736004DA6678E
      644209B42621B5FE85D4227FFA04489459015CDF67BB1732A58C9424C445620C
      50C5210C6808454631AACDD0F500863B0730749EBDF9E8FCD9B9B87386EE6C59
      59D1E9FCC5877BFEF1C31B18EFABBB1FEF34F6569226DF5A31B58DD2B407F104
      066A1D5A3693380C6139917E7FE76B4611B1D771FEDCC1793CBC7D13F5BDED87
      57C3BB5F1A5A17013D3EC003F8758AEACA34AEC17F604DC132B8146229D5BA42
      C9394D90074183DE2A49F05C0F7F25DAC14196E2F9E1DEA8FB324A29ACEBAE95
      C78CC436BB2622D7A4A0261D7A3FAC7668B2D0F795089C3C686915912D44F8B4
      35C8B02795234BF0D7B226D4738D2FA25A3941A90A5BE57B77315925335019DF
      8A68D568259A3E2D24500BD77714AF1DF7CA0D428CB24292E1C2CB93AD596F35
      E88976CF1F238C50ACBCD977BE0FA2B4850E218C79CC1CD24EEB19D0C0E1B989
      97C84D9A25ABA946664C9BCE9A8C013246E1A1D3582DDFF7443AE9B4811BD359
      93C64D2631CD9E13417E67742DAF546BCC5DA51387680E48E19BD3EF398B205A
      A570D57526180D092D02FB27C930112807D8B70DA75A91ECD83A1D87E2C9D1B7
      0DBFE9374D83105B8C6A8CDA7770C061CC2D6CACE3826AACB682781E06DEA5EE
      098D81FCF764B0A7CE4934FA639B207742E1912CF303378C679FF68E5FFEEB57
      3D21F43A907014D48BBFABD08DFE11BC0BB4555F2ACF175CF703E92E9720F924
      DAD3C8538F14E6CE4671FC2F619E36B3D370A8EAA949931054729A21242C9986
      BFA7A853B4E1FFEFD562E97C8C1F0ABBF94C35D4A257E911C6A2D73D9C7DA3BC
      FD5E4DD4522414AA4E525B4D19DFEBA6CA33D36C854AEA82261E93F8000279B1
      0F3CD477D387B2F2BFBCA07D895EDD0864418E3E5A6881D08C621248029D81FF
      5C0509DCC0317F6EEA6A9512C3E6839044B2B268896B515B8EBC26016B9C5BD0
      82F158A6FA4568E4E003951232F00294F6A85351DC8433FEFD3B7721DEC17FE3
      3FBAD960DEABA66854132175AB56079BCD73831A660C93F93906F2357B288BFC
      82F59B91AA9AE1FBB1B7A2008B9BF60F998FB3DD478E2B3FB34408BD71D7F062
      1989753749A7F7B4A2F78CD4AF191B0F83F992D1F165B1F1A32636BE09016D42
      40EF270474F0F58780FEC7D1D9C839745A6F62CF0D0338A02EC3D52C885ACE14
      7325C9262C9D49125F8AE82B9CE1EAF8CD9200170917831AE48185BF70319B9B
      4304D956E2A9B00C2F4840F2C9D48DD0129608098B01B92FBC24592D391E7FAA
      8206E543A45E798090EBFBC0149ED271043F103D0BC40A05B20894EE3785654A
      1372D936117B8A8018CE828FA1CE7CF010E9571233F2C68D662BCC2B6263558D
      6950FB1069E3AEF11C03EBAA8B7C259A4975BA8175D79D48F76977E20E1CF2F4
      5C8987BAE87693EDC78FAF4E1D11C149889C58316A91CCB47C47D32212C24783
      E7D40D43CAA15908B48D067281C6537D179F045387D71DB6FB10095542A6444C
      9DC92A08894A2B094B6311C37817B055930DDB8623E161665BB279D0C3AEE31A
      CD5146B92617B1BF0A6D4B31DAA590BFC17DA88F93BF525C03F3093770190E27
      510A94C3030CFB5595C9BEA332C5D6D2592DD11089DE51FAE52192B574DB0511
      26B005085DE205CC68C8770C9AA1BBC4F0B5A70C0F41B6F3CD92BC03BECDDD95
      0850E6C076B058F26F9CB18637FB427A49C012B3B2A313E8DA5A67623E48B1F0
      1F886A77E87C20D1CAF69E681586EAD4E62E978E02757118CCAB39BC55A6B5A2
      7F6B953A27C78E5C2D91ACCD314ED3E63B4419C284D41968A832CB655EB8BEE8
      62AA84C98BA0231D4618E39A84410751C0CEC8285E7761B94E45023C4064D2C5
      B4252274C1FB168F4443906D049DC202DF90D9C7B9201C9DCD4570DD15209729
      CC8B7FA6865180155F84F7E0FC325C4EFD6CE7AD65815D9B8948242EBE0F28E3
      6F54D862B59D6B19A32B90FC156EB441C190A509BB6A98206F9100291ABAE24B
      076EDD315AECD262E5CD39AF0EF5134F903E43C3D359E794DCEB25AE9C8BFA23
      7E0E4DCB601605D3005470E8E80261BFF0451439CE813C922724A1BC8B04E799
      D5749DE167CD3C4D28E26A04D38D8AE28A3664656A29DCB016A74A49260C6C8E
      AA2EE662461BAB7525BD94B97A815381FD77B0770B81C7AC86C9195BD53AA655
      5942A862A8F2A758AB76FB6DFFED6C56C3CFB5597DE930CB43EC280A9252D736
      022D7EB160CB43E7670CE73019D0C814DFF289E2A2107B42DC1369C9720F448E
      3A7B286649513C9CB1E37AC87A1590049BE06437BD4EBBE84F7443193BF23258
      4AFDB6EF92188E1CD9FBF045489605E8D49EAB25ADA457F221573FF42926813B
      5AF9771F28414B69063C0256F83D444A1C3AAFE12C8467AAFB1AFB8DDBE84B8D
      BBCB3B28BF5E691F542B0F8F1FA5C241D7F81B98313C5B665A296C2D810A17B9
      13613FC47CDA7FEE7A97B3844EB66F285BAE5139AA43424D2460AB093E2EA444
      B5F251922D38A4A4298656EAB3502E172A8D974E28A664D28653875E94940BB1
      0E221F0F56E47057ADA0090AED970B689A4F466D15A41F6E382F3AF3C8A1590A
      9847E379DBA1C58CBE76CF9BF2B7B956A0F4D73481D55605E2C195B701936E07
      538D51F520AD752A22BBE1819A206FD99D000C2A48C5C2D2655791762C0420D1
      DBDF9292EC0B6069A4D9C611E3965DA70728B9FD604AA23BD557A94D49780F33
      01DF28D091F828F0477E1FDB92A72B84AB6DE47875E034A84408039E85203212
      C70BCBDE0E347D8570021CA6DBAC723BFAC5D3F4A314B7C48D64E812A4B3F124
      B6A5A861396497053692D9D60EC8478E66D289991F5F447618282910B831EEE1
      78F0576FF9CD35FCEF6F777F2C92F142AC29CD45ED77DB3D14DB3EBC6E3DCA50
      72EEADD91F902A774F14951E7D0FE35DA5D3D37BC9A0474B331B2FCC3E647F58
      C711DDD90D73BF65FFB9355AF40747837BC8F0ED1A0A483E1484E8C92157FE08
      E4E82C484140A29D09DD0F213072E41E3D5945A72F4525E41DBDB361AF1EEFF8
      B4D4F946E897839B50998BEA7595936EA18E4942B8216E81238B1A8DA03CB303
      08A56221142529DD1EC9E966046DA35F022E6919CF0E7F458A2C021E4F44AC28
      1CA00E00022E986EB416909B11503A1894583AAD1F499FCBFDFC4D4BCB4DE348
      445B34C84E4AD03FA80F5ECD32586A9880CA0740E98F62E7C7D7C6D9AA21AE3B
      68DED8311025D4D0E8C1B9302EEB3B08604002C0872BF7A0FCFCE22DB5C6FCEB
      3DE83FCAA8AFA8C3F624F40BE39208043AB72E05D1F59BEACD996DC0F4FAAC7F
      8CD53E4F87032C1E79323AA54A8BC7232C4A78047D4DAF8F4667C7540EAE8FB7
      9C0C0778CBE96034E2A7F116D8E527D44CEFEC0C6FC2723E78577F00F7E1DFE1
      C988EE1B1D1F1D7FD95D7F27A03AF65A28EE9CB267443483ED3CFF1655A7BACF
      5C62B5A138FAF618FED7F05CFB142697C2E385CFA0ACA4E9D4D585EF4513BE65
      C07A9227054DB8BDC6C7EE9E06B83CEFC1F10A62287A9276D8D6848510C8AD0A
      0C525CBB184FB89754B35694A127E5E8BBD329D615C38307C15B387C0C75B3DB
      02848C4D822B9DBBA6A57CA397D630462D96682564AFB509926D981C2DC92275
      72465115818CC6228E3746558ACFC26810311E2215D30C4F27952F55317FEEBD
      389FB746DBBE3EB86D45EBBEB6E4BF55FAE8B0491FAD79385C60C91754CE4D72
      4F13885CB463A938294E5832B0714C27201D46E2209231FA97E097203166F62C
      64F7D9BB8BD7088E847809A94054110CA04D5CE022C981BE5FF9D415C483F250
      F1411D38A5975A6AD4C25D2EF1083D11E91ABDF7A6318E7DE56ED0AB38CCF500
      55003CE6779D1F34F4958AD697C88B79EBCC5D1FAF6EE0A8B608706834C83AF8
      1E9577F0A9DAF5D0D1461977364D69A07E8080CF640B24FA621D6F229B19B5AB
      B03A3732158BC26FCAC04EA955EA8EDABA150F3ECBF29798EBB1E124A4B217B2
      6D804AE602D1E856A59E7926D98B178B49BB0C5D89B7C526A14B77F06BF22BDF
      7B08C4D1D71E02F11D6F6A3D893576877388BA9264FC3315764EC610B22661C1
      7AD9B1CAB7613030E62075108982E125E89ECC631DC1BD897315188B1EAE5258
      359B2C4CEC6B5A533558EC4F6F9FBDC0640F187F1AF026C1A42C45643A4A2689
      BBC9368FA129966383E3149A2161935D5C6E9260413C307481780493B321A269
      A64C8CDA40D8587C486F69347356769930E628D52E0B0858BB1B06BC53A521BE
      DE5D5E37CEC74A51B5D7F036290D10CA3D78B77446F13DE04793F4221C5B57AF
      A44066F9BD0F72EA1F3FFAB82B64E0E6F92F6C25C5AA144FD2C2191525551910
      2365C81351A33BA24BF51FDF4FC2001497A863F2A3861DDAE8FA2B21B78B992B
      D1DE92EFAA4315B5313D7619065E80DB76E126975C4C47624E53605720DCCE28
      E22E58DC254284F80E07F950A03B708370E5531AE946AF008B804E5B138D6D41
      BA66668E82D62E829573B716B2FBDD4535A4E84D1BEDA09024AD4107088821DC
      6CEFC8E65C53D463189638041996DB26A88E1B251BE3089C36E9C108070112D0
      797DA04E2DDA2996850471D0D69D9B7A1F3F3AF49687EAE8F5CD5F75E7EF2122
      88CDB0F74080FB1C342C051190FE734F8E8E2DCE7927413FC5601FCA8092F3CA
      872913378A9305F12956EC272283BA28203106F5736A8B2A35A56D6DED6F2580
      400C229E4837F39EC37198F4D9E2EB29F5BA68FCC8DA4533054B5F23EFA8C430
      A1A090671CC423EBC799138388900111ED992E6DE9AAD566880C49856D11F0D4
      C4950C144406046D07C32317C9EA2712333253ADC4A0B4A2DFD4F77B3043DFB3
      C2BB57D56EA532B5511C5FBC3CE814924172E4E67941E56B16E17C3629223BEC
      23C75FBB7D444511808680EAC25738859523986266DE431EC032CE66A0F71007
      E0FD4B780FB9FF3E62773DE4150407DF073E8299009D2A7AC8034884B8E4FE0F
      1F62FF411C85C1839E81DFDCA51BA12A7BF860C1F6E064B116B3873D0D78D258
      CD563C110F7510A0CE3D70862AD7C27FD8234857C9A519C1E8218E2059496936
      73FF218E004BF9652CF52F0F7108F355347313330D0F52418543E224F078004D
      DC76CE62519DA974F1B231637CAE19E3E4419A319A2D425B447B5C4739FFEBC9
      71B32D3E775B9C7EFDDBA2D9113BE2E00D703B46FCAD1862D42C7FE904C645C2
      5E9636C99057EF472A82E1FDC9B1BE011DAEE42C99722E794AB58FC5B52796A9
      664ADD83BA26788E67586F0397E930CBADD0D29D00F51D07E160B38ACD59DAAD
      847341907A73F421A5A09F4669B0D0781D2620930083AA5D61512E7B60AFD498
      3CE405F99F383867DB2D4D51B11EA20B734A2BBD9082562847DDC49E92934785
      9CDEB92B3373F1DCBD3B338B85D3312911A17ADF8323BB9B6531DE83279B837B
      BBF70447F0F811FBCEFEDF4BB5E9EF91165C6D903689028F56B50061FFE0560F
      0543D79A1DE40B89550A6B0084A88DBB67B03665ACA7B1669A3A2D1DAEB414B9
      5A4E1B3EB68821187DE5003774C6BCA61425647BC34D865DACCB0558C0BC5F26
      A0A50EE865F8CD5F75AFEF3EA403813C7E9EE3DC3346BA4C519CD880022C4C80
      FFB32CD8AA1E19E62BC750109F259928F20834C0CA9E2C9634C533914F8B30CD
      1B54827BC09BF92B4642FCAD1B44C13D4C90E2D966FC81A9D5732936B405B2E8
      49951FE2C8AD7B287211A3A639AA632F3FFF0E95613DE748D040DA0B80513E38
      6595852BC658BAA1E3CDE3C0A3B08A7BCA11DE1D5641D9FA7714498C0724AE71
      AE1039AA0D8216E11548B30A4A558A8F4725D62B95B34FD6BDB64385F3193C76
      F2CE8E35825AC6EEF81B0ABEE58E53110877C140204E5B8597EDB7D96F9721DF
      E366C768B35C7C666D9974BBFC0E6552E54DF729B40E882F717CDA444C313B8F
      15AA4EB63A09BD06384ED15011F9167415AE5CAC23046B711223E8F992D0AFBB
      CE39EE2DB3977413E93C8957B3F9CD1B0C1820F2599D7627796DC32B482016A9
      1594100C6634B84DA28136740F1071C4A1F28044392658C0306C23CF809ED649
      BCB202C40BD938FB9D2A77F74447382A563B0BE3099DADADC3661BE776990471
      12A4FC4389427460B1E5FBD030BDE5BD864AC7B71F2E5C6FD48734A3F73AF6DD
      C53FF6891EBF654DF6E1448FFFBB4046E6A3C7AB8DB049F73E528460BBDCC7D9
      068F9C26DE1C99301A5AD76875C692ED205B274108DCB573F72706C33F6E9B2C
      75641B82FA51CDB1244B6BDA4FAAA1DCD2F5B4F23652ACCD4220052A9F0A5474
      04FBDFD876D3BB3F9F9519C0EEEE887683899829D5E1C46E86FE9D1895717A3F
      F2EDBE1305BE8CE5B4C6C05F24EE2C8E267112752BEFFD7266D5BD76E556810C
      27126E62AA71680069C6C624684C446E410B5B10612558559674122BBB3DA9AC
      E610D3402E7E79FEC4A0A65AB5FF46076BD54552E4C767B9AC4C0325F20DE75E
      6E255FEED7F88ED34BFE0DFDEC0DE770540EC3C0DBF31595B7515ADAD6BB8F8F
      7ABDBED3FEF1E3ABC3D383C6B5AC19C3CFE870FD4A0CA177A3D56486502CF285
      D5AA0D333335D4512124286195360FCCB0E16F770029DBEB7DD3EBFDBA5D9AEC
      1BE717E5AA542CAF7BF1F1C3EB77DF5DFCAA98425D1ED3EC78DEF15F93727D67
      87194CFC25AF1016A87F92C1697162749C661163CD26FF829B3C539D4DE041C9
      6E76DAE482D1CBE6A091E237EF697596468BF003D8E0B70C06CD4E138AD90868
      873B1A3887C17632109C469ADF9D341FED96E6D6F159C8C5AF5C698BF531A77D
      FEE11C085DD5FC37CFCE5E9D0E9FBF7A55FBFCB04F873E8511DD6A072EC8150D
      27708567D9303BCB962175D80155728ED7C65F4D2ED0240ED19A81359EF3360A
      0E4D59B8970A86EB09FA6DE72E829526C01CB8221FE2EC19CF3FA9910A9D7337
      12E8FB8B06E2BC72CA564BDF45DB3A2BF1DDEF814E484DBF0B971B34EAFA42AE
      0C8D7AD0A051D75B88CF57B369702D9AA2A52596E144282F58202582C8027314
      5CBDB906A0C3759372B333E5E6EC6B4FB979FCE83F8E4E87CEA1830C0583E7A8
      AA24231C662896F44D975AA2448D851B31FAA18465E27F85535F6FE42318B90F
      AC2CE5F018C6D5460D80E20CC5628921AB08F5182758D89436C80155E3C46847
      490579A593AE63E358F1D976C8D0DDA02E3CC8446AA0CC115086A58C1F0B2C34
      030C6221A8BC0687D02EE2882A92055C7C267465CA156228DC1231C9EB006F32
      7CB90CD2956B97947E68D43A066A5D8ACD24467663E2AEA8A473122F694DE080
      A421E63A4E2E1FE8584F60AC86194CE210E326A26C994C57C816308C1E164CFC
      4099030CF31459839E3C4E46D118FC4B05D917031910C12FC341FC3798DE337B
      DCD87518E13C4E827F61524E880222C674448458C4220FA0E0D7B1C1E2A96912
      A769BC58C432E5E23D0F9340673D20901BA67FF65689A41284570221F5759E10
      81525AE59925102A5C2D22CC0842FF39AC9B099EFF9BC3CFE71F7EFACDE1A739
      FC7CD9C34F73B6293BDBF477B392AFEC7073822ABE4C03EF12F97212AF73329A
      63EE909B47EE5530231DF42B9CEB1A62E90455D00F5C5B601ABA8C438CC3F4E2
      255775A47C4650CDE8FCE627EE8C52B7229FA4FDF2A1EA6927A88EBE705377E7
      A8FFCDC67AB67528A32A3ECB04B4ED42D8130ACA2D946E8488A803C37278CA98
      0C98B9B14AA7F0151D6A5874B911B595C43388354DB9BB2D74AB601651D845A4
      122F8594E4B32651BB707D2CB9C42E0396CAC55229B98C7BC404C27CADC58ACC
      118960960EC74ED8C51A1BDE8FA3FAF9FFD6DCC1D1CE146317110635FA18A39E
      203EBBCEA512D794A17EE7EE768474412ED0850EDC53F1654A29243693B20CBD
      6D221C5652611A9F94975DFE92D106324BA4AABDB29E2954012E4B8BE4636FA2
      AACC8607C88EB30C852B85AE7410C629D52AA38A053A389BF347153E02A64CB8
      722E94CD3288306725847EED2A32D470EE9AA74C2CF50402B9E1DAD95109A47F
      2BA34E0B98AAB7229B47A04BFBC8381F369BBB1DA8D9541EBE057347AF3177D4
      5BB13FBEC6F3FDA2B17714A18DA85C3A6BA5182898D54B9FAC8290A2E40CE954
      754BA502B95E1A5C5120874AA1B591085AF4440B5A9E30008162022A7A862EB5
      032F8E341007261D85628AC7B424C222C53A03099D41EB20F2E37507B58CABC0
      A5EBBA53C84974E3EFD1BA5A63E0D17E69F9A5AF8AA44E8A42CA2DB1D031EC4F
      D57153643EC5676BBFF0758446712622BF95F11B148A8EDD17CE55A0E6398541
      0A5C5564B38A40097D43A50FDB3EFA6C13C69D8BD17E0F570567B572D8D901B5
      FE026E73DAFA577DB77AD8BE995FB80F05B17FD5259BB90C35DAC92F7131A0E2
      124BD25494DEAE746E06078B97FA1726B4A603889F392795AA127D6AC5A92AD7
      54E9968BDAA2035BA48D12546F061D778D76143C9D5195E9389A86010139C2F1
      2869986A9EA96A250869A6198256F499628EF488ACED09E19CD14A4D611F22FD
      98DD4975A744B647DABC1B7168630D2BA7C297D33C88A690D0E8BE1053C09B4B
      603F8D6358B7F3949F3FE0F6F0C9AC2533E61C4A93BE98E1E515D8302E4919CC
      2278299E40BD1A13550D76A556384C4BBA6A0E4BD5147D236622F277B18746E9
      2A9EFA51C2511F95BEA399C44F011F350D07D1549DACD2348E54A04D1ACF66A1
      6020002ACB4E881414E6ACEF4FE338548C443D8487318A90CEB01441C64E8288
      C36CF0E9733D6D74BE6BD3FEE419E41D6E7EC7A28CED6CD7D671F7AB766AEB0D
      3F2B383F61ADAB0592255E8AA8C3667CCF46C49AC2099402BC05744EF1072667
      224833EB288532F508E398EE6BE786FCD41EE0816E44BD5F113390FA4D0D4BA8
      9CC4EFA18B872F7E78CD92B0E1025B5A420D518E6C001D59330EBCCC93D43E18
      28A85C95D28FE21F84B028BAF948D3A01FA614C448E9CD5C1EFD6F0ED0FDFFD3
      CB5E6B210A43134BB13A0A683C580025399CCD1418A7CDE1B9AC964F80C0D435
      8C8B54F55761F1E6B56FEC056DC47C07616FA59C7041E79A3A1183D5670BA7D9
      B0B516E6CB8B378D8FAADC50C2918CC65C82DB042986DB536F1BC2ED990B4CE4
      72DAB05FD7286614684F57C8D0423867B91C2C0CBAA68297861D976FBBBED4D4
      4FCC328056D6CB2726A38E6C03AED3226DBCE5C8304E33F59DA25CE0D5418270
      968BD72F24084C748FF363D8A9572FAFAFAFEB0069C15C7BA2EBBCBC76697313
      521136801899585A00B6872AE6BE102E2820D9B9C9067BA61EAD96F871703474
      5A38052D33B676AF87BFBC7AC10ACAA877766C4666EE79F5B2A76E7BF9EAD5AB
      034D0837CDA09530767B2FA390997674BB133B638C616ADCC10CD3441D784C3F
      D06E46BF2A78501C89B3A83EA818985D5C5C894C1D3F9805EC08A2F9A07922AE
      FAEEFD4798D944840141AEA882DA3EBAA51688F667F5CD8D36E81FADBFB22C00
      6DB47451621C8167D0D194113429F29F9D7F2852B2AD413DDD18CEAF81D4105E
      5323BBA3699B7D545285E044CEFBC96F40D2D72F3ABA323683596624507B0E49
      50634562437F73FE27AD01B3E2418A92111269C34112993CDAB19BF6DA898A51
      1870644E470C358D3049C0F80DE537F70028F77A16C12280AEDE87D794C84F4B
      120F257A97109FA1AD819C09D67D807DD44ABE59525AEF29B0D4FB40F5FC418A
      951FD725E217242112C7DA5A3576448EE8CCAD14D5B9000BAC520DF0554179C5
      C931DC42F2C35303874C1AA21FD3D627766EEF0DB5856DA1D0A8695533F70181
      1845849935CF37CEB94B27DA4661DB4D1E1BB04E29182CAE3C970B091136365F
      22A7177B18E85725E3E2A8F29D881A2318716282D116CA7DC632FAFCC3B97168
      312C07C2B0224685A7C0BA3981BDB6748111F2412A8E74C61DBE99FB0C2F4D04
      AF092C38344F041C0D43CA3DA39828D88F9173042A9196B7B6EA0A1D4B84F2FE
      29F4ABD4BDC44FD9B30310EF20CCFCFDFC683698201BA3A8A366AAEC79AA6C10
      F14189C2540C82A1BB903305AAEB1DFCA4C0CE29948C68543F3847562F22A5AD
      E72DDEDC295516CA19FF8E7C6DFC07A2383079D589C056E7B8CE00AF4257C5BA
      71A0598AE004AE3305D508F4B7552A54090364F61A49959ECE947C57A9CD0926
      1BE2BCD6D82E7AB1E7A70093F03E6196ED6DA34F139680EEC284F32D385BE4B5
      4C615D51249D2EAB036F6E61FCAEA61E3138D1E26D09878995ABB11CA8219077
      F32D9036131C05ABED13FAAF511E4A1437029DB85FD5ED05F489E8721FAADBB7
      D5F7E8C033D8137E2071594A622C9E624CF7A1A9199A21D0CADD6B6BDF62E8E9
      137544B4F709B02A3853498AF8C3FD8DBC8A2EEA737029B160D45F7C815D406F
      EE03885B938BA861934B096C2DA112948577BF01CFBF19FF8EAC67FCC77D20D8
      7DCB6C4F55C3229F5B46A14681AEA2DF5B68293844D5884C41662D5161046509
      0075C9D6012ADBCC29098D326E0B55855C65C2CA88BC89A174B9AAE5AFE8E8CF
      2A92B60E8A046FE02880054EE4923C8538973233ECB09383CCAF06463D8B6E3B
      FFE147743C2037B9728310E5933AC2A2CC9759560297E98397AD96DC0DB445B2
      B5B0D966956AB475C421B42D3EFC9C7FA87CF27C3868B653D976224C3C7DA0B4
      8F9174C430AAB09BC51AE4F1DC492BCEB7A46CE2C620A4DB501B9021CE5CC323
      95969DA5481A2F7B63BDA90E94C9CCF0709AF6C3C6765358DFE13681B2837C22
      D64990A6E829CE8E18E884A8569AA49760F4077BA6D95B1E115E207BA81601E5
      D51030854102543BC7B24F72F14A9430A64CCC7E052C2F2CA8E10EB5F6F1E5C5
      080B740F5581EE773FD93408B0E26C12A08D879C2DB4CB29AC6E43A24876A9F6
      1C3472F4F4E2E2A5AAF13DCA800B5533F7621E5F862B209AECA6D7775FEC2DA3
      8BD36667ABF6D6D5397F68CF541051A8BBB05C140C196D0DEDC07048456C9CD5
      ED07B9B4100742E8D9BCF3930BF6923A79E39C6C9D2C6FBD0C09CE8DB55C3BEA
      746794B5BBC72C1672712FE9834080FB186C781F8335A640B65F2B236A8A859E
      38C00919AFF1F6BD659F9314A97249B1551763060242C2B56DD77BD9F972FCF5
      93D03CBEF004F5BB5F09A8C76ECD6A0F508FCF5DCABF57D22AB3B2DF3E3FFB0A
      97C6402D8DBB97E63F9273A236A3BC55CE7188D2E216603A46B7D19B61B71E44
      C7FB29287A811B3A2FDE9C23AF9A6BB463C57B0E6D11F8152EB5D197596AE3DF
      6B2C36DED5FFEFA70FF7B6DE08A1FAA70F3C3F0A0962E4FCF4E16B5985473557
      E139D5518453FA79B89A68A7C317588C5F628CC735C7A895050CD6B2ADE0F73E
      80939A0388E2E8B06C108D6100E3F7A6DA1C6599E8AD43598AE65B15DEA84D8D
      182720F423AAA02B1F05E388821D28AA416587623900996675480315D919A269
      7963970863A5337BCCDCAF5F839E7D6550A6A20472F7F4AA7091E58A9CCBD039
      2A341BD4496256E1B8D8E404AE5E3686B74A9A218EC75B9EAA0C91D707E91CCF
      9A8D963B1D6D9187368E89A83605EAD57D6815CE9B3A5C13D782E1826E82E8BF
      FA37B5895D9FF6306F39D9715A5EBCDCE009B0DBED5244628B0D75C122086166
      10B38C53D50E3263A065023476C1FAB9F6C6A5B482A364E5ED144CA5ACDC8A87
      A8ADBD89579C892E0A6C8187B6CFB9148FC4895000B10ADC0ACD7DEF39A27C16
      98C331592D31CE47C69109383229F3EA584CDCF0A0638463278BE36C4FF3F617
      B88B0CD3EA4D64E4CCCD29074DAB70F31F12310DAEF73A7153A662A89BAB7C44
      EAE81B60944045F4C049763F380243D1B9D43139380AAE876AEFAFC98C48E7C6
      90A0268B6392C8F7B11BC56AE70624C478E1DFA6FE891CE2521C2A548DFBB24B
      C11C3C4929066A2EBCCB3D22E85EE5B883DEFA2CEEB420556DE63355AC7C18FA
      9D4CEDC52DE5B4AD29FAA5FBAB8DAFFF4B65DFFEEBD7FA790FFF80BD4D862A15
      5847D1283A4C804A72FB1CBCC319198521D57ECD8B78852F380F11961448779E
      26E19F5F22942353854941D19E397411A57950305D2E10D10B63C9DB83393893
      EAFDDFF748C005FE6A187DEBBCC89C3B5935045DE980CB2F696E485E0EEEAE2F
      64356A014E6F1628C85E4660662E06B6BF7D6AF8D6951B221E2FF127CA1AD9CB
      F457635414AF20D0FB236DE07E69CA1D34998435B408866680C97B72616888B2
      43EABDEC604C32F286F38F1FDED06CF8BC073CDC034F1A7DCC0451D02A578037
      FB50B3B2658BDC994A45A0AE5DE785855D3F7543B9C71663070EA5EA73E407A9
      111DEEDA02488D32602E429F4BA3606773EC8F8584EB79629966581F2CB43BF8
      D7F90E64E2927DA56D8C6C97E9261407EC18CDB62C468F34C01D35F06929AB15
      E5AE764C766773ACC9D06402171DCA4C97AC6AB8F65BC18C279BF5BC3A111D9E
      698B6B5CD98ED2B0319A9D53033C8C9123941E9D30E9073EAA5F268E5EBD3FCB
      BAAA7DD441689008A3A9F4CB5061B0C7038D0632EDD8AFD1D1449481B787EAF7
      92C7A721DFB0F3AC8374345481499A452DEEC69135DBB6DCA89B3BFBC654990B
      9823F146D9ECDD1D873E451AB4C93953D8B82B4E68B2B2840CB826AB97618C87
      ED6021382E1F6F9BC5147B84FBDD098334C5BD8457EC53F7120E297B1C8DA13F
      583787F1EC52D2DEB190CE1C88CD29CF7B8C4D4D7B27B3AE441BD69279BCD2B1
      300918BD903138144C306C4E04909F25AE16A18E47CE8308762F9EBB75042034
      EC12F68E7977FDE42AF30C4F85CA534FB1574C7D9A144F7029B0365A4ED74184
      60AA07A6ECAE64B823056BAC4C050AFAAF3D119EBB52C71F99E2F9898C0F356C
      CC309D6A2E2432E47815A526DE8BA0C84CA559B2091F74316279CE4474692094
      1B64DA20361EC5B492E02CB7448C6C2F58E2A9090BA269BC21CCD167A5850D4B
      6A3C745001D2988C7B54C49491E74AE7DE230FC5D7AF969F3203F8A608C5178E
      4268E49788ACEB8AD48E322EC5B0B70354E9176E0DEB8548D4E4D4EED5E347CF
      30D2033AB56643181DFCE17D9A4C76151658CA7178C589634B8CEA5340D8941B
      5720935A167067B65138461CC50F1A9416CB74B32B9A55A7E52D97E186D3295B
      AFC81C45275C7CDAF4ADD5B5345F05F86130D1977110659B125D0FB827E1F05E
      CFF381881D114B680A876722E1DB806B3F91CA0FA2060594515974C65C901190
      F605118D62877D9FCD8514E5087B4EF74A8F8EE702A8BDE22571D3E819CAC3BD
      1404E5410C52B872A3DC253002920F8540B90EB317A18DC4684D51B349598C34
      C97512626A9817EC95C48787292E67045E9921A3E19E100DB275821024B80768
      7323332D2CAEFB525406B7A3A80C4E762B2A83935B77BB30BFB92878161A0525
      679AA2E06306D6AB3EBE2B2B2487086B11DE5166B1528A9BE07EB565B3ABB467
      B5BF45F91723E33393DB2DE11E42A5882AF8C5530E8BD59AC65ECE81AC1306F9
      D3B590FB644C664514567EA0D059C4F552635104911F80268347A9DCCE258F4C
      8DFCE780202B518BABDFEB7FA8FE4C1547B41C11F86AF22B03FF0B303A3DA0D3
      96A916A9FBB887BC5609C9E473E300493B554D1BA0033B9DA9614C9507554294
      7EFA82F39389A21F04C926B38A1AF6944B8EC74D729D322679BC036393B841AC
      5079117B4A9116962DC3776794ED542F7BEBA80207B65564CC7A8871A5B39142
      7BCFABCC8EB5B61832072C7AB359DE371BA466DC987DC86BF6C3B6B31E71BC38
      8A3DD63AA4656C8894D16B2F71C8C820280D3796177560029672514F3BF3F03A
      1AA829527EF35A8684C78F5AE7F91174BBDD56B6F7020DC89DF1012ACB800288
      DE427ECBB756C6ED8E3395C6CF559051E4DEE497163417788D54471E9586A51D
      7336B8B9093981F1223830250844790E805685B87E6D260E8141F0139C033A01
      85714C28382AA9B206250D9633C3D9A50ED6724A9DA181DDD101116D1575F667
      9C606DDE38E896725C852EA94872B5C57FE1907AD324762C1B0395E941EFBE1B
      AA72665B33697098F38CDEC241E679346B8426349DD7D842D541208F1F45EA90
      AE03B7B674D050AD101B448EED4788DA124C56400763C9D0A457CAADC6E4A7A1
      51E6386D6AAD6AB2D33D436D520DABD4C1893065BFE9CC6F2FDDAEF38C0C0778
      DE0C12531E0EFDE089BD64F3EB5D83F8E823B15B0F5ABBF28E1D5BC1BC0B77CC
      FD39B41F902C2C10B0118436B32CAE2EC6F722534FC047C3DC0E42A999ED1DB1
      FF81E81DDBA90CAEEA44B0DF3AC7C15E47522469D71C5FD58D589E9DE01CC849
      BE8EB6B81E30E273AEE4FEE3D279AA3FBFA013F3F9877368A806DFB23B4580BB
      2A52C77ED9C53C98A67FE66E6A746E37B5A289B58C23194BD6337533568E8F4C
      69116318A4DE05D3B26610C2BB183984B1461FCE356D541C5BAE972FE8DA3EAE
      463BB49ABA940F2E70D89C491DA8961156BCB505A3A73877B8C9231770780161
      FC5B0492DC8D0E2391AF03E519C80864A51F7282E1DAA55ABA0A95A9BEE7D3A5
      BAA3D42C4BE20C71848A113765C3776518EE96025F55D97013CE7448C52F34EF
      41C4650B9C3FD677E92817B5804C7CAEE19314E3522DDAAFDC3030C2F96B5A34
      D5528163BE0F9DF745DD4B676AA87D9273DD3DC8A15EC4ABC413B8328A8A6671
      AC7CD631AEC9CC9769CE4B84465E276687C3B039544AF9B7B84894B53AAD95A9
      A6838C864059BCA8E2A7A1776A00BAB34569FCA02603083361721CA228B2A96F
      D2733AF9BD88212ED1C3DD698F1F318CB7F3E63D8F19036BD4D45BC2D3169076
      35806CD9A9D429A95748E59BB7164CC12862F00BF542B46277E9414E73F8E693
      72AC0B641FEC99F13AD83526387F578AC4FE68F4E932911EAE2B1483F0AA241E
      899AF96A64E333C670382CE22AE4118F4DCCD702E36512348800AFBA8D1D77AB
      535F63BCB0EC9F63C61D8C18B92D5AA984B7CAA53FAD4D2400C5AC53ED2A979F
      02253CDA98B87D93C442397CC5DDA92A45B8D1A60E608D667351D660FE6553ED
      A8DAF9328D40BCD9DDD0C7B96D76943A58849B32B52D82885A607C99E68C9CB3
      E9E20140AB3B5CC28D0E5A64465316A2051773D7472F2AA14287BFC98603B539
      7C846F354AC3225EED119FFD5C2DAA6AED33172434E1504E44D64ECDD2990508
      CAE2521E4C91FB6B832059DB302E843704FA4445D21C8476F1FCE1D77F10FA21
      671F7EA7ECC30AB4C758398C9581C3AC44AA9C010B5134F9983803EB37D5481B
      41CF6516137CF020D533A2D3792EA22F6626C96AD61E9C1DFD4B98B044611644
      306DC70E83E524A6DAB1C6B44F8ADF848351EDFA4DEF08C9CE0FEEB4F4F157CE
      9E771AEBB72DE69440D7D9E58BD0D6742B2B71CB1F5166F4B48A58073AFEB30B
      4FCED8813865FF0BA9D935D68A76791B1FC59E850F88123AC4C4EA2374B8550C
      8E68159C3E68F0CC2521E28CCF28775747EA44628DF1766406348D93A92C5F46
      8192BBF329A78D6FA23C2F25BF5C1A2F7D29656817168006E9F04BEC944CB60B
      956836E1CA477B40DA596FDBC7D52C95CE847E5E850AA2FD972E45F166D674B3
      6554CAED5E1E6D460C604C650615955E124C322B401CE1E2C7D4BCFA9E98F718
      63BC45659555A1CE363B09CCF704D2D848F3750AF749E657A11664FFCA77A5DA
      BD902F4F35119CF2810E9B321703F5D3242F09C48C95B91277056352C3B7CAFD
      252AA1A4092FDA16C492B38F5C99858E2027301CA07A69A3571003DD9D1625D5
      9444F4140AE7E4034EA665413CFB80ACA832475C7FBC3C2E59D92A71B3C93CC8
      4166A9D54A2C7194A282E65200AC49EED7794BF980FE6657566351A0C337DB96
      D571E8CDBEDD63DF5ADB923DEBD6DABCD39D998BDBC836A316CBB41955210186
      39CACE29BB541236EB5300C13DE6EF3EA06D4658AA3A6AA3D940BB365075645B
      C50E63BC5A0A1C815D746F1BCD0E8FDC9286454B4295EDC0CE61847B4580412D
      98634AE1318901B4B2C264AACF30F0EC9E3602EED72E0E62E869C66225E5E8D1
      ECE8A58EEFB1B94B75DCEF9EDDF6E6714C2F66434B2E5D884B2FB27758F78FE2
      978C75C3842F6948263BE7BEC12CA89E03E8BBD33AAFBC0FAB18277A5B08BFD5
      B0C7DD68408A9E4572713021D5C63ACCD207422CC145055C7FB9FE5587E3DC8C
      FC73D475CE55642067F2F89C91905283744C269FBE231718419E70F383FDE0B8
      CAFB49AA3E67CDC19BB358BA42E1DAA85A503C7EB42343828C9ADBC4B3054389
      3DB363B2EE730715DD2FF28E22A1F0AFEAE4954A07D893360C4FABA2D6B76912
      068B80196A162BBA634854D42C555C2CB3CA5E056E51E2556BFB3A0D6167D249
      185C0AE5B66ED861252D3F985A460C7EFA8B2E67F76BA66C67CBAAE182B9B30B
      83F7EDA253B683DB261DF626E52E974273B0A3D4D43ED60E02D488D70CBEA03D
      7EC48FB1AEF1F6D6ACAE5BF5F851EC8BAEF31A3B94AE92883CF05CC61C4DACD2
      14B032961118809FB8B3996650CCA34D3D2895B8E378985CA92C2A141A4D5764
      2E282C81F7E43898D67E59AD257C06427ECC401397490C045F5816763D1F7B24
      3CA394E319CE4A3CDE34D518645E8392B6A8233AAAB3AD2A2A49181737AC2B42
      05B210E674C425D6D823E663B030F57253AAAD4E0B4787AC5DBF92745D8D6CDC
      70CC1A1C532B1FEAAF447144382B0D77D4446210251DB483B4D195CBEFBE4C32
      2313A8B9BA0F14630470A17ADA694199839E55DBD053AEF4A7FA5F9B7F7DAFD0
      3839C38742409E852AC7C7800229AC2BD6C6D018A0B3D325857905D3DCBB2D97
      3ED1B4BE4C8AB48DC073A53ADDDA5042DCBA06FBE36A090841C249521A53C9DC
      E826AA034A720468F4A3DDA2C27B1B2E562DDE082899914C54B045C3BDECDCBE
      1A92DC8B170B4E6788C83606CA0A2183671061CA5A33779594CFA063547C0BE6
      5FE480B56813B42D2C71756340683462B18C813A9B0C4173EDB2FF7215C1D94A
      ED670C6B47EC6D9F01AC384C4B55A83B50897508E6A675334C06C1FC4801473D
      5076DCE5521707311BE9CE9936ADCF1744AD0B20E79DD75E7AFC884D6E146EE4
      92BB3D3A8C7529ADB6F9F42DD765E5FCF98E63AEFBA1273BCEF9B93CC8456463
      F9260EB5DD41ED312DA43BA7F5E347456A7FE362BDABCE042B34763CF87779F7
      B5AF32EA1B0C399514529B9E1C314EE9BF0B17ABBA7BE1CAAF95DB64A6B160E1
      6D044A65200530AADC29AD912AC6A96D238CD7A8F6B2035B038FDC8465EEA682
      231482E87019BA1EC7D3C65CF5F735C2A7620515B5E2A5CAD53BE838AF6047A5
      AAC433A5850422F4151421E23070A3595B8CF745D8D2E91CA757EC83C37E6159
      28777594DFCEE78210D3031D3F81632CA5C4E3B62558C9654CD8B6B01955EE56
      5B90F19134681858652F60E476C19EF96A8680C56D73A8A74C1146B074675190
      02C50ED0BEE95B78A6CDC62FDFF88CD9AE436070A9357BDEB612EE2010281004
      7A82CA58812DEC00BA21F342C2DA216E9803C50710E35C3A5CA20534BD808119
      48899824C2BD5460648CC72C390DE0159B955C18AF7E191A239B755E7D625A2E
      AB8339370A8CB1D901991D15192EF2533ECDE3414663196B7C6DA6990DD2E1CD
      03B14FD2400B6767E314B081CF35B8F51B380D25B265DBD5B96E12FA2E6F7C54
      72093806DDF6F370D7BF78A9BE0D5F207FD54FAB1F5FFB28B83C37FC18BFA5F3
      C1CF4050FD44C7C1A7EBC04FD1EDF8283F62BF700F606BE444C3FC60290685BC
      10418AC672DB90AD4FB01459EE6BE3DD76034EDBD8A839EE1AB5F503CB28DE55
      F1E5EC29C83908521BD1DB3CD07154750A3A3693F25F780515C3D2711019EA69
      2D1C6BB1D629ADEA449C32762D1B9D706506795C380CB3E6D9B79F001E06A77F
      615035A2D8CFC59CE7A166B23E6A543C4E4AC38227E634AEDAA0156685B0AF05
      ACD527A93EBD64F9F279174006C1AE6F60106E351482AD4DDC450D1AD5087952
      E64BB3A72DC22C93186B88741DD19D75D9DA684197AB9B283636146E4498FE9C
      4B1623F4373E8AE60D74EBD33A23124CCDD624F46B2E15A2968820FF4501148D
      DADE837B909FDBB556835A079D322F33DED39A22B64018FC0B5D686D9733D00D
      83496BF98210E66773A081CBA1D3D2188BD472D032DAAC1E0DD91763C0157091
      6CB919CC36A60B168DB06766ED5AE3D2C950593549BDD6A1118F0CAB2053565E
      BA4A10B35C951C68936F5D41C8A37BCC02B37395792943EB53EF4DC40278BC2C
      EE2DE84D54E7245E23008F105A57116AF1691C93524570D02B64FA3A14C0F998
      1531C034BB95242042D781638DA9C2A9824D4D4AFCAEA917D794ECC9E71AC266
      245B9CBD7AA8DAD47EAB4FF1556B839CAB0DD2C226C535E6F7E3CC59E8B52D3C
      5F392C5A6846DF0890E62D9EDDD6FF59A14279A18559653750AAB4D0E0C1B940
      794F858EBDD92BB4B7F57CE33C77A5F840ABA4A5C00CC91E3389AFF592537E6A
      9D6B64459AB003890B14B1271B91B9CD1DED6F1D3A5172CABF73FEF2CD1B9C7A
      ACC83145A6E9E95BEB975A548CA0D0D10C68B2E3FCB9E31C3281FFE45C8A8D2C
      D6C950BE941A1A0BFBDFD110DFEA986FEF809BE9097C1D5DA13E6FA21A5BFBD5
      5A6244EE8C231921AA588A5278DE2BA8649D01A139838650B6F88BD28118A541
      A31FABD84878156E2695C0EADAF098669E4D762A6511D38D2A6B490AD3BA7EAF
      E2E6355884CE3025975196A0B1CCF9A89A83CD0D0E6D50B755800AA7E6C10434
      0798DDB1D3663BE99CC19BEB3549818AB576004F04298DE84AD00DBAE13E913D
      4A4C1954230CE75805A14F527B6B0E4DD920745198C24C6C75A03EEF110CA3D1
      C424432283ACAD039D0B5CCCF4AC45EE645D020E38F7061D26C6150D0214283A
      67778A09DBD1C12B76B916D69F6DDBBF8AAA9231EB451C48042BCABB04298902
      190963EC882187D6C04CCC29B208B819AA3CEA9D6EBA6FD1A0F72C69764D8059
      2D344B14ED83E9A6D6F491C0AF7C45A220E7D53B9EAEA2EC7D5A1C66A458492C
      43B17DD4DB3B06EA3C4EC83F3C13918A0FE2D0D75D4355554025ED01CA1298A2
      212A5D451678B65A45C010A8B02E95B862846B0E0D751DAC22877B0ACE11B384
      0E1218D066F260F1670EEF820EA04A2079E35D5CBC6C387DB5A9B6F20EE5C469
      29A5120BBFCB16850D520DF8EF09F7BB890235F4FA41471C6625DBD095CABA20
      3034F43450AD789BA09606A649DA759EAB8271BA40171D9C62F2FDBF7D76F111
      B8F7C46C751345609DDA54683AB54BDE9E27B8A9B06AA68D958567B48E3AB790
      7E15629801450522804EBC525935758C29C07222380CB152D9C67D4C8C074F0B
      820F8F884706638DA81ACF016DD4A588973AF3DE8F4D6951179E114B7D8883B6
      2CA6411C1A4D44B8F93952887273286D2917A650332C2D5348372670481F0DD1
      C2A0A262F4A917A863CF9E46C567D6A82A07C2AC21AC00DF16702A8F82D8AC21
      265BCFE0717E87BCB9D4C14DC960BBFA456B4814BB465058729519C184552050
      1DC42491C21CA50C60BD6E2872FEB98269D685D2F5685B746CAD3798FA87494A
      77AA36059880265D2652E3DCD89B8F2AAF74D4522014317D36F992618AD67EBA
      39E685FB4A5DC51EDE7DE045106545F960CE6B118202266F2FF8E7F5DF614A7E
      0616F17AF1228679BC87E89FAEF303E6750A364EF0EA069665A2BC545142A1E2
      3849F7F175018788EA3718C3851F3B97B8C6D6D802FD922018250CACD159AA4F
      3D0BAC114B1E54A9382D5A8DABD7B18C13AE194BFE1B654C53ECAB4976B63C67
      99ECA15302AE5458EF5283656D2708A3D25FDF337701F390C9839D1E38FB16A7
      4D020AE1F3B70F7F072D23BEB8D09F962E94A486935CBFC24E5152EDEC59EE1E
      B4387E5002952CCE64F4533FDE66D710DF7D68B9E3942D6C29AA835D1E3FA2A8
      9DC50AE837CD2CC3C8C0E81A653672AC1C290C4A87A42A3C990E00BDBD32810B
      CA161B09A1DC59934C2743DE4829CBA001A2BD83539A2DC58EC3B3AF023A9272
      1290B2F41DA8AB2106ED51E9702AE3E8535661C318ABCD0E1AE99FDD00D66182
      42BB9A5CBDAD5CAE229DAA65081352E73A17D294F7722AD091CBF886D8B1F8F2
      E26D07FE79C322EA4DECB9E44D5430BD94514BE6720E950B45DE2578031E44B3
      6BCA0FEC6477FC20A6CE2F3FBCF9C7876F7AF4BFFEE857E43EDAB79A954E18FF
      8EF6C8F11F5D712D9AFDB44DC4B6AA02A1C978A04DD4EE0E62D269F8F7CAD633
      8A1B185E2B1F820335AC7239AAAA2D30421889EFC5BE46F9B784547D0F60BE84
      B86DA94D13579562FBA00FC5BEF37CB36570A79D9E372137FBB13C4D4DCF59D7
      7735F6A4D2289AFD663BD30D27DA45B1CC49ABB5318A07E57C87458D18E9CC8D
      A0FCBF018B9C883C4759F314B2D46868356BD7AA2CEE73838D1D47BBC476B3D0
      0B48E5E5F01EAA7E1111565B1323CE13605326225B714D177DCDC43DA818BD02
      5E79D7D1B9B1F0E27CEBD3180D72286E589E508335B6D2106691FBD06C924A72
      FDF2934836BF3A8568250ABD6DF645753A7D7E9D1AF3A429F377F7999BFFC499
      C4838BA7E7F13E92370F55989285A86FE0ECE20CE3B953887333E99E849F8C8F
      38B3ACAEFBEE50712F0B15A74034A58E7694FDA5E3ACAB434137F76267C7B4AE
      AF65BA745038055F72F0CCF6D4B051D2D42E96160C15C60C84AB19F4A69B5EA7
      2640C406C9CA5506B102D4DA2A9A38983AE71F3FBCC123CC5C847E1E2BE1A061
      E555F3C83CFC174484FB95C3571B0EFE891CBC5ACBB877164F2E95FB64ED195C
      1FF05CF8130A5338C1DAEDC8B78D7F4E797FC8B66604C0AEAC846DE03D15BE6E
      323EB6AA1847E14605EEFE18711163FAF68223A733A381CA286A294F42CB6409
      658106AD0CEF894A3955AB9C3A3EBCAC7BDDFB5A2548C4FA2BE5768177CAE40A
      C529B010EF383FBEF8D0D15E9DD71FDFB68072FF5C51F0389971966C671A524C
      A72CAA0B0A9CC34451F0C2C4F8384CA9E290395E14D380BD25ADE7EF2F2E9EBE
      79FFFEA309F087B7635C662ECEBFB6BD8A792EBBA93876BF1A3E318727B94A22
      3C3E4D9DD6059EED71A1AAA5878E38119930114AD0C66809838169AC6340378D
      CAE3C5B3088DD8079C7B2AE06CD67AEDA03FDF4187BEF3FAC9C2219FBE4A35C0
      97E8D81B9D7A0E0A53828441AB5D23752B61051277F6247AF20233E76152D6F3
      3867746DC018CA20A9B6E015747CAE15625D83F5EA9268BBEC11B9C9C068331B
      1271CECEBAB6ADA2B29B0758D68186A1D6C68C88D2DF28B4B9B12A542338B957
      CE02C3C9032B7CA459FD9A3CAF404BF8F8F2E2E8E9C5C54B0603793FEA60C4BC
      4B6A94F067BA3A157E4448814B66F0119F773901C077405482DEA22B0F2582B0
      38B5898D24AF69B31AEFE4F123962C36F627A61F53EC67A426B4836024917A65
      D63B8435A680745F5C6761AF78CF82EA4C0553D2BED2AED3FEA003D5B7041E1B
      065022621ED274DA3DC05200F89EF3BF93F39776AD3B0928BC5DCE57533830A3
      FA99C42B9D3565971D2E0071163AAB46B256D5B1935AC044EB1A07030AE6E4E0
      333B8635D705A98380390F1964F61414020AB10F224C24E570CEC892F6EF9EFD
      F496253D858364071A1F545DCC679FA14F8EA2E1FC9567A565700A3EE8115384
      7F8196547A2E2A00F54377772F598FC06C03C99909982F17788AE26AE149CDD1
      3177D0D7A6E5AB1A744C61297931CC28A86E29971CD64E486A82EF6002D51EC6
      87ED0C88CCBBA29815C711521834302A0E09C865F2D0CED43B628FF0E7DD1944
      353626DBE509A10408F8D1EC691A3B919B56477B02F2298BD74E8BF7C116A25C
      5DF86BF1156BB298F31C60AF7E5B2D9659A0BB49A257F759E1C71D07592DC37E
      1361D825DD6076D5C95E8867898BE001AB944097947D826630592D1B27EC7618
      8FD05643DC92EAFC67D0416A94FB7BFC885992AA4F828D225863964A4B53D2B1
      2E62A604BF92A11BB3AA25BFFCD7AF062000B47F221D6600446475D6590E6636
      95E38BDB35654DD4FB722116AA9832ED29BCEBFDDFF1E09C16F31FE5DE180B11
      572B8466968436E6AF08D748A36146BA3F409E1AE7585CB39D1B468574B6D6B2
      3D4685BD810A7B10AD9A50EC5AA1C21A3A3E8D3152B8610D855A003671B2F85F
      DC82C01F7C54456CE84AE77B50A65E4A1D42A52E5239A3D72FE0C71926B17E9C
      9BF06304FA4275F200F65F9AEEA172BCB6329E123809993CB1D0A5ECC9904EA1
      B0162B5B423086043407472213B2CAA1379BE6864D43A16A58962E759D2505B6
      53AA6EB385F221BA2D8B42640B35657A55461A4B0885059B8309210D5A0B61D8
      1D6B42E059C7595626707C653CD106F1BD746638ABC101924277D1CACF1DC0C6
      E93CD37A2B10BB9290279401BF8B181C98EAC341F0C5AEE891D5D016F02800E2
      0C8E549C256968A48A956669DF3BBAA1E19818DE3931A6277B311AC00C0E9E51
      FDD492D4AE38CC88525AE31840C776DE5C3FBD5C9747CD8D4BE57883800E4237
      E14C4A5514C366B05D554D4DE190D47106D0013DCCF5DACC04C312E8C9BD71D3
      66ACDD959752E13E44620D9D29D0834C18961F8A839A16A6A61C1B1C346E93F5
      B2BD793B2D054A3E71D91AA9F34473DD3253EDBBF026E6FC1D6B059137BD4E8A
      09D5C222C70A8CAA0BCB828E74A60879FB5BE72549950B101758CEE54755D6CE
      8DACBB68EBC2917EF49DF02E315C31E565EEEB329E9A1A20F3F68BDF050A040A
      2DCE228F09FAB0474C3324D2794CB1C4DB6B8C7260E9C86E20DA75A9F2B064FD
      13513029BB062503951980F909BA315DEA4F8D422D9C88D202661CF3CCFE453F
      D73F5D353530FEC476619C898E9A00C543596D5088671C73CEAC2AD352B8239C
      44EC67D57B3E65A5D2C4505E91DC6241A4F9DCC4DA2B5B2FF2FEF936D3FD0406
      C5F612ECCF62C12888D4A72D0E2A1500114E95B28B31FEBE8A41D27C6E0FC495
      37C69C51542C6DADCD9A2152EB300D8BAC8A257A5A0D2C1391D10ADE1360C181
      D48D524E09248E69865ED91AD3864100F5E6607CBB9C2CE6B631FB8B155D73C6
      54C1CCF5F1A611E10664B211BCA04B3FA359810FCFD911EB3A44CFF4079CBA67
      CFBB7CCF0CB6AB0E9DC6BBB085350E9B205A66E803C568228C10B29FE6FC7184
      FFDAB3A74ABEE4059FBD7A91BB101FC9184375BA1297667DA6340310D71867A2
      562415AA00F6F78DBAE505BE9887D151E4C913667FA3A27065807896966D7186
      F2268957B3796E6B03DBB3DEEFB4396DD0200FDCC00A7248648A13EB89B3B831
      8E51BBA00515413C9C6C0E1906A3065BD6EC9D01C7B96EEFB38EC9882D5ED7B2
      3DBB5E58633FA37D9F4A7DA850625CE24585D52CD6DCD49078508993AA0E66C2
      72806A87104FB66989F1E69F348F37EB3C84C48749A236D65DB58926219B0F56
      90C0580A44EB4B580BD1E2037F69AB1A25B0C36886D4822DF2CE03955D6A23EE
      1146C152B32C03268BCDEE279930F622839587B6A7AB1027120B16110B4B32B0
      5712A6B97729070E7169103BBA74706EDCEA806F5C51567E6F1DA4508D1DA015
      5524C393949109E29920BF30A623D1AAD262BFD001A2BCA1BB64AF9D4D4E25DC
      D87347F8A1AAE92C542D4F63A7FDD635F8076C89A30953DAB562F34A4C4E2D32
      9968539BEB49619147A97EBCF76B9C20ABF9A330E9CBCA53E9779BA8CE4AAA69
      F51E3604463C1910390B802753EA1B83468E6C1A56D610CD9505825958466865
      807D04BC5EB0E2813BAC2E13D3AF738BED1B8D9580F504F206041F1112B98789
      D7EA28DE6A321FE52A6097BA4E3E96EC0DC81DCBAA35120B9819DF6798577616
      336752EC5F634FAC24E973F2C390471F6B4838DF8B70D971DE89EB95040502D6
      D07741FAFD6AD2C1C053549E3A288D401748047A57DC9968C260B6685906D95E
      F0A9999311E214AF83C88FD77A1A742CF6EF63440D46842BA2EE98A0A215899D
      E2F80A23AB1D794BFD87C1E44745839D0E9DF193C9C918F6EE1F3B26781A1C0E
      8F71164E067BCC348CED378FC6054B3DBDC6676BCC7D28FBA39D0B009FBF9B25
      509D7D0C9BC73984532F154D99E337E4773970D4AF694A6B288A8613C0B8D02F
      957DC7CD9F0D0F4E2D3437CADC86D854744299299BA5B08A091AF8CD64159119
      DE950F923ACC1A8130741E23751AB5DF69A0CE6F21C6F9D4B2DBF92835E225D5
      F5B18E9D9AB2599C4B42B1DD404569D5257D50447BFC484912B5A07859E86B52
      245778F2F820DCF0908E0C1E55AD208B1E29FF7C3F63F1E3E956910EE1A69C97
      98818651AE01510CD1911F288DB4843D745E860B8A33489EFDF844E624AFC55B
      9C7F20D4A6D20B19A2184E24AB94F042A55405CF2ADF9B45E8C7D12CA60A512B
      C4DA74ECF5A9D765A35C55D293FD140AFF1F668D1946A330EDC04FCD27C2A88A
      F2A676C24EA758819E357D396C9E3051B99925A2F58260C6B2172AF6CEE6C04F
      80BBC6B209DAE84C7BF2CA0D420ED5759D092290620014960BA98ED35586798E
      F222585BEAB3EAA20AA6D275E39B9D591DAAA8F86822160151D39E8F66836661
      14B9756AE20CB10201F439A4D30C2E444D4F5E89FB6C117C5AAD5F2A341D7897
      D59637C46FE4F079EC96F28E999DFCCBF5AFECB2C8C099D36CF71060AFE22854
      6C67BF2234987146168B04775C82E084716230DD0AE55B549D9BACAB8115C6B1
      0C313C998CCE9A7CD89E8E518686C90D019733A51B0DAE2259B8112BD0C5F66B
      0F45A1D152EE45358ABB30BA05EA04CCB52D95A0EBBC623581799DB4BCF757AA
      325B2029FB281B9C8053AE099F27EE4161944A8331AE613839107637BA4C5751
      906E1ADE5603278852BC60A8B01FF0E8D59868725B789B3E4E9B9D67B497AE02
      B78091BE23B7EFC032F2A0E36C0E34D9C35F8B88ACDC0DA901EB410E058BD542
      750BF6C2DC0D55D88FCADC503FE5302A54B9A5FA2FD63A88298CA4D2B01A8BD3
      2E8BD3D1D76E717AFCE842AF8E435A559E5A551A403FE0A35F9D3594DF184A92
      19AB8E293349DE742E0646A118AAAA043961FDA0BA309CF2C7B12FFE2B5C75D5
      A96301955953F68B3448439356DBB611C30E14EE75BD0081FC0CE9A0D0850A54
      8515CA10029422C9921F56E584401ADC05568972B3D9D7B51BA84F32F897D881
      3FA1E755A53E2AFB33C527E1130F72661E3FC2B9F9889C9B27C730D3D4D043DE
      400B8ACEE17299C4FE334BA5299309F4F4400644DD6A67953507D40FE6B5262C
      28D705C606A2F0462B79E40112FF6281314287183432C1444765C934F342A996
      BC81BA5F7A8AF4F1228D532CF7A25F646D142AFC2A140E945727DB2A40DE95EB
      7396EE4F678E62EB4B5D3EB59C4DE0B2582631E9D731E37AC879B28A2E1D193B
      A680AB6E14876F95E001B956DAA5EE2DACC146D12E77F7E01C447196948C8BBB
      FAF0BA58A62040E375A396E74FD63BC99951AB78C6161195907DAA6BC9E68BF7
      6D9538CAA9EF7BA61952A646A321EFD2908FBF7E0D19A4C0822BB4BB115921B2
      E2938CFE0D2B88EA47227A17E6A5C062D3D9731A3C94143E50D1D215452D3F17
      51308BB25F634C1C41E33472D779E0FBD55C207AA042FEF5944F000624AD949A
      3A0E972BC3CD71776BF21E74AC8D4D44E367917468B7E3C4DA874B211D637F61
      8A2467A51A6A2EB1B7B0EF02C4134188319B2B6EAD35D1E002D72D6F42365901
      AB9355A0A03AC873C68223AF1B9920F4067DBBB24C8A12DAAD1736D967CE4F86
      AABB60B9334C558D3833D990597F2185D72A564E715EA8AA8BCC448E7AFBC56A
      2BBC383E0450BFC8FC8CBBED52109E00B909087F77C71AE02C3C3D865A89837A
      986DD19D757168F33834D5CFE14423618FAF96EC5D58475818FE808B4B02094D
      555EF62B2AED86BBAD03CA8D75C75DC42B76D9632C45FDC41791AA2079DC303D
      ED66600A65A53D29FC22B6A06CF28520698881A9BF40DDC398209362C6B4A434
      282265C3C66AB2312AC75C7D5A4515C50DE15F32F8C2CB60030A5584ABC9152F
      E153CFC21BC956C67B18132B59D5DF64D6D1A2E3AC22A922BAF175527106500D
      B872A63C302100D4B3BD5C0D703F05EE50F478AA0B19FE8FDA0D48CEB37511DD
      AC6390B0297963A91049F58E269566401E91EA2221017A5EC238C65A6D0A1A26
      C85088CBD765B6F6D2EB333880A4D7FDD3E100FE0C4E46A7F067787C3C823FA3
      23580FE9F5D1E80C6F391EF5F19693E1006F391D8C46FC34DE020BFC849AE99D
      9DE14DFDFE590FEFEA0FE03EFC3B3C19D17DA3E3A3E32FBBE061F45F1E4AF799
      E33CC7FF2FAE80B2FBE1E673C77956F7F6F386B564713BA8E29B1DA877BB5D34
      1A3740B3FCEF74F9EFB1EEF1FFEBDECEFFABBF4D9C66A7E4F11859F6911D3D48
      1810A2ADF1C832F3B9F3AD93379FD356222FFA9D8392B7596A1F94A291C3C8BF
      905D0B4F07773F5EA57D940FF8CBC1AFAB641AE5AF64B50C03D2586F2240CB9C
      66D49C226EF0609B0A057470FCD8D82EB6802BB26375EA4E3A8CF7BFEDEF4B44
      56A172E2AABC66550022DE3336E735D679B6D10E543B70F27FA7C0719EE28C61
      F2FE5E318BAA9D2C7AE35288A5AE5F86EE458594A0609BF066755C47A0806A53
      B6CCA5A830F746F327DA545C86CB71D6AE415D4DE2B87EA0E2474D63B4DD1B1B
      1E0D808C25F320F4E14D1D07A906C71AC9F009FCFA27D25C461B088F988A815B
      00E9FB60DF7D8C95410AA8E3AD6416727A29365C926F251B47D14E47D1C9D7EE
      28C2927DEF508EFC272D7DBDEBD4E6C14212A67CC4D734B3D5E34AC33FFFA487
      44CC03C654F99435E88737E497912AA886A8CFDF98A93CFC9BE6A1F0C910033E
      FFB4A3A8C5831AF039DB8C5FC4EBE81BB65EEB31E7A7DDCC2A1267D7A81BA5A9
      5C3C6B34750F051DF37F026255206E3972D638C7FF7751A51857F12DAA4F3F2E
      9FC212AD865E71DA18B971E03C55155C7975F3D3F0A316B6072CC29524A610A9
      44E517C814F40D239D196F4ED970EB5B4EA9E3CF7C3FEBCEEB488A24BDA10713
      4CEB70BDAC32001F5AF4AB77E7A0594968DA0AFD8A9A8CC49A62DFAC26A45E6A
      ADEA01B4FD826DBA3E701B8FDDC722405523C49B96DBE46D3849558286C40419
      340862388013BA1311CA2D46D2F011FB246311AA9D61CC6A4350601FDA72159E
      7968F99A1D3A2C9241C04C18A92ECC424BFED340BFAA3D1F146F99E0C2455040
      C405B3C2658B46E3C8DAFCDCDB74B354B0A028E239974A9A3C155D5C5AC628FF
      2969BED99BB5F7261FEFB0186FBC4A3C4EB2A72AF55E9012C23FA1A86A244155
      70A0F5CB0B3891FECA25DA610191032CF0C553F42C22245183CEBDE5FA5439DE
      0CD85C24605B51B0463805139927E4C0101B6174920C39AE886A8B8E50938CA8
      CC1F9C0DE3124E0F672452AD66E58B759DF3976FDEE8C86BD7F9F9C39B176475
      743EBC7CF521BB8E771DE8CA6F02D1B2DD649333B3C07ED4CB0743B8B6171771
      B5FAA99C89C0700C9943A7352819BECEEEA8D6BA08105D2D5C1557227775CF74
      5EAA3D52BFE8129E4CD058864E632BF95FC78FE8A425CC2D46E414D31B1DDBAF
      9194B07664CAD0646DC3D403B4F7A892AC0754A3B3D0BF86ED95CE8C85F5CE14
      6C989565F3D369C9AD45914C192C0408EC74E3B4515C304266B58D45477231EC
      BFC6B5402E91C484167AFEF7030200450697C17BE60A7CB16017FE5D1E381FE8
      1A6FBD8E7E03864F05BDA43D898D70AE4D26A76D504CB4BA5D4CB6509091686C
      D7B7EC08F1546E5B654DC79BB86E8D4ED07A67643AF6A15654E55CA187A6B111
      28547CEC370EC1D6ADB5BF3562455FD2314DAE860CCFEADD9A5619B397206EE1
      FC4109979E47D5FC28F755F57E99886970BD0740FAD2A47C0545F74F0A7A0397
      EB10048B457D793FC1E1C09BE8FC836A0C025FAA42917C127009ED3649756C28
      77ED8075D51A01CF8CD6A0D5A7FD8E40140E8ABDE2829130AC8D48B382B6D98C
      2A49CEF4E63ADA04379AA94C7CB6839FEB432FFFCC859EBF61AF972EAB410BED
      DDFB8F8EC28576A34D560894B148493D5B286CC6CC17A62695BF0549564EB7A9
      0658838F2895DE2B9C899C36A3B9C1D775522D243156F1A039436D93374746A2
      522BABCF9A8BD3D6C55B082DB77C5ECCD1696FA4AB7756B51B372DEC3CE406BA
      9782434955E5133B68D4E084E7F69CD2F4F7C513DA499B2B17AB7D129B018DAB
      0E28A3CEE8DDEE72AE77AA260CAC941941F263A64E902C58DEA9528B9477E211
      95A716275458C628A77467534C5C46FEA59E2494FC59A0EB9C78F338E0B2B7AD
      7F08A90BB9B64850B4DEC5E6C2BE2453D68E2C996BBB3C8C264761807592A669
      24367A540531D449B36DCD609EE09439A51EDBEEE9818687BA79DEB2F7A99234
      7B9AC759B52098C4A2AED4A1E29A390B07EEBA9B99611D4AE6D921FBFA28C622
      6FB4C8D505EBA8CA15A1EA6DCC555982D41C9755DC86228C9AE8EC014425CE76
      30BCAD405746E254553EB376A456E6F45DDB33A529CF78173FA923D0B93A02F1
      D1DE3A61D5E08BD5701B54CDEAFCEF382A3ECFB9CE325CCD82C89E409365BC58
      8576299646E0974B24CA7A542707AC4089BCE8E5C59B4668E77564231E5342C7
      2F9E7688211835FF6FCEFF7CF5EA15971A02D9B058B2372F3B372D1879670AE7
      AAECA9BF7E4B8F754D41B7291CDAF21533D218973AA8C251EEA4A551D7F6A96B
      D5A8DD5FD32EFC20B83E7AB60D414634BAF3CEB44FB49B2344B2166766F14A68
      952A57C099DC58D92CF7DCCD461252C6CAB8E157BCAD6AE1D60D2D532475A6F2
      29D4FA8045613C15690454FBD458641C89A976881F89897553446AB01427560F
      794537A8347516F777221209E84AFF1214060BF34B1A1E2EBFF7EF9EBD35314B
      0F851D7C664E8345B1B2AC86C357C1F50FA87AC2068E3C512BB7E136234F9FDE
      761E479D31BF8BEF79D4C824EF63E09CFC805BE1BFCF44DFDB886D0EA49046EB
      40F6CC988761F09BE56E609B3E48100AE64139B6E0C2D40A679FEA262E5E5EBC
      0DA60D4E70AD30B4D05DB2BBE11DA54698E033B729526019371569EC84205AC8
      0AB9F797C35F1DB9594CE2508579E431C03D26331FD6EA5774559383E69A0414
      BC252C6E362429D825F6AF4947A67192D52E35816274605C2EC34050FDD31A7B
      6EA3F04360041948169D2017EE46992131E8224E66315A29F3E82DD835CCF131
      C8DD4AB9C37E7831A97213D7BBA49A3849D769B3B74845AE2933A0EABC43A623
      3CD0525A5F14A7BA9C9C15E926AE5D8ADDE11FF4931C7683EF0CD0BE958135C0
      89961151B84153A8B15EA8928667416DBA0625D174C590310467AFD5585C2788
      3C9FC4519AD9E47DD1D1E188BC4CF4747389F5E20453E81F6CA8202260089B2B
      E2CF2F1521ECE947FB00A8E92FF5D2A05BDDD46A050DCE7864106E244D723A06
      FA2ACFA3BF35D7BACA66565F539910BA2649A646BE5B1DB76E90778AD29E3384
      D044B3CA9AF35601BAF8C155E0AFE050A4F70495AECB3FCF37DB8F9B69D8D140
      975743B619A13D2FDBA72EB7D9B6F07C542CC701B7ADC0BC19B5C7A5B8A7AD77
      98D9A1B6EA183C6B944D64B4663AA362E5D45C3F342DEA3B0C08FA24D0A97866
      89ABF05358E51D95696717F9CD66CAB033AC558C650E56137BA7E8A87221035C
      F618F14BF1B114ACDB63B7B70DA64A915EEC8F973B71D794371AE3AC15209D1B
      26B065360CCF9CBDBF06AD81816D27A447ECAC67F78F4257C19199605C253D60
      526134078D66522D72319E848D990E5B2C5E2137FD1E66AD894C2BA0A6E669D5
      3212401B7D32C2E94CE50CA031C07A9FD7FB211661F6186383118E895276147F
      F94F1236395461FC85F3CDECC84EDDE1CA771A4FF05BAE0FFC67A7DFEC9F1AF9
      FDD9A44716D65E16992515876C7693BD9B8C7A6FE079C87659DC486B2DCD33AF
      AB15F3260D716F887F53A960A640B2ADE3302E5E0E60900DBBA8A5105E90AAC1
      9CEB538D21AA3037EDA88DB5B2245C6F6E8D00BB4023D87A09FEDCC8AFFAA9A2
      5338C3D0B147E589909E6242EB1A00F08CCDEFA40FE8D2AB8035E944D039C3A3
      F351820B561985D051E0320C1DE737C3DD1DA7DBED726EE602A30967581E7C96
      6D6A75706FC914AFFC625EF82B796FF0911A27136CD540D244B1CAB4D2EF3327
      4F78F14CA169F47BB0AFE048A0E22538CB0C7BAFF570583533D0D5A53D2CCD43
      54810ECFE50C51D3BEAE1B82F6FEBDD3D508109B2B7D2A8F326595C55C71A038
      1B6807C882CF6120572249B3FAD6E848961B388E2E30E8B36113D59E1A7721DE
      D44813B8749E3AAFDE8F305FE64D105D365C2343EEB4C8A2837870A7BD1A5DBC
      D4EA6E1079E1CADF6373BC5627701D142429C49AA439067ABF1F713C957A359B
      685C06EF94591C23152F5617B00876A710E798856DAB702B6ECAD603E8D48AC7
      745E2830C49B4B1CB47E70D379AB0EE110AA48E910A8C2A8E7754616329AFA11
      ECC893754FFD0E3243D7E2D63BB4212C3A1873FE0013A6B40CAC951D60343354
      4E4027633AB8DAEEB41FE733CEF45C357286B537FE065A4738D9189BCEDEF489
      E6F8A966F738801A06189D484065121BCE58D787AD8DC8B6BD9355ABCCC83D0D
      AE9B0287364B0C31F6D251314018E6B9936296205FB8BEC9ACDC22B80931D649
      70B0FA677BC58CBC8E38CECC7325C7304B61E2D455042ED6985DDB0139AB083B
      328B2888E1F5C7B764C4262BA206F8B07EC73CD4151C60A23DB8D633875C8C81
      070C143B13C845A65265697575A2C4957D1DCF8A0A361D88AE1651CEFEB78BBA
      1D53E289328B74D1BD2D0BCA5A07A22BEB4EDE4A2C3518750E86805106603030
      6B18F84EF8EB1990804A67325D5536E9C9062BB82A7B4E2F4BE801BD14EFA20C
      691855E0F3D81E3FAA4DF3C78F6EA4BAE1AC4CCC16106B956005D9D60EBAA9A1
      12F01EDE2E9D9FDE3E7BE1FC90A0BA9A92D36BCAC4695DA4C9CA4B5B786E683D
      23D448F8495F24FF1C87482D04EE18153D8546642E145CAB9D0EC2F563D79349
      902698BDC4FB8F61E70407978535B62FF269F48BED91F4F43AD59A4E4E7740D8
      1AA4C98173E125C152ED7D8B40B679E1C7D770D40289866837E4CA4064FFC49D
      3D899E20BC4B63B3AE9EB91F4935434D264E5EBF20F8C6D09D31F372294410F6
      1D45B137C2CA120D1F5F5E1C3DBD006D5DA9D44F5FBD3F39765EBE78FD51AF6A
      2B69004548069BD3D17920A634CE3209E204D3B061D779CBF77551E8F7501E8D
      97943DFD3ADD8A8527750FD96844AA6B025AB186DD9C8882C472D5C35DE73926
      9EA6F98303BB84CD6262C305D6CE602148581309734B65CB20C37A929182AD92
      54F2AA65924D749EABBEAB7E2CEAB3EC20E388088E458483EA0257D19DC440F6
      B55B27CE409AA98435944D26D1C31C6F34298B8424DB040590661DE20289ACA8
      1729C94F5161123E664431D935101F1007908B55208308ECD886DDD573317054
      85A712C1E0FCF794488EF1D3B02A1B3E67839B93D26CA95D9C63C156F7123A56
      F32EB9154119940D28B8CDB03ED8857FFC0E03BFE360C22CA48AF3C3ACD4F736
      0A1276906084D1816D54C8B67C2E953E8BFAAF5ECB0D47A81611AC3A626E1D02
      25B5712E3EBC470514660CD192D86C969986DA089CD4719E9D7FFF810DF61DE7
      CDB37770DB0FFF7F7B57D7E4C6715DDF59C5FF80E4C554C2D8D3DFDD56E54194
      64CB154A7644DAAE549287FE2411EE2E368B5D49AC94FF7BCEED990130000698
      8128D12E2F58DC5D00DD3DDDB7CFBDF7DCFEFCEDB75DE26F3EFBD3D794BD96F8
      DDD26FC8EAAA1ECCF8EC937E2867C29992CB7A811B31E14F1E2DD30E036B45FA
      BC3FB2EA481C31EC4F1224944D6EFA756754B2DB624E996860724638DEED76EE
      C9D266A3707B9759DD4BDBAE54AF1720D246B8558DB3FE79F1C3F3C5FB59A7A1
      0F76D26C4F115C677F47D3A034DCB1B3E3BB6D3CEDDB5DB66B8C06FBE5CFDBAC
      CA66DA31C6D6D0D06C517FC8C52715E575E0B19D441A3EB61B0E28AB879BD48D
      8FB67755DDE44A0489C0CC19D8DEF4705D95B5DFCD4795AFDF19D82BE1306A9C
      7EF217A44AE5B741281EB17856279D612DBA0318EB54D4D5FB9ECF0E2F1745EF
      D7C79F7DCE27CFB7F46FA443070B53F78F40D8E91B92D5CE014B948E8AA26A4C
      1FFC6A2FF9EA82EA53B6AFDDC5B9C575DDD2B5EC9EF7BCEED5AE631FD02EF4DB
      B21FBDEEC6692AC850CDBBBC1919A27C978D8AB72759D1A0D2F953C201A3ED88
      79BB74A18E35ECC26423F99FFDBA92EA223E0651B9CE08B41EF78C4F1835E9EF
      03ED46E136A60F30DE6A4BBBFAB857CC47EF3DB42E27CDCA4DCEADF5EEEE0BAD
      3B5A7784DD1D71B9B129EDA8447ABEEB70EB40D6E68B5AECEE0D6634B445BB4F
      A76D32E8CF78DC6E22EDAE56A1FB4E6EEAF2E0D6AFB591799D77ABB6AC3552D5
      73B53318BB463D3CBCE962ABC130C2A6597528616B5DB7124BCB76BDC3757FBD
      CBF6ABDEAEB6730E3BB95B4A50BDD56625587F960D0D6DB492A2FC3B42247F13
      26F4E979A31BDFD5C7B4361F7DD0DDAFFA7CBB88BD27145B09D684FDBAE72A35
      CA405C82BEA1CB5BEEDAD3C43A4EB1A7728F03C013E29F7ED2667BC9310DFE1F
      B9DD18049A5630F52BE8D7750EE181E63BBB01C5470BB74BD88F8970637C9E55
      DE4C935B20B357CB351DFEB3993E9BB28A8BE6C83ADB88BE80F6D7858F34847B
      D82F2D49EB466E762F42252BDBEEAFB8694FBDDBDD16420B2C375B46AA55AA97
      130D16534E5994B239F088562D740724F9751B10DC6D386C7B38D0B69AC459BB
      53C3F1E8DF5673BF1D85DA96D81DEA3F5811D1EFD3783E6572AF770975C52C1E
      423B933C15F3CBC5B317EDBE7E4AE207C722EF6C8FDBCAA925B0AD67EA4E0418
      9E12F53D2AFA703B7D13577BEB42BB9864383B0AE82C63EED8EB9B5CD7746CD6
      E9F8A31A4DDFB4D1D9D68BEEFAE05A796AE6753BE143A10379B86EF7D004491E
      7AAEC17A9ADEBFEC6D497C3EB6D478D753775DD22F6BAEEB67FAA21164D27A71
      220884A9D6CBB5FBD8E8BEAD9D15377D8E09EB9C1F3DC7A4235B887EFC632FC6
      B7ED62EB634BBCDACE3E4F221EF7EF0E77C9F41206EB9CA0807177E1EDD9DEF0
      A1DF58F6B61E399B6FFA53CDFA226E3D5D3E91A327F2BBBCAF3733D0E8F27A93
      B0AEF07D4BABE23AE7D05ABFFD3DEF839D71FD89F7DD342938713BAAB10DC8EB
      0A8647053CDBE32F7FFFC56FD16B1D917E549D5E2E7FF277F566815630C7D68C
      4D15ED35711D9A3FBF7947ABBEF27A75F30F8FB83C27BC576FEBFA8755CB3D6E
      57CB2E8E4C50FD6B9ACBAA7BC4C1FB56778F31C3CE5D06750BC67ACB7B36130A
      9D3DA6998652376FDFDD3DDC1281D91372B76CEFD9866BD2E8EF37FE9B01E7F2
      FDA03CB986E5CD4355884417C7B44B1176B79FEC3CB8DE0BF2FDF423C2F79A73
      36FD6E7B37CB0609228B55A41575FD5EA4218868C54CF7767B56FACC5B5A69D1
      DCBB1B7AEE11CC1E22B617CA0A485AD2E9652F887FAF936F5775D42D6FED51B8
      C5D7E51EED6A0DB8D02E3F3DAF6D674F6E3B5F8948B00D60966F6EEAE1097E73
      B4D8663DE3041A402B7DDA25340807EFEB9DB1B4658F8A0977AB77EDC8CF4D17
      D5FC72F11FAB87D64BBFAB532C8182C3BAE0E4FB47177C7E28737557B7FFD7ED
      CC5FD7A5988B5F6DEFB6E93E21A5FDF68F3784A1F6569ECFAE967571DDE2DFFF
      F8EAF5E3BCEE60BE6D6FADEFDEFE1212E5F6F48EBAC49534E721EC4EF9558BD1
      8BFAE5ABD78B7F5D7CBB89FE5AD97F07E47F3641995E7EFE0AB9E9589BDCD2EB
      9DEC2F5FD2772F57DDEA8BFACD272313D26B84E7A0DAFD012495116F9AD15DB9
      BD3323BD8BA77601EC10517D8E91CB2CE8B30E708F77A84D8E673FBBBD85F16D
      D71DD72D95DDECFEEE5684475DDDD9C5B67331EFDBF313008305F3DB8BE9DBB9
      D7FED8EE557BA9E02AAC7EE8A64E76AFFFAD5CE26A798D3F69DA78B9DDA3D095
      D2E7AD56E066FCA2F8455517F8C7CEC8F4878BD2B9A233CE02AA436383A99BCD
      D8525BA1E7FD7C46BF96A2ABE7C1094FCF770EA89F70B9C4F6887EBF7EB73989
      6A6F7F0AF129FFDDE666B6C5B3573DC148CB75047EE956E02ECB7617CB748AF7
      E7B71B4BD69F941FAF56EB6E3BDDDC56CF6CD46E73DA53DE57F77B0BE42698F7
      AE62BBADEF3A150DE987C18977ADEBE103CFFB3590EDA95C5DEEBA95B25F9543
      8B5C0874BF58A322393ECC59E9529FDC3E89D692B4A56FF65CD388E6602E6C4D
      E2A37DFA0FDD09FDFD32A41AE676CC71FF2E022AE6D1199C8F61ABF02B77FE1B
      B4FE3FFDF99C9049CC08C932AD56698FB3FC5DF97AB93E9B91B4EA99CFB410FB
      D78BDF7D1FE88F4FA1F06D19F48E6CF0AF691A0B29F1CDABD5DD7DFBE5FAD78B
      17ABD5158537FFBA784D17437FFAA14F069D808C4AEDBA33F06F3A2286283074
      35BBED4F0E3D728F75FDE3E1EEA65E9EBD9DA6E90FDF0271DB5C6C516FEAE856
      607D84E3578F74EFFA48AF6DFAE5F5ABDA5DEB0FDF23E7FB03355C4F9D9FEA0F
      F3EEE54CFB02BB46D459D2DAC25FD2B465DF29F5BCC776E8BAAEDC68AF155DC4
      F6F692C50E3A0757A76E4CECCFBD786CDB732F3258497BC6EC33DF9DAF553BAF
      FBFBE368CF4F717EF20CA17C79937EBC48D0CE0F09E0BD9357898C1069EA667E
      69AEB75FE1DFDE8AB0080F219C5FE448E8A5FD9D6FEBA6A7DCD1697AD8DB8737
      9966536F733B4A5857CF50F25FB5DCA6AE19AE1BB2618368CFE88C6DD3C38364
      AF96EF880E2DD7132EFADCBAC7FB1F1CD3F8C9ACE0F8C58DB4F825B496F82515
      A47CFF83928E9268C92889119C92582E659B9B92C0079B5A4CE31C2562CC3594
      8A71A4A3DFC2C89A4E6AA57F5A9F8CD6FFF428FFCEDFED77D358D2C5CE96DAAA
      009FF7973C7F3AB58840E665FAF37EF52B84D4D393EF1AAF6D553F995CBB05DD
      43393D31D5AF5DFF0FF076CF7BBF8931A194DB3A4C2FB42CEB1599736AB1354F
      97353ADFA4C9A977D23E12DA1D17017653AF1CF99286EB3F7F9BE3BB97ABF8EE
      23109BC9AEB2FAA39FC0591E4AE28F37571F45164F9FEC7BC9B45CD7C502DDF5
      30916A476EAB1DF5AD2BB4F676496C16A26DD791AD570F671F4DF70B760348EB
      7AC2C77A75F55D7D34CD4DD1D2ABEF977553707BBC447F6F4EBFCE8EAEB0DA9E
      7E74BBB326F5636C2BF8F3EAEE2ABDBAF5313F5FFC82964AFDE71FFEFB17CFDB
      60EA63B0C1D55F8D1CD873354F123F2D09245FE4EB86C1BB5C43C69D65E39F8C
      6E2BFB9E9AB5A66675DB9E6845E59F371F7E34E87D793645CBBF69F3EB9F6812
      FBEF2632E9028F6F3C9D26F0D19ADE6EAEFB1E449F20F4AE3D44ECCABF59D399
      E874FC7ABD37B41D8FADDB2A06EB6D6937577741C1043EE1899CAFAFB872F879
      0DC2F0B34E8BECED2E6F8567B8734ED8A3B2EBF4E59FFE0B6DBFCEA0667EA11A
      191AD148269BA6D1F86F9BFAE2E048D9A5DC94504A693F63B1E1F5B768DFAB20
      852E3A1B8A39F05315258D338D5646A8C4B3B13AE9E8A36331C81C8568588344
      88804AB4222B9EA47FFAC4C5C0F170CB557696476373349E9B189B6811EB48A6
      A34B36706F9442658C8C892B29B9B7BC615A471E9313A2189745C8C2F0905869
      4C505138EBA237D2FB52B8E41C8FC981056954F22A15044C25399F9E3E51DA3A
      CB9847881635F3AA29CE16197CC8217248CF1ADB4814E6BCE25E999035DA887A
      042E92CDAE319C15D7789978F1C2363C06A18CE6DA3625419C3926549DA5C86C
      0E2885099B45745224935523827EFA24342C292B52CE59150731C8CC5D135007
      518496D947E9A568AC1541C4C64170397A5B9C846C9846DBF036386E8AE2D94B
      8EA77816937211922A8EB9D064ABB256E8162694B729F3A6F026D8C87814A179
      FA8484AD4A2CDA40AA7840D6A188E0B275A87E485A391D434C686FE0369B28B4
      CA31A21AAC14C49C4D51A264CB441231A21AC194162B85D003BC9CC2197A0332
      F006C5B61F3642032AF40A1DD28AE1C05844685C80ABEE6F4B402ADA13B2507F
      938B5521418CCC24C81B2D6340157AA278E51A29A87B4C4287206836455BCE59
      484044C64F599E3E89E8D6C687003943DCB914E39D4825FB6C4371993999493A
      DA79EF1B1D45E612C08B41DBCC8C1609E02C40B0B3CA4B6FB86A501D80A7B11A
      CFC533020138AA26312F20A624180B5E491BB4689C621CBD50AC4D4E522AEEB3
      E45A26861E6E124785540A426ACEA529DE3866982AC9007996AA962133688628
      8A69289611064DC9B6781B5D29400D6414A3CBB24486FC85C7AC243A4543659C
      9451E32B8D1A7806BD2A59281112306DB5F23E499653135400E2922EA9ED9B29
      3DAB83714E336D3B8B61FDC692D4172C079E002BA17869FF7EFA64F71DFD2D13
      0AC8F86F6057786F55D098285383BEE76455D0A72679668C6B600DD019013095
      4A43E963F03984829A49E122F392C1BE40A2AE00D7D0C02CAC10065102700C95
      094F9FA03DF8031D191BD324EBB582C9C9D612A80DEC8D37E8379BBCB42CA2A3
      A28E196532285876C632483C480B454B453AC05228D40DA602180432525029F1
      26E9A060AA1467197D9192CAD05F09A0C0D4A10646996CD19BB0E64019BE4443
      D0A10D17768EFC65664536C95464D35781D51E607A4CFEEDDF4F9F6CDF09D6CB
      3C47589462495B349321139044696C4A306E21E82CF1B41062644E67A477012D
      9551CA2CBDCD1A3AA0D16746C394413B0D2C2BDA2449557864F89D04920B58C4
      548003E809B40C0F870E17882B4019B4532242195383BC423907831E4D4A7001
      1CB68E43FB988275CD056538D8B004AB526292D6195F526C8A774659893E87D0
      806EE70CCFC2418595873AB2E08446CFA28185B4D178A8B0D770382C024D424A
      E5AC7484260E6B8BEAA4D4145182B5D16863E127848E16FDEDC842375EB3641A
      9153E0B0D30E4F68A217901377105F634B763037A80C40C97316DA19C6904243
      AC0C38485CF384CFBC8F8A35F0A3B015B05AD272B25B0E6683917A05DE00A2B0
      5CE81478B7C65331D0741961CAA23629C3BBE9C0204D3890CCE142A4843BB406
      FA002F8E8A0BAD93B31A6ED7E606664CE460387CA3F58C37D9142173525A014A
      39664E7E8AF304D76EE12153D1DCC3F03A656281BD82AB87DB2C781CF04266B3
      C0DC3AD8C40C457449812CC0CD4182C81901757453D21EA6C2176A532324F300
      84578267F8461F0BD4C61923840703015E0AF3803480E4C020A0638287923949
      242AF8AC6235B96C27D1E5019FC22DE4588C411FC271C900C3EC8B017569A058
      A00B680D7A82E01315A80BB41C3E122EC440B20E0C051FC014726B5D93C981D8
      AC8C4FC546E86FD6AE691CD97789FE8F02D961E7012A88D22ACBE19D2CE01424
      9C9106C0006D8DFE8201892643F9A184D2411470F81C24A76842110C816AA212
      D9C30330FBF40913A849417742B001EA65BD229E419DE2B2130EAEC0A2F8A20C
      10C52171986FF83E586BCB998171205843D758819420244D061F28461D1AEA0F
      DEE8A27281E460C320821C323C8F456F4803D7179F3E1191DC339C2F9C7F9200
      33EC97054FF34EFBA2E05050F792A16CDEBB029814E8204C6B4166B820096658
      6286A618802505CAE2BC6530B45C919F44A125E5680BC343EA3B011E841F705C
      70160ABA00E581DF05158522A067B84A1120485010462410926AAC91903B2C30
      EA9C6099E1178073D03BF84E0841C2D7C6083AD0C0A92B24D3811ADA30C988B5
      02CE70ADB0990D58115C3211D2846A817715182BE0C046F0A1C8403451368C0A
      0CA88D30F4DA060BC611D0DD2059A80BE89D05B0517D385CA6E0255292901D68
      AF0425281CCA032B061BD5801A3B1815158B0709D4B03EC4E06C067DB41E0545
      0EC7C4C0C5A2843DB0A1012F0D16D6D9C0C1F0C683E572B0A1C8E1599046230F
      BA13AE1EB58B68BB571EEC2039981E743E070767A85A843D65B07B169E523127
      C82F790BE7622497898CA8850E82C00AE023C256A3114938D844A2B9B010DC7A
      3C0B06D550C13272901638487C0A45F48D4357A0D78179A0CB404A4EA06E12FC
      4D58408D7B32A2001DEC1B8816E8AF4A560A0F858717494D464AB419468BC362
      8181C2DD812AC351831FB04201038853267DAE7027D50193C17FE01D75868380
      C94B60038D013B4D32A19EC97268A674C567222612D64929440701AE122C16C8
      10E088D99335D33076607330D4A06FA0E1AE6119E521CA852E4042CCC32F0774
      12B823AC23FE840D86852B30C0B0650A70900A5A2949D5E01BA0332903F15197
      283CBA3100E7990B98AC027F0374A0DAA83CB43405AD82806EC0E4E50C85E13A
      41B50A451E049A821AE4DCE01D78338C736B7D61BB61A0B34223E00EE1B38A2B
      E045A89089289BC1D8F080F2A03BD26B833E6BE0F31CE83A3904904298AE26E4
      C61B040F4233B0F784C807B881F182B6A1DCC29980023446C322A1EF02AC3570
      ECE066D0BB505B41299114A608154589BA204086EA783C0DA110FA2FF9EC342C
      387CAF434407F381C0AB20F809E4B5613040B8A080708FC0AD0A1434195013C7
      D138B050688A6924FC373C530A0EDC07C2115020D944624F5026D8583064B811
      58274432D078F825187940B1016D80E4F1F400C426054E445085C98581419445
      D124854E603206C1A5039363B0F95EA1DD6887238F14528C60E63153D406AA03
      C2A375A33D53802868000CB722520A4E049F0C1F0A03E0E1DBA1EF4A80A22BE8
      271412F0072B4295413434002865A3C14E15FC0EA250906D9BD071881BF1A982
      638299872B873B85AEC193A318A15083822816E4182911D9590F968416425210
      1EAA0F2A0081F880BA512E98410D0E65F0380012B61E9E207B74278353A068C0
      40AB22CCB4D450D6AC4BB105FE06612EDEC19F22A28174213DEE8407114F1437
      0215E046B11A64901D481961226CA60455F5A49B5C91F6440B45D2E006025D05
      7F931102A16FF055D6D0291039D8256592F0642411D821C231041BEF50AC851B
      21766DC0C70147D85B83E0DD10C7402F50440B53431E10DACF11307BD4095E43
      30897233F8077730AB1A64050E1CC6182407EA8DE00C84D2A2AF206257B88908
      7E24FC32632E35103A85BA7067A80BB5392BF8599814A7220405AA017137B141
      0D6045B8031D453733258544248F181B5D847E0127D3D11347434C96A0E7E07A
      401A45E730F9092E89E42E11DA21CE7042201608F0779E035A884E60A460DC03
      6B4058E0E3154C51423F0403D5A0110A884C226A4BC45E1A986557101929583B
      D40C36C5B3806815BC81EC4313220757923C8004C25B25634097619C11F3C2E2
      A0CB1C0DE1105B0906069201BEF034F0337564041109E48F480A11211A87BE44
      450A359C78221E090782B852270BEE8A68492235F80D0769400F688980964588
      0736102C191CC218D80F7CA0D1F7A0371151AA027E1192C1F1A35FA0E5F0AF99
      AA091E87208419176BFB53803FA2912EC820918B4B40228C7084354748002B01
      C4A2A6913588774253D070EE0C6CB3C81402128B82774B190A0CCA41BA869817
      E4483BB8416007FA07C616B2429808DA4A830E246E47D0CEB0DEE836C44EA434
      887B92A41A000768A08663408FF982BE00A100ED014B831186F05DF25E950CD3
      233C4A36D02F8AAB812204F81039BC820767D22461F49182E108B04B062A8A30
      1E9FC1C800C34003DA4F4E06B004A034CC6C0491020746DC085E030F8B7CA03C
      704BA8016438355A6C60B45CE3A8B66D941EDA48939BD3D1E2767406BEF16CE4
      3E1CBFA9313CB1122806349A1B1A2E291A1624788A7880A7642D1241752850CA
      522030A400096131432C92102652446341AF60CA600FB27320B7C11970400772
      06A54A198609BA0C34C01B2101B8BD438C013F65C13AC1011188C30358979C80
      2B08108D8501D0B0AF393150188780975B49019944E883A709D07003A5E370A8
      A0E0E02860E5B2802341A110607AB029443A92732F3C683C62B790E0BC108840
      6B61DB68580E74173C1528D6E800F877781186EA2B8414346A0331808759A781
      4FB849C45FE860D05598125046B2519E861F22D40C64CE93A6CB888845014E40
      38684FDB7383DE876FE72054978CF89E7AED8E0683A58D8E079FAB038D069E1A
      0B3CF6124D9B6688C42DD2CE3DF3DC38D5B11754859FD28ADD3194E39A70AE56
      E7466F8EBDE09336B5422F1CA9D7B1919D73353967198ED604EA7B4A3EBB63BA
      D36D46ADA96AB61250ED7FD58D8AC5D8F8FEABBF3C7D42931D7175B5BA5B479A
      F2B8F6B7F5100D4495A52B19769A9E64044C2BD08B988A935C10FE7144C55060
      4DA896F816A1257DABE0EE25A24E612905E27D596B4C3F239500B9229571847A
      94055A0FDEE96966016600B6DA207CA028069CA269EB005D11F88EE239040046
      E25F038655380D52884E32D0790447C5D43A75F9B42619D277B2FB9693A5409C
      C5F19969EB5C5B092227A025080D0BA5D78E34B4B6103944FB64D01AB49CDA24
      41ADDACFA40EED67351DDFA4E39B747C93AE7E86B2A9CE753EA82B63F0C9364D
      45277DC60F521D96240ED2888334F2208D3C48A30ED2A88334FA208DAE692C24
      4E120D6D3FF5EFEA77E8091DE530C5DE6748072C7498A413926FEED7F7EFAFF2
      FABFAED6697DBFBCF63F08A3E80D2D4BC929E5D2D4AFF2F5F2ED126F6FFA4F1E
      6EF03ED3EC7AFFC9FFB677D5F56FFB43F8F1DEB9FFDB16997F88F9F67EB19383
      2D76D3378B6DDA66F14D3D49F6D3D1D46E909ACEE820D562B40E6B50ED36D7B6
      D26CBC02C78BE49F7EE002C5872E507EF846AB0F5D47FDA10B341FBED1F643D7
      D14D2AB0CFB5848AFD3019C1C35CD3403ACC330D87C33CF2823CEAA2164D03CC
      308FB920CFB44E1FE671135BD4A3430CE171BF8AE8E61F59C0B41E3F5180F8F1
      8D98868613054C3333270AD03FBE11D34073A28069083A51C03C33D13AC6C5EF
      80C49BFB99AA5556ABFB9BBABB33FF703FEBA9FE06F9BA93DDE6E66D0FD09A95
      852ADAAEA09FAD9C9DF1BDDC960B3528B5BB707756F5EFDB55AD6551966F1EEE
      F27A6643F2CD77F96A755B2F9BA42353663D7B93B95DEE385BEC151F9B23FE2E
      05C9B680794DA71DAEDDDD69B31E7DEBDF5C940FBCF64734B8CF5D55625E4337
      10F10FF76F0977CB3CAF9FAF7DBC5BCD43E5CACFD28E3EDFCBE57A6EEB28CBE2
      C5C3D5559E672A6ABE6FE67763CD378F04D52C539DE020D33C1254B34C737447
      A47749A3BA9C17B5ADCB7B4113BB9C17B4B4EDEF4B5ADAE5BCA8A55DDE0B5ADA
      E554E3C1291BC6B2AF97F757F30CCBE7EDA10933DBF56AF9E6C6D30DC3B318C9
      B08C2FBADB40FFE0EFFC9B3B7FFB76F19BD5CD3C257EB14AEF17AFE7B2844DAE
      CBA84DED99CFBB83D8E6F7699FF312146EF2CE8BA88679A706F1C773CFD3BAEE
      44B9C5575B62761CC67BF07A08F7B391FCCA5F3DB49C606603BFF0F7F39EB405
      D06FEA7D3E1D8C7E7C113331F10D3182AF3A3F3BAFCDDBE7CF7BE436DF3C08EE
      EBDCC58FEDB2CF35C42FE88FF9A6E2ABF7B7F90E4CF1DDAC5CBF59D145C1390D
      731F053EE7430CDFDFAD367D793CC3D0E07F797DFBD6AF97F308DD17ABF850EF
      76FEDADFCECAF8872B3A9269B614BFFC976BBFBCDA711AF3FAEEABD75FBF5CBC
      5EDD1287A5AD7AF37A9032BF58DDDFAFAE2FCADF05C1CFFE9CC327F31FFC1998
      F3CDFBEB4B1AFCD9051159CDF8F972A6396B73ADD205B9BED8DC937D4913FF2D
      BF0F2B7F97E63FF70F77B9558EFB7C41EE579E2EDB9A9FEF35F499CE659A3D5E
      5073D311C7148A5D1AE8AE1FC2FFE4384FF3BE59B531D59C3CBF6F4F7F6AFDFE
      DC41E241E679367E9075A677A19BD9573B9669640CEC750D857F7BB74C23CDDA
      317431BF5D5DD171EC9B428F33977D79D30ED53EEEED13E9A1D17E592FCA79F5
      761B206F12EE532F4AB8E9C14D2A7E24D54EAB36E9C41E194BCB87EBFEB9DDC0
      F026AD3C95960FD3AA63693BBC0C12EAD1847B259A6309A949FB25DAD1847CBF
      F56E34A918946986BDF385BF7B772873B31736D1647B79B83ADA8B861F4F7B58
      A8389EB0F6E55400C1C9D0857C1B553D8BA56D8649A01A497E1A5B23994E836C
      24D309B4EDB77D4C9FBFCDDF2DD7FDD8EAF1B158B9D7FCF54E647A82BF0D41F6
      EF0FABCEF91E7FC8B01B7F77739F6FD67927D714C519EDEF133A3422D913CA34
      92E3844E1DCF31A65C23A94F6BD958D34F29DCC8834E68DE48D327A8209F66CC
      47929F53C00303374D05F9252A38DDE08FE49800E083F64C00309F0D603E1BC0
      7C1680F92500DE6FFA1400F3D900E6B3012CE60158CC03B0B80CC0E212008BD9
      0016B3017CD09E090016B3012C6603781ABD19493D0DC0FB4D9F0260311BC062
      3680E53C00CB7900969701585E0260391BC07236800FDA3301C0723680E56C00
      CB590096970078BFE953002C670358CE06B09A0760350FC0EA3200AB4B00AC66
      0358CD06F0417B260058CD06B09A0D60350BC0EA1200EF377D0A80D56C00ABD9
      00D6F300ACE701585F06607D0980F56C00EBD9003E68CF0400EBD900D6B301AC
      6701585F02E0FDA64F01B09E0D607D62E86E28079A74BCCAC31995E331FFB07D
      7D14BFC97862F6461CCE73E291DF0E96041DCFC88F3E734ACEA1905EAC56EF66
      2C13D89432C4E58B65B85AAEEAD8C8FB1FB33C7A7F7CF6F79F6FE6337793C9A3
      D35075307718A44B3E9A70180C49319A70483AA51C4DB84F21A41A4D3A34A372
      A84E15AE6DBA6AF08669F5585A762CB5194BBDD77C3B966EAFF56E2CDD7EE3D5
      689B54B5178362151B4BAC375A3CCCC0C73298E319CE8AEDF820CF09F98D8D3D
      9D10E5C833C6657A3CC339D18EE49A20E3B1364D11F748E3A6CA9DCF95FB6400
      8F8DB14C903BBF48EEFC62B9F3D9201F6DDC54B98BB9721773E53ED9828C8D25
      4C95BBB858EEE262B98BCBD07EE02ACECB5DCE95BB9C2B777911DA0F0CFF0CB9
      CB8BE52E2F93BB9A8BF6FDA86A82DCD55CB9AB8BE4AE2E46FB7E9BE6C85D5D26
      773D57EE7A2EDAF7A3870972D717C95D5F2C777D31DA0F1A37947B8D882693C0
      9DD4277DE84EBA93267C27DD490BB293AEA380270DC74EF269247027C3341278
      28B6492470577E2319C60539CA1AC7653A89041E087712093C2AE3919C13843D
      DAB8A9723F49028FC97D328047329C97FA3EB19A2AF79324F0A4DC4F92C09372
      E797A17D9F6F4D90FB4912784CEE932DC808259B28F503EA3843EE2749E049B9
      9F2481E3729773D17EC01ACFCBFD24093C26F779267C24D70CA91FD0C719723F
      4902C7E57E92041E93BB9A8BF603D6785EEE2749E0A8DC4F92C093725717A3FD
      A07153E57E92041E93FB4912784CEE7A2EDAF789D554B99F248127E57E92049E
      94FBBC7309BE4696F9CBB05F5DFBBBFB0B77397CE5D76FEFFDBC0D9E7FECEEE2
      C96953E1BFD49B1AE89286F53D5D7EDBB07AD651D39EEFD434AC3B9FE9E91349
      C7BDD7138104E75909C99455562619159D9AC4B46CCF52129ACE353AFAD26D49
      A98985B1DC781618F3998D9FEED4BE049D5F8C224B2EA59EF634763215DBFBBD
      F705E52F9B53C70EDF6F3EFF095F749AE6DFEFEBB1F57FBFAF23AD4FDDEFFCF3
      D6E463BC1EFBFEEFF7F5D8FAD32F05AEA14BFBDFC8967A48B0109DDBF7061F18
      778E255CFEAA275DAA71BFDF44ED93B3D6F1C2121D4EAD156A2A1BA705572CAB
      D172D192A74F1C1A28B32949366C8C71FCB5BC462570E1EBE9930F59BB9FE3F5
      2125F0B7D77A7A7D28095CD0FA3EF6E85E7FF9CBFF035DFBFB16}
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
