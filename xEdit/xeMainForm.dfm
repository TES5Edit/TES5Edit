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
      789CD4BD6D731A49B62EFAFD46DCFF90E139F758BA034292ED76B71DB3772040
      326321D180E59E691C1D495502352AAA987A11A2F7D9E7B7DF78D65A59552059
      9613A9FBDC1DB17B2C092AB3F265BD3EEB59FF354EB2E9D158476940FFF196B3
      A3E337C763DF4CA787FF359EC651964DC2FF1A4F0FC7D37415A4E978EACD7592
      9AEC500DCD2C36EA53F7FD7FFFF7FFFD7F8D973AF1C7E9E4D50F87E3541FFD78
      F85FE3097FEBD50FE33CCCE66A60FE9D9B3453D33851BDD857CD3C9BC749AAF2
      348866EAB6E307D97FE329C5B3F829F48CE3D7AA3B55EB3857E95C2706FF4AD4
      22F6531547EAC2DCE6291E992A1DF92A4F0D3F4DE95469B5D0FF8A13E5C58B65
      1C99285341A47C7363C278B930515653CBD0E8D4282F8ED2C03789F2E3486798
      9156E94287A18C18D3F0896AD39FE348F5E320CA52B5D7EEEFAB2C569D701144
      696692E627FC98E6CB659C642A9B1B1547B3180FAC0C8BC765F32055591C8707
      6A34372A315EBC5898C837BECC218E5490AAFF7D74F8FF1C3CB430FCAE41AABC
      24F7021D6278CC94E6ED63957C8C8EA7E75190AD6991E85DBC38CA926092D350
      7515C56AA1B3CC2434EB34F8DDA83A9E1B44373ACCF52434F455DF9865B8567A
      B94C8C17E8CCF85BD37BE00C7C9EEBEC65AA2ECC0AFBC0337F7D7074F026F9CF
      ED671CDE79C6313F6374FEBE3D7868419A9338CFD451EDF8CD21BD7590A52A0D
      22CFF050FFE6F5EE9964667CD5D79937C75B26669207A11C9A6C9E18535FE9B5
      5AE06335D54A8CCE8C6A9B30D3F21DAC053D44055116AB9EC6EEAB285EA924CE
      23BF9E25C1B2A6567112FA2A5D6A0F67689A9A4C6558CA54E154AD9220CB4C84
      539CEA1B5353BD3849E25510F96AA683285517CD5E47854174CD677B60A62631
      91677C75B2AED1AFE679E427063761AABC44A77393D694AF335D0FE334554B9D
      CDF9BB0B1D4EE36461FCBA4EBC797063D45407619EC854A6C1ADF10FD4A7C837
      49647436AFD13130D12C880CCE46184733DC0FB334115F3CFC3D4F4D820530C9
      945E31C11FE2C8A859184F74A8667A6178A2BCDB58643F55AB209B633597F340
      1DBDDA3E40C7AFB737FFF847DEFC8F66ADE6C16C1E06B379966E7C6D1AD471F0
      C200FFCD6E5FFD503912E3491E86261B677AB2B9F175657007640DB079B4E17E
      E50468DA894C19EDCDD532CC6741F43255F12A520BDAF29A4A63A5E52F2A8EC2
      B5F2E21CB2613537895110445E96EB107F98EB084F4FE385C9E64134737A8347
      1FC6BAD2CAA74F2DE9531393AD8C8954B68AD58D49D2208EE8DC6848893C3435
      FBF613ED5DF393B0C7D32049B31AADCE2CB83129CB07E3C591EF34FFCFE59D48
      555DDDE830F0D5E5E970245783CF4BEB7CF84F1CA6531D86B8D0AFE9B7A1A625
      BFE7F2A8C95AF966AAF330733B17C5D5ABF3B54BEC65E3C341B7B0B6790571BD
      AFED7CE7C6BB26EDD6491228B6EB285EA5E5635FA62AF04D944104273924C05E
      396490AA340BC250DD0466C58728C00523C1441A6ADFE9A586FA06C21F0701B7
      1D470F4B555EE7D068ECA856BE5E686CFD3408E91A274643A1A6F405B77D6E85
      31E976AC8EA723CF84214F86048B1F6471A2D24CAF31C6D4E0BA44A4E3BD304E
      716F6A98C7323169AAAECD3AADA9D51C932B2E0F89ED3C8A8268C65BA0D5E720
      F2B1EAA94971BA95897C3531737AC730B8364AAB284E163AE4419C5EEB64D84C
      48744CF33054FD50AF8719ABEBB38BDEA9B2D2554C809A3A31D9DCA4BE7E99AA
      CCDC6679629437CFA36B9A36946E0CF11B273852C507E205BD781047B54DE96D
      9FCF873231D33C35BE22DB43FB851270152D6D330DA2002F839B69AFDEDB1F54
      BEF4A1EA615C7CE8B407EAF8871F685EA771B250572C4BD4F1E14F3535CC7432
      0D0C6E38F4E04447D72AD20B83938CEB627CFB46D19AB44EAAB4974057C1DA82
      BE481FAD0E5AD6828993F42193A0629DD554124F4C92CDAE8F0F8FDED6D4DF61
      6BCD75A42ED32CC953B5F7AF494CFFDAAF29E35DA726D1F31A44A0C9233F9FCC
      6B0A2AD66E0BBE790D334EB5E2C9846EBF4ED320CD70DC0F1E6DD3F4C8483D35
      1A9BFFF8D7AFAA32A7ED6E960A0D7A708D1B05319FE96B12ACE15A945836D799
      5571568941B1896E8489556AC4F72A98928EE12FA4F20D561B7A01A3224BD66C
      5F903C27836115446E0ABD4B52D5D3A1D2BE2F6777A17D52081BB380565671E4
      199EE0DCAC951F4CA7D027E5548A05B10F739F5893AEB1CE82491042EAB31286
      A58E5FC3382733086393DEC5EDC54AF22AA66458E0E7C42CE21B1DB219971868
      6EFC44EFE334B14EC5E659EA00339960A735392C6BFCBE662F25EF1D9B97B480
      98843524ACF144C7831D250D59ED34AB0B6B7DA5A50C7999AAC8A4103C17FD96
      5A9A440C61B82E3A88607B6666010D5C155617FD16B46D7463A22CC649C3572E
      27617083FDC493682561B0A64B1386AEDB5BB5AD3C1DA9896CA4FFBE34083192
      BD1E2DDE77358A95172F699D551467D6EAA2D34066669CCD4DE23429B836D766
      BD8A135F85419AB1D6F4E62AC2B991916A6A854B4DE76A4BB73F286DEFD89DB5
      EA2BDD6B833EC1CA3EDA6ADD34587939EF4CA876C786ADC1D43201965CC589EF
      38E77B8CF26016C570AF9A6118AF544F5F1BD5D74916E8904F6469852579942A
      3D85FC290CB5385199491641447A9717248CB5A329B6B94DF74C16AAB990E7BA
      A2C559F3CB5A3B6E67F9B4EAC692D458C579E85735040F046369BD34EC99B38D
      43FBA9D5C2A4A99E19353153184E1581C9667AAC7D477BB5494198C4571E2D0F
      0ED41D070A1B46FA1E53ADFCE9652A1357D3245EF0E9CA34CC3F5AEFD0E8480E
      208C59B3149929DFB142425EC471F664BAF3FBC37F8DF3D97C43E4E848A4C004
      7AF87B6EFEE7AF45311C675A71F9E015D4ABCFC4965BD70EF614664C8E563903
      1B2D293DBE9A3D1D9159A9CB251B011E3CB2497CFB1EDF28C47FE95C41508462
      DBF096B358A88CE5F47E97F73AADF468726AE99529BE364B02BFFABEF4125B71
      D0EF91FC41545F98459CACAB41A6D2748FC9A4C03CAEE066E25BE91CEE12A9FE
      952E2662DDA934D35820DA163A3E85C4FAEE2354FABA7B4FECE36E3BEBECEFB1
      BB07F7A4DB66DFFD9D0A118135AC18ADED02D3A1F8F2CB544D100D663950A39D
      12E785AD7DC3AAD90A8A7254A7996FC612B2447BD712F22B1F6CB7228A332CF9
      9AC24A7C7AE935167A8DCD08221895A1C91C4574A4BA17A79714EE25737A1AB0
      5108A994C5CBC0A369742F9A3D37FDB31D1C490C9C63041E78295FA636607D6D
      60B0A989F6F97AF0EB4FC2D8BB864896100A2F0BDDF074635F531AC55B7B38FE
      9C5BC05AC1AF94B05D18C7D7F9926330AE92567B10312FE9E492EFCF570DB729
      42D02431FC099AA57C9A0E92E339C11259FB7F232A453639A20291AF96A1A618
      0244985E97026E1E23E49ACDCDE2D1B715F281C7C3958D578EE71B515AD50A03
      EF5AFD87E23C45B4297FE06DC64B13A522E71116227143E6C23B494544B3D0D4
      4304A2FD4087F18CF6983E21A1641D41F6D1024864897DBA451E66017F53024E
      F826FE922017B557A440F8B45743036EC2A8E9E3B47A61B09CC41AA604ECFC85
      89726B33D8377F09072ECC17919A1B8DC4D3DE5F8E5EFFF4A6A6B6A6B4159F70
      9BD587807240E2DD2F4DC271C6449330A3C773BC9EAFD587C037EA824C85E13C
      5EE17B5AA526435ECC593759AD2C3BC88A072BE2C561A897A951B17C825230B3
      24CE9746AEF824BE5559628CF3E0C5794BCC343188E040B29970CAD234C8D42C
      3688C16AF813D61C939DB1F61AD9A724462042F8E0B11ACB52E5696B75C4619C
      27CE26E84D900638FFBF9B4902059C044BB2787C9D5CAB345B17F171BAE67439
      65489B92499714BB9D1B93A52A473E476975D53AE76F3F81A2C219CA53EB4321
      A0731524C870A851620C2DB54ECB4B46B9CEF25A923D9C25E15F5BB81C41E18A
      85C6C391677590BE244396FD31D1E2A9DAA3EF35C3ECAF2D7C294858373B86C6
      71B239C505EF23A3BC6C501A8AD048D595B46B5EFD38E9A605854582480DAFD7
      49B07899AA95D14B18A9E5D7DF977FACFCB6F0D4E54EE8E5D268F83170C31E2D
      ABCF49CA5248D5F841BEB0012F7747D1CB8A25472490AE63ACC3778AD26EF04C
      7924C7B314E58B090E250C8AE85FC6CB484329CD8FAF97CFAF4F433D2B921219
      47C3F03B285E388C8E31EE0C63DA7DEE0CCF0FFC30C491E5D793C08D4DE14361
      D8CFF2E9256BB9ADD7B89B4B93BCA6AF9B882DEE8D8CD5D5E0D1BBD8A144ABB3
      80F3E2681A061EACF8F0BA56B9702F53CA0643C92662A9ECB5A094BA5116D78A
      DDA86DFAA8B5FB02273FE750E4CD1CD16EFA309DB93831FB5F0B2A507C49612D
      44086CA58B8B888DD9EDEDEF64A9E7A443BC3C49704D61FCE15441B59ADBEC9D
      D81A8511AF3D5108641FD2A7FD221152C41BCDAD9B6336E40C5B72C737D79C8C
      936793F88E9776A56816F227F10192EA1B6612A3D0E94EF79DA127699C271E5C
      3C0F4E644A597A9A905D13A4C3354E3E2EA20DA83B47A3180A0035722F1C0007
      D48255F04942C2445E98FBC67793F5DBFAA9A6FEDE3AAFA91B2FACB34AADE759
      10A635F5F7348EDA3AD39713C82516FAE1EFAFEB3ECFCDBAD236C613242A5FA6
      D88A855A26317DE7D1499F937C46E9AF478B084EE63ABB2CF7A57F051F53DB4A
      F752E6B5480D93F49D9879805829BB63F2341C6DD52C235A88152433038CCF64
      9D39BB5722815773E48169C634054F4788964F4C19A0B38EA47840DB36C784A4
      1099767164B33EFC44443B963AA18F22174CD958324729FB9C66F1D26DFA1F8D
      59CAA221ADE6E30A8991C9F1159A222C0A8976B2AF9D66DAD177BF8409BA21F0
      7163E925179A1226854AC3DEBEC7F6A75E122C33656E49C5F9B1D9E95D1323AE
      67913CCB02A4F96EB59785E2AAF33E954747C2CA94F272B423A05D945607A9F9
      B78DE459E15439E29131BEDBDB9D06B76AA183C8DAA4CAE219C2502E7F9A4FEC
      DF688BD32C4E109BC6E122D85CC0F2C2CF13F2BFA0517418A4A4881F1F3AB33A
      D91A65AC91966B57695098F3A5A6E1C83327B0D55C27BE17435549FC8C02E112
      AB86AC8646A713779B3162D1DD1A2BCCC1F43A58A6C52B72980DBB8A958460B5
      B8016D2755E40C349F604AA54D836C530EA5619C55B208AEEB05542947976D6C
      9056CAE6C2794A128566E5D16DABC3C343378B0137C5660BE63AF229946BF708
      512E5811ABC0E3CC41F117169841E49B5BB825387199E451248DBBDBEBCB09A0
      1547A47023EBEF0811323ACA97E207400CD2292805069971F2217E3DDE59A543
      A8AC7519DC928D71BBE931A5E82A2E275F842236B90A22249B6D602082BDB6CB
      6BC300B7D09F4A121DC6A6D249A2D7C827E9DB60912F36C42747386344663898
      B61D58DD2DF1A5AD620088651651A24BE224ACE2F1F27027DCDF3A8BD5D0FAFA
      E43550800C61BA6568544241A1F84E38A022CF598592E76037A8389190004504
      714F5745DB4B8AF46F65E0F14B1C9D52E0B1DADEB759738FB29366B1CC38CA63
      1D76CC9C4514EDC87BBEF8516C4F6768A682A5409CABCC5ABA39AC49BC5C427F
      009617AFEA22FA093553685C817C9E92C48C6975A252884A288BA4966F1FA771
      A328D45A7C60E39BB5ED55AF08211B75E5A54118C62E19BD7A617270728D5651
      6CB77B12B40F463762ED972042386A8E328C5C8D6AB247DC1D9E61615A929F83
      55B21A65C1B97C441E021B1C24E30AF8A72C5E007914AE7713AC08F321AF2C23
      D8632D850B0002C288801B4FB325B8C0520BF0CA38C27087D7C1521DCC028438
      421FAA866C181C683E1D610C794BC3F2279C86F9142566069555C13614A7D65E
      6F72A8BE96017F1093624DF70AC094104ADABB460819E19A38B9768F2C70D620
      108CAA0548B0939070490B905AF338C9BCDC86098305C3119280E0B7EC36C37C
      20CD5D846268238115E2C78995A8EDBB90142B3FACD3EBD462B133B13649243B
      CAFCFBB0B265549EE2BA74CE6D7032DD02CF4A2897E62AE6D50EB311C5C359E6
      8CC113B270ECC915FB49028431338E481D9DCE05794AB94231EB054100785044
      B902A4EDE0612085C7D65E759B4A3942926507CF1CD05FD973B5D2B805799405
      21E5920ADB7F2B3CB76122D2E45A6C0E8B718C001807B648ABE3EC2E51B1E47C
      114895228FBE01A67B99AA7E98CF666BFE5362002285FCD2A29471E17999613E
      72C9151E0073C282B70BE49345FADCC5663F280238094CB54941BA0CB59B306E
      D9086A62D23CCCD277EAF4F2956AA8D38B2B15E99B8549E72A4B028D5CA432FE
      AC48C03296935F2BD4919F7A7A69E4A6F0674E4C14CC4A3C2DA769E686A2CD0B
      BD2CB3EE9E0E9F26BD5E01F8C71012101F94140F3C443D1014F5E6706DE384F0
      9099592C8152E1DF3A7BCBB05E3D0F80FD9B20E6C4388C54A0EC288C57D76140
      07338D432E3BC39C0979209AC04D9371DC746AE8624A60805EB930E03985AE3E
      9095B3731AF14EF29632BCE5A2D35CD28D996C58618FB394DC2B2F646049B66F
      C14C28EB5E200FE993250E838195155C94C8E309AB429CF33447C1116B890D03
      1B9A8C0D77EC2CDBE41CB6C5017C00CBE718D3E544E9675CA83641EE390B7611
      67F7FF519623D237C18CCF2672CAD568288BD0AA8DF8FF9BE5380DC28CCFFFDD
      2D27A0D03D353F49BC2A3D2D9A20CA6FFC804F20FF45CADBA6E421DB4252A9E8
      A18F215B2899E7558298C30E7E7853F9714E85A66CDA8A0B4C19C120A27FB285
      A25394AA00F987BFF51C45D6E8C1D340754601B05F4B4DB5BE985108AB1BEB86
      BD855CE350A72C007B43F83390A22B576B8844A91A04DE9C12259DCB3CBB9C0E
      244B932A0319CF8A04450AD10CCA17F5645BD0112E54D9FF8E6A1ADE5982CB50
      2975847A600EF0B95A5BCD68EB312A8C679455E0EA531AC8DC5254258EEABF9B
      24AE563361BBD9286633D4690E759D673105773018FD841119F38CB838DB9E8B
      D837B8B48B202583304E541EC19421435C3EC4060DC59BF2E85966C356DD278A
      8FD7E4A78141689917EB32D20BFEAB5B9DE3371E9F9AAC33EC89014EFE4E4DD5
      616E36239F8C506B750215E479665989CCDA0A21AE854054800E2215CAA11219
      4B4AB2EE60368F535757A1DE7BA77A6B7546B84C7AEC0CE9148A75263A201F10
      FE421AEA74FEE8745C59FAA678711EEF8436C39067E3B621679D53351EAB7673
      D454757599CC74047030F91DC1ADFA14614E1406C69B3D3D666DD0391D6002BF
      8C3AE735D5EA9C9FD34FADF3414D5DF59A6DFC34A4D3DF4FE08E666B8E70AB3A
      B928E2714C4901A5CF81A93B3F5775D8E73726C9549BE4406ED40841D8625928
      1C58C9DA0326620B0DAF8DEA5DB647CA5B8A25FEF4736C591337955519E41180
      E0826F688DDA4D95C267BB36EB6718FEA279D55575D54F7218169C79521757BD
      6E115D7EC66333680F555D7D08A2ACF46E189434D07E9093A4C8E258F8349EE1
      7CB43E0C54A3984F1F354269A6CE638FF53A6F088295A4380951F81CD340DCBE
      7204533191569CDBA5D8299B3304DADD84A3DB1AF3058C4A9C9AE3376F60558C
      3AC337AAA186C34E4D9D5EBEC67FDE72E5EDF0F4C8699A5282C495BB05C82988
      8274CE856B5B97C882CE35F92AF265D4224B4AE0F10BF990083DBD7CD538BDB8
      7233972EAE50AC1CDCB20D0EE0A86471B2B8A86A54679DD64709638BBA62A82E
      20FE8850C6E4A77208808F080730C8F04DD5FCE26AD879A297C5A63AA38B87AD
      CBF362DF6C0936A543290CC2A1964F51F0EFDCA8A64790CBAA878FC24EC24187
      1A6618C5D3E49E54A0E54F7F3BFA9DC147302BE40B35A09AE9459E921F65AD3E
      423E4F03AA719FACB99EFA397449EB434D0D5B83F39A6AF67A97221CA0E66A1C
      857EA6812FBAA7A4C42CB0693847282055FD93012A1FE8B422514B5A5F0AC19F
      EC6EBD6E406C38FB2231ABFB45EC03E5040B20D828AE90C260328B83447E445A
      8478449E7E2D4F2F01AD547535AC6034B701990CE66404C1334CA1AC36AE8BBD
      B8C98500117EF813C3E94198809F7FF8411002C47D109955087D61138F54CDB0
      3D534B41C04960A7ED775514C382BEA130B22C83C33BF57915A4469D7D227088
      6F6E6DDE858B6B6A45F5BC0E2B3410B419456DD92A40628D3940325B3B231570
      A988F1EDE5D8666B7878551E8DA0BA68F62AA9F524A010CD5460A292F12C6E67
      1413EA619780E5CF9F86231CDF955EAAD34FE7E7F4DC13549ED1196A59B63284
      F6A936E43BE4C0D73D1CB6E1DD4143691C12E08A3DE1974853303D0122BD3704
      D016BF98A2FAFC31891F89F74C40A2349F703E910C2464402D92841F4895303F
      DCA984293938DC4B73A67944E138D19325D84287C12C428082A24B38A051F13B
      ED3B46B37C5F9D99AC9B8A7C20ABADFCD9A27A6739D51288D4642D2EF1240E3C
      E2E0CD0C98D9786A69E5DF14750A0D3D01346DA6F8EB33E8CECD24DD2620A30A
      C72013A40C9A6E0133DC8491445F8AFDE3D029300C1474C4EDAD594585842D81
      A0B64AC69F8A25E7E3E7769356FFE3B0FB4FCE6600A30A5146D3A4FD5B2528E7
      F02D64C4317AE6FB2AF5B4F570B1DB9FBA16DD7A8A6A5AB25F019645D132D747
      CB2E7D43767E87DCB8E89E9EEE90973A2DF252EF2C8E099E7C00435362F2BDCB
      7E9F0AC102529E740BC0BAC3267D2FBE3114835BE834B5BB591AF10F1A5572A1
      9EFE367C8A026662818964927734DBE238EA358169D4647EDD2A201C3D93CE87
      73BD3480980BAC8B1235628C3FFC267E90C2E8583DCBD55E82D37194E828856B
      97F2DB9C0C47494013A60D33B7EC10FA5440837D7A86556551F941DFC4D7AA1B
      E198E87788339274B4C59B3619B03491C9041EE19B65367F967D4EAF119535E9
      FC9D953AE5C220CBB39DF16468C1D3E86C261B7333511175AD56317D8DAAEC39
      0E14A564816C909491653383ECE2523835ECD01568B78705679AD09FA5EF3857
      AED54A274CEFC619530A45009348CC2A0481645A585205119192C6CB04ACA4B6
      26883763113BF2A680A80D84A0C2CB2615F18B6099BE44C446D7E0F65418DE8A
      25F563818A21944BA43E44FA868F17B8D960E958B9C8C44D5410CFC55D58AD6D
      52A6825C8AA03CD53DB08603FF219F188010502BE0981AEF7D37391D21ECE0F9
      E0DFE071B961091A72D620AD09E2CCFEC4EC64584B367B983024ADD9FC3B336E
      D63609F6D2DA1DF81CBE7BFECFD76A9A3887EB9B62F0B0FD9847D8872AD60501
      3FFA576DA3BE1A49577692244B086E431B4D0B9CEB72B5AF4233D3DE9AEED132
      B8351C9CD302453B8DF3A4854A5BB8343A55BD00B45EF114E6BB00A9169A6B77
      0AA4B117CF2278775AB57F393ADC3C207E41DCC1F720F54EA1BB76813FDA3D23
      533CADA91B202BD85A3E6A172201439E348FE9D83B63ADC21504086C062AC58F
      C904219D164CB133078BE52B3E85C47BCC2567BC2C852D12A49E4415F88B20D5
      59217E59A340243E4B41DB6714AE166A33619051B8562160C70C18A9B311380D
      66B4A804AD92456391203C1BB80F22A20C6048B75B970772F688F4C62F28BF3F
      98E8E3A7526AB7ED7CE128FA5875E0452D65AF75431641BA0433B92FEFCCB128
      8BB8E19803891FE60C5FA92B33937A37CA501001B2E376801099D1E6C43B071A
      815024982DADC37509A280893A0298A40C278866395C93421C5BE60E019EDE29
      CD72A2D7FEF713D26BB72B34E6380D41945B65F3BFBF42B9BD8438F74817C451
      850CECC0A44B7A511B3DA20C5143CAD825EE52F0A85A2EF7BB7026046DE63A0F
      B1D6B33CD449DDDC16CA8EF392644408732BCE73BD903A544B55E8C67A184C12
      CD8453D7F6D8F0EDAA84FCC4CF35B74B90E6C7D11F4A605DAE5F7D730585DE83
      2BD17DB5477B8272C82460A779BF26420D9FB6DF8AA752D723946410C99CA92B
      EAF02D2AFB7DF14971AC27616E9609127FB2599E8E5E96D8355EBFE24369F9E7
      5D88CEBEBEFFE0E42D773BCD02EF7ADD10A01E92AF4C141C66F512F453632E8A
      A6A09DEA3A140E9412B9C5B685E354EF1CC7BDBE49C2819999DBFD72B2D60DA6
      6A4326F5A8D96AAB62223C2F226EE12F16A467D99AEA397CE38A7DE58BD1688A
      195E67916FAF48710329E050D2AD3653B6C158A1D4496FB2F2612FBFE06546C1
      FF4CDCB478AAC260E29B2992518DF0F7D78DDBDB0F90CA90C5F9440ED8EE3179
      BEB37C511B459D667965D51ED4F6A8D33FADA9D1A0D917347BAF3FB291DDF7AA
      13D135051F5A62563AF125784DE1FBCDC0FD3EB02F6951208E306E83E2FE96B1
      72E7AB7E9A18136AE0BC7810E622B7873466D4889C69B1E34C94D5DBE7ADA2BA
      CBD2E3EE108163026F2CDD6A62EBB8A8E6A8A64643A962A1AA507AE95A891B81
      8F3C0C661167B644B202C0A697101C89014B96F0334D5998002254B7113FC276
      3B131D53084B265E65C2A0130D20094F8A492F04E542E4704548447523B6AB83
      38DAAF6D5E10BCCBC1C9B0D93880855A2AAC2ACB75D2C856465F03E77EEF363C
      05CDB50BB3F5493C99ACBD30379B24D72D83C0626D93393B0D26415212607B3F
      D4007B5AE89EC99238F0EFA5C42696171D2D759639D363DFCB94F05DC6F23DA0
      74C8DB76B779DE689F9F0C1AEDF3ABCF6A92E8C89BD7B94F0D554F68A16EDE40
      8E4408ACFC8C9C91200429FEEB2BFA9E9B45DF89521CA4D63C08FD3364BEAC07
      CD0C2A8CF5B4ACC7B8833D1D448269271CF15D26DFC70EFDEBE9E5EB2FE86BF3
      32B3E1C85F3E777A9B4436C2D9CF2195C408FB13489F0BC92A0915AC0744BBAF
      9679B274E5D8C7A6B5090A7C92034B6FFC320989813E75393B1487A9DA13760F
      907B3872410D40C8A034F24FC2EA871210CB386491C657945FD923642C872901
      32C794E87BE9BE90005062D3E6C6A588686150E4EE34B92E781DC9DCF6A71F74
      FA4F93C42321068E93CD6519AD262C84DB66EABCEE83CED9851AB49B23CE3C09
      5D22A0343ABC56FC4FC69813688662D960145F97ACDC6E0771D419BEFE425300
      0095329FAE9E3E9EF58A9F756ED2B471468421499DE4212B0094C94C0C67B5A1
      A499EF172F46F52845CD8A0241C17333F97FD5A6FF8657F40725C8BFE2B26D3A
      1C628E561D8E771454C15784A6541890A433574139611F38C9ABA5B8E443543F
      5B12DF6D2C09674F2ADF3354918071DD540639CE1B4E1131E243DAA3ECF1ABDE
      91502472FB94454CF1BE7B674B2B55B8E8146BCA6055032F014C48908A0B4715
      298C7F5FE69390307A45818904A052E563C9731634754BEA52F050132F170EF2
      47A20CA058ACE331904357A5E7273B3B29B929C8F7AF8B98387E734CE0EF9A7A
      7DF8D31B86E4F0261EBF79BDB57CB87D288B710E864A05BC744B68106BC42668
      654387FD3B0F1056A4343B14BAF5605100C7A005AEAD280EAA0EF9971CB99107
      4015D4B994AE68DBC08714A5A29B112AABCDA580B498E01ED7E953EB13666C26
      8AC1992BDB555B1285B84078FEC649266EE4BB9EFBFBAA9B8ECB2A77C96E0E9A
      CAD12C7771D03031A292A61319CD6CB6CFD2BC5459E7A902D676A3B0E2EE3B78
      03EE4609BE2B1FFE1D097A668D10475E52F377EBAFD06910F238CCAA25470519
      66B364BD207EA1BDBFFC78FC534DFDE5C737478E7843B3B2318F77E0A3A52405
      26C60CF71C14C198B8D0E894023E7B2E9F35BE103AF0D7A80664FBA3B832EBFA
      BF731D327D15047BBDCAD6F9BE32281CC46F0EF9E257C26C7CA1B15F6C0E5E90
      F66A8A7D186726E50F209AC4824B69390D2245F71B059D596CCD0296E0719251
      A1FEDCDC24A5FF20A4AF95B2793F48D823772E48B3CF24E0383DD726B7CCC1EC
      40BDD83C5A7BAF010F3F7DA78E0E01137FA78EF65FC05A8F331DAA46C126CB21
      713EA6AA5114FDED469C5A940EDACE3AF4DB979663C586075EAA65BCCC9775AA
      91E544DEDEDD73FDF05DFE7A54F7C19404DDAF27BCE745EC6E23AF2E952F4F15
      217C282A28949B10C1F53242499137D9DC49ECEA28F32B6E46136DBF804AD471
      43A1E9E53244AE1966328125D1A82D4BE26B772ECF0ED841A94C464A27400255
      AE09993508AA58D45B0995136BF2F12CE797CE6D7680CB92329BBA1548301D12
      ED61165F47C83CC961846C076CBEA8DAB71A1E2B46660A827F04A8D8E2772307
      55D2A060D6A1B2356B3981E4C47C276EEC3BEAA3A461533733A83B592C34A114
      689373A6836516AF42BC49610353B9425093F14044137B240B5FBEB9A5C75D20
      F1B6FFBEC4CD569E8F361084550EA20208FF3CAF08CF1B6C88F09A2DC54D190B
      E5831B9915C7C983689967B85D2F7BEB5EECC35779B9D15EC38B610D967FE54F
      6C4F9CC3744F2AE624915947356C250B222C30152C8745F790862F2245D290E5
      7996F83C26321D300B575AFE6CD9D59BCD769E651E726136622FB890A5FD4AC6
      3CB9BFCC6ACF0605B90C775C8E796012A005841C64CBEF289DDE0E22D09E6986
      A17DB9D679B7041003814B303EB2F30D7FB8F84BB41641806D7D9645F9CB4F3F
      FE581A078554447DF5BF73ECD3040D4EA85257ACA70D8B8BDE9DD954D86B6366
      A8679AEA9B43B60587F3004C6D31110FF22AB7BBEDBA30412C9378B194AA46CB
      BAA641FFB742309C98601006B0EC75E56D799E591F1D1E1F174E38AF2055EC73
      838BE2209C9908012E33ECFCFCCE6EC3018A659F6956AFDFFCA840CA2F163B19
      0B752153F009194EDE02E7DE7CF52F147ED119C59F41D1994FE8D3CF32BD0173
      D3AA51CF2C628E508D0A66053A88187A928364D3A740545DF0D32CF152B5C779
      4E7582DA00DC47947231B3B04D0009012ED31B0DCCAC738B9659D713F40A202E
      41B4DBE319A06A1E24385CE5391AAE23FAF563B81B1E1D309674ABA9645A6BA0
      B19646DC45BEF52CA000BEB51E28822F29E00A24A231BF072AFF7F6425BD2D5D
      974A7A1B5DA0F0E09E54983600CE6A584BA0313C3DDAB1FAB93FE8A93A77F7F3
      CD14DE5A840C17B587E0169A1CD879B60934FBED4A797C9FD99D9A8806E2ED99
      1D3A5627714C7A71EFCE145C873FBBC0F0942890F7E72EAA69A68E99FE5BAD26
      9F22C07EF68EF79FFCFD29A8C07C4E9807D570D97D98B6A4A70C736CF8D3CE2D
      61F94E93787102B6B681993EF984904CC44CBA1797BD46F7E2B279CF749C1F5C
      C952D601FB2C5393DA874085E891C2254A726F242C9FE80587AD0E6D397142D4
      9982AE3FA7AAB544CF680616A84D71675B6E0D319BE8C88F17B69CED8926B49A
      546817B0F2E9E50A2E461D91468495681E80BD5BFB023FF367961A1060717B2E
      5083B7B7517F2C396BC7626730BC275C2CC76602E362026B47E70C7B75333E3B
      C3B352BA91CCE1A8009A8E33B6D3D6DE4A1A7EB1708C470D2F3F5D30FD477BD8
      B2C7796023DFC2B8C7B1662C610D68178E075AA24C39089B3BEEA8D690961B8F
      5507371D928792B61FE23C41C2616832350D6370810733EE5AA78E9FECA475DB
      E79D42B38CC78A40CF7413C9C615A19BC5EA1C9CA9F796B23FC10A500D3D5660
      3AA5EE14A5AAFB99200BC38CAADCE02F1FD721811979851B579575FBEE35ABE3
      B16A92F59256CA9E83305423A48AAD3FF49E20D62C82CA50887592D821D2A1CA
      A36910C2EA6283888FB141D3E63A857D2CA48270E6546C5EE4B486E8EBAC7A3A
      D2F4764FB4CB1FDA7DE832315A9EECB1FD668BB6AD3F6C8F2A441529C83981F0
      4382990389C01909604CFDC7DFD4D1F171C960C30D670BCBEAAB66C6F755FD3D
      CC06E62836886CA7AE5E25A8CD437F4212B2C3C1D909FFECF4D0CFA30F64EFB4
      C2382F315BC2DF404403F69490BC4FD55F8E7FAAFFE5D591DAEB1D8E7E695CE0
      3F9787A35FF69FCBCF1000DBF9B035689C43461147B948645E4D96D6751408E0
      50D195BC6BFA0365E5AA103B95EE64BC34FE7448C9E15330075FC49915DF8E03
      9CEBC83FE70546013BD5F037915DA070225C9A789851FE8498CFE5D45248A824
      47B57E93734706BCD86835690737A76D83062E3A757319C4964185A9DDAAB2C6
      B8509E4F260A689CF3B3761706518558A11C894EC8738560C94390816E741270
      CB3272D0ED3BEF594650C2C741DE18F9C212204E3F4F1CDBF40A276962FC3CF2
      41C7B99AF4E37410678DD5045A8C7F287401B27EFA260697AA5A4DAE8CF78A3F
      E0BEECE81F5FA9FF872A594D0A70955040C6F85DD19F2C8BD524311A410D94E5
      D67DB3048F61E4ADB9C3ECA385292EBCDBA60D47FF20A9371CB5457770234D1D
      C299D9D56CBE92438008FA28EE92D0C018E616C47E58A846493C57955A7F0CB3
      9358181461BE7C55C16415A860A236DDBE2E9EA37DD5F9A50FA6390E82173607
      40365425C26D48DC0E7FAB35AA986BF62A56FC728A4C6D08D239BAB0E6E43FAB
      09F1627CD7BA3B934C9D5C5E7EACF81744FF4FE62ECD6E886696F848E3BC7BF6
      A19460BBACCEB65D5B8791398B48894D835BB7F0407363C537624138346EF907
      BCF23D6E00D120E29C1CBD517BE7416474B24F16DD9D82FE9D423D9FA98F7C4B
      BA1A5E9930F602A262DA3EB34C1909D7E43D1B8F2B423FDA7E885F89536DE838
      B7C424993D4CF75100A4EA052E8E8801A59FC7D04B50AC8C586A16AB8BCB8B8E
      4D0BB43E16ACD4F43C00E31213AE4B25BCFF9436D3E74EB38F88019573700660
      3131940BFFCC7D5C994A12C16A0EA012AB1AA3816B6A99989B20CED3706D0B64
      E5CA128BCDD11D169B2A60FEBB28BCDCEEF2457B480796A363D223C01A644418
      23AA90E2E1D809E6F2D9E3BAF94AD2C33223EDBB072DC66335E2890CE755A273
      59387B62BE6755DCCF6A57984DDBC41B713955A782BFE5ABB441E6C571345CE8
      8B66EF0DB38C377B6EE3AE269727A3E1C0FC5B82165D2E336E586E557691B0E2
      255D29E5F42F7B97EDEF277D83ADEA76972F5B3D590DA4C46A98ACF51D1A0289
      C7A1917BC07E2A2545283195000785243EF2ED0C4FCD13375448F7E282C4DF85
      5E10BF3F252B1000C23F4C46E611AD9904A88A75E3D82FFADCC0CC0BBC8026FC
      1D4BE878B4B066C4342F1566459BAAF5D26D05CEBF59CCF615DAB8F70C07C9E2
      9C5ADC96697AC295DF714DF7DFDD3FBDB7C798DEDBE3EAF44CE4EB745EE05124
      5FFB8E8AE9CA5ABABD965E2CD528C842B3FF5E7A064A83A1FEF93F066A4FA2B3
      05AA6D5F217208701B02CB542D1DA764F4359258AC742EB97BCF88CA7BB8F4CA
      B68C4EAF33E05A3FB5F74BBF356AB42EDB67FBB5B21650ED752ECE7B8DCEC5F9
      08FF19EED7B825F2A72BB5D7FCF4E96ABFA6FAF3751A78A91AAE234FEDF53F0C
      47FB7C41DABDB311D1DDE5E9AE936C96047B9310AD7B90D84F6BEA9F239366A7
      79E4897417F880450A4932EC9EAD7FAF9AAD93212285AFD55FF9DA5EF45BBF71
      6FE7F3ABF32E5BC2527CE87C4EBCB90E43438D1BD74B4C4FF8B11A8107FF8B7F
      476BD519D25ACDCAB8A29B0AEC5F9D580FBFE8364D0016FCF324F6D744892B32
      CA3DEF78D51D76B93DF8A4B9980426CA5A71882213D2A4EF8BD2508AA306D134
      FEEAA5DD893989F456C13A69AB4FDFCBDD002F9B5971DFC13CBA8EE2D5779421
      BA6A924A99AA854D56CB55DF574B55D37C52B7D00F4D46D81EFA30A0983B0CED
      94F7DF6FAA67A94379F3A3DBFCEE54D6DED9994A91E4668DE57DC0AB7792822B
      BC5550172C4D722DE057EAC3C4B16EFAB9F06571F86BEAE46CD844516C706346
      49309B990415568D93B3E1CF405B67EB4FCB59A27D4ED1334B648D083E705388
      35937870A8402CACF4CD2A8837C99B38851D860BED0C40B4BB74F6B9D3567B67
      89BE819BF319A2D924E2CA5171184B90511B1F1B0102A4DA7A81C9563F5310A3
      4AE91C91E2038C604824DC19802A738B47ED132AD0A03A5EA32C3DF60E0818E8
      9EE6646960EF2E45ECEA1C7E070A3DBA6E10F43D5BAB2CB0548C65A0C452FEA1
      6CBC9EC461D800E3077D48BE56CF8B4D4CB3F49942D2D6ADEE0F3E2179C7C13C
      18963FE73ACAF285EAA42935B9B127AA15A78FAB282BEE8363A69C6511DD8962
      21AC5E8037CB155654309D6ED67FD4A8468CD073952AB409B25F3E35D589EED6
      3CEDE1377F1F5E5E103AD976A7408A8E288C9F69F5479D414F35930CA0E605EA
      B2C4262EEE66BDD2D32E887CE222DA1B9924D1916A260BED6B2BD88E8EF6FF20
      983B154C5A3E70CAF401C817D6A91294E309A4BFCA0ED2FCA1BAB0A9F7C803A8
      64E5B907C80EBAB56A4B43411C9874210543A2CDF15BE7880E3B7B6706BD7E08
      2F9CC4084203F16529C8E0F6550A20A9111C4DE00F22DEC514B7C81684A1E4C6
      243A2C78171AF28F7384444BDCF1C264F318D66CD3F7FB1AF5FB82C54E6B148C
      4118190F6D0CF58D19C5F8A778737162EE9EBB0A0B2F7F4C4AA1B766C80F4258
      99F62931599E48A10293B4CA3B883DC06CCF08B13C53F2C31EA3AFF05114D910
      9E2C57B02AF9D8DE3EB3DB12DAB29E1A4047A857B5FDBA14786DF48A279AB467
      7995CE2DCAEA557735E970EAE24036348866C37C22155EA4735713C22E1ED07F
      91A23F5977ECC1689CBAF774B5A0CAD5E48218C882DF8D6D4F852D1798A51DFD
      CC64F40FFCC94D23039BCBAC795DA4BF69C086EC4EE314C2142C8B4572E73D97
      9815092B156C64796C7F7174A515561A0066EE9EBC5D19A78B9C30A7FBB9B3B6
      109E507238B099A67ABA345E300D3CA1C0E63EF27B47FB68E439AF4F082F7A3F
      1FCA93CF1A57C506927DE38538EDC5AA11C9AD051A3365BAA85C7E3F7CA9D9EF
      563AE8ED519173B3DF3D58EAE7B2747E1588AE0042BE942B4FFDAC8B588C9C48
      CE17F322038DB2104F247D5F3436559338BEAE0764A796B016A19F433F8D53ED
      993313A983289856402E50D789C16E0282245E77A335D7093E5C36DDE06A46CF
      14CF019291FEFE1E860C717190641C345B1D756066B6950108D46816EF555F2F
      D7B0C8F8E255AA119CB9527EFD14F92634C2556ECB750B659F7E61373A974FF9
      D5962159ACFEA9FEA6EAAF0E0F0F0F0B5E4166E1638600DB79547684EA3E13B5
      F73F8E5EEF9764A5F192E23DA61E4FEBF2F93B6ECAF39055DB64635C40708E0E
      7E3A3876BCF9E2E156DB3DA31E845CDA6FB20E91F0BE8F79E87D51CD2E14C943
      032709769749021D12F28AA079E5B075CA91727DDCFBA258C65A0FE0E2F17508
      DBB94A8C2499026A1644077B18C696016C285FA582A7B4A6FA491027F085E229
      5315C584EA3A09630F1CAC8291FBFA5FC47E719756D562CC9287C912700A7FA7
      25B2AC128A6E6C84EB8DD9A00167CE1162FD163273E9954657FF3D757AA712C1
      21388312D536441023714DEA469D83BFBF6159744A52748635D91D24281D6F9E
      687B21C4517B870707AF8EF6CB7244C9F058D00D3AE6958F21A3C864BFC1EA0F
      859C0248D93C8A8CF1D1110A22BFE97968DC03DB98143C283483624793211AA1
      430AECBA8623E6C8FA42DBFA6200DFE805BDDC8B5ECE656EF23B061102AE829F
      6B95329C35B48A966608D4279D5D2C2E2E04AF8FA38ED926B3FF024B4C535B4B
      2199AF97BBD520467BDE16BB81047EAE15E542759C85A59AB1EFB1AEA9DF0E1B
      BF1D913E59C4C9724E1578215431454570909985BDEE21B0A874B89CEBC687F6
      A056747C1B7E68B63B83DF2E2E91A81E752FCECA3F896A6C3C7227F9D25037CE
      44CFFC380C7181512A7AAB9A8468DEFB5780830A07DA6D3D816359C06E6B4601
      4BB7F44B51DD44CB20FD629025A4A2A1836B3756A35FEF6395FFA23E40614230
      151CD1207967CEEF92F78586CF806926278019C10BE1BCD37C06E5CAC2120DA2
      EC8BA07B30962720118442BCE213A46827F3EB1EC225D0AAE5971D4DA72DEAFF
      2F6C6ED375C12999405817E262A22B812EF467BD0E22CAD6948CF8AE32A0A0D9
      FFA2BACCEFBEF343AFB86B0105E2551F6B144433162E1AE9AFA5A9930692E271
      325AAE83A55C3096312C00D146BD90B04164D16CB8A28ED2245EAE6DDC612D1A
      D1EE3E910021F55EB47EB0DCE50525A771DCED81819445CBE2322A9FDA1539A1
      4412E06F510A7D2EB80DC773E5FBEA2238BF6C5FC4BEF9A25A7320E30B92FA8B
      600003E3FCB25DF4C2B808181322BF731BD55EF1C262FA223C14523B0E4B08B2
      B3CC9E7132D12DC00AEBC883245FA7A86A2F2E86A863C6D778EB3AA9558925C3
      36E80DDB2C4768703E830F26D61E836FFC4C0C1169DD5AAFA55392C5AA37FC60
      F4F28F683B817DBF8F3EF69DA55F66CAFC946998799F4AA3CC66263D049FDECB
      57FA49CC796CFEA2AC2E8463AAA8B5A17C398B79647EE80EF1C07B896ECB44CD
      DE147FF773600A0AFE2247F3B5D2D98473F244FB5212EA4A6F3DFC89E8D0B890
      884C346175976847504C57D8E981F7760BB7880EB6ACF1643D9645CED285DC8B
      17134AD493EBF6F2AF2FD55E855CDA26F9EF9AE3601F853B48F744AA4D17F080
      1A166144DCDB5374BAD969FAE9320CB26208FB320416FBDDA8BD3AFDFDDD853A
      3BD9078C2BF673A23388723035567B59149563C46E86A03CE0B1308E773A62AC
      722AD5FB523E7E03AC1B7595A030748A29938400519E8DDEB9AD8CC9AAD60E97
      2513858B07F1C89A4EEACA0B3A1A0AFD2F859F4C7AA493A0B3EDEE49765F0EA4
      DE67C3CB80A68425973AB3C1D03ABCACFFFE925D132238A1A6E3440AB23DCDBD
      FAEFEF7E0F83C9FF0A7F7F8DFF9FEEBF57F12228D187F429612F15661401C339
      A74B2876CEB1540AD609710F57E32C1353E7708D631881C2E6BA68928A8B05DA
      7D9F0C775A71DE35ADA63A4C0D750191A6396AAF909EEEC9A03047AE0A713C3C
      5936D74AED42C3ECDEA160F9841D0A4673302A2254662CCC83580AD34C464C4C
      68A8C800810C695DF0F6F0F0AF45EF02927847F48B9279F90F25F94730A10CD2
      7849C0A27D9203BDF397A3E3B73F80464E116F02DA4D98C8A4694DFDE5E8D5DB
      9F08295889C082AF187F7AFDEAADF28D811DBB440B17C42528ECA083D0B9ACA3
      0742E79B8DD2348BA2105831FC97227F6BABD4C0CFDAA816143C5959B8C453C9
      642E38DAC18D5BADB9AAABD3B3B361E3F4ECACD9383D1B0D49B0706FDB702DE2
      CDB119C8E5DB1FDE099716E41345534FBBC30F1604582E54ADC004617E08F7A4
      19CB2431E1DC84BC4D55BE4319325456847E16C91D104ECD6A13EE5D68795439
      2D67B169B50A532438FEA4827B27441676FADD3DBDEE0A715263BCBAB2787534
      1CF1F0C982F9DEE25D82C532896F28B5E3682C205CFC4E687BEDC1A5EBFFCF20
      D4376AEFE887FA24B0A5C5F6B5A917BB3A195A00D27FA8A35787E5BA6EB2CC3B
      16DB4B27497943BFA021B145AF65D393CF86FB4C41B6111DDDADAB35DA370989
      F6C833EFD470698C9F53173724FCE2A480FF0AFDD093F3D76F90CD6F02AD6837
      EE70DAD7D4C73C89832CCD235325B5179C6B4BA79EF603BDC1724FE71BD9361D
      56B8EA9B49365FC468963E6492FBCFD40904A5DB02FAA738EA9F4160CFD2BE8E
      8B4DEDD144EA33A56361330BEDADE308D01AA866B72A03ADDAE225825ED2F09B
      5A7E895E21316619CA880C9F2C649FF8DAEBC402E4283C594701AA64B554A5F0
      40FAAB51646C69B9B2EC748843190A8D69BC75C46CB5CCC2E6BA283F605160DF
      9DAC8194B884E8C38FDDF686218A382E393362CABBA538BF819D1DE96BA6E881
      E1656E916064726CE1AA27997566B2AD893A8DD54776F4E569471D1E1EBDA443
      6F2982E09EE25D7FE53F7EA1C0FBCBC31FF9532F7F3DFCF1CB4BA7213F01D110
      65A3F883B9C5999B25A89321A3275C736B5D4AE2178C068C6E76DAD9EAFEEC17
      058F9949100E62063230426599D84664D14F894338B05A8AD77E11FB4477F164
      D3384767C11ECC7B3F89973EE0B9147F16D7B0EA594BF18E45C7E3D463EE0112
      6CCE70A8FBE694AD97402A801034D3F0EB40BFC73D789F640C0A148280858AF8
      B3B852272E95FC7B99F1E6919C056AB0CB3040D45E11EF4D368FF314DFA2AEED
      949DC18C2BE496AEC002B21AF19FC1176B9333A9322E3605F183344557088272
      443AE47405F5392F19DBC5E1D8610E832FEAE73CF0AE516AC00487BC397C38D8
      C1FDD41EBCDC48C9DF49BB5F4A721DBA24730E5CA366E0CB3615C046E92A3C52
      DAD232AEE725C06B56552DDDEAB909896D56DA1506998A73D704DD662DF717C0
      3D20040F84F1893893422031894689715224D2508AA69914B5AC4623D12ADF79
      B2F9946D5B0E8064B27509E5E2756E8D97DBA02DFDBAE4DB19E693BAA0BB08DA
      44109DA7E84CF1E8371A9E1E7D11A0C246D2FD24CC4DFF497D848D8BC7CD6988
      CF925A834C0C5AC6AACEB08F8B560EB953B8B00870522D595F676EE16F8E30D4
      A926A8546040C756797889D3565844995DD252E2C377B88B2EFDEED17D5FB5AD
      3BD5F850E529E570D4D5A0333CB754A3D5ADA45F47FE46C1F44E53E9B390DEEC
      88B1413B1C6D52B6BAEDA2382BDF76541E0D528FBDBCB8BCEFA094A531D3B0B2
      5A7467C9DCA26A44D536898039FECF674B941426D82098A3C7D6F76F926F0C4D
      B6DB8D20FA3A22EFE27309785C1CA1CB2491341367788D5A09EF4422B03D4C21
      531BF6BD889D06F8BD734335E88D5122D6DD6A0E9E3AEE9B0B3BBA20696302D8
      B461E7ECB6D25BAA52004715FC30BABC922A67978274A75B614EF3AADBB8685E
      3115A28F783D1AFADECF15552BE263132A10E2FA20B45047BE9B8B00DC6282C3
      D1A8B141BC5082061A5CFCC131AF5DB8419AEDF645A375796E193B8066F1BB68
      215136477A4AE2C33AA8E652736D0C0C16B4E744DCEC99B9826CAFC932D5581D
      F04E15A708929450C46EA58C65E9061B98251307F13D7E44050D315B7487478D
      567778FC47108AAD26A788BF4941A5556F94B7E1A66C840C23C4620987D9CD00
      594D4ED699D918D1326E52AA2E2BDAC2EDE08932B191AC74451C3A3EEC42DFA0
      3AA5858889A526292B57E6303AA20DE8836BFD1F19ADABC9699E44010418B57F
      437D018FBA1BE9A47DB8F6CC0C89D7A77858FBF2E4EF0CC44C371C959DCE642B
      5C6404A5E1FD43617D3C4575E0CC483214A821C78723081002C75292D75C9855
      F9DB32148D484101D764BC007562160AD0DDCED2280934E07EF638515D389D24
      B654EF42B31F64247AE5349BCFA3D34E1712B8622B71ACFE0F20E0EA9C9F8FC7
      BFB448CF5865B6990D68F09657317A157797E2C9EEC4910D618D9433D08BA36C
      4E7000BA66CCB8D1FAE8A6D62E3F5D6C1B4B6E099D41A7230FB28523E2A71229
      52A54AEC6926FEB9391AC87815212DF298CD98DEDD79B8155B9D0E3F5853E641
      F2B56F1DBE813BB300BFE96A32A408A88D5B949C34BF9C0FCE9F9F168CB8AF8A
      7378377B577522BB0067A5460DB9F1C339F2E0453770AAE76FC751865E11BB1F
      06E2B8DC2099BD3B37CE6CC2D1EC9C9F137199DB851911D7B9F4E1501F748A1A
      990C6486E797ED0A785EFC6AFC9240DC8E3EEDA8391A8F85BA09FECB6623DA38
      2AD1D88E62F5C3A0AC0BBF4467B40D6E55F460835FEEE890C92D65DF3E5FD628
      0822681B5B8227912DC4931CB79FC875EBD2F322B41E245C1B7A2B70EBB2C15A
      D0ED0219B0CB50164C1EE7950E30B6DEC9BEDF2E03F425B93D0268256B14F5D8
      D20FA912E0F5E327F11A31EE78DCFFD81E8DC7447E99E4CBAC20B7BB7BF288ED
      0019B94FF751887CE7A8459126FA3737080DDC4573A4C2CE174981148C2ED7C6
      12DA70D3AA1D26F04B79BF86000666B13A22B5E21654396B43604B99EA56E129
      071776717AA18E4AB23AD24BF44CE4A91D6D807EEF1E2F7DD7A75EB471F52D25
      CD45B3C78CC83610C9B2E00CBF92435D9462B35E73B3F52FAF46E3F1B0DF6937
      BABCA9760264AED9C1DD603D9F0617E3718F1F4B560DC54E765FAAD6E5C9DFC7
      E3163F9878247941CA5CFCD6D2B81AF4BF0C5B389945C13655BA93E17A787088
      3638713E9BABA3C38343B7CBD4197C1C8F5793BE49AE4B1E4FAAE7BA2F86E034
      06A827C6E392809E540B80AC48096E5007D19E6C1159406A490FDB5D638D44A1
      531CAF8A8DE9DEB7A6B1F9CC7BA93ED7EEBA0B545EE5D30BE9C9549625730DA1
      EC770F5D61B4F15864B515E4F7F503E0BE05F10ABB587CFCA966B1D11EA478F7
      7ED1F803010B3E166D22DDA6619F6AB496B0BD58A851B568EACC64AD24589833
      74202B1B913CD37B9F99AC1B4DF5627D0F7F72CAFDA0A97E1F29993BB34597A8
      EA6C9F698EC4E73E00395E21ECAAFE44290C8BD5DA79BF4E87A361D59FA1B049
      DA682609F2C085507FB23746C3A4F17870D61E960AFC188936B6A1382528C29F
      28C284175E47EA7CD4F9E5D10EDEE9E5AB5DCCF53BD61EDF902675192A2DF652
      D8EE1666850F321EDFE9E900577B83A5F6FE519E8B771C69A4F1B87BD16A9537
      5972F21740954BD76AC793DFF543D38CF442D5D50BEA174318B317EC3F72190F
      F5D099AC0985E89E8201B57143420872E2A4760ACD692C51F10E057018A0F050
      8F994137AD34BFD1A9E206603B85DE3A70BA5B4FF45044826D40A7626EA50F19
      59CFC1CCDCB3708366EBC3A002B816C7D5577B73BD5C9A48CA8FD2955E125006
      5430FBBB442FF0D2D4F5620FFE2ACAD2416927284AB485888230B4CD4777A2A2
      5CE82583692C03C1457EADD11831F489B46B1B27B985DAFD7EAE63B75376D5B7
      C13D58A788E716F6EA0E39D8AB1E18035B3A3333B42AE286A2947370B713418A
      381E0F2FDA6D1BB6BD6358FF71FCD0CD41EF9224CC78DC6EF6A8D99DE45A8892
      11C615E9D232CD02AF8FB408A77E5F3F3F11F3BD9CA802DADFC1B0FD59DCC040
      4ACB53776667124195EA102A462AEA462A4535CF42163BD789CFD9F8E655F7B4
      5A86628B889F76D842E8159516C0D074AF3A8DFE68A8CAF2D10DFAD46A739A27
      9D4DF5A25E7C65440E5316ECDDCED9B4AB0B7B6272EACD4035A877431DCF41BF
      6B633B139D06DE3D64BC8D2A19AF9BEF5FA933AA3CDF02A5EA549942403362F1
      25460947F5DDF976C992C5B8107262E7BD3B6F8D9024EB6970954AB81326C884
      28E6399005AA72C898A2FFBC6340F4A2E80F877850A3737935A8E4798581A380
      83B28B72D1EC591C8FC217C66352B004661A8F7F3DFEC25364346EAC10181B8F
      9BD9224E9754FE7BC5C431C1EC094232E371F3BC65F157FD2426E22300BA41BB
      104F61C907D6E272C5AC89232831171ACAF8EA97E6F959051FFB073173DEA19D
      AB0BCAD6D6663995426C26B450C0BA5D527D12C7D7AA6D84712FFE5AFCFD11E3
      20256FEFA9FB43843E480D3D1D1A4E11ECF24C6A59ECC76A869C4EE0513D4468
      3996A031B88694087A10BE00387801B01B95F64A7B31A79171F512060752F28E
      6AD789726FD41C39AEF2A0D7544C1D85A97F36C885AA61180033EA9C96FE75B3
      E6EF8BF3DB5A6A9CC884526922153EE475107571CA14015F13D8BB1D1092DDC3
      6C1D1A21334D7761316AE569162FE45613D11E4816BE6C61132C77180950FEA2
      B031403471927A679DF82B718800A2DEA71AB4543A237B546D30310A95FD54AC
      96C5005DDB4902DF5E69376356AA65C04D2A45FD4E73B1C9D1FAD66E5497BD58
      15DA90729FAC29B40B552DB1711B749D277943CD41AABF7A5D1A5C7F12CFE3DB
      C6D1C18F6C7C13EB4AD1B0462596C9710738ECD78A8B0B83D7ADEDCA890101DB
      466479A35A99994CDCC4562F00295B51B86F5D36147EA1910CADD456FDB3D338
      38E015DE4962AF747A90B5728BFAB8F2A94ECF6374BCAFE2491A932FF6ADE77D
      EB10C076631626AE904AD20C558F8CD585565F8AC18403E83E04F2E942220CF0
      593EA9EFC0F37C97F3D0692D0B9E44C6E370E2A5C1F88287729ADF782C4FEE64
      C8E9C6C6C9D0E28C2C515B88C8531CD9FC200FFE7557FD91C3159C745C26C128
      D53D29239B80B5AEBD8EF422F0EC07F77718AE20D10A63300119F2A24C46E58F
      50D75F8F837EE3F144F2875C5818EA5B591BB6AEA81842A826C15EB95DB4FF7D
      2F50D05752A64BC86409A4FA4484AB4F7222B9DB5D1980B85C45BF75164186BE
      4F373DBDFC8D8ED66FA7FA6B747F8F922642987432FCE58118E0A3E49CEAC5EC
      6233F11C11C76E11C53A5B6B14A4A16295F27CEC704B4F835B107C520A024E4D
      41235E39190C0B8D232564B97D1D42B751839CC0B1D9D46970CB9B5B34D6AB7F
      F5F52A7289C4D28EEFBBA1929983F2B726D85A2B10C1A21C0EB0A7DFB0424F4A
      7159DFBAE0CC282D236D5C773E9A8FB6BB2CBFCE50A88777B291AB9C3C5F2445
      E56F53F390E95165F5D98E02961C206E92F622CECC3B621B4BC92D2B28EDE3E9
      34609E90380E536620582B8D5E82D335771223D5C38DEDB497E53AE429A659CC
      147286996BF1772C33C5EA85938A487EA9258DD3AC31DFCE59AFD1A1967228F3
      A249A0F9514096109A477D4F8170A5A31CB37F3B32578144B6C02C8F5681EF87
      E603BBBDA8F6062B4781F923F0EFB5519FBA70DA62942CA09BD2726934241A25
      5E43B73CAB543A53DD560862C5609A6DA073A9D3074591B8FB0872EDF0122546
      ED3628B248DCE86145749C0ADD801BAD38143E7F72ADC91CD9A16CC896D4B2AB
      A2498C0453F5C2322AFB2F28A3CC38B51D009285967C21FE31AEE2A72832A83D
      47B0B70FFB9F0B0B07669ABED89117CA2C9671A29300E11FE93D008189534C2C
      624C70808469A3D91A74280EBB2CA6B08B3338ECFCCC4B26C4169000A8D5C761
      7E9AE27F21D4A72AD5F6F9C9A0414585C230C07565EEC847615645DFEC305EA9
      8369FE7BD923897A5D15A48F7BE93C58567F41FEE889C9E626F5B56322A57B2A
      179E730C9F5293886B78ACFEA68E5E1D17E19E3D18AD68DFB556C83399AD1EC8
      8F8ECA5FB61B140128113C5FE945E3F4F82B9DA0A7B3988538F5B6CD335395BA
      BB674D4B12848766734447288E89C4825AE15FD9DCAC4971F8F1F748EFC7726C
      1139A2F09188C14B64AEF2ED2230F6CE4D62940C5E4EDFAF927E393D4058DB16
      1472E113228117B783B6DDFD6EEF5F9378874635A5A9E2F4759BEF74D34D9BF0
      0A37416379D4DC92DD96F965AF245173C4B2A0A86EF7C7005E05EA9E822DDCED
      318C132C00E1A02F766483265CE357E7E3C4AC1AFFE777D3D4A906E27FA8A4DA
      C10EFCCBD1EBE337C888D99CFF9DE2CDF4A060395C68F47036B64E708B6BF5B1
      26F106694C6BD00128453CEFA2C011DC922932466CAE873C2EB5CCF1F127E569
      EA0A09DC25533B51ACB34DE4577D6EC4B1C3EC303100F2C663F5CBE81CC803EB
      F5E8548DE6483EA9737363C2DDC6203039C66836CFA09AC9A0B6D68056679FD0
      D0DDB23F6814EF7973524951BC2A7745625A67266B00164A15AD8CC684E1C534
      40789430E0394E9948858639F541838BDAD7086B47C3955EA2D2F9B722AB4E51
      034CB2B8690429775EA84D92862FDCD9D26694357A7A23A6A297D2879CEBF3D1
      23328B09415783133C439D1C872DCA6643C5CF52C3E5E6E1FDDA3C3FFFB2C9C8
      001B4B16BEA463C862CBF4655B8C16B8B083A71AF8339114411C50C98B65C20F
      327B482818299995B9513701AAC3E3844C8D1B54483209010131769AD5A0D36C
      5035C378CC1DCB0B0B90EE4D197BE14E8E204A946E6B9B45DACA70192785102C
      2751A3F571A7D9C1FFF3129DCE25C8435E2F3162DAB0349ADB27CA9B07A19F98
      C86DAC4F901BDC3CCB5797372609196627EB00A0F29C680451EEC8ED2F6CFDE0
      0E03F2BD104219B917B4CD593C4343A0A22513A37C70202C90CD2D2E6319A44E
      A9DA969C5DC6FB703B44E0B4F0BBB2D529D1B38661C9549FDEE1B83FD86D2660
      8A0437749A12ED18B548449BA9589D0D3EF5D5DC705C2D880AC64CAAAFD08CF7
      CAE2585A1BB3F58FD67880FE2364B4FBC4A8A38C4ED5E704F1934A5E904076B8
      1BC657680E9BAADDAD8AE8F15645D152716084FD4C928A0FB9297CD86CF61118
      2262DABAF3285C29C83984C3C01F6889298A2350D2B2926AA4DC9BF6E070B3A8
      0AEEF0BAFF71F6D1D11F6C1F49488CE8C9E5BA520E8B833B4C7A45A7C570E8C2
      0A2C74B2BC75D42505C2AAD1EC777964220EB11A84015BB609F1C95AF0F819E0
      3F5985DFD7764ADDC5C8E043D5391DF4484B772E075D4165C0DF464084C2B340
      2ED2583B0C551A2DEDE6E8783CA6064F4AC2A05C4CC3B00BEED7C809105AFA08
      3932671D79EFE0F23A940050625E29D8579C928340125BF0C9466D8EC75631B5
      0D1757A0C40F5D83E9641187CD130C6AB5E0205EA508B3E60BD4B48918E6B498
      9DD5D7B7008897D3FEA85A417AA03ED3C15841AA804767A5095A8ABED8411AEA
      09495370EE02F808F11300151152C9B746DD1FDFDC0367D970FCC7FB4EAFBE08
      5665C395757744BE5091004A1029C0CE38BE12A599EEF2E4D6F9E5E8999E0CC7
      713C4654F39F28E1E0C02D75E041232D1A8A7AACDBE4C5D7982BBEC71F64043A
      985CE88C916F58429A77F705E5F97007E9F9CDD6C5CECFBFB773C7F3ECF9D787
      6A3EC32178F385DB2E97F5D2F0177A3A45F331D4B4B8BEC4EB2FAADB3EB795FE
      7D80BCA99664914B2CC2DC7A614EF0F66A353B45204A764EAA58B6FC39BB4CE5
      E2CCD228F547838BAFE1A7BFEFA172DAA80B5CFFF3E0891E7A1FEC5BAD26B681
      261DE90FE723D7217096FAE7FFB0E5714D6CCC093686F4F22E16C7331C5056B6
      97277F87906A754F3F6E0691BA1147442DFA15318295F3F2D3601556D551BFDB
      AA71AD38C580242B4288EC5DF4F8E7C1799BDE874BAB3AB80768F980E454897A
      22A73A8A016B80462F2B1D24CBF96426EA6CC14855B813B885336EE5BD9A2048
      807DFCFE0A83AFF7AAD9727DBE611AEF69831FDFA92ED39BFF2F0EBEBD573AE0
      0FBCB33D12E42FFBF4D192795C793A4218908A7F0B3B7BA183E81BC6F69D4C92
      38E5F23CE20EA0C26509A0F25F8B87A15584B6CD3284925630320C87A07005BE
      835BF7CDA1C551F8DAE0D166A788EAE00F3EFA1F714ECF5CA0A91AAC3D847C1F
      FC46E71688906DDAE6CDCFDCE8E4A13FD38EAA624BDF3FF4D9C4784AA9AD3D7D
      F01B2766BB07CAFDC3FF4D7A9D206DBAF79279C20F4CBA78B9FFCD09BDFBDBD7
      4E2B3DBBA6FEC721FFDFE9133CEBA57DD64E13ABBEE0E39F69A2EDB576899E2C
      FEBC9CCCD1A1AA5B95F769AB0A930E3C2A31D17567AA4ECD441DABE3C3E33705
      52FEF0E0F8E0E8EDE15B4792A0BF1CBD3EC4F8A5506CF6BB4F25B3CBA2CD3353
      A1053E3399D438089D05C585A9AF6262D23804C85B7AA9501644A3049FB529DA
      39BAAAB5ED0912304390471CBB12BB2E85C0CB361A814A5F93028C82B04C1483
      1582098D9E4CCD9540ACA66FC9F2BB53CB9DB905882AA64D7DD049B6D30B4820
      09ACC888D551AB1E7E25FF6BAEFD378FC9AB9F7EC4312DD232E3F1CFED4F7D09
      969051C07D688E0E8E5E1FBC7DED3C0AFA6A7DDDF3759FFDAB6F39EF4FEDBD53
      F66133C83BD7BE7A5158CE2F5422A112DA3E2AC914A5E991995B0614288CF144
      D958F489291249A7C50D6563F2555192757932ECA8E2CFBB0C07A610494EAC26
      96888C5E19038528784D82AFF77479A4234A7E5CC54184C7B0E303518D5EB1E4
      296545E45853851AF59A442F87360BD910B68A1D8715CE49A252CB9704814633
      0D3E17EE30750BED7DFD459D9E5F522EBA7FDA452EDA16EA306925370258A860
      17777D2B8F2B2BF950FF03DBFDD7558DBEFA09E139E98743CC77CD51F3E26E13
      D43FC24DB0DA6E4F8B9E23DB50FEBDFFAE684F07D87DE53B1B4AF1DEEFBE573A
      45D70FFB88F259F778105851A145B216F71456B8A4120E000A9CE636F31544B3
      5485C135282EE4BC4BA10BEB5C49B87FC3F27E507D6DFB49EF95BE86607CA746
      437A0BFCF05EE909EE917CF99D9AC431F1D5FE4D8D921CDF990C499955FF728A
      4ECBFBDB8B70AFAA245585A559A297B75F1DBA268A93E23EA231A14F4123FF38
      C5FF88D578F645C03EDD33F043BB90F247F013F48E3D54BBCC8292AC13632274
      4664C83276846971EDA7AD85256D3CAB8371E71379FEC1EEF6FDF59F66DFBFFA
      F1B598346FBE30A98BFFECA9038AD9545B2D0FAF614178C27DE4F4CC6EEBF262
      E3995D900A91834A91780DF101FC30B17ABB05E041554A39B1F11814B5553C94
      3D331859824D9677C37563DEBE7DD826DCC1EEA3E059A9590B8690912547D924
      F4DB6524A60CB7236D50F489D036E552DD415F94F2B0F531DD29584B3A5768DC
      00F70E6F806206F2C639CC2C39858BCB51A7C22D9B2F2B37689744E5B0FF7749
      F3DAAEDFDF64BE7FF483C7E353B09815A6159C4DC0272CA9DD4EA15958EA079E
      E749B9C90EC41E65A8773CBE68F6DE6E3518C5EAECB2109D53B0DF6C10E75682
      EDD6B2DE65E67CFA3F0FCF878DCFC3F3F6133C129C3FE33131FD94B63F001265
      FE67A7C0FD59F5B9DD6886B6242CCD767CB45C13FB68D4D0EDFED07F5E5E5668
      BB193158B40C9930DDC1135C99668F48DAD9A1BA4BDE54238D0EDF87D19C45D7
      97723EBBECF8E0F2EFC5E0D8E91D9C2C7E9BD353EC84ADB0C17505A50822483B
      3C15854AB6EF5559187863E681F7245240D8FFDB24C105384A0064000A0934FB
      1069D7A38618750644BA46D546166BA27A7AAD34C505BE81D1785CA218655C05
      052A77081EAD97F12E210C902A624309299805FEBAFE359AF2C74DB1DB3B1B36
      7ACD117278A5DD51E8A19D1ECD994152C45614EC28B9B896AD9FC4A21DB88E0D
      F578396ACBA6C466213941E0BF2313E769B8A6F25A3AF9433433547F253C92D4
      B81115C1EE66FDBFFE3CB3FEEDAB82C5A7623A4AD46657D311428E74DB7DBE02
      B241A9E52FAD91CB60AF0F1AF9EC7687680E97A708F0B6CE87FF1C8FAFBA43C4
      6EACC885A9C884B182ED1A8F81F4B274DD9BED10454110EE1550E158BB02EF0B
      6D8F69B541027D9FA6773A43C19F7486A43480D4D86DBE24593B49E26BC38952
      B42E27EF4AD8F930EBA275A0F3A1FD1A86EDBE46B7DF2979D0C37B3CEEB0DC2D
      7A8AE661A83A51BE78B25822B50ADFF00638304B79F2C70513DD22983DB471C5
      55E8DC228A41F8FDE07657D7EDCE05577531B0BEEF823B1DFDF99F74F46D331E
      8B26972C529CA885F1837CB153E369E993A88880D3420EC0FF3845C26F1ADCBA
      259158043DFDED019DE9787CDEEAB4BE11AC7EEC0361209E990CB8987EA8D7DC
      1F4FDC2F4EC282FF79D46E96F4BA8ECA0201D6E655AF0FD0325C9802BE88119A
      573DD663B6048A391D2C6AD33A0DF81C8886D30C8576F194D9399A573DB74DA2
      FC86EDF481B672A3F1F8F319F53E1A4232B977A59738C7D31F80D2EFE01C73EB
      E4ECE29D6AE944DFE888A1223BF80EFC74344BE2DC7B6FF019CB0F09F96F6AF5
      92A2620EC6388856DC8A18C8C6EEA67DC19EF54C684C33CBB4774DF3BE87C6F9
      6087773933D9B98E66B99E999AEAA617E6366B85C1F25CA7C05F663598275137
      BA4C2EF3EC72DA8F572669268B38F9A05301DEE16BB81A26E9462726CD4EF220
      F45B7AB1AC516B96B41B756E97A8AD0C4091DE4D652F9A373A0811346327B49B
      7E423CBD1966AD3CB93123A9F7BBC358BDC3ABDE7D3B22605A733B12B7453C3F
      0234CF76623AAAA9F3E3EA2F8E6BEAFC55F517AFDCD80A631F8C3CC4B28DB2CD
      823F3334D12C9BD302065315402F310717FD534B7B825DCE4717FC5B039D1081
      8765FBC7D0D7BCFBE92E0F17B658C800A571AAA4F8335BEFFC503CB3A69A8B45
      8C8ED9F982E4768DAA09E74673B74EFBC34067E6D3524A5B2BBF6BA3786D65F4
      328EECC45CD9BA786ADC0E0AE27CD0BB747A4EA77F7A6C33735A79B82A2AA3BB
      1230CC1041051C38EA09B7C354ADC464B186A73AA3457E78FB0C727EB8CC99C3
      E46AD4F945B8C3053A53A14FF66394C25BC32870AD172663E54A6243448025E1
      961D30DFDC127D626D6D52A5D0D8CDF3D687F1B8DD198ED4324E69A10E761806
      8D72249340754065CF554A2A6E65389C31C6156FDB7FAA100C3DB29F67E2F836
      08EB0006013AEF05A71E95630BA10D4DA0D2BBC9A3C61C98D24E1EBC65A396A7
      562CCB4ADF138B0A4EE71AB9A1CA875240C71676CA704068EDE5BB3B21A29A17
      ED8D8089EDAC219193C6C04C357AE0D578069BCE103BC91C55E07525A226D77B
      FE06A830929F3A0FD961486478B251C153E1E7942B839F6E3D8AD8EE922C5CA1
      EA1D6BB925B45201CF73CF33A7A789E7DDE026C2BE421487150522398EF9E44D
      67BB7A5F08A98AE830F18DD554EF437B54A300524D86A600D2B663EE2E20D829
      27179D3D736A00F319F2C1E2E95E0CAF83E845E965707A73A7A032955051DBB5
      D687014335AF8234C0B5262206DB751AE5F03B8D533CFE17D0DD7F2B72FB0855
      06D8265BE844F4154404A6ECC53EC2882A8882DDC308B33F2F0A4B8436ACEDCE
      FA97678DB3FEE569A5116C9C108904CA5CD7960EC1792882A61244AF42CC4832
      218B6D8CB3B30CBC82CC0B886DA678A245BB32336D21C6D2D55162E72027FE2A
      5BCB2366863DA636D1C58C2CF10784BC29FA3688BC220AE18AD4DAC8C07C3B84
      FCED09BD02A49C01D605DCD557276BCB4E01EB07D52DAB3912D8FFCE03EF1A90
      2BE29BC4BED9925FE7F18F8AADB2DD2411EF203B88E030F37875399DAA9BA383
      1F5D71F3AF5E3D472C55BA3A0E46A774DDF8B6F9B1274874739B9562CD93947A
      869E100A4475C1820E9D25C2800B1B3BFA52049C53295195284F882C10A4202C
      723C490D0C79E4C396899906B78D349F820D48FB7E43FAE2A035A5491D23FEFD
      24BE4143F32AF08EB29144A18FB7B4883EB1A477D4285FEC9511C2E3A221EF8B
      A6EFC791EA46BEB97D51F030D830D6C428E21ED18B4930CB61D0E954BD108052
      2B5E4C82883B1EF3F777B4BE2D529A7DA6D2C183512977B660CB42D82D27382F
      5DBA382286A41DBC09EC2E1210DDB60AE3F83A5F8A570F79E37C879EC3D17AE0
      E2FFBDDB57E717EAE26AD8912E20EAE6CDD18163AB8442196C8DD28CE634C2CD
      D1C1AB83A3277F87781E45EBB33CC874A26EDE1C1CBEDD618433935170AC3968
      86902FDE3C0A3C02C03256131032C466CC42CAFB6A44741FA321104AEDE18045
      40F65341F4A077B98BBF6AA1479CEB3A45139686E5AC20623167DDFD060AA140
      74BF23A96A6F7833052AAB446283C270460C2BFCF71474547790504E86D2F4F1
      8692351C5EAB8B33277A1E9D787394AD6FB26F69A6D533B759024E0C8A3EDCBC
      A5DFDDFCA84E9AC79CDDFFD318785E1DBE7E0E89303CFD42D90055A700A374D8
      B5FD762BD90769285753EEE35CF62E81FD84B8A4652638848A9008F5E61ACB0E
      FDC5E03A6E0567A29C3B06EC80AF29F5D8B07FD6B6FDF1E43DF503AFEABC51B6
      52EBCDD580AF2EFF5B9D68EF1A8710C43EC373611D13DE700642926D028E301C
      594ACAA1E084E8E09C4DBEC3B79B379C5D9E8546FFA08723F18F78F64F853979
      D16F29F4984B1ECEFF7EFB9947052ABC311C76588B5C4ED24C7B96263C8B55FB
      F27250A3E44D4D8D069D8EF360C55E71015011F220CAEBF292393FFFC7CAF371
      06AF2E89491376B6781B44144099FAD9A440275788EB9C1DDC23DE1C1AF62E86
      5B180F3D9863C440C6BF7777B5A458F7D517D464B1B722A77B7BFD9C3484FFE7
      B9D287E4344182598E95DE39256F50F496045EA63E81856384484BC1F7979904
      6D4643B53051EEDE7417C31F6F0D6FB187A7BFF4DB05BE23F255EFD370D4E80D
      47A765BED9794CC4FF382E29B57C99D10B75D53E454ADB96DC22664282138D3B
      E87071DF474C5014AEF1772A5E3BFEE9F5A6F41A18E95761F93C42344E5D82AC
      CB174B7F67B176CCB5B60F78C99FFAEA7F5A5FD979905777E49C0D9D6C8469DA
      C475971B751598D5A3EF40B95F7DDEAF874C248BC765C25A6AE7890D9E1B794C
      184CD0EB40CA266CD7C9C76DBCF203D1706452D1032B1C640F4D8B6C69143757
      3A692EF3C49BD31DCBE6499CCFE44D0F80EA06BF6B9279B9944DF11718412389
      7D7E1D127728C99179082DAC0E4373837E240FCD6911A3CED5E3088357B076B2
      A0A208C05407E8C2A242A48991D9A3E128A54BA4CD9CDDD2A048B24B5843257A
      403588E26BDB241823B866419A6D1527DDE17AA0EE434F807CF21E2F6761C494
      BB0DCF84682AD4D5E0A1A95254983D71B68B3076CDE63C654538562D4FA381E4
      8CBE50C38FC38E5AB28B1AA4725E8106E397D0203326058736059529FE6996FB
      F1DBAD9B2E3245E0580C9EAB640E1AF6FA3B8F47D52A1757EFEE975E9159210F
      4C8E38AFA3FB9BFD74EF9B5D4EA7A8AD6A6344D747FF7878EFA32DF8429DB73A
      FD46B3D5E9BB8F705C1DA146F69F1D45477EEAE9A5717FF8AB4DBD556124DE34
      BDDD47207F30483D1386E24A499765585EBB9DD81F2579F085EC0CA2172B216C
      7124AC959BEC163F1DBC39727F991FE465A496E513BB6092B34BDF53A102B92E
      BBB0C811C519B910F6F93FA9FA7FA80F3A55432F0F977C64771880BC066E1669
      4778532B07616855A1D16BAAAF91846822AD9A9685609E894C6AE9E44ECFFAC4
      BEA7FE53F5B5775DEF46EE6E3039C1ADD6A5FA85B0C8FFA15A719CF808C48A3F
      80D94843B1D6C797A9BA0952F4090BF51A1117BA2B35659F44DB450571242D9D
      B71ED2EAD7EA1DFFA575DEA25AD9CEF9B9B375B5253EB8D64E12038E976E8FFB
      62B17DEF07296EC3BEAAABD4E25710194CB16A315B45E9EEEA78F21DEAD8060E
      846E6C4064A0A55A26AA0C1D521FEE3B2ED9D70DC2FB1FBB777878547F7B7A8A
      827634FBE45E654551F57D03163CE31412D5568858BE26B4043E787BF40D3235
      988D71729D2A73ABC9AAC459B51C7FF74F75A32F70113CA4496C4DE1E8E070DB
      4A387EBDBDDCC73FF27277D1010CA9ED8726CCC4F69506F09B844A95AECE47D6
      0C45D22A3554243C319B9F9005ACA918109655401D99607E92E13931120B9690
      42B22E829B9269849909BC7782FC11C2D71BAC9DDA2E1B4D76AAD1CA9B301D58
      E26269B7B6FFFBAD2AD71BFD7ACBD65880330518F10DD405A77EE06DC4C9C22E
      9E5EE9C4D5FD3E7E033D3BA09BCF9D85A5339FBAF8747E8E6E8FCC4D5E7462B4
      D440C820B4926061CEE2D0BF0A62F03534AABFDBF8E1228E20365C7BC3FDE5E8
      F807483CA234BD942DE63892F8C6482A53333FD80BB0B67FC169F847014CC31B
      D83B558FFEDFD7873FFDE0CC9C76FC03D4F970D8C1CDFFE1354BB23BD2F14965
      3071DDDA21826AD28FB8D3808B83BF1059CC3D1D636EFB2B97268ED4ABE34990
      3DE9B4BC389A868810A599CEF2148B8CB06F714AC1E39E91EB57105A1679DB27
      9D081973FD7354700FB41FF0548AE5A0A2534645112D2B97865442E20F40501D
      27740913C45E19801D3EB02C465B8470A5D76941B845F8676E424E186FB7694C
      A9D4728217BD312196BF5896B2DE4C1A1D6E21039994CBA34ED04CD4CED6F546
      E1993A3AF8F1E0C7578E77E62BD31BAD26707842E95CFB81A034893D4519F560
      AAA77A6A9E72506A4355019BA80521BB31A2EC4CA579CE9D03CE3B1AE99B60C6
      8E5A96188344FB534EF1C576B3F717385D5A4540F8709B049825B6750D4792B8
      5132CF5AFE5093752CCAE4822C35E1F4D13AED29C20347146DB42D60C1476240
      7AC40A579D1ED3E1A3CCAB45AE10D041F016EEEAB470F1C829A590F6B7D8431E
      F154065C154DE100687F9835E6B18ABFA8B5FEA2563AA1B5D0139872B63F2811
      2F133D93F3486F8A35A9F0085069FEAE2199373F1532D8C4C8DF329A9D5A6922
      15444C9AA213BCC4E076718141330CD0B5E1E975015BEBFD417B88C189E9A122
      F11E7D031E650537A3B5EA0C7BDC21178D5DD19D3AF00262E034B7FCEF7D4BAB
      CCF7B7E8E7620D56E279CDA4EF6E69BA22228DBB5EC9079037926AC44F276B71
      A616008F4D88A790FE405065360538EC687F22BDB44A822C3311BE5EF0868B31
      691B6814FD4861475BCFC61338F064AD7E6EB60ED4A90E42E91DED0338AE1646
      439D48F3540E0D1B342A131B3E9845B63D7661A8D3A783521F52D405D37CBCED
      DDE7DE2964E05BE7EEA10DDB2E43156EA9E21969E9F5612B491219DFAD0FABE5
      BCA1FA26B23F36660B139657857B986CE91B847F29D1F64071C537260086EE8D
      216D2FEA8A71C46C813C3D2D53E6CF41EF8461F116B459DF2C52719A114C5952
      64E01037D4FCA7F0DFB8A3141D1350150233AAA7E5B9739BC6D0644522E8EE74
      E8BC0AA0112B50B6E8406B08B0D9E1E2C549B7ED367A61863C387CD94EBE327E
      41DD350F667348D11B41A4B3F3EDBE297582EEF6F4B5B1135AEA442F70066B22
      B78AA4550AB37E1DE7957EC9F8A968975CE35720DC07A405C357936BD51D01B0
      5F394E5223B67901A513A64D9CA0A20F1A6552E68E260688475A9CA24AE5BE56
      7E0F05393EB3AA7D38268300CCD4646BC2CE9088DA9C6A00ED33A51804F7E932
      B7596129DA729F8A2824DF843BF3E5117C02A88838E12B4EF01DAECEB1A9EF2D
      89C1E66AE9F4897C9DE4C2309747E616AD166989E61AD27DEB483845EAF4F703
      141CAD89C3E3B7457E7AD419B6C2600183A117C35569A83EF2A3EA9CCB49D937
      21A7524B4D1D561D54F255F7CFD93643D0A1656532015A38EA00BB3A31D3C4A4
      7326D72B7AB7D15CEA44B4E78C6D397E8DDCCDD9C969AFDACA0BE9A63AF0D154
      76AA8673639CA329AF5F5943091447E3F1E7ABE6603C669600642AA2464F3326
      F30F75162AF3125C23AA12C8822F7ABE3A3FFAB57DB4F0FAFADC5AE88E3FBCFB
      5D79FC55B99FD865DBBEA464BA568B38A272001D2A339D12C3FB94EC28052EFF
      799C2704595D18B557E9FEBE5F533A44648CA2A0B81DD2A61312F34EB379E0EC
      4D02894541D8F2137192D6A8496311B385DC2FCCC4AA2955BC1474403627A78E
      9C3B6A8DBB05D8DF16B7314C9F2493E5DC0841149D246B94C9C1ABD4D3E951A9
      A4606F732D98BC279908C3D3233CEBC0DC9AEF087F8B89B8DDBA75FB017776F6
      580EC7C084019AFFC08E61C4797A90DD3E6896CA446B55966C5AC00070ECE532
      89B5F48696F28B4AC71F51B7699CA3432BDBFC62E4165D674103CDBD90AD415F
      922297332420F0C1A3DFB30BE3959CD391493384BA8EA80141F1D3A1EA307AE3
      A157FFFA97B100A24B8B93D0CAD32C5E1C0451609B1F707EC00FD2C4CC7402C9
      3159DBF564F16C2D69EA2840A68C5D842CB66B05BB9256EBF1E704E64177B1C0
      7D620BA198E4CB944BD0EEE45CB777BD38DF12F7A242A010A595EF3938B8407C
      E4C61CA8B3E0062E09FA8107BF9B1A1B6358991F5ED727E8085EE69AF8FAC0B4
      9202B5C21FBBDBE2F6A1ED3D4560B23E4281D1D0645B04675B6F72196D1E3CDC
      63C80CAA58A1C8753C5513706E70F8CDA66D824A4085B612E73FC75D370B7038
      C8F6BFC64EBD516727821816741366C55FCBD00290E4E1D1A15A04518EBC2F17
      ED52A9F1816A8660F59ECD2D9806C6690A61221DD99378859A06AA4E23596727
      1E20803E63BB96FD903443BA01C866FF2610E2715804286FA36B05C719AA9A53
      A52A8F3200A728A62895CFB65CCB0E4231BD9825AAFFF82D1AE693146135E4D6
      B1E4F9F2C1AB86A8625A7E25D479E4CD2140686EDA834173FFDE48068FFAFF06
      119F5310775055763C55A9010B4AFAF8CBF39120041D36604FAC017B1A6A50E6
      72B3524024020A4C3C6CA433582E09663129AFCC70472BE241F6923C0BA2B5DA
      B3983A84BB16CB80F334FBB6ED952DABAB98EA35A5C98217EBBFB0B17D9E9B37
      8F0380E44AD2F3C047D758EA7E45BE4D641026BE81C72A7596D2608B36DED34B
      2E64A7522E9E05463F505DDC7B2FC929C19CC5900B1229C167A865C8C4C0B312
      99616EE73A4F31D27BC999C24A155F7981A398471422BB3114694853E0B0B91A
      F36E1FAE87E401E7504FB9BEC0F6A7E9E9E512FFDBBAD38F6D739F50C786EDB1
      6C51287BB0A130FB68295DA0970DB577CD0177831B82C098B83BB6FC76A1A934
      7D51A8B220219D502FA9F484464F32BDB3309EE8B046A7B8CE54169A6A2F8BBC
      7A2A55FE1B8191C2C0C3F617B294E3E907659B0EC2F7459B6702319D20417DBA
      F41A47F5AF54438823EC165AEA01F48103823243EE754B4EC2D0646AAFDB6F0F
      F7EDF3DDE2236487115C07601AFEC71E8069FB6497F1CFC829ED368E9033A9BD
      8F17CD1E3F9AB222F6F7F670ED7D1C0E7BBB0DD5F4FFA5A9246018E9A5BAA0BE
      F47B17C5B0F86551FF89BFAABDE1E8A2BDE3324ACB676E7A4C040F3498FCDA36
      81DE43DFE3A719491E291D52398F57ED3BBD373C1D0DEE1FEAA1AB2FF8AC54ED
      F53F762FF655338A173AFC866127C97A8E9A6C7C7F9CFF787C74FC9FE03E1380
      067A46E0104FD699A94FE3A48E7F500DB27C96831EF44279B40481B6F7FF11F7
      B6CD6D2349B6F05FC1E5DCFB989A2669F9A5ED6EC74CDF90F5626B5BB23C96EC
      99DD6EC706488212C620C00640CB9A8DDDDF7EE39CCCAC2A80144951EA7EF6C3
      8E9B2251857ACD3C79F2A4448B14E858C0396E7F194AB8A6236A4E0BAED285BF
      BD13ED43B97EF53B1D4FC43737144BA1EC31053CA3D7D93C9995298AC2A6B3AA
      EFCC3B621292F9324B156ACD3D0CAEF4F1F0CB64A7C4E4286AEC00073F867258
      84BEA33C391FAF69BA32728E5CF5619949B1BAF0E6764C8E93EA4B5DCC06D17E
      3113A2CD5552591C511D8795CD554932ADC2126AB4A778F1DCE1B629E34B0ABD
      6060EDEAA13DA2A41E10A081975EAE41F100A35002413B143A4E41B85B0E673C
      1FD731EF115799CB2E077FB06B32BCE23F0C945811933271D12010B7CE4FD45A
      8D8111A935859027CAC9E480E019E62BA669453695D6EAC4F555D5E57CC4D829
      DC3720AAB423C8B6A5FF3240A68632AB381E68D8E207F88DF64ADF9390614ADF
      5E52172836364E66E03FA1D29D63B1D1A71A1180815F256246BA13E7B964BF67
      59908EFF35910C54B9858B32BD64861049EAF542F2D5A2E39F64F11038287D66
      2A8425E534EA04AD775EA118BC7A3374FDC484A9DC30D189FB1A67E918B087DE
      B2765FF7A2FD9F451247C08DBA2832AD420893569D95B8AA8A512A93344CEA6B
      4CB5720160A7D03CF6C13979D932C13A69F8D63276642DC753E21ED19E14B1C5
      21D66BF1D10A18DBCEEC1E3365C241C0F20D9C14B8933C9726073CB12742B11E
      F685AD399B2531A58C60250A4DEEB418BF761921E904702656CDAC00CE20CE6F
      8661A80B3B945812B674BD1208A74E4BD8941EF176A7E0C479368DBFD3C85B39
      F5C724570A4D8BCB27C501A33B5F41271C826A75C3289458244CB7AF710E214B
      2D1C34C6AC80D02B1E8974E81B0E10C226F98DCEB93C4ACE0383AEBC231E14C0
      F5E74CDF36B42E784EA71AED26C081C02A7DC4BC605C24D7E65C7AB6BD8A1C32
      385D7375C4B21BFE4ADAE4845F737EA09E673B7E086F1F913BD9C9BC4CC469C9
      78428ED2723417AFA617159800CCD9EB0467F738E675C37ECC738C08D73D2003
      F575D32CEB9B33EBCFA9CD0FEBFD983862B477891D594754C95C81EC6046145E
      3B114F78D522F958A759FA2FDBCDB73F555385A2759891D9E2B379392B44B3C7
      FCF1C6F4A715C36CE20C8C8A791943082D3A00168090372016A534C49898A24E
      4751927F4DCB22A76288042F476CBEF968BA68450CB42AC5FD11866E64558C92
      1E188C88EE6182EBA4CC12C6F7A5DCE764928A9A1053F7656FA33FB68F1BCEAB
      F87C3D856C6945CC85F694A5D354AAE0F4C4ADA12580EF32A9460545B8A8FCD9
      494F4754D800600CB364BAE8F9DF6E4B06782352DBDE0B04D296755F0CC52D77
      D2913837CC5204637AD1B8481C0D91B84A03DC841469639E2B78DBC134E33C03
      A0A77975863477C22E1F12C92E3B7844035E07488F13228FC1300CA3E58BDDF0
      E74D37195C0E7AD1E9D9D39D9EB5299DEB4BC2EDB418BB154D80E06E766E9C21
      C53C29BF2A1625CCA210F3E0FD4C711D85265C8CDF37AAC3BDF224E7402610F0
      01975060B038BBF997335A695B625539BBC6BD188232A9A411859B04C512F120
      036DF02859A5840030C44BF1946B6C3BB2FA044F1F9BE1A5CD29E38E7B34C05E
      0C6080E41D7097EB605FC55945E59F349F242505000D3F8776A0C367A476A2D8
      887911FD368FB94BE2AA9A970C09183A158CB7254CC957C5BCD6739BEBDBE2C8
      366161D497EDEA95AF2FA761681FB2E60A921B253460C510AEAE8AEBAA2E6633
      B9D6F29B28F9A69EC6D2A10DCD0B9C279C6E802A559D4CA168E60746FAF9A88A
      B2E4321EC1CE1D27CC2277404AE94A9421151635F0E43C146E80BE07919E5470
      A2E65005F101022D88AF171317736A3A2532160DFB3AC0CCF77F7EBA3E3DC39D
      2EE03A4927DD057B4DD61B18B4242B488C1F7A20B85FED98A94029BA81FA26F6
      1C979FDF8FB20FE34A41E652A9A9D79B63AA2738CC759F778F3D7B8926605A83
      B62A079A2246C5243AF6A0651B8B551016906CB5B3C67C57522CEC12E237B4A5
      0977603E5A2C05B80FFDFA2ACEFBE938614E381B1A1BDADB73D11B61D7A753DC
      D2550B3ECBFCCBBEBA43646EA211B13EBCFFB182667599C4D3957E7F830465A8
      A51D66F831040053A84192BB64ADA8CB14E380BB2C63D920A2B8F4DB3C89E679
      990070E20CA5799F879066A6F98754FA94519C63F10D4318C15108F5A8F2A3C2
      0D59DD724C5549B3F330476E50EC89DB7AD2ACD57401960DFC8C265ADB305575
      27D32713C88E8EB17694F688770BE490DFFC22FB98E3A13EF94910E875B4CC10
      53764C43EE5E79182DEAE6C1EF7868F6A6E05DE77DEAF848395D61ED3860C057
      53D80EC68559A3579E36298714BC207147181004E6BF80E8201628B903F7E17E
      41AD5FE6AA0540E97E0B1A1017B931AC6EC024FE969BCA8BF838AC825845BBBB
      DFF87FE091E182C453E413EFF556DEB515B75513BC1A9DBA838DD9C41B572D95
      03298E21BEFC726851C6C7437DBD053CD41CE1955B5414CE82936DF3F7B1643B
      077C1565642A698B95EB6EC9D4134286E03F061805CF818FCB986AF016C2287E
      A07E5B99DFB731C98F777D8D63E259B259606339708B3E9DD2094B3A806B5EB2
      7DC110EFCAF54778E508742602432022BA66EF607AE350B1F73DC51E7E2D9EEE
      7A2F47DFD05337C6CCA98E86C5B77022D8E759595CA588FE2B6C1BD23DEE0611
      F394AF42EF142E19C121FED648E6EAB3C2E86459BC0559E78D4725AE7C855AFB
      0CAE112855BA6CD66A6D8075EA1C708F95FBF9151EEABC2E10C6568DC3F1787B
      F89CC31475A88D6DBDEE7819415948E407923C2C37ADCB6D8D79A6DE682440FC
      12A4300C33184F4579B3F9509E99FF2F63AADB6C8F6936F1B87F96B7888FADD1
      7B9D48E6A88F2B3B40C1985678A01A1E60556537CD51EB4567D9F8342E2BF90F
      805935E41A881BF1A375C36AB691CAE5F7718F0CA27F2FE67E18018051FA142E
      C01776CB5561B7A8AE1FE0BB3177F6E1884816F8289B8364835714D717C71367
      1EC0D28A2A6C4BB62FC10815F2101FCF39B97CA28618421649921BB604647806
      B5C094442E200882EFD350C65725758A3AF555EDC319CE0D11A1F5E86D710D78
      4F6EEC6B5C3E331E6740178A097A32F34430A44E5392BA4E6B7C500200C10EF5
      7495EA3A851406D893EC1D65AC71C0023E5B22EEBE8477123203E9EC00B38587
      3E175BF89FD844887568B96A7C4EBF44F98E30357039A9AB948F6343C7C98833
      0C48465C876D68836E201900039FA7129E123D870A12D065654B6559790417F0
      18CAB2203302EC12B9C864400DE0BBC3797861D2ABD1BF81C0E156F6E6B6E493
      81D4F75154EB5C9143F6CE719759999BF8EC2B2ED1D0E21572055C06839E319A
      87E7A71EF2D66542EACF309980900BA318594F0E45E369CC9197ED4C2D741A0E
      536A32CAAAAFA22E7E85CEE9137648A99223BC8AEAEB02486B9DE6605C4B191F
      5CE7962A802381CE3BDCA82C6943E8349B2BAC7B6C657A4262C41A5629BA76A8
      52EE926DF0052106F1FD42520873103737AA9FCA5460B0C9C30C9CF157641658
      7297B37841D1615A7B8F25007A51528F063D8E20DC329676379F4940FED6E805
      28A6FCCDDD34CD886D036CC6D921DC3AC9E7308D46925D4AC735157F7B1A7503
      9065FEA64CC7C2C0DB09820C308F6030F006817FA7A74CA94321FD239B38AEEA
      5EBBF732F23427D8EB3011CE7B076EE30BF5594143F8D4BDE84B92D0E56487B1
      E6E4FD74660D5FC1B27F544525D878E059B5B70287430C4BA4308C7B10014CEB
      24901FF7DC38615656516CF5C14C64A60751B3B8C41F5D88A8BA812F0EF748D8
      A70AF0CC73F2AFE08295373641BE09DE821C4A748E4FAA5CC3BDE84A387A7C54
      3A15B2214D0EDDC30D4992E5635A26AD55E323F6CA12237AA01D8D3090CB0661
      F33DF24CF6C8BE719C47378A340DE70CE3BF8ADEF9B5211DD4BC6CB33BAB0840
      A510A42D2FC92771A3F3A8869094F4DE89388DE75CA48ABB0EC48D00ED3302F2
      52467053A7D053205B346720DB5BFD2CE27D7EDA8BE620432615897E32364044
      926952828EFA56E2351EE60E0066829D8AFACE90C02257AEA0B2B74E8EDE60D4
      E333030203138497565EB9A243EFD91B52E106586C0C180B804C565CF2F211DE
      29A0B757B672AA5EC4A8B6C486E59ABFB5AFBDE0BA75477F5C352F456E377719
      5B1E42811CA68A9180A599A355A247B8E5D8F63454801713EEAE4B6D0830767D
      545A6AD03A3CDC99FD389DC535D3E658AC5292D0266542AEA63202EF40C21533
      E251051B271FAD8E92E4512629B1D2EBCA7B027257F4FE7FB74A02B5CE77C56A
      C948901A4C1D6998E4C94478146990B22082F1691D25719592776144D99B06FF
      40E38870D33C3B9FF82243A87A1F8A48A72EB159096C46494B7A10CB450FEA0B
      3A302B217A298178BA5FA2716967294F5825CA329A2186B106E8374EE4B15A4E
      07A6E3109D4A018B95FE6BF2E8AB29130B5EBEF0F341F45E6ACA105CC3712405
      411C6765F32E4260357A9FCA39CE23B78C2F1FE58F0ECA62E621E2775EDAE262
      99B4C5E25AE6CA2C66FD2C21A9A4CCE59EC4C76C92B9FAFCA37E2A99723BD442
      89663CA3EB1AB98FEF4DE880CB473E85D0A8CA5AD8D302660F9C7F10005841C6
      9971E4482793BA8FCB69D91B71EBE12AE3D85B4C489EDF84A9C57C5A79CAC25B
      C5F15133CDA48C6570C718D5858CDD657D29B4B0981D4702AEF6032CD8C43010
      749794793F18033A56CAF484948DE0F23DC1452C68C9DE3874952DFAF08CB098
      29492FA61C6BD26AC11377B4E21180CCE5198F2A0381158526E83B1005FF7E03
      846245198842B8D14006428A8F55D8B1396830E0BDECAA126C900E4333076F84
      5E6FBEEE4D14EDE58B4DB401426DB8E0975E1040F33370F2202151B4B8303324
      8059709A91155E2C3C96F3CB689C64752C72929296824A0C5F42F6A1FFA1A0B4
      383A55B65CD19D900E6069A87EAC8637418FEF986517BCEAB234BB49F1F2C5BA
      3C3B48B1DF9268D71A6215CE43F80F5BBB880E475FAAA48C25B90D0B3FCDE7BC
      111AFB33E8634BBD08C67FC4027A6EB9AAA58F8B9505DA749C375F361787E7CF
      5E45A74559E2A819BB85D1C5CE23B816ED5B50FC66657421C80C95A464584F75
      2B6912CD455DD7DC8EE64E86248D66E0DBB37658E8A7B1F2EE9CE7A80A4C6BD6
      8CEA8F49684A147D7A9A40E457921F31B79082B87BBF4EAA67DC187D1E7E6E4D
      8178806B01521780E17AAD15369A4B3CA62E38549884BB6574EE8D98D6A1EB49
      0FAF033DE847AB8166F74E94EA0232EF58B9E3F42BCCFFAAC5E775273ECBB140
      C399062E5866F4389A605D0FE350A720EF5122076C50110112E8A212794377BA
      BB90F2884EB71ED596A3F2C8F88D034CDAB04CC7974AF1BB8C672624CDD2705C
      859DAF6959CFE3ACE362BA9662CA35A9A7764FD277A5EE01D039360896A0C1DE
      0E2290066E7752564CD227E94AF40635E3A5238762331E482ACE4A8A604E3445
      0658C715FDE16B18E90FC02B381C206818BCF42F7F37111B61C57AB82B85E58A
      2BB94136BBD3E22E89D789ED6AF8951F4D790A8C1515B72234E17675515EC6B9
      EEBBC8F1FE805C14632484B8152288ECE66348193566631D9E9C38D202B69CAB
      C9B73AC69673C4C0141CA75FD3B11211CC29ED2E85AC76245E341D2674047435
      C4D207195CE635D7F41BD5FC7030779A87B3A6E82F1DF01654A1D5116073849D
      B3B923053345AA38C6DEEC4DF481933989479840B803A229509731708349515E
      0349D673D4E6578B25D1F8AC82970BFB948F45815291324DD9F08B20EC8EF006
      AC473DB9E0C70972FB5479C7019F14BA5C6A7BAE1213308904857E59608526A5
      643AE9F6A4E578110F375E50F624751B0EBFCD622926CAC7AE7470FCA1E08D77
      BE36A5EC94F1275106DF5B1E2B48571A78DBBAB8BC14DA7F05AB07BFF177CA2F
      DF7D8645F24BFF7354DD4C87205C4B7502571821F43ED8326E96850BE74B7233
      2CB00E7CA185EFF0E07E83FC87FCB0022981E695539E5769C402713836255FD5
      55BA5139B098D4527643D430B1B01803C4FA9D25A595841EC695B841849944DD
      2BD174765320C49C5CC7C17D63C6C2F2C573FB24BF9E675FA2339FAFCC736ABF
      2E33E4E1AD8BEB0CF1639FECDC8BAE8A6C1C8D4980C772C763BE24009A19A6C7
      64AAA7518C2D91DBDD234C009721F323C6FB4826DE00551A0737339792522593
      B984A45CE933F16FCC7D122025F91623A065A9109C2A105D14D482411FCC099A
      3679011575599800644C0445B79BA1374951E7F7F8CF0A8097CF2A0A9F9F0198
      98CF481EA3796E0B5C41EECD27F3406BA5ABC4951C081F81770A0D7E03736F5F
      F153CB7A29432FB4E9DC4308C4AAB3F3F8F32B5EF27ED8B4506819BDD53406FB
      8DA3D80C4DE2D65EFC4C2AF786C6C5121040B8F57695BA5DA4FDEDB36626F7D2
      E60378A826953B52D7A52EE557441DE795B31198752D19CECC445918460C9B5A
      D15EDD46F02ECD3B7619E061167EA0FEC59443F73C17C5B1A3C54D839C4A8108
      83B84F0E17F6AD873A071493C29A9924C978085FD593E4E1EDBB88876179DC71
      1E3874EF1EBC1C0D2AE9F0E69321264CFF04D8D86633D2CA287283DFCFF80CD7
      21AD35EF626438E26D4A40D9A2F14E36BCFEC02832549E0E4DF6E0F4B1A7214F
      494E39131FA63FC3C38C8E43905BDE44AC5AF2B281E1D041F1EE0E66763EBD83
      CED927A1931EE763849711024047F7A167B5865FC328BCBC3E2B51E10AC26293
      E26E712DE24024B61869B5E2F9EA5415F8455E74780B6F1BF20CD70773154DA7
      C99850ADB3AF36377D4E8B7182F7F3DB84A53516728A568CD147121E402AA0A2
      C1D9C10594359626492F323EF8752FD1D7C80991BB21D0EF43356E97C8842521
      BD96A82F4F8505EE2D37A97B80879E8CA30A9F21EB1B91383C2ED4880D931506
      792AC9AD0CDA5B3AA54CADB899920F163CC53CA606F37F846C374F0371988B33
      04F46606DB42DE17D40B958C206666AAA41C3E225FD610D287B975A9F167B468
      89BAE96325EC394CB23451C953A94D8D72EFEE36B08A5EFD18C510CC4CBB0B4D
      28F9C6E34044BCE30AE7C1CA70C894F99620F119EEC9179B15294D90BA3D990A
      28B2C49864BBA499201F57CCC2F2D11FED89D0F3E6CC87F3A7075700BD1CD968
      DA10DC8A115D6A7BAC3A2D2C68A65B91EE4E2F3435043703C641C43545116BC9
      514EC50F606283F2A27878696C568ACF92D9770D25FE18B63822878D6F6BB126
      108ED41F6065734B6C039E1C64D4621C5C168E216EB031D5C832CABBB7F77DEA
      90BC27571E735A2CB518171BA59570C0DF01453A7728CF482E3FABD8B0D24406
      773C04FB5C053C2E7CA44CF940ABDDF9E1C3ED0C10F738CDEBB218CF472625F4
      4DB2721A829832E9608BD15D515A8D46357AD174AE7FC61EB4C843CF5174EC08
      F055917CE1474D91B7C419F23AB872C8EBA01122EEB3BFE05ACF9A0A39470410
      70B7F19CA3EC8358EC2404A95A9C576762317A311CB17C2C35BB51E4C3076EC2
      3E9AB38838433FCEC77D0987486285AE2C8745647E199569F585C69B9656B763
      48F323C311F7B83D51087BD3F84685E591DCE2A01F85A1BC4EE76216C2ADE32D
      7313DFDDC1DB33062CA817AE7408FC7956FDA0E4FC3A33776A0944C4662CA354
      A61B1797B26C354F479814D6E9C52B3ACC0E59319B5A29D2CFA6CED80269C0AF
      3089BE60D0436E40100D3620102CFF600616079AC6619206050306D1D1BCC495
      0E08495FFE51256536FA14E15FCCE713F16B0B79B3B2BA130A32AAA3EFBDD306
      E76B58D64AB853FD31D9D88A1B9B4B87CC28C7D92AC5BAC0589B814717758FDF
      1D9DED4467A4491C4BB851BF7351CCD251D43D38DE3BD9B9437C41CE2A33C50D
      E0F5A6D5ABE8F8DD9950DA8EDF9DEDADB3B4D0BC6DAFC08312E2609E5CF722C5
      DE823B560D86463B8B1A5BB4B285931AA4480537B545DC60F8DBEA082E5797D4
      CF5C297E39482708C4DA9158A00163C23AC268966FF0B4BB7B952631DB307732
      756B158D8D248ABA392450F1B7EE4DC5CC537962DCCF1CF6C0720FCF2A388D13
      89E4B08648EA3A6562F2CDA332FC6D424F524F8C2A697643DA4A4BB54D29F5CF
      85C9934383CC6A6DE54813D534895257F3E6E3B8EF8522A83F25D8CB87750908
      0781A8246F26472F9AC45A3FB085318B2B5E92DA720917D345792A0ABAF2F78E
      9C12AE3CBDEB9DFF389153483E875B67C89430831A7EADBAB35EA42840CF0372
      166E697D75118461D92067C72A7D6CFB2C3753860CDF72D98C8BFDB675334C1A
      F659DD2C2F08E164E5C9B3417FDAEAA2E62A0FFAB275EB01CD4CB8FF9C6BD1F0
      1008FD66618257A769A80FC45B400F37586EC88815C09C98E77C4A4E3BB22434
      786E92A71AFC13E119F1BD68782FBFB703D54B719E0257A0B54ED1EE4D31BFC3
      718513D81DFDEB0E297E3BB8D4C59E945EDCBA84543D772C768353483595A26E
      998CE625323D9CEEA3265BB993304CCF11C11F7F8C913BA66C31DF0D6781802C
      1ACFEB2BA40B920D5925CC65C85D3EBAE915688B8DAC1B7CA7287BCA3CAD287E
      7ECEC8C69BC3CFFB3FDF6998F7361B66956C158802D89378817C801F79EA03AC
      1E76451F631A3F1205D38A527015BD4A8DFA89B62DDC09EF774D4FA517C26086
      A6DEF9722C42F55FD8EAAD7EEB005F2BE7CD69AD75D34132900730C39EB32A98
      9A0BA2EF58090666604B8183F6E5354B4AD88662C4E57ABCF11C369B93F04EF3
      65E5334D320892C1F48EF363C451645FEE640F58E6910007A7C59805CF344CBF
      365AC71E9A83690CAE86E1D40B56B9561C70E83ECE12C903882BC0538B2C4F23
      4EBB839E05E19BD7B60ECE589272039241E5DC047727810AF5471569FCE1294B
      599D3D8F3E9DEE1DA86761D7B254E4D33247F4C73118B318F24A5E176BCB865F
      40BBFE7C3EBC2CE3D995B805CC63BF0E8AB8283DF6B1BFE8B76CEC0714B952B5
      1B79C7BC70E7A7CDB2E5D004B1F0BA88AEE2722CCEFC7D742CFFF4C38F2CF1CD
      ACA1BDAAC27816B9AB36C4BD260EB923348CA3D76415FC733EE5E181A369BBB6
      7FDC7DEEDAE65A35074DEA20C90BAB92609A37B74620D945A2008361D302AC21
      4D5366163F36951E45DBF6F187A57D0C74DB62590F182FB0FBCE9E3D3E7AF749
      C858E3740C84D517E402AEF2EEF8E83FF81E3F1F1DFD07949C174F8BCDBBC79A
      A2D2BDE3D3BD8368AEC5A225BB3CCDC9857B76B5DDD39FECB214E8E2DB93E187
      7757FD813450D7D477D6CA7ECECF4668423116520460376CD9ABA74FC3D215CC
      6D5725320D89CA31B1F7E9F4A055B593BAA7A828748FC274CF58DC8225B53BA7
      6F0E8FA25F7F8D4EE3CB74A4AEBE689CFCFA6B74B077B117F5DD7FEE41EB10AE
      7032ED281E556921559FE28340DE60EB9EA1E81C32EF2790ABD6E41AB29362D6
      E6A6EB6D253983AD7D9ED4C868A437AB64BD02096E27A1817D7C70FFCA7107BE
      729CACA97FFBCA0B73564ADDA3348F5E3C1F6A5906C165626415F9E2457E2AF7
      3EA929E0C3D8C2CCFE1DBA0961561810560E57B2F4B8E455867047737218B861
      1D26A1517B8F139979BF43D72EE2A1598AB90BA52370FF981E07E576535D67BF
      43F3A836059C068252DB1635ECBAC227099F6CCAE5CA079488BB446BBEC91E67
      54CD98270FD2A6ECE743A1168CA3D7E7A7EFEF57A97179035269E7E4D3F9FBA8
      CB183B2AC5CE922CAB762C68F150ADF116FA0C2B550AF0B838088CCCD337E77F
      64B1A11FBE8735272FDF4A1006D1C7C03AB5EB185D842720FC3F67C0362D1050
      848BED4AC1FEE9C9EE8FB8D72E0ECF9FBF42B71A01A3BDFD0F87BFFEFA8F93B3
      83AD1FAEB6EBABE8F4ECCF478220B1B60772298BFC31F876436499F2927ED05D
      29634CF551A5863C47A8F31C01C9FA55F4BA2828A5E1D30BEA02BF3165103D40
      4C1F4427C400F6AD7A6AD95AE06CCAEE7591223DD5A78AB11F24D9EC2A8D9E3C
      193CDBAA25008B2976D4833CADBDA5646465585D884C429EC22351366D2E7E6E
      7F94A5129E60E8C711C7BB02F4EE67E98C04C89D3BA6BD45E75F6ECA741A9D1F
      A26C9912CBA3135C3601E778308BB75B57EF8A6BF89895D4761F15050D07A055
      41096F8620ADD8BB0BDD68DB5B35FBBE445059A2D92625292B19DC1EBC1B0F02
      166F26916DAB56DC5958CD92B630D0FADA6379B3F6D8EE5D6A8FDDB74CDF2E8A
      D41D015C955210146F8ABAE77531C3FA9202BF87C8F4F829E287F2094C82BCB5
      C4EED0EA93A7EEE2DA37E1B5E84D521F57C7075E9C11F6D70C69D7D1610EBF80
      420EDB9A8B6815A7E72F168EFF2CAF523DFE9B56793F3FFDDBBBC0D8025E8655
      324C729689519D896D1BA7717FECC832908A11CD50C4916ECA34CBD291633EB3
      96ADC83868DCEE7D5920B77DEBD6F1EA30A9E4745748C0935B52142394E2E3F3
      29B1635213D29C2AECD1C9D9D9857ABF747E559FF9412F988116C656DE8745DD
      BD76198F034007A209EB92EE14661C24D5FFE56F1FE450DE8F33AA702747F128
      79879860569984C124F697414C64E3419AA45685C47CE47A9496A8BAABE103D2
      1810CF64A93229FE879A086925E7A5DD05BC331EA45356A8753C77F129BDBB3B
      47480F533D6457105BA1937A5EE6867EA270C22CAE3A77B40B757A1FE42DCECF
      0F5F4527C76FDE46D7C81D57F6DA09634A3F452787EFCE1FA4194B02DFBF38D8
      13916A5C7075F4EDEC758B5BF4E02DBCFBF4402DC8ED7855D4A0FA1B620BEEFF
      77FB3DF9DFBDACC6BF45EF839E7F0BC15BC84AB9FB0DF8FC8FBA015FBE649D5A
      67FB3C3E39FC1CF5A38F0A769DC63316F34DCAE802AB45B443BFFF71CBC688CA
      22D7E26C98A55F71E91900E0B525B1E715F67F7378B465433FF25ACF52267B93
      F827589A71D251074D72F22934311FF6E53FB7F4C276019BC5AC70CAF2F2A49E
      F324C3CC5E176536AE90D9AB49F40727FBFE80271224F1A35093446538EF57FC
      F78727CF82C9D4028DA87AC5130C85690403F0ECB568DF14387E067D8DACAAAC
      D8CE53FFD30F84138FCE9EBD8AF6F2D1550169384A79FC7FD17B30494F8AE24B
      31AFF91134B3B9D410ED112689A5AAA8F0CDDFF6F6B7ECC6732C3BCB21E4B5E5
      317E4B1735730713E603F9CE3277EBF3719AFF931EF4B60E3B87E4DD272464E9
      5289C668645AE4542726C49E9494D74161B8CBA4982675B9ED0AF81ED0A514DF
      F5ED65A37CFE25E6BA1489C39412CB691EBD9B7F89FB17582DA8739ED4D1D738
      4FAB2D51EE1F087243B4A44E67663D8CD34A9839E013484D60A9B9B86D1BB2C6
      9EBFB284A1B321268844A62AEA1E1C9DBD360CD143E95FD338C2615B94DB9AD3
      3FBC7C82ADC5FB488EABF35A898999C95D8B89BFEDF3BF5720C55D0ACFC42BD0
      0472BAC90D785C57F8B6113398C82C1C866340EBFD69360C76C09FF3E2CFBA3C
      B76D01AB418C1B15C951866431C73B39BF5EF77B5B3F76DB30DC737FC17D8ECE
      C1B68E33A99ABD8416C7554FEFD824FDB78D6EFD18F50D7D93C5A7AF19CF0A08
      66CEAE542F439186E54EC6CD3D4CD93FFD4837D32D2123FC0AC9A194826885DC
      3FEF92AB329DE22CD8B6298CF20798089EB960643E1CED529AD6EB01A24A6CC3
      92DFB65DACDA830F8D44241F4E4634031457DEF2F2AFBDF1D8680547CF1EBFFB
      B46DBB3FAA252339E427698E65F3A128A655B44FCA48F8D666B662E8B100E9B0
      357E43AA0E2DFE6D171CE3FA822920E6E4597CD4DA8A5294B8DEFAE1CFF1F037
      49FD2EB976712CB0DFA5F6F06E149797ACEAAE1C127BFBE3EB21534E842212A5
      F96CBE2580F0E3F31F15BC78FED9598F52A38FBC9EB822F3C8E883127EFBF4B7
      F37D868BB70D01E36A61D9E819FCDCB10615A5FC0EA28BAA27A8EEEAB6ADE0CD
      FE364F5158735E17916832EBA13129CA51D2973482A8F341D498CF8ECE2F18FD
      EC6CD9A450314EDE48D4FFE8E40C79FA9390A2C9FA67027EE07567C89C046563
      DB06719951E1590D9CA6947599F41595F4864A50930F2F4DE9B5AE642D7B2607
      02DE5BA2703FBEC4E9F8EEFDFE7F468FDE24ACABF87116FD3D8941DF79E42C06
      F250611B3E616EC7B66D612519C0E76A2DC8F5F736FE17F2F5DD1622CB512122
      492FA119BE6DCB986ABAC7519A53B10F5578B89CC6C9288B2D555EEAFCCD67DC
      4934FBC127E53F2C1FE061E1AEA4CABC78224AD24884571026AC7A57E24A8A4F
      062C2197246C1C44C14BAD6EE4B667E86D5DD553E7F0004261C83539DFC760FA
      FEC8EFA2CEA1E5C23CE75A11D98309EBC8EC763484A1474687A92AA20D8341AE
      3A68746B8FF7B6AE1F22261267E787C29A093B3D4B4A3191A55E6DE0EB302718
      A46AA4B3B90A28361B836185B4B7B2C5827CD06E9F84A76B507F9EAA2DA2BCA7
      9EBB028552AB882AEB7CDE83F6E6C5F308A5092CA5C6E1F3A21AAB52E6BEA80B
      658585B0F4FC9E0EFC6D3D52654CE8FB6A1E0D24C50C1016141295FE70AE98B4
      7A7613FD364FE60030E3AF2E2333AEF98C5E40ACB67A4059513DECACBAFD6C56
      2EE8D97C03241A4BD11AA9DFAB3A5C136A6A1B61E5F760E975657732FCA5A295
      E8E93B801175A1E7109934799CB1530C64E396428172590165F50742BB7FFAE1
      2910BB3D5261CECF0FD92996C5CA91309C98F7A4F4F76D8FED3FFDB80BFFB6F3
      31BF82BF1C67D96030E8589496921A641A5B6DB36992CFB76D08F7B08864908F
      4843353A7D7B7011889B87561D44A6C55E3AC7C56CF2F055D4458CA07FCC07FC
      1DE0061FE242F29B4784F5D874227F18E4355223AA41D7203CDCF218AFC348A3
      67A5CCA0EC0415F61531399172B683DDC40A41B1A7DE8A4566FACCA08E33C99F
      7683B039CF98438CC7AF4CECB891563131D2572D21D9FF0D3F874DFE0A4028B6
      3935695D4754FDD71D415117073AD3105D353D35F394C64E655B8E326C3223B2
      2887458BB09E3BD14E9CC6AB2BF6D2D472F9277085E176FB4C21C4E17A11CA5A
      866F338EAFF3CB39B2A0E07D201BB7C887454967647DE53DCF0FD1391D51DEDA
      4D1AEC627AE45D645DA082D4F5CEE0DEE184677F5438E105DDB40FD4319FC5B9
      5DD6A01A6EF940D2703554DE32995EB968AED8A9425A846C3DE6FF71540810C8
      59C5963BDF3F3BB957E8F64F2FE8ABB14684061E5D466DD56BD353B04B45F669
      4F2A1C21A42C32613C3399B796E473D902B8125421DCFFA89180BB65975FA0CB
      54B08BEB68B7B76B3A5CD56C4E36A054129253258C54E83D62A0F196DCD9172F
      77DDFC1DC4D3F8121E2030CB8498258391593C245FCF2147DB36251403F15A8F
      2F4E25C6C273D38478F3A8A48F4B749DEBA599622FC9DADBB64F90E4AA80E87A
      7478FE5E4CD4D3622C228ADB3E15C18B3D52713FA585D425520D32C50E45CE52
      6BA440AC0A14CFF04DB76CF9C7273A758FA18A0BAACA8CA0211793E46F885220
      8F6F5A6F8CD267713EAE46F18CBA39194B612A0E561A94A1308D0347F3475BE2
      422F08EF5690DD98730DA1E899E4ACF25F9A6EE14B59D128ADE6432DB7823C35
      166DDE7A9008D3DFCC984801F4E0A783777BA73FEDE5A90A045CDCCC9257D1EB
      18C7503A42BCFD758C51A9D3D1964DFE4058976A15F555348C913E8B156CD9FF
      9481C4D2A3DE9528905726422DEC4E8AC51545544DE32CDBF6CD09BD0AA87DA2
      95768B49D4394890B55125D1E16FF37446FCAC6383031FB7186BC062DB7661FF
      EE4B111D21B99A1728F6E17E06B00EF5076E2A145CC7BFEA92FF8291F4770E40
      85AA4CDB42762F99BAA2C5D3A60BC5D34CFE476BA7B11285D58AABB510E5BCDA
      124A7AF9046DAB88F1D7E04048720A16AA4A77B22D54F5F2290E6C013A7D822C
      19725852E48C4020F9E3F9C5B60DE058A1DED4C5BB531F946644C6721EC1AB4F
      EB1A153D6116CD7329EF44D955A603CBA9B77B0F4CEEE5535C8C2767076F709B
      C739CF0A692EF434E56EFE9A44EF3E9EB000234ADD226D8C101A6AEF5A0879CB
      6E3C230C995C47FB3FA3A6095C733E5587022785EA74CAB48E1972F0B54A9424
      E60357F7400B5F3E034EE972909C9A484A5C08E4679F806F09CDBAD8352B8959
      4869FEC5253916657AC90C19AC1E177F45E922E4A5D277D8B6AF38F9A5B83415
      3EE464A3FB20E1274729116C71528CE6D402F089BCCE8998165B1A1D2F9FD11B
      9F0ED3CBB9092F30D4F8A88AFEF6F1FC221079DFB281E7B737F07E6FFFE70768
      0007CABECDF99EB1419B8D18E6154CF33EBE39232F73CB96BFC751E316984ED7
      A30AFF6558968AAD326B5B179210840041609BA4632D6B051D1409A031FB01F9
      687A29A50F0B073A1AC541C3F71365501438795D80DC80E260F1E525AB816C19
      DEBCB50704C9C0D6D8FB746AF1DC344629B928814E3AB43BB4EA1D036397B229
      7B04A429342295C054895A5D687ECF95437E046A52F18521018D0401E964BD79
      B60B0E05FD15FC0CC1CC0AD4B7EC615F15600F8108403D1EE98161CF62633072
      332152314A6315B31C72F4A0BD79EB40C7AE82BD7F897ED8DDF565938D4620C0
      20B233835074A31A909C49BC595C46BEC5C67C49E007ED7DA3348A864E24E006
      E95A60861212C0AA893A48FAC0EB5C149D6806196911A8F1BF94952496824F67
      7CD01E077E3DE82EE82312D494BAC7BBBAFA22C2080FDA6EC848C19F524DED64
      AE5C5640F6CC046BDDC9C8E597E67D2AA9AB0C861ADDA28DA0756F580F74CBC3
      FAB6FEA6B9DF0DE2F241CA548EC3465539CBF1347D1A250778E34157C23C17D2
      F9BD48C8B79D5EA179616C8249A037E7FAABD1C0E0CEF15FA790EC3E84E94B58
      19132D55E0C31AF780126EEBB9628CBE30D034ADA8FBEC2BE1F94A85C6B256D3
      FFC123929AC4F1FAECEC67087F5303F2323A7F7F78E26AEEC918225000E3F521
      032417E38966B40D4036392A8BA9AB17EA76848645D5F1B4229A3E56C7473F64
      AF2428F00B58149F9546A10C95A6CC5678D876B5F422ABBBE54890CCAB64E721
      7B25E097D7890D085242D1C989A83C6493C6515DB8977048717FCF18E6838224
      05EE5D5596F609F690BD2ACAD9550CA87BC9BEAD02FC48D43216886AC6DDB6E2
      A8BC8FE2AFA22EBD58E2EDF78DC2BDA0DD1F8063171787AF03AEF5A243DB799D
      A1E2B5AB4EB02577E7C5CB1F9B0D7F3A3E3FE6C5F47EFFF4754869BC5796F59F
      5E3E855F5ACD2793F49B2019D0B8114C1846026C74B992B7759C0C5DFC8C28A3
      8CDA9327448A78B683DFD4673A5EA7C9290CAAB150CEAAF3561C52A27E8CD542
      867F1F699680A5B61B679FE78D2E44BBE8168E5AADBADD3967B1BEFB3E9BEE42
      E78314F21556FEFBB2C0C55C46DFCE0FA343575CF4A4B8ECF81ABD5B35FB418E
      63B1A902ADBAF7650243EF1CA6286F2E28770BB6189042504B54D3141084DCAA
      070CD71A1DFC2A15815B2986A0E164E85B6F7B59F2E9D004649E05911AC8BC41
      08603E146E74B4B7BD904570E74ABCE4F0DDFE5B9C4B3FE7C535C1209CA0DB3D
      5BA2F971C5F25B7ADA29D8731F7603F848384859F90552A930A35C0ABBE6AC09
      202F3CB316938591A0A8BBBBFBA47F747414AE861F7677F1D18ED9E6D3199EAF
      DCC8C3F3ED2EB3767C4F359A24C467A998C2EEE7451565B4149D3A613E8EDE1E
      5F9C1E6E4EC738478D9C0457D27B57C26D5508F71C293DBEDA9BC570B5108A78
      D2B154DEE15351D4262FAEB7139B9498336E6C4F8388ABA8FF5BB55DE0A00F17
      E196677EDDFAA10858C39E22E88747C597D93D5E57A89F7CCDD13D1E835E058F
      8A471B2F0995E3C016A439096392A6E4BAF2C1C85F95A2732EBB21CDA383065B
      8041FD715213C162701FDF31869685217798A9CC4CCD98E22F0C21340A8469ED
      02F40BE0B072AC4D83D7D5138FC756C80E219129690E0D4D56DE99D47753BDE9
      F6890F18DE4AA6E35A165EA3AF67CC02BE8E8F297434CAE5831BB89E0E211EA9
      6C1C1D35B5FB6E43D9C81251D2C68D6A3E92A9B1B3018F46F5E6483C5936B6C1
      182E4CDEDA777115801CB3030A84994B957E1A9C1C5B9E08EF0A2C4764C9B924
      39AD732F6BC5F79E132BCEBDA5D1D5457B3536387F98BFF3629E45FB715A1AF5
      779C20B636A4B639A828DB75FB0834BA46AFD5B397AEB5FB6EBA99E1EAEEFAF4
      7772A26FA077CB8B925FDBB93745E6E9E614999F8BFE51BAF238307CB598A8AE
      645C015F91D301970294789428A67506C45172D58A59D799F8C1FBB82E1351B9
      7F0C5984F8E67D9C6D406CA27263406E5ADD5E342CA0BB05995DE43B60934D8B
      BC4699A47181681B42C8407CF9F23D384F25E0E571AAF8A608C495F01A23F24E
      A5F7103598258351318DBA45C927C81BEC3039E7E3FF5E734624D260F41ECC11
      D6C860D28C61CFF2472DB2AD8B182A1D12166AD6F19E021786EBB239050E190B
      E5FB22A9ABE8533A4E8A95C6C11E175547BED8B14E35B97EDBF671C971434A5C
      3123E5E9DF8BF9C57C98A08AE30DE94E9C52CD3EB32A6DA8525850EAC5BFD61F
      A53AFA22D0F63367EF7D527EA1BEE00DCBCA444FBE7FB9EDC355044BD06DD356
      D2EC665999D43A795451F47445E8D27E24295C8C853C2870275362A5F9C058CD
      AF6368C267373B0694B935A0620DC2EBF58C19DEAF31C47E33540152816B8672
      F46666C1BA07ED37296FBED4134E64E8AC1323AEAF5171242C8885EF484E2F8B
      A0C83523968B5D2C12D723A1954905C2D6A1F209F83957F31AB8D4C382A674B9
      3FE673183B1ABD0022534CA2D7A752C186C10C8A8E4BADB3B8F2D93215C8D55D
      4556F5FE1A26D1333189761EB4AB41B1D26262CB15338C53102C675D0D12D179
      4C7806FF30E17BC79B852922BA582E309696A3F9D4EA7634043C45CBC542AE0E
      77E3D438EB8E256E1FF4653B07287CDE5682EC781C99F947A1FD1BD4A3556B11
      914A733F8D6BC3AD405901B1961DCB91073045241F7E8FC8AD779C7324212112
      547CE466D05CA5F06606E6C9EAA2C838C8D299E05F47A42BE4C9B5236886B52B
      F13CA3E33FEC2E21C241855570B6F62E3EA0CBB26B1E76B8D4CAA17C9DE898A7
      50BDBFF58A64AC348E862849486A1B16403E8EBAF5558CE07375158F77AFABAB
      F866FCCCD51B9BA4DF1E14CC3F97F818EDE7A2942C3639B6CC6A3B3C3F65F05D
      3401CE0FC504820EC999502B9C8365BE15DD334F7AEFBA100593A54D10CAE4D8
      51C4D9C1826647BBC0DDE1F9E983BEEFDE78AC9A85DD1DE7D8C4DEA911753E6E
      358B31084EA351E2ED8B60DC167912D43F2C2D09EC3FA088B1A420A5BC1AB576
      A772B106B11F4109EF15E2BC25E2E3A1C2BFF3CC2A26D1FBE25A623DE76FCF3E
      B6B85B2CF2B43D75E2D6B093A2CC44AD4C5DCC4D555DC67995C5A46CB8B90B58
      2328E0F07BF5A7ACA3A393F30B1B86210B890A2FF89E4A84B7347E60F25DADD8
      D39B0F1FDFBB70A9C62B51D039EF4FE21AD52C3413D6ED59B923174B72AE0094
      5C1D6127F5B7D28D58F67DA94EECE35F410AB11A5552AA00680CE75311D9E809
      1C2657D46975B3AE31ABE0E92B20FB4919447B0E3F6EB9365AA3B62C321660D9
      DCB5B03756745E0E96D7223B68941F085916250870C31B137A59EF8C69565967
      DB163AED77ECEA3088EA5E394F56A34E6A36A3A69226CE4989F0AF49AFD19578
      492F60964A0F17939F7C51E4CD639E2CA82351F1B0B69B4CF7184571296FB7EA
      756E7F46F7D11E99D84792EEC3C2BCFAAD47BDE811CAD2229C21A269B2D50351
      D547A2A6F648E50D3AC7ACB881A2AC486CE459DD31FBEF9155B561791C5815C3
      AAE0B3AF6FABFCF1A82DAEF048B2A15DD97287098A085434C53D72897B7696C5
      BE30D6CAA93E45D262586D361EC21A58D075D03B548E299A3A6965A01458C0E3
      622432005D30C62C178D2179858C7B3418E968252855EAA66167F3D5F00B7875
      9F976651F696D028647EF816147100DB0F5135D6435C575758EACF71C87913D2
      05E604581D0E5C81928561B091C4F65162467C622438A6CD7AD8AA07E931D5D5
      9089FC40EC2776A587AA4F2A7DCFA6A89F5D31DF6F3B78F6D6C4D457D040C36B
      2F67335AFAA629F540B6049F6DD589E5ED6BA2F0CAB6BFE737EEDDB45FEBAFA0
      73E69A7581146BF2E88C6FFBB7BDFBB6A88DD9F0F1C3464BF6F6DB37D45CFA98
      4F36858FF1293E6CBDD6DE9B9385D6D6EC0D77162995902B52D255A2FD582E10
      DD0FA73065E54F3D2997F685C5D592B8127039C17A8E0DED75B7986508A3AC48
      6EBBCB76C4E6C70787832A4338E917CF8B7598AE4F735DC88725B85117970923
      3B9214DB0AE915652358B8E10920A8784D01199F4C52283EAA05D6C4691110CD
      D9A61688D0222BA3623AC57108CB6A658B3C496CF17179B4DFC48F8360908B71
      A6759370F86D757E36DDA5E45A5A426DC88D463C0E0218BE1AB1ACD22E13A297
      DD11924BD35379C91D5169F8EA22900DC51F6297CA3E26BBDF6851E4AEA7D01C
      BC8B75A3E9F0DB26E83F5C42FEDA74FC55C9F86D135670728B26FBB415AE6314
      D49DB8370028CC72BC74CD757B67855451E3EDCD954FF42E923C48E2E27E76DD
      97D9DDF33A89A7489C4BE2E9D2EC0F64595710A873669784D4D80579902B066F
      C20062C6CE45CC0A60171494F50D1E5552CF073FDA7CDE8FC0EF9CD7D1CB17AB
      46F2C0A5C8102701EB19509DD54FF065FEB026D25CD217C7CD42CA691E3D8130
      2F5F08FFFA1E5D1D5DDDE5D8B492AC268CB741E1CCF72E288E6196AA9FFA14FF
      26A29C2D05BC822FC0D9686C3ACBBDF5EE9C8424B34C8BB24B0D2A6C5609CC0E
      A2EE053F72780584C0916F41153BD86D0E6185E4357E5A4C26622EE20385B78A
      C9A4556448302D09505BAA9FB00AE4126C93D58D3CCB170CEAE7927FB0A4F438
      1C909F073B2BA52B3C848882DEAF9AA520AD369C50DE587EB5EB881A525FDA17
      9772953325E0648C7F6141B022BDD8F99262FF25480B695478D0F9331E3CF817
      7E92556E69984C8A123589B16AAFD2845D4CAB5EB3F701ECAD1C382C71949C20
      A41FBC943CAF3D13D89BD9EADB0D370B911C9992162450CD3280DDC80FEFB86F
      759CFF8C162EE03E73A5748E30E9469847B79ADF3C828A09ED1CD6972C351EE1
      A6C3312F4849F19DC2A1A84AEC58817ED9AFF6DA6F8318E9AAF8ADE30B8AB2B1
      91C795C2FADE0ECFD67A9049997E357E46300D5AEEADDBAAAD694559653DC559
      E568D072CAEFFF6C67BB2793B70AC0AA1050D2D8263B21A6A52B6478A3BC3FAD
      146B68AF26D579C72CD4FC31A34819830D1AA719AB7E2C2B37982B27007E70C0
      B2F37B6009D004EB1555D36501565137A81F887AA73CA8FCB24CDC89623F5065
      A164BCF32AEA63ED60367BE0DA04FF81058A799293ADFFAEB00F363FFC81FE6B
      A51978CDABDE5F02055AA918D0304B20324766A12E2C83723ADE582D8F90062F
      834426000EF785AC5D59944E6D9C8C6AB77E35AE163C1FB5F54496504314C2F2
      943807D6869CE6B84849640D4D2C13FD5AD4362FF2FE38A125BD787E0FCC68CC
      70C0DFB48D47AF0458A6E0A371C096766AE53A0BA6C4E111DE200E8D5750A217
      7A41295B693B5412C626B56B3567B9BF769F44BC615ECE6003CBB5604326C979
      5E660B01A443B9D250174E6B637F099206E93EA02D9904D8819A74C6D350431D
      83E8484BAD2F6254BC9ADAB854BBE1752726EC0626D0C078F2084D7B88D30961
      97B84CC0BCB82CF442126C06EA0826A270E72E14100C349E5FDE6ED8A33D49CA
      6150D047C4D3CECF0FFDF71BE63B091766E1F683876E6AC38730F49E44EB1850
      C7A3368197030CF96C01430E0C6BEE04598C3CD154225074311716603788BEEA
      737B5E5510F18FF68FA415C6324906454BABED2B76DC441C17A62344C5CD33B0
      BB5A1C164730315A4952C3AC9578E8DA0B5C1FED967509F3AAB0003D6753A603
      790F1CB62D24D2A085F978308C9F466F97D54C5CEA3A3A3E1612897950F8A7B8
      E51088F09609C1DFA01EB7FC1006C4EBF3BD7274B59E2BA699A0F1785C350EE7
      8BC3F36722E8092059AA8455D1355267E2E6370D7905260FED2A54DEE331A252
      DA67E2182125C97D81AF640F5E87CDC8B1C9238E8533B4C4B656C555F28A688F
      F29C131822F9569771F4B560CE87304162305C458053BCD7C6E55F17D1FB224B
      AB2B7BFFEF77542FB359CB16E9DB1578CCC54C09314D99BB3B40134CC2D04DB6
      3EBB40BF17183D81B78EC3C4923A004B8AA9878D84E8C5D75428257AC6222F85
      9105D003A3BD32890E70DCDEC15DBD2AD39CB49A7394757B2D42422B2F54CDDD
      FA788CD2B7DCAD1D7414D9C82447CA231BCFDB9812D9B103B085D684DB1D6723
      1692CB94F2FE6368B3CA935519894E2E1924B887DB2412A9956A67468A6D0927
      8FF7E7EAF34FA5083578D438EB5419881D136057A9F8F8E46D92CDA2C74A388D
      1E47EF926FF3EAB418E3DF6FD2FAED7C183D36224DF4D8F1831F2B19F6B1126C
      DDEBDD9B1AFDE40F530FA4B6D1B3C1339E25687A57547960218455AF2D47C032
      C989D4A08A4B77582631AAFACCEBA25F268262B21ACF3429F1D52DC5C25F50EF
      DF9771375DB186A6F387C3F727C8F93C3D3B383C898E8E4F0EA3777BA7874A48
      7D5829871AF6B4E487CD3CAAE4AAEA096F4132E9FDC1D638D530C4141279D08E
      8197F5D834C8A605EC3A13201B17AEA0B1AB47FDA06D9F2497E073B23233EE7D
      8651E633B9387785C0296448DE308E43F1C0B9F9E4B85CEC1F7DC45B0A20E743
      0982CF768E0A3A4A1F679DDF4B17A023F5137109549D802FD2AE2EF9F7B3B3F7
      81B3FDB08BA12CBE247960DF580912AA44A963D8CE38BA4CC50A35A6B006E31F
      B4634A3438BE386D482590C20009E256FAFC03D35DA5A2E545314B471DC1BF28
      56CC6CCB4EF4C6A7C30F1391F5A858F6BC001F21DE5631E196DE682930D59303
      2A774E52C18764C4DA213283F7DBAECB2959C68AA521935601BBC5EC1863543A
      6510E538AA31D7D4FF5D02D83D646F6985B8CC7A39C93C0C318A47B0601C5827
      5455C52E84A5E1D27F02F2F2834A3E884D4391B3647C0B7E09071C296E94C19C
      D7D4A3A11122A12537F2E44D8674E58AE9EE56D1924F6B80210FF92666EC9BAA
      A3E4A4134A2A66947094CA414872103EB4DC735EBFEF58E57A1C5EE50A5A8894
      FFC6E68C5A5262A9AE8C25DC44B36236CF6220BCC0B460F136ECB0B6ABCFAA2A
      4901720FD7CD8C510007EFC408E0F5815A5BFA55A34243968C69F814B9D97F9B
      9BF5DE9EC4D9A316A55ED26BFD79B1E3D51883B56D86762FB466CDC25ED594A7
      3B0C93685820A9221FCBFD8CC8FAF8FE76EBEEE676AB2760AD46733AFE8B1D4F
      D5F26EBB55B712F802493E9AF5E5B61AC0A5B50086C0AD4DB811D60CC2BA00F4
      2FCB782A0EE9004BCF0AB4A8700695C5C4F8A1CCA222F81DF9DEB0F8E67736EB
      18C120B2874FE674DDF9EC4A7F4F1ACA12861A5EDBA2035D2BD1AB90546CB24D
      E30556DAD3E7ED5978FA83CCC2053D36487CC05BCB5BE26D4B409E8BB3FD25C9
      7F280AD4722283EED33CECD24BA4F53E2E20ECEEE836FE8B17F170A70D097354
      8B3292A2088B1D5E39ABAA95BB2FAA62601F2018AF0DE3550462E351AB8897DE
      718AEFBBC37735E9341D239573E21E8BA534866DC5DE2AC18301BA75F0254A1A
      2651D7AE85A2C4652031BBEB25AD085C17E4A305A9E11C76ADD57519A7F9E6AB
      420C92D5FB529990CC3E5DA425B7261656C73ADCF6E422FA2E3A6718F9E2C349
      F45D74A4FAA101EF12ADAD7CCAD1B3A05411AE34421020B8E82DFD25496610A7
      2248063FD63000BB9047F3B2C24551A048DEC221DF6C4D96936B301C92BB3469
      6D9945A1CF61D731B465825741409045E92F11E036B4DCAACAE80172DB23F477
      9B2F81FF288A95F9F77BD1BF0ABC46198FBE400FFB219600DABC2D955FD7C46E
      2FFA8E2FDFDFFCF6FD788C93AB5DD37129524C2AA060B0558392359CC3844C73
      FF30826037D65DD37A195BB0A3BE2A8BF9A5A0C71DFE829A4A828619BC7E53D5
      4892C1475D64625968B775A4EE34803911DDE520584EB6754A0C7B7986A29A6B
      51FB15BFC5BD8714660C0523FF88934D9AE72473C956DFACB964BAF3D4624B7C
      610BA287ED8B45C3470A49BE824E12879507F109ADCEEE58CA63737117AA4903
      6E8C6397C87979008983AEFDD5BEAD3F0EBF2C0DAE1B29F449CD5B88347CC124
      2168609B57B81F4AF86940A4648762BCECD5D20AD71982C3B65D6525E8E3C5C4
      76F551933B40DF3294F135A27DACF504DBDD121D464556CCCB8D353BF8149B70
      773CF21994FF9F26B04118CF93E3271F038292F559E937E93DF0C4A3DA117282
      D2860E347BBC83E0C7EF34BB2EE7A069DCC17272FA17F69CC7F2FB1D799E09FA
      2B65C95E6848AA9AA3A6CA870D41A2700F6106C828C896148DD87C6215695B32
      9FAB1512EA95487F880670CAAD1D35F194D8525C5E8A8A2E54FFAA7498A2388A
      B023F4FB9018B34207F223353CA06B6689B7527847692962C2C98B3062D6E598
      CB3BC9ACB9BFA3304B776126D62502998CB51FBA2903373330669B6876E8C78F
      108B0B72889D372FA7932BD1C7EF751BEFF038EC31E53682F67D19086D69F3C9
      7F9B5E5EF50FDE1FCB96DC780307A985CD278487AFA27152D8845ECF28E65C2D
      947E943F4CE21165762B0BEEFD143DD9DDFD3FF6B2B6FB2D743C70A4DA2C9DA6
      12C4716C5A1D12736187B1D51804582C42432E03DBE9698E6C27353A389A57B5
      98557677DC6D883B6FE3E9705E5E22EFE9B45D596DD12975DFE6976F931EB1CC
      F7E51E52709B2BFF4B9F82154A416ADC93B47EBA8E89CCDB2A9A10CC66D8418A
      2B6D973E73526030FFC549D9EA01968941B1203205F32D8BC38213B0D50F3788
      F232514C0CAF1AC45E9790DBCC60EEFE950B6C9CCC929C3839C80C12C4E45EF6
      C4ED30B429CAE89749EDA3C60C3E86869EB8F87708609F9F9819BA99CD2A6429
      67B9A24D2BCDBA8CB5D60D2807F85BB332ACC5B8A7EEB2D69CF72A693D7BF509
      1C14870D749A8577A2D45AAD66D4E1F5DB01EA2EB72EBF664AED6969F53EA269
      CCB47EFE8C2EEEE1B76FDF443471101DA2AA6A7623254B17D86DDC602225EA4F
      C8501382CDCD67F8E7D3EF9F451D8C69C775BCBBBB4B5EEC815C4DCF777F7CE1
      BAEDBE7374B8AB5F3BA454A3BEA57295493285D6D35A9BDCCD9D0F1DB17C4F20
      FAAE268B6B1B7E08FFAAEC622A8AEA1FE5E2922A38E3F432AD2D41DF38A4D80B
      EFCE2E08FB67A2BDA292596384A8A6E083054DC7F9CDB428D724E2064429154C
      531A49A09326E88588CA27BE9A7043C35D60FFE92CAE39515D2D4E4AECD185A6
      09B0E44EA9122F4CC79351AFD8BFB6EE0579ED5EF453F4BF394F6EC95DC7259D
      301F29F3D7CC92E5BC76F91B9FE716A7162CDADB14EA5A4FD31A9B78287BEA38
      88B600B82738EBD8450825E00766DCB8A1B59BBFB9E557B6FCBE4AE6E362B165
      A910ED66A6D111599CDA13CCBE0B2D6DD01BDDAC085B57F26398BD922FA1951C
      B4E4C3D7A431CC3ABDE1BEDF22AF6593A337F876C8630DD23D9CD09241D03816
      CE5EBE584857D2840D49599A142F5FDC215F291052E46060C8A41C954BBF19F8
      AC6F4131344F455FD2A0F385CA9C72A570B2CFB97D6FCED36F1461718AC5370A
      8B04C59B6C9619FE59BD3F16071C5DF076A884F2F4A017BD32B9B8F31B645AF9
      08BFE536C1A3137229ABA8C4F5B28EA3C5E97C441C55EA358C8412D8087D4BCC
      4B42E72B5FE2F51CA5902E73D00BE3BC8EE229B39A203503D28520778CF24E94
      0C5C52E84AB35044142DC895E25C3017DFF223E31CB93FD74EB1BB63890BBE4E
      D6AD79742B96BB5B14638433F6A596C1AA376DFE20A434EB5D2A473AE3B2634D
      33948FB848041091A8AD898E31ABC965CD9489826C7235ED7FD87786B2E48822
      968B24294D9A53159995D3F321998833205A03229E56683752E87C691107E068
      6552A19C1B5AC5F58601CEA3EF7777DB6925B4A428E83D69ECA83AE6DEF3BF7D
      AA926CEB4138933F004B411C6776CE8D786BB865A05C417849914095167CDED3
      2ADE9E8489D75E7D8E54EBA7D7748F1A208A74C410E85FFF0B27EFAFFFCDCD66
      0AB9B033430344606A591F904A93B826CECF5AA2B01314BC49F3790DC305D593
      C8B4D7DDA398B79991B6F5999366BC4359818D57C8379E897085BA5241DE341E
      94C944BE82212744295197204B29CD454AFFD75F6D40B8BF925F7FEDC82E8847
      AC442B68031F26D2EF94C5914A065CF6761665C5E586FD561CF1367383A93B9B
      1A1C07455EB3DFD15F4372B4CA06B1383C5B5D736EF8E7307BFDAF5A8689174B
      38D8DE81945927651F1FEA9DB4591B94D4B736F888B00D3D956CCF96C964A5DF
      D8DF7FF5EB7F616A7EFDEFE8AF32477ACD1086F30FDE5C1206EA227D1C359259
      683D6172BBDA9CC5E4F6CDB86E1568E6998B58F0793E23E8F64DAE65263486A4
      CE91AB4D15EAA248E7E5A6D2E8296021BA933E31D9054EF6DF7F04EC9104BC85
      20D92DB83A713E83A30C178CDD802BB6E82CADCACE0F2E0751D3E5B5B1FF61FF
      D9D3BB0CA2FC40EF9EF0C671229CDCA5EAD501DCB17B2AD8B01B37A23EA2B39E
      EDF13A23216F8FA7FCADDCABCD07EA9804EB64EC99FB64A616E36486FFD8C0FC
      D5B24CEAD05900D2599462AAF3645407DEB4D0BC79B7F7EEFC38EAC292839A27
      161B158EE3510DFC5DBFAF4B45E3226AF384C9C9AED35D40034255932A98EE61
      B254A51B6C4AECA71D0C35314294E368A8C173FF988CC7580881442F59313BC8
      D020854FEEFC603CC445495161D9EB06C125E12BBB1E2BF6A24776F36FBAA020
      1090E9373670B6037209C01BC6386E6F448E59A338F1AB2E51C658CD1A403221
      5329F3CB04569D9FF5622B565652F2142D02E4D24961866776176ACF504A0DFB
      17F600DFEC5190709CE602D01150B0483A5FCC2EBFA58378767E07FA035FCE5E
      777D161EE5BC3C38B8304A2C0D9E5CC6B02199492B1DDC0EB37D233BC83D9BFA
      8C10F6286D650B00C6C38A5A913D4FF6A3920AE0F41E0BECB1B2645B4F92E9BB
      C63F31F78BCCE6ED0AD253FF7956A2F91ACAF398969B99C923D2AA872E9B1F2F
      F74A34DA5953D4974795AB129A1A1A80171B4CC6A2595C33D894B6D629BF8112
      A54474FC9C11ED421841820E4B57F71D41759C154BA668B1ABAEC4E7C0FEA6EA
      A342FED3B78010BB3D78BB7E5D84EA939B75AD358ABA487435D8FE12794FE23D
      40C1450A69008C2D3A1B66E957263A9AB3FF4CB6B6FD278921C9652C1065A31F
      22055E8531635F33114A99D64113F86EFBD2D28560D5E420A0681A24C968693E
      CAE6A437E4403A2416E24727EA36143CCDE7685570BDF3EC79D571F737490E80
      5340C865E934B74E9EF63110B868C188E1FA71E7E193A7DF3F8DBA3C2AFBD109
      CA7947C73B4DE581206D5DB236FBA3595FEFEC577FB127FDA43982C107A05E0A
      F1655E4F7EE0A6F60D8B35C894F65B554D1A0251AE68F55A0DC0F6E1229A0DED
      61D0298BABE8E3C5D10F8346F2B402DDCD2689ACB5ED19FF5CA5729012AD2B84
      10069E2E8E616E8552DC205CB7521E3740C8164F12BE9EE9F6357808CE945361
      3DC2DF3358F3BA4DB12C437DBFE67ADDFC723CD18656DE8BC1CEEB62719F1F0A
      C85E6463D9826108B3D1757947ECE6CB1CAFBEDD251997F1301D457DACF9175B
      3D017E2D26B8CF49DDEE11FF4A4657D287DDAD1E308E21CA254F78BAD51392FC
      32BBE7232628F67BCF47C0E7BCD7132E93720AF1B67B3CA14C922FF280675B3D
      E06A9E5FA230417E9F194DEB384BEFF722FF8C67F17D57665E94D7C9E53D3B32
      93A4EE7B8C064ED7F9E55C5E66EB7E94F3AA72AFF264AB4754B37BEFB4EA3A19
      DFF311F5BCFCE21EF17CEDF17A7EF8071CA42B0E90257D32B34E95095C80E70F
      E9E8D23EAEB8C844A28E4C22BDA299F114881934E42FD6278F344A3FC11256E1
      083E9B0EAEA4A3B926BA149E29CDF6903884938933DF56348586C5D764072833
      398B5228A4ADD0C15A2940A6AAA8F3516A41857F7EE52ABD8640158BBF006F5B
      ABD0252693D744CC0BF2C702404464D1E06A2DF6CD2CCC19CB344A493D7068B4
      6C3BADA6E897D1CC0CB1CF80EC434111A15449CD6F615A2AD1235D0D6487CF5C
      F53D5DEA7F8501BBEA7B5F403F2BF2BFBE78F1E2C53A94CFB342E99A8BC01C92
      5B9C912CA51B3C8C25DC1B3C3B4A512A49A80CCCEE61AE2E59B431D0F8F58A6A
      BE756F8592082B641218A952785ACCF9C0624FABA66C9A2DD9CDCD44957377BF
      5C8F5E59C28F9AD981185DE750A6A613753B877947E44FECA82175D8EFDA099D
      A9D0F67783B0444CD6BC9CECD55FEC113F41FF87402F37755593C1D2AA1D2372
      B5D7694D766CE83C0496B82B5ADF500DA2A3265A02F8295DE600D074BF76FBFF
      2FF03E7E1AA479AA5086FB4B6AB638CBDE4C1A0EB7312BAA85EFD0D9A52829DD
      9A3B58FE6D776443FACF22EF7A29822BF9A6AD268C3C621C543FD1958EBFF0AB
      4A29E81C680D993F2F474840D85BBB6D267196816CBCBC4738BAE65A4FCD7A43
      D85ED7AD78985D5ECF4767CF7B5EA447BF8001A0A3A893216515936FD406D043
      68B5CC09E37DE1B0892F2AC0C3A2274FD09B79921AE9C648A8C094C66B084FD3
      3B344660E81DFA233D0884FA53D530E401E597D5EFFB4FDDB3C1F724F8C98615
      06302E571C61DA50EA0A7BD2F56A9C54CC25B6775D4D2759BE7CB4B416308E60
      63F262D273505E5873E1A3D115948D48E0E049DC827560AA08ABC15DE8BED180
      6EB728E678AF45BA2A837309ACB772F12C7EBF19A50803144B06144B6139F2E0
      4AB8D5CD84D9A8ABD0D0B2230DCC9B10AF5A388E7738B382C028B7515658CF77
      99261262692DBB32886A51660BDF4307614C79C15DD61F7633628F0813B86E9D
      268D287BC9772F409D65D19FF3A2FEB3298135ACC1D6126A1406EA6284718905
      88E186E19625E666E3D1B69675695E66C5906772705874F11633571105E8DCF2
      4B6D27D4751BCD427410E979A3599F4D879F376E5E2F8ABE1D98D81FCD9A3436
      BC2D8E6DEAE0182F91992A3DDF1DDAE924D6946B8B2507C38901330A4AF37045
      AC99C14B457387710582CE4D78E08667E59A73579ED213D3D6970296154BE5BA
      266C27476E50B039386E573307095B43D330BB512181C68D72DBB251F580C6F5
      422BD2D602F7C65F46B357DFBE7DFBF613533954E35A8E0B792949F8E82E72D3
      7DAE23476210E1312E27DC96437ED3369C6559F4643CE0070E82ADCFF1A60E13
      7959CF8D0E4C731C875F9648847DB7D227E005767F7CB6FBD35DCC23978DB1D6
      C268A76F44791297B7D009E8A46926E6522951DDED4B83F9AB5D237112ED87AF
      0C4A59FF130D09D8FD61E1E2571263580832AC7FE092F5D67CEA13FFD4FD9B32
      CDB274B4C163191E5878DC8BEF77779F44DD8F1747FD1FD6EB692EB1008C76E7
      C6DEA980B5395C5971B9DA39DDDD7DB5BBFB395446074D2A295F45BFA821A593
      3238BFF870FCEECDF9677DB57B8D8E0A8B348C385AB6094D22A8553CF2740089
      D414751B9B69BF8B3F869CF5774BA7A32E6D016B7CE7AE73E2026BB8AD9AEF11
      D45E4FF9224EA15042843E74B7D1DC3C5F3E37C1899B54D3CFA8C2E5925ABAE4
      F6BCDAFBF1E88767AF8F8E761EAA8D071BC2BB347A4E0B4E79656BA87E8B5383
      63F41FFFF8C73F7E6AA4C7E2E80DAE817B4FD293A7CBDF657F66A56D2F92AA1E
      24D5EC9641E4ECBD95DCA803DFB1D563BA2A59D7E7CA5C6DA0528B2B215BFC89
      67F096899509088898EC79352A918F2A5993165B05CD4652A1A62959ED184847
      A009C3F65ABAC1B4B35B11CFD54225C1E120F516500D0A3EAFC5F8DF7D0ADFAA
      0D29F1CE1730933CBF35C9022A1D0BA53DF5A89F7B7FC209F1CFB2F9659A5783
      FA5BBDD1E30C6FF3858FD5234D73117C0EB25AB86C830624133378432965D2FE
      9D98A892C5EAE0B4221EF3371B753478E55EAB32AD54C5C51F9B19348D40386B
      DA4AF85BE5DC2407478BE65649AD288BF0C69126A775214241FA3B2CE03620BB
      0AC37F32207C1F52C737FEED53F9AD69885753A8EB9D1F6EFCFB67F2FBB3C924
      1DC1F73F38D9C72B5FC5E518F693BD4E3F9C818D1FFEBCF962FFF9E983F590D7
      FAA70F8D18C9F3E8D3878D1FFDBD3C7A9F1E469147FBD91C715A5DA60FD3FD17
      D2C68290F9C60F78290F58266CBED23E3E9E18F535204407BB50947D250F31A0
      D08847AD373076A26C6C965C8373C610936AD389407F9B7FA3DA81816D27ABDF
      FF2CE0F24833486850020DE98DD5F2D75576C80CD12A768E2EAA4B62C5F78759
      31FA721741B96BE3E03A873C1A53E572ADF3B1F00329E16E39AC0E39D0EFC183
      6D1E69B14BE200C6CCAAEEEE6F3A75D02E072D562A21F4A2CE486BCD0F0603BE
      B8A87056E93485809F2B4556EDDC22C8AEF7DF06126EB8FE049988BD0EA32C06
      9D232875BB827D0BCB6293B20B520F157557548B1D77D999A4E5AA98AAA0A528
      08ACD5198C25EDC59E8222353B3DB7D37A3E3BB26BF5CC75F3EEF4C4B2D09684
      821C4E8D906C34A9F73D32CDBEAD3DB78DE919261243BE9F65655D111A849D58
      1D8440041DD54DCACAC81AD5FBCA6E152B054EAE1F9D25FEF97FFE078ED697A4
      AFC8DBFFFC8F78B23178D4045213C8C6ADBD2EFDBAB55792ED671B5B9FD34C49
      0F92DDF9779A43ED9561F15576F797C1E7501FF2977F7C5E1D9083223C2F658B
      1053B054F33E88018D250146B2B35BBDBC93CADD7E5D66DFA936195E4EDE886C
      5A89CBAAF48E1E680CBD2E291548B4469473F9C6673FAFAFBCEC4E8FCE7E7BC7
      F75890069127877A0827DCF6635015D2907F1F6F90DC07C1E80FCF4F1FBB4DA2
      9C6709AD23A0BED65AD9A0A361A92B7F5E3213610A89C945F0705519223A1371
      163D527DFA22E71EF57252483BC482A5C8193A3596191D61461FADC4F1C2E235
      5B3E7F41DD5F63B792B68A42606BC40F698B7ABD7D2B95C2D62CE27D9564E368
      8CDD83F61B2B56B6A788637BC74F8E8E1EFE57049AC5ABE82243B3AA6FB26447
      4349EE9D818CDD4151E98819CCAEBC40328E069757053214D7E7BFE8373D2264
      3636E8AC3782777635A4A7C73432FE242792FC4D86AD4DE74093455CBEA13EDE
      27C4AF31986225D46A03A452045D140EBD2CEBF063403E5415587DA81ECA7B98
      681D3A29C7823CF1E3B1779F28D6B9C11BAC2C4D1F5EFB0519DFA7C55835BA37
      CB4DD22FC32C8B2689D4F2D274695DE94EB556293905AEEC74AAA14E7CEDB2A0
      C3ADC93F758D81C527E1DD3D8BABD5EE1B4D43AB67591728D4294195AB789E09
      E2BFF06E3D6F3D69EAB7BE42A3528C00C2425F9201C34420A9E352ABBA327347
      83103DDEDE9643368DF398012FD7F69A8A4AF63D1951654CD7E8890C22C7D6B2
      84BAB081AFC11ACD2F771C3EC54BCDC98AAB91A122784EC996EB8B840BB34A5C
      4656582F14773323162EB588A6FB0E9579AF9448A5291D55F00CEE359F240576
      743A4A67D455665C4FB4BBA07922278A988D2D415AA766829351CD3994F1113C
      E64A70FDF96CD3216550454AE619834407CFD34AD4742CCAF432C545A20E8C0C
      E69A86AA049994CAF0A1518328B715230F0404B4FC265399B5CEAA1C2548BF6E
      BDAB4EDCF02658BE920C8A0300C6E27456DF2C9544D7CC6F08FF8B918E529494
      F053AD5FD7B7CE20B85B2C5BCE14332808E1B60ADC3CEC946921142290A498E7
      4378C30A523CD9DD7DC47538853EB69685313EBE338FFCD87051BA5A79568F49
      00B4B80E1B74752FC2E224AB5E4CD488E22FF0696B3964A49038BDCE42D5835B
      0853CFA95D8BD7058B51278A39F0523EB539C1726B4EB06C20E4041D602BA387
      FEFBE9830212F1736C1C9C3CAD39DF3C10A6CEA92C6F6F92C89DB1D6302356E9
      C15C5AED440FED9CB3CA46B736E182303ACCFE5329EDA04EA77ADFFA28BA020B
      4FC2D8E13298E2322B008F55EE345EEB59F9761D5FC2BBA4BDA82A5C81BC71AA
      1A43526E420929E3F46B3A86D9D09824755B53EA40AE57C086DBC1E8B5AEC5C0
      73A3F23D809124AEA07FC6DAD0B14F02B566D71D30927649C840CBD905D9ECE6
      D284C2F59B2FA543EAE93C3E10CD013EF843C20DE1C6647D0C7FB1746A43D691
      136CA5492179A58D81992275B35D5BBDF0068E7DE544BC7BC97EF1F5B370CA14
      9917B3C8ADD936087357856EC1FEC22B7C33D4028A53020A17760C04F6928CCE
      C7E3F514394A7908D1C1FBDB4F1DD4D6C0EB9666AB3B8662581FB0B3DFECD260
      30E834EA53D6AD09A50A3296181F41BFF73450215872FD98F6A64A4CD13D9646
      5BA7CAA8C82BBD423462621E61A85EEB30312437CD60583A43D93D092652B15A
      C849703928946050A5AA5E51504E4613DE9D52AB689DD5A02C5475F4CC89D398
      C5D455E3E03B4C87195F4CF35BBE179A8583BF2EEC8C78F5ACF4022389013C5F
      720976447B6A9C286B730B06A2A832316ED239435C26625A18ECB9705483DB65
      BBCF013FB44B91699E0EE7B563ADF89A667A0798B8313B45610B6E183B9E053F
      F1A4147DB057A0F27976002083553488F668EEE03A4EA1A377D98037DCEA692E
      3DCB340D6B5B2C5951EE7BC2A9DFFCF0683D67DDC26C37EBAB701BEFAE312CAC
      801D241E6E748DC066682190C2F70F17D1718E62701B018EFA0C91E49CCF704C
      107C68AFC9E8BB685F04FF3FA202A0FEFB00C6C3AA66F63FECB7FA491D4BE380
      058D9C5FA593FA3BE9B9D19863C3CB4545578E121E6534FAF4CBE944A217328A
      CE9E65D3040E963E66AD37D0C4FE80167ED8B757192730B09A837EC0CFD62110
      619C853D5C54C2B5E109422B81C6974F2B6908A2087E44CDE560342A69A42739
      B6D7A9BA8E7E348290A70435AF63245398C2D06AB8231E5D35E9255ECD0688E3
      965ABB0E05EC33B9D8163B6437039D66B143E0E2296EA63D76E103B719053523
      0B6E4B3D0089DCF42323493475CE58B58A83D070D6B76BEBBC98972364F9EDB5
      CFE0766372233B34C0C3074DCEA4C6386410D41B1595F9606C8371D59715F669
      400266D3DA3BEBC9F2036BD3573D2ACAA1F4A78F8D11BE9B8B1C0A7016A22A69
      7E8F991469D0E8E44C9A0410A7AF1EECB5703F8502BC7E4C35A8EA68D20BE3D1
      B2235D528C8D7300C50B039E21B25BB6CBCBA778A7974FC3774AF2715C5DF19D
      B47077BFCD2D684A023AE0710A6CAE845D1467D960AB16D33C7A8D282C6A7D62
      0D1679958CE68DC8A7AE41D827083D50513E965F0DA2BDFCC645545C948C71DD
      F6A02B8D1D4EB6AD0CF57B179F44F3E1D627998CDE2D0FA2B4A033C55D412C79
      94530C66FDE51B19DFF5963F4E403B12A43000EF0B9A6F6ADF0823C5DD209467
      E6F5065A34207F15D7E657DDBE66E9D2D5629B3A6E4DF00C921C5038248DCCC6
      E73205A125665CADBD6ECDB6A4F94791214E29BCE0A4DCEE707FDFB073DFA99D
      AB6C1B6717B8CB57A032CDFC0A4519C2D3BDFD377D4817DA889547D65B51C74D
      7BCC8EBA8B9F3817A36C37B6FBB539EA15CD6E887C88B4849ACC593A1B16ACF7
      E1EC7F9E353487F5FCD0EFBE23D56C5DE9A6A596F2A2C9CB40646F9923E0045A
      7C9076C119B8CD380D6AB440945F527FA6C59845233583B5711806D6FF06FA9A
      7C3543478246E1F3B6018DC0E37532978DE86C5DA697978CCD9B639027D700F7
      6869B987D37669AA758A2EDAB230FA0A6FA1350C2B8186F67739DE2DCA5A23E7
      C11B854B52CCDCC3369019E3E6B6C4B6C0F303DE191AA76E783406BDF6C01312
      87B0EE85C468491946E0C899CF729564AB5D9C3300CC0B03E4557C6F1D1BF98E
      24AED0166C8AE8AFF38714DCA175B4BC7995D31E26120683A97E9B39AE29AC1A
      E9130D9B865CFB52436625C4A781A98D80AC3D5850D84395874030BB7E56E126
      01A78B3A8C4CDD8224B558FACB4AD5AF57585C601FA9C0AD14BEB91D9F56A30C
      036BC5EDF45EF016A11D9D5C10ED43105E8D681736827C4D40FF2EA9DA59F2FB
      4C81F88E419F7EF75968E0157EE06D07392029373298472F979D1262CCD22D5E
      12C4BE7D484949356FFD6146338F3A4274A5D79CE67FECA88690DCC2326F5FC3
      EB2EDE3066585F59AE5F5E081E503AA25808CDED7FD8DFE08A5581BA252BC00D
      8BEB5E1055B10EDED230FA1CAE8EF578F02686CE5551B03131361A311E11C5D6
      7A53DA27A22ACE2070A08AD1BB4296C4DDC816787119A764BC56B5B6F5FDE6EA
      C2958A00FB7500117AECC45F296EB40C7088ABC52777BFEDDC41FA770E9988F6
      333A9B33A76E79802076D43EEEFB93C26712FEF2EDB3BDC46A1AD5F783685F31
      36092FD169B244745EB9A2105241174F56721E3D5DCF63BBBD6FBC3E5CDA8D9F
      87969AFDD2D88C04631646233C646EB1497B8E02D1B8D9AC51FAA0787349660C
      620EF1708397151AB762F78B2F49915E2D1C69A8EA92D7A0F2346926F0619D35
      6DD534974549968E129374C599BF4BE105CBE51152F42FA6ACFDD9FB207EC03A
      EB76A4D01797FDD2CF56D7455E575D0A8DD04FC0C3DE987C6DE9C164529853C9
      0D0445FCC56940E19401CA8396493D2F250D4CD28B610F572E89C9D94171158D
      CBF8D2E5EACB8E7159408D027E6A3FA9086392656EC1F351252AF185CBCFAE41
      B9EBC8A4D0EA85C6039D95C53043F930E7C9D800AFC1DC59BD83D3E445D457CD
      571B3CE7C0A8B9A29AECA497AC987992DA0266A421A35289EE6B92390AAE2D08
      BDED8C17002F3E947FE7F5672CFDBB2C763BE29C1894C94DAD178F3170C7492A
      A0408ED009EC6156B60B03D4388FF835C969B34284AB1A7CAB045989D6101BD9
      CB345EE32847CA7593F302A68F85EE2B025AA92859BBBE7980809D59572357AD
      A0515CE9C51F3298021D2D97EB02928C04B78CA5E5BE28826A5A9F51C82226A7
      2418ED1D6E5652B485A0A208C6BA38DE729987906AA6E60BCDAEE0F952A2C598
      6F0D1697C89B057C7BFDA2EA884D674509ED58C77FBD8EC5AB84E28AB1148148
      83D84EC389E599C4E9C68F28ADA6CC3E3B5E10834070339916E58D959E5BA696
      DA1C823E87EC806F84721455AB6C16E89185A59C75DDBFFEAA42CA8CDEF722F7
      F9381B55BD687FBFDA69C0D0481A13C07549FFEED4BD573112D37A436410F646
      C8920D3AEC58710D5470832E08F8CC0031EA23AAD4B27FADE586F2AA029DE740
      1C3EE652C4E76D9AD79DA84CA85F56F943BA43430EEFD551DB6EAD51B1ECC158
      2A6A55B7CAF97651A7D4D57A610EA8557156881918EA5C9F660C55EADE8AC5F2
      64D7AADB447104F99502754351DDCAED6C7154E6B9FC26899AC5466177547E91
      6A4B0AB781AF565C2B9F19988CDF74FACDD5716D43E7C90C41A73CAB53B604F8
      68A480B7194C9B3FF7977F2073C63781B459AB55A78CEC27DF5BC11EDDC1292A
      2A54585FA8110B0B14693274E7D0BFBC28FE95B81FBB11BEE345050F4A0C490B
      EFF8F2B345BE58A274E1A6EFB41ED37D5D64E31DFB6D4717513B36DED5C52474
      9472BE46D9EFD67C0B3D128DD7AAE185E9EDEFA4C9CF4A736534C6B8AA0886A1
      EF77A859AA385E9A372DAA8D1397969963A29687F78BB1618417D917D142158E
      C41B1D83F68E9438A7E82EF1E19D5E7494153178C2C88BE30050555E3E903ABB
      BC6BDDB384C8C8340E15665B97FF82E3C396F6B2CEA98EBD68D0200C1D8DCB62
      267414EC6432926705530BE2CC82A8DD846E0D8D19AD7E1AD8E457F34B244874
      9D41C9E09D709BE3CB3CADE7E364078E11EC833BCCA1AC0CC319D1EE3AFF63C9
      4FA2AE8A7C0E6F96CE7093FA457B3010FCDFD13947CE491549161BB43C841443
      9B625826F11765565AC95BDA6C47620EC7A5AF0E0037E76E25846845D4C94A5A
      D41E67C0172C8219628C76CB8390A784C6FCE82A4DD69DC01DE9428B3AEEEA8A
      9F145552569DD03B93D441C0172B7F5A49CAADC9D135B2157E19D5F635345089
      2BEAFF78CC8A84A338BB284E699FFC3DCD2BFB452FF2BFC6E7E17FCBD3D622B6
      CF9A7D27A019D46B0E1D23BBCD1826C2E9C97DB5F880A8EBDC225F6E702770B2
      68A054AA8B11445F34D1C0E55AB81FF44CA39176AB14146C36C1DBBF51F8DB16
      B946FCD5DAC4F4B8CB5EF56A42422A8528BC6A9CFEA298D723D4453726505E8C
      6FA902D96E5E4E3BB929A53090E5B0C8339C1E8755BA405194478884F234F52C
      91A643E9735DEC0B924D1194941897B1F7C9DC6E095E4A856554C74C8A66F8D4
      10FD12831C591223AB42A58930448D9211FC9574DFA8EEC8035197C0CD1CC275
      26DFEAFC333E7BCDBE546D1B3F7B3A6FBD5B99C669157526A0C850C3AF137555
      8EC36D5D15F645DE52509CDABC229D1B3BC6DC541ACFB700625EF782B9777451
      2D4C06A9C960A82121EC3A6D91639F216F0B0F2531A58A4B5DCE47F51C325F66
      C676897869CE4D58809900A6F8519EE2ABED5A0DD4D6428F6512C9A6A7A95BD5
      45C13B83C916739C7306AE45173EED0A048139E2C3883099DD6C983345D17437
      2F9B13484DC6A2FA4D0B4A3ADB98561A53EB97829E37C10ADDD7154AEF21F906
      EE10463A481E104F434E50CEC049124FAA8ECC46E76F73DC91FC8A1D9F8291C9
      B9D280370C445E7BB2765EDF44AFE32AF9C089EA2895996ED9B0F8E61589799C
      59BC3C4058058571B569861438F4186CF7AFA220AD82DEFB8727279841E4F959
      CD61F9EACE269BABD5394F0AEF45DFF5A2BE8CD39F21645CB593F21495893A02
      2F02B6E8F4DC7FBD2BF2C486F938FF0A43C245863AEB936B25872528A86AC7BE
      95139745602EA245796D8F596E49B0534D13969120CB1BD19812F5786223C268
      79464BC3D7E9722C17D273F84575425DC5B5B16BB7C5542170E423CCD2E25D3C
      A57874A558F2862515C3E0A11B442333ACCEC4AD12180006F30D13DE804050EC
      8171B6A1264828E16D65AB97BC894B30D51A864E116B7823FD5C03F61AAB15EC
      4732EE1059E8B8A63A84092D5D5B0A69F53CC418A3564A75255090C3990D9C0D
      3301E5460F4118C5F5AB422E0741BEEB321D7D41B5B74A84279C9F81CBB2A03A
      A7B87B75826A89D626C48AD727979EC9FE5E368A6E9AAD24F1627D717F72BA47
      3C9EE7FE7176C6F8B713F461D154DC0887DF57BD7191AEB444CEE5BD77F526B1
      1E19B2969ADD7349CB9DACACDE6D9AF1B19400872A19D49069E5204AE2C2A052
      DF1E618578C8B31579F9A2F87277B7BBA3D70AA4682A167AE804AA762BC3488B
      E52F09CACAC13A2913789A963E1EB6121C7FD6CE207AADA9DC9698CBFBBF2030
      71BA777E1155F3A19B5987FA06C687C629F95CBABDD0A1B48A6B8EC12AAAE472
      85F3708380ABC42D54E5CE181FF35CEA750167C1F4700DE1064DC4BE01BD37CD
      A39C399D3B1CFF595248A15B52A39C30034A732433B355E2DCB4A9C4EFD72A70
      9853573733AC0ABA41F94E7FBAFB5AD266F5C0925510DE8CB1BA68CC866578C9
      2AD71CFD788C8C4ECD0803FFC5CA172451676F3CD60784B1C23BB2469635CA09
      4FDAED92685B89128355A774A9F86A7948253E673BB8FC2C7B501EFD364F2A57
      E0D7BD0A4DAFCD5E66B5C54442858F77D8AA37B268B8F899B069951D483BB68B
      B911AF22DA2E3FE4EF241291FB6CF2BA88FAC73FE7C5F5DFAFE2FA787A50A4F9
      E5207A0F2A9056C07405271A92D938A534D4A52A459AB896336FCD996CE32242
      B182E81A4FE05F50AD94ADDCB560B0A086B2ACE88A5505AF2DB98DCC4333B5A4
      D528875F7C3CC245B54B213E9F921D1078703AAF464ECE5186C62D82A50849F8
      95A8CB5589CCA2C50B76A7E3D62C73BE6D45918180375DCD946FAFC8A59D697C
      07A6F407DD38F48868D9EA1FEFD91BE41B3D0B5014350835C01B4D514C73E2BD
      12AC377E462E89C476B4D8AAD4F3409AA7DFBB5982D3517140751AF224511C62
      E80F472C65129BC6A2716FD29BA1F44DCAD2B3B8E625B8AFB6EC8E7EDA28026A
      C8F6164A4CE28985B2AF008757B32D34907FCB2F0D8C6F918036903B40F68FF9
      9D82261C9E9F52054EF6952FBB22B9175E364DD0651EA4015470AFD2E0EF6991
      7E4826D12FEF4FFEFDC3AB5DFEDF93E79F31E0063DF8CC2D2FDBF96D6568C43F
      B6AB995BF66096E126E2BBE4F1789DB009970311048205450B12FE54C120CE02
      254C594C7E21AEAB9D148A7384466B5DC27742B73ED8253586E84CDB81E0AC2E
      B5A0578CFD5BEBEE602C285652D98659E7E62FFB6910F9D35D47185DE2B00D26
      953AAA42E0A67CF0749810480C4CAEE4DB9A24D0050BBF5115691CD7B15DF361
      F5DC24AC1F1047BFFED79B789A2061E4D7FF1EF8B7B21445BEDE3059D1A915E3
      7B91CE361E507E5711A5763993A5035BF37086536D4A4566A74D6374B6D8C07B
      740DFBC3D514DC2C33824626F73C9E862F43425818208B9377F731324ED1BE4B
      EF29F26527CA4A4F4B528B6E67CE6992279B32F38C3156AB540B7EB1240FDA67
      0E7251D4BB9584B4DAF3533ACF77FBAD867D1906391FB4AD67AC1F82D6371FB7
      5F3E25E5CDE7680986576D47746AF6CFB368568AA1F77F43FB58B65EC4A8AF28
      539058B55C17B389303ABA8AD4D980CE91268E10455B1A6AF202475085201F02
      E63C8C4FF2BC95CFF7D469A7FAAA59863F1A62825468DDF32B5F1871DAA52F6D
      B11CE2C182252DBE605873852CE4864C7DA0F5EDA09690DCDAC8EA0B503A13FE
      4B2722819856A27ED86093EDF41AD83C5D3FAA8039AE45830E64142F3BB25B15
      4D02A90F4BB912F556EBB715AF21C42AAA711A51ACEAB89E571B2F7459E1BF80
      66F35920EF3F7C7DD3D170EB3A9029B62A6281CE40A871BA20E71A96F2581A6C
      5AE4395B75090BC22DE829E450C3E716F9988B9C02FFCB148C9CD9A0E1D88EDA
      FC1D1762F57E7DC7133AD1530B29DCD6F660FDC8E15D6CF4966C10FAD2B2A77B
      D1C7830F3DF3488E2F4E3B5195FC3627A24FD36626F6D633D1EE6F9F1E4A4571
      9EBE4C15B0368474057E6B2A93755E9F9D9F3F3E393BBB708194E84302ECB511
      4F59F992B236C5AD92C04993A33E2F735C3293A8734ED9CF48A2225587AE6092
      3B7482340D78F48E34EFEC9AE38BD376C15A515DA6CA55E738822B1FC1978F8E
      1F4D23BAF31AC6412386E718E924BA8E4B0A25AE8195110EC3A80B162D314239
      D66DB00EE26B94F129C764F331D7C6DDA8553187A8425AE600A8B23133B225ED
      CF79719A096E278F86E9B00172D0D7A2B4AAE6AEB0BC89A50720FEB3C1D3C113
      4DFC7688E6126AFC02E23249BF991754CD134354D42B80B767AA3EC1FD838862
      983DE2484E1A68372A9497975A3CB74C69A82889343174E2A851E6B99A069BAC
      6972B1030EAA04D3418F274AA45B08F51635A8DE6412AC2FA3D08C02873D9755
      ED20C259598CE7238292E984478A642AF136F08839266E1AE7F0A7A7497D558C
      713939A56B1769D7A30F231BFC39E09A7F3C9072050AED1D5F9CDE8119869232
      8FF24707603DB1AE62D170F236668B1D2F21885964A11DE1B9D5B86CB40EA035
      4C28502D2CCA7C37CE2F8036AC4C06F68059A634F673C659361F8C53A81CE092
      2FEB11EE652850FFDB7C3A8B2E0A579E79E31131052311FE5EC69FD337D2A9A4
      9A976BCDF222EFEAA7BE8BBFA236D915B4931D2C78D7E22D3D84A6625ED7C9D8
      D568C33FC1F102BB4BDD99C0284C7EC342B66C63D3BB0C3365DD33F5E40E533E
      9CFB946BFF7DD513398DB569A422311E344EBEF9D083D023A926A9FB6D10753F
      589C68E14291F303370E02B193C96007A99E6867FF6762445C6EF1306574A9BA
      9A4F262CF9138BEAA59C1B81DE492B5DA3D5D95695DC32218507A7BB0A4F0731
      83C6CFAD56A972832E7356F461742ACDC12711843D0F6EC2777B9F4EE516E4E2
      F1169EC8E6F6A24B4031C4A5C7735715D09B9BF37282CB07098142BBA11AEB9D
      8BFFF4A4C46399A2B6423141ECAA4E473A42BA0A787D11950FEB95E29BC9B768
      5414E538CDC92B0DCEF4E01B5A697255CF3E2CC6003D3AA0DB438079468CE272
      2C405E23C6CC956F8B724DA468793C5B3C6E3B052E9A9B8043C259EB0E8B1AC4
      48DD07ADCDD290970E366230A0B25577D0E43F718AB8009E239CE9F782484D4F
      44CDC81CE29B2A9BF50E98A4A12F57F39AAC59F527F822E51CA2F11BC0AC4E8F
      35102A7564480967BA1461FC02A9229E95C11EF4820F111B94E78562692D7A3B
      D2ADCAF4F20A684699C3AA7617B8EBBC0219F25C9759ACED35704E9593D1AAF7
      4974F633ACF6BA4DAA8088E27AB24D2EE20DD11538F5B92BDC62F9371AB40E46
      BDB7A2A3A260E56663898D846B38CDE7778A3AB994C1BA408C68834CC8F0EB3E
      4A82E1664D358071A192D3DBE38BD3C3CA2069FD90D9E3C707D1DBE34B38CC17
      30A834F0772887F04E344CA036B56EA3BAB9B6A211EA5B30CCCF84902E8FED78
      5416159408AA257A3EAB07488439C74956C722052DB6DFBAE1DA8B3AC16FE860
      39B111C568651568F24F8310C603CE76CE30A9AFC965BC2E3C7D004AEF62176D
      E29AF248EB69E5C9A01E2D3CA55252B03AA70978F38457D5371E809A8570A644
      8EDACD877E7F602BFB97EE2D68CF2EB661EC54C9022B9D99188EB7E351096A69
      5AFF4DCDA696D438FEF2341F2FFFF26A28D317150E3B214C9240D85A5EABB523
      4C8C34E49BC14108BAE1C64D084A36152B179ADF6871F52528C49294ED17A419
      164C4C5BE14A8C26A3B1068D6DB4D3389F8C9122D030BB71B4854657DC7C3120
      21FBB0172C8320639E008994D69BF34E74CA44DDBF4687DCC0E7A3B2406AB128
      7350A5C37F8BBB054511DF24A32F08BDD4B210E5FE0F5E0FFABC6BFDC2513123
      F024F5A3ED7DBD145CF00A1C6671F7E26AC92A20C782868BCBAF342DA3E67268
      016860E898282062A1F64DA7572B5D74C2CE81FEA22A8B361A378A4EEAA0AF6E
      EB254AC3658F2F4E7D59861D7FEA60D15C17CD524E4CB815E157E7836FBA9638
      D20C688B85DED864B81DEE72245E2D9E4B1B6E73B1F2D0C4742A590E6C66E1EC
      A994D1891157435C125C151BB2D3624DDCE9C4D966ED3B34BCAC82C1D512481B
      DD5F6DCA60A06707097164EED6714EC2B71EDDAD5794A480861656F376919F02
      05926BDA59431A9E5B9DBD058267255ACF9CC6D362BCC7013D2DC6AF15781775
      92FA3DBAB4F77A20DFB92C6A1700C4B7F0846BBC09C98D97C0128108210A10FE
      DA49146ED23B3D779B63122E306C586ECD603B8AC2CE9EDE706522514B591F26
      CDFF4ABF7280E74ACF48557FDD6BBDEB66CE885610087D924B1CB32CE4D6D82F
      691EB6E952108DFFB5627F3598D37A5ED9F8B75EDD10D9843A23FDE14DDF458C
      79C2498A9D6828C938C900B63EB73BCA7FDE5A077F87AFCD54758D2062E9B5CF
      01B7A01A63CD4354392E2A0C03240A6E2A1EC8932B1C2878791B4FCCEAFB3A94
      6A77FCF97949A780E9DF9A560DF884891D726EE22F5D4D9B2FE63547541755FB
      B4D959523987543757DBDE81A278ECFA231911009F0F39AF92C93C63CD9E185B
      5F628D2E2C225AB6C1F3151331FD4F93716ABCAB5AFF1E4D0D54428D39674691
      D624242FAFB84C08008205C299B70BACF5740EA51B48AD45148E8F9EEF026331
      75471FEDE365CD418BBAA7B163FF897366056103035C8FD13041DD87498393A4
      4A82777755658CCBA5A69995081A6C5E0ADB8CA709ABAD793A7DC08DF526D34A
      69493CC8527DDC63F0E4C623C262A63D2086E9D73863C4A5E0B06DD284A432B5
      2DB976D16C680F6319B84090954270CCA16A9E0A9668442D482B7F696CCB662D
      013CCE2DB250A4596D560666361EFAD7040708FAB134C5DB249BF5A277C9B779
      755A2007FA4D5ABF9D0F7B084EE2B0A544EFFBB82E13B8FFF1E56A1D097BFA6D
      B9872DE8C3DDFA88DC5CA7F918516EE9D87692BB781B88977BF54D0EF31296CD
      A64F7423A3AAD3FEBF3118FEE9A83A054CCB151A8E6B5E0212B047A4CFEB8D38
      B2BF15858AABED3A277315F5E5CE71A52958B34760851A11CB31C47D8A1953B2
      834BD1FAED013E89254ACC6DCB2EE9B2D1D19277B6CFAAA4FC8A53F14312677D
      1E6723663BD286E6C124DF97343FDC8EDA731082A343D03A106A81F9976448FA
      D9AE8BB69AFBD16136252A55EE7D7C54355679B06C502DA9B4D3457266AA229B
      B318218035C9D0F7B1E222BF447C379ACC5962301C7C1BF4CDB7ABAA3B92A1B1
      B1D0A42C8B0D730B9AE170A3FF5ADEDD52C73DDFA00597ED1B463CFCADD53920
      C3D737A24B596C3723CEAECDC23373BE5149AAD7D650696A407B09156D53F152
      D3A0BA4B4D333D0B7ECFA1DEA891BB8EB63FC5FED001F7CDAE1EF38576DDD909
      2C05EEE534CD0B3F4C5D268A3F1FEC0EBEF5A2E783A7F89FC160008B53AB2F55
      8E686416A140733C85BA26A89F9AA1AE123EFAAE8E1FE556BE60DB2C3C1C24DE
      0A83BD350D2EE1443341EF00E5DA81542653041ECBC620AF8672DB1A422E31F4
      2ABDBCCA7805A34FD6824CC7BA59208F41268EB25929B590743CD992220D6EE1
      410A53C4901CF24D375749B42C3C28EB9E49D7EB3397419FA1955462F5A07E4F
      5E948E67DFCAFFB5A26DAE7B69800ECF32C4AD3841360A789E05AFC605A280FC
      B35FB5B0D693721AE7727DB79FBFB2FB9ABC63916BBB50BC865C70510CA223B9
      3C640112C750C313A920952AFDC0DE74FD4D6609D46B64AD899C1F222D7A6D39
      D06B5A480E1E50A4799ED63777A10193E2709D8E51B71D94DB75D3B5F88BA82B
      1B8CE3066DCD65BA9A0BA293664C5A91DC75CAFA59A64DAB251AE3BC48A7F3A9
      76A598445771A6F8B3C660F54F0DB2A76ED9D58D39194D4BAD5692C27616ECB9
      75472A021929D6B2DAACDAF926BD6E0EBF2B4CA556AA53FF20BA22C9EC226C2B
      899974F2BDF727D0CB56AF749432F55E4DC23A45D564A5CB74435AF78E4FF66A
      BE9E857EE026B8DA2174FFC1FD908DA8D5DCC6513CA574B61F3B4B476483550A
      49B00502A70D8AD23ED41521DC8A5F6CFFDE1758DBF2E26EE909F5C1939D9777
      8580A1887E708378AFC1897DE451352A93246FBC219B9145E880C8460BC23866
      8C6221F27A97573B9F0241EC03811A8232A15E857B6B723264EA07BFFB00E8ED
      C46ADABEA1601550ED255172F7284BA56442D0A186CE71BEF0538DC9AF5ABD54
      332F0B9EEA482803B47155CEF32FA8EAEA145CECA178B720936655971E6E7E57
      661AA12B79E1593964FEB16473595CAF3DEB3B6B7EDFBEA4A58CEAF8B1339E1A
      8205AB858837A032306ABCDD117C8CDA85521C5E346EBD7C83E4958DD38A220D
      608823860B0D5EA509384D2E1C78C2A2C71BBC4EF2F432F77F2D107085A18F69
      BC4F0D3556D9C3AE319AFBAD7D35545D52E3A5AAB3767EA717CC13BB24BFD512
      6A4ADCD8BA830B2AEE4166E386E3776A927630B0C335B67620D7677ED2524CB2
      58135199F9C37CA4C63E72718B3BE63D3514E551FB226CE7936B67594294CF21
      31A6DEF08616F5B44A469DDB94E575EEBEDF5D0FA02BEF5CCE44F64544BF68D8
      93F923524848035E321212A95FECB77863C39BE84A0594B9A7A588665075F34B
      7243815D8EBD53F3108F4B37BDF4C9207C67E3C453E6D2E14BE902F6D98AE4A9
      D234349A8B68D74C767965A70B41A80955E38CA3D4D42530E52E3B6F9D18A4ED
      36191B46643934DB241FEF65382162FC7F296B5D96F18DE39E6F5EB560DD8356
      562480D0E8A6876B0FE2B10AB8A3894A277EBFC845C5A0DAF1A529D09BB5567B
      7A99132623A05F9B90C0FF5AF9238104BEC560DAF65C661303231C0F60133A4B
      3C62C2A4285453668100ADF6B632CD682F8A5E47D1EB95E87714ED47D1DECAD8
      EDAA3F6A15121B061BE65005045DDEB4C36BBABAEE6D56BF47B4FA55C0CE9555
      417B2A2D8539D3350E646846FDB591DCA98B867E5B57D6D70ECE8CAEAEA11D0D
      29A8A92EAB9BEAFC5C8A24D12E5B6C2B36A1662C625BF3C4B9D8E05C3F0B654B
      E3612FD0986B5892A87E65B9ECC358E37626DEB8817B798CCC9A251249C31BA9
      A017E7E3C7E83782C6EBEB34068985341BBE40BC26D08C34B137CD719074418C
      8B44BB1BC1029956DCECB84268A6C3C817B9173A6C45B136B55986077696BB8B
      D9275E195769362E93BC17E1E521A023D17769121240FA316E0279092A770449
      1AEB08991785696A5254CE03575F921BC9749E575B5A91C82D7E87E5F87F3980
      365F3A0548F3DAEEB175F6DD277B2267FDDE8F7472BAA06FBF723DEDFF648BAB
      FF936FACFF5353AA77AB16838ADAAFC4E6B0466F792FF4EEF6663750A9D10220
      32CBE4FD2AC1ADF1D4D5E72941E253ECF28FB3C7E87BD48587B28312E1E4DA5B
      CD70FDA3AD2182C96E81D105A43412FCC33ABE098B9DA2A37A536F502D0A7A39
      AE0B5A20FCF65651BD43641915669373D49A5B1E43088208665F1CF191617549
      9720A7E3D959A65E2E7567352F51ED3B35C01D759F3916E3D07464AEB458A1E2
      1FE29DED65371822AA6AAF1B087C6976EBC8AF47442B00B3140D435A7B160F13
      292CB362C52E9ECDC14FBB3E3E6177E252956C092A112F6966B31854207C1B87
      9B588A11C7E2AEFC9A32C992AF60B2816113403E6DA3250FD68374A0BE992955
      143B5C806A6AE73B1AD5FF6BEE4B9B1B37B22DBF4FC4FC876CCEC414D5A6A85A
      E472597EDD1D5ACB7AD6D6A2AACA6F6C4707488212BA488006C052A9A3E7BF4F
      9C73EF4D24286A03D42FDA1F1C25890412895C6EDE7B16874C35441CA50AFCF4
      F7A0BAC8D02EA46B37D647700C94B4A818542F3127B486CE2F7B713CFF4DE42D
      026D810D44D380573C849867301C1022A35B97ECD6AEA9AAA7FEDA95798E601C
      9720B088817D7EBFA69212059E3D24C06AE8AD62AB9A568ADCA7F3A33D4644EE
      7CFFE0BCFA3D3EB56624C94A30398800482C56262DF6E85B7DC9E1D97F9A82A0
      95BFB540238956590F4C1546168662D51D0366AFBCE5FBE961D85544C4D6D8C3
      9C2E76C2B3843AEA61C048F8165872D1202BE2112F56337E9241704B0503D654
      5E685593EEA37C56C402B9D003618A15723AB3E52F5658FB689A9437AE2BEA99
      269FC353B53026AC5C8A779C67C4CAEDFEB446F81B86E72A457532183119E3F1
      D6E3292887E9DFA194070A4D1136F5A10975EF171FE158A6182DC482F7085FE9
      0923105357F929CD18C3AE68C90F4FAC9E333F7AB85BA1A9C1B8ECFEC98FA150
      9003C751AF7A5857B112D83E836022FFD46B175A416021B206A34D9BE7F124B9
      657EB87424D15C02789ACBA70678309AFF3A5038B2FD0EF108877BB2E160B9A9
      B4EE749DC6821F5A63AB85862DA1EA38B2DA026CC596C2240B6EE495086FE2B2
      E26557BD5ED37814210A62F0AAD54A0D47CBF87EA4E8279152D892F34FCD43FB
      E4F4C21C9F2049535352D2F3D04CC16AD5A948DF87FC9498D41A289B4FA068E9
      2E315ADA785C57A0505FE25CE503AABDE2DE6973FB7B9D8ADD1B26BA8CFD224A
      C377B6C36F508F12D13D096841101AAB75325EB6350CFD5CB14BC2AC8C07B9D6
      BA5717DFC7C0125676C19708D453517CA560B854766EB7A1763B25D2A876F86A
      CD6DA68C47ECAA9AEE6FA5AA6D2D814522C79EF9C201637D9918976474952542
      7CEEFC17F4218403AC32302799FFC563FA40639FAA02709B6A635DB0F2A14298
      C8034FA75B32C31B53BAA8F52093F9FAB5DBCD6042079FBFFF458466793C1B3D
      22E0976599F8BBE54DA447566E2D5CC3F87FD2345CE59AA8122401534EF2144B
      2ED293306A30471179527D2DD51754284F27CD74BADC516AEA5509EAC875A411
      8122D4EDAEB7AE949AFA478D087635229000A71E4F6413C813A0171979442A81
      15F6ACAFE9CD16809C3E21F526DC22DDF241B7C580DF1F1C751E2F1E0F91BDE2
      D6C6CD57E837B83FBBFF7D707020BC9D12CE807232AD42009A5C51683DD816FF
      E34FFC1A15BAB9284C22B88E85B0F932431FA43735E30B1DC58FE074FD5BEE4E
      E7A6B7EDDF499ECD1E265B6B4149CDAF2B93467BAAE22A822A0626818F2A8323
      E4FDB11FD7C3BBC6CABF6717DF2FB75B59E845626E81994BB6B30F29A9BD4109
      72F33C09572F5997E54D3DA9CEFF9E5AF7221E1B1871A2334F4FB68F7D76ECBE
      A7593F48BE9E61ED284AA87F6DAC9F64F5DFE07DAD4B5E1D17950FD84FE16D4D
      D14514F8090009A27CAF18C01C07FA7C26346CC545938C35DB1F1C2793A701D9
      A6D15C62E31353C9B54CFEFD914E20A96B5F502901C2CC7E59FFCD1537B36136
      AD7C520240E2486E2C2BCE03C604D24451CB8FBFCE555ADED7F9E58C13C8E0CB
      7E6A9917AE7494A553FA9C5451E95165FB39D735F8704A4C82536E965F66B4A1
      AE15A5715FE4F53D8850C72705BE338E46DA8760EDCFFBAE2BA1BEE6794C4947
      2DE1B84B61991D7BB322957CAEF242A609297FB06F1A0098A59F24705EF13A5F
      72C1651ED28A9C8D6517ED202C0946025ABD60C73A053B2679A6956635D752C5
      0B7B91F6728446BEFC3A98F9AA7460962565CC262F7C59D886A6D34A399B1F85
      AE88BF0AC249AC4C9404B3B406729A7AB41BDF7A79C6E85A46F33D4655263C44
      7A4F343E97F541C0ED96711A28A4F901491A51FDFBF2E1F0EBBE57575C80BC4A
      BB834E0BFDBCCC0B5EB31BA48EF5E52A945B5185822D400FAFB887EF6C5E4BD0
      7F62972C8AF0B56BD873DCDF87754D7F3FC234F9F9CBFA6F3DAD5C85FCCBAA67
      FDDC97ACF8588C13972F338E0B4A58AA7FB9667F5FCAB13E2CB5325725398662
      252C478FE648652B5CC844FD08CD0CEFEF56957203D325ADDEA3D975BAACC88B
      65D74F00C29F20C923619993BD37D05A7F109856FF76C74FBBDB4E2556AAAD40
      530918725F1F8644982904085581B8A98C9EBF7056D7B530632E689AE6B02464
      ED11F107353CF8C6BD7A4A31BB7A1CDDD6B82054A931D3087DA8E7FC0EE7E107
      5E8736BC8B298C0547A2200D57DC72C6BAC332E42E797501D7D4504795AF31F1
      10CAC3ACB549336F7644CA6C6DA2DC68D53C5A83D20E6CF90AF8F393CD30C66E
      12C7636E869A21E36CF319B27B51947B2BBF015249222B5AE59F16FA23853AF3
      3D2D9AD27F830C181E449032837457E816A6114B477C897EF137FC4D8D36E52B
      1E6B91665A9CB1BFF8ED779AF188A926CBE6D06C3479695A4D1A0AE239A136BE
      0E0B055D8FA225CF845024ED51452BA2368583A7073CD329C1BABFDCBD088002
      2981CC8A903A3571AE2B6E8A329E2155F9F801B18EF9CE742A98161CAAA0A4FA
      C8F7A1B9577D3F3078B1849A9F86B70C512CCB948E5561CD14BBBDBC3771C838
      BDCA325F4B3607E2D60C0EB921159FA13EAF77A36B61703F862E2B24B42B9170
      6F75F884134A348B8FA063B801513FD46EF0D3FDE0ACE08396A0C0883CD81CEC
      DBAA6ECEA50FE7D2A0EEAF498EA2C6B7A6C6A08A0D1A25CD88659AD1A9B8FAFA
      0B3080059956FD3D346D337ED452B06506D7556FDC0F90EE9C45E555871823F3
      FAAC9415AC008619F6B07B9BDD1AC2B65297B47567C56A6EEE7249AA4F7A27E1
      3128B8F89D25B0147EACC15C3DFB53E3530B14DA9F1F3900F0C6503E90933C19
      30CA4897F54CE416AD2243DAD503B2CB9C9AF81AB536ABE9B90CAC44008D2A66
      5C04B3D9D36E96580FB7DE769256BAE02A5CAD0AD1A079C96BDD89469F917DA4
      210CADD69E9A05B86D585713705535EEAFF753BDB6D5C2BCD2035D7D8D609D35
      FF8BE03419EA659A1666A5E9C0D7F450ACCD4C9CC87F84AE97DEDC487CBC822C
      15AC054DB15BF54B350237844EF077149EE180943E3087B62599918CDC2C4603
      9262568D8DA0A0AA673D84558A52CE26DEE32D8C975775117CB6BC0485170DB9
      1D648A5052EA4FD1CB471C1DAB2B001F950A13F1CE15A643EB95BEA97AA01285
      6B0D795F56A5BE4AE28E8238894AED34EF423F81A5F33A790C7079F225EEACE8
      277D340230F1F1C27D3CDEDE837CE81CE2B0222FC5CEE80CE8FDD74170D5D926
      AC349B38FBA578AA320B284A57E1564A1EEBA3AED3A3D575E6A27C989439EA98
      A6B30A0C23C451110122864606E581DAE66ADD57D8FB75F1906B50A24BE63A03
      83270E43E90F87AA00BB2DBC5042E1459B1BB0A8FB2BCECBE583C37492F93354
      2C2E4B75595BD645AE483329DCCDCDCDCDFA6CB63E1EBB0F459C6FB9AFEE1002
      CB5BEE069D07835ED7C50E349DBA974F382E7EE046896D28CB0FF7089A9D4697
      AAD22FA2A4A9D4371E584F96F585370E4EBF7BEBF6F70E2FEC2983020BD69D0A
      0AA63B7E545155E67992E55A5019CDBD79D1FD5B9D4FF4483AB1AED8CC3B52D6
      879B2BBC5A6B926CE1CA15E997FBD068B9A52BA41663D66381F30817432FB66D
      4920986C5309D53F9D9CFB4899EAF8429A9DC2EC53F767EA550B3B94D3A18357
      E11BE69D61ACBB9334E8F09AD292EF9BE59EE1398089F6EA6E42CD53439865C9
      257E8B8410896C2A7B04B6AE9610E5E1E3F0E2F849D8736EEFD4D896103E2AE3
      0DDE194593E84BFC10CE5E05A3FDBA1CAA28DD71E5A4707F4BB3F26F41665A66
      700000E962F4CB211B79DDB5BA21A9F5410D5052157D1E7EAAC77791AE4CA843
      02DD46C7D6F353AC6F6546889B84E45594DA05DAADE7B6777F3C975370CF1D6D
      9FECF5DCD9FB73FD30A5AF219F862B82876E6B6146586D77ADE6175AC83ABAF6
      0823820F8777B90F605DAE3F002E0D2950FF204188AF100D7CE94187D2ED9A15
      7868032E9C2956BDA53243C61C0AA019379F6FDCD79EBB79903650AB9A55E0D4
      228E726453C8A0AA5EBE3C24AAEAA26D54C795C8EC546F4D8E1364170CD62322
      7D8CE325E950BFAA86391386BC12460BF7298D0395D8476E9A3CDD2EBFA19503
      C5EB0EEA80A96FA00FCAD4E39AB207BF3FDF735DA6A0E8796172787C5E5D58EB
      3CCE799C0B5AB357AD4A77747BAD28B30CE809BA98DA2541140AB5B44CEE523C
      82FBA561C27DD34D6AE9D528636135D17B607A78F11474BF9E3A7CE8C8F1016B
      034DB34725BFF7F833A1C01668235664C1715072890C88C217E83B50E6BD68E4
      3E51A1C9EA0D2A50C041422371EB2329C9D82B78B897EFED5E88EF896DB36AF1
      944578774504FBAE55EDC95EB80A3020F27FE055439A59E8CEAA40D9AA74AD4C
      275091305755E4513E25EA6E7C5FF252F80EE4F4170ED6E182463C101E0C776D
      DF66EEDCD508AA7A639C482A8F9633B2F5DA9F6CECA8F174F56D599038C97CAE
      DAD0678136A7A8BB580F611E31918B8FC8988405AF5040BD0CA8CE5DC349095A
      800429AD9BF089F1052C53F80B0854AC79975ED4BA3E389E10E86EDB71AFA214
      E318B182934B67242419A4102536E70B240034A67C680FB8D3B111C305413A1E
      6882C5749A1464E9D58EA23A5269043E61BE1D41EBED66C8D2E115D22B36A709
      4E8A711151E155F14F2C8AB430C871448AD8AA1CFE6D49AB003067B0B648A4AC
      0198D41554106055D344E38FEC06088971C65511587545259AD4B25456D1AB98
      9DCCE72EE6AC0FD368A5EFBA3B82F8A01B580DA51FC008AA0797755266BE6245
      EAC0BD6B282CCCEFAF8D0B0348B274F55C409AC1474557D16505D268E528C45F
      64CFAE56A670596383F168D886920CCC062E2C5AE8BDBD1AD4B2904B92BF150D
      F38E0253B8B4691F5B169D5947BBB46895113E8D11202B87C003C04B0CF294F6
      8D4754B79EE2DE20E67ADEF549AD9A56257C1F035861FDD32E1946B48FBCB655
      81AF8879A770B490D4F4127328030CE351845D02E2A6D92CA6F79FFF6065AFA5
      7352C6E832B4A756C6369A8C1EB193AF0A12A8B672665C1EDFAB47A77BEF2BE9
      EF7B331A514ECE8A096FDDCE58EAB590912512036E3870E8C9D23F3CBA3DF482
      9D4C33992CF30CDA64227709FF22FAC664EAC572EFC27C2CB5384593D1D4C882
      7F7D41E66D834D516C58966EAB79C6AE5F22100F9E4427B599E593D6EAD8C28E
      18836D5579445A5D30B8B13802DC9F42BAE711AE6B9E34D908593E2BABD67B0A
      1915FDB122643C827A8CE4DDE794AEE9B75FC6ED57E10D114C7279072B61318E
      248BC0AAB480BD2780295A76161682F2FDCAA5DD56226F880339620412972901
      44CC757219F77954E48124C112A5372559CE2899E333C33CFB2C6BA628ED4505
      554B656AE101B1B48242812DF109C6EF9F32315A2482E258EC6A362A6297FE06
      E3EBFC435A09316E4F13A6D9DC5F3F0C2ED61E3A1D2D6596972A6174C5F0B825
      2658296B370C0F651C1B76F3A3C185FB53503B91D67C29F0A7DD81FB13B1755A
      BE0CFF7684BF1D659AAFE05FD6EE38CA17D7C9B2E67ED5469381ABCEF261F749
      2AB6DE81F68D3B584DF89DF6EF939991EAC92C896056F60DECFF489BBE6D5347
      200D7B29075F691EC8C12A94ACC966C36C987D3543CDE0229CE9D3649694CB0E
      767A15FB2E5F6D7AB73681E88245E98D8E1C83E4028DFBF049B676F0F0BBB834
      8185CF3051A12DBB8539ECDDC1A5A0EB8D5DA35E84C2FA46830EA150BAEEC026
      FF382946518E8EB5AF54A5AAFB57D1653B33CA73428AF3BFE341C24710D642A6
      A7417FDCD3BB868FA32F41ADC30CA1215663DEA559709DFA6DD6DA2D03858C8F
      FACE3ECA0698775323B3C8AEE8412AB4230E4F6C909AE0F16FA1FC104BAD310C
      D0A57999FDB2C2CBF5BE20806DE032FEC8B948E7A9315489B6C763C1411F4E8E
      13BACC75A318A9E42D77783DC43F7E7051211FC14F98115B386E25E9E50F2E1A
      6479297F2CB6DC4E96D146F64FEE0244FD1FB8DA29A9C27439A2A91BEAC7AA7A
      F76D92BF378D807040752C3028201CB38CFE42B28E24939EF8C8C58A47F50F73
      31E033166B3FE00B72703778BDDD1B9548FD028F9BBC1A2504ADA1842F4B30CA
      A48550911D8EB2F846D07D350675FF714FB2135F26A900D8BB918211F930FAEF
      B51FCCA14CBFB09F8EEFFFF812CCDCFCA4F52887C39BE5E1D58278B818523A85
      D54895AC091420AE169750372FE638746306988BC7864C4A267659F337959F87
      52AE610B1F275FF425BA1723559533D917BB465BFFE1BE2F0DD1F3F77D6063A3
      DFBFF751C277573561EDDEBB96F727FC363624CB1FA5F650377E5F2CB3E041EF
      BB883AA6DFF7916A143DB6E1713A6EF5F76A045F0F8536B38F38781772DA47D9
      E8F3F238BFFDA90FE9949FBB43D859B9385E9F5B2240737A0E13E09508984FD2
      285DD2BB0C010B022713D1F2CD051E749DB0CA28B885D01212E134E86015246B
      FEC01E8DF4F22718AD0F205FDB732F905CF8E5ECB7173D597871CFD59F79D5FB
      B6FAD4525760E8442C5BE5B1F9F5D8B6BB7667DD27307C978206525B9FFC2FEF
      7D0E5D76500C149D1EBC44FDE5498452ACFC5A4A2C2CD7C28A50D058D3082A4E
      2911F5A46B4A64C174742D49866280F2391EBDA3EE2C2E1B6095C4F40200FBC5
      6578E067DEC1D82CC001621B49521C0BC1A4146FB1F466E5D72C42B09C11A378
      BB06925E0A1A5CCAC73D563FE97F7DFBDDA65B473434FACC9C2AF016EA3CC3BE
      565196F29B2A1BD5F4466FDDBA391AE32DF1104B3301C9955648291ED7CDAF4A
      602494D5697AE3EFDCBADBA31FE38ADB3EF7CDBE77EB26C3AEFDC812C83C070D
      9921858BD351C6043350F5C010CD2B444D54B80F1707EBEFC49C607D34DF5A94
      93F5771E60D5B059EFDEC0A4649C5407134D054439840B9117662944E36491EF
      B6043963F3A637C6F0226358551EA0B2C6C881E5A07836072600A845A435BC4C
      5F95FE43F2AFA0B2886D65D4FC0C521EAF9A36EDDB5BAFCA5BE9AAD55296022E
      62A973DA1556824F20C8C4394F9245522E56C0F29FD0164C0E2F15571D7E138C
      CD6CCE47C6942F6AB3B3E9CD3021FCBB1EC2B36E02729A5D5ACCB440E3D3DC6B
      D3FBBCC3BBB7E613B6A7D2AB232F0592CDB2311446AA19F01C0F884958EBB717
      85BBCAF2E41FD8A2A74A0401C079847D1D495A6E1EC3AC2CB3199D2331D86E1A
      DEFEFB976E9D6BA64AD5A20F09990C8F39E358E6214369253D25137A3AC28E1B
      B884A6B7C794EB20FF046AAEE2CFC3A47DA169BE46D7EFFA5D8E477BFA31AD61
      0BD1138F9D8D105D480DC426C928C9478B196A2623A6F50DCCA91965537D97D0
      E859DB26A7C30D8E66FC63555B69CB2A04B32487A48CEB54614C2754A69310AE
      EBD3A9DA7E55A2A1F36FB3CDB82B68142A19AB5B155A7F14A5970B24C4836541
      0976D7C8036713D7979D45DCEA782EED0F8B68A33F8C5E3B403CA012F29C4DFA
      7071F0AEDAC6108F4D75B88D75932B145B10B94984A936FA1C00709389FF94B0
      B6593D48C6BCEE73B6338F27CE939E483C64967B16CF329129BB0B4AD1F2BE1A
      8C6A89B77A6FB469C2389FC72C632279661C65E4A1B8EA0833590CDE701ED1FA
      AE805DA5ACB248F52FCFDAE894F84CD2EE83546A551EDF084AE33773C5E08692
      8D327BACE0B7A4CD206529BFE851A3EADA2A690DA3D7B72FB1D49E73D64B3E2E
      5D4CA7E61B3A9F7BA13209D29F7551F159DF40F3CBC3C66D6D606518F55FFDD0
      222D93A9E6AC2C8748C421C3F8E51456DB26FE7270BAF99B3B80504292BAF747
      A73BB4BCCBB367BECF7D2B26A9C5B7015C0260C1C2CB2EB25555441CD5F1F576
      0713DAD8C240E6AE07604E57CA2CBB0F6BF8F428A8546690E2E854EFDA9F4DEF
      D6CC79D6468B4C51D06A024B8809F52526612655E1E95ABD280FCA2294B4731A
      B782EE02F773379C464B2CB9B66DE5711D855EDF5149EA58897AD67D69D7E2F1
      AB2C2F470B9402798825EC428AC9C6CE96028072170DCC755339A53E67B3CEA3
      749CCDDCF6C7FACCBF0EEA16CFDADB17A7BBD5B6571F9F59EA3E25E977CF7A3B
      E9DE048ABEE2D2D3A959CC10E1506199EB9C6C7FC84C52E4861522E8CD6BD4E3
      E6599BFBE3E1C5F17EE1BABAAC9C5110D1FD78481A0270184E52F290B3C68193
      9AB9EFCF3F9C99AAAE868B9A21CF86D378F6BC2DBC25A8E0DF61651568684A03
      29AA82F027DFE3CFDAA21D7501FC119806153528DCAE32ACE1B98B4D85C7C88D
      513685CF2947B7AC4EA345518AE0CBAC691C7A47BB0C6543A35949567DDD5BCC
      08A14BBD2B2EA20F55DE0C14713D6963856C6AFBD310481FF15750A6B0B4F254
      37093CD5B8A9293005510AEA8210541082388FE302647ED666D5B31D9A5325F8
      16A716B8215E057938A8E300E34643120DEF049F924D97E532DA2EDCA162CEE9
      4FDE1CB2265E5191C5D9799504A83C07B52935234F2E0EABDEAC698A32FD7336
      F87A783A99147189BCE26E362D766124A3FA750262CB5932AB9C528D372FBE0D
      C803DCB0D79FB3558B54000142CD4183BE44D34A8E51266992FACFD1CB12341A
      0E3B62BF27C9E5C2BC1A5EBDBE924BE98C7FCEA6063941D84B17A5EBFE09FF56
      3095A944146BE83881FA79D6D538F62CE7593656D9C4E78DAD9831E8B140CB7F
      20AADA45D91A4DB6926DB811700205A98CAED974720084C2095238827D282100
      015ED9F2111C226FFA6FFA6FFFF0873FAC3D73A44BA403040E1125ACD858188F
      078B804CC1E07BB8BC1E7071096646E309E04A1031AF28D1868950CF6091A823
      C1554E418ABC85C06C3CFA0C944E75E25D715BCE79E82940F9239A49E1E359FB
      6630D8F7EBA3CFECA829AA4C80D53CD557B5A89F2F0F8DB5CF6E6E3EEFD0FC68
      D0C50A3A6CC1DEB3DE48423337B2519F4DDC5E748D5C543EEEC7C54CB3C385DB
      94AC8A87D12184928DFFF705EA4ABCC2B3366D851F983981D5AC472B44205ECA
      08DE1AFAF1E56C05A67295925C01986D1D11186248188D664327450E2DF21986
      49B669662425A5D727CF1199122EC792E51BC657D8B9F549B8FEB4D998EF6877
      C546615EDC32D54BDD97D476627A9DA2FAFDAC2142994FDD371229A08D3CC4AA
      C4D28A192B7EAB96C1A251660849D78318E197AA59C38F9A1575FAAF4833089D
      5C32830811AEAF62509D43F9D85BC845EDE9107DB914FE9069AB0A43AC77D700
      88CFBB2460D8AE57EAC24B3AB52B180B01BFA9FA1AD1C42A652C624E7ED3F0AD
      F7161BF69846FC0986DDF316090448867E0EA17DBD9503DD0CFC0CC0513DDB6D
      AB638167FE6B16935AE23F54CAF0AC365FE72332827626CFDB9630A5D1F3AF32
      0C6BB41B942522457866FE988291B8A0F00D6D98097EF50A6926B534039002AF
      857B413F2EE6720CAB8099C29B6A7AABD75A4CB7F9C8725E8953F8FE00D4E239
      913FAA814565672478F384C9A6E74D42E75171A552E22314326458A0BAAADA2B
      12D7B13223EFA127E7132EB09183542AD90A118E0282F613DF4F03C38A721310
      BC9E98A15884CABBC1DB8927FFF02E34016B4C3656453C44D2E867ED865B6E39
      268AF14F448E023A8193C10335492479A903C8E3BB45E3CC19186B30947D5A76
      7509E872848D796DB8A6E30C85DC334D306908938DE339DE4199476931BD7DF5
      6288CB2EA19ADE2A094382693125D220E34DFF75FFF55F1A35503080635F6301
      30361B23226606E6EB60DFCBC0B5B8BE67005EEC6D57D4E1361784ACA0B0012B
      26B2087CBDE9B983938FB26505CD6F74336577BDEEBFEEBF6C7481AF6F01C65C
      06A13DF6DB42D5738B94539DFE15A4BB71B1C6A59597D6E8E215E0BCCD553035
      158BB4FAFBDFBDC6F7BF7B1D7E1F4E32C59518188E0D2983458AF90B5640BCF1
      54BFD1650F1054EF0FCEFCFAADECDC7874959AFE9C2027797CDF1F2C090A3CF6
      F1A538F71EC539EC4D872707A742FF6D74350A55054457AC6D9A4D37E350B7BB
      4B2C4CA3EBE3BB95A28BBCF646DD8B8C0AAE66BD2B670B19974C03ED1DEDF6DC
      29EB56D84D83BFEC0F8E9BF534D597D8DDB6669DED9FFFD4F4ADBDD93838F9F8
      9BE879DCD7110F5C693FA52D7464705B297DA27885CD47EBE481ED41B3492620
      D232CE736C77D7D0DF71457C29A762AC7AD978AC34C46637D85304F5F8268D66
      C9C88D34113A49E2E9D8E8AF5AEA32F07F240E2050242D47577DF7095B1B7218
      E53AE5056619D2962CFFD42E964CDC3FE23C536164E239A202FE8D628420DAEB
      AA164380AC3FFF9B0B94DC3650AD37610944CDD8E3716E4A289418E72C3E63C7
      F5245EA4F1B44DF49F88A713CD37E8A7E94C952EC19E1FDB953B836DC8B17C79
      D9FFB6F182BA4E738C50EA95D6829164D70D0B24C9C6CFB183F922845CC6A0CE
      8FBC638515979847676601819B7CB92F58DAAB085C65A96E44D391D8B568DAE7
      78EF5B89492F0E3240A4A7C910D5FF7EEB48E555B348E597C1605FE6FF2E8720
      1278D3C5D05BE175B1D0E882B4D6C3B400C43358EF30516CC14A52F7C7FE6834
      6257355D8F2806F79BEB8878A660C045B3BBE858E82084A996AB945E6BBB9C02
      D320B5A716DBD5C1E966405B6F163C7CBEC99399FB782E5A78282C2ECA4DFCAC
      AF63CB5BA914D4CDFB788EF7DF8FBF924C7170BA59FD8266007A50910079BD8C
      8B6FBFE4F8FDFA24DBFC920716210D175095C1DEC2F2F36E7D9C5C4225E72AFE
      1AC1DA0AD25A5A48562200DD6BB22F8948FDBACE0EB661C5BD7B5D3CE38A7464
      6953ED5EBD903104AB5C38B1CE8D9ACF8C4D0D4FECC31A51C9A68E62324BA651
      4E8A6CCFB467986713E6B0962C991BA984CE19F3A74B54A1C7B6AB734E4704D3
      6D81E2E6F26D4DB194BF6702661E81AB29549599B01583AD214A1B36C5CAED16
      4CAE6E8BE7818FDDCE8D88D94B56EB4B207F1BA81AEBB945E4FF6EE6CD260BF2
      15A29FF7CFC1607FED389A1F03B19F53599BEFAEFAE35F1771515E0098C73F26
      1391D403D91D090802D7A57EAB520D72A294DA3CD9D1A26B8D5EC5CA2B9F6AD4
      6CE5A18E57C8A836BA1ECE2F482A41ECC924A0C61C9733CD3834BB2E35D90369
      D32AEADA3E3BE42E599160FE5E40153F4D26450F9CA3384FA269D173D30C09BE
      E93257E8E99B5BF3ADED375B530722B3C365864659B2A0B6B9F060BFED7AAF1B
      87ACF36EB355A3EE19570246A5C087B1F8FE5D875ACB91F2AAFFE6DF6DAC3CE3
      2B16BA934566349BD254178F1996EF96CDDED3A31E618DF0E8ED60A064B8476F
      49FFD225B2C9F868B896FC37CC2E1EC57D541ABEE5CBA988F7CF629C2B5A46BD
      073CF57A9CA1345C206171C40DEEE874AFD5ADE439F07F7D96E84B968C0B759F
      13604B1EC7056F44E99905B8FF08F535CA03374125BBA17DC4DCB8CE4D3DDB9A
      9B2481E4221403109970A52A6806B6F4D643A6E9C9CA77F936B3E2673BFBDB6D
      2AA7CF1D38905E09782795E767F3F24665069AA564F55DE38236907606DBED28
      3676D1E0D115BD80847A8CF24E84E284142EA6513A2E46D13CC6C06A74BF8393
      8F3664A945FE467E6A3D825E361B41220DD17E7F954497327BA671F4B9CD6502
      9D11E46579E8DF3BDC3E6A7149EA8259E44DA78DA66B6834FE8272556088E326
      31DD3D9B658EF3E8F2FF802C29D6A85A3860FA66B918DFA9ADD881EF1D6BBACD
      3A27A3B187C9B78A326405936D196AB5CF9F56D7A20C8D261B1030D14945C210
      F9C056A78C8BB23F8FD04FBA5CFB5D07090D160D715EDBFC270F6D07A76FFE79
      70F2714D35B5E2AFCD5EA0B29D8A221B25CC525A62126DFB631F09917954F4E4
      9F9BFACF49F6664E91F9317E48BFE0079073E83FD9ACAB982F3BCEC6EE34BF8C
      601790BBEE2B483494EEF51A762DD1E80E058125C1BA2A7473EBB34CBFB2F51F
      FA0FF4E19F9B8D3201F4AF138F06C081F90814F6A6A81DC28C42E361B27EBA15
      B49F69120199678B720E910F82B3387530067411B6800190D1194C61A4AD9286
      0439102C3AD7593FDDEAF77FFDF5381BFBDEFDF5D759362E7EFDD5728863E4E2
      A1487A74BAD769B99BCBF48BA6EE2A31C97CE3EA8F85ACAF899786F7C13D0416
      8A6D8D2A18793C2144EBE27C7F5FE3FBA3D33D1F1A2D1B3A58FEBF059AE05610
      D7A3BAF172D0BFFE672D47ADFF59CD8ECAE6BBAFDEF3531CCDB374633B9F65F9
      C6F66CB650CBA4628EB8A2B88AE3BB8AA28FBBFECEE9DEC5C6CEE9DE6BA15D7A
      4412E3215FB09784B3774EC60CA44A93E87CAA1F07B56CB8E4B56990B735DC3B
      DDF9CFD5CED04FBCE2F90A549158FF56E8BDDB89B7A747362FFB6F9A9EA7484A
      79FBFDD61DC2C64BD5AD40D25A407108F35D34C3A7F0F19069EB6BDC458B96BD
      DAFC7EAB72211FC74876C09548164BAED6DABBF4DA0679B9D5EDDEBEDE0A30CB
      79E689C162430D9B0AC30F758315D268A059956CC5C2D70C177F95959FE39B22
      4C8457D96C4D8977C91601BA4A640C7B38A7CDA3B1FBC62C3EE9F1B26E3FA559
      1AF7DC1F41628DF3B269BBA66337B84A2600ADA1E78D10ACE310DBC9E7644E20
      5946D49536566C84BB98B28B0265C9A25C406B9E54287E355B9470DDC11042CA
      42AAB571F119AE7E511E47CFD460EF257CFAD3BDBDCBA233F2F84032E3994CD7
      E8B63B6965DFD60689137FA55BE39DD7B796B2621C7AC6B7AA97C97755638CDC
      01443ED0B9D3334036313D22A456D2C5ACF269C5299FF067D2849ABD1FC0A5BF
      D9159523756E87E9BC289D8A83F49C6A333DB75F8C44E453540EC5E8972FAB39
      1445D3465AFEAF5B7771A11B2F4650379E16065A41595A600226C2C600A83912
      5F2B1B129C5325D51BDA8EE359E65E08A67AF5C710C6BF78CED347505F28B6B0
      FF0BC28505413B6174F9D23EADF5020535B79367D70562E9ED69F9CDC19B66A3
      C13F5DA0E336CCB2CFD07FD2E9A767BC2D1939AFFAFD6F2D868DFC477B0E8DB0
      BF5D6614366D58D8F2490ED0E83CC8800CFFC44AD51185BC7BEE4596BE0866C4
      33A5ECBAC3B88C2C1AEA518CC33618EE580DB718BD919DF922C4782859428682
      0EED5D41901653604E2403B8D67373E18BE98CB90185D64A5334DD0136E519E2
      A515B3B3FBE9028E3088CC7A8435F554962C9ADFE48B82EFA6E7DEC7E53EE0C1
      447F780CE55AAF4A5C9D445F8E9952855F3CE5ECCBCCFD3D4BAFC7DFB5EA4949
      2DB2495D6B931969E11638310868F3E8E3D17BD7BD9C66C368CA3F1D7D3C3AA1
      903A417B2F68DB0AE968A9CDEFFE24AAF3505791C486265D95B3706311801CDD
      4DB7E056C2F529CFB369CFF3F3F9FB3DC88F5BA49A39B1E7211050768616E832
      1CE570C40AE90067477BAF833B26A93BDBDEFD892625498ABCE05A8BD3DCCED9
      C55E60CE6289A26136BE211CBD12BBDC39BB38A1B2768BBB9DC7101CC26BA4EA
      24DE17570EA1822E19DCB601EA0C3637143DA82763DE265CB44E0F0617A1EB6D
      979BD88B01E56F6C557D61F10096B6C964ADFD99A461C23E2EE68AF15210AB9A
      522B763D2E666D22FC376FB700342D4AE83D014D3F81C68F6AB39A5FFBD89CFC
      4437EA6E57FBA7DEFCBB2DC5E64BA2DF8F74354AA2C9A2C8B11C5E1C93B86B6E
      E561A1288D495F51D6638B8CAF3A53A5EE1D9D2339C98ADF17386D0FF368F439
      2E6F374C4F639789D017BD598455A509E2287A2EE9C77DF7CBFF3E4BCA4199CD
      7F6B1E21EE0DA79E5157C331C951D03C35184F51AB3DE06A85A22204AD0AE4A5
      D908E2B2E74134957C3612133E1808541F55B9B7D99688A28DCC02BC0D9B0220
      06C16E630654AA1CB1CA2BF36FC78225E705AC07B2DD28CDA6FA028F13C68062
      B0FB9C21640FBE92EAAFB9144F6E170586D32C4AA34B58C1EBCF438B1DF9AE9B
      068FBA0DCBDCFA79F7FF9EBB2EB4DF2479F10F9CE5FC89EA2F6BF50D065B5AFB
      7B9E1D1F0EDA54157D44264E42D9103EF3221E104F837562CB1D9FEEEDF4DCF1
      E960AFE70EDEBFDFE6FF07F8FFC5A0CDAD8D2F78B47B7152DB2CD42DA79AE91F
      063F9DE96ADCEA6DF939A3096E1EBAA04A0D1A5C426773DEDC1D8AA324C677AB
      1BCAA21794DA0D89CD20A3FDDB7BB127C1FF0B45B15FC54CD4064BC28BF5D7AF
      36BFDB7CF7E6EDE6BBFE4BFCF7826297A4B379D616ED29656ACB851001A699FB
      79F7E85335169E23F2EF2056F8F557C1F58AA467E175D19603FE678DF543787D
      CD1482AFBA39AB4803581BCDC19A1D0E6A1A3A7E6D5114D4DBC8883A7B7F7E1E
      2C2A81C406B24C51797599037821604CB250DBDF73C5283E7EBF7FC0DEC39226
      C3E7E7A3D3DD671831FEAE9D0FC2D6B2B3F0CF83FDBD8EBB8EF2C6814855D091
      3BC8B1B6FE602767BB7FEBAD3816B645EBBFECBF6908095028491E7FD980E151
      680E25636001E1B83EACDE6BF61F8185AF07298BAFE01CC9F41CD5D166CC8C41
      65949BC7BF2FE8E7A16972164DD1DEC5FC1AC2182D9E3872458C83F55D25D1C0
      86D9AA612F68802BB97A9E88D031CDA3C1EDA0E390AF83148664A8241FD8ECD2
      9DFF041F14803A3B04597D06B2CC52619867F3C57C8541F5E3D954880637CCCF
      010517686614411AB7D9858FE07BC7C2B5F083AFF3A42C019E29DD9BE39D86D4
      3F6A9401310935EAF8EB2836843D655494E26CD6C2226F7A6607A8323383676A
      8794D16C4E26D38CDBA1183A4C1694952871CC10651472B431FBFBADCA8A30D1
      20FBDB40E2DE8F49FD46184A5450D7BE531924308A767F62E2D97BFCCEFACF76
      2ABF27B955F933E0D4C7B01581F28D024EEEB7DAF04CD7ADB614570940FA2D2F
      534F29772BC07E1E5F2E40E188BF9AD560B1D6FC66E139A37B7104D9C3788C75
      BDE72EC4742529CA9DEC6BC35B48AFFA14842817A89A86AFD0C9998515A66F0E
      3870B022C9124FC93ABA23EBF84342BF616304F03476C54D5A465FDD55727935
      C554C296431094DC41D6C1FB1DDA1157351B28D031147C33446B444C42CCEFA8
      67D374E09C066AF2C5F35DF650C28857AFBFEDB957AFDFE27FDFE37FEF5C17FF
      83225807890166BF71EFCE03D69D49316AD66FBB2869551227C42DCCE651990C
      137AB773440DB3F2CAEDC5D3F955E27EDEE712F5F3FE1B6F150850895AF888F1
      668B2D1C64AF135CD02F884506B53D59D1057A2A1A81EA41E809501AD534BCFB
      CE4D196FE3EA6E1AA797E5959753E591E7EDA61B2665D13EA27BFD7DB3888E17
      1A6569C58C1BDEB85996CCA2F4D5CB97EEAA2CE7C5D6C686FF4D7F1C7F49A214
      25F0FE289B6D4479B9711117DF6212AE1F42A67C7DF3ED77DFBFFEEEDDF76F5B
      9D93688C9D02D9202949FAB581F23B765DD9530AB77D7EBCDD73271F0787C80C
      ECBDEEA1AA70DA70B5D11BEF53F253FD6084F97D89840DB66A300011A0ABA43E
      D55998836A73C383BBCE352CABD81E25883C8F086D938D7DB9E9B6A0C783E233
      851C45170EF96716BC8B9948555F5E6545B9C6C8C7C7334DD725B9B57BF7CE6D
      61BE23C5C325DC2B389140A8126665524EBD452A40ACC2F0287C66D175C7E24F
      0CB2B35468F2789E67AC5C0F17976BEA73070A39F3A0B2D609E2113A6F5FDB3C
      C5AB57DFBB2D5FB48400CA4F0821C8CD9E220EFCF9E8FCA8121D149429F02772
      1092E0062DCC8A583E4B902D14FEC731969B619C269702020FA47A0E2F8EDBB5
      FAA5DB720C1182F23D93B82CEB4B0675C9060D3EBF3080C62AD159FE6E070B34
      2A2932461BEE83417CAD484F733962994F3CC4F4CDC999910E7F3878B71B8AAF
      AB97B81BCD93B28238E9891CEAF8A072A22AC04455500D1827B4F01B63ED767B
      81778222C64CB5DD15C0ED52C9FCB62BF3B306B461E486905EF5E5F5B7DC6D01
      411D63BECCA3028A021DE0343B9066BC86E842E3983440521846A745341D8EA9
      E25F15D519B118B563D3AEB53324DCEE2A5B5B041E187E3868E3DCADEA8F8173
      42A8F9D86A86BEFE1633D46B20A9FFB248EEA21A879C06EA67ED6EF28ACBC02D
      0387F3F892F1A7807789B6E05A5AF4039F6D0FD4E26E3C8D6ED4A090A99ECA3E
      D88B6DB813023E79E50A5FF8F3EED1B9AD6AF5C7D33A40BB077CB9F1EA15F699
      AAD9355D4042E27C5A4A7245E13342666C317781821A3E2C3839F48919A0D14C
      72CAB341BB75F93BB7055B431621E544F3C190D7D8024CC6C5B7B00002AAD51D
      B1F4C9C2EB3A5A0D9790AAE366D1D4A673CB15F6D52B8CB4ED8F61FEB756F965
      098F12FF3E00EFBB8184557870650C81BBAA65690C168CAB8A68A76F09A3F5C6
      CDAFA2A2DDBB788971F3910120CAE326E6C8E18DC59E82E5836326D0FB6E271A
      7D06AC211D57E0617A9ECB1E41CE00A4CEAD86AD8D65F6AB5D333164A0A82763
      F877C80BD884D2091C7F05399705731D54933CA2B89024B145304F290EF0C0BC
      B7E35BE4A7ACC96FDD96A3E96B3D25ACB95A94FAA59A2B9E2ED728EB7E111A68
      DF1D24792C9E243803204A0A22046C78F16482F3F397E94D353410F749DC2035
      BB76CDC7D27CAA1B84E827A3CFAD4F0BF089A8F2E0B6B584873C9685A4551EB1
      EFF6641020C8EF594F23540DD420FD2328F443A20F1420DA3D0302C08F59328A
      1DB4282AC91384D5F3791CE545DF1D4B8B0A190D2BDEFBD21EFC534A07417C6E
      ABD5AAFDC66DA90AEFAD1855754C015A92E1D2B39EA91935012C4035188A1222
      053509545B6420D836D027104E44A62A18309B0240EE5ABB8EE6FAAA140E5DE6
      34E7205805AD6B4645915C82D8A1B8E3316937D61A91ED9D61FCEB21A3F2AE32
      3785DA752D6DA213893F45A586A199F996497EE95F94F4B1951FB3A583E57131
      F72E875E4B3E4A475719CE395883E8EB4828589637CC3A93DF0D295F2EAE40BB
      8CA2D115CED436ED5C17FC40F4C3381E2E2E11F9AC3D43CAE55DB3940B35D568
      156C741F793509024AB0C404041E47292B3DD94420A7068697D950B10DC863A3
      4C5C347527F1D70517A341194733AE81C555A6C0B2BEEB0AB32B2A3EBB6808C4
      1F9BA1E36692E58B592BA0C1994240BB92BAB0BD7ECD630E29D8C183C92C2946
      B66599865B9533DFCBA3CB2C1D66790AD1C1364DEAA04EA993D11DEE7556255A
      342269749B0B5CDE948EAC78B6F2FCA7CEBD82476A96C8D4D469254B1EF025CA
      CC82F9FF70EF5EBE6CC6BBDBAD98BE9E6506D3202CC2340924CEA3EE21D5928D
      6101A827326B2552996E2398B3EB92A870F8A3ED933D4143B35127DB1F0F7DBF
      77855252E792ACF5DD691A80D4B55C2B8C3ACEE79E720D441BBFED237946DD4A
      A418D611B21C9E4773E665FFF5777F6933434C78739C4490922E1643B1902462
      8E309557FD66D69F6674BB312626989EB78B72F2CEA462FAEEA2D24A0EF37B3D
      A9F5C02A000577A9E29719F31A833217EE546E290E91CB61E45466A88BB55165
      533CC1F04667D3868F9240882AC0BA1DC7A967FCB57F796FFFD2964D8A9E83ED
      283D5B5CB7CCB3C5D0DB19D57C41D6DAE7A995F37BBEBDBBAF492529A00C9339
      F17B5C67356C39E4CE551581729066968F7F82C8D49DB0E805A207B72F2939E3
      EAC8209B609B8A35DC843C8255E8EF613A4B84DBB1240405C7C27597E7707BD4
      F8EB6F5B8D83C3D91CF8581EED807F3F3CDB1B184657DE507B9AC7DE3EE0F47A
      78DC3EDAFD51B88D9D3D28E82F4625FB0901DD342E3A6BAD477580562D881A51
      A13C2D4693429DA45A03DA3E3F3E150C1806A6F7BBA1E434AD7D777FC232C628
      336AC5520A460CEB51AA9D4FF2816F00FA856384EF83865E6CB4B4A2FDABA06B
      73F094C7822A3CE372DD35346D92CAD0DA5CE389834C433B37033644EF20B380
      8828447DAFEAF7432D24DEC3B6135381AC48336D60787716C90667FB566B6974
      FD33A6C2D7872CC856FBB5BAFD5177253478E9482DAAABDE619E921A2E0600DD
      03BE5B66CD2641476B2272AF6697D84EA3E9CD3F6260A4E432887072080DC0C9
      451955CD54C24508CBD85ED3ECB2D1654E87D3E40BB6FD73588ECD62E9DE3391
      1301F9E492B5E7AD8D8DEBEBEB7E8A630DA8E5AC3967FADD0DFC6663F3D5BBB7
      6F1AF5D2B104694A2CE4C13A73D9041832A23DD16F5EA0BA43A509E8EC0C6508
      EC20178E2873238FA3D1158641AF9A88F9E8AAE706F1EF2CB4F62C1462A4D373
      7139EA371B1B0730D11693145A6AE9DEAA96CC12256D1F5DB4DF8E369F25A60C
      849A4D584265AFD57E8272A885E97F01A196B99DD3C180A57F2EFC36C59EA1C4
      4E0B15664A02487492BABF7E185CB4B93C896E82589FC2170B0544D5EA18C628
      5FFAC35480F469B5097037549AEE34BE8C4637EEFC64FB580324EC453F689F6A
      714FFF2288626C963DB77D8CFF7FDADF3EEB7137EFB9E3C341ABB3B6E1B556DF
      A532DF464BEA3B165C2F27ACC6D19EC567CC6D4565A91F8354C6CD5A0BE2E549
      166A88413AAC8D4BE5B2B0E16DC83D91C9D1E53883ABBA18565017271E8B688E
      3AAA9B959FAD467B47BBCD5A44A31D2F9C0C68AFD70A139FDD2C842807DE7434
      950D2D781BAA96F9D32FEA7E4599DF54533F4B6970A29EA68DAEFE23C42D762F
      CE8F2A4741590EB5A400D419BA7C522D94ED17C3A6AAAE322D74A8CB59DACA90
      68A36CA5E1CE9C944210B9ABAAFDC0A67A84D5472660D17387E8E41EE464A7D3
      667BFDC9D9EE56FD323DFAFA617F2B8B9E3B80D9EB9D5992072E7E1E8DE22DF7
      6394406573FF266ED7D4DD0764771E6A4C2C598866DFA6EB1F80B7CDBEFE93AD
      D159BAE5283CD55319AA9EDB9ECDB21E5E44F31188F50978ECDFDC276EBD718E
      5310E6CB87BD73B5A13161FBC8482DDE528C0AA9AC46073202FDE7080E6E0B89
      36B305DA39DBBB20B2D55211704FB38493D0E774E165AE9B402BD1D9E0B37905
      AE69844C0938B5DDEAD82C57E3B2720F0FEFE179F4A2706562828AF5CBE3F7A2
      F2D4286478E0DE086E3CAFB08EB6A89AC0BB37BF7C51B2DB6E3F1AFFD0E2EA87
      F70A58EC255FA0B194E5EDF25AD1283EF8D9CDAFB2349E7913688D486573D6B3
      66905BE83F4B266D89EFC5EB230866A776A509C284C5F0167A866C1DF8E80FF2
      B90A1DA12F5998EB0B99C6F4DD82A0316C04DA2163E9D0A2F257EB31593D63A9
      83032FF4FB82E899C1FE5F25CEE822F5472F49212D5960A3E46EA42346CB148F
      A727BD6474D4E5AF9B9A7E218ADBFD71DBD209EC73CB624859F12A9A02C42DAE
      111AC8EE613F3CCED2F806315B9B7B2BD0672C41A906A93D79F591E07FB5205E
      1B35213DBF21EC2E0B5859BC76072FEF33E6F2354AC8F849B037497AD969C862
      D38894793050F3986B45C23EE09E31E46A456893648DBA8D62A69835BCA44180
      4823C5292A35C093A7166929A44ED1E9DA0B786C7276209C365C94A534523F2B
      CDECB1B42E896EA9D96AF99D50EAAFD087933A3D9CD17B52C9BD7533DD7C690A
      9237C6BFE94307F533DBB75B8D8E81602C2AC189AC1E5680EFB5F91BFAF26FD3
      EC9227FAC53C2382B2212658D6C75902D0A597EAE0CB12A520728CF400236717
      AB35E4D5A1C3F72E377D41357BD4B854C7716DBC265E9A4514E6F248924EC772
      3DDCA6E720128BCF5462A72F20159D79E958D9342A25546A11F36AC650EC5AC6
      4BDC912EF6071FE55F71397A0E304243254CF39C90946073D86E4095E471EF4E
      8FC707AEE5E56D91E28660107D698B185CDB129560A057B265C7B22730CA84B2
      ECDD18A9D541A14675059AD18DAFC51254D5C9E474AAB041AE7BC29933659786
      9BC5F674FA9BFB94DFC4E0345D094D03E74BC58774FF085BE5BEB237BCDEE32D
      B9C7A6773F3AFACD1D1C0D2E584B11694631B1AC45956DAEBEBF07E50B42FA8A
      0A87E0C3E0563143988855E660CF7A681AFCADAA59CB470596688333F0F86DD5
      9AF5E9969D3AEAD4F24A1A64449A8821176A6D6AC1890B8A5958DB13B22EB41B
      2442637013A4693790CB652A974BBCA69154C72B14EA6C1302C9A9F7381BFF94
      94EEF0F874CF62B150DDDE14972A2C719B5B2E4BAF85433928A4C1A731BA6CCA
      D1F62770C188CAB12804FF55925C8DC949BFD80663078CEC1AE9902B4AD3F2D9
      24110F75BDFDA3A3D63719A4D9F58DBB56B9CC30E3997C0D4F69DB797935CBB2
      FC1936B957DF3FBF7D0E49FBD8B018C933900754428FE1ED9BDC10DFA1964D27
      1FD9186464A1F2A9C07203542493CABC666C0A7B942018C66A7DDAB0F02FA07C
      F1B057CA63263EA5A543AD5411D7ADA0731D64FDF156A47655743C04E98A7A66
      D53C1474321F372EA3642A9441412E620DBF6D81D6E8553584608C89B7515D7A
      84149572B75ADB4A268D8D16FA09249A09754622FBEF8BD95CCB8C91F5E8F3BC
      34762C59AA71FED95E19CEAEB8DB7E8A30F92C4BD266780859CA065CCA0880E4
      E22CBFFD467F7F86FBEECB7D8939C791125083C811E243010C6EAD40BA5A1AC9
      57D5E9310622B85530986D68D45A1C9F6B2F09F91228FADF84F5113C85C8DAC5
      581AB0C189C84A74193564F91A99705D5C1EF57AE03B18CA7F84B55FD85319A0
      90E0C6B2258806389B616B2A5CC42988A1D4C203964380C4AA1C2D32EDE0C408
      5AB2E1CC3F26BA4A72B46C81FCE25CA156986992E9D32D1990B34F9233DE32D8
      5EFC751EE7090072D1B467CBAB785A46CBE2694F9DA9AFFBDF3675D9235F507D
      A957614946712ECCFF3B028B264D6D28060A3ED841F2754BCC89388531514543
      214F0AC14BD21A02F989CE64F18F7FDC7494F68CAC5B1E178817CDB47CE93226
      2449F6AF5C126B3B8EC0F1EF605CA356EE200A7BC911066F2E7983BAA691E664
      47A668345AE4A84167139B67DD4D37BC29E3B5E51B0BD3A1EF76E440CDCC0740
      80C8BF032F6DE9577E8DC4F4D2B6039037B475D264D90CF99BF6EF694910AB18
      BE7979EB12AFE5129D7368C2E314A92C69C6CAFD7EBF731FA902052A4C53F1ED
      95285BEA0A94B0FC925C4A500F6F3AEE14EB7F7677DDE8BEFBACFC8E74B482C6
      B1D4DA1F2B7571378CB1DBAAEE2A3B5EF2B842560176FF86516A0EC7828ADD8E
      BA8A173832F30B614FDB35D69023E34F1C4A4C201B995B64B310CC7068DCFB68
      C6E9571925CDBA7185A4993260E4B36CBCC0F185B763026F1A51F74E45878CEB
      B080B287684CD365FE5A7917D1F41A4220AA860182A8546F8DAAD18DFB977D55
      6338387D732678843E8C8785CE43F92558B87C89F36924160AD6DB7A68AA4A4E
      DA5AE605396D69FD5E2C984B8A4812F29E84727932F8E85022C7E2F0F2D85871
      0B5C43761BE11CC4395EEBBD5DFB69FBFCE4F0E4FD561532A0A1C1280929D1D2
      6A19536CB0A65199FA42814D745E40B34DC79ADDCCE3E8B30C21A17FC825F890
      EAA89814F65B84B84ACB5508B1C86AA5376A23132D771D7419BDFC96E8844FA7
      A61ECB12C8C1E91B31E3926147022F3B5DE684674F14F5B1CAC6E35A15750CCB
      5D96237C9BDEDCDBA7229D5023FAE00D3134471F25C8F5FB3DBC338D724CCEF1
      9819E7E83A82F5368093412FC6CE329480C22F20DDE636DFEFA8C8C442109D62
      4718B9B79BC3A4AC2C8526EE13F33EAD37B537FD976EFFE7B3FDF3C3E3FD938B
      EDA3663B9C3C6E2501562078515F5F96AC964E6A3DDDD2146F3BC368A0488C6C
      1BC142A61437C029C6715ACAEA02E123F911CA0765A623ACC3CEA5D500488F97
      69324946185EB4C1F05A9619CAC5D0135EB6C5D0E524D0C620C715EEF18A226F
      76CECE749962789806EF305B9461F5DCAF29B3AC280D48A228678D0666719406
      EB210752116B8C596077BDC6480ACF95FEC3E3648C843BFF70C38438FDEBBA48
      928ACD6995D52E663DB73BA8AA94CC22E9DE6DA13667119D57A2325EA3385E12
      10A4C5924586389A6E7DA8A564416DD94C1683BF3413B01D78D626C768D7E5C2
      1E5EFCEF8B82F3BA30652AA99C16B2C91525BAE6731CCFA5EF71DD62AD766F94
      3A829B5F25189FE1ED79F78B5ADB15B62EC789757EFCECFDF99EECCB71944F01
      DF34FE43E3FCBBBF9D61E812C4DC519A887C52B30BEF2C2E91CCE1614562343D
      A18FAE4023D6D842E8C955D15F16D2666CBAAB78B5F8817F3C1DBEB28A9FE198
      93BBEDDD1FCFDD2F94157EF96AF337BC0C119D044E09ADAE16D9415CDADF06CC
      FA97993B9D733EB302205FD075B788CBBE7B9F4828AC1B074F56B94F51A0A8CD
      24E862AEFD507198C2E0D51FF6D4F0817B945740C2C6790D5F999E04DEC9A40A
      BA035B9880ED67DA4056869712064FD67EAA41750167360DC662BF47F7FF95EF
      86930EE70AFFC8E2DE843F3111C0B5CB1EA42773729A7C96EA99999CBE380CD7
      6A3982BEF02215FE8E6044377F9AAA22A2C31ACD46DEEDBAA825758462EE6224
      4C7443974735EF381EBBBDAA6D54DA47C771A0D8AA5A5BE8395A3A6928C81BC3
      E743CE5255A5F92AC29907802D0404CB1595A76FDBAF9B1E9BDF23AC1B5839B5
      FBFE7870B1669CFA6BA95BFBC14D1973F053504FC8A46A0BF69C0831C8CAD090
      A9A549111DCB2A5713403598E4555510440DB2E947EE80F6BEFC72FB2E5C3E26
      AE38A0D866AD6721D61366D1DF9511644337029357CF1F411434E48A8B13B266
      6092620517B2DD733476A11780811D0E26498EDD945E71FE849E6665321202B1
      B8A5B6BC51E45E63A5ABDF84F9B268CA90075CCF08D8D9C63B6745748ECAF812
      E2179D1F85E439BCA1692E9D9C3B86DD1661548170708C37D300A0268EE2D087
      37951647963BAA544A0F2384BA8CCB607335B7DD505DBF6259B4036CCFA39CE7
      5AEE83E5957B0FF9F68693150E5AD904397EC088D28E174683CA3D3657D5BC90
      84304593D556B3B1FFD0607939EF92C54334387A12270833740299B7872050AB
      263DD7EFAF69667A14666A183A74067E19EFF4FC4F27591ACBF9A173487FC9AA
      05CD4C7E55F00B4AC892CA907CAB15762C1B9E4D260918CFADAC1725B4DB0AA6
      9A98C85CE7190EB686518246448DB15BC15265C34A4012679065017764DDDC15
      B545B67E4DDD6E799C3085D5C85FADD123D0981185E0F21AA6F2FE2414E34C9F
      14339DB19237098004A3297EE583FFE6F3D7DB162A6F223C6A743C3D4C65C502
      2DD30E7DE60AF7FB8262735080658AA56296569ED75CFBD6FA6E5B25D6B01F58
      12815258C28B613DCD2B848DDDCE4DA7C69EB2F0222001D61DE4F169DF58413D
      FB644DAB2A3B5650F3FECA29F83FC5115351CE92ABB0C4FB28C9478B191674A8
      9CB52EC629E5247279C6ED8F629A4C55D275D5675A19CBA0E403F8BB58A15AEC
      7E2DC736AE07CC765B2821B824A61D05B10129A7BE1B643E9587952D8E8A845B
      77E41D81B0C2C3B4B1A1632A1215C8C25FBAC3175F5821BBCC44F59E7A2E3FB4
      2BAEBC6A5AAFA8C78878D152F51907D998B4A16BE98145FBAC20621D39C3519B
      C917AF9628373585602BA4350C0BFCAE5FB82E576113CB89C01280077CC30DCA
      62E82079737B2792654584772585B9217572263223D72FE3621303D7431C99A8
      F7875CCA66C37EC5BB072110AE94A18475D9D5DDC4B04F38A4CD511B63DCAED5
      480F486AF6C067B620E64CB20A693A28BCA962172579ED0914E25C457B9759FA
      F8DAFE7F650B4A927174F3A7ED3C767BC02DDF17B8FF57B6C06CE23C2539FE2A
      9BC636431024EE65A30552EF7DF71EF9AD3FB81FB3398A1053E874DD4EB2DD01
      9D7E500356D3DD5221912929D571B77E88C7428B0E677C9C2ADDD5F39534D603
      158547063A4ED4BC8A56683DC402EF7591227F85CE8FAF4DD7C4CBF1A6633FEF
      FC4AFCFFFEE7FFF8FF64D6375C}
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
