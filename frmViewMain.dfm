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
      789CECBDFB77DB469620FCBBCFF1FF80D1EC772C4D530C0182AFF4F4ECDAB2DD
      F18E1D672D2799D930670F481449B440800D8092D839F9DFBFFBA82A00242182
      7A52E9EA9958240814AA6EDDBAEFC76FC3249BD843CF1793D08BA676CBE90CBD
      280DE89FF1626A3B1D67B81CF31D93D690FF4DB37436F147E359DBEEB43AFC35
      8CF96B97BFCE82D2D75140CFE23BDAADBEAD3E4F04BCB13FCC66622EF46FFADB
      FAAFE3B4F5DB70124759360AE1436B08C3FA81359C24F1DC8B8693F1CC4B5291
      C1F545F277E7B7E1BF0D175E14A7C26A39F07FDD56BBD569B9F09F039FDCDFBF
      0673915ADF8B2BEB0B3EFEE7DF6148470F398F7D91AC8F6997C7ECC138031A1B
      C77461CCB378990422C151FFFCFBCB173062BB6292CEE62401942D5830FCD783
      C9E2A0BDDFCF57F3511CD2DCEC7CBD5110DE3CD0C6FF7EFF3988A63EFC97F258
      6EC5B4EC76773BF4D6C6FCFD874F30D8C7E047BC6FE28599357CE5D9C3579D56
      EA7C1E2F5F8BDFD5FAABDEB475977077789770B71C84A8371F2581677DF2B219
      4DBDDDD303A657419ADE3CE084B6C6A1A1D580610023D2586E7B8FFDDEF23FD8
      EF288D432F958B75DDFA73DB36DCB998C6C2FAF1034FAEB3CF1E6D1BEE7FA94D
      A2F14218E46F710210846379DF678796EF8F0A6FB01F01C3E09DB3A0F04E673F
      D4686F470DEB63309D65724DA3E2F85587F90E1407762588D4F87B9D953D7625
      7FC35E3875A75DC9DFD9BDA703ABF6231FB977FFFBE176AB0876BBCFA35A6B8F
      5967EFF8C9AAD938B8AFDB9F5C258A720CAA36A66B573CFCD744880B7A73A7EA
      34DB5DA7E2E1AFCB841FAD3CA6BD5EC5A3C7DF895122AE4EF879A7F2F92A701D
      BF4EBC51303E912BEF541D2ABBDFAD18E10DE05D30E6F75732B26EBBEAFD3F05
      228B3CB828780DDD6E1517507B6E5B05C6AEF6BBDBAB7C4C6EF8DA637AB3BB83
      AA27D56E979FCC77BAD7AA7ED2D9F2A4DAE69E5DF99CDCE7F273A53DEE554A45
      6A93D71E2E6F70AF92C9AA1D2E3F5ED8DD9E5BBDDCF6B637AF6FADDDEFDF4C22
      2C45CFAC9F459AC11B76CA33FDDD04A228B3286C69F7779387F273AB443EB89B
      34941ECCB1A53DD84D184A8F12BAF03207BB8F65E9D1C2AEB507BB0F65E9D98D
      6D73ED2A9E510432336B457DED2AB9B0085FF9484E76ED41C55345E0F253395C
      5DA755F994B3F6943A81AE63573DA329AD7AA674FA5CA74AAAC949AC7EB07CF2
      5CA75DF5686113F9D1C2FEB94E95185BDC3FF9C68DADEBD5A2A62C36E7ACB316
      2D550FE5DBD7AB4549E573850DECD7A2A3F239BD85FD5A944C3E550468BF161D
      930F9641CAEBECEF3E0F4A77D030EDEF3E10F9332BB5C4DDE7413F5480E760F7
      81D08FE544C61DEC3E13FAB1F2A118EC3E14F993FA54D093BBCF847EB2B88783
      DD87227FE3962D1CECE244FF6B9D156D6A6D5543EC944D4BA354F1933A726A71
      20BB5276AC21B39606AA142277CAAFA5612A59560D59767375954CAC8664BB3E
      56A5DA5547C62D8D54257DD49577371475678729601F09694D1F77FAB5B938A9
      DC0A5B4B635411A44DB62EC7D0B85A1CA65D496936F83C0F93636A69984AB2B3
      C1F8791885A7A5412A29D08624C083AC616969AC4AAAB4211CC8B18A385A1AA9
      535B56E0910A185A1AA78A556D0A0F72469BF85934BAB46F4DF44AA3DC92E8AD
      0DE3DE9AE46DACCBBD3DD12B0D7317A2B73ED65D48DEE602EF44F44A23DD95E8
      ADD9D9DCDBA1946211F938B747AAE230D536987A7C341FE89628B5B1B06A9B4C
      3DA42A8D75773E9A8F757B94DA5CE33D2055D1B4DABD773E9A0F5D9F8F6A3C2D
      3D5F9F872AFC2C3EDEABCF3B4B5C331FA03ED7CCF1B134407D8E59C2C3D218F5
      39E53A8FCCC7A8CF234B78571AA33E7FDCC0B7A2F1BB7717BE988F721765A038
      50FF2E44AC34D09DF8623ECC9D9581D268772462A5B1EECA17F391EE4AC268A1
      E3388C936C14FE799808BF359CC2AE44ADE1285C8AD6E625A7D3295E84AF375D
      E601F0DB9621D62EAFDD5B3144C50B7908DBE9172FC2D79B2EB7FEFCF2055EC6
      EF5B0659BBDC2A5FCC07D97A590F3270E40FF0817E1838B5E0DCC2CDFE370C93
      18CF16482A1C67881116434FBAD430BE427FC1500CF9A563A90717DEC28215FE
      3DB48661D01A26F05FEAD9C0A6D2D0E90CE0DFF932CCECE155E08FB370E125C3
      ABC45BC0731E5C1E7AE9C20B17330F3F44CB39302A6F99C543CFFFDB32CD1294
      DB6140986B88FF0499B76859BF0FA3F8EF8075F13CCE84F5DB30CD56A1486742
      64BF3DDE24864916022C26E3D4C6C57B9316FC87C0F354780B4C244BF8969602
      AC8A3C29049D10B077C17A389E26814F8F458BC208D102C7B0866924AE33784B
      FAF7499CCC3D60F5E92209E224C8562DEB7BBC84A11D30CFD42E836864B70850
      F8EF08176DC337FEBB17A8E26506C011A1B81461AB36E086DE48410E44E5ED90
      83498F86F4FB36E85D807C03D20EE8820CC79682616B3FF88DBC54F871D492A0
      84A9A530E70BBBB315A6030B912E4903DFB6DD7E67D0B6AD99F030EAC5B2259C
      9D8787B37D1B3803A46E843342B2124BEF09BA8E826E775FE83A12BAED8787AE
      731BE83ABD9BA10BBF3F3874DB0ABABD7DA1DB665E006B82B13CDF0FB2E052C0
      EDA99807B3C0F745045F96117C144B78656150DB7ACB90B57EF0126F0A909E59
      EFE328A30161ED596ADBF04F125FF9C32C9964E9CF819FCDDEB4E1CB025E14DA
      ADBEFC98E41F27A1FA7D92E94F23FD29C14FE3D1C203B20E1F26FC61044B070E
      C77FB3D542C05DE9A54832906CE0D328F113F537947F47F26F22FFFAD3507F52
      D766F2EFA5B58BC5C06A1F84C91C048BB1ED1BD0E1E50BE634D6576F140A8D4B
      9D222E5511FFF24A46147389345FD3F71CCF113919C1F16F3CBE2861E216F4FE
      4E9166EB0CA4563DAFEEEE79E16BB7CC0B2E23115A9F8FB3E77C9CF27C7ABBE7
      E3F4B6CE072F6FCCA6BDE76CDA6A362425F41F86C0EE8DECEE0DC8EEDE3B2D2D
      ECAA9604FA25596A037CF3348E947CC5FB38A8DCC749ABBC8665381C4F9CB5BD
      AB26B6EB1B07C42DC19D566F765AFBBDD97636D0B8F6CBDFC761185F09BF3489
      D47920E9F2DED006D6FB2088B329E2DC442837A029E9E6F1CF6274A277D3A9DE
      4D8716B9B6A718538E176FBDA7DF7DFDF4D13A8B7D4DBA9D76E514824D9C0AD6
      107953F470B69C9F7773D8EE3448197FDC12FE681C4109E27A6077E15FBBDF76
      E08FD303E6905DB7BB5D17FEB89D3EB0FCEB8E3BC05BBAAE8DB7F4DA18D27FDD
      775C979FC65B00157B344C6B30C09B6C7B80F2C635E8D10EDE66B77B2EDDE776
      3BDD7B464DB96B37A266EB06D474146A3A77434D57F1ABCEDED8F14322785733
      E16B2CA966F0FB212ACDC92DB2ADD2E476CDA7C44D9D6AEEBE8EB7A539DC40E9
      17E1694E6AAB99F5DAF0EB8BBCF90563FD82FECDD2C09A1CB0FBE8399BEF3BCF
      92389AFEF9777A6518A4598672DB6FF491BF8BF922F43201CFB47A368633B71C
      FE9934A421FD1B4DC64E5B7F8CD4E7BF8D5BB074F9118F057E9A10D7905FD2CC
      03A91C6476FEB6F0C642FE0292BB88B2D66FFC2D039C1DBE6AD9C3E5697B60B7
      ADFF8930E2F72DE7239100E9A0EC9794030C3C42B1E0B4DDC5B3D8838B7F1BCB
      C5215170E884C21F345FD55E4ACD855CC26423F8089BA616BF7B5DF1B6F53815
      EBB15DB7BC20BA0023E3DF075E529D05C1B2D5563983ED5B65B72AD6E620892E
      AE8D2EC04BF0EF01AC6DC7CA908057AFADDF5F5B1B5EC0B5C1DFC35FDB0D2B83
      7FF1A417D78697706DF8F759AFCD6DAF910FBA00AFC0BF1639359EEDDA303FA5
      B436BA00AFC0BF75762D27EF87B7B6DE1A25A10BB8B6DEFD50124DDD1F7F6D5D
      778D92D0057805FE556B43C79B05C3E067E0DE4EABD5EEB67FDFCADA3B5DD719
      0CDC56CB7076C3D90D67379CDD7076C3D90F776D86B317397BBFD76EF5FB83FE
      76D6EEF47B6EAFE7740C6B37ACDDB076C3DA0D6B37ACDDB0F667C2DA917EF6BB
      8356056F3FC568FB9EED0E7A35B8FBFEBBFE07E1EEB8F05B6CF2F3E7EE44E5EE
      8EB787CEDDEF24B93C6FEE7EA3E442CCFC0FCBDDD72497327F7FC66BDBC1DD9F
      B7E47257EE7EC092CB6DB8BBD36A0DBA1DB7B79DBB636546074350DC87D8F4E7
      C4DCD5B6DFDF1E3F1BE65EDF1A6198BB61EE86B91FF6DA0C73FF2762EE1DE4DF
      ED0AD5BDDDE9749D8EDBEA17E0A2006078BBE1ED86B71BDE6E78FB735A9BE1ED
      FF34BCBD6DB7FB2DA7DB1B5428EE7DBB3370BA03DB28EE86B91BE66E98BB61EE
      86B91FF0DA0C732F3177A733701DD775B733F7C1C0B15D74C91BC5DDF076C3DB
      0D6F37BCDDF0F6C35D9BE1ED25DEDEED75FBAD6EAFB39DB7F7DC6EAFD76B751C
      C3DB0D6F37BCDDF076C3DB0D6F3FDCB519DE5EE2EDBD96E30C1CA782B79FDA7D
      C776DA8376B76FACF286BB1BEE6EB8BBE1EE86BB1FEEDA0C772F71F741CF71DB
      7DA73213CEB641B3EFF59CAEE1EE86BB1BEE6EB8BBE1EE86BB1FEEDA0C772F72
      77D7E9BBBDCE6050E1733F1D74BA03A7D7EB3886B91BE66E98BB61EE86B91BE6
      7EB86B33CCBDC4DCE149A7D376BA550175EDF6A03FE8778DD3FD1E96F26CD879
      71416AE5869D1B766ED8F9735C9B61E7FF3CECDC6DB55D7BE03A15C96F6DBBD7
      E9389D8E497E33BABAD1D50D7337CCDD30F7035E9B61EE25E6DEE93ADD2E109A
      0A43BCDB1DF47BBD7EDB18E20D7337CCDD3077C3DC0D733FE0B519E65E62EE5D
      B7D3EFB9FD0ACDFD14FB1F77DAFDAE29386BB8BBE1EE86BB1BEE6EB8FB21AFCD
      70F72277EFB43ABD56C7EDD915DC1D58FBA0E5BAC6CD6E78BBE1ED86B71BDE6E
      78FB01AFCDF0F6126FB7DBED56CB76AB78BB3D70BAAD7EBBD56E19CDDD7077C3
      DD0D7737DCDD70F7C35D9BE1EE65EEDE69F5BA8356855DBEDB6F753ABD8E6D2A
      CE1ADE6E78BBE1ED86B71BDE7EC06B33BCBDC4DB5DDBE9B7ED5E55409D0D37F4
      076DDB369ABBE1EE86BB1BEE6EB8BBE1EE07BC36C3DD8BDCBDDB02EEDDEFB5AA
      B8FBC0B107ED9663EAD618E66E98BB61EE86B91BE67EC86B33CCBDC4DCDB8EDD
      B3DD6E85D3BDDDEBBA9D76BBC22ADFCAE1D2DA1728B5E0E0C07FADE63A0C1040
      B080240BC7B3E1649CDAD6D09B001CC22CE10B77E1F23BD674EF3C1E9768DF6D
      89B760FCB7DF3904C0ED56E9DC6D95B71001EE829FB7A9E283AB6CDF7195FB0B
      030FB0CA1BC51C5CA57BB755DE422C78C455CA357636D6C8525EED55923CB09F
      80F0F8ABECD6DD49C4FC6DABDC212C1CC62A7B77C357940DD684BDDD62C3E3AF
      B27FB755EE101F94D8B72640A069BFE5762A6AD6F73AFD4E7730B09D6D103A64
      D3C0DA76DFD93870DF12E2039906EE2DE6E2D184DEFB330DE492FDC1ACED714D
      03B793ED6EB9B643310D3C445DC65B70FE6763AEBA05BF3F244A72A3B9EACEC6
      8183A592C8C2D7585A0DE34077D0717AAD5EBBCAAFEFBAAE63034F7C06CC1DF7
      FDC12CFF87CCDC9FB5B5EECECCFD80AD750FCEDCB553E6F1D7F694CCFDA17D51
      86B91F2C2531CC7D0FE63EE8B88EDBEB54B492B51DB7D5B5079D67A1B91BE6FE
      1CD1D63077C3DC0D7337CCDD30F77B67EE3DDBB1ED7EBB3266CFEEB79C6ECB1D
      74FA86BB1BEE6EB8BBE1EE86BB1F000131DCDD70F73ADCBDDD729C8153D5271E
      E86BC7714102E81AE66E98BB61EE86B91BE67E0004C43077C3DCEB30F74ECBEE
      B41DBBAA807DBBDDEF75BB9D9671BA1BE66E98BB61EE86B91F020131CCDD30F7
      3ACCBD3BE877B0537C0573EF013ABBDDAE6D98BB61EE86B91BE66E98FB211010
      C3DC0D73AFC3DC7B1DA7E3F67ADDEDCC7DD071BB76DF715DC3DBEFBC1493FD66
      B2DFEE1BF74CF69B61E7869D1B76AED879BFE3C08FC0B42BBCEC2DBB67773A3D
      131F7FCF5B6C5475A3AA1B55DDA8EA86B71BDEFE60BCBD8F7DE007ED8ACC7650
      D3BB6DB76F02E80C6F37BCDDF076C3DB0F828018DE6E787B0DDE3E805F5AB6ED
      F4AA72DF3A9D6EABD31938467337DCDD7077C3DD0D773F040262B8BBE1EE35B8
      BBDD6A757B7D587A659B78A7D7B13B0350DF0D7B37ECDDB077C3DE0D7B3F0002
      62D8BB61EFB5D8BBD3755DB75D5996AEDFEFB4FB1DDB44C81BEE6EB8BBE1EE86
      BB1F040131DCDD70F75ADCBDD7EEF47AED76454CDDA9DD719C76CF6DB74D90BC
      61EF86BD1BF66ED8FB211010C3DE0D7BAFC5DE073DBBDDEFF6DDEDECDD1D74ED
      6E6FD037BABB61EE86B91BE66E98FB211010C3DC0D73AFC3DC6DC7757A98F556
      65991F74DD56BB671AC618EE6EB8BBE1EE86BB1F040131DCDD70F75ADCDD6DB9
      8ED3EA57D4943FB5810EB92DD0ED8DF26ED8BB61EF86BD1BF67E0804C4B077C3
      DEEBB077C7765AEDB6DBAD6A19E3743BEDD6C024BC1BE66E98BB61EE86B91F04
      0131CCDD30F75ACC7DE0F4BB76AB57A9BBDB6E77D0E9015734ECFDCE4B31A567
      4DE9D9FBC63D537AD67074C3D10D47D71CBD0DDC72D0EAF42A02E94EED5EB7D3
      B1FB1DA3AFDFF3261B7DDDE8EB465F37FABAE1EE86BB3F1C77EF7407835ECF6D
      55707707587B1F947A930467B8BBE1EE86BB1BEE7E0804C47077C3DDEB7077B7
      DDEA76DD4EBFB2405DABDF6D755B8E61EF86BD1BF66ED8BB61EF0741400C7B37
      ECBD167BEF77DBFDBEDDAE2A2FEF74DAED76CFE91BD3BCE1EE86BB1BEE6EB8FB
      211010C3DD0D77AFC3DD3B9DEEA0DBEFB995A174DDEEA0D7B2FBAE61EF86BD1B
      F66ED8BB61EF8740400C7B37ECBD0E7BEFD9DD7EAB3FE857F574EF75BB3DD7B1
      5D13286FB8BBE1EE86BB1BEE7E0804C47077C3DD6B71F75E0B0DF3EEA0427977
      BB3DAC60D7359DE10C7737DCDD7077C3DD0F818018EE6EB87B3DEE6EB75C77E0
      38558E77DB76065DD7EE9802B486BD1BF66ED8BB61EF8740400C7B37ECBD167B
      1F0CBAED417F50911467F7E05150DD4DD4FC3D2CC5D4B031356CEE1BF74C0D1B
      C3D00D43370C5D33F47EABEF3A835EAFA293FB69C76E3BBD6ECF58E3EF7B938D
      BA6ED475A3AE1B75DD7077C3DD1F8EBBDB4ECFEDF55B55D6F881EDB85DD7EE99
      483AC3DD0D7737DCDD70F743202086BB1BEE5E8BBB773BEDAEDDAD8E936FF5DB
      2D38AEC6D56EB8BBE1EE86BB1BEE7E0804C47077C3DDEB71F7C1A0E3DA760577
      3F755AAD9E3B7007A6BCBC61EF86BD1BF66ED8FB411010C3DE0D7BAFC3DE07BD
      56ABDFE95456A86BBB68BC37817486B91BE66E98BB61EE0741400C7337CCBD06
      73775A1D0703E55BED0AE66EBB2DBB03FCDF31BABB61EF86BD1BF66ED8FB2110
      10C3DE0D7BAFC5DEBBFD56B7D771AAD83BB0C3CEC0B6DB86BB1BEE6EB8BBE1EE
      86BB1F020131DCDD70F77ADC7D60B7BA8EEDFE0EBFFF1B5D8D2F459204BE8031
      42F15BE9927CCA85373A9DB6D32DFD388E97B0966198AA36736B4F75071DD771
      7B9DCEF6A79CED4FB9D8B8AEE7F69DED4FB5356B5B7BAED769D93045BBE23977
      FBDBF22482ED8F752A1ED39580B63FD6DDFE582E5B6D7FAC57F136DDCF0FA9DC
      B607FB15B074FA00FFC1C0DDFED4A0E275B6E3629142BB57B1DDADEDCFF57BED
      56BF3FE8573C55812579BF838AE79CAA1DB75BBD76A7D76BB7ABD0B2BDFD8DBD
      EEA0DF4184AE78AC0A55746DC78AE72A70253F7215CF55204BD7B5FB8316EC7A
      D5A6DB55E8D206F178D0EAF4AA5E58812D79504EC57355F8E2B45AED6E054A3B
      15C862B79CAEEBBAED4AEA60576EBB2ED351F1640561C92B6F573C57812EFD0E
      CCB4DF71AB1EAB4217DDA5ABE2B90A74E9C0C6B53A6EAFF2AC3B15F8623B03A7
      DF85435171909C0A746963023452A58AC7AAB005486DABDD76BB55AFABC01640
      30A7DFB67B15BBD76E55ED7BBBD772608955C7B65D415FDA4E67006CC8AD380C
      ED2A6C690D7A76BBDFED573D57812D03AC110314B462D7DB15D8D26DC169EFF7
      5AADAA5D6F577122ED6AAF78AE025B7AC08500CB7A1558DDAE4016D4C0804CB4
      2A36BD5D812C3DC016BBDF6E556DFAA06AD31DA02D832E4CB482AB5750978EDD
      690199AFE2EA6E05AE0072B500CBDA15AB73AB7045E72A543C57812B5D90909C
      1E70B1AA4D772BA51655D8A0E2B94A56A45C3715CF55208BEBB6DAAE0DC7A8E2
      B12A46D402B2D20739DBAE78AE5FB5ED5D10E47AB6DBAD7AB08A13B5419600B0
      B81578D6A94097369C74E047BD0ACEDEA940179077882255A04BA7025D3AC0A0
      8146B89514BE53812FB6EDB65C3811FDAA1756A04B7BD073DC76BF729E15D8E2
      76BA4EB7CBE6896D8F55200BF03CA7EF0CDA1538D6E9B1E69188CB6C145ABFFD
      185D44F155F4E7DF0917FE6DB8982EE83A7E1806F04F6B1864DE0227D11A26F0
      5F3A82FF3CDC4975477BE71DBBC7B02BEEE0B9A6818F93A20FDD7EBB6D777BF4
      B907C76900E4023FDBC0B8077DD008E80BB0FFCE8078D27CEE65B31F12FEFB3E
      8EB2B63B9C8F928B37016892F2C3F97284947F9ECEBD307C9F78A06DCEFD205D
      BC15137B380F3F79C994EE4EF4275F4CFEF7187EBB4ABCC507D22AC900380FA2
      EC6330870F9197ACE013CE208826F16F436F99CDE2C47A17C23D692692D73FC2
      4FF142245E0697BFC26F7035B2DE45D35024F0D33811A0C5CE87ABC469D9FDE1
      3C06D5CA5FD9C359D2C6D73838326EE2C62D6DB8C5C55B88CCC2FEA7411CE159
      103EBE1AD1268A270B6F2AF088E0AEC3D7AB38F1416277A9F81A7C1FCFBC2405
      C164E016BE5FA540D25B2E8F1A0DDABC3BD7F310164438431F6D6B96658B6FBF
      F9261DCFC4DC4B9BF3609CC4693CC99AE378FE4D3C990463F10DBEF01B945CE9
      D33CFCFDF7E1C203685CD9203B77F9F30C683AECEE1C801E3278E153A23F65FA
      D3883E4D9719C01570284B5231CED0FA7C15F8F1D5384BC2E1248B467F1B7A22
      F2FD783CCC608F2FE67038D2167F9EC409E0471644537BE8C7519C89F948F8E9
      2A9D00C6D800E870154797F3B055F81534FDA9EF651EBC3999C0A8E212D00006
      BCF4C200AE0B80863D4C67F1D522F4C66216873E5A1CE02C4CA33811F3E05AF8
      63181D2D1280EB972288E8C96B7C0B3E061FE0F0025ED8B003D7214C2F5E8908
      5625AE17E92CC922B8BC84C586E9623CF423D882281DF923B84A360F58D212D6
      0D0B4B671E9007C0B07FE0DAFDE99CB0183ECCE8466067F0F9B2F0196E0DA66C
      CBC65F4ADF6638359B1EC00F680281F978913FBC0CC4D54510F9367D4AC75E08
      C375E0888F123F9909CF971F27719C0DD345B8CAAEA22012B835FAF32C9BC341
      4917B088309A659EFF3758D670998A301B79613484FFE002BC64088FC01BC6F0
      ED8ABEC087249B26C33082330D2B1730047CBA4A909E0DD3C85B64F114486110
      8D4518C240617C3509440867D787E18770E362198DD192E7A581A747417292C0
      8C15491946E20A464CB315FC9CC24BA6497C05738E274186138D10E0D90AE08E
      F4177E87C9464067B27438113839118A4BB83CBE4E1764F201FAE0C31E5EE175
      817BEA4DC670A070D6DE846E5E025E86C319DD8180CB80607A09DC998D2F3D82
      5506B3C587260902042F5C7AD9F5E87A7891448B248D44361C7B701C01E14280
      A3859813C0695C789905D3CA5A4CFCAF009127F36C128470902CC705868D871F
      08D13211D92C89B30CF67418849378EE8DBD6C1C46CB45A787270E26640DF1D8
      F9963A8040CC2371DD1AE2D68B6405EAFB10B75E7E8499A4D7F801E01FCD4422
      E8697C0477096D6C349A987880E363D8413AC116F1A8087E0A2FE1742DA2E538
      99E3053400E27736F1A1736911CDBC688A9C2CCAAE33CF6A32B9520F3BB0D1F8
      384CF656CFB7E113F0D55B3DEBC2A7B0FE9B4FCA4F77EABF79641DFF5E354C97
      00507B1A370DD5A381EA6DC44DE3F4EF6B42833A13429CDF3A12709F048855E8
      059125717BF8773834B97002A235906CFA7784671FE8BCC77F81E30016E31328
      1A48F4058AB2F0C2C5CCC30FD1723E9CD0DDC37849084F36E7D61088DD32CD80
      D6CE32784D44A6642539C1805E51CA0159280BC7B3E1640CFC16E8043C3D4941
      F8F1425899DD723A3471BE81FDB0F82BFED86EF56DFA3011701FC8A431DCE54D
      DAA0B27587B3A0F0C51FE92F9DE1184F253D172D0A43440B1C04B6A4349D919A
      91DB2FCD63381A4E5C7788D7870096D9F002E408E0A2ED2E10C1B424C5A1C051
      94E42C353778BE34319A3F5CB57E9E79D9ABD402F26CC1BE5DBFF383CC6A37DB
      CDDF7F83E5DFF3F476CF86ACB44F0F14EBCDBBAFAFFFE7CB1778D68142336A3F
      1E52DBFB217515C4DADDED10031011C476C20996BF0B526F96D3098864E92342
      EA2EB09127DE2D0386C1E2B8F70291AF3361B1970DB0D14AC4224E32E15B419A
      2E456ACD4062B546025416049BFFAD841BEBA4E45ACBA9A81610D696B0367919
      3CB21BEB15CD2A4F9CD633695BC357A3DE1044ABDFB7EC61291CA5F666AEF9F9
      F0D91ADB1BA6DBD11F1F7F9C4DDEB9C5C77A57E3C8028D770CBAD889756A9569
      178AC4B79D4A6D82F9638A589601CECD6310A3ADAB9910A195C5D61899B5A05F
      D271122C320B04D7513C8AAF91CEE3E5D70B5026AC73FEF13DC8DF961F038682
      146C85B1E7D33DC016E01E10F441A884E5F248EB247AEB229179562CD37A04A4
      D700AC8BF4F78443B537EEE58B2A2C9AC3E1084E19E64C42F097546D5BE45D06
      532F0BE0A12C110295C686058A24FE1859F9637882606461C5137A6E91C0BD80
      2361BE9D6A643FDE395D8918CB05AAE8341EBED842D0196C78486CF026A8547A
      785671573D79061BA53D00EE52D81EDFBA0AB2190814056CF060CCC904F4C528
      93DB0E0C2849EB9D65B377B7DBBB148E2AC1BE89CC2C9AA600F350E464361168
      4C93D41BF627801126A13705F921B102B3370FB9373B1FE583C75BD8D0D453F2
      D51459AC3C476CA8A18D839F3DA0C1591002959DC5579697EA9DBDAFB51744D1
      A7D04D6A2ADC6A9635B53958CC6E7D4E9912EF4FC91D2845EF90D5BC5DA0ACAB
      E65582EF19AB7915B0A979B6EE0291A756F3AA0FC31F4ECD7BA04DBE8B88EE45
      4B2FB4C6A1F09046A188FDD6BB8AA64B806853A473C9D953CB05F29F082D6867
      C03CAC25A96C7F5F06E30B1EE10091E30EB0418F9DD249C7CB240551C68FAF22
      EB42AC503B8D00222415010D9CA3E78F84550BBD8D7F92B74B45470BB7C85313
      910232E14FECDC7B8E30DB0EB11AA02E489224409286B8800F593007241BA1D3
      12801DC68459CCDE00B1100137A40E870ECD3A2CDCDAC050B36D6F9D6D9B26D8
      44BF6C1355119CE0AD15C4DB9F5C9A0502661680622CF1099DCE48B241587B8E
      D8537DE270714444E168A568E70997F368E3144915D10BAFBC558AE729F807FA
      519F23288E27F112F675B4B27C94A3301C04E1700634C4FA93751622650510FD
      844BFF8EA573D2B96AB0750411C03541A7EA8AA1C40A1A433555D6141A5BAA08
      40C0C633227931DF8A13E05D62C26FE4CB5D607FABF6D10282967A53A14C1946
      E02C0A9CFE0698665ECA72661AE2C4D1589B25C29B2312F864160C50F399809C
      6A05F345025289DFB48EBF822072915A7FF5E622F92116D9BF9C1875F2EEEA64
      DFA893F570F94C3A2762EBFF9018BCF3815F5EC36A7F05D29E8BCB862458AF41
      97005AA0C502502F32C994B46A52D24B1A16CC3AD34C2C8D97A0C47841125957
      7112FA14CB06AC12B8A015C6B043097B82A42831056AD1043A049204FC3F08E5
      204BB1C24B6F8613E185407BFC155ACB52B434C383EDA6D3B4891001F11981C4
      B192F26A53EEE36EC217A3120DAFA0F7C2DB1AF2C891447305CA587241C27118
      5AD3245E2E601E35A42998D11C4355946E5630D529895A4ADDA4B5B0D6C6E85A
      C4460910B87F8C56C1192C3C576D00C14702A0E00797810F1A239267108DFD86
      45D1AC005AD88914E832FC70950464A947BB3D427BB4CA60C04912CFE92B4713
      82D24902766DD8E1DCE630CD9491A3B80A9A3E685F003604236C8FBF84ED2F7A
      0ACEBE9CED96B50B4A2D4D34F4957E3C17D92CF6AD6371BD00912840EEA41D19
      325A0E11A3F033B0360CBDC41B7E7CFB857E9546F20F5F3F9D340D93BA3B93EA
      79864B19A3A7317A3E8DD1D379BE46CFD73F59FE32E18D27FE00CC62B40CC8DA
      6708F35E8479E73DDB29B721DC86701BC2FD3484BBFD8C09B7EF530CC339FC48
      1F50AC3E630571E7B053EB938789771CDA10A2CE025A0DD9D2D14EBA5C5024DA
      F10FF00B683EE39900CD023531D0A5966883BFC224156B152F4129F045317C62
      2EC725FF0FD2B7EEBFFC8BB6431D12EEDD01F45208FF1E48F9D7CF6779E44F10
      81B2C7FA208689E41667A96A179E23DB3DEBEB38C415E8A9A1986456BC80F3AA
      83FA562A04D03A7A5B63BE71F42A93112A535482975116847273FC23DE460A15
      4DF9B3F0B7CC8C624641A904CD719A78738B7246FE58FB777EFE8ED8AFDEB87C
      A730D335F456D64F9C2A6A9DC55196C4A1F5219AC4964D215CCAB440188ED052
      F7BAAE61E2BB36E53DE7CF1DA2A7F7C999917BE8CCE8E88C18011E8277E4AF3F
      5236A6CBC027CF2C261DD7C002262E22C5F067CE3686F363EC40F76007EA1A6D
      A2A6EC8C6E7234D49E71DA39197B0B7CD06819452D036594D132CB621D8190C5
      0B96588019462251CE877541E2D80BD3986DED7E5C2171C0569C901C3A12E8FA
      205194A418D890191016CBDBDC2D4D2C1E3B12E66DBCC4A95038C22D837FEF10
      0113E38AD753381F7CCDEF76DE019B92DC3734EAF011894C24425378F61884B5
      90DD602A1F4646720711A015C6CDD476B3FC1CF820E1C5B9948EFE313AAB848D
      24FF7916C88B01B2BDDAC39E67986C737C19A40121758222E80949FA575BDE48
      AE25E93349B338C144103C4E780B1D313C2A294BFC4FC5429F11DD373129B508
      7EBA10635065411FF2C2782ADDCF94D25223A98CC04A9E49D46BC5F5385CA6C1
      A5509154A1976624A6E4712EEC0EF4F7F0800A35359440711C0F74E475051859
      BA07C7250845AEFE3681F7C02BA506CC2957722CE936CD9013E130514991F650
      DC0230C83242784E59F09294402ADA9B513CE816F6C2105F0613B25DCBF75669
      1DF246263C71BD08F670AC034DB07EF040698D525E5B51EDDF04D19A8D80638B
      181071A42C197CAB263BC505CA27F7DA39F53CBD4583DA0FA40EAEDFF399CD50
      44E5D06611C6A924856412F9F06A0E50E7B52260616D7152307368F8F31C774E
      CD477C990344947184126EE9E35ECB4375965E0E58ED51C4160EC9B8A13DFFF9
      21C022385E5A7F83A5514E6A5DD644087FE4716C240ECC28F996AD1D8A41FEAB
      BE0B2702541B8D4F68BECB66417401205D31D7417E338B9721064B687C967113
      1490CA73C5777D2FAE97E9A7D84F0DD3D9B965DF2DA702CD8032548F0322763E
      057A317AE390881D9D61053401DC2BCC08E5C7B323C3B0F4A10BE698D42E7C41
      47D8E272719C1F4B005B20C0E82744E26EA7F5E98D754E25CA56E7C135E57614
      581106CCC8938A25032DEC18300FA22546EE1CDB2D0B0E48929E2075F04618D7
      D351BF9A93609C78C689F7E876D3CEA1DB4DAB3D116C57E1688BDC1D711527C4
      CE7F86551CE086DF61BD248AA35072F41E8494D76178A4125B58F59DC7BE6858
      2A0A34B31671CA5A327916230EB60C2224F0294B245A6596A91C7F2C787DF7E1
      EBA777C0755004FEF0D6FA21111834FBDD87E94C609D542F927E5CEB5D04E82F
      802B016CFFFAE5C71F40BE1C89B0ECDEC550DD50CC9F258836015403AA0CC333
      2CED08F2EBB932086DF1D72E53950F448E40788690F2678D94CF1166D568F506
      2B7EC2A5EF8228532ECFD43AF358DF42550F542A2C581165DFC0B90279A7182E
      3D065ACB5ACCFC201D79B7AEF4F493975035088E7E27ADFEFAED72BEE0C527CB
      88D3822395B189268E5A564A4637156D2F63249E23E46EA88A12CF59F34D2D3C
      6C63908BE3C9047189B5F894D57882A487269415926ED0FD57008B39A11A593B
      C51F2CD6E05A471AA0E145E6694E308195A26D40339915034526B9B1A898A0F1
      BC335C2B123BD185A2F20B3EFFE79A7FE913451A49A2ADAD409A744B408E0409
      C864EF4730811287592A44A61EDD35F46ED30BB247B5B89B748867B7E9155B7E
      35AA812E9F2713A0026FE17400174ECFB0583FA63E812033F6904F27946536D6
      A1083A260DE935A90A2B3A5BCF116E95876519B11F0853EFD19525924B2FB4D8
      5C77A5F8359973F9BE19727638354C5E410E8CA349305D26D242623B331E4A32
      FFE708AB0A48F94031324556C8CA7AFC17FC0C4C091953145B7136ABC1B505DA
      7800B728F92CF70CF8C2037A7489C638F851A6A619BBCFCE8A965C62904F6DD1
      7A6C0C410A44CA97048886D3C5A0A8312927327D8E3C4C8AE86DF8A236415A2F
      8D50C65D64CB041D15A0471319E59053F215E5EFD42F902ED3232B5E1403B776
      BEF0C304F34B65B54974A65F7A4188BEF406AC672475929DA310692BBB8E800E
      48F7643E47294E200DC408D67D26A9135161B6682546FB6E9CC3FA5834A74DCB
      6DB69AD70DF8E3E09F66B379C2C22D3F49EF94C416E745651999E41E2B676AA0
      BC67275CE57359382352D1F86B907DB7A42A1FB9AE0A241B61E65BC7B0C4F5FD
      D3F2D3E71A18C782F99325603E23F2F53558A42650606B64184246FACAD782C6
      0BC66B55C2142300BC0BC1C138DE983A31E9EC014A2580EB74FCF6F2B8D224F2
      F4F644FC7D19488F25C832225119D6168E8C3737B3EB8C1CC92C125C01F5E1D8
      3419A220AE8539153B41FF854B65C2E2883AC507697D7D72F744F7F0DD135BB3
      1D642106EC97A61CAB548CC1C3EA64787664E0D91394235BC1FF4EE7F353DFB7
      7E4C45F2AD756D61E3B1EB6FADD553D4250B26A41AB44C04FB3D44B0774C04BB
      89647C9CEA5A125EFBD4AC09A2CB202B045D710408A02E0BFA4033117B1B3A86
      8E55949D23EB48435237D00ACCB193854C4096B1403E59C5CBBD8201D7296250
      05FAE03E89A2864521662C7C0AEAFCF20505BAA9DDF05214F44805BBF2A80103
      013B8F7A2BC67D4618C9474A1BF23B1C06E5C5692CCB02EAE1D8B94AE178184A
      370649284B9668272AA00A65CB524147928B15E6BC22E31CA7A0C06EC9224B35
      8A0948B57F23E6CF08AE260AC944213DBA98DF3B7C31BFCA47490A38EEBB0C33
      892796A7FA20688F1B05824732AF0B6E9231F1857E0A3A49C5A38A04078824B7
      8E0CF8E5FD67F757EBFDF7AF3F5180CDC7CF6F503D22AFCB735D669D7A025B20
      7119241956813BFA59D7163C52A5F1881D893940D04B566C7909301C57843212
      897048B6F6B5E0DFA550850D3731F0E72F1FDF962BED3E2B10DF543D4247D29C
      C58B152AD0AA33B9754CD677FC2A0B079E34ACA3EF6314302858AE1C2258AC46
      808D4AA6C2DFADACC2EBC84526FE60607D4D8854802B19F38EA946A58A228CD1
      0F68A50160309BBEF3AACF589063EEADAC632C1E49112C20B3C20D20E38D422F
      BA788EC0AA02D57B6A6A4315412526C1A27F8C0ED48077EBC2E122C9508807A2
      9364E325F624C0A572082A3987634E0CAD55429CDBFF782CD3AB0CA595D41BA2
      57CF326AA902705FE0CCC473AC0C57E2EEB468D98EC0A8183BB37C85072F2091
      E8FFC6004D4044535C60134CAFAD94012550834568FD03A19525A0318F0044B9
      E6E1F9BE742095AB0720F5CEB3AF1FDD14FDFAE357EB4FD6F9139502D888357B
      E8E59E7DFDF211D6FBFEF1D73B89C7CB5466F66B8CA96D08A333287DE5E37877
      8134748384B2E7E2E323958472AB61FD8952864F2BC10DEBBF1DC09FECC0BC6F
      3F3AEEBC7C51C85D4691803274A9BEF7980A8E5C08815E6CC22B2A63ADB274C7
      CB844A66CB1E46204806A55245071062FAC8F02B92EBBA10DC1D6B17651AB6AA
      2C9E7CD10DC9D47434C8DA90EA381B0E3CA818622D57DD482FD5D20BB25D3828
      DF79F3D132C1988A4F225A1AB145574243001D2917B98E6353C15765B0197CAB
      014FB40CFD288397312DE9088DD0A187ED177497D623ECD06031E839F4D06064
      EE4E0702BD0D8C9BC53E5542CE31105BD2FD68DD32089149A70C964667968A28
      57515A9488C2ED21EC3C2F3E8FDFA4F0CC003DACC807D6E333CB27A361A1B6AC
      82B5F14D35568A93E14E70A82EE08231EC8BD5F142C4194FBBB68058CA46C943
      4CC96249934BD1EA8963AAFEDB6453C1B231B77BC72FFFF5ABDA100ED64FAC60
      1AC5548A5DFA93ED0EBC0BA4558CB8256B7B40D97ADE62018C2DA5604FD48228
      0180261BC5F13F847EBA65EA12D43E3ED55DE67697E94093EAFFC634C1AFF173
      A1477794530B00AD54610A007D02E5382A5B7665BF401949CF5C5B6E19DFEB65
      D2926ECECA6E84E7625D40CB139F6203B129E873C1FC87E7C4EF54C471093E8A
      65710A523950D96F72A41226844A91721CCF1741581192BC3B87813870B17882
      F630E99EA91874C20A95E442F082DD070BE40594CAB8B8CEF0376C35F83DFC37
      FCBD99AFF6B37C172D7B2452F55A13545D4F90D3A6CD321200F8CC212BE52E15
      40E5C7E325B9A06F3A3F243096BBE0154BB2E954812B18378DC45533C92626A4
      F7EE21BDAE09E9357169F71397B63BA7CD04AEED19B8D63FFCC0B57FED0C5CEB
      D43AFA188FBD107B772FC2E534888EACC932624D1C0D0E497C21A203DCE13B55
      55A1503ADD55073D586C4C19CBE886719000E74B332C15490DE061AF91FA16DA
      F8C4131956F53CA33B2A40E351FFA36F4819C10FDB40150A551DE4B206ADB921
      B22DD5516BC7A5A63100618C09C1C750A87EAE7D8EB6C7817CF4B0C7F0B468F0
      92958CBC2BD46300AF9A4836A2692AB51BC0BBE628F5BE698E3CC72257D0E5F3
      AC105509931FBFBEEF5B22024587BC5C314A914C937C4BC1022B91A24574E285
      2145FECF051A4F83748ED65575176B8299C56885E33E47405580291193BCAEE1
      32C5E45E2C213C87C39AACD8781C8931E6E3247FA4DA23D2EFC815690AC786CA
      3720255E082A2186CE4851A724844755A1E248A08B3459A9F2DCB94DBF219357
      AE303D1D0D91BA7AF573046BE5B10B22CCA98185C0D10B98D070B9BE30F41618
      90F68DB85E0070C8B8BE5A48DF408178331350E6C0636CCE4DBF511C28DDEC8B
      749C04CC3147F0E62B951EF62C89FABF62D1E253EB0BF14EB6D644CB30944A99
      B758E86A163B8702617184A5C78CFAB633DB0E5D60CBCCEA75AD74B940C81B45
      4EC1E6AF58933BEFFBA57330B1E8431383DB75243BE96C18AA4B3571F3DA0268
      D7690246AF7729CEC712111746C9A924B5272B9841274BACA082869FF5FADF5C
      3D8C7EA681B7B443A67B707F05353FAB9F84B98116B54A464E452412AAF802A0
      F3572AF47111A3B7903C165EB442D690E72E7A729958260D0090A1A92BBEC0C2
      1C5B568B539A2FC7334EF7410945169BA7E5A96C594A4A1C275E3A13F557FC06
      864E8369144C0210C361A2732AF481D58530049B437952DE908462F2B1B06DA4
      7A0CAC5795E00DF56101C16425A3B8A2154810BBF36AADA31FA30BC002D01529
      DF2465C8AD85951AB3F44E484A7BF41CB702E76FE1ECE602552D43E4B4B5EA2A
      26EB6705A0D6D1EE36E6A8ED9EDB3F9C516A7057A3D44347629EE2449191DC7F
      68EE6EEE706AFDACEA11EA00958D82A9AA7513E0214292B95EB18933F3100CF3
      E1AC16ACC794F832B79D2D6C5428A989FE44EAE3975E60A1A51A62BC9CD05FA9
      76623E25AAB854AA6D87934A6956AC07AB876E633578A4A3F1F8B114846B5877
      078EC01304539C5A1F405D42B5EBA9D67EE3397BA87537F99095F15517FF44CF
      F747EC9D04BA652E9362A97814B7C89D18F9AA95DF1B6F7C819542E1CA474A3A
      3302C7EE90501D2A7864828FD772A68ECA619447AAD8A5D68454B2D4EEC37D43
      2F574A95B80A221FF52E72B8AB9A9A0B814239A808D19215A763992811AE38A5
      3677D9096E4C613C6F5B841C7BBB97FF805C6FD2E1E61562AD0F6907775B1D14
      953E0E26AAB4CEB3B4E7C9986D430415403EB13F0108504005CEB530BB8C9467
      21007E7DFC1759B51B48962F8BEA52B9A5EB8C7AE5F8C1847877A6AED2982995
      02A8D132126EA75048B2CD0081E409B1B579B2CC96898978AB117B0D42D302FD
      8C3A4891AB38BC2D58E401A6EF316F9F0379CD3128C6C78C15FC28092EF1A234
      F4B845B5F2351EA74248A706DE939BD6B8EF3A15C0D5E0F745540CF3CC5447D3
      474F767CF9E2DFC78B6FAFE17FFFF1F84A0FF6B3B9A24418799C8BFEA1B8E8E7
      6B3E855A8450797CA0C804EA2758EF329BF49F24C71E0DCD6C9AD0C78C1D620D
      8BCAC0D782055534BCB773613B1DE709B461B57ED9692544370E79F25DE0A2D3
      2003EE876626F43D60C739A41DAD5442E9E58B47A71E483B5A8376EBDE6987E1
      E8358A9F64E4742E71A6508513614D1EBE81E3860C37AFCEDB0040C948070949
      CAB6E70E201AA0C7E873804B8A81ABD6C7048A42CB715077580A3841060FDC2B
      98AC148B2FED489D8A00C7B2506A6A1DFD48E25A69846F8F14DFD47E443446AB
      6E1C27FB94F74FA85988B6306004FF8F1F942B5517DE6DA0756273298A67A1CD
      82735D3C1667B08201D1771FAE3C816CF3CB78A1E4DD5F9F40BC911679091DB6
      177133AD601208745D5D0882EBB7BB8F677E04B3EB81DD857FED7EDB813F4ECF
      EDC39F76B7EBC21FB7D36FC19F8E3BC05BBAAE8DB7F4DA0EDED2775C979FC65B
      E09CF76898D6608037D9F6A08577D90EDC877FDB3D97EE73BB9DEEC39EFB47A9
      AA53C485F58351F58C88A670A0677F41C9A8EE3317B0EC69BCF3B6E82F5DF89F
      21CB45252B5D88319F0CAE5B49B2CE03C8C2F72709DF73930362396B92F0F115
      3EF6F83040F47C0ABF6B804D3C1B6C6BC2F2ECE457C52651D71E0614EEC5D50A
      18A5E1C9CDBF26136C418C8A0715C0B0580DF5F2DB022CE19904972A794D0902
      4632AD616B2A37833644AE88921BADB28B465119828CC6A274E76814918CC218
      2BCBD4A05D0B70A91A5E85FC3D400F993A250AD6577B7C7DF2475116FF50F9A3
      6D933F5A537F9C631B0A94DE75EA8E89435EF71B519814E72BE9AA710C25001C
      77B74AB398DBC70589B6A1E7E1B8AFBF3FFF80C5930468D199C0A222183D9B78
      4043921375BFF498CB0A0FD23F05DBBC5BB316AA1F7841CE9A7B8B05EAD82391
      5DA17F5FBF8F636379A6341B8E723D4119014D054DEB07553D4B06FCA7488BF9
      6CCD3C9F3BB187C13CC0D517756A6F3C968DB4E74590D13AFC004B1E93A94FB7
      DE26A8E8197BB2542777772FFF26ADE7943825EFA82D38F1C431877FE7AD9CE4
      9F62AAC78A7390AA66C4A6036CBC2E002274AB14CEC63AD78B9145675D865E8A
      B7C53A9F4BADE090BCCA4F1FE0B09D761E5080C3CB177FE573ADCFF9294A4229
      D73F9321E3640B21635284E4A151E8298591BE9862D4E0A6DC583D82EEC9FDD1
      11DC9B58978136E951107FE8ADF228B043C2991A10FBE9D3EBB798C901EBCF02
      3E0498732521488A629278ABFC706898620B285096D00E0987E8FC6295047322
      60A107C0A32A382B029ADA0C22C4BA424D8110A9238B764E2A21478972B937FF
      CA5B713D3B59F2FF700F69DD189C42826911453721A5CB98548AD41B1AF2BD29
      E62A1FF8F10D9A35F096191855B2F5142E05699EC0FB2CB1E3E58BAFDB3CFE37
      A3C8DA6192C44A5225C59F5114920DCBA62263678468524BB9CFA33000A1226A
      E8DCA67683CEB1FA4A85D9C5D44BD158529E07BC5184A0F389EB45188C033CB6
      732FA1A66C3045CC470AF2A6667542CDB7240CF12C0BF4859AA53738468722D9
      8160844B9FF244570A030A00B48E15D0D8D6A35AF99520B8FBA03DFC3103947D
      EC3AEC3B4ED1C95A16B42A19405512C2D5E671334A89B52E835051E1107858E9
      9880605A23444349D91825601D939C8BA51C80455A1F4EA456A27C6279C00F47
      5C3D457CFF78712A55AB6FFF5D4DFE09E27DD8C8FA040078CA45032A888004A4
      7FAA909EF5501E4A709259B4519CCC894EB1DC3E1279A18AB53A8A41FD7CD875
      899992AE36CEB7E42EC006B11A4853B9BE6BF040A4182CF2AECF9032ABD7CD1B
      F9ABD1CAC00C5AF33B6A6B4A654EC8350EEC9145E8DC494170CA2B0DED990DBD
      29CE720A1A02192E8EBC944BFD90894099B150A72256FC2AC57CCA4CC928C88C
      E837F9FD9F8F13EFD50A584A44C7D1EEC490CC3A7F77D2584BE628ED076F1C0A
      5FD308F7D3A4786CB38038876E019171042024A0C470807BB8730513CCBD7BCE
      0B58C4F90EB49EE302C6FF10E3E73C7F1FAB733D670C02CDF799AF602A40EE8A
      9EF30212212E78FEEDE7387F604761F0AC77E06FDEC28B50963D7DB6E5F440FB
      B812D3E7BD0DA86A2CA74BDE88E7BA0890E79E39414DAF84FFBC57902D930BBD
      02F739AE2059A6A93ECCF6735C0176F3CB49EA9F9FE31266CB68EA257A1B9EA5
      800A4AE22818F3024C6076D9A671FECE9829EE6CA6683F4B33853902740494D7
      D52DF9607B5D732EEE7C2EDCC33F17E6486C8964D7B5D7316A6FC9254035FEA7
      56A09D20EC6A39262EF2FEB32BC3183EF7BAEA060C722477C884B3C133EA6F2C
      AEC7629129AAD43CA96B85E7F8C5ABCDC2622A967223F673B2DB56BFA5087DC3
      C282AF79DBE63CF93605CD20C8C633F4346520A14659305715377458A62CF953
      8AFFDF2BB9A55C93823C4C1C38B0E97AA6B0D5319607E6BC557A2185A5509EB9
      0E30253F8F8C2BFDA7F3F3E4D9AD18751251E5EE27485A6DE6898A4FE0ADE600
      DDE6EE3BEB5766B85F9736FBD7FEDF3B49159E1058DC51904E91746CCB7E7F70
      C0F0A887828BD3EA23E68B143B11EA83BB674436A5A567B1229A2AF71CAE1C49
      681C59C7F0F188088216584EF040E7B46942A1424597B8CE918B55C5FF4265DD
      A70B5A09BFFD7735EBC70FDB685A3FCF7063B9C479BABB9AF8CB17C86F8A6505
      98DB00FD675EB0D12132DC68FDD228B22E8A4F021971BEA02D9EEA2205CCBBF4
      D3BAF4C0E357FFC04887FF680651F074145BAF3ED09D742EC48A0E401E4029D3
      37AC74E31E8A4CC4B8688EDAD8CBD1BF451EB89A71A4E76E47405ADC7E2EE4C1
      39A9CC7B31C8D20BADF12C0EC61478F13049C0358EE193451BBF7C5168E7CA8D
      CE755D8E1CF4B2CEB20C3B9582CF98DAA83F9CECB5190C5C4ED32966E86CC112
      94328A2138BB715DE30AC5DFF2CAA8CD8337E75A1FD6B18C31DB8F1ADC6FCDA4
      223D788290B35214E78D4CEBE162F39F9669BD7C7142948923D046628219762C
      2F3572ECA412354052D62D15915F283F85988BAD8000D54631D62D5F5075EAA6
      7586674B9F253544364BE2E57476F301030AB7DB1F0138AC12E752C66D980331
      C47570060588AEED68709F500571E929881F13B17261A2353258AA43788C6405
      45BB4294F85A4ACE7E5AE5F6D7A88042496AA7613C22DDBAA06C1EE3D62D9220
      4E828C7FA890774E0A64F969C2A29F341C3A7E9290600C06871DDD5DA0267D52
      E06C6FEFB12B84FCE128FB8187903FDCC20F2984FC2938FA78F1241B9EC79323
      094633EB15DA9CB1E73A70D65110026D6D585B14AF076FCAC2F4237A82FC43AC
      DB472DC3923CB3693F9E865C4BB5C32A5B48B1730A951990295520A06331FE55
      D16AFAF816D12AEB16554C7B14159BAC57BB6FDD6A4166503638B79B6BFB8EB4
      4439A9CBFEEE574979BAEC594E2578B28AB66F136F1A47A338891ED066BAD7A9
      DC68606145C24B74B70C55009A6B5B52694BACBC82E6B320C26EAFB2AFE82896
      567B1258B50A636A2A3E3C7DE2A2A44AB0FF56C562D52D95C88F4F4B8999BA18
      C8B79C5DB9915EB9DFE05B7497F21BECFC0D67A028876130DEF3159478B63174
      B7D36AD9D6F18F5FDF9FF64F8CDF589DFB9FD159FA849EC5475F70C188891DB6
      B09BB4A655BAC739CA7B54E95766BD03AD33E4EB114AC2B65ADFB65ABF6EB60E
      FBD6FAE57CE7D3EC879424AF79FEF5CB87EFFF7AFEAB240A75698C21094C120E
      49B87E1CBA1050CB74414E1FEC30FF2A2F88C5B9D17196078C192AF080542097
      8C755441C569B68EC9BFA2D0E6C4B0F99BCFB4D4A5D11EFC0C0EF83D17736697
      09456C0474C22D551827D9EDF2C36A3B79151C230F3C9E3CE06E97070AEAB348
      E7BF72A72C96E8ACE3B32F676DE7DBD783F7FDF69BF7EF6BEB0FFBBCEF3684E8
      5E27704E7E66D0C065C94A43EC0AB68C54051DECAEDA8C8D98E32BEDAD260F69
      128768EEC016CD652306C7AECCBD0B2ED58542C248CC3C2C369A0071E0967B58
      8B4FFBFD49CE940538B75703FD7C6E6A98EFDCA5E5C2F7D0F8CEDEF3E6770027
      84A6DF84CBA6DC747D2E58556EDA31E5A6EB21E29BE574125C0BD395B4C2749C
      08E9260BD214EBC8027114DC9F19C166326EB666DC740E3DE3E6E58B7FEDF4DB
      D6A985040363E7A82D245739CC2B59D237D54C89D230E65EC41510534003FF00
      F7BEDECA5D58B90FA42AE3E8182E8D8D1C9EC20CC57C8131AB58EE314EB0F128
      1D80136AA789C18E2935CC4DADEC2AD69E159FAD8B5C7D1BC4816799284DB0E9
      006C988FF8B1C05E314002E6821A607090EC3C8EA8EB58C0FD63422FCDB8C90B
      C55B62617159603C0DB2A5576CF9FCAC8001A0E802282EC46A142339D15155D4
      72398917B4E5B8A05443EA2A4E2E9EE75A6BE046BF07E0D0E4601487183A11E5
      6832592261C0387A4098F8999207D8F53E1207B5BF9C6CA20AE92F64D9BE18C0
      8055FCF26A88CF1F03FA83E2BA71EAB0C2599C04FFC0A49B1059448CF9885845
      11DB3080084F4ACF28CEB2783E8FD38C9BEB3CCFD50F5AB07A2FCCFE345E2629
      F510BC1458145F65015151C942FBE414A0102E6B4853F3085382D0850E783342
      1380516FEEAEDED846BD31EA8D516F9E48BDE93E07F5A687427E9A05E30B24DD
      497C55E2D19C348A043FF22E832989A907B8D73538570FA5D42FDC3E60127A5C
      8B1897398E17DC9891121A4134230DCE4FBC29E56E453E71FBC57395D37A288E
      BEF5322F5F750DBC2800E68F040E42F8C186E646FD7C160988E46BF153C84D37
      0A7A532189D33E575DC0E48D653681AFE855C3D6CA86D9EECC5AD5556B4CCFBA
      75D89C07D388622F22995A29D2941CD7C46CE79E8F9D95D82DC07C79BD1F4A29
      E91EEB02613ED67C490689441051DFED1B02CD144EB1AA10EFC751FD1A0185CD
      05ED4FF7641711863EFA18C99E601977956F25AE2949FDD19DF258F605694013
      26F0442D9629AB90884CC66CF6D181703A897BD5CD951F322621CD73A96A63D6
      6B5979807BCB22F8D8A5283BB4A11ADAB016A1F052A1FA1D8471463DCBA86F81
      0AE1E61C53592201132BBC7426A461338830B32584796D1EAD9D134C8D43B3AE
      A68A4DA380631BBA9FAB5B203F1CE5D03902AA3B5E926925504D82D2B81C9E5B
      BA1DA0691A10DF83C9A4654C26F530F6C70F6823981B9BC97A7D24EA9ACE722D
      C61BE65DD147CB20A4583A0D3AD9069365A43AD9F8DE380B2E29224466E2162B
      1E1CD1A047F0F211173A90744286E1D0A5E3601C47AAC212A637856282AA5E12
      61436395EB846EA9AB20F2E3AB064A2A978147D7D5BC91D8A8C13FB39D77AF8C
      AB1BC651B95508B905B63386F32967A55BC967F86CED177E88D0F6CE10E2B772
      1188C8AF974E589C2C274DD0FB39972215887664188B408CFD482D148F7D740D
      275CDD2E4627015C159C3DCBE16D272482BC85DBAC63F5ABBA5B3E5CBC995FB8
      0F88717EB21F359AE32F70A751B289531265A4602F85722E20162FD42F0C68B5
      4C603F33CE4D95CDFE243AC9E10198BBAB6930B0C84F2E322325D5DB41CBBB42
      13152A80D48F3A8E266140E52241C14A0CD52D535D252521CC14C550AA0243CC
      4AC704D6E311D5532354CEE01C22FC98D8A5F2CE14891EE9035E542A51A72810
      ED0F15B4BBE7135F63B9C5F12A8A8B6AEFB37AD537FC8A137E253E99CF4CAFB9
      D48E4D5DCCABF2ADD16944C9349846F052D46135760248B3A5D18476EFE34731
      1591BFED681B896A5DE747F6457394928A3AE03F05AC47EAD3AFA03A5A66D9EE
      62BA2F5F443258278BA7D35070B900EADF4E852D28185A0D99C57128E9847C08
      95B194A2A575BD45E0B1A320E2681E7CFA4CED2CE977C774FC7893F900EBDFB1
      77E3F1C6A13CA9CDF37F9625FF4401AFE608967821A2061BF1C7C59A5913502F
      29C65BC09BE5D966702682C4AE861405B3F16C775F4AA40038D07169C1DF1497
      77A2DE2227284119A46A2A8666EC04F37730C5D3B73F7C603667C8C4561100FD
      5C538ECC2CC34B17E004915E56CA9549FFC8DB817D8A752F20C908F4C384A21C
      29439A1BA4FF870540FDFF144E2BF94116D1C466AC962C441ECC014C1C1097D6
      A9C9F9F2057521A7C331F658281F018069F6185B299BB402F2A2792817AD71A2
      CC8A4B6B80B395715286525ACC61AB8554EFCE3F1AFF54B58983E318B5A1034F
      01420C4F9F3A1554B867263093CB3A86E378852C4216E5698A342C1438678E1A
      CCB5AC2DAB4BC3812A8F5D9F25AA27A6752C2BBA842BCBD4239D54477ABD671D
      91247D64A5619CE5A23785C1C0EC82040B5ECE3FBC4D8161A2739C1FC379BF7F
      777D7D8D3DC6C6A269BDBBF6E860522522FC154B64626701381EB25FFB5C7820
      3AE4D4AC58CA995E87F184B1E574DAD6116EC1919EF871AB85BFBC7FCBA285DB
      1A74F5B4F53DEFDFB5E46DEFDEBF7F7FA2565963E7BDDD6A7E5E7E09E3BFF732
      0969D4419F3C9133AE434C13B4300B3591DA8C5E0B5ACDE857596114A1512CC4
      8BF897A499E507D380DD40B41FB44F4407BFFFFC157636116140655964536D1F
      9D52732CF75778B517ADD07D5A1FF90A15B4D18C45B971548183D44A2EA049C9
      01ECFA43A6929F9E49AD72BC2F5FAC34ED57F5D8B000A7AAFE8EA66D7662A532
      8C27B23E8FFE0640FDF0B6A13A6C7345CC1C4AF2E432941AC0E5FE07A189C678
      E0A3643E44D8708044CE6EF203A74FD35E8755D2125D3E993312430523CC23D0
      5EC3F4DB2770977E9846800430D5A7F09912F80925BD1CCF99CE00E6EF7C3E24
      D2050723C045282D40E39C128DD6C8F21314083BFD21154B3FAE0BE5FB8D875B
      833282A770B44A4067622481CA1D58004B5511B01D8095C41EA331527E78A20B
      2653B17E3FA6734D14BF7836E4F92CF20D23C9EDDAD72F58AC5144987AB33B12
      78659D79D80AD164966F831F80A758F54E0A29CCCFC61EB71A9A90E9932E91CB
      8BFD0BF4AB6482718495650457A51861AC85F48D318F3EFB72A65D515CBA03EB
      B0621D8BB12CE7CD49EEB5B90B2C80551F7A31F35D78334F095E9A08DE726C49
      344B04288721A5A751C8149CC7C8EA80D4A4986951BAADD3B12911D2F7276B6C
      65DE057ECA077780FF03B7F3F7F3A2152B12B2298A56A2B76A6D9F18C2D4B580
      EB7F21650AE4CC1AF849563BA748338251FDD09C74378E4881BE6CADE649C9C6
      51D6F037A46BC3DFB1D20383572A0D4571AE0615E75E048C879E8C96E348B40C
      4B1878D604442310F19699907D1090D8AB82ACF474AE077852F84E3065516EBD
      C4F4D22AA35B6D62F154286DA2C07F9BB09F7C0BEE16791CB338E1383AD57807
      DE7C8401BE0A7A44BFC4119F3AD037969E2AE7400301339B6D547AD3A151804C
      B798BF2AF45021B851618AA715DDDEC29C082E4F21BAFDC552516580F27E9022
      4AA54416C692EE3C01406AD4685730C3622C8F5FA8F62F1878FA4A6A80C57302
      A40A74AA94E2FDF0F022ADA28B4A557E0AA95523D839CCE6E98045B028024B72
      63C57E12E4844F51AEFBECDBE16F487A86BF3F8558FF17267BB21D16F9DC7218
      19017A17043FC148C1298A46642DD2D8449D11A42500C4A54A19C088D2459E29
      8B57E990B01A084C004E34ACAB852D7F49BA3D4B40CA842812BC817DF873DCCA
      05F90A7137D3DCB4C38E0EB2D1EA568179F0DAD90F3FA2670129CAA51784C8C2
      A4128B5C3FCDD316B8951FBC6CB9E069A0C1B2600E34C7AC5A8C2EA83854708B
      951F2AEB668E53D57162F0487DB1A8259206A1255D2F0F2528977427A1B73C92
      B48A6B7B8F1A439E2E2E62E669122885E83C45523BD10DD2EF8E83C9ADECA00B
      FBA1B1BCACE177B809A05C4F4FC455126419FA797315837C0CE938C1D80D761B
      CF76DB29D01D1E514540F651CD034A9AA1DA15BAD69F3C3905F323F7AF44F6A1
      3BC5ECD7C3F2BC506DB841A37D7D77EE6287EEB6ECD0FDFD4F451804D8723609
      D08443EBA4534E116F2BE23369939ACFC1209D6FCECFDFC926DF6E5E9A500E73
      FFF5DF6B68548B7009404B9BD9F5E33773CBE1621DB3BB55FBDA94CB288828C0
      BC864052348673D5E8C2D24E348594C0C65D95638B1255059CE13006B59B8FAE
      08E32C6992B5F7642FE3C05EAD5C0BE8DA90EA9B96C41EBF6CB148E74F921B08
      00788AC5864FB1586DE963F3B4B49166D8EB89239890F06A5FDD277629A52293
      1E2736DA62D44040C5708BA6E9BDCC78F959DD3DE720BD55B98F07DE41BB7920
      553F7A77ADFA71575CFF6D27AC722B7B25CEBF5CEF64B787507368A8E148D478
      7C76FF23791E6A53D27B252DA7C84EEEA148877B1FB36937EB15E8F83C014930
      F042EBEDC73324663355F0580A12A7451E7980A8E63E0CAA0D7FAB816C7CAAFF
      DF4F5F9E0CDFA848F54F5F787F641D08D7FAE9CBA16061A726169E51AF4550E3
      CFC2E548391D1E00191F628DDD9A6B54D204066B15ADE04FBE805ECD05447174
      5AB5086339B03E4C94B5AA60A0AFA1D815D4BA0CADBB32FE51D922319040A851
      6557585626E388C23428AA41E68662CB8034CB9B990632B23344CBF3AAD8888C
      C5D6FC317DBF7A0DBAFEA5BD991A17A4DBF75FC6932C96E47D86C951B75A1D8C
      8BF78F60B117C62EB71315B044C727DE87BCA6AF1FEC0E030EE3A9398725EDAA
      043F040F1D1B1D93AD3BDCCBFBD0AA5C36957899F4E85034A19760F560F59B3C
      E59E4F879C0F5CDAB08EC6F162851A64B3D9A40370C496C0601E84B03358CE8C
      D3D44E726362C184A8ED8AF5F3ECB5BF6999CA502A69049704429EDB55BCE424
      7321CFFCCE914BB464AFF01A54A9134A665DCE55692C34177EE678F269A0956B
      B27A628C4F1A473A1E49A7CB4BB59A68E14943F3CE461EE6793C29DB6FE02E32
      6CCB379191B4B4A71C532DA3D17F48C424B8DE4B63A72CC5424CAA8CBD012A08
      4042EF1B6F4264090C44E75EC7E4FFD81DB056765DEC760EEBC4896CA60D1172
      B33864897C27DB4B5C6D3D8054735EF8F7299E2285B810A7B25CC653D9B56093
      5E6514223513E38B3D02ECDED78933CCC987420AE6868ACFCA9796335D0A2937
      F43BD9F2D7F83716F7CFF7F097E6AFC512FEBFFCD7AFF5D322FE1B0E3F19BA64
      501D85ABA828026ADAED736C0F276CACCDB8F66BDEC64B7CC15988654DE1E89D
      6549F8A77758E59117CD2BA560D05265112977D4AA0D520E641C8771CA078C49
      3C83EAF37FEE91C00B04587382A3B375EADDC81B2EA8660ADCC149D15372A3F0
      7A7C91D2EEE57184ECA50462E66150FBA76F34DDBAF442ACE74BF4893246F632
      1DD69834C53B08F41EA5C5DE00A96E976072116B48119F77DE4189A2B0BBAFCE
      359091B9E4656030A61969C3D9D72F1F69BB7C3E24633C24AF8CC0A68330E818
      C86A38B784662E525149D8A6F5B6501E7FE285E91E478C1D4094C9CF81212446
      34F8CD73802492F899087D6EAE827329913FE601DE782C16595EC6E3D3CE1713
      296C2077B7FE0A4C73C1CED8638C8C4FB355284ED8F39A9F690C4F31853F6A94
      BFA5C459E4BBCAF3D99CCEB02F8449365EF758335CF2D6E5CA31063B9EACAE48
      BE3F16D788D99694B031D89D3307C6186347357A38AB0423AF7D14BF7498BD1C
      3E4FCAAAADEA60599008A3B1D4CB3038BF385D183448B346F135939DC3CA7025
      4AD0DB43367CC70050C5DE70752C833454B103EDE74729EEC6A59B635B6D142E
      29C73135FF02E248B4313567778B56284183263B6B020777C9F94E852C235D79
      93E5CF30466D3C980B8EEBC7DBA6310537E179B7C220CBF0B0E195A25ABE0025
      650FDD19E6838D79B8D85D0642F4CE6756D4E17606BBC109D31BDBDEC8CD2FD1
      8AC5685E6F6A15CA1E7069432ED1218B0CC3E1C4E2F3D3C4532CD41A93F32182
      D38B9ABB0A3184813DAADDA3DF5D3F394B3FC35B21F3DC339C15439F3645B523
      3B46C3EA551061A5D513DDDA37E55A48B228B23436C8BA80C72331F6400BA813
      88CF55D7500753060CB9172952EC7819653AA08C12AD38D14F998C4F9A18EF3C
      63207AB410CA2DD263109D8F62C22450F61658617B1C2C506BC28E6BAA1C11E6
      F8B3D0C2A629B91ED26400343A631F25356905BA54B9FB4843F1F5CBC56D7600
      DF1421FBC25508553B2622FBBC043528ACF52A53C670F80394F9A5959D37A7F6
      AC5EBE788DA1243029E6A4ACF8C3700A4CC5362F80CA7178C989670B8C2B9465
      B429716E0D4C122DE0CEFCA0708439B21F3449CD17D96A5BB8ACCAD95B2CC215
      DB108FDE93418B345C7C5ACFEDA859108D654D115D517D1107111FCA1A944A46
      D747820EEE3C2614A0C27FC0C229989E81846F03AAFD2AE5CC505F2E0A2023B3
      F0B43D2107209D0B021A0527FB3EDB13298C12CE5CE185B43ADE0B80F69251E2
      A6D573B510EF4250B5102290C24B57D29B022B20FEB01689D760F222941519CD
      2D5E0D18EDB61A1246509A2421CA1A26B1F230416CC5DA2E5324343C1382418E
      2758E504CF001D6E24A66BC8F554828A733F828AD3DB2EA838BD7B77DC30BD39
      5F733D1801A564BBA2E8E6BCEA1E594A29C45871E886348B5502542707C81399
      5FA523A9FC2DD2018943D536A86FBC0ACF100A45D445309E70DCAD9234F6F21E
      E4B3D4553FBD42E5BF3426B322322B3F90D55DC4F542D5B208223F00490675AD
      D2C9953E9D802A5AA290567F52FF2D5F3791046F2672A60023935719C85B80D1
      ED01695BBADBA49AC21EEC58E62B93CF8D032C77BB350BA96ECA421D1493A10C
      61DAA9A852B9E96FDE72023461F31741BC496391214FA5E47A3C45D719172C8F
      B7D4E8246A10CB8ABC58BB4A8216F09A6B7BE7906D143511D0C79691B6DA6109
      2C95CD14168FB44C1DB92A293D1BDE6C66E706FF6B869515753883EE9BCE7A2C
      F3C551F0B112110BB68448DAB4F6E276143D54473B457EB82AF8511D1DD1540A
      8BDA9AEAD750A59E22E97BC7FB8ECECA2B68369B47F9D953D5440AC79CFA2D20
      7FA121C86FF9A9908EBB456552D573654529726FF24BD72417784D2A351A99C6
      A51C73B2B4798D6D1AEFD6140A0E660408D61FA62485A84C45D0F010D76FFEC4
      6134585F05378994A4308EA98E8E4CECD4B5A0B9D65D666127A8CC6AEBB23DCA
      E0702CD5E53FE1F62AF3C649B392E2CA02961266971BF4D7BB79971B051B03F5
      F041F77F1D9DEBE58B50764CDBC0075DECB9CC0D0AB594191B34A6115A106EB2
      0EAE22BB3644CC506248B1C61C9B87B0A84B305AC232B5A14241560AB7AADC3E
      4D8AD2CAE9502B49929DEE79512739B0ACC43B12BA6D38A9F480BA3560544B98
      E63DB15E936D0155D220D1FDE794AB5CA36CF9CCA822404A6B5612F01A1AEBFB
      10DB9FCEA1FD8C78E11A000D232C12BA75ECE2EA5E64C90958F32B9D20E49AF9
      D911FB2B44DFB319AA1847467EEB12EDF910A522C99A75EC8A9FCA636193782A
      07416EF2AB6883A401293EE37EF23F2EAC6FD4E7B7A4549F7D395B9B14D5E395
      913AC591CE67C124FB134F5395EFF6B2422CB10AF3211E4BC6317933769E8F74
      D7106DF7A3570793AA61B0C6F77AE410C61A7DA9230AEEA66C72CD3216AEB4D2
      B7746D1F776531389B96550E509016CFB9F4F9EB80EC42213E49DCC355B93802
      4720509780020C537E4B834B955F0532342A876121C3917318AF3CEAC42BEB3A
      D5F77D7AD4D89486655E9C572CA17EC7A633F9B61CC5FEE17726FFAC029A4EA9
      3786224F58B3B950E03F5677A9401889403A845793520E83B9F4C240B3E743C2
      89DD7C81A3BE4FADCFEBD297CAD490C7A0E49B7B964B7DF9E23C5E2663815BBF
      2E6CAEAF96F51DF4B2B04B4CBB2BB5CE44F5C8659C352381F44F4D76BBD9B003
      5401F90A8827B783425701B278518658C3DCE4F4D554D7F9F1B3DA0C80DC88E1
      758A8CA4087B9D9ED3281F358C61899EEF497BF982EB7C5B1F3FF39A3172466E
      7D813716F95FB15D408E7432752A5518B2810F64F5D8399FDC2CA20B1C2A442C
      44EFD2C89CE8F0EDAD92B0D7C0EEEC9912EB6C9B3D28D83B399EEDBAB76779F4
      705D9E17849715014734CCC1B0BED75C05E274BDFA4FB924B20EEA9A63404C82
      160FA055F771E2EE75EB6BB9DFAD379894072B466A8B762A315E9612A0AEB4AB
      9FA2D6A9B995C74F81181EAD74E4BECE73A134BFF5D3293B4578F903F2BC7252
      60ADCD29BC6CA25C555B5FA6EA0F57BCEBEBAC68554C5534080FA57B5B04118D
      C0156A8C965CB2EAA27CAFC41D6EE0466A1299C0A47D67CEBDDE95E2446D5848
      FD1BAD38549B433FF8562D32CCE3E51E11DA6F245295837C461C8AB93B91A481
      EA8F429D6980655D3CCA8469AE19C595318FEC6D18F8C10702BDA222317ACE36
      9A3F387C3DE787926DF77B69DB95657FB49D43DB19388E4A64D21D3017EB461F
      1D6950F84D0E728C25CFD33CE8F7E4598A6704A7B352C81E2538ADEA3878A424
      2601821E264C59A2380A0298B26487C162145363586DBB27C16FC4D1A6C5064F
      DF532D3C3F78D4BEC6074E9EB79ADA376DE69421D7D8E68D50F6F442DAE18647
      A2CAEC5968611DA800CF263C3965172285E7D7C09592A85EF052ECD9198120A1
      824C0A7344E7E07AF4C3D19AC3064D9EA52C43DCF129A5F72A474424AE30A08E
      8C787A70B28495FB2C507A7739E9D47827AA134FCAE862FCF49590A153B856AA
      90945F22A764915556E59D638F64EFA442FB0BFDB67D1CC5A99499D0912BAB82
      280FA64761BAB92D5C1F199953BB973F9A6B067055662E4B9A8E9360945B01E2
      08911F93F3EAFB623E6310F1069465DA84D46DB60298EF09526D022D3732DC27
      9D5F065B50B8BB9CCACEC7D6E62AFB578D04E774A0CBA6CA8340F3D4D94902AB
      CEE6395BB8916BC62443B7AADD213263C404186D32E294D38BBC348F0D414A90
      530074FB61989C7544493115213B6B8D73CA012393AA289D7DAAA8709BA374E7
      ADDC7DBC3A3259DA2AF1B0A5E53207B9A55609B14451D605348F225C757ABF4A
      4C2A47EC9B53B9BB1A05BA6BCDB1BCF3B164B77701F5EA9ECCDDCCEB3E8E6E29
      72233F8C8A2DEBE8AB485542CAF5946D22099BF5C9FDFF8409BACFE89851B155
      15B7614ED86D4E18D7ABA5B00F3845FB1F347D8E766753DCE9A015431B25BBCC
      B9E1BA256197EDA098A408F78A006356308994A25F125DD2AA18E2083FED6902
      E0D76E23101A9E7AAA85A41A35D98A49E0FC613377471329EAB23DF2B710C2B4
      475E311B7966714C3363434B291F881B2FB277582D80A28FB47543071FA9A24C
      C5A47A539460F71EC0DCB1EED27C8148722EB7F2C850BFEDD57C2AC0C5D182D4
      19EB340FFE0FB14717F567FDE5FA57156DA34AFBECF6DA6FADFDD3695A6732AE
      8F53757C4E38C8E88DA426934FDF4AE77024986C4496B35F41AEEA8590A8CF79
      73F0E63C546EADB3EDD6EC064E67D8005D912D54182B1B3A67BEA485A89792EB
      13A1807FE50C2E6530FF9E0BE7DAB332287D73C161300F889CEEA69779ACE896
      3553C7B34CD2B0DC267B19785B18E20D200D830B217DD286D6EDDC932FBAD511
      D736FD45B5B2FB3597A473B43234B0A498706DBE6D70CA4FF0B14E66BD49B42B
      25C09CEC3E999BADAAF6A850F121E38A19F1155757501E3F22D8D8F878F37082
      18239AD6077C5FB64C2272AF738F72B49FA6BABF95367BC0FCFCC49B4E158162
      02ACDB45C98C1A6B8CB993D25C4261CD74252D457C25F09E120553A22DCBAC54
      1981EA36E6351117490C009F834C54632795855D6DD91E29CFC8061909F20E90
      3761C37A8838C1512AAEB2A12455A8B801AFA8A64FA13E5C22C329B1051F111F
      5DC952A19B146C55D6377A5B8BBD2B494D56858B0DC5AC4131956421FFA6C88E
      D26C77B2BBA96495C3826B24A9981E2C31A31A9B3F7ED76E2E3C2037F329AA18
      637D166AB79DAD497B34336E0428A7579B387D276B6972020FC577BC0E650A8F
      2EE9232B55B1B0859ABE4A3E4F29862B9894DE5DF0D7D3C4EADBDF236500187B
      A9545D8B85807874D559945B216001114E7042AFFCCE5794E6E925728692B504
      68F2A3D322837B0D99DBCDDCA80E32172A91A116867A1573FBC6F17CCE990A11
      99BD4054A1AADE79792F6988997992C7E7655F64E80A2656948A62D111382ED4
      01973706544946CC17312C7D9597C7BCF2D835B98C407192A71923D6B16EB6CF
      85A338024BB6AF3B0195B04E4497ACD5A684374C04C1FC4801BA20883ADE62A1
      5A83E883F4E8449BF0F32D01F41C20FEE8AD99004A6470A360238F9CEDD169AC
      3A6D1DEB4F7FE1BEAE9C1EDFB0F4753F1CA70DEBEC2C3D29C5636377270EB4DD
      02ED21E1DAA3C3FAE58B75687FEB613BACC6083B3C36C6F0EFE2F15B63E5D0D7
      25E24A81886578D6D8CFAD20E79072CA109E7BD8157E1C2EB19AA0DAC635FBAE
      61283BC328809695D438C355B44BBB58617C9BC64B2A37952AF732C1E1074174
      BA08BD3107CBC6DC14F803163FC50629125B5399A977D2B0DEC381C9640768CA
      F90844E8CB428258668107CDC7E2725E54193A9BE1EE897DCAAC9F172C94DB26
      CA6F67B13FC4DC3FCB4F408DA574763C725414721153655A386B3231EB5890F1
      9104645E58B1DDCE6C39C56AC2C75A21A72C0F2E2FE94DA32003809CA0F9D22F
      141B35C7B6FAD872417515BE82003727B66804DC022060FF54B2040DF0DB0E75
      B9C04C1CD5EBB413A9E37A22E90056284F2DEEC002B25EC0751748461825C2BB
      90B5C6B89A72CA31FEEFD9ACE40140D46CD018690EC26E8508EBE7CA528AE604
      E4365024B8484F5959474D45151A56C5AF196645DBE77816887D02FE8F18F86B
      857BCF54E5E98FA0EE24E951D12ACE5D8FD031B9FDD11AF2A02E0BCC5DA6A868
      B65F2E57FDCB385393C039A4BFAA17C81F3FF8C8BAC65EF835FE440AC0CF0073
      F544C3CA9FC6EBC5EF3CDA5E5152EDF25229BC845C0C418696F0A2095A29A814
      13EE2BC3DBE600D6B136407314324ADA270573364AC7352089C1E3EC29283908
      B262B96D3D66C392CD27487126D97E6D16D4EB4A0539948A9ACA5454A9EE665C
      7596ED49889541B9A21B8647F3B6169F00F204AABDD0C52EA2D82FC58A970BBC
      145FCF6214279361279295D4A3EFA51434E89B3C1342C04250F895006C7F9529
      D524CF962FFB08F20AEBEA06AEB12D01425569132F373DEA135D00CD2289B1FF
      47D312CD69934D8985AAE2F2268A6A0D851751B97DCE028BB12A373E8AD60B74
      C8139ED1F427FA6052616A6EF321F75F9073421634AB01C51A01F56CBEA4F9ED
      417F5EBE2057B857C02A894F8D2A4734DE7334C1DA0261F00F74A11D7B9C81AE
      8914EF9EB73A5165C7614EA93617C9DD563C5AA3982AB817633415D0901C2775
      3935061DB67C286EDE955798B4CA74CABB49AA0301830045CD6A95D28B512E59
      8EB3658265C96557816372C0CBD60DE8202B14B4F3A4152AAFB5272797883970
      8A74FD947A8C3B54617519A11C9FC531895554AD7989645FF9FAADAF798F014C
      925BA65427D0B3406FD15D3465A8A84E68DFB671E29A52355971A1BA88646E2B
      EE3D758B02ECD92B90E2A82841D0313993C7E4080715D7989F8F9B53282F7B84
      2A94C5BC8336EDA3008E7EC41B78F47F9628549E177921BB6A9944965C092A34
      662F9E72F46665BDF152F185B6F048561B246BC828BE564823DDC82A15A8102B
      C21E1EEE20C48E66AC8CADEF38FE8B453A2167E4D760CAEF3E7EC4CDC7961913
      247B633556FD6689F220AFAD242FF2D8B0FED4B04E19C0FF665D8855BADEC842
      BA4B606F38CEF875181E35F4B7EF8164A9FDF9105DA244AEA3128FF671D26367
      10AE899D930CCD0825599052CD6759AC58A528A8D3AD8A181768849462B88C82
      2A502C8317E155785E6486A957AC60A9775AA78F529A2FDD28D38A52A14757EF
      5DCBEF249F4E9E1EB12839918CE67183C71904661941C28971005DA3826C8F5C
      D6674565ECDDDC0E2915281C2B07EC4890E887A67C35A017EE936624D98CAE29
      84F116CB20F489AD6EECA1EECA832E02DDF788ED0634E73D42515425AF944B12
      FB143C77A45F7B44CE5CD55F0DA8EE0ABD11DA110CDC0DC0358389D4204D7391
      A7A5AAE89262371496828BBE0C19F694C62CB870A40F60D4F802781C3254048C
      36F4851CFB023B31A3D01F20552893C8777AD9BE3D793E339FD8B6011A5B6897
      281C07933D0BDB5760D77A886F96513E9C6266F94A9729367138AA695128A86B
      7B47209DC509F967A72292013C1C78BA6DA9B2C9664A678062F4276829CA9651
      A178B5C4222008D4D8963A487175680ECDF42C6CD286670A74816942CA008693
      E92C54FC99E3AF6002C8F1533E78E7E7EF0CA5AFED233992121FF6554F8F2826
      8F5AAC7F4755B34D14A606D80F2AE28F9A95D532EAC816CF2CCB01D5436F01B5
      732FC2BC206029A837AD37DC914DE9364411E63139E83FBD3EFF0AF47BA4A981
      76F517142B191A4EE392DFE2151E2B6C4B59AC55851A52436A1E243E85180B40
      817B58C0265E263AFB6D1981AEC202E1311E53223C28EB0BD6CBB0D8172C24A2
      5E3627780EEFA5FAF742C40B951AEFC7BAFBA707EF150BA5A7C17C0A74858838
      9A79903E70B40F25CF505E512992A066E4582E90AE746C8FD2FED09020035794
      520AE02B6EAFAA4BCFD453F6EE836DC5BC7FBE2DE05C1B5901F3E835FCC603A4
      37B71A28E43CD629D2B69EADB56D5E8464627D6A54AB2A5DE6D62E5168D12755
      B19440A175255D535E0D14597F5F02AAA85EE67AB5A497D65B6F7D75322E05C1
      E83E8CAACE4CF1F051EF9386DCE9F97277D676A67593878C242C1C9E9BC35278
      31B4165CC2E3C7460451DE160FF6BC162028A6F1FEE2733EFC276CC9CF40223E
      CCDFC6B0D14F10A0D3B47EC0CC4CC1E609C66E20593A564BB6051432D492C423
      5FF55888A8C582365DF8B1758138768523D02F09568B848519B166B76234C72E
      ADE4264D25A525E3701A27DC94951C2CD21826A99349362E78BF72EE437A0222
      E272B7CF588688C8CA12E50C5ED40BEABBDFCE61A3727EB0D5CD56BCC53A2606
      85E5EB37F5C39323CDBEB8D59EE22E9468865850BF81CD3AA7DA3AB3D23D6873
      FC22192A1995C9AA277FBC696A352A0AEF37772C491B5AED82634E9ACB647606
      303E80DF2437FD2201A36B947AC8B16A2430482193FAE0E432004CE652472748
      6B6C2484F45B8D72990C6923E5148314892611CE392E08761C417D19905ACB89
      3CD2D27722AF86183447CDBBA991A24F99818630EEB64CA84AFB6CE797DAC6EE
      60772C5C8CF15B26216F231BAB08C8029C54B67239FF6A3FAF01E964DAFDC39E
      BF77E79F1AF0CF47E6611FE3B147EE3E5947178504369773B85B28CA6EBD1B0A
      36985353ADF493F5F28B9858BFFCF0F1BFBF7CDBA2FFD9EEAF487D947F34EF6C
      30FC0DCDABC3DF9BE25A98E3B209C463D9C781C1B8F341DB3D51666E6F0BB4A9
      504901E2BA4E6E21AB8123320AED6A64E3592084B0127F1CFBAA0C7F8149D577
      F1959B78178DB959E2C96E695F9452EC5B6F561B36793AE9652BB3398FD5A966
      6ACF9ABEA78A434A89C29CB7A23B5D9D8BDD0541B78134F7E22A718D823E3921
      A154A541FA7F036639113997F2A72936C94868F5B64D65629FE9E2D571B48D6D
      1B445F2B255E5DA243B61722C02A6B62C4B1FE6CCAC4D253DC74455DD3710F32
      182F2F28BEBBFE2D6E5AD35209B030B3F2EB27315AEC901F31C3916F6CC32EF2
      1CCC21D909E35F7E12C9EA576B4B3892B1E2D4C8782FA3A1364FEA367B8F9F5C
      F977DC49545CC66A1F9F22BFF2548629154ADEEB7A73715E84B9B116E9A63332
      A9C0313E624DF3D6EBDBE3C1C779B03785A24971B421ED2F0DF2C53C853F0133
      AF0E653754DC36854F72F8CC26E4D9E6A83BFFA6854A511835102EA7309B6676
      9DC910911ABE9D62A1AB52EB8E4280DAB10C1A0E26D6D9D72F1F51439989D02F
      D73B3831A47C17B49986FF8235DD7EE5F85443C19F2D052797CA5352EEBC5C1E
      9054F8130ADDB8A07098912C6BF79BF4FE90E94CD3F7F5DC821A732057D246F9
      3C195FAE933B365A0D47E14A06EFFE18719760FAF696A3A773B381CC0A3A92BE
      84239DE993871A1CE5559B70312ABEBBEADDCD2771D3129E208C9E1057B6F015
      0A43601EDDB07E7CFBA5A19C361FBE7E3A02C8FD7D49C1DFBB237ED08CB3603B
      539BC23ED375714196D8D051148CB918428799531C55C7283109D85B72F4E6F3
      F9F9371F3F7FFEAA23F8617A18BA590AE4AF6DAF629ACB6E2A8EDE2F977C5C26
      116A4713EBE81C5577C4428957E86713918E02A11C6A509EF21A94DAF8057053
      7571C6F134421BF509A7870A50BD76C72A7EB0D09F6FA143DFFAF06A6E914F5F
      261BE02C54EC8D4A1F07812941C09CE4591286EB5667FE27DEF455F4EA2D66BF
      C3AE5DCDE2924DD5D44BA82A2BB551224185F0AE4761579A1B4AB0C660B262D5
      C219BB908E8B12287B7180649DC83AD1DA561151125BBC3B976FF6B86D279FE9
      A1F8DEBBB4E618941E14C2470CF6E7ACF33D08125FDF9D77BE393F7FC7253D3E
      BB0D0CABF748D212FE543590C28F5818E0827940C41AAFCA12006E0A728B6A0E
      9408AAA8A98C6CC49CF59892B314CB7362123185764672BF1A582F2492E3E5AF
      C6CAC31492EE8BEB3CEC15EF99539FA76042A255D6B48EBFA850756078B52051
      E68A6C1C40B689B9489349F304EBF5E364CEFE931CC074B4BD514051F0E96C39
      01AD1A65D4245EAACCA9626FE0B5829A6B2B92CBBD922DAC01BC98918B81181C
      3C568C412D3D9EAA285F4E1806A63C018E4F51F44184C99C1C8E1915D8F9F7AF
      7FFAC4AC9CC2399442520346BB0B20593E08BB98953E45BF1C45C4F9CB71217B
      8373ED41D898601917988DCCA24521A07EF8EE76A41D53C5D920E50406CC9A0B
      C612E212F55245D53183D057E665BC13D0691CC38681749671DB5FE5672CDCC1
      30AC3DCB2F9B7910B90345D2230E15A44867A045ECF5D7F93C3BDF305767531D
      9B3D42A0B7271AB1E19DEA8C0074BE968F2CC192D0E7781467B33C203B5BBF0F
      CE07E5DBC2DF02D928EC041396137CE5DF96F3451EEAAED3E1E57D85F8E28685
      B4946B73D3AA65E11EC3066BA438C4D3C4C304FE65469591A401827630D96D3F
      5B1837EC66263FE2A9B41CE299953AA0AEF111487A235B88E013585331CF95A5
      2D69142E622A048F375AE5ADB1F1E65FFEEB579DC50FE23D410643FC23322BAB
      3406B99BB2EC811A57371691EF2BC550C876C674A6F0AECFFF89AA73B69E0399
      EE1BE6B49B7645DC5010DEB3A09A61FE92AA13A9AA96919AB0C6D9C60DAB4238
      EBD5732A8CAE7EC9553450640FA2A589B5AE152CAC8AB76731C60A9B93BF56B0
      BF089C3CC0178F201C7E1FCF7DB17CA4F51D485BEF521523252F52C7A10F6FE1
      C72926B27E9DE9F862ACC685B2E2099CBF2CDB43E0F85048694A40D5D19962A1
      47199421E9A124697AE304B83E867797FA8D9B3371C399A05033ECFB9679D682
      02D3295DD79C907204ED51014264CBD47D70654619D377596EB554E883C463C5
      4001F9AFA8C4CD55CC9999315930C93A8227465ABCF7927741CF020D91426FD1
      46CF13C0C1491739FA24B07E24159780A358430E400B7DD3FA30A16C1E8E735F
      9F6DD14101DC0AD421CE72D43092DD40F3D4EFB569901740564DE20ACA89B62D
      159151D7C4E0E0173909C5288B2D7DB9689312281C98D8D69BEB6790ABFEA3A5
      75C9346EE0BF75726A432FE16449D9BBA248629BB2A359B1D40810B3E2AC3598
      B93881DADC1B0F6D4EB9BDF42295A51D22019AF73A3CC84651D8470E4A9AEB40
      1F3616A8DA498597ED4DBA09152879C46373A34A0595D3AA01499EB9C606DF83
      C930ED6F1490ACD06C8A3C27B0AA26A005696CBACBF7F15FAC77C434CE815D60
      4B951F65DF382F2ADC454717D471F7AF627C81D18419A3B9AFFA642A68004BDB
      2FFE1620104851BA001E1DB4515C0EED90C86631C5026F2210E5B0923E2E0BA5
      D72AE6ACDA8587154784E08689D9818CECC7F40175A7EAA52757211127A2B0FE
      29C72CB377D02FCD4F256607DA1B78BCB6CE448545805C212D2EC8C4738A3963
      3A940B213C114E02F6F30E3AB7C154DA18CA0B4A3748100936FB90F6D926C1BC
      05FD615306BE6E3EE75A84F4CA0D0299CA1242B813D2ECC545EE65889022637B
      D44CF9A88D11EB626151E62A6C0009659825C562D8CE176C97D36A942B113930
      61220196FDCFBC88EA9D49C6B4061B2EC557EA595F66B5FC282667B198AA3544
      194A5CBFA433D6A80196AB992648C2AF6957E0C31BF6937A16C133FB01A7F7FA
      4D93EF99C2515381CB78178E7085ABA2222B53F46162C1180CE0293E8DF9DFD8
      F27EF7D4F65D8AE42F656016D11B490711890261E0D6A6AF25E3076E8C612012
      23A91B0450B76FE52D6F715C5E464382A70C98FDED7DC24B03AC2B5930FB4D91
      5724F1723A2B9D5CA06A85F75BC79CD5A70B03DC70D2B950580D1A2B298224B4
      6A6FD720A5BCCC825A119E8E56A7BAD2059166AEE9CD8D715F3774C2EAFA75C5
      BAF3EB6B38F6339ADEA99F860CE445145F275A1A594B5B43D45FE635CA3E9209
      93796AD04124B7084BB4B5C2CB6B48D4BB69C4DEB870B35844E5F6300FB458AF
      6E99607D07941116180D8115F71216321403C15F8E65AF103884B44312A7D7C9
      EB89CC0F2D16C5A32A030B45B47449571C763FDE84D113797177187BB20C71AF
      B16D1051B924AFCB4AECB4F4AE5A5554690CA2F5C0BC5403DF1268A492AF1D52
      850CDD4C65FF2B5115C1F02AE3DA02F15420C56D624211219E62FC6BA313E435
      DC53F6BA15C129F91F7BDEA88AA71C3A0F362BC3D83AFEE4E90A066C6AA30D93
      F2B5E404F4CA7B2900C3AE3D09471D945AA49DA928C04F0A90790AB214BAA5A7
      D16F9AB8CCDD194152C0870381314BBA525CA1844E2ED61B9346096CAAF6AB06
      9A97AE01AC508D08ED0C708E801D08964DF084D52562EA75DEFAF85AA8A56640
      026903960F1129528F1AAD7365CC5643125F9DDC982E0376ABABFCE294FD0125
      CDCD921594B1BA00BE4F13AF5C1BD32A27CECF581477EEC71B72B4904F1F5B3D
      58DF8970D1B0BE17D7CB14640CC0A1BF06D977CB5103034751BE6A20AB01569F
      08F48E7853610259366059555D7DCD69A67523AC357C15447E7CA5B641855BFF
      36C4C2BE58A38AA03BA47ACE12C4D6FAFAD656563BB496E60F8B29AF8A163B69
      5BC357A3DE108EE6EF5B3678129CB6BBB80B3D678F9D86B5FD6D4CEB0254CFAE
      F1D91A7B1FE262B621003EFF3828B03B7F180E8F750A7A2FB52E99E1372467A5
      0AA887B4A535A44C4D09605DE878CABFE3E1CF97078A0DED8D34B86175295262
      A6D26A290A4DFD748DCD64199121DE4B9F2974983802684869FBFFDB7BD7E6B6
      91245DF8BB23F41F7014275E4B3BB24C02E0CDB3979025B9DBA77D5B4BDD3DFB
      76779C280005092392E000A464F5ECFCF7F36466150052A408CA6E5BD8A167DA
      96485CAAB2B2F256994FB2414DF66F9C18276F48893C532831288574C2DD752A
      5EA5255C99A79271F2358894577A7B368A26464D186E9135AF41487B5BAEB36B
      F23C3E6A357CC62E43C8CD0538A6C7C6BF3C5200F3C90136B4254429E7948ACC
      28913561921204722389B8F3C46AD867CEE970C48904D9D18F4FF339CD5B912D
      CE7F119AA6B10B0587181EC96CCA90A0796EDA8E9539F6E9F822E5364C3302D4
      9CE34FCB975BDB69ED32C9418441E0C7A28834D8DA438B00A76B2F24E1375729
      6291C36C7B83A5C7620B04AF799A23E18922A7B68C44EC9E305058F94223DC25
      1C687197EA873A295E616EE61D79AD92A1A4D92A27200451CA6FA28E1E36302F
      395A8C3ACB0332EF37A950A9A9FEDCEECBF589864648667A943035ABE4DE6ECF
      324B628E0D8B2C41EA2180310FD9552146B4F4144EDC6407D0DD867FB99B73C2
      ADD04DDC93DF6A0EBF8A5DF8CBA7DFE444A284469E969B83F1748D34E06E369B
      3581A17A2F0E2664B4A13282064CB302516DA13B8AE933530E35A964584C8694
      3BCC0163439DF5D1487AA1CD30C69BF98C01F7971635455375365263B18E1707
      507BAE062CD6164658BB8014BE88E48ABE3F745E890D20922AAF9CBD5F9BDE66
      49CEC541E5D8353CD422719D8503E7381AEBA338D885D5CF991274223A1B27D3
      DBADE8AA81D2C31558982AF603B94DDBF0CADC16AED267FD8E63023A7B7278C6
      7BE93A510B28E74B4AEFF62B111C3A38BB04D136388E25345419676EF1E4A187
      92D16C64D6159BE5520D4D568FA9BA305FCD614C986E48F55F6C4D8CA26F91A9
      91DA8693968593968B8547144EDA797266B9E319735568B8CAE2DB27E2D7DDC3
      43EBF78865B279D163746111D329FA41F271BB34F3E25C0DD336828F60CB8332
      398B7F845C57A71831E14E682682314DA6C3A23076AF0AE9B52FA9287737B14D
      E91C9934533060C82E0097278A6207D3058CA1A046D4C649958B6B3B27F00BF3
      E4777D07FB61FD9A16CB664A174D7099F393E8910D5E997392DCB23485309D16
      04CB970065585A70768E74A464F15F86218B4E942078081D309E5B037E8D88D2
      22EB67EE0D82CCC3C98995CA8E46D196287B36A204A0679411125005A2095216
      44E71247D91BA04FAD0AA53F78915EDBC4D729F563B12FAAEC256EC0AA0D9213
      7484666FBB32A0B2D89E7D8EC55B27B601E96A19406C31C952B6AF5341D5C82F
      B3D9F8CAC9D32F92A250B451B50323FA54BAECDC37AD2FC1C75B637DF5710FAD
      C1382D4B8A698BE8D1640A0D99DE6C2DF779E77B0DB516DD703DE62EAFCF6DBB
      D7F9067C77DA1481DDD70EE3E60E3679CD3A42AED5D81AD1CB8C68F7F11BD150
      132369A6AEC61CC9283B4C0A7E37588CFB4812401755A6801B6D799C85FF648B
      1066DE74C679CB2FF538B91897DFA6541742C16992AE974914E97123ED002616
      9BF805CCD94A62D94C5CE9ED7649BBDB526FFFA0B2B1992672AF50C616C63697
      4236CBFEACE8625CF652A8C9416FB1AD1202FB2090B0AA54BC8795B6AA7875A9
      C1C4B6088B34B8532C1CC642669CE639CBA6C832DFA25FAFED426274F2EEC93C
      557F2AA8BA0C169BF000D727028AB2379032C12D47FE47B90E77175B9B3827A6
      2DA208914E6BB3546C03E8264E000F9C23D4311F4670B93F9F243040EE122691
      32BBBB93DCD387178734EECB74581404C25DC9B1816713395DB81953DFF57D69
      ED0802167D75E554D0982E32269B0C5E046FD4289DF171D5FA838598B3ABEB97
      BEE8A9C981A70DD3B2070D42A1B239276757A415209AF94E8D4C85A46890C033
      A0949FA2864C68C985504CCAAD18AB29C6A88DD2D1900C0C457F734417CFC206
      D4A609D6B6D67B859C5A43B655A24530ADB259FD3D54710C0E9CD93837F9D8F4
      BADCC806687EE95C99EF1767FC3CB28DCE12703DE7E570EEF7D4761AFC5FB51F
      904B9DAC2264B183A29B39975E4C0C22A8DDB06CB1B87CE491257472324C533A
      AF35C02C498902BC9AED4AD69A7E1AB4BBF8BBDDF75CFCE3F6FC3EFEF1BA5D1F
      FFF89D7E0BFF74FC015DD2F5DB7449CF73E992BEEBFB72375D02FEEDF1635A83
      015DD46E0F5A7455DBC575F4AFD7F3F93ABFDBE9FEB1FC8CD9FFF180C7478EF3
      12FF5F7B9DB3C801AB2EC4D38E1DE7A8EEE5C75BD152C40BD8822F76A0DDEDD5
      A6CDB443B6FBE3ABEE8F0DF89EFE5FF772F9537F9B38DB9D328F8528BA8F23E9
      4926800E7B162EAC0CA03BFFE6CC07D0792BF131F957C796DF13ADBDBF122C1C
      33FF83A252E41F7CFDF91AEB63F584EFE0B37FB9094B298C399014B38C32CEC4
      6E62B4C939CB68EB24DC735857B41060D7F17C1BBBB8033C513AD653151C0820
      FFDD13BF4C970D200365AA924D878674C3E49BD7D467B90A67609E03DFFF9D01
      B7794E2B46D5F91B652D9AE794D917575A4F6CFF303A1C3450080676892E36DE
      B8400CCC15988870A6E025454494A0D9704F2053A496A569FD44C3734B420AAC
      D7C0EF34213A9E00874B2E936184A11C384435B835B9E023C8F89EE6C5C714E2
      90197333EE0A82F926D074E7A98937813AE12C2F934EAFF4ADB4C49BE5DB639E
      A5C73CDE633FE6A18E78EF488FFC07B3BEDD7566F3502387A27DC3635AD9F5F3
      9A0EFFF4939D120B8FF939356F46A763D3AF8C30975F142BF5ECDFAD88C44FC5
      5CF1F34F4B7A46346AC2C712143E496FC62F24F66CE7BC62558938CB66BDB589
      566B5F8B641E92A213F1CE30A81CE71ECF93B3869BFECF622909A6E15BB28E7E
      9C3C271675F628AD62DF796E60D885798B2FADAADC17056CF428A72765D9DAD7
      4901413E85BD51285F81833321DAFA81511EF8511495E37D3DCE7536BD678801
      D56DA8B004DD179FC4BE7A798158A542CC06995FF123C7FA8633D72A8FC82DAB
      ED3A7BD14264B93E6C9A4C2DA2163AF74F603DB9F92993BBE4DD4A9275151839
      55C050BC8F0EF39DA10AF430BF2348B672A4EAA85408B55742C0DA384F52F5C9
      E61A28CBD4E6DB61D89C4541E82A92406DCF13DE139F83C895115F12661F6172
      55125E1743BEE3CADEC660D69F6A4352DC4E0C2427A9782996CA8B3A13DB9A39
      4F49FF7345FB766FD6DE9BE2BD51AFDB7496855201CF4DE0C364CAF8FA0C726A
      91000D9AFFEE2F2770387F930EE860207BBEF59C0E0E092F680B9E7DE764D314
      600B9EF22201F7E62828D4DE2F284900365989D9B688284B8798544A5823D32A
      9C9A9E0930EEA5224A31888E941C722B6473D4AA9CE3D3376F6C5AB4727EFEF8
      E684838ACEC7D3571FCBCFE9AA7DDB584D1398B5CA6EE7A228D88F967D2801EB
      2E73B154AB5F8A99694AA6C8E7D0650B088BC85667081CB9A1AAC90BC997BDBD
      185B6EB640FD76456BAF20CF84626174266C4BF787C322FBC3161D516D30819A
      14C3B599F916E6887A374E05376CAF10EA0985734C4BD47DEE91B93081ADD85B
      B930152876A1E0565855427AB6EE7877B448A6125C1D1A7D7AEBEC91BA10F8CA
      22134B40F72DA60409812C65A4CEE31FF6195993445C899B2985A1EB0D6F69AE
      258A5D475FD3E16C288FEFBE1EFF15DE21B7D3CAAB8BB855CEB5C9E4EC152023
      D6DC5E2C9530788E144BB7972C496E34A7B226584E1749D7185B5EF5AE50FB45
      2F417EEC342DB405F7F5FAAB6447DB4BF7FEADD019F6A39B1A7336294BCA427E
      97ED648B170BA02EE3CFC2FFE08ACA30E44E7A5C9A6A463FC9749C7CDA00BF7C
      52D474258BA73B53D80DD24D433366158FE57D4033C69BD8FF214B8750294D0F
      46F10414C3C866539BFC2943DBB7B6AAA02D58036A330F877335E9A5D2AE11A3
      BED5D3B25FAC21F9FA93DA024253E82D7DAC190BB43499C4B7C3D7F571917F96
      3ECA2FE450CB76BD60467BF7FEDC31A0CD6A7C5B36E2141C5036CF460638B13C
      EA328B2ABF2559D9CE76DB8BAF861C31267DB8E013397B02B5865F6FB284320D
      F7B72ED25DEADDA5D26ED91D752E891ADBBC4689A76D19B37A5D0AEFCAEE9CDA
      FBEE5DA5198D9A2EEC3C1217761A5A3245B931C9C55C4E6801E23DB7E78CA55F
      7B205C3AC3485BCBC877ADA8DB260B1AF28C6C45EEDD11CDBDDC746401A75C30
      623E95D124D948D499E963C84521211331AE484283234C9ACA8E646A4BBFCD9D
      0C407F91D82E23E1659A48C3D8DDFFD2B9ED91BACB7A60F75D5A7CB029429209
      661495563528B9A47F8BA5D8521A54C19DD610C3789A7B95E5992738973599DB
      EE0E63DFC23BDDBF6EE5FB4C43980DC3E3625C3086E1A22974C09D2B39805183
      9236C641FB6E23712847799C42311F93986BB97560BA460CCD6853E989924C0B
      6FD8A46518C298552C6F2044E07283E26D0B7415144CD342B37C4E6E6D357BD5
      DD9562CAD79076D7EBDD1D613EE727E3461D1B374ABCFF79270CC33AFE816625
      EE9A7226C3D94532AE2E6051023C9A0DAB8D50B6FA7CB546E29244E318507B47
      9245A7676FB64A7BDE462EB4DF9481E7179D19DEED8515FFEFCEFF7EF5EA9574
      02826E184DE434AF748B46827B13C36D2AEFFAD77FE3DB0E8B766A317C32DB69
      A2C6919DB46FA2BD0053787CD7D3DAB02FD5D6EC7E4CDBF4A396EEE4E53E8512
      D91AD74B8B36296E4EF8C556DF15CC9BE3A9DC35023E791165AB9CDFCD05496A
      FABB95280A9B73ABE4E923DE77B580E9BC4A3093074366216418E553B1C9C0AD
      498BA08D9353251D014452DD5C4C300A95A321B11F85A3B790317598FBBBF5E7
      5E639DC152FA5D731A2CD6976D4462BFF7EF8EDE16494D4D91179F59D35021E9
      AAAA8667AF924F1FC8F0C4061E87BA566DC397CC3C7DFEA5EB38EACCF95DFA8D
      674D42F25B4C5C8A1F682BFCF32CF4379B715502192851E742B380A2D4B7CA61
      8304FDA13F38958794D448BA461B8C7CEE7A383A3D7B9BC45B18E05A49684335
      91C386775CF750A49EA96D83814A68D390A65AEDC35C6A70777F79F6DB7A2ECF
      6F47413A345920F318E0A1AC83387BF5FBB19AD5A3704F06F36E02EE972893C1
      5492E3B7DCC9A76956F61D2D12CDD8E19C4C868936ED4D051C04C32BD1ABD8BD
      1CA95B13A3A4848B34BB482984390FCC42EFA5FA9E0296DB1876F4923065332E
      50E115B7AAC90E9D3D394A32596B2646C823ABB11EE3A9C3A1277288B9A86F9C
      4E6DA7B74A229CFEA438B547BE30D336593934AC84E2632554031C5E41449107
      164D16EB65325978167BB42F602F0C456F4D58E2128295CFD271712E474B7460
      53118507EC5A4A6BF3C5D5E3B43F6CA764CC980F5599485F9F9A59D2FC6A4425
      EDF2537C0146FAA9650D7E9A9A565E44016B7218B41AE745693A250A9B83C9E8
      0E3BD8EE968B70BD9BD4BAD1FCABC7A1BCDF0A32589255FA8DCB2E0055A2E43A
      8966F0762CBB7347B9F9FBE5E2EAEDC522CC3FA04E7C97DE7128BC506E45BC32
      2C77A992D7EE55D07C0CBBECCBEB0DC8AF60F6284E8ABA338F626DF85982B5AB
      B996836BD6E69F61A75A9FE40C5992D812BA827F4D5E2958F8C054C8553BE796
      0B5108226A224CFD076641751BACAFDEDB79226FC22B12627BCAF6E5E4594ED4
      6DC99177152995B3BCE42C3E5F8A98668EAA29C7DA40C9A961862D732BC0CAD5
      213A770BC9C7720A2F073F061585665664D91AC58005C150F7B746C77A6D4A89
      2212C67424D2F08A44E5F758926DCAD90298E93CAD760BF12E7CBADEB0AE50D6
      962097C08A09B5E1FCB4191411D58D09A6170394183BC608A0FF603D3207F64B
      DF48A55935A7736EF5E98BB7D295F74F4E7BBB7F6AD4E5976B3AAE60E4952957
      B9117FDBDD54DD4D85E55EC0EA705092A39E159ADE584D5C9EB71694AD73644E
      265BA17E56E6BE9932B0A23171D5CA1144BB39684089D9929DC25040A639F2DC
      B04DFE9A3DA24DAD2DA4557859E10D7A3E0FEFCE13E8EBADFEAA5F031AC3FB60
      9FC624D5B1115224D56D71B90B8A9D2CA54F1DFF642F98256228679A9D8890FD
      A38C78DA8484E8904009C29CD436E3EA03E7F0F050EA3247944978417DBB2FCA
      7D6FDCF6DD7C4A9FFC528CE9373E98B1B7145032E3D49450D96F0A9F114FBD30
      2818ED16F615CC79932921E56334346B87836B2E60ABE7D5315B01613A67844A
      4A3FEDF3EBA072AE8F3B98AE2114EBDFB8968DA1ACA589A7398FE692B3547A05
      2CAE28050ACA9E4620C6B5CEA665676A3A65CE6FE1AF8E2865742B6AD61FE3A8
      917E938CAF9CE7CEABF73ED5CAD06F5BC152827256C862337C6833BEF2CF4EAD
      C19B8CC3E12CDA80F74D022176AECD19CA39C19AF539A579BFF725DDCABC5C82
      344A9039F3328B91FB0A9B0FA83FF5C142966399B46DB2B1923BF10EF65BC997
      2F38E1FEF604BB1FD4F4729741868C8940468CF9D2165B91A8A99F9C4E22D70E
      233A2071A8AC305E5FA6AA975943D4303095DA01214BA50A6CDE7BA8540614C6
      1BD92F30DB840ACA069536136CC539F95C9B7001A42F4E1B988F68A9292F5D0E
      CA03AB14A65623D004CAE2046E71B8956B358EA7F970C7C688ABE14C31AECA00
      759C7CDA3627AC4ABC21E55D3A26BD87523C9752ACA286472A2A8A26EF10BC48
      2FB6F56D60EE8B8DB23D5E8F25852C54A64D59AE8B1C75937D4BED5F6FAAB936
      B3310DE462CCE907AFCFDF72009AE3889969FE59F99E6A50677061C61B48AD23
      393F4C4248471A4C928F4AA3ADC8E5A9A10964AFCB047283670EA21B269A8B00
      2EA3EE8193A7265A4B4543B6DDDD9D10C98D4D4237F19DC518AF81915E823080
      C960D528A39D81D14B100153A9540CD54494835BEABE6A0236ADB2980796295D
      C5C5CF985512F1DC6A7064FDD8F2CE937B97A590AC42ED5D507396517BD8DD25
      8435B4604C3DBA3C777E7A7B74E27CC8C81A9DF289562CD4DB3D9B66B370BA4B
      7EC3EE110342E22BFB211FBE49F6D348D3963289511444962EC0B59E734058FC
      34F42C48A619552EC9061544392D89653588C9829CCEC53628787A3DB596CE9C
      E540903544937DE72CCC9289110E150255C30B3FBE76F602683442BAE1930AC2
      E4CFD4C5D3F1538276D986B5D72FDD8F6C9891259366AF4F189971A82E44BA29
      2E1CC0C6E4F4F4AD36ABE88EF3D3B3CEF33358EBC6A07EFEEA7DAFEB9C9EBC3E
      B75C5DA928201D5342E61CD82291A2A9CD244BD2CC64FF8793F7D73512A1A9FC
      6203E3B1380295637C5B8B25DA9587477276CCA66B06B3D9226A067A41A52973
      F3A1F3928A4EA7F36E831C0917CC24810BEA7A215A521A6E8BB434B10C0EAD67
      25292470C9BDA8768B32131B23B457D54F333D2ADD18478FE11431C4A98254B1
      83A42CF79B3A47CEB779B194E0A17231991E85736349B948480E3D70F2683920
      E95C2886FA2225E52E6E29226EC638E5B0056103D204E6721538DE811DBB1577
      F54E2124652234256070109F33C929771A5CB9957355DC72F1144BBB4CEA2B24
      30BF9C8E3552CAF33BC991C9AA09255F32630FBBF01F7FC7C4BF729E60992F25
      493695B2F73D52247240421946FBD5A042B9E5E7CAE8CB8CFFF5BCBC9508EB55
      84988E54784720497BB4161FDF93018A1523A424099A9581FC3D024D3A708E8E
      BFFF2801FB03E7CDD13B5CF6E1BB8FE6E277473FBDA5DBF989D7892A8CD59441
      19F7F64D2867EDE024D49E8B25BCBF954C150B4C487A60E1AA96F811F3EB4984
      C466F38B75ADC4244D7939DD4461C90DFC7553406C8DA5A28A581A9571A1AD24
      A173EB42AA924BD9CFFA93F3E9C0B9DD08E87CAE48A64410CCB5CAE8A494E221
      957270993C55EC26926354AD955FCF7762CD488C51040D1D2859808B7DE6720E
      3CCA39D3FC6B4DBC204E67E3C8C447A50DD558B3214806CC0681EDD253E4C4AD
      C5655EBAF96C55A0DD84F35E637D583050959E2F4E285EE1ECF1B934A485015F
      E493A6E1ADB567E7DB8262F5E9F56B5FF366FFA034FF562CE85C62EA22FC4165
      6D8856157025BA8E1E4554A81F1D93FE5DC6A9BE4FF6498967C9D75CAD9598F7
      1D702137C73EB0BBB06E898D5E9B400E33198699E9227444F73D2C2A2E05D449
      8D035A66A332622EA90B1C6BA8B24941F9AFDE898455C4B73054461A8ED6B6A0
      BC46D4C4B6FA3451B842F4818DCBDD22A9C576636EB577E94D8B7CB957B08CB5
      16F96DDA81723D6B85DC06E0B2902A1297880EAA2A974359C517FCD86A7B320A
      6E65826065E11BCBF24FD314853A958C394158D49638DE7CACC6A24A64104B14
      39C1A8CAEC6076615CA7B928C1A4068DEAA41C9B9973BCA114C12551A344721E
      46B6BD4BF99515BE727251B95BEC06566945469905BBA1F8871093EEAFD09994
      12A714DD987363C69937AD4F0FCA3C756B319434E40B6D6233D38D6E206381BE
      A1CE2C99408519A3A1BAA76A5051AD0FA4DD6EA3C4359C247BF4533639A61382
      258D7F6165539A93CDC4CFF9A06146A7A626EAB8158355AB7E19090BF9B4C7C6
      351D91C1E21D2639C107CD1FC219D90842636B7376240571EF125DCC3413BBA9
      763925292B45186301C5ABD67D501666511352E7D891641B37279A4BCAAC97B9
      528026517283015952B9F80D5961EA0AC0503917326DC512A7D97CC73AA10C56
      954F348D01E612276CC547D9B392136BF104AA4E5274CDA1B3F752EAFAE91235
      078B5CA97F2B292546ACE8268308300F23758351CCEA2880FA855C3B4FA43583
      649DCC9FB3827D92501B33F74273F24791CEA396EE6AFA46DCB852D9565535CF
      906831929321F23148579A2A22567069553595B726A50259284B3C5895705CD5
      D666516CFE3367D1C4752AEFE4EDF04629F79CEC08E22AD17452F0463DB72AA9
      3976BC3512A2B7DAA316AE0B9920BB968C9792B8BD2C136C5BC5BBB4A0C612B0
      CC00AB4D495B3D76C9B0B37A6C11E5EC23268ABA4BE8509109BC3E22B9F364CA
      DD1928CA9C17CFE264E04BCA8E33F25F24E062E5FB5C859C05C637C7A5309E25
      BA513AE69CC9B0DD5FEBC347EF4FBEC3C21A7B7BBB752C5D7E5219771710C22C
      4B2E33941B91B542C7E4E32BCAFED2793AFE5F5BB65B47DEB34B4E7348C57298
      A489F10423ECEC111D59712938ECB634DB5AFD9576055C8C9197864DA06B5443
      F0C18211D974E210738D7696CD26649F2CAC82C9EFDB2BEC4D8A02BF53EFE6AC
      2E6583F3A43D92F18C374444CD632425A15A86527931F706B9A90F13BE74BE32
      9D227D9058C449434A9CB35549F34C448931E6D712317DC346AC941B7735A6F7
      C635B4DC5DB6BECBD4962C29982D2188B2976460E79192FC0E2E7E13C4DC5871
      E287E46D40CF9AFB6948420A6BE01A6D09774F7C94E462CC300AAA00182B521F
      29A1473265E0F34DB9EB2B55E6D13541965E89293E368ECBA1F35FE94C94F015
      9FA404E401725EC9CD56C3AE3F0F49330602E0C2E6B79C71E93C2FDBD7984F68
      4F7EFC714C0C228D778E8609E7D039FFF9E3D9F9F6F876EE586D21E777A18884
      4859227070262B6D8B59503DD963896149FDE6ECDCF937E763E1BB09EDAF73FA
      EAF80C5F11EE8C16EBB9FADD1BFAEE4D6A3228F89BFD1587CAF94D2DFB18C6B6
      05116183B79886699A5D3978AEF293E4B9CE7394BD6345BF0AFACC30DCB64D5A
      6D6FF46832816495F462AE9CB428E0959284ED5EAD14AB557AEF2EA4BD979DE3
      E504D52273A7D237300DD24FE684A4DAC0972D816132AAD1DBC4A1D3E1A4AC55
      30AFB10F6729305EDDEADDE1ED02FD68848C85072564D0C3A2E575BDE3F0B923
      9C223224033AB0A71A3665C28CF30E4AD3C10A047A955F1578520B6528642EA9
      EBA2B79AB377668D8328C943B0A7AE8199649F5956B3D4B7E0CC71DDB444FEA7
      38DE30CD4D61DD1F3CEFEA8C05EB3D9D2E64C299B7562767D60CA3B4A16CB299
      72461938B0998C029C65EEE672C8A44EB583A4DF50360BB1DDD31C03D1E16C93
      94161E9C0C869246640045FD354524E7CEC472221F1DB0CD0C08BFCD37623FD6
      18868B1D09E8315B75B0DE8B65E2B3F5DC40F9FFC7636C8226A18653A6292D45
      502B5FC76F939CF6D59ED29450FDC2797D13D00F7FC67E964BE83712B22FE830
      0A57E29BB3349BCA97F90BE7659A0EC97FF937E73C9BAD1D83DEFFF39746F7AC
      835140F69F41C21F1B530C4E5E60863EB1E89F4BBA59F30FB36CCC1DB2CB6316
      0BC405D3AD686FC1FD3A4CAAD53780505DB2BCF992652D16EEFC8CD733FFF22B
      5207A406639404030BC86DC9480580668C7CD6C91338A4163296E68CDB28A167
      4ED1E0DEA16BDF495851DCC3C4A9B0EF5C7FD442C47EED2CB172E55E6AD82502
      25BBA70CD6162F9EF9F9DBEC9E3F02037903A29C8EA3CF2709E6F925F3EB16F0
      53C95E21A3C99CDCD259AD4DE597D6074E300B02C233E73ACD4B2E5ED2C6A0A6
      675DCE2E349D874EB444F93849862E7F2ED60DE7FE72E535444C96ADCF86B9DD
      08E5B23A9D617245E65092D7E8E659AAC7E9A741BB8BBFDB7DCFC53F6ECFEFE3
      1FAFDBF5F18FDFE9B7F04FC71FD0255DBF4D97F43C972EE9BBBE2F77D325D0C1
      3D7E4C6B30A08BDAED418BAE6ABBB88EFEF57A3E5FE7773BDD3F562763F67F3C
      975FAB6C7199565DEA546A6779031CDB4ECE7FAEFB8880C44BFDF73D7F0EA7BA
      FEE555E1550E75BFF6E81C6A3659FF621A9F24FA8379CDFB6E0B2F139BB21C43
      FD87C60967116E328A523C3D6CD27A1CD5BEBA72EDD6A0ADA8085837DC36E494
      A2F1C7973ABC7A9386575FDFB0A9AF2A591FFD01CAF22E257E1C0FBF092D60E4
      2D68C928C9391BC0B478096974A4D724EECB69580BE510452A599909669A089A
      0851CE501E793ABCE627D3E1136546DD245CDC2B3812B6B58DCD96A33E552586
      D1A49236FA2DCA037E4EB361743651E1FACD7FE03CA554A75F3EFCF6F480BC2D
      BDFF2D4C9FF45B13AAA043FBA0B39E1298FD1FB5D917D89B7491E2CAC04CB3CB
      584920DF5F593F7643D3CA695AA6BE8972227F2E3EFC66BC69CC6B2A62FD890E
      A1BF952CBD533BF39526FE4E112AC0B7993A44A714C9DD10580138E44AC0C086
      EA2227F873425AE7E6A0126EE5E2089310BB1E2E47122FF5D4B619F84681C5D6
      97092CFAFD455967438B704038B478A5B94199D7FD020BF3B34489C7921E2F15
      DEDEA17BE8FE87A1E2DF7FA578069D5530397F9D0CA1A40C4D9D452E5AE09FDA
      1CCCC3C1D8E607C9638F3DE7D7A741EFD7A90AFEB16445E3E499D72542F7DC0D
      961673FB6BC8F302DDE1B8E1DE1A8B3DA4BDB06C8DE9FEAF73285663A389E91E
      39D7A6A52B45A2D2E8F5384E4F66A389F3E9ECD4803016FEF4635AE27AE56D45
      2786E3F393A3B230AAC1F321985BC94BE7D95818B957EFBD03E7D5BB9FA450A9
      B2764D9CAAC9688470396C3571FC9FBAFE1C7862A3062F69DA702ED8B8E39EED
      9CC7CC317E9A99C9446DE2DCCA73B2064F82BA19DB5AEF2F307E7743EBD15D36
      2CD749D72ADEB6EF3F5CF3F2CD75556F32BC5E717ACB8F79341A18BE5DA53C07
      8E9169721FDAF0E69750BC5F747D6B605341FD9C9E7DB0EAC716B6E9F0726C91
      85C577E463FFD3B3378FD1B8D8DA8F6B17FA9757EFFDDF9CEFA8612D6500BF7E
      F7EABD942E3EC2E55C3B194637AD94FC51D72B25D5F499962C4AE7F8980F6C9B
      383D1A7A01D75503EA4B2CCDC7267BB6BA6513DD4247FDB4F0560E0B54815871
      432A973B79737CE0BCE7625A48E1EA37A7676F1F21976F65F27A99CC88AE2C98
      AD73FFE1F4E30F8F7031EBA817EF39FCD9DF040A4B44521327723ACEE9704AD9
      C838973531205E3AB2A9C00C84D8E4D88414BE42806494BA7C432890306C2FA4
      3682C2136914990AA346CE6FE7C98939C08B6EC76A948430D16704BC8399EB61
      64AB33A518AC486051CE4867841330A1EEA087CECF8459405D95A6CF1253C2AC
      86521636F7B024767ED7596ABAFC71A74C95E774BC9E8A413D94D33B4E8CA11C
      B2A20CC520E298D756DA085B781FCA1F26B80C1DD589C4E70915A1D0D304260A
      06BB2D43555C73C7C3A61E6AF0626299BDBD9A52D5D2B17E8CD6FDDAA9BF3C3B
      22F4BAEBD661A789C3A700C13738897F96E3966F72625466B1320B4E941CAE13
      0461722D19318C421D246306178C08F403CEA869ED6771B318B910ECAD381353
      6E3E744EE8834B4515D5ECE9E0BE703664E52A35506F4F3A92E876FE2AA5FE20
      C324C8AA3995DBD3A5FAA74BEBCFF0168E9FDADBE3A765A66AE7B19BAA3B4F7E
      393B3B155BF5981526DCEEE3E12CB0CD709C3DF24A8CF7B27F405604811F5560
      A7C9AEB0DE0D78E2ABA709FCCB611886DF220D85A4D623E4FA3AEE09F79BF8CD
      D9952E5453EED1261D89F35D7BEC23450A8D9C60E1B498A91C4D8794D33569AC
      612F513EFC55011969E23CCEAE6EB31AB59AB0257EFA28ED50A8B5D16CEAD3EF
      4622BD20082E257D05C9D1FEE92369A143FD8993EF40A3F28303FAC414D40954
      D93318CD9DEB8C3E7F16A73E7E2A8C964632C6CE93A2E3EB0B7258FACF227877
      70412EF52715E930212C7293ED681AA651697C965E27D2CCD1D97D4911D68F92
      E458B45BB1C98DBBE20C99EE8CE641B66290D327F9290436B13EBADB4C028FA0
      E293B21619242BCE54A4652DF1699E8C9221864F05C407168F74988457A6BEDE
      D4DE2B2E172FFA4F73BAC7B848F66E1861763F6A4AE2B20891D4A46C71DEB62B
      1C7FCE107C13352ED0D64752F957F1B7D5B891B4D83D4E4713066031A788CB49
      51004A44CECB5B69C37E59AFC3714E8D8F8A6E91957EA226AD467AFDDC4E1AA9
      14769E5079B2B42FF96FD825FB6FD5E4ADCAE0D7E487D34F52CB5C7EF99F339D
      4FCF3155F9124CC31D4DC653412E65704EC1CC31C8452CF74318E1700DB9BE5F
      BAE112E351169D5CD544BA25B60BFBDDDE804D9CCEB5415823A06B0B7F1DB1E4
      1C25BFABC64E6B5CA489D4D80832E7321A7DF4E135874D38019719F9AF39B579
      1F2731D4CC8802BC891AE2C7611A4914651BEDF8EC5CDA6D28635928A3FBD843
      19BFB04B2B1E867326A8C56CD09295657C8702A6E531AD6DDD999D9D36DCFB33
      5EACB8748E5F2E4AF3A6728FEE15046F8621B4F5654D9CE14A755C8336FF33F4
      F556977EB62E6D1F7A5B6DBA4C9BF6B6DA74AB853E7B2AB369FCAC5F9CD4D041
      CC3453E37CA8A69C24217049C6037E164E5EC8F5613A1A719750CEB5B4E1CF66
      2EE6EED994222CD3B476F0A989B35CEFE96F75D467E8A8ADC7B75447F51FBB8E
      DA79F23FDF0CE75CD2E220B32AEA2F86E90DC588469A72621A39B7E29CF61527
      2E16F8C8B26C9C4444A1619A2508D0E499CA2AD2DF6625D5759A44B9732107F0
      0C0692693859344F5ADD1AA702D18C70E7E8F4DE9CCB653A36877CF901FB6D90
      72C68233F98BD087238A27327E29CC026E3F4B1174820D2288785199143EDF2A
      96CF572CDBACA8A58A65F0D8154B29988E189AFAC3CBD323A3621EE182FEB31D
      14FDF4F6E88442522C27F56832BD6540C2DB464EE693D107341FABEB5E9E1D15
      49B34D9E13F8CEB0DD28BDB658B5D0E1D4C284F27DB987DE10765A1EAA8926D5
      D7C4D9424E589D4E094BEF3DF96DAB3F3F5F7FB6B6FA7389FEF496AFF123D29F
      0222DBF8A37B29A71A417A65B7CE50ABAB06CFA202174E35E29CAA7DF2FAE84D
      7367C47DCA6C924F96CEB8B57013A7532373F25A71D6D8DB34E2DAFEDC89B5A2
      94BB264E37CAD4C5FF17C1E3647D69DA914AE54E91D666F2DC76E7021E0956F8
      3A896654304438744D9C7C9C527D20D72F315037C7E9B115DF373737BD3C306D
      7CFDECCE937232DC6AC1248FD39917255D989314B9E0C5EE54E7D3C389223635
      B19422684509EA0CC949898BFE7F73F6224CC3FF86B1B86FBA45E1D14DA49158
      672ACFD330E112545B754AA4F906E58EFF724829FD5885AF5EF178F0CDA6EBFF
      134D374EBD6F31DB6F85A38D098FAFBFC984217EF4386FAAE8E68244D847CEFB
      EC428D93DFA9954EFB8003DDEE3E05B8B913564285F28CAF6F8A86C3B446A07D
      D971F9D7AF737C364ACD345EFCABF981B4CCBF7FF9D2C726AE7FCCED74BE49BD
      FDDF66497845AD77A929DD3009A7DF60F31A038451F8B9A8A6896B38FE468009
      EF5F7C5BB404AE079326D9E96C3AA10601E9D0965693FD68E28BF6B0907A028F
      66E1A5617AA9CA86FC56A30964DC57174CBB20E0E1E1AFBF42FA16C2F7D75F61
      2FE7BFFE6A0B8C23E7047CA8C6534C657709A4FAE7F7906A1CB797874CE2FCD5
      E01978BE974964C23804E02FF8172A9CA616B5A69994202A9CA4E3A7533E1418
      6257D061764ED33CFF787A6A52D8C03BC5B9B63DA676343552D505408F13662A
      BF6C6632DB9D2C81039AE99DBCB667FF6EF0E2F04351C0DFD0C31333E59FB59A
      A4E3E747D928CD9E1F8D46B3B149349DD099587EA9F5B4999C2DD37BF9FEE4FC
      39FE72D9ABA8B1D1CB3EDF7CD85940C30B4403C78FA83D0399A4DCAC8DE4BFB5
      3E1CEE46336B2C788390ECB53DB33E79FFF2FF3897A0DBB0A1568D9990A9B0BF
      043F9366A700A613E989A6A28AB13D99AF94F06E0F0E1F7C70D83AF4B6299D4B
      4F0E9723A63EA293C39D27499ECFB4D31DBCA8F4BA65B43B63F62C80F471D177
      4CC7066C1248269BA3D6638CD063E87905681F810D5BC0EF462A1BA15CDB07E9
      4C42600263EA9334BC97E6B6D20FDCC8A0F7041A0DCD316AE46C2DA7B4BB2E21
      C2186405274BA7E221A9F1C590B46436524373082DC178E34CD1F10BB3D4B840
      57209765BF89B4B84CA757FA36AF629394002306A564EF1B78D6A7B453BF7E30
      E419DB4249363AA074D889FA2681DC3F7D832010AF396182FE11B1FA67DF6C42
      E374AC6BCE6883F9ECAC6FEFF92F5F7FCAC918B268DA5029348C9CB3CB249E1A
      70DC7CAA24E9440C330A735D2513F24FA62955A659D184EBE0C1EEC53542F1F0
      73E0E767906FD359682031E4E9B065736AD809954EB55E8212ACF3AB29251AC0
      8B6C2449779EDC212A07028878EF7FB857DE33DC33612D25846F0DBA4F8C0145
      C8C71C432A94A66043139470839B55E94F84EAA3574ECF128A919AD5B54A8636
      F7A2C1B8803274D3D91623BDE5132E6AD16EF2A2B0DEE26A723514B4A10920E7
      CE1E157E04B78E711A1AB93D8EA7D9F04FC704C24D0DB70949CD7947691A347C
      EEE63B4C26418A691C38A779885F535304E3FC44E5A0B2539A38F19D27D54A37
      837A6E373185458D6314CD6012C76A98DBA62A04C32CE8E8B6F5311F1D50BD55
      233780C1F5928C1CCD18487570961830F100BC3F4A9DA7470CCAB7EC493AA3F4
      9EA74D244C3595692E2FAB823095BFA0C0ABB41E61E0479BFAB4C71BEBE7FD83
      4A1B60E76596DEE474AC7E349CFEE995D74881B1F3A458DF4A37E4204DAF462A
      BB320AD2241FBE10F1D23E3CECD8133A555C7AE01015EC7717A913A8F0AA8914
      A9D466C4799D9D332DA0D97FFEF8E684D0444509C17F1EA73707CED374FCB4A2
      579A4893BBD59A7B81C69C4D18FE8060E88BA00147219A1936D87962666AF315
      159DBF1034276C8A311429AC04C50570F9901A56486929A4C264A80934D6E89D
      DB7496159D1093D834B6682241E643F54B54ECDECFE7DF7F3CE0338903EE8873
      C0073475203C276A729BCD72DE3D07CE777A7A7A0DD9C35D0D8A5EB2206D51AB
      F74E5DBFE57A67676F7AA9C657ACD1FF9A8E6FA25EB3994D4A2AF95C6BCF12C5
      70CF3ECD910E7CA57DEE9B9FDE7CE7EC5D0CD3400DF92B7CF0EED039BFD4DCBD
      F0E994408835482748C6C73FD0E9F094DAB598B47153F04CCF9AF24D121692CC
      5CC654C46D9562E7461194C8E95B72FEE5E3772775A2EBF92CB0474DA9F3F1F4
      1598995B068A93D0DCF64E944C4129049CF0974949C1873727AE534E184BFDE1
      E8F80788340E9452267633674AC9122F3F9C9F58A144C689299308D2E896128B
      A69231410047B8F29D336E2A8FF3643F6A7CC0992EC7A76FDEF07666DBE3426A
      61941CFDF0496ADCE4AE0C67FE73D339CE2406F12CC930B356D7FB5767E7B5F2
      070AD5E5ECB1BBF7F42CE1E43063DB3EB5910332DFE2787F7BE6FC05CE9CB768
      0F4BCF9CDDC77EE6ACF389E940655A22532E39844DA0E334835CC947CD4C2733
      E7A35EF705F5CDCDA7F0501DE8C52C1E9AA605B0342F329DE75C5917CA112985
      838629F983131B2A6CF2DC7B2F1CF1600427A2B006A01FA9A5F0945A1E91E393
      3BAFCFDF528D2F878EA1516B98F4737045634D60A9219E306E689E12B512A1BA
      5A4AB0649DD1A71AC58C8DA5FC6F33CA390B32F0909EDE259EC937B848389420
      E144BACF82C8322A7F0EEFE6501F3ABFFCEF0FC9F46C9A4E7E6B2699382C7412
      0C8F3925331DCFF757916C0BEC2A754151581550C6CA90369BBE265A0C6FD946
      65EF2335ED47A58BC3A889E460EFA1684B4145E675429317D2CCFBA68C1D490F
      19B6E022E9F1D9C808C2CE13026F116D423BC6AA925B4ACF0FA704D91F5ECAD1
      E7F4D29C49B1759EDB64FF8EF8BE64C413E46A71039F61191E92107F33E9B322
      2C7DE0FCF89AF3AFB274B810A33ECA7392392335C696CA0EECEF818D47F37E6C
      6840DAC4444447FDE5F8FFFFE8ECE9B14D71FB9DCE6F8B63CCFFD89F7766C97B
      6FFC943FBC7D7DD66064AD227E3AE2985D1AE429172F50B1F8B0626DBC70DEBE
      3F797980BFCF4E0E9C57DF7D77C47F9FD1DFE7670D9EF9CCF4377F737CFECEA9
      7A9D540FA7A38A29F0E3D90F1F8C49DDE49D5A282C5371C7C7AC58F56BEDA861
      A2E87C99E7EEC020202946B2BDC9F3159BB002C8693B5E732CADF13BF7E989AE
      6318938BFBD43454BFD45C905331589E3E73DB7ECFEF7B5DBF7FD8A23F4FC9BE
      0934773F66390736A1D8952964920751AC1A8ED95F8EDFFC5C8A8A06D3D29E22
      ED52D8EAD75FA59FA81310324FBE6BF3AC170F8F969C1B359804D546F3F62847
      B2CB4916701B8DA6CECE2F85BDB1F96B6C9C857334DA060CDCD854F81E430811
      8A1FBEFBF8B16292E1AF6C36297A44AAE9E5454610BF2C357375DDD0B0C0DC94
      97E881B7DF9DBE62EE267B54C4DB5FDEBC3F6EBE442B26BDFBE37896E35F9BF7
      F097B3D3935DC8F0ACA9919EB2F2582628290CF3CBFAEEC3F1FF3DE0AD5BC7A7
      9B3B253FDC9E267C81D3842DF6E5D2D304EFB19F26EC3C3198D199BE7EFE0EAB
      F65673DB658ADF98C492D918BBE5D0F91156908AC912848DC8A622B3412A0D72
      4DED039D6C2AAA6ACB92CAD67A4C3CB19622679AC08C990099FEDB2CC9085453
      CAD1187328E21A66C8D3A891D393E5565830CAE359D15D875794BA28C5B70574
      C153F28B1329C9AB71DCC067E0C4384D2412C7E88E2A7C4D89CA10785AF24E25
      13BB9133DBFD3FB3D1841B10A585F12786CFD3DC565A4ED2C96CC2E00D8D9CE2
      E998E2F1CF4D5C9EEB7261CF4A5DA9299E68E4BCDEA417B2FB280BE25A673759
      82A18F29A1C47BFBB29153DA79F2CBA713302435389BAA2155C568DB7B3EA360
      32A509513CE2324B671797D048F4C1077B108CFD79A92894C56543F9548D2687
      CEEBA933E29047A0A9F82A9E0DE9BA299D053AD8B582C5C23664534966503AF0
      D1556E95710509548ACAA9CD0005F4CAFE9087CE0713CBC07FC73F70C5099F89
      F2695E2389B12C0BE96E3A6C0D9A1619B3722ACAB8D3E76FA57A9FCE726E0D00
      EEFED7F4163EC73FF80210556B0D257B2CF6E211B2CEB737FDFDC76EFABF2B45
      83847D1B2902DEADA81BDA4BC6546129A59517B3A122F37D426A83BEDE6FEC5C
      ABE7CE7BE76F54000335223FFCC0393FA62AB93798CFCBF45333677866F8D1A4
      B6A990F021610070A0CEE246C8113A5719FFE915AB3132CFC51D85D087535343
      7A69DC621426D5D535935C1FCD496E7E3B9EAA4FCE2544CD90C40D39F059511E
      68DC96ADEA2AE8460DFCF2ADDA5AA6B63A8F5D6DFDA4B244FA0527BF1366C2D4
      0009D08106B763386CE699DCFB19033CC901E48A79356F56AF2558DF763B07F8
      AB4B7F0DE8AFBEB3477FDDA8DCD9A5E4422EE7A3A9EF6E4DEC927A6F933CDC8A
      A96562AAFBD8C5D4CE9363C27618A551122754A0CF9897A3899A2641324CE09E
      B34D13A4F8EB440FD7A76F5F26CE5F4ED9A7FFCBA967316573C294CDD35946C0
      0994C6D948212131E9972AD7EF683E4500234F9DD938971090F44C64C3D0E0DE
      51C3F859487D85CC19453327FFF276AA8F6872CE508F2FC00D705C328AD3701A
      4ED77782649A6F0F29BFC021A53BD81E522E93A5BDC72E4B7925B1EB49325C27
      26437D9426233506459C7FEC3CF9FBAF0CB0F96B3C8CC8D9F9FBAFFF423F52D2
      DB571FACF3FD7F7D38FDF8E6F5BB1F9CDDCBE97492BF78FEBC18EB61A4AF1335
      26A4B1436883E7F8F7F9B9CE3B34E867AF31C5FC99DFED0DDC5E7FD0DDBD8B21
      57B75746ABD31BF45DF7EEE889309418C2D4C2ADAD56D40A075AF506F12050A1
      6EB7FB61DF6DB5946AB5FC400D5A41CB6DC91F4FFED16BAE1FF8725DB7DF6AF5
      7CF31F7EEFE17E0F57B9B1FCD78DF01FFD3B303F833A5D8D6BDAF22AFACFC5EF
      5DDCDFEDE0FEAEB9D65C47CFA59FC1A6FC335FEB996746E61DD5EFF17BC73E8B
      C6827F779ED06FFC8681B90A77FA83CA93B45C4D9F7BF81EDBB2E5613A1EAEF1
      5CF373DFFCDE9599F7069D7EBF1DFB5ED08E7AB1DF57B10B1A75A2106BE0F6BA
      868EA059470534D17FFC03EB0C6ECDF2E1A6DC3A1BFE1AC6EE1731353F8B5531
      855F73382922C6E8279220FA53EB573952BCEDB5FABFC6693A353F86E930FF44
      3FE87134BED499E6BBE9164A4223D9C74F13C9150E7FCDE3E938F86B2DE2FC8F
      6F1D637337D31A26684688718499AB6CF974A4C39404E8DE47530475F4F1EDD1
      81F3EEA7B3D794EF7FE21E106CC5FB6686C30C694EAFC166641D52F09791E59C
      0B2AC1A1C3BFD727923846E909C3E477BA42CA9A1A3CDF57AB921D19B5C486F8
      A58354D1CEB289F33565B22DDF79814953D15A4A7060849B02B7800AA3193730
      1F397BF4C3C5659A4FF7F924B9381FD635446133232D1661BADF07754EA42B09
      0781C94F248C5167A2A8F3483A9C8DE03C265342E7842785D9518F52EED54102
      C294333A7BD18C33BB9473A9048025D3B0BF18A32F985DEC13B20DAE4FA88B09
      4570247C233DCC14A56A369A8AEDF60064B4D05A977C60AEA288B611489BE7CE
      5FDE7C7C5354929A369A84852B9971725A4C244A732DD7721755684DD8AFE4B1
      06EB4F28C6C9C5D8A201D9960BAFCFDF369CAE2DD0950FAA2A588E5C5CCB188F
      B9E99D0BB19D44A654393F748E86797AC07EC0EEE2BDBB140421B01011748DA4
      CEFB4AD28B698A46875EC4558C0405FD3DA55A52DE5B92651968282D72991B39
      6123AADC728F1DAB09BCCD02FBDEA47A8F051C95ABF9B93EA986F8AE14FA4709
      8591C862050F9D68734ECC8FE7760CBC27292526A75E9284374A9CB80D406F73
      3CEA454EFA8F3D72B2F3A47AA24E895F6C31154621C7A0A9D35D44949CA81C56
      B1B34BBDC9769D2B7D0BBDDE4C638832252A18B2163FBBB1739953715F351AFC
      C805D4F6247FA5701A3C7EE1744C076219BB1937C970C8F68D4D6DD60EF9749F
      30714EEC82BB47F64FB63EFECA4F4AA6048F74ADB9EF648A89DE1A9893405F26
      E3660A356341BB1DB2A02D08ABA9D8961E7B8C8545852A041FD5C839167E82DB
      663FC1B43D32984569EC7C84DD4B5911D24093618DD91F8581F7B168AB547455
      E088D750DDCA619A942F91F52CFE197F9D8EE1A7BDE3A676FCE4B239D35F8EDF
      7CB47ED73C7DD74EC3406C347C095ACFDB6D8A269484A50D6AEBAAA5C147510C
      263552D55518A6E9D56CE244330EC471695864989611B9084C8AFB7DCCC6991E
      268D55D0D6B3ED81542FA5DFAB49BCFBD1B687252FFEC414A41404CA09AEBFC9
      1326F74D5C5767D720764A587917DC30B4F657537DD4326441A2E8E8A76A69FC
      1C341F6363416CB0CB2A790A87CE99049769E1471006D03F6A686BE2589A90E0
      31A90EC35BBB493487AEA1CEF3466F8556BF8EF67FE1FCC4817A027834641509
      4D0E3BFD767AF696C1170E9D972ABCBAE00063D95D71988C12E3E7737B71FC5B
      601C1A7272DD57230959305FABC7DA5E02FACAF9DB4CE753AB948C12C48C3225
      888E46EEC499BA20200F010180E60BB46DC70EA5743F6F36B734CA52AC0B8A9D
      F269888A6A10BA52CC6CEA7C41308375C77B9BCE8DC6EA7AC4F8F6877039B07B
      7FA484233A4DA3706E2552476EB68E63CADDBCC6B62EF63745C8257E27A0528D
      2470C9946482BE37863A914FD8D2B25D4E8DCFFE933F3A3228535442654F0FCA
      2ABF43E744362A9D581D58664CB8D298F00493DF7554D2D020DC067A3DC8031E
      4920188DA4B2A53105CA7F4A1310ECFC76A24DCF1B18C17442339968F86E87CE
      5BA1582E1B7A6EEB6E8303CE0F63DABA4C956D88604988C05F9EDEF7A84204D6
      17F1B01B7EE423EC3B87476234509EA811E007565458AB028A0E1E46CA70C92F
      D81339A6FA9F58BCCA22F410589C2FE8486A633295D3CDA2591D0F85FAB63533
      3DC20A1698ED754A620511ADB06F4D4EAEA0BF1A30380573EB620C196DFAF7C1
      A67D3A2DE84574E6CB0FED096A94EA9C299D7368E652CF3FD766351BE5CBBF61
      11E48426A5980ED6C3D4436CC5DCB64A60AD7C6B4C03F9769B2CAA5D72736613
      C3FFBB72221EA49F20C0C2CB34932056904EA9F31FF50E81F86AA42052D76942
      F882E2A311A478A86A906A0A7A44A5F508119D3A0C6810E960764171C2AF5A3B
      F43F374FBEBFCD935F264D1E7D6B909D273F93AE9E525E96E9FE679466428720
      5335367D6635BC54AA998610E17678B6DBB0585265C76B52C6F809DFA9A1F34E
      7F9AB1677736D56AC41E6D7E999A662430984E58F9ABFCCA5101B572E261188D
      0E51351B351958F88369FDB627399512FDAB93811BED17EDAEC80C95E3F71134
      B60DE288C54994B278052770A3D371906663E7E4CD718389B64B8072C68E745E
      9FEC2ECB513551D426CEF29C666732890A18ADA549453C63DB1BA189533D3235
      8B243DE4E8ACD2AF1C1F9AF3B97F75FAADD6651327C8278D9ACF67A8EDE23001
      C786E990DDCB7164DBC3DAEC59E8122ED46B7233F69D27BBF35DD60A48382955
      1D87099956E2CB995EC36F8EDE9D482751A60A7E785DB0FD9EB4B49FEF65BF7F
      E8BC1F57FAEB1A60418650148BE3C0B4B24E7E5F6F36D2EA349BE8AF6DBFD4A5
      3D45C812E326DF26CF676BCC7E0163B6B735669719B30D40A63556C48F26DF20
      4AD430E593D7E9EDC4742012E8FAF661FF11AEF1DA19BE911A24FD3CD2A61CA9
      0E48BD339BC67D53DD4491B54C8DF36159DF65CA370E040CE896C5F36824B0B5
      10BE94027A36CD787B807E261B94A05ECD69CB34256429D32EA2895435F8BDD0
      3962943C2F0E4EF2AB6492832E51046BCC3478D8CAD82F2163BB5B19BB4CC63E
      7A08C0124CF4FDC939890FD8226C0847CEDE344B6701654C72FCFF44DD8C2F66
      047AADF3463BF2AF924F35C8621A4B52DFB2A3E35393262F40244132E1DE59EC
      D49AE38DD71C4729C15E32156A67313F487AE199B80CACBDA21473C923A572AF
      4C4790904C83915A8F4CE61FF74EC4A4E8874A823EE3FC71E64E05B70E3EC5A2
      45BC6DFDFCF9E27AED7D876E672BCF97C9F3478F8D57C873F899D4BF93D3BFA8
      1DFBEB0F2767B689A9C8B147B8C07545B8C0459D9C9E9D17F96D476F8EBF77F6
      C823D83DD1820BC5D2840ECBA0C3761BA9B1E6B573A59B66CEA0F699E63EC506
      1C15D7B8B4CD05CF017FBF973647A4BEAC26A2E85DCA781074180FAFC9116C88
      2612A7E405AB5718DA82D3A0C60EF574C3FCEB64FF0989887558D9F08E51D796
      AC42A72612A8E01ED92E01E1DF5718E1ADF47EFBC00EF49E6D090AD2B141EFEF
      738A07E5BA14C98DD4F6625C86EC9D4B9573A7F6B95855A348F40B03C6DBF8C2
      28C939BF88FBC535BDE7DB4A4C90B30FA76F1ADC08F30397A83E0B181FAF0CA2
      E6B7B094472CF1768F261370ADD4BDEE0AAEC51E675238EABA46368D29159D33
      3BA9F53975499DA68D5424BB065F40A8D1C8191C41C2DFFEAEA9098ACC82CE0D
      B24C8FA7586B73C09A7F093C27B7EED4CC90DD6523769D74ADC9DAF6FD87DBAC
      7C735DA335195E0F976742F1631E89ED7A76759B252367620EDA87E9973828FD
      A2ABB91EC6231826D71488FD381B53619BC8A00F594A2912194D8920FDEA2115
      62F25F1FABF0C5F3E73737378763CAF418A551CEC06FA999D573FAE4B9DFEE77
      BD9AD0848F0A98B0E72E0726AC8212F67AE57F0C28A80D6020DD6380030BE042
      DF40032E031EA4FFF0BE6E68A0052D78A181149C0340B4CF890DC4609B800919
      5490C006BD470B2AB896BB36E1288C171CFF4830049B8D20B88D93D4F08DDECA
      293CD55B2A49FECF53278DA99F1A77CF251383FD24727C76DFD331D92EB9E062
      4EBEA4FA724A73789E6985D707044E50785418F28173A6FFC6187507F6988F8F
      E80E1C3D0D0F1B6944BE9A0DA941DB846CEC2BC2A4926077E6D813030EC39C6F
      03B45FE03CCDDFC65F97C9950680FE2FE42C50CD9103571BDB04BB241A92AFCA
      EEB8C9B83D9C7EE2FCDCF507FF84E8211DFD52E7E5FBB3330676E550A005377A
      842CB3C1A11C452BAEA964990B81CAEE7DB433FEF3C7B3F306CFEEF8F4CD1BE7
      46D1511ECB2A02B79B4D38E4186802F62B520E2B7D5F9A38DF32E4C8E1E951CA
      D577437DA1C25BE7E3BBA3B7E65C93A2B37F16901A8B3266BE913EEE14BDC6DF
      6FE9EF9F4F8F3E1C707C1F1AF6F55923D3A10BBAD87E5DCBA75984679914F301
      DAD93857B19608FEE4B6043AB0012A066A25452282A59116C62FAFDE7BBF39EF
      523EA13219A727AF8FDE3884FC30696434162B5F34261521972DB627954EE3EA
      224A87434292C5139D305339D53A51DF6D5394C1451B1CEA3436EBC99BE34692
      84B02C9C5D42FEAA413D0107DB356DB8A98D0E610E19B3DC7425E7239B381D92
      924D6253F042163D19ED8DD48A4596304152C1DCB92D8D07F0CBA7AE6FE2DD8D
      5CFFEFB152CEF1F9C737EC45B031245E8581E1A0AE49B425E2D2DFD8FA145FC0
      A7F0B63EC5329FE2D137BF298C07631048CAB30561A39D2291F3EA8108D67C44
      57E72FB647224BD7BC1947226F480A89B9981F38AF49E21F3867130D43E18BF4
      B8FCBAA72398C58BF9491C38DF6BC511B3297E7EA5C22F55D7F37527F65185FA
      85F3BD4A32CCE2F4565716A961333996CE7A3A6BDED03F6A298268DEC8A94CC1
      A1AEDDCD1BFA0FD6794FC72F9CA36C9466F064B59A50A0FB68344A0F68D36FCD
      8E269A1D6C7490E3FA1C0E6C8DB499DF6079525C5367945348B6FC8F271FC505
      1380256AE7EEDC28B674619DE4B9BA10435F2052A1E5D4F55B81D87B841C5337
      D66703BF77DCFCFC706B8A35D814DB79F2F2C3C939F7ABB67520B7E0675BB717
      49D85AA2370C7BC1AD7EE0A48FA7C2E449CC35D15367A8A89006B6B9B3576663
      CBD3D8F7A5077D89F0DD5737EEE0754E13027F14ACEC626A35688BD9D3AD205B
      A43FFDF181F1AF4B1A3ABD7094C1C19CC7112F179F67DECCA9E553E6E685550F
      6EE58B86CEAC08C1155A891101C7571C6A3F49AE31B9699A3DC638FBD6B8A91F
      5381CFA95FFDC5995CA6634D6577376CAFC8C99489BB9BBCE94A214593ED1339
      84A823926717F97CE63853804EA079D7EF099146505943568BA169BB45D29B2E
      FDB35C372C30CF8D0464E8FFE94CEC40087D2A6E8CE14010584813095BF0D231
      1380A45E367DA6C7D245918191A94F057EA09E0867A7FF2967187B54304A68D1
      72B4511CEB48971245B517A16E2645CA1A3411A15285C029F84DED05209522C7
      3598E1FB235B5EC1BBC2169508CAE1A51A0E35A12719040B3AE73DA110D85BF0
      FF2D1DE935983A27B673289FD99A33DC03910D4ABACF1AC0DE39B1C2E536E6E4
      BB91B37F9772391EF71A90A9EDD2DEBE2263E886F06BE937E9F880F9EE36728E
      B65113D7C461C852C04D582116342A19334239158945650BC5464D72E789A91D
      7A950C49F593263B36C7EE5274428D82A65A5089E5684D563D961B72382D84CA
      225C40CB3EC9A857ECFB1FA89A6E2A5432D70A9D0E18D758D0030496D1601F73
      23E34FC9D482245F646A7420608D775E66A22BF42E9D35B5EBD0ABF5A0FE3CED
      0A46990D1C3559789C0942B98987B1733117797BCEE57CC46AFF77985E70BAE0
      6C927263B466B6BADD792226E82819939B3F33F990BC99600E3D2544C5716473
      3B24ADC3026C64654244C1FD1C6C916EC145C36A0128A567D336E24733B609D7
      F5E10A7E033F8F5E73E04C66534E1B193BD31AE32F334FB2349DDACC13F11C6C
      5A0AD64787B329BF90CD3DBC7FCF96071DE2CB03070BFB93FCA4A7E116B8F88B
      E438B8DB1C8765FEF8A36F536B6AFFCEA48EB391728DBAB4968D6D24610B92AB
      8953916A61D87701C3D133B82DC188109B4C091294FA2FA459331B4C7ED4233D
      0A20B027696E1A68421950344F53BE2909F091E2CE4F8DB56345C116AAD57653
      63DBFDEC3289A77F3A0986C7C324BC6AE4F47E391A0E7F737ECE6EB5F352E597
      CEC5659A93196841CCF7EED4A6BA2CBE5A8B2A2AF66B8FDD8EC95B3A26CFF997
      439D4F0E79240FAC8C7DB8F0DCA7FD69DC0609267187CDE6F2EF2F476FDEFCE6
      BC7A7376CEF8340E0D5D727AE7CF4D1A3CB9D393D7278EE23E717909385D9C71
      3572664520B45AF0C8D287D2420C830E2BDF95B8A7CAB02C35DBB3CA675A029B
      36921C8618CF862FEC89AF4348ACA46DC8FA76724C37BC1444F5949B980842F6
      1C49A4B74213A75F851F620F37C9F342489B2837C73F2B9570CFA95C8EABE5D8
      D13569FE9ADA26C4E6BAB5EFCD595C349264124695FCA9B769F403BC9AD76FDF
      9FD870B26D2341A18F6B95319A64D986B6C133FEF0E6C49D87372B257D05986A
      026B14BBA8B1137DCEE54DD216538EC6ABCDD3B8EF7D4CAD70E3E45333E768E3
      1BF69431BDA14CD2CB646239580A61B1945411D9F4399E8DD39B5BE7462B86D0
      AED673259FAAB90247D9F47294A6D936C4F325423CEDC136C4B32CC43378EC21
      9E9D274959D5B6981B49FB4422267C1CCAA7A104346DD2C0B61BE70B6C9C2D46
      FBB28DD369400BDC57D49D7D367DF7136F09AA6C1DA9EC0A1B89F20B2CE47812
      3BD16C0237929370A4621A7BEA9AFA6553F3292E1E7B841CB076FE31DB125C11
      2DF1AC619A5E71ADE8D4211848D36EBDC98DC476A9BA9F24A340E9E4BB45AF93
      CB74368C2AE6B034FEE6C5D653950C9DEB84363A8768C9D3E67CACA2366C2B30
      3F47606E41D0970ACC06F4D48DB873851352889B2AE695ED4F67BA51DAEA13DE
      3C3797743E7B990E394CC185E97F9D8D2606FC4B4D1B0C966B44670D8A95D295
      45105162A2B32B2B5B295D8DE8713AA6B3F70F69326E2466F8CE13F1BECFD8FB
      16A8498AA6C8A77F329F7FA0899FCAC4CF69E294C84560D7CAE16E1D11FC5A89
      55520B559BFD6E5198F881C464056405A78036915C94B237B78D288937837D7E
      5BC5E3D0ACA06E9C74A2C990A7801D877C1D7581B93571DEB26D6AC41A779E3C
      63087E3B63EC10E9673FBC75428AE73039C294BA2C4E2DC3510098EDB284D40E
      918452A32F28A5478554BC7F233D7CB57C372684FE213E369D189B69C4ED3C79
      CBBD6CA43C8E69201F7C348D6DC86E911A1213E6A416443F4BB5E00BDBCB4C7F
      026D136ADBA58607D661647285B873DB1BE633AD1EF7B073B84509596AF43CFA
      D6DF1471C5FEC96B54EAE63A9B2EEB0C10E273CA7CB87BA6B0DD519FB1A3DADB
      1DB56C473DFAFEA32F6717B4AB5E38F130559C403321BB97D5B9CA929CB2B96B
      ECB69D27D275694889E0BBF1ECF7DF6F770F9DF3CB24E7EA9F4CE774E84BDB8E
      2A4416DE0592053A930798F752E0837259F5DF666AC89099B015D2D9059B0CB7
      8E4DD2379ECE301951A34FC96B526138CB088A11BF1BDB6ECF7782DBA9DE5F7C
      311F49E587200267C6728A39B5B0A302E650CAB838DF956FCBC54F32C18A4017
      A3E321D7A051B6F60A0976F153B742E90B08A5D67F7C232A2E8F1E6C4C45AF3B
      BFEF2D0D4134A6611DDCF6B551B98F5AF69F891E48BEC2E1E1E1EE57A4DDE750
      EB0B60DBD7010C222F8561D14DBE8AC01880DDC6EA3AB9903C9669A635475B9E
      FDBBB38AAC86AA35323897DC2F224AE2A7EC97DB2F21EB2CAC6AA0298A4A42CE
      8676A412933A5D51545D8D6FF9143E4BA24AF7CECB3A475BE1A533A23522E917
      1A10A548C24DE635FB54E9C3BFB19CE62A51477E93FECB1CC567B95B9B12AC45
      A8B221D7F16C68EB88D8B91C81A712B89DE458CD28D7666A2BD160768CB913B4
      B8624651C4B3E92CD307DCF54B0D31D41B35E60C1C35BC51B739F9B5D7441665
      4E126C1F53674F1F5E1C3A52DEF7EABDF741E067A139A08B724A70A02FC6B810
      94AD13881AAAC9849F65D6CF240195F8196642078E2DA01DA92BF21A33539735
      4E6DB42FD332027218890F6C9E5DF5F114D7A157D033C497679B982659A9555D
      CCE90C566DAEA0DC5EF5E4D07A097EF4F1DDEB77DFBDF8EA69A53B4FCA5820AD
      40654329AE3FCA9990B21CB2FD78254C511C57C1100C0A4C00E9C5484EBFD4AA
      6161AE64B771EE847904AFDE2C675E4D72FB299D7171A4A0E8B2CBFC4D77477A
      A2C7915AE489B19666047C1D35CC657940A965BC25F10DF89435A1D97ED4AA47
      B849C4C75438A886F87BBDF68A937C7EDF33019414EC590C47D86510356490DD
      D6DEFA47D8A3074228BB138995F9AC8F689E0C6D07436E60315419C9C528E27A
      4475033371977BDC555605DF9BFA286A123F9BD04FFE772F65436433E9FD371B
      530A8F72BA7E0002DA5783277EE67CE3ADCBF8F9D69977D8724EFFF2E1F4E3EB
      B7A7EFCE8FDE6CFDC765FEE3A3EFAD2E5B8E4D953A2E103B6514E9E5F0732E4D
      BF17F2640E8CBB689A9C8E48088E287A2A2E59C5D4C1DF54A44350B011B49F18
      17900FBBF26BC8C5DB46B0EEB20C50B4996F39251157872455331DCD425BDC3D
      4909CB2A21840AD807DA94CF50F1B3B120768FB9C7221D7F9C7299FF6ED1E0FB
      F08BA0957EF5A0756A4C238EE68F2BB20E820792BB86062D8B93AD1D334AF3A9
      05EA35DD774D3460A4D5B862A6B14CCEB53935C8C9BBBE21A15CCDF9282E8E92
      882A67F98B5BAE6CCDF53076F6A892897860EC94B5A7F9E8C0393E2BE15A3813
      DBF8EEF67827B0F29F14148CB9D75C7F51341DA02F04EC4134905D6703FA24E0
      FDF560034FEB1CE7720402AAECD93895D6192002EDEF9116BB8047C7566B7588
      241D88E6B9361413209A5C0C7E582F20F095D61359647A6EBE3F37032ABD3E2D
      5F7E99D04EACBE9EDF7E3E4701D394590EC29EF1E51FBEFB78223E8A56D9903A
      2619566A64AE0AD53916B3B5ED289288EDBB64F4C52058BFFABC5ECE2E287197
      8FF024CE657270C2CB34096DB142A005CCC5429C8951DCC4F9EE3C390787FE38
      161005560106C0A55C5E2383C44AFE40878F997374FCFD47E7176936D8F67FA3
      BD702A85F51F140BB5D2E83CC39DE6BB33AEAF0471DF4F587170ADA5DC60EC50
      BCE6D0F92E9178A631CC27F24A9B054508495C0D822D18D491BEB45646504507
      7341CAE29856EA0BC44DE015B615FC376936C44D1C604DE232B83AA1BD2BB88E
      996697949883C827B52A028123F5A49C345088543C88CF3A23AB31AD9BD4C84C
      F8DAFCC3729902D805CDB99E8F2C1D298063256928B9FEF0EA40E4FA30B912B4
      855DE9A9E33C7D5DB56CE470F9A9F391B56F69893851DAD87AAAF322A9842722
      D289084BE9A137B953CD7AE2630278E994AF63DC44590C58CF24A4434E2930D0
      63BC31CCA591361FD2FAB07B2ECC1D0EA9464D2231FC62B0B66C8B0ABACDA58A
      84CF19F6A62CD0DC3A83359DC1B517DDF516DDED91FD7207B1014D48BFA318D9
      9945B2D9FBEEEDD9F9BEEC53DAD60CE954A8A93C1D5286B034BE4F053027CD5E
      9F1C70E85AEC90460AB62393176594E2477D21767401A1C7752342067685C593
      55CE2B3A7B949BB782E6B3A34EEED73D137CE4E75AE7D5C0AA39D0E1B2D491FA
      6B9A31EDAC49A186C9F4D61C9C98037B326E03F627E80CDDE4BCE181268D8D78
      7B348221BBD5909FCDB8EDC32DE6D352F5D7805EB902B368CF97E224A3780D9D
      C5949924D06DB055D9A9608BFE112E758DD43C3B4DE5B8E427CE4F91F384D590
      038318D4545107AF26CE9322430594499DA20348C58B34BB7576BF4F22386F14
      4F799B46CE7754BBB66B3B61C28B09B4C1BC64CBA789A4D979C2CD516C5F534C
      D49A6F0EB4C93B3203650B502CF6424F2B1126FA6C2C67A9D8008AA130CAAED2
      4D2446810B3D2101246D5E3FA8E925163E6966FDDE115684330C76676382FD1D
      EFDAA83DB9CE1CDE92843A534A42E7D7C6B6E7761F4D9CF3998D44D449243031
      83BD596E00E299D30FAC953F4D9DFC2A991C509CDE94AE1E388787FBA6EA26AC
      2619717871F7AC0852EC1E14BFBD4BC75A0EB3765FD371CDB41CE46E1349AC22
      CA58A0F9CF249347EA246C71AF2D344AE33809E960CE20E93471AA127D7F51D1
      9521EBC79B2CA5B4088B790C13B64CCCE2BA0FA36FEAA4BD9B78559291E0A1F8
      AD3D3452960FF7380B4CE8BBCF8C640ED68C0720BC685FD83822C340D419A106
      4D6FB4BA2A8F2435E5BD24F9C8A85C499AAAC0928543FAA8383F6BE2D48D028E
      0BF64AEE9C68EEBE9C25C34A281A0A57CE67497C387BD88CB9F3B7191D5D2827
      90A46A7C9618B43248F350E775B2C1D9DE8509B87FE81C7187118ECE16C93B11
      849869E58E995178DB8C27725EDEEE32CF16A58626005BF67D2DCAF24A28A5AC
      BC9F7A4C1549574D868D7A5B0A413A925193C9908EC34DCF284951B2D52C6192
      85B31199D5614323FF8B717D2E68CED21B1B31630FCFC9293B93D36CEBE4AB52
      DD33C519A96893DAF271F2567142769397F5875C3B60E36C8204CBB9A5026237
      D2A3F4D0394B8B644C3270B4CA130E73C04ACDC32C994C7332738334BD6AA4F0
      A073C75B2AA9B8705E3FBDE60ADF8B940F3C54401AE9CFDBCAC3CF8EE26CABA4
      9646711E7D27ADF9230C92C652961B5552D020139A9900F66A5643969A836546
      0A2093F10365067156DC713A8E0CBE15B77F81C68D9830520FDECC284F11A1C9
      9D3DF6484406B28E182AE8DFC7D812AFC63296C770958CBDBB5EA95890FBBCA0
      9252FE5CA07B38B15C3987539DFB54E95234A8E01A93222926A7FD32A16807F1
      0A0776546E925D0A1C5467CFB876163477EDF829A362A27273366850070AACD9
      462EC9076B9B679C94CFEDC3AA65CB447D09AA961436FDA5CAE0EA05ACE91ACA
      59B521D3F3A1DB19E06F326FBEDC69D65D893C4F5843D09E3B180CBCBEED11FC
      8FBFFFFA2FBF5252928ED454399D961FB4BC96DFF65BAD5617FFF52501CB85D6
      D18348B7E2208E63939415B65CFED793DF3B81EF75E3AEEEF9DD0EFDDD893B7E
      6FD06B753B3DAF13B9BAD7EF46DD5085837618F83AF4BC56BB858B7A7E3F0EFB
      9EEEB891AF769E0CC2C0C5CBFB6E470FFA6ED8EBEBB0A7DC5E18B6C2FE60E0FA
      ED6E3888FA81AB7A9D0E06D3F3C3C8EDF8BEABFA6EABDDED866E180D3C2FEE0D
      B41768AFE706513B6EF5824EE80DFA8350F57CA5E2D8F55D17AFD1413BF07B9D
      4875A2D8EBF9713450D1CE934EB73FE8B7DBAADDF7C26E5B755AF1A01FFB810A
      7410BA7DAFD7EFF55B3E1E36501D57757A81EE628E1847E07A515F0F5A3DB71D
      0F5ACA8FDC5879FD961B065EA7D775BBFD561C819C3A8C30F47614B6FB3AC053
      DA5E5F7BE1C0F7A29EEEB4BCA0BBF32468B5A34EDF8BB4D69D780032F8DA1DB4
      028CC18BBDAEAF55E82BDF6BF5FB5EE085AD0108A743D58F073E68D3EE626EF8
      3518B8BDB8E36AE5BB788B6A875167108252F1A03D085ABADFD1DD0E96A5ED75
      543FD26E2B765B413F6CBBA117B4769E10B13B7118776101B4F102DD0D622F18
      E8FE00C30FA26E67D00D8330C27C03B7AF7BA1D7EDE830C430DA71DCF6BBADB8
      E3C5BADFF6222F0C318CA0170BAFC4C43DE097FBF80CAB011AA81E1E2B1FB660
      08B5F987C0705ADC73C16361CF7363F095F9B94F8C1477157116C6DFD371BF13
      442063BB1781DE98591B5C8595885567D0F23D5A9E5E840569BBFD5EDCEDBB6E
      3B88C0111A7FFBF1CE9310CBDA5241003A83DC3A8E7B6AE045B156BA1FC403DD
      1EF89AA8D31D28A55ADDD0D3AE0FC60B836E5FB77B5D2F0273C6E0E041BFA37C
      D5733B2D0C07CCD3EA77F15EBC2320060E3BADA8AD3C9029F2DAED4075FC7ED0
      F55A834EDBC52AC4FD7E34F0E92A5769DFEDFA511B2BDC8A5C0CA813059EDF75
      5DBF17ABDEA0DD6B77E2A807CEEBD3D03468869DE1C59D76171BABE7F53015DD
      8F553F1CC431B806340AC381F6E3B08DFB6337D41D1F8BD2C59619F87ED8C557
      5D8C40B5B1AF62ED75BC20024FF7BB1DA522BFADA356D009C07151378E646DEA
      AC6C37E80D06DD76B76F24465F159284FF4072E00D90121D37969F779E547FA3
      9FFD080FD0F8AF07B9E25AA982C9847ED4C2DABB2455B0A6BD48B57BBD410BD2
      008B11804DFD4E179B3E0C940E821823F3BD41D8567E1BF205141DC4E06BEC40
      EDF53DAF17EA087C8C2D13EC3CC17CF00316326CF55A515F753B1039BADF27A6
      EE41DEA81ED6AD1F29BFDF0EB1506137D478661B1B4C0F7AFD36281EF87D6CB4
      28F607604BAF83B141548007C11951D08922B71575830E4455C76D6BAC451475
      34F6AF0F4681A8C3087A9D9EEE633521BCC165F81213C182B65CAFBF09FD7DDD
      8EFD56D463CEA6AF8236AF40BBBB8AFEF2F3CE93F237AF6D69AE434894B84FBB
      A5DBF6034D8CE4C5AD7E1441B8054157FB785B1084617BD0D5B87E1060A67EE8
      FBDA577DDDC51EE862CD7A5D8832ECCE1E242BE6E4D35671C336FE8D3C5CEE41
      224631F800FB04BB0C2FC71E8E41AE009BA13BE878213663D4C2BD5E67308040
      0F7B510415E042D6B9D87DED0EA4AB8EF18C01645804A9128791DF1FF4541C85
      AD580D7A9DBE8F3507D1C0DD8341CFD5DE005BB8A3B01DDBC1C0EB626531C198
      76634F610BAB2E144E3B043779BEDF19F4FD0171930B698BE144512BF6E2A0DF
      0F7BDD5E1F7AC2EB867DACF78024744B75DB51AFE5E9287021A761C4B45BA1F2
      40277700F2B5FAB11E40DC6030604A576BAF3BE8B5DBB8A20BB2B6C10791DB75
      237CA654D869B7A047212B20B5FCBE4B726B00B1D1A6ED15B82DB02824171605
      DAADA5E831D8E97E085116767B918676EB066D50130A44BB5021BE0F75D8EF61
      3F408B63E05EB71B0DFA5DA8DDBE6E418C793AE8B9D08D7DD5765BBA177BBE8E
      3ADD0E584987DA253DE5BA11547B1F1A328ABBAE82E01D747A610C7905550FB5
      19E375E017129B31C4ED00325163230EA20E8C05A8395010778660752C53D455
      10152AA639B53CBFADC010AAE3B930B10215C6D836835ECFF3142C10F04BDC56
      606930D2001604F698E706B176892261073A2BEE7749650F7C2C79804FA11674
      18F77A5843282E3F806056710FA64B0B1B0BE60266839520F6093B305DB0CBA1
      23A1427AA0EC00160A3E802874FBFD414B9302E9EB4E4F45713FC4FED5DD41AB
      3520F9EE63FD430FB743CE83A940CA7EA7EF423BF5C14E810F65D4058381B5BB
      582F0890B0A7B1F9B109FD01480185EFC2C889BBC44510049D56D8F1B4820668
      F7779EB43D8C24C67282B001B6575F75C8CEA04519E88137802AE8E3F171A707
      8E724171886FE83E48EBBEDBEE4138105B63AFB563500944EA92C00717630C2D
      5A0FB7D58D3B3A06E520C340021D68689E3E56C3EF41F5853B4FBC90D433942F
      947FE4839921BFFAB0D3D4A0ABE20E140AC61E6B6C36A50631D824C61E84688D
      713354900FCB300E35764A0FCC120574CB40F5DB10B46E87F4241E1AC38BEDC7
      6DBC847FF36007E12F282E288B0EF602360FF42E4C516C04AC8CDB8942304184
      0DD2262310946AF57B3EE80E098C314790CCD00BE0739877D09D20820F5D1B86
      30075A50EA1D5CD60D68A2ADB6DF26AB15EC0CD50A99D9825504954C06698461
      C1EE8A21ACC007FD10F650D886A1896743A84080F64308FA6E3FE8C3E208B0DC
      30B2301698777D3036860F85DBEE404B44910FDAC1ECF56112C42E360FA41864
      540BA6F10042A513C60A466017D2872CB8BE86F9D8577850E84231B5618B853E
      E4413F68C12E0DFA90CE3D2818B7A560E5BAB08642179A05D774710F9613AA1E
      A30B3177D551B00EA201440F16DF850DDEC6D042C8D336E45E1F9AB2D31E78A4
      97541FCAA5E7BB7E4442B48F3D0803D6037F8490D59844E40D2013C9CC858470
      FB0AEF8240EDD183FDD085D10205894FB111556B80A5C0AA83E7C15D3D5069E0
      616C3EEC37AF0F5673150951301DE41B0C2D98BF9DA8EF7B0A1B1E5A246A695C
      89394368B99058B040A1EE602A4351C33E68C7E430C070D2B49F99DD69EBC092
      C17FE0778C190A02222F8235D0EAC13A8DFC08E38CFA2E76A63F889526C3C487
      74EA74E01D045095B062C1191E6C44AD489A7521EC60CD4150C37C83193E68B5
      359E17FB1EF60228D456D0CB011609B623A4237E840C86848B218021CB3A6007
      BF835DE9D356836EC09E8934383EECC6A1A7B08C01F85CBB1E44560C7D03EEC0
      B03178ECD228E876020F7B03224F6B6C18B71B616BC5E47910D3C41881D62DFC
      06BB19C259A42F643704B4EE60125087D059F120865D8401F5423CBB0D61E306
      781EF68EAFBA3DAC590B3A6F00739D14028C4288AE56A05BAA07E7C1EBB661BD
      47F07CC037105ED86D786EECB63D6C8056AF0B8984B50B20ADC1C703A819AC2E
      B6AD4757E25288220C144FECC6707FB17514DE065708EB17293DE8428243F70E
      E0D1417CC0F18AE1FC04A4B5213060706103423D826F3B01394D3D9826031793
      83158A9DD26BF9D0DFD04C513080ED03E278D8407E2B24EB099B0932161632D4
      08A4133C19EC78E8250879B0620B6603288FB707E0D8A8039B88581522170206
      5E167993E43AC192E9C1B91CC0926B43E6AB0EE68D790C4823055118C2320F35
      796D307560F074BBADAE6A77C0A2300320B83B6494C226824E860E850050D0ED
      D8EF1D0F267A07FB131B12EC0FAB084386A1D10503FA7EAB0BEBB403BD032F14
      C6763FC2C2C16FC4A71D28268879A872A853EC3568723CC6EB600431BC5818C7
      B8129E5D5FC14AC20C4129100FC387290082A80063A3BB2006BBB0A17A781D18
      12B21E9A402B2C671B4A81BC811E76550831ED77B15975378EFB31F40DDC5CFC
      067D0A8F06D405F5DC81A7608847E437822B601B852C9061EC80CA701321337D
      98AA8AF6A6DBA1DD13F6B191BAB00D3C2C15F48D860B84B5C157BA8B3D05430E
      72A9D38B3C4542128E1D3C9C1EB18D1AE0B17DA811B2AE7BB0C7C18E90B73D38
      EF3DB231B00AE4D142D49006C4EE77E1302B8C095AC36BFB78AE86FDE10E2056
      BB3056A0C0218C61E4607BC3398341D9C75A81C483D8ED85707E7CE8E5767B10
      B540747275A1CE30169AB3EE40CF42A40C3A2108055303E46E852D8C0052C41D
      C01CC532B73BBEE7C393878F8D25C2BAC026EB868A6C34F86411F6396C3D701A
      79E710F9115412D1DD876B073F63E079F00502E83BE582B5E09D404841B807ED
      160C16E8F80E44518475087AD81A14A100C97C786D11592F2D88E5410CCFA803
      69879141A6A876006F157603C9875610BAB0957C378011086D15F57A3097219C
      E1F342E260C90614C2216B25E84140B6C1BED034D0331C19814702FAC3938247
      88C9612D319098264E76225E090502BFB21BF561BBC25BF27135EC1B17460356
      A0EBC3A16D87200F6420AC64D810BD1EE4073EE862ED61DE84F0523BE05FB864
      50FC5817EC72E8574DC3841D0727A4DD1B843CFF28803EA2C0166810918A8BC0
      8910C221A4395C024809702C461AB65BF07782568C89BB831E64B3A7C905242B
      0ADA2DD2D8C0303968AFC1E78571D41D400D8277B0FF60B105BA033711662B05
      1D88DC03626D0DE98D6583EF449B067E4FE4D308C0079860178A012BA662AC05
      0C0A983DB0D2208441FC41A45427D6103D9EC2937BD85FE457838BE0E083E4D0
      0A0A365397288C35EA407004904B3D6C51B8F1F80C42063C0C6EC0FC49C9802D
      C1505D88D91086146C60F88DB06BA061711F4C1EA8258C0034ACEB2DB620B406
      AD018D56BCF4403C4DB777BFB7584667A01BD77AEEF3F11BF6E1C92AC1C6C08E
      767B142E89BB902081228F07FC14F5FBB8085B871C25ED7B700CC941825BDC86
      2F12C14D248FA60FF30AA20CF2400F06306E83410F36E000C6193655A42198B0
      97C10DD046B800B6FD003E06F4541F56276C4038E2D000FD4134F0A00A0290A6
      0F01D0857CD5511B26CC000EAFDBF7C921F3E1FAE06D1ECCF01E369D0B850A13
      1C360AAC723F868D840D050753C19A82A7E3BBAEF214CC78F86E4104E5054704
      BB16B28DC272307761A7828BBB5800E87768913686DF814B41511B900176587F
      D0057F424DC2FFC202C35C852881C948324A51F821C4368331A768A7FB213C96
      0ED8091C0EB347566E6EF5A1DBDD884A6C378FF8DEF7A71A0D8695B6321EBC6E
      0C140DBC2F16B8EC8FD7926BE639B1E4B475EF5C17A75AF6075BC5BD6F575463
      28CB77C2BA51AD8BDE2CFB039D548C0AABB0645CCB223BEB46B24E322C1D09B6
      EF7DF4A9C674EBCB0C1E69A75552A023FF754C542C0C5BCA7EF58F9D2774D811
      A6C334CB433AF2181908307895B17932E434BDA9E741B4827BE153B94417B87F
      2EBC626CE02E71B58F6FE15AD2B71DA87B1F5EA7D7A72BE0EFFB3C62FA3BA427
      80AEB8AA3720AEC7B360D6C3EE5474B200310059DD83FB405E0C6C8A968C017B
      C5C377E4CFC101E8F9F85F0B1656EC5290C23394C19E877314F7784CE6BE6E97
      6848DFF9E65B972405FC2C179FF564CC3C4B18721E76095CC398AEEF0E6887F2
      0C7187276F86598399D39C7C9856F299DF0DE433BECE2DAE738BEBDCE23AFE0C
      CFA631F3799079C6DC27E535CC9DF4997BE7AABB4FF2EE5CE3DDB9C6BF738D7F
      E79ACE9D6B3A77AEE9DEB9A6CBD7F44171A26820EB647FE3EFB012DDD09FBF62
      E1335C075E303C49E7D9E3693EBD1DEAFCD7611EE5D364A43E79BD0EFD324CC3
      2B1D453A6EF1577A945C721983FD643626C010CA78B69FFC4DF209EDAF932C49
      B3647A8BDF0783BF978F942EE24EE58EB653BDBEE594D7B69C778C0FFFE79557
      0FE6AEBED47268DAFEF3CE93F961CB5DE5A0DBAB07B0FC91EE9FBFF003BD2FFD
      40FFCB4FBAF3A5C7D8FDD20FEC7DF949F7BFF41807B51E68EF4AB0C53ED5E6E0
      F9BBEA31E9FC3DF5F870FE1EFF01F7741E34A37A0C337F4FEF01F7D45BF4F97B
      06356764B9C39B678F691A62993FF301F556FC9E07789F3F897ADC70CF03EA89
      997B1ED0FDFC49D4639A7B1E508F83EE79C066624214A3F37A4CB8301B6EAD38
      4DA7E3742A29D01BBD558D719FC13CDEF45E12873ADBE8161A286E7988E030C2
      F7E1B2DCEBCC3D3554DCB97DA3E14FB98C218D9D38B998653ADF70227A7CAD87
      E9A40036DDE8DDC5CD999ECEB2CDC65DF047515DF15026291FB0D9D439FB5ED0
      06367AF5445D3CE83ED8B59F31617B376F89CD265AB0889A4D2F89EF12BDD93A
      8F5498A59B7165AA36DA1DF6BE3749BEE9ECE816E7E56C38D49B890ABEEFDDE6
      CBC8F76D6604F12D7595E0DC4D9B19417C4B3D45B7847A0F9994B9F3417333F7
      3E608AE6CE07CC54D6FB213335773E68A6E6DE07CCD4DCD959ED9CB6E77DD9F3
      643ADC4CB01C0F532AA8DB705E67C9C55811DEFD4616C9FC334E242398D3FD2F
      3235B9745EA5E3CD36F1CB34BA75CE37B5128ABB1E66DAF0CA50DB86643CDB8C
      D673773E840B8B7B37F3A8E6EFADEBC42FBF7BB35DF7D6F409FDBE34CC96B3F1
      027BCD82E9C69C7CA68633B109369CE0899A6EF6A692815E31E48A61A3CF7FC4
      863CF18E2C82EF8D9EDD6CCEE5FB377B6579DF662CB8B8E71EFC5A73FBA682F8
      25FDB0B9A8F8FE9660D392F1D54677BD4A094F5247F3772F657CD79DE7E12995
      EB9BB92DBF615EE09F8E26972A4F3633E84ED270C62D3DDEAAC946377EA07297
      CDA978FA6C449DB64BA5B1D9DA7D7FFEF68D739E4EC8862598BECD56906E7E49
      C5A6A307DD6F9CE0BD9F75B0BFF98B8F60398F6F470F99F0D1033C32BEF138D9
      509CC95D69F480BB4E0A64FD874CF1077D1BA42A8B367FEF077851BC39A6FA01
      779F29AA1FDCFC3EAA50BCC126DC385EC077FFA4B2845CB1873ABAF92CF8AB0E
      37DB79EF52F1A936B9E7BDD4478BDEDF34483C77F366327EEED60DB50B01F8A6
      15C9B4220676CEAE30A124AD985645D0859A3A9AC3FA2E1EBADC7259A4F7D944
      85D6EFB51775E785F61BC61B38BB2C1DE4E2C245D38B2E2C56B0B8CA5D725565
      56C575DE82311625B3917DAF090C17D7FAF75DEBCE5FDB5976ADE197B90BBB2B
      2F5C78626FD98534A5C527F6575EE82ECE7EB0F2526FEE99BDF9D53951D9D55D
      9AF716DC263A6CA79661CB56B1E72EBFF6EE43BDE517F25AD665202899909479
      7B71FEAB78A9BCA11653ADB8FC7EDE5A71D3FD4CB6E2A67BB86D71EEABF6F347
      7D9DE436B6BA3C16EB2F4C3FAF78A6F7D86FF34CF69FB3D428DFE52F995FC6D7
      E3A91EE7BA72579D8DB372BDEFD9432B287BCF665A71C73D7B6AF91DAB36D78A
      ABEFDF65ABA67EDF865BF1A27B76DE8AA9D7D8826E3D61BEE2F2751BF08E80AB
      B705DD876CC1FA027FC51D3518F8CE7C6A30B0BB3103BB1B33B0BB1103BB0F61
      E0C5A9D76160776306763766606F3306F6366360EF610CEC3D8481BD8D19D8DB
      9881EFCCA706037B1B33B0B73103D7336F565C5D8F8117A75E8781BD8D19D8DB
      9881FDCD18D8DF8C81FD8731B0FF1006F63766607F6306BE339F1A0CEC6FCCC0
      FEC60CEC6FC4C0FE43187871EA7518D8DF9881FD8D19B8B31903773663E0CEC3
      18B8F31006EE6CCCC09D8D19F8CE7C6A3070676306EE6CCCC09D8D18B8F31006
      5E9C7A1D06EE6CCCC09D8D19B8BB1903773763E0EEC318B8FB1006EE6ECCC0DD
      8D19F8CE7C6A3070776306EE6ECCC0DD8D18B8FB10065E9C7A1D06EE6ECCC0DD
      7B4277F374A043C7A19E3F5159EEF3CFCFCF7AF1C58DF79CDE7877CF3987D4B1
      A79A12B4FC4677E93BEBDC394FA497697AB5419A40F19479BE7C9904C324E5D8
      C8EDE7A4472FC667DF1F17E799D5CBFCA5C7501CCC9D77D27D77E585F3CE90EF
      ADBC70DEE8F4FD95172E9A107E67E5A5F362D49FDF4ECCAE721D0BBCF96BBBAB
      AE6D2FBBBAB7EAEA85E9F7575DB730FBC1AAEB1627DF5939A70ECB8BB9C776DA
      AB2EEE16BB78FE0677D50DBDE537AC25DBF220CF3DF45B157BBA87942BDEB19A
      A6CB6F5847DA1577D5A0F1AA39D521F78AC9D5A5BBBB29DD6B33F0AA184B0DBA
      BB0FA2BBFB60BABB1B33F9CAC9D5A5BBB729DDBD4DE95E5B82AC8A25D4A5BBF7
      60BA7B0FA6BBF7306EBFA32AD6D3DDDF94EEFEA674F71FC4ED7704FF0674F71F
      4C77FF6174EF6CCAED8B5E550DBA7736A57BE74174EF3C98DB17E7B409DD3B0F
      A37B7753BA7737E5F645EFA106DDBB0FA27BF7C174EF3E98DBEF4C6E9EEEEC11
      D536022B57DFAB432BD7DD2BC22BD7DD2B412AD71913F05EC151B9BC9E1158B9
      A19E1178976CB58CC02AFD56DCB09A902BADC6D534AD6504DE216E2D2370298D
      57DC5983D82B275797EEF71A81CBE85E9B8157DCB09EEA8B86555DBADF6B04DE
      4BF77B8DC07BE9EE3E8CDB17EDAD1A74BFD7085C46F7DA126485495693EA774C
      C70DE87EAF11782FDDEF350257D3DDDF94DBEF588DEBE97EAF11B88CEE9B89F0
      15776D40F53BE6E30674BFD7085C4DF77B8DC06574EF6CCAED77ACC6F574BFD7
      085C49F77B8DC07BE9DE7930B7DF995C5DBADF6B042EA3FBBD46E032BA7737E5
      F645C3AA2EDDEF3502EFA5FBBD46E0BD74DF0C97E02D6ED93C0DFB6CA4B2E903
      AB1CBE57F9E5546D56E0F9E338D3793AA4761F76C0FFE04E0DD4A4219F523794
      569BB18E5A82EFD46AB50D3ED3CE139FE0DE1911C8735DDDF1FC76A7DFE9FB91
      1F760835A9DDF5054BC9EB12AED1D23F5D7952D40AE3765BB7543B68B7956EAF
      4677923F1EE117E391B18E63467B5A854CD55EF877E10BBA3F2E50C7EEFE5E7C
      FE07FE2134CD7FDE3FDBD9FFF3FE5932FBC8FCABBFEE48BEC59FEDDAFFF3FED9
      CEFEFE3F1DD81ADD58FEEBF9627AF8B042BA5A7EEFE183DE609D95F0F03F8C74
      D959ADF75B615745837E7FE0C6ED88C0A9BB1D8CD46F0DBA9EDB69EBCEAAE706
      AD90EC26ADBCAEEEABC86FB557591C8FE5CF4A0A3CF0CFCE932F39BAAFF1E74B
      52A079B3A73F5F8A020F98BDF53DCC9F7FFCE3FF017C85B547}
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
