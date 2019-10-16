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
              's and plugins in their correct load order. By navigating that tr' +
              'eeview you can look at every single record in any of your master' +
              's or plugins. Once a record has been selected the detailed conte' +
              'nts of that record is shown on the right side.'
            ''
            
              'The view treeview shows all versions of the selected record from' +
              ' all plugins which contain it. The left most column is the maste' +
              'r. The right most column is the plugin that "wins". This is the ' +
              'version of the record that the game sees.'
            ''
            
              'The navigation and view treeview use the same color coding to si' +
              'gnal the conflict state of individual fields (in the view treevi' +
              'ew) and the record overall (in the navigation treeview).'
            ''
            
              'Previously colors were listed by background and text color. Inst' +
              'ead, click the Legend button in the upper right corner. The Lege' +
              'nd window will summarizes the meaning of the colors.'
            ''
            
              'Conflict detection is not simply based on the existence of multi' +
              'ple records for the same FormID in different plugins but instead' +
              ' performs a comparison of the parsed subrecord data.'
            ''
            
              'The navigation treeview has a context menu where you can activat' +
              'e filtering. Filtering is based on the same conflict categorizat' +
              'ion as the background and text color.'
            ''
            'Command Line Switches:'
            ''
            
              '-cp:<codepage> or -cp-trans:<codepage> [sets codepage for transl' +
              'atable strings to codepage number or utf8]'
            
              '-l:<language> [Sets language, affects used codepage and .strings' +
              ' files]'
            '-edit [Enable Edit Mode]'
            '-view [Enable View Mode]'
            '-saves [Enable Saves Mode / View Mode Only]'
            
              '-IgnoreESL [Will load all modules as full modules, even if ESL f' +
              'lagged]'
            
              '-PseudoESL [xEdit will check if the module falls within ESL cons' +
              'traints (not containing new records with ObjectIDs > $FFF) and l' +
              'oad the file like an ESL (mapped into the FE xxx namespace) if p' +
              'ossible]'
            '-DontCache [Completely disables ref caching]'
            
              '-DontCacheLoad [Don'#39't load cache files if present, but save if p' +
              'ossible]'
            '-DontCacheSave [Don'#39't save cache files after building refs]'
            
              '-AllowDirectSaves:<filename list> [File may be an .esm, .esl, or' +
              ' .esp. Without a list of files, this will load non-official (off' +
              'icial = game master, official dlcs, CCs) modules without using m' +
              'emory mapped files. Optionally you can specify a list of files. ' +
              'Which will only load the listed modules without using memory map' +
              'ped files. This optional list may include official modules.]'
            
              '-<gamemode> [Specifies which game mode to use. <gamemode> can be' +
              ' any of the following: '#39'tes5vr'#39', '#39'fo4vr'#39', '#39'tes4'#39', '#39'tes5'#39', '#39'ender' +
              'al'#39', '#39'sse'#39', '#39'fo3'#39', '#39'fnv'#39', '#39'fo4'#39', '#39'fo76'#39']'
            
              '-moprofile:<profilename> Opens the plugin selection from the MO ' +
              'profile named in the switch.'
            '-setesm [Set ESM flag. Plugin selection screen will appear.]'
            
              '-clearesm [Remove ESM flag. Plugin selection screen will appear.' +
              ']'
            
              '-VeryQuickShowConflicts [loads all modules according to plugins.' +
              'txt without showing module selection, except if CTRL is pressed ' +
              'on start]'
            '-quickclean [cleans and prompts to save the file]'
            '-quickautoclean [Cleans 3 times and saves in between each step]'
            '-C:<path> [path to use for cache files]'
            '-S:<path> [Path to look for scripts]'
            '-T:<path> [Temporary Directory]'
            '-D:<path> [Specify a Data Directory]'
            '-O:<path> [Specify path for generated LOD files]'
            '-I:<path> [Game INI Files]'
            '-G:<path> [Save Game Path]'
            '-P:<path><filename> [Custom Plugins.txt file]'
            '-B:<path> [Backups path i.e. Edit Backups\]'
            '-R:<path><filename> [Custom xEdit Log Filename]'
            'All path parameters must be specified with trailing backslash.'
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
              'ach record that is contained in more than one mod of the modgrou' +
              'p, only the last (in load order) is visible. That'#39's it. The invi' +
              'sible record versions simply don'#39't participate in the normal con' +
              'flict detection mechanisms at all.'
            ''
            
              'A modgroup does not perform any merge or make any changes to any' +
              ' mod. All it does it hide away version of records that you'#39've st' +
              'ated (by defining the modgroup) that you'#39've already checked them' +
              ' against each other and the hidden record is simply irrelevant.'
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
              ' modgroup is only available if the module has one of the listed ' +
              'CRCs. Source means that if a record in this mod is found, then i' +
              't will hide the versions of the same record from all mods listed' +
              ' above it that are targets.'
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
              ' in the selection list. Mod groups for which less then 2 plugins' +
              ' are currently active are filtered. If the load order of plugins' +
              ' doesn'#39't match the order in the mod group it is also filtered.'
            ''
            'What'#39's the effect of having a mod group active?'
            ''
            
              'When a record for the view treeview is generated and multiple fi' +
              'les of the same mod group modify this record, then only the newe' +
              'st of the files in that modgroup will be shown. So instead of se' +
              'eing 5 different files with numerous conflicts you are only seei' +
              'ng the newest file in that mod group. This also affects conflict' +
              ' classification.'
            ''
            
              'It'#39's worth pointing out here that if a record is overridden by b' +
              'oth plugins in a mod group and other plugins that normal conflic' +
              't detection will still work perfectly.'
            ''
            
              'Basically this system can be used to reduce a lot of noise from ' +
              'the conflict reports.'
            ''
            'Reference Caching:'
            ''
            '[GameMode]\Data\FO4Edit Cache'
            ''
            
              'Cache files are based on the CRC of the xEdit EXE, then the plug' +
              'in filename. For example 3917E178_DLCNukaWorld_esm_43D25C56.refc' +
              'ache. Once built xEdit will load the cache file rather then buil' +
              'd the references again. This reduces load time.'
            ''
            'xEdit Backup Files:'
            ''
            '[GameMode]\Data\FO4Edit Backups'
            ''
            
              'Backups are saved with the file name [PluginName].[esm/esp/els].' +
              'backup.[Date Stamp} For example PluginName.esp.backup.2018_07_25' +
              '_20_52_10. These can be renamed and copied to the Data folder.'
            ''
            'Show Only Master and Leafs:'
            ''
            
              'What this does is, similar to modgroups, reduce which records ar' +
              'e being show in the view treeview (and are taken into account fo' +
              'r calculating conflict information).'
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
              'C will be shown. The assumption here being that whatever the con' +
              'tents of A or B, it'#39's already being taken into account by D and/' +
              'or E.'
            ''
            
              'This assumption is obviously only true if the author of mods D a' +
              'nd E did their job correctly, so this isn'#39't a good option to hav' +
              'e always enabled. As long as that assumption holds true, it can ' +
              'declutter the reported conflicts significantly.'
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
      Tag = 1
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
      Left = 805
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
      Left = 835
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
    object lblPath: TEdit
      AlignWithMargins = True
      Left = 30
      Top = 5
      Width = 769
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
    object pnlBtn: TPanel
      AlignWithMargins = True
      Left = 866
      Top = 3
      Width = 495
      Height = 24
      Align = alRight
      AutoSize = True
      BevelEdges = []
      BevelOuter = bvNone
      PopupMenu = pmuBtnMenu
      TabOrder = 1
      object bnPayPal: TSpeedButton
        AlignWithMargins = True
        Left = 442
        Top = 0
        Width = 52
        Height = 24
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'PayPal'
        Flat = True
        Glyph.Data = {
          76030000424D760300000000000036000000280000000D000000100000000100
          2000000000004003000000000000000000000000000000000000000000000000
          0000000000003E3829446C5C38766959357425231E2700000000000000000000
          0000000000000000000000000000000000000101010102020202856A2E93DC9B
          01FDDC9B01FD6C592E7800000000000000000000000000000000000000000000
          00004F392D715D3723945E392595A26915D8DD9B01FEDE9C01FF90712AA00101
          01010000000000000000000000000000000000000000764A33B8843000FE8430
          00FEA55801FEDD9C00FFDE9C01FFAB7D13C30606060600000000000000000000
          00000000000000000000543E3276843000FE853000FF984800FFDD9C01FFDE9C
          01FFC88D04E6443E2D4A2B27202E1E1D1A1F0404040400000000000000003F33
          2E51822F00FB853000FF8D3900FFDC9A01FFDE9C01FFDD9B01FED59600F6D293
          00F2C78B02E5846726951A1A181C000000002723212F7E2D00F3853000FF842F
          00FFD69401FFDE9C01FFDE9C01FFDE9C01FFDE9C01FFDE9C01FFDB9B00FD9E76
          1AB40A0A0A0B17161519762A00E4853000FF842F00FF863C02FF924C02FF944D
          02FFA05A02FFBF7B02FFDC9A00FFDE9C01FFD79701F7473F2D4D0A09090A6F2E
          0ECB853000FF853000FF722501FF692002FF692002FF692002FF681F02FF8840
          02FFD69401FFDD9B01FE8E73359D03030303693820B0843000FE853000FF7727
          01FF692002FF692002FF692002FF692002FF681F02FF904902FFDD9B01FFBD93
          35D4000000005C3D2E8B843000FE853000FF7A2900FF692002FF692002FF6920
          02FF692002FF692002FF681F02FFC58301FB705E347C000000004B393166832F
          00FD853000FF7F2C00FF681F02FF692002FF692002FF692002FF692002FF681F
          02FE7E5222BC1313121400000000352D2944812E00FA853000FF842F00FF7D2B
          00FF7D2B00FF7D2B00FF7D2B00FF7D2B00FF7F2D00FE60443789000000000000
          00002522212A7D2D00F2853000FF853000FF853000FF853000FF853000FF8530
          00FF853000FF822E00FC45352D5F000000000000000011101012732903DC8530
          00FF853000FF853000FF853000FF853000FF843000FE812E00F9683015B81313
          1215000000000000000003030303593C2E84744228BB734127BD734127BB7342
          27BC754429C0704834AB43342E5A0F0E0E100000000000000000}
        OnClick = bnPayPalClick
      end
      object bnPatreon: TSpeedButton
        AlignWithMargins = True
        Left = 332
        Top = 0
        Width = 58
        Height = 24
        Hint = 
          'Patreon is now live! Please support further ongoing xEdit develo' +
          'pment.'
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Constraints.MaxWidth = 58
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
      object bnNexusMods: TSpeedButton
        AlignWithMargins = True
        Left = 128
        Top = 0
        Width = 76
        Height = 24
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Constraints.MaxWidth = 76
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
      object bnKoFi: TSpeedButton
        AlignWithMargins = True
        Left = 392
        Top = 0
        Width = 48
        Height = 24
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Constraints.MaxWidth = 48
        Caption = 'Ko-Fi'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000030301182F2715736A5930B59C8247D39D8347D46A59
          30B5302815730303011900000000000000000000000000000000000000000000
          00000000000230281671B09350F0BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
          57FFBF9F57FFB09350F032291672000000030000000000000000000000000000
          00024C3F2297BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
          57FFBF9F57FFBF9F57FFBF9F57FF4F41249A0000000300000000000000003129
          1672BF9F57FFC6A96AFFC9AE71FFC9AE71FFC9AE71FFC9AE71FFC9AE71FFC8AC
          6FFFC0A15BFFBF9F57FFBF9F57FFBF9F57FF332A17740000000003030118B193
          50F1D5C193FFFDFDFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
          FEFFF1EADBFFC0A15CFFBF9F57FFBF9F57FFB29451F2030301192F271573BF9F
          57FFE2D4B4FFFFFFFFFFFFFFFFFFFEFEFFFFCBCBFFFFEBEBFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFD5C193FFC5A867FFBF9F57FFBF9F57FF2D2615756B5931B6BF9F
          57FFE5D8BBFFFFFFFFFFFEFEFFFFBBBBFFFF6161FFFF7171FFFFE6E6FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFDFCFFE3D5B7FFBFA059FF6E5C32B89D8347D4BF9F
          57FFE5D8BBFFFFFFFFFFC6C6FFFF6060FFFF5F5FFFFF5F5FFFFF7272FFFFF2F2
          FFFFFFFFFFFFD9C69BFFE3D5B6FFFEFEFEFFD5C193FF9F8448D69D8347D4BF9F
          57FFE5D8BBFFFFFFFFFF9090FFFF5F5FFFFF5F5FFFFF5F5FFFFF5F5FFFFFCBCB
          FFFFFFFFFFFFCCB37AFFC0A05AFFFCFBF8FFE4D7B9FF9F8448D66A5930B5BF9F
          57FFE5D8BBFFFFFFFFFFCDCDFFFF8383FFFFAEAEFFFF9393FFFF8F8FFFFFF2F2
          FFFFFFFFFFFFCCB37AFFCCB47BFFFEFEFDFFDDCDA7FF6E5B32B72F271572BF9F
          57FFE5D8BBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFAF8F3FFFDFCFBFFF6F2EAFFC5A867FF2D25147303030118B093
          50F0D3BD8CFFE7DBC0FFE7DBC0FFE7DBC0FFE7DBC0FFE7DBC0FFE7DBC0FFE7DB
          C0FFE7DBC0FFE7DBC0FFDECEAAFFC4A766FFB29350F103030119000000003028
          1670BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
          57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FF322A177200000000000000000000
          00024B3E2296BF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
          57FFBF9F57FFBF9F57FFBF9F57FF4E4123990000000200000000000000000000
          0000000000022F27156FAF9250EFBF9F57FFBF9F57FFBF9F57FFBF9F57FFBF9F
          57FFBF9F57FFAF9250EF31281670000000020000000000000000000000000000
          00000000000000000000030201172E2715716A5830B49C8247D39C8247D36A58
          30B42B2413710303011800000000000000000000000000000000}
        OnClick = bnKoFiClick
      end
      object bnHelp: TSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 0
        Width = 69
        Height = 24
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Constraints.MaxWidth = 72
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
      object bnVideos: TSpeedButton
        AlignWithMargins = True
        Left = 72
        Top = 0
        Width = 54
        Height = 24
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Videos'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000101022C080C16870F1526C3161C2CE3192236E71821
          33D00D1118940202043800000000000000000000000000000000000000000000
          0000000000000B0E188E202741FF2A2A37FF272B3BFF171E32FF1D263BFF252E
          43FF293348FF293043FF11141B9B000000000000000000000000000000000000
          000011131EB4222D4FFF1C2235FF211405FF2B292AFF28344DFF282E3EFF292E
          3AFF2C323EFF2D333FFF353A47FF1F2127C10000000000000000000000000A0A
          0F8B2A304AFF202238FF212234FF20202BFF2C2A37FF3B3B49FF2E343BFF2824
          2BFF3E3540FF383B41FF2C2D32FF44454FFF1C1D229900000000010101222527
          38FF190E1DFF303C4BFF588395FF628699FF5E7C8FFF444C56FF484850FF5669
          75FF5C7E8FFF48555CFF383338FF3A3639FF585A65FF090A0B2B0F0F148F3129
          39FF3E4F5DFF68ABBEFF516D78FF4D4C51FF6B8997FF6CA8BAFF4D4950FF7895
          A1FF70BBCCFF393B3DFF453C3DFF353136FF423F47FF2B2C309A272429D34745
          53FF79C3D9FF56808DFF22090DFF261619FF58616EFF7CBFD3FF3B3A41FF687D
          8BFF5E98A6FF373232FF493636FF261A1EFF322E32FF38383EDA3E353CF46B7B
          8AFF94E1F6FF3F474FFF281C21FF271E24FF6D8693FFA0E6F5FF404852FF606E
          7AFF7EBCCBFF536D75FF69858DFF303037FF241415FF3C3A42F4453B44F4606C
          7CFF99E5FAFF3E4A50FF31262AFF444349FF4C5C69FF4E6067FF404046FF6B7B
          87FF7EBBCDFF464C59FF77919EFF83C2D2FF272930FF3E353BF73C3840D3574E
          5BFF86C6DCFF517F8AFF260F12FF4B414BFF352B35FF2A3940FF3A2E30FF6675
          7EFF70ADBFFF2C1B22FF38252BFF89DCF0FF52707CFF3C2D35DE27282C92746C
          79FF626871FF87BFD1FF566F79FF555154FF6C8C9BFF73ADC0FF4C4248FF6E89
          94FF7EC5D7FF54626CFF638B99FF6EA6B9FF4C4951FF2C272C9B040405267475
          83FF473C44FF655E64FF688B9EFF5390BDFF7091A9FF666E7DFF555664FF7687
          97FF7B8F9FFF6A7F88FF657A86FF423A44FF3C3441FF0E0E1129000000002122
          27917C7F93FF4F4242FF212739FF053A7EFF4A546FFF6A5C64FF454A58FF3E3B
          47FF564D5CFF565365FF38333FFF292732FF2C2F3D9300000000000000000000
          0000444650B98C8DA1FF454552FF2C2C37FF4E4953FF5A5967FF5A5D6AFF4A47
          53FF4A4259FF3F3B5AFF262741FF2F374AB80000000000000000000000000000
          0000000000002D2F3892777588FF786F79FF49434DFF3D3A48FF534959FF4B4A
          5BFF3D6068FF33555FFA22394687000000000000000000000000000000000000
          0000000000000000000007070832292930903E3C45CE5D5D6AE9545868EA3446
          50CF183B32860916122000000000000000000000000000000000}
        OnClick = bnVideosClick
      end
      object bnGitHub: TSpeedButton
        AlignWithMargins = True
        Left = 206
        Top = 0
        Width = 60
        Height = 24
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
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
        Left = 268
        Top = 0
        Width = 62
        Height = 24
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        Constraints.MaxWidth = 62
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
    object mniNavFilterForCleaningObsolete: TMenuItem
      Caption = 'Apply Filter for Cleaning'
      OnClick = mniNavCleaningObsoleteClick
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
    object mniNavFilterForCleaningSelectedObsolete: TMenuItem
      Caption = 'Apply Filter for Cleaning (selected files only)'
      OnClick = mniNavCleaningObsoleteClick
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
    object mniNavUndeleteAndDisableReferencesObsolete: TMenuItem
      Caption = 'Undelete and Disable References'
      OnClick = mniNavCleaningObsoleteClick
    end
    object mniNavRemoveIdenticalToMaster: TMenuItem
      Caption = 'Remove "Identical to Master" records'
      OnClick = mniNavRemoveIdenticalToMasterClick
    end
    object mniNavRemoveIdenticalToMasterObsolete: TMenuItem
      Caption = 'Remove "Identical to Master" records'
      OnClick = mniNavCleaningObsoleteClick
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
      object mniMarkallfileswithoutONAMasmodified: TMenuItem
        Caption = 'Mark all files without ONAM as modified'
        GroupIndex = 4
        OnClick = mniMarkallfileswithoutONAMasmodifiedClick
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
    OnPopup = pmuNavHeaderPopupPopup
    Left = 152
    Top = 88
    object mniNavHeaderFiles: TMenuItem
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
    object mniNavHeaderINFO: TMenuItem
      Caption = 'Dialog Topics'
      object mniNavHeaderINFObyPreviousINFO: TMenuItem
        AutoCheck = True
        Caption = 'by Previous INFO'
        Checked = True
        RadioItem = True
        OnClick = mniNavHeaderINFOClick
      end
      object mniNavHeaderINFObyFormID: TMenuItem
        AutoCheck = True
        Caption = 'by FormID'
        RadioItem = True
        OnClick = mniNavHeaderINFOClick
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
      789CECBD6B73DB46B628FA3D55F90FB8BAE794A53D924C80E02BB367EFE3C856
      E23376EC6DD9C9D9374C9D0289268911083000A8C7A4FCDFEF7A743700921040
      5916C54C276589028146F7EAD5EBFDF8639864137BE8F962127AD1D46E399DA1
      17A501FD182FA6B6D37186CB31DF31690DF9679AA5B3893F1ACFDA76A7D5E13F
      C398FFECF29FB3A0F4E728A067F11DED56DF569F2702DED81F66333117FA3BFD
      D7EAB7E3B4F5C770124759360AE1436B08C3FA81359C24F1DC8B8693F1CC4B52
      91C1F545F2BBF3C7F0DF860B2F8A5361B51CF8BFDB6AB73A2D17FE39F0C9FDFC
      31988BD4FA495C5B1FF0F1BF7E86216D3D647A1DA4E9DD438E60489786E6FFDD
      CF2F92C00BFFFAF9DB6F6028470F358F7D91AC4ECF2E8FD583290D68149C9E0B
      639DC5CB2410094E90A6D6AE58ADB33E35D89316400EFEF5608A3864EFF3C5ED
      7C1487BCC81C705110DE3DD0DA7F9F7F09A2A90FFF52B94EDBAD9898DDEE6EDE
      8895513FBF7F0BC3BD093EE17D132FCCACFFE77DEABC1B2F5F88CFBCF2AA376C
      DC15DC60DE68DC70DC95336F3E828DB1DE7AD98C07EC6DB3CD13DA12DA603D60
      18C08812006E7B8B9DDEF01FEC7494C6A197D2DC5CB7F9DC360D7621A6B1B03E
      BDE6C13ADBECCDA6E1FE97DA1CB9D81086F9479C000CE16C7F8503E88F0AE3DB
      5F15B3683DB3A0F03E673BB4686F460BEB4D309D65B49A5171F4AA037C5F68A9
      FD0822F586ADCE49E3FDC8C7DF0A9BEEBD1FF9FBBA0F744C7927F2717B0F0F27
      B75B459EDB7D1ED55A79CC3A7BA50848D57C1CDCD1CDCFDE26FCDA41D59674ED
      8A477F4884B8A4873B55E7D7EE3A150F7F5CF27B3B9547B3D7AB78F4F047314A
      C4F5915C74C7A91CA10A60872F126F148C8F780655C7C9EE772B9EFF1E302E18
      F3D3954CABDBAE7AFBCF81C8220F2E0A39832AF4CCB79CE4817CA33B557C27DF
      68F984DCDECEA0E2817C7BF9817C53BBADCA479CD2236A2BBB55324FBE95FCC0
      CA0676ABA865BE81F2B9E2B675DB554FE96DE3A70A9BD5AD6289F966C937AD6E
      51B75BC59AD51ED95641CECA77AADBAB7C506ED5CA8372C3BA83AAE7D48E959F
      CBF7ADD7AA7ED2D9F0A4DABE9E5DF99CDCBFF2732BBBD8AB1453D536AE3C5EDC
      CC5EA5E4A376B3FC70614F7B6EF572DB9BDE5BDA5A163CFBFDBBE9B8A5D88DF5
      8B48337847A580D9AFA7DE452192F0849EABA7DCE5E7249AB4FBF574BBF4A0C4
      135A777B504FB74B0F2B54690FEA6966E9C1C27EB507F514B3F4ECDA5974ED7A
      7AA924A89C35DAF524533FA478A25D4F35D533F9F9739D7AC2A99E5200759D7A
      DAA99E593977AE534F3EF5A3C533E73AF514543D58D83FD7A927A2FA7D6B5BD7
      6B4447598B29CA358DA8A87A4C6D5FAF110D954F1536B0DF8882CAE7F416F61B
      D130F99402282FAFDF8886C947D781DAAF3F0F4A995304C7EDD71F87FC1905D0
      7EFD79D00F15098D3BA83F12FA410DD041FD99D00FE587829EAC3F12F993A533
      31A83F13FAC9F21E0EEA8F45FECEB52D1CD471A0FFB5CA82E8B992125D354403
      C5A1344E1547A957228AC3D895827D0385A23450A57C7FB772B1B630BB926935
      503556C7AA6462CD948ED25895DA70AD02B2BEC62AF9630B75A46839716A2C33
      8D25A3A279C4E937E6DF6401C9F1B4344A15315A67E8721489A5C541DA953466
      8DC3F320398E9686A924386B2C9F87C931B4344C25F55993027898127E9646AA
      A4466B42811CA9889DA5913A8DA5041EA9849BA591AAD8D4BAE020E7B48A9945
      2B58FB7EE46E75947B123B5A5C7120F74BC85D69A07B92BBD561BE84D8ADAFEE
      0BC95D69ACFB93BBD591BE94D8AD193EDD7B235569942FE2A07A986AD3581D4A
      ADADABDA46568B54A561BE9C83E6637D094AAD2FF08B90AA34D2C370503D5EF7
      4138E89A49BBDB9C874A0C2D3DDD9C7716B8A67EBCD79C6B96F8653E40737E59
      E294F900CD39E52A8FCCC768CE2357B9633E4673EEB8CA17F3319AF3C54D1C31
      1FE74B38623ECA1772443D50FF0B39623ED01771C47C9887E088F9685FCE11F3
      B1BE9423E6237D29F1A2858EE3304EB251F8D76122FCD6700ABB12B586A37029
      5AEB979C4EA77811FEBCEB320F807F6D1862E5F2CABD154354BC9087B09D7EF1
      22FC79D7E5D65FBFFD062FE3DF1B0659B9DC2A5FCC07D978590F3270E417F081
      BE18388DE0DCC2CDFE370C7719CF16482A1C67889132434F7A38314E46FF8121
      35F28F8EA51E5C780B0B56F87B680DC3A0354CE05FEAD9C0A0D2D0E90CE0E77C
      1966F6F03AF0C759B8F092E175E22DE0390F2E0FBD74E1858B99871FA2E51C58
      94B7CCE2A1E7FF63996609CAEB3020CC35C41F41E62D5AD6E76114FF0E5817CF
      E34C587F0CD3EC3614E94C88EC8FC79BC430C94280C5649CDAB8786FD2827F08
      3C4F8529C144B2846F6929C0AA08A242F01001BB0ED6C3F134097C7A2C5A1446
      88163886354C237193C15BD2DF277132F732F8B448823809B2DB96F5135EC2C8
      1A98676A974134B25B0428FC39C245DBF017FFDE0A54F13203E088505C89B0D5
      1870436FA4200722F266C8C1A44743FA7E13F42E41B2013907744086634BC1B0
      B51DFC465E2AFC386A4950C2D45298F3A5DDD908D381854897A4816FBBEDAEE3
      745BD64C78187464D912CECED787B37D1F3803A4EE843342B2124B1F08BA8E82
      6E775BE83A12BAEDAF0F5DE73ED0757A774317BEFFEAD06D2BE8F6B6856E9B79
      01AC09C6F27C3FC8822B01B7A7621ECC02DF1711FCB18CE0A358C22B0B83DAD6
      4B86ACF5DE4BBC29407A669DC7110519FD1BAC3D4B6D1B7E24F1B53FCC924996
      FE12F8D9ECFB36FCB180178576AB2F3F26F9C749A8BE9F64FAD3487F4AF0D378
      B4F080ACC387097F18C1D281C3F1EFEC7621E0AEF44A24194836F06994F889FA
      1DCADF23F93B91BFFD69A83FA96B33F9FBCAAA6331B0DAAFC2649E048BB1ED3B
      D0E1DB6F98D3581FBD5128342E758AB85445FCCB2B1951EC2CD27C4DDF733C47
      E46404C7DFF1F8B284891BD0FB47459AAD33905AF5BCBAF5F3C2D76E98175C46
      22B43A1F67CBF938E5F9F4EAE7E3F436CE072FAFCDA6BDE56CDA6A362425F4BF
      0E81DD1AD9DD3B90DD7D705A5AD8552D09F44BB2D41AF8E6691C29F98AF77150
      B98F9356790DCB70389E382B7B574D6C57370E885B823BADDEECB4B67BB3EDAC
      A171E3979FC761185F0BBF3489D401E9729CA34D8E1A4C66F1674A3FAF6DD0AE
      927481537E58B4B1116DEC3B849CAB217D5F8D3AB6421DFB8BD8B0A60AB8C11A
      A6CD77F7E3DB37D6C77861C513007632D79BEC546FB25C7B79ABAF2869002F6F
      A45925225A9ADDCA84FE7952988DA65CA9D3BE63CBB37FD12D77EFBFE5DFC759
      16CFD776DD7DD85D6F37DFF5F2840A1BDF79E22C0216FE5598C4BA3AD3B99B45
      2CE214362E8E4E12117AB8834A45EC3E71083E1A9375BA7743D04FE2851F5F47
      FA3854CB4AAB9CAE84FB77BDE2248850F73B19E1B9D02FEA3FF88BBEFD46ADE6
      64EC2522D3AF6A2E37347D1560C32CD60266BBB978D0F405A072CD4EFCE00A48
      5AFE1AFB6E3916F7BF24C3AEBC6E5D63250EBAF2E68B2C89A3A97EE71D4CF19E
      4B1BC7CB282BACAADDF40DABF4F68E772462119F2471AC71A07D0799BFE73AFE
      919ED02EA5623A1751FEA66AADECFE889D0AA0505E5640B96A1DEBDE28979CCC
      FD1357BFE1E129C12408051083495CC06CB239199D485998FADB8835D22870F8
      8B181DE96DBB83D839B4C895CDC36C55BA784F5D0945ABB3D827AB44EAB64A3B
      A9770B0D5537039014B31BBBDF76E097D373FBF0ABDDEDBAF0CBEDF45BF0ABE3
      0EF096AE6BE32DBD366600DFF41DD7E5A7F116408A1E0DD31A0CF026DB1EA059
      EBC676E03EFCDDEEB9749FDBED741F184924FCEE948A5A77A089A3D0C4F922A9
      C855C2A67B97CD68F34EBD4F0473814CF80A65DC6ABE7237CA6C128079724D04
      E0B5F9948C366E35E309D6295050CFEA36D0A3577340873448F53BBF062B5A84
      275AE8711F9E0BC1F0634946DDA7AE373C1A19756BF4867972A22DF2EEC373D2
      499789614FEE47CFF9AA366D1C9E7663388E41B2BAC9965E084F8FD797B3432B
      F7A65DDAEC4641514D41B4D5E9B7DD816BBD09D28203E4AF9F69EF42B898A141
      FC0FFAC87F8BF902544101CFF66DE014FD7ECBE1AFC9F534A49FD164ECB4F5C7
      487DFEC7B8A53E44F2D3848C71F28F34F3920C5D21FC1742587E134440E1B2D6
      1FFC176E012CF759CB1E2E4FDA03BB6DFD27E203BF6F391F8904280E55754839
      5ADB23E80727ED6E4B62CB3FC67271C8061DB5CB1817F0D04BB982E9461929CF
      4DD685AB8A37ADC629AD0679A15A8FEDBAE505D105181B7F3F9125D146819EB8
      71A3EC56C54E39709C61A5C5B5E1255C1BFEDEEFB5C1C929AF0C2FE0CAE0B745
      51477BBB36F8595E1B5D8057E0EF26BB868AF6135D9BDB5E211F74015E81BF1F
      0223D5DA77B036ACC4505A1B5D8057E0EFAF7CDAF4B2BFD6DA7ADD95B5F59892
      E0EF2740490A0C6DEBB575DD155A4217E025F85BAD0D231A2D18063F073EA885
      F6A0677FDEC8DA4FFAAEDBEB74BA83FEA3B176A2776BBBFCAFC0DA91953B15EB
      31AC7D2FD76658BB61ED86B51BD6BE1BD6DEEED9DD0E28E79B797BCFEE0FDC41
      D7710D6B37ACDDB076C3DA0D6B37ACDDB0F6FD60ED9D6EDFE9BA0377336BB707
      7D1718FFA0F3781679C3DB0D6F37BCFDE9AFCDF076C3DB0D6F7FD2BCDD69B5DA
      5DA7DFAED0DB4F1C1B587FA73370BE2A77579B7EC746FFA9B83B6F72038FFB9F
      86BBA3E072277FFFF372F755C9A5C4DFF7786D35DC7DAF25972FE6EE4F5872F9
      EADC7D9792CB0EB9FBD7965CEEC5DDB1585CA7E36CE6EE838E3D683903FB0178
      FBFA9E6F018AFDE7ED6B1609C3DB0D6FDFE3B519DE6E78BBE1ED4F9BB7B73BDD
      5EBB655745D3B57BF0E8A06B78BBE1ED86B71BDE6E78BBE1ED86B7EF0B6F1FB8
      DD56AFD7AF70B99F00EF680F7ADD7EF70142E50D7737DCDD7077C3DDF7606D86
      BB1BEEFE27E0EEED56CB759C76BB57A5B9BBAEDD19B43A86B91BE66E98BB61EE
      86B91BE66E98FBBE30774057B7D576AB98BBEDF47ABD76C76919E67EC71ED72F
      C484D0197E6EF8F9135E9BE1E7869FFF19F8F96030E83BF0AA8AECB796DBE901
      1DEA1B3FFB979E4CA3AC1BE66E98FB7EACCD3077C3DCFF04CCDDB50776DF75DB
      1531743670C35EAFDF6B770D7337CCDD3077C3DC0D7337CCDD30F7BD61EEBDAE
      D3A962EEED4EA7D3EDDAC6C96E58BB61ED86B51BD66E58BB61EDFBC2DADBDD41
      C7012ABA99B50F7ABD56BBE73E44CD1AC3DB0D6F37BCDDF0F63D589BE1ED86B7
      FF1978BBDBB25B5D7750E1703FE977DBFD5E7F601477C3DC0D7337CCDD3077C3
      DC0D73DF1FE6DEEB3BCEA05B554BBEDFEAD84EAFF5107D620C7337CCDD3077C3
      DCF7606D86B91BE6FE6760EE8341ABD5E974FA15CCDDB55BB6E3DA5DC3DCEFDA
      E3FA8598D437C3CF0D3F7FC26B33FCDCF0F33F013FEFF4BBAED3EEB43B15FCBC
      6BDB6DA7E7B60C3FFFD293699475C3DC0D73DF8FB519E66E98FB9F80B977ED6E
      C7E9767B15217480CC760F38ABE1ED86B71BDE6E78BBE1ED86B71BDEBE2FBCBD
      EFB4BBBD76A7AA7CFCC0E9DBFD41CB3169ED86B91BE66E98BB61EE86B91BE6BE
      27CCBDD7B23BB6DB72AABCECED6EDF755CBBBF313EBE95C3A5B5FD9637828403
      FF5AA7AB504010C112922C1CCF8693716A5B436F029008B3842F7C099FDF6655
      0DD1F8CE8EF4B844FBCB96780FD6FF155659B5468A30C0553A5FB6CA7B08018F
      B84AB9C6F6DA1A39C0A2F92AFB2B87B85E1C78FC55BA4D7712317FD32A6B4483
      A7B1CACE97E12B4A022BA25DBD90F0F8ABEC7ED92A6B8485CD42DEE3AFB2F785
      ABDC5E6CD054FF1157D9FFB255DE4B80E8F4DB9D7ED7D13BBD2242747AB6D369
      B71FA2FFCCBD2488C7320E1477FB51F496A7651CD8A148BF4BE3C0D716E9EF21
      0D3CAA02CDC2CD57310FEC7C6D5F62B0FA62F3C06ED756631C58916A1EDA3CB0
      BBB5DDCDE5F7DA60751FDEEE74BBAD4ECF1D54F1F66EC7B6D1F26F78BBE1ED86
      B71BDE6E78FB1EACCDF076C3DB81B777FB18726FF7AB78FB49B7DF775A76DF7D
      80DE7286B91BE66E98BB61EE4F83901AE66E98FB1EADED1ECCBD6FB73B8E3D18
      D895CCBDED749D9633701F2068CF3077C3DC0D7337CCFD691052C3DC0D73DFA3
      B5DD87B977DAFDBEDBEDB955CCDD6EB5DBDD76D7768C59DE3077C3DC0D7337CC
      7D0FD66698BB61EE813F68F5EC4EB73BA836CBDBDD76ABD773DCB6E1EE86BB1B
      EE6EB8BBE1EE7BB036C3DD0D7707EEDEEEB53A03E07955DC1D89903D707B86B7
      1BDE6E78BBE1ED86B7EFC1DA0C6F37BC1D797B7FD071DC5EA75A73EF3BFD6EA7
      37B08DD3DD7077C3DD0D7737DC7D0FD666B8BBE1EEC0DDFBED7EC7ED55A7B93B
      AD6EABD3EA39FD0768136F98BB61EE86B91BE6FE3408A961EE86B9EFD1DAEEC3
      DC07AEDD1F38DDEA70F9C1009EEEF58CE66E98BB61EE86B91BE66E98FBD35D9B
      61EE45E66EB75CBBD31F0CFA95F1F2274EABD71EB49D8E71BB1BF66ED8BB61EF
      86BD1BF6FE74D766D87B99BD777AEDAE33E8752BD3E1DABD6EB767F75D639937
      DCDD7077C3DD0D77DF83B519EE6EB83BF06EDBB55D60F0FDDE1D51753DB7DBEB
      747AA64E9D61EF86BD1BF66ED8FB1EACCDB077C3DE81BDBBED56DBEDF49DCAB0
      BA136C1EE33A8EDB7B80DEF186BD1BF66ED8BB61EF4F83941AF66ED8FB1EADED
      5EEC7D000A7CDB1EDCC1DEFBAD4EAF33705CC3DE0D7B37ECDDB077C3DEF7606D
      86BD1BF64EECBD6FB7065DA732E5DD69D9DD1E8CDF35AE77C3DD0D7737DCDD70
      F73D589BE1EE86BB0377EFF49D9EDDE9F52B8BD59DD83D10009CBE51DE0D7B37
      ECDDB077C3DE0D7B7FC26B33ECBDC4DEBBB6DB1A384EAB32B20E987FC71D74BA
      26E7DD3077C3DC0D7337CC7D0FD66698BB61EEC8DCBB7DB7DDE97606D5BAFBA0
      E7F4DA2DDBC4D519F66ED8BB61EF86BD1BF6FE74D766D87B89BDF75AAD56DFEE
      76AA6BCDF77B40639D816B2ADA18EE6EB8BBE1EE86BBEFC1DA0C7737DC9DB8FB
      C0769D6E75459B936EA767C364FA467737DCDD7077C3DD0D77DF83B519EE6EB8
      3B72F776BB6DDB7DFBCE72B4FDB6DB07FDDDB077C3DE0D7B37ECDDB0F7A7BF36
      C3DE0D7B47F63EB09D76BFD7AA66EFF60034FC4E0F889161EF86BD1BF66ED8BB
      61EF4F7F6D86BD1BF60EECBDEFF41CBB050A7C157BEF3AED8EDDEEF68DE3DD30
      77C3DC0D7337CC7D0FD66698BB61EEC0DC07AD7EAFD387D358CDDCBBFD76A763
      62E60D7337CCDD3077C3DC0D737FBA6B33CCBDCCDC3B4E0F7877BFBA16ADD3EA
      F5EC8E6BECF286BB1BEE6EB8BBE1EE86BB3FDDB519EE5EE4EE4ECBE9B49D2EF0
      EFCA2EB07667D0EE765BA6C7FB032CE56931F4F21A70FDFF120CBDB832B5E986
      A11B866E18FA5EAECD30F43243EFDBED6EC7EDDCD1F8B58B51F22EDC6438FAC3
      EEF2D362EF465F37FABA61EF86BDEFF7DA0C7B5F61EF9D56DBEEB4ABF5F541B7
      D36B393D53C1E60196F2B4187A790D465F370CDD3074C3D0F76D6D86A19718BA
      DD769CBEDDB3079F69EDFF46D7E32B9124812F609450FC51BAA4DCF2B66B8392
      DFEEF74ADF8EE3252C6618A6F6E78D8F39ED4E17ABD7DA9B9F72363F35E8B7FB
      1DB7D775363FD5DEFC54CFE9765B9D9E3BD8FC549EE8B7BA345D8477F3839D8A
      A5B55AEDAED36FB7363FD5DDFC54DF6E771C7B30A800486FF3535DBBDB81D5F5
      BA9B9FEA5700A4D5E9B73BFDAE835C6CD37383CDCFB5078341DF0174ACD8EA56
      C5AEB57A76A7DB1DF42B1EAB4091411BE63960F96BD363153892F72CAE78AE5D
      B5DFED56CB759C76BB0A93DD8A17EA724F15CF55E0495E48A2E2B90A4C818D73
      E1F8B43B158F55A0CA60E0DAFD81D3B5AB36DDAEC0963CAAB6E2B90A6CB1E1CC
      C1411854C1C5A940977EA7DDEFBBDD5E05589C0A74C96B6A563CE754EDBB6BC3
      1C1D50652A1EAC202B6D60EF6EABED56A08B53812E83767FD071DC5ED5342BA9
      8A7290563C57812D7014608E9DBE5379D89D0A84C933A12B9EABA22E5DD8051B
      10BBE2B12A74D1995915C4BD025DBA5DDCBFAA87EC4AE2DE72ED4E1FE859C5EA
      DA55E44587A1553C57852D3D40CDBE5D7186DA15C8E2B4EC0E9CF44ED5CB2A90
      A5DB77DAC05E3B6ED59EB72BB02557EB2B9EABC095DCDA5FF15C05AEB88341AB
      D50168563C56812BB9B052C1D25B95DBAE5BDE563C59455D7433BD8AE72AD0C5
      19B8DD56AF5785656E05B6746007BBEEA0EAA90A6CE901B6D86ECBE9576DBB5B
      812FAEDBB25BF0BE2A7056D116DD82A8E2B90A6C81036BF75DB70AC9DC2A6469
      77E1F081A25FF1D8A092C0BB3DA07F836E05383BADCF9F51E04DC455360AAD3F
      3E4597517C1DFD95AF2EA60BBA8A1F8601FC709C6190790B4484D630817FE908
      FE79489EB6B8A5FF1083B46BEFB091043CC09B060F3148EF210681935BBBE8C2
      2DB0FCCD37D50FE3D483D7A95F52F74116DDE0167BF32DDF7E53844CED30AD7A
      E8D6A3AE5D0F5CB77E41F577D40F620F1AE0BF5DF52A260B69E02305A00FAED3
      735D00357EEEF6417EEFF6F8F3A0D7412A8F9F7B0EE849ED3E7F1EB8C0E1F8B3
      8D6A171275FA03A899E374711AF3B997CDDE27FCFB3C8EB2B63B9C8F92CBEF83
      A8A53E5C2C614AF374EE85E179E28DE1B31FA48B9762620FE7E15B2F99D2BD89
      FEE48BC9FF1EA3A83FBF4EBCC56BB22D9019781E44D99B600E1F222FB9854FC8
      F0826812FF31F496D92C4EAC5721DC93662279F109BE8A1722F132B8FC11BE83
      AB91F52A9A862281AFC689F0B2603EBC4D404C190CE7717BE8DF76F00D1D6450
      484E57BFB5690244E0810AA7411CE19DC2C73722B388E2C9C29B8AB4D3E13FAE
      E3C407C5ABDFE9F3DFE39997A4A01C0CECC2DFD72980BB63F398D1A0A70C1837
      F310D641B49B3EDAD62CCB16DF3D7F9E8E6762EEA5A7F3609CC4693CC94EC7F1
      FC793C990463F11C5FF91C7578FA340F3F7F1E2E3C00C2B50D8A50973FCF3074
      A13F9C03B443862A7C4AF4A74C7F1AD1A7E9320370027A65492AC69905DB721D
      F8F1F5384BC2E1248B46FF187A22F2FD783CCC60732FE7C0A2D2167F9EC409A0
      451644537BE8C7519C89F948F8E96D3A0144013C14E16D1C5DCDC356E1DB10EE
      F6BDCC8337271318555CC1EEC380575E18C07501D0B087E92CBE5E84DE58CCE2
      D04773139CFC691427621EDC087F0CA3A3390A8EC19508227AF206DF828FC107
      60A1800E36ECC14D08D38B6F4504AB12378B749664115C5EC262C374311EFA11
      6C41948EFC115C2583172C6909EB8685A5330F983420D63F71EDFE744EE80B1F
      6674A30DD2963FBD2A7C865B83293B32F09BD25F339C9A4D0FE007B45BC27CBC
      C81F5E05E2FA32887C9B3EA5632F14A069C0F11F257E32139E2F3F4EE2381BA6
      8BF036BB8E8248E0D6E8CFB36C0EE7235DC022C2689679FE3F6059C3652AC26C
      E485D110FEC10578C9101E81378CE1AF6BFA033E24D9341986111C6558B98021
      E0D3758272C5308DBC45164F412009A2B1084318288CAF278108E1C8FA30FC10
      6E5C2CA3319ADFBD34F0F42848451298B1A224C3485CC38869760B5FA7F09269
      125FC39CE34990E144230478760B70472908BE87C946405EB27438113839118A
      2BB83CBE491764EF03B2E0C31E5EE375817BEA4DC670A070D6DE846E5E025E86
      C319DD8180CB80987A09DC998DAF3C825506B3C587260902042F5C79D9CDE866
      7899448B248D44361C7B701C01E14280A3859813C0695C789905D3CA5A7C94AF
      019127F36C128470902CC705910D8F3FD09F6522B2591267592880B9859378EE
      8DBD6C1C46CB45874E1C4CC81AE2B1F32D750081CE47E2A635C4AD17C96D0FE8
      336EBDFC0833496FF003C03F9A8944D0D3F808EE121A58693431F100C7C7B083
      74822D921523F82ABC82D3B58896E3648E17D0FA8B7FB37D17CD598B68E64553
      9428A3EC26F3AC532968CA875151C7C761B2F77ABE0D9F40BABDD7B32E7C0A9B
      BFF9A8FC74A7F99B47D6E1E7AA61BA0480C6D3B86BA81E0DD46C23EE1AA7FF50
      131A349910E2FCC69180FB2440AC422F882C89DBC3DFE1D028B905B80A602A5E
      457236A29F29FDBC06916C94A40BA7650D512290E80B1465E1858B99871FA2E5
      7C38F190620C81BC2DD30CA8EB2C838123F21D28C91086F78A120C084659389E
      0D2763E0B040195AF02F0581D50B612D76CBE9D054F98616F23EFA16BF6CB7FA
      367D9808B8AF3F0C63B8CB9BB4ED0E30DA5950F8C31FE93F3AC3319E437A2E5A
      1486881638086C42793A364EC7EE962631BC1AC275BC0C342E2DCA6F28509416
      87B8081484419F037D5C05F4EC91807EBF656A5EB1699D12E27619DAB42913DB
      FA1E686C3CB7E289750E8C645BB03C162E3E3A583EC68BFBC2E45F1B550A642B
      1DD92D9434E9E7081708E2A9C7BF739035004BBC243E4D7ED2D6170169A40899
      DB5F255FA3E1C47587F8CD10A6321B5E82D2010277BB01E414DCE0F90D80735D
      EB9799973D4B2D90E42C20F137AFFC20B3DCD3D6A9F39F3B82A2FD30506CAF60
      9B8221008D60B805CE55C2EEEFF1C979F08860FAA233C84CD22D43856182568D
      0700C70B8B2305F01882F45F7B7F925A5E7A297C0B1404CBB3AEBD5B2B8BAD74
      B958C4492651D147948817731057ACEB209B01A6C0D880FCD67B2F4B441C59A0
      6E3D87E7DF7BB7EFBDF054EE46EDBB5F675600581F5F5B8B384D03D03DEADF6D
      8D62F81147706B3017F8626B0E4AEB2CBCB54013F6B2208E52EB2AF0182F8E2D
      84E11496E707098AF3B43ACF1A2702071F23B6F04A704B17022D02D621AC0447
      E0D51CE1917C51BB964FFFA3F1B23FCE04CF0EDE301508024021DC027C69A6BF
      1C2D819C46F876BC9601C321A4B3C67112F1FEE2F5390A85A8549F1A525107F8
      1FBCB948DEC7224BAD9F035FC4A9211B05B201CCE780C172A0706FE6A5D64808
      38DFBE0FF8B92D2A36380980FCD741185AF102DF62FD77BCFCB81C090B749D5B
      3457F091674A902EC438980463382638496B748B1B5AFB0EB9E3E678D442EAFB
      E57412DC08752AD8A7461169B9FEA94D2B2B08BA829A32CCBA5E3252BA5F794A
      34D349DB1A3E1BF5869937FABC61D74AA1DB8DB76F25AC119F6DB0A161BA791B
      F1F1F2464AC3FF439FE0DABDFB7FBB6DD73AB17E3D7FE7FE66494FA6F55E2497
      D6AB284B6E177100FCD3EEF4BEFDE609EE6EEDEABEFD06D6D785F5BDF07D64D6
      9E958E815D67D624F1A6241A1057FFAFA548518EFEF9ED8B9716B0FB1850C68F
      451A3D037965812670A253EAA133F4045B6473DD4FA01C26022525A0CC40AB5F
      06292EF808A0C4F43211734131A3D6E132BAF622B82FBC056966855883C8975A
      F3200AE6C13F61A4EB191062781AAED6CEC00A3D20D1E3304E454A925802F08F
      E107BCC103829D01C4F711B25570FD056183C04B318676128424BCA55E83ADBA
      82C1B2EB602C88A305856152C0D3C83FB668C752204229F2592FB2C8D702FB81
      AF4944E4CD11F34FD13143AF4E7172E96C99F970D4F711CAD5F8FBEBF94F3F23
      1503FDC5B70091105602D00BE48CEFDFBEFC8840BF4EE2688A32BF9800A785BB
      40E8F79200FD17560A886C1DA6A0A684F045082A0D4A31561B24864CA447FB08
      AB2A489DC561E82D488189270D20AEA8221E53D43D0E09C474E63D22ADCF816A
      C457F82185F7E1B8730F9DC2E911284B91B58C7C90F7C622C9907C8C8364BC9C
      C3318FC6808E8CBD1279BD34859B24F60203C29150B743EC251A8CD731632CD9
      C7EDA846DD8397422C605B16B78892EF64CCD101B121D074815ACEC4F8526E03
      9DF43180C8B7A649BC5CA4BC13611C5F22BC50239FD71317DA1EA6B891403213
      23B6B3C40E9F4962471D38DB4748DF498A5973FFBC2A6B39246B95A78EFE07B7
      F1ECD5ACDA1B67D5B65E4788DD6B2FFEDA421E9CDF4B71ABD4B09F03714D6C23
      60CC2ADA50E0585B675912E2E749182CE88183F378BC242B23104EC60FD05150
      122244C4F10E40114313CA9F09557EBDB878F59BF5F2C5C717B8CA5F5E7CFC80
      1063EEB2D7EB6C822F2BA7461AEF001BE6E298902218A3C1AC4AB39F21BDF6AC
      51E801D11AC10FA453C0890F81DC449720FBCC3CBF750D3F6FFD36D12BA6ED37
      FBC96427B4B6D1AD323A8A048176E15DED88CC9C8A74FEE844C6825DDCCD5AC3
      C75F2B0BD2CAA6FDEAE22D504B8F392F500D360A2F80A2BC6B603EF9E9C55B8B
      22E83C9254AF9380E42720D01E0A47BF2F8344D0C911D61405FF0CE3E8D2C214
      F0F000DD86C322228C9153B22B3C3E631C8409FE994ED60ED0EC85EFBF6581F6
      F06817FC1B856890CEC65E18A2E08DBB8E0999527EF31241AC9CE2EEAC79EC2F
      43A9ECFD89761DDD1F11E0F3949C35780C04C6E7816E1109D023D206470D343D
      1061489446D9C7476598CC1A73B66BD0F9928A0B1DE63106D8FCA9A0F8EBC757
      179DE724DAFC42AA0400E07D7C0D3C1BD67FF1E3BB4F965480119F501F088369
      84EAF1BE5A00ABE070FEAEFD9CEC0517315A53806247D3C271CA122F4A41D124
      CB803A5F48E4A76C354897E3D93E026413389A10A032C440453F7F73F151E10A
      E0891FA4082A393259C5F7113C95F8F272B90883319A820FCE50F34E408F8C27
      07D60F1F3EBD4F151C58C206C1378AA39309204F28AD7105FECE160E4036E358
      AADB8CB75EB404109E85C28BC8B08171CDE4A8C703E98B452270477CE38EAD87
      D8E1B3178B0530BF738E8946E6A6EE7AD6E0541C5BCF3E453E6050C6B1132FF9
      B85B1FC444C05100FEFBEC98BE78F6010D81704A5E63942A9C18B225B0EC74A0
      EC57CF680351830C7C81D26D3C4A631A5BC9B37062B204E4189A3D1E9B67FFB5
      0C40977C019BC0137F86720E4F863CC1180E1247B0420CE7872308C2518AA64A
      714304870C89B3206DEC637E1B27380B4EA820A97A84B2FEEA349464C654A376
      5452988354456EFD04F28B1F8F97E48B3A842FE7807BC122244F361A47474081
      AE8FC92E43967FE101E6E86D3D3A6D248B9228BC19CBAA02569F08159229505F
      4C85D4380D8E90348D03529EC5911FD0E95985F27DDFDF385E7867A4AB02E00D
      49D7DA32BF10EE74A831732DC4F0B219910CFE8ADC0596F05214E84121F6891A
      5126C838B36C8C8C12169FDD6667A4C16256F7EC8161D400421A2E2C905EC382
      15D072B1EBD47A1149736C2910A73EE285ECFE98CA95C42191A9CA2562C6F8BD
      60F7859BF1B4C995CCF6FC526AA5924615F0D4B05B1C22EB4592A00988D8E9F7
      22021D0ED16702226C66BD4F823809B25BC499970C832F2570AB537EAAF4AD62
      879A2161D5BE34109F384CEE1D1FCA83FBEED2C16A60DDA104494A0EBB6429EE
      699B5ADB3E75DCEE2D5FD422C4E3EE808CC000C14B1246F8048C22B812C7A54D
      F036C01FA307786F48CE1CA1540864D80BD194443B59EF6A157E79C1989C79CF
      ADD194F44993C227A13FFEFAB3486E7F9322FB05AA056A77D36379F55794E47F
      63519E151812ED31E2D77A1344F0D87204AA802F4CCC6F1E7D5B7B07F9235280
      DC5CD95829B28C1436D497507441DBE218EDB64285D26764E005C0CBB8607123
      48CCF3A5C827FDD3F02D02612ED04ADB3C6438564A14FCA4691D5BB7F192A643
      5152AC60017D15A7D3D3EF9EA0ED6AE7B1ACCE138F65C5D3BEF1B07F676DA0BE
      9B7C460FE9313A7FD746A4C749D19C704A7A46A780DB3BF2D062859B5AE7D943
      02E2E3AB0B9720F15F17675F63DD4FF0A8D66E45132CADD89A87F56B5E5CBCC2
      BD7952185A0184359DF32131B4435030085A46D0DCCCB913E43CFFE9678D9C38
      159AC9D343CCAF0880774439FFEB85C1CB125EEE0E251533A379FCCBE1A3E216
      061DE53E9495C5DD1049A61138139C08CEE35F0925D5F27F78F31571D228FD18
      7D058A73BDA54B2BFDDA294BFE581928FC4B10F928F37A0BE5D7C5AB6F31F68A
      BF3A462D7FEE5D0A8C7F145ECA550584E0C01C4E50D346502A89C4F9C598D8CF
      A329F5DED8C79A51AF37B1C7451CD60D6206FB8BA5171A11B787246D27089910
      B6E72B50B55A6AAE4D6C2AC08132BEB2782AE08C256C2D7F7C88FC8E388A6019
      237E7E69F0C3D7E4720FBFEC9D2D79519F4BB6B539964BB864E896E1E85D2F61
      524FC51AD8D92FE398392758071A12183859872302E67334DB23FD6DFC7632F1
      3EFE3E4AF11905955554CE0FBBCC386F9CC3B1D5661B9ED88827BEBA0932C3FC
      8ACC0FDDD7BB618002F6E2A93240AF5034CB0F26140A9949F9F710898C14AAEA
      3D952537E49B772F7F10F0FB828A551C215DA4843A167F1128189238660F3456
      51B0BC094E14E92117E0962EEE491005E94CF84616AEDD815798A1EE85E6D46B
      0ECD410EBAAC1AAA0812482B61288DD92EE3AF3C4EEC74A590B347272C721D8A
      19EF488E54EAEB8E6469C140D8C5E2017D34796D8C3D2F2CAE4EB448E25128E6
      D6789920B9051A18D4979CF9F61B962383894662AC5F8379199C52276D08F080
      8CF6069992C4532A3661614CBBCFD5827242AF6FA61DBCC884373FE65F79DD86
      42FDA0444C0338F0B779903B17EEA429F0400B0FB90ABC9A8F8A0A385A520616
      25E507F0A55CC1B3D47AE9651E3D64287C2D0A9C63A9FC6566F5BA86C82B98BC
      C4323832A698440CA4EAF5E797919ACFC378CCE5B028CB097B7CA45C14746EC9
      961D78B4ECD3D6A94B888D9F3A88B2E399B1D135D8A10B594E0724CCD73F9DBF
      531934068573CAFE9E19820CE12428A922441AA7B1B804266E0206966EC038D0
      923C2DA2D53446AE700B84784A09D7D7D8E381B2F3178B30001CB60E3FD2259D
      379BCC69A408302DA130375D5F275B2654242D9E4C38D8102FC8647FB82683D1
      543924CEF01F09BC01AB026414C3EA65CAB42E0B7F358051567FA403654E49B0
      DE2D0309100D351DE48298628130D155084434C5140B4C23FBFBE951531EFE7D
      5E0AE4753489BF2BE1342E270EB9D0539058EFB130C2E122115741BC4CE9CE23
      B845E69BA9FA5EF398EBF8CDC42D6545A00945F8C7B2A8484091D1D77172A956
      16DE4A5E2CC7F18B53B0E680E905A4E1C1E0338C264EAD8F7113C5D11BCF0241
      AB08D2E3F2020B7596522E3983E433F16595ABC2BAF995AB9B1F134E6C553098
      7275793757524252405FC43318F540DF75A063CAF16D1F31A49C10F5E01C716E
      1EA45CBE19A658BE13986B2AC879031B968A4496EBD2BB3712588A225E023AE1
      59B9881B9C6B357114D4F0A0A0D10F0E497E328FB682C4A6DA0114889A9F7474
      559155925F3CCE137DAD97AF5FBC2996DF225D9BCE07FC0B50389C24F1BCB885
      575EB8443B80AED8C7B7D309D6E80A608B5586134BA1677F57B2A77C00AE5DE3
      FAF28740029681B378221BE0A43CB447C53C648980300256DD7FFDF294ABEAAA
      421354F8A018994B2D9E6E320B8EDB52195FF9498C825FCE01B3A83F8E72EAE5
      E04E35BC1BEF17E645E641BE8513A9CB93E5694AE8F1CBAE6389DF0070D9B191
      4E0E009BC8708EF522D3DB271FB8E69A600D0A231DEDC4C37F82A71311F2D17D
      FAC73B59EE4FF1BFD88291B622C9D8C17291D4EC668FBFD6A28D4E51BBEDEF00
      EC9FD82E81A92D4697280246FA25AD14EBDE60BF382ADA81812D524694DC832A
      914A96977136BFF4105854811E3506C9897C12A073D141CC1771820ECFB3576F
      DEE45286ACE55918FF54FA4975153032C2CA6A63C89E5945C89A485316750A2C
      997351BC25F6AE27A466194727BE20BFEABACC7FAAFC10212A05B7ABFE082D66
      A3D40A9323986E9C776369A080AF3A852877C8147D239325CE616546582F4DF0
      3CF42EA62C7929D52E028186E7D70092C5259064B958260BF4C2B0B6A120EC91
      794FE51B465418EE156B4DE7582E5F473A69F892FB17A7C3DB8AF6C9094B7D24
      34CBC254A7D6F932211FD47A758AAC20C271458A0D2FDE466A4E049709450530
      CD73B0567704E689C954209C62CDF4698C5855AF95AA942C2FD3152DBE6CBE30
      CDA5EA830403ADCC324FF81201C14FE67D05D94E9C10B0CC7C8277BA21EAB2ED
      1FC00D41A5DB9559FAF17D113920EE9B27FB65012EDBFA225633BA5F70C5452A
      53FD8E94E3DA4CEDD34252F2BBB5A4E482FD9FE828932FD25452AEE988F69F75
      926A1D166AB5CA718FD5235C976AF5217E0B95ACB4F0417C53738B0E2D024E1D
      99B1D60E5CBDE1A99093ADBC1D4AD767274CC060D57C1714B88C4AB56D6D0A91
      AFD1E43119F35B721DF7F1119F11E70216F8AEA92CFCE0D15D2BC86F04E74A60
      9D8E52EFF9E9C873AC1F0135C3C72DE2F6C465E795664B63140B26BB8896C44D
      DA41C0D0F31D2CD473761119A5591B965BC2AA6D5482890A96F9B910C1088036
      D14707CCF7172F60DC8727A6DBF52763132AF27FE060B58F14D4B28FAF2EDA4F
      F8D83C742C080C0C220FA93BD70224002AAE9A438354345902028B098A1B52CA
      59F3E12ABDE7EFD8B77CFEAED7D5373C34000B27E3310F6473006E137BCDCA2F
      69A12996BF0DD274A97D9BAA4DCBBF0C0AB2BACD019B803D89675DC5C158A8B6
      2A708C97D4703392C13D256702C8F3EFE3304867EAEC768E80F6A127B83E6ABE
      D8F946804021D214BBB82C64FF1BD2CC503625DE6AE4B3FA20CE9B05760F62B5
      C7C448148248E64A192C3AD30A416DA8CC32F44043F546D2E388BA199654BD0A
      B8438C34F3FC1DDDA658C114FB6E5A2F8064BC448B8F41D0FA8D98C1F4A849D3
      C54208FF7B6A976A1035B7F4B28E7FF0E9B57521F5FC03C4C76389A2070CC012
      F4CA4D681A986EEEE8407BA04C312B11CE45FB41206DC7DE9517841497A96367
      8A1E721E991BE272901075BE4103F16AF39B60BE48A8791A573E46A11A835AC8
      B0DBDC127301A7619CA93AC725A34AC2359969929E24032A5CC1FA51840BEBB9
      EC6C0C1F7E1237CBF46D5CEF0DC79B7F08B21F9723F820BB05C127D5DBFBB9EC
      47FD5C36C4D6B0D81199683D0C9970FBABA28822146E9F09C5A5A0A02EA01B5F
      2E9BC83AD11C282C756CF7B4756AFFA721B6B5C166A62F71652DB7F613AFE586
      9D7BEDBE7562B54FDBA4DB21D2B7AC09905CF21BB19159F9F2484E277D5BF63F
      9C5BAF5F82443F4A8477C9119E2789E05C2DB8E318487482B7EE65532400CC00
      5B1A731F0920B40814D478AF8BA6F80FAFDEBF7971F6CA7AFBEEE5AB37D6F9EB
      37AFB0D1D42BD900791FD75DDD3CD3CBD0838DD7F906192F2DA2714CFE6DEEC1
      31A70675B9CE5552B810C5C68997EE674F970AB860E3BDE7701AAE91D6CC6374
      B64A1E6CF931399028321660D17547C15E22855A7A03EC5985CE1B31C5E6C018
      C3483E21AA53B25CB005B3C5DD80B96F2D994874E9F9A7C84FEE8D22DC32F9E3
      D9F92744030E8DCF53ED3935EAE03CA6D0914F8B837D5CFA1DFDA2F35E5807EF
      31003741CD16348EBCCD80CEE3C25AB58BCCFAE5DDBBF785C8D47D8447091AF5
      1942057292C49762D52CF828B554BF864BE7811C3A0F1B17B91B0B32313EC161
      6F2A26AC10298E72A2350D388440F59797ED75F6B32B5C154190BD8B5E7F7C5B
      EC82E751E324903A83E81FA0619398514CC2DAABA5DFD5823CF0C2786A7D8C17
      C1F880B33E7E8993D0071D622C0EAC1F383C51864F5C61B1E514D9020046DC2C
      E0F67D04471530B8F482AC504EA93017D47AE98318A3014892C27D969C2A3BDD
      A91EE164070ED242B7036506567D6F3D953625DBCC4A9F48C887445AC536A4DD
      EC23B82A80459643A5864AA13A0F811D7BE39968E252CF9382B873B60CADE576
      5F32EED7E348610E13DE471056621C47B9C222C714D2BB3951CBA74854765900
      F2C10CA54193CB0068E48CB8B67FDEDF1E34DE58A6F8C339A6D14A01C2FB08CA
      0A402ACF2D2BF9E91695251E568C01747D7C2906F4F8DA9B807FAD85243D8A04
      3BF6D21D94644D332F2357422AAD1F643F9358F1E88D005E4719A8DC89CE66D8
      451F6DD58E15F8B6357AD4225F7B6A4497BE1BF6B51947A5F62DDC5A8B78B10C
      3DCCFFC54419F45096FC5CAB11E0C8C217225EA88A860B4A41D749201E969F39
      C1FC663F8E6401AF5C0583A77CB26DC365E95F33DEF60659C4ECC94C499991AE
      CA91F1B96F88E027F77AD3C22FE40257DEEFE3A25B59B9BDEF827C5E191AD4C8
      511C72550EB2B42292EDAC58DD9FCA3FDC32FEE1A6B0FB492BA48618582FAC83
      1C2C07796FEA3CE69BB2297D959A23E62341EC2D88B44686E56DB74ACEE124D7
      72D6267A63B0241B16BB9826DE9C83214F91F182463CBE54D132072F634C3964
      E74D9481782B4B571CF07DA3F82657064147885002D5834F96142B4C63A7F279
      AA53BFA13D37824095C5381C89B187FE3499A7055FC99A5847BB225F9BBBB36D
      7DF09CDEE683E7F41EEEE07DA4A829601567183105DA89397FC53CB58FEFCE94
      0C59086D0BC524AB3F4AE5B8B6021A939BF39002D7284E00D0FA3237D2156E84
      CD395ACDB0A6D305F2EB0C8FB8B7BE7F1AE71F3B62FC65BCC4A99C85C1F8F25F
      A59FDE2B80F9E39B57407796B882E8C929A36458934999D2E82B0B2268535B63
      1EF04BE0673385B7F80AE40874563D6572C62A0C58B36A9B44DD0BB480588764
      1CACBD39A47A66519C71CDABEB0D53E25454FC36116916634D866B4EE3E56A48
      B2849437F5829D69687BC409D8A962C87F2E7EB1C9DF12A54637BAEAD50AAD46
      374D2171F7B1A9EF8B371FADBF58174FA0D5D4A3D870CF3E7E7803EB3D7FFCF5
      926744125A8D1E3BDBF6F3F62EB88F26B3E472A3407BAC702F7D4697422C5209
      1D8A0155D1EDCA3D04BFEB9330D14417A714F9B333E8EE8CBD6B001749D03620
      56A053FE3C390E6D1592B244E0D66151C148EA51C7BAFE482A0B760A558E64F3
      10F239C3596B37F4FF8BE3B9E1AB395FFD678CD89A78E3CB91976CCB591B40BB
      9EB6CC756D4D2E5D19EEACF4BF6464AD63EB2F74024F1EBEF290F14ED422C4A7
      D7A8EDCF85B17EACD41089F2327569A9C5CE6889F12FC0FD35E82831EF561D2C
      2A9E44D64959E02B9B25F172CAF5280EE88903EE5089197AAA9ED06D9A89395F
      3A0CC671A48ADB6AA30BDB548E4AC982D7B25B259C9EABC0A3EB6A521837D524
      E647BE5FA6E56E55C9A8F8AA95712C4A25C406441E575FC61A7493B2929EE1B3
      CDADB300DB5816F5E0B712AC5491E2E25CD81744C3A754A938158855990ABE79
      43410887BE975CE2EE205707608778154BA5EBE2E0AC7FBF84DBAC43F5ADBA5B
      3E5CBC195E58BB8AF97675EF7001324EC102605E223260B91325E270116F592C
      BE941E4AFD4A11D00A0E2042CDB806A4126A18E3E4F01C9E81C0C260A5B93079
      FE8DACA48070DE35D61BC4F84C941DE1E44EC2608CC7358C978921AA65A24AFE
      8F6B869922085A37228859E998C07A38E292882C8B473EC28FC95D2AEFA420AA
      062A05690818317EB3809D09302252D320DAC2232CF6F29588025BF0B09E4CC9
      AFB4E4FEC0C12440378E1CE7393F7FC4E351D9D3BC51815AF3883A9BE8B6937C
      51D6BBCA2DE98A0C034A366102F549D6588636C4526339866358D7D2344FA907
      AF4CF1DA401E8CD095EB4659A17CC27A6D8462283851100555E9A292BD09E2E9
      34942924646C0FC220BBE5D2C9F2FE2C8E434948E443D2560E6714F82A47EF02
      8F1D05916C1BC01E26DE362AA97548E79377904FB8FEFE058C72B8766AD11BDB
      BC926510B2033B479B399540596033C6EB59ED08C524E46240F318CB5A49FAC0
      E09461CDC752A0CCD8A242F71D9696FCBCB8C02335889CA004666EA33124A176
      8F7E84299EBC7CFF9A39A1A1021BA504551ED66BD458AF0CD2A2622093A80059
      B15F1DB27F60C2A258235CDB1CE98B096870189E9BAACA5AFF6101DCFFA7427B
      2585A812B0A7BA276018CC834CB73D954D92E870A8C0B4110098A646C9BC31A9
      87225C91BE7116CC694B1384B395B1AD53E935F2B099E356871E073F7AF3D1B2
      BE12DA542407D65BD02BCD892C846211F01036049A838AC86269BD5CB1576C30
      57C8163F7214646B6825206D9E0C9187BAA5E691E45F98F74D151422809348BF
      7B82B9323B2FA5E23EF1522A6F62A46AFF24EAF804F7AF76FE3F7873F1068B7E
      1D0613EE2E16657B59B805AB7CEFE3BC4D39C51580BCC5D67C6C43CEB0EF24C9
      1B24164491C084612F09407638AC1DE86F2475F80228B12FB33B64113912F5F3
      4EC3C5D2722990F45B90A9B2BC7E23157C2B1AB539AED5A803F515432FDE285F
      83C1EF75370CF7D3D1CE18442D8418EA079BFA201D166A38E377A7220DB1A22E
      081A813615607D43690DF464DB0CB13276F3C68EEA09D456E60D6A167EFBCD12
      CD14AAD5846CF049CE09CF3A2073E0019635C872FB216564735F47EE77880770
      B1508F51E4DFAB9B9B1B8BEA249C5AAF6E3C521DC2A0D8DB47F54EFAC847D5C3
      BA955ADFD2E60FD5CD68B9C08F4EA76D1DE0161CE0DA68E287AD16B5DB7CC9E6
      0FB735E8EA69EB7BCE5FB5E46DAFCECFCF8FD42A29C5BCC1F6D73B53B89F6516
      6CE145FA58449DBCAA0E10B871C68D8FB8DB259B64F55AD0B347DFCA86A8080D
      F5E5B1C4BF24051A1A4C832C5532AFEC4B8924F9A7771FA94E4118701CA94795
      3C7CACDE330F22517CB517DDCEE11DCD91AFD0A4055D6D48A8B9943419BEB977
      2B078C92788D3A6D7E7A26BA9F67131D9BEB0ACC1720C5E1320E9121A0608F89
      3FBA0A1EC5C846D6BB11962979FDF258F525A3BA2E5E0EA5A0D8BDF31894ECFF
      4168A2311ED478F282E6B560728578E5C02DB7E9E35520B655B110D8C873A1CB
      2B356CB7F990B11127AFA71120014C751795C809FCBA0D983A04446708F38132
      D50E9261F5035C8432436A9C53969915B2BC8BFE8FEF53B1F4E3A6507EE848B7
      1294113C85A355023A1323E40700543CE1BAF64903C04A628F35F6527E181D11
      DC459C4446592F84287EF16CC8F359E41B4692ABDBD773EC6F081BD3EB321CEB
      6D4E46E2DB04BC62874519DF807546A8579EA22898E1B78B9679D8E0835A21DC
      D52DEF2B926715AD4A4C31DB51F4DEC924EE7577D2A925BD47A7BC17547E9C05
      142274480E117E7060A8B2145547FF2048D11D0B8EF122F8EA36302ADB94C4E5
      A2A8CCDA0911F20B12BF6E2F821BA0C173DE19FE9A83C612F582B47ECA8AC453
      AD90E6D2CD2A014A68BEB9EF834B3A498D6111037F918683E8360641342FBBE9
      C9E561A802F7A60CE3F812C5F70DABC437CE97E319BB5AD1FD38E6BE5BA5327D
      14B121CBFC355ED0F73034861F603F2F0F66EBCDE325FC821751D9580EE74E79
      2312D950738232352E505606F3EBA55B8D06BCCB3EAC3098DC4ADB7574CB75FF
      3F45E4E839B0AEBC70A9F8E74A5B78C3246B61ADCF998F89D4671EF99D0D1BDC
      0C9E627B5DA9A8B34E4765DD80284D2840892E1195E13840FA562A82D43D2512
      6CA51BE1A99031ACACA79E7D38D36E1A123BF19862B9493870DCAB92F21D9A1F
      59584003024721603833564E616A3C67981510298E45C098D64400510AA9000D
      2AC678E822ABD36A959A592B13504CC7BF44BF338F287DFEAC033A30D6D6DD2E
      DA55D2300B8B5372C8084D546FD5CA3E3184657B6BCC3121B22267768C9F8AA9
      750482E6DC2CADC71169D42A879DF1A4548ECBF00F94ED879FBFFD86E838C14F
      9ACE8A460D4E85613403E8C9E22B289B655C326802A41184B26586C690D1929B
      8E2B622CF36A94A94B71156443BA630923726911D1BDF6A888F46C30AB7D8CE4
      48A5839EC27EF218B85B143ACCD9B554E28E680A4EEDE0A597790A7A44BFC401
      9F3A6F9C2DBD9033D6792050E8A88311177B902BD6FC1090E91E0B94A1BB55C6
      0BE0AE62C7E68B97302782CB2E24C4BF155B42FA418A38971259184BB2B24380
      BC0172B08BEED27FC38A5ECF32ABBEB53C0AB2C58394FB3BF974537B69BCA864
      E05D586E343CD19DF9F8A9B00A9A048B22B0243756EC27414EB883EA0C2767DF
      0DFF40D233FCBC0BD3D6DF98EC49ED81025F731819F9B8D6B30B23052728F990
      C74463133225650D0769A8520630A27491672E9298CA67C705B150CA65D4A286
      A1D800AD37085BFE92ECDB325B58BAD14482377030FE1CB792AB2DE26EA6B97B
      83630DC94FA9BB15E7496667EF3F6104952894B893865C6A1292EBC3283F631B
      3A74D6D134D0695770899963562D4617541CDC16A9FC803AD476CC71AA3A4E0C
      1EA92F16B544D21F58D2AD376E45EC07E67841A57C16A4E2F2ABA4EB583B4594
      382D8F5FB16304A9599535DFCDA9A84FB4A43690006DDD7198BA52C5BE58E01F
      264C652D0C8BA88674B9ABF211DA66CC8E36522365F806AE259A166DB22F7EBA
      786D1DA2F975740BAA35301034B924A04C8AA4015F3A52434A0E21533A535DCF
      5F4592E7BB7888B123DC2C21BB169C31C2EF4B951B11664AB36153E7111E3A8A
      37B7DE633E6FBC4CB1F946AA326438086106AA03B5E4A04878587DB1853A77B1
      60534C0164EC830C7C14A7515A24F0A1CF91A0A2672C6379A4EA5BFCEE616249
      240D0A314C55BE65CB088C4261470C2EA224BFCA490BD6A5547165BA5566F18D
      75CB3899522ACBE98F432FC5DB60A66ABFB7301D0064A5190FCD3320A6A87448
      653F20D37DA86C17729629DBADA83634ADF2191AACB0D106A66A0611070D52C8
      89AAC382AB6C10BA234D186A7B4BE07F77614AAB34A82947BC4F6285A1C7055C
      C7F41FCC98CF0357D78E8E450D53A61EDA8FD1F22CF1D0A4166C482DE83CF1D4
      826FBFF98159A9DEDC1349F1100BA4AB8EE22049448D90231FE72D4BD05A4809
      58C7186D239208068AF2F018CACA827B13DDDB45394FA957DFE913C4985A88FD
      FCF6C54BD48B17D8BB55344AAF43027DBB1012C4E4214A12EF363F521AE8E4D3
      1137000D3C641797B7493067D385872E7BAE95C2B675DE2D696357B6F15C3850
      3CD2F2D08C9B0511C5FEE5C79AC22831352E96AE861257DCAB1D91E93128326D
      C0E17548A1CF8230B5D2F8BA5634E9E1DA03CAE9ECA00221498CD7DC2A601E37
      E006844B41CA8205C2772FB1E3DB6F3E265E94C20122FF59331459394C929A49
      B2A5042E8AEEE3AE3C534E764D8538C5A05CEBDD280C40CE8B8E31A6A4C11429
      ECA4CD02A38A42A12266C066394ABA345598940881FB16CA72CCB1FE05E6FB82
      DE8021FABC0696AE752447215E076759A02F11164B3BE634142A310D04235C52
      11A2E85661400180D6A1029A4CD56517651982E6A02924C253D4E0C4A98376A4
      C20BF2C7B9832D7A48C3DBF5136964576B558E2938F20BC704B564AD38D94EC7
      B10E49B53CB1DE7819F64F3E2A988A01A163105E12AEFDB44C77E2FEFCF69B93
      F1E2441A3CBEFB7735F9FF787CC4BE26ED600700D8E5A2B1430697A27BF4852F
      B3497F83FFF3316A337BF92161BFCA29B6F8D01D759339912116ED6B071CA112
      C04995143D29CF94206ED3D80EB3227713375C3FDF9201011BFCF4F1BC7F2A35
      5A6E1D223387CAAFA7F0D65593633EAEAC0297E642028781E1E81CE802EC9145
      680DB16B8252225219F2B26514EABA384B4B250B205CAC0777B1CA9536444794
      EFC5D9440BF4B8492106B9157D27FF7E682C2F50EE27CAAA8DBDAC1E25251619
      53591E2B9ECBCF87289B5DBCE2F4BB38F459902E16DF289D423ECF28934F233C
      E6C66EB6C16ED67DE2763378FD281883D8083264F7096E60ED0230980FD9DA09
      B1B2BD5CC13F0528BAB403AD7D9CBFEF45412A17E0ECE30244340DF77B059320
      DAF33D986010DB3E2F602A409988F679018910973CFFF63ECE7FB68CA65E12A8
      3DD84B520A324118EC3516FDC35B787BCE8FA338B916D3FDDE86459C73B4BD3C
      0968C6584E978C49FBBA0BC9324D351ED9FBB802506BF65CB048AF85BFDF2BC8
      96C9A55E816B2C1725CBC5C52B63A3F8521B45EF89DB2836EA67E600D001504E
      76B7E472EF75CDA9F8D253D17FF2A7E2F10FC49E9AFD5F52C008555397AE2D8C
      A9D6478212CDB98E3B79520C85D179206B856EA81AFEAC107B40A1E214DA9F03
      F4100BA5C0251574C0551C54F2BC8E12C743697923B8EB0893EBA917CEADCAE5
      29ED8875C8B93E5E6A1D7CA2F085D2D7DF1D6C4AAA47D72165C3352FA328BDAC
      F542A5A5EB93A34316FB0B14921CD01FCB618BEB0B51E1180B11717C91C79D7E
      B0C52902113DB1BBF05DFE3A5E287FF26F8FEFBF4CC5988B8CC8EE79544C1E6B
      06A9F648B28269A0EBBEDF7138F30398DD0CEC2EFCB4FB6D077E393DB70FBFDA
      DDAE0BBFDC4EBF05BF3AEE006FE9BA36DED26B3B784BDF715D7E1A6F8153DEA3
      615A8301DE64DB8316DE653B701FFE6EF75CBACFED76BA5FF7D47FFB18DDA58B
      B8B07A72AA9E9132DADF30D6A3E93397D8E1228EFED685FF0CCD2DE657E6BDBC
      2872DD9AC384F160EC28746727E5ED3C5C7B50C83A3CE4A2CD8F0E0344CF876F
      4B5B0F837A6B711A3DCB8E65E02AB046446B6E72E761E993ADD85E01E5F2F81F
      EA59C77591313C08D481B190D17385C02A90107C9104982E4AAC5D8901261EA5
      89604A22910299A182E5744A122EB1203AC7B1290912AE1CBC628673601DC2C7
      0392BBB42E4CCD1C73F17E4241C7C5E03A8DEBBA87E27C0EA257FD994424DB26
      80F6812BDE84DFFDBB5AD6E387907EFBCDA9EC4CC7F52FD32C28F6CB93855E88
      1AA5D74146ADF88A418A85203EEEBD49790585CAE514E99C6562BEA02D9E8A72
      E2B27E5A2B103B9093FF1D032BFFE314D4C9DD44F91DE7AB0F54349B75296EE9
      00E4D91AAA0C74BA760FA54178599384695921DAD0F1ED435D0D212F13F28AF6
      B71BEB12906D6615A0AAE6B9EAD29753F754521B6E2B912C23AC7C2369B44E27
      974DA74ADD6BB6128F263067ECE9B97976A8C82F23D90050C5985A810EC0E618
      EEDA171D923BE3FC9D2B13A8DEF5BA6A048416C56ACB339C510D3B713316402C
      A5F2757AB4CD8A4AF0E6D070CEF859CF18A11A10E3447899ACC78920247386AE
      5A44D51A28FE5A16697874313D8FBE7EFC4C833C5155A58B6DD1CFE061734C4E
      73E57D0749265CCAE2D412A7D3D35DAC9E2399FFAF140E77090BAE053AA957E2
      425D705B7552F12C245EA16069531F315FA44152D0CF9A9703DF4C50AF6597E1
      202D0A66199F71D2FAF82463AEA5175AE3591C8C29BD62477AF8E6F48AC7A99C
      290B3B26421659D656EF1CAE85564079DA1D975B69C899EA230156599711C9AA
      59DC8664692395DD019D72E1A562CDA50DB40359DDE6FC2C4ACE668C5F24F134
      F1E6B232E2A14C3FFC57D5DEB01142317FF75FD2867044CC889313651F3566D9
      C739EA915B100BFE795193BA5EC5A8864291BA94301786425C441F23D7290475
      D63A43A2AC89B042DC6C96C4CBE9EC6E9D41D6F65595CE52C66D21CB79AE8233
      A83696070F09D528CE7651E197995BD91DBCC21EB3229D3944AA81A6B830AF0F
      708F2A661B7CCFA5D7D497B2914A9BE4D1D3301E91465AD0780E716F17491027
      41C65F5418B08E0AFC7C17A779BCD8692A7DDC309DFCC1577D425BBED3B54BA3
      314BE90B556A7F6375814771DB3EC5EA028FB2F0C64ECA877751AE5517D8C1F2
      E134EC82FA97BA62211146F3D8350AD6AA85611002F13CDE41A305491E6A6F6C
      96A9FFC0AE6D0CA8A29631C916DD5E4A6C0FF9966AAD5236D461116B2A1D2BEB
      ED80888E6D686E8BC6BBC7D7DBABAC308FA7BADF61A764481D7384912FD27112
      8CB4C83869CADF1E564DD9752189AF63BE6BB0F09789378DA3519C445FD174B7
      45C3402AFB95055722BC3D2ECBB9EB526741A8E4FE5C650B3A454F284991F489
      473F88FF0EC2E20DFCF71FBB3091A7F15CB068244335F9AC2D48C53A5CEFE07E
      546E47D6101D1F56CE4460ED40AE64B56407EBDD9D2015DDAE467BB140755C43
      8ABE5EDD3D8CACDF4988456EC020A61562DB126A59E7AAA6E9140D88D6BA5070
      BF83565A07A7AF49525A8376AB99CAB19524656CDC0DC20EA6968860A6A6A0D1
      8AB75EE73D49F05891F0928A5E23942B80FD2E304CA9D8D8076440E9D12543D3
      C65E182620FD11A80CA77C28F87F6725CB7AD50E13AF9B06A2F3F8D352E14DDD
      80E13B2EAFB9565F73BBC137C88AE537D8F91BCE6E93200C83F196AFA0C2826B
      43773BAD966D1D7EFA787ED23F32544251895F3090E889B8B01F65C10517B6EA
      46AB299BC296B51EA540190D7D7B84849B56EBBB56EB37EB7B6F7C394DE225F0
      176C115A9F74937C67FD2A435E64AD89D38B8F1F5EFFF4C3C56F922834A53186
      243049784AF6B1C7A10B01452F0A0AF839B6A8BB8F6A42C4C571E32CCF103754
      E02B5281DCFAA503D82A4EB3754851140A6D8E0C9BBFFB4C4B73383A75F7E080
      3FB0C381E31E288F26A0134E81C9B5CF61F3046EB890374230F2C0E3C903EE9A
      3C40ECBE602217E9FC37EB1C4DA6B237E62135CBFCEEC5E0BCDFFEFEFCBCB1FE
      B0CDFBEE43881E740217144D261BFA06142264885D91D8D5DE57A0863B3118FE
      1FF8EF2B180C1B143353697F40CE48D029F820346134746FA774CF76369381B3
      C53B49643E8A340352B0A8A04544107F241F92F532DFDF1DCA487BDA0418416F
      E131488054447E6868ED8A95395C071011D51136D34DC475126419B6D5AD1D2C
      C674FD4C80B245180C38EB61FA2CDA9975AB126CD6EA51EFBB79807D38882EE5
      6D588BADBC0446B7B28BDA5B6F0AD2D8FD7D51D0028F69B48FAF2E5CCC4F530D
      BE7EFAB90883D53A00E4CCE5A23ED48D5E36EB82413ACF2F2E5EC91437370F08
      97C33CBC5DAE41E4C1225C02D0D2D3ECE6F1436973B858870D5C849C7EE3C782
      9B69A9ACA12002F400E8E71DD225932B2CED48B74997C0C65D5D7F9023BB4281
      1D31D56E3EBAA480B3A449F29E3C74C4C256D95305743D567DD15444D1E3AB93
      2006EF448F0400EC62B1E12E16AB73381BD4022B7470CA30CE8EFB36216596E1
      3EAF2EDE5A93D0A3AA65329139984879731E703FF44204CC56518125027CAF42
      8E5F7907EDD3A751CF71F085F51CBF14D3FFA88514B2E7E1E73B8FF7BDCB0D3D
      41C47024623C3EB3FFB4F0E19436A6A30F4A584E90993C40BD55F72166D33E6D
      5682FADD04E4C0C00BAD976FCE9052C18B7C8C805094E7A4C8219F20AAB95F07
      D5867F3440363ED5FFF7E70F3BC3377210FEFCA15421D8B57EFEF054B0B0D310
      0BCF28883D8EACB3703992625850CFA0EBB0F5A980A1DB100C4A9AC0BC7202C2
      535940AFE102A2383AA95A84312D58AF2796BFA4281E94EDF03728F705A58EEA
      0B302617FB3273E6A5F404A05EC77A621C09AEA44A15BF7F5F520989B9976679
      9688EACA1CC2F9F26F8BE1212C93E68FE54DA0E56B8224CD4EAD8F0DB4566EC8
      1DC6D7E9E6FD97FD4817CB30E4F9532A5110C16525428F60B8CB5D8585EE91E1
      0E1BAEBFE5ADD279AA960FEC3B362510568A5EAE82870E8E3A6B873ABF58DE87
      F953655309D6BA237F14155CF312AC59A7BE9387D8E3FAD77CE4D263EB601C2F
      6E51413C3D3D25FC3E60435F300F42D89978D1E030898418617A94DB1BC7B911
      519B1E1B2B925CE71B8D8C9CCDECA1222BAE024024A622F2E4DEC64B2E022E56
      08032F6ECB3ADBA8378FE370398F18EE64B97F4784ED701A68ED99EC9EF02E2F
      857D92C5AAB0EC60401B27F566A28747C79A39E2A737AC741F4ECA161CB88B4C
      DBF24D93B876BAC9CAB67387D4F33899BF7E69BD4FC424B8D94A67BF0AB864A2
      C21499F1017410A008E0949B10515570998A46B1CB72531ABFECAD7C0119AB94
      A5416E16819FA3FDE8EB66A2A92F10C9FC0775CB018DB81427B2FEC2AE2C5BB0
      07CF322ED923C6975BA4669E97E883DA52E6668A95CA31F5B7542D2298EB6A20
      B52FA101C89ABF7AE654697CDAC35F4F7F5335B85068F8F5FFFCD6BC08F07FC3
      D9264B96AAF4EF5D71A83B59983065D2C7C4D55464298EBDB2A4C6AF79192FF1
      0567B0F44B144CCEB224FCCBAB8832E7112ABCD23802A8649A42E7B20715C82F
      D5111C87B12C5CC3349C21F1EEEF8D67446E734DEA0FCE34796E60B827FA0DA2
      9280BDF432A1D30D885E6A72498E94DB5211AFBC461CAE084B6CA17A0DD4EBB9
      A65B54FA3B95BD15B0A3C256B6C1CA55E59346329A08F41FA5054E088C201173
      81D957F92930D256B56D84DCCBB079CF2E340C9135A4EAA85AB3382411E0ECE3
      8737B41B3E9F81319E81674622D3F9B60D2ADD606311CE19BD27B8738989BA4C
      9CAA1ADC44B2275E986E71C4D80584DA184F89A584637EB3AAD93F13A10F53B8
      66D9A544FE984978632CE299079BBC9519E9F0DBFA0178E282BDAD87B02CE095
      B7A13862D76A7E6431656967657AF7E8A89E2F916120DF55AECDD3E92C866D92
      2E727314356763B8E43923CAB1053B9EDC721EF7A1AC3E4B0C6A9C2D8104125E
      223EA729D5600F282AE11638B38FD2D5CC9382AC1C5E33C1E68ACA04792166E8
      A99751C39CC27461D020CD8E8BAFA1CB18E63E8527B790EC5EF1FAE4B1247988
      450C1EFDD36BE984AF8FEFC848D0BE73E9E6D856DB7D4BAA6D9CA0D809C49168
      636ACEEE06A54F82064D6ED6040EEE329185F935F303A4E62276B275578CCA76
      3097558CF1B6694CD14B78DEAD30C8323C6C78A5A8752F4007D942F385F9C070
      24F56671A66BAECD00D8A9627DE55D3DCECD27D12D0BC1B89C7A8D9DEBFF5D0B
      2C3B9ECAEC5EEE00C7B884A717E46031654B0A814115C93926BD9B5570D4B322
      8FAA05EAC9352F20A29FE1ADB8F66E91E767382B863E6DCA582414C1738886D1
      EB20C25675473AA69AB42D4F86A42A53C14C96A91B89B1A7EB76523F06655B90
      804E911CC7CB28D3E16054C6842AF7A54D0A1248ABF0D1A9F5FD2DBE96C0420B
      A192E1FA3544E7A39830097439800F2868C10295A2806A284E40E4C940FFC9A4
      D0C28625B91ED5E803F511819345414C1A79AE5009A2B8B819E7742F17F7D901
      2ACC82EC0B57C11093B0CE9B5448E3520C673B40915EDAC919F65BBC14946478
      A3EC94434A3B1650061834003882296556290309D338C4A03AAC21837181B2D0
      258EBB0AA699AE36939F24D2AA89FDA04169BEC8609BBCAB60CA78AFED7C5CD8
      1273456ED90278704EE6285260F169B585E9C16941F2955594C8088ACF2D6238
      55FAD4A2F3010F2D28EFD4C62562EE2C1BF82188702020C8CF52E9E4489BA4AC
      3509920B08EC29B68B09A2DC9EA05761D1C121A8E2759C3001840229E15016A6
      4DCBE7FD8CB08C33E1CC5DE0214A37F72ED15F933105155E7A2B3D2A00076220
      2BB178C74C7F84B223A3B9456E77162B2CC83189DEC59AC1047115D6E74D918A
      D0284DDA7BD4C339624782442498059D1C3AFD488E57B0CF14EC68EA99618274
      B1E27C30124CC97645F1CD792200995229C858B1F0636916AB04A84E67972732
      BF4A4752795CA48731D25EB3747D243C662814CD63AE4D4C81B552B2DAAE786D
      3E095D3F3BF7B61C5B694C564364567E807D51E05C8B9B85EAE713447E00920C
      EA5AA583293D3241C2D58AA3ACF9A4FE5BBE6E22E959C1CF802393E318A85780
      D1E901695B2A3D584F611BCE780B1C75CE4E350E90542666E21ED2BE8C8CE5CA
      83DD1985A68D5CFD79791521A09EBF0C5232DE23443F88B0DEAFE515F428437D
      CAB5360B35BF6589FB9FE944A8A381D480CD7E74007D097BACF24EBB9143F6B8
      A889803EB68CB4D50ED8B9427D14E7F2232D533FAE4B5AD19ABB9A39BE39200D
      23C78A3A9C41F7755F7C761D5B1CC51E4B59B4684B88A4D16BBBB65918206471
      0DDADC49EAE888A4525893D8A498E85E7651A1D2FAC159797AA7A7A707F9C10A
      5453C7FC0C1FE31B91BBD010E4737C9BA7706CD28726F118F503293A5C070D20
      89DE4B9ED78A60023349A5DA23F3B494DF2DBC5DF570F2D9C7FEE09420109529
      C02B6A13BE5D6357505ED1C598B2FE12C6F125D19BAC40D4BC1103032E86C0EB
      33AB2D75DE54DB130EA52EFC17DC3D659A383AADA4965CC553ADF7AA403B9B68
      6FB254C39DFB7C5C302150D62E3AEF3D0A1F43557975B365B7A3553A1EA42B5B
      ADD1885448423CD69E554CD59A7018CABD4512AEFDFF64D889D11D3C5A662237
      3128B84AA953F691E749E1CEA3D1E061B4372547B2473D2FA52A2727330B4754
      BB3EE38DC220A002E29E5A2FC82A80FA6690CCD5E9533E6C8DB0656C27B88D84
      566795ECBA82C4FA3EC4F5DD799AF7888BAD00D0B0B022995BC52E3CB36C9B52
      FD644AD88FFC4EE17DEDF845EC6D4C7BBFFDE62736211543BCC8E75C224FAFA3
      5424D9A9563DE58DF3184D7EB01CF25F5F476B240D08F1D93249E1EB4F0BEBB9
      FAFC92B4DDB30F672B6F44A3932E0A5F18E962164CB2BFF01C54734D2F2B04FA
      2AEE440C94AC56F2E660C2A1C51319A34734B0C15E4D7976C1A4EA4DA7643F2D
      47FD609CD08733B5241983565AC84BBAB68D1FB118184D532A0706487BA52A0F
      AF83A1711E72D19276872A645ACD963CFF734AE1CE4194F25B008E58B7FF3A90
      46FB7CFD85D4414E0EBCF6B0BF3BEBC4517337CB2B0FDE5B2A78C4A594711E18
      5774BF24C195D3DB384386A605732C4F96D630695BC367A3DED3C80EB45B5F98
      1EF8B513797498D189F5A22067FCF4EEA38EA3478DB4C1095403A9001589603A
      B45653520E4FA1BADCA74F1067EAD902C7639F58EF56852F9545218F49C9A9B6
      974BFDF69B8B78998C0562C7AAACB9BA5A0EB3D46EC3DCCF586E9221C39B1909
      A46389DC704531B7807A12DADC11A941D0AF6EB2417393D357535DE5B67BB519
      00B911C3EB04194D11F63A75E6B87CD4A808E3FE9EB46FBF794DB135D69B77BC
      66CC2792B851E09D45FEA8A3A3F3F89AB92A019277EE5BC3871573C5224E593D
      558858089ACD6AA74D8D5A2901E1BB7B2548AF80DDD9325DD5D9342DD0AE6B39
      A2EDBAF76789F470539E18845715914234CCD3608DDF7EF382AB2F9CAC564428
      B510C94BA6CC319025416B07D0B28738700FBAF30DD60BC7E27B4C8683152335
      46FB92182F4B9949D7DA454FC1E418220AA2203D05127674AB03EA757609A5D7
      AD1E4ED9A4D3CB1F90C775B43ED244F98FD6476A92D3E4AB1884AA777D9C150D
      86A98AE2E0B7210FA79DC706DA3002978E313A72C91A8BE2BF9276B2783A95B6
      32328049EBCE9C38B8D6AB60AD6341CA1F7611C3A8658EEBE05BB5C4308F975B
      044E7F2F91AA1C9C33E2184B9F2AF129E499065754D410F34FCAC4BF3EEA529B
      F2C8DA86F1187C20D09B2912A3066D22F99B89FDD35183BEFDE67DC9B0FB9334
      ECCA6A3BDAC8A12D081CFE243269E89F6B934551CD59FD4E0E72380FA2659AC7
      EA1EEDA97046903A2BC5DAC54C25A59825D78B7E1FCC13A2E8068287B25287C1
      6214236AE6267792EA60B87A7DD393A29C1CEC27AA51E70799A1CE7960C4263B
      FBBAC19C12DB8E37B9229431BD900CB8E68E28DA3C574F009F17649EBCC3A7F0
      E4943D7F13769C14A4F082EF802876F3F80F5AA60AFC284C007D7A1FC8176EBD
      AD27ECD22779B0E2AB416B67293510F77B4A19B5CA0711896B0C9423039F7E3B
      59C94A0F7246753911D43826AAB345CAC8629CEB9590A133B85240B0D492D4D3
      16E791EC3D95678AE6836DE3004EA5C0840E5A596943F9263D8A8C6D40C2959D
      5C1F1999E7BA95239AF3F8B9BD16170B55CD56550E7F44ADB467226CEE657987
      81BD6B5096B90E52B1D90860BE879BF192F9539110567CB649B1971112641CDB
      3C153F26BD732438CF029D3155CE039A46A4328604967ACDF3A83C6A9F59B213
      19B254ED0991591C26E8679D11A79CF2E3A579CC075282FC80A3430F43D7AC03
      4A54A988B459E917550E049994836BEA937BB72F70F13A932146ECEE2D8814AB
      511AD20C89872D2D5716C88DB04A422582B12A7D791496AA33EA7547ED5290BC
      3995F50520D0536B8EE5171F4BF67817506FFD64D6F3F58647F71E27B3149391
      1F46C575755C55A46A0BE54A48D1335F60AF180941B8B3BBA4D93D3A6654E394
      CC241FCECC09BBD709E332B114F10187E4AE83A6CF517DDCDE573868C5A0C535
      6EB86A26A8330C141307E15E1160B80A267652E04BA2AB48158317E1AB2D4D00
      FCDA4D0442C3534FB590E8A226AB26D12872AB304B5C6091BAD447E36EB9AEF1
      2C8E69666C4529E5E82C099DD8F1AB16408147DA78A1E38E541DA462A2BB2914
      D0A85000A2C785DC4443F68ADC78153A654A841AFD2D9500CC2327F3C031ADAD
      D6871DEB13A4826DBE429BA9066597D7567B7873F4D0D597CD91AC278B3077AC
      3E56DE8C037332F394C8624DAB0A707168EE1C56199CE46934C09E882746D6AF
      37BFA9E3767781ABCEA9752683683961CDE7CC9C8C0624C31445D058E91C3329
      121EDED9AEEADCDA3C9B78FFD55248FFD68DDA720A540ADDABC814E2D4A035E0
      1565B50A07C1B12E2E51320DA89752AC01020A7FCB195CC9CC992D61C3759865
      0EC8FA82C3601EB08C93475E1796549F8324D78C1E3A2E0882AE7EED07B90ABC
      0DDADE1D200D834B2183400CB5AB85FE07DDF48BABFCFE4A4761118ADF72F536
      472B43054BF209D7A8DC04A7FC041FEAB4F0BBEC16C56CB3EBA30D3DD9B6B02F
      36A05D5C5A062427AA32A23CEC44B261921B0812E816E2D47A8D13CA9609B79E
      C4E7A99D9B4875A7376D8B8405F889379D2A02C5345A374E93096CD618938CA5
      0D93D20CE84A5A8AB04CE03D250AA6F44D5624A9CA08D52FCD6B832E9218003E
      2FB8ACD47E9CEAEE098DF85CA3CC3F46037570EEC687D5A40D82A4B4272D4482
      BE26AAD572076651F9AB42294515E19CC50B8BC88FAEE9AA104EAA93AA400246
      D0F3ABD89345FAE54256E83634B301CD54E287FC9D2243A28242863E2A2071B5
      30152587B0A1D0A64D65BBBF7647B613AED121F76A17E5BAB11011FA76F1AC97
      C4399A19F7BC94D36B4CE87F94456339218E02A65E8432254E17B79235DB589A
      42FB9A2AC3905254643029BDBB102543136BCE742265761B7BA9341815EB66F1
      E8AAAA25F7FDC04A399C30286B833551D4E5485E22672879478086763A2D329C
      DE50B17AF64605BFB9648F0C7032D4AB58F66A1CCFE79C1B1491B11964112A5F
      9F17BA93E6CF992759785E0049068C61A652A9861C1D81C342C17B7963403595
      C47C11C3D26FF342B1D71E07042C23D08CE469C61410AC20EF7395358E7A9C71
      90CE11A7983649C7C7AA854A3AC3CC2ACC3716A0EC8124E32D16AAC98D3E488F
      4EB4093F5F12402F00E28FDE870CA464327353889F47212ED149ACDACA1DEA4F
      7FE316C65C6CE2D8D2D7FD709C1E5B6767E95129C3015B9971E8FA06680F09D7
      1E1DD6DF7EB30AEDEF3CECFD763CC266A6C763EC5DFEF87DE072E8EB5A88A5E0
      DF35783631DAAC233867E00494007D0B07711C2EB1AEA6DAC615AF8A612895D0
      3DB8C0F8AF4F1105D85A3F06517600E469117A6391E6AAD901190C11C70EA40D
      D1709D1C3FC9E2B6099048F4A57F4D6A75EF6429AFC3984A2DC8951F719C0287
      DFC9CC130C9B5FCAD1541D5D101E95ADD46E59983590515D941132321871066F
      CD6535F66F2E235FA64BFDE8CD47CB04ABE6BEA55245AA9E0CF112F926193D8A
      650861351C4688118139FB9477369632CF54324F833C49C12BC84BC9329BC332
      8454167DB530D93D260103FEFA7F7E53DB41AFC3DEE498564A2C9DF3D3ED8EAC
      67944A260ED7D1920D1408D00D1547CA5D60FF314E368AE37F0AFDB4DE1B4380
      9AE9E5E87E66C3B4CA22B404374F206023E131042737711DAC00EDF07BA00C47
      0A520792CA58F56122E55224877EC18593254BD1BCAB53658F12292AAB3AC932
      416A5EBDDD872AF5876B7563FA9FAA7D8CE9A8B85073AA1AC72403C84AE65773
      8A747C68B143CE264B3599CA098DBD4C70A042109D906444696580B488B8AFB1
      BA3F36F82321B4F6B55800834B5E1C1D5BE72028675C79F09C0E4220425F56DB
      C67265FCD6FC655CD0967AA3C05983ED15DBF411BA28B81E37AD84DFCEE6BE10
      AB6C587E122FB82C14CA0A543B7D11536F06E0C8B204C2A120AF2219C67861C5
      7691B3E514FB691C6A3B3BE54B7315766F1A051988ED47E897F40BE5F6CDB9AE
      3ED74C26AD57F58846FB8A3B62CE7CD1FDA721980308A471AA0D8812F926B250
      AEE4485E8384ED4278608E24A1C0263EA9C52D068163055CBF8C6C03A3447897
      B2DA2E371C4939ADF89CBD451EAC57BD0CBD8CE620D40B41D84142161337089E
      8B864870919EB2911E2D94AAD5866AFFC2302BBA34C7B3406CA3D21D30F0573A
      539CA9DE2B6F62C0FCF4A0E80FE7B69E187374E7A329F7286675D72F7763F975
      9CA9DBF005E96FEA69F9E56B1FF9D2D80B3FC66FC9AAF70B00543D716CE54FE3
      F5E2DF3CDA560907EDF23A28529B0203820CFDD7EC366E603860CFB2D2AC2903
      D3570EB7F5775887DAAFCC6A3A5AD88E0A5EEA539987C9FEFD925B3F2BB69BD1
      0F1C5BB2B71A59C3C960B7F20AB244A878E1AC58B35F566C9136EC8C7B26B0E1
      01512E28D434969986BCAD85271A2074138B2F50B0713C17BAB05C14FBA5DCCC
      72B1C5E22258D2620D1EDBF5DDEAC6403C06216021BFF25A002A3FCB94BD31AF
      2955F6EBE70D84D40DDC214602849A2E245EEE4FD4C7B500CC4512637BBB534B
      9C4E4FD93F58689A236FA204B12615A3EB1D0B5E441DA9B824438C7D69F0F5E8
      D6C0683D424402C1449F5C6ACDC29DF0240E090A4A58A9FA3B0E61EC2D880B19
      D3BC024E496C3AAE0A1EC37B0E2658A02B0CFE89612F871E9769D2F487F7CEBB
      3D522D7360462ACA9F70D3CFC32E72D45015A9634C4B000A82B8D4C4FFC049FD
      AACA26C3055B9E1577F7DA2BAC4B150DC87BA1AB1303838CC95B0A2C6739CE96
      0936E591B6C0430A99930D9030B6B350F1D9936EA5BC18B57C6F22E6C002D2D5
      13EAF19E53F300B217A6591C9338448D489648CF55749EF5316F9F8585249629
      D5C8F6A4F1B10136A6F5A75EC5874785BA519BB65EDC504914D66AA8F438F9E0
      8AD8437688EDB0EFA0285CD0213B0BF980904957DC60112CDCB942EF0536FF32
      E7A11D7D2380D91FF0EE1EFCD712C5C98B22AFE3F02C26B0A5E8021531BB1547
      3AF8FED6FADE4BC507428203598C9B1C24A3FAF4BC1B857232B64C25ED170248
      392A84FB6F72F419F695D1771CFECD227D92EB625967AFDEBC41F4C17E721324
      9A6375EB1626252604C595C044F33AEAC7D65F8EAD1306F0BF5997E2365DEDF2
      262328606F38E1EF45181E1CEBBF7E0262A5F6E7757485C2BA4E0F3AD8A2FC32
      F50AE58E3239C9D16C54921529F028F3BFCA1556475F75F8C8F9959281B85699
      EADE21B388E05578E2641D17AF58245E6FA42ED242D576E846E96048851E5DBD
      77A5D00A8579E479CA8B525C89514AEEB065832C2DA346B90085F19455A610EA
      B3A22A63DCDD2B3415285AAB98AC9120910FBDFB6A402FDC22DC16E9089E125D
      D813232C9741E813CF5DDB43DDD512A30674D750B618D09CB7684DA5AAE5A6DC
      AFC3A780F903FDDA038AEF52CD8781A8DE6280828E0D03DE06E09AC1441A90A6
      B9C86369553C69B113204BBF4577BC0C754E63167C38BA17306A7C093C0ED929
      0246DB00438E76859D60F33C902A1458E43BBD6CDB8E96EF984F6CDA008D2DB4
      4B14808B45550ADB5760D77A88E7CB281F4EF1AA7CA5EC5A3C68686C28287B85
      C0E4860EC838A190ADA98864C82E279B6C5AAA6C309FD219A064D9091A91B265
      54E8EC22B1080802883F4CC43D6EBFC2E9189E851D8CF14C8126314D489500B4
      CFCBC1E0D71C730D1340869EF2C1BBB87865287D63FFCA8194F8CE51493CA038
      7CFC68FD486D694CE68506D87B154A429D7C1BDA46283E8F6539A07AE8481054
      24A600F38280A5A07E6A7D2FDB15ABF6B0A4F8C4E4887CFBE2E223D0EF91A606
      3AFAAFA075C974301A975C1ACFF0586153F7624158D4B18EA5DE41E25388E181
      14AA8F6522E365A2CB502C23D054647E281E53223C28EB0BD6ECB0A22E2C24A2
      468F47780E1FC436B210F14295A0F263B45C10F3F4E0BD62A1343D984F81AE10
      11472311D2070E00A62C764AF02F0517360C26CF05521DEEA2F5473421C85856
      A5D602F88ADBAB1A3F31F5948DAD615BB1BE16DF1670D2BBAC327FF002BEE301
      D2BB5B75156A2234A984BC5A3661D3BC08C9C4EAD4A8206CBACC6D65A2D0BF5A
      6A5A298142EB4ABA6D931A28B27E5F02AA90639DD047AE96F4D266EB6DAE4EC6
      A5B858DDA45C55732C1E3E6A0C782C777ABEACD7EC33AD9B7CCDE4820679DB1C
      3BC98BA1B5E0121E3F5C3288F296D0B0E78D0041690E0F17B2FBFAEFB025BF00
      89783D7F19C346EF2066F7D47A8F2552045B1F18BB8164E9F06DD9125BC8EC0B
      128F7CD5C62CA20E64DA32E1C7D625E2D8358E40DF2458921D1666C49A7AC568
      0E02E1958CC4614A4B66E13426ED833586B1348649EA64AAFE141C6339F7213D
      0111B13E262495E125796BE842A11AD40B9A7BE62E60A3727EB0D10357BCC53A
      2406852DA4D6F5C3A303CDBEB80FB5E22E945C8E58D0BC43E42AA7DA38B3D23D
      6852FC20192A99A5C9AA27BFBC6B6A4D6A236D3577ECFB105AED4236A83497C9
      7C4C607C00BF496EFA450246D7A87202670C90C020854CEA2299CB0030992B1D
      97208DAD9110D25F35CA6532A48D54DC07A448348970A45C41B0E3A4AAAB80D4
      5A4EDE9596BE237935C438FAE4925BE9A8283C4318EB2D13AA9B15DBF9A5B651
      1F5F89B1D718DA6592F0574B9194005980930A205D292FB295D7807432EDFC61
      CFE1AB8BB7C7F0E30DF3B037F1D82377A16C56419530C85CCE9170A128BB05EF
      A89C664E4DB5D24FD6CB0F6262FDFAFECD7F7FF8AE45FFD9EE6F487D947F35EF
      1E36FC03CDABC3CFA7E2C6847B6F00E2A1EC95C660AC7DD0768F9499DBDB006D
      44EB22C475378A42A223C773145A467A968CF684F399F8E3D857BDB00A4CAAB9
      8B8FBDF1C0C553B4E7168DB959E2C966C21F9452EC5BDFDFAED9E4E9A497ADCC
      E63C56679FAB3D3BF53D55A55D4A14E6BC15DDE98F9ECC59DA9987D6C09BD812
      19191AC5B8C83C30298952A82BA75F968A4E49D7361793471A24E623E1FB6513
      2A909D2D9D764522A11B50E250301B4F99D372BF3BD2354CAE0EBD317BCF1E7C
      67FFA8DDDB1F80C4FEC46436DF66D52B94F71B60F0C886A791D8B40986765693
      85606188E54662499091D15A19BB1BBD391B788B79A339BDC8486FC7E8126F3C
      8E97516EFD9F7B3E9DECED7CEA7A12B94E2D8D8496EA6C422E0D12EB7164BCF9
      34BBE12EB21BE89339168D114095BC3AD3ADBBE26893B6648E8C86187749ABA8
      8658FBB80E10A5CA7FDACB13717A16BB98B03637379C55D7743C9A0C8E5EE9B7
      766AA9524430B3F2E893181D25C83C59CE9703B6135FBEC21C92DA3DFBF56791
      DCFE666D880235C6F306B5C7CA68A8BD42A96AADF9F8656E7EC79D44963756FB
      F8F8AEC313191BDA2401206FF8A70BF2C77913AAE39508645D3C873A40E12396
      EC3545C1B21B5378C6790A0F45004B33C1B1B48B1F938F7C177E5E4C967D02DB
      F5ED37B0612A1B8782DA39AC711DF2A9CA90A77D82BBF3AABD18CD152EA7301B
      925E54E89ECA3769D4A6A0D4B8B410387C28D338828975F6F1C31BD4B56622F4
      CBA5E98E0CADAF833113F95FB160CE6F9C376048FCDE92787275EF86563071CF
      AB9B0349855FA1D08D1B0B8719C9B20E8B905E79D26B347D2F658C29FF3DD529
      6F309B22859299433AD96EA591094570C8A48A4F91CFBDA3F0AF979CD5929B73
      65AEE781F4F11EE8FCCD3C04EC20AF9F8B8B51793755EF3EDD097F213CC1C3B7
      1B5CD9CC5528388C39F4B1F5E9E58763E54A7FFDF1ED01C0EDF725A5E490ED7C
      21A449A3F6556D0AC74F57C50559E24547B731E6626833E6C372B433A3C42460
      2FF6C1F7EF2E2E9EBF79F7EEA3CEAC820962487D29C1AAB10180692E870F7056
      55B9FCFE3289503B9A58071798E6895828F10AE31F44A4A3F3A8EC05284F793F
      006D6F04C8A912A6E3781AA1EFF08833FA05A85E07AF2D0CA3B27E99D5C7E567
      D6EB67738B62AD641218CE42C544AA8A1F2030250898A3AD8A5F63AA1EEE2967
      27708A234B890ACE2FBDEB68BA449D0F6B05523F26AD39A6F112343F2F48220C
      FF0C7D603263C15D4575B002CA86D24282BE23994288A424C2FA64F0295D72FC
      D6330CE04D84E7DF16533CDAA7CEA94D802BC49E17EBFE3709509C0437CAC99B
      36A160E2382FC389DB843110445431A523176DE7C5A4B74280844A7656C58C50
      24E22C82756E2F0102F78F39AC271579712315CFE1075781BF54A7870A8A17AA
      8B722A32D690A7B84B799E47B7994A492E6773C399DBD2E396E7BF165771D628
      4D380FE885FDF397630A270E2644D5B9F915D5A7CB932C1029E65E842129C0D3
      67A04C1C62DA66300E32C94F6E659155153F53F8BA505D1DC89864748A929942
      500DCA1C25DEF459F4EC2556F201DCBA9EC52527B0290E55551A7BAD1E94CA39
      5A4D1BDB6C876B52ECB0B419181E5FECBD30E3A098C362C3188E4B01AA7BA43A
      CC292B1F19D3234AD73287A216F66F630CD103C82619081A244F1EFCEFE57C01
      ACE560632DB07D39198FD0EF2C4B42EB2F5C1FE9F185DD78539D36795224ABC0
      18957C33552B581322D2F068FCE45D019B4E41742F8482EF0BFA7F7DC6700EA4
      E2E3AB8BCEF38B8B5740701B889EBE75FECE3DC61C5A8FD477E14F856A7A0A1F
      B140D865AA9D9085946050D24064E2947DEA39812D7394E786743E3DA654578A
      FD77B4D333921B7A4CC5E3E578F9ABB1B518E59FFAE226CF71E3BA9B419A4B76
      A7D6E1079597BAA645B1588B6A16D614984C4E8FB0012EBEE7AC014CFFDEC420
      3293458C66DE28A09CD874B69C4C4212E24180577514306E5D69332B0D755696
      2CE171CDF1A2587519ABFBA0A6C3A924C58CB4D2E3A9CAF9E3B241A00A4E40CF
      A49CDA20C2BA2F9C9C151594C89F5EFCFC9615482246B919CC1799C0EA54538C
      B0A3DC1690A80B79D85C502B5D3680627DDCFB0495396CB2C9157950BB699ECC
      B782F812ABC7D4732A48399D196B6804630971899BA91299B05C88AF0938DC09
      F8368E61C34089C9E819AD0015EE6018369EE587F5ACE83C024152344E1CA2BC
      47A0661C035CCAEEA7B3A98ECD16F98E1BAB0A34C16DF60853C54180CFC7F2A9
      266812021D8E40BECB1334B3D5FBE08450051FF85DA02C85BD60DA73F4FFB3F7
      F64D712359BAF8FF44F01D34B537AE61A78CEBFDC573673730E06E6E1BDB0BB8
      7BF6D7EEB8919252A04125D5482A30BD3BDFFD779E73322515145DA2DB6DA3DE
      9A98B631A5929427334F9ED7E7C18AFE3B0EC8A2F5B580C532D755FA0DDB0EF4
      B1F0F3B1600CC6E7E628ADD1F26C2A612E173983A89AC037CF60BA986F0A89EE
      D7ED6B9B8EC29634E196020EB04EDBB8D13886DB1B3705ED4A899DC353D2AEFC
      12ADD1F24857E254C5C5159C78B0B4B1E8D0F21B733AD346418AD934151572DF
      82F1DB3C6FA9A6FA52C6C57B0A57BDFB0E41DBFC2E264AF668D4B4D8A15721C1
      5D02A81E30430BC629B5BC3671599CB5DE3D9535DBFE855141CE95B5BC228405
      8F388C179BDECB5ACD8396C0314FD03BB8510D4BF866CBC2291BFEB005493FF8
      D8F7558619E75BB2B78E32DB33617EA9D05F797C481F5E00D8E6FCB2E8370470
      2FACC55DDA7F79FE0893E3B802719092BB542047448A115598B263876D4DE5A5
      6418A0DD1398799BE8659D3DC1AD2764D045B972E6DCA8CA91E5CD0EB9C30851
      9110E7D0944DC89A927839008491697D9C6509F88F2D687B08D3EEB8614CCD9B
      44A05C124EADD9E0A34DC53ECA6626578CBC4CEED543F258E08D707376575A27
      1A58F45C2F6CF2C27BCE71C0BDFDD2F57AF755AA69F14A92A294505B1CB43247
      B1E21916815528D6D2222E5BB94D1DDBBE00D193AA4CF39EF624352F6AD93180
      8D622C8E1EBDFBCA8BEB434E61EB48E54075FB08EE131DD061A452814E31DCB5
      5505BBE7ECDF031E4422A7F24A859805AACCCEDC2F6ED9526FABEC2A33406FB1
      BEA993C24BEFCA83E31C95A99672DA5951A22A51098BC45A799F47EB765E2DDC
      6DAE24DC6FB163F44DE5B58AA9E65614D1FCEDCA22ABD0CD73C69E5E798FE69C
      FD35403FF34D76FEEA1CF1917146870548953F70DD7C5B0809ED55BC2FC91D1F
      7CA3BD2B34E0E4B2CCFD3AC525907A451A74E63DA2155E108C93796820A22B02
      2AEA09AB63E63992B41F8DF3FE2A63D81B76DA0BBA45B303EE2CB73BE52E006A
      0A4DA72FDA89ED9537868BDEBCA2591731B7F95E480FA354A5F84B0FB7404D61
      5185B2B3C86A68DEA571A6B6628F4C0F13DAC1395FEACC4B5156A59D22EF2A19
      4DBFCCEDFE9AB5CA13C35002D9DD7B88ED53F0F1D550EE97F7B5EAAFD0401210
      C1E366334136E747DE7D3BB86B8C3ABABE748266D304CF844BD3D436584DF788
      9E91374540E3AE6959B5DB2A33C4861D90177EC994AB8170A84B61D273429087
      E62A669065737ADD918D607FDBB52F251D4B87AD7C15E50A62C9164EA469B9A9
      4F1003584B3A748B93958CE5FD7AB34257BE921A1FE5B03CF3F778FFFD577B72
      930BDAAEB6030857E11137183603375EA0FE06750E283EAD7E1B98523943FA3E
      7228E6105A1666757943BBB01EA9E80E923E5ED65807741E730B932C38E69425
      EDF6D25C7288FBCA5BB6CDE897C7FDF8A8A15659485BB48612AEA69F2F70E6A4
      C9E2E2726973936EACBC62C1AA65E1C67E41192CC10F1B5D6CA7EE8EA46C0114
      E93F529CCFDDDBE74553216B6F6108A27B14621579DFF9BD3DBCCBDFDF59423F
      203ECFACBC7C4D0DBD5CC3C6C536B9ABF864C1A35CB13ABD7CC818381509E171
      A61EE16CBC14ABEDAAB0D10EF5ABD6C22FDB4E0CC00DE8982AC4F522E5B80FC8
      5E2D6F676A7AEBCC01824F760CE330ED319E21B3A6EF6ACF5DC792AF1538DAF5
      72B2525CB2549684E73ED6AE40ED5FC926458F0F16119603F8C95911A625CB03
      9FB84B4F33691C56E57478316C21FDBC241A1307280B964A509FDC0286597B16
      6278960B1C5972A1B9B6021804BC68ECC17FE7EE2CF942EE99E4EE449C752A2C
      795ACD1129293E260E304F2F4BA597A5ECEC9CA8DBA59647995363A79BC3C21C
      28558ED1A21DA2AA1A335D118FB1109D0294C858D5261DE9EF6D3A02D6CEAA35
      F26931A3DEAFC08EAE806A96A6FD26A8B1243673349642831C4960EBB752E92C
      9500A68834D0262155AEC5F4C0F6A9ABA3ECFBA83B33561AB54C29AEA11B5034
      AB33688FA25AB86D746B0177922D42C9BD5BC4A14C32024BAE99536153C1ED0A
      DD543A5B85DBC9E5B89BEDB86E1E5F71AA85F3FAA07D73BED5D1BCEDBCD59F16
      191DFFB444BE09F36F176E1B2D0BDEFAFC6DEAB771D4D0519F6A6458D485DED4
      CBDC13F643444C77F26A856F8442EC9B30F6C1012DF3643B81FEEB23B840006B
      CBD2FDC8043046C4CEDDF1DD1959EDEE207E7F1ACCF2A878B041DFF9F8CC1D7F
      A4BDFBCF15131C84CFFB23CCC2B8F78899A6B1FDDDE371D15EC83FE1BB35E63E
      CABABD950B00DF5F5E02E3E960DAE94C3EF70A588F38449BCB794E6E2FF3205E
      E25F50774BF80E4F6946D7D7C7414FD4B067A14A68E0C85D15AA859543397E72
      7C78EE4C010A006BD9C9B930714D5DF62C94B0FDE922E658BECA1A29BEED2DD1
      AE241A76EAD8E0867D1C84C6098C500D94D32948A74A3267AACE8AD769055796
      BA48B38BB49D3453267CCE901A91D522736E7F97E9F41A6EC7A956D17376063C
      2633E3805E0DFDCB96BFDC5258BCE0DC1AD902A4D639427F342AC94316295855
      1A29C4ED2D7B023F778EA219D722A4FB1F9E654B277345F938FF09807E63580A
      B509B9348B9C5906B2CC901C97ED61497C91709FCA0218FD4BEBD3AECB8DF1B5
      769A249B21A45E5F495AAB8FCC474BAB375E2DADDEF8F3494B74E5C69A5CEE1F
      170CE5A50E4F8BC46CE9E24C62717D98B09ABFA3FF2F09BC5ECAC5C4CA8AE2E7
      3248D33A6464E6F28DCCD127C1540B745B3F508C508EF932EBAB6B154652C9AC
      1C17940D28200309A3CD5A48111CD37CF00B99E79B5AB3C4C03A7C2DADD5A07D
      5858709BADF86BB7E2F24E5B9F52BA27F3CFBE1B4BB3FCAB6DC8F2151ED89375
      DEA17012502180DC24193F4929EB1D26101EEC75F63EB5E9AF1EFEDADBDBDB95
      BCA27CD34071D4A967B1E1772967618B7447F2089C259184CAAEA9AFA91CF6A6
      00D5A820AE1C0D0D859C253C1550FB3B335870D918EACC4DD55C8DC27363F1A6
      7A16F25AAB2EC68D0A2BABE696366951350E8E497AE788E352587A569EB2491F
      B337B96F5FB63636075A3CB0A8650BF153D7DEC5543A147AECC74F3FC9EE2AB9
      B5F252B7302193D1B94C86FC381661005370EC3985324AC12D91A40524FF1D7A
      5DB36FCBB18495A2BC79846613DEC0567CB89FED38A11B734239A9287ADC934E
      8F998A25D471F7FEB58762C8846C2F9D75F26A41648936AD78777BCE6BF1F844
      9B659572AD6B865D61BD070FBA1C9C9EEBB8E87562EDC145F1C6D72CCA7C6689
      F0D3A13E6641EAF076A3DB6AE08D72C33B0D95F60382641B9B6C690BDF978FB3
      238732EFA5EB50DD61C15BD151BD5B09D7A3C2E19264F288DA1BB0E5C86B20EE
      BFF67261CC237360B69899F7A6CD72A92253E5691AF5CC474B6078C626A8FF66
      D6422B88AF4DDFED26B9B02AB9D07FE2C985EDAD33BB389EF3AAF3CCAAB3FC88
      A104F1EA2CA1E58D634EBA223E2F44C9F404AE9B12AE77B69F0DAB2897DB9455
      135254F504D7540D91BEA6E30FB29468741EE6518132B2534516DE95B2C3FB5B
      D416F0CF4CD7818048A1B4070DEDEB3186F8E0A735E732D69B9A2506A7C94CAE
      65DEE437CAC29FC5F55A72418B6933CDEE2691C8B5A8F8468367E61C8A5BA6A6
      509579218FEC1764C18596394B92B57F9952B2D430703E3D3A02E22511F36344
      5116059C4B4FB8A9D150C2774EA2A8D209D840E19FCD500FFA1CC57D2EBAD64D
      4EAA98176E8B97EDB3F7BB4FD1B16D72C841D66B1F54D9280E005DB5819325FD
      AF39105179A112D888FD893B5FAD5364699A5E7F494960DDCCD384EDEF44D0FF
      B2CB74115F3959628A992BCFC5F02BF420BFF4D68F5EA42BD6E0C6CE7E38718F
      39889312848281D966F39C8EBFE46663742FFBCD6BA4D5AA5145BBE462EB9823
      622F8AD058D951B38AC37AC97A7F64CF38B7DD6DECDF55F6EFE0C9DBBF740870
      8D33432E22066191FD3243DD460B680EFE386000A3C79016A3ED84B614046CED
      9109972FB8FFE4958EC38BB8FC3441132082F750AE97A1EFEBB89147F87120C6
      7B81A3FCA0A8EA84C14D3FC50DF3C05E62F75BF1EEB62B1B9F8526B717D15990
      84468A90D79BED963AB3E0CB159ECD9A4BEC84B65D080029C4FBAB5AF317D6DA
      E6A87EB8A76C6EE9E37D4D0B582C20266C61AE9825CBA7E815BA4FD1B3F6398D
      4141FC5214B6E6CC6E1D2E8BFDFB42EC2B78902AC40B1660CCBDE5A0FE2CD35E
      EB2EEDAD732872324A64D8795C3FA80195161F80DF8B83CF01272252C1324631
      3B483A562C12E9A8BE3F06C929D27B5F2651D11E4EDE4A461B783197C4C14D1D
      703CE74ADFEE32F4294468EF64F286C6B891D7B65D3F45EC46CD98390C1785B3
      FA698E339D9B66276C988E4D328884049A0775615C26975460C9B8FBBBC00967
      2984051F1CBF1E6A378B7E62912577BCB228376AACA61A03C5F67E040B44E14F
      0ED6D2BD687F5910ED0DEEC7036A0862AB11897950AE0FE91E81404C17F53759
      C5B3683B8B3833AD3B785C6694079906BE20F4ED16E511FC668F4A34D0F55C81
      C96D42A4C124CBF7A7DA3790A2894F0A7096ED824F873BECE686B6C0EE683669
      7A05E76846964A8264AE41F10A4BAA9287D765B9F6F24FD3EE88FEEC4EFA3DFA
      AB371E4CE8AFFE6834A0BF06C34987FE1A0EA6B86434E8E29271BF874B26BDC1
      40BE8D4B68818FF9369DE9141775BBD30EAEEAF6E83AFCDD1F0FF8BAC16838FA
      7D173C8DFEF76765D9779C57F8FFDD097EE87ABAF8C071F6EB5E7EB0512D85B1
      C7167CB1C1EC660E2B6857D8009BE5FF4597FF23D63DFE5FF772F95FFD6DE26C
      76CA3232AE1C6D1C480F5381F7D9B1D0916570DCF9ABB31C1CE7ADC4B9F62FCE
      6FB52387F2EE8318EE34F2DF0DC5FD2BF079ED18E3E2E101579F4C83FF9C0396
      9E47938D14AB0BD566621631F6F092E1B371121EDE6C258D19FB85E70D2368F8
      FDD5D1BBB8F49A73E5B685168C7EB73E9DB79C114CB5EDBE4735B3019F302C3D
      C9230B6F8E41065545AD31F721CFFFADC1427B812905C6CAA32A16CD7DCADA8C
      2BADE796E418D9458378636A9671B171D7056C66A99550B437A29B089928C135
      63E252D3AE9C26C9A358C9458408CD17213A7E3F0E975C86919FD6489DB71D48
      8DDC9A4C9072E4FD9E65C5AF11039111CF001A50218B790C8EE979620252241D
      6F919505A757FA5688BD17D9264FB4324F347CE27922D07ABFC539F3EFBCF2ED
      A6337B07647305C5DC539AD8F5E3CAA33F7F6F87C4BA63794CCD1BD1516C3895
      81CFFFB298A9E7FF663524FD548C957EFE7E054951A3067C2041E3C3E4267E29
      B1693BE6076615C25935EA8DCDF4F0E16B792F3C9C73A2DD1932DB806D2E89B3
      861BFF3FC5921204DCB5979DC0BCFA307F8135ECECA02C63D77961383D647517
      1FDAA374570E6873CE72FD536A7A07B29CCC8DE2EC155C5013A1AD1F17E517DF
      F7FDF275BEB8BF751C673ACD3F3743581D0CB587A5ECA22D4579250D8DF86556
      BCAB3B082B2D8436D0FE9A6F19EB1B2EDEABDCA246C62BB33BAEE5ECF877E2EB
      BB52D336334CAD26FFF56EA932288C9919C7AF66DFBEF8E48220FE6BF8D192AC
      945A282CEFA7BDAE1F35F8476E6E1F7C9EEB96372E9ADFD71F9BA3725D775186
      EE2E04BC51CDE244CAD55176EFA4DC1C945547BC22A89DB23FD8063AC3F5C500
      95A8852D3390EE721EFB327D98ADFA15B0D2A24ADA72C4F19E785CA1C432F268
      8A85AB84AFDAAB147BDF4D8AC47E49ED2C2F93DFCE0D3E396C586904CC8A262B
      3666D10998C0C0656C9ECDDEACBD37253A416765962C524FB07CC03364A8A20D
      E2FB7AC03E83786CC8915A3F1E6A3DFF89B6FEFC1641209BE07D81D43AB01537
      5423F752FB15566E754F803B4B121469EF169204965F5A62D3DEC5DF4716BFE8
      A335B13B69D4520C1628CDB44CD96E0A09947370F4E68DED1A50CE0FA76F0E39
      A6EE9C1EBD3E2D7F8FAB762D85B306B3478DD1AAF476298C481BB6A0874770EF
      DEEA63B557BF5139D52837CA9680F60BB42EDF362F893568A46ACCC26CD5D32B
      D4F5B247EAD33BC2F546AC17350F156C0F5BFE643BEAD0180F78B6E26D6C678A
      057454E985CE052175A7D0D921C295B3F5ADA0C0ECCA76F1FAEACE00367AF161
      FFB3A4AE1102808DB2AAC4B46DD37D6B76574C25190D9DE8F9ADB383F34490BC
      8B42446120B2502A500269C288E407DFED32C838545C0921BEC4352A07BBF6BF
      6444A5A14BB8751CFF9D543E738B66D539DA9CBDB5C5E4EC14F8431632875B85
      6AC4242ADD4406DC1AE9247B971505C0A672C1E48B7091B0ECD90EC4B7C5C15F
      B02FF36DF3A438503894F177E920B097EEFCB53856ECAF6C499EB2E426B66BA3
      7257E10560A47DF23FB85DD8F39858981BB3CDABCD531D849F1EC1D4322F1A16
      43C95EAE3FBECAA390EC06611FD38CE029811C17E3A557610709960E10BC0D67
      B5B80A8A21F7D3DCC67EE4DD77ADAD2A5023D6807A9C87C3D5CC78A8D05BD3B0
      6E752E6C56CBBC21E6241779B7B9478351CFC568824524BE1D7D5C9FE0E10795
      C28A7929495B4B02C6ABE8EDBB73C7D053A8F8B6242E5F7B4FC14C67F36C6630
      A4CB5CAF9975F957989A650D7EE78D49B15ED11893DEBBE313393B023C4BFFBC
      494394DAEE6E5CA4FBD2BB2FA556C926BFD4666079E418D5FF61B117CE93DD39
      B5F7DDDB0A379FCAEFEC3C6803FB96D87CEB633405475BB528BA202B59DA73C6
      15782C5AD64AE15D2B3093B31E825F641BD6E37BEFB3F468434D47EBE482A983
      D06616A63339CA0CE733374D792CE3A0A2070DE3024E29FB26B9C54530DF6426
      9E8BD0D2AD799749E8095FE57FD6699DCF2CE97C8B0F8AD6DBA4F8C52358738C
      D04C40A4EC68BCCF766765B6520A55E8B335E2309EE64E65829645CE8D7FE66B
      F75F63D7829FFDF2CC95CFAB214B439FF708B1490C5DEC0FC674BE6B50B5990C
      7C29CA81ADF9288528E96CAE225A0E5C2C9194B60D8556645E251182B830B774
      6E99A94C32A231F3587E01F408E51EA6A7DD91AC407E33E5780D59562733B3E6
      9CBDD1FDE9B4B217CC97EF8D9F7460FC24F1FF97BD2CBAE5C1777869F1C79433
      8F1617615C157ED1043F5B4455D2B7CD81FDF091C35DB9C63500DB3574C9D1D9
      9BCDA9BC6C0417E75FCE2C3C777D15DECC8599FE6FCEFF7AFDFAB5901A92FA9F
      CD25536BBC9EB50FA41D311360A880DCA6F2B6FFE7AF7CDFBD825D3620B76D99
      972B4FB017C8188EEF3B528FE4E0FC1586F7C6AEFEDDB6E929B9D94C105FEC53
      3A2336D6F3CABE6504C6C1C5608FB362F1667457A6D022AFBC88B3551274BF1C
      26616BEB2175F984B7552DD8C57E2518C92FB33E6671C905DE2819E4E39E89D8
      8B988C93A15714F0A7E80C0D003552B18AC4409415BD4155AA45E8A0639D9221
      F4B3E63A6E9A5FB6F0B0FCDEBDDD3F29CAF29AA20E7E63B54D45620FD5DB3C7F
      1D7E7A0FBB923670ECE9CF5D50B676C65E7CEE0AA33A637E9B7CE55143497E8D
      814B7B0FB6C2FF9C89FE6A23AE6A208383EB5C8882426163259B20217B3A1EB8
      140787D4EC844F5443E7A3EAB8963E7DEBE8EC240C3630D7B50AD12235977CC2
      5BEEED29CACFD48610A812DE34A2A9B6BCF142E654AC727E7CFE9393DDCEDC24
      32751CCB10F69E8899F333B3FAE4F2667210AE49C9C09B93BA942891811693F4
      19783592B424512F4AC5D8A39CCFA3501B227641B7A1D72B21DCD83D9CA95B13
      67444D45925E2408435A6CA11A812EC9DCE1D5D0C55600CF1BE30EEFE1256CCA
      B9CABB62EABD74CFD9917C91A95D338140F3F20EC785E0D072E36A9CE496D7B6
      52EBA63F29AEDF910FEC372D490937C286798936421EAD40FAC80D0B4AE97AB5
      48B608DA26E7A54698A916AC8D8A450056843489F332E4EEEBB62D26AC214959
      2676BA39CC756F82B9F88F3614539B24715571E2E3232388EAF4233E4066FA91
      5D1A7CA9CA2B7741D0192E83567156C02FA0D4D7A416FD65A829CCA5E1F2BE8B
      47FD98764D0CAEDAAFC9DBA918A3DD36B284382029BBA04EF035A4CD721DFA0B
      7289EC8E6006DDE547C8FDAA4F28F6EA8A1BECC95A28B722DDCF2B77A9927BEE
      546AE6CD72314C3506C55A40A714D73DDD7B4631377C2F0193D6DC8FC46D97CB
      F7B0E3A82F7246DD096D9BA857674D8605AD8E59E56DD3070A2DC77AC3ADCE55
      A1ABA47BC04F166E75A7D8A2719D8558D328E8E5F2572EB5ED48D2BA8AF4CB75
      5A926ECF56A2029A6433CAA80D5CA28A52DA0FB7821C5E7DBE731F2C21963CBA
      246F0CB00F5EBB28A4AD53BFB75EEEA1E1EFA6E16EA8856A31A1E52694E948BC
      E235D4EDB734AD9BC2B33BA0C0CBB26A15FADF867C4AC1D946FB028214D77CAB
      3F3D0E700BED91026DC7383DC6D4313AEADFF9A859C2C4C627D25059ADEC5C9A
      5C7C70C20167E7CF4E77B33D6AC05394731A579020CBAAAAF5E4D146856E7653
      79D29D57CDFB02808A639777B7D28D3DCFCBAC6BA5A42D3399D3D2685B51DE66
      3A01679C23A21D52358404D87109215302BBB05318114BE5F7DFC954B1711696
      53B6C65CD2CABBACBC1EEECFAF67EF50A792C03E0477D89C60F5BBA103F261D8
      ED31C5756CCA14C5751B84FB4262872BE503B6C6506CE954B39FE1B17F94624D
      9BB81112054A7014A5859FAE36EC939CCA443DE185765082526C6AE3B8B7B21C
      BFF9B178E04F9CBDB15F291095E2C43452D94F0AB792EE7A61B05EBA1DDA5775
      182D92D8D44B481B19DEDE5AF3B46A2EC8E2CFAAC3B23AC410CC784A5A758B57
      B0C43888F73FBA1F8D11DD8573DCA49CB9AF2C11C68CBBB3815041597E4EDE8D
      691336A73B12C9D92DB9A333947D36574DAC8CC9BA6554F6D16AE2C1D02C5E1E
      F5B977C3B29F4F59ADF75E400CC8E70A09B08CD66E3453D5CCFEE21DE00FAE8C
      2F016E502C829AE9DDED2DC6C5B58692B1E5CF0A0C725BCC488B8C63FB5C910E
      FD226526265F0DCFDE78F24BA5F552BB95EDE59F728E5772CC21BB0AE7997DDA
      37DCA9573E8F635F4B5E089E289538E4D5877EF1A54D3D498D7432AD8537617C
      E5BC705EBF1BA06B0FFFDAE887121FBB22165B690883E0F5E0ECC83ADD61EC45
      0BFF51F5A3C72612686B17335EC5EC53A0E1E4DD40AA3ACDC32B0CDBB69693CB
      A5993CDBFCE2827ED1BE534E5D768798A2CFF05E58963725428EC54AF865A2A0
      D67B955FB618CECFB829F092CC87B6ED13B64CFD3619987DF635FC364C32650C
      C2F5D076DE4A8F0CBCBD89743189581EE49AAF342015DE217C28527722056563
      DF8FB3BE8A829E707DFD4C057F40F8658ABC292F34AC05B4D048C98F6B2DD7DC
      9AAD1861D924C54CC3F52B7EBED2E18777A68D7EF5750FC0BB68F5485ACC24AB
      F2C46D82CF8D2E6BC9499737C77DDD40ABECB470D5C00D6C9500B3558B127845
      1E31AAD4E9376FA0D3D2CD315CB7AA8B55CDFA6E057F294528D188322F1C849F
      3694D6551517A117C13165B3E88C5829B18AEF3B537E01476012DDA5C08BB61B
      DB184EBAF8E2516596C7B194667BCAD0DF8269DE347799B615BA3DD915951AD6
      458C17B988B9EEEFF8FC84F3BE9C9BB3B06F95CF01DEB0F02E619B3CE224A861
      B5706D4FE8914180F70DB359A9422BEDEA26258DF0AAA1CA21A19B4564126FF6
      B8BA2FDD76C1EAC9EDB89646F95EDAE1C6F66F9994C8DDD4AA51E92BA079E84D
      69D6D00CC69C3B25FA8EE9012E5ED52472DDDB1C1343CFACB1DAD603B8316590
      EDA44D758627313889382FD78F0230DE777E614A0A3B4126A345C25ED0EEB9D6
      AD157237A262B0665C9E39DF9FEC1F3AEF53448872AE330944B8ADB33C5D7879
      0BA1BAD63E4391D347F6975C122355C9338D1D5775002FF0EB5AF769D739C9C9
      2FC4E85237CC537415CB161734632D25DF7C10A014E5119DC6C7B935EC970C65
      80214226BBCE99978673A33B2A02AA46F43F1C3B3B2ED9670099E3FA01B041A5
      EAE259FC0C986AF59BC8EF76441DC7415224FB68167D13A0C44A154B90BBC12E
      993AF02BD831B7F4BFE7B3D97392D6874CA72F9D4FF4CABEFEF4D2B95D7E97ED
      ADDFAEFED72F91AF4114F036891FAEB7DDFEFD4811764251589D4D19C27AE5F1
      81BD5CB885497A7CC880F291BA90A35571CF079D0ADC73B831A52A86CBF9D1D9
      F0C5D9D9918D4EBC78FD6E3C728E0E8FCFAD52AAB478C2C0299110DBB6B5B720
      EB9CA761929A964E6FFECE74C43EC2D12EAADAA432D336C88BE5C64FC7191EB3
      9B9F923763839EAEBE632E29F3E53DE715A042C4A7A983C56AA3305208582C27
      C94581CF4F8C3486104BE53436E929AE96484B6148A29969785B4573B04DFBDA
      ABEAB717ED97512172CE2E10FECF53ADE8D4B22F8990E90DE8D4EC4CD11229E7
      8AE5510482AC28EF0A927349DCF0533E4D08D92566F12B24293766B24489DAC4
      09A7AA806A8E012C959F728E8BF6EC46E1D52B2C914259CFB4EE936BFF82458E
      96385A951B4D57082BB171B5D22D907C86D45A3C20C7F0BEC1153EF4BEE1E73C
      FB691F7E8DB85159042FC669058D6807278594B4A0267CB71A822D77F412BA51
      D9A729225EDF0FF20B6B79A311D61F11E29A004F01F8973B98ACD3777070684A
      0182293988B236630778986D67FFE0DB53A9C1683B6FF6DFD265EFBF393517BF
      DDFFFE045FE73B5E87AA7086128693DFD9AD44C699541A8ED4EE46F1544C2C91
      58DB028DAE704397A70B82A4CD3628A6AD92C131B040EB1B3DE8AEC8F23C22F0
      60F2BED69E2AD05F845F99B14FA4F99049D9017E90B093FE67E753DBB9AD6FE3
      DD6D8ECE0B68E84CAB14C56FF07E2B403E221DE0AC845259BE048224F68C245C
      44D1A004C80293EDF222E62C8C54062DDFD544A3020E6E4BC05CF87363CD761E
      EC9347A401CB4003A7BDEF4EF3CABD65B11CEC1E5B0E3AD4476B25A1E1FE12C3
      A047383B5C4948CAC0606273F150746BCD55D397640C2F9A5C81C36D97C9C607
      A663A953E82E2A5545F410453588A824D04A4F593B9837F563AFC22B6C6232BF
      A4DA0477A35CB6DC841FCA0BBD6933BA0E87CE6877D1BC99507C666BA57991D1
      38525D0426F1BD5F974314D81BC434B14ACAECA0D4927224AABA0A0AC97FF1C0
      072BF8AF11F99869729336283F35A21EE8B6B5CD4B2A8C0BCD46ABB4DC0C64F3
      AEB738CB9DBB39BD4B3756F4CB2F2A96586BD1DF0B697D661492CA7C1868F242
      AB4864C26F574F548E55151FF06DABBCCA885EA5823C6A61B74B540FC3E60806
      C5985BBAE4D812BF9A6B0C5855890E629523F9B1AA52771717C633A297A82598
      3298500C8C030AA5862D65E68752A53A4B8C67507E6475ABA4BD2ADF96539F4F
      ACA27EDF420C22C021B2E292B3528C3894B880FBC614D130BF95CC8BDF2E1B07
      AD41508A882FB4CD682C167C01B6003E0121642A00ADC626F82C9D66D2A659D8
      2A1B7DB7DE4CB579439954E3EEAC68D880118DBA73DB3D99711A6A819CBC092B
      6EB45CD5265F25C242FDECB0ED8CFC2A19B4519801B47139836B541F099AB636
      B7AB204A7B5FE8628599C88B0D864A35BA6CE6998A058AB8DAAB8BB698A28F97
      550E139E2EF5B7D441132D502841EA65502B5526167F5A58B182D758BE26AC56
      D8D03594A2186C52E15A069ACA871A32A6B05A22661B70DB85C6E7DA5CBA039A
      C515AED973765E09D4122E5159C5C8AE22169472120B550E1E03D2B40CDD7943
      6FB198D7EFAB171E34A9AD5BCEBED3BA083D6DECD70BCD156C45D1A25AB95DEB
      90A2D197C5432BCFD1EA29CCE383246692D5817F8163D0747DDF3F96CAAF86E5
      E1710725A2FD50F757F5203653620BA8B99CD0DE9ABC4874F9E1FCC79A92234C
      D00740F25B2940B4DF78A8F5AC4E634A0D93AE4067DF1C2D7590F8609FB4EC54
      5C4A0FDDAA9AD90DEACACAEE662BC06A44B0A6242D1CC025F300E8D8A2C8DA5B
      CC1508BFB4A760FE9212045D16A2C3597121375D5DA248D81C0EA2FDEE22152D
      E1195822A25AB8019C0B25C359421FA5D7CE45309BFDB53EA8F3EEF01B9A5863
      8C6FB64E5110A452267C12C1AC2A5B349243792E43BFC457A82BD45912FF69B3
      ECD689F7EC926B1812B13EE64968DC44D45ACD90AEE26A2CB2FC9274E3121452
      3B91D6D9ACB47C8A9480D1C8C815048CA993A68B394C983B423685A13B85B589
      08F05BF5B66275AD7790CB4A769C1E61BCE00DE183F04F0A12AA4DC395376346
      B79BFA5579BF30DEA230154BC4493CD45CDA06F1E54584AA17F3CF92C2E61121
      628BF57C15E3B92BD6ECFD156BC79CD04A0A0129FB0A1678E62B29DD601C02E1
      2808541D07262F4A75E99C358FC02B8928AC056C0E54F205C585092F6206BD52
      05246C51108B721E2982218730BF643012B2DA718D9B265762ABC7C6AFD973FE
      3359C8397DC5591417EE21978CDC6C4ED8F5B9902465D826469939E1625DE745
      C928687E834D7BFA21C61A12BAC4FD28E40239E73F3E9C9D6F52B74B29B53BD5
      E49576BB1A9BC9767C95A86B5C278D9DB370AB893F562A7636DE9C9D3B7FAD74
      E5C8F45C67F8E8E08C3E02D6A0E99DAD7EF6069FBD494CFD047FB2FB40CE3923
      079D8C6D8B0AC73671F18E42699E5592CED5F52425D2CB2BCA7EA3CA31F6A956
      75FD6C3D9649E92B9845BBA1C7ADEDD1EECFE7A49DA5BA9DB1322CB94BA56166
      B3DF2BADC18C48C2A85977BB2E4C9205B97116A7A55B49840E3A71934F26C312
      546EC2D64414CEE847248FC3B251C6DCC57E97B5406C9BEBAB30F0E676BCA3E8
      08357AC882C2030FFE71B9F2B5572D158A16F12979DFB64D9AD8820B338C7BC0
      9DED076885547655E087DE699182C1A5AE0BC25C67E7CC9A177E9879B438E923
      FB95B291AABE895704064B86232F4A32D3A1FCE841D501637CD4B8AB2316FA9E
      24BF5347675EAC3A7A1916066223E58CEEC0A8526D5BE62858AAE6DBDC7A6E0B
      6F50E88225F72CA3A7686FF1986A177EB23C09F52472F702290741CFA57C5A06
      F12139B730A449B6D268FD29013FD818967749A6F09CCD51B0DE0BE6D961EBBB
      81BAFFF7875D2799789A9C3A8D9A1701323F0E4EC20CBB6A4769D45ABF748E6F
      5CFCF017DACD7209FE050DFC12992EBA923E394BD25C3ECC5E3AAF922482FFF3
      57E73C5DE8DDBF7C713CF7ED2DB6FD0CB5516C2C3572135DF366F3A2777EC74C
      A0B45BE075F987450ABF36A864722CF02A5965E050596FC1C18564763553A6F5
      1550F5574C6FB6625A8B893B3FE3F9CCBECE94D13B4AF582A560B1B46F682B35
      EFC889541EC01E329B765218A55BA2DB5CDE2174F08E279C734E657596A4F72A
      2DE1F7BF7485593931AF34191D421EB0A30C2E2ACF8DF9F9F34F459DA0FFEFC1
      7AF108A11CC5FE87F9DAEB7F8DCC7EC7E2BD3B80FAB056605599EC31F2C5B6CA
      5FC8AE1C77E1BAA0B8E1FEDF4BEE6BD2C698C6BD2E17171A09D7B996302257E0
      E0F21762DB7059306302908A41DBF1A350CDAB6F1B85573087C2AC06417B79FA
      E59FA6DD11FDD99DF47BF4576F3C98D05FFDD168407F0D86930EFD351C4C71C9
      68D0C525E37E0F974C7A83817C1B97D0113BE6DB74A6535CD4ED4E3BB8AADBA3
      EBF0777F3CE0EB06A3E1E8F73D72B995F7F75EE5D72ABD3B4D0F5DEA54BAB279
      7D1F8883A4D3BFD4BD850BF552FF792F5E90BF5CFFF2577AED45A5762BC7B25B
      FBF51DF087D7BF1803E092F319AD6EF3BCDBC205A54D59BE43FD9B062157203E
      E62D587FFD8641EBD8AF7D75E5DA8D415B3943C8BA6126B92344F30F2EB577F5
      26F1AEBEBC6153FF2CE5A6B6DFE134BD2F890F71F455644146DE9D53D20F33AE
      2630AC7F1EDE0EE79A0485B9CACBF65AD4B0B8B919A3A8762B2BD10C2BB4892F
      658C429325D1353F1AD92D946FDD84DC3B2CF025960ED1D6EA8199B484939B57
      8A56BF4673C20F491AF96773E5E9B6F30CE5563FBEFFE9595BBCADAF612E7E0D
      748AD572E8B6878F93C467EE24BDB3BC7116296E1A4C35FB9495E2F3DD075BCB
      6E30ACF5787B18B7699E42D9260B837FF9D5D6A6B1BFD121FB3DD2E05F4BD9D2
      F8BFCAC0DF2A800E7C9DA19B9887C142A0257425B08B91BAC8C086036E1EE67A
      97682C775E2C15E4A2E5CBF04E6D028BEBA4FD6A71B1C1A75B834F976A032BE7
      2E2EAAF55D5C4D68C9D580181B329522AA3C229D33102CE3CAADFA1AFDB8F64D
      38606E0B8F39896A1F82CA69833F5BD480FFD7477C843C13CFE1C77944268299
      48E7AE14EFC8AFB6FEE077A3175D7E631E48D0773E3E73C71F73E5FE73C5320A
      C2E7FD11E67ADC7BC47AA2B1FDDDE371D1B620C79BBE5B6385451939F4AB9619
      BEBFBCD0C6D3C1B4D3997CEE755643CBFDCB703C709E2397E35D71E30500C412
      9DC5CF72D17A82CE13E57F2E2BDA9FE054AF1D298D7344E33C155B16EA9A4B92
      304CD3C351622672AD1660D92E4C992EB0D9E645B569D3C63DA6711FAA5CAD1C
      F51F69ACBC9AA7345A0115B1CB98DB1EE764319AFC0AF9F85EC23904302901CE
      705EA2F5914AFB70FEFAF9C441B8D179EECD5F2EF280FE69B1239B28977F194E
      FA241508A548E09ABA3A955E49C59D34569A1C2F2F8AA2878AF3CA4D1C37D6C3
      04DACD2783C8E47A918F917831B7C092931031D1B097A3487127E32376B7D219
      80BE80CCC96F9222F0E54BFD6A51C0D86DAC6C86F7F64AAA059ED3C03DCC9218
      A860B6612C42FF84E93E93C60C8FB60D6A4CB2305F2CD11B354A18240A1C0E57
      FAD64D603194553961CC0A91A71C03CA960EC7668EB5C6DA98E0CC28D4819B44
      40138DCB65122CA018401E6C1A679A2989C904CAC1CE2FC3ED0A4E4DE821A7CD
      59D384C4F02CAB1E11CD5F01936975DC78751AE16592863F23A417192E3A9039
      78A894C96C4ACD4DF23C99CD924C0AD16E9B39FA6987460F8B1635F8A4DC66A6
      90C5A9D62EF85ACE49CE2F8237B64E1D6A8C7000E29BB46E5CA0013554403833
      5B28028EC29FB52123A936E465A6EABE89C3DBDEDA293C69AEACCBA47DEF7951
      FD60EB24107C945E5C7BCA7961EA2D66E8DDF5B867D0A2749BEE15D3BD6182DD
      7F2CE148D5CD0B56F7F86195B0226D99B6AFC33407C5750B51D4F528631C666D
      9565F2366DB05334801809C34EC37D7D72679E62C4A18E8005260C3CD908D2E1
      54817CDFA8F86281F6A38AED6198AE6F94E045ED89FB92195E505A777B6EA65E
      ECB9AAE700632BBCD64D5D74AB65428ED8A474D6107E8D8C4EF21D2B0B81CD21
      DF56E1C0F2AE2A88F7A48BED5590E0FA46F7243768FB78701325F9801C534DC7
      91E5D4648A74EE9C224B3F01F603DAAAEEA236356AD80F2E20139C37081CE5CE
      02CF26F41B5DC79810A8D1D69F94275C4B5A8C1B8E8648E70BE7510DB68660E8
      4B1F221D88F24913A5F690CC62C6A5461ECD236BB74EA2A4E8D8B1582B2F2A38
      2BB773433E50D1EEE68CB04DFB05BE9F2AA8FC2AE697E3EA88914CB8E3BB915A
      FF5F469D0E071FE7E6D4544E4C1E94F1BDD57CEE5C1B3E0709F737718C0F9B0E
      452B88A94A482A103AC501CF4028803B31172DE23C8C4CC56FA6D6572BD8BE05
      32CA9091A07F3651880F89F0C7D7EF063F39AFDFEE9F60F77CF3E6DD2BA8A59B
      3469E6301F5E2B4B86E31DBB1097AE40DE146435D89FBC86ACEDC88DE36601AD
      58818C882B8BB089127C487EDC4D233D9707C9BCC6442C23AFEE70B6A7D21DB3
      DB765A6F1338C4FB51D42AB76B9110B7FDA7157E078EB636F34C7C7861EEF342
      2A247B2BE85E8CB65CF4C40AF162190ADD5D06A70193F60E00E5608D32CBD72E
      8A5BDC48C58D8C233D242AAE9100BA825D28356D086ECCFD63793007363C7E49
      82F216B9A92411302F41996050A3A29BCE90215BACCA5BD3DE173FCB9B289707
      A4724ABB269939FBDF97E73BB6D54DA507B191A37D603F9CBF3B28DDAF650D4A
      17FE10C6E33FCA686B6C140844963F6D8BD66B327FF9604184750628773FBF64
      88A212E83E5F021D28B292E4A7A45A19185BF91E23A7E03E4D55220F2CA06F8F
      CF4F8E3267C7582FEFC99F0F3FD16F992908484E8E7463394792A1DC6523F1F4
      C37B2752AE8E8AE09C69A4494894B33F98880E92D91CC7EA99ED342FF6998163
      AF601E5B94E00359733F146BAE8922794820AF40D748BFFA16A83FF47B1AC46D
      E61CACA77CD8DE9ADBCC27FB179CF87B41FB2A59A4A2A2C508F216594E4A9C04
      3A6B6CD8F101D9592CB530CB16822FEB7C3A5CCCE632FC741173D008910A6950
      67B405A3AB0ABE2B098CFFB10483AA08C6909088AAC799AE004BE59DC9944145
      19AC2BC434D09E4F6E45764BB298490A59D810FE587259AEA13035C38CA38E44
      853357B482CAF2B2301000D8282A912905672B89FCC62E99070CE028940E140C
      F2DD77005BCB4B48CF1309CC9E1581595E3E85EA368274F5A5CD2B31A38862E4
      0E6EAAFF0A35F92826FBFC94A54D9CF407A6FCA6C66A71DF050169015425D229
      9C1DD08D384E43768A80B3A6DCE5CBD1750E3348085F1A881CCED2DFF2DE6AA2
      DC1EDC2C8B58A06B84340E12B956112B4C8110E4E3388C8BEB2E43098A897ACD
      0455E662911AEEDF6EEF526E658EFF26CAEA0149550AFAB454A5EDFC153F1BE8
      C3387192BC46C1067D818C655A5B82F25B7057FA0CF97F8DC240FA503080FF60
      368EB0BCB519CB817F4024EB00681E10EBC972565F7A0B7194552A1D76DE47EC
      7FC926053444B14979226E938560EE5440FB6DB5006FE3FE5E7F6FF4A73FFDA9
      91299D8703B00C83F456DFB0DFEFAFC757DFDEBAE7A97020BB6230C86959B935
      C28926B989A7706DA60E724E6856809D0A1CA5D66102CB84EF2B74EB925F3110
      F62D9944208895D9CE158FE5E359013A2AB948D54C9A3FFE48B3777676549872
      45DD894C8251A2CCBC5E43B5DC2367EF2E85CB7903409C96C87D30F823C971FF
      7B8B6D5B9214D8105813C7F9B01E957894E359CD9904CEA1BA412D4FEAEFE96C
      660A643367204517055E27C236E249FF6381DE1BBE431365F390642E93A8605A
      31959635E4CC15A957DA34E148B159053F15DBC6CBD3C8D66EDEAD25C08155D6
      E52DE171FF21845A00E509192E8D339C47C2905DA0265B183FF14AB9282F73FE
      B9BDF5A55D2506D563D25D546EE015BF4617AF14CB910F0977DC2C1736659AEB
      6D3FB4384A1EB21A2CC9DB5B596EC3EE777751B8E47FD37E0A7F06B6431365F5
      706482B488F3670950408E9CA6FD563846561CFF2C041B3FE61CC312F9884964
      3122322B3D434887BBCB3CFDF16A0D3E14D0CEB3043E3B696CCDF87006A30B9F
      D4B094EE62D89AC558451DBE1317623E71A1FBBAE14EFB2574D9268AF817EC0B
      A8F8E7A674B1E0CD2D8AE856D04C55080ACBAF311A3E4A1BCDA22D7C84527AF6
      CE85982D1B5B45333451B6906C8D095859F42E809358895578DAF64A6D690A14
      0B8C9B52F8AA828B6EEADE189DB889D2FC85E480354D96EAD4CBE52486F03298
      30C36604DC60D844613CD82C51296B68177BCDA9C5FD57C44ACC4A31B457D2BB
      CD556E79C1EE07680723CA268AEF5F46DD2EEA85049B9CF129B071D8F227DF69
      2E59A612FE59180E1B3AD29EE9C0B6471AF798E5C8431F9D81427ECEE859D26B
      85F94FB894350DB920A88963FE8582E0546597D284AD3CCF647214775C86A6B6
      832361DCE821DBA02D790136E3E84A2DC5E5738508B80083BA9A3D45033F8EE8
      98620E9F82D6C734F0DBC004F450F11C657BB74A7ECBDC00042879DD3FD60CB4
      7E3CD47AFE9354329216D979672A40FF1B613E01C9D86DADED8043A168942457
      9218B6C15D4E875B2656571BB11B8B3807AA4D2E474385539471E9609A371760
      64D445DBE47B535E63421589AFE7587D79AAE2A83AB62F0D06D5F93C605083C9
      929C6930160E6A301138A82B9D2210D61F7D06F7DD849E6321629678467FAFB7
      D7FBF727B842BE3EDAD0F8C9A30D7D3036B26D77012A79E2233ECEF5359FCE8E
      EC09B8F7046778ED006578F61C39383FDC2F9AA61B198534E3F1123A6EA5710E
      A361C46D60E1BDEBB79DD76FBF1787B332774D1CAA61C724DDB2D769E2FB7F1A
      0D9C2A845EA35E5E287FC9D46013EF5AA5A170E2B21B85911956D3268EADE44C
      69F02060155ADCA8CFF0FEBD47A6187AAB5EABE7246BCFDDEE60F0EB0F5EFE72
      DD93378CAE1F00DCE4DB3C8D0378DFF72B5CF1B9AE83699249A79367B1F23FC7
      C1FC59E77FED105E23F37374F6BE70AE05DB8A7CEFCB38F4D8E13438C35CAE42
      EEF853343E36E6E5BA799626D96FD0248BB8D1F1DBD7EF9C6F50BAF5046773ED
      60683A68B7A1F525B4E5F89EE97649B5849C9D8303C66E6AE2F0F0EAC8E22429
      A20B26D3F0D434CBE66479846B8742424CAB55B2928816138E2B340FDF1CB49D
      77DC228B8867E593A3B39327B886370A77ADC23D3F3A1BBE60AD6B1CFB3AEC06
      EF8F4EBF7B82D35DE778E9BF2077F727E7EDFEF72746673571204771061E1365
      49140429015DCA88E26685BFD2E8D085C09B938A4911B6BE519C90D317524686
      E845E2FB86EFBE91E3DBDE3A345C2FFE6DAC66A14716BA345104A18EFCCC9EA9
      D2546DB9CE9433D329601AE62AF72EF79C1F10A4466166FE1CC00470C355247D
      B44B370B03E7679D26DC94CB8918002567C0C34CC49E8E2484CF1C6A80862F2A
      F64CD8DF3C56522B7B604C433E26CA042400C902D46F84A813C5A5DC60989031
      6E7C662E2F37EF446F9393135343D504EB959154199A2782F63089F553B4FED7
      8EE4D5D93E3DDEB9EEEC0D9BF8FA08307C0556A7E7197DE5AB9425CE0BCA545E
      8273256D7216C74F9A25AEB4E38631D06E429F76139C5553CF687B99B9218ECB
      1991AA942FEF09DAFBA5CA2EB569D45491B78838F22E25C7278743C9BF9EBF4E
      C03211856E5A25F0DC24A77E7D72AABB494EAD3266274FDD983D3B3B125BF680
      4F4BF46F440BD7C9EA20FFCE91657776E0D718FF67B70D2B0340E9153F177687
      F58F68CD7CF1E6D57FDDF33CEF6BF07841693DC15D51C7C319BEA085F193D3FA
      46C7A84EE0F6E377EEDFB597672D9B351242EC460EB0706ACC50F6F3088060F3
      C61AFE062AEFDDC00CA8A9C01EDB5B6757B7693873BE3FE5FCEA6B007A2CF201
      FE9D2D58E1BC247B3A361DF170C5BF3FC521B4A73F310B2389A0FC451BBF4171
      D4DAE72E720379F19CECEEE1758A2F3E0F9201FD54D82C8D5C18DB5B01171AD2
      F9FF120ECDE4B94FDE1FB92897FA93F2B517CEC8BA32103B86752B64DCFFEBD0
      976EC8D62B44600D8510249BA420D93434982D7196DA527A6D6EC42DC5AEAEF4
      54326D4813E5C795E84BCC18453E258C7D54A3C670E16661442F4F6E54D63631
      406E8220272B5E54F4CADA2383ABAE6106978F4CE2A8914DECDB5BAD539D09FF
      D0C2CB17A96EDD178D29E897DF736DF95CC5DAB25ECE42A9922CFD7115375516
      16ABC96622570BE3D4368EFACEAB5BAEB3BF9196866B3A86A3A25BA148679AA2
      1B7688003ADC44E1A0D0D9D9812AFF6F323A764FD4FC04044D69B6977FCA797F
      D5A9F92CBEFF1F0B9DE5E70060E6EFD3A2016E0A8A65B9BC9C897C0479864380
      B66651809DB08301B2162DB8D4166E8E5CD544C18633E8F1220025D9B5B0B136
      CEB501A872171752F4C36B03CA75666A991B39ACB85265C28749118ADE7F7FCC
      21919291F0EF5912B79D380CE8989921BA1BAA887E8C125F2224DB5B9B58C6AF
      8B65AC9FA632D8B10975AC0A754C1B10EAF8C931EEC51908AFE8403D32259EC6
      B728F6CF539ADABA233B3B6AB8F3679C5871F99C413929CD1BCA2F1CBD420B01
      8C06F18F1A0A0EF2C73F8D3747E96F4D0B74F7FA9BB372C559D95B3DC79BB372
      73C63C622842D16C06C05916F4DB6591CAB942C2F6A34B58B3A074F692D90C9A
      3AE2424B1BDB6CE664B6CE0C817BEDC8521347B9DE8DDF1C51BFE188DAB8732B
      8FA8D5C5B74FE7880A6735A2827F74239C6B518B2C66F528B888921B662AD5A8
      8769E4D88A24ED6BAE6A2CF83064DA04955E2B8ED392001A3CD2ED2D338FF8D3
      CCA5BA4E423F732E24FFCED00DA926270B23C5FCFA8B399D75C8CC9B9C1BE82E
      258197B5D9292325670C3853BB08D2028413D7FB4060A663502F06BA1712F012
      9115B1F3CDC1F3DB0F9E4DC9D4CA83A7F7C40F9E522FED33C4C7FB5747FB0DC6
      B9FB832589BE3FD93F443C8A95A49ECDF35B871EA56E1B39984FE630C078EC51
      F7EA6CBFD1BCD7764CB4EECCB23370B7495027CF8B53DE0914707804A327224B
      2EF3D45CE3686CA2404895D8331F054FEFFAF2AFCD09FBDB4FD8CEE6845D75C2
      F69FF8099BCD01A3D5F85482346319BEF948ABAB068F223314DEA4A4D161CE85
      DC87C7FB6F9A3BA2204A546E4B80528025373406A0FC6BC505632789CF8DFF99
      1368857ABB268EC64FD5C5FFF6C9E3E4D3B0653072B86BC716BDD56934328572
      ADA5984848737C1DFA602E6060D126CA076C72A6BD89415339D45F52D1357148
      65CAB5F1FDB7E5501C1CB606981349B35AD8F4BE2D42977BBC6CE53ACBF7E60A
      EBD8C4638AC0174AE0195F12958F83FFE6F247321EFF9BCCC95D415F42057C13
      8528F69BCAB2C40BB90D963B5F0311CD576897FCD73DF404D02C7CF18EC9F657
      1BEEE07FD07083A4FF3546CB07DCD719707CFD55064CEA47C75953753B773492
      8DE5BC4B2F541CFEAC5367A7DBE660796F1741F240F8BD73726C0DF3B234F4AF
      CAB7D3C4930CBE6C1FE4F35982B75C7B1D0DE3E5FF31E3C129F36F9F7BA53471
      F603E11AFF1ADDFACC9405E47B305D46A1977F85AD6BCC0F5A1506B9BC897318
      7F25B885772FBF2ED602B793094977B2C8E78BDCB040B15304EBD1C41F6DB211
      3497B385776916BD347593F65633B06E7DF1FEED1609706FEFE347D2BD85EAFD
      F87196F8D9C78FB63FD9770E43E0B3E73494D60ADDFA3F506395792AF10DC9EB
      BD0C7D13C4C935CD25CB4D797992D6594FD284D74C49400A42068AA44144BB02
      F97226B33A3F3D3A324572B4768AD479414FAEE30B9CDC16FFC7F22234520E77
      AB0CDA18E9BDCAB9E7FF6600EBE887A2FFBFA1C91533E41FB49A27F18BFD7496
      A42FF667B3456C4A59E748AB65975AE7CD5CD932BC57EF0ECF5FD01F3DF6294A
      DA254E8616A8F3806FA8B1D14D78294E6ED866F59DC59CF5BFB53EC0D092448B
      C6623F88C88E6DDAFBF0DDABFFEB5C92DCA2865A356640A72B88937C0DCE9892
      87AFDA22BC492CFEEAC46267AFBF291A5D99591C3CF1CC6298658B1A2A503BA3
      E94B8EE0CEC81CF6048FCF584E773002B9A73C4062C2300CA256CE51335C85CB
      0B484040195B34F1469E35909D76BA03928C29390CC996FAC4FDF2860549088E
      8C0A7A07486A3A38668D1CEDF69619EFA8F7B242E79D26B938482ABE887048A6
      B392496BA7E24B2139C32BA6046F80C7B2DB44595C26F995BE5D9FB6AFA2A394
      F825062765E72B44BC8EB053BF7CB0E439DB4A613A6BA32277AEFCAF11EDFBF3
      570812F19C03B5F46E249F46FF9B47FCFCAB0D284E62FD7572135F7EC8614CCA
      2A6FA89A8A7CE7EC320C7283CD9BE54AAA56C4704318EC2A9C33C364C26C8846
      35D175E4E1EEC0C921273FAD81D344FA2D5F78069443EE4EB62E8D8A69B0D06D
      2620C53ABBCA51CA405E662345BABD754FA81C2880F0DE7DF78BFA9ED1A601E5
      14025E9BE43E37061480977D217536A7AA405303ECB8C1545AFA134083F483C3
      B38262A06875ADC2C8966E341876505E9D595DC3AC4E3F56A46E3945764106A2
      A9BDA22521DE2AB764D1816962D099B383EE1366B067BFA3913BE8204FA33F1F
      00263CC458E3E8D6790B886FBC3EB3C647E1DC4D14B85E8F328FFE9998561DE7
      7BF4ACCA666AE2C051CD52B6DB195C76BBCF115935BE93BF20B33A505166695F
      80032DF8EDA6314FB20F68FA6AE41E31C86252D2A319A849F018DBB4B06789F3
      AC8628F7191670F59D501FF4AC8982D9DE7AA0F2AB028395BD44EC56E853187A
      D29657EDF0C6FA61B7EDFC90A4E488CF81EAF62A4D6E32E4E5F7A3FCCFAFFB8D
      5418DB5BC5FCCE11B925BF1A3CCF49723553E99539434D79E34B512FDDBDBDA1
      4DF2A9E2D2B60329D8CF2E12C755DE55132552E9100930440BFCFEC3690D61BE
      39049E696233607172D3769E25F1B3CAB9D24499DC6F18DD713589C504FBDBC0
      C12F020F1CC96866E8A1688DB5058F0A291C808392D911D3414A5682306D6711
      2835A40196B4C23CD280AD35E7CE6DB2480B90BD3030D41B4D14C872B47FC511
      BBF3C3F9B7A76D4E6BB499B3A72D69A0B99ADFA68B8C774F0D0FA7ED7CA3F323
      70CC33AD4241864BA22D3A06DFAAEB136EBA7676F24B155FF189FEF724BEF1C7
      CD5E6CD2D8C962DBB17233AB67176344CE58F87FDF7CFFE61B67E7224A5C15F1
      47F48BB77BCEF9A5667AC56739609035894EB0940FBE43823907A18C294C376D
      D9B857CE5F92C89194F632F0237DADD271DD2881429C032BCEBF9D7E7348A376
      6D2AAA4623FAF6D6E9D16B5ACC4C6A284E427309A8508F812A04AE184CA5AFE1
      FD9BC35E452634D5EFF70FBE2395C6B15494723773A4A8B778F5FEFCD02A2518
      27A611C34DFC5BD426E55274011426BAF2AD1337758DF3604F35FD82EB690E8E
      DEBCE1EDFCC329D91E17D290A3243BC4C9D8A0B1BC10A21F072F0C019EA92EE2
      71564DB377AFCFCE2B2793B3C3DEDCB3B390CBC78CE9FACCC60E609D05C1EE26
      2BFD19B2D21B44899559E9E113CF4AEB6C6E08AE0C23334ACD4995B83A4852D2
      1AD9AC99F5662683DA1FBD046F6F9693FFE9D0A9970691E14D203BF222D559C6
      9D799E245111EC8912787B731B086CE2D88BFC717FFCD2110F45D0288AD39ECE
      3F901AE7E05D82639339C7E727E813E6E8319D984B8047B106D8AA471FC70DAD
      530213091A6F5160C927C2042D8C295B3AD93F16A83973535A223ABF2F195370
      7011721C406281F81E4068D707A949708CFA9F91EFB2A7F79C1FFFD7FB303FCB
      93F94FCD9423077D0EDDE8806B36937899BF45EA316857A90BC458958B929508
      9B4D5F03B137BA650B947D8BC4D09F0A8DC4AC89E260DFA0E0C5306DEACC147E
      53867D0C010DC6E90B8168239D7F60BFC84181DD624F895B94E67B390801BC4B
      496BE69726DFC46675660BFD87E2B4C2FAAE110200E66B714F4E61991524E1FB
      260AF0C19073DBF970CCF5596912DD893FEF671954D24CC5B4A1D2B6FDB76B63
      CDBC1B1B1A6C36F10E399FFE76F0FF9D3A3B3AB6156E3F237D5B6431FF7D77D9
      518567DEF821BF3F393E6B307657111B9D713C2E71B3847B1B40001099E9AAB1
      27249570F2EEF0559BFE3C3B6C3BAFBFF9669FFF3CC39FE7670D168E44207CE7
      CDC1F9DB25AF141D75DAAF18131FCEBE7B6F6CEE266FE6E2D0333D7B9C65A585
      71AD1D15850AE9651EBB431603141D4E88268F57ACCA0A28A8A5E4E6505AE337
      F7B343F16F9F193AF74BCDFD3A158BE6D9F35E7750639B8F0793FE6830D9EBE0
      7FCF6023B99AD9975915D23241E8CAB442C9B310AA26CFED6F076F7E28957F83
      656993482DC4AC3E7E144253C705F84FD6B2A5DA7773472BD2460D1681A1A49F
      C3AEB3991C2950872E60228FA68E6E502AFB8A5350D5F9B4C6191AB2A9E03F3C
      CA1A3BDD2AC5F7DF9C9E56AC36FA235DCC0B1E4B955F5EA40019168A4175DDD0
      C08299FB07CF81936F8E5EF3EA86C92AEAED6F6FDE1D345FA315836E7D881719
      FD6D2B23FE767674D8221D9E36355654F62ECB00A58261795ADFBE3FF87FED15
      19F0BD4D2AE133A41236D0992B5309A3279E4AD8DE32A0D4A9BE7EF19626ED44
      33A733C237A6666411D366D9733E9085A302587964FFB119C8AB2011F65DD3F9
      80A4A5424F5B1A5676D6535A126B2572A68196CC0248F53F16610A4C4EE95663
      3C229F3B9C4957FA8D1C9E4CB7A20943894E81365463A1DC0124C2A483E829B8
      2DB00F9EC12D0EA5A98FD3DB58384D141287E8F62BEB1A35C8A4EFB494944A91
      752347D6FABF8BD99C099092C2B013A3E659661B31E7C97C31676887460EF128
      46BCFE8589DB73572ED9AAD2766A5A271A39AE37C9856C2D54405CEBF4260DE9
      D563D48AF44F5E357248DB5B3F7E3AA4050982B55C45E889D17353D29D22968C
      0A20C41A2ED36471714927127EF1DE6681697F5E2A84A9B86928CBD56CBEE71C
      E7CE8C231EAE467756B088705D8E4CA143BB56905AD83E6CAAC80C8607FDEA2A
      B387710548545ACAC16380605D494FB9E7BC37710AFAEFE03B6E26E18C29A7F2
      1A298C55E545F72B5D6BC8B42886959428C3569F9F48EF3E5239B7063D77F74B
      3A0BBFC53DF80C00566B0D259B157BF90497CED7B7FCC74FDCF27F5BA5918751
      D8480DF0F6818EA09D30467BA5F4555E2C2205EB7D8E53031FEF3676ACD5ACF3
      CEF91BE5927DEAC30B6F3BE707E87F7B43E379957C6AE608CFCC7A34656DCA03
      78249DFF1C83135489CC24D0B9C5F8CFAFF91483752EDE28E97CF2696A282F4D
      5F31E7259AEA9A29AE5393C7CD6EE35C7D722E49D344D036F0DFD3A2F1CF782D
      9B93AB901BF801B3CDA9B5EAD49A3CF153EB7B9586C2561CFE0CBC84DC800820
      55C1640F7BCDCCB6BD5B30FA93A4161F1857F346752C61F86E6FD8A63F46F863
      8A3F26CE0EFEB85199D3425D21F7E961E8AD8D815D4AEF24CCBC8D965AA5A5A6
      4F5C4B1D00B16196F86110A2EDBEC65C335EE66CAEF2D00DA3909C773679DC84
      FE38D42484D0F9DB113BF47F3BEA5BB8D90C70B359B2480188802ACF46EA0809
      48BF52997E8BF114D18B2C71167126F11F616464B3D060E281AD7EE181B4C824
      289A39F857B7B9DEC7E09C48C71734D9E4B6A408D2707DCD68E0B8619E6D1294
      9F2141D99B6E12942B54697FF5243F1D55CA13499B1E8AE13A34F5EBB3249CA9
      9804E2FC737BEBBF3E32B4E6C720F2E1E9FCD7C77FC58FA877FBE22FEB7CFB9F
      EF8F4EDFD4E841F8CE695DE6F93C7BF9E24531983D5F5F872A0608D91E1D062F
      E8EF17E73A1B6254CF8F4906D9F3C1683CED8D27D3516B154460ADE18DA6E3E1
      7832B83F3A080E05212C4DDAA69D8EDFF1A65A8DA7C1D4559EEE7627DEA4D7E9
      28D5E90C5C35EDB89D5E47FED797BFF49AEBA703B96E34E974C603F31FFD7B4C
      DFEFD355BD40FE1BF9F41FFE9E9A9F4938234DD774E551F8AF47FF1ED1F74743
      FAFEC85C6BAEC37DF133AD62FE99AFED9B7BFAE619D5CFE9DF437B2FBC0BFDBD
      BD857FF113A6E62AFA26F64071272D57E3F77DFA9C766DA74FC3E9D335FD9EF9
      7962FE3D92918FA7C3C9A41B0CFA6ED71F0783890A7A24A3A1EF0D26C3DE7864
      E448321B2AD7CAF59FFFFCE77F6145A759F4D815BD883E7A41EFB318A3BF72B5
      AEBDAF2C671AE3C78CFC1C5185F8095A487FEA7C949CE4EDB833F91824496E7E
      F49228FB841F74ECC7973AD5FC6D7C05156AD09F7C37D17E5EF4310BF2D8FDFB
      83D2A3F1FF6A2BFEA91D29B50B3BD12A1AC600DC55B6B1DAD75E0215BB736AFA
      A3F64F4FF6DBCEDBEFCF8E51E97FD86B03AFE25D33A36566DC47D7B486603E22
      36CC9072CE05FA73901A3C3E949231142F44E1CFB842DAA21A3CDED70F953932
      5C89CD0008F75441A6D9C4F19AFED9CEC079498346D35B021C3000A690DF809E
      69060CCC66CE0E7EB8B84CB27C97F3CC45F6B8A16116DB3B3C99D0D00F85AE84
      03C0F012012EEACC15284992683123D731CC01CB497E148D0EDCA64CE281DD6F
      3A1D9D1D7FC1455DCAB95482BC926A32BF1879CF5D5CEC02AF86AEA7FFAF7D35
      C57DA312DC11EE338512CD468BB9DB9D929C2DA2D62527D395EF631391ECB3CC
      F9DB9BD337458BA9A1DF044AAE54CD492619324C322DD7323D2B9D9864DFA6DC
      C71F8717B1C5F8B175E9C7E7270D175B87C4C649AA0A4223F7DD327263663877
      492787BE6951CEF69CFD284BDAEC06B4EE7EB78510083042D6BE83A8B9468AEF
      5DA520C6D0A921238655C50050747AE76833E5BD251598AEA6230B1E7523075C
      68B35EB9CB0ED49CDCD10238DF1479C7828ACA4800DC99544100F0430491608C
      D21A3AD42647CCDF651E06DE72A886C94031091451ACC44DF47953DE512F6ED2
      7DE27193EDAD6A321D255F6C0D15061FC797C180E74390739591C5EBB4C059D6
      72AEF42D9DDACDB4855024510186B5B8D98D1D8B39E16C0DDF463F6D92F86B75
      53EFC9EBA603E4BA5276326EC22862E3C5D6346B07EEDA271A379774912707E3
      26950BC31C8847D79A0929131AC6AD013871F5651837536519F3B83784796C71
      534D97B530EB31C0D5FA9AA65420A31A5A0251F809BD2EFB098610C960152581
      734A662D4A22845993C18AD91F2503EFB4205C2AE814389C15A95B49A549E712
      8C6371BFF8E3242637EC2DB3DDF19D4BDAA6BF1DBC39B57E57650A746AB1331A
      BDD03A2FBA5D840A4AA961FFD95E68A1ED289ABCA4F7A914719DE23A125672B5
      983BFE82A36CDC15E69B75CD505D009162A28F459CEA286CEC096D3DDB3149F3
      9510C19AA2BB0F9637165EFCA1E94529049E0184BFC903866F269EA9D332409D
      12336ED18289AC01D65417D48E128A68FFFB6ABFFB121C1FC36691D2606F546A
      14F69C33891B63DA67A42BE880525194D4D83506CF10EA069AC9544244B77617
      690E5CD3819F3573AF14FABD03DDF33D47E101EC68042B1A1A0E3BFE757476C2
      B00B7BCE2BE55D5D70FCB0A4558CC25968FC7CE61DA7BF0BF043232D6EF96AB8
      9CC66C1048B45E39FF58E82CB7879239046944A912A847A37782545D009F437A
      FBE9E473B5E569A753CB395BBFF6572D5FCFA6889ADB3665853A22A11E713664
      A98FD9B4F802465380F07877232914ABEB19A3D6EF91CF419BF303CA8D902A43
      B4B61288839FAD8300859BD7B46B8BED8B00B884E7042BAAE1F28395FACE98EA
      109F2C4BBBEC3254B2FD07FF6ADF8047A17BCA660FCA06BF3DE750362AD2516D
      BBD642EE20CE4384FAB45FCAD020DB4A940FD0158D14A21521E2E0DF2721C9E3
      FC76AE0D510DD9B848C0CCE79A7CB33DE7440492C9765CDA781BE7DFF92EC6CE
      64A96C4200AB4200FD271E02B0AE489FB6C207CE3D57933B355600E78EC46640
      91A8D1DF6DAB29AC5141C7183918096324BF6447E400AD3F81389545ECC1B5E8
      5D7444829B24872652D890C240C76F0B32B666963E94DA9BED7686312BEC5753
      6F2BC0AF06C14D913175119306369C7B64903ECB0B71408C7CF99E4D7FFA89CE
      589019C7662EF5F27DA562B986DF68CE5EBE9C2641123409A23E341FA61762A3
      06371D026BF5DF5327962F93E2B0A75A70721673B3FC5B920F77934FA4BFBCCB
      249510969BE460F3031F0869AF46EA21759D84000D140F0D40E21E7005519F64
      0D4352BF89C33005BE76171708017ED19EA03F6E01FC645300BF4A533C75B28F
      EDAD1F704EE7A8B8326C7DE63C0C9101C9556C786135F99FE8842605C1F47596
      40588CA492C41AA733FD449FA9C879AB3F2DD8673BCBB59AB1AF9A5D26865E84
      6CA1433EF85576E52817D44BFC1AA6FF88D4D062D64824E00244E5BD216BDB91
      62481BDBDB2DD8A760404AE27C4667AD8DBE88AD084158908143F27F93D84DD2
      D8397C73D044991889B40002674C44E7F8B0B5AA72D404409B38CA738CCE9400
      15D0572BAB8178C496CEA08943DD379D84500E92F3AA308CD32F4D62EDFF3893
      4EE7B28903E414A1E6C40A5810A39056AC9744EC18C6BE656BB565AF7452707F
      5D93E9D35BCB9C6805885BC0EDA335D45EEC85B0ACC48F33DCC06FF6DF1E0AF3
      278B8D7E382EF6C58EB0D42FD3D3EFEE39EFE20A1FAE8102645C443138DA867A
      3AFCF90FC0597F6CE94B57D280C0CE625A6E53A1B331553F83A93ADE98AAAB4C
      D5A70F266B8C880FA694C00F559470CE34BF9D1B5A214192EFEE4D9EE014AF1D
      E1FAD6CEED2DE91DD22F7C6DDA88B4B3C88389693942CC2C557116954D57A6ED
      A22D003EB7AC7C6733419A25D58ADACDB33CE5DD41F233659C805E3559923C01
      1A94217868A2540DE42E9D286293BC283222D95538CF482EBE4FC698E15BD8A8
      D8CFA162471B15BB4AC53E75D4BE12FEF3DDE139B40759226C06FBCE4E9E260B
      17B5901CD83F5437F1C50233BAEE9E7B3A6BB81BFFBA208A04D1D8FEC191296F
      17F410379C33D915BBB4266F71CC419212A325559E76EE16F608799D09BA90AD
      57B447AEB8A534DC955504126F6930B6EABE29D86336441A147EA814D633341F
      17DC54A0E6C861B86B0F6F889A1FABADD737B3AD50E7C38D3A5FA5CE9F3A9C5D
      A1C1C8C9042527176D8118FDF8FDE19965251535F604E7B76E4C51209E0E8F40
      F36EAAD2F6DF1C7CEBECC01F681D6AC17262658224171D61AD469E47D5A3B9C2
      7D9931067DAA9953D88099D2353D6C61002CD448F4B671E13B2125C2F1664F2A
      C4F612C67040169E9C2A47F01C1A2CBDCAB9C370145CFE143B60602BC78F85C3
      270DEF17756DC52A4268F6E861B100ACBE32C72742C2F69E5DE71D4BDF495261
      DD3FD8E5B20D94A738379775EAF3257F73234DC236A971A932A65D5F8A63354B
      860C006F830FB330E3C222E6766B3685DB2FA0789CBD3F7AD360D2CAEDADF7DC
      7AFADC65D0BB32C49ADD92253DE31DDFDA9FCF69694B3F6B4BE02A76B844A2EC
      EF5CB23941530EC2D23C69E431D2322DFF32D4468E609FD4F7EDCF1A9C25320A
      6404D6D7F4A53ACE69A64DF235FB1CF04ABDBA63372FD75BF56E3D27596BD076
      07835F6FD1F297EB9AB461741DAD6E3FE7DB3C0DCBF6ECEA360D67CEDC24D8A3
      E473E4503FEB64AE47DE70A3F01A41DAD3458C66355140EFD304C5112986E4FC
      B32EF8200DFE8BC10F16E8822F5FBCB8B9B9D98B51E3314BFC8C71DA1233AA17
      F8CD8B417732EA034CB0615082E3DE6A28C12A8CE0785CFEC71080DA40FCE13B
      06EAAF801A1C1830BF555081F88F9E37F20C18A0851B3420804B9085F63E8101
      05EC024A906100010FD87FD230806B17982CAA1A877ABD75F79551FF7E7D5DEE
      533B90378196F54BF24472F8E8A25452F49F254E1280418DB97061A5B0B305D7
      A8F50E59B616BC7831375FA1AD1C35102F52ADE8F12E50090AB78C5EB9ED9CE9
      7F30EE5C9BAC1EAFC02A6A3B3AF7F61A6987BE5E44A0649BC306BF02D29404CB
      53C7661C388E73BE09F07E8674DC6013BF5DA5569E3AD0FF52BD438DC88BEFA0
      17C921679DB611ED223F82AFCB0EBD29D7DDCB3F71712F237908855FE2BC7A77
      76C658AD1C4CB43EEF135C31750566C219D76854E606A192AE0F1BE33F3E9C9D
      37787407476FDE38370A99405655C0AB5BCC3968E96AA0F515F58A15AA97268E
      B7485FEC73807B9670D35DA42F9477EB9CBEDD3F316951046FFF6296B4011733
      9F08293B82DBF4E709FEFCE168FF7D9BF30374C01E9F35B296BA908B65E85A3D
      CC22C4CBA2580EF22EE24C055A02FCF3DB12DEC086B8189E15E788E88D461A18
      3FBE7ED7FFC9799B7086CB54A31E1EEFBF7180F7306F64B89666BE6022152597
      DEE523156A7175E12751047858BAA3E3A52A431B1458B44DC30637747024D498
      AC876F0E1A2912205838AD12F1AB6548B5C18C03A42163721B0271CEE8044984
      03320C4CA70BAC7518E4BA99C85645053170A6C898B92D8F7E5A0E9F460313ED
      6EE4F47E4B73E51C9C9FBE611F814D19F1190CB606A890823A6593A913940EC7
      C6A9F80C4E457FE354AC702A064F9DF2A6B01E8C452015D3169E0DA78704D791
      53B129139AF219AECE5E6E92262BA7BC11499337D041622E666DE7184742DB39
      9B6B32143ECBC9F765F327348A97CB83683BDF6AC501B39C7E7EADBCCFD514F4
      650776AA3CFDD2F95685298DE2E8565726A961233910363D9D36EFD54FB5B450
      34EFCDD1E4E080A7BB79AFFE9D71DED7A72293F8A5B39FCE92945C5DADE60884
      EFCF66491B5A61639534D72A816BFB82FDF61F386AA953541CC2D6FF70782A4E
      9AC02A81BFDDB9516CE6926D9265EA8221031CC145A5434E5D9F08AEDE135C0F
      8F8BFCAEF0F2B3BD8D21D65C436C7BEBD5FBC37326A8B64D24B7B49C6D439F2F
      416B89DD302006B3F7900F1FE7B2C6C380BBA5732752E8C221C3DCD9296BB9D7
      BF003F8E7D673CE97344F7BEB8ED472E691E02115200B46F2A92C4EF4968BEFE
      F4FB07C5BFECB891B9709441BE5C460E2F87CF236FE6D0B29CD7F2FD29E50F1A
      3AB2223E571C490C02185F7198FD30BCA6C1E549FA1463EC1BBBA56EC6917CB6
      D77F73E69749ACD1AE77C3968A9ECD6B646D91889598BC29BAAEF46034D278B9
      DF38992D5795F300917CE64DBF2399BB191D47119F899EE1D982F2C6A57F91EB
      228B136D152063FDE70BB10149E7A32D3220D70018228D96DB010B004A2FCD9F
      EB586813190919C414F4034815CE8EFE43321C3B6835053CB4243E8A8C8E3097
      28B46E78BA991229DBD744834A870217E7876BBFDC507600693339F876DF365E
      F09EB0ED26026B78A9A2480373C9005F20C17B88D8D709ADFE5BE4F21A3CF443
      4B14CAC95A93BC6D8B6650C2246BC81D97940A37E29894772347FF36E14E3EA6
      1690A1B5B0B3AF6009DD00AF16FF12FE061A6FAB9163B4795A6EA7A35796C66F
      408C58B0A93066C472B48FF9256362A306B9BD657A8A5E8711CE759C630726DF
      2EFD2AE005CAB5A0104B464D663D902F64E4B100CC455601A67D9E82F9F5DD77
      68C5CB454AE65A91539B718C057540B01A0DD63193127F0A738B9A7C91AA595B
      101CEF3DCCC455F02C9D369585E8F5FA8381875DC136B321A3262B8F33412437
      9130F62C96026A2FB8D10F4BEDFF45C90597012EE60933A13593B8767B4BACCB
      5908F6368073F066E1CD44C6D033E030C6BEADFB90920F0BCC9196A512C5EAE7
      388B900317FCD4825A8A7B631BF1AD1913855B02E90A7E02DF0F8F693BF345CE
      2525B193D778FFB22A254D92DC56A588E7604B56687EB4B7C8F9816CECD1F377
      6CE7D01E7DD8766862BF979F74EE6DC08C3F4B69436F53DAB0CA197FEAACB4A6
      2BF04C1A3C1BA9D640CA5AD2D848251729AE260E45FA8CC9BC73197E9E117101
      3F825592032614740B497ADBC8C19DEA999EB9A4AFE749661835E92C40244FA3
      CE14FA7BA698E7A9B166ECEBB55714B858529767C8D5D8B63FBB0C83FCCF876E
      741085DE554339437FDC8FA29F9C1FD25BEDBC52D9A57371996430142DF6F9CE
      BDC6D61E6BB8CEDD432C18D47E77FB4EFD95EFD477FE754F67F33D7E935FD756
      FB1BF4EB2EB6B0712C24D8C4949BCD5DE23FEEBF79F393F3FACDD93923DB3878
      75A9085E4EAB3478704787C7878E62E2B8AC04B22E5260CD1C998405AB8D90AC
      7D500E62966754F9EC855FA779AAFA0D43CF670FB0BC84546DB2BC9E472F6DBE
      D801062C4E2C18F04E46C3F52E05CA3D616E1441DE5E128970363471F8651F91
      503222965A68711326E7106AA549EE053AE9B8918E7D65D345A0C1D71014FA1F
      3268A44424D02A95532789FF1DF93DC727EF0E6DC0D9D253203872AD52C6A92C
      99691B3CE2F76F0E7BCBD869F7A8B7F988238395364963072A1554C2932999F3
      2ADF9A43C34C0370E306E1A7668ED146406C8A31B94191E96538B72B585A6069
      2AD12CD9F4319EC5C9CDAD73A3156373575BBDC24FD55282FD34BF9C2549BA09
      027D8E205077BA0902AD0A02F59E7810687B2B2C1BE2EE964D629B484C85F3A5
      9C2E0540B52912DBEC9BCFB06F36D8EF2BF7CD53E7CC7D0D26F645FEF67BDE0F
      E8899DA9F48A9181D796E3A340C1629D8781E32FE6E465720D8FF45AD39EBB06
      BF3638AFB8EBEC09AE90B5A30CD8D4E05E6A0978454972C56DA8B9037C4943CF
      DE64FEB2167001A0390583276B151C2B97C922F22BD6B23089F364EB5C859173
      1D4211709017AE3897731551BF8D42FD2D0A7583BEBE52A13E7D125E9F19331C
      0F2170F4E22BCB8A67282E6DDF0AED9DB577430D1012C09749C4410CEE89FFFB
      623637A8622A6F304EEF3DD5CAFA07C39CEBF4CA2A5614BB61B0473132F7EF93
      306E2412F9F69678E667EC990B8825222DF2DB3F9BDFBFC7C08F64E0E71838CA
      C000A2AD1CE608F1C9E795302558596DE17C01588C1B62891560185C3EDA4471
      A1E06F6913A1003825E3FDD659DF28B8BD558281683EC06E9C64AEE108209CC7
      3163475DD0F09B289AED2DD93861FC9CD1FFED80688F9007445B27BA753C447B
      78B45E0276C7DC2E39447FD92C0B71EA60C428ACBE404990F2D0F47F23C4C05A
      3E8B81FC1FD1AF0DBD63336DB8EDAD13E6D091C63A9681FCE2D410EAC06C9106
      14130405F5D10FD267F8D252A8E94F24DB106C612A6AB33FB93EBB606A1E3DBA
      F586B4E6375A45BDBDE1DE067D64A551F4F4F9C611B1A51D96653ACD57510E78
      F47B544EDC4F386CF6CB6FD82FDDCD7E59B55F9E3EE9E9ABC505B21C2F9D204A
      1417D8CC61F9F271AED230139A4F1836116AC45BC1E2E79F6F5B7BCEF9659871
      5B50AA332473B1A5D03C72E736240E57A77203734B843450E6AAFFB15011C368
      9219902C2ED81AB8756CFDBE7162A27006EA50A979529EB74801CF48FF3686DB
      0EDA8D73BD7BF7C19C8BCAF69C575234CBD5E760C5435BB327FD5D82C9B63EFC
      B4DEBFC0A333F1924C28C3D5C50865D874D0D3A8F9371B85F319144EE7DFBF92
      145757A93E5A8AFDD1F2A6B63224A1B10CEB20B9AF8DB79D6AD97F2630207508
      7B7B7BAD2F28BBDF22ADCF80765F0744080E0823A59B3A14C12EA0E516ABEBF0
      42EA53F2546B0E423EFF37E721B11AA9D6A8EE5CF17D5151121965A7DB7E48BA
      CE42ADBA1AF15128391B94A9034EC85D9C20D942D45DC5B79CA14F43BFC219CA
      581033CC1134976780957C8924E131748F5D3401F1BF584F73FBA823FF124667
      8ECFB3DEAD2D093E45D0F490E96011D91623F61B67B4A642F228E1332D504393
      DB2635322962E696162FCB1C14C1225FA4BACD6C622AA257BD513157D6A8E846
      DD667059AF3166657204961AD5D9D17B177BF406752449927FFDAEFF5E506BE9
      70B985A5495E2D3E88E95E906CA4E673BED0CC9F29EE295135CC80DA8EEDAC9D
      A92B3884A969D98A131BC84BB5DC1EBE20D6812DB0ABDE1E411B3C02F710379D
      ED5D0C322C7B54EF1673BA0F6D2EB7DC5EF5F4D07A0DBE7FFAF6F8ED372FBF78
      3DE9F65619E8C30C543694E2D6A48C0529D321DB8F67C2F4CB71830CD9AEEB1F
      C327BC5040C2E5974E379ABB2BD96D5C57619EC213BCC878398799FD2D125C1C
      2728B87D790BE0DBBE9EEBD85777974DAC85C280AF034D2FAB0C5495F1AEA54F
      689DF261697628388064C18986C993421E4BDB9A5F5E49AB9E456D24B38BD404
      ECADDBDA3B7B9FB6605B066937DADAEF602973160F020D23CB8BC89C16914AA1
      177D9F5B15D50D59542D26C6AB889C3E37AD53A09D5FCCF1D3E09B57B221D285
      10062E62D4EE28673470493AF6DD684DFCC085C61B77F0B75B67FDBD8E73F4B7
      F747A7C727476FCFF7DF6C7CC355BEE1D3676B973D676C15B85C08D172362513
      96F03BF52F6DE30C1AD6D319F4D70C614F71B86A3CB162EBD09FE8E0013CAC4F
      C79F5817A4205AF24F8F1BBB8DDA6CB11250D8CDB75C8C48577BD099E4762D3C
      DBF83D4F00711502BB820C046D7A6BD0186D4C88D601F33222B971C41000AD82
      34BC91457E244F631B71A43EAE283BD23C55ECB7C24A9925596E91790D1DAFF1
      F5675AC515238C356EA6759D59E58C4006D7F8065AB95ACE51DCCF0F7D74D5F2
      07B7DCF59AE9287076D0E68435103B655F6A366B3B076725900B97581BC7DB26
      6F5C7B00609864AA1D73E745C144800F040842CE283BCF060D4A10FDED11CAA7
      D0F33811260C7A7D6CCD9996F39AEFCB0667F5E6D8D810282DB3590D2F24597B
      85CF4B5AAACCD89827E38566E04AEBB94C31DE2DDB5D7A7F34655706701962AB
      5687C023385F1ABF617A960CD673BEFCFD37A787E2A2689546E050320BA99145
      2868812C466B192A429F6DB770F6D95059BFF8B85E2D2E50B0CBC939097399E2
      1AEF32093DDB83E06A8179B1C86762033671BCE79775D2B3CE8758F017F88430
      D82FE5FC1B2D2626F27BE41D5367FFE0DB53E747E130EC0E7EC26639929EFCF7
      8AD56269949ED137CD6767DC9B49D27F37E77385FB34E50BC64EA5C7EC39DF84
      12EF3456F95C1E69EB9F00ADC45D20B44765A68C92F2DB4BD1C522FD2A5D05E2
      00F0FCDACEFE9B248DFCF667896E7284360CCAE8EC1CBB5FE02253CD3E2D9617
      E42B4D2C02AF23CDAA5C5250A864BA11E7417D7BE25A3FABA1C7EBF965AD05C6
      A70322E0C5BC7127208C29699DE373D84AB22D8747145E0950434B78789C67C7
      55C347F2CACF9C533EBF4B43C5F19386F6519D17F5243C0C515E901A2A476F32
      A75AEEC44904F2E151AA83AD5163A187068206E637D4BCC7E50606D48C3797B9
      9BAFCD2F313FECBCCBE2F62234AF492887DF8D96B66C8B0A72CEA5F2659D33A4
      4ED9DAB9F1267FB537D9DB24E3573B904F9FB6F41B84D0CE2C06CECE372767E7
      BBB20BB1AF190CAA38C8B2244269304A9D7D04E28FB8D8E8F8B0CD616BB1531A
      A9D7F64D459439F24EF505DBD975AC97029F8F7B4E4452EC6E8B2BAC9CD7C83C
      CAFD379AE633689A2F9A557CE299B1F36AECD6A484B8A375A6FE9EA42C3B6B74
      A828CC6F4DEAA5122F72D9254116DE14C4D10D4D8D1BC20EB31999BA9B23F237
      2FDCEEDE06506AE501F9D4097851AD06B4409BA00AC2145123646ACA32123AFD
      C85665A7824CFEF5DE5AFA0497420D58452B07E5F4E0482ECB808B8C55C4C149
      7AA95C8136AC89E344F0A94049410BDB4592DE3AAD6F439F7C3BC4634E12DFF9
      064D6D2D4BAE496E8EAB0D9A265B464D1CF7F61613AE58AA541AA835EF1C3A4A
      DEC24C940D8048EE85CE2B112AFC2E96542C79BC8A11324A1EEA260AA3C09B9E
      43FB0873EC7B955FD2C487CD6CECDBAF954D4AB886A1B58881391CB71C931680
      6FCD013229D9339D28487F1BF78059449A2896EDADB3BBF18C9D4566A0E779AD
      B76D122D4F9CEC2A9CB79100315DAD6D676F6FD7F4E478D52A258E3FB6CE8A20
      45AB5DFCEB6D126B4986B58E91EEC99DE20D5A4D94A0F251CF80F12FA414487A
      286CDFAF6D434A8220F490D8AB3125065DA789D2E06ADD00C5BAE579E9F11979
      9326A8CEB0A0CB64E696B55DDC1752B0D348C42A4CA17C10C1B5C92B6557E20E
      5789898477792999D49C71016435F2DD9A2843B210750AC4A1FC46ABAB32EFA9
      511713663373EC4ADD5505D2CC8BF0AB2207D7C4A1F3111C142B27AC6444EBA8
      6FCE6EB45E2DC2A812ADA65359B2C4D030CE0EEDD7CCF9C702E90FE5B852B84D
      BF0B0DD219E9734F0BD3002CBCDD3D679FA94938055B54FFF8A4C40C3F3C8D0B
      F16FF330DF7975DBE2155B34229A006CC9255B742496204C69F97D3053152559
      4D069C3A29952052326A3E8F904E3764545CE354AB3ECE74C37861EA2D6630AC
      BD86660FEE6607B81F3A4D6E6CD88D7D402743056851CA7B13D601EE8BB8A513
      7C805C205624E26EB2B27D91FB136C244E9068B97E5500F0667A96EC39674951
      F0091347AB2CE4400899B29997867352CE801A4F92AB466A17E42E6FD1B671E1
      1C3FBBE616E18B847322CAC579F4974D5FE26F8EF36CBAAC56C579864F9DC56B
      390D027D2D20517EA5C88D544233518C5FDBC433C308C05E7C8FD2222EAA3B48
      627F3D61C6F696943531F90C9DC93E0B46BAC99B19E629A23899B3C33E8BA840
      3E22224527F45364E3ABE5CEDA545EA56CF0BEDF2A36E62E4FA894A4BF10DC1F
      2E4C57CE5EAEB3014EE0821E83BB6E8ABA9A0CFB658E88089613077F5466EA65
      0A085567C7387F1692172515739599F4A181242850681B29F1F7B6A230E59A7D
      6626AB363543B812342D0568C8ABCAE0E90599D39BA3B7BEB6FE4F32D2BE8385
      863398FFB54FEBF810AC589BE460454830F2D87AC556BBB94C68011AAB0551EE
      C3841C0A72C9F648116A95FFC9F996ACE860819A9B7C4539F103346438166BB7
      9C98D619694CFB5416BEAA7BDD4F2B81F43F7E4618FDE7C7584110C7F10C2B67
      ED172E1EEC8EA2D1FF4E664959C6DC2E5AA4B9D1DB60D35FB2B3A39D168BD2A0
      9414986D50AC8BF8525AEA029AF14B4962BC33DC22F8DCDA06D9DEFDE1DDDDD2
      663CE3DE743AED4F562ECAB934B2FDEB47D43B6A5FE5CA1976066EA7DF197407
      9D4E6744FF4DA470B3471B504F7DDD09DC20084C31A7D7E9F1DF7DF9F7D0A57B
      07233D1E8C86F873180C07E3E9B8331A8EFB43BFA7C793913FF29437ED7AEE40
      7BFD7EA7DBA18BC68349E04DFA7AD8F3076A7B6BEAB93D7AF8A437D4D349CF1B
      4FB43756BDB1E775BCC974DA1B7447DED49FB83D351E0EE965C603CFEF0D0783
      9E9AF43ADDD1C8EB79FEB4DF0FC653DD77757FDC73FD6ED019BB43AF3F9D4C3D
      351E281504BD41AF478FD16ED71D8C87BE1AFA417F3C08FCA9F2B7B786A3C974
      D2EDAAEEA4EF8DBA6AD809A69360E02A57BB5E6FD21F4FC693CE806E3655C39E
      1A8E5D3DA231D27BB8BDBE3FD1D3CEB8D70DA61D35F07B81EA4F3A3DCFED0FC7
      A3DE68D2097C12A7F67C7AF5AEEF7527DAA5BB74FB13DDF7A683BE3FD6C34EDF
      1D6D6FB99DAE3F9CF47DADF53098921806BA37EDB8F40EFDA03F1A68E50DD4A0
      DF994CFA6EDFEB4C4970DA5393603A20D974473436FAA73BED8D83614FAB418F
      9EA2BA9E3F9C7A24A960DA9DBA1D3D19EAD190A6A5DB1FAA89AF7B9DA0D77127
      5EB7E7F5DDCEF616843D0CBC6044567F971EA0476ED077A77A32A5D777FDD170
      3AF25CCFA7F1BABD891E7BFDD1507B1EBD463708BA83512718F6033DE9F6FDBE
      E7D16BB8E340D64A80D543EBE597D619CD06C9408DE9B6F2CB0E393F5DFEC135
      2B2D18F7688D79E37E2FA075657E9E60210523859545EF3FD6C164E8FA24C6EE
      D82779D3C8BAB4AA682602359C76067D4CCFD8A709E9F626E36034E9F5BAAE4F
      2B42D39F83607BCBA369ED28D7253993B875108CD5B4EF075AE9891B4C75773A
      D090CE68AA94EA8CBCBEEE0D68E179EE68A2BBE351DFA7C519D00A9E4E866AA0
      C6BD61875E87164F6732A2E7D2335C2C606FD8F1BBAA4F62F2FBDDAEAB868389
      3BEA77A6C36E8F6621984CFCE90057F5941EF44603BF4B33DCF17BF44243DFED
      0F682F0FC6811A4FBBE3EE30F0C7B4F22678354D32A39DD10F86DD116DAC717F
      4C43D193404DBC6910D0AA211979DE540F02AF4BDF0F7A9E1E0E685246B465A6
      838137A28F46F406AA4BFB2AD0FD61DFF5694D4F4643A5FC4157FB1D77E8D28A
      F347812F7353676647EE783A1D754713A33126AAD024FC3FD21CF404D212C35E
      203F6F6F55FF859F073EDD40D37F63D22B3DAB556830DEC0EFD0DCF7A055684E
      C7BEEA8EC7D30E69039A0C9796E96038A24DEFB94ABB6E406F36E84FBDAE1A74
      49BF9044A701AD6BDA81BA3FE9F7C79EF6691DD39671B7B7683CF4034DA4D719
      77FC891A0D49E5E8C9048B7A4CFA468D69DE26BE1A4CBA1E4D9437F234DDB34B
      1B4C4FC7932E49DC1D4C68A3F9C1604ACBB23FA4772355416B905686EF0E7DBF
      D7F147EE9054D5B0D7D53417BE3FD4B47F07B45048D5D11B8C87633DA1D9246D
      4EAB8C3EA481D084767AFDC963E43FD0DD60D0F1C7BCB2F191DBE519E88E1E92
      BFFCBCBD55FEABDFB532D71E69946082DD32EA0E5C8D85D40F3A13DF27E5E6BA
      233DA0A7B9AEE775A7234DD74F5D1AE9C01B0CF4404DF488F6C088E66C3C2255
      46BB734C9A95C634C056E9795DFADBEFD3E57DD2887E40EB80F609ED327A38ED
      E180C4E5D266184D877D8F36A3DFA1EFF687D32929746FECFB7404F448D7F568
      F77587A45D7540F798920EF349AB049E3F984CC72AF0BD4EA0A6E3E16440734E
      42A3D53D9D8E7BBA3FA52D3C54B41DBBEEB43FA299A50106D88D63455B588DE8
      C0E97AB49AFA83C1703A194CB19A7AA46DE9757CBF13F4037732F1C6A3F184CE
      89FEC89BD07C4FA1A13B6AD4F5C79DBEF6DD1EE9E9293DA1E3A93EC9A93725F1
      7526819E92BAA197A145D9D3BA3F9A8EBB5DBA624462EDD23AF07BA39E4FBF53
      CA1B763B748E92AE20AD3598F4A0B7A6A436BAD85E6EAF434B9434174D0A9D6E
      1D85DBD04E1F78A4CABCD1D8D774BA8DDC2E49930E10DDA3236430A0E37032A6
      FD40A738BD787F34F2A793111DBB13DD2135D6D7EEB84767E344757B1D3D0EFA
      03ED0F47435A4ADAD33D9C53BD9E4F47FB844E483F18F51429DEE970EC05A4AF
      E8A8A76333A0C7D17A81DA0C48DD4E49276ADA88537F48C6021D732441FAA647
      4B9DA6C91F2952152AC0983AFD4157D18250C37E8F1C2F5779016D9BE978DCEF
      2BB24068BD045D454B9A16D2942C08DA63FD9E1BE81E24E20DE9CC0A26231CD9
      D3014DB94BBFA563417BC1784C734807D7C025C5AC8231992E1DDA58642ED068
      6826B07CBC21992EB4CBE98CA423644C929D928542BF2055D89B4CA61D8D0364
      A28763E507138FF6AF1E4D3B9D29F4FB80E6DFEBD3D749CFD3A222514E86931E
      9D4E135A4EEE800EA3112D305ADA239A2F5220DE58D3E6A74D38989228E8C0EF
      9191138CB08A48110C3BDEB0AF159D00DDC9F656B74F6F12D07492605DDA5E13
      35849D814999EA697F4A47C1846E1F0CC7B4A27A247152DF74F691B69EF4BA63
      520E58D6B4D7BA014989843482C2A7554CEFD0C17CF43AA360A803921CE93012
      8176359D3C139A8DC1988E3E6F7BABEFE178A6C3970E7F7F408B99F4D784EC34
      351DA96048070ABD7BA069B329350D689904B40749B506F4653A82066419069E
      A69D32A6C5E2BBF8CA544DBAA4687B439C9374D3C0D7DE24E8D243F85F7DB283
      E80F3AB8E8B018D25EA0CD43E72E99A2B41168667A43DFA345E0D306E9C20824
      497526E301C99D3430BDB34F9A99CE055AE764DED1D9494218D059EB79640E74
      E8501FD265231703ED74075D58ADB49CE968259DD921AB888E6418A43EBD16D9
      5D01292B5A07138FEC21AF4B8626DD9B940A29D089478A7E3471276471B834DD
      6464D1BB907937A1854DAF4F076E7748A784EF0F487664F60EC824087AB47948
      8B918EEA90693C25A532F4024546E088B40F2CB88926F371A2E8465E8F0EA62E
      D962DE80F4C1C4ED905DEA4E483B8FE980E9751459B93DB286BC1E9D2C74CDE8
      FF6FEF6C9ADC368E307C7795FFC31E9343AA80F902503E59965D72C5929D4849
      2EB90C8081C488BBDCEC721DAB5CFAEF791A20B90409801868E32465C3254B04
      BB07D33D6F77BF3D244074584E4A3DB3ABB0DD5B0F3BA80B520F8BAFE0E02953
      ABC8A729792FA752DAB4D052977C4E71C98C32B524D19C1884C06AF05191AB31
      A2D6053951682E1942E59E6B91503319D8540AD24281E42C81E89382A560D5C1
      3CE8CAF052A1999B81BFE91CA8292F4914D091DF205AD05F5BE7467B029E2A52
      2701496C26692932160C94720755A650C30FD2461A06885390786EE12EA10393
      E10F7867CE1408525E0D1B4832D8696D6AE659E78AC83445E38310134376B296
      EEA0A454C26241868623062FD9CC91EC6073246AE81B34BC48D2C078749AC402
      1E4A3D75B96491E08E6447FE490E26C33524607299050EC6129546428DDA40CC
      D401C457AEA9B467194B701E94266535D41BD0C1B4993C515A97CE969AD820E5
      8540C02857135A8D741E029A86198490F00ADE4C72EEB22FB99B041D2C46500E
      A9594DD1C08B98505631764AB25125E3113BC6BB8C354BA87905745D0A02A490
      D4959421F119CD837629ECBDA6F30137242FA28D711B956A0220C91C1989B52B
      C9D6E0B8A0CCB0BA84AD16494449454C94115DE3A16DB9F65C8D5688F5AB7D28
      1C199CDA5BD0D1913E68BC1A9A9F52AA360903C24500521EC1AD2DA569CAA026
      85C238582891922586FA4D65AACB02EE8373340164924AD813C1448E85215346
      C84E7432443C7589240F141368039EE7EA2588AD2D9C48A04ACA25C1D0654937
      29AD134C26A3B92C60722939DF5BECC68E422A52595715CCBC0AD2B54175203C
      CE25CEA71688420348DC5648299C889A4C0D2501786A3BF16E3514DD129F0424
      F08715316588860380C6240E766AA93B74A190EDBC66E1E81B396B294CA4794A
      39E59458A392338CB6CCA0A18B851C234967977B581216E2299CC7F4A10238C4
      97CC4DB448830E0E9571390049AEA71204CF72A61405E90632A2AA224D1B47B0
      06D7347943BDA1CDE515F5948E06EFE23D55680F11AFA56F041570A3AA4DC890
      1DBC4C9B48CE3450552FB1A9AC444F9513480E6EA0592AEA4DA005626D782B38
      620A22475EB259ADBD24491A3B3A9C4C60E30B86CD2923C2AE33F8387024DF66
      34EF99700C56413A5A528D5440A25FD1307BE644D5D0A961DC00FF500569D541
      5628E02463480EE14D7306A1CC592B5C5C342AAB687E0C75394D8B3AC1E9D2EA
      52CE988BD81C2C75969452D80A47413570775225CC802CA20AE828CB9C5AA30D
      9D3C3D364BC4BAC0C95CE585A3D193D5C4395C0FA449774ECAAF2949E277436B
      479F51684D2F5052EFBC025A74272429927B992610166ABC2515D5AC4399111A
      B24381CB0C5D5B2DEC25212D170D9D9125DB3133728A4F4BBA557883E487A4AC
      145CC9A8121248B5AAB30CBA4C72A6E725E3B064856CE1085B293312640A7CA9
      34D4997667848E04FFD349D111621C6BC9441A315C782297A480D057BA3A87BB
      D22D19A4E1370AD2C00A3843439B56B8871C084B86436419F983138EB587DE54
      74A916FCD29251F85917A29CFA1A649AF0389A90342BAAD6FEBAA41EC94E173E
      A8A5C4D52091245C91CD6909C812209699566942BF53260D86AB222337EB202D
      A0B028AA5B1D08602887C41A3D2FE4C8159441B043FCC1D8CA606913A1ADB2E9
      20EE2E04DA81ECCDB2D13B49D0D0F7D44666000E30D051185831DFB016100A68
      0F2C8D248CF38BDA7BDB04528FF68C9C115FD25783221A7C5C4E55F07026271E
      668D2C89A3242F6584286D3CE7483260183460BF14196009A01C69B68248C181
      E91BE1355458F4A03C942566800FE7768B0949AB480A996DD7A5975DA7A9B2E9
      6EF1717786DA78B173EFEFDFB43DBCB01202838856996C97348E0C527AE978C0
      539DE708113AD22805A3690CA541A22D4EE9456ADA44E96872E815A98C7C108A
      02725B16191CB0809C115475203111CBA0816A8400DCBEA0C7A04EE5B04E3820
      8D3815202FEA42530A4A5C9393001CF935D42914A6A0E155B99186CCD0FA7035
      0D0DCF083A45418582C35160E5A68123115034981E3645A76394F2DA43E3E9DD
      CA9AE2452342D492DB645B0EBA0B4F05C58E05A0BE534552A66F692964D70637
      C0C3F2C2814FCA24FD170B0C5D25954019254779D97EA80833C89C974837151D
      8B054E201CDAD3AD5C6FF5A9EDAA965BF3E3777CA78EE3DD6058DAE87EF0A539
      C86EE0D45EE0D0A1934EA68FC447A45DBAE6A57DAAA1835051535171BC87321C
      0997667569F766E8A0261D66C52A0CCC6B6867E7D24C2E6586C19910BE53FE39
      DED39D9F33DA99DAE4D103B6FB6377BB625595F8FD5B1F3FFF4C3EECA836EBCD
      DD7D251F795CEF1E2D4857D9EC46264FCB95324D6A05BDF4544AFC42FBA7E88A
      096027A836BC4B6B29EF5ACABDA1EBD4B948D0EF9B76C6F2FF4A46C0AF486585
      A09EB1A0F5F04E2F9F2C9006C8D519ED837431708AA49B03B1A2794FFA391A80
      CCF05F02C36A946C52E89D6788799AA3266BE7B4D3734E7C28EF99DDBB4A3205
      7D96E25CD6CDB9B51222A789125AC346E45D2111DA5A8886EEAE0CADC172B1C9
      40ADBA73C695DDB9564E1DE4D4414E1DE4DA738C2D736E3F0FDA8DD13BF328D3
      A253CEA933A9F391F4998C3E93316732E64CC69EC9D833197726E35A991C8F8B
      47CB6E9DF6AFDAF758095799BEC4C939E4C0C20E93F225969BEDFDF6C33ADCFF
      7D7D5FDF6F57D7FE279D5979B1DE54EF435D872669DF0AD7ABEEA3C1FD99EE53
      43B911627FE69FDD7788F72F6FEF569BBBD5F603AF8BE2E7C721C34F55B8DD5E
      1D69A457C7F2C9D5A36C72F5AAFD49892F46A58B9EF4BBD07D9522FD423E703D
      9E76A7F538E9747C02C343AA2F9E7840FDD4039AA737DA3EF51CDD530F983DBD
      D1F953CFB19835E05E6B4588FD341BC17DAD7920EDEBCCC3615FC72CD0B18B2C
      9A0798BE4EB64067DEA2F7758A9916EDD1A1FBF0D86E2A96F9130798B7E21303
      E84F37621E1A26069897662606709F6EC43CD04C0C300F411303C4A589AE305E
      7D7B23CF938A0CAD66B3D9DE6CB6DD6D0F5157F537E8ED9EA51EAB2BE930DC45
      A9C8445159923876C977792ED7B6376AE5DBAF44454D7FDBDEDDB469AE9AD5DB
      87BB701F6948B8F931AC37B7870726475DFBA07C17B60F7771F33EE0E370D3D5
      52903C0E10677A7BC74DF70C92A84BDFFAB78BF4E0B59F60F05EBB0D8938430F
      10F10FDB7782BB55885BE76B5FDD6DE250B9F151D1B1D7FB6E751F6B9DA85C3D
      7B58AF435CAA68F55EC52F63AB1747825A95B945B0A71447825A9579856EC07B
      4B8CDA692EB26DA7BBC0C49DE6024BBBF55E62E94E7391A53BDD0596EE34ED78
      739AF67BD937ABED3A2EB17CB5DEC87DB69176BD5EBDBDF1F23B1A518CA43FC6
      F3EE8BEDED6D406FEFFCEDBBAB6F36377141FC6C537FB87A13CB120E5ACBA84D
      BB32F27330AB9B87385FF73497A0F0A01BD751F575E736F1C3DA7151F772F7D3
      C22F1E89D9308C4FE0F5506EA391FCDAAF1F3A4E1069E073BF8DBBD22380BE69
      9FC4B483D1A70F11898957C2085EECEA6C9CCD8FD78FBBE4A35E1C044F636EF1
      6577EAB189F899FC233E55BCF8200F535CDDBC8FD2FA66234FA20D755F7B10F8
      4AF531BC950774EC6C1B56E827FCAFAF6FDFF9FB551CA1DBDF7373F5D2DF4629
      FE2037C1C57BF1EB3F5CFBD5FAA868C4ADDD8B372FBFBB7AB3B9150E2BCFF78C
      5B41517E2637985F2FD2DF35C1BFFB5B287F1F7FE12F61CE371FAE9718FCE582
      8EAC55FC6A1599CE3AAD4DBD40EBF9E1373D9698F8C7F0A1DCF8BB3AFEBA3FD0
      45B5C1B10D0BB45F7BB969385E4FEE5CFE174118BD5FD06AFFD5DFADA4155BDA
      E8DE3F94FF08555CE4BDDA743D558CCEF7DD8D995DDD8FDD24EE29C7E5F89E6A
      647591477F6F8E32D3C81ED89BB61596C7A78D987594E8AAF06EB3969F803A0C
      3ACC5C4EFDFDFAD657FBBE772FE4FA49FBBBF61923AFDF3D36C807C153EA2582
      87153C48A901A923AB0E72FA848CD5AB87EBFD75771BC307593325ABFAB27648
      7687979EA01B153C19311B1214934E47CC4705D5A9F5C5A8A8EE8D99F557E7B9
      BF7B7FEEF3ECA46D920FDBE5A70887563153C3B2E783EA61C1762DE702882253
      49314F4FED1FC3D2A3C22C508D884F636B44691A64234A13683BB57D2C9EFF1C
      7E5CDDEFF75687F762CD89F9F7479DE9047FEB83EC4F0F9B5DF11DBE487F19BF
      BDD9869BFB70A435277046D77B2286463C3B114C231A133135AC31165C23D2D3
      513666FA54C08D5C6822F2464C9F11826A5E321F11BF148067096E5E08AA2521
      383FE18F68CC00F0993D3300ACA201ACA201ACA200AC9600F8D4F4390056D100
      56D100D67100D67100D6CB00AC9700584703584703F8CC9E1900D6D100D6D100
      9E476F46A4E701F8D4F43900D6D100D6D10036710036710036CB006C9600D844
      03D84403F8CC9E190036D10036D100365100364B007C6AFA1C009B68009B6800
      DB3800DB3800DB6500B64B006CA3016CA3017C66CF0C00DB6800DB6800DB2800
      DB25003E357D0E806D34806D34805D1C805D1C80DD3200BB250076D10076D100
      3EB36706805D34805D34805D1480DD12009F9A3E07C02E1AC06E62EBAEEF07F9
      D0711DFA9FA80CF7FC7DFBF65DFC4171E2D31B7DFE39E75A7EEAEBF82B41C38A
      6AF09A7334FB4E7AB6D9BC8FF89AC061943E2E9FADCAF56AD3EE8D7CF894AF47
      9FEECF7EFFD5E1F3CC633133F83154BB99DB6FD28D1A15EC3743468F0AF649A7
      31A382A714C2D851D17E1A35FD706AE1DAC9B509AF2FEBC664D321E96C4CFAC4
      FC7C4CEEC4FA624CEED4783B6A936DF3456F589B8E09BB4314F715D4984236AC
      70D16DC39B3C13FE1BDB7B9A70E5C835C67D3AAC70C9B5235A337C3C66D31C77
      8F1837D7EF2AD6EFB3013CB6C732C3EF6A91DFD562BFAB68908F1A37D7EF3AD6
      EF3AD6EFB333C8D85EC25CBFEBC57ED78BFDAE97A1FDAC545CF6BB89F5BB89F5
      BB5984F6B3C41FE177B3D8EF6699DF6D2CDA4FBBAA197EB7B17EB78BFC6E17A3
      FDD4A618BFDB657E77B17E77B1683FED1E66F8DD2DF2BB5BEC77B718ED67C6F5
      FDDE7644B349E091F4640D3D929B4CE147729319E4486E47012713C791F83C12
      78A4308F049EBB6D16093CF6DF88C2B8234759E3B84F6791C033E7CE2281833E
      1ED19CE1EC51E3E6FA7D92040EF97D368047142E7BFD9458CDF5FB24099CF4FB
      24099CF4BB5A86F653BE35C3EF932470C8EFB333C808259BE9F533EA18E1F749
      1238E9F7491238EE77138BF633D678D9EF932470C8EF71297C442BC2EB67F431
      C2EF932470DCEF932470C8EF3616ED67ACF1B2DF2749E0A8DF2749E0A4DFED62
      B49F1937D7EF932470C8EF932470C8EF2E16EDA7C46AAEDF2749E0A4DF2749E0
      A4DFE39E4BF01295F8AF61BFBE96DFC0587697C30B7FFF6EEBE36EF0FCCBCD5D
      B8DFACE5377EF613FED8FE5283FC48C3FD567E022949DB671D25DDF39D9224DD
      3D9FE9F3CF8C3CEEBD7D2290562A586D529BDBDCD4A6B2F2D4A4D499EE594ADA
      C9738D060FD78D54275593A621F16999A63EA4E34F77EA0E2DCF2F66C826344D
      FBB4A7B12753A5277F9FBC21FACDE1A963E7AF0FE7FF83873C4DF3D77BFC66FD
      AFF718B0BEDEFD1D7ED999FC378EDFD6FED77BFC66FDF461E11AAEE9FE64A6A3
      1E0616E242F73AE344565C6209CB8FF6499776BCEE2795F37591E7856AD25A1E
      4EED2C333549E1B4B269B063E39649A8B05EAB34CF6A579B241D631CFF2BC7A8
      07161E9F7FF694B3FB258EA7F4C0FF9FF5723C95071658BFEF3D76C7C78FFF06
      02DD9C54}
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
  object tmrShutdown: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrShutdownTimer
    Left = 184
    Top = 520
  end
  object pmuBtnMenu: TPopupMenu
    OnPopup = pmuBtnMenuPopup
    Left = 976
    Top = 104
    object mniBtnShrinkButtons: TMenuItem
      Caption = 'Shrink Buttons'
      OnClick = mniBtnShrinkButtonsClick
    end
  end
end
