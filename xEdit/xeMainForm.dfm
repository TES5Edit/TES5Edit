object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'xEdit'
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
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 13
  object pnlClient: TPanel
    Left = 3
    Top = 3
    Width = 1364
    Height = 657
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object splElements: TSplitter
      Left = 455
      Top = 30
      Height = 603
      AutoSnap = False
      MinSize = 250
      ResizeStyle = rsUpdate
    end
    object stbMain: TStatusBar
      AlignWithMargins = True
      Left = 0
      Top = 636
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
      Left = 458
      Top = 30
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
            OnExpanding = vstViewExpanding
            OnFocusChanged = vstViewFocusChanged
            OnFocusChanging = vstViewFocusChanging
            OnGetText = vstViewGetText
            OnPaintText = vstViewPaintText
            OnHeaderClick = vstViewHeaderClick
            OnHeaderDrawQueryElements = vstViewHeaderDrawQueryElements
            OnHeaderMouseDown = vstViewHeaderMouseDown
            OnHeaderMouseMove = vstViewHeaderMouseMove
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
              object bnPinned: TSpeedButton
                Left = 0
                Top = 0
                Width = 23
                Height = 22
                AllowAllUp = True
                GroupIndex = 1
                Caption = #55357#56524
                Flat = True
                OnClick = bnPinnedClick
              end
              object lblViewFilterName: TLabel
                AlignWithMargins = True
                Left = 26
                Top = 7
                Width = 73
                Height = 13
                Margins.Top = 7
                Caption = 'Filter by &Name:'
                FocusControl = edViewFilterName
              end
              object edViewFilterName: TEdit
                AlignWithMargins = True
                Left = 105
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
                Left = 232
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
                Left = 291
                Top = 7
                Width = 45
                Height = 13
                Margins.Top = 7
                Caption = 'by &Value:'
                FocusControl = edViewFilterValue
              end
              object edViewFilterValue: TEdit
                AlignWithMargins = True
                Left = 342
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
                Left = 469
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
          object vstReferencedBy: TVirtualEditTree
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
            Header.AutoSizeIndex = 2
            Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoVisible, hoAutoSpring]
            HintMode = hmTooltip
            ParentShowHint = False
            PopupMenu = pmuRefBy
            SelectionBlendFactor = 32
            ShowHint = True
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
            TreeOptions.MiscOptions = [toWheelPanning]
            TreeOptions.PaintOptions = [toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
            OnChange = vstReferencedByChange
            OnDblClick = vstReferencedByDblClick
            OnGetText = vstReferencedByGetText
            OnHeaderClick = vstReferencedByHeaderClick
            OnKeyDown = vstReferencedByKeyDown
            Columns = <
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coAutoSpring]
                Position = 0
                Text = 'Record'
                Width = 412
              end
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 1
                Text = 'Signature'
                Width = 70
              end
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coAutoSpring]
                Position = 2
                Text = 'File'
                Width = 412
              end
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
                Position = 3
                Text = 'FormID'
              end
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
                Position = 4
                Text = 'RawFileName'
              end>
          end
          object pnlReferencedByTop: TPanel
            Left = 0
            Top = 0
            Width = 894
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object fpnlReferencedByFilter: TFlowPanel
              Left = 0
              Top = 0
              Width = 894
              Height = 25
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnResize = fpnlViewFilterResize
              object lblReferencedByFilterName: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 7
                Width = 80
                Height = 13
                Margins.Top = 7
                Caption = 'Filter by &Record:'
                FocusControl = edReferencedByFilterName
              end
              object edReferencedByFilterName: TEdit
                AlignWithMargins = True
                Left = 89
                Top = 3
                Width = 121
                Height = 21
                TabOrder = 0
                OnChange = edReferencedByFilterChange
                OnKeyDown = edReferencedByFilterNameKeyDown
                OnKeyPress = edFilterNoBeepOnEnterKeyPress
              end
              object cobReferencedByFilter: TComboBox
                AlignWithMargins = True
                Left = 216
                Top = 3
                Width = 53
                Height = 21
                AutoDropDown = True
                AutoCloseUp = True
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 1
                Text = 'and'
                OnChange = edReferencedByFilterChange
                OnKeyDown = edReferencedByFilterNameKeyDown
                Items.Strings = (
                  'and'
                  'or')
              end
              object lblReferencedByFilterSignature: TLabel
                AlignWithMargins = True
                Left = 275
                Top = 7
                Width = 65
                Height = 13
                Margins.Top = 7
                Caption = 'by &Signature:'
                FocusControl = edReferencedByFilterSignature
              end
              object edReferencedByFilterSignature: TEdit
                AlignWithMargins = True
                Left = 346
                Top = 3
                Width = 121
                Height = 21
                TabOrder = 2
                OnChange = edReferencedByFilterChange
                OnKeyDown = edReferencedByFilterNameKeyDown
                OnKeyPress = edFilterNoBeepOnEnterKeyPress
              end
              object lblReferencedByFilterFileName: TLabel
                AlignWithMargins = True
                Left = 473
                Top = 7
                Width = 86
                Height = 13
                Margins.Top = 7
                Caption = 'AND by File&Name:'
                FocusControl = edReferencedByFilterFileName
              end
              object edReferencedByFilterFileName: TEdit
                AlignWithMargins = True
                Left = 565
                Top = 3
                Width = 121
                Height = 21
                TabOrder = 3
                OnChange = edReferencedByFilterChange
                OnKeyDown = edReferencedByFilterNameKeyDown
                OnKeyPress = edFilterNoBeepOnEnterKeyPress
              end
            end
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
              
                'Forum: https://www.afkmods.com/index.php?/topic/3750-wipz-tes5ed' +
                'it/'
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
                ' any of the following: '#39'tes5vr'#39', '#39'fo4vr'#39', '#39'tes4'#39', '#39'tes4r'#39', '#39'tes5' +
                #39', '#39'enderal'#39', '#39'enderalse'#39', '#39'sse'#39', '#39'fo3'#39', '#39'fnv'#39', '#39'fo4'#39', '#39'fo76'#39', '#39 +
                'sf1'#39']'
              
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
              '-I:<path><filename>  [Game Main INI File]'
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
              'Navigation treeview:'
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
          object vstSpreadSheetWeapon: TVirtualEditTree
            Tag = 3
            Left = 0
            Top = 0
            Width = 894
            Height = 573
            Align = alClient
            Color = clInfoBk
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
      Left = 0
      Top = 0
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
      Left = 0
      Top = 30
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
          DragOperations = [doCopy]
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
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toPopupMode, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toRightClickSelect]
          TreeOptions.StringOptions = [toShowStaticText, toAutoAcceptEditChange]
          OnBeforeItemErase = vstNavBeforeItemErase
          OnChange = vstNavChange
          OnCompareNodes = vstNavCompareNodes
          OnDragAllowed = vstNavDragAllowed
          OnDragOver = vstNavDragOver
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
              EditLabel.Height = 21
              EditLabel.Caption = '&FormID'
              LabelPosition = lpLeft
              TabOrder = 0
              Text = ''
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
              EditLabel.Height = 21
              EditLabel.Caption = '&Editor ID'
              LabelPosition = lpLeft
              TabOrder = 0
              Text = ''
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
            Width = 306
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.AlignWithMargins = True
            EditLabel.Width = 86
            EditLabel.Height = 21
            EditLabel.Caption = 'F&ilter by filename:'
            LabelPosition = lpLeft
            TabOrder = 0
            Text = ''
            StyleElements = [seFont, seBorder]
            OnChange = edFileNameFilterChange
            OnKeyDown = edFileNameFilterKeyDown
            OnKeyPress = edFilterNoBeepOnEnterKeyPress
          end
          object cbRegExFilter: TCheckBox
            Left = 408
            Top = 7
            Width = 50
            Height = 17
            Anchors = [akTop, akRight]
            Caption = '&RegEx'
            TabOrder = 1
            OnClick = cbRegExFilterClick
          end
        end
      end
    end
  end
  object pnlCancel: TPanel
    Left = 403
    Top = 280
    Width = 318
    Height = 153
    BevelInner = bvLowered
    BevelKind = bkSoft
    BorderWidth = 50
    BorderStyle = bsSingle
    TabOrder = 1
    Visible = False
    object btnCancel: TButton
      Left = 52
      Top = 52
      Width = 206
      Height = 41
      Align = alClient
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
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
      Caption = 'Compact FormIDs for Light'
      OnClick = mniNavRenumberFormIDsFromClick
    end
    object mniNavCompactFormIDsMedium: TMenuItem
      Caption = 'Compact FormIDs for Medium'
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
    object N32: TMenuItem
      Caption = '-'
      GroupIndex = 4
    end
    object mniCreateNewFile: TMenuItem
      Caption = 'Create New File...'
      GroupIndex = 4
      OnClick = mniCreateNewFileClick
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
    object mniViewClear: TMenuItem
      Caption = 'Clear'
      OnClick = mniViewClearClick
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
    object mniViewClipboard: TMenuItem
      Caption = 'Clipboard'
      OnClick = mniViewClipboardClick
      object mniCopyPathToClipboard: TMenuItem
        Caption = 'Copy path'
        OnClick = mniCopyPathToClipboardClick
      end
      object mniCopyFullPathToClipboard: TMenuItem
        Caption = 'Copy full path'
        OnClick = mniCopyFullPathToClipboardClick
      end
      object mniCopyIndexedPathToClipBoard: TMenuItem
        Caption = 'Copy indexed path'
        OnClick = mniCopyIndexedPathToClipboardClick
      end
      object mniCopyPathNameToClipboard: TMenuItem
        Caption = 'Copy full path (short names)'
        OnClick = mniCopyPathNameToClipboardClick
      end
      object mniClipboardSeparator: TMenuItem
        Caption = '-'
      end
      object mniCopySignatureToClipboard: TMenuItem
        Caption = 'Copy signature'
        OnClick = mniCopySignatureToClipboardClick
      end
      object mniCopyNameToClipboard: TMenuItem
        Caption = 'Copy name'
        OnClick = mniCopyNameToClipboardClick
      end
      object mniCopyDisplayNameToClipboard: TMenuItem
        Caption = 'Copy display name'
        OnClick = mniCopyDisplayNameToClipboardClick
      end
      object mniCopyShortNameToClipboard: TMenuItem
        Caption = 'Copy short name'
        OnClick = mniCopyShortNameToClipboardClick
      end
    end
    object mniViewClipboardSeparator: TMenuItem
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
      Caption = 'Hide'
      OnClick = mniViewHeaderHiddenClick
    end
    object mniViewHeaderUnhideAll: TMenuItem
      Caption = 'Unhide all...'
      OnClick = mniViewHeaderUnhideAllClick
    end
    object N34: TMenuItem
      Caption = '-'
    end
    object mniViewHeaderClipboard: TMenuItem
      Caption = 'Clipboard'
      OnClick = mniViewHeaderClipboardClick
      object mniViewHeaderCopyModuleName: TMenuItem
        Caption = 'Copy module name'
        OnClick = mniViewHeaderCopyModuleNameClick
      end
      object mniViewHeaderCopyLoadOrderFormID: TMenuItem
        Caption = 'Copy LoadOrder FormID'
        OnClick = mniViewHeaderCopyLoadOrderFormIDClick
      end
      object mniViewHeaderCopyName: TMenuItem
        Caption = 'Copy name'
        OnClick = mniViewHeaderCopyNameClick
      end
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
    object N33: TMenuItem
      Caption = '-'
    end
    object mniRefByApplyScript: TMenuItem
      Caption = 'Apply Script...'
      OnClick = mniNavApplyScriptClick
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
      789CCCBD6D731A49B62EFAFD46DCFF90E13EF75ABA034292ED76B71DB3772040
      326321D180E5DED3382692AA046A5454D1F52244EF73CE6FBFF1ACB5B2AA40B2
      2C2752F7D911BBC792A0322B5FD6EBB39EF5DFE3249B1E8D759406F41F6F393B
      3A7E733CF6CD747AF8DFE3691C65D924FCEFF1F4703C4D57419A8EA7DE5C27A9
      C90ED5D0CC62A33E75DFFFAFFFF57FFF5FE3A54EFC713A79F5E3E138D5473F1D
      FEF778C2DF7AF5E3380FB3B91A98DF7393666A1A27AA17FBAA9967F33849559E
      06D14CDD76FC20FB5F784AF12C7E0A3DE3F8B5EA4ED53ACE553AD789C1BF12B5
      88FD54C591BA30B7798A47A64A47BECA53C34F533A555A2DF4BFE34479F16219
      4726CA541029DFDC98305E2E4C94D5D432343A35CA8BA334F04DA2FC38D21966
      A455BAD0612823C6347CA2DAF4E73852FD3888B254EDB5FBFB2A8B55275C0451
      9A99A4F9093FA6F972192799CAE646C5D12CC6032BC3E271D93C485516C7E181
      1ACD8D4A8C172F1626F28D2F73882315A4EA7F1F1DFE3F070F2D0CBF6B902A2F
      C9BD4087181E33A579FB58251FA3E3E97914646B5A247A172F8EB22498E43454
      5D45B15AE82C3309CD3A0DFE30AA8EE706D18D0E733D090D7DD5376619AE955E
      2E13E3053A33FED6F41E38039FE73A7B99AA0BB3C23EF0CC5F1F1C1DBC49FE73
      FB1987779E71CCCF189DBF6F0F1E5A90E624CE3375543B7E73486F1D64A94A83
      C8333CD4EFBCDE3D93CC8CAFFA3AF3E678CBC44CF220944393CD1363EA2BBD56
      0B7CACA65A89D199516D13665ABE83B5A087A820CA62D5D3D87D15C52B95C479
      E4D7B32458D6D42A4E425FA54BEDE10C4D5393A90C4B992A9CAA551264998970
      8A537D636AAA172749BC0A225FCD7410A5EAA2D9EBA83088AEF96C0FCCD42426
      F28CAF4ED635FAD53C8FFCC4E0264C9597E8746ED29AF275A6EB619CA66AA9B3
      397F77A1C3699C2C8C5FD789370F6E8C9AEA20CC1399CA34B835FE81FA14F926
      898CCEE6353A06269A0591C1D908E36886FB619626E28B87BFE7A949B0002699
      D22B26F8431C19350BE3890ED54C2F0C4F94771B8BECA76A156473ACE6721EA8
      A357DB07E8F8F5F6E61FFFC49BFFD1ACD53C98CDC36036CFD28DAF4D833A0E5E
      18E0BFD9EDAB1F2B47623CC9C3D064E34C4F3637BEAE0CEE80AC01368F36DCAF
      9C004D3B9129A3BDB95A86F92C885EA62A5E456A415B5E5369ACB4FC45C551B8
      565E9C4336ACE626310A82C8CB721DE20F731DE1E969BC30D93C88664E6FF0E8
      C358575AF9F4A9257D6A62B2953191CA56B1BA31491AC4119D1B0D299187A666
      DF7EA2BD6B7E12F6781A246956A3D59905372665F960BC38F29DE6FFB9BC13A9
      AAAB1B1D06BEBA3C1D8EE46AF079699D0FFF89C374AAC31017FA35FD36D4B4E4
      F75C1E35592BDF4C751E666EE7A2B87A75BE7689BD6C7C38E816D636AF20AEF7
      B59DEFDC78D7A4DD3A4902C5761DC5ABB47CECCB5405BE893288E0248704D82B
      870C5295664118AA9BC0ACF81005B86024984843ED3BBDD450DF40F8E320E0B6
      E3E861A9CAEB1C1A8D1DD5CAD70B8DAD9F06215DE3C46828D494BEE0B6CFAD30
      26DD8ED5F174E49930E4C99060F1832C4E549AE935C6981A5C978874BC17C629
      EE4D0DF35826264DD5B559A735B59A6372C5E521B19D475110CD780BB4FA1C44
      3E563D35294EB73291AF26664EEF1806D7466915C5C942873C88D36B9D0C9B09
      898E691E86AA1FEAF53063757D76D13B5556BA8A09505327269B9BD4D72F5395
      99DB2C4F8CF2E679744DD386D28D217EE30447AAF840BCA0170FE2A8B629BDED
      F3F95026669AA7C657647B68BF5002AEA2A56DA64114E0657033EDD57BFBA3CA
      973E543D8C8B0F9DF6401DFFF823CDEB344E16EA8A65893A3EFCB9A686994EA6
      81C10D871E9CE8E85A457A617092715D8C6FDF285A93D64995F612E82A585BD0
      17E9A3D541CB5A3071923E641254ACB39A4AE28949B2D9F5F1E1D1DB9AFA076C
      ADB98ED4659A2579AAF6FE3D89E95FFB3565BCEBD4247A5E83083479E4E79379
      4D41C5DA6DC137AF61C6A9563C99D0EDD7691AA4198EFBC1A36D9A1E19A9A746
      63F31FFFFA5555E6B4DDCD52A1410FAE71A320E6337D4D82355C8B12CBE63AB3
      2ACE2A312836D18D30B14A8DF85E0553D231FC8554BEC16A432F605464C99AED
      0B92E76430AC82C84DA17749AA7A3A54DAF7E5EC2EB44F0A616316D0CA2A8E3C
      C3139C9BB5F283E914FAA49C4AB120F661EE136BD235D659300942487D56C2B0
      D4F16B18E76406616CD2BBB8BD58495EC5940C0BFC9C98457CA34336E31203CD
      8D9FE87D9C26D6A9D83C4B1D602613ECB42687658DDFD7ECA5E4BD63F3921610
      93B08684359EE878B0A3A421AB9D667561ADAFB494212F5315991482E7A2DF52
      4B9388210CD74507116CCFCC2CA081ABC2EAA2DF82B68D6E4C94C53869F8CAE5
      240C6EB09F7812AD240CD67469C2D0757BABB695A72335918DF4DF97062146B2
      D7A3C5FBAE46B1F2E225ADB38AE2CC5A5D741AC8CC8CB3B9499C2605D7E6DAAC
      5771E2AB304833D69ADE5C45383732524DAD70A9E95C6DE9F607A5ED1DBBB356
      7DA57B6DD02758D9475BAD9B062B2FE79D09D5EED8B035985A26C092AB38F11D
      E77C8F511ECCA218EE55330CE395EAE96BA3FA3AC9021DF2892CADB0248F52A5
      A7903F85A116272A33C9228848EFF28284B17634C536B7E99EC9423517F25C57
      B4386B7E596BC7ED2C9F56DD58921AAB380FFDAA86E081602CAD97863D73B671
      683FB55A9834D533A326660AC3A92230D94C8FB5EF68AF36290893F8CAA3E5C1
      81BAE34061C348DF63AA953FBD4C65E26A9AC40B3E5D9986F947EB1D1A1DC901
      84316B962233E53B5648C88B38CE9E4C777E7FF8AF713E9B6F881C1D89149840
      0F7FCFCDFFFCB52886E34C2B2E1FBC827AF599D872EBDAC19EC28CC9D12A6760
      A325A5C757B3A723322B75B96423C0834736896FDFE31B85F82F9D2B088A506C
      1BDE72160B95B19CDEEFF25EA7951E4D4E2DBD32C5D76649E057DF975E622B0E
      FA3D923F88EA0BB388937535C8549AEE31991498C715DC4C7C2B9DC35D22D5BF
      D2C544AC3B95661A0B44DB42C7A79058DF7D844A5F77EF897DDC6D679DFD3D76
      F7E09E74DBECBBBF532122B08615A3B55D603A145F7E99AA09A2C12C076AB453
      E2BCB0B56F58355B41518EEA34F3CD58429668EF5A427EE583ED56447186255F
      5358894F2FBDC642AFB1194104A3323499A3888E54F7E2F492C2BD644E4F0336
      0A2195B2781978348DEE45B3E7A67FB683238981738CC0032FE5CBD406ACAF0D
      0C3635D13E5F0F7EFD49187BD710C91242E165A11B9E6EEC6B4AA3786B0FC79F
      730B582BF89512B60BE3F83A5F720CC655D26A0F22E6259D5CF2FDF9AAE13645
      089A24863F41B3944FD341723C2758226BFF6F44A5C826475420F2D532D41443
      8008D3EB52C0CD63845CB3B9593CFAB6423EF078B8B2F1CAF17C234AAB5A61E0
      5DABFF509CA78836E50FBCCD7869A254E43CC242246EC85C7827A98868169A7A
      8840B41FE8309ED11ED3272494AC23C83E5A00892CB14FB7C8C32CE06F4AC009
      DFC45F12E4A2F68A14089FF66A68C04D18357D9C562F0C969358C394809DBF30
      516E6D06FBE62FE1C085F9225273A39178DAFBE1E8F5CF6F6A6A6B4A5BF109B7
      597D08280724DEFDD2241C674C3409337A3CC7EBF95A7D087CA32EC85418CEE3
      15BEA7556A32E4C59C7593D5CAB283AC78B0225E1C867A991A15CB272805334B
      E27C69E48A4FE25B9525C6380F5E9CB7C44C1383080E249B09A72C4D834CCD62
      8318AC863F61CD31D9196BAF917D4A620422840F1EABB12C559EB656471CC679
      E26C82DE046980F3FF87992450C049B0248BC7D7C9B54AB375111FA76B4E9753
      86B429997449B1DBB93159AA72E473945657AD73FEF613282A9CA13CB53E1402
      3A5741820C871A25C6D052EBB4BC6494EB2CAF25D9C35912FEAD85CB1114AE58
      683C1C795607E94B3264D91F132D9EAA3DFA5E33CCFED6C297828475B363681C
      279B535CF03E32CACB06A5A1088D545D49BBE6D58F936E5A50582488D4F07A9D
      048B97A95A19BD84915A7EFD7DF9C7CA6F0B4F5DEE845E2E8D861F0337ECD1B2
      FA9CA42C85548D1FE40B1BF0727714BDAC58724402E93AC63A7CA728ED06CF94
      47723C4B51BE98E050C2A088FE6DBC8C3494D2FCF87AF9FCFA34D4B322299171
      340CBF83E285C3E818E3CE30A6DDE7CEF0FCC00F431C597E3D09DCD8143E1486
      FD2C9F5EB296DB7A8DBBB934C96BFABA89D8E2DEC8585D0D1EBD8B1D4AB43A0B
      382F8EA661E0C18A0FAF6B950BF732A56C30946C2296CA5E0B4AA91B6571ADD8
      8DDAA68F5ABB2F70F24B0E45DECC11EDA60FD3998B13B3FFB5A002C59714D642
      84C056BAB888D898DDDEFE4E967A4E3AC4CB9304D714C61F4E1554ABB9CDDE89
      AD5118F1DA138540F6217DDA2F122145BCD1DCBA396643CEB025777C73CDC938
      793689EF7869578A66217F121F20A9BE6126310A9DEE74DF197A92C679E2C1C5
      F3E044A694A5A709D935413A5CE3E4E322DA80BA73348AA1005023F7C2017040
      2D58059F24244CE485B96F7C3759BFAD9F6AEA1FADF39ABAF1C23AABD47A9E05
      615A53FF48E3A8AD337D39815C62A11FFEF1BAEEF3DCAC2B6D633C41A2F2658A
      AD58A86512D3771E9DF439C96794FE7AB488E064AEB3CB725FFA57F031B5AD74
      2F655E8BD43049DF8999078895B23B264FC3D156CD32A28558413233C0F84CD6
      99B37B25127835471E98664C53F0748468F9C494013AEB488A07B46D734C480A
      9169174736EBC34F44B463A913FA2872C1948D257394B2CF69162FDDA6FFD198
      A52C1AD26A3EAE9018991C5FA129C2A2906827FBDA69A61D7DF74B98A01B021F
      37965E72A1296152A834ECED7B6C7FEA25C13253E696549C1F9B9DDE3531E27A
      16C9B32C409AEF567B5928AE3AEF53797424AC4C292F473B02DA456975909ADF
      6D24CF0AA7CA118F8CF1DDDEEE34B8550B1D44D6265516CF108672F9D37C62FF
      465B9C667182D8340E17C1E60296177E9E90FF058DA2C3202545FCF8D099D5C9
      D628638DB45CBB4A83C29C2F350D479E3981ADE63AF1BD18AA4AE26714089758
      356435343A9DB8DB8C118BEED658610EA6D7C1322D5E91C36CD855AC2404ABC5
      0D683BA92267A0F904532A6D1A649B72280DE3AC9245705D2FA04A39BA6C6383
      B4523617CE539228342B8F6E5B1D1E1EBA590CB829365B30D7914FA15CBB4788
      72C18A58051E670E8ABFB0C00C22DFDCC22DC189CB248F2269DCDD5E5F4E00AD
      3822851B597F478890D151BE143F0062904E412930C88C930FF1EBF1CE2A1D42
      65ADCBE0966C8CDB4D8F2945577139F92214B1C9551021D96C030311ECB55D5E
      1B06B885FE5492E83036954E12BD463E49DF068B7CB1213E39C2192332C3C1B4
      EDC0EA6E892F6D1503402CB388125D122761158F97873BE1FED659AC86D6D727
      AF81026408D32D43A3120A0AC577C2011579CE2A943C07BB41C5898404282288
      7BBA2ADA5E52A47F2B038F5FE2E894028FD5F6BECD9A7B949D348B65C6511EEB
      B063E62CA26847DEF3C58F627B3A4333152C05E25C65D6D2CD614DE2E512FA03
      B0BC785517D14FA89942E30AE4F39424664CAB13954254425924B57CFB388D1B
      45A1D6E2031BDFAC6DAF7A4508D9A82B2F0DC23076C9E8D50B9383936BB48A62
      BBDD93A07D30BA116BBF0411C251739461E46A54933DE2EEF00C0BD392FC1CAC
      92D5280BCEE523F210D8E0201957C03F65F102C8A370BD9B6045980F796519C1
      1E6B295C0010104604DC789A2DC105965A8057C611863BBC0E96EA601620C411
      FA503564C3E040F3E90863C85B1A963FE134CCA7283133A8AC0AB6A138B5F67A
      9343F5B50CF88398146BBA5700A68450D2DE3542C808D7C4C9B57B6481B30681
      60542D40829D84844B5A80D49AC749E6E5364C182C188E900404BF65B719E603
      69EE2214431B09AC103F4EAC446DDF85A458F9619D5EA7168B9D89B54922D951
      E6DF87952DA3F214D7A5736E8393E916785642B9345731AF76988D281ECE3267
      0C9E9085634FAED84F12208C997144EAE8742EC853CA158A592F0802C08322CA
      15206D070F03293CB6F6AADB54CA11922C3B78E680FECA9EAB95C62DC8A32C08
      299754D8FE5BE1B90D139126D76273588C6304C038B0455A1D6777898A25E78B
      40AA1479F40D30DDCB54F5C37C365BF39F12031029E49716A58C0BCFCB0CF391
      4BAEF000981316BC5D209F2CD2E72E36FB4111C04960AA4D0AD265A8DD8471CB
      46501393E66196BE53A797AF54439D5E5CA948DF2C4C3A57591268E42295F167
      450296B19CFC5AA18EFCD4D34B2337853F7362A26056E269394D3337146D5EE8
      659975F774F834E9F50AC03F869080F8A0A478E021EA81A0A837876B1B278487
      CCCC6209940AFFD6D95B86F5EA7900ECDF043127C661A402654761BCBA0E033A
      98691C72D919E64CC803D1046E9A8CE3A6534317530203F4CA8501CF2974F581
      AC1CC7F70B331E00BBB799112324C63D451549BC2A4D59BA0FA86FF0033686F8
      2F523F342517C456EA49C9047D0CE91849EDAD1238753B383A4DE5C73955F2B1
      ED203E06A55C8288FEC92A40A7A80500B40A7FEB399E09088E48DF04333E0A48
      E15696890A3902806B969A8A2931A310660DD60D19671C1C8E25C902B0B9893F
      038AB77255377456D520F0E61489EE5CE6D9E5742061F054195C22BEA9408147
      33483714EC6CE5E6B91260FF3BCA157867098F40B5AA110A2E3982E2AACE9AD1
      D6635418CF286CCBE57D3490B925B7358EEA7F9824AE968B60BBD9EA603DEF34
      87BACEB398BC670C463F6144069522F0C8CA7D11FB06E6CE224849E3C689CA23
      E80AB274E443AC31C8A1CFA367990DABCD4F1480ACC94F0383D81D2FD665A417
      FC57B742B26F3C3E355967D8130B870CCA9AAA439F37239FB4BC55EB805D789E
      5956425FB60483C1E670BBE8205225124A3DB1A464C71CCCE671EA6A8BD57BEF
      546FADCE08F8468F9D215E4DC1A444076464C3204B439DCE1F9DEF286B8B142F
      CEE3ADFC6618F26CDC36E4AC73AAC663D56E8E9AAAAE2E93998E80BE24C32EB8
      559F22CC89E26C78B3A707050D3AA7034CE0D751E7BCA65A9DF373FAA9753EA8
      A9AB5EB38D9F8674FAFB09ECFD6CCD214455271B504CBA2929A0F439404BE7E7
      AA0E03E8C624996A931CC88D1A21CA552C0BC55B2A6951E4E16D25D7B551BDCB
      F648794B31759E7E8E2D6B43A4B22A833C02D25612C8AD51BBA95218C5D766FD
      0CC35F34AFBAAAAEFA491E21F8C400E68BAB5EB708DF3DE3B119B487AAAE3E04
      51569A8F8CFA18683FC8495264712C8405CF703E5A1F06AA51CCA78F228C3453
      E7B1C77A9D3704D120529C04D97A8E6920305A3982A998482B4E9E51708ACD19
      42456EE27D6D11EF229032C6E3376F60558C3AC337AAA186C34E4D9D5EBEC67F
      DE7269E3F0F4C8699A52E3C1A591058A24888274CE95415B97C8A27A3585CDE4
      CB28F69498EBE317F221117A7AF9AA717A71E5662E5D5CA11A34B8E57C119079
      1226CFE2A26C4C9D755A1F254E28EA8AB190C0502304149323C03E161F11F610
      C9F04DD5FCE26AD879A297C5A63AC33787ADCBF362DF6C8D2BE59BC8CF645FF6
      5314FC9E1BD5F408D35675A150394740D350C30CA38085DC930A76F7E96F47BF
      33F888D2F57CA1065494BAC8538A685AAB8FA0A5D3808A88276B2E587D0E5DD2
      FA5053C3D6E0BCA69ABDDEA50807A8B91A87F99E69E08BEE2929318B1C19CEE1
      EAA5AA7F3200B49C4E2B3261A4F5A5D2F6C9EED6EB06C486B32F12B3BA5FC43E
      6024B000820DF4BA545E92591C24F223E2CE44D4F0F46B797A09EC9AAAAB6105
      04B78D7863B41CA7689F610A6539675DECC5CD627388F0C39F19AF8C8A74FCFC
      E38F9282A5E2F2C8AC42E80B9BD921B8F8F64C6D8D3767D99CB6DF55510C8BFA
      F8C2C8B225F2EFD4E755901A75F689B2EFBEB9B5816DAE5EA815E5C93AACD4D9
      D36614C53BAB00990B2659C86C71829418A522C6B79763BB1CFEE155793444E5
      A2D9ABE42E93C0E78A62C6E1494AA9B89D514C69E55D2242BF7C1A8E707C577A
      A94E3F9D9FD3734F50DA4367A865E9A0103B25F0FD77C881AF7B386CC3BBA332
      D23824440B7BC22F1107E6FA6F84D26E08012B7E31854DF963123F12EF99901A
      693EE1840D19484831D9543D3F904A0D7EBC536A50921CB8D73E4CF3888A5D44
      4F96D96C1D06B308010A8A2EE18046C5EFB4EF18CDF27D7566B26E2AF281ACB6
      F2670B9B9CE504D616A9C95A5CE2490C1BC2C19B19505FF1D4D2CABF29EA141A
      7A0278B04CF1D767D09D9B5990CD8C7735DF4D264859BCB895F9761346127D29
      F68F83F1481253D011B7B766151532628432D9AAC97D2A1A928F9FDB4D5AFD8F
      C3EE3F395C0C102044194D93F66F95002FEFDB9CBC63F4CCF755EA69EBE162B7
      3F752D7CF014E58A64BF028D88AA502E40955DFA86ECFC0EB971D13D3DDD21F0
      7F5A04FEDF59A0083CF90086A6145CF52EFB7DAAB4094879D22D00AD099BF4BD
      F8C6500C6EA1D3D4EE6669C43F6854C9857AFADBF0290A98EA02269249DED16C
      8BE3A8D784565093F975ABC891F74C3A1FCEF5D200C32BB8194A068831FEF09B
      F8410AA363F52C577B09D2BC51A2A314AE5DCA6F73321C25014D9836CCDCB243
      E8538502F6E919569545E5077D135FAB6E8463A2DF21CE48D2D156C7D964C0D2
      442693FCB36F96D9FC59F639BD4654D6A4F37756EA940B83FCF8764A8973B74F
      A3B399CDC9CD4445D4B55A26F2352EA8E7385094F342EA585246962E0AB28B6B
      8DD4B04357A0DD1E16A454C22F95BEE364A4562B9D307F168377281401D01751
      5710C68C7937491544C4FA182F13D03EDAA20BDE8C45EC484C01262C302E0AF1
      95941C2F8265FA12111B5D83DB53A1D02A96D48F058B83502EB1A610AB163E5E
      001383A563691833E350C53157CF60B5B6596F0AF61EC24A54F7C01A0EFC877C
      6290E50518DB31F7D8FB6EF62F8230C1F3C1BF419471C31234E4AC415A13488F
      FD89E99FB0966CF63023435AB3B830A634AC6D3298A5B53BF8247CF7FC9FAFD5
      34710ED737C5E061FB318FB00F553001027EF4AFDA46012B92AEEC24499610E4
      71369A1638173E6A5F8566A6BD35DDA365706B3838A705EB731AE7490BA58C70
      6974AA7A017893E229CC7741AA2C34174714504E2F9E45F0EEB46AFF7A74B879
      40FC821981EF41EA9D4277ED822FB37B46A6785A5337A83B666BF9A85D88040C
      79D23CA663EF0C6609571020B019A8D639261384745A30C5CE1C2C96AFF81412
      B12CD7F4F0B214B648907A1255E02F82B56485F8658D0291F82C056D9F51B85A
      2CC384511CE15A85C0757201459D8DC06930A34525EC8A2C1A8B042132C07D10
      116580F3B8DDBA3C90B347A4377E457DF3C1441F3F9552BB6DE70B47D1C7AA03
      2F6A3951AD1BB208D225A89F7D79678E45596029C71C48FC3029F34A5D999914
      1451868218661DB7038CB30CE725622FD4698722C16CED12AE4B1005CC8410C0
      2465384134CBE19A14E2D8522308B2EF4EED8B137FF1EF4FC85FDCAEF044E334
      04516E95CDFFFE0AA7F112E2DC235D104715B6A503932EE9456DF48832440DA9
      1396B84B415469C9B2B76849F4848236739D8758EB591EEAA46E6E0B65C77949
      3222841A13E7B95E481D2A562974633D0C268966469F6B7B6CF87655427EE2E7
      9ADB2558C9E3E84F65082ED7AFBEB982C29FC0A5BEBEDAA33D41BD5912B0D3BC
      5F13A1864FDB6FC553299C10CE278864CED41585CE16F6FABEF8A438D6933037
      CB04893FD92C4F472F29AA2F757A8475B51F4ACB3FEFC224F5F5FD07E969B9DB
      691678D7EB86D05820F9CA4CAC61562F413F352EF66F0ADAA9AE432199E09F39
      2B04DBC271AA778EE35EDF24E1C0CCCCED7E3959EB06533917B326D46C394B31
      119E173163F0170B56A96C4D8079DFB8820BF962349A6286D759E4DB2B52DC40
      0A38947C96CD946D30562875D29BAC7CD8CB2F886F51513D13372D9EAA3098F8
      668A645423FCE375E3F6F603A43264713E9103B67B4C9EEF2C5FD4465108575E
      59B507B53DEAF44F6B6A3468F6052EDCEB8F6C64F7BDEA44744D41389598954E
      7C095E53F87E3370BF0FEC4B5A54E0228CDBA0B8BFA504DCF9AA9F26C6841A38
      2F1E84C99EED218D193522675AEC381365F5F679AB289FB1FCA33B44E0982119
      4BB79AD842192AEAA8A9D150CA04A8EC8E5EBA56E246E0230F8359C4992D91AC
      00B0E92504476240432404385316268008D56DC48FC0B3CE4CB214C2928957A9
      06E8440348C29362560141B910FB56111251DD88EDEA208EF66B9B1704EF7270
      326C360E60A1960AAB4A239C34B295D1D70012DFBB0D4FC123EC421D7C124F26
      6B2FCCCD268B70CB20B058DBA4264E834990940CC3DE8F35C09E16BA67B2240E
      FC7B3987894643474B9D65CEFCC3F796A27F97B17C0FEA17F2B6DD6D9E37DAE7
      278346FBFCEAB39A243AF2E6756E0442F0742DDCB81BC8910881955F90331284
      20C57F7D45DF73B3E83B518A83D49A07A17F86CC97F5A099A282B19E96561677
      B0A7834840C3543D7A972AF5B143FF767AF9FA0B1A87BCCC6C38F2D7CF9DDE26
      538890A27348253142AF0356DD42B24A4205EB01D1EEAB659E2C5D49CCB1696D
      82029FE4004E1BBF4C4262A04F5DCE0EC561AAF6843E01EC098E643B0354BC2B
      8DFC93D0A601636F295D2CD2F88AF22B7B848CE53025B8903025FA5EBA2F55D6
      94D8B4B971A9D2581854113B4DAE0BE23C32B7FDE9079DFED324F1489857E364
      735946AB090BE1B6993AAFFBA07376A106EDE688334FC24707288D0EAF15FF93
      31E6049AA15836289BD725EDB1DB411C7586AFBFD0140040A5CCA7ABA78F67BD
      E2679D9B346D9C112343522779C80A00750813C3596D28692654C58B11E0BF28
      0A50A8007F6EAAF4AFDAF4DFF08AFEA404F9575CB64D8743CCD1AAC3F18E822A
      F88AF0400AC58CB43E2A6AFAED032779B5D6917C88EA674B66B18D25E1EC49E5
      7B862A1230AE9BCA20C779C32922CA71487BD4957DD53B120E3AEE4FB18829DE
      77EF6C69A50A179D624D19AC6AE0258009095271E1A82E9EF1EFCB7C121246AF
      A818960054AA7C2C79CE82A66E59330AA25F223EC241FE4835D9148B753C0672
      E8AAFCE764672765F13FF9FE751113C76F8E09FC5D53AF0F7F7EC3901CDEC4E3
      37AFB7960FB70F25C3CEC1502931163AFA0695E56F82563674D8EF7980B022A5
      D9A1D0AD078B0A23062D706D45715075C8BFE4C88D3C00AAA0CEB54A052F3E1F
      52D4E26D46A8AC36970ABD62827B5C084DBD2598129738DC66AE74426D4914E2
      02E1F91B2799C867EF7AEEEFAB6E3A2EABDC25BB39E8DA45B3DCC541C3C488AB
      974E6434B3D93ECBA351A5F5A612434BF76FC5DD771466DF8D127C573EFC3B12
      F45C962F8EBCA4E6EFD65FA1951BE47198554B8E0AB6C166492B40042E7B3FFC
      74FC734DFDF0D39B2347BCA159D998C73B107E52920213630A710E8A604C5C68
      B4A2006138D7271A5F2AE6F96B5403B2FD515C9975FDF75C87CC0F04C15EAFD2
      21BEAF0C0A07F19B43BEF88D301B5F68EC179B8317ACA89A621FC699AAF60398
      FCB0E052BB4B834855F306DD69165BB38025789C6454093D373749E93F08AB66
      A52ED90F12F6C89D0BD2EC3309384ECFB5C92D73303B502F368FD6DE6BC0C34F
      DFA9A343C0C4DFA9A3FD17B0D6E34C87AA51D07572489C8FA96A14457FBB3153
      16A583B67509FDF6A525B1B0E181976A192FF3659D68663991B777F75C3F7C97
      BF1ED57D302541F7EB09EF7911BBDBC8AB4BE5CB5345081F8A0A0AA7214470BD
      8C5052E44D367712BB3ACAFC8A9BD1444BC85E893A6E2834BD5C86C835C34C26
      B0243A6165497CED4E96D801FD2295C948E9045876CA3521B30641158B7A2BA1
      72624D3E9E46FAD2B98F097059526653B70209A643A23DCCE2EB089927398C90
      ED80CD1765D156C363C5C84C41F08F00155B045AE4A04A1A14D42554B6662D27
      B04898EFC48D7D477D9474C4E9660675278B852694026D72CE7C9B4C93548837
      296C60AE4C086A321EA8927F8F64E1CB37B7F4B80B24DEF6DF97B8D9CAF3C1B3
      4F58E5202A80F0CFF38AF0BC413707AFD9728894B1503EB89159719C3C889679
      86DBF5B2B7EEC53E7C95971BFD0BBC18D660F957FEC4F6C4394CF7A4624E1299
      7554C356B22042B351C17258740F69F82252241D2F9E6789CF63622B01756BA5
      A7CA965DBDD9CDE459E621176623F6820B59DAAF64CC93FBCBB4E16C5090CB70
      C7E5980726015A40D817B6FC8ED2E9ED2002ED996618DA976B9D774B003110B8
      04E3233BDFF0878BBF446B1104D8D66759941F7EFEE9A7D23828A422EAAB7FCF
      B14F137490A04A5DB19E362C2E7A77A6AB60AF8DA9779E69AA6F0ED9161CCE03
      5061C5C4ECC6ABDCEEB6E1D181AD6499C48BA554355A5A2B0D7EB51582E144B5
      813080A5072B6FCBF3CCFAE8F0F8B870C27905A9629F3B081407E1CC44087099
      61E79777761B0E502CFB4CB37AFDE62705D673B1D8C958A80B99824FC870F216
      38F7E6AB7FA3F08BCE28FE0C0EC47C429F7E96E90D98FC538D7A661173846A54
      302BD041C4D0931C2C863E05A2EA829F668997AA3DCE73AA13D406E03EA2948B
      A95B6D02481846993F6660669D5BF424BA9E808C9DC8DAD0CF8C6780AA79B08C
      7095E768B88EE8D78FE16E7874C058D2ADA69269AD8127583A1D17F9D6B38002
      F8D67AA008BEA4802B9088C6FC1EA8FCFF9195F4B6745D2AE96D7481C2837B52
      61DA0038AB612D81C6F0F468C7EAE7FEA0A7EADC3ECD3753786B11325CC4BFCF
      3D0A39B0F36C1368F6DB95F2F83ED3E734110DC4DB33FD6EAC4EE298F4E2DE9D
      29B80E7F7681E1295120EFCF6D2AD34C1D33BFB25A4D3E4580FDEC1DEF3FF9FB
      5350810973300FAAE1B2FB306D49D30EE6D8F0A79D5BC2F29D26F1E204745803
      337DF20921998899742F2E7B8DEEC565F39EE9383FB892A5AC03F659A626B50F
      810AD123854B94E4DE48583ED10B0E5B1DDA72E284A833C7577F4E556B899ED1
      0C2C509BE2CEB6DC1A6236D1911F2F6C39DB134D6835A9D02E60E5D3CB155C8C
      3A228D082BD13C007BB7F6057EE6CF2C3520C0E2F65CA0066F6FA3FE5872D68E
      C5CEA0D04EB8588ECD04C6C504D68ECE19F6EA667C768667A5742399C3510174
      75666CA7ADBD9534FC62E1188F1A5E7EBA60FA8FF6B0658FF3C046BE85D28C63
      CD58C21AD02E1C0FB44C8472103677DC51AD212D371EAB0E6E3A240F256D3FC4
      798284C3D0646A1AC6205B0E66DC164C1D3FD949EBB6CF3B8566198F15819EE9
      26928D2B42378BD5394829EF2D657F8215A01A7AACC0744AF4FFA5AAFB85200B
      C38CAADCE02F1FD721811979851B579575FBEE35ABE3B16A92F59256CA9ED118
      7E8454B1F587DE13C49A4550190AB14E123B443A5479340D42585D6C10F13136
      E88A5BA7B08F855410CE9C8ACD8B9CD6108D73554F479ADEEE8976F943BB0F5D
      2646CB933DB6DF6CD1B6F587ED5185A82205FB21107E48307320113823018CA9
      FFF8BB3A3A3E2E196CB8A36761597DD5CCF8BEAABF87D9C01CC50691EDD4D5AB
      04B579680047427638383BE19F9D1EFA79F481EC9D5618E725664BF81B8868C0
      9E1292F7A9FAE1F8E7FA0FAF8ED45EEF70F46BE302FFB93C1CFDBAFF5C7E8600
      D8CE87AD41E31C328A48A04522F36AB2B4AEA34000878AAEE45DD31F282B5785
      D8A9B47FE2A5F1A7434A0E9F829AF522CEACF8761CE05C47FE392F300AD8A986
      BF89EC028513E1D2C4C38CF227442D2DA796424225FBA4F59B9C29EFF162A3D5
      A41DDC9CB60D3A64E8D4CD65105B0615A676ABCA1AE342793E9928A071CECFDA
      5D184415628572243A21CF1582250F4106BAD149C03DA1C841B7EFBCC7D134CE
      66912767E40B4B8038FD3C71EC832ABC9789F1F3C8D7E08A9AF4E37410678DD5
      045A8C7F287401B27EFA264E10695C4DAE8CF78A3FE0BEEC68D05DA9FF872A59
      4D0A70955040C6F85DD1002A8BD524311A410D94E5D67DB3048F61E4ADB985E7
      A385292EBCDBA60D47FF45526F386A8BEEE04E853A8433B3ABD97C25870011F4
      51DC25A18131CC2D88FDB0508D9278AE2AB5FE1C6627B13028C27CF9AA82C92A
      50C1446DBA7D5D3C47FBAAF36B1F4C731C042F6C0E806CA84A84FB3CB81DFE56
      6B5431D7EC55ACF8E51499DA10A473B4B9CCC97F5613E2C5F8AE757726993AB9
      BCFC58F12F885F9DCC5D9ADD10DD02F191C679F7EC4329C176599D6DBBB60E23
      731691129B06B76EE181E6C68A6FC4827068DCF20F78E57BDC00A241C439397A
      A3F6CE83C8E8649F2CBA3B05FD3B857A3E53A3EE96B48DBB3261EC0544C5B47D
      66993212AEC97B361E57847EB40DE7BE12A7DAD0716E8949327B98EEA30048D5
      0B5C1C11034AC384A197A05819B1D42C561797171D9B16687D948C4ECACF0330
      2E31E1BA54C2FB4F69337DEE34FB88185039076700161343B9F0CFDC2893A924
      11ACE6002AB1AA311AB8A69689B909E23C0DD7B64056AE2CB1D81CDD61B1A902
      E6BF8BC2CBED2E5FB4877460393A2624ECD62023C2185185140FC74E3097CF1E
      D7CD57921E961969DF3D68311EAB114F6438AFF6DC9085B327E67B56C5FDAC76
      85D9B44DBC119753752AF85BBE4A1B645E1C47C385BE68F6DED021B868F6DCC6
      5D4D2E4F46C381F95D82165D2E336E586E557691B0E2255D29E5F42F7B97EDEF
      277D83ADEA76972F5B3D590DA4C46A98ACF51D1A0289C7A1917BC07E2A254528
      3195000785243EF2ED0C4FCD13375448F7E282C4DF855E10813A252B1000C23F
      4C46E611AD9904A88A75E3D82F1A89C0CC0BBC8026FC1D4BE878B4B06658055B
      6156F4015A2FDD56E0FC9BC56C5FA18D7BCF70902CCEA9876899A6275CF91DD7
      74FFDDFDD37B7B8CE9BD3DAE4ECF44BE4EE7051E45F2B5EFA898AEACA5DB6BE9
      C5528D822C34FBEFA5299B7470E99FFFD740ED4974B640B5ED2B440E016E4360
      99AAA5E3948CBE46128B95CE2577EF1951790F975ED9F7CEE975065CEBA7F67E
      EDB7468DD665FB6CBF56D602AABDCEC579AFD1B9381FE13FC3FD1AF79CFD74A5
      F69A9F3E5DEDD7547FBE4E032F55C375E4A9BDFE87E1689F2F48BB773622BABB
      3CDD7592CD92606F12A2370A12FB694DFD7364D2EC348F3C91EE021FB0482149
      86DDB3F5EF55B3753244A4F0B5FA1B5FDB8B7EEB5FDC3CF7FCEABCCB96B0141F
      3A9F136FAEC3D05067BCF512D3137EAC46E0C1FFE2DFD15A7586B456B332AEE8
      A602FB5727D6C32FDAF9128005FF3C89FD3551E28A8C72CF3B5E75875DEEBF3C
      692E268189B2561CA2C88434E9FBA23494E2A841348DBF7A6977624E22BD55B0
      4EDAEAD3F77237C0CB6656DCD82D8FAEA378F51D6588AE9AA452A66A6193D572
      D5F7D552D5349FD42DF4439311B6873E0C28E60E433BE5FDF79BEA59EA50DEFC
      E436BF3B95B57776A65224B95963791FF0EA9DA4E00A6F15D4054B935C0BF895
      1ADD70AC9B7E2E7C591CFE9A3A391B3651141BDC985112CC6626418555E3E46C
      F80BD0D6D9FAD37296689F53F4CC125923820FDC1462CD241E1C2A100B2B8D89
      0AE24DF2264E6187E1423B0310ED2E9D7DEEB4D5DE59A26FE0E67C86683689B8
      72541CC61264D4C6C7468000A9B65E60B2D5CF14C4A8523A47A4F80023181209
      7706A0CADCE251FB840A34A88ED7284B8FBD030206BAA739591AD8BB4B11BB3A
      87DF81428FAE1B047DCFD62A0B2C15631928B1947F281BAF27711836C0F8411F
      92AFD5F36213D32C7DA690B475ABFB834F48DE71300F86E52FB98EB27CA13A69
      4A1DA2EC896AC5E9E32ACA8AFBE0982967594477A25808AB17E0CD728515154C
      A79BF51F35AA1123F45CA50A6D82EC978FEA21EB43566B9EF6F09B7F0C2F2F08
      9D6CBB5320454714C6CFB4FAA3CEA0A79A490650F302755962131777B35E691A
      16443E7111ED8D4C92E848359385F6B5156C4747FB7F12CC9D0A262D1F3865FA
      00E40BEB5409CAF104D25F658B5EFE505DD8D47BE40154B2F2DC036407DD5AB5
      A5A1200E4CBA908221D1E6F8AD7344879DBD33835E3F84174E6204A181F8B214
      6470FB2A0590D4698B26F02711EF628A5B640BC250726312748D17DE8586FCE3
      1C21D11277BC30D93C8635DBF4FDBE46FDBE60B1D31A05631046C6431BE8963E
      8AF14FF1E6E2C4DC3D7715165EFE9894426FCD901F84B032ED5362B23C914205
      26699577107B80D99E116279A6E4873D465FE1A328B2213C59AE6055F2B1BD7D
      66B725B4653D35808E503360FB7529F0DA68C64D3469CFF22A9D5B94D5ABEE6A
      D2E1D4C5816C6810CD86F9442ABC48E7AE26845D3CA0FF22457FB2EED883D138
      756F9A694195ABC9053190057F18DB9E0A5B2E304B3BFA99C9E81FF8939B4606
      369759F3BAD2A3FC0F0A9860771AA710A660592C923BEFB9C4AC4858A96023CB
      631B38A3EDA7B0D2003073F7E4EDCA385DE48439DDCFAD8B85F08492C381CD34
      D5D3A5F18269E009053637EADE3BDA47A7C4797D4278D1FBF9509E7CD6B82A36
      90EC1B2FC4692F568D486E2DD09829D345E5F2FBE14BCD7EB7D27E728F8A9C9B
      FDEEC1523F97A5F39B40740510F2A55C796A185CC462E44472BE981719689485
      7822E9FBA273A49AC4F1753D203BB584B508FD1CFA699C6ACF9C99481D44C1B4
      027281BA4E0C76131024F1BA1BADB94EF0E1B2E90657337AA6780E908CF4F7F7
      3064888B8324E3A0D9EAA80333B3AD0C40A046B378AFFA7AB98645C617AF528D
      E0CC95F2DBA7C837A111AE725BAE5B28FBF40BBBD1B97CCAAFB60CC962F54FF5
      77557F7578787858F00A320B1F3304D8D68EB22354F799A8BDFF71F47ABF242B
      8D9714EF31F5785A97CFDF71539E87ACDA261BE302827374F0F3C1B1E3CD170F
      B7DA4F17F520E4D27E93758884F77DCC43EF8B6A76A1481E1A3849B0BB4C12E8
      90905704CD2B87AD538E94EBE3DE17C532D67A00178FAF43D8CE556224C91450
      B3203AD8C330B60C6043F92A153CA535D54F8238812F144F99AA282654D74918
      7BE060158CDCD7FF22F68BBBB4AA1663963C4C968053F83B2D91659550746323
      5C6FCC060D38738E10EBB790994BAF34BAFAEFA9953695080EC11994A8B62182
      18896B52BBDF1CFCFD0DCBA25392A233ACC9EE2041E978F344DB0B218EDA3B3C
      387875B45F96234A86C7826ED031AF7C0C194526FB17ACFE50C8298094CDA3C8
      181F1DA120F29B9E87C63DB08D49C183423328763419A2D334A4C0AE6B38628E
      AC2FB4AD2F06F08D5ED0CBBDE8E55CE626BF631021E02AF8B95629C35943AB68
      6986408DA8D9C5E2E242F0FA38EA986D32FB2FB0C434B5B51492F97AB95B0D62
      B4E76DB11B48E0E75A512E54C75958AA19FB1EEB9AFAD761E35F47A44F1671B2
      9C53055E08554C51111C646661AF7B082C2A1D2EE7BAF1A13DA8151DDF861F9A
      EDCEE05F179748548FBA1767E59F4435361EB9937C69A81B67A2677E1C86B8C0
      2815BD554D4234EFFD3BC0418503EDB69EC0B12C60B735A380A55BFAA5A86EA2
      65907E31C81252D1D0C1B51BABD16FF7B1CA7F511FA03021980A8E6890BC33E7
      77C9FB42C367C0349313C08CE08570DE693E83726561890651F645D03D18CB13
      900842215EF10952B493F9750FE11268D5F2CB8EA6D316F5FF1736B7E9BAE094
      4C20AC0B7131D1954017FAB35E0711656B4A467C571950D0EC7F515DE677DFF9
      A157DCB58002F1AA8F350AA2190B178DF4D7D2D4490349F138192DD7C1522E18
      CB181680E8535D48D820B268365C514769122FD736EEB0168D68779F4880907A
      2F5A3F58EEF28292D338EEF6C040CAA2657119954FED8A9C502209F0B728853E
      17DC86E3B9F27D75119C5FB62F62DF7C51AD3990F10549FD45308081717ED92E
      7A615C048C0991DFB98D6AAF7861317D111E0AA91D872504D95966CF3899E816
      608575E44192AF5354B5171743D431E36BBC759DD4AAC492611BF4866D962334
      389FC107136B8FC1377E268688B46EADD7D229C962D51B7E307AF967B49DC0BE
      DF471FFBCED22F33657ECA34CCBC4FA5516633931E824FEFE52BFD24E63C367F
      515617C23155D4DA50BE9CC53C323F748778E0BD44B765A2666F8ABFFB393005
      057F91A3F95AE96CC23979A27D290975A5B71EFE4474685C4844269AB0BA4BB4
      2328A62BECF4C07BBB855B44075BD678B21ECB2267E942EEC58B0925EAC9757B
      F9B7976AAF422E6D93FC77CD71B08FC21DA47B22D5A60B78400D8B3022EEED29
      3ADDEC34FD7419065931847D19028BFD61D45E9DFEFEEE429D9DEC03C615FB39
      D1194439981AABBD2C8ACA31623743501EF05818C73B1D31563995EA7D291FBF
      01D68DBA4A50183AC59449428028CF46EFDC56C664556B87CB9289C2C5837864
      4D2775E5051D0D85FE97C24F263DD249D0D976F724BB2F0752EFB3E1654053C2
      924B9DD960681D5ED6FF78C9AE09119C50D3712205D99EE65EFD8F777F84C1E4
      7F867FBCC6FF4FF7DFAB781194E843FA94B0970A338A80E19CD325143BE7582A
      05EB84B887AB719689A973B8C6318C4061735D3449C5C502EDBE4F863BAD38EF
      9A56531DA686BA8048D31CB557484FF7645098235785381E9E2C9B6BA576A161
      76EF50B07CC20E05A3391815112A3316E6412C856926232626345464804086B4
      2E787B78F8B7A2770149BC23FA45C9BCFCA792FC2398500669BC2460D13EC981
      DEF9E1E8F8ED8FA09153C49B8076132632695A533F1CBD7AFB3321052B1158F0
      15E34FAF5FBD55BE31B0639768E182B804851D74103A9775F440E87CB3519A66
      5114022B86FF52E46F6D951AF8591BD58282272B0B97782A99CC05473BB871AB
      355775757A76366C9C9E9D351BA767A3210916EE6D1BAE45BC393603B97CFBE3
      3BE1D2827CA268EA6977F8C18200CB85AA159820CC0FE19E34639924269C9B90
      B7A9CA77284386CA8AD0CF22B903C2A9596DC2BD0B2D8F2AA7E52C36AD56618A
      04C79F5470EF84C8C24EBFBBA7D75D214E6A8C575716AF8E86231E3E5930DF5B
      BC4BB05826F10DA5761C8D05848BDF096DAF3DB874FDFF1984FA46ED1DFD589F
      04B6B4D8BE36F5625727430B40FA0F75F4EAB05CD74D9679C7627BE924296FE8
      173424B6E8B56C7AF2D9709F29C836A2A3BB75B546FB2621D11E79E69D1A2E8D
      F173EAE286845F9C14F05FA11F7A72FEFA0DB2F94DA015EDC61D4EFB9AFA9827
      7190A57964AAA4F682736DE9D4D37EA03758EEE97C23DBA6C30A577D33C9E68B
      18CDD2874C72FF993A81A0745B40FF1447FD2B08EC59DAD771B1A93D9A487DA6
      742C6C66A1BD751C015A03D5EC5665A0555BBC44D04B1A7E53CB2FD12B24C62C
      431991E19385EC135F7B9D58801C8527EB284095AC96AA141E487F358A8C2D2D
      57969D0E712843A1318DB78E98AD9659D85C17E5472C0AECBB9335901297107D
      F8B1DBDE304411C72567464C79B714E737B0B3237DCD143D30BCCC2D128C4C8E
      2D5CF524B3CE4CB63551A7B1FAC88EBE3CEDA8C3C3A39774E82D4510DC53BCEB
      6FFCC72F14787F79F8137FEAE56F873F7D79E934E427201AA26C147F30B73873
      B304753264F4846B6EAD4B49FC82D180D1CD4E3B5BDD9FFDA2E0313309C241CC
      400646A82C13DB882CFA29710807564BF1DA2F629FE82E9E6C1AE7E82CD88379
      EF27F1D2073C97E2CFE21A563D6B29DEB1E8789C7ACC3D4082CD190E75DF9CB2
      F51248051082661A7E1DE8F7B807EF938C41814210B050117F1657EAC4A5927F
      2F33DE3C92B3400D76190688DA2BE2BDC9E6719EE25BD4B59DB233987185DCD2
      1558405623FE33F8626D722655C6C5A6207E90A6E80A41508E48879CAEA03EE7
      2563BB381C3BCC61F045FD9207DE354A0D98E09037870F073BB89FDA83971B29
      F93B69F74B49AE439764CE816BD40C7CD9A602D8285D85474A5B5AC6F5BC0478
      CDAAAAA55B3D3721B1CD4ABBC2205371EE9AA0DBACE5FE02B80784E081303E11
      6752082426D128314E8A441A4AD13493A296D568245AE53B4F369FB26DCB0190
      4CB62EA15CBCCEADF1721BB4A55F977C3BC37C52177417419B08A2F3149D291E
      FD46C3D3A32F0254D848BA9F84B9E93FA98FB071F1B8390DF159526B908941CB
      58D519F671D1CA21770A1716014EAA25EBEBCC2DFCCD11863AD504950A0CE8D8
      2A0F2F71DA0A8B28B34B5A4A7CF80E77D1A5DF3DBAEFABB675A71A1FAA3CA51C
      8EBA1A7486E7966AB4BA95F4EBC8DF2898DE692A7D16D29B1D31366887A34DCA
      56B75D1467E5DB8ECAA341EAB1971797F71D94B234661A56568BEE2C995B548D
      A8DA261130C7FFF96C8992C2041B0473F4D8FAFE4DF28DA1C976BB11445F47E4
      5D7C2E018F8B237499249266E20CAF512BE19D4804B68729646AC3BE17B1D300
      BF776EA806BD314AC4BA5BCDC153C77D73614717246D4C009B36EC9CDD567A4B
      550AE0A8821F46975752E5EC5290EE742BCC695E751B17CD2BA642F411AF4743
      DFFBB9A26A457C6C4205425C1F8416EAC8777311805B4C70381A353688174AD0
      40838B3F38E6B50B3748B3DDBE68B42ECF2D6307D02C7E172D24CAE6484F497C
      5807D55C6AAE8D81C182F69C889B3D335790ED3559A61AAB03DEA9E214419212
      8AD8AD94B12CDD6003B364E220BEC78FA8A021668BEEF0A8D1EA0E8FFF0C42B1
      D5E414F13729A8B4EA8DF236DC948D906184582CE130BB1920ABC9C93A331B23
      5AC64D4AD565455BB81D3C5126369295AE8843C7875DE81B54A7B41031B1D424
      65E5CA1C4647B4017D70ADFF23A3753539CD93288000A3F66FA82FE05177239D
      B40FD79E9921F1FA140F6B5F9EFC838198E986A3B2D3996C858B8CA034BC7F28
      AC8FA7A80E9C1949860235E4F870040142E0584AF29A0BB32A7F5B86A2112928
      E09A8C17A04ECC4201BADB591A258106DCCF1E27AA0BA793C496EA5D68F6838C
      44AF9C66F37974DAE94202576C258ED5FF09045C9DF3F3F1F8D716E919ABCC36
      B3010DDEF22A46AFE2EE523CD99D38B221AC9172067A7194CD090E40D78C1937
      5A1FDDD4DAE5A78B6D63C92DA133E874E441B67044FC542245AA54893DCDC43F
      37470319AF22A4451EB319D3BB3B0FB762ABD3E1076BCA3C48BEF6ADC3377067
      16E0375D4D861401B5718B9293E6D7F3C1F9F3D38211F755710EEF66EFAA4E64
      17E0ACD4A821377E38471EBCE8064EF5FCED38CAD02B62F7C3401C971B24B377
      E7C6994D389A9DF373222E73BB3023E23A973E1CEA834E51239381CCF0FCB25D
      01CF8B5F8D5F1288DBD1A71D3547E3B15037C17FD96C441B47251ADB51AC7E18
      9475E197E88CB6C1AD8A1E6CF0CB1D1D32B9A5ECDBE7CB1A0541046D634BF024
      B2857892E3F613B96E5D7A5E84D683846B436F056E5D36580BBA5D20037619CA
      82C9E3BCD201C6D63BD9F7DB6580BE24B74700AD648DA21E5BFA215502BC7EFC
      245E23C61D8FFB1FDBA3F198C82F937C9915E476774F1EB11D2023F7E93E0A91
      EF1CB528D244FFE606A181BB688E54D8F922299082D1E5DA58421B6E5AB5C304
      7E2DEFD710C0C02C5647A456DC822A676D086C2953DD2A3CE5E0C22E4E2FD451
      4956477A899E893CB5A30DD0EFDDE3A5EFFAD48B36AEBEA5A4B968F69811D906
      2259169CE15772A88B526CD66B6EB6FEE5D5683C1EF63BED469737D54E80CC35
      3BB81BACE7D3E0623CEEF163C9AAA1D8C9EE4BD5BA3CF9C778DCE207138F242F
      48998BDF5A1A5783FED7610B27B328D8A64A77325C0F0F0ED10627CE67737574
      7870E876993A838FE3F16AD237C975C9E349F55CF7C5109CC600F5C4785C12D0
      936A01901529C10DEA20DA932D220B482DE961BB6BAC9128748AE355B131DDFB
      D634369F792FD5E7DA5D7781CAAB7C7A213D99CAB264AE2194FDEEA12B8C361E
      8BACB682FCBE7E00DCB7205E61178B8F3FD52C36DA8314EFDE2F1A7F2060C1C7
      A24DA4DB34EC538DD612B6170B35AA164D9D99AC95040B73860E64652392677A
      EF339375A3A95EACEFE14F4EB91F34D5EF23257367B6E812559DED33CD91F8DC
      0720C72B845DD59F288561B15A3BEFD7E97034ACFA331436491BCD24411EB810
      EA4FF6C66898341E0FCEDAC352811F23D1C63614A70445F8134598F0C2EB489D
      8F3ABF3EDAC13BBD7CB58BB97EC7DAE31BD2A42E43A5C55E0ADBDDC2ACF041C6
      E33B3D1DE06A6FB0D4DE3FCA73F18E238D341E772F5AADF2264B4EFE02A872E9
      5AED78F2BB7E689A915EA8BA7A41FD620863F682FD472EE3A11E3A9335A110DD
      5330A0366E4808414E9CD44EA1398D252ADEA1000E03141EEA3133E8A695E637
      3A55DC006CA7D05B074E77EB891E8A48B00DE854CCADF42123EB3998997B166E
      D06C7D185400D7E2B8FA6A6FAE974B1349F951BAD24B02CA800A667F97E8055E
      9ABA5EECC15F45593A28ED044589B610511086B6F9E84E54940BBD64308D6520
      B8C8AF351A23863E91766DE324B750BBDFCF75EC76CAAEFA36B807EB14F1DCC2
      5EDD21077BD50363604B6766865645DC5094720EEE76224811C7E3E145BB6DC3
      B6770CEB3F8F1FBA39E85D9284198FDBCD1E35BB935C0B5132C2B8225D5AA659
      E0F59116E1D4EFEBE72762BE97135540FB3B18B6BF881B18486979EACEEC4C22
      A8521D42C54845DD48A5A8E659C862E73AF1391BDFBCEA9E56CB506C11F1D30E
      5B08BDA2D202189AEE55A7D11F0D55593EBA419F5A6D4EF3A4B3A95ED48BAF8C
      C861CA82BDDB399B7675614F4C4EBD19A806F56EA8E339E8776D6C67A2D3C0BB
      878CB75125E375F3FD2B754695E75BA0549D2A530868462CBEC428E1A8BE3BDF
      2E59B21817424EECBC77E7AD1192643D0DAE520977C2049910C53C07B240550E
      1953F49F770C885E14FDE1100F6A742EAF06953CAF307014705076512E9A3D8B
      E351F8C2784C0A96C04CE3F16FC75F788A8CC68D150263E371335BC4E992CA7F
      AF983826983D4148663C6E9EB72CFEAA9FC4447C0440376817E2292CF9C05A5C
      AE9835710425E64243195FFDDA3C3FABE063FF2466CE3BB4737541D9DADA2CA7
      5288CD84160A58B74BAA4FE2F85AB58D30EEC55F8BBF3F621CA4E4ED3D757F88
      D007A9A1A743C329825D9E492D8BFD58CD90D3093CAA87082DC7123406D79012
      410FC21700072F0076A3D25E692FE63432AE5EC2E0404ADE51ED3A51EE8D9A23
      C7551EF49A8AA9A330F5CF06B950350C0360469DD3D2BF6DD6FC7D717E5B4B8D
      1399502A4DA4C287BC0EA22E4E9922E06B027BB70342B27B98AD432364A6E92E
      2C46AD3CCDE285DC6A22DA03C9C2972D6C82E50E2301CA5F14360688264E52EF
      AC137F230E1140D4FB5483964A67648FAA0D2646A1B29F8AD5B218A06B3B49E0
      DB2BED66CC4AB50CB849A5A8DF692E36395ADFDA8DEAB217AB421B52EE933585
      76A1AA25366E83AEF3246FA83948F557AF4B83EB2FE2797CDB383AF8898D6F62
      5D291AD6A8C43239EE0087FD5A717161F0BAB55D39312060DB882C6F542B3393
      899BD8EA0520652B0AF7ADCB86C22F3492A195DAAA7F761A0707BCC23B49EC95
      4E0FB2566E511F573ED5E9798C8EF7553C4963F2C5BEF5BC6F1D02D86ECCC2C4
      1552499AA1EA91B1BAD0EA4B31987000DD87403E5D4884013ECB27F51D789EEF
      721E3AAD65C193C8781C4EBC34185FF0504EF31B8FE5C99D0C39DDD838195A9C
      91256A0B11798A239B1FE4C1BFEEAA3F72B882938ECB2418A5BA27656413B0D6
      B5D7915E049EFDE0FE0EC315245A610C2620435E94C9A8FC11EAFAEB71D06F3C
      9E48FE900B0B437D2B6BC3D615154308D524D82BB78BF6BFEF050AFA4ACA7409
      992C81549F8870F5494E2477BB2B031097ABE85F9D4590A1EFD34D4F2FFF4547
      EB5FA7FA6B747F8F922642987432FCF58118E0A3E49CEAC5EC6233F11C11C76E
      11C53A5B6B14A4A16295F27CEC704B4F835B107C520A024E4D41235E39190C0B
      8D232564B97D1D42B751839CC0B1D9D46970CB9B5B34D6AB7FF5F52A7289C4D2
      8EEFBBA1929983F25F4DB0B556208245391C604FFFC20A3D29C5657DEB8233A3
      B48CB471DDF9683EDAEEB2FC3A43A11EDEC946AE72F27C911495BF4DCD43A647
      95D5673B0A587280B849DA8B3833EF886D2C25B7ACA0B48FA7D3807942E2384C
      998160AD347A094ED7DC498C540F37B6D35E96EB90A798663153C81966AEC5DF
      B1CC14AB174E2A22F9A596344EB3C67C3B67BD46875ACAA1CC8B2681E6470159
      42681EF53D05C2958E72CCFEEDC85C0512D902B33C5A05BE1F9A0FECF6A2DA1B
      AC1C05E68FC0BFD7467DEAC2698B51B2806E4ACBA5D1906894780DDDF2AC52E9
      4C755B2188158369B681CEA54E1F1445E2EE23C8B5C34B9418B5DBA0C82271A3
      8715D1712A74036EB4E250F8FCC9B526736487B2215B52CBAE8A2631124CD50B
      CBA8ECBFA08C32E3D4760048165AF285F8C7B88A9FA2C8A0F61CC1DE3EEC7F2E
      2C1C9869FA62475E28B358C6894E02847FA4F70004264E31B18831C10112A68D
      666BD0A138ECB298C22ECEE0B0F30B2F99105B4002A0561F87F9698AFF85509F
      AA54DBE727830615150AC300D795B9231F8559157DB3C378A50EA6F91F658F24
      EA7555903EEEA5F36059FD05F9A327269B9BD4D78E8994EEA95C78CE317C4A4D
      22AEE1B1FABB3A7A755C847BF660B4A27DD75A21CF64B67A203F3A2A7FD96E50
      04A044F07CA5178DD3E3AF74829ECE6216E2D4DB36CF4C55EAEE9E352D49101E
      9ACD111DA13826120B6A857F6573B326C5E1C7DF23BD1FCBB145E488C2472206
      2F91B9CAB78BC0D83B3789513278397DBF4AFAE5F400616D5B50C8854F88045E
      DC0EDA76F7BBBD7F4FE21D1AD594A68AD3D76DBED34D376DC22BDC048DE55173
      4B765BE697BD9244CD11CB82A2BADD1F037815A87B0AB670B7C7304EB0008483
      BED8910D9A708D5F9D8F13B36AFC9FDF4D53A71A88FFA1926A073BF087A3D7C7
      6F9011B339FF3BC59BE941C172B8D0E8E16C6C9DE016D7EA634DE20DD298D6A0
      03508A78DE458123B82553648CD85C0F795C6A99E3E34FCAD3D41512B84BA676
      A258679BC8AFFADC886387D9616200E48DC7EAD7D1399007D6EBD1A91ACD917C
      52E7E6C684BB8D4160728CD16C9E413593416DAD01ADCE3EA1A1BB657FD028DE
      F3E6A492A27855EE8AC4B4CE4CD6002C942A5A198D09C38B6980F02861C0739C
      32910A0D73EA830617B5AF11D68E862BBD44A5F3BF8AAC3A450D30C9E2A611A4
      DC79A136491ABE70674B9B51D6E8E98D988A5E4A1F72AECF478FC82C26045D0D
      4EF00C75721CB6289B0D153F4B0D979B87F75BF3FCFCCB2623036C2C59F8928E
      218B2DD3976D315AE0C20E9E6AE0CF4452047140252F96093FC8EC21A160A464
      56E646DD04A80E8F1332356E5021C9240404C4D86956834EB341D50CE331772C
      2F2C40BA3765EC853B39822851BAAD6D16692BC3659C1442B09C448DD6C79D66
      07FFCF4B743A97200F79BDC48869C3D2686E9F286F1E847E6222B7B13E416E70
      F32C5F5DDE982464989DAC0380CA73A21144B923B7BFB0F5833B0CC8F7420865
      E45ED03667F10C0D818A964C8CF2C181B04036B7B88C65903AA56A5B727619EF
      C3ED1081D3C2EFCA56A744CF1A8625537D7A87E3FE60B799802912DCD0694AB4
      63D422116DA6627536F8D45773C371B5202A1833A9BE4233DE2B8B63696DCCD6
      3F5AE301FA8F90D1EE13A38E323A559F13C44F2A794102D9E16E185FA1396CAA
      76B72AA2C75B15454BC58111F633492A3EE4A6F061B3D94760888869EBCEA370
      A520E7100E037FA025A6288E4049CB4AAA91726FDA83C3CDA22AB8C3EBFEE7D9
      47477FB27D242131A22797EB4A392C0EEE30E9159D16C3A10B2BB0D0C9F2D651
      971408AB46B3DFE5918938C46A10066CD926C4276BC1E36780FF64157E5FDB29
      751723830F55E774D0232DDDB91C740595017F1B01110ACF02B94863ED305469
      B4B49BA3E3F1981A3C29098372310DC32EB85F23274068E923E4C89C75E4BD83
      CBEB5002408979A5605F714A0E02496CC1271BB5391E5BC5D4365C5C81123F74
      0DA693451C364F30A8D58283789522CC9A2F50D3266298D36276565FDF02205E
      4EFBA36A05E981FA4C076305A9021E9D95266829FA620769A827244DC1B90BE0
      23C44F0054444825DF1A757F7C730F9C65C3F19FEF3BBDFA2258950D57D6DD11
      F94245022841A4003BE3F84A9466BACB935BE797A3677A321CC7F11851CD7FA2
      848303B7D481078DB46828EAB16E93175F63AEF81E7F9011E86072A13346BE61
      0969DEDD1794E7C31DA4E7375B173B3FFFDECE1DCFB3E75F1FAAF90C87E0CD17
      6EBB5CD64BC35FE8E914CDC750D3E2FA12AFBFA86EFBDC56FAF701F2A65A9245
      2EB10873EB8539C1DBABD5EC148128D939A962D9F2E7EC32958B334BA3D41F0D
      2EBE869FFEBE87CA69A32E70FDCF83277AE87DB06FB59AD8069A74A43F9C8F5C
      87C059EA9FFF972D8F6B62634EB031A49777B1389EE180B2B2BD3CF9078454AB
      7BFA713388D48D38226AD1AF8811AC9C979F06ABB0AA8EFADD568D6BC5290624
      59114264EFA2C73F0FCEDBF43E5C5AD5C13D40CB0724A74AD41339D5510C5803
      347A59E92059CE273351670B46AAC29DC02D9C712BEFD5044102ECE3F757187C
      BD57CD96EBF30DD3784F1BFCF84E7599DEFC7F72F0EDBDD2017FE09DED91207F
      D9A78F96CCE3CAD311C28054FC5BD8D90B1D44DF30B6EF6492C42997E7117700
      152E4B0095FF5A3C0CAD22B46D962194B48291613804852BF01DDCBA6F0E2D8E
      C2D7068F363B4554077FF0D1FF15E7F4CC059AAAC1DA43C8F7C16F746E8108D9
      A66DDEFCCC8D4E1EFA33EDA82AB6F4FD439F4D8CA794DADAD307BF7162B67BA0
      DC3FFCDFA5D709D2A67B2F9927FCC0A48B97FBDF9CD0BBBF7FEDB4D2B36BEA7F
      1CF2FF9D3EC1B35EDA67ED34B1EA0B3EFE9926DA5E6B97E8C9E2AFCBC91C1DAA
      BA55799FB6AA30E9C0A312135D77A6EAD44CD4B13A3E3C7E5320E50F0F8E0F8E
      DE1EBE752409FAE1E8F521C62F8562B3DF7D2A995D166D9E990A2DF099C9A4C6
      41E82C282E4C7D151393C62140DED24B85B2201A25F8AC4DD1CED155AD6D4F90
      8019823CE2D895D87529045EB6D10854FA9A1460148465A218AC104C68F4646A
      AE0462357D4B96DF9D5AEECC2D4054316DEA834EB29D5E400249604546AC8E5A
      F5F02BF95F73EDBF794C5EFDFC138E699196198F7F697FEA4BB0848C02EE4373
      7470F4FAE0ED6BE751D057EBEB9EAFFBEC5F7DCB797F6AEF9DB20F9B41DEB9F6
      D58BC2727EA1120995D0F65149A6284D8FCCDC32A040618C27CAC6A24F4C9148
      3A2D6E281B93AF8A92ACCB936147157FDE6538308548726235B14464F4CA1828
      44C16B127CBDA7CB231D51F2E32A0E223C861D1F886AF48A254F292B22C79A2A
      D4A8D7247A39B459C886B055EC38AC704E12955ABE2408349A69F0B97087A95B
      68EFEB2FEAF4FC9272D1FDD32E72D1B65087492BB911C04205BBB8EB5B795C59
      C987FA1FD8EEBFAE6AF4D5CF08CF493F1C62BE6B8E9A17779BA0FE196E82D576
      7B5AF41CD986F2EFFD77457B3AC0EE2BDFD9508AF77EF7BDD229BA7ED84794CF
      BAC783C08A0A2D92B5B8A7B0C22595700050E034B799AF209AA52A0CAE417121
      E75D0A5D58E74AC2FD1B96F783EA6BDB4F7AAFF43504E33B351AD25BE087F74A
      4F708FE4CBEFD4248E89AFF6EF6A94E4F8CE6448CAACFA9753745ADEDF5E847B
      5525A92A2CCD12BDBCFDEAD035519C14F7118D097D0A1AF9C729FE47ACC6B32F
      02F6E99E811FDA85943F829FA077ECA1DA651694649D1813A133224396B1234C
      8B6B3F6D2D2C69E3591D8C3B9FC8F30F76B7EFAFFF32FBFED54FAFC5A479F385
      495DFC674F1D50CCA6DA6A79780D0BC213EE23A767765B97171BCFEC8254881C
      548AC46B880FE08789D5DB2D000FAA52CA898DC7A0A8ADE2A1EC99C1C8126CB2
      BC1BAE1BF3F6EDC336E10E761F05CF4ACD5A30848C2C39CA26A1DF2E233165B8
      1D6983A24F84B62997EA0EFAA29487AD8FE94EC15AD2B942E306B87778031433
      9037CE6166C9295C5C8E3A156ED97C59B941BB242A87FD7F489AD776FDFE26F3
      FDA31F3C1E9F82C5AC30ADE06C023E6149ED760ACDC2523FF03C4FCA4D7620F6
      2843BDE3F145B3F776ABC12856679785E89C82FD668338B7126CB796F52E33E7
      D3FF79783E6C7C1E9EB79FE091E0FC198F89E9A7B4FD019028F33F3B05EECFAA
      CFED4633B4256169B6E3A3E59AD847A3866EF787FEF3F2B242DBCD88C1A265C8
      84E90E9EE0CA347B44D2CE0ED55DF2A61A6974F83E8CE62CBABE94F3D965C707
      97FF2806C74EEFE064F1DB9C9E62276C850DAE2B28451041DAE1A92854B27DAF
      CAC2C01B330FBC279102C2FEDF26092EC0510220035048A0D98748BB1E35C4A8
      3320D235AA36B25813D5D36BA5292EF00D8CC6E312C528E32A2850B943F068BD
      8C7709618054111B4A48C12CF0D7F5AFD1943F6E8ADDDED9B0D16B8E90C32BED
      8E420FEDF468CE0C9222B6A26047C9C5B56CFD2416EDC0756CA8C7CB515B3625
      360BC90902FF1D99384FC33595D7D2C91FA299A1FA1BE191A4C68DA8087637EB
      FFFDD799F56F5F152C3E15D351A236BB9A8E1072A4DBEEF315900D4A2D7F698D
      5C067B7DD0C867B73B4473B83C4580B7753EFCE7787CD51D227663452E4C4526
      8C156CD7780CA497A5EBDE6C87280A8270AF800AC7DA15785F687B4CAB0D12E8
      FB34BDD3190AFEA23324A501A4C66EF325C9DA49125F1B4E94A275397957C2CE
      875917AD039D0FEDD7306CF735BAFD4EC9831EDEE37187E56ED153340F43D589
      F2C593C512A955F88637C08159CA933F2E98E816C1ECA18D2BAE42E716510CC2
      EF07B7BBBA6E772EB8AA8B81F57D17DCE9E8CFFFA2A36F9BF15834B96491E244
      2D8C1FE48B9D1A4F4B9F4445049C167200FEC729127ED3E0D62D89C422E8E96F
      0FE84CC7E3F356A7F58D60F5631F0803F1CC64C0C5F443BDE6FE78E27E711216
      FCCFA376B3A4D775541608B036AF7A7D8096E1C214F0458CD0BCEAB11EB32550
      CCE960519BD669C0E740349C6628B48BA7CCCED1BCEAB96D12E5376CA70FB495
      1B8DC79FCFA8F7D11092C9BD2BBDC4399EFE00947E07E7985B276717EF544B27
      FA46470C15D9C177E0A7A35912E7DE7B83CF587E48C8DFA9D54B8A8A3918E320
      5A712B62201BBB9BF6057BD633A131CD2CD3DE35CDFB1E1AE7831DDEE5CC64E7
      3A9AE57A666AAA9B5E98DBAC1506CB739D027F99D5609E44DDE832B9CCB3CB69
      3F5E99A4992CE2E4834E057887AFE16A98A41B9D98343BC983D06FE9C5B246AD
      59D26ED4B95DA2B63200457A3795BD68DEE82044D08C9DD06EFA09F1F46698B5
      F2E4C68CA4DEEF0E63F50EAF7AF7ED888069CDED48DC16F1FC08D03CDB89E9A8
      A6CE8FABBF38AEA9F357D55FBC72632B8C7D30F210CB36CA360BFECCD044B36C
      4E0B184C5500BDC41C5CF44F2DED0976391F5DF06F0D7442041E96ED1F435FF3
      EEA7BB3C5CD862210394C6A992E2CF6CBDF343F1CC9A6A2E16313A66E70B92DB
      35AA269C1BCDDD3AED0F039D994F4B296DADFCAE8DE2B595D1CB38B2137365EB
      E2A9713B2888F341EFD2E9399DFEE9B1CDCC69E5E1AAA88CEE4AC03043041570
      E0A827DC0E53B51293C51A9EEA8C16F9F1ED33C8F9E132670E93AB51E757E10E
      17E84C853ED98F510A6F0DA3C0B55E988C952B890D110196845B76C07C734BF4
      89B5B54995426337CF5B1FC6E376673852CB38A5853AD8611834CA914C02D501
      953D5729A9B895E170C61857BC6DFFA94230F4C87E9E89E3DB20AC031804E8BC
      179C7A548E2D843634814AEF268F1A73604A3B79F0968D5A9E5AB12C2B7D4F2C
      2A389D6BE4862A1F4A011D5BD829C301A1B597EFEE84886A5EB4370226B6B386
      444E1A0333D5E88157E3196C3A43EC24735481D795889A5CEFF91BA0C2487EEA
      3C64872191E1C946054F859F53AE0C7EBAF52862BB4BB27085AA77ACE596D04A
      053CCF3DCF9C9E269E77839B08FB0A511C561488E438E693379DEDEA7D21A42A
      A2C3C4375653BD0FED518D024835199A0248DB8EB9BB8060A79C5C74F6CCA901
      CC67C8078BA77B31BC0EA217A597C1E9CD9D82CA5442456DD75A1F060CD5BC0A
      D200D79A88186CD76994C3EF344EF1F85F4177FFADC8ED235419609B6CA113D1
      57101198B217FB0823AA200A760F23CCFEBA282C11DAB0B63BEB5F9E35CEFA97
      A79546B07142241228735D5B3A04E7A1089A4A10BD0A3123C9842CB631CECE32
      F00A322F20B699E28916EDCACCB485184B5747899D839CF8AB6C2D8F9819F698
      DA441733B2C41F10F2A6E8DB20F28A28842B526B2303F3ED10F2B727F40A9072
      06581770575F9DAC2D3B05AC1F54B7ACE64860FF9E07DE352057C437897DB325
      BFCEE31F155B65BB4922DE417610C161E6F1EA723A553747073FB9E2E65FBD7A
      8E58AA74751C8C4EE9BAF16DF3634F90E8E6362BC59A2729F50C3D211488EA82
      051D3A4B8401173676F4A50838A752A22A519E105920484158E478921A18F2C8
      872D13330D6E1B693E051B90F6FD86F4C5416B4A933A46FCFB497C8386E655E0
      1D652389421F6F69117D6249EFA851BED82B2384C74543DE174DDF8F23D58D7C
      73FBA2E061B061AC8951C43DA217936096C3A0D3A97A2100A556BC980411773C
      E6EFEF687D5BA434FB4CA58307A352EE6CC19685B05B4E705EBA7471440C493B
      7813D85D2420BA6D15C6F175BE14AF1EF2C6F90E3D87A3F5C0C5FF47B7AFCE2F
      D4C5D5B0235D40D4CD9BA303C756098532D81AA519CD69849BA3835707474FFE
      0EF13C8AD6677990E944DDBC39387CBBC3086726A3E05873D00C215FBC791478
      048065AC26206488CD988594F7D588E83E46432094DAC3018B80ECA782E841EF
      72177FD5428F38D7758A262C0DCB5941C462CEBAFB0D144281E87E4752D5DEF0
      660A545689C40685E18C1856F8EF29E8A8EE20A19C0CA5E9E30D256B38BC5617
      674EF43C3AF1E6285BDF64DFD24CAB676EB3049C18147DB8794BBFBBF9499D34
      8F39BBFF9731F0BC3A7CFD1C126178FA85B201AA4E0146E9B06BFBED56B20FD2
      50AEA6DCC7B9EC5D02FB097149CB4C7008152111EACD35961DFA8BC175DC0ACE
      4439770CD8015F53EAB161FFAC6DFBE3C97BEA075ED579A36CA5D69BAB015F5D
      FEB73AD1DE350E21887D86E7C23A26BCE10C8424DB041C6138B2949443C109D1
      C1399B7C876F376F38BB3C0B8DFE410F47E21FF1EC9F0B73F2A2DF52E831973C
      9CFFFDF6338F0A54786338ECB016B99CA499F62C4D7816ABF6E5E5A046C99B9A
      1A0D3A1DE7C18ABDE202A022E44194D7E525737EFE4F95E7E30C5E5D129326EC
      6CF13688288032F5B349814EAE10D7393BB847BC3934EC5D0CB7301E7A30C788
      818C7FEFEE6A49B1EEAB2FA8C9626F454EF7F6FA396908FFAF73A50FC9698204
      B31C2BBD734ADEA0E82D09BC4C7D020BC708919682EF2F3309DA8C866A61A2DC
      BDE92E863FDE1ADE620F4F7FEDB70B7C47E4ABDEA7E1A8D11B8E4ECB7CB3F398
      88FF715C526AF932A317EAAA7D8A94B62DB945CC8404271A77D0E1E2BE8F98A0
      285CE3EF54BC76FCF3EB4DE93530D2AFC2F27984689CBA0459972F96FECE62ED
      986B6D1FF0923FF5D5FF6B7D65E7415EDD91733674B211A66913D75D6ED45560
      568FBE03E57EF579BF1E32912C1E97096BA99D2736786EE431613041AF03299B
      B05D271FB7F1CA0F44C39149450FAC70903D342DB2A551DC5CE9A4B9CC136F4E
      772C9B27713E93373D00AA1BFCAE49E6E55236C55F60048D24F6F97548DCA124
      47E621B4B03A0CCD0DFA913C34A7458C3A578F230C5EC1DAC9828A2200531DA0
      0B8B0A912646668F86A3942E913673764B8322C92E610D95E801D5208AAF6D93
      608CE09A0569B6559C7487EB81BA0F3D01F2C97BBC9C851153EE363C13A2A950
      578387A64A5161F6C4D92EC2D8359BF39415E158B53C8D069233FA420D3F0E3B
      6AC92E6A90CA79051A8C5F4283CC98141CDA1454A6F89759EEC76FB76EBAC814
      81633178AE923968D8EBEF3C1E55AB5C5CBDBB5F7A4566853C3039E2BC8EEE6F
      F6F3BD6F76399DA2B6AA8D115D1FFDD3E1BD8FB6E00B75DEEAF41BCD56A7EF3E
      C27175841AD97F76141DF9A9A797C6FDE1AF36F556859178D3F4761F81FCC120
      F54C188A2B255D966179ED76627F92E4C117B233885EAC84B0C591B0566EB25B
      FC7CF0E6C8FD657E9497915A964FEC8249CE2E7D4F850AE4BAECC222471467E4
      42D8E7FFACEAFFA13EE8540DBD3C5CF291DD6100F21AB859A41DE14DAD1C84A1
      558546AFA9BE4612A289B46A5A1682792632A9A5933B3DEB13FB9EFA4FD5D7DE
      75BD1BB9BBC1E404B75A97EA57C222FF876AC571E223102BFE0066230DC55A1F
      5FA6EA2648D1272CD46B445CE8AED4947D126D1715C491B474DE7A48ABDFAA77
      FCD7D6798B6A653BE7E7CED6D596F8E05A3B490C385EBA3DEE8BC5F6BD1FA4B8
      0DFBAAAE528B5F416430C5AAC56C15A5BBABE3C977A8631B3810BAB101918196
      6A99A83274487DB8EFB8645F3708EF7FECDEE1E151FDEDE9290ADAD1EC937B95
      1545D5F70D58F08C5348545B2162F99AD012F8E0EDD137C8D46036C6C975AACC
      AD26AB1267D572FCDD3FD58DBEC045F09026B13585A383C36D2BE1F8F5F6721F
      FFC4CBDD450730A4B61F9A3013DB571AC06F122A55BA3A1F59331449ABD45091
      F0C46C7E4216B0A66240585601756482F94986E7C4482C58420AC9BA086E4AA6
      116626F0DE09F247085F6FB0766ABB6C34D9A9462B6FC27460898BA5DDDAFEEF
      B7AA5C6FF4EB2D5B6301CE1460C43750179CFA81B711270BBB787AA51357F7FB
      F80DF4EC806E3E771696CE7CEAE2D3F939BA3D323779D189D152032183D04A82
      85398B43FF2A88C1D7D0A8FE6EE3878B3882D870ED0DF7C3D1F18F907844697A
      295BCC7124F18D9154A6667EB017606DFF8AD3F05F05300D6F60EF543DFAFF5E
      1FFEFCA33373DAF18F50E7C3610737FFC7D72CC9EE48C72795C1C4756B8708AA
      493FE24E032E0EFE426431F7748CB9EDAF5C9A3852AF8E2741F6A4D3F2E2681A
      224294663ACB532C32C2BEC529058F7B46AE5F416859E46D9F742264CCF5CF51
      C13DD07EC0532996838A4E191545B4AC5C1A5209893F0041759CD0254C107B65
      0076F8C0B2186D11C2955EA705E116E19FB9093961BCDDA631A552CB095EF4C6
      8458FE6259CA7A336974B8850C64522E8F3A4133513B5BD71B8567EAE8E0A783
      9F5E39DE99AF4C6FB49AC0E109A573ED0782D224F61465D483A99EEAA979CA41
      A90D55056CA21684ECC688B23395E639770E38EF68A46F82193B6A59620C12ED
      4F39C517DBCDDE5FE074691501E1C36D126096D8D6351C49E246C93C6BF9434D
      D6B128930BB2D484D347EBB4A7080F1C51B4D1B680051F8901E9112B5C757A4C
      878F32AF16B9424007C15BB8ABD3C2C523A79442DADF620F79C4531970553485
      03A0FD61D698C72AFEA2D6FA8B5AE984D6424F60CAD9FEA044BC4CF44CCE23BD
      29D6A4C22340A5F9BB8664DEFC5CC86013237FCB68766AA589541031698A4EF0
      1283DBC50506CD3040D786A7D7056CADF707ED210627A6878AC47BF40D789415
      DC8CD6AA33EC71875C34764577EAC00B8881D3DCF2BFF72DAD32DFDFA29F8B35
      5889E73593BEBBA5E98A8834EE7A251F40DE48AA113F9DACC5995A003C36219E
      42FA034195D914E0B0A3FD89F4D22A09B2CC44F87AC11B2EC6A46DA051F42385
      1D6D3D1B4FE0C093B5FAA5D93A50A73A08A577B40FE0B85A180D7522CD533934
      6CD0A84C6CF86016D9F6D885A14E9F0E4A7D4851174CF3F1B6779F7BA790816F
      9DBB87366CBB0C55B8A58A67A4A5D787AD2449647CB73EAC96F386EA9BC8FED8
      982D4C585E15EE61B2A56F10FEA544DB03C515DF980018BA3786B4BDA82BC611
      B305F2F4B44C993F07BD1386C55BD0667DB348C56946306549918143DC50F39F
      C27FE38E52744C405508CCA89E96E7CE6D1A43931589A0BBD3A1F32A8046AC40
      D9A203AD21C066878B1727DDB6DBE88519F2E0F0653BF9CAF80575D73C98CD21
      456F0491CECEB7FBA6D409BADBD3D7C64E68A913BDC019AC89DC2A925629CCFA
      759C57FA25E3A7A25D728D5F81701F90160C5F4DAE557704C07EE538498DD8E6
      05944E983671828A3E689449993B9A18201E69718A2A95FB5AF93D14E4F8CCAA
      F6E1980C02305393AD093B43226A73AA01B4CF946210DCA7CBDC6685A568CB7D
      2AA2907C13EECC9747F009A022E284AF38C177B83AC7A6BEB724069BABA5D327
      F275920BC35C1E995BB45AA4259A6B48F7AD23E114A9D3DF0F5070B4260E8FDF
      16F9E95167D80A83050C865E0C57A5A1FAC88FAA732E2765DF849C4A2D357558
      7550C957DD3F67DB0C41879695C90468E1A803ECEAC44C1393CE995CAFE8DD46
      73A913D19E33B6E5F83572376727A7BD6A2B2FA49BEAC04753D9A91ACE8D718E
      A6BC7E650D25501C8DC79FAF9A83F198590290A9881A3DCD98CC3FD559A8CC4B
      708DA84A200BBEE8F9EAFCE8D7F6D1C2EBEB736BA13BFEF0EE77E5F157E57E62
      976DFB9292E95A2DE288CA0174A8CC744A0CEF53B2A314B8FCE7719E10647561
      D45EA5FBFB7E4DE91091318A82E276489B4E48CC3BCDE681B3370924160561CB
      4FC4495AA3268D45CC1672BF3013ABA654F152D001D99C9C3A72EEA835EE1660
      7F5BDCC6307D924C96732304517492AC512607AF524FA747A59282BDCDB560F2
      9E64220C4F8FF0AC03736BBE23FC2D26E276EBD6ED07DCD9D963391C03130668
      FE033B8611E7E94176FBA0592A13AD5559B2690103C0B197CB24D6D21B5ACA2F
      2A1D7F44DDA6718E0EAD6CF38B915B749D050D34F742B6067D498A5CCE9080C0
      078F7ECF2E8C57724E4726CD10EA3AA20604C54F87AAC3E88D875EFDEB5FC602
      882E2D4E422B4FB378711044816D7EC0F9013F481333D30924C7646DD793C5B3
      B5A4A9A30099327611B2D8AE15EC4A5AADC79F139807DDC502F7892D8462922F
      532E41BB9373DDDEF5E27C4BDC8B0A81429456BEE7E0E002F1911B73A0CE821B
      B824E8071EFC616A6C8C61657E7C5D9FA02378996BE2EB03D34A0AD40A7FEC6E
      8BDB87B6F71481C9FA08054643936D119C6DBDC965B479F0708F2133A8628522
      D7F1544DC0B9C1E1379BB6092A0115DA4A9CFF1C77DD2CC0E120DBFF1A3BF546
      9D9D086258D04D98157F2D430B40928747876A114439F2BE5CB44BA5C607AA19
      82D57B36B7601A18A729848974644FE2156A1AA83A8D649D9D788000FA8CED5A
      F643D20CE906209BFD9B4088C76111A0BC8DAE151C67A86A4E95AA3CCA009CA2
      98A2543EDB722D3B08C5F46296A8FEE3B768984F5284D5905BC792E7CB07AF1A
      A28A69F99550E791378700A1B9690F06CDFD7B23193CEAFF1B447C4E41DC4155
      D9F154A5062C28E9E32FCF47821074D8803DB106EC69A84199CBCD4A01910828
      30F1B091CE60B92498C5A4BC32C31DAD8807D94BF22C88D66ACF62EA10EE5A2C
      03CED3ECDBB657B6ACAE62AAD794260B5EACFFC2C6F6796EDE3C0E00922B49CF
      031F5D63A9FB15F936914198F8061EABD4594A832DDA784F2FB9909D4AB97816
      18FD407571EFBD24A7047316432E48A4049FA196211303CF4A6486B99DEB3CC5
      48EF25670A2B557CE5058E621E5188ECC650A4214D81C3E66ACCBB7DB81E9207
      9C433DE5FA02DB9FA6A7974BFC6FEB4E3FB6CD7D421D1BB6C7B245A1ECC186C2
      ECA3A574815E36D4DE3507DC0D6E080263E2EED8F2DB85A6D2F445A1CA828474
      42BDA4D2131A3DC9F4CEC278A2C31A9DE23A535968AABD2CF2EAA954F96F0446
      0A030FDB5FC8528EA71F946D3A08DF176D9E09C4748204F5E9D26B1CD5BF520D
      218EB05B68A907D0070E08CA0CB9D72D39094393A9BD6EBF3DDCB7CF778B8F90
      1D46701D8069F81F7B00A6ED935DC63F23A7B4DB3842CEA4F63E5E347BFC68CA
      8AD8DFDBC3B5F77138ECED3654D3FFB7A6928061A497EA82FAD2EF5D14C3E297
      45FD27FEAAF686A38BF68ECB282D9FB9E931113CD060F26BDB047A0F7D8F9F66
      2479A47448E53C5EB5EFF4DEF07434B87FA887AEBEE0B352B5D7FFD8BDD857CD
      285EE8F01B869D24EB396AB2F1FD71FED3F1D1F17F82FB4C001AE81981433C59
      67A63E8D933AFE4135C8F2590E7AD00BE5D11204DA1E678B24D07127CEF1F597
      210AD7C023CE698EABECC1DFDE572D30D73FFC4EDD29FBE6368A25A16C9F083C
      D549989B6512A0296CB04CEB8579473109AE7C5906126A8DCA30B8C0C7AB1F26
      748A268CA2E40E20F8B194FF3F716FDBDC3692640BFF155CCEBD8FA9698A965F
      DAEE76CCF40D592FB6B625CB63C99ED9ED766C802448610C026C00B4ACD9D8FD
      ED37CEC9CCAA02489114A5EE673FECB8291255A8D7CC93274F0E8AD0779427E7
      A3354D5746CE91AB3E2C33295617DEDC8EC951527DA98B593F3A286642B4B94A
      2A8B23AAE3B0B2B92A49A65558428DF6142F9E3BDC36653CA1D00B06D6AE1EDA
      234AEA01011A78E9640D8A0718851208DAA1D0710AC2DD7238E3F9B88E798FB8
      CA5C7639F8835D93E115FF61A0C48A9894898B0681B87571AAD66A0C8C48AD29
      843C514E260704CF305F314D2BB2A9B45627AEAFAA2EE743C64EE1BE0151A51D
      41B62DFD973E32359459C5F140C3163FC06FB457FA9E840C53FAF692BA40B1B1
      513203FF0995EE1C8B8D3ED590000CFC2A1133D29D38CF25FB3DCB8274FCAF89
      64A0CA2D5C94E984194224A9D70BC9578B8E7F92C503E0A0F499A9109694D3A8
      13B4DE798562F0EACDD0F51313A672C34427EE6B9CA523C01E7ACBDA7DDD8B0E
      7E16491C0137EAA2C8B40A214C5A7556E2AA2A86A94CD220A9AF31D5CA05809D
      42F3D807E7E465CB04EBA4E15BCBD891B51C4F897B44FB52C4168758AFC5472B
      606C3BB37BC494090701CB377052E04EF25C9A1CF0C4BE08C57AD817B6E66C96
      C4943282952834B9B362F4DA6584A463C0995835B302388338BF1986A12EEC50
      6249D8D2F54A209C3A2D61537AC4DB9D8263E7D934FE4E236FE5D49F905C2934
      2D2E9F14078CEE7C059D7008AAD50DA350629130DDBEC639842CB570D008B302
      42AF7824D2A16F3840089BE4373AE7F228390F0CBAF28E785000D79F33BBB6A1
      75C1733AD56837010E0456E923E605E322B936E7D2B3ED55E490C1E99AAB2396
      DDF057D22627FC9AF303F53CDBF10378FB88DCC94EE665224E4BC613729896C3
      B97835BDA8C00460CE5E2738BB4731AF1BF6639E6344B8EE0119A8AF9B66D9AE
      39B3FE9CDAFCB03E88892346FB13ECC83AA24AE60A640733A2F0DAA978C2AB16
      C9C73ACDD27FD96EBEFDA99A2A14ADC38CCC169FCDCB59219A3DE68F37A63FAD
      186613676058CCCB184268D121B00084BC01B128A521C6C414753A8C92FC6B5A
      1639154324783964F3CD47D3452B62A05529EE8F307423AB6298F4C06044740F
      135C27659630BE2FE53EC7E354D48498BA2F7B1BFDB17DDC705EC5E7EB29644B
      2B622EB4A72C9DA65205A7276E0D2D017C9749352A28C245E5CF4E7A3AA2C206
      00639025D345CFFF765B32C01B91DAF65E2090B6ACFB62286EB9938EC4B94196
      2218D38B4645E26888C4551AE026A4481BF35CC1DB0EA619E719003DCDAB33A4
      B91376F9884876D9C1231AF03A407A9C10790C8661182D5FEC863F6FBA497FD2
      EF4567E74F777AD6A6746E57126EA7C5C8AD68020477B373E30C29E649F955B1
      286116859807EF678AEB2834E162FCBE511DEE952739073281800FB8840283C5
      D9CDBF9CD14ADB12ABCAD935EEC5109449258D28DC242896880719688347C92A
      250480215E8AA75C63DB91D52778FAC80C2F6D4E1977DCA301F662000324EF80
      BB5C07FB2ACE2A2AFFA4F93829290068F839B4031D3E23B513C546CC8BE8B779
      CC5D1257D5BC6448C0D0A960BC2D614ABE2AE6B59EDB5CDF1647B6090BA3BE6C
      57AF7C7D390D43FB90355790DC28A1012B867075555C5775319BC9B596DF44C9
      37F534960E6D685EE03CE1740354A9EA640A45333F30D2CF475594259378083B
      7794308BDC0129A52B51865458D4C093F350B801FA1E447A52C1899A4315C407
      08B420BE5E8C5DCCA9E994C85834ECEB00333FF8F9E9FAF40C77BA80EB249D74
      17EC35596F60D092AC20317EE881E07EB563A602A5E806EA9BD8735C7E7E3FCA
      3E8C2B05994BA5A65E6F8EA99EE230D77DDE3DF1EC259A80690DDAAA1C688A18
      15E3E8C483966D2C56415840B2D5CE1AF35D49B1B04B88DFD09626DC81F968B1
      14E03EECD65771BE9B8E12E684B3A191A1BD3D17BD11767D3AC52D5DB5E0B3CC
      BFECAB3B44E6C61A11DB85F73F52D0AC2E9378BAD2EF6F90A00CB5B4C30C3F86
      00600A35487297AC157599621C709332960D228A4BBFCD93689E97090027CE50
      9AEFF210D2CC34FF904A9F328C732CBE410823380AA11E557E54B821AB5B8EA9
      2A69761EE6C80D8A3D715B8F9BB59A2EC1B2819FD1446B1BA6AAEE64FA6402D9
      D131D68ED21EF16E811CF29B5F641F733CD4273F0902BD8E961962CA8E69C8DD
      2B0FA345DD3CF81D0FCDDE14BCEB7C973A3E524E57583B0E18F0D514B6837161
      D6E895A74DCA21052F48DC11060481F92F203A88054AEEC07DB85F50EB97B96A
      0150BADF8206C4456E0CAB1B3089BFE5A6F2223E0EAB2056D1DEDE37FE1F7864
      B820F114F9C47BBD95776DC56DD504AF46A7EE606336F1C6554BE5508A63882F
      BF1C5A94F1F1505F6F010F354778E5161585B3E064DBFC7D2CD9CE015F451999
      4ADA62E5BA5B32F5849021F88F0146C173E0E332A61ABC85308A1FA8DF56E6F7
      6D4CF2E35D5FE38478966C16D8580EDCA24FA774C2920EE09A976C5F30C4BB72
      FD115E39029D89C0108888AED93B98DE3854EC7DCFB0875F8BA7BBDECBD137F4
      D48D1173AAA341F12D9C08F67956165729A2FF0ADB86748FBB41C43CE5ABD03B
      854B467088BF3592B9FAAC303A59166F41D679E351892B5FA1D63E836B044A95
      2E9BB55A1B609D3A07DC63E57E7E85873AAF0B84B155E37034DA1E3EE730451D
      6A635BAF3B5E46501612F981240FCB4DEB725B639EA9371A0910BF04290C830C
      C65351DE6C3E94E7E6FFCB98EA36DB679A4D3CDA3DCF5BC4C7D6E8BD4E2473D4
      C7951DA0604C2B3C500D0FB0AAB29BE6A8F5A2F36C74169795FC07C0AC1A720D
      C48DF8D1BA6135DB48E5F277718FF4A37F2FE67E18018051FA142EC01776CB55
      61B7A8AE1FE0BB31770EE0884816F8309B8364835714D717C713671EC0D28A2A
      6C4BB62FC10815F2101FCF39B97CA28618421649921BB604647806B5C094442E
      200882EFD350C65725758A3AF555EDC319CE0D11A1F5E86D710D784F6EEC6B5C
      3E331E6740178A317A32F34430A44E5392BA4E6B7C500200C10EF57495EA3A85
      1406D893EC1D65AC71C0023E5B22EEBE8477123203E9EC00B385873E175BF89F
      D844887568B96A7C4EBF44F98E30357039A9AB948F6243C7C988330C48465C87
      6D60836E201900039FA7129E123D870A12D065654B6559790417F018CAB22033
      02EC12B9C864400DE0BBC3797869D2ABD1BF81C0E156F6E6B6E493BED4F75154
      EB429143F6CE719759999BF8EC2B2ED1D0E21572055C06839E319A4717671EF2
      D66542EACF201983900BA318594F0E45E369CC9197ED4C2D741A0E536A32CAAA
      AFA22E7E85CEE9137648A99223BC8AEAEB02486B9DE6605C4B191F5CE7962A80
      2381CE3BDCA82C6943E8349B2BAC7B6C657A4262C41A5629BA76A852EE926DF0
      052106F1FD42520873103737AA9FCA5460B0C9C30C9CF1576416587297B37841
      D1615A7B8F25007A51520FFB3D8E20DC329676379F4940FED6E80528A6FCCDDD
      34CD886D036CC6D921DC3AC9E7308D46925D4AC735157F7B1A75039065FEA64C
      47C2C0DB09820C308F6030F006817FA7A74CA94321FD239B38AEEA5EBBF732F2
      3427D8EB3011CE7B076EE30BF5594143F8D4BDE84B92D0E56487B1E6E4FD7466
      0D5FC1B27F544525D878E059B5B70287430C4BA4308C7A10014CEB24901FF7DC
      38615656516CF5C14C64A60751B3B8C41F5D88A8BA812F0EF748D8A70AF0CC73
      F2AFE08295373641BE09DE821C4A748E4FAA5CC3BDE84A387A7C543A15B2214D
      0EDDC30D4992E5635A26AD55E323F6CA12237AA01D8D3090CB0661F33DF24CF6
      C881719C87378A340DE60CE3BF8ADEF9B5211DD4BC6CB33BAB0840A510A42D2F
      C92771A3F3A8869094F4DE89388DE65CA48ABBF6C58D00ED3302F252467053A7
      D053205B346720DB5BFD2CE27D71D68BE620432615897E32364044926952828E
      FA56E2351EE60E0066829D8AFACE90C02257AEA0B2B74E8EDE60D4E333030203
      138497565EB9A243EFD91B52E106586C0C180B804C564C78F908EF14D0DB2B5B
      39552F62545B62C372CDDFDAD75E70DDBAA33FAE9A9722B79BBB8C2D0FA1400E
      53C548C0D2CCD12AD123DC726C7B1A2AC08B0977D7A5360418BB3E2A2D35681D
      1EEECC7E9CCEE29A69732C56294968E33221575319817720E18A19F1A8828D93
      0F574749F228939458E975E53D01B92B7AFFBF5B25815AE7BB62B56424480DA6
      8E3448F2642C3C8A34485910C1F8B48E92B84AC9BB30A2EC4D837FA07144B869
      9E9D4F7C912154BD0F45A45397D8AC0436A3A4253D88E5A207F5051D989510BD
      94403CDD2FD1B8B4B39427AC126519CD10C35803F41B27F2582DA743D37188CE
      A480C54AFF3579F4D59489052F5FF8793F7A2F356508AEE1389282208EB3B279
      1721B01ABD4FE51CE7915BC69347F9A3C3B2987988F89D97B6B85C266DB1B896
      B9328BD96E96905452E6724FE26336C95C7DFE513F954CB91D6AA144339ED175
      8DDCC7F72674C0E5239F426854652DEC6901B307CE3F0800AC20E3CC3872A493
      71BD8BCB69D91B71EBE12AE3D85B4C489EDF84A9C57C5A79CAC25BC5F15133CD
      A48C65704718D5858CDD657D29B4B0981D4702AEEE0658B0896120E82E29F37E
      30FA74AC94E909291BC1E57B828B58D092BD71E82A5BF4E119613153925E4C39
      D6A4D58227EE68C5230099CB331E5506022B0A4DD0B72F0AFEBB0D108A156520
      0AE146031908293E5661C7E6A0C180F7B2AB4AB0413A0CCD1CBC117ABDF9BA37
      51B4972F36D10608B5E1825F7A4100CDCFC0C9838444D1E2C2CC900066C16946
      5678B1F058CE27D128C9EA58E424252D059518BE84EC43FF4341697174AA6CB9
      A23B211DC0D250FD580D6E821EDF31CB2E78D5656976E3E2E58B7579769062BF
      25D1AE35C42A9C87F01FB676111D0DBF5449194B721B167E9ACF792334F667D0
      C7967A118CFF8805F4DC72554B1F172B0BB4E9386FBE6C2E8F2E9EBD8ACE8AB2
      C45133720BA38B9D47702D3AB0A0F8CDCAE84290192A49C9B09EEA56D2249A8B
      BAAEB91DCD9D0C491ACDC0B767EDB0D04F63E5DD39CF511598D6AC19D51F93D0
      9428FAF43481C8AF243F626E210571F7DD3AA99E7163ECF2F0736B0AC4035C0B
      90BA000CD76BADB0E15CE23175C1A1C224DC2DA3737FC8B40E5D4F7A781DEA41
      3F5C0D34BB77A254179079C7CA1DA55F61FE572D3EAF3BF1598E051ACE3470C1
      32A3C7D104EB7A18873A05798F123960838A0890401795C81BBAD3DD85948774
      BAF5A8B61C9547C66FEC63D206653A9A28C56F12CF4C489AA5E1B80A3B5FD3B2
      9EC759C7C5742DC5946B524FED9EA4EF4ADD03A0736C102C4183BD1D44200DDC
      EEA4AC98A44FD295E80D6AC64B478EC4663C94549C9514C19C688A0CB08E2BFA
      C3D730D21F8057703840D03078E95FFE6E2236C28AF570570ACB155772836C76
      A7C55D12AF13DBD5F02B3F9AF214182B2A6E4568C2EDEAA29CC4B9EEBBC8F1FE
      805C14232484B8152288ECE66348193566631D9D9E3AD202B69CABC9B73AC696
      73C4C0141CA55FD3911211CC29ED2E85AC76245E341D2474047435C4D207195C
      E635D7F41BD5FC7030779A87B3A6E82F1DF01654A1D5116073849DB3B9230533
      45AA38C6DEEC4DF48193398E879840B803A229509731708371515E0349D673D4
      E6578B25D1F8AC82970BFB948F44815291324DD9F08B20EC8EF006AC473DB9E0
      470972FB5479C7019F14BA5C6A7BAE1213308904857E59608526A5643AE9F6A4
      E578190F365E50F624751B8EBECD622926CAC7AE7470FCA1E08D77BE36A5EC94
      F1275106DF5B1E2B4857EA7BDBBA984C84F65FC1EAC16FFC9DF2CB779F6191FC
      B2FB39AA6EA60310AEA53A812B8C107A1F6C1937CBC285F325B919145807BED0
      C27778F06E83FC87FCB0022981E695539E5769C402713836255FD555BA5139B0
      98D4527643D430B1B01803C4FA9D25A595841EC495B841849944DD2BD1747653
      20C49C5CC7C17D63C6C2F2C573FB24BF9E675FA2739FAFCC73EAA02E33E4E1AD
      8BEB0CF0639FECDC8BAE8A6C148D4880C772C763BE24009A19A6C764AAA7518C
      2C91DBDD234C009721F323C6FB4826DE00551A07373397925225E3B984A45CE9
      33F16FCC7D122025F91623A065A9109C2A105D14D482411FCC099A3679011575
      599800644C0445B79BA1374951E7F7F8CF0A8097CF2A0A9F9F019898CF481EA3
      796E0B5C41EECD27F3506BA5ABC4951C081F81770A0D7E0373EF40F153CB7A29
      432FB4E9DC4308C4AAB3F3F8F32B5EF27ED8B4506819BDD53406FB8DA3D80C4C
      E2D65EFC5C2AF786C6C5121040B8F57695BA5DA4FDDD65CD4CEEA5CD07F0484D
      2A77A4AE4B5DCAAF883ACE2B672330EB5A329C9989B2308C1836B5A2BDBA8DE0
      5D9A77EC32C0C32CFC40FD8B2987EE792E8A63478B9B063995021106719F1C2E
      EC5B0F750E28268535334E92D100BEAA27C9C3DB77110FC3F2B8E33C70E8DE3D
      78391A54D2E1CD27434C98DD5360639BCD482BA3C80DFE6EC667B80E69AD7917
      23C3116F5302CA168D77B2E1F5074691A1F27468B207A78F3D0D794A72CA99F8
      30FD191E66741C82DCF22662D592970D0C870E8A777730B3F3E91D74CE3E099D
      F4241F21BC8C10003A7A003DAB35FC1A46E1E5F559890A5710169B14778B6B11
      0722B1C548AB15CF57A7AAC02FF2A2C35B78DB9067B83E98AB683A4D46846A9D
      7DB5B9E973568C12BC9FDF262CADB19053B4628C3E92F0005201150DCE0F2FA1
      ACB134497A91F1C1AF7B89BE464E88DC0D817E1FAA71BB44262C09E9B5447D79
      2A2C706FB949DD033CF4641C55F80CD9AE1189C3E3428DD83059A19FA792DCCA
      A0BDA553CAD48A9B29F960C153CC636A30FF87C876F3341087B93843406F66B0
      2DE47D41BD50C9086266A64ACAE123F2650D217D985B971A7F468B96A89B3E56
      C29E83244B13953C95DAD428F7EE6E03ABE8B51BA31882996977A10925DF781C
      8888775CE13C58190E9932DF12243EC33DF962B322A50952B727530145961893
      6C973413E4E38A59583EFAA33D117ADE9CF970FEF4E00AA097231B4D1B825B31
      A44B6D8F55A78505CD742BD2DDE985A686E066C03888B8A628622D39CAA9F801
      4C6C505E140F2F8DCD4AF15932FBAEA1C41FC31647E4B0F16D2DD604C291FA03
      AC6C6E896DC093838C5A8C83CBC231C40D36A61A594679F7F6BE4F1D92F7E4CA
      634E8BA516E362A3B4120EF83BA048170EE519CAE567151B569AC8E08E87609F
      AB80C7858F94291F68B53B3F7CB89D01E21EA7795D16A3F9D0A484BE49564E43
      1053261D6C31BA2B4AABD1A8462F9ACEF5CFD8831679E8398A8E1D01BE2A922F
      FCA829F29638435E07570E791D3442C47DF6175CEB595321E7880002EE369E73
      947D108B9D8420558BF3EA4C2C462F8623968FA566378A7CF8C04DD847731611
      67D88DF3D1AE844324B1425796C32232BF8CCAB4FA42E34D4BABDB31A4F991E1
      887BDC9E2884BD697CA3C2F2486E71D08FC2505EA773310BE1D6F196B989EFEE
      E0ED1B0316D40B573A04FE3CAB7E50727E9D993BB50422623396512AD38D8B4B
      59B69AA7234C0AEBF4E2151D6687AC984DAD14E96753676C8134E05798445F30
      E821372088061B1008967F30038B034DE33049838201FDE8785EE24A0784A42F
      FFA892321BBB14E15FCCE713F16B0B79B3B2BA130A32AAA3EFBDD306E76B58D6
      4AB853FD31D9D88A1B9B4B47CC28C7D92AC5BAC0589B814717754FDE1D9FEF44
      E7A4499C48B851BF7359CCD261D43D3CD93FDDB9437C41CE2A33C50DE0F5A6D5
      ABE8E4DDB950DA4EDE9DEFAFB3B4D0BC6DAFC08312E2609E5CF722C5DE823B56
      0D86463B8B1A5BB4B285931AA4480537B545DC60F8DBEA082E5797D4CF5C297E
      39482708C4DA9158A00163C23AC268966FF0B4BB7B952631DB307732756B158D
      8D248ABA392450F1B7EE4DC5CC537962DCCF1CF6C0720FCF2A388D6389E4B086
      48EA3A6562F2CDA332FC6D424F524F8C2A697643DA4A4BB54D29F5CF85C99343
      83CC6A6DE54813D534895257F3E6E378E08522A83F25D8CB877509088781A824
      6F26472F1AC75A3FB085318B2B5E92DA32818BE9A23C15055DF97B474E09579E
      DEF5CE7F1CCB29249FC3AD33644A98410DBF56DD592F5214A0E701390BB7B4BE
      BA08C2B06C90B363953EB67D969B2943866FB96CC6C57EDBBA19260DFBAC6E96
      178470B2F2E4D9A03F6D75517395077DD9BAF5806626DC7FCEB5687808847EB3
      30C1ABD334D407E22DA0871B2C3764C40A604ECC733E25A71D59121A3C37C953
      0DFE89F08CF85E34BC97DFDB81EAA5384F812BD05AA768F7A698DFE1B8C209EC
      8EFE758714BF1D5CEA624F4A2F6E5D42AA9E3B12BBC129A49A4A51B74C86F312
      991E4EF75193ADDC4918A6E788E08F3FC6C81D53B698EF86B34040168DE7F515
      D205C986AC12E632E42E1FDDF40AB4C546D60DBE53943D659E56143FBF6064E3
      CDD1E7839FEF34CCFB9B0DB34AB60A4401EC49BC403EC08F3CF501560FBBA28F
      318D1F8982694529B88A5EA546FD44DB16EE84F7BBA6A7D20B61304353EF7C39
      16A1FA2F6CF556BF7580AF95F3E6B4D6BA693FE9CB039861CF59154CCD05D177
      AC040333B0A5C041FBF29A25256C4331E2723DDE780E9BCD4978A7F9B2F29926
      1904C9607AC7F931E228B22F77B2072CF3488083B362C482671AA65F1BAD630F
      CDC1340657C370EA05AB5C2B0E38741F6789E401C415E0A94596A711A7DD41CF
      82F0CD6B5B07672449B901C9A0726E82BB934085FAA38A34FEF094A5ACCE9F47
      9FCEF60FD5B3B06B592AF2699923FAE3188C590C7925AF8BB565C32FA05D7F31
      1F4CCA7876256E01F3D8AF83222E4A8F7DEC2FFA2D1BFB0145AE54ED46DE312F
      DCF969B36C3934412CBC2EA2ABB81C89337F1F1DCB3FFDF0234B7C336B68BFAA
      309E45EEAA0D71AF8943EE080DA3E8355905FF9C4F7978E068DAAEED1FF79EBB
      B6B956CD41933A48F2C2AA2498E6CDAD1148769128C060D8B4006B48D39499C5
      8F4DA547D1B67DFC61691F03DDB658D603C60BECBEF3678F8FDF7D1232D6281D
      0161F505B980ABBC3B39FE0FBEC7CFC7C7FF0125E7C5D362F3EEB1A6A874EFE4
      6CFF309A6BB168C92E4F7372E19E5D6DF7F4277B2C05BAF8F664F8E1DD557F20
      0DD435F59DB5B29FF3B3119A508C851401D80D5BF6EAE9D3B0740573DB55894C
      43A2724CEC7F3A3B6C55EDA4EE292A0ADDA330DD3316B76049EDCED99BA3E3E8
      D75FA3B378920ED5D5178D935F7F8D0EF72FF7A35DF79FFBD03A842B9C4C3B8A
      47555A48D5A7F82090D7DFBA67283A87CCFB31E4AA35B986ECA498B5B9E97A5B
      49CE606B5F2435321AE9CD2A59AF4082DB6968609F1CDEBF72DCA1AF1C276BEA
      DFBEF2C29C9552F728CDA317CF075A96417099185945BE78919FCAFD4F6A0AF8
      30B630B37F876E429815068495C3952C3D2E799521DCD19C1C066E58874968D4
      DEE34466DEEFD0B5CB78609662EE42E908DC3FA6C741B9DD54D7D9EFD03CAA4D
      01A781A0D4B6450DBBAEF049C2279B72B9F20125E22ED19A6FB2C7195533E6C9
      83B429FBF948A805A3E8F5C5D9FBFB556A5CDE8054DA39FD74F13EEA32C68E4A
      B1B324CBAA1D0B5A3C546BBC853EC34A95023C2E0E0223F3ECCDC51F596CE887
      EF61CDC9CBB7128441F431B04EED3A4617E10908FFCF19B04D0B0414E162BB52
      B07F7AB2F723EEB5CBA38BE7AFD0AD46C068FFE0C3D1AFBFFEE3F4FC70EB87AB
      EDFA2A3A3BFFF3B12048ACED815CCA227F0CBEDD0059A6BCA41F7457CA18537D
      54A921CF11EABC4040B27E15BD2E0A4A69F8F482BAC06F4C19440F10D307D109
      31807DAB9E5AB616389BB27B5DA4484FF5A962EC874936BB4AA3274FFACFB66A
      09C0628A1DF5204F6B6F291959195617229390A7F048944D9B8B9FBB3BCC5209
      4F30F4E388E35D017A0FB2744602E4CE1DD3DEA28B2F37653A8D2E8E50B64C89
      E5D1292E9B8073DC9FC5DBADAB77C5357CCC4A6ABB0F8B828603D0AAA0843743
      9056ECDD856EB4EDAD9A7D5F22A82CD16C939294950C6E0FDE8D07018B3793C8
      B6552BEE2CAC66495B18687DEDB1BC597B6CEF2EB5C7EE5BA66F0F45EA8E01AE
      4A29088A3745DD8BBA98617D4981DF23647AFC14F143F9042641DE5A627768F5
      C95377711D98F05AF426A94FAA93432FCE08FB6B86B4EBE828875F4021876DCD
      45B48AD3F3170BC77F9657A91EFF4DABBC5F9CFDED5D606C012FC32A192439CB
      C4A8CEC4B68DD3B83F71641948C5886628E24837659A65E9D0319F59CB56641C
      346EF7BE2C90DBBE75EB7875985472BA2B24E0C92D298A114AF1F1F994D831A9
      09694E15F6E8F4FCFC52BD5F3ABFAACFFCA0174C5F0B632BEFC3A2EE5EBB8CC7
      01A003D1847549770A33F693EAFFF2B70F72281FC41955B893E37898BC434C30
      AB4CC2601CFBCB2026B2F1204D52AB42623E723D4A4B54DDD5F001690C8867B2
      549914FF434D84B492F3D2EE02DE190FD2292BD43A9ABBF894DEDD9D63A487A9
      1EB22B88ADD0493D2F73433F51386116579D3BDA853ABD0FF216171747AFA2D3
      93376FA36BE48E2B7BED9431A59FA2D3A377170FD28C25811F5C1EEE8B48352E
      B83AFA76FEBAC52D7AF016DE7D7AA016E476BC2A6A50FD0DB105F7FFBB839EFC
      EF7E56E3DFA2F741CFBF85E02D64A5DCFD067CFE47DD802F5FB24EADB37D1E9F
      1E7D8E76A38F0A769DC53316F34DCAE812AB45B443BFFF71CBC688CA22D7E27C
      90A55F71E91900E0B525B1E715F67F7374BC65433FF25ACF52267B93F827589A
      71D251074D72F22934311FECCA7F6EE985ED01368B59E194E5E5493DE7498699
      BD2ECA6C5421B35793E80F4F0FFC014F2448E247A12689CA70DEAFF8EF0F4F9E
      0593A9051A51F58A27180AD30806E0D96BD1812970FC0CFA1A595559B19DA7FE
      A71F08271E9F3F7B15EDE7C3AB02D27094F2F8FFA2F760929E16C597625EF323
      686673A921DA234C124B5551E19BBFED1F6CD98DE758769643C86BCB63FC962E
      6AE60E26CC07F29D65EED6E7E334FF273DE86D1D760EC9BB4F48C8D2A5128DD0
      C8B4C8A94E4C883D2929AF83C27093A4982675B9ED0AF81ED0A514DFF5ED65C3
      7CFE25E6BA1489C39412CB691EBD9B7F89772FB15A50E73CA9A3AF719E565BA2
      DC3F10E48668499DCECC7A18A5953073C027909AC0527371DB36648D3D7F6509
      43E7034C10894C55D43D3C3E7F6D18A287D2BFA67184C3B628B735A77F78F904
      5B8BF7911C5717B512133393BB16137FDBE77FAF408ABB149E8957A009E47493
      1BF0B8AEF06D2366309159380CC780D6FBD36C18EC803FE7C59F75796EDB0256
      8318372A92A30CC9628E77727EBDEEF7B67EECB661B8E7FE82FB1C5D806D1D67
      52357B092D8EAB9EDEB149FA6F1BDDFA31DA35F44D169FBE663C2B209839BB52
      BD0C451A963B1937F73065FFF423DD4CB7848CF02B2487520AA21572FFBC4BAE
      CA748AB360DBA630CA1F602278E68291F970B44B695AAF07882AB10D4B7EDB76
      B16A0F3F3412917C3819D10C505C79CBCBBFF64723A3151C3F7BFCEED3B6EDFE
      A8968CE4909FA63996CD87A29856D1012923E15B9BD98AA1C702A4C3D6F80DA9
      3AB4F8B75D708CEB0BA680989367F1516B2B4A51E27AEB873FC7C3DF24F5BBE4
      DAC5B1C07E97DAC37B515C4E58D55D3924F6F627D703A69C0845244AF3D97C4B
      00E1C7E73F2A78F1FCB3B31EA5461F793D7145E691D10725FCF6E96F17070C17
      6F1B02C6D5C2B2D133F8B9230D2A4AF91D4417554F50DDD56D5BC19BFD6D9EA2
      B0E6BC2E22D164D643635C94C36457D208A2CE0751633E3FBEB864F4B3B36593
      42C5387D2351FFE3D373E4E98F438A26EB9F09F881D79D217312948D6D1BC465
      46856735709A52D665B2ABA8A43754829A7C78694AAF75256BD9333910F0DE12
      85FBF1254EC777EF0FFE337AF426615DC58FB3E8EF490CFACE23673190870ADB
      F009733BB66D0B2BC9003E576B41AEBFB7F1BF90AFEFB610598E0A11497A09CD
      F06D5BC654D33D8ED29C8A7DA8C2C3E5344A86596CA9F252E76F3EE34EA2D90F
      3E29FF61F9000F0B772555E6C51351924622BC823061D5BB1257527C326009B9
      2461E3200A5E6A7523B73D436FEBAA9E3A4787100A43AEC9C50106D3F7477E17
      758E2C17E639D78AC81E8C594766AFA3210C3D323A4C55116D180C72D541A35B
      7BBCB775FD08319138BB3812D64CD8E959528A892CF56A035F8739C12055239D
      CD5540B1D9E80F2AA4BD952D16E48376FB343C5D83FAF3546D11E53DF5DC1528
      945A455459E7F31EB4372F9E47284D6029350E9F17D5589532F7455D282B2C84
      A5E7F774E06FEB912A6342DF57F36820296680B0A090A8F48773C5A4D5B39BE8
      B779320780197F75199971CD67F40262B5D503CA8AEA6167D5ED67B37241CFE6
      1B20D1588AD648FD5ED5E11A5353DB082BBF074BAF2BBB93E12F15AD444FDF01
      8CA80B3D87C8A4C9E38C9D62201BB7140A94CB0A28AB3F10DAFDD30F4F81D8ED
      930A737171C44EB12C568E84E1C4BC27A5BF6F7B6CFFE9C73DF8B79D8FF915FC
      E538CBFAFD7EC7A2B494D420D3D86A9B4D937CBE6D43B8874524837C441AAAD1
      D9DBC3CB40DC3CB4EA20322DF6D2052E669387AFA22E6204BB277CC0DF016EF0
      212E24BF7944588F4D27F287415E2335A21A740DC2C32D8FF13A8C347A56CA0C
      CA4E50615F11931329673BD84DAC10147BEAAD5864669719D47126F9D36E1036
      E7197388F1F895891D37D22A2646FAAA2524777FC3CF6193BF02108A6D4E4D5A
      D71155FF754750D4C581CE3444574D4FCD3CA5B153D996A30C9BCC882CCA61D1
      22AC174EB413A7F1EA8ABD34B55CFE095C61B8DD3E530871B85E84B296E1DB8C
      E2EB7C32471614BC0F64E316F9A028E98CACAFBCE7F9213AA743CA5BBB49835D
      4C8FBC8BAC0B5490BADEE9DF3B9CF0EC8F0A27BCA09BF6813AE6B338B7CB1A54
      C32D1F481AAE86CA5B26D32B17CD153B55488B90ADC7FC3F8E0A010239ABD872
      1707E7A7F70ADDFEE9057D35D688D0C0A3CBA8AD7A6D7A0A76A9C83EED4B8523
      849445268C6726F3D6927C2E5B0057822A84FB1F351270B7ECF20B74990A7671
      1DEDF5F64C87AB9ACDC906944A4272AA84910ABD470C34DE923BFBE2E59E9BBF
      C3781A4FE00102B34C8859321899C503F2F51C72B46D53423110AFF5E4F24C62
      2C3C374D88378F4AFAB844D7B95E9A29F692ACBD6DFB0449AE0A88AE474717EF
      C5443D2B4622A2B8ED5311BCD82715F7535A485D22D52053EC50E42CB5460AC4
      AA40F10CDF74CB967F7CA253F718AAB8A0AACC081A723149FE862805F2F8A6F5
      C6287D16E7A36A18CFA89B93B114A6E260A541190AD33870347FB4252EF482F0
      6E05D98D39D7108A9E49CE2AFFA5E916BE94158DD26A3ED0722BC85363D1E6AD
      078930FDCD8C8914400F7E3A7CB77FF6D37E9EAA40C0E5CD2C7915BD8E710CA5
      43C4DB5FC718953A1D6ED9E40F8475A956515F458318E9B358C196FD4F19482C
      3DEA5D8902796522D4C2EEA4585C5144D534CEB26DDF9CD0AB80DAA75A69B718
      479DC304591B55121DFD364F67C4CF3A3638F0718B91062CB66D17F6EF8114D1
      1192AB7981621F1E6400EB507FE0A642C175FCAB2EF92F18497FE70054A8CAB4
      2D64F792A92B5A3C6DBA503CCDE47FB4761A2B5158ADB85A0B51CEAB2DA1A497
      4FD0B68A187F0D0E8424A760A1AA7427DB42552F9FE2C016A0D327C892218725
      45CE0804923F5E5C6EDB008E15EA4D5DBE3BF3416946642CE711BCFAB4AE51D1
      1366D13C97F24E945D653AB09C7A7BF7C0E45E3EC5C5787A7EF806B7799CF3AC
      90E6424F53EEE6AF49F4EEE3290B30A2D42DD2C608A1A1F6AE8590B7ECC633C2
      90C97574F0336A9AC035E75375287052A84EA74CEB8821075FAB4449623E7075
      0FB4F0E533E0942E07C9A989A4C485407EF609F896D0AC8B5DB392988594E65F
      5C926351A61366C860F5B8F82B4A17212F95BEC3B67DC5C92FC5A5A9F021271B
      DD07093F394A89608BE36238A716804FE4754EC4B4D8D2E878F98CDEF874904E
      E626BCC050E3A32AFADBC78BCB40E47DCB069EDFDEC0FBFD839F1FA0011C2807
      36E7FBC6066D3662985730CD07F8E68CBCCC2D5BFE1E478D5B603A5D8F2AFC97
      61592AB6CAAC6D5D4842100204816D928EB4AC1574502480C6EC07E4A3E9A594
      3E2C1CE86814870DDF4F944151E0E4750172038A83C59309AB816C19DEBCB507
      04C9C0D6D8FF7466F1DC344629B928814E3AB43BB4EA1D036313D9943D02D214
      1A914A60AA44AD2E34BFE7CA213F0235A9F8C2908046828074B2DE3CDB058782
      FE0A7E86606605EA5BF6B0AF0AB0874004A01E8FF4C0B067B13118B99910A918
      A5B18A590E397AD0DEBC75A06357C1DEBF443FECEDF9B2C94623106010D99941
      28BA510D48CE24DE2C2E23DF6263BE24F083F6BE511A454327127083742D3043
      090960D5441D247DE0752E8B4E34838CB408D4F85FCA4A124BC1A7333E688F03
      BF1E7417F411096A4ADDE35D5D7D116184076D3764A4E04FA9A67632572E2B20
      7B6682B5EE64E4F24BF35D2AA9AB0C861ADDA28DA0756F580F74CBC3FAB6FEA6
      B9DF0DE2F241CA548EC3465539CBF1347D1A250778E34157C23C17D2F9BD48C8
      B79D5EA179616C8271A037E7FAABD1C0E0CEF15FA790EC0184E94B5819632D55
      E0C31AF780126EEBB9628CBE30D034ADA8FBEC2BE1F94A85C6B256D3FFC12392
      9AC4F1FAFCFC67087F530372125DBC3F3A7535F7640C112880F1FA900192CBD1
      5833DAFA209B1C97C5D4D50B753B42C3A2EA785A114D1FABE3A31FB2571214F8
      052C8ACF4AA350864A53662B3C6CBB5A7A91D5DD722448E655B2F390BD12F0CB
      EBC4060429A1E8E444541EB249E3A82EDC4B38A4B8BF670CF341419202F7AE2A
      4BFB047BC85E15E5EC2A06D4BD64DF56017E246A190B4435E36E5B7154DE47F1
      5751975E2CF1F6FB46E15ED0EE0FC0B1CBCBA3D701D77AD1A1EDBCCE50F1DA55
      27D892BBF3E2E58FCD863F9D5C9CF0627A7F70F63AA434DE2BCBFA4F2F9FC22F
      ADE6E371FA4D900C68DC08260C230136BA5CC9DB3A4E862E7E46945146EDC913
      22453CDBC16FDA653A5EA7C9290CAAB150CEAAF3561C52A27E8CD54286FF0069
      9680A5B61B679FE78D2E447BE8168E5AADBADDB960B1BEFB3E9BEE42E78314F2
      1556FEFBB2C0C55C46DF2E8EA223575CF4B498747C8DDEAD9AFD20C7B1D85481
      56DDFB3281A177015394371794BB055B0C4821A825AA690A08426ED503866B8D
      0E7E958AC0AD1443D07032F4ADB7BD2CF974680232CF82480D64DE2004301F08
      373ADADF5EC822B873255E72F4EEE02DCEA59FF3E29A60104ED0ED9E2DD1FCB8
      62F92D3DED14ECB90FBB017C241CA4ACFC02A95498512E855D73D60490179E59
      8BC9C24850D4DDDB7BB27B7C7C1CAE861FF6F6F0D18ED9E6D3199EAFDCC8A38B
      ED2EB3767C4F359A24C467A998C2EEE7451565B4149D3A613E8ADE9E5C9E1D6D
      4EC7B8408D9C0457D27B57C26D5508F702293DBEDA9BC570B5108A78D2B154DE
      E15351D4262FAEB7139B9498336E6C4F8388AB68F7B76ABBC0C12E5C845B9EF9
      75EB8722600D7B8AA01F1E154FB27BBCAE503FF99AC37B3C06BD0A1E150F375E
      122AC7812D487312C6244DC975E58391BF2A45E75C76439A47870DB60083FAA3
      A42682C5E03EBE630C2D0B43EE305399999A31C55F1842681408D3DA05E817C0
      61E5589B06AFAB271E8FAC901D422253D21C1A9AACBC33A9EFA67AD3ED131F30
      BC954CC7B52CBC465FCF98057C1D1F53E86894CB0737703D1D423C52D9383A6A
      6AF7DD86B29125A2A48D1BD57C24536367031E8DEACD9178B26C6C83315C98BC
      B5EFE22A00396607140833972AFD343839B63C11DE15588EC8927349725AE75E
      D68AEF3D27569C7B4BA3AB8BF66A6C70FE307F17C53C8B0EE2B434EAEF28416C
      6D406D735051B6EBF63168748D5EAB672F5D6BF7DD7433C3D5DDF5E9EFE444DF
      40EF961725BFB6736F8ACCD3CD29323F17BBC7E9CAE3C0F0D562ACBA9271057C
      454E075C0A50E251A298D6191047C9552B665D67E207EFE3BA4C44E5FE316411
      E29BF771B601B189CA8D01B969757BD1A080EE16647691EF804D362DF21A6592
      4605A26D082103F1E5CBF7E03C95809747A9E29B221057C26B8CC83B95DE43D4
      6096F487C534EA16259F206FB0C3E49C8FFF7BCD19914883D17B304758238349
      33863DCB1FB5C8B62E62A8744858A859C77B0A5C18AECBE61438642C94EF8BA4
      AEA24FE92829561A07FB5C541DF962C73AD5E4FA6DDBC725C70D2971C58C94A7
      7F2FE697F341822A8E37A43B714A35FBCCAAB4A14A6141A917FF5A7F94EAE88B
      40DBCF9CBDF749F985FA82372C2B133DF9FEE5B60F57112C41B74D5B49B39B65
      6552EBE45145D1D315A14BFB91A4703116F2A0C09D4C8995E6036335BF8EA109
      9FDDEC1850E6D6808A3508AFD7336678BFC610FBCD50054805AE19CAD19B9905
      EB1EB4DFA4BCF9524F3891A1B34E8CB8BE46C591B02016BE2339BD2C8222D78C
      582E76B1485C8F84562615085B87CA27E0E75CCD6BE0520F0B9AD2E5FE98CF61
      EC68F402884C318E5E9F49051B0633283A2EB5CEE2CA67CB542057771559D5FB
      6B9044CFC424DA79D0AE06C54A8BB12D57CC304E41B09C75354844E731E119FC
      C384EF1D6F16A688E862B9C0585A0EE753ABDBD110F0142D170BB93ADC8D53E3
      AC3B96B87DD097ED1CA2F0795B09B2E37164E61F85F66F508F56AD45442ACDFD
      34AE0DB7026505C45A762C471EC014917CF83D22B7DE49CE9184844850F1919B
      417395C29B199827AB8B22E3204B67827F1D93AE9027D78EA019D6AEC4F38C8E
      FFB0BB8408071556C1D9DABFFC802ECBAE79D8E1522B87F275A2639E42F5FED6
      2B92B1D2381AA02421A96D5800F928EAD6573182CFD5553CDABBAEAEE29BD133
      576F6C9C7E7B5030FF42E263B49F8B52B2D8E4D832ABEDE8E28CC177D104B838
      1213083A24E742AD700E96F95674CF3CE9BDEB42144C96364128936347116707
      0B9A1DED02774717670FFABEFBA3916A1676779C63137BA746D4F9B8D52CC620
      388D4689B72F82715BE44950FFB0B424B0FF8022C6928294F26AD4DA9DCAC51A
      C47E0425BC5788F396888F870AFFCE33AB1847EF8B6B89F55CBC3DFFD8E26EB1
      C8D3F6D4895BC34E8A3213B532753137557519E7551693B2E1E62E608DA080C3
      EFD59FB28E8E4F2F2E6D18062C242ABCE07B2A11DED2F8A1C977B5624F6F3E7C
      7CEFC2A51AAF4441E77C771CD7A866A199B06ECFCA1DB958927305A0E4EA083B
      A9BF956EC4B2EF4B75621FFF0A5288D5A89252054063389F8AC8464FE030B9A2
      4EAB9B758D59054F5F01D94F4A3FDA77F871CBB5D11AB56591B100CBE6AE85BD
      B1A2F372B0BC16D941A3FC40C8B22841801BDC98D0CB7A674CB3CA3ADBB6D069
      BF6357874154F7CA79B21A7552B319359534714E4A847F4D7A8DAEC44B7A01B3
      547AB898FCE48B226F1EF364411D898A87B5DD64BA47288A4B79BB55AF73FB33
      BA8FF6C9C43E96741F16E6D56F3DEA458F509616E10C114D93AD1E88AA3E1235
      B5472A6FD03961C50D1465456223CFEA8ED97F8FACAA0DCBE3C0AA1854059F7D
      7D5BE58F476D718547920DEDCA963B4C5044A0A229EE9109EED95916FBC2582B
      A7FA0C498B61B5D978006B6041D741EF5039A668EAA495815260018F8AA1C800
      74C118B35C3486E41532EED160A4A395A054A99B869DCD57C32FE0D57D5E9A45
      D95B42A390F9E15B50C4016C3F44D5580F715D5D61A93FC721E74D4817981360
      753870054A1686C14612DB478919F18991E09836EB61AB1EA4C754574326F203
      B19FD8951EAA3EA9F43D9BA27E76C57CBFEDE0D95B13535F41030DAFBD9CCD68
      E99BA6D403D9127CB6552796B7AF89C22BDBFE9EDFB877D37EADBF82CE996BD6
      0552ACC9E373BEEDDFF6EFDBA23666C3C70F1B2DD9DB6FDF5073E9633ED9143E
      C6A7F8B0F55AFB6F4E175A5BB337DC59A45442AE484957890E62B940743F9CC1
      94953FF5A45CDA1716574BE24AC0E504EB3936B4D7DD6296218CB222B9ED2EDB
      119B1F1F1C0EAA0CE1A45F3C2FD661BA3ECD75211F96E0465D4C1246762429B6
      15D22BCA46B070C3134050F19A02323E99A4507C540BAC89D322209AB34D2D10
      A1455686C5748AE31096D5CA167992D8E2E3F268BF891F07C12017E34CEB26E1
      E8DBEAFC6CBA4BC9B5B484DA901B8D781C04307C356259A55D26442FBB232497
      A6A7F2923BA2D2F0D545201B8A3FC42E957D4C76BFD1A2C85D4FA1397817EB46
      D3E1B74DD07FB884FCB5E9F8AB92F1DB26ACE0E4164DF6692B5CC728A83B766F
      005098E578E99AEBF6CE0AA9A2C6DB9B2B9FE85D247990C4C5FDECBA2FB3BB17
      75124F913897C4D3A5D91FC8B2AE2050E7CC2E09A9B10BF220570CDE8401C48C
      9D8B9815C02E2828EB1B3CAAA49E0F7EB4F9BC1F83DF39AFA3972F568DE4A14B
      91214E02D633A03AAB9FE0CBFC614DA4B9A42F8E9A8594D33C7A02615EBE10FE
      F53DBA3ABCBACBB16925594D186F83C299EF5D501CC32C553FF529FE4D44395B
      0A78055F80B3D1D874967BEBDD39094966991665971A54D8AC1298ED47DD4B7E
      E4F00A088123DF822A76B0DB1CC20AC96BFCB4188FC55CC4070A6F15E371ABC8
      90605A12A0B6543F6115C825D826AB1B79962F18D4CF25FF6049E97138203FF7
      77564A5778081105BD5F354B415A6D38A1BCB1FC6AD71135A4BEB42F2EE52A67
      4AC0C918FFC28260457AB1F325C5FE4B9016D2A8F0A0F3673C78F02FFC24ABDC
      D2201917256A1263D55EA509BB9856BD66EF03D85B397058E2283941483F7829
      795E7B26B037B3D5B71B6E16223932252D48A09A6500BB911FDE71DFEA38FF19
      2D5CC27DE64AE91C63D28D308F6E35BF790C1513DA39AC2F596A3CC24D87635E
      9092E23B85435195D8B102FDB25FEDB5DF0631D255F15BC717146563438F2B85
      F5BD1D9EADF5209332FD6AFC8C601AB4DC5BB7555BD38AB2CA7A8AB3CAD1A0E5
      943FF8D9CE764F266F15805521A0A4B14D76424C4B57C8E046797F5A29D6D05E
      4DAAF38E59A8F963469132061B344E3356FD58566E30574E00FCE08065E7F7C0
      12A009D62BAAA6CB02ACA26E503F10F54E7950F96599B813C57EA0CA42C968E7
      55B48BB583D9EC816B13FC071628E6494EB6DD77857DB0F9E10FF45F2BCDC06B
      5EF5FE1228D04AC5808659029139320B75611994D3F1C66A7984347819243201
      70B82F64EDCAA2746AE36454BBF5AB71B5E0F9A8AD27B2841AA21096A7C439B0
      36E434C7454A226B686299E8D7A2B67991EF8E125AD28BE777DF8CC60C07FC4D
      DB78F44A80650A3E1A076C69A756AEB3604A1C1EE10DE2D07805257AA11794B2
      95B64325616C52BB567396FB6BF749C41BE6E50C36B05C0B3664929CE765B610
      403A922B0D75E1B436F697206990EE03DA9249801DA849673C0D35D4D18F8EB5
      D4FA2246C5ABA98D4BB51B5E7762C26E60020D8C278FD0B487381D137689CB04
      CC8B49A11792603350473011853B77A18060A0F1FCF276C31EED49520E83823E
      229E767171E4BFDF30DF49B8300B773778E8A6367C0843EF4BB48E01753C6A13
      7839C090CF1730E4C0B0E64E90C5C8134D250245177361017683E8AB3EB7E755
      0511FF68FF485A612C936450B4B4DABE62C74DC471613A4254DC3C03BBABC561
      710413A3952435CC5A8987AEBDC0F5D16E599730AF0A0BD07336653A90F7C061
      DB42220D5A988FFB83F869F47659CDC4A5AEA3E36321919807857F8A5B0E8108
      6F9910FC0DEA71CB0F6140BCBED82F8757EBB9629A091A8F4655E370BE3CBA78
      26829E0092A54A58155D2375266E7ED3905760F2D0AE42E53D1E232AA57D2E8E
      115292DC17F84AF6E075D88C1C9B3CE25838434B6C6B555C25AF88F628CF3981
      21926F7519475F0BE67C08132406C3550438C57B6D5CFE7511BD2FB2B4BAB2F7
      FF7E47F5329BB56C91BE5D81C75CCC9410D394B9BB0334C1240CDD64EBB30BF4
      7B81D11378EB384C2CA903B0A4987AD848885E7C4D8552A2672CF2521859003D
      30DA2F93E810C7ED1DDCD5AB32CD49ABB94059B7D72224B4F242D5DCAD8F2728
      7DCBDDDA4147918D4C72A43CB2F1BC8D29911D3B005B684DB8DD71366221B94C
      29EF3F8636AB3C599591E8E49241827BB84D22915AA97666A4D89670F2787FAE
      3EFF548A5083478DB34E9581D8310176958A8F4FDE26D92C7AAC84D3E871F42E
      F936AFCE8A11FEFD26ADDFCE07D16323D2448F1D3FF8B192611F2BC1D6BDDEBD
      A9D14FFE30F5406A1B3DEB3FE35982A6F7449507164258F5DA72042C939C480D
      AAB874076512A3AACFBC2E76CB44504C56E3992625BEBAA558F80BEAFDFB32EE
      A62BD6D074FE70F4FE14399F67E78747A7D1F1C9E951F46EFFEC4809A90F2BE5
      50C39E96FCB09947955C553DE12D4826BD3FD81AA71A869842220FDA31F0B21E
      9B06D9B4805D670264A3C2153476F5A81FB4EDD364023E272B33E3DE6718653E
      938B734F089C4286E40DE338140F9C9B4F8ECBE5C1F147BCA500723E9420F86C
      E7B8A0A3F471D6F9BD74013A523F119740D509F822EDEA927F3F3F7F1F38DB0F
      BB18CAE24B9207F68D9520A14A943A86ED8CA3492A56A831853518FFA01D53A2
      C1C9E559432A8114064810B7D2E71F98EE2A152D2F8B593AEC08FE45B162665B
      76A2373E1D7E9088AC47C5B2E705F808F1B68A09B7F4464B81A99E1C50B90B92
      0A3E2443D60E9119BCDF765D4EC932562C0D99B40AD82D66C718A3D2298328C7
      518DB9A6FEEF12C0EE217B4B2BC465D6CB49E66188613C8405E3C03AA1AA2A76
      212C0D97FE1390971F54F2416C1A8A9C25A35BF04B38E04871A30CE6BCA61E0D
      8D10092DB991276F32A42B574C77B78A967C5A030C79C8373163DF541D25279D
      505231A384A3540E429283F0A1E59EF3FA7D272AD7E3F02A57D042A4FC373667
      D492124B75652CE1269A15B3791603E105A6058BB76187B55D7D5655490A907B
      B86E668C0238782746006F17A8B5A55F352A3464C988864F919BFDB7B959EFED
      499C3D6A51EA25BDD69F173B5E8D3158DB6668F7426BD62CEC554D79BAC32089
      0605922AF291DCCF88AC8FEE6FB7EE6D6EB77A02D66A34A7E3BFD8F1542DEFB6
      5B752B812F90E4A3595F6EAB015C5A0B6008DCDA841B61CD20AC0B407F52C653
      7148FB587A56A0458533A82C26C60F651615C1EFC8F706C537BFB359C7080691
      3D7C3CA7EBCE6757FA7BD2509630D4F0DA161DE85A895E85A462936D1A2DB0D2
      9E3E6FCFC2D31F64162EE9B141E203DE5ADE126F5B02F25C9E1F2C49FE4351A0
      961319749FE661975E22ADF75101617747B7F15FBC8C073B6D4898A35A949114
      4558ECF0CA5955ADDC03511503FB00C1786D18AF22101B8F5A45BCF48E537CDF
      1DBEAB49A7E908A99C63F7582CA5116C2BF656091E0CD0AD832F51D23089BA76
      2D14252E0389D95D2F6945E0BA201F2D480DE7B06BADAE499CE69BAF0A314856
      EF4B654232FB749196DC9A58581DEB70DBD3CBE8BBE88261E4CB0FA7D177D1B1
      EA8706BC4BB4B6F229C7CF825245B8D2084180E0A2B7F4972499419C8A2019FC
      58C300EC421ECECB0A17458122790B877CB335594EAEC17048EED2A4B5651685
      3E875DC7D096095E05014116A59F20C06D68B95595D103E4B647E8EF365F02FF
      51142BF3EFF7A37F15788D321E7E811EF6432C01B4795B2ABFAE89BD5EF41D5F
      7E77F3DBF7E3094EAE764DC7A54831A98082C1560D4AD6600E1332CDFDC30882
      DD58774DEB6564C18EFAAA2CE613418F3BFC053595040D3378FDA6AA9124838F
      BAC8C4B2D06EEB48DD69007322BACB41B09C6CEB9418F6F20C4535D7A2F62B7E
      8B7B0F29CC180A46FE11271B37CF49E692ADBE5973C974E7A9C596F8C216440F
      DB178B868F14927C059D240E2B0FE2535A9DDD9194C7E6E22E549306DC18C72E
      91F3F21012075DFBAB7D5B7F1C7E591A5C3752E8939AB71069F8824942D0C036
      AF703F94F0D38048C90EC578D9ABA515AE3304876DBBCA4AD0C78B89EDEAA326
      7780BE6528E36B44FB58EB09B6BB253A0C8BAC98971B6B76F02936E1EE78E433
      28FF3F4D6083309E27C74F3E020425EBB3D26FD27BE08947B523E404A50D1D68
      F67807C18FDF69765DCE41D3B883E5E4F42FEC398FE5F73BF23C13F457CA92BD
      D0805435474D950F1B8244E11EC20C9051902D291AB1F9C42AD2B6643E572B24
      D42B91FE100DE0945B3B6AE229B1A5984C444517AA7F553A48511C45D811FA7D
      488C59A103F9911A1ED035B3C45B29BCA3B41431E1E4451831EB72CCE59D64D6
      DCDF5198A5BB3013EB12814CC6DA0FDD94819B1918B34D343BF4E38788C50539
      C4CE9B97D3C995E8E3F7BA8D77781CF698721B41FBBE0C84B6B4F9E4BF4D2757
      BB87EF4F644B6EBC8183D4C2E613C2C357D138296C42AF671873AE164A3FCA1F
      C6F19032BB9505F77E8A9EECEDFD1F7B59DBFD163AEE3B526D964E5309E23836
      AD0E89B9B083D86A0C022C16A1219781EDF43487B6931A1D1CCEAB5ACC2ABB3B
      EE36C49DB7F174302F27C87B3A6B57565B744ADDB7F9E5DBA4472CF37DB98714
      DCE6CAFFD2A7608552901AF724AD9FAE6322F3B68AC604B3197690E24ADBA5CF
      9C1618CC7F7152B67A806562502C884CC17CCBE2B0E0046CF5C30DA2BC4C1413
      C3AB06B1D725E4363398BB7FE5021B25B324274E0E32830431B9973D713B0C6D
      8A32FA24A97DD498C1C7D0D01317FF0E01EC8B53334337B359852CE52C57B469
      A55997B1D6BA01E5007F6B5686B518F7D45DD69AF35E25AD67AF3E8183E2B081
      4EB3F04E945AABD58C3ABC7E3B40DDE5D6E5D74CA93D2DADDE47348D99D6CF9F
      D1C53DFAF6ED9B8826F6A3235455CD6EA464E902BB8D1B4CA444FD09196A42B0
      B9F90CFF7CFAFDB3A88331EDB88E77F7F6C88B3D94ABE9F9DE8F2F5CB7DD778E
      8FF6F46B47946AD4B754AE3249A6D07A5A6B93BBB9F3A12396EF0944DFD56471
      6DC30FE15F955D4C4551FDA35C5C520567944ED2DA12F48D438ABDF0EEFC92B0
      7F26DA2B2A993542886A0A3E58D0749CDF4C8B724D226E409452C134A591043A
      69825E88A87CE2AB093734DC05F69FCEE29A13D5D5E2A4C41E5D689A004BEE94
      2AF1C2743C19F58AFD6BEB5E90D7EE453F45FF9BF3E496DC755CD209F391327F
      CD2C59CE6B97BFF1796E716AC1A2BD4DA1AEF534ADB18987B2A78E83680B807B
      82B38E5D8450027E60C68D1B5ABBF99B5B7E65CBEFAB643E2A165B960AD16E66
      1A1D91C5A93DC1ECBBD0D206BDD1CD8AB075253F86D92BF9125AC9414B3E7C4D
      1AC3ACD31BEEFB2DF25A36397A836F873CD620DDC3092D19048D63E1FCE58B85
      74254DD89094A571F1F2C51DF2950221450E06864CCA51B9F49BBECFFA161443
      F354F4250D3A5FA8CC29570A27FB82DBF7E622FD461116A7587CA3B04850BCC9
      6699E19FD5FB6371C0D1056F874A284F0F7AD12B938B3BBF41A6958FF05B6E13
      3C3A2197B28A4A5C2FEB385A9CCE87C451A55EC35028818DD0B7C4BC2474BEF2
      255ECF510A6992835E18E775144F99D504A919902E04B9639477AC64E0924257
      9A8522A26841AE14E782B9F8961F19E7C8FDB9768ADD1D4B5CF075B26ECDA35B
      B1DCDDA218219C7120B50C56BD69F30721A559EF5239D219971D699AA17CC445
      228088446D4D748C594D2E6BA64C146493ABE9E0C3813394254714B15C244969
      D29CAAC8AC9C9E0FC9589C01D11A10F1B442BB9142E74B8B3800472B930AE5DC
      D02AAE370C701E7DBFB7D74E2BA1254541EF716347D531F79EFFED5395645B0F
      C299FC01580AE238B3736EC45BC32D03E50AC24B8A04AAB4E0F39E56F1F6244C
      BCF6EA73A45A3FBDA67BD40051A4238640FFFA5F38797FFD6F6E3653C8859D19
      1A200253CBFA80549AC435717ED612851DA3E04D9ACF6B182EA89E44A6BDEE1E
      C5BCCD8CB4ADCF9C34E31DCA0A6CBC42BEF14C842BD4950AF2A671BF4CC6F215
      0C39214A89BA04594A692E52FABFFE6A03C2FD95FCFA6B4776413C64255A411B
      F830917EA72C8E5432E0B2B7B3282B261BF65B71C4DBCC0DA6EE6C6A701C1679
      CD7E477F0DC9D12A1BC4E2F06C75CDB9E19FC3ECF5BF6A19265E2CE1607B0752
      669D947D7CA877D2666D5052DFDAE023C236F454B23D5B26E3957EE3EEC1AB5F
      FF0B53F3EB7F477F9539D26B86309C7FF0E692305017D9C551239985D61326B7
      ABCD598C6FDF8CEB5681669EB988059FE733826EDFE45A66426348EA1CB9DA54
      A12E8A745E6E2A8D9E0216A23BE913935DE0E4E0FD47C01E49C05B0892DD82AB
      13E73338CA70C1D80DB8628BCED2AAECFCE07210355D5E1B071F0E9E3DBDCB20
      CA0FF4EE096F1C27C2C95DAA5E1DC01DBBA7820DBB7123EA233AEBD91EAF3312
      F2F678CADFCABDDA7CA04E48B04E469EB94F666A314A66F88F0DCC5F2DCBA40E
      9D05209D4529A63A4F4675E04D0BCD9B77FBEF2E4EA22E2C39A87962B151E138
      1ED6C0DFF5FBBA54342EA2364F989CEC3ADD0534205435A982E91E264B55BAC1
      A6C47EDAC150132344398E861A3CF78FC9788C841048F49215B3830C0D52F8E4
      CE0FC6435C94141596BD6E105C12BEB2EBB1622F7A6437FFA60B0A0201997E63
      03673B209700BC618CE3F646E498358A13BFEA12658CD5AC012413329532BF4C
      60D5F9592FB6626525254FD122402E9D1466786677A1F60CA5D4B07F610FF0CD
      1E0509C7692E001D01058BA4F3C5ECF25B3A88E71777A03FF0E5EC75D767E151
      CECB83830BA3C4D2E0C924860DC94C5AE9E07698ED1BD941EED9D46784B04769
      2B5B00301E56D48AEC79B21F955400A7F758608F9525DB7A924CDF35FE89B95F
      64366F57909EFACFB312CDD7509EC7B4DCCC4C1E91563D74D9FC78B957A2D1CE
      9AA2BE3CAA5C95D0D4D000BCD8603216CDE29AC1A6B4B54EF90D942825A2E3E7
      8C6817C208127458BABAEF08AAE3AC5832458B5D75253EFBF637551F15F29FBE
      0584D8EDC1DBF5EB32549FDCAC6BAD51D445A2ABC1F697C87B12EF010A2E5248
      7D606CD1F9204BBF32D1D19CFD67B2B5ED3F490C4926B140948D7E88147815C6
      8C7DCD4428655A074DE0BBED4B4B178255938380A2699024A3A5F9309B93DE90
      03E99058881F9DA8DB50F0349FA355C1F5CEB3E755C7DDDF2439004E012197A5
      D3DC3A79DAC740E0A2052386EBC79D874F9E7EFF34EAF2A8DC8D4E51CE3B3AD9
      692A0F0469EB92B5B93B9CEDEA9DFDEA2FF6A49F344730F800D44B21BECCEBF1
      0FDCD4BE61B10699D27EABAA494320CA15AD5EAB01D83E5C44B3A13D0C3A6571
      157DBC3CFEA1DF489E56A0BBD92491B5B63DE39FAB540E52A2758510C2C0D3C5
      31CCAD508A1B84EB56CAE30608D9E249C2D733DDBE060FC199722AAC47F87B06
      6B5EB7299665A8EFD75CAF9B5F8EA7DAD0CA7B31D8795D2CEE8B2301D98B6C24
      5B300C6136BA2EEF88DD3CC9F1EADB5D9271190FD261B48B35FF62AB27C0AFC5
      04EF7252B77BC4BF92E195F4616FAB078C628872C9139E6EF584249F64F77CC4
      18C57EEFF908F89CF77AC22429A7106FBBC713CA24F9220F78B6D503AEE6F904
      8509F2FBCC685AC7597ABF17F9673C8BEFBB32F3A2BC4E26F7ECC84C92BAEF31
      1A385DE793B9BCCCD6FD28E755E55EE5C9568FA866F7DE69D57532BAE723EA79
      F9C53DE2F9DAE3F5E2E80F3848571C204BFA64669D2A13B800CF1FD2D1A57D5C
      719189441D99447A4533E329103368C85FAC4F1E69947E8225ACC2117C361D5C
      4947734D74293C539AED217108271367BEAD680A0D8AAFC90E50667216A55048
      5BA183B552804C5551E7A3D4820AFFFCCA557A0D812A167F01DEB656A14B4C26
      AF899817E48F058088C8A2C1D55AEC9B599833966994927AE0D068D9765A4DD1
      2FC39919629F01D987822242A9929ADFC2B454A247BA1AC80E9FB9EA7BBAD4FF
      0A0376D5F7BE807E56E47F7DF1E2C58B75289F6785D23517813924B73823594A
      3778184BB837787694A25492501998DDC35C5DB26863A0F1EB15D57CEBDE0A25
      1156C8243052A5F0B498F381C59E564DD9345BB29B9B892AE7EE7EB91EBDB284
      1F35B30331BACE914C4D27EA768EF28EC89FD85143EAB0DFB5633A53A1EDEF06
      618998AC7939D9ABBFD8237E82FE0F815E6EEAAA2683A5553B46E46AAFD39AEC
      D8D079082C7157B4BEA11A44474DB404F053BACC01A0E97EEDF6FF5FE07DFCD4
      4FF354A10CF797D46C7196BD19371C6E6356540BDFA1B34B5152BA3577B0FCDB
      EEC886F49F45DEF5520457F24D5B4D1879C438A87EA22B1D7FE1579552D039D0
      1A327F5E8E9080B0B776DB8CE32C03D978798F7074CDB59E9AF586B0BDAE5BF1
      30BBBC9E8FCF9FF7BC488F7E01034047512743CA2A26DFA80DA087D06A9913C6
      FBC261135F548087454F9EA037F32435D28D915081298DD7109EA677688CC0D0
      3BF4477A1008F5A7AA61C87DCA2FABDFF79FBA6783EF49F0930D2B0C605CAE38
      C2B4A1D415F6A4EBD528A9984B6CEFBA9A4EB27CF968692D601CC1C6E4C5A4E7
      A0BCB0E6C247C32B281B91C0C193B805EBC054115683BBD07DA301DD6E51CCF1
      5E8B745506E712586FE5E259FC7E334A110628960C2896C272E4C19570AB9B09
      B35157A1A165471A9837215EB5701CEF70660581516EA3ACB09EEF324D24C4D2
      5A766510D5A2CC16BE870EC298F282BBAC3FEC66C41E112670DD3A4D1A51F692
      EF5E803ACBA23FE745FD6753026B5883AD25D4280CD4C508E3120B10C30DC32D
      4BCCCDC6A36D2DEBD29C64C5806772705874F11633571105E8DCF24B6D27D475
      1BCE427410E979C3D92E9B0E3F6FDCBC5E147D3B307177386BD2D8F0B638B6A9
      8363BC4466AAF47C7768A7935853AE2D961C0C2706CC2828CDC315B166062F15
      CD1DC415083A37E1811B9E956BCE5D794A4F4C5B5F0A58562C95EB9AB09D1CB9
      41C1E6E0B85DCD1C246C0D4DC3EC4685041A37CA6DCB46D5031AD70BAD485B0B
      DC1B7F19CE5E7DFBF6EDDB4F4CE5508D6B392EE4A524E1A3BBC84DF7B98E1C89
      7E84C7B89C705B0EF94DDB709665D193F1801FD80FB63EC79B3A4CE4653D373A
      30CD711C7E592211F6BD4A9F8017D8FBF1D9DE4F77318F5C36C65A0BA39DBE11
      E5495CDE4227A093A699984BA54475B72F0DE6AF768DC449B41FBE322865FD4F
      342460F787858B5F498C6121C8B0FE814BD65BF3A94FFC530F6ECA34CBD2E106
      8F657860E1712FBEDFDB7B12753F5E1EEFFEB05E4F73890560B43B37F64E05AC
      CDE1CA8AC96AE7746FEFD5DEDEE750191D34A9A47C15FDA286944E4AFFE2F2C3
      C9BB37179FF5D5EE353A2A2CD230E268D9263489A056F1C8D301245253D46D6C
      A6FD2EFE1872D6DF2D9D8EBAB405ACF19DBBCE890BACE1B66ABE47507B3DE58B
      3885420911FAD0DD4673F37CF9DC04276E524D3FA30A974B6AE992DBF36AFFC7
      E31F9EBD3E3EDE79A8361E6C08EFD2E8052D38E595ADA1FA2D4E0D8ED17FFCE3
      1FFFF8A9911E8BA337B806EE3D494F9E2E7F97839995B6BD4CAABA9F54B35B06
      91B3F75672A30E7DC7568FE9AA645D9F2B73B5814A2DAE846CF1279EC15B2656
      26202062B2E7D5B0443EAA644D5A6C15341B49859AA664B563201D81260CDB6B
      E906D3CE6E453C570B95048783D45B403528F8BC16E37FF7297CAB36A4C43B5F
      C04CF2FCD6240BA8742C94F6D4A37EEEFD0927C43FCBE69334AFFAF5B77AA3C7
      19DEE60B1FAB479AE622F81C64B570D9060D482666F08652CAA4FD3B3151258B
      D5C169453CE26F36EA68F0CABD56655AA98A8B3F3633681A8170D6B495F0B7CA
      B9490E8E16CDAD925A5116E18D234D4EEB428482F47758C06D40761586FFA44F
      F83EA48E6FFCDBA7F25BD310AFA650D7BB38DAF8F7CFE4F7E7E3713A84EF7F78
      7A8057BE8ACB11EC277B9DDD7006367EF8F3E68BFDE7A70FD6435EEB9F3E3462
      24CFA34F1F367EF4F7F2E8037A18451E1D6473C46975993E4CF75F481B0B42E6
      1B3FE0A53C6099B0F94AFBF8646CD4D780101DEC4251F6953CC48042231EB5DE
      C0D889B2B159720DCE19434CAA4D2702FD6DFE8D6A0706B69DAC7EFFB380CB23
      CD20A1410934A43756CB5F57D9213344ABD839BAA82E8915DF1F64C5F0CB5D04
      E5AE8D83EB1CF2684495CBB5CEC7C20FA484BBE5B03AE440BF070FB679A4C52E
      89031833ABBABBBFE9D441BB1CB458A984D08B3A43AD35DFEFF7F9E2A2C259A5
      D314027EAE1459B5738B20BBDE7F1B48B8E1FA136422F63A8CB218748EA0D4ED
      0AF62D2C8B4DCA2E483D54D45D512D76DC65E79296AB62AA8296A220B0566730
      96B4177B0A8AD4ECF4DC4EEBF9ECC8AED533D7CDBBD313CB425B120A72383542
      B2D1A4DEF7C834FBB6F6DC36A66798480CF97E96957545681076627510021174
      5437292B236B54EF2BBB55AC1438B97E7496F8E7FFF91F385A5F925D45DEFEE7
      7FC4938DC1A326909A40366EED75E9D7ADBD926C3FDBD8FA9C664A7A90ECCEBF
      D31C6AAF0C8BAFB2BBBFF43F87FA90BFFCE3F3EA801C14E179295B849882A59A
      F7410C68240930929DDDEAE59D54EE0EEA32FB4EB5C9F072F24664D34A5C56A5
      77F44063E87549A940A235A29CCB373EFF797DE565777A740EDA3BBEC7823488
      3C39D44338E1B61F83AA9086FCFB7883E43E08467F7471F6D86D12E53C4B681D
      01F5B5D6CA061D0D4B5DF9F392990853484C2E8287ABCA10D19988B3E891EAD3
      1739F7A8979342DA21162C45CED0A991CCE81033FA68258E1716AFD9F2F90BEA
      FE1ABB95B45514025B237E485BD4EBED5BA914B66611EFAB241B4523EC1EB4DF
      58B1B23D451CDB3B7E7274F4F0BF22D02C5E4517199A557D93253B1A4A72EF0C
      64EC0E8A4AC7CC6076E5059251D49F5C15C8505C9FFFA2DFF48890D9D8A0B3DE
      08DED9D5909E1ED3C8F8939C48F23719B6369D034D1671F986FA789F10BFC660
      8A9550AB0D904A11745138F4B2ACC38F01F9505560F5A17A24EF61A275E8A41C
      0BF2C48F27DE7DA258E7066FB0B2347D78ED17647C9F1523D5E8DE2C3749BF0C
      B32C1A2752CB4BD3A575A53BD55AA5E414B8B2D3A9863AF1B54941875B937FEA
      1A038B4FC2BB7B1657ABDD379A8656CFB22E50A853822A57F13C13C47FE1DD7A
      DE7AD2D46F7D8546A518018485BE240386894052C744ABBA32734783103DDEDE
      9643368DF398012FD7F69A8A4AF63D1951654CD7E8890C22C7D6B284BAB081AF
      C11ACD273B0E9FE2A5E664C5D5C850113CA764CBF545C28559252E232BAC178A
      BB99110B975A44D37D87CABC574AA4D2948E2A7806F79A4F92023B3A1DA633EA
      2A33AE27DA5DD03C911345CCC69620AD5333C1C9A8E61CCAF8081E7325B8FE7C
      B6E99032A82225F38C41A283E769256A3A16653A497191A8032383B9A6A12A41
      26A5327C68D420CA6DC5C80301012DBFC95466ADB32A4709D2AF5BEFAA1337B8
      0996AF2483E20080B1389DD5374B25D135F31BC2FF62A4A3142525FC54EBD7F5
      ADD30FEE16CB9633C50C0A42B8AD02370F3B655A0885082429E6F910DEB08214
      4FF6F61E711D4EA18FAD65618C8FEFCC233F365C94AE569ED56312002DAEC306
      5DDD8BB038C9AA171335A2F80B7CDA5A0E1929244EAFB350F5E016C2D4736AD7
      E275C162D489620EBC944F6D4EB0DC9A632C1B08394107D8CAE8A1FF7EFAA080
      44FC1C1B07274F6BCE370F84A9732ACBDB9B247267AC35CC88557A3097563BD1
      433BE7ACB2D1AD4DB8208C0EB3FF544A3BA8D3A9DEB73E8AAEC0C2933076B80C
      A6B8CC0AC063953B8DD77A56BE5DC797F02E692FAA0A57206F94AAC690949B50
      42CA28FD9A8E6036342649DDD6943A90EB15B0E176307AAD6B31F0DCA87C0F60
      24892BE89FB13674EC9340ADD975078CA45D1232D072764136BBB934A170FDE6
      4BE9887A3A8F0F4573800FFE907043B831591FC35F2C9DDA9075E4045B695248
      5E696360A648DD6CD7562FBC81635F3911EF5EB25F7CFD2C9C3245E6C52C726B
      B60DC2DC55A15BB0BFF00ADF0CB580E29480C2851D0381BD24A3F3F1643D458E
      521E4274F0FEF65307B535F0BAA5D9EA8EA118D607EC1C34BBD4EFF73B8DFA94
      756B42A9828C25C647D0EF3D0B5408965C3FA6BDA91253748FA5D1D6A9322CF2
      4AAF108D98984718AAD73A4C0CC94D331896CE50764F828954AC1672125C0E0A
      251854A9AA57149493D18477A7D42A5A6735280B551D3D73E234663175D538F8
      0ED361C617D3FC96EF8566E1E0AF0B3B235E3D2BBDC0486200CF975C821DD19E
      1A27CADADC828128AA4C8C9B74CE1097899816067B2E1CD5E076D9EE73C00FED
      52649AA78379ED582BBEA699DE01266ECC4E51D8821BC68E67C14F3C29451FEC
      15A87C9E1D00C86015F5A37D9A3BB88E53E8E84D1AF0865B3DCDA56799A6616D
      8B252BCA7D4F38F59B1F1EADE7AC5B98ED667D156EE3DD35868515B083C4C38D
      AE11D80C2D0452F8FEE1223AC9510C6E23C0519F21929CF3198E09820FED3519
      7D171D88E0FF475400D47F1FC27858D5CCC18783563FA963691CB0A0918BAB74
      5C7F273D371A736C78B9A8E8CA51C2A38C469F7E391D4BF44246D1D9B36C9AC0
      C1D2C7ACF5069AD81FD0C20F07F62AA304065673D00FF9D93A04228CB3B0878B
      4AB8363C416825D0F8F269250D4114C18FA8B91C8C46258DF424C7F63A55D7D1
      8F4610F294A0E6758C640A53185A0D77C4C3AB26BDC4ABD90071DC526BD7A180
      BB4C2EB6C50ED9CD40A759EC10B8788A9B698F5DF8C06D4641CDC882DB520F40
      2237BB9191249A3A67AC5AC5416838EBDBB57551CCCB21B2FCF6DB6770BB31B9
      911D1AE0E183266752631C3208EA8D8ACA7C30B6C1B8EACB0AFB342001B369ED
      9DF564F981B5E9AB1E17E540FAB38B8D11BE9B8B1C0A7016A22A697E8F991469
      D0E8F45C9A0410A7AF1EECB5703F8502BC7E4C35A8EA68D20BE3D1B2235D528C
      8D7300C50B039E21B25BB6CBCBA778A7974FC3774AF2515C5DF19DB470F76E9B
      5BD0940474C0E314D85C09BB28CEB2FE562DA679F41A5158D4FAC41A2CF22A19
      CE1B914F5D83B04F107AA0A27C2CBFEA47FBF98D8BA8B82819E3BAED41571A3B
      9C6C5B19EAF72E3E89E6C3AD4F3219BD5B1E446941678ABB8258F228A718CCFA
      CB3732BEEB2D7F9C807624486100DE1734DFD4BE11468ABB4128CFCCEB0DB468
      40FE2AAECDAFBA7DCDD2A5ABC53675DC9AE0192439A070481A998DCF2405A125
      665CADBD6ECDB6A4F94791214E29BCE0A4DCEE707FDFB073DFA99DAB6C1B6717
      B8CB57A032CDFC0A4519C2D3BDFD377D4817DA889547D65B51C74D7BCC8EBA8B
      9F3817A36C37B6FBB539EA15CD6E887C88B4849ACC593A1B14ACF7E1EC7F9E35
      3487F5FCD0EFBE23D56C5DE9A6A596F2A2C9CB40646F9923E0045A7C9076C119
      B8CD380D6AB440945F527FA6C58845233583B5711806D6FF06FA9A7C35434782
      46E1F3B6018DC0E37532978DE86C5DA6930963F3E618E4C935C03D5A5AEEE1B4
      5D9A6A9DA28BB62C8CBEC25B680DC34AA0A1FD5D8E778BB2D6C879F046E19214
      33F7B00D64C6B8B92DB12DF0FC807786C6A91B1E8D41AF3DF084C421AC7B2131
      5A5286113872E6B35C25D96A17E71C00F3C2007915DF5BC746BE23892BB4059B
      22FAEBFC210577681D2D6F5EE5B4078984C160AADF668E6B0AAB46FA44C3A621
      D7BED4905909F169606A23206B1F1614F650E52110CCAE9F55B849C0E9A20E23
      53B720492D96FEB252F5EB151617D8472A702B856F6EC7A7D528C3C05A713BBD
      17BC456847271744FB10845723DA858D205F13D0BF4BAA7696FC3E5320BE63D0
      A7DF7D161A78851F78DB410E48CA8D0CE6D1CB65A78418B3748B9704B16F1F52
      5252CD5B7F98D1CCA38E105DE935A7F91F3BAA2124B7B0CCDBD7F0BA8B378C19
      D65796EB97178207948E28164273071F0E36B86255A06EC90A70C3E2BA174455
      AC83B7348C3E87AB633D1EBC89A17355146C4C8C8D468C4744B1B5DE94F689A8
      8A33081CA862F4AE90257137B2055E5CC62919AD55AD6D7DBFB9BA70A522C07E
      1D40841E3BF1578A1B2D031CE26AF1C9DD6F3B7790FE9D4326A2FD8CCEE6CCA9
      5B1E20881DB58F77FD49E133097FF9F6D95E62358DEAFB7E74A0189B8497E834
      59223AAF5C5108A9A08B272B398F9EAEE7B1DDDE375E1F2EEDC6CF434BCD7E69
      6C4682310BA3111E32B7D8A43D478168DC6CD6287D50BCB9243306318778B0C1
      CB0A8D5BB1FBC597A448AF168E345475C96B50799A3413F8B0CE9AB66A9ACBA2
      244B478949BAE2CCDFA5F082E5F20829FA1753D6FEEC7D103F609D753B52E88B
      CB7EE967ABEB22AFAB2E8546E827E0616F4CBEB6F4603229CCA9E4068222FEE2
      34A0704A1FE541CBA49E97920626E9C5B0872B97C4E4ECA0B88A46653C71B9FA
      B2635C1650A3809FDA4F2AC29864995BF07C54894A7CE1F2B36B50EE3A3229B4
      7AA1F140676531C8503ECC793236C06B307756EFE0347911F555F3D506CF3930
      6AAEA8263BE9252B669EA4B6801969C8A854A2FB9A648E826B0B426F3BE305C0
      8B0FE5DF79FD194BFF2E8BDD8E382706657253EBC5630CDC71920A2890237402
      7B9895EDC20035CE237E4D72DAAC10E1AA06DF2A4156A235C446F6338DD738CA
      9172DDE4BC80E963A1FB8A80562A4AD6AE6F1E206067D6D5C8552B6818577AF1
      870CA64047CBE5BA802423C12D6369B92F8AA09AD66714B288C92909467B879B
      95146D21A82882B12E8EB75CE621A49AA9F942B32B78BE946831E65B83C525F2
      6601DF5EBFA83A62D35951423BD6F15FAF63F12AA1B8622C4520D220B6D37062
      792671BAF1234AAB29B3CF8E17C42010DC4CA6457963A5E796A9A53687609743
      76C83742398AAA55360BF4C8C252CEBAEE5F7F55216546EF7B91FB7C940DAB5E
      747050ED346068248D09E0BAA47F77EADEAB188969BD0132087B4364C9061D76
      ACB8062AB84117047C668018F511556AD9BFD67243795581CE0B200E1F7329E2
      F336CDEB4E5426D42FABFC21DDA12187F7EAA86DB7D6A858F6602C15B5AA5BE5
      7CBBA853EA6ABD3007D4AA382BC40C0C75AE4F33862A756FC56279B267D56DA2
      3882FC4A81BAA1A86EE576B6382AF35C7E9344CD62A3B03B2ABF48B52585DBC0
      572BAE95CF0C4CC66F3AFDE6EAB8B6A1F36486A0539ED5295B027C3452C0DB0C
      A6CD9FFBCB3F9039E39B40DAACD5AA5346F693EFAD608FEEE01415152AAC2FD4
      8885058A3419BA73E85F5E14FF4ADC8FDD08DFF1A282072586A485777CF9D922
      5F2C51BA70D3775A8FE9BE2EB2D18EFDB6A38BA81D1BEFEA62123A4A395FA3EC
      776BBE851E89C66BD5F0C2F4F677D2E467A5B9321A635C5504C3D0F73BD42C55
      1C2FCD9B16D5C6894BCBCC3151CBC3FBC5D830C28BDC15D142158EC41B9D80F6
      8E9438A7E82EF1E19D5E749C153178C2C88BE30050555E3E903ABBBC6BDDB384
      C8C8340E15665B97FF82E3C396F6B2CEA98EBD68D0200C1D8DCA62267414EC64
      32926705530BE2CC82A8DD846E0D8D19AD7E1AD8E457F3091224BACEA064F04E
      B8CDF1244FEBF928D9816304FBE00E73282BC37046B4BBCEFF58F293A8AB229F
      839BA533DCA47ED11E0C04FF7774CE9173524592C5062D0F21C5D0A6189449FC
      45999556F29636DBB198C371E9AB03C0CDB95B09215A1175B29216B5CF19F005
      8B608618A3DDF220E429A1313FBC4A9375277047BAD0A28EBBBAE2A745959455
      27F4CE247510F0C5CA9F5692726B72748D6C855F86B57D0D0D54E28AFA3F9EB0
      22E130CE2E8B33DA277F4FF3CA7ED18BFCAFF179F8DFF2B4B588EDB366DF0968
      06F59A43C7C86E338689707A725F2D3E20EA3AB7C8971BDC099C2C1A2895EA62
      04D1174D3470B916EE073DD368A4DD2A05059B4DF0F66F14FEB645AE117FB536
      313DEEB257BD9A90904A210AAF1AA7BF28E6F51075D18D099417A35BAA40B69B
      97D34E6E4A290C64392CF20CA7C761952E5014E51122A13C4D3D4BA4E950FA5C
      17FB8264530425254665EC7D32B75B8297526119D53193A2193E3544BFC42047
      96C4C8AA5069220C51A364047F25DD37AA3BF240D425703387709DC9B73AFF8C
      CF5EB32F55DBC6CF9ECE5BEF56A6715A459D312832D4F0EB445D95E3705B5785
      7D91B71414A736AF48E7C68E313795C6F32D8098D7BD60EE1D5D540B93416A32
      186A4808BB4E5BE4D867C8DBC243494CA9E25297F3613D87CC9799B15D225E9A
      731316602680297E94A7F86ABB5603B5B5D0639944B2E969EA567551F0CE60B2
      C51CE79C816BD1A54FBB0241608EF830224C66371BE64C5134DDCDCBE6045293
      B1A87ED38292CE36A695C6D4FAA5A0E74DB0420F7485D27B48BE813B84910E92
      07C4D390139433709AC4E3AA23B3D1F9DB1C7724BF62C7A7606472AE34E00D03
      91D79EAC9DD737D1EBB84A3E70A23A4A65A65B3628BE7945621E67162F0F1056
      41615C6D9A01050E3D06DBFDAB2848ABA0F7C1D1E9296610797E567358BEBAB3
      C9E66A75CE93C27BD177BD6857C6E9CF1032AEDA49798ACA441D8117015B747A
      EEBFDE157962C37C927F8521E122439DF5C9B592C3121454B563DFCA89CB2230
      17D1A2BCB6C72CB724D8A9A609CB4890E58D684C897A3CB11161B43CA3A5E1EB
      7439960BE939FCA23AA1AEE2DAC8B5DB62AA1038F2116669F12E9E523CBC522C
      79C3928A61F0D00DA291195667E256090C0083F906096F402028F6C038DB5013
      2494F0B6B2D54BDEC425986A0D43A78835B8917EAE017B8DD50AF6231977882C
      745C531DC28496AE2D85B47A1E628C512BA5BA1228C8E1CC06CE86998072A387
      208CE2FA5521978320DF75990EBFA0DA5B25C213CECFC06559509D53DCBD3A41
      B5446B1362C5EB934BCF657F2F1B4537CD569278B1BEB83F39DD231ECF73FF38
      3B63FCDB09FAB0682A6E84C31FA8DEB848575A22E7F2DEBB7A93588F0C594BCD
      EEB9A4E58E5756EF36CDF8584A8043950C6AC8B4721025716150A96F8FB0423C
      E0D98ABC7C517CB9BBDBDDD16B055234150B3D740255BB9561A4C5F2970465E5
      601D97093C4D4B1F0F5B098E3F6BA71FBDD6546E4BCCE5FD5F109838DBBFB88C
      AAF9C0CDAC437D03E343E3947C2EDD5EE8505AC535C760155572B9C279B841C0
      55E216AA72678C8F792EF5BA80B3607AB88670832662DF80DE9BE651CE9CCE1D
      8EFF2C29A4D02DA9514E9801A5399299D92A716EDA54E2F76B1538CCA9AB9B19
      5605DDA07CA73FDD7D2D69B37A60C92A086FC6585D3466C332BC64956B8E7E3C
      4246A7668481FF62E50B92A8B33F1AE903C258E11D5923CB1AE58427ED7649B4
      AD4489C1AA53BA547CB53CA4129FB31D5C7E963D288F7E9B27952BF0EB5E85A6
      D7662FB3DA6222A1C2C73B6CD51B59345CFC4CD8B4CA0EA41DDBC5DC8857116D
      971FF2771289C87D36795D44BB273FE7C5F5DFAFE2FA647A58A4F9A41FBD0715
      482B60BA82130DC96C9C521AEA5295224D5CCB99B7E64CB65111A15841748D27
      F02FA856CA56EE5A30585043595674C5AA82D796DC46E6A1995AD26A94C32F3E
      1EE1A2DAA5109F4FC90E083C389D572327172843E316C1528424FC4AD4E5AA44
      66D1E205BBD3716B9639DFB6A2C840C09BAE66CAB757E4D2CE34BE0353FA836E
      1C7A44B46CF58FF7EC0DF28D9E05288A1A841AE08DA628A639F65E09D61B3F23
      9744623B5A6C55EA7920CDD3EFDD2CC1E9A838A03A0D7992280E31F087239632
      894D23D1B837E9CD50FA2665E9595CF312DC575B76473F6D140135647B0B2526
      F1C442D95780C3ABD9161AC8BFE59706C6B748401BC81D20FBC7FC4E41138E2E
      CEA80227FBCA975D91DC0B2F9B26E8320FD2002AB85769F0F7B4483F24E3E897
      F7A7FFFEE1D51EFFEFC9F3CF1870831E7CE69697EDFCB63234E21FDBD5CC2D7B
      30CB7013F15DF278BC4ED884CB810802C182A205097FAA6010678112A62C26BF
      10D7D54E0AC53942A3B52EE13BA15B1FEC921A4174A6ED407056975AD02BC6FE
      AD75B73F12142BA96CC3AC73F397FD3488FCE9AE238C2E71D806934A1D552170
      533E783A480824062657F26D4D12E88285DFA88A348AEBD8AEF9B07A6E12D60F
      88A35FFFEB4D3C4D9030F2EB7FF7FD5B598A225F6F90ACE8D48AF1BD4C671B0F
      28BFAB8852BB9CC9D281AD7938C3A936A522B3D3A6313A5B6CE03DBA86FDE16A
      0A6E96194123937B1E4FC39721212C0C90C5C9BBFB1819A7E8C0A5F714F9B213
      65A5A725A945B733E734C9934D9979C618AB55AA05BF589207ED3307B928EADD
      4A425AEDF9299DE7BB8356C3BE0C839C0FDAD633D60F41EB9B8FDB2F9F92F2E6
      73B404C3ABB6233A35FBE759342BC5D0777F43FB58B65EC4685751A620B16AB9
      2E661361747415A9B3019D234D1C218AB634D4E4058EA00A413E04CC79189FE4
      792B9FEFA9D34EF555B30C7F34C404A9D0BAE757BE30E2B44B5FDA6239C48305
      4B5A7CC1B0E60A59C80D99FA40EBDB412D21B9B591D517A07426FC978E450231
      AD44FDB0C126DBE935B079BA7E5401735C8B061DC8285E7664B72A9A04521F96
      7225EAADD66F2B5E43885554E334A258D5713DAF365EE8B2C27F01CDE6B340DE
      7FF8FAA6A3E1D67520536C55C4029D8150E37441CE352CE5B134D8B4C873B6EA
      1216845BD053C8A186CF2DF231173905FE97291839B341C3B11DB5F93B2EC4EA
      FDFA8E2774A2A71652B8ADEDFEFA91C3BBD8E82DD920F4A5654FF7A28F871F7A
      E6919C5C9E75A22AF96D4E449FA6CD4CECAD67A2DDDF3E3D948AE23C7D992A60
      6D08E90AFCD65426EBBC3EBFB8787C7A7E7EE90229D18704D86B239EB2F22565
      6D8A5B25819326477D5EE6B864C651E782B29F914445AA0E5DC12477E804691A
      F0E81D69DED935279767ED82B5A2BA4C95ABCE4904573E822F1F9D3C9A4674E7
      358C83460CCF31D249741D97144A5C032B231C8651172C5A628472ACDB601DC6
      D728E3538EC8E663AE8DBB51AB620E5185B4CC0150652366644BDA9FF3E23413
      DC4E1E0DD36103E4A0AF456955CD5D6179134B0F40FC67FDA7FD279AF8ED10CD
      25D4F805C4659C7E332FA89A2786A8A857006FCF547D82FB0711C5307BC4919C
      34D06E54282F2FB5786E99D25051126962E8C451A3CC73350D3659D3E462071C
      5409A6831E4F9448B710EA2D6A50BDC924585F46A119050E7B2EABDA4184B3B2
      18CD870425D3318F14C954E26DE011734CDC34CEE14F4F93FAAA18E172724AD7
      2ED2AE471F4636F873C035FF7828E50A14DA3BB93CBB03330C25651EE58F0EC1
      7A625DC5A2E1E46DCC163B594210B3C8423BC273AB71D9681D406B9850A05A58
      94F96E9C5F006D58990CEC01B34C69ECE78CB36C3E18675039C0255FD643DCCB
      50A0FEB7F974165D16AE3CF3C623620A4622FCBD8C3FA76FA45349352FD79AE5
      45DED54F7D177F456DB22B68273B58F0AEC55B7A084DC5BCAE9391ABD1867F82
      E3057697BA33815198FC86856CD9C6A6771966CABA67EAC91DA67C38F729D7FE
      FBAA27721A6BD34845623C68947CF3A107A147524D52F75B3FEA7EB038D1C285
      22E7076E1C0462C7E3FE0E523DD1CEC1CFC488B8DCE241CAE85275351F8F59F2
      2716D54B393702BD9356BA46ABB3AD2AB965420A0F4E77159E0E62068D9F5BAD
      52E5064D7256F461742ACDC12711843D0F6EC277FB9FCEE416E4E2F1169EC8E6
      F6A209A018E2D2A3B9AB0AE8CDCD7939C6E5838440A1DD508DF5CEC57F7A52E2
      B14C515BA118237655A7431D215D05BCBE88CA87F54AF1CDE45B342C8A7294E6
      E49506677AF00DAD34B9AA671F1663801E1DD0ED21C03C234671391220AF1163
      E6CAB745B92652B43C9E2D1EB79D0297CD4DC021E1AC7507450D62A4EE83D666
      69C84B071B311850D9AA3B68F29F38455C00CF11CEF47B41A4A627A266640EF1
      4D95CD7A074CD2D097AB794DD6ACFA137C91720ED1F80D6056A7C71A08953A32
      A484335D8A307E815411CFCA600F7AC187880DCAF342B1B416BD1DE956653AB9
      029A51E6B0AADD05EE3AAF40863CD765166B7B0D9C53E564B4EA7D129DFF0CAB
      BD6E932A20A2B89E6C938B784374054E7DEE0AB758FE8D06AD8351EFADE8A828
      58B9D9586223E11A4EF3F99DA24E2E65B02E1023DA201332FCBA8F9260B85953
      0D605CA8E4F4F6E4F2ECA832485A3F64F6F8C961F4F6640287F912069506FE8E
      E410DE890609D4A6D66D5437D75634427D0B86F99910D2E5B11D0FCBA2821241
      B544CF67F5008930E728C9EA58A4A0C5F65B375CFB5127F80D1D2C2736A218AD
      AC024DFE6910C278C0D9CE1924F535B98CD785A70F40E95DECA24D5C531E693D
      AD3C19D4A385A7544A0A56E72C016F9EF0AAFAC67D50B310CE94C851BBF9D0EF
      0F6C65FFD2BD05EDD9C5368C9D2A5960A53313C3F1763C2A412D4DEBBFA9D9D4
      921AC75F9EE6A3E55F5E0D65FAA2C26127844912085BCB6BB576848991867C33
      38084137DCB80941C9A662E542F31B2DAEBE04855892B2FD8234C38289692B5C
      89D16434D6A0B18D761AE7933152041A66378EB6D0E88A9B2F0624641FF68265
      1064CC132091D27A73DE894E99A8FBD7E8881BF8625816482D16650EAA74F86F
      71B7A028E29B64F805A1975A16A2DCFFC1EB419F77AD5F382C66049EA47EB4BD
      AF97820B5E81C32CEE5E5C2D5905E458D07071F995A665D45C0E2D000D0C1D13
      05442CD4BEE9F46AA58B4ED839D05F5465D146E346D1491DF4D56DBD4469B8EC
      C9E5992FCBB0E34F1D2C9AEBA259CA8909B722FCEA7CF04DD712479A016DB1D0
      1B9B0CB7C35D8EC4ABC57369C36D2E561E9A984E25CB81CD2C9C3D95323A31E2
      6A884B82AB6243765AAC893B9D3ADBAC7D8786975530B85A0269A3FBAB4D190C
      F4EC20218ECCDD3ACE49F8D6A3BBF58A9214D0D0C26ADE2EF253A040724D3B6B
      48C373ABB3B740F0AC44EB99D378568CF639A067C5E8B502EFA24E52BF4797F6
      5FF7E53B93A27601407C0B4FB8C69B90DC3801960844085180F0D74EA27093DE
      E9B9DB1C93708161C3726B06DB511476F6F5862B13895ACAFA3069FE57FA9543
      3C577A46AAFAEB5EEB5D377346B48240E8934C70CCB2905B63BFA479D8A64B41
      34FED78AFDD5604EEB7965E3DF7A75436413EA8CEC0E6E765DC498279CA4D889
      86928C930C60EB73BBA3FCE7AD75F077F8DA4C55D70822965EFB1C700BAA31D6
      3C4495E3A2C23040A2E0A6E2813CB9C2818297B7F1C4ACBEAF43A976C79F9F97
      740A98FEAD69D5804F98D821E726FED2D5B4F9625E73447551B54F9B9D259573
      487573B5ED1D288AC7AE3F921101F0F990F32A19CF33D6EC89B1F525D6E8C222
      A2651B3C5F3111D3FF3419A7C6BBAAF5EFD1D44025D498736614694D42F2F28A
      494200102C10CEBC5D60ADA77328DD406A2DA2707CF47C17188BA93BFA681F2F
      6B0E5AD43D8B1DFB4F9C332B081B18E07A8C8609EA3E4C1A9C245512BCBBAB2A
      635C2E35CDAC44507FF352D8663C8D596DCDD3E9036EAC3799564A4BE24196EA
      E31E8327371E111633ED01314CBFC619232E05876D93262495A96DC9B58B6643
      7B18CBC00582AC1482630E55F354B044236A415AF94B635B366B09E0716E9185
      22CD6AB33230B3F1D0BF263840D08FA529DE26D9AC17BD4BBECDABB30239D06F
      D2FAED7CD0437012872D257ADFC77599C0FD8F27AB7524ECE9B7E51EB6A00F77
      EB2372739DE62344B9A563DB49EEE26D205EEED53739CC4B58369B3ED18D8CAA
      4EFBFFC660F8A7A3EA14302D576838AE790948C01E913EAF37E2C8FE56142AAE
      B6EB9CCC55B42B778E2B4DC19A3D022BD488588E20EE53CC98921D5C8AD66F0F
      F0492C51626E5B7649978D8E96BCB37D5625E5579C8A1F9238DBE5713664B623
      6D681E4CF27D49F3C3EDA83D0721383A02AD03A116987F4986A49FEDBA68AB79
      373ACAA644A5CAFD8F8FAAC62A0F960DAA259576BA48CE4C556473162304B026
      19FA3E565CE413C477A3F19C2506C3C1B741DF7CBBAABA23191A1B0B4DCAB2D8
      30B7A0190E37FAAFE5DD2D75DCF30D5A70D9BE61C4C3DF5A9D43327C7D23BA94
      C57633E2ECDA2C3C33E71B95A47A6D0D95A606B49750D136152F350DAABBD434
      D3B3E0F71CEA8D1AB9EB68FB53EC0F1D70DFECEA315F68D79D9DC052E05E4ED3
      BCF0C3D465A2F8F3FE5EFF5B2F7ADE7F8AFFE9F7FBB038B5FA52E5884666110A
      34C753A86B82FAA919EA2AE1A3EFEAF8516EE50BB6CDC2C341E2AD30D85BD3E0
      124E3413F40E50AE1D48653245E0B16C0CF26A28B7AD21E41243AFD2C955C62B
      187DB216643AD6CD02790C327194CD4AA985A4E3C9961469700B0F52982286E4
      906FBAB94AA265E14159F74CBA5E9FB90CFA0CADA412AB07F57BF2A2743CFB56
      FEAF156D73DD4B03747896216EC509B251C0F32C78352A1005E49FFDAA85B59E
      94D33897EBBBFDFC95DDD7E41D8B5CDB85E235E4828BA21F1DCBE5210B903886
      1A9E4805A954E907F6A6EB6F324BA05E236B4DE4FC1069D16BCB815ED34272F0
      8022CDF3B4BEB90B0D981487EB7484BAEDA0DCAE9BAEC55F445DD9601C37686B
      2ED3D55C109D3463D28AE4AE53D6CF326D5A2DD118E7453A9D4FB52BC538BA8A
      33C59F3506AB7F6A903D75CBAE6ECCC9685A6AB59214B6B3602FAC3B5211C848
      B196D566D5CE37E97573F85D612AB5529DFA07D115496617615B49CCA493EFBD
      3F815EB67AA5E394A9F76A12D629AA262B5DA61BD2BA777CB257F3F52CF40337
      C1D50EA1FB0FEE876C44ADE6368AE229A5B3FDD8593A221BAC5248822D10386D
      5094F6A1AE08E156FC62FBF7BEC4DA9617774B4FA80F9EECBCBC2B040C45F483
      1BC47B0D4EEC238FAA61992479E30DD98C2C420744365A10C63163140B91D7BB
      BCDAC51408E22E10A8012813EA55B8B7262743A6BEFFBB0F80DE4EACA6ED1B0A
      5601D55E1225770FB3544A26041D6AE81CE70B3FD598FCAAD54B35F3B2E0A98E
      8432401B57E53CFF82AAAE4EC1C51E8A770B32695675E9E1E67765A611BA9217
      9E9543E61F4B3697C5F5DAB3BEB3E6F7ED4B5ACAA88E1E3BE3A92158B05A8878
      032A03A3C6DB1DC127A85D28C5E145E3D6CB37485ED928AD28D200863862B8D0
      E0559A80D3E4C281272C7ABCC1EB244F27B9FF6B81802B0C7D4CE37D6AA8B1CA
      1E768DD1DC6FEDABA1EA921A2F559DB5F33BBD609ED825F9AD965053E2C6D61D
      5C50710F321B371CBF3393B483811DAEB1B503B93EF393966292C59A88CACC1F
      E62335F6918B5BDC31EFA9A1288FDA17613B9F5C3BCB12A27C0E8931F50637B4
      A8A75532ECDCA62CAF73F7FDDE7A005D79E77226B22F22FA45C39ECC1F914242
      1AF092919048FD62BFC51B1BDC44572AA0CC3D2D453483AA9B5F921B0AEC72EC
      9D9A87785CBAE9A54F06E13B1B279E32970E5F4A17B0CF56244F95A6A1D15C44
      7B66B2CB2B3B5D08424DA81A671CA5A62E812977D979EBC4206DB7C9D83022CB
      A1D926F9783FC30911E3FF4B59EBB28C6F1CF77CF3AA05EB1EB4B22201844637
      3D5C7B108F55C01D4D543AF107452E2A06D58E2F4D81DEACB5DAD3494E988C80
      7E6D4202FF6BE58F0412F8168369DB73994D0C8C703C804DE82CF1880993A250
      4D990502B4DADBCA34A3FD287A1D45AF57A2DF51741045FB2B63B7ABFEA85548
      6C186C984315107479D30EAFE9EABAB759FD1ED1EA57013B575605EDA9B414E6
      4CD73890A119F5D74672A72E1AFA6D5D595F3B3833BABA867634A4A0A6BAAC6E
      AAF373299244BB6CB1ADD8849AB1886DCD13E7728373FD3C942D8D07BD4063AE
      6149A2FA95E5B20F628DDB9978E306EEE509326B9648240D6EA4825E9C8F1EA3
      DF081AAFAFD3182416D26CF802F19A4033D2C4DE34C741D205312E12ED6E040B
      645A71B3E30AA1990E235FE45EE8B015C5DAD466191ED859EE2E669F78655CA5
      D9A84CF25E849787808E44DFA5494800E9C7B809E425A8DC112469AC23645E16
      A6A94951390F5C7D496E24D3795E6D694522B7F81D96E3FFE500DA7CE91420CD
      6BBBC7D6D9779FEC899CF57B3FD2C9E982BEFDCAF574F7275B5CBB3FF9C6767F
      6A4AF56ED5625051FB95D81CD6E82DEF85DEDDDEEC062A355A00446699BC5F25
      B8359EBAFA3C25487C865DFE71F6187D8FBAF0507650229C5C7BAB19AE7FB435
      4430D92D30BA809446827F58C73761B15374546FEA0DAA45412FC775410B84DF
      DE2AAA77882CA3C26C728E5A73CB63084110C1EC8B633E32AC2EE912E4743C3B
      CBD4CBA5EEACE625AA7DA706B8A3EE33C762149A8ECC95162B54FC43BCB3BDEC
      06434455ED7503812FCD6E1DF9F58868056096A261486BCFE24122856556ACD8
      C5B339F869D7C727EC4E5CAA922D4125E225CD6C16830A846FE370134B31E258
      DC955F532659F2154C36306C02C8A76DB4E4C17A900ED43733A58A62870B504D
      ED7C47A322520D11478902DF7D1E541719DA85ACDA8DF31139069AB4A81C5427
      3127690D9D5F0E9364F659E42D026D81C7B0A641AF58C798A7311C2444C60B8F
      EC369EA9AAA7EED9BE788E701C5B1458D8C00EDF6FA8A4C441CD1E26C0AAE9AD
      62AB0A2BC5D1DF3F9C1EFEBFE6BEB4B97123DBF2FB44CC7FC8E64C4C516D8AAA
      452E97E5D7DDA1B5AC676D2DAAAAFCC67674802428A18B0468002C953A7AFEFB
      C439F7DE4482A23640FDA2FDC15192482091C8E5E6BD67712CAF9CEF1F9C57BF
      C7A7D68C2459092607110089C5CAA4C51E7DAB2F393CFB4F5310B4F2B7166824
      D12AEB81A9C2C8C250ACBA63C0EC95B77C3F3D0CBB8A88D81A7B98D3C54E7896
      50473D0C1809DF024B2E1A64453CE2C56AC64F32086EA960C09ACA0BAD6AD27D
      94CF8A5820177A204CB1424E67B6FCC50A6B1F4D93F2C675453DD3E47378AA16
      C684954BF18EF38C58B9DD9FD6087FC3F05CA5A84E062326633CDE7A3C05E530
      FD3B94F240A129C2A63E34A1EEFDE2231CCB14A38558F01EE12B3D610462EA2A
      3FA51963D8152DF9E189D573E6470F772B34351897DD3FF931140A72E038EA55
      0FEB2A5602DB67104CE49F7AED422B082C44D660B469F33C9E24B7CC0F978E24
      9A4B004F73F9D4000F46F35F070A47B6DF211EE1704F361C2C3795D69DAED358
      F0436B6CB5D0B025541D47565B80ADD8529864C18DBC12E14D5C56BCECAAD76B
      1A8F2244410C5EB55AA9E16819DF8F14FD24520A5B72FEA979689F9C5E98E313
      24696A4A4A7A1E9A2958AD3A15E9FB909F12935A0365F309142DDD25464B1B8F
      EB0A14EA4B9CAB7C40B557DC3B6D6E7FAF53B17BC34497B15F4469F8CE76F80D
      EA5122BA27012D084263B54EC6CBB686A19F2B76499895F120D75AF7EAE2FB18
      58C2CA2EF812817A2A8AAF140C97CACEED36D46EA7441AD50E5FADB9CD94F188
      5D55D3FDAD54B5AD25B048E4D8335F3860AC2F13E3928CAEB24488CF9DFF823E
      8470805506E624F3BF784C1F68EC5355006E536DAC0B563E54081379E0E9744B
      6678634A17B51E64325FBF76BB194CE8E0F3F7BF88D02C8F67A34704FCB22C13
      7FB7BC89F4C8CAAD856B18FF4F9A86AB5C1355822460CA499E62C9457A12460D
      E628224FAAAFA5FA820AE5E9A4994E973B4A4DBD2A411DB98E34225084BADDF5
      D6955253FFA811C1AE460412E0D4E3896C027902F422238F4825B0C29EF535BD
      D90290D327A4DE845BA45B3EE8B618F0FB83A3CEE3C5E321B257DCDAB8F90AFD
      06F767F7BF0F0E0E84B753C219504EA6550840932B0AAD07DBE27FFC895FA342
      3717854904D7B110365F66E883F4A6667CA1A3F8119CAE7FCBDDE9DCF4B6FD3B
      C9B3D9C3646B2D28A9F97565D2684F555C4550C5C024F051657084BC3FF6E37A
      78D758F9F7ECE2FBE5762B0BBD48CC2D3073C976F62125B53728416E9E27E1EA
      25EBB2BCA927D5F9DF53EB5EC46303234E74E6E9C9F6B1CF8EDDF734EB07C9D7
      33AC1D4509F5AF8DF593ACFE1BBCAF75C9ABE3A2F201FB29BCAD29BA88023F01
      204194EF150398E3409FCF8486ADB86892B166FB83E364F23420DB349A4B6C7C
      622AB996C9BF3FD2092475ED0B2A254098D92FEBBFB9E26636CCA6954F4A0048
      1CC98D65C579C098409A286AF9F1D7B94ACBFB3ABF9C7102197CD94F2DF3C295
      8EB2744A9F932A2A3DAA6C3FE7BA061F4E894970CACDF2CB8C36D4B5A234EE8B
      BCBE0711EAF8A4C077C6D148FB10ACFD79DF7525D4D73C8F29E9A8251C77292C
      B3636F56A492CF555EC83421E50FF64D0300B3F49304CE2B5EE74B2EB8CC435A
      91B3B1ECA21D8425C14840AB17EC58A760C724CFB4D2ACE65AAA78612FD25E8E
      D0C8975F07335F950ECCB2A48CD9E4852F0BDBD0745A2967F3A3D015F1574138
      899589926096D6404E538F76E35B2FCF185DCB68BEC7A8CA848748EF89C6E7B2
      3E08B8DD324E0385343F204923AA7F5F3E1C7EDDF7EA8A0B90576977D069A19F
      9779C16B7683D4B1BE5C85722BAA50B005E8E115F7F09DCD6B09FA4FEC924511
      BE760D7B8EFBFBB0AEE9EF4798263F7F59FFADA795AB907F59F5AC9FFB92151F
      8B71E2F265C67141094BF52FD7ECEF4B39D687A556E6AA24C750AC84E5E8D11C
      A96C850B99A81FA199E1FDDDAA526E60BAA4D57B34BB4E971579B1ECFA0940F8
      132479242C73B2F7065AEB0F02D3EADFEEF86977DBA9C44AB515682A0143EEEB
      C39008338500A12A103795D1F317CEEABA1666CC054DD31C9684AC3D22FEA086
      07DFB8574F2966578FA3DB1A17842A35661AA10FF59CDFE13CFCC0EBD0867731
      85B1E04814A4E18A5BCE58775886DC25AF2EE09A1AEAA8F235261E427998B536
      69E6CD8E4899AD4D941BAD9A476B50DA812D5F017F7EB219C6D84DE278CCCD50
      33649C6D3E43762F8A726FE537402A496445ABFCD3427FA45067BEA74553FA6F
      9001C38308526690EE0ADDC23462E9882FD12FFE86BFA9D1A67CC5632DD24C8B
      33F617BFFD4E331E31D564D91C9A8D262F4DAB4943413C27D4C6D761A1A0EB51
      B4E499108AA43DAA6845D4A670F0F480673A2558F797BB170150202590591152
      A726CE75C54D51C633A42A1F3F20D631DF994E05D382431594541FF93E34F7AA
      EF07062F9650F3D3F096218A6599D2B12AAC9962B797F7260E19A75759E66BC9
      E640DC9AC12137A4E233D4E7F56E742D0CEEC7D0658584762512EEAD0E9F7042
      8966F111740C3720EA87DA0D7EBA1F9C157CD012141891079B837D5BD5CDB9F4
      E15C1AD4FD35C951D4F8D6D41854B141A3A419B14C333A15575F7F0106B020D3
      AABF87A66DC68F5A0AB6CCE0BAEA8DFB01D29DB3A8BCEA1063645E9F95B28215
      C030C31E766FB35B43D856EA92B6EEAC58CDCD5D2E49F549EF243C060517BFB3
      0496C28F3598AB677F6A7C6A8142FBF3230700DE18CA07729227034619E9B29E
      89DCA2556448BB7A40769953135FA3D666353D97819508A051C58C8B60367BDA
      CD12EBE1D6DB4ED24A175C85AB55211A342F79AD3BD1E833B28F3484A1D5DA53
      B300B70DEB6A02AEAAC6FDF57EAAD7B65A98577AA0ABAF11ACB3E67F119C2643
      BD4CD3C2AC341DF89A1E8AB5998913F98FD0F5D29B1B898F5790A582B5A02976
      AB7EA946E086D009FE8EC2331C90D207E6D0B6243392919BC5684052CCAAB111
      1454F5AC87B04A51CAD9C47BBC85F1F2AA2E82CF9697A0F0A221B7834C114A4A
      FD297AF988A3637505E0A3526122DEB9C27468BDD237550F54A270AD21EFCBAA
      D45749DC51102751A99DE65DE827B0745E278F012E4FBEC49D15FDA48F460026
      3E5EB88FC7DB7B900F9D431C56E4A5D8199D01BDFF3A08AE3ADB8495661367BF
      144F55660145E92ADC4AC9637DD4757AB4BACE5C940F9332471DD37456816184
      382A2240C4D0C8A03C50DB5CADFB0A7BBF2E1E720D4A74C95C6760F0C46128FD
      E1501560B785174A28BC68730316757FC579B97C70984E327F868AC565A92E6B
      CBBAC815692685BBB9B9B9599FCDD6C763F7A188F32DF7D51D426079CBDDA0F3
      60D0EBBAD881A653F7F209C7C50FDC28B10D65F9E11E41B3D3E85255FA459434
      95FAC603EBC9B2BEF0C6C1E9776FDDFEDEE1853D655060C1BA5341C174C78F2A
      AACA3C4FB25C0B2AA3B9372FBA7FABF3891E4927D6159B7947CAFA707385576B
      4D922D5CB922FD721F1A2DB77485D462CC7A2C701EE162E8C5B62D0904936D2A
      A1FAA793731F29531D5F48B353987DEAFE4CBD6A6187723A74F02A7CC3BC338C
      757792061D5E535AF27DB3DC333C0730D15EDD4DA8796A08B32CB9C46F911022
      914D658FC0D6D512A23C7C1C5E1C3F097BCEED9D1ADB12C24765BCC13BA36812
      7D891FC2D9AB60B45F974315A53BAE9C14EE6F6956FE2DC84CCB0C0E00205D8C
      7E396423AFBB563724B53EA8014AAAA2CFC34FF5F82ED295097548A0DBE8D87A
      7E8AF5ADCC08719390BC8A52BB40BBF5DCF6EE8FE7720AEEB9A3ED93BD9E3B7B
      7FAE1FA6F435E4D37045F0D06D2DCC08ABEDAED5FC420B5947D71E6144F0E1F0
      2EF701ACCBF507C0A52105EA1F2408F115A2812F3DE850BA5DB3020F6DC08533
      C5AAB75466C898430134E3E6F38DFBDA73370FD2066A55B30A9C5AC4518E6C0A
      1954D5CB978744555DB48DEAB812999DEAADC97182EC82C17A44A48F71BC241D
      EA57D53067C29057C268E13EA571A012FBC84D93A7DBE537B472A078DD411D30
      F50DF441997A5C53F6E0F7E77BAECB14143D2F4C0E8FCFAB0B6B9DC7398F7341
      6BF6AA55E98E6EAF156596013D411753BB248842A19696C95D8A4770BF344CB8
      6FBA492DBD1A652CAC267A0F4C0F2F9E82EED753870F1D393E606DA069F6A8E4
      F71E7F2614D8026DC48A2C380E4A2E910151F8027D07CABC178DDC272A3459BD
      41050A384868246E7D2425197B050FF7F2BDDD0BF13DB16D562D9EB208EFAE88
      60DFB5AA3DD90B57010644FE0FBC6A48330BDD5915285B95AE95E9042A12E6AA
      8A3CCAA744DD8DEF4B5E0ADF819CFEC2C13A5CD08807C283E1AEEDDBCC9DBB1A
      41556F8C1349E5D17246B65EFB938D1D359EAEBE2D0B122799CF551BFA2CD0E6
      147517EB21CC232672F1111993B0E0150AA89701D5B96B3829410B9020A57513
      3E31BE80650A7F01818A35EFD28B5AD707C71302DD6D3BEE5594621C23567072
      E98C84248314A2C4E67C810480C6940FED01773A3662B82048C7034DB0984E93
      822CBDDA5154472A8DC027CCB72368BDDD0C593ABC427AC5E634C149312E222A
      BC2AFE8945911606398E48115B95C3BF2D691500E60CD6168994350093BA820A
      02AC6A9A68FC91DD002131CEB82A02ABAEA844935A96CA2A7A15B393F9DCC59C
      F5611AADF45D7747101F7403ABA1F4031841F5E0B24ECACC57AC481DB8770D85
      85F9FDB57161004996AE9E0B4833F8A8E82ABAAC401AAD1C85F88BECD9D5CA14
      2E6B6C301E0DDB509281D9C085450BBDB757835A167249F2B7A261DE51600A97
      36ED63CBA233EB689716AD32C2A7310264E51078007889419ED2BEF188EAD653
      DC1BC45CCFBB3EA955D3AA84EF63002BAC7FDA25C388F691D7B62AF01531EF14
      8E16929A5E620E6580613C8AB04B40DC349BC5F4FEF31FACECB5744ECA185D86
      F6D4CAD84693D12376F2554102D556CE8CCBE37BF5E874EF7D25FD7D6F4623CA
      C95931E1ADDB194BBD1632B24462C00D070E3D59FA8747B7875EB09369269365
      9E419B4CE42EE15F44DF984CBD58EE5D988FA516A768329A1A59F0AF2FC8BC6D
      B0298A0DCBD26D35CFD8F54B04E2C193E8A436B37CD25A1D5BD81163B0AD2A8F
      48AB0B0637164780FB5348F73CC275CD93261B21CB6765D57A4F21A3A23F5684
      8C47508F91BCFB9CD235FDF6CBB8FD2ABC2182492EEF60252CC6916411589516
      B0F7043045CBCEC24250BE5FB9B4DB4AE40D7120478C40E232258088B94E2EE3
      3E8F8A3C902458A2F4A624CB1925737C6698679F65CD14A5BDA8A06AA94C2D3C
      2096565028B0253EC1F8FD5326468B44501C8B5DCD4645ECD2DF607C9D7F482B
      21C6ED69C2349BFBEB87C1C5DA43A7A3A5CCF252258CAE181EB7C4042B65ED86
      E1A18C63C36E7E34B8707F0A6A27D29A2F05FEB43B707F22B64ECB97E1DF8EF0
      B7A34CF315FCCBDA1D47F9E23A59D6DCAFDA683270D5593EEC3E49C5D63BD0BE
      7107AB09BFD3FE7D3233523D992511CCCABE81FD1F69D3B76DEA08A4612FE5E0
      2BCD033958859235D96C980DB3AF66A8195C84337D9ACC9272D9C14EAF62DFE5
      AB4DEFD626105DB028BDD19163905CA0711F3EC9D60E1E7E179726B0F019262A
      B465B73087BD3BB81474BDB16BD48B5058DF68D021144AD71DD8E41F27C528CA
      D1B1F695AA5475FF2ABA6C6746794E4871FE773C48F808C25AC8F434E88F7B7A
      D7F071F425A875982134C46ACCBB340BAE53BFCD5ABB65A090F151DFD947D900
      F36E6A6416D9153D488576C4E1890D52133CFE2D941F62A9358601BA342FB35F
      5678B9DE1704B00D5CC61F3917E93C35862AD1F6782C38E8C3C9714297B96E14
      2395BCE50EAF87F8C70F2E2AE423F80933620BC7AD24BDFCC145832C2FE58FC5
      96DBC932DAC8FEC95D80A8FF03573B2555982E47347543FD5855EFBE4DF2F7A6
      11100EA88E050605846396D15F48D69164D2131FB958F1A8FE612E067CC662ED
      077C410EEE06AFB77BA312A95FE0719357A384A03594F065094699B4102AB2C3
      5116DF08BAAFC6A0EE3FEE4976E2CB2415007B375230221F46FFBDF6833994E9
      17F6D3F1FD1F5F82999B9FB41EE57078B33CBC5A100F17434AA7B01AA9923581
      02C4D5E212EAE6C51C876ECC0073F1D89049C9C42E6BFEA6F2F350CA356CE1E3
      E48BBE44F762A4AA7226FB62D768EB3FDCF7A5217AFEBE0F6C6CF4FBF73E4AF8
      EEAA26ACDD7BD7F2FE84DFC68664F9A3D41EEAC6EF8B65163CE87D1751C7F4FB
      3E528DA2C7363C4EC7ADFE5E8DE0EBA1D066F61107EF424EFB281B7D5E1EE7B7
      3FF5219DF27377083B2B17C7EB734B04684ECF6102BC1201F3491AA54B7A9721
      6041E064225ABEB9C083AE13561905B7105A42229C061DAC8264CD1FD8A3915E
      FE04A3F501E46B7BEE05920BBF9CFDF6A2270B2FEEB9FA33AF7ADF569F5AEA0A
      0C9D8865AB3C36BF1EDB76D7EEACFB0486EF52D0406AEB93FFE5BDCFA1CB0E8A
      81A2D38397A8BF3C89508A955F4B8985E55A58110A1A6B1A41C52925A29E744D
      892C988EAE25C9500C503EC7A377D49DC56503AC92985E0060BFB80C0FFCCC3B
      189B0538406C23498A63219894E22D96DEACFC9A4508963362146FD740D24B41
      834BF9B8C7EA27FDAF6FBFDB74EB8886469F995305DE429D67D8D72ACA527E53
      65A39ADEE8AD5B374763BC251E62692620B9D20A29C5E3BAF955098C84B23A4D
      6FFC9D5B777BF4635C71DBE7BED9F76EDD64D8B51F590299E7A02133A470713A
      CA986006AA1E18A27985A8890AF7E1E260FD9D9813AC8FE65B8B72B2FECE03AC
      1A36EBDD1B98948C93EA60A2A98028877021F2C22C85689C2CF2DD9620676CDE
      F4C6185E640CABCA0354D61839B01C14CFE6C00400B588B48697E9ABD27F48FE
      155416B1AD8C9A9F41CAE355D3A67D7BEB55792B5DB55ACA52C0452C754EBBC2
      4AF009049938E749B248CAC50A58FE13DA82C9E1A5E2AAC36F82B199CDF9C898
      F2456D7636BD1926847FD74378D64D404EB34B8B9916687C9A7B6D7A9F7778F7
      D67CC2F6547A75E4A540B2593686C24835039EE30131096BFDF6A27057599EFC
      035BF454892000388FB0AF2349CBCD6398956536A3732406DB4DC3DB7FFFD2AD
      73CD54A95AF4212193E131671CCB3C6428ADA4A764424F47D8710397D0F4F698
      721DE49F40CD55FC7998B42F34CDD7E8FA5DBFCBF1684F3FA6356C217AE2B1B3
      11A20BA981D8241925F9683143CD64C4B4BE813935A36CAAEF121A3D6BDBE474
      B8C1D18C7FAC6A2B6D59856096E49094719D2A8CE984CA7412C2757D3A55DBAF
      4A3474FE6DB61977058D42256375AB42EB8FA2F472818478B02C28C1EE1A79E0
      6CE2FAB2B3885B1DCFA5FD61116DF487D16B07880754429EB3491F2E0EDE55DB
      18E2B1A90EB7B16E7285620B22378930D5469F03006E32F19F12D636AB07C998
      D77DCE76E6F1C479D2138987CC72CFE2592632657741295ADE5783512DF156EF
      8D364D18E7F398654C24CF8CA38C3C14571D61268BC11BCE235ADF15B0AB9455
      16A9FEE5591B9D129F49DA7D904AADCAE31B4169FC66AE18DC50B251668F15FC
      96B419A42CE5173D6A545D5B25AD61F4FAF62596DA73CE7AC9C7A58BE9D47C43
      E7732F542641FAB32E2A3EEB1B687E79D8B8AD0DAC0CA3FEAB1F5AA46532D59C
      95E51089386418BF9CC26ADBC45F0E4E377F7307104A4852F7FEE87487967779
      F6CCF7B96FC524B5F836804B002C5878D945B6AA8A88A33ABEDEEE60421B5B18
      C8DCF500CCE94A9965F7610D9F1E0595CA0C521C9DEA5DFBB3E9DD9A39CFDA68
      91290A5A4D600931A1BEC424CCA42A3C5DAB17E541598492764EE356D05DE07E
      EE86D3688925D7B6AD3CAEA3D0EB3B2A491D2B51CFBA2FED5A3C7E95E5E56881
      52200FB1845D4831D9D8D9520050EEA281B96E2AA7D4E76CD679948EB399DBFE
      589FF9D741DDE2597BFBE274B7DAF6EAE3334BDDA724FDEE596F27DD9B40D157
      5C7A3A358B19221C2A2C739D93ED0F99498ADCB04204BD798D7ADC3C6B737F3C
      BC38DE2F5C579795330A22BA1F0F4943000EC3494A1E72D638705233F7FDF987
      3353D5D5705133E4D9701ACF9EB785B70415FC3BACAC020D4D6920455510FEE4
      7BFC595BB4A32E803F02D3A0A20685DB5586353C77B1A9F018B931CAA6F039E5
      E896D569B4284A117C99358D43EF6897A16C68342BC9AAAF7B8B192174A977C5
      45F4A1CA9B8122AE276DAC904D6D7F1A02E923FE0ACA1496569EEA2681A71A37
      3505A6204A415D10820A4210E7715C80CCCFDAAC7AB64373AA04DFE2D40237C4
      AB200F07751C60DC6848A2E19DE053B2E9B25C46DB853B54CC39FDC99B43D6C4
      2B2AB2383BAF920095E7A036A566E4C9C561D59B354D51A67FCE065F0F4F2793
      222E9157DCCDA6C52E8C6454BF4E406C394B669553AAF1E6C5B70179801BF6FA
      73B66A910A2040A83968D097685AC931CA244D52FF397A598246C36147ECF724
      B95C9857C3ABD75772299DF1CFD9D42027087BE9A274DD3FE1DF0AA632958862
      0D1D27503FCFBA1AC79EE53CCBC62A9BF8BCB11533063D1668F90F4455BB285B
      A3C956B20D37024EA02095D1359B4E0E805038410A47B00F250420C02B5B3E82
      43E44DFF4DFFED1FFEF087B5678E74897480C021A284151B0BE3F16011902918
      7C0F97D7032E2EC1CC683C015C0922E61525DA3011EA192C127524B8CA294891
      B710988D479F81D2A94EBC2B6ECB390F3D05287F4433297C3C6BDF0C06FB7E7D
      F4991D35459509B09AA7FAAA16F5F3E5A1B1F6D9CDCDE71D9A1F0DBA5841872D
      D87BD61B4968E64636EAB389DB8BAE918BCAC7FDB8986976B8709B9255F1303A
      8450B2F1FFBE405D895778D6A6ADF0033327B09AF5688508C44B19C15B433FBE
      9CADC054AE52922B00B3AD2302430C09A3D16CE8A4C8A1453EC330C936CD8CA4
      A4F4FAE4392253C2E558B27CC3F80A3BB73E09D79F361BF31DEDAED828CC8B5B
      A67AA9FB92DA4E4CAF5354BF9F354428F3A9FB462205B491875895585A3163C5
      6FD5325834CA0C21E97A1023FC52356BF851B3A24EFF156906A1934B661021C2
      F5550CAA73281F7B0BB9A83D1DA22F97C21F326D556188F5EE1A00F17997040C
      DBF54A5D7849A776056321E037555F239A58A58C45CCC96F1ABEF5DE62C31ED3
      883FC1B07BDE228100C9D0CF21B4AFB772A09B819F0138AA67BB6D752CF0CC7F
      CD62524BFC874A199ED5E6EB7C4446D0CEE479DB12A6347AFE5586618D7683B2
      44A408CFCC1F5330121714BEA10D33C1AF5E21CDA496660052E0B5702FE8C7C5
      5C8E6115305378534D6FF55A8BE9361F59CE2B710ADF1F805A3C27F24735B0A8
      EC8C046F9E30D9F4BC49E83C2AAE544A7C8442860C0B5457557B45E23A5666E4
      3DF4E47CC2053672904A255B21C25140D07EE2FB696058516E0282D71333148B
      507937783BF1E41FDE8526608DC9C6AA8887481AFDACDD70CB2DC74431FE89C8
      514027703278A02689242F7500797CB7689C3903630D86B24FCBAE2E015D8EB0
      31AF0DD7749CA1907BA609260D61B2713CC73B28F3282DA6B7AF5E0C71D92554
      D35B256148302DA6441A64BCE9BFEEBFFE4BA3060A0670EC6B2C00C6666344C4
      CCC07C1DEC7B19B816D7F70CC08BBDED8A3ADCE6829015143660C5441681AF37
      3D7770F251B6ACA0F98D6EA6ECAED7FDD7FD978D2EF0F52DC098CB20B4C77E5B
      A87A6E9172AAD3BF8274372ED6B8B4F2D21A5DBC029CB7B90AA6A66291567FFF
      BBD7F8FE77AFC3EFC349A6B81203C3B12165B048317FC10A88379EEA37BAEC01
      82EAFDC1995FBF959D1B8FAE52D39F13E4248FEFFB83254181C73EBE14E7DEA3
      3887BDE9F0E4E054E8BF8DAE46A1AA80E88AB54DB3E9661CEA7677898569747D
      7CB7527491D7DEA87B9151C1D5AC77E56C21E39269A0BDA3DD9E3B65DD0ABB69
      F097FDC171B39EA6FA12BBDBD6ACB3FDF39F9ABEB5371B07271F7F133D8FFB3A
      E2812BEDA7B4858E0C6E2BA54F14AFB0F9689D3CB03D6836C904445AC6798EED
      EE1AFA3BAE882FE5548C552F1B8F9586D8EC067B8AA01EDFA4D12C19B9912642
      27493C1D1BFD554B5D06FE8FC401048AA4E5E8AAEF3E616B430EA35CA7BCC02C
      43DA92E59FDAC59289FB479C672A8C4C3C4754C0BF518C10447B5DD5620890F5
      E77F738192DB06AAF5262C81A8197B3CCE4D098512E39CC567ECB89EC48B349E
      B689FE13F174A2F906FD349DA9D225D8F363BB7267B00D39962F2FFBDF365E50
      D7698E114ABDD25A3092ECBA618124D9F83976305F8490CB18D4F99177ACB0E2
      12F3E8CC2C2070932FF7054B7B1581AB2CD58D683A12BB164DFB1CEF7D2B31E9
      C5410688F43419A2FADF6F1DA9BC6A16A9FC3218ECCBFCDFE51044026FBA187A
      2BBC2E161A5D90D67A9816807806EB1D268A2D5849EAFED81F8D46ECAAA6EB11
      C5E07E731D11CF140CB86876171D0B1D8430D57295D26B6D9753601AA4F6D462
      BB3A38DD0C68EBCD8287CF377932731FCF450B0F85C545B9899FF5756C792B95
      82BA791FCFF1FEFBF15792290E4E37AB5FD00C400F2A1220AF9771F1ED971CBF
      5F9F649B5FF2C022A4E102AA32D85B587EDEAD8F934BA8E45CC55F23585B415A
      4B0BC94A04A07B4DF62511A95FD7D9C136ACB877AF8B675C918E2C6DAADDAB17
      328660950B27D6B951F399B1A9E1897D58232AD9D4514C66C934CA4991ED99F6
      0CF36CC21CD69225732395D03963FE74892AF4D87675CEE98860BA2D50DC5CBE
      AD2996F2F74CC0CC23703585AA3213B662B0354469C3A658B9DD82C9D56DF13C
      F0B1DBB911317BC96A7D09E46F0355633DB788FCDFCDBCD96441BE42F4F3FE39
      18ECAF1D47F36320F6732A6BF3DD557FFCEB222ECA0B00F3F8C76422927A20BB
      230141E0BAD46F55AA414E94529B273B5A74ADD1AB5879E5538D9AAD3CD4F10A
      19D546D7C3F9054925883D9904D498E372A6198766D7A5267B206D5A455DDB67
      87DC252B12CCDF0BA8E2A7C9A4E8817314E749342D7A6E9A21C1375DE60A3D7D
      736BBEB5FD666BEA406476B8CCD0284B16D436171EECB75DEF75E39075DE6DB6
      6AD43DE34AC0A814F83016DFBFEB506B39525EF5DFFCBB8D95677CC54277B2C8
      8C66539AEAE231C3F2DDB2D97B7AD423AC111EBD1D0C940CF7E82DE95FBA4436
      191F0DD792FF86D9C5A3B88F4AC3B77C3915F1FE598C7345CBA8F780A75E8F33
      94860B242C8EB8C11D9DEEB5BA953C07FEAFCF127DC99271A1EE73026CC9E3B8
      E08D283DB300F71FA1BE4679E026A86437B48F981BD7B9A9675B739324905C84
      62002213AE5405CDC096DE7AC8343D59F92EDF6656FC6C677FBB4DE5F4B90307
      D22B01EFA4F2FC6C5EDEA8CC40B394ACBE6B5CD006D2CE60BB1DC5C62E1A3CBA
      A21790508F51DE89509C90C2C5344AC7C5289AC718588DEE7770F2D1862CB5C8
      DFC84FAD47D0CB662348A421DAEFAF92E85266CF348E3EB7B94CA03382BC2C0F
      FD7B87DB472D2E495D308BBCE9B4D1740D8DC65F50AE0A0C71DC24A6BB67B3CC
      711E5DFE1F9025C51A550B074CDF2C17E33BB5153BF0BD634DB759E76434F630
      F9565186AC60B22D43ADF6F9D3EA5A94A1D1640302263AA94818221FD8EA9471
      51F6E711FA49976BBFEB20A1C1A221CE6B9BFFE4A1EDE0F4CD3F0F4E3EAEA9A6
      56FCB5D90B54B6535164A384594A4B4CA26D7FEC2321328F8A9EFC7353FF39C9
      DECC29323FC60FE917FC00720EFD279B7515F365C7D9D89DE69711EC0272D77D
      058986D2BD5EC3AE251ADDA120B0245857856E6E7D96E957B6FE43FF813EFC73
      B3512680FE75E2D10038301F81C2DE14B5439851683C4CD64FB782F6334D2220
      F36C51CE21F2417016A70EC6802EC2163000323A83298CB455D29020078245E7
      3AEBA75BFDFEAFBF1E6763DFBBBFFE3ACBC6C5AFBF5A0E718C5C3C14498F4EF7
      3A2D7773997ED1D45D2526996F5CFDB190F535F1D2F03EB887C042B1AD510523
      8F2784685D9CEFEF6B7C7F74BAE743A3654307CBFFB74013DC0AE27A54375E0E
      FAD7FFACE5A8F53FABD951D97CF7D57B7E8AA379966E6CE7B32CDFD89ECD166A
      9954CC11571457717C5751F471D7DF39DDBBD8D839DD7B2DB44B8F48623CE40B
      F69270F6CEC998815469129D4FF5E3A0960D97BC360DF2B6867BA73BFFB9DA19
      FA89573C5F812A12EBDF0ABD773BF1F6F4C8E665FF4DD3F31449296FBFDFBA43
      D878A9BA15485A0B280E61BE8B66F8143E1E326D7D8DBB68D1B2579BDF6F552E
      E4E318C90EB812C962C9D55A7B975EDB202FB7BADDDBD75B016639CF3C31586C
      A8615361F8A16EB0421A0D34AB92AD58F89AE1E2AFB2F2737C538489F02A9BAD
      29F12ED9224057898C610FE7B4793476DF98C5273D5ED6EDA7344BE39EFB2348
      AC715E366DD774EC0657C904A035F4BC1182751C623BF99CCC0924CB88BAD2C6
      8A8D7017537651A02C59940B68CD930AC5AF668B12AE3B1842485948B5362E3E
      C3D52FCAE3E8991AECBD844F7FBAB7775974461E1F48663C93E91ADD7627ADEC
      DBDA2071E2AF746BBCF3FAD652568C43CFF856F532F9AE6A8C913B80C8073A77
      7A06C826A64784D44ABA98553EAD38E513FE4C9A50B3F703B8F437BBA272A4CE
      ED309D17A55371909E536DA6E7F68B91887C8ACAA118FDF2653587A268DA48CB
      FF75EB2E2E74E3C508EAC6D3C2402B284B0B4CC044D818003547E26B65438273
      AAA47A43DB713CCBDC0BC154AFFE18C2F817CF79FA08EA0BC516F67F41B8B020
      68278C2E5FDAA7B55EA0A0E676F2ECBA402CBD3D2DBF3978D36C34F8A70B74DC
      8659F619FA4F3AFDF48CB72523E755BFFFADC5B091FF68CFA111F6B7CB8CC2A6
      0D0B5B3EC9011A9D071990E19F58A93AA29077CFBDC8D217C18C78A6945D7718
      979145433D8A71D806C31DABE116A337B2335F84180F254BC850D0A1BD2B08D2
      620ACC896400D77A6E2E7C319D3137A0D05A698AA63BC0A63C43BCB46276763F
      5DC0110691598FB0A69ECA9245F39B7C51F0DDF4DCFBB8DC073C98E80F8FA15C
      EB5589AB93E8CB3153AAF08BA79C7D99B9BF67E9F5F8BB563D29A94536A96B6D
      32232DDC022706016D1E7D3C7AEFBA97D36C184DF9A7A38F472714522768EF05
      6D5B211D2DB5F9DD9F44751EEA2A92D8D0A4AB72166E2C0290A3BBE916DC4AB8
      3EE57936ED797E3E7FBF07F9718B543327F63C0402CACED0025D86A31C8E5821
      1DE0EC68EF7570C7247567DBBB3FD1A4244991175C6B719ADB39BBD80BCC592C
      5134CCC63784A35762973B67172754D66E71B7F3188243788D549DC4FBE2CA21
      54D02583DB36409DC1E686A207F564CCDB848BD6E9C1E02274BDED72137B31A0
      FC8DADAA2F2C1EC0D23699ACB53F93344CD8C7C55C315E0A6255536AC5AEC7C5
      AC4D84FFE6ED1680A64509BD27A0E927D0F8516D56F36B1F9B939FE846DDED6A
      FFD49B7FB7A5D87C49F4FB91AE46493459143996C38B631277CDAD3C2C14A531
      E92BCA7A6C91F15567AAD4BDA373242759F1FB02A7ED611E8D3EC7E5ED86E969
      EC3211FAA2378BB0AA34411C45CF25FDB8EF7EF9DF67493928B3F96FCD23C4BD
      E1D433EA6A3826390A9AA706E3296AB5075CAD505484A05581BC341B415CF63C
      88A692CF4662C2070381EAA32AF736DB1251B4915980B7615300C420D86DCC80
      4A9523567965FEED58B0E4BC80F540B61BA5D9545FE071C218500C769F3384EC
      C15752FD3597E2C9EDA2C0709A456974092B78FD7968B123DF75D3E051B76199
      5B3FEFFEDF73D785F69B242FFE81B39C3F51FD65ADBEC1604B6B7FCFB3E3C341
      9BAAA28FC8C449281BC2675EC403E269B04E6CB9E3D3BD9D9E3B3E1DECF5DCC1
      FBF7DBFCFF00FFBF18B4B9B5F1058F762F4E6A9B85BAE55433FDC3E0A7335D8D
      5BBD2D3F6734C1CD431754A941834BE86CCE9BBB437194C4F86E754359F48252
      BB21B11964B47F7B2FF624F87FA128F6AB9889DA604978B1FEFAD5E6779BEFDE
      BCDD7CD77F89FF5E50EC927436CFDAA23DA54C6DB91022C034733FEF1E7DAAC6
      C27344FE1DC40ABFFE2AB85E91F42CBC2EDA72C0FFACB17E08AFAF9942F05537
      671569006BA33958B3C3414D43C7AF2D8A827A1B195167EFCFCF83452590D840
      96292AAF2E73002F048C49166AFB7BAE18C5C7EFF70FD87B58D264F8FC7C74BA
      FB0C23C6DFB5F341D85A7616FE79B0BFD771D751DE3810A90A3A720739D6D61F
      ECE46CF76FBD15C7C2B668FD97FD370D21010A25C9E32F1B303C0ACDA1640C2C
      201CD787D57BCDFE23B0F0F52065F1159C23999EA33ADA8C9931A88C72F3F8F7
      05FD3C344DCEA229DABB985F4318A3C51347AE8871B0BEAB241AD8305B35EC05
      0D702557CF13113AA67934B81D741CF27590C2900C95E4039B5DBAF39FE08302
      50678720ABCF4096592A0CF36CBE98AF30A87E3C9B0AD1E086F939A0E002CD8C
      2248E336BBF0117CEF58B8167EF0759E9425C033A57B73BCD390FA478D322026
      A1461D7F1DC586B0A78C8A529CCD5A58E44DCFEC00556666F04CED90329ACDC9
      649A713B144387C982B212258E19A28C428E36667FBF555911261A647F1B48DC
      FB31A9DF0843890AEADA772A830446D1EE4F4C3C7B8FDF59FFD94EE5F724B72A
      7F069CFA18B62250BE51C0C9FD561B9EE9BAD596E22A0148BFE565EA29E56E05
      D8CFE3CB05281CF157B31A2CD69ADF2C3C67742F8E207B188FB1AEF7DC8598AE
      2445B9937D6D780BE9559F8210E50255D3F0153A39B3B0C2F4CD01070E562459
      E229594777641D7F48E8376C8C009EC6AEB849CBE8ABBB4A2EAFA6984AD87208
      82923BC83A78BF433BE2AA6603053A86826F86688D884988F91DF56C9A0E9CD3
      404DBE78BECB1E4A18F1EAF5B73DF7EAF55BFCEF7BFCEF9DEBE27F5004EB2031
      C0EC37EEDD79C0BA332946CDFA6D1725AD4AE284B885D93C2A936142EF768EA8
      61565EB9BD783ABF4ADCCFFB5CA27EDE7FE3AD02012A510B1F31DE6CB18583EC
      75820BFA05B1C8A0B6272BBA404F4523503D083D014AA39A8677DFB929E36D5C
      DD4DE3F4B2BCF272AA3CF2BCDD74C3A42CDA4774AFBF6F16D1F142A32CAD9871
      C31B37CB925994BE7AF9D25D95E5BCD8DAD8F0BFE98FE32F4994A204DE1F65B3
      8D282F372EE2E25B4CC2F543C894AF6FBEFDEEFBD7DFBDFBFE6DAB73128DB153
      201B242549BF36507EC7AE2B7B4AE1B6CF8FB77BEEE4E3E0109981BDD73D5415
      4E1BAE367AE37D4A7EAA1F8C30BF2F91B0C1560D0620027495D4A73A0B73506D
      6E7870D7B9866515DBA30491E711A16DB2B12F37DD16F478507CA690A3E8C221
      FFCC82773113A9EACBABAC28D718F9F878A6E9BA24B776EFDEB92DCC77A478B8
      847B0527120855C2AC4CCAA9B748058855181E85CF2CBAEE58FC894176960A4D
      1ECFF38C95EBE1E2724D7DEE4021671E54D63A413C42E7ED6B9BA778F5EA7BB7
      E58B961040F9092104B9D953C4813F1F9D1F55A283823205FE440E4212DCA085
      5911CB6709B285C2FF38C672338CD3E45240E08154CFE1C571BB56BF745B8E21
      4250BE671297657DC9A02ED9A0C1E71706D058253ACBDFED6081462545C668C3
      7D3088AF15E9692E472CF3898798BE393933D2E10F07EF7643F175F51277A379
      525610273D91431D1F544E540598A80AAA01E384167E63ACDD6E2FF04E50C498
      A9B6BB02B85D2A99DF76657ED680368CDC10D2ABBEBCFE96BB2D20A863CC9779
      544051A0039C6607D28CD7105D681C9306480AC3E8B488A6C33155FCABA23A23
      16A3766CDAB5768684DB5D656B8BC003C30F076D9CBB55FD31704E08351F5BCD
      D0D7DF62867A0D24F55F16C95D54E390D340FDACDD4D5E7119B865E0701E5F32
      FE14F02ED1165C4B8B7EE0B3ED815ADC8DA7D18D1A1432D553D9077BB10D7742
      C027AF5CE10B7FDE3D3AB755ADFE785A0768F7802F375EBDC23E5335BBA60B48
      489C4F4B49AE287C46C88C2DE62E5050C3870527873E3103349A494E793668B7
      2E7FE7B6606BC822A49C683E18F21A5B80C9B8F816164040B5BA23963E59785D
      47ABE1125275DC2C9ADA746EB9C2BE7A8591B6FD31CCFFD62ABF2CE151E2DF07
      E07D3790B00A0FAE8C217057B52C8DC182715511EDF42D61B4DEB8F95554B47B
      172F316E3E32004479DCC41C39BCB1D853B07C70CC047ADFED44A3CF8035A4E3
      0A3C4CCF73D923C81980D4B9D5B0B5B1CC7EB56B26860C14F5640CFF0E79019B
      503A81E3AF20E7B260AE836A924714179224B608E629C5011E98F7767C8BFC94
      35F9ADDB72347DADA78435578B52BF5473C5D3E51A65DD2F4203EDBB83248FC5
      9304670044494184800D2F9E4C707EFE32BDA98606E23E891BA466D7AEF9589A
      4F758310FD64F4B9F569013E11551EDCB696F090C7B290B4CA23F6DD9E0C0204
      F93DEB6984AA811AA47F04857E48F4810244BB674000F8314B46B18316452579
      82B07A3E8FA3BCE8BB63695121A361C57B5FDA837F4AE92088CF6DB55AB5DFB8
      2D55E1BD15A3AA8E29404B325C7AD63335A3268005A806435142A4A026816A8B
      0C04DB06FA04C289C8540503665300C85D6BD7D15C5F95C2A1CB9CE61C04ABA0
      75CDA828924B103B14773C26EDC65A23B2BD338C7F3D6454DE55E6A650BBAEA5
      4D7422F1A7A8D4303433DF32C92FFD8B923EB6F263B674B03C2EE6DEE5D06BC9
      47E9E82AC339076B107D1D0905CBF2865967F2BB21E5CBC51568975134BAC299
      DAA69DEB821F887E18C7C3C525229FB56748B9BC6B9672A1A61AAD828DEE23AF
      26414009969880C0E32865A5279B08E4D4C0F0321B2AB601796C94898BA6EE24
      FEBAE0623428E368C635B0B8CA1458D6775D617645C567170D81F8633374DC4C
      B27C316B053438530868575217B6D7AF79CC21053B78309925C5C8B62CD370AB
      72E67B797499A5C32C4F213AD8A6491DD4297532BAC3BDCEAA448B46248D6E73
      81CB9BD29115CF569EFFD4B957F048CD12999A3AAD64C903BE44995930FF1FEE
      DDCB97CD7877BB15D3D7B3CC601A8445982681C479D43DA45AB2312C00F54466
      AD442AD36D0473765D12150E7FB47DB227686836EA64FBE3A1EFF7AE504AEA5C
      92B5BE3B4D0390BA966B8551C7F9DC53AE8168E3B77D24CFA85B8914C33A4296
      C3F368CEBCECBFFEEE2F6D6688096F8E930852D2C56228169244CC11A6F2AADF
      CCFAD38C6E37C6C404D3F376514EDE99544CDF5D545AC9617EAF27B51E5805A0
      E02E55FC32635E6350E6C29DCA2DC52172398C9CCA0C75B136AA6C8A2718DEE8
      6CDAF0511208510558B7E338F58CBFF62FEFED5FDAB249D173B01DA5678BEB96
      79B6187A3BA39A2FC85AFB3CB5727ECFB777F735A92405946132277E8FEBAC86
      2D87DCB9AA22500ED2CCF2F14F1099BA1316BD40F4E0F62525675C1D1964136C
      53B1869B9047B00AFD3D4C6789703B9684A0E058B8EEF21C6E8F1A7FFD6DAB71
      70389B031FCBA31DF0EF87677B03C3E8CA1B6A4FF3D8DB079C5E0F8FDB47BB3F
      0AB7B1B30705FDC5A8643F21A09BC64567ADF5A80ED0AA0551232A94A7C56852
      A893546B40DBE7C7A78201C3C0F47E37949CA6B5EFEE4F58C6186546AD584AC1
      88613D4AB5F3493EF00D40BF708CF07DD0D08B8D9656B47F15746D0E9EF25850
      85675CAEBB86A64D52195A9B6B3C71906968E766C086E81D6416101185A8EF55
      FD7EA885C47BD876622A901569A60D0CEFCE22D9E06CDF6A2D8DAE7FC654F8FA
      9005D96ABF56B73FEAAE84062F1DA94575D53BCC5352C3C500A07BC077CBACD9
      24E8684D44EED5EC12DB6934BDF9470C8C945C06114E0EA10138B928A3AA994A
      B8086119DB6B9A5D36BACCE9709A7CC1B67F0ECBB1592CDD7B267222209F5CB2
      F6BCB5B1717D7DDD4F71AC01B59C35E74CBFBB81DF6C6CBE7AF7F64DA35E3A96
      204D89853C58672E9B004346B427FACD0B5477A834019D9DA10C811DE4C21165
      6EE47134BAC230E85513311F5DF5DC20FE9D85D69E85428C747A2E2E47FD6663
      E30026DA6292424B2DDD5BD59259A2A4EDA38BF6DBD1E6B3C4948150B3094BA8
      ECB5DA4F500EB530FD2F20D432B7733A18B0F4CF85DFA6D83394D869A1C24C49
      00894E52F7D70F838B369727D14D10EB53F862A180A85A1DC318E54B7F980A90
      3EAD3601EE864AD39DC697D1E8C69D9F6C1F6B8084BDE807ED532DEEE95F0451
      8CCDB2E7B68FF1FF4FFBDB673DEEE63D777C386875D636BCD6EABB54E6DB6849
      7DC782EBE584D538DAB3F88CB9ADA82CF56390CAB8596B41BC3CC9420D314887
      B571A95C1636BC0DB9273239BA1C67705517C30AEAE2C46311CD514775B3F2B3
      D568EF68B7598B68B4E3859301EDF55A61E2B39B8510E5C09B8EA6B2A1056F43
      D5327FFA45DDAF28F39B6AEA67290D4ED4D3B4D1D57F84B8C5EEC5F951E52828
      CBA19614803A43974FAA85B2FD62D854D555A6850E75394B5B19126D94AD34DC
      99935208227755B51FD8548FB0FAC8042C7AEE109DDC839CEC74DA6CAF3F39DB
      DDAA5FA6475F3FEC6F65D17307307BBD334BF2C0C5CFA351BCE57E8C12A86CEE
      DFC4ED9ABAFB80ECCE438D89250BD1ECDB74FD03F0B6D9D77FB2353A4BB71C85
      A77A2A43D573DBB359D6C38B683E02B13E018FFD9BFBC4AD37CE710AC27CF9B0
      77AE3634266C1F19A9C55B8A512195D5E84046A0FF1CC1C16D21D166B6403B67
      7B1744B65A2A02EE69967012FA9C2EBCCC751368253A1B7C36AFC0358D902901
      A7B65B1D9BE56A5C56EEE1E13D3C8F5E14AE4C4C50B17E79FC5E549E1A850C0F
      DC1BC18DE715D6D116551378F7E6972F4A76DBED47E31F5A5CFDF05E018BBDE4
      0B3496B2BC5D5E2B1AC5073FBBF95596C6336F02AD11A96CCE7AD60C720BFD67
      C9A42DF1BD787D04C1ECD4AE344198B018DE42CF90AD031FFD413E57A123F425
      0B737D21D398BE5B1034868D403B642C1D5A54FE6A3D26AB672C7570E0857E5F
      103D33D8FFABC4195DA4FEE82529A4250B6C94DC8D74C46899E2F1F4A4978C8E
      BAFC7553D32F4471BB3F6E5B3A817D6E590C292B5E455380B8C5354203D93DEC
      87C7591ADF20666B736F05FA8C2528D520B527AF3E12FCAF16C46BA326A4E737
      84DD65012B8BD7EEE0E57DC65CBE4609193F09F626492F3B0D596C1A91320F06
      6A1E73AD48D807DC33865CAD086D92AC51B751CC14B3869734081069A43845A5
      0678F2D4222D85D4293A5D7B018F4DCE0E84D3868BB29446EA67A5993D96D625
      D12D355B2DBF134AFD15FA7052A787337A4F2AB9B76EA69B2F4D41F2C6F8377D
      E8A07E66FB76ABD131108C45253891D5C30AF0BD367F435FFE6D9A5DF244BF98
      67445036C404CBFA384B00BAF4521D7C59A214448E911E60E4EC62B586BC3A74
      F8DEE5A62FA8668F1A97EA38AE8DD7C44BB388C25C1E49D2E958AE87DBF41C44
      62F1994AECF405A4A2332F1D2B9B46A5844A2D625ECD188A5DCB78893BD2C5FE
      E0A3FC2B2E47CF014668A884699E1392126C0EDB0DA8923CEEDDE9F1F8C0B5BC
      BC2D52DC100CA22F6D11836B5BA2120CF44AB6EC58F60446995096BD1B23B53A
      28D4A8AE4033BAF1B55882AA3A999C4E1536C8754F3873A6ECD270B3D89E4E7F
      739FF29B189CA62BA169E07CA9F890EE1F61ABDC57F686D77BBC25F7D8F4EE47
      47BFB983A3C1056B2922CD282696B5A8B2CDD5F7F7A07C41485F51E1107C18DC
      2A660813B1CA1CEC590F4D83BF55356BF9A8C0126D70061EBFAD5AB33EDDB253
      479D5A5E49838C481331E442AD4D2D387141310B6B7B42D685768344680C6E82
      34ED0672B94CE57289D73492EA7885429D6D422039F51E67E39F92D21D1E9FEE
      592C16AADB9BE25285256E73CB65E9B57028078534F83446974D39DAFE042E18
      51391685E0BF4A92AB3139E917DB60EC80915D231D7245695A3E9B24E2A1AEB7
      7F74D4FA268334BBBE71D72A9719663C93AFE1296D3B2FAF6659963FC326F7EA
      FBE7B7CF21691F1B16237906F2804AE831BC7D931BE23BD4B2E9E4231B838C2C
      543E15586E808A645299D78C4D618F1204C358AD4F1B16FE05942F1EF64A79CC
      C4A7B474A8952AE2BA1574AE83AC3FDE8AD4AE8A8E87205D51CFAC9A87824EE6
      E3C665944C853228C845ACE1B72DD01ABDAA86108C31F136AA4B8F90A252EE56
      6B5BC9A4B1D1423F814433A1CE4864FF7D319B6B9931B21E7D9E97C68E254B35
      CE3FDB2BC3D91577DB4F11269F6549DA0C0F214BD9804B1901905C9CE5B7DFE8
      EFCF70DF7DB92F31E73852026A1039427C2880C1AD1548574B23F9AA3A3DC640
      04B70A06B30D8D5A8BE373ED25215F0245FF9BB03E82A71059BB184B03363811
      59892EA3862C5F2313AE8BCBA35E0F7C0743F98FB0F60B7B2A031412DC58B604
      D10067336C4D858B380531945A78C07208905895A345A61D9C18414B369CF9C7
      4457498E962D905F9C2BD40A334D327DBA250372F64972C65B06DB8BBFCEE33C
      01402E9AF66C79154FCB68593CEDA933F575FFDBA62E7BE40BAA2FF52A2CC928
      CE85F97F4760D1A4A90DC540C1073B48BE6E893911A73026AA6828E449217849
      5A43203FD1992CFEF18F9B8ED29E9175CBE302F1A299962F5DC68424C9FE954B
      626DC71138FE1D8C6BD4CA1D44612F39C2E0CD256F50D734D29CECC8148D468B
      1C35E86C62F3ACBBE9863765BCB67C63613AF4DD8E1CA899F9000810F977E0A5
      2DFDCAAF91985EDA7600F286B64E9A2C9B217FD3FE3D2D096215C3372F6F5DE2
      B55CA2730E4D789C229525CD58B9DFEF77EE2355A04085692ABEBD12654B5D81
      12965F924B09EAE14DC79D62FDCFEEAE1BDD779F95DF918E56D038965AFB63A5
      2EEE8631765BD55D65C74B1E57C82AC0EEDF304ACDE15850B1DB5157F1024766
      7E21EC69BBC61A7264FC894389096423738B6C1682190E8D7B1FCD38FD2AA3A4
      5937AE903453068C7C968D1738BEF0764CE04D23EADEA9E890711D1650F6108D
      69BACC5F2BEF229A5E430844D530401095EAAD5135BA71FFB2AF6A0C07A76FCE
      048FD087F1B0D07928BF040B972F713E8DC442C17A5B0F4D55C9495BCBBC20A7
      2DADDF8B057349114942DE93502E4F061F1D4AE4581C5E1E1B2B6E816BC86E23
      9C8338C76BBDB76B3F6D9F9F1C9EBCDFAA42063434182521255A5A2D638A0DD6
      342A535F28B089CE0B68B6E958B39B791C7D962124F40FB9041F521D1593C27E
      8B105769B90A211659ADF4466D64A2E5AE832EA397DF129DF0E9D4D463590239
      387D23665C32EC48E065A7CB9CF0EC89A23E56D9785CABA28E61B9CB72846FD3
      9B7BFB54A4136A441FBC2186E6E8A304B97EBF8777A6518EC9391E33E31C5D47
      B0DE067032E8C5D859861250F805A4DBDCE6FB1D15995808A253EC0823F77673
      989495A5D0C47D62DEA7F5A6F6A6FFD2EDFF7CB67F7E78BC7F72B17DD46C8793
      C7AD24C00A042FEAEBCB92D5D249ADA75B9AE26D67180D1489916D2358C894E2
      0638C5384E4B595D207C243F42F9A0CC748475D8B9B41A00E9F1324D26C908C3
      8B36185ECB3243B9187AC2CBB618BA9C04DA18E4B8C23D5E51E4CDCED9992E53
      0C0FD3E01D668B32AC9EFB35659615A5014914E5ACD1C02C8ED2603DE4402A62
      8D310BECAED71849E1B9D27F789C8C9170E71F6E9810A77F5D174952B139ADB2
      DAC5ACE776075595925924DDBB2DD4E62CA2F34A54C66B14C74B0282B458B2C8
      1047D3AD0FB5942CA82D9BC962F0976602B603CFDAE418EDBA5CD8C38BFF7D51
      705E17A64C2595D34236B9A244D77C8EE3B9F43DAE5BACD5EE8D524770F3AB04
      E333BC3DEF7E516BBBC2D6E538B1CE8F9FBD3FDF937D398EF229E09BC67F689C
      7FF7B7330C5D82983B4A13914F6A76E19DC52592393CAC488CA627F4D11568C4
      1A5B083DB92AFACB42DA8C4D7715AF163FF08FA7C35756F1331C7372B7BDFBE3
      B9FB85B2C22F5F6DFE869721A293C029A1D5D5223B884BFBDB8059FF3273A773
      CE675600E40BBAEE1671D977EF13098575E3E0C92AF7290A14B599045DCCB51F
      2A0E5318BCFAC39E1A3E708FF20A48D838AFE12BD393C03B99544177600B13B0
      FD4C1BC8CAF052C2E0C9DA4F35A82EE0CCA6C158ECF7E8FEBFF2DD70D2E15CE1
      1F59DC9BF0272602B876D983F4644E4E93CF523D3393D31787E15A2D47D0175E
      A4C2DF118CE8E64F5355447458A3D9C8BB5D17B5A48E50CC5D8C84896EE8F2A8
      E61DC763B757B58D4AFBE8380E145B556B0B3D474B270D057963F87CC859AAAA
      345F4538F300B0858060B9A2F2F46DFB75D363F37B8475032BA776DF1F0F2ED6
      8C537F2D756B3FB829630E7E0AEA0999546DC19E13210659191A32B53429A263
      59E56A02A80693BCAA0A82A84136FDC81DD0DE975F6EDF85CBC7C4150714DBAC
      F52CC47AC22CFABB32826CE84660F2EAF9238882865C717142D60C4C52ACE042
      B67B8EC62EF40230B0C3C124C9B19BD22BCE9FD0D3AC4C46422016B7D496378A
      DC6BAC74F59B305F164D19F280EB19013BDB78E7AC88CE51195F42FCA2F3A390
      3C873734CDA59373C7B0DB228C2A100E8EF1661A00D4C4511CFAF0A6D2E2C872
      47954AE96184509771196CAEE6B61BAAEB572C8B7680ED7994F35CCB7DB0BC72
      EF21DFDE70B2C2412B9B20C70F1851DAF1C26850B9C7E6AA9A179210A668B2DA
      6A36F61F1A2C2FE75DB2788806474FE20461864E20F3F610046AD5A4E7FAFD35
      CD4C8FC24C0D4387CEC02FE39D9EFFE9244B63393F740EE92F59B5A099C9AF0A
      7E4109595219926FB5C28E65C3B3C92401E3B995F5A284765BC154131399EB3C
      C3C1D6304AD088A831762B58AA6C580948E20CB22CE08EAC9BBBA2B6C8D6AFA9
      DB2D8F13A6B01AF9AB357A041A33A2105C5EC354DE9F84629CE99362A63356F2
      2601906034C5AF7CF0DF7CFE7ADB42E54D84478D8EA787A9AC58A065DAA1CF5C
      E17E5F506C0E0AB04CB154CCD2CAF39A6BDF5ADF6DABC41AF6034B22500A4B78
      31ACA77985B0B1DBB9E9D4D853165E0424C0BA833C3EED1B2BA8679FAC695565
      C70A6ADE5F3905FFA738622ACA59721596781F25F96831C3820E95B3D6C538A5
      9C442ECFB8FD514C93A94ABAAEFA4C2B6319947C007F172B548BDDAFE5D8C6F5
      80D96E0B250497C4B4A3203620E5D47783CCA7F2B0B2C5519170EB8EBC231056
      78983636744C45A20259F84B77F8E20B2B649799A8DE53CFE58776C595574DEB
      15F518112F5AAA3EE3201B9336742D3DB0689F1544AC2367386A33F9E2D512E5
      A6A6106C85B4866181DFF50BD7E52A6C6239115802F0806FB841590C1D246F6E
      EF44B2AC88F0AEA43037A44ECE4466E4FA655C6C62E07A882313F5FE904BD96C
      D8AF78F72004C2953294B02EBBBA9B18F60987B4396A638CDBB51AE90149CD1E
      F8CC16C49C4956214D07853755ECA224AF3D81429CAB68EF324B1F5FDBFFAF6C
      4149328E6EFEB49DC76E0FB8E5FB02F7FFCA16984D9CA724C75F65D3D8660882
      C4BD6CB440EABDEFDE23BFF507F763364711620A9DAEDB49B63BA0D30F6AC06A
      BA5B2A243225A53AEED60FF15868D1E18C8F53A5BB7ABE92C67AA0A2F0C840C7
      899A57D10AAD8758E0BD2E52E4AFD0F9F1B5E99A7839DE74ECE79D5F89FFDFFF
      FC1FFF1FA6FB4C0A}
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
  object tmrReferencedByFilterApply: TTimer
    Enabled = False
    Interval = 250
    OnTimer = tmrReferencedByFilterApplyTimer
    Left = 192
    Top = 360
  end
  object tmrViewFilterApply: TTimer
    Enabled = False
    Interval = 250
    OnTimer = tmrViewFilterApplyTimer
    Left = 56
    Top = 352
  end
end
