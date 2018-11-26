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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
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
      789CECBDFB73DB46B620FC7BAAF23FA074F72B4B77240600DF993B77D796EDC4
      3B769CB59CE4DE2F4C6D814493C408043800284A93CAFFBEE7D1DD00484200AD
      1735D333158B048146F7E9D3E7FDF87D94645367E4F9621A7AD1CCB1DDEEC88B
      D280FE992C678EDB7547AB09DF31B547FC6F9AA5F3A93F9ECCDB4ED7EEF2D730
      E6AF3DFE3A0F4A5FC7013D8BEF68DB03477D9E0A78E36094CDC542E8DFF4B7CD
      5F27A9FDFB681A4759360EE1833D8261FDC01A4D9378E145A3E964EE25A9C8E0
      FA32F9BBFBFBE8DF474B2F8A5361D92EFCBF67B7EDAEDD81FF5CF8D4F9E373B0
      10A9F583585B9FF0F13FFF0143BA7AC845EC8B64734CA73C661FC619D2D83866
      07C63C8F574920121CF5CF7F7CFD158CD8AE98A4BB3D4900A50D0B86FFFA3059
      1CB4FFC7C5CD621C873437275F6F1484B70FB4F5BF3F7E09A2990FFFA53C56A7
      625A4EBBB71B7A1B63FEF1E30718EC7DF013DE37F5C2CC1ABDF09CD18BAE9DBA
      1F27AB97E20FB5FEAA37EDDC25DC1DDE25DC2D1721EA2DC649E0591FBC6C4E53
      6FF7F580E93A48D3DB079CD2D6B834B41A300C60441AABD3DE63BF77FC0FF63B
      4AE3D04BE5623B9DE673DB35DC8598C5C2FAE91D4FAEBBCF1EED1AEE7FA94DA2
      F14218E46F710210846379DF678796EF8F0B6F701E01C3E09DF3A0F04E773FD4
      68EF460DEB7D309B67724DE3E2F85587F90E1407762588D4F87B9D953D76257F
      C35E3875A75DC9DFD9BBA703ABF6231FB97FFFFBD1E95511ECF68047B5361EB3
      CEDFF09355B371715F773F799328CA31ACDA989E53F1F077891097F4E66ED569
      767A6EC5C39F57093F5A794CFBFD8A478FBF17E344AC4FF879B7F2F92A701DBF
      4CBC713039912BEF561D2A67D0AB18E115E05D30E1F75732B25EBBEAFD3F0722
      8B3CB828780DBD5E1517507BEE5805C6AEF6BBD7AF7C4C6EF8C6637AB37BC3AA
      27D56E979FCC77BA6F573FE9EE78526D73DFA97C4EEE73F9B9D21EF72BA522B5
      C91B0F9737B85FC964D50E971F2FEC6EBF53BDDCF6AE376F6EAD3318DC4E222C
      45CFAC5F449AC11B6AE599413D8128CA2C0A5BDA837AF2507EEE26910FD69386
      D28339B6B487F584A1F428A10B2F73587F2C4B8F1676AD3DAC3F94A567B7B6AD
      E354F18C229099592BEAEB54C98545F8CA4772B2EB0C2B9E2A02979FCAE1DA71
      EDCAA7DC8DA7D409ECB84ED5339AD2AA674AA7AFE35649353989D50F964F5EC7
      6D573D5AD8447EB4B07F1DB74A8C2DEE9F7CE3D6D6F51B5153169B73D6D98896
      AA87F2EDEB37A2A4F2B9C2060E1AD151F99CDEC241234A269F2A0274D0888EC9
      07CB20E5750EEACF83D21D344C07F507227FE6462DB1FE3CE8870AF01CD61F08
      FD584E643AC3FA33A11F2B1F8A61FDA1C89FD4A7829EAC3F13FAC9E21E0EEB0F
      45FEC61D5B38ACE344FF6B93156D6B6D5543D4CAA6A551AAF8491339B5389053
      293B3690594B03550A91B5F26B69984A96D54096DD5E5D25136B20D96E8E55A9
      763591714B2355491F4DE5DD2D45DDAD3105EC23216DE8E3EEA0311727955B61
      6B698C2A82B4CDD6E5181A578BC3B42B29CD169FE761724C2D0D534976B6183F
      0FA3F0B434482505DA920478900D2C2D8D554995B68403395611474B23751BCB
      0A3C5201434BE354B1AA6DE141CE681B3F8B4697F61713BDD2285F48F43686E9
      7C31C9DB5A57E7CB895E6998BB10BDCDB1EE42F2B6177827A2571AE9AE446FC3
      CED6F93294522C221FE7CB91AA384CB50DA6191FCD07FA4294DA5A58B54DA619
      5295C6BA3B1FCDC7FA7294DA5EE33D2055D1B4DABB773E9A0FDD9C8F6A3C2D3D
      DF9C872AFC2C3EDE6FCE3B4B5C331FA039D7CCF1B13440738E59C2C3D218CD39
      E5268FCCC768CE234B78571AA3397FDCC2B7A2F1BB7F17BE988F721765A038D0
      E02E44AC34D09DF8623ECC9D9581D268772462A5B1EECA17F391EE4AC268A193
      388C936C1CFE799408DF1ECD6057227B340E57C2DEBEE476BBC58BF0F5B6CB3C
      007EDB31C4C6E58D7B2B86A878210FE1B883E245F87ADB65FBCF5F7F8597F1FB
      8E41362EDBE58BF9203B2FEB4186AEFC013ED00F43B7119C6DDCEC7FC73089C9
      7C89A4C27547186131F2A44B0DE32BF4170CC5905FBA967A70E92D2D58E1DF43
      6B1406F62881FF52CF013695866E7708FF2E5661E68CD6813FC9C2A5978CD689
      B784E73CB83CF2D2A5172EE71E7E88560B6054DE2A8B479EFFB7559A2528B7C3
      8030D710FF09326F695B7F8CA2F8EF8075F122CE84F5FB28CD6E4291CE85C87E
      7FBC498C922C04584C27A9838BF7A636FC87C0F354780B4C244BF8165B015645
      9E14824E08D875B01E4D6649E0D363D1B23042B4C431AC511A89EB0CDE92FE7D
      1A270B0F587DBA4C823809B21BDBFA012F616807CC3375CA201A3B36010AFF1D
      E3A21DF8C67FF70255BCCA003822145722B41B036EE48D15E44054DE0D3998F4
      7844BFEF82DE25C83720ED802EC870B4150CEDFDE037F652E1C7912D4109534B
      61CE974E77274C8716225D92067020E1A00D3B8E35171E46BD588E84B3FBF070
      76BE04CE00A95BE18C90ACC4D27B82AEABA0DBDB17BAAE846EFBE1A1EB7E0974
      DDFEEDD085DF1F1CBA6D05DDFEBED06D332F8035C1589EEF07597025E0F6542C
      8279E0FB22822FAB083E8A15BCB230A863BD66C85A3F7A89370348CFADB77194
      D180B0F62C751CF82789D7FE284BA659FA4BE067F3576DF8B28417858E3D901F
      93FCE33454BF4F33FD69AC3F25F869325E7A40D6E1C3943F8C61E9C0E1F86F76
      B31470577A25920C241BF8344EFC44FD0DE5DFB1FC9BC8BFFE2CD49FD4B5B9FC
      7B65D5B11858ED8330998360318E730B3A7CFD15731AEBB3370E85C6A56E1197
      AA887F7925638AB9449AAFE97B8EE7889C8CE0F8379E5C963071077A7FAF48B3
      750E52AB9E57AF7E5EF8DA1DF382CB488436E7E3EE391FB73C9F7EFD7CDCFECE
      F9E0E5ADD9B4F79C4D5BCD86A484C1C310D8BD91BD730BB277EE9D961676554B
      0283922CB505BE451A474ABEE27D1C56EEE3D42EAF61158E26537763EFAA89ED
      E6C601714B70A7D59B5D7BBF373BEE161A377EF9DB380CE3B5F04B9348DD0792
      2EEF0D6D60BD0F8238DB22CE6D84720B9A926E1EFF22C6277A37DDEADD746991
      1B7B8A31E578F18BF7F4FBCF1FDE5BE7B1AF49B7DBAE9C42B08D53C106226F8B
      1EEE8EF3F36601DB9D0629E34FA7843F1A475082B81E3A3DF8D719B45DF8E3F6
      813964D7ED5EAF037F3ADD01B0FCEB6E6788B7F43A0EDED26F6348FFF5C0ED74
      F869BC0550B14FC3D8C321DEE438439437AE418F76F136A7DDEFD07D9D5EB777
      CFA82977ED56D4B46F414D57A1A67B37D4EC287ED5DD1B3B7E4C04EF6A267C8D
      25D50C7E3F44A539758A6CAB34B9BAF994B8A95BCDDD37F1B634875B28FD323C
      CB496D35B3DE187E7391B7BF60A25F30B85D1AD89003EA8F9EBBFDBE8B2C89A3
      D99FFFA05786419A6528B7FD4E1FF9BB582C432F13817FE6B4E13439FD6EDBE5
      DF49451AD1BFD174E2B6F5C7487DFEDBC486B5CB8F782EF0D394D886FC92661E
      88E520B4F3B7A53711F21710DD4594D9BFF3B70C9076F4C27646ABB3F6D0695B
      FF1381C4EF5B2DC62201DA41E92F294718788463C159BB8787B10F17FF3691AB
      43AAE0D211853F68BF6ABC94860BB982C946F011764D2DBE7E5DF1AEF5B815EB
      713A9DF282E8028C8C7F1F78494D1604CB565BE50E776F956357ACCD451A5D5C
      1B5D8097E0DF03585BCDCA908257AF6D30D8581B5EC0B5C1DFC35FDB2D2B837F
      F1A417D78697706DF8F759AFADD3DE201F74015E817F2DF26A3CDBB561824A69
      6D74015E817F9BEC5A4EDE0F6F6DFD0D4A4217706DFDFBA1249ABA3FFEDA7A9D
      0D4A4217E015F857AD0D3D6F160C839F03BF3DECB8DD6EE78FDDBCBDDD1D3A4E
      AF3B34ACDDB076C3DA0D6B37ACDDB076C3DA9F096B1FF49D5EDF757BBB79BB83
      B91CBD813B1C18DE6E78BBE1ED86B71BDE6E78FBE1AECDF0F6226F77069D76DF
      05F5BC82B977BBED7EA733EC751E62D3FF49983B2EFC0BF6F8F9337722727747
      DB4367EE77125C9E3773BF5570215EFE4FCBDC370497327B7FC66BAB61EECF5B
      70B92B733F60C1E50B98BBEB76DAED9E536995777ABD4EA7DBEF0E3B0FB1EBCF
      89BBAB7DBFD3529E2543572BBF4F54350CFD6089A761E886A13FA7B519865E62
      E8EDBEDD1D0EEC4A86EEF4FAB6DDEEF65DC3D0EF7B939F0D776FEE5E30DCDD70
      77C3DD0F7B6D86BBFFCB70F7B6DBEDBA6DDB1EECE6EEFD41CF1EB86EBFE86757
      0030BCDDF076C3DB0D6F37BCFD39ADCDF0F67F1DDEDE76EC76C76DB72BFCEC3D
      DB6D0F066D67601477C3DC0D7337CCDD3077C3DC0F776D86B997987BC7EDDBFD
      AE5D11217FE63A9D6EDFE9F57A86BB1BEE6EB8BBE1EE86BB1BEE7EC06B33DCBD
      C8DD3BB6ED766DA75FA1BA9F399DA1DB73DC5EB767B8BBE1EE86BB1BEE6EB8BB
      E1EE87BB36C3DD8BDCBDDB1EDA9D41BBEB5471F7EE009BA5776DA3BB1BEE6EB8
      BBE1EE86BB1BEE7EC06B33DCBDC4DD07B6D36977FB1501F34EDB69775DC06713
      2F6F98BB61EE86B91BE66E98FB01AFCD30F712731FBA2E68E64E45BCBC6377BB
      4EC7B56DDB3077C3DC0D7337CCDD3077C3DC0F776D86B917997BAF6F777B7DB7
      536197EFBB7D4C76EF150BCA9B6438C3DB0D6F37BCDDF0F6E7B836C3DBFF6578
      7BDFEEBBCEB05BC5DBDB3DA73F74FA1DC3DA0D6B37ACDDB076C3DA0D6B3FDCB5
      19D65E62ED4E1B5BBFF6DC0A9BFCA0E374DA9DDED0D8E40D7337CCDD3077C3DC
      0D733FE0B519E65E6A04E70EFA8361BF5B95E7EE0CEC9ED3E9757A86BB1BEE6E
      B8BBE1EE86BB1BEE7EC06B33DCBDC4DD3BBD6E77D8EB752B3CEE6DA7D71FBAAE
      31CB1BDE6E78BBE1ED86B71BDE7EC06B33BCBDC4DB7B03D7859F2BDABC761DA7
      33EC0FBA269ACEF076C3DB0D6F37BCDDF0F6035E9BE1ED45DE3E74FB6EDF6E57
      B58D39736DA7EB3A6EBF63EAD3992EAF86A11B866E18FA335C9B61E8FF3A0CBD
      6F3BEDC1C0A9088F773A3DB7DB714DAF18A3AD1B6DDD3077C3DC0D733FE8B519
      E65E64EE8E8DA5E43B4E6584BCD31BF6EC4EB76D4AD219EE6EB8BBE1EE86BB1B
      EE7EC06B33DCBDCCDD5DBB3D1C747B95ADE06C60ACBD816BCAC91BF66ED8BB61
      EF86BD1BF67EC86B33ECBDCCDEBBEEB06FDB76458CFC59B7E374FB8EDD37DCDD
      7077C3DD0D7737DCDD70F7035E9BE1EE65EEDEB73B6ECF695739DE6DB8C1EDF5
      BA86BB1BEE6EB8BBE1EE86BB1BEE7EC06B33DCBDCCDD87ED76CF19BA15BDE05C
      BBDFEDD8F0B3E1EE86BB1BEE6EB8BBE1EE86BB1FF0DA0C772F7177C71E0C5CDB
      B12B1CEFBD8EDD77DCF6A082B9DB3964EC7DC1D208122EFC67B736A180208225
      245938998FA693D4B146DE14201166095FB80B9FDFB9A67CD7EF7DB37189CEDD
      96F805AC7F9F9DD3DCFD8EAB74EFB6CA2F1002EE829F5F22DEE02ADB775CE5FE
      E2C03DADB2728D74F63756D9B9DB2ABF403078E8556E8A73B8CAEEDD564912C1
      7E22C223AE52AEB1B7B54696661BAFB2465C388C55F69BEE249EF59DABDC5F70
      78FC550EEE86AF28276C08B54D4408A7DF07F5DFB62B9CFB4EB7D71F748676BF
      F70CEC03A8CE3C9885E0BEC5C4FBB40F3C6BA9FECEF6810396EA1FDC3E701FE2
      DD17AEED29ED030F6DB3FA02E6FF6C6C565FC0F20F8992DC6AB3BAB385E06029
      C997B2F721FCDAE956D8FFCF9CFEC0C5C4FAAE61EF86BD1BF66ED8BB61EF8740
      400C7B37ECBD117BEF0E9C6EB7D7AB2871EB0CFA03A7DD765DDB7077C3DD0D77
      37DCDD70F703202086BB1BEEDE88BBF73AEDE1A0ED5615B9756CDB1EF6BB8381
      E1EE775ECA0345EBDD5B4381E7C3D0F5CA1E30ECE250197A796508807F09865E
      5CD943545D360CFD60999E61E8FB30F4BED36D634B9A4A6B7CAFEBF686DD41C7
      70F4FBDD65A3AF1B7DDDE8EB465F37ECDDB0F78763EF8361BB87DDE22BACF1EE
      B037E8756DE36A37CCDD3077C3DC0D733F04026298BB61EE4D98BBDBEDB67BED
      815B55E4D671BA4377E00C87AE61EF775E8AB1C61B6BBCB1C61B6BBCE1E886A3
      3F2047EFB787C37EAFA2AE6DBBD7EFB4BBBDA151D7EF798F8DBA6ED475A3AE1B
      75DD3077C3DC1F90B90F7BB0F26E85BAEEF4865D77D01BB44D64BCE1EE86BB1B
      EE6EB8FB211010C3DD0D776FC4DD079D4EAFED56F59305ADBEDFEFB6BB86B91B
      E66E98BB61EE86B91F020131CCDD30F746CC7DE862B7F86105733FC39236CEA0
      6FF78C65DEB077C3DE0D7B37ECFD10088861EF86BD3761EFED6E7FE876877615
      7B1FB8ED1E68F7AEC96A37DCDD7077C3DD0D773F040262B8BBE1EE4DB87BC785
      FF39CEB05DE177EF036F77BA6D53B3C67077C3DD0D7737DCFD200888E1EE86BB
      37E2EE3D673804D5BDA2808D6B779D6E1FEBD619EE6EB8BBE1EE86BB1BEE7E00
      04C47077C3DD9B70F76EBBDBEFB7DBC38A5E704EBFDF01C0746C93E16EB8BBE1
      EE86BB1BEE7E0804C47077C3DD1B71F79ED3E90FBB4E55A7D78ED373E1BFA1B1
      CC1BEE6EB8BBE1EE86BB1F020131DCDD70F726DCBD37E8F51D7BE856347AEDF5
      3AC341DF758D61DE3077C3DC0D7337CCFD10088861EE86B93761EE7DBB6D0F86
      4EAF22A8EECCE9763BFD9E6B770D7B37ECDDB077C3DE0D7B3F040262D8BB61EF
      CDD87BCFE90F06EDAA8CB8DED01EB843BB67FCEE86BB1BEE6EB8BBE1EE874040
      0C7737DCBD1177EFF6BB8EE3F62A2CF367AE637707BDE1D054AB33ECDDB077C3
      DE0D7B3F080262D8BB61EF4DD83BA8ED9D7EBFD3AE4A781FDA6D781898A2E1EE
      86BB1BEE6EB8BBE1EE0740400C7737DCBD11771F0E87FD6EBBAAA5FB99E3763A
      BD6EB76F82E60D7737DCDD7077C3DD0F818018EE6EB87B13EE3EB43B4E1F14F8
      AA94B86ED71E745CC714AB33DCDD7077C3DD0D773F080262B8BBE1EE0DB8BB6B
      776D67D06E3B957D647ADD76DF6DDB8E89AB33ECDDB077C3DE0D7B3F040262D8
      BB61EF8DD87BAFDD1F767B838A5AB44EC769B77B8E51DE0D7737DCDD7077C3DD
      0D7737DCFD1971F761CFE9DB4EB7226ABED3736CC719F68DEA6E98BB61EE86B9
      1BE67E0804C43077C3DC9B3077E0DDC3AED3EF0EFE80DFFF9DAEC6572249025F
      C018A1F8BD744979EB9DC1B0DD1BF407C3D2AF9378058B1985A9F3C7CEC7067D
      A7D777DDDEEE87DCDD0FE5A5F0773FD6D6BC6DF3411D30B8FBC14EC5FB1C7B30
      706DC7AE986677F763ED8EDBB7FBDDAAA77ABB9F1ABA7D972A0AED7EAABFFBA9
      5C22432AB7EBC141C5DAEC211A62866E67F763C38AC774AFA18AEDB6773FD7B1
      6DB76B3BFD76C5631568D285BDEE0CDA5DA7E231B772C71DA7DF7701D72B50C5
      69576D791FB0CC855352F15C25AA384378A8D3AD00A753812B791E6AC57315D8
      9257A7A8DA77A70263F2B25515CF5520CC00236A87BD5EB7E2B10A84190272B6
      0703A76207DD0A7CC92B67563CE754EEBC8D688665B32B9EAC202EED61C7ED56
      6D9F5B812EDDA1EBDA809E15D8E256618B0E71AA78AE025B062E12DA7EB757B5
      E96E05BAE466D98AE7AA900540D2EEB5079584BA0259BA03DBE900B1AE026715
      75B1BB2E208C6D572059DBAEDC75DDE1B4E2C90A0293D75FAF78AE025B06BD81
      8B54A282A1B4ABC88B0DE8321C747B15F06C57204CCE9BAB76BE5DC58C6007DD
      B65DC556DA55F465D0412F7CB76A7D15F8D2EBDB5DE0EB9D8AD3DEAE62464EAF
      036069577195F6B06ADFF370820ACE5E415FDC36CC7438B02B10B453852E3AAF
      B0E2B92AC9C5EDF6DB20825451CF4E253BEA0E9C2EA0CBB06ADF3B5524C61DBA
      4807875580A962482E1079907FBB1518DAA9421877D0E9F4807356BDAF8AC2D8
      7DBBE3F69C7605CA740695471EE8CB10666B57BDB182C800B2D820A2556D61B7
      0263FA304590C4ABD6D7ADC018D7EDA09C55C558BA15080302A40B27BEE354ED
      7BB7CD527A22AEB27168FDFE537419C5EBE8CF7C75395BD255FC300AE01F7B14
      64DE12899C3D4AE0BF740CFF79B8547587537107BF250D7C1C903EF4F0BCF5FA
      F4B9EF8234D81ED067C74500C1D9A72F1DA0AC3D920A160B2F9BFF98F0DFB771
      94B53BA3C538B97C1580BE243F5CACE0758B74E185E1DBC4038D6AE107E9F2B5
      983AA345F8C14B66702F806291C8CFF0BB98FEEF09FCBA4EBCE53BD29DC8CCB5
      08A2EC7DB0800F9197DCC027DC97209AC6BF8FBC55368F13EB4D08F7A499485E
      FE043FC54B9178195CFE0CBFC1D5C87A13CD4291C04F934480AEB618DD24A003
      0C468B188418FFC6ED8EE68983EFC1AD43F0EFBEA58DB79010065B970631DD2E
      7C7C371ED9289E2EBD996074832FEB38F1412AB58912C0F7C9DC4B5220345D16
      74D495758AF5C26D1E351A4A24B85E84B022DA70FAE858F32C5B7EFBCD37E964
      2E165EDA5A0493244EE369D69AC48B6FE2E93498886FF095DFB8B6DDA64F8BF0
      8F3F464B0FC0B106360ACA0B7D9E832006DBBB00A8870C5FF894E84F99FE34A6
      4FB35506800524CA92544C3234B2AE033F5E4FB2241C4DB368FCB7912722DF8F
      27A30CB6F97201789DDAFC791A2780205910CD008671146702145D3FBD49A780
      32805422BC89A3AB4568177E058576E67B99076F4EA6302A28C85106035E7961
      00D70540C319A5F378BD0C41D39EC7A18F8A351C8659142762115C0B7F02A3A3
      E20DC87E2582889EBCC6B7E063F001CE1D2086033B701DC2F4E21B11C1AAC4F5
      329D2759049757B058D0E427233F822D88D2B13F86ABA4DAC39256B06E58583A
      F7E06C038AFD03D7EECF1684C6F0614E373AA09CFBB3ABC267B83598B1C9167F
      297D9BE3D41C7A003FA0A60FF3F1227F741588F56510F90E7D4A275E2860B4E5
      6C9CF8C95C78BEFC388DE36C942EC39B6C1D0591C09DD19FE7D9020E4ABA8435
      84D13CF3FCBFC1AA46AB5484D9D80BA311FC0717E01D2378045E30816F6BFA02
      1F926C968CC208CE342C5CC010F0699D202D1AA591B7CCE21910B1209A883084
      81C2783D0D440867D787E14770E372154DD05EE5A581A747417292C08C357D89
      C41A464CB31BF8398597CC92780D738EA74186138D10DED90D801D2927FC0E93
      8D80CE64E9682A70722214577079729D2EC9B001F4C1872D5CE375815BEA4D27
      709E70D6DE946E5E015A86A339DD8180CB80607A09DC994DAE3C825506B3C587
      A60902042F5C79D9F5F87A749944CB248D44369A78701A01DF4280A3858813C0
      615C7A9905D3CA6C3CE5FF3E5A031E4F17D93408E11C596E07C8039E7D2044AB
      4464F324CEB25000A90EA7F1C29B78D9248C56CB6E1B0F1C4CC81AE1A9F32D75
      FE809847E2DA1EE1D68BE4A60F52206EBDFC083349AFF103C03F9A8B44D0D3F8
      08EE125A92683431F500C527B08374802DE22F11FC145EC1E15A46AB49B2C00B
      68E6C2EF6CC84217CA329A7BD10CB950945D679ED592CC493E8CAA2B3E0E93FD
      A2E7DBF00938E2173DDB814F61F3379F949FEE367FF3D83AFEA36A981E01A0F1
      346E1BAA4F0335DB88DBC619DCD784864D268438BF7324603E0910ABD00B224B
      E2F6E8EF706872E104D47CA0D8F4EF18CF3E90798FFF02C3012CC627503490E8
      0B1465E985CBB9871FA2D56234A5BB47F18A109E2CABF60888DD2ACD80D4CE33
      784D4406532539C1805E51CA0159280B27F3D17402EC16E8043C3D4D5D17C81A
      AC0CF4BC2E4D9C6F606F23FE8A3FB6ED81431FA6C221435A0C7779D3B68326C3
      7950F8E28FF597EE6882A7929E8B968521A2250E025B529ACE58CDA83328CD63
      341E4D3B9D115E1F0158E6A34B10238089B67B4004D3921487F24679C1726EF0
      7C6962347FB80A8BFC65EE652F520B08B4053B77FDC60F32ABDD6AB77AD6AB37
      9F5FFE4FC477A052BCBD8FB7B1CE7E1B5B05CA766F3728017604CA5A00C2F2EB
      40F819F991154FAD73164B520BD89825C1FA83583F2204EF0233791A3A658031
      B8DCCEFD406A2EACCF1FCFAD31889C7184E896C1952C5E5AA19866D6244E22E0
      A00049BC9C03D07A0BD28175EC85696CADE720EE833C76297CF57CE146D88A13
      6BE245D658582055F830B685F296051B320755CCF2B677ABA5F667131E2EC1C3
      DE84870C49687EF4DA3BA1D1B65EC72B9CCA79184C2EB75E7EC7CDA8DD0A84C8
      1FBFC3D21F77CD6F00E6C9A32FF6EBAF14AE20F6AD8330B45250AEE00F5E0339
      166426401616B9E056C01A94C51566D48EFF0B68DA7385B7F88A20B5F82802B2
      D53E2D6046F0B86781901AA02ED6F8BD1719E84BD6F155900684D4890532EC89
      055A050CB93D25D4967CFA351129E8CFF0858E13DE42470C8F0ACC7C062CBC65
      E87E1DF45FE37CD116612D449A7A3320394B54607D43F08B043F5D8A4900DA93
      0FFFC433CB9BA2968428A7A09601FDB6D65E6A89EB49B84A832B64097447E8A5
      194921D61C7E1E0BC0D544A0FDC16F7C447006F2CD11F0011CC7B38E5EC7D18B
      AC09D920E641078298BA07072608C591055AE1E4721C5FB780FBC0ACE8ABF04F
      69D6F2754466E03C222FC2612239CE2ACA82104602810B00210D4D785259F492
      B46082C2361C5005240D00B483811A8E2F8309391DCBF76E52F819A026AE9741
      221A83068EBCF5A397257194F2C4D5A2905630888AEBE779CB791D1119A1E9C2
      2A6B5F1547E14D712C4D768ACB9343EFB5B5EA799A8606B40F6080337493BFE7
      E3324328139583D54DC23895A4107F3D7AF76201306760205861F17192EF720E
      7DB52D681F0288C87D477C951FF79A3D1AB6686CC06A000B0C8443CA3724F162
      E310A011C44B9B6FF08F74BBB54CE22B947DA642F8636F7209BB410333BEBD0E
      5290BBB430F56FFA2E9C0810652B985A37F10A7E0CA24B80D80D33156427F378
      15FA087535E7315ACF048D23E78AEFFA415CAFD20FB19F1A9E52BB65DFAF6602
      F03658E0A6014481BB908D359A08224047E768E016C07BC28C1076323F32EC46
      9FA9602180AE0A9F4FA8C5DE8008988EE513C0960830FA0971B4D7B53FBCB22E
      C455BD8816653717C1754BA48B222BF257137552D1D963615CE42288569948AD
      63C7B6E08024E90952076F0C086975D5AFE624D482FCD56A360DAE456AB0BBC8
      31384A11513A11CB3841AD2548D395901200E12582CDFF56C28D3D95149A98DB
      E7B4E97963091B936FACF5296B5879E2B49E69DB1ABD18F747A009FDB1630F4B
      E1FC8D3773234E129F6DB0BD61BA1BFDF1F1C7D9E40612E7B1DED718E518E2CD
      27D699349B04A18F7BEFC7B0E1285AAEE384D8F92FB08A03DCF0DAF556AD96A4
      6C14498EDE8288F2320C41168BC3D52262BDB6C161B116B12F4E51420D1854CB
      38652D19A831F0D315C8D0C067236411298B2C5A65E657A5CF11A0D508F4FDBB
      CF1FDE005B4211F8DD6BEBC744009D80ABB3B94047BA17591F3CF4B0A3892609
      04B02D00FF779F7EFA1104D0B1085332AB814C47C22E482700CAC5B304511580
      CED1B107D2EB853207E9531644411610BEAC24AAC033A0613440C30C8625BC65
      131122E5738459355ABD4297305CFA3E8832BC0ECB0075F4DC637D0B553D50A9
      6616C6037C03E70A042256CA40CF87CB1320C6ACE62CC4B344A66AC0FCEC2541
      BC4A993DB3567FFD7AB558F2F29355842E1C7CC603861D4A2B88A4558862330C
      F45FD091FCE7024C1A2F58F34D2D3C6E13908BE3E914518595F494B574029387
      F6911BA4CCA0DADF002C16844964CC14D9DDECC8D6FD8355C64FE56095179A4B
      485FB6A2EAF77EF936B175006920DA81BC708DE77A1A4440173DD6A4E6920CA2
      A12598E68629654A200C0681D5FF628BFFD6BA1E6EEBEE2EDC3E81AC388D57B0
      1FE31BD06EA5299A18193A9490B890E1EBAF1BDEB60FB1BF0A1597D33631CDEB
      E4468F05E913E41EC16D049D7799889488F6A33BCA76388D30DEE81E54AE4343
      A27AE165F796AFC71FA7D306180344F3359C5E9049D2738C4A05710FC5BA8987
      824D82463CB66392896441989232EF22CDEA86CEFE73845BE5615945EC15CBD0
      74142044AEBCD062EBE65A492F64FDE6FBE628E7C0A9616E0452711C4D83D92A
      911627C79DF35052147A8EB0AA80940F14235364858CD2C77FC1CFC0C3918F47
      B115E3B7B481547C82B8354BE2D532F792F8C2037A7485C64DF8D1A25F1FD3F8
      F34CCD643F91CB519EDAA2B1DDD8CD1488945F0D100DA7BBF0B26042DA9C34AE
      93B74D11BD2DBFDC36481B18EA825445A164AB04FD3AF194C928799BD8B596BF
      53BF403A908FAC9824E1C68E9E77530BDEC60F53ECC195178418E7720AEB194B
      0D0D28570375B5EC48033A209DB5F91CA5388134108304F79924EF044E30B230
      6C17CDE1710EEB63D19AB5AC4ECB6E5D9FC21F17FFB45AAD13D605F8497AA724
      B638AF6990002522927BAC5CCB81F2259EE02D1A300470A9747D1764DFAFC638
      60AEDC03C94698F9D6312C7173FFB4FC844A4A03A4033DE6C458F91B786C96A9
      099BD819278790917103191ADC6689B760F42FD8FA25E82860C2BB141CBBE44D
      28E5481E82D45A783E993DE9F8EDE5A0A64900670F410A82A39588BFAF02E9E0
      0559462411C84A64BDC091F1E656769D915B9D458235501F8ED493111DE25A98
      53510BFA4F825CF2B038A24EF141DAA29FDC9BE31EBA37E767C9D730D2348943
      EB5D348DD9C4B7B6302DB00126284F363028B2A7A474B8649C5EFAF8AAF80DFC
      EF6CB138F37DEBA75424DF5AD71626F25D7F6BDD343280604CFD3D06B10653D2
      1DECA7A2297BA61F340CF887C53C64C87F55C07FD704FC9BC0CF7B9460FC2D30
      E9D01909AFE6B208D0CDE82AC80A416C1C5103A8CB9A009055C4DE531D93B811
      7549EA065AA939D47499882B74CFD4BE59C62D46283FDDC4ABBD822B37296250
      05FAE03E89A2864521062F7C0AEAFCF5571438A876C34B5112241D6D0DC72395
      BB91471116B72BC2C848D2EA90DFE1302850CE62B23FC5F970EC8BA6F0460C4D
      9C80A894252B34241550051F5FE04961C15961CE0BB2DE71C60EEC16DAB7B9D4
      176BB75B2192467035415B2668EBD1C5FCF6A18BF9D53E5452C071DF65D04D3C
      B53CC00156EE94C78DC2E22399E50637C9FC00B265A5DE1585AFCA941DD0FDE1
      EB0122C91707DDFCFAF663E737EBED0F2F3F50B8D1FB8FAF504122AFCB735C66
      352A5C0549B6F242EBE89738097D2A1A7164017D5F08F6276141E61810F9860D
      2B01462F8B50865D118AC83A1716FCBB12123F7620D82F9FDEBF9638F61C2158
      05BF5FF2A0A1F3787983CAAFAAAF631D9369BD893A0D4FAC93000FD1C9A975F4
      438CF203451796232A51A46410A6D634F46698DB002F240F98789660AD46CC97
      844805C892ADEE18498E0E9924C79E950680C1648D22BBBAF57300440BDE6E2D
      BC1BEB188E6F42F13C2071C20D20A18D432FBA7C8EC0AA02D55B4005C0823847
      1458F44FD181DAE71AFB791B20CF668489483294D2812E25D96405F2334183A3
      76C93D1C73262DFA6BC8EFC612B94AC7BA91527FF4227BCE80DB80CA273833F1
      C27AF9739979D3A231E12C67DD4683A84E69161EBC80249EFF3F06680296994A
      0ADB607A69A50C28810A2A42EB1F082D2ACA350610E58A85E7FBD23F542E9580
      D43B4F357F7443F2CBF79FAD3F59174F54F7602B94ECA1977BFEF9D37B58EFDB
      C75FEF349EAC5259E740634C6333169D41E90A9FB01B033DE424703D3ACE4820
      DAA7D69F28F9F9ECFE8D5A4F761EDEB69FA22A469E878DEC9CD2918394510676
      F95208F44113DA2027D329C9935592A0DE027F53B49C016F2BC6AB1C4280E823
      C3AF488DF781A0021D1A431B5876F58B6EC91CA7A341B6825447C970D84030DD
      39C446DEBD114EAA8513E4AA7050BEF716E3558211111F44B432528982CF1102
      E848B9B875149A0A9D2A83CDE05B0378A2E1E727197A8C2956476842C6BAA8B9
      0BCB3A7A094BB418F41C38683032F7750381DE05468A111493CB06543ECF6851
      094AC740B049FB23D0C82843A6AE321A1A9D512A645C856151260CE679459693
      D70928056812F3180B64159B0198E5C3736A51CD69198DADDE84A1581C21820B
      C6A02DD6B60BF1627C6763F9AF944B4213E4EA59383EBD3945A3268E593F56AA
      534EB842CE974DE2D7FFFA4D6D07C7E227165506C6DFA537D8E9C2BB405AC580
      5A32A607949AE82D97C0F9528AE5442D88E2FB6935511CFF43E8A76D53A5A1F1
      F93ACF92104472DA21042CD904BFE73A6A205AFC6F4C78FC1C3F177A744739B5
      00AF4A15A600AF27D07DA3B2E1566E948C8367AE2DB78CEFF53269073747A116
      BAB2321910EAC49FC43E1059DFCB9E0BE63F3C277EA3E2854BF0512C8B1388CA
      61C67E8BC38830DD548A94587C3B082B028AEB331088BD160B41681752A65E84
      460E56A82493811720AF47A18B2B098D7EFFCE5B881FE0BFD11FAD7C311FE550
      B4AAB148D5A826E2B9999CA60D93853DAED7886384AF3964A5CCA3022CFD78B2
      220FF36DE78704C6FCF491EFA6507F4E07FAAF61DC3412EB56924D4DBCEDDDE3
      6D3B26DED6449599A8B2A7892AEB1C7E54D9BF75871DEBCC3A7A1F4FBC300005
      7519AE664174644DB1E30A198D536B9CC497223AC01D6E1A65D1CC00B3594286
      02E164791C8E91624BC94446264C8204385F9A61E14C3492A7800C487DB162C9
      8A6B13C5531935F52C8337AA037A3C1F6BC47D43EA087ED805AC50A8EA1EB7C5
      A5A53AE6EC58C74749006244073E8632F3C97384DF660C470380CB308FF75E34
      5B6136436ECF92659BBC35EA3180572DA42BD12C95DA0DE05D6B9C7ADFB4C69E
      6B912BE8EAD956BBDA1DFAF2D3E7B7034B44A00991972B46299289966F295860
      5D5634774EBD30A4B0FC8540CB68902ED074AAEE624D30B318EF70DCE708A80A
      3025629A17715CA5989A8BF592177054931BB20C37A96C188909E6D324CFB2B8
      48250A49E724179D299C2DAAD080E47A29A862DA9C0AC57B54752A8E0496E605
      D8C96AE4CAAA8F5E50CE2D59637A399A2275B1EE7F2EA84598F2126013C449C0
      A486EB1386A1B7C488B36FB8CB1C59CF6F96D23B50A0EF92094883E071B058F2
      6FB553E23C191CCD17E9240998A98E616A6B95DEF52C19C3BF6111E733EB1331
      57B6F844AB30947A9BB75CEA7215204F8E75713EA3BE55A7C2A17F6B9559FD9E
      95AE960856A3C829D87C8715CAB9BA03D0F43C41124B36B430345DC7A1935287
      61B6540038AF0C80769D16A0EB542402ABC46BFEA2C712119735C969249A828A
      66D0E90AEB9FA0E107ABA18B06E4A8500F9DCB83D108F46EE4729B73C17B1005
      B83167F324CA2DCCC1D9CF442412AAD802C0F36F546CE332467720F92CBCE806
      59439E5AE8C985629933004186C6AEF8120B6B5C50FBD1D262F08D8BD564CEE9
      3A28A3C8E2FB347B95CC4A398393C44BE7A2F9825EC1D069308B82690062384C
      7441853AEAABC94C39C29AA37D52DEB384A2F2B18E6FA47A2E6C968DE03DC70E
      7EC1F446067A4537648A3A92DD878F38A12465C86DC48D1ACB75EDD64893F502
      218DF3B770760B9171253443E6D85EB58E09E92A00B589765F62B1DAEDBBFDA7
      B35B75EF6AB77AE858CC339C28B2924AF7362CFDA11CDC67D62F417DC3B5AFBF
      0AF3CCCB9D355155AF2A40550436B346ACC1A26A62329BC1401FCE6CC1924B89
      2FB3D3D94E47B5905AE874A4C685E925D652926FFB8E6A1FE6EFA38A49A5DA74
      F8C6945EC99AB07AE84BEC068F74341E3F9A82700DCBE2C0117882708A33EB1D
      A84BA8763DD5DA6F3D670FB5EE161EB2CD5A8ABA78E777DEA28949F73D769302
      F533175CB1363E4A64E4738C7CD5BBF09537B9C462A070E53D65951999A43E6E
      54070B1E9908E58DBCA9A37220E591AA67A9D5A552C254456F5A4A975807918F
      BA1739DD5555CCA540A91B948468C59AD1B10CF50F6F386B3677DB096EB461DC
      733BC49CDEA1BBE7A453CE2B845B1FD206D61B1E806B120D3E0EEA0B87ABDA38
      CFD2A02783B60D0D5400F9C03E072050019530D7B2EC2A52AE850038FAF15F64
      5D6E2069BE2C9B4BF592AE33EA0DE4075362DD99BA4A63A6540D6026E01B4543
      121D05FAC8EF6373F37495AD121315D720BA1A44A225BA1A759C22D769785DB0
      B8034CDF62DA3DC7F21A2C2F86C84C14FC280F2EF1A234F432B2052A77E3712A
      043B2D9A64D22605DB1AF799A712B77A7F7C1115634533D5E2F509D483FF982C
      BFBD86FFFDE7E3AB45D8E0674D9930F2BC171D4471D1CDD76A0619CAE0BD3703
      0542E5F1812273A89F60BDAB6C3A7892347BB434B3F1429F4376999D5A54E8BD
      12165B06A27B8385E376DD27C8136E6908C86E2A213A7B2813AC037C741664C0
      20D1CE84FE09ECB187D4C34EEBE0F4505042DA610FDB7633DAF165F9F586E957
      5740C9C8EFCC28537BBBE46EA18A4AC2B23C3C02871F1989A03AFD030025C325
      247DA2A47D6E03A2017A8C8E0BB8A478BCEA274DA028B469078D882589139401
      80C105D31B2505947604840EAE749A5A473F913C57FAF9DB23C537B5A7116DD1
      AADFC6C93E05FC136A07A22D1018E55FFBD84FEFB4B35595D63D45F3C68E8548
      A686460F4E98F158DEC13208C4007CB8F204C2CFAF93A592987F7B02F9471AF5
      2574D89EC4FDB4826920D0FB752908AEDFD61FCEFC0066D743A707FF3A83B60B
      7FDC7E67007FDABD5E07FE74BA031BFE743B43BCA5D771F0967EDBC55B066EA7
      C34FE32D70CAFB348C3D1CE24D8E33B4F12EC785FBF06FBBDFA1FB3ABD6EEF61
      4FFDA354DE29E2C2E6C9A97A46443338CEF3BFA0E8D4F4994B58F62C8EFED283
      FF199A5BD4C2D2A59830E273E94A92749ACAC24F2209DF739702E2271B92F0F1
      1A1F7B7C18207A3E856736C036A2A76C6BC202ECE456C53650D71E861CEEC5D5
      0A18A5E1C9EDBDA653A0BDA47850910C8BD5502FBF2DC02A9E4970A512DC1497
      377269036354B93FB621724594DCEA1E5E348ACA206534167148328A52AC0B53
      BF792D9FA5EAE9A4F6A5322CF0019AC0342963B0B9DAE3EB93FB16B44C4F973D
      E86B558E69DBE49836540E17D8470285739DDE63629537FD461425C5394DBAB2
      1C430900C7EDA9D22CE6067141A28DEC79C0EECB1F2EDE61F5242CA990092C3C
      82F1B5890734243951F74B8FBAAC0221FD53ACA653BBF18210B5F0964B54A0C7
      225BA3EF1E066B608EE3F771702CCF9466C371B0272823A01DA065FDA82A6CC9
      88FF1489359FADB9E7736BFA305804B8FAA2CAEC4D26B255F6A208325A871F60
      D56332F4E9E6DA0415BD284F56EBE476F7E5DFA4F59C92ABE41D8D05279E789E
      E79F62AEC70DA721ED7C617D0AC84CB065005BBF0B80088D2585B389CE076364
      D19999A197E26DB1CEF9522B3824AFF2930740F40F3D00E2EBAFBEE363AD8FF9
      190A4229D73F9331E564E920535184D4E1B4D0130A43813107E994BB6E638109
      BA27774747706F625D05DA5C4751FEA17793C7801D12CAD442ECE70F2F5F63AA
      07AC3E0BF804604A96841F698949E2DDE4278320DA80300BD9E30994293442C2
      21BBB8BC49820511B8D003E852259D1B82AADA2D22D4BACA4D8150A9238D464E
      AA3147A976B9B77FEDDD70C13BD915E0700F71D3209E42926A1187B721A54BA1
      3C81EB4AE5143F410569E25E54EAD6538812A47986EFB3DCFACF5BD1000D285E
      2D826C1C2549CB24D152DC1B0525D98F0CE364C80F215AD431EEE3380C40E488
      4E75EA53FB944EB1FA4A95DBC5CC4BD194529E07BC51843E26C72EC36012E0A1
      5D78C925B72E49319F29283635DB4E16E22914480775423FE5F81D8C616F929C
      5C7B07D09370E55322EA8DC2A142488675ACA0CAA622D5CAAF04E2FA73F870AA
      EFE19EC3938D1C6A5595802A358437DB07D6E834D6A60C43758B436071A57384
      D2BA96C13186C03A2631198B410083B4DE9D489D4539C4543850EDFB554FA3A7
      4820982CCFA466F6ED7FA8D53D41B810DB689F2444EAE9160DB82202929F9E60
      E14F1711B4190944E951324D378A9305D12996FBC7222F74B151AA31689E70BB
      297353CAD6D6F996DC05F824161C69E59E73D09649DCDD7C3D65666F9A3EF271
      D148C1EC593333EA594A6552C82B0EBC8FC5E7DC814140C82B15ED992ABD2DCA
      72761A42102E8EBD940B0591F94099B850E1223E5B3BFC8B14D3353325C2202B
      A287E5F77F3D3EBC57236029531D233BBE787372BA910852DA0FDE3894CE6611
      EEA7490FD9611D191CBA75444610808480E2C2016E61ED0AA69895F79C17B08C
      F31DB09FE30226FF1093E73C7F1F8B7B3D670C02CDF899AF602640A68A9EF302
      12212E79FEEDE7387F604761F0AC77E06FDED28B50943D7BB6D5F840B3588BD9
      F3DE06D43456B3156FC4735D048873CF9CA0A66BE13FEF1564ABE452AFA0F31C
      5790ACD2541F66E739AE009B01E624F5CFCF7109F35534F312BD0DCF52400525
      711C4C78012666BB6CB1B87863AC1477B5520C9F8995A281E7B3CCF0CC21A143
      A29CB29D928BB6DF3327E7AE27C7D91D847B5047C71C891D61F054DCBD9EF14E
      2E292670C52548F50149AD40BB51D813734C8CE8EDC78E0C83F8D8EFA91BD029
      4B0E9529E79A67D461595C4FC4325394AD75D2D44CCF4111EBEDC2662A52732B
      F8746795FB530BEBC9E67DA1F3B4DC147487209BCCD1CF94810C1B65C142D5F3
      D0319DB2A0904C1EA897E529BB60AFD49972490CF251715CC1A6EB3AE2A0D809
      1628E694574A67A0B016CA61D7E1ABE4089251AB8F9ECF94BB81000A4FE008CA
      5363312825A2C2E08F0E84AFBF6AE5598E4FE0CCE6F0DFD613952BF8FA2BF6AF
      FDDF37F2D03F212CB865211D12E9D6960D05E1FCE0510F05D7BED527C81729B6
      3AD4E772CF706E4A58CF62451355563A5C3992D038B28EE1E3119D772DB09CE0
      79CD69D39402858A0E719D6017AB860285C2BD4F17B2127EFB1F6AD68F1FB481
      753C7E99E3D67215F534436E51AC27C0BC02C83B93FAAD0E93E156EB98D322E3
      A1E0231001174BDAC1597DF850392F420FAF8B123C41B999FFC06088FF6C0551
      F0041B2449B25E7FA09BF55C8A1B3A027984A5CCFEB0D2AD7B283211C3A639B0
      632F57FF0E89603DE750D0202D220017F9E08C55E69D1887E985D6641E07138A
      AC78A214E1DD911594ACFF48318EA8217117745D9043C2B55E2EF7558D6619B8
      2AE59A0935616F2E7BED2B5A6D17172BE7F814D37B76E0080A11BB6374284097
      274E6D22BC05D701B18E6500D97E87FD9E43E89EEEB0633C592944B3314FBA5F
      7AF7D43CE984C80E47A08DC514B3EF581C3ACD918F6AD30041D93444447EA130
      152226361202541BC758D27C49B5AD5BD6391E1D7D54D410D93C8957B3F9EDE7
      07E81B925195339732EAC22B88DF6D422BA800186C58709F400361E729781393
      A072C1A10D2A57AA51788C44010533452FEA232E4E36D371F6D30977CF430514
      4A4A3A0BE33169C60555F118F7769904711264FC4385BC7352A0BA4F13F3FCA4
      B1CEF193C4FB62A437EDE893AE7D77EF8F7DC2BFEF59507D3EE1DFFF2C0521B7
      C3BF9F82614F964FB2E179B8385258EC80B9468B31B66407C6390E42209DA7D6
      0EA1FBC13BB628F2F024605952BBB024CF4ADA8F65215352ADB0CAE64B6CAB42
      1506643A1488D758A7FFA668D27C7CDDAACA36F578EAD52DD65B86D429A76D73
      D5DEB19607A74FC3BC9E3ACEFF618C9A0D16FE3AF16671348E9348214DED230F
      60F1DCEB546EF5B6B022E125BA9186AAFDCC652DA9AA25165D41EB5810619F57
      D953741C4B933AC9A35A4331D5121F9E3E713D5225B77FAB62AD9A1641E4C767
      A5A44A5D07E45B4E9DDCCA9DDC6FF01DAA49F90D4EFE8673D083C33098ECF90A
      4A1A4BB3DABB37DEDDEBDAB6631DFFF4F9EDD9E0C4B8851561F8057DA10762C4
      7C9405178C98D89F0B7B516B62A67BA4A340485580654A3B104343DF1EA11AAC
      6D7F6BDBBF6D7715FBD6FA557A1125C96B5D7CFEF4EE87EF2E7E9344A1298D31
      279E4FFC2109D78F73EC03EAA72EC8A383EDE75FE4B5B038AF39CEF2702F73C8
      1FF09093E85C7B1BC9D63A68A0E2B85BC7E45F51787562D8FCED875E2ADB680F
      7E0614E09E0B3DB3CB84023202220196AC9C23ABEDE4156C0CBB7F3C76DFD9CD
      EE0BFAB54817BF71172D16D8ACE3F34FE76DF7DB97C3B783F6ABB76F1BEB0F0D
      DE573B869ED09710A27B85C805F999414597E52C0DB12B183B521553405D9AE3
      B576469303348943347760FFE6B211E3D4AAAF500A7BB2F02E65A1AE17E8D69D
      7B58883401EAC1EDF8B00E9FF6FB93202AAB77EEAE14FAF1C2D437AF85FA6AE9
      7B689D6735A0F53DC009A1E9B7E0B22945DD9C0B5695A2764D29EA6688F86A35
      9B06D7C2742CADB02D2742FAD18234C522B3401C05B76E46B099849A9D0935BB
      F1FF80126ABEFEEADFBA83B6756621C1C0D0386A19C9250CF33A96F44DF5515A
      CF9B14D85B7811D73F4C014FFC03448E66A0E900687CA0651987CF705D6D1401
      28CC502C9618B18AC51EE304DB9AD20939A15E9C18EC98523BDED4CAD6B1F6CD
      F86C7EE4D2DD202F3CCB546A824D1760C38CC68F05369A011AB110D45E836368
      1771441DC9026E3E137A69C61D6228DE12AB92CBEAE46990ADBC62BFE867050C
      00450F4071296EC631D21B1D7645FD9A9378495B8E0B6A00D75403731D2797CF
      141C7D0087A617E338C4E08B284793E90A090356E10584899F297980650E9038
      A8FDE5641355857F29CBF6C50006ACE297D742FC27D8DE6171DD387558E13C4E
      827F60D24D883C04A486B1876516B18703C8F8A4158DE32C8B178B38CDB833CF
      F35CFDD086D57B61F6A7C92A49A9BFE095C092FA2A0B08A87D83631E17DB33A7
      00A870B5883025089DF0803763B41118FDE7EEFA8F63F41FA3FF18FDE789F41F
      F739E83F7D14F2D32C985CA20B2189D7251ECD817B48F023EF2A9891987A807B
      DD8073F5514AFDC40D08A6A1C7C58A71999378C95D1D29A11144334AA4F7136F
      46B95B914FDC7EF95CE5B43E8AA3AFBDCCDBB9EA7FA6B512360FB7D4326AF5B3
      4C40DEDE88DC4256B955AB9B8A409C0DB8A402A66EACB2297C459F1AF654369C
      B436215597A431DDEC36617311CC225490EA8B954432F352A429F9B589D52E3C
      1F9B2EB1D780B9F2663F9552CA3D5605C27CAEC58ACC118960920E6A279C6255
      1FDE8FA3E605000A9B0BAA9D6EC62E228C8CF431D03DC11AED2ADB4A5C538AFA
      A3BBE4B1640BD280164CE0899A2F53D22111998C79E8A303E16C1AF7ABDB2E3F
      6444429AA75A35C6AC97B2AC00B7A545F0B14351366F431DF3B4FED5CB5078A9
      50ED10C238A38E67D4D6408580730AAAACA08089195E3A17D2AC1944981913C2
      C477B52A32B4BFA11A8A0DA380631BBA9FEB52203F1CE5D03902AA3B5991DD24
      50FD7FD2B81C9C5BBA1DA0695A13DF833DC436F6906618FBD33B34002C8C4164
      B3F811F55367B916A30DF386EAE355D0404309291A4F4357F6C894629437C982
      2B8A079189BAC57A0747F4C411BC7CCC650E249D90413874E93898C491AAE681
      D94FA198A2AA9744D8EA58A542A1CF691D447EBC3E4549E52AF0E8BA9A14121B
      35F8C76589F535321ADD328E4ABD42C82DB1D1319C4F392BDD853EC3671BBFF0
      5D8486758610BF954B40C83A3BC5B97046040DCF8912A940AC22A3560452EA7B
      EA8E78ECA3DF37E1C273311AF8E1AAE0DC598E5D3BA1D15FC36DD6B1FA55DD2D
      1F2EDECC2FDC0782383FD9881AEDE497B8912897C4290922526E97323717FF8A
      97EA1786A35A26709779E0D7D7701091EAE327D149BE9FBAE572635C74828BCC
      0841CD76D0F2D6686841F58D1A51C7D1340CA89223E84F8921AA65A2AA842084
      1911840694B4A02C3050AD7442903F1E53B13442E60C8E2A8298C95D2AEF4C91
      EC91C0EF45A50A748A06D11652BDBA07220A787345DD4FED3956E37CC3CF9FF0
      78F8248ED400B6B3DA3B38165701A5540B4A5DCCABF26D907244EB3498453071
      5473358603CCB3955196EAB7E7BD9889C8DF451E8CD0B569164016487394C28C
      921A7E0E58D5D414444175BCCAB238929138593C9B8582CB0D506B77AA7B41B1
      D2EAFE2C8E434925E443A88C519835D90A1A10242AC8087C7A1C441CCD832F38
      573B4B2AE0311D61DE642602FA776CEE789C9308755363B9E11759F04F14F06A
      81608997223A653BFFA458546B0A1A2845890B78B33CDB0CCE449064762AA5C5
      6C42458EE9BEE3D27ABE29CEFE440D22DF2F8119A4EA4D8624D46EE2F730C5B3
      DABB5EFFF88E59A52113F9E92B0912E8E99A71F026815443ACA818C85AB9B270
      00B27F60C262D30F486204FD30A538474AA2E60EEAFF690158FF3F85F64AC490
      5536B15FAB252B8D070B001487C4E916E37438261ECBED63801F4D0D43276593
      5640DEB2F48DB3604E9B4FB00168F0DCC3D671DE86527DCC796C84566F2EDE1B
      2756B51D842319B535044F01420C4F9F3A1554FC672E30D9CB3A86E3B8462E22
      2BFFB4441A162A9833DB0D165A1C97F5A5E14095C76ECE14D513B3BC422B8BDD
      639D7547AABF671D91B07D64A5619CE5D23945B9C0AB83040B5E2EDEBD4E811F
      A27B9C1FC349BD7D737D7D8D4DC626A265BDB9F6E860622DA326D5197100ACA2
      89AD03E078C886EE0BE181F09053B362B5679A114614C696DB6D5B47B805477A
      6DC7B68DBFBC7DCDC245C71EF6F4CAF43D6FDFD8F2B6376FDFBE3D5180F0B2BC
      3E13466FEF65F3D1DB8E4E77A2565C649806B7300B3591FA8C9E07DABCE85759
      401457522CA38BB893A499E5D79BD56601FB79683F689F88C8FDF0F133EC6C22
      C280EAB6C8A6DA3EBAA516580FB030372FBA41FF6873CC2A54D0464316E5C651
      050E522BB9C226C5FEB3F30F39467E3468A6379AB0AB6A6C587E53556E47CB35
      BBA052198213591FC77F0390BE7B7D4A3CE4452ACB5D128C0804F2CC31084E81
      3FFD0FDA6085CE4D30129824191011361C2291B39B1DA769AF93280985AE8ECC
      298BA18211A60968BF61FAED13384CDFCD22400298EA53784D09970825BDFC20
      309DA1A38194090E4680735432BC462925D66C90D4A7A8FBF9632A567EDC1488
      0F0842044EE1689520CAA4A88956C750E7062B80A5AA4A580DE42525C7708B94
      1F9EEA82C92400FA311D7D22E7C5B3218F7091291831AD6E973E613547116166
      CDAB1BEBDC2385D5086CBBC153AC7A27050C6657138F1B0551F56CBE345E05A1
      F430D0AF92C7C5115696115C74628CB1127863BD9741F918CE3F9D6B671497EE
      C042AD58C76222CB7973927B63EE022B64BD8666C67C17A6C673869726827102
      1B0ACD13019A5F48D967141305E731B2BA2012297E5B145D6162899832206409
      ADCCBBC44FF9B32EB0776066FE7E6EB2624542B635D144F5566DEC13CDC0A2A6
      045CDEAB410C19019C1E3CC54FB21C3A8592118C9A07E7A4F54824A5F5B2419B
      672DDB3E59A3DF91AE8DFEC04A0F0C5EA91114E53D6E34C058E8C958370E34CB
      B03E81674D413402F96D9509D9C30089BD2AC74A4FE742BE27C5E604D30DE5BE
      4A3CCF97D0E0085154C697EC72F1D8286DA2C0A05BB0E17C0BEE163925B338E1
      483AD55707DE7C84F1BB0A7A44E0C4111F4BD037569EAAF7400301BF9B6F557A
      D3B14F806D5F307F55E8A14270A3C2144F2BBABD8639115C9E4274FB8BA5C2C6
      00E5FD2045AC4BEB9F43C2329184E92924350D332CC6F2F8D2DA5F30F4F48554
      118BE7044815E8542946FCD1F9465A4517951E5C092C58F58323D805CCE6293A
      39287011348AE0920C5B71A80479E1E31FC0F36F47BF23E919FDF11465F0FEC2
      644FB6C322975A0E212340D7C1EF038C149CA16844A6208D4BD43A415A02405C
      AA94018CAC5DE499CBA4C179A6FA56326E8C812D653BFC582D6CF92B52FE5948
      52F64191E00DECA25FE0562EC91588BB99E6C64CF6629001565763CFC3D7CE7F
      FC093D0B484FAEBC204416269558E4FAA94C5CF022D9A90F5EB65AF234D01A59
      B0179A63562D4617541CDC16A9FC50DD37739CAA8E53ED4D0C3FA95016D54852
      31B428ECE5A104E5A2F02415D3ABF448D226AE6D466A0C79FCB8CA99A769A494
      B2F31449ED4437A7A23E0E2637C38336ED87C676B37100C26D00E58A7C22D649
      9065E8E5CD75107242A493046337D8AFCCBEEE7A3D976A0AB2136B1150DA0CD5
      AED0C500E5C929D827B97B25F217DD6B66BF0E9617857AC5A734DAE737171D6C
      C0DD960DB87FF8B90883005BCE2601DA78689D74CA296AEE861851DAA2EE7430
      48F79B8B8B37B2877727AF5D28877912F3F8325C01D0D25676FDF8EDE072B858
      C7EC6CD5DE3AE5760A228A41477836906194419DEB4E179676A229A40436EE6A
      61EC9CAA02CE709C83DACD47D75C709634C9C67BB297F560AF46AE05743D95DA
      9D16D51EBFAEB148174F923E0800788AC5864FB1586D0A64FBB534A266D82D8A
      E39790F06A6FDF07F639A522932E29B6EA62CC4040D5728BB6EBBDEC7C25FAFA
      45D53C1E78839CD68114F568DFB5A8C75D51F9F75A58E556F64A94DEB294ED21
      B31C1A6AB812351E9F9BFF44CE89C684F25E29C719728B7B28D3D1B98FD9B45B
      CD4A747C9C82A01778A1F5FAFD39D2AAB92A782C69CF5991051E20AA751E06D5
      46BF3740363ED5FFF7E74F4F866F54A4FAE74FBC3FB21244C7FAF9D3A16061B7
      21169E533346D0D2CFC3D558391D1E00191F628DBD866B54C202066B15ADE04F
      BE807EC30544717456B5086318805BDE4D9539AA60A2CFA39CB05E6FAAC21B95
      A9110309847A4476856555308E28D881A21A64F227760448B3BC996920233B43
      342CDF14FB8CB1D0993FA6EF57AF41CFBE342753E38274F7F6CA7892E58A9CCB
      3039EA56AB636DF1FE3140E012445B6357ABC3901FC4BA9EAA7FE0ADCA8BF6FA
      C09DE399396825ED680B3C74707444B56E612FEF43AB70D9D4E1E9B8160C17F4
      12ACFEAB7E9387D8F3E90CF3914B4FADA349BCBC410DB0D56AD11138624B5EB0
      0842D819AC58C6696627B931B06002D476C1E6A9F4DAA1B44A65AC9434624B12
      E1350821C6A37D13AF38135D6C90055EDA3E7A29AAC48990056265712B34F77D
      E488F259A09563B25A629C4F1A473AE048A7CC4BB598A8E1C9A9668EA7791CE7
      F1B46C7F81BBC8302DDF4446CED29E725CB50C37FF3111D3E07A2F8D9B12110B
      71A932B806E8200009DD6BB009F591EF94C18CA1E8DC2F991C1C1BAE877AEFAF
      CE8CC8E6DA9020378B6392C8F7B1BB8AD5CE034835E3857F9FF22752884B7126
      2B623C955D0A36E9454631507331B9DC2382EE6D893AA83D6776A718A91CB39C
      A952C887A1DFC9D4BE79A4ACE3C216FDDAFAAD5861FFD7FFFAAD795AC37FC3D1
      253B948C9BAB8F90C668141526407DBD7D0EDEE18C8C8D25359EC7EB78853338
      0FB12C2980EE3C4BC23FBDC1428E0C150605457B968A8748C98382E94A818893
      304EF978300567507DFCEB1EF9B5405F35A13F3ADF24CEA7793F04D5EB805B34
      296A485E0E9EAE2F52DABD3C0E909D88417DDD03D49D817A7DA3E9D69517623D
      5EA24F9435B297E9AFC1AA28A041A0F7272DD6F64F75BB039349D8408AE0AA09
      B0792F2E340C9177E4955E30261969C3F9E74FEF69377C3E03133C032F8C3CA6
      832808CB65C19B2F84662E31D53746C3AAAF2DEBB52E6F1F5B532F4CF73862EC
      C0A14C7C8EFC2031E294A7B60050230F988BD0E7E62838D912F96326E14D2662
      99E5653898699FE25FEB3BE0894BF6951E63647B9ADD84E2841DA3F991C5F012
      5397A341015BCA6A45BEAB1C93ADD91CDB36984CE04D8732C3256F3DAEFC56B0
      E3C9CD9AC4F763718D886B49011A83D539F27F820170546347E543FA818FD295
      0E9397C3E749558D35192CEC116134957A19CA03C5E9C2A0419A9D165FA38285
      28C16E0FC9EE0DAF4F5563C3C9B38871AA0A0D682F3B0A69B7AECC9CCA6A9B6D
      49B58DA93717D03E227DA9399A3B743A091A34B9595338972BCE572A2401E9D2
      982C3D8631EAD2C14270D83DDE368B29B4088FB3150659866709AF1495EA25E8
      207B68BE301F6C8BC3E5EA3212CEB14FCE1C809D2ACE56DED5D3DC3612DDB08C
      CBCB49AD4245012E2DC805320055EAEB62647438B13AFC2CF11487B426E41B88
      E0F4A25AAD02FCE0CD1E55CED1936B9E3BA59FE1AD9069E8194E9BA14F9BA29A
      811DA361741D44580AF54477DE4DB958912C4A2C4D05F3C0C7C27DC76331F156
      52BB4933548F946D41023A456A1BAFA24CC76A511E94EE244BF6DC9316C61ACF
      19841ECD12F37A9A44DFEBD710198F62C22450D59658027B122C5129C27E67AA
      5A10A6E0B34CC28625B91ED24300343AA11EE52C69C3B952A9F548437186ABE5
      97EC00BE2942EE840B15AA6E4B44C673096A4BDA8E6238DB014AECD208CEB0DF
      E3A5A003C31B990BB2D20E832918143BA80022C7E115277D2DEB05D2AFBFCA26
      7359C69A52DF36C024D10206CB4F12078023FB417BD16299DDEC0A56555977CB
      6578C316C0A3B7648E2205169FD6D33F6A15045B59CF43973C5FC641949F5AF4
      2CE0A105DD1CC7A1927BC07C298C9D41840301417E914A0F869C2FC045E6BF69
      459FDEDF00259B9462C54DA0834380A7D861DF6773214539C2A12C4C9B96CFFB
      093BB6629CB90D3C5CCAC3BB1454CA8328A8F0D21BE92E01381003D908943B65
      FA23949118AD291E6F37653112A26C60120BFE53C4552C9A32432AC2A3D0FC73
      24C0F22188E074B8BD26598FB577DC6C62DF534932BB5BEDEC2DC9B8FDDD928C
      DBBF57BF4C4E902E363C0B46822999A628F8382F8A4796528A00569E8E5369F5
      AA04A88EDD972732BF4A4752B953A487510E45E6D7AD91F098A150443DFCE229
      47BD2A51642FDB7F3E095D73537A5BEA291B16E64B63322B2237F303599D455C
      2F552D8A20F203908550D72A9D7EE99109A8E0244A71CD67FDDFF2755349F00A
      7E061C99DCC640DE020C3E0F48DBD2CD20D514F6619D9C6F4C2E358E7F2C66A2
      29FB7250CC553274A75651A582D1DFBCE6FC6482E82741AC472389A13EA5DC77
      3C24D7195714AFF77CEE28A149E422960573B1F694843DE03597EFCE417F5AD4
      6540615B45DA6A8725AC54B251583CD232B3635D529BB69CD52C129803D2302C
      ACA8E499F3B0ED8BC7325D1CA41E2B31B3606C88A4D16B2F76C8853F901BDE14
      9CA40D447857872C95E29E7666E29DAA524D918C6FC0FB8ECECB2B68B55A47F9
      D95305430A74803A262003A221C82DF9A1904EBB43A752D56F654528F25EF24B
      372417784D2AF5229965A5FC6EC5D2E43AA20416D360DFEAD378966808CA0A6E
      059E0D5A26E2E6ED9BBEFE8AE364B0420AEE24A949611C53A91C9979A98B3573
      41BBCCC2664D99D5D6857794D9E258AADC7FB2DCDC0272D2DA26CA92E6CAFA92
      126A575B14D8BB7D9F4F0B6608EAC383FE7D2F940DCDF466370ACA5318A1AB31
      97F941A11A32E383C635420CC24E56D35564D696141A4A1C295689630B129665
      09C62B58A6B66528C84AF15615CCA7495162381D6B254BB2573D2FCB240796C9
      8363A1FB7A93D65F44DE96F5924C070D6054DFFC0E14DB20D13DE494B35C237E
      F9D4A84A3F4A6F5632F00622EBFBB01CF6D379AC9F1137DC00A06185458EB589
      5D5CC08B6C39012B87A513847C333F3B627F95E80736441503C5A81D698940BD
      8B5291642DADC0CA1B1BA5725E7141077294AFA3D2B048D280149F73C3F79F96
      D637EAF36B52ABCF3F9D6F4C8A2AEACA509CE24817F3609AFD89A7A9AA6B7B59
      215C587139E2B2641E9337636BF84828F069FB21BD3A98560DD3222B6C393408
      83893E9DABF9CA40B526DB3E6E600CD32B7D4DE3EEE3B02CC65FD3B2F210050D
      D3482EA210735D28A527897B7853AE5EC0210654C6BF00C394DF72CAC5C6D781
      741FE4302CA4207292E1DAA36EBAB2325373F7A847BD476958E6C579CD116A48
      6C5A87EFCA32EC1C7AEB701DD07446AD2B68879B54A34FA92C73A1407FAC0652
      A13012C37410AFA6B51C0873E58581E6DF878434F58C83E3BECFAC8F9BE299CA
      D690E7A4E4DF7B964BBD8857C944206E6CCAA2A5B536604C58B2887426EDE2CC
      7DA25AEFA2A2E532149BB1443AC1B8C95341522E209EDC0EB22C0264F1A28CA1
      86D9C905A8C96E32EC67B51900983183E30C394D11D3748ACE69F9A8611C4CF4
      7C4F1A17F2B6DE7FE41563EC8DDCF802EB54ECB101124ACAA45B06E44827F3AB
      5285425B08B36139D1350C152216E277E9414E75F8F68BF2AC37C0EEEE99F5EA
      EE5A3F68E0B52CD1E974BE9C27D2C34D9962105E55042DD13007C21BBFFEEA25
      D77138DBACAD50AE7AAC03C316185493A0490468D57D9CB87BDDFA7A9F5464BD
      C2B43C582FD25A346489C9AA9400B5D6C10214B54ECDA93C7E0AA4F4E846DED8
      24DA24CF74A15C402D37C8D329DB49787A4C755EC79B2F93E10E9523A91AC415
      037D9E17CD8EA98A27E1A174778B20A211B8C28C51A24B665F14FF95B0C33DDA
      48A1250B9934FF2CB85BBBD2ABA8CF0A6987E39B7A4CA1606F0E41E1B1B4C0B0
      88577B8470BF9228558E231A73B427D6D6CE34EACC022CCBE25126CC26ED57B6
      3E32C76164081F08749B8AC4A841BB287EF7D0D5A0AFBFFAB1E40CF8419A7E65
      D91E6D06D166088EC41299F4172CC4A64D488722147E93831C63D9F394C286EB
      63773022EFE4594A6FD28A7E5E8A0B8C998E4A314B02045D5098B24491180430
      65E80E83E538A6CEAFDAB44F82DF98E3558B1D9C7EA05A767EF0A8BD8D0F9C3C
      B3357F52B6C46F9BD42985EE7497B34299DB0B79895B0E8B2AAB6893539777BA
      0E5414690B069FB11B72CADE97821C5E7062ECD9FA8020A1A2500AA714BD879B
      F113471BFE1CB48896D21071C76794DEABFC14915863D41ED9F8F4E064282B37
      52A0F4EE72D2A9715E5467A69471C138F22B2143A770DAA07BCB96BD85E82D59
      7495557A2C9B2315FA5BE8B7ED1310904A9909FDBCB22E8872707A140D9C9BCA
      F5919149B77BC51D70CD002EBBCC6545D349128C73153F8E10F93139AFB9ABE6
      23C62A6F4159265E48C56527FCF89E20D506D075835D29B432DC27DF5F866B90
      796CF75C6583AAB1E0AC10F4E854391888D4E9FC26815563D35293BB0D5392A1
      5BD5DE129973622290B61971CA094A5E9A878E2025C829007A05318ECE3AA2B4
      9A8A989E8DCE38E57892695518CF3E5554641F23EE1F5E1D992C4D917896D272
      1583DC0CAB645422189BF2974721B03A7B9F3397EA158359392DC09CCAFA6A14
      E8CD35C7F2CEC792BDE205D47BD493598ADBC80FA3E2BA3AF62A5225CA721D63
      97C4C1367B5F34C9347CC214DF6774CCA89AAA0AEB3027EC4B4E1817A4A5A810
      38454F76D08A818D5BDC70D35050671A286631C2BDA241951CEC0418C51C1C93
      E89256C50848F8694F1300CF6B1705D1F0D46B2964DDA8D5544C021758A42EF5
      91BF7B4E7B328F637A311B494AF940DC5B915DBF6A7E147BA48D176496A87D13
      6A07AA2853312DDF9435A8DF24983BD65D5A2C11492EE45E1F19EAB7BBDC4F05
      B83898905A5F9DE509042176D8A20EADBF5EFFA6626D5E6C04D6954BFB745BD6
      B98C0CE4541D9F7312321A90B46072D85BE90203C4131EDEDDAFDE56F53C49D4
      5F8AFA10E9AFBF0AA6014C2E8FA5DB685EBB330182331EB68057640C15E6CA53
      9D775F5254D44BC9F98980C2BF72065732DA7F4FD870FD5919B55E84092F380C
      160113D43C5674C792A86759D6A4E73DF91EB555F62AF076B0C45B401A069742
      BA9C0DB5AB05F627DDAC88AB9BFEAABAD5FD960BDB395A192A58D25DB83ADF2E
      38E527F85827C4DE26DC9532644E76F492DAC7DA412535E235D768183768D786
      E154C267928DBD8DB74F2F483AA265BDC30965AB2422073BF729470B6AAA3B54
      69CB082CC04FBCD94C1128A6D1BAE1934CB9B126985E292D2A14F74C57D25240
      5702EF29513025FDB2584B0518A8B4635E157199C400F045C13EAEF6638F9467
      E472BCC3BA83E33E6EB05DD8B019434E7094BAADEC1949452C6EC12BAA0B5428
      21A7C229B1891E111F5DEC52A19B146D556238FA5B8BED2949D655A58B0DC56C
      403195F021FFA6C88EA8D28AA18E0A485C4649C5E4206C546BF2C7EF83CCB509
      60AF6A6FC5CDBCFFFE3CF5020F9681A18EDAD986B44753E7567E12D71AD3AFEF
      65B94DCEF0A1F08D97A1CCF1D1658164B52B16B6D018A0F2D3530AD20AA6A577
      173CF634B1E63C29421B0151772F95DA6DB1E2108FAECAFD713B04AC31C21950
      AAAA92BED14BE40424E708D0E8C7A7A5BE301605F71A3257CFFFA85432D73291
      C11686BCE56C1ED3FF26F162C1B90A11D9C64058A1D2DF791D31992836F72497
      CF6BC3C8F015CC9C28D5DFA243705C28162E6F0CA81E8D582C6358FC4D5E4373
      EDB17B7215816E25CF33C6AC63716D9F2B547114966C417722D3FFB09C9B92CD
      308D03F32305A87A20EC78CB2575FF68008782F1EBF1E93A61E86B02E80540FC
      D1FB2F7DFD155BE528E0C823877B7416AB765AC7FAD35FB8372B67D09F5AFABA
      1F4ED253EBFC3C3D29C564630B270EB6DDDC10B86344B8F6E8B0FEFAAB4D687F
      EB61CFABD33176693C9DC0BFCBC7EF7F95435F57A32B0523368027C78C5386F0
      C2C3BEEE9370850507D51EE5165EC3319A464A00A92AE969866D68AF75B188F8
      2E9596746AAA46EE6582431082E86C197A138E878DB96FEF3BAC908A3D5024BE
      A632D3EEE4D47A0BE721934D9A29AD2310A19F9E36C8E18027B01203BF357F19
      D7FCA2F2D1D91CB757EC536AFDA260A3DCB5129E1E6B062166FF597E028A2C65
      BCE3A9A4FA93CB98EADBC27194A959C782CC8F2422F3CA8B2D77E6AB19D6243E
      D65A3B657A70254B6F16051940EC040D987EA164A939D7D5E79AABAEAB181704
      B839D24533E00E0059C7F53555A8EC098A63BBC842B9480D191812960FF1C09C
      48428175CE538BBBB080AC177069069211C689F02E6541322EDA9C723EC45B36
      2C790010F53234479A8350AF1261155E596FD19C80DC508A0417E929ABEBA8A9
      A872C5AA8436C3AC68FD9CCC03B14FD0FF11037FA3BAEFB9AA5FFD1ED49D0602
      7B921E156DEBDC1C09FD97B78E9E729F37AECEED978B5EFF3AC9D46D3887F437
      F5B4FCF19D8FAC6BE2859FE30FA400FC0230574F9C5AF9D378BDF89D47DB2B94
      AA5D5E078598909321C8D0165E34422B0595E2C27D659B530334517DF43BAC63
      6DA5E6606514C64F0A36EF960C20675F41C9459015AB7AEB074E2DD9A1821467
      92ED375E410DB154119652E553996B2AD5DD8C4BD3B24509B13228977DC31069
      DED6E213409E40B517BADC4514FBA5787180DCBD946A0628EE5C048B6F9C9686
      4D4FB4C22E67420858080C5F0B40E51799D25EF274F8B29720AFD3AE6EE072DE
      122054BA36F172E3A33ED105D02C93189B84B42CD19AB5D89858A84D2E6FA2D0
      D750781115EDE74CB0184B77E3A368BD40AF3D3ED524B7B83ED4054130D52717
      53D2643F118943825C1C1B75D3687E7BD01F72857B059C92D8745AE588C67B8E
      A6585B200CFE812EB4638F33D035FDE1BDF36E4E5465729851AA8D4572AF1587
      D6A8A12AF2C5184F0514243FCBBADE1A2F1ADB4614B6AE91550B4B0AE52B5309
      5179D3497566E04D13B2BE025F5A4DB25582D5CF65F3826372C0CB4AF3E8432B
      54BCF3A40D2A2FC627019A8805F08974F38C7A8C3954847515A1149FC531C94C
      54F17995225391BE7EEB73DEA700D3E456291512F42CD05A741F4D194DAAF3D5
      CB1BD7A45A4EED1D0429714DF99CACFA50F14532D815F1877A4EED877F474509
      848ED9B93C664738A4B8C61C7FDCB9420DDB2354C12CE63DB4A3EF05480447BC
      BB47FF678532E74591DBB1B397496CC919A1E26FF6E24947AF6EAC575E2A3E11
      121CC98286647019C7D70AA3A4AF5AA51315A24DEA8F3F1789A43E46ECEEC602
      DE7A88E3BF58A47472DABF75FEE6FD7B441F6CDC3145B23951B736EFC82849C1
      C64AF23A92A7D69F4EAD3306F0BF5B97E226DD6CA7211D2EB0371CCCFC320C8F
      4EF5B71F805CA9FD79175DA144AF231B8FF6EBB8C475B97392A3D9A8242B52E0
      F928EB21FB4D9A3470A284A20DAA9472810C4931896B35A832C9328412668347
      52A6B17AC52A9A1A15748E2AE512D38D327729157A74F5DE8D2452721BE5491A
      CB929FCAA836B738B5412297412A9C7D07D0353ACEEEF8697D9C545A6045D7A6
      7A66C2099AA940F15C3981C782844F7426A8377AE13EE13F92D5E9BA4618F3B1
      0A429FB8F6D626EB0644E8A4D00D9ED830418BDA236246D5134BB972B24F017C
      47FAB547E450566DE0802CDFA03F443BA3813B023CE7EC2DD1813B2A7CA5D891
      85C5E3A2691FEF6C40BB705A310B4F1C6D042837B9042E890C1901A34D8D21C7
      DFC04ECC29FC0868198A3C725A5EB66FF3A18FCC69766D804627DA250A09C294
      D3C2F61518BE1EE29B55940FA7B85D0E8C558ABD26B6F5C1BDE3A0CEE3845CC0
      3311C918218E6D8557D73EBBB554D90B34A54342A90453B45565ABA850635B62
      11500CECBFCBCDB2B88435B7D2F22C6C3687870EB4915942EA0846BDE95C58FC
      9963C060022812A47C322F2EDE1856D0D88D73246546ECEE9E1E515C20357AFF
      9E4A7B9B48D072C1198E3BCCBBBBA1B794853D206AE88EA096F0459016643005
      D496F54A368E538DBA48338A2902E0C3CB8BCF409EC7FAB0EB5882825A26A3CF
      695C728CBCC05383DD338B05B150093B958A09894F21061B506C2056C9895789
      CEC15B45A0CAB0CC788CA790E80A2A0382553FAC28D600460D92604117C3B63D
      27745497225EAAFC7B3FD63D483D78AF582A5510E653201B44A3D18E84C79F03
      8A288587B29BD8D9DB94E63133CF05D21B155FA4154CB432C8D818A5F702F88A
      DBAB6AE333F5942D06615BB1B800DF1670C68FACA179F4127EE301D25B1A1E34
      C0C69A9CB15DF32224139B53A38258E92A37A789422741A9ABA5040AAD4CE9BA
      F66AA0C8FAFB0A50457554D7AB25C5B5C17A6131CDF5CDB81465A3DB45AA6236
      C5C3E7CDEAB957109D4A54A05A624A3779C868C6C251BA3DEE8517436BC1193E
      7EF04510E5CDF960CF1B010256779F0140EFFE0A5BF20B9088778BD7316CF413
      4400B5AC1F31FD53B0FD82B11B48960E0693CD09858CE624E9C7577D1E226AF3
      A04D177E6C5D228EAD7104FA25C18294B03023B5D4EB3D0BEC364B7ED854525A
      B23EA771C2BD63C98323AD65923A998CE6827B2DE73EA4272022023AA7AA22D6
      769A304AF5CDDD7717B00F39B9DFE9832BDE621D13FFC10AF9DB0AE0C991E64E
      DCF04F310F4A55C34D6EDE25679311ED9C59E91E34297E92FC92CCD264D5933F
      F2D46ADF7A3F73C7A2B6A1D52E38F6A4354CE67700DB02F84D73D32FD227BA46
      F98D1C0E47F2809421A9D54ECEE26132573ABA417A262221A4C76A9C8B5C48FA
      28711984443468706273416EE320EDAB8094524E059286BC137935C4B83C6A21
      4EED1C7DCA2D3474AFDEAEA06AF5B39DBFA04C50FC97C9D8DBCAE8AA80934A68
      DEC845DECB29401A95F6EDB06BF0CDC58753F8E73D73A0F7F1C4237FA02CB54B
      69B364ECE668B85094FD7EB7147D3087A272337E24D3E22731B57EFDF1FD7F7F
      FAD6A6FF399DDF90B828076ADEFC60F43B9A1C477FB4C4B530C7250762BD8624
      A17C2C1B3D28389F281BB4B703DA64AA2D405C97D22D243D70C046A1E18D6C5E
      0B740E56E24F625FD5E92FF0A0E61EBC7223F0A2A5354B3CD96FED9352697DEB
      D5CD96C19C4E7AD9046CCE63752E9ADAB396EFA9FA91526030E7ADE82D877351
      7FE8E8E0EC0269EE8355D218C584724A43A98C83F4DE06CC7222F2FCE44F53D0
      9111C01AB6A895A9DAE7BABE751CED62DB06D135C4B89478750D0FD95E8800AB
      6C8111A702B02112CB57715716754D0736C858BDB899475017256F592A431666
      567EFD34467B1BF2236638F28D6DD8459E833924B570FEF56791DCFC66ED8836
      3236980639F36534D4C645DDA8EFF1732FFF8E3B898ACB44EDE353A45F9EC920
      A342557C5DB32ECECB309F6E04B2E9844DAA818C8F58B3BC7DFB1786A24FF260
      718A3493F2EAA9B4BF9C92ABE529ACE498B97528DBA5E2BE290093835FB6B786
      6D8EBAB9705AA835853EFF703583D9B4B2EB4CC780142B6195BA7B14C2CB8E65
      3C7030B5CE3F7F7A8F1ACA5C847EB920C28921E575FBC834FCD797F59D02B3F8
      378E4F3524FED99278F2983C2569CF6BF20149853FA1D0BD0D0AA71DE9B6F6AE
      49E70ED9D63403D8959BB05D5D4F869FEBCC8FAD56C551782323737F8AB85331
      7D7BCDA1D14D56A6ED0A32ABE848FA128E74A6501E497094D77DC2C5A8F8EEAA
      E9B59E0A4B1088B763CA0316CFD9C95528C68039F4A9F5D3EB4FA7CA65F3EEF3
      872380DBDF5714FA4D469C255B99DA9431916E0A0BB2FE868E8060B4C4F0374C
      ABE28838468969C0AE90A3574DECF61717DFBCFFF8F1B38EE0870962E0652990
      BFB1418B8932BBA9387ABF5C34729544A83E4DADA30BD4EDD1BA25F10AFD6C22
      D2411E94838DB10EBA8AA5B68E01E454E99D493C8BD0887DC2E9A50274B3A377
      167AE32D74C75BEF5E2C2CF2C8CB5C027C898A9C51D9E5200F25B8EE13A33ED5
      D70D48BCD98BE8C56B4C8D872D59CF636D516D14A861CA315495A5DAAAC0A0C2
      6F3723A82BAD11C5CDA048B162D5C3397B988E8B022A3B7980649DA84AD3CA94
      1151FA1A05269B4351BB7B3F7857D602E3C58342E887416E059EB720237C7E73
      D1FDE6E2E20D9703F9D839C578778F8428E1CF54FB28FC8835032E99BC477103
      29665D8CF0076E0A528B6A2F9408AAC8A96C70C49CF56B255F2996F7C414648A
      DB8CE4869E62B591488E97CF0E2B175338B92FAEF39856BC67419DA282290956
      59CB3AFEA4C2CCB7D81D9B05901F620ED174DA3AC162FEF89EF3BF92EB974EAD
      370E28383D9DAFA6A02EA3F099C42B95F194F84D1205932652AEA4211B153B37
      962CE1B1965DB2618B30E117E3343874AC18815A7A3C5531BE9C490C3C7B0A02
      0185C80711668B72306654E0F63FBCFCF903737A8AF6C8F5151F445D4C589FA1
      4F8E62D9FCD54457CF5769F820474CB1C20B8C24136C5100681E78BB1B69EBCD
      B854AF364839370133E6828904A744BC54D1744C0EF495ED19EF04649AC4B0A7
      20BC65DC365839210B7730801A2FE3D3760643EE5D91E48AA300298819481587
      04943271E86CAA33B147F0F2EE0C2036BA53851158FCE7F2792450D1D61F8F81
      FDE4A1D4D9E67D7042281917FE16C84601D04C584EF0957F5B2D967990BACE71
      97F7A1DFBDFE84A8E0E1530B892DD7F626C0C8B23F864FD6FBF13149C6C3F4FF
      55467595A4F9813639592D8D13763B8C4728AB211E49A901EAF21F812427B2C3
      083E81E516F32C5782F769E1222631F0785C7C31EF3BF2EB7FFDA653FC41B827
      B860707E4416639580A0B78AA9AD1C573726A1F735384CA75629C4423644A633
      85037DFC2BAACED9668263BA779584883B0EC2304B2A28E6AFA874912A7919A9
      296B943CBD655D08E902AA1697208B63A0441E442B1327DD28D057D576CF628C
      F335277FA39E7F113879702E1E4238FE3E9EFC426DC9DA41E7D6F7204CBD4955
      8494E4EAD4B3E8DD6BF8718649A89FE73ABA186B79A1287802E72FCBF61039DE
      15F29512D085741A58E851F663487A280992DE2401C1C04A910C151A929B4373
      CBA1A148346C2D9779D692C2D229D5D61CA17280ED51014264C9D49D7465BA18
      330059ACB550E643C6892B1E0BC8BFA61239EB38CFA9048A5F5F0E84CD27CA20
      DE3C929EA466D0B44089A4E05DB4F3F31CF1FDA4D11C7D1058A0928A4B48FB7C
      0BCB6C60AA0E47B96FCEB6E89E0076061A13A7306A18C986A379DAF68E77A89A
      4B5CA239D1B6A52232EA82171C1B2327A13869B12930977C82079AD45EC2875D
      98FBCEF1F6002E1D1FF6E11467CD79DAC0C583D04B38175276BF2852E1966C9B
      56AC2402E4AC38290D682E2DA0F6EED6639B13772FBD4C65E58648806ABDB95C
      B252147692A396163A12288B9BC0126B4EC978D6C27CF6A6EF842F943EE2B14D
      52657A9666AEF1C1F7E04D4CFD4F0B68967BD4B9E535ACAA0588416A9DEE147E
      FC17EB0DB18D0B6018D894E527D99CCE8B0A77D1E1059DBDF39D985C62B861C6
      88EEAB669C6AA9C0D4F60BD085E50552DE2EAC9DA23A9A94A9C110E1C28A6913
      45368F299E781BC7288B95D4765D8B5DB51C0F2B4E00C10DF3AE0319FA8FF905
      EA4ED5B04FAE42224E4471FF330E6A6607A25F7AB9CABB0EB437F0786311890A
      8B00C9429A65908DE734135172DD0025EBA158907578319C27ECE77D7CBE0495
      697329B728DD2264241EEDC320E6DB64F70B4814DB4CF0758B05D743A4576E91
      D9545619C2DD94B6312EB42FE390149DDBA36ACA7B6DD29038595F354689A745
      D1AEB04324FB612AD66DD25E838225220726BC27C0D6039917659C1648547703
      365C0E501D0E2E6457E2C7FC282678B1B0ABF54C19AFDCBCAC3456A901AEAC59
      2FC8D32F6957E0C32B76C77A16C133FB11A7F7F2558BEF99C17155D1D178577D
      AD4B78C51A974D755866E828C590230C232A0ECF29E258E36BCFA5481E550666
      11BD91FC10A1291017EEC1FA528A0FC0D3319444622475A4005EF9ADBCE5358E
      CBB33C95E02903667FC3A2F0D200AB5216EC8B33E43749BC9ACD4B27172863E1
      FDD6F1BA01E5A6E4415D5EE01662502A372689B5DADB0D48294FB5A0868867E3
      9B335D0C83C83BD715E706BD2F4F75D2EBE675C5FEF3EB1B38F60BDAE7A9A787
      8C164614DF245A1A594B5B431C041E6A40B9EB63AF84B2F2913B122DDE382922
      DBC5FD40C3F017E1C2EDA21555E4C35CD262CDBB5542A6216C1581411758942F
      6141453110FCE558F62B8133463B24717A93BC9EC81CD362613D2A44B054444B
      9795C561F7E34D18819117985F35AA2C3C5D85880ED8DF88086192978F25AE5D
      9A8E74E390FC01CC4B751A2E81469A0AB45BAB90E59BA902014ADC4530BCC8B8
      FC403C13E440C6AC25423C253C6C8C4E90D7704FD9775704A7E47FECBFA35AA2
      72E83C602D5FD4BD54CE847DB28E3F78BA50025B0569D3A59C2FB989E438D302
      1C75606B9176A6A2003F2984E669CCD21928FD957ECB047FD6EE90521200DB31
      344AD78A2B54D9C95503631829814D55A0D540F3D20D80150A16A12902CE00B0
      03C1A2071ED2A6444CBDAEDE5AB239012DF5520D3E81C4034B908814C98B8EFB
      3A95C4576750A6AB809DF32A893965AF4249FBB30A159871384DBC749C7EAEB6
      E2EB8D5DB276FB5E91BB861CFFD84DC2FA5E84CB53EB0771BD4A41C6001CFA2E
      C8BE5F8D4F313E1585A7536435C0EA13814E186F264CBCCC162CB79AB7C53BBD
      735A37C27AC5EB20F2E3B5DA0615B2FDFB088B0363192B82EE882A424B105B9B
      EBDB5859E3005D9A3F2CA6BC2A5AECB46D8D5E8CFB23389A7FECD8E06970D6EE
      E12EF4DD3D761AD6F6B709AD0B503DBBC6671BEC7D983ABD9D0880CF3F0E0AD4
      2729C3E1B1CE40EFA5F62973FC86E4AC5403F590B6B43E404ED10158157AB7F2
      EF78F4F3C5815A433B234D76587E8A549899B47B4A21BC899113AD76BA0C67B2
      8AC8DEEFA5CF127C5F7FC5D413A0475A1D49DC28204F03A90586183194019703
      AE112FA9055041ED54B0CD2366128AF00620A58516A4CF0C269293489462ED4C
      5D4B4572859AC727E18567A4324CA8C501D9F44870E7FBB96C3F2AC012745874
      CA7A83896A180E1B10C4B008F2B38491E2AF67D69B7041D10A0DC09ABCFCE945
      5A62CD05E263FD3756E4948223972A069565955159D13495BDD1F240FE389AC5
      D42B6A8505354BF8A9F0D20857B59BC2DE0E59E61F3685A98111987614492D67
      9BA8EA63AA45C24ED7DA063C1B7A84D83CA1C377734BC4D16B2A3696BFB07640
      49DCD95EA8AA3FEDD55D4199ADE9445E7941C8C1BA9E35C62AA41846858D4794
      619EA3C5A8722DCD58BE5F465CA90EF2E65C36A6AF89580404CD22B8CDF1CC83
      314A68A8E315B1CD00CC39245D061151C19331719F13804F4BFCA596D301756C
      97564F7AABF48EE963FAEBF56F8DA20E222BAFBF9CE5A7C79B513339A227D451
      67BF5634989646E688044F5C82050AE344177EDBE8D122BBDDE46B090A911ECB
      10C39CC9E4ACC087E3A9586718989C10703917BAD1DC2A928517B174BC397EE3
      A5C882B32AFF42C905C8F0992417F87DAB41C83D0B094CCAD24204C095ECD016
      A494A4942F4E808EAB43E8897A5030A6144FB46B1834078AD7409FEA2A0AB21B
      43DB1A1413A24C30582A1C1854BD8C81A67484B7E1631DB3778DCED255E0952A
      87EB3C8F6286DF49C1C4835EB139C0640F7F2D965CE569A4AA263DF0A160B15A
      C869D53B94A7F06028638B64FE877CB654E94276656A3E332583E8E6489CCEB5
      3606A95D06A9FEA11BA4BEFEEA4261C719A1DD44A29D2AA21FB0E2D70487CA27
      47B23A6DF6D1ED26C9D9CE3DC3289843B69E201F6DEE49634FFC0122550390BE
      0DA8DD9AB45F644116EAFCDBE36261B193BCFA7519BE2A2C7421A35901BFB890
      0065413263079C1A53A1066F81ADA0BC7CEF54F7057A611AFC43ECA841A17645
      26404AE332C527E113CF12F008F6CF489619EE8C86D284AED07A37241A700659
      E9701A70E34C22FFB9195237CC04804F800744A53DA09930A5D46141A549707D
      208A802C64983C2BE033D65F2C3046E80C033EC698EC28CD947A6728DD924F47
      6BDF4DDA7B079A4464ABE8DA0C7BBAA8B914CE12757815B25C14B00041DA7661
      CE794E3FA9149B8F2E559FD46A1A8068B14C6292AF63AEEE91CE93557469A5B1
      A53BB5AA4171F9852E3BB74DA91E079BE07DBDA85187C74616AFF607E13E4671
      9EDC8C07442C961970C8786D04F3B26E5D03AD4D2D5B44D44AF61BD553B610A9
      5D16E0A7DB02FC9ED98894CE6144E05D22F0E0F04560E0020B6EE8EE456487C8
      7B4C729170C020EA248945BE30BF05904D25D9A91AA3F52627940841CCCB5614
      D8FC4A44C12CD28FA36907BBB92544A1E781EF8BE899CA01EFA62CE2EB5A6A95
      D0B48E39C687FBC3CDF1742BF09E9C160E36C1849F65C8A804DDE70B21951A72
      A19B25E71D1DAA506C03833EC0B90BB0F008D6225354B1F6ED35B866787575B2
      C252F521F305A02F8B5154B299CA4997441F1DA76E8A74D7364B914CFBE87519
      AA3FD7A3B202FBAEF2DE796D5655B9667C83AE016B918AC9D1660716EBB5ECBD
      C854A66BEF17CC2DEBCEB196F033BE9E2CD453F256505D02F2245099DE1D48C2
      C97EDB6B3816AD590BE73D8F439D96082A4F0A0778B564EFC23AC2EEEF27DC3F
      1200A87BF3B2DB10E8440382944F5B85936BFB8EB78857ECD3C7608BE6C93322
      9351F478606CE5896008E51D40293E232E94C429B783242804BA8F034D0FC386
      74261BC39252A90894868C352463D4B7394409C4C37FC9A20B63C10114B21597
      C939AFA053356023D2523BE40EDAC3B5B59255F34356D03D4EAD5594CA906F9C
      4F2A8907C80EDC3FF3FFB5F7AECD6D2349BAF07747E83FE0284EBC96666499C4
      8DA4672F214B72B74ECB9795D4DDB36F77C7890250903022090E004A56EFCE7F
      3F4F66550120458AA0ACB6851D7AA66D89C4A52A2B2B6F95F964BE5B6609F0D0
      D73A8DC0F59CD9C3E9E585E977F8BF1A3F2057E5BC8270D2F64A446DAEEE9868
      6C53B3A3D9E6B1F9D0244BE8EC6598A674E2AB1164920AAC78395F56BC577C1E
      747DFCDDED3B36FEB17B6E1FFF38BEEFE21FD7EB77F08FE70EE812DFEDD2253D
      C7A64BFAB6EBAABBE91230788F1FD3190CE8A26E77D0A1ABBA36AEA37F9D9ECB
      D7B9BEE7FFB10C8FD9FFF188BB0796F596FE3FBFC0CBAEC7C58770709A5E7EB8
      112D666B2813BFDC606633D73B43D306D8B0FF5765FF35F89EFEDFF472F5A7F9
      36B1363B6516B651A9360EB527998295D831C8665584DDFA576B36C2CE5B89CF
      D1BF3A76F98E52CABBDF02B43CFD0688FE3BDAB8583EE17B5D489E6EC2AA9846
      1F692AB38C52D29459C4B8973386CFC64978E028B56C64C07EE1C52676710FBA
      A272F60B11ECA9C600F8AC09B446FDCC30935523CB40E8C267DD48225D333BE7
      84BA3DD71113F473823BEB83C6E0794D4B4AA8016BA535EAE754F91BD7524E4C
      1F343AA2D4500A1A1F8A2ED6EEBA423198295151D29BC29F1432110A74875B17
      E93AB82C4D9BA72A5E181252ECBE0CD1F1F8385C72950CA36C7579047C10A21A
      DC9A5C4130A8F1BDCCCB8F2906A266CC3DC36B50EBEB60E85DA43A2005EA84D3
      BC4A5BBD9677AAB5DF34DF9C242D3C491A3CF79324EAECF78114CDBF33EB9B5D
      A7378FE4FAB667B8B2ABE7550CFFFC9399120B8FD939B56F46C763DD568DF0A3
      DF942BF5EADF8C88C44FE55CF1F34F0B9A5BB46AC2872A6A7C94DE8EDF5070BA
      415078549265C9C213FD16116663572D57D006973D245DA8340063BE6A28B819
      723670F5FF59AC2D85CEF89E2CAC1F27AF898BAD1DCADDD8B55E6BD479C5DFE5
      97469BEE2A1DAD552DE75165BAC6202F607194EA5761CEE9286EF3D0288FEB20
      8AAAE19C8C7399150F8C20A0D20E11561D0294DB625EBDB80AAD568666E2D0EF
      F8916379CB0972FC8895E3D5416AC36ADBD64E34177C6E0EDEA6E61E51BFA055
      33A48B26F7C9BB1114AB8A34722A92A190202504584311C8617E4F4E6CC444DD
      55A9116AA742AB35A1A0A4EEB6CDB48256539BEDDD617227150C58996B6A7AB8
      80E557C3A835F7DE16E08265C4B8040C48B05FB59CDAF9B0F1B8DC5BB91E6D71
      37D1D8A1A4C1553D555ED6AA9826D3794AEA9DCBE6377BB3F1DE54FE1B35E54D
      A759A8AAE8B99D7D9814DC2B80D1580D96A0EE4CB0FDCB117CD2DF542F773090
      39E17A4D678B044AB4C1F9BE77B6A9ABBC15AAB3266003CBB5A4F1CE0C91D582
      EC96C426209DACC27D9B47C7A593CEB22051C73754C18B60A41E5595C84D9DF5
      61ABB00E8F4F4F4D7AB6B07E3E3B3DE2B8A37576FCEEACFA9CAEDA353DE024E1
      6E8BEC6E268E82FD68D88772B4EE33174BB5E6E59C99A47C8B7C06C2F6F36A2F
      49036944A6464441AB6B9AEABCD97CD1F0CAC1E77A8F34EFCE448933140DA353
      E15AF9BF4910317549545F4CC028E5684C0180C152A2269385C21EDB29857A42
      011DDDBB7597DB79CE8D6F23F696AE4C0D355E517023AC6A413D539ABC3D9A27
      538502BF1A2B6F981477D60EE91305A2596673A9EE0006D982A444963218E8E1
      0FBB8CEF4902AE42EF9CE904A614BB8CBEA63FD9521EDF3E19FF0D029F3B7FE5
      F545DC28E7C664B2764AA012636ECF975B08DDA09470BFF4250BF21FF5C1AD0E
      97D345AAC14DB3261D5B2F70EF8752ED978D0FF9CD455A2A14EE52F63795846D
      2EDDF9D752AD988F4CD29230B8E226ABBDF65405C9CB20B7F03FB82A330CB9ED
      1F97B7EAD14F3219279FD700499F947561C9FCF94E01BB4135FE900C8CC563F9
      18D074F026F67FC88C21E84BEE2999694F4030566D5634CA0FAD28BF6B8C5985
      D860CCA7F53C1CCEF7A451A9CE9298D69D2CAADEB7D572694DAEE8AD5A6E73B7
      97CA6452BE1DBE6E0EBEFCB3EA08FD461D6B99F61CCC681F3E5E581A195A8CEF
      AA9EA10A6C94CDB3914667AC0EBBF4A2AADF92ACEABCBB691BD8408E689F28AC
      FB44ABF3BEA9DBB7027CC3F5B75942C988BB1B1FEA3E79EF5369BB6AE43A9388
      6D3ABC305EEEE275492259B94E66E734DE771F6A5D734431B7F3481A98514A95
      2BAADBA3D4B3424BA4F0993DA72DFD753185EED3A6814601F96E043517654944
      9E9129FBBD3FE499D1E9DE32E0944BC6EDA75A9D241B297DA7DB36726149C854
      8E6B9250A319939E32832D4C7DB9BE9361F02F13D3EB24BC4A13D51F77FB3F65
      6E3ABE6EB3A2D8FE90961FAC4B321DEDA8CAB9EEB79951E468E2A22FA6411D41
      6A0531B4A7B9535BC1598273ED94BEEDFE48770D86D4C3EB56BD4FB7A559333C
      AE4C0B064A9CB795F6B851E74C848376DDCCA66B82EAB8421CAA5214CEB2980D
      5ACCB40FDBD3BD2B867AB4A9EACC9214A5BBAC3337346134DF5737102E71B583
      F1B639BA2A2C4EDD0EB47A4E6EEAEDCD55F757CA505E8162FCA45DA043ED0235
      1083C1CA2B383C507A69EC846158873FD0AC943F27ACC9707A998CEB0B58D619
      8FA6C37A3B968DC25FAE91B8EE517B0ED4AA9264D1F1F9E94669CFDAC8A57A2C
      18FE5ECCB932BCDB4B33FFDFACFFFDEEDD3BD58F08BA613451A77995DF3452E0
      3A31FCAAEAAE7FF957BE6DBFECFA16C3699BED7751A4C4EA3085ABE8E9CAE197
      7ED69ADDB13676F973DAA667523563AFF62994C8C6B85E58F8498175024936FA
      AE64DE1C4FE5DE1570DACB305CEDFCEEE1280A5B6BCBC4E533DE568DC0ED9C5A
      AC9207B35AAE5C71862CA55CB1C9C03D54CB908D9553351E814C52596F4C600E
      35CB4AD98F8AA337B8344D98FB3B3996190CA1DF2527C2627DD90424F6FBF8E1
      E07D99B3D41671F085650F358A2D2B7C78F52EF9FC896C536CE071281B953F3C
      65EEE9EBA72EF56832E70FE9379E3509C96F3171551F415BE19F67A1BFD98CEB
      1248A38D5A974A4051EA5BEDB04145F4A11E38958794D44835B8D638FBA24947
      EA08771D9FBF4FE20D9870A33CB5A198A8F3880F5C1C5166A7894D1F835AF453
      93A65E33C48CACE17D7F79F59B95DF8D8274A8F3406681C2434566E5CD356FFB
      AA1787E239190CBC09C4A58A346964267500975B799166557BD332938C3DCAC9
      649848DD2255C1836078154816FB8F2371A78390947291669729C5280D384B83
      20963AFBA3A151195009EFAD8D3B1A4798B2291788F09A7BE264FBD68E3A4ED2
      A96D3A4EA8076F716C893C5EAEFC1BA7856928574B85939F0527F7A82FCC9D2A
      2F87DE995000AC828A8147AB3051D403CB5E8ECD72990C868B39BB5788300C68
      6F6C546202C29ECF528DB872A59668CF24233639F4643631CBAD1AB5CF2F30E7
      06624325638686A80B4EFAFA5813A2BEFC144080997E6C58832F1545ED291491
      2697418A715ED6AF5326B03E9A8C66B17A682D7513CD79D0DF75EADD6872F503
      51DE4EE51CCDB6A9B54657BBA009284E82CD72934453B8446647706FBBD957A8
      E7D5DF50EED5050FD857BC506D453C2FAC76A950CFDCA941FE6876D955CFD650
      C10AD847705AD4BD77946BC3CF5290BE928B35B86E6DF619661ECD49CEB02589
      A9B30B9BF0A466719D7C0A2EDFD38574F51EBED55A95B28ADA1953A3836950DF
      2926A75CE609F134E5FB72762CA7EA76D4A1771D6F95F3BCD4697CBE10774D9F
      455396B506A413C30CFBE14EC133D7DF6FDDAF361FAB737875B2A3915168D865
      9E6D1374E1D5744F74E34C4C77776397AC56B8946EA2629D968A57BC2371FB3D
      967593B83607AB3A4BABED52FE9B904F453853A95C213826D410F4F37A884554
      3BA6B0C118E8449B3A5A46FD3BAB9A19F467FA46559BD5133F671697BE78AFFA
      03FFD9EA6EB64783FAFE6A4DB5C1CEEAB9CACBCA5717B22B11BAD94D95A6BBA8
      9BF725820FC72EE7B7D2ADD1E7D5B16C2D292ED747AB95D1B620414ED78A952D
      92EB869042C69B811854815DB25318524877619E19934E7233C7B4A93197A408
      AF6AC3A3E7F3F0CC131A10A77C093D61A3C19A978AC6F061D8EDD1B9776CCA94
      B9771B8CF09262470BE9036B7A9A285B3A93EC6784EC1F65C4D33A6E44070542
      01D1A9FA665CBD67EDEFEFABE2CD11A51B5E5207F1CB6A536BC77D3B2FE8935F
      CA17FEC6A737E6961292669CEA3A2BF34DE956E2A9971A2CA3DBC1BE0A1B4C35
      1DEB840A558646A337D63CB8E612167F5E9F969121BACD47285409693904D37D
      84E2FD6B97AB3166B66A06AA8F9CB9EC2C557D0BE65783420555763ABC9B1B99
      15550B6C3A69CEEFE08E8E282B742326569FD488913C4DC6D7D66BEBDD4797EA
      65E8B78D50A8B03B6B6431493CB4D7DEB9E7C7C69E4D56A7AC85C369B4C6E6D0
      AD45B02D4DDE50CE59D8ACCF2917FCA3AB52AEF4E85490462800CFBC4A75E40E
      C7FA03EA95BD37970A596576EB8CACE45E48845D5B72F74B5679B80FC2F62751
      5C6D3316913611C842D15F9A8A2C9223CD33D849E49A61447B240E5707056BD2
      7A8135449D09535560A0C8B2B4536CAD7CA0B4CCC87E814DA6A8204CDC693DC9
      571EA6CFF42357C8F7E59104331A2D3525AFABD3F4C02885C268049A40559EC0
      AD123782AFE911B58911D7C399CA72D231ECD5C84F544DF979D305B12E338794
      9C69E91C20CA039D21A9A1584D918F4454965EDE5B913207D954C981FB2FD7CA
      193919AB44B450E88669B92C13D9758A2E35A2BD550939ABCD27CED8998E69A4
      9763CE7238B978CF516E8E441A8890DAF754C93A8513345E43EE1DA863CA2484
      7CA5D126F9A8B2B96A85793ABA4E9EA2864D07C9350BE918A2110FF769BB57B6
      89E2C223D376EF5E04E5D6E4A9EBE8CE7C94588351D741081AB08AC629C064B0
      AC9417CF10ED1514812E882A67A3C3D6C11DF581D5219F4E551204C395AEE21A
      6B4C3C89D4F49F86E2A5D855B4DE062DA719F5A0DD5E40564D09C6E5A3CB73EB
      A7F70747D6A78C6CD9824FC46245BBEDF3229B86C5363915DB078C3A89AFCC87
      7C78D724239E53AC4692769CCEBEA238B5EA46DCE8557BD41380669705499151
      7994DABF0AB84EAAE43496F27468B646C9D44961ECA419B382406F8826BBD679
      9825132D186A04AAC71E7E3C811F06754758397CD241C0FF99B87C397E49E030
      9B90F6EAADF6235B6D64E6A4D9C911A33B0EC5A5125C82F307B1E792D5C85E63
      31DCA8BA9A62B9383EF75E9FC319D0E6F8EB771F7BBE757C747261D8BE569340
      0AA842E5D93365266547B24996A499AE1F08271F75DDD41A96657984AAD2004C
      B196D2ACFC7612A163B66B33D8D40695339073DA4AE89BF7ADB754B65ACCFA14
      EA48B9642615D5A0D61A4A01AAB6DF4A5A36905D3A16C2A1F9AC22868A6A7257
      ADEDB284CCC418CD55CD73590F2A37C8926338558CA42A2078CC3C2853FE969A
      1F9895028B546BC5F4283D1F43CA794272E082B34BABB7A91E8CCA8A9FA7A4BA
      8BFB96281F649C72D083F005697435B5DDE420507040059B7A23119B9D62A8AC
      8C509791C1C17CCDAB42F9D7E0CA8DA4ABE3A72B4FB3B2CA548D860AEC2FA123
      44E07CC25FB26CBCC95366FD611F7E0B0CF12AE34AA5E9D44AE7774853A8F313
      4A40DAADC71CAA4D3F538A5F1505AC66D5CD865FAD0194F148B57904B4B4436B
      71F671F56DB051B1A404C7A4826E556869879099F6AC83C3EFCF54C07FCF3A3D
      F880CB3E7D77A62FFE70F0D37BBA9D5F799388D29E4D19F97167B7160AE21670
      640BEF6E044FCDC45214DB3390570B3C89FA7A1EF0913E369B5B2E5B2D64A94B
      D4E9268A5AAEE11AEA1A63632E9585C6AAD919D7E2AA44F6D588185C3C2CC9E9
      253FEBCFD6E73DEB6E2D3CF5994A9C0AA6309722A393560A97D44ACA1575A830
      3851694C3305F9CA9E5121482568E8BCC98064EC3213735C521D43CD3E55C70B
      E2743A8E74F85475BB1A4B3605C9845923EE5DF98A9CD735BFCC0BF7D6CA879A
      B247B309671DCBE6D062A02A0D40F9A91883B5C3E7DA10271AE1918FB28677E6
      6C6FB67F29D84321B7ED5506E092F59AC95B9D8750A8AD0DD1AA1E07122A5246
      6F691E1B535DC0B45BFD90685355A0AB3BD5967CCD2561891ED01E1783737804
      DB0F0B9B98E8B70EE33017621E992C634B74DFE3A2EAAA089BC252C44655405D
      653670B4A1CE0525E5BF7AC313D600DFA2BBCB48C28FDAD49C37889B988EA2BA
      8EB1147DE0D26AB7A8E464B33137DABB72EE957C7950B08CA554E259771DE592
      D71AB93548662934546422DAAB546EA18259E517FCD87A17340A6F650A05CB40
      405625A4BAF70AF53B1973FEB0525BCAF5E6533796444AC4B04451E71775991D
      4C2FB5673413279834C9C66840453D738E3854964345D428513913A354BB0ED5
      5746B6AA6389DADDCA2C608D55669319C01C8A802862D2FD353A9352E274A25B
      7DACCC50F4BAC3EA5E95C66E2C868A867CA1498D66BAD10D642CD037D4DF2553
      7063DA68A8EFA906545C7D5207636623EF561BBAE6E8A7EAA54C07000BFA0BC3
      CAA62C2893CB9FF339C2940E5575DC712306EB46FB221296F269878D6B3AFF82
      C53B4C7242189A3D84D3B21184C6D6E6E4490AE3DE27BA32D37468A6DE2B95A4
      AC2AE3182BDCBC7AE5082569965525AB6DBCAD1724DBB8C5D14C4266B3C49612
      5789721F340E93C895DF9095A6AEC220AAE642A6AD0627C7CBBF639D50C5A2AA
      27EADE01337915A620A46A8DC949B57802152F09BA66DFDA79AB4AFFE9123103
      AD5CABA0AB28A56C54A59B3468C02CD2D42D46316DA2009A9782518A706244F3
      1CD83BD82709A536732F25E78694D93E62E1AEA66F941B5729DBBAAAE619122D
      467C3644F8D5AC2B751D122BB8B4AE9A66926E8C0299AB5BDC5B968F5CD7D67A
      514CEE3327D9C44D4E94D5DBE18D526A3AD911C4554AD3A992396AED55CBDC31
      E36D902FBDD11E8DA05FC804D93664BC5249DB8B12C53665BE0BCB690C01EB51
      C1869434F567578C4B2BC706FACC3C6222A843850C0599C049C1ED1B28849C97
      177296EF1565C669E1AEC4DB7C69FC4C019D81C5D7879DB08C55E8A2F2BA390B
      61BF6C5EB6D93E4B39E0F4E3D17758376D4E6F7686A1CB4F22E306048A309439
      B6F296F9D4324DDA11592B74503EBEA6DC2F99A7E3FFB5E1CB55C43CBFE23C86
      54590E9334D19E6084CD3FA2232BAE1487DD96661BABBFD6F2806B35F2CAB029
      CF0DB444A60385988BB8B36C3A21F3638EC83A7D6FA7342729C8FB417C9831AA
      8489BD937248C653E6F788FACBA89C837A114AEDC5DC3EE4B63992F803D329B3
      038903AC34A4CC38537034CB2394D8A27FAD10D3D7ECD64A996DD7637AEF0296
      BCCF9066CE2918252188B2B7641CE79150D9195CD7A6007163C1691B2AEB023A
      52DF4FEF53F334C6A9568670D5947F915C8E1921018BD3C086D7DE4299B64819
      3B2ACF052E5DC1AD61A92E8FAE09B2F45A59DA63ED97EC5BFF994E951ABEE683
      92801C3C4E1CB9DD18A8AB8F3BD28C6100B86AF93DE74B5AAFAB0E37FA13DA93
      673F8E8987546F9E8361C24972D67FFC787EB1399D9D39149BCBD79D2B212152
      56101D9C874A3B671AD4CFE5586218529F9E5F58FF6A9D916BD66033B1F7A696
      E726A7BB0FCF713761D748653FD7BF3BA5EF4E539D43C1DFEC2E3956CEE13BC3
      963628236CF296D3D09DB56BE7CA757E5289ACB31C65EE58D2D2823ED30CB7E9
      A4D6D8D93C984C207C55FE30D74D1A1CF05ABDC166AFD66AD96ADD77E7F2DA4D
      FF79A90F480D3677AA3A07A641FA591F80D45BF8B225304C46F8918E6E93AAD2
      403FC5DCCB9B7CBCBCDDBBC5BB01EA4FCB1003104AD8A0EB1D65CF1CBF94511D
      359C3D732261D21DF42867309A56BE86409CF69620D08BFCBAC4929AAB302163
      49DC94CDD7AC9D73633D44491E8239A9AFAFBEA502866D6E9E9521B90A0C3F1C
      A6B9AE985B35EB2F9C547D3A0AC8BDC9A9563197E6A607569FBD5E544CC4C4A9
      C962CA196160CF64212A5C2D7D3797429ABC18CA4321967B99E32D329CAE938C
      C26F566FA26C0EF5F4B26A9A628933A75939918F8EC6A61A84DF640AB107AA6D
      BEF97603F4988DA45FED7F32F1D9306EA168FFE31136419350C2DF5A79A1A48C
      13056A7912BF4F72DA553B42522AF41BEBE436A01FFE820DAF2EA1DF4802BFA1
      73265C896FCED3AC505FE66FACB7693A24DFE55FAD0BEAFDFC97A7C6F66C92F1
      4E769B86B91F6B2B0B2E5EA0473631D89F0B5A55F30FD36CCCFDB1AB031203C2
      05ABACEC5DC1CD387492D437005035CB5B5BBD7CC1AA95EBB2F28117E7BC9EF9
      D32F5993E62D9884CA1D3070DC86CE54B8A727C1C7983CC37D6A20631685111B
      55E099B32F54E7502B540D4AAC1A77CE74472D45ECD7CEEFAA56EEAD8455A280
      647784C6C8E2C5D33F7F9BDDF3472020AF4194E371F4E52479E214FE39EC5432
      46C868D267AE74CA1A27AB1B776BBC12C6220DA6414070E75C6179C56547521B
      D3F4B2ABE9A5A4A3CE8954113ECE7FA1CB5F2BDB86B376B9A41A3288AA36D742
      B8AC4F67985C933994E40D7A7956EAB1F83CE8FAF8BBDB776CFC63F7DC3EFE71
      7CDFC53FAED7EFE01FCF1DD025BEDBA54B7A8E4D97F46DD75577D325D0C13D7E
      4C6730A08BBADD4187AEEADAB88EFE757A2E5FE7FA9EFFC7EA64CCFE8FE7F21B
      91CD2FD3B24BAD5ADD2B6F8043D3C7F92F4D1F11907869FEBED7AFE12F37BFBC
      2EBCAAA1EE361E9D45AD269B5F4CE35329FA605EFDBEBBD2C3C4A6ACC6D0FCA1
      71C2F97FEB8CA2124F8F9BB41C478DAFAE5DBB31686B2A02D60D370D39A658FC
      E1950CAF4FD3F0FAEBDB2DCD5525EBA33F4059DEA7C48FE3E137A1056CB8392D
      1925391FF5EB062F218D8ED4960AE97202D55C2143990456E570E5E974757E4F
      284DF82867088E3C1DDEF0ABE9E089929E6E13AEDC55F80FA6F38D4984A32E55
      157AD1A49611FA2D32FF7F4EB361743E11A1DCB35E5292D22F9F7E7BB9A79CA9
      6F610DA6CF860EDD3D6F3D4AFCB14620E922C1257B996497B196FABD5B4F8F9E
      29ECBAA569E5342D5D7844D98C3F971F7E33D63B5E7985B2BFA93EF5273A80FE
      A7F14CB4E3F14150C9FF379BBAAA7F632402B0D0B582011B8ACB9C80CF09869D
      5B83AA782CD73DCCE4BA523D956E31F08D028B9DA7092CBAFDF91D6E428B7040
      38B4782DB93D99E33FC196FF594589C72AB15DD5663BFBF6BEFDEF9A8AFFF52B
      852BE89C82C9F9EB64081DA4696ACD33C91C7B3466501E0EC6363B481E7BEC58
      BFBE0C7ABF1622F8C782158D93578E4F84EED96B2C2DE6F6B790E705BAC371C3
      BD0D167B489359B4C674FFD739EF6A60A328D33DB26E74CF570A34A5D1C9384E
      8FA6A389F5F9FC58A32B96FEF4735AE2668569651786C38BA383AAA4A9C5F381
      71A7FB43F06C0CFCDBBB8FCE9EF5EE438365FF495521D596B78DD4D0E98A903F
      FB9D368EFFB3EFCEE022B66AF02A071BEE05DB7FDCB39DF398F9188066A6F350
      DB38B7EA28ADC593A06EC6A690FB09C66FAF693FDA8B86655BE94ADDDC75DDC7
      2B67BEB9A9764E86374B0E78F931CF4649C3FDABD5DEC077D2AD6C4313017D0A
      DDFCA4EBDB00570AEAE7F8FC93513FA66A4D865763832AACDC4BCE0C383E3F7D
      8EF6C7C6C45CB9D0BFBCFBE8FE667D471D6D2945F8E4C3BB8FAA2EF1192EE7CA
      C9307869AD9E8F9A6209552A9F499520691D1EF2916D1BA74743AFB0B87431ED
      73132D1BD5B18EEAA0C37E5A57236615CC8032D28654EA76747AB8677DE44258
      08D9FA37C7E7EF9F21136F44EE6A91CB70AB2C778D7BFFE9F8EC8767B8984DB4
      87F3FADD879F7E5330564A24B57122C7E39C8EA784898D73CD1283D9A5239308
      CC20866D8E4EA8BA5608908C12976F09C11176EBA52A7CA000451A45BAC2A895
      F33BD20778D1DD588C9210F6F794207328D9791899C24BAEF36A743A68525884
      35921981004CA879E8BEF53301125047A5E255A2EB93C5501585CDBC2F89ADDF
      6596EA0E7FDC4853E4399DC0A7CAA01EAAF33B4E8DA12CB2B20845C3DDE8D7D6
      BA0C1BEC1ECA1F262C0CCA184EA878842E55004FB0C64D85A9E0723A1E133547
      838B12AB2A37733565A2A563F91C4DF7952BF4F6FC8070E76E3AFB5E1B870FEF
      7FF521CA3738AA7F95E396273F316AB2DFAA3457E6D18950A7EF842E98DCA894
      1986980E9231E3064684E701575437F53390580C4A08FE179C89A96EDEB78EE8
      832B41C5D2ECE7E0BE703A64DDABEA9FDE1F792AD1EDE25D4A8D3F864990D593
      2E37C74F8F3F7EEA6E8E9F1619AA8BFD936764A86EBDF8E5FCFC5859AA87AC0D
      E1531F0EA781696263ED904FA27D97DD3DB22108B6A8E6A4E293D562CE383F60
      9AAF7E5AFEA7FD300CFF713FB3F20F4FC522A9F50CB74513EF857B45FC666DAB
      FE5305776753BD88F36D73E8A3AA185A39C1D2A7D15339288694F43569ADDDAF
      627CF8AB861FD2C6796CBD38BFBECB9291F5D399EA54426D89A6854BBF6B89F4
      86C0B3846A18486EF64F67A485F6E567CEAD0309AA0FF6E8135D50A740C65EC1
      68F66E32FAFC559CBAF8A9B4495AB9EEF1EA3AD0AD17BAD7EB1B7257FAAF2238
      7F7040AEE46711C9302198719D0EA93BA151597C96DE24AA8DA3B5FD96E2AB67
      2A0BB2ECA562921BB7952BA4FB32EA07999242CEAFE4A73016451B09BCF56204
      159F5465C6A0487960A21ACD129FE6C9281962F8543CBC679044874978AD4BE7
      7559BDE04AF0B2B134A77B8CCB64EF961166FB4C521297C176A40663F3F336FD
      DCF87306CF9B887189933E52857D35675A8C5B498BEDC3743461F8157D44B898
      146706C62FB2DEDEA9E6E95CBB2B6F1AA4DBD5DA40D61A85EAB41AD5A7E76ED2
      52994FE5C9AAF1C87FC3ECD87D2F26EF4506B725DF2F3EAB5AE6EACBFF98CABC
      B8C054D597601AEE45322E14E628C36A2AC41C0D4AC4723F84110ECF8F6BFB93
      31B5B925C62337465DD546BA25A677FAFDBE7E6D9CCE8D064F23886A035C1DB1
      E41C25BF8BD64E6B5CCB01114DA292512D167DF0E984A3229C5FCB8CFCB79CFA
      B78F93186A6644E1DD440CF1E3308D54906413CCF8E260C62694B12894613FF7
      50C62FECB16AF7E15CE10DB3BD4A5696F61D4A70CFE7B4B64D67767EDC72E74E
      3BA9CAA5B3DC6A51DA37950774AFC2DE668441535FD6C6193EA88E1BD695B771
      DE357DBDD1A55FAA4BBBFBCE469B2ED2A6CE469B6EB4D0174F655AC4AFFAE549
      0DA577149918E743517092844243D21EF0AB70F2465D1FA6A311F7F7E4444A13
      FE6CE7626E9F17146129D2C6C1A736CE72B5A7BFD1515FA0A3361EDF421DE53E
      771DB5F5E27FBE19CE99A4E539655DD45F0ED35B8A118D24A5BCB4726EE531EC
      3B4E5B2C718DD5B271709C42C3344B10A0C533DD7AA1D791FED66B296ED224CA
      AD4B75C2CE681F99849B45336534EA29A1C6D1D9BB3E55CB64AC8FE8F23D76CB
      20C4B481A6730FA1EE460DDA62A9E4428D1C4DA88213860D228078A532297CBE
      512C5FAE583659510B158BF7DC154B25980E1875FAD3DBE303AD629EE182FEB3
      1D14FDF4FEE08842522C25E56852DC69BCC1364EE6B3D606341FA3EBDE9E1F94
      39B16D9E13F84EB3DD28BD3158B5D0E1D4C084D279B9FBDD10765A1E8A8924C5
      D7C6D9424E9C7E5C5DB8C02A9F329A3E3A8A3C1B05FBE50AB6B351B08B14ACFF
      DC15AC02916DFDD9BEAAB61A41BC6577D6508AEB16CFA286274E15E29CAA7D74
      7270DADE1971D72D930594A553EE1ADCC6E988E84670D6D8FB34E2C2FDDC8AA5
      A094BB36CE26CAC4E5FF17C1E36475A81B89AAC29C32AD4DE7B96DCF043C122C
      E04D124DA91E8860E6DA38F938A5E23F2E4F62A06E8ED363A77D6C6FEA797560
      DAFAEAD9AD17D564B8D5824E1EA7332F4ABAD02729EA8237DB85CC8BFD892036
      D5B19432684509EA0CC949898BEE7F73F6222CBFFF86B1B8AB1B41E1D16DA491
      32BE449EA761C225A8A6EA9448F30DAA19FFB44F29FD5885AF5ED0B8F7CDA6EB
      FE134D374E9D6F31DB6F85A38D098F6FBEC984217EE4386FABE8E68244D847D6
      C7EC528C93DFA9954E778F03DDF62E05B8B913564285F28CAFAF6B82179F8563
      E14183AF5BA5F86A94EA51BEF917FD0329917FFB03907D5BB7B831F7CAF926B5
      F27F9F26E13575D5A58E73C3242CBEC1CED4D60543EC73C54C1BD7902CAB6FB1
      801FDF7C5BA4032EF652CDADD369312170FF74A8EBA6E938D0546C9A7340EAE5
      3B9A86579AE955C93584F36A2F71348184FBEAD5D5DBA0F0FEFEAFBF42F696A2
      174BF82BECE5FCD75F4DFD7044C82D85181798EDF646A4D58F983E9A66705749
      A4033084CDAF902B4458A4066DA69DD3A4291EA5E39705C7FB87D81374909DD3
      342FCE8E8F75761AD8A23CD33627D096A40EA9B204D6B1C24CE457EDCC53BB77
      FCBF4733BD97B2F6EADF34101C7E284BEF5B7A2EA2A7FCB3149374FCFA201BA5
      D9EB83D1683AD639A4133AEECAAFA42CDAC9D96A7A6F3F1E5DBCC65F363B0C55
      EB6D3EA42C21DD157202C77DC6E96D93E60A6490729B3592FEC6F6B0B88FCCB4
      B5B00B8A6427E638FAE8E3DBFF635D816EC396DA347A42BA36FE0AFC4C7A9D62
      9356242792EA25C6E6D0BD569DBB39F27BF4915F67DFD9646B2E3CF3EB3DF733
      BFAD17499E4FA5E50FDED4DAD832909D367BE6C0F5B89E3BA61301360954921A
      CC5CBA8A2E2FB1F40803D8E070B7529730619AB8155D17C4D3E98009CCA9CFAA
      93BD6A4CAB9A7D6B29F491E09EA13B46AD2488E195AE6F13DC8B864DB0B2B450
      1E92185F0E4995662331D407C82AD2AE9D293A5B61A6627405864E207F64B78D
      B4B84A8B6B7997D781472AF4100D41B2F30D3CEB63DAAB5F3F18F28AADA1241B
      ED5132EC447C9328ED9FBF411088D79C003FFF8840FCAB6F36A1713A960D67B4
      C67CB656F7EEFCD3D79F7232862C2A5A2A858691757E95C40D6477A1916FF342
      A89C1265BD5124EC3A99901353A4549966A417AE839BBB439E0E3CFD0CF2AD98
      861AEF42DD0A6B36A76E9CD0FA54C8A52080657E5D501601FCC8569274EB4549
      5443310E0510653EFEF0A0BC67246702524A08BA1A449D68138A308B398A542A
      4D05FB4C38C12D6E33253F13648FAC4DAF017567296068C930CCE2462443937B
      D162D83F3574DDD91623BDE3132EEAC0AED39EC012CA1FE56A28284C1D63CEAD
      1D2AFC08EE2CED59B472071D16D9F0CF8784B04D0DB70949CDFA40691A347CEE
      E63B4C26418A69EC59C779885F535D2563FD44E5A06A33B571E2F53A378D796E
      7639454EB5EF144D6133C762989B7E298D70C67295C352F646E6E3072AC86AE5
      0ED1C05F2A65473248924243DC031147A9F5F28021F9165F46C93D2FDB38EB7A
      22D34C5696022B54F0166F2836ABDA8E30AAA3497CDAE16DF5F3EE5EAD09B0F5
      364B6F733A543F18167F7EE7B4525C6CBD28D7B7D60B3948D3EB91C8AEB506D5
      A9876F9470E9EEEF7BE6084F9497EE594405F3DD656A0522BC6E23456A951931
      4DD180AAFF7C767A4438A0A9399B1AA7B77BD6CB74FCB2A632DA38E1FB65983B
      81C49C75A47E8F00E4CB9001C720DA1934280B4E4D2AA2A0F31742DD84B93086
      8E840120B8B62D1F52A30955568A2D3F194A827BD54AE52E9D66257A5D12EB86
      14AD26C8D9FD4A713DD99D9F2FBE3FDBE353893D6E76B3A74E71266272974D73
      DE1C7BD677B238BE81DCE0760365175850AEACB25B39960FE2E63D97325B3BC5
      95185FB3BAFE5B3ABE8D7AED6636552DC944DB3154D3DCB34B73A4035FD5F6F6
      F4A7D3EFAC9DCB611A88217F850F3EEC5B175792BB0EBE2C083E5882B60A83F8
      F0073A1D2EA8CD8ACE08D7C5CEF4AC826F5241219574CB7089B8AD56C7DC2A82
      12395D43CEBF9E7D77845907E61C29B5CE8EDF814FB98F9F32EEDBDB9489D220
      283FC06A828C99164A6149EBD3E9915DA30996FAD3C1E10F10691C26A524EB76
      12839225DE7EBA383222892C0F5D0111A4D11DA515152A6382B08B70E5076BDC
      561EE7C99E497CC0992E87C7A7A7BC9DD9F6B854652E421DFDF0496ADCDA7E0A
      4A3EBAAF7553389DF7C3F3ACDB5D1FDF9D5FD4F492B5C37ED8CBF38413BBB45D
      FAD2F8FC649DC5F1EEE648F9098E9437380D0B8F94FBCFFD4859E613DD1A4A77
      2AA62C70C89240C66906B1918FDA992DA60F3F1DFF0DB5B3CD0B789716D45E16
      0F75BB01589A9799CC73AE890BD5F927C5698629F9721313E46BE3DCCBA35FA7
      F7C6522E8AC27828D53D1420F5FA2DA85D117936B97572F19ECA6F39320C9539
      8323349684621AE2EB714BB38CB65EA87A564A8F6495D0A7E2C18C4D9DFCEF53
      4A2A0B32B0882CEE5346E70A5C26ECE5AB301EDD67D05D192E3F87F3B22FF7AD
      5FFEF7A7A4382FD2C96F6D2413C76B8E82E121A753A6E3D9AE262A4F025B465C
      5278B401D14540092943DA6CF2868835BCE37212762E52DD3654F55F18B5915E
      EC3F940D2574F53737D0BEADE23EBA730BCD3352AD375BEAFD13A68A5215B45F
      8C9EB8B3E467111684A41F5EA913C9E24A1F15B1659D9B347D4FF9AD64801312
      6A79031F2D690651B1F736D26749B478CFFAF18453ABB274A842C78D63ACF91B
      EB20CF49248DC4187B2EDB33BF072692CC1BB6A5A1641DF050FAE9AF87FFFF99
      B523C7267FED773A9A2D0F60FF7D77D65325EFBDF553FEF4FEE4BCC588586570
      74C411BB34C853AE4CA022EF61CDD27863BDFF78F4760F7F9F1FED59EFBEFBEE
      80FF3EA7BF2FCE5B3CF3A9EE4A7E7A78F161C6E7A4523719D52C851FCF7FF8A4
      0DEA36EFD452A3E9623A3E20C5AADF484B0C1341E7C23C770B1603093A12FE6D
      9EAF32196B409AA60D3507CA5ABF735F1E35C9976507F7A56E837E25B9DAA666
      D1BC7C6577DD9EDB777CB7BFDFA13F2FC9000A24372566390736A1C094AE5252
      0FA24034DCB2BF1E9EFE5C898A16D3D21C116D5344EAD75F559B4F2B20C09C7C
      DB6459CF9F0C2D38146A3109EADDDFCD418ECA2D2759C0ED2FDA3A3BB712F6DA
      E26FB071E68EC8681B30E0625B617734219450FCF4DDD959CD24C35FD97452F6
      7614C5D56546C0BCAA379FB86969D46066CA0BF4C0FBEF8EDF3177933DAAC4DB
      5F4F3F1EB65FA29593DEFE713CCDF1AF496AF8EBF9F1D1366478D6D640505533
      AC26A8F2136697F5C3A7C3FFBBC75BB74992D0CC01F8FEE62CE109CE12369094
      0BCF1206CFFD2C61EB85C67ACEE4CDEB0F58B5F792BB21538047E78C4CC7D82D
      FBD68FB082444C96206C443615990D52D5D8569735D0B1A5A092B52CA96DADE7
      C4132B29722E0984980990C9BF4F938CB02E55A5196305455CA00C791AB5727A
      6AB905168CB278962101D18A52F7A3F8AEC42578497E71A2AAED1A24D4F20137
      314E1B89C431BA831A5F538A31049E5419A32A83BA9533DBFE3FD3D1841B07A5
      A5F1A70C9F97B929A29CA493E98491195A39C5E33105EC5FEBC03D17DDC29E55
      25A3BAE8A195F33A4D2FD5EEA31C881B99DD6609863EA66C11E7FDDB564EE997
      CF4760476A4B56882195BB48D3313EA3503265005134E22A4BA79757D047F4C1
      2773088CDD79252890C5F54079214693067269DF3A29AC11C74402498557F174
      488F2AE82CD1C2B656482C6C64B692A6655AE25B7C749D1B6D5D83F85425E5D4
      3F80227E55E3C77DEB930E76E0BFC31FB89484CF54F9B0AF95C4589481F4402A
      AC3A346530E88BF7AA309F4E72EE346CEDEE7E19EEF91ADEC297F8074F002EB5
      D2503227676F9E21677C73D3DF59ECDF3D23D3FF43BD453B5985ADDCE11F9654
      FCEC24632A9E5445A197D3A120F37D428A83BEDE6DED5CEB47D33B17A7228081
      1A911FBE675D1C52F1DA29E6F336FDDCCE196EBD38D71CA953DB4448E08F3002
      3854674021D4213A9710FFF91DEB2932D095430AA90EB746E277ADEEA8E0AD9D
      D438D307B5F9DDB8109FAD2B4892214913F2CF335DB7B7F221A080725B36CAAB
      DEBE860E37368A6B91E2EA3E77C5F593C812D5E937F99D00110A8D1240471ADC
      4861BF9DA7721FA70CF0A48E2097CCAB7DB33A51E1FAAEEDEDE12F9FFE1AD05F
      7D6B87FEBA15B9B54DC9855CAD4753DFDEFD9A21F9672EA7DE2779B811538BC4
      94FDDCC5D4D68B43426518A5511227545CCF9096A3892892201926F0BFD9A609
      52FC752431C9C4FAEB31FBE47F3D760C226C4E88B0793ACD08D38012395B2903
      54D0F9ADC8E5079A4F1980C8536B3ACE559447353364BB4FC3DA5127F769480D
      7FF421443B27FFF6AE900734396B28C797586C782619C55938CFC677AD2029F2
      CD29E4139C42DA83CD29E42251E93C7751C92B895D4F92E126D139EAA3B4817E
      4C46620CA211921AE367FE1A0F237277FEEBD73FD18F94F6F60D04BFF5FD7F7E
      3A3E3B3DF9F083B57D551493FCCDEBD7A3548F753F92378918134AD83EF4C16B
      FCFBFA42E61E0DFBD509A890BF72FDDEC0EEF507FEF67D88B866A3773DBFEB77
      07F7474F84A1D410A61686DAE9449D7020456F100F0211CA6EB71FF6ED4E4788
      4EC70DC4A01374EC8EFAE3A87FE48AEB07AEBACEEF773A3D57FF87DF7BB8DFC1
      5576ACFEF323FC47FF0EF4CFA08D2F714D57BD8AFEB3F1BB8FFB7D0FF7FBFA5A
      7D1D3D977E061FF3CF7CADA39F19E977D4BFC7EF9E79168D05FF6EBDA0DFF80D
      037D15EE7407B5274975357DEEE07BECDB8E83E938B8C6B1F5CF7DFDBBAF66DE
      1B78FD7E37769DA01BF562B72F621B34F2A2D0ED7B76CFD77404CD3C11D044FF
      F10F62DF6194E5C375B9753AFC358CED273135BF885131855F7338294ACED14F
      2462E4E7CEAFEA50F1AED7E9FF1AA769A17F0CD361FE997E90E3687C2533C977
      D32D948646C2919FA6445B38FC358F8B71F0B746C46104C8FFD14D1474F62615
      7B266342BB15A6363A92614AE273E74C57381D9CBD3FD8B33EFC747E42E9FC47
      F61E414E7C6C67384CCFFBF8063C44B621C57619F0CDBAA40A1B3ABA3B395279
      61947D304C7EA72B5459538BE7FB6E592E23238E9808BE6AEC5476996CE37C75
      056CC7B5DE60D254B496124E17619EC029A0AA6786F3CB47D60EFD707995E6C5
      2E1F15178D2C057546DCD2308A2910EEF7419D23D5518483C0E425123AA83511
      D435241D4E47701D93827035E1476176D43A94FB6C9080D0E58CD64E34E5C42D
      615D0985AF9249585F0C9E174C2F77099506D727D48184C2332A36A35A8B09CA
      C46C3515BBDD01C86860B1AEF8B85B44116D239036CFADBF9E9E9D9665A2BABB
      25A1D8AAC437751C4C244A73A9AEE5E6A6E96A3C174C4B665CAC3F4E2EC706C9
      C7B44B38B978DF72BA7640573E87AA212872712D232BE6BAA52DC47612E952E5
      7CDF3A18E6E91E7B01DBF3F76E530884904094A06B25753ED6B25A743B333AD1
      22AE621427E8EF824A45796FA924CA40426991C3DCCA096B5165577BEC504CE0
      6B96A8F53A937BAC304B4503FEA2727FAE50AA95F947090591C81C050F1D497D
      0CCC8FE7560ABC2729A125A7168F4572C37D6836D1E54D0A47B3B889FBDCE326
      B3C7E594B6C5165369147280991AD04544C989C861155BDBD4576CDBBA9677D0
      EBED34862811A206EE6A60AD5B3B971915F75563C1CF5C406D8EE9970A27EFF9
      0BA7433AEDCAD8CDB84D8643B66F4CE6B2B4C8A7FB8C8993525FF9303AFB2203
      29534F4A0A423EBA91DC3332C544EF34CC4920AF92713B859AB6A06D8F2C6883
      B0AA0BB2550B3D06BAA23A1442866AE51C4B3FC1EEB29FA01B1669CCA234B6CE
      60F752CA836A7EC990C4EC8FC2C03B2B1B2295FD1038E2351477EA284D552791
      F5ACFC33FE3A1DC34FFBC00DE9F8C9555BA5BF1E9E9E19BF8BE9BB72F4E50268
      048D962F41E775B74BD1848AB0B4414DD9B46ACD51D67AA912A8FA2A0CD3F47A
      3AB1A22907E2B8F22BD24CCB785C8414C59D3AA6E34C0E93D62A68E3D9F640AA
      B7AA57ABCE2CFCD1B476252FFE48D79B9404CA0947BFCD1326F74DB9AED6B686
      E35461E56D70C3D0D85F4D18AEA56E6C15D5206975F053BD387E06988FE1B320
      59D8AB55890CFBD6B98A3F136F8C202FA0A2C4D054C5B1C021D9A47321867766
      1F498E6E43E3E7EDDC2D25CD3A245A7EE2503DE1376AAA29194D2E3BFD767CFE
      9ED115F6ADB722BCBEE41063D51B71988C12EDE9736B70FC5B621C6A6A716157
      CBE9D4637DAF42FAC2FAFB54E685514B5A0D62469950888E5AF2C499B824A40E
      55E50FDD1748D34A1D6AE961D66B6F6993A198DFC4F87C631DF391C94CB5B22E
      E425B44C8576C75B974E8EC6E266C4E8F4FB703AB0397FA484233A4FA3786D2D
      56478EB68C634ACDBCC1AE2DB72FC5C855044FA146B592C015539211FA519BEA
      443EC59686ED720B84FD0FFEE840C348519594393FA80AF9F6AD23B551E9CC6A
      CF3063C2A5C4842898FC2EA38A862BC7A7116E552090502E5A496543630A95FF
      942620D8C5DD44EA76343083E98C663291F0DEF6ADF78A62B9DAD0335B77131E
      B07E18D3D665AA6C82048B8204FEF30F12186FC4C16EF8910FB1EF1D1F29A381
      F244B500DF3392C058155074F03152C6427EC3BEC8215500C5CAAF2C830F8101
      F2828EA42624853ADF2CBBC8F150A8A15A3B13249A80DF68D9C3B63D439E95E6
      ABCEC955F8AF1AED4DC0DCBA1C4346EBC67A30595F1625BD88CE7CF9BE39438D
      529933A5730ECE5CC9D9E79AAC66AD7CF9372C823AA34929AA83F5D0E50E1B31
      B729025829DF5AD3FEBDDB258B6A9BDC9CE944F3FFB63A130FD2CF1060E1559A
      A930569016D4948F3A7F407CB55210899B34210041E5A311627848188394C664
      4C43C8DFD462B4814806D34B0A037ED5BA9FFFB949F0FD4D12FC2251F1ECDB7A
      6CBDF8991471416957BA319FD688099D711462ACBBBB4AB8A054EF0C09C19DEA
      4C8F5F6526557DA649D3E2277C2786D607F979CA6EDBF9CA8114528CD89FCDAF
      52DD6904E6D211AB7E915F5B22A0364C3C4EADCF21A8A6A356E2069768299F74
      E3B61D955569827BBB65272AB231D5E9FA08EAD844689439498430680347F091
      D371906663EBE8F4B08D34D114D92638386D245A2747DB8B52507504B48DB3BC
      A0D9E944A112046B61CE10CFB8012799EE086DA4C6812E492401A30ECF6AADD4
      F1A13EA1FB17ABDFE95CB571827CD628F984869A260E133075980ED9BD1C47A6
      B9ABC99F85BAE142BD367749DF7AB13DDB44ADC47C5395A8E33021EB4BF972BA
      0DF0E9C18723D50594A9821F4ECA9DB1A3DAD1AB6D6F786377DFFA38AE75C7D5
      C8818C91A88C923DDD653AF9FD7F40E7F913D3ED7461DB10B2C5B8BDB64EE4D9
      98B34F60CEF636E6EC2273F6D923CB6A2BE2479D4E1025A2116A281FAC167713
      DD834861D377F7FBCF90091A48E0535587245F47529724496B5AC47D5DBE4481
      B34C8CF36155C0A5EB33F614DACF1D4BDFD148C1CE42B6528EE77991F1F60079
      74BA2741B5EAC39422256428DDEEA18D44D3F8BB5029CAE6785D9E8BE4D7C924
      075DA208F6986ED0B091B14F2163FD8D8C5D2063DD670FE167903E3F1E5D90F0
      802572D540C892211C593B45964E03CA99E4F8FF91B81D5F4E09D55AE62D77E5
      DF957D23A9EFD8C1E1B1CE835738234132E1DE57ECD6EAD38B138EA454502D99
      08A5359FDDA39ADDE9C80CACBDB2D672C12355695E956DA082322D06523DD0A9
      7DDC1C1193A21F6A19F88CD2C789391A98AE49450F9728ECCC1BCD9BDECE4F21
      D1BD8D445F24D19F3DB65D29C4E069528B4ECEEFA25EE9279F8ECE4D9F5225C9
      9EE1023755580A0FEAE8983ABFEB04B683D3C3EFAD1D32F9B78FA4027E627942
      A7615052DBED5649ACA16BFD307386A5CF243722D6E0A6B8C6A65DAC201BF0F7
      47D5A8881498D145149E4B19F2814EDBBBFB2B47D0B7143E441BA957318B513D
      0C6FC18950638BDAB6550422C6614DC2FB45DC18A232955AEA3CCE6C9680E0E9
      6B6CF05EF56EFBC4FEF18E69E909BAB0F877773983835259CADC456A5B31AE82
      F6D695C8B9CFFA4CACAA5524FA85F1DC4D846194E49C3EC4FDDEDADEB36D16F4
      63E55DB52399F34FC7A765A7CB365260EBC5272E547D1530465E1569CDEF604E
      8F78CF6F1F4C26606D55FDBAADD02D76389BA2AA069DB12AA97539F5392DD256
      2A926D0D21A0A6DACA191C4080DFFD2EA98D899A051D0C64991C1758487DC89A
      3F051E93DD746A7AC8F6A211DB56BAD264EDBAEEE36D56BEB9A9D19A0C6F868B
      4D577ECC33B15DCFAFEFB264644DF449FA307D8A93D0275DCDD5481DC130B9A1
      50ECD9744CB56B4AC07CCA52CA82C8383CDD18691093FFE3693E8F34F8E6F5EB
      DBDBDBFD31657B8CD22867E0B654CFEA357DF2DAEDF67DA78DC0823D7B31B060
      1D54B0D7ABFE634040A901FFE81E0DFC57020FBA1ADA6F117020FD87F7F9A186
      0634E0831A127006C0D03C27D610815D0216645040020B749E2D28E04AEE5A87
      A3305E70FC33C1006C3702E0264ED2C0487CAFCEE1A95E52A8ECFE3CB5D2983A
      A271FF5B3231D85322D767FB231D946D930BAE6CC5B754424E790CAF3329F0FA
      80E0054A9F0A43DEB3CEE5DF19866ECFD2A7787C48B767C922DC6FA511F96E3A
      A4266B1332A0AF09764A85BB339DF113A930CCC526FEFA04F15777137F5D2457
      5A00DA3F97B7404545167C696C13EC9268488E28475474D6ED7EF1997374E568
      E5B327A6E55E6ABDFD787ECED8AD1C0A341EEB336499A6413A1DAFB8A19A64AE
      F4A9DAEBD1CEF88F1FCF2F5A3CBBC3E3D353EB56D0611ECB2AC2AF9B4E38E818
      48C2EE2B730A6B7D5BDA38DF2AE8C8E1E951CAE575437929C23BEBECC3C17B7D
      B249C1D7BF281C1A0324A6BF519DD8297A8DBFDFD3DF3F1F1F7CDAE3F83E34EC
      C9799B53A2A92157031A9261B2980E65049769351BC39D8E73114B15E29FDC55
      50072682C560ADA46994E469A509F2CBBB8FCE6FD687948FB074CEE9D1C9C1A9
      45D80F9356066CB165CAD6A24A0A66F30D465533717119A5C321A1C9E2895698
      899C0AA2A8B5B6AEDCE0CA0E0E746AA3F6E8F4B0952421340B6BBB42FFDAA636
      DA0D08C94DAE548F636DB7EBC6E37CAA13A743D2C249ACAB62C8E427ABBE956A
      B34C2426582AD843779575017EF9ECBB3ADADDCAF5FF1E2B651D5E9C9DB29BC1
      D692723B341007B545A22D11570EC9C6E97802A7C3D9381D8B9C8E67DFFEA6B4
      BAB441A0929E0D101BED14155AAF9F9860CD477475FE667366B270CDDB716672
      4A5248998BF99E7542127FCF3A9F48180A4F727AFB758F4F308B37B393D8B3BE
      9782436A057E7E27C2A72AFDF9BA133B13A17C637D2F920CB338BE93B5456AD9
      4C0E556F3D99B56FE86752D549B46FE454C9605163EEF60DFD07E3DDA7E337D6
      41364A3378B2524C28127E301AA57BB4E93766478BCD0E725D5FB35FFE33C735
      6546298364AAFF7874A63C2C85A044EDD8AD5BC1862C8C8F3C1797CA8E5728A8
      2BDF072D276EDE2B90BD67C831EB56B4DD73F3F3FD8D29D662536CEBC5DB4F47
      17DC90DA948ADC81E14DDD5EA4E2DA2A7AC3D017D4010F04A19037EF8224E6AA
      E8C21A0A2AA5816D6EED54E9DAEA69ECFBD2839E227CF7D58D3B789D4542F08F
      0A8FBC3E35FA1C3489E4E73F3E2CFE75E74D671796D0309734F195775448ED15
      7D9834ED9C7B5E302FDF5F73FEA2A5332B0370A54E6244C0F13507DA8F921B4C
      AE48B3E71865DF98366BD402C2717BF7576B72958E25D5E5DDB239A30EAE74D4
      5DE74DD7EA2CDA6C9D94C58FF92C520F4F8F4E9F794BEF280A8CA08D86ACF142
      DD558B64372E6D50457AFC17F5A8610969AE452483FF17536526422B50F5630C
      F781C042DA48D892970E994624F5B2E2951CAB3E8A0C8C4C9D2AF0037545383F
      FE0F7582B14315A584164D1D05C3A23CD4517D4A04156784B29D14A94AD49408
      55650A9C7EDF56A87F554A72F8FD81A99DE05D614A4A1484E195180E25412369
      780A3AC23DA2E8D67B30F71D9DD6B578EA47A631281FC7EAE3D93D251B846A2E
      ABD17867C40A17DBE843ED56CEFE43CAA578DC48404D6D9B36EE35593AB7044E
      4BBFA96E0D98EF762BE7684E62B9220E4356E5DB84146210A19231C38F538958
      5475486CD524B70F1A4872AE1A7A970C49F193AA3BD447EEAA22851A05155261
      12AB6335C516B1BA21874F43A02D8A4D882F2619F58AFDF80315DB158A8CFA5A
      45C83D463556E0020AB751231F7323E3CF496120922F3331DA53688EF75EA643
      2FF42E99B5B5EB90A6790D804C058DA2560B8F73053FAE6361EC39AC1B757BCD
      F57EC46CFF77985E7236E17492726BB47636BBDD7AA14CD05142DDDA088583B7
      0B6F2798432F0974711C99CC0E95D4611038B22A1DA2E47F0EB5A87EC165CBEA
      738628A567D346E24733FC0997FDE10A7E033F8F5EB3674DA605278D8CEB4925
      599A1626A944B905E64B105F86D3829FC6B61C1EBE634A83F6F1E59E8555FB49
      FD248B70035CFCD8F485D5A1947A7E83BDC96F58E48D3FFB36B5BA30F05C1579
      B652AA5197D6AAAD8D4AD682DC6AE3545429310CC080C1E819FD963046884D0A
      0204A5EE0B69D6CE0693677224470124FA24CD75034DA8028AE549CA3525093F
      12DCF7A9B5866E056FA532EB742F3536EECFAF92B8F8F351303C1C26E1752BA7
      F7CBC170F89BF5737627ADB722BFB22EAFD29CEC448372BE73AF70D566F1D599
      D761B1DB78EC664CCEC23139D69FF6653ED9E7913CB26CF6F1C27397F6274FBE
      81E965A24DDC84B3BD2CFECBC1E9E96FD6BBD3F30B86AFB168E82AE577F660A5
      C5933B3E3A39B2043792CB2B44EAF294AC95332B23A5F5824916509435A25DDF
      61EDBB0A16556896A56E7C463F1515346A2BC9A189F16AF8C61C085B84E54A0A
      892C782BC774C32B05B99E72231405A13D6C107DAF534D7568682385EA1847EC
      4827795E8A7A1D29E7306BADD8EE3555E471411E3BCBBA5040527786B8541244
      8356524405635582D5FB34FA01AECFC9FB8F4726286D9A515000E546648C4859
      35A26DF18C3F9D1ED9B30069E3F96EDBAC0761B2621FB576A22ACF4A75CE8451
      BAF21E888C7A03360B74C8626AA71B279FF7DB09EFF48B09A498B3CAF496B251
      AF92896172556D8BD5A6B2CB762E7535C7F3717A7B67DD4AC148DDF59AB0E473
      3DE3E0202BAE46699A6D62494F510AD31D6C42458B4245DE730F156DBD48AACA
      B8F9FC4ADA272AF2C2E7AE7CEC4A70D53ADB6CB371BE74E3ACBC0D3B6B8315BF
      7067B5A0D3EE3B6A023F2D3EFCC47B86CA674722BBC64EA34C07037D9EC45634
      9DC019E5742055968D4D77435DB7E558D59CB5127A38666383CBAE55E06C98A6
      D75C905A588434A9BBBAB7B9A5D936410890E854803EF936755DE1962A57E974
      18D54C6AD55F9C175B1622195A370949028E0593BFCE9961A57DB991A85F628A
      6CA0D8170ACC16B4EE8DB8418615522C9DCAF2856983A70F924D0D0C6F9EDB2B
      3A29BE4A871CC9E0EAF7BF4D47130D41268A1293F7D9F1C2FAA293E50B4D7322
      B36B2338292B8E267B3CA6F3FB4F69326E25EAF8D60BE59E9F7372BB42B3A470
      8BFAF4CFFAF34F34F16335F10B9A38E58B11A2B6B0B8254804AF568533A953AB
      C9A02FA189E981C4412A5A6FD248DB482ECA0C9CD92394089CC13ABFAB26A788
      48144A2792CC780AD87154D81297985B1BE7ADF644327EC510FE663A607FD5F0
      7E78678514ACE1B98629B5612C0C37356984368E94D195904E2192507AF525A5
      058990CAFF6F55AB60A9BE1B13C6FF101FEB6E8EEDB4D0B65EBCE78639AAC08E
      0F6ED50767BA7B0E1925AA0E45C741A98DD1CFAA20F18D6998263F83FC09F506
      13C33DE32E32B942DCB9E92EF385268DBDEFED6F7046165A342DE8304E1157EC
      A03C9759B1A89F7388CF293DE2FE99C266C37CC186E96E36CCA20DF3EC7B986E
      BD783BBDA4638A37563C4C05E7D94CC8B065952EB224575D3BC9B419522AF876
      3CFDFDF7BBED7DEBE22AC9B9FA2793399DE9D29EA22292B9C7801E81CCD403F4
      23292241B9ACF2EF533164444DE8F9747AC9EAFECE3279FCDA05192623EA04AA
      329B4493B66BE134233047DCA24DB71DD70AEE0AB93B3F363E71CAF7ADB72A79
      96F3D0A90D1E553887AAD28BB366F9B65CF9383AD010C872026A562AC8C49F6C
      04CA130894CEBF7F232A2E2EE35F9B8A8E3FBB670D0D4134A66113D4F695D1B0
      33A9B697F6DA552AC1FEFEFEF657A4DD9750EB0990ED9BA0019103C1A0E83A95
      44611480DDC6E226B954292645262547395EFD9BB588AC2B5F4474D7646F90C3
      B960DD94FC51814DF6A9CD9710640654359014DE240966622EAA12935A6151B8
      5B8CEFF8043D4BA25A7B4F067418D10A91DC0A353E52A4823CFA19BB54C8C3BF
      B110E612504BFDA6BA2F73EC9C2566E369B28AA0B2855CC6D3A1291362AF6F04
      8E4AE03292C733A52498C254A2C16018731FE849D440D6931BA515453C2DA699
      DCE3B6606288D9DC8A3167CF88E1ADB8CBC96DBD21B2081DE2378D4EAD1DB97F
      B96FA90AC0771F9D4F0A7C166AE18EEC48F8A4F4C518171265876232E10BF5E2
      E8EC9C0A1A434F68CF32D5B123714DEE5CA6CBAEC6A989B165523D9E3C395A64
      9323577F3C055CE815F40CE587B3354B335085A866A72F9343F39B2BA8B65733
      39B45A821F9C7D38F9F0DD9BAF9E37BAF5A20AD3D11AD4F68BE0F2A29C49A916
      44ED2E5E0B5DF5C67530847102F5AD3A31923FAE8AD1B034D76A337152837E04
      AFDF34676E4D72F3299D2DB1135F76D9650EA7BB233991E348CC73C558AA5604
      7C1D35CCE5ED4E595FBC29F10DD89035A1DE80D4A847F193920E0DE45E9196F4
      98D9D83C3FA10AEE0CFEA208495090AD74D7786F1F6087ED293A987D44BCCA47
      6844D264681A1472778AA1C848AA4511D7138A5B184CDBDCC2AE46747CAFAB9B
      A807FC74423FB9DFBD551C9F4D556BBFE998526784E5BB01E8635E8D25FF9993
      8137DEDC971B5FCE7EC73AFEEBA7E3B393F7C71F2E0E4E37AEDD02D7CE7BF6AD
      D3B1E51A8850EC4A6D8B90BF4431560EFCE6AAA7F75C7ECA9E76F67483D211C9
      B811C52D95B7543354F03715D9108C6B04F5A6AC07C8876DF56BC8D5D95A6E6E
      B30C10B499EF38191057872434E1544D4353BD3D4909872A217C096877A9CB5F
      A87859EBFFED43EE8E48070FC75CC7BF5DF6EF6E658A5DAACD1A0EB48F4B49D7
      604D630B92A90EE1569A29A3342F0CC4AEEE9BAB3DF99114E39A15C61239973A
      A09F93DB7B4B22B99E48515E1C251155BDF217775C959ACB616CED501D1271C0
      D8AA4A4BF3D19E75785EA1B17006B476AACDB14A60A43FCD0186D809974694ED
      02E80B85E5A0F48F59650DD89435D18E4DD2B49439A85103A0C85E8D53D51503
      44A0DD3D924AE9F3E8D8E2AC0F916403D13C979A620A442657C63A4C1310F85A
      CA895A647A6EBE6B66C01B8CCAA66B2FBF4A681FD65FCF6FBF98A180EEB7AC0E
      A05EF1E59FBE3B3B52FE8514D9909A2169566A650208552996B3358D2492888D
      B7953727A3274357FDEA137F3BBDA47C5A3E7E53112A9DF9125EA54968AA0802
      A9C05C0C7E993201DB38DFAD171760E11FC70A448135840670A9D65F0B296523
      7FA253C1CC3A38FCFECCFA45351AECBABFD166395655F39F044BBDCA263DC79D
      FABB732E9F04713F4E58AF7029A5BA419BA978CDBEF55DA28295DA2C9FA8579A
      DC23823F6AE2B5502507B6B15A2B2DC9A2BD99F06279C4AA2A039493C02B6C2A
      F86FD36C889B387A9AC455E474429B5B413666925D52620E229F2A22511038AA
      5C944FF34B998B07F121646414AA71925AA93D1B720F8B6D8A4D9714E74A3C32
      8354E91AE9D0060AA524F59E12FCC3E45AA12D6C9FA9157C7952377CD4A9EF4B
      EB8CD57365A85851DADA42A78B32DB8327A2A413919692326F73AB9E6BC46700
      F0D12991467B916A39605C93900EF9AC5FE38AF1C6D09746527F482BC4CEB962
      EE7048F5652A12C32F066BAB6D5103AFB91291E27346B559BDA6D1C699FC6267
      D2DE9CA52FF61F5BD080F43B8A909D1B989A9DEFDE9F5FECAA7D4ADB9A119B4A
      3595A743CACB551DED538586936627477B1C975676482B05DB81CE69D24AF14C
      5E2A43BB84D0E3720E4506F69495A32BAC77746AA86EDEC8912790235FF544F0
      999F6A5DD4E3AEFA40870B4A47E26F69C6B4D326C5EA3C3C314C8A3B7D6C528B
      0505EC70D0F1B8CE56C31B75021A31FF68043376A321BF98B3BBFB1BCCA785FA
      B1058D7415E49F397E8A938C223E745453258940F9C19865BF834DFE67B8D40D
      910D55673B9B1CC9D9297212B018726811832A0475EF6AE33C29B654E2945075
      D8659ADD59DBDF27115C378AA6BC4F23EB3BAA17DB362D2EE1C30452035AB2DD
      D3C6796FBDE0B628A66129266A8C370BBAE40319818ABF29547B298B5A7C893E
      1BAB735470B760848AAA9F741B8951423E4F48BAA8FEAD9F447185854FDA5933
      778015E1FC82EDE998407FC7DB26A84F8E3307B754229CAEF0A0B36B6DD9C338
      68608C8C5AD99F74EBC5F97CB062679A6B8078E6F53D63E517A9955F27933D0A
      E4EB82D13D6B7F7F5797C384F514230E2F6E9F97418AEDBDF2B70FE958AAB3AE
      ED133ACF29AC7204DB6DA4A088285F81E63F55993CAA80C194D49A0AA0348E93
      90CEED34744D1BA7AAA2EF6F6AAA3064F5779BA5943561208D61A1D6AA6B573D
      54D76C940D6454BC2AC948F450FCD69C2A09C3873B9CE2A5E8BBCB8CA44FDEB4
      07A078919FD64622C3FE9319E1FD14B7525C57679692B25E927CA495AE4A9AAA
      418A8543FAA83C606BE3D4B50A8E4BF64AEE1D796EBF9D26C3A80AEA43E5AA03
      5C121FD60E36636EFD7D4A4717C20A54C6343E6B72CEA9C1C820F243A9BA0190
      85B7BB6F1D70FB108ECE96B93D118498EED28E9951785B8F27B2DEDE6D33CF96
      35803A005BB5742DEBE52A10A4ACBA9FDA479529576D067C7A5F09413A921193
      C990CECB75C72895C164EA50C2240BA723B29AC39646FEE7E3FA5C469CA5B726
      6296358175A4DCD49CB233CB3C5C8E33523525B5E4E3DCAEF284EC36AF0A03B9
      30C0C4D914D02BE7962A00BA911CA5FBD6795A2663928923459E701403766A1E
      66C904B29780BCD3F4BA95C283CE1DEFA85EE2D23A7979C3A5B797291F788880
      34D25F3625815F1CA4D9D4372D0CD23CFB3659B34718248D55BD6C54CB50834C
      6827D0DC3B736ACCF5F9640F7EA2BC20CE883B4CC791C694E2DE2E50A711CF5A
      156AB73342530660726B87DD0D25E058010C0594EB736C66D7C81335676CB57C
      BDFB2EA7320F77794155B6F86B8586C339E3C2DA2F64EE92F22C5B4B70754899
      F192D366985030837885E33622D7992C25FAA8B5A3FD36F5D96A2F8613262622
      D7077F1A0EA004816DE5927C328677C6F9F6DCF8AB5E4D4CD45701D18AC2BA79
      541518BD84A9DC40F38A2E04763EB4BD01FE26DBE5E98EAAEE8BDB59C26A82F6
      ECC160E0F44D6FDF7FFCD7AF7FFA95328E64240A61791D37E8381DB7EB763A1D
      1FFFF55576950D95220791ECC4411CC73AE32AECD8FCAFA37EF702D7F1635FF6
      5CDFA3BFBDD8737B835EC7F77A8E17D9B2D7F7233F14E1A01B06AE0C1DA7D3ED
      E0A29EDB8FC3BE233D3B72C5D68B4118D87879DFF6E4A06F87BDBE0C7BC2EE85
      6127EC0F06B6DBF5C341D40F6CD1F33C0CA6E78691EDB9AE2DFA76A7EBFBA11D
      4603C7897B03E904D2E9D941D48D3BBDC00B9D417F108A9E2B441CDBAE6DE335
      32E8066ECF8B8417C54ECF8DA38188B65E787E7FD0EF7645B7EF847E57789D78
      D08FDD40043208EDBED3EBF7FA1D170F1B08CF165E2F903EE6887104B613F5E5
      A0D3B3BBF1A023DCC88E85D3EFD861E0783DDFF6FB9D380239651861E8DD28EC
      F66580A7749DBE74C281EB443DE9759CC0DF7A1174BA91D7772229A5170F4006
      57DA834E803138B1E3BB5284AE709D4EBFEF044ED81980703214FD78E082365D
      1F73C3AFC1C0EEC59E2D856BE32DA21B46DE2004A5E24177107464DF93BE8765
      E93A9EE847D2EEC47627E8875D3B7482CED60B22B61787B10FF58EFD16493F88
      9D6020FB030C3F887C6FE087411861BE81DD97BDD0F13D19861846378EBBAEDF
      893D2796FDAE133961886104BD58F14A4CDC037E7988CFB01AA081E8E1B1EAC3
      0EAC9C2EFF10684E8B7B36782CEC39760CBED23FF78991625F106761FC3D19F7
      BD200219BBBD08F4C6CCBAE02AAC442CBC41C77568797A1116A46BF77BB1DFB7
      ED6E10812324FE76E3AD172196B52382007406B9651CF7C4C0896229643F8807
      B23B702551C71F08213A7EE848DB05E38581DF97DD9EEF4460CE181C3CE87BC2
      153DDBEB6038609E4EDFC77BF18E801838F43A5157382053E474BB81F0DC7EE0
      3B9D81D7B5B10A71BF1F0D5CBACA16D2B57D37EA62853B918D017951E0B8BE6D
      BBBD58F406DD5ED78BA31E38AF4F4393A0197686137B5D1F1BABE7F43015D98F
      453F1CC431B806340AC38174E3B08BFB633B949E8B45F1B16506AE1BFAF8CAC7
      084417FB2A968EE7041178BAEF7B42446E57469DC00BC071911F476A6D9AACAC
      1FF40603BFEBF7B5C4E88B5292F01F480EBC0152C2B363F5F3D68BFA6FF4B31B
      E10112FFF520576C23553099D08D3A587B9BA40AD6B417896EAF37E8401A6031
      02B0A9EBF9D8F461206410C41899EB0CC2AE70BB902FA0E820065F63074AA7EF
      38BD5046E0636C9960EB05E6831FB09061A7D789FAC2F7207264BF4F4CDD83BC
      113DAC5B3F126EBF1B62A1423F947866171B4C0E7AFD2E281EB87D6CB4287607
      604BC7C3D8202AC083E08C28F0A2C8EE447EE04154797657622DA2C893D8BF2E
      1805A20E23E8793DD9C76A427883CBF025268205EDD84E7F1DFABBB21BBB9DA8
      C79C4D5F055D5E81AEBF8CFEEAE7AD17D56F4ED7D05C869028719F768BDF7503
      498CE4C49D7E1441B805812F5DBC2D08C2B03BF025AE1F0498A91BBAAE74455F
      FAD8033ED6ACE743946177F62059312797B68A1D76F16FE4E0720712318AC107
      D827D8657839F6700C7205D80CFEC073426CC6A8837B1D6F3080400F7B510415
      6043D6D9D87D5D0FD255C678C600322C825489C3C8ED0F7A228EC24E2C063DAF
      EF62CD413470F760D0B3A533C016F604B6633718383E5616138C6937F604B6B0
      F0A170BA21B8C9715D6FD07707C44D36A42D8613459DD889837E3FECF9BD3EF4
      84E3877DACF780247447F8DDA8D7716414D890D303BCA1130A0774B207205FA7
      1FCB01C40D0603A6B4A574FC41AFDBC5153EC8DA051F44B66F47F84C88D0EB76
      A047212B20B5DCBE4D726B00B1D1A5ED15D81DB02824171605DAAD23E831D8E9
      6E085116FABD4842BBF94117D4840291365488EB421DF67BD80FD0E218B8E3FB
      D1A0EF43EDF6650762CC9141CF866EEC8BAEDD91BDD87165E4F91E584986D226
      3D65DB11547B1F1A328A7D5B40F00EBC5E18435E41D5436DC6781DF885C4660C
      713B804C94D88883C883B10035070AE2CE10AC8E658A7C015121629A53C771BB
      020C213CC78689158830C6B619F47A8E236081805FE2AE004B839106B020B0C7
      1C3B88A54D14093DE8ACB8EF93CA1EB858F2009F422DC830EEF5B086505C6E00
      C12CE21E4C970E3616CC05CC062B41EC137A305DB0CBA123A1427AA0EC00160A
      3E8028B4FBFD41479202E94BAF27A2B81F62FF4A7FD0E90C48BEBB58FFD0C1ED
      90F3602A90B2EFF56D68A73ED82970A18C7C301858DBC77A4180843D89CD8F4D
      E80E400A287C1B464EEC13174110789DD073A48006E8F6B75E741D8C24C67282
      B001B6575F786467D0A20CE4C0194015F4F1F8D8EB81A3602FBB10DFD07D90D6
      7DBBDB837020B6C65EEBC6A01288E493C00717630C1D5A0FBBE3C79E8C4139C8
      30904006129AA78FD5707B507DE1D60B2724F50CE50BE51FB96066C8AF3EEC34
      31F045EC41A160ECB1C466136210834D62EC4188D618374305B9B00CE35062A7
      F4C02C5140B70C44BF0B416B7BA427F1D0185E6C3FEEE225FC9B033B087F4171
      415978D80BD83CD0BB3045B111B032B617856082081BA44B462028D5E9F75CD0
      1D1218638E2099A117C0E730EFA03B410417BA360C610E74A0D43D5CE60734D1
      4ED7ED92D50A76866A85CCECC02A824A268334C2B06077C51056E0837E087B28
      ECC2D0C4B321542040FB2104BDDF0FFAB038022C378C2C8C05E65D1F8C8DE143
      E1763D68892872413B98BD2E4C82D8C6E68114838CEAC0341E40A878612C6004
      FA903E64C1F525CCC7BEC083421B8AA90B5B2C74210FFA41077669D08774EE41
      C1D81D012BD7863514DAD02CB8C6C73D584EA87A8C2EC4DC8527601D4403881E
      2CBE0D1BBC8BA18590A75DC8BD3E34A5D71D38A497441FCAA5E7DA6E4442B48F
      3D0803D6017F8490D59844E40C2013C9CC8584B0FB02EF8240EDD183DDD086D1
      0205894FB111456780A5C0AA83E7C15D3D5069E0606C2EEC37A70F56B3050951
      301DE41B0C2D98BF5ED4771D810D0F2D127524AEC49C21B46C482C58A0507730
      95A1A8611F74637218603849DACFCCEEB47560C9E03FF03BC60C05019117C11A
      E8F4609D466E8471467D1B3BD31DC4429261E2423A791EBC8300AA12562C38C3
      818D280549331FC20ED61C0435CC3798E1834E57E279B1EB602F80425D01BD1C
      6091603B423AE247C86048B8180218B2CC033BB81E76A54B5B0DBA017B2692E0
      F8D08F4347601903F0B9B41D88AC18FA06DC816163F0D8A551E07B8183BD0191
      2725368CED47D85A31791EC4343146206507BFC16E867056D217B21B025A7A98
      04D42174563C8861176140BD10CFEE42D8D8019E87BDE30ABF8735EB40E70D60
      AE9342805108D1D5096447F4E03C387E17D67B04CF077C03E185DD86E7C676D7
      C106E8F47C4824AC5D00690D3E1E40CD6075B16D1DBA1297421461A078A21FC3
      FDC5D611781B5C21AC5F24E4C0870487EE1DC0A383F880E315C3F909486B4360
      C0E0C206847A04DF7A01394D3D9826031B9383158A9DD2EBB8D0DFD04C513080
      ED03E238D8406E2724EB099B0932161632D408A4133C19EC78E8250879B06207
      6603288FB707E0D8C8834D44AC0A910B01032F8BBC49729D60C9F4E05C0E60C9
      7521F3858779631E03D248411486B0CC43495E1B4C1D183CBEDFF145D7038BC2
      0C80E0F6C828854D049D0C1D0A0120A0DBB1DF3D0726BA87FD890D09F6875584
      21C3D0F0C180AEDBF1619D7AD03BF042616CF7232C1CFC467CEA413141CC4395
      439D62AF4193E3318E8711C4F062611CE34A78767D012B093304A5403C0C1FA6
      000822028C8DEE8218F46143F5F03A3024643D34811458CE2E940279033DECAA
      1062DAF5B159A51FC7FD18FA066E2E7E833E854703EA827AF6C01130C423F21B
      C115B08D4216C830764065B88990992E4C55417BD3F668F7847D6C241FB68183
      A582BE917081B036F84AFAD85330E42097BC5EE408129270ECE0E1F4886DC400
      8FED438D9075DD833D0E7684BCEDC179EF918D8155208F16A286342076BF0D87
      59604CD01A4ED7C57325EC0F7B00B1EAC35881028730869183ED0DE70C06651F
      6B05120F62BB17C2F971A197BBDD41D401D1C9D5853AC35868CED2839E854819
      782108055303E4EE841D8C0052C41EC01CC532773DD771E1C9C3C7C612615D60
      93F9A1201B0D3E59847D0E5B0F9C46DE39447E0495447477E1DAC1CF18380E7C
      8100FA4ED8602D7827105210EE41B70383053ADE83288AB00E410F5B83221420
      990BAF2D22EBA503B13C88E1197990761819648AE806F0566137907CE804A10D
      5BC9B5031881D05651AF077319C2193E2F240E966C40211CB256821E046417EC
      0B4D033DC391117824A03F3C297884981CD612038969E26427E2955020F02BFD
      A80FDB15DE928BAB61DFD8301AB002BE0B87B61B823C9081B0926143F47A901F
      F8C0C7DAC3BC09E1A57AE05FB86450FC5817EC72E85749C3841D0727A4DB1B84
      3CFF28803EA2C0166810918A8BC08910C221A4395C024809702C461A763BF077
      824E8C89DB831E64B323C905242B0ADA2D92D8C0303968AFC1E78571E40FA006
      C13BD87FB0D802E9C14D84D94A410722F780585B427A63D9E03BD1A681DF13B9
      3402F00126E8433160C5448CB5804101B307561A8430883F8884F06209D1E308
      3CB987FD457E35B8080E3E480EAD206033F94461AC9107C111402EF5B045E1C6
      E3330819F030B801F3272503B60443F910B3210C29D8C0F01B61D740C3E23E98
      3C504B180168D8D45BEC40680D3A031AADF2D203E569DABD87BDC52A3A03DDB8
      D2739F8DDFB00F4F5609360676B4DDA37049EC438204823C1EF053D4EFE3226C
      1D7294A4EBC0312407096E7117BE480437913C9A3ECC2B8832C8033918C0B80D
      063DD880031867D854918460C25E0637401BE102D8F603F818D0537D589DB001
      E1884303F407D1C0812A08409A3E04800FF92AA32E4C98011C5EBBEF9243E6C2
      F5C1DB1C98E13D6C3A1B0A1526386C1458E56E0C1B091B0A0EA68035054FC7B5
      6DE10898F1F0DD8208CA0B8E08762D641B85E560EEC24E0517FB5800E8776891
      2E86EFC1A5A0A80DC8003BAC3FF0C19F5093F0BFB0C03057214A6032928C1214
      7E08B1CD60CC09DAE96E088FC5033B81C361F6A8959B597DE8763BA2FAD9F523
      BE0FFDA9478361A52D8D07AF1A0345031F8A052EFAE374D435B39C5871DAAA77
      AE8A532DFA83AD623FB42BEA3194C53B61D5A856456F16FD814E2A4785555830
      AE45919D5523592519168E04DBF721FAD463BACD65068FD4EB5414F0D47F9E8E
      8A85614798AFFEB1F5820E3BC27498667948471E238DEF05AF32D64F869CA637
      F51C8856702F7C2A9BE802F7CF86578C0DEC1357BBF816AE257DEB41DDBBF03A
      9D3E5D017FDFE511D3DF213D0174C555BD01713D9E05B31E76A7A093058801C8
      EA1EDC07F262605374D418B0571C7C47FE1C1C809E8BFF756061C53605291C4D
      19EC793847718FC7A4EFF37DA2217DE7EA6F6D9214F0B36C7CD65363E659C290
      73B04BE01AC674BD3FA01DCA33C41D8E7A33CC1ACC9CE6E4C2B4529FB97EA03E
      E3EBECF23ABBBCCE2EAFE3CFF06C1A339F07E967CC7C525DC3DC499FD9F7AEBA
      FF24E7DE35CEBD6BDC7BD7B8F7AEF1EE5DE3DDBBC6BF778DCFD7F44171A268A0
      D6C9FCC6DF6125FCD09DBD62EE335C075ED03C49E7D9E3222FEE8632FF759847
      79918CC467A7E7D12FC334BC965124E30E7F2547C9155729984FA663820BA174
      66F3C9DF55B2A0F975922569961477F87D30F8AFEA91AA03B855BBA36BD5AFEF
      58D5B51DEB03A3B2FF65E9D58399ABAFA43A34EDFE65EBC5ECB0D55DD5A0BBCB
      07B0F891F65F9EF881CE533FD07DFA497B4F3D46FFA91FD87BFA49F79F7A8C83
      460F347725D8629F1B73F0EC5DCD9874F69E667C387B8FFB887BBC47CDA819C3
      CCDED37BC43DCD167DF69E41C31919EE7066D9A348432CF3173EA0D98A3FF000
      E7CB27D18C1B1E78403331F3C003FC2F9F4433A679E001CD38E88107AC272694
      62B44EC604FAB2E6D68AD3B418A785CA6F5EEBAD628CFB349CF1BAF7923894D9
      5AB7D04071CB63048716BE8F97E58E37F3D450704BF5B5865F708D421A5B7172
      39CD64BEE644E4F8460ED349096ABAD6BBCB9B33594CB3F5C65DF247593AF158
      26A91EB0DED439B55E2105ACF5EA89B87CD47DB06BBF60C2E66EDE12EB4DB464
      11312DAE88EF12B9DE3A8F4498A5EB71652AD6DA1DE6BED3245F7776748BF576
      3A1CCAF54405DFF761FD65E4FBD63382F896A64A70E6A6F58C20BEA599A25B40
      BDC74C4ADFF9A8B9E97B1F31457DE72366AAD6FB3133D5773E6AA6FADE47CC54
      DFE92D774EBBB3BEEC45520CD7132C87C394AAE5D69CD7797239168454BF9645
      32FB8C239511CCE9FE9799985C59EFD2F17A9BF86D1ADD5917EB5A09E55D8F33
      6D7865A82343329EAE47EB993B1FC385E5BDEB7954B3F73675E217DFBDDEAE7B
      AF5B6F7E5F19668BD9788EBDA641B136279F8BE154D9046B4EF04814EBBDA962
      A0770C97A2D9E8CB1FB1264F7C208BE07BAD67D79B73F5FEF55E59DDB71E0BCE
      EFB947BF56DFBEAE207E4B3FAC2F2ABEBF234CB4647CBDD65DEF52028B94D1EC
      DD0B19DFB66779B8A05A7C3DB7C537CC0AFCE3D1E44AE4C97A06DD511A4EB95F
      C77B3159EBC64F54EEB23E158F5F8DA87975A534D65BBBEF2FDE9F5A17E9846C
      58C2E05B6F05E9E6B754493A7AD4FDDA09DEF95906BBEBBFF80096F3F86EF498
      091F3CC223E31B0F9335C599BA2B8D1E71D75189AAFF9829FE20EF825464D1FA
      EFFD042F8A3747211F71F7B9A0FAC1F5EFA30AC55B6CC2B5E3057CF74F224BC8
      157BACA39B4F83BFC970BD9DF721553ED53AF77C54C5CF4AEFAF1B249EB9793D
      193F73EB9ADA85D079D39A645A1203BB6057984090964CAB26E842494DC2617D
      970F5D6CB9CCD3FB7C2242E3F79A8BFC59A17DCA5DACCEAF2A07B9BC70DEF4A2
      0BCB152CAFB2175C559B55799D33678C45C97464DEAB03C3E5B5EE43D7DAB3D7
      7A8BAED5FC3273A1BFF4C2B927F6165D48539A7F627FE985F6FCEC074B2F7566
      9ED99B5D9D23915DDFA7796FCE6DA2C376EA07B668157BF6E26BEF3FD4597C21
      AF655306829209499977E7E7BF8C97AA1B1A31D592CB1FE6AD25373DCC644B6E
      7A80DBE6E7BE6C3F9FC99B2437B1D5C5B158776EFA79CD337DC07E9B65B2FF98
      A65AF92E7EC9EC329E8C0B39CE65EDAE261B67E97A3FB0879650F681CDB4E48E
      07F6D4E23B966DAE25573FBCCB964DFDA10DB7E4450FECBC25536FB005ED66C2
      7CC9E5AB36E03D01D76C0BDA8FD982CD05FE923B1A30F0BDF93460607B6D06B6
      D766607B2D06B61FC3C0F3536FC2C0F6DA0C6CAFCDC0CE7A0CECACC7C0CEE318
      D8790C033B6B33B0B33603DF9B4F030676D66660676D066E66DE2CB9BA1903CF
      4FBD09033B6B33B0B33603BBEB31B0BB1E03BB8F6360F7310CECAECDC0EEDA0C
      7C6F3E0D18D85D9B81DDB519D85D8B81DDC730F0FCD49B30B0BB3603BB6B33B0
      B71E037BEB31B0F73806F61EC3C0DEDA0CECADCDC0F7E6D38081BDB519D85B9B
      81BDB518D87B0C03CF4FBD09037B6B33B0B73603FBEB31B0BF1E03FB8F6360FF
      310CECAFCDC0FEDA0C7C6F3E0D18D85F9B81FDB519D85F8B81FDC730F0FCD49B
      30B0BF3603FB0F84EE66E940878E43397BA2B2D8E79F9D9FF1E2CB1B1F38BD71
      EE9F730EA91D4F3D2568F18DF6C27736B97396486FD3F47A8D3481F229B37CF9
      36098649CAB191BB2F498F9E8FCF7E3C2CCF33EB97B90B8FA138983BEBA4BBF6
      D20B679D21D7597AE1ACD1E9BA4B2F9C37215C6FE9A5B362D49DDD4ECCAEEA3A
      1678B3D7FACBAEED2EBABAB7ECEAB9E9F7975D3737FBC1B2EBE627EF2D9D93C7
      F262E6B15E77D9C57EB98B676FB097DDD05B7CC34AB22D0EF23C40BF65B1A707
      48B9E41DCB69BAF88655A45D7257031A2F9B5313722F995C53BADBEBD2BD3103
      2F8BB134A0BBFD28BADB8FA6BBBD36932F9D5C53BA3BEBD2DD5997EE8D25C8B2
      584253BA3B8FA6BBF368BA3B8FE3F67BAA6235DDDD75E9EEAE4B77F751DC7E4F
      F0AF4177F7D174771F47776F5D6E9FF7AA1AD0DD5B97EEDEA3E8EE3D9ADBE7E7
      B40EDDBDC7D1DD5F97EEFEBADC3EEF3D34A0BBFF28BAFB8FA6BBFF686EBF37B9
      59BAB347D4D808AC5DFDA00EAD5DF7A008AF5DF7A004A95DA74DC0070547EDF2
      664660ED866646E07DB2353202EBF45B72C372422EB51A97D3B49111788FB88D
      8CC085345E726703622F9D5C53BA3F68042EA27B63065E72C36AAACF1B564DE9
      FEA011F820DD1F34021FA4BBFD386E9FB7B71AD0FD41237011DD1B4B90252659
      43AADF331DD7A0FB8346E083747FD0085C4E77775D6EBF6735AEA6FB8346E022
      BAAF27C297DCB506D5EF998F6BD0FD41237039DD1F340217D1DD5B97DBEF598D
      ABE9FEA011B894EE0F1A810FD2DD7B34B7DF9B5C53BA3F68042EA2FB8346E022
      BAFBEB72FBBC61D594EE0F1A810FD2FD4123F041BAAF874BF01EB7AC9F867D3E
      1259F1C82A87EF457E5588F50A3C7F1C67324F87D4EEC30CF81FDCA9819A34E4
      057543E97419EBA8A3F09D3A9DAEC667DA7AE112DC3B230239B62D3DC7ED7A7D
      AFEF466EE8116A52D777159692E313AED1C23FBE7A52D409E36E57764437E876
      85EC2E4777527F1CC22FC6236319C78CF6B40C99AA3BF7EFDC17747F5CA28EDD
      FFBDFCFC0FFC43689AFFBC7F36B3FFE7FDB360F691FE577EDD917C8B3F9BB5FF
      E7FDB399FDC37F3CD81A7EACFEEBB9CAF4706185F852FDDEC307BDC12A2BE1F1
      7F18E9D25BAEF73BA12FA241BF3FB0E36E44E0D4BE8791BA9D81EFD85E577ACB
      9E6B77DCFED68B81DF271057184A9DEE328BE3B9FC594A8147FED97AF194A3FB
      1A7F9E9202ED9B3DFD792A0A3C62F6C6F7D07FFEF18FFF07271B4E41}
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
