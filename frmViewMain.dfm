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
      789CECBD6B77DB489226FCDDE7F83FE0D5EC1E53D334CD9B44A97A6A666DD9AE
      F2B62FB596AB6A668B75F6804092440904D8485014BB8EFFFB1B97CC44022404
      D09675E941CF944582402233323322322E4FFC394ED2696FECFA621ABAD1ACD7
      ED1F8DDD4806F48FB79CF5FA47FDF1CAE33BA6DD31FF2B53399FFA136F3EE81D
      758FF86B18F3D763FE3A0F725F27013D8BEF18744F7AFAF354C01B4FC6E95C2C
      84F9CD7C2BFEEAC9EE9FE3691CA5E924840FDD3134EB07CE789AC40B371A4FBD
      B99B4891C2F565F2F7FE9FE37F1D2FDD2896C2E9F6E1FF8EBB83EE517708FFF5
      E1D3F0F3A76021A4F35EAC9D8FF8F85F3F43937DD3E422F645526CB3976F7304
      ED9C52DBD8E610DA3C8B574920126CF5AF9F1F3F821607259DEC6F771248D985
      01C37F23E82C363AFA7CBE594CE290FAD6CBC61B05E1F50D6DFDEFF3AF4134F3
      E13FC96D0D4BBAD51B1CEFA65EA1CDCF3FBD83C6DE063FE37D53374C9DF113B7
      377E72D495FD0FDEEAB9F8ACC75FF6A69DB384B3C3B384B3D5478ABA8B4912B8
      CE3B379D53D70723D3A05C07525EDFE094A6A64F4DEB06C3005AA4B686833DE6
      7BC7FF60BE231987AE54831D0EEBF76D5773E762160BE7E737DCB9A37DE66857
      73FF4B4F12B51742237FC4095010B6E54DEF1D1ABE3FB1DED0BB851506EF9C07
      D63BFBFB2D8DC1EEA5E1BC0D66F3548D6962B75FB699BF82E3C0AC04916E7FAF
      BDB2C7AC646FD86B4D7DD5AC64EF3CBEA10DABE7236B7974F3F3313C2E63D883
      136ED5293CE69CBDE227CB7AD3C779DDFDE426D19CE3B46C628E7B250FFF9008
      71416F3E2ADBCDBDE37EC9C39F56093F5ABA4D47A392475B3F8A4922D687FC7C
      BFF4F93272B59E27EE24F00ED5C88FCA3655EFE4B8A48517B0EE028FDF5F2AC8
      8E0765EFFF251069E4C245C163383E2E93027ACE7B8E25D8F57C1F8F4A1F5313
      5E78CC4CF6F169D9937AB6F34F66333DEA963FD9DFF1A49EE651AFF43935CFF9
      E772733C2AD58AF424171ECE4FF0A854C8EA19CE3F6ECDEE68583EDCC1AE3717
      A7B67772723D8B70343F737E1532853754EA3327D50CC2D659F46A199C54B387
      FC739B443D58CD1A720F66AB65705ACD18728FD272E1619E566FCBDCA3D6AC0D
      4EAB3765EED9AD691BF6CA64864D6416D69AFBF6CAF4429BBEEA918CEDF64E4B
      9EB289CB4F65741DF6BBA54FF50B4FE91D38ECF7CA9E319C563F93DB7DC37E99
      5693B158F3607EE70DFB83B247AD49E447ADF91BF6CBD4587BFED41BB7A66E54
      8B9BB2DA9C89CE5ABC543F944DDFA8162755CF591378528B8FAAE7CC149ED4E2
      64EA299BA027B5F8987A304F521EE749F57ED0670743D393EA0D913DB3D143AC
      DE0FE6218B9EA7D51BC23C963199E169F59E308FE537C569F5A6C89E34BB829E
      ACDE13E6497B0E4FAB3745F6C61D53785A2589FE5751146D9FDACA9AA8D44D73
      AD94C9933A7AAADD50AF5477ACA1B3E61A2A55222BF5D75C33A522AB862EBB3D
      BA52215643B32DB6557AECAAA3E3E65A2AD33EEAEABB5B07F57E8529601F0DA9
      701EEF9FD496E274E4D6AB35D7461943DA16EBAA0DB356ED6606A59C664BCE73
      33D94ACD3553CA76B6043F37A3D769AE91520EB4A509702385559A6BAB942B6D
      2907AA2D7B8DE65A3AAAAD2B704BD60ACDB55326AAB69507D5A3EDF5691B5D06
      5FCCF472AD7C21D32B3433FC6296B735AEE19733BD5C335FC3F48A6D7D0DCBDB
      1EE05731BD5C4B5FCBF40A76B6E1972D292D22B276BE7C51D9CD94DB60EAC9D1
      ACA12F5C525B032BB7C9D45B54B9B6BE5E8E666D7DF992DA1EE30D2C2ADBB47A
      7CE372346BBABE1C35EB34F77C7D19AAD7A7FDF8A8BEECCC49CDAC81FA52335B
      8FB906EA4BCCDC3ACCB5515F52166564D6467D19995B77B936EACBC7ADF5661B
      BF475F2317B356BEE630603774F2354C2CD7D057C9C5AC99AF3E0CE45AFB4A26
      966BEB6BE562D6D2D7B2301AA8178771924EC2BF8E13E177C7339895A83B9E84
      2BD1DDBED43F3AB22FC2D7EB2E7303F86D471385CB857B4B9A28792137D1EB9F
      D817E1EB7597BB7F7DFC082FE3F71D8D142E77F317B346765E368D9CF6D50FF0
      817E38EDD7A2731727FB5F314CC29B2F9155F4FB638CB018BBCAA586F115E60B
      8662A82F478E7E70E92E1D18E1DF43671C06DD7102FF49B707624A86FDA353F8
      77B10AD3DE781DF85E1A2EDD64BC4EDC253CE7C2E5B12B976EB89CBBF8215A2D
      4050B9AB341EBBFE1F2B9926A8B74383D0D710FF095277D9753E8FA3F8EFB0EA
      E2459C0AE7CFB14C37A1907321D23F6FAF13E3240D8116534FF670F0EEB40BFF
      21F15C1DDE021D4913BEA5AB09AB234FACA013227615ADC7DE2C097C7A2C5A5A
      2D444B6CC319CB485CA5F016F9F7699C2C5C10F57299047112A49BAEF31E2F61
      6807F453F6F2249AF4BA4428FC778283EEC137FEBB17A9E2550AC411A1B81461
      B736E1C6EE44530E54E5DD94834E4FC6F4FB2EEA5D807E03DA0E9C05998E5D4D
      C3EE7EF49BB852F871D455A484AE49E8F345EF68274D4F1D5C74890CFCDEF064
      30EA9D749DB97031EAC5E9293AF7BF3D9D7B5F4267A0D4B574464A96AED21BA2
      6E5F53F7785FEAF6157507DF9EBAFD2FA16E7F743D75E1F76F4EDD81A6EE685F
      EA0E5816C098A02DD7F78334B81470BB148B601EF8BE88E0CB2A828F6205AFB4
      1AED392F99B2CE4F6EE2CE80D273E7751CA5D4208C3D95BD1EFC93C46B7F9C26
      D354FE1AF8E9FCC500BE2CE14561AF7BA23E26D9C769A87F9FA6E6D3C47C4AF0
      933759BAC0D6E1C3943F4C60E820E1F86FBA590AB84B5E8A2405CD063E4D123F
      D17F43F577A2FE26EAAF3F0BCD277D6DAEFE5E3A55220646FB4D84CCBD1031BD
      DE35CBE1F1239634CE2777120AB3968EECB554C6FCF3239950CC25F27CC3DFB3
      758E8B931738FE8DBD8BDC4ADCB1BC7FD4ACD93903ADD5F4EBB8BA5FF8DA1DFD
      82CBC8848AFDE9EFD99F7EBE3FA3EAFEF4473BFB8397B77A33D8B33703DD1BD2
      124EBE0D83DD7BB10FAF59ECC31BE7A5D6AC1A4DE0E45A065820A6DA00AD5FC5
      E4D04CEC69E9C406D8C1FCB882C2546E33F07E77FBBDAF16406B1948FDCE7EB7
      F49DD33E11B65B144F18924C9773AFAF3DF21F3FBD7BEB9CC53EED7BD9CFAB99
      668DA028B83AED1DC3BFBD93411FFEF447B0CBD3ABC1F1F110FE0C8F4E80775F
      1D0D4FF196E3610F6F190D3036FBEAA43F1CF2D3780B2CC51135D33D3DC59B7A
      BD53141C577020EAE36DBDC16848F70D8F8F8E6F78692A0A968B7AFAB57C71F6
      F5E2EC7F9D1AA5B5D47E7FEF99FA2911BCB052E19B45D3DF6FD19825B39319E6
      B873AE7355FDC9B1C5FEA0BC5385EEE4FA901D7FB65EB80C9F5E98E687759B2F
      0EF2FA17787FFD4C6F080399A6280EFFA48FFC5D2C96A19B0A78E2E8E4E8E464
      74D43FE19F49F11CD3BFD1D4EB9A4F91FAF887673EE84BD3380CE3B5FA225317
      141D5083F8DBD2F584FA05942111A5DD3FF95B0AAB67FCA4DB87FFBA1D2405BF
      68B5988844C24538C46CD102C69F9BFBE0E9E01837C90896FA1F9E1A27EED63E
      6D1DF88306829B1DD525F43C828F30597B0CB1577788BB07D81B0EBB30787B8C
      780907897FEFCB28FB5F37CA3EB2557B8C74015E877F1DB2DFDD87510EBE7294
      27278551E2051C25FC2D99495CF8B73CCAE1D78D12FECD8F922EC0EBF0EF1EEB
      558FFC1B8DF2E8EB46391C14380F5D80D7E1DFAFDF957AF05F3BCAE3AF1B25A6
      11E4464917E075F8F79BF21E43803AA31C7DE5284705EE43177094A3E33BE2B0
      C4F10AA33CF9BA511E0F0BDC872EC00BF1AF1E25FA4C1C68123F07FE70747474
      74F279B7F6707A72720AFF37DC459EFE20A38FFE5C9740B567BE375E3D1D9CF6
      06CE7F14E90203C08C44C9415FEE57690C5F3394BD772D8C1DC615EF1A4FBF64
      3CA40DECA71EDCEA90CC44F54F774D149E577ADD92B155A805F77D6CD78D0C24
      7E41ADAB56061EC8D82A1480DDCADC0319DB1788FDFCC832ADE6DE8DED0B84FD
      7EB376134ACD978E6D7F117F632B724F81B6F7D8BE40B0F78F714E7BC725B2BD
      DF3B42C3D2A8FB2DE6FCBF956C2FEA718D6C6F64FB431E5B23DB1BD9DEC8F67B
      2DDB87BDEEE9603838EAED96ED706C3F3A3A1D34A2BD11ED8D686F447B23DA1B
      D1DE88F68722DA474747833EC8EFDDA27DD83B19748F06473BFDF98D6C6F647B
      23DB1BD9DEC8F646B637B2FDFEC9F66390DB83E393E3D16ED9FEB4D73F06D1DE
      3D3E6E4EEE8D746FA47B23DD1BE9DE48F746BA3F10E97E72DA1D1E1D9D1C0DCA
      A4FB71F7787432183447F746B837C2BD11EE8D706F847B23DC1F88703FED0D47
      A3A3A3D3D332E13E1C758F46DDC1E80662E51BE9DE48F746BA37D2FD018CAD91
      EE8D74FF6790EEC77078EF0FCBA5FBD149FFF468303C6DA47B23DD1BE9DE48F7
      46BA37D2BD91EE0F44BAF7B04C627F703A3A2E13EF70C7D1717F707CDC88F746
      BC37E2BD11EF8D786FC47B23DE1F8878EF7547C747BDE35EB72464BEDB3B199D
      F4468DDFBD11EE8D706F847B23DC1BE1DE08F70723DC4F8E8E7A83FE4949CC7C
      7F88A9EEC39B80A86B847B23DC1BE1DE08F70730B646B837C2FD9F41B80F47FD
      A3A3C1E8A43464FE68743418764F878D786FC47B23DE1BF1DE88F746BC37E2FD
      A188F7A393EE31C6C4F74BC4FBD1E0F8A477DC78DDAF9DE3EA813488F28D3C6F
      E4F93D1E5B23CF1B79FECF20CF8F87835EBF7FDA2F819DED7747DDA323B8A1F1
      B47FEDD66C4EEB8D746FA4FBC3185B23DD1BE9FE4F21DD47A73D42972D37C69F
      A2F83F6DCEEB8D786FC47B23DE1BF1DE88F746BC3F18F17E3A381E8D4EBA2587
      F7A7BDD3E1D170301A8C1AF1DE88F746BC37E2BD11EF8D786FC4FB4311EF27DD
      2EFEFFC9C967F8FD5FE96A7C299224F005B4118A3F7397D453A68E5CEE472F5E
      C148C6A1EC99AD5D78CE00D9EF7E4EFBFB0B4F65E17EBB1F1B943C66D2F7773F
      362C79CC640EEC7EECA8E4316306C159DEF5E0F1EE074DE19EDD4F8DCA5EA7D5
      B2DD8F9D943C66A67BF763A7BB1F3310C525F3DD2D9B701CDC51C9BB7ABDB2A1
      697751C97365CBC4E473963C57B24E0C8853C96325EBC4203B96CD77AF64A598
      02CB258F95AC932C2AA6E4B911EFE0445CA693D0F9F3E7E8228AD7D15FF9EA72
      B6A4ABF8611CC03FDD7190BA4B2455779CC07F7202FFB9980AABEFE895DCC16F
      91818F0DD28761B73BE89DF68110F8EDF8643080DD409F47FDD3D3D3C1097DEE
      0D71A10F4FD59793C108562334B658B8E9FCA784FFBE8EA374301C2F26C9C58B
      0038ABFA70BE82972FE4C20DC3D7890BBC77E10772F9524C7BE345F8CE4D6674
      6F623EF962FABF3DF86D9DB8CB37C46149195E0451FA3658C087C84D36F00997
      60104DE33FC7EE2A9DC789F32A847B642A92E73FC34FF152246E0A973FC16F70
      35725E45B35024B4DCBD4400575F8C3749BFDB3B192FE25E6FEC6F7AA3F13C39
      C137D144E26C6CDF7302F70CF11EDC6F30913288235CD5C2C7B7D3C289E2E9D2
      9D093918F297759CF8F2E4547FF5E66E228F800B77ADEF6B79743A1A1E719BD1
      E980A7EA6A11C28868F2E963CF99A7E9F2BB67CFA437170B5776168197C4329E
      A61D2F5E3C8BA7D3C013CFF07DCFFA30B1F469117E46057DE90241D6BDDE69F7
      983FCF6119C3F42E80EE2153183E25E6536A3E4DE8D36C0527C70496549A48E1
      A50E34B90EFC78EDA549389EA6D1E48FB12B22DF8FBD710AD37CB180552EBBFC
      791A27B040D2209A0109E3288623E844F87223A7B0647A40E8701347978BB06B
      FD0AA26FE6BBA90B6F4EA6D02A08D22885062FDD3080EB02E8D11BCB79BC86C3
      AC27E671E8A30086AD318BE2442C822BE17BD03A0A6858FA972288E8C92B7C0B
      3E061F6017C2D2E8C11C5CC181388D3722825189ABA59C2769049757305890F8
      DED88F60122239F1277095540018D20AC60D03937317363A2CB27FE0D8FDD982
      16327C98D38DB051E0F3A5F5196E0D667CB4C35F72DFE6D8B51E3D801FF07401
      FD71237F7C1988F505681C3DFA243D3714BD511776FC24F193B9707DF5711AC7
      E9582EC34DBA8E8248E0D498CFF374017B452E611061344F5DFF0F18D6782541
      7999B8613486FFE002BC640C8FC01B3CF8B6A62FF0214967C9388C6053C3C805
      34019FD609B2A6B18CDC651ACF80A7059127C2101A02756A1A8810B6AF0FCD8F
      E1C6E52AF2306ECD95816B5A417E92408F354F1947620D2DCA74033F4B78C92C
      89D7D0E7781AA4D8D108099E6E80EE64CF8862E86C048C2695E3A9C0CE09D0B8
      E0B2772597A403018BF0610ED7785DE09CBAA0094A1CCFD89DD2CD2B5897E178
      4E7720E152E09F6E0277A6DEA54BB44AA1B7F8D0344182E0854B37BD9A5C8D2F
      926899C848A463CF850D090B2E043A3AB87202D88F4B37050D4FB071E05FC76B
      58C8D3453A0D40554C9CFEF0A8FB19B73F70A25522D27912A7A0BC02E7066D74
      E17A6EEA81E2B8A40D07FD71C6B8EB7C47EF3F540DC555778C332F92CDA87B32
      C699571FA123F20A3F00F9A3B948043D8D8FE024A1C649AD89A90B4BDC8309A4
      0DEC90B489E027D07C7BF069E5250BBC800A317E6785178D2DCB68EE46339449
      517A95BA4E47892AF530CA137C1C3AFB45CF0FE013C8C72F7A76089FC2FA6F3E
      CC3F7D54FFCD13A7F5B9AC99632240ED6E5CD7D4881AAA3711D7B57372531D3A
      ADD3215CF23B5B02E19300AF0ADD2072D4DA1EFF1DF64CA6AAF4BAC8B1E9DF09
      6E7D60F32EFF058103AB189F40E5402D5F60284B375CCE5DFC0047ADF194EE1E
      C72B5AF07402EB8E81D7AD640AAC769EC26B223A5A693D0A1A746DC50634A334
      F4E6E3A9070217D8043C0D87B63E70351859AFDB3FA28EF30D5D1484F42BFE38
      E89EF4E8C354C07DA025C670973B1DF48E40EACE03EB8B3F315F8EC61EEE4A7A
      2E5A5A4D444B6C04A624D79D89EED1F024D78FF1643C1D0EC7787D0C64998F2F
      409100213A38061E28EDF18D51E3C80F58F50D9ECF758CFA0F576190BFCEDDF4
      8974803F3B307357AFFC2075069D41E7C879F1EAD3F3FF200D2371787A6F6F62
      7BFB4D6C192907C7BB4909B42352561210865F45C297D85FD44A9D859012F443
      67B54445E61629F735B452BB6098271493A93FBC110A7D9A0BC7DFA2D2DC95CE
      4480FECEE4F23B8A60D5CDC5B0522F8354385321FC09E8A18E3B81C5E3C0CA05
      05C249E781A4C5DBC62BEB200CE13D0EEA5D91E3CE903FA1CAE00453FA197AB1
      84134110AF64B85177A5B1B38957B53BF41A5EFAB940D6A08CB2C11EB4AD7CB3
      19AA830A922B8513835658ECCBCE8E207BBBB98E20BD0CA95D79217CC79D82D6
      B286B52F15A981B6ABD02FCE05683BA903E731782CF2A9193711CE0C14C019CE
      83690E3E2F93F8128ED770E3C6813300ACF89597069735989CB554F00D0BDC29
      B0002F855939C002D5B1423A309DB024249B08E308680A84168A37BE0CA407A7
      AF4EC318ABC8FE62359BC2714D368CD066846C92C6D59D88659C00E373022957
      42F27A248E8864F3BF5374FB537977AF524BC532A787C2100A9D577ED6EAFDAD
      159A7CC7693CD381337E32198DE1D8F579C71CE67CB7B527B3E05EC3676B4C6F
      28772F7F7CFC7626B906AF69997905BEE133B738749E3A1EEACF38EF202E166F
      5E3AF1D471610DE0CF8E1FC3FCC3F9933823E962EAA655940621B35247BA97F8
      38B249E04EA8A1C3D77BB8482A69D4AA41C51222FEF6FAC3F077E7F5FBE7EF50
      5BFDE1ED8717B07B9C751247B35A52AF74AA9D1B27A4B2C01A3AAAEFF5F7DA17
      8DA7F4AD5FBE702F83245DB9A173F06B9C843E19BC0E1C90460B1090241BC502
      9E73938D0354134900E2138D452050DD8817B4B2D139F0EF4AA8D5BC633BFCFA
      F1ED4BB5236E66F0DF6E726F8095DE01679AC62B601E934DA68DE3FC9E892445
      4D0CA62A49BD152840EB38B970D6F32014A4F88431DAA270A3C914553C17B52E
      013708528C364AB38B9EA4CD1EFCDA3DB87B8A3E02D38F17CEF35FF2A28066C0
      0B63197C29FBABDA318D7A5B3A59E7C285179038FEBF314C0EEC20654B792FD6
      8DCEABC9F4DC914C2881A727A4D63F905AE43F9A008932ADD7F57D3EE721CFC9
      48E9FC1288B548CC81AB38843E0DA1C80786B5F9B51EC060E70006CEF3B79F9C
      BF38E7B7CEAF9D2DAB023A59BEF970CF3E7D7C0BE37D7DFBE39DC6DE4AD2E45B
      2BA6B61186F6206A1C134127F904CE59B09CD6413ABFFD35A388D86D3B7F69E3
      3C3EBD7993CC9DED87D7833B505D8CB2E12C505541DD00F5115A3230CB17422C
      A55A362818A709B218B8DB5B2509AAA9F057A2590744259A74EE8C78AF2210DF
      774A3F9B1BEF43414D3A34E6D5B04B9A17D154A1AD37113875F0AA5544BABFF0
      696BD041562AC3ADE0AFF88E5D4DA8E71ADB5BB57282521536CA8FEE62B24A66
      A032BE13D1AAD14A347D0E904007B80122389FBA976E10625401920C175E9E6C
      CD7AAB414F3CE7FF1C61448EEFFC1844E901DA37318427F3AF3807CF61880E93
      3E5E22376956A4A6E0AFC8A077913140BE27BC8B3A6E0E5F2FE00F445DE9B480
      61D36192487388BF458ABB26823C2DE84C59A917327F954E1CE2793F856F4EAF
      EB2C826895C255D79960FC0FB408128284C744A0A8606F0E1C5B45B263F3B41D
      8A95446F0EFCA6DF340D426C114E0338E030E69F37D66940DD595BFF3B0B03EF
      42BF863A48EE28B23FD19B25DAB0B0CDEAB624EC3F8F849D1FB8613CFBB24EFC
      F69FBFEBE9A0FE8084A32036FC5DB92A7B47F02ED0567DA92CBD70DD0FA4BB5C
      82E493685C23CF14D2974713C5F13F8479DACC4DC3A1AAA7264D4250C9698690
      B078AA747EA4282B07548BFFBD5A2C9D4FF143E1475FA9A75AF42A3DC258F4BA
      83B32FEF1B9AA4D49DE8895A8A844233496AAB29E37BDD54598E9BAD50495DD0
      C463922F40202FF681C9FA6EFA5056FEB797C4AFD08B1181B0C8D1478B2C1099
      514C120BD66322FEBE0A12B881635CDCD4D52A2586890621096465D11257A2B6
      1C7943E2158E5C3240AD145AD0B905D414BD088D1C7CA05242065E80B21E952E
      F2133AE33F7F7017E23DFC37FEDCA97C6736DA0FEA5D34EC8990FAB5D6089ADD
      758D22672C97F94500E46B3659160A010BDC22951F7B2B72285EB77F4861CC76
      1FF9A5FCCC5421F4C65D43BB3212EB4E924EEF68C1EE19995A33161406F32DA3
      41CB6241874D2C6813F2F48D439E2A5B6A62A24A62A2FAF73F26EA5F8E4E87CE
      53E7E06DECB9610027D865B89A05D18133C5E421B22A4B6792C41722BA8733FC
      15B13332A6282D67E162022387C4B0A5C45351175E9080E493A91BA1A92C1112
      E61AB92FB490AC961C7F3A554132F29F8B38AEEF036D9ED171043FEC22562890
      45A0742F0F43AAEC0206F5EA18A49689B55314C670166C1795EAC3074AE0DD51
      236FDD68B6C250FBCC9E15F0D0DD359E63605D75906D4433A94E37B0EE3A13E9
      3EEB4CDCBE43AEA04BF15017DD6E9AFCFCE9F589232238E890972B462D927992
      EF685A4442F868EE9CBA614831E30B8196D1402ED074AAEFE29360EAF0B28276
      2B3B75F210295942C7444C9DC92A08898C2B096B6711034116B097930D9B8E23
      E161AA47B27988C32E5D40CA35B988FD5568EF2CB44B217F83FB501F277FA5B8
      02DE126EE0321C4EA2140883071876BC924D1F7DA09C19B196CE6A898648F48E
      D22F0F916A65348B305D23C06C7D2F603643AE65D00BDD1A3AE412E3DB9E71BE
      3419D7374BE53C5051A8A6C54B6D2F6C058B25FFC6291C78B32FA497042C5227
      D0B9B5CE3C7A905CFF5F10AFE9A9F391442BDB7BA25518AA539BBB5C3A0AC4C0
      61989AE6F05699C685DEAD55EA8C8E1DB95A22599B639CA6CD0F08AC81095833
      D0506596BBB7707DD1719EC3BA63EBBB3AD2610031AE4918741005EC8A8CE275
      0796EB5424C00544263C4C5B224217BC6FF1483404D946D0292CF00D997D9C73
      C28DD89C07571D017299C2BCF8676A18E553F145780FCE2FC343D4CFEEDB5A16
      D8B5998844E2E2FB8032FE46852D563B369631BA02C95FE1461B140C595A9CAB
      8609E2140990A2A12BBE70E0D61DA3C52E2D56DE9CF348503FF104E933343C9D
      6549C96C5EE2CAB9A83FE217D0B40C6651300D4005878E2E10D0065F4481E11C
      C823794212F42423B561C3130BD6192DD6CCD384621E7930DDA818AE684356A6
      03858873C0A9019209039BA3AA8BB998D1C6285D492F658D5EE05460FF1DECDD
      42E031AB6172C656B58E69559610AA18AAFC25C6A8DD7EDB7F3A93D4E06B4D52
      DF3A0EF32976140549A96B1B21C4BE5934E653E7570CE730197FC814DFF189E2
      BC107B42DC1369C9720F448E3A7B286649313C9C90E37AC87A55E2345BD86427
      BD4A3BE84F7443193BF222584AFDB61F92188E1CD9FBF045489605A8CC9EAB25
      ADA457F221573FF42526815B5AF9B71F28414B69063C0256F81D444A3C75DEC0
      51074F557735F66BB7D1B71A778777507EBDD23EA8561E1E3F4A8583AEF1B730
      637874CCB452D85A02152E7227C27E88F9B4FFC2F52E66099D6DDF52325CA372
      5487849A38C08326F8B8901275908F913C80434A9A6260A53E0BE572A1D278E9
      84624A166B3875E845499910EB20F2F16045FE74D50A9AA0D07EB980A6F964D4
      5251FCE18642402D8F1C9AA58079348EB51D5ACCF0BE3BD6943BCDB522A9EFD3
      04565B15880757BB6F2E9C5630D5982C0FD25AA7E2B11B1EA809F28EBD05C0A0
      82542C2C5D761569BF410012BDF53D29C9BE0096469A6D1C314ECF557A8892DB
      0FA624BA537D95DA94C01B37CE4CC0370A74243E0AFC91DFC7A6E2E90AE1191B
      395E1D380D2A11C2DE6621882BB4C73B2F2D733AD0F435A20570986EB3CAEDE8
      174FD38F52DC123792A14B10A6C693D892A286E5905D16D848665B3B241F399A
      4927667E7C11D961A0A440E0C6B883E3C1BF79CBEFAEE07FFF7EFBC722192FC4
      9A925CD47EB7BD3FB1EDC3EBD4A30C25E7DE98FD01A972FB4451E9D17730DE55
      3A3DB9930C7AB434B3F1C2EC43F687B51DD1995D33F75BF69F1BA345AF7FD4BF
      8314E08EA180E44341889E1CF2D40F418ECE82140424DA99D0FD10022347EED1
      955574FA565442DE8158EAF578C797A5CE3742BF1CDC8460DDABD7554EBA853A
      E008D184B8058E2C6A3482F2CC0E20948A865094A47C7C24A79B11B4857E09B8
      A4653C3BFC1529B208783C11B1A270883A0008B860BAD15A406E4640E960104E
      E91CFC4CFA5CEEE7EF0EB4DC348E44B44583ECA404FDC3FA60AD2C83A5C611A8
      7C0094FE28767E7E639CAD1AD2B58DE68D1D0351420D8D1E9C0BE3B2BE830807
      24007CB87207CACF6FDE526BCCBFDF81FEA38CFA8A3A6C4F42BF302E8940A073
      EB42105DBFABDE9CD9064CAF4E7BC758C7EE64D0C7B268A3E109D5103B1E62B9
      AD23E86B7A75343C3DA642473DBC6534E8E32D27FDE1909FC65B60978FA899EE
      E929DE84E52BF0AE5E1FEEC3BF83D190EE1B1E1F1D7FDB5D7F2BA03AF65A28EE
      9CB267443483ED3CFF1E55A7BACF5C60758D38FAFE18FED7F05CFB142697C2E3
      85CF2084A4E9D4D585EF4413BE6180669227054DB8B5C6C76E9F06B83CEFC0F1
      0A62287A92B6D9D684C0DFE456050629AE5C0C17DC4BAA592BCAD09372F4DDE9
      14EBE8E0C183F02F1C3E86BAD96D200D7D9104973A774D4BF9462FAD618C5A2C
      D14AC85E6B1324DB30395A9245EAE48CA22A02198D451C6F8CAA149F85D12062
      3C442AA6199E4E2A5FAA62FEDC3B713E6F8DB6757578D38AD65D6DC97FAAF4D1
      41933E5AF370B8C01207A89C9BCC9D2610B9E837A228294E5732A0714C25201C
      C6E1204C317A97E097203146F62C60F7F9FBF337088C846809A9404C110C9F4D
      5CE021C9A1BE5F79D415C083F24FF1311DF8A4975A4AD4C25D2EF1003D11E91A
      7DF75E8DF8D5C78FF87D1C1CCB3DA5DE701CEC21EA086807E8383F69F02C15CE
      2F9159F3DE9ABB3E5EDDC0596E11E0E8ED23B3EBA1178DD2E96C92D138FC00C1
      9AC9D047E4C3F2B3441533285701716E642A1685DF94F59CF2A6D41DB51527EE
      7896C22F314F63C309443B5F58D922F4882D0354231228426D29E5CC33A95EBC
      584CD265E84ABC2D36E95C7A04F7C9AB7CE7011047F73D00E2F1A31F785B9B6D
      FE141521C9D0662AA69C2C1D642AC23ACBB26DD522C2485FCC1F6A23CC046347
      D03D993B3A827B13E73230E63A5CA5B02836590CD87D5A329514FBE5DDF39798
      C701A34F03DE01984EA5E847A7C4247137D9CE208AD660CC42151F82C3141A21
      61939D5F6C9260410C2E7481BA0492B321AAEAD922466D006C2C46A5B7341A39
      093E8EF2E8326FFFDADD30965D4CF907F77813D70DE2B1F24FED35BC4D298372
      7207AE2B9D2E7C07E0D024BD08C5D6D50B259059F2EE839CFAC78F3EED8A07B8
      7EFE0B3B45B12AC593B470463D4895B9C230187233880E552AFB300903D028A2
      B6C96C1AB46993EAAF84B92E66AE444B49BE1F0ED57EC5C4D665187801EEC985
      9B50B52FE82266230576ADACED5C20EE82E10C35F88A5FBD3622C4876F73880F
      85B903BB08573EE5886EF412B128ECB43455D912A42BC4E5485CBDCDBEDDC9F6
      FE6EB3C342FEB3C61320088570B3BD1F9B238B535451087138040996DB47A88C
      1B151B43049C1669C108E300F2CF79734847926AEC52E310CBC2813860EB2EF2
      03BCE55375F0FAEEDFF4E8EE201A884DB077120175778386BD2902528FEE60E0
      7717F0530CF4A1EC2795648B65C6894FB15A3F11194845016431A89F2E5B54A9
      29236B6B7F2BE902721221483A99631C0EC3A4CD165F4F59D574A2AF634DC88C
      1FD9ABD14CC112DCC83B2AA8491828E41707F1C80A74E6C2203A6530447B264B
      6F2BB39C9F8644868B1357320A101910B4910B8F5C248A9F484CB74CB51283C2
      887E53DF6FDD4F95C96118FF5D48E2BD4AD02AADAA8502F9FCD561BB90E99123
      B7AC6E12270E15B85984F3D92488ECB08F1CDF77FB888A21002502358A7B3885
      952398625EDE431EC032CE66A0FB1007E0FD43780FB9FF3E22773DE4150487E7
      073E829900B52B7AC8034884B8E0FE0F1E62FF411C85C1839E813FDCA51BA12A
      CB107E0F710870F8588BD9C39E06742FAE662B9E88873A0850E71E3843956BE1
      3FEC11A4ABE4C28C60F8104790ACA4349BB9F710478095FE3296FAD7873884F9
      2A9AB989998607A9A0C2217112783C80266A3B6FD2387F5561C668AC1495568A
      D183B452343B80768076CA0E732EDAD171B32DBE765B9CDCFF6D813BA286F1BF
      D934C582231AB81D63FE560C316A76887402E32461574C8BC4CCEB0F431507F1
      6174AC6F40AF2CB94BA69C4B9E52716471E58965AAF956E7B0AE959EA322D6DB
      C0653A12732BB87427407DDB4138D8ACA47396762BE16410A4DE1C1D4D2968A8
      511A2C345E8789D9548041B9E480BD325FF28816E460E2B8816DCF33C5B47A08
      1ECC19ABF4420A5BA11474137D4A6E1E15747AD36E9EACF459999FE78EDD3C59
      662B069D4404DA7DEBBEAEC78F3A5992E21D38AB397AB7734768038F1FB1F7EC
      FFBD527BFA0E69C1C504699328B7B52AF507FB077772281899D6EC205F482C42
      68F6E59ED1D8946F9EC69AE5E9A472B872A0A871E0B4E0E301ED77A3901CE27E
      CD58CF9402816C87B7C98F83E55C6D0F20BE62E1EEEE11B372B350254FC3EFFE
      4D0FEBF6A33610A7E3D739CE3D43A0CB14A5858D17C0B202D83BB3FAADE290E1
      56D597B62D7828FA0874C0C592A67826F2690DE66983297017513318C9F0EF9D
      200AEE2602AE9D8D3E3045742EC4863640163FA952371C99BBA7C6142B6582C3
      A2396C632F4FFF0E8D603DE758D040DA0B80413C382395852B0662BAA1E3CDE3
      C0A3C08A3B4A01DE1DE248C9F8B714E48847242E606E003732BA2A88651554AA
      F41A8FCAA37F3BD56A3B16D82886D5166154A0ECF49D1D6B04B58CDD113814A1
      CB23A31A0FEE82713E9C968A20DB8F1BDC2C43BE4B6E80F514EC18CD6B65D2B7
      8BBBBF6B9974486C87E3CB26628AD975AC2FB533159EB06780A1142D11916F01
      4FE1C2C43A40B0D4263142962F09BBBAE39CE1DEA2BD546DF3B5166E3A4FE2D5
      6C7EFD0E0406887C5627CD495EDBD007128845720616450B331ADC2455415DBA
      8399544C2C8F385460833990C216720D54EDAC18F042BACD7E87C6DDAFD1E182
      8AD5CEC278422763EB2CD9C2A95B26419C0429FFA09958B5FF3EAF101D5A7CFB
      2E344C6F79A7D1D071CD88E01B1FF5539AF23B1DFBEEDA1E3B03C46F0519E83E
      0688DFCAC0EF5380F81D0C1F76C35D707F3C519A647964C268265DA3CD180BAE
      83E89C042170D7F6ED1F080C7BB869B2D4B01913241F550C4BB2CCA5FDA41ACA
      ADEA483E552E2B6F23C5D22B8442A072AA4045472CFF8D6D37FDEF660EAC3011
      33A5DA9CDACDC8BE13A3534EEF46BEDD71D2DE3E96D39B1DF8CBC49DC5D1244E
      A26FB864F6DA955BE52D9C48B889A9A5A1E19F19D992802D1177050D68418475
      5C55CDD049BCAAB65B5253A4D39A534E83A8F8EDF9136396EA73E0773A1AAB2E
      50223F3ECB65661AAC90EF38FF722B0173BFC6771C6FF26FE8656F3883B37418
      06DE9EAFA0CCB3ADA68F8FBADD9ED3FAF9D3EBA727878D6358EFD45FD15D7A4F
      EC9CB7A3D564764E2CD185B5A60DAF3215D05121ACB6B8A0FF5CE5C503B76CF8
      DB2D20C676BBDF75BBBF6F571EFBCEF94DB92A15CBEB9C7FFAF8E6FD0FE7BF2B
      A65097C7342C8159C21D28D7DF504FAA79DAC1CC5EF20A61FDF927195E162747
      C7691633D66CF26FB8C933D5D9041E94EC66A7452E18BD6C0E1B317FFD9E5667
      E96AD1E6CA87C0016E180C9ADD2E14F511100B7034740E43F66430388DB8BF3D
      713FDC2DEEADF3B5908BDFB9D2166B744EEBECE3D9A0FFDDF3D3D7278317AF5F
      D73E3FECF3BE2F61445FD5817D2C0ED4C373F255C3195E415E36DCD0B286481D
      B840959CE3B57168938F348943B487608DE7BC1183C35B16EE8502F37A829EDF
      B98B58A4093007AEC887507C263480F44C05E0B91B2CF4C37903715E3965ABA5
      EFA2759EB5FCCE8F4027A4A6DF81CB0D1A757D21578646DD6FD0A8EB2DC417AB
      D934B8124DD1D212DB7222941F2D9012716681390AAEDE5C03D2E1AAC9CAD999
      95737ADFB3721E3FFA97A39381F3D4418682D1755455926110332C4CFAA64B2D
      51A2C6C28D182251C232F1EFE1D4D71BF91046EE032B4B397E8691B55103A048
      45B158624C2BE241C6091636A50D7248D538315E5252415EE9A4EBD8B8667C36
      2E327837A80B0F32951A287304946129E3C7020BCD008358082AAFC131B68B38
      A28A6401179F095D997285188AC74454725183073180B90CD2956B97947E68D4
      3A066A5D88CD2446766302B3A8A473122F694DE080A421E63A4E2E1EE8584730
      56C30C267188911751B64CA62B640B18880F0B267EA0CC01867982AC414F1E67
      AB6814FEA542F58B810C08F2978125FE134CEFA93D6EEC3A8C701E27C13F306B
      27440111633A22822C620D0750F0EB1869F1D43489D3345E2C629972F19E8749
      A0D32E10C80DD3BF78AB445209C24B81A8FB3AD3886029ADF2CC120815AE1611
      E61461A611AC9B091A089AC3CFD71F7E7ACDE1A739FC7CDBC34F73B6293BDBF4
      76B3927B76B819A18A2FD3C0BB40BE9CC4EB9C8CE6A03CE4E6917B19CC4807BD
      87735D432C8D5005FDC8150AA6A1CB50C5384C2F5E725547CA8804D58CCE6F7E
      E2CE28F92BF249DA2F1FAA9E364275F4A59BBA3B47FDCF34565ACDA75BC7322A
      F5B34C40DF2E844EA1A8DC02F3269088A7270CB980991BAB740A5FD15F863595
      1B495A99B06A306B9A6A7645DA9C07B3080F48D5186191CACC145292CF9A44ED
      C2F5B1E812BB0C582A170BAEE472F6113608D3B9162B32472482593A1C3B6117
      6B74783F8EEA230858930B473B538C5D4418F5E863107B8210EE3AD94A5C510A
      FBADBBDB11D2057940073A7047C59729E790984CCA32F4F6332CA6F1A8BCECF2
      B78C369059A655ED95F55CE11270595A241F7B1355F1363C40B69D65285C2974
      AD83304EA9A019D52CD0E1DD9C81AA001430A7C29573A16C964184592F21F46B
      57A9A286B5D73C6562C12810C80D5BCF8E4AA01E1C64D43900A6EAADC8E611E8
      FA3F32A632CC26AE36773B50B3A93C7C03E68E6E63EEA8B7627F7E83E7FB85A8
      C6996876791E3D89EAA9B35E8B91845941F5C92A08298C4ED356AA02984A4772
      BD34B8A4480F95846B63191CD01307D0F284210C149750E13574A9157871A4A1
      3C30AF2914533CC72511D631D6494EE82D5A07911FAFDBA8865C062E5DD79D42
      56A31BFFB0D4826F9F64AB6B5AA2B4AACA4602AAD487099897016C60D5715385
      3EC5C66BAB0D6F22B49A3311B95B8C00A1A07AECCE723A0435CF591252E0AA22
      A356045AEA5B2A9FD8F2D1A99B30725D8C067EB82A38719603D70EA9F597709B
      D3D2BFEABBD5C3F6CDFCC27DF2D9B07FAA1035DAC92F70AE51718925692A4A6F
      573A774D78B178A91F65426B3A807C9A735AAA2AF4A7569C7A3F55CBE5C2B8E8
      E11669A325D59B41C75DA3A1058F6F54883A8EA66140488F707E4A1AA69A67AA
      5A4B429A6986A04F024C31477A44D6D68490D268A5A6B00F917ECCEEA4BA5322
      DB2375DF8D72F8749AC1D0FC109A5D61C7D73030DD1453C09B4B70418DE758B7
      F38C9F3FE4F6F0C9AC2533E61CCE93BE9841F215F8342E4919CC2278291E51CD
      EA0492A6ABE62454BD6CDF8A9988FC1D5BBB3A9EA3D1A88A677E946FD447A5CC
      680EF04BC0074DC31E34D927AB348D23156693C6B35928182780EAB613A20505
      39EBFBD3380E1597500FE1518CE2A333A84590B09320E2201B7CFA4CCF2B9DEE
      5AB4F97863F1F635BF63DDC6D6D6963CDC43ADFA5581F9096B5D2D70D4F15244
      ED6A830B19F13D83A8458E3B8FC3BB05744E6D7E26672248ED6A2B6D31F508E1
      98EE6BE586FCCC1EE0A16E447550113390FA4D0DCFA89CA61FA18B4F5FFEF486
      C55CC30576AA00E8A39A714C659E5EB64AAF6072553A3FCA76109FA2E8C1231D
      817E98527C22BCA20E648EE4FAE9FFEE00DDFFA75EF65AC550109B58ADD55130
      E3C10228C9C16CA6C0386D0ECF659D7B0204A6DE6354A4AABF0A8B37AF5A6347
      5914E7C6007B2BE5740B7D6869365BAD45F5EAFC6DE37E2AB760700CA2B163E0
      12478AE1EED34B9E2079E60273B49C166CC7358A0885C7D31132B4C0CB59A606
      0BA36B2B6869D82DF9B60F6B1F83F513B30C9C9515E689C985A343BBEB1C909A
      7CE0C8304E33BD9AE253E0D5418250968B372F25083B746CF363D8A9D7AFAEAE
      AEB03898273ACEAB2B97761D220CD5E112D800E263625100D81E1DD61216C205
      E521E366368E33F568B5C48FFDA3817380537060C6D6EA76F197D72F59B91876
      4F8FCDC8CC3DAF5F75D56DAF5EBF7E7DA809E1A6196A12465DEF859D63A61DDD
      E5C48A183E981A77303734512711D30F3468D1AF0A1A14476223E8E2DA4964EA
      F8D5D5EB6701BB70683E689E88C9BDFFF0096636116140682AAA5EB68F0EA505
      02F9597D73A30D7A36EBAF2C0B1B1B4D5094D246C019746664684C8AD967B71D
      8A836C6B504F37866B6B1035C4CDD4A0ED689466EF9254C13391F361F20790F4
      CDCBB62E7BCD409644232281DA734C8236089FFF4113AC97739D15094292AC83
      481B0E6EC864C98EDDB4D74E548CC20023732261A86984E1FDC6E327BFBB0357
      E79B59048B00BA7A17FE4E5A4BB424DD6C23309FA1AD819C093646807DD40ABA
      59525AAD29B0D43B40617FFA93142B3FAE4BC46F4842248EB5B5721465565447
      9363AA73E91458A5B1AAB9514179C5C9315042F2C35303854CDA9D1FD3D62776
      6EEF0DB5856DA1D0A86955B3F4114118458439312F36CE994BA7D14661DB4D1E
      1BAC4E29182CAE3C974B0011EC355F226F149BFEE95725E3E208F15E0443414C
      300C026FACEC87AFBD03671FCF8CA7891137106115D1253C85C3CDA9E7B5A50B
      8C90CF35D43396BBD035EE33BC3411BC26B096D03C1170F20B296B8CA299603F
      46CE11A8445ADEDAAA2B742C11CA2DA790AF52F7023F65CFF641BC8330F3F783
      B6B68104D990441D3553559827760C52B90146E5AA11FD4504A707DBF849E198
      531018D1A87E588DAC5E444A5BCF9BA2B9D7AAE29333FE13F9DAF833E22F3079
      D589C0D6F7B88400AF425745A97188588AB002AE3305D508F4B7552A54750264
      F61A24959ECE947C57A9CD09A609AA7955EB3C1B428D2D4401175F32CBF6B6D1
      A7094B407760C2F9169C2D7227A671C23170BAA40EBCF900236F35F588C18903
      DE9670DE58B91A85811A0279372780363B4EC48435C16AFB82FE6B7C8612C58D
      E022EE56757B097D22BADC85EAF6BDA323C260C9FB81C45527AB9F43C6E229C6
      74179A9AA11962A8DCBEB6F63D068D3E5147447B9F00AB823395A4583DDCDFC8
      ABE8A23E07DF452D0D43AC73E8CD5D80706B7211356C722981AD255482B2F0F6
      37E0D977E33F91F58C3FDF0538DDF7CCF654A12B72A865146A14E82AFABD8396
      82A7A81A9129C8AC25AA79A02C01A02E95EA008DAE6DCBCC6552633F13EA9489
      F822022786D6E5CA96BFA2C33F2B49DA3E2812BC811DF40B9CCA253902713665
      66CC642F0619600D467A167876F6D3CFE836407E72E906218A30758845A92F55
      CA811BA9227DF0B2D592BB81D648CB5ED86CB37235DA3AE2104E161F7E088DAD
      D94E65DBA9F226A69F3A50DAC7483A621855D8CDE204F258EEA415D3AB4C4BCA
      266E6C46BA0DB5FD189CCC353C5269D95972A3F19037BBA23A0A2633C3C369DA
      0F1BDB4D610384DB04CA0EF2895827419AA297373B839013427A090666B0D398
      7DDDD5E75C42FA6327D622A08C18829430187E6AE758F6492E728DF2C59488D9
      AF36E5B98522DCA6D63EBD3A1F6269ED812AADFDFE179B0601569B4D02B4F1D0
      38699753BCDB860491EC50DD3968E4E8D9F9F92B559D7B98410EAA66EEC43CBE
      0C574034D949AF6EBF8E5B4617A7C5CE56E3ADD36EA720A20073A4670D1D461B
      D4190DDA1ADAA1E1908AD838AB56DB19578535C3410C7A366FFDE482BDA44ED6
      9E93BDAC077B9568B5966B5B9DEE8CAA76FB68C3422EEE24F10F087017830DEF
      62B0C614C8F66B65444DB18613C72F21E335DEBE77EC739222552E29B6EA62CC
      404018B6B6ED7A2F3B5F8EBF7E110EC7379EA05EE79EC071ECD6ACF680E3F8DA
      A5FC6725AD322B7BE992DEB294EDA1B3DCB7A5D1574BE3F6A5F9CFE49CA8CD28
      6F94733C45697103001BC39BE8CDA0530F5CE3C31414BDC00D9D976FCF9057CD
      354EB1E23D4F6D11780F97DAF0DB2CB5F19F35161BEFEAFFF7CBC73B5B6F842D
      FDCB479E1F85E130747EF9785F56E151CD5578462512E1947E16AE26DAE9F00D
      16E3B718E371CD316A650183B56C2BF89D0F60547300511C3D2D1B446318805B
      DE4CB539CA32D167514E88B32B7578A33635622081D08FA862AE7C148C230A76
      A0A80695B68940FE32CD4A8C062AB23344C3F2C62E0FC64A67F698B95FBF063D
      FBCA9C4CE504E4EEE955F124CB153997A1735464D6C4DAE2FD13A0C0459615D3
      D8D54A57C87BB1AEE6EAEF78AA322C5D1FA4733C6B365AEE74B4451EDA3826A2
      DA14A757F7A155386FEA704D5C0B860BBA09E2F6EADFD426767DDAC3BCE564DB
      39F0E2E5064F809D4E87B6C0015BF2824510C2CC20D618A7991D66C640CB0468
      EC82F593E08D4389EBDCBBC688AD58845B238418B7F6265E718AB828B0051EDA
      3EE7523C12274241BB2A582A34F77DE088F259600EC764B5C4381F194726E0C8
      24BBAB633171C3C3B6118EED2C8EB335CDDB5FE02E324CAB3791913337A71C57
      ADC2CD7F4AC434B8DAEBC44D5986565CAA0AAE013E084442F71A4C4275E43BA5
      2763283A5731260747C1F550EDFD359911E9DC1812D464714C12F93E76E34FED
      DC8084F52EFC9BD43F91435C88A70AEEE2AEEC5230494F528A819A0BEF628F08
      BAD739EEA0E79CC59D16A4AACD7CA68A950F43BF93A9BDB8A59C963545BF757E
      B791F17FFBCFDFEBA735FC176C5DB243A9B8B9EA08698C46D16102546DDBE7E0
      1DCEC8280CA9763F5EC62BECC1598880A240BAB33409FFF20A2118992A4C0A8A
      F6CCC17E28CD8382E97281885E184BDE1ECCC199541FFE56BB475421CE30FA83
      B322736E67750C748D022E9CA4B9217939B8BBBE90347B591C203B11836AF000
      3C3B03F77A66F8D6A51B22922EF127CA1AD9CBF457635414D020D0FB236DC87D
      690A1534998435B408C64C80C97B726E6888B223C368C19864E40D679F3EBEA5
      D9F0790F78B8079E34FA9809A2A055AE9068BE909A99C6E45647AD63152DE7A5
      853A3F7543B9C71663070EE5E173E407A9116DEEDA02488D32602E429F8B9A60
      6773EC8F8584EB79629966201C2CB4DBF8D7F90164E2927DA52D8C6C97E92614
      87EC18CDB62C869734A81C35A06729AB15E5AE764C766673ACA6D06402171DCA
      4C97AC62B8F65BC18C279B35A9EF2D71850BD7510AF4CAAD3E43A8D4000F23E4
      086147274CFA818FEA9789A357EFCFB2AE6A1F7510D623C270AB50BD0C15067B
      3CD06820D3B6FD1A1D4D4419787BA87EAF98001A8B0D3BCF3A485B231118373C
      6A71D78EACD9B6E546DDDCD937A69A5AC01C8937CA66EFEE38F429D2A04DCE99
      C2C65D714293952564603159BD0C633C6C070BC171F978DB2CA6D823DCEF4E18
      A429EE25BC629FBA977048D9E3680CFDC18A370C349792F68E2570E6406CA945
      5F7E56DB99F124DAB012CCC3918E053980B08281CFF018B0542A7B8200BFB039
      11F87D96B85A843A1E390F22D8BD78EED61180F0669770734CE7EA2757996778
      2A549E7A8ADD66EAD3A478828B78B5D072BA0E2284413D341575254315294062
      654B50987CAD89F0DC953AFEC814CF4FDAF8A0082D91DBC6AB2835C15C942865
      0AC092C1F7B083C1C87326A14BBDC4C49F3AE1F9E635C4C6A39856129CE59688
      6EED054B3C356129338D158439FAACB4B0E5498D870E2A401A93718F8A9832F2
      5CEADC7BE4A1D8C3D5F24B6600DF14A1F8C2810A8DDA1291755D91DA51C6A518
      F676802ABDB29233EDF778291C92E18D2C26F9540F8D691AD8C5516021C7E125
      67852DAB35D6C78F526FAE20AC2937AE4026B52CA0B16C277184388A1F34282D
      96E9665734AB4ECB5B2EC30D9B080F5E93BD8A4EB8F8B4E9FE41C7D27C15E087
      41335FC64194ED5A743DE0A685C33BB643807B207C29CE9D49840D01437E2295
      8B43F517E8A212E48C2580DE5F634956834A3C7E8493401B87084FC1C5BECFF6
      440A83844D69759B86CFF30933B6E235731D7918EBC3BD1084F5411C54B872A3
      FC29400712208548BA36F31FA1ADC8686E7179BA29CD91164A6125F1C9608A6B
      15515566C845B815EA7FB608105F0417386D6EB74E5A64E51D9BE2EABB2B4DA6
      7F339A4C7FB45B93E98F6ED4719331A4F382EBA1D16072B62B8A4ECE50F3C894
      4A21C2DA15D25666B152829AE07EB523B3ABB425B5BF45B9205553649FDD6A09
      B7192A45547B2F9E7258AC5645F6720E649D30909CCA1D53CDD910964FC66477
      4469E6070ABE455C2D35584510F901E84298399CDBFDCA6513101E256A71F57B
      FD5FEA7553C5F02C4704B64C7E65606F0146A70774DA32751E7517F6119D9C90
      4C3E370E90B453D5B4013AB093991ABE537950252CE8672F39819928FA5190E8
      318BA4E13EB9E478DC245729838557BB4677006812BB88159E2E825329DAC3BA
      6664EE8CF46DFB2C0307B65564CC7A8871A5B391427B4BABD48F75EED8B4E5CD
      6695A0D92035E3C6EC435EB31FB69DF588E3C551ECB156332D6343A48C5E7B89
      4346064169B8B1BCA83554F8BE8969CA0546ED4CD56B6B2CA7480540E07D0767
      F911743A9D836CEF6944118B0F50BD041440D404F92DDF59F9B63BCE541AFB56
      4146917B935F5AD05CE035529D8B541A9676CCD9C0E426E404065363DEAAF37C
      9668084A2DBF03F7062D1371FDCA4C8F1F71200D42A8E04CD231298C63C2D251
      A99906AA9911EF52070B35A5CEC020F368B3454B1DB9FFE2F4330BC861679B29
      2B9EAB002815D52EB738B07BFD3CB72D3304D5E0C100003754B5CACC64D78ADA
      D32BC28035E7E5818585CCEBC1AC355A18B43AF998AE43B7B6B4D050AD111B46
      8E2D4888DB124C56304C63CBD09455EAAD86CBA74E51E6386D6BAD4BB2DB3DC3
      6D520DABECC2893025BBE9D46F2FDE8EF39C4C073568545DD70E0EB64162CAC3
      696FBA59F8F95DA3A180F4B959EBC085856CEE43B4ECBB73693F206958206023
      0A6D89555C5D8CF045B69C800F87B91D847233DB3B62FF23D17B3644D9916454
      6934C7A0DE44522469C71C60D58DB5723D2F19F1813CE9EB28D72CB23460C567
      5CA8FDE7A5F34C7F7E49C7EAB38F67854E11E4AE8AD5B15B3A9F07D3F42FDC4D
      0DBFEDA6563CB196722465C93CA66EC6AAEF91A9FA61EC87F4EA605AD64C87AC
      B0F9D8218C36FA78A6FBAB22D9EA4CFBA48631CC8CF425B5BB8FC3D20ED0A661
      65310C86A6911A8415946D61ED29E61E6EF2F0061C834020FE160D25BFA5CD50
      E3EB40B90F321A5A398A9C85B876A950AE826EAAEF1E75A9AC2835CBB2380325
      A15AC34D55F05D6988BB05C53DAA0A6E229E9E526D0B9AE11ABB08D812E2365B
      08FEB16E48C7CAA81566A27C0DAFE548994B370C8CFCBE4F8BA65A707060F853
      E743513DD3E91C6A9FE4FC7B0F72A88F1F9DC7ABC413B83A8ADA6871B47C2432
      1ECCCCE5698E55045AAE42B17911281F175770B214616B5D296A93E110088717
      550C35BC5AF54EF7A4288F1F14AD81301326C753142436694D8A4E3BBF9330CC
      257AB81B8981BCEBA0EABDFDC044C1E81BB5362CE1690B48BB6440B6E8547E95
      D44B686BC1140C2306C3502F442B7E971EE45487EFBE28CFBA40F6FE9E59AFFD
      5D64820376A5C4EB0D875F2EF2E8E1BA322F082F4B6292A8997B22FA1E3F7ACE
      380E4F8BD80A79D46313F7B5C09899042D1EC0AB6E62C7DDE8D457BB9C22E705
      A6E5C17891D7A29D4A78AB5C02540D9AAD4DB80005B653F52A971B063D3DDA98
      E07E93E942B980C5DDA9CA49B8D9036ABF4EB65B9A6A57D5CE9634067149439F
      E6B65551EA70116ECA54B708226A8111669A3372CEAA8BDABDD665B8001B9D57
      2B1F260B9932FF2CB852BB3E575121163A1D4E361CECCD11267CAB511816F16A
      8F10EE176A49E5C384261CCC89D8DAA9593AB30061595CCA8429F27E6DCA236B
      1B067EF06A47AFA8489A53CE2E8E3FB8EFA79CC78F7ECAD9FADF2BCBAE82ED31
      560E6365E0402B912A77C042144C3ED5E678138A603DACDED2425C7499850D1F
      3E48ED4D19C9CF72617F31F351A566A9F1A28709539628D082E8A1EDD861B09C
      C454D6D558EE49AB9B7038AA5DC1E93D61D9F9C1AD5625BEE7EC998DF55EDED0
      BE6D31A714BAF62E5F84B6A65B798975D2874123AF6517B54A50073A48B4034F
      CED8CB3865E78AA5875B3E8A3D4B1F1025749089D501740E16C3230E0AEE1A34
      78E6D21071C66794DEABDD10915863501E99F04CE36407CB1752A0F4EE7CD269
      E39B28CF4C59543B91ECC5D238F22DD2E529437BB0804548475FE2B764B0D546
      E7892A8E64D5B7308DEDE3EF974A674237AEC205D1FE4B97827D334BB8D9322A
      E976AFB002C60C60D8658615955E124CB2237E1CE1E2C7E4BCFA9E980F188ABC
      45449557A10E2EB23A887B0781B991401A0368BE94E13EF9FE2A1A83CC63BBFB
      AA0A544D04277DA0C3A6CC7F40DD30E94B02516365AEC85DC194D4F0AD726788
      4A2969028CB605B1E4FC2357669121C809320E804E3F0C93730E286BA62464A7
      5019271F2E322D8BD2D9074545D531E2E2E0E581C7CACE887B49E6510C3233AC
      D65189E116F52F97225C4DF63E272655C7ECCFF251FFCDAEAC46A340676DB32D
      BF7A5BB2D3DB5A7AB7BA33736119D966D442D58456451AA22C3B63ECD238D866
      EF8B3A89847798C1FB80B619A1A9EAA88D66877DC90E63405A0AFA805D74671B
      CD8E5BDC92864543019B06CACFFD769222DC2B6AA0E46025C028E6D897C4405A
      D9018EF0D39E2600EED72E0E62E869C66225D5E8D194740207687397EAC0DE3D
      BBEDCDE3985ECC46925CBA0FD75664D7AFEE1F851619E30599252ADF84A7030D
      CA6467DD37A805D593047D47DCA5C51217C9B99AEB8386FBED86FB292117C70A
      52E9ABA7597E408815B6A842EB6F57BFEB509A2785B8B93CB4CF51C73953817F
      9C89E373CA414A0DD229981CF68E5C60FC77C2CDF7F7C3DB2AEF27A9FA4B511D
      01FDF851300DA07359A85CA178EDCEFC064E68D8229E2D184ACC956D93569F3B
      A8E89792F31309857F550F2E5530FF9EB461FC5915946ED384071C068B80196A
      160ABA634854B32CAD53F39E7C8FC62A7B19B83B44E235240D830BA15CCE0DB7
      AB24F64753AC88D14D7FD3D5EA7ECF94ED6C59355C3077766174BE5D74CA7670
      CBE4BB5EA7DCE512600E77D492DAC7DA418819F19A21182635CAB53D7E44260B
      62D958DB787BF782A6233ACE1BEC50BA4A2272B0739D72B4A04A53A1CA584660
      007EE2CE669A41318F36059F54468DE361F6A4B2A85058335D91B980AE04DE93
      E3605AFB65B596F01508DA3143455C2631107C61D9C7F57CEC91D18C528E67D8
      5470AC03F471DD6A288688131DD5D956D58C248C8A6BD615C1FE5810723A9C12
      8BE811F33160977AB929D556E77DA3BFD52E4F49BAAE862E6E38660D8EA9950F
      F557A238222095863B6A22314A928EC941DAE8D2E4B75F0799A10760AE2A6FC5
      C9BCF9FA3CD50A0FA2BC5045EDB4A0ED51D7B9949F5A6BB5F9D78F0A6E931378
      287CE379A852780CEA8F02B362650B8D013AFD5C52905630CDBDDBF2D853C7EA
      CBA4086D04C4DD5DA94EB736A010B7AED1FCB81C024288708293064D3237BA89
      EA80921C011AFD68B7A8D8DD868B558B374242662412154BD1702F3B75CF8B17
      0B4E4488C8F0059A08E17A6718602AC96BEE2A119EE1BAA8D8144C8BC86167D1
      0A6F5948E0EAC680B064C4625927ED0FA8B3C92032D72EBB2757119CADD47EC6
      987504D7F619808AA3B05409BA4395DD87686D5A37C3340E4C7F1470D40365C7
      5D2E75F50FB3916E9D69D3FA7C49043D078ADF7A71A5C78FD8E446D1442E79D3
      A3A7B1AE95D5329FBE7766B52207383DBEED9807FDD0936DE7EC4C1E5AE8F2E9
      1C0B387124ED8EE918D362BC83AA6AC5E9F8CEC58A57ED09D6686C7BF0EFF26E
      27C880CDE582116B509463C6290178E1625D772F5C219EA09EA58285B7112895
      7112C0CB72A7B446AA189FB50D215EA392C80E640C3C721358B99B0A8E5008A2
      A7CBD0F5385C36E6B2BE6F101F154BA4A8E52C5522DE61DB790DDB2555359C29
      A52310A1AFE0081166811BCDDA62402F028F4EE738BD621FA0F573CB42B9ABA3
      FC763E178498FBE7F8091C63299D1DF724814B2E6302AF85CDA812B35A828C8F
      A420C3C0AAB9EF9B9776459EF96A8688C42D73A8A74410C6B17467519002C50E
      D1BEE95B80A5CDC62FDFF80CCAAE436070A9357BDEB612EE20102810846982CA
      58812DEC40A021F342C20A246E9843C50710C45C3A5C830534BD807117484798
      24C2BD5068638CC82C391BE2359B955C18AF7E191A239B755E7D625AD640A8DE
      28B4C5660764765464B8C84FF9348F671D0D56AC01B49966B671D49B07629F9C
      80039C9D8D53C0F63DD3E8D56FE13494C803DBAECE8591D07779EDA3926BBC31
      F0B69FC7B3FECD4BF56DF802F9BB7E5AFDF8C647C1E5B9E1A7F81DA9FFBF0241
      F5136D079FAEA1E6F2EDF8283F62BF704FACAF417EB01483425E88204563B96D
      A5D6875C0A1CF7B5F16EBB01A7656CD41CAA8CAAF8A165F1EEA8F071F614E41C
      04A90DD96D1E683BAA3E059DAC49B32FBC82CA616984950CD6B416D89758EB74
      5475224E199C968D4EB832833CF01B4651F3ECDB4F000FF3E28530801751ECE7
      42CAF32830591F35A61DE79C614513731A576DD00AB3A2BED702D6EA93541F4D
      B25CF7BC0B20C358D7373014B71A0AC1CE26EEA2068DAA8FB3DA3A69F6B44598
      65126391908E233AB30E5B1B2D6C727513C5C686C28D08B49F53C56284EEC647
      D1BC816E7D5A674482A9D99A986FA66A81A82522C87F51C03CA3B6F7E01EE4E7
      76ADD5A0D641BBCCCB8CF71C4C1138200CFE81FEB196CBE9E586C1408FEA388B
      1096F150038F43A7A5B127A9E5A065B4593D1A702FC6782AE022D97233706A4C
      17AC0A61CFCCDAB5C6A5739DB27A927AAD43231E195641A6ACBC7495206EB92A
      3BD022DFBAC28847F7988555E72AF35206A3A7DE9B8805F07859DC5BD09BE846
      C0105386605D45A8C5A7714C4A15E13DAF90E9EB5000E75356A500B3E8569260
      045D078E35A6CCA60A3635E9ECBBA65E5C51AA269F6B0836916C71F6EAA17252
      FBAD3EC557AD0D72A636C8013629AE307D1F67CE429F3DC0F395C3A28566F4AD
      00697EC0B37BF07F56A8509E6B6156D90D942AECE865069B7344E8D89BBD427B
      0F5E6C9C17AE141F69951C28AC4232B64CE22BBDE4949F5AA712599126EC40E2
      1245ECC946E86D7347EB7B874E949CD1EF9CBD7AFB16A71E4B6E4C91697AFAD6
      FAC516152328743443806C3B7F693B4F99C0FFEA5C888D2C16C250BE941A1A0B
      3BD7D1107FD036DFDE0337D313F826BA447DDE44351EEC574C8921B7338E6484
      A862294AE1F9A0A08E750684E60C1A02D9E22F4A076210060D6FAC6223E155B8
      99547EAA6BA35F9A7936C9A794244C37AAA424294CEBFABD8A9BD741795309A4
      E432CA123496391F5573B0B9C6A10DEAB60A50E1CC3B9880E600B33B76DA6C27
      9DF1777D41262950B1D6FEDD8920A5115D09BA4137DC27B2478929035984E11C
      AB20F4496A6FCDA1291D340385DB946662AB03F5798F60188D032619F318646D
      1D3027E062A66707E44ED635DE80736FD01F625CD1204081A273EA6B16B6A383
      57EC722BAC3FDB867D15552563D68B389008569477015212053212C6D811430E
      AD81999853641170335479D43BDD74DFB2411F58D2EC9A00B35A689628DA0793
      45ADE923815FF98A4461CAAB773C5B45D9FBB438CC48B192584662FBA8B7770C
      D4599C907F782622151FC471ADBB86AACA7C4ADA03942530454354BA8A2C746C
      B58A802160695D2E73C5E0D35C04CB75B04C1CEE293847CC123A4860409B4973
      C59F39BC0B3A802A81E48D777EFEAAE1F4D5A6DACA3B9413E740299558D95D1E
      504C201579FF9150BB9B285043AF9F74C46156B60D3DA5AC0B0243434F031583
      B7096A69609AA41DE785AA08A72B70D1C129A6F08077CFCF3F01F79E98AD6E02
      0DAC539B8A3BA776C9DBF304371596C5B4A1B0F08CD656E716D2AF428C44A0A8
      40C4C789572AABA68E3105584E048721562A5BB88F89F1E06941F0E111E1C660
      AC1195DB39A48DBA14F152E7CDFBB1A91DEAC23362A90F71D096C5348843A389
      08373F470A516E0EA52DE5C2146A86A5650AE9C6040EE9A3215A1854548C3EF5
      0275ECD9D398F6CC1A55694098350405E0DB024EE551E09835C4E4C173789CDF
      21AFAF65705D32D8AE7ED11A12C5AE11D2955C65463061550054073149A43047
      298347AF1B8A9CBFAF609A75A9743DDA033AB6D61B4CFDC3246533559B024C40
      93AE03A9316AECCD47A555DA6A291048983E9B7CCB30C5DA4116DC57EA2AF6F0
      D6E32AE830AD8BEAC19CD722048CEE26837FDEFC0DA6E45760116F162F6398C7
      3B082EE9383F615EA760E304AF6E605926104C1515142A4C93741F5FD76788A8
      3C83315CF8B173816B6C8D2DD02F09224DC2C01A9DA5FAD4B3C02AB1E441958A
      D3A2D5B87A1DCB38E1A2B0E4BF51C634C5BE9A5C66CB7396C91E3A25E04A85F5
      2E3516D67682302AFDF53D73E7300F993CD8E981B36F715A24A010FA7EFBF077
      7860C41757F2D3D28592D47092EB97BF294AAA9D3DCBDD8316C78F4AA092C599
      8C7EEAC79BEC1AA2B30F2C779CB2852D4575B0CBE34714B5B35801FDA6996518
      19185DA3CC460E84238541E990544327D301A0B797267041D9622321943B6B92
      E964C81B2965193440B477704AB3A5D87178F6654047524E025296BE437535C4
      883CAA0D4E751A7DCA2A6C1863B5D94183F0B31BC03A4C50685793ABB795CB55
      A453B50C6142EA5CE7429AF25E4E053A7219DF103B165F9DBF6BC33F6F5944BD
      8D3D97BC890A8597326AC95CCEA172A1C8BB04AFC18368764DF9819DEC8E1FC5
      D4F9EDA7B7FFF5F1BB2EFDAF37FC1DB98FF6AD66450FC67FA23D72FCB923AE44
      B39FB689D852251E34190FB589DADD414C3A0DFF59D97A467103A26BA54C70A0
      8655EA4695AD05460823F1BDD8D710FE9690AAEF01CC9700B72DB569E2AA4A6B
      1FF5A1D8775E6CB60CEEB4D3F326E4663F96A7A9E939EBF8AE8696541A45B3DF
      6C67BAE144BB28963969B53646F1A09CCCB0A811239DB91194FF3760911391E7
      286B9E42961A0DAD66715A95C57D66A0AFE36897D86E16BAA118A38C97C37BA8
      CA4344586D4D8C384F804D99886CC5055BF43513F7A062F40A70E41D47E7C6C2
      8BF3AD4F6334C8A1B86179420DD6D84A039845EE43B3492AC9F5DB2F22D9FCEE
      14A29528F4B6D917D5E9F4F9756ACC93A644DFED676EFE1D67120F2E9E9EC7BB
      C80D7CAAC2942CC07C0367176708CDED429C9B49F72478647CC4996585DB7787
      8A7B59A83805A22975B4ADEC2F6D675D1D0ABAB9133B3BA675DD97E9D241E114
      7CC9C133DB53C346495356585A3054183310AE66D09B4E7A959A00111B242B57
      F8C30A506BA968E260EA9C7DFAF8168F307311FA79AC84C3869557CD23F3F0DF
      1011EE770E5F6D38F81772F06A2DE3CE593CB954EE92B567707DC073E14F284C
      D9036BB723DF36FE39E5FD21DB9A1100BBB212B681F754F8BAC9F8D82A521C85
      1B15B8FB73C4358AE9DB4B8E9CCE8C062AA3E84079120E4C965016687090E13D
      51A5A66A9553C7879775AF7357AB0489587FA5907CFBE67285E2145888B79D9F
      5F7E6C6BAFCE9B4FEF0E80727F5F51F0389971966C671A504CA72CAA0B0ABFC3
      4451F0C2C4F8384CA9E290395E14D380BD25072F3E9C9F3F7BFBE1C32713E00F
      6FC7B8CC5C9C7F6D7B15F35C765371EC7EE523793CC95512E1F169EA1C9CE3D9
      1E17AA5A7AE88813910913A1046D8C96300097C63A0674D3A83C5E3C8BD0887D
      C8B9A702CE66076F1CF4E73BE8D077DE3C5938E4D357A906F8121D7BA353CF41
      614A903068B56BA46E25AC40E2CE9E444F5E62E63C4CCA7A1EE78CAE0D184319
      24D516BC828ECFB542AC6BB05E5DF16C973D223719186D664322CED959D7B255
      5476F300CB3AD430D4DA981151FA1B85363756856A0427F7D25960387960858F
      34AB5F93E73568099F5E9D1F3D3B3F7FC560201F866D8C9877498D12FE4CD796
      C28F082970C10C3EE2F32E2700F80E884AD05B7461A1441016A736B191E4356D
      56E39D3C7EC492C5C6FEC4F4638AFD8CD484B6118C2452AFCC7A87B0C61490EE
      8BAB2CEC15EF595019A9604ADA57DA715A1F75A0FA96C063C3004A44CC439A4E
      3B8788F48FEF39FB1B397F69D7BA9380C2DBE57C35850333AA9F49BCD2595376
      4DE1021067A1B36A246B55D91A885B63E2D6350E0614CCC9C167760C6BAE0B52
      0701731E32C8EC29280414621F449848CAE19C9125EDDF3FFFE51D4B7A0A07C9
      0E343EA8BA98CF3E439F1C45C3F92BCF4ACBE0147CD023A608FF022DA9F45C54
      00EA87EEEE5EB21E21D506923313305F2EF014C5D5C2939AA363EEA0AF4DCB97
      35E898C252F262985150DD52AE28AC9D90D404DFC104AA3D8C8FDB1910997745
      312B8E23A4306860541C1290CBE4A19DA977C41EE1CFBB3388D8E84EF023409D
      4F8A6E75B46B1E3B919B56476B02F2298BD7CEF6BEBA0FB610E5EAC25F8BAF58
      93C59CE7107BF5C76AB1CC02DD4D12BDBACF0A3F6E3BC86A19F69B08C32EE906
      B3AB4EF6423C4B5C040F58A504BAA4EC133483C96AD93861B7C37884B61AE296
      54E73F830E12287EA38A8FE01388C4585D02ECF123934A4B53D2E6E7E822664A
      F02B19BA31AB5AF2DB7FFE6E000240FB27D26106404456679DE560665339BEB8
      5D53D644BD2F1762A16A25D39EC2BB3EFC0D0FCE6931FF51EE8DB11071314268
      66496863FE8A708D346066A4FB639664BBD0E97AA869BA158CB9CAD6B23D4685
      BD810A7B10AD9A50EC5AA1C21A173E8D3152B8610D855A003671B2F85FDC82C0
      1F7C640D362EA5F3232853AFA40EA15217A99CD19B97F0E30C93583FCD4DF831
      027DA13A7908FB2F4DF75039DE58194F099C844C9E58E852F66448A75052465D
      2F01C5C091C863AC5AE5CD9EB8664FD408AEC10260BE0853D75952603BA5EA36
      5B281FA27B6051886CA1A6C8AECA486309A1805E733021A4416B210CBB634D08
      3CEB38CBCA048EAF8C27DA20BE97CE0C6735384052E82E5AF9B903D8389D670E
      DE09C4AE24E40965C0EF200607A6FA70107CB12BB6730264159C973805920950
      0738C89BAB62A559DAF78E6E68382686774E8CE9C95E8C0630838367543FB57E
      601714664429AD71F4A1EF3B6FAE9F5E4EE551C97F63778873BC414007A19B70
      26A52A8A6133D88EAAA666E390002BB3BBE4D67111A801322C819EDC03EA5AC9
      A6CD58BB2B2FA4C27D88C41A3A53A0079930ACA9E6A0A685A929C706078DDB64
      BD6C6FDE4E4B81924F5CB646EA3CD15CB7CC54FB2EBC89397FDB5A4199379D0B
      5D43973B30E7785EAB03AD666A8CB7BE775E915439077982E55C7E5665EDDCC8
      AA444E5B178EF4C31F847781E18A29EF045F97F1D4D40099B75FFC2E502050EA
      B8451E13F4618F986648A4F3986289B7D718E5C0D291DDA0B8EB4AE461C9FA27
      BA615276A0C2FE31F940DFB9AE7316E0527F6A146AE144941630E39867F62FFA
      B9FEE9AAA981F127B60AE34C74D404281ECA6A83523EE3987366559996C21DE1
      24623FABDEF3252B952686F28AE4160B22CD671FD6CE1DAD3E0BD84CF70B1814
      DB4BB03F8B05A320529FB638A85400443855CA2EC6F8FB2A0649F3B93D1057DE
      1A734651B1B4B5366B8648ADC334ACEB14B91A582622A315BC074E497192BA51
      CA2981C4540B43678C3FBDF66B044822BE5D4E1673DB98FDC58AAE3963AA60E6
      FA78D388700332D9085ED0A59FD3ACC08717EC88751DA267FA13F6FFF98B0EDF
      3383EDAA43A7F12E6C618DC326889619FA40319A082384ECA7397F1CE1BFF6EC
      A9922F7962DACB1BB90BF1118B7770E5D5E74AF08334C63092EA4DC02B926A59
      00FBFB4EB5F1125FCCC3682BF2E409B3BF5151B832403C4BCBB638437993C4AB
      D93CB7B581335AEF775A9C36689007AE6105392432C589F5C415E8A45DD0828A
      203E9D6C9E1A180CE2DD8C26CE45799FB76BE8A82623B6F0A891EDD9F5C21AFB
      15EDFB540D448512E3122F7235B3587353431244254EAA3A9809CB012A2F423C
      D9A6251A74BF681EAFD77908890F93446DACBB5542261DACFF80A11208C69738
      35EADD135C248B0F7CB4A56A94C00EA319520BB6C83B0F5576A98DB84718054B
      CDB20C982C36BB9F64C2D88B0C561EDA9EAE429C482C58443C2EC9C05E4998E6
      DEA51C38C4A54180EAD2C139C2A803BE714559F9BDA90606D05A288EF1492DFC
      504226886782FCC2988E44AB4A8BFD420748FF337497ECB5B3C9A9841B7BEE08
      3F54359D85AAE569ECB4DEB906FF804D7534614A01576C5EC98AA94526136D6A
      733D292CF228D52F4B3E56EAB2F232FA9DC3FFF6D1219D3AB161ACBFC372C678
      25030167C1E7642A79638ED054A3638F0685354473658160161211DA08601700
      A716AC36E0FEA8CB82F4EBDC62FB46DF24583C813B1BA14384C4047B136DD556
      9CD1E42DCA55C00E719D3A2CD9969F3B5439166A3236C7CCA71A2776639DA4CC
      8912FBD7980B2B89F782BC28E48FC70A10CE8F225CB69DF7E26A2541FCC31AFA
      21487F5C4DDA18368AAA4F1B650948F244A06FC49D892688658B966580EB058F
      9839D720CAF03A88FC78ADA7414752FF3946CC5FC4A722EA8E09E85991D8298E
      AF30B2DA71B3D47F184C7E5434D8E9C0193F998CC6B0773FEF98E069F074708C
      B330EAEF31D330B63F3C1A172CF5F40A9FAD31F7A1EC0D772E007CFE76964075
      EE306C1EE7299C59A9E4C91CBF21BFCB419BDEA729ADA1D0194E00E342AF52F6
      1D377F363C3873D0DC286319224BD1F962A62C8EC22A0568C033935544467457
      3E50EA307304D2D0798A3466D45EA7813A7F8518A793829403A1102FA9E88E75
      26D484CB8250120ABC062249AB68E883A28912136AB5F09CEB6B5224977828F8
      28DCF02969F31E1594A8C15AC91E47AA3B37C948FA783655B445B028E715E68F
      618C6A4024456CE30749C4C78FB4847DEABC0A171425903CFFF989CC495E8BB7
      38FF8540994A2F6480613893AC5242FB9452952BCBC2E7E3681653F9A6150261
      E6D6A75E978DEE54394DEC4450E0FC3029CC0D1A7D6807B8693E4B45957BD785
      0DAAED5C3B5D5A0582D7F4C4B071C1C4D466768483970412C6B3892F54CC9D8D
      795F00568D450FB4C998F6E4A51B841C68EB3A13C40FC5F0252CF6A1ADE61CA5
      4598B3D425D50315E9A48BBA373BB33A8E50B1C9442C02A2A64DEE668366310E
      B96568E204B13C00F4B9FAE84DA7195CA99AE0BC54F7D922F8B45AE054263AA0
      2AEBCAB049DD52AE2BB3517FBBFA9D1D0E1972729AED1E42D3550C832AE1EC57
      2106D3C1C82091E08E4B1039304E0CE05AA1B68A2A42937535B0622C9621C60E
      9345585307DBD301C4D030F908E0B2D6A96B005CA3B954240B376205BAD881DA
      635558B23A7342AB0EA81330D7B654828EF39AD5046665E4185306A14B55362D
      90941A940D4EC021D6C4B613F7A01847A5A018BF2D1C0C285602FD99AB284837
      0D6FAB01E243F9573054D80F78B26A2C30B92DBC4D1FA7C59E2DDA2A97819B61
      7E571BAB11E17C4766DEA165E441B7D71C88B687B715F154B99F52C3CD83A00A
      16AB85EA376C96B91BAAA01D9577A17ECA214CA86249F55FAC751053D6482551
      3516A75D16A7A3FB6E717AFCE85CAF8EA7B4AA3CB5AA34FC7DC0473FBD86AA55
      ED6B16597E6B295968CC3EA68A2439CBB9D6178562A8A211E463CDBC69EC49BF
      87ABAE3AF12BA02269CAC49106696892625B36DED7A142ADAE31895BBB5C8774
      2E549829AC500600A0044796FCB02A2704B1E02EB0C6939BCDBEAEBC407D92C1
      3FC40EF4083D6D2A7151D99F29BA089F789033F3F811CECD2764ED3C398699A6
      861EF21A5A506C0D17BB24F990592A4D914BA0A7073220EA54EF246B0EA81FCC
      6B4D504FAE0B8CEC43C18956EAC70324FEF9024EA840FDB37831C1344565EA34
      F3428992BC813ADF7A8AF4F1228D532CD6A25F646D142ADB2A148A93577DDE79
      FC2810745EB7FA9C25EBD3A1A4D8FA52173F2D6713B82C96494C0A78CCA81C72
      9EACA20B47C68E29BFAA1BC5E15B057440AE9576A973036BB0D1C4CBDD3D3807
      519CA514E3E2AE562917CB14E463BC6EF4F6FCD17B2739336A150FE122A202B0
      CF7425D87CE9BDAD024539F57DCF2441CAB36834E45D1AF2F1FDD790410A2CB8
      BEBA1B9199222B1DC9D8DDB082A8FA23626F6156092C369DFBA6A13F49E10315
      2D5D51CCF10B1105B328FB35C6B40F344E23779D077EB59E2DA2072AE4DF4C59
      C1371067A5D4D451B45CD76D8EBB5B93F7B06D6D6C221A3F8BA443C31EA7C53E
      5C0AE908F97353E2382BB4507389BD837D17201A080284D95C716BAD8906D5B7
      6E711232DA0A589DAC0205D5183033161C79DDC8849037D8D995454E94D03E78
      69937DE6FC62A8BA0B543B4344D57831930DD9FD17527807C5BA27CE4B553391
      99C85177BF486B85F6C68700EA17D9A7A7E48A203400F223107AEE8E35C03974
      7A0C75504ACC305BA233EBE0D0E671687206E14423618FAF96EC7E584758D6FD
      904B4302094D4D5DF62B2AED86BBADC3C18DF1C65DC42BF6E963B845FDB41591
      AA1077DC305DED66600A65853929FC22B68068F2651C698881A99E40DDC39820
      9320C6B4A424262265C3C66AB2312AA65CC73B87C751F8970CBEF032D8804295
      D06A32BD4BF8D4F3F05AB295F11E46B44A56F5379975B4683BAB48AA886E7C9D
      549C015403AE7B290F4D8C00F56C2F5703DC4F913D143D9EEA3284FF5FED0624
      67C9BA884DD63638D6947AB15478A27A47934AD3278F48350A4180AE99308ED1
      DFAB805D820C43B87C5D666B2FBD3A8503487AD53B19F4E14F7F343C813F83E3
      E321FC191EC17A48AF8E86A778CBF1B087B78C067DBCE5A43F1CF2D3780B2CF0
      1135D33D3DC59B7ABDD32EDED5EBC37DF877301AD27DC3E3A3E36FBBE061F4DF
      1E08F7B9E3BCC0FF2FAE80B2FBE1E633C7795EF7F6B386B518743C52F1CD0ED4
      BBDD2EF98C1BA059FEB7BAFCF758F7F8FF756FE7FFD5DF264EB353F2688A2CFB
      C88E1E248CF8D0D2686299F9DCF9DEC99BCF692B9117FDD621C55B2CB50F4BB1
      C461E4DFC8AE85A783DB1FAFD23ECA07FCEDC0D355328DF257B25A86116BAC37
      111C654E336A4E11D778B04D7D013A387E6A6C175BB013D9B13A75276D46EBDF
      F6F72522AB2F39715556B22ADF10EF199BF306AB34DB5805AA1D38F9BF57E837
      CF70C630F57EAFA046D54E169C7121C452571F43F7A2C23950A04B78B33AAE63
      9A7F8D84DE5C0E0B736F347FA24DC565B01B67ED1ACCD4248EEB072A7ED23446
      DBBDB1E1D100C858320F421FDED476906A70AC910C7EC0AF7F22CD65B481F088
      A994B7056FBE0F72DDA75819A4803ADE4A6631A91762C305F556B27114ED7414
      8DEEBBA3080BEEBD4739F21FB4F4F5AE539B07CB4098F4FEFB34B3D5E34AC3BF
      FCA28744CC03C6549D549D0DFAE10DF955A4CAA12166F377662A9FFEBBE6A1F0
      C910033EFFB2A324C5831AF019DB8C5FC6EBE83BB65EEB31E7A7DDCC2A1267D7
      A81BA5A95C3C6B2C740F051DF37F825155106C3972D638C7FF7751A51815B1F2
      B677A85FFDBC7C866BD86961E4C6A1F34C41C1F3EA363F6A617BC8225C49620A
      914A5402824C41DF30D299D1E2940DB7BEE5943AFEDCF7B3EEBC89A448D26B7A
      30C1BC0FD7CB70FDF9D0A25FBD3B07CD4A42D356E8D7D46424D614FB66355123
      4744ADC503A7E5176CD3F561D778EC3E96F0A91A21DEB4DC266FC349AA323824
      66D0A04110C3019CD09D88506E3192868FD827198B50AD0C21561B8202FBD096
      ABCFCC43CB57DCD061910CE165C2487559155AF27B1C53AADD1D454CAF04172E
      42FA21AA97152E5B341A47666F49D5DB74B354A09E28E239D94A9A3C155D1A5A
      C628FF2969BED99BB5F7261FEFB0946EBC4A3C4EB2A71AF35E90123E3F61A06A
      1C40552EE0E0B7977022FD9D0BACC302220758E08B67E8594448A2065B7BCBF5
      A992C0196E3947C01A311440E3568EC83C218786D808A39364B86F454C5A7484
      9A6C4565FEE0641797707A3865912A2D2B5FACEB9CBD7AFB56475EBBCEAF1FDF
      BE24ABA3F3F1D5EB8FD975BCEB50D76D138875ED269B9C9905F6A35E3E18C2B5
      BDB888ABD54FE54C048663C81CB6AC42C9A8D61684AFD33F18CE5CD154C595C8
      5DDD339D976A8FD42F998427133496A1D3D84207D0F1233A6909938F1137C5F4
      46C7F66B2425ACFC98323459CB30F500ED3DAAA0EA2155D82CF4AF617BE5DA77
      86D4CE146C989565F3D379CB078B229932580810D8E9C669553687F28401304D
      241783F66B5C0BE412494C589F677F3B24F84E6470193867AE3C170B76E1DFE6
      81F381AEF18337D11FC0F0A91C97B427B111CEB5C9E4B40C8A8956B78BC9160A
      32128DEDFA961D219ECA6DABACE97813579DD1095AEF457565C1C78F6CFC6665
      CE2721A1050A950EFB8343B0F5ADADEF8D58D197744C93AB01BFB36AB5A65546
      DC25805A387F50C2A5E7512D3E4A6D55BD5F26621A5CED016FBE34295F41D1FD
      9382DEC0F538042167515F3E4C7038F0263AFFA01A83C097AACC239F045CC2AA
      4D521D1BFABA1A971EFB7EA895598673D0EAD37EB1B4140E8ABDE2728F30AC8D
      48B372B4D9742949CEF4E62AD804379AA94C7CB6839FEB0327FFCA659ABF63AF
      972E8A410BEDFD874F8E427576A34D56C693B148493D5B286CC6CC17A62695BF
      0549560CB7A9E557838F2895DE2B9C899C56F5CE26B837B87F9D0418AB78D89C
      A1B6C9DB5A17A974905557CDC569EBD22B04A75B3E2FE6E8B437D2D57BAB568D
      9B16761E7203DD4BC1A1A4AA6E891D346A50BE737B4E69FAFBE209EDA4CDA55B
      1D92FAF851E072A42C42FCE88CDEED2EE77AA72ABAC04A9911A03E66EA04C982
      E59D2A944879271E51796A714205768C724A7736C5C465E45FEA49C2B89F05BA
      4A89378F032E5A7BF05F42EA32AC0724280EDEC7E6C2BE2453D68E2C996BBBB8
      8B26070EB00625B76860C34B5510439D345BD60CE6094E9953EAB1ED9E1E6AFC
      A8EBE72D7B9F2A28B3A7799C550BC2512CEA4A6D2A8D99B370E0AEDBC10C6B50
      726B315B5B154FD4146391375AE4AA7AB555DD8950F536E69A2A416A8ECB2A6E
      4311464D74F600A212673B18DE56A02B2371AA1A9D593B522B73FAAEED99D294
      67BC8B5FD411E84C1D81F8685F83195657E1CC9DD2A05B677FC351F179CE7596
      E16A1644F6049A2CE3C52AB40BA93402BF5C2251D6A33A3960FD48E445AFCEDF
      36423BAF231BF198123ABE3AEDE40E23999AFFEFCEFF78FDFA35170A02D9B058
      B2372F3B372D1858670AE7AAECA97FFB9E1EEB98726C5338B4E5EB5DA4312E75
      508523EBDDC81F2B07B17FD9AA462FBF4FDBF4A3E0F2E7D93E0521D228D73BF3
      42D1B08E18CA5ADE99C52BA1552A6D0187766386B3FC77D75B51485B2B6397F7
      785BD502B61B58B64AEA4CB517624E01B41870452A03953635261B47622E1E22
      5062E6DD14A11C2CCD8AF5475ED10D6C4D9DC5FD838844028AD03F04C5C9C2FC
      920A88CBEFC3FBE7EF4C50D34361075F99F46051AC2CEDE1E9EBE0EA27D44D61
      03479EA895FC7093A1A9CF6E3AD1A3CE98DFC7773C6A6492773170CE8EC0ADF0
      DF67A2EF6CC436075250A4CE8C191486BE59CE06B6E88378A0501E14520B2E2A
      AD60F8DDA806EFF3E1A957E7EF826983345C2B4E2D7497EC8F784FB913263ACD
      6DCA1C58D64F451A3B638816B282F6FDEDE9EF8EDC2C2671A8E240F228E21E93
      994F73F50BB6AAC9417B4E020ADE12D8255B9A142E133BE0A423D338C94A939A
      48323A512E976120547953460F81EE651059747E5CB81B6584C4908B3899C568
      A3D4D82D35CC57ECFBC3AE611290C1FE56CA1DF6C38B49959BB8DE0595CC493A
      4E8BDD492AB44DD90955E71DB22DE18997F2FEA238D5F5E6AC503871E552700F
      FFA09FE4B81C7C678006B00CCD014EB40C99C20D622DC73D601C347E8BF6DD33
      600C81D96B1D15170102D32771946616795FB47530620D4AF232D1D3CD15D48B
      134CB181B0A1828890236CC6893FBF5284B0A71F0D08A0A6BFD24B836E7553AB
      15B448E39141B89134D9EB1809AC5C937E1ECA07E75215D12C02FEEE930E8783
      B31DA2B49DCC18F5B6B10A92F32EA8133F16C066B90CFC151C89F48EA0CA76F9
      57707BF61BCC5EDDD14087D742B615A13D2FDBA52EB7D9B2E07ED47239E4B615
      D63783FAB81416B5F50E3337D416A3F50ACAE6A0B4B67C1B7A1CF5494EA82681
      CEB2AB0788CA4B5C059FC22A6FAB3C3BBB406F36578657619D61AC82B09AD83B
      45C7940B19E09AC6785F8A8EA550DD2E3BBD6D28558AF3626FBCDC89BAA67CD1
      1865ADE0E8DC3081FDB0617066FBFDCE76AE79C47E78F6EC28E014ECB689B395
      35E44335DD03555713867BD8E825D50217C34DD8D6E9B0BDE235B2DB1F615A9B
      C0B502A86A9E560786FF6B934F46389DC89CE13706580EF46A3F40234C2E63E8
      30823951AA8EE251FF41A226073A8CBF703A9A1DF8999B5CFCE11D5707FE8BD3
      6BB6478DECFE6C4E230B692F8BCB92D549DDCC429BDD9449BA4FB67A6FF07BC8
      7659DC4A6B2DCF33B7AC151427956B3553DA7604C8A95C315341D9568418382F
      8740C8865DD4530850481569CEF54905B969376DACD525E17A73AB7BD83E754F
      B7508338E625D84223C1EAE7924EE10C43C71E157B47AA8C89BD6B10C20DC55E
      EEA40F68D3AB8075E944D039C3A3F351826B5AD98DD051E0324E1D2740C3DD6D
      A7D3E970F2E602C30D67583F7C966D6A75703F90295EF9CDBCF077F2DEE8470C
      204D14AB3C2BFD8B395642AB3385A5D1EBC2BEF26A0C358E544005A7A161EFB5
      360FAB66061ABFB487A57988AAE0E1B99C426ABAA00B8BA0BD7FBF604E85BAA1
      6A852A9733A59DC55C92A0381B682AC8A2D3E174732992342B808D9E66B981E3
      E802A3421B3651EDA97117E26D105D38CF9CD71F86982F83DF1AA69021775A64
      D1413CB8D75E0FCF5F697DB606C8B317AEFC3D3607417CD3814DC70D498AC226
      798EB1E01F861C72A57AC7461A97F13D6516EA482590D505AC93DD2E84426691
      DD2A222BD83289D0D1168FFB66A95C5F05E1E027379D1F10549152115043513F
      EA8C2CE423F523D891E5EA6EF86D6487D546418B5BEFD086B02A61CC09064C96
      D242B256FA80D1CC507F019D8CA9E06ABBD37E9CCF38D373E5CA19F7DEB82468
      A1E15463F03A7BD3275A28A45A22E000B2F404AAA3D830BEBA2E6A6D23B6CD99
      AC39291B7665431166535E3525126D9E196270A6A36280300E3447524D314B90
      2F5CDFA45E6ECD888941D65972B0FA677BC58CBC893810CD732507394B6102D9
      55882E56A95DDB0139AB083B328B2888E1CDA77764C42643A34600B17EC744D5
      159C71A23DD8DA73F642061EB04FEC4C2017994A65E5DD29E3391E0415683A50
      54AD106522D4BB7F9B746D53E089F28A7445BD2D03091D27EB644547C6D151B4
      132BB46AADD7593004301898350C7B2780F60C6940E53B99D128ABF464833560
      9545A79B65FC805E8A77510A350C3CF079F8374371C35599D60740CB5582F567
      0F7690550D9350F9F076E9FCF2EEF94BE7A70455D534103528C98676A4DDC179
      9AACBCF4008F1507CF0975127ED217C97DC711540B811B4A0557A1199A2B11D7
      6AA78D70FF38BA6412A409663FF1F664D83AC1B167C4C4D127B64746D49B54AB
      4139AD01316D902687CEB997044BB5EF0D8164CEB4F0F31B3866813443281C72
      6420EC7FE2CE9E444FAAFDEDD06463D2AEE6CA3F93D6866A4E9CBC7949E08FA1
      3B63CEE652FC206C4A8A5F6F249925373EBD3A3F7A760EBABED2B69FBDFE303A
      765EBD7CF3492F7B2BE500E54B06BAD3D65924A6B0CE3209E244A50778CB0F2A
      43630FC5D17848D9CBAF73B15870D2DB918546A4B626A0326B4CCE8928482B57
      3DDC715E60566A9A3F32B0C7D8AC15365A60610D16805CD19BB9A5B26390593D
      C946CA1649AA8775603251B47D50DF553F0EF5797684714404072202497581AB
      E84E6294FB1AEB1AB8D596E7C78F9856B044B2B9227A98838D266591906497A0
      E0D1AC435C3D9195F42225F929AA5AC2478C28269B068207E20072710A640C81
      0DD970B37A1E088EA8F0540A181C0E9F11C931761A5665C3C66CE4733E25662A
      17E757B051BE848EC0DF8AC17A41597F839B8CD88BAAD3C9D3CF7FC2C06F3990
      300BA7E2181C2B2FBE8572829D23185D74681B14B22D9FCBB3CF22FEABD772C3
      11AA4504AB8E987887284A2D9C8B8F1F5001851943282536986566A116A22AB5
      9DE7673F7E64637DDB79FBFC3DDCF6D30F1FD5CDEF9FFFF20E1FA7162F03D728
      AB31A136B60E2D334E8DE393644DF8B0E14C9682C5246D6B3CAB1DE788FC7C22
      A561B30DCDBC5AF648957F8E0FA149728F83A14A20D6CA92C922E642679468CB
      51EA541D11B3E4623A44FDC5B96A3B9BBDA0D273593419C4A0146E825E523475
      58E9E03C784CEA0D380429974C4FCF571B9FD9BEC88C069D491A01E390563919
      1DD9C7947FADB2164CE355E42BDB2817B28A042982A8C0EC61D4CE4E8AFF7F7B
      57D7DCC68D65DF5DA5FFA0DD9771B6BC49E31B98D43CC44966925A2793899D99
      DADAD9077CDA5C4BA25694E2B8B6F2DFF75C7437C926D95437EDC43315D16549
      2401347071EEBDE7E2B32EDADAEDE683CAD76F1BEC957018354E3F160C52A5F2
      DB20148F387F5CE7A4612DBAD319EB34D4C5DB9ECF0E6F1E45EFB7A7AE11319E
      30555DE9DF48870E16A5EE9E8FB0D537F534C7AD5120DF0E835135A60F7CB537
      807541F531DBD76EF1DCE0BA6EE75A74CF7B523772D7B10F6817FA6DD18F5C77
      63349532A39A37793D2A44F94E1B116F3750D38012A1E4FE01D8F56879BB6CA1
      8E356CC3642DF95FFD2E93EA223E0451B9CC08B41E36944F1814E92F0BED86D8
      D6A60F30DE684BBBF2B857CC07EF3DB42E47CDCA55CEADF5EE2E13ADBB59B784
      DD9D7FB9B629EDA8447AB2ED70EB38D5FA8B5AECF6F566347275D31E7005823E
      25F8BFDD72C3ABFEDE15BA0CE5AAAE1E6EFD5A1B99D739B76ACB5A23556D523B
      7BB16DD4C3DDCB2EB61A0C23AC9B55871236D67523B1B468D73A5CF677BF6CBE
      EAED6A3BDFB095BBA504D55BAD5781F507DDD020542B29CABF2544F2377519D0
      9B091D7BBFD1ED8E8AA173EABBCB579F6C96B0F7846223C19AB05F165DA54619
      884BD03774B3CB4D7BD458C7297654EE617C7742FCD3CFE96C6E40A691FD0357
      1F8340D3EAA57E0DFEAA4E10DCD1646837A0F860E1B609FB2111AE8DCFE3CA9B
      69620B64F662B1A2938186B36B130C52671BD117D0FEBA2E928670F7FBA52569
      DDC8CDF62DA96465DB1D1A57ED9178DB9B4268FDE57AC348B54AF5E6A2C142CA
      296738AD4F43A2150BDDE9497ED50604376B0EDB9E1CB4A92671D6EE48713CFA
      4FD5DC6F46A136257627FE0F5643F4DB38BAEB2CA76C5FBA6857CBE221B42BC9
      53311F9F3F7EDAEEE9A752FCE0CCE4ADAD711B39B504B6F54CDD6900C323A4DE
      A0A277D7D33770B55732B40B498633A380CE22E68EBDBECC753DC77A858E3FA8
      D1F44D1B9D6DBCE8B60FAE95A7665EB6F339143A9087EBF60E55004C90E4C073
      0DD6D2F4FE65673BE293B165C6DB9EBAEB927E49735D3BD3178D209396931341
      204CB55EAEDDE64697716DADB6E9734C58E3FCE039261DD742F4E35F7B31BE6A
      175A1F5ADCF5B035F7E016985E80DBA3811325D9EF197B55CF92CD57FD71657D
      11D79E6E95C8D1D319CE8BDB7AE5028D0CAFD609EBCADC57B49AAD33ECADE5DA
      DDCE3ED8F4D61F65DFCD6082CFB623129BA5677569C1C7EBFBC81ED4671401CF
      FEFCC59FD06F1D0D7ED08C5E2E7FF537F5D2805630B4DAEBFEA19C9DE5609D68
      2F89A9D0ECF7D56B5AAF9557CBAB7F79C0E57DC27CFEAA2E4E58B6CCE17AB9E8
      A2C004E5BFA499A8BABB1BAC6D79F3C0F8B7AE29A8FB2B561BD6B29E0EE82C32
      CD1394BAF1FAE6E6EE9AE8C78E90BB35798FD74C91C66EBFF5DF0E1893EF87D4
      C9392CAEEE2ADE13DD09D32E24D8DE38B2F5E07AE5C79BE9A77F1F69CE9BFEE4
      5942C0F932D272B77E93D01023B45AA57BBB39E57CE6FDAAB45CEDF5153DF700
      24F701D9B77909A02CE858B1A7448E57C9B74B2EEA5EB4F610DBE2EB5A8C7629
      057C64979F9ED7B6B3679E9D334498D646178B9757F5540374CE043EDC0502EB
      B588B40CA75DDF8258EDB6DEF64A7BE9284DB859BE6E99F65517727C7CFE9FCB
      BBD60DBFAEF31F8122B7BA1AE4CD0341BD7F9C717953B7EED79DC6DFD44590E7
      9F6C6EA5E93E219DFCFE872BC2507B9FCE67178BBAB0EDFC2F3F3C7FF130E93A
      980CDB5984BBB3ED8344B93956A32E2E25CDB90BDBF371D562F4A27EF6FCC5F9
      1FCEBFA7D06C8232D5E8ADED9E1F5794FBF3E7C84DE7CDE4963F6F7FF78CBE7B
      B6EC9646D46F3E1A992D5E21760697EE4F06A99477DD8CEEB2ECADE9E26D3CB5
      AB538788EA738C5C43419F75807BB8FD6C72B0F9D9F5358C6FBB28B8EE75ECCF
      EEDEDA23F0A0AB5BFBCFB6AED4DD59ACBEB931BE9DF7ECCFD35EB6B7FD2DC3F2
      A76EDA62FB5EDECA042E1697F893A66C179BED035D297DDEAAE457E337B89F57
      6D80FBEB6C487FA8279DE7396F867A3069B21ED569ABF3A49F49E8573174B51C
      9CAB74FFF1DD8B3A4371F0E47CBF7ABD3EFF696757089125FFE3FAC2B4F3C7CF
      7BF69016AB0870D265BD5D96CDDE91E9F46C3D24B739C03E5E2C57DD2EB7FB5A
      FD8E8DDA6E4E7BF8FAFDEBEECE1EDDEEAC5EEB2AB6DDFAAE53D1907E009A18D3
      AA9E0AF0A45F7DD89E85D5E5AEDB17FBF530B4BC8420F7BB159E92E3DD9C3526
      F5C9ED936815475BFA7AA7338D250E66A156243E9A16BBEB0ECEEF1700D508B4
      E37CBB570450310F96FEFEF8B30ABF12E37F42D3FECB9F8A0999C48C78EBDE84
      991692B407517E5DBE59AC48AB1EFB4C4BA07F7FFEF59B407F7C0A856F93D03B
      B2C0BFA70924A4C437CF9737B7ED97ABDF9F3F5D2E2F2876F9C3F90BBAAFF9D3
      F77D1EE794E3AA88B77547D35F752C0B215EE86A76DD9FD779E07AE9FAC7DDCD
      55BDD37A3341D21F9C0556B6BE6FA25EA0D1AD7DFA00879EF6DDBBD57BAB03BD
      B6EE977B0B7CF1BCF6E7EAFD77D994351368443BE7DF1FA1DDCB9976E3758DA8
      F393B5851FD38461DF29F594C576E0B9AE99686FFB3C8FEDA522E75BE81CDC68
      BA36B1BFF6B2AD4DCF3DCD6025EDE1AF8F7D77AE55EDBCEEEF0FA33DBFC4A9C5
      3384F2E5557A7791A09DEF73C1DBCE79A7444688347573AE34CB5A16F1FE652F
      DD6E633A3F34DC85404794D76D93AFEA76A3DC91697AD8ABBB9799E631AF733B
      C257D7AD50F24F5A6E5357EBD66DD0B041B41573D6A994DBCDB958BC263AB458
      4DB87F73E31E6F7F724CE327B382E31737D2E297D05AE2975490F2ED4F4A3A4A
      A225A32446704A62B9946D6E4A021F6C6A318D73948831D7502AC6918E7E0B23
      6B3AA995FE657D325AFFCBA3FC477FB3DB4D6349CFB736B35605F8BCBF7BF9D3
      A94504322FD39FF7C9278897A727DF365E9BAA7E34B976E7743DE4F4C454BF76
      E53DC0DB3DEFED3AC284526EEA30BDD0B2A80BFBE6D462639E4E6B74BE4A9353
      6FA57D20B45B2E02ECA65EF4F1258DC57FFE2AC7D7CF96F1F5AFCF5BA6BBCAEA
      8F7E0167B92F891FAE2E3E882CEAA6D781974C8B559DEAEF2E6589543B725BED
      906E5D1BB5B33F61BD046CB3826BB5BCFF0A78BAF6AF1B3E5AD5733556CB8B1F
      EBA369E289163DBD59D4EDB8EDA10EFD6D35FD0A37BA596A73E2D0F5D66AD00F
      B1A0FF6FCB9B8BF4FCDAC7FCE4FC77B448E9BFBEFBEFDF3D6983A90FC10697FF
      3072604FD43C49FCB224907C91AF5BF56E720D19B7166C7F34BAA1EB0D356B45
      CDEA361CD15AC6BFAD3FFC60D0FBF2DE142DFFA66DA77FA509E8DF4C64D2051E
      DF7ADAC7FFC19ADE6E6BAB27100042AFDBA3BB2EFCCB151D564E47A7D7EB3CDB
      F1D8BAA161B0D295F65175D7024CE0139EC8F9EA822B879F97200CBFEA9CC7CE
      C6EF5678863BE7843D28BB4E5FFEEDEF68FB650635F3E7AA91A1118D64B2691A
      8DFFB6A92F0E8E945DCA4D09A594F633161B5E7F8BF6BD0A52E8A2B3A198033F
      5551D238D36865844A3C1BAB938E3E3A1683CC51888635488408A8442BB2E249
      FAB3472E068E875BAEB2B33C1A9BA3F1DCC4D8448B5847321D5DB2817BA3142A
      63644C5C49C9BDE50DD33AF2989C10C5B82C42168687C44A63828AC25917BD91
      DE97C225E7784C0E2C48A39257A920602AC9F974F64869EB2C631E215AD4CCAB
      A6385B64F02187C8213D6B6C235198F38A7B6542D66823EA11B84836BBC67056
      5CE365E2C50BDBF01884329A6BDB940471E69850759622B339A014266C16D149
      914C568D08FAEC5168585256A49CB32A0E629099BB26A00EA2082DB38FD24BD1
      582B82888D83E072F4B63809D9308DB6E16D70DC14C5B3971C4FF12C26E52224
      551C73A1C95665ADD02D4C286F53E64DE14DB091F1284273F68884AD4A2CDA40
      AA7840D6A188E0B275A87E485A391D434C686FE0369B28B4CA31A21AAC14C49C
      4D51A264CB441231A21AC194162B85D003BC1CC3197A0332F006C5B61F364203
      2AF40A1DD28AE1C05844685C80ABEE6F4B402ADA13B2507F938B5521418CCC24
      C81B2D6340157AA278E51A29A87B4C4287206836455BCE59484044C64F59CE1E
      45746BE343809C21EE5C8AF14EA4927DB6A1B8CC9CCC241DEDBCF78D8E227309
      E0C5A06D66468B04701620D859E5A5375C35A80EC0D3588DE7E21981001C5593
      98171053128C05AFA40D5A344E318E5E28D626272915F759722D13430F3789A3
      422A052135E7D2146F1C334C9564803C4B55CB9019344314C53414CB0883A664
      5BBC8DAE14A006328AD165592243FEC26356129DA2A1324ECAA8F195460D3C83
      5E952C94080998B65A799F24CBA9092A00714997D4F6CD949ED5C138A799B69D
      C5B07E6D49EA0B96034F809550BCB47F9F3DDA7E477FCB840232FE1BD815DE5B
      153426CAD4A0EF395915F4A9499E19E31A58037446004CA5D250FA187C0EA1A0
      6652B8C8BC64B02F90A82BC03534300B2B844194001C4365C2D923B4077FA023
      63639A64BD563039D95A02B581BDF106FD66939796457454D431A34C0605CBCE
      5806890769A168A94807580A85BAC154008340460A2A25DE241D144C95E22CA3
      2F525219FA2B0114983AD4C028932D7A13D61C28C39768083AB4E1C2CE91BFCC
      ACC826998A6CFA2AB0DA034C8FC9BFFDFBECD1E69D60BDCC7384452996B44533
      1932014994C6A604E31682CE124F0B2146E674467A17D05219A5CCD2DBACA103
      1A7D66344C19B4D3C0B2A24D9254854786DF4920B980454C0538809E40CBF070
      E87081B80294413B2522943135C82B947330E8D1A40417C061EB38B48F2958D7
      5C5086830D4BB02A2526699DF125C5A678679495E873080DE876CEF02C1C5458
      79A8230B4E68F42C1A58481B8D870A7B0D87C322D024A454CE4A4768E2B0B6A8
      4E4A4D1125581B8D36167E42E868D1DF8E2C74E3354BA61139050E3BEDF08426
      7A01397107F135B664077383CA00943C67A19D610C2934C4CA8083C4354FF8CC
      FBA858033F0A5B01AB252D27BBE5603618A957E00D200ACB854E81776B3C1503
      4D9711A62C6A9332BC9B0E0CD28403C91C2E444AB8436BA00FF0E2A8B8D03A39
      ABE1766D6E60C6440E86C3375ACF78934D113227A515A09463E6E4A7384F70ED
      161E3215CD3D0CAF532616D82BB87AB8CD82C7012F64360BCCAD834DCC504497
      14C802DC1C24889C1150473725ED612A7CA1363542320F40782578866FF4B140
      6D9C3142783010E0A5300F4803480E0C023A267828999344A282CF2A5693CB76
      125D1EF029DC428EC518F4211C970C30CCBE185097068A05BA80D6A027083E51
      81BA40CBE123E1420C24EBC050F0014C21B7D635991C88CDCAF8546C84FE66ED
      9AC6917D97E8FF28901D761EA08228ADB21CDEC9024E41C21969000CD0D6E82F
      18906832941F4A281D440187CF41728A2614C110A8262A913D3C00B3678F9840
      4D0ABA13820D502FEB15F10CEA14979D70700516C5176580280E89C37CC3F7C1
      5A5BCE0C8C03C11ABAC60AA404216932F84031EAD0507FF04617950B24071B06
      11E490E1792C7A431AB8BE78F6484472CF70BE70FE4902CCB05F163CCD3BED8B
      824341DD4B86B279EF0A6052A08330AD0599E18224986189199A62009614288B
      F396C1D072457E12859694A32D0C0FA9EF0478107EC071C15928E80294077E17
      54148A809EE12A458020414118914048AAB14642EEB0C0A8738265865F00CE41
      EFE03B2104095F1B23E84003A7AE904C076A68C32423D60A38C3B5C266366045
      70C9444813AA05DE5560AC80031BC1872203D144D9302A30A036C2D06B1B2C18
      4740778364A12EA07716C046F5E17099829748494276A0BD1294A070280FAC18
      6C54036AEC6054542C1E2450C3FA1083B319F4D17A1414391C1303178B12F6C0
      8606BC345858670307C31B0F96CBC186228767411A8D3CE84EB87AD42EA2ED5E
      79B083E4607AD0F91C1C9CA16A11F694C1EE59784AC59C20BFE42D9C8B915C26
      32A2163A08022B808F085B8D4624E1601389E6C24270EBF12C18544305CBC841
      5AE020F12914D1370E5D815E07E6812E03293981BA49F037610135EEC9880274
      B06F205AA0BF2A59293C141E5E24351929D166182D0E8B05060A7707AA0C470D
      7EC00A050C204E99F4B9C29D54074C06FF8177D4190E02262F810D3406EC34C9
      847A26CBA199D2159F8998485827A5101D04B84AB05820438023664FD64CC3D8
      81CDC15083BE8186BB866594872817BA0009310FBF1CD049E08EB08EF8133618
      16AEC000C39629C0412A68A52455836F80CEA40CC4475DA2F0E8C6009C672E60
      B20AFC0DD0816AA3F2D0D214B40A02BA019397331486EB04D52A147910680A6A
      90738377E0CD30CEADF585ED8681CE0A8D803B84CF2AAE8017A14226A26C0663
      C303CA83EE48AF0DFAAC81CF73A0EBE410400A61BA9A901B6F103C08CDC0DE13
      221FE006C60BDA86720B67020AD0180D8B84BE0BB0D6C0B1839B41EF426D05A5
      44529822541425EA820019AAE3F1348442E8BFE4B3D3B0E0F0BD0E111DCC0702
      AF82E02790D786C100E18202C23D02B72A50D064404D1C47E3C042A129A691F0
      DFF04C2938701F084740816413893D41996063C190E146609D10C940E3E19760
      E401C506B40192C7D303109B14381141152617060651164593143A81C9180497
      0E4C8EC1E67B8576A31D8E3C5248318299C74C511BA80E088FD68DF64C01A2A0
      0130DC8A482938117C327C280C80876F87BE2B018AAEA09F5048C01FAC085506
      D1D000A0948D063B55F03B884241B66D42C7216EC4A70A8E09661EAE1CEE14BA
      064F8E6284420D0AA2589063A44464673D58125A08494178A83EA80004E203EA
      46B96006353894C1E30048D87A7882ECD19D0C4E81A20103AD8A30D3524359B3
      2EC516F81B84B978077F8A8806D285F4B8131E443C51DC0854801BC56A904176
      20658489B0991254D5936E7245DA132D1449831B087415FC4D460884BEC15759
      43A740E460979449C2939144608708C7106CBC43B1166E84D8B5011F071C616F
      0D8277431C03BD40112D4C0D7940683F47C0EC5127780DC124CACDE01FDCC1AC
      6A901538701863901CA8378233104A8BBE82885DE12622F891F0CB8CB9D440E8
      14EAC29DA12ED4E6ACE06761529C8A1014A806C4DDC406358015E10E7414DDCC
      941412913C626C7411FA059C4C474F1C0D3159829E83EB0169149DC3E427B824
      92BB44688738C309815820C0DF790E68213A819182710FAC0161818F57304509
      FD100C54834628203289A82D117B6960965D4164A460ED5033D814CF02A255F0
      06B20F4D881C5C49F20012086F958C015D867146CC0B8B832E733484436C2518
      184806F8C2D3C0CFD491114424903F22294484681CFA121529D470E28978241C
      08E24A9D2CB82BA22589D4E0371CA4013DA025025A16211ED840B06470086360
      3FF08146DF83DE4444A90AF8454806C78F7E8196C3BF66AA26781C8210665CAC
      ED4F01FE8846BA2083442E2E018930C211D61C2101AC04108B9A46D620DE094D
      41C3B933B0CD225308482C0ADE2D6528302807E91A625E9023EDE006811DE81F
      185BC80A6122682B0D3A90B81D413BC37AA3DB103B91D220EE49926A001CA081
      1A8E013DE60BFA028402B4072C0D4618C277C97B55324C8FF028D940BF28AE06
      8A10E043E4F00A1E9C499384D1470A8623C02E19A828C2787C0623030C030D68
      3F3919C01280D230B311440A1C187123780D3C2CF281F2C02DA10690E1D468B1
      81D1728DA3DAB6517A68234D6E8E478B9BD119F8C67B23F7E1F84D8DE1899540
      31A0D1DCD07049D1B020C153C4033C256B9108AA438152960281210548088B19
      6291843091221A0B7A055346FB839C03B90DCE80033A90332855CA304CD065A0
      01DE0809C0ED1D620CF8290BD6090E88401C1EC0BAE4045C4180682C0C80867D
      CD8981C23804BCDC4A0AC824421F3C4D80861B281D874305050747012B97051C
      090A8500D3834D21D2919C7BE141E311BB8504E78540045A0BDB46C372A0BBE0
      A940B14607C0BFC38B30545F21A4A0511B88013CCC3A0D7CC24D22FE420783AE
      C2948032928DF234FC10A16620739E345D46442C0A7002C2417BDA9E1BF43E7C
      3B07A13A65C4F7D86B7B34182C6D743CF8BE3AD068E0B1B1C0432FD1B4698648
      DC20EDBE67DE374E75E80555E1C7B4627B0CE5B026DC57ABFB466F0EBDE093D6
      B5422F1CA8D7A1919DFB6A729F65385813A8EF31F96C8FE94EB719B5A6AAD948
      40B5FF55372A1663E3FBAF7E3E7B44931D7179B1BC59459AF2B8F4D7F5F80A44
      95A52B19769A9E64044C2BD08B988A935C10FE7144C550604DA896F816A1257D
      ABE0EE25A24E612905E27D596B4C3F239500B9229571847A94055A0FDEE96966
      016600B6DA207CA028069CA269EB005D11F88EE239040046E25F038655380D52
      884E32D0790447C5D43A75F9B42619D277B2FB9693A5409CC5F19969EB5C5B09
      2227A025080D0BA5D78E34B4B6103944FB64D01AB49CDA2441ADDACFA40EED67
      351D5FA7E3EB747C9DAE7E86B2A9CE753EA82B63F0C9264D45277DC6F752ED97
      24F6D288BD34722F8DDC4BA3F6D2A8BD347A2F8DAE692C244E120D6D3FF5EFEA
      77E8091DE530C5CE6748072C7498A4B389AF6E57B76F2FF2EAEF17ABB4BA5D5C
      FA9F8451F48696A5E4947269EA57F972F16A81B757FD277757789F6976BDFFE4
      7FDB1BE2FAB7FDE9F678EFDCFF6D8ACC3FC57C7D7BBE95839D6FA76FCE37699B
      F36FEB19AE9F8EA67683D474C206A916A37558836AB7B9369566E315385C24FF
      F43D1728DE7781F2FD375ABDEF3AEAF75DA079FF8DB6EFBB8E6E52817DAE0554
      ECA7C9081EE69A06D2619E69381CE69127E45127B5681A608679CC0979A675FA
      308F9BD8A21E1D62088FDB654437BF6301D37AFC4801E2DD1B310D0D470A9866
      668E14A0DFBD11D34073A48069083A52C03C33D13AC6F3AF81C4ABDB99AA5596
      CBDBAB256DDDCC3FDDCE7AAABF42BEEE4CB5B979DBE3AF6665A18AB62BE8672B
      67677C4FB7E5420D4AEDAEB99D55FDDB76556B392F8B9777377935B321F9EAC7
      7CB1BCAE573CD27928B39EBDCEDC2E779C2DF68A8FF5E17AA7826453C0BCA6D3
      0ED7EE4AB2598FBEF62F4FCA075EFB0E0DEE73579598D7D03544FCDDED2BC2DD
      22CFEBE74B1F6F96F350B9F4B3B4A3CFF76CB19ADB3ACA72FEF4EEE222CF3315
      35DFB7F3BBB1E69B47826A96A94E7090691E09AA59A639BA03D23BA5515DCE93
      DAD6E53DA1895DCE135ADAF6F7292DED729ED4D22EEF092DED72AAF1E0940D63
      D9178BDB8B7986E5F3F6D08499ED7ABE7879E5E9E2DF598C6458C617DD1D9CDF
      F91BFFF2C65FBF3AFFE3F26A9E123F5DA6B7E72FE6B28475AED3A84DED99CFBB
      43D4E6F7699FF31414AEF3CE8BA88679A706F18773CFD3BAEE34B8F3AF36C4EC
      308C77E075176E6723F9B9BFB86B39C1CC067EE16FE73D6903A03FD69B743A18
      BD7B113331F12D3182AF3A3F3BAFCD9BE7CF7BE426DF3C08EEEADCC98FEDB2CF
      35C44FE98FF9A6E2ABB7D7F9064CF1F5AC5C7F5CD215BD390D731F043EE7430C
      DFDE2CD77D7938C3D0E07F7979FDCAAF16F308DD17CB78576F54FEC65FCFCAF8
      DD051DC8345B8A5FFEFBA55F5C6C398D797DF7D58B6F9E9DBF585E1387A5AD7A
      F37A90323F5DDEDE2E2F4FCADF05C18FFF96C347F31FFC1998F3D5DBCB531AFC
      D9091159CDF8F962A6396B732DD309B9BE58DF507D4A13FF23BF0D4B7F93E63F
      F7BB9BDC2AC76D3E21F7734FD75CCDCFF702FA4CE732CD1E2FA8B9E978620AC5
      4E0D745777E17F729CA779DF2EDB986A4E9E3FB7A73FB57E7FEE20F120F33C1B
      3FC83AD3BBD09DE8CB2DCB343206F6A286C27FBA59A491666D19BA985F2D2FE8
      30F575A18799CBAEBC69876A1FF7F689F4D0683FAB57D43C7FB50990D70977A9
      17255CF7E03A153F906AAB55EB7462878CA5C5DD65FFDC6E60789D561E4BCB87
      69D5A1B41D5E0609F568C29D12CDA184D4A4DD12ED6842BEDB7A379A540CCA34
      C3DEF9C2DFBCDE97B9D9099B68B2BDDC5D1CEC45C30FA7DD2F541C4E58FB722A
      80E064E82ABCB5AADE8BA54D8649A01A497E1C5B23998E836C24D311B4EDB67D
      4C9FBFCF3F2E56FDD8EAE1B158B9D3FCD556647A84BF0D41F697BB65E77C0F3F
      64D88D5F5FDDE6AB55DECA35457146FBFB880E8D48F688328DE438A25387738C
      29D748EAE35A36D6F4630A37F2A0239A37D2F4092AC8A719F391E4F729E09E81
      9BA682FC14159C6EF047724C00F05E7B260098CF06309F0D603E0BC0FC1400EF
      367D0A80F96C00F3D90016F3002CE601589C0660710A80C56C008BD900DE6BCF
      04008BD90016B3013C8DDE8CA49E06E0DDA64F01B0980D60311BC0721E80E53C
      00CBD3002C4F01B09C0D60391BC07BED990060391BC0723680E52C00CB5300BC
      DBF4290096B3012C670358CD03B09A0760751A80D5290056B301AC660378AF3D
      1300AC660358CD06B09A0560750A80779B3E05C06A3680D56C00EB7900D6F300
      AC4F03B03E05C07A3680F56C00EFB5670280F56C00EBD900D6B300AC4F01F06E
      D3A70058CF06B03E32743794034D3A5EE4E18CCAE1987FD8BE3E8A5F673C327B
      23F6E739F1C8EF074B820E67E4079F3925E750484F97CBD7339609AC4B19E2F2
      E9225C2C96756CE4EDBB2C8FDE1D9FFDF3E7EBF9CCED64F2E034541DCC1D06E9
      928F261C0643528C261C924E294713EE5208A946930ECDA81CAA53856B9BAE1A
      BC615A3D96961D4A6DC652EF34DF8EA5DB69BD1B4BB7DB7835DA2655EDC5A058
      C5C612EBB5160F33F0B10CE670867BC5767890E788FCC6C69E8E8872E419E332
      3D9CE13ED18EE49A20E3B1364D11F748E3A6CA9DCF95FB64008F8DB14C903B3F
      49EEFC64B9F3D9201F6DDC54B98BB9721773E53ED9828C8D254C95BB3859EEE2
      64B98BD3D0BEE72AEE97BB9C2B773957EEF224B4EF19FE19729727CB5D9E2677
      3517EDBB51D504B9ABB9725727C95D9D8CF6DD36CD91BB3A4DEE7AAEDCF55CB4
      EF460F13E4AE4F92BB3E59EEFA64B4EF356E28F71A114D26815BA98FFAD0AD74
      474DF856BAA316642B5D47018F1A8EADE4D348E056866924705F6C9348E0B6FC
      46328C0B7294358ECB741209DC13EE24127850C6233927087BB47153E57E9404
      1E92FB64008F64B85FEABBC46AAADC8F92C0A3723F4A028FCA9D9F86F65DBE35
      41EE4749E021B94FB62023946CA2D4F7A8E30CB91F258147E57E94048ECB5DCE
      45FB1E6BBC5FEE4749E021B9CF33E123B966487D8F3ECE90FB5112382EF7A324
      F090DCD55CB4EFB1C6FBE57E94048ECAFD28093C2A777532DAF71A3755EE4749
      E021B91F258187E4AEE7A27D97584D95FB51127854EE4749E051B9CF3B97E01B
      6499BF0CFBF9A5BFB93D7197C3577EF5EAD6CFDBE0F94377174F4EEB0AFF5C6F
      6AA04B1A56B774F96DC3EA59474D7BBE53D3B0EE7CA6B347928E7BAF270209CE
      B3129229ABAC4C322A3A358969D99EA524349D6B74F0A5DB9252130B63B9F12C
      30E6331B3FDDA97D093ABF1845965C4A3DED69EC642AB6F37BE70BCA5FD6A78E
      EDBF5F7FFE0BBEE834CDDFEEEBA1F5BFDDD781D6A7EE77FE756BF2215E0F7DFF
      DB7D3DB4FEF84B816BE8D2FE37B2A51E122C44E7F6BDC107C6DDC7124E7FD593
      2ED5B8DF6FA2F6C959EB7861890EA7D60A35958DD3822B96D558B9B609E1EC91
      F681CEBFCE49366C8C71FCA3BC462570E2EBECD1FBACDDAFF17A9F12F8E76B3D
      BDDE97044E687D1F7B74AF9F7FFE7F5D03EF24}
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
