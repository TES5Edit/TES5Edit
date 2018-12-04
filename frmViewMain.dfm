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
      789CECBD6B77DB469628FADD6BF93F6034F72C4BDD124380E02B333DE7D8B2DD
      F1193BCEB19C64E6865967814491440B04D800288A9D9BFF7EF7A3AA00908408
      EA49A5AB7BC52241A050B56BD77E3F7E1B24D9D81E78BE18875E34B19B4E7BE0
      456940FF8CE613DB693B83C588EF183707FC6F9AA5D3B13F1C4D5B76BBD9E6AF
      61CC5F3BFC751A94BE0E037A16DFD16AF66CF5792CE08DBD41361533A17FD3DF
      D67F1DA5CDDF06E338CAB261081F9A0318D60FACC13889675E34188FA65E928A
      0CAECF93BF3BBF0DFE34987B519C0AABE9C0FF3BCD56B3DD74E13F073EB9BF7F
      0D6622B5BE174BEB0B3EFE6FBFC3908E1E7216FB22591FD32E8FD98571FA3436
      8EE9C298E7F122094482A3FEDBEF2F5FC088AD8A493A9B9304503661C1F05F17
      268B83767FBF58CD86714873B3F3F5464178F3401BFFFBFDE7209AF8F05FCA63
      B915D3B25B9DEDD05B1BF3F71F3EC1601F831FF1BEB11766D6BFFC903A9F478B
      D7E277B5F2AA776CDD1FDC17DE1FDC270761E9CD8649E0599FBC6C4A936E75F5
      80E93248D39B071CD3A63834B41A300C60441ACB6DEDB5D3439855BF3C581CA5
      71E8A572B1AEBBCFDC861261F83F40C7DF2FC42416D68F1F7872EDBBEECEFF52
      DB43E38530C8DFE204200807F2BE4F0D2DDF1F16DE603F286EC1DBA641E16DCE
      7E48D1DA8E14D6C76032CDE46A86C5F1AB0EF01DA80CEC4710A9F1F73A257BEC
      47FE863B63538DFDC8DFD6B9A743AA76221FB97BFF3BE176AAC873ABC7A35A6B
      8F59E7EFF8C9AAD938B8A3DB9F5C258A5AF4ABB6A463573CFCD744884B7A73BB
      EA04DB1DA7E2E1AF8B841FAD3C9ADD6EC5A3C7DF8961229627FCBC53F97C15B8
      8E5F27DE30189DC895B7AB8E93DDEB548CF006302E18F1FB2BD956A755F5FE9F
      0291451E5C14BC864EA78AF2AB3DB7AD021B57FBDDE9563E26377CED31BDD99D
      7ED5936AB7CB4FE63BDD6D563FE96C79526D73D7AE7C4EEE73F9B9D21E772B65
      20B5C96B0F9737B85BC958D50E971F2FEC6ED7AD5E6E6BDB9BD7B7D6EEF56E26
      1196A264D6CF22CDE00D5514ADD5DB4D188AF20961094B3DBDDD84A1FCE42A91
      AFDC4D144A0FE678D2EAEF2609A54715A2B4FABB8F63E941B55BBCD4FEEEE358
      7A7A63C35CBB8A5B14C1CC0C5AD15DBB4A0A2CC2573E2241EBDAFD8A678AA0E5
      672454994C3BCDCAE79CB5E714485DC7AE7A46D358F54CE9DCB94E9524931357
      FDA03E73F460ABEAC1C226F283A5FD739D2AA1B5B87FF28D1B5BD7AD45475948
      CE99662D2AAA1E52DBD7AD4541E553A50DECD5A2A0F249BD85BD5A344C3E5520
      606EAF1605930F6E82B4B7FB34283D2127386E6FF781C89F5220EDED3E11FAA1
      9CD0B8FDDD07423FA6C1D9DF7D22F443F9919082D2EE43913F5B3A15FDDDA742
      3F59DCC3FEEE4391BF71630BFBBB38D0FF5A674172A5251DAD6A909D52696994
      2A7EB243425D1BC6AE941977C9AA1BEBB22BC5C79D926B69984AA6554F8A2D8D
      55C9C2EA4AB4A5D12A55AD3AD26D69A42AF9630F49B7A8943B3BD4FE7A92112D
      B8A87D3BBDDAFC9B146C85A7A531AA48D126439763482C2D0ED2AAA4311B1C9E
      0729E26869A04A82B3C1F2792085A1A5412A69CF860CC08394F0B334522535DA
      100AE44865EC2C8DD5AE2D27F05805DC2C8D53C5A636C50639A775CC2C1A585A
      B723761B869AD6EDC95D7118F7D6E46E7DA05B12BB8D85B9772477A5B1EE42EE
      D6C7BA3DB1DB5CE33D90BBA255CDBD0B07CD47B9254A29BEA007AAB6BBD440AA
      D24077E2A0F9307741A9CDD5DD11A94A63DD9583E623DD15A5360CA99D7BE1A1
      6BF6D24E7D0E9AF3CEFCE9FABC33C7CCE200DDFA7C33C7C8D200F5F9658153E6
      8FD7E7946B18581AA53E972C615E698CFADCB1CC17F311EAF3C52D9856347577
      6F4DBE4AA3DC8923EA617A7753004A43DD9E7C9586B93B47CCC7BAB302501AED
      4EE4AB34D25DC9170C388AC338C986E1BF0D12E1370713D895A83918860BD1DC
      BCE4B4DBC58BF0F5A6CBCD7F7BF9022FE3F72D83AC5D6E962FE6836CBDBCF64A
      1EC2767AC58BF0F5A6CB3C327EDB32C4DAE5B57B2B8628BE90976EF71DF9137C
      A09FFA4E2D483771B3FF842110A3E91C8985E30C307A62E049071AC64EE82F18
      6621BFB42DF5E0DC8307FF1E5A8330680E12F82FF56C604F69E8B4FBF0EF6C11
      66F66019F8A32C9C7BC96099787378CA83CB032F9D7BE17CEAE18768310306E5
      2DB278E0F97F5BA45982F23A0C08330DF19F20F3E64D0BF07C10C57F07AC8B67
      7126ACDF0669B60A453A1522FBEDF1A63148B21060311EA5B6051069C27F083A
      4F05AEC034B2846F685A306506AC8A2A29049410B077C17A309A24814F8F45F3
      C208D11CC7B0066924AE339854FAF7719CCCBC0C3ECD93204E826CD5B4BEC74B
      18B601D348ED32888676930085FF0E71D1367CE3BF7B812A5E64001C118A2B11
      36F700DC50C10E84E44AD80D07F4FB36E85D826403720E68810CC7A68261733F
      F80DBD54F871D494A084A9A530E74BBBBD15A67D0B912E4903DFB6DD5EBBDFB2
      ADA9F030A2C5B2259C9D8787B37D1B3803A46E843342B2124BEF09BA8E826E67
      5FE83A12BAAD8787AE731BE83ADD9BA10BBF3F38745B0ABADD7DA1DB625E006B
      82B13CDF0FB2E04AC0EDA99805D3C0F745045F16117C140B78656150DB7ACB90
      B57EF0126F02909E5AEFE328A30161ED596ADBF04F122FFD41968CB3F4E7C0CF
      A66F5AF0650E2F0AED664F7E4CF28FE350FD3ECEF4A7A1FE94E0A7D170EE0159
      870F63FE3084A50387E3BFD96A2EE0AEF44A24194836F06998F889FA1BCABF43
      F937917FFD49A83FA96B53F9F76A27A783D53E0D93790C1663DB37A0C3CB17CC
      69ACAFDE30141A97DA455CAA22FEE5950C299E1269BEA6EF399E23723282E3DF
      787459C2C42DE8FD9D22CDD63948AD7A5E9DDDF3C2D76E99175C4622B43E1F67
      CFF938E5F97477CFC7E96E9D0F5EDE984D6BCFD9B4D46C484AE83D0C81DD1BD9
      DD1B90DDBD775A5AD8552D09F44AB2D406F866691C29F98AF7B15FB98FE36679
      0D8B70301A3B6B7B574D6CD7370E885B823BADDEEC34F77BB3ED6CA071ED97BF
      8FC3305E0ABF3489D47920E9F2DED08605F1FB479C4D11E72642B9014D49378F
      7F16C313BD9B4EF56E3AB4C8B53DC57871BC78EB3DFDEEEBA78FD679EC6BD2ED
      B42AA7106CE254B086C89BA287B3E5FCBC9BC176A741CAF8E396F047E3084A10
      D77DBB03FFDABD96037F9C2E3087ECBAD5E9B8F0C76DF780E55FB7DD3EDED271
      6DBCA5DBC270FDEB9EE3BAFC34DE02A8D8A5619AFD3EDE64DB7D9437AE419376
      F036BBD575E93EB7D3EEDC336ACA5DBB11359B37A0A6A350D3B91B6ABA8A5FB5
      F7C68E1F12C1BB9A095F63493583DF0F51694E6E916D9526B76B3E256EEA5473
      F775BC2DCDE1064A3F0FCF72525BCDACD7865F5FE4CD2F18E917F46E9606D6E4
      80DD47CFD97CDF4596C4D1848C737F02B44DB30CE5B6DFE8237F17B379E86502
      9E69766D0C5E6E3AFC33694803FA371A8F9C96FE18A9CF7F1B3561E9F2231E0B
      FC3426AE21BFA499075239C8ECFC6DEE8D84FC0524771165CDDFF85B06383B78
      D5B4078BB356DF6E59FF1361C4EF5BCC862201D241992D298715788462C159AB
      8367B10B17FF36928B43A2E0D009853F68BEAABD949A0BB982C946F011364D2D
      7EF7BAE26DEB712AD663BB6E7941740146C6BF0FBCA43A0B8265ABAD72FADBB7
      CA6E56ACCD41125D5C1B5D8097E0DF0358DB8E952101AF5E5BAFB7B636BC806B
      83BF87BFB61B5606FFE2492FAE0D2FE1DAF0EFB35E9BDB5A231F74015E817F2D
      F2B83CDBB561364A696D74015E817FEBEC5A4EDE0F6F6DDD354A4217706DDDFB
      A1249ABA3FFEDA3AEE1A25A10BF00AFCABD6868E370B86C1CFC0BD9D66B3D569
      FDBE95B5B73BAED3EFBBCDA6E1EC86B31BCE6E38BBE1EC86B31FEEDA0C672F72
      F65EB7D5ECF5FABDEDACDDE975DD6ED7691BD66E58BB61ED86B51BD66E58BB61
      EDCF84B523FDEC75FACD0ADE7E86F1F65DDBED776B70F7FD77FD0FC2DD71E1B7
      D8E4E7CFDD89CADD1D6F0F9DBBDF497279DEDCFD46C98598F91F96BBAF492E65
      FEFE8CD7B683BB3F6FC9E5AEDCFD802597DB7077A7D9EC77DA6E773B77C7AA8B
      0E86A0B80FB1E9CF89B9AB6DBFBF3D7E36CCBDBE35C23077C3DC0D733FECB519
      E6FE4FC4DCDBC8BF5B15AA7BABDDEE386DB7D92BC04501C0F076C3DB0D6F37BC
      DDF0F6E7B436C3DBFF69787BCB6EF59A4EA7DBAF50DC7B76BBEF74FAB651DC0D
      7337CCDD3077C3DC0D733FE0B519E65E62EE4EBBEF3AAEEB6E67EEFDBE63BBE8
      92378ABBE1ED86B71BDE6E78BBE1ED87BB36C3DB4BBCBDD3EDF49A9D6E7B3B6F
      EFBA9D6EB7DB6C3B86B71BDE6E78BBE1ED86B71BDE7EB86B33BCBDC4DBBB4DC7
      E93B4E056F3FB37B8EEDB4FAAD4ECF58E50D7737DCDD7077C3DD0D773FDCB519
      EE5EE2EEFDAEE3B67A4E65269C6D8366DFED3A1DC3DD0D7737DCDD7077C3DD0D
      773FDCB519EE5EE4EEAED373BBED7EBFC2E77ED66F77FA4EB7DB760C7337CCDD
      3077C3DC0D7337CCFD70D766987B89B9C3934EBBE574AA02EA5AAD7EAFDFEB18
      A7FB3D2CE5D9B0F3E282D4CA0D3B37ECDCB0F3E7B836C3CEFF79D8B9DB6CB976
      DF752A92DF5A76B7DD76DA6D93FC667475A3AB1BE66E98BB61EE07BC36C3DC4B
      CCBDDD713A1D2034158678B7D3EF75BBBD9631C41BE66E98BB61EE86B91BE67E
      C06B33CCBDC4DC3B6EBBD7757B159AFB19F63F6EB77A1D5370D67077C3DD0D77
      37DCDD70F7435E9BE1EE45EEDE6EB6BBCDB6DBB52BB83BB0F67ED3758D9BDDF0
      76C3DB0D6F37BCDDF0F6035E9BE1ED25DE6EB75ACDA6ED56F176BBEF749ABD56
      B3D5349ABBE1EE86BB1BEE6EB8BBE1EE87BB36C3DDCBDCBDDDEC76FACD0ABB7C
      A7D76CB7BB6DDB549C35BCDDF076C3DB0D6F37BCFD80D766787B89B7BBB6D36B
      D9DDAA803A1B6EE8F55BB66D3477C3DD0D7737DCDD7077C3DD0F786D86BB17B9
      7BA709DCBBD76D5671F7BE63F75B4DC7D4AD31CCDD3077C3DC0D7337CCFD90D7
      66987B89B9B71CBB6BBB9D0AA77BABDB71DBAD568555BE99C3A5B92F506AC1C1
      81FF9A8D75182080600149168EA683F128B5AD813706388459C217EEC2E577AC
      E9DE793C2ED1BEDB126FC1F86FBF730880DBADD2B9DB2A6F2102DC053F6F53C5
      0757D9BAE32AF717061E6095378A39B84AF76EABBC8558F088AB946B6C6FAC91
      A5BCDAAB2479603F01E1F157D9A9BB9388F9DB56B94358388C5576EF86AF281B
      AC097BBBC586C75F65EF6EABDC213E28B16F4D8040D37ED36D57D4ACEFB67BED
      4EBF6F3BDB2074C8A681B5EDBEB371E0BE25C407320DDC5BCCC5A309BDF7671A
      C825FB8359DBE39A066E27DBDD726D87621A7888BA8CB7E0FCCFC65C750B7E7F
      4894E44673D59D8D03074B259185AFB1B41AC6814EBFED749BDD56955FDF755D
      C7069EF80C983BEEFB8359FE0F99B93F6B6BDD9D99FB015BEB1E9CB96BA7CCE3
      AFED2999FB43FBA20C733F584A6298FB1ECCBDDF761DB7DBAE68256B3B6EB363
      F7DBCF427337CCFD39A2AD61EE86B91BE66E98BB61EEF7CEDCBBB663DBBD5665
      CC9EDD6B3A9DA6DB6FF70C7737DCDD7077C3DD0D773F000262B8BBE1EE75B87B
      ABE9387DA7AA4F3CD0D7B6E38204D031CCDD3077C3DC0D7337CCFD00088861EE
      86B9D761EEEDA6DD6E39765501FB56ABD7ED74DA4DE37437CCDD3077C3DC0D73
      3F04026298BB61EE75987BA7DF6B63A7F80AE6DE0574763B1DDB3077C3DC0D73
      37CCDD30F743202086B91BE65E87B977DB4EDBED763BDB997BBFED76EC9EE3BA
      86B7DF792926FBCD64BFDD37EE99EC37C3CE0D3B37EC5CB1F35EDB811F816957
      78D99B76D76EB7BB263EFE9EB7D8A8EA465537AABA51D50D6F37BCFDC1787B0F
      FBC0F75B1599EDA0A6775A6ECF04D019DE6E78BBE1ED86B71F040131BCDDF0F6
      1ABCBD0FBF346DDBE956E5BEB5DB9D66BBDD778CE66EB8BBE1EE86BB1BEE7E08
      04C47077C3DD6B7077BBD9EC747BB0F4CA36F14EB76DB7FBA0BE1BF66ED8BB61
      EF86BD1BF67E0004C4B077C3DE6BB177A7E3BA6EABB22C5DAFD76EF5DAB68990
      37DCDD7077C3DD0D773F080262B8BBE1EEB5B87BB7D5EE765BAD8A98BA33BBED
      38ADAEDB6A992079C3DE0D7B37ECDDB0F743202086BD1BF65E8BBDF7BB76ABD7
      E9B9DBD9BBDBEFD89D6EBF677477C3DC0D7337CCDD30F743202086B91BE65E87
      B9DB8EEB7431EBADCA32DFEFB8CD56D7348C31DCDD7077C3DD0D773F080262B8
      BBE1EEB5B8BBDB741DA7D9ABA8297F66031D729BA0DB1BE5DDB077C3DE0D7B37
      ECFD10088861EF86BDD761EF8EED345B2DB753D532C6E9B45BCDBE497837CCDD
      3077C3DC0D733F08026298BB61EEB5987BDFE975EC66B75277B7DD4EBFDD05AE
      68D8FB9D97624ACF9AD2B3F78D7BA6F4ACE1E886A31B8EAE397A0BB865BFD9EE
      5604D29DD9DD4EBB6DF7DA465FBFE74D36FABAD1D78DBE6EF475C3DD0D777F38
      EEDEEEF4FBDDAEDBACE0EE0EB0F61E28F52609CE7077C3DD0D7737DCFD100888
      E1EE86BBD7E1EE6EABD9E9B8ED5E6581BA66AFD3EC341DC3DE0D7B37ECDDB077
      C3DE0F828018F66ED87B2DF6DEEBB47A3DBB55555EDE69B75AADAED333A679C3
      DD0D7737DCDD70F743202086BB1BEE5E87BBB7DB9D7EA7D7752B43E93A9D7EB7
      69F75CC3DE0D7B37ECDDB077C3DE0F818018F66ED87B1DF6DEB53BBD66AFDFAB
      EAE9DEED74BAAE63BB2650DE7077C3DD0D7737DCFD100888E1EE86BBD7E2EEDD
      261AE6DD7E85F2EE76BA58C1AE633AC319EE6EB8BBE1EE86BB1F020131DCDD70
      F77ADCDD6EBA6EDF71AA1CEFB6EDF43BAEDD3605680D7B37ECDDB077C3DE0F81
      8018F66ED87B2DF6DEEF775AFD5EBF2229CEEEC2A3A0BA9BA8F97B588AA96163
      6AD8DC37EE991A3686A11B866E18BA66E8BD66CF75FADD6E4527F7B3B6DD72BA
      9DAEB1C6DFF7261B75DDA8EB465D37EABAE1EE86BB3F1C77B79DAEDBED35ABAC
      F17DDB713BAEDD35917486BB1BEE6EB8BBE1EE8740400C7737DCBD1677EFB45B
      1DBB531D27DFECB59A705C8DABDD7077C3DD0D7737DCFD100888E1EE86BBD7E3
      EEFD7EDBB5ED0AEE7EE6349B5DB7EFF64D7979C3DE0D7B37ECDDB0F783202086
      BD1BF65E87BDF7BBCD66AFDDAEAC50D772D1786F02E90C7337CCDD3077C3DC0F
      828018E66E987B0DE6EE34DB0E06CA375B15CCDD769B761BF8BF637477C3DE0D
      7B37ECDDB0F743202086BD1BF65E8BBD777ACD4EB7ED54B1776087EDBE6DB70C
      7737DCDD7077C3DD0D773F040262B8BBE1EEF5B87BDF6E761CDBFD1D7EFF135D
      8DAF449204BE803142F15BE9927CCA85373AED96D329FD388A17B0964198AA36
      736B4F75FA6DD771BBEDF6F6A79CED4FB9D8B8AEEBF69CED4FB5346B5B7BAEDB
      6EDA3045BBE23977FBDBF22482ED8FB52B1ED39580B63FD6D9FE582E5B6D7FAC
      5BF136DDCF0FA9DCB6077B15B0747A00FF7EDFDDFE54BFE275B6E3629142BB5B
      B1DDCDEDCFF5BAAD66AFD7EF553C55812579BF838AE79CAA1DB79BDD56BBDB6D
      B5AAD0B2B5FD8DDD4EBFD74684AE78AC0A55746DC78AE72A70253F7215CF5520
      4BC7B57BFD26EC7AD5A6DB55E8D202F1B8DF6C77AB5E58812D79504EC57355F8
      E2349BAD4E054A3B15C862379D8EEBBAAD4AEA60576EBB2ED351F1640561C92B
      6F573C57812EBD36CCB4D776AB1EAB4217DDA5ABE2B90A7469C3C635DB6EB7F2
      AC3B15F8623B7DA7D781435171909C0A746961023452A58AC7AAB005486DB3D5
      723B55AFABC0164030A7D7B2BB15BBD76A56ED7BABDB74608955C7B655415F5A
      4EBB0F6CC8AD380CAD2A6C69F6BB76ABD7E9553D57812D7DAC110314B462D75B
      15D8D269C269EF759BCDAA5D6F557122ED6AAF78AE025BBAC08500CBBA1558DD
      AA4016D4C0804C342B36BD55812C5DC016BBD76A566D7ABF6AD31DA02DFD0E4C
      B482AB575097B6DD6E0299AFE2EA6E05AE00723501CB5A15AB73AB7045E72A54
      3C57812B1D90909C2E70B1AA4D772BA51655D8A0E2B94A56A45C3715CF55208B
      EB365BAE0DC7A8E2B12A46D404B2D20339DBAE78AE57B5ED1D10E4BAB6DBA97A
      B08A13B5409600B0B81578D6AE4097169C74E047DD0ACEDEAE40179077882255
      A04BBB025DDAC0A08146B89514BE5D812FB6ED365D3811BDAA1756A04BABDF75
      DC56AF729E15D8E2B63B4EA7C3E6896D8F55200BF03CA7E7F45B1538D6EEB2E6
      9188AB6C185ABFFD185D46F132FAB7DF0917FE34984FE6741D3F0C02F8A73908
      326F8E93680E12F82F1DC27F1EEEA4BAA3B5F38EDD63D81577F05CD3C0C749D1
      874EAFD5B23B5DFADC85E3D40772819F6D60DCFD1E6804F405D87FBBDFB2F94B
      0BE8834D947836F3B2E90F09FF7D1F4759CB1DCC86C9E59B2042D22F3F5E2CE0
      EDB374E685E1FBC403D573E607E9FCAD18DB8359F8C94B2670F76096E84FBE18
      FFEF11FCB64CBCF9075231C91A380BA2EC6330830F9197ACE013E271108DE3DF
      06DE229BC689F52E847BD24C24AF7F849FE2B948BC0C2E7F85DFE06A64BD8B26
      A148E0A7512240A59D0D5689D3B47B83590C7A96BFB207D3A485AF717064DCD1
      8D5B5CB8C5A1A9900200D890067184082E7C7C379380281ECFBD89E023035F96
      71E283FCDEEEDBFC7D34F59214CE35557251DF9729F0A15E9B478DFA2DDEABEB
      59082B220CA28FB635CDB2F9B7DF7C938EA662E6A58D59304AE2341E678D513C
      FB261E8F8391F8065FF80DCAB1F46916FEFEFB60EE0138963648D21DFE3C050A
      0F7B3D03A8870C5FF894E84F99FE34A44F93450680058CCA92548C32B4452F03
      3F5E8EB2241C8CB368F8B7812722DF8F47830C36F9720647256DF2E7719C0082
      644134B1077E1CC599980D859FAED231A00C209508577174350B9B855F41EF9F
      F85EE6C19B93318C2AAE000F60C02B2F0CE0BA0068D883741A2FE7A13712D338
      F4D1FE00276312C5899805D7C21FC1E8689F00CCBF1241444F5EE35BF031F800
      471910C3861DB80E617AF14A44B02A713D4FA74916C1E5052C364CE7A3811FC1
      1644E9D01FC255B280C09216B06E58583AF58058008AFD03D7EE4F6684C6F061
      4A37027383CF5785CF706B3061CB36FE52FA36C5A9D9F4007E408308CCC78BFC
      C15520969741E4DBF4291D79210CD786033F4CFC642A3C5F7E1CC7713648E7E1
      2A5B464124706BF4E76936839392CE61116134CD3CFF6FB0ACC122156136F4C2
      6800FFC10578C9001E81378CE0DB92BEC087249B24833082230D2B1730047C5A
      2648DD0669E4CDB3780284318846220C61A0305E8E0311C2E1F561F801DC385F
      4423B4EB7969E0E951909E2430634D6022B18411D36C053FA7F09249122F61CE
      F138C870A211023C5B01DC911AC3EF30D908C84C960EC60227274271059747D7
      E99C0C4040207CD8C3255E17B8A7DE7804070A67ED8DE9E605E0653898D21D08
      B80CC8A797C09DD9E8CA235865305B7C689C2040F0C295975D0FAF079749344F
      D24864839107C711102E04385A8839019CC6B9975930ADACC9AC6009883C9E65
      E320848364392EB06F3CFC40891689C8A6499C65B0A783201CC7336FE465A330
      5ACCDB5D3C7130216B80C7CEB7D40104D21E89EBE600B75E242B50E607B8F5F2
      23CC24BDC60F00FF682A12414FE323B84B6871A3D1C4D8031C1FC10ED209B688
      6345F0537805A76B1E2D46C90C2FA03910BFB3C10F5D4DF368EA4513E46B5176
      9D795683C9957AD8818DC6C761B2B77ABE059F80CBDEEA59173E85F5DF7C527E
      BA5DFFCD43EBF8F7AA613A0480DAD3B869A82E0D546F236E1AA7775F13EAD799
      10E2FCD69180FB2440AC422F882C89DB83BFC3A1C9451510B48164D3BF433CFB
      40E73DFE0B1C07B0189F40D940A22F5094B917CEA71E7E8816B3C198EE1EC40B
      4278B240370740EC166906B4769AC16B22322C2B390A06F48A920D484659389A
      0EC623E0B74027E0E9710AA29017C2CAECA6D3A689F30DEC95C55FF1C756B367
      D387B180FB40428DE12E6FDC0205AE339806852FFE507F690F46782AE9B9685E
      18229AE320B025A5E90CD58CDC5E691E83E160ECBA03BC3E00B04C0797204700
      176D758008A6C5F50D50E028CA75969A1B3C5F9A18CD1FAE5A3F4FBDEC556A01
      79B660DFAEDFF94166B51AADC6EFBFC1F2EF797ABB6743F2D913BF1459D9936C
      85F5E6DDD7D7FF13E90B70053E4E8F7790ECFD0E52D53621BCB7C10B0042F0DA
      092558FE2E38BD594CC62006A68F08A9BBC0465219B70C18068BE3DE0B44BE4E
      85C57E3EC0452B11F338C9846F0569BA10A9350529D91A0AD093106CFEB7126E
      AC1593732FA7DC5A28595BC2DAE465F8CA6E9C5774B23C715ACFB8650D5E0DBB
      0310E77EDFB287A58098DA9BB9E669C4676B6C6F986E477F7CFC713679E7161F
      EB5D8D230BD4EC11E87F27D699B549BB6E3B156917D83D951F53C4B20C706E16
      83E86E2DA7428456165B23141004FD928E92609E59202C0FE3617C8DBC052FBF
      9E8302635DF08FEF41E6B7FC183014246F2B8C3D9FEE015604F7807201822C2C
      97475AE70B5B17890CBB6299D62320BD66387591FE9E70A836A37BF9A20A8B46
      89974EAD7112CF2C6F341229EDB0670150B20074BE15EC5F809F827FC0A389C0
      C74EAD9107BBEF5BC315DE09FA083E3307706616E9F44072F08AB816A30551A3
      31DC17C6136B06E37B8027416A79BE0FBFF88B4461947E8F970530C5784C57F9
      8D68674044F270BA3B179B4EEF7A340CCEDC883347BFBC1562FEAB751ECF0103
      52EBF8B3B4A1FE7FDF8330F985B6ECE408B024B216A04424D64824192A07A320
      192D40DBF722C0340B2DAF611C5F5A693C038AE2A1992F855D071D3B12F052A0
      2B432111053E233A806E32111970B310F9DA384E98E68C70226C1C04DCB91BA4
      AC7F2A31AC8E8CF19EED1969A5847E1FA2DFC11DB77F56B9640FFA70F445A470
      1A3FC57E300EE0901EBF89432010402C2E40F03CB23ECF89944F814490104A47
      F9799ECE9AD6062549D5D4656131BBD54AE5B5B94F0DFFDE54EDDAA223C564DD
      9FAE7D7BA03C075D7B171AD525B895507AC6BA76056C6A9291BB40E4A975ED6A
      9CFFC3F1B407DAE4C7D7B537A6F210BAF6CEB1EE51195FB70DEF07870790F4AA
      21FCB08AD5ED77B65AB19AC1E909CE18E64C63F097546D5BE45D0513568FB344
      08F41A9F5A5E44FB1559F96378C46064A194E87902F7021285F976CA9177734B
      8D188B39FAE8693C7CB185A0BBAD69C660431D6CF0C6E855F6F0ACB25186CFE0
      69690FD096926F8F6F2D836C0A1247011B3C18733C16091A6678DB814325693D
      C39AD9BBDBED5D0A479560DF406E174D52B659E8D394088CA691E45DAA4FE3D0
      9B8080915881D99BFBDE9B1A846EFDE0F1169E6AEA29196F8A3C589E238ED4A0
      8D4BC9DC9566410854761A2FD12EA676F6BED6BE662E39501D58CDF23E756015
      4B747F3A70FF39E881BB4059570FAC04DF33D6032B6053F36CDD05224FAD0756
      1F863F9C1EF8409B7C1711DD8B165E688D42E1218D4211FBADB78C260B806843
      A433C9D953CB05F29F082DC26753F486904EF7F74530BAE4110E1039EE001B0C
      D9554AEB6891A420CAF8F132B22EC50AD5D70820425211D0C01986FE92B06A61
      B8F19FE5ED52D1D1C22DF2D444A4804CF81347F73E47986D87580D5017244912
      2049439CC3872C988954F9C046614C98C5EC0D100B117043EA70E8D0ACC3C2AD
      0D0C35DBD6D6D9B668820D0CCC6EA02A8213BCB58278FB934BB340C04C03508C
      253E61D439926C10D69E23F6549F387291231185A39562D045B898451BA748AA
      885EB8F456299EA7E01F1848FD4C41318E1711C51EF82849A1D71721710E54C4
      FAB3751E226D0520FD848BFF8EE573AD7501D8120C9A5E311094F31881962A63
      093D283500A04FA3295134763F8F7074DE04A6EB467CDCB5616FD526E9E00F69
      A930F264519EF437C0A4BDA6698813475B6C96086F8648E093D52F40C5660C62
      A815CCE609081D7EC33AFE0A72C6656AFDD59B899D2F4E7E8845F62F27469DBC
      BB3AD933EA643D643F97DE8BD8FA3F2406FFF21A16F32BD0ED5C1A3624C17A0D
      AA02D002CDF529288A9992D63C4A6AC72945EC692696C60BD051BC2089AC659C
      843EE5AA011F042E6885316C40C28E1E29294C805A34800E81A080A1799105A2
      12EBB3F46640782F04DAE3AFD01896A221191E6C359C864D840888CF10048A15
      89A3355878221A72AB6BDCFC3546451AE6419383299DCA634752CD1214B2E492
      04E430B42649BC98A734A719C69B29E5AB608B5322B314AB492D61B56C131F25
      48E07E0C570340A522D75D383A0D84CCE02AF017142A89B2AF7F6A51C22A0017
      F62205CA0C3F2C93804CF1689847780F57190C484197F895F30541AB2409BA2E
      68686E3398660D2F0EE14F7199B43ED0BF00680844D8417F011852F4159C7F39
      2F6AAD34D1D0570AF04C64D3D8B78EC5F51C84A200F993F654C87C38DC86C2CF
      C0DC30B9126FF8F1ED17FA555AC13F7CFD74D2305CE8EE5CA8EB193664AC9AC6
      AAF934564DE7F95A355FFFA442F11341E41F78C170119039CF10E67B20CC862E
      1BBA6CE8F2D3D0E5D633A6CBBE4F310817F0237D40A9F95C69809F64CA0C7A49
      42D4384027215337DA39171C7C7FFC03FC027ACB682A40EC47250934A145B873
      4E805B4BAC3261ADE205C8FCBE28863FA85C1DF2DF207DEBFCCBBF683BD221E1
      DE1D402F493966347DFD7C9EDB90659E1AAA7B18E6919B94A52E5D788E6CEFAC
      90E3104B50434331CE305329CA83F2562A84CF3A7A1B47AF32193E3241057611
      65412821EF1FF126521C67CA9F855F786D8DC5AA9951CC27A884A0F74D126F66
      51D1873FD6FE5D5CBC23F6BBC5F88FB5AA426F65FDC4B59EACF338CA9238B43E
      44E3D8B229044B590E08C3115AEA5ED7354CBC6EC2D80122D4933323F7F099D1
      D139F10A3C06EFC8E37EA46C4457814FBE55AC1BC6B443A4189DCCD5C0E07818
      2BCE3D280B1DA32CD4148DD18B8D66D6732E0B47A6DA0203364A445189F8BAF3
      2E9051868B2C8B75044116CF5962016618C19197DE8582884382C4B117A6319B
      D2FD784D28D13294373C214175282C2A1E006224093AB06353202B96B7B99D9A
      9A3C7624CBDB788153A160825B06EFDE218225C6156FE4D93CF49ADF01CC9347
      5FECCB170A574842A6E8E911C86221BBB154BA8A0CB40E22C01A0C6BA9ED24F9
      39F041808B73219C4A4FE059256403F16EE71053CCBC98870132BDDAEFBDC830
      59E6F82A480342EA0445D01392F4975BA6449E23E91249B338C1440E3C4E780B
      1D313C2A292B054FC5639F1163304127B538423A17235065411FF2B03A0BFB97
      292545428DDC86A8B68AEB51B848832BA122A1422FCD484CC9E354D899E7EFE1
      BF14EACD285EE2385E5105AE433B584B46AEEFC181094291EBC80DE03E302BA9
      2673D2947C9D747B629D1A7A5354D2B63D94C80010B212309E5496CD4817F494
      36BE19A8837E5F2F0CF1653021DBB57C0CB7230B9DB89E077B78BDE1C85B3F78
      A09346294FBCA8F8EFB412706C10AF328E40DFAD5131478FA5C94E717972E8BD
      B6563D4FD3D080F603A983EBF7C8221144E5D0AC11C6A924856412F9F06A0630
      6760205861F17152B08468E8AB6D415D0420A2CC2394304B1FF79A3D6AAB3436
      60B547115738A47C83F2DBE787008BD47A69FD0D46A3DCEE5D114AE7B2C642F8
      438F231BF1CD8C906FD9DAA138E8BFEABB70A640B5D1F884E6BB6C1A449700D2
      15731DE437D37811622C84065BA19A8E5C0CBEEB7B71BD483FC57E6A98CECEED
      FA6E3111680694B1782ADE016B1D11853A3AC712E50298539811468FA647861F
      E94317CC04957DE2236C713D774E5F2580CD1160F413E268A7DDFCF4C6BAA072
      63AB8B9DA307D7949B51E05518EE228F32D6A1B2B001E02C88161898736C372D
      3820497A82E4C31B62D84E5BFD6A4E8271E21927DEA3DB4DDB876F37ADF2447C
      25BB0A0753E4EE88659C103BFF195671801B5E3FA5A98E9C5E060849EA28B51C
      BD0729E675181EA9CC15D68D67B12F4E2D15E29959F33865359A5C8FD142D6A5
      441691B2C8A2756A99CCF11C015A8D40DF7DF8FAE91DB02594913FBCB57E4804
      46C47EF7613215D80AC58BA427186D384920806D016CFFFAE5C71F40421D8AB0
      EC20C660DD50CC9E2588AA00741ECFE635E0EB81807BA14C4A5B1CBA8B546504
      91A7108625A4FC5923E5738459355ABDC19E1E70E93B2CDC2A7DA2A975EEB142
      86BA20E85C589122CABE8173050251315C7A04C498F5A0D9417AFAEE00989FBC
      840A3E70043CA9FDD76F17B3392F3F59449CF91BA9A44C3293485A0522D4CED0
      0A8AB79741147F2CC85125575C456AE1611B81E01C8FC7884BACE6A7ACE7131C
      3DB4B0AC90740B2B5D012C66846A640E157FB060846B1D8A80A61B998839C60C
      558AD701DD665A8C2419E7B6A4628AC6334E61ADCADA440F8BCC2EA823477CFE
      CF350FD5270C6652545DDB91346D97901E0A12B1C9A580700435101359888E3D
      BA73A9BEA365AFCCE8E7881595D9BCCBE1E7F118A8C05B381DC085D3736CCE87
      C94F20C850F1712BA134B2918E54A0A836210376489758D1D97A8E60A900CA22
      62371166D6A32B4C24575E68B1356FA9B8359A836B28A472A829B27E38354C7F
      41508CA371305924D208633B537E9B940E9E23302B71CC079A91A9CC2632E51E
      FF053F03DF42DE15C5568CDF409A06DCA2CCB2DC71E00B0FC8CD159AF3E04799
      77660C433B6B5A720D413EB545F3B2B1142910295713201A4E17C3AA46A49C48
      733239A014D1DB70553148777B160A30AF9767282337B24582BE1050B489CE16
      8256F349E94D954ED7232B9E1763C376BEF0C318535065BD49F4D75F794188EE
      FA5358F0502A2D44B9CABE25EE358073CAA720A505247118E2BACF1C7496294C
      06EDCC68008E73581F8BC6A461B98D66E3FA14FE38F8A7D1689CB070CB4FD23B
      252DDD1D68F0F2055A09B1342313DD63E5900D9407EE842B7D2E0AC7486A227F
      0DB2EF1654E9235767816823D47CEB18A0B0BE835A829282F99325603E23F2F5
      3598A72692606B6C194246BAD2D7A2CA0BD66D55A3146308BC4BC1E13CDE883A
      2FEBF402CA3580EB74FCF6F2D9D224F204F744FC7D37250CA4CF13641991A814
      6C0B5F8DA335B2EB8C5CD12C102C81FA70749B8C8210D7C21C9B9D30E6863020
      338D8936C507699E7D720747E7F01D1C5BF3256419066CA0AE7CB7548AC1C3FA
      64787664E8DA1314245BC1FFCE66B333DFB77E4C45F2AD756D61F3F1EB6FADD5
      5354260BC6A43B344D90FC3D04C9B74D90BC89857C9C025C125EF56511208AD1
      559015C2B63886045097E357806622F69EEA30BDB540445237D00ACCD1978554
      41BE0BC48F55BCD82B9C709DE00555900DEE93E6E9A51682CAC22721BE1807A7
      40EDA528C59176B5F4A8BF02813A0F8A2BEE450DBE1861B020A96CC8EFF04D28
      2F4E62593950BF91BDAF14D087C178239084B2648186A402AA50BE2D957424C1
      5961CE2B32CE71964B9CA83A4CB257E296A04023979A302513A6F4E8527CF7F0
      A5F8CA4EB0A880E3BECB309318BBB6CA4607DAA14691E2914CFC829B64C87CA1
      6182CE62F1A864C10122C9ADC34C7E79FFD9FDD57AFFFDEB4F1460F3F1F31BD4
      7EC8EFF21C97598D0A5741926191B7A39F75F1C02355F98EB88D98C1735EB262
      BB4980F1BA22948146B572375042F2C2C0B7E0DF8550A50D3731F0E72F1FDF96
      6BEDFE4140FC731E49A3DAE8C6B28BAE754CC675FC2A0B079E9C5A47DFC7283F
      50B05C3986B058AE003B9160343F8C46EE2DF12CA156590D85B0A4003432C41D
      53094A1522483E3B2B0D007F6B303C367DE7759FB162C7CC5B59C7583C922258
      4066851B40841B865E74F94782E67BEA5A4335412526C1A27F8C0ED43E7787CA
      E0B2F934D0A5241B2DB0ED002E968350C9F71B7372692ADBF7782C91AB0CA595
      540CA257CF3228A9022A5FE0D4C4332CFC5662DEB8E81AE746751C304AC6CE44
      60E1C10B4828FA7F63003820A22950B009A6D756CA8012A8C322B4FE81D0CA12
      50898700A25CF728F5832F141840FA9D27683FBAADF9F5C7AFD69FAD8B27AA16
      B0D19DF4A1977BFEF5CB4758EFFBC75FEF381E2D52591D40634C6D53189D41E9
      0A1FB11B23945D131F1F6724109BA7D69F2965F8ECFE0D634F761EDEB79EA296
      449EBD8C1C9F9278A980F7884A8E5C0A816E6A421BAA539DC4B3DD0827BB1951
      4D6CD9A608A4CDA054EEE87063481F0AC04572BD03C41A82BB23E3A34CC35655
      CE932FBA21219BCE0ED91B529D1FCAA1071543ACA5B31BE9A55A7A41B60B27E9
      3B6F365C241855F149440B23B628F81C21808E940F5C07AAA9D8AA32D80CBED5
      8027DA177F94D1C99898748466E8D0C3060CBA11EB11F668B018F41C5B683032
      F79703812E82B106555790DEAC2AAAB2768E811E930649A09161884C5D65B834
      3AB45480BA0AE5A26C15EE2161E7D9F56B319C017A599155AC0771960FCFA985
      3AB70AD7566FE2666FA82EE08231F08B35F642CC19DF595B402C66A414824CEB
      1935696A295A4EF1A5AA0737995DB0F0CCED26F1CB7FFDAAB683C3F5132B9844
      31556B971E65BB0DEF027116636EC9201F50429F379F03E74B29D813D524CA12
      A0D54471FC0FA19F6E9ADA06B5CFD74D7DE640B4F8DF9826F8357E2EF4E88E72
      6A015E953A4E015E4FA01C4765DBAEDC28194BCF5C5B6E19DDBBBB189C974963
      3B9C15735A76814BD604035A9EF8141F88AD419FCBE1787866FD4E451D97E0A3
      B81A272115A29983045BFC7D550D4DA5D4398A67F320AC084BDE9DE8401CB858
      6141BBA174E7543494B0CE25F910BC00C50194CBB844CFE0376C38F83D361DFC
      BD912FE6B31C8A563514A91AD5C44DD713E59471B3863DBE8404005F73C84AF9
      4B0543B11F8F16E4C8BEE9FC904C596E9657ACFCA6D30596306E1A896523C9C6
      26ACF7EE61BDAE09EB35C16B2678ED6982D77A871FBCF6AFEDBE6B9D59471FE3
      91176207EF79B89804D191355E44AC6AA33D21892F6BD89A0F1005EE547A85E2
      ED746F1E7472B131652403204641029C2FCDB02225B581076440EA5BE816148F
      65ECD5730D01A9008E477D94BE2175043F6C035628548D909BC2DF521DB9765C
      EA2C0300C4C0117C0C65E6E7DA0C697BB0C8470F3B0D4F8A162D59EEC85BA29A
      0268D340B2114D52A9BC005A3586A9F74D63E839163983AE9E6D95A8ED30F9F1
      EBFB1E10115074C8CF15A390C834C9B7142CB09E291A3CC75E185270FF4CA06D
      344867683C5577B1A297598C5638EE73045405981231CE8B1F2E524CF0C53AC3
      333889C98A6DC3911861CA4DF2C72A2F227D8F5C97A67070A8880392DAB9A032
      62532AAFEE51E1A73812E8034D56AA86776E913F95192A4BCC40474BA32E71FD
      1CA15605B3087362601970AE02A6225C8F2F0CBD791AD4894C9B7C23AEE7003D
      B29EAFE6D23B5020DE92C24B83E03136E8A6DF3895066FF6453A4A0266884398
      DC5265803D4BA2FEAF58D9F8CCFA428C91AD35D1220CA5CEE5CDE7BAA205C882
      435D5DCCA85ED5E974E8BE5A6456B763A58B3982D528610A367FC5B2DD796B30
      9D4389551D1A18BDAE43D54921C3485CAA8A9BD706409B4C03D075BD0DB1B5BB
      B0E2CB17EA7522E2CA273919A50E66052BE778812552D0AEA3AB88CB22E15C41
      8C7EA6776F69894CF7200A08EA8F563F11730373706A131189842AB600F0FC95
      8A6D9CC7E8EDA3DA925EB442D69027287A721558090DD697A1A12ABEC4DA1B5B
      16836F9C2D4653CEE8410164E74465C97A5A9E4A88A5BCC351E2A553517FC56F
      E0DD6930898271003236AC6446C53EB08010066173304FCA1B9250E83E16B78D
      542382F5C211BCA13EAC3018AF64A057B42233D2D18FD1256C32A88294529232
      E4D6E2468DD579E78EA1897414CF6608699CBF85B39B0954930C99D3B6A6654C
      485701A875B4BB8DB569BB6BF60F6773EADFD5E6F4D0A196673851E41395DE6B
      58FAC3055C9E593FABA283947BB9B5E8A96AE0049888B064B6A67B3D2B5A4861
      3A9CDB824597125FE6A7B3098D8A1D35D01F48DDFCD24BACA624DFF657AA7E98
      BF8F4A2295AAD3E11B537A256BB1EAA1DBE8FC8F84F98F1F0B41A884857100C3
      9F2018E2CCFA00CA0EEA554FB5F61B8FD143ADBBC12748E36B1D3112515A57F8
      44D7F647ECA004CA632E97623D7814B8C81D18F9AAA1DF1B6F7489E540E1CA47
      CA2B3322C7EEA84F1DEA7764E28BD7D2A28ECA619047AAA2A5D6AC4AF950150D
      5B291B6219443EAA56E40F577531E702856A10F1A3052B3EC732D5215C715A6C
      EE5113DC5CC278CEB64831F67627FC01B9CEA4C30C08600DB48B9FA56F4CD3E9
      E360AC0AE43C4B939D8CBA36645001E413BB0C80460554A65C8BB38B48390F02
      E0D8C77F91C5B981AAF9B2302E154DBACEA8258E1F8C897B67EA2A8D9952C6FF
      44C0378A5524520A2492DFC7F6E2F1225B242666AD467834484573F414EA2842
      2ED7F0B660530798BEC7DC7B0EC635585E0C601929F851225BE24569E871AB6A
      E52D3C4E85906E09BC27378E717B75AA52ABC1EF8BA818A899A9CEA68F9EB0F8
      F2C5BF8FE6DF5EC3FFFEE3F1151FEC4AB3A44C15799C8B1E9EB8E8A76B3C856A
      8450797CA0C824E82758EF221BF79E244F1E4DC56C9ED0C78C7D5EA7161573AF
      050B4ABFBEB773613B6DE7093462B57ED92F25445F0DF9E25D6092932003EEB7
      48EBD4CF210F04B69643F2D24CF701E47D8211894BB3DF6AD6232EB7CBA0374C
      BFBAC649469EE512F30A55CC1096DEE11B3838C830FCEADC0B00948C789090A4
      A47A6EF5A1017A8C9E07B8A478BCEA924CA0287427078587058513940180C105
      E39592024A3B023205173C4DADA31F495C2BFDFCED91E29BDA1388D666D553E3
      649F22FD0975F4D036060CB1FFF1837686AAEAB8A7689FD0F3DC396EBE10C9D4
      D0ACC1D92A1ECB3B58A68018800F579E80E5FD329A2B81F8D727907FA4D95E42
      872D46DC332B180702DD57978200FFEDEEC3991FC0ECBA6F77E05FBBD772E08F
      D3757BF0A7D5E9B8F0C76DF79AF0A7EDF6F1968E6BE32DDD9683B7F41CD7E5A7
      F11638E55D1AA6D9EFE34DB6DD6FE25DB603F7E1DF56D7A5FBDC4EBBF3B0A7FE
      514AE7147161FDE4543D23A2091CE7E95F5074AAFBCC252C7B12477FE9C0FF0C
      CD2D2A59E95C8C18F1B9FAE46C4194F2F1C596DA92F03D17C3267EB226091F2F
      F1B1C78701A2E713B856810D45AFB2533625619175729C62ABA76B0F4302F7E2
      6A058CDA1D5AA300CE3DBEC663EC348C9A0955B9B0584FF5F2DB022CE5990457
      2AFD4C8901462EAD618C9ACD8B3D9F0D152CE2EC3A744A465119868CD6240E3A
      46618C95656AB3AE05B8543DADE2FA9EA2D1CBCB171B8B39BE3EB96F41CBF46D
      D983BE562578B64C82674DE57086BD2250389704BF869C6FA291D7233964A814
      2725E9E2700C27802D77A94AB398DBC0058936B3E741B9AFBFBFF8800590B0E4
      4126B07608C6D0261E9099E444DD2FDDEAB24A83F450B1264F5DBD0B72D6CC9B
      CF51C71E8A6C890E7C3D1847B7F234E8551CC87A822200DA011AD60FAA02960C
      D94F9116F3D99A7A3EF7530F835990D5800DA62915D46E6F34920DB1674590D1
      3AFC008B1F93A94FB7D026A8E84579B22227B7712FFF260DEC941D25EFA82D5B
      F1DAF23CFC14D335569C4754F542361E6003750130A15BA57836D2F95A8C0B3A
      3132F452BC2DD639596A8287E4367EFA2087EDD4F380821CFE4A87B6065908F5
      393F435928E51A6632709CAC21644E8A903C9C167A4361BC2FE6119D72FF6DAC
      0041F7E41EE908EE4DACAB409BF428943FF4567924D82121550D58FDF4E9F55B
      CCE880F567019F124CAC9210245D3249BC557E7A344CB1D713E8536887845376
      71B94A8219D1B8D003E051259B15014D6D0611625D65A64088E04CEF9C291D7A
      3484529D38CAA7CB1DFE4B6FC545EB647F80C33DE67523790A69A6451CDE04A5
      AE555229966F68D9F72698ABACE02728134DEC8BCAD57A0A938234CFD17D965B
      FFF2C5D76D210137EFFFDA5192A44AD224C59D5110926DC73012865C11A2419D
      E33E0FC300A48EE854A72FB54EE914ABAF547D5D4CBC14AD29E579C01B45E863
      82EB3C0C46019EC999975C7287921473928262EFB2CD841F9E82261D35E41A7F
      376E50D3F4538EF2A160772017E1C2A75CD19542910284AD630555B616A98E7D
      2510EF3E660FE75E38DC6376B29607ADCA0650A58470B5791E8DD622A5985C44
      A1D2C22170B0D23942695CCBD81846601D93188CD51A80FF591F4E4827D9F9B6
      543BCDF290218ED97A8A2C81D1FC4C6A5EDFFEBB5ADD13440CB115F60900F094
      8B86B32902128FFEA98282D6838128074AA6DA467132233AC562FD50E4C52AD6
      4A2506F57362D7056ACACBDA38DF92BB009FC48A208DDC790EDA3049B3EBAFA7
      EC6A52E96BC81105EB47FE6AB4533007D7FC8EBA9752A913F29D037B64013AF7
      62109CF262427B66446F0AB39CA58640868B432FE55A3E6441500110A872112B
      7E9562D265A684186446F49BFCFEE876E89C0FC3FA9F8213EFD512584A55C7C8
      902FDE9D9CAEE57B94C09DEE1E12370E05B84984FB69D244B659509C43B7A0C8
      4003902250A438C03DDCB98231A6E73DE705CCE37C079ACF7101A37F88D1739E
      BF8F15BA9E330681F6FCCC573011207745CF79018910973CFFD6739C3FB0A330
      78D63BF0376FEE4528CB9E3DDB927AA07D2CC5E4796F033A181793056FC4735D
      04C873CF9CA0A64BE13FEF15648BE452AFC07D8E2B481669AA0FB3FD1C57803D
      FD7292FA6FCF7109D34534F112BD0DCF5240052571188C780126B4BB6CD3B878
      B7C38E61CC14BBCD14AD6769A63047808E8072CBBA25276DB763CEC59DCF857B
      F8E7C21C892DA1EEBAFE3A46FD2DB84EA8C6FFD40AB413845D2DC7C445DE7F76
      659CC3E76E47DD805E5772878C399F3CA32EC7E27A24E699A24A8D93BA56788E
      7A5896CA9391BB49855A6E448F8E773B77B614A23FB5B02A6CDEBC39CFCD4D41
      3308B2D1143D4D1948A85116CC54CD0E1DB5496583F25A2A9420B0577A4CB9AA
      057998387060D3F54C81AF23AC22CC69ADF4428A5BA14C751D7F4A7E1E1976FA
      4FE7E7C9F36331EA24A2EADD4F9074D1C833199FC05BCD01BE8DDD773E484982
      1A2E6DF6AFFDDF77922A3C21B0B869209D22E9D8962DFDE080E1510F0557B0D5
      47CC1729361BD40777CF806DCA5ACF624534556A3A5C3992D038B28EE1E31111
      042DB09CE081CE69D39842858A2E719D6517ABC60085F2BB4F17B4127EFBEF6A
      D68F1FB6D1B07E9EE2C67299F37477B6FCCB17C86F8A550798DB00FD675EB0D1
      0432DC68FF725A645D149F0432E26C4E5B3C11E5CC07FDB4AE4CF0F8E54130D2
      E13F1A41143C1DC5D6AB0F74379D4BB1A203904758CA04102BDDB8872213316C
      9AA336F672F46F910796530E05DDED08488BDBCF753E386995792F066A7AA135
      9AC6C188022F1E268DF89083205FBE28746CE55EE6BA6C470E7A598A59869D4A
      C167449DD21F4EF6DA8C162E67F1141378B660094A19C5109CDDB8AE71856278
      7965D40DC29B71B510EB58C698ED470DEEB7EA52911E3C41C859298AF346A6F5
      7091F94FCBB45EBE3821CAC411684331C6043C96974E73ECA40A364052D62D15
      915F286085988B1D8300D5863196369F538DEB86758E674B9F253544364DE2C5
      647AF301030AB7DB1F0138AC52EF52C66D980331C47570060588AEED68709F50
      0571E929881F13B172DDA2353258AA64788C640545BB4294F85A42CE7E5AE5F6
      D7A88042496A27613C24DDBAA06C1EE3D6CD93204E828C7FA890774E0A64F969
      C2A29F341C3A7E9290600C06CF0AE97C55F745E99302677B0F905D21E40F47D9
      0F3C84FCE1167E4821E44FC1D147F327D9F03C9B1E49309A59976873C6B6EAC0
      59874108B4F5D4DAA2783D78E716A61FD113A44561593F6A1B96E4994DFBF134
      E45AAA2556D9428AFD57A80A814CA902011D0BFAAF8A56D3C7B7885659B7A8A4
      DAA3A8D83718881952A79CD9CDC57F875A601C3F0D777BE29CBDC6939945DF26
      DE248E8671123DA04974AF43B7D1E3C28A8497E8861AAA423417BFA4DA97589A
      05665DC74A8DFD5E656FD1612CADF624B06A15C6145D7C78FAC4654D9560FFAD
      8AC5AA5B4B911F9F9412337531916F39FD7223FF72BFC1B7E82EE537D8F91BCE
      41510EC360B4E72B28F16C63E84EBBD9B4ADE31FBFBE3FEB9D18BFB13ABA3FA3
      B3F4093D8B8FBEE0821113FB7461CB694DAB749F7394F7A856B0CC7A076268C8
      D723D48C6D36BF6D367FDDEC2EF6ADF58B74334A8AD6B8F8FAE5C3F77FBDF855
      9EF9BA24C49C783EF187243B3FCEB10FA82BBA209F0E76997F95D7CB227B591D
      B3631E3066A8C00352815C74D6510515C7DD3A26FF8AC2AB13C3E66F3EF45297
      467BF033A000F75C0E9A5D2614B1111009B054611C2EC89317B931ECFEF1D8BD
      BB9DDD17D46791CE7EE5565A2CB059C7E75FCE5BCEB7AFFBEF7BAD37EFDFD756
      0FB6BF6FE763DB27741B4274AF10B9203F33A8E8B2A2A52176056347AA820EA8
      5B73BCD4CE687280267188E60EECE35CB6517068CACCBB94A5BA5EA1D776EA61
      35D2048803B7DCC3427BDAAD4F72A6ACCF2987D91DBE5C2E16FAF9C21439DF09
      B3C5DCF7D0F8CE6A40E33B801382DB6FC06553B0BA3E17AC2A58ED9882D5F510
      F1CD62320EAE85695B5A615B4E84749305698A6566817A0A6EE18C603319375B
      336EDA879E71F3F2C5BFB67B2DEBCC428281B173D45892AB1CE6A52EE99BEAB6
      446918332FE20A8829A0817F807BBF73E5B06E17D6ED03A1CA3836860B6BA300
      4041866236C788552CF61827699D48A2E3944EC80975ECC468C8947AF2A656B6
      8CB56FC667F32397F70679E159665213DAB4017CCC68FC58603B1AA01133413D
      36388A761647D4B72CE01635A19766DC26860232B172B9AC609E06D9C22B368D
      7E56C000507400149762358C91DEE8B02B6ADA9CC473DA725C50AA21B58C93CB
      E7B9D61AB8D1EB023834BD18C621C65644399A8C17483930D01E10267EBEF4A3
      87F443ED2F67A3A84AFD7359D72F06306099BFBC5CE2F3C7805EBFB86E9C3AAC
      701A27C13F302B27441E1263C2229659C44E0F20E39356348CB32C9ECDE234E3
      F63CCF73F5FD26ACDE0BB33F8F16494A5D08AF0416D55769425475B2D0A13905
      28848B1AE2D62CC29C21F4B103DE0CD14660F49FBBEB3FB6D17F8CFE63F49F27
      D27F3ACF41FFE9A21E9066C1E8124977122F4B3C9AE3F290E047DE55302131F5
      00F7BA06E7EAA294FA857B148C438F8B15E33247F13C206B29653C8268462A9E
      9F78134AEE8A7CE2F6F3E72AA775511C7DEB65DED655FF91D64AD8DCDF50CBA8
      D9CF3C01797B2D7A0A59E546396F2A2371D6E39A0B98BAB1C8C6F0157D6AD879
      D970D29D39ABBA668D6969B70E9B8B6012A182B4BB485824332F459A925F9B58
      EDCCF3B12F137B0D982BAFB75C29E5E463D9204CD79A2DC81C910826E9A076C2
      2956F5E1FD38AA5F21A0B0B9A0DAE996ED22C2C0471FE3D8132CE2AEB2ADC435
      A5A83FBA4B1E8BBE200D68C0049EA84533E5141291C998873E3A10CEC671B7BA
      39F3434624A47926556DCC7A2DEB0E706F5A041F771F94EDDB50C73CDDFDEA79
      28BC54A87608619C51C7336A6BA042C03905555650C0BC0B2F9D0A69F90C224C
      7C0961E2DBBA1919DA5F530DC59E52C0B10DDDCF7529901F8E72E81C01D51D2D
      C86E12A81641695C0ECE2DDD0ED0340D8CEFC11ED234F6907A18FBE3073400CC
      8C4164BD3A12355567B916A30DF3AEEAC3451052A89D069DEC912965246F9405
      5714EC21936C8BC50C8EE889231879C8350C241190213874E93818C5912A9E84
      A94DA118A31E9744D8CA58E539A1436919447EBC3C4531E42AF0E8BA9A145212
      35F8E7B9E26BFBE45BDD3092CCACDA1D2984909B633B64389F72E2BA157D8683
      D7161B3E4468586720F2B4B804842CC5539C2C6744D0F09C28910AC42A326A45
      20A57EA4068AC73EFA7D132E5D17A3811FAE0A4E8DE5D8B5131AFD2DDC661DAB
      5FD5DDF2E1E2CDFCC27D52DA707EB217359AD22F71AF512E89531244A4DC2E65
      EE46BD5D8BE7EA5106B48203B09F2967A6CA567F12E3E4FBA95F2EB7C64527B8
      C88C10546F072D6F89861654DFA859751C8DC3806A4182FE9418A25A26AA4A08
      42982982A034018698958E08ACC7432A9646989AC13944F831B94BE59D29923D
      92E6BDA8547F4E1118DA1FAA56B771E26B9898EE8728E0CD159543B5E7588DF3
      0D3F7FC2E3E193F9487ACDA55E6BEA625E726F8D4E234AA6C1248297A28AAAB1
      13409A2D8CA2B31B6D3F8A8988FC6D47DB084CEB2A3DB22F9AA39455D401FF29
      6035519F7E05D5E122CBE24846D164F164120AAE04408DD9A92405C539ABFBB3
      380E2511900FA1224521D279A54460A0C320E2301B7CFA5C6D1BE966C774B678
      07F974EADFB131E3F1C6893BD9436AFA5996EB1305B499E1AAE3B9884EADE5CE
      01D0463F2A16C41A83F64811DE022627CF3683331124559D4A61301B518963BA
      EFB8B4E46F8A0B3C5183C8094A6006A97A9321093B37E93B98E2D9DB1F3E3017
      3354602B874717D484A32ACBF02A4AECB2CAAD4CD847D60DDC51AC3BE84804A0
      1FC614A348D9CD3518383748FF0F0BE0FE3F14DA2B0942D6C8C476AC96AC331E
      CC00921CCEA63B88D3E118792C520F01C0347B0C7B940D560179CB92334E9439
      6D690D70B632CEB8503A89396CB590EADDC547E35DAA36507088A13653208A23
      C4F0F42994A7A23B53815958D6311CC725B2085971A721D2D0AA210DABEAE5CC
      74839996B565E968384EE5979FD45683D51393BCF82A0BCC439D2F474ABB671D
      91987C64A5619CE57235C5A7C0AB83044B55CE3EBC4D811BA2639B1FC349BD7F
      777D7D8DDDC146A261BDBBF6E858529121FC158B5B624F00381C0D961166C203
      D121A765C522CCF43A0CF48B2DA7DDB28E70038ED4C4EBE4711F379BF8F0FBB7
      2C7DB8CD7E47AF4CADFFF8FDBBA6BCEDDDFBF7EF4F1420BC2C2F9C8471D77B95
      CFD17881EE72A2555C209806B7307F34919A889E071AB4E85759FA13175BAC90
      8BC895A499E50793801D30046EDA062272DF7FFE0A1B978830A07A29B221B68F
      FEA219D6E12BBCDA8B56E8B8AC8F3878086AA97184266884A2C437AA9E415A23
      17BFA4C07E76DC0116174E0F2D66A509BB2A94869531555976B43AB3FB2895E1
      3391F579F83700EA87B7A7AAF53597AACCA1248F2543E914F8D3FF435BAC111A
      982419FF10361CBB90F3922D8765AF83260985AE6BCCB984E8D0DDF93897ED5A
      C6B9C72FFDF6095C9D1F26116009ACE529EA97D1FE10CE7AF941603A43470329
      131C8C00E7A824788D504AEE913477AF8610F75B57F9EC87542CFC7803888F00
      C2972FD68088E0291CAD124C991849A0726B144042559D6B0760252DC7388894
      1F1ECB4AC63B2729C53F3FA6834F14BF7878E4012EF20D23C7ED82E9172CB328
      22CC8979B3B2CE3D52578D44B71D3CC572745206616635F2B807D0986C927489
      BC51DC39847E951C2E8E805D4482CB450C31CA41BAAD98479F7F39D78E24AEA9
      810552B1C0C448D6D9E6ECF3DADC0516C07A0DBD98992ABC99A7B4F369985522
      1827B099D03411A01A86943746D14C701E23AB0D2291E2B645D916669E08E996
      93C5AF32EF123FE5CF3AC0DC81DBF9FB95AE2ED612644B134D546FD5DA3E3184
      A99D0017E642CA14C8999DE22759869C62BC0846F5A366D2DD382285716FE760
      255334CF5AB67CB206BF1189FCFDE50BACD2C000964A4351E2E326018C879E8C
      53E320B10C8B0F78D618442310F11699900D0A90D8AB4AA9F4742EE67B52B64E
      305550EEACC4F4D22AA35B6D62F1542865A1C07F1BB09F7C0BEE16790BB338E1
      1037A029BB03F8B0650E4CED08236F15F488C089233E96A06F2C3C55A981DE04
      DC6EBA51A34D472D01B6DD6281AA86C38664A7EAADA6E28945B7B7302782CB53
      84AAFDC552015F80F27E9022CEA544374692EE3C2140B046CA53C8B37FC198D0
      5752032C9E132055A030A5188A47871769155D549AF053D499D7E0BA80D93C7E
      3D5E052C82451158921B2BF69320277C0AA9FEFCDBC16F485906BF3F057088A6
      C92E55E42DCB2164A4E35DF0FB0423056728F7909D47E312352C90760090852A
      250023481719A2AC29A563B5087A2C95D5B118C1DDD5A296BF20CD9EE51F651F
      1409DEC0DEF7196EE59CDC80B89B696ED8611F06995F750DF43CAAECFC871FD1
      6980F4E4CA0B42E44F528545969ECA7C022F921DF6E0658B394F03AD910563A0
      3966D5427441C1A14259ACFA503936739CAA8E1383476A8B451D71B7704C1D0F
      959CEBE55102E55AED24F2965F250DDEDA1CA4C690C78F8B8F799A464A113ACF
      5CD4FE71732A7687B8E446785095FDD01866D60E40B809A05C8D4FC43209B20C
      7DBCB98241FE857494605806BB8CD9D31D51253F7640CD024A56A18A11627787
      4759C44F9E9C82F191FB4E227FD11D5EF6EB3D795128237C4AA37D7D77E16267
      ED96ECACFDFD4F451804D82A3609D0C243EB241B0105B3AD8811A50D6A1A0783
      B4BFB9B878279B73BB79CD4139CCFDD76DAFA145CCC305002D6D64D78FDF842D
      878B75CC9E54ED8A531EA520A2E8F1A2219C6B3D17E67D52C7CD9895F1167775
      736CEE0AC4210C6A371F5D0DC659D2246BEFC95EA681BD5AB016D0F5546A775A
      547BFC72C3229D3D49561F00E029161B3EC562B52190ADD7D2849A618F268E5E
      C2EAA9DA95F7893D4EA9C8A4438A6DBA1833105011DBA2617A2F235E89BEDEAA
      C8C6036F90DD38905A1BDDBBD6DAB82B2AFFB613566C04BEF1FCBE5C6F30B787
      CC7268A8E148D4787C6EFE23F91D6A13CA7BA51C67C82DEEA17A867B1FB36935
      EA55CEF83C06412FF042EBEDC773A45553558758D29EB3220B3C4054731F06D5
      06BFD540363ED5FFF7A72F4F866F543BFAA72FBC3FB240836BFDF4E550B0B05D
      130BCFA9052268E9E7E162A85C0E0F808C0FB1C64ECD352A610143B58A56F027
      5F40B7E602A2383AAB5A84310C581FC6CA185530D017B4B60C4DB78CC7356CCE
      BAB50986110835AA6CD6CABA621C51A803C534C8A44D2CF59F66798FD140C675
      8668795E15FB83B1549A3FA6EF57AF41AFBEB43753C38174FBFECB6892F9825C
      CB30396A22AB236DF1FE212CEBD298DD766E3AD6CEF8C4FB9057D2F58137C713
      73CC4ABA51093C350E1342900E8E8EA7D6ADE7E55068362EDB423C1DD382D184
      5E82557BD56FF29C7B3E1D733E72E9A975348AE72B54111B8D061D812336F505
      B32084CDC34A639C8576925B0B0B36426D38AC9F02AF3D4EDCE6DED3566E4922
      E4C95DC50BCEFF166BA79E67BE8F5E9AD408DE42BD196BBFCE54512AB4077EE6
      78F249A0B567B27B628C4F1A473ADC48A7BA4BBD9908E6C9A9E69EA77998E7F1
      B86CA081BBC8722DDF4456D0D29E724CB58C46FF2111E3E07A2F959C92100B31
      A932B406E8204011FD6FBC099125301B83BB14938363CDF5B0DBFBABD31EB2E9
      EEBB95A541EE26872C9173647BF5A9AD6794CAC10BFF3E0554242297E24C16BB
      D8D248FCC12564DC6ED8A4571945404DC5E8728F00BBF7F1CE5B8AE4432105F3
      43C569E54BCB892C857419FA9D8CF5EB87D23A2EECE12F8D5F8BA5F37FF9AF5F
      EBA745FC371C7EB264C9A03A0A57517104D46EDBE7D81E4ED8589B71EDD7BC8D
      17F882F310CB89C2D13BCF92F0CFEFB000232F9A574AC1A0A5A21F52F28009D5
      D8CF529CE2288C533E60CC2419549FFFB3F694A9879CE60447E7EBD4FB34EF85
      A09A1870EF25454FC94FC2EBF1454ABB97C711B21B1288998741ED9FBED174EB
      CA0BB18E2ED127CA18D9CB365863D214F120D03D94166BF2A7BA4D814934AC21
      687CDE79076581C2EEBEBAD04046E6929770C19065A40DE75FBF7CA4EDF2F990
      8CF090BC32329D0EC3A063200BD5DC129AB94845D55A1BD6DB4259FAB117A67B
      1C31F6F0509A3E8786901871CA6F9E012491C44F45E87353139C4B89FC310FF0
      462331CFF2121C9F76BE9848E129B27FEBAFC034E7EC6D3DC6C0F7345B85E284
      5DABF999C6001553B4A346655ACA8A45BEAB5C9B8DC914FB31984CE2759734C3
      25EF29AE3C5FB0E3C96A490AC0B1B846CCB6A4848DB1EC9C1630C2283BAAAFA3
      9225FDC047F14B87D9CBE1F3A4ACDAAA0E56FD88301E4BBD0C83F38BD3854183
      343B2DBEA6763C1225E8ED211BBE6300A8526DB83A96414E552503EDC84729EE
      C6A59B635B6D162E29C73175E502E248B4313567778BDA284183463B6B0C0777
      C1F94E852C235D1493E5CF30466D3C98098EEBC7DB2631452FE179B7C220CBF0
      B0E195A25A3E0725650FDD19E6830D71B80E5D0642F4CE6756D47A760ABBC109
      D31BDB7E9A9B5FA2158BD1BCDED42AD434E0B2845C7F4396F785C38975E12789
      A758A83522F74304A7173577154308037B547747BFBB7E72967E86B742E6B967
      382B863E6D8A6A03768CA6D565106111D413DD7337E55247B21CB13436C8927D
      C74331F2400BA8935FCB15D3500753060CB9172952EC7811653A628C12AD749B
      59321A9F3430E279CA40F46821943AA4C7203A1FC58449A0ECCDB1F8F52898A3
      D6849DCE54AD21CCF167A1854D53723DA4C90068743A3E4A6AD20A74A512F391
      86E2EB17F3DBEC00BE2942F685AB10AAEA4B44167A096A5058EB4550C570F803
      94F9A59D9D37A7F6AC5EBE788DB1223029E6A4ACF8C3700A4CC5F62A80CA7178
      C58967730C1C9405AC29716E0D4C122DE0CEFCA0708C39B21F3449CDE6D96A5B
      3CACCAD99BCFC315DB108FDE93418B345C7C5ACFEDA851108D65C1105DEC7C1E
      07111FCA1A94EAE50B827E24E8E0CE6242012ADA072C9CC2E91948F836A0DAAF
      52E94B918B02C8C8243B6D4FC80148E7828046E1C9BECFF6448A938433577821
      AD8EF702A0BD6094B869F55C0CC4BB14540C8408A4F0D295F4A7C00A883FAC85
      DA9D327911CA8A8CE616AF068CB29D771046509A2421CA1A26B1F230466CC5BA
      2C1324343C1382418E2758C404CF001D6E24A66BC8F554828A733F828AD3DD2E
      A838DD7B77DD30BDB95873DE1801A564BBA2F8E6BCA81E594A29865871E85369
      16AB04A88EFE972732BF4A4752F95BA40B1287AA6D71DF78159E21148AA87B5F
      3CE6D85B2569ECE53DC867A92B767A85AA7D694C664564567E20ABBB88EBB9AA
      6511447E00920CEA5AA5932B7D3A0155A34421ADFEA4FE5BBE6E2C095EC15381
      23935F19C85B80E1EB01695BBACBA39AC21EEC58A62393CF8D2328777BEE0AC9
      6ECA421D14D3A10C61DAA9A852A9E86FDE727E3361F31741BC496391214FA5DC
      793C45D719D7128FB7D4D7246A10CB6ABA58BB4A8216F09AEB72E7903D2D6A22
      A08F2D226DB5C312582A5D292C1E69991BB22C293D1BF100CCCE0DFED70C2C2B
      EA7006DDCBDE7CB2F12D638BC3DC632522166C0991B469EDC5ED287EA88E768A
      FC7055F0A33A3AA6A9143BB53597EF54957A8AA4EF1DEF3B3A2FAFA0D1681CE5
      674F5513291C73EA9680FC858620BFE5A74242EE16954995C69515A5C8BDC92F
      5D935CE035A9D468649E9672CCC9B2E435B66977CBB0ACE0604680607161CA42
      88CA54040D0F71FDBE4C1C6983F555709348490AE398EAE8C8CC4D5DC7996BDD
      6516F660CAAC96AECAA30C0EC7525DFE336EAF326F9C342A29AEAC4E296176B5
      417FBD9B77F9B46063A0F63AE8FEAFA373BD7C11CA66661BF8A02B3997B941A1
      50326383C634420BC24DD6C1556CD78688194A0C29969063F310D66C09860B58
      A6365428C84AE15695CAA7495162391D6A2549B2D33D2FEA240796C98743A1DB
      75934A0FA85B2793ACB61DB261BD26DB02AAA441A25BC32957B946D9F2995145
      8094D6AC24E03534D6F721B63F9D43FB19F1C235001A46582474EBD8C5D5BDC8
      9213B0E6573A41C835F3B323F65788BE673354318E8CFCD625DAF3214A4592D5
      E8F3F2F2C5A7F258D89C9D0A42909B7C196D903420C5E7DCC7FDC7B9F58DFAFC
      9694EAF32FE76B93A272BB3252A738D2C53418677FE669AADADC5E5688265661
      3EC463C938266FC68EEF91EEF8A1ED7EF4EA605C350C56E75E8F1CC258A32F75
      44C1DD944DAE59C6C29556FA96AEEDE3AE2C8667D3B2CA010AD2E239933E7F1D
      925D28C427897BB82A573FE00804AAF05F8061CA6F39E53AE4CB408646E5302C
      A4307292E2D2A326B9B2AE537DDFA7472D456958E6C579CD12EA336C3A826FCB
      52EC1D7A47F0CFF33AF23A473C9D516F0C45BFB0A873A1BC7FACE2A254A48CC4
      301DE3AB692DC7C95C7961A0F9F72121CD6EC6C161E167D6E775F14CE57BC873
      5272DE3DCBA5BE7C71112F9291C0AD5F9746D757CB0A11BA61D867A6FD995AA9
      A282E532109B91403AB0C8DDB73BC0BC807C05C493DB41B1AD0059BC2863B061
      6E72FA6AAAEB0CFB596D06406EC8F03A434E5384BDCEE0392D1F350C72899EEF
      497BF982EB7C5B1F3FF39A31B4466E7D8179161964B15D408E74B2B67CAA3064
      031F94596477F037DB4D740544858885F05E1A993321BEBD559EF61AD89D3DB3
      669D6D53070D7C274BB45DF7F63C911EAECB1483F0AA222289863910DEF8F2C5
      6BAE0371B65E9BA15C3359477DCD306226419308D0AAFB3871F7BAF5B5FCF3D6
      1BCCDB831523B5454396182D4A19524B1D0B4061EDD4DACAE3A7404E8F563AB4
      5F27C25026E0FAE994AD24BCFC01795E879B238D95A36AEB48AAFA70C5405FA7
      459B62AA62417828DDD922C0C8FDD5BDD841B8888DD1B34B7661D410943CC41D
      DE48D122239AB410CDB84FBB52BDA84F0B2990C315077B73F008DFAA658A59BC
      D823C6FB8DC4BA7298D0908339B13677A6B16B126061178F52651A6B567365ED
      23831C4686F08140B7A9488C22B48DE6F70F5D117AF9E28792F1F77B69FC9585
      7FB421840D113B8713AADAA7C8A4436126D6CD463A56A1F09B7CCB31164D4FF3
      B0E1936729BF1120CF4B417F9422B5AAE32292A29A0408FAA830E98922310860
      CA161E06F3614C6D61B5F59F24C321C7AB163B407D4FE5F2FCE051BB1A1F3879
      DE6AACDFB4BA538EDDE9367F86B2C8171217377C1A5586D3427FEA40858836E0
      C9093B2129C0BF06AE9464F9829F63CFDE0A040915A6529823BA17D7E3278ED6
      5C3E68342DE529E28E4F284158B93222B1C4903C3203EAC1C996566EC44009E2
      E5B455E3DFA84E5D29A38BF1F45742864EE15A3543D28E899C924D57D9A5778E
      3D94DD970A0D34F4DBF67135A752A84257B0AC2CA27CA01E05FAE6D6747D6464
      56EE5E1E6DAE3AC0959DB972693A4A82616E268823447E4CEFABEFCDF98C61C8
      1B5096891752F9D90A60BE2748B58DB4DCE9709F8A01325C832C68722A3B1F5B
      9BAB6C7035149C15824E9F2A1F04CD53E73709AC5C9B965AE4AD599B0CDDAA76
      A8C89C1313A2B4C988534E50F2D23CBA0429414E01D071888176D611A5D55404
      FDAC75D629879C8CABE27CF6A9C322BB20EDBC95DB9357C7364B63261EB6B45C
      282137E52A219628CABA80E6518CAC2E10A0529BCA31FFE654EEAE67810E5F73
      2CEF7C2CD9715E40BDBA277337F3BA8FA35B8AFDC80FA362CB3A7E2B52B59472
      3D659B48C2767F0A2078C214DF6774CCA860AB8AFC3027EC36278C6BDE52E008
      9CA2FD0F9A3E47BBF331EE74D08AC191925DE6DC70DD92B0CB76504C73847B45
      80512F98864AF133892E8A550C92849FF63401F06BB711080D4F3DD5425A8E9A
      6CC52470FEB099BB3D0C8ABA6C8F1D2E0441ED9199CC469E691CD3CCD8D052CA
      28E2D68DEC3E560BA0F8256DDDD0E14BAAAC53312DDF9435D8BD073077ACDC34
      9B23925CC8AD3C32D46F7B3DA00A7071BC2175D73ACBD30742ECF3451D5E7FB9
      FE5585E3A8E240BB6DF55BAB07B51BD6B98C0CE4641F9F5316327A23A9C9E4F4
      B7D2191C09261B91E5EC57D2AB7A2124EA73E61DBC390FB65B6B7DBB353F8213
      22364057640B15C6CA539D755FD242D44BC97D8A50C0BF720657321D60CF8573
      FD5A19D6BEB9E0309805444E77D3CB3CDA74CB9AA96B5A2669586E93BD0ABC2D
      0CF1069086C1A5904E6B43EB76EEC917DD0D89ABA3FEA2DAE1FD9A4BD2395A19
      1A58524CB8BADF3638E527F858A7C3DE24DA9552684E769FCCCD6E567BD4B8F8
      9071CD8D78C9F51994C78F08367646DE3C9C20C68886F501DF972D9288FCEFDC
      E51CEDA7A9EE91A5CD1E303F3FF1261345A09800EB8E523227C71A61F6A53497
      5060345D494B216109BCA744C19468CB322BD556A0CA8F7955C5791203C06720
      13D5D8496561575BB647D234B2414682BC8BE44DD8B01E644E70948AAB6C4A49
      352E6EC02BAA0A54A8308710A5D230F1DC22E2A36B612A749382ADCA1B476F6B
      B1FF25A9C9AAF4B1A1983528A6922CE4DF14D9519AD5884834B5B0342CB8CA92
      8AE9C12235AAF3F9E3B7F5E6D20572339FA2A7155678A186DDD99AB44733E35E
      81727AB589D377B21A27A700517CC7EB502601E9A240B2D6150B5BA8E9ABF4F5
      9462B88271E9DD057F3D4DACBEFD3D52068091974AD5B5584A88471F07C5760A
      58828453A4D02B5F2BE45C8FE425728692B50468F2A3D322A37F0D99DBCDDCA8
      9232973A91A116867A15B30347F16CC6A90C1199BD4054A1BAE0798130698899
      7A92C7E7856364E80A665E94CA6AD111382E5412973706548B46CCE6312C7D95
      17D85C7AEC9A5C44A038C9D38C21ED5879DBE7D2531C81253BDC9D804A5827A2
      4B567B53C21B668A6086A5005D10441D6F3E57ED45F4417A74A24DF8F996007A
      01107FF4F64E002532B851B09147CEF6E82C56DDBA8EF5A7BF70EB574EB03FB5
      F4753F1CA5A7D6F9797A520AD8C60E511C68BB05DA03C2B54787F5CB17EBD0FE
      D6C3965AA7436C02793A827FE78FDF5E2B87BE2E32570A442CC3B3C67E6E0539
      87A5538EF1CCC3CEF2A37081F508D536AED9770D43D9194601B4ACA4C619AEA2
      5DDAC51AE5DB345E52B9A9D8B997090E3F08A2B379E88D385836E6BEC11FB07C
      2AB65891D89ACA54BE9353EB3D1C984C3689A6A4904084BE2C4588851A78D07C
      2C2E0846B5A5B329EE9ED8A750FB45C142B96DA2FC7616FB434C0EB4FC04D458
      4A88C723476525E731D5B685B32633B78E05191F4940E685151BF64C1713AC47
      7CAC1572CAF2E00295DE240A3200C8099A2FFD42B952736CAB8F2D976457E12B
      087073628B46C02D0002F64F454FD000BFED50974BD4C451BD5E3D913AAE2792
      0E608DF3D4E21E2E20EB055CB98164846122BC4B59AD8CEB31A71CE3FF9ECD4A
      1E0044CD068D91E620EC5688B002AF2CC6684E406E0345828BF4949575D45454
      A962553E9B6156B47D8EA681D827E0FF8881BF56FAF75CD5AEFE08EA4E921E15
      ADE2DC37091D93DB1FAD210FEAC2C2DCA78ACA6EFBE582D7BF8C3235099C43FA
      AB7A81FCF1838FAC6BE4855FE34FA400FC0C30574F9C5AF9D378BDF89D47DB2B
      4AAA555E2A8597908B21C8D0125E34412B059562C27D6578DB1CC03AD606688E
      424649FBA460CE46E9B8062431789C3D05250741562CD8ADC73CB564FB0A529C
      49B65F9B0575CB52410EA5B2A8325755AABB19D7AD657B12626550AE0987E1D1
      BCADC527803C816A2F74358C28F64BB1E2E51231C5D7B318C5C964D8CB6425F5
      E87B29260DFA26CF8410B01014BE1480EDAF32A59AE4E9F4651F415EA35DDDC0
      55BA2540A8AE6DE2E5A6477DA20BA099273176106958A23169B029B150975CDE
      4451ADA1F0222AD8CF596031D6F5C647D17A810E79C2339AFE581F4C2A6DCD8D
      42E4FE0B724EC8926835A05823A09ECD9734BF3DE8CFCB17E40AF70A5825F1E9
      B4CA118DF71C8DB1F84018FC035D68C71EA7A86B22C5BBE7AD4E54E1729853AA
      CD4572B7158FD628A64AF6C5184D053424C7495D908D41874D238A9BB7F40A93
      56994E793F4A75206010A0A859AD627C31CA258B51B648B0B0B9EC4B704C0E78
      D9FC011D648592789EB442E5D5FAE4E41231034E91AE9F528F71876AB42E2294
      E3B33826B18AEA3D2F90EC2B5FBFF535EF528049728B942A0D7A16E82DBA0FA7
      0C15D519EFDB364E5C53AA262B2E545991CC6DC5BDA77E53803D7B05521C1525
      083A26E7F2981CE1A0E21A13F871730A056A8F5085B29877D0A67D14C0D18F78
      038FFECF0285CA8B222F64572D93C8922B4185C6ECC5538EDEACAC375E2ABED0
      161EC97A85640D19C6D70A69A41B59A502156245D8C3C33D88D8D18CB5B5F51D
      C77FB14827E4ACFE1A4CF9DDC78FB8F9D874638C646FA4C6AADF6E511EE4B595
      E465224FAD3F9F5A670CE03F59976295AEB7C290EE12D81B8E337E1D8647A7FA
      DBF740B2D4FE7C88AE5022D7518947FBB5539AEF6E7A41BCB5D03D46734A4937
      A4D8F359D64356390CEAF8AB3AC9052222C51CAED5A06A20CBE84678151E2899
      82EA158B646A54D0F9A594074C37CABCA354E8D1D57BD71240C9E993E74FCC4B
      5E26A39ADCE09206895A869870E61C40D7E8286BA1CDBBC3A7595CD28749E5FC
      DDDC922915285E2B17EE5090F088CE0025D17AE13E894A9251E9B24518B1B108
      429F18F3C626EBCE40E864D0BD97D8F24073DE239845150B4BB92CB24FE17747
      FAB547E40E563DDE806EAFD09FA15DC9C01F015C53F676A03E5147A22DC6A714
      3BB2B01C5DF486C8C0A93466D187638500E54697C02591252360B4A930E4E819
      D88929050F012D43A94626D37AD9BE7D813E33A7D9B6011A5B689728A007D345
      0BDB5760F87A886F16513E9C6287F94A1729369250EAD8EE0826ADF0ED1DC374
      1E27E4E19D8848860071E8EAB6A5CA469F299D018AF21FA3AD295B448502DA12
      8B806250735DEA62C515AA39B8D3B3B0511C9E29D0262609A9131890A6F358F1
      678EE08209A0CC90F2C1BBB8786758416D2FCB919419B1B77B7A44517DD4E6FD
      3BAADC6DE23835C07E50318379D3B51AEDEF40F759B23408540FFD0DD452BE08
      F38204A6A0DEB0DE705738A51D114598C5E4E2FFF4FAE22BD0EFA1A6063A58A0
      A09AC9E0721A973C1FAFF058616BCC62C52CD4B14EA5EE42F25588D10414FA87
      3572E245A2F3E71611683B2C311EE33125C283DA8260CD0EEB89C14222EAA773
      42E7702EE279ADC2F8BB898F4C6AD71D483D78AF982B4D0FE653A02B44C4D150
      84F481E38528FD8632934AB1083563CF728975A5A38394FE88A60819FAA2D45A
      005F717B556D7CA69EB27F206C2B560EE0DB02CED69145368F5EC36F3C407A73
      BB83CDACC95A9CB41014BB312F4232B13E352A87952E727B9928B40994CA5C4A
      A0D0DA96AE6BAF068AACBF2F0055543F75BD5AD26CEBADB7BE421A97C268742F
      4855A9A678F8A8FFCAA9DC692A14463BBD3BC1E46163110BA7E6E6C0165E0CAD
      0597F0F8D1154194B7E6833DAF05088A8ABCBF089F0FFF097BF63390880FB3B7
      316CF41384F834AC1F30B753B08183B11B48968EF692AD09850CD624F1C8577D
      1E226AF3A08D1F7E6C5D22122E7104FA25C18294B03023D6EC568C66D829961C
      ADA9A4B4645E4EE3841BC3928B469AD3247532E9CA05FF59CE7D484F40440474
      261FCC6E62206B53947380512FA8EFC0BB808DCAF9C156475DF116EB98181496
      D0DFD40F4F8E34FBE2767F8ABB50AA1A6241FD263AEB9C6AEBCC4AF7A0D5F28B
      64A8649626BBA0FCF13EA786456D43AB55F0DC4973994CDF00BE06E019E7B661
      A44F748D721339988DE401294352AB9D9CC5C364AE74F88234D7464248C7D630
      17B990F451D231088968F1E0A4E482DCC621D6570169AD9CE9232D7D27F26A88
      5175D41F9C7A35FA943A68E8DE6EC383AAD5CF8E80823261BDDFADA5781393B1
      B791AEB50590082795CE5C4ED0DACFAD402A97F60FB16BF0DDC5A753F8E723B3
      A88FF1C8237FA02CB48B32009BCB391E2E1465BFDF0D151DCCA9A9D6E9C938F9
      458CAD5F7EF8F8DF5FBE6DD2FF6CF757A43ECA819AF74618FC8646CBC1EF0D71
      2DCC71D904E2B1EC04A1C0788238BEDB9A4E4DD536A14D954C0A10D785740B69
      0F1CB251E888237BDB02218495F8A3D85785FC0B4CAABE0FB0DC27BC68ABCD12
      4F3664FBA2745EDF7AB3DA30B9D3492F1B91CD79ACCE45537BD6F03D553D524A
      14E6BC15FDEDFA5C6C83188A5ABB6575E25D4A5CA3A850CE5828957190FEDF80
      594E44BEA3DC074CC14B4642ABB76D2A55FB5C57B78EA36D6CDB20FA5AADF1EA
      1A1EB241110156190B234E06604B25D6A6E2B62DEA9A8E7B90D17A6B15C71B96
      4A808517CBD177CE53BE7E1CA3410EF911331CF9C616EC22CFC11C929DA0FCE5
      2791AC7EB5B6C42B19234D8D94F8321A6AEBA3EEE4F7F8D9977FC79D44C565A4
      F6F1291230CF649852A126BE2E4817E7559A4FD742E174CA265540C647AC49DE
      DD7D7BC0F8288F06A75835298E9E4AFBCB29B95A9EC25D80A95987B21B2AB09B
      E22B393A6613F21CF7AD9B0BA78552521814102E26309B46769DC90890DD5EC4
      5225AC52F38F4280DAB18C2A0EC6D6F9D72F1F5185998AD02F17443831A47C17
      B49986FF8245DF7EE5005643C19F2D05278FC95352EEBC9E1E9054F8130ADDD9
      A07098912C6BEF9A74EE90E94CD3F7F5E4831A73204FD1467D3D1980AEB33F36
      BA1947E14A46F7FE18712362FAF696C3AB73B3814C1B3A92AE82239D0A944712
      1CE5659D70312A00BCEADD8D27F1C2129E208C9E1057B6F0158A32601E7D6AFD
      F8F6CBA9F2C97CF8FAE90820F7F705458707BB332B6113E66C676A515467BA2E
      2EC81A1C3A4882311723E430B58A83E61825C6017B4B8EDE7CBEB8F8E6E3E7CF
      5F75883F4C0F23334B91FEB5ED554C73D90BC5E1FDE59A908B2442ED686C1D5D
      A0EA8E5828F10ADD6822D2411E94648DC110BA48A5367E01DC54E19C513C89D0
      467DC2F9A30254AFA3DD1E5A0BDDF516FAEBAD0FAF6616B9EC653602CE4285D6
      A8FC7210981204CC499E4661B86E756980C49BBC8A5EBDC5F478D8B5E5342ED9
      544D4185AABA531B35145484EE7A9075A5B9A1046B8C152B96359CB20BE9B828
      81B2170748D6892C24AD6D151165B9C5BB93FDA68FDB97F2991E8AEFBD2B6B86
      31E741213AC4607FCE3ADF8320F1F5DD45FB9B8B8B775CF3E3B37B8A51F31E49
      5AC29FA80E53F8112B075C320F8858E3554900C04D416E51DD83124125379591
      8D98B31E53729662FD4ECC32A6C8CD48EED729161489E478F9ABB13431459CFB
      E23A8F6AC57B66D4082A1893689535ACE32F2A121D185E2D4894B9221B07906D
      622ED278DC38C182FE3899F3FF2407301D6D6F1850907B3A5D8C41AB46193589
      172A73AAD85D78ADE2E6DA8AE47297B209368017537631108363C38A21A6A5C7
      5315C4CB19C5C094C7C0F129483E8830DB93A32DA3023BFFFEF54F9F98955338
      8752486AC0687794A9E583B08B69EB13F4CB51C09BBF1815923338191F848D31
      D67981D9C8345B1402EA47E76E47DA1195A40D52CE4FC0B4BA6024212E512F55
      541D530C7D655EC63B019D46316C18486719F716567EC6C21D0CC3DAB3FCB299
      E6903B50243DE248400A64065AC45E7F9DAEB3F30D337536D5B1D923C2797B1E
      111BDEA9100940E76BF9C8122C097D8E877136CDE3ADB3F5FBE07C50422EFC2D
      908DC24E306139C157FE6D319BE791EC3A5F5EDE57081F3EB5909672F16E5AB5
      ACEC63D8608D0C8678927898E1BFC8A874923440D00E26BBED6773E386DD4CF5
      473C9596433CB35207D4454002496F648F117C028B2EE6B9B2B425A7858B98E9
      C0E30D5779EF6CBCF997FFFA55A7F983784F90C108FE88CCCA2A4B41EEA6AC8B
      A0C6D59D47E4FB4A3114B221329D29BCEBF37FA2EA9CADA738A6FB8639EDA65D
      11771C84F7CCA9A898BFA0F245AAEC65A426AC71F6F48655219CF5EA39D34597
      C7E4321B28B207D1C28452D78A0556D5DDB3184381CDC95FABE85F044E1EBF8B
      47100EBF8FE7BE585FD2FA0EA4AD77A98A919217A925D187B7F0E304F354BF4E
      75F83096EB4259F104CE5F96ED21707C28642C25A0EAE844B0D0A304C990F450
      9234BD51025CDF4A91C6141A929B3371C399A050336C0C9779D69CE2CE291BD7
      9C907204ED51014264CBD48D7265C218D377598FB5540984C463C54001F99754
      036719E7899740D0D13A8227465ABCF7927741CF020D91426FD146CF13C0C149
      1739FA24B0C024159780A358430E400B7D032B7160B20EC7B9AFCFB6E8A0006E
      05EA1027316A18C976A17966F7DA34C80B20CB2A7189E544DB968AC8A86B6270
      F08B9C846294C59EBF5CD54909140E4C6CEBCDF513C45583D2D2BA649636F0DF
      DD16F6972F422FE15C48D9DCA248621BB2E559B1D40810B3E2AC3598B9F680DA
      DC1B0F6D4EB9BDF43295951B22019AF73A3CC84651D8470E4A9AE9401F3616A8
      E24A8597ED4DBA09152837C46373A3CAF494D3AA01499EB9C606DF83C930ED3F
      2D2059A11B15794E60550D400BD2D8741BF0E3BF58EF88695C00BBC09E2B3FCA
      C6725E54B88B8E2EA8E3EE5FC5E812A3093346735F35D254D00096B65FFC2D40
      2090A274013C3A68A3B81CDA21914D638A05DE44204A51257D5C5652AF55ED59
      F5130F2B8E08C10DF3AE0319D98FE903EA4ED56C4FAE42224E4461FD138E5966
      EFA05F9A9FCABB0EB437F0786D9D890A8B00B9425A5C9089E71473CA74281742
      78229CE3EBE72D766E83A9B4319417946E9020126CF621EDD34D82790BFAC3A6
      0C7CDD6CC6C50AE9951B04329525847027A4D98BABE0CB102145C6F62889F251
      1B23D6C5C2A2CC55D80012CA304B8AC5B09D2FD82EA7D5A846227260C24402EC
      0B907951C6297D4431D760C3B5FA4A4DEDCBAC961FC5E42C1653B586284389EB
      D77CC61234C07235D30449F835ED0A7C78C37E52CF2278663FE0F45EBF69F03D
      13386A2A7019EFC21196B82AAAA132411F26D683C1009EE2D39CDE3DACD11E75
      DFA548FE52066611BD91741091281006EE7DFA5A327EE0C61806223192DA4500
      75FB56DEF216C7E5659C4AF09401B3BFBD4F78698085270B66BF09F28A245E4C
      A6A5930B54ADF07EEB98B3FA74DEFF0D279D0B85D5A0B192224842ABF6760D52
      CACB2CA857E1D97075A60B591069E6A2DFDC39F7F5A962981BD715EBCEAFAFE1
      D8CF687AA7861B329017517C9D6869642D6D0D517F99D7281B4D264CE6A98307
      91DC222CD1D60A2FAF2151EFA6117BE3C2CD6211D5E3C33CD06241BB4582E51B
      50469863340496E44B58C8500C047F3996CD44E010D20E499C5E27AF27323FB4
      58358F8A08CC15D1D2355F71D8FD7813464FE4D5DF61ECF122C4BDC6BE4244E5
      92BC702BB1D3D2BB6A9559A53188D603F3521D7E4BA0914ABE76481532743395
      DCAF445504C3AB8C4B07C4138114B781094584788AF1AF8D4E90D7704FD9EB56
      04A7E47FEC79A3329F72E83CD8AC0C63EBF8FF67EF5DBBDB469234E1EF3EC7FF
      01ABB3E7B5342DCB2400DEDC3B334796E42A6DC9979154553D6FB9CE9E049090
      D0220936404A56CDF47FDF2722320190A2445076DB422F7BA66489C425333232
      6E19F1C43B55001448A88D17CCD8D74613F02BBF0AB08B1CED193A1649A955D9
      99EB0AFD8C015996201BA3DB9C34467B9BBCCC9524B7063E3604E52C15407015
      849CD2ACDF8434E6C866C1610BA2A97C816015B0218A33601F411D68B14D6887
      D51562F6756AF1F98551CBF8799A6403A183E89CA4478DDEBA26676BD708DFA2
      B8319F2572AC6EEB8B73390F98F3DC1C03B14CE802F4BE427895DE58E172D2F8
      3611C595EBF1860F5AF84C9F7A41383FEAE164D779AF3FCF72D818E0A11F92E9
      8FB360971247C9BEDA255503559F693A1D51177A93C8728796F7C1AF2F1C9A15
      BE118111DF24E328BDB1CB60D3ADFFEB1321FF12041553F713033E1B123B8BF3
      5B9859EDD45A1E3F26333F2B9E6CEC399F5E04BD4FD89A7F5FB2C071F2D2EBD2
      2AF4DC35561A73FB6BC8F302AB4F3FD3BD35D67E489359C60074FFB76181D5F5
      C3D83CCE4BF8BDDCDBE492FE2271360770FA9496B48695594802CC8B0E9ECABF
      69F397D38363C36B63026E041EC54ECC85895AEA4AD7BF0242339B8D3910AFF2
      865247842348C34E1B1BD464FFC68971F28694C833851283524827DC7EA7E255
      5AC295792A19275F834879A5F967A36862D484E11659F31A84B4B7E53ABB26CF
      E354ABE14B761942EE3EC0313D36FEE59182A84F0EB0A12D0146394754644689
      AC099394108E1B49C4E7CFAC867DE91C0D479C4890EDFFFC229FD3BC15D9E2FC
      2781651ABB506086E191CCA68CF899E7A62F5999639F8E2F52EED33423BCCC39
      FEB47CB9B19D562E931C4418887E2C8A48838D3DB4885FBAF242127E73952216
      39CCF63F587A2CB640F09AA739129E28726ACB48C4D6210385952F34C25DC281
      167769ADCE08362ACD3BF25A254349B3554E4000A194DF442D3F6C605E72B418
      54960764DE6F52A15253FDB9D997AB130D8D90CCF428616A56C9BDD99E6596C4
      1C1B165982D42200631EB2AB428C68E9299CB8CE0EA0BB0DFF72BBE7847BA59B
      B827BFD51C7E15BBF0B7CFBFCB8944897C3C2D3707C3E51A69C0ED6ED6EB1243
      F55E1C4CC8684365040D986605A2DA42FB14D388A61C6A52C9B0980C29779803
      C6863AABA391F4429B618C37F31903EE2F2D6A8AA6EA6CA4C6621D2F0EA0F65C
      0D16AC2D8CB07601297C11C9157DBFE7BC151B4024555E397BBF36CDCF929C8B
      83CAB16B78A845E23A0B07CE7134D64771B00BAB9F3325E84474364EA6B71BD1
      5503A5872BB03055EC07729B36E195B92D5CA5CFEA1DC70474B6E5F08CF7D275
      A21640CC9794DEED54223874707609A2AD711C4B68A832CEDCC2C5430F25A3D9
      C8AC2B36CBA51A9AAC1E537561BE9AC39830DD90EABFD89A1845DF225323B509
      272D0B272D170B4F289CF4FCD999E58E97CC55A1E12A0B5F9F885FF7000FADDE
      2396C9E6458FD185454CA76818C9C7EDDCEF4A72354C57083E822D0FCAE42CFE
      09725D9D62C4845BA59908C634990E8BC2D8ED2AA4D74E014CBDB00036A57364
      D24CC18021BB005C9E288A1D4C173086821A519726552EAE6D8CC02FCC933FF4
      1DEC87D56B5A2C9B295D34C165CE4FA247367865CE4972CBD214C2745A102C5F
      02946169C1D939D2B292C57F19862C5A5582E02174C0786E0DF835224A8BAC9F
      B93708320F2727562A3B1A455BA2ECD98812805E524648401588264859109D4B
      1C656F803EB52A94FEC18B746C135FA7D46EC5BEA8B297B843AB36484ED0119A
      BDEDCA80CA627BF639166F9DD80EA5F7CB00628B4996B27D9D0AAA467E99CDC6
      574E9E7EBDDE33D581117D2A4D741E9AD6D7E0E38DB17EFF710FADC1382D4B8A
      698BE8D1640A0D99DE6C2CF779E77B05B516DD703DE636B0AF6C3FD8F9FE7A77
      BA1081DD570EE3E60E3679CD3A42AED5D818D1CB8C68F7E91BD1501323E9B6AE
      C61CC9281B480A7E37588CDB4412401755A6801B6D799C85FF648B1066DE74C6
      79CB6FF438B91897DFA6541742C16992AE974914E97123ED0026169BF805CCD9
      BDC4B299B8D2BAED9276B7A5DECE6E6563334DE45EA18C2D8C6D2E856C96FD59
      D1C5B8ECA5509383DE615B2504F641206155A9F8002B6D54F1FDA50613DB012C
      D2E04EB170180B99719AE72C9B22CB7C837EBDB20B89D1C95B87F354FDA5A0EA
      3258EC12D3D422C604B71CD81FE53ADC5AEC5CE21C9AA68622233AADF532AD0D
      5E9BD8F83C2E0E40C77CD6C0D5FC7C50C0F8B7250FD4C1F3AB16232C9BE6B6DE
      BBD8A3A95DA6C3A224100E4B8E2D3C9BC8F9C2CD985AB3EF48EF4690B0689C2B
      E782C6789161DB74F0227CA346E94C4EE42913A27E658B9E9A1477DA0F2D7B8E
      20142A5B6B72F2445AC19999EFB3C8534C8AFE073C3CCAE8294AC484965CE7C4
      74DA48A99A528A3B260FC97E50F49303B67816F697363DAE36A5DCF788A11564
      BB4FB408645536ABBF872A76FF6E8D82AD716EF2B1693CB9910CD0FCD29832DF
      29CEF879E86B9D25E07ACECBE1DCEFA96D24F83F6A3F20973A5945C862BB45B3
      722EBD98184450BBA3D96271F9C8234BE8E46498A6745E6B8059921205F87EBE
      2C796FFA79D0EEE267BBEFB9F8C7EDF97DFCE375BB3EFEF13BFD16FEE9F803BA
      A4EBB7E9929EE7D2257DD7F7E56EBA040CDEE3C7B40603BAA8DD1EB4E8AAB68B
      EBE85FAFE7F3757EB7D3FDC7323C66FF8F073CDE779C37F4FF8B0B7CDFF5B8F8
      C071F6EB5E7EB0112D4538800DF46283D9DD5E6DB94C1B60C3FEDF94FDD7E07B
      FAFFBA97CBFFEA6F1367B353E6A10E71D7EA2AD15B8682A47E4D5C81B96DE1C2
      CA00BAF3AFCE7C009DF71A1F937F736CF9E7CFB6456FEF7CFBBED5E977C0D2DF
      36D607A68B45FFC613965218732029761B659C89DDC468937396D1C68B78E0B0
      AE6821C08EE3F92676710778A274ABA72AD81540FEBB277E99B6259594926BAA
      924D878674CDE49B636AA35C853330CF81E7FFBE0E882AF9E3AF6849A97C7FAD
      B446F3A2323DE34AEB896D3046A787062BC1E032D1C5C69F170C82B90A1491DE
      14DDA4988A12B81B6E1A64AAD8B234AD9F89786E694C91F72244C7E3E360C965
      328CF0A65D87A806B726177C0479FD8BBCF89862203221EEB55D41305F079AEE
      3C3501294C3E9CD5680D5A64A55EE95BE99937CB37E7404BCF81BCA77E0E443D
      F5DE93A2F977667DDE96A362F350A787A2BFC3535AD9D5F39A0EFFF48B9D120B
      8FF939356F464763D3D08C40995F172BF5F2DFAC88C46FC55CF1FB2F4B9A4A34
      6AC20712333E4C6FC6AF257A6DE77CCFAA127196CD7A6334DDAF9E2DD479488A
      4EE43FE3A472A47C3C4FCE1A8EFEFF2BA694801EBE23F3E9E7C92B6251679BF2
      2E769C5706A75D98B7F8D2AACA1DD1D04C68D3C934330504F914E644A15B050E
      CEC470EB0746795CFB51540EE7789CEB6C4A235879F73D430CA8B04385252ABF
      382D766CCB2BC82A2564364CFD961F39D6379CDA5679446E596DCBD98E1662D3
      F571D564EE11F5D8593501BA687297BC1B41B1AA0223A70A180A08D261BE3354
      811EE677E4C4464C54FD900AA1B64B08581BE749AA3ED95C036599DA7C3B0C9B
      B328085D4512A8ED79C22CFF25885C19F12561F611265725E17531263CAE6C5D
      19CCF47662103749414B2D545E9491D8CECB794ADA9B0BD6375BAFF6D6BBAC81
      D87FC1CE759ECEB2502AE0B9097C984C195F9F414E2D12A041F3DFFAED100EE7
      EFD2011D0C64CFB75ED1C922E1056DC0B3EF1C7D9A026CC1535E24E0F61C0585
      DA3B052509C0262B31DB161165E910B328253491092977528C9023F584DCE7D8
      9CA32AE7E0E8E4C4E63C2BE7D7D3934367755BF4E7CFA84AF4F4E8ED69792B3D
      68C73656D30466ADB2DBB9200936AC651F4AC0BACB5C2CD5EA9762669AB22DF2
      3974D902C222B2D51902476EA86AB242F2656F2FC6969B2D50BF5D11F91514EA
      A2235F5B993F1C16D91FB6A6884A7F09B3A4188D4DBC5F9DA96E608EA877E354
      70C3B60BA19E5038C7B444DDE11E990B13D8C8C57B095B8162170A6E845525A4
      67EB8EB7468B642AC1D5A1D1A7B7CE36A90B81AF2CF2B00474DF624A9010C852
      46EA3CF86987913549C495B89973BDB344B1EBE85BBA8B0D65E1ADE3F15F21F2
      B95B565E5DA38DEE7D904C35B45C9592CE760133620DEEC5620983E848D1747B
      C992E446732E6BC2E57491F48DB10556EF0BC55F7413E4C74ED342A17067AFBF
      4A7EB4BD74FB5F0BB5623FB21949CA227A97DD628BA70A5E2EC3CBC2BDE082C9
      30E446791775A8BA9A8AA99DDE24D371F2790D88F34951F6952C1E004D615A48
      C30DCDB0563C9F0F0191046F6217898C2102AE346D1AC59B508C349B4D6D76A8
      0C6DC79AB302C8606DACF59C20CEF7A4974A47478CFA564FCB96B2E58A1A5D2E
      4B229DAC190DB4349AC4BBC3D7F591917F954ECAAFE5D46A75C337D3188339F1
      FD8773C7E03AABF16DD9AB53A042D9821B196CC5F2B0CB2CAAFC956465C7DB4D
      BBBE1AB2C858FDE182DBE46C0B1A1BFEBCC9124A46DCD9785177A977974A5B65
      03D5B9446CDB5D85C16CEF277BE15F596BA4F6BE7B5F6947A34A14F0125FC78E
      524BAE28B726B998CB0A2D60BCE7B694B1F5D745045A4A9B6B45DD3659CC9067
      642B72EF8E67EED5A6230BD8E08211F3A98C26C946A2CC4C1F432E0A09998471
      45CC191C61D25332921ABA36994E6D75B8793863D45F24B61149789926D25376
      EB3F756EDBA86EB11ED87A9F161FAC4B3213EF288BB1EEF66FB1145B4A832AB8
      D30A62184F73BBB23CF304E7B22673DBDD61EC4097D5ABAED02B96B61C92E919
      B366805CAC0F86395CB43A77B9B9E55C8C8376DD5AB24E4EEA3843623E6C31D7
      726BD7748D189AA1A4D213259916DEB0C9BA30B336AB686FA8216998C12B3B18
      035AA0AB00659A2E9BE5AB726BCCD9ABEE2EA6A5BC405AFC62BCA403E3258973
      3FEF63E191073FD188C41B53CE6438BB48C655E21715BEA3D9B0DAE764A38BEF
      D7265C71681C03EADE4872E4E8EC64A370E7EDDB42B54D19577EC153599DA4C8
      BBBD30D1FFCDF99F6FDFBE954E4010FCA3891CD6954ED148706F62384DE55DFF
      EB5FF9B6BDA29D5A0C8F6CBED3C434A5BD0033767CD78D5AB3EDD4824DBD3199
      BFEB363DD5DC7C7CE58559B991A1443696F3D2AA4E8A9B137EB155660577E778
      2A778D80C35D84E12AE7770F069BC414BB4F9E3EE17D5723C36D35D0AEE35582
      993C5A320B21C3285D8AED016E4D5A846C9C9C4AED0820920AEB628251A8984D
      623F32CB671BC8983ACCFD831EEB0C96D21F9AB35CB1BE6C0212FB7D78BFFFAE
      48496A8A38F8C292850AC5EE2B5A78F936F9FC910C4F6CE071A8BF79A5C6ABAF
      5DA65167CEEFD3EF3C6B1292DF63E252DB405BE1FF9D85FE6E33AE4A208314EA
      5C8880A2C4B5CA498244F4A11E3853A74E2B65E8B191F48D3628F9DCF7707474
      F62E893740C0B5D2D0866A226709EFB9F2A1483E539B160395D0A6214DB5DE87
      19D920EFFEF6F27727BF1D05E9D0A479CC837C874266F1E6EA375C358B43F19C
      0C06DE04CC2D6124039A24A76BB9934FD3AC6C2C5A6492B14739990C136DFA97
      0AF6078657C253B1FF3852B726C258A7E936B5FACD2E528A51CE83B3D0D0A884
      A780E636C61D8D234CD9940B5478C5ED6AB23D675BCE8A4C6A9B89139AC13B1C
      38228F97ABF6C6E9D4B672ABA4C2E9CF8AD37BE40B7BA7A4DDD03B130A809560
      0D707905F0441E587451AC97AA64D157ECD9BDC0BD30D6BCB551890908373E4B
      094EA506256D443ED2BB361D51D8C42EB7B4375F5C60CE0DC4864AC68CFB5015
      9CF4F591214475F92980002BFCC8B2065FAAA695A750B8995C06ADC679519C4E
      89BEE65831BAB3D6B67DE5221EEF3AC56C34B9EA61266FA7628E861E352859ED
      392E1B05548992EB249AC125B23B82BBCACDBF422EAEDE5E2CC29207EC092F94
      5B11CF0BCB5DAAE499DB15B01EC32E3BF26C83E22B903C8AD3A2EEBCA3581B7E
      9680E96AAEC5E0A2B4F9679879D41061F5633DCF9F1D33B249620BE90A2637E9
      A7E0F35D532757ED9F6B091795D28A5A095317825950DD2B36695CE709713525
      F4727E2CE7E2B6E4C8BA0A86CA895C721E9F2F05453347CD94466DD0E2D430C3
      8EB815ECE4EAFB9DBBB5E263394597B39D3CCDEA1CF533FFDF96C9B8463960D5
      309B9D8DE1B15AA352B28804331D0948BC2579FA23566D9378B600693A4FABAD
      42C0DB984E49385B675CA22726D46BF3F37A804454FB25C85E0C53626C192384
      FE9D75C91CA22F7D23D562D5CCCEB9C5A52FDE49EBDD3F39EDCDF6A8517C5FAE
      2959E4ABE5BB41CA2BD3AE72232137BBA9D46CE755FBBDC0DFE1E0E4E256BAB1
      0ABB3C77ADA4B4E505791F486F33A55C45F7E1AAA523B87673E87F12B9254384
      01814C07E4B931992C367BC89A5A6347ABF0B2185E1D6B8087C033B8F3129AE0
      4683D52FF58CE1A4B05F6332E7D8522932E736F8DC05C50E97D207E6F22C1163
      39D3EC4884EC0065C4D326304427014A60E4A43E1957EF3A7B7B7B525B39A264
      C10B6ACE7D516E6AE3996FE553FAE4B7E285BFF3F18CBDA5C08B19A7A690CA7E
      63FCC65A4128BCF8C2805DB45BD857B0FA4D3A849491D1E8ADB90EAEB980499F
      57A7656588E9A0112AA9F02C5C57DBF98302FA6BD7A3311CB534E23467CA5C57
      960ADEFFE26A502CA04C3FC744AE75362DBB4BD351727E0B7F7344399D1B31B1
      FA28468DF44932BE725E396F3FF85410437F6D844289BC59218B4DE3A18DF4D6
      3F3BB2F66C320E87B3680DDE3F363EB44D0BCA39FF99953518196F948429F36A
      09B128C1D6CCCB2C44EE0C6C3EB850A33A7188DD8544C632EDDAA45C2577621E
      ECB9923F5FB0CAC33D08B63EAAE9E51623091913812C14F3A52DB92239523FBD
      9C44AE1D46B44BE2505584F11263879AFEA592FD4FADB7E74ABDE69D834A6E7F
      6178D5C994279B4CA8A06C60693DC9579C96CFF50217D4F9E2CC81198DB88152
      CFE5B83CB04A616A3502CDB0AC3FE03E861BC157F70CDA0681ABF14AB19CCA20
      759C7CDE7420AC8AC421654E3A92F1C0799C4B2956D1D32315E9023A6B91E074
      F05F235788AC0153E506EEBF582B29E4782C9966A132CDCA725DA4A19B045B6A
      027B53CDB8998D69A41763CE52383E7FC7516A8E235A048FCAF754893A838F33
      5E43ACEDCB316312427CD260927C549A5495C23A131D2747D0609A83E48685E6
      C27BCB68BBEBE4A989D752E1900996D45015776328373615DDC4771603C1066D
      7A09CE00268355A3BC76C64F2FA1044C4153311B13760E6EA907AB89E8B4CA7A
      1DD8A57415574963E24924D3FF3A142FA4AAD07A0BB49C65D4FF756B0959CD34
      C7758E516EE489B9F3CBBBFD43E76346D6EC940FBD62A1DDD6D9349B85D32D72
      2BB6F61914125FD90FF97C4E52A4469A769CC99EA228B37402AEF59C5D42E3A7
      D9654132CDA87649F6AFA0CA69492E63214E875E6BD4331D4FAD193467351026
      0D4D78C7390BB36462044365F6D5D0C2CFC7CEF6CA170550778475C3471904DB
      9FA98B17E31704EEB20969AF16DB3FB3D54676509A1D1F3236E3505D8864539C
      20884DC919EC1B5557D11BE747679D5767B0F58D41FEEAED875ED7393A3C3EB7
      6C5F291820FD5282E6ECDA3291A2ADCD244BD2CC140884930FA6BE620DC3B138
      0295637C5B49259A95DF4E2274CC766D0693D92262067A415B6150AB5B07430B
      E0F97BCE1BAA4C9DCE3B1E72245CB093C435A83586E84869BA2D02D5843A38F2
      9E95C490A025F7A3DA2A4A4D6C08D15E553F1775BF7084A86D1ADC2A86395510
      3C7690940A7F439D09EC4A8145CAB56262168E8D25E52221392EC1D9A1E5DB54
      9D0265520262C72F52521ECC7D47C44D19A71CF620F83F9AC05CAE02C74BB067
      3702AFDE2185645584A60C0CFEE32B2639E54F832B3792AE0A6E2E8E64699549
      1186C4EDEFA12344E062C25E72DF7893AF99B5877D582B531053FF9AB98265C6
      94A4D954CAD6B749536077AE7C482419463BD5A044B9E5E7EAE4CBACFFD5BCBC
      9108AB5584188F549D47584ADBA4D24F3F908D8A2525402509BB95A1A56D024E
      DA75F60F7E3C9578FEAE73B2FF1E977DFCE1D45CFC7EFF9777743B3FF13A5185
      3D9B3230E3F64E25D2C3EDD7C816DED9089E8A892514DBB58854A52751EF9C90
      5C8DF9F5244A6337FAC5BA564296A6C09C6EA2A8E51ABEA32922B6F65451492C
      ADCAB8925632D5B97D2155CAA5EC67FDC9F9BCEBDCAE85653E574953A208E65A
      6574904AE5D3959270993C55ED26928434572D2FF68C4418458ED0719245B0D8
      6126E6B0E3EA437C3E869A7FAD0928C4E96C1C99F8AAF4AA1A6B3604C9805927
      305EB000A76D2D7A944B379F2D1DB49B70DEB1AC0F0D06AAD2F3C54FC52B9C6D
      3EB686B430008C7C5235BCB5F6EC7C6B50ACBE00ABED96D6DD3DEB65EEA8557E
      701700A1B27844AB6AA048490D0D0DA37E6C4C9A7C19B7FA21D927659E255F73
      495762DEB7CBC5DC1C1EC1EEC2BA2536B86DC238CC851866A68BC011DDF7B8A0
      B9545953CC89B8A48C974BE202471BAA5CC0945FF90622C037EF46C22AE27B74
      221969385A9BAAF31A7113DBEED344E10AD107362E778B641FDB8DB951EFA5E3
      2BF2E541C132D65AE4B76908CA35AD15721B1CCC42AA48DC23DAADAA5C0E6615
      5FF063AB3DCC28BC95094495C5782C4B404D6314EA5632E6F460515BE278F3A9
      1B8B2A91412C72E480A32AD483D985719DE6020975729FEB0491CDCC3924518A
      E092A85122391323DBE2A5FCCA0A5F39B7A8DC2D7603ABB4229BCCC2DD508844
      8849F757E84C4A89D3896ECCC93343C99BFEA8BB659EBA98147185867CA1CD7C
      66BAD10D642CD037D47C25132C30633454F7540D2AAE46CD85B5B39177AB0D5D
      7BF053363AA6138225AD7F6165531694CDC3CFF9A0614687AA2630B9118355AB
      7E19090BF9B4CD395E7440068B7798E40421347F04676423088DADCD999114E7
      BD4B7431D34CECA6DAE994A4ACD4698C05F5AE5A1A42499A45D9489D7826C936
      6E5034979059A77AA302874CB90F066849E5E2376485A92B2043E55CC8B435E8
      E378F90FAC13CA6055F94483FD3F975761EB3DCAC6969C548B27507592A26BF6
      9CED3752DB4F97A83968E44A895C4929316245371954807928A91B8C62564701
      D4AFF5A214E1C48AE6855356B04F126A63075F68CE0D29B27DD4D25D4DDF881B
      572ADBAAAAE619122D467236443E06E94A5368C40A2EADAAA6B9AC1CAB40160A
      1377EFCB47AE6A6BB32836F799936C625D8396F27678A3949A4E76047195683A
      A989A3BE5B95CC1D3BDE1AF9D21BED510BFC854C902D4BC64B49DA5E9628B6A9
      E35D5A4E6309580D1BD6A4A42D2FBB64E0593DB6C065F61113451D2674A8C804
      AE53BF3EE5160E1465CE8B677122F02565D719F92F1270B13C7EAE84CE82E39B
      035318CF52D1587AEE9CC9B0D95F2BD7E4E4C3E10F5858636F6FB68EA5CB2F2A
      E30E03429865B967867223B256E8247D7C45B95F3A4FC7FF63C376ABC87B76C9
      890EA9580E9334319E60849D3DA2232B2E0587DD96661BABBFD2B2806B35F2D2
      B0A9937B27070B4664D38943CC65DC59369B907DB2B00A260170BBB037290AFC
      5EBD9FB3BA940DCE93F648C633DE101135909194846A954AE5C5DC1FE4A63E0E
      F8D2F9CA748AE4416211270D29B7CE5624CD3311A5C6983F4BCCF4357BAD526E
      DCD598DE1BD7D07277D9FA2E535BB2A460B68470CCDE90819D474A5240B8364E
      207163C5B92192B7013D6BEEA7210929AC816BB425DC3DF151928B31C328A802
      64AC487CA49C1FC99481CF37E5CEAF54B847D704597A25A6F8D8382E7BCE7FA6
      3351C2577C92129007C87925371B0DBBFA3C24CD180680CB9ADF71C6E5EA68FA
      ABB2C78DDCC29BF6F4E731719034F0D91F269C66E7FCC7CF67E79B03E0B973B7
      8594E0852214226589E2C1A9AEB46F6641F5E88F458A25F5C9D9B9F3AFCE69E1
      DC09EDAF73FAEAE00C5F11768D16F3BAFADD097D77929A140BFE66E7EEB1B49C
      33C1B586A96D5146D8DC4DE21AF335D3309DB52B27D3158633B9B2F31C65EFB8
      A7A5057D66186ED36CADB6BBBA3F9940F44A8A32575E5AA8F04A49C366AF56AA
      E12AFD771752E7CBF6F272066BE1BB53692E9806E9677384526DE2CBA6C23019
      E1573A1D4ECA6286D5C03AF21AFB709602E3FBDBBD3BBC5DA0408D90B120A384
      2FBA57B4BDAE775E3E77C653848E64DEBBF6D8C3265D1872DC417ADABD07A65E
      E55705E0D442950AD953EABA68C0E66C9F59EB214AF210EC49BD7DCD2D652D4B
      7D0BCE1CD78934B398F9E130CD4DDDDD3F785AD50909987B3A5DC884336FAD4E
      CE2C09466943D96433E50C42B06B3319055BCBDCCD059536B786525588655EE4
      4E9D00E3671DCED64969E1C1C9602869440650D45E534472EE4C2C27F2D101DB
      CC00F1DB7C23F6638D61B8D895801EB391F6ABBD58263E5BCF0D14EFFF78204E
      D024D470CA34A5A5086EE571FC2EC9695F6D2B4D09D5AF9DE39B807EF933F6B3
      5C427F910C7D4D8751B812DF9CA5D954BECC5F3B6FD27448FECBBF3AE7D4E0F9
      CFDF1CE1F3F933B6DE0C1A3E3CCC490D042D4A32720233F48985085DD2B09A7F
      9965636E825D1EB3E420813965295A5C70430E936AF51D7056972C6FBE64598B
      853B3FE3F5CCBFCF92618C92606041B92D19A9FCCF8C91CF3A79027B54536F69
      CEB88D127AE6140DE91FEA84D2A6C429B873F561523ED723B510B1DF3A4BAC5C
      B9371A668780C96E2B83B4C58B677EFFFA6B5543AEFE438092D720CAD138FA72
      927CE54A81058855B257C8683227B774566B53F9A5FD8113CC828040CFB94EF3
      928B97B4B197E95997B30B4DE7A1132D513E4E92A1CB5F8975C3B9BF5C980D11
      43B59F6BE15C5647BB1A3F3FB9228B29C96BB4FC2CD5E3F4F3A0DDC5CF76DF73
      F18FDBF3FBF8C7EB767DFCE377FA2DFCD3F1077449D76FD3253DCFA54BFAAEEF
      CBDD740974708F1FD31A0CE8A2767BD0A2ABDA2EAEA37FBD9ECFD7F9DD4EF71F
      AB9331FB7F3C975FAB6C711DEFBBD4A994D7F20638B0DD9CFF5CF711018997FA
      EF7BF50A3E73FDCBABC2AB1CEA4EEDD139D44DB2FEC5343E49F407779BF7DD16
      5E2636653986FA0F8D13CE225C6714A5787ADCA4F538AA7D75E5DA8D415B5111
      B06EB8B7C81145E30F2E757875928657DFDEB0A9AF2A591FFD0394E55D4AFC3C
      1E7E175AC0C85BD0925192733680E90313D2E848AF495897D3B016CA218A54B2
      3213CC74093401A09C813CF27478CD4FA6C327CA8CBA49B8FE5750246CFF1B9B
      2D47BDAA4A88A349256DF47B9407FC9A66C3E86CA242BDEBBCA04CA6DF3EFEFE
      62579CA9EF61ECA5DF9F0EAB85A610AABDDB598F54FF5823907491E2CAC04CB3
      CB584920DFB9B77EEC86E69DD3BC4D7D13E544FE5A7CF8DD78D398D754C4FA0B
      1D427F2F597AA776E61B4DFCBD22E080EF337513D2307806E0902BC10A1BAA8B
      9CC0CF098C9DBB7F4AB8958B23E61262A92ACB341AF84E71C3D6D7891BFAFDC5
      0D6C2387F02F387278A5B94999D7FD0A74FF55E2C463C97E9702EE9537797BEE
      9EFBEF86CCFFF589E2197414C1F4FE3419424919A23B8B5CB4C03FB539985F8D
      71CC0F88C7197BCEA71741EFD354057F5FB2E471F2D2EBD24AF4DC35D61E73FB
      6BC8F3C2C2C071C3BD35B861487B611913D0FDDFE6CCABC64613D33D72AE4DDF
      578A44A5D1F1384E0F67A389F3F9ECC8C038160EF7535AE27AE56D45B38683F3
      C3FDB230AAC1F321885BC94BE7D908CA1C81297ABBCEDBF7BF48A15265ED9A38
      5593D108E1B2D76AE2F83F77FD396CC5460D5ED2B4E15CB071C77DDB398F9963
      FC34339389DAC4B995E7640D9E04B53CB6C5E05F61FCEE9AD6A3BB6C58AE93AE
      54BC6DDF7FBCE6E59BEBAADE64787DCFE92D3FE6C96860387F95F21C3846A69D
      6D68C39B5F43F17ED5F5AD814D05F57374F6D1AA1F5BD8A6C3CBB1452616DF91
      8FFD8FCE4E9EA271B1B11F572EF46F6F3FF8BF3B3F50575BCA003E7EFFF68394
      2E3EC1E55C8D5C4500A895923F6A8BA5A49A3ED39224E91C1CF0816D13A74743
      2FF1BC4CBDED53132D1BD5B18EEAA0A37E5A572B660589408CB42155C31D9E1C
      EC3A1FB856164296BF599D1520B71E9DBD7B825CBE91C9AB653263BAB260B6CE
      FDC7A3D39F9EE062D6512FDE2BF8B3BF0B1496C8AC264EE4689CD3E194B29171
      2E6B62C4BC7464138A1908B1C9B109297C85ECC92833F986502061D85E48E903
      8527D2283215468D9CDFF36787E6002FBA1DAB5112C2449F11F00E66AE8791AD
      CE9462B022814539239D114EC0841A88EE39BF126601355D9ABE4C4C09B31A72
      59588D01CCBF2F899D3F74969A3E81DC6D53E5399DC0A762730FE5808F736728
      CDAC284431A03966649566C4160188528C095183928A13AA31A14B05260A06BB
      2D43555C73C763A2166BF0626299BDBD9A52D5D2B17E8AD6FD4A6ABF39DB2778
      BBEBD65EA789C3A700C17738897F99E396EF705856E6B032034E941CAD134261
      722DF9308C411D2463550767E3D64922420581B76A5A035A602DC63E04FF2B4E
      D594E7EF3987F4C1A5A2926B7685705F381BB2F6951AA877871DC9843B7F9B52
      7F91611264D5A4CBCDF9D4E3CEA7E8F8A9BD397E5A66AA769EBAA9FAFCD96F67
      674762AB1EB0C284DB7D309C05B6158EB34D6E8B716F7676C98A20F0A38A1F4B
      7685757FC013DF3C4DE05FF6C230FC1EC91724949E20D7D7714FB8E3C4EFCE96
      34A99A7297376A58BCBA226E9A6FD97321A9172D0ADB9A4583C2AF3193D99F0E
      29ED6BD258DB5F0281F851C12169E23CCEAE6EB3A44EAF41E79753E99942DD8F
      66539FFE3642EB35A17429695E48BEF82FA7A4A8F6F467CECF038DCA0F76E913
      2D35778266F6127675E73AA3CF5FC6A98FDF0ACBA6918CF1FC59D133F635392C
      FD97111C40B82097FAB38A7498105CB94988342DD7A8383E4BAF13E918E96CBD
      A120ECA9E441161D596CFEE3963843A6BFA379902D2AE40C4B7E0AE151AC0E00
      3793C023580149598D0C9215C72ED2D196F8344F46C910C3A712E25D0B593A4C
      C22B53616FAAEF15178C17EDA93923645CE483378C305BA79A12C12C8824B53A
      5B9CB7ED2CC79F334ADF448D0B40F691140756FC6D356E242DB60ED2D184315A
      CC41E3725214901291F3E656BAB46357D5C99ACDA93752D16FB2D2B2D464DE48
      3BA0DB492395C2F36754C12C2D50FE1BA6CBCE3B3579A7327836F9DEF4B3943B
      975FFEC74CE7D3734C55BE04D370D393F154C04D19BF5360750CB811CBFD1076
      3A9C43AEF09786BBC478E4E9C8554DA45B629BB4DFED30D8C4E95C1B1036C2C2
      B608D9114BCE51F2876AECB4C64526498D8D20732E03D6FB1F8F39B6C239BACC
      C87FCDA951FC3889A1664614034ED410BF0ED348E2289B78C717C73B36D18E65
      D18EEE538F76FCC65EAF7818CE99001BB3414B5696F11D1AEACFCACCCE8E1AEE
      FD192F565C3AC72F17A579537940F70AC8372315DA12B426CEF05E755C8336FF
      1CFA7AA34BBF5897B6F7BC8D365DA64D7B1B6DBAD1425F3C95D9347ED92F0E73
      E8AC669AA9713E5453CEA3104425E301BF0C27AFE5FA301D8D48960F391DD386
      3F9BB9985B67538AB04CD3DAC1A726CE72B5A7BFD1515FA0A3361EDF521DD57F
      EA3AEAF9B37F7E339CD34D8B83CCAAA8BF18A63714231A69CA8A69E4DC8A73DA
      B79CDB582024CBB271A6118586699620408367FAFC995947FA69D6525DA74994
      3B17724ACF882199869B453365D0EA1921CFD1F9BD3976CB746CCEF0F25D76CB
      20C48C8166D213A1EE46142E6404538198265CC10903071148BC68448A8E6FF4
      C697EB8D4D5ED452BD3178EA7AA3943BFB8C3DFDF1CDD13E6B903A998B8D3CC5
      FE273B2AFAE5DDFE2105A5584EEAD1647A6B500B9B3899CF461FD07CACB67B73
      B65FE4D636794EE03BC376A3F4DA02DA428B539F13CAF9E5467B43586A79A826
      9A545F13670B5162753AA52C7DF0E4AF8D8AFD7215DBDAA8D8252AD65BBEC64F
      48C50AD26CE30FEFA5E66A04E995DD3A43ADAE9A398BD5F6014DB3023A4E95E6
      9CF07D78BC7FD2C829F38CB8DB99CD03CAD21937286EE2745474AD386FEC5D1A
      310040EEC45A51D25D13671365EAE2FF8BE094B2BE343D4BA57AA7486C33996E
      5B73218F040B789D44332A1A22B0BA264E3E4EA942906B9818CD9B23F5D8691F
      9A9B9D5E1E9936BEC8F6F9B37232DC8FC1A48FD3A917A55D98B314B9E0F5D654
      E7D3BD89223635E196226C4529EA8CDB49A98BFE7F73FE224CC3FF86B1B8633A
      46E1D14DA49158672ACFD330E13A555B9A4AA4F90E3591FFB24749FD58856F5E
      16B9FBDDA6EBFF3F34DD38F5BEC76CBF17D836263CBEFE2E1386F8D1E3BCA9A2
      9BAB16611F391FB20B354EFEA07E3BED5D8E85BB3B1403E776590955D33308BF
      291CAE15F55B7660FEED8B215F8E52338DD7FFCBFC425AE6DFBE7E7D6413D73F
      E6AE3EDFA528FF6FB324BCA2FEBCD4B96E9884D3EFB0798D01C250FD5C56D3C4
      351C7F2754850FAFBF070877294AB8224C3A69A7B3E984BA08A4435B7F4DF6A3
      892FDAC342EA0B3C9A859786E9A5741BF25B8D269071DF5C306D81807B7B9F3E
      41FA16C2F7D327D8CBF9A74FB60A39720EC1876A3CC554B696E0AE7F79EF81C6
      717B790E25CE5F0D9E81E77B9944264A4328FF8281A1C2696A716B9A4909A2C2
      613A7E31E543812176059D77E734CDF3D3A32393C406DE298EBEED49B6A3A999
      AA2E207A9C3053F96533D3D9EE6409ECD24CEF64B6BDFC37833A875F8A2AFF86
      1E9E9829FFAAD5241DBFDACF4669F66A7F349A8D4DAAE984CEC4F24BADA7CDE4
      6C99DE9B0F87E7AFF0C365AFA2C6462F5B96F36167811F1FFC5587267E443D1C
      C824E58E6E24FFADF5E170CB9A990038349664C7F6CCFAF0C39BFFED5C826EC3
      865A356642A6C6FE12FC4C9A9D02984EA4279ACA2AC6F664BE52C4BB39387CF4
      C1616BCFDB24752E3D395C8EBBFA844E0E9F3F4BF27CA69DEEE075A5212E43E2
      19B367011690CBBE633A3660934092DD1CB51A65841E43CF2B60FB0891D8A282
      3752D908E5DA3E486772061318539FB9E6DD74C095A6E146067D206469688E51
      23676B39A5DD750913C6602B38593A150F498D2F86A425B3911A9A436809C61B
      678A8E5F98A5C605BE02B92C3B4DA4C5653ABDD2B779159DA48418313825DBDF
      C1B33EA29DFAED83212FD9164AB2D12E65CC4ED47709E4FEE93B048178CD0938
      74ED60FEF3AFD08FF6E5779BF1381DEBEF733CF1EDA79C8C21ACA68D1453CF9F
      5DA6C3C839BB4CE2A941D0CDA74AD24EC476A348D855322117669A52F99A955E
      B80E4EEE36F939F0F333C8B7E92C34A018722B6CD99CBA7A42A553B5974009EB
      FC6A4A8906F022FF5928C68100A2CC879F1E94F78C094D684B09816083A81363
      40113C32C7900AA5B93A9F8B9F4680C40D6E79A53F13F08F5E32FF7C0EE892C1
      9CD5B54A863639A3C1D0813274D31F1723BDE523306AF46EF2A2C010E28B72C1
      14D4A58930E7CE36158F04B78EF12A1AB97F0EA6D9F04F0784D34D6DBB096CCD
      794F791C347CEE093C4C26418A69EC3A4779883F535348E3FC4215A3B2959A38
      F1E7CFAAC570063BDD6E628A9B1ACF299AC1668ED530B7AD5908CE5930D66D03
      653E5BA092AC466E0003FD25293B9A6192043071178C3D4A9D17FB0CCAB7FC32
      4AEE79D1C459DF939325F85235984710305E535C56FA9B3032A4CD8CDAE66DF5
      EBCE6EA595B0F3264B6F723A75DF1F4EFFF4D66BA4B878FEAC60804A47E5204D
      AF462ABB32FAD3E426BE16E1D2DEDBEBD8033C555CBAEB1015EC7717A913A8F0
      AA8914A9946EC434450BCDFEEBE9C92161898A7E81EF3C4E6F769D17E9F84545
      653471C2772B35B7038D39C3E8AEC33E09E1B35DAABC88297090A2995185A26C
      D5A6332A3A9E21EC4E581463A851D8088A4BE8F22175B490E2544885C95013AA
      ACD13AB7E92C2BBA2926B1E97CD168829CDEAD373793DDFEF5FCC7D35D3EB4D8
      E5BE3ABB7282335193DB6C96F3FED9757ED0D3A36B8816EE6B50B49B05E58A4A
      BDF7EAFA1DD73B3BDBD34B35BE6275FDD7747C13F59ACD4B5273C934D9B64431
      CCB14373A4E35EE9B07BF2CBC90FCEF6C5300DD490BFC207EFF79CF34BCD0D0E
      5F4C098458837482647CF0139D0D4FA95D8B491A3715D1F4AC29DF244121C9CB
      654C45DC56A9866E1441899CBE25E75F4E7F38C4AC037B8A943AA7476FC186DC
      3250CCFBE6B677A23C09CA0EE05CBE4CAA053E9E1CBA9509631D3FD660C1FD83
      9F20B1384C4A79D8CD2406A54ABCF9787E68250ED91EA6482248A35B4A2B9A4A
      BE04011CE1CAF7CEB8A93CCE933DD5F880F35C0E8E4E4E783BB3F5712195304A
      0E7EF81C356E6CE306918FFE2BD35ECE2406F13CAB96D787B767E715B5E36CB3
      ABF6E22CE1CC2F6399BEB05E3FD96771BCB33950FE0A07CA1BB487A507CAEE53
      3F50D6F9C4B498324D9129511CB224D0719A416CE4A366E68A99C34FAFFB9A3A
      E7E653F8970E3463160F4D4F0218921799CE732E9B0BE5FC934239C394BCB989
      0DF33571EEC5D1AFD77BED880722301085450005486D85A7D4F6881C97DC393E
      7F4725BC1CF885CA9C031B1A6B823A0DF1F5B8A1394652F04AA991AC10FA545D
      98B1A193FF6D46D962410606D1534B971A242E496792092E120E044828901E6D
      316219743F87F3B2A7F79CDFFEE7C7647A364D27BF37918ECF9F7150E730181E
      70BE653A9E6F9F22A914D855EA8222A82AA07494216D367D4DB418DEB295CACE
      456A1A904A93865113C9C1FE43D175C2148873AFEE9B32F223FD5FD8FA8AA485
      67439D7B825D1155413BC6EA895B4AAC0FA704B71F5ECA89E4F4D21C16B1659D
      DB34FD8EF8AD6480135C6A71031F2E190691D87B33E9734F5079D7F9F99833A7
      B27458ED6090BF76F6F39C64CE488DB15FB25DFB776043C5BCD91A1A2B36F10C
      513F7F39F8FF4F9D6D3DB6C9697FD0C96B71BEF8EF3BF3BE2A39E78D9FF2C777
      C767463634782E124F80F00AF294CB0EA8CC7B5831245E3BEF3E1CBED9C5CFB3
      C35DE7ED0F3FECF3CF33FA797ED6E099CF4CFBF29383F3F7732E2555B2E9A8A2
      E77F3EFBE9A3B1979BBC530B85656AE56005D63283C018D7DA51C344D1D93093
      C7814140828EC47F9349226663056FD336B4FE48A1B2E66EEE22DAFCE2503CD8
      17A663FAA5E6629A8AC9F2E2A5DBF67B7EDFEBFAFDBD16FDEF05593881E606C7
      2CE9C0281479324548F2208A34C3EFFACBC1C9AFA5B06822A9168E78B628E4F4
      E9D3072E34710202CDC9B76C8E7479B253A3685AA293FF14E73E8646D556F3F6
      A44652C7491670978CA6CECE2FF541C5E6AFAA056C02865C6C2AF08E99A548BC
      8F3F9C9E564C32FCC86693A2BFA39A5E5E6404CECB223157D70D0D0ACC4D7989
      907FF7C3D15B665DB24745B8FDE5E4C341F3E55931E9AD9FC7B31CFFDAAC85BF
      9C1D1D6E4182674D8DF39435C33241C92E985FD6F71F0FFECFEE92B3E9BDCD39
      C0573807D840522E3D07F09EFA39C0F36706ED39D3D7AFDE63D5DE69EE874CC1
      1993CE311B63B7EC393FC3C05131197930FFD80A643648A573ADA938A0234745
      C5665952D95A4F89275652E44C13C6301320D37F9B2519615DAEEEE3CC65648C
      151471ED31A469B4D7CC3314E1088535A51C9C7B3AE3F0A25307A4F8B6001D78
      417E7122C5747C384D8CD34C1A70086EBFC2D994200C91A725E35332A01BC9DF
      5BFF7B369A706FA0B4B0EDC4AE7991DB12C8493A994D1855A191533C1A53B8FD
      9509BB73C12CCC5529F834450B8D9CD7497A219B8B3218AE7576932518FA9872
      3DBC776F1A39A5E7CF7EFB7C0886A4DE635335A46A146DDBC267142BA60C1E0A
      365C66E9ECE2123A893EF8680F71B13F2F1585A1B89E279FAAD164CF399E3A23
      8E67049AAAA2E2D990AE9BD2519F835D2B20296C22369564063E031F5DE5561D
      57203AA5DA9BF0FF291857B66EDC733E9A4005FE3BF8892B3DF83C934FE21A49
      0C22450D8A2D66103D90A92A279A8CF77CFE4ECAEAE9A8E6D620D3EE7C4B7FE1
      4B3C84AF801DB5D254B2A75EAF9F20EB7C7FE3DF7FEAC6FFFB5234484CB79122
      E0FD3D453DDBC9982A1BA5A4F1623654649F4F486DD0D73B8D9D6BF55879FBFC
      4405305023F2C4779DF303AA4E3BC17CDEA49F9B39C3E7CFCE0C479AC4341512
      74234C008EC45948073923E702E03FBD65454606BAB8A490E9F05A34FE36FA90
      2ADA9A498D53730E9BDF8EA7EAB3730949322469421E7A5614E619AF64A3990A
      BA51EBBC7CA3959669A5CE53D74ABFA82C914EBDC91F8455303505FC741CC16D
      101A1A52F830636025393C2CE7B5F2BEB989376FDAC7128B6FBB9D5DFCE8D28F
      01FDE83BDBF4E346E5CE16250672211DD1666B636297D47B97E4E1468E2D9363
      DDA72EC79E3F3B204C85511A257142B5F30C46399AA8691224C304EE395B3441
      8A1F871A934C9CBF1CB1CBFE9723CF62B9E684E59AA7B38CF0082809B3913240
      22CA6F54AEDFD37C8AF8449E3AB3712E111EE955C8569FC19BA356EDB390FAF9
      984388664EFECDED54EFD3E49CA11E5F60B15717318C292C934B8E4DD7778264
      9A6F8E29BFC231A53BD81C532E93A5BDA72E4B7925211648745C2726017D9426
      233506459CBF3F7FF65F9F18F9F2533C8CC81BFAAF4FFF42BF5246DB371FACF3
      E37F7E3C3A3D397EFF93B375399D4EF2D7AF5E1563DD8BF475A2C684EFB5076D
      F00AFFBE3AD7798706FDF21853CC5FFADDDEC0EDF507DDADBBD86D759B58B43A
      BD41DF75EF8E9E0843791F4C2DDCDA6A45AD70A0556F100F0215EA76BB1FF6DD
      564BA956CB0FD4A015B4DC96FCCF937FF48AEB07BE5CD7EDB75A3DDFFC87BF7B
      B8DFC3556E2CFF7523FC47FF0ECCEFA04E57E39AB6BC8AFE73F17717F7773BB8
      BF6BAE35D7D173E977B029FFCED77AE699917947F57BFCDDB1CFA2B1E0DFE7CF
      E82F7EC3C05C853BFD41E5495AAEA6CF3D7C8F6DD9F2301D0FD778AEF9BD6FFE
      EECACC7B834EBFDF8E7D2F6847BDD8EFABD8058D3A518835707B5D4347D0ACA3
      0299E8DFFF8E9506BF66F9705D7E9D0D3F85B1FB558CCD2F62564CE1530E3745
      0419FD4632447F6E7D9243C5DB5EABFF294ED3A9F9354C87F967FA458FA3F1A5
      CE34DF4DB7509619493F7E9AC8AE70F8298FA7E3E0AFB588F34FDFD5C5665E52
      A9663226AC5A652B9B231DA6241FB74F4D7DD2FEE9BBFD5DE7FD2F67C7BBCEBB
      1A4CF0E1D0DD254C890FCD8C9819D21C5D83CDC880A4F02F63BA3917546343C7
      7FC787921946290AC3E40FBA42EA961A3CDFB7F7653332A4880DF24B73A7A2D3
      6413E76B4A5C5BBEF31A93A6AAB494A0B808D4049E03953533625F3E72B6E997
      8BCB349FEEF059727142DCD0408A2DEFEDF731F543E906C24160F21309DBD399
      28EAF8910E6723388FC9945031E1496176D41B947B64908030C588CE7634E3D4
      2DE55C2A4147C934CC2B86BE0B66173B842983EB13EA1E42011A89CE48EF3045
      89968DA662BB3D00192DACD5259F87AB28A23D02D2E6B9F39793D393A2C8D3B4
      AF248859497D93C36022519A6BB996BB974225C23CCDB8927E9C5CD488EE191C
      1E9B5B7E7CFEAEE1746D81AE7C0E558148E4D258864ECC4DCF5AC8E4243255C4
      F99EB33FCCD35D36F3B716EFDDA22008E17888146B24753E54725A4C33323AD1
      22AE620C26E8EF295582F2DE9234CA4043239147DCC8091B51E5967BEC404DE0
      4C1698F326517B2C98A35C8BCFB5458C4D50C34C911AFC28A1301299A3E0A143
      6D8E81F9F1DC0681F72465BCE4D4C391603C891337F1E54D0A47BDC048FFA907
      46E68FCB29AF8BCDA1C2E2E3103375988B88921395C3E475B6A827D89673A56F
      A1D79B690C51224405BFD5C25237762E732AEE9B067B9FB880DA9CE4DF2B9C06
      4F5F381DD07957C66EC64D321CB27D633397B5430EDB674C9CF3B6E0CB91FD93
      F185ABCDE6644AB845D79AFB3DA698E8AD012909F465326EA6503316B4DB210B
      DAC29F9A6A6BE96DC73055546842B84E8D9C63E127B86DF6134CBB21032794C6
      CE29EC5ECAF690C6958C17CCFE280CBCD3A29D51D1AC80235E43752B6765529F
      44D6B3F867FC753A869FF69E9BC9F193CBA6487F393839B57ED73C7D19FFA286
      0DDAF02568BD6AB7299A50129636A82D7996C61A45B597B4CAAAAEC2304DAF66
      13279A71948D6BBF22C3B48CA745384FDC676336CEF43069AC82B69E6D0FA47A
      237D564DE2DDCFB62D2B79F187A6DEA420504E40F94D9E30B96FE2BA3A5B064C
      53C2CA5BE086A1B5BF9AEAA396210B1245FBBF540BDBE730F318D90A62835D56
      C953D873CE24724C0B3F82B480FE51435BF4C6D284048F497518DEDA4DA2392E
      0D759E377A2BB4486AFCC221760256343413F14BDE38FD7574F68E7111F69C37
      2ABCBAE0E861D9B27058C3F64B4689C1DAE3B6DEF8B7C02734E4E4B2AE4612B2
      60BE568FB5BD44EB95F3B799CEA7562919258819654AD0188DDC89337541181B
      52C20FCD1768DB061D4AE961DE6C72E593A55917343BE2C38EB96264D3CD9180
      2C05888EB72E9DF98CD5F58881E3F7E0516073FE4CF94474589644ABD57C5689
      D4919BADE3987237AFB1AD8BFD4D117289DF092454C3094C26E80763A8137D85
      2D2DDBE50E28FF1FFCD1BE0180A20A297B7A5016F1ED3987B251E9386AD73263
      C275C2840698FCA1A39286067C5602818450D148225A12521CFC9734013DCE6F
      27DAF48A818D4B07309389866BB6E7BC1382E4490D69F887D8BB95CDBB090F38
      3F8D697733553641822541027F79FEDE930A12586FC4C386F9994FA8EF1C1F89
      654199A246C6EF5A61614D0FA83AF818292319BF665FE4802A8062F12B8BE043
      60FBAF404B520B91A99C6F165DE07828D410AD99D90F56F6B0E1CE606585F96A
      526E059AD5E0B429585317638860D3F50E26EB8BA921468DCD27C80FFCC43D7B
      861AA53A674AE71C9CB9D4F3AFB679CD463FF35F580439A34929AA83F530050F
      1B31B729035829DF1AD3BABDDD269B6A8B7CA1D9C4F0FF969C8907E96708B0F0
      32CD248C15A453EABA477D3B20BE1A2988D4759A10F89F786984F71D123E20E5
      2859E310F23775188E20D2C1EC82C280DFB4F2E79F37CBBDBFC9725F262A9E7C
      538EE7CF7E255D3DA5B4AB6B6AB448DE3A6BC484CE38A66A6CBAB36A38A154EF
      0C09C16DE46C8F5E3193CA2ED1A469F11BBE5343E7BDFE3C63C7ED6CAAD5881D
      D6FC32356D40600D1DB2F257F995A302EA91C4C330EA1A7268366A24A46F8196
      F2D17455DB968C481BDEDB29DA4491092987E723685B1B82116B910861C1040E
      E104A7E320CDC6CEE1C94113696228B245786FC64C748E0FB796A58F9A186813
      67794EB333794005C6D5D294209EB1ED4BD0C4A9EE9B8242120E72F05569E28D
      0FCDE9DAFF72FAADD6651327C8E7849A4F57A85DE13001C786E9905DC371641B
      ABDADC57A80A88D1667728DF9A6F5E56A0B54915690DB1370E1332ADC4B1353D
      7A4FF6DF1F4AFF4D261B7E392EF6C5B634829FEF00BFB3E77C18575AD71AD43F
      4638148B63D7F4884EFEF827680B7F6CFB8C2EEDE741861637C736593A1B5BF5
      2BD8AABD8DADBACC566D0070ACB1227E36D90251A286299F9B4E6F27A6FB8F60
      C2B7F7FA4F708D57CEF0A4060DA48248BF8AB42926D2CE6C1AF74DE11145C532
      35CE8765759629BED815289F5B96BEA39180C642B65202E7D934E3ED01FA995C
      4E8259356725D394609F4CA3862652D5C0EB42A58851F2AA3817C9AF92490EBA
      4411AC31D35A612363BF868CED6E64EC3219FBE4F1F94AA4CF0F87E7243E608B
      B0211C39DBD32C9D0594EFC8E1FD437533BE98D192AE7AE69ECE1BEEC8BF2D9A
      3A52CFB0FD832393E42E30224132E1BE55ECD49AA389630E9394482C990AB5B3
      98DD237DE84CD805D65E5125B9E491527757661B48C4A5C130AAFB266F8FFB16
      6252F44B25BD9E21F838EFA6823A079761D122DEF4545E575CAFBC6A993CEF6C
      E4F93279FEE491ED0A11063F937A6772F21635313FFE7878661B888A1C7B820B
      5C37AC28604F8747D492DD64A7ED9F1CFCE86C9347B075A805D589A5091D7441
      876D355B21B176AE74B2CC19713ED3DC00D8E096E21A9776B1A031E0E7076931
      44EACB6A228ADEA58CE64007E9F09A1C41766822714A5EB07A65B569F2FC1961
      577096D3D8A1866B2589887558D9F08E51D796AC42A72612A8E01ED92E0181D3
      5718E19D3455FBC80EF4B66DC709BAB002F077388383F2548AD444EA49312E43
      F6CEA5CAB905FA5CACAA5124FA8DA1DA6D7C6194E49C1BC48DD89ADE6FED5EB8
      8EB38F47270DEE30F9910B4C5F060C5E570651F35B58CA23DECE5BFB9309B856
      AA56B70495629BB3201C755D2313C6147ACE999DD4539CDA8F4ED3462A922D83
      0E20D468E40CF621E16FFFD0D4A1446641C70259A6C753ACB53960CDBF06D492
      5B776A66C8EEB211BB4EBAD2646DFBFEE36D56BEB9AED19A0CAF87CBB398F831
      4FC4763DBBBACD92913331A7E8C3F46B1C947ED5D55C0DC2110C936B0AC49ECE
      C654962632E86396520644465322BCBD7A308298FCB707127CFDEAD5CDCDCDDE
      98123946699433265B6A66F58A3E79E5B7FB5DAF266EE093420DECB9CB5103AB
      8881BD5EF91FA3FD6983E647F71854BF0255D037B87DCB5001E93FBCAF1B1ADC
      3F8B2C68F0FEE6D009ED736283FFD726D44046FC232440EF0923FEADE4AF7578
      0AE305CF3F1180BF66C3FB6D2225ABF39DE5149EAA259524EEE7A993C6D4EC8C
      3BD78EEA20048D67EC4A916FB4F5814ED2B6C84B178BF30D159053A2C3AB4C2B
      8C2F20F481C2E9C29C769D33FD374698DB85551316C045BB8E9E867B8DB433DF
      CE86D4606D4266F815814E493C3C73ECA102476ACE3731DCAF70E4E66F42B4CB
      044F0340FB17D21AA8A4C881378E6D825D120DC99D658FDDE4DCEE4D3F73862E
      237248C3BDD479F3E1EC8C8159391868C1899E2047D48DE39978C535951C7319
      4FD9398F18FF3F7E3E3B6FF0EC0E8E4E4E9C1B4587792C8A089C6E36E1A063A0
      0998AF483AACF46D69E27CCBA02307A84729D7CE0DF5850A6F9DD3F7FBEFCCC9
      26055FFF6C58DAA084996FA48B3AC5AFF1F31DFDFCF568FFE32E47F8A1408FCF
      9A9C106DBB6D2D9FA409CBD520B2A1D57C0C7736CE55AC25C83FB92D910C6C0C
      8B91584991886069A485F1DBDB0FDEEFCEFB940FB14CCEE9E1F1FE8943E80F93
      46066CB1658AAEA12205B3C5DEA1D22B5C5D44E9704850B178A213662AA76A27
      6A8B6DCA32B86C83A3A1C6AC3D3C3968244908ACC2D92AA1BDB64C8F6CEA7143
      8841C6E6361DC1F9C8264EEBE07D90924D6253F242463F19ED8D549B45223161
      4EC1DCB92D8D07F0CBE7AE6F42E28D5CFF1F53B84E07E7A727EC45B031245E85
      01E2A0AE47B425E2D2DFD8F8145FC1A7F0363EC5329FE2C937AF29AC2E631048
      56B44559A39D22C1F5EA9909D67C4457E7AF37A7264BD7BC19A726272485C4A2
      CC779D6392F8BBCED944C350F82A4D2CBFED010A66F17A7E12BBCE8F5A71C46C
      8ADFDFAAF06B95FE7CDB899DAA50BF767E544986591CDDEACA22356C2607D23A
      4F67CD1BFAA9963A89E68D9C2A191CEABADDBCA1FF64BDFB74FCDAD9CF466906
      6757AB0905BAF747A3749736FDC6EC68A2D9C1460739AEAFE0C0D6F0BE7E87E5
      49714D9D51DA21D9F23F1F9E8A0B26F849D48CDDB9516CE9C23AC973752186BE
      60A042CBA9EB7702B2F70439A66E10C8067EEFB8F9F9DEC6146BB029F6FCD99B
      8F87E7DC6FDA968ADC829F6DDD5E24716D89DE30F005F7F281933E9E0A932731
      57454F9DA1A25A1BD8E6CE7699B02D4F63DF971EF435C277DFDCB883D7394D08
      DD51C0B08BA9D5A02D664FB7826C91FEFC8F8F9C7F5BD2D0F186A30CD0E53C50
      78B9F83CF3664E2D9F32372FAC7A702B5F3474664508AED04A0CF837BEE250FB
      61728DC94DD3EC29C6D937C6CD1AD58070DDDEFEC5995CA6634D9579376CAF98
      D35889BB9BD4EA4AAD4593ED133984A823926717F97C723953808EA879D76F0B
      9146505943568BD474DC46A4E8D23FCB75C302D4DC4840C6F69FCEC40E84D0A7
      FAC7180E04C1853491B0052F1D300148EA65D3977A2C6D1219F9981A51E0176A
      7A7076F41F72CCB14D35A504072DA71FC5B18EB42151549E11EA6652A42C5313
      112A850A9CA5DF54B07F292639A8C10C3FEEDB0A0CDE15B6EE44400C2FD570A8
      0960C9805CD039EF2185C0DE81FF6FE948AFC1D439B4AD41F9CCD69CE1EE8A6C
      50D23BD6E0F1CE8915AEC831B54B8D9CFDFB942BF6B899804C6D8BF6F6151943
      37044F4B7F494B07CC77AB9173B4C7B55C3687214B8D37C1895864A964CC18E5
      544716953D121B35C9E7CF4C79D1DB6448AA9F34D981397697BA14EA0434D502
      3A2C476BB2EAB1DC90C36921E016E1025AF64946CD603FFC44057753A192B956
      E8B4CBB0C5023020C08C06DA98DB107F4EA61603F92253A35D816BBCF332135D
      A177E9ECBAA1B8F76F939597F0B42B40663670D464E1712600E4261EC6CEC55C
      E4ED1557FC11ABFD9F617AC1E982B349CA9DCF9AD9CB560CD05142BDDA6063D6
      D894B29B78B7C15E7A41A88CE3C8E687C4E930A2B652C706CBB4C89828B60747
      63A45F70D1B25A304C090484F6193F9AF151B8361057F01BF879F49A5D67329B
      725EC9B89A9A92A5E9D4BCDFF80DF64BAC8E0E67537E1A1B7B78F8B6AD1FDAC3
      97BB0E96F517F94D4FC30D70F157C9707037190ECBBCF127DF85D614079E49A1
      6723A51A35612DFBD648BA16C45213A722E5C4B0EE02C69A67F45BC219213699
      122428355748B366F68F3CD5233D0A20B027696EFA6342D2532C4F53B62909F0
      91E2CE4F8DB5624B802BC9AD33FDD4D8723FBB4CE2E99F0E83E1C13009AF1A39
      BDDFF687C3DF9D5FB35BEDBC51F9A5737199E664045A10F3ED3BC5AB2E8BAFD6
      A28A8AFDDA63B763F2968EC973FE654FE7933D1EC9234B671F2F3C77687F1AA7
      414249DC403319D7C9986D288BFFB67F72F2BBF3F6E4EC9C316E1C1ABA24FDCE
      1FAC3478724787C7878EE24E7179095A5D1C8235726645A4B45A11C9028AF246
      0C0F0F2BDF95C0A8CA7035F5E3B3FA695A82A336921C86182F87AFED91B04368
      AEA490C84077724C37BC1454F694FB9C0888F61C49E05ED429666DA6735C4539
      622F39C9F342D49B4839C7502BD574AFA8E48E2BEED85936D5049ABA33C48592
      201A34922212699514AB7769F4135C9FE3771F0E6DC4D936A3A0E8C8B5CA1893
      B26C45DBE0197F3C3974E741D216BA6D0BBCD504262BF6516327FA8A2BA0A435
      A69C9E573BACAD46FC001DB2985AEAC6C9E7BDAF9222FCEDC960E324F6AC32BD
      A17CD4CB6462995CCA69B1DA5478D9CCA52EE778364E6F6E9D1BAD18ABBB5A15
      967CAE661CEC67D3CB519A669B50D1D70815B5079B50D1B250D1E0A9878A9E3F
      4BCADAB8C50C4BDA271279E143553E5325C06A934CB6D9385F61E36CC0E0976D
      9C4E03FAE4BEA526EEB3E9FB5F784B507DEC486557D84894A560B1CD93D88966
      13F89A9CCA2375D7D853D7D4569BBA5C7109DA13E48095F38FD996E0BA6A898B
      0DD3F48A2B4EA70EE14D9AAEEC4DEE58B64518012419059027DF2A9AAA5CA6B3
      6154B198A581382FB69EAA64E85C27B4D139D44BEE38677515E6E346607E89C0
      DCA0AD2F15980D68BC1B718B0C27A45039D5DD2BDB08CF1C03DB1A16DE3C3797
      74CE7B990E3950C1E5ED7F9D8D2606424C4D1B8CCA7B4774B27CA1694E747665
      052765B4D1648FC674FAFE314DC68D441E17DFFB8C7D6F81ABA4588A7CFA27F3
      F9479AF6914CFB9CA64D995E0498AD1CEEF811C1659558659D36E8C36191416F
      A19EF89DC462053206A79136919E94F637B78928113883757E5B85FDD0AC9E6E
      9C74A2C98CA7801D47851D75A192866225C9B649C62F19C8DF4E083B443ADA0F
      6F9D90C2353CDB30A56E8D53CB72140266A32B219D4233A6ECE90BCAFA5121D5
      F7DF48A35F2DDF8D09E77F888F4DBBC6665A68EFB81F8ED4CFD511CF4424B9E7
      D4F4CF21AB45EA504C1C943A1DFD2A1587AF6DCB34FD19C44FA83B981AEE5A77
      91E919E2CE4D0B9A2FB479DCBDCEDE066964A9C9D38006E21471C50ECA739D4D
      97F51708F139A547DC3D53D86C982FD830EDCD8659B6611AD0C5F4CDEC828E29
      5E3BF130559C673321CB9715BACA925CFA76926933A444F0AD78F6C71FB75B7B
      CEF9659273F54FA6733AD3A53D4515220B8F013D029DC903CC23296441A9AAFA
      6F3335644C4D1802E9EC82ED815BC726E91B1F65988CA817A86436A9309C6584
      D588BF8D5DB6ED3BC1ED54EF2CBE98CF9BF23DE78D24BE728A3975B9A302E650
      CAB80CB8DACA33A9D5FE05BD3A172FC9842A025DCC50A62D612AFE642371BE82
      C469FDFB77A2E272BF7F6D2A7ADDF94D6D6908A2310DEB00BBAF8CA79D6AD97F
      C6EF975C83BDBDBDAD6F48BB2FA1D65700BFAF0318442E08C3A24B3A8A161803
      B0DB585D271792A632CDB4E638C9CB7F73EE23ABA16A8D1CCE25F78B8892C827
      9CA561F125649D6D8C15688A7F9290B34199B8CE81138949EA9745217335BEE5
      43F62C892A3D4019F561446B44922B34204A91048AE83578C60E55FAF05F2CA7
      B94AD491BFA44533C7DF59EED6A6046B112A5CC8753C1BDA3A22F61C47E0A904
      3E25394533CA9399DA4A34D814636E162D9E965114F16C3ACBF42E370653430C
      F5468D397B460D6FD46D4E4EEB35CD59993300DBEAD4D9D67B177B18411D4A82
      F26F3F781F05A116CAE5964C4DF8B5F4C518CF22CA0ED564C2179AF533093C25
      7E8699D0AE630B6847EA8A3CBECCD4658D531BA7CBB43C9E9C3DE2039B46577D
      3C856DE815F40C71D4D9E0A549566A5517B33A83FB3657506EAF7A7268B504DF
      3F7D7FFCFE87D7DF3CB1F4F9B332D0472B50D9508AEB8F7226A42C876C3F5E09
      5314C77530305E57BF8635BC7474249F5ECAD9B07657B2DB3831C2BC85177896
      333B27B9FD940EB0381050F4EAE52D4077477AA2C7915A649BB1967E057C1DB5
      DD6591419963BC6BF10DF89495A5D9A1D4F047184E24CC342DE831B7AD79F04A
      EAF12C4423CC2E8809B2B76E6BEFEC7D6CC15D99A4DD682BEF2156E6533A2268
      32B44D0EB981C550652417A388EB11D50D2CAA2D6E83572139BE37E54FD4477E
      36A1DFFC1FDEC886C866D21E7036A6E41BE574FD00D4B163034FFCCA19F31B7F
      F0CBAD336FAFE51CFDE5E3D1E9F1BBA3F7E7FB271BE7709973D880F6EBB2E98C
      B1423E174569F9382597B6DF0B092CBBC61B343D4C4724C04614D8148FABC61B
      2BC60E7E52A10E81C146D07F625E40426CC99F21976F1BB9B9C55240D176BEE5
      8C435C1D92D084DF350B6D79F7242534AB84302A602168534243E5CFC686D83A
      E0468C747871C485FE5B4517F046A6E9819EC638E260FDB822ED207AAA386F85
      99324AF3A9C5E135FD778DB33FD26A5CB1C258E4E6BA56A49B0F0572F28D6F48
      2C57F3358AE7454944A5B1FCC52D97AEE67A183BDB54CD443C3076CAFAD37CB4
      EB1C9C95802D9C476D3C6F7B3813580D40D384AD76CC051645DB01FA42E01E44
      49D97536B04F02DF6F7528ABA197E354FA6260F8B437475A14363F972DCEEAC3
      69671341C166759A35A5AB4B5D98A5254D8CAD79582F58812BAD27B2C434B67C
      676EFC547A5D99C065425BB53A059EC1F9DCFC4DDF6639C47AC9977FFCE1F450
      7C14ADB221754C328CD4C82C13AA742C666BDB5124111B6FC9E8AB41B07EF379
      BD995D50CA2D9FCF499CCB64CF84976912DA4283400B988B85381323B089F33D
      BFAC2179B4F3F3585016584318849772FD8D14131BF9231D3D66CEFEC18FA7CE
      6FD2B0B0EDFF4E9BE5480AEB3F2A168BA5557A863BCD77675C8209EA7F98B05E
      E1724CB9C118AA78CD9EF34322014F63964FE49536C1892094B8D4037B5456CA
      08A968772EBC589CC04AE9807800BCBEB682FF26CD86D1EE57096F72883689CB
      F0EC8476BF2043669A9D5A622FA2AF54AA08888ED4A47256412192F1203EE98C
      ACC6B58E5643D5EBF9652D0663ED4021F062DDB8E08F8C29A990633D6C29B92B
      CA63985C0920C396F4E5715E1C570D1F39397EE19CB2FE2E0D15274A1B5B2C75
      5E648CF044447C11DD28F3F32677AA094D7C8E00379EB2758CA329B486794D52
      3CE48402834DC67BC75C1A69F321919F9D73E1DD7048356A12AAE117837385EB
      2BF037972A1236665C9CB24073E32D3EDA5B7437C7EDCB1DC427DFA5F4F9B31F
      28467666816AB67F787776BE23DB90762D433A594555A3C4331D52F22F253347
      148A3FE284A3E3C35D0E5C8BA1D248C1B66FB2A28CCE3BD517626817187B5C12
      227462675A1C5DE5BCA58345B9792368BE82A0F9A687864FFCE0EBBC1A9A3527
      3E5C943A527F4D33A69D3529D43099DE9A93954A34286087830ED94DCE1B1E68
      72D488B7472318B21B0DF9C58CDBDEDBC0422DD58F0D68A62B388CF6002A4E32
      0A0AD1494C992602DD065B957D06B6E89FE052D740ECB1D3548E4B6EE0FC1439
      4B580D39B488414D15B5F86AE23C29745440998475527CA7FA22CD6E9DAD1F93
      08CE1B055CDEA591F30395A56DD95699F062026D4031D9F26922699E3FE3EE29
      B6F129266ACD3707DAE43DD989B20528547BA1A79510147D3696C3566C00C538
      1765DBE92612A3008E9E9000923EB01FD5F4120B9F34B3346F1F2BC229085BB3
      31E1028FB71C13D427D799C35B9271674A49E8F4DA18FFDC0FA489733EB39188
      3A99062666B03DCB0D823C73FAAEB5F2A7A9935F25935D3ADF3055A9BBCEDEDE
      8EA9BA09AB59481C5EDC3A2B82145BBBC55FEFD3B196B3AEAD633ACD999683DC
      6A22895544F90A34FF99A4FA481184ADDBB55544691C27219DDB19F89B264E55
      C2F3AF2BBA3264FD7893A5945861419161C29669595CD461F44D0D93DEC6AB92
      8C040F8567EDC994B27CB8CD396042DF1D662473EE663C00E145FBC2C6111906
      A2CE0833687AA3D55579A8A929EB25C94746E54A565505962C1CD247C5015B13
      A76E14705CB05772E7C073EBCD2C195622CD50B872C24BE2C3D9C666CC9DBFCD
      E8E8423981645DE3B3C4A095419A87BA4E961C6B3C320177F69C7D6E41C2D1D9
      22BB27821033BDDE31330A6F9BF144CE9BDB2DE6D9A28ED00460CBC6B045CD5D
      09A49495F75313AA22E5AAC9A051EF4A2148272E6A3219D269B9692A25394CB6
      96254CB2703622B33A6C68E47F31AECFB5CA597A632366ECE13939A56F721E6E
      9D544D2A69A64024556452DF3ECEEE2A0ED16EF2B2FA908B0B6C9C4DC06239F9
      5440EC467A94EE39676991AD49068E5679C2610E58A979982593694E666E90A6
      578D141E74EE784B351717CEF18B6B2EDFBD48F9C04305A491FEBC292BFCE228
      CEA6466A6914E7C9B7DA9A3FE320692C35B75125430D32A19960756F673564A9
      395866A40032193F52EA1027CD1DA4E3C84057717F1868DC880923D5E0CD8CF2
      14119ADCD9668F446420EB88A182FE7D8A3DF36A2C63794E57C9F9BBEB958A05
      B9C30B2A09E5AF049587D3CA95B337D5B94FA53045830AAE9929926272DA2F13
      8A7610AF706047E526D9A5003975B68D6B674173578E9F1226262A3767830673
      A0C09A6DE4927CB4B679C629F9DC5FAC5AB44CD497A06A4961D380AA0CAE5EC0
      9AAEA19C551B323D1FBA9D017E9279F3F54EB3EE4AE479C21A82F6DCC160E0F5
      6D13E1BFFFD7A77FF944794B3A5253E5745A7ED0F25A7EDB6FB55A5DFCD79704
      2C175A470F22DD8A83388E4D5256D872F95F4FFEEE04BED78DBBBAE7773BF4B3
      1377FCDEA0D7EA767A5E277275AFDF8DBAA10A07ED30F075E879AD760B17F5FC
      7E1CF63DDD71235F3D7F360803172FEFBB1D3DE8BB61AFAFC39E727B61D80AFB
      8381EBB7BBE120EA07AEEA753A184CCF0F23B7E3FBAEEABBAD76B71BBA6134F0
      BCB837D05EA0BD9E1B44EDB8D50B3AA137E80F42D5F3958A63D7775DBC4607ED
      C0EF7522D58962AFE7C7D14045CF9F75BAFD41BFDD56EDBE1776DBAAD38A07FD
      D80F54A083D0ED7BBD7EAFDFF2F1B081EAB8AAD30B741773C43802D78BFA7AD0
      EAB9ED78D0527EE4C6CAEBB7DC30F03ABDAEDBEDB7E208E4D46184A1B7A3B0DD
      D7019ED2F6FADA0B07BE17F574A7E505DDE7CF82563BEAF4BD486BDD89072083
      AFDD412BC018BCD8EBFA5A85BEF2BD56BFEF055ED81A80703A54FD78E08336ED
      2EE6863F8381DB8B3BAE56BE8BB7A8761875062128150FDA83A0A5FB1DDDED60
      59DA5E47F523EDB662B715F4C3B61B7A41EBF9332276270EE32E2C80365EA0BB
      41EC0503DD1F60F841D4ED0CBA611046986FE0F6752FF4BA1D1D8618463B8EDB
      7EB71577BC58F7DB5EE485218611F462E19598B807FCF2109F61354003D5C363
      E5C3160CA136FF12184E8B7B2E782CEC796E0CBE32BFF78991E2AE22CEC2F87B
      3AEE778208646CF722D01B336B83ABB012B1EA0C5ABE47CBD38BB0206DB7DF8B
      BB7DD76D07113842E3A71F3F7F1662595B2A084067905BC7714F0DBC28D64AF7
      8378A0DB035F1375BA03A554AB1B7ADAF5C17861D0EDEB76AFEB4560CE181C3C
      E87794AF7A6EA785E180795AFD2EDE8B7704C4C061A715B5950732455EBB1DA8
      8EDF0FBA5E6BD069BB5885B8DF8F063E5DE52AEDBB5D3F6A63855B918B0175A2
      C0F3BBAEEBF762D51BB47BED4E1CF5C0797D1A9A06CDB033BCB8D3EE6263F5BC
      1EA6A2FBB1EA87833806D780466138D07E1CB6717FEC86BAE36351BAD83203DF
      0FBBF8AA8B11A836F655ACBD8E1744E0E97EB7A354E4B775D40A3A01382EEAC6
      91AC4D9D95ED06BDC1A0DBEEF68DC4E8AB4292F0FF2039F00648898E1BCBEFCF
      9F55FFA2DFFD080FD0F8AF07B9E25AA982C9847ED4C2DABB2455B0A6BD48B57B
      BD410BD2008B11804DFD4E179B3E0C940E821823F3BD41D8567E1BF205141DC4
      E06BEC40EDF53DAF17EA087C8C2D133C7F86F9E0172C64D8EAB5A2BEEA762072
      74BF4F4CDD83BC513DAC5B3F527EBF1D62A1C26EA8F1CC3636981EF4FA6D503C
      F0FBD86851EC0FC0965E076383A8000F8233A2A013456E2BEA061D88AA8EDBD6
      588B28EA68EC5F1F8C02518711F43A3DDDC76A427883CBF0252682056DB95E7F
      1DFAFBBA1DFBADA8C79C4D5F056D5E8176F73EFACBEFCF9F957F796D4B731D42
      A2C47DDA2DDDB61F6862242F6EF5A308C22D08BADAC7DB82200CDB83AEC6F583
      0033F543DFD7BEEAEB2EF640176BD6EB42946177F6205931279FB68A1BB6F16F
      E4E1720F12318AC107D827D8657839F6700C7205D80CDD41C70BB119A316EEF5
      3A8301047AD88B22A80017B2CEC5EE6B77205D758C670C20C3224895388CFCFE
      A0A7E2286CC56AD0EBF47DAC398806EE1E0C7AAEF606D8C21D85EDD80E065E17
      2B8B09C6B41B7B0A5B5875A170DA21B8C9F3FDCEA0EF0F889B5C485B0C278A5A
      B11707FD7ED8EBF6FAD0135E37EC63BD0724A15BAADB8E7A2D4F47810B390D23
      A6DD0A95073AB90390AFD58FF500E206830153BA5A7BDD41AFDDC6155D90B50D
      3E88DCAE1BE133A5C24EBB053D0A5901A9E5F75D925B03888D366DAFC06D8145
      21B9B028D06E2D458FC14EF74388B2B0DB8B34B45B3768839A5020DA850AF17D
      A8C37E0FFB015A1C03F7BADD68D0EF42EDF6750B62CCD341CF856EECABB6DBD2
      BDD8F375D4E976C04A3AD42EE929D78DA0DAFBD09051DC751504EFA0D30B63C8
      2BA87AA8CD18AF03BF90D88C216E0790891A1B711075602C40CD8182B83304AB
      6399A2AE82A85031CDA9E5F96D0586501DCF858915A830C6B619F47A9EA76081
      805FE2B6024B839106B020B0C73C3788B54B14093BD05971BF4B2A7BE063C903
      7C0AB5A0C3B8D7C31A4271F90104B38A7B305D5AD8583017301BAC04B14FD881
      E9825D0E1D0915D2036507B050F00144A1DBEF0F5A9A14485F777A2A8AFB21F6
      AFEE0E5AAD01C9771FEB1F7AB81D721E4C0552F63B7D17DAA90F760A7C28A32E
      180CACDDC57A4180843D8DCD8F4DE80F400A287C17464EDC252E8220E8B4C28E
      A7153440BBFFFC59DBC348622C27081B607BF55587EC0C5A94811E7803A8823E
      1E1F777AE028171487F886EE83B4EEBBED1E8403B135F65A3B069540A42E097C
      7031C6D0A2F5705BDDB8A363500E320C24D08186E6E96335FC1E545FF8FC9917
      927A86F285F28F7C3033E4571F769A1A7455DC8142C1D8638DCDA6D420069BC4
      D88310AD316E860AF26119C6A1C64EE98159A2806E19A87E1B82D6ED909EC443
      6378B1FDB88D97F05F1EEC20FC80E282B2E8602F60F340EFC214C546C0CAB89D
      28041344D8206D320241A956BFE783EE90C0187304C90CBD003E877907DD0922
      F8D0B5610873A005A5DEC165DD8026DA6AFB6DB25AC1CE50AD90992D584550C9
      6490461816ECAE18C20A7CD00F610F856D189A7836840A04683F84A0EFF6833E
      2C8E00CB0D230B638179D7076363F850B8ED0EB44414F9A01DCC5E1F2641EC62
      F3408A4146B5601A0F20543A61AC600476217DC882EB6B988F7D8507852E1453
      1BB658E8431EF48316ECD2A00FE9DC8382715B0A56AE0B6B2874A159704D17F7
      6039A1EA31BA1073571D05EB201A40F460F15DD8E06D0C2D843C6D43EEF5A129
      3BED81477A49F5A15C7ABEEB472444FBD88330603DF04708598D4944DE003291
      CC5C4808B7AFF02E08D41E3DD80F5D182D5090F8141B51B506580AAC3A781EDC
      D50395061EC6E6C37EF3FA603557911005D341BEC1D082F9DB89FABEA7B0E1A1
      45A296C695983384960B89050B14EA0EA6321435EC83764C0E030C274DFB99D9
      9DB60E2C19FC077EC798A12020F2225803AD1EACD3C88F30CEA8EF6267FA8358
      69324C7C48A74E07DE410055092B169CE1C146D48AA45917C20ED61C0435CC37
      98E183565BE379B1EF612F80426D05BD1C6091603B423AE257C86048B8180218
      B2AC0376F03BD8953E6D35E806EC994883E3C36E1C7A0ACB1880CFB5EB4164C5
      D037E00E0C1B83C72E8D826E27F0B03720F2B4C68671BB11B6564C9E07314D8C
      1168DDC25FB09B219C45FA42764340EB0E260175089D150F62D84518502FC4B3
      DB10366E80E761EFF8AADBC39AB5A0F30630D74921C02884E86A05BAA57A701E
      BC6E1BD67B04CF077C03E185DD86E7C66EDBC30668F5BA904858BB00D21A7C3C
      809AC1EA62DB7A74252E8528C240F1C46E0CF7175B47E16D7085B07E91D2832E
      243874EF001E1DC4071CAF18CE4F405A1B020306173620D423F8B61390D3D483
      693270313958A1D829BD960FFD0DCD140503D83E208E870DE4B742B29EB09920
      636121438D403AC193C18E875E8290072BB6603680F2787B008E8D3AB0898855
      21722160E065913749AE132C991E9CCB012CB93664BEEA60DE98C78034521085
      212CF35093D7065307064FB7DBEAAA76072C0A330082BB4346296C22E864E850
      080005DD8EFDDEF160A277B03FB121C1FEB08A3064181A5D30A0EFB7BAB04E3B
      D03BF042616CF7232C1CFC467CDA81628298872A873AC55E8326C763BC0E4610
      C38B85718C2BE1D9F515AC24CC109402F1307C980220880A3036BA0B62B00B1B
      AA87D7812121EBA109B4C272B6A114C81BE861578510D37E179B5577E3B81F43
      DFC0CDC55FD0A7F068405D50CF1D780A8678447E23B802B651C80219C60EA80C
      371132D387A9AA686FBA1DDA3D611F1BA90BDBC0C35241DF68B840581B7CA5BB
      D85330E420973ABDC8532424E1D8C1C3E911DBA8011EDB871A21EBBA077B1CEC
      0879DB83F3DE231B03AB401E2D440D6940EC7E170EB3C298A035BCB68FE76AD8
      1FEE0062B50B63050A1CC218460EB6379C3318947DAC15483C88DD5E08E7C787
      5E6EB707510B44275717EA0C63A139EB0EF42C44CAA0138250303540EE56D8C2
      082045DC01CC512C73BBE37B3E3C79F8D85822AC0B6CB26EA8C846834F16619F
      C3D603A791770E911F412511DD7DB876F033069E075F2080BE532E580BDE0984
      14847BD06EC160818EEF4014455887A087AD41110A90CC87D71691F5D282581E
      C4F08C3A90761819648A6A07F0566137907C6805A10B5BC977031881D05651AF
      077319C2193E2F240E966C40211CB256821E04641BEC0B4D033DC391117824A0
      3F3C297884981CD612038969E26427E2955020F02BBB511FB62BBC251F57C3BE
      7161346005BA3E1CDA7608F24006C24A860DD1EB417EE0832ED61EE64D082FB5
      03FE854B06C58F75C12E877ED5344CD8717042DABD41C8F38F02E8230A6C8106
      11A9B8089C08211C429AC325809400C762A461BB057F2768C598B83BE841367B
      9A5C40B2A2A0DD228D0D0C9383F61A7C5E1847DD01D4207807FB0F165BA03B70
      1361B652D081C83D20D6D690DE5836F84EB469E0F7443E8D007C800976A118B0
      622AC65AC0A080D9032B0D4218C41F444A75620DD1E3293CB987FD457E35B808
      0E3E480EADA060337589C258A30E044700B9D4C316851B8FCF2064C0C3E006CC
      9F940CD8120CD585980D6148C10686DF08BB061A16F7C1E4815AC20840C3BADE
      620B426BD01AD068C54B0FC4D3747B0F7B8B657406BA71A5E73E1FBF611F9EAC
      126C0CEC68B747E192B80B091228F278C04F51BF8F8BB075C851D2BE07C7901C
      24B8C56DF82211DC44F268FA30AF20CA200FF46000E33618F460030E609C6153
      451A82097B19DC006D840B60DB0FE063404FF56175C20684230E0DD01F44030F
      AA200069FA10005DC8571DB561C20CE0F0BA7D9F1C321FAE0FDEE6C10CEF61D3
      B950A830C161A3C02AF763D848D850703015AC29783ABEEB2A4FC18C87EF1644
      505E7044B06B21DB282C077317762AB8B88B05807E87166963F81DB81414B501
      196087F5075DF027D424FC2F2C30CC558812988C24A314851F426C3318738A76
      BA1FC263E9809DC0E1307B64E5E6561FBADD8DA8C476FD88EF43FFAB468361A5
      DD1B0F5E35068A063E140B5CF63FAF25D7CC7362C969ABDEB92A4EB5EC7FD82A
      EE43BBA21A4359BE13568D6A55F466D9FFA0938A516115968C6B596467D54856
      4986A523C1F67D883ED5986E7D99C123EDB44A0A74E4BF8E898A85614BD9AFFE
      FEFC191D7684E930CDF2908E3C4606230C5E656C9E0C394D6FEA7910ADE05EF8
      542ED105EE9F0BAF181BB84B5CEDE35BB896F46D07EADE87D7E9F5E90AF8FB3E
      8F987E86F404D01557F506C4F57816CC7AD89D8A4E16200620AB7B701FC88B81
      4DD1923160AF78F88EFC3938003D1FFFD7828515BB14A4F00C65B0E7E11CC53D
      1E93B9AFDB251AD277BEF9D62549013FCBC5673D1933CF12869C875D02D730A6
      EBBB03DAA13C43DCE1C99B61D660E634271FA6957CE67703F98CAF738BEBDCE2
      3AB7B88E3FC3B369CC7C1E649E31F749790D73277DE6DEB9EAEE93BC3BD77877
      AEF1EF5CE3DFB9A673E79ACE9D6BBA77AEE9F2357D509C281AC83AD9BFF83BAC
      4437F4E7AF58F80CD781170C4FD279F6789A4F6F873AFF34CCA37C9A8CD467AF
      D7A13F866978A5A348C72DFE4A8F924B2E63B09FCCC684284219CFF693BF493E
      A1FD73922569964C6FF1F760F05FE523A5D1B853B9A3ED54AF6F39E5B52DE73D
      A3C3FFF9DEAB0773575F6A39346DFFF9F9B3F961CB5DE5A0DBF70F60F923DD3F
      7FE5077A5FFB81FED79F74E76B8FB1FBB51FD8FBFA93EE7FED310E6A3DD0DE95
      608B7DAECDC1F377D563D2F97BEAF1E1FC3DFE23EEE93C6A46F51866FE9EDE23
      EEA9B7E8F3F70C6ACEC8728737CF1ED334C4327FE103EAADF8030FF0BE7C12F5
      B8E18107D413330F3CA0FBE593A8C7340F3CA01E073DF080F5C4842846E7784C
      B8306B6EAD384DA7E3742A29D06BBD558D719F01455EF75E12873A5BEB161A28
      6E798CE030C2F7F1B2DCEBCC3D3554DCB97DADE14FB98C218D9D38B998653A5F
      73227A7CAD87E9A4403E5DEBDDC5CD999ECEB2F5C65DF047515DF15826291FB0
      DED439FB5ED006D67AF5445D3CEA3ED8B55F30617B376F89F5265AB0889A4D2F
      89EF12BDDE3A8F5498A5EB7165AAD6DA1DF6BE93245F7776748BF366361CEAF5
      4405DFF77EFD65E4FBD63382F896BA4A70EEA6F58C20BEA59EA25B42BDC74CCA
      DCF9A8B9997B1F314573E723662AEBFD98999A3B1F355373EF23666AEEECDCEF
      9CB6E77DD9F3643A5C4FB01C0C532AA85B735E67C9C5581120FE5A16C9FC330E
      252398D3FD2F3235B974DEA6E3F536F19B34BA75CED7B5128ABB1E67DAF0CA50
      5F87643C5B8FD673773E860B8B7BD7F3A8E6EFADEBC42FBF7BBD5DF7CEB400FD
      B134CC96B3F1027BCD82E9DA9C7CA68633B109D69CE0A19AAEF7A69281DE32E4
      8A61A32F7FC49A3CF19E2C821F8D9E5D6FCEE5FBD77B6579DF7A2CB8B8E71EFD
      5A73FBBA82F80DFDB2BEA8F8F19660D392F1D55A77BD4D094F5247F3772F657C
      D79DE7E12995EB9BB92DBF615EE01F8D26972A4FD633E80ED370C63D3FDEA9C9
      5A377EA47297F5A978F472444DB44BA5B1DEDAFD78FEEEC4394F2764C3124CDF
      7A2B4837BFA162D3D1A3EE374EF0F6AF3AD859FFC5FBB09CC7B7A3C74C78FF11
      1E19DF7890AC29CEE4AE347AC45D870536FF63A6F893BE0D529545EBBFF723BC
      28DE1C53FD88BBCF14D50FAE7F1F5528DE6013AE1D2FE0BB7F515942AED8631D
      DD7C16FC5587EBEDBCF7A9F854EBDCF341EAA345EFAF1B249EBB793D193F77EB
      9ADA85007CD38A64BA270676CEAE30A124DD33AD8AA00B35352B87F55D3C74B9
      E5B248EFB3890AADDF6B2FEACE0BED13C61B38BB2C1DE4E2C245D38B2E2C56B0
      B8CA5D72556556C575DE82311625B3917DAF090C17D7FA0F5DEBCE5FDB5976AD
      E197B90BBBF75EB8F0C4DEB20B694A8B4FECDF7BA1BB38FBC1BD977A73CFECCD
      AFCEA1CAAEEED2BCB7E036D1613BF5145BB68A3D77F9B5771FEA2DBF90D7B22E
      0341C984A4CCDB8BF3BF8F97CA1B6A31D53D973FCC5BF7DCF43093DD73D303DC
      B638F7FBF6F3A9BE4E721B5B5D1E8BF517A69F573CD307ECB77926FB8F596A94
      EFF297CC2FE3F178AAC7B9AEDC5567E3DCBBDE0FECA17B28FBC066BAE78E07F6
      D4F23BEEDB5CF75CFDF02EBB6FEA0F6DB87B5EF4C0CEBB67EA35B6A05B4F98DF
      73F9AA0D7847C0D5DB82EE63B6607D817FCF1D3518F8CE7C6A30B0BB3603BB6B
      33B0BB1603BB8F61E0C5A9D76160776D0676D766606F3D06F6D66360EF710CEC
      3D8681BDB519D85B9B81EFCCA706037B6B33B0B73603D7336FEEB9BA1E032F4E
      BD0E037B6B33B0B73603FBEB31B0BF1E03FB8F6360FF310CECAFCDC0FEDA0C7C
      673E3518D85F9B81FDB519D85F8B81FDC730F0E2D4EB30B0BF3603FB6B337067
      3D06EEACC7C09DC73170E7310CDC599B813B6B33F09DF9D460E0CEDA0CDC599B
      813B6B3170E7310CBC38F53A0CDC599B813B6B3370773D06EEAEC7C0DDC73170
      F7310CDC5D9B81BB6B33F09DF9D460E0EEDA0CDC5D9B81BB6B3170F7310CBC38
      F53A0CDC5D9B81BB0F84EEE6E940878E433D7FA2B2DCE79F9F9FF5E28B1B1F38
      BDF1EE9E730EA9634F352568F98DEED277D6B9739E486FD2F46A8D3481E229F3
      7CF926098649CAB191DB2F498F5E8CCF7E3828CE33AB97F94B8FA138983BEFA4
      FBEEBD17CE3B43BE77EF85F346A7EFDF7BE1A209E177EEBD745E8CFAF3DB89D9
      55AE6381377F6DF7BE6BDBCBAEEEDD77F5C2F4FBF75DB730FBC17DD72D4EBE73
      EF9C3A2C2FE61EDB69DF7771B7D8C5F337B8F7DDD05B7EC34AB22D0FF23C40BF
      FB624F0F90F29E77DC4FD3E537AC22ED3D77D5A0F17D73AA43EE7B265797EEEE
      BA74AFCDC0F7C5586AD0DD7D14DDDD47D3DD5D9BC9EF9D5C5DBA7BEBD2DD5B97
      EEB525C87DB184BA74F71E4D77EFD174F71EC7ED7754C56ABAFBEBD2DD5F97EE
      FEA3B8FD8EE05F83EEFEA3E9EE3F8EEE9D75B97DD1ABAA41F7CEBA74EF3C8AEE
      9D4773FBE29CD6A17BE77174EFAE4BF7EEBADCBEE83DD4A07BF75174EF3E9AEE
      DD4773FB9DC9CDD39D3DA2DA4660E5EA077568E5BA074578E5BA072548E53A63
      023E28382A97D733022B37D43302EF92AD961158A5DF3D37DC4FC87BADC6FB69
      5ACB08BC43DC5A46E0521ADF73670D62DF3BB9BA747FD0085C46F7DA0C7CCF0D
      ABA9BE6858D5A5FB8346E083747FD0087C90EEEEE3B87DD1DEAA41F7078DC065
      74AF2D41EE31C96A52FD8EE9B806DD1F34021FA4FB8346E0FD74F7D7E5F63B56
      E36ABA3F68042EA3FB7A22FC9EBBD6A0FA1DF3710DBA3F6804DE4FF7078DC065
      74EFACCBED77ACC6D5747FD008BC97EE0F1A810FD2BDF3686EBF33B9BA747FD0
      085C46F7078DC06574EFAECBED8B86555DBA3F68043E48F7078DC007E9BE1E2E
      C13BDCB27E1AF6D94865D3475639FCA8F2CBA95AAFC0F3E771A6F37448ED3EEC
      80FFCE9D1AFE6F7B67B3C3200803E0FB92BD4B0B2DC2E388C00B6C57DF7D549C
      874DB6C4B81FA35F6208181B5A0FD6CB871CD270B9CA69288083EB088ADF0900
      473FD3F944A27B1F8C405AA9C89A902D5B0AD4B15893D050712969235EA3594C
      8914A04B88115AF4886DC4BADDA9A0C55F9C43A698D2607BAA99A9F0617CB821
      CFA7C93AF63C9FD63F88D834F7CB91FD7E99C93E8C63FCEE4E7EC1F1EEF7CB91
      FD6B38F71A2695ABA1D27A50EE424C2CF3262F34EE5D97B09CC174C9F5EF3E74
      A60DCE5AA7120691531BCE3B2570462BC6C8F5C8242E7BEBBD77D60702AC751C
      FF42B5020BC9D96F8C352BB0BDEC85B52AB020FBFBBFC748DFDF007F190FA1}
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
