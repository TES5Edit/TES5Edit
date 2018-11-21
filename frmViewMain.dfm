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
      789CECBD7B77DB46962FFABFD7F277C0D19CBB227553325F7AA52733C796ED8E
      4FFB916B39C9991B659D051245121108B051A0287656BEFBDDAF2A144842006D
      598F0C7A269644E251B5AB6ABFF76FFF7E9166A3CE851FA851E4C7E34EBB7B78
      E1C73AA47F86B371A77BD8BD980FF98A51FB82FFD5999E8C82C170D2EB1CB60F
      F9CF28E13F8FF8CF4958F87310D2BDF88E5EFBA4637E1F2978E3C94536515365
      BFB37FAD7E3BD4EDDF2F46499C6583087E695FC06383D0BB18A5C9D48F2F46C3
      899F6A95C1E7B3F49FDDDF2FFE7231F3E3442BAFDD85FF3B6AF7DA87ED3EFCD7
      85DFFA7F7C0AA74A7BEFD5C2FB88B7FFED0F7864D73E729A042A5D7D66A7F8CC
      6378CE293D1B9FD987679E25F33454293EF56F7F3C7D024FEC950CB2BB3E4820
      651B260CFF1DC360F1A1C77F9C2FA78324A2B175F2F9C66174F383D6FEF7C7CF
      613C0EE03FCDCFEA970CABD33BDA4CBD9567FEF1C33B78D8DBF047BC6EE44799
      F73F7ED0DD0FC3F973F5879979D93B36AE0FAE0BAF0FAE531769E94F0769E87B
      EFFC6C4283EE1DDB07EA45A8F5CD0F1CD1A274E9D1E68151084FA467F57B5BAD
      F40046755A7C5812EB24F2B54CB6DFDF666C03D930FC1F6CC73FCED53851DE8F
      6F7870875FBA3AFFCB2C0F3D2F8287FC96A440413890B77D6A68FAC1C07943E7
      ABEE2D78DB2474DED6DD6E53F4366F0AEF6D389E64329B81FBFCB203FC055C06
      D6238CCDF3B73A255BAC47FE862FDE4D35D6237FDBD12D1D52B312F9938F6F7F
      25FA4765ECB977C24FF5566EF3CE5EF19D65A3E9E28A6EBE73991A6E715AB624
      479D929BFF9E2A75496F3E2C3BC19DA36EC9CD9FE629DF5A7A348F8F4B6EDDFD
      5E0D52B5D8E3FBBBA5F797916BF779EA0FC2E19ECCFCB0EC38754E8E4A9EF002
      765C38E4F7978AADA35ED9FB7F0A5516FBF0A1E2391C1D95717EB3E61DCF11E3
      66BD8F8E4B6F93055FB9CD2EF6D169D99D66B58B77E62B7DDC2EBFB3BBE14EB3
      CCC79DD2FB649D8BF715D6F8B85407328BBC727371818F4B05AB59E1E2EDCEEA
      1EF7CBA7DBDBF4E6D5A5ED9C9CDCCC223CC3C9BC9F95CEE00D651CAD7752CD18
      5CFD8476096B3D27D58CA178E7329557563385C28DF93EE99D56B384C2AD66A3
      F44EAB8F63E146B35A3CD5D3EAE358B87B6DC1FA9D3269E1929905B4E1BB9D32
      2DD0A5AFDC22A4ED774E4BEE7149CBF70855994D77DBA5F77557EE3324ED773B
      65F7581E6BEE299CBB7EB74C93C999ABBDD19E39BAB15776A3B3887C6361FDFA
      DD32A5D55D3F79E3DAD21DD7E2A3AC24E742B31617353799E53BAEC541E5AEC2
      029ED4E2A072A75DC2935A3C4CEE721858FFA41607931BD7497A527D1A8C9D90
      339CFE49F581C8EF32243DA93E11F6A69CD1F44FAB0F84BDCD92F3B4FA44D89B
      F223218A52F5A1C8EF2D9C8AD3EA5361EF74D7F0B4FA50E46F5C5BC2D32A09F4
      BF564590CCB460A3953DA4522B2D3CA54C9E5468A82B8FE994EA8C55BAEADABC
      3AA5EA63A5E65A784CA9D0AAA7C5169E552AC2EA6AB485A7959A5A75B4DBC293
      CAF48F2D345DD728EF5698FDF534239AB06B7D774F6ACB6F32B0CD3E2D3CA38C
      15AD0B747986EC52F721BD521EB326E1F921EE1E2D3CA894E1AC897C7E90D9A1
      858794F29E351D801F52D89F85279572A335A5409E54DC9D85671DD6D613F859
      CEDE2C3CA74C4CADAB0D32A6D59DE93A587A9FC7ECD61C35BDCF6777EE63FA9F
      CDEE561FF499CC6E6D62FD2F647785677D09BB5B7DD6E733BBF539DE02BB73BD
      6AFD2F91A0F9533E734B19B9601F54EE77A9B1A90A0FFA22099A3FE64BB6D4FA
      ECBE7053159EF5A512347FD2976EA93547EAD1ADC8D0157FE9517D099ACBCEFC
      EEFAB233DF99EE038EEBCBCD7C47161E505F5E3A9232BFBDBEA45CD98185A7D4
      9792859D5778467DE958948BF913EACBC50D3BCD75751F7F36FB2A3CE58B24A2
      7DCCC997190085477D3EFB2A3CE6CB2562FEAC2F36000A4FFB22F65578D297B2
      2F78E0308992341B447FBB4855D0BE18C3AAC4ED8B413457EDF58FBA8787EE87
      F0E74D1FB7FFF6F4097E8C7F6F78C8CAC7EDE287F943367EBCF24A7E44A77BE2
      7E087FDEF4313F19FFDAF088958F57AE2D7984FB429E7AE7B42B5FC12FF4D569
      B716A5DBB8D87FC11488E16486CCA2DBBDC0EC890B5F0268983B61FFC0340BF9
      E3D03337CE7CB8F19F91771185ED8B14FED37E07C4938EBA87A7F0EF741E659D
      8B45180CB368E6A7178BD49FC15D3E7C7CE1EB991FCD263EFE12CFA720A0FC79
      965CF8C16F739DA5A8AFC30361A411FE1366FEACEDC13EBF88937FC2AE4BA649
      A6BCDF2F74B68C949E2895FD7E77C3B848B30868311AEA8E071469C37F483ADF
      24AEC030B2942F687B306426ACC92A71124A88D855B4BE188ED330A0DBE299F3
      847886CFF02E74ACAE331894FEE72849A77E06BFCDD23049C36CD9F6DEE34798
      B601C3D09D2289069D36110AFF1DE0A43BF017FFDC8A54C93C03E2A8485DA9A8
      BD05E1068676A02497D26E7041DF6FA2DE256836A0E78015C8746C1B1AB6B7A3
      DFC0D72A48E2B6901286A661CC979DC38D343DF570D3A53A0C3ABDD3A3F6E971
      CF9B281F335ABC8ED0B9FBF5E9DCF91C3A03A56EA43352B27497DE1275BB86BA
      47DB52B72BD4ED7D7DEA763F87BADDE39BA90BDF7F75EAF60C758FB7A56E8F65
      01CC099EE507419885570A2ED76A1A4EC2205031FC318FE1573587573A0FED78
      2F99B2DE0F7EEA8F81D213EF751267F440987BA63B1DF8274D16C145968E32FD
      73186493173DF863062F8A3AED13F935CD7F1D45E6FB51667F1BD8DF52FC6D38
      98F9C0D6E19711FF3280A98384E39FD972A6E02A7DA5D20C341BF86D9006A9F9
      19C9CF81FC4CE567308EEC6FE6B389FCBCAA947430DBFB11327721623A9D1BB6
      C3D3272C69BC4FFE2052762F1DBA7BA98CF9176732A07C4AE4F996BFE7FB1C37
      276F70FC990C2F0B3B71C3F6FEDEB066EF0CB4563BAEA3EA71E16B378C0B3E46
      26B43A9EEE96E3E916C7735C3D9EEEF1C6F1E0C76BA3E96D399A9E190D690927
      5F87C16EBDD9FB376CF6FEADF3526755AD26707223035C21A61C80DD9FD560CF
      2EEC69E9C28EBA34C9F6CAD4BA17FC61614D6B8FE1FB4FEFDE7A6749604F60B7
      5D3A80102984D376DF1FAEBC795D86D0E0565EFB6A0ACBAD434AE9D5DDA29A69
      F7088A82EBD3CE11FCDB39E975E147F7184E7976DD3B3AEAC38FFEE109F0EEEB
      C3FE295E72D4EFE025C73DCCBBBE3EE9F6FB7C375E025BF1981ED33E3DC58B3A
      9D53141CD7601275F1B24EEFB84FD7F58F0E8F6E796BCAAADDA8ECB76FD89C5D
      B339BB5FA646192DB5DBDD7A7FFC902A5ED54C05769F743F73A36E648605EE5C
      185CD5780A6CB1DB2B1FD4CA700A63C8CD9FB517CEA2FD4BFBF87EDDC7AF4EF2
      E6170CC9E7F117D8443ACB501CFE4EBFF2DF6A3A8BFC4C85C1F1E9C949A7DBE9
      F7F95BD23B2FE8DF7834ECF6ECAFB1F9FDB761DBFC12CB6FA3248A9285FCA133
      1F341DD083F8AF993F54F20D68432ACEDABFF35F196C9F8B6FDA9D8BF97EEFB4
      D3F3FE13E9C16F9B4F072A85534CD5029A43B5BE6CEB70BF778407E3183EFE6D
      2873C313DAA5E3023FD02970DB53B982E1C6F02B2C51DD79259BE6D32DCC279F
      0DD0BF381DFA009E8C3F3DF2AB3D8029D152754F372F55A75D32B72E724B776E
      F401BC027FD6592C940D0F756E27272B73C30F706EF0F33636A299FB3DCC0DFE
      2DCE8D3E8057E0CFAF7CC8ECB4BFD2DCFABD15F6411FC02BF0E703602030FFCF
      9E1BE6F817E6461FC04BF0E703985BC5CC90C997CFED788597D00738B7E37ABC
      E4C17292A3FE091E76776EF811CE0D7F9AB96138C38307E1EF61D03B3DED9D9C
      9E1CFDB151B4F70EDBDD5EF7A8D36D447B23DA1BD1DE88F646B43F0006D288F6
      46B4D710EDA7474727EDC37E7BB368DFEF1E9FF44FFAEDA3A346B637B2BD91ED
      8D6C6F64FB0360208D6C6F647B0DD9DE3DEC1D754FBB4725767B0724FFF1D1C9
      F14923DB1BD9DEC8F646B637B2FD01309046B637B2BD8E6C3F3E393E3C3C3C2D
      91EDFB2787C79D93A3C37623DC1BE1DE08F746B837C2FD21309046B837C2BD8E
      703FE9F4DADDFEF17189E1DE393D444674D878E51BE1DE08F746B837C2FD2130
      9046B837C2BD4E325DEFF0080478FBA42CE4DE3EEE75FBBD4E23DC1BE1DE08F7
      46B837C2FD21309046B837C2BD8670EF234CEA61F7A853922A8F7D7D4E3B471B
      BDF2ED9C2CED6DA9528B105DF8AF7DB04A04A4108C7FB52070A552F6B3C5FC97
      CC6AFBB5C62976EA4E71F30451C0AFAC7B51F63F8C5976BF6C96153AC066FDE6
      EE67D9FBC2596EAF0D58017F87B3EC7FD92C3F432FD8B892B95AF7556679F865
      B3FC0C0D619BFD7A1B7A1DCEF2E8CB66F919BAC22D9DCADA1A1ECEF2F80B67B9
      BDD6F0B5790F71BC95599E7CD92C495DD84E7F383CE9B7DBEDA393927CFC6EFB
      E8B8D73EEE776FDD39B0A57E5FCF3DF0489C03ACDBDFA67BE0DEA7F4252AFD17
      BB07EE776E15CE8115D5EEB6DD03F736B70A25E0513BACBED839F0801D565FDD
      39708F0EABFB740E7C6D87D56708F763B0FE4F7AA7C7DD12CF7F1F01F94F4EBB
      B78091B3BEE8FFAD84FBAA32D708F746B83FE6B935C2BD11EE8D707FD0C2FDE4
      B0DBEE1DF78FCBC2FAFDD39376B7D73FB905949C46B837C2BD11EE8D707F0473
      6B847B23DCFF04C2BD03A2FBA8D7EF774BE2FAA7C724FD4F6FC12DDF08F746B8
      37C2BD11EE8F606E8D706F84FB9F41B8F74E4F8EBAC78727FD92A0FB69FFA473
      74D26F847B23DC1BE1DE08F746B837C2BD11EE8F45B8F77B9DEE71A7D32BB1DC
      F7E1CE7EBF7F72DA04DD1BE9DE48F746BA37D2BD91EE8D747F34D2BDDF3E3DEC
      1F1E9698EEFB9DD3937EEFF8F4F4B4DD88F746BC37E2BD11EF8D786FC47B23DE
      1F89783F3EE91F1E9D9E1C9500E1ED835D7FDC3BEC35397537AD71F5449A02B8
      469E37F2FC01CFAD91E78D3CFF33C8F3932EC8EBD3EE716FB33CEF1C1DB68F7A
      2747B7016CFB2716E88DB5DE48F746BA37D2BD91EE8D747F40D2BDDB3EEC1DF5
      8F8E7AA77FC0F77FA14F932B95A661A0E01991FABDF0D1DA5D856F87C91CA672
      11E98E3DDB2B37E6BEFFCD379A2AFB95DB2CFCEEE6BB7A9BEFCAD30836DFD6DF
      7C9B8503DC7CD7E1E6BB2CFC3F2EF2A6FB8E4A0669DD259B6F3BDE7C9B6901BC
      F9A693CD37592C83CD779D96CCCC74242C59EB76D9625B5CA4921B3B2514B10A
      67C97D259BC476572AB9AD6C97D8329192FB4AB649EFF4B47702EB56B6DE9D92
      8D626B4E4B6E2BDB2736E1B5E4BE633EC0A9BACA0691F7FB8FF1659C2CE2BFF1
      A7B3F18C3EC55F2E42F8A77D1166FE0C57A67D91C27F7A00FFF9886065AEE894
      5CC16FD161800FA45F8E4E7ABDCE116E7CFCEBB8DD85FF3BE2DFBBA74825FA1D
      2670D43E8545A53F0E81005DDA01D3A99F4D7E48F9E7EB24CE7AFD8BE920BD7C
      110263955FCEE7F0F2A99EFA51F43AF581F54E8350CF5EAA51E7621ABDF3D331
      5D9BDADF0235FADF43F86E91FAB337C46049179E8671F6369CC22FB19F2EE137
      7C7F188F92DF2FFC79364952EF5504D7E84CA5CF7F84AF92994AFD0C3EFE04DF
      C1A7B1F72A1E472AA50D3F4C1530F5E9C532EDB63B2717D3A4D3B90896B08B26
      69875E85C7095763FD9A2E5C738897F4708FC04AEA3089717BAA005F8F1B2E4E
      46337FAC345D017F2C9234D0A7C0D1F8CFE1C44FF52110F0D4F97BA18F3A1DEA
      0A0E8F8C4F7BBC54D7D30866448B4FBF76BC4996CDBE7DF64C0F276AEAEB8369
      384C139D8CB28361327D968C46E1503DC3F73DEBB6DB3DFA6D1AFD81FAF9CC07
      822CE0A5B0BCF4FBA4036B0FF302BA474C61F82DB5BF65F6B701FD369E83DD98
      B611784DAB618670A58B304816C32C8D2E46593CF8EDC257711024C38B0C96F9
      720ABB5CB7F9F75192C206C9C2780C244CE2040CD0810AF4528F60CB7480D0D1
      3289AFA651DBF91624DF38F0331FDE9C8EE0A92047E30C1E78E547217CAE801E
      9D0B3D491660CA0ED524890294BF7034C67192AA6978AD82213C1DE5336CFD2B
      15C674E735BE056F835FE014C2D6E8C01A5C83399C254B15C3ACD4F54C4FD22C
      868FE7305910F8C38B20864588F52018C0A7A401C094E6306F98989EF870D061
      93FD0BE71E8CA7B491E197095DD801161A8CAF9CDFE1D270CC961D7E53F86B82
      43EBD00DF80B1A17301E3F0E2EAE42B5B80485A343BFE9A11FA9CE711B4EFC20
      0DD289F203F9759424D9859E45CB6C1187B1C2A5B1BF4FB2299C153D834944F1
      24F383DF605A17730DBACBC08FE20BF80F3E80975CC02DF08621FCB5A03FE097
      341BA717510C871A66AEE011F0DB2245D674A1637F962563E069613C5451040F
      026D6A14AA088E6F008FBF800B67F378888E6F5F87BE7D0AF29314466C194CAC
      16F0449D2DE16B0D2F19A7C902C69C8CC20C071A23C1B325D09DBC197102838D
      81D164FA62A470700A142EF87878AD67A402018B08600D17F8B9C235F54111D4
      389F0B7F4417CF615F461713BA02099701FFF453B8321B5EF944AB0C468B378D
      5224087E70E567D783EB8BCB349EA53A56D9C5D08703091B2E023A7AB8734238
      8F333F03054FB16FE02F170BD8C8A369360A41534CBD6EFFB0FD071E7FE044F3
      54659334C9407705CE0DCAE8D41FFAD910F4C6191D38188F7781A72EF0CCF943
      CD505DB72F70E555BA3C06F50A575E7E8581E86BFC05C81F4F54AAE86EBC0517
      09154E7A9A1AF9B0C587B08074803D9236317C058A6F077E9B0FD3297E80FA30
      FECDFA2EFA5A66F1C48FC72893E2EC3AF3BD031155727317190EDC0E83FDACFB
      7BF01BC8C7CFBAB70FBF45F5DFBC57BCFBB0FE9B07DEEE1F658F392202D41EC6
      4D8F3AA607D55B889B9E73725B033AAD3320DCF21B9F04C227055E15F961ECC9
      DEBEF8279C995C55E9B49163D3BF033CFAC0E67DFE0902077631DE81CA816C5F
      6028333F9A4D7CFC052CAD8B115D7D91CC69C39301D6BE005E37D719B0DA4906
      AF89C9B2327A143CD077B51C6F156E14FED320F8FD0866062AE761017E147D5F
      F82D7ED96B9F74E8979182EB404B4CE02A7FD4EB1C82D49D84CE1FC1C0FE7178
      31C45349F7C533E711F10C1F024B5218CEC08CA87F5284411D5C8CFAFD0BFCFC
      02C832B9B80445028468EF0878A02E6871A87114272C6383FB0B03A3F1C3A730
      C99F277EF68DF6803F7BB072D7AF8230F37A07BD8323EFC5AB4FCFFF93348CD4
      E3E5BDBB85ED6CB7B065A4EC1D6D2625D08E48594940987E15093FA138F29291
      77C66A89F6408A7942D6F76A718714FC129AC969E8AF40F012B9BAFDDBA1D444
      799F3E9C790350399318B75B069F64C9CC8BD428F386491A8300054AC2C7950F
      7328ECBD06EDC1DBF5239D788B095804A0B05DAAC0BCC0B910D66ACF1BFAB137
      501E681D01BCDC4385CC83159B80E5E6F9EBCB7960167095605D22D82A66715F
      421BF5CF666FE30C7BDECB648E43398BC2E1E5DACBBF70B5AAC99BE08CD17CBC
      D339BF029AA7773ED9A74FCC5EC1EDB908A3C8D3607FC10FFC0CF45C50AA60B3
      B04E0697C2AE4165DDEC8CCAE7FF0C86F9443636BD22D41E9F55DA6C8B10BEF5
      3DD05143B4C56A3FF63C037BC9DBBD0A75487B36F54085DDF3FCB8F2CE00DEB9
      3E2434A702B83DF052A5C1C4863FE838E12574C4F0A8C0C8C720E30F1AC15045
      E4EFE7633080BD703A4B13242CD8E664308329452262E70CBD15CA7B09669AEF
      FD0086C164A7111656588453055A890A8072482D76ED8006EA7B01116C8604A3
      AF707F1E1DB6DFBDF0CEC99BB03C0FAF0F949E7A135F03A7871D0C5B793EC407
      A5C9D443379D87C1AE6918CF33A5BDDD4EDB9B24F354EFA13CF007B0DFBC43F9
      B6729CFAA016BB426DB2843CDEC33E4AE215FCE2A324CFF9ACCDF0623E1E85D7
      4A3FB4E351429B9AC7E34B2882BA1407B7F04CA46A96A428A242ADE7B0A327C0
      C979E723D9826F856EBF4B9AC875E6586BD61171732F8615115F3A766B1B1507
      4EF319C1D7DF0C8E2F40ECFDB1610D0B5920B5177325508FF7D658DE486FDEFE
      78FBDD2C72E512EFDA550565390835E8C7C19EB7BFA288A2E7ED7387626656BD
      DB486B0FA300375B90C00E034DC35B24E9258EED6720DB67EA6C660477B041ED
      64EB6ED05B5AEFDA447EFAA46CC5179310F43B5051775E8375FE3C8A76C0588A
      E6D358D4B86912A896075F85BC30B344B34A08E20CF48DB91FA11E12A308D58A
      C4A555FFF839FAA12D9F0958192ACADF5F79F14ADFFAF94BF7FD9B4FEF5E818A
      81FAF39B97DE0FA9028E0C9F8E270A4358608ABEF331B685964F1A2A50416099
      FFFEF1C71FBCC81FA84893B51A81E1816B098A24ACEAF43357CBCCA6396BB460
      A3640E96CE6009EA2428431856C4F5226B1BB91C9E920FFF58F155BC4B82391C
      AB73B20843F89CCC22CB10FD68E12F51E524F94BB623267680163A038B4AE363
      EBCEB4B7ED4CB7B0A86F4364DC93CEBAA5C3B7A68B1526F3359DAC652ED6C3C6
      C55A4FD97D694EA8378563E48F95379F61ACF8A19903F7EB5A0DD6A864ED5F26
      5750DBB3F429819D7A1566606380053EF087976216C3CE658BBBF211A08AE0EE
      26B5843C6A0345FEA398FD471E5AEA5E38A2AF99415E85C95C83A2C25781B85B
      26F3DA237E9DAC7B68C332D287B7E93CCC2632550F83D4A8602571B4FC52A7C0
      E7B86C815E96D4BE460FB83F02E6BF80C3A185D440DB7914ACAE450C4A8097A1
      C3059D7FF8183F55DE38213998E48F6315E48A1CE5F11274C7188EC47C886994
      F946C1DBA7784ED80A35FBA6C626061E39343114584E94999CA50982366101CC
      CCF325EB578D0FF2D13A4EEE9753DEA7E3A4FC7CFFE91C275F6991BFC01A1B62
      0E03AEBB98636000FBB007F0EB5C8BA780602C6145B8681E6761C4AC144324E4
      839618899FA24BFA016E92CF762EFDF2FA43FF57EFF5FBE7EFC8107DFBE1054A
      F2459A3CCE69966F85AB30CDE67EE4EDFC9CA45140697C3B1EF0F729881C9236
      6A0AF7F9E9D28399AA34C410848AC420C72D522D8F2535D1837FE74A36D0861D
      F8F3C7B72F6513FEB948FC33060FE764F69E25B325DAC12645DADBA5A027FEB9
      48433C447B2D6FE77D822A06F9B78A4E46D4399942DA1B45FE788CBA8DC64090
      82D73E46AA95D1EC39ED128768146DDE458663BD7A4986CE231DC2FEAD21F050
      7DC2C816C8BD9F42E06A303C6FEA2FBD5D38DF29EA7943D059E102D0F206911F
      5FFE99A8F91AF60A6C9324DF4930E91F63A4C8639C66B9D74AA5192AF2C097D2
      6C3807FD9926CB7E635CF928E1D405EDE90C2D049F957613DE5F8A61107F933D
      46BA9450E5239C9A64EA3DFFA928BC69D2C328D1B9E86E2C88F22413E5C30B48
      E3F9FF12A026ECB226B76D9D4CCF3DCD845268A022B5FE85D4A2328901902837
      2CFC2060537A2537ADF215C8BDF3ECA03B4F477BFEF693F757EFFC9E32D1D6FC
      D75F7BBA679F3EBE85F9BEBEFBF98E92E15C4BE699DD52B51D61744825C511BD
      2998C686895CA86EDDF99E1122B65BDE5F5BB88EFBB7EF16BBB7F3F0BA771F79
      8A36216F8AF21EE5330A75DA32B0CA974ACDB46C1B147594EF84570FE7698A86
      0DFCD4E85A03E1877AE1BD11EFDEF23C2DFD5C76BD0D059174B5746EF4B83A2F
      A2A542877CAA70E9E055F3988C4115D0D1206782B6F96CF467D923E4BEC6FF59
      ADBDA0D88583F2BD3F1DCCD3312881EF543C6FD416439F1D24D00EE78D2C3CFF
      CA0F234A49967877916CCD7EAB414F741EFE18732AF5F760BCEFA08F194B59F3
      1897B7F31CA6E831E99319328B6647E6C17260D09BC85883BB87C81A955BFBF1
      81A8ABBD5DE0C7641E1269C81B621874AA28DA8501ADB9BC90F9ABF692088DE6
      0CB3743A79BAB0EF0DB00E169E08128284C740A1A8E0881A18A22ADD70785A1E
      610648668979D3080C744DE6024E384AF8EBA5632EC895B5F5BF42020B0D90EB
      19F0F9F4663DAF7C861F512D80543E84E453F1A364FC7983F8E5FFFC6A9683C6
      03128E8AB9F17B8927770EE15DA0AD065ABCEDF079106A7F3603C9A7D1A913A2
      9984F4E5D9C449F22F65EFB66BD370A8EAA5C9D20854725A21242CF904BFE7CA
      16502DFEF77C3AF33E258F851F7DA19EEAD0ABD48471E8750FB66F5C74DCCA42
      4929094B6D5932BED6CFC8515EF9648A9E37A7A5924C6A4AB53BDF0381864900
      7C38F0B3C77238BEBEB07E85A1B118C445813E46AA81548D13126A0AC337FF9C
      87295CC0B94A7EE61BAD131115C28864B678C5D4B5AA2D6ADE900476339E6D8C
      29332F423F08DB5C2287E005A80EA05EC6254517BFFFDD9FAAF7F0DFC51F07F9
      643EC8A3685603A5CD539D013687A72AEF119D9BC53506F23567284F4881FDEB
      902A4886730A42DF743C4865CC0F17857782DC59A1CCB95CC07375AC16076936
      6A5276B748D9ADBCA224A7B7DFE4F43699694D66DAFD64A6751F7E66DABF1D9E
      F6BD7D6FE76D32F4A3106CD859341F87F18E3742182D721B6B6F9026972A7E80
      2BFC05C9403AA15C396F4AE54E9C46C5BE92A1242F0CC314249FCEB0401EDDE4
      1AD61A992B3C219DCF380B782479538F327D638534358869A9E707587AF98CCC
      11FC6513352365AA8E6ECA6DD3362D6DD7E6580985312B046F439D79EF3112B8
      343FE6AD1F8FE75811917BB4A454D25FA09902FBEA00D9463CD662BCC0BE3B18
      68FFD9C1C0EF7A140CBA528F73D36DA6C88F9F5E9F782A0633A78E5F15036109
      AA99CCB402CF100B011AD0233AF2A388B2FFA70A9DA7A19EA277D55CC59660E6
      F1BEC357FF892899AA515E1B3DD7B077A609CC770A47355DB2F3385643ACC849
      978F71DAA5874A829353AE89CC4F167AA690C3C175A88F53C4525D036F8996F0
      31182771068441038643AFECB2AFC6AC694901CB427BF319FA2A31804ADEFE3F
      175963ACAB0911DA76183227A2F8336886FE0C73D69E317228B9D79733091F38
      DC5D4480780C77C3E98CBFE3421ABC38507A98862C5207F0E68529107B945CFF
      DF10CB65DFFB48C295DD39F13C8AC428F367334FD07C3DC66B6F6CB3CA623A8C
      6FCD33EFF8C8D3F31992B5B1D20C6DFE8E3844580637C692EEBCC472EA07EA00
      73D76DA23A596C98874BA0196A14C6210723E3647100DB75A4528558505678D8
      67A91883F081C323D111E4FA384773847440B7CF2AE611257AF1D7F460944FAB
      2FC26B707D1928B97E8DE5DAB6C0A18D55AC52429800CA044BC96CAC0E6DCC12
      0C0652C4C28F972818F2E2445FA609E2140990A1A32BB9F4E0D20DB3C5214DE7
      C30957F3A0FA21005B343D530C4B2585C3D4D713557FC62FE0D13A1CC7E12804
      0D1B063A4568777C11E557732A8FE60549292B1FF11D62D6C24D5D91B3F2B4A0
      88A81A8E9692C5152FC989B423D8F03B5C2DA299307038AA8658482B6D9CD295
      F4126FF4149702C7EFE1E8A60AADA886C95957D422A15D5942A8D56CE6CF7146
      6D8EDCFEE95C52BD2F75497DED4CCC7D1C280A92D2E03636D3F84AE1ED7DEF67
      4CE7B055971B31566A59A8989E42EC1589CD821164921827C24D29CD870B5FFC
      21F266A96F67179C3EC8AEB3038C271290ACBE0C67DA0CE8EF690226473E247C
      11D26D0A3AF5D037A258D32BD9C835377D8ECFE08E8EC6DDE752D05E1B031381
      23700FC914FBDE1BB085D0A6BAAFB9DF78CEBED6BC0FF89015F72B9D03441FC5
      B8F75B580E341C739D1411C550DDA26062359EECD32781C1927DE10F2FC72959
      B66FA9E8ACD149AAB3466DAAE04E939FBC5256B5534CA3DC31885CD6582AD453
      6D0613E76289451807687951C05D9E823E2AF45F4EE1D16C3AED4AA27FB4E49A
      D93C22A718A1AD89BC6D5073FA0F3DF226F136DF49B67E480B58ED76306C7A37
      1C19649C47E9AD938CEC86C51982BCE36801F09FB006DCF4D4D165E7B1092C84
      20D177BF233D3A50C0D248B34D628653BACE085432084724DD33F329BD541316
      C058C15F94E8487C14F8230F887DC9A33976326AE478756E35684DD8212E4F41
      642087978EBF1D68FA1AABF23993B739066EF6CBD0D08FAAE0523FD691CF2D12
      4C2471572B25210BBC26F7AD715B0F74930E84FCD50875A038C46E1A28291078
      30EEC13CF8F7E1ECDB6BF8DF7FDCBD59A493A95A501D8C9C77373C94B841BE83
      7A94A1FADD5B73502055EE9E2852417D0FF39D67A3937B29B24757343B2FEC39
      E48059CB5307E31BD67ECD41746BB4E8740FBBF750257C6029A0D9288830D443
      A1FC3EC8D171988180443F13C627109C19B9475B57D1E96B51097947FBB4D7AE
      C73B3EAFBABE11FAE50029D401B528BC22937084A03C7C0167163502BFBC7003
      0825A90E4249AAC84772FA394177312E011F898A15989630448A3C031E2D2256
      14F650C483FC0A474B23E40B2B023A0543A16A6FE74752D70A5F7FBB63C4A20D
      24A2AB19442395E8EFD5C7D46511AB3DEB60C004FE1FDFD8582A97FE87C04606
      F3CC8EB35A8DB1131199853E0D2E75F1599D418C03E2EF017C720FBACD2FC399
      51887FBD07F5467CF6421D7617615C18B744A830B875A988F0DF561FCEFC0066
      D7A79D23F8B773D2EBC28FEE71FF047EF48E8EFAF0A37F78D2861F87FD53BCE4
      A8DFC14B8E7B5DBCE4A4DBEFF3DD78099CF2637A4CFBF4142FC246CE7855A70B
      D7E1CFDE719FAEEB1F1D1E7DDD537F27B03AEE5E583D3965F7A8780CC779F21D
      6A4675EFB9C43ED349FCDD11FCAFE1B9AE91A5676AC81B9F71294991A9ABEADE
      8BA27BCB30D9244F5614DDDD05DE76F734C0ED791F81D750C7DF642D762521FC
      3A454D8141AA6B1FD305B7926ACE8EB2F4A42A7D7F34C28EF26857100286C756
      A69F5F162286671A5E99DA3523E51BB5B386AF693A4327E0B974A76C989CBB25
      57A953F0794A06323A8B389D18752D3675A92592D5CF6CE74F93D2E7DF7EE8B8
      92453C7DB23699DDEBBDDBD6A3EEEBC43DCEEAD092E2CF5E53FC59D3F6333D51
      AD59D7E419AF79A124118AEB912C2E1CD3094887793408E78BE123F8264CAD93
      3CCFC87DFEFEFC0D621F21DA41A6103604F363531FB848BA67AE9788B8003448
      7C89ED706084C3CCD192A6FE6C8616F240650B8CBDDB87716A2B0F835EC559AC
      7B28E1D18A3FC0CE670C7E25C9F81A592D1C9D1AA408311136C01B9760AC4D43
      9CBD6B34FBC3A174D79ABA24A3790421821A93A3CEF6E322AAD849F982B5B9D4
      999AAE7C27DE6FAA7B922B6A6B46CC16F21A7D8D85184BAE102A7B219BFEB07D
      32ECF846978A7235E4622D36F613A76832F2355E0623AD1C9159EF071836BEF7
      0486C3879EC0F0F4C9DFF958DB63BE8F9A8E66F432491A275706F98262E40E2D
      A72714A6F26281500B7124181C82AEC9C3C9B1C2C6C8A69BB824D4C0A658E639
      5C0F69CBD4A0D84FEF9EBFC4520D987F16F221C18A29A120198269EA2FF173F9
      C8D0145B388131844E443864E797CB349C128B8B7CECD08E572D89686631A45F
      3ABA0AABA12394CBA8CC99472F2621C451A15C1EAD5FF84B86AB13D8FF877B88
      EB26E138F5A3EE1E5E27A58531B987D093A907BE07FC67925E0454EB9B8D12EA
      BCF8F6512EFDA74DD1FC9B573F2B9E136154C291BCA4960EC5F21B5525E94986
      992E146A5007D433EEC3200A412F895BB6BAA9D7A2836EFEC47A919FD4D8D7E8
      2D290E1686A5A2008B5B6751380CF1D84EFDF4927B9368AC480ADDAE65EBF540
      3C0487BBC488F0DEE20C1CCA42076E10CD03AAF15C9A1DE090D0DB3564634F8E
      E9B36768588346751ADCA91A27F1419CC35BF614569DC4BD951A68832940300A
      D172FDC836768DB7AAC510EE30F7CD75CE11EAEB560BC72C006F971465847200
      11E9BDD913ABC5C4BC241A681B0EDD839B667F38DB17D3EBDB7F3783BF877C1E
      F6B2DE0301EE73D2B01554480AD23DC53160EBDF75CA4E357AA5EB6B67072715
      3849A16D9CA453E253ACF90F540E54B182A318D62F995DD5B9A9E86AED7C8B84
      02398968200779701CEC655278575F4F95D5ABCE8FFCB9E8A660F16C0522F52D
      2598130A7C83FC64053A8F51101152A56BE8110245B465C1F4BABECB25684864
      F870E06BC602221F83F184A15546E2FC1B8D2597997142A030A2EFE4EF7B94C4
      77BFD749126FD50C58B4AA5D14C8E7AFF65A2BC51C0572F3BAA07E368E71B99A
      128F0D1E92A387EE21913401D011506178804B5839831116DF3DE609CC927C05
      DA8F7102C37FA9E1631E7F80D85B8F7907816DFCC8673056A055C58F7902A952
      973CFEDE631C3F88A3287CD42BF09B3FF3635466F71F2D581ED8160B357EDCCB
      80B6C67C3CE78578AC930075EE913354BD50C1E39E41364F2FED0CFA8F7106E9
      5C6B7B983B8F7106D8CE2F67A97F7B8C5398CCE3B19FDA6578940A2A18898370
      C8136812B38B1E8BF3578D97E24BBD14C78FD24BD19C003A0126E6DA2F44608F
      8F9A63F1A5C7E2E4E11F8BE6446CC863B7B8EA98F337678850BBFDB517DA1808
      8751764986BCFED0971C860FC747E6028CA8FEF8A9FA189E704A65BCCCA8FFB1
      BA1EAA5966B8D6C15E5D173CA73C2CD681C74C26E65A72E94680F9968778AF79
      D7E6BCAE56835D1066C309469132D04FE32C9C1ABC0D9BB329803F85ECFFAD4A
      5B8A88141460E2A480F5B833A5BD0E111D984B5289F3D40A6C708DB94D4FA520
      8F64A5DE43B5E6FD263EE5C5AF987212136CF73D80301CE4658AF710CBE6FCDF
      832DE0046E77F61C3BFBBFAFE4D0DF232D108BE193043F4DD85ABAF9C111C3C3
      1E2946A7B56728501AFB0CDAA3BB65C236D59C6789619BA6B01C3ED9117AEC78
      BBF0EB0EB104ABB1ECE189CDB9D3881281DC80B7AD914B0C9EBF03ADFB757256
      EAA05246DFFEBB19F5DD676DE0EAFE3CC1A56594739DA1BC702101585A008367
      66BFD6DE315A6BECD272450F2517810E389DD10A62F25FAD7437239CECE32DAE
      C03D9CC67FC76487FF3808E3F01E164898B29D7F685BE95CAA251D813C83524A
      403CBD760D652F62E634276E6C15C8DFA0132C269C0F1A6A7703300C07179DB2
      F4C43C4B3FF28693241C52DEC43D55F96E16A9546F7F47D9C468227197728BA9
      61E95AFD0C415196C454517D86D424FDEB695FEB09C3C52A1EB78067C31E4135
      6273820D25E0F2C0A98D833F65280F6F5732C8B63BECB7CB90EFF1B0633D4421
      05B3B64CBA5D7E77BF3269AF0E5744BEC429680335C2023CD6985AF9EE24FC19
      E038ABAE8A3870B0A570E762A31FD88B830451C967044F7DE09DE1D9B267C93C
      229BA4C97C3CB9F9800103443ECB42104172696FC32B4820AE92332CA128AC68
      789B54056DE83E8417F3A822A8D00A1B2CC00CEE22D740CD2D4FF1AE013053AC
      C8D9CEAEDC3C0E932E28AC761C2503329E1D737317D7769686491A66FC458942
      B4E7B0E5FBD03087B37BCD864E6E3F23B8DEACF76945EF75EE9BDB776C93207E
      CB9AECE34910FFB3603AAEE77FDF87441FCEEE65C16B88883CA51C9930BA5A17
      E877C6A6EB205B076104DCB575F71683E51FB74DB73A156108CB475DC3D2BC72
      693BA98672CB74C42A7A49B1790AE11048C914A8E888C6BF743DA7776F9F9579
      B8EECE44BBC107CC946A71713763F30EACCA38BA1FF976CFD5B1DBB8466F77E2
      2F537F9CC483248DBFA25B74AB43B7D6A0C28B959FDA6E1806C099C12B09BB12
      B157D08116C6D8AA55DA820E12F1BB93466A6D940613F1EBB31F461D359AFBB7
      26D9AA2ED421DF3E2ED4555AB4906FB97A72AD7C72BB876F304E8A6FE8E46F38
      034B388AC2E196AFA0BA317E74E51DCEBB8F0EDBED8EB7FBE3A7D7FB277BD57B
      F5BF4BECF8670C983E103FE7DD282DB99F139B6CA9A0953333B35B28C44058BF
      52970FCCB0E16F7780F9DA6E7FDB6EFFBADE1AEC5BEF1709350ACB3B38FFF4F1
      CDFBBF9FFF2A4CA12E8F694E3C9FF887A43BDF99AD8275B914F4C106F1DFE488
      595CDA9C64794A5873C8BFE221CF35639B3850729ABD5D8AB0986DB3D748F19B
      CFB498CAE8F07D0407FC9631583826422919219D70CF60E3309E4E8E15D448F3
      BB93E6FDCDD2DCB18E959EFECA9DAE581FF376CF3E9E01A1AB1EFFEDF3D3D727
      BD17AF5FD7B61FB619D0E730A25B1DC039459AC10217C8CA86D939BE0C6DB20A
      A89372B2B0E1688A70A64984DE0CECB15CF45170E6C9D4BF14A4AD6F302C3BF1
      116E3405E6401DF1AA2BA7116BCF46FE49CF1484CECD68A01FCE1B90F24AA2CE
      67818FBE75D6F20FBE073A21358303F8B8019CAE2F05CB00A7BB0DE074BD8DF8
      623E1E85D7AA693B5AE23A4E9544C142AD114816B8A7E2F6CA48B6A6A666534D
      CDE943AFA979FAE4DF0E4F7ADEBE87FC0273E3A8AB236314E64095F497E98544
      8516533F66FC420DBB2078804B5F6FE67D9879009C2AE3EC1786CE46014F6984
      6A3AC38C54046B4C526C2C4AFB7F8FBA616232A3A686B8DACB16890DAC04EC3B
      64746ED0061E65213450E61028C342244814768281F33F55D4FF823364A7494C
      2DC342EE0E13F93AE3162E944D89B0E3023FAEC3AC8E1AE0BB3D9F1F1BB58E80
      5A976A394890DDD8B42A6AA99C2633DA1338216D89B948D2CB473AD76398AB65
      068324C2B48838DF26A339B2054CA3870D933C52E600D33C41D660168F4B490C
      CCFE4C20F712200322F0E548867F82E53D75E78D4387194E9234FC1796D44428
      2012AC374490446CD300FA3B593C8324AB73CC93E934D11977D7799C043A6D03
      81FC28FBEB709E6AEA1178A51035DF940111ACA4D31E5903A1A2F934C6821F8C
      9FC3BE19A0FDDFD8365F6EDB741ADBA6B16D1ADBE67E6C9BCE6656F2C08C9B63
      54F175160E2F912FA7C9A220A339A50EB979EC5F8563D2411FE05AD7104BC7A8
      827EE4F601A3C8471CE11AF44915526298CCB83323553482F646265E90FA632A
      DE8A035208668F55953B468DF5A59FF986308559FF99E64A1BFE74CD72A36E3E
      B31454F295BC2C94A66B60DC0414B17FC2A80A589A31CF46F02786D4B02F7223
      6C2B2B522D284DD3B26E9536E7E138A6C48B582A2B95D614B546615BA3CAD40F
      B0F112070D5870AF364C29D4DC232E10D66B4DE7E4B14815737DB04CE1141B00
      F82089EB2300388B0BD69F6DA8AE62CC7B0C304B3D450876534DA5AEA946FDCE
      23F208EB823CE00006704F0D94A9A890984CC662F6EE2B2446C97179EBE4AF99
      90A0F352AADA3BEBB97454E4D6B248BEB1AA41E89169E0864668CB9B45CAD7CA
      F43B88928C5A9A51530293E0CD25A602A1805515BE9E28F17B863196B54430F0
      4DBD881ADE5FD352C58E5020B11BBE9F9B5BA03FECE4D4D901AE3B9C93DF2434
      0D7E74524CBD2D5C0ED46CFA0FDF82CBA4DDB84CEAEDD81FDFA08F60DAF84C56
      D18FA8273AEBB5986C9837451FCCC38832ED2CE9A409A6E848FE300BAF28D743
      AA6C5DB0821DBA63079E3C608C0261029260431FED86C32436581D58B814A911
      DA71698CAD8A4D1513C69C16611C248B16AA2157A14F9F9B412127310FFF801E
      DA1A138FB7ABDC2F7D55AC4D6115526E86ED8EE17CCAC06D27F90CEFADFDC237
      31FADE9988FC56867810A01D772C5CEF408FE73208AD705791DF2B062DF52DB5
      3FDC0D30EE9B12381D123BC24F1517BE72EADA1E3DFD255CE6ED9A6FCDD572B3
      7B31BF701B0AE2F8D26A3C486A468DBEF64BDC0CA8B8249A341551EC45296778
      B06466BE61421B3A80F89970DDA934EA931D27BDAEA9212EF7BEC520B8CA1A25
      A8DE0A7AFE021D2D68DF5133EA241E4521813982FD94364CB5C8548D12843433
      0CC158024C314F0F89ACBB038242A39D9AC13944FA31BBD372A546B647DABC1F
      737A640DC79140D0191E444B4880755F8929E0C525D09F36B86C9EF38CEFDFE3
      E7E19DF993EC9C0B404EE6C31C526F850DE396D4E1388697A2893AAC13BAAC16
      13BCC36159B279632C5553F4AD1AAB38D8C41E1AA56BD52D80128EC628FA8E61
      123F856C6A5A0E62A83A986759124BB24E968CC79162AC00EADE4EA015942A6D
      AECF922412462237A1314659D639DC22C8D8411873AA0EDE7D66968DECBB5D3A
      9FBC827CC2EDF7D89A71373FB575CAB6E439B5F5869F05F14F39FB6A8A644966
      2A6EB19F7FE882668DC002A52471058313FEC0E44C1569662D5128B321E11CD3
      75BB85293F7327B8671E22EF176286DABCA96109958BF83D0C71FFE50F6F5812
      365C60A3968061AC31676616E9E56AFD82842B35FF205AEB20DD801056AB7140
      D234E88B112542528934B748FF0F0FE8FEFF986D6FB41081D9C486AC9EA09187
      53A024A7C4D93EE47438863EABE50320308D1E732BA50B2B6CDEA2F68DA3A083
      581C209CAD8C6B328C5DD31CB65A9BEAD5F9DB264255EEE4E04C46EBEAC02D8E
      14C3D3577D98E44C106ECF4461A597B70BE775813244407B0E948E1C087316BA
      E1D4A26B0ABC341CA7E2CBEB8B447307320B016865A57B604BEEC8F0F7BD1D52
      B5773C1D2559AE9B531A0CBC3A4C116677FAE6A5066988C171BE0D07F5FAD5F5
      F53576101BAA03EFD5B54FC7926088F05B04C0C4C6007038A419FB54F9A03A58
      5E5607A1D1057BA61161CA61E2750F7BDE0EAED18E9DDB6EBB8DDFBC7EC9DA47
      BF7D7A646766AF79FDAA2D97BD7AFDFAF59E21849FE5D04A98DCBD95C7C7EE0B
      0CB913AF628C617AB88725A8A95833761CE814A36F051E1467E2A2E8E2DE4975
      E605E138E4200E919B968198DCFB0F9F60E152158504B952394EE9991D60506A
      8A687FCED8FC7889D1D1FA3BCB01D046371615C611BA06D99D8C9F49A5011CFA
      43796169C47E96A565EB06480DC1350D703BFAAD3900A5254727F63E0C7E0392
      BE79D932ADAF19CC32A7919C39A6510BA4D3FFA405B6DB194424B90F71E29CFD
      904B127B546AB088FC346D75128593587064AE578C0C8DB08AC0460DF5B7F710
      2E7D338E6113C050EF23664A2B445BD2CF0F02F3193A1AC899E060843846A3C1
      DB2D65F49E15967A1FA89E3F68350F92BA44FC8A2444E23847AB405166454252
      6E9F025BD0C07BAD90B5CE8958A1BC307B4CB6D0FCFC91854326F52F48E8E813
      3B77CF861C61576E347A5C15F53F2210A38AB1F4E6C5D23BF3C95C6D34BACDE4
      7111EDC49E627135F4B953106163F34714D1E2F0017D2B322E8911354631E2C4
      00332524F4C532FAECE3990D46312C07A2AC2246C5D0AF6EF74360DD5CE15E5B
      BAC00CD9F0A191B1DC85A1F1986154A9E23D812D8726A902D330A2E234CA8882
      F3187B87A0121979EBAAAE30F25449684FE0B132FF127FCBEFED82780761166C
      172473D106D9D34403B54BB5B24E4C61EA49C0D05DC89B4219590B7F132C73CA
      DA2612D4CFBCD1D57B4494F1A2B79A07257D9FBC8BDF916D5DFC81280E4C3D51
      F85D758EDB08F026F325918DB3C8320427F0BD11683EA09ECD3354036BA8C798
      DE86ECDE60A9D20B7235DF17C539C57A445959D9E98559C69FB588EEA930C682
      237F0F603DF9125C2D8A386649CA6972A66B0EBC790793730DF5887FA91D3E75
      604ECC7D83E5400F027136590369B3894DB0993E63FC06C481F4B23A8EC915C5
      8D5029EE57757B096322C2FDF13BCCFF8EF58EEF3C93340667220835EE394D7C
      63287CE73E14314B12045AB97B65EC3BCC2BFD462C40F79C00AB02934953B61E
      1E5EE455F4A131734B8905B3FEEAFBE71C46731F6D180CB9881A2EB9441E1B01
      94A2A8BBFBF375F6EDC5EFC87A2EFEB80F04BBEF98ED49B32B8A97E5146AF4E3
      2AFABD9B4795D764E13EAA46E40AB29B8D1A2388B300D4A55225A1D1B55DA12A
      C85536258CA8975A4296AB5AC19C2C7B569144EF9AA9142FE008FE140813CE28
      CA874BA573D70E0728C8BB6A51D2F3CCB4B31F7EC4A00172932B3F8C503E8985
      8A325FE7350920BF6A4C52CF50F79FCF78A4E88D74FC85CD392CD7B3C5062230
      F1D838D13C027D6B8E53D97162F28841E93B242413C3AAC27E9E2750C47327AD
      B8F82471795B979079861C404630F32D0B142D3B2F91B411F266D35727B9E45E
      76309683A871CDACEC6F0E43545E5AA0606EE9A76A9186598661E0DC06A12084
      1EA698B9C151650E86C78417C831AA69483531845D619100E5E438EE47EE4D89
      12C67681D9AE3FE5B90335DCA2A77D7A75DEC70EDC3DE9C0FDFE273714136243
      D93444170E4D834E39A5C42D49CEE8036A79090F397C767EFE4A9A78F70D2E61
      0D57ADBCE75E9A26CFA23950551F64D7F7D1EC2D279DB7CBE1561BAF3381A730
      A63475D75FCE90D1CEC8F72C87145AE2AAAEDFA869CF70128359CD3BB75C9E3E
      C171D230BF06D1B76AD3EA6CD79658775659BB7BCC62A5A7F7521B0804B88FC9
      46F73159EB0A64F7B4385133ECE3C4F94BC87859E3A87ED8ABF3771C96D22A93
      A815BB7D31AD2024A85CD777BD9523B0C0803F0BEEE32BAF60E7E081A07E6C56
      BDB640FDF8D2BDFE7B25AD72377CE99E5F73A56DA1D43CB4ADD195AD71F73ED6
      1F297A519B93DE2A6BD94771720B201DFDDB184DEFA01E40C787116882A11F79
      2FDF9E21AF9A18B463E13DFBAE8C7C805BADFF75B6DAC5EF35361B9FEAFFFBD3
      C77BDB6F8450FDD3475E1FC181E87B3F7D7C28BBF0B0E62E3CA33E8A60C69F45
      F381894A7C85CDF835E67854738E4659C0D447D74D7EEF1338AE39813889F7CB
      26D1780EBC3723E3AD721CF48ECD96A17757921B8DA311D30894B945DAB9B219
      98C494EA40390D52F889DD02749677210D25AF3342CFF3D2ED20C62A677E9BBD
      DEBC0603FFE26FA69E057AF3E27AB5003431A83F9B53F419C64F9D686D322E3E
      7200975E367EB94A422244C73B5EAA1CB03700D99C8C9B6356B08DD6C84307C7
      E653DBF6F4721D3A8D8B9E10DFA6BD603EA19F2238B0F94E0EB11FD019E623A7
      5BDECE30992DD1403C3838A0FDBDC37EBC701A46B0328856C655687BB92BD071
      00A257B0863F881C87F52BED6D506AAE25994ADCE0C245E4702F93399799AB15
      C6C093DBC62E459B395582202BD056E80FFCC019E5E3D058CFECD6C42C1F9DC4
      362349EAE1AB658DB19B8961EEB5ACF46CE5B9A0BBA3A20707AE22D7B60C85DC
      A48565E7C46B4958FF2155A3F07A2B939CEA149DC455499B06560954C4F81B2F
      42EC294C45E756C7140159894D5487876D654436B18E04592C4E5AA2E0C8660C
      AB8D479020E555709BFA27F2884BB52F9019F7E5B88235F826A3E4F5891A5E6E
      9162F7BAC01FCC9272FAA411A5F2CC62A58A530F43DF932F7EF54879BBCE12FD
      72F0AB0BC0FFCBFFF9B57E59C37FC1D125479564CD51368AC902A08EDB0127EF
      7045C6CA886BBFE66532C7179C45084B0A9439CBD2E8AFAF10A59127CD33A564
      CE023288A81695CFA76CBB42A6E2304A341F0FE6E14CAA0FFFD8A2BA1638AC65
      F53B67ABECB995B74B30AD10B83F93E1861406E1F9044AD3EAE589821C65045E
      E563DEFABB6796EB5CF911E2F11277A1A290AD3C7B35064DF90A0AA33FDA05EE
      D7B6DD41534958434D60580558BC6FCE2D0D91F36B73543D4C39C6A37FF6E9E3
      5B5A8D80CFC010CFC0378DC265732468970B58CD675233578908B1F5C07BE940
      D38FFC486F7182383E4355F49CB74132BEC56F9E022591834F541470E7131C4B
      81BB318BF7874335CB0C0C478D1825CBE416FEF4FE0E226FC6B1D25D4C5CD7D9
      32527B1C18CD8F2C668F34A01B35D069A9AA15C5AA094C1E8C27D893A1A9045E
      A194D025EF1A6EE256B0E2E97241DAF9AEBAC69DED89FA8BC9EA9CF93FC41438
      02D031E58E4118A0F264D3E4E5F179CD546D3B04513B624C96322F4371EF0E17
      1E1AEAAC95BFA63AFDD166135181DD169ADD2B2680816BC3D9B18AD132480436
      C68E4ADA8D536F8E6DB9CFB660DC26D4990B9823F146DD9CDD0D369D90069D6E
      DE080EEE9CEB959C2A210B8CC9EA6594A02D1D4E15E7E5E365E384528BF0BC7B
      51986578D8F013533343EA23D8205B18B6301EEC9BC35874D5E560A4BD63A79D
      09AC06973CAF2D7B2B779FC44BD69279BEDA732007187990F13304E2170E2762
      C38F53DF88506F48B181184E2F9AD52603101EEC136E8E7D77FDE22A7B0F2F85
      94A167382AA63E2D8AE916B68BAED145182310EA9E6DBBAB19AA482089C51320
      B07DBB0335ACD3EB602E0690CED0C432DE05590B8D1C3B99C799CDF7A24229DB
      69969CBE7B0798B13C6122FA34112AFDB1CF203E1F27B493C0969B2100F6309C
      A151840DD10C561096E0B3D2C27E23990F192A401A5B508F9A9AF870AE4C693D
      F2507CFD7CF6392B806F8A517CE12C94416D89C97D2EA4AE01399D8AAF28842D
      013248FCE4BC38B547F5F4C9734CE48041B12465BB1E1E67C8E4766181AD9C44
      575C3836C3AC3E01B1A6C2B71532C9B6802BF383C239E2287ED05F349D65CB4D
      D9ACA62C6F368B96ECE0DB794DDE263260F16E3BB69D034735163C0F0B783E4B
      422CEEA9C1A69E3E91938B01083CB860E1E3CB08B80F4438A5C33391F06DC0B5
      BFD112E890490165A48ACEBA0B72020E7DDA5303FE1C5F45F3A52C473873CE0B
      6976BC1640ED396F899B66CF601EFEA522300F6290CAD74B8987C00C483EAC24
      CAB598BD28E30556B580C02AAF303B82CA1C69A3ACEC24361E46B85B1157658C
      8C86474234C8F709228CE0C1A0C38DCC746573DD97A2D2BD1D45A57BBC5951E9
      1EDF7A5C85F9CDF94AE8A051500AAE294A3ECEA12CC9114A19C04642B7C4EB55
      4A509BBB2F2732FF948E24C74BAA73AB3D0920C63628A6D75F8567089522EAE0
      978C382DD6681A5BB9F6F3515AD44EDF41DDD309790D515805A1E0B3A8EB9901
      F908E320044D066DADC2C995804B486892A8A4D51FD47FC9EB46C2F09C30023E
      99E2C2C0DE42CC2D0FC9DAB2CD20CD10B610C7526F4C3133CE7F740BCD8C7F39
      74AB951ABE53698712D8F3B3975C7E4C14FDA8A2EAD897EFD8510D7B2A14C7E3
      29BACE184F3CD9808F49DC2011445D849612DAC3BE66E8ED9CB22DD712017B6C
      1E5BAF1D42589962A3C83DD252B8B128183D6BD16816E7CD01A999F5E5DA70CD
      765F0FB5230A1727A9274645747C097C082A1FF7E39B2DCCA04F161B04E5E1D2
      0993766D4E5221B16963255ECB6060C51218C7EB76CE8A33383838D8C9CF9E41
      03718E39754C4001448FA0B0E43BA7A07683C964A06D05F089A297FCD215CD05
      5EA3C5A2912AAB1901BC56118842732E34B9CD2A81F922B42F5500C44526817E
      85A47EEB25CE7241F8135C03B281A22421981B29ABB430CB0C469779D86629F3
      7A1634C7F81376C51AFE2BAE9EF15EEC1D943254C18614925CADB157FFE6456C
      1917423D6333E6363B18C0F723E957B6B6DC1647B9C8EC1D1C635E6CBB9168D5
      69EBB1896DF2AAD634C84836808BF0C6DE1F845409077398A6219AA5ACA8A606
      0D9F064575DF74668DA2C821F31C73491E2C857F03C267A941A36A871C2F55A8
      0BBBFBC07B4EAE03B438C3D4767F33816EBB658B47C260F418A3D828B82BDBD8
      5E87BBFDFEC2D18F48D4AD10B091732EA35BDD5D0CBE458E9A900DBBC20942A1
      389386F7EEE6ACCD5CDFB397C9CDE1A2B0B4E13D35F816B1A737B156697660ED
      537916F65F2730068A822FE2359606ACF88C5BB5FF38F39E99DF5F92CD7CF6F1
      6C655084862B7936EE93CE27E128FB2B8FC1E062FB9993EC6BE4138950F27DC9
      C5D8F73DB64D3DAC5B8F5E1D8ECA1E83E0D9E6F75B7192E55074884F27739644
      B5C24C5FD267DB4423DDEC699A5631FF401C9A5309E9DB8C6907274F987BB42C
      421370820101F03B34D4FC9616C3842F42F1EBE73474EA0BB94070E1531F5C81
      5DAA1FDAF4A96B283D9665B18514A95E10EA35DC340EDF5442B859923CA8C6E1
      36A1699F5A5718FE8598CB0EFA7E62AE328930B2C36C02AEE5B59C0673E547A1
      95DF0F694F540B0ECEDADEF73EACAA67A6D642CE492136F728A7FAF4C979324F
      870A977E551B5D9D2DDB3BBE092DE6E14A6B33119EB82441D326A8E61C12C0E2
      0E4ECEE673369E2C07B90D81B2F8A1E43FC3D864F866A8AB02FB512D06506EC0
      E4D84749E3D2DE16D8B48A470D7358E2C77BD29E3E61186EEFED079E3366CEC8
      D23BC2D315902E9A7FBEE9A4F8499B1DE2EE87EA8800193545B7880528341BD1
      49CEA5277399C2B79F5523BD42F6EE9615ABDD4DF3000BBC52E275FAFDCF1779
      74735D99174657250947F4980723FA9E3348C3FE2A2E4211D2D826754D312126
      459708F0AADB3871B7BAF4758A8062EF05D6CCC18C91DBA29F4A0DE78502A685
      0DF553523A3596F2F92ED0D3E3A5214A5E84425578ABA7533A3DF8F90D78266B
      0CD13CB0F8B29109556D7C9981182EBC2B7FD0A789EB55D4261B841F657B5384
      313D81E1631A33DA35A349BF37EA0EF757233B8A7C64E2009A72A77563595197
      14B20F074B4ED5E6D40FBED4AA0CD364BE4586F60BD954C5249F01A762223276
      6677C63844CC149FEA585699BB71E691BF0DF33A78BF63D053A58D19B389A5F7
      1EBE19F343C1B7FB5E7CBB02BA63FD1CD6B58EEA6CB57E4ACDBF281C3055AB5E
      219B48E07C276FD94554739D27FDEE3D52F58C48795648DA4B984D8AA225F3C5
      0012161C519A04D1C378B2A3703648A86FAB4DFF23BD6EC0C9A46E7BA5F78444
      178477DA76F88173DF8DAEF6759F39D5B7B58AD1881ACBEB84340685D2CFB5A0
      459967D4E9311D9A14CF03B873CC41C41187571CCBCC89526CD9B88028617248
      9C0160ECEF2385D5F3E8E5CE4AC0065D9E851A415CF13195D69A4044AC16982F
      474E3CFB70F284CDAB23296E9F042ACF2E968C36E18BF2C293E26669E2F4A594
      A133B8822448C62FF15B72D91AB7F3409A1B39DD29ECC3B609146BD19930902B
      B01D2682E953166EEE0BB747462A62B78A4773413F63223328A81EA6E12037F2
      9318F736D6DED58FC57CC01C619A772D0F807667680B97361298AF09B5758116
      FB0C6E538C2FC916E4FF5A5B70B77BD44071C906866CCA2208340C5B7CA410F3
      55173AD0ADF88A1AB6541E0E918290267F685D106BAE1EF2759E1B829C20E700
      D7610D88074C93F376A828A6246567A5F14D31A3645496A5B30DC489B429E2DE
      DFE589C7E28AC4C3A68B2005B923D628B1C4305615349F325C6D71BEA93B2A26
      E437A7B21A4B02C3B5CDB1FCEC63694E1D87BD9DAD77A707AF9098919F352354
      6D72556C4086721B6393C6C14E798AEEDF6379ED233A4584646AD2329A035472
      80AA811B6E3A618C164B691F708AEEEDA0B9998B6BC2AE98B6586DF7BB258670
      AD0A3125054B4029B925B570526E06E3D9C7EA5CED2D5D003CAE4D1CC4D2D3CE
      C5A99931B3D93C4ACACE71B94B9EB75B9694BBE5B0879324A117B393A450CDC3
      9D1139B66BC647C945D67961738B0C62925B12DF400A54AF018C1D4191A633DC
      03E7B2943B0DF7DB8CC553422E4E06A4CE54FB79EA7E840DB0A83BEA2FD7BF9A
      5C999B81790E0FBC33C9CAE33A1A0A2755A747AA8CDE48563045E43D3DC5E4EE
      94DFDFDD0E2DAB7C22A4C973D51B0C2D6FAEB5D23676636D021723AC91CEE5FA
      25BEC896AD782F1819E6A514B84432E14F19C195E4EA6F3971C67EADBC5892D2
      D7291285D390D9699E0ABA61CED4712C131E96BB5CAF427F83BCBB81A45178A9
      24A2DCF0BACA55FB68DB0431B2E82FA695DCAFB9269D6FAB8607160C1306CEDB
      44A7FC04EFDA5A55ABB9556319AFAB76850298BD0D6D9EB6716510DA45B26064
      0413AB23768D4D87D78F262831EAC07B836FCBE6694CB173EE0F8EBE4F6D5B47
      599F068C2E48FDF1D8B02766BFD289499972196F88758FE20BA19C65FA4417B2
      B552784F817F19C5D6FB54639550A925E003425DCC110D6769022B3275BCE366
      C1B628574621C85B20EFBF78D35E58CDFF263A8AD92AED1C095DE2865D45783C
      0EB69B4985C4EE76C47A2CC8A4D96CA2B59A8A6D0CA5BA9D23498D9DD5A0A4E0
      0A372CB5064BD5A27AC84F8DF28A40501AF66988C408472623076963BA86DF7D
      0F63C61590B5BA0F04614457A166D7D98AB64723E32E7B32BCDAECE97B41C2E4
      FA1CCACD781E49858E05E4119C2956B6D0D237A5E39A32B0C251E1DD4E389E06
      565FE4C4C60130F4B598AE2E8C4F75CC9C5E6F90F8B85701E283708193013CB2
      E3F45319A10897105D7E745A2435B7E162D5E28D408A19664432291AEEE596EE
      0D93E994EB0C62727B81B24290DB393897386226BE48F91CB4453253B02CA200
      69453B7CD701E9960B43C28151D35902535FE6E0960B9F238FF3180C273ACD35
      1279C8714EB8D7012343710E967487DB939A37445A33EA1B967160F9A3025B10
      941D7F3633AD39EC41BA73A64DFBF32511F41C287E0F4D33D9E146B9443EC5D2
      E3FDC4B4B1DAB5BF7DC74D53B9FABDE5D9CF8368A85BDED999DE2B645363EB24
      4E93DD40ED0BDA6BF7D02A7395DADFFAD86BAA35C0F689AD21FC3BBBFBBE5339
      F593B8C66A8979524845AC41724E08A702E0A98F5DD987D13C50F932AEF8771B
      8152992501BCAC60C83552C546AC5D7CF04D362F19DD0434EE678AB30BC2787F
      16F943CE854DB8E3EE1B842EC5DE23B25BB5D4D9EDB5BCD770603269AF4C151B
      A18A0281014414057E68FE2C06E3225CE76C82ABA7B601493F773C949B06CA6F
      67B53FC2CA3D2F48C190A56A753C7204E9384B085716CE9A945555BE765791F3
      9134689EB9DB0D67321F2358F0AEB5D9A98883D123FD711C6640B13D745F060E
      966873AECBCF35E3A59BF415247873A45D2FE10602817E409025A86B6D3AF545
      8019F21EA4AC1FE281D9133E80F8E2DAE3F628A0C8850CAB403AC22055FEA520
      853116B2E65287D7EC58F261BE70430DD374C2299DCD41A8B698101E5790129B
      1390BB4991E1223F65631D4D1983236CB0AD9966AE7B743809D53609FF3B4CFC
      155CDE33032CFD168C9D54EFB86E73EE598491CB1B6FD5DC5F8D01AF8322D4F4
      2FC3CC5C862FD0BF9ABBE5CB37010AAEA11F7D4ADE91FAFF738D13F7F489360F
      6D79F90BE056EDFECD2FDC2A8DAA579C2AA597508821CCD013EE7AA98D054B39
      E181F1CCAD3FC0DBB53E6ACE42C688C29EE3F13E90CC708E14140204990B956D
      6F6879D23882CC660A50ACBC82DA5081655D0BD82B30E105CB4CA5D654CCDD8C
      6165D9A384FB322C42B6618234AFBD7B073028B0FE9545B38893A0900C5E8478
      715FCF9A16A36E63AB116B6ACB33687F3909DD0B053BF59BCCD81D79217B3104
      90839F9B0B18FEFAE993836A164FB3254CD9D4CF5D8FF6C03AF39EA50976EF38
      F0D4C1F8805D890E26B85C4449AB91F26302CBE722AF0431B5F156F45E60409E
      B611CD7064CF1DC14A73930ED9018AC2132B7865F4EC2D58C3D32714C6F69DE5
      96856E950591F19A9D1156F547E1BF3000B6EB73EDB7E51FBC38FE72CF007EC3
      98B475F5C862CA52E46B6FB0F012CC8482E39D6F168B74C6D3C6660B2EE117BE
      33685384943759343B151E32249F27C883F9309BA788F53DA97150EAB40920C0
      FF5D8AAE0B363BC6BF1C303A5FFC47394E9E8C3E5553E0F27AF57CF9BC3108FC
      741EA30E9E2509A94404A43C47966D02F9DEA71CFE1F0BDCE69A30FE7C0F8C12
      DB7D52F2406DADF9A69555D75445C95609611A922FCDDD1CD4C869BB1C899D5C
      F6D708A4D111399323B283EF54D758598F8BEB00C3EEA0F9E4B1E4A0457FAB40
      58EFF006D8F97FE7A82F9EBBB28A03B5CC200B61049337B395B8D879B1F45EF8
      5A7DA415DE112041F2840C926BB3E924886CAA7CEC76A0D21F3F96DE3F1C6646
      4C6B7BC5EE771ED9835C4BEF9DBD7AFB16971E7B598C90E955E79B9867D5EF62
      288C606526397E63CBFB6BCBDB6702FFC5BB544BBDDA82424225B0369C63FC3C
      8A765AF6AFF7C0AECCFABC89AF501BB709873BDBB53162B0EB9CE15821284C45
      D4950F02326C6A0F0C6F30E0C30E87110D86E10F0CB0B0A42DEA3A05A0E83730
      D5A5BE8B5E69B782AD0BA5125FBA504A8AB4B20330435BA9EDA4784E5E1A312B
      44981AABE386683328CB925EC2457140DDC6FCD89CD66C8F9329C6BBB9D39156
      A8189BE8EC4091D2877E7EF3403FDA26ED46C494850BAA512A0CC308A38004FB
      DA22DB8E3C1860B03D8FD8A94093DA2295C5A0786986230E28F56EC7BE768742
      C1A6B71AF0ED25C6326C1819C427D073C2910E9B5163524FDC3627ACFDBA3E77
      C9EDD309EB459C0604FB6978092210C531CEDAFA00234E8C817598505E10F032
      BF0EC46F6686E567DBF6E3F91093A4D9B400763BD12A513A0F167A9AF5C5A692
      B94E6C1FF16C1EE78F33E23027C65C63038775536DEB04A5B324A5E0ED58C592
      BCC359A99B6622FD33359D014AE01FA11B299BC70E2EB56C921AAD9046D4B396
      BA473174342776FA1E3668C3430796C438255302D3D16C892A7ECDC9593042D4
      19349FCCF3F3578D28A81D61D9119D113BA2EB1DCAE9A3E6E8DF13A47693C369
      09F6834907CC9B9D619C93553D60691827A026EA2E411D0DCC90F4C07BA118EC
      D074AD22A327A1D8FDBBE7E79F80390FEC51B75900B550659E3E11D34E12CBE9
      D514D4F8068F15B6A47471AAD0046B896943FA5584990494F887E836C93CB5B5
      73F3188C21562A77F19812E3416B41B1F988405F30D798FAD8ECD1399CA96466
      4ADA83C476EDF4E11E3533461C3CCB611AC4A3D1C583679BD378A86C862A8A0A
      39043573C6726D7369B37AD034AC41499446E86590AC16D3C50EA8E32EB0C1A4
      67EE296DF96061B1A49F2F0BB91047C02D779EC377FC007D7317819BEAB436BD
      94F6905A7D2F8150E979EEC4524E6B3D31C434CD534CA921CF31AB932F5B6DBE
      DAC1C4DE3FE7B0554C9B724B0EB26CEB11A4BE419A1452686C0F468330E39E4F
      EA7BD292DD42105FC636B9DF3443CAA1E091D240717C7FFC0E14B8E3C48930CE
      3BDEC1B6B88F749237FF8025F919B8C89BE9CB04D6F1CEB3470EBC1FB0EA59B1
      F782B72EF0349BC625FDFE541DC718276A92FE1498060C31F55FB0CE8F20F12E
      71132EF025F44D8A489130F346ADA9B69CA6D8A19562A85A5831B99675927243
      560AD0883B4DB85353AAEC84C672F14486046E44D8F1DA2059AD97F7A25D503F
      F4760EEB90B3FB8D2136F7126F97641842D7AF5B887B3B707D350B2311C86DF6
      8C74A13235DC05F5BBDBAC4AAA8D432F5C835ECB8F2294C96B4D7E41F992C67E
      4B43436CF59E1392136799946E805403EA8D72CF303230FA8CAA12398D8D340A
      5632B9B94DAE24C050AE6C5E429D3E139EB4455512D21AE47A1DB24FAA48062D
      127D265CB1EC28879C7F7D159259CB8540E20ADC934F234CB9A3C6DDD44431A0
      B2C18631567B260CCA3E470A1C838492BB9A6ABDB562AD123A9952E6952AE4AD
      C20A6472D9F01187165F9DBF6BC13F6F5944BD4D863EC513BD51B5D9E74B1903
      FBD339592E52C5C0E20D700FCDA92937FAC97BF9518DBC5F7E78FB5F1FBF6DD3
      FF3AFD5F91FB98086DDED5E0E277F46A5EFC71A0AE55739ED689B82B3D1C0C19
      F78C9BDBDF404CDCB52E412D04AE53F2C0B9184EAB1AE9290B7C0E061A0C93C0
      20ECE732A872BCCBFA41C262036FD7999BA5BEB452FB680CEB001BDFAFFAE489
      1514BDCCCD792C2F54338B7A10F8063952348AE6BCB901797370AA8DDB4D24CD
      23C1465DA394512E67108C07F64F4A0C39649113537029BF9BD2961A0DAD666B
      59A9E43EB3C8D649BC496C371BDD528C41C4CB013EA4B51011D6781363AE1460
      7728025771C315F399CD9D903CBD1C6DBC7238B468079E299F8591155F3F4AD0
      A987028B2592BCB107ABC863680E49258D7FF949A5CB5FBD0D094D8D17A746BD
      7C711B5A0FA66DB177F78EEE7FE24AA2E13234EB781FD599FB92EAE4E0E15BB4
      BA2407606EADE4CAD97A4E423FC65BBC71DE761DC3F2952F5FCF261FE6D9E494
      ED260A6D4B7C382D0AF8D45A28421EB8BDA5C2C2AE87B25C26319C1238390167
      7D69D86B69FB066B07670AD30AA2F9184673905D6736CDC485C92AF4F57032D8
      7625E5381C79679F3EBE451366A2A2A08896B0D7B0F2AA75641EFE0B22C2FD5A
      2341055DAB0D8B7FB42C9E622EF7C9DA73343E60A9F02352B6AB8173DA916FDB
      F89C8487C8B76605C0A6D28575E83D495FB7551F2B189F144A94E4DF1F636E20
      4C7FBDE4EC6B721AD4981D07ECB9EC6847820D3BB694284F56D8C961A1703226
      85BC6C7807F7B54B9088F577CA2D23EB6C942A94A5C012BAE5FDF8F263CBC474
      DE7C7AB70374FBE71C97C02327CE8CDD503DCA0AD5ABCA82C073D83C0CDE9698
      618745559C74C75B621472AC64E7C587F3F36735B8C1DB0F1F3ED922011820E6
      76166A056A3BB49829731C8B0B048A8892F33446F369E4ED9CA36D8F1B55F615
      46EA546C534DA8441BD3292CC4A5F58E01E50CECCE3019C7E8E5DEE3EA5305B6
      D9CE1B0F03FE1E46FCBD37DF4C3D0AFA4BB902BEC4947698E273D087529CF75E
      633E55A306A4FEF89BF89B9758390F4BB2982445FF75D5FD0D18431966D51AFE
      82C9F02D64719B76669BBC1185C5C07C35171471C221A85D5741E5200FB0AC3D
      83316D5C193155C8517A747328AA019AFC2B6F8A29E9A1933CD26C6E439ED7A0
      237C7A757EF8ECFCFC1583817CE8B730EBDE27254A0563D3380A7F4548814B66
      EF3119B375AA054D11014853D05A4C63A154111AA7F1C19170B6AF15B9E2A27F
      620132658FC6B2A02D042389E579F9E810D69852DA03759D67C5E23553EA1115
      8E2860931D78BB1F4DAAFB9AB863B700CA432C531A8D0EF610E71FDF73F60F8A
      0DD3A9F5072125C8EBC97C04E6322A9F6932377557D211B8C61AD4D174698E45
      40CF95290B3D16D2FE1A96084B8631D78393CFDC24D7C2EDDA6409732D32C8EC
      11280494851FC6588ECAE99CB123EDDF3FFFE91D4B7A4A07C9ED9500545D2C57
      1F63D08EB2E182F9D029EEE0227CD023460800034F921A5E5400EAA7FF6EDEB4
      C3645AED91F1D35073F90316E5854321A76C3C6D783A162806C6F78C57C2661A
      26B0A6A0BC65DC0FD844299D2B9840B5A7F1D15451E44512797445D815E71152
      2A35B02ACE192814FBD0D93467628B14EA0D5548189E20A73B0190C0E43F15CF
      23918A967E7700E2A70E6A086C5C3EB5D9EAA3E01051BD2FFC74388BB316CC7B
      F67054BFCDA7B33C59DE16D2CB754EFA71CB4366CBC0DF441801FD69E4648D0A
      88649CFA082030CF087649DC0F14594FE7B32608BB9EE7A38CD7108FA4588016
      1F24147622BD45F00E845ACC6B6D89DEADFCC31A8789AA2DF8958CCD983725F9
      E5FFFC6A610640FF27D26115414C4E655329615753025FFC6ADBB5448654C8C1
      9056C874A6F0AA0FFF40D3395BADA1D4DBA64921DA25F61A84C7CC086F2C9813
      B29141C48CCD78EC966CDD3068A4B49D5C75E942E0CE51F03750650FE379938A
      5D2B97D860C36709A61237AC61A51B804B9C3CFF178F20F0870059830B3CE97D
      0FCAD42B6D52A8E443EA56F4E6257C39C652D84F139B7E8C505FA80AEEC1F9CB
      B22D548E374ED5540AB6902D248B7C2AB08CC80E2545D21FA6A018781A798CD3
      8ABC3913379C094A55C3A67299EFCD28B19DAA79611354DFDC1CA13C4577C721
      21B93A6D0F5DA96A63092148AE05A811D2A08D1086D3B120909E4592577602C7
      17F78971886FA533839D052624E5F6A2979F07800F277B66E79D42F44A42AF80
      B35A4F41DE3940A80FAC06E23CF9D5D1BAF10B9077605271A5A5A591B41ACD4B
      C75786414102C16C62FCE6D43A9FDCDD6A4137387946066144ADDB2F9851A58C
      C6D185816DBCB87E89BA696E5A989794818380AE03671DF92957634AEF0C9707
      1F483F3517EE04B89D3B6A4B660637308B7BD3A97658BBAF2FB56047C40A2CEF
      557A9013C359474E6A9ADA4421763918F427E7655BF376DA0A547CE2B33FD2D4
      9ACAB0EA449E349769CA6E087C180C0B8796B3C99C5657145A81591DC0B62093
      CEB610DFFDCE7B4552E51CE409B674F951BAD6F9B173151D5D30E9FB7F57C34B
      CC46CC789B07A64BA7A106C8BCEDF2778102A1A8E30E796CD2873B1D5A21954D
      124A365EDF4054474B26BBC0B4D7A0E4D8F6228F4A8E08D10D0BBB43291DC0FA
      0473A5E9E427B3908D137BA3C81F8F39299AE38B41617CA6B03BB4C1C2DD9579
      A6266B02140FF1DAA094CF39E684F950AEA5F040B81039C83BF87CCE4EA585A1
      D2232DCFA8CEA4C95902AA46DBF0FEC93A47FD0C06C5FE127CDD74CA4888F4CA
      350EAA05C408974AFC620CB02F394886CF6D01CAF2D6BA3356154B576B735688
      D43A2CC3BA4991AB017752A304DC12130612625782CC8F332E2A2496BA421B46
      0A343B9F51F20AB2986FC5EA2F5674AD8D29B9CAF511A711040764B295AAA04B
      3FA755815F5E7028D6F7889ED90F38BCE72F0EF89A319C4593198D57E1131638
      2B427119630C14B3893043C8BD9B0BCC11216CCB918A7CF1ABAF7489E96E6FE4
      2DC4451CCEC19D579F8B6600E21AD348644752B30A607FDFCA252FF1B93C8D96
      90A74898ED9D8ACAD721625A3ABEC5310A9334998F2785930B6CCF79BFB7CB65
      8316BDE086935E403313368BC4AFA57405AB9432516A459D12F707CB7D0BA541
      BC9B21C7B92DEFF3962D995DFDDCC8F6FCF3953DF633FAE6A9DD87640AE3165F
      655A76B3169686C483144E4A1FCC94E500F50F219EECD2121DBA9FB58E46E7D9
      6A47E64A11C1FD61A1A98B97374FC9E7832D22309B0211FF5256318CF8C06F76
      A509099C3022BF6CD855DEB927D5A52E281F8118CC0C47B280B2F8D8ED2413A6
      56E4B8F1F0ECD13CC285C49645C4C2D21CF0958469E15D127C212E0D6287204E
      6A25FB1449233E001BAF724A8033831D60145524C33719831724634591612C47
      A25D65C4FECAD389F296EE9A83722E3945B871608E5048E5D179265A91C6DEEE
      3BDFE21FB0AB8E164CB46B61F3220A460E99302E54C32CACAEEDC28C5597316A
      E5D04FD4C7BC8059546E094406074D5667753D91A8F7702030E7C9E2CC39203E
      B952DF38340A6433D0B49668BE5E21988387845E063847C0EB152B1E78C2EA32
      31F33A7FF5F9566325783E85BC01C1479446EE61F3B55AC25BC184AC5600A934
      52CF438EBA9BEA64CDE18282DDE639E8CDF83ECBBC725BCC1A9C38BEC6E15849
      FD171487A1883E7691F0BE57D1ACE5BD57D7730D0A04ECA1BF87D9F7F3410B13
      4F51796AA134025D2055185DF1C7AA498459A365196CFB4A4CCD1A3E8875BC08
      E32059986530B9D8BF5F20B030225C11752F086E5A48ECADCE6F6566B5336F69
      FC3099E2AC68B223F8FA9BC1F1051CCD3F362CF028DCEF1DE12A1C77B7586998
      DB6F439A176CF5EC1AEFADB1F691EEF4376E00BCFF6EB64075F5311C1E6F1FAC
      5E6A9B3281BFEAA4EE20C72B40AC3EA455AFA1765A660153C7D055FE37F2877C
      7A60D8D0F289470EE1ABC888198B5BD368EAE871B3209EE93C264FBDAF1F2975
      987F0269C868239D1B55E45128465E84C94019C839901BC98C7AFB3856A5215C
      9EE99252F23610493BAD471F154D4492C86EE135379F69955EA1E5F1B18E8BD9
      8FF6C9AA1852FF04F2E9917DC08F64C87F348085B60859E5BDC222354C850D89
      A408C2FC2889F8F48911C2FBDEAB684AA908E9F31FBFD105E1ECF016EFBF10AE
      535447C64206A3659E112CA9D6D2152DCFD14FE271425DA2E688D859D89F665F
      36EA55E53271A4429A04C0A230376854A65514D66ACB3D5AA93431E865A603C3
      C6B8D90AC16B867BD8836153777367C5CE4B4222CB5F28CC9DDDB59F81AA8DDD
      198C5F9ACEE4951F469C89EB7B030429C51C29EC4A625CF39C0A46E0B8342419
      81A45399D6F0CDC9AC4E56143699AA6948D474C9DD1CD03C91A2B00D6D3222F6
      3180314764CFE04634F4E49DB8CD09C0BB65FF522FE9905AB18B7394DE2AE12F
      7B0E7FB9FE956312398273961F0E82EC157E401D79B6EB54832565E47148F140
      A5883E98A416D56DA5858B34C3C9871A3A4918B308F38FC9AB2CD4A93606F085
      264B19DE4C1124B83FD7A9D1E5AAD2A91FB37EBC3A80DA7315C85AD3A1C16806
      28F299293B12FFC07BCD5A00732AED84E7AFA4FD5AA8A9C0281FBB0233D6A6BF
      1373A03C49D13F6CEC17F47E4AA6C098E83C0EB365C3BA6A00015115174C15CE
      031A4E8D0FA670845DFAD4807F251C9F5D0E9FD159BA0AFD15A4F50DE57B7B8E
      9B0743671320DA16115BC464E5716A037B0F72289CCEA7B2AE7058267E24893F
      52BB215F15502AA46953FD171B15C3F64E9252ACC6E7B4C9E774F8D07D4E4F9F
      9C9BDDB14FBB6A28BBCA40E8876CD9DDB087AACF88D96445D623B2D07A756C37
      4A0AB873CF31CAD690E61514A7CDA3691C8D7F80BBAE06CD5F87D4AE4D7C1859
      9845B6B876D7450DDBCBC1B18B0B60B23EA792890A1B905102A8C491053B6CBA
      01A130F8536C25E5E78B6B1A3CD00B75F82FB5063051BDA676D9A4FC513CD094
      A1848F7CC42BF30939372F8D65A6992598DE80C6616841F939DC7693D87FEE88
      B4ED3681E043900171610DE835CC4A6DDE4FE10D0CFE43F98B4E75C8A3A22D52
      F67C8A2940FB981332C03A4671535AA25325259F0DA04F0D79FDF4C9575EA437
      263736C3B631E645CE59A20EB14AB0A0404628B2B69D01E505FB6473ACDE3A33
      5D56CB79006E8B599A907E9D3074879EA4F3F8D2D3C9AD14F7DA5EB16660481F
      A791CF4DD3BA8D7DDC28EBE531215C8338C92B97F188A8E92C0309992C1ACDBD
      687C57506BD50C5731B5A27D667AD216DB00AEB54A82ED5E398CC51AFC79CD5A
      442AE76894E84D4AF4D1C357A2414C4CB995BB1F9327236F62C918E2B0C5A855
      25427C61F10AEC465362671046492304352F9B53E6F20B1587E338FF36C1D211
      744F23779D8441A0E247A90710B148C5B74069A5C432B9B8DC3E6E82A7DB506F
      AFE51C6CA209DFCB9431C5B58F974226CFFEDC365BCEFB39D4DC41EFE0588588
      2A8240632E57BC612B35A2B8BC1A6166DA94050A76276B3804B74C50D005CDC6
      E6993700DB959D504426EFBC2C52F5274BD54DC8DB396CAA0195192CC9B13FD5
      6AB8B3DA3DC57B29CD1999471CB6B74BC7164838D6F1695CE4801E51AC812003
      28504008BAF91EA8831EE996236C9AE6AE3A181FE0D4264964AB06C160D17084
      E7338E2F2C626C0FBFC73D288184B6792FC7054579E1619B9C71EBBEF1A7C99C
      63F2980B51BFB6456592078FE7A16DE2084CA1BCBD27A54F240E5A4DB15F244D
      31B42D16687898D363ABC89896D55A576008D9B0B19A6C8CDA3A47A860F8F82F
      7974E159700095B4E26ACAC14BF85405D9CA780FC35EA5F3FA87CC310C5ADE3C
      D692B48DAFD3C21940F273F74CBD6763FC34B2AD6209703D65E6508278669A19
      FE8FDA0FD05C4AEB238459CB825D537D06D1ACF20998AF20479E549A2EC544D2
      10432B5192604057D05FC21C68B87C5FE67B2FBB3E05F321BBEE9CF4BAF0A37B
      DC3F811FBDA3A33EFCE81F9EB4E1C761FF142F39EA77F092E35E172F39E9F6FB
      7C375E021BFC981ED33E3DC58B3A9DD3365ED5E9C275F8B377DCA7EBFA478747
      5F77C3C3ECBF3E5AEE73CF7B81FFBFBA03CAAE878BCF3CEF79DDCBCF1AD662FD
      05A4C1DB13684EBBDB5B1A0F40B3FDEF74FB6FB1EFF1FFEB5ECEFFAB7F4CBCE6
      A414211759F691273D4C19F361D7408EE50E74EF3BAFE840A7A34461F23BC71D
      DF65A9BD570A380E33FF4A5E29B40EEE7EBEA27D944FF82B22AC73BD8C042459
      2DC38C3358813A786C046A59509D1A2BE286689EED524096E5A7C6B9B1065E91
      DBDD993F6831EAFF7A4830557997CA812FB5CDD20422D9323BE70DF67A76110F
      E43983A5F75E00729EE18A6101FF56698DA3EACA677A519EBF71A9D4CC3439C3
      F0A2C02908B6135E2C063FC314148A5498BDA3FB139D2E3E43E6505F22A9854B
      93A47EAAE227436374CD5B1F1E8D8FBC2993300AE04D2D0FA906768F6608057E
      FD37DA7E8C4E129E10750C7760D2B7C1BFFB9488C70A263F9CEB3C2BF5522DB9
      2DDF5C3771A08D71A0E3871E07C2AE7CEF518EFC27ED6C73EAE410623389A74F
      1EE0CA56CF2B8BFEFA939912318FE29C1EDF8C5EC5D2120D819DBFB52BB5FF1F
      8645C26F76AEF0FB4F1B1A533CAA099FB1CFF865B288BF65EFB59973C9AA2271
      36CDBAD189CAA5AF014C1FA21C63F64E58ABE4298F8BE4AC61C7FF77D1940817
      B15ABB7F87EAD38FB367B887BD5D4CCCD8F39E095E3CEF6EFBA591A57B2CA145
      D05282532A15063A0375C20A5F8694131F6E7DCF2981023D0F827C386F62ADD2
      EC86110CB0B0C31FE6D8FE6CB498576FAE21738AC88C17FA353D32560B4A6DCB
      1F519DECA5CD5EDCF1768315DF747D6C369E7B809D7EAA668817CDD6C9DB7092
      AA120D8D2532E810C468BF17F90315E93546D2F011D7507108B59BC3C81A4750
      E8DA648526CE3CB562D70D93D4C8385F364BD4745FA12D5F5FEFAFBC621DF82B
      C58D8BB87F08FDE5A4CCAE3A8D637BB6B48C365BCE04D613453C5753695B8862
      DA43EB04E53F15BD3767B3F6D964EB0DDBE926F374C845F2D4887E186604E24F
      40A9062C507A0AECFCF2120CCE5FB90B3B6C2013DF7A869145441D6A30ECD742
      9F52A3CD98CC2E01EB6456008D770B44E605D9B3C446A49C3407875B05AEC540
      A82D4714E705974CF904C5C33589D48E5962B1BE77F6EAED5B9337ED7B3F7F7C
      FB929C8ADEC757AF3FE69FE3557BA67B9B42406C3F5D169C24701ECDF6C10CAD
      F5CD455CAD7EAD66AA301D43170068B94AB3F25EAE54E5FA0EC63C179A4A5E89
      DE343C3B782D67A47E5F25B44CD017869D744C757F14D9FC11539584C5C3887B
      62476352F70D5812B687CC187D6CD732F510DD39D275758F1A71AE8CAF617BA5
      2BE3C0B933051B66E5B8F44C61F2CE74954C39AC0308EC6C597D0476519E304A
      A6CDE462647F834B815C224D0810F4EC1F7B84F1890C2E87E72CF4F062C1AE82
      BB34381FE91EDF7913FF060C9F7A766977111BE15C94AE3712CADBB5382446E1
      5EADA6105C48F4A69B4B36643F4AE056DCE5781137A7311558EFAD54B71D09E9
      B15962E505B50FFB8D13A8CDA5BBDF59A9613E32294BBE01FDCE7BD6DAA732EA
      2E81D4D6A0D1A03AE2185155E670483DFDA8BC55A6374BD528BCDE02267D66EB
      C2C2D5005006AA0537ED50048E45F3F9304092C09BC844424D07E12FA561241B
      0B3EE1D5A699491FE5A1ED197596111B8C02B55D362D2584E24BB92B248C7AA9
      B2BC6F6DBEA222CB7949B85D36618AE64A135B77F0757D7CE59FB99BF3B71CD6
      32BD3368A3BDFFF0C913F0673F5EE6FD3E194F9414B4A90030E6B12C5933FE2B
      4CF3AEB94DCBBF1A0C5794FAE18A55E4ED321E1BFCB948434C46DC6B8CA475EA
      AD536927EFB15A48C4360D5808F1B69CECD6361ACD2BDFBE2556D57BA7A58D9F
      AD9C3CE406661A8A9349A9BDC9B890156AC1C00B674E74FD6D21833612EFCAC7
      969EC466D0F03125BBEBE329BC5ABABAC03E1913A83ED6D984E9948599344BA4
      AA9121D178E4B0394123AE212E9E3E5176B099291F978713D2FD3834CD4C8693
      24E4DEB63BFFA5B4E9D6BA437260E77D623FD89664E2EFC8ABB5D67BC0188A6D
      A4818BFE7423316CB7995D67798A04A7BA27B9AD388C3A94C48C2C031175F3D2
      E64392BE335B3AC859FB2024C4555DA9451D340B3E0E3C965B31430EE5518644
      D1275168DBD592C612910C050B14E1EB30B3D6B0645DC8AC65156BB0A0FC9908
      3D9C9F6018D00A5D194B535A79E6AFD246993357ADEF294379C6BCF8498CA033
      3182D8B82FDA58F0C8B37FE088D81AF3BD59341F87B14B7C5B023C9D476EAF94
      4658978B1B2A4914AD1F5B44221F7975FEB691C845FDD68AB6CCBF54DA582AD5
      F14DD718C955F4FFF0FEE7EBD7AFB9591030FEE98C8375B9513465609C11184D
      F95DFFFE1DDD76605BB28DC0222BF6BCC8123C0BA0E7C6EB66D4969DA91A9DFA
      211DD38F8A3B9CE7E7146444A3396FACEA44B73822181B596537AF86A7526B09
      B0A7AD13CD89BEDDEC01214DAB8C5D3EB06355390CF7DCD502A6EB39AE481A2D
      6A7DC0A2305D8AC43D752FB51E194F63251D024462DDDC0861141CAD88D543DE
      D10D644C9DCDFD7715AB1414A17F294A6285E5230D0FB7DF87F7CFDFD994A4C7
      C20EBEB064C1A15859D1C2FEEBF0FA07D42BE100C74355AB74E136F3469FDD76
      99469D39BF4FEE79D6C824EF63E25CBA8047E1BFCF42DFDB8C5D0E2448A1DE98
      191426AE39810276D88378A0441C145253EE1B2D20F8D4D670FAEAFC5D386A50
      7E6BA59045FE8CE300EFA96AC1268EF94D0701C72D29A4716B7568970AACEE2F
      FBBF7A7A391D2491A4681411BC874C66B6C4EA375C95C5415F4C0ADADB0C3637
      BB800411892363DAD35992E6AD453149AB8E7B8BAA66D0609CCDA250490753C6
      FE8019E4F054641E4EFDA5381031612249C709FA178BC82B38342CBFB1B8DBA2
      B9E14B8609E969037F7849DD68D2036F97E33C9275263E3EC930F3C8E983D62A
      55DCC54966BABD39596AEADAA7BC1BFEC2DCC92933F8CE109D5739D00298AB8C
      66420FACB1EAD5F580B617630D7A53B292016831C179468421387AA3C6E25642
      68F93489B3DC231FA896C936E49D64760477405FDD0394D907672E8C09F7C165
      9CF8F52BA195BBFCE81F002DFC954911A44BFDCC790A7A93D164507EAC6DED39
      E6F14AD43058DB0EA6C7655083DA2B90BDF58D89A74FB89DAF1BD0A463690961
      88E63426E7D3047409C2AB30988351647223A9F95CF17EBED8BDDD2EC386071C
      705E5A7E5EE179C3FC28FBFCCC5D07AE4776C31E3F5B707C1994C7A7B4A6C23B
      6AD0B2B080F43A46DC5554B0418569C5D798A9D677F613704968EAE4EC0E96E4
      51D8C42D2983739BECE60B61191A3613C62E04F3817B104C4EB8D221EE6ACCD7
      A5EC564AB56D7344DA0543A53C2D0E95EB8DA0681249C62C69418BF3A3B40E25
      FD60C9F0CAEE10BDF572F298E3E81CDD116C149C994DA515F9010B02B3D96B74
      936AA18BB920ECABF4D821F11A99E5F7B0244D5ED90AA46991563B96C11B9F4E
      4E3853469CA32786D890F37A3BBC21ACFD62642F4221117547F8CB7F922C2920
      FAE2375C2DE6E665161617BF78C7FD79FFEA759AE351A3B63E5FD3D801C2CB93
      A6B430C0E6B0B887C5EAEF163B873C8FABE7646164711E3375D2D1B4256E796A
      5A0DCD6521A55C530A02C109719518C6B52BA0FFB1E716D510C2FB9136C98561
      4B929A89A12646D551FE70E2CC009F4F33587B027EDD88A7FA759C233052C8AE
      91AC3752436CD65B03BE6D29F672237D40139E87AC07A78A4C80215937296E58
      F1FA80C159E330711E494BEA93E1812DEFE0E0806B2BA7980B38C60EDEE3FCDC
      8BF1BEA333FCE4173BA65F293C636EB1783171226550E61B6B5AC253C70254D1
      69C3B902855E5219B8040C535C8C9A0DBB660CAAB8E66949EE8BF010698F31F4
      B97CD33EDFB4F5406FFD7669940268217D36291E5CADF3724D58C268FFABCB85
      9E803C751C667AA5D22C6F408D7162BD046B738A099B0D1FA90EC4F853F5368C
      2FBD67DEEB0F7D2C66C1BF1AAE91C36A3A6431393A78D25EF7CF5F196D368C87
      D13CD8E270BC11E3D8E4FC684A6E26698E29D61FFA9C0D25AF66078BCFC89A3A
      4F31A4CEC0F20176986EADA4204AC2740DDE1560A65726ED06579C1964B7A2A1
      6EB7CACD1D08767EF0B3C90EC1048982802A8C7C69CAA590D1D4CF1D479E6C86
      11B49019FA0EB7DEA00D61CBBF8453FB99304E9956D1347012F7AD6686CA09E8
      643C49DFB8846EB98AD6C6CA0BBDC01973DE461C68A3E16EC0BC720E960F8C48
      C88C3CC019E6C505D4C5B0617C7523D0C64BEC7A2B59B59A5A17F528BC6EFA0F
      BA2C31C2B4484F327830497323C51C393DF5035BF6B846709BFD6B2AD460738F
      B74AE878539D08CE6964435F5A95696593D0257B165BC02EDC7C9B798C231DC7
      94A3F0E6D33BF2519317D1C07338DF6315E91C2C9C780BB6F69C838CE110D827
      0E26D4D35CE7728AE2C4378E96A2209A03C9650B159C7B9B68DBF274228E58AC
      0A32FDECD6DC23646FFA3544456C431DAB1E5E8192FEB48E1100938165C5A475
      424FCF6100A45AC9CE465CCE83257660157F4E3B2FC601C515AFA2FA66987818
      F0F46F87E296AB32AD778096F314BBBFEE6C20AB4C9310F1F072EDFDF4EEF94B
      EF871455D52C54BA4EF9F7FFDFDED735B97123D9BE2B42FF81D72F96F6F6DA55
      F8C638F641B23D63C7CAB2D72DCFC48DDD7D40E143E2AABBD94B765B564CF8BF
      DF934015C9225964152D5BBB314D85BA9B2480021227334FE2930448B2FBE4F2
      6E79EFEF3EA1B8E39367F948487CD57D9827F0CA02A9EB481AD7AE9DA231E672
      0FF0A8722EE82C7E6ADDB299DF2D696352D1DF72645C2C4BCBB211A759B1099B
      95BEBDEB68508F35D081332493A7B34BBF9CDFB6866123A0DEC0C24FDF220E83
      37A3736AF22C059DC9BF74AF3FBDF9349CAC008A7C18D03E6DB67FCAAC8D78D0
      62F9ED57F9E0C52BF7BA58369797074229F3F2F40757B735CFF4EAEB4BF9F925
      B87E4BC83FFFF3F75ACDBEFEEADB571DECB77603907FD99C8873D1ED01595F6A
      73BB9C2F96EDEA7F7FFB7DBB7962424CBD9E002DF3FCDD3EAAE259F3D3C984DE
      645EBB0465EE8EBB6CE28EB7726DE6CF66CF694FE9DD76543166B0A39D105EC3
      A98C6AD0C518C547962BB78B416D073AF2B8FB72238C32AA996FA3FA64BD8FA4
      1B40EC528D5F89FA6C1308CDE20DC2AA7C86A983E1E92A49EBDCDFD1BD045D4F
      01229BBECAF25807369D28770599C725F2DAD0CDD3CAC58485A49F21C95270BE
      75A48429378B3CEC4187FF51037A8B19F2800A74F6C1E08D9BA228CB2E7CBBC7
      0BF1E3E7396AA6D5D340E583A5DB3EB9BC04921B565676589451FB0139C204EE
      2ED79B0FD577FE21D7EC410F3FC6E9DD9B25556505CDD69EF427E429CAE408AD
      307ABA3DE6B0D1E8DE1EF7CD92FE9E884F2F563984E5078B70DA451476495BEF
      E814A427D4593F7E4F1C155D4A47219561B7CDD0D2133A15E962F6ECCB6F7E2C
      A3F917B317CF5E22D90F7FF9B14DFCF2D95FBFA3ECB9C49FE76ECD6717F9D4C5
      274FB7467AF2E56BC4859F3E189E2D8A552476D11D37752092E877170912CA26
      D6DDB63522D9EE1EA74C34283921346C3700777469BD0BB8DC439677C19665E8
      F96E42DAE5B6C861D4FF9DFD72317B3FE9A0F2DE3699CD0980ABE896344B4AA3
      215BDBB94BE369C7EDBCAC30DADE0A7FF2812D352C238CC5D0D06452773CC5D3
      0CE23CEC58E698FA8F6DC70BD2E2BEBBF8DE957BA66E62E679C44FA68C7BAF7B
      38AFC9DAEDE683BAD56DFBEB74AC1F378E3FB50B52A5F24B188A47CC9EE43969
      1883F6F0C43C5375F5BEA3ABFD7B3FD1FBF4F8938F79F1F4624300073AB4B730
      75F77483ADBE21596D8F03B932524652183F36562EE86AC3EA63A6AD6CD1DCE0
      3AEFD79AB7CFBBC81BB1F3E807B40BFD36EFC6AEDB519A0C32547319D7E34294
      6FDA74617F87343E38BD3F8360B4192F2FCB16F268C3364CD692FFC3AF1AC91E
      E0D7BF430A7FF09686EB8838EA61C7F8886191EE2ECF76906D6DFA00E38DB694
      A5C59D623E78EFBE75396A566E622CD6BBBDEB336F57DD12767B3CE5DAA69471
      8970B1ED70F348D5FA8B5CECF6ED633476455B4B4784DB57EFD7E7336E3680B6
      B79ED0552437797170F16B25F0CEB36ED9961523954D4E99E0D836EACDFDEB36
      74EA0D24AC9B95071336D67523B1302FAB1DAEBB9B57365F7576B5CC386CE52E
      94207BABF542B1EE141A1ADC2892A2FC5B42247FF3414E05A3D546EFDA79E77C
      8C7C7B37EAC566857A47283612CC09DDD5322F69CE52A30CC425E81BBA576559
      8EF96A39C58ECA3D8CF08E086FBA599DCD05C534B67FE0CA5E10685AE0D4AD9F
      5FE529827B9A0E6D87141F2CDC36613F24C2B5F1799279334D6D81CC5ECD5774
      6C4F37BF36C2209529B8D636A22FA0FD795D240DE2EEF74B2169EDC0CCF625A6
      6465CBEE8A9B725EDDF69E0F5A7FB9DE0F92AD52BE37A8B7D672CC9A95F56946
      B466A13DFDC8AD4A40B05C73D872F2CFA69AC459DB13BFF1E8BF6473BF1964DA
      94D81EC8DF5B0FD1EDD2B818339FD6B984BCA0160FA16D478E8AF96CF6E479D9
      B44F495CEF48E3ADED711B3915025B3C53BBDDBF7F04D43B54F4FE76FC06AC72
      6342596BD29F1B0574E63EB6ECF575CC2B3AD6CB78DC418DA66F4A74B6F1A2DB
      3E38579E9A795D66742874200F57B6068D91E4BEE7EA2DB7E9FCCBCE96C48B81
      95C8EFB63D75DB25DDAAE7BCBCA62B1A41262D27278240982A5EAE6C52A3ABB0
      B616E474394E2F837ED8EC32EE3C16A21F9F74627C53D6621F5ADE953BFBF4E6
      C587FDBB3B7B643A096F8F068E11352D486BF78CBDC987C5C69BEEB0B1AE885B
      47B74244EF88D9CEEFF295093432BC5A27CCAB7BDFD08AB8D6F217D3B6BBA1BD
      B7E9AD3B8ABE9DE404E12D43169B683BAF3EF86C7D5DD8837E0D8F0A7DFFD55F
      D06F2D4F7ED08C4E2E7F75CB7CE87F11CCE993FC0E2C296B457B4D548626C86F
      DED292AEB85ADCFC9F075C9E12E8E59BBC7E6151A8C5ED62DE868901CA7F4D53
      55797F3768DD62F910126C5D33903760AC36B4663D5FD05A649A484879E3F572
      797F4BFC6447C8EDB2BD276B2A4983BB2FDDCB1EA572DD983B3987F9CD7DC67B
      A03B5DCA5A83ED9D255B0F268B7D7A97C5BBF167771F69EFBBEEEC5982C86CE1
      69C95CB713A90F225AF1D2BEDD9C733EF17E545AF2F6F6869E7B00B3FB88ED84
      B20092E674F2D873A2D7ABE0CAB28DBC9BAD9C519B5C5ECF51D65AC089B6F9E9
      79A59D1D776DBD2502BD129FCC5FDFD0C1076338B55B9F1CB65ECF484B79CA02
      18447B77F9B656DA8D47699AE5E26D19D8B9698396CF66FF6F715FFCF4DB3C83
      D250EC97978BBC7BA0B8A7472A17CBBCB73FEF55FE2E2FA49C7DBEB976A6FD84
      94F6C79F6E0843E5C29C6757F3BC386EF66F3F5DBE7A98B6ED4DA7ED2CE4DDD9
      3A42A20CEB6335F20255D29CFB667B462F5B8C4ED42F2E5FCDFE65F6E398D363
      BAF8AF74CFCF2BCAFDE52572D3A935B110ECEDEF5ED0772F16EDFA95FCCDD381
      F9E615A26F90EDEEF090CC89D7CD682FBBDE9A70DEC65359E1DA47549763E096
      09FAAC05DCC3F566A3C3D567B7B730BE656171DE2DD99DDEDD6D4438BD7EE8EE
      81D06C6F72DBBA54776745FCE64AF832B5DA9DA7BD28F7FD2D9AC52FEDCCC8F6
      CDBC992A5CCDAFF127CD0ACF377B14DA52BABCD90ADC0CDFC03ECBEA02FFD81A
      99EE60503A5774DA24786F5E663D7054AA73D14D56740B25DA5AAE6571F211DD
      F94E170307CBBBD5DBF531533B5B4F884DB99FD757A6CD9E5C76F422CC571EE0
      A4EB7ADB2C9B0D2AE3F9DBDFDEACED5877C6BDBF5AACDAAD74C75AFD011AB5DD
      1C006984715FBE5B2EEE7616C8B515DB6E7DDBA9684837C64D946A950F1EB8E8
      D62F9623B7DADC791B65B7E48656B010E43E5DE129D1DF4F59C6929F5C9E440B
      454AE9EBFDD6345CD99BE85A91F8688FFE7D7B707EB7C628C7B02D29DCBD4580
      8A797005A723D82CFCCC9CB736A1FD6F31EDBFFFC99A90898F08C8222D452967
      557E9BBE9BAF48699EB8486BA4FF34FBF65D437F7C017D2E49E81D19D83FD114
      1452E29BCBC5F2AE7CB9FAD3ECF9627145B1CBBFCC5ED185CC5FFCE14776229E
      22DED69E5E7FD3B22C8478CDE2F48AB85CF5DBEECCCF03174CE73FEE9737F956
      EBCD1C4C77AE1668DBFA4A8A7C8146BBBCEA231C9C7AA07B5707BA75DD71AF2E
      737FAE3E4E97A18E65D54077CA762746DAD1D7D631CF70E6067C46538E9DCCF3
      598D65643AAFBA28D779CE7CB95664B685CEF6CAD2D323207902706D62FFE895
      619B9E7B1EC14ACA01B24F5C7B7456EEBCF6EF0FDF5723ECEAEF72F2F104A17C
      7D137EBB483EF0E2FF9D6355898C10696AA7756922B7DB2151EE339835F74D43
      A798E7AD976FF27EA4D872652AEBCDFDEB4833A1B7B10C01E6952F94FCF3425D
      F27ADFBCD71A2686B6734ED811DD3F04F66AFE96D8CEFCF4B6D41137706EDCE3
      DD2FB656F8591BCEF08B6961F08B2B25F04B4853E19714969228515312CD1925
      314C88929B92C007EB5C4C652D25AA6B5B51AA9A211DFDE65AE4744249F5FBFA
      64B4FEF747F9CF6EB9DB8F4349675B3B66B3027CD9DDBEFCC5D8221A322FE39F
      F7F9E708A8C727DF365E9BAA3E1D5DBB19DDFE383E31D5AF2CEE07BADBE7BD5F
      479850CA4D1DC6179AE6F962CA29B5D898A7F31A1D6FC2E8D45B691F08ED968B
      00BBC997857C4D83F55FBE89FEED8B857FFBC7139BF1AE32FBA3DFC159EE4BE2
      A79BAB8F238BE275C6108CCE8D86F92AAF26686F7EF1547D727C655038AFCFDA
      D923B15E86B65945D65EFBD70E1FADF2E11DABC5D5CFB9649A99A27555EFE679
      CF6F3939A2BBF1A65B4447974F6D8E35BADD5A70FA31F60CFC6DB1BC0A97B7CE
      C78BD9A7B40EEADF7FF8CF4F2F4AB4F531D8E0E27F8C1CEA0B394D12BF2F0924
      5FE4664F4E079D74A4608E29B7168D3F1DDC54F68EDABDA276B79B9E683DE5DF
      D61F7E346CB6FC9B76B6FE95A6B03F96B1DDDB50F30735FCA5A3C3023E4ED3DB
      318FF60C0320E46D391FECCABD5ED171E774B27ABECEB38CC7E63D13BDC5B4B4
      55AB5C67306660D111395F5D3169F1F31A84E1C3F188FD298E9D9DE245569A59
      6BB9996DC0FE4FFF81965D47102F379395682A5E895A5455A5F0DF54F9C5C080
      A20DB14A4D4AA97C56FB8AE5DFBCBC978DE02AA9A829A2C04F99A4D056574A6A
      2E038BDAA8A0BCF3B6F68D889EF3AAAE9008F14DF28647C982708F1F59DF303C
      DC3019AD615E9BE8B563DAFBCA1B4432A256DE06D330A7A54465B4F081492198
      33ACAA95F2CC07CB79D236F22672CD9A50A74A37D2736BAC775A389712138CE1
      31B1A91BA16570322484432958171E3F92CA5853D70E019857B59355B22689C6
      35B1F1CC706DB4A9040AB34E3227751315DA887A348C07136DA5599D6CE54460
      C9715331DF70A91553A64A01E28C3EA0EA75F0B5890D4AA9B989DC5BC1838EB2
      E28D7AFCA8A9EA200D0F3146992CC42022B355833AF0C49588CE0B2778650C6F
      B8AF2C0417BD33C90AC8A656681BDE3696E924597482E129AEF6415A0F49255B
      DBA68A464625D12D3597CE84C8AAC4AAC6F89A79DE548F1F91B065F249694815
      0F88AA49BCB1D15854BF094A5AE51B1FD0DE8699A83D57327A8F6AD42921A2AC
      92E4299A9A07EE3DAAD1E854B092083DC0CB319CA1372003A7516CF9B0E20A50
      A157D3222D69068C7904BE09B86AFF3604A4A41C210BF5D73119D90488B1D601
      F246CB6AA00A3D919CB495E0D43D3AA0431012EBA40C6375138088889F223D7E
      E4D1AD956B1AC819E28E2969677948D145D3241B6B2B22494759E75CA53C8F4C
      0078BE5126D65AF100702620D81AE984D34C56A80EC0531985E7E2190D01D8CB
      2AD48E434C81D775E3A4308DE2959535432F24638215948AB9289812A1460F57
      81A14232345C28C6844E4EDB5AD732050DE419AA5A84CCA0193CC95A41B134D7
      684A34C9196F53026A2023EF6D14C9D7C89F988F52A0531454C60AE115BE52A8
      81ABA1572972C99B004C1B259D0BA28EA16A6403C4059542E99B313DAB1A6DAD
      AA95692D86716B4B925FB01C7802AC8464A9FCFDF8D1F63BFA5B041410F15FC3
      AEB0CEAAA0315E840A7DCFC8AAA04F7570B5D6B6823540673480A9900A4AEF1B
      179B26A166825B5F3B51C3BE40A23601D7D0C0C80DE71A3100700C95691E3F42
      7BF0073AD257BA0AC6290993138D21506BD81BA7D16F2638616A8F8EF2CA4794
      5943C1A2D5A686C41B61A06821090B587289BAC15400834046686408AC0AAA91
      305592D5117D11828CD05F01A0C0D4A1065AEA68D09B30DE4019BE4443D0A115
      E3668AFC45AC93A882CEC8A6AF9A3AF740AD86E45FFE7EFC68F38ED79DCCA387
      454986B445D5A28904249E2A13028C5BD3A828F0B4A6F1BEB62A22BD6DD052E1
      8588C299A8A0030A7DA6154C19B453C3B2A24D825485F91ABF0347720E8B1812
      70003D8196E1E1D0E104713550066525F750C650212F97D6C2A07B1D025C0083
      AD63D0BE5AC2BAC684322C6C588055493E0863B54BC157C9592D8D409F436840
      B7B59A456EA1C2D2411DEBC672859E45031369A3765061A7E0706A0F347121A4
      35C2129A18AC2DAA134295786A8CF15A69033FC19537E86F4B16BA72AA0EBAE2
      31340C76DAE20995771C726216E2AB4C8A16E606950128598C5C595DD748A120
      D61A38084CB180CF9CF3B2AEE047612B60B5846164B72CCC464DEAD5B00A1085
      E542A7C0BB558E8A81A60B0F53E6950E11DE4D3535A4090712195C8810708746
      431FE0C55171AE54B046C1ED9A58C18CF1D86806DF685CCDAAA8131731482501
      A5E823233FC558806B37F0902129E66078ADD43EC15EC1D5C36D263C0E7821B3
      99606E2D6C628422DA204116E0E62041E4F4803ABA29280753E112B5A9E2A276
      0084939C21066E9C4F501BAB35E70E0C047849B503A401240B06011DE3AC4991
      9144BC84CF4A4691CBB6025DDEE053B885E893D6E843382ED1C030BBA4415D2A
      2816E8025A839E20F87809EA022D878F840BD190AC0543C1073085CC185B4572
      20264AED42321EFA1B95AD2A4BF65DA0FF3D4776D879800AA234D23078270338
      3502CE48016080B6427FC180781DA1FC504261210A387C06929314A108864056
      5EF2E8E0016AF3F851CD519384EE84601BA89771927806758A8D965BB80283E2
      93D4401483C461BEE1FB60AD0DAB358C03C11ABA56274809425264F08162D4A1
      A2FE60954A3226480E360C22884D84E731E80DA1E1FAFCE347DC937B86F385F3
      0F026086FD32E069CE2A97241C0AEA9E2294CD399B0093041D84694DC80C1724
      C00C938FD0140DB08486B258676A185A26C94FA2D014A237A9C643F23B0E1E84
      1F705C701612BA00E581DF05158522A067980C1E200850909A48202455192D20
      775860D439C032C32F00E7A077F09D108280AFF51E74A082539748A61A6A6855
      8B9A582BE00CD70A9B598115C12513210DA816785782B1020E8C071FF2358826
      CA86518101351E865E99C6807134E86E902CD405F4CE00D8A83E1C6E2DE12542
      10901D68AF0025480CCA032B061B55811A5B1815E993030954B03EC4E04C047D
      340E057906C754838B79017B609A0ABCB431B0CE1A0E86550E2C97810D7906CF
      82340A79D09D70F5A89D47DB9D746007C1C2F4A0F31938788DAA79D853C44C8D
      81A794B5E5E4979C8173D182894046D44007416039F0E161ABD188C02D6C22D1
      5C5808661C9E0583AAA960E119480B1C243E8522BACAA22BD0EBC03CD0A52125
      CB513701FEC60DA0C61C1951800EF60D440BF4570623B883C2C38B842A2225DA
      0CA3C560B1C040E1EE4095E1A8C10FEA4401038853247DCE7027D50193C17FE0
      1D75868380C90B600395063B0D22A09EC13068A6B0C945222602D6494A44070D
      5C25582C90C1C111A3236BA660ECC0E660A841DF40C36D554794871816BA0009
      D50E7EB94127813BC23AE24FD86058B804030C5B26010721A19582540DBE013A
      132210EF55F2DCA11B1BE03C320E9395E06F800E541B9587968646C986433760
      F26284C23015A05A89220F024D420D62ACF00EBC19C6B9585FD86E18E828D108
      B843F8AC641378112AA43DCAAE616C5883F2A03BC2298D3EABE0F32CE83A3904
      904298AEAA8995D3081EB8AAC1DE03221FE006C60BDA867213AB3914A0D20A16
      097DD7C05A03C7166E06BD0BB5E5941249618A505194A812C25FA88EC3D3100A
      A1FF828B56C182C3F75A4474301F08BC12829F86BC360C0608171410EE11B895
      0D054D1AD4C432340E2C149AA22B01FF0DCF141A0BEE03E1702890A83CB12728
      136C2C1832DC08AC132219683CFC128C3CA058813640F2787A03C406094E4450
      85C98581419445D124854E60321AC1A50593AB61F39D44BBD10E4B1EA909DE83
      99FB48511BA80E088F529572B50444410360B82591527022F864F850180007DF
      0E7D971C145D423FA190803F5811AA0CA2A10040212A05762AE1771085826C9B
      808E43DC884F251C13CC3C5C39DC29740D9E1CC570891A2444B120C74889C8CE
      38B024B4109282F0507D500108C435A81BE5821954E0501A8F032061EBE109A2
      4377D6700A140D6868958799160ACA1A554A26C1DF20CCC53BF8534434902EA4
      C72C7720E281E246A002DCC867830CB20329234C84CD14A0AA8E749349D21E6F
      A0480ADC80A3ABE06F224220F40DBE8A0A3A052207BB2475E08E8C24023B4438
      9A60E32C8A357023C4AE35F838E0087BAB11BC6BE218E8058A68616AC80342FB
      190266873AC16BF05AA0DC08FEC12CCCAA02598103873106C9817A233803A134
      E82B88D826A63D821F01BF5CD73654103A85BA7067A80BB5394AF85998142B3D
      0405AA017157BE420D604598051D4537D7527081481E3136BA08FD024EA6BC23
      8E86982C40CFC1F580348ACE61F2035C12C95D20B4439C6139472CD0C0DF3906
      68213A819182716FEA0A84053E5EC21405F443A3A11A344201910946370F80BD
      5430CB36213292B076A8196C8AAB1B44ABE00D641FAAC6337025C11A904078AB
      A035E8328C33625E581C7499A5211C622B8D8681AC015F781AF8993C32828804
      F247248588108D435FA222891A4E3C118F8403415CA982017745B424901AFC86
      8134A0079440405B7B880736102C191C426BD80F7CA0D0F7A0371E51AA047E11
      92C1F1A35FA0E5F0AF91AA091E8720A4D6D6E7F68706FE8806B62083402E2E00
      8930C21ED61C2101AC04108B9AFABA42BCD354090D6756C336F3482120B12878
      B710A1C0A01CA46B8879418E94851B0476A07F606C4D940813415B69D081C46D
      09DA11D61BDD86D8899406714F105403E0000D54700CE83197D0172014A03D60
      6930C210BE0DCEC914617AB843C91AFA4571355084001F22875770E04C8A248C
      3E92301C0DEC92868A228CC7673032C030D080F69393012C01280533EB41A4C0
      81113782D7C0C3221F280FDC126A00198E8D162B182D5B59AA6D89D29B126932
      7D3C5ADC8CCEC0379E8CDCFBE3373986275602C58046334DC32549C182348E22
      1EE029188344501D0A94A2E0080C294042585C231609081329A231A0573065B0
      07D15A90DBC66A70400B7206A50A118609BA0C34C01B2101B8BD458C013F65C0
      3AC1011188C303181B2C872B68201A0303A0605F63A841612C025E6604056402
      A10F9EC641C335948EC1A1828283A380958B048E04854280E9C0A610E908C61C
      77A0F188DD9A00E78540045A0BDB46C372A0BBE0A940B14207C0BFC38BD4A8BE
      444841A33610037898B10AF8849B44FC850E065D85290165241BE568F8C143CD
      40E61C69BAF0885824E0048483F6949EEBF53E7C3B03A13A67C4F7D86B7B3418
      2C6D703CF8541D6834F0D858E0A117AF4A9A3E1237483BF5CC53E354875E5015
      764C2BB6C7500E6BC2A95A9D1ABD39F4824F5AD70ABD70A05E8746764ED5E494
      65385813A8EF31F96C8FE98EB719B9A6B2DA484096FFB21D15F3BE72DD57BF3E
      7E44931D7E71B558AE3C4D795CBBDB7CFE05A2CAD4960C3B4D4FD21CA615E845
      4CC5482E08FF18A26228B022540B7C8BD092BE9570F7025127379402F1BEC835
      A69F9E4A805C914A5B423DCA02AD07EF7434B30033005BAD113E5014034E5195
      3A405738BEA3780E018016F857816125468314BC950C741EC151D2B94E6D3EA5
      4886F49D68BF6564291067317CA64B9D732B41E438B404A161A2F4CA9286E616
      22072F4F06AD41CBA94D02D4AA7C2654533ECBE9D83A1D5BA763EB74F933944D
      75CEF3416D19BD4F3669323AE933B6976ABF24BE9786EFA5117B69C45E1AB997
      46EEA5517B69544E632071926853FAA97B97BF434F282FFA29763E433A60A1C5
      241D6E7C73B7BA7B7F1557FF71B50AABBBF9B5FB856B496F68D1490C21A62A7F
      15AFE76FE6787BD37D727F83F791E6CEBB4FFEBBDC42D7BDED0EC8C77B6BFFBE
      2932FEE2E3EDDD6C2B473DDB4E5FCD3669ABD9CB7C08EC1783A96D2F359DC041
      AA55D32AAB5EB54BAE4DA5EBE10A1C2E927DF1810BE41FBA40F1E11B2D3F741D
      D5872E507FF8469B0F5D473BAAC02ED71C2AF6CB6804F7738D03693FCF381CF6
      F38833F2C8B35A340E30FD3CFA8C3CE33ABD9FC78E6C51870EDE87C7DDC2A39B
      7F6301E37AFC4801FCB737621C1A8E1430CECC1C2940FDF6468C03CD9102C621
      E84801D3CC44718CB36F81C49BBB89AA95168BBB9BBC3133FE7237E9A9EE06F9
      DA43D9A6E62DC7634DCA42152DEBE3272B676B7CCFB7E55CF64A6DAFD29D54FD
      BBB26635CDD2FCF5FD32AE263624DEFC1CAF16B7F996483A0E65D2B3D799CB5A
      C5C962CFF8589FCE772E4836054C6B3AED5F6D6F359BF4E85BF7FAAC7CE0B5BF
      A1C15DEEAC12D31ABA8688BBBF7B43B89BC769FD7CEDFC72310D950B37493BBA
      7C2FE6ABA9ADA32CB3E7F75757719AA9C8F95E4EEFC69C6F1A09CA59C63AC15E
      A66924286719E7E80E48EF9C46B539CF6A5B9BF78C26B639CF6869E9EF735ADA
      E63CABA56DDE335ADAE694C3C169DD8F655FCDEFAEA619962FCB910813DB7539
      7F7DE3E8EEE0498CA45FC657ED359E3FB8A57BBD74B76F667F5EDC4C53E2E78B
      F07EF66A2A4B58E73A8FDAE49EF9B23D646D7A9F7639CF41E13AEFB488AA9F77
      6C107F38F734AD6B0F839B7DB321668761BC03AFFBE66E32922FDDD57DE10413
      1BF895BB9BF6A40D80FE9CAFE26961F4DB8B98888997C408BE69FDECB4366F9E
      3FED919B7CD320B8AB73673FB6CD3ED5103FA73FA69B8A6FDEDFC62598E2DB49
      B9FEBCA05B7E63E8E73E087CC6FA18BE5B2ED67D793843DFE07F7D7DFBC6ADE6
      D308DD570B7F9F2F65FECEDD4ECAF8C3151DB734598A5FFFF3B59B5F6D398D69
      7DF7CDABEF5ECC5E2D6E89C3D246BC693D48999F2FEEEE16D767E56F83E0277F
      8BCDD3E90F7E06E67CF3FEFA9C063F3B2322CB19BF9C4F346725D7229C91EBAB
      F525D7E734F15FE3FB66E19661FA737F58C6A21C77F18CDC978EEEC99A9EEF15
      F4994E5D9A3C5E9073D3F1C5148A9D1BE8AEEE9BFF8A7E9AE6BD5C94986A4A9E
      EFCBD94EC5EF4F1D24EE659E66E37B59277A17BA567DB1659906C6C05EE550F8
      2FCB791868D696A1F3F1CDE28A0E5B5F177A98B9ECCA9BF69F76716F9748F58D
      F68B7CC7CDE59B4D80BC4EB84BBD28E1BA07D7A9D881545BAD5AA7E33B642CCC
      EFAFBBE7B603C3EBB4E2585AD64F2B0FA56DF1D24BA80613EE94A80F25A426ED
      96680613B2DDD6DBC1A4BC57A6EEF7CE576EF9765FE67A276CA2C9F6747F75B0
      17353B9C76BF507E3861EECBB1008293A1BBF4D6AA7A124B9B0CA3403590FC38
      B606321D07D940A62368DB6DFB903EFF187F9EAFBAB1D5C363B162A7F9ABADC8
      F4087FEB83ECDFEE17ADF33DFC907E377E7B73176F56712BD718C519ECEF233A
      3420D923CA3490E3884E1DCE31A45C03A98F6BD950D38F29DCC0838E68DE40D3
      47A8201B67CC07929F52C03D03374E05D9392A38DEE00FE41801E0BDF68C0030
      9B0C603619C06C1280D93900DE6DFA1800B3C900669301CCA701984F03303F0F
      C0FC1C00F3C900E69301BCD79E1100E69301CC2703781CBD19483D0EC0BB4D1F
      03603E19C07C3280C534008B690016E701589C03603119C0623280F7DA3302C0
      623280C564008B490016E70078B7E963002C2603584C06B09C0660390DC0F23C
      00CB73002C2703584E06F05E7B4600584E06B09C0C603909C0F21C00EF367D0C
      80E56400CBC90056D300ACA601589D0760750E80D56400ABC900DE6BCF0800AB
      C900569301AC2601589D03E0DDA68F01B09A0C607564E8AE2F079A74BC8AFD19
      95C3317FBF7D5D14BFCE7864F686EFCF73E2913FF696041DCEC80E3E734CCEBE
      909E2F166F272C135897D2C7E5F37973355FE4B191F7BF6579F4EEF8ECF75FAE
      E733B7938983D3507930B71FA40B3698B01F0C093E98B04F3A85184CB84B2184
      1C4CDA37A3A2AF4E19AE255D3678FDB46A286D7D28B51E4ABDD37C33946EA7F5
      7628DD6EE3E5609B64B617BD62653D9458ADB5B89F810D65D087339C14DBE141
      9E23F21B1A7B3A22CA81670CCBF4708653A21DC83542C6436D1A23EE81C68D95
      3B9B2AF7D1001E1A631921777696DCD9D9726793413ED8B8B172E753E5CEA7CA
      7DB405191A4B182B777EB6DCF9D972E7E7A17DCF559C96BB982A773155EEE22C
      B4EF19FE09721767CB5D9C27773915EDBB51D508B9CBA9729767C95D9E8DF6DD
      364D91BB3C4FEE6AAADCD554B4EF460F23E4AECE92BB3A5BEEEA6CB4EF35AE2F
      F71C118D26815BA98FFAD0AD74474DF856BAA316642B5D4B018F1A8EADE4E348
      E056867124705F6CA348E0B6FC06320C0B7290350ECB741409DC13EE28127850
      C6033947087BB07163E57E94041E92FB68000F64382DF55D623556EE4749E051
      B91F258147E5CECE43FB2EDF1A21F7A324F090DC475B90014A3652EA7BD47182
      DC8F92C0A3723F4A0287E52EA6A27D8F359E96FB51127848EED34CF840AE0952
      DFA38F13E47E94040ECBFD28093C24773915ED7BACF1B4DC8F92C041B91F2581
      47E52ECF46FB5EE3C6CAFD28093C24F7A324F090DCD554B4EF12ABB1723F4A02
      8FCAFD28093C2AF769E7127C872CD397615F5EBBE5DD99BB1CBE71AB37776EDA
      06CF9FDA9B76625857F8D77C53035DD2B0BAA3AB6DAB3A9F755495F39DAAAA6E
      CF677AFC48D071EFF94420CE58945CD4D2482382F0924E4DAA952867297145E7
      1A1D7CA95252A87CAAEB58B9BAA96B17EBE1D39DCA8BD3F9C52832C594F2694F
      432753D53BBF77BEA0FC697DEAD8FEFBF5E7BFE38B4ED3FCC77D3DB4FE1FF775
      A0F5A1FD1DFFD89A7C8CD743DFFFE3BE1E5A7FFC25C135542AFFB528D4438085
      A858DE6B7CA0ED299670FE2B9F742987FD7EE5950BD618CB521DE8706A255153
      5159C599ACA31C2A3755BC46EB3D5D1E6090B3AA8718C7FF94D7A004CE7C3D7E
      F4216BF747BC3EA404FEF7B59E5E1F4A0267B4BE8B3DDAD7AFBFFE7F163BC62B}
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
