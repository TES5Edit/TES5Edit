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
      789CCCBDFB731A49B62EFAFB8DB8FF4386E7DC6BE90E0849B6DBDD76CCDE8100
      C94C0B89062CF79EC63191542550A3A28AAE8710BDCF397FFB8D6FAD9555057A
      584EA49EB323768F254165563ED6F35BDFFAEF71924D8FC63A4A03FA8FB79C1D
      1DBF3B1EFB663A3DFCEFF1348EB26C12FEF7787A389EA6AB204DC7536FAE93D4
      64876A6866B1519FBB1FFFD7FFFABFFFAFF15227FE389DBCF9E1709CEAA31F0F
      FF7B3CE16FBDF9619C87D95C0DCCEFB94933358D13D58B7DD5CCB3799CA42A4F
      8368A66E3B7E90FD2F3CA578163F859E71FC5675A76A1DE72A9DEBC4E05F895A
      C47EAAE2485D98DB3CC52353A5235FE5A9E1A7299D2AAD16FA5F71A2BC78B18C
      2313652A88946F6E4C182F1726CA6A6A191A9D1AE5C5511AF826517E1CE90C33
      D22A5DE8309411631A3E516DFA731CA97E1C4459AAF6DAFD7D95C5AA132E8228
      CD4CD2FC8C1FD37CB98C934C6573A3E26816E3819561F1B86C1EA42A8BE3F040
      8DE64625C68B170B13F9C69739C4910A52F5BF8F0EFF9F83C71686DF35489597
      E45EA0430C8F99D2BC7DAC928FD1F1F43C0AB2352D12BD8B174759124C721AAA
      AEA2582D74969984669D067F1855C77383E84687B99E8486BEEA1BB30CD74A2F
      9789F1029D197F6B7A8F9C812F739DBD4ED58559611F78E66F0F8E0EDE25FFB9
      FD8CC33BCF38E6678CCE3FB6078F2D487312E7993AAA1DBF3BA4B70EB254A541
      E4191EEA775EEF9E4966C6577D9D7973BC6562267910CAA1C9E68931F5955EAB
      053E5653ADC4E8CCA8B609332DDFC15AD043541065B1EA69ECBE8AE2954AE23C
      F2EB59122C6B6A1527A1AFD2A5F67086A6A9C95486A54C154ED52A09B2CC4438
      C5A9BE3135D58B93245E0591AF663A885275D1EC75541844D77CB607666A1213
      79C65727EB1AFD6A9E477E627013A6CA4B743A37694DF93AD3F5304E53B5D4D9
      9CBFBBD0E1344E16C6AFEBC49B0737464D7510E6894C651ADC1AFF407D8E7C93
      444667F31A1D0313CD82C8E06C847134C3FD304B13F1C5C3DFF3D4245800934C
      E91513FC218E8C9A85F144876AA6178627CABB8D45F653B50AB2395673390FD4
      D19BED0374FC767BF38F7FE4CDFFD9ACD53C98CDC36036CFD28DAF4D833A0E5E
      18E0BFD9ED9B1F2A47623CC9C3D064E34C4F3637BEAE0CEE80AC01368F36DCAF
      9C004D3B9129A3BDB95A86F92C885EA72A5E456A415B5E5369ACB4FC45C551B8
      565E9C4336ACE626310A82C8CB721DE20F731DE1E969BC30D93C88664E6FF0E4
      C358575AF9F4A9257D6A62B2953191CA56B1BA31491AC4119D1B0D299187A666
      DF7EA2BD6B7E12F6781A246956A3D59905372665F960BC38F29DE6FFA5BC13A9
      AAAB1B1D06BEBA3C1D8EE46AF079699D0FFF81C374AAC31017FA2DFD36D4B4E4
      F75C1E35592BDF4C751E666EE7A2B87A75BE7689BD6C7C38E816D636AF20AEF7
      B59DEFDC78D7A4DD3A4902C5761DC5ABB47CECEB5405BE893288E0248704D82B
      870C5295664118AA9BC0ACF81005B86024984843ED3BBDD450DF40F8E320E0B6
      E3E861A9CAEB1C1A8D1DD5CAD70B8DAD9F06215DE3C46828D494BEE0B6CFAD30
      26DD8ED5F174E49930E4C99060F1832C4E549AE935C6981A5C978874BC17C629
      EE4D0DF35826264DD5B559A735B59A6372C5E521B19D475110CD780BB4FA1244
      3E563D35294EB73291AF26664EEF1806D7466915C5C942873C88D36B9D0C9B09
      898E691E86AA1FEAF53063757D76D13B5556BA8A09505327269B9BD4D7AF5395
      99DB2C4F8CF2E679744DD386D28D217EE30447AAF840BCA0170FE2A8B629BDED
      F3F95026669AA7C657647B68BF5002AEA2A56DA64114E0657033EDD57BFF83CA
      973E543D8C8B4F9DF6401DFFF003CDEB344E16EA8A65893A3EFCA9A686994EA6
      81C10D871E9CE8E85A457A617092715D8C6FDF285A93D64995F612E82A585BD0
      17E993D541CB5A3071923E661254ACB39A4AE28949B2D9F5F1E1D1FB9AFA3B6C
      ADB98ED4659A2579AAF6FE3589E95FFB3565BCEBD4247A5E83083479E4E79379
      4D41C5DA6DC137AF61C6A9563C99D0EDD7691AA4198EFBC1936D9A1E19A9A746
      63F39FFEFA5555E6B4DDCD52A1410FAE71A320E6337D4D82355C8B12CBE63AB3
      2ACE2A312836D18D30B14A8DF8510553D231FC8554BEC16A432F605464C99AED
      0B92E76430AC82C84DA17749AA7A3A54DAF7E5EC2EB44F0A616316D0CA2A8E3C
      C3139C9BB5F283E914FAA49C4AB120F661EE136BD235D659300942487D56C2B0
      D4F16B18E76406616CD2BBB8BD58495EC5940C0BFC9C98457CA34336E31203CD
      8D9FE87D9C26D6A9D83C4B1D602613ECB42687658DDFD7ECA5E4BD63F3921610
      93B08684359EE878B0A3A421AB9D667561ADAFB49421AF5315991482E7A2DF52
      4B9388210CD74507116CCFCC2CA081ABC2EAA2DF82B68D6E4C94C53869F8CAE5
      240C6EB09F7812AD240CD67469C2D0757BABB695A72335918DF43F96062146B2
      D7A3C5FBAE46B1F2E225ADB38AE2CC5A5D741AC8CC8CB3B9499C2605D7E6DAAC
      5771E2AB304833D69ADE5C45383732524DAD70A9E95C6DE9F647A5ED1DBBB356
      7DA57B6DD06758D9275BAD9B062B2FE79D09D5EED8B035985A26C092AB38F11D
      E77C8F511ECCA218EE55330CE395EAE96BA3FA3AC9021DF2892CADB0248F52A5
      A7903F85A116272A33C9228848EFF28284B17634C536B7E99EC9423517F25C57
      B4386B7E596BC7ED2C9F56DD58921AAB380FFDAA86E081602CAD97863D73B671
      683FB55A9834D533A326660AC3A92230D94C8FB5EF68AF36290893F8CAA3E5C1
      81BAE34061C348DF63AA953FBD4E65E26A9AC40B3E5D9986F947EB1D1A1DC901
      84316B962233E53B5648C88B38CE9E4C777E7FF8AF713E9B6F881C1D89149840
      0F7FCFCDFFF25014C371A615970F5E41BDFA4C6CB975ED604F61C6E4689533B0
      D192D2E3ABD9D3119995BA5CB211E0C1239BC4B71FF18D42FC97CE15044528B6
      0D6F398B85CA584EEF7779AFD34A8F26A7965E99E26BB324F0ABEF4B2FB11507
      FD1EC91F44F58559C4C9BA1A642A4DF7984C0ACCE30A6E26BE95CEE12E91EA5F
      E96222D69D4A338D05A26DA1E35348ACEF3E42A5AFBBF7CC3EEEB6B3CEFE1EBB
      7B704FBA6DF6DD3FA8101158C38AD1DA2E301D8A2FBF4ED504D160960335DA29
      715ED8DA37AC9AADA02847759AF9662C214BB4772D21BFF2C1762BA238C392AF
      29ACC4A7975E63A1D7D88C208251199ACC514447AA7B717A49E15E32A7A7011B
      85904A59BC0C3C9A46F7A2D973D33FDBC191C4C03946E08197F2756A03D6D706
      069B9A689FAF07BFFE248CBD6B886409A1F0B2D00D4F37F635A551BCB587E3CF
      B905AC15FC4A09DB85717C9D2F3906E32A69B50711F39A4E2EF9FE7CD5709B22
      044D12C39FA059CAA7E920399E132C91B5FF37A2526493232A10F96A196A8A21
      4084E97529E0E63142AED9DC2C9E7C5B211F783C5CD978E578BE11A555AD30F0
      AED57F28CE53449BF207DE66BC34512A721E61211237642E7C905444340B4D3D
      4420DA0F7418CF688FE913124AD611641F2D804496D8A75BE46116F03725E084
      6FE22F0972517B450A844F7B3534E0268C9A3E4EAB1706CB49AC614AC0CE5F98
      28B736837DF3D770E0C27C11A9B9D1483CEDFDE5E8ED4FEF6A6A6B4A5BF109B7
      597D0A280724DEFDD2241C674C3409337A3CC7EBF95A7D0A7CA32EC85418CEE3
      15BEA7556A32E4C59C7593D5CAB283AC78B0225E1C867A991A15CB272805334B
      E27C69E48A4FE25B9525C6380F5E9CB7C44C1383080E249B09A72C4D834CCD62
      8318AC863F61CD31D9196BAF917D4A620422840F1EABB12C559EB656471CC679
      E26C82DE046980F3FF87992450C049B0248BC7D7C9B54AB375111FA76B4E9753
      86B429997449B1DBB93159AA72E473945657AD73FEF633282A9CA13CB53E1402
      3A5741820C871A25C6D052EBB4BC6494EB2CAF25D9C35912FEB585CB1114AE58
      683C1C795607E96B3264D91F132D9EAA3DFA5E33CCFEDAC297828475B363681C
      279B535CF03E32CACB06A5A1088D545D49BBE6D58F936E5A50582488D4F07A9D
      048BD7A95A19BD84915A7EFD63F9C7CA6F0B4F5DEE845E2E8D861F0337ECC9B2
      FA9CA42C85548D1FE40B1BF0727714BDAC58724402E93AC63AFCA028ED06CF94
      47723C4B51BE98E050C2A088FE65BC8C3494D2FCF87AF9FCFA34D4B322299171
      340CBF83E285C3E818E3CE30A6DDE7CEF0FCC00F431C597E3D09DCD8143E1486
      FD2C9F5EB296DB7A8DBBB934C95BFABA89D8E2DEC8585D0D9EBC8B1D4AB43A0B
      382F8EA661E0C18A0FAF6B950BF73AA56C30946C2296CA5E0B4AA91B6571ADD8
      8DDAA68F5ABB2F70F24B0E45DECC11EDA60FD3998B13B3FF505081E24B0A6B21
      42602B5D5C446CCC6E6F7F274B3D271DE2E549826B0AE30FA70AAAD5DC661FC4
      D6288C78ED894220FB903EED17899022DE686EDD1CB32167D8923BBEB9E6649C
      3C9BC477BCB42B45B3903F890F9054DF309318854E77BAEF0C3D49E33CF1E0E2
      79702253CAD2D384EC9A201DAE71F271116D40DD391AC55000A8917BE10038A0
      16AC824F121226F2C2DC37BE9BACDFD64F35F5F7D6794DDD78619D556A3DCF82
      30ADA9BFA771D4D699BE9C402EB1D00FFF785BF7796ED695B6319E2051F932C5
      562CD43289E93B4F4EFA9CE4334A7F3D59447032D7D965B92FFD2BF898DA56BA
      9732AF456A98A4EFC4CC03C44AD91D93A7E168AB6619D142AC209919607C26EB
      CCD9BD1209BC9A230F4C33A629783A42B47C62CA009D7524C503DAB639262485
      C8B48B239BF5E12722DAB1D4097D14B960CAC692394AD9E7348B976ED3FFD998
      A52C1AD26A3EAE9018991C5FA129C2A2906827FBDA69A61D7DF74B98A01B021F
      37965E72A1296152A834ECED476C7FEA25C13253E696549C1F9B9DDE3531E27A
      16C9B32C409AEF567B5928AE3AEF53797424AC4C292F473B02DA456975909ADF
      6D24CF0AA7CA118F8CF1DDDEEE34B8550B1D44D6265516CF108672F9D37C62FF
      465B9C667182D8340E17C1E60296177E9E90FF058DA2C3202545FCF4D099D5C9
      D628638DB45CBB4A83C29C2F350D479E3981ADE63AF1BD18AA4AE26714089758
      356435343A9DB8DB8C118BEED658610EA6D7C1322D5E91C36CD855AC2404ABC5
      0D683BA92267A0F904532A6D1A649B72280DE3AC9245705D2FA04A39BA6C6383
      B4523617CE539228342B8F6E5B1D1E1EBA590CB829365B30D7914FA15CBB4788
      72C18A58051E670E8ABFB0C00C22DFDCC22DC189CB248F2269DCDD5E5F4E00AD
      3822851B597F478890D151BE143F0062904E412930C88C930FF1EBF1CE2A1D42
      65ADCBE0966C8CDB4D8F2945577139F92214B1C9551021D96C030311ECB55D5E
      1B06B885FE5492E83036954E12BD463E49DF068B7CB1213E39C2192332C3C1B4
      EDC0EA6E892F6D1503402CB388125D122761158F97873BF174E734D67E890183
      9DED7804C952ACC6EAC55AE5EC4D611990991A27A54058702A168E6360633BA4
      1B015FC9E2058023E17AB77B81280DD28232825D4DC19D03C7051D002F8C664B
      D9DEA516DC8C7144510EAF83A53A9805F050431F928254104E08C3D7C318D785
      86E54F380DF3394ACC0C12A7929A2ED4BC557E640F3F94C07C1452602DAF0A3E
      900026DABB460410DE769C5CBB3B861CF40D046268F3DB6CE3255C9100A0CD3C
      4E322FB7519E60C1D9E42420F4247B3D90FE24780B4F9A3612500F7E9C28796D
      DF85C2D8E587757A9D5A286D26C602DD28C72B7B1FD4B10CAA52588ECEB98D2D
      A55BD84789C4D15C453BEE301B911B9C24CC38F72D0BC78678B19FE40433E4C1
      1168A1D3B9000729D5235699248081EE8828D48BAC0B0C446460585957B7A994
      2324597670AC80DC943D572B8D5B90475910522AA030DDB6A22B1B1A9E26D762
      6B466C1BC42F382E4142196777898213E78B40461ED2A01B58A8D7A9EA87F96C
      B6E63F25061840C82F4DD0C68C2E3C2F33B43F57CCE001D006167B5B00572C50
      E32EB4F65111C0393C2A2D09D265A8DD8471CB06C01293E661967E50A7976F54
      439D5E5CA948DF2C4C3A57591268A49294F16745FE8CA178FC5AA18EFCD4D34B
      2337853F7362A26056C22139CA3E37142C5CE8659934F574F83CD9D10A3E3B86
      9080F8A09C66E0C169454CCB9BC333891382B36566B104C8807FEBECECC0F8F0
      3CE0AD6F8298F39AB0310092A2284C5D87011DCC340EB96A0873A6C4B1680237
      4DC661AFA9A18B297E1DBD72617F7106547DA2848CE3FB85190F80DDDB4C6850
      22FD1E4C7C12AFCAC404DD07C0D3FD00D0AD4CFE22E51F53B2206DA19520DEE9
      6388A64B666695C026DFC14E6D2A3FCEA9108B6D07311129621E44F44F56013A
      05941BC818FCADE778262038227D13CCF8282003575926C2E107C0462C35D5C2
      614621CC1AAC1B128638381C0A9005308B25AA1F10F83330B81DD50D9D553508
      BC3905123B977976391D481433550697886F2A40BCD10CD20DF5165BA9550672
      EF7F07DA9C7796D2C9546A18A15E8E1D605775D68CB61EA3C278465137AECEA2
      81CC2D791D7154FFC3247115ED8FED66AB83F5BCD31CEA3ACF62727E3018FD84
      11191388B8112BF745EC1B983B8B20258D1B272A8FA02BC8D2910FB1C6207F2C
      8F5E6436AC363F53FCA8263F0D0C422FBC5897915EF05FDDEA80BEF1F8D4649D
      614F2C1C32286BAA0E7DDE8C7CD2F256AD236BEE796659895C58043D638591BC
      A483488524A8D4C392921D73309BC7A9AB2D56EF7D50BDB53A23DC123D768670
      23C502121D90910D832C0D753A7F72B8BA2C0D51BC384FB7F29B61C8B371DB90
      B3CEA91A8F55BB396AAABABA4C663A02788E0CBBE0567D8E30270A93E0CD9E1F
      D331E89C0E30815F479DF39A6A75CECFE9A7D6F9A0A6AE7ACD367E1AD2E9EF27
      B0F7B3354780549D6C4031E9A6A480D297C09C9C9FAB3A0CA01B9364AA4D7220
      376A842045B12C19B45425AB8534AA2DC4B936AA77D91E296F29A6CEF3CFB165
      6D885456659047004A4AFEAF356A37550AA3F8DAAC5F60F88BE65557D5553FC9
      2304C8187F7A71D5EB16D197173C3683F650D5D5A720CA4AF39193F603ED0739
      498A2C8EA5DEFC05CE47EBD340358AF9F481A14F33751E7BACD7794374248A93
      10372F310DC4B52A4730151369C5B90F0A63B23943A0B64DB8A6ADC15C045285
      76FCEE1DAC8A5167F84E35D470D8A9A9D3CBB7F8CF7BAE4C1B9E1E394D5320FA
      5CD9568000822848E75CD8B175892C285323B9B1942FA3564F42664F5FC8C744
      E8E9E59BC6E9C5959BB974718562BEE096C3FD00564994338B8BAA1F75D669FD
      CCF9298B3965281B20B00801C5E408B08FC547843D44327C5335BFB81A769EE9
      65B1A9CEE8BB61EBF2BCD8375BA248E902F233D997FD1C05BFE746353D822455
      5D28143E114E30D430C3286021F7A402BD7CFEDBD1EF0C7E46E571BE5003AA29
      5CE4294534ADD547C8C0694035A09335D71BBE842E697DAAA9616B705E53CD5E
      EF528403D45C8DC37C2F34F045F79494984DFC0FE770F552D53F1900194CA715
      890CD2FA5228F96C77EB6D0362C3D9178959DD2F621F28005800C106F8580AE7
      C82C0E12F9117167AAB37FFEB53CBD04F448D5D5B08261DA062C31D889336C2F
      3085B21AAF2EF6E266AD3044F8E14F0C374541317EFEE107C9A0516D70645621
      F405672205EDBB3D535BA2CB4912A7ED775514C3A2BCB930B26C85F307F56515
      A4469D7DA6E4A96F6E6D609BC1E7B5A2BA5487953269DA8CA2F662152073C135
      F299C5964B85482A627C7B39B6AB991F5F9527230C2E9ABD4AEA29097C2E0865
      1895241F8BDB19C59415DC2522F4CBE7E108C777A597EAF4F3F9393DF7049519
      74865A96CD07B153C24E7F871C78D8C3611BDE3DA99EC6210112D8137E8D3830
      97EF229476430046F18B296CCA1F93F89178CF94684FF309276CC840428AC966
      5AF9818414FFE10E52BCAC517787AE4FF3886A15444F96C9481D06B308010A8A
      2EE18046C5EFB4EF18CDF27D7566B26E2AF281ACB6F2678B7A9BE584B515A9C9
      5A5CE2498CFAC0C19B193017F1D4D2CABF29EA141A7A02688C4CF1D717D09D9B
      59101B2763CC0FF95F9218B4097484076DC1839B0892984BB16B1C82575A428D
      B8B335AB9E90072368C05621E5737147FCFCA5DDA435FF79D8FD07078981DC82
      00A369D2AEAD12809C7D8B7C768C99F9BE4A3D6DFD5AECF1E7AEC57C9DA2C68C
      AC5640C850CAC75583B237DF9098DF212D2EBAA7A73B84FB4F8B70FF079BDD87
      FF1EC0BC942A99DE65BF4FE51101A94C3AFBE0A26043BE17DF188ABC2D749ADA
      DD2C4DF7474D29B946CF7F073E4701F313C03032C9079A6D711CF59AC81ED464
      7EDD2A32E33D93CE8773BD34005E0AD881520062823FFE267E90C2D458BDC885
      5E82E96C94E828854397F2DB9C0C47494013A60D33B7EC06FA042BC73EBDC0AA
      B280FCA46FE26BD58D704CF40744174926DA92269B02589AC8649275F6CD329B
      BFC83EA7D788C59A74FEC14A9D72619015DF4E2471C6F679343553F0B819A688
      B556B1FD0F11F8BCC481A24C1712C69228B21C3F905D5C20A2861DBA02EDF6B0
      60121252A0F403A720B55AE984498F98DA81021040EA10DF000183982C915441
      44547DF13201579F45CAF3662C62473601D01781264FD88AA44E74112CD3D788
      D3E81A9C9D0AEF51B1A47E2C081C047089EA82A890F0F1024D162C1DEB7998CE
      84CA44B9E401ABB54D555250AE1042A2BA07D65CE03FE41383DC2E10B48E19C7
      DE775336117009FE0EFE0D76831B96A021E70AD29A0079EC4FCCD983B5646387
      CBE8D39A2D5C631EBADA26ED545ABB834AC277CFFFF1564D13E7207D53CC1CB6
      1AF308FB50851020CC47FFAA6D541D22D5CAAE91E406C1F86563688173B59AF6
      556866DA5BD33D5A06B78643725A103EA7719EB4507F064746A7AA1780EC269E
      C268177CCA4233A2BDC0DF79F12C824FA755FBD7A3C3CD03E217E5EC7C0F52EF
      14BA6B175499DD3332C0D39ABA41B128DBC847ED422460C893E6311D7B67084B
      B8820081CD4005AA319920A4D3822976E660B17CC3A790D840B9108397A5B045
      82D49358027F1154132B442D6B147EC4672954FB82C2D52218268CDD08D72A04
      549451EF753602A7C18C1695102BB2682C12A4FA1CF741449401BAE376EBF240
      CE1E91DEF81545A907137DFC5C4AEDB69D2F1C451FAB0EBCA825B2B4CEC72248
      97E0EBF5E59D3902C5F2C1461A48FC3093EE4A5D99995481505E8268411DB703
      34A1DA56DE43DC21BDC112CC169CE0BA0451C0E5EB014C52061144B31CAE4921
      8E6D3DBBE0F9EE142C3891CEFEFE8CA4B3ED0AB92F4E4310E556D9FCEF078868
      9710E71EE98238AA50E41C9874492F6A634694176A4871A7445B0A7641CB70BC
      C525A12714AA99EB3CC45ACFF2502775735B283BCE469211217C8638CFF542EA
      508541A11BEB61304934D3B05CDB63C3B7AB12E813EFD6DC2E41251D477F2AAD
      6BB97EF5CD1594A277AECFF4D51EED098A8492809DE6FD9A08357CDA7E2B9E0A
      DA5D887A2092393F5754A75AB0EBC7E293E2584FC2DC2C13A4FB64B33C1DBDA6
      58BE145711C2D57E282DFFBC0BFDCFC3FB0FA6CA72B7D32CF0AED70DE11E40CA
      95E933C3AC5E427D6A5CA1DD148C535D87C20CC03F732E08B685E354EF1CC7BD
      BE49C2819999DBFD72B2D60DA61A1C2E75AFD91A8462223C2FA233E02F165440
      D97AC9B4DBAE9042BE188DA698E17516F9F68A143790020E25096133651B8C15
      4A9DF4262B1FF6F20BB65294C1CEC44D8BA72A0C26BE992205D508FF78DBB8BD
      FD04A90C599C4FE480ED1E89E73BCB17B551542F955756ED416D8F3AFDD39A1A
      0D9A7D0109F7FA231BCFFDA83A115D53B0042566A5135F42D614B4DF0CD7EF03
      F19216659308DE3628DA6F79DC76BEEAA78931A106BA8B0761865E7B4863C68A
      C899163BCE4459BD7DDE2A6A1E2C69E40E1138A6B5C5D2AD2643010C9E72307F
      3494E200AA95A297AE956811F8C8C36016713E4B242B606B7A09C1911870C708
      6BC99485098041751BF123C8AC33FD2785B064E2D5FA703AD1808FF0A4B8145C
      B02D4499548444543762BB3A88A3FDDAE605C1BB1C9C0C9B8D0358A8A5C2AA72
      BF268D6C65F435E0C3F76EC37390BFBAF0BD9EC493C9DA0B73B349FDDA32082C
      D636F964D3601224252DACF7430D60A785EE992C8903FF5EA258E23ED0D15267
      993369ECBDF5C3DF652CDF83F585BC6D779BE78DF6F9C9A0D13EBFFAA226898E
      BC799DBB3710285D0BA1E9065E244260E517648A041748F15F5FD1F7DC2CFA4E
      94E220B5E641E89F21DF653D68E6156084A7E502C51DECE92012A83095FCDDE5
      B77CEAD0BF9D5EBEFD8A6E0FAF331B8EFCF54BA7B749EF204CD61C52498C70A2
      800AB590AC9246C17A40B4FB6A99274B57E6696C5A9B00C02739E0D2C62F538F
      18E8739773427198AA3DA97947C9BB2343CA0065CA4A23EB245C5740D65B1E0E
      8B2FBEA2ACCA1EE161394C09021B4C89BE97EE4B692CA5336D465C6A331606A5
      9F4E93EB82ED8CCC6D7FFA49A7FF30493C12BACC38D95C96D16AC242B86DA6CE
      EB3EE89C5DA841BB39E27C9390880140A3C36BC5FF646439416528960D9EDD75
      C955EB7610479DE1DBAF3405C04E29DFE9EAE9E3596FF859E7264D1B6754469F
      D4491EB20240F5C1C4702E1B4A9A5930F16204F32F4A0114CA765F9ADFFA419B
      FE1B5ED19F94167FC065DB7438C41CAD3A1C1F28A882AF08799FF08248BF9AA2
      10DB3E7092572B1CC987A87EB6A483DA5812CE9E54BE67A80E01E3BAA90C729C
      379C22E28986B44735D983DE911087715381454CF1BE7B674B2B55B8E8146BCA
      60550325012448908A0B47C5CC8C7A5FE69390907932DE6B1B804A958F25CF59
      D0D42DD541C1CE4A6C3538C83F53212DC5621D8F811CBA2A6935D9D94959B14D
      BE7F5DC4C4F1BB63827CD7D4DBC39FDE31108737F1F8DDDBADE5C3ED033BBA73
      30545A81088778836AA937A12A1B3AECF73C40589192EB50E8D683455D114315
      B8A2A238A83AE45F72E4461E005550E70AA582CC9C0F292AF0362354569B4B5D
      5E31C13DA600A08600CC634AC45B33570E98B6240A7181F0FC8D934C8CA1773D
      F78F55371D9755EE92DD1CB45AA259EEE2A0616244B04A27329AD96C9F253FA8
      72315361A1E568B7E2EE3B5858EF4609BE2B1FFE1D097A66ED12475E52F377AB
      AED07F0BF238CCAA854605455C937A69914345AC1B7B7FF9F1F8A79AFACB8FEF
      8E1C51866665631E1FC0D248490A4C8C799F3928823171A1D13F002CCF5C9568
      7C4ABBD4E46B54F9B1FD515C9975FDF75C874CEA02C15EAF72D87DAC0C0A07F1
      9B43BEFA8D301B5F69EC579B831754969A621FC6995FF413E8D7B0E052B14B83
      482DF3064765165BB38025789C6454FF3C373749E93F081562A51AD90F12F6C8
      9DCBD0EC33092E4ECFB5C92D73303B50AF368FD6DE5B80C24F3FA8A34380C33F
      A8A3FD57B0D6E34C87AA51702C72489C8FA96A14A57EBBD109160583B6DF04FD
      F6B525E2B6E181D76A192FF3659DB8413991B777F75C3F7E971F8EEA3E9A92A0
      FBF58CF7BC88DD6DE4D5A5DEE5B922848F450585880E22B85E462829F2269B3B
      895D1D657EC5CD68A265D1AE441D37149A5E2E43E49A6126134412ED8BB224BE
      7667B8EB80338F8A63A46002D428E59A905983A08AC5BA950039B1269FCEFD7B
      E9DC7C02B82C29AEA95B8104D321D11E66F13042E6590E23643BC0F24531B4D5
      F05831325310FC2340C516EB1139A8920605610915AB59CB09DC11E63B7163DF
      5115256D4CBA9941B5C962A109A5409B9C33492273DB14E24DCA1998E010829A
      8C07AADFDF2359F8FADD2D3DEE0289B7FD8F255AB6F27C90A3134239880AF8FB
      CBBC223C6F7084C16BB6CC21652C940F6E64561C270FA2659EE176BDEEAD7BB1
      0F5FE5F506E9BC17C31A2CFFCA9FD89E3887E99E55CC4922B38E1AD84A1644C8
      352A580E8BEE210D5F448AA44DC1CB2CF1794C1C25E0DBAC34C2D8B2AB375B50
      BCC83CE4C26CC45E70214BFB958C79727F99EB990D0A7219EEB81CF3C024400B
      08E7C296DF513ABD1D44A03DD30C43FB72ADF36E091B06EE96607C64E71BFE70
      F197682D8200DBFA228BF2979F7EFCB1340E0AA988AAEADF73ECD304B4FF549F
      2BD6D386C545EFCE2415ECB531E1CE0B4DF5DD21DB82C37930A505021D17AF72
      BBDB8647078E9265122F9652CB283474104711783599AB9DC200A05E5F565375
      2F34EBA3C3E3E3C209E715A43A7DA67D2F0EC2998910E032C3CE2F1FEC361CA0
      44F68566F5F6DD8F0A54D562B193B150170A059FF0E0E42D70EECD57FF42B917
      9D51FC19C475F9843EFD22D31B3063A31AF5CC22E608D5A8E053A08388A12739
      A8E77C0A44D5053FCD122F557B9CE75427A808C07D440117F36DDA0490D04232
      6BCCC0CC3AB76824733D0183F63EC08B6842C53340AD3CB845B8B673345C47F4
      EBA730363C39602CE95653C9B4D640EE2AED698B7CEB5940017C6B3D50045F52
      C0154844637E0F54FEFFC8FA795BB02EF5F336BA40E1C13DA92B6D009CD5B096
      4063787AB463CD737FD05375EE79E59B29BCB508192E224DE7C6721CD879B109
      34FBED4A517C9F49739A8806E2ED9933355627714C7A71EFCE145C873FBBC0F0
      942890F7E7DE8269A68E991457AD269F23C07EF68EF79FFDFD29A8C034399807
      556ED97D98B6A4D302336BF8D3CE2D61F94E9378710212AC81993EFB84904CC4
      4CBA1797BD46F7E2B279CF749C1F5CC952D601FB2C5393DA874085E89172254A
      726F242C9FE90587AD0E6D393141D499D9AB3FA75AB544CF680616A84D71675B
      640D319BE8C88F17B688ED9926B49A54C816B0F2E9E50A2E461D91468495681E
      80BD5BFB023FF367961A1060717B2E5079B7B751752C396BC71267F01E275C22
      C76602E362026B47E70C7B75333E3BC3B352BA91CCE1A8005AF132B6D356DC4A
      1A7EB1708C470D2F3F5F30E9477BD8B2C7796023DF4264C6B1662C610D68178E
      075AFE4139089B3BEEA8D690961B8F5507371D928792B69FE23C41C261683235
      0D6330E40633EEE5A48E9FEDA475DBE79D42B38CC78A40CF7413C9C615A19BC5
      EA1C5494F716B03FC30A50E53C56603A25CEF652D5FD4290856146556EF0978F
      EB90C08CBCC28DABCABA7DF74AD5F15835C97A492BC5CEE8E63D42AAD8FA431F
      0962CD22A80C855827891D221DAA3C9A0621AC2E3688F8181BB432AD53D8C742
      2A08674E25E6454E6B886EA7AAA7234D6FF74CBBFCA9DD872E13A3E5D91EDB6F
      B668DBFAC3F6A8424F9182F310083F24983990089C9100C6D47FFC4D1D1D1F97
      BC35DC86B1B0AC1E3433BEAFEAEF710E3047B141143B75F526416D1EBA769190
      1D0ECE4EF867A7877E197D227BA715C67989D912D606A217B0A784E47DAAFE72
      FC53FD2F6F8ED45EEF70F46BE302FFB93C1CFDBAFF527E8600D8CE87AD41E31C
      328A7A7E8844E6D564695D4781000E155DC9BBA63F5056AE0AB153E9D9C34BE3
      4F87941C3E0521EB459C59F1ED38C0B98EFC735E6094AD53E57E13D9050A27C2
      A5898719E54F90BCB0A796424225E7A4F59B9C79CAF162A3D5A41DDC9CB60DDA
      1AE8D4CD65105B0615A676ABCA1AE342793E9B28A071CECFDA5D1844153A8572
      243A212F1582250F4106BAD149C08D7CC841B7EFBCC7D134CE66912767E40B4B
      8038FD3C716C5E296C9789F1F3C8D760889AF4E37410678DD5045A8C7F287401
      B27EFA264E10695C4DAE8CF7863FE0BEECE8AA5CA9FA872A594D0A7095103FC6
      F85DD1B5278BD524311A410D94E5D67DB3047B61E4ADB9EFE29385292EBCDBA6
      0D47FF45526F386A8BEEE0F6723A8433B3ABD97C25870011F451DC25A18131CC
      2DE8FCB0508D926EAE2AB5FE1C3E27B13028C27CF9A682C92A50C14468BA7D5D
      3C47FBAAF36B1FFC721C042F6C0E806CA84A84C9F9DD0E7FAB35AA986BF62A56
      FC728A4C6D08D2397A13E6E43FAB09B1617CD7BA3B534B9D5C5EFE5CF12F8855
      9DCC5D9ADD102DDEF091C679F7EC5329C176599D6DBBB60E23731691129B06B7
      6EE181E6C68A6FC4827068DCF20F78E57BDC00223FC439397AA7F6CE83C8E864
      9F2CBA3B05FD3B857ABE5077E596F4FABA3261EC0544C0B47D66992812AEC947
      361E57847EB45DC21E88536DE838B7C424993D4CF75100A4EA052E8EE800A54D
      C2D04B50AC8C586A16AB8BCB8B8E4D0BB47E968C4ECACF03302E31E1BA54C2FB
      CF69337DE934FB88185039076700161343B9F02FDCDD90092411ACE6002A71A9
      311AB8A69689B909E23C0DD7B64056AE2C71D71CDDE1AEA902E6BF8BB8CBED2E
      5FB4877460393A26D4EBD620239A185185140FC74E3083CF1ED7CD57921E960F
      69DF3D68311EAB114F64388FF3D02F4166B470F6C47CCFAAB89FD5AEF099B689
      37E272AA4E057FCB576983C28BE368B8D017CDDE3B3A0417CD9EDBB8ABC9E5C9
      683830BF4BD0A2CB65C60DCBA8CA2E1256BC2429A59CFE65EFB2FDFD546FB055
      DDEEF265AB27AB8194580D93B5BE434320F13834720FD84FA5A40825A612E0A0
      90C447BE9DE1A979E2860AE95E5C90F8BBD00BA24DA764050240F887C9C83CA2
      35930055B16E1CFB45FB1098798117D084BF63091D8F16D60CAB602BCC0A36A4
      F5D26D05CEBF59CCF60059DC47868364714E8D1FCB343DE1CAEFB8A6FB1FEE9F
      DEFB634CEFFD71757A26F2753A2FF02892AFFD40C574652DDD5E4B2F966A1464
      A1D9FF289DB4A46F4BFFFCBF066A4FA2B305AA6D5F217208701B02CB542D1DA7
      64F4359258AC742EB9FBC888CA7B18F4CA66654EAF33E05A3FB5F76BBF356AB4
      2EDB67FBB5B21650ED752ECE7B8DCEC5F908FF19EED7B851E8E72BB5D7FCFCF9
      6ABFA6FAF3751A78A91AAE234FEDF53F0D47FB7C41DABDB31191DCE5E9AE936C
      96B47A93101D5190D84F6BEA1F239366A779E4897417F880450A4932EC9EADFF
      A89AAD932122856FD55FF9DA5EF45BFFE48EA7E757E75DB684A5F8D0F99C7873
      1D8686DA99AD97989EF06335020FFE17FF8ED6AA33A4B59A9571453715D8BF3A
      B11E7ED18395002CF8E749ECAF89085764947BDEF1AA3BEC72D3DC497331094C
      94B5E2104526A4493F16A5A114470DA269FCE0A5DD893989F456C13569AB4F3F
      CADD00DBBE597137AE3CBA8EE2D5779421BA6A924A99AA854D56CB553F564B55
      D37C52B7D00F4D46D81EBA2FA0983B0CED94F73F6EAA67A94379F7A3DBFCEE54
      D6DED9994A91E4668DE57DC0AB0F92822BBC5550172C4D722DE0576A6FC3B16E
      FAB9F06571F86BEAE46CD844516C70634649309B990415568D93B3E12F405B67
      EBCFCB59A27D4ED13337648D083E7053882B937870A8402CACB4232AE836C99B
      38851D860BED0C40B4BB74F6A5D3567B6789BE819BF305A2D924E2CA5171184B
      90511B1F1B0102A4DA7A81C9563F53D0A14AE91C51E1038C604824DC19802A73
      8B47ED132AD0A03A5EA32C3DF60E0818E89EE6646960EF2E45ECEA1C7E070A3D
      BA6E10F43D5BAB2CB0048C65A0C452FEA16CBC9EC461D800E3077D48BE56CF8B
      4D4CB3F48542D2D6ADEE0F3E2379C7C13C1896BFE43ACAF285EAA429F585B227
      AA15A74FAB282BEE8363A69C6511DD896221AC5E8037CB155654309D6ED67FD4
      A8468CD073952AB409B25F3EAA87AC0F59AD79DAC36FFE3EBCBC2074B2ED4981
      141D1117BFD0EA8F3A839E6A261940CD0BD465894D5CDCCD7AA5555810F9C445
      B4373249A223D54C16DAD756B01D1DEDFF4930772A98B42CE094E903902FAC53
      2528C713487F957D55F94375E150EF910750C9CA73E78F1D746BD59686823830
      E9420A86449BE3B7CE111D76F6CE0C3AFC105E3889118406E2CB5290C1EDAB14
      40527F2D9AC09F44B78B296E912D0843C98D49D0EA5B78171AF28F7384444BDC
      F1C264F318D66CD3F7FB1AF5FB82C54E6B148C4118190F6DA0C5F528C63F6B95
      7EF77B0F73EFF2C7A4147A6B86FC208495699F1293E589142A3049ABBC83D803
      CCF18C10CB0B253FEC317A808FA2C886F064B98255C9C7F6F699D396D096F5D4
      003A421D5CEDD7A5C06BA38332D1A4BDC8AB746E5156AFBAAB4987531707B2A1
      41341BE613A9F0229DBB9A1076F180FE8B14FDC9BA630F46E3D4BD55A60555AE
      2617C44016FC616C532A6CB9C02CEDE86726A37FE04F6E1A19D85C66CDEB4A63
      E93F286082DD699C42988265B148EE7CE412B32261A5828D2C8FEDBA8B669FC2
      4A03C0CCDD93B72BCF749113E6743FF79B15C2134A0E0736D3544F97C60BA681
      27C4D7DC5D79EF681FFD11E7F509E145EFE74379F659E3AAD840B26FBC10A7BD
      583522B9B54063264A1795CBEF872F35FBDD4AD3C93D2A726EF6BB074BFD5296
      CE6F02D11540C8D772E5632C73118B9113C9F9625E64A05116E289A41F8B7E91
      6A12C7D7F580ECD412D622F473E8A271AA3D736622751005D30AC805EA3A31D8
      4D4090C4EB6EB4E63AC187CB561B5CCDE899E2394032D2DF3FC290212E0E928C
      8366ABA30ECCCC363000811ACDE2A3EAEBE51A16195FBC4A35823357CA6F9F23
      DF844618CA6DB96EA1ECD3AFEC46E7F229BFDA28248BD53FD4DF54FDCDE1E1E1
      61C12BC82C7CCC10601B3ACA8E50DD67A2F6FEC7D1DBFD92AC345E52BCC7D4E3
      695D3E7FC74D7919B26A9B6C8C0B08CED1C14F07C78E375F3CDC6A175DD48390
      4BFB4DD62112DEF7310F7D2CAAD985227968E024C1EE3249A043425E1134AF1C
      B64E3952AE8FFB5814CB58EB015C3CBE0E613B5789912453402D82E8600FC3D8
      32800DE5AB54F094D6543F09E204BE503C65AAA298505D2761EC81835530720F
      FF45EC177769552DC62C79982C01A7F0775A22CB2AA1E8C646B8DE980D1A70E6
      1C21D66F2133970E6974F53F52036D2A111C823328516D43043112D7A426BF39
      58FB1B9645A72445675893DD4182D2F1E689B617421CB5777870F0E668BF2C47
      940C8F05DDA04F5EF918328A4CF64F58FDA1905300299B4791313EFA4041E437
      3D0FED7A601B938207856650EC6832447F6948815DD770C41C595F695B5F0DE0
      1BBDA2977BD5CBB9CC4D7EC72042C055F073AD5286B38656D1D20281DA4FB38B
      C5C585E0F571D431DB64F65F6189696A662924F3F572B71AC468CFDB623790C0
      CFB5A25CA88EB3B05433F63DD635F5CFC3C63F8F489F2CE26439A70ABC10AA98
      A22238C8CCC25EF71058543A5CCE75E3537B502BFABC0D3F35DB9DC13F2F2E91
      A81E752FCECA3F896A6C3C7127F9D2500FCE44CFFC380C7181512A7AAB9A8468
      DEFB5780830A07DA6D3D816359C06E6B46014BB7F46B51DD44CB205D629025A4
      A2A1836B3756A3DFEE6395FFAA3E41614230151CD1207967CEEF92F78586CF80
      6926278019C10BE1BCD37C06E5CAC2120DA2ECABA07B30962720118442BCE213
      A46827F3EB1EC225D0AAE5971D4DA72DEAFFAF6C6ED375C12999405817E262A2
      2B812E7465BD0E22CAD6948CF8AE32A0A0D9FFAABACCEFBEF343AFB86B0105E2
      551F6B144433162E1AE9AFA5A9930692E271325AAE83A55C3096312C00D19DBA
      90B04164D16CB8A28ED2245EAE6DDC612D1AD1EE3E910021F55EB47EB0DCE505
      25A771DCED81819445A3E2322A9FDA1539A14412E06F510A7D2EB80DC773E5FB
      EA2238BF6C5FC4BEF9AA5A7320E30B92FA8B600003E3FCB25DF4C2B808181322
      BF731BD55EF1C262FA2A3C14523B0E4B08B2B3CC9E7132D12DC00AEBC883245F
      A7A86A2F2E86A863C6D778EB3AA9558925C336E80DDB2C4768703E838F26D69E
      826FFC420C1169DD5AAFA55392C5AA37FC64F4F2CF683B817DBF8F3EF683A55F
      66CAFC946998799F4AA3CC66263D049F3ECA57FA49CC796CFEA2AC2E8463AAA8
      A1A17C398B79647EE80EF1C07B896ECB44CDDE147FF773600A0AFE2247F3B5D2
      D98473F244FB5212EA4A473DFC89E8D0B890884C346175976847504C57D8E981
      F7760BB7880EB6ACF1643D9645CED27BDC8B17134AD493EBF6FAAFAFD55E855C
      DA26F9EF9AE3601F853B48F744AA4D17F0801A166144DCDB5374BAD969FAE932
      0CB26208FB320416FBC3A8BD3AFDFDC3853A3BD9078C2BF673A2338872303556
      7B59149563C46E86A03CE0B1308E773A62AC722AD5FB523E7E03AC1B7595A030
      748A29938400519E8DDEB9AD8CC9AAD60E972513858B07F1C89A4EEACA0B3A1A
      0AFD2F859F4C3AA393A0B34DEE49765F0EA4DE67C3CB80A68425973AB3C1D03A
      BCAEFFF19A5D132238A156E3440AB23DCDBDFA1F1FFE0883C9FF0CFF788BFF9F
      EE7F54F12228D187F429612F15661401C339A74B2876CEB1540AD609710F57E3
      2C1353E7708D631881C2E6BA688D8A8B05DA7D9F0C775A71DE35ADA63A4C0D75
      0191A6396AAF909EEEC9A03047AE0A713C3C5936D74AED42C3ECDEA160F98C1D
      0A4673302A2254662CCC83580AD34C464C4C68A8C800810C695DF0FEF0F0AF45
      EF02927847F48B9279F94F25F94730A10CD27849C0A27D9203BDF397A3E3F73F
      80464E116F02DA4D98C8A4694DFDE5E8CDFB9F08295889C082AF187F7AFBE6BD
      F28D811DBB440B17C42528ECA083D0B9ACA30742E79B8DD2348BA2105831FC97
      227F6BABD4C0CFDAA816143C5B59B8C453C9642E38DAC18D5BADB9AAABD3B3B3
      61E3F4ECACD9383D1B0D49B07047DB702DE2CDB119C8E5FB1F3E089716E41345
      534FBBC34F1604582E54ADC004617E08F7A419CB2431E1DC84BC4D557E401932
      5456847E16C91D104ECD6A13EE5D687954392D67B169B50A532438FEA4827B27
      441676FAC33DBDEE0A715263BCBAB27875341CF1F0C982F9DEE25D82C532896F
      28B5E3682C205CFC41687BEDC1A5EBFF8F20D4376AEFE887FA24B0A5C5F6B5A9
      03BB3A195A00D27FA8A33787E5BA6EB2CC3B16DB4B27497943BFA021B145AF65
      D3932F86FB4C41B6111DDDADAB35DA370989F6C8331FD470698C9F53173724FC
      E2A480FF0AFDD0B3F3D76F90CD6F02AD6837EE70DAD7D4CF791207599A47A64A
      6A2F38D7964E3DED077A83E59ECE37B26D3AAC70D537936CBE88D1227DC824F7
      5FA813084AB705F44F71D47F07813D4BFB3A2E36B54713A9CF948E85CD2CB4B7
      8E23406BA09ADDAA0CB46A8B97087A499B6F6AF9257A85C498652823327CB290
      7DE26BAF130B90A3F0641D05A892D55295C203E9AF4691B1A5E5CAB2D3210E65
      2834A6F1D611B3D5320B9BEBA2FC8045817D77B20652E212A20F3F76DB1B8628
      E2B8E4CC8829EF96E2FC067676A4AF99A2078697B9458291C9B185AB9E64D699
      C9B626EA34561FD9D1D7A71D757878F49A0EBDA508827B8A77FD8DFFF89502EF
      AF0F7FE44FBDFEEDF0C7AFAF9D86FC0C4443948DE24FE616676E96A04E868C9E
      70CDAD7529895F301A30BAD96967ABFBB35F143C662641388819C8C008956562
      1B91453F250EE1C06A295EFB45EC13DDC5B34DE31C9D057B30EFFD245EFA80E7
      52FC595CC3AA672DC53B161D8F538FB90748B039C3A1EE9B53B65E02A90042D0
      4CC3AF03FD1EF7E07D963128500802162AE2CFE24A9DB854F2EF65C69B477216
      A8C12EC300517B45BC37D93CCE537C8B7AB553760633AE905BBA020BC86AC47F
      065FAD4DCEA4CAB8D814C40FD2145D2108CA11E990D315D4DDBC646C17876387
      390CBEAA5FF2C0BB46A901131CF2E6F0E16007F7737BF07A23257F27ED7E29C9
      75E892CC39708D9A81AFDB54001BA5ABF048694BCBB89E9700AF5955B574ABE7
      2624B659695718642ACE5D13749BB5DC5F01F780103C10C627E24C0A81C4241A
      25C649914843299A6652D4B21A8D44AB7CE7D9E653B66D390092C9D625948BD7
      B9355E6E83B6F4EB926F67984FEA82EE22681341749EA333C593DF68787AF455
      800A1B49F7933037FD67F511362E1E37A7213E4B6A0D32316819AB3AC33E2E5A
      39E44EE1C222C049B5647D9DB985BF39C250A79AA05281011D5BE5E1254E5B61
      116576494B890FDFE12EBAF4BB47F77DD5B6EE54E35395A794C3515783CEF0DC
      528D56B7927E1DF91B05D33B4DA5CF427AB323C606ED70B449D9EAB68BE2AC7C
      DB517932483DF6F2E2F27E805296C64CC3CA6AD19D25738BAA1155DB2402E6F8
      3F9F2D5152986083608E1E5BDFBF49BE3134D96E3782E8EB88BC8BCF25E07171
      842E9344D24C9CE1356A25BC1389C0F630854C6DD8F722761AE0F7CE0DD5A037
      46895877AB3978EAB86F2EECE882A48D0960D3869DB3DB4A6FA94A011C55F0C3
      E8F24AAA9C5D0AD29D6E8539CDAB6EE3A279C554883EE2F568E87B3F5754AD88
      8F4DA84088EB83D0421DF96E2E02708B090E47A3C606F142091A6870F107C7BC
      76E10669B6DB178DD6E5B965EC009AC5EFA28544D91CE939890FEBA09A4BCDB5
      313058D09E1371B317E60AB2BD26CB546375C03B559C2248524211BB953296A5
      1B6C60964C1CC4F7F8332A6888D9A23B3C6AB4BAC3E33F83506C353945FC4D0A
      2AAD7AA3BC0D376523641821164B38CC6E06C86A72B2CECCC688967193527559
      D1166E074F94898D64A52BE2D0F16117FA06D5292D444C2C354959B93287D111
      6D401F5CEBFFC8685D4D4EF3240A20C0A8FD1BEA0B78D4DD4827EDC3B5676648
      BC3EC7C3DA97277F672066BAE1A8EC74265BE12223280DEF1F0AEBE329AA0367
      4692A1400D393E1C418010389692BCE6C2ACCADF96A168440A0AB826E305A813
      B35080EE76964649A001F7B3C789EAC2E924B1A57A179AFD2823D11BA7D97C19
      9D76BA90C0155B8963F57F020157E7FC7C3CFEB5457AC62AB3CD6C4083B7BC8A
      D1ABB8BB144F76278E6C086BA49C815E1C65738203D03563C68DD6CF6E6AEDF2
      F3C5B6B1E496D019743AF2205B38227E2A912255AAC49E67E25F9AA3818C5711
      D2228FD98CE9DD9D875BB1D5E9F09335651E255FFBD6E11BB8330BF09BAE2643
      8A80DAB845C949F3EBF9E0FCE569C188FBAA388777B3775527B20B70566AD490
      1B3F9C230F5E7403A77AFE761C65E815B1FB61208ECB0D92D9BB73E3CC261CCD
      CEF9391197B95D9811719D4B1F0EF549A7A891C94066787ED9AE80E7C5AFC62F
      09C4EDE8D38E9AA3F158A89BE0BF6C36A28DA3128DED28563F0DCABAF04B7446
      DBE056450F36F8E58E0E99DC52F6EDF3658D822082B6B1257812D9423CC971FB
      895CB72E3D2F42EB41C2B5A1B702B72E1BAC05DD2E9001BB0C65C1E4715EE900
      63EB9DECFBED32405F92DB238056B246518F2DFD902A015E3F7E16AF11E38EC7
      FD9FDBA3F198C82F937C9915E476774F1EB11D2023F7F93E0A91EF1CB528D244
      FFE606A181BB688E54D8F922299082D1E5DA58421B6E5AB5C3047E2DEFD710C0
      C02C5647A456DC822A676D086C2953DD2A3CE5E0C22E4E2FD4514956477A899E
      893CB5A30DD0EFDDE3A5EFFAD48B36AEBEA5A4B968F69811D9062259169CE157
      72A88B526CD66B6EB6FEE5D5683C1EF63BED469737D54E80CC353BB81BACE7F3
      E0623CEEF163C9AAA1D8C9EE4BD5BA3CF9FB78DCE207138F242F48998BDF5A1A
      5783FED7610B27B328D8A64A77325C0F0F0ED10627CE677375747870E876993A
      839FC7E3D5A46F92EB92C793EAB9EE8B21388D01EA89F1B824A027D502202B52
      821BD441B4275B4416905AD2C376D7582351E814C7AB6263BAF7AD696C3EF35E
      AACFB5BBEE029557F9F4427A329565C95C4328FBDD4357186D3C16596D05F97D
      FD00B86F41BCC22E161F7FAE596CB40729DEBD5F34FE40C0828F459B48B769D8
      E71AAD256C2F166A542D9A3A33592B0916E60C1DC8CA46242FF4DE6726EB4653
      BD58DFC39F9C723F68AADF474AE6CE6CD125AA3ADB179A23F1B90F408E5708BB
      AA3F510AC362B576DEAFD3E16858F567286C92369A49823C7021D49FED8DD130
      693C1E9CB587A5023F46A28D6D284E098AF0278A30E185D7913A1F757E7DB283
      777AF9661773FD8EB5C737A4495D864A8BBD14B6BB8559E1838CC7777A3AC0D5
      DE60A9BD7F9497E21D471A693CEE5EB45AE54D969CFC0550E5D2B5DAF1E477FD
      D03423BD5075F58AFAC510C6EC15FB8F5CC6433D74266B4221BAA760406DDC90
      10829C38A99D42731A4B54BC43011C06283CD46366D04D2BCD6F74AAB801D84E
      A1B70E9CEED6333D1491601BD0A9985BE96346D64B3033F72CDCA0D9FA34A800
      AEC571F5D5DE5C2F972692F2A374A59704940115CCFE2ED10BBC3475BDD883BF
      8AB27450DA098A126D21A2200C6DF3D19DA828177AC9601ACB4070915F6B3446
      0C7D22EDDAC6496EA176BF9FEBD8ED945DF56D700FD629E2B985BDBA430EF6AA
      07C6C096CECC0CAD8AB8A128E51CDCED4490228EC7C38B76DB866DEF18D67F1E
      3F7473D0BB2409331EB79B3D6A7627B916A264847145BAB44CB3C0EB232DC2A9
      DFB72F4FC47C2F27AA80F677306C7F11373090D2F2D49DD9994450A53A848A91
      8ABA914A51CD8B90C5CE75E27336BE79D53DAD96A1D822E2E71DB6107A45A505
      3034DDAB4EA33F1AAAB27C74833EB5DA9CE6596753BDA8170F8CC861CA82BDDB
      399B7675614F4C4EBD19A806F56EA8E325E8776D6C67A2D3C0BB878CB75125E3
      75F3FD2B754695E75BA0549D2A530868462CBEC428E1A8BE3BDF2E59B2181742
      4EECBC77E7AD1192643D0DAE520977C2049910C53C07B240550E1953F49F770C
      885E14FDE1100F6A742EAF06953CAF307014705076512E9A3D8BE351F8C2784C
      0A96C04CE3F16FC75F798A8CC68D150263E371335BC4E992CA7FAF983826983D
      4348663C6E9EB72CFEAA9FC4447C0440376817E2292CF9C05A5CAE9835710425
      E64243195FFDDA3C3FABE063FF2466CE3BB4737541D9DADA2CA75288CD84160A
      58B74BAA4FE2F85AB58D30EEC50FC5DF9F300E52F2F69EBA3F44E883D4D0D3A1
      E114C12ECFA496C57EAC66C8E9041ED543849663091A836B4889A007E10B8083
      1700BB5169AFB417731A19572F61702025EFA8769D28F746CD91E32A0F7A4DC5
      D45198FA17835CA81A860130A3CE69E9DF366BFEBE3ABFADA5C6894C28952652
      E1435E075117A74C11F090C0DEED8090EC1E66EBD0089969BA0B8B512B4FB378
      21B79A88F640B2F0750B9B60B9C34880F217858D01A28993D43BEBC4DF884304
      10F53ED5A0A5D219D9A36A838951A8ECA762B52C06E8DA4E12F8F64ABB19B352
      2D036E5229EA779A8B4D8ED6B776A3BAECC5AAD08694FB644DA15DA86A898DDB
      A0EB3CC91B6A0E52FDD5DBD2E0FA37F13CBE6F1C1DFCC8C637B1AE140D6B5462
      991C7780C33E545C5C18BC6E6D574E0C08D83622CB1BD5CACC64E226B67A0148
      D98AC27DEBB2A1F00B8D6468A5B6EA9F9DC6C101AFF04E127BA5D383AC955BD4
      C7954F757A1EA3E37D154FD2987CB16F3DEF5B8700B61BB3307185549266A87A
      64AC2EB4FA520C261C40F721904F17126180CFF2497D079EE7BB9C874E6B59F0
      24321E87132F0DC6173C96D3FCC663797227434E37364E8616676489DA42449E
      E2C8E60779F0875DF5270E5770D2719904A354F7A48C6C02D6BAF63AD28BC0B3
      1FDCDF61B882442B8CC10464C88B3219953F425D3F1C07FDC6E389E40FB9B030
      D4B7B2366C5D513184504D82BD72BB68FFFB5EA0A0AFA44C9790C91248F59908
      579FE54472B7BB320071B98AFED9590419FA3EDDF4F4F29F74B4FE79AA1FA2FB
      7B923411C2A493E1AF8FC4009F24E7542F66179B89E78838768B28D6D95AA320
      0D15AB94E763875B7A1ADC82E0935210706A0A1AF1CAC96058681C2921CBEDEB
      10BA8D1AE4048ECDA64E835BDEDCA2B15EFDC1D7ABC825124B3BBEEF864A660E
      CA7F36C1D65A810816E570803DFD132BF4AC1497F5AD0BCE8CD232D2C675E7A3
      F964BBCBF2EB0C857A78271BB9CAC9F3555254FE36350F991E55569FED2860C9
      01E226692FE2CC7C20B6B194DCB282D23E9E4E03E60989E330650682B5D2E825
      385D732731523DDCD84E7B59AE439E629AC54C216798B9167FC73253AC5E38A9
      88E4975AD238CD1AF3ED9CF51A1D6A2987322F9A049A1F056409A179D4F71408
      573ACA31FBB723731548640BCCF26815F87E683EB1DB8B6A6FB07214983F02FF
      5E1BF5B90BA72D46C902BA292D974643A251E23574CBB34AA533D56D8520560C
      A6D9063A973A7D501489BB8F20D70E2F5162D46E83228BC48D1E5644C7A9D00D
      B8D18A43E1F327D79ACC911DCA866C492DBB2A9AC4483055AF2CA3B2FF8A32CA
      8C53DB01205968C957E21FE32A7E8E2283DA73047BFBB0FFB9B07060A6E9AB1D
      79A1CC6219273A0910FE91DE03109838C5C422C604074898369AAD4187E2B0CB
      620ABB3883C3CE2FBC64426C0109805A7D1CE6E729FE17427DAA526D9F9F0C1A
      5454280C035C57E68E7C146655F4CD0EE3953A98E67F943D92A8D75541FAB897
      CE8365F517E48F9E986C6E525F3B2652BAA772E139C7F0393589B886C7EA6FEA
      E8CD7111EED983D18AF65D6B853C93D9EA81FCE4A8FC65BB41118012C1F3402F
      1AA7C75FE9043D9DC52CC4A9B76D9E99AAD4DD3D6B5A92203C349B233A42714C
      2416D40AFFCAE6664D8AC38FBF477A3F95638BC811858F440C5E2273956F1781
      B10F6E12A364F072FA7E95F4CBE901C2DAB6A0900B9F1009BCB81DB4EDEE777B
      FF9AC43B34AA294D15A7AFDB7CA79B6EDA8457B8091ACBA3E696ECB6CC2F7B25
      899A2396054575BB3F06F02A50F7146CE16E8F619C600108077DB1231B34E11A
      1F9C8F13B36AFC9FDF4D53A71A88FFA1926A073BF02F476F8FDF21236673FE77
      8A37D38382E570A1D1C3D9D83AC12DAED5A79AC41BA431AD4107A014F1BC8B02
      47704BA6C818B1B91EF2B8D432C7C79F94A7A92B2470974CED44B1CE36915FF5
      B911C70EB3C3C400C81B8FD5AFA373200FACD7A353359A23F9A4CECD8D09771B
      83C0E418A3D93C836A2683DA5A035A9D7D464377CBFEA051BCE7CD492545F1AA
      DC1589699D99AC01582855B4321A138617D300E151C280E7386522151AE6D407
      0D2E6A5F23AC1D0D577A894AE77F1659758A1A6092C54D2348B9F3426D92347C
      E5CE9636A3ACD1D31B3115BD943EE45C9F8F1E91594C08BA1A9CE019EAE4386C
      51361B2A7E961A2E370FEFB7E6F9F9D74D4606D858B2F0251D43165BA62FDB62
      B4C0851D3CD7C05F88A408E2804A5E2C137E90D94342C148C9ACCC8DBA09501D
      1E27646ADCA0429249080888B1D3AC069D6683AA19C663EE585E5880746FCAD8
      0B77720451A2745BDB2CD25686CB3829846039891AAD9F779A1DFC3F2FD1E95C
      823CE4F51223A60D4BA3B97DA2BC7910FA8989DCC6FA0CB9C1CDB37C75796392
      906176B20E002ACF894610E58EDCFEC2D60FEE3020DF0B2194917B41DB9CC533
      34042A5A3231CA0707C202D9DCE2329641EA94AA6DC9D965BC0FB743044E0BBF
      2B5B9D123D6B18964CF5E91D8EFB83DD6602A6487043A729D18E518B44B4998A
      D5D9E0735FCD0DC7D582A860CCA4FA0ACD78AF2C8EA5B5315BFF688D07E83F42
      46BB4F8C3ACAE8547D49103FA9E405096487BB617C85E6B0A9DADDAA889E6E55
      142D150746D8CF24A9F8989BC287CD661F812122A6AD3B8FC295829C43380CFC
      819698A23802252D2BA946CABD690F0E378BAAE00EAFFB9F671F1DFDC9F69184
      C4889E5CAE2BE5B038B8C3A457745A0C872EACC04227CB5B475D5220AC1ACD7E
      974726E210AB4118B0659B109FAC058F9F01FE9355F87D6DA7D45D8C0C3E549D
      D3418FB474E772D0155406FC6D0444283C0BE4228DB5C350A5D1D26E8E8EC763
      6AF0A4240CCAC5340CBBE07E8D9C00A1A58F902373D691F70E2EAF43090025E6
      95827DC529390824B1059F6DD4E6786C1553DB7071054AFCD035984E1671D83C
      C3A0560B0EE2558A306BBE404D9B88614E8BD9593DBC0540BC9CF647D50AD203
      F5850EC60A52053C3A2B4DD052F4C50ED2504F489A827317C047889F00A88890
      4ABE35EAFEF8E61E38CB86E33FDF777AF355B02A1BAEACBB23F2958A04508248
      0176C6F19528CD749727B7CE2F472FF464388EE331A29AFF400907076EA9030F
      1A69D150D463DD262F1E62AEF81E7F9011E86072A13346BE610969DEDD1794E7
      C31DA4E7375B173B3FFFDECE1D2FB3E70F0FD57C8143F0EE2BB75D2EEBA5E12F
      F4748AE663A869717D89B75F55B77D6E2BFDFB0079532DC922975884B9F5C29C
      E0EDD56A768A4094EC9C54B16CF9737699CAC599A551EA8F06170FE1A7BFEFA1
      72DAA80B5CFFCBE0991E7A1FEC5BAD26B681261DE94FE723D7217096FAE7FF65
      CBE39AD898136C0CE9E55D2C8E1738A0AC6C2F4FFE0E21D5EA9EFEBC1944EA46
      1C11B5E857C40856CECB4F8355585547FD6EABC6B5E2140392AC0821B277D1E3
      5F06E76D7A1F2EADEAE01EA0E503925325EA899CEA2806AC011ABDAC74902CE7
      B399A8B3052355E14EE016CEB895F76A822001F6F1FB2B0C1EEE55B3E5FA7CC3
      34DED3063F7E505DA637FF9F1C7CFBA874C01FF8607B24C85FF6E9A325F3B8F2
      7484302015FF1676F64207D1378CED3B992471CAE579C41D4085CB1240E5BF16
      0F43AB086D9B650825AD6064180E41E10A7C07B7EE9B438BA3F0D0E0D166A788
      EAE08F3EFABFE29C9EB9405335587B08F93EFA8DCE2D1021DBB4CD9B9FB9D1C9
      637FA61D55C5967E7CECB389F194525B7BFAE8374ECC760F94FB87FF9BF43A41
      DA74EF35F3841F9874F17AFF9B13FAF0B7874E2B3DBBA6FEC721FFDFE9333CEB
      B57DD64E13ABBEE0D39F69A2EDB576899E2CFE7D3999A34355B72AEFF3561526
      1D785462A2EBCE549D9A893A56C787C7EF0AA4FCE1C1F1C1D1FBC3F78E24417F
      397A7B88F14BA1D8EC779F4B6697459B67A6420B7C6632A971103A0B8A0B535F
      C5C4A4710890B7F452A12C8846093E6B53B47374556BDB13246086208F387625
      765D0A81976D340295BE26051805619928062B04131A3D9B9A2B81584DDF92E5
      77A7963B730B10554C9BFAA0936CA717904012589111ABA3563DFC4AFE43AEFD
      378FC99B9F7EC4312DD232E3F12FEDCF7D09969051C07D688E0E8EDE1EBC7FEB
      3C0AFA6A3DECF9BACFFECDB79CF7E7F6DE29FBB019E49D6B5FBD2A2CE7572A91
      50096D1F95648AD2F4C8CC2D030A14C678A66C2CFAC41489A4D3E286B231F9A6
      28C9BA3C197654F1E75D86035388242756134B4446AF8C814214BC26C1C33D5D
      9EE888921F577110E131ECF84054A3572C794A591139D654A146BD26D1CBA1CD
      423684AD62C761857392A8D4F22541A0D14C83CF853B4CDD427BDF7E55A7E797
      948BEE9F76918BB6853A4C5AC98D00162AD8C55DDFCAE3CA4A3ED6FFC076FF75
      55A36F7E42784EFAE110F35D73D4BCB8DB04F5CF7013ACB6DBD3A2E7C836947F
      EF7F28DAD301765FF9CE8652BCF7BB1F954ED1F5C33EA27CD63D1E0456546891
      ACC53D85152EA984038002A7B9CD7C05D12C5561700D8A0B39EF52E8C23A5712
      EEDFB0BC1F555FDB7ED247A5AF21183FA8D190DE023F7C547A827B245FFEA026
      714C7CB57F53A324C77726435266D5BF9CA2D3F2FEF622DCAB2A4955616996E8
      E5ED5787AE89E2A4B88F684CE853D0C83F4DF13F61355E7C11B04FF70CFCD82E
      A4FC11FC04BD630FD52EB3A024EBC498089D1119B28C1D615A5CFB696B61491B
      CFEA60DCF9449E7FB0BB7D7FFD6FB3EFDFFCF8564C9A775F99D4C57FF1D401C5
      6CAAAD9687D7B0203CE13E727A66B77579B1F1CC2E4885C841A548BC86F8007E
      9858BDDD02F0A02AA59CD8780C8ADA2A1ECA9E198C2CC126CBBBE1BA31EFDF3F
      6E13EE60F751F0ACD4AC0543C8C892A36C12FAED32125386DB913628FA44689B
      72A9EEA02F4A79D8FA39DD29584B3A5768DC00F70E6F806206F2C639CC2C3985
      8BCB51A7C22D9B2F2B37689744E5B0FF7749F3DAAEDFDF64BE7FF283C7E353B0
      9815A6159C4DC0272CA9DD4EA15958EA079EE749B9C90EC41E65A8773CBE68F6
      DE6F3518C5EAECB2109D53B0DF6C10E75682EDD6B2DE65E67CFABF0CCF878D2F
      C3F3F6333C129C3FE33131FD94B63F001265FE67A7C0FD59F5B9DD6886B6242C
      CD767CB45C13FB68D4D0EDFED07F5C5E5668BB193158B40C9930DDC1335C9966
      8F48DAD9A1BA4BDE54238D0EDF87D19C45D797723EBBECF8E0F2EFC5E0D8E91D
      9C2C7E9BD353EC84ADB0C17505A50822483B3C15854AB6EF5559187863E681F7
      2C5240D8FFDB24C105384A0064000A0934FB1869D7938618750644BA46D54616
      6BA27A7AAD34C505BE81D1785AA218655C05052A77081EAD97F12E210C902A62
      4309299805FEBAFE104DF9D3A6D8ED9D0D1BBDE60839BCD2EE28F4D04E8FE6CC
      2029622B0A76945C5CCBD64F62D10E5CC7867ABC1CB5655362B3909C20F0DF91
      89F3345C53792D9DFC219A19AABF121E496ADC888A6077B3FE5FFF3EB3FEFD9B
      82C5A7623A4AD46657D311428E74DB7DBE02B241A9E52FAD91CB60AF0F1AF9EC
      7687680E97A708F0B6CE87FF188FAFBA43C46EACC885A9C884B182ED1A8F81F4
      B274DD9BED10454110EE1550E158BB02EF0B6D8F69B541027D9FA6773A43C1BF
      E90C496900A9B1DB7C49B27692C4D78613A5685D4EDE95B0F361D645EB40E743
      FB1086EDBE46B7DF2979D0C37B3CEEB0DC2D7A8AE661A83A51BE78B65822B50A
      DFF00638304B79F2A70513DD22983DB471C555E8DC228A41F8FDE07657D7EDCE
      05577531B0BEEF823B1DFDF9BFE9E8DB663C164D2E59A438510BE307F962A7C6
      D3D227511101A7851C80FF718A84DF34B8754B22B1087AFEDB033AD3F1F8BCD5
      697D2358FDD407C2403C33197031FD50AFB93F9EB85F9C8405FFF3A8DD2CE975
      1D950502ACCDAB5E1FA065B830057C112334AF7AACC76C0914733A58D4A6751A
      F039100DA7190AEDE229B37334AF7A6E9B44F90DDBE9036DE546E3F19733EA7D
      34846472EF4A2F718EE73F00A5DFC139E6D6C9D9C507D5D289BED111434576F0
      1DF8E96896C4B9F7DEE00B961F12F2776AF592A2620EC6388856DC8A18C8C6EE
      A67DC19EF54C684C33CBB4774DF3BE87C6F96087773933D9B98E66B99E999AEA
      A617E6366B85C1F25CA7C05F663598275137BA4C2EF3EC72DA8F572669268B38
      F9A45301DEE16BB81A26E9462726CD4EF220F45B7AB1AC516B96B41B756E97A8
      AD0C4091DE4D652F9A373A0811346327B49B7E463CBD1966AD3CB93123A9F7BB
      C358BDC3ABDE7D3B22605A733B12B7453C3F0234CF76623AAAA9F3E3EA2F8E6B
      EAFC4DF5176FDCD80A631F8C3CC4B28DB2CD823F3334D12C9BD302065315402F
      310717FD534B7B825DCE4717FC5B039D10818765FBC7D0D7BCFBE92E0F17B658
      C800A571AAA4F8335BEFFC503CB3A69A8B458C8ED9F982E4768DAA09E74673B7
      4EFBC34067E6F3524A5B2BBF6BA3786D65F4328EECC45CD9BA786ADC0E0AE27C
      D0BB747A4EA77F7A6C33735A79B82A2AA3BB1230CC1041051C38EA09B7C354AD
      C464B186A73AA3457E78FF02727EB8CC99C3E46AD4F955B8C3053A53A14FF663
      94C25BC32870AD172663E54A6243448025E1961D30DFDC127D626D6D52A5D0D8
      CDF3D6A7F1B8DD198ED4324E69A10E7618068D72249340754065CF554A2A6E65
      389C31C6156FDB7FAE100C3DB29F67E2F83608EB0006013AEF05A71E95630BA1
      0D4DA0D2BBC9A3C61C98D24E1EBC65A396A7562CCB4ADF138B0A4EE71AB9A1CA
      875240C71676CA704068EDE5BB3B21A29A17ED8D8089EDAC219193C6C04C357A
      E0D578069BCE103BC91C55E07525A226D77BFE0EA830929F3A0FD961486478B2
      51C153E1E7942B839F6E3D8AD8EE922C5CA1EA1D6BB925B45201CF73CF33A7A7
      89E7DDE026C2BE421487150522398EF9E44D67BB7A5F08A98AE830F18DD554EF
      537B54A300524D86A600D2B663EE2E20D82927179D3D736A00F305F2C1E2E95E
      0DAF83E855E965707A73A7A032955051DBB5D6A7014335AF8234C0B5262206DB
      751AE5F03B8D533CFE57D0DD7F2B72FB045506D8265BE844F4154404A6ECC53E
      C2882A8882DDC308B37F5F1496086D58DB9DF52FCF1A67FDCBD34A23D8382112
      0994B9AE2D1D82F350044D25885E859891644216DB186767197805991710DB4C
      F1448B766566DA428CA5ABA3C4CE414EFC205BCB1366863DA636D1C58C2CF107
      84BC29FA3688BC220AE18AD4DAC8C07C3B84FCED09BD01A49C01D605DCD55727
      6BCB4E01EB07D52DAB3912D8BFE781770DC815F14D62DF6CC9AFF3F847C556D9
      6E928877901D44709879BCBA9C4ED5CDD1C18FAEB8F9376F5E22962A5D1D07A3
      53BA6E7CDBFCD81324BAB9CD4AB1E6494A3D434F0805A2BA604187CE1261C085
      8D1D7D2902CEA994A84A9427441608521016399EA406863CF261CBC44C83DB46
      9A4FC106A47DBF217D71D09AD2A48E11FF7E12DFA0A179157847D948A2D0C75B
      5A449F58D23B6A94AFF6CA08E171D190F755D3F7E3487523DFDCBE2A78186C18
      6B6214718FE8C52498E530E874AA5E0940A9152F2641C41D8FF9FB3B5ADF1629
      CD3E53E9E0C1A8943B5BB06521EC96139C972E5D1C1143D20EDE04761709886E
      5B85717C9D2FC5AB87BC71BE432FE1683D72F1FFDEEDABF30B757135EC481710
      75F3EEE8C0B15542A10CB6466946731AE1E6E8E0CDC1D1B3BF433C8FA2F5591E
      643A5137EF0E0EDFEF30C299C92838D61C3443C8176F1E051E016019AB090819
      62336621E57D3522BA8FD11008A5F670C02220FBA9207AD0BBDCC55FB5D023CE
      759DA2094BC3725610B198B3EE7E07855020BA3F9054B537BC9902955522B141
      6138238615FE7B0A3AAA3B4828274369FA7443C91A0E6FD5C599133D8F4EBC39
      CAD637D9B734D3EA99DB2C012706451F6EDED3EF6E7E5427CD63CEEEFFDB1878
      DE1CBE7D0989303CFD4AD90055A700A374D8B5FD762BD90769285753EEE35CF6
      2E81FD84B8A4652638848A9008F5E61ACB0EFDC5E03A6E0567A29C3B06EC80AF
      29F5D8B07FD6B6FDF1E43DF523AFEABC51B652EBDDD580AF2EFF5B9D68EF1A87
      10C43EC373611D13DE700642926D028E301C594ACAA1E084E8E09C4DBEC3F79B
      379C5D9E8546FFA0C723F14F78F64F853979D16F29F4984B1ECFFF7EFB994705
      2ABC311C76588B5C4ED24C7B96263C8B55FBF27250A3E44D4D8D069D8EF360C5
      5E71015011F220CAEBF292393FFFC7CAF37106AF2E89491376B6781B44144099
      FAD9A440275788EB9C1DDC23DE1C1AF62E865B180F3D9863C440C6BF7777B5A4
      58F7CD57D464B1B722A77B7BFD9C3484FFEF73A50FC9698204B31C2BBD734ADE
      A0E82D09BC4C7D060BC708919682EF2F3309DA8C866A61A2DCBDE92E863FDE1A
      DE620F4F7FEDB70B7C47E4ABDEE7E1A8D11B8E4ECB7CB3F39888FF715C526AF9
      32A317EAAA7D8A94B62DB945CC8404271A77D0E1E2BE8F98A0285CE3EF54BC76
      FCD3DB4DE93530D2AFC2F27984689CBA0459972F96FECE62ED986B6D1FF1923F
      F7D5FF6B7D65E741DEDC91733674B211A66913D75D6ED45560564FBE03E57EF5
      79BF1E33912C1E97096BA99D2736786EE431613041AF03299BB05D279FB6F1CA
      0F44C39149450FAC70903D362DB2A551DC5CE9A4B9CC136F4E772C9B27713E93
      373D00AA1BFCAE49E6E55236C55F60048D24F6F97548DCA12447E621B4B03A0C
      CD0DFA913C36A7458C3A578F230C5EC1DAC9828A2200531DA00B8B0A91264666
      8F86A3942E913673764B8322C92E610D95E801D5208AAF6D93608CE09A0569B6
      559C7487EB81BA0F3D03F2C97BBA9C851153EE363C13A2A9505783C7A64A5161
      F6C4D92EC2D8359BF39415E158B53C8D069233FA4A0D7F1E76D4925DD42095F3
      0A3418BF840699312938B429A84CF1DF66B91FBFDFBAE92253048EC5E0B94AE6
      A061AFBFF37854AD7271F5E17EE9159915F2C0E488F33ABABFD94FF7BED9E574
      8ADAAA3646747DF48F87F73EDA822FD479ABD36F345B9DBEFB08C7D5116A64FF
      D95174E4A79E5E1AF787BFD9D45B1546E24DD3DB7D04F20783D4336128AE9474
      5986E5B5DB89FD5192075FC9CE207AB112C21647C25AB9C96EF1D3C1BB23F797
      F9415E466A593EB30B2639BBF423152A90EBB20B8B1C519C910B619FFF93AAFF
      87FAA45335F4F270C947768701C86BE06691768477B572108656151ABDA6FA1A
      498826D2AA695908E699C8A4964EEEF4AC4FEC7BEA3F555F7BD7F56EE4EE0693
      13DC6A5DAA5F098BFC1FAA15C7898F40ACF803988D34146BFDFC3A5537418A3E
      61A15E23E24277A5A6EC9368BBA8208EA4A5F3D6435AFD56BDE3BFB6CE5B542B
      DB393F77B6AEB6C407D7DA4962C0F1D2ED715F2CB6EFFD20C56DD85775955AFC
      0A228329562D66AB28DD5D1D4FBE431DDBC081D08D0D880CB454CB4495A143EA
      C37DC7257BD820BCFFB17B878747F5F7A7A7286847B34FEE55561455DF3760C1
      334E21516D8588E56B424BE083F747DF205383D91827D7A932B79AAC4A9C55CB
      F177FF5437FA0217C1439AC4D6148E0E0EB7AD84E3B7DBCB7DFC232F77171DC0
      90DA7E6CC24C6C5F6900BF49A854E9EA7C64CD5024AD524345C213B3F90959C0
      9A8A01615905D49109E627199E1323B160092924EB22B82999469899C07B27C8
      1F217CBDC1DAA9EDB2D164A71AADBC09D381252E96766BFBBFDFAA72BDD16FB7
      6C8D0538538011DF405D70EA07DE469C2CECE2E9954E5CDDEFE377D0B303BAF9
      DC59583AF3A98BCFE7E7E8F6C8DCE44527464B0D840C422B0916E62C0EFDAB20
      065F43A3FABB8D1F2EE20862C3B537DC5F8E8E7F80C4234AD34BD9628E23896F
      8CA43235F383BD006BFB579C86FF2A806978037BA7EAD1FFF7F6F0A71F9C99D3
      8E7F803A1F0E3BB8F93FBC654976473A3EAB0C26AE5B3B44504DFA11771A7071
      F017228BB9A763CC6D7FE5D2C4917A733C09B2679D961747D31011A234D3599E
      629111F62D4E2978DC3372FD0A42CB226FFBAC132163AE7F8E0AEE81F6039E4A
      B11C5474CAA828A265E5D2904A48FC1108AAE3842E6182D82B03B0C32796C568
      8B10AEF43A2D08B708FFCC4DC809E3ED368D29955A4EF0A23726C4F217CB52D6
      9B49A3C32D6420937279D4099A89DAD9BADE283C5347073F1EFCF8C6F1CE3C30
      BDD16A02872794CEB59F084A93D85394510FA67AAAA7E63907A5365415B0895A
      10B21B23CACE549AE7DC39E0BCA391BE0966ECA865893148B43FE7145F6D377B
      7F85D3A55504840FB7498059625BD77024891B25F3ACE50F3559C7A24C2EC852
      134E9FACD39E233C7044D146DB02167C2406A447AC70D5E9311D3ECABC5AE40A
      011D046FE1AE4E0B178F9C520A697F8B3DE4094F65C055D1140E80F6C759639E
      AAF88B5AEBAF6AA5135A0B3D812967FB8312F132D133398FF4AE58930A8F0095
      E6EF1A9279F75321834D8CFC2DA3D9A995265241C4A4293AC14B0C6E17171834
      C3005D1B9E5F17B0B5DE1FB487189C981E2A12EFC937E0495670335AABCEB0C7
      1D72D1D815DDA9032F20064E73CBFFDEB7B4CA7C7F8B7E2ED660259ED74CFAEE
      96A62B22D2B8EB957C007923A946FC74B216676A01F0D884780AE90F04556653
      80C38EF627D24BAB24C83213E1EB056FB81893B68146D18F1476B4F56C3C8103
      4FD6EA9766EB409DEA2094DED13E80E36A6134D489344FE5D0B041A332B1E183
      5964DB6317863A7D3A28F521455D30CDA7DBDE7DEE9D4206BE75EE1EDBB0ED32
      54E1962A9E91965E1FB6922491F1DDFAB05ACE1BAA6F22FB6363B630617955B8
      87C996BE41F897126D8F14577C630260E8DE18D2F6A2AE1847CC16C8D3D33265
      FE1CF44E18166F419BF5CD2215A719C1942545060E7143CD7F0AFF8D3B4AD131
      01552130A37A5A9E3BB7690C4D562482EE4E87CEAB001AB102658B0EB486009B
      1D2E5E9C74DB6EA31766C8A3C397EDE42BE317D45DF360368714BD11443A3BDF
      EE9B5227E86E4F5F1B3BA1A54EF40267B02672AB485AA530EBD7715EE9978C9F
      8A76C9357E05C27D405A307C35B956DD1100FB95E32435629B17503A61DAC409
      2AFAA0512665EE68628078A4C529AA54EE6BE5F75890E30BABDAC7633208C04C
      4DB626EC0C89A8CDA906D03E538A41709F2E739B1596A22DF7A98842F24DB833
      5F1EC127808A8813BEE204DFE1EA1C9BFADE92186CAE964E9FC8D7492E0C7379
      646ED16A919668AE21DDB78E8453A44E7F3F40C1D19A383C7E5FE4A7479D612B
      0C1630187A315C9586EA233FAACEB99C947D13722AB5D4D461D541255F75FF9C
      6D33041D5A562613A085A30EB0AB13334D4C3A6772BDA2771BCDA54E447BCED8
      96E3B7C8DD9C9D9CF6AAADBC906EAA031F4D65A76A3837C6399AF2F68D359440
      71341E7FB96A0EC663660940A6226AF4346332FF5467A1322FC135A22A812CF8
      A2E7ABF3A3DFDA470BAFAFCFAD85EEF8C3BBDF95A75F95FB895DB6ED4B4AA66B
      B588232A07D0A132D32931BC4FC98E52E0F29FC7794290D585517B95EEEFFB35
      A54344C6280A8ADB216D3A2131EF349B07CEDE24905814842D3F1127698D9A34
      16315BC8FDC24CAC9A52C54B4107647372EAC8B9A3D6B85B80FD6D711BC3F449
      3259CE8D1044D149B246991CBC4A3D9D1E954A0AF636D782C97B9289303C3DC2
      B30ECCADF98EF0B79888DBAD5BB71F7067678FE5700C4C18A0F90FEC18469CA7
      07D9EDA366A94CB45665C9A6050C00C75E2E93584B6F6829BFA874FC11759BC6
      393AB4B2CD2F466ED1751634D0DC0BD91AF4252972394302021F3CF93DBB305E
      C9391D993443A8EB881A10143F1DAA0EA3371E7BF587BF8C05105D5A9C84569E
      66F1E2208802DBFC80F3037E902666A613488EC9DAAE278B676B495347013265
      EC2264B15D2BD895B45A4F3F27300FBA8B05EE135B08C5245FA75C827627E7BA
      BDEBC5F996B81715028528ADFCC8C1C105E22337E6409D05377049D00F3CF8C3
      D4D818C3CAFCF0B63E4147F032D7C4D707A69514A815FED8DD16B78F6DEF2902
      93F5110A8C8626DB2238DB7A93CB68F3E0E11E436650C50A45AEE3A99A807383
      C36F366D1354022AB49538FF39EEBA5980C341B6FF2D76EA9D3A3B11C4B0A09B
      302BFE5A861680240F8F0ED5228872E47DB968974A8D0F543304ABF76C6EC134
      304E530813E9C89EC42BD43450751AC93A3BF10001F419DBB5EC87A419D20D40
      36FB3781108FC32240791B5D2B38CE50D59C2A5579940138453145A97CB6E55A
      76108AE9C52C51FDA76FD1309FA408AB21B78E25CF978F5E354415D3F22BA1CE
      236F0E014273D31E0C9AFBF7463278D4FF3788F89C82B883AAB2E3A94A0D5850
      D2A75F9E9F0942D06103F6C41AB0A7A106652E372B054422A0C0C4E3463A83E5
      92601693F2CA0C77B4221E642FC9B3205AAB3D8BA943B86BB10C384FB36FDB5E
      D9B2BA8AA95E539A2C78B1FE0B1BDBE7B979F3380048AE243D0F7C748DA5EE57
      E4DB440661E21B78AC5267290DB668E33DBDE442762AE5E25960F403D5C5BDF7
      929C12CC590CB92091127C865A864C0C3C2B9119E676AEF314237D949C29AC54
      F19517388A794421B21B43918634050E9BAB31EFF6E17A4C1E700EF594EB0B6C
      7F9A9E5E2EF1BFAD3BFDD836F709756CD81ECB1685B2071B0AB38F96D2057AD9
      507BD71C7037B821088C89BB63CB6F179A4AD317852A0B12D209F5924A4F68F4
      24D33B0BE3890E6B748AEB4C65A1A9F6B2C8ABA752E5BF1118290C3C6C7F214B
      399E7E50B6E9207C5FB4792610D30912D4A74BAF7154FF4A358438C26EA1A51E
      401F38202833E45EB7E4240C4DA6F6BAFDF670DF3EDF2D3E427618C17500A6E1
      7FEC0198B64F7619FF8C9CD26EE3083993DAFBF9A2D9E3475356C4FEDE1EAEBD
      9F87C3DE6E4335FD7F692A0918467AA92EA82FFDDE45312C7E59D47FE2AF6A6F
      38BA68EFB88CD2F2999B1E13C1030D26BFB64DA0F7D0F7F8794692474A8754CE
      E355FB4EEF0D4F4783FB877AECEA0B3E2B557BFD9FBB17FBAA19C50B1D7EC3B0
      93643D474D36BE3FCE7F3C3E3AFE4F709F0940033D23708827EBCCD4A77152C7
      3FA806593ECB410F7AA13C5A8240DBE36C91043AEEC4391E7E19A2700D3CE29C
      E6B8CA1EFCED7DD50273FDE3EFD49DB26F6EA35812CAF689C0539D84B9592601
      9AC206CBB45E98771493E0CA976520A1D6A80C830B7CBCFA6142A768C2284AEE
      00821F4B3989ABBE233F39F2BF31746AC139ACEAAB6D26D9EAC29B5B31E99BF4
      3A8B9707AA152F19683337A9CD238AE3F0E870A9318BB4DA428DEC29523CDFA1
      6D123D23A2172CAC553D648F08A8070068C44B67DF88E2218C42140832A1AAE3
      544977B370C6F3A18E498F149DB9AC722805BB14C34BFC871225B68949628A6C
      10805BC373B156356244624D21E5897632FF3F716FDBDC3692640BFF155CCEBD
      8FA96992965FDAEE76CCF40D592FB6B625CB63C99ED9ED766C802428610C026C
      00B4ACD9D8FDED37CEC9CCAA02489114A5EE673FECB8291255A8D7CC93274FE6
      80E019E62BA669453695D6EAC4F555D5E57CC4D829DC3720AAB423C8B6A5FF32
      40A68632AB381E68D8E207F88DF64ADF9390614ADF5E52172836364E66E03FA1
      D29D63B1D1A71A1180815F256246BA13E7B964BF6759908EFF35910C54B9858B
      32BD64861049EAF542F2D5A2E39F64F11038287D662A8425E534EA04AD775EA1
      18BC7A3374FDC484A9DC30D189FB1A67E918B087DEB2765FF7A2FD9F451247C0
      8DBA2832AD420893569D95B8AA8A512A93344CEA6B4CB5720160A7D03CF6C139
      79D932C13A69F8D63276642DC753E21ED19E14B1C521D66BF1D10A18DBCEEC1E
      3365C241C0F20D9C14B8933C9726073CB12742B11EF685AD399B2531A58C6025
      0A4DEEB418BF761921E904702656CDAC00CE20CE6F8661A80B3B945812B674BD
      1208A74E4BD8941EF176A7E0C479368DBFD3C85B39F5C724570A4D8BCB27C501
      A33B5F41271C826A75C3289458244CB7AF710E214B2D1C34C6AC80D02B1E8974
      E81B0E10C226F98DCEB93C4ACE0383AEBC231E14C0F5E74CDF36B42E784EA71A
      ED26C081C02A7DC4BC605C24D7E65C7AB6BD8A1C32385D7375C4B21BFE4ADAE4
      845F737EA09E673B7E086F1F913BD9C9BC4CC469C978428ED2723417AFA61715
      9800CCD9EB0467F738E675C37ECC738C08D73D2003F575D32CEB9B33EBCFA9CD
      0FEBFD983862B477891D594754C95C81EC6046145E3B114F78D522F958A759FA
      2FDBCDB73F555385A2759891D9E2B379392B44B3C7FCF1C6F4A715C36CE20C8C
      8A791943082D3A00168090372016A534C49898A24E4751927F4DCB22A7628804
      2F476CBEF968BA68450CB42AC5FD11866E64558C921E188C88EE6182EBA4CC12
      C6F7A5DCE764928A9A1053F7656FA33FB68F1BCEABF87C3D856C6945CC85F694
      A5D354AAE0F4C4ADA12580EF32A9460545B8A8FCD9494F4754D800600CB364BA
      E8F9DF6E4B06782352DBDE0B04D296755F0CC52D77D2913837CC5204637AD1B8
      481C0D91B84A03DC841469639E2B78DBC134E33C03A0A77975863477C22E1F12
      C92E3B7844035E07488F13228FC1300CA3E58BDDF0E74D37195C0E7AD1E9D9D3
      9D9EB5299DEB4BC2EDB418BB154D80E06E766E9C21C53C29BF2A1625CCA210F3
      E0FD4C711D85265C8CDF37AAC3BDF224E7402610F001975060B038BBF997335A
      695B625539BBC6BD188232A9A411859B04C512F120036DF02859A5840030C44B
      F1946B6C3BB2FA044F1F9BE1A5CD29E38E7B34C05E0C6080E41D7097EB605FC5
      5945E59F349F242505000D3F8776A0C367A476A2D8887911FD368FB94BE2AA9A
      970C09183A158CB7254CC957C5BCD6739BEBDBE2C8366161D497EDEA95AF2FA7
      61681FB2E60A921B253460C510AEAE8AEBAA2E6633B9D6F29B28F9A69EC6D2A1
      0DCD0B9C279C6E802A559D4CA168E60746FAF9A88AB2E4321EC1CE1D27CC2277
      404AE94A9421151635F0E43C146E80BE07919E5470A2E65005F101022D88AF17
      1317736A3A2532160DFB3AC0CCF77F7EBA3E3DC39D2EE03A4927DD057B4DD61B
      18B4242B488C1F7A20B85FED98A94029BA81FA26F61C979FDF8FB20FE34A41E6
      52A9A9D79B63AA2738CC759F778F3D7B8926605A83B62A079A2246C5243AF6A0
      651B8B551016906CB5B3C67C57522CEC12E237B4A50977603E5A2C05B80FFDFA
      2ACEFBE938614E381B1A1BDADB73D11B61D7A753DCD2550B3ECBFCCBBEBA4364
      6EA211B13EBCFFB182667599C4D3957E7F830465A8A51D66F831040053A84192
      BB64ADA8CB14E380BB2C63D920A2B8F4DB3C89E679990070E20CA5799F879066
      A6F98754FA94519C63F10D4318C15108F5A8F2A3C20D59DD724C5549B3F33047
      6E50EC89DB7AD2ACD57401960DFC8C265ADB30557527D32713C88E8EB17694F6
      88770BE490DFFC22FB98E3A13EF94910E875B4CC1053764C43EE5E79182DEAE6
      C1EF7868F6A6E05DE77DEAF848395D61ED3860C05753D80EC68559A3579E3629
      8714BC207147181004E6BF80E8201628B903F7E17E41AD5FE6AA0540E97E0B1A
      1017B931AC6EC024FE969BCA8BF838AC825845BBBBDFF87FE091E182C453E413
      EFF556DEB515B75513BC1A9DBA838DD9C41B572D9503298E21BEFC726851C6C7
      437DBD053CD41CE1955B5414CE82936DF3F7B1643B077C1565642A698B95EB6E
      C9D4134286E03F061805CF818FCB986AF016C2287EA07E5B99DFB731C98F777D
      8D63E259B259606339708B3E9DD2094B3A806B5EB27DC110EFCAF54778E50874
      2602432022BA66EF607AE350B1F73DC51E7E2D9EEE7A2F47DFD05337C6CCA98E
      86C5B77022D8E759595CA588FE2B6C1BD23DEE0611F394AF42EF142E19C121FE
      D648E6EAB3C2E86459BC0559E78D4725AE7C855AFB0CAE112855BA6CD66A6D80
      75EA1C708F95FBF9151EEABC2E10C6568DC3F1787BF89CC31475A88D6DBDEE78
      19415948E407923C2C37ADCB6D8D79A6DE682440FC12A4300C33184F4579B3F9
      509E99FF2F63AADB6C8F6936F1B87F96B7888FADD17B9D48E6A88F2B3B40C198
      5678A01A1E60556537CD51EB4567D9F8342E2BF90F805935E41A881BF1A375C3
      6AB691CAE5F7718F0CA27F2FE67E18018051FA142EC01776CB5561B7A8AE1FE0
      BB3177F6E1884816F8289B8364835714D717C713671EC0D28A2A6C4BB62FC108
      15F2101FCF39B97CA28618421649921BB604647806B5C094442E200882EFD350
      C65725758A3AF555EDC319CE0D11A1F5E86D710D784F6EEC6B5C3E331E674017
      8A097A32F34430A44E5392BA4E6B7C500200C10EF57495EA3A851406D893EC1D
      65AC71C0023E5B22EEBE8477123203E9EC00B385873E175BF89FD844887568B9
      6A7C4EBF44F98E30357039A9AB948F6343C7C988330C48465C876D68836E2019
      00039FA7129E123D870A12D065654B6559790417F018CAB2203302EC12B9C864
      400DE0BBC3797861D2ABD1BF81C0E156F6E6B6E49381D4F75154EB5C9143F6CE
      719759999BF8EC2B2ED1D0E21572055C06839E319A87E7A71EF2D66542EACF30
      9980900BA318594F0E45E369CC9197ED4C2D741A0E536A32CAAAAFA22E7E85CE
      E9137648A99223BC8AEAEB02486B9DE6605C4B191F5CE7962A802381CE3BDCA8
      2C6943E8349B2BAC7B6C657A4262C41A5629BA76A852EE926DF0052106F1FD42
      520873103737AA9FCA5460B0C9C30C9CF1576416587297B37841D1615A7B8F25
      007A51528F063D8E20DC329676379F4940FED6E80528A6FCCDDD34CD886D036C
      C6D921DC3AC9E7308D46925D4AC735157F7B1A75039065FEA64CC7C2C0DB0982
      0C308F6030F006817FA7A74CA94321FD239B38AEEA5EBBF732F23427D8EB3011
      CE7B076EE30BF5594143F8D4BDE84B92D0E56487B1E6E4FD74660D5FC1B27F54
      4525D878E059B5B70287430C4BA4308C7B10014CEB24901FF7DC38615656516C
      F5C14C64A60751B3B8C41F5D88A8BA812F0EF748D8A70AF0CC73F2AFE0829537
      3641BE09DE821C4A748E4FAA5CC3BDE84A387A7C543A15B2214D0EDDC30D4992
      E5635A26AD55E323F6CA12237AA01D8D3090CB0661F33DF24CF6C8BE719C4737
      8A340DE70CE3BF8ADEF9B5211DD4BC6CB33BAB0840A510A42D2FC92771A3F3A8
      869094F4DE89388DE75CA48ABB0EC48D00ED3302F252467053A7D053205B3467
      20DB5BFD2CE27D7EDA8BE620432615897E32364044926952828EFA56E2351EE6
      0E0066829D8AFACE90C02257AEA0B2B74E8EDE60D4E333030203138497565EB9
      A243EFD91B52E106586C0C180B804C565CF2F211DE29A0B757B672AA5EC4A8B6
      C486E59ABFB5AFBDE0BA75477F5C352F456E3777195B1E42811CA68A9180A599
      A355A247B8E5D8F63454801713EEAE4B6D0830767D545A6AD03A3CDC99FD389D
      C535D3E658AC5292D0266542AEA63202EF40C21533E251051B271FAD8E92E451
      2629B1D2EBCA7B027257F4FE7FB74A02B5CE77C56AC948901A4C1D6998E4C944
      78146990B22082F1691D25719592776144D99B06FF40E38870D33C3B9FF82243
      A87A1F8A48A72EB159096C46494B7A10CB450FEA0B3A302B217A298178BA5FA2
      716967294F5825CA329A2186B106E8374EE4B15A4E07A6E3109D4A018B95FE6B
      F2E8AB29130B5EBEF0F341F45E6ACA105CC3712405411C6765F32E4260357A9F
      CA39CE23B78C2F1FE58F0ECA62E621E2775EDAE26299B4C5E25AE6CA2C66FD2C
      21A9A4CCE59EC4C76C92B9FAFCA37E2A99723BD44289663CA3EB1AB98FEF4DE8
      80CB473E85D0A8CA5AD8D302660F9C7F10005841C69971E4482793BA8FCB69D9
      1B71EBE12AE3D85B4C489EDF84A9C57C5A79CAC25BC5F15133CDA48C6570C718
      D5858CDD657D29B4B0981D4702AEF6032CD8C43010749794793F18033A56CAF4
      84948DE0F23DC1452C68C9DE3874952DFAF08CB09829492FA61C6BD26AC11377
      B4E21180CCE5198F2A0381158526E83B1005FF7E03846245198842B8D1400642
      8A8F55D8B1396830E0BDECAA126C900E4333076F845E6FBEEE4D14EDE58B4DB4
      01426DB8E0975E1040F33370F2202151B4B83033248059709A91155E2C3C96F3
      CB689C64752C72929296824A0C5F42F6A1FFA1A0B4383A55B65CD19D900E6069
      A87EAC8637418FEF986517BCEAB234BB49F1F2C5BA3C3B48B1DF9268D71A6215
      CE43F80F5BBB880E475FAAA48C25B90D0B3FCDE7BC111AFB33E8634BBD08C67F
      C4027A6EB9AAA58F8B9505DA749C375F361787E7CF5E45A74559E2A819BB85D1
      C5CE23B816ED5B50FC66657421C80C95A464584F752B6912CD455DD7DC8EE64E
      86248D66E0DBB37658E8A7B1F2EE9CE7A80A4C6BD68CEA8F49684A147D7A9A40
      E457921F31B79082B87BBF4EAA67DC187D1E7E6E4D8178806B01521780E17AAD
      15369A4B3CA62E38549884BB6574EE8D98D6A1EB490FAF033DE847AB8166F74E
      94EA0232EF58B9E3F42BCCFFAAC5E775273ECBB140C399062E5866F4389A605D
      0FE350A720EF5122076C50110112E8A212794377BABB90F2884EB71ED596A3F2
      C8F88D034CDAB04CC7974AF1BB8C672624CDD2705C859DAF6959CFE3ACE362BA
      9662CA35A9A7764FD277A5EE01D039360896A0C1DE0E2290066E7752564CD227
      E94AF40635E3A5238762331E482ACE4A8A604E34450658C715FDE16B18E90FC0
      2B381C206818BCF42F7F37111B61C57AB82B85E58A2BB94136BBD3E22E89D789
      ED6AF8951F4D790A8C1515B72234E17675515EC6B9EEBBC8F1FE805C14632484
      B8152288ECE66348193566631D9E9C38D202B69CABC9B73AC69673C4C0141CA7
      5FD3B11211CC29ED2E85AC76245E341D2674047435C4D207195CE635D7F41BD5
      FC7030779A87B3A6E82F1DF01654A1D5116073849DB3B923053345AA38C6DEEC
      4DF481933989479840B803A229509731708349515E0349D673D4E6578B25D1F8
      AC82970BFB948F45815291324DD9F08B20EC8EF006AC473DB9E0C70972FB5479
      C7019F14BA5C6A7BAE1213308904857E59608526A5643AE9F6A4E578110F375E
      50F624751B0EBFCD622926CAC7AE7470FCA1E08D77BE36A5EC94F1275106DF5B
      1E2B48571A78DBBAB8BC14DA7F05AB07BFF177CA2FDF7D8645F24BFF7354DD4C
      87205C4B7502571821F43ED8326E96850BE74B72332CB00E7CA185EFF0E07E83
      FC87FCB0022981E695539E5769C402713836255FD555BA5139B098D4527643D4
      30B1B01803C4FA9D25A595841EC695B841849944DD2BD174765320C49C5CC7C1
      7D63C6C2F2C573FB24BF9E675FA2339FAFCC736ABF2E33E4E1AD8BEB0CF1639F
      ECDC8BAE8A6C1C8D4980C772C763BE24009A19A6C764AAA7518C2D91DBDD234C
      009721F323C6FB4826DE00551A0737339792522593B984A45CE933F16FCC7D12
      2025F91623A065A9109C2A105D14D482411FCC099A3679011575599800644C04
      45B79BA1374951E7F7F8CF0A8097CF2A0A9F9F019898CF481EA3796E0B5C41EE
      CD27F3406BA5ABC4951C081F81770A0D7E03736F5FF153CB7A29432FB4E9DC43
      08C4AAB3F3F8F32B5EF27ED8B4506819BDD53406FB8DA3D80C4DE2D65EFC4C2A
      F786C6C5121040B8F57695BA5DA4FDEDB36626F7D2E60378A826953B52D7A52E
      E557441DE795B31198752D19CECC445918460C9B5AD15EDD46F02ECD3B7619E0
      61167EA0FEC59443F73C17C5B1A3C54D839C4A810883B84F0E17F6AD873A0714
      93C29A9924C978085FD593E4E1EDBB88876179DC711E3874EF1EBC1C0D2AE9F0
      E69321264CFF04D8D86633D2CA287283DFCFF80CD721AD35EF626438E26D4A40
      D9A2F14E36BCFEC02832549E0E4DF6E0F4B1A7214F494E39131FA63FC3C38C8E
      43905BDE44AC5AF2B281E1D041F1EE0E66763EBD83CED927A1931EE763849711
      024047F7A167B5865FC328BCBC3E2B51E10AC26293E26E712DE24024B61869B5
      E2F9EA5415F8455E74780B6F1BF20CD70773154DA7C99850ADB3AF36377D4E8B
      7182F7F3DB84A53516728A568CD147121E402AA0A2C1D9C10594359626492F32
      3EF8752FD1D7C80991BB21D0EF43356E97C8842521BD96A82F4F8505EE2D37A9
      7B80879E8CA30A9F21EB1B91383C2ED4880D931506792AC9AD0CDA5B3AA54CAD
      B899920F163CC53CA606F37F846C374F0371988B3304F46606DB42DE17D40B95
      8C206666AAA41C3E225FD610D287B975A9F167B46889BAE96325EC394CB23451
      C953A94D8D72EFEE36B08A5EFD18C510CC4CBB0B4D28F9C6E34044BCE30AE7C1
      CA70C894F99620F119EEC9179B15294D90BA3D990A28B2C49864BBA499201F57
      CCC2F2D11FED89D0F3E6CC87F3A7075700BD1CD968DA10DC8A115D6A7BAC3A2D
      2C68A65B91EE4E2F3435043703C641C43545116BC9514EC50F606283F2A27878
      696C568ACF92D9770D25FE18B63822878D6F6BB126108ED41F6065734B6C039E
      1C64D4621C5C168E216EB031D5C832CABBB7F77DEA90BC27571E735A2CB51817
      1BA59570C0DF01453A7728CF482E3FABD8B0D24406773C04FB5C053C2E7CA44C
      F940ABDDF9E1C3ED0C10F738CDEBB218CF472625F44DB2721A829832E9608BD1
      5D515A8D46357AD174AE7FC61EB4C843CF5174EC08F055917CE1474D91B7C419
      F23AB872C8EBA01122EEB3BFE05ACF9A0A3947041070B7F19CA3EC8358EC2404
      A95A9C576762317A311CB17C2C35BB51E4C3076EC23E9AB38838433FCEC77D09
      87486285AE2C8745647E199569F585C69B9656B76348F323C311F7B83D51087B
      D3F84685E591DCE2A01F85A1BC4EE76216C2ADE32D7313DFDDC1DB33062CA817
      AE7408FC7956FDA0E4FC3A33776A0944C4662CA354A61B1797B26C354F479814
      D6E9C52B3ACC0E59319B5A29D2CFA6CED80269C0AF3089BE60D0436E40100D36
      20102CFF600616079AC6619206050306D1D1BCC4950E08495FFE51256536FA14
      E15FCCE713F16B0B79B3B2BA130A32AAA3EFBDD306E76B58D64AB853FD31D9D8
      8A1B9B4B87CC28C7D92AC5BAC0589B814717758FDF1D9DED4467A4491C4BB851
      BF7351CCD251D43D38DE3BD9B9437C41CE2A33C50DE0F5A6D5ABE8F8DD9950DA
      8EDF9DEDADB3B4D0BC6DAFC08312E2609E5CF722C5DE823B560D86463B8B1A5B
      B4B285931AA4480537B545DC60F8DBEA082E5797D4CF5C297E39482708C4DA91
      58A00163C23AC268966FF0B4BB7B952631DB307732756B158D8D248ABA392450
      F1B7EE4DC5CC537962DCCF1CF6C0720FCF2A388D1389E4B08648EA3A6562F2CD
      A332FC6D424F524F8C2A697643DA4A4BB54D29F5CF85C9934383CC6A6DE54813
      D534895257F3E6E3B8EF8522A83F25D8CB877509080781A8246F26472F9AC45A
      3FB085318B2B5E92DA720917D345792A0ABAF2F78E9C12AE3CBDEB9DFF389153
      483E875B67C89430831A7EADBAB35EA42840CF0372166E697D75118461D92067
      C72A7D6CFB2C3753860CDF72D98C8BFDB675334C1AF659DD2C2F08E164E5C9B3
      417FDAEAA2E62A0FFAB275EB01CD4CB8FF9C6BD1F01008FD66618257A769A80F
      C45B400F37586EC88815C09C98E77C4A4E3BB22434786E92A71AFC13E119F1BD
      68782FBFB703D54B719E0257A0B54ED1EE4D31BFC3718513D81DFDEB0E297E3B
      B8D4C59E945EDCBA84543D772C768353483595A26E998CE625323D9CEEA3265B
      B993304CCF11C11F7F8C913BA66C31DF0D6781802C1ACFEB2BA40B920D5925CC
      65C85D3EBAE915688B8DAC1B7CA7287BCA3CAD287E7ECEC8C69BC3CFFB3FDF69
      98F7361B66956C158802D89378817C801F79EA03AC1E76451F631A3F1205D38A
      527015BD4A8DFA89B62DDC09EF774D4FA517C26086A6DEF9722C42F55FD8EAAD
      7EEB005F2BE7CD69AD75D34132900730C39EB32A989A0BA2EF58090666604B81
      83F6E5354B4AD88662C4E57ABCF11C369B93F04EF365E5334D320892C1F48EF3
      63C451645FEE640F58E6910007A7C59805CF344CBF365AC71E9A83690CAE86E1
      D40B56B9561C70E83ECE12C903882BC0538B2C4F234EBB839E05E19BD7B60ECE
      589272039241E5DC047727810AF5471569FCE1294B599D3D8F3E9DEE1DA86761
      D7B254E4D33247F4C73118B318F24A5E176BCB865F40BBFE7C3EBC2CE3D995B8
      05CC63BF0E8AB8283DF6B1BFE8B76CEC0714B952B51B79C7BC70E7A7CDB2E5D0
      04B1F0BA88AEE2722CCEFC7D742CFFF4C38F2CF1CDACA1BDAAC27816B9AB36C4
      BD260EB923348CA3D76415FC733EE5E181A369BBB67FDC7DEEDAE65A35074DEA
      20C90BAB92609A37B74620D945A2008361D302AC214D5366163F36951E45DBF6
      F187A57D0C74DB62590F182FB0FBCE9E3D3E7AF749C858E3740C84D517E402AE
      F2EEF8E83FF81E3F1F1DFD07949C174F8BCDBBC79AA2D2BDE3D3BD8368AEC5A2
      25BB3CCDC9857B76B5DDD39FECB214E8E2DB93E1877757FD813450D7D477D6CA
      7ECECF4668423116520460376CD9ABA74FC3D215CC6D5725320D89CA31B1F7E9
      F4A055B593BAA7A828748FC274CF58DC8225B53BA76F0E8FA25F7F8D4EE3CB74
      A4AEBE689CFCFA6B74B077B117F5DD7FEE41EB10AE7032ED281E556921559FE2
      8340DE60EB9EA1E81C32EF2790ABD6E41AB29362D6E6A6EB6D253983AD7D9ED4
      C868A437AB64BD02096E27A1817D7C70FFCA7107BE729CACA97FFBCA0B73564A
      DDA3348F5E3C1F6A5906C165626415F9E2457E2AF73EA929E0C3D8C2CCFE1DBA
      0961561810560E57B2F4B8E455867047737218B8611D26A1517B8F139979BF43
      D72EE2A1598AB90BA52370FF981E07E576535D67BF43F3A836059C068252DB16
      35ECBAC227099F6CCAE5CA079488BB446BBEC91E6754CD98270FD2A6ECE743A1
      168CA3D7E7A7EFEF57A97179035269E7E4D3F9FBA8CB183B2AC5CE922CAB762C
      68F150ADF116FA0C2B550AF0B838088CCCD337E77F64B1A11FBE8735272FDF4A
      1006D1C7C03AB5EB185D842720FC3F67C0362D1050848BED4AC1FEE9C9EE8FB8
      D72E0ECF9FBF42B71A01A3BDFD0F87BFFEFA8F93B383AD1FAEB6EBABE8F4ECCF
      478220B1B60772298BFC31F876436499F2927ED05D29634CF551A5863C47A8F3
      1C01C9FA55F4BA2828A5E1D30BEA02BF3165103D404C1F4427C400F6AD7A6AD9
      5AE06CCAEE7591223DD5A78AB11F24D9EC2A8D9E3C193CDBAA25008B2976D483
      3CADBDA5646465585D884C429EC22351366D2E7E6E7F94A5129E60E8C711C7BB
      02F4EE67E98C04C89D3BA6BD45E75F6ECA741A9D1FA26C9912CBA3135C3601E7
      78308BB75B57EF8A6BF89895D4761F15050D07A05541096F8620ADD8BB0BDD68
      DB5B35FBBE445059A2D92625292B19DC1EBC1B0F02166F26916DAB56DC5958CD
      92B630D0FADA6379B3F6D8EE5D6A8FDDB74CDF2E8AD41D015C955210146F8ABA
      E77531C3FA9202BF87C8F4F829E287F2094C82BCB5C4EED0EA93A7EEE2DA37E1
      B5E84D521F57C7075E9C11F6D70C69D7D1610EBF80420EDB9A8B6815A7E72F16
      8EFF2CAF523DFE9B56793F3FFDDBBBC0D8025E8655324C729689519D896D1BA7
      717FECC832908A11CD50C4916ECA34CBD291633EB396ADC83868DCEE7D5920B7
      7DEBD6F1EA30A9E4745748C0935B52142394E2E3F329B1635213D29C2AECD1C9
      D9D9857ABF747E559FF9412F988116C656DE8745DDBD76198F034007A209EB92
      EE14661C24D5FFE56F1FE450DE8F33AA702747F12879879860569984C124F697
      414C64E3419AA45685C47CE47A9496A8BAABE103D21810CF64A93229FE879A08
      6925E7A5DD05BC331EA45356A8753C77F129BDBB3B47480F533D6457105BA193
      7A5EE6867EA270C22CAE3A77B40B757A1FE42DCECF0F5F4527C76FDE46D7C81D
      57F6DA09634A3F452787EFCE1FA4194B02DFBF38D813916A5C7075F4EDEC758B
      5BF4E02DBCFBF4402DC8ED7855D4A0FA1B620BEEFF77FB3DF9DFBDACC6BF45EF
      839E7F0BC15BC84AB9FB0DF8FC8FBA015FBE649D5A67FB3C3E39FC1CF5A38F0A
      769DC63316F34DCAE802AB45B443BFFF71CBC688CA22D7E26C98A55F71E91900
      E0B525B1E715F67F7378B465433FF25ACF52267B93F827589A71D251074D72F2
      2934311FF6E53FB7F4C276019BC5AC70CAF2F2A49EF324C3CC5E176536AE90D9
      AB49F40727FBFE80271224F1A35093446538EF57FCF78727CF82C9D4028DA87A
      C5130C85690403F0ECB568DF14387E067D8DACAAACD8CE53FFD30F84138FCE9E
      BD8AF6F2D1550169384A79FC7FD17B30494F8AE24B31AFF91134B3B9D410ED11
      2689A5AAA8F0CDDFF6F6B7ECC6732C3BCB21E4B5E5317E4B1735730713E603F9
      CE3277EBF3719AFF931EF4B60E3B87E4DD272464E95289C668645AE4542726C4
      9E9494D74161B8CBA4982675B9ED0AF81ED0A514DFF5ED65A37CFE25E6BA1489
      C39412CB691EBD9B7F89FB17582DA8739ED4D1D7384FAB2D51EE1F087243B4A4
      4E67663D8CD34A9839E013484D60A9B9B86D1BB2C69EBFB284A1B321268844A6
      2AEA1E1C9DBD360CD143E95FD338C2615B94DB9AD33FBC7C82ADC5FB488EABF3
      5A898999C95D8B89BFEDF3BF5720C55D0ACFC42BD00472BAC90D785C57F8B611
      3398C82C1C866340EBFD69360C76C09FF3E2CFBA3CB76D01AB418C1B15C95186
      6431C73B39BF5EF77B5B3F76DB30DC737FC17D8ECEC1B68E33A99ABD8416C755
      4FEFD824FDB78D6EFD18F50D7D93C5A7AF19CF0A0866CEAE542F439186E54EC6
      CD3D4CD93FFD4837D32D2123FC0AC9A194826885DC3FEF92AB329DE22CD8B629
      8CF20798089EB960643E1CED529AD6EB01A24A6CC392DFB65DACDA830F8D4424
      1F4E4634031457DEF2F2AFBDF1D8680547CF1EBFFBB46DBB3FAA252339E42769
      8E65F3A128A655B44FCA48F8D666B662E8B100E9B0357E43AA0E2DFE6D171CE3
      FA822920E6E4597CD4DA8A5294B8DEFAE1CFF1F03749FD2EB976712CB0DFA5F6
      F06E149797ACEAAE1C127BFBE3EB21534E842212A5F96CBE2580F0E3F31F15BC
      78FED9598F52A38FBC9EB822F3C8E883127EFBF4B7F37D868BB70D01E36A61D9
      E819FCDCB10615A5FC0EA28BAA27A8EEEAB6ADE0CDFE364F5158735E17916832
      EBA13129CA51D2973482A8F341D498CF8ECE2F18FDEC6CD9A450314EDE48D4FF
      E8E40C79FA9390A2C9FA67027EE07567C89C046563DB06719951E1590D9CA694
      7599F41595F4864A50930F2F4DE9B5AE642D7B260702DE5BA2703FBEC4E9F8EE
      FDFE7F468FDE24ACABF87116FD3D8941DF79E42C06F250611B3E616EC7B66D61
      2519C0E76A2DC8F5F736FE17F2F5DD1622CB512122492FA119BE6DCB986ABAC7
      519A53B10F5578B89CC6C9288B2D555EEAFCCD67DC4934FBC127E53F2C1FE061
      E1AEA4CABC78224AD24884571026AC7A57E24A8A4F062C2197246C1C44C14BAD
      6EE4B667E86D5DD553E7F0004261C83539DFC760FAFEC8EFA2CEA1E5C23CE75A
      11D98309EBC8EC763484A1474687A92AA20D8341AE3A68746B8FF7B6AE1F2226
      1267E787C29A093B3D4B4A3191A55E6DE0EB302718A46AA4B3B90A28361B8361
      85B4B7B2C5827CD06E9F84A76B507F9EAA2DA2BCA79EBB028552AB882AEB7CDE
      83F6E6C5F308A5092CA5C6E1F3A21AAB52E6BEA80B658585B0F4FC9E0EFC6D3D
      52654CE8FB6A1E0D24C50C1016141295FE70AE98B47A7613FD364FE60030E3AF
      2E2333AEF98C5E40ACB67A4059513DECACBAFD6C562EE8D97C03241A4BD11AA9
      DFAB3A5C136A6A1B61E5F760E975657732FCA5A295E8E93B801175A1E7109934
      799CB1530C64E396428172590165F50742BB7FFAE12910BB3D5261CECF0FD929
      96C5CA91309C98F7A4F4F76D8FED3FFDB80BFFB6F331BF82BF1C67D96030E858
      9496921A641A5B6DB36992CFB76D08F7B08864908F4843353A7D7B7011889B87
      561D44A6C55E3AC7C56CF2F055D4458CA07FCC07FC1DE0061FE242F29B4784F5
      D874227F18E4355223AA41D7203CDCF218AFC348A367A5CCA0EC0415F6153139
      9172B683DDC40A41B1A7DE8A4566FACCA08E33C99F7683B039CF98438CC7AF4C
      ECB891563131D2572D21D9FF0D3F874DFE0A4028B63935695D4754FDD71D4151
      17073AD3105D353D35F394C64E655B8E326C3223B22887458BB09E3BD14E9CC6
      AB2BF6D2D472F9277085E176FB4C21C4E17A11CA5A866F338EAFF3CB39B2A0E0
      7D201BB7C887454967647DE53DCF0FD1391D51DEDA4D1AEC627AE45D645DA082
      D4F5CEE0DEE184677F5438E105DDB40FD4319FC5B95DD6A01A6EF940D2703554
      DE32995EB968AED8A9425A846C3DE6FF71540810C859C5963BDF3F3BB957E8F6
      4F2FE8ABB14684061E5D466DD56BD353B04B45F6694F2A1C21A42C32613C3399
      B796E473D902B8125421DCFFA89180BB65975FA0CB54B08BEB68B7B76B3A5CD5
      6C4E36A054129253258C54E83D62A0F196DCD9172F77DDFC1DC4D3F8121E2030
      CB8498258391593C245FCF2147DB36251403F15A8F2F4E25C6C273D38478F3A8
      A48F4B749DEBA599622FC9DADBB64F90E4AA80E87A7478FE5E4CD4D3622C228A
      DB3E15C18B3D52713FA585D425520D32C50E45CE526BA440AC0A14CFF04DB76C
      F9C7273A758FA18A0BAACA8CA0211793E46F8852208F6F5A6F8CD267713EAE46
      F18CBA39194B612A0E561A94A1308D0347F3475BE2422F08EF5690DD98730DA1
      E899E4ACF25F9A6EE14B59D128ADE6432DB7823C35166DDE7A9008D3DFCC9848
      01F4E0A783777BA73FEDE5A90A045CDCCC9257D1EB18C7503A42BCFD758C51A9
      D3D1964DFE4058976A15F555348C913E8B156CD9FF9481C4D2A3DE9528905726
      422DEC4E8AC51545544DE32CDBF6CD09BD0AA87DA295768B49D4394890B55125
      D1E16FF37446FCAC6383031FB7186BC062DB7661FFEE4B111D21B99A1728F6E1
      7E06B00EF5076E2A145CC7BFEA92FF8291F4770E4085AA4CDB42762F99BAA2C5
      D3A60BC5D34CFE476BA7B11285D58AABB510E5BCDA124A7AF9046DAB88F1D7E0
      4048720A16AA4A77B22D54F5F2290E6C013A7D822C19725852E48C4020F9E3F9
      C5B60DE058A1DED4C5BB531F946644C6721EC1AB4FEB1A153D6116CD7329EF44
      D955A603CBA9B77B0F4CEEE5535C8C2767076F709BC739CF0A692EF434E56EFE
      9A44EF3E9EB000234ADD226D8C101A6AEF5A0879CB6E3C230C995C47FB3FA3A6
      095C733E5587022785EA74CAB48E1972F0B54A9424E60357F7400B5F3E034EE9
      72909C9A484A5C08E4679F806F09CDBAD8352B89594869FEC5253916657AC90C
      19AC1E177F45E922E4A5D277D8B6AF38F9A5B834153EE464A3FB20E127472911
      6C71528CE6D402F089BCCE8998165B1A1D2F9FD11B9F0ED3CBB9092F30D4F8A8
      8AFEF6F1FC221079DFB281E7B737F07E6FFFE707680007CABECDF99EB1419B8D
      18E6154CF33EBE39232F73CB96BFC751E316984ED7A30AFF6558968AAD326B5B
      179210840041609BA4632D6B051D1409A031FB01F9687A29A50F0B073A1AC541
      C3F71365501438795D80DC80E260F1E525AB816C19DEBCB50704C9C0D6D8FB74
      6AF1DC344629B928814E3AB43BB4EA1D036397B2297B04A429342295C054895A
      5D687ECF95437E046A52F18521018D0401E964BD79B60B0E05FD15FC0CC1CC0A
      D4B7EC615F15600F8108403D1EE98161CF62633072332152314A6315B31C72F4
      A0BD79EB40C7AE82BD7F897ED8DDF565938D4620C020B233835074A31A909C49
      BC595C46BEC5C67C49E007ED7DA3348A864E24E006E95A60861212C0AA893A48
      FAC0EB5C149D6806196911A8F1BF94952496824F677CD01E077E3DE82EE82312
      D494BAC7BBBAFA22C2080FDA6EC848C19F524DED64AE5C5640F6CC046BDDC9C8
      E597E67D2AA9AB0C861ADDA28DA0756F580F74CBC3FAB6FEA6B9DF0DE2F241CA
      548EC3465539CBF1347D1A250778E34157C23C17D2F9BD48C8B79D5EA179616C
      8249A037E7FAABD1C0E0CEF15FA790EC3E84E94B5819132D55E0C31AF780126E
      EBB9628CBE30D034ADA8FBEC2BE1F94A85C6B256D3FFC123929AC4F1FAECEC67
      087F5303F2323A7F7F78E26AEEC918225000E3F521032417E38966B40D403639
      2A8BA9AB17EA76848645D5F1B4229A3E56C7473F64AF2428F00B58149F9546A1
      0C95A6CC5678D876B5F422ABBBE54890CCAB64E7217B25E097D7890D085242D1
      C989A83C6493C6515DB8977048717FCF18E683822405EE5D5596F609F690BD2A
      CAD9550CA87BC9BEAD02FC48D43216886AC6DDB6E2A8BC8FE2AFA22EBD58E2ED
      F78DC2BDA0DD1F8063171787AF03AEF5A243DB799DA1E2B5AB4EB02577E7C5CB
      1F9B0D7F3A3E3FE6C5F47EFFF4754869BC5796F59F5E3E855F5ACD2793F49B20
      19D0B8114C1846026C74B992B7759C0C5DFC8C28A38CDA9327448A78B683DFD4
      673A5EA7C9290CAAB150CEAAF3561C52A27E8CD542867F1F699680A5B61B679F
      E78D2E44BBE8168E5AADBADD3967B1BEFB3E9BEE42E78314F21556FEFBB2C0C5
      5C46DFCE0FA343575CF4A4B8ECF81ABD5B35FB418E63B1A902ADBAF7650243EF
      1CA6286F2E28770BB6189042504B54D3141084DCAA070CD71A1DFC2A15815B29
      86A0E164E85B6F7B59F2E9D004649E05911AC8BC4108603E146E74B4B7BD9045
      70E74ABCE4F0DDFE5B9C4B3FE7C535C1209CA0DB3D5BA2F971C5F25B7ADA29D8
      731F7603F848384859F90552A930A35C0ABBE6AC09202F3CB316938591A0A8BB
      BBFBA47F747414AE861F7677F1D18ED9E6D3199EAFDCC8C3F3ED2EB3767C4F35
      9A24C467A998C2EEE7451565B4149D3A613E8EDE1E5F9C1E6E4EC738478D9C04
      57D27B57C26D5508F71C293DBEDA9BC570B5108A78D2B154DEE15351D4262FAE
      B7139B9498336E6C4F8388ABA8FF5BB55DE0A00F17E196677EDDFAA10858C39E
      22E88747C597D93D5E57A89F7CCDD13D1E835E058F8A471B2F0995E3C016A439
      096392A6E4BAF2C1C85F95A2732EBB21CDA383065B8041FD715213C162701FDF
      31869685217798A9CC4CCD98E22F0C21340A8469ED02F40BE0B072AC4D83D7D5
      138FC756C80E219129690E0D4D56DE99D47753BDE9F6890F18DE4AA6E35A165E
      A3AF67CC02BE8E8F297434CAE5831BB89E0E211EA96C1C1D35B5FB6E43D9C812
      51D2C68D6A3E92A9B1B3018F46F5E6483C5936B6C1182E4CDEDA777115801CB3
      030A84994B957E1A9C1C5B9E08EF0A2C4764C9B92439AD732F6BC5F79E132BCE
      BDA5D1D5457B3536387F98BFF3629E45FB715A1AF5779C20B636A4B639A828DB
      75FB0834BA46AFD5B397AEB5FB6EBA99E1EAEEFAF47772A26FA077CB8B925FDB
      B93745E6E9E614999F8BFE51BAF238307CB598A8AE645C015F91D30197029478
      9428A67506C45172D58A59D799F8C1FBB82E1351B97F0C5984F8E67D9C6D406C
      A27263406E5ADD5E342CA0BB05995DE43B60934D8BBC4699A47181681B42C840
      7CF9F23D384F25E0E571AAF8A608C495F01A23F24EA5F7103598258351318DBA
      45C927C81BEC3039E7E3FF5E734624D260F41ECC11D6C860D28C61CFF2472DB2
      AD8B182A1D12166AD6F19E021786EBB239050E190BE5FB22A9ABE8533A4E8A95
      C6C11E175547BED8B14E35B97EDBF671C971434A5C3123E5E9DF8BF9C57C98A0
      8AE30DE94E9C52CD3EB32A6DA8525850EAC5BFD61FA53AFA22D0F63367EF7D52
      7EA1BEE00DCBCA444FBE7FB9EDC355044BD06DD356D2EC665999D43A795451F4
      7445E8D27E24295C8C853C2870275362A5F9C058CDAF6368C267373B0694B935
      A0620DC2EBF58C19DEAF31C47E33540152816B8672F46666C1BA07ED37296FBE
      D4134E64E8AC1323AEAF5171242C8885EF484E2F8BA0C83523968B5D2C12D723
      A1954905C2D6A1F209F83957F31AB8D4C382A674B93FE673183B1ABD0022534C
      A2D7A752C186C10C8A8E4BADB3B8F2D93215C8D55D4556F5FE1A26D133318976
      1EB4AB41B1D26262CB15338C53102C675D0D12D1794C7806FF30E17BC79B8529
      22BA582E309696A3F9D4EA7634043C45CBC542AE0E77E3D438EB8E256E1FF465
      3B07287CDE5682EC781C99F947A1FD1BD4A3556B11914A733F8D6BC3AD405901
      B1961DCB91073045241F7E8FC8AD779C7324212112547CE466D05CA5F06606E6
      C9EAA2C838C8D299E05F47A42BE4C9B5236886B52BF13CA3E33FEC2E21C24185
      5570B6F62E3EA0CBB26B1E76B8D4CAA17C9DE898A750BDBFF58A64AC348E8628
      49486A1B16403E8EBAF5558CE07375158F77AFABABF866FCCCD51B9BA4DF1E14
      CC3F97F818EDE7A2942C3639B6CC6A3B3C3F65F05D3401CE0FC504820EC99950
      2B9C8365BE15DD334F7AEFBA100593A54D10CAE4D851C4D9C1826647BBC0DDE1
      F9E983BEEFDE78AC9A85DD1DE7D8C4DEA911753E6E358B31084EA351E2ED8B60
      DC167912D43F2C2D09EC3FA088B1A420A5BC1AB576A772B106B11F4109EF15E2
      BC25E2E3A1C2BFF3CC2A26D1FBE25A623DE76FCF3EB6B85B2CF2B43D75E2D6B0
      93A2CC44AD4C5DCC4D555DC67995C5A46CB8B90B582328E0F07BF5A7ACA3A393
      F30B1B86210B890A2FF89E4A84B7347E60F25DADD8D39B0F1FDFBB70A9C62B51
      D039EF4FE21AD52C3413D6ED59B923174B72AE00945C1D6127F5B7D28D58F67D
      A94EECE35F410AB11A5552AA00680CE75311D9E8091C2657D46975B3AE31ABE0
      E92B20FB4919447B0E3F6EB9365AA3B62C321660D9DCB5B03756745E0E96D722
      3B68941F085916250870C31B137A59EF8C69565967DB163AED77ECEA3088EA5E
      394F56A34E6A36A3A69226CE4989F0AF49AFD19578492F60964A0F17939F7C51
      E4CD639E2CA82351F1B0B69B4CF7184571296FB7EA756E7F46F7D11E99D84792
      EEC3C2BCFAAD47BDE811CAD2229C21A269B2D50351D547A2A6F648E50D3AC7AC
      B881A2AC486CE459DD31FBEF9155B561791C5815C3AAE0B3AF6FABFCF1A82DAE
      F048B2A15DD97287098A085434C53D72897B7696C5BE30D6CAA93E45D262586D
      361EC21A58D075D03B548E299A3A6965A01458C0E3622432005D30C62C178D21
      79858C7B3418E968252855EAA66167F3D5F00B78759F976651F696D028647EF8
      16147100DB0F5135D6435C575758EACF71C87913D205E604581D0E5C81928561
      B091C4F65162467C622438A6CD7AD8AA07E931D5D59089FC40EC2776A587AA4F
      2A7DCFA6A89F5D31DF6F3B78F6D6C4D457D040C36B2F67335AFAA629F540B604
      9F6DD589E5ED6BA2F0CAB6BFE737EEDDB45FEBAFA073E69A7581146BF2E88C6F
      FBB7BDFBB6A88DD9F0F1C3464BF6F6DB37D45CFA984F36858FF1293E6CBDD6DE
      9B9385D6D6EC0D77162995902B52D255A2FD582E10DD0FA73065E54F3D2997F6
      85C5D592B8127039C17A8E0DED75B7986508A3AC486EBBCB76C4E6C70787832A
      4338E917CF8B7598AE4F735DC88725B851179709233B9214DB0AE915652358B8
      E10920A8784D01199F4C52283EAA05D6C4691110CDD9A61688D0222BA3623AC5
      7108CB6A658B3C496CF17179B4DFC48F8360908B71A6759370F86D757E36DDA5
      E45A5A426DC88D463C0E0218BE1AB1ACD22E13A297DD11924BD35379C91D5169
      F8EA22900DC51F6297CA3E26BBDF6851E4AEA7D01CBC8B75A3E9F0DB26E83F5C
      42FEDA74FC55C9F86D135670728B26FBB415AE6314D49DB8370028CC72BC74CD
      757B67855451E3EDCD954FF42E923C48E2E27E76DD97D9DDF33A89A7489C4BE2
      E9D2EC0F64595710A873669784D4D80579902B066FC20062C6CE45CC0A601714
      94F50D1E5552CF073FDA7CDE8FC0EF9CD7D1CB17AB46F2C0A5C8102701EB1950
      9DD54FF065FEB026D25CD217C7CD42CA691E3D81302F5F08FFFA1E5D1D5DDDE5
      D8B492AC268CB741E1CCF72E288E6196AA9FFA14FF26A29C2D05BC822FC0D968
      6C3ACBBDF5EE9C8424B34C8BB24B0D2A6C5609CC0EA2EE053F72780584C0916F
      41153BD86D0E6185E4357E5A4C26622EE20385B78AC9A4556448302D09505BAA
      9FB00AE4126C93D58D3CCB170CEAE7927FB0A4F4381C909F073B2BA52B3C8488
      82DEAF9AA520AD369C50DE587EB5EB881A525FDA179772953325E0648C7F6141
      B022BDD8F99262FF25480B695478D0F9331E3CF8177E92556E69984C8A123589
      B16AAFD2845D4CAB5EB3F701ECAD1C382C71949C20A41FBC943CAF3D13D89BD9
      EADB0D370B911C9992162450CD3280DDC80FEFB86F759CFF8C162EE03E73A574
      8E30E9469847B79ADF3C828A09ED1CD6972C351EE1A6C3312F4849F19DC2A1A8
      4AEC58817ED9AFF6DA6F8318E9AAF8ADE30B8AB2B191C795C2FADE0ECFD67A90
      49997E357E46300D5AEEADDBAAAD694559653DC559E568D072CAEFFF6C67BB27
      93B70AC0AA1050D2D8263B21A6A52B6478A3BC3FAD146B68AF26D579C72CD4FC
      31A34819830D1AA719AB7E2C2B37982B27007E70C0B2F37B6009D004EB1555D3
      6501565137A81F887AA73CA8FCB24CDC89623F5065A164BCF32AEA63ED60367B
      E0DA04FF81058A799293ADFFAEB00F363FFC81FE6BA51978CDABDE5F02055AA9
      18D0304B20324766A12E2C83723ADE582D8F90062F834426000EF785AC5D5994
      4E6D9C8C6AB77E35AE163C1FB5F54496504314C2F2943807D6869CE6B8484964
      0D4D2C13FD5AD4362FF2FE38A125BD787E0FCC68CC70C0DFB48D47AF0458A6E0
      A371C096766AE53A0BA6C4E111DE200E8D5750A2177A41295B693B5412C626B5
      6B3567B9BF769F44BC615ECE6003CBB5604326C9795E660B01A443B9D250174E
      6B637F099206E93EA02D9904D8819A74C6D350431D83E8484BAD2F6254BC9ADA
      B854BBE1752726EC0626D0C078F2084D7B88D3096197B84CC0BCB82CF442126C
      06EA0826A270E72E14100C349E5FDE6ED8A33D49CA6150D047C4D3CECF0FFDF7
      1BE63B091766E1F683876E6AC38730F49E44EB1850C7A3368197030CF96C0143
      0E0C6BEE04598C3CD154225074311716603788BEEA737B5E5510F18FF68FA415
      C6324906454BABED2B76DC441C17A62344C5CD33B0BB5A1C164730315A4952C3
      AC9578E8DA0B5C1FED967509F3AAB0003D6753A603790F1CB62D24D2A085F978
      308C9F466F97D54C5CEA3A3A3E1612897950F8A7B8E51088F09609C1DFA01EB7
      FC1006C4EBF3BD7274B59E2BA699A0F1785C350EE78BC3F36722E8092059AA84
      55D1355267E2E6370D7905260FED2A54DEE331A252DA67E2182125C97D81AF64
      0F5E87CDC8B1C9238E8533B4C4B656C555F28A688FF29C131822F9569771F4B5
      60CE87304162305C458053BCD7C6E55F17D1FB224BAB2B7BFFEF77542FB359CB
      16E9DB1578CCC54C09314D99BB3B40134CC2D04DB63EBB40BF17183D81B78EC3
      C4923A004B8AA9878D84E8C5D75428257AC6222F859105D003A3BD32890E70DC
      DEC15DBD2AD39CB49A7394757B2D42422B2F54CDDDFA788CD2B7DCAD1D7414D9
      C82447CA231BCFDB9812D9B103B085D684DB1D67231692CB94F2FE6368B3CA93
      5519894E2E1924B887DB2412A9956A67468A6D09278FF7E7EAF34FA5083578D4
      38EB5419881D136057A9F8F8E46D92CDA2C74A388D1E47EF926FF3EAB418E3DF
      6FD2FAED7C183D36224DF4D8F1831F2B19F6B1126CDDEBDD9B1AFDE40F530FA4
      B6D1B3C1339E25687A57547960218455AF2D47C032C989D4A08A4B77582631AA
      FACCEBA25F268262B21ACF3429F1D52DC5C25F50EFDF9771375DB186A6F387C3
      F727C8F93C3D3B383C898E8E4F0EA3777BA7874A487D5829871AF6B4E487CD3C
      AAE4AAEA096F4132E9FDC1D638D530C4141279D08E8197F5D834C8A605EC3A13
      201B17AEA0B1AB47FDA06D9F2497E073B23233EE7D8651E633B9387785C02964
      48DE308E43F1C0B9F9E4B85CEC1F7DC45B0A20E7430982CF768E0A3A4A1F679D
      DF4B17A023F5137109549D802FD2AE2EF9F7B3B3F781B3FDB08BA12CBE247960
      DF580912AA44A963D8CE38BA4CC50A35A6B006E31FB4634A3438BE386D482590
      C20009E256FAFC03D35DA5A2E545314B471DC1BF2856CC6CCB4EF4C6A7C30F13
      91F5A858F6BC001F21DE5631E196DE682930D593032A774E52C18764C4DA2132
      83F7DBAECB2959C68AA521935601BBC5EC1863543A6510E538AA31D7D4FF5D02
      D83D646F6985B8CC7A39C93C0C318A47B0601C58275455C52E84A5E1D27F02F2
      F2834A3E884D4391B3647C0B7E09071C296E94C19CD7D4A3A11122A12537F2E4
      4D8674E58AE9EE56D1924F6B80210FF92666EC9BAAA3E4A4134A2A66947094CA
      414872103EB4DC735EBFEF58E57A1C5EE50A5A8894FFC6E68C5A5262A9AE8C25
      DC44B36236CF6220BCC0B460F136ECB0B6ABCFAA2A4901720FD7CD8C510007EF
      C408E0F5815A5BFA55A34243968C69F814B9D97F9B9BF5DE9EC4D9A316A55ED2
      6BFD79B1E3D51883B56D86762FB466CDC25ED594A73B0C93685820A9221FCBFD
      8CC8FAF8FE76EBEEE676AB2760AD46733AFE8B1D4FD5F26EBB55B712F802493E
      9AF5E5B61AC0A5B50086C0AD4DB811D60CC2BA00F42FCB782A0EE9004BCF0AB4
      A8700695C5C4F8A1CCA222F81DF9DEB0F8E67736EB18C120B2874FE674DDF9EC
      4A7F4F1ACA12861A5EDBA2035D2BD1AB90546CB24DE30556DAD3E7ED5978FA83
      CCC2053D36487CC05BCB5BE26D4B409E8BB3FD25C97F280AD4722283EED33CEC
      D24BA4F53E2E20ECEEE836FE8B17F170A70D0973548B3292A2088B1D5E39ABAA
      95BB2FAA62601F2018AF0DE3550462E351AB8897DE718AEFBBC37735E9341D23
      9573E21E8BA534866DC5DE2AC18301BA75F0254A1A2651D7AE85A2C4652031BB
      EB25AD085C17E4A305A9E11C76ADD57519A7F9E6AB420C92D5FB529990CC3E5D
      A425B7261656C73ADCF6E422FA2E3A6718F9E2C349F45D74A4FAA101EF12ADAD
      7CCAD1B3A05411AE34421020B8E82DFD25496610A72248063FD63000BB9047F3
      B2C24551A048DEC221DF6C4D96936B301C92BB34696D9945A1CF61D731B46582
      5741409045E92F11E036B4DCAACAE80172DB23F4779B2F81FF288A95F9F77BD1
      BF0ABC46198FBE400FFB219600DABC2D955FD7C46E2FFA8E2FDFDFFCF6FD788C
      93AB5DD37129524C2AA060B0558392359CC3844C73FF30826037D65DD37A195B
      B0A3BE2A8BF9A5A0C71DFE829A4A828619BC7E53D54892C1475D64625968B775
      A4EE34803911DDE520584EB6754A0C7B7986A29A6B51FB15BFC5BD8714660C05
      23FF88934D9AE72473C956DFACB964BAF3D4624B7C610BA287ED8B45C3470A49
      BE824E12879507F109ADCEEE58CA63737117AA49036E8C6397C87979008983AE
      FDD5BEAD3F0EBF2C0DAE1B29F449CD5B88347CC1242168609B57B81F4AF86940
      A4648762BCECD5D20AD71982C3B65D6525E8E3C5C476F551933B40DF3294F135
      A27DACF504DBDD121D464556CCCB8D353BF8149B70773CF21994FF9F26B04118
      CF93E3271F038292F559E937E93DF0C4A3DA117282D2860E347BBC83E0C7EF34
      BB2EE7A069DCC17272FA17F69CC7F2FB1D799E09FA2B65C95E6848AA9AA3A6CA
      870D41A2700F6106C828C896148DD87C6215695B329FAB1512EA95487F880670
      CAAD1D35F194D8525C5E8A8A2E54FFAA7498A2388AB023F4FB9018B34207F223
      353CA06B6689B7527847692962C2C98B3062D6E598CB3BC9ACB9BFA3304B7761
      26D62502998CB51FBA2903373330669B6876E8C78F108B0B72889D372FA7932B
      D1C7EF751BEFF038EC31E53682F67D19086D69F3C97F9B5E5EF50FDE1FCB96DC
      780307A985CD278487AFA27152D8845ECF28E65C2D947E943F4CE21165762B0B
      EEFD143DD9DDFD3FF6B2B6FB2D743C70A4DA2C9DA612C4716C5A1D12736187B1
      D51804582C42432E03DBE9698E6C27353A389A57B598557677DC6D883B6FE3E9
      705E5E22EFE9B45D596DD12975DFE6976F931EB1CCF7E51E52709B2BFF4B9F82
      154A416ADC93B47EBA8E89CCDB2A9A10CC66D8418A2B6D973E73526030FFC549
      D9EA01968941B1203205F32D8BC38213B0D50F3788F232514C0CAF1AC45E9790
      DBCC60EEFE950B6C9CCC929C3839C80C12C4E45EF6C4ED30B429CAE89749EDA3
      C60C3E86869EB8F87708609F9F9819BA99CD2A642967B9A24D2BCDBA8CB5D60D
      2807F85BB332ACC5B8A7EEB2D69CF72A693D7BF5091C14870D749A8577A2D45A
      AD66D4E1F5DB01EA2EB72EBF664AED6969F53EA269CCB47EFE8C2EEEE1B76FDF
      443471101DA2AA6A7623254B17D86DDC602225EA4FC8501382CDCD67F8E7D3EF
      9F451D8C69C775BCBBBB4B5EEC815C4DCF777F7CE1BAEDBE7374B8AB5F3BA454
      A3BEA57295493285D6D35A9BDCCD9D0F1DB17C4F20FAAE268B6B1B7E08FFAAEC
      622A8AEA1FE5E2922A38E3F432AD2D41DF38A4D80BEFCE2E08FB67A2BDA29259
      6384A8A6E083054DC7F9CDB428D724E2064429154C531A49A09326E88588CA27
      BE9A7043C35D60FFE92CAE39515D2D4E4AECD185A609B0E44EA9122F4CC79351
      AFD8BFB6EE0579ED5EF453F4BF394F6EC95DC7259D301F29F3D7CC92E5BC76F9
      1B9FE716A7162CDADB14EA5A4FD31A9B78287BEA3888B600B82738EBD8450825
      E00766DCB8A1B59BBFB9E557B6FCBE4AE6E362B165A910ED66A6D111599CDA13
      CCBE0B2D6DD01BDDAC085B57F26398BD922FA1951CB4E4C3D7A431CC3ABDE1BE
      DF22AF6593A337F876C8630DD23D9CD09241D03816CE5EBE584857D2840D4959
      9A142F5FDC215F291052E46060C8A41C954BBF19F8AC6F4131344F455FD2A0F3
      85CA9C72A570B2CFB97D6FCED36F1461718AC5370A8B04C59B6C9619FE59BD3F
      16071C5DF076A884F2F4A017BD32B9B8F31B645AF908BFE536C1A3137229ABA8
      C4F5B28EA3C5E97C441C55EA358C8412D8087D4BCC4B42E72B5FE2F51CA5902E
      73D00BE3BC8EE229B39A203503D28520778CF24E940C5C52E84AB35044142DC8
      95E25C3017DFF223E31CB93FD74EB1BB63890BBE4ED6AD79742B96BB5B146384
      33F6A596C1AA376DFE20A434EB5D2A473AE3B2634D33948FB848041091A8AD89
      8E31ABC965CD9489826C7235ED7FD87786B2E48822968B24294D9A53159995D3
      F321998833205A03229E56683752E87C691107E0686552A19C1B5AC5F58601CE
      A3EF7777DB6925B4A428E83D69ECA83AE6DEF3BF7DAA926CEB4138933F004B41
      1C6776CE8D786BB865A05C417849914095167CDED32ADE9E8489D75E7D8E54EB
      A7D7748F1A208A74C410E85FFF0B27EFAFFFCDCD660AB9B033430344606A591F
      904A93B826CECF5AA2B01314BC49F3790DC305D593C8B4D7DDA398B79991B6F5
      999366BC4359818D57C8379E897085BA5241DE341E94C944BE82212744295197
      204B29CD454AFFD75F6D40B8BF925F7FEDC82E8847AC442B68031F26D2EF94C5
      914A065CF6761665C5E586FD561CF1367383A93B9B1A1C07455EB3DFD15F4372
      B4CA06B1383C5B5D736EF8E7307BFDAF5A8689174B38D8DE81945927651F1FEA
      9DB4591B94D4B736F888B00D3D956CCF96C964A5DFD8DF7FF5EB7F616A7EFDEF
      E8AF32477ACD1086F30FDE5C1206EA227D1C359259683D6172BBDA9CC5E4F6CD
      B86E1568E6998B58F0793E23E8F64DAE65263486A4CE91AB4D15EAA248E7E5A6
      D2E8296021BA933E31D9054EF6DF7F04EC9104BC8520D92DB83A713E83A30C17
      8CDD802BB6E82CADCACE0F2E0751D3E5B5B1FF61FFD9D3BB0CA2FC40EF9EF0C6
      71229CDCA5EAD501DCB17B2AD8B01B37A23EA2B39EEDF13A23216F8FA7FCADDC
      ABCD07EA9804EB64EC99FB64A616E36486FFD8C0FCD5B24CEAD05900D2599462
      AAF3645407DEB4D0BC79B7F7EEFC38EAC292839A27161B158EE3510DFC5DBFAF
      4B45E3226AF384C9C9AED35D40034255932A98EE61B254A51B6C4AECA71D0C35
      314294E368A8C173FF988CC7580881442F59313BC8D020854FEEFC603CC44549
      5161D9EB06C125E12BBB1E2BF6A24776F36FBAA0201090E9373670B6037209C0
      1BC6386E6F448E59A338F1AB2E51C658CD1A4032215329F3CB04569D9FF5622B
      565652F2142D02E4D24961866776176ACF504A0DFB17F600DFEC5190709CE602
      D01150B0483A5FCC2EBFA58378767E07FA035FCE5E777D161EE5BC3C38B8304A
      2C0D9E5CC6B02199492B1DDC0EB37D233BC83D9BFA8C10F6286D650B00C6C38A
      5A913D4FF6A3920AE0F41E0BECB1B2645B4F92E9BBC63F31F78BCCE6ED0AD253
      FF7956A2F91ACAF398969B99C923D2AA872E9B1F2FF74A34DA5953D4974795AB
      129A1A1A80171B4CC6A2595C33D894B6D629BF8112A54474FC9C11ED42184182
      0E4B57F71D41759C154BA668B1ABAEC4E7C0FEA6EAA342FED3B78010BB3D78BB
      7E5D84EA939B75AD358ABA487435D8FE12794FE23D40C1450A69008C2D3A1B66
      E957263A9AB3FF4CB6B6FD278921C9652C1065A31F22055E8531635F33114A99
      D64113F86EFBD2D28560D5E420A0681A24C968693ECAE6A437E4403A2416E247
      27EA36143CCDE7685570BDF3EC79D571F737490E805340C865E934B74E9EF631
      10B868C188E1FA71E7E193A7DF3F8DBA3C2AFBD109CA7947C73B4DE581206D5D
      B236FBA3595FEFEC577FB127FDA43982C107A05E0AF1655E4F7EE0A6F60D8B35
      C894F65B554D1A0251AE68F55A0DC0F6E1229A0DED61D0298BABE8E3C5D10F83
      46F2B402DDCD2689ACB5ED19FF5CA5729012AD2B8410069E2E8E616E8552DC20
      5CB7521E3740C8164F12BE9EE9F6357808CE9453613DC2DF3358F3BA4DB12C43
      7DBFE67ADDFC723CD18656DE8BC1CEEB62719F1F0AC85E6463D9826108B3D175
      7947ECE6CB1CAFBEDD251997F1301D457DACF9175B3D017E2D26B8CF49DDEE11
      FF4A4657D287DDAD1E308E21CA254F78BAD51392FC32BBE7232628F67BCF47C0
      E7BCD7132E93720AF1B67B3CA14C922FF280675B3DE06A9E5FA230417E9F194D
      EB384BEFF722FF8C67F17D57665E94D7C9E53D3B3293A4EE7B8C064ED7F9E55C
      5E66EB7E94F3AA72AFF264AB4754B37BEFB4EA3A19DFF311F5BCFCE21EF17CED
      F17A7EF8071CA42B0E90257D32B34E95095C80E70FE9E8D23EAEB8C844A28E4C
      22BDA299F114881934E42FD6278F344A3FC11256E1083E9B0EAEA4A3B926BA14
      9E29CDF6903884938933DF56348586C5D764072833398B5228A4ADD0C15A2940
      A6AAA8F3516A41857F7EE52ABD8640158BBF006F5BABD0252693D744CC0BF2C7
      02404464D1E06A2DF6CD2CCC19CB344A493D7068B46C3BADA6E897D1CC0CB1CF
      80EC434111A15449CD6F615A2AD1235D0D6487CF5CF53D5DEA7F8501BBEA7B5F
      403F2BF2BFBE78F1E2C53A94CFB342E99A8BC01C925B9C912CA51B3C8C25DC1B
      3C3B4A512A49A80CCCEE61AE2E59B431D0F8F58A6ABE756F8592082B641218A9
      52785ACCF9C0624FABA66C9A2DD9CDCD44957377BF5C8F5E59C28F9AD981185D
      E750A6A613753B877947E44FECA82175D8EFDA099DA9D0F67783B0444CD6BC9C
      ECD55FEC113F41FF87402F37755593C1D2AA1D2372B5D7694D766CE83C0496B8
      2B5ADF500DA2A3265A02F8295DE600D074BF76FBFF2FF03E7E1AA479AA5086FB
      4B6AB638CBDE4C1A0EB7312BAA85EFD0D9A52829DD9A3B58FE6D776443FACF22
      EF7A29822BF9A6AD268C3C621C543FD1958EBFF0AB4A29E81C680D993F2F4748
      40D85BBB6D267196816CBCBC4738BAE65A4FCD7A43D85ED7AD78985D5ECF4767
      CF7B5EA447BF8001A0A3A893216515936FD406D04368B5CC09E37DE1B0892F2A
      C0C3A2274FD09B79921AE9C648A8C094C66B084FD33B344660E81DFA233D0884
      FA53D530E401E597D5EFFB4FDDB3C1F724F8C9861506302E571C61DA50EA0A7B
      D2F56A9C54CC25B6775D4D2759BE7CB4B416308E6063F262D273505E5873E1A3
      D115948D48E0E049DC827560AA08ABC15DE8BED1806EB728E678AF45BA2A8373
      09ACB772F12C7EBF19A50803144B06144B6139F2E04AB8D5CD84D9A8ABD0D0B2
      230DCC9B10AF5A388E7738B382C028B7515658CF7799261262692DBB32886A51
      660BDF4307614C79C15DD61F7633628F0813B86E9D268D287BC9772F409D65D1
      9FF3A2FEB3298135ACC1D6126A1406EA628471890588E186E19625E666E3D1B6
      9675695E66C5906772705874F11633571105E8DCF24B6D27D4751BCD427410E9
      79A3599F4D879F376E5E2F8ABE1D98D81FCD9A3436BC2D8E6DEAE0182F91992A
      3DDF1DDAE924D6946B8B2507C38901330A4AF37045AC99C14B457387710582CE
      4D78E08667E59A73579ED213D3D6970296154BE5BA266C27476E50B039386E57
      3307095B43D330BB512181C68D72DBB251F580C6F5422BD2D602F7C65F46B357
      DFBE7DFBF613533954E35A8E0B792949F8E82E72D37DAE23476210E1312E27DC
      96437ED3369C6559F4643CE0070E82ADCFF1A60E137959CF8D0E4C731C875F96
      48847DB7D227E005767F7CB6FBD35DCC23978DB1D6C268A76F44791297B7D009
      E8A46926E6522951DDED4B83F9AB5D237112ED87AF0C4A59FF130D09D8FD61E1
      E2571263580832AC7FE092F5D67CEA13FFD4FD9B32CDB274B4C163191E5878DC
      8BEF77779F44DD8F1747FD1FD6EB692EB1008C76E7C6DEA980B5395C5971B9DA
      39DDDD7DB5BBFB395446074D2A295F45BFA821A5933238BFF870FCEECDF9677D
      B57B8D8E0A8B348C385AB6094D22A8553CF2740089D414751B9B69BF8B3F869C
      F5774BA7A32E6D016B7CE7AE73E2026BB8AD9AEF11D45E4FF9224EA15042843E
      74B7D1DC3C5F3E37C1899B54D3CFA8C2E5925ABAE4F6BCDAFBF1E88767AF8F8E
      761EAA8D071BC2BB347A4E0B4E79656BA87E8B538363F41FFFF8C73F7E6AA4C7
      E2E80DAE817B4FD293A7CBDF657F66A56D2F92AA1E24D5EC9641E4ECBD95DCA8
      03DFB1D563BA2A59D7E7CA5C6DA0528B2B215BFC8967F096899509088898EC79
      352A918F2A5993165B05CD4652A1A62959ED184847A009C3F65ABAC1B4B35B11
      CFD54225C1E120F516500D0A3EAFC5F8DF7D0ADFAA0D29F1CE1730933CBF35C9
      022A1D0BA53DF5A89F7B7FC209F1CFB2F9659A5783FA5BBDD1E30C6FF3858FD5
      234D73117C0EB25AB86C830624133378432965D2FE9D98A892C5EAE0B4221EF3
      371B753478E55EAB32AD54C5C51F9B19348D40386BDA4AF85BE5DC2407478BE6
      5649AD288BF0C69126A775214241FA3B2CE03620BB0AC37F32207C1F52C737FE
      ED53F9AD69885753A8EB9D1F6EFCFB67F2FBB3C9241DC1F73F38D9C72B5FC5E5
      18F693BD4E3F9C818D1FFEBCF962FFF9E983F590D7FAA70F8D18C9F3E8D3878D
      1FFDBD3C7A9F1E469147FBD91C715A5DA60FD3FD17D2C68290F9C60F78290F58
      266CBED23E3E9E18F535204407BB50947D250F31A0D08847AD373076A26C6C96
      5C8373C610936AD389407F9B7FA3DA81816D27ABDFFF2CE0F24833486850020D
      E98DD5F2D75576C80CD12A768E2EAA4B62C5F7875931FA721741B96BE3E03A87
      3C1A53E572ADF3B1F00329E16E39AC0E39D0EFC1836D1E69B14BE200C6CCAAEE
      EE6F3A75D02E072D562A21F4A2CE486BCD0F0603BEB8A87056E93485809F2B45
      56EDDC22C8AEF7DF06126EB8FE049988BD0EA32C069D232875BB827D0BCB6293
      B20B520F157557548B1D77D999A4E5AA98AAA0A52808ACD5198C25EDC59E8222
      353B3DB7D37A3E3BB26BF5CC75F3EEF4C4B2D09684821C4E8D906C34A9F73D32
      CDBEAD3DB78DE919261243BE9F65655D111A849D581D8440041DD54DCACAC81A
      D5FBCA6E152B054EAE1F9D25FEF97FFE078ED697A4AFC8DBFFFC8F78B23178D4
      045213C8C6ADBD2EFDBAB55792ED671B5B9FD34C490F92DDF9779A43ED9561F1
      5576F797C1E7501FF2977F7C5E1D9083223C2F658B1053B054F33E88018D2501
      46B2B35BBDBC93CADD7E5D66DFA936195E4EDE886C5A89CBAAF48E1E680CBD2E
      291548B4469473F9C6673FAFAFBCEC4E8FCE7E7BC7F75890069127877A0827DC
      F6635015D2907F1F6F90DC07C1E80FCF4F1FBB4DA29C6709AD23A0BED65AD9A0
      A361A92B7F5E3213610A89C945F0705519223A1371163D527DFA22E71EF57252
      483BC482A5C8193A3596191D61461FADC4F1C2E2355B3E7F41DD5F63B792B68A
      42606BC40F698B7ABD7D2B95C2D62CE27D9564E3688CDD83F61B2B56B6A78863
      7BC74F8E8E1EFE57049AC5ABE82243B3AA6FB264474349EE9D818CDD4151E988
      19CCAEBC40328E069757053214D7E7BFE8373D22643636E8AC3782777635A4A7
      C73432FE242792FC4D86AD4DE74093455CBEA13EDE27C4AF31986225D46A03A4
      52045D140EBD2CEBF063403E5415587DA81ECA7B98681D3A29C7823CF1E3B177
      9F28D6B9C11BAC2C4D1F5EFB0519DFA7C55835BA37CB4DD22FC32C8B2689D4F2
      D274695DE94EB556293905AEEC74AAA14E7CEDB2A0C3ADC93F758D81C527E1DD
      3D8BABD5EE1B4D43AB67591728D4294195AB789E09E2BFF06E3D6F3D69EAB7BE
      42A3528C00C2425F9201C34420A9E352ABBA32734783103DDEDE9643368DF398
      012FD7F69A8A4AF63D1951654CD7E8890C22C7D6B284BAB081AFC11ACD2F771C
      3EC54BCDC98AAB91A122784EC996EB8B840BB34A5C4656582F14773323162EB5
      88A6FB0E9579AF9448A5291D55F00CEE359F240576743A4A67D455665C4FB4BB
      A07922278A988D2D415AA766829351CD3994F1113CE64A70FDF96CD321655045
      4AE619834407CFD34AD4742CCAF432C545A20E8C0CE69A86AA049994CAF0A151
      8328B715230F0404B4FC265399B5CEAA1C2548BF6EBDAB4EDCF02658BE920C8A
      0300C6E27456DF2C9544D7CC6F08FF8B918E529494F053AD5FD7B7CE20B85B2C
      5BCE14332808E1B60ADC3CEC946921142290A498E74378C30A523CD9DD7DC475
      38853EB69685313EBE338FFCD87051BA5A79568F4900B4B80E1B74752FC2E224
      AB5E4CD488E22FF0696B3964A49038BDCE42D5835B0853CFA95D8BD7058B5127
      8A39F0523EB539C1726B4EB06C20E4041D602BA387FEFBE9830212F1736C1C9C
      3CAD39DF3C10A6CEA92C6F6F92C89DB1D6302356E9C15C5AED440FED9CB3CA46
      B736E182303ACCFE5329EDA04EA77ADFFA28BA020B4FC2D8E13298E2322B008F
      55EE345EEB59F9761D5FC2BBA4BDA82A5C81BC71AA1A43526E420929E3F46B3A
      86D9D09824755B53EA40AE57C086DBC1E8B5AEC5C073A3F23D809124AEA07FC6
      DAD0B14F02B566D71D30927649C840CBD905D9ECE6D284C2F59B2FA543EAE93C
      3E10CD013EF843C20DE1C6647D0C7FB1746A43D691136CA5492179A58D819922
      75B35D5BBDF0068E7DE544BC7BC97EF1F5B370CA149917B3C8ADD93608735785
      6EC1FEC22B7C33D4028A53020A17760C04F6928CCEC7E3F514394A7908D1C1FB
      DB4F1DD4D6C0EB9666AB3B8662581FB0B3DFECD26030E834EA53D6AD09A50A32
      96181F41BFF73450215872FD98F6A64A4CD13D96465BA7CAA8C82BBD42346262
      1E61A85EEB30312437CD60583A43D93D092652B15AC849703928946050A5AA5E
      51504E4613DE9D52AB689DD5A02C5475F4CC89D398C5D455E3E03B4C87195F4C
      F35BBE179A8583BF2EEC8C78F5ACF4022389013C5F720976447B6A9C286B730B
      06A2A832316ED239435C26625A18ECB9705483DB65BBCF013FB44B91699E0EE7
      B563ADF89A667A0798B8313B45610B6E183B9E053FF1A4147DB057A0F2797600
      2083553488F668EEE03A4EA1A377D98037DCEA692E3DCB340D6B5B2C5951EE7B
      C2A9DFFCF0683D67DDC26C37EBAB701BEFAE312CAC801D241E6E748DC0666821
      90C2F70F17D1718E62701B018EFA0C91E49CCF704C107C68AFC9E8BB685F04FF
      3FA202A0FEFB00C6C3AA66F63FECB7FA491D4BE380058D9C5FA593FA3BE9B9D1
      9863C3CB4545578E121E6534FAF4CBE944A217328ACE9E65D3040E963E66AD37
      D0C4FE80167ED8B757192730B09A837EC0CFD62110619C853D5C54C2B5E10942
      2B81C6974F2B6908A2087E44CDE560342A69A42739B6D7A9BA8E7E348290A704
      35AF63245398C2D06AB8231E5D35E9255ECD0688E3965ABB0E05EC33B9D8163B
      6437039D66B143E0E2296EA63D76E103B7190535230B6E4B3D0089DCF4232349
      3475CE58B58A83D070D6B76BEBBC98972364F9EDB5CFE0766372233B34C0C307
      4DCEA4C6386410D41B1595F9606C8371D59715F669400266D3DA3BEBC9F2036B
      D3573D2ACAA1F4A78F8D11BE9B8B1C0A7016A22A697E8F991469D0E8E44C9A04
      10A7AF1EECB5703F8502BC7E4C35A8EA68D20BE3D1B2235D528C8D7300C50B03
      9E21B25BB6CBCBA778A7974FC3774AF2715C5DF19DB47077BFCD2D684A023AE0
      710A6CAE845D1467D960AB16D33C7A8D282C6A7D620D1679958CE68DC8A7AE41
      D827083D50513E965F0DA2BDFCC645545C948C71DDF6A02B8D1D4EB6AD0CF57B
      179F44F3E1D627998CDE2D0FA2B4A033C55D412C7994530C66FDE51B19DFF596
      3F4E403B12A43000EF0B9A6F6ADF0823C5DD209467E6F5065A34207F15D7E657
      DDBE66E9D2D5629B3A6E4DF00C921C5038248DCCC6E73205A125665CADBD6ECD
      B6A4F94791214E29BCE0A4DCEE707FDFB073DFA99DAB6C1B6717B8CB57A032CD
      FC0A4519C2D3BDFD377D4817DA889547D65B51C74D7BCC8EBA8B9F3817A36C37
      B6FBB539EA15CD6E887C88B4849ACC593A1B16ACF7E1EC7F9E353487F5FCD0EF
      BE23D56C5DE9A6A596F2A2C9CB40646F9923E0045A7C9076C119B8CD380D6AB4
      40945F527FA6C59845233583B5711806D6FF06FA9A7C3543478246E1F3B6018D
      C0E37532978DE86C5DA697978CCD9B639027D700F76869B987D37669AA758A2E
      DAB230FA0A6FA1350C2B8186F67739DE2DCA5A23E7C11B854B52CCDCC3369019
      E3E6B6C4B6C0F303DE191AA76E783406BDF6C0131287B0EE85C468491946E0C8
      99CF729564AB5D9C3300CC0B03E4557C6F1D1BF98E24AED0166C8AE8AFF38714
      DCA175B4BC7995D31E26120683A97E9B39AE29AC1AE9130D9B865CFB52436625
      C4A781A98D80AC3D5850D84395874030BB7E56E12601A78B3A8C4CDD8224B558
      FACB4AD5AF57585C601FA9C0AD14BEB91D9F56A30C036BC5EDF45EF016A11D9D
      5C10ED43105E8D681736827C4D40FF2EA9DA59F2FB4C81F88E419F7EF75968E0
      157EE06D07392029373298472F979D1262CCD22D5E12C4BE7D484949356FFD61
      46338F3A4274A5D79CE67FECA88690DCC2326F5FC3EB2EDE3066585F59AE5F5E
      081E503AA25808CDED7FD8DFE08A5581BA252BC00D8BEB5E1055B10EDED230FA
      1CAE8EF578F02686CE5551B03131361A311E11C5D67A53DA27A22ACE2070A08A
      D1BB4296C4DDC816787119A764BC56B5B6F5FDE6EAC2958A00FB7500117AECC4
      5F296EB40C7088ABC52777BFEDDC41FA770E9988F6333A9B33A76E79802076D4
      3EEEFB93C26712FEF2EDB3BDC46A1AD5F783685F3136092FD169B244745EB9A2
      105241174F56721E3D5DCF63BBBD6FBC3E5CDA8D9F87969AFDD2D88C04631646
      233C646EB1497B8E02D1B8D9AC51FAA0787349660C620EF1708397151AB762F7
      8B2F49915E2D1C69A8EA92D7A0F2346926F0619D356DD534974549968E129374
      C599BF4BE105CBE51152F42FA6ACFDD9FB207EC03AEB76A4D01797FDD2CF56D7
      455E575D0A8DD04FC0C3DE987C6DE9C164529853C90D0445FCC56940E19401CA
      8396493D2F250D4CD28B610F572E89C9D94171158DCBF8D2E5EACB8E7159408D
      027E6A3FA9086392656EC1F351252AF185CBCFAE41B9EBC8A4D0EA85C6039D95
      C53043F930E7C9D800AFC1DC59BD83D3E445D457CD571B3CE7C0A8B9A29AECA4
      97AC987992DA0266A421A35289EE6B92390AAE2D08BDED8C17002F3E947FE7F5
      672CFDBB2C763BE29C1894C94DAD178F3170C7492AA0408ED009EC6156B60B03
      D4388FF835C969B34284AB1A7CAB045989D6101BD9CB345EE32847CA7593F302
      A68F85EE2B025AA92859BBBE7980809D59572357ADA0515CE9C51F3298021D2D
      97EB02928C04B78CA5E5BE28826A5A9F51C82226A72418ED1D6E5652B485A0A2
      08C6BA38DE729987906AA6E60BCDAEE0F952A2C5986F0D1697C89B057C7BFDA2
      EA884D674509ED58C77FBD8EC5AB84E28AB114814883D84EC389E599C4E9C68F
      28ADA6CC3E3B5E10834070339916E58D959E5BA696DA1C823E87EC806F847214
      55AB6C16E89185A59C75DDBFFEAA42CA8CDEF722F7F9381B55BD687FBFDA69C0
      D0481A13C07549FFEED4BD573112D37A436410F646C8920D3AEC58710D547083
      2E08F8CC0031EA23AAD4B27FADE586F2AA029DE7401C3EE652C4E76D9AD79DA8
      4CA85F56F943BA43430EEFD551DB6EAD51B1ECC1582A6A55B7CAF97651A7D4D5
      7A610EA8557156881918EA5C9F660C55EADE8AC5F264D7AADB447104F9950275
      4351DDCAED6C7154E6B9FC26899AC5466177547E916A4B0AB781AF565C2B9F19
      988CDF74FACDD5716D43E7C90C41A73CAB53B604F868A480B7194C9B3FF7977F
      2073C63781B459AB55A78CEC27DF5BC11EDDC1292A2A54585FA8110B0B146932
      74E7D0BFBC28FE95B81FBB11BEE345050F4A0C490BEFF8F2B345BE58A274E1A6
      EFB41ED37D5D64E31DFB6D4717513B36DED5C524749472BE46D9EFD67C0B3D12
      8DD7AAE185E9EDEFA4C9CF4A736534C6B8AA0886A1EF77A859AA385E9A372DAA
      8D1397969963A29687F78BB1618417D917D142158EC41B1D83F68E9438A7E82E
      F1E19D5E7494153178C2C88BE30050555E3E903ABBBC6BDDB384C8C8340E1566
      5B97FF82E3C396F6B2CEA98EBD68D0200C1D8DCB62267414EC6432926705530B
      E2CC82A8DD846E0D8D19AD7E1AD8E457F34B2448749D41C9E09D709BE3CB3CAD
      E7E364078E11EC833BCCA1AC0CC319D1EE3AFF63C94FA2AE8A7C0E6F96CE7093
      FA457B3010FCDFD13947CE491549161BB43C8414439B625826F11765565AC95B
      DA6C47620EC7A5AF0E0037E76E25846845D4C94A5AD41E67C0172C8219628C76
      CB8390A784C6FCE82A4DD69DC01DE9428B3AEEEA8A9F145552569DD03B93D441
      C0172B7F5A49CAADC9D135B2157E19D5F6353450892BEAFF78CC8A84A338BB28
      4E699FFC3DCD2BFB452FF2BFC6E7E17FCBD3D622B6CF9A7D27A019D46B0E1D23
      BBCD1826C2E9C97DB5F880A8EBDC225F6E702770B268A054AA8B11445F34D1C0
      E55AB81FF44CA39176AB14146C36C1DBBF51F8DB16B946FCD5DAC4F4B8CB5EF5
      6A42422A8528BC6A9CFEA298D723D4453726505E8C6FA902D96E5E4E3BB929A5
      3090E5B0C8339C1E8755BA405194478884F234F52C91A643E9735DEC0B924D11
      94941897B1F7C9DC6E095E4A856554C74C8A66F8D410FD12831C591223AB42A5
      8930448D9211FC9574DFA8EEC8035197C0CD1CC27526DFEAFC333E7BCDBE546D
      1B3F7B3A6FBD5B99C669157526A0C850C3AF1375558EC36D5D15F645DE52509C
      DABC229D1B3BC6DC541ACFB700625EF782B97774512D4C06A9C960A82121EC3A
      6D91639F216F0B0F2531A58A4B5DCE47F51C325F66C676897869CE4D58809900
      A6F8519EE2ABED5A0DD4D6428F6512C9A6A7A95BD545C13B83C916739C7306AE
      45173EED0A048139E2C3883099DD6C983345D174372F9B13484DC6A2FA4D0B4A
      3ADB98561A53EB97829E37C10ADDD7154AEF21F906EE10463A481E104F434E50
      CEC049124FAA8ECC46E76F73DC91FC8A1D9F8291C9B9D280370C445E7BB2765E
      DF44AFE32AF9C089EA2895996ED9B0F8E61589799C59BC3C4058058571B56986
      1438F4186CF7AFA220AD82DEFB8727279841E4F959CD61F9EACE269BABD5394F
      0AEF45DFF5A2BE8CD39F21645CB593F21495893A022F02B6E8F4DC7FBD2BF2C4
      86F938FF0A43C245863AEB936B25872528A86AC7BE95139745602EA245796D8F
      596E49B0534D13969120CB1BD19812F5786223C26879464BC3D7E9722C17D273
      F84575425DC5B5B16BB7C5542170E423CCD2E25D3CA57874A558F2862515C3E0
      A11B442333ACCEC4AD12180006F30D13DE804050EC8171B6A1264828E16D65AB
      97BC894B30D51A864E116B7823FD5C03F61AAB15EC4732EE1059E8B8A63A8409
      2D5D5B0A69F53CC418A3564A75255090C3990D9C0D3301E5460F4118C5F5AB42
      2E0741BEEB321D7D41B5B74A84279C9F81CBB2A03AA7B87B75826A89D626C48A
      D727979EC9FE5E368A6E9AAD24F1627D717F72BA473C9EE7FE7176C6F8B713F4
      61D154DC0887DF57BD7191AEB444CEE5BD77F526B11E19B2969ADD7349CB9DAC
      ACDE6D9AF1B19400872A19D49069E5204AE2C2A052DF1E618578C8B31579F9A2
      F87277B7BBA3D70AA4682A167AE804AA762BC3488BE52F09CACAC13A2913789A
      963E1EB6121C7FD6CE207AADA9DC9698CBFBBF203071BA777E1155F3A19B5987
      FA06C687C629F95CBABDD0A1B48A6B8EC12AAAE47285F3708380ABC42D54E5CE
      181FF35CEA750167C1F4700DE1064DC4BE01BD37CDA39C399D3B1CFF595248A1
      5B52A39C30034A732433B355E2DCB4A9C4EFD72A709853573733AC0ABA41F94E
      7FBAFB5AD266F5C0925510DE8CB1BA68CC866578C92AD71CFD788C8C4ECD0803
      FFC5CA172451676F3CD60784B1C23BB2469635CA094FDAED92685B89128355A7
      74A9F86A7948253E673BB8FC2C7B501EFD364F2A57E0D7BD0A4DAFCD5E66B5C5
      4442858F77D8AA37B268B8F899B069951D483BB68BB911AF22DA2E3FE4EF2412
      91FB6CF2BA88FAC73FE7C5F5DFAFE2FA787A50A4F9E5207A0F2A9056C0740527
      1A92D938A534D4A52A459AB896336FCD996CE32242B182E81A4FE05F50AD94AD
      DCB560B0A086B2ACE88A5505AF2DB98DCC4333B5A4D528875F7C3CC245B54B21
      3E9F921D1078703AAF464ECE5186C62D82A50849F895A8CB5589CCA2C50B76A7
      E3D62C73BE6D45918180375DCD946FAFC8A59D697C07A6F407DD38F48868D9EA
      1FEFD91BE41B3D0B5014350835C01B4D514C73E2BD12AC377E462E89C476B4D8
      AAD4F3409AA7DFBB5982D3517140751AF224511C62E80F472C65129BC6A2716F
      D29BA1F44DCAD2B3B8E625B8AFB6EC8E7EDA28026AC8F6164A4CE28985B2AF00
      8757B32D34907FCB2F0D8C6F918036903B40F68FF99D82261C9E9F52054EF695
      2FBB22B9175E364DD0651EA4015470AFD2E0EF69917E4826D12FEF4FFEFDC3AB
      5DFEDF93E79F31E0063DF8CC2D2FDBF96D6568C43FB6AB995BF66096E126E2BB
      E4F1789DB009970311048205450B12FE54C120CE02254C594C7E21AEAB9D148A
      7384466B5DC27742B73ED8253586E84CDB81E0AC2EB5A0578CFD5BEBEE602C28
      5652D98659E7E62FFB6910F9D35D47185DE2B00D26953AAA42E0A67CF0749810
      480C4CAEE4DB9A24D0050BBF5115691CD7B15DF361F5DC24AC1F1047BFFED79B
      789A2061E4D7FF1EF8B7B21445BEDE3059D1A915E37B91CE361E507E5711A576
      3993A5035BF37086536D4A4566A74D6374B6D8C07B740DFBC3D514DC2C338246
      26F73C9E862F43425818208B9377F731324ED1BE4BEF29F26527CA4A4F4B528B
      6E67CE6992279B32F38C3156AB540B7EB1240FDA670E7251D4BB9584B4DAF353
      3ACF77FBAD867D1906391FB4AD67AC1F82D6371FB75F3E25E5CDE7680986576D
      47746AF6CFB368568AA1F77F43FB58B65EC4A8AF28539058B55C17B389303ABA
      8AD4D980CE91268E10455B1A6AF202475085201F02E63C8C4FF2BC95CFF7D469
      A7FAAA59863F1A62825468DDF32B5F1871DAA52F6DB11CE2C182252DBE605873
      852CE4864C7DA0F5EDA09690DCDAC8EA0B503A13FE4B2722819856A27ED86093
      EDF41AD83C5D3FAA8039AE45830E64142F3BB25B154D02A90F4BB912F556EBB7
      15AF21C42AAA711A51ACEAB89E571B2F7459E1BF8066F35920EF3F7C7DD3D170
      EB3A9029B62A6281CE40A871BA20E71A96F2581A6C5AE4395B75090BC22DE829
      E450C3E716F9988B9C02FFCB148C9CD9A0E1D88EDAFC1D1762F57E7DC7133AD1
      530B29DCD6F660FDC8E15D6CF4966C10FAD2B2A77BD1C7830F3DF3488E2F4E3B
      5195FC3627A24FD36626F6D633D1EE6F9F1E4A45719EBE4C15B0368474057E6B
      2A93755E9F9D9F3F3E393BBB708194E84302ECB5114F59F992B236C5AD92C049
      93A33E2F735C3293A8734ED9CF48A2225587AE60923B7482340D78F48E34EFEC
      9AE38BD376C15A515DA6CA55E738822B1FC1978F8E1F4D23BAF31AC6412386E7
      18E924BA8E4B0A25AE8195110EC3A80B162D314239D66DB00EE26B94F129C764
      F331D7C6DDA8553187A8425AE600A8B23133B225EDCF79719A096E278F86E9B0
      0172D0D7A2B4AAE6AEB0BC89A50720FEB3C1D3C1134DFC7688E6126AFC02E232
      49BF991754CD134354D42B80B767AA3EC1FD838862983DE2484E1A68372A9497
      975A3CB74C69A82889343174E2A851E6B99A069BAC6972B1030EAA04D3418F27
      4AA45B08F51635A8DE6412AC2FA3D08C02873D9755ED20C259598CE7238292E9
      84478A642AF136F08839266E1AE7F0A7A7497D558C713939A56B1769D7A30F23
      1BFC39E09A7F3C9072050AED1D5F9CDE81198692328FF24707603DB1AE62D170
      F236668B1D2F21885964A11DE1B9D5B86CB40EA0354C28502D2CCA7C37CE2F80
      36AC4C06F68059A634F673C659361F8C53A81CE0922FEB11EE652850FFDB7C3A
      8B2E0A579E79E31131052311FE5EC69FD337D2A9A49A976BCDF222EFEAA7BE8B
      BFA236D915B4931D2C78D7E22D3D84A6625ED7C9D8D568C33FC1F102BB4BDD99
      C0284C7EC342B66C63D3BB0C3365DD33F5E40E533E9CFB946BFF7DD513398DB5
      69A422311E344EBEF9D083D023A926A9FB6D10753F589C68E14291F303370E02
      B193C96007A99E6867FF6762445C6EF1306574A9BA9A4F262CF9138BEAA59C1B
      81DE492B5DA3D5D95695DC32218507A7BB0A4F073183C6CFAD56A972832E7356
      F461742ACDC12711843D0F6EC2777B9F4EE516E4E2F1169EC8E6F6A24B4031C4
      A5C7735715D09B9BF37282CB07098142BBA11AEB9D8BFFF4A4C46399A2B64231
      41ECAA4E473A42BA0A787D11950FEB95E29BC9B7685414E538CDC92B0DCEF4E0
      1B5A697255CF3E2CC6003D3AA0DB438079468CE2722C405E23C6CC956F8B724D
      A468793C5B3C6E3B052E9A9B8043C259EB0E8B1AC448DD07ADCDD290970E3662
      30A0B25577D0E43F718AB8009E239CE9F782484D4F44CDC81CE29B2A9BF50E98
      A4A12F57F39AAC59F527F822E51CA2F11BC0AC4E8F35102A7564480967BA1461
      FC02A9229E95C11EF4820F111B94E78562692D7A3BD2ADCAF4F20A684699C3AA
      7617B8EBBC0219F25C9759ACED35704E9593D1AAF74974F633ACF6BA4DAA8088
      E27AB24D2EE20DD11538F5B92BDC62F9371AB40E46BDB7A2A3A260E56663898D
      846B38CDE7778A3AB994C1BA408C68834CC8F0EB3E4A82E1664D358071A192D3
      DBE38BD3C3CA2069FD90D9E3C707D1DBE34B38CC1730A834F0772887F04E344C
      A036B56EA3BAB9B6A211EA5B30CCCF84902E8FED785416159408AA257A3EAB07
      488439C74956C722052DB6DFBAE1DA8B3AC16FE86039B111C568651568F24F83
      10C603CE76CE30A9AFC965BC2E3C7D004AEF62176DE29AF248EB69E5C9A01E2D
      3CA55252B03AA70978F38457D5371E809A8570A6448EDACD877E7F602BFB97EE
      2D68CF2EB661EC54C9022B9D99188EB7E351096A695AFF4DCDA696D438FEF234
      1F2FFFF26A28D317150E3B214C9240D85A5EABB5234C8C34E49BC14108BAE1C6
      4D084A36152B179ADF6871F52528C49294ED17A419164C4C5BE14A8C26A3B106
      8D6DB4D3389F8C9122D030BB71B4854657DC7C312021FBB0172C8320639E0089
      94D69BF34E74CA44DDBF4687DCC0E7A3B2406AB1287350A5C37F8BBB054511DF
      24A32F08BDD4B210E5FE0F5E0FFABC6BFDC2513123F024F5A3ED7DBD145CF00A
      1C6671F7E26AC92A20C782868BCBAF342DA3E67268016860E898282062A1F64D
      A7572B5D74C2CE81FEA22A8B361A378A4EEAA0AF6EEB254AC3658F2F4E7D5986
      1D7FEA60D15C17CD524E4CB815E157E7836FBA9638D20C688B85DED864B81DEE
      72245E2D9E4B1B6E73B1F2D0C4742A590E6C66E1ECA994D1891157435C125C15
      1BB2D3624DDCE9C4D966ED3B34BCAC82C1D512481BDD5F6DCA60A06707097164
      EED6714EC2B71EDDAD5794A480861656F376919F0205926BDA59431A9E5B9DBD
      058267255ACF9CC6D362BCC7013D2DC6AF1578177592FA3DBAB4F77A20DFB92C
      6A1700C4B7F0846BBC09C98D97C0128108210A10FEDA49146ED23B3D779B6312
      2E306C586ECD603B8AC2CE9EDE706522514B591F26CDFF4ABF7280E74ACF4855
      7FDD6BBDEB66CE885610087D924B1CB32CE4D6D82F691EB6E952108DFFB5627F
      3598D37A5ED9F8B75EDD10D9843A23FDE14DDF458C79C2498A9D6828C938C900
      B63EB73BCA7FDE5A077F87AFCD54758D2062E9B5CF01B7A01A63CD4354392E2A
      0C03240A6E2A1EC8932B1C2878791B4FCCEAFB3A946A77FCF97949A780E9DF9A
      560DF884891D726EE22F5D4D9B2FE63547541755FBB4D959523987543757DBDE
      81A278ECFA231911009F0F39AF92C93C63CD9E185B5F628D2E2C225AB6C1F315
      1331FD4F93716ABCAB5AFF1E4D0D54428D39674691D624242FAFB84C08008205
      C299B70BACF5740EA51B48AD45148E8F9EEF02633175471FEDE365CD418BBAA7
      B163FF897366056103035C8FD13041DD87498393A44A82777755658CCBA5A699
      95081A6C5E0ADB8CA709ABAD793A7DC08DF526D34A69493CC8527DDC63F0E4C6
      23C262A63D2086E9D73863C4A5E0B06DD284A432B52DB976D16C680F6319B840
      90954270CCA16A9E0A9668442D482B7F696CCB662D013CCE2DB250A4596D5606
      66361EFAD7040708FAB134C5DB249BF5A277C9B779755A2007FA4D5ABF9D0F7B
      084EE2B0A544EFFBB82E13B8FFF1E56A1D097BFA6DB9872DE8C3DDFA88DC5CA7
      F918516EE9D87692BB781B88977BF54D0EF31296CDA64F7423A3AAD3FEBF3118
      FEE9A83A054CCB151A8E6B5E0212B047A4CFEB8D38B2BF15858AABED3A277315
      F5E5CE71A52958B34760851A11CB31C47D8A1953B2834BD1FAED013E89254ACC
      6DCB2EE9B2D1D19277B6CFAAA4FC8A53F14312677D1E6723663BD286E6C124DF
      97343FDC8EDA731082A343D03A106A81F9976448FAD9AE8BB69AFBD16136252A
      55EE7D7C54355679B06C502DA9B4D3457266AA229BB318218035C9D0F7B1E222
      BF447C379ACC5962301C7C1BF4CDB7ABAA3B92A1B1B1D0A42C8B0D730B9AE170
      A3FF5ADEDD52C73DDFA00597ED1B463CFCADD53920C3D737A24B596C3723CEAE
      CDC23373BE5149AAD7D650696A407B09156D53F152D3A0BA4B4D333D0B7ECFA1
      DEA891BB8EB63FC5FED001F7CDAE1EF38576DDD9092C05EEE534CD0B3F4C5D26
      8A3F1FEC0EBEF5A2E783A7F89FC160008B53AB2F558E686416A140733C85BA26
      A89F9AA1AE123EFAAE8E1FE556BE60DB2C3C1C24DE0A83BD350D2EE1443341EF
      00E5DA81542653041ECBC620AF8672DB1A422E31F42ABDBCCA7805A34FD6824C
      C7BA59208F41268EB25929B590743CD992220D6EE1410A53C4901CF24D375749
      B42C3C28EB9E49D7EB3397419FA1955462F5A07E4F5E948E67DFCAFFB5A26DAE
      7B69800ECF32C4AD3841360A789E05AFC605A280FCB35FB5B0D693721AE7727D
      B79FBFB2FB9ABC63916BBB50BC865C70510CA223B93C640112C750C313A92095
      2AFDC0DE74FD4D6609D46B64AD899C1F222D7A6D39D06B5A480E1E50A4799ED6
      3777A10193E2709D8E51B71D94DB75D3B5F88BA82B1B8CE3066DCD65BA9A0BA2
      93664C5A91DC75CAFA59A64DAB251AE3BC48A7F3A976A598445771A6F8B3C660
      F54F0DB2A76ED9D58D39194D4BAD5692C27616ECB975472A021929D6B2DAACDA
      F926BD6E0EBF2B4CA556AA53FF20BA22C9EC226C2B899974F2BDF727D0CB56AF
      749432F55E4DC23A45D564A5CB74435AF78E4FF66ABE9E857EE026B8DA2174FF
      C1FD908DA8D5DCC6513CA574B61F3B4B476483550A49B00502A70D8AD23ED415
      21DC8A5F6CFFDE1758DBF2E26EE909F5C1939D97778580A1887E708378AFC189
      7DE451352A93246FBC219B9145E880C8460BC238668C6221F27A97573B9F0241
      EC03811A8232A15E857B6B723264EA07BFFB00E8EDC46ADABEA1601550ED2551
      72F7284BA56442D0A186CE71BEF0538DC9AF5ABD54332F0B9EEA482803B47155
      CEF32FA8EAEA145CECA178B720936655971E6E7E57661AA12B79E1593964FEB1
      6473595CAF3DEB3B6B7EDFBEA4A58CEAF8B1339E1A8205AB858837A032306ABC
      DD117C8CDA85521C5E346EBD7C83E4958DD38A220D608823860B0D5EA509384D
      2E1C78C2A2C71BBC4EF2F432F77F2D107085A18F69BC4F0D3556D9C3AE319AFB
      AD7D35545D52E3A5AAB3767EA717CC13BB24BFD5126A4ADCD8BA830B2AEE4166
      E386E3776A927630B0C335B67620D7677ED2524CB258135199F9C37CA4C63E72
      718B3BE63D3514E551FB226CE7936B67594294CF2131A6DEF08616F5B44A469D
      DB94E575EEBEDF5D0FA02BEF5CCE44F64544BF68D893F923524848035E321212
      A95FECB77863C39BE84A0594B9A7A588665075F34B7243815D8EBD53F3108F4B
      37BDF4C9207C67E3C453E6D2E14BE902F6D98AE4A9D234349A8B68D74C767965
      A70B41A80955E38CA3D4D42530E52E3B6F9D18A4ED36191B46643934DB241FEF
      65382162FC7F296B5D96F18DE39E6F5EB560DD8356562480D0E8A6876B0FE2B1
      0AB8A3894A277EBFC845C5A0DAF1A529D09BB5567B7A99132623A05F9B90C0FF
      5AF9238104BEC560DAF65C661303231C0F60133A4B3C62C2A4285453668100AD
      F6B632CD682F8A5E47D1EB95E87714ED47D1DECAD8EDAA3F6A15121B061BE650
      05045DDEB4C36BBABAEE6D56BF47B4FA55C0CE9555417B2A2D8539D3350E6468
      46FDB591DCA98B867E5B57D6D70ECE8CAEAEA11D0D29A8A92EAB9BEAFC5C8A24
      D12E5B6C2B36A1662C625BF3C4B9D8E05C3F0B654BE3612FD0986B5892A87E65
      B9ECC358E37626DEB8817B798CCC9A251249C31BA9A017E7E3C7E83782C6EBEB
      34068985341BBE40BC26D08C34B137CD719074418C8B44BB1BC1029956DCECB8
      4268A6C3C817B9173A6C45B136B55986077696BB8BD9275E195769362E93BC17
      E1E521A023D17769121240FA316E0279092A7704491AEB08991785696A5254CE
      03575F921BC9749E575B5A91C82D7E87E5F87F3980365F3A0548F3DAEEB175F6
      DD277B2267FDDE8F7472BAA06FBF723DEDFF648BABFF936FACFF5353AA77AB16
      838ADAAFC4E6B0466F792FF4EEF6663750A9D1022032CBE4FD2AC1ADF1D4D5E7
      2941E253ECF28FB3C7E87BD48587B28312E1E4DA5BCD70FDA3AD2182C96E81D1
      05A43412FCC33ABE098B9DA2A37A536F502D0A7A39AE0B5A20FCF65651BD4364
      1915669373D49A5B1E43088208665F1CF1916175499720A7E3D959A65E2E7567
      352F51ED3B35C01D759F3916E3D07464AEB458A1E21FE29DED65371822AA6AAF
      1B087C6976EBC8AF47442B00B3140D435A7B160F13292CB362C52E9ECDC14FBB
      3E3E6177E252956C092A112F6966B31854207C1B879B588A11C7E2AEFC9A32C9
      92AF60B2816113403E6DA3250FD68374A0BE992955143B5C806A6AE73B1A1591
      6A88384A14F8EEF3A0BAC8D02E64D56E9C8FC831D0A445E5A03A8939496BE8FC
      729024B3CF226F11680B3C86350D7AC53AC63C8DE12021325E7864B7F14C553D
      75CFF6C57384E3D8A2C0C20676F87E4325250E6AF63001564D6F155B5558298E
      FEFEE1E4801651F4E1F0E883FF1CDFDAB124492F981C58004C2CD64C5ADCD10B
      63C9E539B89B82A085BF35402340AB9C07A60A230743B5ACC520B3576679757A
      186E1511B1B5EC616E17F3F00C50473C0C1C09D70303178DB22235E2A5D48CDB
      6410DC52C1801D95175AD6A555299F3EB1401EB4C64CB1404E67DAFEA1E7DAC7
      595ADF445D51CF34F91C7AD5923161E152CC7159902BB7FFF30EE96F589ECB14
      D599C188CDF8FF9AFBD6E6B69164CBEF1BB1FFA186BBB1A6A629CAB2D56EB7FA
      CE4CE8E9D66DBD4694EDBEDBDD310192A0843109B001D0B22666FFFBC6399959
      2850D4C380E6C6F4870E4B228142A12A2B1F27CF89C7DB4F6F41394AFF0EA63C
      B4D014E1501FDB500F7EF1098A658AD1822FF800F19546180199BAD24F69C618
      72454B7A7822F59CF9D5C3D30A430DD665F74F7E0D85841C08473DEB619DC54A
      60FB748289FC53AD5D7005A10B9135181DDA3C8F27C91DF1C3A590447309E8D3
      5C8E1AA0C168FAEB40E1C8F13BC4231CEDCB8103735371DDA99D86C10FA5B155
      42C34CA82A8EAC96005B71A430C9821B7926C2DBB8ACFAB2AB59AF713C0A1105
      317895B552C1D1327E1829FA51A814B625FEA969689F9E5D9AE21328696A4C4A
      1A0FCD14AC564545FA3EE4A7C4A8D6D0B2F9152D5A7A4A8C960E1ED71528D4E7
      3857FA80EAAC7870DBDCFD5EA7EAEE0D135DD6FD224CC3F78EC31F504F22D13D
      0DDA824034569B64BC6C1B18E6B9EA2E09B3321EE45A9B5E35BE4F8125AC9C82
      CF115A4F85F19584E152D9B93B86DAEDB49146B9C357736E33653CE254D5787F
      2B566D1B092412B9F64C170E18EBABC47A4946D759228DCF9DFF023F84F4002B
      0DCC69E67FF1943950DFA7AA00DC6DB5B12958F950214CE491A7D32399EE8D31
      5DD46690C97CFDDADD6130A183CF3FFC2242B13CC6464F70F8C52C137FB77C88
      F4D8955B73D7B0FEBF6A1BAE524D540A92A0534EF2144B2AD293D06B30451179
      527D2DD51794284F37CD74BA3C512AEA5511EAC87564100123D4DDA9B7A9949A
      FA07F508F6D4231007A7EE4F6413D0136016E979444A8115CEACAFE9CD16809C
      7E45EA4D7A8BF4C847BB2D16FCC1E0B8F374F27890EC15770E6EBE427FC0FDD9
      FDEFC3C343E9DB29A10C289169E50250E48A44EBC1B1F81F7FE2D7C8D04DA330
      89A03A16C2E6CB0C7390DED6842F74153FA1A7EBDFF274BA30BE6DFF4EF26CF6
      78B3B5169454FCBA1269B4A72AAE23B062601378AF3208211FF6FD680FEF5B2B
      FF9E53FC30DD6E25A11789B805762EBB9DBD4B49EE0D52909BE64968BDC42ECB
      9BFAAA3AFF3B72DD0B796C20C489C93C3BDD39F1D9B1879E66FD30F9720EDB51
      9460FFDA583FCDEABFC1FB5A97BC3A2E2A1FB09FC2DB1AA38B30F013001278F9
      9E3180390ECCF94CDAB01517CD66ACD9C1E024997C1D906D1ACDC5373E35965C
      CBE43FECE90494BAF605A51220CCEC97F5DF5C713B1B66D34A272500248EE4C6
      62711E112690210A5B7EFC65AED4F2BECE2F314E40832FE7A9655E68E9484BA7
      ED735245A546959DE7B46BD0E1149F04516E965F6594A1AE15A5715FE4F53D88
      50D72709BE33AE46CA87C0F6E77DD715575FF33CC6A4A392703CA56066C75EAC
      48299FABBC907142CA1FEC9B060066E9270994573CCF975C70B90F6945CEC6B2
      8B16084B829180564FD8B14EC28E499E69A559C5B594F1C25EA4BD1C69235F7E
      1DCC7C553C30CB9432269317BE2C1C43D369C59CCD8F8257C45F05EE242C1329
      C12CAD819CA68676E33B2FCF3ABA96D17C4F6195098348AF89C6E7B239087ABB
      659D060C697E41B28DA8FE7DF970F8753FAB2B2EC0BE4ABB836E0BFDBCEC0B5E
      B31BA48EF5E52A945B5185822DC00CAFB8879F6C5E4BD07F22972C8CF0B56BD8
      733C3C87754E7FBFC234F9F9CBFA6F3DAD5C85FD97D5CCFABD2F59F1B108272E
      5F661C17A4B054FD72CDFEBE94B03E2CB5325725398662252C474373A4B2152E
      64A47E846686F777AB4AB981E89256EF31EC7ABBACD08B65375F01843F459247
      DC3227676FC0B5FE2830ADFEED8EDF7677954AAC545B81A61274C87D791C1261
      A21068A80AC84D65F5FC85BBBACE8519D3A0699AC39290B547C41F54F0E01BB7
      F935C5ECEA71F458A341A85263C611FAD8CCF913CEC30F3C0F6D781763180B42
      A2200D57DC51C6BA4732E43E7A7501D7D4504795AE31F110DA87591B9366DE2C
      44CACC36916EB41A1EA5412907B67C05FCF9ABC530C66E12C7631E869A21E36E
      F319B2075194FB2BBF81A692442C5AA59F16EA23853CF33D2D9A527F831D300C
      449032037557A816A61E4B4774897EF137FC4D8536E52B1E6B91665A9CB1BFF8
      E3779A31C45491655368B63679195A8D1A0AE4392137BE2E0B055D8FA225CD84
      9024ED49452BA236A5074F033CE32981DD5F9E5E3840019540664548DD9A88EB
      8ADBA28C6748553E7D41AC63BF339D8A4E0B2E55B4A47ACFF7B1BD577D3F1078
      B1849ADF867704512CCB948E9561CD18BB3DBD3771C8885EC5CCD792CD01B935
      9D431E48C527B0CFEBDDA85A18DC8FAECB0A0AED8A24DC4B1D7E458412CDE263
      F0186E80D40FB51BFCF430382BF8A02528B0220FB7060766D54DB9F4F15C1AD8
      FD35C951D4FAADC931A86483D692668D659AD1A97AF5F517E80016645AF5F750
      B4CDFAA3969C2D13B8AE66E3618074E73C2AAF3BC41899D667C5AC600530ECB0
      C7D5DBECD620B695BAA4D99D15D6DCD4E592549FF4DE86C7A0E0E24F964052F8
      A90273F5EC4FAD9F5AA0D03E7EE402C01B43F940227976C06847BAD833A15BB4
      8A0CDBAE1EA15DE6D6C4D7C8B5596DCF6560251C685431E322D8CDBEED66A9EB
      E1CEDB4ED28A175C89AB95211A6D5EF25A77A3D127641F290843A9B5AFCD02DC
      15ACAB11B82A1BF797875BBD7654C2BCE2035D7D8DC0CE9AFE45104D867C99C6
      8559713AF0353DE66B331327F41FA1EAA51737121DAF204B05694163EC56FE52
      F5C00DA113FC1D85672820A58FECA11D49662423378B3180A498556B2328A86A
      AC07B74A51CAD9C46BBC85FEF2AA2982CE96A7A0F0A421779D4C214A4A7D14BD
      1CE2E85A5D01F8A858988877AE301D5AAFF443D5804A18AED5E57D5995FA2A8A
      3B12E2244AB5D37C0AFD0696C9EBE431C0E5C9E7B8B3629EF4D108C0C4C70BF7
      E164671FF4A17390C30ABD1427A333A0F65F07CE556787B0D26CE2EC97A2A9CA
      2CA0305D854729FB589F749D1EA5AE3317E5C3A4CC51C7349E556018418E0A0F
      103E3432288FD43657F3BE42DEAF8B875C03135D32D71D183C71E84ABF3F5206
      D81DE90B25145EB8B9018B7AB8E2BC5C3E384A27998FA1625159AAD3DAB22E72
      CD3693C2DDDEDEDEAECF66EBE3B17B5FC4F9B6FBE28E40B0BCED6E317910E875
      5D9C40D3A97BF915E1E27B1E943886B2FC689FA0D96974A52CFD424A9A4A7DE3
      117BB2CC2FBC7178F6DD1B77B07F74694F19145860772A28989EF851D5AA32CF
      932CD782CA68EEC58B1E3EEA7CA247D28975C666DE91B43E3C5CA1D55AA3640B
      2D57A45FEE83A3E50EAF904A8CD98C05CA2334869E6CDB924010D92613AA7F3A
      89FBD832D5F185348BC2EC530F67EA950B3BA4D3A18257E107E695616CBA9334
      98F01AD3929F9BE599611CC0447B753769CD53419865CA257E8B0D21E2D954F2
      081C5D2D21CAE0E3E8F2E4ABB0E73CDEC9B12D2E7C54C61BBC338A26D1E7F831
      9CBD12467BBB1CB228DD73E5A4707F4BB3F26F41665A76700000E962F54B908D
      BCEE5A5D90D4E6A00628A98A3E8F3FD5D3A7482D13EA9040B751B1F5E20CF6AD
      CC08711397BCF252BB40BBF5DCCEDE8F171205F7DCF1CEE97ECF9DBFBBD00F93
      FA1AF469B822FAD0CD166684D576D76A7AA185D8D1B5270811BC3FBA4F7D0076
      B9FE00B834A840FD83042EBE4234F0A547154A776A52E0A10CB8F44CB1EA2D95
      1976CCA1009AF1F0F9C67DE9B9DB47DB066A55B30A9C5AC4518E6C0A3BA8AA97
      2F0F89AABA701BD57125B23B555B93EB04D90583F508491FFD78493AD4AFAA6E
      CE842EAFB8D1D2FB94C6014BEC130F4D46B7CB6F68E542F1BC83BA60EA07E8A3
      34F5B8A69CC1EF2EF65D9729286A5E181D1E9F570D6BBD8F731EE782D6EC5556
      E99E69AF156596013DC11493BB24F042C19696C95D8A27F47EA99BF0D076935A
      7AB5CA58584DF41ED81E9E3C05D3AF5187771DB93E206DA069F6A8E4F79E1E13
      0A6C81326245168483924BA44314BE403F81B2EF8523F72B199AACDEA004055C
      241412B73992928CBD82C767F9C1E905F99EC8362B174F5984775744B09F5AE5
      9EEC8556800E91FF03AF1AB69985EAAC0A94AD4AD7DAE9845624EC552579944F
      09BB1BDF97BC14BE0389FEC2C53A5C508807C483E1A9EDC7CC93BB5A41D56C8C
      1349E55172468E5EFB93AD1D159EAEBE2D06899BCCE7AA0D7D1670730ABB8BCD
      10F61113B9F888AC4948F04A0BA8A701D5BD6B3829410BB0414AEB267C627C01
      660A7F4103156BDEA527B5AE2F8EAF7074772CDCAB5A8A1146ACE8C9A5321292
      0C52881299F3051200EA533E7606DCABD888E502271D0F3481319D2605BBF46A
      A1A8AE540A814F986F87D37A7718623A3C437AD5CD698493225C44547855FC13
      89222D0C721DB1456C550EFF2EA555009833585B2454D6004CAA051504583534
      E1F863770388C4B8E32A0FACBAA2369AD4B25456D1AB3A3B99CF5DCC591FA6D0
      4ADF757705F14135B01A4A3F8011540F2E765276BE6245EAC0BD1B302CCC1FAE
      8D4B079064E9EAB98034838E8A5AD16506D268E52AC45FE4CCAE2C5368D63860
      3C1A8EA1244367030D8B167AEF5A835A167289F2B76AC3BCA7C0149A369D63CB
      A233EB689716AE32C2A7B102C472083C007D89419ED2BEF184EAD6D7A83788B8
      9E577D52A9A65509DFA7005658FFB44B861EED13AF6D55E06B62DE491C2D4D6A
      7A8939980186F128C2290172D36C1653FBCF7FB092D7D23D296B7419DA532B63
      5B9B8C86D8C9170509544739332E4F9FD5E3B3FD7715F5F783198D2867CF8A11
      6FDDCD58EAB590912512036A3850E8C9D23F3C793CD4829D4C33D92CF30CDC64
      427709FD22EAC664AAC5F2A0613E915A9CA2C9286A64CEBFBE20D3B6C1A12832
      2C4BB7D53C63D79B08F883A7D1696D67F9A4B52AB67022C6E8B6AA3422AD2E18
      DC5814011E4E213DF00837354D9A6C842C9F9555EB33858C8AFE5835643CA1F5
      18C9BB4F2955D3EFBE8CBBAFC20B2218E5F22E2C61318E248BC0AAB480BD2780
      295A76161282F2FD4AA5DD2C9117C4011D311C89AB940022E63A69C67D1E1579
      2049B044E96DC92E6794CCF199619E7D129B294C7B5141D652D95A78409856B4
      50E048FC0AE1F78F99082D1241712272351B556397FE06EBEBE27D5A1131EE4C
      13A6D9DC5FDF0F2ED71E8B8E9632CB4B9530AA6278DC1213ACA4B51B864119D7
      86DDFC7870E9FE14D44E64349F0BFC696FE0FE446C9D962FC3BF1DE36FC799E6
      2BF897B57B42F9E22659E6DCAFC6683470552C1F4E9FA462EB1368DFB8A7AB09
      BFD3F9FDEACE48D5649644302BFB06F67FA24CDF8EB123B00D7B29075F711E48
      601552D664B36136CCBE98A0667011EEF469324BCA65053BBD8A7D97AF36BD9F
      9B4078C1A2F456578E417281C67D3C92AD051EFE149721B0F019262A74647730
      87BD7B7A29A87A63D7A817A160DF28D0212D94AE3BB0CD3F4E8A51946362ED2B
      55A9EA612BBA2C67467A4E5071FE773C48F808D2B5906934E8C33DBD6BF838FA
      12543ACC101A2235E6559A05D7A9DF66ADDD3250C8F8A8EEEC93648079371532
      8BEC8A1EA44239E2306203D504C3BF85F687586A8D6E809AE6E5EE97155AAE0F
      39011C03CDF813F72295A7C66025DA198F05077D343949A832D78D62A492B7DD
      D1CD10FFF8C145857C043F61476C23DC4AD2AB1F5C34C8F252FE586CBBDD2CA3
      8CEC9FDC251AF57FA0B5D3A60AE3E588A66EA81FABEADD779BFCBD68048803AA
      B0C0A08050CCB2F61736EB4832E92B1FB958F1A8FE612E077CC662ED077C4102
      7783D7DBBD5189D42F30DCE4D548216803257C599C51262DA415D92194C53782
      E9AB7550F79FF624BBF155920A80BD1B2918910FA3FF5EFBC114CAF40B07E9F8
      E18F2FC1CC4D4F5A4339046F96875709E2E16248EA14562395B2266080B85E5C
      81DDBC9823E8C60E30158F0DD9944CECB2E66F2C3F8FA55CC3113E8DBEE873F4
      2046AA2A67722EF6AC6DFD8787BE34C4CC3FF4818D8D7EFFC14709DF5D3584B5
      07EF5A3E9CF0DBD8902C7F94DA43DDFA73B1CC82077DE822AA98FED047AA55F4
      D481C7E9B8D5DFAB157C3394B69903F8C17BA0D33ECE469F96D7F9DD4FBD4FA7
      FCDC3DC4CEDA8BE3F9B9C50334A5E730015E9180F9248DB64B7A95216041A064
      225CBEB9C0836E12561905B7104A42C29D463B5805C99A3F724623BDFC1142EB
      03D0D7F6DC0B24177E39FFED454F0C2FEEB9FA339BBD6FAB4F2D4D05964EC4B2
      551E9B5E8F1DBB6BF7D67D02C177296820B5F5D1FFF2C1E750B38362A0F0F4E0
      25EA2F4F239462E5D7526261B916528482C69A4660714A89A867BBA678164C47
      D792642806683FC7934FD4DDC55503AC92885E0060BFB80A037EE61DAC9B0538
      401C23498AB0109D94A22D96DEAEFC9A79089633A2176FD740D24B41834BF9B8
      A7F227FDAF6FBFDB72EBF086469F985305DE42956738D74ACA527E5365A39ADE
      E88D5B374563BC2506B11413905C69859462B86E7A55022321AD4ED31B7FE7D6
      DD3EF51857DCF6B96FF6BD5B371A769D479640E639DA90E952B8381D654C3003
      550F0CD1BC42D444857B7F79B8FE56C409D647F3ED4539597FEB01560D87F5F6
      35444AC6491598682A20CA415C88BC304B21EA270B7DB725C8E99B37BD319617
      3B8695E5012C6BF41C580E8A67736002805A445AC3D3F455E93F24FF0A328BD8
      5146CECF20E5B1D97468DFDE79555E4A57A596B21470114B9D53AEB0227C4283
      4C9C33922C9272B10296FF1563C1E6F0547155F09B606D66733E32B67C51DB9D
      4D6F860DE1DFF5109A751334A7D9A5454C0B6D7C9A7B6D7A9FB778F7367CC2F6
      947A75E4A940B2593606C348B5039EE301B1096BF3F6A270D7599EFC0347F454
      1B4100701EE15C47929687C7302BCB6C46E5482CB6DB86B7FFFEA55BA7CD54AA
      5ACC2121936198338E651FD295D6A6A764424D47C8710397D0F4F6D8721DE49F
      D09AABF8F330695F689AAFD1F5BBFE9463684F3DA6351C211AF1586C04EF426A
      20B64946493E5ACC50331931AD6F604ECD281BEBBBB846CF3A36890E37B89AF1
      8F5563A52CAB3498253928655CA772633A21339DB8705D9F4ED5F12B130D957F
      9B1DC65D41A390C958D5AA30FAE328BD5A20211E98056DB0BB411E389BB8BE9C
      2CA256C7B8B43F2CA28DFE307AE500F1004BC8730EE9FDE5E1DBEA18833F36D5
      E536D643AE506C41E42611B6DAE85300C04D26FE53D2B5CDEA4132E6759F739C
      793C71BEE9898D87CC72CFE259263465F741295ADE579D512DF156EF8D324D58
      E7F398654C24CFAC471979285A1DE94C168137C4235ADF15B0AB945516A9FEE5
      59079D129FC9B6FB20955A95C73782D2F8ED5C31B82165A3EC1E2BF82D713348
      59CA1B3D7254DD5825ADA1F7FAE6254CED0577BDE4E3D2C5746ABAA1F3B9272A
      1327FD598D8ACFFA069C5F1E366EB6819561D47FF5438BB44CA69AB3B21C2211
      8774E39753586D87F8CBE1D9D66FEE10440949EADE1D9FED52F22ECF9EF93E0F
      594CB616DF0570098005869753645655481C55F1F5EE0413DAD84240E6BE0760
      4E57CA2C7B8F73F8F448A85466A0E2E854EFDAC7A6F773E63CEBA085A6281835
      8125C484FA1293742655EEE95ABD288F96453069E7146E45BB0BD4CFDD701A2D
      75C9B51D2BC375147AFD4425A96325EA59CFA53DF3C7AFB3BC1C2D500A64104B
      D8851493AD3B5B0A00DABB6860AEDB4A29F539877511A5E36CE6763ED477FE4D
      50B778D6D9BE3CDBAB8EBDFAFACC52F73149BF7BD6DBC9F42660F415959E4E4D
      628608870ACB5CEFC9F64166922237AC10412F5EA31A37CF3ADC1F8F2E4F0E0A
      D755B3724E4244F7E311DB1080C3709292079D35024E72E6BEBB787F6EACBAEA
      2E6A863C1B4EE3D9F38EF00EA1827F879554A0A1290DA4A80CC21FFD8C3FEB88
      765505F047601A94D4A0707BDA610DCD5D1C2A0C233746D9143AA75CDD629D46
      8BA214C29759533FF49E7119CA8642B392ACFAB2BF981142977A555C781FCABC
      1930E2FAA68D15B4A9EDA321347DC45FD03205D3CAA86E1268AAF15053600ABC
      14D40541A8200DE20CC705C8FCACC3AA673B34A74AF02DA216A8215E077938B0
      E300E346411275EF049F924D97E932DA1AEE9031E7EC272F0E5923AFA89AC539
      791505A83C07B9293523CF5E1C56BD59D31466FAE71CF0CDF06C3229E21279C5
      BD6C5AEC414846F9EB04C496B3645629A55ADFBCE836200F70CB597FCE512D52
      0104486B0E06F4399A56748CB24993D47F8E5A9668A3E1B223F67B925C2D4CAB
      61F3D5B55C4A77FC730E35C809425EBA285DF74FF8B782A98C25A258C3C409D4
      CF775D8D63DFE53CCBC64A9BF8BCBE1533063D1668F90F78557B285B63C856B2
      0D0F026EA02095D135994E2E809038410A47900F250420C02B5B3E824BE475FF
      75FFCD1FFEF087B567F674897400C121BC8415070BFDF1C008C8160CBE87CB6B
      808B4B30331A4F0057028979D5126D9808D50C168A3A36B84A14A4C85B10CCC6
      A34F40E95411EF8ADB72CF834F01CC1FD14C0A1FCF3A3783C181B78F3EB3A3A2
      A8B20156F7A96ED6BC7EBE3C0CD63EBBB5F5BC4BF38341172BE8B0397BCF7A23
      71CDDCC8567D3671FBD10D7251F9B81F1733CD0E176E4BB22A1E4607174A0EFE
      DF17A82BF10ACF3AB4157A60A60456931EAD1081782923686BE8C797B315D8CA
      554A720560B6B547608821E96834193A29726891CF304C724C33232929BD3EFB
      1C9129A139962CDF30BEC6C9AD4F42FBD3E660BE67DC55370AF3E296A95E9ABE
      A4761253EB14D5EF677511CA7CEABE114F01636410AB144B2B76ACE8AD5A068B
      429921245D0331C22F95B3861F3529EAF45F9166907672C90CC245B8B98ED1EA
      1CD2C7DE412EEA4C87E8CB25F7879DB6CA30C47A770D80F8BC2601CB76BD6217
      5EE2A95DD1B110F437555F239A58A98C85CCC91F1A7EF45E62C31ED31A7F8265
      F7BC45020192619E43685F6FE54237013F037054CF7657EA58E099FF1A63524B
      FC874C19BEABCDD7F9888CA09CC9F38E254C69F4FCAB0CDD1A9D06ED1291223C
      337F4CC1885F50F88136CC046F6E22CDA492660052E0B5F02CE8C7C55CC2B00A
      98297D534D6FF54A8BE9B61F59CE2B11851F0CD05A3C27F24739B0C8EC8C046F
      9E30D9F4BC49E83C2AAE954A7C8442862C0B5457957B45FC3A5666E43DF4243E
      A1818D1CA852D9AD10211410B49FE87E1A1856989B80E0F58D198A45A8B41BBC
      9C78F20FAF4213748DC9C1AA88874806FDACD370472DC74831FE09CF51402750
      3278A42689242F790019BE9B37CE9C81750D86B44FCBAA2E41BB1C61639E1BAE
      E93A4321F75C134CEAC264E3788E7750E6515A4CEF5EBD18E2B24BA8A637DA84
      21CEB48812A993F1BAFFAAFFEA2F8D062818C0B1AFB100189B8DE1113303F365
      70E069E05A5CDF77005EEEEF54ADC36D2E085A41E906AC3A9185E0EB75CF1D9E
      7E90232B187EA39B6977D7ABFEABFECB4617F8F20660CC6510DA53BF2DAD7A6E
      9172AB53BF82ED6E34D6B8B4F6A535BA7805386F73156C4DC522ADFEFE77AFF0
      FDEF5E85DF87924C712D02866343CAC048317FC10A88179EEA37BAEC219CEA83
      C1B9B7DFDA9D1B8FAE53E39F13E424C3F783C112A1C0531F5F8A73EF509CC3D9
      74747A7826EDBF8DAE46A2AAA0D115B64DB3E9261CEAF6F6888569747D7CB762
      7491D7DE687A9151C1D56C7625B69075C934D0FEF15ECF9DB16E85D334F8CBC1
      E0A4D94C937D89D36D36EBFCE0E2A7A66FEDF5C6E1E987DF84CFE3A18978E44A
      072965A12383DB4AE913C52B1C3E5A270F640F9A6D32019196719EE3B8BB01FF
      8E2BE22B898A61F5B2F158DB109BDD605F11D4E3DB349A252337D244E82489A7
      636B7FD5529781FF23510001236939BAEEBB8F38DA90C328D7492F30CB90B664
      F9A776B164E2FE11E799122313CF1115D06F142104E15E57B61802647DFC6F2A
      5072DB80B5DE8825E035E38C47DC94902831CE597CC689EB9B7891C6D331517F
      229E4E34DFA09FA63255BA047B7EEA54EE0E7640C7F2F965FFDBC606759DE218
      21D52BA50523C9AE1B1648928D9F6207F14510B98CD13A3FF28A15565C621E9D
      9905386EF2E5BE6069AF23F42A4B75239A8E44AE45D33E27FBDF8A4F7A799801
      223D4D86A8FEF75B7B2A9BCD3C955F068303D9FF7B5C8248E04D17432F85D785
      A15183B4D6C3B600C433B077D82866B092D4FDB13F1A8D38554DED11C9E07E73
      1D21CF140CB87076171D731DA461AAA595D26BED9453601AA4F6D4E2B83A3CDB
      0ADAD69B390F9F6EF364E63E5C08171E0A8B8B720B3FEBEBD8F6522A0579F33E
      5CE0FDF7E32F6CA6383CDBAA7E4131000D54C4415E2FE3E2DBCF397EBF3EC9B6
      3EE78144484303AA34D8DB303F6FD7C7C9155872AEE32F11A4AD40ADA585646D
      04A07A4DF63911AA5FD7D9C531ACB877CF8B67BD221D316DCADDAB17B20EC12A
      174EAC73A3E1336353C3137BB74658B2C9A398CC926994B345B667DC33CCB349
      E7B0962C991BA988CEE9F3A74BAD424F1D57E7828A08C6DB02C6CDE5DB1A6329
      7FCF04CC3C42AFA6B4AACCA45B31381AA2B4E150ACDC6ECEE4EAB1F83EF0B1DB
      BD15327BC96A7D0EE86F0356638D5B84FEEF76DE6CB3205F21FC79FF1C0C0ED6
      4EA2F90910FB3999B5F9EEAA3FFE751117E5258079FC6332114A3D34BB230141
      E0BAD46F95AA41224AA9CDB33B5A78AD31ABB0BCF2A946C3D63ED4F10A1AD546
      D743FC82A412C89E8C026ACC7539D38C43B3EB92933DA036ADBCAE9DF3239E92
      5513CCDF0BB0E2A7C9A4E8A1E728CE93685AF4DC3443826FBADC2BF4F5875BF3
      A3ED37B3A903A1D9A199A1509618D436171E1CB4B5F77A70889D775BAD06F5C0
      BA12302A093EAC8BEFDF75A9B55C299BFDD7FF6E6BE5195FB1B43B996746B129
      4D7531CCB07CB71CF6BE3DEA09D2084F3E0E06DA0CF7E423E95F6A229BAC8F86
      B6E4BF61773114F75E69F896AFA642DE3F8B1157B4F47A0F19F57A9CA10C5C20
      6171C403EEF86CBFD5ADE439F07F7D96E873968C0B559F13604B1EC7056F44EA
      99057AFFE1EAAB9787DE04A5EC06F71173E3BA3735B635354902C98528062032
      E995AAA01938D25B2F99A691959FF21D66C5CF770F76DA544E9FDB71607B25E0
      9D649E9FCDCB5BA519689692D5778D0BDA42DA1DECB46BB1B18B068FAEE80524
      D4639477221427A470318DD271318AE6311656A3FB1D9E7EB0254B2EF2D7F253
      EB15F4B2D90A126A88F6E7AB24BAB4B3671A479FDA5C26E019415E9641FFFED1
      CE718B4B9217CC3C6F2A6D34B5A1D1F833CA5581208E9BC454F76C9639CEA3AB
      FF8366499146D5C201D337CBC5F84ECD6207BA77ACE9369B9C8CC21E46DF2ACC
      90154CB6A5ABD53E7F5A5D8B34349A6C80C34425157143E403DB9D322ECAFE3C
      C23CA9B9F6A70E121A2C1A225EDBFA2783B6C3B3D7FF3C3CFDB0A69C5AF19766
      2F50BB9D8A221B25CC525A621263FB631F09917954F4E49F5BFACF49F67A4E92
      F9317E483FE30734E7507FB2D954315F76928DDD597E15412E2077DD4D503494
      EED51A4E2DE1E80E098125C1BACA7573EBB34CBFB2FD1FFA0FCCE19F9BAD3201
      F4AF138F06C081E90814F6A6C81DC28C42E365B27EB61D8C9F69120199678B72
      0E920F82B3B875B006D4089BC300C8E80CA23032564943A239105D74AEB37EB6
      DDEFFFFAEB4936F6B3FBEBAFB36C5CFCFAABE510C7C8C58391F4F86CBFD3F234
      97ED174DDD756294F9D6AB3F96667D4DBC34BC0FEE21B0501C6B64C1C8E30921
      5A97170707EADF1F9FED7BD76859D0C1F2FF2DD004779CB81ED98D979DFEF53F
      6B396AFDCF2A7654363F7DF59E1FE3689EA51B3BF92CCB377666B3854A261573
      F815C5751CDF57147DDAF577CFF62F3776CFF65F49DBA54724D11FF2057B4938
      7BE564EC40B23409CFA7EA7190CB8626AFCD80BCACE1FED9EE7FAE5686FECA2B
      5EAC401589F46F85DEBB9B78FB7ACFE665FF75D3788A4D296FBEDFBE87D878A9
      BA15505A0B280E6EBE8B66F8143E1E76DAFA1A77D162649B5BDF6F572AE4E318
      C90EA81289B1A4B5D6D9A5D6369A975BDDEECDABED00B39C67BE315864A82153
      61F8A16E6021AD0D34AB92AD307CCD70F1D759F929BE2DC2447895CDD6947897
      DD224057098D610F71DA3C1ABB6F4CE2931A2FEBF6539AA571CFFD114DAC715E
      361DD774EC06D7C904A035CCBC3504EB3AC471F229991348961175A5831519E1
      2EB6ECA24059B22817E09A672B14BF9A2D4AA8EE6009216521D5DAB8F80455BF
      288FA3671AB0D7123EFBE9C1D965D119797C2099F14CC66B74579DB4926F6B83
      C489BF50ADF1DEEBDB4859310E35E35BD5CBE4BBCA31C6DE01783EE0B9D31820
      9B181F11522BE96256E9B422CA27FC996D42CDDE0FE0D2DFEC09CB912AB74374
      5E984E45417A4EB6999E3B284642F2292C8722F4CB97D51C8AA269232DFFD7A5
      BB68E8C68B11D88DA7858156509616988091B0D1016A8EC4D7CA8638E76449F5
      82B6E37896B91782A95EFD31B8F12F9E33FA08EA0BC536CE7F41B8B020681146
      972FEDE35A2F605073BB797653C097DE9996DF1CBE6EB61AFCD3053C6EC32CFB
      04FE27DD7E1AE36DCBCAD9ECF7BF351F36F21FED390CC2FE769591D8B46161CB
      2739D046E74106ECF04FAC541D91C8BBE75E64E98B60473C53CAAE3B8CCBC8BC
      A11EC938EC80E189D5F088D11B59CC17C1C743C91234145468EF0A82B4980273
      2219C0B59E9B4BBF98EE985BB4D05A698AA23BC0A63C83BFB46277763F5E4211
      069E598FB0A69ED29245F3DB7C51F0DDF4DCBBB83C003C98E80F8FA15CEB5589
      ABD3E8F30953AAD08B279D7D99B9BF67E9CDF8BB563329A9450EA96B6332212D
      DC02118380368F3F1CBF73DDAB69368CA6FCD3F187E35312A913B4F782B2ADA0
      8E96DAFCDE4FC23A0F7615496C68D2557B166ECD0390D0DD780BEE245CBFE679
      B6EC797EBE78B70FFA71F3543327F23C0402CAC9D0025D86500E2156D80E707E
      BCFF2AB86392BAF39DBD9F285292A4C80BAEB588E676CF2FF70371164B140DB3
      F12DE1E815D9E5EEF9E52999B55BDCED2206E1105E235927F1BE6839A4157449
      E0B60D5067B0B5A1E8418D8C799BD0689D1D0E2E43D5DB2E0FB11703D2DF9855
      7D61FE004CDB64B2D63E266998B08F8BB962BC14C4AAA2D48A5D8F8B591B0FFF
      F59B6D004D8B127C4F40D34FC0F1A3DCACA6D73E36253FE18DBA5FD5FE6B6FFE
      DDB662F325D1EF57BA0A25516451E8588E2E4FD8B86B6AE561A1288DD9BEA25D
      8F2D32BEAA4C95BAB7548EE4262B7E5F20DA1EE6D1E8535CDE1D9846635789B4
      2F7AB108AB4A13C451F45CD28FFBEE97FF7D9E9483329BFFD6DC43DC1F4E7D47
      5D0DC724A1A0696AD09F22577BD0AB15928A10B42A9097662B8866CF83682AFA
      6C2426BC3310B03E2A736FB32311451BD905781BB605D01804B98D1950A91262
      95D7A6DF0E8325F102EC811C37DA66537D81E1847540D1D97D4E17B2075D49D5
      D75CF227778A02CB6916A5D115A4E0F5E7A1F98E7CD74D9D473D86656FFDBCF7
      7F2F5C17DC6F92BCF80762391F51FD65AD7EC0E0486B7FCFF393A3419BAAA2F7
      C84449281B42675EC803E2696027B6DDC9D9FE6ECF9D9C0DF67BEEF0DDBB1DFE
      7F80FF5F0EDADCDAFA058FF72E4F6B8785AAE5543BFDFDE0A773B5C6ADDE96DF
      339AE066D005566AB4C1255436E7CDDD91284A627DB7BAA118BDA0D46E486C3A
      19EDDFDE8B7D71FE5F288AFD3A66A23630092FD65F6D6E7DB7F5F6F59BADB7FD
      97F8EF05C92ED9CEE6BBB6284F295B5B2E040F30CDDCCF7BC71FABB5F01C9E7F
      07BEC2AFBF0AAE57283D0BCF8BB6ECF03FABAF1FC2EB6BA2107CD5CDBB8AD481
      B5D51CD8EC705153D0F14B8BA2A0DE4656D4F9BB8B8BC0A804141BC83245E5F5
      550EE0858031D985DAFE9E2B56F1C9BB8343CE1E4C9A2C9F9F8FCFF69E61C5F8
      BB76DE4BB796C5C23F0F0EF63BEE26CA1B3B22554147EE20616DFDC14ECFF7FE
      D65B1116B645EBBFECBF6E08095028491E7FDE80E051280E256B6001E2B83EA4
      DE6BF21F8184AF07298BAEE01CC9F41CD5D1669D19834A28378F7F5F50CF43D3
      E42C9A62BC8BF90D88315A3C71E48A1881F57D25D14086D9AA612F28802BB97A
      46449898E6DEE04E3071C8D7810A433254920F6C76E9CE7FA21F14803A0B82AC
      3E035A66A930CCB3F962BE42A0FAE9DD54F006374CCF010517706614411AB7D9
      858FA17BC7C2B5F407DFE44959023C53BAD727BB0D5BFFC85106C424D8A8E32F
      A3D810F6A451D116679316167AD3730BA0CACC049EC91D5246B3393B99663C0E
      45D061B220AD448930439851D8A38DDDDF6F5556848806BBBF0D24EEF598546F
      84AE440575ED3BA5414247D1DE4F4C3C7B8DDF59FFD9A2F207925B953E03A23E
      BAAD70946F1570F2B0D486EF74DD6EDBE22A0E48BFE565EA29E56E05D8CFE3AB
      055A38E22F263558AC35BF591867742F8F417B188F61D77BEE52445792A2DCCD
      BE34BC85CCAA4F41087381B269F80A9DC42CAC307D73C885038B24269E947554
      47D6F587847EC3C108E069EC8ADBB48CBEB8EBE4EA7A8AAD8423872028B983D8
      C18715DAE157355B28E031147C33486B844C42C4EFC867D374E19C056CF2C5F3
      5DF648DC88CD57DFF6DCE6AB37F8DFF7F8DF5BD7C5FFC008D6416280D96FDCBB
      F3887467528C9ACDDB1E4A5A15C509710BB3795426C384DAED5C51C3ACBC76FB
      F1747E9DB89F0F68A27E3E78EDA502012A51091F11DE6C7184A3D9EB1417F406
      B1C8C0B627165DA0A7C211A81A84BE014ABD9A8677DFBD2DE31D5CDD4DE3F4AA
      BCF674AA0C79DE6CB9615216ED3DBA57DF37F3E878A15196569D71C35B37CB92
      59946EBE7CE9AECB725E6C6F6CF8DFF4C7F1E7244A5102EF8FB2D94694971B97
      71F12D36E1FA1168CAD7B7DE7CF7FDABEFDE7EFFA6559C4461EC14C806494952
      AF0D2DBF63D79533A5703B17273B3D77FA617084CCC0FEAB1EAA0A670DAD8DDE
      F880949FAA07239DDF5748D8E0A84607201C74A5D4273B0B73506D6E78785F5C
      C3B28A9D5182C8F388D036D9D8975B6E1B7C3C283E93C85178E1907F66C1BB98
      0955F5D57556946BF47CBC3FD3D42EC9ADDDDBB76E1BFB1D291E9A70CFE0C406
      42A5302B9372EA25520162950E8FC267165D772CFAC46876960A4D1ECFF38C95
      EBE1E26A4D75EED042CE3CA8D83A413C82E7ED4B9BA7D8DCFCDE6DFBA2250850
      7E820BC1DEEC29FCC09F8F2F8E2BD2414199027F2281903837186156C4F25982
      6CC1F03F8E616E86719A5C09083CA0EA39BA3C6937EA976EDBD14508CAF74CE2
      B2AC2F19D4251934E8FC42001A56A2B3FCDD0E0C342A29B2461B9E83817FAD48
      4F533962994F34C4F4CD49CC48853F04DEED96E2ABEA25EE45F3A4AC204E1A91
      831D1FAD9CA80A3051155403C60925FCC6B0DD6E3FD04E50C498B1B6BB02B85D
      3299DF55657E568736F4DCE0D22BBFBCFE96A72D20A863EC9779548051A0039C
      6607D48C37205D68EC9306480AC3E8B4F0A6C33555FCABBC3A6B2C46EDD8B86B
      2D8684DA5D256B0BC703CB0F8136E26E657F0C941342CEC7563BF4D5B7D8A19E
      0349F597857217D538E434503F6B77934D9A813B020E17F115FD4F01EF126D41
      5B5AF4039D6D0FD4E2693C8D6E55A090A99E4A3ED8936DB853023E79E50A5FF8
      F3DEF18559B5FAE3691DA0DD03BEDCD8DCC439530DBBC60B48489C4F4B49AE28
      7C46D08C2DE62E6050C387052787393101348A494E191BB4B3CBDFB96DC81AB2
      082911CD7B435EE308301A173FC20208A8567784E913C3EB3A5A0D1797AAE366
      D1D4B6734B0BBBB98995B6F321CCFFD62ABF2CE191E2DF3BE07D3710B70A0FAE
      1D43E85DD5B234160BD655D568A76F09ABF5D6CDAFA3A2DDBB788975F3810E20
      CAE346E6C8E50D634FC2F2C10913E87DB71B8D3E01D6908E2BF03035CFE58C60
      CF00A8CEAD86AD8365F6ABDD30B164C0A8276BF877D00BD886D20D1C7F41732E
      0BE6BAA8267944722149620B619EB6384003F3C1896F919FB221BF71DB8EA2AF
      F594B0E66A51EA976AAE68BADCA0ACFB59DA40FBEE30C963D124410C002F29F0
      1070E0C59309E2E7CFD3DB6A69C0EF13BF416A76ED860FD37CA60784F02763CE
      6D4E0BF41391E5C1ED68090F792C7349AB3C62DFEDCB228093DFB39986AB1AB0
      41FA4750E887781F2840B47B0638801FB264143B705154942770ABE7F338CA8B
      BE3B911115B21A56BCF7A533F8A7940A82F8DC762BABFDDA6D2B0BEF1D1F5579
      4C015A92E5D2B399A90935012C403618921222053509585B6421D831D027104E
      48A62A1830870240EE5ABB89A67DD5160E35739A7310AC82D635A3A248AED0D8
      A1B8E331DB6E6C3442DB3BC3FAD720A3D2AE323585DA752D6DA21B893F45A5BA
      A199E996497EE95F94F431CB8FDDD281795CCCBDCAA1E7928FD2D17586380736
      88BA8E84826579C3AC33FBBB41E54BE30AB4CB281A5D23A6B66DE7BAE80FC43C
      8CE3E1E20A9ECFDA33A45CDE364BB990538D52C1D6EE23AF268143892E310181
      C751CA4A4F3611C8A981E1653754DD06EC63234D5C3475A7F197058DD1A08CA3
      196D60719D29B0ACEFBAD2D915159F5C3404E28FC3D07533C9F2C5AC15D0E05C
      21A05D495DD859BFE6318724EC6060324B8A911D59C6E156E5CCF7F3E82A4B87
      599E8274B0CD903AA853EA667447FB9D558916F5481ADDE6129737A6232B9EAD
      8CFF54B957F048CD12999A3AAD68C9837E89323367FE3FDCDB972F9BF5DDED55
      9DBEBECB0CA24130C2140924CEA3AE21D5B21BC31C50DFC8AC9548ED741B419C
      5D4DA2C2E18F774EF7050DCD419DEE7C38F2F3DE9596927A2FC95ADF9DA50148
      5DCBB5D251C7FDDCD35E03E1C66FFB48BEA36E25520C76845D0ECFC339F3B2FF
      EABBBFB4D92146BC394E225049178BA1484812314798CA66BF99F4A709DD6E8C
      8909A6E6EDA29CBC35AA98BEBBACB892C3FC5E4F6A3D900A40C15DAAF865C6BC
      C6A0CCA5772AB71487D0E5D0732A33D4C5DAB0B2299E6078ABBB69C37B496888
      2AD0753B8E53DFF1D7FEE5BDF94BDB6E52CC1C6447A9D9E2BA659E2D865ECEA8
      A60BB2D63E4FAD3DBF173B7B079A549202CA309913BF473BAB6ECB114FAEAA08
      94A3696639FC1344A69E84452F203DB87B49C9195721831C826D2AD65013F208
      56697F0FD35942DC0E9310141C0BD75DDEC3ED51E3AFBE6DB50E8E6673E06319
      DA01FF7E74BE3F308CAEBCA1F66D1EFB0780D36BF0B873BCF7A3F43676F6C1A0
      BF18959C273874D3B8E8ACB55ED5015AB5206A4489F2B418CD16EA24D51AD0CE
      C5C99960C0B030BDDE0D29A729EDBBF713CC18BDCCA8559752B062588F52EE7C
      361FF801605EB846F83E28E8C541CB28DABF0AAA36074F7922A8C2739AEBAEA1
      69935496D6D61A230E761A5ADC0CD810B5834C02222211F583ACDF8F8D90780F
      3B4E8C05B26A9A6903C3BBB74836383FB05A4BA3EB9F3315BE3E6441B63AAF55
      ED8FBC2BA1C04B476A515DD50EF32DA9A13100E81EF0DD326BB6093A5A13917B
      35BBC44E1A4D6FFF11032325978187938368004A2EDA51D58C255C88B0ACDB6B
      9A5D35BACCD9709A7CC6B17F01C9B1592CD37B2E7422683EB962ED797B63E3E6
      E6A69F22AC416B396BCE997E7703BFD9D8DA7CFBE675A3593A11274D1B0B1958
      672E9B004346B427E6CD135477C834019E9DA12C815DE4C2E1656EE47134BAC6
      32E8551B311F5DF7DC20FE9D85D69EB942F4747A2E2E47FD666BE31022DA2292
      42492D3D5B559259BCA49DE3CBF6C7D1D6B3F8940151B3114B28EDB5CA4F900E
      B530FE2F20D432B77B3618B0F44FC36F5BEC194AEC945061A624804427A9FBEB
      FBC1659BCBB3D14D10EB53E862A180A85C1DC318E54B1F4C05489F5687004F43
      6DD39DC657D1E8D65D9CEE9CA88384B3E8079D532DEEE95F04518CC3B2E7764E
      F0FF8F073BE73D9EE63D77723468156B1B5E6BF55D2AF16D8CA47E6241F572C2
      6A1CE5597CC6DC2C2A4BFD58A4B26ED65A345E9E66218718A8C3DAA8542E131B
      DE85DC13991C5D8D33A8AA8B60057971E2B190E6A8A2BA49F99935DA3FDE6B36
      220AED78E264407B3D5798E8EC66214439D0A6A3A86C28C1DB90B5CC47BFA8FB
      15657E5B6DFD2CA5C0896A9A36BAFA8F20B7D8BBBC38AE1405C51C6A4901A833
      4CF9A43294ED8D61535657D916BAD42596B63224C6284769783227A53488DC57
      D57EE4503D86F5910D58F4DC1126B9073AD9E9B4D9597F7ABEB75DBF4C8FBA7E
      38DFCAA2E70E21F67A6F96E4918B5F44A378DBFD182560D93CB88DDB0D75EF11
      DA9DC706134B16A2D9B7A9FA07E06DB3AFFF64363A4BB71D89A77A4A43D5733B
      B359D6C38B68BE02619F80C7FECD7DE4D11BE78882B05FDEEF5FA80C8D11DB47
      D6D4E225C5C890CA6A744023D07F0EE7E02E91683359A0DDF3FD4B225B2D1501
      F5344B3849FB9C1A5EE6BA09B4129E0D3E9B67E09A46C894A0A7B65B85CD7235
      9A9507FAF01EDF472F0A572646A858BF3C7E2F2C4F8D5C8647EE0DE7C6F715D6
      D116D51078F7E6972F4A4EDBDD47E31F5A5CFDE841028BFDE4333896B2BC5D5E
      2B1AC5873FBBF97596C6332F02AD1EA91CCE1A6B06B985FEB364D296FABD787D
      38C19CD4AE0C413A61B1BCA53D438E0E7CF407F95C858ED0972C9DEB0BD9C6D4
      DD02A1316404DA2163A9D0A2F457EB31BB7AC65207075EE8F705D1338383BF8A
      9FD145EA8F5A92D2B4648E8D3677231D315A6EF1F8FAA497AC8E3AFD7553D12F
      78717B3FEE583A81736E590C292B5E475380B84535421DD97D9C8727591ADFC2
      676B736F05FA8CC5295527B527AF3E12FCAF16C46BAB266CCF6F08BBCB82AE2C
      5EBB8397F7097BF9062564FC24D89B24BDEA34EC62538F947930B4E631D78A84
      7DD07B4697AB55439B246B546D143BC5A4E1250D02441A5B9CA2521D3C796AA1
      9642EA1493AEB380C766CF0E88D3868BB29441EA6765983D96D625D12D355B2D
      BF134AFD05FC7052A787327A4F2AB9776EA6872F4541F2C6F8377DE8A07E66E7
      76ABD531108C45453891D5DD0AF47B6DFD86B9FCDB34BB6244BF9867445036C4
      048B7D9C25005D7AAA0EBE2C610A628F91063012BB58AD21AF820E3FBB3CF405
      D5EC51E3521DC7B5F19A7869165198CB6393743A96EBE1363D0792587CA6223B
      7D01AAE8CC53C7CAA15131A1928B9857B30EC5AE65BC441DE9F260F041FE1597
      A3E700233464C234CD0949093687ED06AD920CF7EED5787CE45A9EDE16296E10
      065197B688D16B5BA2120CF44AB6AC58F6151D65D2B2ECD518C9D541A2465505
      9A518DAF8509AAEA64129D2A6C90764F7AE68CD9A5E161B1339DFEE63EE6B731
      7A9AAEA54D03F1A5E243BA7F84AC725FBB373CDFE31DBAC7A6773F3EFECD1D1E
      0F2E594B116A4611B1AC79956DAE7EB00FE60B42FA8A0A87E0DDE0563E439888
      D5CEC19ECDD034F85B55B3968F0A2CD11667A0F1DB6A34EBD36D8B3AEAADE515
      35C8886D22865CA88DA9454F5C50CC826D4FD875A1D3201E1A9D9B204DBB815C
      2E53B934F19A46521EAF90A8B38D0B2451EF4936FE2929DDD1C9D9BEF96221BB
      BD312E5558E236B75CA65E0B97725048834E6374D5B447DB47E0821195B02804
      FF55945C8D9B937EB103C6028CEC06E9906B52D3F2D924110F76BD83E3E3D637
      19A4D9CDADBB51BACC30E3997C09A3B49DBCBC9E6559FE0C87DCE6F7CF2F9FC3
      A67D1C58F4E4E9C8032AA16178FB2137C477A864D3E9070E061959B07C2AB0DC
      0015C9A412AF191BC31E290886B14A9F362CFC0B285F34ECB5E531139DD2D2A1
      56AA88EB56D0B90EB2FE782B52BB2A3A1E82744D3EB36A1F0A3A998F1B975132
      959641412EC286DF95406BF4AA1A4230C6C4DB282F3D5C8A8AB95BA56D2593C6
      414BFB09289A09754622FBEF8BD95CCB8C91CDE8F3BC344E2CBB54E3FC93BD32
      C4AEB8DB410A37F93C4BD26678083165039A320220699CE5B7DFE8EFCF71DF03
      B92F31E708290135881C213E24C0E0D10AA4ABA5917C559D1A636804B70A06B3
      0D8D468BF0B9F692902F01A3FF6D581FC15308AD5D0CD380034E4856A2ABA861
      97AF3513AE8BCAA35E0FFD0E86F21FC1F64BF7540628247A6339127803DCCD90
      35955EC4291A43C985072C87008995395A68DAD1132368C9863BFF84E82AC9D1
      7204F28B0B855A61A749A64F8F6440CE3E4ACE78DB607BF197799C2700C845D3
      9E9957D1B48C96C9D3BE76A7BEEA7FDB54658FFD82AA4BBD0A4B328A73E9FCBF
      C7B16832D48664A0E8073B4CBE6C8B3811B73036AA7028E4492178494A43203F
      D1992CFEF18FDB8EB63D23EB96C705FC45132D5FBA8C1149B2FB572E09DB8E10
      38FE1D1DD7A8953B90C25E7185419B4BDEA0DA34B63959C8148D468B1C35E86C
      62FBACBBE586B765BCB67C63E974E8BB5D09A899F9000810F977E0A52DFDCAAF
      B131BDB4E300CD1B3A3A19B21C86FC4DFBF7B44488550C5FBFBC7389577289CE
      0538E111456A97347DE57EBFDF79A8A902052A6C53D1ED152F5BEA0AA4B0FC9C
      5C89530F6D3A9E14EB7F76F7DDE8A1FBACFC8E4CB482C6616AED8F15BBB81BC6
      386D957795132F795C69560176FF965E6A0EC582AABB1D75154F7064E217D23D
      6DD758438E8C3F712931816CCDDC429B0567864BE3C147B39E7EA551D2AC1B2D
      24C59401239F65E305C217DE8E09BC6944DE3B251DB25E8705983D84639A2AF3
      37DA77114D6F4004A26C18681095EAADB56A74E3FE555FD9180ECF5E9F0B1EA1
      0FE16169E721FD12245C3EC7F9341209059B6D0D9AAA92938E9679416E5B4ABF
      170BE692223609794D42B93C3BF8A85022617178791CACB805AE21A78DF41CC4
      395EEB8353FB71E7E2F4E8F4DD76E53260A0C12A095BA265D4B2A638604DA332
      F585029BF0BCA0CD361D6B76338FA34FB284A4FD432EC1875445C5A4B0DFC2C5
      D5B65C85100BAD567AAB3232D1F2D48197D1D36F094FF8746AECB12C811C9EBD
      16312E59766CE0E5A4CB9EF0DD13457DAD72F0B856D53A067397E570DFA6B70F
      CEA95027D41A7DF086E89A638E12E4FAFD19DE99463936E778CC8C737413417A
      1BC0C960166367194A40E117A06E735BEF7695646221884E91238CDC9BAD6152
      56924213F791799FD687DAEBFE4B77F0F3F9C1C5D1C9C1E9E5CE71B3134E1EB7
      A2002BE0BCA8AE2F4B564B915A4F8F34C5DBCEB01A481223C74660C8B4C50D70
      8A719C96625D407C243F82F9A0CC74857538B9941A40D3E3559A4C9211961765
      303C9765867231F884976531D49C04DC18EC71857ABCA2C89BC5D9999A29BA87
      69F00EB3451956CFBD4D9965456940124539AB37308BA334B0875C4845AC3E66
      81D3F5062B298C2BFD87C7C9180977FEE1960971EAD77591241599D32AAB5DCC
      7A6E6F5055299945D2B3DB5C6DEE222AAF4465BC4672BC24689016491659E218
      BACDA1969205B5653B5904FED24CC076E8B3363A46BB2E0D7B78F1BF2F0AEEEB
      C298A9A4725AC8215794989A4F713C97B9C7758BB5DABD51EA086E7E9D607D86
      B7E7DD2F6B6357D8BA8413EBFCF8F9BB8B7D3997E3289F02BE69FD0F8DF3EFFE
      7686A14BE073476922F449CD2EBCBBB8423287C18AF8681AA18FAED146ACBE85
      B42757457F31A4CDBAE9AEE3D5E407FEF174F98A153F479893BB9DBD1F2FDC2F
      A4157EB9B9F51B5E86904E02A784515746761097F6B701B3FE65E6CEE6DCCFAC
      00C817D4EE1671D977EF127185F5E0606495FB14058ADA4C822EE63A0F550F53
      E8BCFA604F051F78467906241C9C37D095E989E39D4C2AA73B908509BAFD8C1B
      C8CAF052C26064EDB71A581710B3A93316FB33BAFFAF7C37DC74882BFC238B7A
      13FEC444006D973D484FF6E434F924D53313397D7114DA6A09415F78920A7F47
      7444377F9AAA22A2CB1AC346DEEDA6A82575A4C5DCC54898E8812E8F6ADA710C
      BB3DAB6D54DA47C771C0D8AA5C5B98394A3AA92BC81B43E74362A9AAD27C1D21
      E601600B0EC17245E5EB8FED574DC3E67770EB06564EEDBE3B195CAE594FFD8D
      D4ADFDE2268D39FA53504FC8A46A8BEE39216210CBD0B0534B9322BA9695AE26
      806A30C9ABAC20F01AE4D08FDC21E57DF9E5F653B81C26AE0850ECB0D65888F5
      8459F477ED08B2A51BA19357E38FC00B1AD2E22242D60C4C52ACE8856CF71C8D
      55E8056060C1C124C9719A522BCE47E869562623692016B5D496378ADC2B58BA
      FA4D982F8BA67479D0EB19013BDBF8E4AC1A9DA332BE02F945E74769F21CDE52
      34974ACE1DC36E0B31AA4038B8C69B710090134771E8C3DB8A8B23CB1D592A65
      86E1425DC56570B89ADA6EC8AE5F7559B4036CCFA39C712DCFC1F2DABD037D7B
      C3CD0A05AD6C821C3F604469C713A381E51E87AB725E484298A4C92AABD9587F
      68B06CCEBBECE2211A1C338908C2049DD0CCDB8313A855939EEBF7D734333D0A
      3335741D3A036FC63B3DFFD36996C6123F748EA82F598DA099C8AF127E810959
      5219926FB5C28E65C3B3C92441C7732BE94571EDB683AD262232377986C0D630
      4AE088A875EC56B05439B0123489D3C932873BB269EE0ADB2247BFA66AB70C27
      8C6135F2576BF40814664421B8BC81A8BC8F8462C4F44931D31D2B7993004830
      9AE257DEF96FBE7FBD6CA1F64D84A146C7B78729AD58C065DAA1CE5CE17E5F90
      6C0E0CB04CB1549DA595E6356DDF5ADFED28C51ACE034B22900A4BFA62584FF3
      0C6163B77BDBA9754F997B113401D615E4F1693F58413DFB644DAB2A3B2CA869
      7FE524FC9F22C45494B3E42A2CF13E4AF2D16206830E96B3D6C5386D39895C9E
      F1F82399265395545DF59956FA3228F900FE2E52A8E6BBDF48D8467BC06CB7B9
      12824B62DA51101BA072EABB41E65379B06C7154243CBA23AF08040B0FD1C686
      8AA94854200B7FE58E5E7C6685EC2A13D67BF2B9FCD0AEB8B2D9B45E51F711F1
      A2A5EA330EB2316943D5D243F3F65941841D3947A8CDE48B674B949B1A43B015
      D21ABA05FED42F5C9756D8C8722274094003BEE101653E7490BCB97B12895911
      E25D49616E489D9C89CCC8F5CBB8D8C2C2F5104726EA7D904BDA6CC8AF78F520
      38C2153394745D76F53431EC1382B4396A63F4DBB51AE90149CD1EF8DC0C62CE
      24AB344D07853765EC2225AF3D81429C2B6FEF2A4B9F5EDBFFAF6C414A32AE6E
      FEB493C76E1FB8E5871CF7FFCA16D84DDCA76C8EBFCEA6B1ED103889FBD96881
      D47BDFBD437EEB0FEEC76C8E22C4143C5D77936CF740A71FE580D574B7544864
      4B4A75DCAD1FE1B130A2A3191FA74A77F57C258DF54045E1B1031D1135AFA215
      5A0FB1C07B5DA4C85F61F2E31BE335F174BCE9D8EF3B6F89FFDFFFFC1FFF1F3A
      7D7BBB}
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
