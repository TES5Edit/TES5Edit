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
      789CECBDF973DB489620FCBB22F43F60B5BB616A9AA6791FD553332BCB7695BF
      F65163D9553B51ACD8004990440B04D80068895DE1FFFD7B571E00099D942D37
      D13365912090C87CF9F2DDC79FC3389D3686EEC49B066E386BD49B9DA11B263E
      FD335ECE1ACD4E73B81AF31DD356A353EF0DF1537D98A4C97C3A198DE778B1C3
      5F8388BF76F9EBDCCF7C1DF9FA797C57ABDE6FA8CF530FDEDC1FA6736FE1E9DF
      F4B7FCAFE3A4FEE7701A85693A0AE0437D08434F7C67388DA3851B0EA7E3B91B
      275E0AD797F13F9A7F0EFF6DB874C328F19C7A13FEAF5B6FD53BF536FCD7844F
      ED2F1FFD859738EFBC0BE7033EFED72F3064530FB988265E9C1FB3911DB307E3
      0C686C1CB30D639E46ABD8F7621CF5AF5F0E0F60C456C1249B9B930470D661C1
      F05F0F268B83F6BE9CAD17A328A0B935CC7A433FB87AA08DFF7DF9CD0F6713F8
      2F917935DA05136BB4BADBE1971BF5CB2F6F61B837FE27BC6FEA06A9337C32EA
      0D9FF45AF0B7397C3281BFEE60F864EA0E9F8C3BC327DEE00B2DA355F4E2ADDB
      86DBC5DB86DBD74410BB8B51ECBBCE5B379D2B18F7F490C9859F24570F39A5DD
      6AD2E06AC8C08731697AEDD66DC61AC9CEF37F80575FCEBC59E4399F5EF39675
      1BF785F2FF516096B50630CCDFA3784867F2014EC064648D7FEFD9DF05476899
      73DF9A46F376DBDBDABEBDCE1B7F364F6991237BF4A2137A5720AA6DF243F586
      5B61FC8DB7C98CDFF996DB64A6D1DDDD291CD9E3F6760FBE76A75F44975B7D1E
      D6C93DE79CBE9445B73B83A28771ABB73FBC8EF9C5C514017FD9FAEC4FB1E79D
      CBD3CDC2A79B054F7F5CA93717217AA3D72B78B6F2B3378ABD8B63B5F06E21D3
      E81541AD7212BB237F7C2C732844D57EB76080E7808FFE581EEF162EBF55F4FE
      5F7D2F0D5DB8E8C91C7AFD2226AFF6BEE1587CDCDAF7DEA0F049D9F8DC936AD3
      FB8DA207D5AE671FB476BC5F2892A82DCF3EAAB7BBDF2A7C50F63BFB607EAFFB
      EDE2E7B78129BBD1FD4EE1D3B2D3D9A7ED5DEE778B97DCDAF6E6CC16D3ECBBD7
      B14647913CE7372F49E11DB794627A83EB09882DA91016D173D7D38EEC738843
      B4A67E313BD6A423F3A8C1A27EFD7ABA9179546151BF98B7E8039B79D0DAC77E
      FDFAD39A7976CB3EF69BFD02A6628399D9BB40B8DF1C143D6241581E9103DA6F
      350A9EB141CBCF58506D1509263654F92902282FA95524611A3AAC9E3267921E
      6C173E988745E630F65B9DA207AD4DE407EDFD6B1531747BFFE47D5BB6AE7FFD
      D6296159EF5DFFFABD33CFA8CD1B5CBF79FA216BF706D7EF9E7ECCDABEC1F5DB
      A71FCBEEDFE0FAFD334F66367070FD06EA27ED1D1C5CBF83E68D9B5B881AEE35
      64F4FFE4E928BD38A3A4DC4DD2CA8F7247916B43676ADC47FECA0C7477512C33
      CCBDA5B2CC68F714D03263DD4B56CB8C745FB18DD6696BA6CD0766EFB6FA790B
      16441AA642DFCC1837E7493286465E7B985BB0291EC6A06E66989BF32D1E4621
      6E66909BB3311E2487B699B16ECED9642C1B693323DD9CD5F14816CA66C6B939
      EF93196D22AC6D6568DD990A6646B9BBE2690FD3BE330DDC5857FBEE543033CC
      7DA8607EACFBD0C0CD05DE8B0A6646DA81F26A9B95DAF7306164C6B93B52D9C3
      74EEC958CD407744A98D8575EE895499B1EECF58CD587747A9CD35EE00A96C5B
      62F7E119AB79D7ED74BB0D8363F7F68A9EFD78EF2E3A5F6680BBA87F9901EEA8
      0966C6B8A3529819E3F6FAE1E65AEEAA2CE6ACBDBDFB304A33CA7DD4057BA0FE
      7DA85A66A07B314A33CCBDD585CC68F7A46A99B1EECB28CD48F7A569B4D07114
      44713A0AFE3A8CBD497D38835D09EBC351B0F2EA9B979A9D8E7D11BE5E759907
      C06F5B86C85DCEDD5B3044C10B798846B36F5F84AF575DAEFFF5F0002FE3F72D
      83E42ED7B317CD205B2FEB41064DF9013ED00F83E68DE05CC7CDFE37F4FE8FE7
      4B2415CDE610830786AE78903074407FC12803F9D271D4834B77E9C00AFF1138
      C3C0AF0F63F82F711BC0B792A0D919C0BF8B5590368617FE649C064B371E5EC4
      EE129E73E1F2D04D966EB09CBBF8215C2D8073B9AB341ABA93BFAF923446411E
      0684B906F88F9FBACBBAF3651846FF00AC8B1651EA397F0E93741D78C9DCF3D2
      3FBFDE2486711A002CA6E3A4818B77C52FE612005D15C101934963BEADAE80AB
      822AAC780A02F875F01E8E67B13FA1C7C2A53542B8C4319C61127A9729BC25F9
      C7348A172EF0FF6419FB51ECA7EBBAF30E2F61D402CC356964C1346AD40958F8
      EF0817DE806FFCF756E08A562900C80BBCCF5E50BF31F086EE08565847C881FC
      5C00B9D1907EDD06BB731079400002F5F06AF8E0C2476EE24DA2B02EC0829727
      30ABF346672BD4060EA2569CF893561B80D3ED3973CFC5880DA7818726693E3C
      181B77012380C28011969D0724FCBE0D90D7A1570E784D05BCEE2D81D7142C6C
      3D3CF89A77015FB3771516C2AFB707DE16DC6B29F0F56E09BE16136C98340CE5
      4E267EEA7FF6E0EEC45BF8737F32F142F8B20AE1A3B782375A63369C170C3AE7
      1737766700CAB9F32A0A2900E3DF608A69D268C03F71743119A6F1344D7EF327
      E9FC790BBE2CE14541A3DE978FB1F9380DD4EFD3547F1AE94F317E1A8F962ED0
      5EF830E50F235839B021FE9BAE971EDC957CF6E214C40FF8348A27B1FA1BC8DF
      91FC8DE5EF6416E84FEADA5CFE7E76AEE303B0DA07E1048F860F341A57A0C4E1
      01B303E7A33B0A3C8D4F1D1B9F8A28F4C689A83369D664D8500A4450C671FC1B
      8DCF33D8B889E13F2BEAEA9C8274A9A7D5BD7E5AF8D62DD382CBD6C9D3D369DE
      6E3ACDEC747AD74FA7D9DB3A1DBCBC3199D6ED26D35293213EDE7F18127A0B6C
      E7F5B6AFC0F4F66EE865A37F258DCB424BD0BBF29B373AD61B3728DC381F1792
      9DB89FDBAA4D0ADDAC6FBCF6E5026099F8897A65B35EF8CA699300977B2B46BB
      E2C53CD6DE74DD3F7F7CFBC6398D261ECB2759394FA30092FACB41A30BFF36D0
      639E5E367B7082D3CB56B7DB863FED4E1F68F365A73DC05BBAED06DED26B61DC
      EF65BFD96EF3D3780BBCB547C3D40703BCA9D1182063B804ADA489B7355ABD36
      DDD7EE76BA3BC63C016001E6C11A05983B917594A4D86CDE76377E893D469DD4
      9B68BC68EE082F684A19EA9A99DB35D3C9D0B566AB784EB9D964A660548CFCFB
      96C1D3733D7AFBA6A3E79778E5F8E3BF7EA117047E92A6C8CBFEA48FFCDD5B2C
      0337F5FC49BBD5EED79B837A937F25C97048FF86D371B3A53F86EAF3DFC775F5
      21944FD32808A20BF992A42E882A20C8F0B7A53BF6E4171067BC30ADFFC9DF52
      409DE1937A63B87ADA1A345ACE7F2238F86DABC5C88B815050387AC2CE5357F0
      D67FDAEA22E6F7E0F2DFC7B2363C824D3A0FF00755EF5D2FE5334C37848FB043
      375D57B46D3DCDCC7ACC6A1AED767639740146C6BF0E19881EC19268AB9A83ED
      5BD5A817ACAD89E4D05E1B5D8057E0DF9B6C166A698F756DFD7E6E6D7801D706
      7F7781886AEDDF606D2D8C4AB4D74617E015F8F7810F995EF603ADADDDCA910F
      BA00AFC0BF8F8080C0FAEFBC360C26CFAC8D2EC04BF0EF2358DB352B43225FBC
      B65E8E96D0055C5BEF66B4E4D152922EB06158BABD36BC846BC3BF6A6DE83470
      6020FCEC4F1A8DF6A0D369771A5FB6F2F6A718C8D16DF507CD6EC9DD4BEE5E72
      F792BB97DCFD11109092BB97DCFD26DCBDDBAC37DABDC1A088BBF706ED7AB7D1
      AB97CCBD64EE25732F997BC9DC1F010129997BC9DC6FC0DC9BAD56ABD16F373A
      DB997BA3DFE9F47AFD7EAFD4DC4BE65E32F792B997CCFD31109092B997CCFD46
      CCBDDD6A0C5ADDD676E6DEEC35BBBD4EBDDE2E79FBBD97B24B766EAD4111BAEF
      0751EFCDCEF5CA0C5F7F346B7B68769E5D1902602FD8B9BD32B5EB253B2FD979
      C9CE33ECBCD56FB7EAAD7EB75E6088EFF75B1D40E876A9ABEF788F4B5DBDD4D5
      4B5DBDD4D54BE65E32F78762EEED6E7DD06C0C3A05BA7AA3DB68777A1D50D94B
      E65E32F792B997CCBD64EE8F808094CCBD64EE3760EEDD6EBDDFEFF6EAED0243
      7CBDD1EAF4EA8D46C9DC4BE65E32F792B997CCFD31109092B997CCFD06CCBDD7
      ED743BFD76BB40736FB7FAF54EA357EF97BCBDE4ED256F2F797BC9DB1F010129
      797BC9DB6FC0DBFBFD66BDD3EE0D9A45B96FFD56BB596F75BAA5CFBDE4EE2577
      2FB97BC9DD1F030129B97BC9DD6F92D95EC72A75CD46A330B5BDDB6A7707F5CE
      A054DEEFBF943244BE0C91DF35EE9521F225472F397AC9D10D476F763BCD66A3
      5F90CFFEB4D1EA345BFD76B7B15561AF1BC8D46F0B981BC1A209FFD56B793820
      906009F992BBB9B6107766EEF759D5EDB71B97D8B8E912B72F10797C6EEB0BD9
      FF375C65F37EABBC460CD86EB4F8FAAB6CDD7395B71708EA9648F7B556D9BEDF
      2AEF201A6CDDC90714E870959DFBADF20E42C26DF07517C61A5C65F77EABBC83
      B8B0A3537963B30DAEB277CF55DE5E707868DA43142FB7CAFEFD564912C3AD45
      887EB7DFECD6FBDB45885EAF57AF77068D9D67CDDFD2687733A3C07762F167F1
      FE812C048F52F2BD52AADF9D85E09BACED1AFB404EB47B580BC1E3B10F7CD75E
      A87BDB071EB117EAC1ED03DFD00BF52DED030FED85BA0B736FB47BDD41BFDF2C
      2855DFAAB7BBDD41B7B50377FEE6A6EF1573CF0B7325732F99FBF7BCB692B997
      CCBD64EE8F9CB9777BCD7EBDDBEE1618FF7BBD6EABDEE90D4AEE5E72F792BB97
      DCBDE4EE25772FB9FBF7C2DD9BF566A7D3E8B60AECF24F1BC057DBDD66731796
      F992BD97ECBD64EF257BFF0ED656B2F792BDFF4BB0F7D6A0DD6FD77B05D56D3B
      FD46AFD901E5BE64EE25732F997BC9DC4BE65E32F792B97F2FCCBDDF6DB57BF5
      E2EAB6ED5EABD9DF492B9A92BB97DCBDE4EE2577FF0ED65672F792BBFF2B70F7
      16E8E60DF8FF22EEDEEF377BDD66ABBF832CFA92BB97DCBDE4EE2577FF0ED656
      72F792BBFF6B70F7FEA0D968777B05DCBDD719343BFD41AFE4EE25772FB97BC9
      DD4BEE5E72F792BB7F2FDCBDDD6C373BED46AF2866BE311874EB0D004EC9DD4B
      EE5E72F792BB97DCBDE4EE2577FF4EB87BA7DEEDB61AED4E5139BC667DD06CF6
      5BCD76BD64EF257B2FD97BC9DE4BF65EB2F792BD7F2FECBD57EFF530EF6D3B7B
      EFB6DBED7EBF51FADD4BE65E32F792B997CCBD64EE2573FF7E98FBA0DD68363B
      45D56C1AED7EA7D7EE028F2FB97BC9DD4BEE5E72F792BB97DCBDE4EEDF097707
      76D71AB4068382A8BAA78D46A7DBED76EA65B1BA92BD97ECBD64EF257B2FD97B
      C9DEBF1FF6DE42EEDD2A0A9AEF765B9D66BB5E2F997BC9DC4BE65E32F792B997
      CCBD64EEDF0D736F377B9D66B75DD4361E8850A75F6F977EF792BB97DCBDE4EE
      25772FB97BC9DDBF1FEEDEEB373BDD7AAFA0CE7CA3D76F74079D46BDE4EE2577
      2FB97BC9DD4BEE5E72F792BB7F2FDC1D787BA73E68B7DBDBB97B0B987BA3DDED
      9686F992B997CCBD64EE25732F997BC9DCBF13E6DEAC375AEDFAA0592F2C66D3
      6AF71AED4EB753C6CC97ECBD64EF257B2FD97BC9DE4BF6FEDDB0F756BBD11FB4
      1B05D56C406F1F34DBBDFEF6A8BABA014CFDF67B7E235034E1BF7A2D0F068411
      AC214E83F17C381D270D67E84E0114411AF385FB30FADBACEA8678AC165FB8C4
      C6FD967807DEFF00AB2C5A23AC9E57D9BCDF2AEF20057CC555CA1A5B1B6BA4E5
      DF6295FDDC29BE5E1EF8FAAB6CDF742711F3B7ADF21AD9E071ACB2733F7C4551
      2027DB5D2F257CFD5576EFB7CA6BA485ED52DED75F65EF9EABBCBDDCA0A9FE57
      5C65FF7EABBC9304D1AE77DA831648106AAB7332C4A03768F65AFD6E73F7C2D5
      2DA4A987370FD8DBFD553497C7651EF88642FDB7340F3CB4507F0771E0ABAAD0
      2CDD3C8881E09BAFED3E26AB7B1B08BEEDDAAE310FE4C49A5D1B08BEDDDAAE66
      F3DFB5C9EA2ECCBDD16CD5BB9D7AA7F785D6FE6F743DFAECC5B13FF16094C0FB
      337369C3AC90F9751CAD6031C320697CD9FA58A3DBAC37DABDC160FB53CD82A7
      749BFBED8FB50A1EAB37EAF56EB3D128785B5BEF767E71AD56ABD12F5C5BA7E0
      753AC361FB63DDED8F75BBF57EBFDBABB7B73FD52B78996E1FB8FDB17EC16300
      FCEEA0DF6F3690AB6D7B705004CB66BFDB6FC25C0BF6BBBEFDB956BFDDAA8368
      58B0738D223CD1759C0A9E2BC2141DA952F05CAB68CF012620E582205BF060BB
      68D355CE6AC17345C8D2E8F69AFD7AB7708105D8621A4B153C57802FED6E1D1E
      1B745A45FBDE28C2185D73A3E0B92284D13D320A8E7A01C2188254F05C01C618
      3766C173CDA29D6F34EB80348D6EAB00B59B45E44517122D78AE08651AED41A7
      D3EE340A1E2BC018A386153C578431F566B7D36C36FA9DA2AD6F16D1181DD45D
      F05C01CA345BED5663D0EA16C1A5086374DDF5022A5F8031BD6EA7DBE9B7DB05
      AF6B358A375E35582F78B2F9E50B72C4D8FB9C8E02E7CF4FE179185D847FE5AB
      CBD992AEE287A10FFFD4877EEA2E91D0D58731FC978CE03F1727ADEE686DBDA3
      D9B6EFB97E9446C11D3CD7C49FE0B4E803B06860803DFADCED034FEBF60007F0
      5BAF39180C5AB87F8B859BCE7F89F9EFAB284C5BEDE162149F3FF741AA910F67
      2B78C52259B841F02A7641EE594CFC64F9C29B36868BE0AD1BCFE8DE587F9A78
      D3FF6F0CBF5DC4EEF235C937A48A2EFC307DE32FE043E8C66BF88447D90FA7D1
      9F437795CEA3D87919C03D49EAC5279FE0A768E9C56E0A973FC26F7035745E86
      B3C08BE1A771EC813CB518AE6338F7FDE1226A34869375A33B9CC78D36BE08D6
      86BB8E5B77D56D542710F63DF1A31067E34D70020897309A2EDD9997B4DAFCE5
      228A2749BFD76BF2D7F1DC8D934EBD4E5113EAFB45D2E977BB0D1E321CB4784B
      2E1701AC8950853E369C799A2E7F78F62C19CFBD859BD416FE388E92689AD6C6
      D1E259349DFA63EF19BEEF59B35E6FD1A74580E2D970E902482E40A0012A479F
      E70DD8575818403E6018C3A7587F4AF5A7117D9AAD52006E1D4D4389374ED176
      7BE14FA28B711A07C3691A8EFE3E74BD703289C6C31436FA7C016722A9F3E769
      14038AA47E3803184661947A20904E92753205A46900A48375147E5E0475EB57
      103D67133775E1CDF114460541364C61C0CF6EE0C3750FE0D11826F3E8621980
      443C8F82090AC070046661147B0BFFD29B8C6174149001C53F7B7E484F5EE25B
      F031F800671690A3017B7019C0F4A2B517C2AABCCB65328FD3102EAF60B12071
      8F87931036214C4693115C25111C96B48275C3C292B90B6401D0EC9FB8F6C96C
      41A80C1FE6746303C4E8C9ECB3F5196EF5676C5AC15F32DFE638B5063D801F50
      9382F9B8E164F8D9F72ECE41E26FD0A764EC061E9C5038D9A37812CF3D77221F
      A751940E9365B04E2F423FF4706BF4E779BA80D3922C611141384FDDC9DF6159
      C35502CAC3C80DC221FC0717E025437804DE30866F17F4053EC4E92C1E06211C
      6B58B90743C0A78B1809D93009DD651ACD8002FAE1D80B0218089499A9EF0570
      802730FC106E5CAEC2311A04DCC477F52848506298B12237A177010326E91A7E
      4DE01DB338BA802947533FC5798608EF740D6027536218C15C43A03469329C7A
      38370F141EB83CBE4C96A480008D98C0165EE0750FB7D405352CC1E50CDD29DD
      BC02B40C8673BA03E19602997463B8331D7F760954294C161F9AC6080FBCF0D9
      4D2F4797C3F3385CC649E8A5C3B10BE711F02D00303A88383E1CC7A59B8282E5
      71E8CEBF0D2F008FA78B74EA83A6163BCD76A7FE054F3F10A355ECA5F3384A41
      7304020DAAE0C21DBBE918F4B6259D37988F33C4433771D4F143CDCCBBAC0F71
      E3BD78DD03D91A375E3EC244924BFC00D00FE75EECD1D3F808EE112A7C349A37
      7501C3C7B07F747E1D624D21FC046A67033EADC6F1022FA0368ADF59DF445BE7
      329CBBE10C1958985EA6AE5313BE260F3791DEC0E330D93B3DDF824FC04CEFF4
      6C1B3E05377FF371F6E9CECDDF3C722A5F8A86E912006E3C8DAB86EAD14037DB
      88ABC6E9EF6A42839B4C08517EEB48C07B62205581EB878EE0F6F01F70668C44
      82542D71E9DF111E7DA0F22EFF057E03588C4FA07420E80BF464E906CBB98B1F
      C2D56238A5BB87D18A109E0C20F52190BA559202A59DA7F09A902C1B4A5C8201
      5D4BE47172EE10909AEB3DF80B6A00D035581C48C59D8C8B044D7DF82BFED8AA
      F71BF461EAA1DE3B0C22B88B0701D1C1B7BE4C46FA4B6738C68349CF854B6B88
      708983C0AE64A63442270DCEA8DDCFBA6A46C3691B5D16EDFE1020331F9E8328
      016CB4D5053298D8521D8A1CF6927F9BBBE993C401EAEBC0BE5CBE9CF8A9D3AA
      B56A1DE7F9CB8F27FF49E243ECF0E67DBD6D6BDC6ADB8A80D4EA6E0712408580
      740D680E0F5EE05C50A074165E928060E7AC9628817C45A8DC030E0C84663BE7
      D4231034DBD7AFFEE3DC73261B1098BB8933F240AC66504C6A028C8F1120D067
      3FF59CA9E74D4620FB39EE08F6D4018402AEEDA4733F219CAAE2950B3F086018
      07659DD071674814904F3BFE947E86972C410CF7A35512ACE5AE3472D6D14ABD
      EF158CF925B762BF68D1FE8D97ADA7E9A044E1269E138114957FD17D418B0BD1
      307093736FE2B853E0E117804F89C00016BD0A26792001EF4F1DD04EE0B17042
      C3B8B1E7CC401C9A2180F470F07919479F4133851BD70E08C48045AB319A93CD
      06E1E30B442DD855B8AEF60BE88108D0890350868D48D8141D85000D00912784
      E2859F8C41CFA8ED37953843D8C1D6FCEC2E46AB780667E5AD17AEF683461CE1
      E28F1C38336174E1B89F5D3F40E11BC181689205C99EE3C9D1199C63E753883A
      E9C4F9D90FD3232032A4C41A6AE71C9DC0F41D066BB4C433B71F98F4DB1CA8FF
      3610016E818A3546A22658F59EC09238152046A3B5236B3AC6DF8881A4A8F810
      5D44D2B792D1C6289E02A423504D911DB9A1D3A803F90B57295C759D11AAAE30
      E21CDE8A2F1D79485399F6AE427E268FD155878C82487BE137F52650F47044A0
      CFB89A20E29FD74C649977F29DEA409C06FEF85C8D42EF27DE80EFE681931568
      97F888032A352870488927BE1B44B3AD43FCFE7FFF50B0A2D180889371047F17
      76DCE8C05040E581DDACC2D40FF0FAC44FDCE5D2835D46324F7C0017CF7309A3
      E89F9E7E5A036ECFCF74ECA1B50B5015163F8E26B0A52014EDC7817D7909024B
      08789959BB427E387C6144B80F4725F6FEB1F263B8C12199D205855038061A4B
      E0013CDA40F51061BD4B4FE1D46B3A87CB28497CE4297083B2B6D39D340E0A2A
      201719E200CF235140B28AE8EE3AC33F7F7217DE3BF86FF8A566E6FA5E86A249
      8FBC448D6ABD7F4F715A54C2775E7E7B0034FB81DA1F5109B0C03089C6AB85C7
      6CA1106B89E01B9C0F227782BC208E1672871C970B1837017DBB16A7D36F8468
      B7B38A3CB80D42A3DC8615A25D5A219EAF6653FFD24B0E0FF6E5EC81824A2151
      48BE413E8EE2144F5A92AC80AF18110A8132F94160C29E5A8A833256466D40BF
      3AC859227DAF999836E729EB5D9D6D7AD396337C32EA0D5377F465CBCE64E286
      6FBC45B9303A7CF6069B86711C5B770E9FFF0A7BF73F3B83B6F3D4397A138DDD
      C007617119AC667E78E44CD1FF83222B4AD57174EE858F6ADB2A1AC948AA2693
      C6312C24818B88830B179DCBA085B84A11187B310A1DCED88F813124A91BA20A
      177B09EC0E123018215E2DD95E32454BD5E2F58BE451ADF9F0A068D5EE64028B
      7E46822D7ED80685C0C363885CEDB31FA7A89B1CFD16C5C1845C9D470E50CF05
      198FC4F3EA542691879C33559071DC313D8622DCF1A3024C651AC11EB35A29A6
      4F84CA1BD01D5768FE34FA97CF2B722F50D6856DAEE1B10B678948C08006B551
      E23EAB8DDC2688C3E3B9FFD97B5C3850B0D44F1F5FF51D2F042919B71DB5BD40
      0EF4C4514B0C3D6F823AF3147466B2242E3C54AFFD6481FAB7BA8B9580D46124
      C07135137BD41088BDA9335AF901016095C0662E2258CA028E44BC66CB41E88D
      D11E1EAF1FD57AE0546F5F111B456019935560E3304631E0F987FB505423E3BE
      7709873358C365105AC314568C82AD9F5A8698AAD8A72F1267B5745C3421C82F
      8F0A1C45C008D11AEE636CD0D8E7938AC01983D0E12E13A4791C7841D694F552
      4C39165113CA07C22ABCC5A9F88B25FFE6B2B58E6E9F78C938F699078CE0DD17
      CA5FF2B8C8DDFFC48C8AA7CE07E205AC2F87AB201011DC5D2E1D89737238947C
      9F25F1C3835768225CA54EAFEB24AB25826C3F64F29F30700EFD4933907112E3
      025C808A5B734E005F620FE50791CF2FA2984C91B0203FF4D9560B6A730DD06C
      EAC570EA3C435EF5585E888E8389456C50D3B68D3F5340CC35E9D5CE19C584AD
      CFFCCB9A073CE7C24FE7F2330D8C143CFF22BC07F78E43BFB417716347F1CD33
      2FF462178783854FD68E28F9CB088DA940FF53342C237D343E3A572609EC02A7
      9FA21D203A77E0D62D73C5372E56E3398A0D2E19A6C71E715A9A9C72B592F36D
      1CBBC9DC98599FC393893F0BFDA90F8218CC638171A7380E021DA6BB002A9230
      B462B4832328E014D1FC799332DB42D0C6080E7FBA6616812673D4C38F2470F5
      08D937AA5EB46EA37F819CE8EDBBE74F4C640B8422CECDC1372FBC94B3FBF780
      307CBC8808590A80904797BBA8EB4D9AE1BFB2D2DEBFA7D2BE1D42CD1B41E829
      4E0249EA8D221C30DCE986B80142C56FE83742F95FFBB1DEB2FC7996F3611115
      4208307107C22B92AA101DF2E471E8823B461226C10E6C5F486AE9655A436781
      1B2491939CFBCB44BDEDA7380201D5BC0F5F842B5E80A83676153B49E895ACA5
      A887EEA2AA3D38AAEE7CE767705001D7CE0B773F5FA7E3E6BBFF1AA46294AE77
      3FE91BA3EB2D08598DB1358B1B847320B33BE8407A036042D9DFC83080A31E32
      78B2EE036245AC643D077D781693E6F1067D00F19E33C923ED323FDAA3C09813
      E7281B2A7004A2689A627C81927889252AD9328D964EE04DC94206C2A7422614
      E740640C27283E935B4A46418D1D2D30A077AE58FEAD8C57312026A8EE140961
      19D1518B87A3581ACBB37C77F02D8DE5622477AD009FC7B12F9AD655FCA90AFD
      7B5C360B09FFD90F3AF2962D8F70C8FDD45B5802D12A5436481F5855E54792B4
      261E9005128FA29063382FD363E45A137F4A6C2B555769CC04E8CB1AB45DF846
      512C448B80C6F0FBD8CE355D6196CA9EF3B05360F598D8670250566828745E58
      563E80D72B1FA4DB9F2931673FB0F323D94D053614E51DBB6112B89481A5FD00
      95C4F3C4088AF718FBC3317993D0CE33D2A09D78A11DBF43BC11F175A772E4BF
      8F973F5CC2FFFE63E76A4F122DBC0B8A3F94F3631B8223DB0C5FDBED927039BB
      958A69736063BEFC89F9BF3B9BE82A9DF6773C51402A345BB106A7F1912DD655
      C7ABCD6E086BDCE89B2DA2D1EC3477BB889A9E78C2F25C80A6567236B5817CCF
      FC14E832EAC868610C80C6E0E9A8270FB33C3C1FF541AB7EB3F371F335EE3717
      39F328133A4B3103E559067A91F00DEC42DE0F0EB219E30940107F9C4009107E
      42A0720DB02A6875844B8A69B0EB4A966982EE505C65CE738C4C0508AF3F5D2B
      B69281363029CEB2499CA34FC4DB333FFF70A4E8B936CEA3E10A683A65421EEB
      2C2826FD89A395310C09FCF45A7B17542A541515B92DD3109A8BEA1DC7B4BACC
      FEBC899F12999BC0959D328EDFC74B25D5FCB17B762886375916ABBCE8E2C09D
      F03DB4189F7B04901FAEC77783D3E9E5A0D1C56285FD56136BDFF5DA7D2A13D7
      6D6345B54EBF8E25BADA832E55B36AE02DBD56136FE937DB6D7E1A6F8149F668
      98FA608037618D04BCABD184FBF06FABD7A6FBDADD4EF7410F1266C7EF6C1705
      925E3803FC9FFF880C572E9D636D8528FCB10BFFDB07FA82F269B2F4C68C6BE4
      C86226FADD883579A1A67281FAF0AEF93DE2C38E27EF27E193B4CAFA2AA67392
      7D1FA88077E962BC844D31AD2DD2EBA4A4131794D631395B491F80AB9CD9636E
      034A0BCA96FF59455A2B06B1E792C629D6A08895A74587E5FC4B9F75D646F32B
      CFD83B249E09154E8E5E42FECB6A02EA66866727EA6915D7E0EED891B131CDCA
      E5F1AE99EFB73A03DF4D7641ABCC2E00017C8179E22889E910D77D0A6D129734
      C7ECB270AE21004041076902323E5A61E1173FD6462D132374F2EEEC35E6A262
      DE59EA39582C01DFE3C2B98E8FD5FD35955624B97062C9654507C8CE38B578FC
      C25D2E51051979E9057A8AF4701CB0C313A197716CCE31F24154936ACE2F2A8F
      58E2F612246C8CF273778257D720732F7C5C9CAD93B863342653A0B70D119AE4
      C49F002F27C30341076BC1D2A2F58C5D26A5C93A49BD45EE37317A05D1E1C118
      B358E91E459B7866266B2AC160CA3507DD168DC8AA13957C8315D1AD22408C75
      DC32EFA58ED30FDC046F8B746C72ED517934BEB92FACB99D667F255FD8E1C14F
      7C98F4E17A8A6261C239DC127E468A22A9C8588B18F467539A04A38F3034B78A
      F9789C6447F718674908F7C6CE675F1B19289C2F70D7C63BFF3830E1F0E0D7B7
      272F30D4121696FA8CB318842CA0219D208EDDB5C1650D2C2C5402E2359A3C00
      E7CFCED7B1BF207A81FD1662CABD5D1334149489ACE9C459EBDCAB13862615CA
      6FA78070E343BA70D79C6C1F5188E1A33C536F3692166CA4DA0481CECFDCB16A
      A5D24276AC5E3179BEC04D70D5D6F98949D5785C9B01BC6F9B63E8EA1DC921A5
      9C6639B68AAD2083961A36E8C724FBA157A3EA40EF47810FBC30ACEA28DF5695
      CE83FA8AE19BBF7A33374135353B0F874A186232C432F0C73EA2FFC28DA94E0F
      4C1143777DBB100E1602C8C7D6F224AC6308F227BA23C8C34AA16A70AE82D584
      F20BD66AE72CF83815051356A255C9A40C806E87B60F82B4B7B1075E87B6C7B9
      5415956445E962C17A13BFFFC5C5D33C63A42A3B01D0DF0C6AA264A6E52D744D
      39159298306F0DA8B7F3FA5882879475D9B85AD98FBDDB20BDF1F2A948C73FFC
      BB9AD6EE3DAD6C0BDAB15BF856B3BD8D31CCF17CE29585F3CD475A7E5BAB63CE
      894AE1B592EC809558E92CB25035F24C325CAE4487AF4582BC504311BD1B682C
      940D282CE60AD68C3305F4031239F2A353EA495E5933E3A252C5845D1352AA90
      46198EE44901BACB228CB13BD21A4D2A6F365D6453A8E0D8645C3F5C1CB909E7
      D392C2A3F469EA9D91B20D02064915EB425A48BFC9F7EF8882DB45F884C35590
      4E9FBD3CAEE6820F3360607821AF9C8508C6322431AB866DB7097D25354CFC45
      C03590853CAA9D9962C4F5A39CD9323230AB3FAA998DFFE98D1FE5C4269828FE
      28371364F7C73AB599075C377C94338B3DEF9C27D67A5413039219F88F13667F
      77976E8882C953298BF088E606F2DD85377BA48043496F355B31E81EDDEC80AF
      3F56FA915C7893473AB574159FEBA9B51FD5D4E25592E893D07854531BCF7D8B
      82FCF551CD6DBE0A676EAC01F7B8C40F10A147FE9867B61741508707A4A69DBD
      2C55B37BA866CD47A79AED01D22A4B7D3B63B7EF754B4CBE0726B7BE2D26EF11
      12532D4B2A917678303EA79084155755D1189B38BE3659B2D5B34294FAD5FBB6
      38ABDEF7BAEA06B4F393F172CA192FE99CD27B2FC7DE325534A2A69235D93375
      B199D6AEE23836E24EB6D67AAB725F0E72D964CC9A30EFE4C24FB1FD1566C1C7
      58467CA112E338E2C3A4B866C2F0ECD0CF6CF618196BD947B4E9AAA08017EEE1
      47D1FE341E7906295F4687A6904D552252BE1F9BAA490840975E4835B7763B7B
      1321BE6BEF0687E2D4542AD24EE3AAD9BCFCFF5E0A763FD422B834396193F839
      A4B238201A6274E071711B8D6A132FC192E61A81B3114D94B39246EAE0AAC414
      B872242B39722AF0F188F05EB3B963C45B73C2A6E4FCB43D243A503A5245EBAC
      C23B0FE1CB0B7EF877359F62A7D81DAB84D49CDFE608702EF795A448AAEC4C20
      2654405B98CE6C14800F368A72566DAA47BE52E0F78B25017EE665C3EDF4D33A
      5B68D74974E88FFA8F9A1FFA0F10FB5135D3F67571D2736F4DF864221F245CD0
      4936EEA198030C0C62B799EDD1D9C2032EE61C81E12736D4399D8DA3F499DE62
      F0831B38E379E48FC9B1758B74856F1B51737860B52EE0DE1F3AF1CC0044EA12
      491487F0A8317516B93317DC8C8CC9865ADA51965BB606D9C676C72305A3F0BC
      A8769FBBE06C35A722CEE8DB61FE0EF1FEAE6585B0449E1DF6F08DE8DD1D11EC
      984E177BA947D847D613EE56359B4D198B706EF21A4D38B1F2831111B07EE904
      5B766155AC25D55AAA39A788891AF3D410D86274359B5F8D8EDC804C870A278C
      2AF00AA2A537EDB4061B7BF35E6BC0DC769DB14E27319B3E9A3BCB990A05153C
      3CC863AD00A45C34634648DD3E8A8A051072300BA21109DA96EC5A9953473B3F
      8AFD947F28E060C716E9D87554CE4346E36CE9C677EF202202F26D277D0B64D9
      5AB450C715ED548AFD969145778D2B3A3CF82A9145BB469B9DA336CAA63AC608
      0F3F563CC74E8D0EB77AF6477E00A7BAFA400760E7628E4FDDE6A6409BACEE9D
      3695433AA6CAC76655702CA148092E129E09720796245BDB6AF9F7A1B48AB877
      85E9809758E5C403AEE232D21C77BA6B7AF79061E2B56D3542EE9D71FE227667
      51388AE2F0E194720B3B37CAD939A1E7C6BA769E2AAD235D6AB13883EA7FEA87
      58E69E251E6E71CA3DF52CE5BDAC3E703F5CE08A194A9AF9C111BFA900957F9D
      65429975A6D60F1CB0BC11B19C79768BB8951DA061063805893A0015213B0245
      A06E3CD9EDD4EB0DA7F2E9E3ABA7FDE37DB0485397CD1DC7203F68860B6AE3DC
      4AAD6A8EADEE4E82AC99CAB64836041CFBF224DFAF8E48BDFE43BDFEC76615DB
      1F9CDFC5142B87BB76F6F1C3EB773F9DFD2127ECA6E7F15FFF7C5D2103DDF184
      3D9CE99EFA997864C1AB72CB57954BCB31FE516A1CA8E591BADB913292927663
      149C1DA7422639B5D9C7FBCAA1746E189A4DF2C7E9DE1BF270C7890D71E4F9F1
      E93C392AD78FF3034DDE5EC9A976C2A9DADB3995A59B78C9E20F2ECC2A1D592B
      A71F4E5BCD1F4E06AFFAADE7AF5EA943759BE1EE72686F33FE1959E9417F919A
      0CFB70EE3913782C4DDAD1217AA16DFD64A88E0F0FA2803AE604414E7B633FD7
      C23D977CDC27685F9FBB5808238603C7559131715D3B3C483691E2129B952AB0
      4EC5FBB33DAF2125FDCAC4456175CEFEBA1DCEBFCBCA42CDB2B250D9B7B8EC5B
      7CE390C4F6B7ED5BDC6F819E8A8717FDEA54AD9BCB0E98920FF44DD52CA558B8
      851B72498204B6F671F5BD84056123E6095083947D895C1109991F4516788B25
      867E60598528C6FAEC84ABC754BC1CC31712EA079038E945A4ADAD1336B370D1
      25E0948F2B1B0296DC81253305C66EC358B02AF6161ED5F6E320944514520D5D
      9F0B52066E927259498A9CC03251522E2AF1D3956BF79878346BECC21ACFBDF5
      28C2F36AB5220E9D491C2D698B70A689060176057C6C8BE8C122F4591A45013A
      D542B36BDCC711A3B5A807F5E33B5B7D3C5B0ADC1C20A8CA8F2D25BD3F82F561
      B6BFA978F0983764602F08E704539F47B1FF4F8C800C90224618C38C5512B0AA
      1CF6FC45397914A569B4584449CA75351FD9B206D8D8D60DD2BF8C57714225A7
      3F53975E158C49D520ACEE0C0976005E2D420CBB4427116CE308D5B452D6BD5A
      D66D94B26E29EB96B2EE8D65DDCEB795757B281A26A93F3E47FA17471719D6C4
      F110483543F7B33F7B7CEDC960015D6A584EE5D6A681CB357870FEE368C925C4
      29BE1B640892D327B13B9B495F696472CB472750F450207AE1A6EED6E57C2F8B
      186C88DF548C7319832097F3BB23FFD8A80845E94F4FFB9C6D84C18AAB740A5F
      D17E8E4D23F699BDEC6FE3F933ABD5F9F6F6F3A8BA91A59239D14683733BBD06
      F34647AAF5FA02C3AFF34DD3471E606FE86DE90E4FCD5E25C057B5AA1F617FF8
      D05DA8785DEF92D256761A1786E97F78AA6A30F8EEC33129C69B4E64CA947FC7
      61AF4FA7516FD78D25DCC404EBAA8D3A91D41E2EE08FCB6273BED40846B1BF0A
      BABEE7269E2A0C17442915D7A5026FA6AB0F5258C941C2A84637997B6239F143
      0CF70CE0B55BF06CCF7D05A21B6041556007FB419BA8A0E69159F911908EF18A
      344C5F15EAC47EE4767C52E6768054D9A2E11AE5B25E2A979F5EA36F74B13FDA
      A5EA0970A1641D0C01315D5A462B3FA0300A0D18296DAE7A8C49D7F6894A8CB0
      D39F8EE88923187994E9722BAE60BA54F1C751A892E9727DB98FB734E6AE2227
      FDECBB745D4D0A4FB71A5C1A16DBD1CC57DCA6E29671D54BECE6809DEEA6D22A
      4EBAC5A4F8AC1AEF7588A6385E1F0FCAF95C92FA69BF8A6328E9690EAD4C3CDC
      4C52DE43105DDE5021EDCA04FD1E3127D847681284AB1EE73D70E8C2318DFE02
      6E732AEA5775B73C6CDFCC2FB4D68FAF97461868823B472823778D1262A7228A
      899CC5A9D9D152FDC25050AB005A3BE7E404A91C2D5B29C3536300EE01802E1C
      2FDD734ECDA8E05EA09289C234B5C988C269E05325081077F7A475315319C5A9
      111EEA94292992A1E124630259654489EA846129603FC286CF7F227726480748
      54A4366726695F9D5A823DA5F83FD039C39BB715FC383C483CE37251233DE311
      8E79447CD68CA59794C92C56174D19821CE9426C4A406783D772A353412C8058
      BADA6F21F98D37F30E0FC2C9B613B727BDEC454B43624FEF179EAACEDDAF3EAB
      0FFA5012CC102D57691A85E2C54DA3D92C90EE40D4D08592EF282E4CDD9F4651
      2067531EE26E6FAE5D5F02D8CDC80FD9CD8B4F9FAA2D21B9BE4267827787CF95
      FE1D6B8E57364E8AEE67F89B544AF0D46C30F90897842D5DAB6CCE1BDB69DA53
      D01A289ACD8381E53C3128628FB87F55048E744CE57EE8BE4A66BACFECC91DAB
      41E4FD02083F516FDAEB637878F033BCFEE98B5F5E33D1DF8F9397617668659E
      71584B1616B6C82845704C97B30478899737AE1337A41FA6144B420939DC86E5
      3F1C78F9FF56B8A8382572226E775C734E1C298585EDC8383DCFD7BD4E0867C7
      2E0B7D23573A9F61808A54EC079CCACA76380F663A992902CAA71CF4A964DEF2
      0C1CBC3C7BB34F8664D1280F0F10FB29BC446B96889C080D3C140A59293178EE
      6170B653815372811457B2826B5E125815BA98BD60D33A11F6A4E0136079766C
      CD1FD48599A926A35BFB48843AA962AE7344721AE8AA41941AD18EBCAB297500
      7C059CE5F58BC4C17681EA317CE7AB9797979720A4B963AFE6BCBC74E93048A3
      6DEC987478B040E50A3890277D61169E0B5CD09008BB0A13BD10433E22A7D969
      394708C0233DF54ABD8EBFBC7AC15CB25D1F74F5C4F53DAF5ED6E5B697AF5EBD
      3A56EB94FE8794798D6167B682ACF704BD49DC03889B01E3B30EA652C422C8EA
      D7A0FE4FBF4A6D159CA85DB00737364EB09DE1CC67DB2F018B804884E1DDFB8F
      00F6D80B7CCA339596231334342FB04684F56A375CA303E1385BF58B36087576
      8A35E79692A80F7009120A1464333BD24883753491B52664AAAA00D6275145C8
      D030A67AD1B28B3674DE8FFE0E0079FDA2AA9A8B704511B34241675E611528F2
      FF22E86B54029A4F760E5C17BBE50CEDDC82A63606ABD691AA0212C6E74741A0
      D6878183DA489FFCB0E3CA08AF6721C01EA6B1F392000416DA66D7E00E1F2CC2
      263C8AD8661027A0E437BD8F8A7BE648C46ED7FE4BE2AD26D1C3AF1D57652162
      06147CEC04165C1D12365D25D65F030FA138E8794BF8E1A92E8AC4DD46233A05
      44766C54136CA6866F42BCF69B897FF0A81D23C6AF3E5F3BA72EA907FBC0CEF3
      4BB70B3C0803638A3B76B93A2955B6E24B643D668B22FD2A649A7A67861EA7EE
      8DD0C32766666612A71F4EB5E1971313B1960D26FB8DA59216E72D298C84F9B1
      AC49E332E18781F98D3066ECF16E6115D379EC81B01D5050F582FB0C0351ED00
      C35404DF164BE0BDB1274670C9804FDD73EEDBAB9E6D027F018A3CC9589CEDCA
      18AC0ED33C341C7340E4E553ED3B4EBEC7D3ECCB8BABF849CA8491279E56A89D
      B18973EDFE889894B553F13B5513E6E19F78D4875F30258ED72EA298CDCBB99E
      1D6FB02B9100ECA74F311BCC75A6C0388179AF524F4AE5217153C56DE869237E
      B922F1C418E22E401714CA2C21DC065F1B9B948C6671811A809A6FA1C663B1EE
      E3385AEBEAA030F011C601A995D399F68E185BB905A224BED140409BE71B1510
      B4231BF679737A2AE3AD806B530ADEC3F1ED17F03E5AD2CE79D78F8EF2CD539F
      DA047732A183329683F6402BC114CE0758CD24C2002A62C6365EC1A903E932A1
      6806C4653C76745189EB0FB4CA3378CF83AD921661AF52C8B5A27031D2D2DD2E
      ECF487E19F787A865F761C9BF2231F4AA95D4B965EB3B0FD9656DEC26DFE53E4
      76A4FBE9EDA50A7CA28000072CE41CFB20D820A13E3C90BC6FEDEB96B6DF0A48
      C5BC75B222A58479A2D2E4BD186F6057CD02F76049E669DC86C4A8826CC42343
      87AE88665CEEA7BF7C42B31A9ECDCFAE1F2075B51ACA2626488F4B54C3CB564B
      9E06DA0D2CCD7E4F71FFC4921429539D65482A44B06F38CED903BC7411A96D41
      9A043D2DD4B8C663942DF046F28D9319498C4A5A535563C8A9E0CC7E57D31C91
      974C98BBF6B7EC39B2BE31562E502626C1DE28951FE719139F5ABCD17262EF22
      F6D3149D0A46DA24035F328ED13DC73E0AD52619EB57B0ED75E153902925CDE9
      BA1476037BB667705DF6CD96C60A21CFACCA4C55BAF9E3CBB336F60A518DEDDF
      FD6AAFC0C7C603B18FCA27CD92CE168501AC892A4B8B7A18A4F3ECECECA5B41B
      699B2A1932CC8E6D58CB6005AB4D6AE9E5CDCA3FDFA256AB59905361D3BC361F
      2B4BAA1F5280986DD2E2BA57D6B48E35B5101020AC371FE4BAB0EC875230DE29
      A40E0F700E34851B43EBD6C535A53998DAFDAA48E15A0CD86D995350E6771D0F
      0EF3DE71E706B458EE7896DA1290697E9E62D95C76C52259D016E5B76C414DBC
      540CAC6C6F414F8D4F15816C9B90ADE6674EFF5D32EFEEB3B99C178463E84C21
      CA1D9A369D46ED9164DF75EF997D772FF85816AD5D53BEC7B3D54DD9EA5D42EE
      13D9F5AE84DB5D5B4A3C45E2B783643A78DF0D61D66EE581D66E392D86DAFB29
      F077DF0D9C176F4EF18CCF55D52539D44F6D52FD78F6BCFD007BAE4ECBFFFBF5
      C3436D3C55B6FAF543A6B960DBF9F5C3B747870E03F494CAAA836E721AAC46CA
      08B87BACD8F1E4BB3C79C5C6D0856C1BC0BEE1CC7A3569711D3E2D9ADDBFB892
      F37AAA1462CBE86689C2D4D748621C949D02DD419E7A447A20B0741D85E49122
      D79304DC631DBE24352D027C89DE08D0E2B4B66B39B304631ED3F7ABD7A08747
      EC4C540F1047DAB271E2B25BAEC8930193A3DE0C3A1A06EF1F01069CD7BE6A02
      CD23D4EC313DEF2D43D9D40E9A00B789667B82FD1FE75B964EF8AC6395748B1F
      B90FCD4559BDCFD56E470C7070632C55A47E93B3E54EE868F14948AACED1385A
      AE51CAAFD56A8499476C2AF0177E0050C72C788E443E36D606CBC6A00D0F3AE5
      47DB77B95B90AB8D577230E5BCACA31567CC78B9B3C613B33407D449624F4AE0
      48DA349A0BDE73A4D5CCD7DA091935D0479A44A176D6EACC1DD14B88821C57B5
      2A53356121956956E184BBC8E4246F221B4806E01CB124715ABFC4DED4BFB455
      1E0A02B74254C4B909A4019688A6688650E87818A2C5ED3BC8A89833F7BDD5C1
      78A0F82A354B00C50E5B32274A9AF44DF0920AB079931BE3271E8A73EFA9E4AB
      3D809A0CA0799272C73A6F7C6E3CF6AF32E8AE00C96455116C79241BB368053E
      D2EF64BDCA639953B120F77BED0FBB8ADCEFFFF70F1D43F7DF80ACA41B8B1B9E
      1C83CA3D44AD5926ECFEE4E0BDDC84D4282FA2153E7F1A60851358D7691A077F
      79195267279C32CF93E232322975C27EC83B9F894A18079174E3637AC1EB78FF
      3713F00F8755538DA3D3FC49AF9A7A7BAA961E57B7558793AC7AEB4C53511337
      C0A66A385B2EC664BD7DA68FD16737C0623B745C283CD03605DC604E786831BB
      305A257625B94457CDDBFB20694E6A02B83F39D3F0412A645217316C074FCCE9
      C70F6F08D21346BE3122DF93FD60A927847C929D79474819A647B55E6ACE0BAB
      44DBD40D1283D86C95A4741A76A711ABA8F2C00B0002D2ACB9174CB86025BE2A
      431198A8B9636C996DF2D7DE4AAF27F8EBFC04D477C9F6F40A866525E93AF08E
      A535B05E1EFAECF63BA1EDF0E01585D2230F5026F0DA6C8EE500F728B5E0F040
      D66CDAD528A32EEC54BCE66E8215E9D12EC20D06727144DB183DFD9412AAA2C0
      27FE0499B40E2193E14DFCAC120131E12D44CFB11A0B399763CD069E013DBB6A
      8FA2BCAB14C06C08FC4B9E9DCA85C75733AFABAA7420ED4641567EE5BCF6F42C
      9C66A4F588EA060335216292ECD381308BF631DD0B2330DD74154B276F4DE875
      950F16608208B50B7FE171601BDE368BC8D58A87C80940FB4114C72BB69AB104
      09D3E802F042AC4FCA650252DD82750E704A1499CF6E48D5686AE19AA5289E6D
      E258793F5C908173CBA402101C092C6F368B5DC50D740BC42A291A2ACC000676
      29D553BF5B87C9EA4B54E44CA59BA4F852060D414C1525AEA0EDE3C20FB1A2CA
      B16E369170E2AB142412D547EA215446DED8D59DA4A9BBBAD295044C0912A068
      15A6DAF34C21AFBA0703996C8E6B1867346700B8344B8A13D56310D90A23DA43
      90B29758526AEC2F51E0F54393EA3CF10E0F52E19EACA4CA74494E8595EBC419
      64F8A2517E5629344877A88FEF720BFC70A010C92D4ED35309872159B754C378
      51542338123E0A7562A562C8993141BB8001996AB33283EDCC650D766D4BC091
      28F8CC01BC4B74FE4BF1288A2FCEAD403604EE3418C86157484D51355D2CD3F5
      B6581415DABC5C066B56F48F5E91624B9A033EADE77654B3A423C956D3F5BD96
      911F1A6C47B31D223BE83C380E952B0056E11F1E8487073305031C0CCEF49344
      4C84326758B8042B6B25CAC087108E6042813D93095B0528D60190D97A294D9E
      411D62DB74DAADAB16C7896AEEB947896A44163C37598B25115641142FE7B9AF
      F2B1F494A1065548D92C0AF4A63DCC6C3220A9F41399229E604ADF0CCF1F8F43
      2B309B88E971885C742C9084E476FE5B31C5E64E9862B3B79D29367BB73338F2
      213DCBD9DDF6811962612BB1735B1503C8A442E1398A9F5445872F04960E6793
      7360AED241508644317987DAD09B6C8E84A88DFC950A7747530E7E516CCF36AC
      9977E82220AE55942089C88281B477E24BD6A077B954595F7E38F1816BA2A89B
      392F628BF463EE3E1FA6896DFFA1D6C342032C1B1D3E484E0638F13E065DF924
      ECEABAEBEA0D161DE74C0732E47264851D68ACCC48BE1DD1BADF67F525155B7A
      F6829327085A1F3C22A47AFBF6E3C47E6486460540A89056B4A526079DA048AA
      DE6092B0800DD08DAB5619A8556D5112C4E155A82D08986BAC425203FB9C481C
      E145466ADDF05C3067DA73BC3D559DC7F70F4DC56783C9D61C4D162929C552C2
      4251E133BDB429778E3BB71BBB7F53BB7233FEE0AD31D25595DD1B8A7F05EF3B
      3AE5B71F1E687A5CAB1D198C572975D6E1A2DA79488D6910B2D5BFB53210B608
      C4AA888DA41193499F5F9B63A1F09A04855A7671DBF66EBB269776EAC172B042
      0F85D985D97387CA5814DB00E4FC3F842089AF4114510AA684ABAB424694548D
      B9FAA983A56753A7A5533A9522561135E42F087DA5D31D4B7EEA162224552964
      419F374892AB3761EB16542DCD8BAA93A22FC80DA498F1C63EE8524659DA6795
      12E25DD03B4CDB415841D40BD47F8081B89C3704914076C74EB5679517F312FD
      D10A56A1D53705389170548D369A1865B1D0715002093B794CBAAE0C2CA1D923
      4F376A2165C9469B9A73421A176A037EAC4B3B2BC78C46972CAEA90C52A56C28
      21086E383CB09148DF89B8F6ED3C2C8F8476E74ED8DE10EE3C6991846C525D7D
      96CA33788B54DE60ACB721EEBE63B5DA767F9323850FF5E1811CEBD761E2C569
      4DAB06722B355942559CDC3217E1062900EA74CA3D743E2D9D67EAF30BD2464E
      3F9CE6DE49B56BC49B6A8F7436F7A7E95F780EAA7A949B5A613F8A26134F205D
      5E6EC6863CA12ECFC8A60A9C1ABEDA9F160D53236B0E7E060068FF2E7A843F9C
      AA198B873E33CF1774CD32B3DB414EF4CEACB74A2C280B7121E9C026AB668050
      AB609D4D52627F151576B31698F05BAA5CE7EAC217039E59A01534CE61E1172E
      F55B90D4606DD477A9CABDD546D924F451A389B2314B3634BCF72D1BB358EEE6
      A75462509D672C4A64556C8BD45DCAD729BBAE23713469614FE76737F0359B79
      1C3BFD9143A69E3AEFF3CC5DC51F0AD666CCD98F6B0D67D12A1E7BB855791125
      BF089650B51DDE18EEB5944BF5AF24BC89370D567C78801663AE266B61838509
      0246326B0044F0A2C436C1CB657E6A2E7986F13880086B1EB165FC29D2591B6A
      3A0AB49A456AF45D868F10A7B92495F3E63D2F053DA5B2551647B0A9BE5DEDCD
      608104DE266A4737F60FE46DE06696E2A74B3F28CCB0E282E8518EE8FBE12E09
      223B4F1388AEA5F48D76FBEEA49E1EBE29ADF783CF05BE631AE62B90FC13CE01
      7B9A4FDCCA161AD29EF7057A3F63542681209858E647B0A1870780A7CF31C49A
      3A2E922B0534E455266AF642FBA6287C8DAAE2BAFC14486AE15A07E0E9004D0A
      DACE9F16A9EDE79A07E4FC8CD448870766ACA932246F1D4B950D2A18EAE3DCB6
      8424CAB3C843E96283D8001446E024CDFDD160B855997068AEC94C6234190644
      6B5E70371D255853414A12EE476B0EFC625F24DFAAD9E1225A9978AFE7B2DD59
      5FEF888354B00E55AA3775E663A2A44B81A2352BA419A9A4325090FD007D888C
      89E84DF0E2520ECED2C6FEB795837FC958A1DE89154AD263B566A90D78EC47F7
      5231182EBCBC92AC9D62D66F3248052B83252686E9F87109150480D34C9844C4
      D446C4035906DA7D31C2973C79B44C65250BFC25F78A36663F9246461C3A6317
      8D7D477508B0D3D8BEF499D96AE8CB5B6624D8BBCA24286BC754B63C2BBC7DC3
      965964BAB11A99F82A1EA6064FCED86C3F65CBAB25FA59C6CB6CB53D5A85F271
      5AE3A3413EEFC13BCA996AD168930976C79D9851DA84326186DE05C64090A543
      0F4EF6846CED3E4A59C9A615ECA95533B78D7BE28FCAAF9A303F574A82741C22
      50648F5226B391548EB5AA25EAC12CAF4B22FC1C7D2292F8A7BC052E45231933
      9D4654C9B8B07D379CBFC43597B8440AB6001F194D2C0A11A330885CEBCBEF31
      D269638512D128E2EAD6C5F13D7EA2CD34D952DF56EE91F8EB48E3DFFE26298C
      3BF2385812CDAC4586457A8B0ED7A5168749A6CE744E89DED393FA520235F7CC
      757C9270BCAD9B18D7249E1E736AD0C48E810BCE1105A216B87373A547B3FECA
      699107D7CA61941AAEDC9CA538F8494C2888E2493669CBD885941843A730CFC4
      5D8AF4D1F9502A52371BCCB7E76781DC1EE561B8F230B06BC842995D9E878C5F
      D01C01C540B4573D54C9BD4682DCC6FAD804480EAE6F989DF14890FB93EA108D
      9EB512AFF378CDE575C86309B8FB50E86D078A6C50FEBC66759D2E6507D2C3BD
      D2EA338CD8ED1AEB046E3B58047ECA6A4D3CEAB653A717AB676205B1AAB914BC
      03A7679FC8EBA38FB2B31ACFA388C665AD30133DCB05CEA52398BC9E7CD25A9D
      D32E6995EB6C2722ED7992D609CC0BB3A1174BDCBE33D985A33D21089944DD02
      50706006D5097E6A2203032C474CAD057EBFFC43796BAFCEDAEDD49C5389B1E0
      D0D809071B52F32F565EC853E5240B8C3F8B79F8662681BD781A24E9E9269426
      AE21D731616BE022472A6E2CDCA673053691AACE42CA08A1EAA5E421C045E25F
      99C1670905CCAE8BCBE54840DBE67AA8219AB4E75521315B664CB5975339F7C6
      70A33A116F0B1FDC0A10EA0CC57E953DA70F1F7481572ED8F2BB2A98FD8711B6
      CC86EF09DDF8C8E765B9DE0A03736E2A3A93E22A092113B27ABCA5B6AEA51E52
      5A5F74C17966CA024E040A3B656C1E08E0A65E0DDB61C75EBA8A43F20E713318
      34D224BA1CAFD613E1E593D89DE9569C4C9174F9DB4C674ED12FB9F9205E4932
      9EFB38BAC89E7925FEB0E0437966D2815455DD58C611006B61D9C7142C8D099E
      893683DF546FBF6A1FF2E1690405D118A4183C65DA5DB1A394916B953A504128
      DC0B1D8EAB2E64A2365A841F95AA83EE05BBEE3C4943AAC6D1DED318C5045527
      4C24CE94A8B90FF484339B95131757ADBACF7CF913D6BFC3261F9CE22530DE71
      3125D516118F564656A097720D6FD5E75476F567A980C261B0E4DA3B09241056
      A7E94ADE37F372D48C54A24F42BE727F9A19DA7209D17B35E90C953E34761351
      1674D4AC7E58D58290BE582E690AA004A924667DA31BCBF84203FD58772CE260
      A33D3FD12754CD897320C511B70F2799D37BC7D162C12188A1DD3ACA4A94178D
      74EE0A1B32D9A2E2B4C4904893830E1708332B569530B9D1A704546FB18C6059
      6B53F5E4C26533FE2A0469D8D1BD8EA970D784F3BCD92B2E05B38F25DE1BAB0D
      28D68FF1991876EF8170BE561D55C9F9A2B17BA72D8808695E10241EA4BB52B6
      9B23D68E885469E18AFEF423771FE01CA4AAA3AF4F827152754E4F93E34CF816
      96C7E5E09E2D601A12063C28907E70B110707584E5D9AB63F877997D1D6CD47D
      09BB019B2E6E9089B5B8012038708CF238162E36E819072BAC3FA1809BB3F9EC
      29D154AE3738D31979793F2867A624D936B5819B24626D3337F5D8E9E5874F97
      813BE6209D887B52BCC61A34583553B02C9138F2E3AAF30AB03895B6201470E9
      7BC1442A5B60F2190F6AC6E25C79AA599552C73CCF2ABB7666D93DB6CD830767
      392EC0B874D0AB405998707BF7840B362E23AADE03474062942B1ED93C487092
      5ED69646385FCDB09A5245AB3D1462C9C548DC59E8A7B0DE63B49A4CACA230FB
      7A9AB8029BF2772230F7E32021A9DDB278E071945F898C7EDB59CBE6B392FE15
      B3E481787C2CA70F8BA2250ED70E0529C2E76C34E273A3D873CF254F5FB59227
      99FE15EBD46E8C6DE1F9656803D973FCC406686B29ECB10F887942D44B7AE11D
      1E50808229E2A44A7A313C6C83CD78EE7B566CDF11C32D5714E95455D47A03F2
      6D9C1CD94634AE928BA6FD2B1F4DB8FE3457FA9A642B6CFD3E4ED56DF882E40F
      F5B4FCF87A82541CD4DD8FD15B121C7F0360A827AA8E791AAFDBDF7934DBDDDD
      CA4E93FC8D642CF453B48BD9262DA54D508CD844D90C3607702ADAA0653A3B1F
      5BE6B19A8492B15130630B4CEDFA60FA81AA23C51B4985E186CED95750D162E5
      77CB94AD916C05513C7027FCC303A57253DBBB6C25036A54459B623F03071AD4
      2C4FA7F885D124137D96CD45B52750B53A3C629D4EADF6C818BA2D980C77819D
      259FA44A6835C9495963A029C6A66EE0A2605653C8096882DA2AA27B42E2AD87
      07B22CE9735973BCDAACC68610ABCE99DC44F13A81E78654598F239C232C2486
      8FA21688AE2442015AC054E33B55E3E22A98B27B1ED921738500686C73E2C83F
      A35F8EAE20DEA46A91FB04EF399A621256E0FF138DD01569EDA40F2503D65D1F
      AB1266F04202F7E1412ACAD9C49852CDCEA9121111BAB5E16099ADD65506A43B
      A2BFC8A0CB856B4D5B85F19AFAF00ACFB0073999748042AEC6E92AC61A6852FA
      AF423E21A916871668ABFC822B3AB4A90E21EF8DBD0550B5248FD72EEF1855C0
      598528C2A551449CF9F0806A50AD908A290794F3D11402C4D0EC5542652B5C07
      64525DF45EC26074A6D0B67DF12E29689FA5562AD441E6027B6BA9747066E78F
      6C4645B8772AB877844F789798D58460B5AAFB1CA170EC30292470BFF180731C
      31E88FFE6B8562C7994D7CD951C15423633C549E529B441E3D5F3BCFDDC4FB40
      1B7024952D48BB1C45976A37C547A242612DDF22DB5AB9E62C7B51B09897BEA3
      F2A343C23CE73139A72FDFBCC19D714D6778B9F538774272F3302541AACE5FAA
      CE535EFDBF39E7DE3AC9D77914F326008EA39740CB3FAAEA6FEFE0902AE0BD0E
      3FA3C4A5C3328E32C56FB98897D5845E5165394AC2FBDE4B9526154BA84E84AA
      DE649D2B61879C17A62A3349EC06F5627355BA806B1732D19BA073012823836E
      94A8DBC4D3A3ABF7E6E2F9C9026BE21897198BEE9E8A8D1F8044CDC5A3B8774D
      72ED70298DE32A8CFCEAF2B98987E29372528C3C921ED006A8067483CD4E223A
      93181D78D8779A38C406F875A9586A4D6AB52A05B241533235F854427CC2B598
      26149E70A4473D227F86AA610D64688D4648ED0B01520D8B9DB38952BB4895AB
      D12EF1C9328E6D9613EF731231FF64A72D6CE4F81C0836927E5C94B64704EC08
      0520CDC98B0BA71F59A3BCD34D734562DF3355DC061BBD4F04C0AAF46CB4216B
      B1163DC4B35568865394D92C64956011C54D49D9F216D3BC4EA3985C1033D07C
      A52E3185C46C9BA8D4E54F087728A06E8A6A6DBA0AAD7A59B27F7048A80305D5
      0BE6AA571C76E23A58E81A711144B9594CB21CBAED755202FECC7E6E9800329F
      8411F6ECECE59E533665FE3C12B9017BED805286710DD476E767AAF3B5271126
      BFA8880853961A0DFF2C2D001140332035EFB18165717905AE9AF35C2A5EAB3A
      C7249446E43C7A7B72F611A8D5481F30ED86B224628924A371C920F904711D4B
      E5AB0C7010DAC58B5415B992B878809E2A8A7C50ED9D55DCF62A044994E5920A
      9E1E3ACD28EC792C77638E3C2C25A4FAABC7743C965EB454A9439348770370E1
      196FA9646818CB3AAA44B4506DC523C7EE5DDDD42AEBC662B6614496B576E62A
      B11B3527F1662A7D005666C31EA4F4C30322B14C71A47439401D139FF8469FE3
      55A5ECC9D109FCC64324575704BC2A9458CAE2655E4A1BECE5DF4B39DEC9CAE8
      DE9E55A15CC4E48456AA055D5D5B4E0D143AFF58C126A92E3C7A29A41260F5B2
      9B2C47CBF251C6FBA96BC4ABB4501BB3A9AC6755768AD2DB9570998D97D8B9AB
      8D674193C077EFBA472DE918AA2438007BB72B78FD3780D26F70665E2F5E4400
      DA5DBB546BCE2F1845EFB1AAC5D8000754FBBCA592B9277120D2034B6A138654
      9A50AB6193C839C73DBDC011D6D2F76A82B3DE73BEF87A81CD16C89E9F084921
      C34F12C5DC5B81CC96A293AB0663FBC1256D124AF21FB7FF13EFA029F96D6531
      A0BCA76DC96700424382B7DA8CED5B9C0A9151AC4DB729731F1F6922CBE5C315
      05A4D066DC1F5D0B45C8E5D52FCEDC8346890F42D5C966448603F9F1166FC62A
      6A2DCB882C0AB74426026185A54D8DD9064F345DA3307376EC13C7110981EAA5
      1A26026FFAAC7D4F626A093D4F8CB023C392915850D6060800A89C715687C5D7
      39A4EAB34F623E87A08AADE058AE061861402D65A86EFB84C2C4F79C52E87279
      6C7FB3C440F277EF4B74B6040817C040A57BE432356C531E09B1DA1ACA76EE97
      676FA9612793DB37D1D825E3B614FD31BD30D9F51F785913F61549607B8AABBF
      906DE38337757EFFE5CD7F7FF8A14EFF6BB4FFC0F3ACECFCA67CA0EA7C5EF32E
      BDFDC06203A08A144254203A56E629770BA010DB6C60E9BA3E56EC20FBDAAC9A
      A9D23602288769A3CE54D750EC636382B79BCED8869C3476A5C4F407A5414CB0
      5152DE5446E72B6B40DAD353F0B302776DE2AA0A1EC219F701CB3F5AC80ADAC4
      3668185784921828EC840308335963E2C4F099FE86648A354F93AFB71412B02B
      1F27B99CEA425851B88D3FED03FE0134B89E58712EA014AB25A0293B46C8C17B
      6C46C1A46D2E28AAAE69A79B0425E40A8FD51C95E9002FCE8E3E8DD0E480C499
      A9AF0CD8C23E76F48A3DC7DDDF7FF5E2F51FCE1607F29E28BCC5A94259F4D116
      185DD17CB786A57FE00EA0C0ABBBD1ED3C5AFFA9F89CAD6274DBBBB067030674
      7C3F1573A2CE7A33D340687B089869A9C72E7F1186AAA20A57C9AEBA5B00624C
      F136206EE47BDD2F76FFA90EE4A2C81076856E028CED25BA914762255EA3272B
      58CDE045B5F432D53E453BEB3B537ED28A01501D7EFD29B7A206A18FBA5067F2
      BB8EF799A2FDD7EAF00049D9EF587AE00F0EAC2909D9572764643C7D3002668A
      350065813F81A7ABFC59A707A993B6908B1197CC0A9ACC6D0BFFDBACCC209166
      3A30325757852CF5124AF429E45E1FF4ED056022F76BD3BA9B44C41E89E1F148
      47B91ADFD7914991C6B9AA60B0A2B7D71E62F770FD37DFC1DBF866B6524FF277
      3103A93A9F5E7CA82AC3ECEB8F6F8F60C1FF5851881869B84BD6B05B148792E4
      5995A4F0696F1CA30BC62660B02F872B64DBAE1E3D7F7F76F6ECCDFBF71F7510
      1EBC1D834D32B1784A4A6439890DC91C5F972DE2B18A431464A7CED11975AC77
      3EA8CD4443B7176A6721E5AFA0CF4D5715D16A3FAC5AA5C38EA3598836B163CE
      01C0669247AF1D744139E883725E3F5938E4869268BF8AD5E05825DE00AB8DA9
      9DF39E4BBA2F6277F6247CF202538600DC17F32863E5D9C3FCB0D75B52C25434
      513E56AB505DCBC011FDFC76A90B692457B1651B36E50215385625AC94AE1752
      40358551ED39AEBE733F3B0B0C4BF32D4FE57E20E52BE0731F5F9E759E9D9DBD
      E4BCC2F7ED2A46D5B9C4E7BDC94CD5FAC58F982775CED43264B543450002D700
      B6AAAAD1AA1EDC76FD4E3DA6D0606C4C6E7EC514108A7509652FAA98B618CA88
      E6E5587789C2DE26DEA589E2C17B1654F7D79F12EF4F6B4EE5830A87DB600EAC
      7E21F7C0D0DDE9B476EC9CB00671FA3772ABD06172473E05D125F3D514B41B14
      7FB8D533A794585D3D72955372939595487734EC60801919004010B13878C00E
      C9C90C90A878244EF600EE3405D64761787E8819031CBE125A7CEDDDC9AF6F99
      A791F7D288A91310943097678656738A6698ACC6565C25A71F01C79C621E288C
      245914D4255E1188EDE832A6AA3D7EC2C18918DEED8F051CB2E9892272BAEB34
      9142B813B6711C0134414048B9278732F25B77F0F2D4243E6C86301A33A91C61
      0ED2A0882A38BEECE8CAC4B8124E2B64339154DB4367D9C846C98630F58F594C
      A68512D82B23A0A6266C2BCDDF67F50CB64E9305263E6FC7F8CABFAF164B13CE
      A65380E43E2B8EA9CA6DF528B983162559B77B4ED37FC1E85517D39A5629A52C
      8BAA46BB13AF967BE2A0D0ADEAC5A48187E0F04004779D2AE8CB0995F298F80C
      16DA30991204CBAA7511A3187944BBCD22DEFCFBFFFD43E73D81EC476BC6F8BE
      90EC502A44516F839896795C5D5553DE9771F949B7104274BCEBFDDF509D49F3
      91F4493EF12BE45AE970D79252E4272B4A0B56854A42F53A8D2AD52BE6C4CDCA
      340AD93394643C94D8FC7055867DE9626E6984A14DFB70DA74613D7BE1269C09
      111F8EDC044F5BA685D6CFC0B05F26CA4F2E17A986EDEB17F0E30C331D3ECE75
      3415A6AFA3C0710C588FFDC32CE6A50F580C52AC8E7B0E5C0AD20F483B2069C4
      1DC7C0DF40C74D323D72F61255A9BBF6E1414AAD6353D75952801CE56AEC0FE2
      9E3847D6EAC91AA3FB5D486C35934BA9A093494724F14B7113C0C90BCA91BD88
      4CF03FD047D1359525CD16B8404406B99D8295D0B8C7E3E3B324881EBDF5B0FA
      08A5D189D5AE86D9821863CBC176F937D9364920DC20E872A4BD5ADFE1C15CFA
      0F588DEE37DFA2B299B98854ACF56C1B4D74721F3B52651AB99E54742A399D5A
      F1C6264C6DEBCD3AF34735347033EFE3F41BE0357EE0C61C8D2FA51F6D9AA33A
      9EDBF98E70FCED376A2071AE9682BB6A35BFF5281852E626E789E4A9851EE833
      F9B5905267ED023BA74DB32E56C154D2B3F5B23C2DA35DA2D05097AD222A9520
      F356BD0B131706624A57B536D7AA2B4C065198510DB6832471DDA0A6F2A3F392
      48E4191047AC05FA490A73BBA17517213CE840ED9FBCF1394672A48C6013559B
      5FAD04E87326E20866EF8BB0652DCD742EB4664BC0F3D27944C14D9B7B4B290E
      A404E9FA6AAACF4D508056B4664C8851ED4731C450DD89D3016D14778427295B
      16DABD69A5AF76E6F52A21C6D796F54A6E19B1F2C8018B131D14198EA112733E
      BF861F72ED634E019998C2AD5B7084C04A31BBC9C6B924167A1B6A35DFA4239B
      8792D5431C6DB1E0921534E206514824FF17E1282A3817AE1397B03ADB26B3F2
      8DD6DFF2E283CDBC2DE81077C7F8E3ABF8F9FBD06A8F07C3F858670F94E29483
      CC890CE426CE351B32AD8EB2949B1FC5A0651646B4F42DF14DBABE1466910205
      D7641AC4991382087C78CE7E01D7A1C5A6BFE0DB4F9ED7F89E19A0A90A96C2BB
      70840B9C34E55ACED0A88F2E5C74CBDA4FEBAE91B9890845CBAED4DE773C3474
      3CAC23C1ED084E844D00ED46179FEC25D5468443FB83DCF202C7E549546571D9
      656D1817B0492516EEB06C0C33246071B49ACD33180BC7D51ADEA948D33F95ED
      74058667D2DF853C28A8E656A91C1E1ED5397F3A5A3F4D54675422285CDA8BDB
      48204828518CA095FB45917A733DB7BFBFA1018C6A434A8410624FFE2C6A44C9
      0096A89684D24B15FA988913159B244261830AED36DB76E16A0E479515302BC0
      2E6EB08A498FC4EA84E814C3E20A31F31C4591F0978A94A404DC24F009B2E44F
      FCB1D5B8D16A0199B2A324B5EBD5E0B01962873E32535F0D1E9DAE028432D684
      A5A31B9B8A32D27CDA1A4ACC8FAA81AAEA65915996281FDA906AB75955894D4A
      62C0253C49B1165242FD623DF22560C02CEDA8E203B9F1096E1A6A095B8C6D60
      084165AB31D54191A18D7F3D0B21A7F2D6D5E959ACBC13B845D011EA25146E6A
      4141C7ADD8E420F1ACD50B2737A92022B988857B523BFEAA9D351F9DEE7478A0
      E428C0447409EBD201569EAA919EF643972290A8B2361A206E92038695CE8B1A
      10602F50378FD91CE2B5004B8DE6E61FD7A2075553F0F0C0716B713C94DA9B5D
      1572A303DE9395CF4E1495E991B04D2D23BA3A5649251C4E1F79BBC7BDC8DCF8
      FABD36201C1E3C2743243970B048A1F3B3172CABCE3BEF7295003383DDFDC94F
      7F5E8D4054F013E4D3D4311BF852ECA1FDD19DED4B435105A7A212673983B196
      5DB100D2851F4EA20B05E2B2C177B6C1F7E05B36F84674779E624755D5649588
      4BA674CCE3D8287D2461BA68AB35DFF1149A5983284BE014B51E73BA496C9D89
      5DC3B34A92EBD228F12A2423999B3CAE4533F1811593F44D221CCA5B535FA4F5
      005DAF29300020A8D192EAAE5A0A828287715EC614B1056B4FAC46018F63A942
      5F6577798FD4B5C48B3FA37CFAC17383A724588EA98C1F590A4844E4FBB9761D
      EA1F02114CCE765E62C433C6CFF804082CBFF4B8967E78A018CA53E765B020CF
      547CF2E949926134D6C174FE1B6B9A8880C2159440A85DA5549A2549A4AEB309
      A48BC2594405755758D624832E0A4DF65C0C909E8B5C470F00CE076F3F58BB55
      83261BA5A972F3557DC1AD56E31CAC74C9513B4EC7A87F472F28D3DE8C27148E
      CD1B9B55B4B0B4A0B24F11A2ABAE5618953CC21A2EE845F6AD56DEEC09A7B23C
      F4467981389C55739F3D47774557626FE113A46C50EE07D69F64D147C750609D
      3E984F40C22C2290821563908598F8A3A015F537F1A9678FD8706850311D6BEC
      C77E8D649534359F5283B35468480E19D547CD541EC5106652F26244E3184B56
      44B12E29902BEA29B54BCD4C7CCBE9B60C3058894C576A6D389E8A588281C9D2
      08978D8C85861F0F14C990E5A5FCF86AA652934785172A16659A2959ACA7E6BC
      6276C4A73BB15C3A9FA500B49F50DCAB999A07FA830E42E3E66718BF218C507B
      1C40CC23E7191AFB57A19FAEF7FCB89F72E0302C03101165E03D515AF1E06CAE
      DDA9B0D99A3018FB736EEBCDB9D11951A9BD68B29EC37A8D97022BDBF05B1255
      1A0EA8AABF582DE4AD80A2733710F7AA0436CA4F996C37A98DABC7D51D1C5591
      5A09DF2D35E88C06DDAA7F4B0DFAF0E04C6DE9534285B1A082AA50E7B3347E93
      8DCF22ABD074ADCEEAE2F1E43AE272CBDC20986B2A9253C318C0D9AFF4A850E5
      954FF5A545C74BFD34D0490D153B9DFDD854D23A3CC8024EC5982C24AC059082
      539E288E9D591320C28872C1DC05F55C379BA26A16D22B13FF9FDE962C36056E
      096017E315398FF189C707D18F48BB18A49ADEA47A99C9154B24AF2C97BD2702
      680C22BADC3D80690C543064C81D1E8C2D0C6582A4FDBD997770A62D85635801
      958F0368870708B6B305FA859FA2AB718431EC6234D110A5207946D8DA8303F7
      B50AAE49B16AA87A9185B9D438C1937469A0921EA93C8707D694324DB5C38D87
      97AA3F41F1A9C3ED5CC611896C11E7FD25F378159E3B49E4A89E817A505C9DD4
      61CD4C6ACB9432E7EE8EB8B3A7B2DBCF08DF3032891E8897DE6299AEB1CBF11E
      097247D74022AF0B7921B56F78A63BDE678A915FDD0A3B1B874EE18DA5D09515
      BAB61F8FAF267401C15C70331F973B5A9BF2F65C630CB69D8AD863FE3AC67062
      C76D89CED62D9B501601F1225D5140D5732FF467A1F935C2284CB47521A59AFB
      93896987FE3890E0F59445419DDC5F0803157DC4E5B1E7789014508EABD619A2
      A5F2B3BC609526F1E8169EEF376F174DBCE17EBF55AD0C31B7DEA62BDB377EBF
      D910AB28645BF200A5987353B928AA5495E1D83A1C6E6F6B7B711D50E147472F
      B210FB55436C5BD12F53CB46E5968ED664385C24DEF8285F3BD47921E5E2F9D0
      76EA99A0332971C04223BD965B8C91A99272A9B80F13161BDAB27D1CFABD39C5
      0AB5088369CDA58B3AF1D4559CC0C1592DD938791162B7A163AE680FCBD7ED33
      D8942F4C97E7A4C2DEB44A0C7ADB8A7D53E8ECD361A9DC021D8DA78086756584
      E4D59952FFE4FE8BAC8CD46CF579D5264C899EBACFAAA29E0C070A102630ECB9
      FC692AFB9E04C81E5DFC97AC527027A0B5273597F726DBC63ED9D780A4E8B472
      BE78BCF2B6C89955671526127786A32572DC808971ADFEE458FBBAE8C5B62112
      BE9257D7E72E6F52A7FD7FA8DF134E887031A9BEAA0B6A5158E6524ABEA85340
      ACB349D6CED847A3691045E8DE90244EDF14452ADE6FB3A7E9E5A0D1857F1BFD
      5613FE347BED3EFC6975BB6DF8D3EEF4EBF0A7D31EE02DDD76036FE9B59A784B
      BFD96EF3D3780B6C428F86A90F067853A331A8E35D8D26DC877F5BBD36DDD7EE
      76BA0F8A48D4DCFC3E05844E1CE739FEBF40113E9F3ACE898A7BDF8FB3C4E299
      465A85FF764314C4BA12E776857306D9F0FFE51BFF4FA39EB32FD887153198C2
      92C1CC8F39C3ACA252E08D9DCCF9D1C9DAC9083DC9D5B3D3A26215A6FBC7BBAD
      0787F2D897DD22524518CFAE67CA21A56278675E8A7E79E686540424C3EFF654
      227B658AF191FCFC71AF54ABF776CF787754B51ACF660CE0B1676AD58F5CC940
      512D9CB38ED6D7D8BA644B5B40D05DDE49D2E93304366630D93119AAC3AFF6C9
      9D634730AB1FB4EA009BEA9B45E1E02CAB4C68269320B469A0C2E67296A96AAB
      453EAF284AADB7F3FAD0F8A535737A3DE962A0D54D60A0AA834BC206649CE0C5
      A3631735B98C2A16CF977ACB58A5C7ACE2041F23D5059B9ACA9A701650F0B88C
      F72A29CDA339F368F35B9A47B1C0F73B2498FF49D8A6F058F0158B1D3EAADD3A
      4983BFFCAA664AA7ECD14EF56528D59BB1CAD30F1AB24FFF431109F8A417019F
      7FDD522DF171ACE494ED352FA28BF007360BA9C514EC03AE7ADB72F6940BBF56
      E5CAC648C09932528918C9E9CF80EA068ACBBF026FE6D2156F911F7F5A3E43D4
      722AE8633B769E492536463AFDA3E220C7CC7684BD908F399698BF2475D786E5
      70690131B068BB07BD161BB2E9B7BD0E13EC555EFC8291A75AAD4BC017CB9E6A
      E4ED71CC5620B3B200BDA22143EF825CFFD61089428223A732C9997D8EB3339F
      60A9D5EBE687372D37D7BEA7A74F02A5128C16A5A6AD311A0BDC9117241B876F
      3FCEDEC77906081553D94669ADBE2D39677A8CF0B4B3251E55B00667BCEBD815
      55649350F58A0CF718D1C5E5DEE8632BC2266FF309AD03C3EF4AD74BA97982CC
      88437E131D96A99A93607F70C9FD294F049D0816D1A975FA2A1E73BA10751E1A
      FB2955B7A3FA30BADF32D7D23BFAFD05280D7F38D49A07B656D97B9FA1951BF3
      84F7A78E16D9E025E585AB37E58153C940872179ACA184C9ADA6D1BB9B2FB483
      F6781DC82E8A21477FBA943DCBD1ECD430842DFE5864D6397DF9E68D0AB2729D
      DF3EBC79417610E7C3CB571FCC75BCEB5815A4F6B0F0951BAF332AA8179B6655
      A8396EE005910A1DC6BFD1025CA589498601C745725D318189B8F4926D83EB57
      27829CBA2A2DCA9DA8A347BAC3321124E5BA5331B4989181898EFA652A844EA5
      1F639578EEDBE5543419A396A4D2D0E0589ACD655EBFA7A4C2AA97C6D0D98F03
      FE31D29922478B3C084CEA1930A774ED54A6D4AE1E6530EDBAE6A2762AF30D4F
      561C511197D3BF1D535D16240BA6EA4AA6B431F3286FF235358147887A47AFC3
      BF63C375AC9799D8F0DF1F3E7325089C8ACE70DCD6BF9E398B6EF27A458F5771
      5288E10E6F92569E1256FC4E73305DFD9C86A516874C7CA9E6F2DF39BA4ADD5A
      F95193607549B9915D55562CDB1194ABE691BD92EA051D1E807C4A61F9E33155
      0FA7C40599DC32F6A6FEA52982B6D471C87EDE469B0287E32A911EA587D3CBDE
      8F70BE301089BFC8724D976C11255DAA0D14A72A0485DF7CAC04224E3A539C3C
      23E05250098EA91BC7AFBDD4347C30D014A6B490165E185E4655600C6B66C11C
      7ED645A27EE3E6233FB06159156BA43D7CF7FEA3B4E78605AF4DC17DAE00435C
      7E21A5378CB95900CADFFCD87493D8F7F2E24AA81BE7245EA7C2E504E0EB45EC
      537FB03D13808F362170641A1C6462AC54294FAA2DE41482548BC6F9B4EE7756
      E55237CDE13B1E3135098F2356A454A61D9BA20B8D65305D24C15C96EED6957D
      76B1263F1D4D146A55D6C4E6EB32234B0150D8A019D5C2931E81AEDD7D8E8224
      C70480A9451A54CB7BA0AB6A26A94AAC9127A97EDDCC576531C7F3C8E7960E47
      FFED25AA0F82F4C67A17E90BB9E58A0268A281376B81AAD56E9DBF9D0B7DCD42
      44C0AF58A0CD028B0270E5B1CD691CAB74E9AB616EDE27C545B3F633E65254E0
      02792A284E1657AD529DFB8C5A87D87AABF3CFF671F2C96535B54CD1E2AAD462
      543DD7222EE1E9A789E9AA9658CB923D300F60812483F7F0B61C54B8B4C9DCF4
      EEE27112C5D3D55D87079B905690E3FCB95F45863D15199655A6AC040C839EFE
      0DE7C4B2B22BCD186DD8EA548BC52AB0EB76EE2B6BA1A07411EDB01A3C9ECF97
      676FF6847F9090A449794A55EBF2A2269D312DA5FD87F3BF5EBD7AC5F5648116
      2E966C223742EB82935AA720D49AA7FEFD477AACA62B4D4F4162CE96874C2344
      511096C24D31375B17B894BBBED6E1F8E049AF237D3A80A8EE8F74A503F2D1B0
      86759A146DD74897C03354E811341D6D31B0ACE6572B8E24131411A06F87ED98
      72D3B28C22DC106B4E6139E80627DE452D04B49649FDB25C2C0D82C1D353CCF2
      B2F8378B218C4A6576E84F5E08AA6A406DB296BA612DEDFBFB77276FB547FA3B
      3963F76AC9FACABFFC05E51A3812E1D8DB12F278AF13FC6CB7FD63DF45574DF7
      BE934562B0E398CFA71C768858B5DBB93E0060CD440F77DBD4DC3A62AA95E28C
      4F20BAFF2DCB9DEE2D458E55A48F0B6E4D2285E6A8DCFAE2E5D95B7F5A16270A
      0277C976BD77148BA81DF8EE9E54E0D3CBB6235BA5E914D513FAFDE91F4EB25E
      8CA240BC7AD9725F6306218BCCBA7982C01535D118F8F912702ED30A9C2DC849
      B619A7F1C693544E2DBDA55901E7E9C1DB4DBA35C9E00B772D860B74C145F12C
      42BB4636C311DF8BB1ACBA4497B07A7CC93822C63E72C7E754D034AE391536B8
      8AEF5FB512E59939A4F2A24A80865D50F6C32855A5B2AD6801EFD225572BFFA0
      9E651F29BED547CDDC24688156C0B987B0481810ABC39BCC2C95E7A85C3E9C35
      4915DF74F3BCA7D43C0FD617A6C63C36914EEB7A83D44E70EF9B3CEC29F4C174
      C7CCF7D47C298BB07706F52390A85E1E1EA87DA39BB1CB9F1E074D4C28BE796E
      98E8EC1A0C3012D3F96463AF5451FD7C35A15CB74DDB1ECFFD9CD422D482AD86
      348C81D800D6FFEC4FB079AA4235AAA99D7D9E6FB61FD720DC32408DB7091F3A
      3C602CC74EF5E600B83C6AC5CA5995BD3CE6D1A5341767A6BAE481DE788B862C
      8DC505813C0A8BA4E0E9EC186A251A609403E8AB506D8D3B12D702E85395486C
      BB8F8501A33EC21E778F8E56231B0555909897F8884F71747870C1A13714C553
      6787885DFB851CE2EC8849B666D38BA70383ABA47A801BC4808D6B2ECE64CFC0
      D9CC9909D947C36652C943C489EB201EA17700CE38BAD8EF3676C000D0C1C706
      0E87F5A95748617EA6B6E0FBC103A9C44B160E479AE22975D300452577981217
      3E16EFBFCC64D462D832678C5356A1704D39B4FF49B4335378087FE140673BE8
      24B32FF8C35B6E90F117A7B1DF589BD98ED0AA6B601CD4891094FDC1612DBEE9
      1C56B276E4D1573515B73C0A965B3FD1805338077C6DD3C92F61CABA4188CD8F
      B98C41A696039B72B8075674AEBAF5646625BE7CE5638814D7F6DCF1DC9A208E
      4F13DC18017FDE7362AE3303A620A292542BB105C46D756CC19E94EE7AB175ED
      208AAD7C16C4628F44CC3109C731229AE8D068F173B92C01A7A1C0DD55A756AB
      7130FF026329B0177B3433674DF4A5A324C52BBFEB17FE413652F588CE330D23
      89215E60495CFA4D6B0430EE4CD2F51A7540771018C503C7F1CF38B94C8F69EC
      376ACD5A9D5C292039763963408F6FB7B8CF0752534D2BAED92FCE10D5041265
      D33C2C5101B31AC745E1672F4E4D6F16F481246BD0241618B0B2E787F32777E1
      BDF1C373E799F3EA7D1B234EF1DB7E1CC5137BC9CA9D8BF8FDAA7DF65209547E
      380E56138392AF45E951DEDF24D3450A0664B7B78CCC3AADABDA66E9200D6ADA
      2117B0134B3517C461C2B4C42BEE6F2898A48BA076A5B7F0EA827E47BFB8E9FC
      88727F85D3598DFA54AC311E4DD372139B0DCB5B2655A40FAE459DB63065AC73
      1E71A41E2FAAB095821587A7050464A2201AF01A5CA56267488176D164BAD570
      D1376D6DA41DC47DC04033F6D18C3CD39E89091CCECF44FA51E1F57DA7046CB8
      559628DBECC20CDC98C1A6FEE5BE944C3F71020C2A71C4578BF12B5BA161319C
      853BD181F81BC0D4514B563FBD99ED207C1DB2A79E1B617206810A3A93B81FEC
      D37061FB4E57A16E9237C1F6C489EA4AADB306ADDF31E96005D26B684EFA095B
      EDFD31100C7C979F2C0C5FB682B5C5BA8632BCD41E0378C8DE65AC18DB165EE5
      A2B987074C7D74A7CC4D95F342059E89B69BB73349F1A82D5956A62B30953133
      8954126EAB272B56ADD11A1B2D88025C3711ADA6C3397577F5A573EC8DE0A509
      0D43EA0820B18AB187C35106288707BE1439A7755061067C20717E7D7BF2C2F9
      25468126F5B9B731ADFCE82C8D57E3F408E5C2A313AA06023FA98B64F6664F34
      77541627359AB1B893C68DC6A962C53A9C7C3CF2D318637319F3B93482C72E7A
      225B688F36F1BAA623708647610E2AAEE7185B91FB4B3931D6E26C7DECD36B10
      83813C63EA2A5929B1725DECCE9E844F30DB73DF8D629F88BD23478DE2D72FA8
      2E47E0CEF8BCBB1400818DAE305C6D3F483350CA8F2FCF3ACFCE40581391EBD9
      ABF7BDAEF3F2C5EB8F0A1BADC83FA4A82643B6AA82317599D365EC47B144FA8D
      97EF250ED2C81FDA65C02E271508CC849E06A71EBD24DCC4203765BA9CDBE4D7
      95876BCE73CC13C83509660F89DE6656E5A865DFC87492610A23DA1D19E662B3
      10369F5025E0231DCEA94C19EA2E1D037362A450D57A35C5A6C3899E0386AD5D
      60E53D0544D81A03C64C87640D863C104857A3B816F336AE9FCE72DA46AB647A
      8A4A55B21009AA29EA79586D026797719A918208E760CF0904D99DD871379600
      6690DC9F1138319E0AB0653F280396326301DF707EBB8B73018C8064E4632FFC
      A2C9F8379E0E60FE6E03440E0F2C47373B60ADAC9E0AD244366AA2EFF8D8D6C1
      CC19CA640999D0BBEB1168CF8F984826180B8E99C81584F387F728DFC06E603A
      326BFF464BAE606672D53939FDF903DBEAAACE9B937770DB2F3F7D909BDF9DFC
      FA161FA711B1FF929285222AE25139B6D45EAA2A8D72D4F17E9CE4D7A140A3AA
      D2B9B74898D9AD4020C11968EB2DB1EC2292A0830FA169C4C8F392E9916D9A88
      0609AAC14C09131C9946D5D031343B22E1F82FCE65D559DB35D03241A4A6E844
      E2B931BA0C50F9B3526A78EA987BC1ED76B3B942CC52D9CEC187136DB42A6BEE
      98B0878C1F6CBACD8E2AEAD5345AA93E492ED7EA0D3D9224908B5A662D0D5DF2
      B5E741BC15675520B9C2DDAC2CAF73DA61C9F8384BFE30825321EF09B6C1E462
      1A64DD0DD64A9CC916EF07C8733E7FD5080805C0CCC4D0E453AF2CC0E14A6DAD
      D665A51CDF9264FCA5AEE821579D678EC837184181C2BE0C57A56C17D28001ED
      00A8BEB25E89CE491B0CB3883DADE5E2735B8D5E9C8682FA2FEE90B177B1738B
      942B7B073458761A4F480469C7652E171E88A6FB9E2CF34995C3172D5E9F63C0
      0B837E1C98A410793F78001FC52BCF60C8ADA022DD191773062C404A19117D00
      59FF9A546DBA4ECAB4FC70782003DBB59751C18E39FB5AD5E13071FC527533E2
      5EE4186D45F495D514B241D3B9E6134D0798CD8636FD1AAD6622B066742A3D6B
      D2AB0CA5310099F8EC0C5BA8CA9FE6274563D812683DCD9C87E8AEF6BDAB7C52
      1773060514D2EA544109892BF9702FC47B41E5DEA47940D584A729B664D64F37
      AA90295A333E801C097FC1C29F31A7A80B67CAE1FABE5B7F4E9499D434CE408B
      DC9676147E486E63155A9790616F85A67DB159EC07D9F8B8BD108439CF15929A
      D0540CB24EE027987E9B35460B350120C281A2F00E34EF6C02946500D130ED36
      024897382032E40A09760C268691E828643AE8548E361332F2DAAA9C843E2F49
      2F761316E5622DE07072AE99050A34523F0C46FE89E89F5186CD8852542FE34F
      538195A6F43C85ECC0081880EBE23D35A7F29C5391F016375366C98ABF366B64
      D986E9B024316513A82FB023D952C71973BD41F612666DFCB065FED813C967E6
      91374F3B4FDDADA7047F6199D8B0049BA1D0DC70150BB6A0A24C88F45CE26837
      8970C60BAA08652E5E9DE555C0C0C383621CD400555151E4F7548373D7766266
      B8DD4CB239D81A6B1B5B9E52F544DE23BBAD12CA9E13D2A30F94F97DA44034E7
      40AD6D2EF3FDCABAA08853051CDBE4704328A9B0E839D5CAF1429562AF865862
      57A5913776517AF2532A5988A6A544DF48E141738C201052C8F4229F3E9489EC
      5655E7C4DC0F42156B80463F22EFD79E23FD9BF72F7E821D11396D3FF0F95737
      A6A27DBCE86D1E7A810A7641A79C90F01C7DEC5E1285FF63BFD1E56C4EAEB388
      39E832F245F29FC0695BA0ED98F27540F288E2BD9026DF72A0A4A46B87870700
      1E6D2614F286F6C329A5D9C4F16A49ADD4B2009400898A1676D0F0F4CE7D9711
      1C745373A4B47EB8223C9D601153F693D9919ED68BA9D0A561EDB9F9DAB3D5C1
      15B8794E34C6E00415909BDD5E7483CA5753F12CDB7101830BCE431C760BB26C
      A28A9A71045BE86332FD7314DF9289CBFE408AC7E6FA3F53971C85ECE7037621
      CFE3FB78194A7812BE00023CCBAEFE2CA40C3257E7CAEBA00E74DEB25714A4F8
      949A3B60B038DE338AA37316F44211686BCE7F472B6637E764151DA14C4F7EC8
      8BBD6F7EF95B14539615A5A7BCA56813E799A9922A57F0307CF814E2F673CBB6
      93C0A73805E7BF3E9D7DDC1307C6ABCD38A45C28278249F20A0F0F4289724294
      5E8D6C0B3B9D5405C837671F9D1F9D0F5AEC67C87E4EF0A7D333F809935DA56D
      A6FDDB1BFCED4D24CE3DFAE5B8C0B192804EF5FFB7776E4D721BD71D7F6715BF
      C3BE594A2931D0F7B62A0FBA46AA58B662D2E587380F8DBE885B5AEE30DC5D59
      AA94BE7B7E0D6066676607B300B892E348C32239973E8DEE73FEE79CFF69000D
      C8DCF6CEC79E73EDEE7E1C1F18B37766651F0AC3253E8760D84A4C6CE258BF03
      2B944A9BEB5F37B01EEA948FDEBC21A00DD74DF597EB6FB723DBBB00F197E144
      1F5D7CBEF7DC8DA32BEDEE9F77349C05D97F62ECE675B7E936DF8FCBAEFB0FEF
      E813E3D5E56BDED6D32F97F7572E8EBD6C657BDFBB9E7E82D1458F6332CAE8DC
      DBAD5FEAAE2F0727930ED6747775FA70B40FB64BA5DB937DE3201EDC8EFDC1C4
      1675E1E6DBDD7DE147578BD6CC1FBEDB6D697DF1DE8B6DAE4C973711D8D46776
      8C22F7D794BE7F30F6C1FBB79BE1C5ABCDCD7841F84F3CE6FDD10E5BC16D6E8F
      AE59188FBA3FF251DF8C72BBCED63FFCB3BF87EB83EDC520C3DDED8374DD21AF
      5EA7BF3D655B4F915673FFE686E3E478B7779EB4EF7AE8AA9EAA1C0EBEBB09A6
      AECC1C2C71D7074DF5EBE577E30E7BDB33CC7D09323294E3CD026B37BFF0E037
      44BD9EA2FDE345BB7739BFFAFC19D38D39D5C7337F94D2B049CA97E5ABCB9B0A
      E6F742AE1779FDEEE2CBBF75F5CD8738D1D0A47EAA21E77775799A96FCF262F3
      F676F8F1E677171F6F365795FFFEEBC5CBFAC0950F9FFC92A4CA1FC63DEEB6CF
      6083E077E361DF6C378A39F1F097FECDDDDBEBFE8132F70BB8DB9BE46107BBED
      22FBED2DC7B3F24F7A5AFB84D26F4E287BA7CE972F7A2DDF54453EF19E3A0C60
      38B3B6DD0E6C3BFB7A35FA3880FE84433FBA7FA9A708B6AAEAF70819D6C5FAF3
      8AC373072EE2B053E7C51E200E9E8CB08B353F8D463FCEA4BD619F9FF7C27807
      7BAFD4F1FD5383F1C46E4F137361DE8B67F3D975FA39E7325CC5B377C9DFF80C
      FBEDB9917A36647BB5DECDF8DCB2BBAE7F9A617F25FFABE131907B0F707A75F7
      4DAEE71BDEE46111A23FDD5A9BFF76488BFD9548FD4D2FDBE7C1EE5D23B4BFD1
      CEAF8F217E9A9DC4BE0BDB2D2D2EF6EE8CE851F5C9F669251F8E2DBAEA4BBBD6
      BFFD2D75C1EED3BE9FDDF7F3FE87BB06B7BB2B462E7AE1E13A382C3AB6FE6147
      85C1D97D0F3B9972D95FFDB0D7C7BD339C3C60BE4EDB0F7B6FFF3FA7EFFB3841
      CEE83783FCACAE5C7DF22AC76FA9BBBF7DFA74313BD83DC514FE7C7D354C62C6
      146A705D16E576318EC2A43F73336EA719EBA16B541A563FFA13CC4797F7ED4E
      92DF9FE31E77FD1E2BB69BFE26B99BCDD5777DCF75E9B39E39FEDB657F3BC370
      8FD77697D0ED19FCBA8FEEFD1DB56FF62E4179EA2BEAFEB2797B955EBC09317F
      70F19B7A9AF73FBFFEAFDF7C3050B59FFAE9D7EF9C1B4F4FA0FD40FF54533842
      4B8D62A1BF5AFA6DEE79E4DE3555EF4F5EB9FBB73AE29B3AE2F1E2D57AF1C45F
      765FEEADF13EA5B1479A502FC9EF1F28FAF7623EF3CB9171C47F08F56E9F9F62
      CCC335C7FDFD45D8E4DBE1F6EDAB509FD17CDD6F25D66F693F2C13F4D7E81D5C
      AB52AFA31DB7A89B915E42250F3757427BFE7D4DFEF819D38A6C75638F6E2219
      546385F75EBA13CADF02F09FFECAEC5F67326DB8D08DEA1AD9A85635B4E2AF6B
      FA974028FB949BD2955286EFDAD888FE7F397CD69D92A6986C2B2BE25F5DB4B2
      DE36465BA993C8D699646288BE8D9DCA51CAA66D6804472BD1C9AC4552E1F933
      1F3BC1C19DD0D93B11ADCBD10661636CA2838DA9D6449F5C2782D59AC1581593
      D04A89E044D31A13454C5ECA627D965D965674A92D8DED7494DEF918AC0AA114
      A184E030B96B3B65750A3A15285D493EA4E7CFB471DEB56D804446D306DD14EF
      8AEA4297BB289CB4CEBA46D1990F5A046DBB6C9823E3E8844C2EFBC68AB6F826
      A8244A90AE11B193DA1A615C5312EACC3131F436C5D6E58E5E5AE9B28C5EC964
      B36E64679E3FEB9A36692753CE59178F1A5416BEE918832CD2A81CA20A4A36CE
      C94EC6C6A3B81C832B5EA19BD630373E765ED8A2450E4A7094D0C6A47D4453C5
      B7BE6BB2D3D968CCD24A1D5CCAA229A2E95C6C45945DF3FC5955B62EB1188B56
      3940365D919DCFCE33FC2E19ED4DEC6262BE9D70D94669748E9161B4A5C08A9B
      A265C9AE9549C6C8303A5B06AC948A1EF0720E6758031D044BB7C3978D3440A5
      BEBA1169C50A301621EF055C8DEF5D055231A1228BF1DB5C9CEE126A6C6D42DF
      CCAC055558A204ED1B25AB796CC220D07A5B8C13A2ED1288C8FCABCAF36711B3
      36A1EBD033EACEA5D8E0652A3964D7159F5BAF72D58EF12184C64499850278B1
      332EB7D6C804380B08F64E0715ACD00DC3013C8D331C97637415C05137A90D12
      3525D9B65DD0CA7546365EB7022B14E79257B595085909A3528B859B2418904E
      9D544608654BB0BEB5AD2EC9823C578796D1199E218B6E0D8E65A5652AD995E0
      A22F05D4A0A3187D5625B6C81711B35618C5E0325EA968F8C93082D0E257254B
      2DBB04A69DD12124D5E6D474BA0371C99434D8668E654D67BD37AD7163C47061
      1749FA179183231025B428C3FBE7CFF63FD5F72AD141E6AF25AE886D54613251
      A506DB8B1A55B0A94DA1B5D63744038CD10153A50D4E1FBB90BBAE3032257D6C
      836A892F68D417708D0766E9A4B49054708CCB74CF9F311FDE60C8D8D826B960
      3421273B57416D8937C162379782726DC450D1C44C9F2D0E96BD752D1AEF94C3
      D152511E584ACDD80815601064A44EA7249A643A4DA8D2A2CDD822259DF15F05
      5008758CC06A9B1DD6249883327E642218B411D22DD1BFCA6D514DB23DB2EB4F
      5DDB5BA03553FA1FDE3F7F76FF49B65B9DE7484429AE7A8B6955972B9064695C
      4A04B7AE335971B4AE8BB1F526D3DE77CC5445A5B20A2E1B7CC060336B086578
      A725B23227555D45C496FF93A4B92422A6020EF013BC8C83E3C30575753883F1
      5A469C3135C84AED3D013DDA944801825847B51E5B4D74CD853E3C312C11554A
      4CCA791B4A8A4D09DE6AA7B0394A03DDDE5B91A5C78575C01DDBCE4B83659960
      A9DE68032E1C0C09A78DA0492AA5BD53BEA249106D194E4A4D91A5732E5A631D
      79429AE8B0B7AF11BA09A64DB69139758238ED39421383444FC2A3BEC695EC09
      370C06508A9CA5F1B66D6961506B0B0E923022F15D0851B70D79945841D4524E
      D4B8E5091B6D75AF4E344094C88551C86E4DA8DDE0E92A12CAA2B12993DD4CD7
      A24D124816A410A54887CEE20F6471062E8D49DE19D2AECB0D614CE6CE0A72A3
      0BAD68B22D52E5A48D064A396651F3941089D4EEC890A9181108BC5EDB588857
      A47AD266E170E0A586CD42B8F5C4C48C23FAA4210BA43934886404EA98299940
      A808A5CEA981B1040011B41499DC1862C16DBCB55206180878296D00D200C9C3
      20F03129BA9245D548D4E4ACE24C4DD95E61F28E6F490B39166BB121894B7504
      E6502CD4A5C1B1A00BCC064B54F8440D75C1CBC991A4108B663D0C852F0885C2
      39DFE49A405CD636A4E222FE9B8D6F1A5FE3BBC2FE51224E9C0754A8D26927C8
      4E0E38758A64640018D036D88B00126DC6F97142E55105095F40728AA9282210
      E8266A990319A075CF9FB5929114CC89623BDCCB055D7946358ACF5E7A5281A3
      FBA22D8812689CF04DEE235A3BD15A82438535BED616B484924C0DF8A0983134
      D51EA23145E782E68861A8207799CCE3B086B2A4BEF8FC998C353D937C49FE49
      0166E29783A7056F42D12414C65E32CE16822FC0A4E08384D682302948C10C4B
      CC788A052CA9AB223EB896402B74CD93745A528EAEB41CA4FF24E141FC43E222
      59687C01E721EF424571042C23748A8020E1206D258168AA7156A1772230634E
      4466F2023887DE913B518222D7C6081D6848EA9A66A6AB136D5AD556D60A9C49
      ADC4CC0656444AAE8434312C78572158810317E143B18568D237418500EA2281
      DEB8CEC1383ACC0DC9622CD03B07B0193E09B7D564899414BA83F62A28411138
      0F518C18D5408D3D4145C712208186E853199CCBD04717E8280A12530B178B8A
      78E0BA065EDA39A2B325C18826C072056C280A320B6D0C32989354CFE822730F
      3AC00E9227F4607C01076F195A249EB6C43D47A6D4AD97352F054772B14AA854
      83A8C30721B0127C4462359348D213132BCD25420817381601D5D68E55149016
      1224DFE288A1F19802AB8379D065D192978C4DC1DFA4036A22D4200AE8886F10
      2DE8AF4E4EC980C39345529369C99C095A8288050325DD419549D4F083B6D482
      01E294AB3FF770AFAE0393E12F7867CC2408425E820D3416769A54629CC9093C
      53F9127225268AE8A435D54147AA84C5820C0947CCA1463343B083CD11A8A16F
      D070DFB499FE2843F10534D406F2728791E08E4447DE1283897085004C2CD3C0
      4169BC5255572337E0332983F8684A94013376E03C0B49C82AE41BD0C1B0193C
      5E9A3AA33B896F10F272C6618449B856A99547054D610439377C8237139C87E8
      4BEC264067CD244887E4ACE20BBC8801D948DF2DC14674F487EFA8602C366BC8
      791EBA5E1302A490D0D574B90996E2419A16F69EA87CC00DC10B6FA3DF225A89
      0334D61091B05D47B406C79E348375715B595BD29450C440E9D1144A645C2770
      344A21EC9742F686084EEEF55474840F0AAF42F1D3D5AC4DC08070E180A44770
      ABBB5A3459A889174C0E168AA7D84691BFC94CA9F3701F94237120D5C4CA9E70
      26622C0C99344274A292C1E3C94B0479A0D8401BD03C47EF406CD270A20A5542
      2E01862AAB5693B57482C9588A4B0F936B89F941336FE6E16B46EA528C30F398
      6BD506D581F018D3984039DE541A40E0D69594C289C8C9E450024020B7E3EF5A
      42D135FE8943027F58114386681800A8546360A79ABC43150AD97609C35137F2
      AD263111E649E5A4537C8D4C4E3752338242150B39A625959D0BB0246688A650
      1EC3870AA090D031B62A4518347028CBE10024B19E4C9003E66C490AB51AB078
      55244C2B83B366538A2BE41BCA5C3E914FA968D02EDA135E068878AA7523A880
      1BC53E204376D03265223153415543F54DA1ABF744872319B881C454E49B4C09
      846DF8291B7C0A22475CD236C9508324851D158EADB0099E6E1D69A4B26B0B1F
      078EC45B4BF16E2BC7C00AB5A225D4D40C88F70B0AE6C098C81AB255F49BE11F
      C213560D6485044E3086E4E0DE1467104A87AD50B12FC2468A1F455E6E5B9F1A
      945E4B5DD21963A973CE9A3C4B48F13AA228A806EA6E62C3088822C243473173
      AB955454F2D4D89808BBC0C94C0C95A3519325FC1CAE07D26A754EC84FA4A4AA
      774569479DE1A5A416E8C87741002DAA138214C1BD6B1B080B395E138A1276E8
      2CAE5157285099A26A4B95BD3484655FA88C34D18E91115342DB51ADC21B6A7C
      68BA28E04A4A749040B255B216BA4C70A6E625E260325F97702A5BE92C01B205
      BE641AF24CBF32424582FEA9A4A808991CB66420A54EBCF2440E4902A1AE34C9
      C15DA99614ADE13702D280058CA2A06D23EA2106C292E110D6123FF8C2607BE8
      4DA44AD5E097928CC48F5DF072F26BAEC384C75184B4D6C77EFEA9231FD5852E
      74906A8A4B2091201C89E69404440910CB4863DB50EF744D61E2C25B62B3CCB5
      04AC2C8AEC96320E0CE5A8BE46CD0B39329E340876F03F185B97356522B4B52E
      3A5475FB0AED4CF4C66CD44ED569A87B92AA2300074CD09018B05828D8024201
      ED81A5118451BE4F21E892093D32D0B3C5BF6A5D0D8A28F051395921C0994CD5
      3036D2048E8EB8647151CA78BE23C88061D0C0FC6B92019600CA106623440A0E
      4CDD08AF21C32207E5212D31027438B75A6C085ABEF175B44395DE0D95A6B0E7
      ABC5FBD51972E3A395FBE1FA4D5FC357568263E0D1C2D6E5926288205DA8150F
      784ACED108D7A985525692C2B0164894C52DB548A24CAC158D835E11CAEA03B0
      BD87DC76DEC2013DE40CA74A99C0842F8306B2110DE0F69E1A833CE5609D7040
      0A713280F3C94B5241876A1C01C0105F736AA1309E825738550B3245E9C3D124
      34DCE27482840A0587A3C0CA558123E1501498013645A5A384083240E3A9DDBA
      44F2A210C16B896D75590EBA0B4F05C5060390DFC9222DC3D7941475D50635C0
      C39C37E0933449FD8581A1AB841228638D51A12E3F44DC0C3217AAA7AB48C5A2
      81130887F60C963BB03EB95D40A8D6ACF89E7BEDAF06C3D226D7831F1B435D0D
      3CB71678EA259BA1CD2112EF91F6D8311F5BA73AF5C255C439AFD85F4339ED09
      8F8DEAB1D59B532F72D26E5458E1C4B84EADEC3C3692C722C3C991E0BEE7F4B3
      BFA63B3F66F423D5CDBD06F4F0578FAB62313661FBD38FCF9FD5931D7173B579
      7B13EB298FD7E14D7F9F2B5565197B264ED72359496805BDD454A2EA85F24F50
      15E3C0A6A25AF12BA565FD5593EE1555A774B505F5BEEA475CFF8DB507F44A2B
      EB2BEAE90B5A0FEF0CF5CC026180586D291F6A1503A7688631E02B92DF6A3D47
      0160157F1A1856117591428E9AC1E7298E8AEDC734CA195375587F53E3AFA246
      0AEA2CC1777618733F4B889CC44B280D4B6D6F7CF5D07E8648C8E1C8D01A665E
      E7A4A056C377CA74C3777D3BB16B2776EDC4AE5DFF1D7DD731F7E783C63E0EBE
      B96FD3A3B37E271EB47AD8937CD0463E68A31EB4510FDAE8076DF48336E6411B
      D3B77168BC6AB41BECB4FDD4FF86254C54872D8EBEA31D581831597753BBBEBD
      B9FDE12ADFFCF5EA26DDDC5EBE0EDF4BABEB877A55444E2997A6FF29BFBE7C75
      C9C7EBED3777D77CCEF584F5F69BFF1EF6C5DF7EDCEE3DC967EFFFE7BECBFC7D
      CC6F6E2FF624DA8BFDF6CDC57DDB667C8CFC8793ADFD41EB7A4B6F75ADB65E98
      7330EC41EA7ED0EDF4004E77293E7CE20EE55377A89E7ED2FAA9C7689EBA43FB
      F493764F3D463FABC3ADD4252EF6FD6C041F4ACD03E9A1CC3C1C1ECAA815327A
      D58CE601E650C6AE909967F443193F73465B74C84378DC6E22667EC70EE659FC
      4C07F2DD27310F0D673A981766CE7460DE7D12F34073A68379083AD3C1B23031
      24C68B2F41E2F5ED42D72A9BCDED757FDB51FEFE76D151C33572E3E62B4B6587
      FD361689D4810E570A2F76CE31F8AE8FE5521FF43A3EDC67D1F06F870B33CB45
      B9FCA63EEB7CE144F2F577F96AF3A67FD047BDEB7CD1B177C2C315848BD5DEE3
      63B70BCF5A90DC77B06CEAF5E6AD719BFE45877E13BE592507AF7D87096FA57B
      975836D11D44C2DDEDAB8ABBCBBCCCCEAF437CBB5986CA4D58E41D5BB9DF5FDE
      2C9D5D15B9F8F8EEEA2A2F0B15BDDC1F969BB1975B46827A91B949F040681909
      EA45E625BA13DA5B33A95172D5DC46D915531C2557CC74B0F79A998E92AB663A
      CAAE98E928A9A78BD3F6B0967D599F9DBBE8389F0C37FC2E9CD78BCB6FAE437D
      FCD3224672D8C7A7E35365BE0E6FC3376FC39B57179F6FAE9739F1C79BF4C3C5
      CBA52C6127B58EDAF496F964DC6866B94DB7926B50B8935D56511DCACE2DE24F
      4B2FF3BA714B9DF1B99E67607C04AFBBEE7631925F84ABBB81132C9CE0A7E176
      D991EE01F479BF4DF908A377EF622126FE5019C117639E5D36E7FBE32F3BE4BD
      DC32081EFBDCEAC38EE24B03F1C7F5CDF250F1C50F6FF25B98E2B78BA43EDFD4
      6752E574287D12F8421C62F8F6ED6667CBD3028701FFB3D76F5E859BCB6584EE
      D34DBCEB9F11F65578B348F0EBABBA8DC7622D7EF6CFAFC3E5D55ED25866BB2F
      5E7EF5FB8B97C36317EBDD66CB2C58853FDEDCDE6E5EAF921F8BE0F7FE92BBF7
      971FF82398F3F50FAFD74CF8A31515592FF8C9E5C27036486DD20AA94F774FAA
      5B33C57FCF3F749BF0362D3FEED76FF3E01CB77985F48B509F63B05CEE25FE5C
      B71C59BC5ED04BD79D156B29B6067E2F170BEE55C83777FDB3E7171E774D31F6
      C7614F948132CC5B783C29BA2C391C882E4B4BBD5E094C150F8B17C40F84970D
      F94074CD903FB90A3737977357774FCB8A55F3DD4ABFCBA8979542A36C3DBD5D
      EEAED64D792BBC72CE5BF15593DE5CDDBDBEBE593BEE5E760DBAB6B24BA9D2A1
      F44A53F5B2CB6A8541F6DFDE5EA655AAEA05D799B7175D63DA5E708D867AC1D5
      EA997B2EE284E8B213577B82CBCE5E0D822BD2C09EE03A5BAE4E022B16DCF604
      D7D8B2175C67CB5E748D2D7BC135B6949F5EE4FE4994EB02D99EF83ABBEE75B0
      2E085FEF76315821FED955FE262C2CF107C9AFDF6ECAB09D6FB85AC72FEEBADB
      9E9CAC165D933C2877561DB2CAAD3370955CB8A6501FFDBCD9AB4727CE7CDE47
      B115137A59AFA73B29B75714C7FC6A735577FA7F797F7AE6F43AD731C9AEBB7F
      6CCF926C1B99C312FFF7FD83805EBCBA3F9DB26BD89E68D8D3F68356E244AB9D
      3676ADE441ABAF72BABC7BBD3DEA08855D5B75AEEDD6FCBBD6FA54EBBDDCB06B
      68261B8AC386F654C33DE6B06BE8261B1EF5E8271BCA8386F6D0369F86B7DFEE
      174ABB668796D9F1C75356B4E274DB0786B4F274C387B63C03A08B8F627D74DE
      B1A2A69074DFFCC8A853A09AE8FF3CBA2684CEC36C42E80CDA0E25A6FCF94FF9
      BBCB9BFB158DD367EED5D1F46FF6CE639C59ED3B84D97FDC6DC6A59AD3073934
      E397F551E537794F6A8EE34C68E98C074D9AFC8C334D1CE58C579D969872AF89
      D6E7BD6C42E88CBB4D4DFD9CE74D4C7D860B8A652E28E645F589E6F31CF041EC
      9EE78262B10B8AC5009E9F02262466C0F7C1F46700582C02B0580360B118C062
      76E2989CFA0C00CB650096CB002CD70058AEC9207201639938D00C00CBC50096
      8B012C17C7DFE3B93F0660B906C0723180E56200CBC5F1571D9BFD3100AB6500
      566B00ACD600582D8EBF0FE63E03C06A3180D56200ABC500568BE2EFF1BC6702
      582D06B05A0C60B518C07A59FCD54B39BC5E0360BD06C07A3180F5E2F8FB60FA
      3300AC1703582F06B05E0460BD26FE1E4F7D0E80F56200EBC50036CB006C96C5
      5F736CF07900366B006C1603D82C06F083F9CC00B0590C60B318C0661180CD1A
      001F4F7D0E80CD62009BE95ABC3DD4C3B8B27A70F5CDE98AFF707EDB1A7E2778
      6E8DA13D75C83F1D5C3E7E5A509C3CE61CC943257DBCD97CBBE092D25D2F87B8
      FCF8B2BBBADCF42B233FBCCBAD74C7ABBA7FFC6477EDDB7E33F56075B65EB2D4
      AFE51E96E84A4C363C2C9F949C6C78483A959A6C78CC3B949E6C7A1846D5A13B
      F570DD9ECA21E01DB635536DDB53ADED54EBA3E9BBA97647B3F753ED8E27AF27
      E7A4FB7871D0AD6EA71A9B9D171F0A8829017B5AE051B59D5EE239A3BFA975A4
      33AA9C38C6B44E4F0B3CA6DA09A9193A9E9AD31C754F4C6EAEDEC552BDCF06F0
      D4EAC70CBD8B557A17ABF52E16837C727273F52E97EA5D2ED5FBEC0832B55C31
      57EF72B5DEE56ABDCB75687F902A1ED7BB5AAA77B554EF6A15DA1F04FE057A57
      ABF5AED6E95D2F45FB71553543EF7AA9DEF52ABDEBD5683F9ED312BDEB757A37
      4BF56E96A2FDB87A98A177B34AEF66B5DECD6AB43F98DCA1DEFB8A683609DC6B
      7D3687EEB53B1BC2F7DA9D8D207BED460A783670EC359F4702F704E691C0876A
      9B4502F7F5372130ADC849D638ADD35924F081726791C0933A9E909CA1ECC9C9
      CDD5FB5912784AEFB3013C21F0B8D68F89D55CBD9F258167F57E96049ED5BB58
      87F663BE3543EF6749E029BDCF8E2013946CA6D61F50C7057A3F4B02CFEAFD2C
      099CD6BB5A8AF607ACF171BD9F2581A7F4BE2C844F482DD0FA03FAB840EF6749
      E0B4DECF92C0537AD74BD1FE80353EAEF7B3247052EF6749E059BDEBD5687F30
      B9B97A3F4B024FE9FD2C093CA577B314EDC7C46AAEDECF92C0B37A3F4B02CFEA
      7DD91E565F21B2FC96BD17AFC3DBDB9577C47E116E5EDD86659B81FC797CF460
      4EBB01FFD83FD5AB3ED0EBE6B63E03BC69FB7D319B612FD0A669C7BD3C9F3F53
      F5D140FDEE915288ACA56AB5D34E251575DD61B3356AD877539ABA07E6C99719
      7A4A4D2C6D9B9BD0766D1B723BBD13E8F092F5591774597229FDCEA053BB98B6
      47FF1FFD50E5CB6E87DA879F77DFFF84AFBAF3FA2FF7F5EBEC7FB9AF13B34FE3
      FFF9E71DC9DFE3F5ABED7FB9AF5F677FFEA5E11AA60C7FAD1AA8878285983C7C
      B67C61FD632C61FDABDF155D4FE7FD269A90BC735E9436D5079918CD4855E38D
      14BACD7ABAE7189F3F33C138531FB8A09A768A71FC5F794D6A60E5EBF9B3A71C
      DDCFF17A4A0DFCE3CDBEBE9E4A032B66BFAD3DC6D78F3FFE2FE8F7302A}
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
