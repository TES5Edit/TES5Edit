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
      789CECBD6977DB46B628FADD6BF93FE0E8BCBB2C754B0A264EE9DBE75E5BB613
      DF63C77996939CF3C2ACBB40A248A205026C00D4D059F9EF6F0F550580244450
      9265AABBBA572C8A026AD8B56BCFC3EFC3AC9838C32014933848A68EED768641
      9247F4CF783175DC8E3B5C8EF989893DE47FF3229F4DC2D178E6391DBBC3BFC6
      29FFDAE55F6751EDD75144EFE21C9EDD77D4E7898019FBC36226E642FF4DFFB6
      FAD7716EFF3E9CA449518C62F8600F61D830B286932C9D07C970329E05592E0A
      F87E91FDDDFD7DF8A7E12248D25C58B60BFFEFDA9EDDB17DF8CF854FFE1F9FA3
      B9C8AD1FC495F5095FFFCB1F30A4AB879CA7A1C856C774EA63F6609C018D8D63
      FA30E659BACC2291E1A87FF9E3F93318D16B58A4BBBE4800A50D1B86FF7AB058
      1CB4F7C7F9CD7C94C6B436A7DC6F12C5B70FB4F6BF3F7E89926908FFE53C96DF
      B02CC7EB6E86DECA987FFCF801067B1FFD84CF4D82B8B0FEEDC7DCFD385EBE14
      7FA89D37CDB1F17CF05CF87CF09C5C8465301F6551607D088A192DDAEBE901F3
      AB28CF6F1F704287E2D2D06AC0388211692CDFDBE9A447B0AA417DB034C9D338
      C8E5667D7F97B58D24C2F07F808E7F9C8B692AAC9FDEF1E23AF73D9DFFAD8E87
      C68B6190BFA51940102EE443DF1ADA7E38AACCE07C51DC82D9665165367737A4
      F0362385F53E9ACE0AB99B5175FCA60B7C0F2A03E711256AFC9D6EC90EE751CE
      706F6C6A711EE56CDD07BAA4EA24CA917B0F7F127EB7893C7B7D1ED55A79CD3A
      7BC36F36ADC6C513DDFCE64DA6A8C5A0E948BA4EC3CBDF65425CD0CC9DA61BEC
      74DD86973F2F337EB5F16AF67A0DAF1E7E2F4699B83AE2F7DDC6F79BC075F832
      0B46D1F848EEBCD3749D9C7EB76184578071D198E76F645B5DAF69FE9F235124
      017C29780FDD6E13E55767EE581536AECEBBDB6B7C4D1EF8CA6BFAB0BB83A637
      D569D7DF2C4FBA6737BFE96E78531D73CF697C4F9E73FDBDDA19F71A652075C8
      2B2FD70FB8D7C858D509D75FAF9C6ECF6FDEAEB769E6D5A375FAFDDB4984A528
      99F58BC80B98A189A279FDED84A12A9F1096B0D4D3DF4E18EA6FDE6472CAED44
      A1F6628927DE603B49A8BDAA10C51B6CBF8EB517D569F15607DBAF63EDEDB503
      F39D266E510533336845779D2629B00A5FF98A04ADEF0C1ADEA98296DF915065
      32EDDA8DEFB92BEF2990FAAED3F48EA6B1EA9DDABDF3DD2649A624AEFA457DE7
      E845AFE9C5CA21F28BB5F3F3DD26A1B57A7E72C6B5A3EBB5A2A32C24974CB315
      15552FA9E3EBB5A2A0F2ADDA01F65B5150F9A63EC27E2B1A26DFAA1030BFDF8A
      82C917D741DADF7E1B949E50121CBFBFFD42946F2990F6B7DF08FD524968FCC1
      F60BA15FD3E01C6CBF11FAA5F24A484169FBA528DFADDD8AC1F65BA1DFAC9EE1
      60FBA528675C3BC2C1360EF4BF575990DC694D476B1A64AB545A1BA5899F6C91
      505786711A65C66DB2EADABE9C46F171ABE45A1BA69169B593626B6335B2B0B6
      126D6DB44655AB8D745B1BA949FED841D2AD2AE5EE16B5BF9D64441BAE6ADF6E
      BF35FF26055BE1696D8C2652B4CED0E518124BAB83788D34668DC3F320551CAD
      0DD44870D6583E0FA430B4364823ED59930178901A7ED6466AA4466B42811CA9
      8E9DB5B13AADE5041EAB829BB5719AD8D4BAD820D7B48A9955038B773762B766
      A8F1EE4EEEAAC3F8772677AB03DD91D8AD6DCCBF27B9AB8D751F72B73AD6DD89
      DDFA1E1F80DC55AD6AFE7D386839CA1D514AF1053D50B3DDA50552D506BA1707
      2D87B90F4AADEFEE9E48551BEBBE1CB41CE9BE28B56648ED3E080F5DB19776DB
      73D09277966FB7E79D25665607E8B5E79B2546D60668CF2F2B9CB27CBD3DA75C
      C1C0DA28EDB9640DF36A63B4E78E75BE588ED09E2F6EC0B4AAA9BB7767F2551B
      E55E1C510FD3BF9F02501BEAEEE4AB36CCFD396239D6BD1580DA68F7225FB591
      EE4BBE60C0711AA759318AFF32CC44680FA7702A893D1CC54B61AF7FE5763AD5
      2FE1D7DBBEB6FFF2FC197E8DBF6F1864E56BBBFE6539C8C6AF57A6E4211CB75F
      FD127EBDED6B1E197FDB30C4CAD72BCF360C519D90B7EE0C5CF927F8407F1AB8
      AD206DE361FF094320C6B305120BD71D62F4C430900E348C9DD0BF609885FCA5
      63A9171701BCF8F7D81AC6913DCCE0BF3C70803DE5B1DB19C0BFF3655C38C3AB
      281C17F122C8865759B080B702F87A18E48B205ECC02FC902CE7C0A08265910E
      83F06FCBBCC8505E870161A531FE1315C1C2B600CF8749FA77C0BA749E16C2FA
      7D981737B1C8674214BF3FDE32865911032C26E3DCB1002236FC87A00B54E00A
      2CA3C8F801DB8225336055544925A08480BD0DD6C3F1348B427A2D5954464816
      388635CC13715DC0A2F2BF4FD26C1E14F069914569161537B6F5037E85611BB0
      8CDCA98368E4D80428FC77849B76E037FEB913A8D26501C011B1B814B1BD03E0
      460A76202437C26E34A4BF6F82DE05483620E78016C870B4150CEDDDE0370A72
      11A6892D41094BCB61CD174E67234C0716225D9647E1A00F4ABAD7B56622C080
      16CB916076BF3C989DBB801900752B9811908D48FA40C0751570BB3B02D795C0
      F5BE3C70DDBB00D7EDDD0E5CF8FB1707AEA780DBDB11B81E3302D8120C158461
      544497029ECEC53C9A45612812F86599C047B184192B633AD66B06ACF5639005
      5300F4CC7A9B26050D085B2F72C7817FB2F42A1C16D9A4C87F89C262F6CA835F
      163051ECD87DF9312B3F4E62F5F749A13F8DF4A70C3F8D478B00683A7C98F087
      11EC1CD81BFF2C6E16029ECA2F45568058039F465998A99FB1FC39923F33F933
      9CC6FA93FA6E267F5E6E6573B0DBAFC3611E83BF38CE2DE8F0FC19B319EB7330
      8A85C6A54E15979A287F7D27230AA64482AF897B89E6889C8CDFF8331D5FD430
      711DBBBF5774D93A0389552FABBB7D5938EB8665C1D748825697E3EEB61CB7BE
      9CDEF6E5B8BD8DCBC1AFD716E3EDB6184F2D86E483FE9721AE3B63BA7F0BA6FB
      0F4E472B67AA65807E4D8A5A85DE3C4F132558F1290E1A4F7162D7B7B08C87E3
      89BB7272CD8476E5D880AE6578CC6A62D7DE6D62C75D43E1B673BF4DE338BD12
      616D0DB9FB8584CA07C31996BF1F1E6BD6459BDB48E42A3025C13CFC458C8EF4
      59BACD67E9D21E574E14A3C4F1CBBB9EE8F79F3FBCB7CED250936CD76B5C41B4
      8E50D10A12AF4B1CEEFAD5793387B3CEA39C91C7AF218F4610141CAE074E17FE
      75FA9E0B3FDC1EF084E2DAEB767DF8E177FAC0E9AF3BFE001FE9FA0E3ED2F330
      44FFBAEFFA3EBF8D8F001EF668187B30C0871C678062C63568CF2E3EE6783D9F
      9EF3BB9DEE03E3A53CB35BF1D2BE052F5D8597EEFDF0D2577CAAB32B6EFC9809
      3ED342841A479AD9FA6E584A4BF2ABECAAB6B62DCBA93151B799A7AF226D6D09
      CD147E119F9434B69945AF8CBEBAC55BC71FEBF1FBB78B002BCC7FFBAD73D7A6
      3B2FB23499922DEE4F80B17951A0A4F63B7DE4DFC57C1107858842D7EFC24582
      FBC67F258D6848FF2693B1EBE98F89FAFCB7B10DFB961FF142E0A709310BF94B
      5E0420868390CEBF2D82B1907F01515D2485FD3BFF5600B60E5FD8CE7079E20D
      1CCFFA5F08219E6F391F890C8806E5B1E41C4410107645275E176F610FBEFCDB
      58EE0DC9814B77137EA0B1AAF5565A6EE412169BC0473832B5F9EDFB4A37EDC7
      6DD88FE3FBF50DD1173032FEFCC25B6AB321D8B63A2A77B0F9A81CBB616F2E12
      E7EADEE80B98047FEEC1DEB6EC0C4977F3DEFAFD95BDE117B837F8B9FF7BBB65
      67F02FDEF4EADEF02BDC1BFE7CD27BF3BD15F2415FC014F8D322FFCA93DD1BE6
      9ED4F6465FC014F8B3CDA995E47DFFF6D65BA124F405EEADF730944453F7C7DF
      5BD75FA124F4054C813FD5DED0CD66C130F81998F7600037D1B1FFD8C8DA4F30
      EBCEF3FABD9EFB250EFD9F84B9E3C6EF70C64F9FB91391BB3FDAEE3B73BF97E0
      F2B499FBAD820BF1F27F5AE6BE22B8D4D9FB13DEDB16E6FEB40597FB32F73D16
      5CEEC0DC1DD71B785ED7ED347077B70B04B6EFD815B82800DCFBCC9F126F579B
      7EB8237E32BCBDBD2DC2F076C3DB0D6FDFEFBD19DEFEAFC3DB3BAED71BD87EB7
      81B70FBC8EEFBAAEDFFF12876E98BB61EE86B9EF332135CCDD30F7A7B437C3DC
      6B5679DB76FB9EEF3530F70EFCCFE93ABDBE51DC1F602B4F869D5737A4766ED8
      B961E7869D3FC5BD1976FEAFC3CE3B03CFF33A9D7E83AEDE77BC8ED7B73BAED1
      D51FFA8C9F0C7337BABA61EE86B91BE6FE04F666987B95B9FBEEC0EEFBBD7EA3
      AE3E18F4FB1DDB38D90D6F37BCDDF076C3DB0D6FDFE3BD19DE5EE3ED5EDF71DC
      4EA7213CDE715DDB735D808D51DC0D7337CCDD3077C3DC0D73DFDFBD19E65E63
      EEBEE3F83DC769B0CA779C4EB7D3EF74AB69ED467137BCDDF076C3DB0D6F7F8A
      7B33BCFD5F86B7773CDB19F8AEDF6BF0B8777CCF717DBF67A2E30D7337CCDD30
      77C3DC0D73DFE3BD19E65E63EEBED3EFF65DAF299CAEE3F77AFEA0E31AABBC61
      EE86B91BE66E98BB61EE7BBC37C3DC6BCCBD33703B8EED35B9DCBD4EBFDFE9D9
      7DC3DC0D7337CCDD3077C3DC0D73DFE3BD19E65E63EEBDBED7ED74ED4183E6EE
      7BFD8ED3ED7AB661EE86B91BE66E98BB61EE86B9EFEFDE0C73AF32F7AEE30E6C
      77D06DAA25DF71FB9D8E3F700D7337CCDD3077C3DC0D7337CC7D8FF766987B8D
      B9FB7EC7B1FB4E43409D3BE8F55DDBEE57DBC4986079C3DB0D6F37BCDDF0F6A7
      B837C3DBFF75787BC7B5DD9EDD731B1477A73FF03A7DAF6B82E50D7337CCDD30
      77C3DC0D73DFE3BD19E65E63EE5D7FE07B03BBA94F8C6B7B7DDFEE3803C3DD0D
      7737DCDD7077C3DD0D77DFE3BD19EE5EE7EE1DBBDFEBF94D1D5E1DC7C544B88E
      6D4ACB1BEE6EB8BBE1EE86BB1BEEBEC77B33DCBDC6DD7B7ECF75FB7E8361DE71
      FC6E6FD0ED38467537CCDD3077C3DC0D7337CC7D8FF766987B95B9F76C3852DB
      F39BAAD8F8FDAEED0D3AA66F8CE1ED86B71BDE6E78BBE1ED7BBC37C3DB6BBCDD
      F51DE0DD9D46A77BDF7306360C6F1477C3DC0D7337CCDD3077C3DCF7776F86B9
      57997BDF1EF43BBD8EDBD8CD7DE0B91DCFB11B98BB5D42C6DE152CAD20E1C27F
      F6E92A141044B085AC88C7B3E1649C3BD630980024E222E32FEEC3E737EEA93C
      F5073F6CDCA273BF2DDE81F5EF72729ABBDF7397EEFD76790721E03EF87917F1
      0677E9DD7397BB8B030FB4CBC63DD2DD5FD9A57FBF5DDE4130F8D2BB5C15E770
      979DFBED922482DD448447DCA5DC63776D8F2CCDB6DEE51671613F76D96B7B92
      78D737EE7277C1E1F177D9BF1FBEA29CB022D4B610211CBBD771FA8ED7E0D8EF
      0CDC5EBFE7749F80710075992F661E7880AD7C217BC083B9621E4DD27D387BC0
      1714EC9E863D0001F0687BDB177B803AF587B608ECB33DE03E36AA3BB0F87DA2
      24B7DAA8EE6D11D85B2A793776EE759D7EAFE335C4E975FCC1A06F03BF37ECFC
      618FF82179FB93B6D0DD9BB7EFB185EE8BF3F68730D53C41DEFEA5FD4F86B7EF
      2D2531BC7D07DEDEB77B7ED7EE3614BE73FA1DAFDB775CDBE8EA86B91BE66E98
      BB61EEFB40400C7337CCBD05731FB84ECFF53BDDC6CA779D5ECF763BB66B1BEE
      7EEFAD184BBCB1C41B4BBCB1C41B866E18FA1763E81DDBEBF88ED39431DF757B
      A4ADBB869F3FEC191B6DDD68EB465B37DABA61EE86B97F31E63E7060DFBEDFD0
      3D16FEE877E1D45DDF3077C3DC0D7337CCDD30F73D202086B91BE6DE8AB9F79C
      4177D0759A4CF1BEE37ADD9EE799283AC3DD0D7737DCDD70F77D202086BB1BEE
      DE82BB3BB6DDEDF57B5DAFB150BDEDD9FD6EDFE918E5DDB077C3DE0D7B37EC7D
      1F088861EF86BDB762EF8EED763A9D7E237B1F382EB078DFF8DD0D7737DCDD70
      77C3DDF7818018EE6EB87B2BEEEE3B5D77D0E93694B3F51CD775BDAE6398BB61
      EE86B91BE66E98FB3E1010C3DC0D736FC5DC3B5DCFF1075E0373773A9ED703ED
      DE36297086BB1BEE6EB8BBE1EEFB40400C7737DCBD15771FD87D7BD0711ACAD7
      9CB88E37F05CA73F30617586BD1BF66ED8BB61EFFB40400C7B37ECBD0D7B779C
      81677BBEE337B1F74EC7F75DCF58E60D7337CCDD3077C3DCF7818018E66E987B
      2BE6EE6375BA41B721DFFDC471BD4EDFEBF63A86BD1BF66ED8BB61EF86BDEF03
      0131ECDDB0F736ECDD7506BED7B3BD863EB2AEDDB39DAED7F78CE3DD7077C3DD
      0D7737DC7D1F0888E1EE86BBB7E2EEAEDFEFF56DBB21ACEEC403E5BD670F4C8F
      57C3DD0D7737DCDD70F7BD202086BB1BEEDE8ABB776D07AF6393697EE00D06A0
      D97BA69A8DE1EE86BB1BEE6EB8FB3E1010C3DD0D776FC3DD4133F7BBBEEB3470
      77BFEB7903BFD3318679C3DC0D7337CCDD30F77D202086B91BE6DE8AB9F79D5E
      BFE7B80D85E61DA7D31B78BD8161EE86B91BE66E98BB61EEFB40400C7337CCBD
      0D73F7ED41AF8B8D649AF2E11CBF0B8ABBD33721F386BD1BF66ED8BB61EFFB40
      400C7B37ECBD157BEF789D81DBED34A5BB3B1DBFD7779CBE497837ECDDB077C3
      DE0D7BDF0B0262D8BB61EF6DD87BC7EDF67B76D76EC8883B713C40E88E671ABC
      1BEE6EB8BBE1EE86BBEF050131DCDD70F736DCBDDBC33631C0BD9B32E2BA7DB7
      3FE8F40D7737DCDD7077C3DD0D77DF070262B8BBE1EEADB87BDFF13AAEDFB11B
      B87BBFEB76BA9D5ECF58E60D7737DCDD7077C3DDF7818018EE6EB87B4BEEDEF1
      DD5E93651EFEE8DBEEC0F64C351BC3DD0D7737DCDD70F77D202086BB1BEEDE86
      BBF73CBBEBF8DD7E83EEEE767A4EBF3FF04D8B38C3DC0D7337CCDD30F77D2020
      86B91BE6DE8AB9777A54CDC6DBCCDC51AB1FD8B6B1CB1BE66E98BB61EE86B9EF
      050131CCDD30F736CCBDEF74BC9EDBE93730F713CFF16DC7EE0E4C4CDDFDB7F2
      900CBDB20745EA9E0EAADE9BA1EB9D959C7D6FF6F6A5197A7D6708807F09865E
      DD993A75C3D00D43370C7D85A1F7BADD8EDB73DC06537CDF0576DAEF1B3FFB03
      9FB1D1D68DB66EB475A3AD1BE66E98FB1763EE834E67E03B6EB72903AE3BE8FA
      5D6FE01947BBE1EE86BB1BEE6EB8FB3E1010C3DD0D776FC5DD0703B7EBF4EC86
      283A0FD4FA9EDF37A678C3DC0D7337CCDD30F7BD202086B91BE6DE82B9BBF6C0
      B7ED81ED35A5B7F73CB7DB1B74BBA66D8CE1EE86BB1BEE6EB8FB3E1010C3DD0D
      776FC3DD1D6FE0D9AED71446D7EF7ABDC1A06F1BAFBB61EE86B91BE66E98FB3E
      1010C3DC0D736FC5DC7DBFE779CEC0F903FEFE27FA36BD1459168502C688C5EF
      B5AFE45B3DD707A1A0D3E9D6FE384E97B097619CABE6B12B6F39F6C0EEDB838E
      D3DBFC9ABBF9B56ECFEFB96EDF7737BFE569DEB6FA9EEF771CBBDF349BDFB048
      5D8877F36B9D86D7BC0EE5113A83CDAF751B5E7341B6F2BA6E67F35BBDCD6F75
      3CDB19F8AEDF4322B7E9BD7EC36C3A2162F36B8386D7749264C371DB0DEF390E
      088E9EEF3480D269C0936EC7B5DD9EDD6B3870C76D3AF1B2C161C39B5E1362DA
      DD5EBFD7F51A8EC169C095BE63F73A00D426B834E08ADB8133F73A9D7EC36B0D
      B8525ED5A663779AF0A53370E12A7876C36B0DE832183840137DBF01A59D0674
      E93AEEC07607DD86D9DC466CF11DA02B836EC374AED378EC3A2CB8E1CD06C252
      461C35BCD7802EBED7771CB7D369DA601365D12ED086F71A498BEAC9DD74EE6E
      03C6F83E00B5E7380D88E636A04B59CFACE1BD26F2A21B9035BCD7445FEC4ED7
      73FC81D7706D3DBBE9E43BBDBED7ED74ED0694F11A084CA9D136BCD78430B663
      C3B977FA0D74C26B4098818B98DDE93671B0068401A4B6FB40793B4DE7EE3561
      8CEBFAFD5E1FA85AC37B4DDC4897A96D78AF0961DCAEEDA04CDF740E4D08A34B
      EB34BC3768BCF2BA194E03736F203270F97C1B5852D36B4D1CA9EB0F7C6FD004
      4FBF015F0039813675BC8673F71BD0C5B56DB7EFF95EB7E9DCFD068419746CAF
      0377BE69BE0674014513D83BB0C086D79AF891F6FA34BCD7802D2002F63BBD8E
      DB7406FDC6DBEE3BFD6E1FAE6DC38B8DE4C577BAEEA0D36D38BD4E1343EAB85E
      6F60FB4DAF35E0CA608002C8A0EB34BCD6445B4074F4BD9EEDF59B4EBDD3842E
      03E0B540991ADE6AC0151F9874DFEFF59B76D7617D201397C528B67EFF29B948
      D2ABE42FFCED62BAA06FF1C330827FDC6154040B5C823DCCE0BF7C04FF050858
      F584DDF004CF9247210E481F4000B741FAA68F7D9077BA28E6E26F3DD8E9004E
      1F3F030A792E300CFC0CACA3E77B547D733E0F8AD98F19FF7C9B2685E70FE7A3
      ECE255045A9AFC70BE84A9E7F93C88E3B759007ADC3C8CF2C56B317186F3F843
      904DE9D94C7F0AC5E4FF8CE16F5759B07847FA1A99D6E65152BC8FE6F02109B2
      1BF884F8102593F4F761B02C666966BD89E199BC10D9CB9FE04FE9426441015F
      7F86BFC1B789F52699C622236C1F670234C4F9F026736D60D7F3D47186E18DDB
      1BCE32176722D68967B1F919A78B0F2100E01CF3284D10554488D3E3F127E964
      114C05633AFC7295662108C34E57FE713C0BB2BC07CABD53F9FD2A07BA40F3C2
      98C9C0E393BA9EC7B0253A7BFAE858B3A2587CFBCD37F97826E6417E3A8FC659
      9AA793E2749CCEBF492793682CBEC109BF01B2E6D1A779FC07EAE88B00207205
      3A029055FA3C03FE03C73B07C0C70C62F894E94F85FE34A24FD36501B0058C2A
      B25C8C0BB4ED5E45617A352EB278382992D1DF868148C2301D0F0B38E78B3920
      796EF3E7499A01861451320518A6495A08D0AFC3FC269F00CE3800E9F8264D2E
      E7B15DF92BE8D1D330280298399BC0A8A09727050C7819C4117C2F001ECE309F
      A5578B1814FC591A87A8CF03DE4F933413F3E85A8463181DF57DC0FC4B1125F4
      E635CE82AFC107B884801B0E9CC1750CCB4B6F4402BB12D78B7C9615097CBD84
      CDC6F9623C0C133884241F8523F8962C0AB0A525EC1B3696CF02B8E68065FFC0
      BD87D33961327C98D1830EB0DB707A59F90C8F4653B614E35F6ABFCD70690EBD
      801FD0C000EB099270781989AB8B28091DFA948F8358C0688BE9280BB3990842
      F97192A6C5305FC437C5551225024F467F9E1573B82BF902F61027B32208FF06
      BB1A2E731117A3204E86F01F7C01730CE11598600CBF5DD12FF0212BA6D9304E
      E052C3C6050C019FAE32244CC33C0916453A058A16256311C730509C5E4D2211
      C3F50D61F8213CB85826633493057914E851909E64B062455F12710503E6C50D
      FC358739A6597A054B4E275181EB4C10DCC50D401DA928FC1DD69A009D29F2E1
      44E0DA442C2EE1EBF175BE20730A5088104EF00ABF1778A2C1640C170A171D4C
      E8E12560653C9CD11308B702886790C193C5F832205015B0587C6992213CF08B
      CBA0B81E5D0F2FB26491E5892886E300AE23A05B0C60B4106F22B88D8BA0B060
      59858D14E74FC32B40E3C9BC9844315C238B9A13E0E50742B4CC4431CBD2A288
      85338CE2493A0FC641318E93E5A2D3C1FB060BB28678E9424B5D3F20EC89B8B6
      8778F222BB41E5014F5E7E8495E4D7F801C09FCC4426E86D7C050F09ED57349A
      980480E1633840BABF16F19A04FE145FC2DD5A24CB7136C72FD0B886BFB3F90C
      1D378B64162453E44849715D04D6A96454F26517E90DBC0E8BBDD3FB1E7C02EE
      78A7777DF814B79FF9A8FE76A7FDCC23EBF08FA661BA0480D6CBB86DA81E0DD4
      EE206E1BA7FF500B1AB45910E2FCC69180F76440ABE2204A2C89DBC3BFC3A529
      0515C746824DFF8EF0EE03950FF827F01BC0627C03850389BE40501641BC9805
      F82159CE87137A7A982E09E1C99E6B0F81D62DF30228EDAC80691232D32A1909
      060C4A4908A4A2221ECF869331705BA012F0EE24775DA069B02F544869D9FC00
      7B38F1AFF84790891CFA3011F01C88CD293C154C3CA7032C7716557E0947FA97
      CE708C7792DE4B16952192050E0207525BCE48ADC8EFD7D6311C0D27BE3FC4EF
      870094D9F002A408E0A04053412AA9C879286C54243A4B2D0C5EAEAD8A160FDF
      5ABFCC82E2456E0165B6E0C8AEDF84516179A7DE29A81B28283EE4E2B62F26F8
      E3ABC3C37AF5E6F3CBFFF5FC19895499C508FD78A8ECEC82CA4DC0C27D6E0216
      408780753B8860E7DB80F46A399D8004963F2290EE0E1679C5FD3A4C1822B0FD
      7BE2CBF3679F67C2626F1520A09589459A1522B4A23C5F8ADC9A816C6A8D0428
      2808B1F05B0932D622C94555524C2D0CACAC7F65E5320863F3C2D55553D4A9BE
      6CDACDC4B3862F46BD2188507F6C38BA5A4847EB335CF195E1BB2D4E35CE3723
      3CBEFEC5CEB62D357AFEEC509F669A58A0D78E41DF3AB24EAC973F5BE132E3E3
      9E80FC0562B1355A463108C8D35512762FF4FB4A54A81D43558B7C309AADD484
      3B50A44636A6E8F91E53F36D706C49CEEF01BD3DA5E70D806977A39AC0B1FF14
      BD71E5FF6C34FD6B9D6F23590F91801F5BE7F047FA1024A175168B00C994F521
      40EB636E8D83C482EF42AB482DB46059F07AB65C14110C76F823FC2517D67826
      C6175610C7D63C0D973160CD15EAE9D64DBAB4E6A0D2C303A005C0D730C65C8E
      7B151533A259DD7FFBB77F3BDA3BACBA075C2571FE0188F3E78F675698C2C693
      B4004A1D151100E9C6426B18C111ED183748C20BB883FABD16735F59B0482B9A
      D08B38CB5590C3314D0A2B5DC0555D64E2324A97390C8E878A0F1DBC4E931705
      4F1D4C51615D264514CBA3090FF81047E9355C7CFE8C3460656557D6DB349B5B
      410133A4D32C985BA434DF4D0858E1FA0F77F6CAA6AF0F5F7DD19EA6DC6943B7
      CC7B776C3A3F7F43EC5DA3518937E87A88831BEB67B6DB5B67695264696CBD4B
      26A9E5004DCF809AE338F2B6E1D9A967B7AE88FC840F0184AF2CDC3D15A1E42D
      DB4EF3BDA3845F9DBFBA7BCE5F0FCE88FDE1757B433E9803B8A75748212FA310
      2EED48A0AF8929A6C8730BFD7CE841826B786A349E7B6A3C5DA3F1B480DE6774
      1F59E98458047A1E095B4BB66E3421AD09A130355A1605F04829FD14E982452B
      60A5095CE474B251283A0CE23C45C117D877DA203DC1391C91443D12D6321728
      546F37D192C806C735036A6205EB67A989C82AB85C02D72A77F05BB207B52E6F
      E3BA3CEB75BAC4859CC5D1F8E25E02E01DACD6E9EA6ED115FB85F7FB06A09D3D
      F2469F3F534844327E041A563E06112FA6EF722042639418D96F0A8F827E85FE
      748511DBA96A14825C98966A04C8FE7C4109C9486A0C2C9032236461AD873D2F
      8242588797511E11AE6628B81E912A72B561460C6808E9AFC01F8B34835FE81A
      E12374B5F006E4ACB57C2D8EF95428FD6B58ECD687628C27B2E6208C04532044
      0B8C40090D0FD03C205F883168EAA06005713AB58209CA6F888D0A6405907452
      B9C5F5385EE6D12572097A220EF28244126B16E46C37CB04460F85AD6F0FAE40
      CE8C72248E136C50DF9183077051A25894CAFB29701B9852EAEFC7B424391651
      0F542081F7E03049CD0C10A06805BB943160784359C8BA6A01332613D292A081
      A40180816C411CE37A60CD8E6F85C18D342C8AEB459489D6A0016A60FD188092
      9BE4BCB7AAD162AB8503290CEE08019126CA0EC38F6A82535DBD7C73A79353EF
      D32C1AD4612475763DCF4736A1117D438B4B9CE692086E9D86CC39EF5ECC01E6
      0C0C042B6C3ECD2A561C0D7D752CA8740044946907F0557EDC697BA891D2D880
      D50037180887943364E97CE512600C5390B73F60695094BA933511221C05A05C
      A50C3446C9D76C1D51ACF1DFF553B810A0D7681743D363318B920B00E90DF31B
      E434B3741987782C6ACDA3EDD41200276822B9195CCC0FE27A997F48C3DCF0A3
      DB81F7FD722AD0C439C723057803E321ED177D8848C10ECE307A5500DF8A0B42
      E7F1ECC07022E644D15C005516215F5E8BE37C13E0475648D05A20B4E84F889D
      DD8EFDE195754E91A537E7D1F5A9C8E75526142EC7EA8E62C4B68569D4F32859
      1622B70E1DDB82AB91E54748178211609AD5517F35287EFB491977A271273EA0
      B9D3DB73736793A3820D271C15527A2BAED28CB8F72FB085BD3BEB7BEC96E46E
      94400EDE8244F2328E41F44AE3E53C911AEE3C0DC5314A9B11C36191E6AC0C93
      0B3459921F304A90A6E72C5D68CD98C7D93F47C03DA0F5FDBBCF1FDE009B4169
      F7DD6BEBC74CC0ED876FA73381392D4122DDCD6864C922016C0820FBDDA79F7E
      04517224E2BA171A240900E4FC0902681D3C2D60CA103CC3107C9043CF95CD67
      835B792931497A08E11D42C85F34423E3D8835A3D42B4CCB80AFBE8F92427942
      73EB2C60B50A353A508CA616E6E47C03370A841BD6BD405B87AFC74060595999
      EFA1CBED0E88C440F939C8D0EDCFCC96CD77D7AF97F3056F3D5B2614DA01EF04
      C07E63B663B49070141143E49A6209100EE2787A706B46A73C9DB3729B5B78CD
      C62000A79309E2112BEA396BEA04C700AD243748B041BDBF0148CC09CDC89429
      8A7F26A85CEBD003B4AC04F115DEB14994841C0A040AC8AC1AC732294D3D4A39
      27740171307C8AE872384997B0D7D10D285CA090A0D5946871DCC62636BEC0BB
      46A69EFF5CF1287DA0282949CBB51548537409E7912061992CFD084550E516E8
      40C6611FD9D7D3DEF78129242D65CDA7870F70513663C4D5E8E3640277FF35DC
      0AE0BAF919A64283388362CB3840BE9CA1B94906CAA1C6AE03E5904693467043
      77EAE901A50124CB84DD3A055A312284C665105B6C83BB4ADAE8D5CCC0C98CCB
      43CD90D5C36D619A0B42619A4CA2E93293F611C79DF16C521A787AA06CC4AF10
      2845A1C80959570FFF8A9F815321B74A522BC5DF406E06BC9A66E972519AFB43
      110091B944231BFCD1A2BF3EA6ADE2299A747E229798BCAE5573AFB1F1109A4A
      D710A218AE158399C6A48248F32E798314A9ABB996B60E8EDE8C7580B7F04D44
      B98AAC2896193A26409526EA5A897E2D17A52790EECF032B5D5423B2B64EF86E
      62C16CFC32B9CD2F832846AFF9316C78249513A258754F105C6FE94C2C9720A5
      03246D184EBBCB1AF82470FEC442D32F1A6DD3D28D77284EA7A7967F6A9F5E1F
      C30F177F9C9E9E1EB120CB6FC29C6DD4D04292595CFA24CA800611B13D54DED1
      48F9CB8EF0110D1A02B9D43ABE8B8AEF97239CB3545A815823D442EB10A0B07A
      825A629242F891B1456FB906D122370EFDF5A02E048B747AAFC4AE572CD2126E
      E4CA0F2E04C7D30463AA6BA35318289F01BEA78BB793EB941601AC7ABBF60072
      8FC0D8EDBF2F23E97A04E94564090850A4B6E3D438DA69715D90CB9885802BA0
      3B1C77268311C4B53017E676507FA200791092264492D23DB4BB7E758F84BFE7
      1E898DF90F64B2BAB2B02C9572A0628212DA2372BA3332A82C7F6C5DFA06FE77
      329F9F84A1F5532EB26FAD6B0B2B435D7F6BDD3CB486DDC2B037211DC13681E8
      BB04A26F7D6853A47AC744AAB78C5F34E189B74B33E11A8C74988704567BB904
      086572191595502B8EFE00A465611FE828E2EDB18E9C5B091F24A5032DBF1C10
      59C93CE4A74014B949973B45F8AD92C1A809AED1C341566FB412E515B723C8BB
      183CB712648C5B53600E7294E648BFBA0A308B8FC15C06B155CF21C1C03CD2C8
      90B9E13028144E53B21AA5E570EC40A5E83A8C8C1B83C453644BB41055708012
      7711FF593A5628F1826C6E9C409266648DE6F2F4ACBCAE45E819E1F3F6D33691
      4377891CDA7E894C68D16641BEB3E7827C931B92746FC409193F924EAC40A636
      975E330AE64E6436163C24E3DAC93A950797143829534C022A78B077F87167B7
      FFAF6F3FFABF596F7F78F981E266DE7F7C85EA0FF94FFE7936791965C53288AD
      835FD22C0EA902E98105F47E2ED82B844DC552C0DF1B36964418312BE2B80519
      66C331E18FACAB6AC1BF4B21916703F6FDF2E9FD6B89804F0FC0B755AED00132
      67E9E206956355DCD93A245B3AFE7A9545787D8E8EAD831F52942728FAAD1EF1
      57AD3D3089832986DAC368E4C7124F10668D355408432A2023DBDB21121A1DF1
      97B64041F4DE59790408CE766E92A57E8E04D7F9980737D621DCEC8C42534038
      850740A01BC54172F1CF03CBB780278022698945B0E59F92BDB4C9DDDD957B26
      B202E575203759315E82244D5BE5785272EFA69CCC898E1972B0B16CAE12876E
      A4FC9FBC788291460D30F904F7259D639D39C9AE5B8097393A410573A74A7E6E
      948D86A45C11C0F02403FD7F29401B70D014005841AA9756CE5012A8C522A8FE
      81A0A2B2EF23804FE92B0AC2507A8AEA19FE48B3CB4CE947362DBF7CFFD9FAB3
      75FEAF908D7FF6F9D37BD8EBDBC7DEEB241D2F73997DAF31A5B5758B2E9EF471
      8FD95B81AE6F12AD1E19572400ED63EBCF94967BF2D0CE87AF7407DE7A8F8D12
      65EA700B2A8CAC9F7268A39C71098EFF4208744F133E2153D379B4E36596A176
      033F73B4B7019BAB550DDAD720D0072D80A1C15B25CDBB404F814D95CB93E3DC
      92C94C1782CC04B90E79E1608186215612C58D08D2208220FB8C5A18F0BE0FE6
      A3658641101F44B234C209D71943F01D28C7B68E3753215275981954BC1D9C07
      E768EEF94946166312D1015A9CB1FB4EE9C4B20E5EC2FE2C863BC7071A5C245C
      244BD12618AE170F55F93387408149F1A34DCB2041A6A7328C19FD512AD65B85
      5B51E608E629259653E6ABEB08CB360C848230237490227B588DC2AC5F9B638B
      3A9CC9486BB5180CBAE2A011DC709CF29F6FAAA163FC646B4190AA66A969CA28
      51B241D2CC399A3A714C59E529225B091672B9DB1CBFFED76FEA40388C3EB3A8
      B714FE5DFA7A9D0ECC055229C6C492ED3CA2C4BA60B1006E97533066F1A28531
      15E1CBBB49D2F41F420F6F9B8202ED68D35991C5209AD3F921D8C90EF83DD7F8
      0261E3FF6042DFE7F48950A22F2B933E7F5605D6A32BBE49DD4E2BCF4806C133
      9F96A7C5CF0685B48A9B2B703B6865CD2CA0CE5948017CA761503C118CFFD2BC
      F78D8A05AE014731294E078A6B21C4E1291715C39C4D293E624BB7282E8385B7
      CE5B8B26DE9E99401CB75AF4403B920AB5123480B0E22519134C8012020A615C
      E666F8FB77C15CFC00FF0DFF382D77FB510E45DB1E895C8D6AC29D5B452F4A4B
      651D030076E67AC92814C0DC0A9CC274BC241F73C3CD61BC45E1B0BC77E4C3A9
      1444D3E1FB57306E9E6CAF3976759A15131393BB1B56AF85DCFA26E4D644A199
      FA558F1B64D6DDEB20B37FEF0C7CEBC43A789F8E833802ED74112FA75172604D
      B0A32F5989736B94A517D83D79EF0EF75E054E28E84DF7DF412F145B41C63222
      611C65C0E9F2026B33A2553C8763467A5A69F8934E6410D4D38CC868004D408D
      90BE219D033F6C02552C542D8EDBE2D0721D407658EBD702E0C3380E7C0D45DF
      A7D9EE6873ECC6FB20992E3107A1B453C96A41C1152A238032A7480C92692E55
      1440A9D3511E7C733A0A5C8BBC36974FB1065323447EFAFCB66F890474157247
      A5280E32B1092D05092CEB8966CC4910C714713F1768F18CF2399A44D553ACCC
      1516A3148EFBF4C0D400A44C4CCA6A81CB1CD0A205C0E75889770ED734BB6193
      7022C6980193FD33D5FA902E462E1053B95554570169F0425015AF19951F0FA8
      F2529A808E9114D98DAA715D9AE18F65CAC815E685A3F9509780FE6782598279
      2CB00DB8761193182E8417C7C10263C3BE11D70B000D59C36F16D2985F21DA92
      B2B750CCC8D07718CD17FC3227BFE068A1C8C759C47C72044BBB52C9584F90DA
      FF3B16073EB13E11BF645B4CB28C63A95A058B852E3001A2DF4897F6321A5643
      521B3AAB9685D5EB5AF972813035BA165DE7EFB0A475D9194BA731629185538C
      2BD741E4A47761A42C55972DB3F5D124730A88BADA97B81C4B245C5FA4A48CD4
      9DAB344DB608FA5A62A51234EAACD6D7E6F25DF4679A794387647A064F5F5073
      B0F699906B48836B9F8A44645438054017DEA808C4458A4E3D723004C90DB283
      324B309016582C43060028D04A955E60218C0D9BC119E7CBF18C736C50269185
      DA69F52AE194D2FFC65990CF44FB0DBD82A1F368BAF5B9249A442072C34EE654
      7903EBF8608834C7E95013D1C932A38879AC239BA8E2FCAB851CF8C443D86134
      B9619E8A1E66B4121DFC945C001680DA47891E39436E25BAD3D8926F3F276944
      9E239871F1162E6D2E506532E48D4D495729A15B03945611EE2EC6A4CDEED57F
      329352EF9E26A52FEB833EC155227368743FC3BEBF8C03FAC4FA4595F9D3A123
      BAB8680B04AD479610C1443833ABABF67366CE82313A9C8D825591B250E696B3
      098DAA119DA2E78F1AE1E51758EE482EE83B2A4958D63BA59A45B5C27138634E
      53B2B2AB5EBA8B61E051EEC463C739109661F51AC0FC470F7438B1DE81C2839A
      D523EF5BDFADE7CF1E79CFA77CB5EA58AA2B69A25FFA3D761702D5B1143EB1C6
      FAF691032EA42D9250F5C17B158C2FB02E277CF39EB2BF8CE8713B080F74D4DE
      818910AEA62F1DD4C3190F546949AD0DD5F2961A3A9BCEA9215A9484A85A913B
      5C15A85C0814AB410B4896ACFA1CCA20FBF88653564BC799E04E0EC641B626CD
      F4F7DA41261D634125D8797FCE6EEBEA355D3E8C26AA3ECD13B4BFC9986943D6
      88AC7D60B33FD09C88EA7E6B61749928074004CCF9F0AFB2DE3550A950569CA5
      7245D705F59309A30931EA427D4B63E6945D3F15F01B451C12690492C7F3B161
      78B22C9699892DDB16B60CD2CF023D813AD48FEB22BCAE18C601A06F31D19D23
      650D7EEB8893B1021EE59B654192C701376156CEC0C35C08E958C0674A431775
      14DF2EC3537D587D38A148AAB196856AEDF9E87ACDFF1C2FBEBD86FFFDC763EB
      34D8F1E58A724FE42DAF3A70D2AA13EEF481A152B94B4D7041883C3640645EF2
      A3EF75594CFA5F21651D6DC16C6BD0778F9D59C716154D6F0507CA877EA0BBE0
      B81DF7D1955CB577D9892446370CB9D67DE097D3A80046880621F41D60FF35A4
      1576AE2104DB7F4C6A81B4C21E78F603D30AC3D86FC79273519013B8C6A36215
      F783B56CF8010EF0314C9D98FA7A060440494625483052FA3A77C8D0D03C447F
      017CA5D8B4EAF74B70A874D8064D8685812364E3C0A7A2C98D62E4B5E300B981
      AB84E6D6C14F248FD5FEFCED81627FDAB5879660D58AE268970AF7C84AB797EE
      B1B4C90003E67F7AA7BD9BAADEEC319A1B366C44F227344270CE48C0220B1604
      207A1EC2378FCEBD7E1D2F94BCFBDBA38B30D29C2E21C3B61D6E2E154D22810E
      A70B4130FD76FBAD2C6F5E713D70BAF0AFD3F75CF8E1F6FC3EFCF0BA5D1F7EF8
      9DBE0D3F3AFE001FE9FA0E3ED2F35C7CA4EFFA3EBF8D8FC0F5EED130F660800F
      39CEC0C6A71C179EC39F5ECFA7E7FC6EA7FB45AFFB23D4A3A9A2C1EA95697A47
      2453B8C7B3BFA200D4F69D0BD8F3344DFEDA85FF194AABD5A77C21C68CF25CB9
      918496071766F751947DFE8C84D95551F6F00A5F7CECFD23563EFEFEB73795C2
      F695C76C37C222E5E4E3C48649D701C6F1EDC4E42AA8A681CD8DB026136CBA8B
      6A059591B058B90CCAC7222C809945972A334C317D237F6E332CD57B1F1BBAA7
      E9DE5A5BE8AA69538604A3E187038051A6621D97FA8C6B392C576FAB68BBC7EF
      8AB2B691C3EBA3878EA7304D4EDADEB85FB6E7836FCEB8F44CC6650BF0BE9B63
      0B0694CF75F28C090BAE397C288489D3857401360611408D7B38E545CACDD1A2
      4CDBC8CBE8D8973F9CBFC392435851A0105892038359B300684B76A49E97DE6D
      5925413A965845A79ED615716A1E2C16A83C8F4471857E743D188799F232682A
      8E283D426EDF62AB680338B57E5405A764587D8EF4996FD52C08B9DD781CCD23
      DC7D555D0EC663D9107A5E0519ED238CB0463059EE740B69828ADE54200B5972
      0BF3FADFA4019C3297E413ADA5245E78990D9F63B6C40D67F9344DC84A3FB60F
      17B0617A540A5A63CCA5DA3A27255B31B2E87CC638C8719C5427549DEE9D27F8
      AB07230CF63A18E13BBECFFA7E9FA0049E73B5B0CBA005A5A5E06EB282900929
      41CA715C69A08491B9980274CC2DAAB144033D53FA98137836B32E236DC6A370
      FB38B829A3B4F6079D5A109C9F3FBC7C8D1917B0FB22E2DB81195112C4A44B66
      597053DE1A0D746C88042A135A1EE1769D5FDC64D19C885F1C00E8A8C4CC0D81
      4C9D1651685DDDA542A1D46547CB26955BA32436F2CFB7A80C84C5D2821BAE1F
      9772E1FC7DBDDE6DA36D2A99A155145F07A42E24D2289EAFC9C60F24A0AB24DE
      472FB84C1C8D8AC0060A87A2BC4CA97D82870EAADB2607FFED27BF7285248192
      9448B16B948C64E32E8C6821A78338A5A66A1F47710432469B8A89C73AF7C83B
      A60BAE7EA502E7621AE4684BA92F151625E21033521771348EF03ECF83EC82DB
      7EE4985014551B84AD67EBF02A2B54859A861F73300E45940399889721E56EDE
      A8F3AF00D03A5440633B8FEA555783A0B93F4BF2D06D7DAD7AC58E567292557E
      3F1534886FD6EFE2BFBAFEB22AB650BDDE189856ED7EA064AEE56D74FE5B8724
      12634D05E089D6BBA3D35A5BFB4AE40E07563D762CFE78712215AC6FFFA75AF8
      8A2B9E3C2D5FBEDE7AF6E896FDA60DDFDF2AD5EA2E8A88049D7D75673C684F62
      7267ACC4E4505E914C694DD26C4E74673B2F23D97D24CA3A112B9508A3F6D9AB
      AB72332543ADDD69C96D80E761B58E53ED15476D9884D6D5E929C979D5B4518E
      8B460866B59AB9512F4FAA31421E6FE0852C0497DE08825259BF67C7BCE37591
      94F3BEC6DB65F31C031A4641CE1576C87EA00C5CA85511637E91630664A12416
      644FF437F9FBA3FBEFBF2A5FDEA92DAE948D0E91F79EBF393A5E49B8A8819A0F
      0DA5AC69826769D230D62C1FCE66B3FCBE983E6470004803281AECDDF16D5DFF
      0453E29EEEF21769097DFBE92D7FFC0F317EBAAB0FB112D6D3C51DD0699FF4FA
      A70204ACE4E92E3F13E28257EF3DBDD503EF89A3270CFDBF058B204181F5E489
      16AC03F5E24A4C9FF211A02EB19C2EF9109EE61640687BD22434BF12E1535E7F
      B1CC2EF4FAFDA7B7FE6C99E7FA0A3B4F6FFDD8CAAE24A27F797A1B982D936990
      E92378824228687FA368CCCB37A1D66CD82633C4F91B637AB8A7E96173A0DA5E
      9B1E0CEA67DA0FEAD7BCA2BDAEB90FF7BC0FEE9EDF0773155603CF75E1728CB8
      5B72354D8DF7B915692706FB410E896BBCFDE8CB80828FBDAE7A00DDA0E4CE98
      705276316BD121766A89EBB158148A569D1EB5B5A473FCC1D57A6D2F1528B916
      FBB9B182FB31FA9692B23971990E9B83F01F15E319BA810A104493229AAB5218
      3AA45216D8A985EBEF948552AF17411E22F6F4AF3B8B292A758C957639999426
      A418124AF986975B641AA28B86FC343268F45FCA4F5366A462FC484285AF1F1F
      006586E163C34086E59EEE5018E12177CE8EAFFFFB465EF5AF0607EEA2473747
      BAA2650B3BB85478BD63C1155ED5B5C28A22D87D4F5FD61D23A8293FBC4815A1
      5449E0F0CD8184C58175081F0F880868E1E408EF68498F2614AC433EEAED6A27
      3BB175865BAAEAE857EAD7EE107BF290D5314EE26FFFA7DAD463D78A79FEECD4
      FA6586E7CE05C4F302D94735B79F9907D07BA6FD6B0D0FE3B52E29C7554E4401
      42200BCE1774BC53514F43D06FEBFCFFC72FD3839109FF711A25D1D721C07AE7
      916E3873216E08F15564238916DBC7A30C84B54128A610E39839046327C7FC06
      E1E06AC6319A515E3D7A2EA3C189A2CC4631FA3188ADF12C8DC61403F155D276
      37F3D6C788E52A9B9672776E5D12A384A92C412C2341A57833A6F6E05F4EC252
      F1B95B9FACC49FD6326DAA49361BF003E589CD81321412CB3BA3BE08C19C2B71
      588732066C371AF09024F8EBD100EC3F500D9CFC17E44047446A383E6C242698
      FBC672D171897454150688C8AAFD21092B759E1021B1530EA0D80878548B7AC5
      0B2AFD7C6A9DE1A5D3974CCD51CCB274399DDD7EF380E8216D55296D39E334AC
      81D8DF2A30A30A3C57A22AA387832988458F5FAB800957BD0ED00AE9AB55FF3B
      444A81025C251A7B25DD65377D71F3342AD44F92D7699C8E4829AEA89187786C
      8B2C4AB3A8E03F344836471552FCE8BAC2C978D1189CFC2874EA6BECF884CEF2
      2BEE7B73838B5D22B51F944F7D3538EC18A9FD909BFE5A5514D723B51F9F318F
      175FE1A0CBA0ED16741F092E9A4BAFD0708C1DC481458EA21828E9F1D748E320
      7AF1B0306B9954B4A0065959992BB41BF742FEA49A3FD5AD9CD85584D2FC6592
      1248D758B8FEA66AF97C6CB5AA85A5EA8B258DD40CBCEBF65B86D231E74673E5
      DB911609275F838F7DDD40FCAF64DA7C9D05D33419A559F2C5CC9A3B5D34F261
      6E7DB2DAE0C14A4490E96E12AA6E32D792A4529258EA04CD6051821D4C65BFCC
      512A0DEA248E6AE5C49429FCC224892B802A99FD5B1527D5B6FA20BF3EADA537
      EA56C7DF7212E35A16E36E836F504BEA3338E50C67A0FFC67134DE710A4AE55A
      1BBADBB16DC73AFCE9F3DB93FE91F1F492D8F20BBA37F7C218F918BA79698CC4
      8E53D83A595328DDCE1B053FAAA72B13CA81C219A2F5A56BABDAF6B7B6FDDB7A
      9BAC6FAD5FA56F50D2B1D3F3CF9FDEFDF0DDF96FF2A637128EAD73AE50164308
      A87EC01E0AD05F8C1A44D4175C90B3069BA8BF282B5271F6715A94C15CE6EE7F
      A9BB5F4AC83A00A0E1925B87E41A5118736458FA2D37596AC968D3FDD7BAD6EC
      CDA0B88A88EEB5A5EACB704D9AB2568C61ED8FC4DAFDCDAC5DDEFCAD63A0F22C
      F2F96FDC598A4537EBF0ECD399E77EFB72F0B6EFBD7AFBB6B586D062417ABEBB
      909F075DC039398641C19655200D8953F1A9B90A11A09EC2E995761F9357324B
      63EA6F1FC72BF6078E4E9D0717DB6382D997F9029DB1B3008B77664037B8F71C
      56A8D35E7A923865C5CBCDD5353F9E9B02E0B7037BB9080334B4B3B07FFA3D00
      0941199EC2D7A6A6734B20FE32DB5CB2D935259B5B40EFD5723A89AE8569C959
      4901D0F92E99909EB028CFB1E02A1044C1ED86116626E36543C68BB7D7192FCF
      9FFD7BA7EF59271652098C5BA3C6885CF6AF2CEB48BFA956439409310F92E5F6
      7822D49E73409170EFF0A21D607C004C08E4ABE028172E3C8DFC9E2200C57C81
      81A4581E31CDB06D275D8D23EA3789818A39359ACDADE22AD53E94902D8A5CFC
      1A84832798B14C90E9006498B384A9C0A62B401AE6821A4E7060EB3C4DA85957
      C48D58E2202FB85B0A054262D16E59BC3B8F8A65506D82FC84400180E802202E
      C4CD284532A323A3A80B71962EE8B8713BB986D3559A5D3CC99DF660A79A088C
      D21883CB92F2FC274BBCED18D00E98903EC93B0F9BECE38D5707C7F91EAA38FD
      4216B34B010858DBAEAC10F8E48F7650DD352E1CF6374BB3E81F98F512235348
      3109104B0F62DF0210D349AB19A54591CEE7695E70039AA7B8F7810D7B0FE2E2
      CFE365965347BD4B8185E255120ED561AC340CCE0106F1729E60BA0DBAB60121
      46A8BB1BEDE49EDA8963B49336DAC97615DAA82F467D7938F5C5DF7BF5A58752
      7A5E44E30B24D5597A55E3C71C1987043E092EA329499A7B77CC2DF8540F05CD
      4F5C4C7F12075CAC1737394E17DCA2903208410423FD2CCC8229A54D252171F6
      C5D394C77A2874BE0E8A60E39EFFA9763A2835AA16682F319C7AD92C3210BA57
      A29C90B7AE15B2A61A0D277D2E6880F913CB6202BFA25B0C1B0A1BD67B2BD0CB
      2A30A6895B0D17CFA36942C11289CC6414794EFE66E2ACF320C48E426CDA6726
      BCDA11A496D58E457630156ABE242B4226988C835209B75755450FD3A47D8E7D
      E5E04075D3EDC5458291872D82FA4737D88B2898AB5427714D99E08FEC4BC74A
      2A481E4E61FA3F7E87BD3F76020825F211692998A93E763AC324ED751F7FE741
      5EE639B546B99732AD9F1BAF22E8D81728FB91A182796C2D6211E44215FF8FD3
      827A7451117F1557CD299DB2FE00663804F94C481B6494607A490CEBDAD464C7
      10F3365A28F63902066D08B95496401438284173007476BC246B48C4BD6D5A98
      FCF3B41E375B1B0F606D7AF3DED752621B4B490BE8FDF40EF35CE6C612222FB7
      EAD57AA5A4578C072C7B848F96514C01711A6EB2CFA394968271115D526C86CC
      7BAD560338A0370E60E411170190775F46C3D05787D1384D54110CCC208AC504
      35B92CC13EBD2A9D083D42575112A657C728735C46017DAF168504440DFE7151
      E374ADB29E6E1947A62F6D8F0742B82DB08D2FDC4BB96CDD56BDC0C15BAFE85D
      82267406212F8B2B28709BE1DA6239438186E7C4855C2042912D2B0161F43DB5
      023C0CD1659B71E1B7144DF9F0ADE084540E313BA2D15FC363D6A1FAAB7A5ABE
      5C7D9827DC05C4B83ED96619CDE61778D228A7A4390926527E97B2F769BB534B
      17EA5506B4820330A519E784CAB67512DFE4FCD4EF955BBBA2FF5A1446286A71
      7C5670855616D4E1A8C7729A4CE288AA2482129519625A21A6522822802952A0
      447E0697958F09A68723AA2846385AC00D44E03199CBE59339923B92EB83A4D6
      674C91163A1CAAF8B676D75B2CF861C8013EDC5050537B86D538DFF0FB473C1E
      BE598EA4F75CAB8CA4BE2CABD2AD5068C4C73C9A263029EAA11A3501A4C5D2A8
      3C5B90E0BD988A24DC74A98D88C497446AEDC8B26881523A5157FBE788B5457D
      EF154847CBA2481319F852A4D3692C38F79E9A8953F1078A4256CF17691ACBEB
      2F5F428D890298CB5A83C0344751C29131F8F6993A33D2D20EE956F1F1F1BDD4
      7FC73E83876B77EDA83513FF4556B413158C99E39ED385488EADABAD03A0557E
      5CAD2035012D92A2AF052C4DDE69066626488E3A96C25F81DD10A6FCDC616DC3
      DF54B777A406910B94A08C7235932105B79FD0F7B0BE93D73FBE63D6656EFF3A
      4F4777D394831FEBC0AA4AE7B236ACCC9247660DFC50ACBAE288E9D31F261429
      4899C52DD6C36DBDFFC302A0FF0F85F04A66901526B1ABA8252B7247730023C7
      9EE9C6D8742DC6018BCF23802EAD1EE313652B5140DBBA948C0B65DE5ADB03DC
      AA82D31C94FE61AED9F66BF6E6FCBD7115351821385C509B2210B9115C78EF14
      B253619B99C09428EB102EE215B20559D5E654E4B1D542F25545BC99CD46732D
      57CB52CB7091EA93B7E793EA8D6959BA54F7A297B969A49A07D60189C407561E
      A745294353F0094C1D6558F071FEEE750E1C10DDD7FC1A2EEAED9BEBEB6B6C91
      3516A7D69BEB802E2415F2C1BF6289482C8B0FD742F60F9F8B008485928A550B
      17D37418B8975A6EC7B30EF0000ED4C2DBD4743AB46D7CF9ED6B96377C7BD0D5
      3B53FB3F7CFBC6968FBD79FBF6ED9102445094C58930347A27A38DC60B8CEBE0
      86F494AB4D835B98C99949AD43AF038D56F457594013375BAD2F8BC895E58515
      46D388DD2E046E3A06226F3F7CFC0C07978938A2F224B2A373884EA03996BEAB
      4C1D2437E8A66C8F3878095AA96C8426686AA23C33AA59411A229791A4C07AF6
      C40116576E0F6DE646937455840C6B4CAA32E6685366A7512E036412EBE3E86F
      00D477AF8F55F7662EFA5842495E4B86D23170A6FF878E582334B04732F0216C
      3804A1E4221B2ECB4E174D120A5D159873FB5AB96FB934D6555ABAF1F26F1FDD
      77F96E9A008EC04E1EBFF2329D0DE16B505E02A631742D902AC1A58870854A62
      D7C8A4A41D496F77EA89F0A095FF7ECCC5324CD700F8083C6B0580089ACA95AA
      C19389900428B70D01E45315B0B60055D2708C76C8F9E589AC03BC759152E00B
      53BAF044E9AB97465EDC2ABF3092DBAD00FD84B50B4582D92AAF6EACB380F452
      23C3D17DA8C3A65AEC4D4A1DCC9EC60177C6A172D0FC15F998B8B706FD55F2B4
      34C1222B824B358C309A413AA3982B9F7D3AD3EE21AE6581D548B1B8C358969F
      E6FCEFD6FC0436C03A0C4DCC6C1466E6256D7D1B56950946086CB133CB04A881
      31257351B412DCC4C4EA8010A4F86B559A859567423ADB6491A922B8C04FE5BB
      2EB073E06FE16E9EAD6A213EB626D142F551AD9C134398CAEF73012CA449915C
      D9317E92E5BB29868B60D43EF825B7B6E28814BFB797DDAF199A79D5B2119235
      FC9D88E31FCF9F61910406B05413AA321E17D5673C0C641C1A078101E8E10D6B
      02C2100875CB42C87AFD48E655ED517ABB14EC03294D6798BF274F56627A6D97
      C99D0EB17A2B947A50E1BAA7709EFC089E1679018B14DBCE8C6E74CF1898F900
      0366157088788903BE75A0402C03550A81060236365B2B75A6838F0099EEB07E
      5503614D5453454A73F15565B1D7B022824A2B5182A4988792C5FE6AA9982DC0
      E630CA119D7222096349521E1D185B1F79FE4CC10BCB933C76D1D6BF62ACE70B
      A9EB55EF079028508D728AA4C34B8B348ABE543AEFE3CBA81AB1CE612D5F0B50
      04872AA02407562C2743EEB7218CF20BE3D9D9B7C3DF91D80CFF787C01FEAF4C
      E664F726728095F03192F0ADE0FB00E3442728E6902147A3113501908A3E883E
      8D0CDF08CD3A0F4D966FD2D156DB454D846DA6C1DC2C54854BD2DC59D251B63F
      91E103EC459FE3292EC8AD87079997461BF64C906955D7102FA3C2CE7EFC095D
      0148452E8328467625D554E4EE7919F8CFCDE460B2E5829781964636F4990B76
      BBB45CD164A82615EB3854D5CC5CA48D1789612375C2ED2A4405C0A423687137
      28FDFDF572E624F95AB5A9A4215B9B7BD418F2EA7191AF4093462949973987DA
      D76D4C2FB79FD6FBD2B20EDA70181BC34B15F5E375E8946A7A26AEB2A828D05F
      5B6A19E431C8C7190657B0FB97BDD609D5CA6397D23CA2A413AAE9A08BDCC92B
      51B11A72FF44641ABA23CA6E3D14CF2B65758F69B4CF6FCE7D6C17EDC976D13F
      FC5CDD6284BD50B3080D34B40DBABE14697643DC253FA55E693048E79BF3F337
      3CC4D6557CF4CBA27D729EAF60D15EC44B80697E5A5C3F7E73B2126CD6217B46
      B56B4D7988A28422BEAB066E2E8D5C59F791267B128E78A2EB2F72071D8E3450
      27F9C86A2EAE919648E07EFEECEBF4DD40A06B34C50EE9ACA069B9EBB1ABF38A
      7CFEF82610DCFCE36F347EFC8D6ABB1D1B9BA5C5B3C026451C58B43D900E28B1
      76C87D60DF512E0AE95A621B2D7AFD23AA095B3534EF64B5AB11DC3BD5C0F8A2
      A7E79CEE49298CCE3D4B61DC0FC97FDF0A2836F8DE7AABEFD8846AEF70C29538
      F1D85D9C7E22E7416BC2F980D4E40439C70314B6F0EFBF16EFB45D518B8F1310
      F5A220B65EBF3F43E23453D57C25B139A932C3BD4331FF4BA0D8F0F71648C6F7
      F8FFFEFCE92BE119D55EFEF9139F8CAC9DE05B3F7FDA0FECEBB4C4BE33EA0608
      8AF759BC1C299F4123126E1D4E61E97E00A1DB12084A6CC0B0ABAAB5FB2B2FBF
      D772F9499A9C346DE15FDD1AF06EA26C4F15337C45592BD04A2B23149551111D
      FF42BD22BB43B3FE9726149C405108327D12CBE3E745D9673392B197315A906F
      AA9DB358EE2C5FD3CFAB69D00F2FEDC654A43FAF9F6C9B607879F8324464B124
      8732AC9FFAACEA80591C7204AF5D182BDBED10C5C2171FF89CCAA2B52130EB74
      6A2E58696E5B830D5D191DEDAC5BACCBE7D0F85B377E043AFE0463FE820CEBE3
      AABFC9EB1B84747BF9B2E5C7D6C1385DDCA07E787A7A4A987DC066BB681EC570
      2C58CE8BB3C28E4ACB1FD9FBB6A7AE9341505B09DBE7A96BA712F77B0FB4315B
      520F79A96FD22527698B1582C05BDB452945853913B2D6AA2C1085C6BF8F1CED
      3D8DB4664C364C8CC7C9D3448706E97473A913131D3C3AD6FCF0B80CC63C9CD4
      AD32F01499A0E54C64F2AC9D29473CBFDDDE3C9582C97FCCC424BADE491FA7AC
      C14A68A90CA401FA075044171B1F4262094CA6E046BEE4C758F1306CF7EDEAAC
      8562A6AD08F2B038BC885C1C9B8B3D6DBC7E542C5D840F770D91385C8813596C
      E2EB58AB00FE2F0A0A659A89F1C50E81706F6B94411D277330C53EE598F50C92
      4A9E0AFD9D8CEEABD7C93AAC1CCFAFA7BF55CBCAFFFA5FBFB5CF47F86FB8B664
      A192B16D1441A2FCFBD44B3AE4501BCE94585971EB695EA74B9CE02CC64A9D00
      99B3228BFFFC060B18F2A679A7149359ABA921C58956227A3D2F7D1CA7395F0D
      A6DE0CAA8FFFB9432A2CD0564DE40FCE5609F371D9044015F8E726448A1292BF
      83F7138A9C4EAF0CE7633F21D0A900A3CA3F7CA349D2651063755A223D94AAB1
      9349AFC5A2291841A09B27AFD6ACCF75117F93DBB7D5B841499570722FCE3500
      3133A6AC7E8251C178EFCF3E7F7A4F4711F20518E3057861842C4EB927FC9605
      5EEE08CA520CA232A6A7D6EB4AE9F64910E73BDC1D76C550B23B476410EB3FE6
      99E70046A4DD331187DCC903D752A36B4CDC83F1582C0A5DC0623B9B614E7C8C
      3FADEF80D52DD81D7A8881E57971138B23F67D969715E3424CC98B6D0C98924C
      919B2AE7E3E97486ED0A4C566ECD1DCC4029BB622B27159C75767345D2F8A1B8
      469CB6A43C8C61E41C703FC69836AA4BA3120FC32844814907B0CBE1CB44A7D6
      7A07D6CC4830004A4D862CDEAA2C17068DF2E2B832CDF6BBA6628028E16D0769
      EE0D03409536C3DDB15871ACEA0168273A0A66B76EDD5CD806A36D19B7026A6A
      4AFDA780261249CCCDADADDDDA122E6856B3267065979C4354C9DCD185235998
      8C53D49AA3B9E098797C6C9A52C410DE742B8E8A02AF197E53559F17A071ECA0
      C2C27AB04D0CD76C2BB60BEE48A4B1B1CC0C8E82D38ED7CEFCB8349324372C13
      F37E73AB5219804BF871FD0A591A17AE2516499F6681629BD6983C0309DC5B54
      A055C41E0C1C50C51A3D77FB8427FD0E1F85CC162F70550C7D3A14D5F1EA108D
      9F57518285428F741BD99C4B04C952BE52E797E5ED0E47621C6CEFB7F6FC9954
      77F202152A654790679123AD4E9749A1C3B8287949374F25B3EED129C616CF18
      88016D84F275F41844E19394300934B705D6841E470B5481B0A997AAD28399F2
      2CA8B08548EE87D412008D4E6A47E94C5A6B2E557A3B524F9C7EB9B8CB09E04C
      09322EDC855055531232904B506F1F4F9A9152B8F9110AF9D212CE87D37A5528
      DE82D60C8B621ECA5A3C0CA7C054ED4002A89CC6979CCCB5C0603D59FC9992D1
      56C024D1029E2C2F0A477323E341CBD07C51DC6C8A3E5579708B457CC3A6BC83
      B76457227515DFD66B3B38AD88C3B2EC86AE01BE48234CBC095AD0F4E7CFF8E6
      A28B012F2EE8F3381995B903E64D81EB0C249C0D48F68B5CBA32E4A6003232B3
      4D1B074A00C2BDC81968140C1C866CF7A3E045B873950969777C1600ED25A3C4
      6DBBE7921AC185A0921A44204590DF488F07EC8098C34A0CDC319317A1ACBDF0
      A1058C16DB0B2B334650EA2121CA0A26B1C230416CC5EA26532434BC12824189
      27580A04EF005D6E24A62BC8F5B54414F7414414B7B75944717B0FEC39616273
      BEE21F30A2095DF85F944FB052868E0C9E14D2AB78F3B1B46E35425347D9CBBB
      587E4B97517944A4EF2FD9AE675F6993F7DA54787B501CA26E76E984635D958C
      B193F9BE5CA5AE6E19542ADDE5295907914D8591AC8E22AE17AA2644948411C8
      30A85FD5EEAC74AA4454BC11C5B3F68BFA6F39DD4492BA8AAB0047269F2F10B6
      0883C523D2B074CF43B5841D18B1CCFE25AF18C52FB633B22B27B6323447D594
      2343926ED74CA99AF237AF399F98C0F949104BD228640893F6E9D2FDB92EB8D6
      B62C3DFBF3F65CBC4AB94A2214A92C4A8B65A124E001E5B9B07509F7E3AA7A02
      4ADA32D1E63BAC2EA53286E2EA6D97491A57354D68CD15CD3CDE5C8D2D0605A9
      EB999BB07E13A48F1D4B6371687AAA24C68A692191C6AD9D582017DE400E7853
      7180BA32C2A84DB84F3D92696322DDB1AAA394488F383E777056DFC1E9E9E941
      79EB54C18E0A05A03603C8746808F2497EA864C26ED0A0548D5959AE895C973C
      E98A3803D3E452C191B954CAE956ADEBAD23456033586117758D1688BDBD825C
      52A71F688748DB773052F12F58C4044F92B4A6384DA9588D4C9CD40591B9845C
      616143A3C2F274E91B65813894FAF39F110794BDE3485602DA408E65D14709B5
      CB35DA1BDC7ECEC715A30335A441DF7D401163A85CAF1E762B1D561745AE152E
      AED61C667CD0B8468841D8C94AB90AB75A933C638923D5EA6C6C2FC2CA29D168
      09DBD4960B055929F3AA6AF3B428CAE9A66BAD044C76A9979593E4C032037024
      744F6BD2F1ABC87B6ABD244301EA9751368F5AC028D9FAC4B4E608D7885FBF35
      AAD28E52A39560BC82C8FA39BC335FCF5DFD54F8E00AF40C13D4246E15AFB878
      1619752256056B77073966796BC4EE1AD20F6C91AA467691DBBA469ADE25B9C8
      8A53ADAECA07B139399558D81E7CF6FC59C62EEA558A0744F88C5B9DFFB4B0BE
      519F5F93967DF6E96C655154BF5646E054473A9F4593E2CFBC4C55E63A282AA1
      BF8ABF117F253B997C18FBA627BA5D863601D2D4D1A469182C74BD1A11843144
      9FCED47A65E8995EE5C3F0D0A9F59AC6DDC567598DA5A66DD5E313A4F1732E5D
      FE3A7EBA52E74E92F5F8A65E76800310A84C7E058639CF72CC25BDAF22E90328
      61584939E49CC1AB809AC7CAF249ED1DA00175E4A461990B978542A83DAFE99F
      BD9E34D8DDEBFED93A8AE984DA4628BA84D58F272D2E5059243F5503A9181989
      5C3A225793598E90B90CE24833EDFDC197EDDA0D87709F581F5725329572212F
      48CD81F70437FAFCD979BACCC602316355FC5CDD2BEB40E88861AF99F6686A3D
      8A0A7FCBF2DA8C00D285C51D8F2AA85769BCF079BBE7980E83CC8700577C4B06
      43C3DAE4F2D55257F9F4133A0A80DB88A17582ECA50A799D63735CBF6418DE92
      3CD53BC6B5B2ADF71F79BF185023B1A2C22DAB1C71B4DDF2FFFC595993BFC448
      991E952BF45943964A2A02551057B5051596562275E945CE57F8F64E09D32B40
      77774A637537ED1B94EDAD5CD0F1FDBBB3417AB92D1F8CE2CB8638241A661FD8
      E1F3672FB94AC3C96A61847A01621DE835C750990C4D1F40C31EE2AA3DE0A9B7
      282F67BDC25C39D82D5260345789F1B296BE74A5030028309D3A4105FC1648E4
      C98D0ECE47BADBA68904390569522528C86B291B3504E598F2A28ED6279B2837
      D6C69154A5DF86813ECFAAC6C55CC588F050BA6F4494D0085C33C668CB5A5B26
      395F0937DCEA8C542E32824923EC9C9B962B5591DA97901A38BAE188ED76850F
      131E4BCB10F374B94324F72B894FF5C0A011076E6285EB42E3CD34C2722A0165
      BAAC527C65CE238B1BC682F06D4077A9C88CBEB34EE77B7BADEF3C7FF663CDFA
      FB035A8A499DBDE468A879352756A81A99A290DE80B958B5FBE8E883CADFE420
      8758543C2F837F8F9EA02CF6FC19C1E9AC16C0973271944293DC2D7A8F30D588
      0227081ACA461D478B514A1D4FB5559EC4B8110796561B1EFD40C5E6C2E8515B
      F5EE33CDAD5BE1A5936BDD144E696DC79B9C0CCA4C5EC9155C733434D9342B1D
      972315C8790A6F4ED93738619748455EAE7816766C1940DBCCD52D2C17802EBD
      D55886831527CBA84540673D31100F7B4AB9B4CABB90882B0C9B23FB9C9E9D8C
      5CF50604946C5D4F03352E87CD205FC114E378E71BBD0A16BA7D2B8500493925
      1A4A6656652A1EC94642958E107AB05DFCF3B9946FD0ED2AAB6A287F634051B6
      A5FD5ADF0599DFDA7E9AEDD5ED54EE3E9738E6629FF9388B46A5969E2688F698
      70D7DEC1F2118384D7A02CD322644AD24600F33351AE6D97F56E7EBBA4D5CBE8
      09B26E6D5E8AECD534129C92816E9626AB3F2D43A715092CD59AD7BABCA1A967
      BBAD3632146B9B8343A6839858A1152124E7C4A1202F833C904894C401BD7818
      EB661D50BA4B43F4CD4A9B997AE4C7A429E066973225B2E30F77D36E0E2C9676
      44BC6679BDD8406941552229918ABAC4B5DD2C4DBEB6BCCCC2572947F5587C73
      1F6F0723B95ECD85BCDF8564FF7505E91EF54ED6222CCA6BA838AD8E8F4A540D
      A152E5603164BB49B126A7B02D9E6201BE62BAED53B96054CE54455F98BBB5F3
      DDE272B014B901F7E7AB5DB16AD8E11A075C3507DC6200D83A155908AA298730
      988830EC045342298025D385A4AAF189F0A71D6D01BCAE4DB443C353EFA59228
      A376D3B0085C7F55BDD91E97BBE3B2C7B334A589D95A524BE1E1CE83ECA9C5F5
      B53283530091EE3EA8E38754BDA46A7EBC292EB0E58460E1580F69BE400C3997
      077D60E8DE864A3C0DB0E2503FEA26755206F6C7D8D58A7A97FE7AFD9B0A88B9
      BD2C4FE7D43A93717B9C3C1372AE404103923A4CBE752B9F63E076C6C3BBBB15
      C16A5E2709F69CE4063397616C2B3D5B37661D709AC11A64AAF4BEC1DA78AC53
      DB6B3A879A947C910805FC2957702943EC77DC38977195A1E2EB1B8EA3794474
      72BB7455C6716ED83335012B24712A8DAA9751B081D3DD02D238BA10D2036C88
      D8ED07F249F7F8E13AA1BFAAD66EBF95A273895386B895AE6BAE84B70948E5DD
      3DD439A7B7496BB58494A3367D3C561B34ED9086F3AEE09216E915973F504E38
      A2C4D8ED77FD5A82E8224EAD77385FB1CC12727673636E3480E6BAED93366FC0
      FAC22C984E156962D2AB9B24C90C176B8C798CD22C42C1C6F44D5E0BA9CA609E
      1AED52E22CCBA954BA80AA2496150817590A009FE7AD327194895C1DD90E99C9
      C8DF1809CA7688B761C36AE036C151AAA9B2BB229590B805AFA8E84EA5689B8A
      76C49673447674DD48856E525655C9D9E823AD367224E155550036B4721BAD54
      0285FC89BDE6B186C976039E2932C5D487CB17A9D019ACFEA2FA783F76A36AAE
      0B20CFF161BB62B40A5C4BD97B8424A026DDD1BAB82B9E5C5C6B92F4BD2C6BC9
      C9341468F13296E934BAD28E2C20C5C215EAF42AFD3BA754CC68529BBBE281A7
      85B5379E274A931F07B95452ABF5797874553B8FBB0860750FCE474237FA761F
      7C759D41265728194A94E916F61C546B88DB167E468586B984888C9C30348B68
      1666D88DD3F99CF30212326D81684235B3CB7A5BD296320B244F2FABB1C83014
      4C63A855A922E43FAC54D9960F4654E045CC1729ECFBA6AC547915B03B719980
      8A24EF31C6886355EA902B39719C946CDA7604CA5F9B4076593C4D096B987681
      598A02B43E106D82C54235CBD057E8914935A1E66B02E739C0FBF11BBE93BD8C
      828602729D2727A9EA4575A83FFD955B9B726AFAB1A5BF0FE3717E6C9D9DE547
      B53068EC82C421AE1B203D243C7B64383F7FB60AE96F036C19753CC28687C763
      F877F1D8EDA34AC8EB5A6DB530C13A2C5B9CE54670731437E5E7CE036C853E8E
      97A1288F70C5766B58C8EDF10E40C06ABA9AE123847AB5C2DE9B745A52AAA942
      7850080E24889293451C8C398835E58EB8EFB0FE28F61291789ACB4CB8A363EB
      2D5C9542B63EA6048B48C4A1ACE587850D78D0722CAEAB4565998B191E9DD8A5
      BAF979C5FAB869A13C3B8BF731263A5A61068A2AA591E365A3BA8C8B948AC3C2
      2D93C94F87820C8B240CF3C6AA9D6966CB2956F33DD42A37A5547085C7609A44
      0500E4084D9361A5DEA7B9B00D1796EB98ABB85F84B6B9ABDAC0B7013AC0EEA9
      3C089AD5375DE77A31973469D790265117F54852002C0C9E5BDCCB04E4BA882B
      1D904C30CA4470216B7A7129E39C530FDEB2C9280070A8D5A0A1D15C812D6A0F
      56AE95A50C0DEE4BCF1D1259A4A1AC8CA33EA2EAFBAA9AD30CB0AA45733C8BC4
      2E21FA070CF9957AB967AAE0F37B506AB2FCA06AEBE6CE41E847DCFC6A8BADE9
      6ABCDC88896A5587F52AD1BF8E0BB5085C43FE9B9A40FEF15D88EC6A1CC49FD3
      0F24EAFF0210576F1C5BE5DBF87DF5771E6DA74827AFBE558A0321C74154A07D
      BB6A58566A28C57287CAA8B63E8075A8CDCA1C3D8C72F551C5488DB2709B8A6A
      B990F6FF9AD9BFA856B9D6631E5BB2DB03A9C724C9AFAC82FA45A968845A4551
      99C82995DA824BBEB2BD08B132AA574EC3B0663ED6EA1B4098408117BA784492
      86B510EE7A3195EAF42C3A71D616F6FDB891DA720BCAB2BD75046896BC1242C0
      4A30F795006C7F512845A44C32AF5BFECBC2E6EA012E6D2D01422561B3A0342D
      EA1B5D01CD224BB1E1C6A9254EA7A76C2AAC14F3960F51C8692C8284AADC7346
      568AC5B0F155B451A0839DF08C963FD11793EA41735F0D79FE825C0EB26C580B
      286E0F8E95E6495ADF0EF44756150E2A5825F1E9B8C9B18CCF1C4C30673F8EFE
      818EB1C380D3BB3591E2D30B6E8E54B56F5853AE8D42F2B41577D628A6CADAA5
      18F60434A4C4495DB48C41879D16AA8777155416AD528FCA5E8AEA42C0204051
      8B5675E952944896E3629961357059CCFF901CEAB26302BABD2A65E302696BBA
      D215EDE4E23231074E91AFDED28071876A982E1394DD8B3425818A4A252F91EC
      2BDFBDF5B92CED8F396BCB9CAAF10516E82ABA87A40CF7D46D0B371D9CB8A69C
      485656A8FA2019D5AA674F8D994E7543E67681110755F181AEC999BC260738A8
      B8C604783C9C4A01D703549B2CE61D7468EF05F0F3033EC083FF7789E2E47995
      17B203964964CD55A0425D76E22907AF6EAC57412E3ED1111EC89A7E64FB18A5
      D70A69A47358A5F054623FD87BC32D7BD87D8C65A9F513877FB5480FE494F716
      4CF9CDFBF778F8D8A96282646FACC66ADF70505EE4959D94A5148FAD3F1F5B27
      0CE03F5917E2265FED1F21DD2170361C2BFC328E0F8EF56F3F00C952E7F32EB9
      44595C870F1EECE27AC7861C5C90BA24199A114AB220A59A8FB21CB04A3050B7
      5B9509AED00829C5709D025502588621C254785F64C26750AD13A94F5A677352
      CA2D3D28D38172A14757F3AE646492CFA64C6E58D49C4446E768F22383B42C83
      4238590D406B940FA97857A38FF52D512974B7F71FCA058AC5CAB53A1224F4A1
      B95E0D18C4BB64FF4806A3ABF460FCC4328A4362A86B07A8DBE0A01B40371A62
      5B01AD7987D01255172BE7A2BF2185C11DE8690FC84DAB5A9901BDBD418F8376
      F1025F0370CD60212D003E17659EA88A16A9B61F61F9B7EAAF90614C79CA220B
      47EE003A8D2F80BB212B45C068B35ECCB12C7012330AE5012285D2889C332876
      6D82F39139C4A603D0D842A744E135987D5939BE0AA3D6437CB34CCAE1141B2B
      77BACCB177C2414B43424551DB39A2E82CCDC8F93A15890CC8E110D24D5B959D
      2C73BA0314463F41EB50B14C2AE5A125160135A0B6B0D4B289AB2F7390656061
      4B34BC53A0054C335203303C4CE78DE29F399E0A1680BC3EE78B777EFEC6D0F8
      76BE900329E861B7F1FC8002ECA8F1F8F75492DAC4534E5415158EDDA3BE60AD
      0C39B23532CB6F40EFD02B400DCCAB00AF08550AE4A7D62BC1B505A53E43B460
      9E92EBFDC3CBF3CF40B9479A0E68277E459992E1DD342EF9275EE085C2DE8FD5
      0250A8151D4B6D8344A618BDFC148287D561D265A6B3D69609E8272C041EE205
      259283F2BD605D0C2B68C146126A1E738437B04D84D1D62716225DA82CF530D5
      2D360398572C946E06EBA9501422DF68DA41CAC0113C94FA425941B51881ADB3
      331B2F85D01B1DAFA3343E341EC87814A58802F8AAC7AB2ABE33DD946DF2E058
      31059F1F8B38534656923C78097FE301F2DBCBF85712A95A60E35AAED5A67511
      9289D5A5510DA87C595AB844A51B9E54BF720285D68F74B576355062FD7D09A8
      A27A80EBDD922EDA6EBFED55C8B416DEA25B1EAA522FD5CB471D458EE549CF97
      DB13940AAD8F7CB9C8C0CAD5B93DE084B7423BC10D3C76E4439494DDE7E0BC5B
      0101F6F6705137EFFE130EE317200EEFE6AF5338E2470FBB39B57EC47449C1A6
      08C66A20553AFA4A76DE13326C9204A250752D48A86981365384A97581B87585
      23D05F322CBB08DB3282CC163D688E5D50C9139A4BF24A56E03CCDB8E9297952
      A4D54B922493FBCB185CE537A413200A6EEFBB9ACBE00F59DCA19E718B3A407B
      27DB399C52C901363AD3AA8F5887C492B020FCBA2E7874A0191677B353FC84D2
      C31005DAB78359E54D1B57567B062D8B9F240B25D331D9EEE41F6F5BDAD6B5EC
      BA76ACEA1A5B5EC5FD268D6232B302581DC06F521A789174D1779430C8F16724
      2248B1927ACA945C1F1673A9A30FA4CD3511427AA746A5148654917280416E44
      F307E7085744398E83BE8C4885E5241C69CF3B92DFC61808476DB1A9576148F9
      7C86246E3141A8E2F46CCA97CAC5F678752CFC8B6159268DAE96235C83620548
      2A797825EF7727AF00E95FDABDC39EBD37E71F8EE19FF7CCBADEA7E380DC79B2
      162D0A066C0EE710B658D4DD76B7945630F765F349FC4806CA4F6262FDFAE3FB
      FFFEF4AD4DFF73FCDF90E828E767D90A60F83B5A50877F9C8A6B612E0ADB4734
      040F65D70305C32365A50E364012F1B50A4D5D49B69274C0A114959E2EB25D2B
      90375867384E435597BEC277DAFBE6EA4DAFABB6D8220B6433B14F4AB30DB159
      FCAA499DAE70DD486C2E5A4302983AB0D33050A518A584602E928EEB1CFEBEF5
      41796536C1B374BC2AD98B22343963A0562841BA6C23E622097985CAB7299CC8
      885B6D7AAECA7CE8335DF8394D36B16183E2D502DBCDF531647F1D82AA320326
      1C8CCF3648ACF8C49D47D4773A484146CEA1FDB1955E254FECD452D9A8B0B2FA
      F493148D6DC88398C9C8193D38425E83B91EB783F9D79F4576F39BB52170C898
      61265B92CEEB08A82D8BBAF3DC63673AFE1D0F11B58FB13AC2C74F763C919144
      9522F1BAB85B5A962F3E5E0946D3E991D4260A5FB1A665FFF1CD21DBE3321E9B
      A2C5A4E0792C8D27C7E43A797CF33FA6437DF59380735041D514DBC8112EEB30
      6753A16E7E9B57CA32A1633F5E4E6125A7C57521A338DA442ED7EA4AD55A5854
      E2C70E654C6F34B1CE3E7F7A8F7AC84CC461BDDCC09121DEB7829AA9F6AF581E
      ED378E1D3534FB29D26C72807C3D5A5DD6A403220A3F62A18BFC57AE301262ED
      27939E1AB277698ABE1AF0DF620DE4F659AB512783BE75C6C55AAFDD24BE9111
      B53F25DC6A977E7BCD21CDA54940A6EA1C48D3FF814EBF2963010ECA0249B819
      1574DD34F7E957F0A5128E2084BE1A9E6CE0251423C01CF9D8FAE9F5A763E55F
      79F7F9C30140EDEF4B8AC6DE1E8E83E69905DB8F3C8AC6CC57850359D9428738
      30D662641BA63271B01BA3C32462C7C6C1AB8FE7E7DFBCFFF8F1B30EA987E561
      44652DB2BEB51D8A092D7B94389CBE5E53719925A8014DAC837354CC1103254E
      A14B4C243A4483129941412A8B3C6AA316C04D15A219A7D3048DCA479CA92940
      BDDA1E42F8CE4297BB853E77EBDD8BB9456E7719FD8FAB5081312A871BC4A30C
      017354A62D183EDB50FA3D0BA62F9217AF31FF1C8EEC6A96D60CA5A65CC1866C
      850D150A544CED6A5874A331A106688CF1AA96059CB1B7E7B02A6DB2C30588D5
      91AAADAC2C1109E593A5DBD3EA668FDB62F1295E871F824B6B8E21E25125BAC3
      E03DE1FD5B101B3EBF39EF7C737EFE862B697CF48F31BE3D20B94A8453D55A09
      3F6256FE0553FD84355A15AE0FFC13A414D557271354AA5285EE113BD6634A5E
      52AD7B8979BC146999C8A33AC6321D891CAF9C1A8BF9526C7828AECB28547C66
      4E1D90A2090952C5A975F849C58C038B6B950B58E783ACFC23A3C474A0C9E4F4
      C87AC9CAE7D97F928F96AE74308A281C3D9F2D27A037A3449AA54B95BC54ED7D
      BB52A972654772BB57B23F3380179362314A8263BAAA21A1B5D7731574CB39BB
      C08627C0E3299C3D4A309F92A323930A03FFE1E5CF1F987953AC85523D5AC068
      7BC5212B04D11613C3A7E861A340B57039AEA45170BA3B881713AC9E02AB9189
      ACC8F6DB47D36E46DA3195728D72CE24C0C4B5682C212E512F57D41C93F84265
      34C627019DC6291C18C86305B7B6551EC3CA130CC3D6ABFCB49E90503A442429
      E2083E0A3C0632C48E799D58B37586B9BA9BEADAEC1091BC39E387CDE954E403
      A0F3B97E650996843E87A3B49895F1D1C5EA73703F28E5157E56C846E52498B0
      1CE1947F5BCE1765E4B9CE4897CF55C27D8F2D24A35CEE9A762DEBE518F677FB
      49FF88E92E0126D02F0BAA4624ED0C747CD9F600BD8571A82A1E21A36C84B20A
      E25D95DA9E2EAF11493A23DB6CE01B58B4B04C53A5D338AE7C8919093CDEE8A6
      ECFC8C0FFFFA5FBFE9047A90E5092818699F90B9586513C883941507D4B8BA3B
      879CAF1605215BF6D25DC2A73EFE272AC9C56A1262BE6B04D2769A95700F3E98
      674125BAC225950452652313B5608DAEC7B7EC0AE1AC77CF1929BABC2417B040
      113D4A9626F4B94590AA2C855EA418BD6B6E7CB5F67D153265BC2D5E3EB8F621
      DEF86A8546EB7B90AFDEE42A7C497E49FD78DEBD863F4E3187F4F34C87FB62F1
      2B940E8FE0E615C50E22C6BB4A4E51067A8D4ED58A034A5E8C49E324D9321867
      C0E731DABAD64DDBDC86A6DB403162D80CAD08AC050589539AACB91BFA6EBCB4
      0E2AE0214BA5EE062B93B998A6CB5AA6B5BA1A240A2BA609687F451565AE524E
      8A4CC93E491610BC2BD296BD936C0B3A15688314098BD6775E000E4E7AC7C107
      81251AA996035CC216BB45DBFBA9F56E4209351C70BEBADAAAEB013814A83E9C
      60A861245B6796F9D62BCB20FBBE2C52C46589336D3FAA62A22E41C1E12B7211
      8A39563BDF728D242544B8B0B08D0FB74FDB56BD386BFB92B9D3C073DBA4B3C6
      41C6798AB2014495B89ECA5660D5CA1E40C6AAABD660E68A00EA706FBDB125CD
      0EF28B5CD653480468D9ABF0207B44E51C39AC68AE4375D830A04A155526DB99
      68132A501647C0264595852997D50292BC728D0D61008B61AA7F5C41B24AAF26
      F28BC0AE4E012D483BD3CDB00FFF6ABD2176710E8C02FB92FC241BAE0549E529
      BABAA07AFBDF89F1054602168CE6A1EA1CA9A001CC6CB7A859804024C5E70A78
      740046753B7442A298A514C1BB8E40943E4ABAB7AC3EDEAA52B26A9A1D375C11
      821BE6444732D01EA3F9D593AAC79CDC85449C84A2ECA71C69CC7EBFB0B63E95
      131D693FDFE1CA3E3315E8001285B4AE20FB2E29E68CE950297EF04238FF362C
      DBD0DC0553E9602841275F234124D2EC42DA67EB04F30EF487CD1638DD7CCEA5
      FF68CA350299CB8A3D7812D2C4C595E365B88F22633B142A79AF0D0FAB026155
      DAAA1C00896398AEC402D8D609364B682D6A84881298B090086BE9174142E5C5
      24635A810D57BEAB756EAFB35A7E15B3A45840D55AA10C036E5F35190BC300CB
      D54C1364E097742AF0E1157B41038BE059FC88CB7BF9EA949F99C2555341C7F8
      148E7085BBA2CA2653F4506295160CC8A9BE8DA9D7D8197EFBD276DD8AE42F75
      6056D11B490711890A61E0969F2F25E3076E8CC11D1223A9C50250B76FE523AF
      715CDEC6B1044F1D30BBDBF644904758C6B162E29B22AFC8D2E57456BBB940D5
      2AF35B879C5EA773F26FB9E95C97AB058D951441125A75B62B90523E64419DFC
      4E463727BAC80491662E9BCD0D635F1EEBCCD1D5EF15EB2EBF5FC1B15FD0CC4E
      4D2A64282EA2F82AD1D2C85A3B1AA2FE32C150B661CC98CC53D70B22B95558A2
      5D15266FA1756CA7113BE3C2ED621155B7C384CC6A79B86586A51550465860AC
      0316B8CB58C8500C04FF72281B70C025A4139238BD4A5E8F64A266B5061D25F9
      2F14D1D2155471D8DD7813C64694F5D361ECC932C6B3C62E3C44E5B2B20C2AB1
      D3DA5CAD8A96D21844EB8179A9CEB735D048F55E3B9F2AA9B2854AC057A22A82
      E145C1E9FDE95420C53DC53420423CC5F8574627C86BB8E7EC61AB8253F23FF6
      B251D14C397419425687B175F821D04504D8BC460726E56BC90968CA07A9BDC2
      6E3C09471D625AA59DB9A8C04F0A90652EB014BAA557313C357196B7C35B49F7
      701B301C49D766AB94AE29657A63CCE0FA1B0833556455432CC857A055290184
      1606B841C008044B2578B7DA922F355DB03ABE1667A9BF8E40AA80B53B448E74
      A345CF59198B752CC9AE4E46CC97113BCF55A26FCED6FF9ACE66C952C598E08F
      F369B255EA615AD9C4F5192BE2ED87F18A7C2AE4B6C7560AD6F7225E1C5B3F88
      EB650EA20520D07751F1FD72748C91A028561D2387010E9F097484045361C254
      F8762A403615305F718E697D08CBF95E4549985EA9335081D3BF0FB1762E9684
      22D00EA964B284AFB5BABB957DB50C94A5F5C366EABBA2CD4E3C6BF862D41BC2
      95FC63C3D94EA213AF8B07D073773864D8D9DFC6B42BC0F1E21ADF6D71EC71EE
      F4379E3DBEBF0FA78F97C63A0135975A82CCF037A461B52AA3FB739A2D9059DF
      7FD815FA97CADFF1CA979B032D868E455AD7B09A13692C5369A21495B678BA8A
      65B64CC8EA1EE44F12364C100130A49F91EC8CA2EE2492FA5C8CF13905702DE0
      02E9823AD654144805B632FC24A3286A00515EE98AF98420221983C4143EEF16
      6054AFE522BB4415E39308E213D20DC654B49F8C7724E5F3905C881E355D0959
      ACE164BDC1DC308C4A8D08A05860F80982F0F933C5514FAC37F19C6204B2973F
      BDC86B9CB64253ACFFC67A955208E41ABFA0782C0B2ABA99E7B2815719289F26
      D394DA1A2DB164650D37154E1A41E9F6336267832C6A0F27C264C0083F95ECB0
      ABEDAE352479B5440F55A34BB50BD8E8F75A81764B770DDB1F74806C696A3878
      4D25B9CA092549677B9FAA73D4DE96890609F932DDC5CB208A396636B046589D
      138396B04386B2BC73E0155574A505C9F9657C532AD335CD8DBC1DEE8A366662
      1E1128ABB03617530640D4105007FD614D7E58704C1A09A2A00226E3E02EB88F
      6F4BCCA5EEC711350D97264D9A55FAB5F4FDFBF5FA3776369405878BF25A5095
      5A4907A82FCC6EED5430518BAC05195EA50CCBEFA599AE5DB6D26744766C2997
      1A55822716318600932D584267BBA111275481C23033B90FE0FD527E4643A9C8
      E641C2B2F0EA025AEF55966255F90D4A16283BCA5778FCA9F596F93ED3A8BCE2
      56BF945DC2A29C727BCAB50B504475FC3991050A59941287F6D9828C4F4110E8
      EC5C2651716388D6EDE776C6D953B04FB80CA82119FB4919C65805CEF6BB46D0
      B30ED92346B7E8320A56AA866FC8993BAA9868D01B360388EDE063C55AA3BCCE
      5CD56707F613CD977379A8704D66412C437564DA84FC53AD1484EC28D47E6225
      56E8DE3F32C9C9D88BD6ED4583BDB6173D7F76AE10E384106A2C114A958A8F58
      81BB057DB65F0F855F75922319A036DBE8768AE43EE75E58147B213B30904BB5
      747CB16F7DEF10AE4D1A61446DC4A499A2888A58A7B21E564B6C1D7160C9FAED
      55019A7319340AB83726799F120B999703BE8DA8D64130C74E484179B4AA0501
      4D9847FF106B351AB69FA83E34997428CDC6146D84433ED973F98C049B0F46D3
      D042832BDF50CE424182226DB8992351FDD2CAA89B3802B8C740FA93DA09D034
      4C4175044F6D06AE9A43818695CC8C27045984EBF91C43794E30B663847983D2
      06A9414E89897C2F003AAD420DBEE801BD5301AC05B6345113556E11F52D15B2
      C6123006414A75654165623C2918ABAF2E54DFCEE6DB8F28B1C85212A653AE7D
      91CFB2657261E5E983841AE8EEA36A61089F4AA39ADBB6F510386C24F306270E
      1E40929639C0FF7F7BEFDFDC3692A409FFEF087F079CE2E2B5B423CB240882A4
      E776376449EEF6B5647B2D75F7DCDBDD7151000A124624C10148C99ADDF9EEF7
      6466150052A408CA6EB7304BCFB42D91F851959595BF2AF349DA1D7A3499422D
      A6B75B33BD34D377D6906AD1DBD6636E8BFACAF6479DEF5B77AFC70F187DED40
      6EEF817DD7ACFEE36A8BADC57CCF62C6754FDB62866E1849E37135E65845D993
      5120B3C15DDC799170B3A8AC048C68ABDA8A2EF66400C2AA9BCE38E9F88D1E27
      97E3F2DB948A3A28F04C22F52A89223D6EA0E26752B1355F608FAD24954DA295
      8E6857B4AD2DEDF6F62B3B9A2922F70A5D6C1D6B03E9F3CEA46367B68B8B66CA
      D4A0AB6D5A5093BDCEB0E11282EC2070AFAAB47C80CFB6CA794505C1C436DE8A
      3438570C1E06296600E53943A7481EDF6252AF3E16A08C74A3A5778EE749FA53
      41D26560D525EEA8457C09EE38A23FCA75B8B3FEE50BDD439C63D36550A44BB7
      B5597AB5816013878007CEA1E9984F21B86C5F5ACB1380ED120E91D2B9FB93DC
      D507970734B1AB745814F9C175C9B17567133956B81D53EBF23DE9940802160D
      6AE520D0183332269BE05D0470D4289DC9E13BA53CD4AF55D15393B44E5BA165
      8F0F64FA65234BCE92482B2831F35D0D798A49D18A808747693B45D197108A2B
      97984E5BE954473A5103A2C32159148AFEE6502D1E85ADA54DEFA86D59F632F1
      B38666AB2486404D65B3FABBA7E201ECD728BE1AE726C39AC6931B99005D2F4D
      20F3BDE2389F87BED11102AEE7E41BCEE69EDADE7DFFA3F60372A979558408B6
      5FB403E7328A89C1EEB47B996D14974F3AB2840E4C86694A07B406582529717A
      573365C978D3CF83B68FBFDBFD8E8B7FDC9ED7C73F1DDFF7F08FD7EDB7F04FD7
      1BD025BED7A64B7A1D972EE9BB9E2777D325E0EE1E3FA63518D045EDF6A04557
      B55D5C47FF767A1E5FE7F95DFF77E5764CFEF746243E749C37F4FFC5D55D753D
      2E3E729CC3BA971F6D850A0B1531C68BAD65F779B5A931B1FE96F1BF1DE36FC0
      F1F4FFBA97CB9FFA1BC4D9EE117BD8425935D9FA169CD0771C414F320164D8B5
      105F65E0DCF957673E70CEBB8C4FC4BF31E2FBAEE8E9BD9530DE58FCDFA72544
      FACDD1ED778DADB17AB2F730D3BFD664A59CC51C3D8A8D46E96462233122E49C
      15B4F515569DCB1588FEEC1B5E6C23135509F5615CBACD5315EC0B40FEFDB3BD
      4C978D160365EA884DB78474C3CC9A77D4A2B80A40609E03CFFE7D1D8853F2B7
      5FD17A52C1FD46D98AE6456502C6B5D613DBD48BCE090DBA814152A28B8DBF2E
      A80173852422AF29B0490111250035DCB2C7D4A065695A3FC1F0C2D298C2ED45
      F48DC7C7C190AB6418E14DFB0E510DCE4B2E8806F2FA1779F131C5386442DCC7
      BA822BBE098CDC456AC24D987C38AB11AD2D924DAFF59D34A99BE5DB739F25E7
      3ECBE5E65339F7A10E75EF49BBFC3B733DEFC851B16FA8E9C2935BD2F5739A0E
      FFF4939D0ECB8C66CFE7646C7A88114EF2EB628D5EFE9B958BF8A998297EFE69
      497387064DF748C2C0C7E9EDF8B5449BED8C57AC289166D99CB716D20A756C81
      C743526C22EF19C39423DFE3795AD670E2FF5BD84D82497846B6D28F9357C49C
      CE2E2555EC39AF0C64BAB06DF1A5D58B7BA28E99CAA61368668A00F2296C8742
      910A5A9B09CBD68F75F2B80EA3A81CCEBB71AEB3298D60EDDD2B86185071860A
      4B807CF14DECD896D77F550AC06CE4F92D3F72AC6F3963ADF288DCF2D98EB31B
      2D849BEBC39EC9DC23EA71B36E0274D1E43E79B722E2C12A8A9C4A5828CC47C7
      F1CE50057A98DF93105B0151246E55A8B45B62B3DA004E5275BDE67A13CBBCE6
      7B52D8244481CE2AB23A6DE31166F62F81CACA8823094C8FC0B22AF9AB8B61DE
      7165D3CA60A677130385494A592A99F2A214C43635CE53D2D85C60BEDD74F536
      DD550DECFC4B76A0F374968552B0CE6DD5C364CA48F70C3D6AF1F90CAEFECE2F
      C7702A7F93B6E2E01E7B52F58ACE0809CB678B675D6C623EC13425D30271BC48
      BDDD39F209A9F70A3212BE4C56C2A82D82BCD25964510268420F52ACA418C046
      EA00B98DB0390E55CED1C9E9A94D5F56CECF9F4E8F9DB4C64CA8BAF3D3C9DB4F
      E5ADF4A03DDBCF4C13BEB4CAEEE6A220D8AA96772873EA3E67B13CAB5F429969
      4A97C8E7005F0BB089C896580842B8A1AA49EBC897BDBD185B6EF8BF7EB720F2
      2228964527B7B6967E382CD2376C591095EC12B648311A9B43BF3EE9DCA01051
      B3C4A9007AED16E23CA1788DE93FBAC74D291726B09588CBA95A814617F26DC5
      94D81A695129BC335AA45189740E2D3EBD7376494B08966491422508F816FF81
      B67F96326CE6D10F7B0C7349C2AD04B19C6B5A25CA5C47DFD2336C22F3EEBC1B
      FF15929E7B54E5D505DAEADB8291EFD1A8C63D55323ABB05188835AF172B1E0C
      BC2285C8ED254B3212CDF1AA8981D345D2B8C5D647BD2F947DD1C08F1F3B4D0B
      25C2FDB4FE2AF9CEF6D2DD7F2D5489FDC82613290BAC5D76652D9E2AB0B58CF2
      0A67822B1DC3907BD35DD6E1BCF5544CEDF426998E93CF1B208D4F8AAAAD64F1
      54670A7342FA5E68069DE2F97C08882478133B446400118AA4E98C28BE8362C0
      D76C6A533A65687BD67E15F0046B576DE6F2709226BD549A2862D4777A5A766F
      2D57D4E86F59126917CDD09CA5A124BE1CBEAE0F50FCB3B42B7E2D4751EBDBAC
      99FE14CC89EF3F5C38065E598DEFCAF69882DBC956DBC8C01D9627586651E5B7
      242B9BCB6E3BE4AD13D6C6CC0F179C24675780D2F0EB6D965012E1DED6675A90
      E1F749B453762B9DCB9BB6ED4D18537635CD0B6FCA5A20B577DCFB4A3F1855C2
      7097283876945A123CB937C8E55C2A6781A33DB7998C65BF296ECF52DADC286A
      6DC90286FC205B4A7B7F3C73AF362D51C003970C594FD52E49361235669A0772
      F946C8248C2B02CEC0F992869291D458D5643AB525DDE6E10C127F99D84E20E1
      559A4803D79DFFA373DBB3748735C0CEFBB4F860539299D046595275BF818AA5
      D8521A542198D610C3F895BB95E5992738571F99DBEE0F630F5AAC0625F9910F
      2F6D3924D3B465C310B8D81D0C40B8686CEE7347C9B98806EDBA8D049D9CC271
      C2C37C9062AEE7D5BE69DB30344349A52949322D7C5F934461666D56D1DE5043
      48338357763006B4405701B034AD2DCB57E5D68CB357DD5F4C4B7941A1F8C978
      4647C63312577EDEAFC2238F7EA0118907A69CC97076998CABC42F0A7447B361
      B5D1C8560BAFD0C25C3868FC01EA9A4842E4E4FC74AB6AED1903C943ABD4A60C
      ECBEE09DACCF33E47D5E98E5FFE6FCCFB76FDF4A131E88FCD1440EE24A476824
      1035311CA5F2AEFFF5AF7CDB41D1C92C861736DFE4619AD22E80E93ABEEF3A6D
      D8F169C18EDE9AC97FDC06FDA4B9C1F7DA0BB3720B43776CADE5F92D3C319171
      4213B60AACE0EB1C0FE5860D70AF8B705BE56CEEC1B892985FABC4E813DE7135
      32D5D683DF3A9D4AD092474BA620A417253FB10DC0FD408B008D93534D1C4137
      52055C4CF0071553496C466968BFC577594BFDEFF45867308DFEAE394B158BCB
      361FF1DE87F78767458A514304C1EF5B67F0FCD9CBB7C9E78F646662EB8E435D
      ABDEE0EB09A257DFB8AEE2E5FB747EBECF9F7DE3199360FCD693965A04E2FE7F
      DCAF0DFB275CE0E5B3FDF51B540A55048E41ED742E451E51EA59E58C4062F550
      059C71B31E501D1A6B246D990D403DB7151C9D9C9F25F1168C777D1AD9504DE4
      80E03DD72814C9636A0BED2F066141976A590E33B041BFFDE5E56F4E7E370AD2
      A149D69887D80E85C6E2ABD5EF646A5686E234198CB809D85AC24306D248CECB
      72279FA659D9B1B3C804637F71321926DA340615080E0CAF848E62EF70A4EE4C
      E4B04E376BEAA19B5DA6147B9C4748A1A151A54D018C6D0C381A4798B2B916A8
      F09A9BC36407CEAE9CFE98D43413FF338377382044FE2C97D58DD3A9ED945649
      65D39F1527E9C817F64E499EA1772614D82A9113E0D00AEE883CB0684F580F32
      C182A0D87378815461A4776B871213106A7B9612AA490D4ADA487BA4F76D3AA1
      B0895D6EE91BBEB8C09CDB87DD948C1984A12A30E9EB134388EAF253780096F6
      89650DBE544D2B4FA13032B9055A8DF3A25E9C5274CD4161746FAD6D5FC84560
      DC4D6ACE6872D5E349DE4EC51C0D3D6A50B2DACC5B360AA8122537493483DB63
      7704F76D9B7F855C5CBDBD5884250F38105E28B7229E1796BB54C933772B9839
      865DF6E4D90650579071142737DD7B47B136FC2CC1B5D55C3FC1B563F3CF30F3
      A821E6EB47729E3F7BC7302389AD772B98DCA48F82CFF74D395BB531AD255C54
      4A2BEAD14B3D00664175AFD8746F9D27C4D59490CBF9AD9C4BDB9243E82A3A29
      A763C9097BBE14B6CC1C1E530EB4C17253C30C3BE24E608CABEF77EE17718FE5
      5C5CCE6CF234AB7378CFFC7F5726D31AE58055C36CF6B626C7C3E47B4FB91F12
      A77424E2F09684E9F758B26DFA5825557D679E503B8568B7119B926AB610B844
      354CA88FE5E7CD7081A8524BA0B51833C4583146FCFC3B6B9139705DFA466ABB
      AA9999732B4B5F9C4943DB3F39EDEDC6783807B6BAA06485AF17EB06A5AECC9F
      CA8D60DCEEA3621F15167B0182C321C7C52D746B557479825A494BCB0BCA3E90
      A266CAAE8A76BE55DB4600E5E660F7241E4BA607A3F29896C27363329968F6B8
      34B5E68D56E15531BC3AFA9F87C033B8F7129AE05667ADB1556D41660C9F84DD
      1893FAC6864991FAB685C8966D77BC9438308D678918C69966A721646727236E
      36C11F8AEC2BC16F93FA615CBDEF1C1C1C4805E48852FD2EA9CFF565B99D8D17
      BE934FE9935F8A17FEC6C72DF69602BC659C9AA227FB8DF1116BCC6B4C2FBE34
      F813ED1676142C7C93D220255F347A6B9A83652E61BEE7D56959E9611A57844A
      EA300B37D536DCA018FDC6B5630C0B2D6D2ECDE930D780A502B6BFB81AE4F797
      69E398C88DCEA665BB663A14CEEFE05B8E2823732B201E5E82EFD4489F26E36B
      E795F3F68347F52BF4DB561C18B0CB0A4D6C120E6DA1B7DEF989B55D9371389C
      451B703DA37CB3D765D37A72CE5C66150D26C63B25E1C9BC5C42294A002DF332
      8B903BEE9A0FA86BF3FE429661990D6DF2A1927B810B763FC9292FD8E0617CFF
      9D8F6A7AB5C3A83D46EB93D161BEB4D54F2420EA677D932CB5C388F649CE292B
      65D7DE1C2E3570A8B15E2A59FB42964A59D6BC2350C9C92F8C2DB23760660915
      948D0E6D26D28A63EDB9E6D902EC5E1C18301FD1525346B89C6B07BAEC3C2FA2
      9E26509605702BC0AD445B23D1E470C68671AB11473186CA30739C7CDE36F12B
      64DD90121A1D494AE0F4CAA5E4AAA8DE918A740150B548ED226FD7D69381AD2F
      374ACB7837962CAF5099AE5EB92E92BF4D5A2B3548BDADE6BCCCC63490CB31A7
      0ABCBB38E3183247F92C3246E57BAAF69CC11F196F20AF0EE5F02F0921176930
      493E2A8DA022A7A65EEC57C2DBE4D7196C7010DD70D05C7C6E1975F79D3C3501
      57AAE5B1BDE1EEC5396E6D02B889C12C86690D30F3922A7E4C06AB46D9E40C32
      5E16EA9B02A262A826281CDC517F5213756995F531B024E92AAE44C6AC9288E7
      F69563BF0F2E4B215385DA3BA0E62CA306AA3B4B086B68C1F0747479EEFC7476
      78EC7CCCC8029DF2A1542CD4DB399F66B370BA43AEC0CE21A32AE22BFB219F9F
      499AD248D39632194C1405963EB9B59EB34FA0F534F42C48A619550BC9061570
      362D095E3588C9229CCEAD3628327A37B536CE9CCD40803044933DE73CCC9289
      110E15025563053FBE83F7045D4638327CD840F8F699BA7C317E41C029DBA0F3
      9A35F891ED313260D2ECDD31231C0ED5A58836C5397AD8959C38BED563F614E8
      E2E4BCFBEA1C16BA31A25FBDFDD0F39D93E37717969F2B49FAA45D4A349A7D5B
      9A51747C9964499A99A4FC70F201BEE6FA0CD524DA044BB238BF9433785BDE24
      7A9587471276CCE66A0653D9A24E067A41992973F381F386AA40A7F3AE821CD6
      169C245108EA1D21FA519A518B9C3481098E8C67252924B8C85D9C768AE20E1B
      EAB357D5CF043D2C5D17478FE108314EA8823CB183A414F4DB1A6B4E18FF7629
      C141E562323D0A87C6927291901C68E0F4CD7240D2E84F8CF3454ACA5DDC9843
      5C8B71CA410A82D2A309CC6511707403DB752BE86A1C2248B24368AAAEE011BE
      627A53EA3258722BE10A2470F10B4B5B4CCA1E24B2BE9C88EB13DD201B17B3EB
      9255D349BEDE84B0FBBE3D227699E224793195CAF15D521F72BA41193F7BD5F0
      41B9D1E72AD1CB4CFBF54CBC95036BB482D889540247F044BBB4109F3E90B589
      E5228C22898D9581F85DC222DA770E8FBEFF2401F77DE7F4F03D2EFBF8DD2773
      F1FBC39FCEE8767E22759AB79669CAF886BB7B2662B31EDC80E3E0B998BD7B5B
      79642D2EA1E7BE85805AE231CC2F265111DBCC2B16B512773425DC7413851E37
      F0CC4D99AE358E8A5A5DE9DDC5B5AA9223CE7DFCA8222D658FEA4FCEE77DE76E
      23F0EFB9BA95128F2FD72AA3034E8A7C548AAE65F254179B483A50B51EBD06A2
      065B2F1247141143A741163E628F599C838B724834FF5A131988D3996D17AFA4
      85D358B3E14706CB06C1EBD227E404AAC5655EBAF36C899EDD81F3FE617DA82D
      50959E2FEE265EE1ECF2713244858132E473A4E19DB55FE75B6862F5E9F56B5F
      73BAB75F9A7B2B16742E45741162A0B23644AB0AAE115D478F222AD48F8349EF
      2BE33E3F24F8A49CB2E46B2EA04ACCFBF6B95C9AA31CD85D58B7C446A84DC886
      990CC3CC741124A2FB1E17F9963AE63ABD39998DCAA8B8641C7054A1CA2605E5
      BF71ED016B877FFC2768F02D652A041F9CAA6D4DF7BAD8886D7B69026D85CC03
      FF96DB441280ED8EDCEAEC128DF2616132D65A64B6E98AC955A3154A1B2CC942
      9248EC21DAAFAA598E55155FF063AB4DBD287A9509E493C5492C8B2C4DF7106A
      E931E6E45C5155E25CF371198B27913B2C45E47CA22AA783D9A57192E6220175
      328FEB64C29B99734CA114BB2551A344B21846B60F4AF99515B8722E51B95B6C
      0556634566970591A118871093EEAFD099141167F7DC9AF360C65F374D42F7CB
      2C716B259434E40B6DDE31D38D6E200381BEA10E2599606B1943A1BA9D6A5071
      3DEC2C0C98AD9C5B63D9DA539DB2D12F05FF9734BF85594D494936053EE73384
      199D869AB0E256FC15E995CBE85748A65D36A5E9E80BF6ED30C9099267FE70CD
      484550199B9AF31329447B9FE2629499F84CB5DD27C957A98F180B7E5CB52483
      52258B728DF52E02C934EEDE339714592F13A58021A26405035BA472F111B2C2
      AC15C89E722664C61ACC6EBCFC3BD6056538AA7CA2C1CA9F4B84B05516658747
      4E6CC513A82648D13507CEEE1BA99AA74BD41CAC70A530ADA49318ACA2934CBD
      FD3C30D32D4631AB23F8EB575819C8059345327F7A0AE649426D4CDA4BCDC91C
      457A8E5ABAA1E91B71D94A255B55D13C43A2C5488E7CC89F201D69CA7B58B1A5
      559554DE9A948A63A11C707F554E70554B9B45B1F9C79C1513EB1AB494B7C3F3
      A4CC70B21F88AB44C349251A35A5AAA4DAD8F1D6C859DE6A8DF5802A6477EC58
      1A5E49D6F4B2B4AE6DDDECFD22164BBD3297AB36196D39D71543B7EAB10500B3
      8F985047FB40878A8CDEF541C729373CA018725E3C895371AF28CBCDC87D917C
      8B45E873056B1650DE1C81C258960846E97C735E02F6D576673D1C21FA70FC1D
      56D598D7DB4DC39BE627953122BF5065599A9821DB882C143AF61E5F531E97CE
      D3F1FFD832DC83D43DBFE29C85544C85499A18972FC2961ED14914575CC3504B
      B3AD852FEC782635127969C604357A2DC8918111D374961073A97496CD26648D
      2C2C81C9D1DB2DAC4B8AEFBE57EFE76C2C65C3EEA43192F18CB742447D5624B9
      A05A1D52793177D2B8AD8F9EBD74BE329D220590F8C349434A7EB36540F31C44
      292EE6D712697CC3B6A394DF763DA6F7C63596E93E4FDFE7684B96149C96101E
      D81B32A7F34849A60657A3099C6CAC3885433230A05BCDFD3424218535678D8E
      846B271E49723966A80255807515E98B949A23392FF0EFA6DC04954AE5E89A20
      4BAFC5F01E1B37E5C0F93FE94C54EF359F9104E4ED7186C8EDD65E5D73CC9166
      5C67CFD5C3679C32B93E50FEAA6C0523B7F08EFDF4E398D847FADC1C0E134E94
      73FEE3C7F38BED996D9943B290D2BB501D42742C313238519576CC2CA81EE7B1
      30B1743E3DBF70FED5F954387142F89B9CBE3A3AC757840CA3C598AE7E774ADF
      9DA6266182BFD95B71929CC38586616D313CD8BC4DEAC819330DD35EBA72DA5C
      E13693C63ACF4EF68E152D20E833C36DDB5664F5DCD2C3C90412575287B9D0D1
      A26B57CA0DB6BBD4D69F557AD12EE4B397DDD5E5C0D4C25DA7D2742F0DD2CFE6
      70A4DAD096CD836132C28F74D69B943506EB016BE435F6E1BCFFC7ABBB9D3BBC
      51A0348D78B1009D84CDB9D9D9F7DCD94D111A9259EFDBE30C9B1F6188710F3F
      697F05A8BBCAAF0B18A785EA12B2A0D44DD19CCCD93DB7F64294E42138931ADD
      9A5BCA1A94FA369B398613296611E6C3619A9B42B8DF795AD50909F4793A5DC8
      67336FAD4ECE2C09466903D56425E55CE8BF6F731105B1CADCCDE58B364F86D2
      4E88615EE44E9D00E2671DCE36494FE1C1C9602801440650543953C471EEAC2B
      27F2D1C1D9CCC0D6DBDC21F6598D29B888E14F8FD94AF9351E2B539E8DE5E689
      F5DF1B9F150409351C304DE9258200F92E3E4B72DA51BB4A5326F46BE7DD6D40
      3FFC193B592EA1DF4876BEA643265C896FCED36C2A5FE6AF9D37693A245FE55F
      9D0B6A75FCE76F0C82CAB69AC18D872759E7A44512859CC00C7C62813697346E
      E61F66D9989B4197C7273908604E4F8A4610DCB6C2A44B7DE36CA1A54B9B2F59
      D262D12ECE792DF36FBE5CCF9FD1082559C042585B1252A99E19219F5EF2F00F
      A88B8AA53723204A5899D32DA49FA6134A230FA7E0CBF50744F95CCFD042AC7E
      DB752B57ED8D86A12170ACBBCAE056F1C2999FBFF63AD5D8257F04BC70499093
      71F4E5E4F8AAA9FB0B20A5649B9081644E61E9DCD526DF4B870027980501A183
      7325E5151719E94AA3F9ABD9A5A6B3CD8996181E27BAD0E5AFC492E19C5DAE8D
      8658A1EACC8D9022ABA35D5FA4995C937594E4351A6096DA70FA79D0F6F177BB
      DF71F18FDBF3FAF8A7E3FB1EFEF1BAFD16FEE97A03BAC4F7DA7449AFE3D2257D
      D7F3E46EBA042AB7C78F690D067451BB3D68D1556D17D7D1BF9D9EC7D7797ED7
      FF5D55306358FFBE0C7EA3B2C5455C75A953296D65DE3FB22D8DFF5CF7110149
      95FAEF7BF50A7E71FDCBAB32AB1CEA5EEDD139D45EB1FEC5343EC9CE076B9BF7
      DD15CE2476643986FA0F8D134E03DC6414A5647ADCA4F538AA7D75E5DAADF16A
      5503AC19EEBD714251F6A32B1D5E9FA6E1F537B73BBFBE7AAC28E5F50AF23E15
      7E1C0FFF003AC0A05BD08C5192F3A9BEE99012D2D8489749B896D3A8164A178A
      54B03293CBF4CC33E19D9C0136F27478C34FA6E324CA6CBA4DB8F056D01D6C67
      189BEB46FD9B4A4CA14925DDF3DBA7F2FF9C66C3E87CA242BDEFBCA03CA45F3E
      FEF6625F1CA66FBF5EE91F4D83F5525288D4DEEF6E46A6DFD3E023D5A3B8742F
      D3EC125612BEF756D678DDD2AC739AB5A941A25CC69F8B0FFF209E3466341598
      FE4487C97F8CECBC57DDF24D26FD5E518DFE1F316D6C3D2960BB25E00070C6B5
      80710DD5654E10E10459CEBD2F257CCA450C7309AC543165E0F8FFA03860EBAB
      C401BDFEF238201C088E035E6BEED5051A7F85E35D09FA8E254B5D6AAAD7DED4
      39700FDC7F3734FECF5F295041A70A4CEC5F2743682443716791811658A726EB
      F28B318AF9E1F028E38EF3EB8BA0F7EB5405FF58B2DA71F2B2E3D322F4DC0D96
      1D33FB6BC8B3C2A2C02FC3BD35186198BBEED2F5A7FB9FC6C99558E6917363BA
      9D5274298DDE8DE3F478369A389FCF4F0CF861E14C3F9DD5AD577756343238BA
      383E2CCB961A3B1B028495DC719E8B05707BFBA1B3EFBC7DFF93141155D6AD79
      1335F987902807ADE68DFEB3EFCDE1153668E8924A0DD7814D38EE51CED9C61C
      A9A779999CD1E6CDAC3CE66AEC14A8C1AFADB8FE0AA37737B211DD6583729D74
      AD966D7BDEE3D52CDF5C57CF26C39B15A7AEFC98A7A06EE1D5552A66E0F398DE
      ADA10D549629FD4F64696BA04141DB9C9C7FB4DAC6D69AE9F06A6CC17BC52DE4
      93FA93F3D3A767476CADC487D7F897B71FBCDF9CEFA8812B65E8BE7BFFF68314
      123EB9955C3B15C60FAD94DF5163282515ED99964446E7E8880F5A9B37391A78
      098F65EA5E9F963CD9AA8ADA9E199DCDD3925AC12A3000628B0DA930EDF8F468
      DFF9C005AB10ABFCCDFA637CB9F5E4FCECC9B1F7560AAF91C28C96CAA2D83AED
      1F4F3EFDF0E4D6B18E3AE9BC82A7FA9B804E899C6ADE344EC6391D2B291BDDE6
      2223469D4B4736D597A1069B1B7190D253089C8C32866F096511F6EBA5142350
      D0218D2253EDD3C0D93D7F766C0EDEA2BBB11A2521ECF01901DD60DE7A18D90A
      4929CB2A924D9433D2D925F7B79F865707CECF8415406D87A62F135340AC865C
      A0556300F3EF4B62E7EF3A4B4D6F3CEE2DA9F29C0ECC5331AC877230C7792E94
      0A56148618901A33B24AEB5D8BB843A9BF846341C9BE09D57CD0A582C804ABDC
      96822AAE7EE331517B31B82AB1CCDE5E4DE964E9583F3D137E2DADDF9C1F123E
      DC4DEBA0DBBCC193EBFFCD4FCE5FE6B8E79B1F7495B9A5CC78132547E104EE97
      DC48DA0AE33907C9783D64D1F36784EC17110A075C51D30ECF0258316C20F85E
      711AA53CFFC039A60FAE14953BB3B383FBC2D990B5ADD4229D1D77255BEDE26D
      4A6D38864990551322B7E74B8F385FA2E3A3F6F6F8E8BE49DA79D226E9F367BF
      9C9F9F884D7AC40A122EF5D17016D85632CE2E7926C683D9DB279B8140862A5E
      2A5911D6C3013B7CE363FD7F3908C3F0DB274A90207A72CC5EC701E16E0DBF39
      3BD2BA69CA5DCDA41D6FBE638F6DA410B381D32BDC123391C3E99072AE260D35
      DE256A87BF2A701ECD9BC5F9F55D968C9C9F3E498F10EAF4339B7AF4BB1131AF
      09BB4A4983BD8B1A120B4EF44F9F48E91CE8CF9C18070A951FEC4B73792E6613
      18B097308CBB37197DFE324E3DFC5498280D648AE7CF8AA6A7AFC9DFE8BF8CE0
      BDC183B8D29F55A4C38410BD4D1EA2693046B5E6597A9348DB4367E70DC54B3F
      49FA61D1A4C4A61DEE882F63FA189A07D95A3D4E6CE4A730B043F3A83782B24E
      CAEA5D50A338F5906EABE0D13A494D79324A86981D55E5EE5B7CCF61125E9B72
      7553CAAEB800BBE8ABCCE919E322F7BA41747BFE6CE793A65C2C8BBA480DBD16
      676D3BA8F1E70C6C3751E302AF7C2455771557598D9B4989A3743461A0137310
      B89C14053A43E4BCB993E6E25C314B7D808A9E8995969A26C7455ADFDCAD1DC7
      A481AA00DE1CC1C170DB8FFF821DB277A626672A836F921F4C3F4BF570F9E57F
      CC743EBDB89B68F9120CC39D40C653410265B84BC1A531E8402CED43D8DAF0ED
      B85C5EFAC512D391AF2257358F6A896D2C7EBF835EF3267363B0CB082EDA8248
      472C2F47C9DF55432735AE2476D074CAD0F1E1C7771CF1E0CC57E6CFBFE6D4B8
      BCC65619273154CB8842B6891AE2C7611A4900641BA8F8B240C5364C713F4CE1
      3DE930C52FECB41A4FE25C907FD974258BCAB8115F25F1E65B7B7832AFF39346
      7B78C64F15CFCEF1CA0569DA441ED0B4827FCDB07EB6BAAB79F3FB6757BE5BC5
      F838C5B8FEA45C3467FBA0B3D59DF7756777AB3BB75AE7F113994DE397FDE2BC
      858E53A6991AE74335E5D406812032DEEDCB70F25AAE0FD3D1883B677236A40D
      68366FF63BE7538A9A4CD3DA01A5E6CD71BD07BF55598FF3E5DA5B6F6E9946F2
      9FB4467AFEEC9FDDD0E64CCFE218B22ADA2F87E92D0586469A12541A38B3E28C
      F52DA7161690C1B2641CE2A6202FCD11D36FEC3C9F3F336B487F9B7554376912
      E5CEA51C9D33D046A6E144D13C19C37946E06C74A86E8ECD321D9B33B87C9F9D
      2E482E638899EC40A8B711C50719D853109709766FC2303B84962E1A90A2DC5B
      4DF1859A629B9EB44453F49EB4A628A5CD2103317F7C7372C83AA34E43AC061E
      4FFF531DF5FC7476784C6126968D7A3499DE1950BFE64DE5B3D100341BABDDDE
      9C1F1649ADCD9D1138CE30DC28BDB1F8AED0D9D4E083526DB99FDC1036591EAA
      892655D7BCB94280580D4E19481F3AF2DB56A17EA1426D6D15EA7D85DA7FD20A
      55A0571B1EF197A2A611245676E70CB5BA6EE21CD6DB0234C90AEA36156D7386
      F5F1BBC3D3064E98E7C36DBD6CBE4E96CEB8EB6EF326A3A21BC5995D6769C475
      F4B9136B456971CD9B4B94A9CBFF2F82C3C9DAD134E39402992237CD24ABEDCC
      8532122CDE4D12CDA82E87F0DC9A37F538A5D23B657BD64B0F61ECB00F4DCD18
      2FCF421B5EB7FAFC5939156E426052BAE9CC8A9224CC69885CF07A67AAF3E9C1
      4411839A204A118AA2CC7206B3A4C442EFBF38BB1026E07FC128DC339D91F0E8
      E65148CC3095E7699870E9A7ADF624C2D42AC2E18298AF56864349F658816F5C
      6DB8FF074DD5FB6F32D538ED7CFB99D6C799FECA931DDFFC019385B0D1E3BC99
      629ACB006103391FB24B354EFE4E0D65DAFB1CCD76F7288ACD7DA0122A4767D0
      795381BBFCECFADBC3E3BE1CA5668CAFFF97F981D4C5BF7DF5C6230D5BD6983B
      D27CFB2DF8F26FB324BCA6FEB1D4676D9884D36FBE1B8DFDC0A0F35CAFD2BCD5
      1BFF2158031F5EFF7140035C6025FD9DD3D9744248F8E9D0D62693D967C27FF6
      E48E1AD68E66E1956174296B862056A309C4D5FC3CBE4187941D10EFE0E0D75F
      CFD65E994685A0FDF557D8C1F9AFBFDA42DEC8390683AAF11473DDF9DA05D1CD
      DB04E5C99138737052AF92C8845208AB5E102154384D2D7A4B132749133C4EC7
      2FA61CA91F6237D0A1734E93BCF8747262B2C6C012C5F9B33D4E763435FAD405
      4C8D13662ABF6A6422E0E241FD3ECDF35E32D9CB7F33506BF8A1A87E6FE47986
      99F0CF7A3D7ECA241DBF3ACC4669F6EA70349A8D4DD2E784CEB0F22BADA70D64
      FA2233E3CD87E38B57F8CB657FA16CA0CDE78E051ABA601B7090873A1190C9C9
      BDC748E25B2BC3E1462BB386A21E0835DED9A3E3E30F6FFEB77305920C1B69BD
      98E998F2F42B302AE9718A2F3A919E68AA5718DBE3716A95BE3DC5FBA253BCD6
      41679B41B9E4186FF0A48FF1923C9F69C71FBCE6D8688DC5971EAE8C12676CA0
      05A43C2EA98E29DCCF168224A0396A4457D1E505501DE1ED5AB0EB066A0FA15C
      DB03E94C925E02C3E9B3F46697AEACD2BCDA489E0F84990C5D316AE05C9F3F33
      B3F55DC2583170044E964EC50752E3CB2169C56CA486E63458A2E4C65DB2BDE0
      D312B5807C8EBDE651E22A9D5EEBBBBCC0FB58EF43E715C80E030DB2FBCD1DC3
      13DAA1DFDAAD7E699BDCEF53EEEA442D8662BFC1BCFFF4CDA33EBCD6849EF940
      941D137FCC6C5FFE419319A763FD479C197CEBE9266388A6690385D2F36757E9
      3072CEAF92786AB061F3A9927C0F31CF28AE759D4CC83D99A65405664511AE83
      F3BA4B3E0CBCF70CC26A3A0B0DC084DC0A5B35A73E9350DD54382520B93ABF9E
      D2393FDCBF7F0E7AB17B4F74F9F04315CBE99EE866A46382224A08D819249D18
      2B88607F392A54A8478145261CDDC6765FD29F09F646AF9C9C25132310AB1B95
      0C6DE24363A1F264E0A6152BC679C7874ED447DCE41A61ADC589E4F222283613
      08CE9D5D2AB808EE1CE3133470631C4DB3E19F8E08589ADA4213C098F39E7224
      68F0DC7C76984C821493D8774EF210BFA6A6F4C4F9896A2A658F346FDAD5A231
      03F46DB72E05388D4F13CD60F2C66A98DB9E2184412C80E0B64B2F07FFA97C29
      6F62F8D3005E492A8C6688A0690D59CA0882FB20E228755E1C324EDDB227E98C
      F26A5E348F2CD50CA2B964A80A4253FE9A82A8D27F8371106DC6D12E6FA99FF7
      F62B7D6B9D37597A9BD309F7E170FAA7B79D060A8AE7CF8AB5AD34EF0DD2F47A
      A4B26BA3124DAEDF6B112BED8383AE3D5F53C5A5FB0ED1C07E77993A810AAF9B
      478F4AD1439CD7D933D3026EFCE74FA7C704AC99DAD3A5717ABBEFBC48C72F2A
      BAA47914B95FF4B81B68CCD884D3F70958BD08067074A189E180E208C1A6072A
      3A2221944AD81063A84E58058A0BCEF221B55D90124E4883C9501376AAD13677
      E92C2B70DF92D8B467681E39E643EE4BD4EAEECF17DF7FDAE793857D6EF9B2CF
      872C35E28ECE444DEEB259CEFB66DFF94E4F4F6E207318A3BF68830AC216856F
      EFD5CD19970C3BBBD32B35BE662DFED7747C1BF59ACC6852BEC82753BB962486
      73F6688674582B7D5F4F7F3AFDCED9BD1CA6811AF257F8E0FD817371A5B90FDF
      8B29E1F06A104EC07C8F7EA093DD29351C31B9D9A6A8989E35E59B249A2349B0
      8C4388DB2A05C50D222711D3B3C4FCCBA7EF8EEB600DE4B3C01E17A5CEA793B7
      6064EE7F27EE40537B17517E031DFD73AE5D2639FB1F4F8F5DA79C2E96F9E3E1
      D10F10651CF8A484E726CE93521CDE7CBC38B6C2888C11538510A4D11DA5014D
      25CF81708070E57B67DC4CEEE6A97ED2F88073538E4E4E4F791BB3AD71296526
      4ACE67F81C346E6E1B8273EF95698666B274788E6486591BEBC3DBF38B3ADBBB
      5457CE2EBB752FCE134EE33276EC0B1B1B20632D8EF7B6E7C55F7A5EBCC551B8
      7F5EDC59BEBE4FE5BC58E713D33BC9B4F2A5C46D889840C7690669928F9EDC92
      D63DC9EDF8AFA9E56B3E8507EA400B66F15060FCE90CFB32D379CE856AA11C6F
      52A8679892C737B101C0E6CEBCF7DA112F45C0150ACD0F6D48BD70A7D4CF879C
      9BDC7977714685B21C0C86FEACB1FBE7707DC69A5043433C61DCC89C22EA9941
      D5A79402C93AA24F057F199B45F9DF66941B1664E01F3DBD4F3A9325709970A0
      40C284749FC5526518FA1C1ECC813E707EF99F1F93E9F9349DFCD6442271C0E7
      38181E71D2643A9E6F23221912D84FEA9262AB2AA01492216D337D439418DEB1
      2DCA1E466A7A684A4F83060A17F6108A160D54845D27E07829FDA76FCBA89069
      94428488A4556503E303CF9F11D689E80FDA2B5679DC51CA7C38A5E4A2F04A4E
      27A757E674896DF0DC26E077C5B725539DD0478B1BF834CAF08F04ED9B489D15
      81E67DE7C7779C2B95A5C385A8F3619E93AC19A9313653B66F7F0F6C84997762
      2343CC26DE217AE92F47FFFF2767578F6DAED9DFE90CB6388CFCF7BD7967957C
      F3864FF8E3D9BB7323361A3B13092640640579CA0505546F3DAC5817AF9DB30F
      C76FF6F1F7F9F1BEF3F6BBEF0EF9EF73FAFBE2BCB1F39E9996DCA74717EF9DAA
      5749F5683AAAA8FE1FCF7FF8684CE7E6EED04245998A373E2CC58ADF68470D13
      4527C43C73070600C92E92E7CD9DADD87F158C4ADB859923640DDFB12F8EC53D
      7D611A7C5F69AE7DA9D81E2F5EBA6DAFE7F53BBED73F68D19F1764AA049A3BF3
      B2E8C2FA1FD5F00B4E4E4F4D5191BC8B62CF70BFFE7274FA7329221A4B497B1E
      B443E1A85F7F95C6984E403835F98ECD815E3C06FAE73901AAF645B7473292F5
      4D12803B4634736E5E29DE2B967D55CA83FD19AAB0994036668E22E53E7EF7E9
      53C5B2C25FD94C42A07532C6A963F7F4EA3223A45B6958A76E1AE9F4CFD16489
      E43FFBEEE42DF335D99D22D2FE72FAE1A8E952AC98F2CE8FE3598E7F6DC6C25F
      CE4F8E7720B5B366C670CA825E999E241FCC2FE9FB8F47FF777FC901F6B6B5FB
      1707FDB7588F4B82FEED271DF43790C999BE79F51ECB75A6B919705C0B3BD926
      83CCC6D84607CE8FB076544CF61E8C45B619994552E9EE6A0A0EE85C5251E158
      9654F6DCD3E197B5B33ED784E7CB41A94CFF6D966484322925610CD21371E530
      2468D4C0C90937282C16E5DDAC82E0A1D5A41641F15D0114F0827CDE448AE2F8
      689A38A28989B21C543BAC302C650A43CA6949FD9434E806AEECCEFF9E8D26DC
      4027AD69E625B682FA456EEB1C27E9643661A08446AEEDC99862EBAF4C8C9DAB
      6261B74A55A7296A68E0CA9EA697B2EF2877E14667B75982818F2909A473F6A6
      81137AFEEC97CFC7E056EADB355543AA54D1B6557A46A1614AEBA160C45596CE
      2EAFA085E8838FF620175BF74A51808A0B79F2A91A4D0E9C775367C4F18E4053
      31543C1BD275533ACF73B0A105F184ADC56612CC805DE0A3EBDCAADF0A38A654
      6A13B63E05E9CA5E8807CE4713A5C07F473F701D089F6AF2895C0349B12C6BE8
      81945539B464E0E48B33A976A703973B03F5BA578AB96FE1157C811FF0BB3763
      3AB74757AF9F1C53FCF126BEFBA44DFCF7D5C6E364E035705FBF5F51A6B39B8C
      A98C51EA172F67434556F884F4409DB3783C61AFA1C4A89E1AEF5E9CAA00D66A
      449EF8BE737144356BA798CD9BF47313E767A54D9188A642C25984CAE7009CC5
      69900370AEF4FDD35B565D64AB8BD309510FF745E377A301A984AD89B4F8640E
      5AF3BBF1547D76AE2061862465C849CF8A3A3CE39E7CCB10D6535656D4752EDF
      2AAAFB8AAAF3A415D54F2A4BA49B6DF2770222989AFA7C3A9CE016030DDCBF1F
      668C8C24A7834EB43E09F79F61D2EF24ECDE76BBFBF8CBA7BF06F457DFD9A5BF
      6E55EEEC500A2017D5116576F6B6A24B44D75992875BC9755F72794F5A723D7F
      7644580AA3344AE2848AE21937723451D3244886091C6FB65C82147F1D6BCC30
      71FE72C2CEF85F4E3A16703527C0D53C9D6584454079940DDCF912407EA372FD
      9E6653C41DF2D4998D7389DB487F3FB6ED0C481CB52F9F85D419C71C263471EA
      6FEEA6FA90A6B6BEDE75A8C797E004F82E19455F38AFC6F79C2099E6DB53C82F
      3D857407DB53C8FBF2B3FBA4E5272F228401098C9BC4E48D8FD264A4C62087F3
      8FE7CFFEF357C6A0FC351E46E4EBFCE7AFFF423F52F6DA371EAAF3FDFFF978F2
      E9F4DDFB1F9C9DABE97492BF7EF5AA18E941A46F12352680AE03C8FF57F8F7D5
      85CEBB34E497EF30C1FCA5E7F7066EAF3FF077EEC3AED504606F7B839ED769F5
      EF0D9EA842991C4C2ADCD96A45AD70A0556F100F0215EA76BB1FF6DD564BA956
      CB0BD4A015B4DC96FCE9C83F7ACDF5034FAEF3FBAD56CF33FFE1F71EEEEFE02A
      3796FFFC08FFD1BF03F33388E36B5CD39657D17F2E7EF771BFDFC5FDBEB9D65C
      47CFA59FC1A0FC335FDB31CF8CCC3BAADFE3F7AE7D168D05FF3E7F46BFF11B06
      E62ADCE90D2A4FD272357DDEC1F7D890AD0EA6D3C1351DD7FCDC37BFFB32F3DE
      A0DBEFB763AF13B4A35EECF555EC8246DD28F4FA5DB7E71B3A82665D15C844FF
      F10F2C349835CB879B32EB6CF86B18BB5F41587E11A76202BFE6F0454480D14F
      243BF4E7D6AF722E78D7032FC6693A353F86E930FF4C3FE87134BED299E6BBE9
      16CA1823A9C74F1399150E7FCDE3E938F86B2DD2FC73B723300996546D998C09
      4F56D9A2E448872989C5DD4FA6DCE8F0D3D9E1BEF3FEA7F377FBCE590D06F870
      ECEE134AC4872606C10C614E6EC060642B52B89721DB9C4BAA88A1F3BB77C792
      E545C907C3E4EF7485D4183576B66F57E5243240880DE84BAFA4A23D63F3666B
      EA545B9EF31A53A6EAB194B0B608A0040E02D52433185F3E7276E987CBAB349F
      EEF1417071BCDBC81889C55DEEF731F163E9CAC1115D7205098DD39928EABC91
      0E6723F887C994902CE12E616ED44C93BB559060300583CE6E34E33C2BE55C29
      8131C934AC2946B60B66977B840E83EB13EAE241B11709BC481B2E45E9920DA4
      A1E19DF60024B4A054577C90ADA288F606C85A07FC2577FE72FAE9B428E5344D
      21093156D2D8E434982898E65AAEE57EA0D092305633AE911F2797638BA76353
      C7DF5D9C3590AA052278BB05BAF2615205FD904B57191531370D5E218993C894
      01E707CEE1304FF7D9A2DF59BC7787621C04BB21D2AB81B4F950494431EDBFE8
      588A18867194A0B1A754ABC9BB4AB21D035D433D43519163DC408A1472CC2D37
      E1919AC0AB2CE0E24D2EF658B046B9909E6B8A2A05F451425122323EC141C7DA
      1CF5F2BDDC7980B71B25AAE4D40691F039890FB741E36D72C6DAC887FFA4231F
      F367DD9486C5E64F61DF71DC985AB64544C689CA61DE3A3BD48D6BC7B9D677D0
      E44D347E2883A182B56AD1A51B3A13ABD4D65E6C92EEB6526B7B4AFF90C4EA3D
      71897544275B197B1BB7C970C8C68ECD3CD60E796D9F316B4ED4824347C65026
      1726530218BAD1DC5B31C524EE0C6048A0AF9271130599B194DD2E59CA16AAD4
      144B4B37394692A2E210825F6AE00C0B6FC06DB33760DAFD18D49F34763EE94B
      CE579016910CFBCB1E270CB94F453BA1A2CB00C7B286EA4E0EBDB85C687DC89D
      CC68F1C1F8FE740C5FEC3D7778E357975D8BFE7274FAC93A5FF3E43780158D5E
      80D6AB769BA205255969E7D99A65697651945E494D52750D86697A3D9B38D18C
      E3675C88151986653C2B0263E2DE17B371A687494315B2F55D7B20D41BE9666A
      72E47EB4CD4FC94B3F36452005797282B06FEE74C9FB12E7D4D931D896122ADE
      01270CADADD56C17B3DD261174F853B5E47C0ED08E91A5200DD8DF94348303E7
      5CA2C1B4E8230801E81C35B4256A2C24489E984C85E19DDD1E9A63CD50CF7983
      3741AB5F479DBF767EE2B83A41221AA24A1927B9E3F4DBC9F919631E1C386F54
      787DC981C3B24DE0301925C68BE776D9F8B7C00534C4E42AAB0692B160BC568F
      F5BBC4DF95F3B799CEA756CF18C587F9644A30108DBC89337549C018525C0F6D
      1768DB5C1C8AE861BE6C6A2992A5970F7A9DF0D1855A9FF3F8FC59A55CD8D4D2
      825C06238E77351DF18CD5CD8851DF0F9CB709F6ED8F94294427631483ADC4E0
      C891D6714C799437D8D0C5CEA6A8B744E60496A981E42D19920CCE0FC6E626E2
      094B5A96CB1D50FE3FF8A34383D344554DF63CA0ACA83B708E658BD2E1D2BE65
      C484AB7909852FF9BB8E4A0A1A24D840D7E88D7849C18C26DA5B96C214FCFE29
      4D40AE8BBB8936BD5F60F2D289CB64A2E1811D386742AF5CB6F2DCA6FDEFEEDD
      FF30A63DCB24D9FAF8F77DFCFE13F7F1ADCFD1C12EF891CF98EF1D0489914049
      9D4668EF5B0161AD08A836781229430ABF668FE3884A7262F11D8BD8416051B2
      A015A9A1C7544E298B266D3C14EA58D6C4DC052B4E60A0D720BBF3C1B4A237B6
      AC499F159C5403A3A6605C5D52837AD3B50EF6EB8B69412DA2325F7E60CF42A3
      54E74CE79C432F577AFEB936FDD8A85BFE0D4B20A72D29C56CB01AA61A612BDC
      B659FA0F49B5A7DD10BDF423C97ADA21676636317CBF2367DA41FA19622BBC4A
      33095005E994BADD51170D08AD068A1F75932684CA277E18C16D87AA06A1A6A0
      4654DA8910CBA9C34001910E66971401FCA6153BFFA499EAFD6DA6FA3D19E23D
      ED2619CF9FFD4C9A794AB954A6DF9D5191091D694CD5D87453D5F042A91E19A2
      63ED43B9479C6DB82B6655D9CD9974337EC2776AE8BCD79F67ECDC9D4FB51AB1
      4B9B5FA5A66F07ACA763B605547EEDA8803A1DF1388D8287049B8D1A88CE5BC0
      9B7C343DD1762503D206FEF68A564F6470CAF1F9080ADA0668C4B6243258A880
      63B8C9E93848B3B1737C7AD43C8A187AEC10629BB1189D77C73BCB92454D6CB4
      7973BCA0B999EC9F028A6A692210CFD7760B68DE440F4D8520490D39E3AA74E2
      C687E6A4ED7F39FD56EBAA79D3E31343CD672DD46470988057C374C80EE438B2
      4D506D9E2BD40717C635B7C9F8CE7C67B1026F4D4A42C7612D2B555B77CEB4DB
      3D3D7C7F2C4D359968F8E15DB12376A593FB7C0BF7BD03E7C3B8D264D660F631
      36A15820FBA69373F2F7C6F7757F67FB822EEDAF41661737B03629555BB3F54B
      CDD6DED66CBD6FB63E6D98D7C286FAD1640B44891AA67C7A3ABD9B981E3C02E9
      DE3EE83FB9E55D3BBFD3B48E60E5F38C5791364542DA994DE3BE2928A27859A6
      C6F9B0ACB932A515FB82BA73C7127734128857C8534AD63C9F66BC2F403D93B7
      49C0A8E6DC649A123A93E9B0D03C9A1AA45B281131415E154720F97532C94195
      2882E5651A1E6CE5EA17CB557F2B57EFCBD5A78DAD57426F7E38BE20A101BB83
      0DDEC8D99D66E92CA0EC468EE51FABDBF1E58C60A1D79724E58D76D3DF166D14
      A95FD7E1D189496217F48F209970DF28765ACD41C5BB984220257C4AA642ED2C
      66F548FF371373815D57D43C2E79A454D295A904124D692CAAE9A1C9D3E35E81
      9812FD50499F67743CCEB7A940C2C13158B47CB76D8D3714D1F5702BE6647877
      2BC3EFCBF0A70D3B67C416BC48EA53C9C95AD460FCDDC7E373DBAA5364571331
      CFCDE40497E9F8E4FCA2C8463B3C3DFADED925BB7FE7580B0013CB103AF282D6
      DA69B20A626D5CE91B9933D87BA6B90FAF8111C5352E6D5E4152C0DF1FA4D10F
      292CAB7B2826973212031DA4C333720495A179A429F9C06A9248D7719952C9DA
      1F3BD4ECAC2410B10DAB17DE2DEAC61255A8D43CF2149C231B25205CF80A139C
      49CFB38FEC20EFDAE697A00ACB7C6F8F53332843A54843A44E11E33200EF5CA9
      9C3B90CFC5A01A44A05F184ADD460F4649CE3941DC27ADD9EDD056C26C9C7F3C
      396D6CD3C78F5C28FA326074B9322C9ADFC1221EF136DE399C4CC0AF527DBA23
      7812BB9C03E1A89B1A269229D99C3330A9A53775039DA60D541E3BA6B65F68D1
      C0F11F42AADFFD5D534310990385F8B34C8FA7586773449A7F0D5824B7DEC4CC
      80DD65E3759D74AD6DDAF6BCC71BA77C735DEB3419DE0C97C76FF9314FC1483D
      BFBECB9291333147E0C3F46B9C747EC5855C8F9C110C931B8AAC7E9A8DA9CA4C
      04CFC72CA5D4858C264478781B83FC810ABF0BBD1761FE5EBF7A757B7B7B30A6
      FC8B511AE50C9A969A39BDA24F5E79EDBEDFA989EAF79430FD7AEE724CBF2A9E
      5FAF57FEC7587CDA60EDD13D0673AFC0FCF30CAADE32CC3EFA0FEFF34383CA67
      71FF0C1ADF1C76A07D4E6CD0F9DA84E9C7787C84D3D779B2787C6B996B1386C2
      68C1E34F047EAFB9E07BDB20C8C32C792607E854F6A8242B3F4F9D34A64662DC
      207654C32484C9C1DE12B93F3B1FE8386C879C70312DDF5005386528BCCAB4C2
      F002420628FC2ACC68DF39D77F6308B87D3ACE2BE083F61D3D0D0F1A6850BE9D
      0DA979D984ACED6BC28692F076E6D813020EC25C6C83B25F7A6EE66D63AEF7C5
      CD5307CC5FC847A02A2107AE36B607764734246F95DD7193167B30FDCC59B60C
      A3216DEC52E7CD87F373464AE5089F45117A72CC503738674211375433CC9539
      95D6F3E0F8FFF8F1FCA2B1733B3A393D756E159DC7B1F82150B8D984E3888126
      CCBC223B302F3BBF346FB6651C91E3CDA3940BE186FA528577CEA7F78767E668
      92A2A97F36CC6C60BCCC37D29E9CC2D1F8FB8CFEFEF9E4F0E33E87EBA130DF9D
      37375FD9F6B25A3E45136BAB416243A9F9A0EC6C9CAB584BC47E72574210D8D0
      1443A392EE1081D2407B829ADBFFE6BC4FF934CA24861EBF3B3C75089161D2C0
      082C364BD1A453645FB6D8AA53FA6CABCB281D0E0998154F74C24CE5549D447D
      A74DB504975B7080D318B0C7A7470D2408214C383B25BCD68E69424D1D6508DC
      C7D8D6A6E1369FBDC4E9B086E9446A35894DA10A19F7649C3750511699BE84FC
      04DBE6AE3416C02B9F7DCF44B81BB8F6DFA7708F8E2E3E9DB2AFC0A68FF80E06
      1A83FA0BD166884BAF62EB397CA9E7D0D97A0EF73D87A7DD2AA6B0B08CFA97A4
      650B82463B4442E5D5C30F2CF788AECE5F6F8F3F962C77038E3F4E49F088E998
      EF3BEF48C4EF3BE7130DABE069ADE8DA996006AFE727B0EF7CAF1507C1A6F8F9
      AD0ABF5619CEB79CD62715EAD7CEF72AC93087933BDDD4E539928E743A6BDAC0
      3F69A95C68DAB8A9B6C0A166D54D1BF80FD66D4FC7AF9DC36C9466F063B59A50
      C4FA70344AF769AB6FCD8B8699176C5C904BFA0AAE690DD3F237189714A5D419
      650692ADFEE3F12771AF04E088DA973BB78A8D59582179AE2EC590173052A834
      757326B0764F8E59EA06766C10F79EFB9E1F6C0DAE661A5CCF9FBDF9787CC1AD
      9A6DE1C61D18D956CE4512A096800C434C70331CF8DEE3A9707712732DF2D419
      2AAA7B81F1EDEC96A9D4F234766AE9415F231AF78D8D38F893D38490160567BA
      98580DCA62EE742B8816E9CFBF7F08FC5B1286CE281C652027E711B8CB85E779
      377162F994F97861C5833BF9A291F32A226A851A6208BEF13547CC8F931B4C6D
      9A664F2F5CBE3564D689197BAA08CFECED5F9CC9553AD6541A77CBB689394795
      E8B9C978AE943E34D7169183843A52787699CF677CF3FCE9689937FBAE906804
      1D35643D189A765524B0E9D23FCB75C3024BDC883D06D39FCEC4E2839CA7F2C3
      185E02A172348FAC051F1DF1F449D465D3977A2C5D07197698BA3EE007EA3170
      7EF21F7254B14B059D84C42C2718C5C18CF4FB50542D11EA26D2A3AC1613B929
      95039C38DF4C747DA9EC38AAC108DF1FDA8208DE0FB608445005AFD490DADA83
      F3054F824E688F29AE7506CEBFA303B9C6D2E6D8F6D8E4D35673FABA2F324149
      035603893B274EB838C614113570EEEF532E9A63EC7E99D80EEDE96BB27C6E09
      21967E93FE0998ED4E0367680F5AB9720D0396C26A42EDB0A04DC99871BFA998
      2B2ADB0D36688ACF9F993A9FB7C990543DE9AE2373582E4522D44967AA05F357
      4EC664C563B921876742E828C201B4E4934CE7B9F3E107AA799B0A8DCCB542A5
      7D460D968A7E814134C8C2DCC7F77332B510C497991AED0BF6E1BD9799C809BD
      4B67CDECDBF3763D483E4FBA820F664342CD151AE782FC6DE25CEC43CC45D45E
      71D11DB1D9FF1DA6979CD4379BA4DC31AC89ED60C5D81C25D4E18C002F7893F0
      2682E9F382F00BC7914DD788D361440D9904EC222B531888EB6B441A796370A8
      451AEE16FD9E050A945E4F3B8CDFCE40245C9E872B7810FC4A1AC9BE33994D39
      13645C4D26C9D2746A86683C04FB25D64687B3293F8D4D3B3C7CD756F31CE0CB
      7D078BFA93FCA4A7E11618F8CBF312DC6D5EC27D7FFB69377235057AE75267D9
      4059469D4CCBC63092580579D5BC89481D2F2CB9603DD23921C033BE2C617E10
      034D097A935A1DA45913BB357ED2233D0A20C327696E7A5142F8530C4F53BA28
      C9F491E2A64A0D35684B70294991332DCAD8843FBF4AE2E99F8E83E1D13009AF
      1B38B95F0E87C3DF9C9FB33BEDBC51F995737995E6640F5A68F0DD7BB5A52ECB
      B4F96163DEB15773E476449DA523EA38FF72A0F3C9018FE37175AD8F96A77BB4
      2B8DE72031246E54D954BEFDE5F0F4F437E7EDE9F90543C838347049C69D3F1F
      69ECD44ED65E77FCEED851DC972D2FA1A08B83AE064EBC088D56CB155924512E
      88E1DD61E5BB127A54196EA6D676565D4D4BF8D10612C390E2E5F0B53DF07508
      2D95D40F59E84E8EC9865782729E72231101A69E2388B43168ECE40FA5F92E05
      460BA96D22DE1C0FADD4B2BDAA93B69FAA884BE2D84F36C9FF9A7A1CC4854A20
      123591601C589574A9B334FA018ECFBBB30FC736BC6C1B3A5050E446658CFC58
      367A6DEC7C3F9E1EBBF3B064F71A54B3D653E135F64F43A7F98ACB94A4F9A49C
      8B57DB9571A3F8985ACDC6C9E726CED0463EEC49637A4BC9A257C9C4F2AE14B1
      D6E890C93591078D04152C89703E4E6FEF9C5BAD18FDBA5AB8957CAE66121C66
      D3AB519A66DBE8D0174787DA836D74E87E74A8F7A4A343CF9F2565E9DA629224
      ED0F09B7F089291F98C2EF1A99B4B0ED86F9D20DB305565FB2619E7A07DAB7D4
      0E7D367DFF136F052A5A1DA9ECDA349AB748E149EC44B3093C49CECC914268EC
      A51B6A524D5DA1B846ECC92DFEDAD9C76C5A70A1B3C4B986697ACD85A0538730
      1D4D7FF3E676F7DAA1727D9286828593EF140D49AED2D930AAD8C5D26B9B175A
      4F5532746E12DADF1CB425579B13B40A236A2B241F2D24B7C8E54B84E4536F68
      1B718B0927A4803795C02BDB2ECE9CEEDA8213DE34B757747C7B950E394AC1B5
      E67F9D8D2606B34B4D1B8B767B4F5CB254A1494E74766D852525A6D1544FC674
      EAFE314DC60DC4F116BFFA9CFD6A8184A418897CFA27F3F9479AF4894CFA8226
      4D295B0440AD1CEE9711C16795D8A3AA213086C322EFDD222CF13B89BD0A780A
      CE036D1E3529776F6EFB50166F061BFCAE8ABCA15921DD3AE94493B14E41388E
      F13AEA12336BDEAC9F3F930D938C5F3220BE9D0EF68674861FDE3921C56978AE
      614AFD0CA796DD28A0CB0656426A84E64B89CF9794C2A3422AB6BF95FEB85ABE
      1B135EFE101F9B86864DB4C6CEB88F8C14B9D511CA4422B9E793E93B43368AD4
      8D98C826F507FA598A025FDBF662FA33489F502F2D35DCB70E215333C49DDBE6
      2D5F62E1B807DD832DD8C77D03A7FBD4BB6D5390153B27CF75365D86D21FE273
      4A68B87F3AB0DD288FDD28EDED46B9BF519E7A7FCF37B34B3A9178EDC4C35471
      4ECC842C5C56DF2A4B72E9694966CC90F2B777E2D9DFFF7EB773E05C5087782A
      D4C9744EE7B1B497A8A063E1312046A03379807924852328CF54FF6DA6860C5B
      09B59FCE2E59FBDF3936B3DE7822C364447D3225074985E12C234844FC6E6CB0
      5DCF09EEA67A6FF1C57C6A941F386F246B9533C3A91B1C951687526F65B0CCD6
      D1683D15F9D5B9F842261011E86286326D0940F1275B49F3A592A6F5EF7F1009
      97EFE64D49C8026C0909412426E197136EE793969D67FC7A4924383838D8F986
      84FB0252FDEE628FF07AC8CF609071934122B80260B4B1BA492E25B3649A69CD
      419097FFE6ACA2A921698D24CB25F78B649270263CA261F125449CED2415680A
      6A926CB31197B8CEC91149476A3045317035BEE323F42C892A2D32198661440B
      44022B341846914481E83578C61ED5E5F06F2C9EB98ED391DFA46B3107D459DC
      D6A6042B0F2A36C8753C1BDAAA1F760F4760A8048E23F93E33CA8099DA9A3158
      1163EE9F2C0E95D10FF16C3ACBF43E77D252430CF5568D39E9450D6FD55D4E9E
      E90DCD5999A0BEED04EAECEA83CB038CA00E2541F9B71F3A1F0501163AE58E2C
      4B38AFF4C518CF22CA0ED564C2179AF533793725A08599D0BE634B5C47EA9A1C
      BBCC54518D531B84CBB43C9E7C3AE2039BF5567D3CC565E815F40CF1C6D9BEA5
      4956EA4917932F83555B2B2837571D11B45E721F7E7AFFEEFD77AFBF71F6E7F3
      67650C8FA85FD94C8AAB857226A22C856C3D5E0553BEC6752B3055D7BF8695BA
      343E24B75D0ACFB06ED7B2D338ABC1BC85177796332B27B9FD944EA3D8D72FDA
      D832FBD3DD919EE871A4165966AC05FB9FAFA38EB42C2E08009D772CBE018FB2
      8A34BB93DAE508B3897499A6053DE6B6340F5E49E59C054484A505114126D65D
      ED5D7D88EDB72F93B49B6CED3DC4C67CE446044D86B61F20B78218AA8C646214
      71E5A0BA8511B5C35DE32A24C7F7A65C89DAAACF26F493F7DD1BD90CD94C7AE9
      CDC6945AA31CDF0B401D3B36F0C4CF9C16BC75FDBED020EB1CB49C93BF7C3CF9
      F4EEECE4FDC5E1E9D60FBCEF073EF57EE4B2D98C8142EE15855FF98424974ED8
      0BD927FBC6F1336D3E4724B84614B314E7AAC61B2B060EFEA6DA19825C8DA0F3
      C4A48064D8915F432EAF36F2728777BFA26D7CC72982B83A246109176B16DAF2
      EB494A9052092147C02AD0A6AE850A948DDDB073C43D0BE944E2848BF0778AD6
      D80D4C2F04358D39C431F87145C641E05451D60AC36494E6538B756BDAD31AAF
      7EA4D5B86277B1A0CD75AD1036C7FA7372826F491857532E8AE745494435AEFC
      C51D1798E67A183BBB5460441C3076CA2AD17CB4EF1C9D97102A9C136D5C6C7B
      E21258B94FD38475F68E0B240A207FFA4280184435D95536F84B02896F35272B
      9F97E354BA4C60F8B42D475AD4343F976DCCEAC369531341C164759A1DA56BAF
      8898A125C38BED77D82C58816BAD27B2C434B67C6F6EFC541E5D99C055421BB5
      3A059EC1C5DCFC4D5B6339997AC9977FFCEED3B178255A6543EA396418A981A9
      22549758CCD5B677482236D892D157C33CFDC6B37A33BBA40C593E7293609649
      8009AFD224B40503811680158B3326665FF3667B715543E668E7C7B12020B066
      30A82BE5DA1BF92536F1473A4BCC9CC3A3EF3F39BF4887BFB6F71B6D9313297C
      FFA858209656E839EE34DF9D733D2468FF61C2FA846B23E5066398E23507CE77
      89C4348D193E9157DA0C250234E26A0CEC4E5927239EA2FDB9086271A42A19FE
      62F1F3EADA0AFBDB341B46FB5F2582C951D8242E23B013DAF702CB9869766089
      B988BE524C22C0365220CA29028530C683F8F032B29AD63A568D54AB1757B5D8
      8BB502C5B88B55E3423D32A1A4748DF5AFA5E3BE288D61722D70093BD2E1C679
      F1AE6AEEC851F00BE713EBEDD23C71A2B491C54E42CCB226D3082EA21AA56CDE
      E64E352B898F09E0B253D28D712A85D2B0A7497A879C1D6050C278DF984B236D
      3E24E2B3232E7C1B0EA97C4C4232FC6270AD707C0594E64A45C2C28C56539655
      6E3DC3C77986EEF6F47C9933F8B47B7A3E7FF61DC5C1CE2DAAD2EE7767E7177B
      B2FD68B732C092554EEB554B9E0E2963577ACAA782739366EF8EF739302DA649
      03C5D9A1496C325AEE93BE14A3BAC0B9E3CA0DA112BBCDE2D22AE72D9D16CACD
      5BF1F2A5E2E59B9E043EE503AD8B6AD8D59CE4709DE8DA7B47EAAF69C694B516
      861A26D33B73A452090905EC7BD0A1BAC969C31B4D0E1AB1FD6804AB76AB32BF
      8CA7DB075B0CA7250AF3A977A51598447BEA142719C584E8F8A54C0781B283D1
      CAAE031BF64F6E956B60E8D8492AC7254F707E829CF9AB861C57C490A68A7A68
      356F9614372A6046A83EEC32CDEE9C9DEF9308CE190553CED2C8F96EBDDDF3FC
      593A9BECD8DE937065026DF02AD90C6A1E619E3FE39625B68B2828612D3907FA
      E33D998CC2FC14A3BDD4D34AFC893E1BCBD92A585F311245D9B9B979A428509C
      272475A4A5EA4735BD025F244D2CAB3BC46A70A6C1CE6C4C40BDE31DC744F2C9
      73E6C896E4D39992103AA8363E00F7E168DE8CCF17C310BBB3DC60B43303EFD7
      91FAC6D89FA64E7E9D4CF6E948C3D492EE3B07077BA67626ACA61A715C71E7BC
      8850ECEC17BFBD4FC75A0EB776DED101CEB41CE44EF308AC224A4BA0D9CF249B
      47CA196CADADAD044AE33809E998CE00D3346FA29C421B53066DA91F43D689B7
      594AF91316A518C66A9979C5E51945DB1689432519C9130AB99A73A6F5815D65
      1DCE5D4EF212EAEE3113996336E30A081FF2EB9A4762D8823A232C9FE9AD56D7
      E509A6A6C496241F19252B49531590B070481F15A769CD9BB851B971C158C9BD
      B3CD9D37B36458092E43C5CA612E890D6717DB3077FE36A3B30AE50492498DCF
      12831D06191E6A81E3276B6EEFC039E4D61E1C6FBD5A8F83494DD5395E1A4178
      9946E9981945B4CD7822E7CDDD0E3374510568A2AE659FD5A266AE0438CACAFB
      A9E5539153D55C28A7B352F8D1018B9A4C86742C6E5A38498A92AD4A09932C9C
      8DC8840E1B19EA5F0CE473857196DEDA6019BB714E4E799945822D8717A95492
      FADE715E162EADE145CB89D96D5ED60E72B1800DB109482B67950AA0DC488FD2
      03E73C2DD230C9A4D12A4F388C019B340FB36402A14CD8DC697ADD40B141478C
      77544171E9BC7B71C365B797299F6FA880B4D09FB745815F16A3D9563A2D89D1
      3CEDBE56F3471A2481A55236AA249F4112341156EDAD3D18E6A27DB2FD3E52CA
      0FA7BA1DA5E3C8A04571CF15A8CF88E72CC5D94D0CD048FC8515E92EBB1522D4
      58E40F1594E9D36B3A57C38E2A4FDB2A797AF7DD4A3105F7783125F5FB9500E2
      7002B8720EA63AF7489F163D51B8B2A54867C9691B4C2854417CC23119959B34
      950264D4D935DE997CB6DE0DE1648789CACD099F29FF2F405C1BB8201FAD899D
      71EA3CF7E9AAD61113ED25125AD2D734732A23A297308A6B685AD58694CE876E
      7780BFC952F97AC752F785EC3C590D397BEE6030E8F46DD3DD7FFCE7AFFFF22B
      E51BE9484D95D36D7941ABD3F2DA5EABD5F2F15F5F12A75CE8113D88742B0EE2
      3836C95461CBE57F3BF27B37F03A7EECEB9EE777E9EF6EDCF57A835ECBEFF63A
      DDC8D5BDBE1FF9A10A07ED30F074D8E9B4DA2D5CD4F3FA71D8EFE8AE1B79EAF9
      B34118B87879DFEDEA41DF0D7B7D1DF694DB0BC356D81F0C5CAFED8783A81FB8
      AAD7ED62303D2F8CDCAEE7B9AAEFB6DABE1FBA6134E874E2DE407702DDE9B941
      D48E5BBDA01B7606FD41A87A9E5271EC7AAE8BD7E8A01D78BD6EA4BA51DCE979
      713450D1F3675DBF3FE8B7DBAADDEF847E5B755BF1A01F7B810A7410BAFD4EAF
      DFEBB73C3C6CA0BAAEEAF602ED638E1847E076A2BE1EB47A6E3B1EB49417B9B1
      EAF45B6E1874BA3DDFF5FBAD380239751861E8ED286CF77580A7B43B7DDD0907
      5E27EAE96EAB13F8CF9F05AD76D4ED7722AD75371E800C9E7607AD0063E8C41D
      DFD32AF494D769F5FB9DA013B606209C0E553F1E78A04DDBC7DCF06B30707B71
      D7D5CA73F116D50EA3EE2004A5E2417B10B474BFABFD2E96A5DDE9AA7EA4DD56
      ECB6827ED876C34ED07AFE8C88DD8DC3D8874E6FE305DA0FE24E30D0FD01861F
      447E77E087411861BE81DBD7BDB0E37775186218ED386E7B7E2BEE7662DD6F77
      A24E186218412F165E89897BC02F0FF119560334503D3C563E6CC1B469F30F81
      E1B4B8E782C7C25EC78DC157E6E73E3152EC2BE22C8CBFA7E37E378840C6762F
      02BD31B336B80A2B11ABEEA0E57568797A1116A4EDF67BB1DF77DD7610812334
      FEF6E2E7CF422C6B4B0501E80C72EB38EEA941278AB5D2FD201EE8F6C0D3441D
      7FA0946AF96147BB1E182F0CFCBE6EF7FC4E04E68CC1C19057CA533DB7DBC270
      C03CADBE8FF7E21D013170D86D456DD50199A24EBB1DA8AED70FFC4E6BD06DBB
      5885B8DF8F061E5DE52AEDB9BE17B5B1C2ADC8C580BA51D0F17CD7F57AB1EA0D
      DABD76378E7AE0BC3E0D4D8366D8199DB8DBF6B1B17A9D1EA6A2FBB1EA878338
      06D780466138D05E1CB6717FEC86BAEB61517C6C9981E7853EBEF23102D5C6BE
      8A75A7DB0922F074DFEF2A15796D1DB5826E008E8BFC3892B5A9B3B27ED01B0C
      FCB6DF3712A3AF0A49C27F2039F0064889AE1BCBCFCF9F557FA39FBD080FD0F8
      AF07B9E25AA982C9845ED4C2DABB2455B0A6BD48B57BBD410BD2008B11804DBD
      AE8F4D1F064A07418C91799D41D8565E1BF205141DC4E06BEC40DDE9773ABD50
      47E0636C99E0F933CC073F6021C356AF15F595DF85C8D1FD3E31750FF246F5B0
      6EFD4879FD7688850AFD50E3996D6C303DE8F5DBA078E0F5B1D1A2D81B802D3B
      5D8C0DA2023C08CE88826E14B9ADC80FBA10555DB7ADB11651D4D5D8BF1E1805
      A20E23E8757BBA8FD584F00697E14B4C040BDA723BFD4DE8EFE976ECB5A21E73
      367D15B47905DAFE2AFACBCFCF9F95BF75DA96E63A844489FBB45BFCB6176862
      A44EDCEA4711845B10F8DAC3DB82200CDB035FE3FA4180997AA1E7694FF5B58F
      3DE063CD7A3E441976670F921573F268ABB8611BFF461D5CDE81448C62F001F6
      0976195E8E3D1C835C0136833FE876426CC6A8857B3BDDC100023DEC45115480
      0B59E762F7B5BB90AE3AC63306906111A44A1C465E7FD0537114B66235E875FB
      1ED61C4403770F063D577706D8C25D85EDD80E061D1F2B8B09C6B41B7B0A5B58
      F95038ED10DCD4F1BCEEA0EF0D889B5C485B0C278A5A71270EFAFDB0E7F7FAD0
      131D3FEC63BD0724A15BCA6F47BD564747810B393DC01B5AA1EA804EEE00E46B
      F5633D80B8C160C094AED61D7FD06BB771850FB2B6C10791EBBB113E532AECB6
      5BD0A39015905A5EDF25B93580D868D3F60ADC165814920B8B02EDD652F418EC
      742F84280BFD5EA4A1DDFCA00D6A428168172AC4F3A00EFB3DEC0768710CBCE3
      FB30B47CA8DDBE6E418C7574D073A11BFBAAEDB6742FEE783AEAFA5DB0920EB5
      4B7ACA7523A8F63E346414FBAE82E01D747B610C7905550FB519E375E017129B
      31C4ED00325163230EA22E8C05A8395010778660752C53E42B880A15D39C5A1D
      AFADC0100A661F4CAC408531B6CDA0D7EB74142C10F04BDC56606930D2001604
      F658C70D62ED1245C22E7456DCF749650F3C2C79804FA1167418F77A5843282E
      2F806056710FA64B0B1B0BE60266839520F609BB305DB0CBA123A1427AA0EC00
      160A3E802874FBFD414B9302E9EB6E4F45713FC4FED5FEA0D51A907CF7B0FE61
      07B743CE83A940CA7EB7EF423BF5C14E810765E483C1C0DA3ED60B0224EC696C
      7E6C426F005240E1BB3072629FB80882A0DB0ABB1DADA001DAFDE7CFDA1D8C24
      C67282B001B6575F75C9CEA04519E841670055D0C7E3E36E0F1CE582E210DFD0
      7D90D67DB7DD837020B6C65E6BC7A01288E493C00717630C2D5A0FB7E5C75D1D
      8372906120810E34344F1FABE1F5A0FAC2E7CF3A21A967285F28FFC80333437E
      F561A7A981AFE22E140AC61E6B6C36A50631D824C61E84688D7133549007CB30
      0E35764A0FCC120574CB40F5DB10B46E97F4241E1AC37FEDC76DBC847FEBC00E
      C25F505C50165DEC056C1EE85D98A2D8085819B71B856082081BA44D462028D5
      EAF73CD01D1218638E2099A117C0E730EFA03B41040FBA360C610EB4A0D4BBB8
      CC0F68A2ADB6D726AB15EC0CD50A99D9825504954C06698461C1EE8A21ACC007
      FD10F650D886A1896743A84080F643087ABF1FF4617104586E1859180BCCBB3E
      181BC387C26D77A125A2C803ED60F67A300962179B07520C32AA05D37800A1D2
      0D630523D087F4210BAEAF613EF6151E14BA504C6DD862A10779D00F5AB04B83
      3EA4730F0AC66D2958B92EACA1D08566C1353EEEC17242D5637421E6AEBA0AD6
      413480E8C1E2BBB0C1DB185A0879DA86DCEB435376DB830EE925D58772E979AE
      179110ED630FC280ED803F42C86A4C22EA0C2013C9CC858470FB0AEF8240EDD1
      83BDD085D10205894FB111556B80A5C0AA83E7C15D3D5069D0C1D83CD86F9D3E
      58CD552444C174906F30B460FE76A3BED751D8F0D022514BE34ACC1942CB85C4
      82050A750753198A1AF6413B2687018693A6FDCCEC4E5B07960CFE03BF63CC50
      10107911AC81560FD669E4451867D477B133BD41AC3419261EA453B70BEF2080
      AA84150BCEE8C046D48AA4990F61076B0E821AE61BCCF041ABADF1BCD8EB602F
      80426D05BD1C6091603B423AE247C86048B8180218B2AC0B76F0BAD8951E6D35
      E806EC994883E3433F0E3B0ACB1880CFB5DB81C88AA16FC01D1836068F5D1A05
      7E37E8606F40E4698D0DE3FA11B6564C9E07314D8C1168DDC26FB09B219C45FA
      42764340EB2E260175089D150F62D84518502FC4B3DB10366E80E761EF78CAEF
      61CD5AD0790398EBA41060144274B502DD523D380F1DBF0DEB3D82E703BE81F0
      C26EC37363B7DDC10668F57C4824AC5D00690D3E1E40CD6075B16D3B74252E85
      28C240F1443F86FB8BADA3F036B84258BF48E9810F090EDD3B804707F101C72B
      86F31390D686C080C1850D08F508BEED06E434F5609A0C5C4C0E5628764AAFE5
      417F433345C100B60F88D3C106F25A21594FD84C90B1B090A146209DE0C960C7
      432F41C883155B301B4079BC3D00C7465DD844C4AA10B91030F0B2C89B24D709
      964C0FCEE500965C1B325F75316FCC63401A2988C2109679A8C96B83A90383C7
      F75BBE6A77C1A2300320B8BB6494C226824E860E850050D0EDD8EFDD0E4CF42E
      F6273624D81F5611860C43C307037A5ECB8775DA85DE81170A63BB1F61E1E037
      E2D32E1413C43C5439D429F61A34391ED3E9620431BC5818C7B8129E5D5FC14A
      C20C4129100FC387290082A80063A3BB20067DD8503DBC0E0C09590F4DA01596
      B30DA540DE400FBB2A8498F67C6C56EDC7713F86BE819B8BDFA04FE1D180BAA0
      9E3BE82818E211F98DE00AD846210B64183BA032DC44C84C0FA6AAA2BDE97669
      F7847D6C241FB641074B057DA3E102616DF095F6B1A760C8412E757B51479190
      8463070FA7476CA306786C1F6A84ACEB1EEC71B023E46D0FCE7B8F6C0CAC0279
      B41035A401B1FB5D38CC0A6382D6E8B43D3C57C3FE700710AB3E8C1528700863
      1839D8DE70CE6050F6B15620F120767B219C1F0F7AB9DD1E442D109D5C5DA833
      8C85E6ACBBD0B31029836E0842C1D400B95B610B23801471073047B1CCEDAED7
      F1E0C9C3C7C612615D6093F9A1221B0D3E59847D0E5B0F9C46DE39447E049544
      74F7E0DAC1CF18743AF00502E83BE582B5E09D404841B807ED160C16E8F82E44
      518475087AD81A14A100C93C786D11592F2D88E5410CCFA80B69879141A6A876
      006F157603C9875610BAB0953C378011086D15F57A3097219CE1F342E260C906
      14C2216B25E84140B6C1BED034D0331C19814702FAC393824788C9612D319098
      264E76225E090502BFD28FFAB05DE12D79B81AF68D0BA3012BE07B7068DB21C8
      0319082B193644AF07F9810F7CAC3DCC9B105E6A17FC0B970C8A1FEB825D0EFD
      AA6998B0E3E084B47B8390E71F05D04714D8020D22527111381142388434874B
      0029018EC548C3760BFE4ED08A317177D0836CEE687201C98A82768B3436304C
      0EDA6BF079611CF903A841F00EF61F2CB64077E126C26CA5A003917B40ACAD21
      BDB16CF09D68D3C0EF893C1A01F80013F4A118B0622AC65AC0A080D9032B0D42
      18C41F444A75630DD1D35178720FFB8BFC6A70111C7C901C5A41C166F289C258
      A32E044700B9D4C316851B8FCF2064C0C3E006CC9F940CD8120CE543CC8630A4
      6003C36F845D030D8BFB60F2402D6104A0615D6FB105A135680D68B4E2A507E2
      69BABD87BDC5323A03DDB8D6739F8FDFB00F4F5609360676B4DBA37049EC4382
      048A3C1EF053D4EFE3226C1D7294B4D78163480E12DCE2367C91086E2279347D
      9857106590077A3080711B0C7AB0010730CEB0A9220DC184BD0C6E8036C205B0
      ED07F031A0A7FAB03A6103C2118706E80FA24107AA200069FA10003EE4AB8EDA
      3061067078DDBE470E9907D7076FEBC00CEF61D3B950A830C161A3C02AF762D8
      48D850703015AC29783A9EEBAA8E82190FDF2D88A0BCE08860D742B651580EE6
      2EEC5470B18F05807E87166963F85DB81414B501196087F5073EF8136A12FE17
      1618E62A44094C4692518AC20F21B6198C39453BDD0BE1B174C14EE070983DB2
      7273AB0FDDEE46541ABB79C4F7A13FD56830ACB495F1E07563A068E043B1C065
      7F3A2DB9669E134B4E5BF7CE7571AA657FB055DC8776453586B27C27AC1BD5BA
      E8CDB23FD049C5A8B00A4BC6B52CB2B36E24EB24C3D29160FB3E449F6A4CB7BE
      CCE091765B2505BAF25FD744C5C2B0A5EC57FF78FE8C0E3BC27498667948471E
      2383E305AF32364F869CA637F53A10ADE05EF8542ED105EE9F0BAF181BD827AE
      F6F02D5C4BFAB60B75EFC1EBECF4E90AF8FB1E8F98FE0EE909A02BAEEA0D88EB
      F12C98F5B03B159D2C400C4056F7E03E9017039BA22563C05EE9E03BF2E7E000
      F43CFCAF050B2B762948D13194C19E877314F7784CE63EDF271AD2779EF9D625
      49013FCBC5673D1933CF12865C07BB04AE614CD7FB03DAA13C43DCD19137C3AC
      C1CC694E1E4C2BF9CCF303F98CAF738BEBDCE23AB7B88E3FC3B369CC7C1E649E
      31F749790D73277DE6DEBBEAFE933AF7AEE9DCBBC6BB778D77EF9AEEBD6BBAF7
      AEF1EF5DE3F3357D509C281AC83AD9DFF83BAC841F7AF3572C7C86EBC00B8627
      E92C7B3CCDA777439DFF3ACCA37C9A8CD4E74EAF4BBF0CD3F05A47918E5BFC95
      1E25575CA0603F998D090384729AED277F93B440FBEB244BD22C99DEE1F7C1E0
      3FCB474A2B6FA77247DBA95EDF72CA6B5BCE7B8669FFF3CAAB0773575F693934
      6DFFF9F9B3F961CB5DE5A0DBAB07B0FC91EE9FBFF2033B5FFB81DED79F74F76B
      8FD1FFDA0FEC7DFD49F7BFF61807B51E68EF4AB0C53ED7E6E0F9BBEA31E9FC3D
      F5F870FE1EEF11F7741F35A37A0C337F4FEF11F7D45BF4F97B06356764B9A333
      CF1ED334C4327FE103EAADF8030FE87CF924EA71C3030FA827661E7880FFE593
      A8C7340F3CA01E073DF080CDC4842846E7DD98105D36DC5A719A4EC7E954B299
      377AAB1AE33E035CBCE9BD240E75B6D12D3450DCF218C16184EFE36579A73BF7
      D450713BF48D863FE56A843476E2E47296E97CC389E8F18D1EA69302A174A377
      1737677A3ACB361B77C11F4591C46399A47CC06653E7447A0106D8E8D51375F9
      A8FB60D77EC184EDDDBC25369B68C1226A36BD22BE4BF466EB3C5261966EC695
      A9DA6877D8FB4E937CD3D9D12DCE9BD970A83713157CDFFBCD9791EFDBCC08E2
      5BEA2AC1B99B363382F8967A8A6E09F51E332973E7A3E666EE7DC414CD9D8F98
      A9ACF763666AEE7CD44CCDBD8F98A9B9B3BBDA396DCFFBB217C974B89960391A
      A6543AB7E1BCCE93CBB122D0FA8D2C92F9671C4B463027FA5F666A72E5BC4DC7
      9B6DE2376974E75C6C6A2514773DCEB4E195A1DE0BC978B619ADE7EE7C0C1716
      F76EE651CDDF5BD7895F7EF766BBEECCF4E0FCBE34CC96B3F1027BCD82E9C69C
      7CAE8633B109369CE0B19A6EF6A69281DE324A8A61A32F7FC4863CF19E2C82EF
      8D9EDD6CCEE5FB377B6579DF662CB8B8E71EFD5A73FBA682F80DFDB0B9A8F8FE
      8EC0CF92F1F54677BD4D090B5247F3772F657CD79DE7E129D5DB9BB92DBF615E
      E09F8C26572A4F3633E88ED370C67D39CED464A31B3F52B1CBE6543C7939A2EE
      D5A5D2D86CEDBEBF383B752ED209D9B004B5B7D90AD2CD6FA87274F4A8FB8D13
      BCFBB30EF6367FF1212CE7F1DDE831133E7C8447C6371E251B8A33B92B8D1E71
      D77181A5FF9829FEA0EF825465D1E6EFFD082F8A37C7543FE2EE734595839BDF
      47B589B7D8841BC70BF8EE9F5496902BF65847379F057FD5E1663BEF7D2A3ED5
      26F77C906267D1FB9B0689E76EDE4CC6CFDDBAA17621F0DDB4229956C4C02ED8
      152680A315D3AA08BA5053B77058DFC543975B2E8BF43E9FA8D0FABDF6227F5E
      689F3274C0F955E92017172E9A5E7461B182C555EE92AB2AB32AAEEB2C186351
      321BD9F79AC07071ADF7D0B5EEFCB5DD65D71A7E99BBD05F79E1C2137BCB2EA4
      292D3EB1BFF2427771F683959776E69ED99B5F9D63955DDFA7796FC16DA2C376
      EAFBB56C157BEEF26BEF3FB4B3FC425ECBBA0C04251392326F2FCE7F152F9537
      D462AA15973FCC5B2B6E7A98C956DCF400B72DCE7DD57EFEA46F92DCC65697C7
      62BD85E9E715CFF401FB6D9EC9FE63961AE5BBFC25F3CBF86E3CD5E35C57EEAA
      B37156AEF7037B6805651FD84C2BEE78604F2DBF63D5E65A71F5C3BB6CD5D41F
      DA702B5EF4C0CE5B31F51A5BD0AD27CC575CBE6E03DE1370F5B6A0FB982D585F
      E0AFB8A30603DF9B4F0D067637666077630676376260F7310CBC38F53A0CEC6E
      CCC0EEC60CDCD98C813B9B3170E7710CDC790C03773666E0CEC60C7C6F3E3518
      B8B33103773666E07AE6CD8AABEB31F0E2D4EB3070676306EE6CCCC0DE660CEC
      6DC6C0DEE318D87B0C037B1B33B0B73103DF9B4F0D06F63666606F6306F63662
      60EF310CBC38F53A0CEC6DCCC0DEC60CDCDD8C81BB9B3170F7710CDC7D0C0377
      3766E0EEC60C7C6F3E3518B8BB3103773766E0EE460CDC7D0C032F4EBD0E0377
      3766E0EEC60CEC6FC6C0FE660CEC3F8E81FDC730B0BF3103FB1B33F0BDF9D460
      607F6306F63766607F2306F61FC3C08B53AFC3C0FEC60CEC3F10BA9BA7031D3A
      0EF5FC89CA729F7F7E7ED68B2F6E7CE0F4A673FF9C73487D77AA2941CB6F7497
      BEB3CE9DF3447A93A6D71BA409144F99E7CB3749304C528E8DDC7D497AF4627C
      F6C351719E59BDCC5B7A0CC5C1DC7927DD73575E38EF0C799D9517CE1B9D9EB7
      F2C24513C2EBAEBC745E8C7AF3DB89D955AE6381377FADBFEADAF6B2AB7BABAE
      5E987E7FD5750BB31FACBA6E71F2DD9573EAB2BC987B6CB7BDEA62BFD8C5F337
      B8AB6EE82DBF612DD99607791EA0DFAAD8D303A45CF18ED5345D7EC33AD2AEB8
      AB068D57CDA90EB9574CAE2EDDDD4DE95E9B8157C5586AD0DD7D14DDDD47D3DD
      DD98C9574EAE2EDD3B9BD2BDB329DD6B4B9055B184BA74EF3C9AEE9D47D3BDF3
      386EBFA72AD6D3DDDB94EEDEA674F71EC5EDF704FF0674F71E4D77EF7174EF6E
      CAED8B5E550DBA7737A57BF75174EF3E9ADB17E7B409DDBB8FA3BBBF29DDFD4D
      B97DD17BA84177FF5174F71F4D77FFD1DC7E6F72F374678FA8B61158B9FA411D
      5AB9EE41115EB9EE410952B9CE98800F0A8ECAE5F58CC0CA0DF58CC0FB64AB65
      0456E9B7E286D5845C6935AEA6692D23F01E716B19814B69BCE2CE1AC45E39B9
      BA747FD0085C46F7DA0CBCE286F5545F34ACEAD2FD4123F041BA3F68043E4877
      F771DCBE686FD5A0FB8346E032BAD796202B4CB29A54BF673A6E40F7078DC007
      E9FEA011B89AEEDEA6DC7ECF6A5C4FF7078DC06574DF4C84AFB86B03AADF331F
      37A0FB8346E06ABA3F68042EA37B77536EBF6735AEA7FB8346E04ABA3F68043E
      48F7EEA3B9FDDEE4EAD2FD41237019DD1F340297D1DDDF94DB170DABBA747FD0
      087C90EE0F1A810FD27D335C8233DCB2791AF6F94865D34756397CAFF2ABA9DA
      ACC0F3C771A6F37448CD3EEC80FFC19D1AA849433EA54E28AD36631DB504DFA9
      D56A1B7CA6E7CF3C827B6744A08EEBEA6EC76B77FBDDBE177961975093DABE27
      584A1D9F708D96FEF1E549512B8CDB6DDD52EDA0DD56BABD1ADD49FE7408BF18
      8F8C751C33DAD32A64AAF6C2BF0B5FD0FD71813A76FFF7E2F3DFF10FA169FEF7
      FDB39DFD7FDF3F4B661F997FF5B71DC91FF167BBF6FF7DFF6C67FFF09F2E6C0D
      3F96FF7A9E981E1EAC105FCBEF3D7CD01BACB3121EFF87912EBBABF57E2BF455
      34E8F7076EDC8E089CDAEF62A45E6BE077DC6E5B77573D376A45DEF367BE3F18
      B4C970F25AED5516C753F9B392028FFCF3FCD9D71CDDB7F8F33529D0BCD9D39F
      AF458147CCDEFA1EE6CF3FFEF1FF00CA860DBB}
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
