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
    Left = 552
    Top = 432
    CompressedData = {
      789CECBD6B73DBC69628FA5D55FA0F383AF796A9D9B4CCA7483A939923CB76E2
      3B7EE4584A72A6C2D429106892D802016E00B4A49DCA7FBFEBD50F80A42C5954
      2C6F72CFC42241A0D1BD7AF57A3FFE1866C5B839F443358EFD64D26CB4BA433F
      C923FA27984F9AAD6E6BB808F88E71BBD96DF486F8A931CC8B7C3A0E47C1142F
      76F96B9CF2D763FE3A8D4A5F4791791EDFD56EF49BFAF358C19BFBC362AA66CA
      FC66BE557F0DF2C61FC3719A14C528860F8D210C1D46DE709CA5333F198E83A9
      9FE5AA80EBF3EC1FAD3F86FF369CFB499A2BAFD182FF3B6EB41BDD4607FE6BC1
      A7CE9FE7D14CE5DE7B75E97DC4C7BFFB13866C99216769A8B2EA98CDF2983D18
      674063E3981D18F3345D6491CA70D4EFFEDCDF8311DB6B26D95A9E2480B3010B
      86FF7A30591CB4F7E7D9F56C94C634B7A65D6F12C5370FB4F4BF3F7F8D924908
      FFE532AF6667CDC49AEDE3D5F0AB8CFAE74FEF60B8B7D1CF78DFD88F0B6FF864
      D41B3EE9B5E16F6BF82484BFFE60F864EC0F9F04DDE11335F89396D15EF7E295
      DB86DBC5DB86DBD74210FBB35116F9DE3BBF986A18F7CC90F96594E7370F39A6
      DD6AD1E07AC8388231697A9DF69D506004F31A94074B933C8DFD9CF7ACD5BECB
      D4468248FC1FA0E99F676A922AEFE7377AD78E9BF7DDB6FFA5F78D2618C3207F
      4FB3211DF14D1F289A723872DE70EFD97F21D24D236712ADBB614B7B35B6786F
      A3C9B490458EDCF1D71DF97BD025D8A628D1E3DFE900DD619BEC1BBA5F6F9BEC
      248E3774A8F506D9917B9BDFA04EB7BF8ED0B7FB3CAC5779CE3B7D258F0ED63D
      8A5BBDFAD1EB4C16D6594F11F097954FFF902975C1EF3E6EAD7DBAB5E6E9F345
      26CFAE43F466AFB7E6D9DA8F6A94A9CB4319602D0FEAAD8359ED24F347517068
      56BF1655FBC76B867801F818053283E3B5CB6FAF9BC12F912A121F2E2A5946AF
      BF8E65E8BD6F7A8E6060F6BD3758FB9C6C7CE539BBE9FDE6BA47F5AE971F7576
      BCBF56C6D15B5E7ED46C777F2D67D4FB5D7EB0BCD7FDCEFAA75701A9BAD1FDEE
      DAE765A7CBCFBBBBDC3F5EBFE4F6AA7757B7F8F873ACD1D304CFFB55E505BCE1
      2E848F16D81B7C9E80B8A28FC6A2DEE0F3D4A3FCDC35EF677F3D333684A3F4A0
      C5A17EE3F354A3F428E1102DB3BF9EB798035B7AD4D9C77EE3F3A7B5F4ECD23E
      F65BFD354CC50532B377816FBF3558F788035F79C41CD07EBBB9E62917B8FC94
      03D7F63AD1C4852B3FA58F65BFBD4EC2B454583F533A917D4710AF3E588545E5
      30F6DBDD758F3A9BC88FBAFBD75EC7D2DDFD93372E6D5DFF565496656FB379FD
      5B9158FD90DDBEC1ADE8AB3CE76CE0E056C4559E335B38B8156D93A75C800E6E
      45D8E4C13248459DE87FFE4068154403151EFAFC91B00F09B9691E0F3E7F24CC
      5316A4F0DCE70F8579CE121A78EEF307C33C573A19F0E8E78F867DD49C0D7EF4
      F347C33CEA6C253CF8F9C361DFB9BC95688DF80C8FFA5F5526B5AC017EB1105B
      1AE53EF2AC3B50F33EA26D69A02F97724BC3DC47E05D5EDD7DA4DFEA58F71283
      4B23DD57225E52FA5B0F293B5574FB3BF07752DF35FA96C6B83DC397310CF2BA
      C3DC4102E0612CEA9686B9BD48C0C368C42D0D727B198107A9A06D69ACDB8B0D
      32968BB4A5916E2F45F0480ECA96C6B9BD5821335A4658D780D3FE622A581AE5
      0BA9606598CE17D3C0A57575BE9C0A9686B9A7DA5F1AEBDE1680D268F7A282A5
      91366017706D769D2F4329CD33EC385F8E54EE30DD7B32563BD017A2D4D2C2BA
      F744AAD258F767AC76AC2F47A9E5356E00A95C33EDF1C33356FBAEBB29CE9A6B
      D8E7EFA845571EEF7D893A5D1AE08E9AF5D2027A5FA86697C6F8128DBB3AC6DD
      55EFE5B5DC430F770DE9BDFB304A3BCA7DD40577A0FE7DA85A69A07B314A3BCC
      BDD585D268F7A46AA5B1EECB28ED48F7A569B4D0208DD3AC18C5DF0D33153686
      13D895A4311CC50BD558BED4EA76DD8BF0F5A6CB3C007E5B3144E572E5DE3543
      AC79210FD16CF5DD8BF0F5A6CB8DEFF6F7F0327E5F3148E572A37CD10EB2F2B2
      1964D0921FE003FD3068DD0ACE0DDCEC7FC3488D603A4752D16A0D31D063E88B
      7B0EC33CCC178C08912F5D4F3F38F7E71EACF01FB1378CA3C63083FF72BF097C
      2B8F5BDD01FC3B5BC445737819854111CFFD6C7899F97378CE87CB433F9FFBF1
      7CEAE387643103CEE52F8A74E8877F5FE44586823C0C08738DF19FA8F0E70DEF
      CF6192FE03B02E9DA585F2FE18E6C575ACF2A952C51F7FDD24865911032CC641
      DEC4C5FBE272F40980BE8EB681C91419DFD6D0C0D501304EEC0B01FC73F01E06
      932C0AE9B164EE8C90CC710C6F9827EAAA80B7E4FF18A7D9CC07FE9FCFB328CD
      A2E2BAE1BDC74B18610273CD9B65308D9A0D0216FE3BC28537E11BFFBD13B8D2
      45010052B1FAA4E2C6AD8137F447B0C206420EE4E735901B0DE9D755B0BB0091
      070420500F6F860F2E7CE4E72A4C9386000B5E9EC3AC2E9ADD95501B78885A59
      1E85BD1EF99DBDA9F231BAC66BE2A1C95B0F0FC6E69780114061C108CBAE0212
      7E5F05C8CFA15705782D0DBCE33B02AF2558D87E78F0B5BE047CADDE4D5808BF
      DE1D782B70AFADC1D7BB23F8DA4CB061D230941F8651117D527077AE66D1340A
      4395C09745021FD502DEE88CD9F45E32E8BC9FFCCC9F0028A7DEEB3429684098
      6291379BF04F965E86C3221B17F9AF51584C5FB4E1CB1C5E14371B7DF998D98F
      E358FF3E2ECCA791F994E1A76034F781F6C287317F18C1CA810DF1DFE27AAEE0
      AEFC93CA0A103FE0D3280B33FD3796BF23F99BC9DF70129B4FFADA54FE7EF23E
      C70760B50FC2091E0D1F68366F4089FD3D6607DEB93F8A95C1A7AE8B4FEB28F4
      D2896830693664D8520A4450C671FC9B0617256C5CC6F01F3575F54E41BA34D3
      3AFEFCB4F0AD2BA605979D9367A6D3BADB745AE5E9F43E3F9D566FE574F0F2D2
      64DA779B4C5B4F86F878FF6148E81DB09DD7DBB901D33B9BA197CDFE8D34AE0C
      2D41EFDAAF6A7468366EB076E3C62D5A45A332F7D6902F96F6ECB653F8F1FCDD
      5BEF340D158B0A8DD24E99DD40AA7B35681EC3BF4D8C0B28AE5A3D384CC555FB
      F8B8037F3ADD3E90C9AB6E6780B71C779A784BAF8DE1D257FD56A7C34FE32DB0
      E93D1AA63118E04DCDE60069F41528082DBCADD9EE75E8BECE71F778C34820E0
      5B8304B04601E546C40E738A6FA2702B77E3A74C319F2D54A8B10247F922AC58
      49581AEE612ECDED33D3299198566BED9C223C72E5094515045D9625685AE509
      BC9AC186E7516E5ED95E0F864675374BAFB32A46F51DF3F8E98519BF73DBF1EF
      307AF0DD9F347C1CE545819CEC0FFAC8DFD56C1EFB858AC256A3D118747ABDE3
      63FE9904C321FD9B8C8356DB7C4CF4E7BF070DFD21914FE3348ED3CB060AD3F8
      352F7C90554092E16F733F507223C8332A291A7FF0B7021076F8A4D11C2E9EB6
      07CDB6F79F080F7EDF62365219C09F720772F69EFA8460D1D3F6319EB61E5CFC
      7B208BC363DFA233087F50F3BEEF52AA0BF904934DE0236CD0DA55A111A7B4AE
      74D57A5A6BD6D3EC74CA0BA20B3036FEFD5A4B5AB551ADC1AA8D4232D66CAC59
      5B0B89B0BB36BA002FC1BF8F7F6D37ADACDF47B42FAD0D2ED1DAE0EF37BDB636
      467CBA2BA30BF00AFCEB91CDF29B5D5BA75D211F74015E817F6FB36B9AD63DC2
      B561987E696D74015E817F378191CB74FEAF5B5BAF4249E802AEADF7E094C42C
      FB81D676DCE997D74617E015F857AF0D7D061E0C839F2334780FFADD7EB7FBE7
      4AE6DE6C3706FD56B7DD68EC98FB8EB9EF98FB8EB9EF98FB8EB9EF98FB37C2DC
      3BED46BFDD6BF6D730F746B7DD6F0DDABD1D73DF31F71D73DF31F71D73DF31F7
      1D73FF46987BBBD5EB743AED7E6F35733F6E769BBD41AFDBD9F1F61D6FDFF1F6
      1D6FDFF1F61D6FDFF1F66F83B77706BDC1710F38FC1AC5BDD5EB0F80C676772E
      F71D73DF31F71D73DF31F71D73DF31F76F84B91F775ABD76BF7DDC5ECDDC3BCD
      5EABD9EFB6768AFB8EB7EF78FB8EB7EF78FB8EB7EF78FB37C2DBFBAD66BBD93B
      EEAFE1ED985E36E87461DF77CC7DC7DC77CC7DC7DC77CC7DC7DC77CCFD1B61EE
      835E77D083DFD730F71EF66FE8B676E1743BE6BE63EE3BE6BE63EE3BE6BE63EE
      DF0A731FB43BAD41ABD11CAC66EE4F9BAD7EB7DDEAF6772EF71D73DF31F71D73
      DF31F71D73DF31F76F84B9379BFD66AFD7EAB78FD7A8EECD76B371DC6A765B3B
      EEBEE3EE3BEEBEE3EE3BEEBEE3EE3BEEFE8D70F756B7DB6FB5DB8D35DCFD69EF
      783068348F3B3BEEBEE3EE3BEEBEE3EE3BEEBEE3EE3BEEFEAD70F776B3DF6B75
      7A9D35DCBDDB3D3EEEB55ACD955EF786854BE3EE5B7E2B48B4E0BFC651150A08
      2258C28D9578BF98CFDF6555B74463BDF8B54B6CDE6F895FC0FA1F6095EBD608
      ABE755B6EEB7CA2F1002FEC255CA1ADB4B6BA4E5DF6195FDCA21FEBC38F0D7AF
      B273DB9DAC3470B9AD68F03856D9BD1FBEA2245011ED3E2F24FCF5AB3CBEDF2A
      3F232CAC16F2FEFA55F6EEB9CABB8B0D86EAFF85ABECDF6F955F2240F4FABDE6
      A0D36DB7CC56AF70EE773AC7836E7FF3C2D51DA4A987370FB8FBFD97682E8FCB
      3CF01585FAAF691E7868A1FE0BE481BF548566F1E6410C045F7D6DF73159DDDB
      40F075D7F619F34045AED9B481E0EBADED663EFF4D9BACBE84BB0F1AED66AF3B
      18ACE5EEFD6EABD96D377A1B88DCDB31F71D73DF31F71D737F1C8474C7DC77CC
      FD1B5ADB1731F76EB73BE8771ABDB5AAFB71B7D569F57A9D0D64D4EFB8FB8EBB
      EFB8FB8EBB3F0E4ABAE3EE3BEEFE0DADED0BB87BABD1E974BBED76A3BB5675EF
      748EFB8DF6F1CE2E7FFFA53C2E7E5E5E03AE7F2BF8B9BBB21B432E76FC7CC7CF
      77FCFCB1AF6DC7CFCBFC7C70DC6C357B83CE9FB476EE1C9F7E52591685AAB01D
      E4F525ADE59B08BFD2AF41BA80C50CE3BCF9E7EAC774EBDAD54FB5563F654AEB
      AF7EAABDE65DC6CBB0FAB18ED9ECEA83BA05DFEAE7BAEB5EA7ED1EAB1F3B5EFD
      982950B4FAA9DEEAA74CE583D54FF5573F65AA18231B5BF5DC60CDD24C34C69A
      CD6EAC7ECE22D79AE7D660891532D73CB7064F4C25C7358FB5D7EDB8E9CBB4E6
      C1CE1AB89814D535CFAD431593FCB2E6B9E33FFFC4A398A94FC528F6FEF839B9
      48D2CBE43BBE3A9FCCE92A7E1846F04F6B1815FE1C0F7A6398C17FF908FEF371
      4FF41D8D3577C891CFF228C421E90380AFDD3CEED1E75E6B3018B4FBFCB9D76D
      B41A08F9D9CC2FA63F65FCF7759A14EDCE7036CA2E5E444008E5C3D9025E31CB
      677E1CBFCE7C2095B330CAE72FD5B8399CC5EFFC6C42F766E653A8C6FF5F00BF
      5D66FEFC0D9144925E675152BC8D66F021F1B36BF884181325E3F48FA1BF28A6
      69E6BD8AE19EBC50D9C9CFF0533A57995FC0E573F80DAE26DEAB6412AB8C161A
      640A88F06C789DC1C9E90F6769B3390CAF9BDDE1346BE29B5A083284F94DF7E0
      D182FDCAA334C1B9A8105F8F1793743CF7272A6FB7F8CB659A8579BF7B3CE0AF
      C1D4CFF24EBFDFE939DF2FF36EAF4D30852193419B37F86A16C38A688BE963D3
      9B16C5FCF9B367793055333F3F9A454196E6E9B8380AD2D9B3743C8E02F50CDF
      F7ACD568B4E9D32CC6CD1DCE7D00C8651348E1317F9E36617F615D00F798210C
      9F32F3A9309F46F469B200CD2E6B605C57AE8202032F2FA330BD0C8A2C1E8E8B
      64F4F7A1AF92304C836101DB7C31035CCE1BFC799C66802045944C0084699282
      8A3852617E9D8F01659A00E8F83A4D3ECDE286F32BF0AA49E8173EBC391BC3A8
      C0F9920206FCE4C7115C57008FE6309FA697A06C066A9AC621724C40EF499266
      6A165DA93080D191A302827F5251424F5EE15BF031F800670D50A3097B70050A
      6B915EAB0456A5AEE6F9342B12B8BC80C5028B0E8661029B90E4A37004578967
      C39216B06E58583EF5E1380392FD13D71E4E6684C8F0614A373681EF86934FCE
      67B8359AB02E86BF94BE4D716A4D7A003FA0E805F3F19370F829529717202234
      E9531EF8B16A82003D9F8CB2309B2A3F948FE3342D86F93CBE2E2E932851B835
      E6F3B498C159C9E7B0883899167EF87758D6709183B431F2E36408FFC10578C9
      101E813704F0ED92BEC087AC9864C33881430D2B5730047CBACC90000DF3C49F
      17E904285794042A8E6120907EC6918AE1F88630FC106E9C2F920035083F8F7C
      330A92930C662C246598A84B18302FAEE1D71CDE31C9D24B98723A8E0A9C6782
      F02EAE01EC646E4852986B0274A6C887638573532021C1E5E02A9F93C4021422
      842DBCC4EB0AB7D407B92DC7E50CFD31DDBC00B48C8753BA03E1560091F433B8
      B3083EF904AA02268B0F8D3384075EF8E41757A3ABE14596CCB33C51C530F0E1
      3C02BEC500460F112782E338F70B90C814A7DDFDDBF012F0783C2BC611887699
      D7EA741B7FE2E90742B4C85431CDD20244CDE63002D971E6077E1180A037A7F3
      06F3F18678E8424F1F3F14E5D45563881BAFB2EB5EA33FC48D978F3091FC0A3F
      00F493A9CA143D8D8FE01EA18448A3A9B10F181EC0FED1F9F588A524F013C8A9
      4DF8B408B2195E40F115BFB3808AF6907932F59309329EA4B82A7CEF48F8913C
      DC427A038FC364BFE8F9367C0226F845CF76E0537CFB371F969FEEDEFECD23AF
      F6E7BA618E0900B79EC64D43F568A0DB6DC44DE3F43735A1C16D268428BF7224
      E03D1990AAD88F124F707BF80F3833561E41AA96FBF4EF088F3E50799FFF02BF
      012CC627503610F4057A32F7E3F9D4C70FA01A0DC774F7305D10C293C6D41802
      A95BE40550DA6901AF494815D2A2100CE83B628D5789656E37BB20C8FBA067B5
      80AEC1E29A8D56B714DF8CB601FC157F047DA1491FC6409E5B20CAA770170F72
      3C9C46CE977064BE7487011E4C7A2E993B4324731C0476A534A5114658E38C3A
      FD729CF50834C216DA35418700D04C8717204B001F05A9144413678D439439DC
      35FF3AF58B27B907E4D7838DB97A154685D73E6A1F75BC17AFCE4FFE93E487CC
      E3DDFBEBF6AD79A77D5B07A5F6F11A280158084A9F81CD8BC5640CE244BEBFF7
      1782E11E0BE755B73A95187C5E73ABF3B9E5EEEF9D4F95C7060CC01D2F53F334
      2B54E84579BE50B9370561CA1B2910A8112AE17301CA1F62FCBF2A9C236EB8D7
      CDE901628AFFCCC4CC59D247A7C1076ADCF6864F46BD2130FC3F576C4DC9B07F
      EB3DAA18BDF0D95BEC1A286C2B770E1FFF2BF6EE7F76071DEFA977F03605E92D
      FAA7F2E6F10284CB036F8CC217282AB089DE284B2F48D27D3CDB563348065304
      F53000BDE5101692C345C441507540B6C9BDC04FBC05F09ACC0B5456200F09A2
      2C58804CE883E09903AEE6B03B48C260846C31A725A763EF35C88D6F5EE6DFC4
      9AFD10A4E8C933D061D24FF861150C628587B08073FA2902542D1620761EFC0A
      5271487AC68107F47386FA92276A8F570B53800FC8AE1A329E1FD063A8631D3E
      2EC08C53D8636F748D76CA4D9E8E10790ADA05CAE3A24E72CF9171DFDE02C75E
      80DAEF81BEA3CC614388FB977EA6100D8F902E24931C2867AC706FBCA351EE3F
      3B1AF92DCF87D7469FD423C3D16F732B7E3E7FDDF75412A478928095655E2C04
      31F4F416244A85B9E77B63D055477E70E1CD140C9544F9CC8BC6E62EDC38DC42
      3E4438EE6E7FEEBF3F991A7BA34514D3F6805A9F7BB314003D0392975D035903
      0A9728A0E7B99F5DEFE07D7F78034223AF98A5E12276E9139AAF90FBC08B514D
      00D12EF7D4153086F81A2E2B384205EC870F2B06750088593055C1850AEBF815
      ED53B9B7987BF00C0817FCCB6EB336B05940B7923C429375103197D8F0FC8B0D
      8FB7BF07C81580C2E0CF739458D8628908555CCF610588408E4022720BA89AB0
      4B5E2D9ACDF9379F70126F0E551E64114B6F2300F525E019DA7CC3C725A8FC4F
      8C5C78EA7D24390E97EB7BC9228E457DF6E7734FDC031EBB6CB75A8BDEDF7B8D
      56E145E1F58EBD7C3147986D893EFD037A9BBC79964E403FC989CA92FE3CF343
      75E49D00C6640AA57FD1AD2FD3EC02B109561425111E0214232F8F00D1C62A03
      AAA02CF33463A904CDDDA143ACE1116F9EE67904D7BD2205153006B21EA77EE8
      9D9133E5FA2CBA3A5220EF5C46C5547EA681913F575F84F7E0E6B1CFE448766E
      794BF1CD1395A8CCC7E160E1E135BE1C8FFC3C8D9202B93B9C8DE41AF90BF090
      05BC6EA43C5F2609C2004E1F3EC5697AE1C1AD2BE68A6F9C2D82298AD4BE8752
      5BA048CAA3C981180182C304E80E7C0E323F9F2A33DF17F0641E4D92681C811A
      05F398A1A315C741A0C3746740477286560673CE1014708E68FEBC49A56D2168
      A3E9331A5F338B85959115ED403CB507283AA2D984D66D6D27A0E5A9F068CB29
      C27B005490CE6608469C9C87AF9EA9828BDAFCEB9386F3CB949045C3607FAF02
      852AC27C89B1AD4553FC1736B9B5EE69725B0DA0CEED20F414278144F5563215
      4511DE123940B2F83502DE80EA270ADB445FDEB1087F6644F830F2E374428408
      61C0F41D68AF08FB4277508D05B13EFA847F908A9170968A79303F2AAE8A23EF
      0DDC17E7A9975F44F35CBFED872C0519DFBE0F5F844B9E81B416F89AA3E4F44A
      5692F5435F62C978705CDDFCDE4FE0A802BA5D6C5C1780FD7F03A231AA000F30
      ED5BA3EC5D049D23C6D8327E10DE81F0EEFD00907A0B904215C08A3280A70AF9
      3CE29B02E44A59577DE10717938C14B8B729FAB8B79D571EFCE8CF468B6CA2B2
      03EF9D4A165BC1204FF6F73CBB705AF701C8A4450194C888BEC419B59059A473
      2F566332738314AAD109E53A901D9310E5E8F3297A417814347DA0191014D005
      0BC2B56091016A16F1F5213D6A3D61680E81E3B8F37895D86FFBAB7ABCC4D345
      B68347B52F86DAD5A231E87E2A07EC795CE68B0F6460D90E497B7FEF1D5B98E1
      9447859A3972D122D1B6E608B855ED7B12B842057481A4A4147D8909EED52132
      AE301A13E72AF4551A330702730D7A2F7C4B3F6962044486DFC716AFF10203BD
      B69D8D9D02BBC7E0584F873A83CA8F607EE998FC0060AF2390727FA4E0B62DC1
      CF73B2A10A70D09851647E92C73E85311A7F542D574A4CA2788FB5451C925F18
      6D3E2303DB1098E3E8DAC3005992F7913D22C66E569CFCF760FEFC0AFEF71F9B
      D780F274A62E317E519F21D7309CBA4E8DA30D2F0A17B471F198B608B667B353
      5D14E3FE86A78A96333464B14267B092ADD8754F1D4D6E096FDCED5B2EA3D9EA
      B636BC8C2333F59C45BB18CDAFE45EEC00219F44055068549AD1EA1803B1C153
      D2C81F6881784E1A8376E376E7E40EABDC728E72A628B3A04C3C631D8C018423
      E71B38EA624BB8C91B32C4BBE67F8002D14B032640FA9060E55B68D5D01A0997
      340361A796ACD31B67E98CC640E995B9D021321820C1D1F85AB39812B881614D
      D3CB049DC4073F13A32FFDFCFC40537663B4476B1650770A2D3ED4B87DCE4C20
      F78C6E06ACCEFBF98DF13A10C30489AB8E7ADD8A6908E5456D0F23196142CC0A
      55181544EC42B8B259BAFC5B30D732CEEF0FC01AC51E270B631D189D1FB81791
      427BFA8522903CFF3CCA5BB42EAE06CD632C18D06FB730FFBCD7E953AAF67107
      B39ABBFD06A6C97606C79451DAC45B7AED16DED26F753AFC34DE0267A747C334
      30E712FE36070DBCABD982FBF06FBBD7A1FB3AC7DDE3073D4B6488DBD83E0A28
      5532812330FD1E59AF5CBAC07CA534F9FE18FEB7153406E5D57CAE02C6367272
      313325010740F00D88385501A776894AF2C6393FE2C4A6A71FE5C993A2CE5AEC
      25505732FE032D50573EC653B894D3D926B3D24BB2D3822A1B9033967404B84A
      64D6B7B701C5050D2C42959688BF6614DB2E739C627657A6FD3026EEE95FFBC4
      B38E5A5D7AC90E221163A886727C187262561B505FB3DC3BD74FEBC8077FD35E
      8EA579D6AE0E37CE86BFD639B85B42D32DD387602D9B4F206AEF1288501C9FCD
      33320C1A497BBB22A0C46DCD61EF2CAB1B100054D0879A83C88F265AF825CA8C
      BDCB86129DBC3F7BE3D5306A68745D286F8E3920F01E1FCE7676A8EF17DF4EA6
      FEB18832EDFC66AD07284F5038AC7EE6CFE7A88F8C5471895E24331847F5F034
      E8551CC07388CC1075A623EFA74C7D8AD245AEC3FB72A46D8CF2533FC4ABD720
      7ECF225C1A2C727FCFA8287E809666CAE6702142D30CA310583AD922083A589C
      85166DE6EC333DCDAFF342CD2ABF89358CE2DCE50E4D9C786609865425E845CB
      31E2F29AE3AED78DC77A1495538015D1AD22450426B09E77D224E2C47E8EB7A5
      2678FEE851793BBEBA9FACF355FD643FF04192BDD9DFCBBDA7281B02B2219394
      1835D219495FC6D240A04C9B48670A51C2F8DD3A20051C920486A27BAC1F2581
      7B33EF53642C0E14F317FBD7D677FF3830617FEF9777272F311E131656448CB3
      18A92CC021D520CBFC6B8BCB0658690227475DA1FD0370FEECE23A8B66442FB0
      E26186E4475D1334340123A2161A2B873DF5FA84A17D054BC12414756FDD4B97
      3E4514265E4A71888FF24CBD5DCAAA71916A1904305D469D4D6B583AB16AD35A
      1693E74BDC065F6F5E94DB6CA2C7B51DE7AB3C4637EF480529E534CBB1D54C05
      D9B33743B2452E4E3226AA23EF75BABF97791F467104DC30A99B60E0769D4E84
      FE8A419EBFA8899FA3B65A9E8947254230E7641E4741840760E6671718C60C93
      C4085F9922B3B0E5005C9C44E61E43903FD14341CE570A668373152F424A42B8
      D6FBE6C0C7AB6998B0268D6AF1485500B4066DEF6F5AFA5A687B58C908D2798A
      94111A5F2FE3F7BFBA7C5AE68E1C3BEFC740824BB889A29911B8D05FE5D54868
      C2DC4F20E0DE9B43913FB5B5D9BA61D9C9BDE138BE60FE54E4E3E7FFAEE7F500
      5E58B60A6DDA697CA7F9DEC930E6A98858E6DA19577B867E6D2B64C5C14A91B8
      921A81058FE848B2743552363112E9B009A24082A70F6B55BAA1E0DF25641612
      078416B35A8FAC8B051405923DAAA353A24A5567B3E3A276C5F4DD50D414E74B
      B9B8E45F0102CCB28CB542D21A6DD27E39B96459BAE030665C3F5C1CF939E7CE
      93DEA3F56AAA6959B031020629340F439248BFC9F7CDA2F39D08F99D0E1F9172
      936E63995D0D09F6D9ABC37A2546B104088618B2CD498280DC452E9634B2EE57
      D5C8C48904DC0359C9A3DA993186663FCA99CD530BB3C6A39A59F04F153CCA89
      8558D4E0516E2688F18F756A13057C37799433CB94BAE089B51FD5C48066C6D1
      E384D9DFFDB99FA068F2F4F195F00009EF524D1E29E050D65B4C160CBA47373B
      E0EB8F957EE4972A7CA4532B16D985995AE7514D2D5BE4B93909CD4735B5601A
      3914E4BB4735B7E92299F89901DCE3123F40861E4501CF6C3B22A3F6F7484F3B
      7BB5D3CDBE5C373B7E7CBAD93660AD36DA774A26FCDEF10E95BF1C957B5F1995
      B70B8BA978ADAEE987010A0B2EC4625036F72263B764D3678D68F5EB0F1D715C
      7DE81DEB1BD0E44F16CC31A7C414534A04BE0AD4BCD054E248A775B297EA7239
      055EC7742C45A1AC2C4D58F7B0E40DBB6F4AB64D98777E1915586A1E33E6B345
      5244339D4067A23F2419B61497E746839693CCC862CBFEA265AF0585BF70AF0C
      4A04A0F1C84F48E934264C850CAB129DF22D19566DB600BAF8122AD5B5E1F9DB
      E0F18D3B3A3838E748672B6D36E49ACDCCFFF795A0F8832D831C0F8C53E2F240
      BCF5292E02F13A565C19C8205CA8F228734299CB514E94D452A4FAF8EACC15B8
      72204B39F06AF0F180B0DF70BB43C45E7BCEC6E40E759D2526825AFC0DA5AA45
      0FE2DC8B9FFFBB9ED07A1F59D593757BA8FF3A459073A5B0BC4092E5260B31C1
      021AC3F4A6E20C724892A9255977A91FB94FA91128817EA2CA4178E6699350B4
      F15C3BF44EFDC75194440FE15AAFDB8947A6EAEF85BA269CB2F1101246E8E54B
      F7502C02060CB117CD75EFACE00697538ECC887217EE9CF4C621FC4C793128C2
      8FBD609A4601F9B9EE90CDF0B54316F6F78409A1243952521736AC3048A96924
      F11DC2AFB0FEDBE4CB39E272CC4C3904D38DBE5CB139C840567B22294C85E745
      A5FFFC1927B57935F14FDF0DFB3789FB5F4A36D05D5D8A87F85A74EFCBA67F28
      4A0EBBAE47D8C34909A3ABDB0DA7E446383D551527099D746244062CD10ADB3B
      4AB1AAD69C2A351D79A7888D06FBF410D8DE673199DE8C9270989124E840E29C
      D1055E4134B50A8B68BD1014DD1E24C0E7364D21F93C96734D2B27BA54DAA086
      4708F9AD139E5489762C89ADAB47D12102421426713A22D1DB91666B08D37916
      A55954F00F6B78D9A14340361EB2F3A0A13AE90D512F5F1C634470BEEBB4EF82
      302B2B409AB0A3CDCAB55F35F0E88B66BCBFF7D7051E6D1C79368FE228AF9A20
      242403A8E85FA249835BAE45A32886F35D7FA883B079C10713F5A9E26E66032E
      4B140F699AAE475B56D0B12023A5C2482027482258DAECDA55DABF15855644C0
      1B4C0BBCC83AA72970299891E1C0E38DD3BE078DCE7D20B5FD65E64FD2649466
      C903AAEC0E8E2E15C7F312E567A6129FAED1C3C51DA8B60326C2A11A89AD5BB1
      2B2815151DA5628721E66EC4AC5DE982FB610357DCD002CE734FFCAB0255FE75
      520A7D36C95DCF39C07929C2B9F4EC0A09AC3C40D30E700A62760C9A4379048A
      555D7AF2B8DB6834BDDACFE7AF9FF60FB7C26EFD2B1A7B371DB0FCB0E905A8A9
      631559EC07628EAE69BA836C9A2ABF480E051CFDDD69BE67219246E379A3F1FB
      7269DCE7DE6F62AE95037E7476FEF1CDFB1FCE7E975376DB33B90567EC0679E8
      4B4FD9039AF8A95D8A221B1F36DD7962B3703929202DACB77577ACBEF0585999
      C9B83BD69C1FAF46363BBDDD875BCBA94C56199A54FC8D4BB10F78A4D850473E
      A288CE94A7330539BBD066FDED38D66638566735C772341595CF7EE78AAF2C4F
      78B5D38FA7EDD6F393C1EB7EFBC5EBD7FA60DD65B82F39B87719FF8C4CF9A0CC
      484187AD38FB145D916B970B357D482F8D47808CD9591A535B9E38AEE872EC0F
      9BF91792CDFB042DF0531F0B69641EF60FC782CB98F86EDC2224A448718AD575
      2E3E9C6D7B212AE98B265E8CA31F010808AAF0082EEF6A131996B5BA36516B57
      9B68DB9A9BAF6F6D0E6769D7DCFC33918CFDAFDCDCBCDF06A5158F2F7AE0A910
      38172EB04523E89B2E814A1174333FE1A206396CEDE36A500A0BC26EED21D083
      82FD8D5C55091920C520A8D91CC344B030439A61F177C2D643AA8B8E810E39B5
      1BC8BDE23235F6D7908D2E5CB809B8E5E34AA380257761C94C83B1253996BCCA
      D44C5189400E5899A50915E58DB8B265ECE705D7A7A4180B2C352525A7F2A858
      F86E0F8B47B3C66358E385BA1EA5785E9D7EE0891766E99CB608679A1B1060FB
      C1C7B6881E2CC29CA5511AA3BB2DB1BBC60D2331B68B5AD53FBEB3D5C7B3A5C1
      CD0185BA84D95C2A03A4B03E2C14608B253CE60D19B80BC239C1D4A76916FD13
      232663A48829C63D638105AC4C87CD9951561EA54591CE66695E7079CE47B6AC
      01F6D0F5E3E26FC122CBA982F5276A07AC8337A99084D3F821C756C38B598261
      9AE836826D1CA1AEB613773F23EE3677E2EEB689BB920EB152E0DD89BB9F1377
      075F59DCEDA174981751708124304B2F4BDC890325907026FEA768F2F83AA0C1
      028EA93D3A556D1BC73E57F0C1F907E99CCB91534038881124AA87993F99480F
      6BE473F3472753F450267AE917FECAE57C2B8B182C49E054D3739E812C57F1C5
      230759AA274579534FFB9CA684218D8B620C5FD1908E6D28B69AC16C6D9BFB33
      A7ADFAFEDEEA66F7A8BF91C59279D1523B75372707734E47BAD1FB0C23B5AB2D
      DA470AF037512B7AD1534F598904560946A7841814976105301DD8ABAE28D365
      B32163983A8807EB08467F80884D0A08A7535930F5DFB4E3EDE938ED6DBC5585
      9FDBA85EBD59279211C40D0170616CDB9782C328FFD741E9577EAE7471B9382D
      A8522F1589B3FD8290CE4AEA12863DFAF9548909254A30223486D7AEAA1CBAE5
      544A94042CCE0A5C612B281495E63CB00B3F00F2B1BF172C48D98C74D14F6C80
      EE062E951E0050ED5A3E7C4ECF6CECF44C6C4D069AD76C8B144DDD65E0524B3D
      1818625BBF8C16514CA1150632522C5D3730932EF1A14EA27053A60EE8890318
      79546AA92BCE61BA548B8234D14978952EE0872BDA80D791A17E8A7CBAAE2785
      075C0F2EED91DD68E71B6ED371CDB8EA39F687C0467A63E944271D680A7C568F
      F72641C31CAF8F07E51C30491A755FC5F195F434875DE60A7793F4F8046498B7
      549ABB16A21724E324FD140D847055717E0447331CD2E82FE136AFA67FD577CB
      C3EECDFC4267FDF87A69AD8106B90B8432B2D834279E2A3299085C9CD89DCEF5
      2F0C05BD0A20B7534E61904AD4B295323CB51AE0AE02E8D051C5B6B36BC605FF
      12154E14ABA9F3469A8CE388CA4980E0BB2D7D9299CE68768D00D1E74C0B930C
      0E2F0F0866B511A5B9138E1580FF081CA600B9DC992325208991FAA7D9A47F7D
      6E09F85422A072D2F6F73675D6F0E63585438C0B468FF38C9F3FE4F1F0493B92
      59522927595FB4650C2AC40BD12907050E5ECAAD5405B30062C562EB65E5B76A
      A29270D599CBB7E4D089BA86049F26207C559FBC5F225623CCB1F40464A0C017
      69227EDD229D4C62E939446D6228518FA2C5F4FD459AC6723AE5216E23E7BBF5
      2980E58CA2841DBFF8F4A9DE1312F06B742A787BF85C99DFB180796DE9AC9856
      89BF4A9D05E5D90D9FE192B06B6C9DAD7B819BDE3D4E038E715330B09C280645
      A64802A88BD05104543688EEAB95A6FBCC9DDCA11E44DE2F808872FDA66D3F88
      3FC2FB9FBEFCE90DD3FD2D397B25868766E70987BA9481E10A8E52488733BBF6
      F728F805F889AADADB8927D20F638A30A1A41D6EF0F21F1EC0ECFFD5F8A8F9A5
      EEA97CE49D7852540BDB9C71125F647AA810D6063E8B7E235F3AAA61D08A3400
      00AC2A4B78380B663CA50902D2171C0CAA25DFDD29D8DF7B75F676AB2CCBAE6E
      C9412746C344E44470E0B1D0C84A49C4538571DB5E0DCEC925525DC9203E5279
      ECD4FA621683EDF044E493B25180E7E5B10D8FD01726B61A8D691A14A7FB7B7E
      A89532DF3B20790DB4D6382DAC80472ED782BA0BBE06FEF2E665EE612B42FD18
      BEF5F5ABABAB2B10D6FC401D79AFAE7C3A10D2CF5BBA3129E4424ADACDCC940F
      9CD01209B79213BD0E034152AFD56D7B0708C00333F55AA381BFBC7EC99CB2D3
      181C9B699B7B5EBF6AC86DAF5EBF7E7DA883F4A5B32265696330DA9131759CBB
      BB822E26EE2EC4DD86F1690F132D321168CD8BD01240BF4A65169CAA5BF207B7
      36CBB151E224625330018B8048C4E1FD8773007BA6E2881252A58B498876E719
      D696705EED27D7E853382C570FA30D42ED9DE2D0B95925EA055CBE840208D9EE
      8E54D2E21D4DE4DA10335D87006B9BE862666824D3AD6ED96F9B781F467F0780
      BC7959D7FD4AB81A895DA12034AFB00E34F9FF21F81B5402BA4F160F5C17FBEA
      2CFD5C81A82E0ECB0932359438723FD6EBC3804263B3CF9F6FBA96C29B4902C0
      87796CBE8400018636DAB7D8C3478BF0090F233631C4196839CEECA4E6A11532
      B1E1D5FF94AB4598FE05ABC77539C85802061F3D8106D79B848DD769F89F8188
      D01D74C8E5FCF0D89455E25EA6299D04223E2EBA0946BB246CCB99F94745FD1E
      31B8F5C5B577EA93A6B0256CBDBC76B720843032A6BB81CF154FA93A165F226B
      325B18E95721D6D49D33519CDE3742B79F989D99559C7E3C3586604E5FC42A38
      98101848352ECE6BD23809F363A993C665F20F03F31B61CC4CF1766165D469A6
      40EC8E29E47AC67D8C81B47681716AB2EF8A27F0DE4C89515CB2E50BFF82FB02
      EB675BC065802E87250BB45B498355639A8781630588BC7CAAA1C789FA789E23
      79711D3F49A93172D1D30A8D8736F73EBB3F222E956D56FC4EDDE479F8071EF6
      E19F9835C76B1791CCE5E85C178F37D897100176E017982FE67B63609FC0C217
      8592927B48DE74491C7ADA8A61BE483E1906C00BD005854A4B4856C1D7C5262D
      A9399CE00840CDB75047B3CC748A1C5D9B5AA330F0018608E995D3A156078CAD
      DC625152E36820A0CED3A56A09C6BB0DFBBC3C3D9D13B78677538ADE0372EF97
      F0425AD3E6F9D7F79E76D9532FDC1CF732A7A312C8517BA8B560A2E743AC274C
      31BE8A58B28B5B70F240CECC29CC01F1198F1E5DD4A2FB43ADF30C5EF470EBA4
      65B8EB14A2ADE95C861475C34B3B7D3EFC030FD1F0CF4D07AE7CCF8753EAE192
      F9D72E6DCBE59677705BF414D91E29836687A9909FE823C00AD7B2902D117190
      684B92B8F1824B8B710DA5F55C365C908AC2DC51EBF62AC31BD88533C34D9893
      D11AF721B7AA219BF5C8F461EAA95967FCE94F3FA3A90DCFE7273F8A91CA3A9D
      6B731BC9C7A5AFE1658B394F032D09D16CEBA5F6134768A4B4761627A96CC196
      6239AF5DC46B57A826A1CF0838BEF524958BC391ACE39546124393D15BF51872
      2EB80E806FC88EC84E361ADEF861B61D5DDF5AC317681661BC2D2AE6F9D431FA
      61B37ABD7AABF364EA328B8A029D0D56F224A35F1E64E8B863DF85EEC68CD52E
      D81E3B8B280E9512EC4C1D0B4169C7BEC1F5DE973B276B943C73EA39D5E9E6F3
      57671DEC46D2966E24EF7F710D97113635C8225445699674BA2844E09A28737E
      4465E46190EEB3B3B357D2D0A463AB6AC8309BB66ACDE3052C373F2AAE6E5750
      FA2E355FED92BC1A9BEC8D5159DB57A38402C85C2317D7CB72E6756828860001
      A1BDFC20D797650F9586F2A62BFAE224680EB786D7DDCB734A13328D017591C8
      8D38B0E162A9A0DF6F3C701C66BEE9CE1068C8DCF43C8D7DA0D46BBDC012BCEC
      AA45F2606CCDEFD8B29AAB420CAF6C85413F4E44A5845C4B91ABFC97A8C097A4
      EADD6B833993C8C7DB4D7211A51BC115AF79F43832F69AABA3A46F9FB2773F10
      39B6AE8D13C147B5DF2DD9EF8D82EF6732FBDD08BC2F6E5CF11449E106F2F0F0
      85B7041CDE5A811C5CF2DA0CBA0F6360FA911F7B2FDF9EE2819FEACA4D72C29F
      BAB4FB51ED7DE721F65E1F9DFFFBCBC76504A04274F7A4D14FA544D62F1F4B9D
      0D3BDE2F1F1F055A7419AAA754B71D5497D37831D2B6C2CD63C7E6E77FCCF3D7
      EC0DDDCEAE99ECEB4EAE7724ADB693A7EB26F8AFAD08EDEFBD196BB5D9B1CE39
      C232755492D8086DCE400792D28F48B70596BFD3847C58E4AC92907DACED9717
      B6154124511F315AA6AEDD4AD12CDDD8C7CCFDFA35E813127B145518C49156EC
      9C38F9E60BF27DC0E4A80B8489A2C1FB47800317477F690ECE63D4FF31CBEF1D
      83D916230A81FBA4936DC1FFF3E98AB513469B3827D35848EE43B3525937F48D
      AB12C322FC0C8B1FE9DFE474F9211D2E3E0B79DD3B08D2F935EA00474747849B
      076C508866510C60C7A47A8E643EB43609C71261CC13266DC85882B947916F8C
      5C7234E5C45CA70BCEBA5195D3C61373F40AD4583225457524071B8D0A1F3846
      6B1219DD854C1FE857CDD3C438784DF68F682D44430EEB46D1A9DB6092DAB8AC
      92C25D6499923791A5A404708E759208AF9F32358EAE5C858882C89DC0167188
      02718025A2D19A2194780A83BBB84D08191F2B66C17726900F5463AD8409A0D8
      C94B6647C9B8BE0D6252493715DE1E41F1585CA8A792F4F6108A3400E749C1FD
      F2547061FDFCAF4B08AF41C9A455136D79A41CF1E8844DD2EF64E5AAE2995773
      60F7DBD1EF6E65BADFFECFEF26FEEEBF015D497716E73D3912B52F899AC084EC
      30E5C0BFCA84F4282FD3053E7F1A63C91458D76991C57F7B955037299C32CF93
      A2394A8979C282C8A75F8A6508E2547A0132C5E0757CF82F9B3200C7D5D08D83
      D3EA59AFDB1A7EBA3E1FD7CCD5C793AC7FD7A5C6A636DA808DDA70BA7C8CE57A
      F7CC1CA44F7E8CD57BE8C05068A16B2AB8C59CC829A5D06499BBD5E97253896F
      1764CD995100F82767064048886C062446FBE091393DFFF896401D32F605887D
      4FB684AD9E10FA4996E71782CA323E2A1F73E4BD740ABF8DFD38B7A8CDB64B4A
      C961DF1BB18B3A0F3C032820D59AAA38E43298F8AA124D60B2E607D8BEDB66C1
      BD93BE52F0D7FB0108F09C2DEF350CE7CA8BEB581D4A8362B33C74F06D7D5ADC
      6B8AC54736A06DE54793295619DCA6E40440025EB46D8AA30DBFB057D9357731
      AC49C778117130048C63E1028C0CA0D4521D451E4621326A137C2630B5B1B75A
      10C4B4B9041DCD7A2CE45EFA76BAA2AE40E7AEBBA3685F2C853F5B22FF8A67A7
      B3EAF1D5CCEFEA3AA5C8385C909DDF38AF6D3D0DA725A13DA582C44050889EE4
      5B7524F6F7ECBA5185F7C6701E1699741437C4DED40C6131264E51CB88668A03
      E2F0B6494A8E593C465E0C5A1022395E71D58D39C899562780D761E5532E3950
      9806B0530054AE497D7947EA56634BAE5996E2D9E69E933BC4C51D38434D4A0A
      C1A1C0AA6993CCD71CC1345DAC93C2A1C31260609F5246CDBB4D88ADB9C47092
      8495025FCAA02188E972C735B4825C460956673934BD2C724EA0950A47A20249
      6D85DA4805BEE9664D5DDEB5CE2460CA9104A58BA4307E6A0A9735FD1DC87873
      788491495306804FB3A41853330611AE24A53D04597B8E55AA82688E626F94D8
      9C69CCC461FE49AAEAFE9E9E2E49ABB072937A834C5F34CB4F3A0907290F7511
      9EAF801F0E9420C1C5692A9DB498909D4B37AE178535853311A16427F62A869C
      1D13740C1890E936AB34D8545DD6E096CC041C49E34F1CFC3BC75001A94645B1
      C99515C886C09D160339500BE929AAA8B3FDBD7971BD2A7A450746CFE7F135AB
      FC07AF49C5250D029F37B33B38726424C9793345C3E66994587C47131EA23BE8
      3E380E953E00764101670C011C08C8D0935C4C85326358B684391B45CA4287D0
      8D2042614061C8B6018A8B0054765E4813674027D8B83D89F6F7E0DD372D8D93
      DDFC0B45C96E4416949F5F8B4D11D64024AFE2E5AFF3B154DA60838AA46C1605
      89D31E563699E5BF31620926054EF0F4F128B402BB85986087A8458702094865
      DFBF16536C6D8429B67A6B9862AB7737C3239FD1B38AF96D4B98E1AFDAE2ED54
      1E20C30A05F3687E52174D7E2DB44CF89B9C037B950E8236288AF13B3116DF7C
      7924446EE4AF54123C1D73A08C667BAE81CDBEC39413F19DE206794A760CA4BD
      61247987EA6AAE73C6A2248C806BA2B05B3A3162938CA89A06B2F3DCB50251B3
      63A1018EAD0E1F2477039CF80843B42212774D4577FD06878E739604197439FE
      C28D4DD6C6A4C88D81DDF2D3FA8A2A373D7BC9791704AE8F8A28A9D9BF2D39B3
      E7CCD4A8940895E54A5754F7A033944A051D4C3416B801C2710D2C0BB6BA2B4C
      8240BC488C1D01F39575106BEC9E14893BBC2CC9AD4B3E0CE64EDB8EB9A7BADD
      F91622AAF86F30659BE3CE522DAB386A58228A7CA97737E5DE71BF78EB016819
      C76EC93BBC32AEBAAEF38313F1B5E07D07A7E5B71F1D1D1D588CD70979CEE1A2
      4A7C488F6908B2D9BF73B216F6F75688C4BA208E242293719F5F5B61A3F0A25C
      C45A09CED5966FB7C29771F0C172B0DA0F05E425E593870A599AB900E4FC4184
      2009B1719A520AA784B89BA2489CEF5F7858CDB6F0DA262154AB62355144FE86
      B0D75ADDA164B75A38EDEF193224D52D64419F9688927FF326D4C55588AC960A
      9EA257C88FA54AF2D24E98B24865EAE79425E25D307B4CDB4158C1DA8DF63D2F
      0922B1EC8C9BAACF2A2FE63446A305ACC0A86FD9FE9E004E641C5DEF8DA64599
      2F7418B448C2CE1E9BEC2B434B28F748992630A42CB94873E49D90C685FA4094
      998AD1DA416390A58C693AFF54AB1B5A0CAA2090B90FF1ECEBF9591E0BE5AE40
      677BC8F6125E703A3729AF11CBE525BC451A6F31562D09BCEF59B5761DE1E44E
      291DE93749AEB2E2C8A8067223B56F42659C5C3397A0882F1102A04EA7DC9FE7
      E7B9F74C7F7E49FAC8E9C7D3CA3BA9FE8D7855DD91CEA6D1B8F81BCF42D7A0F2
      0B2704485364E209A4CDCBCDD8EC2731A51E8DA9825E1D8DD70D7344F69CB297
      17FDC21F4FF57CC5535F9AE54BA03478D531B5BB014FF4CEB2CF4A2C28337124
      992027A7E28050ABF8BA9CD6C45E2B2A11E72C30E7B7D4B95ED66524263CBB40
      27B89CC3C72F7D6AE42049C5C6B0EF53F17CA755B34D02A40E16BB8E2FE5F8F1
      D5DE84BFAAE58B713A3FA55A85FA38635D231DF906D290563AD084292E4FD976
      139463680B3B3C3FF9716438CDE3D8EA738E9E7AEA7D30FCDDAD9381863E46DB
      9245FB71AD617FEF2C5D6481C2ED72E414B6C45796C122AA31C65BEBBD1174A9
      9096C43AF1B689D1984BD33AF8E01401143092650320821725CC095E2DB3D333
      A9728CC7014458F188D7F91409AD0B3313125A2F23353A30934788D3FB7B5CD8
      CA7BFB8117830E53D92C8729B884DF045959E7EB4CE7E861EF4BDED3A51D74E2
      F6A85497AE1AA131C30910A20739B8EFF997249154C1D5BA530641AB1A8E0D2A
      CE67497DB3D3F9725A4F0FDF96D847F1A7350E641AE6AFA0F9279C2DF6B49AE2
      552E5464FCEF33F48066A84E0245B091CD8F604701495F60B835757324670AE8
      C78B52FCECA5F14D51181BD5D7F5F92990D4926BC04F1D8A6782352984BB7A58
      A442207A5C34AD48ECDD3C961E69AC4DC92B47D24587D60C743E75ED20B9F62D
      F250A660213617851138A3738B54186E82261C9ACB3B93244D7601519B67DCA1
      47CBD654D592A4FBD135C77FB133926F35CC70962E6CD8D70BD9EDB2BB77C491
      2A58C6AA30BB3A8930A3D2A788D12A95D4F6093220A01B9151111D0A2ADB09C2
      65DAB8DA3EF05709C2FB7B3F95AC50EFC50A2589B446B734BA1DFBD2552196CA
      99AAAAC9C631E6FC2683D4B0B2586E23990E1F97544100382D854AA44C6F443A
      9065A0DD17637DC99B47CBD476B2389A73276A6BF6236164C4E1336EE9D9F754
      B9003B986D4DE39A95B6BE65A31DC57DD7571933B541CF89745F3268AEB3DE38
      9D51225D8FF8089E9CB0DD7ECCA65747F473EC97E5727DB40AEDE874C6478B7C
      D58B7750B1D5A2DDA614F78E5B31A11C0A6DC54CD425864290B1C30C4E268572
      F13FCA5F2967186CAB69B3B28FDBE292AA2E9B70BF527B82B41CA2516494D276
      B391949F750A2E9AC11CC74B2E3C1D1D239209A89D063E8525595B9D415549BF
      70DD379CCEC4B59AB8AE0AF6181F595D2C4D10A7309EDCE8CC1F30E469698512
      D82812EBCAC5F13D516E4C35B66A38CAA14E2A92B8EC48EB5FFD26A9AE3B521C
      3389B6D675D6457A8B89DBA5D68979A960754591DED6B3FA4A0236B7CD7F7C92
      73E0AD9F5B0F259E1F7B6ED0D28EF10BDE0145A4AEF1EA56EA97966327C6EBFC
      C74E52A31482E56E2FEBA3A0C48C82489E9773B8AC7548CB32740EAB8CDCA790
      1F931EA54376CB717DDB7E1A5EA2FB63771C6E3E0E042427C862A327A2E420B4
      87403311E35C4F74BEAF952357B13F360592AFEB2BA66A3C16F4FE59B7A0461F
      DB0EB397309B0BF190F312B0F7A110DC8D1859A2FE550DEB733A951B550FF74A
      0FD124650F6C66B2BADDB811F8A9AC3DF1A8ABCE9D59AC998913D1AAE7B2E61D
      383DF74C7E3E0CA93CAB609AA6342E6B87A5505AAE942E6DC6E4F5E49E366A9D
      F14EEBF467372D69DB73B64E606298213D9BE3FE9DC9361C6C0B4928E5EEAE81
      05476950A1E1A7364830C67AC6D4A5E0B7ABDFB5E7F6E644DEEE91772A21171C
      271B72DC217514632586BC565E3EC350B48C876F95B2DAD74F83E43DD3DDD206
      39549A2FAC8C61E4A0C5A585BB946E8D75A46E92924AA2A87E29B90B7091F857
      66F049A202CBEBE23A3A12DDB6BC1EEAB2269D7F757CCC8A1953F1E6424EBE35
      E1E826C7AB029A5702845A4DB18B65DB29C447531E960BB9FCA64B6EFF6E252E
      BBE3DB4239CEF9C4CCAF5702C19E9C9A49ADB8494A28C5AF1EAE28CDEBA88994
      E7975E72EA9936871389C2B61BCB470238AA3AC25EDB992A165942BE22EE2C83
      E69ADC54F335FA22BC3CCCFC89E9F1C934C954CF2DB5FC143D937B1AE295BCE4
      C5CFB07767B2BC440997A5C433696DAA8B71CCB3148035732C651A96D61ECF64
      9BC16F0BC0DFB40FD568358282E80D524F1E977BD38E528AAE53FF4087A470A3
      7538B0A6BE89DE68118074EE0EFA1ADCD2F52411E9E2473B2AA3F9A0EEB089F4
      991237B782A270B2B376EAE2B275339B3FFF00006CB25B08A77D0994375D6749
      F75BC4E3559218E8AD5C065CB750958DFD514AA370642CF9FA4E62898D3599BB
      920CCE1C1D35249DFB9393F73C1A9786765C44F45E433E13AD17057E2E4A839B
      F3CB0FEB1211D268CB278D0194219DD96C6EF433195FE860949916481C7EB4ED
      A7FA842A3D7166A478E6B6E23473DA6F90CE661C9698B8DDA89CFC79D14DA7BE
      30239B442A6E4C0C922C25A6136ED69C126272634479A96A364F615DD7B61CCA
      A5CF56FD450252B1671A295355AF90D3BFD9512ED5B60F250C1C8B1068010023
      3631165F81907EAD5BB59233C6E0F766FB1911DABC24503C4CB3A67293482C2A
      91EA62C435F3E97B6E62C0A94975CF5C0FE320AF7BA7A7F96129AA0B6BE972C8
      CF0A400D09071E164CCF7DAC1B5C1F617DF77A00FFCE375F43D802CE543E2885
      60DC02141C5146091E331FBBFD04F1024B5368F0562C40DB4A3AB53B0E0E7649
      74DE12FA59AA59B64A85E0EE8B58FCCC2F143BC2A2E4E93CF6038EDE49B9B9C5
      1B2C5083A53505CF72892F3FAC7BAF018F0BE93042B198918A43297C8199693C
      A81D8B13E9A9A455418DF8945397EDCCB182AC9A070FCE125D8C11EBA06381E2
      107207F99C6B3ACE532AED038740A2976B8A2C20244049AB6C473B9C2E26586B
      A96654208ABEE45A25FE24890A58EF21DA5042A762CCD69E272ED1A69DA008CD
      2D394A486E57AC1E381DA55F22C35F75DACAA9AEA48C652C8120261FCAF9C3AA
      69B9C70546419A8838558DB8DD2853FE8524F1EB6EF524DDBF660DDBCFB0F33C
      BF0C2D22DB8EA1D851ED5A0A7F6C096A9E100DB30DF6508AD5359E74CD2F0688
      6BC009A69172E2FE0E187095AA49A7BAE4D65B9074B3FCC035AA71315D34F6DF
      F868CE85AAB91458582EC1F55B50E8DBF005F9EFFA69F9F14D88941C54DFF3F4
      1D0990BF0230F41375CF3E8DD7DDEF3C9AEB046F97A7493E48321E4605DAC95C
      1397D62B287A2CD41684E501BC9A3170D9B6D1878EB9EC4882CCD848884714A4
      666D1D2CDC1262E691BA27151E499DE17ED1E597507563ED8D2B55B691640651
      420AAE0BC4EA37F5D12B9739A0AE57B429EE1370A441E15226013049C3525C5A
      3955D57D7DDD691A89B53C8D0224637097B1FDBD687FCF785E2FB161E593428B
      AF3679A96C20B415DBF40D5C3BCCE93519825E68AC24E624380B93E699479E3A
      9A1CB159C42984263751244FACFC848AEF7100748AD5C6F051D408D1BD444840
      D31F1B8CA7925D5C2A53764F9165B2522980C60624084B5E1BDFD92ED9A8FA3A
      A70ADE7330C634AD38FA271AA66BD225CA1C4C06AC7F7DA8EB9CC12B73A31DCB
      66688661F64ED79048D1D90D47CB6EB62943200D17A35909612E7D67D23AC8D7
      9692D798862DCEC9C003447211148B0CCBA4EDEF497DC01A798AA4A01C5AA533
      5BA1C1178DDA968F9037676A06942DAFE2B6CF7B46457216098A72459A127FA6
      32550BA463DA29E59DDB5A8118B8BDC8A9AA85EF81646AEAE34B788C49245AB5
      2BEA8A62FA5976A53A1E643A7037962A0C97F6FDC0E555847BA7827B07F884BA
      C2B42704AB53FEE70045648F892181FBAD02E671C0A03FF8DF0B143DCE5CF2CB
      AE0BA61A2553A2F69EBA44F2E0C5B5F7C2CFD54702FF8194BE202D73945EE9DD
      14AF890E9375FC8D6C7BE5C2B4EC57C17A5FE68EDAF71E89F49CE8E49DBE7AFB
      16F7C5B78DE7E5D6C3CAF9A8CCC3560CA97B7FAB7B4F79F5FFE65DA8EBBC5A0A
      528C9D00388E6A0275FFA06EBEBD8743AA81F726F984529709D6382855C8E53A
      5F4E8F7B4D95E52809F7FB20659C7494A13E11BABC9373AE842172E2982EDD24
      111DD4D4CDD7C904BE5BEBC46C82C914A0840DBA512272736546D7EFAD44FB93
      3DD64638CE4BF6DD6D151D3F028D9A8A9371FB3AEFBA615406CB7590F9CD3576
      73852294765A8C144910680FD403FAF172DB11936B8C4E3D6C674D3C6209FEA6
      9E2C753B75BA9F02E1A029D9427D3A613EE7624D21052D1C98510FC8BFA14B5D
      0321BA4683A4F18D00B186C54ED95C69DCA6DAFDE8D6016539C735D089473A4F
      9983B223177632B800928DC41F1765EC12313B47014853F2ECC2F947E628EFF4
      8B4A25D90F4C1757C1C6EC1301B02EED1F5DC83ACCC50CF16C91D8E1346DB60B
      59E4586971595A763CC834AFD334238FC404F45F295E4C8132AB262A05FC73C2
      1D0AB41BA3725B2C12A7A096EC1F9C126A56414585B92C1607A3F81E96C3465C
      04616E92913487AE7C93B2803FB3EF1B2680EC2767843D3B7BB5EDB44D1B420F
      4474C0CE3CA09961B00335E9F9912A816D4BDCC94F3A4EC256AF462F004B0C40
      06D02048BD7E5C68399C5EC3EBC87B2185B1753164124B537226BD3B393B077A
      353247CCB8A51CA95822CC685C324D3E416CC79AFA6E9A384AC075912C898FC7
      E8B7A26808DD319A0807685770921390465936A9E1F9A1F38C029F62D91B13E9
      61290995693DA4033257E95CA71685A9691BE0C3336AAEA56818CB39AC44B650
      75C543C70E5FD303ABECD662C661C5966BE3DED5A2376A4FE2DED415C3616D2E
      EC75113BA63852DF1C608E69517C5BC471ACB956B30F4EE0571E22BFB96CE04D
      41C6AB5E4B1BACAA6FA63CF07C61F56FE51432175139A7951A61D714A0D30325
      DE3F16B049BA658FAEF172406AC1ED1663C37BCED39237D49492D789A32E6653
      EDCFBAEC14A5C06B01B31C43B179C71B4F8366812FDF78B75BD23474F57000F7
      86D7F0E6BF0050BFC2B179337B99027437EE643DF27EC2187BC52A1763041C52
      E30797B2E74AA243A4699614314CA886A151C7C2D4BBC07DBDC411AEA5515688
      D3DE76EEF866868D19C8B89F0B65210B509E66DC87812C98A29CEB96645BC22B
      5D424A7220F70C146FA1AD0FEE6439A0DC67ECCA6700434BBB56DA8FDD5BBC1A
      11532C63B72C7B1F1E1852CBB5C63525A4C067DC205336A54A3457BEB8740F9A
      273E0A6D27DB119910E4C73BBC192BAEB51D83B2A8DE12B508E4159636B6061C
      3CD3748D82D0D9D54F7C47E4042AAC6A5909BCE993F14489D125514A0CB223CB
      98915C5056078801A8A471D687C3DD39D4EA5344E23E87A78AD5E050AEC61873
      400D68A8C87B4841E4DB4E2B4C6D3D36C539D22039C0B726765BC287D70041A7
      835432395CB31E89B3C632CA16EF5767EFA8CF2753DCB769E093995B0A04D916
      9A1C0C10ABB239FB8634B16DC5D69FC8CCF1518DBDDF7E7AFBDF1F9F37E87FCD
      CEEF78A4B5D1DF561AD4EDD38FD495DA123CB610AA49D1440DA3436DAAF25740
      0AF1CD85962902E44415B2EFCD29B12A7D268078D846EC4C792DD53EB40679B7
      4B8D6BD429325F2A527FD4BA44889D95AA66333A616563D2B69E831F35BC8F42
      5F17FB10F6B815787EEEA02B6815ABC0615D135A6EA050140E2C2C6596895323
      621A9C9061D63E4DDEDF9DA840ADFC380FE6D414CE4A93554C6A2B3010C0C105
      C8D6670C4A715B829AB66B241CD4C746154CEEE612A4FA9A71C349A042A552D9
      91A73321E0C5E5D1C729DA1F904033059601DBD8FC8E5EB1EDD8FBDB2F2ABBFE
      DD5BE153DE16D5777D3A5119818C35C69441DFB099E91FB80728F99ACE729B8F
      E67F2A9E68A780DDEA26EEE5300213FF4FE59FA829DFC4F61D5A1D1A667BF171
      2080084575518BEB6469DD300831E078151897D2C2EE19DBFFD4047851C4083B
      489741C6D613D301247792B4D1BF152F26F0A2A3E2AA309E463743BC54B5D289
      0DD0ED81A33177B206F18F9A5897B2C00EB79CAE3141FB0DEB14FCCE11373B72
      F615C81999531F8E8CD9E20E405FE04FAC4C7540E704218D325673B1EB9299C1
      10BB55A181954A0EFB7B58D192A3D04CE0E452B79024BE9640A39F136E1642DF
      74933CA3C949BCEC8198220F4C0CACF5891DD8846A9CAB0E145BF7EEA307D93F
      0480ECE15F4243C913C68CA4EEFDFCF2635D1B6BDF9CBF3B8025FF63410164A4
      F1CE59E36E538C4A5E07B428536049F7339E3A46198C5CC070600E6628F76E3D
      78F1E1ECECD9DB0F1FCE4D901EBC1F43514AB17A5A66641AC3E6658EBF2B17FE
      5864098AB563EFE08CFADE7B1FF586A2F95B25C69148592EE88F3395488C2100
      D6AD9367837492A09DEC90F304B01FE5C11B0F7D531E3AA7BC374F661EF9A724
      1AB0E6F448D6E939C07433EA08BDED72EFCBCC9F3C499EBCC4CC2280F7E5342D
      197EB6318FECCD8AD4311D6D548DE55AABBE95008951006E790CE9445773A51C
      36F0022538D4A5AFB4EE9750C83585596D3BB6BEF73F79338C5B8B1C1FE696A0
      E56BE077E7AFCEBACFCECE5E7106E2874E1DE3EE7CE2F72A9CE85AC1F811F3A9
      2E986226AC84E81841E01DC05E75355BDDCADBADFE69C6143A8C06E0FD3DFD2B
      268A502C4C229B51C704C74446B42FC77A4D141817AA2B1BE583F7CCA86E7034
      2619A038F26A1F75C0DC128360650C390886F78EC74787DE096B13A7FF45EE16
      3A4EFE28A230BB7CBA1883AA836210778CE6B413A73148A5DE4A65B2B21269B1
      865D10306703FD917EB0BF8781056EC84E69805C472C714A0870A831B03F0AD4
      8B12CC2AE0F096C4E16DEF4F7E79C77C8DFC9A56600D415CC28C9F09DAD229D2
      215C044EE425272901D71C63C6288CC4991624019940A4D5E81250AD9F28E7F0
      450C018F0201876C7AAEC99C695E4DC410EE846D0C52802608090537F6D0A67F
      E70E5E9E9EC4C7E520476B3A9533CC011C147105E7971D60A52858C2698D6C36
      D26A75702D9BDD282911A67E5EC6645A2881BD36027A6AC3BA8AEA7D4EE361E7
      343960E2F37688AFFCFB6236B7E16E265148EE73E29CEADC9B8FD23F6851929F
      BBED54FD270C70F531F369515076B3686DB43DD962BE2D6E0BA7EBBD98389C36
      EC26A53092332AA535F1092CCD61F329089875E722C639F2786EBF46BCF9B7FF
      F3BBC98E020190168D118009D9A57410A3D9073137F3B8A622A7BCAFE40A9496
      2384EA78D787FF42B5A6A846DBE7152F39962DC16AEB70D79CD2E9C3052510EB
      D226897E9DC195FA0D73E296670687DC194AD21E4A6D51B2D8FAA030A901B7BF
      877880714F5B72DECEDD2296BC721BEC84A80F872EC4F356EAC5F52330ED57B9
      F6A0CB45AA80FBE625FC38C17C88F3A989B5C25477143A0E01EFB10D99C3C0CC
      11CB409435B1D1B14FA1FC31E9082491F841063C0E74DDBCD46A673B91757F4F
      F7E90E555CF8DE9CE2E728A5638B50F7C43B70964F7619D3354322B099644ACD
      9D52E22209619AA300565E522EED656A530480468ACEA9ED6AAED805823248EF
      14CA84863E1E1F9F2571F4E01D562398284EB9132BDE116616621C2E87E355DF
      E5DA28817C83C0CB11F96685D2C3C066EEE05B2AEFD079CF5C7A2A33FAB68B27
      260D901DAC32894A732B3A979C76ADF9630B26B6F2669321A49B2294A62D693A
      C06FA2D8CF386A5FCA46BA5447374F7733238100B86F3420E29C2E0DF71BCF82
      25667E7E914B3E5BA240ABA9AE85543B670FD8696DBB7EB122A6D3A39D9755A9
      19ED12858EFA6C1DD10907A5B79A5D087D1888695DDDD95CA72A311947614647
      B01D248F9B3637B5EFBD574424CF803C621DD19FA5B0B79F387711C28326D4F9
      41051718E351307A85BABABF5E0950E8523412CC3E1281CB599A6D82E8CC9680
      A78A694A814FCB7B4B8910A042A23264EAB2E97E39F11AC4A25563E28C6E648A
      2188FA4E5DAA5C26295B96B85D6EA549B7793DBE5CB742888C9DBD565946A67D
      74C0E44413459663A9C4944FAFE5883C114E14096DD1D715384260A598DE7CE9
      5C1213BD0BB59A2E5391E543C94A228E369B71790B1A718928E492298C701445
      9CCBDD899B589F6D9B81F9D668715501C265DF0E7488BF637CF24D1CFD43E2F4
      D9836122ACCE07AA71C141E844062A13E7EA0EA5864965CACD8F6250338B2346
      0297C827538F0AB34D81821B220D02CD0941043EBC600F81EFD1628B9FF0ED27
      2F8EF89E0920A90EA3C2BB70844B9C34E5644ED0BC8F4E5D74D4BA4F9BFE9395
      8908452BAFD4DD773C3274389C03C1ED0C4E844D00ED46979FEC2555548443FB
      5C6E7989E3F224EAB2B8F2B2964C0CD8EE128B7C3896860912B02C5D4CA6258C
      85C3EA0CEFD5A47BA0CE89BA01C34B89F2FB7B421E345C2BEBD4CE0F4575D29F
      8EAE9F9AFC3922285C0C8C1B519CD44DF642F5BA26F5F67A657F7F4533185594
      94C821C49EEA59348852022CD12C09B5971AF61913272A514984C205155A6FEC
      CB41C27961D31B6EE271548501F306DC42088B8CB4492C69882E322CC49031D7
      D134097FA949294BC04E029FA04BF5CC1F3A3D209D6E9205FB4C0AB7B60D0E5B
      2277E82FB315D9E0D1F12246386335593ABC99AD3F236DAC9DA1C40C29AA1990
      3BDD0FA3B43051418C49D56DDAAAD39FB4D4808B78527072553A51E455C0705A
      DA53CD092AA313DC0CD472B61CBBC01092CAD663AA9922435B8F7B19425EED9D
      6F52B8588527708BA823F44B681C81787F4F9AD29A70169724E4CA59BD70739B
      2E22D28BD8BAC3A36D0F0AD1A214A022FA874D950127A1D50A505BA24F114C74
      111C03113FAF40C349FC452D08F017289C625687982DD0D2A3F9D5C78DF84195
      17141E39EE538E87D2F8B6EB42704C407CBE88D89DA2734172B6AD95C457CF29
      C084C399236F65562377E3EBB7DD8CF0822C92E4CBC1BA86DE8F2A9ED7BDF7EA
      6A91034783EDFD212A7E5C8CEA18B682CC9A1A700373CA141A22FDC9D63427D5
      805A5714AD623A36122C164CBA8C9230BDD430DE350C2F370C6F7FD586E188F0
      DE536CCFAA3BB6127D29559A791C3B650E254C178DB6F63B9E433B6B9068099E
      A2DD63F23749AF13316F28A79EB9A9A4922D12B295F9F9E35A34931F583109E1
      24C5A1D0358E44688FD10F5B000F009A9ACEA958ABA3256878584F6646215CB0
      F6DCE933F038962A14567697F7485FCB55F60985D48FCA8F9F92741950D53F32
      18909CC8F773B13B5443042298C3EDBDC258680CA789081058ADE9712D5D3394
      A7DEAB78462EAAECE4E7277989D138C7D2FB6F2C8022120A975B02A976515015
      973C9762D036AE6E7F2F4D262955E15D600D9412BA6834D97649407A3772E53D
      80399FBC2DE1EE4EC99A72E0A64EE2D72509579A8F2BC032354ADDB01DAB051E
      BCA4947C3B9ED038B6722C97DDC26A84DA5045C8AE5B6361B0F2084BBEA04B39
      723A83B35B9CAAF8D01BE505E27DD60D82B61DE13571C9D42C2250B9B0DC12BC
      3F29239009A9C0D27E30A198245A44210D2CC6210735F147412C6A901251DB1F
      31E6D0A0624536F88F8D1FC940698B4415166BA932911C332AAA5A2A578A71CD
      A4EB6588C81956B74833537BA05209540A9EDA99448EF76D1E63F412D9B0F4DA
      703C1DC2040393C9112E5B390B2D400AF4C98465A6EAF87AA652C047C71B6A46
      65FB3139ECE7C87BCD2C89CF77EE78773E49D5E828A750583B35054A84894AE3
      1E6A18CE21ECD0381F40D4233F1ADAFD1749545C6FFB813FE56062580760220A
      C2DBA2BBE2D1595EBC57631B36E130B6FA5CD5E673A9C5A2D67ED17E3D85055B
      970596C1E1B7E4BA9A1C10D668B698C95B0149A77E2CBE568975949F4AC97052
      52D78C6B5A41EADAB612D1BB53A4CB8A74E7AB2AD2FB7B677A4F9F122E04820B
      BAAA5DC462F96D76BE8CAD42D68D566BCACE932389CB3473B361AEC3480E0E6B
      0A672FD3A3C295FDBDD71155A61665AF888AD8243BD4DCB4F7435B79AB0C381D
      7132932017C00A4E86A2D876E64E800923CA13F367D4C1DD6E8AAE73482FCCA3
      7FAAE55EC506DC12D42E462C7225E3138F11A2E748BE18A486E41466A1F90D8B
      242F2D17CC271A682D23A6503E002A004298946047AF618A64BCBFA53770262E
      05673821968F09686733F4123F45C7E308E3DAC57662E04981F38CAE470F0EDA
      373AD4A6C04AA3FA450EE652C30525E9D4402615E93DCE844AEDB993A547E7BA
      AB019EB8FDBDD5670EB7739EA524B5A59C0F984FB34572E1E5A9673A2BE86171
      754EEDD69B26B509DCD956F1ED47047092DAEC0F444C359B17D7D830799B64B9
      83CF80A2AA10A9841A3F3CD31D20CA45CC6F6EAB5D8E4DA770C79DDC5596BBBA
      5F55EE028A39E32E403E37C7B655F1B91CD9FE1EEC3B55BFC7F4760CEAC4F6DD
      12B06DFA3DA130021246B1A008AB172A892689FD35C5B04CB47921B19A466168
      7BAB3F0E2C78336669D0E4FE57A16060A0C391B8AEF6144F9206CA61DD3944B4
      547E9617AC73271EDDC2ABCDEBDD1A8BB7DCEF77BA172226DEBB8465F5C66F39
      276235854C4C0A708AB9371596A29A5625AE6D02E4B6B70C18170E159674F0B2
      0CB25F0CC856D507B3056F74D2E9E89A0C88B35C0507D562A3DE4BA933CFC7B6
      DB2845A149FD03961CE9B5DCA18C4C969462C54D9CB026D18AFDE368F0E529D6
      A8BF184C6B2A0DD989AD2EB21C8ECE62CE46CACB045B151D72297C58BEE9BCC1
      467DE1BB3C271D0767F46250DE16ECA742C79F8954E56EEA6844053C6C686324
      AFCE7609205760EAA4AA96CBD6EB0E635AFE34AD5A35FD643850CC308161DB85
      505B0CF824460EE9E3BF649C823B01AF95D469DE9E141CF76C7F0626EBCE2BA7
      92670BB542D8AC7B8B249740341C2D9703078C8C8BFCE787C6EF452F760D92F0
      957CBC11B78893EAEEFF43FF9E7396848FF9F67553778B2235E75211469F0362
      9F2DB27A66111A4FE334454787647746B672D2FA0DB79B5A5C0D9AC7F06FB3DF
      6EC19F56AFD3873FEDE3E30EFCE974FB0DF8D3ED0CF096E34E136FE9B55B784B
      BFD5E9F0D3780B604E8F86690C067853B33968E05DCD16DC877FDBBD0EDDD739
      EE1E3F28265193F47BD5183AF1BC17F8FF0246F87CEA79273A1A7E4B4E130B69
      066DF50970BBA920DEEDB06E635867D10DFF5FBEF1FF0CF2795B837F583083A9
      2C59CFA28C53CF6A3A3FDE9AA9BDEFBDB2C98C1094DC3E9BAD3D5663E27FB8E1
      C2712897FDB96164AA09FFD9F85C39D254ECF0CC53D153CF5C91EA8494F8DEB6
      CA66AF6DE13E12A5CFB74BCDFAE036A0F74775A7836DC9269E295BE67EE44B7A
      8AEE065D76BDBEC1CE272BBA0B821EF35E72529F21B431C1C98DD3D0AD828D93
      EE02DB8A39ADA5752BD9C2DC2CCA0727619542369910A1850395379F9350756F
      2E7282A569E1BC9DD787C630A3A6D3EB492F030D2F8481EA1E2E09BB9871FE17
      8F8EADD8E432AA5B3C5F6A4DE3542873AA179CA7BAA13675A7B5212EA0EC71F9
      EF45BEB39656ACA5C75FD55A8A85C1DF23CDFC4F42378DC882B05816F1516DD7
      4911FFED173D533A668F76AAAF12A9F88CB5A09E1BC83EFD0F4D25E09359047C
      FE654559C5C7B1925336DEBC4C2F93E76C23D28B59B30FB8EA55CBD95646FC46
      57350B9084336DA42A3292F25F82D52D54987F09F6CCC52DDE214BFE79FE0C91
      CBABA1D7EDD07B2615DB18EDCC8F9A891C32E7110E437EE74C4201F3C2BFB65C
      878B0F88B5C51841E8B5D8D2CDBCED4D9263DFF3F52F1829DDB65DA2C05800D5
      23AF0E7076229CB539E8350D99A84B0A077086C835161C78B5B062033A2CCF3C
      C4AAAC9F9B1FDE345F5EFBB69E3F899ECA318A94BABF666838F0472ACE978EDF
      969CBEF369090A355BFD462BB0912B3E97FA93F0BCCBC520750807E7C49B8816
      5D8E9390F5861CF80C11C6E73EEB81137753350025CE91E17715D773A98A820C
      8963817313ADA91B9B60AF71490CDA9D093E132CA8531FF64516703A11352E0A
      A282CAE0511119D3BA998BEE1DFCF6125487DF3D6AEC037BABEDBFCFD0EA8D89
      C45B536D8B4CF2920DC3159E1036FB7B2E746A25F030280F0D9830F9D5B68DF7
      ABE578D0406F62DC453FE4A8509FB26B39D09D5A8D880BC0F74E5FBD7DAB43AF
      7CEFD78F6F5F9239C4FBF8EAF5477B1DEF3AD4C5AB1516C7F2B3EB921EAA32DB
      EA0AD5C725B4205261E2FB979A89EB1C32493DE06849AE3D2610111F5FBE6A70
      F3EA5C70D3D4AF45D91315F5D4F46A2682A47D793AB2165335300BD2BC4C07D6
      E9E464AC29CF5DBFBC9A2163D4D6545A201C4AB3BAD2EBB795543845D5183C5B
      71C08147A62689E460568581CD4B03F6545C7B35A49F5C1EC578B3B9F49D4E8B
      C3B395A554E8E5F4BF0EA9720B92055B97A5540699B9940AFF4A75E03122DFC1
      9BE4EFD8BD1D0B6BE6EE066C0DA7F90C0CBC9A4980D4325B3588D1B7AD626FE8
      142B3E8BFD3DB1E1E16DD21054428EDF1B2E66AAA5D3C0D4269149309568FE3B
      875DE95B6BDF1B42AC2F69DFB2AF0B9095FB8A727D3D325D525D21905129603F
      08A8D638A534C8D4E6991A4757B658DADC44284755636D015C8E6B492ACA1FA7
      577D18E16C6120128191E9DA6EDB224EFA543F282B745C0ABFF950CB449C91A6
      797949C8A548131CD3B4A0BF56856D106161298C6926EDBF30EA8C2AC558F6CC
      C239FC6C4A49FDCAED4A9EB385591775A43D7CFFE15CDA7CC382AF6D797EAE12
      439C7E26C539ACDD5900CADFA2CC769FD8FA62E45AEA0D2A52AF57E38203F0F5
      328BA8B5D87609C1009A65101CD88608A5D02B5DF4932A10796B616AC4E36ADE
      F77BA7C6A95F54301E0F999E84E2301629A9E906AC988264255C1779B092C4BB
      72659F7CACE14F8713455B9D53B1FCBAD2C8522A1476684255F3A4C3A0EF76AE
      A3E0C9800030768883946E42BAAA6752E8941B7992EADC4D225D403398A611B7
      8038F86F95EBBE09D253EB7D6A2E54962B5AA00D135EAE1AAA57BB72FE6EAAF4
      671622627ECD016D195814992B8F2D4FE3506753DF0C73FB3E29435AB6A33197
      A21A1855AE5AA79AF825D50E71F54EC79FEDE4E49C2BEB6AA5D2C6E46CDBDF73
      7AB5A55CEC332A72DB8D2D7796257B601FC0224A16EFE17D15A870F593A9EDF7
      C5E3E49AA7EBBB96E1ACE1C69975BF88147B2A522CAB4D651918863CFD2F9C11
      4BCBBEB47174616B5230668B58EA7B6E3B73A1707591EEB0743C1ED057676FB7
      858390A064887941D5EDAAC2269D3323A9FD87F7FFBC7EFD9A6BCF02359CCDD9
      586EC5D619A7BC8E41B0B54FFDFBF7F4D891A94A3D06A959689494912C524453
      1098926541B75C4378277BFD65C7E3A392F648E67C0065DD2209CBC4EAA3890D
      0B3A69FA6ED02E8767A82424E83BC672E0D8CF6F561F492E584783BE1EBE633E
      4EDB318E7013AD2945E9A0539CF817351C309A26F5D8F2B17A0846558F3109CC
      E1E22C8A302EEDB247F77E500968AC31F5D69A9B7EB7B4F11FDE9FBC33FEE96F
      E494DDAF9FEBEBE8EA27946FE05024815A110779BF43FC6CC3ED67DFA7374DF8
      DED3458AB0A2A7ED7D418CE121885A1B9EED8681BBBF47E07DA0C9BA474DF761
      9CF049C49800C79067DA5291AF1509E58C3B9A485D3AAAD23E7B75F62E1AEF0A
      19A571ECCFD9CEF79E82148D57DFDF968A7D66DD6ECCABF4ABA2DA43BF3DFDDD
      CBAF67A33416575FB93858C03064F9D9745D10C0A2629A016B9F03D6953A8AB3
      49392FF7F2B42E7A12D1A92FB87439E06C3E78BB4DCC26817CE65F8B1D03FD72
      693649D1CC51CE83C4F76294AB29E8255C1F5F12A4C4E3477E70412550B323AF
      C616580908D09D4879661E69C0A81F50BC789216BABA36DCBFBFA74308D4954F
      DE57FE493FCB8E537C6B848ABA4DE20215813314794853529E5CC53A1B527B81
      38B792EAC399CE7B4FA9F31EAC2F29ACB52C9486ED6683F44E70D39C2AEC291E
      C236D7ACB6E47C258B707706952510AE5EE95DA35BFD627FCF19072D4E28C929
      3FC94DFE0DC61D892D3D5CDA2B5D89BF5A78A8D2ACD335D0731B28BD08BD60A7
      930D6320F68F8D3E4521F65ED5A84675B8CBCFF3CDEEE306842B0638E26DB238
      8EEDEEE9FEFDBD9C719E46AD3999ADB297873CBAD424E2FC559FDCD24B6FD1B0
      E5B1B87690A278490AAB2E8FA1576200467982910EE236B823C12E803E7589D1
      76DB5F58309A23ACB8FD74BA18B928A863C7541E213E65D4E55107F634BCDAFE
      5E25E725212F397B66F29559F7E2FAC0902BA932E0C71960E33557717267E02D
      E7D424ECB461ABA9E42AE2C44D648FD03B00274C76EB3BE0BD47971F9B3B3CD6
      AD5E2389F9911A8B6F0917A46A3065401C189AA7754F0B159DF8618B614458F2
      FFAA94778B11CD9C594E9987C237E5D8FE2751CF529522FC8563A0DD5894D2C6
      E00FEFB8B1C6DFBCE696E36D693F12A70082755AE74253B6088B8D0867325DC9
      F8514560DD971C9EB28E06C7DB9F1BD8DDE0F9970866D359C4E5C95CF0A054F5
      812D3BDC402BBDD08D7E4AB312F7BE763BA49A732B3F983AD3C3F1697A4B23E0
      CFDB4ED04DDAC018E454126D25E28058AE8938D8964A5F2F572E1E04B245C4E2
      58A648D00C4844CE10D544974613A0CF050C384B05EEAE7B4747471CE93FC310
      0B6CE89E4E0073F7F7E4BC89DE74901778027F33AFFC9DCCA6FA21938B9AA412
      60AC7F317A018C3B9174BE6603101EC44671CB7168344EAED4A61ADB953AB3D6
      27572A4E063EA71398F175214CB4E55563ACA90616D7FA17FF88EE2089126A15
      96A886397DE7D2E493CA0ADBD405DD22F935E813338C63D9F6E3F9833F536FA3
      E4C27BE6BDFED0C16854FCB62587F1C45DB3F6F32286BFEE9CBDD262559404F1
      22B448F946941FED16CE4B2DA860404E3E959159B7F575CF2D13BB41ED3EE402
      F670A957623B6CFC9638CBA32545937412D4B2CC1EDE5C01F0E027BF981E5076
      B0703BA7CF9F0E44C6C3697B7662AF62794B5847FAE03BF469055BC6EAE82987
      F0F1A2D6B66070C2F38C90808C14C4035E83AF55ED1231305E9B529F1B2E1267
      EC8EB483B80F1881C66E9B91B29D9D98C0E1FC6C0020956BDF7A5AC0365C6D92
      72ED2FCCC4AD3D6C1C5D6D4DA1F5132FC668134F3CB818D8B2121C0ED399F9A1
      89D35F82A6096772DAF14D5CAFE19B841DF8DC4993130C74349A0404617F874B
      D7A1BA484C8FBD103B1CE7BAB1B5492B747EC79C8405C8B0893DEB276CC18F02
      2019F8AE289F59DEEC44728B9D0D2579A95506F090CD2BD933562DBC6E2AED16
      4EA34D260C20FA3BAAE7A58E4813ADB76A719252532B92B06C63612A7B66F3AC
      240ED74C56EC5BA36B6CD0208A70C306BBDA26E9D4203692D6B3B7829721350C
      A90380C422C3DE0F072B8022ABA0D20D70FBFEDE65EEFDF2EEE4A5F75386424D
      11717B645AF9C159912D82E20065C38313AA19023FE98B640067F734376516CF
      351AB4B803C7ADC6A963853B9C7C368A8A0CC37619F3B97C8262BF3D112EB44C
      DB505EDB54B8C4A5304915D77388DDCCA3B99C186771AE56F6F31B1085814063
      6E2BD92BB1D25DE64F9E244F301D74EBCD633F138747A69A666F5E52F18ED89F
      F081F7292C02FB646128DB561067A094E7AFCEBACFCE405C13A1EBD9EB0FBD63
      EFD5CB37E7D86A9AF1D1090B449A6A7368EB3A4ED394469D67519A49186030FF
      204192560631EE03763FE9186126F53438B5F925012703D9A9D42ADD25C0BE3C
      7CE4BDC014824A9F61F696987D66F30935FC1BD91E344C6344C323135D6617C2
      4614AA1F7C60623DB54943DF6542634EAC24AA7BB716D8B7383773C078B64BAC
      D4A781085B63C1586AB26CC0500502696C14EE62DFC665D759565BEAB64C4F51
      714B1624413D456D0F4B52E0EC4A0E345213E1206C3B892003147BF102096E06
      F1FD19C113E3AC005DB6823670E13316F32DF7773B41AF0112108D6AC044B46E
      36D1EDE703C8BFE9380CEBF66677AC93F4533BDFDF03CAC8064EF4251FBABA98
      3D47A534221B95F7791CDAF66326020A468B63BE720D01FDF1038A39B02198B4
      CC6600AB2ED7307FB9EE9D9CFEF891CD7675EFEDC97BB8EDA71F3ECACDEF4F7E
      79878FD388D8BC498B442915FBA81D3AFA2F55A34671EAAFECF9FE354FF39B44
      C051D759DF2B24CDF25E2094403EE8983D712C2492C1830FA191C4CAF5920A52
      6EBB88A609AADD4C39151CB24675D431723B2521F96FDE55DDBB76EBA595224C
      6D6D8A5CF9193A10500974726E78EA989EC12D7BCBC944CC58D9E2C1C713ADB5
      3AB1EE90D087CC206CC42D8F2A8AD6385DE8264B3E57F84D14C913C84B1D0397
      812E79DFAB205E89B43ACE5C236F59A637A9EFB0647C9C350018C1AB912F051B
      6972CD0DB2F4C6D75AA82997FD07C873DA7FDD8A096B80598AAAA9E6663980C3
      95BADAADCFCA39BE252FF94F7DD1476E3AD01CB06F3182A2882319AE4EE930A4
      F401DA0150236DC712DD933618669129A3EDE2732BCD5F9CA9827A30EE90B57C
      B1AB8B942C77070C58361B65482469D33C6DA64044DDFAAA973FEB4AFAA2D09B
      A30CA8613190A395342E6F051FE0C3B8FA14EEEFC9394CB897546AFAEB625281
      0349A937620E216B6261DDA5EDA4579B1F6858B762336ADA19A768EB821D36CC
      5F6A74A6DCD11C63B088C2B2BA42F6683AD97CA6E908B301D1A560A3C544C4D6
      926E65E64CFA95A53504100CFA0B30A5929D63335D29D4424BD319B60A3ACF33
      F721DA6BBCF13AE914353E0684344BD53042F24A2EDD4BF164506938693B50B7
      216B9A31D9F5D38D3A8C8AD68C0F204FC25FB04C68C679ECC29B2AA8BEF576A0
      13ED4CB13D37D038B7A2934594901759C7DBE564E35BA0995F8C175B4136CE6D
      CCC8FE5E093EE644D7487242B331C83B7194638E6ED96725D404A008078A023E
      D0D0B30C51960344D3741B10205DE230C9840B2904363499024B4CDC261D752A
      5F5B0A2279E39458420F98E420FB398B739911723887D7CE02851A29350623FF
      40F4CF2AC57644A9C057F2AEE9704B5BB29E827860040CCBF5F19E23AFF68273
      95F016BF5491C989CAB66B64F986E9B0643995B3AC2FB1A1D9DC441F737142F6
      1946FB7B258B3F6C5A1428917F268ABC7BC699EAAF3C28F80B4BC69629B84C85
      6687EB98B139152543A4E9125FBB4C884B5E514D2C2B71ECF575914B2E571180
      EA3829F282EAA1B9F73B303304006E38136D0EC2C66AC88EE7543F738BC0A9AD
      27A6071F2947FC40C368CAD15BAB7CE85B968F4191A81A3AAEEDE19660D201D3
      532AAAA3129D8DAF87986357A6910A7C94A1A2822A1CA29129373752C8D01463
      0A841C32CDA8A6169562BE75893A31FE8368C59AA0D593C81BB6ED68FFF6C3CB
      1F604B445CDB128CFEC5CFA8CA1FAF7A95CF5EC082DDD4295F24B940AFBBCAD3
      E47F6C39C29C4DC99796321B9DA791A800211CB8191A92299907049034DB0EA9
      12AB0A5298646E59B831190A89435BE298D270B26C31A7766C65084AD044CD08
      3D68847AEFBF2F890FA63B3A52DB285910A68658F6943D676E04A8F362AA8D69
      19FC0DB3350117B87B5E1A60C0828ED42DEF2F3A46E5AB2D8F56EED480010717
      090EBB025B967145CF38853D8C30EBFE050A7179E8B3879022B5B958D0D827D7
      217BFE8065C8F3F83E5E8616A284378020CF326C344928BFCC3749F526D003DD
      B9EC270569BEA0A61018468EF78CB2F482C5BD4404DB23EFBFD305B39C0BB290
      8E50B627CFE4E5AE0ACCAF6946495894BBF28E4250BC67B6B2AA5CC1D3F0F1E7
      04F79F4BBE9EC411C52E78FFFBE7B3F36D7167BC5E8E4EAA8478229C6CDE21C5
      ED204A2F46AEB59D4EAA86E3DBB373EF7BEF2308FFFB7B2CFE33683FE5F8E3E9
      19FC88C9B0D27CD3FDED2DFEF63615671FFD72B8C6CD92836E05229DCE8C24C9
      CBCC525ACD387E16171738F0A78C0DFA8935551FF19A20CBAEE6356B2B27F339
      50340EA6A2287E5DBCCC894ADC924374E2BD761A7654E2EF6CA724F689B87D67
      D3D9281DA557628275BB7E106B8CA3197C44674C64E3196514FD2C9DBE647DEF
      238FF018788A1C6E5D25060BC4945C4B25FBAED1D7F96D756D36D5AE3F99C452
      BA767D4D453B3FBF3079E3951852E4FDFE275307DBAB9D696E194679007883BD
      3EE4111B697A589A3B9F7E5D3B2F88D35C02C51F78CEEE6CB9725C5A546218E4
      ADEECC05DE304B6D71A306A294DF55D7E1219CFD2E4F53F4BE76DFA2BB9473CA
      9FE4F01E152C1CAF290DCD43A1E3921F37E93168A12999BBB14515D9CE175292
      4FFB9B490D1119A55A5B1087D976F2C7748FA4B46F8FDEDDB3A80BAC375021B6
      793E09432EA4F266FC2ECA119D6BBEC2C8AFE7DE9BCB117EF80E8E11DF82DF90
      E83C475335DC09BF9CA559C13FE6CFBD17691AA30CFCBD778E9D5ABEDBB04777
      7F8F4408A989A71BB881943F92F7CE753599156D63E8C3224BA8158DB5E5EA3C
      7A10104C81492A88296EFACDFAB957803D5F016E03D0F33382738EA05C2A4074
      4FF738CC805D6DBA7C985E3F06AACB0CC8FF40D33B428F810616151261131939
      1AB9638117707D4FCFC189524F0543701E08A62F14303FAE0754F325CB9DC02A
      9F378E90521AEA16AB8195DF7D3DAF92F02F5D0DC6CCECEF39457090E321DB15
      7709BA4774185F2E9DCF16236A884881FE53EE24E934809A2E260A5D1073C5F6
      08F2C1E2EDCF983F528012E5C4E8C6B24EE8905B9167D7D1D8165FBBD769F9E4
      EBDA179E9339417875AA9B9D7C27778CF03C99BB9F3D0315C17C73CF9A1DE7F0
      3B734361C2483C7A98E3E3604BE5EE6B231403A2D911CC33E38862229C31EC71
      58F9429584FA8BF3F15F9A8F5B5201AC834A48BE4233D6E9540517A0825F7CF7
      E7FEDED7A2781B59C4CF494CCBB8CD2290C4DE89D439840ED414F2E6481DCE00
      DF8DA489AD21E478AE84FE19E7B9F57D4BC970D1DF724AA4CBD3F8138D8CA650
      F4275F4694F0C07960BABCA8F6EC63095E9B773B778253361E6DF76B9AC5E1D9
      DC0F54DD7B82DEDFDF7EFAFD499DE5B607EFA57D7F26B97A09CD7AF7C11651C1
      187F7F0FE8994F01D59922C1D289B93A5C1BDB7B8993CE71D212DE8AA115BF9A
      8B0FB3E1223160D43E3527FD16C42099F37B1FD3821E64D61C974C9948B02B17
      9CEC1DFBD8F339A1026454179F8D0714C3578A65C1585B296C770B56E3A32491
      C7ADEE00FE9D012FD91C8B596229ED66B7D1AB249708285A83C1A0DDF72C92FD
      DB10563753C0557DAFDBE88C1AED46A7D969341AC7F05FBF41FF6B0183548350
      35C6A3F178CCD79A01C010FFB6F97B77D4691F8F8F550F4520F8B73BEE767A83
      5EE3B8DB6B77C396EAF58FC3E3C00F06CD60D45141BBDD6836E02610C8C641BF
      ADBAADB003276A108C5AF0F27EABAB06FD56D0EBABA0E7B77A41D008FA207A75
      9AC7C120EC8F5A7EAFDB85C9F43A41D8EA763A2DBFDF6A348F8F8356100EDAED
      716FA0DA23D5EEB5466173DCE88DBA417BD01F047EAFE3FBE371ABD36AC16BD4
      A839EAF4BAA1DF0DC720BF8DC3811FEEEF758FFB837EB3E983C4181C37FD6E63
      3CE88F3B237FA44641ABDFEEF57BFD4607061BF8DD96DFED8DD431AC11E6316A
      B5C3BE1A347AADE678D0F03B616BECB7FB8D56306A777BC7ADE37E631C023855
      10C2D49B61D0ECAB118CD26CF7553B1874DA614F751BEDD13188DF8D66D8EDB7
      43A554773C003074D4FFDFDEB9F5C8911C57F89D00FF031F6D03062AEF99D0D3
      5E24AFE05D69ADA5E117BD64E56539D090437386C22E8CFDEFFEB2BAA7A76F55
      5359A4651BAB26484E77676465469C3871A2BAA74A8661640DAA2AAB4B4C3A6A
      3578AF46958680E34A8ABE068D6F84656F3C1D8374D5C812B5E42851A46C42C2
      533588300EC59B620D6111CA449F8B1CAA1C469F844C6A1C5EBE68CE363555EB
      F02A072876AC6A0CC507963F666B824D63CAEC7794BEB8A4AC2929B10C512B12
      78A846D5E285CA2A259631BABAC34A6DE8012F4B38231AF8203AA6DDBD38280B
      54DA63DC23AD3A09C6124ABD82ABFDCFBE01A9DAD890C5FA5DA9DE8C19370A97
      F1373B13A08A48D468C2A0550B8FCB04040DEFAAF5528A318388C2BFBABE7C91
      08EB10C7113FE3EE52AB8B41E55A62F1630D45045D9A776C88310E36A92235C0
      4BA3F54538AB32E0AC203878137574D20C2C07F00CDE725C8E31360027336411
      156ECA4A88311AED47AB866084240AD5FB1C741B2563D1D2EA2C88F090250B32
      7954DA4AA95D8D2E08274CCD0EE4F9B6B482CFC80C558DB02496538EAD145FA3
      4FA15650838F520A45D724B0AF3215A3098A256582D6C9F2966505519057B528
      A3C60CA6BD3531662D4A1E463382B86C6BDEC5664D64EDE842B0C2FA3D63F878
      6092E90173700458C2C8BAFBF9E58BE367ED679D99A0F0D7C12BF29155D84CD2
      7920F6B2B10A3175390AE7C2001B108C11986A6349FA34C6328E959569159288
      5AC02F783454704D0616E59572A851704CCA8C2F5FB01F7E2090697043F6D11A
      28A778DF40EDE09BE8889BCF517B910854B2A930A720C14A705EE0F1517B122D
      571D80A532AC0DAA008320238F266739643B1AA8CA48518845CEA690BF1AA040
      75ACC019573CD184BC41196FB211023A48E57BFCAF8BA87AC86E42767B6B1453
      04849DF3FFEEE7972F9E9E29F1E8F3926094EA5BB658A1C7D280A4EAE07386DC
      C6D116CDD1C63125116C617C18D9A94E5A171D7DB1E4802566CE426564A78359
      D9936EA92293E0FFAC18AE60C45CC101794296717072B8E2AE9164B0C1A84432
      E6015B654280D093CB991220E13A5AF3240CEC5A2A7304382CC32A3565ED838B
      35A7A1C6E08CD7C41CA781EE109C2C2A90C226928E620CCA125936585B36BA48
      0A474BC111093429AD4DF03A343449D896E5E43C545547EF93B3CE5327944D9E
      7887C6D043B422BB41953C4A783A70842145859F64C07D83AF2540372C0650CA
      52940D4E084658DC2AC0419656665E8B3119315047E10A584B7BD9782B401BA2
      A5D72807200A731114AADB10DB3464BA4E5059B22E17AA9B1D05DEA480144909
      D19A72E81DF9401567E1CADA1CBCA5ECFA324063AA8C4E521B7D147228AE2A5D
      B2B10628955464AB5352664ABBA742E66A6584788371A9C257947ACA66E570E0
      A5D166856E039C5848C4900D6281328707B14C409D30651BA18A58DB9E06A545
      0410D12859A88D3155D22638A754448180972A229006480105418E2939D6229B
      4792A166556F5BC90E9A908FBC4A5928A93A470C295C7A84986375489781C442
      2EB01B22D1E0930CD2852CA74652421C9E0D28145E800AA5F76128AD80F8625C
      CCD527F2B7D8300CA1F1BB26FE49610ECF032A5CE98D9754270F9C464D31B200
      0C685BE205812457487E9250075C41C197889C6A1B8A20023324A34AA40208FF
      F28550ACA4124E1C3B925E3E9AA6335A5042092A500A3CD357E34094C4E3D037
      B50FB6F65238C8A1C19A5C13152FE124DB081F14B386A1C5430EB69A52F11C1C
      860BCA58A83C9E686847E94B2F5FA8D4CA33C597E29F356086BF3C3A2D061BAB
      A1A0B0F65A48B618430526951C845A2BC694208D32ACA990290EB0E4B19984E8
      05442B4DAB934C5A7349BE0A0E323D53E820FEA170512C0CB940F2507791A224
      029191262740904910D144209E1ABCD3F81D0666CD1966A62E8073E41DB51327
      686A6D4AC88181A26E1866C7B6D14168D1542B70A6B4C29903AA8892DC046966
      59E8AE0A5981039FD043492034991B5281407D82E8AD1F3D8A6324DC882CD682
      BCF3009BE5537085A14AE4ACF11DB2572309AA24796031386A401A0748C5A41A
      118116F6690ACE17E4A38F4C94248549A0C592860FFC38A04B470F3B3B0A8C1C
      222A57A28692A4B230C662433829F5AC2EB1F76822EA2007A887E04B34B86069
      093E15F09EA7521A1154AB4BD1535C9C963A3712F5E4200256818F0457B389AC
      029CD8642E0C217DE45810AA6B13EB24112D14485E2511E31008055107F3A0CB
      E1A5A0589B46BF290FD4646C240AE8E0378416F2D764AF5524E1A92279288C64
      CF909684B150A0943BA432851A7D206A6B18104EA5E5F304F7963A2819FE8277
      D64C8180F2326A6070A8D3AC33EBCC5E92993AD4589A30D1B09331740723A512
      150B32141AB1C4C66616B243CD41D4C83764781844613EFA5872010F89485D1E
      0912DA1176E447381886AB10305C6680833664A56EA9466D20677201F1C9D6A4
      22611CC179910ACAAAD41BD0C1B2593C599A476B46456E4079A59030D26652AB
      B6CEA381A6B28252069EA19B21E71DFBC2DD1074316C827248CDAAA1A28B5890
      4BCC2D201B39321FB9A3A375C46CA0E605E47A2B088842A86B18CB101DCD83B2
      02F59EE97CC00DE445B6316F9542910083B33012B11B616B701C28334497B455
      6D2443A12216CA8CB6D202933A91A3D10A11BF1C4BB03038B537D0D1411F345E
      95E6676C551BC2407091809447706BC6D63439A449906C0E154AA6B84153BFA9
      4C790C681F9CA348203DA4A69E48263816854C19819DE864C878EA12240F1407
      64039EE7E82388CD064DD4A00AE542307459AD9B6CAD134AC6D15C06949C80F3
      A361DFEC23B48A34E69450E6A9B4AE0DA983E0B176B091F67B683200E2364D94
      A289A8C9D450082052DBC977A390E886FC2421813FAA882523342C00D47AB0A8
      5343DDA10B456CFB4CE0E81B79D55098A0794A39E5945CA392338D32ACA0D2C5
      228E194967E7232A891DE2299CC7F2910238248EACAD594183160DE5381C8084
      EBA90425124E415168DD8023AB1234AD2DC95A6CADBE526F687379463DA5A3C1
      BB784F061511E2B9F58DA0026D94264246ECE065DA443853235563CB4D695AF6
      244F2259B4812254D49B420B446C78AB58720A21072F1997556C2449634787E3
      1A6C62605A4F1969EADAA1C781237CEB68DE5DD31844A175B4504DAB8064BFA4
      618EAC89AAA18466DE82FE90015AB588150A38648CC821BD69CE10949E58E1E2
      50A54B343F9ABA2C44C8034E6FAD2EE58CB5B43D17439D85528249380AA981BB
      8734B002584406E4286116462B4D274F8F4D88880B9ACCA6D8341A3D5926CFD1
      7A20AD75E7507EA62435BF6B5A3BFA8CA014BDC048BD8B1268D19D405290FB28
      06040B35DE404599388C8ED46867287099A66BCB4DBD0CD072A8744606B66365
      704A1423DD2ABAA1F1C330268956D272440452ADB273C865C8999E17C62164A1
      9DC2696A657410A400BE541AEACC7466848E04FFD349D111B23962C9426ADB78
      D3891C9202425F69B347BBD22D6946A36F24A28108584D432B12EE810351C968
      08E7E00F5EB0C41E7993E8520DF8A525A3F01317B29CFA5ADA32D1713421C285
      34ED3F8FD4A376620B1FE456E232488484136C4E4B004B8058569AC440BF330E
      958DCBE0E066555A0BD85414D52D171218C9D1728D9E177164036510EC907F28
      B6B118DA44646B3BE9D0DC1D1AB40BEC4DD8E89D5AD2D0F764DD56000ED8A0A5
      3010B15889058202D9834A8384717EC8319A5AA01E1599D9915FADAF064534F8
      B89CAA10D14CB679981819886384971C294A1BCF6B900C18060DECBF15196009
      A02C349B10526860FA46740D15163B240F658915E0C3B5DDE200698521B4D5EE
      BAF471D7694AB7DC2D3E9D9DA1363EDBB99F9EBF997AF8A64A480C325ABA76BA
      A45A18648CADE3014FD97B06913AAD512A5AD118B60689B658D08B64DAC4D6D1
      78E41554D63ECA0E01713B0687060C8833922A1788895C060D542306A0ED033D
      0675CAA33AD18034E254001F7250948211D77808C0C2AF250B244CA0E1955EB7
      864CD3FA7034850C77249DA4A022C1D128A8725DD14824140D66444DD1E96829
      A38AC8787AB73153BC6844C85AB8AD9D9643EEA25341B12500D477AA8860F986
      96A29DB5C10DE8301F2CF8A44CD27F1160E42A5482646C1C15DBE987449A21E6
      62CB749DE8580C7002E1C89E5DE44EA24F6D9708AA2D677C971EC767835169B3
      E7839F5B433B1BB8742EF0DA430DBB31A7487C42DA73C77CEE3CD5B507A92297
      B2E2F81CCAF54C786E55CF9DBDB9F6A0261D564514AEACEBDA999DE756F21C33
      5C5D09E9BBE49FE373BAEB39635AA9199E3C60767FCDFEAC584A437C7C6BFA20
      FC9FFE9CEE6EEF3EDCA7F691C7DBF87EFA2D57BACABA9F199E6E47720A6A05BD
      F454B2F985F64FD21593C0B6A15AF32EAD657BD750EE355DA7F26D04FDBE9E56
      DCFE4D6D06FCCA28171AEA990B598FEE8CED93056800AE76B40FAD8B41530CBB
      35902B8AF75A3F4703E0347F06145695ED2485DA7B869CA739AA6E5AD3DECEDA
      E6C3F69EDEBF2B1B53D067495E73BB354FBB44C829B284D6B0B6F136B40C9D76
      8885DA1D1959C3CEDB9E34D26AF79AB6E3EEB5699C3C8C938771F2306E7A8DB9
      DB9AA7CF83F6739CBCF2346642677B4D5E8CBA9C495D8C511763F4C5187D31C6
      5C8C311763ECC5183B8DF178BC7974DCC5E9F1D9F41E91B0499F8E387B8D7160
      618FC9764DB5770FF70F3FDF96FB3FDFDEE7FB879BB7F127E54C7BD2BEFE5072
      2E7598DE2A6F6FDEDCF0F4DDE32B1FDFF1BCB40FA51F5FF9CFDD75F21F9F3E5E
      8592E721FCD7D394E5A754DE3FBC3AB210AF8EC70FAF9EC60EFB7BCDFF667674
      3819DD7E9DB7A596685FC23959F6CEEA69D1627E01D7A794BFF9CC13AACF3DA1
      FEFC9B369F7B8DF6734FE83EFFA6FDE75E635835E1A3D50D29F6D36A049F5AAD
      03E9A9CD3A1C9EDAE80D3666D38ED601E6D4C66DB05917F4539BB072478FE850
      A7F078B84B84F913275817F18509D4A76F621D1A16265847330B13D84FDFC43A
      D02C4CB00E410B13F4D1C4AE30BEFA3D487CF7D0995AF5EEEEE1DDF4CB46E5A7
      87AEA3C677D8ED2FBDD26BBBBBD64697495BE8EE5BC1DDC9B927DFED5CAECCC9
      ACFB9BFD742DFF61F705CCFAAADEFCD86E86DEB991F2EEAFE5F6EEFD74DB8FF6
      DBE65DC73E18EFBE23D8EDF6091F876BF06C05C9D3047D5B6FBFB2B5BF647FD7
      A1DFC71F37D9A16B3F61C38FD6534AF46DF40091F8F1E14DC3DD4DE98BF3DB98
      3EDCF5A1F22E7665C7A3DDB737F7BDBB6B26AFBEFC787B5BFAA862B2FB437F18
      27BB3E113499AC2D8227467D2268325957E8AE786FCBA6F6969BF6B6B7DDB0C5
      BDE5869DEEE2BD65A77BCB4D3BDDDB6ED8E9DED2CC37A7E2B4977DDDEEA8DB75
      9CAF76BFE6DBB9AF1F6E7E7C17DBCDA0BA14C9E91C5FEFEF30F37DFC107FFC10
      DFBF79F5BBBB777D49FCE55DFEF9D5EB5E9570B0DA266DA6C87CB5BFC04C7F4C
      1F2DB7A0F060DBD7519DDAAE6DE2AF5BF765DDFE523AFB3B7D2EC0F80C5E1FC7
      876E24FF106F3FEE3441E706BF8E0F7D477A02D0EFA64B95EF61F4E9537462E2
      0F4D117CB3AFB37D7B7E3A7EDF219FECFA20789E739B0FBB37EF25E22FDB0FFD
      54F1CDCFEFCB0794E25FBAAC7E77D76E6855F2A9F555E04B798AE1870F778758
      5E373825FCDFBE7DFF26DEDFF409BAAFEFD2C7E97E61DFC5F75D86DFDFB68B77
      747BF1B7FFFC36DEDC1E158DBED87DF3FABB6F5FBDDEDD84B1FD56595F049BF1
      97770F0F776F37D9EF9BE07FF88F32FE63FF81BF4039BFFBF9ED960D7FB1A123
      9B0CBFBAE9A4B39DD55DDE60F5F5E1066D5BB6F8AFE5E7F12E7EC8FDC7FDFE43
      D925C743D960FD436CF732E8B77B4D3EB70B8D749F2F98ACDB35155B2BB6057E
      AFBB0D8F3AE4FB8FD3FDE83B8FBBA519FBE3EE4A283BC9B0EEC4E355D3BEE270
      62DA579626BF424C0D0FDD27C44F8CFB967C62BA65C95FDDC6FBFB9BB56777AF
      DBCA4DFB7DB4FE9455F7B5427BDBF6F176FD78BB6DCB8FC61BF7FC68BE69D377
      B71FDFBEBBDFBAEEC9760BBA1E6D7BA5D2A9F5C6504DB67DBDC2CEF65F3EDCE4
      4DAE9A0CB7857732DD12DAC9708B8726C3CDEE59FB59C415D3BE0FAE8E0CFB3E
      BDDA196E28034786DB62B9B9086C38E17664B8259693E1B6584EA65B6239196E
      89A5FAFA5599EE49B98DC88ECCB7C5F568826D24FCEE709D820DE6BFBD2D3FC6
      CE167F67F9FD87BBBABB8C6FBCDDA62F3E8E0F9338D96CBAA578D0EE6C3A64B3
      DB16E066D9794EA1DD08FAEEA81F9DF9E4F389C5366CE875FB3EDD55BBA3A638
      953777B7ED2AFFAF9F3E9EB97E9EEB5C64B74B7C3C7E4AF238C89EB6F8DF4EB7
      02FAE1CDD3C7298781E2CAC049B69F8C9257461DBC7118A54E467D57F2CDC7B7
      8F47DD43E130562F8D7D0CFF61B4B936FAA8361C06DAD981F274A0BB36F04839
      1C06FAD981673386D981EA64A03B8DCDD7F1C35F8E1BA5C3B0D3C81CF4E3B528
      3A797DEC45209DBA3EF032960B007AF5456AB7CF3B77D41C929E869F05750E54
      33F32FA36BC668196633460B683BB598CBE73F95BFDEDC3F9DD1B8FEC9BD3EDB
      FEFDD1E7180B67FB4E61F66F1FEFF6A76AAE1FE4348CBF6F772DBF2F47566B12
      67C64B0B19341BF285649A39CA42565DB7984BAF99D1CB593663B4906E735B5F
      CABC99ADAF4841D99782721DABCF0C5F978017DCBD2E0565770ACA6E00AF2F01
      33162BE07BB1FD1500965D00965B002CBB012C57178ED9ADAF00B0EA03B0EA03
      B0DA0260B5A582A80EC53273A0150056DD0056DD0056DDFC7BBEF7E700ACB600
      5875035875035875F3AF3E0FFB7300D67D00D65B00ACB7005877F3EFC5DE5700
      5877035877035877035877F1EFF9BE5702587703587703587703D8F4F1AFE9D5
      F0660B80CD16009B6E009B6EFEBDD8FE0A009B6E009B6E009B2E009B2DFC7BBE
      F5350036DD0036DD00B67D00B67DFC6BCF03BE0EC0760B806D37806D37802FF6
      B302C0B61BC0B61BC0B60BC0760B80CFB7BE06C0B61BC076BE1717A77ED89F59
      3DF9F6CDF58EFF747F8F3DFCC170E91C83B876C83F9D7C7DFCBAA1BC7ACC3596
      A74EFAF2EEEE2F1D5F293DCC728ACB2F6FC6DB9BBBE9CCC8CF9FF2AB74E76775
      FFF8D5E1BB6FC7C3F4C5D9D9F695A5E95CEE698BAEE5ECC0D3F649ABD981A7A2
      53EBD981E7BA439BD9A1A734AA4FD36982EBE3473910DEE9583B37565C1BEDE6
      469F6DDFCF8D3BDB7D981B77BE7933BB2733F1C5C9B446CC0DB6872C3E359073
      06EEBAC1B36EBB7E8A67C17F73E791165C39738C799F5E3778CEB533562B7C3C
      B7A735EE9ED9DC5ABFCB5EBFAF06F0DCD98F157E979BFC2E37FB5D76837C7673
      6BFDAE7AFDAE7AFDBE9A41E64E57ACF5BBDAEC77B5D9EF6A1BDA2F4AC5F37ED7
      BD7ED7BD7ED79BD07E41FC1D7ED79BFDAEB7F9DDF4A2FDBCAB5AE177D3EB77B3
      C9EF6633DACFF7D4E377B3CDEFB6D7EFB617EDE7DDC30ABFDB4D7EB79BFD6E37
      A3FD6273A77E9F3AA2D522F068F4620D3D1AB748E147E31619E468DC5E022E12
      C7D1F07522F0C8609D08BC74DB2A1178ECBF19837947CEAAC6799FAE128117CE
      5D2502AFFA78C67285B36737B7D6EF8B22F09ADF570378C6E079AF9F0BABB57E
      5F14818B7E5F14818B7E97DBD07EAEB756F87D51045EF3FB6A069991642BBD7E
      211D3BFCBE280217FDBE2802E7FDAE7BD17EA11A9FF7FBA208BCE6F73E0A9FB1
      EAF0FA857CECF0FBA2089CF7FBA208BCE677D38BF60BD5F8BCDF1745E0ACDF17
      45E0A2DFCD66B45F6C6EADDF1745E035BF2F8AC06B7EB7BD683F17566BFDBE28
      0217FDBE280217FDDE770DABEF30E9FF95BD1FDEC60F0F1B7F23F69B78FFE621
      F65D0CE4DFF7B7182CF9B0E05FA6BB7AB51B7ADD3FB43B7F0F62BA2EE6B0BB16
      E83088FDB53C5FBED0EDD640D3D5239594C5282D8C375E679D4CBBC2A6B07A77
      DD4D65DB3530AF3EEC6EA63CA42A4419A218858845CC5F0974F750ED5E174C59
      4BADD39541E7AE622ACEFE3F7BA3D9D7C3156A2F9F1F5EFF1F7CB42BAFFF7A1F
      7FDFFDAFF77165F779FF7FF9DBAEE47FE3F1F7D8FF7A1F7FDFFDF2C3A0356CDD
      FD757A273D342AC496DD73C70B2E3CA712B63FA6ABA29BF9BA3F241B73F03EC8
      2A72BB918935AC540FC12A69443173F386A1DD99D1BBB1C876A3153D8839C5F1
      7FE531EB818D8F972F3EE7EAFE168FCFE981FF7FBB6F8FCFE5810DBB7FEC3DF6
      8F5F7EF96FBC72BE36}
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
