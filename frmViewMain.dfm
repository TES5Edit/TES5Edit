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
      789CECBD7B77DB46962FFABFD7F277C0D19CBB42754B345FA2A4F464E6D8B29D
      F8B41FB996939CB951D6592051241181001B0025B1B3F2DDEF7E55A100120228
      C97AF4A0676251141E55BBAAF67BFFF61F67713AE99EB99E9A046E38ED767A07
      676E98F8F4CF7831EDF60E7A67CB315F31E99CF1BF499ACC26DE683CEB770F3A
      07FC6B10F1AF43FE75E6E77E1DF9742FBEA3DF39EAEACF13056F3C3A4B676AAE
      CCDFCC6FC5BF8E93CE1F6793284CD351001F3A67F058CF77CE26713477C3B3C9
      78E6C6894AE1FB45FC8FDE1F677F395BB8619428A7D383FF1B76FA9D83CE00FE
      EBC1A7C19F5FFCB94A9C8FEAD2F98CB7FFED4F7864CF3C721E792A2E3EB39B7F
      E6213CE7989E8DCF1CC0334FA265ECAB189FFAB73F9F3F8327F64B06D95B1F24
      90B2031386FF0E61B0F8D0C33F4F57F35114D0D8BAD97C433FB8FE416BFFFBF3
      173F9C7AF05FC2CF1A940CABDB1F6EA65EE1997FFEF8011EF6DEFF09AF9BB841
      EAFC8F1F93DEA7F1F2A5FA53CFBCEC1D1BD707D785D707D7A987B474E7A3D877
      9D0F6E3AA341F70FCD03934B3F49AE7FE08416A5478FD60F0C7C78223D6BD0DF
      6AA54730AAE3FCC3A23089023791C90E06DB8C6D241B86FF83EDF8E7A99A46CA
      F9E91D0FEEE0B6ABF3BFF4F2D0F30278C8EF510C14840379D7A786A6EF8DAC37
      74BFEADE82B7CD7CEB6DBDED36457FF3A670DEFBD3592AB319D9CF2F3BC0B7E0
      32B01E7EA89FBFD529D9623DB237DC7A37D5588FEC6DC33B3AA47A25B2271FDE
      FD4A0C8665ECB97FC44F750AB739276FF8CEB2D1F4704537DFB98A35B7382E5B
      9261B7E4E6EF63A5CEE9CD076527B83BEC95DCFC6519F3ADA547F3F0B0E4D6D6
      0F6A14ABCB5DBEBF577A7F19B95A2F6377E48F7765E60765C7A97B342C79C22B
      D871FE98DF5F2AB686FDB2F7FFECAB3474E14BC573180ECB38BF5EF3AE638971
      BDDEC3C3D2DB64C10BB799C51E1E97DDA9573B7F67B6D2879DF23B7B1BEED4CB
      7CD82DBD4FD6397F5F6E8D0F4B7520BDC8859BF30B7C582A58F50AE76FB756F7
      70503EDDFEA6371797B67B74743D8B703427737E51490A6F28E368FDA36AC660
      EB27B44B58EB39AA660CF93B57B1BCB29A29E46ECCF649FFB89A25E46ED51BA5
      7F5C7D1C7337EAD5E2A91E571FC7DCDD6B0B36E896490B9BCC2CA035DFED9669
      81367DE51621EDA07B5C728F4D5ABE47A8CA6CBAD729BDAF57B84F9374D0EB96
      DD6378ACBE2777EE06BD324D2663AEE64673E6E8C67ED98DD622F28DB9F51BF4
      CA94567BFDE48D6B4B77588B8FB2929C09CD5A5C54DFA497EFB0160795BB720B
      78548B83CA9D66098F6AF130B9CB626083A35A1C4C6E5C27E951F569D07642C6
      700647D50722BB4B93F4A8FA44989B32463338AE3E10E63643CEE3EA13616ECA
      8E84284AD58722BB37772A8EAB4F85B9D35EC3E3EA4391BD716D098FAB24D0FF
      2A8A209969CE462B7B48A5569A7B4A993CA9D0500B8FE996EA8C55BAEADABCBA
      A5EA63A5E69A7B4CA9D0AAA7C5E69E552AC2EA6AB4B9A7959A5A75B4DBDC93CA
      F48F2D345DDB28EF5598FDF534239AB06D7DF78E6ACB6F32B0F53ECD3DA38C15
      AD0B747986EC52FB21FD521EB326E1F921F61ECD3DA894E1AC897C7E90DEA1B9
      8794F29E351D801F92DB9FB9279572A335A5409E94DF9DB9671DD4D613F859D6
      DECC3DA74C4CADAB0D32A6E2CEB41D2CFD9B31BB35474DFFE6ECCE7ECCE0C6EC
      AEF8A01B32BBB5890D6EC9EE72CFBA0DBB2B3EEBE6CC6E7D8E77C0EE6CAFDAE0
      3612347BCA0DB794960BE641E57E971A9B2AF7A05B49D0EC31B7D952EBB3BBE5
      A6CA3DEBB612347BD26DB7D49A2375782732B4E02F1DD697A099ECCCEEAE2F3B
      B39D693FE0B0BEDCCC7664EE01F5E5A52529B3DBEB4BCAC20ECC3DA5BE94CCED
      BCDC33EA4BC7BC5CCC9E505F2E6ED869B6ABFBF0C6EC2BF7945B4944F398A3DB
      1900B947DD9C7DE51E737B89983DEBD60640EE69B7625FB927DD967DC103C751
      10C5E928F8DB59ACBCCED9145625EC9C8D82A5EAAC7FD53B38B0BF845FAFFBBA
      F3B7E7CFF06BFC7DC3430A5F77F25F660FD9F875E195FC886EEFC8FE127EBDEE
      6B7E32FEB6E11185AF0BD7963CC27E214FBD7BDC933FC107FAD371AF16A53BB8
      D87FC11488F16C81CCA2D73BC3EC8933570268983B617EC1340BF9E5C0D1372E
      5CB8F11F817316F89DB318FE4BDC2E88A724E81D1CC3BFF3659076CF2E7D6F9C
      060B373EBB8CDD05DCE5C2D7676EB27083C5CCC50FE1720E02CA5DA6D199EBFD
      BE4CD218F57578208C34C07FFCD45D741CD8E76761F40FD875D13C4A95F3C759
      92AE0295CC944AFFB8BF619CC56900B4988C93AE0314E9C07F483A5727AEC030
      D2982FE838306426ACCE2AB1124A88D855B43E1B4F63DFA3DBC285F5847081CF
      70CE92505DA530A8E41F93289EBB297C5AC47E14FBE9AAE37CC4AF306D038691
      74F3241A753B4428FC778493EEC26FFC732B5245CB1488A30275A182CE16841B
      69DA81925C4ABBD119FD7D13F5CE41B3013D07AC40A66347D3B0B31DFD466EA2
      BC28EC08296168098CF9BC7BB091A6C70E6EBA38F1BD6EFF78D8393EEC3B33E5
      62468BD3153AF7BE3E9DBB37A13350EA5A3A23254B77E91D51B7A7A93BDC96BA
      3DA16EFFEB53B77713EAF60EAFA72EFCFDAB53B7AFA97BB82D75FB2C0B604EF0
      2CD7F3FCD4BF507079A2E6FECCF73C15C22FCB103EAA25BCD27A68D779CD9475
      7E7463770A949E396FA330A507C2DCD3A4DB857FE2E8D23B4BE3499AFCE27BE9
      EC551F7E59C08B826EE7483EC6D9C749A0FF3E49CDA791F914E3A7F168E1025B
      870F13FE3082A98384E39FE96AA1E0AAE442C5296836F069147BB1FE19C8CF91
      FC8CE5A7370DCC27FDDD4C7E5E544A3A98EDC30899FB1031DDEE35DBE1F93396
      34CE17771428B3970EECBD54C6FCF33319513E25F27CC3DFB37D8E9B933738FE
      8CC6E7B99DB8617BFFA059B373025AAB19D7B07A5CF8DA0DE382AF910915C7D3
      DB723CBDFC780EABC7D33BDC381EFC7A6D34FD2D47D3D7A3212DE1E8EB30D8AD
      37FBE09ACD3EB8735E6AADAAD1048EAE65800562CA0168FDA246BB66618F4B17
      76D2A349760A53EB9DF197B935AD3D861FBE7C78EF9C449E3981BD4EE9007CA4
      104EDB7EBF5F78F3BA0CA1C1155EFB660ECB9DF894D29BF4F26AA6D923280AAE
      8EBB43F8B77BD4EFC18FDE219CF2F4AA3F1C0EE0C7E0E00878F7D5C1E0182F19
      0EBA78C9611FF3AEAF8E7A8301DF8D97C0563CA4C7748E8FF1A26EF71805C715
      98443DBCACDB3F1CD07583E1C1F08EB7A6ACDAB5CA7EE79ACDD9D39BB3773B35
      4A6BA9BDDED6FBE3C758F1AAA6CA33FBA477C38DBA9119E6B8736E7055E3C9B1
      C55EBF7C5085E1E4C690993F6B2F5C04FBE7E6F183BA8F2F4EF2FA178CF9181C
      C83138EC7D4593141F4EFBF46C0C2A176C8CA51BC0DDE3F5093DB0915ADCBF9B
      8DABFEC050B4DF1D1E0EFB3DE7BD9F589A25B993FE02334FD214358D3FE823FF
      AEE68BC04D95EF1D1E1F1D757BDDC180FF4A2AFD19FD1B4EC6BDBEF918F6FAC8
      FEF0B7DFC71DFD21944F932808A24BF925495D502361C5F837A4B0FC05544D15
      A69D3FF8375C82B36F3ADDB3E57EFFB8DB77FE13F702BF6F391FA91858249562
      241C0777E928F9FBFD614776CAEF63991B32BF9E5E63F4B7544D65BB89E0C42F
      60B821FC02FBBFEEBCA24DF3E995CC0756203F21FA029E8C3FEF7E4AF52684AE
      D2F5A5EA1D6F5EAA6EA7646E3D3CCCF6DCE80B7809FE7CA8B9593383F5BDF9DC
      8E8E0A73C32F706EF0F311CCAD6266C8CC4AE706FFE6E7465FC04BF0E7E39FDB
      35331BF47BB0B97373C3AF706EF8F349CF0DCB277233A32FE015F8D3A1F0C7D3
      9DDB618193D01738B7C37A9C647B19766F731B0E0A9C84BE8057E04F3D378C14
      39F018FC0C72FFF8B87F747C34FC73A368EF1F747AFDDEB0DBB3C8A2E77FEB25
      7F4AA25D4FFAEE56F8C988763DF5AFB5691BD1FE68D96823DA1BD1FE94E6D688
      765BB41F0F87479D834167B368DFEF1D1E0D8E069DE1B091ED8D6C6F647B23DB
      1BD9DEC8F6C73BB746B6DBB2BD77D01FF68E7BC312BBBD0B92FF70787478D4C8
      F646B637B2BD91ED8D6C6F64FBE39D5B23DB73B2FDF0E8F0E0E0E0B844B6EF1F
      1D1C768F86079DA3AFB1E88D706F847B23DC1F33236D847B23DC9FD2DC1AE19E
      13EE47DD7EA737383C2C31DCBBC707C8860E868D706F847B23DC1BE1DE08F746
      B83FDEB935C23D974CD73F188200EF1C9585DC3B87FDDEA0DF6D847B23DC1BE1
      DE08F746B837C2FD11CFAD11EEB6701F2002ED416FD82D4995C79649C7DD6149
      C8BD9311A6B32D556A11A207FF75DA452220856006D71673DE58CC57CCE9CE85
      3C4EB17BBB29DE40F2DF7CE56E56F487B3ECDD6E9637D0016EB33F4BE6A8D7BF
      7496FD5BCE727B6DE02BCCF25A3D076739B8DD2C6FA017DCE32C658E076B7364
      35AFF62C4921D84E43B8FF590EEBAE6401E5A1AEB6F038667978BBFD8ACA4141
      DBABD61BEE7F9647B79B6585FEA0F5BEBC06717034E8743AC3A3928CFC5E6778
      D8EF1C0E7AC34D247ACCCE81C27A7FCD42FAC7E41CB8B38CCA7B537BEFCE3990
      E9F68F666EF7EB1CB821A2C3CDE6F6589C03D7AA74B7700F3C66E7C06D1C5637
      10F88F89935CEBB0BAB57BE0D1724994E1059156ED1E3804FBFFA87F7CD82BF1
      FD0FB0DBC1D171AF064ACE830B775CF78740C97970E1FEA4FD75B716EE8FD85F
      F7D585BB09CBDCFFDC1E52B87FED685423DC1F2D2769847B7DE17E74D0EBF40F
      07876581FDC1F151A7D71F1CF51AE1DE08F746B837C2BD11EE8F808134C2BD11
      EE35847B1744F7B03F18F44A22FBC78724FD8F9F825BBE11EE4F71DB36C2BD11
      EE8D706F847B23DCEF5EB8F78F8F86BDC383A34149D0FD7870D41D1E0D1AE1DE
      08F746B837C2BD11EE8F818134C2BD11EE7584FBA0DFED1D76BBFD12CB7D1FEE
      1C0C0647C74DD0BD91EE8D746FA47B23DD1F030369A47B23DD6B49F741E7F860
      70705062BAEF778F8F06FDC3E3E3E34E23DE1BF1DE88F746BC37E2FD11309046
      BC37E2BD8E783F3C1A1C0C8F8F86255078FB60D71FF60FFA4D4EDDEDA7D214C0
      35057077BDF79A02B8469E37F2BC91E7469E1FF5405E1FF70EFB9BE5797778D0
      19F68F86074DA8FD8E17B9B1D61B6BBDB1D61B6BBD91EE8D74FF5AD2BDD739E8
      0F07C361FFF84FF8FB5FE8DBE842C5B1EF297846A0FEC87DB57657EEAFE36809
      93390B121DB72FDC9679FE37DFD6DB7C9B81DFDD7C57DF08B7B5D7E93482CD37
      0E36BFCE00026EBEEB60F35DA601C0E6BB86251431CE92CDB71D6EBE4DB70046
      26B7E9B6A3CDB7192C83CD771D97CC4CF7242C59EBCEE6DB0C2A52C96D657BC4
      A89B25F7F5CA96DBF4572AB9B15FF242532652725FC936E91F1FF78F60E54AEE
      2AD926A6E2B4E4B6B27D62D25DCB96BC7BC807385617E92870FEF8293C0FA3CB
      F06FFCED62BAA06FF1C3990FFF74CEFCD45DE0DA74CE62F82F19C17F2E2EA5BE
      A25B7205BF25F13D7C207DE8778787C37E8F3E0F8FFAF82B7D3EECF4E0FF86FC
      B9778CF4A2CFC7DDC3E363E072F4F9B07330ECF3E72EACC2019C21F9E578D839
      865D40BF1C00C57A5DB96CD8E9C25DB82CF3B99BCE7E8C8126F4E96D14A6FDC1
      D97C149FBFF2812DCB87D3250C7D9ECCDD20781BBBC0B8E79E9F2C5EAB49F76C
      1E7C70E3295D1B9B4F9E9AFCEF31FCED327617EF8841932E3DF7C3F4BD3F870F
      A11BAFE013EE603F9C447F9CB9CB7416C5CE9B00AE495215BFFC09FE142D54EC
      A6F0F517F81B7C1B3A6FC269A062F8D338562010E667ABB8D7E91E9DCD23989A
      B7821D388BBBF4223C8AB892EBD7F4E09A63BCA44BE700B641E24721F209E5E1
      DBF1E887D164E14E55D21FF22F9751EC25C7BD9EFC6D3C73E304185C6760FD7E
      990C81AAF85E786478DCE775BE9A073021DA39F4B1EBCCD274F1ED8B17C978A6
      E66ED29EFBE3384AA249DA1E47F317D164E28FD50B7CDF8B5EA7D3A74FF3E0CF
      3FCF162E50E3B2DB3D86FD409F675DD82A302D207AC0E4854FB1F9949A4F23FA
      345D82C9197710B52D51E3140DB94BDF8B2EC7691C9C4DD270F4FB99AB42CF8B
      C66729ACF1F91C0E48D2E1CF932886DD91FAE11428188511D8AE23E525AB6402
      FB05F6940A565178310F3AD65F41684E3D3775E1CDF1049E0A42384CE181176E
      E0C3F70AA8D13D4B66D12558C163358B020F85379CAA6918C56AEE5F296F0C4F
      47E10EA7E642F921DD79856FC1DBE0031C60D8175D58812BB0A4D368A5429895
      BA5A24B3380DE1EB254C16B485F19917C21284C9C81BC1B7A43EC09496306F98
      583273814BC00EFB27CEDD9BCE6917C387195DD805FEEB4D2FACCF70A93F65B3
      10FF92FB6D8643EBD20DF801B509188F1B7A6717BEBA3C076DA54B9F92B11B28
      D82EC02C46B117CF94EBC9C74914A567C92258A597A11F2A5C1AF37996CEE1A0
      240B984410CE52D7FB1DA675B64C40F119B9417806FFC117F09233B805DE3086
      DF2EE917F810A7D3F82C08E144C3CC153C023E5DC6C8D5CE92D05DA4D114D8A1
      1F8E5510C08340119BF82A80B3EBC1E3CFE0C2C5321CA352EC26BE6B9E82EC24
      86111B6613AA4B786292AEE0CF09BC641A479730E668E2A738D010099EAE80EE
      E4080923186C085C264DCE260A07A7405B83AFC757C982B427E00F1EACE1257E
      AF704D5DD021139CCF993BA18B97B02F83B3195D81844B81F5BA315C998E2F5C
      A2550AA3C59B26311204BFB870D3ABD1D5D9791C2EE22454E9D9D885E3081B2E
      003A3AB8737C388D0B3705ED50A51DE4137F39BB848D3C99A7131FD4CCD8E901
      A7FD130F3F30A265ACD2591CA5A0F602D3073D76EE8EDD740C4AE7820E1C8CC7
      39C353E739FAFCA152A9AE3A67B8F22A5E1D826E862B2F1F6120C9157E00F287
      33152BBA1B6FC145426D959EA6262E6CF1312C201D60870455087F029DB90B9F
      96E3788E5FA02A8DBFB3B28C6E9A453873C3298AB330BD4A5DA72D524E6EEEC1
      3AE3ED30D81BDDDF874F205A6F74EF003E05F5DFBC9BBFFBA0FE9B474EEBCFB2
      C70C8900B58771DDA30EE941F516E2BAE71CDDD5808EEB0C08B7FCC62781F089
      815705AE1F3AB2B7CFFE016726D372BA1DE4D8F4EF088F3EB079977F82C0815D
      8C77A06620DB1718CAC20D1633173F80997636A1ABCFA2256D78B2DE3A67C0EB
      96490AAC7696C26B4232CAB40A060F746D8DC7296295C27F09C87D37809981B6
      7A90C32E456317FF8A7FEC778EBAF461A2E03A503123B8CA9DF4BB07207567BE
      F58B3732BF1C9C8DF154D27DE1C27A44B8C087C092E48633D2231A1CE5315447
      6793C1E00CBF3F03B2CCCECE418D0021DA1F020F4C721A1DEA1BF909CBD8E0FE
      DCC068FCF02D4CF297999B7E9338C09F1D58B9AB379E9F3AFD76BF3D745EBDF9
      F2F23F71BF0397E2E5BDBF85ED6EB7B065A4EC0F3793126847A4AC24204CBF8A
      845F501C39D1C43961B52471408A3942D68FEAF21E29781B9AC9691814F07B89
      5C6039DC09A566CAF9F2E9C41981CA1985B8DD52F8268D164EA026A9338EE210
      04285012BFCE08E8BC05E5C069B94112399733D0F6411F3B579EBEDFBA109662
      D719BBA133520E28151E3CDB417DCB810599814DE7B8EBABD5D6EB53A4478FE8
      51C4331E48D8A3FED1EB6FA446DF791D2D712827813F3E5F7BF92D17A3722990
      227FFE0153BFDF39BF019AC7F73ED9E7CFF45EC1DD77E90781938071053FF03B
      5063416782CDC22A175C0ABB067571BD332A9FFF0B98EC33BD6FF1157EE2F051
      84CD5679B78211C1EDAE033AAA8FB658EDF79EA6602F39AD0B3FF16953C70EA8
      B0BB0E5815F0C8F521A1B5E4D15F639580F90CBFD071C24BE888E15181914F41
      84B71BBE5F45FD1F9653B06F1D7FBE8823242C98DE640F83A5441260E7047D11
      CA790D5698EBFC087AFF6CA791054616F873054A87F28072482D76DC8082E93A
      1E116C8104A33FE1FE1C1E743EBC724EC959B03AF5AFDA2A993B3337014E0F3B
      18B6F2728C0F8AA3B91355BEFB024E39C6C9E67EB84C55E2B4BA1D67162DE364
      1705863B820DE91CE8BFB66BB12B54164BC8E33CEEA3240EC05B1F25ED48BCC9
      6678B59C4EFC2B953CB6E351429B9AC7E33614415589C35E782662B588621451
      7E922C61C3CE8093F3CE47B279DF0ADDFE900492ABD432C68C9FE1FA3E0D0511
      5F3A7663FAE4074EF399C09FBF191D9E81D8FB73C31AE6F2436A2FE686560935
      963748366F7FBCFD7E16B972895B66554117F6FC04D45F6FD7D92F28A2E858BB
      E950F4CCAA771B29E57EE0E166F322D861A0483897517C8E63FBC5272FF82DA8
      E3DCC3063593ADBB41EF68BD6B13F9F9B3B215BF9CF9A0BE818ABAF3168CEF97
      41B003B650B09C87A2C6CD234FED39F0279F17661125ACF181B4027D63E906A8
      878428421345E2D2A87FFC9CE4B12D9F0E60692ACAEF5F79F14ADF7AF3A5FBE1
      DD970F6F408340FDF9DD6BE7C7580147866FA73385E12930453FB818B742CB27
      F6156818B0CCDF7FFEE9472770472A48C85A0DC0F0C0B504451256757EC3D5D2
      B3B9F3C5D251454D36F9FD2B2F56E95B6FB4589577D16A9EA06F3F56A0678A49
      6878A11FFAA94FE76C29470C1E1A63BCEC844FEA2FE6A4DE6ABA5F81534A50D7
      105282CA5F9B5196BEB6C6FA4DA22558A9A3159802A0C862B89756073D2528A1
      90FC9FFE5E70237D88BC65A097CE87EFC9A4350BE80697EE0ACD05D29DC8EEC7
      741DB02016600D27F8D8BA13ED6F39D12D9C215B487B79EDE3B62E342D6E695C
      E83C8822896B28D23F2D30A8EC8C676A4CCACC4775B54C60AFAC31D9DB8EE921
      CCBD5B2C41BD5D5646F81A87982309951792370E273307F37F4C1C561C298E2B
      AB863E001703142046252B23B79275DD655F667EA2BDC3E9320E513E4CD8F986
      FC60E775147E935AEF342F7096B489769C68819CA5B67FEEDDC481B7F1CDE413
      BC70FD00FDCF7B309F11C6D2611A333F4C990A302CF4C0C11D21FA21714CD910
      84D9C1FF536C6E9B31F04AE0FB43071D28E8D9883252B6547BDA7606ED4EFB6A
      0F7EF4F047BBDDDE65E720DF49EF144F0D8E6BE2C749EAA4E8C369B99394468B
      C4C510A1DAC54BCCBC899EC85EE155DFFBE90FCB113E3093A79E5F6333254835
      CF6901158A2B6804C0275A9C64B79EC3A66CAB3F143FDD32925933760893F99A
      D1C3B2D8E141133BACE7E679ADF51B670E4A883B55726A1E990C79E098A1B746
      25E3F9657279B5D9E1970876EA850F7C69A294377281D5B3BF17762E3337604E
      B879C9DECEB3650A8C3007F527F467D61E2FFC68990027E3ABC08E5B45CBDA03
      7A1BAD871EFD32CAFA77191583A9565EC3B47030FB0A5D0B5118AC6EEB0EBF59
      FC0E486A56C34D30FA4B62E7128E4722AB01E45F065E71B94230A1585061E00B
      1F8306DE34223B22CA1EC7E6F7050589C3155877211C8AE5188B0BB2AD82B7CF
      F1A4B00756EF1C6081631DFB87E54483820B135860A37062DEF89A1D074D70ED
      C946041E9611162302D5B1E57B0C19949FEF7FB990C157DA05B7F04392E68D1B
      431C9160D8B8B049F0CF990F8452614249A8818B9661EA07CC48313980A2AF92
      1D00EA3EFCFA0837C98DC32ABFBEFD34F8CD79FBF1E50772C1BEFFF40AED90CB
      387A9AD32CDF0A177E9C2EDDC0D9F9258A038FF2D3771C1000739049248ED41C
      EE73E395033355B18FC17715882B9AB688A4D43BF0EF52C9FED8B0C17EF9FCFE
      B5ECB17F2D0AFE42E62BF9044FA2C50A9D84BA2AC86991BF007FBD8C7D3C23BB
      7BCECEC708F5070ADCE4A367A8523285126712B895639A4E51B349300542C1B8
      FEB5C8FA9236924557CAB46A21CB3111AD28C5C049E2C30E666B9EB4A79F7D60
      5AF07667EEAE9C161CDF1895B831A8A47001A870A3C00DCF9F22B1CA48F53670
      A7B00BA26C27C1A47F0A91224F729A250E7D15A7A8A303D389D3F112B4679A2A
      874371DD830833F26A2847ECA3225722ABEC3AB16D256641F84DFA2F44B8CF70
      66A2B9F3F2E7BCF0A6498F8328C94477636294674F2A175E401ACFFF17013561
      233649DBEB647AE9244C2885162C52EB9F482DAAFF1B018932C3C2F53C36A40B
      59D9C8BDB3ACD67BCFB37EF9FE8BF357E7F48152ACD7A27B5F7BBA275F3EBF87
      F9BEBDFFF94EA2F13291946AB3636A3BC2E80C8A6F1FBD29989F8D19CAA86EDD
      FB9E112276F69CBFEEE13AEEDFBDD7EBC1CEC3DBFE4324E09B4CF3394A7C14BF
      28B369CBC02A9F2BB54864DBA024A3445ECAB258C631DA2DF03341D71AC8363B
      0477EFC47BB00206433F9B1B6F43414D3AF4965ACFA19598B949F5F18E152E1D
      BC6A19729CCFA3A341BE82C44406E9D79277487CB0F17FD6504E50AAC241F9C1
      9D8F96F11474BC0F2A5C365A89A6CF0E12688713222FB3C0BA8E05E7C9D6ECB7
      1AF444C7CF4F21D708FD0096F90EFA981182218B71393B2F618A0E939E73219A
      1D99C5C281416F2223E54528BB625132159C560DC60F0C9BAC3F228D64563077
      8D1585B2305AB59417327F4D9C28E00412D0A6BA59994B21E7C4C7102A8A8A62
      D249FEF0EC390494236977FA4D1330D113B20670C241C47F5E59D6805C595BFF
      CB65F7654931E490A43727E8D4C4674AC59E4F2E133788A6F5DF5179853D885F
      FFCF6F7AC5683C20E1088404FF2EE1E2EE010C06B455CC1122673A7CEFF989BB
      5880E44B283905AD20A42FCF268CA27F2A73B7599B864355AF5D1A07A092D336
      41C2924FF0072ED904D5E27F2FE70BE74BF454F8D12DF5548B5EA5268C45AF07
      B07DC3BCE356164A52FB586ACB92F1B56E2A8EF2E6285452173471AA38FD0108
      348E3C60B29E9B3E959DFFF525F19BCA2B30EE158234C91150CB3490A9614422
      4D61F0E61F4B3F860B3811C94D5DAD73220E901F9050179797BA52F5D33249FE
      DA853C26C294EA17A117842D2E9142F0025406502BE34AD9B33FBE77E7EA23FC
      77F6673B9BCC277914CD6AA412FD546B80CDE9AA4A6A44CF657E8D817CCD21CB
      25535BA4AA2EB089C64B0A415F777E48A3CC4E1FC57FBCCC97A1F4C1BD841727
      A1BA6CC7E9A449D8BD7DC2EEA049D86DF2D2EE2E2FAD493BDB26EDACF7F8D3CE
      FEEDE078E0EC3B3BEFA3B11BF860C12E82E5D40F779C09823F92573971467174
      AEC247B8C2374EC348224C83AB419FA933A7325F4EA26257CA58B21BC67E0C92
      2F49111826C1E43AD80CC87DB18074B9E024E189A4553DCDEC8E12EAB91EE209
      BC206B053F30352D52D5E02E5C1D2D159BD765B625266BAD6552B084C2981382
      B7A152BDFB14095C5A11FBDE0DA74BAC87C83C620211E05EA21D03FBAA8D7C25
      9C2662DDC0BE6B8F12F7457BE4F61C8A155DA827B9E94A69F2D397B7478E0AC1
      12A23058845A24332DCFD1B440DC21F4874EDC20A0C4FEB942D7A99FCCD1B7AA
      AF624B3075785BE1739F22A14AC814AB4906F9B14C606BCC2398EF1C0E6BBC62
      D771A8C6586E13AFFE85A62D81C939178B67C7860A4E91132F142ADB14AD5435
      F8D315F096600577827112A64039346038322B4EFF3DA94DB9C43252F45462F8
      94FEF214C95A7AECFC104B667C44631FFBCC6818252108DC0526A4BD60BC6B72
      AEAF16123CB098B77078F117B6FCF982FFC6653478B1A79271ECB3C41CC19B2F
      75F5D79364EAFF860864FBCE67929DECCE099741204699BB589802DDCA47710F
      93E7CF1AF3ADB2DA0E0360CBD4391C3AC97281946F0C394D9BEF11810F8BE0A6
      0888919558CE5D4FB531B9DD64B2935187A9BA0417A52654CC8D01CD30BA6CC3
      8E9EA858210AA2912FE6592AE442EE8C4BA22BC876834E9658148E8E9F22DA1F
      6582F19FE9C128C28A2FC26B707DB90340FD22CCB56D512BE378AA421553113B
      90CE5BE9D4C74584D1420A69B8E10A4543569AE8CA341145060890A2AB2B3A77
      E0D20DB3C521CD97E31957F3A08622D092343D5D0C4B3587E3D84D66AAFE8C5F
      C1A3137F1AFA131F2C1618E81CDB9D101E02A66073AE4FC20B12534E3E221B85
      AC87EBBA226BE56941112ADC9FAC24CD2B5C39D89AA00AFFC1D991862A3B5C6F
      9230E50A69A58DDFBA9292E2B09EE352E0F81D1CDD5CA1A9D53039E3ADBA8CC8
      FB5942A8E2B6BB89BF6A7368F75FCE6BD5BFADD7EA6BA76AEEE34051909446BF
      B1E3D3578A7FEF3BBF60BE87A9BADC8850C5D92BC43B91922CF5409E8879229C
      90927CB8AAC51D23E395D27576C125EDF42A6D633C91F0D193737F91D4F1E8C9
      80BE8F23B04AB221E158F2683C38A88446C576B0BEE9265E837B3A1AF79F6C41
      7B6D0A4C048EC003645BEC3BEFC05C42B3EBA1E67EED39FB5AF36EF321CBEF57
      3A2A083C84A1F1F7B01C685B663A2922F4A1BA45E1C4D0D310E9AFDCF1F93426
      CBF63D159D350A4775CEA84914DC69B2930B35533BF924CA1D8DDF652C215D2C
      557DB8AFE99141B514977EE8A1DD4511790D13B650A8948389102ED9706A491D
      40B0E292DA2C64A71899B409CD6D5072068F3D34270139D7CAC57E4C0B58ED74
      D04CBAE54F3470CE9374E7494E77C30335413E703801F88F9FAAB9A5CB2E431D
      58F0AB9BA3AC9CD677A4457B0A589A27388284B674951298B2E74F48B6A7FA5B
      7A694250015305BF51AA24B966803FF280D8D93C596283BE46D057A75E83CE84
      6D4FB31C450671786D39E481A66FB16C9F137D9B6360A7C78C35FDA8482E76C3
      2470A989A50935B612A524A681D7649E356E67854ED29121BFA7423B0D94F403
      75558DF7F610C6C1BF8F17DF5EC1FFFEE3FE8DA2249AAB4B2A9391F36EC78F22
      3B0ED8AE47192AEFBD33F70452E5FE892205D60F30DF653A397A901A7C7444B3
      EBC29C430E98ED39847C5B4A8B35F7D09DD1A2DB3BE83D401171DB502061A320
      C0400FC5FA072047A77E0A02121D51189DC0A604C85E3A49159DBE1695907774
      8EFB9D7ABCE366C5F78DD02F8747A1C6DE79E115E8842344EDE10B38B3A811F8
      E5951D4028386435CEA7A529504D3F039F1B9AB73070015F693540774B236A65
      49F26834B12EB18B6A0288387FB2D28A426ED140ED60A4D4C4D9F98934BADC9F
      BFDDD192D3441AD15DAD21C877EB83EEB2144E1CE383C01CFF9FDEE960AB41DE
      DD43FFC586718AD442AF0690A5F27D306A974107102581448007DF3C80FAF3EB
      78A175E6DF1E400312A7BE908F5D4E1838C62DE12B8C7E9D2B22FCB7D5E7373B
      A3E9D5717708FF768FFA3DF8D13B1C1CC18FFE7038801F8383A30EFC38181CE3
      25C341172F39ECF7F092A3DE60C077E325C0080EE9319DE363BCA8DB3DEEE055
      DD1E5C873FFB8703BA6E303C187E5DC6702FC03CF65E289E9CB27B543885E33C
      FB0E95A7BAF79CC3B4A751F8DD10FED7B065DB0E4B166ACC1B9F912D49D7A9AB
      0D3F882E7CB738DAA40D1775E1D625DE76FF34C0EDF91091593F09BF49F7D81D
      8500EE1479C5CE18572EA61C6E25D5AC1D65E8C90D4D2613EC0D85A607616838
      6C88BAD9653E827CC6FE852E6FD352BED14C6BB8A3F25DBA1A26676FC9B51E66
      B65B549294D19FC429C9A86BB1354CDD028D7E669A62EB9C3FF7EE63CB952CE2
      F9B3B5C9B4AE76EF5A8F7AA813F72F5540DA6F0A486B9A87F34535BE03852C8C
      DDD7642AAF59CA924AC5354D067A8EE904A4C34C1C0404C61014FCC58F8DA33D
      4BD97DF9F1F49DD3C2ECDCD12A55884C8219B6B10B6C26DED5D74B545D502024
      8865777FCCD4A8B9BB58A0093D52E92506F8CDC33839968741AFE234D75D5401
      D0CC6F63D750C6D7928CFF0479319FAD1AD498B91EDEB8026B6EEEE3EC6DABDA
      1D8FA5BBE1DC2619CDC3F31116D934B4A47E884415332957E03C5749AAE685BF
      89079D8AABE48ADAAA13CF2DABF34FB0DA63C56548C517563E4C8F889D07B0BF
      526CA74ACF12F56C6CEAC178B398CACCC04DF0B2C8D47CE9193CA6D0F3832741
      1C3CF62488E7CFBEE7636D8EF93EAA420903A4495639F93AC89B142277D8B3BA
      4A6132305621ED211605034CD03559CC3A846B63E7C2373E3DCAF30FDC559628
      F698B64C25C57EFEF0F235967AC0EC539F4F00166509FDC84E8C6377959D8C3A
      10A59AE8D8250ACC297443C2213B3D5FC5FE9C7860E002750949674554D5AB45
      8CDAA0DC588C4A1F69747312081D15DB6511FF4B77C58878D236E0F11EE2BA89
      3C5691AABD87D72965A0501E207CA56B8A1F00629AA41761E1BA7AA3F84956E1
      FB2497FE8B9D1150E3A0D5DB2085A324BC4C989696DEA828494733CC95A16085
      6A5353BA4FA3C007AD24DC33D551FD3D3AC5FA57827657533741674A7E1CF046
      1580D1A8AE16813FF6F1D0CEDDF89C7B9B2458D1E4DB6DD1D6EB89780816EBA0
      EEAF7BE4ABAED30EA21A570093E5819F044B8F4A51577A0F5969194E4B53959D
      45BA19608EC4D5E7F0EB45171EEF39DC2D145A6B540202620856EB07B6B16A9C
      A20E43C0C6DCB5DC3A47A8AD1B1D1CF3089C16A9C908060102D279B7DBCE353A
      C69043B5C1C94945CBCD6DD0EFA18460BCD817CBECDB7FD7B37B809421F6D23E
      489AD4C34D1AF68AF2497F7A80893F5C5650311B886AA8A450378CE239F129D6
      FB472AC3C2284035FAF54B6E8B3A37D575AD9D6F912E20271170A49DC5CEC15A
      2675B7F87AAACC2EBA3EDCEACCDAE7CFF4ABD18FC112DCC83B6A8C4A482A143A
      07F1C81A7616E5203A6560465B165CAF6BBB5CE58644862F476EC26842E461D0
      7E30B4C948147F9360C966AA95181446F437F9FDDEFDD4991C86F93F8424DEAA
      DBB068552D14C8A76F76F70AE5203972F3BAA07E360D61B9AA411E9B2A920D0E
      94E16377A0489A012811A8513CC225AC9CC104ABFB9EF2041651B6029DA73881
      F13FD5F8298FDF43FCAFA7BC83C0787EE233982A50BBC2A73C8158A9731E7FFF
      298E1FC451E03FE915F8DD5DB821AAB2FB4F16B00F8C8F4B357DDACB80C6C872
      BAE48578AA930075EE8933D4E452794F7B06E9323E3733183CC519C4CB243187
      B9FB1467800D053396FAB7A73885D9329CBAB1598627A9A0829138F2C73C8126
      B13BEFD2387DB38D1BA3F1526CF2521C3E492F457302E804E8A0EC2017A23D1C
      36C7E2B6C7E2E8F11F8BE6446CC88337D8EED58E13383F4BC62035E723C1908B
      44673810D32221F3F6D340B2203E1D0EF5051893A560C984CBCD53EAC0ACAEC6
      6A916AAED5DEADEBA3E79C88CB7564339DA8B9967BBA11E47ECF4140D9AC6F74
      56BA9B805DE0A7E319869952D04FC3D49F6B480F93D229984256F540B5E1BADC
      AA76268F8A41F1274E2BB022D706ED2285EB119F986B5E694494D54265EC267B
      95A24092B4FADF2E0A9415CF624E4A48D0E10F50B2D1CECA1C1F2096CDD9BFED
      07422C78FE8C836BFFF78D1CFA07A405772CA44322516DE92708E7078F7AA018
      FCD69C204F25D8E9D09CCB2DB2B9AB9DEB7ECA25ED69A499A6AE5B876F76845C
      3B4E0B3EEE1043300ACD2E1EE88C794D2891C80E989B12BC48B71CB0A07DB748
      69B95BB893FDE0DB7FD7A3BEFFA40EC4FAF865866BCF28EB498AE2C406256061
      02FC9F65C15A07CA60ADB5CC9E2D9928390954C4F98256705A0FE220935DE6F1
      06B6E001D6E8DF3159E23FDA7EE83FC00209CF36F3F74D339F73B5A223906560
      4A018993AC5D43998B9856CD891F5B25026C50192E679C2AEA27F606602010AE
      6965E18A799A6EE08C67913FA6BC8B072A22DE9C0149E5FCF79403891614B751
      37901D195DE7954F61A0674E6CD58ACF98BAB86FA79C6DA37BAD0390E56B80EC
      F29F0D7B04B58CCD093A94C0CB03A73612EE9C91429C9624986D77D8EF38C5EE
      E10E3BE69BE55238FF5BCAA45D603A35F8A270323808132CDF63856A2FDB9D04
      6F031CA7E8C9083D0BDD0A772EF62282BD388A10387D41F0D86DE704CF96394B
      FA11E92C8E96D3D9F5070C1820F259168288E34B7B1B5E4102B1484EBF84A2B0
      A2FE5D5215B4A187105ECCA344DF127651608339A0C316720DD4DCAC14F1A43A
      FA93ABE7D9CEAADC3C0E9D6E28AC761A4423B2AD2D63B3856BBB88FD28F653FE
      438942B46BB1E587499A7ED064E9E841128631559C56F441E7BEB97DC836F9E3
      77ACC93E9DFCF17F1554C9F5FCF18790E8E3C5832C78966F8E1C16DDAC97E873
      C69EEE2038477E00AC73CFD9A0957FF5A62F9A3D3C085916D4922CCECA9AB613
      59289474BBADBC03143BB3104481D45381FE8D60FF2BDB297AFFC6579977EBFE
      ECAF6BFCBF4CA93DAEFB66E8DF91D107270F23BC1EB860EF2BB9456B4CFC75EC
      4EA37014C5A1DE3495B77C059FE956A772AD4186132A3736DD38348034236312
      3026D8BC17E83EF343EC262B7D4B479138E5491F35164A03B8F8F5F913439A6A
      BDFD5B9D89551747916F9FE6AA320D90C8B75C7BB9567CB9DDC3379826F93774
      B3379C801D1C04FE78CB5750D5D9DAA387079D4ED769FDF4E5EDFED16E1337D6
      E7FE170C963E1227E6BD4CD8726262072FEC566D7895E9A18EFA1EE1044BC93B
      F0BA867DDD035E6CA7F36DA7F3DB7A6BB26F9D5F25CC281CAD7DFAE5F3BB8FDF
      9FFE2667BE948554BEB3C0631A96C02CE13129D7F7C3177C6AC9AE28E4831DEC
      BFC9C0B4B8303A4AB37CB1860B7C452E90A9CE26ABA0E4B83B2D8AAFE86DB3DB
      88F9EBCFB4D8D2E8EE7D0207FC8EA1A039224209193E9D704E784B2241E3C910
      6E1A717F7FE27EB059DC0B0FA87C06DAD72A99FFC6ADB858A3735A279F4FFABD
      6F5F1EBF3DEABF7AFBB6B6FD506340E67D376144773A80538A3383052E70970D
      B3B37C1989CE29A03ECED1A50946537C338E02F4666087E7BC8F82F34EE6EE79
      8DBC1E8A8A7E8351DB998B58A631700F6ED987387D26EE4F8AA8A07B6E4612FD
      74DA20A057D27BB9F05C74BEB319D0FE01E884D4F4DAF07583665D5F0A96A159
      F71A34EB7A1BF1D5723AF1AF54D3F6B4C4751C2B0993F9498220B4C01C15F77F
      46B23505379B0A6E8E1F7BC1CDF367FF7670D477F61DE4179819475D2519E130
      83B9A4DF74A325AAC298BBE1B2BACA13ADEB04B689F708F7463DD20C80341EB0
      B294936318761B3500CA3254F30526AC2216641463E7533A20BBD4AE13731D13
      EAD89B38E96564222F1E7B1F19D91BD4852759464DB43900DAB09CF122859D68
      8045CC15F5DFE014DA791452CB329FBBD3046E92720B194AB744D072012F4FFC
      74E9DA3DA79F143180144320C5B95A8D22643726A98A5A3AC7D182961C279418
      4A5D46F1F9139DEB21CCD53083511460DE4498ED81C9124F3D26D1C36E889EE8
      D987691EE1C9D78BC795261A817F21807D119001F1FB0407B1864455FF123BE0
      D8260D0E1D88308B62FF9F589413A00C89B05E112116B10B04A8F864148DA234
      8DE6F32849B975CFD39CFD710766EF06E95FC7CB38A10684170A11F775111021
      4E5AED9913A042B09C8758EE83F173D83723B4FF1BDBE6F6B64DB7B16D1ADBE6
      1E6C9BCAA735C6CF06E3A7BB99D73C32EBE71055FC24F5C7E7C8B8E3E83227A1
      39290FD97DE85EF85352521FE15AD7905B87A8A37EE6EE0493C06598629CE638
      5A70D347AA6604DD8D0C3C2F76A754B8157A24EB174F55913B447DF5B59BBA1B
      67FDAF3457DACDC76B4619F5015AC4A0901752A75096AE01791344C4FE11032E
      6059C6329DC0AF1850C396CB8DA8ADAC463578354DB3BB226D4EFD69486917A1
      5455AA24A1983589DAB9EB61C3258E08B0542EF652C995D32322109662CD97E4
      6B8815736C303BE1906AE0772F0AEB57FF5B6B07A69D72C6D52E2E2ABD522166
      3D7A98C41E237CBBAEA45257549F7EEFF1780474411ED086013C048447147341
      2131999465E8BD13617F121D0E1F62F66E929551D5DE7A2FA5172377AD45F271
      34513ABBA185B9E72C02E5264AF73908A294BA9D51BF029DBDCDD5A3828E8035
      156E3253E2B3F4432C6A09605C9BDA1435ACBDA6198ACDA24020376C3DB3A540
      3DD8C9A8B3035CB7F2A6F192BC26BE6E0E9444F9CCDCDCF380DC4D6BE33B7098
      741A8749BD2DFDD33BF410CC1B8F4911CB8DDAADB35E8BA98659BFF5D1D20F28
      CFCE904EBA634A79BA3B4EFD0BCAF4900A5B1BA86087EED881278F189F409880
      A4D7D0572D7F1C851AA703CB960235413B2E0EB1C9B1AE61C270D2A51F7AD1E5
      1EAA2117BE4BDFEB412127D10FFFB4D0826F9B5AAA6B9E24555375A2002ED657
      5EF8703E65E0A6497D8A0FAFAD36BC0BD1ADCE44E46131BC8380ECD883E57208
      7A3C5749240A771579BD42D052DF53EBC4968751DF9861E92274EFC3B78AEB62
      39716D979EFE1A2E735AFAAFFA6AB9D9BE985FB84DB91A8E4FBA54A323FD1CD7
      1A159728214D45147BD1B9DBF5562D5AE85B99D09A0E207E665C962A4DFE64C7
      C9FBA9952E77CDC510B84A1B2DA9DE0A3AEE253A5AD0BEA32ED55138097CC279
      04032B6E986A9EA96A250869A61982B60498624E3226B2B6460483463B358573
      88F4637697C89509B23D52F7DD30872DA7190CAD0F21D1AD9DF81A2EA6BB610A
      7871092AA8092DEBE7BCE0FB77F9797867F62433E71C8893FE3283D32BF069DC
      92893F0DE1A568A29ADD09244D978D2554BD6DDFABA90ABD4D47BB51988A263D
      8A2F1AA3E82AFA80FFECB31D694EBFA6EA6899A65128393469349D068A6100A8
      673BE1515092B3BE3E8DA2409880DC848614E5476730892040477EC8493678F7
      895E3632DE5A74B67805F9749ABF634BC6D6DA89DBDD426BFA4580F894B56DE6
      38EB68A1C23DE7B2F201E8A31FDB60579368CCE9DD0A0627679BC9192BD2AAF6
      44194CC7045F4CD7B572537E614F70573F440628C4F413FDA68625542ED20F30
      C4FDD73FBE6329D670818D121E435053CEA9CCD3CBD6D805E256AAF551748374
      54C5001DA900F48709A51F5269730D01CEADD1FFC301BAFF3F7ADB6B0D42E031
      B111AB2318E2FE1C28C9C96CA677381D8EB1CB2AF508084CA3C7A44769AD0A9B
      37AF39E34059D2E6E600672BE56A0A6D933487ADD6A67A73FABE892E953B2838
      07D1B829708B23C5F0F4E92D4F883B338525584E0B8EE3258A0881DB69AB2470
      6A68C31A999C85AE3F37BAB6C042C371CABF7CB7B619ACEF4066C1B59D092BCC
      23530B4746BBEBEC909ABCE3244194667A3525B0C0ABFD18E171E7EF5E27200D
      31B0CDB7E1A0DEBEB9BABAC2C66063D576DE5CB9742C096108FF8AC09588F70F
      87439AB0CF950BAA43C6CB6C04667A1DA6F9454EEFA0EFECE002ECE881D7A9D1
      6E753A78F3DBD7AC7D0C3AC74333333DFFD6DB371DB9ECCDDBB76F773521DC34
      434DC2ACEBADA071CCBEC07039F12AC606A6873B583C1A8B2562C6810E2DFAAB
      C07AE264F51FA547891F27A9E3F9539F2334446E5A0662721F3F7D81858B55E0
      13588AB4C2F6305E3447103EEBD56EB8C2C866FD8D8387A0961947DB049D5054
      D446D019643532F22565ED73E00E76B1757A68322BC3D8354A1AC2626A4C76F4
      3A737C2991F499D0F934FA1D88FAEEF59E6E7ACD30941995E4583295F6403EFD
      4F5A62B3A1414892F30F69C3B90B992CD97058B63A68C2280C663117126240B7
      F276C6ECBA8CB2885FF2ED03843ADF4D43D825309787002FA3F5A13DEB660781
      F90C1D0DE44C70307C1CA3D6E0CD86D27A8FF0DCAD9A3DDC31FEE08F895A7AD1
      1A11EF8184CF9F158888E4B18E568EA6CC8C84A8DC170536A186E6AA20ACF072
      4C9448F866B4E191D9570E52D43F2FA2834F1CDF3E3C72806DB9D1E8715534FD
      8C188B2AC48A98572BE7C42573B5D1E83693C7C6A2131D8485D5D8E506408469
      CD5F51348ADB86D05F45C24521E2BD28C68A18611A8484AD58469F7C3E318124
      06D44074544497180B8636979ED7962E3001B66BE8C52C54E1CD3CA4CABB6154
      B1E23D818D8266B102D330A0AA314A7782F3183A07A01269696BEBB630F25849
      584E90AF52F71C3F65F7F640B883B4F3B683A5B67102D9D34403354B555827A6
      30F51260542EE44CBE8C6C0F3F0906392581118DEA67CD24D57B449471B7BA12
      DD7645F3A8A59D9373F607B1C83F9F3F43880626B0180DB6C6C71D02781FBA92
      C8C650A8407AB8C399806A042ADE3255D27C0099BD8649A5BB3335DF15DD3AC6
      42415959D9E9B95986375A44FB54686341C444F5BE84D7B661C1F919B89C144E
      4CA39873E0743B1C18DA0E66DE6AEA1183533B7C2CC1DE58BA1AA6811E04D26E
      B606D066D29A60B7DD60821A9F614DB3D360AB897A60D5ED358C89E8F210C839
      DF393A230CB6BCE727B8E712E21B63E13B0F4810044879087DF63B4C1AFD462C
      40DA4675B107819781459550AE1E9E6E6466F4A536951F42AD35F43C85D1DC3F
      5AAFA626D1C2E63A22AEB57C8A51546E48D7FCEAFBEDE4DBB33F90F59CFDF910
      7AFF77CCF6A48B1505D4321A350A7415053FC093FC7D548DC815647613353410
      5701A84BA54A42A36BDB325330A74C3A17512F36842C52B1C6FECEF4146F49C6
      3FAB48DA85A862BC8003F4735CCA05450A713593CCF7C3610EF2D01A8CF42CF1
      ECE4C79F30AE801CE5C2F503146162E5A2D44FB292036EB0072F5B2E7818E8B0
      B4FC85CD312BD7B32D1B8880B4D83A2234B6E638951D27268F1894B61949F683
      D174D97F5D2D49D7A1DA492BCEBF4A7CE2C663A45F22C78FC1C95CC32345CBCE
      8A1B4D08BD3915D55930999F1EAC692F687C37850310AC1328B3F4637519FB69
      8A61E0CC06A11044328E317383A3CA1C0C0F09E98F6354739F0A5E0852C240F4
      C9C120F76375022EF927B9E924CA17D30166BBC693A7168AF01E3DEDCB9BD301
      36D6EE4B63ED8F3FDB34F0B1536CECA31388E6496C80F2DD5624889236F5B284
      871CBC383D7D23BDB90719E4A03CE6EE71DD6BB4BD58044B205AD24EAFEEBF49
      5B4617A7C5C15613ADD341273FA40473DB57CE50CFD6B8770DFB134AC292D502
      905E7B36770DE22C07BD9AF76E29E344681EB5D7642BEFC156FD57ADEDBA27F6
      9D51D5EE1F8E5825F307C12106023CC464838798AC0929B1835BBCAC29F670E2
      0427E4CC26DAF7818352894A2566C56E5F4C2BF009E4D6F65D6FE5E7CBF1D71B
      E1707CE505EAB61F091CC766CD6A0B388EDB6EE53F2A69C57EE26BCF2F4CFFC6
      3ACB63DB1A3DD91AF72FCD7FA2D0446D4679A79C631FA5C51D006C0CEE6234FD
      763D708D4F1350F47C37705EBF3F415E35D338C5C27BF66D11F808B7DAE0EB6C
      B5B33F6A6C363ED5FFF7E7CF0FB6DF085BFAE7CFBC3E02F230707EFEFC5876E1
      41CD5D78422D12C14A3F0996231D74F80A9BF16BCC7158738E5A59C06C2EDB0B
      FEE01338AC3981300AF7CB26D138069C7713ED8CB21CF496D596A2EB56B21FB5
      A311D30814DF52C3E94C1E3034C7D9568C42CA86A0B407A9EBC45600499AF520
      F525F53340CFF3CAEE1FC65A69769BB95E1C6D14F8177F3335244836AFBF249C
      2C96147D86C1519359938C8BD78F600AE78DDBAD7281117FE303AF4306B5EB81
      6C8EA6CD31CBD9466BE4A15361F2A997B5EA45F828C9A3D06D9CF785B826ED05
      130EDD18917FF5DFE49CBB1E1D733E72C99EB3338E162B3411DBED361D811D76
      F5F9733F80C54330322E54DBCDBC85968FD0380EEB57C99B881377B9778D975B
      58849CDC55B4E412715538F53CF26DEC5234896325D8AF825B057CA05A5BF9C4
      29E753DF58CFE4F7C434A0240A4D4692A98617BB9918E6EE9E919E7B5926686B
      9277D0C055E4B99637911734B7A69C762D09EB3FC66AE25F6D6592539DA295B6
      2AD937C007818A187FE345081D85051BDCC5982A250BA187EAE8AFA98C4867C6
      91208BC5394914FBD88C3FB5F10812D6BBF2EE52FF441E71AEF605EEE2A1FC52
      B006DFA494033553E3F32D52ECDEE60EBF5E5296665A4ECA33F3952A563D0CFD
      9D5CEDC523E5B4AC25FAB5FD9B8D8CFFEBFFF9AD7EDDC37FC1D1253F9464CD51
      BA89CE02A066DA1EE7E6704546353C517E4AB5C7F13A5AE2084E02041405D29D
      A471F0D73708C1C8546152503A680EF643140B4AA6CB25228E8328E1E3C13C9C
      49F5E9EFB547441DE228CD0E4FFACE4991F7EE657D0C748F02EEACA4B9214539
      78B89E4A68F5B2447D0E22022B72316BFDC30BC3752EDC00917489BB540F126B
      46B672FDD598152534280C0F2536267F62DA1434A58635F408C64C80D5FDE6D4
      D010454386D18239C9C81B4EBE7C7E4FABE1F11918E319F8A6D1C84C1205ED72
      41A2B92135338588E058DBCE6B0B757EE206C9162708F948758D2359633C66D6
      12F67868732035CA80990A3C6E6A8283CDB13F1612EE78AC166906C2C1427B0F
      7F3ADF834C5C70ACB48599ED49BA0AD42E0746B3238BE9250D2A470DE8592A7B
      45B9AB0393EDE90CDB2D34A5C2C58032D325EB18AEE356B0E2F1EA92D4F796BA
      C28DEB887E8CC9EA9CF73FC61C3902D0D1D5909EEF85DF541FA52CD15EDE9F95
      65D5B66410F723C4742B3D1A5418ECF9C043FD24DDB35FA3D38DA8026F0BD5EF
      0D134063B1E1E05907D9D35005260C8F5ADCB5336B8E6DB9533767DA46D4740B
      9823F1C6A439BB1B8C3E210DBADC9C091CDC25173459654406F5124E6F0D0309
      AC0434B6FDB9E2C47D7CCE34A2E42464084EE0A7291E36FCC6B6BA1760C56C61
      1AC380B1210E23D1A5A4DE63879C19AC46A265637ED9F732E749B8622D99E79B
      38166801E30E32C08600FCC2E144E0F769EC6A11EA8C297810C2E945BB5B6700
      C2835D02D631EFAE5F7D65EEE1A5E042F63A59EF290E9C1788D64D37026BA1EF
      F4D20F110875D734DD4D18EE48308BC59B20B07DAD911ABB4BB19092144D2CED
      7E105227C8B1A365989A7C2FAAA4324D64C9E5BBDBC694E61913D1A589506D90
      7906F1F930A28D02B6DC02D1ADC7FE02AD266C64A6C184B0889F9516762CC960
      C950017588EBED6B6CF2B446C9096A7BE207BAD0D5FBC887710ACBC54D561147
      1BA208444A280D0D13928F5ED6C211FF5304FCC147B3401CE9BC385BBC142C71
      78238B5AF60CC0C3341DED0E2CB0D7A3E0822BCB1698172818D7543A57A0816C
      0AB8323B499C428EF2093D4EF345BADA90EE5A63D35EEAC2BEC52258B11771E7
      2DB9B4C84AC61798E1EFB459BD26ED5950450C22FA22F2C3EC60637402CFF53C
      A21D42A07D20C029579E49840F02A6FE4D2281129912D0458AEC8C3721231F9D
      092219E51E7B1E3B0B294B12CE9BF5421A38AF04D07AC9ABBD61623536EDA4F2
      0A4D1C061471CF15018A108B556EB292800B50814450215D6F8F3998D26E66F4
      E8C87EA03249DA26857DC4B6C504772AE2B24C91C9F0538806D92E411013DCDE
      74F691D716B656867776DF9A4CEF6E3499DEE1664DA67778E791196626A785E0
      43A3C1E47C5794BE9CC1EA912B955284B508AF7CCC1E9A02D751DC64FFCB81CB
      BEA513A7E32D12820C4D582D597F129E22548AA87B5F34E1D45AAD8A6C151CC8
      0661303B5D0BB72F89C8EF8892C8F305DF455D2D349A851F7A3EA83A688CE5CE
      AE846C7CC2A34425ADFEA0FE8B5F57ABC69378A215A9C057535C19B8978FE9EB
      3E9963A653A41EE33672912B9629E6C61994762D9B7661FB76B553C3982A2D59
      028B7EF19A2B9C89A29F154916B38B1AF694AB9EC7537495329A78B4016193B8
      412478BA885E25A4856DCBC8DC1965F76C53050CB66568DC7A0882A5AB9102FB
      484BE9C765CE2A5A8B67B3406FF67FCDBC31DBC86BB6FB7AB01E71BC388B3DD2
      4AA2E56C08C5E9B595B4A3F4A03A1631CAC3951568ED9994A55C6AD4C652BD3D
      0DF6144A681DAFDB39C9CFA0DD6EEF64674FE38958C79CFA25A07CA14750DCF2
      83556FBBFE5A038E2B985214DEE497161413784D22368DD469E9C09C0093D758
      A6EA5E5CA91581468220BC30151984792E826E87A87E67264EA44184155C2432
      93822822241D411E3448CE8C76973AD8A62975FA0697477B245A622CFF159757
      3B3776DBA51C57F0298566176BFCD7BD7E95F72C270435D8C1F0BF5B83D6CF9F
      05D2CE6C6D3F182CE7BC34B0A0927937989D46DB82F626DBE03A756B4DC50C64
      87D82072EC1C42D4167FB484691A2F84A6ACE8AE1A2C9F064575E374A8B526C9
      41F70CD6491E2CB58523653A7A93BD0E5BB74E55586D4765DB79498E03344AFD
      D83487D3B174B365F36746C300699B576BC0856D6CAEC3DDFE7001ED27240B0B
      046C04A1CDE88ABB8BF1BDC80FE3B3E5973B412835B3B3A3B6B7773EB223CA4E
      13A3C0768EF7BC0B1315A7353ABD3C7FF621FF2C6CCE4E780F1447BF0CD7581A
      B0E213EEE3FED3C279A13FBF269BF9E4F349615004B82B993AF6934E67FE24FD
      2B0F53A373BBA9952CACD37C48C6926B4B2EC6A6F0A1E9F9613C7FF46A7F52F6
      9836F94FF39943986BF4B98E2A58CDD964CE920B979BE96BFA6E9B70A59D7D4D
      D3CA673088CF732E490126E3DA82E213E61EACF2E0069C814018FF160D137ECB
      1E23915FFA1219C868685528720DE2A54B6D7205B8A97E70D4A5AEA3F45896C5
      192409751A6E7A826F2A42DC2C281E514FF04F8B3AFA3AA744ED53770CCDBF10
      D6D902F88F74E294CE94911D6652780DAFE53C990B37F08DFC7E4C9BA65A7070
      D6F7BEF3A9A89EE9720E3927B9D0DD939CEAF367A7D1321E2B5CFAA2365A9C2D
      1B4426389945338D514590E59267CD9B40025814CBAB1C8CAD295B1B4F9683DC
      864059FC5252AC616C327C3DD4A2C07E528B01941B31BDF651D2D8B437053A7B
      F9A3865930E1D33D69CF9F31D2B7F3FE13CF19736F64E92DE1690B48BB6140B6
      E9A4BE2AD13B646D3F68B748E590C46F62200EF546B4F27FE9C95C09F1ED8DCA
      B00B64EF6D5914DBDB3474B0C02B45627730B8B94CA49BEB0A453FB8284959A2
      C73C12D9F8FCD94B8679D82F422FE451934D5AD81C336662748900AFBA8B1377
      A74B5F395F3815AFB0280FE68BBC16DD586ABCCC953FD5491C30990094184FDD
      AF5C7E3028F2E1CAE4FE9B4218AA042C1E5FE936E16637C8811EAD3F69A20355
      1B9FA4018A4B1EF465663B1D139D09C28F32CD2FFC909EC000348D119D73FAA2
      FAAF951D6EE0465654750205BAD0C43F34E746EEDAF0A23E2D643E8E569C0BCE
      C9237CA9D128E6D1728B14F057B2A5F2194023CEF5446CEED46C9DA98FA82D2E
      55D2B40B3E73EDEB23771C6675F06EC798A88A1B336813C7EF3F7633E8F9B31F
      73AEDF8FE2FA15541FE306316E084EB352A9440BE6AAE013AA7CE3C224225837
      CB5B5A089A9E6459C5BB4F547B23529EE4B20223E6A3A287C97C310085154D94
      6641F4D08EEEC05F8C22EAFA6A5CFBA4F68D3819D56EF0F4915A7178FEBD362D
      7EE4EC79A3277EDDA54E15767B9B8215DADD6E952DAE052CCABCA256FB695F27
      88B6E1CE294718271C5AB1B4702B42B1655F049AA6CE1FB1068081C162E6C34E
      215833AA81A098AF51C4F59E5269AF8E5284EA12F3EDC8C367DE4E6EB27C9705
      2AEDCE57A436A18BF2B295FC666982F8A594A13358C02124C3979829B96BB5CB
      79249D93B29AD6EC61DB048913518830882B901F3A7AE952926EE6073727420A
      6EEBBFA6F20A8317C098CC8C399A8C637F947900A210373F56EED50FD47CC21C
      E3352A4BD185982D1B09CCD7F889717FE6DB186E53EB2F9918E41CDB3C14694E
      35525CCF81E19AB2E8010DC3942E2984944D72EDEDD04F5423A1B9E15B35D2EF
      A4DEA4C93E5A97D409D71EB949963882AC2263111813C41C3A6787EA654AF279
      0A6D73F2D92493B2149E6D1054A4C511B7162F4F3A1637241EB6240F71903961
      B5864A0C23AF7D55FB1B29729764B5FFBAAC299FD0DF9CCA6AA80A8CE536C7F2
      D6C79263E2D6D6BBD79399CBDAC80EA396BA26F32AD420479911C22A49753E40
      4E6761973EE5063C6079EF133A6604B5AA933A9A13769313C668B5941302A7E8
      C10E9A9DD6B8260D8B6E826B1C0335900260BC7605233C4CF998D08225A8941A
      131BBC2B3BFF11FEB4A58F80C7B58983187A9AB95815377A362583C0F1DB06CF
      E6AC5F2B7D698BA263F6E0CCA2885ECC5E945C2D10B75DE4C02F8EAF46984732
      AE4CEB459399A4119BEC92FC06D2A07A9160EC08CA345FE0263995B5DE69B8DF
      662CA01272712A21F5C5DACF2A0302ECD045ED5B7FBDFA4D67DA5C0F0C74D076
      4E24A78FCB743C2E3648E981642653B8DE49E6B0E3992B844E6F3B30AEF27192
      AACF2571F0E62C4DAED0B6766365039732AC51C6E6FA25BEC83D530C9FB342F4
      4B29AE8954C09F32820B49E4DF72E20C2C2B09E9EB130EFCB94FDCB25AD3CAF2
      4437CC99DA99A5C2A23297EB85EF6E9077D79034F0CF9544931B5656B9269F4D
      9B22862DFD55F7A9FB2DD3A4B36DD5B0B89C61C2B87C9BE8949DE0962964BD4E
      73CB15BFEC569FCCF53653B50FF5F367EF5286C2882E195B41C7EA881F6357E3
      F5C3096A8C6A3BEFF07DE9320E2976CE1DCAD13D9A98E655C6ED01E3F362773A
      D50C8A19B069F524D534CE18EB26C55D4229CDF44D924BE68AE13D390EA6555B
      D659091781401D333CC4451C01C1E7A0F2D45849ED40D74BB64535334A39DE04
      597BC7EB7643313D9CE82886AB748B247C8A6BF615014E5AE0714851427D8916
      0E311F0373A9B79BE8ADBAA01B43A976634A5264352671C3316B704CAD59C8CF
      04C55192D6C8256C60AE0C2D181D49E7E320768CEE5A7EFF2DB919744016F321
      108C119D857A69A7056D8F46C64DFC6478B599D30F02B4C9C53B9499F13290F2
      1D83D5231855AC6CA1A5AF0BCF13CABFF227B9775BF17A1A587DF77AA8EDFBB1
      9B88E96AC300F1D3358E1FB74240F0102E6EC2A07BAD6471F3243796118A68F1
      D1A347A745F2761B36572DDC082499414A24D5A2E15E765DDF389ACFB9082124
      B717A82A04F99D417B899F65E68A8CCF205F2475056B2672905874045A1648B8
      5CE8138A8C9A2F2298FA2A83C6BC7439F2B80CC17092D38CC9E808AAED316C14
      A75749EBB95D3009EB94EB33905BAA9537ACF1C0DA4805B620A83AEE62A1FB7E
      988374EF4C9BF6E76B22E82950FC219ADB933F8D928D5C0AB687FB916EA3D532
      9FBEE3A6AD5C1ABFE798EFBD609CEC392727C9AE852B9FCEB0751327C96EA0F6
      19EDB57BA7F5F367456A7FEB62AFABBD117667DC1BC3BF8BFBEF7B9551DF00C4
      E5B20CF3F4ACB19E1B49CEF9E2541D3C77B12BFC3858224CA05EC6827FB71128
      955912C0CB72665C23554CC4DA4617DF64F192C94D30E56EAA38FDC00FF71781
      3BE64CD8887AFE82BA952A44F16CC96E4DA4086F77CF790B072695EECD54ADE1
      ABC01318418458E08766CF62A42E828D4E67B87A6A1B0CF653CB43B969A0FC76
      56FB032CEB73BC18CC582A65C7234790908B885069E1AC49CD554B91F3911464
      9E98DD4967B69C22D470CB18E454C2C1E092EE34F45320C82EBA2F3D0B45B439
      B6E5C796D1D675F23012BC39B1B61370038140FC135C093AE0371DEA3CB84C14
      D6EBB213EAE3BA2B7C00E1CB1387BBAF80AEE733E602E908A358B9E78233C650
      CB09173ABC65B7920B04D1A34167647310AA0D2204C61594C4E604643E5064B8
      C84FD958474B4523086BD86BA699EDFB1CCF7CB54DC2FF0E13BF00DB7BA261A9
      DF83B913273BB6579C5B2261DC71F3AD35F4418376CC1DA60851DBCBE350FF3A
      4EF520700CC96FFA05F2C7771E8AAEB11B7C893E9001F00BD05CDFB1E76477E3
      F7F6EFFCB4ADB2A4FAF9A952F6088518FC143DE1B60B5A1BA89413EE69C7DBFA
      039C9671407316326ADABB963B1BB5E31A94C4E4718E14E40204A90DB46D9EB9
      E748670A329C49B72F8C821A61E91C861C5EA914918AB99B32E22CFB937057FA
      7934374C8FE665B5EF00F604A6BD32381661E4E552C1F3E02EF6EB598DE24A31
      6C53B2BA4B4074B0377924B401ADA4F04B05BBFD9B549B2659217C3E469041A7
      EB0B18615B084288B4B19BB91ECD89B648B388236C0ED276547BDA6657A20517
      2E1751D26AA0DC90B0F8B9C42B424C6EBC15BD171890A77D46C39F988349B0D4
      DCE243D65F517042C0CC6A50B13ABD56DC9734BE2DF8CFF367140A77AD5D25FB
      69AF2C108DD7EC4C103620F0FF8921B496CBC5E58649F1EAB9AB5D0D180E634A
      8CBB48565BCB68B3C534D85E84C952C043B23D69A0D49874D8EEC15EBC4BD71A
      B42E64CA1A45EA03010F018E9AD682D18B502F598ED3658CA0E4D272A0450178
      817FC700990566E78A172AC3D993C1C56A0E9222299E5297F70EA1AB2E43D4E3
      D32822B58A909A97C8F675ACDFF9A21B105055CA64991046A0EB80DD621A644A
      AAA82945DFB470EA8ACA2CD970214C4472B7D96B4F9DA232CCF47A89143BB606
      41C7E4448EC90E3E545D61F13D2E8E052DBB832694C3B28316EDBD0289BEC30B
      B8F3FF2E51A93CB56521876A9945E642093A35662B99B2F36AE5BC7213F59996
      70479006C91B328AAEF4A69130B22E05B2724538C2C3ED8538D08CA8D8E68AD6
      770ED9845C6E5F4328BF79FF1E171F9B654C90ED8DF5B3EA775294835C984906
      F0B8E7FC75CFD96702FFC53957ABA4D8E542C225B0369C67FC320876F6CC6F1F
      8165E9F579175EA0466E920E77B609D2634F10C6C3CE58861184C21644ABF924
      40C5BA44419F6E0D606CF108D16218234183134BF222BC0ACF8B948FBA367AA5
      5969531B4A35BC74A1941525CA3C5DBFB750DF49319DAC3C62910B223596C735
      11675098258384EBDE7C6A58D198201B3297CD59D1057976AFA4F556488942E5
      580760478A543F74E5EB07BAC136554422660C5C10E65B2CFDC023B1BAB686A6
      650F86084C5324F61BD098B74845D1205D09C3117B943CB7635EBB43C15CDD5B
      0DB8EE0AA31126100CD20DC8358381D4604D7395559DEAEC12BB8F096BC1762C
      43D29E92881517CEF4811D353E071987021509631C7D01E7BEC04ACC28F50758
      15EA24F24E37DDB61BCF2796139B16C0EC165A254AC7C15A4E6BF92C716D1EF1
      6219668FD3C22C9BE932C1060E3B353D0A96B9B67506D24914537C76AA4249E0
      E1C4D34D53950E9C099D014AC19FA0A7285D861670B5EC226008D4F596DA4B31
      3234A766BA0E7670C33305B6C034266300D3C94C152AFE99F3AF600028F1133E
      78A7A76F1A4E5F3B46B2231A1FF6544F7628270F3F3A3F10627693856908F6A3
      CEF8A34E66B59C3AD2FF997539E07A182DA04EED36CD2D054B53BDEDBC925E6C
      BAB515992D1105E83FBC3CFD02FC7B64B88109F55B8695A486D373296EF10D1E
      2BEC59690351A185B4279607A94F01E60250E21EA2D344CBD854BF2D43B05558
      216CE13125C683BABE62BB0C91BC602221F5B1D9C5737827C8DF0B152D74E5BB
      17A1EF8184A70BEF550B6DA7C1782CBE424C1CDD3CC81F38DB878A67A8AE2897
      495033732C53485726B7475B7FE84890C4156D9402F9ECE5D598F4CC3DB9B11F
      2E2B96F5F3653ED7DA08B8E5CE4BF81B3F20B9BECD80558A550767B558ADB569
      5CB4C95471680444952C336F97B2FAF789299610298CAD64F0E4F58342E71F4B
      D82ABAD1B9992DD9A5F5E65BDF9C8C724930A649A30691B10F1FF53DD993959E
      2FAB4B9C52639B7CCD4C42EBF05C9F96C293A1B9E014EE3F37C20FB3A678B0E6
      B50841398D77979FF3EEEFB024BF008B78377F1DC1423F40824EDBF9110B2F15
      BB27787703CB32B95AD2145049AA25A9479EEEAF10527B05E3BAF022E71CF7D8
      253E81FE122310244CAC516BAA0DA339B670A53069229C969CC3491473C7560A
      B088334CB853534B6C45BF32E94376026EC46AC4B9445244B2CE7756F92BDA05
      F5C36FA7B050993CD81866B32F715A24A010BA7EDD3EDCDD31E28BDBEC69E942
      8566B80BEA37AF294AAA8D23CB5D833EC7CF2250C9A94C5E3DF9E37543AB1CCB
      B66347B4D9C0E95B81397197497506083EA0DF2473FD2203A3EFA8F49073D548
      611025937AE0643A000CE6C26427883736544AE256A34C2743DE4835C5A045A2
      4B846B8E2DC58E33A82F7C326BB990473C7DBBF26D804973D4D99B9A287A5419
      D830C66ACF8406D1673FBF581BD5C9EE88498CF95B4D41DE5A35964D488B4EBA
      18B95047BC55D4806C3213FEE1C8DF9BD30F7BF0CF7B9661EFA3B14BE13E01C9
      452581DDE59CEE16A87C58EF1AC086E6D4941BFDE4BDFCAC26CEAF3FBEFFAFCF
      DF76E87FDDC16FC87D747C346B5A70F607BA57CFFE6CAB2BD51C977522B6A445
      0393B1F2C6EE6057BBB9DD0DD4C66D6D53DC60DC5A550D9C9161B5AA919EB2C0
      086126DE38F234C2BE25A4EA87F8F2EDB76D676E1ABBD229EDB3368A3DE7D56A
      CD274F273DEF656ECE6379A9995EB3B6E76A7048D1289AF36687D3CDB958A358
      B576694771B5BA46499F5C9090436990F8AFCF2227A4E0527637E526351A5ACD
      D6B252897D6290A9A37093D86E36BAA118838097437448E72022ACF626869CEB
      CFAE4C849EE27E2AFA3B93F720C97805B4F0B6A3EB5BE1C59503CCBF7E12A1C7
      0EE5110B1C79631F5691C7D01C924A8AFEFAB38A57BF391BD2911A2F4E8D8AF7
      FC3634EE49D362EFFE8B2BFF812B8986CB58AFE343D457EE4B9A9285676FF0E6
      A20C6379AF90E9662A32A91116DEE24CB3B6EB9BF3C1C759B237A5A2893ABA27
      FE973D8AC53C443C012BAF1ECB6AE8BC6D4A9FE4F49975CAB3CFD174FD4D2CA4
      28CC1A089653184D3BBD4A2545A4466CC706BACAF5E5B012D45A9234EC4F9C93
      2F9FDFA38532538197C73BD86D587915B59987FF8A906DBF717E6AC3C19F2C07
      A790CA4372EE0C2E0F582AFC0894E94B601D6664CB26FC26D11F729D19FE5EAC
      2DA831060A25ADC1E7497EB929EE586B331C062B49DEFD29E40EC1F4DB6BCE9E
      CEDC065215B423B1841D53E993A51AEC64A84D38199DDF5DF6EEF6838469699F
      208D1E70AF6C902B9486C0327ACFF9E9F5E73D1DB479F7E5C30E50EE1F4B4AFE
      AECEF84137CE82FD4C7D4AFB4C8AEA82406C982C0ADEB998428795539C55C75B
      62E273B464E7D5A7D3D317EF3F7DFA6232F8617898BA994BE4AFEDAF629ECB61
      2ACEDECF433E2EE310ADA389B3738AA63BEE42D957186753A1C902A11A6A309E
      320C4AE3FC02BA695C9C71340DD147BDCBE5A10A4CAFEA5CC5770EC6F31D0CE8
      3BEFBE993B14D39762031C85CEBDD1E5E3A030C54898DDAC4AA291BAE595FFB1
      3BFD26FCE63556BFC3AA5DCEA29C4FB5C14B2883955A8348D029BCC52CEC5277
      438ED6984C66A316CE3884D4B235508EE200CBDAD530D0DA571152115B545DCB
      37BBDF9E924FF4507C742F9C3926A5FB56FA48B3FB33D1F91614892F6F4E0F5E
      9C9EBE61488F4F833D4CAB7749D352DE54F787C28F080C70CE3220648B575709
      803405BD4537078A15216A6A271B0967F34C912C363C271611536A6728EBB587
      7821A13C2F7B35220F534ABAA7AEB2B457BC664E6D9CFC09A95669DB697DD6A9
      EA20F06A51222F15D9398062136B912693F62EC2F1E3604EFE4E01603ADAEEC8
      A72CF864B69C80558D3A6A1C2D75E594DDF6B700A85998914CF752BA530379B1
      221713313879CCCE41CDDD9EE82C5F2E1806A13C01894F59F47E88C59C9C8E19
      5AE2FCE3CB9F3FB028A7740E6D90D4A051350092E381B28B55E9538CCB51469C
      B71C5BD51B5C6B0FCAC604615C603452458B4A40FDF4DDCD9B764C88B37EC205
      0C5835E78F85E2B2F512CDD5B182D0D3EE65BC12B6D338820503ED2CE59EBE3A
      CE685DC134AC3DCACFEB7510590045F811A70A52A633F0228EFA9B7A9ECA37CC
      F5D9D4C7668B14E8CD8546EC78279C11A0CE97FC91255AD2F6698DA274962564
      A7C5EBE07C50BD2DFCB4D886B512CC5876F195BF2FE78B2CD5DD94C3CB75567E
      F19E83BC94B1B969D602DCD388C11A250ED13476B1807F9912329238206805E3
      1A8D679B30EC7A253FEE53F11CE299151BD0607CF8C26FA44308DE81988A59AD
      2C2DC99EF5259642F0F346ABACAD355EFCEBFFF9CD54F1837A4F94C114FF90DC
      CABA8C415653600FF4734D6311795F2E87427A15D399C2AB3EFD1D4DE7B45803
      996C9BE654CDBB426E2808EF59106698B72474228D6A19EA019B3DBB77CDAC90
      CE66F65C0A63D02F19450355763F5C36B9D6B5928535787B1A61AE7073F20B80
      FD3671B2045F3C8270F83D3CF7367CA4F303685B6F129D23255F5243A177AFE1
      8F532C64FD3233F9C588C685BAE22E9CBF34DD42E178679534C560EA984AB1C0
      A50ACA80EC50D234DD710C521FD3BB73BDC29B3371CD99A054336CEB96BACE82
      12D3A95CB73921F90CDA1D8B42E4CB346D6EA5A28CF9BBC0ADE6803E483DD602
      1436FF2541DC5C465C9919910793BC237862C4E3BD95BE0B76165888947A8B3E
      7A1E003E9C6C919D0F0AF123095C028E620D3D003DF46DE7DD84AA7938CFBD38
      5A3B4001D20ACC21AE723434926EA059E9776118140510D42446508E8D6FC9DE
      8C061383935F64105A50DA2D7D19B4492B143D18D8C68BEB5790EBF6A2B97949
      1937C8DF3A35B5811B73B1A4F4AEB0596C5B3A9AD95023C0CCEC511B32333881
      5EDC6B0F6DC6B9DDE43C1168875081E55DA407F928AC75E4A4A4B949F4616781
      C64EB25EB635EBA6AD40C5232EBB1B7529A80CAB062579E46637782E0C8679FF
      9EB5C9AC665314398159B5615B90C566BA7CB7BE73DE90D0380571812D557E92
      BE716E685D454717CCF1C1F76A7C8ED984296F734FB7C1D4D40091B65DFE2D50
      C01755DA228F49DAB0A7432BA4D25944B9C0EB1B886A58C91E17A0F45A60CEBA
      1B78507244886E5898ED4B663F960FE82B75AB3C99856C9C90D2FAA79CB3CCD1
      412F373E5D98ED9B6860AB30CF58A745805E211E1714E219C79C311FCA94101E
      0817017B59079D9BEC545A18AA0B4AD658102936DBB0F6D93AC3BC01FF615706
      BE6E3E672C427AE51A834C0442085742DC5E0C722F29429A8D6D8199F2DE3823
      8A6AA1AD73590B404A195649B11A56F982CD7A5A0DB81295111306E223EC7FEA
      8684772682A9401B86E2CBB5A4CF8B5ABE158BB3584D3516A2A412D78774468C
      1A10B946688226FC9256053EBCE238A9EB103DD31F71782F5FB5F99A291C359D
      B88C57E1132E715604B232C5182602C660028F7D37D67F63CBFBEAA16D3B1591
      2F7962DADB1B590731098B3170E7D29722F8411A631A88EC48EA0601DCED5BB9
      E4353E97A7B127E4C913667B7F9F72131F71252DB7DF1465451C2DA7B3DCC905
      AE66BDDF6971559F0106B8E6A43350580D1E2B1C4118AD5EDB02A5749459512B
      C2FDD16ADF205D106B664C6FEE7BFB72CF14AC16BFD7A23BFBBEB0C77E41D73B
      F5D390445EDCE245A665366B6E6988FB4B5DA3F4918C99CD53830E62B9362DD1
      D70A2FAFA15157F388ADF7C2F56A11C1ED611DA88D57B78C11DF017584056643
      20E25ECC4A861620F89796F40A8143482B247BBAC85E77A53ED406C523948185
      665A06D2151FBB9D6CC2EC890CDC1D9E3D5906B8D6D83688B85C9CE1B29238CD
      BDAB168A2A3D83783D082FDDC037471A31F24D40CAAAD04D75F5BF5655910CDF
      A48C2D104D1572DC361614D1C6D382BFF074A2BCA17BC251379B9C22FF38F246
      289EF2E82CD92C4F63A7F5C1350806EC6AA30513FD5A2401BDF24E006038B427
      743449A936EF4C94453F5120B3126451BA25D2E8B59BBCCC4A926B051F0E04E6
      2C19A4380B422753EB1B97468E6C1AFBD510CD4D0A04B3D088D0CF00E708C481
      62DD044F585D26A65FE7169F6F945A6A06A49037207C884A907BD4689D2B395B
      7BC27C4D7163B2F439ACAEEB8B138E07E42C37471094115D00DF679857668D19
      9313C7D778142BD7E315055A28A68FAD1E9C1F54B0D8733EAAAB65023A06ECA1
      EFFDF487E5680F134751BFDA435103A23E56181D71A7AA496459A36519BA7A21
      68666C23C41ABEF4432FBAD4CBA0D3ADFF3843605FC4A822EA9E119EB390D829
      CEAF30B3DAA9B5347E984C7E5634D909FCF99BD1E1191CCD3F372CF0C4DFEF0F
      71150E7B5BAC34CCEDF731CD0BB67A7A85F7D658FB20E90E366E00BCFF7EB640
      75FD301C1E671FEC5E6A5D32C3DF909DE510501FD392D6D0320D27807961E029
      FB1D0F7F363D306C686DC4E186E85264C44CC56BA9ACA67E0663335E86E48877
      93274A1D668E401A32DA48A146FD77E28B911760224F0A420C8442B4A0EE3A96
      55A90997E5A9C4947C0D444AACDE9E4F8A26222664B7F09AD720A4BE2D51F105
      5A1E9F951BEC93C930A6E602E4D323E59F1FC980F968000B6D1151CA79834566
      98C8EA13491102F94912F1F9332D61F79D37C19C1209E2973F7D93E424AFC55B
      9CFF42344DD10B1987182C92654A90A049226DC7B21CFB289C46D4866989809A
      B9FDA9F765A33B552E13072204811F1685B941A30F15014E2B2F44E697AB14D1
      C861BABDC1C6B05881E035A339EC9E3039B5992762E7350185652F14E6CEEEC0
      1B605A63E303ED97A63379E1FA0127DABACE08314431C3097B7A68D73C676911
      EE2C0D494620C95091D47F3627B33AD550D864ACE63E51D326777340B33C89DC
      36347982D84500C61C90B1821B51D39377E2362700EF96FD4BFD9C7D6A862E9E
      4F7AAB84BFCC39FCF5EA378E4964E0C8697638085157F801F5B3D9AE0D0C567C
      913B21C60315233860141B4CB5427F14E934930DD5B7722C1601660F93CB58A8
      53ED8FC417EA1C6378334519E0FE4CA7467FAA8AE76EC8FA717100B5E72A70B1
      BA34426B0628F299295B12BFEDBC652D8039556245DF2FA4BB999F5079503676
      0536AA495D27E640598EA27F98D02EE8FD942B8131D165E8A7AB8675D5C0E9A1
      1A2C982A9C07349C1A074BEE08DBF4A93E714440A7C5E1333A4B17BE5BC039DF
      507CB76BF97030743603A26D1190453C541E67A211E5410EF9F3E55CD6150ECB
      CC0D24AF47EA2EE44F399409E98754FFC55AC5309D8BA44AAA71286D72281D3C
      7687D2F367A77A77ECD3AE1ACBAED208F73E5B76D7ECA1EA33A237599EF5882C
      345E1DD3119202EEDCCE8BB235A471040561B3501947E31FE1AEAB538EE8532F
      34F161A47E1A98D2D8960DEAB5CBC928EB87582775CE25D11436E0984C002A50
      64C10E9B6E44280AEE1C1B39B9D9E2EADE09F4C2C4FFA75A437FA85E53B36C52
      BC28EE65CA50C2473EE195F9829C9B97C630D3D4102CD90095A16941F939DC93
      92D87FE68834BD2881E0639001616E0DE835CC4A4DDE4FEE0D8CCD43E989566D
      C793A22D52F6748E2940FB981332C21A4471531AA25391239F0DA04FAD1AA5AF
      BC48EF74EA6B8A1D59F48BACB3442D58956039818C50646D5B03CACAEDC9E628
      DEBAD02D48CB79006E8B451C917E1D31AE46328B97E1B993447792A4601AA9EA
      81217DAC3E3BD74DEB2EF671A3AC97077C700DC2282B2AC623A2E68B14246474
      D968EE79E3BB825A45335C85D4E7F5856EF89A6FC1B7D6A808B67B3562E61A3A
      79CD4A42AAD66894E84D4AF4F0F12BD12026E6DC4EDD0DC99391F59864046FD8
      62D4491221BAB0360576A32E90D300A0A411829A972E2973F9950AFD6998FD35
      C2CA10744F23779DF99EA7C227A90710B148C5374067A5C4D2B9B8DCDD6D86A7
      5B536F77CF3AD84413BE9729A34B639F2E85749EFDA9E9639C7553A8B9833EC0
      B1F211EE0361C26CAE78CD566A447179B1C1423709F314EC4ED670080D99909A
      739A8DC9336FF0AF2BFB90884CDE799DA7EACF86AA9B80B13354538D19335A91
      637F9EA8F14EB17789F35AFA1E328F38E86C976B2D886DACE3D3B8C8013DA158
      03D5F373E37B44C0CDF6401D443FBB1C61D3345BAA3D6DE3D46651608A02C160
      49E0082F171C5FB80CB1F7FA2EB77704129ADEBA1C1714E58587AD13C28DFBC6
      9D474B8EC9632E44FDDA16954A923B9E878E8E233085B2EE9B943E11594833F9
      568C3445DF7440A0E1614E8F2912635A52A513D1A9E15235B914F6497A19A0FE
      E0E2BFE4B08567C1F952D2E5AA29E62E614315642B632D0C5A152FEB9F214BEF
      DFAB51B2152692918DE349843380E4E7DE95C9AE89F1D3D0B78A25C0F5949943
      D9DFA9EE35F83F6A3F20E14A5917B1C5F64C3F732ABE580826A83ED1A4B1F428
      E411FB183909A208E3B502CDE26738C0E5FB32DB7BE9D5315807E955F7A8DF83
      1FBDC3C111FCE80F8703F8313838EAC08F83C1315E321C74F192C37E0F2F39EA
      0D067C375E021BFC901ED3393EC68BBADDE30E5ED5EDC175F8B37F38A0EB06C3
      83E1D7DDF030FBAF0F79FCD2715EE1FF1717B8EC7AB8F8C4715ED6BDFCA4612D
      C61D400ABA3960FAB4DB5D99F10034DBFF5EB7FF16FB1EFFBFEEE5FCBFFAC7C4
      694E4A1EEC10EEAAAE135D111824766CA21ACC96060CCB1CE8CE774EDE814E67
      8DC2E4F78E2EFFFC598BE5F6EEFDB7B68E1E004DBF25DA074C1716FD9E27CCC5
      30129064BD0D33CE586F22BCC99C66D45811D704EB4C1301321CBF34BE8B35E8
      89CCAC4EDDD11E43F2AF47FC6295B5801CB952972C3D1AA22D936FDE61A7651B
      D0409E0396FFC73A30AA688FBFC025C502FEADD21AE545597AC6B9520BDD620C
      A387829620C84C78B1D8F38C4290AB4161EE8DDE4DF4A9B80C78436D83A48E2D
      8EA2FA99885F348DD1F36E5C74343E7296CCFCC08337ED394835306B124648E0
      D77F9398AFD107C213A276DC1686F936E0745F227148C1E4C7CBA44E8B35C94A
      3D572BEE9AB74C9A38D0C638D0E1638F036157BD8F2868FE93B63E1DCBB9393C
      D8EBC17478784C2B5B3DAF34F8EBCF7A4AC43CF2737A7A337A134A4B338465FE
      D6ACD4FE7F6816099FCC5CE1F3CF1BDA4A3CA9099FB0CFF87574197ECBDE6B3D
      E7925545E26C9A75A334958B670D763E4641C7FC9F9052C9531EE6C959C3D0FF
      EFA24A31ECE107549F7E5ABCC02DEAB430EF62D7792148EDBC79CD1FB5A8DC65
      094D849656A5B114102429A81346B632209CF870EB3B46695C2F3D2F1BCEBB30
      51718A23A8BCBB6488232CEC70C7192E3F1B2D7A6C9B6BC8AC2232EDA67E4B8F
      0CD525A5B6598F48F456DB715A5EC1375D1F598DE7EE61979DAA09E0458B75F2
      368CA2AA0223C10A1874086230DF09DC910A92353ED1B009DB0EB108D5CA4060
      B59FC7B76DB25C0B659E5ABE2186CE59648C2E9304AABB9ED096BF0D26578CFB
      1251FB1095CB4A782DFA8443EBE8F260D2D54230375140732D5462CA4874EFE5
      2442E94D25EBCDD1AB7DF4663530FBA7645C27D1321E730D3CB5811FFB2921EC
      13CCA9C602143CFF9D5F5F83C1F91BF740870DA4E35B2F30B28888410D7CF65A
      E8534AB01951B948C0568E824CED5D434984B08933D4B622A62C06314D29A178
      26B8DCC9258C1CAE27A44EC71247759D9337EFDFEB9C67D7F9E5F3FBD74E5407
      86182EFEFCE6EDE7EC567CD0AE6EADA610CEDA8D573927091C58BD7D30016B7D
      731157AB5F8A192BCCB64872F8B206C4C2D3D5190C482E5495AC9064D3DBCDD8
      123902F51B16A15D81AE2E0CF9EADAFC2030D91FBAA6084B7F11B5C48C4627DE
      5767AA0BD011766F4C1939AC6598BA8FEE1C698ABA4B5D320B1368F86229612D
      3076A660C3AC2C979EAE3BDE9917C994A13680444F574E0BC50503589A3C2C86
      DDD7A812C804E288B03A4FFEBE4BD89AC8E232E4CC5CF72C16ECCABB4F73F189
      6EE19D77E1EFC0F2A95F5662AF51237BAF25530D296753D269199811AD70178B
      2504D311BDE9FA920DC98D12971577395EC49D637481D54723F84D3F417A6C1A
      198142BDBD7EE7FC687D69EB3B2356F4573A23C9D598DE59BF58F35446CC2580
      59302FA860723CA65679D33A54ADA662A4A7B788D5C4BFDA02E47C61CABEFC62
      002805D5825B6E2802B6A2F97C1A2149E04D6422A13284D095D2A891AD0997B0
      66E3546787F2D076B53ACB800C5AC7DACE08A27C4F7C29F7748451AF549A3595
      CD565464392F09F7B2263CD04C6962EB0EFE5C1F1BF917EEA5FC2D47ADAA5BBE
      496B0CDA891F3F7D7104D9D90D5759B74E060B250D6E2EE88A59B04B16957FF3
      E3ACE76DD3B0AF062F12AD7F5C309B9C16E3B1C1AF97B18FC988BB8D15B54EBD
      752AED642D547389D8BABF0AC1D99693DDD8575B43517DB41AD2B8190E7886AF
      A347A93857949A934C7359A106C83B77A444D7DF161168236D2E5CECB7496C06
      2D235D91BB3E9EDCABA5270B6C832961E663198D1FCF59984927432A0A191309
      27169B13246194533C921AB2D64F535D1D2E0F2794FAA9AF5B918C6791CF5D65
      77FE4B25BA91EA0EC9819D8F91F9625B9289BF232BC65AEFE0A229B6910636B8
      530531C4D26C59CB9327389535C96DEBC3D8055956AFBA42552C6D3624E91AB3
      A5839CB50F023A2C6A9D7BD4DE32E7E3C053B715AFE3481D6548E4DD16B9A65B
      7BD2372290A144DC15C54F8D352C5917326B59457D430D4E431BDC3AC130A002
      5D192A53FA6C66AF4AB432A7AF5A5F4C4D7986B4F859ACA413B192D8B8CFDB58
      F0C893BFE388D81A739D45B09CFAA14D7C53E13B5F0676A7934616974B13AA38
      14C300FB37221F7973FABE11B879FDD688B69490E50B964A7592229D76A3A2FF
      87F33FDFBE7DCBBD8080F1CF171CACCB8CA239E3DE4CC068CAEEFAF7EFE8B6B6
      69A836018B2CDF6B228DF02C801A1BAE9B515B369E2AE8D48DCAFCA0C7F4B3A2
      F6E39517C6D9410621D268CE1BAB3AD16F8E08C65A9899DD9DC053A96F0418DC
      C60D67C5EFAE7536B12A56C64F1FF1B9AB91E1560DB5EBF42D67268D16D542E0
      61982E45FA003527352E1B27C1523B0488C4C2BA09C228586A13EB8FB4E5E306
      32A6CEE6FE5E852A064DE99F8AB25C617D4905C4EDF7E9E3CB0F2625E9A9B083
      5B962C58142B2B5AD87FEB5FFD888A271CE070ACEEBD52E3C55D9769D499F3C7
      E881678D4CF22126CEB50D7814FEFB2CF483CDD8E6408214EA4C994161E29A15
      49608F3E8807CAD4A9D34C19E4D89C3B470B4E3E753E9CBF39FDE04F1A20E05A
      696881BBE058C247AA7C30C9676ED364C0726D0A69EC7A1FDAC882BCFBEBFE6F
      4EB29A8FA240D23CF220DF6326335B73F55BAECAE2A03F2706056F019B9BDD48
      029AC4D1B5C449D228CE5A8B9A4C32B228178BC057D2C194B13F6078193C15D9
      8F7377251EC63A6DB7B1D96F3C8DD047990767C1A161098F81E616E50EC7318E
      48951BB9E3736A5813B79D16C78A24B54DFC843278871C4768F152D55E18A5BA
      999B950AA7AE5C4AEFE13FE83B39ED06DFE9A3032C036B009397014FF881A68F
      62BD54258DBEA263F70CF74258F35A47C54D80B8F17184702A3528A93DF29EDA
      D3E988BC4DF4727383F3E202536E201C283F24DC079B71E29FDF0821ECE54707
      0268E16FF4D6A04BDDD47A0ABA9BD164506E9898E2744CF495B0A2B7B6D6BA81
      65118F779B62369C9C1DCCA4E364E628F4A84149BBEB381F14A08AE75FF8DE12
      4C227D22A8AF5CFE157CB17DBB59840D0F68F35EC88E223C6F9C9D52979FD9B2
      C07A64BBECF2B305C59721795C4A8B5A7B87591B7A1683E92AAAC5A0A2B4FC33
      641E3558587D5FCFF367EF08D9C4D7857466934BFA29ECF33DA993B33BE86AC2
      7919B7C266C2D8856039B2CF8A4E1A57898FBB1A137A293F9672713B1CB2B6C1
      5029918BE3F1C94650340935631AB5A0C5B9410C2762C5D8C9F6FB9DF55AF190
      A3E81CDB49A2B84EA89FF6FF2A4BC615E100AB06B3D96D148F6A898AC922ECCC
      74D821F116F9E90FB06A4DE25901D2344FAB1DC3E0B54F27239CAE33CED0137D
      ECB679B51D2011D67E31B217C194882E234CE83F4996E4107DF12F5C2D666776
      E61617FFF0819BEFFED5E936C7A346F17DB6A6A89157F37741CACBD2AE12E190
      CD69CA24DB175B7F37F83BE49C2C1EA54B2DB0B3B8AB95D29618F25E93DE26A5
      5CA6FFB0ADE930AE5D0EFD8F3DB7A888102090F440CE8D49B2D8749035D2CA8E
      72C73333BC3ADA000D8166B0F6129C6023C1EA977A4EC04821BB4632E7485331
      99730D3EB7A1D8EB8DF4017579E9B3B21C2B3224C66400C5B8A7C53184910097
      61E4B83E19AEDE73DAED36D756CE3159708AEDB9A7D9A116CB7C2749F19B5FCD
      0B7FA3F08CBEC5E0C584911452E9BF88DD58CB09052F9E0AD845B703E70AB47E
      4987E032321CBD56D761D74C41A54FEC69691E221D34C62E57781AD35577FE40
      87FED6F5680447CDAD3825A64C756511E3FD1757037D0159FA394CE442C569D6
      5F1A43C9C90AECCD39E674366CA23A14E3CED57B3F3C775E386F3F0DB020067F
      6B984286BC699145A7F1E0417AFBFFB7F76D4D6EDC589AEF8AD07FE0E8C5D26C
      AD9D896BA21DF320D9EEB66264D963C9DDB1B1330F485C248EAAC81AB2CA9262
      A2FFFB7E07C84C66924C56262D5B3BD14585AA8A2480040ECEE53BC0C18178F5
      5D8B67972B7779EB67F0FEF3C6876EC382B629FE39196B30329E9803A69A47E7
      25169B736B6E775188E96EE0E68337F66ACA3AC4C55E20E32EECBA09B95A1EAC
      7924CF95FCF98E554EDF41F0E8277BF3F651CA24D440044228CD97ED912BD223
      D3C3CB49E5B6DDF017A40E6D4F191F013B74E9DF3A47FFD3E5DB83A35E43E7A0
      17DBDF01AF2991F284C932156CBBB0344FF375BBE583DBC073D6F96ECF21311A
      7103859EE7EDF2BA350A37AD45A011EECE1FA47B0CEF15DFD43DE87611B8BF5E
      9991D36E913A2E3FDCDF40D85789971439B9C8110F298EF328C57A76FACAFAD0
      A5CEDA27386DFC4F88152234D09C7203F7BF991514F27C9523CD9C6D2E2BDB86
      2E0CBD09B0A54B60DFF7236E6E57D4D337AB14A5F0FCF50F69953AAD23B6193C
      7ADFD349D45BF838AB196AED69DE665C3AA84FEACC727BB58354BD8375CDEA38
      39824D4E7390BC61A1C1F2DE31DA5E2CB6EB66BD960E0E358B25134CC5E11ACA
      FB3614BD59DFD95F086EB24D1FC93380C160D628AE3DE54FDFA512680E3475A3
      69969DEB8F74076BB3A253ECCEEB009752A9744A1A035FFA3CFC4F43F14EAB66
      5A3F022D6F3774FFEBA323646D86B99AB28DF23EB7B85DFCF587A7DF2E7EDA10
      9ABD499B5E31D3EED1AB9BCDADBB79446EC5A3A7292924BE6A3F4CFB733944EA
      2A90C435D153B4CA9C6F029ED4CE0565E3A7D16DEAE5CD86CE2E65F9CD59E542
      0E2E4B4A9C36BD669C677A7ED3C2A0016AA09C3434E0278B576EB3BC6E14436F
      F4FDA5855F9E2F1EDFF9A01AE68E72DDA4AD0C4ADBBFB16FBE587D41C95DEE97
      B4EF56DBBF24D4463868BD79FE6DCACD7869DF64CD66538020843245B0DF9BBA
      9EDD78FDDD2BF9D52B60FD06907FF5E71FB55A7CF7EDF3D72DDBF70E0C907DD9
      25CDB9688F8974D7DA5C6F96EB4D7340C05DFFD89CAF98011CBB2DD0BC8DDF9E
      A4CA96353D9D54E82AE1DA0D20739B11B30E7BD60A9DBAFBEA605801B4FFE5E2
      199D4CBD193A1E794BB863A7BCAE415763641B992FDDCE0AB559EA482BEF9B1D
      31F2A265BA8FEA5177D4A45D426C4B4D8F457DDA3942746D1ADCAA94E6D442F1
      B49DA450F8F77433413B536091DD5C2562768E4D4BCA7D42A67589141DBA7B9A
      9D7240998C40C6F1FB94CC0DA77B47B29BB25AA7650F4AFF470318C42AA4F512
      C8ECBDC29BB64991A32A5C730C0CFEE35789E4143F0DAEBCD774FDE4E6D991DC
      A1B27C0823AFDB8FD0112A703F606F39D6DFE5A78CDA831C4E8A14C4D03F65AC
      E02E622A87D9F48EAD3F264B91B7472880E8497FCD6127D18363F0BBA0FEBB59
      F55EE0EFB600191BD2E13B4A95F498E6E2E71F098262C6285F525E55DBAD1C3D
      A6BC48178BA7DF7CFF735EAEBF58BC78FA12C57EFACBCF4DE1974FFFFA03554F
      2DFEBAB41D5C5DA7BC8B8F9FF41672305177F63163E127F78AA707B132492FDA
      8C54473C89E17C12A5216CA29BD7DE8A64737E9C2AD1A2E40CD7B03923DCC2A5
      EEA070BE892C1D94CD81E8E976423A08B74E6ED4FF5A7CB8587C9C95AA7C7050
      669724701BEC86F649E97474EFC4771E3C1DCA5DE618A3C161F80C57EE7C6E5E
      61CC8A86B693DA0C164F1297A765C7BCCB347C6CB35E10D7B72BDF2C9FE6ABA8
      5621E13CC22773D6BDBB194E5159FBD37C54F8DA9381AD100EFDC6E999BF4055
      6A3FBBA178C4E271DA9586B668F22BA68DA8CB8F2D5C1DDEFC89D9CF79D312EE
      BDDB5024743732A183B8D3FDFC06BDB9215AF5D7816C3E2243DD98BEF495EFF0
      6ABCE653BA2F9FE2DCF1753AB1B56C9E7791CE6AA7D50F4817E66DD9AE5D37AB
      34890BD1CD4DE8D685A8DE796BE2F910352D291197D85FEF3EA8D1AC97E7C085
      B4DAD067938EF27FF86523C9447C8E8B46AE02FCA8FB43E5139645DADB3C9B45
      B64EF5818D77D292838B5BC1BCB7DE3BBF36EB97938A651542D6DFCD7D9FE9C8
      6A8FDC4D9ACB4EABE4650D7FD137B969ADAAFB2235DBBFA28C56AF363903559B
      C27177C2B3B9F7842E2359A5E8DF6CB6B25F9D36D592AACA3A28A99CBC7FD1D7
      D9F5ED9BC6331AAC134C096D9EB246DC8C3CAD38EC54F08EA87E994322AEDA1B
      5C765FB5CA376F4BF46A67DC904C5A172CD666B3A115904C4CAADFA33319A514
      2DF4BED9584E99E29BEB4F2F7661E82D62D8D130156C039B13DDA8028105FA86
      EE56D9E4545F0D68E8CBD4042ADE9D141760E65EDFDD0D74DB7D9DDD3DC6B401
      70E4665FA06C0A726AC3ECB7691FE196F64C9B75C77B35D847F5C748D8E9A7C7
      095CD3FE1710EFE5724B1982863B6C8D6E04A121DA29F09196710F899E615AB3
      34D3BFC894B46C3E86B1CA49EDFA273F2806B33B153265B992745BBA7F68106F
      39E570462FDB318536347994EC36FB0D9B0EEAE61C42BBB110B46D928BE3E17F
      493661B716B56BB149ED3F089B688F73ECEEAD4C31B368810E1F592AF3E5E2F1
      B37C749F8AD841E6E3DE09B81DA53288CDB6A939F43FCC14F51EBDB89D6200A6
      1FE5A208E065AB9AF73651C13E4B171A98FB26A4D08F2E98C71E956AFA26BB71
      3B63DB37D56984448BABBCF5433E06D9CAE61C513270EBBE691A04DDB40664EF
      DCE1C558B871DF5A3793D28636A7189A1826D0323F1DDE28459E138E20AECA96
      2E1F79A36BB57A81396D7F278443DF5B8F49B95D08823C6AC9F836C7641F8B03
      BB3FA67BF4B44C4BC0FEB2E1444AB6A7C7DEA6BCB261D5E6256B9BB8B6748144
      709620F094E3E937E986065A65DE766DA538DFB7143CD7E8FFAC01F74FBF0F4E
      C8B5B9EF9BFD5080E7BCBAB10B644B810AF7F275E79CBCF8F1DBBF60621BBC7D
      2F3A2D5DFE6A37E902814C9863A1650DE5AE08ADD046F9EA1D857685ED7AF54F
      F76C7717795FBD4D710CEB8C1CAED7CBC613F490EC2BDAB24A27BD81DBD69B7B
      D4DFBB91201DC5D8EE80CD94D0BABCB1D0A86CDA7188E994F666737B4DF8646F
      169AF8BEC71DDEA455E097F6E50075D976719EACC772759B04C2D3FD3039E2A0
      7F08A5F7E074FDC7FBE969BE8F8E370FA78B0D241659AC1D85CEB5078E864C44
      912FCDDB5D4AF49957A952E8DBBB153D374EB072876C7DC8D42D59D660B625A5
      297B46007BEB6D8EF04847DF72C6DB6853E8470ECB809D6DEA539732295A80DB
      584BB87BD94759BE59A52C09B6CB21D6C53552484F0E8481CF77932E76A57379
      54A6DEACDF6528BE6A1C972F17FF677D9B8DF0BBB49352930798C246DEDF5BD8
      BBF743D69B74CA3F9D5AFE210554DEBD9AFED5EE0A9B5C2509EDCFBFAC8883F2
      FD3C4F2F97298A6EF16FBFBC7A7DBFBF3BD877DB8BF8DD3B6342A4DC25E94891
      AC2437B7757FEB2FA99496D42F5EBD5EFCCBE2E7CEB9CBB4FF754B5F7DF30A5F
      516A9A90E175FFBB17F4DD8B75136291BE7932B2EBBC856B0DA8DD2611497077
      19278CB719467371766F67BAC7704D28EC90A3DA1A233756D0670DC3DDDFA536
      D95D7D7A7D0DD59B2390D3C1CA361378EFC4C2BDACF60EBBF5AED7DD8B8CDFDD
      1E9FB758DBECDCEB7C77E0BA5E7F68B650FA77F426A870B9BCC29FB43BBCDC9D
      5598182BD3359EB4C06AFC36F745121718D046C9B43944297DE897DDADD6D3F6
      CB077B3CDDD2511EF745BBEDD12C3FB6E43848E474319285DE6EDF75F9A4F60E
      A1109EB2BF76F7AB2D1EBF6AD1835F6E1DD893AEEE6DAAEC8EAA4C4770CD76DD
      CD2E733FADE35DAEB7CDB1BADF7958FD01E55CEDEB9BBD48B8E6A9FDC1355382
      5EB64BD98499B629C7C0451BA898536735B5D379C936B68642558865BED82EA6
      2C307E08EE764E484BEA5CEE0C058DE40E7447AB694572B027B625F2D106DB6D
      9367BF8D374A7E6C030CF72F1DA066EEB5FDDD5E6C227E42CFFF03D5FBEF9F67
      133471014E59A0B0949C96F279FC61B925B97A6C03C54BFF69F1FC7D4D7F7C0D
      79CE45E81DE9D03FD166144AE29B57EBCD4DFE72FBA7C5B3F5FA92FC977F59BC
      A6FB9BBFFEC313783E7C90D05B93EC1E1EE6F58404591464B4A89BAE5FB71940
      8FDC479DFEB8DDACD21DD7BB6D962D48D0ECB2743758A4FB369A50ABCF9046F5
      C8F46E8F4C6B3771AF5FA5F9DC7E9E29431F7380419B73BB25239DEE6BFA98F6
      3AD300BEA423F32DCD535AC6BCF49C4234F2F5A00B976F215974DC79F766D276
      70056AA762FFE828B1DDCC3D0B801D3957EC63DB24D24A93D7FCFDE9E76A825E
      FD5DF220CF20CA772BFFDB49F2890F02EC655025BC42A0A9D9B9A5BDDA36943F
      DF6EB0A86FEB9A729AA763986FD3D9A4D0E0656AEBEDED9B40FBA1D721AFF2A5
      20192AFE55463729F6379DBB868AA1A39DB3D258F67B7B777AFCE53B424CCBED
      841B3D77E6F1E68329157E961567F8C5B4A8F08B2B25F04BC8AAC02F290C1551
      A2A4229A332A523121726D2A021BAC5333853154A82C4D41A54A8672F49B6B91
      CA0925D5EF6B9331FADF9FCB7FB59BFD791C2BBAE89D9E4D02F04D7B59F3D753
      9BA849BD4C7FDE575FC1679E5EBCAFBC765D7D32B9770BBA2C727A61EA5F0EF4
      077737CFFBD8799910CA5D1FA6371A97298A704E2F76EAE9BC4187959F5CBA57
      F61ED0F64C04D04DBA3AE43B5A8DFFE66D70EF5EACDDBB3F1ED84C3795C91EFD
      0EC6F29012BFAC2E3F0B2D00F2F6ACA45F6E53344073CD8BA3DE915DCBCBBA29
      0C6BEF3844174AB68B046B2E016C1680B6294FC7767DF96B6A99369F2832EAFD
      321DEFCD4922DAEB6DDA6839BA8A6A97C1E8BA1736FA398E07FC6DBDB9F4AFAE
      AD0B178B2F2892E9FFFEF41F5F5C6467EA7380BDF5E7A7C3DD4A3313AABC90F3
      48F5FB8240B245369D0CDC84E432F602C89F8C9E1F7B4FE3DED2B89BF34D1413
      F9B7EEC3CFC69B0DBCA643AC7FA54DE8CFA54B0FCECEFC41037F69292FC0E719
      7AB3A4D1A42B0087BCCBA9C02EED9B2DE536A75CEBE972CFBCDC9A0E470C0262
      E95456738FC004B860097B6F2F9934F879053CF0E960C2E12EC6DEA1F04C2BCD
      8C31BC5AEC98FD9FFF1D23BB0AC05576210B5117BC10A5288A42E17F55A41703
      C009C68722D631C6FC59E90A967EF3FC5ED682ABA8822687013F6594421B5D28
      A9B9F42CE84A79E5AC33A5AB45709C17658142705FA2AB7890CC0BFBF0817135
      C3C32B2683A998D35570DA32ED5CE12A382AA254CEF8AA66564B89CE68E13C93
      42305BB1A254CA31E70DE7519BC0EBC035AB7D190B5D4BC74D659CD5C2DA1899
      600C8F0975590B2DBD953EC2DB89DE58FFF0815495A9CAD2C2BF72AAB4B288A6
      8AA2B675A81DABB8AE7455083466AC6456EA3A288C11FDA819F7553085666534
      85159E45CBAB82B99A4BAD98AA8AE841CEE03CBA5E7A5756A1462B25AF027746
      70AF832C78AD1E3EA88BD2CB8AFB10828C0664108199A2461F78E44A04EB8415
      BCA82A5E735718102E385B4523409B52616C785B1BA6A364C10A86A7D8D27969
      1C28154D69EA22543228896929B9B4950FAC88ACA82B5732C7EBE2E10322B68C
      2E2A0DAAE20141D591D7265406DDAFBD9246B9DA798CB76655D08E2B199C4337
      CA18E1301651F218AA927BEE1CBA51EB98792512F7805F4EF119660334B01ACD
      E60F0BAEC02AF4AA1B4E8B9A81C71CFCDA08BE6AFEAE8891A2B2C459E8BF0EB1
      92B507194BED416F8CAC04576126A295A6109CA6477B4C083C5E1D55C558597B
      7044C04F111F3E7098D6C2D635E80C728718B535DCC760435547134A23025147
      196B6DA11C0F4C80F15CADAA506AC53D983382834D25ADB09AC902DD01F31495
      C273F18C9A18D8C9C29796834C9E97656DA5A86AC50B234B86598855E58DA052
      CC06C194F02566B8F00C1D92BEE642312674B4DA94BA94D16B705E455D0BA019
      248347592A0896E61A430955B4953331826B4023E74C10D195A81F990B526052
      1444C608E114BE52E8812D21573170C96B0F9EAE94B4D68B32F8A2963538CEAB
      E8F3DC4C9959556B6354A9AA466354B6D324E905CD8127404B4816F3DF0F1FF4
      DFD1DFC2A38180FF1A7A85B55A058371C217987B465A0573AABD2DB53605B401
      26A3069B0AA920F4AEB6A1AE237A26B871A51525F40B286A22F81A121878C5B9
      06C4071F4364EA870F301EFC818974852E7C659584CA0955454CADA16FACC6BC
      55DE8AAA749828A75C409B25042C185D95A0782D2A089A8FC2802DB944DFA02A
      C083E00C5F4BEF59E1552DA1AA242B03E6C27B1920BF028C0255871E68A94385
      D984F20697E14B0C04135A305ECDA1BF08651485D789B3E9ABBA4C3350AA31FA
      E7BF1F3ED8BDE3654BF3E0A0516245D2A24A510762241E8BCA7B28B7BA5641E0
      6975ED5C695440795363A4C2091184AD82820C28CC99565065904E0DCD8A3109
      1215E64AFCF61CC53934A28FE003C809A40C0F870C4790AB86302823B98330FA
      0275B934060ADD69EF610218741D83F49512DA3544B461A0C33CB44A745E5446
      DBE85D11ADD1B2129873100DDC6D8C66811B88B0B410C7B2365C616631C048D2
      A82D44D82A189CD2819BB810D254C2103731685B74C7FB22F2585795D34A57B0
      135CB90AF36D48431756955E173CF89A414F1B3CA17096834ECC807C45158381
      BA4167C0942C04AE8C2E4B9450206B093EF04C318FCFAC75B22C6047A12BA0B5
      44C5486F19A88D92C4AB660558149A0B9302EB56586A06922E1C549953DA0758
      375597A0260C4860302142C01C561AF2002B8E8E73A5BCA914CC6E150AA8311E
      6ACD601B2B5BB222E8C845F05249B0527081919D62CCC3B457B0903E2A66A178
      8DD42E425FC1D4C36C463C0EFC426A3342DD1AE8C40041345E022CC0CC8182A8
      E9C0EA9826AF2C54858D34A6828BD28221ACE42CC0365A172136466BCE2D1008
      F82596162C0D463240109031CEEA181851C449D8AC582932D94660CA6B7C0AB3
      105CD41A7308C3256A28661B35A04B01C1025CC0683013C43E4E02BA40CA6123
      614234286B8050F0015421AB2A530432205590DAFA5839C86F50A6280CE97781
      F9771CD5A1E7C1542065252B06EB54819D6A0163A4C060606D85F98202713A40
      F82184C2801430F80C20272AE22228025938C983850528AB870F4A8E9E444C27
      085B43BC2A2B0967D0A49860B88129A8D07C941A1CC54071A86FD83E68EB8A95
      1ACA81D81AB2564650094452A4F0C1C5E84341F3C10A156588A01C74184810EA
      00CB5361368486E9730F1F7047E619C617C6DF0B3033F457059C668DB251C2A0
      A0EF3140D8AC35116C12218350AD11956182049061740192A2C12CBEA62AC656
      25142D936427D168F4C155B1C443D23B0E1C841F305C301612B200E181DD0514
      8520606698F40E4CE0212025814050AAA8B400DDA181D1670FCD0CBB003E07BC
      83ED0411046CAD738003058CBA443155D3408B5294845AC1CE30ADD099055011
      4C3201528F6E017745282BF041E580875C09A089B6A154A0402B0745AFAABA02
      E2A831DD0059E80BE05D05C646F761704B092BE1BD00ED007B05204164101E68
      31E8A802D0D840A948172D40A082F621045705C0C7CAA221C760984A603127A0
      0FAABA002EAD2B68670D03C30A0B94CB80861C83654119853A984E987AF4CE61
      EC565AA0036FA07A30F90C18BC44D71CF4297CA6BA82A594A5E164976C05E3A2
      05139E946805190480E5E00F075D8D41786EA01309E64243B0CAE25950A89A1A
      168E01B4C040E25308A22D0CA602B30E9E07776950C970F44D00BFF10AACC62C
      2951301DF41B8016E0AFF495E016020F2BE28B80921833941683C6020285B903
      5486A1063E2823390C004E81E439B13B890E900CFE83DFD1671808A83C0F3450
      68A0532F3CFAE92B06C91426DA40C044403B4909EFA086A9048A05677060C460
      499B29283BA039286AC037C070539401EDC187852C8042A5855DAE3149C08ED0
      8EF8133A181A2E4201439749B08390904A41A206DB0099F1011CEF5474DC621A
      6BF079601C2A2BC2DE803BD06D741E52EA6B256B0ED980CA0B0102C394876845
      F23C8869227A10428177C0CD50CE59FB42774341078941C01CC2664513818BD0
      21EDD0760965C36AB407D9115669CC59019B6700D7C92000144275157528AC86
      F3C05509F4EEE1F9806FA0BC206D6837B29243000AADA091307735B435F8D8C0
      CC607621B69C4AA22854113A8A165584FB0BD1B1781A5C21CC9FB7C1286870D8
      5E038F0EEA038E5784F35393D586C200E08200C23C826F654D4E930634310C83
      030A85A4E842C07EC332F9DA00FB80381C02240A47E809C2041D0B840C3302ED
      044F06120FBB04250F562C001B40793CBD06C77A094C44AC0A950B05032F8BBC
      49729D8064349C4B03245742E75B8971631C862C52ED9D03327781BC36401D00
      1EA50A654B0916050C80E296044A818960936143A1002C6C3BE45D72407409F9
      844082FD818AD065000D050614A25040A71276075E28C076E53171F01BF1A984
      61829A8729873985ACC192A3192ED183082F16E01825E1D9551628092304A540
      3C741F500004B135FA46B5A006153094C6E3C090D0F5B004C1623A4B1805F206
      34A4CA414D0B05610D2AC62AC2DEC0CDC53BD8537834A02EA8C70CB700E29EFC
      467005B0914B0A19600754869B089D2900552DC92693243DAE82202960038EA9
      82BD0970813037F82A28C814801CF492D49E5B529270ECE0E168621B6BD06C05
      3342E85A038F831DA16F359C774D1803B3401E2D540D5940483F83C36CD12758
      0D5E0AB41B803F98815A55002B30E050C60039106F3867009415E60A24369169
      07E747C02E97A5F105884EAE2ECC19FA42630E1276162AC5480742016A80DC85
      2BD003681166004731CDA5145CC093878F8D29C2BC0093296709A3C127F39073
      603D701A79E750F91E2689E82EE0DAC1CF309CC317A861EF2C036BC13B819282
      72AFCB028005365E421579CC43AD211AB442019209786D9ED04B01B56C223C23
      096D879E41A7D8B286B70ADC40FAA1A81D035612AC060884B5F25A032E4339C3
      E785C6C194195AC221B4526B28C812EC0B4B033B935646E09180FEF0A4E01162
      70984B7424D2C00927E2913020F02B95AF805DE12D099406BE61000D980125E0
      D0960EE4810E044A0686D01AFA031F28CC3DE08D83972AC1BF70C960F8312F90
      72D8D740DD048E8313526AE3D2F87D0D7B440B5BA0812713E7C18950C20EDA1C
      2E01B40438163D7565017FA72E2206CE8C866EE6815C404251B06E3E40800139
      48D6E0F3021C29033308DE81FC01B1D541C24D046CA5450722B721D60ED0DE98
      36F84E2434F07BBCA01E800F304005C38019B31173014001D8039406250CE21B
      6FAD8C01AA875BB4AC215FE457838BE0E083E4B00A16984911853147128AA386
      5ED21051B8F1F80C4A063C0C6EC0F8C9C8802DC1500A6AD601480103C36F04AE
      8185453D401E9825F400349CEA2D16505AA630D4DBECA5D7D9D364FAB4B7B85B
      9D816DBCD3731FAEDF241F9E5009040312CD342D9744050D525BF278C04FBEAA
      5008A2438E52101C8E213948708B4BF8221E6E22793415E0155419F4413006E0
      B6361A18D0009C41A87C8062822C831B608D5000D8DEC0C7809DAA803A8101E1
      88C30254C61B0E53508334151480827E0DBE04843170785925C82113707DF034
      0E18AE21740C0615101C1805A85C44602408141C4C0B34054F473066B9058C87
      EF567B182F3822905AE8365A9603DC054E05172B4C00EC3BAC4889EE4BB814B4
      6A033200875546813F6126E17F61820157A14A00194947595A7E70103380394B
      922E1C3C160976028703F6E4991BCC3E6C3B03A03A67C5F7D4ABBF1A0C9436BA
      1E7C571F6835F0D45AE0B1172F72992127EE38EDAE67DEB54E75EC055161A7A4
      A2BF86725C12EEEAD55DAB37C75EB0495DAF300B47FA756C65E7AE9EDCA5198E
      F604E27B8A3EFD35DDE93A23F554163B0AC8FC5F36AB62CE15B6FDEAEF0F1FD0
      66875B5FAE375B475B1E57F63A65B08057199B96A1A7E9499A43B5827BE15331
      A20BDC3F06AF1802AC88AB05BE856B49DF4A987B01AF93575402FEBE483DA69F
      8E5A005D514A1BE27AB405580FDC696967016A00BA5AC37D202F0698A2C87D80
      AC707C47FE1C1C002DF0AF00C28A8C1629784319C83C9CA3A8539F9A7A4A110D
      E93BD17CCB4853C0CF62F84CE73EA75102C87148095CC348E59521094D23440D
      9E9F0C588391D39804A055FE4CA83A7F96CAB1AE1CEBCAB1AE5CFA0C6D539FD3
      7E50D3C6E0935D99C49DF4193B2875D8123F28C30FCA888332E2A08C3C28230F
      CAA883322A95A94071A2689DE7A97D97BEC34C28278625F63E4339F042C39394
      C77875B3BDF97819B6FF7EB9F5DB9BE595FDC0B5A437145312BC0FB1485F85AB
      E5DB25DEAEDA4F6E57781F686BBCFDE4BFF27D72EDDB36173EDE1BF3DFBB26C3
      0717AE6F16BD1AE5A25FBE58ECCA168B9729DFEBD7A3A5CDA03425D920D12A29
      886AD0ED5C6BD7E972BC03C79B645F7FE206F9A76E507CFA41CB4FDD47F5A91B
      D49F7ED0D5A7EEA399D4605B6B0911FB30998387B5A631E9B0CE343E1CD61167
      D491678D681AC30CEBE833EA4C9BF4611D3371442D77F0217BDCAC1DA6F93736
      306DC64F34C07FFB20A671C38906A6A999130DA8DF3E88694C73A281691C74A2
      81796A221BC6C57370E2EA66A668C5F5FA66958E66860F37B39E6A57A8D7A455
      9B5B3767C09A55853A9AC3DF670B67A37CCFD7E55C0E5A6D2EC59DD5FD9B1CB3
      1A1771F9E67613B633071256BF86CBF575BA1092D299CC7A765739C72ACE267B
      E28F2EBFDEB94CB26B60DED0E9786A7381D9AC475FDB3767D503AEFD0D036E6B
      27919837D08E45ECEDCD5BE2BB659837CF57D66DD6F3B8726D6749475BEFC572
      3B77745465F1ECF6F232CC5315A9DECBF9D398EACD0341A9CA542338A8340F04
      A52AD30CDD11EA9D33A8A6E659636BEA9E31C4A6E61923CDF37DCE489B9A678D
      B4A97BC6489B9A72DC392D87BEECEBE5CDE53CC5F24D4E8A30735CAF966F5696
      AE099E8548866D7CDBDCD8F993DDD8371B7BFD76F1E7F56A9E103F5BFB8F8BD7
      73514257EB3C689366E69B264DDAFC396D6B9EC3855DDD791ED5B0EE5427FE78
      ED7952D7E47B5B7CBF0366C7D9788FBD6EEB9BD99CFCCA5EDE664C307380DFDA
      9B794FDA31D09FD3AD3B0D1BFDF62666F2C44B4204DF377676DE9877CF9FF7C8
      5DBD792CB82F73673FB6A93E57113FA33FE6AB8AEF3F5E870D90E2BB59B5FEBC
      A6DB7A831FD63ECAF88C0D79F866B3EEE6F27885A1C2FFEEEAFAADDD2EE701BA
      6FD7EE36DDBFFC83BD9E55F1A74B4A98349B8ADFFDEF2BBBBCEC198D7973F7FD
      EB1F5E2C5EAFAF09C3D241BC793348959FAD6F6ED65767D56F9CE0C77F0BF593
      F90F7E0AE4BCFA7875CE809F9EE191A58ADF2C67AAB35C6BEDCFA8F56D779FF5
      3943FCD7F0B15EDB8D9FFFDC9F36210BC74D38A3F62B4B5762CDAFF71AF24C49
      9566AF17A4DA9480985CB1731DDDED6DFD9FC1CD93BC97EBEC53CDA9F3634EDD
      94EDFEDC45E241E5793A7E5075A675A1EBD1D73DCD34B206F63AB9C27FD92CFD
      C8B07A8ACE85B7EB4BCAA7DE357A1CB9ECD39BCE9FB67E6F5B480D95F68B74DB
      CDABB73B07B92BB80FBDA86037835D2976A4546F545D39BE07C6FCF2F6AA7D6E
      B330DC9515A7CAB2615979AC6CC32F83826AB4E05E8BFA58411AD27E8BD56841
      B63F7A335A940FDAD4C3D9F9D66EDE1DD25CEFB94DB4D91E6F2F8FCEA266C7CB
      1E36CA8F174C733995816064E8DABC4E54EFE4A55D85494C3552FC346F8D543A
      CD6423954E70DBFED8C7E4F9E7F0EB72DBAEAD1E5F8B157BC3DFF63CD313F86D
      C864FF76BB6E8CEFF1870CA7F1F9EA26ACB6A1576B8AE08CCEF709191AA1EC09
      611AA97142A68ED71813AE91D2A7A56C6CE8A7046EE44127246F64E81344904D
      53E623C5EF12C00305374D04D93922385DE18FD498C0C007E399C0C06C3603B3
      D90CCC6631303B8781F7873E8581D96C0666B31998CF63603E8F81F9790CCCCF
      61603E9B81F96C063E18CF0406E6B31998CF66E069F066A4F43406DE1FFA1406
      E6B31998CF6660318F81C53C0616E731B0388781C56C0616B319F8603C131858
      CC6660319B81C52C0616E730F0FED0A730B098CDC0623603CB790C2CE731B03C
      8F81E5390C2C6733B09CCDC007E399C0C0723603CBD90C2C6731B03C8781F787
      3E8581E56C0696B31958CD6360358F81D5790CACCE6160359B81D56C063E18CF
      040656B31958CD6660358B81D5390CBC3FF4290CAC6633B03AB17437A4036D3A
      5E86E18ECA719F7F38BED68BEF2A9ED8BDE187FB9C78E4CF8390A0E315D9D167
      4EA93924D2B3F5FADD8C3081AE95215F3E5BD697CB755A1BF9F85BC2A3F7D767
      7FFCA6DBCFEC171347B7A1D262EED049176CB4E0D019127CB4E010740A315A70
      1F4208395A74A846C5509C12BBE67249E10DCBAAB1B2E5B1D27AACF4DEF0ABB1
      727BA33763E5F6072F47C72493BE18342BCBB1C2AA93E261053656411FAF7027
      D98E2FF29CA0DFD8DAD309528E3C639CA6C72BDC45DA915A13683C36A629E41E
      19DC54BAB3B9749FCCC0636B2C13E8CECEA23B3B9BEE6C36938F0E6E2ADDF95C
      BAF3B9749FAC41C6D612A6D29D9F4D777E36DDF979DC7E602AEEA6BB984B7731
      97EEE22C6E3F50FC33E82ECEA6BB388FEE722EB7EF7B5513E82EE7D25D9E4577
      7936B7EF8F690EDDE579745773E9AEE672FBBEF73081EEEA2CBAABB3E9AECEE6
      F683C10DE99E3CA2C920B057FAA40DED953BA9C27BE54E6A905EB906029E541C
      BDE2D34060AFC234107848B64920B04FBF910AE3841C458DE3349D04020F883B
      09041EA5F148CD09C41E1DDC54BA9F0481C7E83E9981472ADC4DF57D603595EE
      2741E049BA9F048127E9CECEE3F67DBC3581EE2741E031BA4FD62023906C22D5
      0FA0E30CBA9F048127E97E12048ED35DCCE5F603D47837DD4F82C063749FA7C2
      476ACDA0FA017C9C41F79320709CEE2741E031BACBB9DC7E801AEFA6FB491038
      4AF79320F024DDE5D9DC7E30B8A9743F09028FD1FD24083C46773597DBF781D5
      54BA9F048127E97E12049EA4FBBCBC043FA0CAFC30EC5757767373E62987EFED
      F6ED8D9D77C0F397E6A69DE0BB0EFF3DDDD44097346C6FE8E6DAA24CB98E8A9C
      DFA928CA263FD3C30782D2BDA78C409CB120B92865252BE185939435A95422E7
      52E28AF21A1D7DA9DC922F5C2CCB50D8B22E4B1BCAF1EC4EF9C5297F319A8C21
      C694ED692C3355B9F77BEF0BAA1FBBAC6387EFBBCF7FC71765D3FCC77DDD8FFE
      1FF77564F4BEF91DFED89E7C8ED7FDDCFFE3BEEE477FFA25813554CCFFB5C8D0
      430085A890DF6B7CA0CD5D28E1FC57CA7429C7ED7EE194F5A6AA0C8BA5A7E4D4
      4AA2A7A2308A33590639D6AE2E4241B72A701642859A45398638FE7F798D52E0
      CCD7C3079FB2777FC4EB5352E07FDEE8E9F5A92870C6E85BDFA379FDFDEFFF0F
      6A09B144}
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
