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
      789CECBD6977DB489626FCDDE7F83FE055CF1C535D94CC4D5B5667F7D8B25DE9
      292F399633B37B5279E6804490440A04580850142B8FFFFB7BB708044052042D
      594B36AA3B2D89C4127123E2EEF7B97F9CA7D9B07DEE076A18F9F1A8DDEA1C9C
      FBB10EE99FC174D4EE1C74CE6703BE62D83AE77F75A6C7C3A03F1877DB07AD03
      FE334AF8CF43FE731C16FEEC87742FBEA3DB3A6E9BDF870ADE787C9E8DD544D9
      EFEC5FE56F07BAF5C7F93089B3AC1FC12FAD73786C107AE7C33499F8F1F97030
      F653AD32F87C9AFEA3F3C7F9BF9E4FFD38D1CA6B75E0FF0E5BDDD641AB07FF75
      E0B7DE97CFE14469EF839A7B9FF0F6BF7E814776EC232749A0D2F233DBC5671E
      C1734EE8D9F8CC1E3CF33499A5A14AF1A97FFDF2F4093CB1BB66909DE5410229
      5B3061F8EF08068B0F3DFA72B698F49388C6D6CEE71B87D1F50F5AFADF975FC2
      7814C07F9A9FD55B33AC76F77035F54ACFFCF2E37B78D8BBF027BC6EE8479977
      FECC6F9F3F3B68E9CEC7C1EC85FA62E6BFEE4D2B57095787570957AB8314F527
      FD34F4BDF77E36A6A1778FEC03F53CD4FAFA070E69693AF468F3C0288427D2B3
      7ADD2DD67BC5FF60BD639D44BE96C9F67AD5C7B6EA71676A9428EFA7B73CB883
      6DD668D5E3FE9759247A5E040FF93D498182702C6FFBECD0F483BEF386F61DEC
      3078E73874DED9D96E6B74576F0DEF5D381A6732A7BEFBFC7587F9061C075625
      8CCDF3B73A2B5BAC4AFE86ADF6D48D56257FE7E12D1D58B31EF9938F6E7F3D7A
      07C7EB3876F7981FEB95EEF34E5FCBAD27EB6EC5955D7DEB2235BCE370ED89C1
      6F56DEFDB754A90B7EF76167EDDD9D35777F9EA572EFBA7DDD3E3A5A736FE307
      D54FD57C571EB0569C1CADA359E345EAF7C3C1AE9DFDDA9D797CB8E6112F61FB
      850319C1E1DAE977D78DE0E75065B10F1F2A99C6D1F13A7160D6BEED3912DEAE
      FBD1C9DAFB64E14BF7E58B7EDC5E77AB59F5E2ADCE8A1FAF5556CC92176FB5CB
      7DBC56EA99F52EDE585CEBE3DEFABB5711A9BCD0C7076BEF97952EDEEFAEF2F1
      E1FA297757BDBBBCC4879B049F67F89BF78BD219BC61937E7374B2995FB83A8C
      D93447279B9945F1BE052FDFF17AC96AF944E1C67CCB1CB7363389C2ADB46568
      9AC7EB25873D9F855B9D653B6E6D3E9C857B9796EDB873BC4686B84466E12DF4
      3DEE9CACBBC5A1AFDC62CFE371B7BDE62E97B87C9743D7EE3AC5C3A52BDF654E
      E171B7BBEE1ECB74CD3D850378DC5DA764E6CCD6DE583C7BC7DD8375B73A8BC8
      B7BAEBD75D27C1DDF593372E2DDD7125A6CA6AB45DBCE34A1CD5DC942FDF4925
      762AF7390B78528997CA7D76094F2AB132B9CB25E849253E263716492AF3DC7C
      1E8C2D61697AB2F940E4F708B339696D3E0FF6A69C9E276B35F1FC40D8DB7226
      73D2DA7C26EC6D854371D2DA7C28F23BEDA9A03B379F097BA7B386276BD5DAFC
      50E46F5C5EC293F62649F4BFCAA268D98AFB6A55B5F0949B68ADEE83DA375160
      0B0FFA7A5DB6F0989BA8B5CBB3BB898E5B7ED68D94DDC2936EAAF72E19EE9D5B
      D4904AF6F916529C4C70B35B0BCFA82ED6E51976AFBA8FD942CEF363F29D5A78
      4C75C1CF8F31FBB4F090EA9A003FA4B44B0BCFAAAE1CC8B3DC3D5A7852755D81
      9FE4ECD0C273AA2B0F32A2E5FDE93A61BA5FCDF40A4FF94AA6577A4CEFAB59DE
      D2BC7A5FCFF40A8FB9A12D5F78D68DCDFAC2D36EC4F40A4FBA0563DFF5BBF5BE
      6E4B1911913FE7EB3795FB98831BCAD1FC415FB9A596267670C34D5578D6CDE5
      68FEACAFDF52CB73BC854DE5BA5A0F6F5D8EE68FDECE1A364222BF7F4BD3B874
      FBD1D7D8C885076C692E2F4DE0E82B6DE7C233BEC68C2E3F637B7B7A792E3730
      AE5D67F8D14DE462FE949B1803EE838E6FC2C40A0FBA915CCC1F736363A0F0B4
      1B32B1C2B36E2A17F327DD9485D144074994A4593FFAEB79AA82D6F90856256E
      9DF7A3996A2D7FD43938703F843FAFFB981F807FAD7844E9E3D2B56B1EB1E685
      FC8876E7D8FD10FEBCEEE3D65F9F3EC18FF1EF150F297DDC2A7E983F64E5C7F6
      21271DF9027EA12F4E3A95E8DCC2C5FE574C9B188CA7C82A3A9D73CCB838F725
      C486F916F60F4CCD903F0E3C73E3D49F7A30C37F44DE7914B6CE53F84FFB6D10
      533AEA1C9CC0BF935994B5CFE76130C8A2A99F9ECF537F0AF7F9F0F1B9AFA77E
      341DFBF84B3C9B80A0F2675972EE07BFCF7496A2DE0E0F84B146F84F98F9D396
      F7E53C4EFE01BB2E992499F2FE38D7D922527AAC54F6C7DD0DE23CCD22A0C570
      A0DB38797FD882FF9078BE4977818164295FD232843599284E120A117B13ADCF
      07A3340CE8B678EA3C219EE233BC731DABAB0CDEA2FF314CD2890FA25E4FD330
      49C36CD1F23EE04798EA01E3D4ED2289FAED16110AFFEDE3A4DBF017FFDC8A54
      C92C03E2A8485DAAA8559970E77EDF500E54E5D5948341F7CFE9FB55D4BB00FD
      06B41DB005998E2D43C3D676F4EBFB5A0549DC1252C2D0348CF9A27DB092A627
      1E6EBA548741BB7B72D83A39EA7A63E563168CD7163A77BE3D9DDB5F4367A0D4
      B574464AAEDDA5B744DD8EA1EEE1B6D4ED0875BBDF9EBA9DAFA16EE7E87AEAC2
      F7DF9CBA5D43DDA36DA9DB655900738267F9411066E1A582CBB59A84E3300854
      0C7FCC62F855CDE095CE43DBDE2BA6ACF7A39FFA23A0F4D87B93C4193D10E69E
      E9761BFE499379709EA5C34CFF1206D9F86517FE98C28BA276EB587E4DF35F87
      91F97E98D9DFFAF6B7147F1BF4A73EB075F865C8BFF461EA20E1F867B6982AB8
      4A5FAA3403CD067EEBA7416A7E46F2B32F3F53F9198C22FB9BF96C2C3F2FBD4D
      220666FB4D84CC831031EDF635DBE1E9139634DE67BF1F29BB970EDCBDB48EF9
      1767D2A71C4CE4F996BFE7FB1C37276F70FC990C2E0A3B71C5F6FEC1B066EF14
      B4563BAEC3CDE3C2D7AE18177C8C4CA83C9ECE96E3E914C773B4793C9DA395E3
      C18F9746D3DD72345D331AD2128EBF0D83DD7AB3F7AED9ECBD5BE7A5CEAA5A4D
      E0F85A065822A61C80C62FAABF6B17F664EDC20E3B34C956696A9D73FEB0B0A6
      95C7F0C3E7F7EFBCD324B027B0D35A3B80102984D376DF1F96DEBC2C436870A5
      D7BE9EC072EB90D28075A7A866DA3D82A2E0EAA47D08FFB631B921BBEA1CC129
      CFAEBA87873DF8D13B3806DE7D75D03BC14B0E7B6DBCE4A88BB9DA57C79D5E8F
      EFC64B602B1ED1635A27277851BB7D8282E30A0CA20E5ED6EE1EF5E8BADEE1C1
      E12D6F4D59B5F5A29EBE5DBF393B6673766EA646192DB5D3D97A7FFC982A5ED5
      4C05769F74BE72A3AE648605EE5C18DCA6F114D862A7BB7E50A5E114C6909B3F
      4B2F9C467B17F6F1BDAA8F2F4FF2FA170CFEFA85DE10853ACB501CFE41BFF2DF
      6A328DFC4C85C1D1C9F171BBD3EEF5F85BD23BCFE9DF7838E874EDAFB1F9FDF7
      41CBFC12CB6FC3248A92B9FCA1331F341DD083F8AFA93F50F20D68432ACE5A7F
      F05F196C9FF367ADF6F96CAF7BD2EE7AFF81F4E0B7CD267D95C229A60A03CD41
      5B5FB675B8D73DC48371041FFF3E90B9E109EDD071811FE814B8EDA95CC27063
      F81596A8EABC9255F3E914E693CF06E85F9C0E7D004FC69F1EB9AE1EC09468A9
      3A27AB97AADD5A33B70E724B776EF401BC027F56592C940D0F756EC7C7A5B9E1
      073837F8791B1BD1CCFD1EE6D6C58452776EF401BC027F7EE34366A7FD8DE6D6
      EB96D8077D00AFC09F0F8081C0FCBF7A6E580550981B7D002FC19F0F606E1B66
      864C7EFDDC8E4ABC843EC0B91D55E3250F96931CF68EF1B0BB73C38F706EF8D3
      CC0DC3191E3C087F0F83EEC949F7F8E4F8F0CB4AD1DE3D6875BA9DC376A716ED
      B568AF457B2DDA6BD1FE0018482DDA6BD15E41B49F1C1E1EB70E7AADD5A27DAF
      7374DC3BEEB50E0F6BD95ECBF65AB6D7B2BD96ED0F8081D4B2BD96ED15647BE7
      A07BD839E91CAEB1DBDB20F98F0E8F8F8E6BD95ECBF65AB6D7B2BD96ED0F8081
      D4B2BD96ED5564FBD1F1D1C1C1C1C91AD9BE777C70D43E3E3C68D5C2BD16EEB5
      70AF857B2DDC1F0203A9857B2DDCAB08F7E376B7D5E91D1DAD31DCDB2707C888
      0E6AAF7C2DDC6BE15E0BF75AB83F0406520BF75AB85749A6EB1E1C82006F1DAF
      0BB9B78EBA9D5EB75D0BF75AB8D7C2BD16EEB5707F080CA416EEB570AF20DC7B
      08997AD0396CAF4995C75E4027EDC3955EF9564E96D6B654A944880EFCD7DA2F
      13012904E32F1704962A65BF5ACCDF6456DBAF354EB15D758AAB278802BEB4EE
      45D9FF3066D9B9D92C37E800ABF59BBB9F65F786B3DC5E1BB002FE0E67D9BBD9
      2CBF422F58B992B95AF74D667970B3597E8586B0CD7EBD0DBD0E677978B3597E
      85AE704BA7B2B28687B33CBAE12CB7D71ABE35EF218E579AE5F1CD6649EAC276
      FAC3C171AFD56A1D1EAFC9C7EFB40E8FBAADA35EE7D69D035BEAF7D5DC038FC4
      39C0BAFD6DBA07EE7D4A3751E96FEC1EB8DFB96D700E9454BBDB760FDCDBDC36
      28018FDA617563E7C00376587D73E7C03D3AACEED339F0AD1D565F21DC8FC0FA
      3FEE9E1C75D678FE7B08CB7F7CD2B9058C9CE545FF6F25DCCBCA5C2DDC6BE1FE
      98E7560BF75AB8D7C2FD410BF7E3834EAB7BD43B5A17D6EF9D1CB73ADDDEF12D
      A0E4D4C2BD16EEB570AF85FB23985B2DDC6BE1FE2710EE6D10DD87DD5EAFB326
      AE7F7244D2FFE416DCF2B570AF857B2DDC6BE1FE08E6560BF75AB8FF19847BF7
      E4F8B0737470DC5B13743FE91DB70F8F7BB570AF857B2DDC6BE15E0BF75AB8D7
      C2FDB108F75EB7DD396AB7BB6B2CF73DB8B3D7EB1D9FD441F75ABAD7D2BD96EE
      B574AFA57B2DDD1F8D74EFB54E0E7A07076B4CF7BDF6C971AF7B747272D2AAC5
      7B2DDE6BF15E8BF75ABCD7E2BD16EF8F44BC1F1DF70E0E4F8E0FD700E1ED815D
      7FD43DE8D63975D7ADF1E689D40570B53CAFE5F9039E5B2DCF6B79FE6790E7C7
      1D90D7279DA3EE6A79DE3E3C681D768F0F6F03D8F64F2CD06B6BBD96EEB574AF
      A57B2DDD6BE9FE80A47BA775D03DEC1D1E764FBEC0F7FF4A9F26972A4DC340C1
      3322F547E1A3A5BB0ADF0E92194CE53CD26D7BB64B37E6BEFFD5379A2AFBD26D
      167E77F55DDDD577E56904AB6FEBADBECDC201AEBEEB60F55D16FE1F1779D57D
      876B0669DD25AB6F3B5A7D9B6901BCFAA6E3D537592C83D5779DAC9999E948B8
      66AD5BEB16DBE222ADB9B1BD862256E15C73DF9A4D62BB2BADB96DDD2EB16522
      6BEE5BB34DBA2727DD6358B775EBDD5EB3516CCDE99ADBD6ED139BF0BAE6BE23
      3EC0A9BACCFA91F7C74FF1459CCCE3BFF2A7D3D1943EC55FCE43F8A7751E66FE
      1457A6759EC27FBA0FFFF9886065AE68AFB982DFA2C3001F48BF1C1E77BBED43
      DCF8F8D751E7042943BFC3A00F5B27B090F4C7014CBA43AB3E99F8D9F8C7947F
      BE49E2ACDB3B9FF4D38B97213053F9E56C062F9CE8891F456F521FD8ED2408F5
      F4951AB6CF27D17B3F1DD1B5A9FD2D50C3FF3D80EFE6A93F7D4B4C95F4DF4918
      67EFC209FC12FBE9027EC3F787F130F9E3DC9F65E324F55E47708DCE54FAE227
      F82A99AAD4CFE0E3CFF01D7C1A7BAFE351A452DAE4835401239F9C2FD24EAB7D
      7C3E49DAEDF360013B679CB6E9557884700596AFE9C0355DBC84CA9160F57498
      C4B8935580AFC74D1627C3A93F52BA7BC07FCC9334D027C0C2F8CFC1D84F356C
      9ECE81F3F75C1FB65BDD163F323EE9F2F25C4D2298112D38FDDAF6C65936FDEE
      F9733D18AB89AFF727E1204D7432CCF607C9E479321C8603F51CDFF7BCD36A75
      E9B749F40575F2A90F0499B7DB27AD43FE7DDC86F5867901DD23A630FC96DADF
      32FB5B9F7E1BCDC0564C5B08B6A6D5204388D2791824F3419646E7C32CEEFF7E
      EEAB380892C17906CB7C31819DAD5BFCFB3049618364613C021226710246675F
      057AA187B065DA40E86891C49793A8E57C0BD26E14F8990F6F4E87F054909D71
      060FBCF4A3103E57408FF6B91E2773305F076A9C4401CA5C380EA33849D524BC
      52C1009E8E3219B6FBA50A63BAF30ADF82B7C12F70F2606BB4610DAEC004CE92
      858A6156EA6AAAC76916C3C733982C08F9C17910C322C4BA1FF4E15392FA30A5
      19CC1B26A6C73E1C6ED864FFC4B907A3096D64F8654C17B6816D06A34BE777B8
      341CB13587DF14FE1AE3D0DA7403FE8206058CC78F83F3CB50CD2F40C968D36F
      7AE047AA7DD48253DE4F8374ACFC407E1D264976AEA7D1229BC761AC7069ECEF
      E36C0267454F6112513CCEFCE07798D6F94C83BED2F7A3F81CFE830FE025E770
      0BBC61007FCDE90FF825CD46E97914C3A186992B7804FC364F911D9DEBD89F66
      C908F858180F5414C18340831A862A82E31BC0E3CFE1C2E92C1EA0B3DBD7A16F
      9F82FC2485115B0613AB393C51670BF85AC34B466932873127C330C381C648F0
      6C0174270F469CC060636034993E1F2A1C9C02250B3E1E5CE929A93DC0220258
      C3397EAE704D7D50FE34CEE7DC1FD2C533D897D1F998AE40C265C033FD14AECC
      06973ED12A83D1E24DC31409821F5CFAD955FFEAFC228DA7A98E55763EF0E140
      C2868B808E1EEE9C10CEE3D4CF40A953EC0FF8D7F3396CE4E1241B86A01DA65E
      A777D0FA82C71F38D12C55D9384D32D057815B83023AF1077E36005D714A070E
      C6E39DE3A90B3C73FE501B5457AD735C79952E8E40A5C295975F6120FA0A7F01
      F2C763952ABA1B6FC1454225939EA6863E6CF1012C201D608F244C0C5F81B2DB
      86DF668374821FA00E8C7FB38E8BFE95693CF6E311CAA138BBCA7C6F5FC493DC
      DC418603B7C360BFEAFE2EFC0632F1ABEEEDC16F51F537EF16EF3EA8FEE6BED7
      F8B2EE31874480CAC3B8EE5147F4A06A0B71DD738E6F6B40275506845B7EE593
      40F8A4C0AB223F8C3DD9DBE7FF803393AB27ED16726CFAB78F471FD8BCCF3F41
      E0C02EC63B503990ED0B0C65EA47D3B18FBF8075753EA4ABCF93196D7832BA5A
      E7C0EB663A03563BCEE03531595346778207FAAE96E3952146E13F0D82DF8F60
      66A0661E142047D1DF85DFE297DDD6719B7E192AB80E34C304AEF287DDF60148
      DD71E8FC11F4ED1F07E7033C95745F3C751E114FF121B02485E1F4CD887AC745
      E8D3FEF9B0D73BC7CFCF812CE3F30B50244088760F8107EA8216871A4771C232
      36B8BF30301A3F7C0A93FC65EC67CFB407FCD98395BB7A1D8499D7DDEFEE1F7A
      2F5F7F7EF11FA461A41E2FEFDD2D6C7BBB855D47CAEEE16A5202ED88941B0908
      D3DF44C2CF288EBC64E89DB25AA23D90629E90F5839ADF21056F4233390DBD12
      EC2E91ABD3BB1D4A8D95F7F9E3A9D70795338971BB65F049964CBD480D336F90
      A4310850A0247E9C13D07B03CA81D7F0239D78F33128FCA08F5DA8C0DCEF5C08
      4BB1EB0DFCD8EB2B0F948A009EEDA1BEE5C1828CC118F3FCE5D5DA37EB53A647
      87E8518621EE49B4A2FAD1EBAEA446D77B95CC7028A75138B8587AF90D1763E3
      522045BEFC8116E19DCEF935D03CBDF3C93E7D62F60AEEBE7918459E06F30A7E
      E067A0C682CE049B85552EB814760DEAE266676C7CFE2F606B8FCDBEC55784DA
      E3A3089B6DE3DD0A4604B7FB1EE8A821DA6295DF7B9681BDE4352E431DD2A64E
      3D5061773DB02AE091CB43426B29A06F53A5C182863FE838E12574C4F0A8C0C8
      4720C2F76BBEBF89FA3FCC4660DF7AE1649A26485830BDC91E064B8924C0CE29
      3A2394F70AAC30DFFB11F4FEF14E2D0BAC2C08270A940E1500E5905AECB90105
      D3F70222D81409465FE1FE3C3C68BD7FE99D91B36071165EED2B3DF1C6BE064E
      0F3B18B6F26C800F4A9389976C7CF7259C720C704DC2789629ED35DA2D6F9CCC
      52BD8B02C3EFC386F40ECCB7FB95D8152A8B6BC8E33DECA3244EBF1B1F2579CE
      576D8697B3D130BC52FAA11D8F35B4A9783C6E42115495385E85672255D324DD
      780FCAB050EB19ECE831B07A3E1A48D7E03B21EC1F921A729539D69A75445CDF
      7FA1A403AC9D9CB58D8AA3A4C10FE1EB67FDA373908B5F562C7221F3A3F26A97
      82F3786F85F58FF4EAF381B7DFCD2ED8B89E0D5A765C5550968350837E1CEC7A
      7B254D153D6F5F3B1433B3CDDB91B4F6300A70370609EC30D034BC79925EE0D8
      7E01B27DA552674670071BD44EB6EA06BDA5F5AE4CE4A74FD6ADF87C1C827E07
      3AECCE1BB0CE5F44D10E184BD16C128B9E374902D5F4E0AB9017669A68560941
      9C814232F32354546294B15A913CB5FA213F47D7CB771BCB374C66A05DF717A0
      C28000C64815AE1E5978787090F01FFF5E327FDF27C10C56EA8CAC90103E2755
      DC9E313F9AFB0B547388A583BCDD6C4E684C2000D5680A6ABEC6F7562545B722
      291CF9F52D0CBDEBDE7B1F8AD4964EC68A6E3D98CCB774ECAD73EB1DD46EBD6A
      1AD82B7384BD091C237FA4BCD914E3930F4D47BD5F775EB044256B9431B982CA
      DE8CCF09ECD4CB102CE62198857D7F7021A618EC5C360341BAE1E62549475E9C
      BE229F45CC3E0B0FAD432F1CD2D7CCFF2EC364A641F6F155200D17C9ACF280DE
      24CB5EC1701D65C3DB74585560F3420B0F03A328D493385ADCD452FD3AD71A90
      D4AE86AFD131EB0F81F9CFE17868590D20FF2C0ACACB15839EE065E807409F14
      3EC64F95374A485426F9E3E07774B190FF365E80C612C3A1980D30612FDF2A78
      FB044F0ADB3E66E7000B1C18B73C2C278A444EF603419BB00066DEF88AB5ADDA
      EFF5688DF5FB65840FDA585F7FBEFF74C6FA37DA053730DE061837C78D818AFD
      DB576874F9B049F0EB5CCDA728552CB12EB868166761C48C14FDF6E41815C7BD
      9FA29FF4016E92AF7668FCFAE663EF37EFCD8717EF5157FDDBBB8F2F51BCCDD3
      E4CF35CDCB30CDC014F7767E49D228A0C4B11D0FD8FF042412092335A9C06CE0
      D17EBAF080142A0DD171AEA24853D093F690A4C379F0EF4CC9065AB1037FF9F4
      EE956CC2C748E2F5A7ED178C68CDC8EC3D4DA60BB4834D2AAED7A0401BFE394F
      433C44BB4D6FE743820A06F9548A8E2DD4399942DA1B46FE68849A8DC6E88482
      D73E46AAADA3D90BDA250ED12AD09FA2A40DE449D6D994803605DC2A844D8EFA
      1546534030FE1C025783E179137FE135E07CA7A8E50D4067850B40C7EB477E7C
      F167A2E61BD82BB04D927C27C1A47F8A91228F719AEBDD5A2ACD508D07B69366
      831928D83459F655E2CA4709C7D3B5A733B40F7C56D94DCC79216641FC2C7B8C
      745945952AE6D29EF7094E4D32F15EFC5C94EF44974194E85CBAD756C8FADC07
      E5C30B4829FABF09501336629D72B54CA6179E6642293472915AFF446A51F67E
      1F4894DB1E7E10B0AD5DCAA942FE9DE7A4DC7996D48B779FBDBF7867F79420B5
      1468FBD6D33DFDFCE91DCCF7CDDDCF77980C665A12A2EC8EA9EC2BA333289977
      E870C1EC2ACC2F4285EBCEF78C10B1D5F4FED2C475DCBB7DC7D8BD9D8737DDFB
      489FB379621394F828A151ACD3968155BE506AAA65DBA024A3341CBC7A304B53
      346EE0A746EF1BC836D40CEF8D78F7967E68E9E772E36D286848870E55E739B4
      12E8714F15AE0C3C691693B5A702DAF9E42DD0368B8AFE5CF708BA6F7378B176
      9156504E50AAC241F9C19FF467E90874BCF72A9ED55A89A1CF0E126887B315E6
      9E7FE98711A5654B48BC48B67ABF55A027BA7E7E8A39C3F707B0CD77D00D8D05
      947918CCDB790153F498F4C914B949BD23F3703930E855640C91312AB7DEE023
      914E7B0DE0C664FDD1BCC9D961D873AA289485D1AA993C8DB9B2F692086DE20C
      FEF2DA2603B58204D19EEFF5B1FA125E0A128284475FA1A8E0881A98A22A5D71
      789A1E55A74BF28919CC104C744DD6004E384AF8EB85630DC89595F5BF428E0B
      0D90D3ECF1F9F4668D9E4F7CA6E4DB87E434F1A364F475EFF8F53F7F330B42AF
      03094715C2F8BD048CDB07F02E5046032DEE74F83C08B53F9D6E9672B01FD1AD
      430144A42FCF264E927F2AFB789B405C73A8CD6B97A511A8E4B4844858F20AFE
      C00517A07BFCEFD964EA7D4E1E0B3FBAA19E5A217FCAA5D73DD8BE71D1752B0B
      25150E2CB565C9F85A3F1357797D143652175475AA17F9010834480260B2819F
      3D969DFFED25F16B0C6CC5202C0AF431220BA46A9C90C452189DF9C72C4CE102
      4E45F233DFA89458A41F6E7C5544425D5C5EEA4A5596446F49FEBA59B636C694
      9991A017844D321153F002D417502BE33A97F33FFEE64FD407F8EFFCCB7E3EDB
      8FF2289A765F69F3546780F5E9DA94F7889E4BDA04768D817CF521CB335660FF
      3AA40A92C18CC2D0EEF9291F0F5218F3D347E19D20775550447AE39BF164CFE1
      C53A56F3FD341BD639BD37CFE9EDD539BD75EADAADA5AED599695B65A6751E7E
      66DABF1C9CF4BC3D6FE75D32F0A3102CD869341B85F18E3744E826F22A6BAF9F
      26172A7E802B7C8364209D50AE9C37F1113E8EB3A4D8533290E485419882E4D3
      19566DA3175DC35A23738527A4B329A7090F256FEAB1A66FAC218E1F6035DF73
      3247F09755C48A14571DA96B93D7B4CD3A6BD8142A2120267DE06DA812EF3E46
      FAD9348F2A619E427ECC3B3F1ECDB02222777849799E3F473B06F6D53EB28D78
      A4C5BA817DB7DFD7FEF3FDBEDFF1281474A91EEBA65B9D33F4D3E737C79E8AC1
      D0A12857825A24F3A4C033B440500074770EFD28A2D4FE8942E769A827E85D35
      57B1259879BCEFF0B98F91506BC894AA615E6E3BD3B0352609CC770247B58A83
      61C1FEE5580DB026275D3C46CAACDD4212BD9C70D9647EB6D033851C0EAE4385
      9B429AEA0AD84FB4808FC13C8933200C9A301C7A15AF7E53EA53E6DA9B4DD115
      890154FAE6CF45B518CB6642C44B1D84CC6A28BC0CAA9F3FC58CB3E70C4749EE
      F5C554A2030E7F1721200EC14638D99CA8CC3773AD0D3E2D507A90862C54FB30
      B4B929117B9482E15F104164CFFB44C2951D3AF12C8AC42CF3A7534F30643D46
      06AFADB38DF57618DF9A65DED1A1A76753246B6DA719DAFC0DE171B00C6E8445
      DD7991E5C40FD43E66AFDB5475B2D9301397A01AD4308C438E57C6C97C1FB6EB
      50A50A218AAC7CB1CF523106E1038747A22BC8F5720E670824106D46D879FAC4
      0FCA683D940BC64FA077A3942B8F05AFC12DC008BED52B3597760E8E7EA46295
      12F401102F5898DCC66982F1428A59F8F10245435E9EE8CB4441E62209327476
      25171E5CBA6232F8C6C96C30E68A1ED45104F989466F0A62A9EE7090FA7AACAA
      4FE8253C5A87A3381C86A086679B6FF02788338E23A1246C4E07D2BC6629E5E5
      A7B815589737C547CEE6A03547A8CF70B89044AF78419EA61D012ADFE19212CD
      942BE58DD68EE98D2B241EE909521AC7EFE1E8260A4DAD9ACD5977D43CA14DB7
      8650E56DF7350EA9D5B1DB3F9D5BAA7B53B7D4B7CEC5DCC381620C616D781B1B
      377CA300F79EF70B2674D8CACB95402C41953228CC6021EE89C4A69888072247
      CC136196940BC4C52FFE0059AF54B8B31B4EEF6757D93EC61409E1545F84536D
      06F4B73401AB241F12BE08E93601AD7AE0B330F6D15A8657B2256C6EFA1ABFC1
      1D1D8DBBCFA6A0BD3602260247E01ED229F6BCB793698466D77DCDFDDA73F6AD
      E6BDCF87ACB85FE91C202C26C6BEDFC172A06D996BA5886485EA160514E30A07
      303020A72FFDC1C52825E3F71D159ED53AC9E6BC519B2CB853672897EAA6768A
      89943B06B6CB9A4B8582A93520D6542E310FE3006D2F0ABACB53D04B854ECE09
      3C9A2DA386A4FA470BAE9BCDA372E8B902E65147DF56A839BD871E7D93989BEF
      A45B3FA405DCEC78306CBA110E0D7CCEA3F4D749DA76CDE20C41DE734801F84F
      98A989A3AACE62133908416037BE27353950C0B148714D628654BACA76517607
      E1908477663EA5676A2AF71F29F88B921D894D02FBE3F7B1377938C30639B598
      DE9C3C0D4A11361ECBB30C19ABE195E350079ABEC1C27B4ED5AD77B99BE03230
      F4A33AB8D48F75E45313291B4D6C68A5242681D7E49E316A27B159C3474769DF
      AE4FA06237D393F4033C18F7A0FDFFDB60FADD15FCEFDFEFDEEAD1C944CDA916
      46CEBB1BFF49DC28DE7E35CA5081EEADF91F902A774F142991BE87F9CEB2E1F1
      BD54D1A323997D13F61C7244ACE9A9FDD1356BBFE4FFB9355AB43B079D7B2803
      DEB714D0ACF34718CBA1587D0FE4E828CC4040A21B09C30F113072E41E2DBD89
      4EDF8A4AC83B5A27DD5635DEF175E5F3B5D05F0F70428D358BC22B32394588BB
      B3B98A8D9EC0D945B546B0BE7843AB4CB22184D454938FF4F6738A37302E011F
      19196F7A951029F22C78B4885893D8451D00045C385C182D40BB2B024A0783A1
      6A6FE727D2E70A5F7FB763E4A60D24A2AB19642755F1EF56C7D56519AC3DEB60
      C024FE9FDEDA50A901D76D6E66E7FD59B6622222D4D0A7C1E52E3EEB3B887240
      0220804FEE41F9F97530351AF36FF7A0FF88CF5EA8C3EE228C0BE396081506B7
      2E1411FEBBCD87333F80D9D549FB10FE6D1F773BF0A373D43B861FDDC3C31EFC
      E81D1CB7E0C741EFE490BACBB7F192A36E072F39EEF47A7C375E02A7FC881ED3
      3A39C18BB081305ED5EEC075F8B37BD4A3EB7A870787DFF6D4DF09B08EBB17CA
      2767DD3D2A1EC1711E7F8FAA53D57B2EB0BF71127F7F08FFAB79AE6B85E9A91A
      F0C6676C4AD274AAEAC2F7A209DF2E5436E9C2654DB831C7DBEE9E06B83DEF23
      F01AEAF859D6645F1362B453D41418A4BAF227D3486D25D59C1D65E94975FAFE
      70889DCCD1F0200C0C8FCD503FBF2C441CCF34BC34F56B46CAD77A690567D464
      8A5EC233699B583339774B96A953708A4A0E323A8B38E3185529B685A9158FD5
      CF6C4B4A93D4E7DF7EE878238B78FA6469328DABDDDBD6A3EEEBC4FDA90A40BB
      75016845DBCF34EBB4665D9D69BC1416A23428AE481A56F06A196C392624D016
      136D10F317E34BF04D985A377B9E91FBE2C3D95B44504248844C21B20826D0A6
      3EB09974D75C2F217381799008151BEAC0290799A3464DFCE9144DE8BECAE618
      9CB70FE3D4561E06BD8AB35877510540337FDFFBD1E06349BEBE465ECC676BEC
      07F8E9024CB5498853734D667F8041B2B0024937071046A69E85C94E130D4284
      46265F20D117BB7A11D9ECAC7DC1EB5CE84C4D4ADF89839DCAABE48ACABA154F
      3EAFF4D721E8660B2E445AF7C226F9066003660A8846978A7A36B0055F0C4468
      4B2F235FE365892DEA32037C4871E57BCF703878E8190E7FE3436D0FF91E2A42
      9A11D02E2B9C0ECE2A276708799362641F4DA7B314260363155213D128181B86
      AEC923D6B1C296BEA60FB6C9F38FFC459E05F690F65405A6FAF3FB17AFB0DC03
      E69F857C48B02C4B884CA6649AFA8BFCF058B263232830A7D00D0987ECEC6291
      8613E281918FBDC5F1AA0511CDAC97B40237CEC69C0F99238D6E4E0291A35A3A
      8CF76FF63C5342C0DC5F302A9E740678B8A7BC6A1A8F53A6EA6EF365522A8362
      740FD12D53557C0F18D224BD08ECD6373B29D4798DEFA35CFAA74F3EAF4A19B8
      7EFD4B47495895F024239C515192A6659829439108B54F7DE73EF6A310B4920A
      838B9BB6FCA9DBA4836EFE24F47635F235FA5B8A438541A928C002D969140E42
      3CD7133FBDE00E271A6B9A42B739DA72C1108FD2E12E31A2C43739C987F2D881
      5D44B3800A491766073804F41A8668EC0B32EDFC0A14AC4F116FA20A52B478D0
      764B65D2067880C018A2C5F289AC0D9F253D86A089B9FBAE734C501DB74A36E6
      11780DD28311EF0144A4F77657AC161314CB538266AB9BF17E7B3FCEDE60BA27
      A6D777FF66067F0F1941EC86BD0702DCE7A4612BA890F49F7B0A74C0D6BF87A4
      9F72B20F153849A16D9CA41362439B2D6752ECFB2AC7B228812D86D56B6ACB2A
      3555652D9D6F114020061153643F8F9E83394CFA6CF9F5547C5D767EE4CF4537
      054B5F2BEFA8B52921A150641CC423EBC7791083A89483116D590DBDACAB7201
      DA60B310D198F8D0F73583059103C138CAD0E42259FD4C6345666694189456F4
      9DFC7D0F71FE7B16D55B35141695A981E2F8ECF56EB354EB5120372F1C2A5FA3
      18D7B3AE0059E11F397CE8FE11C922000D01D58507B8841B6730C4DABCC73C81
      6992AF40EB314E60F04F3578CCE30F10BFEB31EF20307C1FF90C460A94AE7833
      BB7AC4334C95BAE0F1771FE3F8415E45212CD1E35D81DFFDA91FA3AEBBF76811
      F9C03699ABD1E35E06344566A3192FC4639D04E87B8F9CE3EAB90A1EF70CB259
      7A6167D07B8C3348675ADBC3DC7E8C33C08680394BFDEB639CC278168FFCD42E
      C3A3D460C18AEC87039E409DD85D74699CBDAEDD183775631C3D4A37467D02E8
      0498886BAF107F3D3AAC8FC54D8FC5F1C33F16F5895891076FC1DB31E36FC608
      A276FB6B2FB421128EB2344886BCF9D8930C868F4787E6020CB852B064C8B5E4
      19E84315F229D5D5404D33C3B5F677ABFAE839E161BE0C5C66F23097724F57A2
      D8373DC48BCDFB3EE785BB1AEC82301B8C31C894817E1A67E1C4007AD88C4D01
      0C2A540F6C551A5384BCA0F813A7152C87A5292B7680F8C25CD24A2FA4A415AA
      51879B2BD43A620088A2409293FADF2E0AD4B4B5B198B41213F0F73DA03CECE7
      658EF710EAE6ECDFFD2DF00A6E77F61C5CFB7FAFE5D0DF232D10ECE1B344474D
      D85B3A02C211C3C31E2946B735870CE151B099A13DBA5BA66B53CD7A9618B669
      0AD3E1931DA1C78ED7805F778825588D65174F6CCE9D86942744F1F0CD962907
      CC6D115E627A0A38D8BD5BE4BCDCEE56D88BBEFB3733ADBBCFFAC0E5FF658C6B
      CF40EA3A4381E2620EB0380109C0D260A98764B4D43DA6E9CA264A4E02257132
      A5251EA9626184BDDBE212DC07F610E642FCFB7E1887F7C592EDEC43DB8CE742
      2DE8004882654C0A4785F5E4C287A5C7507223265673E2C756A9002B9486F998
      934543ED6E000602E1AA5616AF9886E947DE609C8403CABCB8A732E2D532970A
      FAEF284D126D286E846E413B72BA0A0AB3A4A58AEA33A04EECDF4EFB32C9C21B
      AF7492610B453E6E7DCF8A3D827AC6EA141DCACFE59951A7087FC258215E4332
      D0B6E306B7CB90EF931B604F063785F35A99F4ED528AEF5B26ED12DBE10CB5BE
      1A627D1E6B4CCD7CF3117E0D3094B2AB220E1CF02ADC98D84B08B65A1FA45685
      F61453C2BFDEF74EF1F0D9C366DE918DD364361A5F7F028101229F3595799AF7
      368C810462999CA143D1D28A86B749555097EE6125858915518B4A6CB00074D8
      40AE81AA9D93225EAAC7D9CEAE5CFD1A937028AC7614257D329E1D73B3814B37
      DDDC28384CD230E33BD72844BB0EDFBE0F0D7330BDD76CEAA46246F1ADCF7A8F
      96FC5EE7BEBA3FC8CA04F33B41177A8809E67732F1FB43955C4E30BF87E9C369
      B80FEE8F16A5CD3847268CAED639FA9DB1713B88CE7E1801F36CDEBD4160D9C3
      6D93A582DF9960FDA8A9589A17366D27D5506E9986599BF5F7821B15BBB3108E
      81945C818A8E70FF0BD7B57A0FA52FF7EA102C7891979DC44CA926D77E333A70
      DFEA94C3FB916FF75D4B706FBED357A93F4AE27E92C6DF70CB6C752A973A6078
      B1F253DB6EC34048333A26816322B80B3AD0C218BBC14AE7D17E228EF95905C4
      54C7CAA95119BF3D7F62DC53A3DA7F67D2B5AA822DF2EDA342E1A6451BF98ECB
      3397EA33B77BF80AF3A6F88676FE8653B0A5A3281C6CF90A2A4C5B7AF4E141AB
      D5F61A3F7D7EB377BC5B0797CD09FD0523AA0FC4CF79375A4DEEE7C42E5ED8B1
      9A9919F02ADB491D1542021396C279608635FBBA0350D956EBBB56EBB7E5DE63
      DF79BF4A2C5238DAFED9E74F6F3FFCEDEC3739F35559487DE2F9C4DF83EEFC0D
      D5A08AC60C96FE52D0079BD43FCB01B5C8A51627599E33561FF26F78C873CDD8
      6616AC39CD5E6398261B1F38B191DEDD5ACC5F7FE8C5964697F123E000B78C17
      CD41134AEA08890578065B87F178729C9C5ADCDF9DB8EFAD16F78EF9ACF4E437
      6EC6C50A9BD738FD74DAED7CF7E2E4CD71F7E59B3795CD836DDEB7821115F9CC
      C6B7AD6044B73AC2330A4583894EB099F1A866768EB3439BBC04EAE59CCC6DBC
      9A42A06912A1BB03BB3C93DE6F7D149C2E3BF12F04A9EB190676C73EE299A6C0
      1CB8691F42F1D9C83FE99902E0B91A2CF4E3598D82BE71C966D3C047E73B6BF9
      FB3F009D909AC13E7C5C235A57177282685D0108A80479DDA921AFABEDD497B3
      D130BC5275E3D335BEE554491C2DD41A8168817B2A6EF08C64ABAB725655E59C
      3CF4AA9CA74FFEE5E0B8EBED79C82F30798E1A4F3208620E74497F996E4C54AA
      31F1630648D4B00B8207B8F41B670EF3460C8F00F814051DB30AB41A333637AA
      089488A82653CC6945B8C824C5E6A8744076A9A327E64B6A6AEAABBD6C9ED8D0
      4CC0DE4786FF067DE251D65AD3B63900F2B19C091285ED6A80454C1435E9E02C
      DB4912535FB3905BD844BECEB8CF0C656422B2B9209CEB309BF96ED7E947450C
      20C52190E2422DFA09B21B9B77455D9FD3644A4B8E13D29652F324BD78A4733D
      82B95A66D04FA20A9B05732FE27C9B0C67C83930151F364CF278F9C731F20FB3
      BE5CAF6290FCA702FC9700A51007304753FC13EC801377DE387498E13849C37F
      62DD4E843224C1A246046AC45611600390D5D44FB22C994C129D717F9FC739FB
      9316CCDE8FB2BF0C66A9A62E85970A51F74D2111E1563A1D9C3550219A4D622C
      19C2003B6C8A3ED8FF15D4AFBBEC18F567B18F96CC9F766DFED4E64F6DFEDC8F
      F9D35ECD4A1E98FD73847680CEC2C105B2EE3499176434A7E521C38FFDCB7044
      6AEA035CEB0A92EB08B5D44FDCA16018F90C778CD31C2453EE0D493591A09A91
      8917A4FE88CABFE280A4FDF4B1EA6947A8B1BEF2337FE5AC79AE1536CA9F831C
      B4E14F962C376A18344D41252FE557A1345D020427348ABD63866EC0F28E5936
      843F31EA86CD9B6B61BBB1AAD522DFD47DF5CAB4390B4731256FC4529DA9B4A6
      C03609DB891F60EB268E2BB05C2EB75C29D4ED23B61096744D66E49048153375
      303CE1901A8CF96073FF98B83ACC80B3B860FDD9AEEF2AC6D4C80033DD530482
      371559EA8AEADCEF3C688FD831C803F66100F7D4E5990A1389C9642C66EFBE0C
      63981CADEFEFFC2D7316745E8E557967BD10F002EE7F8BE4E398A4B4804333B4
      E94D23E56B655A2A4449464DD1A83582C901E732554159C0C20B5F8F953836C3
      184B632218D7AA6E46356BAF6888624F2910C8355BCFAD29500F7672EAEC00D7
      1DCCC873129A1E423A2966E7162E076AD63D906FC123D2AA3D22D576EC4F6FD1
      0530A95D22650425EACBCE6A2BA61BE68DD9FBB330A25C3B4B3A69A3292A903F
      C8C24B4A0791425C17CF6087EED88127F719C6409880E4E0D0478D7090C406CE
      036B9B2235444B2E8DB11BB22974C290D23C8C8364DE442DE332F4E9733328E4
      24E6E11FA746AE6D537075CD93A4B46A730115526E8A1D95E17CCAC06D37FB0C
      1F5E592B781BA36B9D89C8C36214086EE75C182C9744D0E3B952422BDC55E4D6
      8A41097D473D161B01467E5306B84BD0C50F9F2A2E9EE5E4B55D7AFA2BB8CC6B
      986FCDD572B37B31BF709B9A361C9FB4B34667FA05AE35EA2589264544F47651
      A9F7ABAD5A3235B732A10D1D40FC8CB934557A01CA8E93F7534B5DEE9E8B6170
      95D54A50B515F4FC39BA5AD07CA376D6493C8C42028404F328AD996A91A91A25
      086966188251F499629E1E10591B7D424BA39D9AC13944FA31BBD372A546B647
      DABC1F177AB6190643EB4388764B27BE8207E97698025EBC063ED48697CD739E
      F3FDBBFC3CBC337F929D7301EBC97C98A3EE95F8346E491D8E6278295AA07677
      0249B3596DE86CDEB6EFD448C5C1AAA35D2B4C658B1DC5178D51741573C07F0E
      D94CB4A7DF50B53FCBB224963C9A2C198D22C55000D4BB9D402B28D1D95C9F25
      49244C406E42438A72A473344510A0FD30E6441BBCFBD42C1BD9660D3A5BBC82
      7C3AEDF7D8B9B1B174E276B7D09A7E11BC3EE56C9B09CE3A99AAB8E9CD373E00
      BDF40317136B08D623A5782B189C9C6D2667AA48AB6A8A3298616388115FD728
      4CF9B93BC15DF31019A01033D4E64D354BD8B8483FC010F75EFDF896A558CD05
      564A780C428D38AFB2482F576317245CA9D847D10DD251954374A402D017434A
      41A4F2E60A029C7BA8FFBB0774FF9F66DB1B0D425034B15FAB2768E4E10428C9
      096DB60B391D8E81CF2A751F084CA3C7C44769D20A9BB7A839E34059D216E600
      672BE3920B6393D487ADD2A67A7DF6AE0E1EAD77507092A17553E016478AE1E9
      335B9E5077C60ACBB0BC061CC7398A0881DCD9573AF22A68C306C29C856E38B1
      BAB6C04BC3712ABE7CB7B2196CEE18E500ADAC30F76DC11C19EDBEB7436AF28E
      A7A324CBF56ACA5081578729C2594EDEBED2200D316ECDB7E1A0DEBCBEBABAC2
      0E6203B5EFBDBEF2E95812CA107E8B0098D818000E87F46A9F281F54879C97B9
      40CDF43A4CF54BBCCE41D7DBC105D83103AF52C8DD68B5F0E637AF58FBE8B54E
      0EEDCCCCFC1B6F5EB7E4B2D76FDEBCD93584F0B31C390933AFB7C2CFB1FB02A3
      E1C4AB1842981EEE6101692A96881D073AB4E85B8107C5C9BA28BAB8B9529D79
      41380A390043E4A6652026F7E1E36758B854452101A648C7EC00C34113C4EA73
      5EEDC70B0C5C56DF3878082A9971B44DD00945956F049F4156230364526A3FC7
      E560173BA78726B3B08CDD40A9217AA6816E47AF33878FB424D0C4DEC7FEEF40
      D4B7AF9AA63B36A355E6549263C9546A827CFA1FB4C47643839024E71FD28653
      137259B2E2B06C75D0845158EC632E26C478EDC6DB19B76B9EE4013DFDDD3D44
      32DF8E62D8253097FBC098A6F5A13DEBE70781F90C1D0DE44C7030421CA3D1E0
      ED86327A8FF0DC7BEC0AB1F7A356B3205922E21D90F0E9931211913CCED12AD0
      94999110951BA8C02634F85D1B082BBC1CF32034DF3C14B4E38D8314F52F48E8
      E013C7770F8F1C60576ED47ADC269A7E422046156355CCCB8577EA93B95A6B74
      ABC9E302D6890EC2C26AE073A72082BEE68F281AC5DD45E85B9170498CA0308A
      F122FA98E520612B96D1A79F4E6D2089413510441511260602B5CDE5E795A50B
      4C80ED1A7A310B5578330F6933BAF31006C87B025B0E8D5305A66144956394CD
      04E7314644022B6D5DDD16469E2A09CB09FA55E65FE06FF9BD1D10EE20ED82ED
      E0AD5D3041F634D140ED5295D689294C2D0718990B395328236BE26F02554E39
      5E44A3EA49317AF31E11657C73AB81822B9A472D8DA1BCF33F88457E79FA0461
      1A98C06234B81A1F3712E07DE84B9E1AE78065883EE07B43508D40C59B654A7A
      1420B33758AA7477AEE6FBA25BA7582C282B2B3BBD30CBF8AB16D13D15C65830
      6262E303E0B5FBB0E0FC0C5C4E0A276649CA296EA6AD0E0C6D07736F0DF588C1
      A91D3E96606FCC7C03D5400F0269375E0269B3594BB0DBBE628206C46149B333
      80AB5ADDB3EAF60AC64474B98F4CB4EF3D93F0055B3E0835EE394D7C63207CE7
      1E09822029F7A1CF7E0F3A0EE6459336569155F341025E061695A6543C3CDDC8
      CCE843632ADF875A6BE97906A3B97BC45E434DA285CB75445C1BF994A2A8FCF2
      074CFE8EF7DBE977E77F20EB39FF721F7AFFF7CCF6A4D91505D4721AD50AF426
      0ABE8727857BA81A912BC8EE26EA7B20AE025097D62A09B5AEEDCA4CC19DB2E9
      5C44BDD41272898A1536B8D553821919FFAC221917A24A712538403FC1A59C52
      A4105753E7BE1F0E739087D6E2A4E78967A73FFE847105E428977E18A108132B
      17A5BECE2B0AB80F1FBC6C36E561A0C3D2F117D6C76CBD9EEDD84004A6C5D611
      41B6D5C769DD7162F28841E99A91643F584DD7CFF3048A70EDA4F4169F242E6F
      EB1032CF90D3C50065BE6581A244E7D58B36425E6FFACD492EB91B1E8CE520AA
      5D33A5FD1D2D132837E453354FC32CC3286F6E625084410F524CCCE0A0F17873
      F91506C36342FBE318D524A47A168295B0387E72721CF723B79E44F161BBC06C
      D77EF2CC41126ED2D33EBF3EEB6107EEAE74E0FEF0B34B83101BCAA621FA7868
      9E74CA299D6D417246EF536B3978C8C1F3B3B3D7D2C4BB97C30ECA636E1FBADD
      59CF756AF0349A01D1F47E7675F7ADDA72BA780D8EA5DA609C89298531E58F57
      C96F70BCE58C08ED4C6DD772482136AEAA3C5B15B82AEC194E6230AB79E78630
      8E920659794DB6720E6CD585D5D9AE4D31DFAC2676F788C34A4FEEA56C0F0870
      1F938DEE63B23662C4FE6B71A266D8A689F39790F1DA60DE7B8E39699549488A
      BDBA983510128EADEB9ADECA8D979FD5CD630EF55721717CE3156CEF3F10408E
      D5AAD716801C37DDEB7F6CA415FB89AF3DE04FCB9D67B7506A1EDAD6E8C8D6B8
      7B71FF1385262A73D25B652D7B284E6E013FA3771BA3E9EE57C3CEF838044D30
      F423EFD5BB5364666303662C8AC49E2B231FE056EB7D9BAD76FE4785CDC6A7FA
      FFFDFCE9DEF61B0150FFFC89D747201A7ADECF9F1ECA2E3CA8B80B4FA94D2298
      F1A7D1AC6F820EDF60337E8B391E569CA3D126309BCBF582DFFB048E2A4E204E
      E2BD7593A83D07DEDBA1F156390EFA0A869D63D665E8DD950449E38BC44C0365
      9E2A1D5FD9984C62CA86A0B407A9EBC476003ACBFB908692FA19A1E779E1F610
      63B535BFCD5E6F5E83817FF137535302BD7AFD25E1643AA3E8330C8E3AD1DA64
      5CBCBE0F93BDA8FD721BB702C26BBCE775C8E1768370738247948CEA7358B0AE
      0AF443F2D0B1B109D7B67FBD5C875EE5A2ABC4B7492F986EE8A708EC6BBE9353
      EE0774C8F9C0E9A6B73348A60BB420F7F7F7E900ECB027309C8411AC0C228D71
      99DA6EEE4C745C88D6AF58BD46DEC69B665A52A9C4092E0C42CEED22997181B8
      9233BFF1C9055EB255FE0D9AD4A912785841AD4277E1474E381F85D6B826AF27
      2601E924B6F948B6165ECC6AE285BB4D2B3B9B791E686358F4DFC055E4D89637
      9193B4B0A69C742DE9EA3FA66A185E6D65B15395A293B42AB937C0058148187D
      E345883D85E51ADCC798E21F1B9F5E0A5D6C0E0EDBC2896C6C1D11B2589CB244
      B193D5E8532B0F2021C6ABE036D553E410176A4FD030EECBAF058BF42CA314A9
      B11A5C6C9181F7A6C01DCC9AB3B03362549E592C6471CA65E87B72D597C433C2
      EAE74BF4EBFE6F2E78FEAFFFF95BF5B288FF82B34D7E2C49AAA36C14932440FD
      B6034EDDE1828DD2882BBFE65532C3179C4608280A9439CDD2E82FAF115F9127
      CD33A564D002E887A8159B4518E6DA15F2140751A2F9FC300767527DFC7BE521
      531339CBE8774ECBCCB999B73A306D0CB8F99261971425E1F9044AD3EAE579FC
      1C84045EE56352FBFBE7962D5DFA1122E912FBA18A91AD3C8315064DE90C0A83
      43DA45E5D7B651415D6858414960C40458BC67679686281A728416CC48C6A37F
      FAF9D33B5A8D80CFC000CFC0B35ADDB22914B4CB0587E62BA9992B4484B5BAEF
      BD7270E7877EA4B738411CBEA12A7C4EEB2025A0C96F9E002591838F551470D7
      121C4B81BB318BF7070335CD2CC2C66661C332B9893FBDBF81C89B7228B58179
      ED3A5B446A97E3A6F991C5E4921A93A302AE2C15BDA2583571CBFDD1181B2ED4
      85C2E57833D325EF196EC25AB0E2E9624EDA79435DE1CEF6443FC65475CEFA1F
      60861CC1E7985AC8200C5079B259F4F2F8BCE6AAB2A182A01E31E6529997A1B8
      77870B0F0D75D6745EB3F9C4996423AABFDB42B37BCD0430486C383B56319A06
      A8C046E95149BB76EAF5B15DEFD22D98B609B5DD02E648BC51D76777854D27A4
      41879B3784833BE37226A788C8625EB27A1925684B8713C559F978D928A1D424
      3CEF5E1466191E36FCC435AAA760836C61F9C278B0E30DC3CC6515BC51B0E2D8
      23670CABC1F5D04BCBDECC9D27F182B5649EAFF61CC802461D64780D41EF85C3
      89A8EEA3D43722D41B50E82086D38B76B749108407FB04AB63DF5DBDF6CADEC3
      4B2165EC198E8AA94F8B62FA7C35D02D3A0F63C438DDB54D7735231909DAB0B8
      0A0491AFD157037F56C1332C0690CED0C432EE07590B8D1C3B99C5994D07A33A
      2ADB46961CBEBBFB98D03C6622FA3411AA0CB2CF203E1F27B493C0969B2274F5
      209CA25184ADCC0C941096F0B3D2C28E25990F192A401A5B6D8F9A9AF8702E4D
      DD3DF2507CFD6CFA352B806F8A517CE12C94017589C9BB2EA4DEFC3C712E2570
      F843D4F9C547CE8B5379544F9FBCC0441018144B52B6EBE171864C6EFF14D8CA
      4974C9656353CC0A147C6AAA8B2B9149B6055C991F14CE0F47F1830EA5C9345B
      AC4A76352579D369B4600FE0CE1B724791018B77DBB1EDEC3BAAB1E08158A8F2
      691262698F5F814F3D7DC22717830F7870C1C2C79711261F88704A856722E1DB
      806B3FD35CD719C8A48032524367DD053901E15C68261AA51607017B03290912
      CE9CF3429A1DAF05507BC65BE2BAD933D6877FA108EB8318A4F2F54262213003
      920FA53CBA26B317657CC0F04B051A4D375E213B82AA2069A39476121B0F43DC
      AD08BB324246C323211AE4FB04314AF00CD0E146665ADA5CF7A5A8746E4751E9
      1CAD56543A47B71E76617E73560A1CD40A4AC13545B9C939661E39422941D848
      E8A678BDD612D4A6F6CB89CC3FA52369A225123E8C375BDE73EB0E5F7A159E21
      548AA83D5F32E4AC59A3696CE5FBCF476901397D07944F27E4354461158402DE
      A2AEA606AA228C83103419B4B50A2757223221814DA292567D50FF25AF1B0AC3
      1BAB5C28C09329260CEC2DC4DCF490AC2DDBC6D10C610B712CD5C61431A3F4C8
      6ACE771307370EE8D02D65AA19D346439590A09FBFE2F265A2E82745B2C9EEA2
      9A3D154AE3F1145D650C159EAC80CF246E9008582E42530969615F33EC764ED9
      A66B89803D368BADD70E11AE4C2D52E41E6929FC98178C9EA558348BF37AFF57
      4C0A736DB87ABB2F87DA11A48B73D813A3223ABE84587C5A5B493BCAFDA952E4
      8DF270E184493B361FA990D4B4B250AF69909C62899CE3753BA7C519ECEFEFEF
      E467CF808538C79C9A21A07CA1475058F2BD534CBBC26432C8B7021845D14B7E
      69497381D768B168A408CBC4DD0475BCC2320D2A602DE6F16324086207538941
      5CE422E87848AA7755E22418844FC1452223294A1282C991B24C0BD3CC507699
      872D9632AF6B41778CC3A121E6F25F70798D7B63777F2DC715F049A1D9E512FF
      F5AF5FE5A6E363A0EE3918BCAF669946D28A6C693F58A0E6A2347070907937D8
      9D46DB82F626DBE0262F6B49C58C6487B80871EC1E424896B03F83695A4785A1
      AC28B706099F064545E174A88D26C931F51CB3491E2C28BA7D65FB7193490F5B
      B70A1E65653FE4BEF7827C0B689286A96DEC6622E176CB16CF8CC1F83156B3D1
      804BDBD85E87BBFDFEE2D58F48169608580B4297D1957717837791272764CBAF
      7082506AE667476D6F107D6037949B054671EB02EF791B6B956615DAB83C7DF2
      BEF82CECBE4E600E14269FC74B2C0D58F129376AFF69EA3D37BFBF22A3FAF4D3
      69695084A62B8938EE93CEC6E130FB0B0FD3406FFB9993096CB27848C692734C
      2EC6AEEFB16DE861FD7EF4EA70B8EE3108BE5D4E0CC254A24F5554C1CD9C4DE6
      2C996C8599BEA2CFB60957BAA9D534AD628282783C2712F3B7E9D40ECE9E30F7
      68518436E00C0402F07768A8F92D4D86199F87E2F8CF69E8D4277205E2DCA716
      B782CA543DF6E953C7507A2CCBE21C6F841A09D72DBF575518AE16140FAAE5B7
      4D68DAA3CE16863D2124B303CE9F98AB4C228C6C209B806B5929A7C15CFA5168
      C5F343DA139BE502E76CEF791FCBDA97A9B390635088CD3DCAA93E7D7296CCD2
      81C2A52F2B9BE5D9B2BD8351160E89D970A5B599086E5CB2A47913487C6AB8B9
      52199B33399BCFD978B21CE41504CAE28792200D6393E19BA196E5F1A35A0CA0
      5C9FE9B58782C4A5BD2DAE69168F1AE6B0C48FF7A43D7DC228DDDEBB8F3C67CC
      9C91A57764A32BFF5CB0FF7CD349E193363B64693F90D763E37872B788852734
      1BD149CEA5277399C2775F55425D227B67CB82D6CEAAD18381BD51E2B57BBDAF
      1779747355991746976B128EE8310F46F4BD600C87BD32764F11F1D826754D30
      2126458F07F0AADB3871B7BAF415E60BE7E22596D4C18C91DBA29F4A0D6685F2
      A5B90DF553523A35A6F2F92E50C3E3854DCCB7552A54A4573E9DD208C2CF6F90
      F3CA257D9516C779D9D084AA56BECCC00BAF79D7E7B1EB55D4261B841F655B57
      84313D81F1656A2BB9E0D545FDDEA83BDC7E8DCC247281897F67C24DD48DE144
      4D54C8FCEB2F38559B533FF852AB324C92D91619DA2F655315937CFA9C8AB9B9
      C96C13CD1FB375462182B2F854E8B25F728A1B671EF9DB30F1830F044645555A
      DB39AB787EF7E1DB393F167CBB1FC4B72BA03DD6CF61FD0C9C47A53209074C54
      D9E963330D9CEFE4210D4434D779D2EFEE2355CF8852A785A4BD84D9A4285A32
      5F0C2061C111A549103D8CA33A0AA7FD845AB25AD73CE9757D4E2675BB2F7D20
      A0BA20BCD38EC20F9CFBAEF4A42FBBC4A9BEADB92AD860DCE54ED1E052C0619D
      57D3E90D5D4DB7E035DE87878F388838E4E889A3893B41882DFB1A1025B439AD
      F91831F6574E6ED829C563D0A359A811C4151F51EDAD8933C46A8EF972E4A3B3
      0F274757B10902D55E172B42EBE0C3FABA92E25EA8C3F06B2943A7B0802358C1
      5C25E397F82D79648D57B92F9D8FF2A2D3FC6DDBC481B5A84418A715C80E13A0
      F4290B377775DB232315B15B859BB9A09F21931933540FD2B09F1BF9498C9B1F
      6BEFAA875A3E628EF01295A52A424C9795F4E36B426D3D9C852E831BDF5B9DA5
      E5C91694EEBE7AACD25CAAAFB864032332EB0204344E5B7CA410125617DAD395
      7C4535DF5A1FED9082903A7F6859106BAE1EF2759EFA819C20E70018D5C32C38
      6F876A5ED664E494BADA14F341864E12CEE644985528DE553050A44511B7065F
      9F782CAE483C6CBA0852903B628D124B1CA5ACA0F994C06A8BF34DDD513121BF
      3E959BB124301A5B1FCB1B1F4B8E6A3B5BAF74323787CC2B1EDDAF3B9985C48C
      FC301AB16C93AB62035394DB29AB5412F6DA5374FF1EEB6F1FD1312324549396
      519FB0AF39610C264B591D7048D61E347B8E369FB86F73D0DCCCC5256958F624
      6CF21DB8358870AD0A3125056B4429B925B578536E06237CB5A50B805FBB8A41
      587ADAA13A353366B03488CDA0424BA3C409BADC657562AF93A1B445D9303B79
      C64942E4612F4AA1DC87DB2672F0D75091928BAC77C3E616194825B766BEC61C
      D8BC063076444D9A4C71939CC952EED4DC6F3558CF1A72713220B5ADDACB73FB
      E12C545029A8FDEAAF57BF996C9BEBA17D0EF6BD5349DBE34A9C80EB09327A23
      99C914B2F7F4048E04B38DD8EB6C07A7B56A22FC2052F5B92C0EDE9C67C295DA
      CEAE2C5EE06A8525D2B962618DB3B2694BE20B568879294536910AF853467029
      B9FA5B4E9C816125E77C79C2513809899D56D0146D2AE88A39533BB24C7858EE
      93BD0CFD15F2EE1A9246E185929073CDEB36AEC927DB878881477F357DE67ECB
      35E97C5BD53CB0609830B2DE2A3AE527B8616B55AF33910AF52DBB9B4FE6721F
      A92D0028DE660C8891CC193CC184F388616357E2E5C3096A8CDAF7DEE2FBB259
      1A53F49C3B8CA3FF54DBE653D6ED01E30B527F34320C8A19B0EDE5240533DE00
      4B23C55D4259CBF4892E2474A5F09E020733AA2DEBAC047C40A88B39A2E1344D
      80E013D0892AACA4C93F304BB64545338A41DE04797BC6EB764339039CE82886
      AB747B24008A6BF61541F638F06FA9644B627F3C623E1687D26C37D15B4D5137
      465BDDC692A4C81A54E19A6356E09846B3909F1AC591AE0069540355E5B46008
      2493B2830832A6EBF8DDB7D4665C0159CCFB801846F815EA859D95B43D1A1977
      E993E155664E3F085426D7E750F2C68B482A742C628F0051B1B28596BEA92DD7
      94A2150E0BEF76E2F534B0EAEEF5D8380006BE16D3D5C5F9E1A71B243EEE5380
      F8205CBF8451F9CD5038EE38FD544628A22544971F9D16C9DDADD9DC66E14628
      C68C4322A91635F7724BF706C964C2850831B9BD4055214CEE1CBD4B1C31635F
      647C8EEA22A92B583751C0BCA223D07050BCE5C2908062D4649AC0D41739FAE5
      DCE7D0E42C06C3494E3326A423EA75C0B8509C8125BDE576C124AC52912F506C
      4679C33A0F2C7F54600B82AAE34FA7A66F873D4877CEB4697FBE22829E01C5EF
      A3393D39DC28D9C8A7607BBC979836580DFBDBF7DC7495ABDF9B9EFD3C8806BA
      E99D9EEADD42BA35B65EE23CDA15D43EA7BD76E7B47EFAA44CEDEF7CEC55D5EC
      63FBC5E600FE9DDE7DDFAA9CFA1601AE908858A46785F55C4972CE18A702E089
      8F5DDD07D12C50F93296FCBBB540D9984601BCAC60C6D552C586B45D00F15516
      2F99DC8444EE678AD30FC2786F1AF9034E964DB863EF5BC436C5EE25B25BB514
      E2ED36BD3770603269CF4C251DA18A02C1094414057E68FE2C46EB22E0E76C8C
      ABA7B641513F733C94AB06CA6F67B53FC2D23E2F48C18CA56A753C7284F9384D
      087816CE9AD45D3514391F4941E689B9BD70C6B311820537AC414E451C8C1EE9
      8FE2300382ECA2FB3270B044EB63BBFED8325EBA495F4182D727D67502AE2010
      887F42244107FCAA435DC48F49E26A6D7062735C77850F2000B9F6B87F0AE87A
      21C32A908ED04F957F2150620C96ACB9D4E10DBB957C2088190D3A23EB83B0D9
      2042785C414AAC4F40EE0345868BFC948D75B4540C8EB0C1B6669AB9BECFC138
      54DB24FCEF30F14BB8BCA70658FA1D983BA9DE71BDE2DCB3080393AB6FADA00F
      5AD45F6E014598D841118DFAD74166068163D0BF9917C8976F03145D033FFA9C
      BC2703E017A0B9B9A3E9E577E3E7EEDFFCB4ADB2A4BAC5A9527A098518C20C3D
      E1AE0BDA18A894131E18C7DBF203BC8675407316326ADABB8E3B1BB5E30A94C4
      E4718E14140204998BA66D9FD9F4A4B70419CEA4DB9746419DAA4C924301B354
      2A4DC5DCCD185496FD49B82BC322601BA647F3B2BA77007B02D35E592C8B3809
      0AB9E245FC16F7F5AC4671AD18361A59881D5DE11855C2C9E391D0067492C2E7
      0A76FBB3CC982679317C31469003A89B0B18425B0842A0B3A99FBB1EED897648
      334D136CEFB1EFA9FDD13EBB121DD070B988B25A23E5C784A6CF556009826EE3
      ADE8BDC0803CED331AFED01E4CC29DE62E1EB2FE8A8213825756818AC9C62BC4
      7D49E3DB82FF3C7D42A170DFD955B29F9AEB02D178CDCE10A103A2F09F18426B
      F85C606E9914AF9EBFD835A8E230266DDD45B2DA4646DB2D66F0F412CCA6021E
      92EF498B96C6A4C38E0EEEE2CD7D67D0A6D2296FF5680E043C04386A5609292F
      41BD6436C86629A28E4BD3800605E0A5330306C81CBC3A5FBC5039949E0C2E55
      139014BA7C4A7DDE3B04A03A8B518FCF9284D42A02639E21DB37B17EEF73DE42
      008BE4669A60007D0FEC16DBE25252456DBDFAAA8553575489C9860BC11E92BB
      CD5D7B6A0605BB67AB448A1D5783A063722AC764071FAAAEB0FC1E17C7418FDD
      4113CA63D9418BF64E8144DFE105DCF93F33542ACF5C59C8A15A669185508249
      8DD94AA6ECBC5C782F7DAD3ED112EE0898207943FAC995D934124636A5404EAE
      084778B84110079A11F8DA5ED1F8DE239B900BEE2B08E5D7EFDEE1E263478C21
      B2BD817956F5568772904B33C9311C9BDE5F9ADE1E13F85FBD0BB5D0E53E1512
      2E81B5E13CE31751B4D3B47F7D009665D6E76D7C891AB9CD4ADCD926488F8D3F
      18F23A671956100A5B10ADE6A360119B120573BA0D46B1C323448B619404833F
      2CC98BF02A3C2F5261EABB009576A56DF92895F9D2855256A4957DBA796FA9BE
      93623A7979C4B41044AA2D8F6B22CEA0304B060917C601756B136475E6B23D2B
      A662EFFA6E475AA1726C02B07D45AA1FBAF2CD03FD689B2A221133163208F32D
      66611490585D5A43DB74074304B6AD11FB0D68CC5BA4A218A02ECD88C30125CF
      EDD8D7EE5030D7B44F03AEBBC068840D04837403728DBD0A15564F9F4C540EDA
      61B24BDC6627AC05BBB10C497BD2092B2E9CE9033B6A7001320E052A12C63AFA
      22CE7D81951853EA0FB02AD449E49D7EB66DCB9D8F2C27562D80DD2DB44A948E
      83C59ECEF239E2DA3EE2F92CCE1F6784593ED399C61E0D3B153D0A8EB9B67506
      D26992527C76A46249E0E1C4D35553951E9A9ACE00E5E80FD15394CD62079B5A
      761130046A4B4B0DA218FC9953337D0F7BB0E199025B6094923180E964B60A15
      BFE6FC2B18004A7CCD07EFECEC75CDE92BC7487644E3C3A6E77A8772F2A8FFF9
      0F048A5D67615A82FD6832FEA8175925A78E3468665D0EB81E460BA8D7BA4B73
      47C13254DFF75E2A863C14DB8638C224A100FDFB17679F817FF72D37B0A17EC7
      B092D4707A2EC52D9EE1B1C2AE932E14155A484DB13C487D8A30178012F7109F
      2699A5B6FA6D1683ADC20A61038F29311ED4F515DB6588E5051389A955CD2E9E
      C35B01F79EAA646A4AE383C436F7F4E1BD6A6AEC34188FC3578889A39B07F903
      67FB50F10CD5151532092A668EE50AE9C2E6F618EB0F1D0992B8628C52209FBB
      BC06769EB9A7B4E68365C5BA7FBE2CE45A1B01B8DC7901DFF103F4F59D049C52
      AC2A3829E56AAD55E3A24DA6CA4323282A3DCBBD5DCAE9C027A6982652585BC9
      42C69B07C5DE3F66B0554C27723B5BB24BABCDB7BA39991492606C9B458333E3
      1E3E6A6DD294959ECC36178C64D636F9969984CEE1B93E2D85274373C129DC7D
      6E4418E75DEF60CD2B1182721A6F2F3FE7EDDF61497E0116F176F22A8185BE87
      049D7DEF47ACCC54EC9EE0DD0D2CCBE66A49D73F25A996A41E05A685424C1D14
      ACEB2248BC0BDC63737C027D932218244CAC566B361B46136CC24A61522D9C96
      9CC33A49B9E72A0558C41926DCA92E3676A25FB9F4213B0137E2E6CEAF5A5244
      0459A258C18B7641F5F0DB192C542E0F5686D9DC4BBC06092844A75FB60F7777
      ACF8E24E7A46BA50A119EE82EAFD69CA926AE5C80AD7A0CFF1930854722A9357
      4FBEBC6E68151098B61B3B22CE465ED709CC89BB4CAA3340F001FD86B9EB1719
      187D46A5879CAB460A832899D4E626D701603097363B41BCB1B15212B7EAE73A
      19F246AA29062D125D225C73EC28769C417D199259CB853CE2E9DB954F234C9A
      A3DEDCD42731A0CAC09A316EF64C18207DF6F38BB5B139D91D7189317FAB2EC8
      5BAAC67209E9D0C9542B97EA88B78A1A904D66C33F1CF97B7DF6BE09FFBC6319
      F62E19F814EE13985C5412D85DCEE96E912A86F5AE016CA84FCD7AA39FBC979F
      D4D0FBF5C777FFF5E9BB16FDAFDDFB0DB98F898FE68D0BCEFF40F7EAF9977D75
      A5EAE3B24CC486B46960326EBCB1DDDB356E6E7F05B5715BBB14B730B84E5503
      676438DD68A4AF2C3042984930480283B2EF08A9EA21BE628F6ED7999BA5BE34
      43FB648CE2007BDB977DF274D28B5EE6FA3CAE2F35336BB61FF8061C52348AFA
      BCB9E174732E360382AE22691EC535EA1A257D72414201A541E2BF218B9C9882
      4BF9DD949B546B6815BBC74A25F6A905AF4EE25562BBDEE896628C13BE1EA243
      BA0711618D3731E65C7F766522F414F754319FD9BC0749C6CB01C5370E87166D
      DF3305B030B2E2EB87097AEC501EB1C09137766115790CF521D948E35F7F56E9
      E2376F453A52EDC5A950F15EDC86D63D69BBE8DD7D71E53F7025D170199875BC
      8FFACA3D49537220EF2DDE5C92B77C699632DD6C4526011CE32DDE28EFACBE3A
      1F7C90277B532A9AA8A34DF1BF342916731FF104ACBC7A28AB61F2B6297D92D3
      679629CF3E47DBD8573B4851983510CD46309AFDEC2A9314910AB11D17E8AAD0
      99C349506B48D27038F44E3F7F7A8716CA58454111EF60B766E59BA8CD3CFC57
      C474FB8DF3536B0EFE6839388554EE9373E77079C052E147A46C5F02E730235B
      B6E13789FE90EBCCF2F7726D418531502869093E4FF2CB6D71C75227E1385A48
      F2EE4F313701A6BF5E71F674EE3690AAA01D8925ECD84A9F3CD56027476DC2C9
      98FCEE75EFDEBF97302DED13A4D13DEE95157285D210584637BD9F5E7D6A9AA0
      CDDBCFEF778072FF9851F2F7E68C1F74E34CD9CFD4A5B44F5D56170462C36651
      F0CEC5143AAC9CE2AC3ADE12C390A3253B2F3F9E9D3D7FF7F1E3679BC10FC3C3
      D4CD42227F657F15F35C0E5371F67E11F27196C6681D0DBD9D3334DD7117CABE
      C2389B8A6D1608D55083F19463505AE717D0CDE0E20C92518C3EEA5D2E0F5560
      7A6DCE557CEB613CDFC380BEF7F6D9C4A398BE141BE0284CEE8D291F07852945
      C2ECE65512B5D45D5FF99FFAA367F1B35758FD0EAB361F27059F6A8D97B00E56
      6A0922C1A4F096B3B0D7BA1B0AB4C6643217B570CC21A486AB8172140758D6AE
      818136BE8A988AD892CDB57CE3BBED2AF9480FC507FFD29B60527AE8A48FD4BB
      3F179D6F4091F8FCFAECE0F9D9D96B86F4F8D86B625ABD4F9A960A46A68114FE
      8AC000172C0362B6784D95004853D05B4C73A05411A2A671B29170B6CF14C9E2
      C273621131A576C6B25E4DC40B89E579F9AB11799852D2037595A7BDE23513EA
      F3140E49B5CAF6BDC62793AA0E02AF12258A52919D032836B1166938DCDF45BC
      7E1CCCE9DF29004C47DBEF879405AFC7B32158D5A8A3A6C9CC544EB9AD7F4B80
      9AA519C974E7D2A11AC88B15B99888C1C9636E0E6AE1766DB27CB9601884F210
      243E65D187311673723A66EC88F30F2F7E7ECFA29CD2398C4152814615BA0A04
      A0EC6255FA08E372941117CC064EF506D7DA83B231441817188D54D1A212503D
      7D77F5A61D10E26CA8B98001ABE6C281505CB69E365C1D2B0803E35EC62B613B
      0D125830D0CE32EEEA6BE28CCE154CC3CAA3FCB45C07910750841F71AA20653A
      032FE2A8BFADE7D9F88689399BE6D86C9102BDBAD0881DEF843302D4F95C3CB2
      444BDA3E8D7E928DF384ECAC7C1D9C0FAAB7859F0EDB70568219CB2EBEF2F7D9
      649AA7BADB7278B9CEC92F6E7AC84B199B9B662DC03DB518AC50E2908C521F0B
      F8671921238903825630DDEC3F9BD661D8E54A7EDCA7E239C4332B36A0C5F808
      85DF480B11BC033115F35A595A92A6F3219642F0F3FA8BBCF3355EFCEB7FFE66
      ABF841BD27CA608A7F4C6E6553C620AB29B007E6B9B6B188BCAF904321DD8AE9
      4CE1551FFF8EA67356AE81D4DBA6396DE65D31371484F74C09332C98113A9141
      B58CCD80ED9E6D5E332BA4B39D3D97C258F44B46D140953D8C6775AE75A56461
      03DE9E25982B5C9FFC1260BF4B9C3CC1178F201CFE00CFBD0B1FE9FD00DAD66B
      6D72A4E443EA38F4F6157C39C242D6CF639B5F8C685CA82BEEC2F9CBB22D148E
      B74E49530AA68EAD148B7CAAA08CC80E254DD31FA420F531BDBBD04EBC3E13D7
      9C094A35C3BE6F99EF4D29319DCA75EB1352CCA0DD712844BE4CDB07572ACA98
      BF0BDC6A01E883D463234061F3CF09E2669E706566421E4CF28EE089118FF756
      FA2ED859602152EA2DFAE87900F870B24576DE2BC48F247009388A15F400F4D0
      EF7B6F8754CDC379EEE5D1BA010A9056600E7195A3A5917403CD4BBF4BC3A028
      80A0263182726A7D4BEE66B498189CFC22833082D26DE9CBA04D46A1E8C0C056
      5E5CBD82DCF41F2DCC4BCAB841FE56A9A98DFC948B25A57785CB62F7A5A3990B
      3502CCCC1DB52533831398C5BDF6D0E69CDBD7175AA01D62059677991EE4A370
      D69193922636D1879D05063BC979D9D6AC9BB602158FF8EC6E34A5A032AC0A94
      E491DBDD10F83018E6FD4D679339CDA6287202B3DA876D41169BEDF2DDF8DE7B
      4D42E30CC405B654F949FAC6F9B173151D5D30C77B7F53830BCC26CC789B07A6
      4FA6A10688B4EDF26F8102A1A8D20E796CD2863B1D5A21958D13CA055EDE4054
      C34AF6B800A557027336EDC2A3354784E88685D9A164F663F980B9D2F4D29359
      C8C68929AD7FC439CB1C1D0C0AE33385D9A18D06364AF34C4D5A04E815E27141
      219E73CC31F3A15C09E1817011709077D0F99A9D4A0B4375417A89059162B30D
      6B1F2F33CCAFE03FECCAC0D74D268C4548AF5C62905A20847025C4EDC520F792
      2264D8D8169829EFAC33A2AC16BA3A97B300A494619514AB611B5FB05A4FAB00
      57A27262C2404284FDCFFC98F0CE44309568C3507C859EF54551CBB7627116AB
      A9D6429454E2EA90CE88510322D70A4DD0845FD0AAC02F2F394EEA7B44CFEC47
      1CDE8B97FB7CCD088E9A495CC6ABF009739C1581AC8C308689803198C0E3DE8D
      F5DFD8F27EF3D0B69D8AC8972231DDED8DAC839884C318B8B5E90B11FC208D31
      0D447624758300EEF69D5CF20A9FCBD3680A798A84D9DEDFA77C1D22AEA4E3F6
      1BA1AC4893D9685C38B9C0D59CF77B0DAEEAB3C000D79C74060AABC063852308
      A3356B5BA29489322B6A45B8D75FEC59A40B62CD8CE9CD8D715F346DC16AF973
      23BAF3CF4B7BEC1774BD533F0D49E4C52D5E665A76B3169686B8BFD4354A1FC9
      94D93C35E82096EBD2127DADF0F20A1A75857EF5DBEE85EBD52282DBC33A5017
      AF6E9622BE03EA0853CC8640C4BD94950C2340F09B86F40A8143482B247BBACC
      5E77A53ED405C5239481A9615A16D2151FBB9D6CC2EC891CDC1D9E3D9C45B8D6
      D83688B85C9AE3B292382DBCAB128A2A3D83783D082FD3C0B7401A31F26D40CA
      A9D0CD4CF5BF5155910CCF32C61648460A39EE3E1614D1C63382BFF474A2BCA5
      BBE6A89B4B4E917F1C7923144F79749E6C56A4B1D778EF5B040376B5D182897E
      2D92805E792B00301CDA133ADAA45497776AE5D04F14C8BC0459946E893406FB
      755EE6E68A2051F0E14060CE92458A73207472B5BE766914C866B05F2DD17C5D
      22988346847E063847200E14EB2678C2AA3231F33ABFFC7CABD452332085BC01
      E1439446EE51A175AEE46C3585F9DAE2463D0B39AC6EEA8B35C7030A969B2708
      CA882E80EFB3CC2BB7C6ACC989E3AB3D8A1BD7E325055A28A68FAD1EBC1F5434
      6D7A1FD4D54C838E017BE86F61F6C3ACDFC4C451D4AF9A286A40D4A70AA323FE
      48D5892C4BB45C87AE5E0A9A59DB08B186E7611C2473B30C26DDFA8F7304F645
      8C2AA2EE39E1390B89BDF2FC4A33AB9C5A4BE387C9146745931DC2D7CFFA47E7
      7034BFAC58E061B8D73DC45538EA6CB1D230B7DF07342FD8EAD915DE5B61ED23
      DDEEADDC0078FFDD6C81CDF5C37078BC3DB07BA975C918FF42765640407D484B
      5A41CBB49C00E68581A7FC6F3CFCF9F4C0B0A1B511871BA24B91113312AFA572
      9AFA598CCD74169323DED78F943ACC1C813464B491428DFAEF3014232FC2449E
      0C84180885644ADD751CABD2102ECF534929F91A88A49DDE9E8F8A26222664B7
      F09A5720A4B94DABF4122D8F4FCA8FF6C86418507301F2E991F2CF8F64C07C34
      8085B68828E5BDC622334C640D89A40881FC2889F8F48991B07BDEEB68428904
      E98B9F9EE982E475788BF75F88A6297A21E310834532CB0812546B693B96E7D8
      27F128A1364C3304D42CEC4FB32F6BDD69E33271204210F86151981BD4FA5019
      E074E385C8FC0A95220639CCB4375819162B11BC623487DD1336A736F744ECBC
      22A0B0FC85C2DCD91DF81598D6D8F8C0F8A5E94C5EFA61C489B6BED7470C51CC
      70C29E1EC635CF595A843B4B43921148325422F59FF5C9DC9C6A286C32559390
      A8E992BB3EA0799E44611BDA3C41EC2200638EC858C18D68E8C93B719B138077
      CBFEA57ECE21354317CF27BD55C25FF61CFE7AF51BC7247270E42C3F1C84A82B
      FC80FAD96CD706062BBEC89D90E2814A111C30492DA65AA93F8A749AC9871A3A
      3916D308B387C9652CD4D9EC8FC4179A1C6378334519E0FE5CA7467FAA4A277E
      CCFA71790095E72A70B1A634C2680628F299293B127FDF7BC35A00732AED44DF
      2FA5BB59A8A93C281FBB021BD5A6AE1373A02C47D13F6C6817F47ECA95C098E8
      2C0EB345CDBA2AE0F4500D164C15CE031A4EB583A570845DFA6C3E714440AFC1
      E1333A4B97A15FC2395F517CB7EBF87030743606A26D1190453C541EA73688F2
      2087C2C96C22EB0A8765EC4792D7237517F255016542FA21557FB151316CE722
      A992AA1D4AAB1C4A070FDDA1F4F4C999D91D7BB4AB06B2AB0CC27DC896DD357B
      68F319319BACC87A44165AAF8EED084901776EE745D91AD2388282B079A88CA3
      F10F70D75529470CA9179AF830B2308B6C696CC305F5DAE56494E5436C923A27
      92680A1B704026001528B260874DD72714057F828D9CFC7C714DEF047AA10EFF
      A996D01F36AFA95D36295E14F7326528E1231FF1CA7C46CECD4B6399696609A6
      574065185A507E0EF7A424F69F3B226D2F4A20F80064405C58037A0DB3529BF7
      53780363F3507AA253DBF1A8688B943D9B600AD01EE684F4B10651DC9496E854
      E4C86703E853A946E91B2FD25B93FA9A614716F322E72C510B5625584E202314
      59DBCE80F2727BB239CAB74E4D0BD2F53C00B7C5344D48BF4E1857438FD3597C
      E1E9E45692146C23553330A48FD367E7BA69DDC63EAE95F5F5011F5C8338C98B
      8AF188A8C934030999CC6BCDBD687C6FA056D90C5731F5797D6E1ABE165BF02D
      352A82EDBE7118F32574F28A958454AD512BD1AB94E8C387AF44839898703B75
      3F264F46DE639211BC618B51274984E8C2DA14D88DA640CE00809246086A5E36
      A3CCE5972A0E4771FE6D829521E89E46EE3A0E8340C58F520F2062918A6F81CE
      D612CBE4E27277B7319E6E43BDDDA673B089267C2F53C694C63E5E0A993CFB33
      DBC738EFA6507107BD87631522DC07C284B95CF19AAD548BE2F5C50653D3242C
      50B03B59C3213464426A2E683636CFBCC6BFDED8874464F2CEAB22557FB6545D
      058C8D88809B530159D80BA84C7F419EFF8956839D727313EF953446642672D0
      DA2E195B20DDD808A08193877A48C1082AF8A7480241E4AED8245C68B73CC986
      DA1FEDE3B8C749644B02C15CD1708067538E2ECC63ECBCBECBCD1D8180B6B32E
      47054575E131997470EBBCF127C98CC2559B030B43CAAFAE5EFCA232C982C703
      D3328106A650DE9E93F22B12078AA6D8AB91A810DA160934034CFAB155644C4B
      2A852252D66CAC221BC3464A2F2254307CFC973CBAF02C38804ADA60D5D5DE6B
      F8D406B2AD632D8C6A95CEAA9F21C730687AB3584B4636BE4E0B6F00C9CFBD2B
      F5AE8DF1D3C8B68A25C0F5949943D9DF99E935F8FF557E80E64A591FB1C59AB6
      9F39155F4C0513D41C58D2583A14F248438C9C444982F15A816609731CE0F5DB
      2EDF5AD9D5095807D955FBB8DB811F9DA3DE31FCE81E1EF6E047EFE0B8053F0E
      7A2778C961AF8D971C753B78C971A7D7E3BBF112D8BF47F498D6C9095ED46E9F
      B4F0AA7607AEC39FDDA31E5DD73B3C38FCB6FB1966FFED218F5F78DE4BF8FF8D
      D779E51DB0EE4278DAA9E7BDA87AF969CD5AACBF8034787B02CD6977DB36E309
      A9CFC79D9E8F2DF63DFE7FD5CBF97FD58F89579F94221A22CB3EF2A48729433A
      340C6058EE40F7BEF78A0E743A4A1426BF7374F9064BEDDDB570E130F36FE495
      42FBE0EEE72BDAC7FA092F21B4DFDE84B918460292AC9661C619EB4D843759D0
      8C6A23E19A609D6D2240A6E3E7DA77B1043D911BD699DF6F3224FF72C42F5579
      0BC8BE2F75C9D2A321D932F9E62D765A76010DE43960FB7F10789BE7B862589F
      BF55D6A23C27CFBEB8506A6A3A88617050C0100478092F166B9C41060A2526CC
      9CD179891E119FF16CA82B9094A9A549523DD1F0B321213AD62B20788A8B8E26
      40EE927118053094A6875403B3463342028FEF99B61FA38B83674CEDB81D0CF3
      6DC0E93E27E26F02EA0C663A4F3ABD500B6E8A37D37598676598E7E8A18779B0
      27DE079423FF415BDF9C3A393CD8CAC1367078482BBB795E59F4979FCD948879
      14E7F4F866F43A968E6588BAFC9D5DA9BD7F372C127EB37385DF7F5ED135E251
      4DF8949DC2AF9279FC1DFB9ECD9CD7AC2A1267D5AC6B9D68BDF43558E6031474
      CCDE090895FCDC71919C15CCF4FF2E9A12A31ABE47EDE8A7E973DCA25E03D32A
      76BDE702C4CE9BD77E6944E52E0B6091A3949E94A61B5FC705043A037DC30A5F
      068413176D75C7280DFC4510E4E37D1B6B9566D70CB18F751BFE2087DD679BC4
      BC7A7589985323669CCC6FE891B19A53E69AF3086DB6DA8ED7084A9EE5EAC069
      3CB5009BE85C3F81CDE4A6A74C97C95B73924D15181A2B60D0DF87C17C2FF2FB
      2AD24B8CA4E623AEA1E210AA9183C01A3F4FE8DA648516CA3CB562430C93B3C8
      185D3609D4743DA13371134CAE14F725A2F6212A9793F05A76F9C6CED986C16C
      8E6A03A7584C059413453C174B695B67629A33EB04E53FD5B4D767B3F2D964EB
      0DBBDD26B374C035F0D4067E106684B04F30A7060B50F0FC777E7D0506E76FDC
      031D3690896F3DC7C0212206D5F0D94B914D29C16644E532011B050A32B5772D
      2511C226CD51DBCA98B218C4C452C20A9956834CBA268072CF15513EC1E870C9
      2135439650ABEF9DBE7EF7CEA445FBDE2F9FDEBD22A7A2F7E9F59B4FF9E778D5
      AE69ADA610CEDA4F17052F0A9C47B37D30016B79731157AB5E8A992A4CA6D005
      7C590B621198EA0C062417AA4A5E885EF5763B362D47A07AC3A28D57A06582BE
      308C099BE2FD28B2D91FA6E8086B8311D6C40ED764E61BA023ECDE98317258C3
      32F510DD39D2147597BA64962650B3BDB50BE380B133056B66E5B8F44CDDF1CE
      A44CA61CB501247AB6F01A282E18C0D2666231ECBE41954026902684D579FAF7
      5DC2D644169723677261E866C59BDB6BB16057C15D1A9C8F748FEFBC8D7F07EB
      901A6A6977116BE15C994C5EC3828C1875BB5C2A21888EE84B3797AC486E94A8
      AC38CBF122EE1B63CAAB3E58B16FBB09D263B3C44A0BEAECF53B67479B4B1BDF
      5B99613E9A5798B3A42CF906F43B6F286B5FCC90BA84400BF60755540E06D44B
      8F4A5365F4D3540DC3AB2D10CCA7B6A62B2C477732D01BB89F8622D42A1ACBC7
      3ECE18DE44F60F6A3A884B295D18D912F0094836CD4CF2270F6DD7E8AA8CB660
      14A8ED2C1CCAD5C49772C34618F5426579C75821F9E648AD05D1647A73276B42
      03CD5526B6EDE0EBEAC8C8BF7027E5EF38A865FA5ED046FBF0F1B327B0CD7EBC
      C85B71321228A96713814ECC435DB2A8FC5798E60D6DEB6E7C15F888A8F48392
      4DE435186C0DFE9CA721661AEED626D232F596A9B493F7472D2451C331AF50E2
      699AC6AC5F176B5D6D0D44F5C16947E367A59387ECC24C4371A628B526191572
      422D8C77E1CC89A65F7920543A43585BABC877E963BF4D62346819998ADCE511
      155E2E3D5960A78C08331FCB68C274C2E24C3A195251C88088387438A12009A3
      A43223C94CE9B7DC4910F4A3D0F419198C93905BC6EEFC97D2A64BEA0EC9819D
      0F89FD605B84247166D84AAB0A945CD1C1C5506C250D5C70A70DC4104BB3E12C
      4F91E054D624B72D0F63D7C03B5DBF6EF9FBA425CC96EE71562E08C5B0AC0A35
      A9772539302A50D2F838F0DC6DC50E3994472914459F44A1E95653FA464432DA
      84BBA28499B586252D430823AB98DF8098C0F90185B795E8CA3898D244337F8E
      36BA9AB96A79A588F215B8DDE5667387379FF7B39851A76246B1F55F34C26058
      A77FC759B1B9E67BD368360A6377016D09F06416B9AD506A79BE5E225149A218
      06D8E01179D1EBB377B5D02EEAC856FA65043D5F3666E8B45B2DFEDFBDFFF1E6
      CD1BEE0504B26132E5685E6E164D18F7660866537ED7BF7D4FB7EDDB866A43B0
      C94CAF890A213B6EE084670154E178D9D2DAB23355AD763FA463FA49717FF2FC
      9C8210A995EB95459BE83747046323EFECE6D5F054EA1B0136B9F5B239F1BB82
      93A4A2BDEB7851489D5BC74F1FF0B9AB044CD7759C993418540B8187613E15A9
      0CD49CD43A6D3C8D95740810897573438451704243AC3FF28EAE2163AA6CEEBF
      6D8E7BC52A054DE99F8AD260617D4947C4EDF7F1C38BF736A9E9B1F08B1BD634
      38245D57D5B0F726BCFA11154F38C0F14055AA6DB8CDCCD3E7B75DC75165CE1F
      927B9E3532C9FB9838173FE051F8EFB3D0F7366397030994A83752C4A030F5CD
      0936B0D31FE407A5F2A0909A70DF6841C9A7BE8793D767EFC3610D035C29092D
      F2A71C6CF840750F36F5CCAF5B0C38AE4D218D5BED43BB5470777FDDFB6DF32E
      D78B493F89240BA488013EE0756063AF7A4756593D74F7A4A0DE4D61F7B39749
      309538FCA63D9D2569DE79D4269A91C1399D46A19206A70C0E02C3CBD1ABC8BC
      9CF80BF15162C245928E127461168159F0BD58DF6361B945B1C3970C1252E3FA
      FEE0829AD5A4FB5E83434992B5263E421A5985F588338F5C4F681053515F9C64
      A6D79B9308A7AE7C4AEDE12F64DA929583C30AD13F96433580C1CB8828FC40DB
      66B15A2693816731A17D067B21287AA3C2E22E4158F934896D5C0E97A8695211
      790F98B5E4E6E6E5D5A3B43F384E614C980F2E4FC4AF5FCB2C717E15BC9266F9
      D1BF004AFA6BB335E8697EE6BC081DD66830283FD6B6341D13852530192C6D07
      D3DFB20CD7BB4DAD1BCEDF0D87D279B3643024733A8EF32900AA04E16518CCC0
      DA31DB9D7ACA15EFE78BDDDBED22141F50C5BF8BEFD8E7BD901F4578E5203FA5
      3EBFB6E1A0F9C876D9E5D70BC82F63F6F89414B5340FBB36F42CC6DA5554CB41
      356BC56798A9562739419684A684CEEE5FC92B852DDC940A39B7776EBE109611
      611B61EC3F30EBBBC76073F5DED327FC26784588DB1EB37D29799612755B1CF2
      76915229CB8B63F17A25629A84AA31C75AA0E4FC288523B36060657788DE7221
      79CC51780EFC082A0ACECC66D98A60800581A1EED64AC766698A8922ECC6F4D8
      D3F00659E50FB02475CA5909CCB448AB1DCBDE799F6E56AC1DCA9A12E41C5831
      C4469C57DB411161DD18637A114089E831C280FE83E44801EC17BFE14A3337A7
      B3B0FAF8C57BEECBFB17AF5D9F9F0A75F9F99AC60E465E9E72A585FDD5A7C93D
      4D5673B7B03AE49424AFA743D3B991C479BCD552B64AC81C55362B7ED6E6BE49
      19986D4DEC6A398C68578006649F2DEA29040524ED910BC396FC3513A24D8C2E
      A4FCC1D8D91BF87C1ADED213F0EB5A7E55AF011D82F541368D24D591126293EA
      6A5C6E4BB1572BE953C53E69F467212BCAA922236240F6518A7B5A5C421824F0
      19618E6B9BE1EAA6B7BFBFCF759913CC241C61E7EE517EEEC56CDFD1197EF2AB
      1DD36F149831B75828993891122AF38DB519E1A92341C168B7E05C813A2F9912
      5C3E8643337A38EC9A11E8EADA1DB36110D23963E073E9A7797E1554CECD7E07
      E91A82BEFEAD6BD908CA9ADB784A3C9A4ACE12EE15505E517414E43D8D801897
      2ACDF2DED41865D60BB0572798325AB39ACD611C7FA2DE85F185F7DC7BF3B187
      B532F857CD5872504E872C26C3070FE39BDED96BA3F086F1209A055BEC7D4920
      84936B7286342558933CC734EF8F3D4EB79297B393C667644E9D6731526761F9
      003B54374B598E79D2B66463854BFE0EB25BD196B73BE1FAF6043B3FFAD97887
      40864445402546BE34C556C86AAA27A723CB35C3089AC80E7DC38C3797A9AA55
      DA10360C4CB87680C9E2548115AD07A732C02A6FA8BF80DAC654F08D53693BC6
      66E3E48546E10C486FA30DB48F70A9312F9D03E57D23143223117002797102B5
      38ACF95A85F03405778C8FD87567B272953BA887E155DD9CD0E57811E65D7A92
      DE83299E2B29E688E1891FD8A2C92582DBF46253DF069B7BB455B6C7DB9853C8
      06BEB429D3CAE6A84BF62DB67F9DBBB936B31807328A29FDE0EDE7F7E480263F
      622ACD3F9DEFB1067506264CBC05D77AC1F1C37000DC110713EA49AEB4D95C9E
      0A9280CF3A4F400B9E39105D3651C103B88ABA4D4F27E2ADC5A221D3EE6EC945
      323749E8E2DF29FB7805467A05C2004C06560D33DA09183D0711904A253B54F1
      28F717D87D551C36ADBC98073453BC8A8A9F6156614073ABB023ABFB969F3EB9
      76592C67656AEF00356729B687DD594158A10561EAE1E5DAFBF9FD8B57DE8F29
      6AA31945B4864CBD9DB32C9D0DB21DB41B765E1020247C653EA4E01B673F4D14
      1E29498C4227327701AEF49C2662F1E3D0D37E98A558B9C4079411E514279655
      202631728C8B6D51F0F436339A4E417340C81AA4C9AE773648C3A930078740AE
      7BE1A7B75EA30F120D916E28528198FCA93F7A163F436897DAADBD79E97E22C5
      0C3599247DFBEAFF6FEFEB9ADCB8B12CDF15A1FFC09D979676B57626BED18E79
      B06C77DBB1B2ECB1D4DDB1B1B30F487C485C5591B5C52ACB8A09FFF73D17C84C
      3249269949CBD64E7451A1AA220920818B73EF3D179FF964C62BF7A658379737
      0E4031F3F2F4076FB6E33B5E7FF34A7EFE0A6CBD25D49FFFE507AD16DF7CFDDD
      EB0ED53B3B0AC8C76C8FCC79D66D12E92FB5B9B95DAE6FDBD5FFFEE6879F272C
      84A6ED1733C8633F055AA6F1BBBD58C5BBE6EA919D5D65EA7A0BDADC9DA8D9C4
      3D97E6DACC9F2D9ED3A6D3BB61D850A6847B3095810BBAF5A278C972E176B196
      ED58461E5ABFDD8AA20C5CE6BBA8FEA5DF66D28D1176A9A62F33FD721BC62CE2
      0A41513EE2D4C1AA7495A455EEEFA74C397FD8F45D090C6D3B33CBA30F6E3A51
      EE0B320F3DE4C5A3DB0A959B0B0B51DF9764C995AF142961C66A9D872DE86C40
      6AC060AD421EEF80C63E98BB69B31065C9846FB7802140FC3C8B9CD64E03950F
      766EF7DCF212296E7959D95F5106E68FCB71C292F2CDC1E2C8E55883961F73C5
      1EB4F0D7FF40C3FFE07582DBF5526591CDCEB6F727E448CA0409AD307ABA3BA8
      B055F9C136FAED8AFFF3587EB008E75D44A18EB4F18E0E497A427DF1D30F4440
      D1637452521934DB0EE43FA143939E2DBEFCEADB9FCA80FDB3C58B2F5F22D98F
      7FFDA94DFCF2CBBF7F4FD973893F2F5D4F56D7F950C6274FDBA19CB3952B43ED
      9BC2849F3E58A61D065644FAAC3BAEEA481C31EC4F1224944DF4FDBA3326D96E
      2FA74C342C39235E6F37107764A9DF455C2E2ACB1B6DCB22F47C7521ED925BE7
      38EBBF2D7E79B6F830EBA0F3C12699ED09829BE86E69A694C64376B68397C6D3
      8EDD655963B4BB57FE3CEE0A9B29638CC5D0D0845277C0C5D38CF23CF058E699
      868F6DC70BD2FA7E15DAF1D1720DD52A6622480466C6C0F63652CC0BB7F6BBF9
      A8F275BB023B251C468DD38F058354A9FC1284E2118B27795E1AD6A23D7C31CF
      345D7DE8F8ECF05A50F43E3DFEEC635E3C7DB6A57F231D3A5898BA7FFCC14EDF
      90AC760E57A27454144961FAE858B9BFAB0DAA4FD9BEB2C5738BEBBC5B6BD93E
      EF59DEC89DC73EA05DE8B765377ADD0EE46490A19AB7B11F3AA27C978D8A970D
      D4CB0913B41946DB11F3B274218F35ECC2A497FC1F7E134976119F82A85C4704
      5A0F1BCA278C9A74577DB6A370BDE9038CB7DA529616778AF9E0BD87D6E5A459
      59C518262DB580F2B6F785E60DAF3BFDD19E80D99B9D3270119EEDFAE43CD6D5
      7F919FBC7B7F198D7EDD9623AEBAF31DB7FB43DB5B53E82A93555E415CFC5A89
      CCF3BC5BB665C548659353A638768D7A73FFA68DAD06C3087D9DF350C2D6BA6E
      2516966539C304695F4F906277FFCBF6019D752E531B3B7528C422FBBC7EC959
      771A0E0D90146152FE1D3993D7CA6B8EDEB713CBF920FAF66ED467DB85EC1DA5
      D8CA3027EC563E67B951066213F40D5DDD725BCE126B59C59ED23D0C014F8880
      BA799DED0DC634FC3F58FC777E3EA55C78BBCA8B9CBA75F89B3CCD704F73A6ED
      98E38311DCE5F4C76E4EEE8DCF934CAD69820C7CF76AB9A1C383865370ADE183
      A0A1B7796D240DE11E0ABD90B476E466F78E53B2B2650BC6AA1C89B7BBEB83D6
      60F63B42B255CAF70E0DD65B4E39C3A93F0D89562DB4A727B949A738E598E1B6
      A7B9E570A16D4B88D616164EB5FB6B36F7DB81AAED43DB4B01068B26BADD1EDB
      FB2AF3A25A94403B931CA5F96CF1E479D9D34F49DCE048E49DBD6F5B3915025B
      DC4E7B1AC0F008A9F7A8C5FDCDF41D5AE5C685B29864387D0A5C2C7D2CEC758A
      797F13F3B28F7E218F3BAAF2F44D09E0B65E74D74DE7F69124AECB9C104517E4
      04DBFD43879E6B9B75B9F50C7B1B129F8D2D35DE75C36D97742B9FF3FA99AE68
      0499B4A49CBC3F01A6F8A7B28F8DAED22AA701FCF6F5887B4F9DB056FAC1F74C
      3AF285CE37FB974E8C6FCB9AEE638BC41E36F81EDD6BD30970BB386CB224BB8D
      656FF389B471D51D36D71571E3E8E289E81D91DFE55DBE95814697377DC2BC08
      F82DAD8A6B9D0359BF0906E9E66053FC60F35C77667E3B930ADA5C063EB6317B
      5EE4F0A05FE747967EF8FAAFE8D896693FA84E2797BFBBDB7CF14011CCB17567
      ADE4AE89EDD00CFAEA1D2D0C8B9BF5EABF3CC0EE9C785FBDCD2B20D6855ADCAC
      976D0C18A0D9D7349B95778983D6AD6F1F42829D9B0CF23E8DCD96F9F4530AAD
      45A6B986947767DFDEDEDF10FDD80AF9FCA03EF542BBF4EF494F476980F8A57B
      39A065AE1BB727EFB15CDD67850874AF4C59ADB0BB4365A766F9DA90F7D34F10
      3FD1DE7E65214164B1F6B4A6AEDBB0340411AD9969DF6E0F539F79472B2D9B7B
      B7A2E71EC1EC2162739B2778B9B7B4EB67F96649A7973D2706BE09AE2CFDC8FB
      E2CA61BAC9E53521654907FC6CFB08AA521145C7805B6F8958B08430CB37AB7C
      C282EBCF1EEB5745D25A9FB2880601E15DBE109636ED519AE676FDAE70F5551B
      D77CB6F89FEBFBE284DFE5499686C2C3BCE4E4FD83873D3F98B9BECD6704E43D
      CFDFE7C5988BCFB737DBB49F90D2FEF4B71561A8DCC9F3E5D5322FAF5BFCDBDF
      5EBD7E98D91DCCB8ED2D07DEDB5F42A2DC1ECE9117B9925ADC37BB937ED96274
      A27EF1EAF5E25F173FF5B15B91FDCF1BFAEAAB57F88A8EA489853DEF7EF782BE
      7BB16E1757E46F9E8ECC376FDE9F9FCC7FFC880EBAE8CE17C984B76F467B9FF6
      CE9CF42E9ECA12D821A2BA1C235759D0672DE01E6E509B1C8D7E797303CB5A56
      1EE74D95DD01E13BBB151E7475671FDBCEB5BC7B2BE2B797CA97C9D5EED0EE75
      B95270DDAC7F69E74676EFF6CD4CE06A797ECE026969E278B9DDC6D03EA62B3C
      5B81D5F82DF08BAC2EF08FAD91E94E0EA543433FEB6FC39E36973598BCE94786
      4A859E75F319DD6A8AB69E0707383D1B399CDE6DDEF5474DEDED5021BAE47EEE
      AF5D5B3C79D59183B0DC78C0334E384EA92B73BBD1653A837BFCA81FF9DB1EA5
      EFAFD69B76CFDDEFDCEEDD169763E0D7777B8BE4DAA7EE36AEED33D4B21BE726
      CEB4C907103CEB16399633B5DADC79A7E472CA4688B2328716BA10ECFEB44145
      A2BF9FB3DA2557AE5486D693940AF45BB3695473301BB621F1D1D4DA7D7B3E7F
      B71429C7B12D31DCBFAC808A797007E7A3D82CFCCC9EFF13DAFFDFFFF84DC8C4
      4704659156AC94032DBF4BDF2F37A4574F5CA4B5D67F5E7CF7BEA13FBE803E97
      24F48E8CEC9F69A60A29F1CDABF5ED5DF972F3E7C5F3F5FA8AE2977F5DBCBEBD
      3F5B87F8F48B8F7DF0E794E902E27FED21F9AB968A21C86BDAAADF7407831EB9
      E83AFF717FBBCA97676FE761BA33BA40DDFA9B2FF2551EED2AAC4F70BAEA91EE
      DD1CE9D6BEE35EBFCAFDB9F9F83D3265B210752C4B0BBAB3BA3B31D2DEC0B68E
      79223437E0339A99EC649E8F742C43CF797146BE56F4FC84D0C297EB4D163BF0
      1D5C9DDA9BD83F7A01D9B6E79E47F09272CAEC13D71EC3953BAFFDFBD368CFEF
      713CF20CA17CB30ABF5D2468E7C75C7AB777B42AF115224DEDEC2FCDF776ABFC
      CBAD088BE6BE69E8A8F3BC85F36DDED7145B424D65BDBD7F1369C2F4269651BE
      BC3C86927F5ED84D5E169C3765C3C4DCDEBAB335FC30EB00CCDDE65C2DDF111D
      5A6E265CF4B9758F77BFD85AE1676D38C32FA685C12FAE94C02F214D855F5258
      4AA2444D49346794C430214A6E4A021FAC733195B594A8AE6D45A96A8674F49B
      6B91D30925D5EFEB93D1FADF1FE53FBBDBFD6E1A4BBAD8D9569B15E0ABEE92E7
      2FA616D1907999FEBCCF3F47503D3DF9AEF1DA56F5E9E4DA2DE81ECAE989A97E
      650F00C0DB3EEF431F654229B775985E685AE6F583736AB1354F97353AAEC2E4
      D43B691F08ED8E8B00BBC9378A7C43A3F15FBD8DFEDD8BB57FF7C7139BE9AE32
      FBA3DFC1591E4AE26FABAB4F220B90BC3D2F19969BBC1AA0BDFDC553EDC8AF95
      71DFBC4A6B6FA744BF186DBB50ACBD5FB01D21DAE4533E36EBAB9F73C934F944
      4BA7DE2FF3BEDF72C44477EB4DB7948EAEB0DA1E6F74B3B3E8F453EC1CF8C7FA
      F62ABCBA71FEBCF23F5BFC89964BFDAF1FFFF79F9E51B4159F7E0AEAB3FED482
      EAE5503F93E72581D6FF5ECABE076FF2452E6F1ABC8D3964DC593AFE74746BD9
      7B6AD6869AD56E7DA22593FFE83FFC64D86CE935ED6FFD3B4D427F2A5B7AB0AD
      E60F6AF84B4707067C9AA6D362DABC7FEE3D9D630084BC2BE7845DB9371B3A19
      9D0E61CFF78696E1D6BC2DA25D2F7B7EE577599919EFBA1B0826F00947E47C73
      C5A4C5CF6B10868FC7230EE741F6369417616A66ADE566B1D586FFFAEF68FA75
      04F1720B5989A6E295A84555550AFF4D955F0C0C28DA10ABD4A494CA67B5AF58
      FECDCB7BD908AE928A9A220AFC94490A6D75A5A4E632B0A88D0ACA3B6F6BDF88
      E839AFEA0A8910DF246F78942C08F7F891F50DC3C30D93D11AE6B5895E3BA6BD
      AFBC4124236AE56D300D735A4A54460B1F98148239C3AA5A29CF7CB09C276D23
      6F22D7AC0975AA74233DB7C67AA785732931C1181E139BBA115A062743423894
      8275E1F123A98C3575ED108079553B59256B92685C131BCF0CD7469B4AA030EB
      2473523751A18DA847C37830D1569AD5C9564E04961C3715F30D975A3165AA14
      20CEE803AA5E075F9BD8A0949A9BC8BD153CE8282BDEA8C78F9AAA0ED2F01063
      94C9420C22325B35A8034F5C89E8BC708257C6F086FBCA4270D13B93AC806C6A
      85B6E16D63994E924527189EE26A1FA4F59054B2B56DAA68645412DD5273E94C
      88AC4AAC6A8CAF99E74DF5F811095B269F948654F180A89AC41B1B8D45F59BA0
      A455BEF101ED6D9889DA7325A3F7A8469D1222CA2A499EA2A979E0DEA31A8D4E
      052B89D003BC9CC2197A0332701AC5960F2BAE00157A352DD29266C09847E09B
      80ABF66F43404ACA11B2507F1D93914D80186B1D206FB4AC06AAD013C9495B09
      4EDDA3033A0421B14ECA305637018888F829D2E3471EDD5AB9A6819C21EE9892
      769687145D344DB2B1B62292749475CE55CAF3C80480E71B6562AD150F006702
      82AD914E38CD6485EA003C9551782E9ED11080BDAC42ED38C414785D374E0AD3
      285E595933F44232265841A9988B8229116AF47015182A2443C385624CE8E4B4
      AD752D53D0409EA1AA45C80C9AC193AC15144B738DA644939CF13625A00632F2
      DE46917C8DFC89F928053A454165AC105EE12B851AB81A7A952297BC09C0B451
      D2B920EA18AA4636405C502994BE99D2B3AAD1D6AA5A99D66218D75B92FC82E5
      C0136025244BE5EFC78F76DFD1DF22A08088FF1A76857556058DF12254E87B46
      56057DAA83ABB5B615AC013AA3014C8554507ADFB8D834093513DCFADA891AF6
      0512B509B88606466E38D788018063A84CF3F811DA833FD091BED255304E4998
      9C680C815AC3DE388D7E33C109537B7494573EA2CC1A0A16AD363524DE080345
      0B4958C0924BD40DA6021804324223436055508D84A992AC8EE88B106484FE0A
      0005A60E35D0524783DE84F106CAF0251A820EAD183773E42F629D4415744636
      7DD5D4B9076A3526FFF2F7E347DB77BCEE641E3D2C4A32A42DAA164D2420F154
      991060DC9A464581A7358DF7B55511E96D83960A2F4414CE44051D50E833AD60
      CAA09D1A96156D12A42ACCD7F81D38927358C4908003E809B40C0F870E2788AB
      8132282BB98732860A79B9B41606DDEB10E002186C1D83F6D512D63526946161
      C302AC4AF24118AB5D0ABE4ACE6A6904FA1C4203BAADD52C720B15960EEA5837
      962BF42C1A98481BB5830A3B0587537BA0890B21AD1196D0C4606D519D10AAC4
      53638CD74A1BF809AEBC417F5BB2D0955375D0158FA161B0D3164FA8BCE39013
      B3105F6552B43037A80C40C962E4CAEABA460A05B1D6C041608A057CE69C9775
      053F0A5B01AB250C23BB6561366A52AF865580282C173A05DEAD72540C345D78
      9832AF7488F06EAAA9214D3890C8E04284803B341AFA002F8E8A73A582350A6E
      D7C40A668CC74633F846E36A56459DB888412A0928451F19F929C6025CBB8187
      0C493107C36BA5F609F60AAE1E6E33E171C00B99CD04736B61132314D10609B2
      0037070922A707D4D14D4139980A97A84D1517B503209CE42CC2373A9FA03656
      6BCE1D1808F0926A07480348160C023AC6599322238978099F958C22976D05BA
      BCC1A7700BD127ADD187705CA28161764983BA54502CD005B4063D41F0F112D4
      055A0E1F0917A221590B86820F600A9931B68AE4404C94DA85643CF4372A5B55
      96ECBB40FF7B8EECB0F300154469A461F04E06706A049C9102C0006D85FE8201
      F13A42F9A184C2421470F80C24272942110C81ACBCE4D1C103D4E6F1A39AA326
      09DD09C136502FE324F10CEA141B2DB7700506C527A981280689C37CC3F7C15A
      1B566B1807823574AD4E901284A4C8E003C5A84345FDC12A95644C901C6C1844
      109B08CF63D01B42C3F5F9C78FB827F70CE70BE71F04C00CFB65C0D39C552E49
      3814D43D45289B73360126093A08D39A90192E488019261FA1291A60090D65B1
      CED430B44C929F44A129446F528D87E4771C3C083FE0B8E02C247401CA03BF0B
      2A0A4540CF30193C4010A02035914048AA325A40EEB0C0A8738065865F00CE41
      EFE03B2104015FEB3DE84005A72E914C35D4D0AA1635B156C019AE1536B3022B
      824B26421A502DF0AE0463051C180F3EE46B104D940DA302036A3C0CBD328D01
      E368D0DD2059A80BE89D01B0517D38DC5AC24B8420203BD05E014A9018940756
      0C36AA0235B6302AD2270712A8607D88C19908FA681C0AF20C8EA90617F302F6
      C03415786963609D351C0CAB1C582E031BF20C9E056914F2A03BE1EA513B8FB6
      3BE9C00E8285E941E73370F01A55F3B0A708AA1A034F296BCBC92F3903E7A205
      13818CA8810E82C072E0C3C356A311815BD844A2B9B010CC383C0B065553C1C2
      33901638487C0A4574954557A0D78179A04B434A96A36E02FC8D1B408D3932A2
      001DEC1B8816E8AF0C4670078587170955444AB419468BC1628181C2DD812AC3
      51831FD489020610A748FA9CE14EAA032683FFC03BEA0C07019317C0062A0D76
      1A44403D8361D04C61938B444C04AC9394880E1AB84AB058208383234647D64C
      C1D881CDC15083BE8186DBAA8E280F412E740112AA1DFC72834E02778475C49F
      B0C1B070090618B64C020E42422B05A91A7C0374264420DEABE4B9433736C079
      641C262BC1DF001DA8362A0F2D0D8D920D876EC0E4C50885612A40B512451E04
      9A841AC458E11D78338C73B1BEB0DD30D051A2117087F059C926F02254487B94
      5DC3D8B006E5417784531A7D56C1E759D07572082085305D55132BA7113C7055
      83BD07443EC00D8C17B40DE52656732840A5152C12FAAE81B5068E2DDC0C7A17
      6ACB292592C214A1A228512584BF501D87A7211442FF0517AD820587EFB588E8
      603E107825043F0D796D180C102E2820DC23702B1B0A9A34A88965681C582834
      455702FE1B9E293416DC07C2E150205179624F5026D8583064B81158274432D0
      78F825187940B1026D80E4F1F406880D129C88A00A930B0383288BA2490A9DC0
      6434824B0B2657C3E63B8976A31D963C5213BC0733F791A236501D101EA52AE5
      6A09888206C0704B22A5E044F0C9F0A130000EBE1DFA2E3928BA847E4221017F
      B02254194443018042540AEC54C2EF200A05D936011D87B8119F4A38269879B8
      72B853E81A3C398AE11235488862418E9112919D71604968212405E1A1FAA002
      10886B5037CA0533A8C0A1341E0740C2D6C3134487EEACE114281AD0D02A0F33
      2D149435AA944C82BF41988B77F0A78868205D488F59EE40C403C58D4005B891
      CF06196407524698089B2940551DE92693A43DDE409114B8014757C1DF448440
      E81B7C1515740A440E7649EAC01D19490476887034C1C659146BE046885D6BF0
      71C011F6562378D7C431D00B14D1C2D4900784F63304CC0E7582D7E0B540B911
      FC8359985505B202070E630C9203F54670064269D05710B14D4C7B043F027EB9
      AE6DA820740A75E1CE50176A7394F0B33029567A080A5403E2AE7C851AC08A30
      0B3A8A6EAEA5E002913C626C7411FA059C4C79471C0D3159809E83EB0169149D
      C3E407B82492BB40688738C3728E58A081BF730CD04274022305E3DED415080B
      7CBC84290AE887464335688402221388DA02B1970A66D926444612D60E35834D
      7175836815BC81EC43D57806AE24580312086F15B4065D867146CC0B8B832EB3
      3484436CA5D1309035E00B4F033F934746109140FE88A41011A271E84B542451
      C38927E2917020882B5530E0AE8896045283DF309006F4801208686B0FF1C006
      82258343680DFB810F14FA1EF4C6234A95C02F4232387EF40BB41CFE355235C1
      E31084D4DAFADCFED0C01FD1C0166410C8C505201146D8C39A23248095006251
      535F5788779A2AA1E1CC6AD8661E2904241605EF162214189483740D312FC891
      B27083C00EF40F8CAD89126122682B0D3A90B82D413BC27AA3DB103B91D220EE
      09826A001CA0810A8E013DE612FA028402B4072C0D4618C2B7C13999224C0F77
      285943BF28AE068A10E043E4F00A0E9C499184D1471286A3815DD2505184F1F8
      0C460618061AD07E7232802500A560663D88143830E246F01A7858E403E5815B
      420D20C3A9D16205A3652B4BB52D517A53224DA64F478BDBD119F8C6B391FB70
      FC26C7F0C44AA018D068A669B824295890C651C4033C05639008AA438152141C
      81210548088B6BC422016122453406F40AA60CF6205A0B72DB580D0E6841CEA0
      5421C2304197810678232400B7B78831E0A70C58273820027178006383E57005
      0D4463600014EC6B0C35288C45C0CB8CA0804C20F4C1D33868B886D231385450
      707014B07291C091A05008301DD814221DC198E30E341EB15B13E0BC1088406B
      61DB68580E74173C152856E800F87778911AD597082968D40662000F3356019F
      709388BFD0C1A0AB3025A08C64A31C0D3F78A819C89C234D171E118B049C8070
      D09ED27383DE876F672054978CF89E7AED8E0683A58D8E079FAB038D069E1A0B
      3CF6E255493344E21669E79E796E9CEAD80BAAC24E69C5EE18CA714D3857AB73
      A337C75EF0497DADD00B47EA756C64E75C4DCE5986A33581FA9E92CFEE98EE74
      9B916B2AABAD0464F92FDB5131EF2BD77DF5EBE34734D9E1D757EBDB8DA7298F
      6B7743C7642C1055A6B664D8697A92E630AD402F622A467241F8C71015438115
      A15AE05B8496F4AD84BB17883AB9A11488F745AE31FDF45402E48A54DA12EA51
      16683D78A7A399059801D86A8DF081A218708AAAD401BAC2F11DC5730800B4C0
      BF0A0C2B311AA4E0AD64A0F3088E92CE756AF3294532A4EF44FB2D234B81388B
      E1335DEA9C5B0922C7A125080D13A557963434B71039787932680D5A4E6D12A0
      56E533A19AF2594EC7FA74AC4FC7FA74F933944D75CEF3416D19834FB669323A
      E9337690EAB0247E90861FA4110769C4411A7990461EA4510769544E63207192
      6853FAA97B97BF434F282F8629F63E433A60A1C5249D81BCBADBDC7DB88A9B7F
      BFDA84CDDDF2DAFDC2B5A437B4E82486105395BF8AD7CBB74BBC5D759FDCAFF0
      3ED2DC79F7C9FF2D17D6756FBB63F6F1DEDAFFD816197FF1F1E66EB193A35EEC
      A6AF16DBB4D5E2653E2BF68BD1D476909A4EE120D5AA6995D5A0DA25D7B6D2F5
      78058E17C9BEF8C805F28F5DA0F8F88D961FBB8EEA6317A83F7EA3CDC7AEA39D
      5460976B0915FB65328287B9A6817498671A0E8779C40579E4452D9A0698611E
      7D419E699D3ECC6327B6A843071FC2E36EEDD1CDBFB180693D7EA200FEDB1B31
      0D0D270A9866664E14A07E7B23A681E64401D31074A2807966A238C6C57740E2
      EA6EA66AA5F5FA6E95F76EC65FEE663DD5AD90AF3D776D6EDE7244D6AC2C54D1
      B23E7EB672B6C6F7725BCEE5A0D4F6D6DD59D5BF2B8B5AD3222DDFDCDFC6CDCC
      86C4D5CFF16A7D93AF93A42351663DBBCF5C1633CE167BC6477F00DFA520D916
      30AFE9B47FB5BD1D6DD6A36FDC9B8BF281D7FE860677B9B34ACC6B680F11777F
      F79670B78CF3FAF9DAF9DBF53C54AEDD2CEDE8F2BD586EE6B68EB22C9EDF5F5D
      C579A622E77B39BF1B73BE7924286799EA040799E691A09C659AA33B22BD4B1A
      D5E6BCA86D6DDE0B9AD8E6BCA0A5A5BF2F69699BF3A296B6792F68699B538E07
      A7F530967DBDBCBB9A6758BE2AA726CC6CD7ABE59B95A34B8667319261195FB7
      1782FEE86EDD9B5B77F376F197F56A9E123F5F870F8BD77359429FEB326A937B
      E6ABF61CB5F97DDAE5BC04857DDE7911D530EFD420FE78EE795AD71E08B7F876
      4BCC8EC3780F5EF7CDDD6C24BF7257F78513CC6CE0D7EE6EDE93B600FA4BBEB1
      A785D16F2F6226265E1223F8B6F5B3F3DABC7DFEBC476EF3CD83E0BECE5DFCD8
      36FB5C43FC9CFE986F2ABEFD70136FC114DFCDCAF597355D051CC330F751E033
      36C4F0DDEDBAEFCBE3198606FF9BEB9BB76EB39C47E8BE5EFBFB7CBDF3F7EE66
      56C61FAFE8C8A5D952FCE6BF5FBBE5D58ED398D777DFBEFEFEC5E2F5FA86382C
      EDD49BD78394F9F9FAEE6E7D7D51FE36087EF28FD83C9DFFE02FC19C571FAE2F
      69F09717446439E357CB99E6ACE45A870B727DDDDF847D4913FF47FCD0ACDD6D
      98FFDC1F6F63518EBB7841EE578EAED39A9FEF35F4994E5D9A3D5E9073D309C5
      148A5D1AE86EEE9BFF13FD3CCD7BB92E31D59C3C3F94B39D8ADF9F3B483CC83C
      CFC60FB2CEF42E74F7FA7AC7328D8C81BDCEA1F05F6F9761A4593B86CEC7B7EB
      2B3A70BD2FF43873D99737ED3FEDE2DE2E911A1AED17F9229C576FB701729F70
      9F7A51C2BE07FB54EC48AA9D56F5E9F81E190BCBFBEBEEB9EDC0709F569C4ACB
      8669E5B1B42D5E0609D568C2BD12F5B184D4A4FD12CD6842B6DF7A3B9A940FCA
      D4C3DEF9DADDBE3B94B9DE0B9B68B23DDD5F1DED45CD8EA73D2C941F4F98FB72
      2A80E064E8CABD5E55CF62699B6112A846929FC6D648A6D3201BC974026DFB6D
      1FD3E79FE2CFCB4D37B67A7C2C56EC357FB313999EE06F4390FDDBFDBA75BEC7
      1F32ECC6EF567771B5893BB9A628CE687F9FD0A111C99E50A6911C2774EA788E
      31E51A497D5ACBC69A7E4AE1461E7442F3469A3E4105D934633E92FC9C021E18
      B8692AC82E51C1E9067F24C704001FB4670280D96C00B3D90066B300CC2E01F0
      7ED3A70098CD06309B0D603E0FC07C1E80F96500E6970098CF06309F0DE083F6
      4C00309F0D603E1BC0D3E8CD48EA6900DE6FFA1400F3D900E6B3012CE60158CC
      03B0B80CC0E212008BD90016B3017CD09E090016B3012C660358CC02B0B804C0
      FB4D9F0260311BC0623680E53C00CB7900969701585E0260391BC07236800FDA
      3301C0723680E56C00CB590096970078BFE953002C670358CE06B09A0760350F
      C0EA3200AB4B00AC660358CD06F0417B260058CD06B09A0D60350BC0EA1200EF
      377D0A80D56C00AB1343774339D0A4E3551CCEA81C8FF987EDEBA2F83EE389D9
      1B7E38CF8947FE345812743C233BFACC293987427ABE5EBF9BB14CA02F6588CB
      E7CBE66AB9CE63231F7ECBF2E8FDF1D91FBEEAE733779389A3D35079307718A4
      0B369A70180C093E9A70483A85184DB84F21841C4D3A34A362A84E19AE255D36
      78C3B46A2C6D7D2CB51E4BBDD77C33966EAFF5762CDD7EE3E5689B64B6178362
      653D9658F55A3CCCC0C632E8E319CE8AEDF820CF09F98D8D3D9D10E5C833C665
      7A3CC339D18EE49A20E3B1364D11F748E3A6CA9DCD95FB64008F8DB14C903BBB
      48EEEC62B9B3D9201F6DDC54B9F3B972E773E53ED9828C8D254C953BBF58EEFC
      62B9F3CBD07EE02ACECB5DCC95BB982B777111DA0F0CFF0CB98B8BE52E2E93BB
      9C8BF6FDA86A82DCE55CB9CB8BE42E2F46FB7E9BE6C85D5E26773557EE6A2EDA
      F7A38709725717C95D5D2C777531DA0F1A37947B8E882693C09DD4277DE84EBA
      93267C27DD490BB293AEA580270DC74EF269247027C334127828B6492470577E
      2319C60539CA1AC7653A89041E087712093C2AE3919C13843DDAB8A9723F4902
      8FC97D328047329C97FA3EB19A2AF79324F0A4DC4F92C093726797A17D9F6F4D
      90FB4912784CEE932DC808259B28F503EA3843EE2749E049B99F2481E3721773
      D17EC01ACFCBFD24093C26F779267C24D70CA91FD0C719723F4902C7E57E9204
      1E93BB9C8BF603D6785EEE2749E0A8DC4F92C093729717A3FDA07153E57E9204
      1E93FB4912784CEE6A2EDAF789D554B99F248127E57E92049E94FBBC7309BE47
      96F9CBB05F5DBBDBBB0B77397CEB366FEFDCBC0D9E7F6BAFE289A1AFF0AFF9A6
      06BAA461734757DB56753EEBA82AE73B5555DD9ECFF4F891A0E3DEF389409CB1
      28B9A8A5914604E1259D9A542B51CE52E28ACE353AFA52A5A450F954D7B17275
      53D72ED6E3A73B9517A7F38B51648A29E5D39EC64EA6AAF77EEF7D41F9537FEA
      D8E1FBFEF3DFF145A769FEF3BE1E5AFFCFFB3AD2FAD0FE8E7F6C4D3EC5EBA1EF
      FF795F0FAD3FFD92E01A2A95FF5A14EA21C042542CEF353ED0F61C4BB8FC954F
      BA94E37EBFF2CA056B8C65A90E7438B592A8A9A8ACE24CD6518E952B2B43775B
      D0E1EFD12067558F318EFF5F5EA312B8F0F5F8D1C7ACDD1FF1FA9812F8CFD77A
      7A7D2C095CD0FA2EF6685FBFFEFAFF001F30547F}
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
