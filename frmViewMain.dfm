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
      789CECBD6B77DB469628FA9D6BE93FE06AEE5DA6A6291A00DFEEE99963CB76E2
      D3769C6BD9C9CC0DB3CE02C922890804D80028899D95FF7EF7A3AA50200959B2
      A4986E56CFC42241A050B56BD77E3F7E1FA6F9D41B0613318D8278E6B97E6718
      C45948FF8C9733CFEFF8C3D598EF98B6BC8EDB1BE2277798E5D97C3A198DE778
      B1C35FA384BF76F9EB3C2C7D1D85FA797C57CBED7BEAF354C09BFBC37C2E1642
      FFA6BF6DFE3ACEDCDF87D324CEF351041FDC210C3D099DE1344D16413C9C8EE7
      419A891CAE2FD37FF8BF0FFF7DB80CE224138EEBC3FF75DD96DB71DBF09F0F9F
      DA7F7C0C1722737E1057CE077CFCAF7FC090BE1E72914C44BA39A6571EB307E3
      0C686C1CB30D639E25AB3414298EFAD73F8E6A3062AB6292FEF624019C2E2C18
      FEEBC16471D0DE1FE7EBC52889686E5EB1DE388C6E1E68EB7F7FFC1CC6B309FC
      97C97979ED8A8979ADEE6EF86D8CFAC78FEF60B8B7E127BC6F1A44B9337C32EA
      0D9FF45AF0D71F3E99C0DF60307C320D864FC69DE11331F88396D1AA7AF1CE6D
      C3EDE26DC3EDF311C4C162948681F32EC8E70AC63D3D64761566D9CD434E69B7
      7C1A5C0D198530264DAFDDBA130A8C605E83F260499C255190F19EF9ADBB4C6D
      241189FF0334FDE35CCC12E17C7AA376ADEBDD77DBFE97DA379A600483FC96A4
      433AE20F7DA068CA9391F1867BCFFE0B916E1E1A93F0EF862DADDDD8E2BC0D67
      F35C2E72648E5F75E4EF4197609BC2588D7FA70374876D2ADED0F97ADB544CA2
      FB40875A6D503172EFE137A8DD195411FA569F8775369E73CE5EF1A3DDAA73E7
      E356EF7E749DCA85B5BB7ED56621ADD8F9F477A91017F2DD55C8EA75FD8AA73F
      AE52F96C250BE9F52A9EAD7F2F46A9B83A910354E259AF0A66F5E769300AC727
      7AF5DDAA21FADD8A215E003E866339832A54F01030BB67F05328F238808B422E
      A337A862196AEF3DC7100CF4BEF7DDCAE7E4C66F3C576C7ABF525051BB5E7ED4
      D8F17E2583535B5E7E546F77BF5DF9A0DCEFF283E5BDEE77AA9FDE05A4CD8DEE
      772B9F973B5D7EDEDCE57EAF7AC9AD5DEFDEDCE26E25E39224C35104CFF95964
      39BCE12E848F16D81B7C9E8098A28FC2A27E25D72EA847F9B9752A1FFC3CE128
      3D58E050BF92C51554A3F428E1102DB3EF7EFEC0961E35F6B15F49B88BD35A7A
      766B1FFBFEA082A9984066F6AEE0DB72AB1E31E02B1FD107B4DFAA12324CE0F2
      53065C5B55D2A209577E4A1DCBBE214F6F3CA3A9B07AA67422FBAD4EE5839BB0
      D8388CFD56156F3637911F35F7AF524E37F74FBE716BEBFAB7A2B22C7BEBCD1B
      DC8AC4AA878AED1BDC8ABECAE78C0D1CDC8AB8CAE7F4160E6E45DBE453264007
      B7226CF2C13248A53AD1FFFC81502A8802AAD71D7CFE48140F4972034F7DFE48
      E8A70A90C2739F3F14FAB982D0C0739F3F18FAB9D2C980473F7F348A47F5D9E0
      473F7F34F4A3C656C2839F3F1CC53BB7B7D2777B9FE351FF6B93496D6B80FD2F
      15624BA35472B25BC8B3E6405EA5BA780BD1B6345035ABFB9C945B1AA692EDDD
      42E0DD5E5DB5F8FC79E97773AC4A49FA36627069A44AFE7C4B89784BE9F73F63
      56B897ECB4A1DBFBFD5BF37752DF15FA96C6A824895B0C5F8EA191D71CA6E5DD
      5A02E0610AD42D0D534D353745021E46216E69904A12BA2523F0201B685B1AAB
      9AACEE067109694B235552D92D2982473250B6344E25C9DD122BE48CB611D634
      E0B4BE980A9646F9422AB8314CFB8B69E0D6BADA5F4E054BC3DC870A6E8E751F
      1AB8BDC07B51C1D248F7A5821B36BBF697A194E219C5385F8E54E6309D7B32D6
      62A02F44A9AD8575EE8954A5B1EECF588BB1BE1CA5B6D7F80048659A692BED86
      0FC7588B77DD9EB16AC42D3D7F7BA6AA10D67CBC777B665A62A3C500B767A305
      829606B83D0B2D2166698CDBB3CE4DA6598C717BA65942C4D218B767985B0868
      1AD27BF76194C528F75117CC81FAF7A16AA581EEC5288B61EEAD2E9446BB2755
      2B8D755F46598C745F9A460B1D275192E6A3E8AFC3544CDCE10C76257687A368
      25DCED4B7EA7635E84AF375DE601F0DB8E21362E6FDC5B3144C50B7908CFEF9B
      17E1EB4D97DDBF1ED5F0327EDF31C8C665B77CB11864E7653DC8C0973FC007FA
      61E0DF0ACE2E6EF6BF63A4C678BE4452E1FB430CF41806D23D87611EFA0B4684
      C82F1D473DB80C960EACF01F91338C427798C27F59E001DFCA22BF33807F17AB
      28F78657E1649C47CB201D5EA5C1129E0BE0F230C89641B49C07F8215E2D8073
      05AB3C190693DF56599EA2200F03C25C23FC27CC83A5EBFC318C937F00D6258B
      2417CEEFC32C5F47229B0B91FFFEE74D6298E611C0623ACE3C5C7C205D8E0101
      3050D13630993CE5DB5C055C150063C4BE10C03F07EFE1789686137A2C5E1A23
      C44B1CC31966B1B8CEE12DD93FA649BA0880FF67CB344CD2305FBBCE0F780923
      4C60AE995706D3C8730958F8EF0817EEC137FE7B277025AB1C002422712922F7
      D6C01B062358A18B9003F9B90272A321FDBA0B761720F2800004EAE1CDF0C185
      8F824C4C92D895C082976730AB0BAFB3136A0307512BCD423876709C066DCF99
      8B00C36B1C0F4F4DE63F3E1CBD2F8123C0A28023AC7B1392F0FB2E487E0EBF36
      A0E72BE875EF0A3D5FE261EBF1E1E77F09FCFCDE4D7808BFDE1D7A3BB0AFA5E0
      D7BB2BFC5A4CB361D63056309984797829E0F64C2CC27938998818BEAC62F828
      56F04A6350CF79C9B0737E0CD26006B09C3BAF9338A701618E79E679F04F9A5C
      4D86793ACDB39FC3493E7FD1822F4B7851E4B97DF9312D3E4E23F5FB34D79F46
      FA538A9FC6A36500E4173E4CF9C308960E9C88FFE6EBA580BBB24B91E62081C0
      A7513A49D5DF48FE1DC9BFA9FC3B9945FA93BA36977F2F9DCFB10258EDA33083
      BD61059E77034A1CD59823381F835124343E754C7CAA22D25B47C265EAAC2971
      412B104119C9F16F32BE2861E30E14FF5E1158E70C244C3DAFEEE7E785AFDD31
      2FB86C9C3D3D1FFF8EF3F1CBF3E97D7E3E7E6FE77CF0F2D66C5A779C4D4BCD86
      B879FF71C8E81D109E17DCBE01D9DB0F4333BD7E49AAD902D0224B6225E9F04E
      0D2A776AEA9667B98A86E3A9BFB13BD52475736B8084A5B897EACDBE7BB7377B
      FE16A2DEFAE5AF93284AAEC4A43489CC7F2439EFC11003D6FB85A8B12D8CDC44
      ECB6E025695FFD67313AD1FBE557EF974FCBD8D8350C23A78B5FB66747B5EF3F
      BE7BEB9C25134D7EFD56E514C26DAC0937DEBC2D42F83B4EC8AB056C6816668C
      21ED1286682C4049E07AE075E15F0F835CF26BBF07043EBF6E75BB6DF8D3EEF4
      81755F77DA03BCA5DBF6F0965E0BA3F8AFFB7EBBCD4FE32D806C3D1AC61D0CF0
      26CF1BA0DC700D7AAB8FB779AD5E9BEE6B773BDD07463EB96B37201FEFE083E0
      5F5B3196CE9DA806A2C08FA9E0ADCBC544A3423527BE191B7732BBB6C95F4A93
      FBDC7C4A6CCFAF66C39BC8599AC30D047B199D1614B39AAB6E0CBFB9C89B5F30
      D62FE8DFCCB63718F6E7CF97BFFDBEF33C4DE2D95FFFA057466196E72860FD4E
      1FF9BB582CA32017E1E4D46BC191F17A9D96CFBF93C632A47FE3E9D86FE98FB1
      FAFCDBD8457D8E3F22F2E3A729517FF925CB0390A141C2E66FCB602CE42F2067
      8B38777FE76F3920EDF089EB0D57A7AD81D772FE0B81C4EF5B2D462205024169
      2D193BF603C2B1F0B4D5C513D7838BBF8DE5EAF0E8FB740EE10F1A856EBD945B
      2EE412261BC347D835B5F8CFAF2BD9B51EBF623D5EBB5D5E105D8091F1EF232F
      E9360B8265ABADF207BBB7CA732BD6E6232136D74617E025F8770FD6F6999521
      99AE5E5BBFBFB136BC806B83BFFBBFB61B5606FFE24937D78697706DF8F79B5E
      5BBBB5413EE802BC02FF3AE42AF866D7861924A5B5D1057805FEBDCDAE15E47D
      FFD6D6DBA0247401D7D67B184AA2A9FB9FBFB66E7B8392D0057805FE556B4377
      9603C3E0E770D21AB4FD4EA7FDC76EDEDEEA0C3CAFDB1958D66E59BB65ED96B5
      5BD66E59BB65EDDF086BEFF7BC6ECFF7BBBB79BB872914DDBE3FE85BDE6E79BB
      E5ED96B75BDE6E79FBFEAECDF27693B77BFD76ABE7837A5EC1DC3B9D56AFDD1E
      74DB8FB1E9FF22CC1D17FE057BFCED33772272F747DB7D67EEF7125CBE6DE67E
      A3E042BCFC5F96B96F082E65F6FE0DAFED33CCFDDB165CEECBDCF75870F902E6
      EEFBED56ABEB555AE5BD6EB7DDEEF43A83F663ECFAB7C4DDD5BEDF6B29DF2443
      572B7F4854B50C7D6F89A765E896A17F4B6BB30CBDC4D05B3DB733E8BB950CDD
      EBF65CB7D5E9F996A13FF4267F33DCFDF6EE05CBDD2D77B7DC7DBFD766B9FBC1
      70F796DFE9F82DD7EDEFE6EEBD7ED7EDFB7ECFF4B32B0058DE6E79BBE5ED96B7
      5BDEFE2DADCDF2F6C3E1ED2DCF6DB5FD56ABC2CFDE75FD56BFDFF2FA5671B7CC
      DD3277CBDC2D73B7CC7D7FD766997B89B9B7FD9EDBEBB81511F2A7BED7EEF4BC
      6EB76BB9BBE5EE96BB5BEE6EB9BBE5EE7BBC36CBDD4DEEDE765DBFE37ABD0AD5
      FDD46B0FFCAEE7773B5DCBDD2D77B7DCDD7277CBDD2D77DFDFB559EE6E72F74E
      6BE0B6FBAD8E57C5DD3B7D6C6FDE71ADEE6EB9BBE5EE96BB5BEE6EB9FB1EAFCD
      72F71277EFBB5EBBD5E95504CC7B2DAFD5F1019F6DBCBC65EE96B95BE66E99BB
      65EE7BBC36CBDC4BCC7DE0FBA0997B15F1F29EDBE9786DDF755DCBDC2D73B7CC
      DD3277CBDC2D73DFDFB559E66E32F76ECFED747B7EBBC22EDFF37B98ECDE350B
      CADB6438CBDB2D6FB7BCDDF2F66F716D96B71F0C6FEFB93DDF1B74AA787BABEB
      F5065EAF6D59BB65ED96B55BD66E59BB65EDFBBB36CBDA4BACDD6B61EBD7AE5F
      6193EFB7BD76ABDD1D589BBC65EE96B95BE66E99BB65EE7BBC36CBDC4B8DE0FC
      7EAF3FE875AAF2DCBDBEDBF5DADD76D77277CBDD2D77B7DCDD7277CBDDF7786D
      96BB97B87BBBDBE90CBADD4E85C7BDE5757B03DFB76679CBDB2D6FB7BCDDF276
      CBDBF7786D96B797787BB7EFFBF073459BD78EE7B507BD7EC746D359DE6E79BB
      E5ED96B75BDEBEC76BB3BCDDE4ED03BFE7F7DC5655DB9853DFF53ABEE7F7DAB6
      3E9DEDF26A19BA65E896A17F836BB30CFD70187ACFF55AFDBE57111EEFB5BB7E
      A7EDDB5E31565BB7DABA65EE96B95BE6BED76BB3CCDD64EE9E8BA5E4DB5E6584
      BCD71D74DD76A7654BD259EE6EB9BBE5EE96BB5BEEBEC76BB3DCBDCCDD7DB735
      E877BA95ADE05C60ACDDBE6FCBC95BF66ED9BB65EF96BD5BF6BECF6BB3ECBDCC
      DE3BFEA0E7BA6E458CFC69A7ED757A9EDBB3DCDD7277CBDD2D77B7DCDD72F73D
      5E9BE5EE65EEDE73DB7ED76B5539DE5DB8C1EF763B96BB5BEE6EB9BBE5EE96BB
      5BEEBEC76BB3DCBDCCDD07AD56D71BF815BDE07CB7D769BBF0B3E5EE96BB5BEE
      6EB9BBE5EE96BBEFF1DA2C772F7177CFEDF77DD7732B1CEFDDB6DBF3FC56BF82
      B9BB0564DCBB82E55690F0E13FB7B9090504112C21CDA3F17C381D679E330CA6
      0089284FF9C27DF8FCCE3515BBFEE09B8D4BF4EEB7C42F60FD77D939CDDDEFB9
      4AFF7EABFC0221E03EF8F925E20DAEB275CF55DE5D1C78A05556AE91CEFEC62A
      DBF75BE51708068FBDCA4D710E57D9B9DF2A4922B89B88F027AE52AEB1BBB546
      96666FBDCACF880BFBB1CADE6D7712CFFACE55DE5D70F8F357D9BF1FBEA29CB0
      21D4DE4684F07A3D50FF5DB7C2B9EF75BABD7E7BE0F6BADF807D00D59947B310
      3CB498F890F6816F5AAABFB77D608FA5FA47B70F3C8478F7856BFB9AF681C7B6
      597D01F3FF666C565FC0F2F78992DC68B3BAB785606F29C997B2F701FCDAEE54
      D8FF4FBD5EDFC7C4FA8E65EF96BD5BF66ED9BB65EFFB40402C7BB7ECFD56ECBD
      D3F73A9D6EB7A2C4ADD7EFF5BD56CBF75DCBDD2D77B7DCDD7277CBDDF7808058
      EE6EB9FBADB87BB7DD1AF45B7E55915BCF75DD41AFD3EF5BEE7EEFA53C52B4DE
      833514F87618BA5ED923865DEC2B432FAF0C0170100CDD5CD963545DB60C7D6F
      999E65E87761E83DAFD3C2963495D6F86EC7EF0E3AFDB6E5E80FBBCB565FB7FA
      BAD5D7ADBE6ED9BB65EF8FC7DEFB835617BBC55758E3FD41B7DFEDB8D6D56E99
      BB65EE96B95BE6BE0F04C43277CBDC6FC3DCFD4EA7D56DF5FDAA22B79ED719F8
      7D6F30F02D7BBFF752AC35DE5AE3AD35DE5AE32D47B71CFD11397AAF3518F4BA
      15756D5BDD5EBBD5E90EACBAFEC07B6CD575ABAE5B75DDAAEB96B95BE6FE88CC
      7DD08595772AD475AF3BE8F8FD6EBF6523E32D77B7DCDD7277CBDDF7818058EE
      6EB9FBADB87BBFDDEEB6FCAA7EB2A0D5F77A9D56C73277CBDC2D73B7CCDD32F7
      7D202096B95BE67E2BE63EF0B15BFCA082B99F62491BAFDF73BBD6326FD9BB65
      EF96BD5BF6BE0F04C4B277CBDE6FC3DE5B9DDEC0EF0CDC2AF6DEF75B5DD0EE7D
      9BD56EB9BBE5EE96BB5BEEBE0F04C47277CBDD6FC3DDDB3EFCCFF306AD0ABF7B
      0F78BBD769D99A3596BB5BEE6EB9BBE5EE7B41402C77B7DCFD56DCBDEB0D06A0
      BA5714B0F1DD8ED7E961DD3ACBDD2D77B7DCDD7277CBDDF7808058EE6EB9FB6D
      B87BA7D5E9F55AAD41452F38AFD76B0360DAAECD70B7DCDD7277CBDD2D77DF07
      0262B9BBE5EEB7E2EE5DAFDD1B74BCAA4EAF6DAFEBC37F036B99B7DCDD7277CB
      DD2D77DF070262B9BBE5EEB7E1EEDD7EB7E7B903BFA2D16BB7DB1EF47BBE6F0D
      F396B95BE66E99BB65EEFB40402C73B7CCFD36CCBDE7B6DCFEC0EB5604D59D7A
      9D4EBBD7F5DD8E65EF96BD5BF66ED9BB65EFFB40402C7BB7ECFD76ECBDEBF5FA
      FD5655465C77E0F6FD81DBB57E77CBDD2D77B7DCDD72F77D202096BB5BEE7E2B
      EEDEE9753CCFEF5658E64F7DCFEDF4BB8381AD5667D9BB65EF96BD5BF6BE1704
      C4B277CBDE6FC3DE416D6FF77AED5655C2FBC06DC1C3C0142D77B7DCDD7277CB
      DD2D77DF030262B9BBE5EEB7E2EE83C1A0D76955B5743FF5FC76BBDBE9F46CD0
      BCE5EE96BB5BEE6EB9FB3E1010CBDD2D77BF0D771FB86DAF070A7C554A5CA7E3
      F6DBBE678BD559EE6EB9BBE5EE96BBEF0501B1DCDD72F75B7077DFEDB85EBFD5
      F22AFBC8743BAD9EDF723D1B5767D9BB65EF96BD5BF6BE0F04C4B277CBDE6FC5
      DEBBADDEA0D3ED57D4A2F5DA5EABD5F5ACF26EB9BBE5EE96BB5BEE6EB9BBE5EE
      DF10771F74BD9EEB752AA2E6DB5DCFF5BC41CFAAEE96B95BE66E99BB65EEFB40
      402C73B7CCFD36CC1D78F7A0E3F53AFD3FE0F77FA7ABC9A548D37022608C48FC
      5EBAA4BCF55E7FD0EAF67BFD41E9D771B282C50CA3CCFB63E763FD9ED7EDF97E
      77F743FEEE878A52F8BB1F6B69DEB6F9A00E18DCFD60BBE27D9EDBEFFBAEE756
      4CB3B3FBB156DBEFB9BD4ED553DDDD4F0DFC9E4F1585763FD5DBFD5421912195
      DBF560BF626DEE000D3103BFBDFBB141C563BAD750C576BBBB9F6BBBAEDF71BD
      5EABE2B10A34E9C05EB7FBAD8E57F1985FB9E39ED7EBF980EB15A8E2B5AAB6BC
      0758E6C329A978AE1255BC013CD4EE5480D3ABC095220FB5E2B90A6C29AA5354
      EDBB57813145D9AA8AE72A10A68F11B5836EB753F15805C20C00395BFDBE57B1
      837E05BE1495332B9EF32A77DE4534C3B2D9154F561097D6A0ED77AAB6CFAF40
      97CEC0F75D40CF0A6CF1ABB0458738553C57812D7D1F096DAFD3ADDA74BF025D
      0AB36CC57355C8022069755BFD4A425D812C9DBEEBB581585781B38ABAB81D1F
      10C6752B90ACE556EEBAEE705AF164058129EAAF573C57812DFD6EDF472A51C1
      505A55E4C5057419F43BDD0A78B62A10A6E0CD553BDFAA6246B0837ECBAD622B
      AD2AFAD26FA317BE53B5BE0A7CE9F6DC0EF0F576C5696F553123AFDB06B0B4AA
      B84A6B50B5EF4538410567AFA02F7E0B663AE8BB1508DAAE42179D5758F15C95
      E4E2777A2D1041AAA867BB921D75FA5E07D06550B5EFED2A12E30F7CA483832A
      C05431241F883CC8BF9D0A0C6D57218CDF6FB7BBC039ABDE574561DC9EDBF6BB
      5EAB0265DAFDCA230FF46500B375ABDE58416400595C10D1AAB6B05381313D98
      2248E255EBEB54608CEFB751CEAA622C9D0A840101D28713DFF6AAF6BDD36229
      3D1597F928727EFF145FC4C955FC57BEBA9C2DE92A7E1886F08F3B0CF3608944
      CE1DA6F05F3682FF025CAABAC3ABB883DF9285131C903E74F1BC757BF4B9E783
      34D8EAD367CF4700D1D1592C827CFE63CA7F5F2771DE6A0F17A3F4E245082A92
      FC70BE82372CB2451045AFD30094A8C524CC962FC5D41B2EA277413AA37B53FD
      6922A6FF7B8CF0585CA5C1F20DA94B64D95A8471FE365CC0873848D7F0096710
      C6D3E4F761B0CAE749EABC8AE09E2C17E9F34FF053B2146990C3E58FF01B5C8D
      9D57F12C1229FC344E05A8678BE13A05B1BF3F5C2420B74CD67E67384F3D7C0F
      EE1642FC865BF05CC166656112E33CC4045F8DC73B4EA6CB602618C1E0CB5592
      4E400EE5B69DF07D3C0FD2AC0767C137BE5F657DECDCC963C603D8743C0DFF3E
      BC5E44B020DA62FAE839F33C5F3E7BFA341BCFC522C89A8B709C265932CD9BE3
      64F134994EC3B1788AAF7CEABB6E8B3E2DA23FFE182E0380C615304E5057E8F3
      1C442FD8D005803D62F0C2A7547FCAF5A7117D9AAD72802BA04D9E66629CA359
      F52A9C2457E33C8D86D33C1EFD360C443C9924E3610EBB7CB1004CCE5CFE3C4D
      52C08F3C8C6700C2244E7201AAED245B6753C0180F001DAD93F87211B9C6AFA0
      C2CE26411EC09BD3298C0A2A719CC380974114C27501D0F086D93CB95A46A05B
      CF936882AA34A0FF2C4E52B108AFC5640CA3A3AA0DE87D29C2989EBCC6B7E063
      F0014E1AE085077B701DC1F492B5886155E27A99CDD33C86CB2B582CE8EEE3E1
      24862D88B3D164045749998725AD60DDB0B06C1EC069060CFB27AE7D325B101E
      C38739DDE8813A3E995D1A9FE1D670C6465AFCA5F46D8E53F3E801FC80BA3DCC
      278827C3CB505C5D84F1C4A34FD93888048CB69C8DD2493A17C1447E9C26493E
      CC96D13ABF8AC358E0CEE8CFF37C01E7245BC21AA2789E0793DF6055C35526A2
      7C1444F110FE830BF08E213C022F18C3B72BFA021FD27C960EA3188E342C5CC0
      10F0E92A45EA33CCE260992733205B613C1651040345C9D53414111CDD090C3F
      841B97AB788C16AA200B033D0A52931466AC28CA301657306296AFE1E70C5E32
      4B932B9873320D739C688CF0CED70076A495F03B4C3606329367C3A9C0C98948
      5CC2E5F175B62453069087096CE1155E17B8A5C1740CE709671D4CE9E615A065
      349CD31D08B81C486490C29DF9F8322058E5305B7C689A2240F0C265905F8FAE
      871769BC4CB358E4C37100A711F02D02383A8838211CC665903B30ADDCE5937C
      05783C5DE4D3308273E4F86D200F78FA810EAD5291CFD324CF2301C4399A268B
      601CE4E3285E2D3B2D3C7030216788A76EE2A8F307E43B16D7EE10B75EA4EB1E
      C87DB8F5F223CC24BBC60F00FF782E52414FE323B84B683BA2D1C43400141FC3
      0ED2017688A3C4F0537409876B19AFC6E9022FA0610BBFB3E90A9D26CB781EC4
      33E43B717E9D074E53B223F9302AABF8384CF68B9E6FC127E0815FF46C1B3E45
      B77FF349F9E9CEEDDF3C72EA7F540DD32500DC7A1A370DD5A3816EB711378DD3
      7FA8090D6E3321C4F99D2301F34981584541183B12B787FF8043538823A0D803
      C5A67F4778F681CC07FC17180E60313E819281445FA028CB205ACE03FC10AF16
      C329DD3D4C5684F0644B758740EC56590EA4769EC36B6232912A5909060C4CB9
      06A49F3C1ACF87D331B05BA0132DAFE3F6E06FE6FB40DA6075A0DD7568F27C13
      FB18F157FCB1E5F63DFA30151E99CF12B88B07E90EE7A1F16532D25F3AC3319E
      4C7A2E5E1A43C44B1C04B6A534A5113CE6E28CDAFDD23C86A3E1D4F3D1FFD9EE
      0F0136F3E1054813C0495B5DA08499B9C8218A1DA555FF3C0FF227990324D881
      BDB97E350973A7D56C35BBCE8B571F9FFF176234D021DEC03F6FEBBCBB6D5D15
      A05ADD0A40016408509F05CF51ED23721427993A672C58640E302205B61FC4D5
      9F08A1FBC08401E2B7CB0091E0F0DBB782C45C381FDF9F3923100A9318D12587
      2B79B2742231CD9D7192C6C0E3005278B90090F31AF8B7530FA22C71AEE6208F
      83C4742126EA79E34600F589330E6267241CE0FB1318DB4189C80180CF413D72
      02676B379A0AFE9BEBF569BDEEC67ADB324CE0B3CB7D99ACF04D675138BED81A
      FBBEB0C405DD6AC248626E3DE5570091F4E1E72AF70977FE2A8C222703D503FE
      E03590F240A2808D6281046E851D434955EDCACFA058CE154AE00861E63016D3
      3E5E85F06BE0800016A29EA19E3ACF41D477EA976116D26EA70E885F270E08C4
      F0C4F68028E84FE8D754802E9DC217C233BC85700F7108DE3B03EED33C7482F6
      521CD5603EA8253B0B9165A0B33AAB25EA5693C3A264D9528C4310DC27F04F32
      7382290AE888320A2A391026E72AC81C713D8E56597889B48EEE88822C27F6E8
      CCE1E791005C03E51354DF89422F7C811C3806FA85B705CEF1CB247E92334523
      64244E1200B2869138764099185F8C92EB2690441891BE8A4983DE28C7A2F307
      670109240E13CB7156711E46301270715884B44FE029617E2E8FD9186534381C
      6A817AF2683D01ED0D5F0613F2DACE245867F033AC18F4D030156A59709A9C1F
      833C4DE28CE7A5E68CC7707B793C2DF9DA633AA1341B5844020AAA79AB3EB0E6
      E4E4932650D5CF348886C204E608C8B72E8679BFCC110474FC616EE328C9248D
      C05F8FDF3C5900407829B866987A92165B508046C10C757E588FDC144404F9D1
      9C1CDA22E851C0065814DC874FC801D264B1813CA8B7069906EE8FF4CD59A6C9
      25F2BAA910935130BE0050D173BC952FC30CF8AC669EFFA6EFC2F700AD71C2A9
      B34E56F063185FC07AD74C2B914ACE9355344198A9298DD09E21681C39157CD7
      0FE27A95BD4B26D9C193CAA3DAF7AB9900AC0A17B8290031209A64D58AC782CE
      EEF1195A140510D52827741ACF8F0F858A7E0C1747350124474CF87C386C5E05
      3530702604902502847E421CEB76DC772F9C7332E9ADCFC3EBA6C81626019DAC
      C6EA9CA03DDCC1D0B14518AF72913975CF75007FD3EC048F5E30027C713AEA57
      8BA8B517ABD934BC16D9A1201FB3700EC4428C4BC5324951100DB36C2524EF22
      BC42B04C9E49B8B03386A2AF0A8384B6B56D4C716372B795C2B5EAAF347D97F5
      FF69CB193E19F58620F9FEB1637F4AD1CAB7DEA88D30307CF6165B1765BB5117
      1FFF9336B0AE772C41F64D4CEDC43995FA65184D705727096C258A3B57494A7C
      F06798E39E6D65D54248A843367DFC1AD8F6F32802E92289568B58AA308B6422
      1A280E85BCC46592B1B603F40D18CC0AE431603C31D254E0CB4735A4A05AF9E1
      91B26F0414DFBFF9F8EE15D07014C6DEBC747E4C051C4AB83A9B0B949B40DF7F
      17A0FB0E15D8341440E3016CDF7DF8F423C84A231165641200F984C42EE0C400
      A5C5B7B2F633F408809075AE34658DD3611CE621EDF22A63210C9E4131169E21
      3CF959E3C937B2D617E801824BDF87718ED7617EA0469C052C8AA3900FD2F6CC
      41F7DF53C06060E72CAF836E0597C7408E58445E886F65777F0AD2305965CC75
      58CDBA7EB95A2C795DE92A462B2C3E13001F8AA44A290F3CEEF80C43741784FC
      DFC88AB364C17A0E28B480D66390C392E914379735AE8C552E5A7F809AE81AA9
      16E8696B58E482F69E4C3622DFB7054F93156887A335C8AED23E42E717ED7FB8
      89A454FE7DC3F6096AD22A52875BEB9BFA8807D1159E80912071840C66B8E120
      F22E53D06343F2983CB4E1F271AC80DFC66E5D8DDE4FA7805B2F833C002A9A9D
      613C0D30166420E300E96C8AAA2FEBEEA4982C6807333EBB2434C190F0F4B7B1
      DE55CCB6CF3C5CA0AC014BBD0C228795FD2B456FC910C3F7CD9132039AF26904
      C69AC4D370B64AA502E7F9731E4A12EFA3DAB70106D03645AE0E29D957EA7FC3
      CF40A09048C58993E037102C60BB6769B25A1696B48908E0E85EA2160F3F3AF4
      EB9FA946EDA942F9894CC2F2A09856A1C3D13095ED141005A7B308F2704CF29A
      B402914555D1912DDBEB36C83EA2154E7AB7F2558AE64110E589F0904D92CDA7
      C590FA79699F3F761262B1CADCF166EAC060FC1BF9552E833042B74A03663392
      B2189DF8B2B1144E90B474176F906C0D49033AF78D57301470F8D841D30D1A5D
      92629D75D19C359D76D36D5E37E08F8F7F9ACDE6094B00FC240D29490CBE761A
      A6704489D0D495D93D54D6DE13BC452F8BA02165A8EFC2FCFBD508072C446720
      54B8E2895387156C0257B369299A9C584351ED63B8CC0ED3DF432B974E931CD5
      C8591A2C18370D7391040D797A820BC11ECD604C81B912433390D827A4A7D3D9
      301D00F40E603711F05D40EB54FC63154A0B3BF04E91C6C09D4911C007F1E666
      7E9D935782F9D4159C5B768D4B4F93B81616696B1F04F93C60F274F293BDB37C
      7C757B9EFFB5ED793F497E8061196912396FE269C29AEE958371EDCA4700549B
      B4DE8CB05E3AE633E78FDF61E50FAA06ADE17FA78BC5E964E27CCA44FACCB976
      30A8FCFA99B37E84108929C992EED73AAB778C74BB655C192CE63122CB3A36B2
      8CC9DA4B61033130B6610B0CDA2928E1A1592C9094F832CC0DE738BB0201B358
      B8048A83C8D5D071061B811224C1C2690D39B263998A4B34E0C958841899FA3A
      5999E10E9BC422AC5A77789795EB991A9EF7E8E109D3518D82011424820C850B
      12B9AF00B33209892232C004558CC10C24A423A5C66150469925A46727C5706C
      93A790050C37180377CED315EAD4C636E1E30B443216B5D4AE3D211304475502
      ACD12AC625145817D90A7BB0B290F5F45A4FEF9D24C3D6D7960C8F6A55BE0452
      A7704FA56330993A01EC2FCBFACA864E3162B18C22869B64A81B990DB2E092C2
      4D64E4276872F075CF10A06AF1BFBC7EDFFED579FDC3F377E4ED7CFBFE058ACB
      64B1DDB315546FE06598E62B50698F7F4ED26842C96EC70E50CC85603333968E
      4B00BDD6ACFD8618232422E9D0A58D95F9790EFCBB12725777A0C5CF1FDEBE94
      98B167C0A902CDCF8563F32C59AE51C739AAA9345FA74E563FFC7A958688B427
      0DE7F887047929450A94031F50B4E1C567CE340A6618BB07E391D55B7C2B0079
      4E7B6B40846C1C753CBB3AF481ACF44E160252B1C18E24809F4238FD30B4B308
      D64E1D0E4B4A9E47109AE00610434651105FEC9FABA2020EAF610361EF92627B
      61459FE23D346A547944459AA37C08E737CDC72B90DC68151CEF420E98847301
      D0F04BC67396055568EE5ACA9BF1936FC405FC0170345938CF7F2A731D5A0FC6
      15173CE780C5D27311C000C48AFFBF04A0050872882952CF9D8C0121506B4168
      FC13A141F9F023004121AD06938934339773A090DA1599300F1D1CF0FCED47E7
      2FCEF9D74B68BAC35C8F6A671F3FBC85E9BE7EF8E94E93F12A93294C7ABF14D0
      0981A52F69CCF64C743111CF7EE845CA25BA0DE72F947C71FAE06B7D2C547ADD
      7AF86D29B24090C3503A4598F166C1065C08812E1CDA30A4C03AA562BC4A5314
      39E16F866604A0C9A6A3F4DB88B029166F9290BB2C5FAD1BCD3A729CA31A8E74
      435E0A211DA94E99F6CFB24FAC18A434C4464ECE21B33CA4E580A6DF078BD12A
      457FDF3B11AF0E85D71DE3F28F6AC7CAC9A3A30F94D3BD0C168B2FB5E373D478
      3FC9502C0C923D466B1616B2292CD1CEF173588283C055F11E8782514735529A
      778189A243849935AEA24DEB40EE4860A775C9E011265D32FA0B8DD22AFE4D39
      F09388436080C77B4592D146D44C884E0824B49B613365CC6E3854D34B469FA9
      37A1979F7D9CB81A8C0760DDC78834E03BD5C128059A16513B6425A18133B4B4
      E02332EB3A24BD12D342770EF1CB7FFFAA60C5517FA091619124FC5DBA4BBC0E
      0C05020E461891552DA4B0ED60B9049A9F51FC0C4AA5144948738993E49F423F
      EDDAFCAB4252CDD308C438DA01041CD92CBEE7A478609AFF1B63C23F26DFCA49
      BEAF4C6B00A32C266125A807D035E2B25D48C25986E5313B9210E77B835CDACF
      2CA6D664A23A10B174426119CD49907F2B88797F16F34A856195D6AFC835070B
      97A3B7264DCEE60FF240C93A58E62B8C2AE2B4DE10E730D3B9B4D93757E3A056
      C982B824D1F03CB2311406388176F8FB77C142FC00FF0DFF6816737D2F87A249
      8F44A646B571622C3F68334A798B003C8782E214656C006202DA23F96310778F
      6A55D84BA24A81FB64C3358A16E8E8C52B18398BC55533CDA736D8E9F3C14E6D
      1BEC64E3166CDCC2DDE316DA5F3B6EE1DF3A83B673EA1CBF4DC6411482DEB38C
      56B3303E76A658D394CC6CA020A6C98588F76CEFAA7337294042269CB2179EB5
      DAB1F4E98DC314B84596638113B41666B04548CF303379C569BCC954FAE5F7CE
      5D59B1EA6082B5049E92DC8B1F76412112781A39C9FEA6A0864C072CD4B58B5E
      C206DD9CF818CA7727FB069ADD8ECDB7413C5B61BC65615090B9C9C1158AC2B0
      D54D3C80F12C930232A0427394054F9BA3C077C80E7DB97FB9DABB17FBE9E3EB
      BE236210A3C9769EA08CC3077BE2A845622D1B34034D8328A2B0C585408B5198
      2DD0A4A4EE622D2177181170DCFD0B3ED80D83544C8BE21AAB0C3359B000D402
      8E46BA6673582CC618849BAEF76C4547B58A35493705E7F11A984C197A48AF96
      8292F0E754C82DA02A61490C126D9CC39A6549B2C2BED89001B157982585A61B
      5DF36BCF0052058E18037043389439207BC867968B4B4451B0C46085A75C5B9C
      0C85EBA5B4521A04CE612A288D2BF570B1E4DF382C176F9E886C9C86CC0F46F0
      EE2B15A8BD6F84EFDFB086D4A9F38138032BD6F12A8AA47C1E2C973A8F91FBAE
      5931FD355AC057B9D3EB3AD96A89603B1C81FD3BAC5FC6998140038B2C044CF7
      6B62609E8EC223E11DC39EA84A51919686D6A126A0DB54A4026BC46962ABC712
      31E7AB1684070D4AA6B568BAC2C45654C0376BA5718D02FA9906467ABEF922BC
      07F78FBB1CE84486AD5DC537CF442C524AA385854FD62A186599A0BF80ACA641
      BC465A592408047292584A01A69FA3C120B9C084CA1D73C5372E56E33907F622
      279565F368722ADB8322FFC76990CD0B4FC20B78320B6771380D413C83792C28
      FF12D3A531D68CDDD819432BA5A041AC2914AB5A869BD9820C6DAC551E4ED732
      BE205E93B27E2C3BAB1C73086AC6EBDE08D3B1A6B59AB4A92D1092383F07DFBE
      1028411F0A81F878950020E26A406CA2CD97E8F4BB5D2FFF529A7DE7BE9AFD3D
      DD53A7380FA4AFB70AE1A11EB3B7F74D9D3A3FABCA22DA75BB552548951C0614
      424030B1C7CC58558D86892F3AAF39761613D0D389CCBC623B04A58E37D1DB40
      85D5B30B4C3D976FFB8E4A9C14EFA304F352090B7C6346AF642D463DF425CADC
      9F80B28F810198850C78F7281ECA53E70D48CD287D3FCAD46F8DBC77937F9A8C
      BB654CD1D571D01FF5168B0A8386504838589E0ED93F3909E289AACCFE02B467
      2CA50357DE5238F8C1B3D0638A1A39AA61DCC8F141458A6154F4713966E65815
      9CD17271291CBAA2A50405855E85F104856CF273A9B235A0E3A3DD06B4D4154B
      C975191319AD3987A4B0C30BAE3169EDED1B5CB9FBB5EDEDD2CE1E18216FFBB2
      399AF4D5C3A94A52DE3753870C883B1CA2F28E4D9770E243AA65A765A655AC8C
      9821F0AFFADF649937A0111359498A72CEAF73AA333B09A7C4CB727595C6CC28
      D96C26E01B45CB10610282C3EF6313D974853DDC0E9EB19D8104B03CAAA11F41
      07BA709ADF4BC34C08307B8D09621CAB753858FA914CAF0021840F05D8A7419C
      4501F7BF512E857A2684B4A4E23D85E982DB215161280DDE8988CD58A15C359E
      786851F33FC6CB67D7F0BFFF7C0C3D09EBC85E518CAE3C4DA64D39316DFACD07
      5F182EEA314A6DC894A1879EEE2A9FF61F25610B6D60ACFE690C653378C3A1AA
      7E0FDFA1CAF3A923F2032738E9E9CB32AE115A6FC99BD506F23E0B73A0DBA866
      A3D112CB88E3A971B3475B249E1B77D0726F776EBE2895EB50790DE6995247E1
      324D8D94231BD392F906F6581F0E9FD98E3A054048C79F8414259171AD520DB0
      3A9A33E192622DAA7B0B2DD5E85904222EF3A713643D4098C3E95A319F12C481
      95710DA1CC39FE445240E9E767C78ADE6BEB3F5AC254DDD113A398624A454DB5
      1E87C1899FDE68F7852AF7D4401D70C734242D46CD90A36C036692985447A46F
      02571E9A52FF325E2A11E8D747619AD29E2717C73A3317B10EA7A14083F48520
      B03CFB3CE617D89D5F0FBC2EFCEBF55B3EFCF17BED3EFC6975BB6DF8D3EEF45D
      F8D3690FF0966EDBC35B7A2D1F6FE9FBED363F8DB7C011EAD130EE60803761D7
      71BCCBF3E13EFCDBEAB5E9BE76B7D37DDC234556BC07DC4C094D11CFE024CCFF
      861C595EBAC08EE549FCB72EFCEF50A88DEE9E4738C7A55B88C192F0F3D0851C
      1F4FFCD9147EEA57A8553F824480C8F1084527B3F849DE28DA14922B01AB345F
      0718B261D25263BBF46AB9B03528BF63F2F3923E41553AD0ED50DC1662A19934
      BC54D1E08A755859A4B6D9DBE550CE3F6BB55B9D6D4CFB890CAF42C59583A990
      43B37241FD8B3457D71D64556845F0F03E93AD99D6AF4F1E813DDBE2AFC65BAA
      F2215A361F420AECAAA7A496C50F2CDE4A7AC539B058979E601880E2369165A2
      A9A133FE16A6DA5C56042E3DFFE1FC0DE68063F65C2E300514E38CD2008E797A
      A2EE97CE2299CF272DC566C3AD42025804CB252A2D23915FC9F6AF3C58A67AC7
      C234E8551C2E7482FC1115AB26B635E30C7E19529815FD77E7C1845B2145E122
      4402646A31C1782C7B012D0C881CD5789A93100B65E91661D43F8816ADE71CC8
      3A36DC60A9FC9B34A451A4B3BC4351299E5991F195619CE79AA382ABC663650B
      7636C7666C74AB142CC63AB49AF7522714444186B7253A7CBAB9677E93AFEE78
      EB7D6DC7DB777C9AF4E93A458931E3E20932288EF44AD2ABE3A31A1ECB8651B5
      19A3A13074B8C11D88304B30A6A3AB3D32B1C07EAEAA9DBB0A338C82751117B0
      2FE87054FBE9DDF39718040A4BCB43465D0C9396E021C5214D837581D21A60D4
      D35A5CA3AD0450FFFC629D860B221B5180CDEDF1AE35C143415A36AB571691E2
      F8AB8386B6182A2E4161EB85ABEA2A5873A50B5931713F8FD6DBAD040B13B5B6
      81A0934C1F5E0353792C8F50498CF897EC7727B730CC8AE4927DDB1410DE7779
      A06EDE990DF494275B1E61C565B8992115F946C729992045938AA8BF1F452130
      C7B8A123915B0D3A19F4F5A80617A8F69D9805DC58BE341378A7882698BEB18C
      C27188476111A4175C0535C300E3D0AC15BE1DFFCB93300E24F56A6AB04B97C2
      E7E08445AB09E542ACD5DE19F071EA0A26AC6DABCAF22500FD4BA2EFC946828D
      4A10A364B768BD8DE7FFF272EB516D936152F92B6EF568A0288A6C5A1043C797
      5327610AF3EE80A23B6F4E9AA59660867797DDE70F1E3A385E9E4AC9F9D97FA8
      993D8A73978D480FEF8FBED39CEF684B734448BC744738E8FE1A3037FCB6140E
      2C9335E2245DD00965E16B248AD4BE8D9A24A1161C36451F8A40DE426C49F580
      F662EE63B3F0D580324182C9E6E8943AA3343BA5D715E3A206C6245F13596A2F
      41199BE4A8019ACC824E61BCA4351609CAE574976DC18363A971FD707114649C
      25CCED22A5FA8D322B91F72719C6F4E78AAD2185A4DFE4F78746EB3BD1F63B1E
      44A2EE663713C903EB48C3CF5F9D343682234BC060A821379DC5084C1B32B9A1
      B9F5BFB6E626FD51C05290BFECD9F64C31407C4FE7B64C0AB8B97B36B7F13FC5
      784FA736C15CF83DDD5210F6F777723301CC38DED3B9A5425CF0D45A7B363520
      A351B8AF70FB2D5806314A2DA7B206C45ECD0EC4BF2B31DB5BE0A128B89AAD18
      7C7B383F60F9FB4B4DB22B31D9DBC9E5ABF4424FAEBD67934B5759A6CF84B767
      93C3AAEE053DF9EB9ECD6EBE8A6741AA81B76FA20988DAA370CC733B9840ACA3
      1AE974E7AFAC1E771F3D6EB0977ADCBF3CF622EE2A77401B7059FB03A8508945
      E9FBA0B4B73B28E84FC5E903436759F053958EC3288815D796D1B89B39A1367C
      B2EDB44EC4FBF5FBB67487BDEF75D50DE83F2013E8945375726AFA22AEC76299
      2B8AD15459A8ECF9BADA4EDF5781235BA12E3B2BE035B841B2EE44532456644E
      7615E6E3391A7E7327C57E010B95E7A7434C64F66E2912D08C422D27C291C997
      FD4FDB2E108AB1196341264E49A0F1C8F748293E3A16862CB33204E65BB3CC16
      B90BE83A8CA90ED983AFA188627F8C9437190BD4BC432ED51D26CFD6EAFFF34A
      22FBA32E85ABBC1386490F8A2CD20EC887581E092EF7A3D16F2232AC0EAF91BA
      1C5845C93679A20EB3CAA8812BC77239C74E1D3E1ED359D06CF00471B9387553
      72B69ABE171DC79DA8B27E4629A247F21B46CFFE434DA9DAF506ABFFE2FCBD9F
      A977249743E39E916622139330A03A4C81B62AEA475B654C1B263D24EF6C8EAD
      6809FC33518EFDD34FEB64A747C8084497D77F36C3387C1C077EA3987CA88BBA
      5E8835E156117B2123189D6CEB1E8A7AC0202576CE991EA31D3C42B5FA0C3313
      F69C97C709054C8F31FC22889CF13C09C7E43EBB437EC53E0447007D2BFA4270
      2B209D43578045D66C92D124AA6D207749FB525EB91DA1538E0035833F776C10
      B295DD4E4E0A8AE179519DC36021BBBDD5A5FBFB6EA7E061CFC0979310F48697
      422FBE1E1DFC72643BA1F3C6DEF1919862D83333C046B1F19488092769531B8A
      274612342205DC87DB3C4AB07AD8926A51359D33D559BB8413F93C4D56B3F9CD
      A8297BDFAA78E68CD186BA6246DB114F61B59014DE0528C0FD1E9E62F2D92CE7
      C66E9CEE5291863A1E27E4C34650D446C46549B8DD3D8A8A4490046216252312
      D00D99B78E705D629BF430E71F2AF8DB89414C1E214AE891A3831EA1552C8636
      11B4EF3AF5BB5678D859F8F15F28DEE921A49D3F33DEE91110E931EA01A25CAB
      E39F9034A089E00AED21D88C07A8ED288CE0CC371EEF603CC6410EA96DE514E8
      5711FE59A28448EB5481DEB27A8F4529295B47869582B482E5DCD6A6CAFF8DA9
      C29F314EF0421B9C4AC1C56E469A434F1F81263E72CCB056F91F3ADFFB651ACC
      927894A4F1636E9889AF5BC5019D5804A9AE44A8AA1171C10AAA5781A97BA87E
      8631B6199085F14789B4E69000A0C5315B8AE1DE28C18544941CF4CC916E5C09
      58FE75560ACAD6E968CF38F47A2BF6BAF4EC0E41AD3C80570C70061279048A46
      79048A9CDD7AB2DB715DCFA97FFAF8FAB47F722876706AE25B49CC3675BC7D21
      67A4E373D7BB46718875BF1864E054D746E67A0011B0E7FAFE25565CF799EBFE
      BA5D2DF899F38BB4FDCAA3DE3CFFF8E1CD0FDF9DFF2ACFDB6D4FE7619CB64D59
      E921F6E631992F1E270CDA275B6183BB4CAB4462CE5948F2C2A96B0FD8971FB0
      4298D25E948A93E4D4C9F4A7F6FCE490B997CE8443834CF00832EEA31E2E36F7
      91F729A4D3E5A82C47CE8C2C32162D177B302ED6DECDC50C6546648B5FB906AE
      6CAE5B3FFB70D6F29F3D1FBCEEB75EBC7EAD8ED85D86FB92237C97F1CFC93700
      DA8E2C5171285480623932E5C6A14619C995F63090613C4D22EA6B14451BFA1E
      FBD916C185CC477E82D6FC7980B5415238785C881A93F8B5AB856417596F6377
      E98EF7E7B6DC564DF698934E11A329FA9FDBC0FE9B2DBDE4DBD24B8C4887D68A
      FA8646D44735DB8AFAF3C194BB71F74FED45DD6F81768B4719FDFC54289D0B31
      148530E89B2A044B117C8B20E6220D196CF064EF9AD4C2A2B0C1F604E843CEDE
      4C2E1F856C91A21DC462894129586C2249B1483EE1ED09D58EC7908A8C9A3364
      4E7E9568CBED848D345CA10A78E8BE2579C0A23BB068A6CAD8431AAB7BA56221
      A8342207C82C92988A14875CD7330AB29CAB73523C0756D592D5B5B2305F0566
      DB8F3D5A6517567921D6A304CFAED1603A762669B2A46DC2B9661A08D8D971FF
      96D18365E853354A2274DFC5C5CE71374E8C29A3FEE27BD7251856D0C733A640
      CEE18CAA66DB52963948608558F5A0A8FCB0DF9B32309784B382C9CF9334FC27
      466C46481F138CC2C67A11588C0F3B39A32C3D4AF23C592C922CE7F2A47BB7B0
      01362B0EA2FC2FE3559A515DEF4BEABCACC247A93286D12823C3AECEAB458C81
      A2E87C82AD1CA14267A5E1CF4BC39E95860F531A96791ABBE5612B0D7F5E1AF6
      BFBE34DC43C131CBC3F10552C434B92A312C8EC2403A1A0797E16C1F3BCAC112
      BAD4989E4AD54DA3806B14E10AC6C992EBB4537C3A481724CB4FD26036937DC3
      91F52DF750D4E8A1B0F432C8839D0BFA769631D812D0A9B0E93205316FC3C78F
      3C65AB6A1625779DF639970AE32957F914BEA2151E3B765896B3DD8EFE7098CF
      B9D1D69E42F0B159956E83BA08265847D6215B2773A7AD66F666C210E6C96278
      F262457A632A9800823202A74715529B24B1CE4E32404FAD7B6538B28831F665
      82117829563B53D1C5E29A52701E3A360DF31CF1803561FC470915A5E8743A9F
      39738387F7E19D4E93DE2374F508B222B0586DDA7399B2C45D137071EC209035
      9851456838CB4804995005F5A224A7D2C55418AF68B6847457E65661AC6590CD
      85B4B8843186A246F0DA5D05542DCD927A0496A905367138F48A4A941E17AB3F
      0672325E91561AAAD2A7D87FDE8C8E2ADD0ED0B29D316EA190BA5621658CFBF4
      063D168B43D2485533862B250F61D849D12E67B40A230ADAD0A091C5E45523B8
      711E5E926F54267598295DC7F4C4318C3C2AB52F960E67BA540FC749AC920537
      BAAF9FEC68BFDE401E7B1906745D4D0A4FBA1A5C76A336A3AC6FB84DC553E3AA
      97D846039B124E65573FD9B327C767D5786F6234E6F1FA7850CE519309AEE6AB
      389A939EE620CF4CE08692C21F8368F3960A96D727E84749B9CC40824645B82A
      384F8383244E68F497709B5357BFAABBE5C3E6CDFC4263FDF87AD981044D7817
      0865E4B849462C568A6A520EE364F464A97E6128A85500DD9D731A85ACCD2DB7
      520E4FCD18B8EF02BA84446EB9778DD121B8429514056EEA5192C4D328A49A18
      20121F4C4F6AA6358A772344E8AC1DD50C099321E26463025B7D44C9F9846939
      9C02840FD3814CDE99213D203192FACF15E50AD4E925F8537183473A6F787345
      F913EDBE51E33CE5E74F783C7C12473AAAC96828B5A45206B5BA581460D82061
      885119E876F05AEE4F2B910B2096AFAC007D547B2B66229EEC3A7907C4E8A526
      87C49FE62079ACE2763F85AC5EE8E3E948A8818E9F27B1F40FE7C96C16C9364D
      D454879207291A4DDD9F274924CFA87C88DBF005666D0D603FA3306607323E7D
      A6B68564FE3A9D0EDE213E5FFA77ACE75E2F4E9FBA4921F9CFB23E84708A3D5F
      E092B01B6F830D816333157D0A1A05C5D00918589E2B06452A481A684801241F
      531124BAAF5E9AEE537372276A10F97E098830536FB2C7B1F63D4CE1F4E58F6F
      98051CCE092CB13FB453CF387CA60C0F539494E5808AA67319F016B169A027EE
      483F4C295E855286B80DCE7F3A00B4FF47E1A4E29CAA5F75D379EEC83261D81D
      8E930943DD698630771CB028380A64233A0C81913D1100B3CA121F9053AC5340
      4CA8344540FD9C434E952C6CCF02E1C4ABF3B78767882E744E0E62D19A272229
      42040F87425A4A6E9E0B0C1377EA705AAE9002CBCCE6A6C822A38219B31BEC26
      28854059020BF0BD3CB6E617EAC2ACA8A6A35B2CC9587952D502E7982438D065
      A3242F443EF2D81ED5726ACEF81A78CD9B9799839D1CD583F8D6D7AFAEAFAF41
      7C0BC6A2E9BCBA0EE858C87EE9B27795408E2464579E8508802B16A4C2AC4845
      2FC4A092C4F13B2DE7180178ACA75E775DFCE5F54BE69A6D77D0D513D7F7BC7E
      E5CADB5EBD7EFDFA44AD5336A6A4EC710C71331568BD27E895E22E4CDCBD199F
      7530B1239522AE7E0DDA07E857594F06276A162CC28D4D33EC32390BD95E4CA0
      22101281F8E1FD47007B2AA2907263657B97091AA7175803C3787510AFD10171
      52AE83461B843A3D45BC73AF4FD413B8E00A0526B2811E696581753491B52669
      AA4A0256635165D9D080A69A06B3C33776DE8F7E0380BC79D9508D5CB87E4AB1
      4289CEBCC20650E6FF9BA0AF5109683FD941705DECDE2B68E80E34353158F5F4
      5415A038472052EBC320456DD8CF9E3D7CA58737B318C00F33798CE206041CDA
      ECA0C0203E5C84537820B10124CE4149757A37152FDD20140F0E811F33B19A24
      B785C05D7B5A9520806B3390B204103E8212225C4F1310401507F80C5424F541
      2F5EC60F4F7551286E089BD089201264A29DC46C939059C6FE4150C34C8C9C7D
      B176CE02521F0E87C597976F16AB904C8DA9F038E0BAAE54E18B2F91C599AD90
      F4AB24DDD4E134169C5C38424FA1344D33E338FB70A68DC59C4089557B301D71
      2C2B8A713E95C24C981FCBA1342E33031898DF0863A682770CEBBFCE53018278
      4441DD0B6E090D84B6034C543101535481F7A6421ACE65FE7E1E5C709365F5AC
      0F3C07A8F4A464A536AB7CB0CA4CF3D070DC00222F9FEA0172E9003CD5A17C71
      033FC97269E4DDA7156AA76EE67C767FA4E854B669F13B55C7ECE1EF78E4877F
      60C21EAF5D8A67267FE71A7FBCC1818C2E60DF7F8E796A813305660A0C7D950B
      593E10899C2ADD434F17225920A5A01443EC25D0250A959610EF82AF894D44C3
      CAE56F9B006ABE851ABFA5BAC7E668AD6BA8C2C0C71865A4564EE75A1C33B672
      634A99924703018D9E6FD56FD00E71D8E7EDE9A95CBC0A4E4EA9818FCACB5FC2
      2B69558FC1CBFFE6284F3FF514CE703F333A2E6379DC1E6F3D9869FAF031137F
      C3109727521036310CCE1FC89E19C647C0C211AFF108D26525CE3FDE5ACFE155
      8FB7565A88B95649BE15C54B91B63E42D4CBD9B3E1EF78A4867F3CC6DAE8B0CA
      9ABF64292E1668A599777063788A9C907445BDD55491502A2CC01D2BB9CAA108
      3E48C83967FDA89669FFB96CDEAE0055CD7B272B526198672AED5FA47803BB7D
      16B80F4B3271E3566485FAC80640328EE84A70851BFFECC74F6892C3B37A1984
      11D25DA3057056040672A16F78D96AC9D3405B83610D38E033F0DC902629CF9E
      E54C2AA57088B8CED90CBC7C297A9B023709845AF8090AEF53B9A81DC9414E69
      246990D29AAD1A439E0EAE4D1068FA23E5AA22E05EFB6E2CD2D6DE165632503C
      26D14129A11FE72533A10240A115A5E22A0DF31C1D14855C4A46C26C9CA2CB8F
      3D1EAAAD35D6E160EBED22A4E0564AEDD3153624621B7610AE70BFDD825A21E6
      B95179AA41377F7C75DEC6AE2C2DD995E5879FCC1584D8CE210D5159A559D219
      A320833551E9AC4985BC6190CED3F3F357B2B14BBBA8F7218779780BD8325AC1
      82B3667E7DBBB2D977338115CB72EA6CE4D7866865930D630A45330D625CDDCB
      98D989A61D121008F1ED07B9622EFBB614A41F1A5E47359C06CDE2D630FB9222
      A3B24B9BC2848694D8B588F0E0A55F45B67884C87498FDC3578B46F3E7C3CF55
      5B144A4DEC732C2ECCEE5E2417DA4EFD8E2DB299C8A5C196ED36E8050AA9EE91
      695B32CD0525AAF0259982F7DC684E5F0AF0019DD144394E70C5F19A7B9230D8
      BA6FC2E07DA16498C81E812EEED9B6FB72DB1F18889FC866B80DC28729907E8A
      F4F1013201F195B7061FDEBC013FB8E4B41880EFA720138441E4BC7C7B86E77F
      AEEA4DC9037F6A92F43DC381F6E3E0803A48FFE7A70F8F880854DEEBA70F8ED9
      0FB2EDFCF4614FD0A3C3B03DA342F5A0E79C45AB9132373E3C963CC60ABABC02
      C5F7D09F6D5AD8BEF6F47A4DD9C13C3EAD9AE201A84D6FA64AD5364C7B86584D
      DDA664E485B282A0434AA84764A70996D493987C62E4FC92690258A330CB8B16
      0CA18C2989D0A6B5366B61B3EC533CA6EF57AF411F93B46451A5441C69C7E649
      A7E17245BE14981C75C0D0113A78FF08D0E0A2A94B551DB0CD00130DDF31A48B
      EA4913E047C9EC804EC1C7F98EE5135EEB482ADD6E49DE8706A9B22E19680728
      865C0429966B52BFC933164CE888F189C81ACEF13859AE514F68369B84A1C76C
      840817610490C75C7F8E9B3E29EC1886F5429B3474C292B62473E7A6409BC7E4
      0195E7669DAC38DF476C9C399E98A17BA056930A5900482685A321E23DC781CD
      42ADDF90B904BDB559126BB7B1CE3B929A0D5192938656861A45A04A7D5A565F
      E12E3268C9379175A504708EA79251643FA6621A5E9B4A1385AC1B4133D2CD0A
      24029688466F8650EC080C20E3062964B6DC3028BED3A182A0462B454D028A5D
      C764B094E9DFB7414D2A4527267741513C1B17E25426DC3D8ED20D007A927357
      4131BEA00802C3B050A0BD0228935945C0E543E5C84A233C937E27FBD826B639
      750382BF347F35EBEAFDF2DFBFEA48BFFF01A4252D5B0606906B5239A5A809CE
      84DDB01C62B8312135CACB6485CF9F4558D505D67596A7D15F5EC5D45F0BA7CC
      F3A448915262A06447142F508A93184789EC99C87483D7F1FEEF459A021C5A4D
      3D8ECF364F7CA3A840A8AA0B721D607548C96EB82E35832D2219D8280E672CC0
      68B1774FF571BA0C222C3344C78682184DA3C22DE644CE2D81C6CECCACAB97E9
      2A8236A41B1807A76501EC9F9C6B1821452A92303198084FCDD9C70F6F09DA13
      46C03122E0934361B1CF090529D3F4A8167F29B40A2648156E9ACE4BA360DD34
      88B202C1D9E649C940ECC423D6D1E081170008A45D73114DB89427BEAA441998
      B805636C835E64E1BD93DDB5E0AFF31D90E2255BEEEB183096E5EB489CC8D6CE
      7A79E829B4697947B5D714FC8FFC4099DA9BB33996483CB88408B9EEA21D9032
      17C38EA56BEEF15817D788788E147A30D48C63EEC658219F125C55ECFA249C20
      DBD6416E72F822D257898698B617A3DF5A8D859CCC316603CF8042DE3047517E
      5D0AB82E08FE2B9E9DCAF0C75733EF6BA86426EDB241D67EE3BC0EF84C9C9524
      F9842A2C036521C2921DDEC128968E0ABE338553B14A654F764DF8752D13166C
      A204B58F7021389C146F9B25E4E4C5C3E444A01D21AAE315530D5982E459E80A
      F03AACDFCA451072DD2E770EB0CA14D92F6F4AA3D0E4E2354B573CDBCC31B296
      B8DC0467C8C99A477034B0C8DB2C0D1477D0AD281BA488A840071838A0C455FD
      6E1DD0AB2F319C64B24C8E2F65D010C454F1E63ADA48AEC218EBC69CE8A61D19
      A7F1CA124C523592D51EEA23310E741FF01C8562A54B4930C16B8F6AE371B28A
      73EDF5A6F05CDDC7828C3B274D8C799A3308029A27C5B4EA518880C509ED22C8
      DF4B2CA6350E97280A877191BE8D7940CC4D598995D325F91556AED37E500090
      1AE7A54A0042FA433D97973BE08703C54876719242A54DC66405938072A4229B
      C0B10851D093D62C865C3126681D3020536F5672B025BD5C8159ED137024892E
      39D478896107B25C1645426FAC406E08DC5960200780215545D575B1CCD7BBA2
      615410F67219ADD91070FC9A145FD228F0693DB7E3A6212DC95C3B5DD76C9984
      7181ED68DE4364075D08C7A1220CC0324210E98E6A3305031C0C68D1934C9A12
      E59C61E132AC5A2B57057C08E10826145A3499B0D580A22C00998D97D2E419D4
      3136BDA7DDBA69719C66175C084AB323B220826C2D2D8EB00AA27A1BD1020D3E
      9642197250B5949B4521E9B487A54D3EAAE5B227CB14F10413126778FE781C5A
      41B18998DC87C845870249C8C6CE7F2DE6B8BBE6EA9D99A3DFAB608E7EEFAE86
      493EA8E71BB6B943618AA8A71FD538F4A8A8834026170A10527CA52175FC4A80
      E9C03A791E8AAB742094C1519AC8636D14CEB6474214473E4B05CE932907DE28
      F6671AE08A77E8122781516A214BC8C281347812CADC4771BD54F96A613C0981
      7BA2E85B3A37D2661952790F64EB99691FA256D0921618B63C7C909C1270F243
      0CFB0A49F8D515EAD51B0C7ACEB91964F0E5180E33FC5999994233C6D69ED957
      5456EAE94B4EF620887D104454F5161ECAC9659F02A1E875CE65C3921D1547E8
      2425B2B60FA63C4BD001DA718DAE02720D53B404F178156B0B03664EAB20D9C8
      3C2F32A2F1AA24C56E793A985359FCAD9DA9AEF00787AE85A70713C8AF40BC5F
      133E4AE9C550CD62A9E2973A9B53F61F12FAB5E127F0B52BB8E44FDE19BDDD50
      79CAB1F4CBE07DC767E5B7379BCDE302EF554AA071C4A85E20D2661A822CFBEF
      8C0C891D62B22AD423D3A1C901C02F65865A68A5F8A20C855D76919BF671B302
      997606C272B00E1105F8C5E5F3874A5A929A00E40C46842089B551925012A90C
      A4D7E59AB8FE40EE6009DEDC69E99454A59ED5A572F21784BDD2F44E647EED0E
      52242B6DC8E55C6E11A6406F410187D226340C8D8CEAB3A2F728886489E7AD9D
      D0059BCA34D02898C4FBA0F7983684B082351EE5AADE124A22B93366D9005683
      31AB321CAD600D5AA5536093D28EAA464793A21C1B3A0C4A38618710D5FD280F
      2D43C5474237B82115CA94C39ACE73D2C3504708535DEE5AB97134B294853795
      01AB541025126D2090BE0FF1ECEB7963F6887E6F00E8508837CB1A9BD8C169E5
      A4D6862CA997B017697D81B7624B04FE81556ED3754E4E97D2C17E136722CD9B
      5A599037528B2A54D2C98173156F1103A05067DC7BE8D3D279AA3EBF24FDE4EC
      C359E6606D29E39D5495477A60CDB1CEE7E134FF0BCF42D5C70A72237448D165
      E20CA4E7CB9BB19551ACDB9FB2190327872F0FA755C334C9D253F608A30FF9C3
      995ABAF4ED9766F992AE198678334C8ADE58F66B49DBCA423A9B74689451F740
      D2AC685D4EA062CF1615B0339697F15B1A5CC9EB2A94A6BD627946C03A87A45F
      05D48F4226356BB37F40D5FF8D96D545D221B5E2B04D6C3663D2DB5FBB898DE1
      A23EA5828AEA4C63C925A32E5DA2EE52BE51B9F73A92479317F68C5E0651A859
      CEBEECF7470EBA3A75DE6FB27A15C928B1B764F0DEB7551CD5CE93553A16B861
      9B42CBE6425862D5D6FAC2BCAFA55EAAF12583A478EBA45599EBE81A18616083
      0424993C00267851C647C1ABE5ECD44C3619C7BE8011D63CE2959E22CD35A1A6
      634A1B65D4464F67BC97987D54E3BA5BCEDBF7BC1CF4ADCA0D333884C905CCAA
      760526C850DE4CEDEBD62E6EA882BA8085C20E23AE881EE4C8C0675F929EB209
      30FF8E3909FE665837683D9FA5FB5EBBFDE5849F1EBE2DE50FA3CB0A6F330DF3
      6745DE704EDAE9662259B98092F6D72FD0579AA29209A4A1F920CD7C1F6C5B8F
      6A80AD2F30749BFA5792EB0534E755290AF74AFBB2280C8E6A0207FC14486FF1
      5A07F2E9804F0A06DF3C33B29261503C204FD1687BA4A93237EF1C499543AA18
      E8E3DCB48F64CA0F398A8E6A38982EAD882D55610CCE223D2CCD86DBBC499ECD
      55A949C026A381D4A917DC734889DC54809384FED19A83C7D87FC9B76AE6B848
      5645CCD80BB9E565FFF088035CB0CA56AEB7761662FA664041A79B1453192FC8
      BE807E47C646F43C88D44AC89B74B2F3B525E41F4B56AA1FA4950A13778F6AE4
      395F98E91142956011B9342A2EC4A60AADDD68C66F72903A563FCB8A28A8937D
      1334080867A5108B84298F1418E442D0368C51C3E4FDA3852A6B5A142EB91B77
      611A24F964C4613766B1DC1FA87A023668FB535371BE7671FE5D26C16DDB1E05
      913776D93C95DDCF089BDFB27B5699778C362FA18AA769C2933336EF4FD9426B
      08848699B35C579056A17CA3C6F868B8DFF4FA1D6F9874D1B0530AA2C7DD9851
      5A863276C6E20A6328C81EA20727AB43B94A21A5C4E8848543B7806E6CE5C1F8
      AF36D74DF83F058131DAD285895891F54A19D846B266AE511F520F67786932C9
      E3D18B22130D958721A0A8A6C2A8A71156667498BE1ECE93E20A525CE4051BAD
      8F0A3D2D8911B330385DEBD4EF31626A6B8D3232528AB13B17C7F7849936E794
      0B9E1B394ED2BF475681DD6F9225814782832ED1245B6586A4B7E8F05F6A0E99
      95AA6D6FA8D9077C625FC9A0CF8373390323CC387E37C80AA7269EA2E2F4A059
      1E031F9C630A6CAD70046F145D2D7B3AA755BE5F23675256AFE5D635D54154D2
      D082A89E9593C30A0B92126DE8346E32F580228674DE958AFC2D0707DA335123
      87893D149F3D14EC583250E721CF45C9A7581C05C550B4573E5649C58564B98B
      15B2C990DC635F31FB638F90FC93EABD8DBE398BDFBBF09B8B0191DF1370F8B1
      D0DC0C38D9E2049B9AD7E7742D33501FEE958D52E3849DB7A94E2037034FE0A7
      B256C5A3EE3A7D7AB17A264670AC9A4BC53B707AE6C9FC7C14537956E37992D0
      B8AC3596A272B9D4BBEC9F265F4F9E6DADEE69C7B6CAB136939D6C3258ED39CC
      0D33B1174BDCC273B913C78742188C04E1D8796202E3A8668083833CA832F269
      11691861AF556AB6F0CBF5AFCAE77B73B670A7E99CC9880D0EB99D70F022354B
      63E5863C5D4EB6C078B69487F74B09F4D5D3200950B7F02CA224367A48EC0C84
      E4C8C74D3C28D1BB0ADB4943673B958453F552F22DE022F1AF9CC1A50C2D2CAF
      8BCBF7C820B9EDF5500339D9E45885D7EC9831559BCEE5F92F0C3CAA9FF3AE80
      C49D00A1EE59EC8FB174A2F64197B1E5E231BFA832E1BF160258B1E907433FD8
      53C4952C76C1A1383F759DB17193C4500A863DD95145D8501F298D30B9E2BC36
      65352742853D44B60F067057D1C4E6E2A9C857694C9E256E9383C69C4C171ED6
      7A24BC7C920633DDC89429932EF45BEA6B2AF54F6EDA8857B292FF3FC506A5F1
      F61265E42DE5B5C9FEADAAFAC7324D00580BC38EA6605998ED997C33F88BBAF5
      37EDC366D01B41416A12B20C3E65F6DDB0A394016C945A50012DDC591E8EAD2E
      A8A2365A0A432A25085D1266C57D928E54CD254B6B80D62886A8BA8822A1A6E4
      D043A12B9C51AD1CC1B872D59FE7119A9E70569904F5C31779522D25F1A09524
      087A2FD72E57DD62E5FE7E2FEBB170A02D39079F4732D4562709CBAC73E6F0A8
      37A9B4A28CBCEEE1B434B4E150A2F76A421A2B6D691C645295D071B9FA615591
      42F60F0B488F001549A550EB1B83548E2F296298EACE4E1CC264CF77ED39D599
      E2EC4BE9CA3B9473CD09C6E364B1E020C7D86CB565A4EB4BBD751E48E654E4AA
      4AD727865C1699F0708130B46ED43093378694FE2A16CB0496B62E6AB05C05EC
      0058C5202B3BBA6F3495159B70B639FBD76561F013195B8E350F944080F19F18
      E02F40745FAB9EB4E4BAD158FED0FDA708775E12301EA70355B9132656B14854
      A9E4BAFEF437EEC0C0794F0D475F9F44E3ACE19C9D652747B552681856F9E5A0
      A11DC01A121E3C36A89E0558D5B831C292F48D31FCBB7CDC56AABADC422982E3
      16E0E0E034CA1E5904D8BC681CADB0228602F28695E88009A972E2C1192F49D5
      87434D4BC5D3762918DC6812ABB005B960F759189F2EA360CC21400977E87883
      D571B0DEA7C4B64CC6AE9F349CD780CDB96C9542A19DA18826B2E606A6C0F1A0
      C5589CBD4F55B572EA37288C0271E786A564D73C787096F4228C86070D0CD40A
      CA66C21341C54D9609D51582A320A3A2EB82AC242454C90EE186EE385FCDB0D6
      535D2B4814CCC9655282591CE6B0DE13B4B34C8C7235877CAAB8569CF29E2240
      0FE74021E9DD0100E07D94ED8942C0AE3357CEAC256D2D65A904F1F9449E422C
      DF96395CF514248C9073E288FB8D52115CC8CA015CEC2AE3C8C8D7AC8507B01E
      F532B49A583CA566716B5976E47010F439D1B3A28320CAB7AADC942A3EC63031
      4D3DE379288C28C26386DD46F9A63355F9EB2DC8C069766C9ADFB8CE2FBA076E
      7C34E34ADA5C916C52AE05F6CB3857B7E10BB25FD5D3F2C73713A4EAA01A7F4C
      DE9160F93380433DD1708AA7F1BAF99D47331DE8ADF234C9734966C630478B9A
      690C531A0745A14D9495617B00A7AE4D61AA5BF6512D5A9F18A6B5A60C576383
      62C98E989BB5CCF4030D47169C244587DB64975F428597950FAF545A47664A48
      F524E7C244AC9E538BC07275056AE3459B623E01071B5431A1930DE364528A6F
      2BE7C69AAF67F67F54BBC258BF080B1921B05449381E47B74F93435E6147CE27
      B912688B04A9B229B1281DA76EE012664633CD09688CDA8AA24F82B130EE0F0A
      1B229AB3269B4D8C9A6CF2268A058A44105315408EA84EB0E8193E8ABA22BAA3
      080968FA538DF154398C2B778EC5516D99CBF84119F657185A68F4E2D4919727
      30B64B6E54A3CA0983F71C4F31152C0AFF8926ECBA6C75A50F260336589FA882
      6BF0C24CEBCD722314DBD07BA70A5724E82287A3556CB6AE7D207B49868B12C2
      5C05C6A455C8B01C1790A1C035ECED4E2620A094AB71BE4AB1629B2C535827CF
      92AC6D87F66BA330442075EDA266857C732A1640D9B24DDC0E78CFA83ECF2A46
      B12E4F12E2D254276B85744C39B19C8F45D1420C035F65544A2370404AD505FC
      65688DCE52DAB52BE29AD204588EA5E221645400EDCFD85A2A7C5CDAF9639361
      11F69D49EC3BC627C435E65421608DDA43C728303B4C0E09E06F0530906306FE
      F1FFBB4211E4DC24C0ECE660BA5132362A7FAB49268F5FAC9D1741263ED0061C
      CB9A1BA4798E926BB59BD2C3A2026E0D0F255B68B9522EFB60B0E498BEA3FE37
      87047CCEA272CE5EBD7D8B3B83F52F65775E79EBC9C609D9984751A8A4E1FCA5
      E19CF2EAFFDDB910EB6CB32AA5348702E03826EA79141D37F4B71FE0902AE0BD
      892F51FAD2411EC7A592BD5C6AAC38689A2ECBC324F9DF7B59434A452AAA33A1
      6A4B19274BB244CE4B5375A3642408F5A60B547242609658D19BA0330F280784
      6E94B1BD99D0A3ABF76E640F90C5B688925C962CC0072C427E003235973EC983
      6C2E6C0661695C5741EB3717FDCD048A52CAB931122449A0BD500D1844DBFD51
      745E33BA01B16F37718AAD2DD0E56DA995ABD1DA15C8074DA9A818A812F433AE
      1435A16087633DEA31F94154056E20476B34586A1F0AF01B58EC9CCD99DAD1AA
      1C96666152EE026E9AEEA40F3B4B9893B2EB1736737C01841B59002E4ADB2A22
      76A70290E6E40B062A802C52BE33C8374ADBBE67EAB80B367A9F08800DD9CBD2
      84ACC162F4104F5771319CA2D0C5425619967CDC969A0D9F33CDEB2C49C96D31
      036D585653A6009B5D1395DD0532C21D0AD39BA2AA9BAF62A39A97DC3F3828D4
      4F83AA1C734D2E0E62091C2CD18DB80842DD2C25A90E9DFF3A05027F666F394C
      009950C6087B7EFECA52386D223D963204761102250D2324A8A1D0F7548BEC80
      E2557E54F11545516DF413B0F400C4004D85D49AC80458C1F541E753406B3A2F
      64C56E55A799C4D484DC4EEF9E9F7F04BA35D2474D3BB00C195946A8D1C864B6
      7C82588F25FFCD9C7494881B52D224AE1EA1878BE228545B6C151DBE8A413665
      39A58EA7884E350A7F82E570CCD887A5C45435F6848EC952244B95B03449744F
      83009E114B2553C358EAC81ED5C8740BA04155160F1F3B8875D3AEB2038C1948
      21C4ACB53B5889E2A84D495FA8D210606D26F455253DA63CB2F03AC01CD3ADF8
      B690A361653996E3E7F01B0F90952B177239B9DB862AEF7A2D6DB0D87C33E59B
      67AB421F17467D75293867B4522DFAEA3A786AA0D8F9C70AB6497517D28B2125
      61F7723617A365FBA4E435D515EE5552AA89D95484B421F78912ED95B0598EBA
      780CE71C4F84E681AF7F84EEBDA479A8B2E600F0075FC79BBF03B87E86C3F366
      F13201183F824FB1E9FC88F1FA82D530C60B38ACDA6F2E6BB20B195322BB7CC9
      8A8A311554D42ADA24712E707FAF7084B5ECEC35C1895B5E597BB3C0D61164FB
      CF248921D35096A4DC29824C9B5267576DD40E87739A649564436E7828BD8A45
      F172236F0265416D733E073016746CA76DD9BCC5A91361C59A7ADBF2F8C9B126
      BB5C085D51450AA2C63DD2D55A3609E8CE1797EE41C3C50749E7C9AE44C605F9
      E31DDE8C75DF5A86B1592AE532F611882D2C6D5A9876F064D3350A68E7C000E2
      415266A04AAF055B81375D6A5F9534C7C4424863EDA860D24834284F04840254
      DC388FC4E0F51CA67519920AC041AED29E7022AF4618A1408D72A802FD8402D2
      2DC5288AFCB19DCE90A8C9577E4871E03214B9020E2AC5642337C434FB9180AB
      2DA76C137F75FE8E5A9532E97D9B8C033284CBD2444517500E1D8844D9E07D43
      FAD901E3EC8F6403F920A6CE2F3FBEFD9F0FCF5CFA9FD7FE15CFB6F20C14650F
      5557F8A6B8168782CD0588EAB284A304D251AD7DA24C59C10E6021D69900D3F5
      878CB844F6D119B55F65430CA022457B79A6C205053F29CCF6665B1DD3E893A7
      68E3C5197C503AC6041B416D9AD5E89C958D4D077C1ABE57206F4E02555F4472
      CB43C1F68F06D282B6B10B22851B43491214BEC28189A5BC35E90009991EC764
      BE2D9E263FB1151E06B20F21A7D89CE9D25D49BC8B671D0A1E0244B80A5A7556
      A22CBC4B8053B68F988302D9F08269E45C1A555DD38E3B19DCB0512EADE9A8EC
      0A787179F46982360A24D64C8DE5802DECDC47AFB0385CFBE52791AE7F757638
      A20F4831AE4E562AA391B6D8E88AED0F6E8EFA076E04CAC4BA15DF6304B99F4A
      2FB6514C6F7777FA720882CE2AA02254D4597056344CDA1D5856B414E4200229
      2A35A4E2DC20BBEC83831183977781722BF5ECDEE916A73A448C624ED8B5BA0D
      36B6B1E8C6259991168E9EB16835835735F3EB5CFB28CD9CF452294D23B640F5
      3B0EA7DCA01B0443EACD5DCA333BB1548EC9DB2F581EE1570EDAB1C4ED6B1137
      B2BF3E26512B0A4B00B5813F91D0150B8DB384144BDBDAA529980C129AF4ED0A
      33DCAE2221E3D97408A6125774FE1459FD65C8D2A798FB9CD037D5EE4F6B7B32
      F6F6589A2E8F753C6DE14F3B2ED2B871AE2AE46CEBEDF2DDCD47DA4304C1CDFB
      0828F4A014953C69CC5A1ACEA7971F1ACAC0FBE6E3BB6358F63F56148E469AF1
      9235F316C5BA649B4C4CA6156A3F1F230DC63F6070318744941BD21EBF787F7E
      FEF4EDFBF71F75C01FBC1D035A4A717F4A9A6462C306698EE52B971D59A5310A
      BC53E7F81CB5294400B9A5683017B1764352FE0CFAF3741D146D2E8055AB54DD
      71328BD1A676C2B907D85EF3F88D835E2D07DD5ACE9B270B873C5B32B2B06EB4
      7E56893FC084536A746D25E2DACB34983D899FBCC4B42500F9D53C2959880E34
      4FEDCD8ED43415B9B4191756A9DE956089910466710ED954AF6ECA3D6C12066A
      70A28A7029DD30A6306E0AD9B2385BFB21B874161806171A1ED0C341CED7C0FD
      3EBE3AEF3C3D3F7FC5798EEFDB0D8CE40B88FB8BC94C5533C68F98AF75C1D433
      660545451D02170166ABEAEDAA6EE56665523DA6A4C96689184C40A1989A58EE
      4603932863395EF16AAC1B45817613715D440BE13D0BAA6B1C4E491EC89B4EFD
      830AC053AC02235E25B360450DB909860D4FA7CD13E7396B19677F27370D1DAA
      601452E05E365F4D410942A1889B6173428BD1D164A3E6CBC674E55A64AF38EC
      DB80D920E8CDE4D00433F4A7F478A6229F38CD0478D514182105FE8531662B70
      984C6C70B91F9EFFF48E391CF9440B017622F2A39AC05CA2195ADF295A62B21A
      1BB19C9CFE041C748A79A93096CCE040D6A7439A76A3CB98EA0D851907446268
      793896E0909B9E2962A7FB721349843B6123C709401304869CFB912867817107
      2F504DE2C376D864616695C7988340287A0B8E303BCE4A71B584D30ADD8A98AD
      DDE1BA6C9CA3A44798FAC73226D34209F0F51150D522402CDFBCCFE8A66C9C26
      034C7CDE4EF095BFAD16CB22704EA720C9FB8C88A9063719A4C4125A94CC02B6
      B4BDF62346CD069856B5CA298D5AAA72B443E96A79408E8EA3DACFAA63973480
      187DE675CA62284FAA2CF8894F605190225B83E0D9302E62E4248F67B69FC49B
      7FF9EF5F75F615C883B46E8C288CC972A58222F55648D3348FABEB84CAF7955C
      88739E34213CDEF5FEEFA8E6E49B51FCD966F259CC55E1E1AE25A5EE4F5694A6
      AC8AAAC4EA751A5D1A37CC891BB76934326728130251820BE3950D2FA3F82955
      922E4F307CEA504EDD47B3B0262FBD089A3AAAE10180A337C153576A26F63DB0
      F05799F2C0CB8B549DF7CD4BF87186D9161FE73A6A0BD3EA51003901ECC75E6A
      0633D3072D05C956475C4701250A44A4359074128C53E077A00367A51E41078D
      B2DC877C22A23C7096148C4739238784C018DB746C4080AC36BAD3878CEE66F2
      292BFE945224492C53DC0570F38AF276AF92220101E8A5D44595DDCD14C44074
      06899E82A2D010C8E3E3B324A01EBF1358258552FBA48DAF89198C18DBCBC17D
      EA4D4735F52ED38609A41C44608EF7D72B941D178AECA01D6F5139D65C002BD5
      7AB8892A3AE1901DB372C11BBDB9E874728AB7E2953E4C6CE7CD3A0B49B57028
      4D5BA60201EF09A320E58C0059CCD2A43EAA3BBC99830964C07CA30611E78D29
      B8DF781C0AA216641799CC998B05E8399B6B2175CFD8037676174DCB583553A9
      D8C6CB36691AED1285A2066C3551C90CA5B7EA5D9804301053BC86B1B946C564
      329CC28C9AB01D24A1EBD63CF5BF39AF88549E0391C4EAA69F64E9F12036EE22
      8407DDA8FD9D185F608448CEE835515D08D44A804E97229A60F6A114BE8CA515
      DD1C8DD912F0443E4F28786A7B6F29C98294235D1B4E75F88936D1AAB0B2E3AA
      3129473566C5604675AF2AA62E2729B72C363BF7CAFEE3A5D7ABA49C50DBE1EB
      1BCB4895370F581D6AA7EC9D3B29A8C49CCF6FC11779229C8432294AD1EEC011
      022BC508675BE79258E95DA8D55C6C51ACED43C96A238EB65870290D1A718B28
      64322719E12895732EBA279DCAEA6C17599E6FB55EB72948984CDC800E71798C
      77BE89AFBF8F8D3681304C8835024159CE39A89DC8C0C6C4B99244A9C9539972
      F3A31824CD428996C665DC94AE838519AD40C1359906B1E63941043EBC60FF41
      E0D062F31FF1EDCF5F34F99E1920A90AC2C2BB70842B9C34E57DCED0F88FEE5F
      74E99A4FEB1E9A1B139114ADBC5273DFF1D0D0E1300E04375C782ED904D06E74
      0BCABDA4BA8E70689FC95B5EE2B83C89865C5C79595B46076CD989C5440CDBC3
      0C09589AAC66F312C6C261358677EAB2F5A1CAB7BA01C34B29F9923C28A86EAC
      523946B0203E5AFA4E47EB539D9B4724858B9071AB8CE70D9D0DB1795D91FAE2
      FAC6FEFE8C8631AA6B29238E107B36CFA2469412608966C9D07D595F3F65E244
      8532895098A0427BCEAE5DB899C351B507CC42300B2EAC52D22BB1A0223ACFB0
      E043CA3C475124FCA52ECB69026E12F024B26C9EF813A37DA5D1083367674A6E
      56D1C1614BC40E7D69451D387874BA8A10CA58D7968E6E5A54BA914DB98DA1A4
      5952B59355DD3A4ACB924A089A58011B2825C5683BAB52AA94CC808B789273C2
      563213E46BC0805CDA51C50736C627B869A8656C49368121092A5B93A93A8B1C
      BAF0C99721E4D4DF053A2D8C957902B7147424F592146E6A404187BD98E42013
      CAC00C9A5BAE7879917C22651769FB9E346DF0484DC952808DE83ED6A50C8C6C
      D942823A149D8A8022E9FD51AD004A906D00C4482C464D08B018A89C607687F8
      2D01A6C60B361FD7220855781078F0B8ED3A1E4DEDFD6E48B2A303EBB355C86E
      16955992B1ADAD24C23A46B9271C4E1FFC426ED5B237BEDE1A146A2FC848496E
      1E2CA8E87C2FA265C3F9415CAF32606CB0C3DF85F9F7AB5103A35B9067532F71
      E051A940DB64303B9CD6AA05ACAA4AB16D1894B52C8B459AAEC278925C2930DB
      F6E79BEDCFBB5FBBFD3922BE738A1D6655D3592235A5E236FBB25DFA78C284D1
      9A5B7CC71359CC1B445C02AA54F731C79CC4D999B47708A3CCBA2EDF92AE6232
      9E05D9BE2D9B4911AC99E47212ED50129B86528E8FD0599B034B00129B2CA962
      ACA13A288814EECE9462BE60F599D106615F162BE9ADDC61DE27752D13E925CA
      AE1F44109D92D039A6B283644520F191EFE76A7BA89B489860A2B8F30A83A931
      F62624506099A87D5BFC514DB19853E755B4203F56FAFCD393ACC47A8C03EAFC
      0F565D91620BD77A0281779553F1982C93D5A98B70BC249E25540E788585574A
      28A350C50A0735D97792ABFF01D0F9001E0EC3376AE594633E55C500551971A7
      6D79035EBA58AA19E5532889C72F29FFBF184F523B3682A87C6DB324A2B26111
      BAAB5E5E18E73CC25A33E8790E8D46E7EC3DA7F241F43E39BC7452AB764616E9
      35E549C522246899E03C1CDC7F5E46231D7F81F505614E1109BA88480A5E8C49
      0682E28F12BDA88F4B483D8AA4BD87069566667D06B06B2559308B0A557981BB
      5418491E35AAF05AAA9C8A61D1A408A688CE2996D348525DE660A328A9ACBD5A
      CC24341C74CB08039EC8CCA5D686E3A9A8271898AC9270B990BBD0482440D98C
      5986DA1C5FCD54D60D52218A8A6115CDA30C46D4745E3373E2539E19EE9F4B59
      C23ACC2886B6989A00DD4207B271EB378CFD906C517B2740F423471B3A065671
      98AFEDB1AF9D7120322C05901165E303526CF1006DAFDFA9B3A99B3019BB95EE
      EA54BAD51F52A9C668E69EC39A0BCF0656DFE1B764AAA41D50D870B15AC8B702
      AACE8348BA646590A4FCA9945D276BFCEA71751F4B556C5786025B2D7B53CBEE
      7D6D2DFBA876AE36F69410622C114255D70B5952BFCDF69751565278ADF07279
      587803399DB87834374DE67A90E40ED1B1D9D223B5670873547B1D52C56CA905
      E6611EE99489BA995C7F52D4FD2A834EC5A72C64480CA006A755516C3CB32A40
      8711659D050BEA485F6C8BAAB8482FCCC27F8A1DF9720AE0322C5E1ABAC8F18C
      4FEC1B4C11A21F918A314835E5C9F542B3CA451ED5B828297768A5B62F86E144
      17F107508D8122C625E8D18B9834696F71E91D9CE34BC11C4678E6BE808D51F1
      7C817EE55374558E30365E9A56344C29F89E51B67977F0DE11B86F54F1D33CC9
      B1F2A97A9581BFD41042C8646DA098821422634AA576E3F1D6A34BD575A1FADC
      E1862ED384C4B884F30BB379BA8A2F9C2C7174DF073528AECEA8247BD3946E87
      3D47B59BF1E78025BAEF11CA7152A49120768AC5325F63F7E70313EF8E3F038D
      4D4D49C4D49CE2A9EA52512EB17E739BF072843B054A5A516C5314EB7F7D510C
      08E8825B1605DCF3BB28DDCF35D160F3A9403F66CF634C28F6249751DFBA3515
      4A272072E42B0AD07A21E2701617BF2618D5895631A45CF37032291AC6EF0B2A
      BC99B288A88B0B544241C53371D1EF391E2805969386719668B1FC2C2F592562
      ECE1D255F8DEB96EA752147CBCE59EBF536D1C31AFDFA430BB37DF32265660C8
      0E2500B198A353592BAAA855E2E33ACCEE80EB90712553C99F8E5F16303BAA21
      847ED250DB55A0ACA8B1A3325A476B32342E32313EDEAC7FEABC94C5F0F9F876
      DC52409B2CB3C0E224BD965BAA916993F2B6B8F3149642DAB1851C56BE3DC53A
      35458369CD659779E2B2AB348303B45AB231F32AC6EE4A275CAF1F00A0DB84B0
      0B40B2619E930AA9D34A33E8752BF66CA1B35087BC728B7834B6022ABACA68C9
      AB2B5A1990FB3031B260CBB5F5555B342596EA5EB38A8E321C28F898C0602553
      A34AF1F308D96580FF92050B6E05E416B286F44165F49867FC3360A93AB59CAD
      9EAEC40E09B4E1ACE24CC6B4E168993C76C0D4B81B4176A27D65F462D370095F
      C9371C72773B597FFEFF52BF679C7411604A7F4317FCA2D0CFA52C3FA34E03B1
      529FACA3698846D62849D02D221347C3A25853F59E17FB9A5F0FBC2EFCEBF55B
      3EFCF17BED3EFC6975BB6DF8D3EEF45DF8D3690FF0966EDBC35B7A2D1F6FE9FB
      ED363F8DB700F2F468187730C09B3C6FE0E25D9E0FF7E1DF56AF4DF7B5BB9DEE
      E32213ACFEDE358D9E3BCE0BFC7F0949F87CE638CF557CFDE19C2916DB34F2AA
      7360B67F41ECB3B8F790B857201DFEBFFCC6FFD328E81C121662750EA6B86464
      0B53CE6AABAB34FCC2B6E6FCCD29DBD6084DC955F4D065CFEACC0A4E1EBC6E1D
      4A6B3BCA52DE77BA92233DC27C3984551AEF99CFA2AF9F3925152729F1C20396
      DA5E17E50349CEFE78606AD8FBB8D031F260D40090146D794B86F4541435F947
      81CC84512DAECBCEDB37D8B26547AB44D0737E90C9AF4F11E0984965C67BA8FE
      C7DAC37781DDD18C7ED9AA3B6EAE6F96CA09677B950241992CA11D0495BB80B3
      5D558331F29F25496EBC9DD7874633ADC9D3EB496F030D700203351C5C12B662
      E344331E1DFBC9C9CBA88EF17CA9A78E5122CD2896F031515DC2A9E16E112A03
      CA2097285F65D6B8BA655C1D7C6DE32A962FFF01C9E77F11CE296C96588B251A
      F76CCF9EE7D15F7E5273A5D3B6C7937D15CB8AD4588FEA9986EEE97F2A72019F
      F432E0F34F3B6A3CEECB5ACED8CEF332B98A9FB139492DA7622F70DDBB1674C0
      9CF98D2AAF364682CE94924AD8C85A032570DD42C9F9D7E0D747352EABF10E79
      F4A7E5534431A78E5EBB13E7A9AC1EC7C8A77F545CE58459916439E4BF4E658C
      619607EB820D71D9036998D1F6127A2D36A7D36F7B1367D8DBBDFA0523A15AD3
      CBC032964BD5C8BBA3A78DF06965397A4D43C6E28AC20A8C21328508C74E7DB2
      612E3A29CF7C82A5623F373FBC69B9BDF6033E85321C2BC308556A6C9BA28121
      188928DB3A848773063FCE4B80A817D57794961B9A7275A9AF0A4FBD5C9E5205
      847056BE8E8F51054209656FC8C24F116D02EE253F36A278366D45B17170F85D
      F97A29ABB22073E250E34C8781AA862CD84F5DE620D993A14F068BF0D46E7E95
      8E3971893A2F8DC39CAAF2511D1BDD999A6B001EFFF212948A5F1D6A4B04DBAB
      6CC64FD1528E79CC8755F38B6CF932F1862B4D6D02A85E821043F344430A136F
      D3A2CEC2665120B4EBEB407AA93C72BC694099BD1C4D4FED51A4E72070CE5EBD
      7D4BE15C47358C05707EFEF0F625D94C9C0FAF5E7F50815E7CDF892AAE2DB048
      5790AE4B6AAA488B865DA85D6EE106910C9D46B0D5325D25ADC90C078EC3E41A
      681226D24598ED1A5CBF3A9308AA2BEBA23C8A7A7CA23B52136152AE4015B58B
      1921987AA95FA6C2F5546A3456BEE7DE654E5D93336AD72A5B359CC8C67BA5D7
      1F30C930EABB31840EE7A07F4C74C6CAF162130C4555376056F9DAA92329E572
      2DDA25CE85F8541E1E9EB034A1C233677F3FA15A32481E8A3A31A532CDCCB3C4
      E4CFD412F614058FDFC4BF61B37AACF799997B70587CE7463038759D79A9E4B8
      CDF0C8A068847B431F5CE9EC90C63EBC49363A9501CD3F688EA62BBAD3B0D4F6
      918931D590FE8DA3B8D4ADF5BF6992AC2E29F774A04AA295BBA5E2A84735599D
      89AA1D81DC4A6901E3315544A7D40939B965FAFFB7F7AECD6D2349BAF07745E8
      3FE0559C3896776499C48DA4672F214B72B74F5BB646525FF674779C28000509
      2392E010A46DF56EFFF7F7C9CC2A00A4489964CB6DCC9A9A18B744E25297ACBC
      E7933ACD3E56006EA332073A9BF7EB4E20F104DF5273F93ABFEC5D44E3C58358
      2D26115C7514372AA66254A3F1C4A6B8C89B9F5A25498AE0AC649F517C396985
      9E2988F618D49D9E54CD2CAAD534426A601A98511A1B23D754A25A14767C5D02
      5CFD280D565E8833DA024DF21EBE7D77655A9963C277551B0141AD61A93F3030
      21958BDA2CA8FC958DAB4E195BC8741C41A3E8C5739AB0B32F9007F8F3C338E3
      DE685FA162BC777F15F6AAF60D33B95C168E9471919CA5CB5AAACC96B02D0DBE
      ADA1AFAAC91CDDD351B383D0921163E03EEBB92F2558DA0CC51B0D71AE7A78E1
      CCDE2BEA37C04794945D5BB971FF75334F3620A6D8A46BC6F3339D1255BDFB1E
      2764C6BC00698D45184029E2AF7624135BDC63EE640CBEEBCC427BC6377926ED
      2AF6FE5317B6C783E906F6362F3F989BAE310EABFCE3FB78A676B60BC75FAFD1
      FEC4448CE2BF5F5BDAD9C5E2845F73DBFD613CB565DC0FAF79F53E03903AEB67
      1369C5301C245B21756AD2F580B1FB67CC3DA2D6B57880F8D3399E376BC1CDC0
      2E1F183C49DB652E1718D26C52547DE48ADAB4CC1E543710A85345F778DBDCAA
      0804CB4DD5A74C9E5358D96EAFDADDB9BFD276E5A48EEF07A3D31E1B9D564CA9
      598D180F3DFE8EC624BAB332CD28EB6B5B16790CA6FD3AF6E8D72C623811DEA8
      79846E4F67F4F4F2CD57244758692A59FA8491F7E6554F3E6BA5D6F6EFCEFF7A
      F5EA9560E382270E46E252AF94D88194D9A65072ABBBFEF5DFF8B6C312353B85
      063D0B7539C98954A13C0DEFABBDB318C75B3DECCF3C2417DA74752A4F0918EC
      D7A56D958500E480237429CBEB4BE22B70138356C2022A3D0A352FFBC30625EB
      08CB98D197A37A2AF9F16A4E1369FF75C3293E14486759C66D114AEB93BB8329
      8230A164ED942ACD6AF25CD41221A76DBD2A51D6377A0833B6CF6DC14665F35E
      DEFB776F8FCECA88F63FCB59FBA39D695F651FCF49DFC1D118C6FAF7FBA9BA7F
      F4303F7FF466BA6FF38706FD084326EEF0F8E9A5CF24B591A8ECD147FCE88BBC
      BBC3CBFCD9065C3F7BB6A7E4B51C4DCA29A8B9FBCAE65A1CA525E639905E2C06
      378FF1E507A7976759BA4558E2FC80BE1A8943F02D273E965901EA2B02152CA7
      5E4FA675A4EB168322FDFCEC57A7B81B4479DF840867B1CB625946D1AFCBAE11
      666DC97C1D43E88F407B331DD3C5FD5CCCF627AD42FCACC273E773D3A5418A08
      F1F6AA2E9C15F681BA33DE0E8AE7E5E3EB9C9C21B3E597F45E4A9E2DF1C68C3E
      402F897396FE918A6F19AF757CE8EC8BB7D62414D8EEAA323287ED64B21F3819
      7D984F2C3238855CCB1404FD5171DC56BEB2F74AC095DE9A91395F558DC18490
      C2487964098ACF21665B8469E34652D2C9F0756517C167DC4510F31B4E2A9F5A
      621AD2971B6477429AFECCAF3DE75354ED42E79B8C9E9A49D477868C29A85DA7
      76D7724140A17687E573C82F453A9E56C3A22CF5A1EC25E3774FEEED95ED2630
      0F8634D77EB4EECC974656761276C2B54E3C4281D413377B9F25D44FD6921A03
      88CFDE2F17D76F2F9770C1030E659B2A1AC7F370FDEE8E3D004A9EBA5F2BA835
      7BF9549E6E5092A46C567138FBDE5B641B08AA9E9E2568469A732F395B7BF619
      7626E5827161626673C34BDA31C932209F0393FA5D6FE0512D637984B5B4D5CE
      A7519D046D069A2E32A2A73177ACB48941BB3B2D89A6D4416B38BA2E519C6261
      C9BF099350D696013950FD31A8F14E70A5EA2370EE17EE0C25C023BE55531C49
      032F33830CBFC37262B0DB3E7E10021421148F882386D72BE232DF72CFF4AF47
      163232CDEC5AEC959CCFDAA6D5C2D8AA920A9123A38E051F67CA7D29475ACADA
      B9D4D1484F7378FF8379E80CF8147D2359D5F54C9699BDA12FCEA43BC85F9CF6
      967A67B664580360A822DD85612E5F172D97EA5C5960CB2E92793296AEEB06BB
      CC06266A590245B97C0F640C989CE8B2434A5D3E0BE6C20CF084F87FA419587E
      6BDB16CD8CCA2406D840456EA5B856F14D6D78F47C1EDEBD27D0D75BE65E9523
      A4505B59D335C90A2C81CB6485AF0881EC64E1FCA1A24D3351D0C69A55CF9895
      E631119CB1B1C95DA80443416A6070F581737878281504034AD0A0A6F5F93525
      ADD853672CA9BD62429FFC5CBEF25776B1DA9BCAD2D7616E5296ED37A5A580E7
      5E9BBAC1760B640F45D284F324D99A0637D3849B1AB0D6466DCFAF41C58C9594
      2994CFB7609DE4F49BCFDA66502E695360222AB62726E9ACF36B498659AD935E
      3E7CAFC793AA390D05528A3B581803CA82D91ED29D6FD440BFC986B7CE73E7D5
      3B9F525BE9AFAFE7481ED5A76D63C444E7AFFCCB53AB6865C3B83F4D2AD27C6D
      8C221B522E66DA6AE181124B374F169B57D93E6265E607772C311F502B9A83B9
      CC902A07CC84DAB37B0628DB2A647D95DBF8303EE1DEB99ADCEC7131B2917CB5
      0E8636B1998E68D58B947A309BB72407C425548D4B2D10D104EA9E4B1AA04C6A
      69F7885A925FA930905085AA207350D6049F6109659C67A65D8F60D7955E49DE
      41DA07CA6293404FA4AB3E55C2E6687C551A21A3CC6F39828DBF586F55DD3523
      02BD7295A5D9C7AF091FFEC8E953C68A6382BF941CB370456A0268A09232FBFF
      DE82962951B5EE8BD7F568E3EBA184FFA553A8942DD88C36935444CD293ED403
      B1D361D93D30A1FECD856DDB5D962ED6BEA74A8729B4DA6175E28FC4CB9FC560
      1CF4AEAC185472BACA0C3718D0F2FAC240A86145CC0ECEF83B164DFDA0C4059E
      D45A89DE37493FD8AC36630DCFFBA30CF2D58212AFAA6D3263B155555C26A3B7
      1CAAF17E4577D45DC218C8AD2A6DB66A01CFED6F33D358777767A5152B598EAC
      D41E56623AA6D6157B0B16C5CC831123E8F2C2F9E1ECE8C4391F938233C9A4F9
      33CF7CEF72329EC6933DD213F78E18AE045FD90FD93D2E616D69396D22DEE4EE
      92F6212B3DE78060F768E8E3289B8C290158285F301BB4C4FBFBBB3BC4C0C873
      5DA505574D9367A41595C2D28C9E52B7F66C64CE4C6D7A754BEDFBD7508CC1A8
      A98296FD9904C03756D74F864FA8E874EB3EDBDDF99E853DC9D77CFCFA846143
      FAEA5A4EBDE29C0AEAF84519715F0F9306CFBC3ABD0C9E5F427D334AD8F357EF
      3AA1737AF2FACA52652DC190786B55AC7B60733E4BF4D6D138CBC726A1301EBD
      33E9969546520619244865F38D85E5F3C3B99D31AB3B636852330DE1EB8C5899
      9B0F9D97549630D74F59622AE5568B89C75D0CA3AA918E701A63F5B10B6F5C4D
      44DC2B0C72BC57668D5A6787BDAA4CAD39AAF452DB9D7642FD998B720C9415F7
      810004ED226273AA659C69265D2EC3FC22B015C7E932D5DB042A5E34B77B5DA5
      F92E46DE14B512262B5980048341A39B09B3B1E988B3B06514E2A994705F6C72
      A5A1CF3FE725A5542D50CCD7C2215EEDEEE456F5AF74817AD3EB25EB04D6319F
      64912D1B4FB6CE8870081E3D7B6377A7162897006EADA4689F38A4384129F6FC
      B46EA355276AA644A9CAEFFB34296D0FDC8ED15928099D8AA3F769AD2FDE91E6
      831DA1FA68F1105496F43E954A1F3847C7DF5E885FEFC07973F416979D7F7361
      2E7E7BF4C319DDCE4FA44654564BCA196564FF69CD3466E86CD2B0FECC46F75F
      5EF2CB8A1CD81AF305FAE7EC76D042E12CF8E5B6D4FC27A63A886E22174AA5ED
      9B3293D98E92E4B860A069AED690C437867EA77CF09C95E7BF381F0F9CBB3A78
      DB4CC66A8588516835A650031987B57A1E193A157E485FE2D9422511B4E20F91
      434A1E5D5BBAF79429889D24E2E89D7DAA31BFD27C6ADB452901221E6AD62F48
      B6D6DC5FE5EA72CC7E7E8917D2ADCD5EB7F43BABE99785F69832DD2E76019EE0
      EC73D4853A840AD2077B83FB7756C999ED558095179081834A6D58B29833B938
      F3755FB585A399D6EAA1E93A7A14BDA59889B72A63A53C74A6A50CA0A208CE4A
      CECCE30EB8D4864D41901D1635B35E2E6393F2066314635D5AC174DF42E798D4
      C0907D4C3B54F9C52428C6A6577D07CA6579EC2C45E64B8F9F9B38D0505BB7F5
      3AA635B14DED31BDCDF87C81422A429454274BD25F8F449083F9E0891C4A5FAC
      BC6C224CE50AB5C5344827E571141B2D39A8737936BACB2FF8B175706932C3C7
      520E6E8142AA0202031D9A4BFB76CAE1625E2B864C76BDBB73634EB99C6F3ECE
      E264AC73B3687A6D94D919BBAB1C35DB5E15DFA91624C9249436B000A6D55796
      E388DFB076B7C821E6C21F6C1E992D6D255B5016C2F482B56B448C9663C01F4C
      C48331EA4CB784832AE5CD8A2833FF9BDD9D895C6A13B178CE740BC927FA86F0
      4BC752356FE4D41CBD6F3D45D047AD63B5EAB2423EBC055D38B221079E6DD25E
      C1AEC02905048C6FE3EB611F578B334EAA93BDCFBA143998A101F5B3822A8267
      5DD886AB602171B03859845C41F7175534036385D63B27107F9274CBA18037C4
      558A3327A594F99F7CE0195D772601E5750DE4892266A6E25915A2E08D4BB547
      EA85AB51909A6320CFF0E46F980F560673F544830738138DB3699B15CA3E2700
      E10994DEABE89A4367FFA55443D1256A0611AA96DD5DCD51341EE1C7A68E6AB6
      A6FB03B5671B9559CC02952831C6D9C800B62C8BB5D187AE35C702CBD0AB5A78
      52E81BD1942BD150172C3C369AC5403CAEA42912673759BAF799F14C0CD5B2CC
      B96CF88365394F75D96296D3665871CC941EBDBB430F9746F72CD468BB85754B
      2A374135D7E2AC76382BA45C6D192AD78092CCDCB3CB7423A95F8B82EE5F5F6D
      07E7B3DA05AA3B25565C299B7C7DC3703E7A68ABFFED2346D4582AD2B1227D2A
      9B30DA2239A08AF2424E36BAA13C04C312856FCC172BCDE48F5BA03C13228092
      25F661653D71EC6C4BFC3B6FDE9D7C835D31DADBD743D73FA831E30DCAC417C5
      F9CDCA50E378AE4019DE52A45E17F9F0FFDB92CDE50D87DE7291AAA33C337641
      829337206F335708411BC9C75F91967926C9964525D44BA7A26177E46D4CB9BC
      673C9E8EB8BBDCEC229A648BFD52092237D55BF57646A1283BC113E7CD8653A6
      D784B05825D656CF23ADBD98B13A2B91FFC068CB540DDA40278F29D1C1A6FCCE
      6E318552CD9F1548DB6C63094A55B81DD2631710CC7D72B123CEB18D19D5F9BF
      24B5AE4894C41439EB5BA08A52C5C1468915427C98FBE97D320DAB56193901C5
      5E74DAEC7AC8756BAA2CE32F534428002C915568F713EE614129E9744D34CE6F
      45011C1A45F7D0F9CF7C2AE2E7967DA811E9FA1CCBFCB0ED0B4A5E9B7CCCF55D
      5C1073C6F92BCEF30AECD57C4207E2E2FB219180E0D01EF533CE7970FEF6FDE5
      D55714F678753FBB692E519496AAAA6AE4BC9FDD1D22ED6954F7CBF389B58BF9
      E6F2CAF937E7A2340B6475DF17F4D5F125BEA2525BD351B4FEDD1BFAEE4D6E42
      83FCCDD325E198023617943C5B77C9BA58394AD31FA7168FA99383A40DCD1284
      BD6309FE247D66E885566B77678BC9CD76CCD16804E626F9585C166051D46AA9
      8D5FCF613A725ED55A8CCC65F1556D9E2486526FAA9B0FA23CCA3F1A376DBD4F
      090BCA7E36C0AF14BCC9AAAC48F3147B2F9FC1E1F2C64D0ED333248C39E416A5
      86006A664251333EE0D29E97B71D58E7AA0D159A41DC2B0A3F5882AEA78ADBB2
      3A7D2E17953401F5BE44E976F62FADEC4CB22206E9506B12734B95B1FA7466EC
      C2052C8E5FDCCF0B9376FE99C75C1FADA0D8E593B9CC07F3D6FAC8CD7A6394D6
      1FC77D51B9728C1A8399D412A9B237F77335800DF8528095B6FB4981F7E8785A
      8BB2F2A3E55114E8949BCB921BF2E0CCB8C4A9BF167BD8A7061CD0C6A7D93431
      1ACB3CCE213D66CB047784FBB1DAF64FC8F5FE30900CA61CEB843A591F258940
      B7BC4ECFB282887A5F694A1E7BE1BCFE10D12F7FC561924BE82F623D2FC89D8D
      2BF1CD653E9EC897C50BE7659EF7492FFE37E78A7ACBFCF573E438914A6110FA
      6C173AE8FE9179F3C822D82C6875C3BF4CC7436E9F53F97C6DD53E148612F492
      413A4D78FFB1E3E30B96BE58B0E4E5A25E5DF25A17B49CF7E08FFE70581D6390
      E09C8532B36B40C9EF660C1CA9E0011E526CC12E18439788238D0393D25BC189
      0575D4A951C64CF78792F97CB6757DA9210A0589685F999A7A5E5AF3FB67204C
      034FB5C28C30FB4DE6743A4CFEDC19E1A8CDC1EF901424516C022C1452B10981
      85E9DF368DB8C3231711DC486BCC5A03AB9BE9B5A6B0C5488BC78263B774F973
      91989CE4C4F536B66F6E2DFDA83E986DDBE61A16DC1F3C36EF9545DD706A6519
      4C5CC7B643CB5FCD15111DACF2EAE7CF613C947FD50F5DF59CA77F2D2F989469
      280EDF2C6976D85573F55DA92B83D6AA2794F7A4192754D49E519D89852FD4C3
      C4FE51FBF56B92ED10260C6F794A0EAFE31B1DDFC24CBFFD92DC6F23DE777F1A
      DF0FFBF727F228C888F34C0F660CC7810C4E684C6F2736253E130E5BCFA51296
      A1F72A726EE0CD8D7D5770C15E91F7DFF393C9714AF1E80F19175448BD99853F
      B5790104145C55F98E6A092E9F217BEFC77CDC4F2E472AD607CE138A1FFF7CFE
      EB9303D1E93E53DBF0C7169C8BA7D13E083EE344E62887D89BE24CEDB166B5B3
      96BDF57469C6F0071A74418396C83D0C4A4AD0F8B1FCF8736DBCD124A82A801B
      AFFEB3A84866DC6F1515217DA6914BDE33573E617F6EA5D4BCAFA8C1F59061D1
      18D35F9C0D9C1938931943B9BC066EEF0BD9DDADC7B1BBFDEEFC369596375429
      B6BC6F35C333C310FFE4AAFE283E1069E967CA51BC43F7D0FD8F86F529FEE24D
      BDDDC5FBF72736F516352B293B8B919D9827AF87697E321D8C9C8F97A70618A3
      D4D89BB2790690D6E6735D9D1C5599B8CD1C2A01ED48D6180FD46206BC7AE71D
      38AFDEFE2089B3B5156FD82C4C3A04CEF161AB6143835937835FD1947149DA14
      B442561DB8CB0FA71EB1178A066D924F1A36ECCA85DACCF151F70E5BF9F20843
      73571D1A0F84349B72683CD8D475F24FCA93B6EF6F2E50F8E655254AD67FBFC4
      1FCF8FF993040BB54AAFD24FA1069BB6106573D8C790278FB673AFA860E3F4F2
      DCB25E9B2CADE39BA145381223802330A7976F9A260EB7BA8CF3F3AB77FEAFCE
      37D4578232805EBF7DF54E52DD1BB6550C1253CB2127A06325C544632DC915CE
      F131FBED1B36721A5555796EEA219A748EB71CB87A1E8569888E2C4BE39118DD
      A34F49D7276F8E0F9C775C31018656FFE6F4F2AC4C5E6B0AED6D199CF33383E1
      3097B376DBF9E9C5770DDB28B061EF39EC995FA5585CB844C3C6783A2CC8FFAC
      AC078F936E1969211FD85C9E7A03ACA669C052D080F33AA6B4A20F04FC016DEB
      5AF206C9A8CC93C4E4CF366DE8BB3B27C6F39EDC0DD5208BA1124EA9AA16169C
      EE2736215F3290CB40A292D68FD4456A12DF1C3A3F52891741ED4E9E65A6A444
      F5251779E66159EAFCA6C7B9814D67E07F55141451CA45CBEB8BDB9D03941428
      2FB32F6D0765796DAD5D88ADDCA5EC20AAE8A36CA08CD22AE95229DF868A68CB
      0A142769F398309ADD9D0994E2542667AFE7BECE43DD348DF2E5E511812DBC6F
      1D060D1B19D97F8FDEE78A5BDC2DF530630536F53157992BBCEB2325712642B2
      90EEBAB9806045D990312A12AA3A8CCBF676B6CC9C013040538A1338E4E643E7
      843EB8515496C24A2FEE8BA501AAC9B63D3B0924847FF52A27BCCB7E168DEBB9
      1A5B87F57287757BEBB09ED78116ABB57FA20EB4BBF3F3E5E5A92841C72C1DA8
      77707F1A59DC55679F9459A3F43E3D20694825CD35BB85E4A3558AB1DF8FCD49
      FEE5308EE3C70F551137689C520E8D94D1197F75F6046A78C228D8D269A4D8B3
      257492CDD7B4B1977AAA19E5D1A44FE1FE5113153EF16DE09F5A5162C386B8BB
      73797B37CE06CE0F1702D649B0B7D3894F7F9BB3F9A26CE35A30B0E70F17C46B
      0FF5474E96C0ECAA0F0EA46314A7514B41FF33A853C1FB317DFE2CCD7DFC564A
      D6A6EDD6EE4ED9D8E105A9A0DD67095471289537FAA3A236F6044666124F0C00
      3577E0CDDF67823CEFECBD248FD085E49B9448A136CF644FD45B03256F1E6473
      C43993859FC2756F0D5B9A01E44B56D55A60AAA5CB55FA4970E3FA6C90F5312E
      AAA038308E0B69D4251540A63A4871B94BD9BB85E397C33291AC2933DEBBE036
      6B162784C0A2E7276491B5F973068518A96189C13690ECED9A49A3868D9BA4ED
      C0667DFE8B6759D6A025CECB3BE92AC49511047E5BC2D4D7FA1098E8AE60C6DE
      8D9AC7F2A868432038FF1B62F0E9991A9DA93154CFE270F2512A3CAA2FFF36D5
      C5E40AB3902FB18F8CCA399C08A40C63AF4889ABA90166B61743DB82FACEC544
      D2BB8268817455B9AA614B92D94641F711D11B36D2F7060080F0B62C0A57C2BC
      6590FDA69A38E2612DEEC96CB2F4531D9DBF6643929398986CFE5E507FA16196
      82810EC83F94A93E7EEDE789D8955BFBEF93F6DFD6FA9BB7FEDC2F6DFDFDCCB6
      86D1332F05048AD52392FD46C96CD8AE99215F9E36577337C685E8EB8EDFD085
      7C40B208B2184355D83CEE860DFE9F5AD86C65C5A76445FBD0DB4A8B7969E16D
      A5C5FF50563C9DA4CFBAA5C395FCA993B11A167D35E1C09ED4101BFBE5593C7A
      21D7C7F960C07D0A38FBC5FA6E1A36B5BDCB0919AC937C6533BD6113F8B401B6
      E5E30FF0F1ADD67F8F8FFB5F9A8FFF536B7E9CB453C618EA3CF3BA2FCD31079A
      C2B74D1B76191D79C5B92625D8932C36BBEDC8F94513C0DC1A3A09597BFAD7AC
      BF7A9F6749214DFE24B3844AD90B9E02436B4D09EC80C258C6AB3ED6A9ED9477
      C0DA3BB885D1284C3E0944C2807C2F940FB2BB6380B0088962C4B5CB8436372C
      3B626D59F0A759F036EC7E8F05075F9A0557ECE088E1B3CE5F9E1E1976DCB0CD
      FAE77140733FD034FB283D4D07A3C99D01C768D8383F1ADE4943B52CFFE5E551
      99C1D4D0E152CF58A18341FEDEE200414A116A28E555319A7A1FFA4311AB9126
      09D0B089E0B859A9C5BD2F3DF96B2B423E2D425A5B11322F42C22F2D42041DA8
      C92E4FC9AA1E805F8CEF9CBE56B7CD1C600DD78C6A9C3889EDE4F5D19B460E96
      119F6D407B4C3DE99A67A2A9E4BDE29C84B33CE182B1C249B5A25C8D860D945A
      66FF6F6A98CD12C1746590F4DE3265C2E450ECCD989A1996FD7D964C29AB98E0
      2D1A36AF34A78C7B655B5E493B1750F5BB46E6E255919126978854A364484493
      4B479E6F8A401ADFAC5CF0626FA28BC9E14811D518FBB534F1295F8F616F2891
      C5FF6FCE66812EF2DFD04E9E1AA4613CBA6193174D4015451E675C869199BA0B
      9AF5E327FC52662256EFF7DD9DC7169A079F67B43E8DF6338CF5FE02FCE1D1A6
      B9F73906FB5990CD767730DEE1FBCF325EEA2F3A2C1AC86838B31E92D37937BE
      56C3EC3782686D1FB03BCC7D4A4E3069605B6F9C2855528BA2419F0147EAD920
      378378F1AFE617E269FFFE1980351BB52F2943B43E7EA1D43FA6597C4BED3508
      9DBB9FC593E273C0D71A39C458819CFEDAB0D51D7E8E1AB4772F3E6F011AA74A
      4B771898F623821FCCFBB62486C4BBF13758F738F5E3184CA9E332D39254D380
      13296AA2FCE8D3DFC3FC0F0F7FF905BCA46425BFFC026DA5F8E597DD1D5B5F92
      382719F7C9C358F7FEA79FE1CAEDFACE0262DF64B61B3D610B4AA99F8A27B92D
      796DDC0C68F427F9F0C9845D6E7D102205550A9AC1D5C5E9A94913C06E96F115
      1B2C7134B53ED065E1AE138F5571D3B409CEC7980EB8EDEA7CEEC0B37F37500B
      F8A52C956A9ECFD1CCE647AD46F9F0F9D178908F9F1F0D06D3A1499A199103B8
      B8D17AD238429391BF7C7772F51CFFB8D28DACEC41C3CEF612E54EEAD3D8E224
      0848D24118B85A3A7389587318CA75DAC4CA3599EA6B1BE93879F7F2FF38309C
      937EF3E4A419ABA96432FD22D907E1247AA4290972684335B50A8FAD777BA977
      BB75E86D9354EEB9B73B5FDABDBDBB9315C5543B61EFC592BEC373D014B53ED2
      DC0795B3051C35A0ABE8F2128982F0A12C6A5AD3B8AECCB9ED63D22661228390
      FF287D91A4E384F4B73127FF1DA17381CB0E1A3A91D07D51EB9F3CCE27A205AB
      E1759F44C578A0FA267821FE30A330DB264D7955CB467AEBD3864DF2269FDCEA
      BBA25E7559954E9AFACBFDC7778A9C12D93FBE47E499ED0F7540193A23F5F8FE
      9CBFAC3468F246AC63D96AE91DDFEF3FBE73EFD9E3AFB219EE301FEAF9F1EE3E
      42978A7F79FC1167439CC049F3CE5E3F712E6FB27462608760C44A1C4F043BD9
      E6BB3BB7D988F44E9873F48D3992B812C6C23E29A73084C6D4736C1A9B3A3FB9
      19AA4C412D0A2036282F59E09574713BA1501154F6C62F065B4A34E577DF3DC8
      9D18DB8A4AA333C2E9C26A8D8C70252C28368C4BEE2D405884BF54E229376C15
      F4472AE7D54BC76E578181A9AACEE5D9B0A12015322AD35C0383B863AF2F35FD
      31F15FEC93A8FE9CB50BA66DBC4C85B34F0993D19D6314BDA6D1EBF164DCFFCB
      312185511B1B021970DE52148DBB3812AA6D3F1B45394678E09C16B1B43A2CAA
      76CD42BC0D9B533D8BDA60AED90343CE17A3A026D398FA2CF70B0B584A905582
      CD663BA6B04FB0DEE8BB293334A5F312E4E456960694E3007436C89D27D22F75
      F165140E7DD2B0092D893CD78AC18B17E4BB114C4F460DB131E07D26E11F9F1E
      D43A8E382FC7F98782E23547FDC95F5E794D3B75E58ED47AAA44797E3B50D254
      1AECC4643BBC70787AEDC3C3C03AB95579E98143D3B3DF5DE7DC59B36153AD25
      29A6347A0BF4F6E3C59B13C28629FB210EF30F07CE937CF8A4C62D1B3697FB59
      F7FB91C6748CF7ED807BBD5A3389EDAEC6194A660A36FB41911F94B058726A29
      0FC5CAD9972EC2459F4020A53C00476BD4D704DB63B8E95D3E1D97780D596AC0
      229B39D38BFB95356616FB3F5E7D7B71C03EC60346743D105FEAEECE488DEEC6
      D38269F5C0F9464F4EA98B20231296AD2EB0286542F65BF5FE8CAB449CFD090C
      E65B96307FCF871F924ED3F67F77C7AC8B64BBF384F7ED7CCD9672DB518A6048
      E38E373FBCF9C6D9BFEEE791EAF357F8E02DF548D48C1DFF6442D84CD4445A00
      9E8EBFA370C78470494DA296A924315D81EFAC712BC9370CEC81DB6A35244D59
      2B5A29DFAED44F17DF9C502F7AEBD1CD9D8BD357201F066317DDAF9180C01468
      A33015A72D8C25AFEEFCCD895B9B0B56FFFCE8F83B1C7D76A050FE53E32641B1
      B697E75727F6F0922C346980519EDC51287852F59EC3956FB9E37823E771A171
      298737B95F1A9D0B9686D792A1A9C46DCA1184D4A023366B16742E9E1BC86E13
      C5E509D445FCBB57975735AEEBECB36AFDE432E308BBD16E9E18F1CF8A409A3E
      DDC6485688916CABC8EEC548BA5F3A46A28B91413536DD5428770C07DC74B4D7
      C5A0617B66A2025EF8829A721413180EDC0F34ED1BA442A836D7635D149C612D
      2D93D91EEEE7A4CB8FAC7FA3A1D3EABC70448F95EAB352D64144708753C2D725
      F5B7705E5F9D5145047BA9A86374BD1A78A809D926A636EDCD8B3F4B15022596
      3067ED5286B934412FFE31A5F87F34C6A6EAC9FD299B78D675C676993838E83E
      0BE5C3787D05F4DB437DE8FCFCBFCEB3C9E5241FFDDA382F235BC62751FF9893
      51F2E12CF0A804EAA881FB35B97C544461CA7EC23DC1699AFD3B568958FFCC4D
      7F0441656CDA596515B34490AC5AD9538247693E1B50549A826900DC34838C2A
      2B854712755A0679475977F184A0FCE21B090D4C6E8C839855B8C2E6F005628E
      90A6477037E50DEC50369B2A0EBE864D7C8973EBC0F9FE35C7BFC7797FCED375
      54147470076A08E21D1FD8BF23EBD562CA6F9E5BCB9896C2797F3AFEBF17CEBE
      1EDAE480DF28BA51C601FEE3E9AC0142C6549367737EF6FAB29965E1A54767C0
      BE883C2A724E45A462987E4DF2BD70CEDE9DBC3CC0BF972707CEAB6FBE39E27F
      2FE9DFABCB664E6A6A9A01BD39863D573726284B5B2735D9F5FDE577E746DB6A
      E8A92839B54900E72004B554D78EEA678AC22A3C2D07128C9801F1BE864E4554
      8F1A5E8A6D34C36E84269F922727624B3C31AD856E34A7B3D684E793676EDBEF
      F85D2FF4BB872DFA7942B236D2DCDA847901768E0C7793DF2B0F228F1714E99F
      8EDFFC589DB9C6694C73DEDF3DB2DA7FF9459A1A3811D5B0167B363D6BDEE9FB
      4FE2EFAD7753B21E5AC936A343D5C45EBAC6CD68795D4DDBABB33C101D236A34
      B0C8D54C40B8C2F937171735D18E7FC6D3518988AF2637D763C229127474F5BE
      7976D5CC6C16F0B8B36F4E5F312D91CA222CE0A737EF8EEBA7BEB9F3D9FB5E3A
      36DB28DC4F97A7277B6061E3061AB85589888C5D026AB39BF1F6FCF8FF1D2C08
      EE6CBB40ADE249DC8289DCF324F6BEB427D1A050C19E7DFE16FB71A6B9890AD9
      B8BB3B2696391D82D20F9DEF0BDB701D6A89B412A42DCEA5BF86C96EA44882A2
      0CEC71563B164DD9EF4B4D504B3CBBB1FEC7341B134A89E456735570C2C52B60
      4F49D3462EDBA4B0CC14115E56F34BFB40E8BCE95D59FAF584CC954C52C7390C
      447BD9B0C9B17BE1A84645943A05D6A125F14692BE9A36E8BDFF331D8C18DE36
      2FF50D11C84F0A9BA43FCA47D31197AD356DF4A74372D93D37AE3BAEB3807624
      D5062627B269437E935F0B1953F0EEBD1E7F186718D590E297DED9CBA68D7677
      E7E78F27A010C2A09EC00AD71F636DBB2D8DC93145B16432EE6EC6F9F4FAC6B9
      E00FCE6D140467E14691A9CE09BAC5440D46DC3375C0F663A4297F399DF6B9B9
      2AF9DD1D9C10A9F764B5A569AB616B0A71E96D61E5470D58456A7608B78F3C11
      1560FEA1736E8C42FC1FB63E6588726081FDE64D9CE57CA0FA817C20D3B08CD0
      A7AECEA4A8897CB07706BBE7E99FA954FE1135F20FEB2097D659FDA2611BFAC5
      F543EF8BB74A7F5B6F95444A48D30EDDDB25A9BCFB558FAFB1BE9E52173CFD91
      FA8431F4CBD3264EA31E9FD9BF7AA322684309994F07CED5312589BFC1505FE6
      1F1B37F84B4320261941C5043502E1C6DE0A5B2B275124AE55F9CB2BE6E4A4E6
      891101E608A556E36F231028ADBC71D3BC30318FE26E38511F9D1B9CC93E9D4B
      3298C665E2BB515BBF1AEE4DB0E6C59673CF73EE2FDEE0F907051B9CBB8864BF
      5111DBC41480918B94110E9B76BCDE4DB95C5BE202FF0C037E2D1EC2B61B1CE0
      9F90FEE9D13F5D679FFEF9A00A678FF23D38F19D66B5F7F5E8746759116F99C2
      3C53F8E27DFF76778EA9DC6E9027599A518916E3B40C466A9245593F8305C632
      3BCAF1CF89C62432E7A753B6CA7E3AF52CA41077912DF2E9982ADA28C3A66907
      53BC65D4F9F92D0DB5B42E8BDC990E0B31BC05219E5516030A517516363ECFC6
      CDEBE5DD441FD1B89DBE1E5E638BA0E38EC93EE62071E83B513629B6B1881562
      116E6F1B8B98674E5FBCCD1CEF120E63D5C03DBA03ABCA066A881913660223BE
      FC92F613D2B1FFEB977FA15F2999C2F90CC089DFFEE7F9E9C59BD76FBF73F66E
      269351F1E2F9F3722C87897E9FA921010F1C827D3EC77F9F5FE922A0613D7B8D
      2914CFFCB0D3733BDD5EB8E7FC4E23EF27E3A23F5977CDA6FD5FE2D45D85AFFF
      A131FE0EF22BA06309FDD16FB4F5FA23E8943DD9779D56F79734CF27E6D71826
      EA47FA450F93E18D1E6BBE9B6EA1703B112D3F4D482EEEFF52A49361F4F7CF20
      CD1A75846D4A08A5E0674302E751B6DA24D1714E04BD7F61F26A8F2ECE8E0E9C
      B73F5CBEA614B913F780CADCDE35CEE435533A7D8F8D37ED080583C0B9A60C51
      723ABF3E9118394597FAD96F7485A4D336732AAF96255A706DA2757509B46E09
      13DFB0A998B28396EFBCC07C28C539A74A752A7C843A43C5218C0B510C9C7DFA
      E5FA262F264F39EE5046139A674D59DCAF6E17B33A117C4B76AB90CA593689C4
      76F5A703E8A1D984D04EA0B961E004C72F8D258B321BDDD94FA61C9956CE8D92
      0ACAB18660611C86687AFD944A4A717D46789864A589892678CB8A72409ABA40
      ED760F2B648BC36F3830A292848816AB5614CE4F6F2EDE9409FC067D9E907C24
      682FD1059A7D5E68B9961B06402040E68EB98A68985D0F6D01AD4D0E7B7D75D6
      B415B1EBD1C27AB083B406A1C1E50A0CAD5198CE0DE05B59628A368A43E7A85F
      E407AC73ECCDDFBB47260ED50D0A3B68DAB4DFD5028906D7999CADB4D15CF00C
      B133A1347EA664C9C98834183229CD4D9B4B79EADD8AA68FD5081A67890F67D2
      B1860212C3A546DA341CB425464946E61D6936D8D8136DE2017C2F4304328153
      1CB120E877C25E21F2F86A9C31DB00DB52A3E78BF764ADC74E28CACD92BCD443
      D81B4328DD09ADD34815D0B19C3D4271DE736EF51DE416C9F186ED2AC5B26A98
      3A166FAB69AC872387753EFFA7BA4EB6319BE631832FDE1D94DCB383112BEA39
      CE7EBFCF32DC663B6987B4FB8F981887BAA1F8938C1FCB85D984EA8ADF6B46B3
      CF31CE3B53FD18E99B6CD8386DDFA86E6E40AA9B05B931052F8226CEA5DFDA34
      F46CDAF04B5DDC6DB3EE69606B4D45709E3A1750B828762588FB0CD2C46607F4
      938B1216B7C42B640F415FDD892357B26C496D135D9DBFCE87D0D9DF32C6373F
      B902D7FDE9F8CD8555D26797CE14E9356DF1ECD2B59EB7DB64EC550B42D46E0B
      5304CFB2CC35963CDDFAEAF5F3FC763A7292E9987C0DD7927B9C184AE222742A
      B26680CBE970ACFB5913859035613A588797D2B5C1A4117C6F9B3C901D766212
      35CBD91704ABD7D0B9902A2F368AB3670058C4EDB5875DEC5BCDA081C6889D00
      9DE9A31FEA454333900E5C318EF3C77689C4910E9D4B717DD16699C697AA6F13
      AEF958D209E650D4EE0E373367BABD7634BBD6208E8AA6D2668BCEE80FEC0024
      B40EB320C2A4C8E4A2BF4E2FCFB856ECD079A9E2DB6B76A55498EDFD6C90194B
      8DBBE0E0BF25F0855906CE3E6E9E2A6B97A0C3624A1C85CAF9C7541713CB720D
      8BC750C74A103CCC014EC7EA9A4A01A5FA097C3DD2B6211078F27282816C61A7
      7103F3784BB1D70AB120A7EC449DA90631D514846C22900A7C58C84D3C54EF07
      0C5A7708ED13C7E17B8AB0925F9C9C4E35E705D9413A4D29F7E33D4E89C46EF1
      0BB9E8C4A52165D74D5B1ABB30A4D0BC330A1BAD8BD08AA585821A42FE8D3F3A
      3255D894F16BFD925596F8A173220783DCD3079642C85F095997112245F69B4E
      AAE531C83FE219A19ABBA6AE0FF9EA7EC8334CF6EA6EA40DB82A7426F2DB8E46
      1AFAF5A17326B32DE484CC9C84FFF1A6D977433A2D3CE7AD81366FA07DF1DEDB
      95DEEF818EBFE728D13DCFB38846CA3331FCF0C01E4F2B3B87D45E982069C827
      C78AEB3125BFA6623E94865F64ABE1212E08EA7322D18A12149C874220DA8D8B
      1B5682829541D326CA684E261B47D0760C9281823A704DCDA30CC279C28DCEEC
      4C6985F8F2431BF048725DF01A156CF3DEE8D9E7DA54252385F82F2C9FF88073
      3296B19226B1F0AB612DDB9CBC453CE58B373CB25607690E7BA43EC3A815BADD
      930056947F04CB886FF2B1F807A27C4238EB84D60986D1B4A3AFDEE719215F88
      5A4F306731816350D0DD6A376066B9C3755D898EA6D7E43AF9533363FF79D3D6
      BADBB4B5F9F3FBC5C1387F24A936A15C02DB1651C44B467ED88982BE6E5A5B68
      983654F38283CB90E6B62D89E80B55B71A6E2B8BE96404DFF4567F9CB2D57039
      D16AC0665071931BF84FA805D2115415B78E8A088B980762A41FD8C374D05050
      A7730302BE2F7937D6BDF2B4C459262549826103C82D6B6D8B3E4433B4D55D27
      30ADF261948F87CEC99BE3664E768FB0158C1AE4BC3ED95B947F64DC4B0D9BC0
      150DDC44D1CB0AF78501759E8C45496CD82C8E4C723B1D4371A9D73A04E143E3
      B7FF57A7DB6A35AD2F2E0717347B7FCB8EAA71DE67436398D8D615362F0AFC94
      F3C21BDAD96877676F1692BB844F301D63E38CB40251FB4D6B9237476F4FA463
      024F18BFBC2EE9705F5A3FCDF67C7A7AE8BC1BD6DA7A185C0CE94CFB510A2AA5
      574DF65BB31B41959D6917E279927AC0FD774CF87AAB41ADA04175B61AD4BC06
      F5C541888C94FCDE44FE924CF5730EB9502363D3C28D01F6DA87DD86EDDE1BC9
      7AD6CF136D12A0B5339DA45D932C4D0E8BB11A16FD2A13DCE4A71E48FDF01DB3
      B2C140C087C0A82807E872326682DDDDA12E7D921044B83EC6E93BC9A942DC80
      48366C3D0CC41298AFC8D4E7A583979A0C16987492404FB03D79B72C6B059615
      6E59D61CCBF2BF382E8645B479777245A71A4299D5B4C4D99F8CF369448937EC
      ED3C511F86D7534214D345E34CB1B23BD3AB12DC9FB0B18F8E4F4DE2A1944A46
      D988919ED97A316ED8D76CC35685A4636A83371F21178C746315436129EB2916
      3C5272FDABF8A198C3CD04FA393259268C838FF1D22FB5844786BFE0E0760D16
      02BAEABCBEB6ED3FB30AF70BB6DC6F9EFB7D716C09C336609E502F05CE6FA04E
      4CAFCF4F2E6DA708E11D0DDBBA99667427A7D432CAE4661CBD39FE563A43EF9D
      682904E7134CBE7630F3BDA6B1EEBAFCA975362818CA6FACB9A78A01E0C1352E
      9D292939C4BFEF044F98D8BCE5D8E418C9B96491826B50B31D295F6CE6AC6BFC
      970B2B394BC0F4F82CA7467BC91C97A953BDB7CB21F36BECC448DE12A05F6D67
      CE0463FC9C4DA07DDB79011366FEE83FE5182AF752B66934849939AC9C8ADC28
      7438EF2768CCDC1928CF1A7F83ACE0A87AD5E8B069C31580EBA575A497E7A76F
      9AD994E09CCB479E450C185179948A3BE85CD22F734F1A394B4DCA9ED454EE73
      0CB2D636BDAEC2502B236A2231C99BC620F74C959CCCA269833B02EFBAFB4D3B
      6FF26B19207924C76398C4FDBBAA8FE9238CDA5D75D43C4685EBCB51F33C52D7
      C93FA9F5B47D7F73B5876F5E55EFC9FAEFFB8BB51F7ECC9F55B3757B37CE068E
      ED63DBCF1F23DEF1683BF52EEA67EFC9DB74311D52F6BB9CE6F3714E2143EAA8
      77FD3094C60A8B85E9FE01288D17CF9F7FF8F0E17048914D189005C353E466D4
      CFE993E77EBB1B7A7F0A72C63A03FAFD7798CC5BA08CAD05F5183B7226811DD3
      BE9D53D972274F09D29A7B66905460F58FF4B9BD77E405DE23555F84F24B2A1D
      A298D7F3B156787A44C560A5A288211D3897FA1F8C0E71E0182735FBA00F1C3D
      890F9B26AD5F4DFB84913D2225E4964AD8C5AF3476AC5B8D4DB4ABADC3640587
      89BF7598CC1FF706E0EECDC5B828F9D78189404DC140F47D6E45496684490A3A
      9C7CE424226928CBB0E8392CF9CB4B46166243DF2AE40DDBED599C9DF75400C3
      19B9B5E652A0D7BF7D7F79D5CC81739374E9B2C6879FF027A6237627449A8035
      CA348C1A486933A772C4BEA041CE49E77D7DADE23BE7E2EDD19971B693BFE4AF
      86C20C9880F946FA1C91AB08FF9ED1BF3F9E1E9D1FB0970C62E6F56543F3AC2C
      42F3E2F1973E159EE3AC57653A2C54AAC50F36BAABCAD3AC9DCB4042C46BE57C
      3E6D5CA51AB5AFFAD5799B971D7BF3D439797DF4C6A162BC51E39C28658304E1
      13F71BD071931E759DE4FD3E8118E1014E3C5605E511535F1B9334699B65977A
      D4C99BE3A6CD95EA069DBDAAB07FCFB4B921F8552A71362A9EE9D6C3EECA34EF
      9364C852934A4ADA2129804DE3F5657E1215A543BCDE55C20C5BF831F48D73A9
      695BF22DD6D739BEBA78C3CA26CB5D513E4D252361E41201A6955ABA553D5750
      3DBDADEA39AF7A7E715455231ACFEA8D4A2DC602D1B838B3EAFE47EC26B7352D
      5E6C3D90F776B3191EC837C41B44D1290E9CD7C46261F08F34846593B60CC37B
      313BBA03E75BEA7C7CAEC613FCFE4AC58F9576FB6863BE50B17EE17CABB23106
      787AA71BB9B0C70259AEC78D1AD585963CC7460D8AF2101DEA9CD3A8517D67ED
      AD7CF8C2391A0FF2316C14AD46E4A03B1A0CF2033ADA5B61DA34616AFC3864BA
      3C6783EB47F6D9E831A54B90F2F8FDC98568EA52C54DDD906CBF6308D5A250D7
      A2590AB60F18B87A7F26B0180DDBEC397FD53D03AD38DC2A070D550E76775E9E
      9F5C71FF199BC1790732B4F9E989F8E3C4A6E66241C6FE859D369C086D662997
      D24C9CBEA2E4556882CE7E95D3254F631B891EF418A184C7543860984C32425A
      112CB4FAA8E9734C37D11F3FBF3BEFD1A6449E524719B098597CB76A663CA9C6
      8DBA9830EDDCDF08FEA279832EDD19255766D88DE12DFBFF4EB2F718F7241F37
      2D78B695CBD6C8853DA15FFDE48C6EF2A1A69CF20F2C894D0C451C86264BAB96
      FDD834C97B3F2BBF98CD30E3B15348880FD9BE4C6F007EDC679E1F1B5C6C6271
      74E95FE5BA0A8CCEF01286489C4C45370167A49CFB94FAB937AF3BA60DCD48EF
      DF827A9A3CD343C1F967802D82D8C42F040B7979FA37F1ABEE538102C18999AE
      E2D6452CB0A88A522663DDD4A996AC48320C3907AF81888992BB79FCED914D79
      640AB4399C82FE71A3FAD4AE0AB426D57C147C392127C01968ED8E3CF6CD9CD5
      89ED24C161141356399023A6A44188017C9A399D9CB86A224D4D9BD8DBBCD6EA
      9D47BD4787E496A4F3070248A2BF04AC1253D96BDAF06D0C85F3B8311AA9BCA1
      72485B459E0D19518EF29F930AE0BF29E3DFDD3109B6AFB23E778DC5C93E3611
      2C490325885FEE6E8EBD10BFBAEC552A3714D058A9AA54F68E368B3B1A3BEFBE
      A31CF0892C80B95696E080E1AEA4584B10480C24167788F9984D2C76D6F5580D
      0E0497E4DECB8C254BEFD2E306020A9BE5AC210958F3BAA1E7F05270E08C4380
      B5CB19BFC273CE31A7FDFF7FFDFC9A7341A6A39CC1BF1BD78D647747F4944146
      58E45443C8C4C9C40BE9FB6422DD9D4D7853229BB67E705C050E4B6A638B547A
      B5941D7C04FB869E4D64CB8FE6A24BCE47C715FC067E1EBDE6C0194D271C391D
      D623ABE33C9FD8C8AA2886F64BACAB8EA7137E1AAB0E78F8BE4DA33DC497070E
      36E407F94D4FE22D58D54AD140771B0D9C3794BE7CBB11495DBF941283A6F112
      6AC95161E04A32811E376D94525902CD2362B03E0646A20248DABC09A1D710AA
      643E6E5CD3820BD8C48308DC6F9417A6DF02D826F93434650B11371C28C66C6E
      A2F254D5A84BBE86411E675DF0F2264B277F3989FAC7FD2CBE6DDAC87F3EEAF7
      7F757E1CDF69EA497C23FDF828166FF0DFF67F9F3FE52E9FF2F931F9AB0E6A77
      E75F0E75313AE417DD7BF81F65214F89DE8D1629A635375C6824D1FC7CF4E6CD
      AFCEAB3797575CD0EAD0A824A16AD687DACC719F9EBC3E711483A11715F857E9
      A56EDCA0C57551AF36E0634AB14D432FFDDA7715648E32144450F196B74E2AD8
      9C86CEF359FF858D8F500FF5013153D2D49C0233896F046C2E67905381219B99
      6D231BA7D7EAABC93CC9B8B1A0D93A719BB1F7A696A3FE9C12D9398F9DAD1493
      CBA809BB312D191C4DAE7153651F8F84DCCFF2E43B28ADAFCFDE9D58379645A1
      2463F2BD1A339049D503A49993397F73E2CE8201DC6B05C4AC1B5A0B68B68973
      9098BAF4479018511D159C1B61A5D483A481DD597FB6F6A2F5DBE71F283DE726
      1B5992926A0F6C0055183478F897C3FCC39DF3412B061EABA764671FEBF1B0A3
      F1E46690E7E3AD35BC8A35DCEE6DADE1796BF88BF7DBCBAAFCF5F9F416A270B1
      3F3958C1B10AC2F03259035B925F81E4B7C075F748FE8B773079455DA6A693B7
      3F80987777065C5A3250E35BD39ECBE2B965A9934C47B03738942C3544380FEF
      A9C510E13C733679C376571AB2719590F808A8432057744C1C023D317DA51A8A
      B4BD472568C48BA4E4B9D82B71506FF2693FA9E972D22789B7484F54D677DE67
      74F4D80F45F616E7026C19D40A0C6A8B2D778F417DF17628BB3B0903683A31F9
      F2A88E4C597C7613CFB179B44CF6D226F4269746AA5CD3F5F7E960649013D4A4
      99504CF758556C5BC88EF4F8D6322A4A98A0799C0E2942769E67C3A601B289A9
      7609536D77474B9F003699E5F3BFF037DA39A7399DCA9CB8EB1BE51B10269972
      180D34A19667ECFEA1F618366BB0049CA207D2BE9765939CF2D3B095A07C9019
      A2A544AB3134C7BB7AB9A76646FEC1C9479A544C7295B083CC51D72A6B5A15F9
      EE8E9069367CC6788276ACD4DDD1F61D8CC926975EC539E1FA4F2C1590378CF5
      858C582F4D8612CFAE2986AD62AA32FB206D53B47C3724B8C13EB54515ECFFC6
      2917678C4C2BE9F03C39F9E0C2C0D492C8954C57E3392228E01F25F1FF8585FA
      D61FB16819015FABFE81B52E781D62DCB98583FD84C8760F83C36D85E93D89FD
      C51B2091BFABA00E7E7A3C59848818E3738A2BDEF79F6E49FD01526F6F497D9E
      D4BF78A78ADD1D6AD20E827FE1A4FD5CBA5B8F482F63F1A7C659215D1E48C6F7
      29336F2F9DFEF6DBDD1EF5ADA48E938A5A2815140CA2F340E9B1738FC17C233D
      9607984792014BC94EFA1F53D567441D88CD7C7A7D230D936D42A428C7BB3BD2
      6DDB06F4551C4FC784FB82BF8D8AB2EF3BD1DD443F9D7FB574DE3C745E4AF214
      67FD11883B1502C59231CE59537C5B21CAB5B14DA951A9199F0C5ABC09FCC9F6
      ACAF70D65BFFF185566971B5DADAABE485B347AA5C232C0AAFD10A276BEF420B
      F51B734F828D8787877B7FE2DA7CD106ADBB3B54D74DEA3083FC9928B194DA65
      DC423DBB96E8F164AC359BBFCFFEDD59B66C66D5167E2DA75B3C4D6C74D92FC1
      262C4A52A4C9DFC40D098D292D6515D2B1971AF4DD71446E9C25B5D60F5C5538
      A0F523AE109B3AF5A46CC14BCF784A49C9FC177330AEE770E42F6974C32E48E6
      477616CC3E29E7B3D0E9B42F19CDBB3B53313106D8D08C9A8A410B9F52947A62
      73D9212A87DC5547F476DB17713A998EF501E366AB3EC6F2410D3976ADFA1FD4
      5D41D6CD7B9A94327ECEB2B1E3BE3EBC3E7424F7FFD53BEF5CB0A0C032EF4C03
      63FA62880B695DFA6A34E20BCDD29AD878555D69467BE0D8429581BA25FB616C
      12C08765633AD891FC78321D688B4C2EC8EECEA4FE02B2A8E925F41431D8A427
      1FE6502B1D99CF078A96116E3483A6BACA19FEF1E8E2EDEBB7DFBC78F4942348
      B5D241426B58A356C559D1052F842CA8D036AFA5C99FBF968ED02C9A04D69F0C
      38496BC7D2DE0A294BAF497904AFFFB46052CA0AFB2939C8D9EA2BFB9F30F9D1
      DD8986459FA8F95D1D6AC1AEBC315DAA0774D84846E72AE14341CD07DF792C07
      CC0120C85EA108399D657BC262F6D4F0F09564E65B3C17487B9C4212F365F2E1
      11E8FB60B63D29D1097BF16941B2BE05C6679CD1BE1A13474812AE2B501F20CA
      F71886BDB664F8DEE45D53B3AAE9887EF3BF7929D4369E0AF2FC7448D16EE584
      7E84B9D95763C37EE444B1AD09F069B5C03B6C39A73F9D9F5EBC3E3B7D7B75F4
      666B0FCCD903C1176F0325C7C5085852B1C98945891252D4712FAC7C60D47FD3
      B162A076778654BB69DAA9CEC85FD39E9E009912F07D118A38BA7BF267CCA54F
      8621EDF1F15474CEEE38670657C7C48DA0894F635B1A35CAA9C63FA31A48883D
      6DF280DFEBB261F0DE3163FD93C3F5944BDBF6CABE464D4B58C98D28671FE4B0
      C65F70D8EB9015A5DC1DE4C5C4825C99EE26C62A1B6835B43AC3EE0E382FB3B9
      426BDBF8B6A01607E073F50069A962245942452EFCC51D17A114BA9F3AFB944A
      4D7B3774AA4A926270E01C5F5615BA9C52676C28EB2D8E2C4BA55940B778CD09
      AB2520257D218589C2D4EDFE98B27AC17EB42285F9FAB3612E10A6183E1D8881
      1609C6CF65F5A7FEF0DD1D3A50B4628536B395BAE142343F485A2CCEADD62359
      7F7A72F174E6ED54BC547BFD4D46F45F1F00BFFF6A66F4A6658DF8C49FF1E5E7
      DF5C9C88B2AAD5B84F60D0B69358C34891AA16CA895804D12C6135231B3C1A22
      D2630EF9E5F49AB2B9D8932F16BE0936C7377916DB3CCF484B15AF856D103DA4
      6153D9DDB902C97C3F94923FE683A672B7DA1473A045C13AA7F00214A3E36F2F
      9C9F5BFCD3F67F25E23C9582B273C53CA2528A2E71A7F9EE92AB25B06EEF46CC
      3DB972426E307A125E73E87C93899BC6E8742379A58DE453213AE7C8E24CC81A
      575D41EB6E9532CA22D99BA240F2CED8CAB50FD422B48FDBD82D94A5954B6844
      6745305D6ABDAE69752441574A9BA5F883437125FBC18338A69158A96055E8A6
      898095779E991C79D4CA05E53A0012D5925DCFD2C22ED281C31CB09FDD4A85E0
      9EA00A3B4F5ED7E5AE847F9EC0BC262953C94927C99B97D72D2B55156B98C34E
      4B42E9401F0AA71E73678F23CC2A8A3A1BD34196115A17B1B3980375065581E9
      D55C9A68F321AD2CDB534271719FD2E0C5F8E51783DE84566B95CB372A11E2E3
      92E6AA24636B202C3510DC6D38ECBE4DD080D61EDF90BFE1D21634EF7F737679
      F5548E109D38AEA42F197B91F7DF73CF372AB5C8A56E9AFA251FB08F4D246ED3
      D8C99189F11BF970A1AF45852B014038AF5666C8B68F182ECA7945A103B9797B
      BC5738DE7F6A58E08BBABEAFEA0E2AE335DEDDE10A9681FABB69E56865ACEA67
      933BE3BEAD19DF112BB514C232691A59B1A0C9FA96F03E4178EDC36DE1FE3DA9
      F2C53BC808C6897580A7D9988C747215572158080CE866ACFEB272DAB04DAC66
      A01C97EC90D9D1732299EAB39B861AD129C2226FD814C8D22FEB702935FE3A1F
      DF397BDF66094C03B290CFF2C4F98692E5F76CCF0A28D29136903A2CE11B3625
      06B0B53D433003AB7F38E0B96F498F11722347D5B59ED49C01F4D950022B2036
      C5059F5557A386CDB284531BD12995EE28E70AF6FD37E3AC7195004758470EF3
      ED4D8704CD35DCB38E4832A6D8C920B91A268F96425046A56444D6864D6777E7
      72DEF0DCE70E77DC6123E35899D11D615717B7D9E8801C8FA6E8E4C0393C7C6A
      9285E37A749CDD337B97A5C1B97750FEF5361F6AF188EFBD26D7F0C42947B0D7
      B0C551DCF199A6369500B6E492DA8A1B9BFA9CA7691693E3DE9454376C169C16
      95525654C5E46366EC1FC63945232DA61814A22A5580135F4BF05D710864633A
      A2E4B5B2CE696589639F930E64659EF2EE1AD7BB51178540F8690D5B1EA8127A
      4C15E4930F5ADD5611094D21DEAC1818592131FE1AD243DCA78F4A077CC366C5
      928372C4ED8E67F722157B659B4AF1AD71F3BAB1B8C4F79C7D107FE1FC634A5E
      54E54492B4A6AADEEE6069B1162449D2159E1E3A478CE1CA1EA932889DE0B09B
      DE5C181579EBCCCB12E7E5DDDE4CA73CEB74AAB55AB6A9F955CDFCB8BA9F80AE
      CBCC808696FE9F55CC82DCBE6A34EA5378CA605B4B14DE26E0C6D9389E0E48B5
      8A9BE8A39CF74172E9CF38FF60FD0CAC7B3B0565E694F94FEC55A16A0AC2D9E7
      CC82D283FEA1A8CA0B381BD2BA1E04AF89938604B063A007F9A1739997893824
      57B52A32B61C5552753B1F3B519EDF36ED24523CE18E3240AF9DD74FDE73C1CC
      75CE4E551511C7FDEBB6B4E09336EF36DBFA9ECDFBC551BD67FDA8C4DEA46626
      A9E546E0A8366CE35ED9481097BA919E724E416F4EB238CE8789C11760985DC8
      9484A723B5538D33784B7BB670F659371586C2BCB44F3D529B86854FC686F5BB
      D71240EE5B15A2B63CE56D906CBCE7527ECD3979CA399CE8C2271153029372F6
      6B19142E883647644272735E6E495998606FD5C177DFE8EF16FE8AC28E235518
      5FBF299B2B91A39AB698E756951B7326228390D70B7C68DDC49F53AD8D81C4AE
      FC3AD7D0CF56103FAA0DCE56F4DDA0877F49363F9EF7FA1E5FF2DA41AB33BB6E
      66BD3A6EAFD7F3BAB6B5CDEFFFF5CBBFFC425177CD6D3983961FB5BC96DFF65B
      AD5688FF77257DC005FFD5BD44B7D2284D53935210B75CFEAF277F0791EF8569
      A83B7E18D0BF411AF89D5EA715061D2F485CDDE9864918ABB8D78E235FC79ED7
      6AB77051C7EFA671D7D3819BF86A77A717472E5EDE7503DDEBBA71A7ABE38E72
      3B71DC8ABBBD9EEBB7C3B89774235775820083E9F871E206BEEFAAAEDB6A8761
      ECC649CFF3D24E4F7B91F63A6E94B4D356270A62AFD7EDC5AAE32B95A6AEEFBA
      788D8EDA91DF09121524A9D7F1D3A4A792DD9D20ECF6BAEDB66A77BD386CABA0
      95F6BAA91FA94847B1DBF53ADD4EB7E5E3613D15B82AE8443AC41C318EC8F592
      AEEEB53A6E3BEDB5949FB8A9F2BA2D378EBCA013BA61B79526584E1D27187A3B
      89DB5D1DE1296DAFABBDB8E77B4947072D2F0A7777A2563B09BA5EA2B50ED21E
      96C1D76EAF15610C5EEA85BE56B1AF7CAFD5ED7A9117B77A58381DAB6EDAF3B1
      36ED1073C39F51CFEDA481AB95EFE22DAA1D27412FC64AA5BD762F6AE96EA0C3
      00DBD2F602D54DB4DB4ADD56D48DDB6EEC45ADDD1D5AEC208DD310B210C729D1
      61947A514F777B187E9484412F8CA338C17C23B7AB3BB117063A8E318C769AB6
      FDB095065EAABB6D2FF1E218C3883AA9D04A4AD4037A7988CEB01B5803D5C163
      E5C316548236FF12194A4B3B2E682CEE786E0ABA32BF778990D250116561FC1D
      9D768328C132B63B09D61B336B83AAB013A90A7A2DDFA3EDE924D890B6DBEDA4
      61D775DB51028AD0F8D74F7777626C6B4B4511D619CBADD3B4A37A5E926AA5BB
      51DAD3ED9EAF6975C29E52AA15C69E767D105E1C855DDDEE845E02E24C41C1BD
      6EA07CD57183168603E2697543BC17EF888880E3A095B49587654ABC763B5281
      DF8D42AFD50BDA2E7621ED76939E4F57B94AFB6EE8276DEC702B7131A020893C
      3F745DBF93AA4EAFDD690769D201E57569681A6B8693E1A5413BC4C1EA781D4C
      457753D58D7B690AAAC11AC5714FFB69DCC6FDA91BEBC0C7A68438323DDF8F43
      7C156204AA8D73956A2FF0A20434DD0D03A512BFAD93561444A0B8244C13D99B
      5576368C3ABD5ED80EBB86637455C949F8079C036F009708DC547EDFDDA9FF45
      BFFB091EA0F1FF0EF88A6BB90A2613FB490B7BEF1257C19E7612D5EE747A2D70
      036C460432F58310873E8E948EA21423F3BD5EDC567E1BFC052BDA4B41D73881
      DAEB7A5E07B631E8184726DADDC17CF00B36326E755A49578501588EEE7689A8
      3BE037AA837DEB26CAEFB6636C541CC61ACF6CE380E95EA7DBC68A477E17072D
      49FD1EC8D20B3036B00AD0202823898224715B491805605581DBD6D88B240934
      CEAF0F4201ABC3083A414777B19B60DEA0327C898960435BAED75D67FD7DDD4E
      FD56D261CAA6AFA236EF403B5CB6FEF2FBEE4EF597D7B66BAE637094B44BA725
      6CFB912642F2D2563749C0DCA228D43EDE164571DCEE851AD7F722CCD48F7D5F
      FBAAAB439C81107BD609C1CA703A3BE0AC98934F47C58DDBF86FE2E1720F1C31
      494107382738657839CE708AE58A7018C25EE0C5388C490BF77A41AF07861E77
      920422C005AF7371FADA01B8AB4EF18C1E785802AE92C689DFED75549AC4AD54
      F53A41D7C79E63D140DDBD5EC7D55E0F473850388EEDA8E785D8594C30A5D3D8
      5138C22A84C069C7A026CFF7835ED7EF1135B9E0B6184E92B4522F8DBADDB813
      76BA90135E1877B1DF3DE2D02D15B6934ECBD349E4824FF7F08656AC3CAC93DB
      C3F2B5BAA9EE81DD6030204A576B2FEC75DA6D5C116259DBA083C40DDD049F29
      1507ED16E4287805B896DF75896FF5C036DA74BC22B7051205E7C2A640BAB514
      3D0627DD8FC1CAE2B0936848B7306A63352140B40B11E2FB1087DD0ECE03A438
      06EE8561D2EB8610BB5DDD021BF374D471211BBBAAEDB67427F57C9D04610052
      D2B176494EB96E02D1DE85844CD2D05560BCBDA013A7E05710F5109B295E077A
      21B69982DDF6C013350E622F09A02C40CC610571670C52C73625A102AB5029CD
      A9E5F96D05825081E742CD8A549CE2D8F43A1DCF53D040402F695B81A441483D
      681038639E1BA5DAA5158903C8ACB41B92C8EEF9D8F2089F422CE838ED74B087
      105C7E04C6ACD20E5497160E16D405CC063B41E41307505D70CA212321423A58
      D91E34147C0056E876BBBD962601D2D54147256937C6F9D561AFD5EA117FF7B1
      FFB187DBC1E7415458CA6ED075219DBA20A7C887300A416020ED10FB05061277
      340E3F0EA1DFC35240E0BB5072D290A8088C2068C581A7152440BBBBBBD3F630
      9214DB89858D70BCBA2A203D8336A5A77B5E0FA2A08BC7A74107140575D807FB
      86EC03B7EEBAED0E98039135CE5A3BC52A61914262F8A0628CA145FBE1B6C234
      D029560E3C0C4BA0230DC9D3C56EF81D88BE7877C78B493C43F842F8273E8819
      FCAB0B3D4DF54295061028187BAA71D894EAA52093146710AC35C5CD10413E34
      C334D638291D104B12D12D3DD56D83D1BA01C9493C3485E5D84DDB7809FFE541
      0FC23F105C101601CE020E0FE42E54511C04EC8C1B24318820C1016993128895
      6A753B3ED61D1C18634EC099211740E750EF203BB1083E646D1C431D6841A807
      B82C8C68A2ADB6DF26AD15E40CD10A9ED9825604914C0A69826141EF4AC1AC40
      07DD18FA50DC86A2896783A98081766330FAB01B75A17144D86E2859180BD4BB
      2E081BC387C06D07901249E263EDA0F6FA5009521787075C0C3CAA05D5B807A6
      12C4A982121882FB9006D7D5501FBB0A0F8A5D08A63674B1D8073FE8462DE8A5
      5117DCB90301E3B614B45C17DA50EC42B2E09A10F7603B21EA31BA1873578182
      7690F4C07AB0F92E74F0368616839FB6C1F7BA909441BBE7915C525D08978EEF
      FA0931D12ECE2014580FF4118357631289D7034F2435171CC2ED2ABC0B0CB543
      0FF663174A0B04243EC54154AD1EB602BB0E9A077575B04A3D0F63F3A1BF795D
      909AAB888982E8C0DFA06841FD0D92AEEF291C784891A4A57125E60CA6E58263
      410385B883AA0C410DFDA09D92C100C549D3796672A7A3034D06FF07BD63CC10
      10607909B4815607DA69E2271867D2757132FD5EAA3429263EB85310C03A8820
      2AA1C582323CE8885A11370BC1ECA0CD8151437D831ADE6BB5359E97FA1ECE02
      56A8AD2097236C1274477047FC0A1E0C0E97820183970520073FC0A9F4E9A841
      36E0CC241A141F8769EC296C63043AD7AE07969542DE803A306C0C1EA73489C2
      20F27036C0F2B4C68171C304472B25CB838826C508B46EE12FE8CD60CEC27DC1
      BBC1A0758049401C4266A5BD147A1106D489F1EC36988D1BE179383BBE0A3BD8
      B316645E0FEA3A09042885605DAD48B75407C68317B6A1BD27B07C4037605E38
      6D786EEAB63D1C8056270447C2DE45E0D6A0E31EC40C7617C7D6A32B71295811
      068A2786294C601C1D85B7C114C2FE254AF7427070C8DE1E2C3AB00F185E298C
      9F88A4361806142E1C408847D06D1091D1D4816AD273313968A138299D960FF9
      0DC994443DE83E581C0F07C86FC5A43DE13081C7424386180177822583130FB9
      04260F526C416DC0CAE3ED11283609A01311A982E582C1C0CA226B924C276832
      1D18973D68726DF07C1560DE98478F245294C43134F35893D50655070A4F18B6
      4205F3BB456A001877404A297422C864C850300005D98EF31E7850D1039C4F1C
      48903FB4220C198A460802F4FD5608ED3480DC81150A65BB9B60E36037E2D300
      82096C1EA21CE214670D921C8FF1028C2085150BE51857C2B2EB2A6849982156
      0A8B87E14315C082A80863A3BBC00643E8501DBC0E04095E0F49A015B6B30DA1
      40D64007A72A069BF6431C561DA6693785BC81998BBF204F61D16075B17A6ECF
      5350C413B21B4115D08D6266C85076B0CA3013C1337DA8AA8ACEA61BD0E989BB
      38482174030F5B0579A36102616FF0950E71A6A0C8812F059DC453C42461D8C1
      C2E910D9A81E1EDB851821EDBA037D1CE4087EDB81F1DE211D03BB40162D580D
      49409C7E1706B3C2982035BCB68FE76AE81F6E0F6C3584B202010E660C2507C7
      1BC61914CA2EF60A4BDC4BDD4E0CE3C7875C6EB77B490B8B4EA62EC419C64273
      D601E42C584A2F88B1505035B0DCADB88511808BB83DA8A3D8E676E07B3E2C79
      D8D8D822EC0B74B23056A4A3C1264B70CEA1EB81D2C83A07CB4F209268DD7D98
      76B0337A9E075B2082BC532E480BD6099814987BD46E4161818C0FC08A12EC43
      D4C1D1200F0596CC87D59690F6D2025BEEA5B08C02703B8C0C3C45B52358ABD0
      1B883FB4A2D885AEE4BB11944048ABA4D381BA0CE60C9B171C075BD623170E69
      2B51070CB20DF285A4819C61CF082C12AC3F2C295884981CF612034969E2A427
      E2951020B02BC3A40BDD15D6928FABA1DFB8501AB003A10F83B61D6379C003A1
      254387E874C03FF04188BD877A13C34A0D40BF30C920F8B12F38E590AF9A8609
      3D0E4648BBD38B79FE490479448E2DAC4142222E01258209C7E0E63009C02540
      B11869DC6EC1DE895A2926EEF63AE0CD9E261390B42848B744E30043E5A0B306
      9B17CA51D8831804EDE0FC41638B740033116A2B391D68B97B44DA1ADC1BDB06
      DB890E0DEC9EC4A711800E30C11082013BA652EC05140AA83DD0D2C084B1F8BD
      44A920D5603D9EC2933B385F6457838A60E063C921151474A69056187B148071
      44E04B1D1C5198F1F80C4C06340C6AC0FC49C8802C415021D86C0C450A3A30EC
      46E83590B0B80F2A0FC4124680355CD55A6C8169F55A3D1AAD58E991589A6EE7
      616BB1F2CE40367ED2729FF5DFB00D4F5A090E064EB4DB2177491A8283448A2C
      1ED053D2EDE2221C1D3294B4EFC13024030966711BB6480233912C9A2ED42BB0
      32F003DDEB41B98D7A1DE8803D28673854890663C2590635401AE102E8F63DD8
      1890535D689DD00161884302747B49CF832888B0345D308010FC55276DA8303D
      18BC6ED72783CC87E983B77950C33B38742E042A5470E828D0CAFD143A120E14
      0C4C056D0A968EEFBACA5350E361BB450984170C119C5AF03672CB41DD859E0A
      2A0EB10190EF90226D0C3F8049415E1B2C03F4B06E2F047D424CC2FEC206435D
      052B81CA483C4A91FB21C6318332A7E8A4FB312C9600E4040A87DA233B37B3FB
      90ED6E420562EB7B7C1FFAA97B83A1A52DF5077F6A0CE40D7CC817B8E8C76BC9
      35B3945851DAA7DEF9293FD5A21F1C15F7A15351F7A12C3E099F1AD5A7BC378B
      7E2093CA516117168C6B9167E75323F914675838121CDF87D6A7EED35D9D67F0
      488356B50281FC3F305EB1386E29FBD5EFBB3B14EC88F37E3E2E620A790C0C7E
      09ACCAD43C197C9ADED4F1C05A41BDB0A95C5A17987F2EAC621CE090A8DAC7B7
      302DE9DB00E2DE87D5E975E90AD8FB3E8F98FE8DE90958575CD5E911D5E35950
      EBA1772A8A2C800D805777603E9015039DA22563C059F1F01DD97330003A3EFE
      D7828695BAE4A4F0CCCAE0CCC3384A3B3C26735F18D21AD277BEF9D6254E013B
      CBC5671D1933CF128A9C875302D330A5EBC31E9D509E21EEF0E4CD506B30739A
      930FD54A3EF3C3483EE3EBDCF23AB7BCCE2DAFE3CFF06C1A33C783CC33663EA9
      AE61EAA4CFDC7B57DD7F9277EF1AEFDE35FEBD6BFC7BD704F7AE09EE5D13DEBB
      26E46BBA58715AD148F6C9FEC5DF6127C2D89FBD62EE335C075A30344981E6E1
      A498DCF575F14BBF488A4936501FBD4E407FF4F3F8562789A666EEF84A0FB21B
      CEC6B69F4C87547F4EF9A6F6937F480A9AFD7334CEF27136B9C3DFBDDE7F558F
      943E744EED8EB653BFBEE554D7B69CB78C5FFAD7A557F766AEBED112386DFF75
      776776D8725735E8F6F2012C7EA4FBD7477EA0F7D80FF41F7FD2C1638F317CEC
      07761E7FD2DDC71E636FA507DABB321CB18F2B53F0EC5DAB11E9EC3DABD1E1EC
      3DFE06F7041BCD68358299BDA7B3C13DAB6DFAEC3DBD156764A9C39B258F491E
      639BFFE00356DBF1071EE0FDF149AC460D0F3C603536F3C003C23F3E89D588E6
      8107AC46410F3C603D362182D1793D24F084358F569AE79321F743D71F276BBD
      550D719F814A5CF75E62877ABCD62D3450DCB209E330CC77735EEE05334F8D15
      77505C6BF8D2F93A4F9D34BB9E8E75B1E644F4F0BDEEE7A312366EAD7797378F
      F5643A5E6FDC257D9439FB9B1249F580F5A6CEE9E35281BCD6AB47EA7AA3FBA0
      D7FE8109DBBBF948AC37D19244D47472437497E9F5F679A0E271BE1E55E66AAD
      D361EF7B9315EBCE8E6E715E4EFB7DBD1EABE0FBDEAEBF8D7CDF7A4A10DFB2AA
      109CB9693D25886F594DD02D58BD4D2665EEDC686EE6DE0DA668EEDC60A6B2DF
      9BCCD4DCB9D14CCDBD1BCCD4DC192C374EDBB3B6EC5536E9AFC7588EFB399569
      AD39AFCBEC7AA80889772D8D64F61927A6B72EA5D85F8FD5E8C679950FD73BC4
      2FF3E4CEB95A574B28EFDA4CB5E19D21B4E76C385D6FAD67EEDC840ACB7BD7B3
      A866EF5DD5885F7CF77AA7EECCF47BFAB652CC1693F11C794DA3C9DA947CA9FA
      53D109D69CE0899AACF7A68A805E31988321A33FFE883569E22D6904DF1A39BB
      DE9CABF7AFF7CAEABEF54870FECC6DFC5A73FBBA8CF825FDB23EABF8F68EA090
      B2E1ED5A77BDCA09994D27B3772F247CD79DA5E109155D9BB92DBE6196E19F0E
      4637AAC8D653E84EF278CA78E4676AB4D68DE754CDB2FE2A9E3E1B50AFC34A68
      ACB777DF5E9DBD71AEF211E9B084AAB5DE0ED2CD2FA9A472B0D1FDC608DEFF51
      474FD77FF11134E7E1DD6093091F6D6091F18DC7D99AEC4CEECA930DEE3A29E1
      913799E277FA2ECAD53859FFBDE7B0A2F8704CF406775F2AAAD95BFF3EAA0AFC
      8043B8B6BF80EFFE418D3332C53621BFABB56FAC59C8C534FABB8ED73BB26FF3
      4D8CB17752402C2AC36A8EC785B7AE271C666E5D4F2C5D09326C46F4B0B6437C
      E6E6F5863C73EB26433E667C8955BDBB8BEF75379AAFBDFB8F8C7A3D53C8DC4B
      E16D6A20B2D194EDCD1BCED9DEBED1A4F3FE74302C361D37DFBB0975D97BD755
      9566EFDE70ABF8DEF56C05B997509D365A2ABE71B3EDE55B37D95ABE719315E2
      1B375E9E5563110B6E5D2F7055BB71BDE895DCB88118A8DDB8D95E6E2C043670
      B8D56EDC642FF9C6CDF6926FDD642FF9C64DF6D23B31AD8D376364B5DB37DBD7
      DA033663C2C3891E8CF2B11ADF6D70FB695F5FAB354D7CB9F37C9CA7848444B0
      489BE917D368C2CAC9C6B76E223C60EE6CF44ABA6FB30DA63BD7F42910007A5E
      B34797443E2B2EB6C184AE289F6EE17D35A338D6D4C55C8F65280F58EFF794EC
      CB918A6D94C45E14CE9AF86F183BE9F2A60AA79417B6175CC86AFBCC55EE82AB
      CAD528AFF266AE3AD349361DD8B71A5228AFF51FBAD66E7F7975B0E8EA9A6C28
      2F0C975EE8CE5ED85974614D73282FEC2EBD70EE89BDA5177A33177666F7E644
      8D6FEB865279D9ECCE94FAE3A25DECB88BAFBDB7911D6FF185F7F7F20102728E
      E2985C3FEDD528A9BA7C6E539711D592E73F4C5D4B6E7A98CC96DCF400B5CDDE
      B1EC3C5FE8F7595179341647EEFDB9E917B538C603DEBE5932FBDB3437AE9AC5
      2F99DDC6D79060C342D7EE5AE5E02C59A5074ED0D22D7FE0302D79CB03A76AF1
      1DCB8ED792AB1F3E654B6E7AE0B82D9BFA43276FC9D4573882EE7A47D05D8DAB
      2FB97CB503788F77AF7604DDB58FA0BB3601AF2E0296DCB102F9DE9BFE0A04EC
      AE45C0EE2604ECAE4DC0EECA8263E9D45720606F3D02F6D623606F1302F63691
      20DE1A1ACB9217AD40C0DEDA04ECAD4DC0DEDAFC777EEE9F22606F1302F6D626
      606F6D02F6D6E6BFFEFCB67F8A80FDF508D8DF8480FD4D08D85F9BFFDE9BFB0A
      04ECAF4DC0FEDA04ECAF4DC0FE5AFC777EDE2B12B0BF3601FB6B13B0BF360107
      EBF1DF605D1D3ED88480834D0838589B8083B5F9EFBDE9AF40C0C1DA041CAC4D
      C0C15A041C6CC27FE7A7BE0A01076B1370B0360187EB1170B81EFF0DE7377C35
      020E3721E0706D020ED726E07BF3598180C3B509385C9B80C3B50838DC8480E7
      A7BE0A01876B1370B8DC166FCFAE83F1ACCE64DF2CB6F867E7676DF8F2C6877C
      0CED45AFBC98491F5F7CA3BBF09DABDC39BB482FF3FC768D94D2F229B374F932
      8BFA59CE9E91BB3F524A37EFD57D775CE6BED52FF3EF79672965897DB9B326BA
      EF2EBD70D67CF2BDA517CE2A9DBEBFF4C279BDC30F965E3ACB46FDD9E3C4E46A
      43396078B3D786CBAE6D2FBABAB3ECEAB9E977975D3737FBDEB2EBE6271F2C9D
      53C0FC62E6B1417BD9C561798A676F7097DDD0597CC327976DB18BE781F55BE6
      477A602997BC63F99A2EBEE1534BBBE4AE15D678D99C5659EE25935B75DDDD75
      D77D65025EE6FD5861DDDD8DD6DDDD78DDDDB5897CE9E4565D776FDD75F7D65D
      F79539C83277C5AAEBEE6DBCEEDEC6EBEE6D46EDF744C5A7D7DD5F77DDFD75D7
      DDDF88DAEF31FE35D6DDDF78DDFDCDD63D5897DAE7ADAA15D63D5877DD838DD6
      3DD898DAE7E7B4CEBA079BAD7BB8EEBA87EB52FBBCF5B0C2BA871BAD7BB8F1BA
      871B53FBBDC9CDAE3B5B442B2B81B5AB1F94A1B5EB1E64E1B5EB1EE420B5EB8C
      0AF820E3A85DBE9A1258BB613525F0FEB2ADA404D6D76FC90DCB1772A9D6B87C
      4D575202EF2DEE4A4AE0C2355E72E70A8BBD7472ABAEFB834AE0A2755F998097
      DCF0E9559F57AC565DF70795C007D7FD4125F0C1757737A3F6797D6B85757F50
      095CB4EE2B7390252AD98AAB7E4F755C63DD1F54021F5CF70795C0E5EBEEAF4B
      EDF7B4C64FAFFB834AE0A2755F8F852FB96B8D55BFA73EAEB1EE0F2A81CBD7FD
      412570D1BA07EB52FB3DADF1D3EBFEA012B874DD1F54021F5CF760636ABF37B9
      55D7FD412570D1BA3FA8042E5AF7705D6A9F57AC565DF70795C007D7FD4125F0
      C1755F0FC3EA0CB7AC5FB2773950E3C98615B1DFAAE266A2D60303F97E38D645
      DEA7C66E76C0BF73572F6AE8554CA8A55DABCDB8982DC1026DB5DA06CB7377C7
      A7D6408C1EE9B9AE0E3CBF1D7483AE9FF87140089BEDD017DC4D2F240CCC853F
      A13C2969C569BBAD5BAA1DB5DB4AB7972381CA8F47BD2EF0C854A72923832E43
      316DCFFD77EE0BBA3F2D116AEFFF5D7EFE197F0879FDEBFDD9CEFEEBFD5930FB
      C4FC57FFB923F9123FDBBDFF7A7FB6B37FF82780AE11A6F2FF8E2FAA870F2D24
      D4F277071F747A9FD21236FF6154F460B9DC6FC5A14A7ADD6ECF4DDB09353209
      038CD46FF542CF0DDA3A58F6DC0837EEEE0489EBB73AA428B5DACB348EA6FC2C
      5D810D7F76771E73747FC6CF63AEC03FDFECE9E7B1566083D95BDBC3FCFCFEFB
      FF0FB73C681A}
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
