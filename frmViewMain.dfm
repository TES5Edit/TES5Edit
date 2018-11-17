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
      789CECBD7B77DB489227FABFCFF177C06AF61E4BDD14CD975ED553336BCB7695
      B7FDA86BB9AA666EB1CE1E9048922881001B098A62D7F177BFF1CA44820F01B4
      65C9EA45CF944582402233323322321EBFF8B39F66A376DF0FD428F2E371BBD5
      39EAFBB10EE99FE16CDCEE1C75FAF321DF316AF5F95F9DE9C928180C27DDF651
      EB88BF46097F3DE6AF93B0F07510D2B3F88E6EEBB46D3E8F14BCF1B49F4DD454
      D9DFECB7D55F87BAF5677F94C4593688E043AB0FCD06A1D71FA5C9D48FFBA3E1
      C44FB5CAE0FA2CFD47E7CFFE5FFA333F4EB4F25A1DF8BFE356B775D4EAC17F1D
      F8D4FBF4319C2AEDBD530BEF033EFEB74FD064C736394D0295AEB6D92EB67902
      ED9C51DBD8660FDA3C4FE669A8526CF56F9F1E3F8216BB5B3AD959EF2490B205
      0386FF4EA0B3D8E8C9A78BE5749044D4B7763EDE388C6E6E68ED7F9F7E0DE371
      00FF696EABB7A55BEDEEF166EAADB4F9E9A7B7D0D89BF067BC6FE44799F73F7E
      D29DF7C3F933F5C98C7CDB3B36CE0FCE0BCF0FCE530769E94F0769E87B6FFD6C
      429DEE9ED806F522D4FAE6064734291D6ADA341885D022B5D5EBEE34D303E8D5
      59B1B124D649E46B196CAFB74BDF06B260F83F588E9F2ED43851DECFAFB97347
      5F3A3BFFCB4C0FB51741237F2429501036E46DEF1A1A7E3070DED0FEAA6B0BDE
      36099DB775765B14DDCD8BC27B138E27998C66E0B6BF6D037F019781F90863D3
      FE4EBB6487F9C8DFF0C5ABA9C27CE46F3BBEA54D6A66226FF9E4F667A277BC8D
      3D774FB9556FE531EFFC253FB9AD371D9CD1CD4F2E53C32DCEB64DC9717BCBC3
      3FA44A5DD29B8FB6EDE0F67167CBC31FE7293FBA756B9E9C6C7974FF473548D5
      E2809FEF6C7D7E1BB9F69FA5FE201C1EC8C88FB66DA7F6E9F196169EC38A0B87
      FCFEAD62EBB8BBEDFDBF842A8B7DB8A8780CC7C7DB38BF99F3B6E7887133DFC7
      275B1F93095F79CC4EF6F1D9B627CD6C179FCC67FAA4B5FDC9CE8627CD349FB4
      B73E27F35C7CAE30C7275B752033C92B0F1727F864AB6035335C7CDC99DD93DE
      F6E17637BD79756ADBA7A737B308CF7032EF57A53378C3368ED63D2D670CAE7E
      42AB84B59ED372C6507C7299CA2BCB9942E1C17C9D74CFCA5942E151B350BA67
      E5DBB1F0A0992D1EEA59F9762C3CBD3661BDF63669E1929905B4E1BBED6D5AA0
      4B5F794448DB6B9F6D79C6252D3F23546536DD696D7DAEB3F29C2169AFD3DEF6
      8CE5B1E699C2BEEB75B669323973B50FDA3D470F76B73DE84C223F5898BF5E67
      9BD2EACE9FBC716DEA4E2AF151569273A159898B9A87CCF49D54E2A0F2546102
      4F2B715079D24EE169251E264F390CAC775A8983C983EB243D2DDF0DE69C9033
      9CDE69F986C89F32243D2DDF11F6A19CD1F4CECA37847DCC92F3AC7C47D887F2
      2D218A52F9A6C89F2DEC8AB3F25D619F74E7F0AC7C53E46F5C9BC2B33209F4BF
      5645908CB47046DBD648A9565A68659B3C29D150579A696FD519CB74D5B571B5
      B7AA8FA59A6BA199AD42AB9A165B686BAB08ABAAD1165ADB7AD4AAA2DD165ADA
      A67FECA0E9BA87F24EC9B1BF9A664403764FDF9DD3CAF29B0ED8669D16DAD8C6
      8AD605BAB421ABD46DA4BB95C7AC49786EC45DA38586B6329C3591CF0D99155A
      68642BEF59D301B891C2FA2CB4B4951BAD2905D252717516DA3AAAAC27705BCE
      DA2CB4B34D4CADAB0DD2A7D595E91A58BA9FC7ECD60C35DDCF67776E33BDCF66
      77AB0D7D26B35B1B58EF0BD95DA1AD2F6177AB6D7D3EB35B1FE32DB03BD7AAD6
      FB12099AB7F2994BCAC805DBD076BB4B85455568E88B2468DECC972CA9F5D17D
      E1A22AB4F5A512346FE94B97D49A21F5F85664E88ABDF4B8BA04CD6567FE7475
      D999AF4CB78193EA72335F918506AACB4B4752E68F5797942B2BB0D04A752959
      58798536AA4BC7A25CCC5BA82E1737AC34D7D47DF2D9ECABD0CA174944DBCCE9
      971D000A4D7D3EFB2A34F3E512316FEB8B0F0085D6BE887D155AFA52F6050D0E
      932849B341F4B77EAA82567F0CB312B7FA8368AE5AEB973A4747EE45F87AD3E5
      D6DF1E3FC2CBF87D43232B975BC58B79231B2FAFBC929B68774EDD8BF0F5A6CB
      DC327EDBD0C4CAE5957BB734E1BE9087DE3EEBC84FF0817E3AEB54A2740B27FB
      2F1802319CCC9059743A7D8C9EE8FBE240C3D809FB05C32CE4CB91671E9CF9F0
      E03F22AF1F85AD7E0AFF69BF0DE249479DA333F8773A8FB2767F1106C32C9AF9
      697F91FA3378CA87CB7D5FCFFC6836F1F1433C9F8280F2E759D2F7833FE63A4B
      515F8706A1A711FE1366FEACE5C13AEFC7C93F60D525D32453DE9F7D9D2D23A5
      274A657FDE5D37FA6916012D4643DDF680222DF80F49E79BC015E84696F20D2D
      0FBACC843551254E400911BB8CD6FDE1380D037A2C9E392DC4336CC3EBEB585D
      67D029FD8F51924EFD0C3ECDD23049C36CD9F2DEE1250CDB806EE87691448376
      8B0885FF0E70D06DF8C67F77225532CF80382A52572A6AED40B881A11D28C95B
      6937E8D3EF9BA877099A0DE839700A643AB60C0D5BBBD16FE06B1524714B4809
      5DD3D0E7CBF6D1469A9E79B8E8521D06EDDE69F7A47DDAF226CAC78816AF2D74
      EE7C7D3AB73F87CE40A91BE98C94DCBA4A6F89BA1D43DDE35DA9DB11EA76BF3E
      753B9F43DDCEC9CDD485DFBF3A75BB86BA27BB52B7CBB200C6046DF9411066E1
      9582DBB59A86933008540C5FE6317C547378A5D368DB7BC194F57EF2537F0C94
      9E78AF9238A30661EC996EB7E19F345904FD2C1D65FAD730C826CFBBF065062F
      8ADAAD53F998E61F4791F97D94D94F03FB29C54FC3C1CC07B60E1F46FC610043
      0709C77FB3E54CC15DFA4AA5196836F0699006A9F91BC9DF81FC4DE56F308EEC
      27736D227FAF4A251D8CF67E84CC5D889876FB86E5F0F8114B1AEFA33F88945D
      4B47EE5ADAC6FC8B2319503C25F27CCBDFF3758E8B931738FE4D86978595B861
      79FF6858B3770E5AABEDD77179BFF0B51BFA05979109ADF6A7B3637F3AC5FE9C
      94F7A773B2B13F7879AD37DD1D7BD335BD212DE1F4EB30D89D177BEF86C5DEBB
      755EEACCAAD5044E6F64802BC4940DB0FFAB1A1CD8893DDB3AB12176B038AE70
      652AD71978A7B5FEDE9753A0B50EB57967A7B5F59DA30E11B6B5A6A076FA7CB9
      F0FACA23FFF1E3DB37DE7912D0BED79DA29A69D7088A82EBB3F631FCDB3EED76
      E04FE704767976DD3D3EEEC19FDED129F0EEEBA3DE19DE72DC6BE32D275D8CBB
      BE3EEDF47AFC34DE024BF1849A699D9DE14DEDF6190A8E6B381275F0B676F7A4
      47F7F58E8F8E6F79690A056F54F65B372CCE8E599C9D2F53A38C96DAE9EC3C53
      3FA58A1756A602BB683ABB2D1ABB643632C302772E74AEAC3F05B6D8E96EEFD4
      4A770A7DC88F3F6B2F9C458797B6F95ED5E6570779F30B8664F3F80B2C229D65
      280EFFA48FFC5D4D67919F2978E2E8F4E8F4F4E4A873CA3F93E2D9A77FE3D1B0
      653FC5F2F18FA1FD602E8D92284A16F245673E283AA006F1B7993F54F20B2843
      2ACE5A7FF2B70C564FFF49AB03FFB59A480A7ED17C3A50A9868B708859A3058C
      BF30F7E161F71837C9092CF53F86324EDCAD1DDA3AF0070D04B73BAA2BE8790C
      1F61B2761862BBEA10370FB0DDEBB560F0EE18F1120E12FF7E2BA3EC7CD9283B
      C856DD31D205781DFEF5C8B8F82D8CB2FB85A33C3D5D19255EC051C2DF2D3389
      0BFF8E47D9FBB251C2BFC551D205781DFEDD61BD9A917FA5511E7DD9287BDD15
      CE4317E075F8F7CB77A519FC978EF2F8CB468949038551D205781DFEFDAABCC7
      12A0CA284FBE7094272BDC872EE0284F8EEF89C312C75B19E5E9978DF2B8B7C2
      7DE802BC10FF9A51A2CFC48326F17318F44E8E8E8E4E3F6DD61ECE4E4FCFE0FF
      7A9BC8D3E9E6F4319FAB12A8F2CCB7FBF3C3EE59BBEBFDE72A5D6000986DA839
      D4CBFF228DE14B86B2F3AE85B1C3B8924DE3E96C190F6903BBA907773A243B51
      9DB34D1385E795766BCBD84AD4826F7D6C378D0C24FE8A5A57AE0C3C90B19528
      009B95B90732B6CF10FBC591E55ACD3737B6CF10F6BBCDDA6D28359F3BB6DD45
      FCADADC81D05DACE63FB0CC1DE39C6396D1F6F91ED9DF6111A964E5A5F63CEFF
      AF92EDAB7A5C2DDB6BD9FE90C756CBF65AB6D7B2FD9B96EDBD76EBACDBEB1EB5
      37CB7638B61F1D9D756BD15E8BF65AB4D7A2BD16EDB568AF45FB4311ED274747
      DD0EC8EFCDA2BDD73EEDB68EBA471BFDF9B56CAF657B2DDB6BD95ECBF65AB6D7
      B2FDDB93EDC720B7BBC7A7C7279B65FB61BB730CA2BD757C5C9FDC6BE95E4BF7
      5ABAD7D2BD96EEB5747F20D2FDF4ACD53B3A3A3DEA6E93EEC7ADE393D36EB73E
      BAD7C2BD16EEB570AF857B2DDC6BE1FE4084FB59BB777272747476B64DB8F74E
      5A4727ADEEC92DC4CAD7D2BD96EEB574AFA5FB03185B2DDD6BE9FEAF20DD8FE1
      F0DEE96D97EE47A79DB3A36EEFAC96EEB574AFA57B2DDD6BE95E4BF75ABA3F10
      E9DEC6A2889DEED9C9F136F10E771C1D77BAC7C7B578AFC57B2DDE6BF15E8BF7
      5ABCD7E2FD8188F776EBE4F8A87DDC6E6D09996FB54F4F4EDB27B5DFBD16EEB5
      70AF857B2DDC6BE15E0BF70723DC4F8F8EDADDCEE99698F94E0F53DD7BB70151
      570BF75AB8D7C2BD16EE0F606CB570AF85FBBF8270EF9D748E8EBA27A75B43E6
      8F4E8EBABDD659AF16EFB578AFC57B2DDE6BF15E8BF75ABC3F14F17E74DA3AC6
      98F8CE16F17ED43D3E6D1FD75EF71BE7B87C2035A27C2DCF6B79FE0D8FAD96E7
      B53CFF5790E7C7BD6EBBD339EB6C819DEDB44E5A47477043ED69FFD2AD599FD6
      6BE95E4BF78731B65ABAD7D2FD5F42BA9F9CB5095D76BB31FE0CC5FF597D5EAF
      C57B2DDE6BF15E8BF75ABCD7E2FDC188F7B3EEF1C9C9696BCBE1FDB07DD63BEA
      754FBA27B578AFC57B2DDE6BF15E8BF75ABCD7E2FDA188F7D3560BFFFFF4F413
      FCFE17BA9A5CA9340D03056D44EACFC22579CAD6912BFC384CE630927EA4DB76
      6BAF3C6781EC373F67FCFD2B4FE5E17E9B1FEB6E79CCA6EF6F7EACB7E5319B39
      B0F9B1A32D8F593308CEF2A6078F373F680BF76C7EEA64DBEB8C5AB6F9B1D32D
      8FD9E9DEFCD8D9E6C72C44F196F96E6D9B701CDCD19677B5DBDB8666DC455B9E
      DBB64C6C3EE796E7B6AC130BE2B4E5B12DEBC4223B6E9BEFF69695620B2C6F79
      6CCB3AC9A362B63C77C23B385557D920F2FEFC39BE8C9345FC37BE3A1BCFE82A
      7EE887F04FAB1F66FE0C49D5EAA7F09F1EC07F3EA6C29A3BDA5BEEE0B7E830C0
      06E943AFD5EAB6CF3A4008FC767CDAEDC26EA0CF279DB3B3B3EE297D6EC35D9D
      6EABCB5F7AB8EA7B67F2E5B47B024B135A9E4EFD6CF253CA7F5F2571D6EDF5A7
      83F4F279086C563E5CCCA127533DF5A3E855EA03239E06A19EBD50A3767F1ABD
      F5D331DD9BDA4F811AFDEF21FCB648FDD96B62B7A4194FC3387B134EE143ECA7
      4BF884EB318C47C99F7D7F9E4D92D47B19C13D3A53E9B39FE1A764A6523F83CB
      1FE137B81A7B2FE371A4525AFBC354018B9FF69769A7D53EED4F9376BB1F2CDB
      27FD497A8A6FA259C5A959BFE714EE39A17B7081C2B4EA3089F1A30AF0F5B48C
      E26434F3C74A777BFC6591A4813E3D3B92AFC3899FEAA376AB7BE67C5FE8A3B3
      D3931EB7199F7579E2AEA7110C8996027D6C7B932C9B7DF7F4A91E4ED4D4D7CD
      69384C139D8CB2E630993E4D46A370A89EE2FB9E766002E9D334FA84EAFACC07
      8A2CDAEDB3D6317F9EC0A286C99E02E12326317C4AEDA7CC7E1AD0A7F11CCE91
      292CB02CD56A9879D0E4220C92C5304BA3FE288B077FF47D15074132EC6730CF
      975358F3BAC59F47490A2B240BE331D030891338900E54A0977A046BA60D948E
      96497C358D5ACEAF2008C7819FF9F0E67404AD82588D3368F0CA8F42B8AE801E
      EDBE9E240B38DA0ED524890214C7B051C67192AA6978AD8221B48EE21A36C295
      0A637AF21ADF828FC107D893B036DA3007D7703CCE92A58A6154EA7AA6276916
      C3E5390C16E4FFB01FC43009B11E0403B84A0A010C690EE38681E9890FDB1E56
      D93F71ECC1784A2B193E4CE846D829F0F9CAF90CB786633EE8E12F856F13EC5A
      9B1EC00F78D680FEF871D0BF0AD5E212F48F367DD2433F52ED9316ECFF411AA4
      13E507F2719424595FCFA265B688C358E1D4D8CF936C0A9B45CF6010513CC9FC
      E00F18567FAE419519F851DC87FFE002BCA40F8FC01B86F06D415FE0439A8DD3
      7E14C3AE86912B68023E2D5264547D1DFBB32C1903870BE3A18A22680894AB51
      A822D8BF0134DF871B67F37888516CBE0E7DDB0A3294147A6C984A3F560B6851
      674BF859C34BC669B2803E27A330C38EC648F06C097427EB469C406763E03499
      EE8F14764E81FE059787D77A461A11F08800E67081D715CEA90F7AA1C6F1F4FD
      11DD3C877519F5277407122E036EEAA7706736BCF2895619F4161F1AA54810BC
      70E567D783EBFE651ACF521DABAC3FF46143C2828B808E1EAE9C10F6E3CCCF40
      DF536C2AF84B7F010B7934CD4621288EA9D7E91DB53EE1F60756344F55364993
      0C5459E0E3A09B4EFDA19F0D418D9CD18683FE787DDC758167F61F2A8AEABAD5
      C79957E9F2A475DAC799978FD0117D8D1F80FCF144A58A9EC647709250FFA4D6
      D4C887253E8409A40DEC91EC89E127D083DBF0693E4CA77801D563FCCEEA2F9A
      5E66F1C48FC728A1E2EC3AF3BDA6082E7918A50B3E0E9DFDACE7BBF009A4E567
      3DDB834F51F5371F149F3EAAFEE681B7FF695B33C74480CADDB8A9A9136AA8DA
      44DCD4CEE96D75E8AC4A8770C96F6C09844F0ABC2AF2C3D893B5DDFF07EC995C
      7101D5033836FD3BC0AD0F6CDEE7BF20706015E313A81DC8F2058632F3A3D9C4
      C70F70F0EA8FE8EE7E32A7054FE7B1561F78DD5C67C06A2719BC26A68396D1AA
      A041DFD56C404FCAA2E1A43F1A82C00536014FC311AE035C0D46D66E758EA8E3
      7C430B0521FD8A3F765BA76DFA3052701FE88C09DCE58FBAED2390BA93D0F912
      0CEC97A3FE1077253D17CF9C26E21936025352E8CEC0F4A8775AE8477FD01FF5
      7A7DBCDE07B24CFA97A0488010ED1E030FD4EEF8FAA87114072C7D83E70B1DA3
      FEC35518E4AF133F7BA23DE0CF1ECCDCF5CB20CCBC6EB3DB3CF29EBFFCF8EC3F
      49C3483D9EDEBB9BD8F66E13BB8D94DDE3CDA404DA11294B0908C32F23E10BEC
      2FAAA5DE54690DFAA1379FA122738794FB125AC92EE81509C564EAF46E85421F
      27CA0BD6A834F1B53750A0C033B982A610ACBCB90456EA5598296FA45430003D
      D4F307B0783C58B9A04078D924D4B4781B7865114611BCC743BD2BF6FC31F227
      5419BC70443F432F6670240893B98E9672579678CB645EB943AFE0A59F56C81A
      6EA36CB8036D4BDF6C87EAA182E46BE525A015AEF665634790BDDD5E47905E96
      D4BEBE5481E78F406B59C0DAD7426AA0ED3C0A56E702B49DCC8303193C1607D4
      8C9F2A6F0C0AE018E7C136079F67697205876DB871E9C1190056FC7C98855715
      989CB354F00D53DC29B000AF945D39C002E558A13D984E58129A0D86490C3405
      422BE18D2F423D84D357B3668C65647F3E1F8FE0B8A66B46E832423650E3EA4E
      D52C4981F179A1D673A5793D124744B205DF09DDFE145FEF75E6A858F6F4B032
      8495CE8BD7B57C7F1B85A6D8711ACFA8EBF59F0C4EFA70ECFAB4610E0B9EDCCA
      93B9E26CC3672B4C6FA4372F7F7CFC6E26B902AFD9B7F30A7C23606E71E01D7A
      43D49F71DE415C4C5FBFF09291E7C31AC09FBD2081F987F3277146D2C5E4A679
      9C8511B3524FFB57F838B249E04EA8A1C3D76F709194D268BF0215B710F1B757
      EF7BBF7BAFDE3D7B8BDAEA0F6FDE3F87DDE32DD2241E57927A5BA7DABB75428A
      3DD6D251BE57DF6B9F359EAD6FFDFC857B15A6D9DC8FBCBD5F93340AC8E0B5E7
      81349A828024D9A8A6F09C9F2E3DA09A4A43109F682C0281EAC7BCA0C546E7C1
      BF7325AB79C376F8F5C39B17B223BE68F0B73F97D66A6E37855CF8CAB379C37B
      3F7F3E7F9DA0D2AD91F6E7C96C09FA9567FC18DEFE22CC26F4759186C85F0E1A
      DEDEBB04B5AF6751B49733AA45925E92B6CDF3A5BD51E48FC7A8F669D0F52305
      AFBDAD217FB51D7A0BF2F01EC4CB28998304182CF323154EEAB94A3354A761BF
      A5D9700E5A2CCDD06212468AB4D728F183D2E6615F023BD5192AF23EEAD60A5A
      50A4FE2E457F8F9F6435A7FD524EBB790E3F80684FA6DEB35F8A029F66601825
      B8636FA7ABAB53511F62B64ED685F2E105A474FD7F094C0E6C31B198BD538BFA
      6463C8F4CCD34C28856764A4D63F915AE4251C0089F2B38D1F047C9A47A69493
      D2FB25540B95DA63F5EA103A3484553ED0ABCCD0CD00BA1B07D0F59EBDF9E8FD
      D5BBB87386EEADD98ED095F6D5877BFEF1C31B18EFABBB1FEF2819CE354D7E85
      65E52CAACAD638DAA6A87A0E149974523870C38A23C5E6CE9795D0B9D5F0FEDA
      C0A93EBC7DDBDCBD6D9957DD7B507FAC3EE24D51DD41F50155165A5530CB974A
      CDB42C1B949DA314B910DC3D9CA7299E57E0AF46FB1E4853B4EDDD1BF15EC620
      E1EF957E2EC3DE8582867468D575DAA199409B7EAA7066A0A5796977623A04AA
      80B6065934B458F0157FDDF60E79AE36C296EB2F287861A3FCE84F07F3740C5A
      E55B15CF6BC5C5D0670F09B4871B204E169E7FE58711869720C970E115C956AF
      B70AF44483CFCF31866605DE8F619CEDA1A11B63B972479BB7F70C86E831E993
      1972937A451A0A927966131943E47B6A88CE30599DEF8974DADB076E4C874918
      770519106507F8B8E1E0A922971B7AD5E6F242E6AFDA4BA240213B066DAADDF2
      A6613CCFE0AAEF0D30100C5E0A128284C740A1A860B71E9C6C55BA61F3343C0A
      A145B71EFC66DE340A236C110E0C38E028E19F97CE8141EEACACFF9D47E1F0D2
      BC863A487E493244D29B351A33B14D102B911A922C0B423F4AC69FF78EDFFEEB
      773321F43A106014AC88BF8B4BBA7D04EF026534D062D187EB41A8FDD90C049B
      46FB1C7920917CDCD93849FEA9ECD396F435032A9F9A2C8D40E3A61942C2E2B9
      D2FB91A2E9D036F9BFE7D399F7317928ECE60BD550875E5B4F280EBDEEE1F4CB
      FB862629F30766A2662AA5105C12CA32657CAF9F89C5B9DE0AA5D4054D3C21F1
      01041A2601F0D0C0CF1ECACAFFFA82F6257AAB62900505FA18890412314E4820
      297472FC631EA67003C732F9996F34460C070E2312C962D352D7AAB21C794DD2
      134E543A44A5135AB09E98CCBC086D187CA01221032F40698F3A15F983BDFE9F
      3FF853F50EFEEB7F6AE683792F4DD1A8064A9B569D0ED69BE70635CC9A268B73
      0CE4ABF7501ED102EB37275539C30F92E19C1CC737ED1FD207F3DD87AE2B5415
      8D2542998DBB8017EB582D9A6936BAA715BD630472C5985F18CCD78CFADD16F3
      DBAB637EEBD0B63AB4ED7E42DB3ADF7E68DBBF1D9DF5BC436FEF4D32F4A3100E
      A8B3683E0EE33D6F8439606413D6DE204D2E55FC0DCE70795CDA9680190D17C3
      0AE481853FF5315395439FD8103294C08C619882E4D3991FA3252C551A160372
      5F78493A9F719CF14882A1F443A4DEF680233F0880293CA5E3087E207AAE102B
      52C82250BADF146EA66D28D9BE8D44120262BC0A3E863AF3C143A4DF96A09037
      7E3C9E63BE041BAB2A4C83EC43A48DBFC0730CACAB26F29578ACE57403EBAE39
      D0FED3E6C0EF78E4E9B9520F75D16D26DBCF1F5F9D7A2A86931039B112D42299
      69059EA145AC5480D6CC911F45941B305568F80CF5142DA3E62E3E09661EAF3B
      6CF721126A0B995235F206F330222ACD352C8D6902E39DC2564D976CF88DD510
      3376D2E5831E7615D7688132E2799C26C13C722DC5689742FE06F7A13E4EEE48
      750DCC275AC265389CC419500E0F30EC5715937D43326016DA9BCFD010091293
      7F798864DDBAEDC21813734204661886CC68C8770C9AA13FC300B6A79CF64EB6
      F3E54C4CFF0E77171120E6C0FD703AE3DF3813076F0E941EA6214BCCD28E0EA0
      6B0B9361F620C5C2BF214AD7A1F781442BDB7BE27914C9A9CD9FCD3C01ABF018
      9CA83EBC95A6EBA1F36A9E7927C79E9ECF90ACF531CED0E6074450C144BB3168
      A83ACFD19CFA816A6208B88DF7A6231DC618E39A84418771C8CEC838593461B9
      8E540A3C40E5D2C5B6A562F4B0070E8F4443906B041DC1025F92D9C7BB207C90
      E54578DD542097298A8B7FAEC0A4E8DD28E356FB82CDE01260A490EA899E6B2B
      077B3F56B14A7DEC12102F584A6C63B9296C96A0B7905C1A7EBC44D9916748FA
      420910C948A30C6D61C9A507B76E200876693A1F4E38A5085598A12295878667
      126E29AF7198FA7AA2AA8FF83934ADC3711C8E42D0D2A1A353443AC217517839
      C7FA689EB3147DC9486DE009C4C64D7293B33868CE1152201C2D258A2B5E9221
      6A4FA092F6384B44336160FF9475B110585A1BB64BE92516ED294E05F6DFC3DE
      4D159EC46A3E68CD598B8456E51642ADC6337F8E416BB36BF75FCEACD5FD52B3
      D6D78EC43CC48EA2ACD9EAFD466CB9AF168F79E8FD8A111F36F91399E25B3E74
      5CAC84A710F7445AB268049123C713619614C5C3593BFE1059AFE4D0B3954E37
      B3EBAC892E473FD289A72FC399366FFB214DE05492BF0F5F84649982DA3DF48D
      30D6F44A3E079B873EC76A70472BFFEE632968298D8147C00ABF87608A43EF35
      1C97F0D8755F63BF711B7DAD7137790715D72BED8372E5E1F1A34C79E83D7F03
      3386C7CF5C7185ADA550E1228F23EC87840D02CFFDE1E538A5C3EF1BF44BA6B5
      CA511E146A2301F7EAF0E395BCA9BD6294E41E1C52B20C432BCD71A990309525
      332F5223B27AC3A9C32C4ACA8558847180672FF2C94B2B68A54213E7149AE6C3
      D3BEC4F1474B0A02759C7668B902E6513BE7366831BD6FDD39272E39DF89A5FE
      9626B0DCF0403CB83C63E4D2DB0F47069EE7411AF42468BBE68186206FD9E300
      0C2ACCD4D4D165E7B1F13D8420D1F7BF27253950C0D248B34D62866CBACE0E50
      7207E188447766AE529B1A78E3D21B2BF846B190C447813FF2FBD8DC3C9A2352
      672DC7CB63AB41254204E43C4A9161245E382679A0E92BC41CE048DE7A95BB01
      3243433F4A724BFD58473EA1D95A67E3BE56152C87ECD5C04672DBDA01B9D1D1
      923AB0F313A8D88D1425050237C63D1C0FFE7D38FBEE1AFEF71F777F2CD2C954
      2D28CD45F6BBEB414A5C375FB31A65283DF7D6EC0F4895BB278A2448DFC378E7
      D9E8F45ED2ECD1D2CCC60BBB0FD965D6F054737CC3DCAFD97F6E8D16EDCE51E7
      1E92809B96029A0F05113A7BC8DBDF03393A0E331090686742F743048C1CB947
      4B97D1E96B51097947EBACDBAAC63B3E2F79BE16FADB115008E1BF7C5D15A45B
      64C2961093885BE0E0A35A23D89EFC0184927009A12465E42339FD9CA0FBE897
      804B46C6734C8090220F92C713112B0A07A80380800B474BA305146604940EC6
      63D5DEDECFA4CF157EFE6ECFC84DEB48445B34C84E4AD13FA88EDBCB32581B24
      81D20740E98F13EFE7D7D6D96AD07D1B68DED83010116A68F4E074199FF51DC4
      38200110C0957B507E7E1BCE8CC6FCFB3DE83F62D417EAB03D09FDC2B8244285
      CEAD4B4574FDAE7C73E61B30BB3E6B1F6381C3D36E07EBE59DF44EA9B8DC710F
      EBB01D415FB3EBA3DED93155C06AE32D27DD0EDE72DAE9F5F869BC0576F90935
      D33A3BC39BB09209DED5EEC07DF8B77BD2A3FB7AC747C75F77D7DF09F28EBB16
      5677CEB667543C86ED3CF91E55A7AACF5C62A19524FEFE18FE57F35CF714A667
      6AC80B9FF12849D3A9AA0BDF8B267CCB58DD244F5634E1FD053E76F734C0E579
      0F8E571043F193ACC1B626C48027B72A304875ED63C8E14E52CD5951969E94C6
      EF8F465852090F1E8480E1F131D4CF6F0B112D330DAF4C7A9B91F2B55E5AC118
      359DA19590BDD6368EB66672B42457A953308A4A90321A8B38241955293E0BA3
      41C47A8824EC199E4ECBA143392CD0BF17E7F3DA68F7AF0F6E5BD1BAAF2DF92F
      9561DAAD334C2B1E0EA758ED0295739BFF53C72AAFDAB1244E8A739A2C701CD3
      094887913888668CFE25F8254CAD993D0FD97DF6EEE235E22721A442A6107804
      0368531FB8487A60EE179FBAA04088878A0FEAC0298799A3464DFDD90C8FD003
      952DD07B6F1BE3D857EE06BD8AC35C0F5005C0637ED3FBC9A0634940BF465ECC
      5B67E20778750947B5698843A34156810029BD834FD5FE101D6D9494E7D29406
      1A8408FA4CB640A22F962E26B2D951FB2C41F452676ABAF29B18D829FB4AEEA8
      AC5BF1E07320008DE9204BCE53DAF642B60D50C550201ADD2AEAD9D0E683F162
      B1999991AFF1B6C4E67C990E7E4B7EE57B0F8138FAD643207EE04D6D26B1C2EE
      F00E5157D28C7F2661E7640C216B12D6E8D60DA772150603639A5203C12A1881
      82EEC93DD631DC9B7A57A1B5E8E12A8555B3CCC3C4BEA5355581C5FEF2F6D90B
      CC0781F167216F12CCDB1222D351324DFD65BE792C4DB112151CA7D00C099BEC
      E272998653E281910FC423249D2511CD306562D416E5C6E143664BA399B3B4CB
      843147D9787940C0C25F32E05D42290ADFF02EAF1AE7E364B1BA6B789D94162B
      E51EBC5B26E9F81E40A6497A11D4AD6F5652A8F314E00739F58F1F7DDC143270
      F3FCAF6C256155C2938C704645498AA261A40C79222A744735A9F4DDFB411482
      E212376C7E54B7411BDD7C25787735F635DA5B8A5DF5A8983066D0CEA27018E2
      B69DFAE925D711D198D314BAC5D7D6338AB80B0E77891146BEC1413E14E80EDC
      209A079469BA342BC021A0B76F88C6B620532EB040416717C1CAB95B0BD9FDEE
      A22A20ED376CB483953C6A834B40580DD1727D47D6E79A553D86818923906185
      6D82EAB855B2318EC0DB273D18112340027AAF0FE4D4629C62794810076DDDB9
      A9F7F1A3C3E1EC508E5EDFFDBBE9FC3D4404B119F61E08709F8386A5A042D27F
      EEC9D1B1C639EF24E86735D88732A0F4A4F461CAC4C5B2F4C4A758B11FA81C0D
      6305AC31AC9E53BBAA5253DAD6DAFE160104621021479AB9F71C8EC3A4CFAEBE
      9EB2B3578D1F79BB68A660E96BE51D555725A014F28C837864FD387762101172
      ACA21DD3A51D5DB5DC0C9183ADB02D029E1AF89AB184C88060EC6078E42259FD
      446346666694189456F49B7CBF0733F43D2BBC3B152C1695691FC5F1C5CB83C6
      4A324881DC3C2FA87C8D639CCF3A4564837DE4F85BB78F4814016808A82E7C83
      53583A821166E63DE401CC927C065A0F7100C37FAAE143EE7F80F05E0F7905C1
      C1F7818F60AC40A78A1FF20052A52EB9FFDD87D87F104751F8A067E00F7FE6C7
      A8CA1E3E583C3E38592CD4F8614F039E34E6E3394FC4431D04A8730F9CA1EA85
      0A1EF608B2797A6947D07B882348E75ADBCDDC7E8823C06A7F394BFDDB431CC2
      641E8FFDD44EC3835450E1903808873C803A6EBB68B1B878595B29BED44A71F2
      20AD14F50EA01D601CAABD827BF5E4B8DE165FBA2D4EBFFD6D51EF880D61EE16
      BA1D03FAE68C206A97BFF642EB016127CA3EC99057EF7B12A0F0FEE4D8DC80FE
      54F2858C38553CA3EAC7EA7AA86699614ACD83AA16760E5758ACE3929928CAB5
      C8D18D10F50D0FD15EF39ACD7956AD06B53FCC8613741165A07EC6593835701C
      36DE92F080CA3D5D71213960A7CC9722A205B99738F666DDEB4C41AF43C417E6
      8C557A21C5A4500ABA0D2D251F8E4494DEB9A732F7E0DCBDB7320F7533212731
      E17ADF839FBA992729DE83A39A63779BF78436F0F811BBC6FECF4BD9F4F7480B
      AE37489B44B0A1A51A20EC1FDCEA9162645ABB8302A5B14E6105FC0FD9B83BC6
      6253427A9618A669B2CEE1CA9E906BCFDB878F7BC410ACBE72801B3A675E230A
      02729DDD36812E3105031CDCDDAF13AF5205D332FAEEDF4DAFEF3E6203713A7E
      9DE0DC334ABACE509CB878012C4C80FFB32C58AB1F19156BC7508C9E239928B0
      0834C0D29E4C6734C56355CC7AB0CD5BD0817B8093F9770C74F88F661887F730
      41C2B3EDF8435BADE7522D690BE4C19192FEE1E9B57B28301183A23968632737
      FE06956131E140CF50BB0B80413C382395852B8650FA91379C24E190A226EE29
      057873D40425E3DF51A0301E90B884B9006E94DBFB1CC20B06B3C49C8AE233A4
      0AEAA5CAD967EB5EEB91C0C5041D373767C31A412D6373780DC5D672C7A90C84
      3F659C0F6F5FA2C776DBECB7CB90EF71B363305921FCB2B24CBA5D7E8732A9F4
      A6FB145A07C49738FC6CA046987CC70A55235F9D044E031C67D55011070E3215
      AE5CAC24046B719020A6F98CC0AD9BDE39EE2DBB974C13D9244DE6E3C9CD1B0C
      1820F2599355A7796DC32B4820AE522BDC423098D1F0368906DAD03D20C01187
      2AE20D1598E00A44E13EF20CE86995BC2A27FE7B25D966B753E5E69E98004661
      B5E32819D0D9DA396CEEE3DCCED23049C38C7FD8A2101D386CF93E34CCE1EC5E
      23A193DB8F06AE36EA439AD17B1DFBE6DA1EBB0487DFB226FB7082C3FF551021
      8BC1E1E546D8B4791F1940B05DEEE36C83474E1B4E8E4C180DAD0BB43A63D176
      90AD833002EEDAB8FB1383E51FB74D962AB20D31FBA8A4589A672DED26D5506E
      997259451B29965E210C02499702151DB1FC97AEDDF4EECF67DB0C60777744BB
      C144CC946A70DE3623FB0EACCA38BA1FF976DF79005FC7725A61E02F527F9CC4
      83248D9BA5F77E3DB3EA4EBB72ADFE85172B3FB5C5360C3E34435F12F22502B3
      A0852D8CB116AC14261D2462B72795D51E626A44C5AFCF9F18B3D4A8F6DF9958
      ACAA4089FCF8B89074699142BEE3D4CAB5DCCADD1ADF707A29BEA19DBFE11C8E
      CA51140E777C45E96D9475B6F6EEE3A356ABEDEDFFFCF1D5E1E941ED5A368CE1
      5774B87E2386D0BBD16A724328D6F0C27AD59699D92AEAA8101252B064C50333
      ACF9DB1D20C6B65ADFB55ABFAF571EFBCEFB4D5C95C2F29A171F3FBC7EF7C3C5
      EFC214AAF2987AC7F38EFF9694EB3B3BCC605E2F7985B044FD931C2D8BF39E93
      2C8F18AB37F957DCE4B9EA6C030FB6EC666F9F5C3066D91CD452FCE63D2D6769
      B4083F800D7ECB58CFEC34A1988D9076B8677071184B27C7B8A9A5F9DD49F3DE
      6669EE1C9F959EFECE85B4581FF3F6CF3F9C03A1CB9AFFEED9D9ABD3EEF357AF
      2A9F1F76E9D0E730A25BEDC005B9A2E1042E709535B3736C19DA841D50A1E664
      61FDD5E4024D9308AD1958C2B968A3E0D094A97F29285B4FD06F3BF1118B3405
      E6C005F71046CF7AFE498D14F0CDCD409FEF2F6A04F3D2299BCF021F6DEBACC4
      377F043A213583265CAEC1A6AB0BB96D60D39D1A6CBADA427C3E1F8FC26B55D7
      24DD62194E9578C142AD11231698A3E2E2CC15F01AAEEB949B8D293767DF7ACA
      CDE347FF7674DAF50E3D6428183C47452319C03007A9A46FA69212256A4CFD98
      C10D352C93E01B9CFA6A23EFC1C80360651987C7306C366A001467A8A6330C59
      4524C724C5BAA5B4410EA8D826463B6AAAB7ABBD6C9158C74AC0B64346E60675
      E141E64903658E80322C658244611D1960105345D5333884769AC454702CE4DA
      3291AF332E0043E19608395E055793D1C97598CD7DB762F443A3D63150EB522D
      0709B21B1B7745159BD364466B0207A42D3117497AF940C77A0263B5CC609044
      183711E7CB643447B68061F4B0609207CA1C6098A7C81ACCE471328A81D89F09
      225F02644080BE1CE6F05F607ACFDC7163D7618493240DFF894939110A8804D3
      111141116B3880825FC5068BA7A6419265C9749AE88C6BF33C4C029DB580407E
      94FD75384F355518BC5288986FF2840873D2A9BEAC8150D17C1A634610FACF61
      DD0CF0FC5F1F7EBEFCF0D3AE0F3FF5E1E7EB1E7EEAB3CDB6B34D7B332BF9C60E
      3727A8E2EB2C1C5E225F4E9345414673CC1D72F3D8BF0AC7A4837E83735D412C
      9DA00AFA814B078C229F61867198C364C6451B299F1154333ABF05A93FA6D4AD
      3820693F7BA87ADA09AAA32FFCCCDF38EA7FB1B19EAD1DCAA848CF2C056D7B25
      EC0905E51A08374244548161393C654C06CCDC986723F88A0E35ACA95C8BDA52
      E259C49ABA9ADD2A6D2EC2714C6117B1245E2AADC9674DA276EA075851895D06
      2C95572BA11432EE111308F3B5A6733247A48A593A1C3B61171BE8F72089ABE7
      FF3B7307473B5B6B5DC518D418608C7A8AF0EB26974A5D5386FA9DBBDB11D205
      B940133A704FB59529A590D84CC632F4B68970584A855172B2BDAAF2D78C36D0
      792255E595F54C5005B8EA2C928FBD8952780D0F900D6F16295F2B53C8204A32
      2A454605094C7036E78F0A3E02A64CF87AA2C46619C698B31241BF36D510AA39
      77C55326567202815C73EDFCA804D27F2FA7CE1E30D5E19C6C1EA1A9DCA39362
      D86CE176A0665D58F816CC1DADDADC516DC5FEFC1ACFF7D3DADEB10A6D44D5D0
      592BC540C1BC1CFA601E461425674927C52B4505F287597845811C9242EB2211
      ECD1137BD0F2800108840948F40C5DDA0F87496C803830E92852233CA6A531D6
      20361948E80C5A8471902C1AA8655C853E5D379D424E621A7F8FD6D50A038F77
      4BCBDFFAAA589BA428A4DC0CEB18C3FE948EDB1AF2193E5BF985AF63348A3311
      F9AD8CDF20283A6E5F3857819AE71406AD705591CD2A0625F40D5536DC0FD067
      9B32EE5C82F67BB8AA38AB95C3CE0EA8F517709BB76F7E3577CBC3EECDFCC25D
      2888FD2BAFC8CC55A6D14E7E898B0115974493A6227ABBE8DC0C0E96CCCC2F4C
      684307103F134E2A950A7CB2E2A4883515B2E59AB5E8C05659AD04559B41CF5F
      A01D054F6754443A89475148408E703C4A6BA65A64AA4609429A198660147DA6
      98A78744D6FD01E19CD14ACD601F22FD98DD69B95323DB236DDE8F39B4B18295
      53F0E50C0FA2292434BAAFC414F0E62DB09FD6316CDA79CACF1F707BF864DE92
      1D7301A5C95CCCF1F256D8302E491D8E6378299E40871526AA1CEC4A56384C4B
      36AF0F4BE5147DA3C62A0E36B1875AE95A3DF5A384A33E8ABE6398C42F211F35
      2D0731541DCCB32C8925D0264BC6E348311000555D27440A0A7336F767491209
      239187F0304611D2399622C8D8411873980D3E7D6EA68DCE77FBB43F79067987
      DBDFB1E6E27EBE6BABB8FBA59DCA7AC3AF02E7A79C753545B224331537D88C3F
      7411B1467002A5006F059D13FEC0E44C1569660D5128B321611CD37DFB85213F
      750778601A91F70B31436DDE54B384D249FC11BA78F8E2A7D72C096B2E906B09
      1564B8A348A0236BCC81974592BA070381CA95947E14FF2084D5AA9B8F340DFA
      6144418C94DECCD5CFFFC303BAFF3F66D91B2D443034B1D2AA2740E3E11428C9
      E16CB67E386D8EA1CF6AF900084C5DC3B84829AF0A8BB7A87D632F6823163B08
      7B2BC3848B0A642C2F676BCF46F586ADB4305F5EBCA97D54DB0D251CC968CD25
      B84D9062B83DCDB621DC9E89C2442E6F1FF6EB02C58C80F634958E1C847396CB
      E1D4A26B0ABC34ECB862DBD5A5A679629C03B4B25E3EB01975641BF0BD3DD2C6
      F73C1D2559AEBE53940BBC3A4C11CE72FAFA85068189EE717E2C2BDF718F1F29
      EFD5CBEBEB6B2C3136544DEFE5B54F9B9B908A7054889189A505607B48ADF6A9
      F24101C9D99D0BF64C3D9ACFF063E7A8EBEDE114ECD9B1EDB75AF8CBAB17ACA0
      F45A67C77664F69E572F5B72DBCB57AF5E1D1842F8590EAD84B1DB3B1985ECB4
      A3DB9DD819630C53E31E6698A672E0B1FD40BB19FDCAF0A015C02960A82ECC2E
      2EAE54675E108E437604E1359E276272EFDE7F84994D551412E48AD4CB0ED02D
      3545B43FA76F7EBC44FF68F595E50068A3A58B12E3083C838EA68CA04991FFEC
      FC4391926F0DEAE9D2727E03A486F09A06D91D4DDBECA3D21282137BEF077F00
      495FBF6898C2D70C66999300F75C851569A9D40019F73F690DD8150F52948C90
      481B0E92C8E5D186DDB4D34E144661C191391D313234C22401EB37D4DFDD03A0
      DCEB710C8B00BA7A1F5E53223F2D493F5FE7CC6768E5236782751F621F8D926F
      9794D17B5658EA7DA07AFEA4D53C48AA12F12B921089835BABC28E90DD57203A
      732BA13A176081556A00BE4A282F9C1CC32D343F3CB270C8A42106096D7D62E7
      EEDE10B1E90A855A4D2B9BC00F08C4A862CCAC79BEF4CE7D3AD1D60ADB66F2B8
      8075A260B0B81AFA5C4888B0B1F91239BDD8C340BF7AA3D29791104C62448D51
      8C3831C0680B719FB18C3EFF706E1D5A0CCB8130AC88513114B06E4E60AF2C5D
      60847CAEA117B3DC8537739FE1A5A9E23581058726A982A36144B967141305FB
      31F68E402532F2D6555DA163A912EF9FA05F65FE257ECA9FED8078076116ECE6
      4773C104D918451DB55345F354DA523E914C612A06C1D05DC89942E97A033F09
      D8398592118DAA07E7E8F24524DA7AD1E2CD9D92B2505EFF4FE46BFD4F88E2C0
      E4951381ABCE719D015E85BEC4BA71A05986E004BE3702D508F4B779A6A48401
      327B83A44A4FE74ABE2F6A735A25D5CEB78674D90A8551C69F35CBB26D685798
      D38423A09B30E17C0BCE16792D335857144967CAEAC09BF7307ED7508F189CDA
      E36D098789B96FB01CA8215025276B206D36380A56DB67F4DFA03C6C51DC0874
      E27E55B717D0A7F3D2DB7030F751D4EB7BCF049EC19E08428DCB521363190A63
      BA0F4D8D68862441A095BBD7D6BEC7D0D327724474F709B02A3853698AF8C3FD
      8DBC8A2E9A73F05662C1A8BFEA02C34E5E406FEE0388DB908BA8E1924B04B691
      5029CAC2BBDF80E7DFF5FF44D6D3FF741F0876DF33DB936A58E473CB29542BD0
      65F47B0B2D8587A81A9129C8AE252A8C209600509748072837326F50126A65DC
      15AA825C65C3CA88BCA9A5F476552B98D3D19F5524631D5429DEC05100539CC8
      19790A712E756ED8612707995F2D8C7A1EDD76FED3CFE878406E72E58711CA27
      39C2A2CCD779560297E98397CD67DC0DB445B2B5B0DE66A56AB473C421B4ADF2
      A80B3A1D11E85BBD9DB66D27268F1C28DD63241D31AC2AECE7B106453C77D28A
      8B2D894DDC1A844C1BB20119E2CCB73C52B4EC3C45D27AD96BEB4D79A04C6E86
      87D37410D5B69B95F51DAD13283FC8A76A918659869E62396294B6093C9CBC14
      7A9862F4077BA6D95B1E135E207BA8A621E5D51030854502949DE3D827B97825
      4A185B2666B70296170ED470835AFBF8F2A28705BABB52A0FBDD2F2E0D42AC38
      9B8668E3A161D02EA7B0BA258922DDA4DA73D0C8D1D38B8B9752E3BB9703174A
      33F7621E9F4573209A6E66D7775FEC2DA78BB7CFCED6F212C18F1F19879EF14C
      853185BABBD672868C7686766039A4101B6775FD412E2DC481106636EFFCE482
      BDA44EAECFC9E35B286DB3531D5767B936E4746795B5BBC72C567A7A2FE98340
      80FB186C741F83B5A640B65F8B1135C3424F1CE0848CD77AFBDEB2CF49AB4C5C
      526CD5C59881909070ABB980E560BC9321B0C0803F0BEEE32BCF60BBF98DA07E
      6C56BD7640FDF8D2B5FE6729AD7233FCD635BF664ADB41A9F9D696464796C6DD
      8BFB9FC97B519993DE2A6B394471720B381EBDDBE84DB7590DC3E3FD0834C1D0
      8FBC176FCE91994D0C1CB2F09E4357467E834BADF775965AFFCF0A8B8D77F5FF
      F9E5C3BDAD3782B0FEE503CF8F4045F4BC5F3E7C2BABF0A8E22A3CA7428B708C
      3F8FE603E395F80A8BF16B8CF1B8E2188D3681D15CAE99FCDE07705271007112
      1F6E1B446D39F05E8F8CB5CAB1E03B67B60CADBB12FD68C230308C409947A4DE
      2B9F149398622128E8419247B15A80CEF232A5A1047E4668795EBA15C4D83A96
      3F965439774A93A627181B2026692A6BA037CFBF049CCCE6E49E86FE53A95A89
      D665157A002FB9ACED72A55380301F6F796A73C0DE00647332AEB759E16CB446
      1EDA3836E0DAD6AF97FBD0685CB484F836EC05A309FD14C181CD6FB289FD80F6
      306F39DDF0F686C96C8907C466B3C2666AD216D863535F380D23983C443DE364
      B783DC9CE8C42958CB62F56C7DEB949A6B89B61233B87011D9B9CB64CEA9EA6A
      8531F0E0763997E299395582202BE857680F7CCF21E7E3D09E9EC9AC8991603A
      896D4492CDA9170B3EF1C38386158E8D3CD0737F640D34E55E1B5408A019326D
      4B57C84C5A98760EBB9680F59F52350AAF773A9253AEA313B62AE139C007818A
      E8A2E349883D85B1EA5C0B993C202BBE8972F7B04D9DC826D6D22093C5414BE4
      1CD90C73B5710B12A4BC0A6E53FF441E71A90E0576E3BE0C5730074F320A929A
      A8E1E50E2176AF0AFCC14C294B33234AA5CDAA7E43098373326AA80132D6AFEE
      396FDF99C3DF9ABFBB08FDBFFDD7EFD51323FE1BF63659B224F28EC2554C1C01
      D5EC0E38BA875336F221ED964FF02299E30BCE23C42D05D29D6769F4D79788F5
      C883E691523868017E4474158AB62B442A0EA344F3F6601ECE9478FFF71D3274
      CB3D2FB16765C1DEB9E5DFC29C1B793D05532B810B381976497E121E4FA034CD
      5E1E49C86E4860663E46BEBF7D6AF9D6951F21602FB11F4A2BD9C9F447D5F36E
      EE34053428740F6917D95FDB7A0875AA61053D82B11B60F29E5C581AA268D066
      AB7A18B48CBCE1FCE387729F2A4D57C09B64889BE449ADB2D9300CDA06029953
      85DC1BA8996B4C84FADAF45E38E0F6233FD23B6C31F6F0502E3F87869096D0E0
      374F81922803262A0AB8760AF6A5C0FE5848F8C3A19A653918080BED06FEF57E
      0099386367EA3E86BEEB6C19A903F69CD2962DED24C7532081EABD5C2ECB292F
      16E5AE716D36C713ACEA50E712AFBAA4992E79DD71E3F982194F970BD2EFF7D5
      35AE6C4F14680C77E7DC812106D1118C8FC9A80CC200D52F1B682FCDE7695995
      4F32881D1263B89579192A0C6E77A1D150670DF73526DC8852F47650FD5EF2F8
      0C261C769E759086C132B059B5A8A4DD38B27A576E37EA168EB60995EE02E648
      BC51D75B73C3A14F488326376F04FB72CE194F4E1A9145DF64F5324AF0B01D4E
      1507EEE36DE3848293703B7B519865B897F08A7BEA9EC1196487932FF4070BEB
      30E05D46DA3B56DA9900B139277A87B1C9B43772FB4ABC642D99C7AB3D07B480
      E10D19A4437084617322C2FC38F58D84F486E43C8861F7E2B9DB840842C33E81
      F3D87757CFBEB2CFF05448227B86BD62EAD3A40C15D70ADB47C3E8228C116DF5
      C0D6E5D58C8724B8C7622A106CC0FD811AFA7339FEE80CCF4F645BA8605882E9
      94B9D0C89093799CD98030CAA4B2A568C92A7CD0C490E60913D1A78150F2906D
      83D8789CD04A82B3DC0C41B487E10C0F455831CD001261123F2B6D6C5892F1D0
      4105486353F251111323CF9549CE471E8AAF9FCF3E6706F04D314A271C8532D0
      3031D9D785D49E189712D8DB21AAF453BF82F542A53239957BF5F8D1330C0581
      4EB1A0E4733DBCCF90C92DD3024B3989AE38B36C86617F82944DC9732B649265
      0177E61B8583C851FCA041693ACB969BC25D4DDEDE6C162DD902B8F78ACC5174
      80C5A76DDFF69A8EE62B882016347D968471BE29D1F9807B120EEF5538D7E347
      08E911B384A678792612BE0DB8F6132D9E1019145046D2ECACB9202720ED0B22
      1A051707019B0B290C12F69CE995191DCF05507BCE4BE2A6D133D6877FA908EB
      8318A4F2F5521C263002920F2B91740D662FCA9889D19A22B349698E34C95532
      664AEF28AE243E3C8C70392332CB18190DF7846890AF13C428C13D409B1B99E9
      CAE2BA2F45A5733B8A4AE764B3A2D239B975C70BF39B8B15DF42ADA0144C5314
      9DCCC87BA50FCCC50AC931C4468437C42CB695E236FA5FB66C7E95F6AC71A788
      8731B65E33BDDE12EE21548AA8C45F32E2B859A369EC64FBCF3B61A1417D07DA
      4F2764354461158402DFA2AE6706AC228C831034193C4A15762E79642A840F86
      8469895A5CF55EFFB7F467241CD17144E0ABC9B30CFC2FC4E8F4904E5BB69CA4
      E9E30EF25A3296C9EBC611946E2E9B3140876EBE53CD984A0FAA0439FDF40527
      3013453F28924D7615D5ECA9903D8F9BE43A63D0F264030827718344607B119C
      4A480BCB96F1BD73CA36CA97BD73548103DB3C1EDA3349AA6CBA52E4EE7949FD
      58188B2173C0557F36CBFB7A83548C1B730F79F57E5877D623D01787B9274687
      748C0DB118BD7612870C1D82D270E978513B3664A910F7B43151AF61909C62F1
      9B5732243C7EB4775E1C41B3D9DCCBF79EC11371F800D56D4001446F21BFE55B
      272577C399CA00EC0AA614B937F9A52B9A0BBC46CB9147F2B48C63CE453FB741
      27305E440FA60C82B8C801D0AA90542FDEC44130888E82734027A02849082647
      B22E2B50D2823D33DE5DE661B1A7CCEB5A5C1E13EFB02F71677FC50936E68D83
      E6568E2BF0934292AB35FE0B87D49B26B1E1D818A88E0F7AF7FD48EA9DADCDA4
      056A2E327A072899E7D1AE119AD06C52610B953B981F3F8AE5906E42B7D674D0
      4856888B32C7F6238475090773A083B56418D28B726B40FB6968945A4E9BDAA8
      9AEC74CF619DA461C92D1C285B179CCEFCEED26D7ACFC87080E7CD30B5F5E38C
      9BDB2ED9E27A37283FE648EC57C3DE2E7776AD6F05FB2EDC31F7E7D07E40B270
      8580B5207499E5EAEA62003032F5847C342CEC20949AF9DE51BB1F88DEB19DCA
      0D1323BF758183BD8EB54AB3A63DBECA8D58BF9DF01EC807BE88D7B81E30E273
      2EF5FEF3CC7B6A3EBFA013F3F9877368A80A04A3D32942E495481DF765179370
      94FD95BB69E0BBFDCC893F36328E642C59CFE4662C2D1FDBDA23D63048BD0B47
      DB9A418CEFD5C8218C35FA706E6823716C855EBEA06BBBB81ADDE06AEA5231B8
      C063732675A05C463811D70ECE9E70EE68598436E0F0022A02E0104873371A0C
      55BE08C5339013C8C94FE40CC4854FC57605B6A9BAE7D3A7C2A4D42C4BE21C92
      84AA15D775C53765186E9602DF545D711BCE7448D5310CEF41486607BD3F3177
      9928175940363ED7F2498A712917ED577E145AE1FC2D2D9A72A9C051DF87DEFB
      55DDCBE46AC83E29B8EE1EE4502F92793A54B8325615CDD5B1F259C7BA26735F
      A63D2F115C7995901C8EB2E65029F16F71152967753A2B53A6838C864059BC28
      F1D3D03B1980E9ECAA347E509301841930390E5114B9D4B7D9378DE25EC41097
      F8E1EEB4C78F18E7DB7BF39EC78C813532F58EF07405A45B2E205F76923CA5CD
      0A297DF3DA8259318A588043B3109DD85D7A90D31CBEFBAC1CEB15B27776CC78
      ED6C1A139CBF4B4562BBD7FB7C99480F57158A6174B5251E899AF96664E33306
      79385CC555284222DB98AF29C6CBA46810015E751B3BEE56A7BEC27861D93FC7
      9C3B1831725BB452A9E1BC9000B5B0910014B34EC5AD7C7E0A94F07869E3F66D
      120B65F1ADEE4E2E25816EE72A889A86CDC57983C5978D8CA36AE3CB0C44F172
      73431F27AED9519B60116ECA16BF08636A810168EA3372C1A68B0700A3EE708D
      373A6891194D2C4453AEF66E8E5E5463850E7F8325076A73F808DF6A95866932
      DF213EFBB92CAA72EDB3102434E0504E84DECEECD2198788DAE2531ECC2AF737
      0641B2B6615C086F08F489AAB43E086DE2F9DD6FFF20F453C13EFC4EECC382EA
      63AD1CD6CAC061562A1367C054AD9A7C6C9C81F39B34B28FA8E83A8F093E7890
      EA19D1E9BC10D197309364356B07CE8EFE254C58A2300B2298B16347E16C9050
      71596BDA27C56FC0C1A8CA49197F4750774178A7B591BF71F6BCD158BF6E31A7
      04BAC6265F84B1A63B49876BFE886D464FA7CA7568E23F9BF0E4981D8823F6BF
      909A5D61AD1897B7F551EC5819812861424C9C3E4287F7568323F6569C3E68F0
      2C2421E28C8F2977D744EAC46A81F1766406B48D93A9AC58678172B78B29A7B5
      6F627BDA4971B9D45EFAAD94A15DB8824448875F62A764B29D4AA2D9804B23ED
      8079E7BC6D1757B3169D09FDBC02FA61FC973E45F1E6D674BB6524A376278F36
      230630E832A38EEA611A0E722B4012E3E2C7D4BCEA9E98F71863BC4665C9AA90
      B3CD4602F33DA1B636D26221C35D92F925D482EC5FC5AE94BB178AF5AB068A53
      3ED061B3CDC540FDB4C94B0A416575A106DE8A31A9E65BDBFD259250528717AD
      0B62CDD947BECE43479013580E50BEB4D12B8881EEDE1E25D56C89E859A9AC53
      0C38196D0BE2D9054345EA207181F2ED71C962ABC4CDA68B2007B9A5D628B1C4
      515615349F02606D72BFC95B2A06F4D7BBB21C8B021DBEF9B62C8F43AFF7ED0E
      FBD6D996EC5977D6E69DEECC42DC46BE198D58A6CD28950618E6283FA76C5249
      D8AC4F0104F798BFFB80B61961A99AA88D7A036DDA40E5916D253B8CF16A2970
      0476D1BD6D34373C724D1AAE5A12CA6C076E0E23DCAB420C6AC11C530A8F492D
      A0951326537E86816777B41170BF3671104B4F3B162729C78C66432F4D7C8FCB
      5DCAE37E77ECF6709224F46236B414D285B836237B874DFF287EC95A376CF892
      81647273EE6BCC82F23980BE7B7BE7A5F76105F1D46C0B15ECD5EC7133D88FD0
      73955C1C4C48C5B30EF3F481086B745185D7DFAE7F37E1383723FF1C35BD7389
      0CE44C9E803312326A908EC9E4D3F7F41423C8536EBEB31B1CD7F67E92AACF59
      73F0E63C966EA5B26D5C2E281E3FDA90214146CD75E2B982618B3DB361B3EE0B
      0715D32FF28E22A1F0AF74F24AD20176A40D03D44AD4FA3A4DA2701A3243CD63
      45370C89AA9E65C2C572ABEC55E8AF4ABC726DDFA4216C4C3A89C24B256EEB9A
      1D96D2F2832D76C4F0A7BF997A77BFE7CA76BEAC6A2E5838BB3078DF263AE53B
      78DFA6C3DEA4DC1552680E36D4A2DAC5DA41801AC982C1178CC78FF831163E5E
      DF9AD30ABC2B0954D37B8D1DCAE6694C1E78AE738E26566D2B5C59CB080C2048
      FDF1D83028E6D1B6609424EE78434CAE148B0A8546D3155D080A4BE13D050E66
      B45F566B099F81801D73D0C4599A00C1A78E85DDCCC70E09CF28E57886F31A90
      374D35069957A0A42BEA888E72B695AA93847171C3BA2254A03C9DD4465C6211
      3E623E16EAD22C37516D4D5A383A64DD0297A4EB1AE0E29A6356E09846F990BF
      1AC511E1ACD4DCD1108941944CD00ED2C69436BFFB3ACA8C4C2073751F28C608
      E04205B7B315650E7A566E43CFB814A0F4BF32FFFA51C03639C38742409E4592
      E363418104EB8AB531340698EC744D615EE1A8F06EC7A54F34AD2E9362632318
      FA5A4EB72E9410B76EC0FEB85E024290709294C154B237FAA97440244788463F
      DA2D12DE5B73B172F14638C88C6422C11635F77273FB2A48F261329D723A434C
      B631505608F83B8708136BCDC417299F43C7487C0BE65F1480B56813EC3B50E1
      72634868346A3A4B803ACB1C4173E1B3FF721EC3D94AF63386B523F676C00056
      1CA62515EA0E24B10EC1DC8C6E86C920981FA9E0A807CA8E3F9B99DA1F7623DD
      39D3A6F5F982A87501E4BCF3DA4B8F1FB1C98DC28D7C72B7C7878929A5B56F3F
      7DCF855B397FBEE1D9EB4134D40DEFFC5C1F1422B2B17C1387DA6EA0769F16D2
      9DD3FAF1A3556A7FE763BDABC6004B383686F0EFECEE6B5FE5D4B71872921452
      999E1C314EE9BF531FCBBE0FA3795029B7C94EE38A85B71628A58114C0A80AA7
      B45AAA58A7B68B301E969BB936606BE0919BB0CCFD4C718442181FCE227FC8F1
      B40997057E8DF0A958204556BC965CBD8386F70A76542635A0292D2454512050
      8488C3C08DE66D31DE17414767139C5EB50B0EFB8563A1DCD4517E3B9F0B224C
      0FF482148EB194128FDB966025670961DBC26694DCAD7D45C647D2A06160A5BD
      8091BBF57826F3310216EFDB433D658A3082A53F8EC30C287680F6CDC0C133AD
      37FEF68DCF90EC260406975ABDE75D2BE10602810241A027A88CADB0850D4037
      645E48593BC40D73207C0031CEB5C7255A40D30B199881948841AAFC4B012363
      3C66CD6900AFD8ACE4C378CDCBD01859AFF3F213D36C561ECCB91430C67A07E4
      765464B8C84FF9348F071983656CF0B599662E48C77012AA5D9206F6707696DE
      0A36F0B901B77E03A7A154EFB97675AE9B84BECB1B1FD55CE18D41B78322DCF5
      6FC3CCDC862FD0BF9BA7E5C7D7010AAEA11F7D4CDED2F9E05720A879A2E1E1D3
      55E0A7E8767C941F715FB803B03572A26E71B01483425E88304363B96BC83627
      588A2C0F8CF16EBD016FDFDAA839EE1AB5F503C728DE94F872F614141C04998B
      E86D1F6878529D828ECDA4FCAFBC828A619938881CF5B4128EB55A9894563911
      678C5DCB46275C996111170EC3AC79F6DD278087C1E95F59548D38090A31E745
      A899BC8F06158F93D2B09E893D8D4B1BB4C29C10F68582B5FA2433A7973C5FBE
      E802C821D8CD0D0CC22D4321D8DAD49F56A051859027315FDA3DED1066962658
      43A4E9A9E6B8C9D64607BA5C6EA2D8D848F93161FA732E5982D0DFF8289A37D0
      AD4FEB8C4830B25B93D0AFB954882C1145FE8B1550346A7B07EE417E6EDF590D
      B20E1ADBBCCC78CFDE08B105A2F09FE842DBF73903DD3298AC922F08617E9607
      06B81C3AADADB148968391D176F518C8BE0403AE808BE4CBCD62B6315DB06884
      3B330BDF19974986CAAB499AB50E8D0CC9B00A32653ECCE62962964BC9817DF2
      AD0B843CBAC71C303B5FCC4B395A9FBC375553E0F17A756F416FE22A27F10A01
      7884D03A8F518BCF9284942A82839E23D337A100DEC7BC8801A6D9CD350111FA
      1E1C6B6C914D0936B529F19BA65E5D53B2279F6B089B916C71EEEAA16A53BBAD
      3EE1ABCE0639970DB2874DAA6BCCEFC79973D06BF7F07CE5B168A1197DA3409A
      EFF1ECEEFDBF7354282F8C302BED064A953D3478702E50D15361626F760AEDDD
      7BBEF49EFB5A7DA055B2276086648F1924D766C9899FDAE41A399126EC40E202
      45ECC946646E7BC7FEF71E9D2839E5DF3B7FF9E60D4E3D56E41821D31C9A5BAB
      975A1446B0D2D11C68B2E1FDB5E11D3281FFE25DAAA55EAD9321BE940A1A0BFB
      DFD110BFD7B0DFDE01373313F83ABE427DDE4635EEED566B8911B9738E6485A8
      B0145178DE0B54B2C980309CC140283BFC457420466930E8C7121B09AFC2CD24
      09ACBE0B8F69E7D966A7521631DD28594B5AD9D6CD7B859B57601126C3945C46
      7982C6ACE0A3AA0F363738B441DD9600154ECD8309A80F309B63A7ED76323983
      37D76BD20A156BE3001E28521AD195601AF4A35D227B444C5954230CE7988751
      40527B6D0E6DD9207451D8C24C6C75A03EEF100C63D0C434432283ACAD029D0B
      5CCCF66C8FDCC9A6041C70EE253A4CAC2B1A04285074C2EE141BB6638257DC72
      2DAC3FBBB67F89AAD209EB451C48042B6A78095212053212C6DA11230EAD8199
      9850641170335479E49D7EB66BD1A0F72C69364D805D2D344B14ED83E9A6CEF4
      91C02F7D452A90F3F28EA7F3387F9F11873929E61ACB50AC1FF5768E813A4F52
      F20F8F552CF1411CFABA69A852E453D31EA02C81111AA2B279EC8067CB2A0286
      408575A9C415235C7368A8EF611539DC53708E18A77490C080369B078B3F7378
      1774005502CD1BEFE2E265CDE9CB4DB5A5778813674F944A2CFCAEF7286C906A
      C0FF48B8DF7514A8A5D74F26E2302FD986AE54D60581A1A1A7816AC5BB047534
      3043D2A6F75C0AC699025D74704AC8F7FFF6D9C547E0DE03BBD56D1481736A93
      D0746A97BC3D4F705361D54C172B0BCF680D39B7907E15619801450522804E32
      97AC9A2AC6146039311C8658A9DCC77D4C8C074F0B8A0F8F884706638DA91ACF
      016DD4994A6626F33E486C69511F9E5133738883B61CA6411C1A4D44B8F93952
      887273286DA910A650312C2D5748973670C81C0DD1C2205131E6D40BD47167CF
      A0E2336B94CA81306B082BC0B7859CCA23109B15C4E4DE33789CDFA16F2E7570
      5332D8A67ED11A52AB5D23282C3DCF8D60CA29102807314DA4B047290B586F1A
      8ABD7FCC619A4DA17433DA3D3AB6561B4CF5C324A53B959B026C409329136970
      6EDCCD4795571AB2140845CC9C4DBE6698A2B39F6E8E79E1BE5257B187771F78
      11C679513E98F34A84A080C9DB0BFE79FD7798925F8145BC9EBE48601EEF21FA
      A7E9FD84799D8A8D13BCBA8165D9282F294AA8248E93749FC0147088A97E8335
      5C048977896B6C812DD02F298251C2C06A9DA5FCD433C51AB1E441D5C269D16A
      5CBE8E759272CD58F2DF88314DD8579DECEC78CE72D943A7045CA9B0DEB501CB
      5A4F1046A5BFBA67EE02E62197071B3D70EE2DDE3E092884CF5F3FFC1DEC59F1
      C585FE8C74A124359CE4EA15765625D5C69E15EE418BE30711A8647126A39FFC
      789B5D437CF7AEE38E135BD84C9507BB3C7E44513BD339D06F945B869181D135
      CA6CE4583952184487A42A3CB90E00BDBDB2810B628B8D951277D620D7C99037
      52CA32688068EFE0946647B1E3F0ECAB908EA49C042496BE03B91A61D01E950E
      A7328E016515D68CB1DCEC6090FED90DE01C2628B4ABCED55BCBE55AA553B90C
      61429A5CE79534E59D9C0A74E4B2BE21762CBEBC78DB807FDEB0887A930C7DF2
      260A4C2F65D492B99C43E522557409DE800751EF9AED0776B23B7E5023EFB79F
      DEFCF787EF5AF4BF76EF77E43EC6B79A974EE8FF89F6C8FEA7A6BA56F57E5A27
      E2BE548130643C30266A7F0331E934FC6769EB39C52D0CAF930FC1811A4EB91C
      A96A0B8C1046120C93C0A0FC3B42AABA07B05842DCB5D466A92FA5D83E984371
      E03D5FAE19DC69A7174DC8F57EDC9EA666E6AC19F8067B52348A7ABFB9CE74CB
      8936512C77D21A6D8CE24139DF615A21463A772388FF3764911393E7286F9E42
      966A0DAD62ED5AC9E23EB7D8D849BC496CD70B7D05A97C3BBC87D42F22C21A6B
      62CC79026CCA44642BAEE962AED9B80789D15BC12B6F7A2637165E5C6C7D94A0
      410EC50DCB136AB0C256EAC22C721FEA4D524AAEDF7E51E9F2776F255A89426F
      EB7D519E4E5F5CA7D63C69CBFCDD7DE6E63F7026F1E03234F3781FC99B8712A6
      E420EA5B38BB24C7786EACC4B9D9744FC24FC647BC715ED77D73A8F8300F15A7
      403451471B627F69788BF250D0E5BDD8D931ADEB5B992E13144EC1971C3CB33E
      356C94B4B58BB50343853103D17C0CBD6966D7990D107141B20A95419C00B57D
      89260E47DEF9C70F6FF00833515150C44A38A85979D93C320FFF0D11E17EE7F0
      D59A837F26072FD732EE9DC5934BE53E597B0ED7073C17FE44CA164E70763BF2
      6DEB9F13EF0FD9D6AC00D89495B00EBC27E1EB36E363AD8A711C2D2570F7E798
      8B18D3B7171C399D1B0D24A3684F3C097B364B280F34D8CBF19EA89453B9CA69
      E2C3B775AF795FAB0489587DA5DC2EF0CE36B942710A2CC41BDECF2F3E348C57
      E7F5C7B77B40B97FCC29789CCC3833B6337529A653AFAA0B02CE61A328786162
      7C1CA65471C81C2F8A51C8DE92BDE7EF2F2E9EBE79FFFEA30DF087B7635C6621
      CEBFB2BD8A792EBBA93876BF1C3EB18027394F633C3E8DBCBD0B3CDBE34295A5
      878E3815DB30114AD0C668098B8169AD63403783CA334CC6311AB10F38F754C1
      D96CEFB587FE7C0F1DFADEEB27538F7CFA926A802F31B13726F51C14A6140983
      56BB5AEA96C20AA4FEF849FCE40566CEC3A42C2649C1E85A83316C83A45A8357
      30F1B94E887505D66B4AA26DB247142603A3CD5C48C4093BEBF65D1595DD3CC0
      B20E0C0CB53166C494FE46A1CDB555A11CC1C9BFF2A6184E1E3AE123F5EA37E4
      79055AC2C79717474F2F2E5E3218C8FB5E0323E67D52A3543036D5A9F023420A
      5C32838FF9BCCB09008107A212F4165379285584C5694C6C24796D9BE578278F
      1FB16471B13F31FD98623F6399D0068291C4F2CABC77086B4C01E981BACEC35E
      F19E29D5990A47A47D654D6FFF8309545F13786C184089887948A351F3004B01
      E07BCEFF4ECE5FDAB5FE20A4F0763D998FE0C08CEA679ACC4DD6945B76780588
      73A5B332928554C74E2B01132D2A1C0C28989383CFDC18D64217B40902E63C64
      90D923500828C43E8C319194C3396347DABF7BF6CB5B96F4140E921F68025075
      319F7D8C3E398A860BE643272D8353F0418F1821FC0BB424E9B9A800540FDDDD
      BC648704661B6ACE4CC07CB97028149785A70D47C7DCC1C09896AF2AD03183A5
      344C60464175CBB8E4B0714252137C0713A8F2303EAC6740E4DE1561561C4748
      61D0C0A83824A090C9433BD3EC881DC29F376710B1D19DE047803A1FED86A581
      112D69EAF707207CF260ECF223EAE347AB4DC116A25C5DF8EBF01567B298F31C
      60AFFE984F6779A0BB4DA297FB9CF0E38687AC9661BF8930EC92AE31BBAA642F
      24E3D447F0807946A04B629FA0494EE7B3DA09BB1EC6A38CD510B7A49CFF2C3A
      4828FC468A8FE01388C498E7C912BD1BCE454C8380F6AA20708F05BA31AF5AF2
      DB7FFD6E010240FB27D26106404C566793E56067531C5FFC6A5BD644BA5408B1
      9062CAB4A7F0AEF77FC78373B69AFFA877C65888B95A21343323B4B1604EB846
      060D3336FDB14BB27143A791D2CE52E52194E35B30AC26636FA0C21EC6F33A14
      BB52A8B0818ECF128C14AE59C34A2D00973879FC2F6E41E00F01B20617BAD2FB
      1194A997DA8450C9452A67F4FA05FC38C624D68F131B7E8C405FA84E1EC0FECB
      B21D548ED74EC6530A27219B2716F9943D19D1299494517F988262E069E4314E
      B5F37A4FDCB02728120DABCE65BE37A3B875CAC4AD77483102770F28548EE522
      24245BA82DD32B19692C21040BB60013421AB411C2B03B1684C0B348F2AC4CE0
      F8623C3106F19D746638ABC101924277D1CACF1DC0C6E93CB3F756217625214F
      8801BF89181C98EAC341F0AB5D719D1320CCE0BCC42990760D4925D23CA7BBF0
      8E0ADA82F811048E89E19D536B7A7257AB05CCE0E019E9A711B56EC561469432
      1A4707FABEF1E6EAE9E5A63C6A61E892E30D023A8CFC943329A52886CB609B52
      4DCDC5210156E676C992993107CCCCB95BB60A25577775CEDA7D7DA905F72156
      0BE8CC0A3DC884E14C3507354D6D4D39363818DC2687063BF3765A2D947CE2B3
      35D2E48916BA65A73AF0E14DCCF91BCE22730A5D91D704BADC8439A7F39AAD30
      BEFFBDF79244C605080BACD5C2150E2B50B2C148E7A621DABA70A4EFFDA08697
      18AE98F14E084C194F430D9079BBC5EF02054251C71DF2D8A00F77C434432A9B
      24144BBCBEC62807968EEC16A2DD942A8FB6AC7FA21B26658712F68FC907E64E
      53C74FBA28AB22A698FF3107345760A7EC5F0C0AFD33555343EB4FDC5F19676A
      A22640F110AB0D4AF99C634E9855E55A0AF795938883BC7ACFE7AC549A18CA2B
      D26B2C88349F5D58FB649DA77E06FF61734805201304FA671444EAD31A07D502
      4084B3297631C6DF971824C3E776405C7963CD19AB8AA5ABB53933446A1DA661
      DDA4C855C032513931E13D21161CC8FC38E3944062AA2B43678C3FB3F619BEAE
      206AF9514CEE623DB6B413F68C29C1CCD5F1A611E10664B215BCA04B3FA35981
      0FCFD911EB7B44CFEC27ECFFB3E74DBE670CDBD5844EE35DD8C202874D102D63
      F4816234114608B94F73FE38C27FEDD85311414562BACB1BB90BF111877770E5
      D567A21B8034C630125970548702B8DB7772CB0B6C977A59AE9B35843C45C254
      8716CDCD8ACAD721225A3AD6C5314A9C34998F2785CD0DBC31EFE2336F9F1307
      2DF6C00DCCA0804526BCD84CDD0AA58C135A5119C4C3C1F2D0026110F7663C71
      2ECBFBAC61135E57AF1BD15D8131E78FAEACB25FD1C24FC53E24981817F92A5F
      B3CBD5218D18EA2575522A61A62C2CA87A087165979668D2FDAC99BCF12CC358
      7C9826EAA2DDCD5332EA6089080C964038BE94D50C231FF0977D2942025B8826
      E0BA1CA986D6F42AF73C90FC5217738F500A6686695938597CEF6EB209A32F72
      6079687B348F7022B1641171B934877B25715A7897B870884F836432C5830B84
      9123BE75463919BE99810630AA2A8EF149C6C003C95891DB17B38D68C918A9DE
      AC02785BE8004D8D9D18CD7E3B979C22DED8774708A2F2F63C58AD48636FFFAD
      6F1110D8584713262AB84802911623874C36DED4E57B5A39E411E52F4F3F1685
      59FC8C41B38EC92C5D00467F87C58CF14A16022E87CFA9145D263A7B6DD028D0
      D5A0C65AAAFADAC0139B434E0E55844604D824C0C815EB15B87DAA7228F33A7F
      B57DAB90126E9E42DE80D8224A23F7B0E1580D619C36B151CF43F6989BDC62CD
      C6FEC2A9CB736095B139CB9BF293943D51E2EB6B7361E93C3E272F0AF9E3B102
      84F7A38A660DEF9DBA9E6B10FEB0447E08B31FE78306868DA2E2D3404902723C
      55E81BF1C7AA0E6259A3E536C0F5158F983DD720CAF0228C836461A6C14452FF
      D947CC5FC4A722EAF609E85948ECAD8E6F656495E366A9FF3098E2A868B0A3AE
      D77F3238E9C3D6FCB4618247E161F71867E1A4B3C34CC3D8FE18D2B860A967D7
      F86C85B98F74BBB77101E0F377B304CA738761F378877066A5922713FC86ECAC
      006DFA2D4D6979D49AE103302AF429E5DF71EBE783832309CD8C98CA10578ACE
      1663B1372ABEADC21E2240578BAE99CE63B2B2FBFA4192EFF123E69E403D3A6E
      91428DCAED2894135C84813C194839901AC98CAAF238474643DB3C4A25A5C86C
      209276AA8A3E309A88249125C5D602734DABF40A0F161F941F1D92BA3FA49A13
      648F23C59DEF67247D3C990AE9102CCA7B89F96318A31A12C510DBF841D2C8C8
      D743EF6534AD1644F0F851FAECE727BA209A1DE6E3FD3722698A5EC808C47064
      99670407AAB5D433CBE3EB93789C507DA739226516D6A75997B572553A29EC88
      10F47E9814E606B5C2B401FDB498C622F5E06DE5838D2EAD157A56F4C4B069C1
      C6D4E65684BD17041296BFB0B44161EE6CEBFB0C346BAC8A606CCAB427AFFC30
      E2485CDF1B20C028C6376135106356E7302E02A5A53E4B0F2414CA547DAF7766
      650E9BAA6948D474C95D6FD03C4AA2B00C6D2021D60F803E47749AC18568E8C9
      2B71971D804FCBFAA532D121555917B326BD555C5776A3FE76FD3B3B1C72E4E4
      2CDF1C84A62B0C832AE1EC562106D3C1C8DE90E2864A113930492DE0DA4A6D15
      294293773574622C6611C60E933DD85007DB3301C4D0307908E072AE55A32D54
      A5533F66F5D7B45F1EA6221DA83C56C19235991346334091CF4CD991F84DEF15
      6B01CCA9B4E37DBF92B269A1A6D4A07C700A0EB136B69D9803C5388AFE61FDB6
      7034A05809F467CEE3305BD6ACAB02880FE55FC150613FE0D9AAB6C014B6F03A
      7DBC7DF66BD15EBA0AFD1500F30D897707E5E7D4DCC8834EAF09106D076F2BE2
      A9723FB5819B0739144EE753E9376C96891F49D08EE45DC84F058409299654FD
      C546C5B0658D2489AAB6386DB2381D7DEB16A7C78F2ECCEA38A45535945565E0
      EF433ED9555943C59D23A2CEDA756C9148F28463ADA172A9C4A1185234825CB0
      B92F8DFDE8DFE0AA2B4FFC0AA9489AD82FB2308B6C52ECBE8BF77520A8D51526
      716D979B90CEA98499C20A6500004A7064D50056E5802016FC29D678F2F3D937
      9517A84F3AFCA7DA801E61E6551217C5FE4CE147F8C4839C99C78F706E3E226B
      E7C9B1CC34B3F4D037D082626BB8D825C987DC10698B5C023D872024E2724FB7
      3B07D40FE6B536A8A7D00546F6A1F84527F5E30112FF628A21408718F031C034
      45B164DA79A14449DE40CDAF3D45E678912519166B312F72360A956D5582E234
      AC92F4142A3A8E3B7DCE93F5E950B2DAFACC143FDDCE267059CCD28414F08451
      39F4249DC7979E4E3C5B7ED5348AC3770AE8805CDBDAA5E62DACC15A13DFEEEE
      C13988933CA518177779F4C2749681004D16B5DE5E3C7A6F24674EADD543B88A
      A900EC535309B6587A6FAD405141BFDF314990F22C6A0D7993867CFCED6BC820
      05A65C5FDD8FC94C91978E64EC6E584154FD11B1B730AB04169BC97D33D09FA4
      F0818A96CD29E6F8B98AC3719CFF9A60DA071AA791BB4EC22028E702F10315F2
      AF477C02B010675BA9696268B9AEDB0477B721EF41C3D9D844347E164987863D
      4EFD7DB8143211F217B6C4715E68A1E2127B0BFB2E443410040873B9E2DA5A53
      35AA6FD5E22464B455B03A59050ACB3160C62C388ABA910D20AFB1B34B8B9C88
      D0DE7BE1927DECFD62A9BA09543B47443578318325D9FDA75A0DF756EB9E782F
      A466223391A3D66E71D682F6C68700EA17D9A747E48A203400F223107AEE8635
      C03974660C553000ED30F75573DCC4A14D92C8E60CC28946C31E9FCFD8FDB088
      B1ACFB0197860412DA9ABAEC3614ED86BB6D82C1AD75C79F267376D9632C45F5
      B4159549803B6E9896F1433085F2C29C147E91384034C5328E34C4D0564FA0EE
      6154904D10635A52121391B2666315D91815532E3FADA28AE247F02F197CE165
      B0019594D0AA53C1B7F0A967D18D64DBC67B18D12A9D57DF64CED1A2E1CD632D
      01DBF83A2D9C015403AE7BA90F6C0800F56C275703DC4F813B141C9E993284FF
      A372039AB3647DC4266B581C6B4ABC98099EA8D9D1A4D274C823525EE22344D7
      4C9424E8EF15609730C710DEBE2EF3B5975D9FC10124BB6E9F763BF0A773D23B
      853FDDE3E31EFCE91DC17AC8AE8F7A6778CB71AF8DB79C743B78CB69A7D7E3A7
      F11658E027D44CEBEC0C6F6AB7CF5A7857BB03F7E1DFEE498FEEEB1D1F1D7FDD
      050FA3FFFA40B8CF3CEF39FEFFEA0AD8763FDC7CEE79CFAADE7E5EB3168B8E47
      2ABEDD8166B7BB259F7103D4CBFF4E97FF0EEB1EFFBFEAEDFCBFEADBC4AB774A
      114D91651FD9D1C394111FF60D9A586E3EF7BEF78AE673DA4AE445BF7348F17D
      96DA075BB1C461E45FC9AE85A783BB1FAF681FDB07FCF5C0D3259946FC95AC96
      61401AEB4D044759D08CEA53C40D1E6C5B5F800E8E1F6BDBC51AEC447EACCEFC
      4183D1FAD7FD7DA9CAEB4B0E7CC94996F20DC98EB139AFB14AB38B5420EDC0C9
      FF9DA0DF3CC519C3C4FB9D821AA59D3C7AE352A999A93E86EE45413910D025BC
      598EEB98E45F6ECAD6851415E6DE68FE449B8ACF6037DEC2B798A96992540F54
      FC68688CB67B6BC3A30190B164124601BCA9E121D5E058A3191D815FFF44DBCB
      6803E11153296F07DE7C17E4BA8F8918A4803AC3B9CE63522FD5920BEACD75ED
      28DAE8283AF9D61D455870EF1DCA91FFA4A56F769D6C1E45E96BDFE0CC968F2B
      8BFEFA8B1912310F1853E953CEA01FDE905FC6520E0D319BBFB35379F81F8687
      C2274B0CF8FCCB8692140F6AC0E76C337E912CE2EFD87A6DC65C9C763BAB489C
      4DA3AE95A6EDE2D960A10F51D031FF27185581602B90B3C239FEFF16558A5111
      4B6F7B8BFAD5CFB3A7B886BD7D8CDC38F09E0A143CAF6EFBA311B6072CC24512
      5388542A09083A037DC34A67468B131B6E75CB2975FC5910E4DD791D6B956637
      F46080791FFE30C7F5E7438B79F5E61C342709CD58A15F5193B15A50EC9BD344
      69AFB5598B7BDE7EB0629BAE0EBBC6630FB0844FD908F1A6D93A796B4E5296C1
      A13183060D82180EE045FE40457A8D91D47CC43DC93884DACF11628D2128740F
      6D85FACC3CB462C50D1316C9005E368CD49455A125BFC331A5DCDDB18AE895E2
      C245483FC4F472C265578DC6B1DD5B5A7A9B2D6702EA89229E93ADB44D6431A5
      A17582F29F92E6EBBD59796FF2F10E4BE926F374C839F454637E186684CF4F30
      A9060550CA05ECFDF6024EA4BF7381755840E4000B03F5143D8B084954836FAF
      B93E25C79BE1960B04AC10430134DE2F109927E4C0121B6174D21CF56D159316
      1DA1365B51CC1F9C0DE3134E0FA72C52A565F1C5FADEF9CB376F4CE4B5EFFDFA
      E1CD0BB23A7A1F5EBEFA905FC7BB0E4CDD368558D77EBA2C9859603F9AE58321
      5CEB8B8BB85AF554CE546138862E80CF0A4A46B9B6A00293FEC170E64253892B
      D19BBA673BAF658F542F998427133496A1D3D849FE37F123266909738B1116C5
      F6C6C4F61B2425ACFC9831F2D8BE65EA21DA7BA4A0EA0155D85CE95FCDF6B66B
      DF39983B53B066568ECDCFE42DEF4D57C994A33E80C0CE96DE7E6973284F18FE
      D246723168BFC1B5402E912684F479FEF70302EF440697437316CA73B16057C1
      5D1E381FE81ADF7B1DFF010C9FCA716977126BE15C994CDEBE052931EAF66AB2
      852042A2B1DDDCB221C453DCB6624DC79BB8EA8C49D07AA7CA2B0B3E7EE4A237
      8B399F84841128543AEC0F0EC136B7EE7F6FC58AB964629A7C83089E57ABB5AD
      32DE2EC1D3C2F983122E8743AAC547A9ADD2FB59AA46E1F50EF0E6339BF215AE
      BA7F32D01BB81E8722582CEACBFB010E07DE44E71F546310F852CA3CF249C027
      A4DA3433B1A1AF92D26E60DF0F8C32CB700E467DDA2D9696C241B1575CEE1186
      B554595E8E369F2E91E44C6FAE824D68A2B9CAC4673BF8B93A6CF2AF5CA6F93B
      F67A99A218B4D0DEBDFFE809E8B31F2FF3329E0C354AEAD954B019735F984C2A
      7F0BD3BC186E5DCBAF021F11957EB87226F2F6CB7736C1BDC1FD8B34C458C583
      FA0CB54EDEFDC52A95F6F2EAAA85386D537A85D072B7CF8B3D3AED0C64F5CE29
      67E3672B3B0FB981E9A5E25052A95BE2068D5A8CEFC29E134D7F573CA18DB4B9
      F2CB43521F3F0A7D8E9445881F93D1BBDEE542EFA4A20BAC9431C1E963A64E98
      4E59DE496D46CA3B191295470E27142C639453A6B319262E23FF922709E17E1C
      9A2A25C3491272D1DABDFF56DA9461DD2341B1F72EB117762599583BF2642EA7
      FE8B147731E4C00156A0E41A0D5CF4A81262C84973DF99C122C129734A1E5BEF
      E981C18FBA79DEF2F74941991DCDE3AC5A104CE2AAAED4A0D298050B07EEBA0D
      CCB00225D716B3B355F1444D311645A345A1AA5743AA4E44D2DB846BAA84993D
      2E4BDC861046263A7F005189F31D0C6F5BA12B23714A8DCEBC1D6D943973D7FA
      4C19CA33DEC52F72043A9723101FED2B30C351E91D85531A74EBFCEF382A3ECF
      F9DE2C9A8FC3D89D409B653C9D476E21955AE06F974894F5282707AC1F89BCE8
      E5C59B5A681775642B1E3302BF97D34EE13092ABF9FFE1FDCF57AF5E71A12090
      0DD3197BF3F273D39481754670AECA9FFAF7EFE9B1A62DC73682435BB1DA4596
      E05207553876DE8DFCB17410BBD7B5AAF5F26F699B7E505CFE3CDFA720446AE5
      7A635E281AD61122D9C83BBB7835B44A952BE0D06ECD708EFFEE662B0A696BDB
      D8E537BCAD2A01DB751D5B2575A6DC0B31A1005A0CB82295814A9B5A938DA731
      170F112831F36E84500E8E66C5FA23AFE81AB6A6CAE2FE41C52A0545E89F8AE2
      64617E4905C4E5F7FEDDB3B736A8E9A1B0832F4C7A7028B62DEDE1F05578FD13
      EAA6B081E3A1AA94FC709BA1A94F6F3BD1A3CA98DF25F73C6A6492F73170CE8E
      C0ADF07FCF44DFDB885D0E2450A4DE98191486BE39CE06B6E88378A0501E1452
      53AE6D2D28FB541471FAF2E26D38AA61842B05A145FE8C9D0DEF2831C2869EF9
      758902C7B429A471D38168950A6EEF6F87BF7B7A391D249104791421C2874C66
      3EAA55AFC62A9383C69A14B4B7192C6E362309E8127BD7B4A7B324CDAB8E6298
      57057B1227E6E08972368B4225C54D193D0446904364D1F971EA2FC508892117
      493A4ED04659C46EC1AE61868F05F616CD0D5F324C484F1BF8C34B2A779336BD
      7DF61549DC9A18012546CD23C3111E6729A92F4E32532BCE897353D73E45EEF0
      0FE6490EBAC1778668DDCAA11AE0B8CA7828D46085592F3F04DB528F15E84DE1
      4E06E2C5B8F7195386F0EE8D1A8B4B09B1EBD324CE72A37DA01A265E91579259
      115C417D750D506C20ECB93026E4089771E2CF2F8556EEF4A30101D4F49726C8
      906EF533A715B448E39141F9B1B6D9EB18092CAEC9606D3998129A41056AAF60
      02573F6D984ABFAED794B6A52584219A53D89C7713D02508AFC2600E8722135D
      49B5ED8ACFF3CDEEE3761A3634D0E4C8B67CBF427BC37C2BFBDCE6BE03F823AB
      E180DB16B46F86F5F12930AAF08E0AB42C4C20BD8E217D15A57C50EE5BF13566
      A8D51D06047D129A543CBB8225FC1416714332EDDC02BDF9445886867586B10E
      C27CE06E041355AE7488AB1A237E293E9682755BECF676C15429D28BFDF17A23
      EE9A78A331CE5A00E9FC28AD42493F583282B3DB456F3D213D66673DBB7F045D
      0547668371457EC084C0680E6ADDA45CE8623C091B333D3648BC4266F9234C49
      1D99B6829A5AA4D59E65F0C6A69313CE642AE7008D21D6FBBCDE0DB108B3C718
      1B8C704C44DD11FEF29F244B0AA8C2F80BE79B954B5D27F4B330FBF8C35BAE0F
      FC57AF5DEF9F0AF9FDF9A4C70ED65E1E99A58543D6BBC9DD4D56C1B7F03C649A
      5CDD480B23AC73AFAB13F3A62D716F887F9354305BFFD855611817AF0030C876
      5B5442082FA84A847CB6DE6D0973338EDAC4E842CA1F4E9C11601768046B2DE0
      CFB5FCAA9E2A3A82530C1D7C24B48EF4141B5A5703805B8ABDD8481F5095E721
      2BCAA9A233C2908E3F292E58310BA11FC067183ACE6F86BB1B5EB3D9E4DCCC29
      46138EB13CF838DFD47274DFD35925F7C4E347BFD93EFD4EFE1BD3AA85A48913
      C9B432BFD8B327BC782C681AED16EC2BD0F8255E82B3CCB0F7460F875533065D
      5DBBC3323C440A740C7DCE10B5ED9BBA2168CEDF2D56534035A4D2A7789429AB
      2CE18A03ABB38196803CF81C0672A5D22CAF6F1D975784017EBA84E3E814A342
      6B3E52EEA9F1A7EA4D185F7A4FBD57EF7B982F83DF6AAE9123773A6431413CB8
      D35EF52E5E1A75378C87D13CD86173BC96D3B3090AD214624DD21C03BDDFF738
      9E4A5ECD16189FC13B751EC748C58BE50296C16EACC439E661DB126E15AE9932
      E8D48AC774BB0ED64A1C54899177AB20ECFDE467933D822A1205015518F9D164
      6421A3A91EC18E3CD9F434682033F41D6EBD411BC2A28309E70F3061B6968175
      B203AC6686CA09E8644C07DFD88C76E37CD6575E2836CEB0F6D6E340EB08271B
      63D3D9593EA8508A91454266E4018E304F4FA03A8A35E3ABEAA2366664D79CC9
      AAD5D4DAB047E1755D01D1658911C65E7A12E283619E1B29E608F2A91FD8CCCA
      3582DB10639304078B7BBC5348C8EB98E3CC86BEE61866AD6C9CBA44E0628DD9
      851B6F338FB123E39862145E7F7C4B366AB2221A800FE777CC439DC30126DE81
      6B3D6327633804EE889D09F53457A9F2B4BA0AEC3510F3399E1505361D882E8B
      A860FFDB44DD862DF1449945A6E8DE9A05656102D1C5BAB36AE115306AA3D739
      2803301898358C6A27FCF51C4840D2996C57C5E43C58628957B1E7B4F2841ED0
      4BF12ECA90865185018FEDF1A31DACF53752DD324E26E61E106B9E6289D9BD0D
      7493A112F01EDEAEBD5FDE3E7BE1FD94A2BA9A914F6BC4C4D9BBC8D2F930DBC3
      73C3DE33428D849FCC45F2D07104D454E18E91E02834227325E14AED3410AE1F
      BB9E0EC22CC5EC25DE7F0C3BA738762CAA6274BE426C8B40ED90F4F43A339A4E
      417740D81AA4C98177314CC399EC7D8740AE79E1E7D770D40281856837E4A940
      64FFD41F3F899F20BC4B6DB32E9FB99F4935434D26495FBF20F8C6C81F33F3F2
      290210F61D45A0D7C2CA110D1F5F5E1C3DBD006D5D54EAA7AFDE9F1C7B2F5FBC
      FE6856B5933480222487CD69983C105B1A679686492A01FEC3D9FBAA28F43B28
      8FD609CABE7E936EC5C293BA876C3426D53505ADD8C06E0ED48AC4F2E5E1A6F7
      1C134FB3E2C1813DBE7631B1E1026B67B010E4A2DDCC2DC5964176F33427055B
      25A9E4D59E4D363106407357F550D367F941C653311C8B0807D507AE623A8981
      EC0BBF8210586A3B95B086F2C9247AD8E38D21E52A21C93641F1A17987B84022
      2BEAAB94E4A7A830091F33E284EC1A880F880328442B904104766CCDEEAAB918
      38AE6228595E70FE7B4A24C7F0685895359F73C1CDF92098AB5D9C42C156F72D
      74AC0229B51AB0176E1B50789B517BB00B3FFD0903BFE358C13CA88A63689CD4
      F77D1424EC20C118A303D7A8906FF9422A7D1ED45FBE966B8E502E225875C4DC
      3A044ADAC7B9F8F01E15509831444B62B3596E1ADA47E0A486F7ECFCC70F6CB0
      6F786F9EBD83DB7EFAE183DCFCEED92F6FF1716AF12AF4ADB29A1030E3FE8131
      E594AF583CB968D6840F6ACEE468604CD28681ACDA708E28CE271212365BCFCE
      AB63959414F3FFBFBDAB6B72E3B8AEEFACE27F40F2622961ECE9EF6EABF2204A
      B2E50A25CB226D572ACE437F920877179BC5AE2456CAFF3DE7F6CC00180003CC
      40946897172CEE2E80EE9EEEDBE7DE7B6E7F52261A759C118E777B847BB2B4D9
      28DCDE6556F7D2B60BD1EB0588B4116E55E3AC7F5DFCF06CF16ED669E8838D32
      DB5304D7D9DFD134280D77ECECF86E1B4FFB7697ED1AA3C17EF9F336ABB29976
      8CB13534345BD41F72F17145791D786C2791868FED8603CAEAE12675E3A3ED5D
      5537B9124122307306B6373D5C5765ED77F351E5EB7706F64A388C1AA79FFC05
      A952F96D108A472C3EAA93CEB016DD018C752AEAEA5DCF6787978BA2F7EBE3CF
      3EE7E3675BFA37D2A183A5A9FB4720ECF44D3DB0717BC012A5A3A2A81AD307BF
      DA4BBEBAA0FA94ED6B77716E715D776C2DBBE73DAB7BB5EBD807B40BFDB6EC47
      AFBB719A0A3254F32E6F468628DF65A3E2ED1E691A543A7F4A3860B41D316F97
      2ED4B1865D986C24FFB35F57525DC487202AD71981D6E39EF109A326FD7DA0DD
      28DCC6F401C65B6D691717F78AF9E8BD87D6E5A459B9C9B9B5DEDD7DA175C3EA
      8EB0BB232E3736A51D9548CF761D6E1DC8DA7C518BDDBDC18C86B66873E9F90B
      2911FC6FCE78DCEE11EDAE56A1FB4E6EEAF2E0D6AFB591799D77ABB6AC3552D5
      73B53318BB463D3CBCEE62ABC130C2A6597528616B5DB7124BCB76BDC3757FBD
      CBF6ABDEAEB6730E3BB95B4A50BDD56625587F960D0D6DB492A2FC3B42247F13
      26F4E979A31BDFD6C7B4361F7DD0DDAFFA6CBB46BD27145B09D684FEEAAE2E6A
      AE52A30CC425E81BBABCE5AE3D4DACE3147B2AF738003C21FEE9276DB6971CD3
      E0FF91DB8D41A0690553BF827E5DE7101E68BEB31B507CB470BB84FD980837C6
      E7A3CA9B69720B64F66AB9A6C37F36D367539649D21C59671BD117D0FEBAF091
      86700FFBA52569DDC8CDEE45A86465DBFD1537EDA977BBBB3E6881E5664748B5
      4AF572A2C162CA298B5236071ED1AA85EE8024BF6E0382BB0D876D0F07DA5693
      386B776A381EFDDB6AEEB7A350DB12BB43FD072B22FA7D1ACFA64CEEF52EA1AE
      98C54368E391A7627EB9F8E879BB6D9F92F8C1B1C83B1BE4B6726A096CEB99BA
      0DFFC353A2BE47451F6EA76FC16A6F5D6817930C6747019D65CC1D7B7D9DEB92
      8DCD3A1D7F54A3E99B363ADB7AD15D1F5C2B4FCDBC6E277C2874200FD76D0E9A
      20C943CF35584FD3FB97BD4D89CFC6961AEF7AEAAE4BFA65CD75FD4C5F34824C
      5A2F4E048130D57AB9769B1ADDB7B5B3E2A6CF31619DF3A3E79874220BD18F7F
      EEC5F8A65D6CBD7FB0EAB6B3CF9388C71DBCC35D32BD84C13A272860DC5D787B
      B6377CE83796BDA947CEE69BFE54B3BE885B4F974FE4E889FC2EEFEBCD0C34BA
      BCDE24AC2B7CDFD0AAB8CE39B4D66F7FD7FB60675C7FE27D374D0A4EDC8E6A6C
      03F2BA82E15101CFF6F88BDF7FFE5BF45A47A41F55A797CB9FFC5DBD59A015CC
      B1356353457B4D5C87E6CF6FDED2AAAFBC5EDDFCD3232ECF09EFE59BBAFE61D5
      728FDBD5B28B231354FF9AE6B2EA1670F0BED5DD63CCB0739741DD82B1DEF29E
      CD8442678F69A6A1D4BDD977770FB74460F684DC2DDBFB68C33569F4F76BFFF5
      8073F97E509E5CC3F2E6A12A44A28B63DAA508BBDB4F761E5CEF05F97EFA11E1
      7BCD399B7EB7BD9B65830491C52AD28ABA7E2FD21044B462A67BBB3D2B7DE62D
      ADB468EEED0D3DF708660F11DB0B6505242DE970B2E7C4BFD7C9B7AB3AEA96B7
      F628DCE2EB728F76B5065C68979F9ED7B6B327B79DAF4424D80630CBD737F56C
      04BF39396CB39E71020DA0953EED121A8483F7F5CE58DAB247C584BBD5DB76E4
      E7A68B6A7EB9F8CFD543EBA5DFD6299640C1615D70F2FDA30B3E3F94B9BAABDB
      FFEB76E6AFEA52CCC5AFB677DB749F90D27EFBC71BC2507B2BCFA757CBBAB86E
      F1873FBE7CF538AF3B986FDB5BEBBBB7BF84449936276FD425AEA4390F6177CA
      AF5A8C5ED42F5EBE5AFCFBE2DB4DF4D7CAFE3B20FFD309CAF4E2B397C84D07DB
      E4965EEF647FF182BE7BB1EA565FD46F3E1E99905E233C07D5EECF17A98C78D3
      8CEECAED9D19E95D3CB50B608788EA738C5C66419F75807BBC436D723CFBE9ED
      2D8C6FBBEEB8EE97EC4F00DFD98AF0A8AB3BBBD8762EE67D737E0260B0607E7B
      317D3BF7DA1FDBBD6A2F155C85D50FDDD4C9EEF5BF954B5C2DAFF1274D1B2FB7
      7B14BA52FABCD50ADC8C5F14BFA8EA02FFD81999FEEC503A36F4979B0BB3A7CD
      640DA66E36634B6D859EF5F319FD5A8AAE9E07673C3DDB3981FFFC89133BC7D3
      FBF5DBCD59547BFB53884FF9EF3637B32D3E7AD9138CB45C47E0976E05EEB26C
      77B14CA7787F7EB3B164FD49F9F16AB5EEB6D3CD6DF5CC46ED36A73DE57D75BF
      B7406E8279EF2AB6DBFAAE53D1907E189C78D7BA1E3EF0AC5F03D99ECBD5E5AE
      5B29FB5539B4C88540F78B352A92E3C39C952EF5C9ED93682D495BFA66CF358D
      680EE6C2D6243EDAA7FFD09DD0DF2F43AA616EC71CF7EF22A0621E9DC1F918B6
      0ABF72E7BF43EBFFD31FBF0999C48C902CD36A95F640CBDF95AF96EBB31949AB
      3EF2991662FF7AF1BBEF03FDF10914BE2D83DE910DFE354D632125BE79B9BABB
      6FBF5CFF7AF17CB5BAA2F0E6DF17AFE862E84FDEF7C19F139051A95D7706FE4D
      47C4100586AE66B7FDC1A047EEB1AE7F3CDCDDD4CBB3B7D334FDE15B206E9B8B
      2DEA4D1DDD0AAC0F70BAEA91EE5D1FE9B54DBFBC7A59BB6BFDFE7BE47C7FA086
      EBA9F353FD59DDBD9C695F60D7883A4B5A5BF84B9AB6EC3BA59EF8D80E5DD795
      1BEDB5A28BD8DE5EB2D841E7E0EAD48D89FDB9178F6D7BEE79062B694F99FDC8
      77E76BD5CEEBFEFE30DAF3531C8F3C43285FDCA41F2F12B4F37D0278EFEC5522
      23449ABA995F9AEBED57F8B7971E2CC24308E71739127A697FE79BBAE9297774
      9A1EF6E6E175A6D9D4DBDC8E12D6D53394FC572DB7A96B86EB866CD820DA333A
      63DBF4F028D9ABE55BA243CBF5848B3EB7EEF1FE07C7347E322B387E71232D7E
      09AD257E490529DFFFA0A4A3245A324A6204A724964BD9E6A624F0C1A616D338
      478918730DA5621CE9E8B730B2A6935AE99FD627A3F53F3DCABFF377FBDD3496
      74B1B3A5B62AC067FD25CF9F4C2D22907999FEBC5FFD0A21F5F4E4BBC66B5BD5
      8F27D76E41F7504E4F4CF56BD7FF03BCDDF3DE6D624C28E5B60ED30B2DCB7A45
      E69C5A6CCDD3658DCE376972EA9DB48F8476C74580DDD41B45BEA0E1FACFDEE4
      F8F6C52ABEFD00C466B2ABACFEE82770968792F8E3CDD50791C5D327FB5E322D
      D775B14077FB4BA4DA91DB6A477DEB0AADBD5D129B8568DB7564EBD5F9BBE6E9
      7EC16E00695D4FF858AFAEBEAB8FA6B9295A7AF5FDB26E0A6E8F97E8AFC5E9D7
      D9D11556DBD38F6E77D6A47E886D057F5EDD5DA597B73EE6678B5FD052A9FFFA
      E6BF7FF1AC0DA63E041B5CFDCDC8813D53F324F1D39240F245BE6E18BCCB3564
      DC5936FEF1E8B6B2EFA9596B6A56B7ED895654FE79F3E10783DE176753B4FC9B
      36BFFE8926B1FF6122932EF0F8DAD369021FACE9EDE6BAEF41F409426FDB43C4
      AEFCEB359D894EC7AFD77B43DBF1D8BAAD62B0DE967673B5771E4C1958F444CE
      D7575C39FCBC0661F859A745F67697B7C233DC3927EC51D975FAF22F7F41DBAF
      33A8995FA84686463492C9A66934FEDBA6BE383852762937259452DACF586C78
      FD2DDAF72A48A18BCE86620EFC544549E34CA395112AF16CAC4E3AFAE8580C32
      47211AD6201122A012ADC88A27E99F3E7131703CDC72959DE5D1D81C8DE726C6
      265AC43A92E9E8920DDC1BA550192363E24A4AEE2D6F98D691C7E48428C66511
      B2303C24561A135414CEBAE88DF4BE142E39C7637260411A95BC4A05015349CE
      A7A74F94B6CE32E611A245CDBC6A8AB345061F72881CD2B3C636128539AFB857
      26648D36A21E818B64B36B0C67C5355E265EBCB00D8F4128A3B9B64D4910678E
      09556729329B034A61C266119D14C964D588A09F3E090D4BCA8A947356C5410C
      3273D704D44114A165F6517A291A6B4510B171105C8EDE1627211BA6D136BC0D
      8E9BA278F692E3299EC5A45C84A48A632E34D9AAAC15BA8509E56DCABC29BC09
      36321E45689E3E2161AB128B36902A1E90752822B86C1DAA1F92564EC71013DA
      1BB8CD260AAD728CA8062B053167539428D93291448CA84630A5C54A21F4002F
      A77086DE800CBC41B1ED878DD0800ABD4287B462383016111A17E0AAFBDB1290
      8AF6842CD4DFE462554810233309F246CB1850859E285EB9460AEA1E93D02108
      9A4DD1967316121091F15396A74F22BAB5F12140CE10772EC5782752C93EDB50
      5C664E66928E76DEFB464791B904F062D03633A34502380B10ECACF2D21BAE1A
      5407E069ACC673F18C40008EAA49CC0B882909C68257D2062D1AA718472F146B
      9393948AFB2CB99689A1879BC451219582909A73698A378E19A64A32409EA5AA
      65C80C9A218A621A8A65844153B22DDE46570A500319C5E8B22C91217FE1312B
      894ED150192765D4F84AA3069E41AF4A164A84044C5BADBC4F92E5D4041580B8
      A44B6AFB664ACFEA609CD34CDBCE6258BFB124F505CB8127C04A285EDABF9F3E
      D97D477FCB840232FE1BD815DE5B153426CAD4A0EF395915F4A9499E19E31A58
      037446004CA5D250FA187C0EA1A06652B8C8BC64B02F90A82BC03534300B2B84
      4194001C4365C2D327680FFE4047C6C634C97AAD6072B2B5046A037BE30DFACD
      262F2D8BE8A8A86346990C0A969DB10C120FD242D152910EB0140A7583A90006
      818C14544ABC493A28982AC559465FA4A432F45702283075A88151265BF426AC
      3950862FD1107468C3859D237F9959914D3215D9F45560B507981E937FFBF7D3
      27DB7782F532CF1116A558D216CD64C80424511A9B128C5B083A4B3C2D841899
      D319E95D404B6594324B6FB3860E68F499D13065D04E03CB8A364952151E197E
      2781E402163115E0007A022DC3C3A1C305E20A5006ED948850C6D420AF50CEC1
      A04793125C0087ADE3D03EA6605D7341190E362CC1AA9498A475C697149BE29D
      5156A2CF2134A0DB39C3B3705061E5A18E2C38A1D1B36860216D341E2AEC351C
      0E8B40939052392B1DA189C3DAA23A29354594606D34DA58F809A1A3457F3BB2
      D08DD72C9946E41438ECB4C3139AE805E4C41DC4D7D8921DCC0D2A0350F29C85
      768631A4D0102B030E12D73CE133EFA3620DFC286C05AC96B49CEC9683D960A4
      5E813780282C173A05DEADF1540C345D4698B2A84DCAF06E3A3048130E2473B8
      1029E10EAD813EC08BA3E242EBE4AC86DBB5B981191339180EDF683DE34D3645
      C89C945680528E99939FE23CC1B55B78C85434F730BC4E995860AFE0EAE1360B
      1E07BC90D92C30B70E363143115D52200B707390207246401DDD94B487A9F085
      DAD408C93C00E195E019BED1C702B571C608E1C1408097C23C200D20393008E8
      98E0A1644E12890A3EAB584D2EDB497479C0A7700B391663D087705C32C030FB
      62405D1A2816E8025A839E20F84405EA022D878F840B3190AC0343C1073085DC
      5AD7647220362BE353B111FA9BB56B1A47F65DA2FFA34076D879800AA2B4CA72
      78270B38050967A40130405BA3BF6040A2C9507E28A17410051C3E07C9299A50
      0443A09AA844F6F000CC3E7DC2046A52D09D106C807A59AF886750A7B8EC8483
      2BB028BE28034471481CE61BBE0FD6DA7266601C08D6D035562025084993C107
      8A518786FA8337BAA85C2039D8308820870CCF63D11BD2C0F5C5A74F4424F70C
      E70BE79F24C00CFB65C1D3BCD3BE283814D4BD64289BF7AE0026053A08D35A90
      192E4882199698A12906604981B2386F190C2D57E42751684939DAC2F090FA4E
      8007E1071C179C85822E4079E0774145A108E819AE520408121484110984A41A
      6B24E40E0B8C3A275866F805E01CF40EBE134290F0B531820E3470EA0AC974A0
      86364C3262AD80335C2B6C66035604974C8434A15AE05D05C60A38B0117C2832
      104D940DA302036A230CBDB6C182710474374816EA027A67016C541F0E972978
      8994246407DA2B41090A87F2C08AC14635A0C60E4645C5E2410235AC0F31389B
      411FAD474191C3313170B128610F6C68C04B838575367030BCF160B91C6C2872
      7816A4D1C883EE84AB47ED22DAEE95073B480EA6079DCFC1C119AA16614F19EC
      9E85A754CC09F24BDEC2B918C96522236AA18320B002F888B0D56844120E3691
      682E2C04B71ECF82413554B08C1CA4050E129F42117DE3D015E875601EE83290
      9213A89B047F131650E39E8C284007FB06A205FAAB9295C243E1E14552939112
      6D86D1E2B05860A07077A0CA70D4E007AC50C000E294499F2BDC4975C064F01F
      78479DE12060F212D84063C04E934CA867B21C9A295DF19988898475520AD141
      80AB048B0532043862F664CD348C1DD81C0C35E81B68B86B5846798872A10B90
      10F3F0CB019D04EE08EB883F618361E10A0C306C99021CA482564A5235F806E8
      4CCA407CD4250A8F6E0CC079E60226ABC0DF001DA8362A0F2D4D41AB20A01B30
      79394361B84E50AD42910781A6A00639377807DE0CE3DC5A5FD86E18E8ACD008
      B843F8ACE20A78112A6422CA6630363CA03CE88EF4DAA0CF1AF83C07BA4E0E01
      A410A6AB09B9F106C183D00CEC3D21F2016E60BCA06D28B77026A0008DD1B048
      E8BB006B0D1C3BB819F42ED456504A248529424551A22E0890A13A1E4F432884
      FE4B3E3B0D0B0EDFEB10D1C17C20F02A087E02796D180C102E2820DC2370AB02
      054D06D4C471340E2C149A621A09FF0DCF948203F781700414483691D8139409
      36160C196E04D609910C341E7E09461E506C401B20793C3D00B1498113115461
      7261601065513449A113988C4170E9C0E4186CBE576837DAE1C8238514239879
      CC14B581EA80F068DD68CF14200A1A00C3AD88948213C127C387C20078F876E8
      BB12A0E80AFA098504FCC18A5065100D0D004AD968B05305BF83281464DB2674
      1CE2467CAAE09860E6E1CAE14EA16BF0E4284628D4A0208A0539464A4476D683
      25A18590148487EA830A40203EA06E940B66508343193C0E8084AD8727C81EDD
      C9E014281A30D0AA08332D359435EB526C81BF41988B77F0A78868205D488F3B
      E141C413C58D4005B851AC06196407524698089B2941553DE92657A43DD14291
      34B8814057C1DF648440E81B7C9535740A440E764999243C1949047688700CC1
      C63B146BE146885D1BF071C011F6D6207837C431D00B14D1C2D4900784F67304
      CC1E7582D7104CA2DC0CFEC11DCCAA06598103873106C9817A233803A1B4E82B
      88D8156E22821F09BFCC984B0D844EA12EDC19EA426DCE0A7E1626C5A9084181
      6A40DC4D6C50035811EE4047D1CD4C492111C923C64617A15FC0C974F4C4D110
      9325E839B81E9046D1394C7E824B22B94B847688339C10880502FC9DE78016A2
      13182918F7C01A1016F878055394D00FC14035688402229388DA12B1970666D9
      1544460AD60E35834DF12C205A056F20FBD084C8C195240F2081F056C918D065
      1867C4BCB038E832474338C45682818164802F3C0DFC4C1D19414402F9239242
      4488C6A12F5191420D279E8847C28120AED4C982BB225A92480D7EC3411AD003
      5A22A06511E2810D044B06873006F6031F68F43DE84D4494AA805F846470FCE8
      176839FC6BA66A82C7210861C6C5DAFE14E08F68A40B3248E4E2129008231C61
      CD1112C04A00B1A869640DE29DD014349C3B03DB2C328580C4A2E0DD52860283
      7290AE21E60539D20E6E10D881FE81B185AC102682B6D2A00389DB11B433AC37
      BA0DB113290DE29E24A906C0011AA8E118D063BEA02F4028407BC0D26084217C
      97BC5725C3F4088F920DF48BE26AA008013E440EAFE0C1993449187DA4603802
      EC92818A228CC7673032C030D080F69393012C01280D331B41A4C081113782D7
      C0C3221F280FDC126A00194E8D161B182DD738AA6D1BA58736D2E4E674B4B81D
      9D816F3C1BB90FC76F6A0C4FAC048A018DE686864B8A8605099E221EE029598B
      44501D0A94B214080C29404258CC108B24848914D158D02B9832D883EC1CC86D
      70061CD0819C41A9528661822E030DF04648006EEF1063C04F59B04E704004E2
      F000D62527E00A024463610034EC6B4E0C14C621E0E55652402611FAE0690234
      DC40E9381C2A2838380A58B92CE048502804981E6C0A918EE4DC0B0F1A8FD82D
      24382F0422D05AD8361A9603DD054F058A353A00FE1D5E84A1FA0A21058DDA40
      0CE061D669E0136E12F1173A187415A60494916C94A7E18708350399F3A4E932
      2262518013100EDAD3F6DCA0F7E1DB3908D52523BEA75EBBA3C16069A3E3C1E7
      EA40A381A7C6028FBD44D3A61922718BB473CF3C374E75EC0555E1A7B462770C
      E5B8269CABD5B9D19B632FF8A44DADD00B47EA756C64E75C4DCE5986A33581FA
      9E92CFEE98EE749B516BAA9AAD0454FB5F75A3623136BEFFEAAF4F9FD064475C
      5DADEED691A63CAEFD6D3D44035165E94A869DA6271901D30AF422A6E2241784
      7F1C5131145813AA25BE456849DF2AB87B89A853584A81785FD61AD3CF482540
      AE48651CA11E6581D683777A9A59801980AD36081F288A01A768DA3A405704BE
      A3780E018091F8D78061154E8314A2930C741EC15131B54E5D3EAD4986F49DEC
      BEE564291067717C66DA3AD75682C809680942C342E9B5230DAD2D440ED13E19
      B4062DA7364950ABF633A943FB594DC737E9F8261DDFA4AB9FA16CAA739D0FEA
      CA187CB24D53D1499FF183548725898334E2208D3C48230FD2A88334EA208D3E
      48A36B1A0B89934443DB4FFDBBFA1D7A4247394CB1F719D2010B1D26E984E49B
      FBF5FDBBABBCFECBD53AADEF97D7FE076114BDA1652939A55C9AFA55BE5EBE59
      E2ED4DFFC9C30DDE679A5DEF3FF9DFF6AEBAFE6D7F083FDE3BF77FDB22F30F31
      DFDE2F7672B0C56EFA66B14DDB2CBEAE27C97E329ADA0D52D3191DA45A8CD661
      0DAADDE6DA569A8D57E07891FC93F75CA078DF05CAF7DF68F5BEEBA8DF7781E6
      FD37DABEEF3ABA4905F6B99650B11F262378986B1A488779A6E17098475E9047
      5DD4A2698019E63117E499D6E9C33C6E628B7A7488213CEE5711DDFC230B98D6
      E3270A103FBE11D3D070A2806966E64401FAC737621A684E14300D41270A9867
      265AC7B8F81D9078733F53B5CA6A757F537777E61FEE673DD5DF205F77B2DBDC
      BCED015AB3B25045DB15F4B395B333BE97DB72A106A57617EECEAAFE7DBBAAB5
      2CCAF2F5C35D5ECF6C48BEF92E5FAD6EEBF5C27464CAAC676F32B7CB1D678BBD
      E26373C4DFA520D91630AFE9B4C3B5BB3B6DD6A36FFDEB8BF281D7FE8806F7B9
      AB4ACC6BE80622FEE1FE0DE16E99E7F5F3B58F77AB79A85CF959DAD1E77BB15C
      CF6D1D65593C7FB8BACAF34C45CDF7F5FC6EACF9E691A09A65AA131C649A4782
      6A96698EEE88F42E695497F3A2B675792F686297F38296B6FD7D494BBB9C17B5
      B4CB7B414BBB9C6A3C3865C358F6D5F2FE6A9E61F9AC3D346166BB5E2E5FDF78
      BA617816231996F179771BE837FECEBFBEF3B76F16BF59DDCC53E2E7ABF46EF1
      6A2E4BD8E4BA8CDAD49EF9AC3B886D7E9FF6392F41E126EFBC886A98776A107F
      3CF73CADEB4E945B7CB92566C761BC07AF87703F1BC92FFDD543CB096636F073
      7F3FEF495B00FDA6DEE7D3C1E8C7173113135F1323F8B2F3B3F3DABC7DFEBC47
      6EF3CD83E0BECE5DFCD82EFB5C43FC9CFE986F2ABE7C779BEFC014DFCECAF59B
      155D149CD330F751E0733EC4F0FDDD6AD397C7330C0DFE17D7B76FFC7A398FD0
      7DBE8A0FF56EE7AFFCEDAC8CDF5CD1914CB3A5F8C5BF5DFBE5D58ED398D7775F
      BEFAEAC5E2D5EA96382C6DD59BD78394F9F9EAFE7E757D51FE2E08FEE8CF397C
      3CFFC19F8239DFBCBBBEA4C19F5E1091D58C9F2D679AB336D72A5D90EBF3CD3D
      D99734F13FF2BBB0F27769FE73BFB9CBAD72DCE70B72BFF474D9D6FC7CAFA0CF
      742ED3ECF1829A9B8E38A650ECD24077FD10FE27C7799AF7F5AA8DA9E6E4F97D
      7BFA53EBF7E70E120F32CFB3F183AC33BD0BDDCCBEDAB14C236360AF6A28FCDB
      BB651A69D68EA18BF9CDEA8A8E63DF147A9CB9ECCB9B76A8F6716F9F480F8DF6
      8B7A51CECB37DB007993709F7A51C24D0F6E52F123A9765AB54927F6C8585A3E
      5CF7CFED06863769E5A9B47C98561D4BDBE16590508F26DC2BD11C4B484DDA2F
      D18E26E4FBAD77A349C5A04C33EC9DCFFDDDDB43999BBDB08926DBCBC3D5D15E
      34FC78DAC342C5F184B52FA702084E862EE4DBA8EA592C6D334C02D548F2D3D8
      1AC9741A6423994EA06DBFED63FAFC6DFE6EB9EEC7568F8FC5CABDE6AF7722D3
      13FC6D08B23F3CAC3AE77BFC21C36EFCDDCD7DBE59E79D5C531467B4BF4FE8D0
      88644F28D3488E133A753CC798728DA43EAD65634D3FA570230F3AA179234D9F
      A0827C9A311F497E4E010F0CDC3415E497A8E074833F926302800FDA3301C07C
      3680F96C00F35900E6970078BFE95300CC670398CF06B0980760310FC0E23200
      8B4B002C660358CC06F0417B260058CC06B0980DE069F46624F53400EF377D0A
      80C56C008BD90096F3002CE701585E0660790980E56C00CBD9003E68CF0400CB
      D90096B3012C6701585E02E0FDA64F01B09C0D60391BC06A1E80D53C00ABCB00
      AC2E01B09A0D60351BC007ED990060351BC06A3680D52C00AB4B00BCDFF42900
      56B301AC660358CF03B09E07607D1980F52500D6B301AC6703F8A03D1300AC67
      0358CF06B09E05607D0980F79B3E05C07A3680F589A1BBA11C68D2F12A0F6754
      8EC7FCC3F6F551FC26E389D91B7138CF89477E3B5812743C233FFACC29398742
      7ABE5ABD9DB14C6053CA1097CF97E16AB9AA6323EF7ECCF2E8FDF1D9DF7FB699
      CFDC4D268F4E43D5C1DC61902EF968C2613024C568C221E9947234E13E85906A
      34E9D08CCAA13A55B8B6E9AAC11BA6D56369D9B1D4662CF55EF3ED58BABDD6BB
      B174FB8D57A36D52D55E0C8A556C2CB1DE68F130031FCB608E67382BB6E3833C
      27E43736F674429423CF1897E9F10CE7443B926B828CC7DA3445DC238D9B2A77
      3E57EE93013C36C63241EEFC22B9F38BE5CE67837CB47153E52EE6CA5DCC95FB
      640B3236963055EEE262B98B8BE52E2E43FB81AB382F773957EE72AEDCE54568
      3F30FC33E42E2F96BBBC4CEE6A2EDAF7A3AA09725773E5AE2E92BBBA18EDFB6D
      9A23777599DCF55CB9EBB968DF8F1E26C85D5F24777DB1DCF5C5683F68DC50EE
      35229A4C0277529FF4A13BE94E9AF09D74272DC84EBA8E029E341C3BC9A791C0
      9D0CD348E0A1D82691C05DF98D641817E4286B1C97E924127820DC4924F0A88C
      47724E10F668E3A6CAFD24093C26F7C9001EC9705EEAFBC46AAADC4F92C09372
      3F49024FCA9D5F86F67DBE3541EE2749E031B94FB62023946CA2D40FA8E30CB9
      9F248127E57E92048ECB5DCE45FB016B3C2FF79324F098DCE799F0915C33A47E
      401F67C8FD24091C97FB4912784CEE6A2EDA0F58E379B99F2481A3723F49024F
      CA5D5D8CF683C64D95FB4912784CEE2749E031B9EBB968DF275653E57E92049E
      94FB49127852EEF3CE25F80A59E62FC37E79EDEFEE2FDCE5F0A55FBFB9F7F336
      78FEB1BB8B27A74D85FF5A6F6AA04B1AD6F774F96DC3EA59474D7BBE53D3B0EE
      7CA6A74F241DF75E4F04129C672524535659996454746A12D3B23D4B49683AD7
      E8E84BB725A52616C672E35960CC67367EBA53FB12747E318A2CB9947ADAD3D8
      C9546CEFF7DE1794BF6C4E1D3B7CBFF9FC277CD1699AFFB8AFC7D6FFE3BE8EB4
      3E75BFF3CF5B930FF17AECFB7FDCD763EB4FBF14B8862EED7F235BEA21C14274
      6EDF1B7C60DC399670F9AB9E74A9C6FD7E13B54FCE5AC70B4B7438B556A8A96C
      9C165CB1ACC6CAB54DCE4F9FF06064F02627D9B031C6F1B7F21A95C085AFA74F
      DE67ED7E8ED7FB94C0DF5FEBE9F5BE247041EBFBD8A37BFDF5AFFF0F743FDB3D}
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
