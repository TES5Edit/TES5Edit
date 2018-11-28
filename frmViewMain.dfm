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
      789CECBD6B77DB469628FADD6BF93F6034F72E4BDD9442007CA6A7E71C5BB613
      9FB1E31CCB4ECEDC30EB2C9028926881001B0045A9B3F2DFEF7E541500921041
      4996C8A47A261645A10A55BB76EDF7E3B741928DED81E78B71E84513BBE9B407
      5E9406F4CF683EB19DB633588CF8897173C0FFA6593A1DFBC3D1D4B5DBCD36FF
      1AC6FC6B877F9D06A55F87018DC577B8CD9EAD3E8F05BCB137C8A66226F4DFF4
      6FAB7F1DA5CDDF06E338CAB261081F9A0398D60FACC13889675E34188FA65E92
      8A0CBE9F27FF747E1BFC6530F7A2381556D381FFEB34DD66BBD982FF1CF8D4FA
      FD733013A9F583585A9F70F8DF7E87291D3DE52CF645B23AA75D9EB30BF3F469
      6E9CB305739EC78B241009CEFAB7DF9F3F8319DD8A453AEB8B04503661C3F05F
      17168B93767FBFB8990DE390D666E7FB8D82F0F689D6FEF7FBCF4134F1E1BF94
      E76A552CCB763B9BA1B732E7EF3F7E80C9DE075FF0B9B11766D6BFFD983A1F47
      8B97E277B5F3AA776C3C1F3C173E1F3C270761E9CD8649E0591FBC6C4A8B76BB
      7AC27419A4E9ED138EE9501C9A5A4D18063023CDD5727738E90DFF83938ED238
      F452B9D956ABFEDA364D772126B1B0BEBCE3C5B577399D4DD3FD4F753C345F08
      93FC234E008270211FFAD6D0F6FD61E10DF657C52D78DB3428BCCDD90D29DCCD
      4861BD0F26D34CEE66589CBFEA02DF83CAC07904919A7FA75BB2C379E46FD809
      9BEE781EF9DB3A0F7449D549E433771FFE245A9D2AF2ECF678566B659875FE86
      4756ADC6C113DD3CF22651D4A25F75241DBB62F077891097F4E676D50DB63B4E
      C5E0CF8B8487565ECD6EB762E8F1F7629888E5098F772AC75781EBF865E20D83
      D189DC79BBEA3AD9BD4EC50CAF00E38211BFBF926D75DCAAF7FF14882CF2E04B
      C17BE874AA28BF3A73DB2AB07175DE9D6EE53079E02BC3F46177FA5523D56997
      47E627DD6D568F74368C54C7DCB52BC7C9732E8F2B9D71B752065287BC32B87C
      C0DD4AC6AA4EB83CBC70BADD56F576DD4D6F5E3D5ABBD7BB9D44588A92593F8B
      348337545134B7B79D3014E513C212967A7ADB094379E44D225FB99D289406E6
      78E2F6B79384D25085286E7FFB752C0D54A7C55BED6FBF8EA5D16B07D6B2ABB8
      4511CCCCA015DDB5ABA4C0227CE51009DA96DDAF1853042D8F91506532ED342B
      C7392BE314485B8E5D3546D35835A674EF5A4E95249313573D50DF391AE8560D
      2C1C220F2C9D5FCBA9125A8BE727DFB87674DD5A749485E49C69D6A2A26A903A
      BE6E2D0A2A47950EB0578B82CA91FA087BB568981C552060AD5E2D0A2607AE83
      B4B7FD36283D212738ADDEF60B918F5220ED6DBF117A504E685AFDED17420FD3
      E0EC6FBF117A507E25A4A0B4FD52E4634BB7A2BFFD56E891C533EC6FBF14F91B
      D78EB0BF8D03FDCF551624775AD2D1AA26D92A959666A9E2275B24D49569EC4A
      99719BACBAB62FBB527CDC2AB996A6A9645AF5A4D8D25C952CACAE445B9AAD52
      D5AA23DD9666AA923F7690748B4AB9B345EDAF2719D1868BDAB7D3ABCDBF49C1
      56785A9AA38A14AD33743987C4D2E2246E258D59E3F03C4911474B1355129C35
      96CF13290C2D4D52497BD664009EA4849FA5992AA9D19A5020672A636769AE76
      6D3981E72AE066699E2A36B52E36C835AD6266D1C0E2DE8DD8AD196ADCBB93BB
      E234AD3B93BBD589EE48ECD636D6BA27B92BCD751F72B73AD7DD89DDFA1E1F80
      DC15AD6AADFB70D07C963BA294E20B7AA26ABB4B0DA42A4D742F0E9A4F731F94
      5ADFDD3D91AA34D77D39683ED37D516ACD90DA79101EBA622FEDD4E7A039EFCC
      47D7E79D39661627E8D6E79B39469626A8CF2F0B9C321F5E9F53AE60606996FA
      5CB28479A539EA73C7325FCC67A8CF1737605AD1D4DDBD33F92ACD722F8EA8A7
      E9DD4F01284D7577F2559AE6FE1C319FEBDE0A4069B67B91AFD24CF7255F30E1
      280EE3241B867F1B24C26F0E26702A5173300C17A2B9FE95D36E17BF845F6FFB
      BAF9B7E7CFF06BFC7DC3242B5F37CB5FE6936CFC7AE5953C85EDF48A5FC2AFB7
      7DCD33E36F1BA658F97AE5D98A298A2FE4ADDB7D47FE093ED09FFA4E2D4837F1
      B0FF822110A3E91C8985E30C307A62E049071AC64EE85F30CC42FED2B6D4C0B9
      0703FF195A8330680E12F82FF56C604F69E8B4FBF0EF6C1166F66019F8A32C9C
      7BC96099787318E5C1D7032F9D7BE17CEAE18768310306E52DB278E0F9FF58A4
      5982F23A4C082B0DF19F20F3E64D0BF07C10C5FF04AC8B677126ACDF06697613
      8A742A44F6DBE32D63906421C0623C4A6D0B20D284FF10749E0A5C816564093F
      D0B460C90C58155552082821606F83F5603449029F8645F3C20CD11CE7B00669
      24AE335854FACF719CCCBC0C3ECD93204E82ECA669FD805F61D8062C23B5CB20
      1ADA4D0214FE3BC44DDBF01BFFDC0954F12203E088505C89B0B903E0860A7620
      2457C26E38A0BF6F82DE25483620E78016C8706C2A18367783DFD04B851F474D
      094A585A0A6BBEB4DB1B61DAB710E99234F0FB3D50D2DD8E35151E06B458B604
      B3F3F5C16CDF05CC00A85BC18C80AC44D20702AEA380DBD911B88E04AEFBF581
      EBDC05B84EF776E0C2DFBF3A705D05DCEE8EC0759911C096602ACFF7832CB812
      F0742A66C134F07D11C12F8B083E8A05BCB130A76DBD66C05A3F7A893701404F
      ADB77194D184B0F52CB56DF8278997FE204BC659FA73E067D3572EFC32871785
      76B3273F26F9C771A8FE3ECEF4A7A1FE94E0A7D170EE014D870F63FE30849D03
      7BE39FD9CD5CC053E9954832106BE0D330F113F533943F87F267227FFA93507F
      52DF4DE5CFABAD6C0E76FB341CE631F88B6DDF820ECF9F319BB13E7BC350685C
      6A1771A98AF2977732A4604A24F89AB8E7688EC8C9F88D3FE3D1650913D7B1FB
      7B4597AD739058F5B23ADB97856FDDB02CF81A49D0EA729CDD96E39497D3DDBE
      1CA7BB7139F8F5DA62DCDD16E3AAC5907CD0FB3AC475674C6FDD82E9AD07A7A3
      8533D53240AF2445AD426F96C69112ACF814FB95A7386E96B7B00807A3B1B372
      72D58476E5D880AE2578CCEAC54E73B717DBCE1A0AD77DF7DB380CE3A5F04B6B
      489DAF24543E18CEB0FCFDF058B32EDADC462257812909E6F1CF6278A2CFD2A9
      3E4B87F6B872A218258E5FDEF544BFFFFCE1BD751EFB9A643B6EE50A8275840A
      5690785DE270D6AFCE9B199C751AA48C3CAD12F2680441C1E1BA6F77E05FBBE7
      3AF0C3E9024FC8AEDD4EA7053F5AED1E70FAEB76AB8F8F745A363ED2753144FF
      BAE7B45A3C1A1F013CECD234CD7E1F1FB2ED3E8A19D7A03D3BF898ED765BF45C
      ABD3EE3C305ECA33BB152F9BB7E0A5A3F0D2B91F5EB6149F6AEF8A1B3F2682CF
      3413BEC6916AB6BE1B96D2925A4576555ADB96E59498A853CDD35791B6B4846A
      0A3F0F4F731A5BCDA257665FDDE2ADF38FF4FCBDDB458015E6BFFDD6396BAFBB
      C892389A902DEE2F80B16996A1A4F61B7DE4DFC56C1E7A99087CA7D5818B04F7
      8DFF4A1AD180FE8DC623C7D51F23F5F91FA326EC5B7EC40B819FC6C42CE42F69
      E681180E423AFF36F74642FE0544751165CDDFF8B70CB075F0A2690F16A76EDF
      76ADFF8110E2F72D66439100D1A03C969483083CC2AEE0D4EDE02DECC297FF18
      C9BD213970E86EC20F3456D5DE4ACD8D5CC16223F80847A636BF7D5FF1A6FD38
      15FBB15BADF286E80B98197F7EE52DD5D9106C5B1D95D3DF7C5476B3626F0E12
      E7E2DEE80B7809FEDC83BD6DD91992EEEABDF57A2B7BC32F706FF073FFF776CB
      CEE05FBCE9C5BDE157B837FC79D07B6BB92BE483BE8057E04F8BFC2B07BB37CC
      3D29ED8DBE8057E0CF3AA79693F7FDDB5B778592D017B8B7EEC350124DDD1F7F
      6F9DD60A25A12FE015F853ED0DDD6C164C839F8179F7FB7013EDE6EF1B59FB29
      66DDB96EAFDB75BEC6A1FF41983B6EFC0E677CF8CC9D88DCFDD176DF99FBBD04
      97C366EEB70A2EC4CBFFB0CC7D457029B3F703DEDB16E67ED882CB7D99FB1E0B
      2E7760EEB6E3F65DB7E3B42BB8BBD30102DBB39B05B82800DCFBCC0F89B7AB4D
      3FDC111F0C6FAF6F8B30BCDDF076C3DBF77B6F86B7FF79787BDB71BBFD66AB53
      C1DBFB6EBBE5384EABF7350EDD3077C3DC0D73DF67426A98BB61EE87B437C3DC
      4B56F966D3E9B92DB782B9B7E17F76C7EEF68CE2FE005B3918765EDC90DAB961
      E7869D1B767E887B33ECFCCFC3CEDB7DD775DBED5E85AEDEB3DDB6DB6BB61DA3
      AB3FF4191F0C7337BABA61EE86B91BE67E007B33CCBDC8DC5B4EBFD96B757B95
      BA7ABFDFEBB59BC6C96E78BBE1ED86B71BDE6E78FB1EEFCDF0F6126F777BB6ED
      B4DB15E1F1B6E3345DC701D818C5DD3077C3DC0D7337CCDD30F7FDDD9B61EE25
      E6DEB2ED56D7B62BACF26DBBDD69F7DA9D625ABB51DC0D6F37BCDDF076C3DB0F
      716F86B7FF69787BDB6DDAFD96D3EA5678DCDB2DD7765AADAE898E37CCDD3077
      C3DC0D7337CC7D8FF766987B89B9B7EC5EA7E7B855E174ED56B7DBEAB71D6395
      37CCDD3077C3DC0D7337CC7D8FF766987B89B9B7FB4EDB6EBA552E77B7DDEBB5
      BBCD9E61EE86B91BE66E98BB61EE86B9EFF1DE0C732F31F76ECFEDB43BCD7E85
      E6DE727B6DBBD3719B86B91BE66E98BB61EE86B91BE6BEBF7B33CCBDC8DC3BB6
      D36F3AFD4E552DF9B6D36BB75B7DC73077C3DC0D7337CCDD3077C3DCF7786F86
      B997987BABD5B69B3DBB22A0CEE9777B4EB3D92BB68931C1F286B71BDE6E78BB
      E1ED87B837C3DBFF3CBCBDED349D6EB3EB5428EE76AFEFB67B6EC704CB1BE66E
      98BB61EE86B91BE6BEC77B33CCBDC4DC3BAD7ECBED37ABFAC4384DB7D76AB6ED
      BEE1EE86BB1BEE6EB8BBE1EE86BBEFF1DE0C772F73F776B3D7EDB6AA3ABCDAB6
      838970EDA6292D6FB8BBE1EE86BB1BEE6EB8FB1EEFCD70F71277EFB6BA8ED36B
      5518E66DBBD5E9F63B6DDBA8EE86B91BE66E98BB61EE86B9EFF1DE0C732F32F7
      6E138EB4E9B6AAAAD8B47A9DA6DB6F9BBE3186B71BDE6E78BBE1ED86B7EFF1DE
      0C6F2FF176A76503EF6E573ADD7BAEDD6FC2F4467137CCDD3077C3DC0D7337CC
      7D7FF766987B91B9F79AFD5EBBDB762ABBB9F75DA7EDDACD0AE6DECC21D3DC15
      2CB520E1C07FCDB355282088600B49168EA683F128B5AD813706488459C25FDC
      87CF6FDC537EEA0F7ED8B845FB7E5BBC03EBDFE5E43477BFE72E9DFBEDF20E42
      C07DF0F32EE20DEED2BDE72E7717071E6897957BA4BBBFB2CBD6FD767907C1E0
      6BEF72559CC35DB6EFB74B92087613111E7197728F9DB53DB2345B7B975BC485
      FDD865B7EE49E25DDFB8CBDD0587C7DF65EF7EF88A72C28A505B4384B09BDDB6
      DDB3DD0AC77EBBEF747B5DBB7300C601D465BE9A79E001B6F295EC010FE68A79
      3449F7E1EC015F51B03B0C7B0002E0D1F6B62FF60075EA0F6D11D8677BC07D6C
      547760F1FB44496EB551DDDB22B0B754F26EECDCEDD8BD6EDBAD88D36BB7FAFD
      5E13F8BD61E70F7BC40FC9DB0FDA42776FDEBEC716BAAFCEDB1FC2547380BCFD
      6BFB9F0C6FDF5B4A6278FB0EBCBDD7ECB63ACD4E45E13BBBD7763B3DDB691A5D
      DD3077C3DC0D7337CC7D1F088861EE86B9D760EE7DC7EE3AAD76A7B2F25DBBDB
      6D3AEDA6D334DCFDDE5B31967863893796786389370CDD30F4AFC6D0DB4DB7DD
      B2EDAA8CF98ED3256DDD31FCFC61CFD868EB465B37DABAD1D60D7337CCFDAB31
      F7BE0DFB6EB52ABAC7C21F5B1D3875A76598BB61EE86B91BE66E98FB1E1010C3
      DC0D73AFC5DCBB76BFD3EFD855A6F896EDB89DAEEB9A283AC3DD0D7737DCDD70
      F77D202086BB1BEE5E83BBDBCD66A7DBEB76DCCA42F54DB7D9EBF4ECB651DE0D
      7B37ECDDB077C3DEF7818018F66ED87B2DF66E379D76BBDDAB64EF7DDB0116DF
      327E77C3DD0D7737DCDD70F77D202086BB1BEE5E8BBBB7EC8ED36F772ACAD9BA
      B6E3386EC736CCDD3077C3DC0D7337CC7D1F088861EE86B9D762EEED8E6BB7FA
      6E0573B7DBAEDB05EDBE6952E00C7737DCDD7077C3DDF7818018EE6EB87B2DEE
      DE6FF69AFDB65D51BEE6D4B1DDBEEBD8BDBE09AB33ECDDB077C3DE0D7BDF0702
      62D8BB61EF75D8BB6DF7DDA6DBB25B55ECBDDD6EB51CD758E60D7337CCDD3077
      C3DCF7818018E66E987B2DE6DEC2EA74FD4E45BEFBA9EDB8ED9EDBE9B60D7B37
      ECDDB077C3DE0D7BDF070262D8BB61EF75D8BB63F75B6EB7E956F491759ADDA6
      DD717BAE71BC1BEE6EB8BBE1EE86BBEF030131DCDD70F75ADCDD69F5BABD66B3
      22ACEED405E5BDDBEC9B1EAF86BB1BEE6EB8BBE1EE7B41400C7737DCBD1677EF
      346DBC8E55A6F9BEDBEF8366EF9A6A3686BB1BEE6EB8BBE1EEFB40400C7737DC
      BD0E7707CDBCD569397605776F755CB7DF6AB78D61DE3077C3DC0D7337CC7D1F
      088861EE86B9D762EE3DBBDBEBDA4E45A179DB6E77FB6EB76F98BB61EE86B91B
      E66E98FB3E1010C3DC0D73AFC3DC5BCD7EB7838D64AAF2E1EC56071477BB6742
      E60D7B37ECDDB077C3DEF7818018F66ED87B2DF6DE76DB7DA7D3AE4A77B7DBAD
      6ECFB67B7B99F08E275D62F0836922E0DFD1947E5A7F2866BFB2B7A228B385F9
      EFC5067740EACA53447EBF82E2BB8A0287B2D3DEDA657E68C1604F768AB2C0CA
      4E1F514C78CC9DA264B0B2D33D131A1E6AA72827ACECF4B04488FA3BEDAE51A4
      C316282A777A37F1A2ED747ADD66A7599191776ABB80FA6D772F1BCC1BE9C248
      1746BA38EC9D1AE9C2481707BC53235DDC2A5D74BAD82607A487AA8CC04ECFE9
      F5DB3D235D18E9E2A931DC481746BA38DC9D1AE9C2481787BBD33B4A173DDB6D
      3BAD76B342BAE8759C76A7DDED1ACF88912E9E1AC38D7461A48BC3DDA9912E8C
      7471B83BBDB374D16E39DD2ACF08FCB1D574FA4D771FAB1919E9C2481746BA38
      EC9D1AE9C2481707BC53235DDC2A5D74DD66C76E757A15B60BA7DDB57BBD7E6B
      1F5B141AE1C2081746B838EC9D1AE1C2081707BC53235CDC2E5CB4BB54CDC9DD
      2C5CA055A3DF6C1ABF88112E9E1CC18D7061848BC3DDA9112E8C7071B83BBD9B
      70D1B3DB6ED769F72A848B53D76E35ED66A76F623A1F7A633B0B14657162E5A8
      8D4071E83B35028511280E76A746A03002851428BA9D4EDBE9DA4E852BA4E700
      3BEFF54C9C85B1563C35821BE1C2081787BB53235C18E1E270777A37E1A2DF6E
      F75BB6D3A9CA40EDF43BAD8EDB774DA085912E9E1AC38D7461A48BC3DDA9912E
      8C7471B83BBDA374D1EF3B1DBBDBAC88E274DB4EB7DBEA195788112E9E1CC18D
      7061848BC3DDA9112E8C7071B83BBD9370E134FBAD66B3DF74ABCA5B745DA7D3
      ED773AFBD8B6CB481746BA30D2C561EFD4481746BA38E09D1AE9E256E9C276FB
      6ED371ABC2387B1DB7DBEFF79A26EAC208174F8DE046B830C2C5E1EED4081746
      B838DC9DDE51B868B5BAAE6BF7EDDFE1EF7FA16FE32B9124812F608E50FC56FA
      4A8EEA3A2D104ADAED4EE98FA378013B1B84A96A5EBE32CA6EF69BBD66BF6D77
      370F73360FEB745B5DC7E9B59CCDA35CDD9073755CABD5B69BBDAAB7B52A16A9
      0BA16F1ED6AE18E6B6298FD7EE6F1ED6A918E6806CE7769CF6E651DDCDA3DA6E
      D3EEB79C56173B336E1AD7AB789B4E08DA3CAC5F314C2729571C77B3629C6D83
      E0EAB6EC0A50DA1578D2693B4DA7DBEC561CB8ED549D78DE60B762A45B8598CD
      4EB7D7EDB815C76057E04ACF6E76DB00D42AB854E08AD3863377DBED5EC5B00A
      5CC9AF6AD5B1DB55F8D2EE3B7015DC66C5B00A74E9F76DA090AD56054ADB15E8
      D2B19D7ED3E9772ADEE654624BCB06BAD2EF54BCCEB12B8F5D87A5578CAC202C
      79C459C5B80A7469B93DDB76DAEDAA0D565116ED82AE1857495A8086F5607795
      E7EE54604CAB0540EDDA7605A23915E892D753AC1857455E7403CC8A7155F4A5
      D9EEB876ABEF565C5BB75975F2ED6ECFEDB43BCD0A94712B084CAE51578CAB42
      98A6DD84736FF72AE8845B81307D0731BBDDA9E26015080348DDEC01E56D579D
      BB5B85318ED3EA757B40D52AC65571235DA6BB625C15C2389DA68DBA40D53954
      218C2EAD5531AE5F79E57533B40AE65E4164E0F2B59AC092AA865571A44EABDF
      72FB55F06C55E00B2027D0A6B65B71EEAD0A74719A4DA7E7B6DC4ED5B9B72A10
      A6DF6EBA6DB8F355EFAB4017505781BD030BAC1856C58FB4D7AB625C05B68008
      D86B77DB4ED519F42A6F7BCBEE757A706D2B0656929796DD71FAED4EC5E9B5AB
      1852DB71BBFD66AB6A5805AEF4FB2880F43B76C5B02ADA02A263CBED36DD5ED5
      A9B7ABD0A50FBC162853C5A80A5C690193EEB5BABDAADDB5591F48C455360CAD
      DFBE449751BC8CFEC6DFCE2773FA163F0C02F8C719049937C725340709FC970E
      E13F0F01AB9E68563CC16F49031F27A40F20803741FAA68F6E0FB8421F2042BF
      F540FA012CC5CF5DD8751F30013F033AB90E300FFC6CBB5D9000E543C053BA2D
      97CA02CF665E36FD31E19F6FE328735B83D930B97C158032273F5C2C604DB374
      E685E1DBC403756FE607E9FCB518DB8359F8C14B26F46CA23FF962FCBF46F0B7
      65E2CDDF915A4756BD591065EF83197C88BCE4063E21A204D138FE6DE02DB269
      9C586F427826CD44F2F20BFC299E8BC4CBE0EBCFF037F836B2DE44935024740D
      468900457236B8499C26F0F1596CDB03FFC6E98216E8E09B88A7E221AD3FD3C3
      67E821C20138E1348823FC287C7C3FC999513C9E7B13C1D80CBF2CE3C4073999
      A3F0E1F7D1D44BD26EBB4332BEFA7D99F67A9D7E97278DFA2E1FE2F52C844D11
      5AD047DB9A66D9FCDB6FBE49475331F3D2B359304AE2341E6767A378F64D3C1E
      0723F10DBEF01BA0782E7D9A85BFA3CD78EE014C96A03E00C5A5CF53604D70DA
      33007DC840864F89FE94E94F43FA345964005D40B62C49C5284353EC32F0E3E5
      284BC2C1388B86FF187822F2FD7834C8E0A42F6780FFA053D3E7719C008E6441
      340128C6519C0950C4FDF4261D03D6D800EBF0268EAE6661B3F05750B127BE97
      79F0E6640CB382021F6530E1951706F0BD0078D883741A2FE7A13712D338F451
      F1872B3189E244CC826BE18F6076340CC0A5B812414423AFF12D380C3EC0FD04
      ECB0E10CAE43585E7C2322D895B89EA7D3248BE0EB056C364CE7A3811FC12144
      E9D01FC2B7647A802D2D60DFB0B174EA0105003CFB17EEDD9FCC0897E1C3941E
      B48113FB93ABC267783498B0991AFF52FA6D8A4BB369007E40DB03ACC78BFCC1
      5520969741E4DBF4291D79A180D9E69361E22753E1F9F2E3388EB3413A0F6FB2
      651444024F467F9E6633B82DE91CF61046D3CCF3FF01BB1A2C521166432F8C06
      F01F7C01EF18C01078C1087E5BD22FF021C926C9208CE05AC3C6054C019F9609
      D2AC411A79F32C9E00B10BA291084398288C97E3408470817D987E000FCE17D1
      2883FD7869E0E95990A224B062456E22B18409D3EC06FE9AC23B2649BC8425C7
      E320C3754608EEEC06A08E0416FE0E6B8D80D264E9602C706D221457F0F5E83A
      9D93A50568840F27B8C4EF059EA8371EC185C2457B637A780158190EA6F404C2
      2D03BAEA25F06436BAF20854192C16078D1384077E71E565D7C3EBC16512CD93
      3412D960E4C17504740B018C16E24D00B771EE65162C2B6B22CDF9CB6009683C
      9E65E320846B6451DF16BCFC408A1689C8A6499C65A1B00741388E67DEC8CB46
      61B498B7DB78DF6041D6002F9D6FA9EB07343F12D7CD019EBC486E50AFC09397
      1F6125E9357E00F0475391081A8D43F090D0B445B389B107183E8203A4FB6B11
      1B8AE04FE115DCAD79B4182533FC02AD70F83BDBD9D08B348FA65E3441661565
      D799679D491E26073B486F60382CF64EE35DF8048CF34E635BF029ACFFE693F2
      E876FD370FADE3DFABA6E910006A2FE3B6A9BA3451BD83B86D9EDE432DA85F67
      4188F31B6702DE9300AD0ABD20B2246E0FFE0997269761EC26126CFA7788771F
      A8BCC73F81DF0016E308140F24FA0241997BE17CEAE18768311B8CE9E941BC20
      8427C36F7300B46E91664069A719BC26220BAE129F6042AF28E780C89485A3E9
      603C027E0B7402468F53E0FA5E083B436D9516CE0FB04B12FF8A7F04B9C8A60F
      6301CF814C1DC353DED8B5DBC074A741E1177FA87F690F46782B695C342F4C11
      CD71123892D272866A45AD5E691D83E160DC6A0DF0FB0180653AB80439027828
      5055104C4A721C0A1C0521CF524B83E1A575D1F2E15BEBE7A997BD482DA0CE16
      1CDBF51B3FC82CF7CC3DFBFD3714231F7675DB5783B2E79383C47AF5E6F3CBFF
      F1FC19495689C578FD78186DEF86D15500C39D6E02184088005605263D316C7F
      1BA4CE9120082B8BADFF0D7CF1D2FAE5256CE657EB3C145E547992775D983ABF
      473C96FB1C84A42DADF26679ABA0AF3D04F85F5A2038255622E6719209DFCAE0
      2E5BDE188590111E01DC07EBB5B78C260B80D49948670D0B569DA5563C866785
      9582146C8DBC20892CD026429F0459CB8FAD28B6C238DAFAFE09BC288C3D1F29
      07CE37F166E20CF4B220B5E0FFBDC802C91D3EA50B414B0332E385A0A0F937D6
      3C1120F2657536196C7D220282E59CD9F0421F268E87201DDE584314E3C59944
      96AD737C8EAD71700DCBA4B5C38A1B9216C2EFA0C95B20F95F223841FCB54072
      5DCC537ADD0C795D2246A8065A5E6ACD623F00E1D897AFB7403BC151CB29A8A9
      8B143FAE5F140931787E245284632A2CA00433D489F06A0D450D183C7F16F9C1
      55E02F608137F85AE1372CD29AE178E0B8D360068A83B54C0254D52CA0377462
      C39B0CDE394EE219FDCAFA0A08BA20CAEE003B5CFE0C7692320616374A3BB496
      01800DC108C7E32F00C73C0BE03406E91570E0FCD3398E5300A2758408DA0836
      03F366D3D8B78E41550A835190C126BC396C051F9502371E44E1CFA0FFA2EE86
      0F7C79FD89FE0A4A23A8ACD6BBCF1FB66EE6E4AC4CB850ADB9E3557E0282750F
      C9A826E385CD3C8134D27D78B960FB62BC754C784A71E4CF288C14AED03630BD
      5A4C80828BF48F2D1EEC0090CF404839E40649A1161288BBA5D6145804B016E0
      4B0835FF5B0936367E539C4DAECD6943C5CA0E56D62E2357AB96CE866A4B6B4E
      E565D36EC6AE357831EC0E326FF8FB86032C45BFD63EC995201F1C5BE36CC374
      33EAE3F0AF7AC20A4CDB8EF7589E680DD100248008186E8A62CA89756ABDFCC9
      F2170963053161E0C8C34510FAF0D52AA1FD23F33EB5C807E32DCAD67987DB5A
      C9F90E80FC6F83634DEA7F0FE8ED29F1AF004CBD3B55058E1A17FE89497FE5CA
      FF68A4FFA9CEF7581FE90A61F7918437AC0BF8237D40E5E75C99023E78E8444D
      41E38FAC10F542502ED10D67C1F06431CF0298ECF847F80B28A0A3A900ED0DB5
      5D5069172160CD929C0D5B85D59B7801AA9B8F33A06D8834D8997CF132C8A644
      D43AFFF66FFF76B27768770FC04BEAFD0350EFCF1FCF2D3F166836C8809483BE
      CD2AF914D45F04347A6B6E94C5448FABF1EEA5058BB40236DDE05B965E0AE738
      CEAC780E77799E88AB205EA4A820473E3D74F43A8E5E64FC6A6F82A68A459405
      A13C1AFF884F79185FA395833E0B7F6D654BEB2D68D316E8F5A0BC4F126F6691
      6BE06E72C28A58F080D2A68C5DC8ED68F28BFA44E76E824FF57BEF8E4D17176F
      88FF6B34CAF106432C42EFC6FA89C313ACF338CA9238B4DE45E3D8B2D188A4CD
      5174DBF0ECD4B35B574481520F01842796FE0E456A79CB1EE274EF28E1933360
      67CF19F0D139F147BC6E6F28D2E4489937AF021F2EED5060440D534C91A616C6
      33619C0C5CC333A312DD5325EA1895A88EF9078364D0F47FCEA152E46128B075
      A32A69550985A9E122CB80474AE9278BE72C5A012B8DE0224B87D9AA5074EC85
      69CCDE1D3FAE909EE01C4E48E41E0A74D791D44D12199CC6148885E5AD1F95A6
      11ABD070081AABC4BF5593FA2B68B81BA1E15AAFE3052EE43C0C4697F792EFEE
      60E48E57774B8E97AFBBDF3700EDE49137FAFC99C21112E1D131968E40820BD9
      230B3466840221077FC1A3802D181458DB19F773E083D817E75A027A62E9FE01
      926D1D2D586AF42C9032036461B5DF7B917999B08EAF823420644E50703D2155
      64B96149E4A194BEB9348B13F885AE113E42570BAF48CA5ACB5371CC43A1F4AF
      71B118166DCD40D6F0264067E61846EB1B12AF497C3A172350C4417FF2C27822
      832410D914C8C8738D1AB5B81E858B34B8A2B0167C22F4D28C240E6BEAA56C37
      637FB2BF83875CA837A39888F378523BAF43300A0A3CF2700FAE4A108A5C7D3F
      037E03AB921A7C83562D5F273DEF19721F9C262A19023C14AE001032D81DEF28
      8B59920A4843810692060046167861882F8305D92DCBF76EA461515CCF831D02
      2FE0B25B3F7AA0C346292FBC6893D86AC0400242CB855D6E7D551C293B0CCFA5
      094E717B72EA9D8E568DA7656840FB81D4D9F57B3EB28D8DE81B5A5CC2389544
      90AC35EF5ECC00E60C0C042B6C3E4E0A461A0D7D752CA853004494E506F0557E
      DC69F5A870D2DC80D500169808A7946F509121F925C0406C2FAD7FC0D2A02855
      236B2C843FF440778A19268C6FAFD9F8A158E3BFEBA77021408ED1EC8596C56C
      1A449700B11B6627C848A6F122C4781B0D15197A83F3C8B5E2BB7E10D78BF443
      ECA7869BDC7E5EDF2F26020D94333C3100A70CA7F1D04988D4E7E81C736C0470
      9D30236C1D4D8F0CA3614613CC045054E1F3DDB4381B09A3C62C9FA0354768D1
      9F103B3BEDE68757D685B8DA2E9645D9CD45708D217C452684A154F28E62469A
      85E5656641B4C098AE63BB69C1D548D213A40BDE1023BEDAEAAFE60EDC0E6FE3
      4E34EEC407B466BA7B6ECDACF243B05D84E3427267C4324E887BFF0C5BD8BBB3
      AE1D36B3BA5712A951FE387A0BF2C8CB3004C12B0E17B388D5D71A44033DA5A2
      61A998E1CC9AC7292BC3E4028D38343788902BA42C9F68CD985FB57F8E807B20
      CFF7EF3E7F78037C08A5DD77AFAD1F138101D6DFBF9B4C05E6EE7A91F447A315
      260904F02900FE779FBEFC08B2E6508465373586758762F68702D039E61182A0
      7AA16C3E1BBCC60B8928D20108630825D9C883F8767800A902C72BCC2C85AFBE
      0FA24CB93953EBDCAB016156AB50A303CD696261E6F13770A340FA2946DE8F80
      02B33633DB4397DB3D10E9272F41C7BFCCB420D5FDFAF56236E7CD278B88A23F
      608C4771FD6CEA90344AA56DC8188D3F1258D278C6CA6D6AE1351B81001C8FC7
      8826AC87A7AC8813903C3481DC203D06EDFD062031232C224BA5C8FE4850B9D6
      91056859F1C225DEB27110F91C0A041ACAB418A632CE4D3DC52C1F1407FD4344
      97E371BC80BD0E6F4023935653A2C5E8F250D9271FFFABE40DAA016C617DA028
      2949CBB59147537409E7A12061992CFD084550E530138AC8D323FB7AEAFB3E30
      0BB6A6AC7978F800176533462C871FC763B8FBAFE15600D74DCFB1D40B26D681
      5432F2902F2794FB38D281003A500E093069043774A70E0F2815205944ECB5C9
      D0CC112034AEBCD0621BDC52315FB2D1F27353E4E47015D21AC233D15C90F9E2
      681C4C168934A0D8CE94DF26E581C30365257EF94029324571C8BA7AFC77FC0C
      9C0AB955145B31FE066231E015651CE6B67C5F784064AED00A077F94F988C6A4
      73EB417C219798BCAE457BB0B1F1109A2ABF0FA018AE15639546A48248FB2F79
      8314A95BF31BADC3B35ED628C545D4F04A678B041D13A02913752D04B7E68BD2
      2B90EECF232B9E1703AEB6BEE6DD1873967930B9CDAFBC20C4D08C066C7828D5
      13226A65470F5C6FE94CCC97200508A47E182DBBCB1A74DE312C064BDBA0D136
      CE617D2CCE266756EBAC7976DD801F0EFE383B3B3B61419647D23B250DC5758D
      8304080C51D2E33A0A95F48E06CA1D7682B368D010C8A54AF15D907DBF18E23B
      73A515883542CDB78E010A2AF4459DA00EB19142F889B1456FB927C13C350EFD
      F5982D048BF468AF84A6172CD2126EE4CAF72E05C7D37823AADBA73314285D01
      BEA78BB793EB9416C1C512265488E19F8B40BA1E41381149E46D0FB9619D1C5F
      8DB39D65D719798459085802DDE1B032198C20AE85B930B703F413C5BF839034
      269214EFA159F5C93D12AD3DF7486C4C6F90A538B0ECA6F2B052390ED0A4B91A
      878C194B1F5B97BE81FF9DCE66A7BE6F7D4945F2AD756D6181CBEB6FAD9B87D6
      B0B79393604C3A42D3C499DF37CEBC6DE2CC4DF4E183082BFE1A8CA65EBAFD2A
      1745985D2A1905D155901542AD38FA03B09AF501A0A388D80D1D39B7121B484A
      075A7E3920B29058C84F812872132F768AF05B25834115E0838703BDDE68210C
      2CAC4790773178D6CA885560F65294E628FA74E961921E83390F622B9E438481
      79A4B42173C36950289CC464358AF3E9D83F4AD1751819370289274B1668212A
      E000E5E5E20561E958A1C40BB2B9717E489CA8BA5C94A8B43142CF089FB79FB6
      891CBA4BE4501D25C984166D12E4DB7B2EC857B92149F7469C90E121F1D8F264
      E672EE35A358ED48265BC14332689DAC53B2B29ECA20F1A8E0C1DEE1C79DA321
      7E79FBB1F5ABF5F687971F282CE6FDC757A8FE908BE5F036598D065741926195
      BFA39F75FDC92355FC90F88F98C1382FB9617B4A8041B52294C141841EB2F6BB
      05FF2E842A7EB98E5C3F7F7AFF5AE2D71F097E3FE7E12DE7F1FC06755FD59BC2
      3A265339FE2AAB3E9E34ACA31F62141728BCAD1CD057AC1C300EB71B8927186A
      0FAF233F96F84301F525215101AA647D3BA6F2A22AA48F9C73561A00F6B2199B
      44A59F02C1553A66DE8D758CA54129F204644F7800E4B561E845978707AA2A40
      BD0DBD49CAF5622516C196BF447B6972BB736488483214C681D824D968016232
      6D94C345C9771B7B1C09B3DD32838E1972B0B16CAEF2826EA4FC1FBD38C048A3
      0AB07D82DB12CFB0D25C895DD39631EF2967D64693A848A8151E4C4F02CEFF17
      032801074DF2FE0A057F69A50C25812A2A82EA5F082A6A4C3304F8E48E20CFF7
      A51BA89C9D8F143BCF727E64BBF1CBF79FADBF5A177F8654FBF3CF9FDEC35EDF
      3EF65EC7F16891CAD47A8D29B54D5774F1D881BDFD5523F655A0E39B24AF4746
      2609E166C3FA2B25E59E56821A3BA6DD01D84F7449DEBA8F5FA121CF0C46D64F
      09B254A17D44053C2E8540DF33E11395215749B2A3454215CDE1678AC6346073
      A58A3FFB1AE1F975605724CDBB404F814D95BA93F3DC92A64CF84E36002E7253
      C3342C64A840C53B56B2C08D8C5221A3207F851BF2BD371B2E120C81F820A285
      114EB8461842E74879AD7530998A7F2AC3CC60DAEDE03CBA4063CF1719598C39
      4247684EC6FE80B987CA3AC2B61A16C39D83FF0C2E122E929D68130CD70B7FAA
      E49863A0C0A4D5D1A6650420934B19A3EC6DB7DB3F7F76A3C3C155B815658E70
      C70F3BCF575F89B00C305902D9C36A8865F9DA342C6ACF2AC3A8D59B30A28A23
      4270C3189CC56A76212E8C9FAC2D0896F243F21050B240D29B53B462E29CB284
      534096122CC172B777FCF27F7E5507C261F48985DD2FB74E4255DDA5A7D76EC3
      62402AC58858B29C079458E7CDE7C0ED520AC544358862F76937511CFF4BE8D1
      4D532DA01E6D3ACF9210246F3A3F842A5901BFE7025E204BFC2F4CC5FB1C1F08
      25FABA32E9F36745603DBAE21B95ADB4F28C64843BF369795AFCAC97499BB8B9
      025BC80E17C402EA9CF8149D77E67BD98160FCD7E6BD6F64247019388A4971AE
      4F3980D83FE38A61989029C5476C3A1B841591C0DBB30A88A116EB11682F51A6
      5E84E60BD6AB24DF8117A000803216D7B019FCF69D37133FC07F83DFCFB6D711
      D2BBFD28DF45DB1E8A54BDD6C432D70D4D444B6519030076E67AC9101340ED02
      9CFC78B420F7F16D378784C3FCDE910FA750ED4C05EF5B4B98378DC4F22CC9C6
      269EF69EF1B42D134F6B22C8BE5AEDA9AD739908B28D11649DBD8E20FBF776BF
      659D5A47EFE3911706A09DCEC3C524888EACF122622D1B2D05497C2922DDB079
      7F0EF75ED54B28A24DF7CE412F145B41463222611424C0E9D20C2B33A2553C85
      6346825BE8E6138F6508D401C6635483C6A32E47DF90CE811F36812A14AAD046
      7588D9D6256050B48A2F3B2E356301F8621407CE8BC2F361F632DA1CB9F1DEC3
      7ED193A2214BD60AF296A8AD004E9D21B58826A9D46100E7CE86A9F7CDD9D073
      2C72EB5C1D6881A5CD10F9F2F96DCF12112833E4AF8A515E646AE45B0A1258F5
      138D98632F0C29DE7E26D0DE19A433B499AAA758DBCB2C46299877EBA27A8707
      C70A2826629C17135CA498778B657A67708B931B3607476284E931C91FA9CE87
      7430727198C29DA29A0A48A2E782CA734DA9F4B8475597E24860C9D7E446D5B7
      CEADF40D992EB2C49C70B42EEAF2CF7F24984598C302DB804B173081E1227861
      E8CD3174EC1B713D07D090B1FC662E6DFDBA67BA7CFC4A99F98EB1F739FD8DF3
      5AF0615F6CCFBF1A2501B3D1212C6DA912B10E90D6FF3B16063EB53E113B655B
      4EB40843A99A79F3B92E2E0192E15097F5321A5A45421B3AAA1699D5ED58E962
      8E3035BA1A5DE7EFB0DE75DEF44A57AAC6020B671874AE23CC496FC3405AAA2C
      9B67EAA3C5E60C1075B52B713E9788B8B6484E19A9F156C1B4395E60111234E9
      606DED62E9EC65502332448EA7376FE88F4CB15D78FA82FA7ED5CF825C431A5C
      FB444422A1A229003AFF460528CE63F4F991FFC18B6E901DE419829EDC269620
      03006468C48A2FB108C6DA6E79A1B3C568CAF9352891C82AEEB47A958D4AA97F
      A3C44BA7A2FE865EC1D469308982710002372C74464535B0440F06485394CE76
      093BE5134B289C1E4BC446AA72FF6A11073E711F76188C6F647056744356A6A3
      2FD1256001688594059232E456823F8DA9F9F6A39036E6198219176FE1D26602
      352A43DED814B58C09DD2AA0B48A7077B1356DF6BEFEC12C4EDD7B5A9CBEAE8B
      FA145789DCE3A1E367EB044F9E5A3FAB227F3AB664ADB4A8EA61042888606456
      576CD5CC8C03237438D1040B1E25BE4C1B67031A151A3A43C720B5B04B2FB192
      917CDB77546D307F1F95232AD584C337A6F44AD664D5A0BB68FD8F82F28F1DE5
      404884856900B11F3DCCE1D47A070A0F2A4E8FBC6F7D759E3F7BE43D9FF1BD29
      632917C9DC2EF2090BFDDAEFB1B310A88EB9F089F5D551AE228F60E4AB0E76AF
      BCD12596DC846FDE53EE97912C6E07F0918ED93B32F1C1C5E4A5A37230E391AA
      1AA9959D52D652454F524A515806918F9A1339C355EDC9B940A91984FC68C119
      29C732C43EBCE174D5DCAF26B80783718FAD092BBDBD768F49B798570875DE9F
      B3DBBA7A26BBDB95C44BEB3818ABDA3407687F9321D586EE11DDFBC0667F204A
      01D5FCD6D2EA22520E8000B8F7F1DF65AD6B2063BEAC364BA58AAE336A15E307
      6362D499FA96E64C29F57E22E0370A4824DA093491DFC786E1F1225B2426F46C
      5B5433483F73F403EA5041AE88F05AA4DA300E007D8B79F01C486BF05B47AC8C
      14F0A8E25AE24569E86564B953AEC0E354D4C82965CF034E925BC2B89B38D586
      D587E38BA818AB99A9B69E8FAEF8FCC768FEED35FCEF3F1F5BE9C16E2F4B4A4D
      91B7DC2FE0695C74C29D3D30540A77A90A2E0891C70688ACBBFDE87B5D64E3DE
      1364B4A32D988D11FAEEB133AB6151C1F45A70A042AC0F74176CA7ED3CBA16AC
      F62EBB9084E88621D77A0BF8E524C88011A2C5087D07D85A0D694533D51082ED
      3F26B5405AD1ECBBCD07A61586B1DF8E2517222327F076FF779189852A2C086B
      E1F00C1CFF63B83E71FDF5140B80920C5B9060A4F4776E9FA1A1798C0E05F84A
      F171D52D98E05068BF0DAA0E0B0327C8E7819105E31BC5E94BC701820597104D
      ADA32F24B095FEFCED91E28FDAF787B664D5A7E26497F2F70975C9903685AD03
      40A48F62EBCB3BEDFE54C5681B68B0D8B011C9C0D08CC149291ECB3458508008
      BE0FDF3C3A7BFB65345702F1AF8F2EE34883BC840C5B87B8F354300E047AA42E
      05C1F4DBEDB732BF79D975DFEEC0BF76CF75E087D36DF5E087DBE9B4E047ABDD
      6BC28F76AB8F8F745A363ED2751D7CA4E7B45A3C1A1F81EBDDA5699AFD3E3E64
      DBFD263E653BF01CFE74BB2D7AAED56977BEEA757F847A36453458BD32556344
      34817B3CFD3B4A4875C75CC29E2771F4F70EFCCF505AAD5FA573316294E7BA8F
      24D53CB8B4BB8FB2EEF36724EDAECABAC74B1CF8D8FB47AC7CFCFD07D8BAB2C1
      76232C504E4E506C9674ED61A0DF4E3CAC80491A96DC046B3CC686BBA8565095
      098B954B2F7F2CC0E2974970A512C7144F37F2E736C352B9EFB1216B9AACADB5
      842E9A366548301A7E3800184526D671A985B8F2EDC82063189D6C7DAD0CC77B
      FC9629CF9FADEDF5F8FAE48FA108FE7132365D93B159037AEF66D87E01C56F9D
      3A63C2824B0E1F0A60E26421D592508208A0C6FD9BD22CE6CE6941A26DE47974
      ECCB1F2EDE614522AC489009ACD881C1AC890784233951CF4BF7B72CA2201D4B
      AC81533FEB82B434F3E673D48D87225BA2A31D26ABB1117E1F47A2F24A69351C
      747A820201AAF867D68FAA1E950CAB4F913EF3AD9A7A3EB71A0F835980BB2F6A
      C3DE68249B41CF8A20A37DF801D60726CB9D6E1F4D50D19BF2649D4B6E5F5EFE
      9B348053DE927CA2B694C40BCF93E5534CA7B8E1149E8D2FDC3A23AC88957EEC
      2D2E0022349794C4463AD58A9145A73B865E8A8FC53A9DEA6CEF3CC14F1EADD0
      DFEB6885E7CFBEE31BAD6FF829CAE029971393B1DB64C32003508484A151689E
      8481B798E1D3E0EED358A0819EC95DC8113C9B58578136C251347DE8DDE4515A
      FB832D5BE1F5D38797AF319D02F69E058CFA98EE24A1477A60927837F9952078
      D6E0584236430295090D8B70BB2E2E6F926046942DF400B65481E68660AACE8A
      28B4AE0E53A050EA2EA3E192AAB151125BEE9F5F7A375C3D4E16CDDFD7DB5B37
      DAA690F659C4DF7538E9322295C2F55A28F10389D72A43F7D1CB2D13C3A212B0
      9E429120CDF3650FF0D03FAF79EF6BD0B9ADA8B17285240593A44AB16B948C64
      D32E8C68219F8238A3866A1F8761003246D4D089456E836EAFFA958A9B8B8997
      A2A1A4BC0E78A3087D4C379D87C128C0CB3AF3924BEEE79162B65050ECFCB59E
      8AC34B28900CEA06DEE0481B8C27AFD30D617BBD8E68142E7C4AEEBC51185408
      A1B08E1554D910A41AD99540BCFD067E2DF5765F6FE0C94A46B2CAEDA76206E1
      CDFA55FDB36B2FAB220B15F30D81A7952E10CAE55ADA46D7BF754C0231D65300
      8E68BD3B392B74BC2FC4ED6C8F7E9471578F9FC3309A9F4A0DECDBFF507B7BF4
      B81E36BB3E411CD3536D1870440424283D8933632D06E4114277564376282F49
      66BC46713223C2C4A2FD50E4552256EA1806F5735757056BCA955ABBD3929500
      53C40A2067B9CB1B74619269575F4F29CEAB860D396F0D4A03AF462B05B36BCD
      DCA8D1279520218F37F04216A3737705C129AFFFB36362F2BA50CB99630864F8
      72E8A55C8087EC07CAC0856A17F1DD17296640664A6241EE437F93BF3F320AE7
      4CF7B1D198D8EE4E2D71A5F8748CDCF7E2CD49632523A3046A3E1314C426111E
      95C9D358B37CD89BADEEFB62FA90BE7F90075038D8BBE3DBBAFE31A6C41DEEF2
      E7710EFDE6E12D7FF42F313ADCD5FB5807EB707107D4DE835EFF448004151DEE
      F213212E79F5EEE1AD1E784F181C30F4FFE1CDBD08E5512E8377781B00FD6129
      26877C04A84D2C260B3E84C3DC02086D074D42D3A5F00F79FDD922B9D4EB6F1D
      DEFA93459AEA2B6C1FDEFAB1D35D4E44FF76781B982EA28997E82338402114B4
      BF6130E2E59B486A36389119E2E28D313DDCD3F4B039506DAF4D0F06F513ED2A
      6D951CA7DD8EB90FF7BC0FCE9EDF0773155603CF75D9728CB85B70354D8DF7A9
      156837067B428E896BBCFDD89231071FBB1DF5003A42C95B31E6A4EC8C9AFC8A
      EB9198678A149D9DD435947304C272BDB6978A835C0BEDDC589EBD616169D4BC
      35719ECC9A826C1F64A329FA79329033A32C98A94A173A62920AEC6C5D6B5E9F
      84C2F577CA4229D78B2007103BF257DDC511879C8EB0D22EE78AD20B29868452
      BE757028B961644CE89FCA0D93E79362F4474475AD1F3FFC23CF0F7C74073207
      D59EED50F7E02177CE7EADFFFB465EF5278303F7D0A38B215DC9B2C31DDC19BC
      DEA1E002AEFAD6F822C5DE7B352A6BC8CBBA630435A57F67B122942AC71BBE39
      92C03AB28EE1E31111012D9C9CE025CE09D698C2758A5E6A9DC016AB32F985F2
      B45F2376A44696F469F8ED7FA8353F7604055C3EEBE7299E3BD7074F33641FC5
      CC7C661E40EF99F6AFF5430CD75AA0348A9C88228040D4DBBA92D99C8E7722CA
      69087A7A9DDEFFE8E7F31F189BF09F6741143C457C5A23DF79A0DBCD5C8A1B42
      FC3CB251A65958E9DA3314118861CA1C63B193DF7D8370B09C72086690168F9E
      AB64701E28B3518C7FF4426B348D831185383C49D2EDE6C842CA797F94D842D4
      7FB837B72C68B1DD7C5700BAAC512C8345A57833A2D6E05B45B03B4B58EB05B8
      CA8934C51C9A0DF881F2C4E638180A8AE58553DB036FC67534AC6319C3F567BC
      E2D85EA01819F9641C68EB434FC7A24E88167184D8508C31F78D05A7468E9554
      F405A8CCAAFD21F20B759E1063B1530EE0E030C65ADF732AFD7C669DE39DD277
      484D914D93783199DE7EB180E8216D55196B29E334BC82D8DF2AAC820A70C121
      050F0732907A1EBD821A51A5720D9F12E15B29ED778C7402D65927FABD108FBD
      920FB39BBEB879252A924F92D749180F496B2EA891C778AEF324889320E33F54
      883E270552FCF8B778347FC2D8E3F8A16370EBEDF894CEF209F7BDB9C1C52EA1
      D80F5948EF6042B11F72D34F5545B11C8ABDDD969A3C41DD40B8224F5174A610
      D98D0417CDA54B341C638371E0A1C320044ADA78F49E0B8A5E3C2C48EAF030AC
      77470DB2923C5B6837EE85FC49357F2A5B39B1ED08A5F9CB342510BFB1B2FD4D
      D1F2F9D87A570D53D6D76A0DB3CDC0CB506A70F23457BE1D6A9170FC147CEC49
      F3DFBE8AEDB3C6A65F27DE248E8671127D35BBE74E176DADC18315092FD1DD24
      545964AE04498520B192099AC182081B94CA7E99C3581AD449DAD4BA872932F8
      95290ED7EF5422F9B72A0CAA6EED401E3E29E52F02226C1DC7D537BEE534C6B5
      3CC6DDDEBE412DD1F53DE80D76FE8673D07FC33018EDF80A4AE65A9BBAD36E36
      6DEBF8CBE7B7A7BD13E3E92521E667F47FEE85B5F23124B6DC5A892DA9B075B2
      2661BA99374A75542E57E68B03093454ED6B974E6D36BF6D367F5DEFA3F5ADF5
      8B741E4A427776F1F9D3BB1FBEBBF8B52E29A84B590C21A0F2007B28407F4DFD
      0D7363C99B834DD45FE405A738BD38CEF2602E73F7BFD6DDCF25641D21A02F79
      F90E5BC7E43B5118736258FA2D37596AC968D3FD735D6B7677505C4540F7DA92
      256864D99ABC148C61ED8FC3DAB73ED46C6DE6FD05E559A4B35FB9B3148B6ED6
      F1F9A773D7F9F665FF6DCF7DF5F66D6D0D81648D9AEFBB0BF979D0055C90E718
      34705905D29038159F9AAA10016A3A1C2FB57F99DC96491C527FFB305C315070
      08C9CCBB94A5AC5EA0AF75EA616DCE04C802B796C30A75DA4B4FF2A22C68B9B9
      78E6C70B53DFFBF6135BCC7D0F8DE42CCB9F7D0F404250FA67F0B5A9C85C1388
      5515991D5391B906F45E2D26E3E05A988E9B85087F6D0A4E84F46205698A0557
      81200A6E375CA314C2B5C978D994F1E2EE75C6CBF367FFDEEEB9D6A985640403
      DBA8312217FECB2B3FD26FAA9310A54ACCBC888B02A68022FEDE1D7BBD7DB760
      DF3E90AF8C8358B8AE34F27B8A0014B339069262FDC338C1AE9C74354EA89D24
      C621A6D44736B5B265AC7D283E1B0CB9743508070798900C7069035C98AFF8B1
      C08E2A40186682BA497058EB2C8EA8D156C05D56422FCDB8150A854162456E51
      831473F1EE34C8165EB109F261C1AA03B0BA1437C318C98C8E8CA22EC4493C27
      7CC0EDA41A94CB38B93CC89D7661A79A080CE310631DA21C45C60B240718D00E
      C8121F2451804DF69024A883E38410557B7E2E8BD9C50004AC6D97D7083CF8A3
      ED17778D0B87FD4DE324F817A6C584C814624C02C4CA82D8B700E4F83A4120A8
      190DE32C8B67B338CDB847CD2182A7DF04F07861F6D7D12249A9A7DE95C062F3
      2A4F872A31167A0AA700A670318B302307DDE380334354EF8D86734F0DC7361A
      8ED170BE96866314980A05A6B5F70A4C1705F9340B46974889937859E2C81C1B
      87F43BF2AE8209C99A7B77CC35D8501745CD4F5C717F1C7A5C8D1737398AE7DC
      A49072084108230DCD4FBC09254E453EF1F6F9614A645D143B5F7B99B771CF7F
      A89DF673B5AB06DA4B0CA77637F304C4EE953827649D6BC5ACA94AC3698F6B1E
      6006C5221BC3AFE818C38EC186B3DE0AF4BC0E8C69E356C2C58B601251B84424
      931D459A92C79938EBCCF3B1A7105BFF9909AFB60D29E5B563991DCC979A2DC8
      D4900826E3A056C2ED5565CFFD38AA9F655F383850DE74FF701161ECA1BF7DFC
      F006DE1E793395EC24AE2959FC91BDE9584B05C9C319BCFE49AAF153AE1F9196
      8C99EA6327348CE36EE7F177EEA579A6536D947B2913FBB9F52A828EDD85B265
      19EA8F0D6B1E0A2F4574A2EAFE619C51232FAAD2AF42AF39A9539628C01C072F
      9D0A69A60C224C3009615D9B3AF118625E47C9C46648C0A00D2197CA12880247
      39688E80CE8E1664EC08B8BFCDF66A8A1861538A9C2DCD07B036CD77EF6B0869
      1A43480DE87D7987992E33630991975B756B5D2AE9152302F32EE1C345105248
      9C869BECF428A5256F94055714BE21335F8B05038E68C411CC3CE43A01F2EECB
      8019FAEA3818C591AA93814946A118A3269744D8A957651CA14F6819447EBC6C
      6CDF548C1D3D3D1AA8568D1446BDFDE35CB1C25D52A36E9949254121E4E6D8CA
      176EA65CB86EAD9EE1D8DA72C2BB086DE40C447E2B975990056E8A6BE12C059A
      9E931752812845D6AC08C4D1F7D40EF0D847B76DC2C5DF6234E7C3B782935239
      CCEC84667F0D8F59C7EAAFF2E9EDC2909CBD381BAF6897EC33DC80ECC58C86F3
      4B44061465E294641729E24BF19CAB75C573F51706B48203B0A529E785CAE675
      12E3E4F4D41496FBBFA20F5B64462CAA713A96B7443B0B6A71D467398EC66140
      A514418D4A0C392D9053291611C0142950423F83CB4A4704D3E321951D231CCD
      E006D67805C29769612A274B91E491F0EF45A5526F8AFAD0F95161B80720079B
      6E3B3E5C5175537B87D53CDFF0F8139E0F47E633E90D95CA27A92FC9EB5A035D
      C75B9F08F2386F45C411A7D36012C1C2519BD5E80DC7922D8CE2B405A0EFC544
      44FE26C260042DBEB652F747AE460B94328E220F3F05AC736ADAA1403A5C6459
      1CC9189B2C9E4C42C139FCD4B59C8A485034B37A3E8BE350D2073908F52E0A84
      CE8B1A025F1D061147D8E0E8737566A4EB1DD3CDDCBA273E5FBEFC7A026C6978
      BC76A14F7690B67E96D5F54401A9660896782EA2065BF747C5625563D046298E
      5BC0BBE5AD66702682A4B1861422B3111517A6E78E4B5BFEA6B8FE1335897CBF
      046690AA37196270FB097E0FEB3B7DFDE33B6680E6FEAF4B06E8B69A7018A504
      568D19243C8B6A80AC542B73F691E503E315AB5E3F922EE80F638A5BA434666E
      10FE9F1600FDFF5508AFC40A59CC123B945AB2B67730033072149BEEA04DD762
      E4B1103E04E8D2D2301452F61C05B42DCBDAB80AE6AEA505C2ADCA38A3426931
      E69A6DBF666F2EDE1B9753853183030FB54903911BC185F74E213B95C8990A4C
      AEB28EE1222E912DC8FA3867220D0BE5C0998F06332D59CB9ACC704FCA739FD4
      5678D588495EE354F7A497496CA4BF7BD611C9CD47561AC6592E68538C0ABC3A
      48B032E4ECDDEB14181C7AB979182EEAED9BEBEB6BECA535126775A0F7E6DAA3
      2B49458170022C378935F8E162C86EE433E181C090D3B16295645AD1628E1F9D
      B66B1DE1111CE9BD1D379BF897B7AF595E6835FB1DBD33FDCCDB374DF9D89BB7
      6FDF9E284078595EC50883AC77AA69A38F1DC33FB8773D2575D3E416A67C2652
      35D1EB40DB16FD5556DAC49DE48568B7BE95912B4933CB0F2601BB6FE83CE89C
      88BCFDF0F1339C6C22C2800A9DC8EED03E3A93665844AFB0362FBA4177677DCC
      2A549E466B14E5AB51690BD210B9202505E8B3BB0E19417E3568A5379A5EAB5A
      6558AD52954347C3337B9652194513591F87FF0090BE7BDD504D9EB936640E02
      79E718040D603BFFCFDB1A188938A0311E781F190A11361CCA9073910DB769A7
      9B280985AE2FCC5982A1821146F36B6F5FFAEDA3BB38DF4D2240015868AD8469
      AA2BF8507E4E023DA1A3975F02A631742D902AC1A50870854A20D7E8A4249515
      72FAF845327F4CC5C28FEB02F0AB810F0153B8520A9A356E02019CA994843877
      2801EC54C5B6B6405D52708C9A4879F05857142679CE8FE9CA13192FDE097975
      8BCCC00866B71ED7272C722822CC7C7975639D7BA4761A118D10B90C9B62D938
      295230831A79DC63870A4BF357E48A62BB3FFD5572B538C26A2CA24EC40E7B10
      12219D5ACC95CF3F9D6B371357C5C0BAA6582662242B5D7326796D7E023B641D
      8656C69C16DECC6B8697268211027BF14C13012A5C48696114D4043731B2DA20
      04290E5B1456616189903E39598D2AF32EF1533ED601860EECCBDFAD3E74B1A4
      1F9B8B68A1FAA856CE8956502B3A4895D2429A14C8A537F093AC144EB16004A3
      FA4134A9B51589A47C5EB646F3B1CB8E49D6E037A46883DFB196028357EA008D
      8200C7C5F9190B3D19ACC69162195609F0AC31084320B12D3221EBFE23995725
      4A69742ED67B52504E300F509E2B61450D92B27204D19D4EB9786D94FE5060CB
      6770E0FC089E16F91233C02B1F23DD54F71978F31106DE2AE8117513477C2D41
      7D5878AAA8024D049C6EBA56344D073101B6DD61FDAADC4285A846D51F9E5258
      7B0D2B22A83CBEB0F6774BC57E6D7D16EE831FA4889229119591244A8FDEFF29
      8717163A796CF9ECEF1833FA422A83C5FB01240AB4A79422F2F05E238DA22F95
      C6FBE825BE73405DC05A9E0A50048722A0248B563C2941EEF7F825BECFBF1DFC
      86C466F0FBE3D794FA3B9339D9288A5C60397C8CA87C2BF83EC03CC129CA4164
      E9D16844ED04A4A20FB2D12686BF3DE8B090D4F36717BB917DCA4A513AAC8B60
      9B6830570B55FE82547B168694E54F24F800FBD167788A73F2DAE141A6B9D186
      DD0E645AD5D5C8F3E8B2F31FBFA02B00A9C8951784C88DA49A8ADC3DCD1308B8
      6F1DBC6C31E765A09DB1600934D7AB42562EE83154DB8A351CAA8E4647BCBD1E
      C3CC5CA3F23562E04995B1A8289212A1855D2FF7F797EBA693DC6B956692766E
      6D5D5373C88BC7D5C43C4D18A51C9D672E6A4FB7B90FB79FE0FBDCAE0ECAB21F
      1ABB4C11B3C375E8E44A7A2296499065E8AD953A0610657229A4A304432B6AE4
      CCA077983DD61115E5637FD32CA0DC16AA0CA1CBEDC93B53B03A722747E429BA
      AFCA6EDD1C2F0AF57B1B34DBE737172DEC4BEDCABED43FFC548441804D579300
      ED37B44FBADF14CE7643CC273DA3A66C3049FB9B8B8B37B2B5752BAF0E28A779
      0283F73C5C00C8D2B3ECFAB1BBA0E530B18ED96DAAFD6ED28154ABFA724481E5
      A2E070E01ACC858D9D68BA28018D27BA3E90FBF07020823AC9475672718DB4C4
      5BCFE38EBD60766A665A40D386D4DFB458F6D86580453A7B7C0B096EFEF1371A
      3EFE46B5598F6DD1D2209A6137248E3B4242ABFD751FD873948A4C3A96D8428B
      1EFF806ACB16EDD03BD9ECC2ED226681E0DEA9D4C6573D3DFB6C4F2A6EB4EF59
      71E37E48FEDB5640E5D6F487A6707B87138EC489C7E6EA5FC8FD509B703E2035
      3945CEF100F5335AF75F8B7B56AF76C6C731887A81175AAFDF9F23F59AAABAC2
      92D89C1699E1DEA158EB6BA0D8E0B71A48C6F7F8FFFEF4E989F08CAA40FFF489
      4F46966868593F7DDA0FEC6BD7C4BE736A3B089AF979B8182A97C25740C287DF
      61A7E60E95D0802157454BF7132FBF5B73F9511C9D566DE1CF6E0B78375696A7
      8209BEA0896568A195D189CAA4885101420D912D4F59FF8B238A5CA010059980
      8945F6D32CEFD619C8C0CC10ADC737C5FE5B2C75E6C3F4F3EA35E8A69736632A
      F59F6E3E5919FB315F90A7181647AD58EB2493A9685A9C7208DF5E1A1BDBED00
      C3E2191FF89CF2D2B73E70E278622E586E6C5B830D5D191D0AAD1BB5CBE7D0F4
      5BB66C783A3C05E3FDBC04ABECAABFC9EBEBF9747BF9B2A50DEB6814CF6F50F9
      3B3B3BA318CE23B6C905B3208463C192609C137692DBFD0AD63E6D02AC9FC8AE
      FD45D8147EEBE31413254DD9927AC84B7D132F38CD5BAC1004DEDA2E2A296AC3
      8990E558659129B4EC7DE450F049A0F562325062B84E1A473A6E48E7A34B8D98
      E8E04943F3C3461E88793C2E9B5CE0293240CB37913DB374A61CED2CE3C47F4C
      C438B8DE49D9A694401D58BA7548AA826880440214D1BD96B28FC1121843CEED
      80C98BB1E25FD8EED7D5290DD954DB10E461716811393836178CDA78FDA826BB
      F01FEE1A2271B814A7B260C5D398A200FE2F320A639A8AD1E50E41706F4B9441
      5D7B66728A7DCA39CBE925852416FA3B59D457AF93755C389E5FCE7E2D56AFFF
      65EBDAFECFAFF59315FE1BEE35D9A7646C1C859728E73FB5ACF6390E87D32856
      B654FB35AFE305BEE03CC472A000BAF32C09FFFA06AB243254181414B0592ADB
      21E50D8A872BC5128EC238E5ABC1D49B41F5F1BF6AAF881AB169227F74BE4A98
      1B79AF01D547805B19294A48CE0C5EAE2FD260BB23176BB4E8583F76230221F3
      302AFDC3379A665D792196C025DA44A91E3B59FC6AEC8A0211043A79D26269FC
      54B71330897F5B4D1B94710927F7E242031099465E3F05638A91309C7FFEF49E
      8EC2E70B30C20BF0C248619C914FF82D6BC8EC02CAAD7317609D0B52544CF5CC
      7A5DA80F3FF6C27487CBC59E1ACA84E7880E121E1ABCB419C019A9FF54843EB7
      1CC1C596081FB3076F3412F32C2F80C1ACBA813FADEF8017CED9197A8C61E969
      76138A13F67CE69715037F4C458C6D1C9A325091DD2AD7E3D9648A2D0F4CCA6E
      F1124AA0E4CDB7958B0ACE3AB9596E8F2A4079FE585C234E5B52A2C620748EE8
      1F61C01B15BE51998D7EE0A3C8A5C3DFE5FBF334A9DAAA0DD6DC8830464EBD0C
      8504ABB01F983448B346F1352A4488D2E57610F7DEF0FE54FD345C3CCB1D0D55
      09407BD95172BB7567E6C256986C4B8A6E4C6DAE802612494CCDAD2DDDDA1C2E
      6877B3C67065179C815448EBD1D52959980C6354AB8399E0807A7C6C12534011
      DE742B0CB20C6F117E53D4AFE7A092ECA004C37AB01B0D9785CB4856C7F63453
      8074AAD85DF9481BB99924BA619197B7935A85AA005CE38F6B57009E6C274B19
      5D4BACC43E493CC536AD11F90522B8B7A861AB803E78B347E56CF4E2EA6743E9
      317C1432953CC36533F4E95046821B6B1DA375741944588DF44477AB4DB98290
      AC172C8D02B282DEF1508CBC855476D20CB525656690804E91CEC68B28D3115A
      94D9A41BB09251F7E40CA38AA70C428F5689993A755A06E9D710018F62C224D0
      DCE658787A14CC5147C2F662AA840FA6D1B3A0C22624B91F524B00343A291E85
      2F69CEB952E9F1483D71858BF95D4E00DF1421E3C28D0A555225220BBA04B525
      CD48315CEC006578690967D8EFF0525089E18D4BB667910E0F932918147B9800
      22C7E115A771CDBD1A973B1B4D6585694A665B0193440B982CBF491CEA8D8C07
      4D47B37976B3293855E5D1CDE7E10DE73F1EBD25C313E9B3385A2FFFE8AC20ED
      CA9A1CBAD0F83C0EA2FCD6A27B012F2DA8EA380F55C003B64B01EB0C229C08A8
      F18B54BA31E47A012E32A34DEBFDF4FE1A28B95DDB7EFE0C0F812E0E019E6285
      7D9F2D8714DB0897B2B06CDA3E9F279CD88271E636F070390EEF5250390EA2A0
      C24B6FA4CF04E040DC632544AEC1F447287B311A573C3E6ECA4B244459C124D6
      06C688AB58F86482548467A1F5E74880254010C1E9727B753C2B5B9FB859C5BE
      A792619C0791619CEE6619C6E93EB0EF85A9D1C58A87C1C82E74317F565EC542
      953A329952C4AF727734A4F9AB129A3A4A5FDEC5FC5BBA8CCAA722BD8791768A
      A5EB33E1054371883AE2C5638E745542C84E0E807C11BA80A6F4A8D42889B96C
      58694CF645E4637E206BAB88EBB9AA2811447E005210EA57A57B2FDD3201157F
      44F9ADFEAAFF5BBE6E2C495DC1D9803393D718085B80C1E6016958BAF7A25AC2
      2E4C937387C9AFC6F18FC5443365680E8AF94886E2DCAE99523DE66F5E732E31
      81F393208EA331C4D01DEDF4A5EB719D7139EFAD63E20DB52C8950C4B2662DD6
      8C9280078CE6D2D839DC1B45FD0594B445A4CD77587A4A251485C5CB2C533496
      255569CD57CD6280B91A5B0C0A52D7333761FD2648273C16D6E2C0F458099505
      D342248D5B3BB1402EDC811CF0A6E021ADB12A47472995429D36E6D9355491A5
      48BACCF1B9A3F3F20ECECECE8EF25BA70A7E14284003DF884C87A6209FE48742
      9AEC060D4A15A095B59CC875C92F5D9156E035A9D48264269572BA15EB82EB50
      12D84C0D84DEEEF898A3D9272B78167835688788EBB74952013258E1044F9294
      A2308EA9D48DCCABD4F592B9045D6661D7A4CC7275E11C65A438960AF65F2D27
      B7779CC83A4245722CA9ADAC0829A176B5467BBDDBCFB951303A50D71B74EE7B
      147586FAB73AEC1AD07EFE4C61842E885CE6048582C48C0F1AD70831083B5929
      57F1586B92672871A458DB8DED45585625182E609BDA72A1202B455A55D09E16
      4509DF74AD95FCC82EF5BCAC929C58E6FF0D856E9D4D3A7E1179CFAC976428A8
      01A3510D1E0A0441F768434F795244FCF2AD51957A9496ACE4DE1544D6CF6145
      EAA773571F0A1F5C819E61829AC4ADE21597DE229B4DC0AA60E9EE20C7CC6F8D
      D85D01FA810D4EBAC8E950B057BA449ADE45A948B233ADAECA0767DBA9FFF367
      575CA281BCE4CBA8342D123320C2E7DC2EFDCBDCFA467D7E4D4AF4F9A7F39545
      51F55B1981539CE9621A8CB3BFF23255816B2F2BC4062BFE46FC95CC60F261EC
      BD1EE98E1CDA4E48AF0EC655D39C91B5B51C118431449FCED57A656C5A9DCB30
      AC61F4D23B7D4DF3EEE2922C065BD3B6CAE107D2423A932E7F1D605D288227C9
      7A7853AE4AC0F1055443BF00C394DFD2E07ADFCB40BA09721816120E39A570E9
      51875A595BA9BE03D4A3B69F342D73E1BC8A08F500364DBAD753063B7BDDA45B
      47319D52D3083ADC1A17082812564F2E54D08FD5442A044622970ED9D5649603
      60AEBC30D04C7B7FF065BB76C331DEA7D6C755894CE564C80B5272E01DE0469F
      3FBB8817C9482066AC8A9FAB7B651D483B28738FA6D6A3A86CB88CA96604902E
      2CEE9854907C0B3825614DD641001B7E2983A1E1D572756A25AB6CF880200D60
      1932304E917B1401AB736C1AE53B84D12BD1A15E212EA45DA702C5FB8F0C120C
      A9917851E097459E582CD89F239C4C8F4A15FAAC214B211581CA8BABBA820A09
      0B81B83490F315BEBD5336F40AD09D9D72549D4D40025D7A2B93B35BADBB7339
      1A5C97CD05E1554598114DB30FDCEEF9B3975C82E1D45A29B5532E3EACE3B866
      180993A0650348D4435CB5073CF5EDCEA4C87A85B972B05B24B0688D12A34529
      7DA906C4963A048042D3A90F94C713834C1EDDE8F07C9DA742097AABD7527671
      F0F201F2A20ED7671A2B27D4C6995421E08A893E4F8BB6C3548580F054BAA944
      10D10C5C10C628C35A1926315EC92EDCE88C14D3ADC3C908262D3C33EE8CAE14
      286A7E426AE0F08603B23964841FD522C22C5EEC1087FD4AE25339EE67C87199
      58DD3AD3783309B0988A47892CAB145F59EBC8A086911C8CEAE8EC14895167D6
      E97C77AFD599E7CF7E2C59F27F90765B5967475B32B4258183A644268DFD33B1
      6AD6D1B10385BFC9498EB1E6789AC7F69E1CA02C26EDDBE7A5F8BC9889A3149A
      E46ED139849944141741D05026E830980F636A88AA8DEE24A30D396EB4D80DE9
      07AA24E7078FDAEC779F692E1BD947DBCD7A250BFABA299CF2DE1A9B9C0CCA4C
      5E48265C733454D9340B4D9D0315C879062327EC1B1CB34BA42050173C0B3BF6
      132038A87090C202D0A5B71ACB70B4E2644163A54C0CDCEEACA0083AC4860925
      DB2AEF422496185947F639FD76327295DB17503676394FD4B81C2AAA109631C5
      38DEF9CAAF82856EDF4A1940D25E89C8929955998A87B2CB50A15D849E6C17FF
      7C2A052074BBCACA1CCADFE851286E6EBFD6774126C0EE140640B9FBDB63CBB9
      C83597FA4C474930CCD5F83842B4C77CBAFA0E968F1849BC066599162175948D
      00E6678254DB2ECBBD0077C9BB97D11364DDDABC14D9E96928382503DD2C5556
      7F5A864E2B1258A8352D75895BB105198254E1BFF0B7F307132BB4494A493971
      C84BF3200F24123971402F1EC6BA594794EE52117DB3D283A61CF931AE0AB8D9
      A5D089EC18C4CDB6ABE386A51511AF595A2E36909B5895CC4AA46255E2F22840
      5527D97346D176216E520ED73717F6767891EBD55CC8FB5D48F65F1790EE51EF
      6429C222BF868AD3EAF8A8481519CA558E4D6208DBE27D5127F7EF09D36D0FE5
      82513153157D61EED6CE778B8BC152E406DC9F27BB62C5B0C3350EB86A0ED866
      00286614C2B322D82EC1639FBD28E6009644579A2AC627C29F76B405F0BA36D1
      0E0D4FBD97421E8CDA4DC522708345BAB23D2E77C7658FA6714C2F666B492943
      873B17B22B57AD8FE283B41583CC0FDB65D4981D3AB20ED3938B1387525CE025
      2C1CEB21CDE6882117F2A08F0CDDDB5089A702561CEA47ADA64EF3C0FE103B5A
      51E7D35FAE7F550131B757DD699F59E7326E8F93677CCE15C868425287C9F96E
      A5330CDC4E787A67B72258D5EB24C17E2EB6872E3F7F168C03585C1EE9B6D214
      766362026722AC01AFC812CA76456D906CE8ECF7925AA25E4AFE4C0414FE942B
      B89251F83BC2864BC1CA68F2224C78C361300B9894E6919C1BB6443DC2B020C1
      76330F7A14B5DDF52AF03630C35B401A0697427A910D9DBB1DD29F749720AE35
      FA8B6A0DF76B2E5DE73865E85FEEFEE662799B8094DFDD639D967A9B4057CA59
      39D9D0C16917AB0695B488975C2301AE518DDD9069828835760B5EBFB720DD88
      33EB1D2E285B241139CCB9F337DA4853DD174A5B4060037EE24D268A343175D6
      6D9664128C35C254476939A17864FA262D856525F09E12ED52122F8BB2540081
      2A2DE6450AE7490C009F154CE4EA3C76483C46FEC627AC7B25D6A9C4711B36AC
      C676131CA5262BBB335211895BF08AEAF214EABAA980486C5A476447D79E54E8
      26C559959E8D7ED6622348926F551561432BB7D14A2573C89FD8CC9ECB9C18BA
      48F8CF058C54740D0246B5F97EECA6DE5C19008E69EBA3788E8F5F4C188BAF50
      87EA6C45BAA38573DB3C8964B5A9D6F7B2F225E7DB50B0C6CB5066DCE8623CB2
      C6140B57A8F6AB0CF19442AD8271E9DD05273D2DAC3E278AD01A4034DD4BA51E
      5BACF3C3B3ABF27ADC8900EB7B703E92AA65A41FF412B900C92F824475B8AF51
      8E8A02730D71DBC2F2A85831171191C11586A81151C324BC513C9B716E4144D6
      2F104DA8EE765EB54BA66B4D3DC9D3F37A2C325205331D4AD5AE08F98F0B95BA
      E58301D58011B3790CFBBEC96B552E3D2E40B788408792F718E3CCB1B2B5CFF5
      A038D64AB67D3B914978583C4D4962987681598A02543A106DBCF99C1A6ED4C0
      8F8279EBB16939A1E66B02E705C0FBF11BC693CD8DE28A3CF2AE47A7B16A5675
      AC3FFD9D7B9F72F67AC3D2DFFBE1286D58E7E7E949A1B07B36C536491C05BB7A
      18F0C480F0EC91E1FCFCD92AA4BFF5B0A75463881D111B23F877FED8FDA572C8
      EB9A6FA550C31AB0E4306FCACF9D79D8277D142EB0AC9F3A9FDC766B38C4B690
      884CD2A7922A66D804518952E5EE4D2A2BE9CC5402DCCB04871204D1E93CF446
      1CE71A7347DC77588114DB8D484C4D652EDC49C37A0B372193AD8F29C12210A1
      9F36B65F231C81B50FF8ADF9CBB8B216556ECEA678B66297FAE61705EBE3A69D
      F0F258FE0F313FCFF213505429D31CEF23D5779CC7543F162EA24CA03A166458
      246198775EEC6E335D4CB0E0EFB1D6CA292D832B457A9328C8006227689AF40B
      2541CD8DAEB8D15CEA5C05AA20B4CD65D606BE0DD0B18EB7D72FA11223287A6D
      2208E58230643D485816C4AB72224904D60E4F2D6E7702725DC0C51048261826
      C2BB9465BFB81C72CAE90B6FD964E40138D4CBD0D068AEC016B5078BDBCA6286
      06F7A5730F892CD25056C6511F51258055596A0658D1A2399A06629728FE2386
      FC4AC5DC735513FA3D283535D69AA447457B39F71F426FE4ADB3A7DC468D2B5E
      FBE542D2BF8C32F518AE21FD558D967F7CE723BB1A79E1E7F80389FA3F03C4D5
      8886958FC6EF8BBFF36C3B0543B9E57D50A808390E820CEDDB45C3B2524329DC
      DB57563735411D2547BFC33AD696678E4146D1FBA460C73E9371E16CFF2F99FD
      B362A56C3DA061C97E0FA41E9324BFF20A6A29A50A9E946A8ACA6450A9D4665C
      F495ED45889541B9B81A463EF3B11647006102055EE8FA1251EC97A2BC01720F
      52FE18A0B871132CB271FE183618D16AB95C09216021DE7B2900955F644A57C9
      13D5CB96FFBCF6B97A804B644B805051D8C4CB4D8BFA461740334F626CB97166
      89B3C9199B0A0BF5BEE54314B61A0A2FA242F89CD51563396C1C8A360AF4C1E3
      A83AD5E1B787AC2008C6FAE6627A99ECCE21714890DB62A53A19AD6F07FA438E
      6DAF8053129B1A556E657CE6688C59FF61F02F748B1D7B9C20AEE90F9F9D7773
      A2AA7DC38A526D129267AD78B3460D55F72EC6B828A020F95DD655CD78D3D88A
      A17074B52AD261F99E7C672A81296FD9A8EE0CBC6944B655604A8B51B648B0A2
      B86C08704CEE7459BD1DFD6285BA729EB434E525EF24401331033E91AEDE518F
      31878A9C2E2294DCB3382669896A292F52642AD2736F7DCE6BFF6375F3454AE5
      FA3C0B3415DDA652C683EA84F2F2C1D5294FB3F5098294B8A6CC4C5677A8C421
      99E58AF843CD9D76C3BFA3A2F841D7EC5C5EB3239C525C63123E9E5CA146EC11
      AA5D16F31E3AD1F702E481233EDDA3FFBD4069F3A2C8EDD881CB24B6E46A50D1
      343BF1A4A35737D62B2F159F08098E64D94032AF0CE36B8551D2FFACB2840AB1
      23DBAF3F9762A4AE40ECC2C6D2D87A8AE3BF5BA468725EBE75FEE6FD7B441F6C
      863146B239528FD6EF692849C1CA4EF26A8D0DEBAF0DEB9401FC17EB52DCA4AB
      2D2AA43B05CE86C3915F86E15143FFF603902B753EEFA22B94E57584E2D16EFD
      8BB8E2754E72341B9564450A3C1F65BDE11A492CCF9F719283A20DAA5471810C
      4931898B29A832C432141256835772C4651BBD62AD4A8D0A3AA394F282E94199
      92940A3DBB7AEF4A56283985F2048B79C90B65949A2A473588E332EA8413E600
      B446BB919A7D31025A5F2495C657D103693B1BE18CCB54A060AE9CBB43416227
      3A0CD41BBD7097601EC9E474AD218CE05804A14FFC7AED84753B1F7444E87649
      6C8CA04DED10FFA28A77A55C99D8A740BC23FDDA237214AB766A40906FD0E7A1
      9DCCC017019E53F688E8301C158C52EC6FC28271D1848F4FD638475C56CC6213
      C70E01BE8D2E813F222B46C068C362C8D1347012530A26022A86C28E5C9697ED
      DACAE723F3984D07A0D1894E89027C3045B4707C0556AFA7F86611E5D3293E97
      03639162FF86754D70E7A8A6F33821EFEE444432E2876354E1D55BC7AE6D55B6
      DB4CE9925032C018ED53D9222AD4B0965804E4827AD752EB292E11CD8DA93C0B
      FBB6E1A5033D6492902282316C3AB915FFCC115DB000140652BE9917176F0C13
      A8E7AE3992A222F64C4F8F28C48FDAA77F4F75B34D44E758D582E1E8C1BC471A
      FA4259BC0362864E07EAB15E846641EA4278D691B5B08694F54A7668531DB148
      5D8AC9F9FFE1E5C567A0DC434D0774184141579301E6F46AF290BCC00B850D2A
      8B65AC50336B486D8564AA10E30C2808106BDCC48B44A7D62D22D06F58903CC6
      0B4A24073504C1FA20D60183BD46D4E1E6846EE05CC4739506EFC7BA45A70763
      C45CE9763057811A04510DB4DD1ED02312342E2165E01822CACFA1D425F6F7D6
      AF5ACF9C3E97536F545091D63BD1F8206362943A0C002CE2802A4CCFA45576F3
      8383C54A01FC58C0093DB2E0E5D14BF81B4F90DEDE6DE0B67CAF4D2F251C1285
      F7D680765ECB2A5DE456365168DA2755B89440A1752C5D545EBD2BB2FEB90064
      51ADCAF56E499FADB7DFFA6A685C0AB1D19D1955459AE20DA5C6270D29D35195
      2FA5913C657422C559F03A6999B8BADF7F83FD3F6A704510A91677DB6D9F78DE
      0F0BA5027656C2E9DD7FC169FD0C24E6DDEC750C47FCE8A13F67D68F98D529D8
      9CC1580D044F4780C9FE7F42866E9248E4ABE60A11F556D0960C3FB62E11F996
      3803FD25C1F291B02D23CA6CD18466D8CD95BCB1A924AF64894EE3847BB39237
      475ACE24493229CA8CC1457E436A03A2E0623B6390112A791FBC42562D6A01F5
      1D7D17704A3907D8E8AD2B3E621D134BC2BAF5EB0AE3C9916658DC744FF1134A
      514314A8DFB56695376D5C59E919343E7E925C960CD864FF937FBC6D69DB659A
      1DD78ED56943CB2DB800A5DD4C667700AB03F88D732331922EFA8EF21A394C8E
      A408295852EB9B9CEBC362AE740484F461444248DFD650B01ACD2D4639551924
      473480702A734120E460EDAB8094584E049226BF13F96D88F17AD4BD9B5A2AFA
      94536848E2162384AAA1CFEE80BA1A08B54AC2D83193CA574A652E41B1002495
      E3BC929EBC9367813430ED2062FFE29B8B0F0DF8E73DB3AEF7F1C823A7A2ACA9
      4B99B46431E730BA50949D87B7548030F765F349FC4826CA4F626CFDF2E3FBFF
      FEF46D93FE67B77E45A2A35CB079C782C16F68BA1CFC7E26AE85B9286C21D110
      3C96CD1918865B87DAAD1365C8F636809AECBD0570EB92B985CC088EF728F4A6
      915D6581FEC146FC51ECAB02FC05C654DF0158EECD5D34D76689279BA27D52AA
      AF6FBDBA59B3BAD31D2FDB91CD4DACC852530776E67BAAA4A41421CC4DD3C1A7
      FA46AC816BBB2C5974DE2AE18CC24839F3A154CD41BA7D03663311398EF2D114
      AD64E4B13ABD6365D2F6B9AE701D479BF8B441F16225F1EA221EB24F104155D9
      0923CE1860232556AEE2162BEA3B1D0B21C3FB564A8E9F592A23165EBC7589E5
      D78F6334D8210F622623DFE8C211F21ACCF5B81D9CBFFC24929B5FAD0DD149C6
      4E53F4456C4A9D2F23A0363DEA0E7A8F6DBCFE271E22AA272375848F9F91792A
      A3914679BB585DA42ECECB30375622DE740E27D540C621D624EFA3BE39687C7B
      99F83CAA9C42D2A464DA90E69706F9676A1D12551878A863C2A4AEFD382A151C
      4E519A1C27B37E2C6C6ED47D7ED34279290C0F08171358CB59769DE9709162F1
      AB52AF8E420CDAB10C1A0EC6D6F9E74FEF510F998AD02FD7443831C4FBD64364
      AAFD0B9679FB9503540DCD5EA3D9DBDD6DFB4FD4C985F274C43C2FBE0744147E
      8442773328DC71A4D4DAD3267D3D6431D3247F53DA822AA357633D395D92C1EB
      3A6F64ADA97014DEC8B8DE2F11F714A6DF5E7360756E3390094747D27970A493
      88F26882A3BCCC136E46857E57BDFBEC09BCB1842308C4A7C093CD7C84620C98
      6137AC2FAF3F35947FE6DDE70F4700B37F2E28229C8C3373B61EB975925430D7
      225D951E647D0E1D24C1588BE1739890C511758C0EE3805D2347AF3E5E5C7CF3
      FEE3C7CF3AB01F16885199A5F8FEDA862AA6C4EC93E2A0FE7265C84512A18A34
      B68E2E5073470C9438854E3511E9200F4AC7C660085DAA525BBD0072AADECE28
      9E4468963EE17C5301FAD7D13B0B7DF2163AE56B84B0BE9859E4B8973908B80A
      155AA332D1413C4A103027A602C3D61AF789377911BD788D59F47064CB695CB2
      A49AAA0CEBC4FCDD86420C2A2E7735B4BAD2DA5002344689158B1B4ED95F745C
      1447D96503E4EA44159156A68A8832DA2862D9D80C6E3FBC1FBC2B0BA8F0F68A
      E25650880F31784F78FF16C486CF6F2EDADF5C5CBCE182211F5B0D8C91F748AE
      12FE44F590C28F585BE092A93E5E8A42C83F705090525403A14450C14D655B23
      86ACE794BCA458BD13B391295A33E2B39C36B0D84824E7CB5F8D258929BEDC17
      D779242B3E33A3564FC19804A9ECCC3AFEA4E2CE57585CAD74C823691D404689
      3947E3F1D989F59255CFF3FF222F2F5D696F1850487B3A5D8C416F4689348917
      2A43AAD80578A5DEE6CA8EE47697B20D358017537B31CE82A3C28A41A5A5E1A9
      0ADCE59C6160C363E0F114121F449817CAF195518181FFF0F2A70FCCBC295A23
      D74D7C104B31357D522765B446084146A16EFE62A46BE6ABA47D102FC6580306
      5623D37191EDD78FC8DD8CB4232A481BA49CAE80E973C148425CA25EAAA83966
      0AFACAAA8C4F023A8D62383090C7326EF2AB5C8A85271886B557F9693DA921F7
      984852C4318014000D64885DFBA5E41CBA7AEA56EC10B4BC392988CDE9546804
      36FFB97C230954841DC743603CDA43BA7A73C9EA4299B9F0B340150A8066BA71
      82AFFCC76236CF83D375C2BB7C0E5DE8DBAFA30A196E584848B96C370146D6FD
      311CF27608FE8849331E160258645455499A8FE98493C5DCB85415A6C9401CA1
      EC827819A53AA7AB80049290C8862138026B2BE6C9AE04EC46E14B4C7DE0F9B8
      D262DE46E497FFF3ABCEF407619D8082F1FA11D98355C2813E27E9A9E279759F
      117A5F8DCD35AC52A8846C604CB70927FAF85FA82A67ABD98EE9CEC51222EE27
      08D3CCA99698BFA0DA45AABE65A496ACF1B171CBBE10D2053C2D6E41D6C84029
      3C8816263EBA4624ABACD99EC518E26BEE7CB1487F113279502E5E3FB8F83EDE
      F94229C91ACAC6F72063BD49551094E4E4D47CE8DD6BF8E30473513F4F75D030
      96F14209F1046E5E96ED2066BC2B642625A0DBE894AFD0A324C890B44E922FBD
      5102C200C66C977A8B9BEB52755D28900C5BC3659E35A750734AB73597475F9E
      97D651013C64ADD4AD6F654A18137D5995B550E143067E2BBE0A68BFA4EA38CB
      384FAE042ABFBD12089B4994C1BB7E683CC9C8A07A81D24821B768A4E735E2FB
      493D39FA20B01E25D59590F6F733ACB08169391CB6BEBADAA2FB015818A83F9C
      ECA86124FB84E679DB1BDEA1CA2D710DE644DB908A98A86B5D708C8B5C84E29E
      C536BF5CEDA95E5A250D7660ED1BE7DB01B87477D847535C35276A03E70E422F
      E17C47D9CCA2487FCF64E7B36211112064C5456940736D017576B7DED99CAC7B
      E9652A4B37440274EDD5ED9255A270921C7D34D3113D595C0796586E4AC6A216
      D6B33365277CA184118F6D8F2AE1B3B4728D0FBE076F62BADF28A059EE27E71E
      D5B0AB33400C52E274EFEFE3BF5B6F88615C00ABC01E2B5F647F392F2A3C4597
      1714F0D67762748901831923BAAF3A69AAAD023BDB2DB816B6174819BBB0778A
      D3A89735ED17774C8728B2694CB1C0EB384699AAA4A4EB62EBAA477858710308
      6E985D1DC8807DCC0A504FAA9E7B72171271228AD69F7040327BFFFCD2CB5576
      75A0BD7DC72B9B4854B003C814D24E830C3CA7998892CB1A28B91D8A05298737
      C3E9C27EDE96E72EA84C874BC942E91A2123C1681706315D27BB7720516C21C1
      D7CD665C0A915EB94666535960084F531ACBB892BE8C2C52746E87B229EFB501
      43E2648DBC2F29981685BAC20991D487B955B7C979352A96881C98F09E007B0B
      645E4405D7247B5B810D57022C35BBF74AFC988762C6168BB95AB79411C7F5AB
      4863991AE0CA9AF58224FD924E053EBC627FAA67113CB31F71792F5F9DF13313
      B8AE2ABE199FDA5EE6125EB1C46D532196093A4331900883838AD3739E3896F7
      DA712B9247958159446F243F44680AC485DBA8BE94E203F0740C139118492D27
      80577E2B1F798DF3F22A1B123C65C0EC6E46145E1A6041CA82357182FC268917
      9369E9E602652CBCDF3A5ED6A0DC940DA84B08DC420C4A95C624B15667BB0229
      E58D16D4D9F0747873AA4B5E1079E732E2DC63F7654367B1AE7EAFD87FFEFD0A
      8EFD8C067B6ADA21A37E11C557899646D6D2D1100781413528F7F6545CA1CC7A
      E47644FB362E8AC876F13CD00C7C275CB85DB4A2627C981C5A2C77B748C81C84
      1D2130B002EBF1252CA82806827F39960D49E08ED109499C5E25AF273269B458
      530F8511767267C58AB238ED6EBC09A32CF27AF28B5A4585C78B10D1011B1711
      214CF2CAB1C4B54BCB917E1D923F8079A966C125D0482381766315D27633550C
      4089BB08861719971A8827821CC598714488A7848795D909F21AEE29FBEA8AE0
      94FC8FFD755446544E9D07A3E59B7A102F119C9375FCC1D34511D81248872EE5
      7CC94D24C71917E0A883558BB4331505F8492134CF4B967E3DE99FF4CF4C48E7
      EDC7A3340440750C6CD295E20A857472BDC09844B81608C24C959DD510F3D215
      68150A12A11102B01F188160A103AF675DF2A55EB7DD4EB2BA002DEF52F93D81
      64030B8D8814098B8EEA6A48B2ABF31ED345C06E7895749CB20FA1A4F75985B2
      CB389D265B3AE63E5758F1F5C61679FBD9BD22CF0C050060E708EB7B11CE1BD6
      0FE27A9182680108F45D907DBF183630A61465A6067218E0F089407F8B371126
      E0856FA702E45A47B678A3174EEB43589E7819447EBC5467A042B07F1B602D60
      2C4F45A01D500168095F6B75772BFBAA19964DEB87CD9477459B1DBBD6E0C5B0
      3B802BF9FB86B31D07A76E070FA0EBEC70C8B0B37F8C685780E3D9358EAD71EC
      616AF7369E3D8EDF87D3C74B639D829A4B2D52A6F81BD2B052CDD3FD39CDED81
      6FEAF6C39ED08995FF8E173EDF1AE8307428D23E8775A5485F994823A794B8EB
      5834D144A78B6E268B888CFB5E7A80C07BFE8C2926C08E143812AE51161E0752
      E10B31142803B6066C229E538B9F8286A9209B87C22414B00D204A0B6D440F0A
      229277487462354C7D978AE40A558C4FC20B4F493718511B0332DE9184CECF73
      697ED47425E0B09E94F506B3CC30BE35207861B9E3038490E2A7A7D69B704681
      0835809ABCFCF2222DB1E202D1B1FE1BCB6B4A29914B128366B2C8A88C689ACA
      8E67794C7E1C4D62EA03B5C00A9B25DC54386924A9DB4F843D1AB28A3F9C0893
      01231DAD563A2DA78CA87A61AAFDC146DFD90A306BBA7CD8FEA0436D7353C3D1
      6B2A0F96BF70EB8492A4B341501565DAA97382B24BD35DBCF28290C3733D6B88
      A54431360A9B8A28CB3B878051115B5AB17CBF0CA3524DDFCD8DAC475613310B
      089445589B8B29E32C4A08A8C30FB185002C3824950551500193717017DCC7D1
      1273A95D74405DD6A54193DE2A1D5FFA82FE72FD6BAD8082C8CACB2767FF7F7B
      6FDBDC3692A48B7E7784FF038EE2C4B5B423CB240882A4E7EC6EC892DCEDD3F2
      CB4AEAEE39B77BE246012848189104072025ABF7CC7FBF4F66560120458AA0EC
      760B33F44CDB128997AAACAC7CABCC27CB7DC398BB4692709F9CCD1ACC50D118
      C71B32DA6B198109A65981C4B6D079C5F4B029E7925492382643CA57E668B225
      1F3DCF262DE3C17CBE808F4B139B22A93A1BA9B1D8C28BCFAF3D15831B6B4B29
      AC2D404A5E847145C71FD4488D17C34084585E39DCBF317DD7929CEB8CCAC969
      B8B2452E3CCB0DCEAD34264971EA0B3F815331E8B874364EA6775BA9F6F04A1C
      492517E689DD425ED636021317F996F789E3ECCA9119EFA29B442D409C2F29CF
      DBABC470E8A8EB0A04D9E0109680516518B985A487FA4946B39119D6FA53E218
      370E4DC29029E130F7CE8152982E4BF54766ED8EA2D99129B8DA469CEE479C06
      4F3AE2F4FCD9B9658C97CC71A1E1380B7C9F888757877DE6378DD16F4564A7E8
      1CC987E7D2FE8B93334CC3083E732D4FC6E464FDC9F1539D8AC584FBA69920C5
      34990E8BAAD9DD2ADCD79E649EDCDF9C36C973647253C15A52FACF358CA2CBC1
      4E01C32AA811757652E5CAD9960AFCC23CF94D5BC4880A1C845D1353BE68C2C6
      9C6D44773490EC44F40B92C642756141131AB72CBD9C0E755A7998EE2989F4BF
      64A95F46198BBE97207708D13F9E5B011E8908C822C5676E1082E0C3D98C950A
      9106915E38FE7C44D93E2F297523A0224513852CD685AB2065671C6CBA441BD3
      BF4E6EB5CD939D520F163B96CA3EE236ADDAC03941F26B76AB2B632EABF0D983
      58BC75629B9DAEDEFFC414932C65733A15A08DFC2A9B8DAF9D3C758A76ABF6A1
      34FD4A579C8786B49E03BF4A039BB55CBC35BD579CF3D0228ED3B2E09876871E
      4DA6508CE9EDD60E2FEDF09D35A45A74A7F5983BC1BEB22D612BD9D6CB5A12CD
      D9EB1B56117249C6D6E2BD67F1E2BAA76DF142F48FA415BB1A73ACA1EC1129F8
      DC601EEE0449185C549E023EB3D57116ED737D58894C40D875D319E725BFD1E3
      E4725CDC4EE11BEACA96B158BE4AA2488F1BA9FADFC562CF1740672B69E9EC4A
      9A8EB470BBA26D6D89BBB75FD9D14C11B957E8622B6A9B4A1F5BD5715EB4382E
      5B28AC62AF05EE798F0D9710460841855961B8F6ED6BF86CAB9C5714198842A1
      98AC06E78AD1C490C90CE73C67E814F9E55B84ECD5070394B46EB4F4CEF13C49
      7F2A48BA0C3ABB4441B5F032C11DC5F49D51AEC39DC55E26CEB1E97928C2A3DB
      DA2CC1DAC0B989BDCFE3E2D072CCC70C758ED1E9A57C4AC078B94B78446AF4EE
      4F73571F5C1ED0D4AED261514D08FF26C7E69D4DE4E4E0764CFDDAF7A4B52348
      58F4D495C34063CEC8B06D8A7711A351A3742607F0941751BFA0454F4D663B6D
      86963D42100A95BD37399522AD80D2CCB761E42926456B841A49A0183FA5FF14
      E5674249AE7F62426E05581D01C6AD9687647428FA9BC3B57814769F36DDB0B6
      25E2CB24D41A9AAD923A027D95CDEA6FAF8A17B1EFCCC6B949C3A6D7E54626C0
      1C88049969AF38D2E7916D748C80EB39018753BEA7B6D9E0FFA8FD805C8A6BD7
      036A118CD97E016BCDC5181383256AF732DB392E1F8764099DAA0CD3944E710D
      C84B52E206AF66CA92F1A69F076D1F7FB7FB1D17FFB83DAF8F7F3ABEEFE11FAF
      DB6FE19FAE37A04B7CAF4D97F43A2E5DD2773D4FEEA64BC0DD3D7E4C6B30A08B
      DAED418BAE6ABBB88EFEEDF43CBECEF3BBFEEFCAED98FCEF8D907CE8386FE8FF
      8BCBBFEA7A5C7C046FA6EEE5475BA1C242450CFA62EFD97D5E6DD34CACBF65FC
      6FC7F81B703CFDBFEEE5F2A7FE0671B67BC49E1B50664DB6BEB81C0A9183EC49
      26D010BB1691AC8CAD3BFFEECCC7D67997F1B1F93746A0DF1545BEB712561C8B
      FFFB008BA7DF1C6D7FD71823AB277BAF2BC8D79AAC14C598034CB1D128E74C8C
      2846A89C3393B6BEC2AA73D3A2C3003B8F17DBE04555427D1C977EF55405FB02
      D97FFFF82FD36567C840996A64D3BD21DD30BBE61D355DAEC21898E7C0F5FFB0
      BE865290735ED17A52ADFF46198BE6456596C6B5D613DB858C8E230D00824175
      A28B4DC98E600FCC559B88BCA6C82705559440E5700B2153C996A569FD2CC40B
      4B630AD917013A1E1F474BAE92618437ED3B44357837B9E022C8EB5FE4C5C714
      0491097167EE0ACEF926907617A9894861F2E12CAFD385CD64A45EEB3BE9AA37
      CBB767474BCE8E96CBCDA77276443DF73E9076F94FE67ADE91A362DF68A9517B
      5A4BBA7E4ED3E19F7EB2D36199D1ECF99C8C4DD33302767E5DACD1CBFFB07211
      3F1533C5CF3F2D6936D1A0E91E499CF838BD1DBF9688B59DF18A1525D22C9BF3
      D6425AA18E2D107A488A4DE43D03AE72687C3DF6E33CB16B78F9FF128695C027
      BE2763EAC7C92BE25E67971233F69C5706045EF8BAF8D22ACE3DD1D7BC0CA6B7
      69662A05F2298C8B42D30A289C89DBD68F96F2B80EA3A81CCEBB71AEB3298D60
      EDDD2B86185005870A4B447F715EECD896979955EACC6C68FA2D3F72AC6F3931
      AEF208467D223EDB7176A38578747D7435997B444D79D64D802E9ADC27EF5686
      3C586A91539D0BC501E9CCDF19AA400F8B95DB1E1BDF4FFEAA5069B70492B511
      9EA4EA9BCD755B9679CD37D1B0C99082D055248FDA4E29CCEC5F82C895114712
      241F016E55726017E3C0E3CAA695C14CEF2606B593B4B6943BE54541896DD39C
      A7A4D2B98E7DBBE9EA6DBAAB1AC8CC97EC61E7E92C0BA5EC9D1BC587C99471FB
      1925D562FC992E013BBF1CC3EBFCAB344A07F7D8A3AC5774884890415BF0ED62
      13F311A7A9CC16A8E545EAEDCE914F48BD579091606CB212696D118F964E338B
      3A41139B909214C53839522CC88D91CD81AA728E4E4E4F6D1AB5727E3E3B3DAE
      8139FBFC1995809E9DBC3D2B6FA507EDD9066C9AC0B05576371726C156B5BC43
      D957F7398BE559FD42CC4C53C2453E872B5B605A44B69243E0CC0D554D6248BE
      ECEDC5D872C3FFF5DB1B919B41C12E3ADAAD54E4DB04105B3B4485BF8450528C
      C6A6EAAFCF3D376047D4DD712AB060BB85384F28A0631AA6EE711FCD85096C25
      E272AA5670DC857C5B3125B6465A9413EF8C16695482B2438B4FEF9C5DD21202
      595924610916BF8599A0ED9FA50CBD79F4C31EA36992702BB132E7BA6C8932D7
      D1B7F40C9BC8BC3BEFC67F83A4E7965A797581B6FAB660E47B34AA714F958CCE
      6E012962CDEBC5AA09657A82122A97B964494EA3397F354172BA48BACCD81AAB
      0F85B22F3A0EF263A769A144B8FDD7DF2463DA5EBAFBEF852AB11FD96C2365F1
      BBCB36B2C55305FA96C164E14C70BD64187233BDCB3A9C57A310CA4E6F92E938
      F9BC01A0F9A4A8FC4A168F7DA63027A44987666C2B9ECFC780488237B1434406
      1081559A568EE23B28C695CDA636295486B667ED574158B076D5662E0FA779D2
      4BA5EB23467DA7A765BBD972458DFE9625910ED7DC78A53494C497C3D7F57190
      7F96FECAAFE5AC6A3DDEB469A5C19CF8E1E38563509CD5F8AEECE729F0A06CB5
      8D0CAA6279C46516557E4BB2B21BEEB6A1DF3A616DCCFC70C1497276058F0DBF
      DE6609A521EE6D7DA605197E9F443B657BD5B9CC6BDB6685A16B57D3BCF0A6AC
      05527BC77DB0AD6BEAA0E8A8120EBCC4D2B1D3D092436A9A985493410B3CEFB9
      DD664CFF4DE1819612EF4651374F9640E428D97ADDFBE3997BB569EF0226B964
      E87CAAB949B291E839D32D916B4442A6715C918006569854981DC954CAC26BAC
      7FD1DA91C1EA2F13DB9124BC4A136949BBF37F746EBBB0EEB08AD8F990161F6C
      4A3213FB28EBB6EE3783B1145B4A832AD2D31A6218C773B7B23CF304E71A2873
      DBFD61EC59AC275AB73A7A7BE5D2964332CD63368C918B61C238878BD6E83EB7
      D09C0B79D0B6DC4812CA391EA74CCC4731E63A78ED9BF611433394549AA324D3
      C23936691866D66615CB1B0826F846D769A66C763006B4B0650448D334EA2C5F
      955B3BCF5E757F312DE505ECE227E33A1D19D7497CFD79C70B8F3CFA81062D2E
      9A7226C3D96532AE12BFA8021ECD86D586275B35BD424D736DA27118A8072409
      9193F3D3AD2EB68710240FAD529B32C0FCA2FBC2DB1866F9DAC789DDFE1FCEFF
      7CFBF6AD34038256184DE4A4AEF49446828413C3932AADFDFFF5EF7CDB41D172
      2D869B36DF6C629AD22E806D3BBEEF5B6DD8796AC1D0DEDAD17FDC063DD3DCD3
      7CED8559B985A13BB6E6F4FC169E98D03981165B0556F0758E8772E308F8DF45
      3CAE7278F760E049CCAF5562F409EFB81AB96E6B2F193A9D4A5493474BA620A4
      17A54FB10DC0AD4B8B088E9353551D0140520D5D4C200C1553496C46E6F76C0B
      22B31E4B588F7506D3E837CD79AE585CB6F988F73E7E387C5F2429354410FCBE
      950ACF9FBD7C9B7CFE446626B6EE38D4B52A16BE9E207AF58D2B335E7E48E7E7
      FBFCD9379E3109C66F3D69A96620EEFFC7FDEAB27FC2055E3EDB5FBF41AD5145
      E018EC4FE752E411E5A6550E1124980F55C0293975F225A72369326D70F0B9BD
      E1E8E4FC7D126F217DD7E7990DD5444E103E709543915DA6B61D04C4202CE852
      2DEC61063620BBBFBCFCAB93DF8D827468B239E681BA43A1B1F86AF53BAA9A95
      A1384D06236E02B696F090C14D9203B5DCC9A76956760E2D52C5D85F9C4C8689
      36DD4705E503C32B01ACD83B1CA93B1339AC035A42AD7AB3CB94C293F3302C34
      34AAD529E0B58D0147E3085336D702155E730F9AECC0D995E32193BB66E27F66
      F00E0784C89FE5C2BC713AB51DDB2AB96EFAB3E22C1EF9C2DE29D935F4CE8402
      5B25F6021C5A81369107166D12EB812E589C157B502FA82D0C286FED506202C2
      7ECF52024EA941491B8A8FF4BECD371436B1CB2D3DD017179893FFB09B9231E3
      3C5405267D7D6208515D7E0A0FC0D23EB1ACC197AA69E529146926B740AB715E
      549C530EAF39498CEEADB5ED4FB988BFBB49D51A4DAE7A7EC9DBA998A3A1479D
      0078A531B96C1450254A6E926806B7C7EE08EE1F37FF0AB9B87A7BB1084B1E70
      20BC506E453C2F2C77A99267EE5660790CBBECC9B30D6EAF80EF28CE7EBAF78E
      626DF85982AFABB90283ABCFE69F61E65143CCD78FE43C7FF68E814A125B3157
      30B9C92F059FEF9B82B86A835C4BB8A89456D42B985A0DCC82EA5EB1F9E03A4F
      88AB296397136039D9B625A7D4550854CED79223F87C29329A395DA624690318
      A7861976C49DA02557DFEFDC2F031FCBC1B99CD9E4699DD8B6F0FF5D996D6B94
      03560DB3D9DB9A1C0F93EF032587489CD29188C35B12A6DF63C9B6F965955CF6
      9D7942ED14A2DD466C4AAAD952E2123A31A17E9A9F374316A25A2F41EF62D411
      63C518F1F39FAC45E69096E91BA90EABA66ECEAD2C7DF15E1AEBFEC9696F37C6
      C349B2D505252B7CBD583750786582556E04E3761F15FBA8B0D80B181D0E392E
      6EA15BABA2CB13D44ADE5A5E50F6811C36539755B415AEDA3602493787EC27F1
      58323D18D7C7742E9E1B934955B3C7A5A9356FB40AAF8AE1D5D1FF3C049EC1BD
      97D004B73A6B8DAD6A4B3A63F824ECC698DC38364C8ADCB82D0EB76CBBE3A5C4
      81693C4BC430CE343B0D213B3B1971B309FE50645F09029C5420E3EA7DE7E0E0
      404A2447940B7849FDB62FCBED6CBCF09D7C4A9FFC52BCF0AF7CDC626F29E05F
      C6A9A98AB2DF181FB1C6BCC6F4E24B8360D16E6147C1C237290D521346A3B7A6
      3958E612E67B5E9D96951EA68146A8A450B370536D5F0F8AD16F5C5CC6E0D4D2
      4DD39C0E7391582A5D01165783FCFE32AF1C13B9D1D9B46C1B4D87C2F91D7CCB
      11A56C6E05C4C34BF09D1AE9D3647CEDBC72DE7EF4A8C0857EDB8A03039759A1
      8949C2A987EAFAD63B3FB1C66D320E87B368836D615A766043DABC9F9C739F59
      8783CB3128C98832A393588B1250CDBC4C33E4D6C0E6036A30BDBF908658E653
      9B84A9E45E6483FD53F2DA0B3E79B8CBC0CE2735BDDA6160206316905562BEB4
      F5532441EAE78DD7487ED6C538A37D9294AA22A7975840D4E02F95BC7F21CBCA
      56AB95ACFEC21A23830476985041D9F0D16632AF38F79E6BE22DF0F2C58902F3
      112D35E594CBC17760D5C1D4EA029A405958C01D07B7226F8DC893D31B1BE795
      60628DE049CA454C644E9581EA38F9BC6D265848CB21A5443A92D6C0099A4BC9
      5551DE2315E90224ABBA1CA2E94DA2AF2D5903DF5F6E94D8F16E2C7962A132ED
      C7725DE4979BC458EAE47A5BCD9A998D692097634E367877F19EA3D01C27B4E0
      1B95EFA9A074068F66BC81403B94E3C32484E0A4C124F9A834A32A557226FA4D
      6E9F412707450D7BCC85EF96916EBFE8ABC4B540B643DDBD30083B8F35D69652
      C84D146731D06BC0A197000560325835CA4767A0F3120BC0D42815B33161E5E0
      8EFAA49AB84DAB2CC1812D4A5771B133269E4432FDAF43F1429E0AAD7740CB59
      463D5A779690D54C93D1EFE8F2DCF9E9FDE1B1F32923F3749AD431C525524EB4
      DB399F66B370BA43AEC4CE21E33AE22BFB219FBF499AD348D386321950144596
      6EBDB59EB34FB8FA34BB2C48A6199523C9F61478382D09622CBEE9506B8312A5
      77536BDFCCD90B04274334D973CEC32C99987D5F10289F0B24FCF80EAE15F418
      A1D0F04904E1EB67EAF2C5F8C5DAF7132ECB3664BD86483FB2B146D64D9ABD3B
      6684C5A1BA14B1A638C30F3B92D3CEB73ACC9E215D9C9C775F9DC37C3716F6AB
      B71F7BBE7372FCEEC2327C25C59F344B0976B36F0B3B8A165E932C493393D21F
      4E3E9A8A880D8CC5E270530EE86D7194A84C7E3B09CF319BAA19AC600B6A19E8
      053DA5CCCD07CE1BAA219D56DC841A744946E6B0B7E025896250F70AD18ED233
      5B44A9096C70643D2B8921C149EE45B5531487D850A1BDAA7E26E961E9D9387A
      0C3F89914A15448E1D24A5B0DF528F01BB52609072AD981E85336349B948488E
      42706E67F93669572886F92328290FE6DE21E2798C530E7210981F4D602E0B81
      A323D8B05B5157E3104292254253B5057FF015FBC094FA0C96DCCAB8028B5CDC
      C6D21293B20989CCAF202284DF62F25DB26AB4C9D71B2FF6DFD74DE7ACC14B95
      0C28499BA9549EEF927E90C30F4A08DAAB060FCA7D3C57C95E26E2AFE7D1ED36
      5F23F4C552A40A398237DAA58538FB48F626968B308E243256C67F7609CB68DF
      393CFAFE4CE2F1FBCEE9E1075CF6E9BB3373F187C39FDED3EDFC44EA776F6DD3
      94F11177F72AF11AACD2DA318AE1BBB71537D6A4127AEE5B08A9253EC3FC6212
      99B1CDBC62512B514753024E3751E0710327D054F15AF3A828E595EE615CCA2A
      29E4DC4B900AD6527698FEE47CDE77EE3642179F2B6B29F1FC72AD323AFFA4B0
      46A5265B264F65B389640BCDD5B38B79B2F6BD12451411438745167E628F599C
      438B728634FF5A131988D3996D5AAFA447D458B35D47F6C806A1EBD22BE4FCAA
      C5655EBAF36C059FDD81F31E627DA82E50959E2F0E275EE1ECF2693344858142
      E463A6E19D354FE7DB7862F505E88CEDDCF52A820DBE150B3A9741BA08515059
      1BA25535E2A324E445C3A81FE492E65AC6817E48F049B565C9D75C5F9598F7ED
      733535C739B0BBB06E898D4F9B780C73218699E9220244F73D2EEE2D65CE143C
      222E5137EB4B2C4C4C5C121238AE50659382F2DFB83481B5C33FFE1B34F89632
      15820F3ED3B6E47B5DF0C3B6DE3471B442E6817FCB6D22F9C176476E75768966
      F9B030196B2D32DBF4E5E4A2D20AA50D1665214924FA10ED57D52C07A38A2FF8
      B1D5AE61149ECA04328A70E7EA24F957946F6E3B98505B9131A7F78A3613F79A
      CFD358828968624924E71355511ECC2E8D9B34172E28A6C5218352A696148B12
      C96018D92E2AE557569ACA8942E56E3104584715595D16408642184229BABF42
      44D2329CD973AB6A6C8AF5D6AB91F45803D3C774BFCC32B766444941BED0E62D
      33D5E806B220E81BEA9192097897B12416F6DB3682BBCE6CB547366527610ADC
      2FE9AD0B9B9912926CFA7BCEF1FF191D749AA8E156B615A995CBE857889D5DB6
      93E9D00AC6EB30C9098E67FEE46C3D209BC8442C03763D272F5288F6FE928849
      66822FD56EA2245DA578622CE873D57A0DCAA32C6A39581A71EF9FB984C83A98
      48050011652118C022958BF99F1516AB80F594C3240BD5C079E3D5DFB1982F03
      49E5130D8CFE5C8683ADAFB0DD216B2C9729B4C74BA86048D1630E9CDD375252
      4F4F5173A0C495AAB5924E62AE8A4632C5F8F3A84DB718E86C52BFB64ADA1848
      72C8FC9927182709B5B1552F35E7681459376AE966A66FC4172BB56755F7F2E0
      699A2339AC214781349B29EB117554E7E4B1A2B1E6F263AC5E59A814DC5F952E
      5CD5D066496C6A32E7C3D847C3A5A48C70320C88A744BB49051AB5B3AA64D0D8
      3B6AE42A6F35C67A2015B239762C0DAF245B7A59B6D6B65EF67EF18AA55E35E4
      57938CB68CEB8A315DF5D8027FD9474C14B56AD0A1226B369972A3038AFDE6C5
      859C617B45B96946A48BCC5AAC2D9FAB43B340F2E66C1216AC441ECA44324E17
      D86E9B8797FFF4E3F177583263F36E7704EF889F54C638FC4215CADC5A7BD362
      6A97A1EB886C133ACF1E5F53EE95CED3F1FFD872E483943CBFE25C83540C8549
      9A18672FC28E1FD10113D759C3484BB3AD6D2FFCFA5E2A23F2D2422902FD4606
      D30940CCF5CF59369B90A9B140619359B75B58851495FDA03ECC5947CA06CB49
      1D24E319737A44DD552429A05AF2517931F7CFB8AD8F99FDC0746E2DB02B2DBF
      938694B4666B7BE61984324FCCAF25BEF886DD4829E9EC7A4CEF5DC28FF7B9D1
      CE3905972484E0F5860CE13C52923EC1F563077252A238AF42721EA015CDFDF4
      3E99A7B5328DFA8343269E44723966700155A325E9F367C6E82F320A29A54612
      51E0974DB9372AD5BFD13541965E8B553D36EEC581F37FD29928DE6B3ED908C8
      4BE3B48DDBAD565D733891665C3CCF25C1EF398FD17955F677319FD0863CFB71
      4C0C24CD6B0E8709A7A739FFF5E3F9C5F620B5CCDB5848A25D28D8203A96B816
      9C1C4A7B661654CFD85856583A9F9E5F38FFEE9C91035607AF827C34599B9B9C
      EE3E3AC7DD04F8A2C556AE7E774ADF9DA626D181BFD95B71029CC34386DD6CA1
      39D8BC2DA6619A4A578E80ABCC24D9A5F3EC64EF58D1D7813E33DCB6ED2F56CF
      A53C9C4C207325A3978B132D227625C17FBB4B6DCD58A503ED429A79D9535D4E
      312D44752A9DF4D220FD6C8E23AA6D6C59FB0F93117EA403D8A44CFC374FB1F7
      F2F61EAF6E61EEF03E80CA33D2C36266125CE666E7CD73872145D44686B36F4F
      084CDCCF8E720ED268ED6B08F3687F0510BBCAAF0BE8A5857A0E3290D44DD171
      CCD93DB7164394E4213893DADB9A5BCAAA8FFA265911722B31E1C3619A9BC2B3
      75B3FEC24955A72370EA75E27ED3852C3433B0EAECCDA2622236C04C5652CED5
      FBFB36415060A8CCDD5C7268B35B28598458EE458EB7E870B649C608BF59DE44
      3919F2F4A22E99628573A74BD4ED9E8FBB660668DEA6F3B0BF69ECBC45D47D7A
      CC56C6AFF13699F26C09374FA8FFDE88AA2048A8E15DADBD54534A88803ABE8B
      DF2739EDA75DA52939F9B5F3EE36A01FFE8CAD2E97D06F247B5FD3D110AEC437
      E76936952FF3D7CE9B341D92A7F2EFCE05B537FEF337C6357DFE8C2D3503063F
      367615DCB9C08C6B62A13197F462E61F66D998FB3B97071F39E667CE3D8AD60D
      DC68C264307DE3049E72692B2B972F59B1624DD63EF2E29CD732FF23960B5390
      A2088B4A6D694CB573660A7CE6C8F33BA04340BB200C6A282165CE7F901E9A4E
      28BD399C0A5FCEB5012DC4EAB75DB772D5DE68D82102A0BAAB0CD2142F9CF9F9
      6B2F439DF4F13F0010B824C8C938FA727260965F2F5D6D0156940C0F3290CCF9
      299D98C6C9FA045783FEC1309DC12C0808F09B8B1BAFB8EE47579ACB5FCD2E35
      9D494EB444F038F7842E7F25760CE7D972B132E40E154C6E04FE589DCE30B926
      D327C96BF4B42CB5E1F4F3A0EDE3EF76BFE3E21FB7E7F5F14FC7F73DFCE375FB
      2DFCD3F5067489EFB5E9925EC7A54BFAAEE7C9DD7409546E8F1FD31A0CE8A276
      7BD0A2ABDA2EAEA37F3B3D8FAFF3FCAEFFBBAA60469DFE7D19FC46658B6BB4EA
      52A7526FCABC7F64BB14FFB9EE2302922AF5DFF7EA15BCE2FA9757655639D4BD
      DAA373A86362FD8B697C92300FCE35EFBB2B5C49ECC8720CF51F1A279C99B7C9
      284AC9F4B849EB7154FBEACAB55BE3D5AA065833DC2DE384A2EC47573ABC3E4D
      C3EB6F6DA7FC0EEAB1A294D72BC8FB54F8713CFC03E8007B6D41334649CE07F6
      A6A7494863235525C15ACE6D5AA8262852B8CA0CAC3C5D9F9E466DF04C782867
      C48B3C1DDEF0ABE9308992966E132E9715B805DBECC566A8514BA612056852C9
      E2FCF6E9F73FA7D9303A9FA850EF3B2F28C5E8974F7F7DB12F0ED3B75FD0F489
      D0A0BDDFFD9DA850C7FE5D606B523D8AABE932CD2E6125C17A6F65D9D52D4D2A
      A74999B220CA41FCB9F8F00F62B993B557889D4D45A13FD151F2BF84F7619C8B
      0F8A2AEBFFA0694BD11997FB8375AE053E6BA82E7342FD2614726E6729F1552E
      3C98CB4CA52A2783B0FF07050A5B5F2550E8F597070AE16170A0F05A73FB2DD0
      F82B1CEE4AC8772CC9E75207DD39700FDCFF3424FCEF5F290E41870E4CCB5F27
      43281C435067913F1638A32667F26030B2F921F2C8E38EF3EB8BA0F7EB5405FF
      58B29871F2B2E3138D7BEE06AB8A99FD2DE45981E6F0CB706F8D751EE6AEBB74
      79E9FEA7716E259679E4DC98FEA4143C4AA377E3383D9E8D26CEE7F313834658
      F8CA4F6775EB958215AD078E2E8E0FCB32A1C6CE86205C25A59BE76201D3DE7E
      ECEC3B6F3FD4C9EE93CA9ECAD2368F1626BD1042E7A0D5BCD17FF6BD3908C106
      0D5DF2A4E13CB095C78DC739D79883F9342F9333DABC999527618D9D0275EDB5
      75D25F61F4EE4656A2BB6C50AE93AE55C46DCF7BBC26E69BEBAAE26478B3E260
      961FF3143432FCBA4A390CDC22D39035B4B14CA8E1A7B5B435209AA06D4ECE3F
      596D63CBC8747835B680BBE239F261FEC9F9E9D33335B686E4C36BFCCBDB8FDE
      5F9DEFA82B2B25F1BEFBF0F6A3D4083EB9955C8F3049B89F95526FEAF6A4A41B
      5EA6258DD1393AE2A3D6E64D8E065E825A991AFEA7254FB6AAA2B6F346A7F3B4
      A456B04A6DBED86243AA3A3B3E3DDA773E72352AC46AF59B93F3F74F8E7BB742
      768D90658C5296B4D66DFF7472F6C3935BC73ADAA2F3EAED879FFE4A4850EBCB
      618C9C6ADE3C4FC6399D3C291B00E7222306934B47368B9701029B1B9490C253
      88958C728E6F091B11F6EBA5542B505C228D225310D4C0D93D7F766CCEE6A2BB
      B11A2521ECF019C1D3509EF230B21592529655A49B2867A4B34B6E5A3F0DAF0E
      9C9F0908807A094D5F26A63A580DA5406BEE6149ECFCA6B3D474B3E36E902ACF
      E9C03C15AB999B40D618B420CA713258513962D067CCC82AFD742D080EA5FE12
      FE0425FB2654F141970A8E12AC725B0AAAB8FA8D874D3DC3E0AAC4327B7B3525
      94A563FDF44CF8B5747B737E48A86E37AD836EF3064FAEFF373F5C7F99E39EAF
      7CE6B3FEC4A74C3F65C69B28392D2748BEE446325B18643948C60CB617117E06
      FC4CD3C06E96EB12BA194CAD384B526E3E708ED5B4C61188A2FCFE2B2D158B78
      74381BB23A9662A5F7C75DC957BB789B52678C611264D59CC9ED09D3234F98DA
      DB13A6FB366BE749DBACCF9FFD727E7E2246EB112B48B8D447C35960BBBB38BB
      E499180F666F9F6C06C20FAA78A96445580F07ECF08DCFB8FFED200CC36F9F3C
      4BB2EAC9317B1D0F859B28FCD5D991764B53EE44263D76F31D7B6C2315050D9C
      5EE1B798891C4E8794963569A8F12E513BFC5541EB68DE2C9E3F3BBFBECB9291
      F3D39934EFA01E3DB3A947BF1B21F31A06EF58495B3C72A27F3A239D72A03F73
      E61B08507EB02F0DE1B99C4D20BC5EC2EEEDDE64F4F9CB38F5F05361813470CD
      9F3F2B1A95BE268FA3FF3282730607E14A7F56910E1382D9369988A6A517D59A
      67E94D229D089D9D37140E3D9304C4A23188CD2BDC116FA61E9CF2D8BEC996F3
      71EE23BF86B11F9A48DE11D4755216F88260C5B9873451251ECD935132C4E0A9
      6C77DF626A0E93F0DA94AB9B5276C505D8452F644ED01817D9D78D22CBCE99A6
      642B0B86487DB616676DDB9AF1E78C383751E302447C2465751567598D9B4989
      A3743461A81373CEB79C1467161E2F72DEDC494370AE99A5DE3B451BC34A974B
      93E5221D69EE260D14E454EF2B8D36FE2F6C88BDF76AF25E65F02BF283E96729
      0E2EBFFCAF99CEA71798A67C99C4757205B93DC7782A009D0C5429C83406FC87
      A57D08531AAE1BD7D34B0B57623A7245E4AAE69135B1CDC0EF37B66BDE646E0C
      341901345BD8E688E5E528F94D357452E34ADE066B8722327CF8E91D073438B5
      95F9F36F39351B1F2731F4C688C2AD891AE2C7611A497C631B64F8B220C336C4
      703FC4E03DE910C32FEC708A0F50470B9C0B6A2F9BAE6451191FE1C9AD7BDD89
      9F9F34DA7D334EA8386D8ED7DCE57840CF0A283563F6D9EAAEE6CDEF9F5DF56E
      35E71769CEF64167AB3BEFEBCE6E6374E76AC5F8E4967533A5B2DE2468B0D699
      4DE397FDE23085CE4AA6991AE74335E5BC05411832BEEDCB70F25AAE0FD3D188
      9B5972AAA30D67366FF63BE7538A994CD3DAE1A4E6CD71BDFFBE55598F55595B
      776F89CAF29FB4CAA25EDAFFDC8636E77916678C55D17E394C6F292C34D2947D
      D2C0991507A86F396FB040039625E300374581698E987E63E7F9FC995943FADB
      ACA3BA499328772EE55C9C7134320D278AE6C908CE33C25EA31373732696E9D8
      9CC0E5FBEC744172194BCD640742BD8D283AC8A89D02A64CB07B1386D921B4F4
      71D1BC7EAB29BE50536C738F96688ADE93D614A5B4396418E64F6F4E0E8DCE78
      726BF9AF758AF3D3FBC3638A21B1E0D3A3C9F48E00F9D6A75DDE3570AE9F8DFC
      A7E95ADDF6E6FCB0C8576DEE8CC092862347E98D457785C6A6F61E9468CB7DE0
      86B0C8F2504D3429BAE6CD15E2C3EA6F4A2DFAD891DFB6EAF40BD5696BAB4EEF
      ABD3FE9356A782ABDAF078BFD42B8D20B1B23B67A8D57563E75081D4A6726BCE
      8D3E7E7778DAD4F9708B299B8A93A5D01EEBBB4534D1BB57D18DE2ACAEF769C4
      25F2B9136B452971CD9B4B94A9CBFF2782BBC9DAD134D194DA97222FCD24AAED
      CC053212ACEE4D12CDA82A87C0DA9A37F538A5AA3A653BC44BEF5F6CC18F4D4D
      062F4F421B5E92FAFC5939156E4160D2B9E9488B5224CC59885CF07A67AAF3E9
      C14411839A104A1188A2947186B2A4BC436FED8BFF2F6727C246FCBFB01AF74C
      DB24BCBB7924143B4DE5791A265CF6692B3D8972B50A70B818E6AB95E050063E
      96E81B571AEEFF4153F5FE45A61AA79D6F3FD3FA38A95F79B2E39B3F60B21036
      7A9C37538E7309208C24E76376A9C6C96FD46FA6BDCFC16E778F82DCDC262AA1
      5274C6A437D5B7CB8FB6B1E4A0C0B72C1C7C394ACD185FFF2FF303E993FFF8EA
      10B90D5BD698DBC97CFB2DF8F2EFB324BCA6F6B2D4866D9884D36FBE1B8D81C1
      98F45CCCD2BCD51BFF2138031F5FFF7120035C7D25BD9DD3D9744238F8E9D0D6
      25935D68E283F6608FBAD98E66E19561742969862056A309C4D5FC3CBE410395
      1D10EFE0E0D75F21480B39FAEBAFB083F35F7FB535BA91730CFE53E329A6B2F3
      AF2E9FCA53A38FB6F1D9551299480BE1D40BD4830AA7A9456E69E2246982C7E9
      F8C594E3F443B03A1D38E734C98BB393139331068628CE9EED51B2A35970AD3D
      B01AEB02C5C60933955F35904C8BA7F8FB44887B99662FFFC380ACE187A2EEBD
      91C71D66C23F6B3549C7AF0EB3519ABD3A1C8D666393113AA113ACFC4AEB6903
      99BEC8CA78F3F1F8E215FE72D919287B4EF3B16481842EA0051CE2A12603644F
      725B3112E7D68470B887CAACA17006428D77F664F9F8E39BFFED5C812498EADA
      9B1B68BB98F99ACAF52B703269710A3F3A919E682A6618DBE3F54A05EDF690EF
      71877CAD83CE36BD72C929DFE0499FF23D7F96E4F94C3BFEE075A57F2BC3BF19
      1B6801B58E8BA9630AF6B38520C9678E1AD155747981404740BA16C5BA81DA43
      C8D2F6401793A097C070FA2C5DD9A5E1AA34AE3682E523812143578C9A3B57BF
      06B7B884AD62900A9C2C9D8A07A4C69743529BD9480DCD61B104D18DB364FBC8
      A725A001B9247BCD23D5553ABDD6777915E7A304EB30881FBBDF3CD871423BF4
      5BFBCC2F6D83FB7DCA5B9DA83F20CEFAA76F1ED2E1B52658CCAF1F427FF9074D
      669C8E75CDD97CCD28CFBF7DEBE92663489E692365CE3072CEAF92786A5061F3
      A9926410B1BD2864759D4CC83999A654FF650511AE8367BA4B1E0C1C73D6C2EB
      99623A0B0DF6843C1DB66A4E4D28A1DBA9AA4AE071757E3DA53400F8870D24E8
      F367F748CAEE3D91EEE30F0FCA76C6382694A284209D41F589319308F097C346
      857A14406442D06D6CDF25FD991071F4CAC9593231F6B0BA51C9D0E645341624
      4F066EFAB44E6AB0D250DDF1A914B51937E94C6007F133B93C09CAD1448A7367
      970A36823BC7B80D0DDC3B47D36CF8A7236A084B6DA5099ECCF940591634786E
      5E3B4C26418A49EC3B2779885F5353BAE2FC443599B28D9A37ED6AD1994101B7
      BB9B82A4C62F8A66B08A6335CC6D4311022816B470DBE5974F07A8FC296F62A1
      B581CB92641ACD1844022EB80F0A8D52E7C52143D82DBF8CD26E5E346FCE2B32
      A52AD04DF96B0AA1D69015D29A8331146DC6D22E6FA89FF7F62B5D6F9D37597A
      9BD301F8E170FAA7B79D068A89E7CF8AC5AFB4FE0DD2F47AA4B26BA3334DAEE0
      6B112AED8383AE3D7E53C5A5FB0ED1C07E77993A810AAF9B478F4AD1444C13B4
      48E43F9F9D1E13E2666A0F9FC6E9EDBEF3221DBFA8A889E64DF77E3DE46EA031
      63136DDF27407527AFC145265AC0118A26C60B8A43089B5EA8E89085102E6164
      8CA1386113282E57CB87D491410A40210D26434DB8AB46D7DCA5B3ACC08C4B62
      D3B9A1C1E438BB5FCB6DA6BAFBF3C5F767FB7C3AB14F0D63DEEFCB41CD444DEE
      B259CE3B67DFF94E4F4F6E20528E691F153D5241B7A270EE83BA79CFF5C4CEEE
      F44A8DAF5945FF2D1DDF46BD06F29121DB615483C4C44D4CB25D4B33C3397B44
      023AEE9596B0A73F9D7EE7EC5E0ED3400DF92B7CF0E1C0B9B8D2DCA2EFC59420
      7A35282B40C0473FD0D9F094DA9598DC6E53924CCF9AF24D120F92245AC630C4
      6D9572E486D1DBB395A47F39FBEE18730EEC6151EA9C9DBC058F72DF3BB1F49B
      DAB388D21F283380F3EC3249E8FF747AEC56A68B35FC7478F403E414873D6B30
      20E5433791149424F1E6D3C5B11545648C982A86208DEE284B682A9912845D87
      2B3F38E36672374FF54CE303CE6E393A393DE56DCCE6C8A594A92839E1E183D2
      B8A11D0A44DF78AF4C2B3593E9C3B3AC1A621FDF9E5F547491B3CB3EDB8BF384
      93B88C99FAC2C606C85C8BE3BDED79F1979E176F4116EE9F177796AFEF53392F
      D6F9C43456AAB1F0A6CF2F657643C8043A4E33C8937CF4E456BDEE0969C77F4D
      FD60F3297C5007AA328B8706E11F46E765A6F39C4BDD423901A550CF30259F6F
      620380CD9BB94D1068777AAF1DF15404C1A13010A011A955EE94DAFD9083933B
      EF2EDE53B12D478CA143E7607FC69A4045437C3D6E6446B454AF528E24EB883E
      D503666C18E57F9F51F258908139F4F43E55DED6D8319269709970A840C284F4
      688BC5CA20F6399C9C037DE0FCF23F3F25D3F3693AF96BF3A8F8FC19877C8E83
      E111E755A6E3F92624926581FDA42E29B6AA024A4319D236D3374489E11D1BAC
      EC63A4A6C1A6744468A0706137A268F060EABCB9F3F46D1917322D5268969134
      A96CA0FB4F4028A23D68A758BD7047E9F2E194F0EDC32B39BE9C5EF1D9521DE9
      34661B3CB7F9F95DF16DC9542770D3E2997C5C65B84742F6CD235FB5D4752E16
      BDEFFCF88EB3ADB274B810983ECC7312462335C656CAF6EDEF818D30F33E6C64
      88D984444427FDE5E8FF3D7376F5D866ABFD4687B4C569E57FEECDFBB3E4BE37
      7CC29FDEBF3B6F2CBA5511131D71A82E0DF2944B12A85E7B58B12C5E3BEF3F1E
      BFD9C7DFE7C7FBCEDBEFBE3BE4BFCFE9EF8BF3C6CE7B66DA799F1E5D7C98733B
      A95C4D4715C5FFE3F90F9F8CE1DCDC1D5AE8305310C747A558F11BEDA861A2E8
      7C9867EE40FD93EC2279DEDCD98A815841B80C5369D0CC41B486EFD817C7EBBB
      BC3D7FC62EEE0BD31EFC4A73FD4CC57E79F1D26D7B3DAFDFF1BDFE418BFEBC20
      7327D0DCD797A51B58846252A62C491E44B167385F7F393AFDB914118DA5A43D
      0FDAA160D4AFBF4ACF4C2720209C7CC766512F1E03FD139C0099E9575BA6DB33
      1BC91B2709C0FD269A3937AF14EFC6AE5F1F26993F0923E667B04441CA692C19
      44107EFAEEECAC627CE1AF6C36295A25AAE9D5654638B9D2EC4EDD3432263037
      E12592FFFD77276F99AFC9EE1491F697D38F474D9762C594777E1CCF72FC6B93
      1AFE727E72BC03A99D3533C4539604CBF424F9607E493F7C3AFAFFF679D3D6F1
      DAE64EB8B78DE1BFF8E0600B27B9E4E0A0FDA40F0E9E3F33A8CC99BE79F5010B
      F65E73B7618ACB986490D918BBE4C0F911F68E8AC9E2832DC8262173402ABD61
      4DD1029D4C2A2A3ECB92CA967A3AECB0961EE79A108179FA99FEFB2CC908A752
      CACA18C527E2EA63C8D0A8819393A556582C4ACD5985D143AB493D88E2BB026C
      E00579BD8914D6D510107C7E4D4CD33C1271DCEDB0C2D1944A0C29A7253B54F2
      A41B38AF9DFF3D1B4DB8434F5A987962E4BCC86DADE4249DCC268CA5D0C0099E
      8C29F8FECA04E1B9681676ABD4859AAA8706CEEA34BD945D47C90D373ABBCD12
      0C7C4C49209DF76F1A38A15F3E1F8311A929D8540DA99045DB26EB19058629A9
      87E20C57593ABBBC8206A20F3ED9435CECCA2B45E129AEF3C9A76A34A9218D0E
      9C775367C4D18E4053C5553C1BD2A3A67422E8603B0BA80A9B930DA46889A781
      8FAE73AB9D2BE89B520C4EE8FE14C52B5B2D1E389F4C1803FF1DFDC065227C2E
      CA07760D24C5B2A4A207325AE54C93A19B2FDE4B413D9DC8DC192CD9BD83C2CB
      FF163EC1177801BFBB8D786ECFB65E3F39A6F8E30D7CF7491BF81FAA5DCDC9FE
      6BE0BEFEB0A2D46737195321A454405ECE868A8CF409A90AFA7AAFA133AD9E19
      EF5E9CAA008668444EF6BE737144F56AA798CD9BF47313E76745496E93D05448
      208C50F91C7EB3300E72FCCD85C07F7ACB7A89CC70713821C7E1BA68FC6ED41B
      55B835911667E69835BF1B4FD567E70AE263482284BCEFAC28D3339EC7B78C4E
      3D654D441DEBF2AD16BAAF853A4F5A0BFDA4B2443AE126BF114EC1D494EFD3B9
      03372868E0FEFD38636425391BFC2799D33B89A9B7DDEE3EFEF2E9AF01FDD577
      76E9AF5B95D7D9A43B9400C84575449B9DBDADF012BABC4FF2702BBBEECB2EEF
      49CBAEE7CF8E0849619446499C50D53C234F8E266A9A04C930815FCDB64B90E2
      AF638D1926CE5F4ED8D7FECB49C742B6E604D99AA7B38C900828D5B281C241C2
      C76F54AE3FD06C8AB0429E3AB3712E911BBC5ADD89756760E6A8F9F92CA4CE3A
      E628A189537F7337D587343567A8C7975868781E19C54E3827C6F79C2099E6DB
      13C42F3D417407DB13C4FBE2B1FBA4C5232F22F63AC9839BC4648E8FD264A4C6
      2087F38FE7CFFEFB5706A9FC351E46E4CCFCF7AFFF463F52E6D9371EAAF3FDFF
      F9747276FAEEC30FCECED5743AC95FBF7A558CF420D237891A1386D701C4FB2B
      FCFBEA42E75D1AF2CB779860FED2F37B03B7D71FF83BF771D9968D9C51E6E6C7
      DEF6063DAFD3EADF1B3C518512359854B8B3D58A5AE140ABDE201E042AD4ED76
      3FECBBAD9652AD9617A8412B68B92DF9D3917FF49AEB079E5CE7F75BAD9E67FE
      C3EF3DDCDFC1556E2CFFF911FEA37F07E66710C7D7B8A62DAFA2FF5CFCEEE37E
      BF8BFB7D73ADB98E9E4B3F8341F967BEB6639E19997754BFC7EF5DFB2C1A0BFE
      7DFE8C7EE3370CCC55B8D31B549EA4E56AFABC83EFB1215B1D4CA7836B3AAEF9
      B96F7EF765E6BD41B7DF6FC75E276847BDD8EBABD8058DBA51E8F5BB6ECF3774
      04CDBA2AB074FDC73FB0D460D72C1F6ECAAEB3E1AF61EC7E057139C7ABEB37E4
      86CC8C19FE9AC3611119473F9178D19F5BBFCAB9E05D0FEC1AA7E9D4FC18A6C3
      FC33FDA0C7D1F84A679AEFA65B28678C04233F4DC45A38FC358FA7E3E06F2B69
      87F93F66B33F393D513BC592AA2D933161D22A5BB71CE93025C9B97B66CA8D0E
      CFDE1FEE3B1F7E3A7F4759F6C7EE3E81407C6C6294CBCCFAE406DC43A620056B
      198FCDB9A482173A7D7B772C495C9436304C7EA32B04C1AEB1B37DBB2AE590F1
      3F6C385E3A2515DD1B9B375B5382DAF29CD79832D58FA504A545F823B0FFA926
      9991F6F291B34B3F5C5EA5F9748F4F7A8BF3DB4646496CF16DBF8F891F4BDB0E
      0ED992A747689CCE4451DF8D74381BC1FD4BA68464096F0873A35E9BDCAD8276
      BD29187476A319275129E74A099049A6614D316C5D30BBDC23F0175C9FD408BE
      282EBE94C08B74E952942ED96022B7DB0350D922575DF149B58A22DA3EA07C9E
      3B7F393D3B2DEA344DCF488294951C3539CB250AA6B9966BB95D2854208CD58C
      0BE0C7C9E5D8C2E5D8D603EF2EDE379A682D108D4F8B2AD0865CBACA9087B9E9
      FF0A499C44A6C6373F700E8779BACF16FDCEE2BD3B14C220D80D915E0DA4CDC7
      4AA68969FE45E74EC4300C9304753CA5524CDE3492CA18686821F27A1B38DD42
      48B9E5F6395213B88C0516BCC9A31E0B4A2857C973B14FA53A3E4A28C2436623
      D8E358E7E1DAF7F2312D3F9C1B13F066A324939C5A2012F42671E13622BC4DAC
      581BF7F09F74DC63FE289B52A8D8F829AC3B0E0A533FB788C83851398C5B6787
      3A71ED38D7FA0E6ABA89A60F252854B0562DB674436732A7D2BE69FCF6290BA5
      ED19FB0A81D47BE202E9884EA53276256E93E1902D199B35AC1D72C93E63D69C
      43056F8D2C9D4C2E4CA6040C74A3B9B3628A49DCD1156BDFA8A93AF82A193751
      90193BD9ED929D6C814A4D99B3349B639028AAFB205CA506CEB0F005DC36FB02
      A6D98F01F44963E70CD62DE52B487B48EE00C4FE262CBDB3A29950D16380C354
      437527475E52094436B23858FC753A86A3F581DBB7F193CB96447F393A3DB39E
      D53C750DD84403E96BA9DB7AD56E5320E0ACC68A1404A1AD690B92A5D5455155
      25E546D53518A6E9F56CE244338E9E718D55641896D1AC0867893B5FCCC6991E
      260D55C8D673ED81966FA4D9A94981FBD1F646251FFDD8547814E4C909C0BEB9
      D325F74C5C5367C7205B4A1478079C30B4B656337D503B471240873F55ABC9A9
      C8BAC67E29C23A0C3D0579C21EAB24191C38E7122C26AE18418C406BA9A1AD3D
      63314312C9E4290CEFECFED11C8A8682CF1BBC4B5AFD3A06C16BE7270EBB131C
      A2A1BB086E72E8E9B793F3F70C6870E0BC51E1F525870DCB3683C36494983800
      F7D2C6BF0568A02126D75835908C85726CF5D80090F0BC72FE3ED3F9D46A2AA3
      19319F4C0940A2114871A62E0916434AEBA10E036D3B8F43953DCC974DAD33B2
      F4F241AF133ED950B550CFCB526153474BD0937CBC23BB9A4E80C6EA66C4A0F0
      07CEDB04FBF647CA13A253310AD1564274E469EB38A644CB1B6CE8626753CC5B
      027702CAD440F2960C4916E94763B513F184252DCBE50E28FF5FFCD1A14169A2
      92257B5C5056D41D38C7B245E9EC69DF3262C295BC84C197FCA6A39282060536
      D0EB8113F048829568208D2D852936FE539A805C1777136D3ABFC026A60399C9
      44C3873B70DE0BBD72D9CA739BF65F3D3EF0C398F62C93641B25B81F25E83FF1
      2881F55B3AD8053FF211F4BD7322311228A5D308ED7D2B20AC1501D506572365
      30E1D7EC921C51494E2CCE65117D082C4616B422F5FB98920052DCC38D1BB4F1
      50A85B5913531BAC3881055F83ECCE47D3CADED8B226795650520D889A827175
      490DEE4DC73AD8AF2FA605B588CA7CF9813D078D529D339D730EDE5CE9F9E7DA
      E463A36EF9372C811CC7A414F5C16A987285AD70DBE6E83F24D59AD12FBDDD26
      EB69879C99D9C4F0FD8E1C7907E96788ADF02ACD248215A4536A86473D3420B4
      1A287ED44D9A10269FF86104B51DD66A76076A44A59D08B19C3A8C0210E96076
      4921C26F5AAFF34F9AC8DEDF26B2DF9321DED3EEA1F1FCD9CFA499A7946A651A
      E2191599D0A1C8548D4D27550D2F94EA91213AB8019C6DB72B5653D9EE99542F
      7EC2776AE87CD09F67ECBB9D4FB51AB1C79A5FA5A66B078CA36356F52ABF7654
      406D8C7818467F4340CD460D84DE2DA0493E998667BB92FF68F115F78A3E4E64
      4FCAF1F908FAD7C65FC4742432D832FF6378C1E93848B3B1737C7AD43C8A187A
      EC10D29A31089D77C73BCB52454DE8B37973BCA0B999EC9F02656A692210CFD7
      B60268DE440F4DF91F09053904ABF4E1C687E6A4ED7F39FD56EBAA79D3E31343
      CD672DD44170988057C374C8FEE138B24D506D962BB40397C535B7C5F8F3673B
      F39DC50AAC34A9F81C87095949E28C9956B9A7871F8EA51D26D3043FBC2B187E
      57DAB4CFF767DF3B703E8E2B3D640DDA1EA30A8AFDB06FDA3427BF35BE69FB3B
      DBF473596F8CF5D55A645571FB6A939FF34DE198FE49EDD2DED62EBD6F973E75
      88566335FC68F205A2440D533E419DDE4D4C8B1D416C6F1FF49FDCF2D698DFA9
      14FEE85791363540DA994DE3BEA917A27857A6C6F9B0AC97329513FB829A73C7
      3277341278564854CAC63C9F66CCF6208E49CC24505373EE314D095DC9343F68
      1EC90C4A2DD488D818AF8A238CFC3A99AC6FE00DB245116C2FD3CF602B59BF82
      64F5B792F5BE647DDAD8782574E6C7E30B922B304ED8E88D9CDD6996CE022A69
      E370FDB1BA1D5FCE08F559E78DF6C4DF167D12A9DFD6E1D189C95317F48E2099
      70DF27F64BCD51C33B8E7294F027990AB5B3989723FDDB4CD424DF2F8B1A973C
      524AE56C32C0DAA1A726A2D25854D24393ABC7DD023167FAA19242CF00789C52
      53417D83F7B068FD6E1B1B7FB188EE6E45F47D11FDB481E38CD8822749AD2839
      DD8ADA83BFFB747C6E7B718AEC6A6A471E4C4E70958E4FA8D9B9C9273B3C3DFA
      DED925C37EE7580B80128B083AB48252DA69A00AAAAADA4AD7C79CA1DA6BA582
      729B5D83148AC7B8B4BB0528017F7F944E3EA4D1AC72A2B85CCA400B74560EDF
      C811D085C6D2AEA2491831823393C60EB52A2B674F4CC3BA83F78ABAB1141312
      346FEE85E922DB2420D0F6CA0ABF978E659FD8FFDDB5AD2B411596F8DE1EA756
      5086499146484D1CC66584DDB9522447D68BA2220AD5340AFEC240E8367A304A
      724EFAE13668A69959E366246DAE56C26C9C7F3A396D6C4FC7E7CF3E71B1E8CB
      80F1E5CAD8697E079379C43B7DE77032014B4B05EA8E204AEC729A4359933967
      3D523B6EEAE5394D1BA83A764CE9BE4CB481E33F84C8BEFB4D533B0F990305F9
      B34C8FA7584473069A7F0D4823B7DEC4CC80DD65E3759D74AD65DAF6BCC79BA6
      7C735DDB3419DE0C978767F9314FC1443DBFBECB9291333167DCC3F46B1C657E
      C5855C0F8C110C931B8AAC9ECDC654462652E55396526E42461322B8BB8D31FC
      1E09ECB53E78B980E2F7FAD5ABDBDBDB833125588CD22867C0B3D4CCE9157DF2
      CA6BF7FD4E4DD0BEA704D9D7739743F655E1FA7ABDF23F86DAD3064A8FEE3190
      7A05A49F6740F39641F2D17F789F1F1AD03D0BEB67C0F6E6A001ED736203BED7
      26C83E86DB2318BECE63E1F67AE1EF0EB7B796BD3661298C165CFE0782E73D6A
      873D3905BA0D82ACB308DFCB313A952E2AC9ACCF53278DA91518B778259B82DD
      21F26F763ED279D70E79D96218BEA11A6E4A4278956985B70754FC6F1CA7B52F
      FF44474DFBCEB9FE3B63BCED3BE6B48E0FE3F61D3D0D0F1A6852BE9D0DA9FDD8
      848CE96B027F92F076E6D803000EC25C6C63AE5F1A73F5B631D7FBE2E6A903DE
      2F241C509D8F035F1ADB03BB231A9233CAFEB6C97C3D987EE63C5946CA902E73
      A9F3E6E3F939E39C728CCF3AA54F8E19EAC6DE4CACE186AA7EB9B6A6D2191E1C
      FF5F3F9E5F34766E47277592344E9D5B4547762CA1083B6E36E16063A00937AF
      C811ACB442691E41CA60E38C8E1C472957BB0DF5A50AEF9CB30F87EFCDE92585
      5CFF6CF8DD8079996FA4033905A4F1F77BFAFBE793C34FFB1CD187D27D77DEC0
      ACE5822AB665D5F24916615926C47C607636CE55AC25243FB92B61046C788A20
      65EA65048ACC69A0C941FDEBFFEA7C48F9C0CAE48F1EBF3B3C75087661D2C028
      2CD8A268B329E2315B6CB6298DB4D565940E8704CE8A273A61A6722A41A2C6D2
      A666826B2A38C4692CDCE3D3A306128460249C9D12856BC73491A6A63104F163
      EC73D3519B0F68E274486A35894DA90999F664BD37505116D9BE84FE04DBE6AE
      3416C0089FFDB50FF04C84BB812BFF3D96D139BA383B6567826D23712E0CFA05
      3510A2AD10976EC7D6B5F852D7A2B3752DEEBB164FBB594C614918EB40D2962D
      101AED1089A657CF47B0DC23BA3A7FBD3D2159B2DC0D38213925C1236663BEEF
      BC2311BFEF9C4F346C82A7B5A26B678219BC9E9FC0BEF3BD5664E66653FCFC56
      855FAB56E75B4EEB4C85FAB5F3BD4A32CCE1E44E3775798EA4E59CCE9A36F033
      2DC50D4D1B37951F38D48FBA6903FFC13AEDE9F8B573988DD20C3EAC56130A69
      1F8E46E93E6DF5AD79D14CF3825CD257EC6DFFCC514A9D51E21F99E23F1E9F89
      7B251045D480DCB9556CABC2C8C873752976BAE08D4263A99BF7024CF7E478A1
      6E70CF0671D75E7FCF79CF0FB60657330DAEE7CFDE7C3ABEE076CDB6B2E30E9C
      6E8BEB2289604B38866126B81D0E7CEFF154D83F89B96079EA0C15D5BDC0F876
      76CB5C6B791A3BB5F4A0AF118BFBC6461CFCC96942608A02465D9D187D0E8A44
      FAF3EF1FDDFE96B3A6130A4719C8C8790CEE72F23CEFC64D6C7D8AD60575E2B8
      D4CBD69BBF68E4C48B805BA1A518636F7CCDE1F4E3E406539BA6D9D30B956FCD
      985A66CC5FC99DD46FFFE24CAED2B1A6CAB95B365DCC31AB44CE4DC673A5F0A1
      81A6CAFDF2C47C3EA19BA74707CB2CC57685022328A0212BB9D034AC22814D97
      FE59AE1B1658E046EC315AFEDAD14C676210421150F1610C1F81803B1A4CD623
      A60F89BA6CFA528FA5EB20E30A53DF07FC405D06CE4FFE4B8E2976A9DE93A096
      E5F4A2389461A82A6A8D96E2F226D2A32C2613B92995039C36DF4C7C7DA9EC38
      FAFED0563BF06EB0151E820978A586D4B35E3B062C82CE668F2964F51E6C7D47
      276D8D9DF8B16DA0C9C7A8E658B5C6AED817A1A1A401ABC1BC9D93375C1C638E
      B31B489E0F2957D53138BF4C6C87F6F435593EB704014BBF498304CC76A78133
      B487AC5CDA86014B5935C17A58D0A664CCC0DE54ED15950D071B34C5E7CF4C95
      CFDB6448AA9E94DB913928972A126AB633D502EA2BE762B2E2B1DC90C37521F8
      14E1005AF249460D533FFE40457153A1519D3E4FF43021E33EE3060B22800021
      1A6C616EF4FB39995A10E2CB4C8DF6051EF1DE684CE48506A3B366F6FE314B52
      C107B311A3E60A8D7381F6366130F621E6A269AFB8E88ED8ECFF1BA6979CF337
      9BA4DC54AC89ED60A5CF1DD543521B3442C4E06DC2DB08C6CF0BC2301C473659
      43F2342C1A4656E638146CCD7114E9A75BB47316AC4F7A36ED0F7E34A38C7079
      1EAEE037F0F3E835FBCE6436E53C9071354F244BD3A9CD131107C07E09D2EB70
      36E5A7B1E58687EFDA6A9E037CB9EF60CD7E929FF434DC02FB3E2AE960EDC573
      5909EE362BE1BEBFFDB45BB99A0ABE7329C46CA02CA35EA665E717C9BB82B46A
      DE44A4D017965CC008EE0C204B881FC41F5302DFA4560569D6C4768C677AA447
      0164F824CD4DB349087F0AD169CA0425993E52DC14A9A1F66A092D25F96FA6C5
      185BE8E757493CFDD371303C1A26E1750327F7CBE170F857E7E7EC4E3B6F547E
      E55C5EA539997B16FB7BF75E6DA9CB226B7ED89877ECD51CB91D5167E9883ACE
      BF1DE87C72C0E3785C5DEBA3C5E51EED4A9E780D23CB4691B859655359FB97C3
      D3D3BF3A6F4FCF2F1842C6A1814BB6EEFC114A63A77672FCEED851DC592D2FD1
      9E8BA3AE06CEAB887D56CB15592851AA87F15A8795EF4AF0516598959AD3597D
      342D01481B480C438A97C3D7F63CD721BC54524064A33B39261B5E099079CAAD
      40049C7A58C352AED24C9A19348F3E558C21F681933C2F84BB897B73E0B452F0
      F68AAAE2B8288E5D6193DBAFA991415CA805A24003E921E155C9877A9F463FC0
      B779F7FEE3B10D32DBAE0D14F7B85119633F16905E4D5C7F99EFA7D363771E9A
      EC5E9B6AD67C304DB1831A3A4DC98B920692303ED7DE035151ED49C6FDE463EA
      271B279F0F1A09BA670324F6B431BDA584D1AB6462D95B2A5DB1D24727A7A74D
      5CE67286E7E3F4F6CEB9D58A11B0AB7559C9E76AB2C06136BD1AA569B68D107D
      71594A7BB00D00DD0F00F59E7400E8F9B3A42C5E5BCC82A4FD2111153E37E563
      53828136A961DB0DF3451B66ED6DD8515B68F5253BEAA9B7997D4B3DCF67D30F
      3FF15EA1BAD691CAAE4D37790B269EC44E349BC0D9E4F41D2984C666BBA14ED4
      D41B8AABC49EDCE2AF9D7DCC8605173A4B306C98A6D75C0A3A7508D5D134316F
      6E8FAF1DAAE72771297039F94ED194E42A9D0DA38AE12C0DB579A1F5542543E7
      262101C0915DF2C6398B6BDB7FE2CBCD8E2DB8F91221F9D4BBD646DC64C20929
      2A4E55F2CA368D3347C0B6268537CDED159DF15EA5438E5170B5F9DF66A389C1
      FD52D3C622DEDE13972C556892139D5D5B6149F96B34D593319DBB7F4A937103
      91BC9F3F13D7FB9CB3CE053992C228F2E99FCCE79F68DA2732ED0B9A36256E11
      4EB572B8A946049F550294D487D4A6B617C0BFF440E29E5CAF1D8F81A7E05CD0
      E65193F2F7E6B60FA5FA6630D2EFAAC81B9A15D2AD934E3459F314A5E330B0A3
      2E31B3E6CDFAF933D930C9F82543E2DBE9606F48FBF7E19D13529C86E71AA6D4
      D3706A998D62BE6C6025A44668BE941D7D49693C2AA472FB5B6982ABE5BB3121
      E60FF1B1E97BD8446BEC3DB79A913A389EBF7C7066DACA9001228521F9AC06ED
      39F4491D827E96BAC1D7B60799FE0CD227D44F4B0DF7ADC7C8D40CF1F06DFB96
      2FB170DC83EEC116EEE3BE81D37DEA2DB529C48ACD95E73A9B2E43EA0FF13965
      3DDC3F3ED86E94C76E94F676A3DCDF284FBDC7E79BD9259D47BC76E261AA3871
      6642162EAB6F9525B934BE2433664839DC3BF1ECB7DFEE760E9C0BEA134FC53A
      99CEE9C896F612D57D148FA9A3D2F84DA057A0337987792B452C285F55FF7DA6
      860C7E09CB209D5DB28170E7D8047CE3AC0C9311F5DB945C261586B38C5013F1
      BB31D3763D27B89BEABDC529F2C1527EE0BC91EC57CE0FA79E72547F1C4ADD16
      A7BDF26DB9B83A26CE10E862743264892FF1275B41F2A582A4F59F7F1009976F
      D64D49C8F2690909412426E197136EE74CCBAE21B77DEDD5F0EB258DE0E0E060
      E71B52F60B68F9BB8B3D42EC213F8381CA4D0689200B8013C7EA26B994CC9269
      A63507415EFE8753257A95A686A435323197DC2F6247C299EC55DB2F21BF2CAE
      69A029A84982CB465CE23A474B24FAA80B15C5C0D5F88E8FD0B324AA74D16420
      86112D1049B4D0A018451205A2D7E0197B547AC3BFB1ECE55A4E477E93D6C61C
      5067595A9B12AC3CA82221D7F16C680B7BD83D1C81A112388EE41ECD28FF656A
      EBC660458CB9C9B2385446F8C7B3E92CD3FBDC6E4B0D31D45B35E6AC1835BC55
      773979A63734676582FAB659A8B3AB0F2E0F30823A9404E5DF7EEC7C12045828
      8C3BB22CE1BCD217633C8B283B5493095F68D6CF24E69490166642FB8E2D731D
      A96BF2FD325349354E6D102ED3F278F2E9880F6C625CF5F11495A157D033C41B
      67FB962659A9295DCCD00C566DADA0DC5C7564D47AD17E78F6E1DD87EF5E7FE3
      14D1E7CFCA181E51BFB29914570CE54C44590AD97ABC0AA6848D8B5B60AAAE7F
      0D6B7DE98D489EBDD49661DDAE65A771DA83790B2FEE2C67564E72FB299D4671
      38A0E874CBEC4F77477AA2C7915A6499B196F6007C1DF5A4657141D960BC63F1
      0D789475A8D99DD45347984DA4CB342DE831B7A579F04A8AE32C2422CC288808
      B29FEE6AEFEA436CBF7D99A4DD646BEF2136E62337226832B44D03B99DC45065
      2413A388AB07D52DACAC1DEE1C572139BE37354DD47B7D36A19FBCEFDEC866C8
      66D2706F36A6C41AE5F85E00EAD8B181277EE6C4E0ADEBF785165BE7A0E59CFC
      E5D3C9D9BBF7271F2E0E4FB77EE07D3FF0A9772497CD660C14F29D28FCCA2724
      AC67EEA5A7EC1BC7CFF4021D91E01A5158533CA71A6FAC1838F89B0A6C087435
      82CE1393029261477E0DB9C4DAC8CB1DDEFD8AB6F11DA708E2EA9084257CB059
      684BB02729814A25841E01AB409BE2172A523676C3CE11772DA4238B132EC4DF
      299A633730F50ED434E610C7E0C7151907812322BDD2BC948FF8D27C6AD16E4D
      835AE3D58FB41A57EC2E16B4B9AE01604207047A8857E4D4F211C2B89A72513C
      2F4A22AA72E52FEEB80A35D7C3D8D9A52A24E280B1539692E6A37DE7E8BCC459
      E18C68E383DB1397C0CA7D9A26ACB3775C225120FDD31782D720AAC9AEB2C160
      12487CAB3959F9BC1CA7D26502C3A76D39D2A2A6F9B96C63561F4E9B9A080A26
      1BD5495B5F7B45C40C2D29606CBFC366C10A5C6B3D9125A6B1E57B73E3A712E9
      CA04AE12DAA8D529F00C2EE6E66F1A1BCBC9D44BBEFCD37767C7E29568950DA9
      2D9161A406A68A506D623157DBFF2189D8604B465F0DF5F41BCFEACDEC925268
      F9C84D2255260126BC4A93D0960B045A70582CD698987DCD9BEDC5550D99A39D
      1FC78282C09AC180B3946B6FE497D8C49FE82C31730E8FBE3F737E9136806DEF
      AFB44D4EA43AFE936281585AA1E7B8D37C77CE4593A0FDC709EB132EA0941B8C
      618AD71C38DF2512B03466F8445E69339408D488CB35B03B659D8C788AF6E742
      8CC591AA940088C5CFAB6BCBF06FD36C18EDD79039EB2537875893B80CAF4E68
      DF0B3063A6D98125E622FA4AB589E0DF481529270814C2180FE2F3CDC86A5AEB
      583552AD5E5CD5622FD60A14C02E568D4BF5C88492EA36D6BF968EFBA23486C9
      B5602AEC487F1BE7C5BBAAB923A7C52F9C33D6DBA579E24469438B9D2E3837C4
      56651AC14554A394CDDBDCA96625F119005C764ABA314EA5501AF63449EF90B3
      030C5218EF1B7369A4CD87447C76C4856FC32155984948865F0CAE158EAF00D3
      5CA9485898116BCAC2CAAD67F838CFD0DD9E9E2F73069F7ADBCFEF280E766E11
      6676BF7B7F7EB127DB8F762B632859E5B45EB5E4E9903276A5AB7C2A483769F6
      EE789F03D3629A34509C1D9AC426A3E5CEF4A518D5051C1E97760895D86D1697
      56396FE938516EDE8A972F152FDFF4A8F0291F685D54C3AEE624870B49D71F0F
      AABFA51953D65A186A984CEFCC914A252414B0EF4127E626A70D6F343968C4F6
      A311ACDAADCAFC329E6E1F6C719C9628CCA7DEB85670F9ECA9539C641413A2E3
      97325F04CA0E462BBB0E6CD83FB955AE093E289DE55CF204E727C899BF6AC871
      450C69AAA88B56F3664971A3028984EAC32ED3ECCED9F93E89E09C5130E57D1A
      39DF51C5D88E6D2C093F25D0066F926D9CE6CDFAF9336E59625B84629AD64C73
      A01C3E903D289C4D01D84B3DAD0497E8B3B11C9C82AF15E350949D9B9B478A02
      A679422245FAA57E52D32B2C7AD2C49AB943ACC6B446DCF9F9B398EAEB08AC77
      BCE398483E79CE1CD992643953104207D5C607E04E1CCD23CAF367E78B8188DD
      596EA0DC99CBF7AD2D3F4D9DFC3A99ECD389852915DD770E0EF64C614C58CD24
      E2B0E1CE791180D8D92F7EFB908EB59C5DEDBCA3F399A9538C60A779F4531165
      1DD0EC6792AC23050DB694D65602A5719C84740AC7C034356CA226C6E4398936
      A61CDA524386AC156FB39432282C1431CCD532F78A0B348AEE2E12894A32123A
      1474B5274DCA72E12E6771097DF7988DCC399AB1F58513F969CDA3208C3D9D11
      9ACFF456ABEBF2885253E64A928F8CA295ACA80A505838A48F8AE3B2E64D9C95
      6E5C704DB278745927E169E7CD2C1956C2CBD0C3729C4B92C5D9C54ECD9DBFCF
      E8B4423981244AE3B3C4008C418A875A70FBC99EDB3B700EB9C107475C8BEC9C
      08C28B7C41D846981705ACCDCB22E7CDDD0E736B51056882AA6523D5A224AE04
      38CACAFBA9A7539132D55C28A7F7A5F0A3F31335990CE9D4DBB471920C242A3A
      A9B1A2B49BC3240B672332A2C38606FB1783F95C659CA5B73660C6AE9C93536E
      669164CB21462A97A4F6789C9B551C89DDE6657120A7FADB189A40B572DAA880
      CA8DF4283D70CED322CF926C16ADF284E314B04BF3304B2690B904BF9DA6D70D
      141B74867847F50F97CEBB17375C787B99F201860A48C9FC795BF5F76541986D
      29D39220CCD36E5E357F664132584A61A34A7619244113A1E3DEDA935FAEC927
      DBEF13E5F4702EDB513A8E0C5E14375681028D78CE527DDDC4084C1160C99D5D
      762C44A8B1C81F2AA8D3A7D759AE96BF698FD32A8978F71D4B3106F7783125B7
      FB9520DE7086B7720EA63AF74859160D20B874A5C857C9691B4C285CB1DE871B
      9B869C2A37892A05C8A8B36B1C380B584BD90C13959B233C53DF5F00B9367041
      3E59233BE3DC786EC6552D1426DA4BA8B3A4AFE9D854863C2F6116D7D0B4AA0D
      299D0FDDEE007F93A5F2F5CE9DEE0BD979B21A72F6DCC160D0E9DBBEBAFFF8EF
      5FFFED574A28D2919A2AA7DBF28256A7E5B5BD56ABE5E3BFBE6446B9D0237A10
      E9561CC4716CB2A5C296CBFF76E4F76EE075FCD8D73DCFEFD2DFDDB8EBF506BD
      96DFED75BA91AB7B7D3FF243150EDA61E0E9B0D369B55BB8A8E7F5E3B0DFD15D
      37F2D4F367833070F1F2BEDBD583BE1BF6FA3AEC29B71786ADB03F18B85EDB0F
      07513F7055AFDBC5607A5E18B95DCF7355DF6DB57D3F74C368D0E9C4BD81EE04
      BAD37383A81DB77A4137EC0CFA8350F53CA5E2D8F55C17AFD1413BF07ADD4875
      A3B8D3F3E268A0A2E7CFBA7E7FD06FB755BBDF09FDB6EAB6E2413FF60215E820
      74FB9D5EBFD76F7978D840755DD5ED05DAC71C318EC0ED447D3D68F5DC763C68
      292F7263D5E9B7DC30E8747BBEEBF75B710472EA30C2D0DB51D8EEEB004F6977
      FABA130EBC4ED4D3DD5627F09F3F0B5AEDA8DBEF445AEB6E3C00193CED0E5A01
      C6D0893BBEA755E829AFD3EAF73B41276C0D40381DAA7E3CF0409BB68FB9E1D7
      60E0F6E2AEAB95E7E22DAA1D46DD41084AC583F62068E97E57FB5D2C4BBBD355
      FD48BBADD86D05FDB0ED869DA0F5FC1911BB1B87B10F9DDEC60BB41FC49D60A0
      FB030C3F88FCEEC00F8330C27C03B7AF7B61C7EFEA30C430DA71DCF6FC56DCED
      C4BADFEE449D30C430825E2CBC1213F7805F1EE233AC0668A07A78AC7CD88269
      D3E61F02C36971CF058F85BD8E1B83AFCCCF7D62A4D857C459187F4FC7FD6E10
      818CED5E047A63666D7015562256DD41CBEBD0F2F4222C48DBEDF762BFEFBAED
      20024768FCEDC5CF9F8558D6960A02D019E4D671DC53834E146BA5FB413CD0ED
      81A7893AFE4029D5F2C38E763D305E18F87DDDEEF99D08CC19838321AF94A77A
      6EB785E180795A7D1FEFC53B0262E0B0DB8ADAAA0332459D763B505DAF1FF89D
      D6A0DB76B10A71BF1F0D3CBACA55DA737D2F6A63855B918B0175A3A0E3F9AEEB
      F562D51BB47BED6E1CF5C0797D1A9A06CDB0333A71B7ED6363F53A3D4C45F763
      D50F07710CAE018DC270A0BD386CE3FED80D75D7C3A2F8D83203CF0B7D7CE563
      04AA8D7D15EB4EB71344E0E9BEDF552AF2DA3A6A05DD001C17F971246B536765
      FDA03718F86DBF6F24465F159284FF4072E00D90125D37969F9F3FABFE463F7B
      111EA0F15F0F72C5B552059309BDA885B57749AA604D7B916AF77A8316A40116
      23009B7A5D1F9B3E0C940E821823F33A83B0ADBC36E40B283A88C1D7D881BAD3
      EF747AA18EC0C7D832C1F367980F7EC04286AD5E2BEA2BBF0B91A3FB7D62EA1E
      E48DEA61DDFA91F2FAED100B15FAA1C633DBD8607AD0EBB741F1C0EB63A345B1
      37005B76BA181B440578109C1105DD28725B911F7421AABA6E5B632DA2A8ABB1
      7F3D300A441D46D0EBF6741FAB09E10D2EC397980816B4E576FA9BD0DFD3EDD8
      6B453DE66CFA2A68F30AB4FD55F4979F9F3F2B7FEBB42DCD75088912F769B7F8
      6D2FD0C4489DB8D58F2208B720F0B587B7054118B607BEC6F5830033F542CFD3
      9EEA6B1F7BC0C79AF57C8832ECCE1E242BE6E4D15671C336FE8D3AB8BC038918
      C5E003EC13EC32BC1C7B3806B9026C067FD0ED84D88C510BF776BA8301047AD8
      8B22A80017B2CEC5EE6B77215D758C670C20C3224895388CBCFEA0A7E2286CC5
      6AD0EBF63DAC398806EE1E0C7AAEEE0CB085BB0ADBB11D0C3A3E5616138C6937
      F614B6B0F2A170DA21B8A9E379DD41DF1B1037B990B6184E14B5E24E1CF4FB61
      CFEFF5A1273A7ED8C77A0F4842B794DF8E7AAD8E8E0217727A8037B442D5019D
      DC01C8D7EAC77A007183C180295DAD3BFEA0D76EE30A1F646D830F22D777237C
      A654D86DB7A047212B20B5BCBE4B726B00B1D1A6ED15B82DB02824171605DAAD
      A5E831D8E95E085116FABD4843BBF9411BD48402D12E5488E7411DF67BD80FD0
      E21878C7F76168F950BB7DDD8218EBE8A0E74237F655DB6DE95EDCF174D4F5BB
      60251D6A97F494EB4650ED7D68C828F65D05C13BE8F6C218F20AAA1E6A33C6EB
      C02F24366388DB0164A2C6461C445D180B5073A020EE0CC1EA58A6C85710152A
      A639B53A5E5B812114CC3E9858810A636C9B41AFD7E9285820E097B8ADC0D260
      A4012C08ECB18E1BC4DA258A845DE8ACB8EF93CA1E7858F2009F422DE830EEF5
      B086505C5E00C1ACE21E4C97163616CC05CC062B41EC137661BA609743474285
      F440D9012C147C0051E8F6FB83962605D2D7DD9E8AE27E88FDABFD41AB3520F9
      EE61FDC30E6E879C07538194FD6EDF8576EA839D020FCAC8078381B57DAC1704
      48D8D3D8FCD884DE00A480C27761E4C43E71110441B715763B5A4103B4FBCF9F
      B53B18498CE50461036CAFBEEA929D418B32D083CE00AAA08FC7C7DD1E38CA05
      C521BEA1FB20ADFB6EBB07E1406C8DBDD68E412510C927810F2EC6185AB41E6E
      CB8FBB3A06E520C340021D68689E3E56C3EB41F585CF9F754252CF50BE50FE91
      076686FCEAC34E53035FC55D28148C3DD6D86C4A0D62B0498C3D08D11AE366A8
      200F96611C6AEC941E98250AE89681EAB72168DD2EE9493C3486FFDA8FDB7809
      FFD6811D84BFA0B8A02CBAD80BD83CD0BB3045B111B0326E370AC1041136489B
      8C4050AAD5EF79A03B2430C61C4132432F80CF61DE417782081E746D18C21C68
      41A97771991FD0445B6DAF4D562BD819AA1532B305AB082A990CD208C382DD15
      4358810FFA21ECA1B00D4313CF86508100ED8710F47E3FE8C3E208B0DC30B230
      1698777D3036860F85DBEE424B449107DAC1ECF56012C42E360FA41864540BA6
      F10042A51BC60A46A00FE943165C5FC37CEC2B3C2874A198DAB0C5420FF2A01F
      B46097067D48E71E148CDB52B0725D5843A10BCD826B7CDC83E584AAC7E842CC
      5D7515AC836800D183C5776183B731B410F2B40DB9D787A6ECB6071DD24BAA0F
      E5D2F35C2F2221DAC71E8401DB017F8490D59844D419402692990B09E1F615DE
      0581DAA3077BA10BA3050A129F6223AAD6004B815507CF83BB7AA0D2A083B179
      B0DF3A7DB09AAB488882E920DF6068C1FCED467DAFA3B0E1A145A296C6959833
      84960B89050B14EA0EA6321435EC83764C0E030C274DFB99D99DB60E2C19FC07
      7EC798A12020F2225803AD1EACD3C88B30CEA8EF62677A835869324C3C48A76E
      17DE410055092B169CD1818DA81549331FC20ED61C0435CC3798E183565BE379
      B1D7C15E0085DA0A7A39C022C1768474C48F90C19070310430645917ECE075B1
      2B3DDA6AD00DD8339106C7877E1C76149631009F6BB703911543DF803B306C0C
      1EBB340AFC6ED0C1DE80C8D31A1BC6F5236CAD983C0F629A1823D0BA85DF6037
      43388BF485EC8680D65D4C02EA103A2B1EC4B08B30A05E8867B7216CDC00CFC3
      DEF194DFC39AB5A0F30630D74921C02884E86A05BAA57A701E3A7E1BD67B04CF
      077C03E185DD86E7C66EBB830DD0EAF9904858BB00D21A7C3C809AC1EA62DB76
      E84A5C0A518481E2897E0CF7175B47E16D7085B07E91D2031F121CBA77008F0E
      E2038E570CE72720AD0D8101830B1B10EA117CDB0DC869EAC13419B8981CAC50
      EC945ECB83FE86668A82016C1F10A7830DE4B542B29EB09920636121438D403A
      C193C18E875E8290072BB6603680F2787B008E8DBAB089885521722160E06591
      3749AE132C991E9CCB012CB93664BEEA62DE98C78034521085212CF35093D706
      5307068FEFB77CD5EE82456106407077C928854D049D0C1D0A01A0A0DBB1DFBB
      1D98E85DEC4F6C48B03FAC220C1986860F06F4BC960FEBB40BBD032F14C6763F
      C2C2C16FC4A75D28268879A872A853EC3568723CA6D3C5086278B1308E71253C
      BBBE829584198252201E860F5300045101C64677410CFAB0A17A781D1812B21E
      9A402B2C671B4A81BC811E76550831EDF9D8ACDA8FE37E0C7D033717BF419FC2
      A30175413D77D05130C423F21BC115B08D4216C830764065B88990991E4C5545
      7BD3EDD2EE09FBD8483E6C830E960AFA46C305C2DAE02BED634FC190835CEAF6
      A28E222109C70E1E4E8FD8460DF0D83ED40859D73DD8E36047C8DB1E9CF71ED9
      185805F268216A480362F7BB709815C604ADD1697B78AE86FDE10E20567D182B
      50E010C63072B0BDE19CC1A0EC63AD40E241ECF642383F1EF472BB3D885A203A
      B9BA5067180BCD5977A167215206DD108482A90172B7C216460029E20E608E62
      99DB5DAFE3C193878F8D25C2BAC026F34345361A7CB208FB1CB61E388DBC7388
      FC082A89E8EEC1B5839F31E874E00B04D077CA056BC13B819082700FDA2D182C
      D0F15D88A208EB10F4B0352842019279F0DA22B25E5A10CB83189E5117D20E23
      834C51ED00DE2AEC06920FAD2074612B796E002310DA2AEAF5602E4338C3E785
      C4C1920D288443D64AD083806C837DA169A0673832028F04F48727058F1093C3
      5A6220314D9CEC44BC120A047EA51FF561BBC25BF27035EC1B17460356C0F7E0
      D0B6439007321056326C885E0FF2031FF8587B983721BCD42EF8172E19143FD6
      05BB1CFA55D33061C7C10969F70621CF3F0AA08F28B0051A44A4E22270228470
      08690E970052021C8B9186ED16FC9DA01563E2EEA007D9DCD1E402921505ED16
      696C60981CB4D7E0F3C238F2075083E01DEC3F586C81EEC24D84D94A410722F7
      80585B437A63D9E03BD1A681DF13793402F00126E8433160C5548CB5804101B3
      07561A8430883F8894EAC61AA2A7A3F0E41EF617F9D5E02238F82039B48282CD
      E41385B1465D088E0072A9872D0A371E9F41C88087C10D983F2919B02518CA87
      980D6148C10686DF08BB061A16F7C1E4815AC20840C3BADE620B426BD01AD068
      C54B0FC4D3747B0F7B8B657406BA71ADE73E1FBF611F9EAC126C0CEC68B747E1
      92D887040914793CE0A7A8DFC745D83AE42869AF03C7901C24B8C56DF82211DC
      44F268FA30AF20CA200FF46000E33618F460030E609C6153451A82097B19DC00
      6D840B60DB0FE063404FF56175C20684230E0DD01F44830E544100D2F421007C
      C8571DB561C20CE0F0BA7D8F1C320FAE0FDED68119DEC3A673A1506182C34681
      55EEC5B091B0A1E0602A5853F0743CD7551D05331EBE5B104179C111C1AE856C
      A3B01CCC5DD8A9E0621F0B00FD0E2DD2C6F0BB7029286A0332C00EEB0F7CF027
      D424FC2F2C30CC558812988C24A314851F426C3318738A76BA17C263E9829DC0
      E1307B64E5E6561FBADD8DA8F675F388EF437FAAD16058692BE3C1EBC640D1C0
      876281CBFE745A72CD3C27969CB6EE9DEBE254CBFE60ABB80FED8A6A0C65F94E
      5837AA75D19B657FA0938A516115968C6B596467DD48D64986A523C1F67D883E
      D5986E7D99C123EDB64A0A74E5BFAE898A85614BD9AFFEF1FC191D7684E930CD
      F2908E3C4606A80B5E656C9E0C394D6FEA75205AC1BDF0A95CA20BDC3F175E31
      36B04F5CEDE15BB896F46D17EADE83D7D9E9D315F0F73D1E31FD1DD21340575C
      D51B10D7E35930EB61772A3A59801880ACEEC17D202F0636454BC680BDD2C177
      E4CFC101E879F85F0B1656EC5290A26328833D0FE728EEF198CC7DBE4F34A4EF
      3CF3AD4B92027E968BCF7A32669E250CB90E76095CC398AEF707B4437986B8A3
      236F86598399D39C3C9856F299E707F2195FE716D7B9C5756E711D7F8667D398
      F93CC83C63EE93F21AE64EFACCBD77D5FD2775EE5DD3B9778D77EF1AEFDE35DD
      7BD774EF5DE3DFBBC6E76BFAA03851349075B2BFF17758093FF4E6AF58F80CD7
      81170C4FD259F6789A4FEF863AFF759847F93419A9CF9D5E977E19A6E1B58E22
      1DB7F82B3D4AAEB802C17E321B13C807A52CDB4FFE2E597FF6D74996A45932BD
      C3EF83C17F978F947EDD4EE58EB653BDBEE594D7B69C0F8CC3FEE795570FE6AE
      BED27268DAFEF3F367F3C396BBCA41B7570F60F923DD3F7FE50776BEF603BDAF
      3FE9EED71EA3FFB51FD8FBFA93EE7FED310E6A3DD0DE95608B7DAECDC1F377D5
      63D2F97BEAF1E1FC3DDE23EEE93E6A46F51866FE9EDE23EEA9B7E8F3F70C6ACE
      C87247679E3DA6698865FEC207D45BF1071ED0F9F249D4E386071E504FCC3CF0
      00FFCB27518F691E78403D0E7AE0019B8909518CCEBB3141B66CB8B5E2349D8E
      D3A964336FF45635C67D069978D37B491CEA6CA35B68A0B8E53182C308DFC7CB
      F24E77EEA9A1E296E81B0D7FCAF50869ECC4C9E52CD3F98613D1E31B3D4C2705
      04E946EF2E6ECEF474966D36EE823F8A3289C73249F980CDA6CE89F452F9BFD1
      AB27EAF251F7C1AEFD8209DBBB794B6C36D18245D46C7A457C97E8CDD679A4C2
      2CDD8C2B53B5D1EEB0F79D26F9A6B3A35B9C37B3E1506F262AF8BE0F9B2F23DF
      B79911C4B7D4558273376D6604F12DF514DD12EA3D6652E6CE47CDCDDCFB8829
      9A3B1F315359EFC7CCD4DCF9A8999A7B1F3153736777B573DA9EF7652F92E970
      33C172344CA9326EC3799D27976345A8F41B5924F3CF38968C604EF4BFCCD4E4
      CA799B8E37DBC46FD2E8CEB9D8D44A28EE7A9C69C32B43CD1592F16C335ACFDD
      F9182E2CEEDDCCA39ABFB7AE13BFFCEECD76DD7BD364F3FBD2305BCEC60BEC35
      0BA61B73F2B91ACEC426D87082C76ABAD99B4A067ACB3028868DBEFC111BF2C4
      07B208BE377A76B33997EFDFEC95E57D9BB1E0E29E7BF46BCDED9B0AE237F4C3
      E6A2E2FB3B42374BC6D71BDDF53625B0471DCDDFBD94F15D779E87A7544E6FE6
      B6FC8679817F329A5CA93CD9CCA03B4EC31937DE78AF261BDDF8898A5D36A7E2
      C9CB11B5A72E95C6666BF7FDC5FB53E7229D900D4B587A9BAD20DDFC862A4747
      8FBADF38C1BB3FEB606FF3171FC2721EDF8D1E33E1C34778647CE351B2A13893
      BBD2E811771D1760F98F99E20FFA2E4855166DFEDE4FF0A278734CF523EE3E57
      5439B8F97D549B788B4DB871BC80EFFE496509B9628F7574F359F0371D6EB6F3
      3EA4E2536D72CF47297616BDBF699078EEE6CD64FCDCAD1B6A1742D74D2B9269
      450CEC825D6102395A31AD8AA00B35B50387F55D3C74B9E5B248EFF3890AADDF
      6B2FF2E785F629E3029C5F950E7271E1A2E94517162B585CE52EB9AA32ABE2BA
      CE82311625B3917DAF090C17D77A0F5DEBCE5FDB5D76ADE197B90BFD95172E3C
      B1B7EC429AD2E213FB2B2F7417673F58796967EE99BDF9D53956D9F57D9AF716
      DC263A6CA7C65ECB56B1E72EBFF6FE433BCB2FE4B5ACCB4050322129F3F6E2FC
      57F15279432DA65A71F9C3BCB5E2A687996CC54D0F70DBE2DC57EDE7337D93E4
      36B6BA3C16EB2D4C3FAF78A60FD86FF34CF65FB3D428DFE52F995FC677E3A91E
      E7BA72579D8DB372BD1FD8432B28FBC0665A71C7037B6AF91DAB36D78AAB1FDE
      65ABA6FED0865BF1A20776DE8AA9D7D8826E3D61BEE2F2751BF09E80ABB705DD
      C76CC1FA027FC51D3518F8DE7C6A30B0BB3103BB1B33B0BB1103BB8F61E0C5A9
      D76160776306763766E0CE660CDCD98C813B8F63E0CE6318B8B33103773666E0
      7BF3A9C1C09D8D19B8B33103D7336F565C5D8F8117A75E87813B1B3370676306
      F63663606F3306F61EC7C0DE6318D8DB9881BD8D19F8DE7C6A30B0B731037B1B
      33B0B711037B8F61E0C5A9D761606F6306F63666E0EE660CDCDD8C81BB8F63E0
      EE6318B8BB3103773766E07BF3A9C1C0DD8D19B8BB3103773762E0EE63187871
      EA7518B8BB3103773766607F3306F6376360FF710CEC3F8681FD8D19D8DF9881
      EFCDA70603FB1B33B0BF3103FB1B31B0FF18065E9C7A1D06F6376660FF81D0DD
      3C1DE8D071A8E74F5496FBFCF3F3B35E7C71E303A7379DFBE79C436AAC534D09
      5A7EA3BBF49D75EE9C27D29B34BDDE204DA078CA3C5FBE49826192726CE4EE4B
      D2A317E3B31F8F8AF3CCEA65DED263280EE6CE3BE99EBBF2C27967C8EBACBC70
      DEE8F4BC95172E9A105E77E5A5F362D49BDF4ECCAE721D0BBCF96BFD55D7B697
      5DDD5B75F5C2F4FBABAE5B98FD60D5758B93EFAE9C5397E5C5DC63BBED5517FB
      C52E9EBFC15D75436FF90D6BC9B63CC8F300FD56C59E1E20E58A77ACA6E9F21B
      D69176C55D3568BC6A4E75C8BD627275E9EE6E4AF7DA0CBC2AC65283EEEEA3E8
      EE3E9AEEEEC64CBE727275E9DED994EE9D4DE95E5B82AC8A25D4A57BE7D174EF
      3C9AEE9DC771FB3D55B19EEEDEA674F736A5BBF7286EBF27F837A0BBF768BA7B
      8FA37B77536E5FF4AA6AD0BDBB29DDBB8FA27BF7D1DCBE38A74DE8DE7D1CDDFD
      4DE9EE6FCAED8BDE430DBAFB8FA2BBFF68BAFB8FE6F67B939BA73B7B44B58DC0
      CAD50FEAD0CA750F8AF0CA750F4A90CA75C6047C5070542EAF6704566EA86704
      DE275B2D23B04ABF1537AC26E44AAB71354D6B1981F7885BCB085C4AE31577D6
      20F6CAC9D5A5FB8346E032BAD766E01537ACA7FAA2615597EE0F1A810FD2FD41
      23F041BABB8FE3F6457BAB06DD1F340297D1BDB604596192D5A4FA3DD37103BA
      3F68043E48F7078DC0D574F736E5F67B56E37ABA3F68042EA3FB66227CC55D1B
      50FD9EF9B801DD1F340257D3FD41237019DDBB9B72FB3DAB713DDD1F340257D2
      FD4123F041BA771FCDEDF7265797EE0F1A81CBE8FEA011B88CEEFEA6DCBE6858
      D5A5FB8346E083747FD0087C90EE9BE112BCC72D9BA7619F8F54367D6495C3F7
      2ABF9AAACD0A3C7F1C673A4F87D4ECC30EF81FDCA9819A34E453EA84D26A33D6
      514BF09D5AADB6C1677AFECC23B8774604EAB8AEEE76BC76B7DFED7B91177609
      35A9ED7B82A5D4F109D768E91F5F9E14B5C2B8DDD62DD50EDA6DA5DBABD19DE4
      4F87F08BF1C858C731A33DAD42A66A2FFCBBF005DD1F17A863F77F2F3EFF1DFF
      109AE6BFEE9FEDECFF75FF2C997D64FED5DF76247FC49FEDDAFFEBFED9CEFEE1
      3F5DD81A7E2CFFF53C313D3C5821BE96DF7BF8A0375867253CFE0F235D7657EB
      FD56E8AB68D0EF0FDCB81D1138B5DFC548BDD6C0EFB8DDB6EEAE7A6E003BE7F9
      33BFD78F08C435F25AED5516C753F9B392028FFCF3FCD9D71CDDB7F8F33529D0
      BCD9D39FAF458147CCDEFA1EE6CF3FFEF1FF0387EA21D8}
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
