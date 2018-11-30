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
      789CECBD6B77DB469628FA5D6BE93F6034F72E4BD3140380E02B7D7ACEB1653B
      F1193BCEB1EC64E6865967816491440B04D80028899DE5FF7EF7A3AA5020093D
      2C29A687D533B148102854EDDAB5DF8F3F065931F106E1584CE230997AAEDF1E
      84491ED13FA3C5D4F3DBFE6039E23B262DAFED7607F8C91DE4453E9B8C87A319
      5E6CF3D738E5AF1DFE3A8B2A5F87917E1EDFD5727B9EFA3C11F0E6DEA09889B9
      D0BFE96FEBBF8E72F78FC1244D8A6218C3077700438F236730C9D279980C26A3
      5998E5A280EB8BEC1FFE1F837F1B2CC224CD85E3FAF07F1DB7E5B6DD00FEF3E1
      53F0F9633417B9F393B8723EE0E37FFD0C43FA7AC8793A16D9FA985E75CC2E8C
      D3A7B171CC00C63C4B975924321CF5AF9F0F0F60C456CD24FDCD4902385D5830
      FCD785C9E2A0DDCFE7ABF9308D696E5EB9DE248A6F1E68E37F9F7F8D92E918FE
      CBE5BCBCA066625EABB31D7E6BA37EFEF91D0CF736FA84F74DC2B87006CF86DD
      C1B36E0BFEFA836763F81BF607CF26E1E0D9A83D7826FA9F6919ADBA176FDD36
      DC2EDE36DC3E1F411CCE8759143AEFC262A660DCD543E657519EDF3CE48476CB
      A7C1D590710463D2F482D6BD506008F3EA57074B933C8DC39CF7CC6FDD676A43
      8948FC1FA0E9E773314D85F3E98DDAB58EF7D06DFB5F6ADF6882310CF2F7341B
      D0117FEC0345531E0F8D373C78F65F8874B3C898847F3F6C696DC716E76D349D
      1572914373FCBA23FF00BA04DB14256AFC7B1DA07B6C53F986F6D7DBA672129D
      473AD46A83CA91BB8FBF4141EDC1F45B3D1ED6597BCE397B251FF5EB1EC5ADDE
      FEE82A930B0B3AB5841CA7B4F5E91F32212EE4BB6BB7BAE3D73CFD7199C9673B
      75CF76BB35CF1EFF288699B83A9103D46D84D7AD83D9F1F32C1C46A313BDFA5E
      DD10BD4ECD102F001FA3919C41BF76F9ADBA19FC12892209E1A290CBE879752C
      43EDBDE7188281DEF75EADB4A1367EEDB972D37B41DDA36AD7AB8F1A3BDE6BD7
      3FEA6F79546F77AF53FBA0DCEFEA83D5BDEE75EB9FDE06A4F58DEEF56A9F973B
      5D7DDEDCE55EBF7EC9AD6DEF5EDFE2CE6D34DD5104CFF955E405BCE13E848F16
      D8ABE58D250131451F85453DF776EA517D6E95C9076F271C95074B1CEAD53308
      4D352A8F120EC965DE7E602B8F1AFBD8736F3FAD956737F6B1D7F26A988A0964
      66EF0ABEAD3A71C184AF7C441FD09E21E5569F3281CB4F19706DB56B9FF2D79E
      52C7B2D7EAD53D6300949F3161D9EAD7BEAAB5F658158CBCBEFE9D681E4BC21A
      94FD3B113CF590C2D3FE9D689D7CCA0066FF4E844E3E676068FF4E94463E6782
      B47F2732231FDCC04DAFD3BF1D39953AA0400A0FDD8E9EE5431A3FE1B9DB1154
      3F5702159EBB1D45F5730A47E1A93A61AE1415F45315BE018FD62977A590503E
      5A651AF0F0ED87433F6C6C253C78FBF128DFBABE95BEDBBD8D5FFCAF7586B1A9
      8DD511CA9B054A5A78659C3AA2798B74B9368C57ABBADD41CCAC0C54C7AF6E91
      383716E6D5C1F88EE26765AC5A5E780749747DAC5AE678AB48BAB9C65A11FBEE
      F2A9A980FBB7A8F80F97634C4DDBAF3B7D9BDC96946945D52A63D41DC44DF62B
      C790C86B0E52CBF637B9310F2251776345B5C2C02683E6811409AC0C524B4237
      38360F625026D3D0D07A0085A88CF3E514C21C26780885A80CF4100A5119E881
      14A232D603294465AC075288CA588F40214CEB52F06548B53ECA17A29422807A
      A0F603D94E39D01722D5FA300F41A9CDD53D9CED94637D3952AD8FF45094DA30
      28769E92EDACD90D3B77673A25BB299FBE3BBB2911D61CA07B775653226A6580
      BBB31883B9948FDF9DB954684A658C5A69FD16DD70CDD0DAFD625A5219E521B4
      C41CA8F74006550EF4E5B4A432CC83694965B48733A872AC07D192CA480FA525
      B4D0511AA759318CFF3AC8C4D81D4C61571277308C97C2DDBCE4B7DBE645F87A
      D3651E00BF6D1962EDF2DABD3543D4BC9087F0FC9E7911BEDE74D9FDEBE1015E
      C6EF5B0659BBEC562F96836CBDAC07E9FBF207F8403FF4FD3BC1D9C5CDFE37F4
      E48F660B2415BE3FC040804128DD371806A0BF60C480FCD276D4838B70E1C00A
      FF113B8338720719FC97871E708B3CF6DB7DF877BE8C0B6F70158D4745BC08B3
      C155162EE0B9102E0FC27C11C68B59881F92E51CF845B82CD24138FEFB322F32
      149C6140986B8CFF4445B8709DCF8324FD07605D3A4F0BE1FC31C88B552CF299
      10C51F7FDE24065911032C26A3DCC3C587D22515120043158D01932932BECD55
      C0550112466C0401FC36780F46D32C1AD363C9C2182159E018CE204FC475016F
      C9FF3149B379085C375F64519A45C5CA757EC24B18810073CDBD2A98869E4BC0
      C27F87B8700FBEF1DF7B812B5D160020118B4B11BB7706DE201CC20A5D841C48
      AD35901B0EE8D76DB0BB004103C48E56E716F8E0C287612EC669E24A60C1CB73
      98D585D7DE0AB5BE83A895E5D1D8F3825EBBDFF29C990831FCC2F1F0D4E4FED3
      C3D1FB1238022C4A38C2BAD72109BF6F83E46DF8B5063D5F41AF735FE8F9120F
      5B4F0F3FFF4BE0E7776FC243F8F5FED0DB827D2D05BFEE7DE1D7629A0DB386B1
      C2F1382AA24B01B7E7621ECDA2F15824F06599C047B184571A837ACE4B869DF3
      7398855380E5CC799D26050D08732C72CF837FB2F46A3C28B24991FF1A8D8BD9
      8B167C59C08B62CFEDC98F59F97112ABDF2785FE34D49F32FC341A2E4220BFF0
      61C21F86B074E044FCB7582D04DC955F8AAC0009043E0DB371A6FEC6F2EF50FE
      CDE4DFF134D69FD4B599FC7BE9DCC60A60B54FC20C76861578DE0D287178C01C
      C1F9180E63A1F1A96DE2531D91DE38122E53674D894B5A8108CA488E7FD3D145
      051BB7A0F88F8AC03A672061EA79756E9F17BE76CBBCE0B271F6F47CFC7BCEC7
      AFCEA77BFB7CFCEED6F9E0E58DD9B4EE399B969A0D71F3DED390D17B203C2F38
      B801D983C7A1995EAF22D56C00689EA789927478A7FAB53B3571ABB35CC683D1
      C45FDB9D7A92BABE3540C232DC4BF566DFBDDF9B3D7F0351EFFCF2D7691CA757
      625C9944EE3F919CF7688801EBFD42D4D814466E22761BF092B4EFF857313CD1
      FBE5D7EF974FCB58DB350C33A68B5FB66787073F7E7CF7D6394BC79AFCFAADDA
      29449B5813ADBD795384F0B79C905773D8D03CCA1943820A86682C4049E0BAEF
      75E05F0F43278A6BBF0B04BEB86E753A01FC09DA3D60DDD7EDA08FB774020F6F
      E9B630CAFBBAE707013F8DB700B2756918B7DFC79B3CAF8F72C335E8AD3EDEE6
      B5BA01DD1774DA9D47463EB96B37201FEFE0A3E05FA0184BFB5E540351E0E74C
      F0D61562AC51A19E13DF8C8D5B995D60F297CAE46E9B4F85EDF9F56C781D392B
      73B881602FE2D39262D673D5B5E1D71779F30B46FA05BD9BD9F61AC3BEFD7CF9
      9BEF3B2FB23499FEF533BD328EF2A24001EB0FFAC8DFC57C1187858067DCAE87
      F1A8AECF3F93C232A07F93C9C86FE98F89FAFCF7918BEA1C7F44DCC74F1322FE
      F24B5E8420428380CDDF16E148C85F40CC1649E1FEC1DF0AC0D9C133D71B2C4F
      5B7DAFE5FC4F8411BF6F391F8A0CE803653DE4EC6B0E09C5A2D356070F5C172E
      FE7D24178727DFA763087FD02674E7A5DC71219730D9043EC2A6A9C5DFBEAE74
      DB7AFC9AF57841505D105D8091F1EF132FE92E0B8265ABADF2FBDBB7CA736BD6
      E6231D36D74617E025F87707D676CBCA904AD7AFADD75B5B1B5EC0B5C1DFDD5F
      DB0D2B837FF1A49B6BC34BB836FCFB4DAF2D68AD910FBA00AFC0BF0E790ABED9
      B5618241656D74015E817FEFB26B2579DFBDB575D728095DC0B5751F879268EA
      FEE7AFAD13AC5112BA00AFC0BF6A6DE8CD726018FC0CDCDB77DD56A7F5792B6B
      6F7702BFDF0F5CD77276CBD92D67B79CDD7276CBD977776D96B39B9CBDD76DB9
      BD5EBFB79DB5FBBD6ED0EDFA6DCBDA2D6BB7ACDDB276CBDA2D6BB7ACFD1B61ED
      483F7B9DBE5BC3DB4F3174BCEB05FDEE1DB8FBFD77FDBF0977C7857FC1267FFB
      DC9DA8DCC3F176D7B9FB8324976F9BBBDF28B91033FF6FCBDDD724972A7FFF86
      D7760B77FFB625978772F71D965CBE84BBFBAEDBEFB483EE76EE8E15F97C8C33
      099E62D3BF25E6AEB6FDF1F6F89B61EE77B74658E66E99BB65EEBBBD36CBDCF7
      88B9B7917FB76A54F756BBDDF1DB81DB33E0A2006079BBE5ED96B75BDE6E79FB
      B7B436CBDBF786B7B7BC56CFF53BDD7E8DE2DEF3DA7DBFD3F7ACE26E99BB65EE
      96B95BE66E99FB0EAFCD32F70A73F7DBFDC00F82603B73EFF77D2F4097BC55DC
      2D6FB7BCDDF276CBDB2D6FDFDDB559DE5EE1ED9D6EA7E776BAEDEDBCBD1B74BA
      DDAEDBF62D6FB7BCDDF276CBDB2D6FB7BC7D77D766797B85B7775DDFEFFB7E0D
      6F3FF57ABEE7B7FAAD4ECF5AE52D77B7DCDD7277CBDD2D77DFDDB559EE5EE1EE
      FDAE1FB47A7E6D269CE78166DFEDFA1DCBDD2D77B7DCDD7277CBDD2D77DFDDB5
      59EE6E72F7C0EF05DD76BF5FE3733FEDB73B7DBFDB6DFB96B95BE66E99BB65EE
      96B95BE6BEBB6BB3CCBDC2DCE149BFDDF23B750175AD56BFD7EF75ACD3FD1196
      F2CDB07373416AE5969D5B766ED9F9B7B836CBCEF7879D076E2BF0FA815F93FC
      D6F2BAEDB6DF6EDBE437ABAB5B5DDD3277CBDC2D73DFE1B559E65E61EEED8EDF
      E900A1A931C4079D7EAFDBEDB5AC21DE3277CBDC2D73B7CCDD32F71D5E9B65EE
      15E6DE09DABD6ED0ABD1DC4FB1C971BBD5EBD882B396BB5BEE6EB9BBE5EE96BB
      EFF2DA2C7737B97BDB6D77DD76D0F56AB83BB0F6BE1B04D6CD6E79BBE5ED96B7
      5BDE6E79FB0EAFCDF2F60A6FF75A2DD7F5823ADEEEF5FD8EDB6BB92DD76AEE96
      BB5BEE6EB9BBE5EE96BBEFEEDA2C77AF72F7B6DBEDF4DD1ABB7CA7E7B6DBDDB6
      672BCE5ADE6E79BBE5ED96B75BDEBEC36BB3BCBDC2DB03CFEFB5BC6E5D409D07
      37F4FA2DCFB39ABBE5EE96BB5BEE6EB9BBE5EE3BBC36CBDD4DEEDE71817BF7BA
      6E1D77EFFB5EBFE5FAB66E8D65EE96B95BE66E99BB65EEBBBC36CBDC2BCCBDE5
      7B5D2FE8D438DD5BDD4ED06EB56AACF26E0917F7BE40B9131C7CF8CF6DAEC300
      01040BC88A78341B4C46B9E70CC209C0212E32BEF0102E7FCB9A1E9DC7E312BD
      872DF10B18FF97EF1C02E0CB56E93F6C955F20023C043FBFA48A0FAEB2F5C055
      DE5F18788255DE28E6E02A8387ADF20BC4823F7195728DED8D35B29477E75592
      3C703F01E1CF5F65E7AE3B8998BF6D95B7080BBBB1CAEEC3F01565833561EF76
      B1E1CF5F65EF61ABBC457C5062DF9A0081A67D3768D7D4ACEFB67BED4EBFEFF9
      DB20B4CBA681B5ED7EB071E0B125C427320D3C5ACCC59F26F43E9E69A094EC77
      666D7FAE69E0CB64BB2F5CDBAE98069EA22EE31770FE6FC65CF505FC7E9728C9
      8DE6AA071B0776964A220B5F636977300E74FA6DBFEB765B757EFD20087C0F78
      E237C0DC71DF9FCCF2BFCBCCFD9BB6D63D98B9EFB0B5EEC999BB76CAFCF96BFB
      9ACCFDA97D5196B9EF2C25B1CCFD1ECCBDDF0EFCA0DBAE6925EBF981DBF1FAED
      6F4273B7CCFD5B445BCBDC2D73B7CCDD3277CBDC1F9DB9773DDFF37AADDA983D
      AFE7FA1D37E8B77B96BB5BEE6EB9BBE5EE96BBEF0001B1DCDD72F7BB70F796EB
      FB7DBFAE4F3CD0D7B61F8004D0B1CCDD3277CBDC2D73B7CC7D07088865EE96B9
      DF85B9B75DAFDDF2BDBA02F6AD56AFDBE9B45DEB74B7CCDD3277CBDC2D73DF05
      026299BB65EE7761EE9D7EAF8D9DE26B987B17D039E8743CCBDC2D73B7CCDD32
      77CBDC77818058E66E99FB5D987BB7EDB7836EB7B39DB9F7DB41C7EBF9416079
      FB839762B3DF6CF6DB63E39ECD7EB3ECDCB273CBCE153BEFB57DF81198768D97
      DDF5BA5EBBDDB5F1F18FBCC55655B7AABA55D5ADAA6E79BBE5ED4FC6DB7BD807
      BEDFAAC96C0735BDD30A7A3680CEF276CBDB2D6FB7BC7D270888E5ED96B7DF81
      B7F7E117D7F3FC6E5DEE5BBBDD71DBEDBE6F3577CBDD2D77B7DCDD72F75D2020
      96BB5BEE7E07EEEEB96EA7DB83A5D7B689F7BB6DAFDD07F5DDB277CBDE2D7BB7
      ECDDB2F71D202096BD5BF67E27F6EE77822068D596A5EBF5DAAD5EDBB311F296
      BB5BEE6EB9BBE5EE3B41402C77B7DCFD4EDCBDDB6A77BBAD564D4CDDA9D7F6FD
      563768B56C90BC65EF96BD5BF66ED9FB2E1010CBDE2D7BBF137BEF77BD56AFD3
      0BB6B3F7A0DFF13ADD7ECFEAEE96B95BE66E99BB65EEBB40402C73B7CCFD2ECC
      DDF303BF8B596F7596F97E27705B5DDB30C67277CBDD2D77B7DC7D270888E5EE
      96BBDF89BB076EE0FB6EAFA6A6FCA90774287041B7B7CABB65EF96BD5BF66ED9
      FB2E1010CBDE2D7BBF0B7BF73DDF6DB5824E5DCB18BFD36EB97D9BF06E99BB65
      EE96B95BE6BE1304C43277CBDCEFC4DCFB7EAFE3B9DD5ADDDD0B3AFD7617B8A2
      65EF0F5E8A2D3D6B4BCF3E36EED9D2B396A35B8E6E39BAE6E82DE0967DB7DDAD
      09A43BF5BA9D76DBEBB5ADBEFEC89B6CF575ABAF5B7DDDEAEB96BB5BEEFE74DC
      BDDDE9F7BBDDC0ADE1EE3EB0F61E28F53609CE7277CBDD2D77B7DC7D170888E5
      EE96BBDF85BB072DB7D309DABDDA02756EAFE3765CDFB277CBDE2D7BB7ECDDB2
      F79D202096BD5BF67E27F6DEEBB47A3DAF55575EDE6FB75AADAEDFB3A679CBDD
      2D77B7DCDD72F75D202096BB5BEE7E17EEDE6E77FA9D5E37A80DA5EB74FA5DD7
      EB0596BD5BF66ED9BB65EF96BDEF0201B1ECDDB2F7BBB0F7AED7E9B9BD7EAFAE
      A77BB7D3E906BE17D84079CBDD2D77B7DCDD72F75D202096BB5BEE7E27EEDE75
      D1301FF46B94F7A0D3C50A761DDB19CE7277CBDD2D77B7DC7D170888E5EE96BB
      DF8DBB7B6E10F47DBFCEF1EE797EBF13786D5B80D6B277CBDE2D7BB7EC7D1708
      8865EF96BDDF89BDF7FB9D56BFD7AF498AF3BAF028A8EE366AFE1196626BD8D8
      1A368F8D7BB6868D65E896A15B86AE197ACFED057EBFDBADE9E47EDAF65A7EB7
      D3B5D6F8C7DE64ABAE5B75DDAAEB565DB7DCDD72F7A7E3EE9EDF0DBA3DB7CE1A
      DFF7FCA013785D1B4967B9BBE5EE96BB5BEEBE0B04C47277CBDDEFC4DD3BED56
      C7EBD4C7C9BBBD960BC7D5BADA2D77B7DCDD7277CBDD77818058EE6EB9FBDDB8
      7BBFDF0E3CAF86BB9FFAAEDB0DFA41DF9697B7ECDDB277CBDE2D7BDF090262D9
      BB65EF7761EFFDAEEBF6DAEDDA0A75AD008DF73690CE3277CBDC2D73B7CC7D27
      088865EE96B9DF81B9FB6EDBC74079B755C3DCBDC0F5DAC0FF7DABBB5BF66ED9
      BB65EF96BDEF0201B1ECDDB2F73BB1F74ECFED74DB7E1D7B0776D8EE7B5ECB72
      77CBDD2D77B7DCDD72F75D202096BB5BEE7E37EEDEF7DC8EEF059FE1F77FA3AB
      E9A5C8B2682C608C58FC51B9249F0AE08D7EBBE5772A3F8ED225AC6510E7AACD
      DCDA539D7E3BF0836EBBBDFD297FFB530136AEEB063D7FFB532DCDDAD69EEBB6
      5D0FA6E8D53C176C7F5B9944B0FDB176CD63BA12D0F6C73ADB1F2B65ABED8F75
      6BDEA6FBF92195DBF660AF06967E0FE0DFEF07DB9FEAD7BCCEF3032C52E8756B
      B6DBDDFE5CAFDB727BBD7EAFE6A91A2C29FB1DD43CE7D7EDB8E7765BED6EB7D5
      AA43CBD6F637763BFD5E1B11BAE6B13A54D1B51D6B9EABC195F2C8D53C57832C
      9DC0EBF55DD8F5BA4DF7EAD0A505E271DF6D77EB5E58832D65504ECD7375F8E2
      BB6EAB5383D27E0DB278AEDF0982A0554B1DBCDA6DD7653A6A9EAC212C65E5ED
      9AE76AD0A5D78699F6DA41DD6375E8A2BB74D53C57832E6DD838B71D746BCFBA
      5F832F9EDFF77B1D38143507C9AF41971626402355AA79AC0E5B80D4BAAD56D0
      A97B5D0DB60082F9BD96D7ADD9BD965BB7EFADAEEBC312EB8E6DAB86BEB4FC76
      1FD8505073185A75D8E2F6BB5EABD7E9D53D57832D7DAC110314B466D75B35D8
      D271E1B4F7BAAE5BB7EBAD3A4EA45DED35CFD5604B17B8106059B706AB5B35C8
      821A189009B766D35B35C8D2056CF17A2DB76ED3FB759BEE036DE97760A2355C
      BD86BAB4BDB60B64BE8EAB0735B802C8E50296B56A5617D4E18ACE55A879AE06
      573A2021F95DE062759B1ED44A2DAAB041CD73B5AC48B96E6A9EAB419620705B
      8107C7A8E6B13A46E40259E9819CEDD53CD7ABDBF60E08725D2FE8D43D58C789
      5A204B0058821A3C6BD7A04B0B4E3AF0A36E0D676FD7A00BC83B44916AD0A55D
      832E6D60D04023825A0ADFAEC117CF0BDC004E44AFEE8535E8D2EA77FDA0D5AB
      9D670DB604ED8EDFE9B07962DB6335C8023CCFEFF9FD560D8EB5BBAC7964E2B2
      18C6CE1F9F928B24BD4AFEFA9970E1DF068BE982AEE3874104FFB883A8081738
      097790C17FF910FE0B7127D51DAD5BEFB87D0CAFE60E9E6B1E8D7152F4A1D36B
      B5BC4E973E77E138F5815CE067D89D5EBB4F6C683E0F8BD9CF19FF7D9D26452B
      18CC87D9C58B089447F9E17C096F98E7F3308E5F6721556F9A8FA37CF1524CBC
      C13C7E176653BA3BD39FC662F2BF47F0DB55162EDE90224936BF7994146FA339
      7C48C26C059F7006513249FF1884CB629666CEAB18EEC90B913DFF043FA50B91
      85055CFE08BFC1D5C479954C6391C14FA34C80E23A1FAC32DFF57A83790ADAD4
      78E50D66590B5FE3E3C8B86F37DC8248015B9E476982778B31BE1A112C49278B
      702AF830C197AB341B8388DEEAB146075746B330CBBB1DBFD7FF5C7EBFCA7BFD
      A01FF0A849BFC51B723D8F61418426F4D1736645B1F8FEBBEFF2D14CCCC3BC39
      8F46599AA793A2394AE7DFA593493412DFE12BBF4361953ECDE3CF9F078B10A0
      71E581B8DCE1CF3320E3B0A173007ACCE0854F99FE54E84F43FA345D16005740
      9B22CBC5A84083F355344EAF4645160F264532FCFB2014C9789C8E0605ECF2C5
      1CCE43EEF2E7499A017E145132F506E334490B014AFF385FE513C0180F001DAF
      D2E4721EBBC6AFA0DC4FC76111C29BB3098C2A2E010D60C0CB308EE0BA006878
      837C965E2DE2702466693C462303A0FF344933318FAEC57804A3A31102D0FB52
      44093D798D6FC1C7E0039C57C00B0F76E03A86E9A52B91C0AAC4F5229F654502
      9797B0D8385F8C06E304B620C987E3215C2533072C6909EB8685E5B310280260
      D83F71EDE3E99CB0183ECCE846E060F0F9D2F80CB74653365FE32F956F339C9A
      470FE007B47AC07CC2643CB88CC4D545948C3DFA948FC25800535C4C87D9389B
      89702C3F4ED2B418E48B78555C2551227067F4E759318773922F600D71322BC2
      F1DF615583652EE26218C6C900FE830BF08E013C022F18C1B72BFA021FB2629A
      0DE2048E342C5CC010F0E92A430A36C8937051A453207E513212710C03C5E9D5
      2412311CDD310C3F801B17CB6484B6BB308F423D0A52930C66AC28CA20115730
      625EACE0E71C5E32CDD22B98733A890A9C6882F02E560076A4B8F03B4C360132
      53E48389C0C989585CC2E5D175BE20230F9087316CE1155E17B8A5E16404E709
      671D4EE8E625A0653C98D11D08B802486498C19DC5E832245815305B7C689221
      40F0C265585C0FAF071759B2C8F24414835108A711F02D06383A8838111CC645
      583830ADC265727F05783C991793288673E4F801B0683CFB408796992866595A
      14B100E21C4FD279380A8B519C2C17ED2E1E38989033C0533776D4F903F29D88
      6B77805B2FB21528EC03DC7AF91166925FE307807F321399A0A7F111DC25B4AA
      D1686212028A8F6007E9003BC49512F829BE84C3B54896A36C8E17D0E487DFD9
      A887EEA445320B9329F2AEA4B82E42A7C9D44A3DECC346E3E330D92F7ABE059F
      80937ED1B3017C8AEFFEE693EAD3EDBBBF79E81C7FAE1BA64300B8F3346E1AAA
      4B03DD6D236E1AA7F75813EADF654288F35B4702E69301B18AC32871246E0FFE
      0187A614474098068A4DFF0EF1EC03990FF92F301CC0627C02250389BE405116
      61BC9885F82159CE0713BA7B902E09E1C9CAEC0E80D82DF30248EDAC80D72464
      3C56B2120C189A720D483F453C9A0D262360B740275AA863C1DFDCF781B4C1EA
      3CD76FD3E4F926F6BEE2AFF863CBED79F46122E03E904453B88B07E90C6691F1
      653CD45FDA83119E4C7A2E591843240B1C04B6A532A5213CE6E28C825E651E83
      E160E2F9E8190E7A0380CD6C7001B20470D2560728616E2E7280424765D5BFCE
      C2E259EE000976606FAE5F8DA3C269355BCDBEF3E2D5C7E7FF13311AE8106FE0
      9FB775DEFDB6AE0E50AD4E0DA0003204A85BC17378F062399D805C91FF899078
      C8DA79E17E505DB85CB61FDC65C51F67C261EF0FE0909389459A1562EC4479BE
      14B93303B1CA190A90AB112CE3EF255C585722974F79D6351B5B9BE2DAE46450
      C3AD53D3A74A1D22978FD6A4E50C9E0DBB0360FE9FB7EC4F2544E2CE1BB5E67B
      C267EFB07571BE1D75F1F13F6D038FF59EA589034AD708D48113E7D49987C912
      4495512C42240F4E3A715E8657C97409106B8A7C0E7B4D02BC13387310A7E12B
      3E993B0510776799E323FF0021E78247D8B18DAF5F36AA0938F702F07AB4CC72
      D00D4185499C0BB172AE6680C8B068FC1D48CF1CD50DE72A2A660EAA387F91B7
      0365C487510677E05DCE08E091891CF0007F628D62C7C051070CD08A70AD219C
      DE5838735842B4800FA0F3C2BE0F51C30120C5296D367303D86BC489CFEB78EA
      139EBA1B2C31B8EB3270064DD4D29AA8DAE10C36DEF1D0B340EFC075CD405651
      DB880A26123810A1BF914DC359133D0154CD0B0704FDE53CD9C0CA08D8785A38
      617C15AE72C4CFE89FA80DEDD81AE19C4ED225ECC670E58C91D7A3C106177906
      07CEF98B7316238581F5FF82EBFA91341D38AF82170710C950A959F1FA041F6A
      82478EF40CBFD283E10415AE1C8EF26846873FE55B7174862F53372BE0BC549B
      E00009C8C3A970960B3C907F26687640E2196F806116E62CE8E4314E0C700EA6
      28C2396EE2D80991A0A0E83C0141C989E68B0C58E7B8E91C7F046E79913B3F84
      7391FD9C8AE25F4EBE128EDD53FFB9A3B6018B790A7DA367F50DC6C533D4A405
      D2ABFF43B2D66FCF61B2BF03592C45AE3D3891CF41DE84A3A8F92188A085A4E9
      5A7CADC8AE0D076655681E90A74B1074C3284B9CAB348BC764890536024CC489
      530070067F422D124CE1B0369D8F3360A1F0FF20DD8174C00A0FBD1910368CE1
      E88F57CE02F80E0889F860ABE9373DA20370F687C06A5752806ACA7DFA98A28E
      0423D0B0305843223C71EA2B90C7B30B12C6E2D89966E97291D36873B49228D9
      1B68D03C1D4793088020C53329C291E8CA52F926A6C8C5C0FD2381023C4CBA94
      6F01B7860256308E2EA331680448D9400C1B371CF2A30058008A399034F8E12A
      8B0AD2159605416AB82A60C04996CEE92BDBB141A920614EAD1B5F3D8759E4BC
      6FE62469762061C392110400B9F112762604716732111982F6ECC399A972D06B
      E2B1D25EE6A298A563E7585C2F8097474896C305CC146F95665604A2F133D074
      34D9E30D9F5E7EA05F59D171DE7C7C77D2B4D4F976EADC0D2D79B6E6206B0EBA
      BF39C8FFDAE6A03A9DF2F92FCE7899F19612E1052A3C5C46642AB124F10E24D1
      52444B112D45BC3F456CED2C451C23ED6B38E7F0237D4049F18CB58DC383A9F3
      2EC420A39CACBF314AC92047932D118D52CB4511C170C73FC32F206B8F660284
      5D14EC417A5FA20DF20A3DF2CE2A5D82203BC61B50CD23597C2EC725B3339296
      CEBFFC8B361AEC0ADAD4014D92C79F803C7E7C7F561AEAA204F406562D6620E7
      1F1E94963BA973194F92F59215371CE40A949E584C0A275DC029028DEB324A97
      390AFAC9986E3A7A9926CF0A1E399CA2BAB44C8A2896401D1F31F887E9356A5A
      F4598CB7BCF63568050EE827A0844CB370EE9063FB1B81FBF9F92B62455B2CA3
      186617872BE7178E5373CED2A4C8D2D879934C52C7439D506B9784720806756F
      101C1E5896F69AE37376CDA7F3D54977F0B549F7D119D15544E157E4753B5256
      84CB684C8E1E8C57E4032DF2DCC138518C4204D4B67AFE1D84DA8E156AA58887
      9E3334839D71382999D20CDEB15FC22E32E5E1B22852ED742CD205B368E02309
      9C3869765D67AEC7619CA76CA91CA7355C18407D4232D550A0D197C42AE2EC00
      F0199C6A27743676431FE6BB38A5EFE1927E992EF14DE4837C7C67747AC709DF
      CB8BFE0A20923DFE5CE53E913886C6DA7C042244CCB67538AD239448380C156E
      851D432FB4DA955FA33188156929D0A14D9DB098F691848ED0012125426AAD9E
      3A2FC24238C797511ED16E6728D69C90CC77B56540B2584B636E5EA4197C213C
      C35B08F7108772160FBF16EDDF218266BDBC44C9F28518815A02327218A753E9
      51429451502187052A20E27A142FF3E852A8D08118D434628FA56398DD08E3D2
      EF21D4C02895E06DE1165D05394908C81AC5A2D4549A40126144A9AC34385085
      C792CE920209240E9354749E10B9382C4266A5E029617E2E8F99D48936BDDAE8
      EB01050D5F0613F202D06557D27A21AE1751E9C682D3E4FC1C820A91E43C2F53
      BBBA5515633F392F224D943EC8B7EA036B4E4E3E690255FD4C8368288C23A9F0
      E861DEB3124EC71F35BF38CD258D20ADF1CD3350F7E45270CD30F5343394450D
      1A0533141E613D4A830444901FCDC9A15E408F023684141A804FC801949FAC44
      1ECC5608730D5C692F9012AC3311623C0C3900069FE3AD7CC97A9F22CAFFAAEF
      C2F700AD41E5192D0BC52C4A2E60BD2BA695482567E93246CFA15E9374225248
      114F05DFF593B85EE6EFD2716E49E5C18FCBA94033850CE950FEC3102DE47876
      8FCE308F4C382F455C103A8D66477B4445A3B9009223C67C3E1C4EAAA390C231
      01648100A19F10C73A6DF7DD0BE79C12B956E7D135C5991A0414BDBFF29C602E
      A583A594E651B2442FF3B1E73A80BF597E82472F1CA20FBAAD7EB5886A2DEFD6
      F27E2FF34DFB6B9B6FEA8C99AC5FB2EFB1B4685EA519F1C15F618E3BB695F5C1
      E624D621A33E7A0D8CFB791C1FA9705D5662E6E958341C150354388B34677D87
      1C010947E3440952D59CB9B4567E6498EB8E81A20E103FBEF9F8EE15D07014C6
      DEBC747ECE04C642FDF8663A13283781BECFFE145460B348008D07A0FDF0E1D3
      CF202B0D455C75B36080552CE6DFCADACF300F1484AC73A5296F718B2C7315BC
      4C767B7886B0E4578D25DFC85A5F60DE2F5CFA314A0AE57AC89DB390457114F2
      41DA9E3A98F4FD1D6030B07333726D04E48845E4F9CE99DBEB56FC4B98A13F4A
      C607929A75FD72395FF0BAB265C2C935894AB22095521E77156C289D7EDFC88A
      F374CE7A0E28B4981F0272583A99E0E6B2C695B3CA45EB0F51135D21D5023D6D
      058B9CD3DE93C9467C2BDEB56BED5B43E55666544C3087841CBE20E2CE0C875B
      3429956933A27447934C6AD22FD0E6A9E22DDFFFC79ABDF71D79B12541D33AB6
      266B124243412218190971FD20E663BC2C9DF4C383C736D63E8DE5F3DBD8ADAB
      E1FBC904CED34B4047E01CF919D69FC1E068609AA310794B4661E423ED2FD371
      0848AF48505C11327F1BEB5D266CEFC52C3134388BEC328C1D36705C291E43C6
      27BE6F86DC08D09429100813693289A6CB4C2AAD9E3FE3A124C3D24EEF1D0703
      68D8A25087946C4AC77FC3CF4094913027A993E23710A660BB29A4BCB41E8E45
      0847F7122D17F0A30C38B74AF4273283CB83625AC2F645AB56D6E2C30340149C
      0EFACB4724A34ACB175991151DD9B0376F828CE2FFA547AF5866681205F58508
      8F11BD530EA99F973E8923275D982EFB37134CC9E0DFC89774194631BA921A30
      9BA1943FE9C4570DC47082A475BF7C83646B481A30DAC778854ECD8077A1B90A
      0D4D69B9CE63D19C369DA0E936AF1BF0C7C73FCD66F384A51E7E92869424065F
      3B893238A244688E95AB215216EE13BC452F8BA021E5C61FA2E2C725E57396EA
      02102A5CF1D8398615AC0357B369298E7DB5A4861D3AD71FA345BE9F3E2E5AB9
      7414AD05B7192632091AF26E851782BDB8E1880AD9E9E8440A5584EB74364CA7
      07BDA3CCA5CAC43F9691F42A00EF14994A0972F041BCB9595C17E489613E7505
      E796C301A4774D5C0B8BB4071F282E0F58F5844E7EBA73D69EAF6EC3EC7C6D1B
      E6D6A84A99D0877520955F8492FA42ACAA80582F8311B08C02ACFC51D5A015FC
      EF743E3F1D8F9D4FB9C8BE77AE1D2C9F78FDBDB37A82B09009C992AE8DA6BB43
      345DDB46D3D9E0138331DF506240C2C3C81C8E92CBA8300202D8FD0998C5C225
      501C44AE868EAD580B0E2109160D531CCD6204D1F35DC07657E9D20CF1582716
      51DDBAA3FBAC5CCFD48836881F9F301D1E500084824498A3704122F7558881EE
      0C89321AC2045582011C24A423A5C661504699A6B26C881E8EFD1014A6812116
      23E0CE45B6449DDAD8264AF0A0522D246AA95D7B4626088E244D3395454E81C9
      5B433DAC2C64BDDBD6BB7D2FC9B0FBB525C37AA730A953B8A7D2199A4E9C50E6
      E09436748A8B4B64E434DC24C3FBB88E91ACDA25A35D434A50DB3104A85BFC6F
      AFDF07BF3BAF7F7AFE8E3CBC6FDFBF4071992CB6DFC80A2EA3ACC0D21347BFEA
      522247AA9A06516F3187E7C26CC5BA6F84515122962E6CDA5660E687075889DA
      B90CE3A550954C36D1E2D70F6F5F562B53ED0A70EAB1FBD7D29D7B962E56A8E5
      A8B2F8CE3159FDF0AB2C2472D2708E7E4A9197526C4435D8C34C4D9BC4E114E3
      156134B27A8B5D03486D1A29EDAD010FB2711C539D1815EC41567A278F00ADD8
      6057162EC35CC879B8728EB1080C795B4168821B400C19C66172B17BAE8A1A38
      BC860DCCB9E48EDC5E58D1A764078D1A751E519115281FC209CE8AD1120B43E2
      2A38C2871C3029E73FA0E11705CF906541158EBC92F266F26CE7DCDEDB17FC01
      70349D6365880AD7A1F5C89A90562C3D17210C40ACF8FF4B015A8020FB9816F6
      DCC9191002B51684C63F111AD4F961082028A5D5703C9666E66ADE1752BB32FB
      E7B183039EBFFDE8FCC539FF7A495CF798EB1988FE1FDEC2745F3F4101D474B4
      CC65DA96DE2F05744260E94B1AB13D135D4CC4B31F7D91BC44B7E1FC85124E4E
      1F7DAD4F854AAF5B8FBF2D65E60B72184A21A1726D23CA80BC10025D38B46154
      D74CA5918C96199548937589419E882AB9CDDF48844DB97C9388DC07006AE5AA
      6C841CE7865C1C423A529D72ED9F659F58CD106B7948FBCCF29096039AFE18CE
      87CB0CFD7DEF44B2DC175E7784CB3F42EC3C3C40278F8E3E504EF72A582CBE1C
      1C9DA3CEFB4986626160F0115AB3B065536989768EB05CA5C3C0E5788F7DC1A8
      C3035299B78169B35E8D8AB03D066247023BAD4B068F30E992D15F689456F16F
      CA814F01A85C4DD32B13ABD6A26622744220995D0F9BA96276C3A10E7832FA4C
      BD892BACA30088ABC17800D67D8C4803BE531D8C4AA06919B54376121A38475B
      0B3E2233CD23D22B311576EB10BFFDE7EF0A561CF5071A19B603C3DFA5BBC46B
      C35020E060841159D5220A550F170BA0F939C5CFA0544A91843497244DFF29F4
      D3AECD39D3987B539576609AFF1BE3E03FA6DFCA497EA84C6B00A32A2661CFB3
      47D03592AA5D48C25986E571CC818438DF1B16D27E6631F54026E70311CBC614
      96816D26BE15C47C388B79A5C2B02AEB57E49A8385ABD15BE3265730C00C0719
      D0820DEDA2B8264EEB0D710E33814D9B7D759B0DD42A591097241A9E473686C2
      00270D0FFEC04AF93FC17F83CFCD72AEEFE55034E9A1C8D5A8364E8CE5076D46
      A96E1180677F509CE28C0D508C417B249FCC4DD84BA24AB50ABC59A841472F5E
      C1B87922AE9A5931B1C14EB7073B0536D8C9C62DD8B885FBC72DF4BE76DCC2BF
      B6FB8173EA1CBD4D47618C3D9516F1721A2547CE04BBF792910D14C42CBD10BB
      D6F3AD3E5F95022474655D3471B3563B923EBD519401AFC80B2CEA921BBDDC8C
      52BEE944FAE577CE5D89AB06F97673DD215530FE8E245FFCB00D0ED4CE4D360E
      AB0F6BC0D4136A9DED1C572ACC026CD0CD898FA17CB773558AB73B36DF86D828
      666A1A1454B3B42B148561AB9B780093692E05644085E6300FBF6B0E43DF212B
      F4E5EEE5A76F5FECA78FAF7B8E48408C26CB798A320E1FECB1A31689F57BD00C
      3409E398C216E7022D46513E479392BA8BB584C26144C071772FF8603B0C3231
      290B8A2C73CC64C1A257733818D98ACD61891861106EB6FA3656249D149CC56B
      E031E5E721B55A082A3B30A3D27521E5A5A709C8B34991AD541136695D3C3CA0
      12731C107B85595268BAD175CE760C20B50D03A3044370618E80EC119F59D90D
      300E1718ACF09DB85EC0CAC950B85A482BA541E0AAED138FB1E111FDC661B978
      F358E4A32C627E3014D8E84D066AEF1AE1FB57AC9B75EA7C207EC88A75B28C63
      299F878B85CE6304D963A86B12ECB198FE1A2DE0CBC2E9769C7CB940B0ED8FC0
      FE03D66C2BAB64EB2C044CF76B62609E8EC223E11DC39EA83253999686FA7513
      D06DBD734C399648385FB5243D54A9DBB0164D9698D84A6DD8D6EAC3718D02FA
      9906DED2A286EEC1FDE3EEBB3A91616357F1CD5391888CD268B9899BB4062C52
      F417706BB96485D4B24C1008E524B194024CBF4083417A8109955BE68A6F9C2F
      47330EEC454E2A4B05D2E454B60745FE8FB2309F959E8417F0641E4D93681281
      7006F39853FE25A64B63AC19BBB173865646418358472951F51BD7B30519DA63
      985F3459C9F8826445CAFAD1A7E4027600C47A0A4195ADD9D6C274AC69ED40DA
      D4E608499C1FF6150CE702E5E7FD21101FAF52429A1A40ACA3CD97E8F4DB5D2F
      FFAD34FBFE4335FB07BAA74E711E485FEF14C28355C7EFE19B3A757E559545B4
      EB76A34A902AB30C28848060626F76C561E28BCE6B8E9DC504F46C2C33AFD80E
      41A9E34DF4365031F9FC0253CFE5DB7EA01227E5FB28C1BC52C202DF98D32B59
      8B510F7D8932F727A0EC536000662103DE3D8987F2D47903527374D7FEF04F86
      BCF7236F4DC6DD2AA6E8EA38E88F7A8B8594414328251C2CC987EC9F9C04C958
      55A37F01DA3396D2812B6F291CDCB2D083231D3772B457916218157D548D9939
      520567B45C5C0987AE69A34141A157513246219BBC5CAA6C0D68F968B7012D75
      C952F2B18C888C579C4352DAE105D7D5B4F6F635AEEC6D77ABFD89067769680F
      8D98B75DD91D4DFB8EA389CA52DE355B878C88DB1FAAF28E6D9770E4232A66A7
      85A665A2AC981130B0E3BFC93A6F4024C6B29414259D5F17545CB7ECB02DAFD2
      9839659B4D057CA37019A24CD4BF1BDFC736B2C912DBA159CE76700642C0021D
      093AD285F3FC5E1A764280D96BCC10E360ADFDC1D28F647B95F0A108FB2C4CF2
      38E4A63FCAA7709C0B214DA9784F69BBE01E5054194A83772C123358A850DD36
      1E5BD6FC1FA3C5F7D7F0BF7F7F0A45098BE772F34F799A4CA3726A9AF59B8FBE
      305CD453E46FC89CA1C79EEEB298F49E24630B8D60ACFF690C653B78C3A1B27E
      8FDF96CBF3DBFEE36738E9E9CB3AAE319A6FC99D1500799F4605D06DD4B3D16A
      89B5D3F1D4B8F9932D12CF8DDB6FB9773B375F94CBB5BFBCE65C14E4C9A9D0D4
      5879B2312F996F6097F5FEF099CDB0530084F4FC4948510E19172BD5003B467B
      265C52AC45B5ACA1A51A8D9A40C465FE7482AC070873345929E6538138B0322E
      22943B479F480AA8FCFCFD91A2F7DAFC8FA6305578F4C4A8A698515553ADC861
      74E2A737DA7FA1EA3D355009DC320D498B5135E430DB909924E6D411E91BC395
      C7A6D4BF8D164A04FAFD4998A634E8C9C5B1D2CC55ACA34924D0227D21082CDF
      DF8EF9257617D77DAF03FF7ABD960F7FFC6ED0833FAD4E27803F41BBE7C29F76
      D0C75B3A8187B7745B3EDED2F383809FC65BE008756918B7DFC79B3CAFEFE25D
      9E0FF7E1DF5637A0FB824EBBF3B4478ACC788FB899129A2299C24998FD0D39B2
      BC7401739AA6C9DF3AF0BF7DA136BA6520E11CD76E21064BC2CF6357727C3AF1
      675DF839BE42ADFA092402448E27A83A896D181A656F46F2256099E6EB106336
      4C5A6A6C975E2DE57485A0FC8EC8D14BFA0495E940BF43795B849566B2E85285
      832BD661659183F58636FB74FEF5DA0F0F543B1FD37E2223AC5071E5682AE4D0
      AC5C50D326CDD575DB5C155B113EBED364A3F1D0F1F5C913B0675BFDD5784B5D
      4244CB264448815D35D2D4B2F8DE055C49C738C716EBEA130C05000CD789A62E
      D6F84B946973998A5C3A3C5839CF7F3A7F8369E098405708CC02C550A32C8483
      9E9DA827A4BF48A6F4495BB1D967AC9401E6E162816ACB501457B2EB2D0F96AB
      96B930117A15470C9D208744D5AA89DDDC38895F4615E665DBE15938E60E5071
      348F7071A61E138E46B21DD0DC84084D721C61A52CDD178D1A08D19269C68707
      38E75096B2E1BE52E5AF64929DC8A25C234C1FA73B149DE29995495F39867AAE
      3830B86E3C56B7B0AF13F6A0A35BA56831D2D1D5BC973AA7200E73BC2DD511D4
      CD1DF39C7C7DDFDB76B2F4A716E9FC818F943E62A7C8E5732EA12043E348B924
      E53AC193D9302A37634414860F37B80B11660AD23DA5532611D8C756B5B157A1
      8671B82A630376051F0E0F7E79F7FC250682C2D28A88711743A525704877C8B2
      7055E2B40617F5F216D7682E01DC3FBF5865D19CE8461C025C28957845F05070
      26F2A6F3808DF3AF4E1A9A63A8C00405AF97DEAAAB70C5D52E64D5C4DD3C5B6F
      37922C4CC4DA04824E347D7C254CE5B23C41353122D7B2CF9FDCC2282F134C76
      6D530E0F3E6E7342DDBC336BE8294FB63CC28ACD7013472AF48DBE53B2428A26
      15527F3F8C23E08E49434723B71A7432D457AA7E27A6618E2A6D751EF0461183
      7A85491C8B381A457814E66176C19550730C328ECC7AE19B31C03C09E34052BF
      A6067B7529840E4E58BC1C533EC44AED9D011FE758C184156E555DBE02A0FBA1
      EF3D90F7F0E0EBA1EFC95A9A8D4A12A384B778B589E7FFED45D71FC4E141955D
      52092C6EF768A0284A6D5A1243DF97734CD214E6DE014577DE9C342B6DC10C07
      2F7BD01F3D7C70B43895C2F3F7FF43CDEC49FCBB6C477A7C97F4BDE67C4F739A
      2322E2A55B424277D786B9E6BAA5906099B091A4D99C4E280B5F4351A6F7ADD5
      2589B4E0B02EFA5014F206624BAA07B417F31F9BA5BB06B409124CD647A7F499
      75D5AE1C17553026FA9AC8528B09CADA245F0DD06416744AFB25ADB14C52AEA6
      BC6C0A1E1C4F8DEB878BC330E73C616E19293570945989BC3FCB31AEBF506C0D
      2924FD26BF3F365ADF8BB6DFF3201275373B9A481E788C34FCFCD549632D40B2
      020C861A72D36982C0B46193EBAA9BFFB55537E993029E820C66C7F6678251E2
      3B3AB7455AC2CDDDB1B98DFE29463B3AB53126C4EFE89682B4BFBB939B0AE0C6
      C98ECE2D13E282A7D6DAB1A901198DA35D85DBDFC34598A0D8722A0B41ECD4EC
      40FEBB12D39D051ECA82CBE992C1B783F3039EBFBBD424BF12E39D9D5CB1CC2E
      F4E4821D9B5CB6CC737D26BC1D9B1C16762FE9C95F776C76B365320D330DBC5D
      134D40D41E46239EDBDE04631D1E905277FECA2A720F52E45A3BA9C8ED09FA2A
      1F4050F108743B16A71F84D3C1D7C7E9BD43672AFBA90AC86120C4922BCC68DC
      CD9D489B3ED97A7A4CD4FBF5FB403AC4DE773BEA06F420901174C2F93A05357E
      11D723B12814C568AA5454F67D5D6D26F1ABE8918D6897AD75F01ADC265977A3
      29B32B7227BF8A8AD10C4DBF859361D780B94AF6D351263285B7120E6886A256
      B3E1C8E8CB1EA84D270885D98CB02C13E725D078E47DA43C1F1D1043B6591905
      F3ADD966CB0406741E26548DECD1D75086B23F45DE9B0C076ADE23A1EA1E9367
      7BF5FF7D2591FD4997C2B5DE09C3A40F45966A07E4432C8F0517FDD1E8371639
      D688D7485D8DADA28C9B22558759A5D5C09523B99C23E7183E1ED159D04CF004
      71B93C751372B79ADE171DCC9DAAE27E4641A227F21CC6DFFF0F35A57AE71BAC
      FE8B93F87EA50E925C148D3B479AD94C4CC280EA3005DAA8AB1F6F14336D98F4
      90FCB305B6A425F04F4535FC4F3FAD339E9E202D109D5EFFDE8C92E8695CF88D
      72F2912EED7A2156845B65F4850C6274F28D7B28EE01C394D83D67FA8CB6F008
      D5F033CA4DD873721E6715303DC6008C307646B3341A9103ED1E4916BB10DD03
      F4ADEC0EC10D8174225D091659B949C693A8E681DC2BED4B79E5668C4E350C54
      33D230DFB641C856B6BB39292C86E745D50EC3B9ECF9762C1DE0F73B058F7B06
      BE9C84A03FBC127CF1F5E8E09723DB099D37F68F0FC504639F990136CA8DA76C
      4C3849EBDA50323632A11129B00A2C6CF330C51A620BAA48D574CE547FED0A4E
      14B32C5D4E6737A3A6EC80AB429A73461BEA8D196FC63C45F54252741FA000F7
      7B7C8AC967B39A20BB76BA2B951A8EF138211F36C2A2D6622E2BC2EDF651542C
      822410D3381D92806EC8BCC708D705B64B8F0AFEA186BF9D18C4E409E2849E38
      3EE8091AC662701341FBBE53BF6F9987ADE51FFF1B453C3D86B4F367463C3D01
      223D455540946B750414920634115CA13D045BF200B51D46319CF9C6D31D8CA7
      38C81135AF9C00FD2A03402B9410699D2AD35B55EFB1342525ECC8C0529056B0
      A8DBCA54F9BF25551840778B718217DAE0540AAE7833D41C7AF20434F189A386
      B5CAFFD849DF2FB3709A26C3344B9E72C34C7CDD2811E82422CC743D42559288
      AB5650D10ACCDF43F5334AB0DD802C8F3F4CA5358704002D8ED97A0C0F4609AE
      26A2E4A0EF1DE9C79580E55FA7952C269D91F63D075F6F445F579EDD22A85507
      F0CA01CE40228F41D1A88E40B1B31B4F76DAAEEB39C79F3EBE3EED9DEC8B1D9C
      5AF9D612B3751D6F57C819E9F8DCFBAE511E62DD3506193815B791D91E4004EC
      B97E789D15D7FDDE757FDFAC19FCBDF39BB4FDCAA3DE3CFFF8E1CD4F3F9CFF2E
      CFDB5D4FE77E9CB67559E931F6E649A5A588BACD08B21536B8D7B4CA25E6AC85
      B4289DBAF6807DF9012B8529ED45A93949CE3199FED49E9FEC33F7D2B9706890
      099F40C67DD2C3C5E63EF23E4574BA1C95E7C8B99165CEA2E5628FC6C582ED5C
      CC5066443EFF9D0BE1CA16BBC7671FCE5AFEF7CFFBAF7BAD17AF5FAB23769FE1
      BEE408DF67FC73F20D80B623AB54EC0B15A0588E5CB971A85D467AA53D0C6418
      CFD298BA1BC5F19ABEC77EB679782133929FA1357F166279900C0E1E57A3C634
      7EED6A21D94596DCD85EBDE3FDF9DED7DCC23E738707683F63C9D0688DFEE7B6
      B1FF66EB2FF9B6FE129F6DDB90DA36A4BE573065FB6B0753FE6BBBD702ED168F
      32FAF9A95A3A9762284B61D037550D9622F8E661C2651A72D8E0F1CEB5AA8545
      619BED31D08782BD995C410AD922453B88F9028352B0DC449A61A57CC2DA132A
      208F2115397568C89DE22AD596DB311B69B84815F0D05DCBF28045B761D14C95
      B1933496F8CAC45C507D440E9099A709552A8EB8B8671CE60597E8A4780E2CAC
      250B6CE551B10CCDDE1F3BB4CA0EACF242AC86299E5DA3CD74E28CB37441DB84
      73CD3510B0BFE3EE2DA30BCBD0A76A98C6E8BE4BCA9DE39E9C1853463DC677AE
      5730ACA087674C819CC31955D9B6852C7490C20AB1EE4159FB61B737A56F2E09
      6705939FA559F44F8CD88C913EA618858D1523B01E1FF67346597A9816453A9F
      A779C1354A776E617D6C591CC6C55F46CB2CA7E2DE97D47F59858F526D0CA35B
      468EBD9D97F3040345D1F9045B394485CE4AC3B74BC39E9586AD346CA5E12F90
      863B5F5F1AEEA2E09817D1E8022962965E5518164761201D4DC2CB68BA8B6DE5
      60091D6A4F4FC5EA2671C8558A7005A374C1C5DA293E1DA40B92E5C759389DCA
      EEE1C8FA163B286A7451587A1916E1D6057D3BCBE86F08E854DA74918198B7E6
      E3479EB251378B92BB4E7B9C4B85F194CB62025FD10A8F6D3B2CCBD96C4ABF3F
      CCE7DC686E4F21F8D8B14A37439D8763AC244BD6CE82B9D3464B7B336108F364
      313C79BE24BD31134C00411981D3A34AA98DD344672719A0A706BE321C592418
      FB32C608BC0CEB9DA9E862714D29388F1D9B86798E78C09A30FE93848A52743A
      9DCF82B9C1E3FBF04E2769F7095A7B84791958AC36EDB94C59E2D609B8387610
      C82ACCA822349C452CC25CA8927A715A50F1622A8D57765C42BA2B73AB30D632
      CC67425A5CA20443516378EDB612AA9666493D024BD5029BD81F7A45454A8FCA
      D51F0139192D492B8D54F153EC426F4647556E0768D9F6187750485DAB9032C6
      7D7A8351B9F37DD248553F862B250F61D849D93367B88C620ADAD0A091E5E455
      37B851115D86A8C3CAA40E33A5EB889E38829187951EC6D2E14C978EA3519AA8
      64C1B51EEC275B9AB03790C75E46215D5793C293AE06972DA9CD28EB1B6E53F1
      D4B8EA0576D2C0CE8413D9DA4F36EE29F05935DE9B048D79BC3E1E9473D46482
      ABF92A8EE6A4A739C83317B8A1A4F02720DABCA592E5C763F4A3645C662045A3
      225C159CA7C141122734FA4BB8CD3956BFAABBE5C3E6CDFC4263FDF87AD98404
      4D78170865E4B8694E2C568A6A520EE364F474A17E6128A85500DD9D711A85AC
      CE2DB7520E4FED18B8F302BA844461B9F701A34378852A290ADCD4A6244D2671
      4435314024DEA3C6D44C6D14F74698A8D3A6244C8688938F086CC7434ACE274C
      2BE014207C980EE4F2CE1CE9C1E4F00005496A4357162C50E7977680CA1B3CD1
      89C39B6B0AA068078E1AE73B7EFE84C7C327CB91F4922A19D4EA625980618D84
      21461D1EE4A0DDC16BB94DAD442F8059B1B422F4E1C15B3115C978DBD9DB2356
      2F753924FF3407C965D509FC256205431F4F47420DB4FC224DA487B848A7D358
      F66AA2C63A943E48F168EAFE224D63794AE543DC8D2F34AB6B00031A4609BB90
      F1E933B52D24F51FD3E9E01DE2F3A57FC79AEEC71B6746F79DFC555688104EB9
      E7735C1236E56DB029706426A34F40A7A0283A0103CB93C5A0C804C9030D2982
      14232A8344F71D57A6FB9D39B91335887CBF044494AB37D9E378F0234CE1F4E5
      CF6F9805ECCF09ACB03FB4544F3980A60A0F539894058138C5ECF080426A80BB
      8875233D7148FA6142312B9436C4CD70FEDD01B0FDBF0A2B15F7548DAB9BCE73
      47960AC326719C5018E97E3384BBA390C5C16128FBD161188CEC8C00B85595FA
      7016CC842A1304D42F38E85449C3F62C104EBC3A7FBB7FA6E852EBE43016AD7B
      228A2244F0702894A5F4E699C04071E7184ECB15526099DBDC14796CD4306376
      832D05A510288B6001B657C7D6FC425D9896F574749BA5383D3C08C74A5D0B9D
      2392E1409F8DD3A214FAC86B5B5087C6D7C06BDEBCCC1D6CE7A81EC3B7BE7E75
      7D7D0D025C38124DE7D57548C742B64D97FDAB047224213BF3CC45085CB12415
      664D2A7A1D8695A48EDF6E394708C0233DF563D7C55F5EBF64AE19B8FD8E9EB6
      BEE7F52B57DEF6EAF5EBD7272A2B4076A7A4FC710C726BEAB8BD8FE6AEA0678A
      7B31711B677CDAC1E48E4C0AB9FA456823A05F654D199CAA59B408B736CBB1DD
      E434629B31018B804824E2A7F71F01EC998823CA8F954D5EC668A09E631D0CE3
      D561B24227C449B5161A6D10EAF514F5CE2D3F5153E0A22B149CC8467AA49525
      DED144569AA4A94A09589145956643239AEA1ECC4EDFC4793FFC3B00E4CDCB86
      6AE7C23554CA154A84E615368032FF3F047F8D4A40FDC91682EB62175F4945B7
      20AA89C3AAB5A7AA02C57902B15A1F062A6AE37EFEFDE3577B78334D00FC3093
      A7287E42C0A1CD0E4B0CE2E34538850712DB40E21C945CA7775371D33552F1E8
      10F83917CB717A5708DCB7B3550502B83603292B00E1232821C2353501015481
      805BA022E90F7AF2727E78A20B437167D8944E04112113ED24669BA4CCB2F60F
      82DA6662F4EC8B9573169202B13F4CBEBA7CB36085646B4C854721D776A52A5F
      7C89ACCE6C89A45F25E9A63EA789E004C3217A0BA5799A19C7D987336D30E624
      4AACDC8329892359558C73AA1466C2FC5812A5719919C0C0FC46183313BC6358
      0376960910C5630AEC9E736F6820B46D60A38A0998C20ABC3713D2782E73F88B
      F0827B2DAB677DE03940A5C7154BB559E98395669A8786E31A1079F9541390CB
      07E0A98EE48B1BF849964C230F3FAD503B7673E7D6FD91C253D5AAC5EF548DB3
      077FE0911F7CC6A43D5EBB14D04CFECE75FE7883431961C0FEFF0273D5426702
      CC1418FAB210B28420123955BE879E2E85B250CA411986D94BA04B14AA2C21D9
      065F139B94DC66F08426809A6FA1F66F99EEB4395CE93AAA30F011461AA995D3
      B916478CADDC9E52A6E5D14040A3671B351CB4531CF679737A2A1FAF8693537A
      E093F2F297F04A5AD553F0F2BF39CADB4F9D8573DCCF9C8ECB481EB7A75B0F66
      9B3ECD9AC629066B118336710C4E20489F394549205EE311A48B4AA07FBAB59E
      C3AB9E72ADB41473AD92802B9A9721757DF4E59D7D3FF8038FD4E0F3E3C7BFFC
      8D0FABACFB4BB6E27279569A79073746A7C809495BD41B4D5509A5C202DCB196
      ABEC8FE083A45C66AE6B1FBA6CE1AE0055CF7BC74B526198672AFD5F647803BB
      7EE6B80F0B3272E356E4A5FAC80640328FE86A70A52BFFECE74F6894C3937A19
      4631D25DA311705E060772B16F78D972C1D3406B4334B712FDE1C173439AA45C
      7B9633A99CC2FEE23A2F5F8ADEA6C04D02A1167EC2D2FF542D6C477290531949
      9AA4B466ABC690A783EB13849AFE48B9AA0CBAD7DE1B8BB4076F4B2B19281EE3
      788F94D08FB3D24878786000A0D48A3271954545812E8A522E2523613ECAD0E9
      C71E0FD5DC1A6B71B0FD761E51802BA5F7E92A1B12B10D3B0857B9DF6C44AD10
      F3DCA83ED5A09B3FBE3A0FB0334B4B7666F9E917D3D019614B872C4265956649
      678CC20C5644A5F32615F38641DADF9D9FBF92CD5D82B2E6871CE6F12D608B78
      090BCE9BC5F5DD4A67DFCF04562ECB396633BF36442B9B6C9450389A6910E30A
      5FC6CC4E34ED908040886F3EC85573D9B7A520FDD8F03A3CC069D02CEE0CB32F
      29342A5BB5294C6848795D8B088F5EFE55E4F327884E87D93F7EC568347F3EFE
      5CB545A1D2CABEC002C3ECF04572A1EDD4EFD8229B8B421A6CD96E837EA0886A
      1F99B625D35C50A10A5F922DF8C08DE614A6101FD0594D94E704571CAFB92349
      83DD87260D3E144A8689EC09E8E28E6DBB2FB7FD9181F8896C869B207C9C22E9
      A7481F1F211B105F7967F0E1CD6BF0834B4E8B01F87E02324114C6CECBB76778
      FE67AAE6943CF0A72649DF311C089E0607D441FABFBF7C784244A0125FBF7CA8
      F4840C9C5F3EEC087AB419B66754AC1EF49CB3783954C6C6C7C792A758418757
      A0F81EFAB34D0BDBD79E5EB729DB9827A77553FC6FAF361D1EBC992855DB30ED
      196235759C929117CA0A820E29A11E91DD2658524F13F28991F34BA60A609DC2
      BC28DB304432A624469BD6CAAC87CDB24FF998BE5FBD067D4CD29245D51271A4
      2D9B279D868B25F9526072D40543C7E8E0FD4340838B32EC658F6D06986CF88E
      215D56501A033F4AA77B740A3ECEB62C9FF05AC752E9964BF23E34485575C950
      3B4031E422CCB06493FA4D9EB1704C478C4F44DE708E46E962857A42B3D9240C
      3D622344348F62803CE6FB73E4F44969C730AC17DAA4A19396B42599BB3785DA
      3C260FA83C37AB74C9393F62EDCCF1C40CDD03B59A4CC8224032311C0D11EF39
      0E6C1A69FD86CC25E8ADCDD344BB8D75EE91D46C88929C34B432D42803558E27
      55F515EE2283967C1359572A00E7782A1945F6732626D1B5A93451D0BA113423
      DDAC4022608968F46608258EC000326E924266CB3583E23B1D2C086AB452D424
      A0D8754C064B99027E17D4A47274627C1F14C5B371214E65D2DDD328DD00A067
      05771614A30B8A20300C0B25DA2B80329955045C3E548DAD340234E977B28FAD
      639B736C40F0B7E6EF666DBDDFFEF3771DE9F75F80B4A465CBC000724C2AA714
      35C219B31396430CD726A44679992EF1F9B3182BBBC0BACE8A2CFECBAB847A6C
      E194799E142952490E94EC88E2052A7112A338957D13996EF03ADEFF4799A800
      8756538FA3B3F513DF28AB10AA0A835C0B581D52B21BAE2A0D61CB4806368AC3
      190B315AECDD77FA385D8631961AA26343418CA651E10E7322D7964063676ED6
      D6CB7525411BD40D8C8353B300F6CFCE358C9022958998184C84A7E6ECE387B7
      04ED3123E00811F0D9FEB0D8E7848432DFF40BA1553241AA72D3745E1A45EB26
      619C9708CE364F4A0762271EB18E060F3C074020ED9A8978CCE53CF15515CAC0
      C42D1C612BF43213EF9DECB0057F9D1F80142FD8727F8C016379B18AC5896CEF
      AC97879E429B987778F09AC2FF911F28537B733AC332897B961201A8C0EB2E5B
      02297331EC58B6E23E8FC7E21A11CF91420F869A71CCDD08630D28C555C5AE8F
      A331B26D1DE426C15A46FA2AD11013F712F45BABB19093A9DBE98AB80685BC61
      8EA2FCBA14705D12FC573C3B95E58FAF66DED750E94CDA6583ACFDC679EDF199
      38AB48F229555906CA428425DFB7837178502E1D157C6702A76299C9BEEC9AF0
      EB7A262CD8C4296A1FD15C70D81DDE364DC9C98B87C989413B4254C72BA61AB2
      00C9B3D415E07558C3950B2114BA65EE0C60952BB25FDD9446A9C9252B96AE78
      B6B963E42D71C909CE9193758FE06860A1B769162AEEA0DB5136481151810E30
      7048A9ABFADD3AA0575F6238C96499025FCAA02188A902CEC76823B98A12AC1D
      73A21B77E49CC82BCB3049D548567C381E8A51A87B811728142B5D4A82294742
      942E9342FBBC29385777B220D3CE4913239E660C8090664911AD7A0C225F494A
      7B08D2F702CB698DA2050AC25152A66F631610F3525261B1452E4F97E45758B9
      4EFB4101406A9C972A0108E90FF55D5E6C811F0E9420D9C5690A95369990154C
      02CA918A6C0AC72242414F5AB31872E598A075C0804CBD59C9C1B6F4720D66C5
      4FC09134BEE450E305861DC892591409BDB602B921706789811C0086541555D7
      F9E1C1A2586D8B875161D88B45BC6253C0D16B527D49A7C0E7F5EC8E9A86BC24
      F3ED7475B3451A2525BEA3810FD11DB4211C870A3100D3A0403686000E0494E8
      592E0D8972C6B06C1954AD55AB123A846E04110A2C1A8FD96640311680CAC60B
      69E20CE804DBDE27D1E101BCFBA6A571A25D782128D18EC88208F395B438C21A
      88EAAD450B34F8580A65C841D5526E1685A4D31EAE6D32CB8213C4124C489CE2
      E9E3516805E51662721FA2161D0A24206BFBFEB558A3FF38ACD1EFD6B046BF7B
      5FB3241FD3F335CBDCFEB0C45F9555DCA8834006170A0F525CA52135FC5A80E9
      B03A791ACAAB741C94B9511AC8136D12CE37474214472E4B25CED30987DD28E6
      679ADFCA77E82227A1516A214FC9BE8114781CC9CC4771BD50D96A51328E8077
      A2E05B3937D2621951790F64EAB9691DA266D0921218963C7C905C1270EE230C
      FA8A48F4D535EAD51B0C6ACE991964EEE5080E33F85919992233C2D69ED95754
      58EABB979CEA4110FB2088A4EA2DDC9F93FB91191C9537A1C261E9968A237492
      5259DD07139E25E800EDB84A5709B98629588270BC4CB47D01F3A655886C6C9E
      1719CF7855916137FC1CCCA92CFE1E9CA9BEF0FB89AED2D38309E41CC5962AE9
      C550CC12A9E0577A9B53EE1F12FA95E125F0B523B8E24DDE1ABBDD5059CA89F4
      CAE07D4767D5B7379BCDA312EF5542A071C4A86220D2661A82ECFAEF8CFC88C3
      832D42B22AD523D3A1C901C0AF5D63A9F0A25C0ABA32F45759C7CD0A64DA1508
      CBC13A4414DE9754CF1FAA6869660290F317118224D6C6694A29A4328C5E976B
      E2EA03858345780BA7A513529572762C5593BF20EC959E7722B36B4B381D1E68
      62246B6DC8055D6E90A6F0E64D6848A722B25DAAD08ABEA33096459E37764217
      6CAAD240A36012EF82DE63DA0EC20AD67794A37A432889E5CE9845035809C69C
      CA68B8841568852E3B3C908093F28EAA4847D3A21C1B3A0C4A3C618750996C2C
      879681E243A15BDC90FA64224DD3794E3A186A0851A60B5E2B278E46962AA6A9
      FC57A5802891680D81F47D88675FCF17B343F47B0D407B45BC37B08393CA49A9
      8D5852AF602F52FA126FC58608FC13ABDCA6E39C5C2E9583FD26C9455634B5B2
      206FA42655A8A493FBE60A14F40D720034EA8CFB0F7D5A38DFA9CF2F494339FB
      70B6F64EAAC923FDAFE648E7B36852FC8567A1AA6385851138A4E8327106D2F2
      E5CDD8CC28D12529B509835E1D4DEA8669929DA7EA0F460FF28733355FE9D9AF
      CCF225D01BBC6A18E2CD30297A67D5AF252D2B73E96CD2A15146DD0349B3E255
      35818A3D5B54C2CE5860CE6F697025AFAB489AF6CA051A01EB1C927E15524F0A
      99D2ACCDFE21750030DA56974987D48EC336B2598F49EF7DED4636DA417D4A05
      15D599C6824B2A680E0423A585A07D53FA46E5DEEB481E4D60D8337A19C69166
      3ABBB2DF1F39E8EAD479AF99BD59B403ED808CBD1583F7AEADE2F0E03C5D6623
      815B66882D6CAA5F5B084BACDA5A5F9AF7B5DC4B55BE6490146F9DB42A9379DC
      94988C3A85129064F40098E045191F05AF96B3533359671DBB024658F390577A
      8A34D7849A8E296D54511B3D9DC94E62F6E101D7DD72DEBEE7E5A06F556E98C1
      214C2EA063B34A3FED5C250562CB4FDED78D5D3482FEA896982A60A1B0C3882B
      A2073932F0FB2F494F5907987FCF9C047F3DAC1BF49E5BE9BE17045F4EF8E9E1
      BB52FE28BEACF136D3307F120378CE3969A7EB8964D5024ADA5F3F475F69866A
      269086E6A334F47DB46D055C7D8181DBD4C1921C2FA0392F2B31B857DA8F4541
      70541338E4A7407A4B5680A62A904F077C5230F8FA9991950CD13BA3884652DE
      CD63A99126CAE0BC7524550EA966A08F33D342922B3F240FA50B2B6253551881
      7348F74BB3E1466F926373556A12B0C9682075EA39771D52223715E024A17FB8
      E2D031F65DF2AD9A35CED3651931F6426E78D53B3CE4F016ACB155E88D9D4698
      BC1952C8E93ABD54C60BB22EA0D791B1113D0F22B3F2F13A95EC7F6DF9F8F0E0
      E78A9DEA2769A79289BB5AEFD47A1FFBDF45216D9973B1AE426B379AF19B1CE4
      186B9FE5650CD4C9AE89190482B34A8045CA94478A0B7221681BC69861F2FED1
      42952D2D8E16DC8FBB340D927432E4A01BB358EE4F543B015BB4FDA989385F3B
      0E769B4970D3B64721E48D6D364F65F73382E637EC9E75E61DA3D14BA48A2837
      E1C9299BF7276CA135C441C3CC59AD2A48AB50BE51637C34DCAF7BFD8ED64CBA
      68D8A984D0E36E4C292943193B1371853114640DD18393CDA15AA390126274BA
      C2BE5B40D7B6728FFC57EB2BA713B056FE82F41F225664BB52E6B5A1AC986B54
      87D483195E9A5CF278F4A2C83443E5610829AAA934E9698495F91CA6AF87B3A4
      B87E149778C156EBC3524B4B13C42C0C4DD71AF57B8C98DA58A18C8B9442ECD6
      C5F13D51AE8D3965C173144D8D0C27E9DF239BC0F637C982C043C121976892AD
      3342D25B74F02FB587CC2BB5B6D794EC3D3EB1AF64C8E71EBA9C9FE71CBD1BE6
      A553134F51797AD02C8F810FCE1185B5D63882D74AAE56832E26752E67236352
      D6AEE5D635F54154D2CC82A89E5753C34AFB91126DE834AE33F590228674D695
      8AFBAD0607DA3371F012DD25F650DC7A28084E4674C6A39E8B8A4FB13C0A8AA1
      68AF7CA2528A4BC9721B2B648321B9C7BE62EEC70E21F927D57D1B3D7316BFB7
      E137970222AF27E0F053A1B91970B2C109D635AFDB742D334C1FEE95AD529394
      5DB7994E1F37C34EE0A7AA56C5A36E3B7D7AB17A264670AC9A4BCD3B707AE6C9
      BC3D8AA93AABD12C4D695CD61A2B51B95CE85DF64F93AF27BFB656F7B45B5B65
      589BA94E3615ECE039CC0DF3B0E70BDCC273B913477B44182AE9C135E0E0200F
      AA8B7C5A461AC6587E995A2DFC76FDBBF2F8DE9C2BDC6E3A67326283436EC71C
      BC48ADD258B9213F9793CF319E2DE3E1FD4AFA7CFD344802D44D3CCB1889B50E
      125B032139F27163E126BDABB19D3474AE534538552F25CF022E12FFCA195CCA
      D0C2EABAB8788F0C91DB5C0FB58F936D8E5578CD961953ADE9429EFFD2C0A33A
      3A6F8B8DDE0A10EA9EC5DE184B270E3EE822B65C3AE6375524FCF752002B377D
      8FE8C7473E378BD5563894E7E758676CDC24315442614FB6D41036D4474A224C
      AF38AF4D59CD8950610791CD8301DC5534B1BD78268A65969067899BE4A03127
      D76587B51E092F1F67E154373265CAA4CBFC56FA9A4AFD935B36E295BCE2FDCF
      B04169B2B94419794B596DB27FABAAFDB1C85200D6DCB0A3295896667B26DE0C
      FEB26AFD4DFBB01EF24650909A842C828FCBBD694729FFD728B4A0C259B8B73C
      1C5B5D4E456DB41486544A10BA24CC7AFB241DA98A4B96D600AD510C51F51045
      424D89A1FB4257389F5A398271E5AA3BCFE73F00068FDBF284B3CA24A81FBFC4
      936A298907AD2241D07BB972B9EA152BF7F747598D85036DC939F83C96A1B63A
      4158E69C338747BD49A515E5E4758F2695A10D8712BD5713D244694BA33097AA
      84995ACC0FAB7A14B27B58487A04A8482A815ADF1866727C4911A34CF775E200
      267BBE0F9E539529CEBE94AEBC7D39D79C603C4AE7730E714CCC465B46B2BED4
      5B67A1644E65AEAA747D62C065250B9E30F4D8A860266F8C28FD55CC17292C6D
      555660B90AD901B04C40567674DF682A2A36E65C73F6AFCBB2E02732B61C2B1E
      288100A33F31C05F80E8BE523D69C975A3B1FCB1DB3311EEBC24603C55FFA96A
      274CAC6291AA52C9C7FAD3DFB80303673E351C7D7D1C8FF2867376969F5442C3
      B0C62F070D6D01D680F0E0A941F57D88358D1B432C48DF18C1BF8BA7A86F5C02
      4F975BA84470DC011C1C9A46D923F3105B178DE225D6C350205EB312ED312155
      4E3C38E315A97A7FA869A574DA360583DB4C620DB6B010EC3E8B92D3451C8E38
      0428E5FE1C6FB0360E56FB94D896CBC8F59386F31AB0B9908D5228B43312F158
      D6DCC014381EB41C8BB3F7A9A65641DD0685511EEEDCB0946C9B070FCE925E8C
      B1F0A081815A41A5E2F044507193454A5585E028C898E86341561212AA648770
      43779C2DA758E9E9582B4814CCC96552C2691215B0DE13B4B38C8D6235FB7CAA
      B8529CF29E2240F7E74021E9DD0200E07C94ED8942C0B63357CDAC256D2D63A9
      04F1F9449E422CDE963B5CF314248C8873E288FB0D33115EC8CA015CEA2AE7B8
      C8D7AC8587B01EF532B49A583CA556712B5976647F10F439D1B3B27F20CAB7AA
      D4942A3DC630314D3DA359248C28C22386DD5AF1A63355F9EB2DC8C0597E649A
      DFB8CA2F3A076E7C34E73ADA5C916C5CAD04F6DBA850B7E10BF2DFD5D3F2C737
      63A4EAA01A7F4CDF9158F92B80433DD170CAA7F1BAF99D47331DE8ADEA34C973
      4966C6A8408B9A690C531A0745A18D9595617300E7589BC2CA5ED9278661AD29
      83D5D89C58B12216461D3310B0F5230D47969B2445879B64575F426597950FAF
      525A47E64948F5A4E0C244AC9E5383C06A6D056AE2459B623E01071B5431A153
      0D93745C896FAB66C69AAF6F183D31B1B6A8568DE418BA719A1CEE0A7B713EC3
      E0D7D1E1010A18657254D59058968D5337700133A391E618F4456D43D1E7C058
      96EC0CDA744473DA64A389518D4DDE449140B10813AA00C8F1D429963CC34751
      53446714A1002D60A2F19DEA8671D54EB977822C986BC50968ECF2C491872734
      B62A5C1C1ED03635EA5C3078D7D104D3C0E2E89F68C03E966DAEF4B164D086AB
      13556C0D5E996BAD596E85621A7AE754D98A141DE470B0CAADD6950F641FC968
      5E41972B0C1E58C849AB80E1B2CEBDC233ECEA4EE61FA092CB51B1CCB0569B2C
      51784C5E2559D3EEF000ADD759591422949A7659B142BE391373A06BF93A6687
      BC67549D6799A05057A429F168AA92B5442AA65C58CEC7B2602106812F732AA4
      113A20A3EAE2FD32B04667286DDB15714D49022CC552E9103229985B4B258F2B
      3B7F64322BC2BD33897B47F884B8C67C2A04AB5177E808856587492181FBAD00
      E671C4A03FFA3F4B143FCE4DE2CB2E0EA6191543A3F2B59A24F2E8C5CA7911E6
      E20381FF4856DB20AD73985EABDD94DE15156C6B7827D93ACB3572D9FF82E5C6
      F41DC77F7348B8E70C2AE7ECD5DBB7B82F58F952F6E595B79EAC9D90B5799445
      4A1ACE5F1ACE29AFFEDF9C0BB1CAD7EB514A5328008EE3A19EC7F151437FFB09
      0EA902DE9BE412252F1DE0715429D6CB65C6CA63A669B23C4A92F7BD97F5A354
      94A23A11AAAE9471AE243BE48C3455334A46815057BA50252684667915BD093A
      EB80F23FE84619D79B0B3DBA7AEF5AE600596BCB08C945C5FABBC7E2E3072053
      33E98FDCCBB6C2660096C67515B07E73B9DF5CA018A51C1B434152045A0AD580
      61BCD919456734A30B103B7613A7D8D8025DDA969AB81A4D5D817CD094CA6A81
      2A353FE72A51630A7438D2A31E910F44D5DE0672B44253A5F69F00C986C5CED8
      90A99DACCA596996246559C734DB49FF759E321F65B72F6CE6E8020837B2005C
      94B653C4EC4A0520CDC80F0C540059A47C6758AC15B57DCFD4711B6CF43E1100
      1BB28BA5095983C5E821BE5B26E5708A42970B59E658EE71536236FCCD34AFB3
      342397C5143461594799826BB64D54F615C8097728446F826A6EB14C8C4A5E72
      FFE0A050270DAA6FCCF5B838802574B03837E2228874D38C643A74FCEBF407FC
      993DE5300164423923ECF9F92B4BE1B479F448CA10D83F0814348C8EA056423F
      5215B23D8A55F959C55694E5B4D147C0D20310033413525322136006D757206B
      3A2F64A56E559D9944D4941C4EEF9E9F7F04AA35D4074DBBAE0C0959C6A6D1B8
      64B07C86388FA5FECD5C7494861B52CA249E1EA36F8B2228543B6C221F870798
      DF908064CA72CA319E223AD528FC0996C3315B1F969250C5D8133A260B912E54
      B2D238D5DD0C4278462C94440D63194796881796ABC1A3C7AE61DDACABEAFA62
      F6518A302BED085662386A52D20BAAF403589B097B55438FE98E2CB80E30C744
      2BBE2DE238582EC302BAF5D173F89587C86FAE5A785390F2B6D7D2068BF53753
      A679BE2C35716154569762734E2BD582AFAE7FA7064A9C7F2C61935457215553
      E6885484BB2DA60C09FA98563CA6BAB6BD4A4835319B0A9036E44E5192BD1236
      AB11174FE198E389D03CF0F54FD0B797340F55D21C40FEE8EB78F31F00AE5FE1
      F0BC99BF4C01C64FE08C6D3A3F63ACBE60358C31030EABF699CB7AEC42C693C8
      FE5EB2966242A514B58A364E9D0BDCDF2B1C61257B7A8D71E296571EBC9963D3
      08B2FBE792C89061284F33EE1141664DA9B3AB066AFBC3394DB24AB221B73A94
      1EC5B270B9913381B2A0B6379F03184B4AB6D5AE6CDEE21C1369C56A7A9BF2F8
      C99126BC5C045DD1450AA0C63DD2955AD649E8D61757EE41C3C50749E9C9AA44
      C605F9E33DDE8C35DF5A86A1592AE532EE11882D2C6D529A76F064D3350A66E7
      A000E242526AA02AAF256381375D6A3F9534C724424843EDB064D34834284704
      840254DC3887C4E0F51CA27519910AC001AED29E7022AFC6189D402D72A8FAFC
      9882D12DC5283BD0B19DCE100FC94FBE4F31E0320CB9060E2AB9642D2FC434FB
      9188AB2DA76C117F75FE8E9A9432E97D9B8E423283CBB24465FF4F0E1B8845D5
      DC7D43EAD91EE3ECCF6403F92026CE6F3FBFFDAF0FDFBBF43F2FF81DCFB6F20B
      94050F553FF8A6B816FB83CD25908E65F94605A61365CA0AB7000BB1CE0498AE
      3D64C424B27FCEA8FA2A9B610015291BCB33152E29F84969B6371BEA98469F22
      0B65A9EC0F4ACB186313A875B31A9DB3AAB1698F4FC38F0AE4CD71A86A8B486E
      B92FD8FED1405AD036B641A4746328498242573828B192B3261D2011D3E384CC
      B7E5D3E427B6C203A39E4AAF39D365BBD2641BCFDA173C04887005B4FA8C4459
      729700A7AC1F090704B2E90553C8B928AABAA61D7732B061AD545AD3519915F0
      E2EAE893146D1448AC991ACB015BD8B38F5E6171F8E0B75F44B6FADDD9E288DE
      23C5B83E51A98A46DA62A36BB53FBA39EA1FB8112813EBC6784F911D702ABDD8
      4621BDED7DE9AB21083A9F800A505157C169D92C697B5059D94C908308A4A8D4
      908A73832CB38F0E460C5CDE06CA8DB4B307E70A9CEA00318A3861D7EA26D8D8
      C6A29B96E4464A387AC6E2E5145ED52CAE0BEDA334F3D12B65348DD802D5E938
      9A706B6E100CA92B7725C7ECC45239266FBF616184DF3968C712B7AF45DCC8FE
      FA9444AD2C2A01D406FEC442572B34CE12522C6D6B97A660324868D2B72DC870
      AD82C4E101D6D9E478361D80B9D1E42489573264E953C23D4EE89B6AF5A7B53D
      19777B244D97473A96B6F4A81D9529DC3857157256F7EEE613ED218260C4C7E8
      F1536DB75254F2A5316B69389F5E7E682803EF9B8FEF8E60D9FF5852381A69C6
      0BD6CC5B14EB92370035AAF45826156A5F1FA30D4640606831074554DBD11EBD
      787F7EFEDDDBF7EF3FEA903F783F86B45422FF943CC9E4864DD21CCD572D3AB2
      CC12147927CED139EA5388027253D1642E12ED8AA4EC19F4E8E92A28DA6000EB
      5689BAA3749AA055ED84330FB0B9E6D11B07FD5A0E3AB69C37CFE60EF9B6646C
      E1B1D1F659A5FD001BCEA8C9B595890F5E66E1F459F2EC25262D01C8AF6669C5
      46B4A7596A6FB624A6A9D8A5F5C8B05A05AF024B8C26304B73C8867AC7A6E4C3
      4661A00727AA0497D20E130AE3A6A02D8BB3073F8597CE1C03E122C307BA3FC8
      F91AF8DFC757E7EDEFCECF5F7196E3FBA081B17C21F17F319EAA5AC6F811B3B5
      2E987A26ACA2A8B843E023C06E55B55DD5A9DCAC4BAAC79434198DC68707EA57
      4C40A1C89A44EE47039328133962F972AC1B45C17663715DC60CE13D73AA6B1C
      4D4826289ACEF1071584B7C12C5855436E8281C39349F3C479CE7AC6D97F90A3
      860E55388C28742F9F2D27A006A158C4ADB039A1C5E866B256F1656DB27225B2
      531C766DC07C10F46786A3C3030C4F3003802A03E42AFE89534D805B4D801552
      F05F9460BE0207CB24069FFBE9F92FEF98C7915FB41462C7203E6126D114EDEF
      142F315E8E8C684E4E7E020E3AC1AC541849E67020EBD3614DDBD16544D586A2
      9C432231B83C1A4970C84DCF15B1D35DB98924C29DB08DA314A0090243C1BD48
      94BBC0B88397A726F1613370B234B4CA63CC612014BF0547985D6795C85AC269
      856C65DCD6F6805D36CF51CA234CFD63159369A104F6E32150D53248AC58BFCF
      E8A56C9C26034C7CDE4EF0957F5FCE1765F09C4E4092F71951530D6E3148A925
      B42899036C69FBC1CF18371B625AD5B2A0246AA9CCD10E65CBC51EB93A0E0F7E
      55DDBAA409C4E832AF131623795265B94F7C024B8294F91A04CF867111632779
      3CB3F924DEFCDB7FFEAEB3AF401EA47563546142B62B1518A9B7421AA7795C5D
      2554BEAFE244943D5208E1F1AEF7FF818A4EB11EC79FAFA79F255C131EEE5A50
      E2FE784949CAAAA44AA25EA7D1A571C39CB8699B4623738632251025B82859DA
      00338AA05205E98A1403A8F6E7D47D340B6BF2E2CBC0293C0070F4C678EA2AAD
      C47E0406FE2A571E7879916AF3BE79093F4E31DFE2E34CC76D61523D0A202780
      FDD847CD6066FAA06520D9EAA8EB38A4548198B406924EC25106FC0E74E0BCD2
      2168AF51967B908F455C84CE82C2F1286B64BF10F8B973644080AC36BACF878C
      F066F229EBFD549224492C53DC0570F38AF276AFD2320501E8A5D44595E5CD14
      C4407406799EC2A2D014C8E3E3B324A01EBDC3D20753C1E97DD2CED7C42C468C
      EFE500BFF57799564C20E5200273C4BF5EA1ECB750E607E15BD6DEA172ACB9FC
      55A6F570135574CA21BB66E524D63A73D1E9E4146FC52B7D98D8D69B751E926A
      E05099B64C0602DE13C561C65901B294A5497B546F78330B13C880F9460D22CE
      1C5370BFF13894242DCC2F7299359708D073D6D742CA9EB107ECEE2E5B96B16A
      A652B18D97ADD334DA250A460DD96AA2121A2A6FD5BB300E6120A6780D63738D
      7AC9643A851935613B4842D78D798EFFE6BC2252790E44126B9B7E9285C7C3C4
      B88B101E74A3E00731BAC0189182D16BAC7A10A895009DAEC434C1EC23297C19
      4B2B3B391AB325E089629652F8D4E6DE52A2052895A81EE9DA70AAC34F5C8358
      B46A4CCC514D59319C51DDA94AA9CB49CA2D4BCCAEBDB2FBB87E3DBE5C356C88
      B425FE786D1999F2E701AB93BA29329E924ACCF8F4967C9127C28928E3B210ED
      161C21B0529470BE712E8995DE875ACD36A9C8E6A164B511479BCFB990068DB8
      41147299958C7094AA3997DC936E6575B6CB3CCFB75AAF5B17234C266E4087B8
      3C463CDFC4D7DF274693401826C20A81A02C171CD64E64606DE25C49A2D2E2A9
      4AB9F9510C9366A1444BE332724A57C1C29C56A0E09A488358F39C20021F5EB0
      FF207468B1C5CFF8F6E72F9A7CCF1490548561E15D38C2154E9A323FA768FC47
      07303A75CDA77507CDB589488A565DA9B9EF7864E870180782DB2D3C976C0268
      373A06E55E52554738B4DFCB5B5EE2B83C89865C5C75591B46076CD889E5440C
      DBC3140958962EA7B30AC6C2613586778E65E34395737503865792F20F0F2479
      50705D5BA7728D08AAE07E3A5C9DEAFC3C22285C828C1B653C6FE87C88F5EB8A
      D497D7D7F6F757348C51554B197384D8B37E1635A254004B344B06EFCBEAFA19
      13272A934984C20415DA73CA978384A3F7E1661E47151F3013C12CBAB0CC48B3
      C4828AE840C3A20F19731D4593F09763594E13B093C027D165FDCC9F18ED2B8D
      469805BB530AA38E0EBDB042EED09B56D681834727CB18E18C756DE9F06665A5
      1BD992DB184A1A26B1A52A933BD5AFA3B230A9886823ABD97656A55529A90117
      F1ACE0A4AD742AC8DB8041B9B4A78A13AC8D4E70D350CBD9966C02439254B627
      537D163974E997AF42C8397E17EAD43056E709DC52D491F44BD23802F1E1816C
      ABAB835F4C92900B63F5929B970928527A91D6EF71D306901C28690AB0111DC8
      BA9C8191335BCA50FBA355115854D91D0D94305F0388915E8CBA106031D039C1
      0C0FF15B024C8D16AE3FAE8510AAF220F0E071D3753C9ADAFFDD90644707D7E7
      CB88DD2C2ABB24676B5B4588758C924F389C3EF8A5E4AAA56F7CBD35291CBC20
      3325B979B0A0A2F3A388170DE72771BDCC81B5C10EFF10153F2E870D8C7041AE
      4DBDC4814B6502AD93E1749F5AAB2A58D595625B33296B69160B355D45C938BD
      5260B6EDCFD7DA9FC37D5FB9FD3922BE738A1D6655D3592235950237BBB25DFA
      78C284D19A5B7EC71359CE1B845C02AA54F831CF9C04DAA9B47808A3CCBA2EE1
      922D13329F85F9AE2D9B4911AC99247312ED50129B4452928FD15D5B004B0012
      9B2EA862ACA13A2888940ECF8CA2BE60F5B9D1066157162BE9ADDC61DE27752D
      17D925CAAE1F44189F92D039A2C283644720F191EFE77A7BA89D489860B2B8F3
      0A03AA31FA26225060A9A85D5BFCE1816231A7CEAB784E9EACECF9A7677985F5
      1807D4F92FACBD22C516AEF70402EFB2A00232792EAB5397017969324DA91CF0
      128BAF545046A18A150E0E64DF49AE000840E703B83F0CDFA898538DFA545503
      5475C4ADD6E53578E972A9669C4FA9241EBDA41A00E57892DAB11144E56C9B65
      1195158BD05DF5F2C258E721D69B41DF7364343A67FF399510A2F7C9E1A59B5A
      B533B248AF294F26E61141CB04E7FEE0FEF32A1AE9080CAC3108738A49D04544
      52F0624C3210147F94E8457D5C22EA5124ED3D34A83434EB33805D2BC98659D6
      A92A4ADCA5E248F2A8518DD74AF5540C8C2645304374CEB0A4469AE952076B85
      4965FDD5722691E1A05BC418F244662EB5361C4FC53DC1C0649584CBA5DC8546
      2201CA66C232D4FAF86AA6B276900A52540CAB6C1E6530A2A6F39A99139FF2DC
      70005DCA22D6514E51B4E5D404E8163A948D5BBF61F487648BDA3F01A21FB9DA
      D035B04CA262658FFDC1198722C35200195136DE23C5160FD0E6FA9D63367613
      2663B7D26D9D4A37FA432AD5180DDD335873E9DBC00A3CFC965C95B5030A1BCD
      9773F95640D559184BA7AC0C93943F5532EC649D5F3DAEEE63A90AEECA6060AB
      65AF6BD9DBCFDB9FA8651F1E9CAB8D3D25841849845035F62296D4EFB2FD5594
      95145E2BBCBA1C3EB99DB88034374DE6AA90E40E290DE7EC93DA3184791D51CD
      6CD401292CBD888A58274D1C9B09F62765EDAF2AE85484CA5C06C5006A706A15
      45C733AB02741852E65938A78EF4E5B6A8BA8BF4C23CFAA7D8ECBAAC012EC3E2
      A5A18B5CCFF8C42EC2F423523156AC35E529F442F31B16495E5D2CE67F781053
      DB17C370A2CBF803A8464011930AF4E8454C9AB4BFB8F20ECEF3A5700E234073
      97C0763E47BFF229BA2A87181B2F0D2B1AA2147CCF28DBDC04EEE1C13DC07B17
      E0BE51E13905563F55AF32B0971A420899AE0DF452903A644CA9D26C3CD97874
      A1BA2ED49F3ADCCE4596921097727E613ECB96C98593A78EEEFBC0771F1EE4B4
      3AA39EEC4D937A0CECD96379EE47847192966924889D62BE2856D8FB79CF84BB
      A35BA0B1AE278984DA537CA7FA54548BACDFDC24BC1AE14E819256105B17C4FC
      AF2F8801F99C73C3A2903B7E97C5FBB92A1A6C3E95E8C7FC798C09C58EE432EA
      5B37A642E904048E6249015A2F44124D93F2D714A33AD12686746B168DC765BB
      F85D4185371316107579815A28A878262EFC3DC303A5C072D230CE122D969FE5
      25AB448C1D5CBA0ADF3BD70D55CA928F77DCF377AA892366F69B1466FBE65BC6
      C4EA0B59A1042016F3732A6C4535B52A7C5C87D9ED7125B2E7B22D95E450472F
      AB50FB45436D5B89B2B2CA8ECA671DAEC8CC38CFC5E868BD02AAF35216C4E7E3
      DB762BE16CB2CC028B93F45A6EAA46864DCADBE2CE53580C69CB167258F9E614
      8FA9291A4C6B267BCC13975D66391CA0E5824D995709F6573AE19AFDB07CDD28
      841D00920DF39C54409D569941AB5BB25F0B5D853AE4951BC4A3A91550D15526
      4B5E5DD9CE809C87A991055BADAFAFDAA229A154779A557494E140C1C704062B
      991A758A9FC7C82E43FC97EC57702BA0B69055A4F72AA3C73CE1B780A5EED472
      AE7AB6145B24D086B34C7219D186A3E5F2D80153E37E04F989F694D18B4DB325
      7C25CF70C4DDED6405FA7F51BFE79C741162427F4397FCA2C0CF852C3FA34E03
      B1529F6CA3598426D6384DD129221347A3B25C53FD9E97FB5A5CF7BD0EFCEBF5
      5A3EFCF1BB410FFEB43A9D00FE04ED9E0B7FDA411F6FE9041EDED26DF9784BCF
      0F027E1A6F01E4E9D2306EBF8F37795EDFC5BB3C1FEEC3BFADEEFFDFDEBB36B5
      912DE9C2DF89E03FD44B9C3886D9184B75D1C57B2E810177731A301BE8CB9CEE
      8E13ABAA56416D2495B64AB24DCFF47F7F9FCC5CABAA24242CA971BBF658CCB4
      37487559975C79CF277DBECE6F05ADCF4B4CDCF2FD0FA21A1D3ACE1BFA7FB392
      F8FDC8710E6D7EFDD773A6446D2B88D79E836A0B18A2BE0DED3D27ED954447FF
      6FFE929F82049DAF890A099D43382E3BD9D29154B5EDDA32FCD2B7E6FC9B33ED
      5B6332E540D173039FED8A28D87B7EBCB38C90F61E0153FED1E11A89F419C62B
      09ACC6752F729622FD2229199C644A167EC55ADBDB124090F5EC9BAFCC0C83DE
      3A28AD8CB10AF72B6D79A71CE9235DA2F287CAD4C1D806D7D3A1DB536ADA32A7
      5922EC9C0B53FCFA8A169C2AA9AAD91EB6FF7111DFBBA7FE68956ED9B63FEEB8
      B8D8182752ED3595062A6C89FC2064DC29A976B54DC6387A9665E3CADB657EE4
      342B2C797E3DDB6DB000633C68DFA129513B36293493A7534F39F3319963325E
      EEAA538148AB8025DC64B64738B7DC2D1365600C0A48F924DF38571F3957BD2F
      ED5C2500F30B629FFFC13467A9D9502D4134D66CCF0EC7BDBFFC60C7CAA7ADC6
      833D19184C6AC2A37A5DACEECB7FB7EC02BF15D3C0EF3FCCC178ACCB5C8EC4CF
      739C7D18BC1677929DCE82BDA079CF9BD0572C994F2DBC5A440C5D382543D818
      A481A9E55AC2C8F99F22AF0556E39C64F4F7C3574462CE2E45EDF69C57063D4E
      88AFF8D24A953D114546E470FC7A64320CF3B17A28C590C01E18C74CE12FE1D7
      527BBAE26DA7839CBABB2F7E41A86D737A9356267AA97DF2FCDCE94AF2B4F51C
      BDE5470EF4074E2AA83C22B784B0E3ECC633EEA2BDE991C70415FBA9F1D145C3
      C773FF8A4FA149C6CA293F955BDB8EC8C1A042DDCB1F1DC2AFE70CDEDC4D2DC4
      6E89BE63ADDCB4AA554F755691A14FC353DA7410A9C92FB2632C402893EC1335
      F823221B25DDE4A34A16CFACAF68503938F2AEF1C3D0A0B290709244E3BC4802
      B52D59A8A3BAA940DA9C8CE264880ACF0DE727A348CA96B8F752948E19958F71
      6C8AEED48201B8F3F3318C8A5F1D6E4C84EDB53EE357E429A72AE6AF09F38B3D
      F9A6E84670A66879B6B7AA0BB43BB542B29A7BC54A51D9EDA8445998050522BF
      7E91466F8C47C936555CD72BB9F4DC20C5440E94737472766693B994F3E3D5D9
      317B4C9CAB93B757E5E774D59E85D6D604D1A5460F5346AA1E950DBBC8B67C44
      19CC308A1282472DD36DC19AA96E901C4C4140332B620284F9BC8717AFCE0D79
      16B8BAA48D92159F151DA9992DD940A0CDD8A56A102ABB2C5E6653F56C5934E1
      DE4BEF3267B76066DCAED5B46AD8338DF7A65EFF15338C0ABA9BACD0D772CC21
      2FB3A25A65A73FBB0C25A61B44D5F8C1D925462A502D45405C60F86C0D1E9DB0
      51C6A03347DFED318A0C31871223660AA45924968EFF4C1BA1A624B8733AF83B
      35AB27B4CFBCBA075F93D4F9C43238BB45D5A5D5E266932355D908F7893EB826
      D4B1BD659C7D749969746A129A2F0A895620BAF383B9F1A3B063C690FEBB6471
      D94B77FFAD60CAF6231B9E5616126DBA5FAA20FEB18F93918EA0B57249401431
      1E3A974D98A10D473A493F96F06DC322033A9DF5EA8E21F104DD5273E93ABFEA
      5D48A3C583582926015C7614370AA66244A3D1D826B8C89BF7AC8A24057056AE
      4FA9BD9CB242CF54D158EA1C1EF4B86C6551AEA511527DD3C08C92D818B5A614
      D5A2AEE3EB02DCEA4769AFF25A5CD1166692F7F0E2DD8D69658E093F942D0404
      B186A57EDF4084940E6AB3A0F2573A2AFB646C00D371048D1E1CCDE8C1CEAEC0
      1DE0CF0FA3947BA37D756A3156E7F12AEC94AD1BA632B92C18296322390B97B5
      50982D615B1ABCA860AFAAF10CDDD351B383D0920F63A03EAB992F0550DA14C5
      1B0D71A67278EECCDE2BEA36C04794945D5BB7F1F875534F3610A6D8A45B46F3
      339D1255B5FB1EA76346BC00498545183029E2AE7624635BD863EE64FCBDDBD4
      027B4677592ACD2A76FE53E7B6C383E9067691151FCC4CD7988665F6F1633453
      3BDBB9E3AFD6677F622246F1DFAD2CEDF46271BAAFB9EDF130F66C09F7D36B5E
      BECFC0A34E7BD944563104C7AC6CDD67DCFE29638F6875250E20BE748EE54D5B
      6F5390CB1C9BDBDEAA7499CB0484341DE7651FB9BC322DB307E50D04E854D23D
      DE37B32A02BF7257762993E7E456B2DBAB1EAFB35D37A9E0FBC168B44746A315
      436A5A1FC6238FBEA31189E6AC4C2BCAEADA16051EFD49CFE08E6E448CA0D81A
      358FB0EDE98C9E5C9F7D45728495A682A58F19756F56F1E4D356686DFFEEFCAF
      B76FDF0A322E78627F280EF55285ED4B896D0225B7BCEB5FFF8D6F3B2830B313
      68D086531990CB7146C40AE569F058E99D4638DEE8617FE621B9D2A6A353714A
      C062BF2E6DAB280320071C214B595E5F105F8E9B18B0121650E151A8F8D89F36
      28594758C48CBE1CD553C18F57719A48EBAF3B4EF0A1303ACB326E8A50D89EDC
      194C117C09A56A2754675691E8A29608396DAA5589B2BED10398B13D6E0A362C
      9AF7F2DEBFBB383C2FE2D9FF2C67ED8F76A67D9B7EBC248D07476310E9DF1F27
      EAFED1C3FCEAD99BE95E644F0DFA19864CDCE1F9934B5F4A622351D9B38FF8D9
      17797B8B97F9B30DB87AF66C47C95B399A94515071F715ADB538464BCCB32F9D
      580C661EA3CBF74FAECFD36483AEC4D9013D351487E005A73D163901EA2B0214
      2CA65E4DA4353DB71810E9E797BF3AF9433FCC7A2644388D5B16C9328A7E5DF4
      8C306B4BE6EB08427F08DA9BEA982EEEE77CBA376919E067159EFB9E9B1E0D52
      4288B79755E1ACB0F7D583F176503C2F1BDD66E40C992EBEA4F752EA6C813566
      F4017A4994B1F40F5574CF58ADA3036757BCB5269DC076569591396C2793FDC0
      A9E8836C6C51C171FDF6964D40D01F15476DE52B7BAF045CE9AD2999F365CD18
      4C08298B94471680F81C62B62598366E24059D0C5D57F4107CC93D0431BFC1B8
      F4A9C5A6217DB1417627A4E5CFECDA733645D92C74B6C5E88999447567C89882
      DA7562778D2F55E3EDADCA73C82F453A9E5683BC28F4A1DC25E3778F1FED95ED
      23300B8434D37CB4EACC972656761276C2953E3C4281D40F377D9FC6D44BD692
      1A83874FDF2F17576F2F9670CE030E649B4A1AC7F3E4FAEDAD5C689E9FBA5B29
      A7357BB9274F3708495234AB389CFDE82D766DE5598264A439F39273B5A79F61
      67522C189725A63633BCA01D932A03F2D93789DFD5E61DE5321647584B53ED6C
      125649D0E69FE93C257A1A71BF4A9B16D47076B7B766216B38BA2E519C7C6EC1
      BF099350CE96813850BD11A8F14130A5AA23701E97ED0C24C023BE55531A4903
      2FF2820CBFC37262B09B2E7E10021421148F882386D75BE232DF72C7F4AF4716
      322ECDF45AEC149CCFDAA6E5C2D89A92128F23A56E051FA78A7D29435A8ADAB9
      D0D1484F7378FF8379E8146A127D2339D5D54C96A9BDA12FCEA533C85F9CE686
      7AA7B66450815F2823DDB9612E5F172D17EA5C515ECB2E925932B63DD7715719
      9AA86409E4C5F23D91316032A28BEE2855F92C880B53B013E2FF915660D9BD6D
      5934352A93166003159995E25A457795E1D1F379788F9E405F6F987B598C9040
      6D654DD7242BB0042E9215BE22FCB1E3B9F3878A364945411B69563D23569A47
      4470C6C62677A1120405A980C1D5FBCEC1C181D40FF42941835AD667B7A0DFED
      2D73EA8C25B5938FE91CFE5CBCF25776B1DA9B8AC2D741661296ED3785A580E7
      DE9AAAC16603640F45D284F324D59A0637D5829BDAAF56466DCFAF41C48C9414
      2914CFB7409DE4F49BCDD966482E695160222AB62326E9ACB36B498659A58F5E
      3678AF47E3B2310D0552F20758187DCA82D91CD2AD6F545F9FA5837BE795F3F6
      9D4FA9ADF4D7D773240FABD3B65162A2F3B7FEF58955B4D241D49BC425699E1A
      A3C80695F3A9965A78A054BA9A278BCDAB6C0FB122F383BB95980FA80DCDFE4C
      664899036642EDE92303946D15B2BE8A6D7C1A9D70E7528DEF76B814D948BE4A
      F7429BD84C47B4EC444A1D98CD5BE27DE212AAC2A5E688680274CF240D5026B5
      B0734425C5AF501848A842559039286B824FB18422CE33D5AA4790EB0AAF24EF
      20ED0365B149A027D4658F2A617334BE32899011E6371CC1C65FACB7AAEA9A11
      815EBACA92F4E3D7840D7FE8F42863C531C15F4A8E99BB221501D4577191FDFF
      68418B94A84A93C1DB6AB4F17420E17FE9122A650B36A3CD241551638A0FD540
      EC6450740E8CA97B736E9B7617858B95EFA9D26102AD76509EF843F1F2A71118
      07BD2BCDFBA59CAE64861B2F1CE9F6063E0DEB61F66FCADB316FE2FB0526F0B8
      D244F4B141FAC1E6B4195B78D61B45077A7B2B3E9857E055364D6624B6B286CB
      64F4168335DEAFF0813A4B1803B951A6CD960DE0B9F96D6ADAEA2EB55E05C391
      95DAC14A4C46D4B46267CEA29859305A045D9E3B3F9C1F1E3B9723526FC6A934
      7EE699EF5C8F479368BC435AE2CE21439564C9F696633F66F7B884B5A5E1B489
      7893BB4B5A873CF924FB9C7D02DDA3C18FC2743CA20460A17C416CD012EF67F6
      457EEB3229B86C983C25ABA80C9666B4479DDAD3A1393195E955EDB4EF4FA116
      834D53F52C7B33097C6FA46E5F0C5E50C1E9C679B6BDF53D8B7A92AED9E8F498
      21437AEA56CEBCE28C0AEAF54519715F0F8B06C7BC39B90E5E5D4379332AD8AB
      B7EFDA2DE7E4F8F4C6526525C190386B59A8BB6F333E0BE4D6E128CD4626A130
      1ABE33E996A53E528418244465B38D85E1F3C3B991312B3B23E85153CDE0AB6C
      58999B0F9C37549230D34959222AC5568B5B85FB1786650B1DE134C6E66307DE
      A89C88385718E078A7C81AB5AE0E7B55915873586AA5B62FED983A33E7C51828
      27EE038107DA45C4E694CB38D546BA5886D945601B8E9365CAB7094CBCE86D8F
      FA49F35D8CBA294A250C56B2FF0802834637156463C3116761C328C44F29C1BE
      C8644A439B7FC54B4A895AA098AF8743100A9B28FEA526506D77BD609DC03A66
      532CD245E3495719110EC1F3E76E6C6F95617209DF560A8A7689438A0B9422CF
      7B550BAD3C5153054A6576DFA7496973E0B68CCE4249E85418BD4B6B7DF58E34
      1FEC0855478B7FA0B4A377A9507ADF393CFAF64ABC7AFBCED9E1052EBBFCE6CA
      5C7C71F8C339DDCE4FA41654564BCA18616477AF6218336C3669587F668BFB2F
      7AAE4F07663DF6B1FCE942FD737A3B68A17016FC625B2ADE13531B44379103A5
      D4F64D91C9742F49725B30C834576B48DA1BC3BE533678C6AAF35F9C8FFBCE43
      15B86D2A5FB544C3C8B51A51A0814CC34A358F0C9D0A3FA423F1749992085AF1
      86C821257FAE2DDCDB630A621789B879A79F6ACCAF249BD846514A4088079AF5
      0B92AD15E757B1BA1CB19F5DE2B9746B73D72DFD4E6BFA45993DA64CB78B5D80
      2738BB1C73A1DEA082F2C1BEE0DE835572A6FB1460E5056260BF541B162CE654
      26CE6CD55765E168A6559B5789C94E6FC9A7A2ADCA58294F9D69290228298273
      9253F3B87D2EB46153106487454DAD8FCB58A4BCC118C548175630DD37D73526
      3530641FD30E955E310989B1E955DD8162599E3B4791F9D2F34BB7BE86DABA01
      E2344D896D628FE96AC6E70B145212A2243A5992FE5A24C2F6961CCC274FE440
      7A626545FB602A56A82CA64139298EA3D868F17E95CBB3D15D7CC18FAD024B93
      193E9262700B1352960F18D8D04C1AB7530617F35A3164D86BCD675C4E371F66
      713056795938B935AAEC94D535DCDEB2A366DBABE43BE582C4A904D2FA16BCB4
      FCCA721CF11A56EE1639C45CB888DFDBC256B20565214C1758BB46C4683902FC
      C1C43B189FCE744AD82F13DEAC882AE7CF17DA242C9E33DD40D289BE21E4D291
      54CC1B2955A1F6ED2D967D1B3EB175681DAB65AF10F2E0CDE9C0910E38EC6C53
      F67276044E281C607C1B5F0FFBB8999F6F529EEC5DD6A5C8BD0C0DA897E6540F
      3CEDC2365C050B8983C5A922E40A7ABCA8A219182BB4DA3581F893245B0E04BA
      212A139C3925A5C8FEE423CFC8BA53E927A71580278A97997A67958B82372AD4
      1EA9172E47416A8E813BC393BF613E581ACCE5130D16E0542CCE266D9608FB9C
      FE83275072AFA26B0E9CDD37520B4597A8293CA84A6E773947D178841F9B2AAA
      E98AEE0FD49A6D58E4300B4CA24418536A3758890C60D3D2481B8DE856732CB0
      08BDAAB96785BE115DB9140E55D1C2A3A379F4C5E74ABA22F17693A5CBBB33C5
      8EA762A89669CE64C3EF2FCA79AA4A17B3A036C38A63A6F6D1D2E21E428D1680
      365C98B7A47213507325CE6AEF5922E56AC352B90694A4E68E5DA63B49FD9A17
      74FFFA6A3B389FD52E50D52DB1E44AD9E4EB3B06F3D1035BFF6F1F31A4B652A1
      8E146954E998B116C90595171772B2D11DE52118A6289C63B658692A7FDCC2E4
      992001142DB1104BFB8963671BE2DF3A7B77FC0D76C5E86F5F0F5DFFA0468C37
      28139F17E7372B434DE3B90265704F917A9D6783FF6F4336D7771C7CCB44AA0E
      B3D45806314E5E9FFCCD5C21047D241B7D457AE6B9245BE6A5502FDC8A86DD91
      BF31E1F29ED16832E4DE72D38B68D22D760B35881C5517EA624AA128BAC013E7
      4D0713A6D798905825DA56CD23ADBC98B13A4B91FFC4688B640DDA40278B28D5
      C1A6FC4E6F310553CD9F2544DB745B094A55B81FD063E710CC6372B123CEB08D
      29D5F9BF21B52E8F95441539EB5BA08A12C5E1468916427C98FBE97D320DAB56
      193901D55EB4DAF476C0756BAA28E32F524428042CB155E8F763EE604129E974
      4D38CAEE45011C1855F7C0F9CF6C22E2E79EBDA82169FB1CCDFCB0C1A021BF4D
      36E2FA2E2E8839E7FC15E75509F66A3EA10371F5FD80484050680F7B29673D38
      7FFBFEFAE6AB097C48407326BB6926519496AAAC6AE4BC1F22EC4958F5CBF379
      B54B79767DE3FC9B7305A3607B4BCC0259DDF7397D79748D2FA9D4D6F413AD7E
      7746DF9D652638C8DF1490BF3301991C3617943C5B77C9BA58314AD31DA71291
      A99283240E4D1384BD6301FE247D66E86583C75D583187C321589BE463715180
      C550AB24367E3D47E9D0795B692F3293C557B67892184AB5A16ED60FB330FB68
      1CB5D51E252C267B691FBF52F0262DB322CD53ECBD7C06078B9B36394CCD902F
      E6885B8C1A82A7990A454D79810B6B5EDEB66F9DAB36546806F1A8247C7F01B6
      9ECAEF8BDAF4994C54D203D4FB02A3DBD9BDB692334EF308A4436D49CC2D65BE
      EADED4D885075814BFA897E526E9FC338FB93A5AC1B0CBC633990FE6ADD5919B
      F5C628AD3F8E7BA272DDD8BE4D2C910A7B73375702D8702F8557A56EFD458EF7
      E8685289B2F2A3E55114E894DB8B821BF2DF4C39C5A9B7167BD827061CD0C6A7
      D93031FACA2CCA213D66C304B784FBB1D2F64FC8F5FE308C0CA61CE998BA581F
      C6B100B79C26E7694E44BDAB34258FBD764E3F84F4CB5F7198E412FA8B58CF6B
      7267E34A7C739D8DC6F265FEDA7993653DD28AFFCDB9A1BE327F7DF628F0F616
      2B14069FCF76A083E61F9A370F2D7ECD9C3637FCCB6434E0D639A5C7D7D6EC43
      5D28202F19A2D384F79F3B3E3E67E9F3394B5E2CEACD35AF754ECBF908FCE80F
      87D5310609CE592033BB0694FA6EC6C0910A1EE001C516EC82317089B8D13834
      299D159C4850479D0A654CF57E2898CF675BD7371AA25070887695A9A8E7A535
      BF7F06C234E0544BCC08B35F674E2783F84F9E11E5DD6C6F55C077480A922836
      01160AA8D884C0DCF46E9B84DCDD914B08EEA42D66A579D5DDE45653D062A8C5
      5FC1D15BBAFC95C84C4E72E26A1BDB33B7927E544502DAB46CAE20C1FDC163F3
      5E59CC0DA75296C1C47564FBB3FCD55C11D2C12AAE7EF50AC643F157F5D095CF
      D9FB6B71C1B8484371F86649B3C3AE9AAB1F0A5D19B4563EA1B8274939A1A2F2
      8CF24CCC7DA11EC4F68FCAAF5F936C87306170CB1372771DDDE9E81E46FAFD97
      E47E6BF1BEC7D3F87ED07B3C9167C1459C451C8319C3512083121AD1DB894D89
      CF84C3D633A98445E8BD8C9C1B707363DFE55CAE9767BDF7FC64729B5234FA43
      CA0515526D66C14F6D5E00C1049735BEC34A82CB67C8DEFB311BF5E2EBA18AF4
      BEF382A2C73F5FFEFA625F74BACFD432FCB905E7FC6934F783CF389119CA51DB
      5B60708A73B5479A15CF4A06D7DEC29CE10F34EC9C866DD2662941E3C7E2C3CF
      B5F14693A0AA006EBAFACFA22299715F282A42FA4C2397BC67AE7CC2EEDC4BA1
      794F5173EB0183A231A2BF381B3833702A338672790DD8DE17B2BB1BCF6377FB
      9DD96D2A2C6FA8526C79DF6B06678621BE444F3B458997D2CECF94A37807EE81
      FB1F35EB51FCE51B7AFB5FBAA1B7A85971D1578CECC42C3E1D24D9F1A43F743E
      5E9F18588C4263AFCBE619385A9BCD75737C5866E2D673A804B32339633C508B
      18F0F69DB7EFBCBDF84112672B2B5EB3599864089CE38346CD8606B36E0ABDA2
      2EE392A4296885AC3A708F1F4E3C622F140DDAA49ED46CD8A50BB59EE3A3DE1D
      B6F2E51986E62E3B341E086936C5D078B089EB649F94274DDF5F5FA0F0CDCB4A
      94B4F77E813F9E1FF32709166A935E269F4209364D218AD6B0CF214F9E6DE7DE
      52C1C6C9F5A565BD36595A4777038B6F24460047604EAECFEA260E37BA8CF3F3
      DB77FEAFCE37D45582F27F4E2FDEBE9354F79A6D1583C45432C809E6584931D1
      484B6A857374C47EFB9A8D9C4655569E9B7A883A9DE30D072E9F47611AA223CB
      D2A4024B748F1EA55C1F9F1DED3BEFB85E020CADFACDC9F57991BA5617DADB30
      38E76706C3612E67EDB6CB93ABEF6AB65160C3DE2BD833BF4AB1B870899A8DF1
      649093FF5959FF1DA7DC32D242D6B7B93CD5F65775D380A59C01E7754469451F
      08F803DAD6AD640D925199C5B1C99EADDBD08F8DDF3D7E18A87E1A41219C504D
      2DEC37DD8B6D32BE641FDB30E2F61655B251EB47EA21358EEE0E9C1FA9C08B80
      76C72F535350A27A92893CF5B834717ED3A3CC80A633ECBFCA738A2865A2E5F5
      C4EDCE014A0A9417B997B67FB2BCB6D22CC4D6EE52761055F4513E504A499574
      A9946F4345B445058A53B4794C04680D953891C9D9ABB9A7F340D74D9F7C737D
      48500BEF1B0741CD4646D6DFB3F7B8E2F6760BFDCB5881753DCC65DE0AEFFA50
      499489702CA4B36E261058613A60848A982A0EA3A2B59D2D3267F80B5094E2F4
      0DB9F9C039A60FEE1495A4B0CA8BFB22697F6A326DCF8F0309E0DFBCCD08EBB2
      9786A36AA6C6C65DBDD85DDDDCB8AB6735A0E04B6B40DB5B3F5F5F9F880A74C4
      D2813A07F726A1C55C75764995352AEFDE3EC9422A68AE582D241DAD4A8CFD7E
      6E4EF22F0751143D7FA08AB841ED5472E8A38CCDF8ABB32330C36346C0962E23
      F98E2D9F935CBEBA8DBDD052CD280FC73D0AF60FEBA8EE896703FF540A126B36
      C4EBFB8751DA87A6F6C395407512E8ED64ECD3DFE66CBE2E5AB8E60CEBF9C315
      F1DA03FD91532530BBF2837DE916C549D452CCFF12CA54F07E449FBF4C321FBF
      1592B56EBBB5BD553475784D0A68E7650C451C2AE59DFEA8A8853D419199B413
      033ECDDD77B3F7A9A0CE3B3B6FC81F7425D926054EA8CD32D911E5D6C0C89B07
      D90C71CE63E1A770CD5BCD96A60FF992969516986AE170955E12443A79DA4F7B
      1817D54FEC5BE0186ED225D53FA6324871B14BD1B785A39783228DAC2E33DEB9
      E2166B162584A0A267276471B5F973068418AA4181C0D697DCED8A41A306B59B
      A4EDBE663DFEF3677965612962E7CD837414E2BA0882BE2D20EA2B3D084C6C57
      10631F86756379544C07B5820138FF1B6270EF5C0DCFD508AA677E30FE28F51D
      E5977F9BE87C7C8359C897D847C6E41C8C0550869157A4BCD5D4FF32DB8BA06D
      417DE75222E95B41B440BAAA5C55B325496D93A0C778E8351BE97B53FC4F785B
      16852B66DED24F7F53751CF1A012F564365978A90E2F4FD990E41426269BBFE7
      D45B68902660A07DF20EA5AA875F7B592C76E5C6FEFBA4FDB7B1FE66ADBFD697
      B6FE7E665B43344DE75A00A0583D22D96F94CC9AED9A19F2F5497D3577635C88
      BEEEF8355DC827248BE08A314C85CDE2AED9E0FFA985CD46567C4A56340FBC8D
      B4989516ED8DB4F81FCA8A27E3E465A770B8923F753C5283BCA7C61CD8930A62
      63BFBC8C86AFE5FA28EBF7B94B01E7BE58DF4DCDA6B6733D2683759C2D6DA6D7
      6C029F36C0367CFC093EBED1FA1FF1F1CE97E6E3FFD49A1FA7EC1431862ACFBC
      ED4963CCBEA6F06DDD865D4447DE72A64901F4248BCD6E3B727ED10430B79A4E
      42D69EFE35EBAFDE67699C4B8B3F2950A742F69CA7906C6F11B0D684C00E2890
      65FCEA239DD83E79FBACBF835F189DC2E4934028F4C9FBC26831028245381443
      AE5C26A4B941D10F6BC3823FCD823761F7472CB8FBA55970C90E0E193CEBF2CD
      C9A161C735DBAC7F1E073477034DD28FD2CFB43F1C3F18688C9A8DF3A3E19D34
      54CBF2DF5C1F16194C351D2EF58B153AE867EF2D0A10A4142186525E1563A9F7
      A03FE4911A6A9200359B088E9B955ADCF9D293BF3622E4D322A4B111213322C4
      9BBF7F7FA208116CA03ABB3C25A7BA0F7E317A707A5ADDD77380155433AA70E2
      24B6E3D3C3B35A0E96D19E6D407B441DE9EA67A2A9F8BDE29C84F32CE672B1DC
      49B4A25C8D9A0D941A66FF6F6A97CD12C1746490F4DE2265C2E450EC4C999A29
      96FD7D1A4F28AB98C02D6A36AF24A37C7B655B5E492B1750F5BB5AE6E2959191
      3A178894A3644044934B479E6F8A401ADFAC5CF07A67ACF3F1C15011D518FBB5
      30F1295F8F416F2891C5FF6FCE66812EF2DFD04EF60CCE301E5DB3C98B26A0F2
      3C8B522EC2B0751734EBE74FF8A5CC44ACDEEFDB5BCF2D34F73FCF687D1AED67
      18EBE305F8C3A34D32EF730CF6B3E09A6D6F61BC83F79F65BCD45D7490D790D1
      70663D24A7F36E74AB06E96F04D0DADC676798BB474E30695F5B6D9B283552F3
      A2419F0145EA653F338378FDAFE617E269FFFE19106C6BB52F0903B43E7FA1D4
      3F2669744FAD35089BBB9746E3FC7380D71A39C448819CFE5AB3D51D7C8E1AB4
      77AF3F6F011AA74A4B671898F643021FCC7AB62486C4BBF13758F738F5E2E84F
      A8DF32D39254D38013296AA1FCECD3DFC1FC0F0E7EF905BCA46025BFFC026D25
      FFE597ED2D5B5F123BC729F7C8C35877FEA79FE1D2EDFACEC261DFA5B6173DE1
      0A4AA99F8AC6992D78ADDD0C68F4C7D9E0C5985D6E3D10228554729AC1CDD5C9
      894913C06E16D1151B2C7134353ED045D9AE138D547E57B709CEC698F6B9E9EA
      6CEEC0CB7F37400BF8A52895AA9FCFD1CCE647AD86D9E0D5E1A89F8D5E1DF6FB
      9381499A19920338BFD37A5C3B429391BF79777CF30AFFB8D289ACE83FC3CEF6
      02E34EEAD3D8E2240048D24118B65ABA7289587318C87552C7CA3599EAA98D74
      1CBF7BF37F1C18CE71AF7E72D28CD55432995E91EC8370623DD4940439B0A19A
      4A85C7C6BBBDD0BBDD38F036492A8FDCDBF3D176FED4C2E434CF27DA69755F2F
      E8393C034C51E922CD3D50395BC0517DBA8A2E2F7028081DCA62A6D58DEBCA9C
      9B3E266DD2255208F98FD21549FA4D48771B73F2DF113617B86CBFA61369B9AF
      2BBD9347D958B46035B8ED91A818F555CF042FC41F661466DBA2292B6BD9486F
      DDABD924EFB2F1BD7EC8AB559765E9A4A9BFDC7D7EA7C80991FDF37B445EDAEE
      50FB949F3354CFEFCFF9CB5283266FC42A96AD96CEF1BDDEF33BF75E3EFF2A9B
      E10EB2819E1DEFF633F4A8F897E71F713AC0091CD7EFECF562E7FA2E4DC60674
      0846ACC4F144B0936D7E9F0E49EB8431479F9B0389EB602AEC926A0A3368441D
      C72691A9F2935BA1C8E4D49E004283B292055C49E7F7E36C883D8292AB6ABF18
      6C29D1A4DF7DF7247762642B2A8D4E09A50BEB3534C29590A0D8302EB8B7C060
      11FA5281A65CB355D01FA99C572F1CBB5D0586A52ABB96A7839A8254C8A84C6B
      0D0CE281BDBED4F2C7C47FB14FA2FA73D62E98B6F132E5CE2E254C860F8E51F4
      EA46AF47E351EF2F478413464D6C0864C0B9A0281AF770244CDB5E3A0C338C70
      DF39C92369749897AD9A85786B36A76A16B5C15CB307869C2F46418D2711F558
      EEE516AE9420AB049BCDF64B619F60B5C9775D66684AE725C8C98D2C0D28C73E
      E8AC9F392FA45BEAFCCB281CFAA266135A1079AE1483E7AFC97723889E8C1A62
      63C0BB4CC23FEEED57FA8D386F46D9879CE23587BDF15FDE7A753B75C58E54FA
      A9845976DF57D2501AECC4643BBC76787ACD8383C03AB95571E9BE43D3B3DFDD
      66DC57B36653AD242926347A0BF4F6E3D5D93161C314DD1007D9877DE7453678
      51E196359BCBE3ACFBDD50633AC6FBB6CF9D5EAD99C47657ED0C2533059BFDA0
      C80F4A582C19B593876AE5EC4A0FE1BC471090521C80A335EC6982ED31DCF421
      9B8C0ABC8634315091F59CE9D5E3CA1A338BDD1F6FBEBDDA671FE33EE3B9EE8B
      2F75A8860FA349CE94BAEF7CA3C727D44190F1088B36175892221DFB42BD3FE7
      1A116717040B83F99E25CCDFB3C187B85DB7FDDFDE32EB22D9EE3CE15D3B63B3
      A5DC74942218D2B6E3EC87B36F9CDDDB5E16AA1E7F850F2EA843A266E4F81763
      C266A216D202F074F41D853BC6844A6A12B54C1D89E909FC608D5B49BE61600F
      DC56A921A9CB5AD14AF976A57EBAFAE6983AD15B8F6EE65C9DBC05F93014BBE8
      7EB58403A6401B85A9386D612479759767C76E652E58FDCBC3A3EF70F4D98142
      F94FB59B04C5DADE5CDE1CDBC34BB2D0A4018659FC40A1E071D9790E575E70BF
      F15ACEE34AE3520E6F72AF343A172C0D6F25435389DB942308894147ACD72CE8
      5CBC3280DD268ACB13A88AF8776FAF6F2A5CD7D965D5FAC575CA1176A3DDBC30
      E29F158124D9DBC4489688916CAAC81EC548DC2F1D23D1F9D0A01A9B5E2A943B
      86036EFAD9EBBC5FB33D335101AFF59A5A72E463180EDC0D34E919A4422837B7
      239DE79C612D0D93D91EEE65A4CB0FAD7FA3A6D36ABF76448F95EAB342D64144
      707F53C2D725F537774E6FCEA92282BD54D42FBA5A0D3CD0846C135193F6FAC5
      9FA50A81124B98B37628C35C5AA0E7FF9850FC3F1C6153F5F8F1944D3CEB3665
      BB4C1C1C749F85F261BCBE1C1AEE813E707EFE5F97E9F87A9C0D7FAD9D97912D
      E3E3B077C4C928D9601A78540275D4BEFD965C3E2AA430652FE68EE034CDDE03
      AB44AC7F66A63B82A032D6EDACB28A592048968DEC29C1A3309F0D282A4DC1B4
      FFAD9B41469595C223893A2D837CA0ACBB684C507ED19D0407C677C641CC2A5C
      6E73F802314748D323B89BE20676289B4D15075FCD26BEC0B9B5EF7C7FCAF1EF
      51D69BF1741DE6391DDCBE1A807847FBF6EFD07AB598F2EBE7D632A6A570DE9F
      8EFEEF95B3AB073639E0378A6E147180FFD89B3640C898AAF36C2ECF4FAFEB59
      165E7874FAEC8DC8C23CE354442A86E95524DF6BE7FCDDF19B7DFC7B7DBCEFBC
      FDE69B43FEF79AFEBDB9AEE7A426A615D0D911ECB9AA314159DA3AAEC8AEEFAF
      BFBB34DA564D4F45C1A94D02380721A8A1BA76542F551456E169399060C40C88
      F7D5742AA27A54F0526C9B197623D4F994BC38165BE285692C74A7399DB5223C
      5FBC749B7EDBEF782DBF73D0A09F17246B43CDAD4D981760E7C87037F9BDF220
      F2784191FEE9E8ECC7F2CCD54E639AF1FEEE90D5FECB2FD2D4C009A98635DFB1
      E959B34EDF7F127F6FB59792F5D14AB6191DAA3A76D2356E46CBEB2ADA5E95E5
      81E81851A38645AE6602C2152EBFB9BAAA8876FC339A0C0B447C35BEBB1D114E
      91A0A3ABF7F5B3ABA6663387C79D7F73F2966989541661013F9DBD3BAA9EFAFA
      CE67E77BE9D76CA3703F5D9F1CEF80858D6A68E0962522327609A84D6FC6C5E5
      D1FFDB9F13DCD974815AC693B8011379E449F4BEB427717BCBE050C1A27D7581
      1D39D7DC4685AC5C13CB9C0C40E907CEF7B96DB70EB584B513DEE24CFA6B98EC
      468A2428CAC01EA595635197FDBED604B5C4731BE97F4CD211A194486E355705
      C75CBC02F614D76DE4B2490ACB4C31E14535BFB40F84CE9B3C14A55F2FC85C49
      25759CC340B497359B1CBB170E2B5444A953601D5A126F24E9AB6E83DEF93F93
      FE90E16DB342DF1081FC22B749FAC36C381972D95ADD467F322097DD2BE3BAE3
      3A0B6847526D607222EB36E4B3EC56C8988277EFF5E8C328C5A80614BFF4CEDF
      D46DB4DB5B3F7F3C06851006F51856B8FE1869DB6D69448E298A2593717737CA
      26B777E0B5F4C1A58D82E02CDC2932D53941371FABFE903BA6F6D97E0C356530
      27931EB75625BFBB831322F59EACB6D46D356C4D212EBDCFADFCA800AB48CD0E
      E1F69127A204CC3F702E8D5188FF60EB5386280716D86F5EC759CE06AA9FC807
      320DCB087DEAE65C8A9AC807FB60B07BF6FE4CA5F28FA8917F5807B9B6CEEAD7
      35DBD02FAF1F7EF146E917D55649A484D4EDD05D2C48E5DD2D7B7C8DF4ED84BA
      E0E98FD4278CA15FF6EA388D6A7C66F7E64C85D08662329FF69D9B234A123FC3
      50DF641F6B37F86B432026194145043502E1C6DE0A5B2B275124AE55F9CB5BE6
      E4A4E6891101E608A556E36F231028ADBC76D3BC32318FFC6130561F9D3B9CC9
      1E9D4B32974645E2BB515BBF1AEE4DB0E6F98673CF72EE2FDEE0F907051B9CBB
      88A4BF5119DBD81480918B94110EEB76BCDE4DB85C5BE202FF0C033E150F61D3
      0DF6F14F8BFEE9D23F1D6797FEF9A0726787F23D38F19D66B5F3F5E874E7691E
      6D98C22C53F8E27DFFB6B78EA8DCAE9FC56992528916E3B4F4876A9C86692F85
      05C6323BCCF0CFB1C62452E7A713B6CA7E3AF12CA4107791CDB3C9882ADA28C3
      A66E0753BC65D4F9F982865A589779E64C06B918DE8210CF2A8B0185283B0B1B
      9F67EDE6F5E661AC0F69DC4E4F0F6EB145D07147641F7390B8E53B613ACE37B1
      882562116E77138B98654E5FBCCD1CEF120E63D9C03D7C00AB4AFB6A80191366
      0223BEFC92F462D2B1FFEB977FA15F2999C2F90CC089DFFEE7E5C9D5D9E9C577
      CECEDD783CCC5FBF7A558CE520D6EF533520E08103B0CF57F8DF57373A0F6858
      2F4F3185FCA5DF6A77DD76A7DBDA717EA791F7E251DE1BAFBA6693DE2F51E22E
      C3D7FFD0187F07F9E5D0B184FEE837DA7AFD1174CA9EEC8776A3F34B926563F3
      6B0413F523FDA207F1E04E8F34DF4DB750B89D88969F262417F57EC993F120FC
      FB679066B53AC236258452F0D30181F3285B6D12EB282382DEBD3279B58757E7
      87FBCEC50FD7A7942277ECEE5399DBBBDA99BC664A27EFB1F1A61DA1601038B7
      94214A4EE7D36389915374A997FE4657483A6D3DA7F27651A205D7265A579740
      EB1630F1359B8A293B68F8CE6BCC87529C33AA54A7C247A833541CC2B81079DF
      D9A55F6EEFB27CBCC77187229A503F6BCAE27E753A98D5B1E05BB25B8554CEA2
      4924B6AB37E9430F4DC7847602CD0D0327387E692C9917D9E8CE6E3CE1C8B472
      EE9454508E34040BE3308493DB3D2A29C5F529E161929526269AE02D2BCA01A9
      DB02995D6F76B13EB6341C7C9F03232A8E8968B16A79EEFC7476755624F01BF4
      7942F291A0BD441768F659AEE55A6E18008100993BE22AA2417A3BB005B43639
      ECF4E6BCAE2BD2C08AB083B402A1C1E50A0CAD919BCE0DE05B696C8A36F203E7
      B09767FBAC73ECCCDEBB43260ED50D0A3BA8DBB4DF55028906D7999CADB4D15C
      F00CB133A6347EA664C9C90835183229CD759B4B71EADD92AA8FD4101A67810F
      67D2B1060212C3A546DA341CB42546714AE61D6936D8D8636DE2017C2F430432
      81531C3127E877C25E21F2F86A9C319B00DB42A3E78BF764ADC64E28CACD92BC
      D043D81B4328DD31ADD350E5D0B19C1D4271DE71EEF503E416C9F19AED2AC5B2
      2A983A166FAB6EAC872387553EFFA7BA4E36319BFA31832FDE1D94DCB3FD212B
      EA19CE7EAFC732DC663B6987B4FB8F981887BAA1F8938C1FC985E998EA8ADF6B
      46B3CF30CE0753FD18EABB74503B6DDFA86E6E40AA9B85B931052F8226CEA5DF
      DA34F4ACEBF09BAC791AD05A530F9C25CE15D42D8A5C09DE3E4334B1D101EDE4
      4A4A12B7B7A20A5E217B087AEA411CB992654B6A9BE8EAFC753680CE7EC118DF
      FCEC125CF7A7A3B32BABA44F2F9D29D2ABDBE2599DAFE9365E359B64EE5D1593
      217AB7A529826859641B4BA6EE41E5E25E96DD4F864E3C61BF04E71EC78692B8
      089D8AAC19E0723218E95E5A4721644D983656E18D746D306904DFDB260F6487
      1D9B44CD62EE39C1EAD5742EA4CA8B8DE2EC180016717BED600F7B5633A8B131
      D26CD2B93EFCA15A363405EAC035E338816C994824E9C0B916E7176D97697DA9
      7A36E59A0F269DE1B299B9A15ACDAE3588A3BCAEB4D9A013FA033B0009ADC32C
      87302932B9E8AF93EB73AE153B70DEA8E8FE965D2925667B2FEDA7C652E32E38
      F8DF02F8C22C03671FD74F952D28A2D1664125AE42E5FC63A2F3B165BA86CD63
      B02325181EE6082723754BC58052FF04CE1E6ADB12085CF96982A9651EAF5D8C
      1616E3845DA853B520A69682704D0450810F4AB6BDF581B015DEF719B6EE00DA
      270EC3F7146125BF38399D2ACE0BB283749250EEC77B9C92E2B8908B4E5C1A52
      765DB7A5292985549A774665A3B5115AB1B490534BC8BFF14787A60E9B727EAD
      67B2CC133F708EE56890837ADF5248CAF51C844891FEA6E372790CF28F7846A8
      E6AE6EEB6357877C753F6429A67AF330D4065C155A13F96D87430DFDFAC03997
      B9E6723EA64EC2FF78D3ECBB01055578CE1B036DC640F3BF78EFED5275F540C7
      DF7394E891E7594423E599188EB86F8FA7959D036A2F4C9034E49363C5F58892
      5F1331200AC32FB4D5F01016BBE33B35966845010ACE432110EDDAC50DED6967
      55D03489325A93C9C511AC1D8363A0A00CDCC22602473308E731373AB333A515
      E21B180794021E71A6735EA39C6DDE3B3DFD649BAA64E410FF85E5131F7046C6
      3256D224167E35AC659393378FA77CF18647D6E620BD6187D46798B442B73B12
      C00AB38F6019D15D3612FF40988D09679DD03AC130EA76F4D5FB2C25E40B51EB
      09E62C22700C0ABA5BDD06CC2C73B8AE2BD6E1E4969C277F6A66EC3F6FDA5A67
      93B6367B7EBF3818E7F6D68F24D9C6944D601B238A8049C9134B2D56A5B58586
      6943352F38B80C696EDB9288BE50F6ABE1B6B2984E4AF04D17FAE3846D86EBB1
      567D3683F2BBCCC07F422D908EA02ABF77544858C43C0C23FDC01E26FD9A823A
      5D1A10F05DC9BBB1CE95BD02679994240986F521B7ACAD2DFA10CDD056771DC3
      B0CA0661361A38C76747F59CEC0E212B1845C8393DDE99977F649C4B359BC00D
      0DDC44D18B0AF7B901759E8C4549ACD92C0E4D723B1D4371A9573A04E143E3B9
      FF57A7D368D4AD2F2E8717347B7F8B8EAA51D663436310DBD615362F0AFC94F3
      C26BDAD968671A90BB004F30FD62A394740228FDDB5B50FB4D6B92B3C38B63E9
      98C013C62FA7051DEE4AEBA7E99E4F7B07CEBB41A5AD87C1C590CEB41FA5A052
      7AD5A4BFD5BB1154D199762E9E27A907DC7FC784AF371AD4121A547BA341CD6A
      505F1C84C848C9EF4DDC2F4E552FE3800B3532362DDC1860AF79D0A9D9EE6D6F
      9D49DEB37E156B9302AD9DC938E998746972598CD420EF95B9E02643755F2A88
      1F9899F5FB023F0456455940D7E39174241CD98420C2F5314EDF714615E20644
      B266EB612096C07C45A6BE2A1CBCD46430C794E3187A82EDC9BB61594BB0ACD6
      8665CDB2AC2F8E8B61116DDE1DDFD099865066352D7676C7A36C1252E20DFB3B
      8FD587C1ED8410C5745E3B53ACE8CEF4B600F7276CECC3A313937828A592613A
      64A467B65E8C1BF6946DD8B29074446DF066E3E382916E6C62282C453DC59C47
      4AAE7F19411473B89E403F8726CB8471F0315EFAA592F0C8F0171CDCAEC04240
      579DD5D736FD6796E17EC186FBCD72BF2F8E2D61D806CC13EAA5C0D90DD489E9
      F4F2F8DA768A10DE51B3AD9B6A46777C422DA34C66C6E1D9D1B7D21B7AE7584B
      21389F60F2B58399EFD48D7557E54FA5B341CE507E23CD3D550C000FAE71E94C
      49C921FE7D2778C2C4E62DC726C748C6258B145C839AED48F9623D675DE1BF5C
      58C95902A6C7673135DA4BE6B84C9DEABD5D0E995F6D2746F29600FD2A3B732E
      18E3976C02EDDACE0B9830F3477F8FA3A8DC4BD9A6D11066E6A0742A72A3D0C1
      AC9FA0367367A03C6BFCF5D39CA3EA65A3C3BA0D5700AE17D6915E5F9E9CD5B3
      29C125978FBC0C1930A2F428E50FD0B9A45FE68E3472969A941DA9A9DCE51864
      A56D7A5585A15646D444629CD58D41EE982A399945DD067708DEF5F09B76CEB2
      5B19207924472398C4BD87B28FE9338CDA5D76D43C4685EB8B51F33C12D7C93E
      A9F5347D7F7DB5876F5E56EF497BEF7BF303F6FC983FAB66EBFE6194F68BCEBD
      BDEC39E21DCFB653EFC25EFA9E7C4D57930165BFCB69BE1C651432A48E7AB74F
      43692CB15898EE1F80D278FDEAD5870F1F0E0614D9840199333C456646FD8A3E
      79E5373B2DEF4F41CE586540BFFF0E93790394B1B1A09E6347CE25B063DAB773
      2A5BE66409415A73CF0C920AACFE913EB7F38EBCC03BA4EA8B507E43A54314F3
      7A35D20A4F0FA918AC501431A47DE75AFF83D121F61DE3A2660FF4BEA3C7D141
      DDA4F5DB498F30B287A484DC5309BBF895468E75ABB18976B371982CE130F137
      0E93D9E35E03DCBD99181725FF3A3011A8291888BEC7AD28C98C30494107E38F
      9C42240D6519163D83257F7DCDC8426CE85B85BC66BB3D8DB3F39ECA5F3823B7
      D25C0AF4FAB7EFAF6FEA39706E922E5DD6F8F013FEC464C8EE845013B0469186
      510129ADE7540ED917D4CF38E9BCA76F55F4E05C5D1C9E1B673BF94BFE6A28CC
      8009986FA4CF11B98AF0EF39FDFBE3C9E1E53E7BC920664EAF6B9A6765119AE7
      8FBFF0A9F01CA7BD2A9341AE122D7EB0E143599E66ED5C0612225E2BE773AF76
      956AD4BEEA57E7222B3AF66689737C7A78E65031DEB0764E94A24182F089C70D
      E8B8498FBA8DB35E8F408CF000271AA99CF288A9AF8D499AB4CDB20B3DEAF8EC
      A86E73A5AA4167A72CECDF316D6E087E950A9C8D8A67BAF5B0BB32C97A2419D2
      C424929276480A60DD787D919F4445E910AF0FA530C3167E6CF9C6B954B72DF9
      16EBEB1CDD5C9DB1B2C97257944F53CB4818B9448049A9966E54CF25544F6FA3
      7ACEAA9E5F1C55D588C6F36AA3528BB040342ECEACAAFF11BBC96D4DF3D71B0F
      E4A3DDAC8707F28C7883283AF9BE734A2C1606FF504358D669CB30BCD7D3A3DB
      77BEA5CEC7976A34C6EF6F55F45C69B7CF36E62B15E9D7CEB72A1D6180270FBA
      960B7B2490E57A54AB515D69C972ACD5A0280FD1A1CE39B51AD577D6DECA06AF
      9DC3513F1BC146D16A480EBAC37E3FDBA7A3BD11A67513A6C68F43A6CB2B36B8
      7E649F8D1E51BA04298FDF1F5F89A62E55DCD40DC9F63B8650CD73752B9AA560
      FB8081ABF7E7028B51B3CD9EF1573D32D0F2838D725053E5607BEBCDE5F10DF7
      9FB1199C0F20439B9D1E8B3F4E6C6A2E1664EC5FD86983B1D0669A7029CDD8E9
      294A5E8526E8EC96395DF234B691E841CF114A784E850386C938259C15C142AB
      8E9A3EC77463FDF1F3BBF39E6D4AE4297594818A99C6772B67C693AADDA8F331
      D3CEE38DE02FEA37E8C29D51706586DD18DCB3FFEF387D8F718FB351DD82671B
      B96C8D5CD813FAED4FCEF02E1B68CA29FFC092D8C450C46168B2B42AD98F3595
      BC454EFEF6563E9D61C663A790101FB25D995E1FFCB8C73C3F32B8D8DCC21D97
      FE55AE2BA1E80C2F6188C4F14474137046CAB94FA89F7BFDBA63DAD08CF4FECD
      A9A7C94B3D109C7F86D722904DFC42A090D7277F13BFEA2E1528109C98E92A6E
      5DC4028BAA286532D2759D6AC18A24C39073F06A889828B99B47DF1EDA9447A6
      409BC329E81F77AA47EDAA406B52CD47C1976372029C83D61EC8635FCF591DDB
      4E121C463161957D39624A1A8418C0A7A9D3C989AB26D254B7895D649556EF3C
      EA1D3A24F7249D3F104012FD25509598CA4EDD866F63289CC78DD148E50D9543
      DA3AF274C0887294FF1C9700FF7519BF49AF7D9BF6B8672CCEF591895F6D6F49
      1A2841FC727773EC85F8D565AF12B92587C64A35A5B277B459DCD1D879F71DE5
      808F6501CCB5B204FB0C7725C55A82406220B1B843CCC7746CB1B36E47AABF2F
      B8248F5E662C597A971ED51050D82C68054BC09AD7353D87D78203671C02AC5D
      4EF9155E718E39EDFFFFEB65B79C0B3219660CFE5DBB6E24DB5BA2A9F453C222
      A71A42264E265E48DF1763E9EE6CC29B12D9B4F583A3327058501B5BA4D2ABA5
      E8E023D837F46C225B7E34175D723E3AAEE037F0F3E835FBCE7032E6C8E9A01A
      591D65D9D846564531B45F625D753419F3D35875C0C3776D1AED01BEDC77B021
      3FC86F7A1C6DC0AA968A06BA9B68E0ACA1F4E5DB8D48EAFAB59418D48D97504B
      8E1201579209F4A86EA394CA12681E2183F53130121540D2E68D09BF865025B3
      51ED9A165CC126EE87E07EC32C37FD16C036C9A7A1295B88B8615F316A731D95
      A7B2465DF2350CF238EB82D7776932FECB71D83BEAA5D17DDD46FEF361AFF7AB
      F3E3E841534FE23BE9C747B17883FFB6FBFBEC2977F994CF8EC95F7650DB5BFF
      72A0F3E101BFE8D1C3FF280BD9237A375AA498D6DC70A19644F3F3E1D9D9AFCE
      DBB3EB1B2E68756854925035ED43ADE7B84F8E4F8F1DC560E87909FE5578A96B
      3768715D54AB0DF898526CD3D04BAFF25D0998A30C051158BCE5ADE31234A7A6
      F37CD97B6DE323D443BD4FCC94343527C74CA23B019BCB18E45460C8A6665BCB
      C6E995FA6A324F526E2C68B64EDC66ECBDA9E4A8BFA24476CE63672BC5E4326A
      C26E4C0A064793ABDD54D9C72321F7F32CFE0E4AEBE9F9BB63EBC6B22894644C
      BE57230632293B80D473329767C7EE3418C0A35640CCBAA1B58066EB380789A9
      4B77048911112EB84505E7465809F520A96177D69FADBD683DF7D9074ACFB94B
      8796A4A4DA031B401506351EFEF520FBF0E07CD08A81C7AA29D9E9C76A3CEC70
      34BEEB67D968630D2F630D37BB1B6B78D61AFEE2FDF6D2327F7D36BD85285CEC
      4F0E5670AC8230BC4CD6C086E49720F90D70DD2CC9075FBC83C95BEA3135195F
      FCC0C44C85257D35BA37CDB9B6B72C9E5B9A38F164087B8343C9524384F3F09E
      5A0C11CE336793D76C77A51D1B5709898F80FA037245C7D821D013D357AAA648
      DB3B548246BC484A9EF39D0207F52E9BF4E28A2E277D92788BF458A53DE77D4A
      478FFD50646F712EC086412DC1A036D8728F18D4176F87B2BD153380A613912F
      8FEAC894C56737F11C9B47CB642F4D42EF3269A4CA355D7F9FF4870639418DEB
      09C5F4885545B689EC508FEE2DA3A284099AC7C980226497593AA81B20DBF696
      186BD76CAC31A60C9BCCF2E95FCCE79734A7139913777DA37C03C224530EA381
      C6D4F28CDD3FD41EC3660D168053F440DAF7A26C92537E6AB612940F3245B494
      683582E6F8502DF7D4CCC83F38D950938A49AE12769039EA16C3AED9948448D3
      EDADC14BC613B463A5FE8EB6EF604436B9F42ACE08D97F6CA980BC61AC2FA4C4
      7A69329478764B316C155195D907699AA2E5BB01C10DF6A82DAAB4FCAA9D7271
      CEC8B4920ECF93930FAE0C4C2D895CC974359E238202FE5112FF5F5BA06FFD11
      8B9612F0B5EAED5BEB82D721C29D1B38D84F886CF72038D854983E92D85FBC01
      12F9BB72EAE1A747E3798888113EA7B8E263FFE986D49F20F5E686D46749FD8B
      77AAD8DEA226ED20F8D74ED2CBA4BBF590F432167F6A94E6D2E381647C8F32F3
      7692C96FBF3DEC50DF4AEA38A9A885524EC1203A0F941E3BF318CC37D4237980
      792419B094ECA4FF31513D46D481D8CC26B777D230D926441AE5987B6D639C26
      A0AFA2683222DC17FC6D54945DDF091FC67A6FF6D5D279F3C07923C9539CF547
      20EE54081449C638674DF16DB928D7C636A546A5667C3268F127F0279BB3BEC4
      596FFCC7175AA5F9E6DECAABE4B5A68F54B14658145EA3254ED6CE9516EA37E6
      9E041B0F0E0E76FEC4B5F9A20D5AB7B7A8AE9BD46106F933516229B54BB9857A
      7A2BD1E3F1486B367F5FFEBBB368D9CCAACDFD5A4EB7789AD8E8B25F824D5894
      A45093BF891B121A535ACA2AA4672F35E87BE088DC288D2BAD1FB8AAB04FEB47
      5C213275EA71D182979EB14749C9FC177330AEE770E42F6974C32E48E6477616
      CC3E29E733D7C9A467339AD9C0D8DEEA6343536A2B062D7C4251EAB1CD6587A8
      1C704F1DD1DB6D5FC4C97832D2FB8C9BAD7A18CB07D3A351F53EA8879CAC9BF7
      342965FC9C455BC75D7D707BE048EEFFDB77DEA5604181653E9816C6F4C50017
      D2BAF4D470C8179AA535B1F1B2BAD28C76DFB1852A7D754FF6C3C824800F8AC6
      74B023F9F1643AD016D95C1079FCF696BC802C6A7A093D450C36E9C98739544A
      4766F381C245841B4EA1A92E73867F3CBCBA38BDF8E6F5B3A71C6D6F950E125A
      C30AB52ACE8ACE7929644185B6792D4DFEFCAD748466D124B0FE64C0495A3B96
      F65E48597A4DCA2378FD27399312A8CE7C4A2E72B6FA8AFE274C807477AC61D1
      C76A7657075AB02BEF4C97EA3E1F36CA99200357AAAE40482C07CC0120C85EA1
      08399D457BC27CFAD4F0F09564E65B3C17487B9C4212F345F2E121E87B7FBA39
      29D1097BF16941D29E05C6679CD19E1A11478863AE2B501F20CA771886BDB264
      F8DEE45D53ABAAC9907EF3BF7923D4369A08F2FC6440D16EE5B4FC1073B3AFC6
      86FDC889621B13E0D36A8177D0704E7EBA3CB93A3D3FB9B8393CDBD803B3F6C0
      176F03457D2AE9C018114B4A36B9B1285542CA3A1E0596F78D01607A56F48979
      F433D34E754AFE9AF6F404C81483EF8B50C4D1DD913F232E7D320C69878FA7A2
      73F6C03933B83A226E044D7C12D9D2A8614635FE29D54042EC699307FC5E170D
      83778E18EB9F1CAE275CDAB653F435AA5BC24A664439FB200715FE82C35E85AC
      28E46E3FCBC716E4CA74373156595FAB414567202607DE9C6B6D1BDFE6D4E200
      7C4EE565C3ABE2F2388DA9C885BF78E022945CF712679752A969EF064E594992
      F7F79DA3EBB2429753EA8C0D65BDC5A165A9340BE816A79CB05A0052D2175298
      284CDDEE8F29AB17EC472B5298AFBF1C6402618AE1D381E86B9160FC5C567FAA
      0FA7E384276F6FE95C9BD94ADD702E9A1F242DE8FB5EEBA1AC3F3D39DF9B7A3B
      152F555E7F9712F55707C0EFBF991ABD6959233EF1977CF9E53757C7A2AC6A35
      EA1118B4ED24563352A4AA8562221641348D59CD48FBCF8688F49C437E33B9A5
      6C2EF6E48B856F82CDD15D964636CF33D452C56B611B440FA9D9546EEE344EEB
      F70329F9633E682A77CB4D61BD853A5411755D5278018AD1D1B757CECF0DFE69
      FABF12719E4841D9A5621E512A45D7B8D37C77CDD51258B77743E69E5C392137
      183D09AF3970BE49C54D6374BAA1BCD246F2A9109D73647126648DCB9EA055B7
      4A116591EC4D512079676CE5DA876CD4C34D38ADF4BE34295D42433A2B82E952
      E9754DAB2309BA52DA2CC51F1C8A2BD80F1EC4318DD84A05AB42D74D046C6F61
      EF97D9796672E4512B1694EB0048504B763D4B0BBB48FBC2037BE9BD5408EE08
      AAB0F3E2B42A7725FCF302E6354999524E3A7156BFBC6E59A9B258C31C765A12
      4A07FA903BD5983B7B1C615651D4D9980EB28CD0BA889D451CA833A80A4CAFE6
      D2589B0F6965D99E128A8B7A94062FC62FBF18F426B45AA95CBE53B1101F9734
      9725191B0361A181E06EC2618F6D821AB4F6F886FC0DD7B6A079F79BF3EB9B3D
      394274E2B892BE60EC79D67BCF3DDFA8D42293BA69EA97BCCF3E3691B8756327
      8726C66FE4C395BE1515AE0000E1BC5A99215B3E62B828E72D850EE4E6CDF15E
      E278FFA961812FECFABEA9BAA88CDF982B58FAEAEFA695A395B1AA978E1F8CFB
      B6627A87ACD45208CBA469A4F99C16EB1BC2FB04E1350F3685FB8FA4CA17EF20
      231827D6019EA42332D3C9555C86602130A09BB1FACBCA69CD36B19C81725CB2
      43A647CF8964AAC76E1A6A44A7088BBC6653204BBFA8C3A5D4F8DB6CF4E0EC7C
      9BC6300DC8423ECF62E71B4A96DFB13D2BA04887DA40EAB084AFD99418C0D6F6
      0CC10CACFEE180E75E901E23E4468EAA5B3DAE3803E8B3810456406C8A0B3ECB
      AE46359B6501A736A4532ADD512E15ECFB6F4669ED2A010EB18E1CE6DB990C08
      9A6BB0631D91644CB1934172354C1E2D85A08C4AC988AC359BCEF6D6F5ACE1B9
      CB1DEEB8C346CAB132A33BC2AECEEFD3E13E391E4DD1C9BE7370B0679285A36A
      749CDD333BD785C1B9B35FFC75910DB478C4774EC9353C768A11ECD46C711477
      7CA6A94D24802DB9A4B6E2C6A63E67499246E4B83725D5359B85B8135F578454
      C46CFDC328A358A44514833A243BBDBD45A9029CF85A80EF8A43201DD11125AF
      95754E2B4B1CBB9C74202BB3C7BB6B5CEF46591402E1A7D56C79A04AE8115590
      8F3F68755F4624348578D3BC6F6485C4F82B480F518F3E2A1CF0359B154B8EA4
      D8F1F4519C62A76852299E356E5D371287F88EB30BD2CF9D7F4CC887AA1C0A12
      53349F3ABB6F6F090404585AA40549927485BD03E790315CD9235504B1631C76
      D39B0BA3226F9D795DECBC79D899EA94679D4E9556CB3635BFAC991F95F713D0
      75911950D3D2FFF3925990DB570D873D0A4F196C6B89C2DB04DC281D45933EA9
      5651FD7C94B31E482EFC19651FAC9781356F274FC13B7499FFC45E15AAA6209C
      7DCE2C283CE81FF2B2BC80B321ADEB41F09A386948003BFABA9F1D38D7599188
      437255AB3C65CB51C565B7F3911366D97DDD4E22C5131E2803F4D6397DF19E0B
      666E3376AAAA9078EE5F37A5059FB47937D9D68F6CDE2F8EEA3DED4725F62635
      337125370247B5661BF7D64682B8D48DF4944B0A7A7392C55136880DBE00C3EC
      42A6C43C1DA99DAA9DC15BD8B3B9B3CBBAA93014E6A53DEA915A372C7C3236AC
      DFBD9200F2D8AA10C5658FB741F2F15E49F935E7E429E760AC739F444C014CCA
      D9AF45503827DA1C9209C9CD79B925656E82BD6507DF5DA3BF5BF82B0A3B0E55
      6E7CFDA66CAE408EAADB625E5A656EC499880C425E2DF0A175137F4EB9360612
      BBF4EBDC423F5B42FCA826385BDE73832EFE25D9FC7CDEEB477CC96B068DF6F4
      BA99F56ABBDD6ED7EBD8D636BFFFD72FFFF20B45DD35B7E50C1A7ED8F01A7ED3
      6F341A2DFCD791F40117FC577763DD48C224494C4A41D470F97F3DF93B087DAF
      95B474DB6F05F46F90047EBBDB6EB482B617C4AE6E775A712B5251B71985BE8E
      3CAFD16CE0A2B6DF49A28EA70337F6D5F656370A5DBCBCE306BADB71A3764747
      6DE5B6A3A81175BA5DD76FB6A26EDC095DD50E020CA6ED47B11BF8BEAB3A6EA3
      D96A456E14773D2F6977B5176AAFED86713369B4C320F2BA9D6EA4DABE5249E2
      FAAE8BD7E8B019FAED2056419C786D3F89BB2ADEDE0A5A9D6EA7D954CD8E17B5
      9A2A6824DD4EE2872AD461E476BC76A7DD69F878585705AE0ADAA16E618E1847
      E87A7147771B6DB799741BCA8FDD44799D861B855ED06EB9AD4E2389B19C3A8A
      31F4661C353B3AC4539A5E477B51D7F7E2B60E1A5ED8DADE0A1BCD38E878B1D6
      3A48BA58065FBBDD4688317889D7F2B58A7CE57B8D4EC70BBDA8D1C5C2E94875
      92AE8FB569B63037FC1976DD7612B85AF92EDEA29A511C7423AC54D26D76C386
      EE04BA15605B9A5EA03AB1761B89DB083B51D38DBCB0B1BD458B1D2451D2822C
      6CE205BA15265ED8D59D2E861FC6ADA0DB8AC228C67C43B7A3DB91D70A741461
      18CD2469FAAD46127889EE34BDD88B220C236C27422B09510FE8E5293AC36E60
      0D541B8F950F1B50099AFC4B68282D69BBA0B1A8EDB909E8CAFCDE21424A5A8A
      280BE36FEBA413843196B1D98EB1DE98591354859D4854D06DF81E6D4F3BC686
      34DD4E3B69755CB719C6A0088D7FFD647B2BC2B6365418629DB1DC3A49DAAAEB
      C58956BA13265DDDECFA9A56A7D5554A355A91A75D1F841785AD8E6EB65B5E0C
      E24C40C1DD4EA07CD57683068603E269745A782FDE1112014741236E2A0FCB14
      7BCD66A802BF13B6BC463768BAD885A4D389BB3E5DE52AEDBB2D3F6E62871BB1
      8B010571E8F92DD7F5DB896A779BED6690C46D505E8786A6B16638195E12345B
      38586DAF8DA9E84EA23A513749403558A328EA6A3F899AB83F71231DF8D89416
      8E4CD7F7A316BE6A6104AA897395682FF0C21834DD69054AC57E53C78D300841
      71712B89656F96D9D956D8EE765BCD56C7708C8E2A3809FF8073E00DE012819B
      C8EFDB5BD5BFE8773FC60334FE6B83AFB896AB6032911F37B0F72E7115EC693B
      56CD76BBDB0037C0668420533F68E1D047A1D261986064BED78D9ACA6F82BF60
      45BB09E81A27507B1DCF6BC336061DE3C884DB5B980F7EC146468D7623EEA856
      0096A33B1D22EA36F88D6A63DF3AB1F23BCD081B15B5228D673671C074B7DD69
      62C543BF838316277E1764E905181B58056810941187411CBB8DB81506605581
      DBD4D88B380E34CEAF0F4201ABC308DA415B77B09B60DEA0327C898960431BAE
      D75965FD7DDD4CFC46DC66CAA6AFC226EF40B3B568FDE5F7EDADF22FAF69D75C
      47E02849874E4BABE9879A08C94B1A9D3806730BC396F6F1B6308CA266B7A571
      7D37C44CFDC8F7B5AF3ABA8533D0C29EB55B6065389D6D7056CCC9A7A3E2464D
      FC6FECE1720F1C314E4007382738657839CE7082E50A71185ADDC08B7018E306
      EEF5826E170C3D6AC73144800B5EE7E2F4350370579DE0195DF0B0185C258962
      BFD36DAB248E1A89EAB6838E8F3DC7A281BABBDDB6ABBD2E8E70A0701C9B61D7
      6B616731C1844E635BE108AB16044E33023579BE1F743B7E97A8C905B7C570E2
      B8917849D8E944ED56BB0339E1B5A20EF6BB4B1CBAA15ACDB8DDF0741CBAE0D3
      D0519A8D48795827B78BE56B7412DD05BBC1604094AED65EABDB6E3671450BCB
      DA041DC46ECB8DF1995251D06C408E8257806BF91D97F856176CA349C72B741B
      2051702E6C0AA45B43D16370D2FD08AC2C6AB5630DE9D60A9B584D0810ED4284
      F83EC461A78DF300298E817BAD56DCEDB420763BBA0136E6E9B0ED42367654D3
      6DE876E2F93A0E5A01484947DA2539E5BA31447B0712324E5AAE02E3ED06ED28
      01BF82A887D84CF03AD00BB1CD04ECB60B9EA87110BB71006501620E2B883B23
      903AB6296E29B00A95D09C1A9EDF54200815782ED4AC5045098E4DB7DDF63C05
      0D04F4923415481A84D485068133E6B961A25D5A912880CC4A3A2D12D95D1F5B
      1EE25388051D25ED36F61082CB0FC19855D286EAD2C0C182BA80D96027887CA2
      00AA0B4E39642444481B2BDB8586820FC00ADD4EA7DBD024403A3A68AB38E944
      38BFBAD56D34BAC4DF7DEC7FE4E176F079101596B213745C48A70EC829F4218C
      5A203090760BFB050612B5350E3F0EA1DFC55240E0BB5072921651111841D088
      024F2B488066677BABE9612409B6130B1BE2787554407A066D4A5777BD2E4441
      078F4F823628CAC58A837D43F6815B77DC661BCC81C81A67AD996095B0482D62
      F8A0628CA141FBE1365A49A013AC1C78189640871A92A783DDF0DB107DD1F696
      17917886F085F08F7D1033F857077A9AEAB6541240A060EC89C66153AA9B804C
      129C41B0D604374304F9D00C9348E3A4B4412C7148B77455A70946EB062427F1
      D00496632769E225FC97073D08FF4070415804380B383C90BB50457110B0336E
      104720821807A4494A2056AAD169FB587770608C390667865C009D43BD83ECC4
      22F890B5510475A001A11EE0B25648136D34FD2669AD20678856F0CC06B42288
      645248630C0B7A570266053AE844D087A226144D3C1B4C050CB41381D1B73A61
      071A4788ED869285B140BDEB80B0317C08DC66002911C73ED60E6AAF0F952071
      7178C0C5C0A31A508DBB602A41942828812D701FD2E03A1AEA6347E141910BC1
      D4842E16F9E0079DB001BD34EC803BB72160DC868296EB421B8A5C48165CD3C2
      3DD84E887A8C2EC2DC55A0A01DC45DB01E6CBE0B1DBC89A145E0A74DF0BD0E24
      65D0EC7A24975407C2A5EDBB7E4C4CB483330805D6037D44E0D59844EC75C113
      49CD0587703B0AEF02436DD383FDC885D20201894F711055A38BADC0AE83E641
      5D6DAC52D7C3D87CE86F5E07A4E62A62A2203AF037285A507F83B8E37B0A071E
      52246E685C89398369B9E058D04021EEA02A4350433F682664304071D2749E99
      DCE9E84093C17FA0778C1902022C2F8636D068433B8DFD18E38C3B2E4EA6DF4D
      9426C5C407770A025807214425B4585086071D512BE2662D303B687360D450DF
      A086771B4D8DE725BE87B380156A2AC8E5109B04DD11DC11BF820783C32560C0
      E06501C8C10F702A7D3A6A900D3833B106C547AD24F214B631049D6BD703CB4A
      206F401D1836068F531A87AD20F47036C0F2B4C681715B318E56429607114D82
      1168DDC05FD09BC19C85FB82778341EB0093803884CC4ABA09F4220CA81DE1D9
      4D301B37C4F370767CD56A63CF1A90795DA8EB2410A01482753542DD506D180F
      5EAB09ED3D86E503BA01F3C269C37313B7E9E10034DA2D7024EC5D086E0D3AEE
      42CC6077716C3DBA1297821561A078622B81098CA3A3F0369842D8BF58E96E0B
      1C1CB2B70B8B0EEC03865702E32724A90D8601850B0710E211741B846434B5A1
      9A745D4C0E5A284E4ABBE1437E4332C56117BA0F16C7C301F21B11694F384CE0
      B1D0902146C09D60C9E0C4432E81C983141B501BB0F2787B088A8D03E84444AA
      60B96030B0B2C89A24D3099A4C1BC665179A5C133C5F059837E6D1258914C651
      04CD3CD264B541D581C2D36A355A0AE67783D40030EE809452E84490C990A160
      000AB21DE73DF0A0A207389F3890207F68451832148D1608D0F71B2D68A701E4
      0EAC5028DB9D181B07BB119F06104C60F310E510A7386B90E4788C17600409AC
      5828C7B812965D47414BC20CB152583C0C1FAA00164485181BDD0536D8820ED5
      C6EB4090E0F590045A613B9B100A640DB471AA22B069BF85C3AA5B49D249206F
      60E6E22FC8535834585DAC9EDBF51414F198EC46500574A3881932941DAC32CC
      44F04C1FAAAAA2B3E906747AA20E0E520BBA8187AD82BCD13081B037F84AB770
      A6A0C8812F05EDD853C42461D8C1C26913D9A82E1EDB811821EDBA0D7D1CE408
      7EDB86F1DE261D03BB40162D580D49409C7E1706B3C2982035BCA68FE76AE81F
      6E176CB5056505021CCC184A0E8E378C3328941DEC1596B89BB8ED08C68F0FB9
      DC6C76E306169D4C5D88338C85E6AC03C859B0946E1061A1A06A60B91B510323
      001771BB5047B1CDCDC0F77C58F2B0B1B145D817E864AD48918E069B2CC63987
      AE074A23EB1C2C3F8648A275F761DAC1CEE87A1E6C8110F24EB9202D58276052
      60EE61B3018505323E002B8AB10F611B47833C145832DFA5F011B49706D87237
      81651480DB6164E029AA19C25A85DE40FCA111462E7425DF0DA104425AC5ED36
      D4653067D8BCE038D8B22EB970485B09DB60904D902F240DE40C7B46609160FD
      6149C122C4E4B09718484213273D11AF8400815DD98A3BD05D612DF9B81AFA8D
      0BA5013BD0F261D036232C0F7820B464E810ED36F8073E6861EFA1DE44B05203
      D02F4C32087EEC0B4E39E4ABA661428F8311D26C77239E7F1C421E91630B6B10
      93888B418960C211B8394C027009502C461A351BB077C2468289BBDD3678B3A7
      C904242D0AD22DD638C05039E8ACC1E68572D4EA420C827670FEA0B1853A8099
      08B5959C0EB4DC5D226D0DEE8D6D83ED448706764FECD308400798600B82013B
      A612EC05140AA83DD0D2C084B1F8DD58A920D1603D9EC293DB385F6457838A60
      E063C921151474A616AD30F62800E308C197DA38A230E3F119980C6818D480F9
      9390015982A05A60B3111429E8C0B01BA1D740C2E23EA83C104B1801D670596B
      B101A6D56D7469B462A5876269BAEDA7ADC5D23B03D9F849CB7DDA7FC3363C69
      25381838D16E9BDC25490B1C245464F1809EE24E0717E1E890A1A47D0F862119
      48308B9BB04562988964D174A05E8195811FE86E17CA6DD86D4307EC4239C3A1
      8A351813CE32A801D2081740B7EFC2C6809CEA40EB840E08431C12A0D38DBB1E
      444188A5E98001B4C05F75DC840AD385C1EB767C32C87C983E789B0735BC8D43
      E742A04205878E02ADDC4FA023E140C1C054D0A660E9F8AEAB3C05351EB65B18
      4378C110C1A9056F23B71CD45DE8A9A0E2163600F21D52A489E1073029C86B83
      65801ED6E9B6409F1093B0BFB0C15057C14AA032128F52E47E8870CCA0CC293A
      E97E048B25003981C2A1F6C8CE4DED3E64BB1B5381D8EA1EDFA77EAADE606869
      0BFDC19F1A0379039FF205CEFBF11A72CD34259694F6A9777ECA4F35EF0747C5
      7DEA54547D28F34FC2A746F529EFCDBC1FC8A46254D88539E39AE7D9F9D4483E
      C519E68E04C7F7A9F5A9FA7497E7193CD2A051AE4020FF05C62B16450D65BFFA
      7D7B8B821D51D6CB467944218FBEC12F8155999827834FD39BDA1E582BA81736
      954BEB02F3CF85558C03DC22AAF6F12D4C4BFA3680B8F761757A1DBA02F6BECF
      23A67F237A02D61557B5BB44F57816D47AE89D8A220B6003E0D56D980F64C540
      A768C81870563C7C47F61C0C80B68FFF6B40C34A5C725278666570E6611C256D
      1E93B9AFD5A235A4EF7CF3AD4B9C0276968BCFDA32669E2514390FA704A66142
      D7B7BA74427986B8C3933743ADC1CC694E3E542BF9CC6F85F2195FE716D7B9C5
      756E711D7F8667D398391E649E31F549790D53277DE63EBAEAF193BC47D7788F
      AEF11F5DE33FBA2678744DF0E89AD6A36B5A7C4D072B4E2B1ACA3ED9BFF83BEC
      442BF2A7AF98F90CD781160C4D52A07930CEC70F3D9DFFD2CBE37C9CF6D547AF
      1DD01FBD2CBAD771ACA9993BBED2FDF48EB3B1ED279301D59F53BEA9FDE41F92
      8466FF1C8ED26C948E1FF077B7FB5FE523A50F9D53B9A3E954AF6F38E5B50DE7
      82F14BFFBAF0EAEED4D5775A02A7CDBF6E6F4D0F5BEE2A07DD5C3C80F98F74FF
      FACC0FF49EFB81FEF34F3A78EE31B69EFB81EDE79F74E7B9C7D85DEA81F6AE14
      47ECE3D2143C7DD772443A7DCF7274387D8FBFC63DC15A335A8E60A6EF69AF71
      CF729B3E7D4F77C91959EAF0A6C9639C45D8E63FF880E576FC8907787F7C12CB
      51C3130F588ECD3CF180D61F9FC47244F3C40396A3A0271EB01A9B10C1E89C0E
      083C61C5A39564D978C0FDD0F5C7F14A6F5503DC67A01257BD97D8A11EAD740B
      0D14B7ACC3380CF35D9F977BC1D45323C51D14571ABE74BECE1227496F27239D
      AF38113D78AF7BD9B0808D5BE9DDC5CD233D9E8C561B77411F45CEFEBA44523E
      60B5A973FAB85420AFF4EAA1BA5DEB3EE8B57F60C2F66E3E12AB4DB420113519
      DF11DDA57AB57DEEAB6894AD4695995AE974D8FBCED27CD5D9D12DCE9B49AFA7
      5763157CDFC5EADBC8F7ADA604F12DCB0AC1A99B565382F896E504DD9CD55B67
      52E6CEB5E666EE5D638AE6CE35662AFBBDCE4CCD9D6BCDD4DCBBC64CCD9DC162
      E3B4396DCBDEA4E3DE6A8CE5A8975199D68AF3BA4E6F078A907857D248A69F71
      6C7AEB528AFDED480DEF9CB7D960B543FC268B1F9C9B55B584E2AEF5541BDE19
      427B4E0793D5D67AEACE75A8B0B877358B6AFADE658DF8F977AF76EACE4DBFA7
      6F4BC56C3E19CF90D7241CAF4CC9D7AA37119D60C5091EABF16A6F2A09E82D83
      391832FAE38F5891262E4823F8D6C8D9D5E65CBE7FB55796F7AD4682B3676EED
      D79ADB5765C46FE897D559C5B70F0485940EEE57BAEB6D46C86C3A9EBE7B2EE1
      BBEE340D8FA9ECDACC6DFE0DD30CFFA43FBC5379BA9A42779C4513C6233F57C3
      956EBCA46A96D557F1E4659F7A1D964263B5BDFBF6E6FCCCB9C986A4C312AAD6
      6A3B4837BFA192CAFE5AF71B2378F7471DEEADFEE24368CE8387FE3A133E5CC3
      22E31B8FD215D999DC95C56BDC755C8023AF33C5EFF44398A951BCFA7B2F6145
      F1E118EB35EEBE5654B3B7FA7D5415F8018770657F01DFFD831AA5648AAD437E
      372BDF58B190F349F8771DAD76642FB2758CB17752402C2AC3728EC7B9B7AE26
      1CA66E5D4D2CDD08326C4AF4B0B2437CEAE6D5863C75EB3A433E627C8965BDBB
      F3EF75D79AAFBDFB8F8C7A3553C8DC4BE16D6A20B2D694EDCD6BCED9DEBED6A4
      B3DEA43FC8D71D37DFBB0E75D97B575595A6EF5E73ABF8DED56C05B997509DD6
      5A2ABE71BDEDE55BD7D95ABE719D15E21BD75E9E656311736E5D2D7055B971B5
      E895DCB88618A8DCB8DE5EAE2D04D670B8556E5C672FF9C6F5F6926F5D672FF9
      C675F6D23B36AD8DD7636495DBD7DBD7CA03D663C283B1EE0FB3911A3DAC71FB
      494FDFAA154D7CB9F3729425848444B048EBE9179370CCCAC9DAB7AE233C60EE
      ACF54ABA6FBD0DA63B57F42910007A56B14717443E4B2EB6C6846E289F6EEE7D
      15A338D2D4C55C8F64284F58EF8F94ECEBA18A6C94C45ED49A36F1CF183DE9FA
      AE0CA7141736E75CC86AFBD455EE9CAB8AD528AEF2A6AE3AD7713AE9DBB71A52
      28AEF59FBAD66E7F717530EFEA8A6C282E6C2DBCD09DBEB03DEFC28AE6505CD8
      5978E1CC13BB0B2FF4A62E6C4FEFCDB11ADD570DA5E2B2E99D29F4C779BBD876
      E75FFB6823DBDEFC0B1FEFE51304E41C4611B97E9ACB515279F9CCA62E22AA05
      CF7F9ABA16DCF434992DB8E9096A9BBE63D179BED2EFD3BCF468CC8FDCFB33D3
      CF2B718C27BC7DD364F6B749665C35F35F32BD8DA79060835C57EE5AE6E02C58
      A5274ED0C22D7FE2302D78CB13A76AFE1D8B8ED782AB9F3E650B6E7AE2B82D9A
      FA53276FC1D4973882EE6A47D05D8EAB2FB87CB903F888772F7704DD958FA0BB
      32012F2F0216DCB104F93E9AFE1204ECAE44C0EE3A04ECAE4CC0EED28263E1D4
      9720606F3502F65623606F1D02F6D69120DE0A1ACB82172D41C0DECA04ECAD4C
      C0DECAFC7776EE9F22606F1D02F65626606F6502F656E6BFFEECB67F8A80FDD5
      08D85F8780FD7508D85F99FF3E9AFB1204ECAF4CC0FECA04ECAF4CC0FE4AFC77
      76DE4B12B0BF3201FB2B13B0BF320107ABF1DF60551D3E588780837508385899
      808395F9EFA3E92F41C0C1CA041CAC4CC0C14A041CACC37F67A7BE0C01072B13
      70B03201B75623E0D66AFCB735BBE1CB11706B1D026EAD4CC0AD9509F8D17C96
      20E0D6CA04DC5A99805B2B11706B1D029E9DFA3204DC5A99805B8B6DF1E6F43A
      18CFEA54F6CD7C8B7F7A7ED6862F6E7CCAC7D09CF7CAABA9F4F1F937BA73DFB9
      CC9DD38BF426CBEE5748292D9E324D976FD2B09766EC1979F823A574B35EDD77
      4745EE5BF532FF9177965296D8973B6DA2FBEEC20BA7CD27DF5B78E1B4D2E9FB
      0B2F9CD53BFC60E1A5D36CD49F3E4E4CAE36940386377D6D6BD1B5CD7957B717
      5D3D33FDCEA2EB6666DF5D74DDECE48385730A985F4C3D36682EBAB8559CE2E9
      1BDC4537B4E7DFF0C9659BEFE27962FD16F9919E58CA05EF58BCA6F36FF8D4D2
      2EB86B89355E34A765967BC1E4965D7777D5755F9A8017793F96587777AD7577
      D75E777765225F38B965D7DD5B75DDBD55D77D690EB2C85DB1ECBA7B6BAFBBB7
      F6BA7BEB51FB2351F1E975F7575D777FD575F7D7A2F6478C7F8575F7D75E777F
      BD750F56A5F659AB6A89750F565DF760AD750FD6A6F6D939ADB2EEC17AEBDE5A
      75DD5BAB52FBACF5B0C4BAB7D65AF7D6DAEBDE5A9BDA1F4D6E7ADDD9225A5A09
      AC5CFDA40CAD5CF7240BAF5CF72407A95C6754C0271947E5F2E594C0CA0DCB29
      818F976D2925B0BA7E0B6E58BC900BB5C6C56BBA9412F86871975202E7AEF182
      3B9758EC85935B76DD9F5402E7ADFBD204BCE0864FAFFAAC62B5ECBA3FA9043E
      B9EE4F2A814FAEBBBB1EB5CFEA5B4BACFB934AE0BC755F9A832C50C9965CF547
      AAE30AEBFEA412F8E4BA3FA9042E5E777F556A7FA4357E7ADD9F5402E7ADFB6A
      2C7CC15D2BACFA23F57185757F52095CBCEE4F2A81F3D63D5895DA1F698D9F5E
      F72795C085EBFEA412F8E4BA076B53FBA3C92DBBEE4F2A81F3D6FD492570DEBA
      B756A5F659C56AD9757F52097C72DD9F54029F5CF7D530ACCE71CBEA257BD77D
      351AAF5911FBADCAEFC66A353090EF07239D673D6AEC6607FC3B77F5A2865EF9
      985ADA359A8C8BD9102CD046A369B03CB7B77C6A0DC4E8919EEBEAC0F39B4127
      E8F8B11F0584B0D96CF982BBE9B5080373EE4F4B9E1437A2A4D9D40DD50C9B4D
      A59B8B9140E5C7A35E177864A29384914117A1983667FE77E60BBA3F29106A1F
      FF5D7CFE197F0879FDEBFDD9CCFEEBFD9933FBD8FCAFFE7347F2257E367BFFF5
      FE6C66FFF44F005DA395C87F6D5F540F1F5A484BCBDF6D7CD0EE7E4A4B58FF87
      51D183C572BF11B554DCED74BA6ED28CA991492BC048FD46B7E5B94153078B9E
      EB373CEA3E4568FACD4E27F61BCD451A475D7E16AEC09A3FDB5BCF39BA3FE3E7
      3957E09F6FF6F4F35C2BB0C6ECADED617E7EFFFDFF073D7C1AF4}
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
