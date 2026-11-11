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
      59101B2763CC0FF95F656250505536958E40A12D7D701346127D29F68F83F14A
      4BD011B7B766151532620412D82AA97C2E16899FBFB49BB4FA3F0FBBFFE07031
      305C1065344DDABF5502B8B36F31D08ED133DF57A9A7AD878BDDFEDCB5E8AF53
      549B91FD0A30198AFAB87E5076E91BB2F33BE4C645F7F47487C0FF6911F8FF60
      F3FCF0E403189A522FD3BBECF7A9502220E549B700AC146CD2F7E21B4331B885
      4E53BB9BA511FFA8512517EAF96FC3E72860A602984826F940B32D8EA35E13ED
      839ACCAF5B458EBC67D2F970AE9706104C813D5032408CF1C7DFC40F52181DAB
      17B9DA4B709E8D121DA570ED527E9B93E1280968C2B461E6961D429F00E6D8A7
      17585516959FF44D7CADBA118E89FE80382349475BDC6493014B13994CF2CFBE
      5966F317D9E7F41A515993CE3F58A9532E0CF2E3DB2925CEDD3E8FCE66321E37
      131551D72ACAFF212A9F97385094F342EA58524696ED07B28B4B45D4B04357A0
      DD1E169C42420F947EE064A4562B9D30FD11933C502802981D621E208810D326
      922A8888B42F5E2660EDB39879DE8C45ECC82B00222310E6096F91548C2E8265
      FA1A111B5D83DB5361402A96D48F058B83502E915E1029123E5EE0CA82A56365
      0F139B50C128173F60B5B6494B0AF215C24A54F7C01A0EFC877C6290E50596D6
      31F7D8FB6EF2268230C1F3C1BFC17370C31234E4AC415A13488FFD89D97BB096
      6CF670417D5AB3256CCC4857DB24A04A6B77F049F8EEF93FDEAA69E21CAE6F8A
      C1C3F6631E611FAA600204FCE85FB58DFA43245DD949922C21B8BF6C342D70AE
      5BD3BE0ACD4C7B6BBA47CBE0D670704E0BD6E734CE93162AD1E0D2E854F502D0
      DEC45398EF82545968C6B617483C2F9E45F0EEB46AFF7A74B87940FCA2B09DEF
      41EA9D4277ED822FB37B46A6785A5337281B656BF9A85D88040C79D23CA663EF
      0C6609571020B019A85435261384745A30C5CE1C2C966FF814122F289764F0B2
      14B648907A1255E02F82746285F8658D0291F82C056D5F50B85A2CC384511CE1
      5A85008D32FEBDCE46E03498D1A2127645168D4582D4A1E33E888832C079DC6E
      5D1EC8D923D21BBFA23CF560A28F9F4BA9DDB6F385A3E863D58117B59496D60D
      5904E912CCBDBEBC33C7A2583ED89803891FE6D45DA92B33937A10CA501041A8
      E376803054DB1A7C883B243A5882D9D2135C97200AB8903D8049CA70826896C3
      3529C4B1AD6C1764DF9DD20527FAD9DF9F917EB65DA1F9C56908A2DC2A9BFFFD
      0025ED12E2DC235D104715B29C03932EE9456DF48832440D29F394B84BC13368
      B98EB75825F4848236739D8758EB591EEAA46E6E0B65C77949322284D910E7B9
      5E481DAA352874633D0C26896642966B7B6CF87655427EE2E79ADB2548A5E3E8
      4F25782DD7AFBEB98252FECE959ABEDAA33D41B95012B0D3BC5F13A1864FDB6F
      C553C1BD0B650F443267EA8A3A550B7BFD587C521CEB49989B6582C49F6C96A7
      A3D714D597322BC2BADA0FA5E59F7721027A78FFC15959EE769A05DEF5BA212C
      0448BE32916698D54BD04F8D6BB59B8276AAEB503802F867CE0AC1B6709CEA9D
      E3B8D7374938303373BB5F4ED6BAC1548DC345EF355B8D504C84E745C406FCC5
      8214285B2F9980DB155CC817A3D11433BCCE22DF5E91E20652C0A1A4236CA66C
      83B142A993DE64E5C35E7EC15B8A82D899B869F15485C1C4375324A31AE11F6F
      1BB7B79F2095218BF3891CB0DD63F27C67F9A2368A3AA6F2CAAA3DA8ED51A77F
      5A53A341B32F70E15E7F6423BB1F5527A26B0ABEA0C4AC74E24BF09AC2F79B81
      FB7D605FD2A2801261DC06C5FD2DA3DBCE57FD343126D4C079F120CCD56B0F69
      CCA81139D362C79928ABB7CF5B45F583A58FDC2102C704B758BAD56428D0C153
      0EEB8F865226405553F4D2B51237021F7918CC22CE6C896405804D2F21381203
      1619E12F99B2300144A86E237E049E752602A510964CBC5A294E271A40129E14
      17850BCA85C8938A9088EA466C570771B45FDBBC207897839361B371000BB554
      585516D8A491AD8CBE0690F8DE6D780E1A5817E6D7937832597B616E3649605B
      0681C5DA26B36C1A4C82A42488F57EA801F6B4D03D932571E0DF4B194B2C083A
      5AEA2C73A68FBDB792F8BB8CE57B50BF90B7ED6EF3BCD13E3F1934DAE7575FD4
      24D19137AF731F0782A76BA136DD408E4408ACFC829C91200429FEEB2BFA9E9B
      45DF89521CA4D63C08FD3364BEAC07CD0C038CF5B4ACA0B8833D1D44021AA6E2
      BFBB4C974F1DFAB7D3CBB75FD1F7E17566C391BF7EE9F436891E84D39A432A89
      11761490A2169255122A580F88765F2DF364E9CA418D4D6B1314F8240770DAF8
      651212037DEE7276280E53B527D5EF287E77E44A19A0605969E49F84F50A187B
      CBC86191C657945FD923642C872941658329D1F7D27D2992A5C4A6CD8D4B95C6
      C2A008D469725DF09E91B9ED4F3FE9F41F268947429C19279BCB325A4D5808B7
      CDD479DD079DB30B356837479C79123A3140697478ADF89F8C3127D00CC5B2C1
      B8BB2E596BDD0EE2A8337CFB95A600002A653E5D3D7D3CEB0D3FEBDCA469E38C
      0AEA933AC9435600A8439818CE6A4349331F265E8C00FF4551804201EF4B335D
      3F68D37FC32BFA9312E40FB86C9B0E8798A35587E3030555F015A1F1138610E9
      5C539464DB074EF26AAD23F910D5CF96C4501B4BC2D993CAF70C5524605C3795
      418EF38653448CD190F6A82B7BD03B120A316E2FB08829DE77EF6C69A50A179D
      624D19AC6AE0258009095271E1A8AC99F1EFCB7C1212464FC67B6D0350A9F2B1
      E4390B9ABA253D28785A89B70607F9672AA9A558ACE331904357A5AF263B3B29
      6BB7C9F7AF8B98387E774CE0EF9A7A7BF8D33B86E4F0261EBF7BBBB57CB87DE0
      49770E864A531061136F5055F52668654387FD9E07082B529A1D0ADD7AB0A830
      62D002D75614075587FC4B8EDCC803A00AEA5CAB54D09AF321452DDE6684CA6A
      73A9D02B26B8C76400D41A80194D89826BE6CA06D39644212E109EBF7192893B
      F4AEE7FEB1EAA6E3B2CA5DB29B83A64B34CB5D1C344C8CA856E94446339BEDB3
      34085556662A31B46CED56DC7D071FEBDD28C177E5C3BF2341CFFC5DE2C84B6A
      FE6EFD153A71411E8759B5E4A8208B6B52572D72A8887F63EF2F3F1EFF54537F
      F9F1DD9123DED0AC6CCCE303F81A29498189310334074530262E343A0980EF99
      EB138D4F69979A7C8D6A40B63F8A2BB3AEFF9EEB90E95D20D8EB5536BB8F9541
      E1207E73C857BF1166E32B8DFD6A73F082D45253ECC338338D7E02111B165C6A
      776910A96ADE60ABCC626B16B0048F938C2AA1E7E62629FD072145ACD425FB41
      C21EB973419A7D2601C7E9B936B9650E6607EAD5E6D1DA7B0B78F8E907757408
      98F80775B4FF0AD67A9CE950350AB6450E89F331558DA2E86F3762C1A274D076
      9EA0DFBEB694DC363CF05A2DE365BEAC134B2827F2F6EE9EEBC7EFF2C351DD47
      531274BF9EF19E17B1BB8DBCBA54BE3C5784F0B1A8A050D24104D7CB082545DE
      647327B1ABA3CCAFB8194DB47CDA95A8E38642D3CB65885C33CC64024BA29151
      96C4D7EE5C771DB0E751998C944E8024A55C13326B1054B1A8B7122A27D6E4D3
      59802F9DDB500097256536752B90603A24DAC32C1E46C83CCB61846C076CBE28
      8BB61A1E2B46660A827F04A8D8E23F220755D2A0A02EA1B2356B398145C27C27
      6EEC3BEAA3A4A1493733A83B592C34A114689373A64B64969B42BC496103531D
      425093F14095FC7B240B5FBFBBA5C75D20F1B6FFB1C4CD569E0F9A74C22A0751
      01847F995784E70DB63078CD9643A48C85F2C18DCC8AE3E441B4CC33DCAED7BD
      752FF6E1ABBCDEA09FF7625883E55FF913DB13E730DDB38A394964D6510D5BC9
      8208CD4605CB61D13DA4E18B4891342C7899253E8F89AD04CC9B9596185B76F5
      66338A1799875C988DD80B2E6469BF92314FEE2FB33EB341412EC31D97631E98
      046801615FD8F23B4AA7B78308B4679A61685FAE75DE2D01C440E0128C8FEC7C
      C31F2EFE12AD4510605B5F6451FEF2D38F3F96C6412115515FFD7B8E7D9AA001
      0055EA8AF5B46171D1BB335D057B6D4CBDF342537D77C8B6E0701E4C698140CC
      C5ABDCEEB6E1D181AD6499C48BA554350A211DC45104864D666DA7300048D897
      D554DD0BCDFAE8F0F8B870C27905A9629F09E08B8370662204B8CCB0F3CB07BB
      0D0728967DA159BD7DF7A30269B558EC642CD4854CC1276438790B9C7BF3D5BF
      50F84567147F06855D3EA14FBFC8F406CCDDA8463DB3883942352A9815E82062
      E8490E123A9F025175C14FB3C44BD51EE739D5096A03701F51CAC5CC9B360124
      0491CC1F3330B3CE2D5ACA5C4FC0A5BD0FF022DA51F10C50350F9611AEF21C0D
      D711FDFA29DC0D4F0E184BBAD55432AD35D0BC4AA3DA22DF7A165000DF5A0F14
      C19714700512D198DF0395FF3FB292DE96AE4B25BD8D2E5078704F2A4C1B0067
      35AC25D0189E1EED58FDDC1FF4549DBB5FF9660A6F2D42868BE8D3B9C51C0776
      5E6C02CD7EBB521EDF67FA9C26A281787B664F8DD5491C935EDCBB3305D7E1CF
      2E303C250AE4FDB9CB609AA963A6C755ABC9E708B09FBDE3FD677F7F0A2A3061
      0EE641355C761FA62DE9B9C01C1BFEB4734B58BED3245E9C800E6B60A6CF3E21
      24133193EEC565AFD1BDB86CDE331DE70757B29475C03ECBD4A4F62150217AA4
      708992DC1B09CB677AC161AB435B4E9C1075E6F8EACFA96A2DD1339A81056A53
      DCD9965B43CC263AF2E3852D677BA609AD2615DA05AC7C7AB9828B5147A41161
      259A0760EFD6BEC0CFFC99A5060458DC9E0BD4E0ED6DD41F4BCEDAB1D8190CC8
      0917CBB199C0B898C0DAD139C35EDD8CCFCEF0AC946E2473382A80A6BC8CEDB4
      B5B792865F2C1CE351C3CBCF174CFFD11EB6EC711ED8C8B7509A71AC194B5803
      DA85E3819689500EC2E68E3BAA35A4E5C663D5C14D87E4A1A4EDA7384F907018
      9A4C4DC3185CB9C18CBB3AA9E3673B69DDF679A7D02CE3B122D033DD44B27145
      E866B13A0729E5BDA5ECCFB00254438F15984E89BDBD5475BF1064619851951B
      FCE5E33A243023AF70E3AAB26EDFBD66753C564DB25ED24AD933FA7A8F902AB6
      FED0478258B3082A4321D649628748872A8FA64108AB8B0D223EC6064D4DEB14
      F6B1900AC29953B17991D31AA2EFA9EAE948D3DB3DD32E7F6AF7A1CBC46879B6
      C7F69B2DDAB6FEB03DAA1055A4603F04C20F09660E240267248031F51F7F5347
      C7C725830D37642C2CAB07CD8CEFABFA7B9C0DCC516C10D94E5DBD49509B87FE
      5D24648783B313FED9E9A15F469FC8DE6985715E62B684BF818806EC2921799F
      AABF1CFF54FFCB9B23B5D73B1CFDDAB8C07F2E0F47BFEEBF949F2100B6F3616B
      D038878CA2EE1F22917935595AD7512080434557F2AEE90F9495AB42EC54BAF7
      F0D2F8D32125874F41CD7A1167567C3B0E70AE23FF9C171805EC54C3DF447681
      C2897069E26146F913242FECA9A59050C93E69FD2667C672BCD86835690737A7
      6D8306073A757319C4964185A9DDAAB2C6B8509ECF260A689CF3B37617065185
      58A11C894EC84B8560C94390816E7412704B1F72D0ED3BEF71348DB359E4C919
      F9C212204E3F4F1CDB580AEF6562FC3CF235B8A226FD381DC45963358116E31F
      0A5D80AC9FBE8913441A57932BE3BDE10FB82F3BFA2B57EAFFA14A5693025C25
      1490317E57F4EFC96235498C46500365B975DF2CC16318796BEEC0F864618A0B
      EFB669C3D17F91D41B8EDAA23BB8D19C0EE1CCEC6A365FC92140047D14774968
      600C730B623F2C54A3249EAB4AAD3F87D9492C0C8A305FBEA960B20A5430519B
      6E5F17CFD1BEEAFCDA07D31C07C10B9B03201BAA12619A7EB7C3DF6A8D2AE69A
      BD8A15BF9C22531B82748E2E8539F9CF6A42BC18DFB5EECE24532797973F57FC
      0BE257277397663744B3377CA471DE3DFB544AB05D5667DBAEADC3C89C45A4C4
      A6C1AD5B78A0B9B1E21BB1201C1AB7FC035EF91E37806810714E8EDEA9BDF320
      323AD9278BEE4E41FF4EA19E2FD467B9255DBFAE4C187B0151316D9F59A68C84
      6BF2918DC715A11F6DBFB007E2541B3ACE2D3149660FD37D1400A97A818B2362
      40699830F412142B23969AC5EAE2F2A263D302AD9F25A393F2F3008C4B4CB82E
      95F0FE73DA4C5F3ACD3E220654CEC11980C5C4502EFC0BF739642A4904AB3980
      4AAC6A8C06AEA965626E82384FC3B52D90952B4B2C364777586CAA80F9EFA2F0
      72BBCB17ED211D588E8E0909BB35C88830465421C5C3B113CCE5B3C775F395A4
      876546DA770F5A8CC76AC41319CEE33CF44B90192D9C3D31DFB32AEE67B52BCC
      A66DE28DB89CAA53C1DFF255DA20F3E2381A2EF445B3F78E0EC145B3E736EE6A
      7279321A0ECCEF12B4E8729971C372ABB28B84152FE94A29A77FD9BB6C7F3FE9
      1B6C55B7BB7CD9EAC96A202556C364ADEFD010483C0E8DDC03F65329294289A9
      04382824F1916F67786A9EB8A142BA171724FE2EF48208D42959810010FE6132
      328F68CD244055AC1BC77ED14804665EE00534E1EF5842C7A38535C32AD80A33
      5B800564809BDEF96631DB03B4711F190E92C539B5802CD3F4842BBFE39AEE7F
      B87F7AEF8F31BDF7C7D5E999C8D7E9BCC0A348BEF60315D395B5747B2DBD58AA
      51908566FFA3F4D4920E2EFDF3FF1AA83D89CE16A8B67D85C821C06D082C53B5
      749C92D1D74862B1D2B9E4EE23232AEFE1D22BDB9639BDCE806BFDD4DEAFFDD6
      A8D1BA6C9FEDD7CA5A40B5D7B938EF353A17E723FC67B85FE396A19FAFD45EF3
      F3E7ABFD9AEACFD769E0A56AB88E3CB5D7FF341CEDF30569F7CE46447797A7BB
      4EB25912EC4D42F44641623FADA97F8C4C9A9DE69127D25DE003162924C9B07B
      B6FEA36AB64E868814BE557FE56B7BD16FFD937B9F9E5F9D77D91296E243E773
      E2CD75181A6A6CB65E627AC28FD5083CF85FFC3B5AABCE90D66A56C615DD5460
      FFEAC47AF845375602B0E09F27B1BF264A5C9151EE79C7ABEEB0CBED7327CDC5
      243051D68A4314999026FD589486521C3588A6F183977627E624D25B05EBA4AD
      3EFD287703BC6C66C57DB9F2E83A8A57DF5186E8AA492A65AA1636592D57FD58
      2D554DF349DD423F3419617BE8C38062EE30B453DEFFB8A99EA50EE5DD8F6EF3
      BB53597B67672A45929B3596F701AF3E480AAEF056415DB034C9B5805FA9D10D
      C7BAE9E7C297C5E1AFA993B3611345B1C18D1925C16C66125458354ECE86BF00
      6D9DAD3F2F6789F63945CF2C913522F8C04D21D64CE2C1A102B1B0D298A820DE
      246FE21476182EB43300D1EED2D9974E5BED9D25FA066ECE17886693882B47C5
      612C41466D7C6C0408906AEB05265BFD4C418C2AA573448A0F30822191706700
      AACC2D1EB54FA84083EA788DB2F4D83B2060A07B9A93A581BDBB14B1AB73F81D
      28F4E8BA41D0F76CADB2C052319681124BF987B2F17A128761038C1FF421F95A
      3D2F3631CDD2170A495BB7BA3FF88CE41D07F36058FE92EB28CB17AA93A6D421
      CA9EA8569C3EADA2ACB80F8E9972964574278A85B07A01DE2C575851C174BA59
      FF51A31A3142CF55AAD026C87EF9A81EB23E64B5E6690FBFF9FBF0F282D0C9B6
      3B0552744461FC42AB3FEA0C7AAA996400352F50972536717137EB95A66141E4
      1317D1DEC824898E543359685F5BC17674B4FF27C1DCA960D2F28153A60F40BE
      B04E95A01C4F20FD557658E50FD5854DBD471E40252BCF3D4076D0AD555B1A0A
      E2C0A40B2918126D8EDF3A4774D8D93B33E8F54378E12446101A882F4B4106B7
      AF5200499DB668027F12F12EA6B845B6200C25372641D36FE15D68C83FCE1112
      2D71C70B93CD6358B34DDFEF6BD4EF0B163BAD51300661643CB48166D7A318FF
      AC553ADFEF3DCCC2CB1F9352E8AD19F2831056A67D4A4C962752A8C024ADF20E
      620F30DB33422C2F94FCB0C7E8013E8A221BC293E50A56251FDBDB67765B425B
      D65303E808F572B55F9702AF8D5ECA4493F622AFD2B94559BDEAAE261D4E5D1C
      C88606D16C984FA4C28B74EE6A42D8C503FA2F52F427EB8E3D188D53F7A69916
      54B99A5C100359F087B1EDA9B0E502B3B4A39F998CFE813FB9696460739935AF
      2B2DA6FFA0800976A7710A610A96C522B9F3914BCC8A84950A36B23CB6FF2EDA
      7E0A2B0D0033774FDEAE8CD3454E98D3FDDC7956084F28391CD84C533D5D1A2F
      98069E5060739FE5BDA37D744A9CD7278417BD9F0FE5D9678DAB6203C9BEF142
      9CF662D588E4D6028D99325D542EBF1FBED4EC772BED27F7A8C8B9D9EF1E2CF5
      4B593ABF09445700215FCB958FB1CC452C464E24E78B79918146598827927E2C
      3A47AA491C5FD703B2534B588BD0CFA19FC6A9F6CC9989D441144C2B2017A8EB
      C46037014112AFBBD19AEB041F2E9B6E7035A3678AE700C9487FFF084386B838
      48320E9AAD8E3A3033DBCA00046A348B8FAAAF976B58647CF12AD508CE5C29BF
      7D8E7C131AE12AB7E5BA85B24FBFB21B9DCBA7FC6ACB902C56FF507F53F53787
      87878705AF20B3F03143806DED283B42759F89DAFB1F476FF74BB2D27849F11E
      538FA775F9FC1D37E565C8AA6DB2312E203847073F1D1C3BDE7CF170ABFD7451
      0F422EED3759874878DFC73CF4B1A866178AE4A1819304BBCB24810E097945D0
      BC72D83AE548B93EEE63512C63AD0770F1F83A84ED5C2546924C01350BA2833D
      0C63CB003694AF52C1535A53FD248813F842F194A98A6242759D84B1070E56C1
      C83DFC17B15FDCA555B518B3E461B2049CC2DF69892CAB84A21B1BE17A633668
      C099738458BF85CC5C7AA5D1D5FF48ADB4A9447008CEA044B50D11C4485C93DA
      FDE6E0EF6F58169D92149D614D7607094AC79B27DA5E0871D4DEE1C1C19BA3FD
      B21C51323C1674838E79E563C82832D93F61F587424E01A46C1E45C6F8E80805
      91DFF43C34EE816D4C0A1E149A41B1A3C9109DA62105765DC31173647DA56D7D
      35806FF48A5EEE552FE73237F91D83080157C1CFB54A19CE1A5A454B33046A44
      CD2E16171782D7C751C76C93D97F8525A6A9ADA590CCD7CBDD6A10A33D6F8BDD
      40023FD78A72A13ACEC252CDD8F758D7D43F0F1BFF3C227DB28893E59C2AF042
      A8628A8AE020330B7BDD436051E97039D78D4FED41ADE8F836FCD46C7706FFBC
      B844A27AD4BD382BFF24AAB1F1C49DE44B43DD38133DF3E330C40546A9E8AD6A
      12A279EF5F010E2A1C68B7F5048E6501BBAD19052CDDD2AF4575132D83F48B41
      96908A860EAEDD588D7EBB8F55FEABFA048509C154704483E49D39BF4BDE171A
      3E03A6999C0066042F84F34EF319942B0B4B3488B2AF82EEC1589E8044100AF1
      8A4F90A29DCCAF7B089740AB965F76349DB6A8FFBFB2B94DD705A76402615D88
      8B89AE04BAD09FF53A88285B5332E2BBCA808266FFABEA32BFFBCE0FBDE2AE05
      1488577DAC5110CD58B868A4BF96A64E1A488AC7C968B90E9672C158C6B00044
      9FEA42C2069145B3E18A3A4A9378B9B67187B56844BBFB440284D47BD1FAC172
      9717949CC671B7070652162D8BCBA87C6A57E484124980BF4529F4B9E0361CCF
      95EFAB8BE0FCB27D11FBE6AB6ACD818C2F48EA2F82010C8CF3CB76D10BE32260
      4C88FCCE6D547BC50B8BE9ABF05048ED382C21C8CE327BC6C944B7002BAC230F
      927C9DA2AABDB818A28E195FE3ADEBA45625960CDBA0376CB31CA1C1F90C3E9A
      587B0ABEF10B3144A4756BBD964E4916ABDEF093D1CB3FA3ED04F6FD3EFAD80F
      967E9929F353A661E67D2A8D329B99F4107CFA285FE92731E7B1F98BB2BA108E
      A9A2D686F2E52CE691F9A13BC403EF25BA2D13357B53FCDDCF812928F88B1CCD
      D74A6713CEC913ED4B49A82BBDF5F027A243E3422232D184D55DA21D41315D61
      A707DEDB2DDC223AD8B2C693F55816394B17722F5E4C28514FAEDBEBBFBE567B
      1572699BE4BF6B8E837D14EE20DD13A9365DC0036A588411716F4FD1E966A7E9
      A7CB30C88A21ECCB1058EC0FA3F6EAF4F70F17EAEC641F30AED8CF89CE20CAC1
      D458ED6551548E11BB1982F280C7C238DEE988B1CAA954EF4BF9F80DB06ED455
      82C2D029A64C12024479367AE7B63226AB5A3B5C964C142E1EC4236B3AA92B2F
      E86828F4BF147E32E9914E82CEB6BB27D97D39907A9F0D2F039A12965CEACC06
      43EBF0BAFEC76B764D88E0849A8E1329C8F634F7EA7F7CF8230C26FF33FCE32D
      FE7FBAFF51C58BA0441FD2A784BD549851040CE79C2EA1D839C752295827C43D
      5C8DB34C4C9DC3358E61040A9BEBA2492A2E1668F77D32DC69C579D7B49AEA30
      35D405449AE6A8BD427ABA2783C21CB92AC4F1F064D95C2BB50B0DB37B8782E5
      33762818CDC1A8885099B1300F62294C33193131A1A122030432A475C1FBC3C3
      BF16BD0B48E21DD12F4AE6E53F95E41FC1843248E325018BF6490EF4CE5F8E8E
      DFFF001A3945BC096837612293A635F597A337EF7F22A46025020BBE62FCE9ED
      9BF7CA370676EC122D5C1097A0B0830E42E7B28E1E089D6F364AD32C8A4260C5
      F05F8AFCADAD52033F6BA35A50F06C65E1124F2593B9E06807376EB5E6AAAE4E
      CFCE868DD3B3B366E3F46C3424C1C2BD6DC3B58837C7662097EF7FF8205C5A90
      4F144D3DED0E3F591060B950B5021384F921DC93662C93C4847313F23655F901
      65C8505911FA592477403835AB4DB877A1E551E5B49CC5A6D52A4C91E0F8930A
      EE9D1059D8E90FF7F4BA2BC4498DF1EACAE2D5D170C4C3270BE67B8B770916CB
      24BEA1D48EA3B18070F107A1EDB50797AEFF3F8250DFA8BDA31FEA93C09616DB
      D7A65EECEA64680148FFA18EDE1C96EBBAC932EF586C2F9D24E50DFD8286C416
      BD964D4FBE18EE3305D9467474B7AED668DF2424DA23CF7C50C3A5317E4E5DDC
      90F08B9302FE2BF443CFCE5FBF4136BF09B4A2DDB8C3695F533FE7491C64691E
      992AA9BDE05C5B3AF5B41FE80D967B3ADFC8B6E9B0C255DF4CB2F92246B3F421
      93DC7FA14E2028DD16D03FC551FF1D04F62CEDEBB8D8D41E4DA43E533A1636B3
      D0DE3A8E00AD816A76AB32D0AA2D5E22E8250DBFA9E597E815126396A18CC8F0
      C942F689AFBD4E2C408EC2937514A04A564B550A0FA4BF1A45C696962BCB4E87
      3894A1D098C65B47CC56CB2C6CAE8BF2031605F6DDC91A48894B883EFCD86D6F
      18A288E3923323A6BC5B8AF31BD8D991BE668A1E185EE616094626C716AE7A92
      596726DB9AA8D3587D64475F9F76D4E1E1D16B3AF4962208EE29DEF537FEE357
      0ABCBF3EFC913FF5FAB7C31FBFBE761AF233100D51368A3F995B9CB959823A19
      327AC235B7D6A5247EC168C0E866A79DADEECF7E51F0989904E1206620032354
      96896D4416FD94388403ABA578ED17B14F7417CF368D737416ECC1BCF79378E9
      039E4BF167710DAB9EB514EF58743C4E3DE61E20C1E60C87BA6F4ED97A09A402
      0841330DBF0EF47BDC83F759C6A040210858A8883F8B2B75E252C9BF97196F1E
      C959A006BB0C0344ED15F1DE64F3384FF12DEADA4ED919CCB8426EE90A2C20AB
      11FF197CB53639932AE36253103F48537485202847A4434E57509FF392B15D1C
      8E1DE630F8AA7EC903EF1AA5064C70C89BC387831DDCCFEDC1EB8D94FC9DB4FB
      A524D7A14B32E7C0356A06BE6E53016C94AEC223A52D2DE37A5E02BC6655D5D2
      AD9E9B90D866A55D6190A938774DD06DD6727F05DC0342F040189F8833290412
      936894182745220DA5689A4951CB6A3412ADF29D679B4FD9B6E50048265B9750
      2E5EE7D678B90DDAD2AF4BBE9D613EA90BBA8BA04D04D1798ECE144F7EA3E1E9
      D157012A6C24DD4FC2DCF49FD547D8B878DC9C86F82CA935C8C4A065ACEA0CFB
      B868E5903B850B8B0027D592F575E616FEE608439D6A824A0506746C95879738
      6D854594D9252D253E7C87BBE8D2EF1EDDF755DBBA538D4F559E520E475D0D3A
      C3734B355ADD4AFA75E46F144CEF34953E0BE9CD8E181BB4C3D12665ABDB2E8A
      B3F26D47E5C920F5D8CB8BCBFB014A591A330D2BAB457796CC2DAA46546D9308
      98E3FF7CB6444961820D82397A6C7DFF26F9C6D064BBDD08A2AF23F22E3E9780
      C7C511BA4C1249337186D7A895F04E2402DBC31432B561DF8BD86980DF3B3754
      83DE182562DDADE6E0A9E3BEB9B0A30B923626804D1B76CE6E2BBDA52A057054
      C10FA3CB2BA97276294877BA15E634AFBA8D8BE6155321FA88D7A3A1EFFD5C51
      B5223E36A10221AE0F420B75E4BBB908C02D26381C8D1A1BC40B2568A0C1C51F
      1CF3DA851BA4D96E5F345A97E796B1036816BF8B16126573A4E7243EAC836A2E
      35D7C6C060417B4EC4CD5E982BC8F69A2C538DD501EF54718A20490945EC56CA
      58966EB08159327110DFE3CFA8A021668BEEF0A8D1EA0E8FFF0C42B1D5E414F1
      3729A8B4EA8DF236DC948D906184582CE130BB1920ABC9C93A331B235AC64D4A
      D565455BB81D3C5126369295AE8843C7875DE81B54A7B41031B1D42465E5CA1C
      4647B4017D70ADFF23A3753539CD93288000A3F66FA82FE05177239DB40FD79E
      9921F1FA1C0F6B5F9EFC9D8198E986A3B2D3996C858B8CA034BC7F28AC8FA7A8
      0E9C1949860235E4F870040142E0584AF29A0BB32A7F5B86A2112928E09A8C17
      A04ECC4201BADB591A258106DCCF1E27AA0BA793C496EA5D68F6A38C446F9C66
      F36574DAE94202576C258ED5FF09045C9DF3F3F1F8D716E919ABCC36B3010DDE
      F22A46AFE2EE523CD99D38B221AC9172067A7194CD090E40D78C19375A3FBBA9
      B5CBCF17DBC6925B4267D0E9C8836CE188F8A9448A54A9127B9E897F698E0632
      5E45488B3C6633A677771E6EC556A7C34FD69479947CED5B876FE0CE2CC06FBA
      9A0C29026AE3162527CDAFE783F397A70523EEABE21CDECDDE559DC82EC059A9
      51436EFC708E3C78D10D9CEAF9DB7194A157C4EE8781382E374866EFCE8D339B
      70343BE7E7445CE6766146C4752E7D38D4279DA246260399E1F965BB029E17BF
      1ABF2410B7A34F3B6A8EC663A16E82FFB2D988368E4A34B6A358FD3428EBC22F
      D1196D835B153DD8E0973B3A64724BD9B7CF97350A8208DAC696E049640BF124
      C7ED2772DDBAF4BC08AD0709D786DE0ADCBA6CB01674BB4006EC32940593C779
      A5038CAD77B2EFB7CB007D496E8F005AC91A453DB6F443AA0478FDF859BC468C
      3B1EF77F6E8FC66322BF4CF2655690DBDD3D79C476808CDCE7FB2844BE73D4A2
      4813FD9B1B8406EEA2395261E78BA4400A46976B63096DB869D50E13F8B5BC5F
      430003B3581D915A710BAA9CB521B0A54C75ABF094830BBB38BD504725591DE9
      257A26F2D48E3640BF778F97BEEB532FDAB8FA9692E6A2D96346641B88645970
      865FC9A12E4AB159AFB9D9FA9757A3F178D8EFB41B5DDE543B0132D7ECE06EB0
      9ECF838BF1B8C78F25AB866227BB2F55EBF2E4EFE3718B1F4C3C92BC20652E7E
      6B695C0DFA5F872D9CCCA2609B2ADDC9703D3C38441B9C389FCDD5D1E1C1A1DB
      65EA0C7E1E8F5793BE49AE4B1E4FAAE7BA2F86E03406A827C6E392809E540B80
      AC48096E5007D19E6C1159406A490FDB5D638D44A1531CAF8A8DE9DEB7A6B1F9
      CC7BA93ED7EEBA0B545EE5D30BE9C9549625730DA1EC770F5D61B4F15864B515
      E4F7F503E0BE05F10ABB587CFCB966B1D11EA478F77ED1F803010B3E166D22DD
      A6619F6BB496B0BD58A851B568EACC64AD2458983374202B1B91BCD07B9F99AC
      1B4DF5627D0F7F72CAFDA0A97E1F29993BB34597A8EA6C5F688EC4E73E00395E
      21ECAAFE44290C8BD5DA79BF4E87A361D59FA1B049DA682609F2C085507FB637
      46C3A4F17870D61E960AFC188936B6A1382528C29F28C284175E47EA7CD4F9F5
      C90EDEE9E59B5DCCF53BD61EDF902675192A2DF652D8EE1666850F321EDFE9E9
      00577B83A5F6FE515E8A771C69A4F1B87BD16A95375972F21740954BD76AC793
      DFF543D38CF442D5D52BEA174318B357EC3F72190FF5D099AC0985E89E8201B5
      7143420872E2A4760ACD692C51F10E057018A0F0508F994137AD34BFD1A9E206
      603B85DE3A70BA5BCFF45044826D40A7626EA58F19592FC1CCDCB3708366EBD3
      A002B816C7D5577B73BD5C9A48CA8FD2955E1250065430FBBB442FF0D2D4F562
      0FFE2ACAD2416927284AB485888230B4CD4777A2A25CE82583692C03C1457EAD
      D11831F489B46B1B27B985DAFD7EAE63B75376D5B7C13D58A788E716F6EA0E39
      D8AB1E18035B3A3333B42AE286A2947370B713418A381E0F2FDA6D1BB6BD6358
      FF79FCD0CD41EF9224CC78DC6EF6A8D99DE45A889211C615E9D232CD02AF8FB4
      08A77EDFBE3C11F3BD9CA802DADFC1B0FD45DCC0404ACB53776667124195EA10
      2A462AEA462A45352F42163BD789CFD9F8E655F7B45A86628B889F77D842E815
      9516C0D074AF3A8DFE68A8CAF2D10DFAD46A739A679D4DF5A25E3C302287290B
      F66EE76CDAD5853D3139F566A01AD4BBA18E97A0DFB5B19D894E03EF1E32DE46
      958CD7CDF7AFD419559E6F815275AA4C21A019B1F812A384A3FAEE7CBB64C962
      5C0839B1F3DE9DB7464892F534B84A25DC0913644214F31CC8025539644CD17F
      DE31207A51F487433CA8D1B9BC1A54F2BCC2C051C041D945B968F62C8E47E10B
      E331295802338DC7BF1D7FE529321A3756088C8DC7CD6C11A74B2AFFBD62E298
      60F60C2199F1B879DEB2F8AB7E1213F11100DDA05D88A7B0E4036B71B962D6C4
      1194980B0D657CF56BF3FCAC828FFD939839EFD0CED505656B6BB39C4A213613
      5A2860DD2EA93E89E36BD536C2B8173F147F7FC23848C9DB7BEAFE10A10F5243
      4F87865304BB3C935A16FBB19A21A71378540F115A8E25680CAE2125821E842F
      000E5E00EC46A5BDD25ECC69645CBD84C18194BCA3DA75A2DC1B35478EAB3CE8
      3515534761EA5F0C72A16A1806C08C3AA7A57FDBACF9FBEAFCB6961A2732A154
      9A48850F791D445D9C3245C043027BB70342B27B98AD432364A6E92E2C46AD3C
      CDE285DC6A22DA03C9C2D72D6C82E50E2301CA5F14360688264E52EFAC137F23
      0E1140D4FB5483964A67648FAA0D2646A1B29F8AD5B218A06B3B49E0DB2BED66
      CC4AB50CB849A5A8DF692E36395ADFDA8DEAB217AB421B52EE93358576A1AA25
      366E83AEF3246FA83948F5576F4B83EBDFC4F3F8BE7174F0231BDFC4BA5234AC
      51896572DC010EFB50717161F0BAB55D39312060DB882C6F542B3393899BD8EA
      0520652B0AF7ADCB86C22F3492A195DAAA7F761A0707BCC23B49EC954E0FB256
      6E511F573ED5E9798C8EF7553C4963F2C5BEF5BC6F1D02D86ECCC2C41552499A
      A1EA91B1BAD0EA4B31987000DD87403E5D4884013ECB27F51D789EEF721E3AAD
      65C193C8781C4EBC34185FF0584EF31B8FE5C99D0C39DDD838195A9C91256A0B
      11798A239B1FE4C11F76D59F385CC149C765128C52DD9332B20958EBDAEB482F
      02CF7E707F87E10A12AD30061390212FCA6454FE0875FD701CF41B8F27923FE4
      C2C250DFCADAB07545C510423509F6CAEDA2FDEF7B8182BE92325D42264B20D5
      67225C7D9613C9DDEECA00C4E52AFA67671164E8FB74D3D3CB7FD2D1FAE7A97E
      88EEEF49D24408934E86BF3E12037C929C53BD985D6C269E23E2D82DA258676B
      8D823454AC529E8F1D6EE969700B824F4A41C0A92968C42B278361A171A4842C
      B7AF43E8366A901338369B3A0D6E79738BC67AF5075FAF2297482CEDF8BE1B2A
      993928FFD9045B6B05225894C301F6F44FACD0B3525CD6B72E38334ACB481BD7
      9D8FE693ED2ECBAF3314EAE19D6CE42A27CF574951F9DBD43C647A54597DB6A3
      802507889BA4BD8833F381D8C65272CB0A4AFB783A0D9827248EC3941908D64A
      A397E074CD9DC448F570633BED65B90E798A691633859C61E65AFC1DCB4CB17A
      E1A422925F6A49E3346BCCB773D66B74A8A51CCABC6812687E14902584E651DF
      53205CE928C7ECDF8ECC5520912D30CBA355E0FBA1F9C46E2FAABDC1CA5160FE
      08FC7B6DD4E72E9CB618250BE8A6B45C1A0D894689D7D02DCF2A95CE54B71582
      583198661BE85CEAF4415124EE3E825C3BBC448951BB0D8A2C12377A58111DA7
      4237E0462B0E85CF9F5C6B324776281BB225B5ECAA681223C154BDB28CCAFE2B
      CA28334E6D078064A1255F897F8CABF8398A0C6ACF11ECEDC3FEE7C2C28199A6
      AF76E485328B659CE82440F8477A0F4060E214138B18131C2061DA68B6061D8A
      C32E8B29ECE20C0E3BBFF09209B10524006AF571989FA7F85F08F5A94AB57D7E
      32685051A1300C705D993BF2519855D1373B8C57EA609AFF51F648A25E5705E9
      E35E3A0F96D55F903F7A62B2B9497DED9848E99ECA85E71CC3E7D424E21A1EAB
      BFA9A337C745B8670F462BDA77AD15F24C66AB07F293A3F297ED0645004A04CF
      03BD689C1E7FA513F47416B310A7DEB67966AA5277F7AC694982F0D06C8EE808
      C5319158502BFC2B9B9B35290E3FFE1EE9FD548E2D2247143E12317889CC55BE
      5D04C63EB8498C92C1CBE9FB55D22FA707086BDB82422E7C4224F0E276D0B6BB
      DFEDFD6B12EFD0A8A634559CBE6EF39D6EBA69135EE126682C8F9A5BB2DB32BF
      EC95246A8E581614D5EDFE18C0AB40DD53B085BB3D86718205201CF4C58E6CD0
      846B7C703E4ECCAAF17F7E374D9D6A20FE874AAA1DECC0BF1CBD3D7E878C98CD
      F9DF29DE4C0F0A96C385460F6763EB04B7B8569F6A126F90C6B4061D8052C4F3
      2E0A1CC12D992263C4E67AC8E352CB1C1F7F529EA6AE90C05D32B513C53ADB44
      7ED5E7461C3BCC0E1303206F3C56BF8ECE813CB05E8F4ED5688EE4933A373726
      DC6D0C0293638C66F30CAA990C6A6B0D6875F6190DDD2DFB8346F19E37279514
      C5AB725724A67566B20660A154D1CA684C185E4C03844709039EE39489546898
      531F34B8A87D8DB076345CE9252A9DFF5964D5296A804916378D20E5CE0BB549
      D2F0953B5BDA8CB2464F6FC454F452FA90737D3E7A44663121E86A708267A893
      E3B045D96CA8F8596AB8DC3CBCDF9AE7E75F3719196063C9C297740C596C99BE
      6C8BD1021776F05C037F21922288032A79B14CF841660F09052325B33237EA26
      4075789C90A971830A4926212020C64EB31A749A0DAA66188FB963796101D2BD
      29632FDCC9114489D26D6DB3485B192EE3A41082E5246AB47EDE6976F0FFBC44
      A77309F290D74B8C98362C8DE6F689F2E641E82726721BEB33E40637CFF2D5E5
      8D494286D9C93A00A83C271A41943B72FB0B5B3FB8C3807C2F845046EE056D73
      16CFD010A868C9C4281F1C080B64738BCB5806A953AAB6256797F13EDC0E1138
      2DFCAE6C754AF4AC615832D5A77738EE0F769B099822C10D9DA6443B462D12D1
      662A566783CF7D35371C570BA2823193EA2B34E3BDB23896D6C66CFDA3351EA0
      FF0819ED3E31EA28A353F52541FCA4921724901DEE86F1159AC3A66A77AB227A
      BA5551B4541C18613F93A4E2636E0A1F369B7D04868898B6EE3C0A570A720EE1
      30F0075A628AE20894B4ACA41A29F7A63D38DC2CAA823BBCEE7F9E7D74F427DB
      471212237A72B9AE94C3E2E00E935ED169311CBAB0020B9D2C6F1D754981B06A
      34FB5D1E998843AC0661C0966D427CB2163C7E06F84F56E1F7B59D52773132F8
      50754E073DD2D29DCB41575019F0B71110A1F02C908B34D60E4395464BBB393A
      1E8FA9C19392302817D330EC82FB35720284963E428ECC5947DE3BB8BC0E2500
      9498570AF615A7E42090C4167CB6519BE3B1554C6DC3C51528F143D7603A59C4
      61F30C835A2D38885729C2ACF902356D2286392D6667F5F01600F172DA1F552B
      480FD4173A182B4815F0E8AC34414BD1173B48433D21690ACE5D001F217E02A0
      22422AF9D6A8FBE39B7BE02C1B8EFF7CDFE9CD57C1AA6CB8B2EE8EC8572A1240
      092205D819C757A234D35D9EDC3ABF1CBDD093E1388EC7886AFE03251C1CB8A5
      0E3C68A44543518F759BBC7888B9E27BFC4146A083C985CE18F98625A479775F
      509E0F77909EDF6C5DECFCFC7B3B77BCCC9E3F3C54F3050EC1BBAFDC76B9AC97
      86BFD0D3299A8FA1A6C5F525DE7E55DDF6B9ADF4EF03E44DB5248B5C6211E6D6
      0B7382B757ABD9290251B27352C5B2E5CFD9652A17679646A93F1A5C3C849FFE
      BE87CA69A32E70FD2F83677AE87DB06FB59AD8069A74A43F9D8F5C87C059EA9F
      FF972D8F6B62634EB031A49777B1385EE080B2B2BD3CF93B8454AB7BFAF36610
      A91B7144D4A25F112358392F3F0D5661551DF5BBAD1AD78A530C48B22284C8DE
      458F7F199CB7E97DB8B4AA837B80960F484E95A82772AAA318B00668F4B2D241
      B29CCF66A2CE168C54853B815B38E356DEAB098204D8C7EFAF3078B857CD96EB
      F30DD3784F1BFCF8417599DEFC7F72F0EDA3D2017FE083ED91207FD9A78F96CC
      E3CAD311C28054FC5BD8D90B1D44DF30B6EF6492C42997E7117700152E4B0095
      FF5A3C0CAD22B46D962194B48291613804852BF01DDCBA6F0E2D8EC24383479B
      9D22AA833FFAE8FF8A737AE6024DD560ED21E4FBE8373AB740846CD3366F7EE6
      46278FFD997654155BFAF1B1CF26C6534A6DEDE9A3DF3831DB3D50EE1FFE6FD2
      EB0469D3BDD7CC137E60D2C5EBFD6F4EE8C3DF1E3AADF4EC9AFA1F87FC7FA7CF
      F0ACD7F6593B4DACFA824F7FA689B6D7DA257AB2F8F7E5648E0E55DDAABCCF5B
      559874E0518989AE3B53756A26EA581D1F1EBF2B90F28707C70747EF0FDF3B92
      04FDE5E8ED21C62F8562B3DF7D2E995D166D9E990A2DF099C9A4C641E82C282E
      4C7D151393C62140DED24B85B2201A25F8AC4DD1CED155AD6D4F908019823CE2
      D895D87529045EB6D10854FA9A1460148465A218AC104C68F46C6AAE0462357D
      4B96DF9D5AEECC2D4054316DEA834EB29D5E400249604546AC8E5AF5F02BF90F
      B9F6DF3C266F7EFA11C7B448CB8CC7BFB43FF72558424601F7A1393A387A7BF0
      FEADF328E8ABF5B0E7EB3EFB37DF72DE9FDB7BA7ECC3669077AE7DF5AAB09C5F
      A9444225B47D5492294AD32333B70C285018E399B2B1E8135324924E8B1BCAC6
      E49BA224EBF264D851C59F77190E4C21929C584D2C1119BD32060A51F09A040F
      F77479A2234A7E5CC54184C7B0E303518D5EB1E4296545E45853851AF59A442F
      87360BD910B68A1D8715CE49A252CB97048146330D3E17EE30750BED7DFB559D
      9E5F522EBA7FDA452EDA16EA306925370258A86017777D2B8F2B2BF958FF03DB
      FDD7558DBEF909E139E98743CC77CD51F3E26E13D43FC34DB0DA6E4F8B9E23DB
      50FEBDFFA1684F07D87DE53B1B4AF1DEEF7E543A45D70FFB88F259F778105851
      A145B216F71456B8A4120E000A9CE636F31544B35485C135282EE4BC4BA10BEB
      5C49B87FC3F27E547D6DFB491F95BE8660FCA046437A0BFCF051E909EE917CF9
      839AC431F1D5FE4D8D921CDF990C499955FF728A4ECBFBDB8B70AFAA245585A5
      59A297B75F1DBA268A93E23EA231A14F4123FF34C5FF84D578F145C03EDD33F0
      63BB90F247F013F48E3D54BBCC8292AC136322744664C83276846971EDA7AD85
      256D3CAB8371E71379FEC1EEF6FDF5BFCDBE7FF3E35B3169DE7D655217FFC553
      0714B3A9B65A1E5EC382F084FBC8E999DDD6E5C5C633BB201522079522F11AE2
      03F86162F5760BC083AA947262E331286AAB78287B6630B2049B2CEF86EBC6BC
      7FFFB84DB883DD47C1B352B3160C21234B8EB249E8B7CB484C196E47DAA0E813
      A16DCAA5BA83BE28E561EBE774A7602DE95CA17103DC3BBC018A19C81BE730B3
      E4142E2E479D0AB76CBEACDCA05D1295C3FEDF25CD6BBB7E7F93F9FEC90F1E8F
      4FC1625698567036019FB0A4763B856661A91F789E27E5263B107B94A1DEF1F8
      A2D97BBFD56014ABB3CB42744EC17EB3419C5B09B65BCB7A9799F3E9FF323C1F
      36BE0CCFDBCFF04870FE8CC7C4F453DAFE004894F99F9D02F767D5E776A319DA
      92B034DBF1D1724DECA35143B7FB43FF717959A1ED66C460D13264C27407CF70
      659A3D22696787EA2E79538D343A7C1F4673165D5FCAF9ECB2E383CBBF178363
      A77770B2F86D4E4FB113B6C206D71594228820EDF054142AD9BE576561E08D99
      07DEB3480161FF6F930417E0280190012824D0EC63A45D4F1A62D41910E91A55
      1B59AC89EAE9B5D21417F80646E369896294711514A8DC2178B45EC6BB843040
      AA880D25A46016F8EBFA4334E54F9B62B777366CF49A23E4F04ABBA3D0433B3D
      9A3383A488AD28D85172712D5B3F89453B701D1BEAF172D4964D89CD427282C0
      7F4726CED3704DE5B574F2876866A8FE4A7824A971232A82DDCDFA7FFDFBCCFA
      F76F0A169F8AE928519B5D4D470839D26DF7F90AC806A596BFB4462E83BD3E68
      E4B3DB1DA2395C9E22C0DB3A1FFE633CBEEA0E11BBB12217A62213C60AB66B3C
      06D2CBD2756FB643140541B857408563ED0ABC2FB43DA6D50609F47D9ADEE90C
      05FFA63324A501A4C66EF325C9DA49125F1B4E94A275397957C2CE875917AD03
      9D0FED4318B6FB1ADD7EA7E4410FEFF1B8C372B7E8299A87A1EA44F9E2D96289
      D42A7CC31BE0C02CE5C99F164C748B60F6D0C61557A1738B2806E1F783DB5D5D
      B73B175CD5C5C0FABE0BEE74F4E7FFA6A36F9BF15834B96491E2442D8C1FE48B
      9D1A4F4B9F4445049C167200FEC729127ED3E0D62D89C422E8F96F0FE84CC7E3
      F356A7F58D60F5531F0803F1CC64C0C5F443BDE6FE78E27E711216FCCFA376B3
      A4D775541608B036AF7A7D8096E1C214F0458CD0BCEAB11EB32550CCE960519B
      D669C0E740349C6628B48BA7CCCED1BCEAB96D12E5376CA70FB4951B8DC75FCE
      A8F7D11092C9BD2BBDC4399EFF00947E07E7985B2767171F544B27FA46470C15
      D9C177E0A7A35912E7DE7B832F587E48C8DFA9D54B8A8A3918E3205A712B6220
      1BBB9BF6057BD633A131CD2CD3DE35CDFB1E1AE7831DDEE5CC64E73A9AE57A66
      6AAA9B5E98DBAC1506CB739D027F99D5609E44DDE832B9CCB3CB693F5E99A499
      2CE2E4934E057887AFE16A98A41B9D98343BC983D06FE9C5B246AD59D26ED4B9
      5DA2B63200457A3795BD68DEE82044D08C9DD06EFA19F1F46698B5F2E4C68CA4
      DEEF0E63F50EAF7AF7ED888069CDED48DC16F1FC08D03CDB89E9A8A6CE8FABBF
      38AEA9F337D55FBC71632B8C7D30F210CB36CA360BFECCD044B36C4E0B184C55
      00BDC41C5CF44F2DED0976391F5DF06F0D7442041E96ED1F435FF3EEA7BB3C5C
      D862210394C6A992E2CF6CBDF343F1CC9A6A2E16313A66E70B92DB35AA269C1B
      CDDD3AED0F039D99CF4B296DADFCAE8DE2B595D1CB38B2137365EBE2A9713B28
      88F341EFD2E9399DFEE9B1CDCC69E5E1AAA88CEE4AC03043041570E0A827DC0E
      53B51293C51A9EEA8C16F9E1FD0BC8F9E132670E93AB51E757E10E17E84C853E
      D98F510A6F0DA3C0B55E988C952B890D110196845B76C07C734BF489B5B54995
      426337CF5B9FC6E376673852CB38A5853AD8611834CA914C02D501953D5729A9
      B895E170C61857BC6DFFB94230F4C87E9E89E3DB20AC031804E8BC179C7A548E
      2D843634814AEF268F1A73604A3B79F0968D5A9E5AB12C2B7D4F2C2A389D6BE4
      862A1F4A011D5BD829C301A1B597EFEE84886A5EB4370226B6B386444E1A0333
      D5E88157E3196C3A43EC24735481D795889A5CEFF93BA0C2487EEA3C64872191
      E1C946054F859F53AE0C7EBAF52862BB4BB27085AA77ACE596D04A053CCF3DCF
      9C9E269E77839B08FB0A511C561488E438E693379DEDEA7D21A42AA2C3C43756
      53BD4FED518D024835199A0248DB8EB9BB8060A79C5C74F6CCA901CC17C8078B
      A77B35BC0EA257A597C1E9CD9D82CA5442456DD75A9F060CD5BC0AD200D79A88
      186CD76994C3EF344EF1F85F4177FFADC8ED135419609B6CA113D157101198B2
      17FB0823AA200A760F23CCFE7D515822B4616D77D6BF3C6B9CF52F4F2B8D60E3
      84482450E6BAB67408CE43113495207A1562469209596C639C9D65E015645E40
      6C33C5132DDA9599690B3196AE8E123B0739F1836C2D4F9819F698DA441733B2
      C41F10F2A6E8DB20F28A28842B526B2303F3ED10F2B727F40690720658177057
      5F9DAC2D3B05AC1F54B7ACE64860FF9E07DE352057C437897DB325BFCEE31F15
      5B65BB4922DE417610C161E6F1EA723A553747073FBAE2E6DFBC798958AA7475
      1C8C4EE9BAF16DF3634F90E8E6362BC59A2729F50C3D211488EA82051D3A4B84
      01173676F4A50838A752A22A519E105920484158E478921A18F2C8872D13330D
      6E1B693E051B90F6FD86F4C5416B4A933A46FCFB497C8386E655E01D65238942
      1F6F69117D6249EFA851BEDA2B2384C74543DE574DDF8F23D58D7C73FBAAE061
      B061AC8951C43DA217936096C3A0D3A97A2500A556BC980411773CE6EFEF687D
      5BA434FB4CA58307A352EE6CC19685B05B4E705EBA7471440C493B7813D85D24
      20BA6D15C6F175BE14AF1EF2C6F90EBD84A3F5C8C5FF7BB7AFCE2FD4C5D5B023
      5D40D4CDBBA303C756098532D81AA519CD69849BA383370747CFFE0EF13C8AD6
      677990E944DDBC3B387CBFC3086726A3E05873D00C215FBC791478048065AC26
      206488CD988594F7D588E83E46432094DAC3018B80ECA782E841EF72177FD542
      8F38D7758A262C0DCB5941C462CEBAFB1D144281E8FE4052D5DEF0660A545689
      C40685E18C1856F8EF29E8A8EE20A19C0CA5E9D30D256B38BC5517674EF43C3A
      F1E6285BDF64DFD24CAB676EB3049C18147DB8794FBFBBF9519D348F39BBFF6F
      63E07973F8F62524C2F0F42B6503549D028CD261D7F6DBAD641FA4A15C4DB98F
      73D9BB04F613E2929699E0102A4222D49B6B2C3BF41783EBB8159C8972EE18B0
      03BEA6D463C3FE59DBF6C793F7D48FBCAAF346D94AAD775703BEBAFC6F75A2BD
      6B1C4210FB0CCF85754C78C3190849B60938C270642929878213A2837336F90E
      DF6FDE707679161AFD831E8FC43FE1D93F15E6E445BFA5D0632E793CFFFBED67
      1E15A8F0C670D8612D72394933ED599AF02C56EDCBCB418D923735351A743ACE
      83157BC5054045C88328AFCB4BE6FCFC1F2BCFC719BCBA24264DD8D9E26D1051
      0065EA6793029D5C21AE7376708F787368D8BB186E613CF4608E110319FFDEDD
      D59262DD375F5193C5DE8A9CEEEDF573D210FEBFCF953E24A70912CC72ACF4CE
      297983A2B724F032F5192C1C23445A0ABEBFCC2468331AAA858972F7A6BB18FE
      786B788B3D3CFDB5DF2EF01D91AF7A9F87A3466F383A2DF3CDCE6322FEC77149
      A9E5CB8C5EA8ABF62952DAB6E4163113129C68DC41878BFB3E6282A2708DBF53
      F1DAF14F6F37A5D7C048BF0ACBE711A271EA12645DBE58FA3B8BB563AEB57DC4
      4BFEDC57FFAFF5959D07797347CED9D0C94698A64D5C77B9515781593DF90E94
      FBD5E7FD7ACC44B2785C26ACA5769ED8E0B991C784C104BD0EA46CC2769D7CDA
      C62B3F100D4726153DB0C241F6D8B4C896467173A593E6324FBC39DDB16C9EC4
      F94CDEF400A86EF0BB2699974BD9147F81113492D8E7D7217187921C9987D0C2
      EA303437E847F2D89C1631EA5C3D8E3078056B270B2A8A004C75802E2C2A449A
      18993D1A8E52BA44DACCD92D0D8A24BB843554A207548328BEB64D8231826B16
      A4D95671D21DAE07EA3EF40CC827EFE97216464CB9DBF04C88A6425D0D1E9B2A
      4585D91367BB0863D76CCE53568463D5F2341A48CEE82B35FC79D8514B765183
      54CE2BD060FC121A64C6A4E0D0A6A032C57F9BE57EFC7EEBA68B4C11381683E7
      2A998386BDFECEE351B5CAC5D587FBA5576456C8039323CEEBE8FE663FDDFB66
      97D3296AABDA18D1F5D13F1EDEFB680BBE50E7AD4EBFD16C75FAEE231C5747A8
      91FD6747D1919F7A7A69DC1FFE66536F551889374D6FF711C81F0C52CF84A1B8
      52D2651996D76E27F647491E7C253B83E8C54A085B1C096BE526BBC54F07EF8E
      DC5FE6077919A965F9CC2E98E4ECD28F54A840AECB2E2C724471462E847DFE4F
      AAFE1FEA934ED5D0CBC3251FD91D0620AF819B45DA11DED5CA41185A5568F49A
      EA6B24219A48ABA66521986722935A3AB9D3B33EB1EFA9FF547DED5DD7BB91BB
      1B4C4E70AB75A97E252CF27FA8561C273E02B1E20F6036D250ACF5F3EB54DD04
      29FA84857A8D880BDD959AB24FA2EDA282389296CE5B0F69F55BF58EFFDA3A6F
      51AD6CE7FCDCD9BADA121F5C6B278901C74BB7C77DB1D8BEF78314B7615FD555
      6AF12B880CA658B598ADA27477753CF90E756C03074237362032D0522D135586
      0EA90FF71D97EC6183F0FEC7EE1D1E1ED5DF9F9EA2A01DCD3EB9575951547DDF
      8005CF388544B5152296AF092D810FDE1F7D834C0D66639C5CA7CADC6AB22A71
      562DC7DFFD53DDE80B5C040F69125B53383A38DCB6128EDF6E2FF7F18FBCDC5D
      7400436AFBB10933B17DA501FC26A152A5ABF391354391B44A0D15094FCCE627
      64016B2A06846515504726989F64784E8CC48225A490AC8BE0A6641A616602EF
      9D207F84F0F5066BA7B6CB46939D6AB4F2264C0796B858DAADEDFF7EABCAF546
      BFDDB23516E04C01467C0375C1A91F781B71B2B08BA7573A7175BF8FDF41CF0E
      E8E6736761E9CCA72E3E9F9FA3DB237393179D182D35103208AD245898B338F4
      AF82187C0D8DEAEF367EB88823880DD7DE707F393AFE01128F284D2F658B398E
      24BE3192CAD4CC0FF602ACED5F711AFEAB00A6E10DEC9DAA47FFDFDBC39F7E70
      664E3BFE01EA7C38ECE0E6FFF09625D91DE9F8AC3298B86EED104135E947DC69
      C0C5C15F882CE69E8E31B7FD954B1347EACDF124C89E755A5E1C4D434488D24C
      67798A4546D8B738A5E071CFC8F52B082D8BBCEDB34E848CB9FE392AB807DA0F
      782AC57250D129A3A28896954B432A21F14720A88E13BA840962AF0CC00E9F58
      16A32D42B8D2EBB420DC22FC333721278CB7DB34A6546A39C18BDE9810CB5F2C
      4B596F268D0EB790814CCAE5512768266A67EB7AA3F04C1D1DFC78F0E31BC73B
      F3C0F446AB091C9E503AD77E22284D624F51463D98EAA99E9AE71C94DA5055C0
      266A41C86E8C283B53699E73E780F38E46FA2698B1A39625C620D1FE9C537CB5
      DDECFD154E975611103EDC260166896D5DC391246E94CCB3963FD4641D8B32B9
      204B4D387DB24E7B8EF0C011451B6D0B58F09118901EB1C255A7C774F828F36A
      912B047410BC85BB3A2D5C3C724A29A4FD2DF690273C95015745533800DA1F67
      8D79AAE22F6AADBFAA954E682DF404A69CED0F4AC4CB44CFE43CD2BB624D2A3C
      02549ABF6B48E6DD4F850C3631F2B78C66A7569A48051193A6E8042F31B85D5C
      60D00C03746D787E5DC0D67A7FD01E6270627AA848BC27DF802759C1CD68AD3A
      C31E77C845635774A70EBC801838CD2DFF7BDFD22AF3FD2DFAB9588395785E33
      E9BB5B9AAE8848E3AE57F201E48DA41AF1D3C95A9CA905C06313E229A43F1054
      994D010E3BDA9F482FAD9220CB4C84AF17BCE1624CDA061A453F52D8D1D6B3F1
      040E3C59AB5F9AAD0375AA83507A47FB008EAB85D15027D23C9543C3068DCAC4
      860F66916D8F5D18EAF4E9A0D4871475C1349F6E7BF7B9770A19F8D6B97B6CC3
      B6CB50855BAA78465A7A7DD84A9244C677EBC36A396FA8BE89EC8F8DD9C284E5
      55E11E265BFA06E15F4AB43D525CF18D0980A17B6348DB8BBA621C315B204F4F
      CB94F973D03B6158BC056DD6378B549C66045396141938C40D35FF29FC37EE28
      45C7045485C08CEA6979EEDCA63134599108BA3B1D3AAF0268C40A942D3AD01A
      026C76B87871D26DBB8D5E98218F0E5FB693AF8C5F5077CD83D91C52F44610E9
      EC7CBB6F4A9DA0BB3D7D6DEC84963AD10B9CC19AC8AD226995C2AC5FC779A55F
      327E2ADA25D7F81508F70169C1F0D5E45A754700EC578E93D4886D5E40E98469
      1327A8E883469994B9A38901E29116A7A852B9AF95DF63418E2FAC6A1F8FC920
      003335D99AB03324A236A71A40FB4C2906C17DBACC6D56588AB6DCA7220AC937
      E1CE7C79049F002A224EF88A137C87AB736CEA7B4B62B0B95A3A7D225F27B930
      CCE591B945AB455AA2B98674DF3A124E913AFDFD0005476BE2F0F87D919F1E75
      86AD3058C060E8C570551AAA8FFCA83AE77252F64DC8A9D45253875507957CD5
      FD73B6CD10746859994C80168E3AC0AE4ECC3431E99CC9F58ADE6D34973A11ED
      39635B8EDF2277737672DAABB6F242BAA90E7C34959DAAE1DC18E768CADB37D6
      5002C5D178FCE5AA39188F992500998AA8D1D38CC9FC539D85CABC04D788AA04
      B2E08B9EAFCE8F7E6B1F2DBCBE3EB716BAE30FEF7E579E7E55EE2776D9B62F29
      99AED5228EA81C4087CA4CA7C4F03E253B4A81CB7F1EE70941561746ED55BABF
      EFD7940E1119A328286E87B4E984C4BCD36C1E387B9340625110B6FC449CA435
      6AD258C46C21F70B33B16A4A152F051D90CDC9A923E78E5AE36E01F6B7C56D0C
      D327C964393742104527C91A6572F02AF5747A542A29D8DB5C0B26EF4926C2F0
      F408CF3A30B7E63BC2DF62226EB76EDD7EC09D9D3D96C331306180E63FB06318
      719E1E64B78F9AA532D15A95259B1630001C7BB94C622DBDA1A5FCA2D2F147D4
      6D1AE7E8D0CA36BF18B945D759D040732F646BD097A4C8E50C09087CF0E4F7EC
      C27825E77464D20CA1AE236A4050FC74A83A8CDE78ECD51FFE32164074697112
      5A799AC58B83200A6CF303CE0FF8419A98994E2039266BBB9E2C9EAD254D1D05
      C894B18B90C576AD6057D26A3DFD9CC03CE82E16B84F6C2114937C9D7209DA9D
      9CEBF6AE17E75BE25E540814A2B4F223070717888FDC98037516DCC025413FF0
      E00F5363630C2BF3C3DBFA041DC1CB5C135F1F985652A056F863775BDC3EB6BD
      A7084CD64728301A9A6C8BE06CEB4D2EA3CD83877B0C9941152B14B98EA76A02
      CE0D0EBFD9B44D5009A8D056E2FCE7B8EB66010E07D9FEB7D8A977EAEC4410C3
      826EC2ACF86B195A00923C3C3A548B20CA91F7E5A25D2A353E50CD10ACDEB3B9
      05D3C0384D214CA4237B12AF50D340D56924EBECC40304D0676CD7B21F926648
      3700D9ECDF04423C0E8B00E56D74ADE038435573AA54E55106E014C514A5F2D9
      966BD94128A617B344F59FBE45C37C9222AC86DC3A963C5F3E7AD510554CCBAF
      843A8FBC390408CD4D7B3068EEDF1BC9E051FFDF20E2730AE20EAACA8EA72A35
      6041499F7E797E260841870DD8136BC09E861A94B9DCAC1410898002138F1BE9
      0C964B82594CCA2B33DCD18A7890BD24CF8268ADF62CA60EE1AEC532E03CCDBE
      6D7B65CBEA2AA67A4D69B2E0C5FA2F6C6C9FE7E6CDE30020B992F43CF0D13596
      BA5F916F131984896FE0B14A9DA534D8A28DF7F4920BD9A9948B6781D10F5417
      F7DE4B724A306731E482444AF0196A193231F0AC446698DBB9CE538CF45172A6
      B052C5575EE028E61185C86E0C451AD214386CAEC6BCDB87EB3179C039D453AE
      2FB0FD697A7AB9C4FFB6EEF463DBDC27D4B1617B2C5B14CA1E6C28CC3E5A4A17
      E86543ED5D73C0DDE086203026EE8E2DBF5D682A4D5F14AA2C484827D44B2A3D
      A1D1934CEF2C8C273AACD129AE339585A6DACB22AF9E4A95FF4660A430F0B0FD
      852CE578FA41D9A683F07DD1E699404C2748509F2EBDC651FD2BD510E208BB85
      967A007DE080A0CC907BDD9293303499DAEBF6DBC37DFB7CB7F808D96104D701
      9886FFB10760DA3ED965FC33724ABB8D23E44C6AEFE78B668F1F4D5911FB7B7B
      B8F67E1E0E7BBB0DD5F4FFA5A9246018E9A5BAA0BEF47B17C5B0F86551FF89BF
      AABDE1E8A2BDE3324ACB676E7A4C040F3498FCDA3681DE43DFE3E719491E291D
      52398F57ED3BBD373C1D0DEE1FEAB1AB2FF8AC54EDF57FEE5EECAB66142F74F8
      0DC34E92F51C35D9F8FE38FFF1F8E8F83FC17D26000DF48CC0219EAC33539FC6
      491DFFA01A64F92C073DE885F26809026D8FB34512E8B813E778F86588C235F0
      88739AE32A7BF0B7F7550BCCF58FBF5377CABEB98D624928DB27024F7512E666
      9904680A1B2CD37A61DE514C822B5F9681845AA3320C2EF0F1EA87099DA209A3
      28B903087E2CE524AEFA8EFCE4C8FFC6D0A905E7B0AAAFB69964AB0B6F6EC5A4
      6FD2EB2C5E1EA856BC64A0CDDCA4368F288EC3A3C3A5C62CD26A0B35B2A748F1
      7C87B649F48C885EB0B056F5903D22A01E00A0112F9D7D238A87300A5120C884
      AA8E5325DDCDC219CF873A263D5274E6B2CAA114EC520C2FF11F4A94D8262689
      29B241006E0DCFC55AD588118935859427DAC944FF3F716FDBDC3692640BFF15
      5CCEBD8FA96992965FDAEE76CCF40D592FB6B625CB63C99ED9ED766C80242861
      0C026C00B4ACD9D8FDED37CEC9CCAA02489114A5EE673FECB8291255A8D7CC93
      274F02826798AF98A615D9545AAB13D7575597F31163A770DF80A8D28E20DB96
      FECB00991ACAACE278A0618B1FE037DA2B7D4F4286297D7B495DA0D8D8389981
      FF844A778EC5469F6A4400067E958819E94E9CE792FD9E65413AFED7443250E5
      162ECAF492194224A9D70BC9578B8E7F92C543E0A0F499A9109694D3A813B4DE
      798562F0EACDD0F51313A672C34427EE6B9CA563C01E7ACBDA7DDD8BF67F1649
      1C0137EAA2C8B40A214C5A7556E2AA2A46A94CD230A9AF31D5CA05809D42F3D8
      07E7E465CB04EBA4E15BCBD891B51C4F897B447B52C4168758AFC5472B606C3B
      B37BCC94090701CB377052E04EF25C9A1CF0C49E08C57AD817B6E66C96C49432
      82952834B9D362FCDA6584A413C0995835B302388338BF1986A12EEC506249D8
      D2F54A209C3A2D61537AC4DB9D8213E7D934FE4E236FE5D41F935C29342D2E9F
      14078CEE7C059D7008AAD50DA350629130DDBEC639842CB570D018B30242AF78
      24D2A16F3840089BE4373AE7F228390F0CBAF28E785000D79F337DDBD0BAE039
      9D6AB49B000702ABF411F38271915C9B73E9D9F62A72C8E074CDD511CB6EF82B
      6993137ECDF9817A9EEDF821BC7D44EE6427F33211A725E309394ACBD15CBC9A
      5E5460023067AF139CDDE398D70DFB31CF31225CF7800CD4D74DB3AC6FCEAC3F
      A7363FACF763E288D1DE2576641D51257305B283195178ED443CE1558BE4639D
      66E9BF6C37DFFE544D158AD66146668BCFE6E5AC10CD1EF3C71BD39F560CB389
      33302AE6650C21B4E800580042DE805894D21063628A3A1D4549FE352D8B9C8A
      2112BC1CB1F9E6A3E9A21531D0AA14F74718BA9155314A7A603022BA8709AE93
      324B18DF97729F93492A6A424CDD97BD8DFED83E6E38AFE2F3F514B2A5153117
      DA53964E53A982D313B7869600BECBA41A1514E1A2F267273D1D5161038031CC
      92E9A2E77FBB2D19E08D486D7B2F10485BD67D3114B7DC4947E2DC304B118CE9
      45E322713444E22A0D701352A48D79AEE06D07D38CF30C809EE6D519D2DC09BB
      7C4824BBECE0110D781D203D4E883C06C3308C962F76C39F37DD647039E845A7
      674F777AD6A674AE2F09B7D362EC56340182BBD9B9718614F3A4FCAA5894308B
      42CC83F733C575149A70317EDFA80EF7CA939C039940C0075C4281C1E2ECE65F
      CE68A56D8955E5EC1AF76208CAA49246146E12144BC4830CB4C1A364951202C0
      102FC553AEB1EDC8EA133C7D6C869736A78C3BEED1007B3180019277C05DAE83
      7D156715957FD27C9294140034FC1CDA810E9F91DA896223E645F4DB3CE62E89
      AB6A5E322460E85430DE9630255F15F35ACF6DAE6F8B23DB8485515FB6AB57BE
      BE9C86A17DC89A2B486E94D0801543B8BA2AAEABBA98CDE45ACB6FA2E49B7A1A
      4B8736342F709E70BA01AA54753285A2991F18E9E7A32ACA92CB78043B779C30
      8BDC0129A52B51865458D4C093F350B801FA1E447A52C1899A4315C40708B420
      BE5E4C5CCCA9E994C85834ECEB0033DFFFF9E9FAF40C77BA80EB249D7417EC35
      596F60D092AC20317EE881E07EB563A602A5E806EA9BD8735C7E7E3FCA3E8C2B
      05994BA5A65E6F8EA99EE030D77DDE3DF6EC259A80690DDAAA1C688A181593E8
      D883966D2C56415840B2D5CE1AF35D49B1B04B88DFD09626DC81F968B114E03E
      F4EBAB38EFA7E38439E16C686C686FCF456F845D9F4E714B572DF82CF32FFBEA
      0E91B98946C4FAF0FEC70A9AD565124F57FAFD0D1294A1967698E1C710004CA1
      0649EE92B5A22E538C03EEB28C658388E2D26FF3249AE76502C0893394E67D1E
      429A99E61F52E95346718EC5370C61044721D4A3CA8F0A376475CB315525CDCE
      C31CB941B1276EEB49B356D3055836F0339A686DC354D59D4C9F4C203B3AC6DA
      51DA23DE2D90437EF38BEC638E87FAE42741A0D7D132434CD9310DB97BE561B4
      A89B07BFE3A1D99B82779DF7A9E323E57485B5E380015F4D613B1817668D5E79
      DAA41C52F082C41D61401098FF02A28358A0E40EDC87FB05B57E99AB1600A5FB
      2D68405CE4C6B0BA0193F85B6E2A2FE2E3B00A6215EDEE7EE3FF8147860B124F
      914FBCD75B79D756DC564DF06A74EA0E3666136F5CB5540EA43886F8F2CBA145
      191F0FF5F516F0507384576E5151380B4EB6CDDFC792ED1CF0559491A9A42D56
      AEBB25534F081982FF1860143C073E2E63AAC15B08A3F881FA6D657EDFC6243F
      DEF5358E8967C966818DE5C02DFA744A272CE900AE79C9F60543BC2BD71FE195
      23D099080C8188E89ABD83E98D43C5DEF7147BF8B578BAEBBD1C7D434FDD1833
      A73A1A16DFC289609F6765719522FAAFB06D48F7B81B44CC53BE0ABD53B86404
      87F85B2399ABCF0AA39365F116649D371E95B8F2156AED33B846A054E9B259AB
      B501D6A973C03D56EEE75778A8F3BA40185B350EC7E3EDE1730E53D4A136B6F5
      BAE365046521911F48F2B0DCB42EB735E6997AA39100F14B90C230CC603C15E5
      CDE6437966FEBF8CA96EB33DA6D9C4E3FE59DE223EB646EF752299A33EAEEC00
      05635AE1816A78805595DD3447AD179D65E3D3B8ACE43F0066D5906B206EC48F
      D60DABD9462A97DFC73D3288FEBD98FB61040046E953B8005FD82D5785DDA2BA
      7E80EFC6DCD987232259E0A36C0E920D5E515C5F1C4F9C79004B2BAAB02DD9BE
      042354C8437C3CE7E4F2891A62085924496ED81290E119D4025312B9802008BE
      4F43195F95D429EAD457B50F6738374484D6A3B7C535E03DB9B1AF71F9CC789C
      015D2826E8C9CC13C1903A4D49EA3AADF1410900043BD4D355AAEB145218604F
      B27794B1C6010BF86C89B8FB12DE49C80CA4B303CC161EFA5C6CE17F621321D6
      A1E5AAF139FD12E53BC2D4C0E5A4AE523E8E0D1D2723CE302019711DB6A10DBA
      8164000C7C9E4A784AF41C2A484097952D9565E5115CC06328CB82CC08B04BE4
      2293013580EF0EE7E18549AF46FF0602875BD99BDB924F0652DF4751AD73450E
      D93BC75D66656EE2B3AFB844438B57C81570190C7AC6681E9E9F7AC85B9709A9
      3FC36402422E8C62643D39148DA731475EB633B5D069384CA9C928ABBE8ABAF8
      153AA74FD821A54A8EF02AAAAF0B20AD759A83712D657C709D5BAA008E043AEF
      70A3B2A40DA1D36CAEB0EEB195E90989116B58A5E8DAA14AB94BB6C1178418C4
      F70B4921CC41DCDCA87E2A5381C1260F3370C65F915960C95DCEE205458769ED
      3D9600E845493D1AF4388270CB58DADD7C2601F95BA317A098F23777D33423B6
      0DB019678770EB249FC3341A4976291DD754FCED69D40D4096F99B321D0B036F
      270832C03C82C1C01B04FE9D9E32A50E85F48F6CE2B8AA7BEDDECBC8D39C60AF
      C34438EF1DB88D2FD467050DE153F7A22F494297931DC69A93F7D399357C05CB
      FE51159560E38167D5DE0A1C0E312C91C230EE410430AD93407EDC73E3845959
      45B1D5073391991E44CDE2127F7421A2EA06BE38DC23619F2AC033CFC9BF820B
      56DED804F926780B7228D1393EA9720DF7A22BE1E8F151E954C8863439740F37
      2449968F6999B4568D8FD82B4B8CE8817634C2402E1B84CDF7C833D923FBC671
      1EDD28D2349C338CFF2A7AE7D7867450F3B2CDEEAC2200954290B6BC249FC48D
      CEA31A4252D27B27E2349E73912AEE3A103702B4CF08C84B19C14D9D424F816C
      D19C816C6FF5B388F7F9692F9A830C995424FAC9D8001149A649093AEA5B89D7
      78983B009809762AEA3B43028B5CB982CADE3A397A83518FCF0C080C4C105E5A
      79E58A0EBD676F48851B60B131602C00325971C9CB4778A780DE5ED9CAA97A11
      A3DA121B966BFED6BEF682EBD61DFD71D5BC14B9DDDC656C79080572982A4602
      96668E56891EE19663DBD350015E4CB8BB2EB521C0D8F55169A941EBF07067F6
      E37416D74C9B63B14A49429B9409B99ACA08BC030957CC8847156C9C7CB43A4A
      924799A4C44AAF2BEF09C85DD1FBFFDD2A09D43ADF15AB2523416A3075A46192
      2713E151A441CA8208C6A77594C4554ADE8511656F1AFC038D23C24DF3EC7CE2
      8B0CA1EA7D28229DBAC46625B019252DE9412C173DA82FE8C0AC84E8A504E2E9
      7E89C6A59DA53C619528CB688618C61AA0DF3891C76A391D988E43742A052C56
      FAAFC9A3AFA64C2C78F9C2CF07D17BA92943700DC7911404719C95CDBB0881D5
      E87D2AE7388FDC32BE7C943F3A288B998788DF79698B8B65D2168B6B992BB398
      F5B384A49232977B121FB349E6EAF38FFAA964CAED500B259AF18CAE6BE43EBE
      37A1032E1FF91442A32A6B614F0B983D70FE410060051967C691239D4CEA3E2E
      A7656FC4AD87AB8C636F3121797E13A616F369E5290B6F15C747CD34933296C1
      1D635417327697F5A5D0C262761C09B8DA0FB06013C340D05D52E6FD600CE858
      29D313523682CBF70417B1A0257BE3D055B6E8C333C262A624BD9872AC49AB05
      4FDCD18A47003297673CAA0C0456149AA0EF4014FCFB0D108A1565200AE14603
      1908293E5661C7E6A0C180F7B2AB4AB0413A0CCD1CBC117ABDF9BA3751B4972F
      36D10608B5E1825F7A4100CDCFC0C9838444D1E2C2CC900066C169465678B1F0
      58CE2FA37192D5B1C8494A5A0A2A317C09D987FE8782D2E2E854D9724577423A
      80A5A1FAB11ADE043DBE63965DF0AACBD2EC26C5CB17EBF2EC20C57E4BA25D6B
      8855380FE13F6CED223A1C7DA9923296E4362CFC349FF34668ECCFA08F2DF522
      18FF110BE8B9E5AA963E2E561668D371DE7CD95C1C9E3F7B159D166589A366EC
      1646173B8FE05AB46F41F19B95D1852033549292613DD5ADA4493417755D733B
      9A3B1992349A816FCFDA61A19FC6CABB739EA32A30AD5933AA3F26A12951F4E9
      6902915F497EC4DC420AE2EEFD3AA99E7163F479F8B93505E201AE05485D0086
      EBB556D8682EF198BAE0506112EE96D1B937625A87AE273DBC0EF4A01FAD069A
      DD3B51AA0BC8BC63E58ED3AF30FFAB169FD79DF82CC7020D671AB86099D1E368
      82753D8C439D82BC47891CB041450448A08B4AE40DDDE9EE42CA233ADD7A545B
      8ECA23E3370E3069C3321D5F2AC5EF329E9990344BC3711576BEA6653D8FB38E
      8BE95A8A29D7A49EDA3D49DF95BA0740E7D8205882067B3B88401AB8DD495931
      499FA42BD11BD48C978E1C8ACD7820A9382B298239D11419601D57F487AF61A4
      3F00AFE07080A061F0D2BFFCDD446C8415EBE1AE14962BAEE406D9EC4E8BBB24
      5E27B6ABE1577E34E529305654DC8AD084DBD5457919E7BAEF22C7FB0372518C
      9110E2568820B29B8F2165D4988D757872E2480BD872AE26DFEA185BCE110353
      709C7E4DC74A4430A7B4BB14B2DA9178D17498D011D0D5104B1F647099D75CD3
      6F54F3C3C1DC691ECE9AA2BF74C05B5085564780CD1176CEE68E14CC14A9E218
      7BB337D1074EE6241E6102E10E88A6405DC6C00D2645790D2459CF519B5F2D96
      44E3B30A5E2EEC533E16054A45CA3465C32F82B03BC21BB01EF5E4821F27C8ED
      53E51D077C52E872A9EDB94A4CC0241214FA6581159A9492E9A4DB9396E3453C
      DC7841D993D46D38FC368BA598281FBBD2C1F1878237DEF9DA94B253C69F4419
      7C6F79AC205D69E06DEBE2F25268FF15AC1EFCC6DF29BF7CF71916C92FFDCF51
      75331D82702DD5095C6184D0FB60CBB859162E9C2FC9CDB0C03AF08516BEC383
      FB0DF21FF2C30AA4049A574E795EA5110BC4E1D8947C5557E946E5C062524BD9
      0D51C3C4C2620C10EB77969456127A1857E20611661275AF44D3D94D81107372
      1D07F78D190BCB17CFED93FC7A9E7D89CE7CBE32CFA9FDBACC9087B72EAE33C4
      8F7DB2732FBA2AB2713426011ECB1D8FF992006866981E93A99E4631B6446E77
      8F30015C86CC8F18EF2399780354691CDCCC5C4A4A954CE6129272A5CFC4BF31
      F7498094E45B8C8096A54270AA407451500B067D302768DAE40554D465610290
      311114DD6E86DE24459DDFE33F2B005E3EAB287C7E0660623E23798CE6B92D70
      05B9379FCC03AD95AE125772207C04DE2934F80DCCBD7DC54F2DEBA50CBDD0A6
      730F2110ABCECEE3CFAF78C9FB61D342A165F456D318EC378E623334895B7BF1
      33A9DC1B1A174B4000E1D6DB55EA7691F6B7CF9A99DC4B9B0FE0A19A54EE485D
      97BA945F11759C57CE4660D6B564383313656118316C6A457B751BC1BB34EFD8
      65808759F881FA17530EDDF35C14C78E16370D722A05220CE23E395CD8B71EEA
      1C504C0A6B669224E3217C554F9287B7EF221E86E571C779E0D0BD7BF07234A8
      A4C39B4F869830FD1360639BCD482BA3C80D7E3FE3335C87B4D6BC8B91E188B7
      2901658BC63BD9F0FA03A3C850793A34D983D3C79E863C2539E54C7C98FE0C0F
      333A0E416E7913B16AC9CB06864307C5BB3B98D9F9F40E3A679F844E7A9C8F11
      5E4608001DDD879ED51A7E0DA3F0F2FAAC44852B088B4D8ABBC5B5880391D862
      A4D58AE7AB5355E01779D1E12DBC6DC8335C1FCC55349D266342B5CEBEDADCF4
      392DC609DECF6F1396D658C8295A31461F497800A9808A0667071750D6589A24
      BDC8F8E0D7BD445F232744EE8640BF0FD5B85D22139684F45AA2BE3C1516B8B7
      DCA4EE011E7A328E2A7C86AC6F44E2F0B85023364C5618E4A924B732686FE994
      32B5E2664A3E58F014F3981ACCFF11B2DD3C0DC4612ECE10D09B196C0B795F50
      2F5432829899A99272F8887C5943481FE6D6A5C69FD1A225EAA68F95B0E730C9
      D244254FA53635CABDBBDBC02A7AF56314433033ED2E34A1E41B8F0311F18E2B
      9C072BC32153E65B82C467B8275F6C56A43441EAF6642AA0C8126392ED926682
      7C5C310BCB477FB42742CF9B331FCE9F1E5C01F47264A36943702B4674A9EDB1
      EAB4B0A0996E45BA3BBDD0D410DC0C180711D71445AC254739153F80890DCA8B
      E2E1A5B159293E4B66DF3594F863D8E2881C36BEADC59A4038527F8095CD2DB1
      0D787290518B7170593886B8C1C65423CB28EFDEDEF7A943F29E5C79CC69B1D4
      625C6C9456C2017F0714E9DCA13C23B9FCAC62C34A1319DCF110EC7315F0B8F0
      9132E503AD76E7870FB73340DCE334AFCB623C1F9994D037C9CA690862CAA483
      2D46774569351AD5E845D3B9FE197BD0220F3D47D1B123C05745F2851F3545DE
      1267C8EBE0CA21AF834688B8CFFE826B3D6B2AE41C1140C0DDC6738EB20F62B1
      9310A46A715E9D89C5E8C570C4F2B1D4EC46910F1FB809FB68CE22E20CFD381F
      F7251C228915BAB21C1691F96554A6D5171A6F5A5ADD8E21CD8F0C47DCE3F644
      21EC4DE31B159647728B837E1486F23A9D8B5908B78EB7CC4D7C77076FCF18B0
      A05EB8D221F0E759F58392F3EBCCDCA92510119BB18C52996E5C5CCAB2D53C1D
      615258A717AFE8303B64C56C6AA5483F9B3A630BA401BFC224FA82410FB90141
      34D88040B0FC8319581C681A87491A140C184447F312573A20247DF9479594D9
      E853847F319F4FC4AF2DE4CDCAEA4E28C8A88EBEF74E1B9CAF61592BE14EF5C7
      64632B6E6C2E1D32A31C67AB14EB02636D061E5DD43D7E7774B6139D9126712C
      E146FDCE45314B4751F7E078EF64E70EF10539ABCC143780D79B56AFA2E37767
      42693B7E77B6B7CED242F3B6BD020F4A88837972DD8B147B0BEE5835181AED2C
      6A6CD1CA164E6A902215DCD4167183E16FAB23B85C5D523F73A5F8E5209D2010
      6B476281068C09EB08A359BEC1D3EEEE559AC46CC3DCC9D4AD5534369228EAE6
      9040C5DFBA3715334FE589713F73D803CB3D3CABE0344E2492C31A22A9EB9489
      C9378FCAF0B7093D493D31AAA4D90D692B2DD536A5D43F17264F0E0D32ABB595
      234D54D3244A5DCD9B8FE3BE178AA0FE94602F1FD625201C04A292BC991CBD68
      126BFDC016C62CAE78496ACB255C4C17E5A928E8CADF3B724AB8F2F4AE77FEE3
      444E21F91C6E9D2153C20C6AF8B5EACE7A91A2003D0FC859B8A5F5D545108665
      839C1DABF4B1EDB3DC4C19327CCB65332EF6DBD6CD3069D86775B3BC20849395
      27CF06FD69AB8B9AAB3CE8CBD6AD073433E1FE73AE45C34320F49B85095E9DA6
      A13E106F013DDC60B92123560073629EF32939EDC892D0E0B9499E6AF04F8467
      C4F7A2E1BDFCDE0E542FC5790A5C81D63A45BB37C5FC0EC7154E6077F4AF3BA4
      F8EDE052177B527A71EB1252F5DCB1D80D4E21D5548ABA65329A97C8F470BA8F
      9A6CE54EC2303D47047FFC3146EE98B2C57C379C0502B2683CAFAF902E483664
      9530972177F9E8A657A02D36B26EF09DA2EC29F3B4A2F8F939231B6F0E3FEFFF
      7CA761DEDB6C9855B255200A604FE205F2017EE4A90FB07AD8157D8C69FC4814
      4C2B4AC155F42A35EA27DAB67027BCDF353D955E0883199A7AE7CBB108D57F61
      ABB7FAAD037CAD9C37A7B5D64D07C9401EC00C7BCEAA606A2E88BE6325189881
      2D050EDA97D72C29611B8A1197EBF1C673D86C4EC23BCD9795CF34C9204806D3
      3BCE8F1147917DB9933D609947021C9C1663163CD330FDDA681D7B680EA631B8
      1A86532F58E55A71C0A1FB384B240F20AE004F2DB23C8D38ED0E7A16846F5EDB
      3A386349CA0D4806957313DC9D042AD41F55A4F187A72C6575F63CFA74BA77A0
      9E855DCB52914FCB1CD11FC760CC62C82B795DAC2D1B7E01EDFAF3F9F0B28C67
      57E216308FFD3A28E2A2F4D8C7FEA2DFB2B11F50E44AD56EE41DF3C29D9F36CB
      964313C4C2EB22BA8ACBB138F3F7D1B1FCD30F3FB2C437B386F6AA0AE359E4AE
      DA10F79A38E48ED0308E5E9355F0CFF99487078EA6EDDAFE71F7B96B9B6BD51C
      34A983242FAC4A8269DEDC1A81641789020C864D0BB086344D9959FCD8547A14
      6DDBC71F96F631D06D8B653D60BCC0EE3B7BF6F8E8DD2721638DD33110565F90
      0BB8CABBE3A3FFE07BFC7C74F41F50725E3C2D36EF1E6B8A4AF78E4FF70EA2B9
      168B96ECF2342717EED9D5764F7FB2CB52A08B6F4F861FDE5DF507D2405D53DF
      592BFB393F1BA109C558481180DDB065AF9E3E0D4B5730B75D95C834242AC7C4
      DEA7D38356D54EEA9EA2A2D03D0AD33D63710B96D4EE9CBE393C8A7EFD353A8D
      2FD391BAFAA271F2EBAFD1C1DEC55ED477FFB907AD43B8C2C9B4A37854A58554
      7D8A0F027983AD7B86A273C8BC9F40AE5A936BC84E8A599B9BAEB795E40CB6F6
      795223A391DEAC92F50A24B89D8406F6F1C1FD2BC71DF8CA71B2A6FEED2B2FCC
      5929758FD23C7AF17CA865190497899155E48B17F9A9DCFBA4A6800F630B33FB
      77E8268459614058395CC9D2E3925719C21DCDC961E08675988446ED3D4E64E6
      FD0E5DBB88876629E62E948EC0FD637A1C94DB4D759DFD0ECDA3DA14701A084A
      6D5BD4B0EB0A9F247CB229972B1F5022EE12ADF9267B9C5135639E3C489BB29F
      0F855A308E5E9F9FBEBF5FA5C6E50D48A59D934FE7EFA32E63ECA8143B4BB2AC
      DAB1A0C543B5C65BE833AC5429C0E3E22030324FDF9CFF91C5867EF81ED69CBC
      7C2B4118441F03EBD4AE6374119E80F0FF9C01DBB44040112EB62B05FBA727BB
      3FE25EBB383C7FFE0ADD6A048CF6F63F1CFEFAEB3F4ECE0EB67EB8DAAEAFA2D3
      B33F1F0982C4DA1EC8A52CF2C7E0DB0D9165CA4BFA4177A58C31D547951AF21C
      A1CE730424EB57D1EBA2A094864F2FA80BFCC69441F400317D109D1003D8B7EA
      A9656B81B329BBD7458AF4549F2AC67E9064B3AB347AF264F06CAB96002CA6D8
      510FF2B4F6969291956175213209790A8F44D9B4B9F8B9FD51964A7882A11F47
      1CEF0AD0BB9FA533122077EE98F6169D7FB929D369747E88B2654A2C8F4E70D9
      049CE3C12CDE6E5DBD2BAEE1635652DB7D5414341C80560525BC1982B462EF2E
      74A36D6FD5ECFB12416589669B94A4AC64707BF06E3C0858BC9944B6AD5A7167
      61354BDAC240EB6B8FE5CDDA63BB77A93D76DF327DBB2852770470554A4150BC
      29EA9ED7C50CEB4B0AFC1E22D3E3A7881FCA273009F2D612BB43AB4F9EBA8B6B
      DF84D7A237497D5C1D1F787146D85F33A45D478739FC020A396C6B2EA2559C9E
      BF5838FEB3BC4AF5F86F5AE5FDFCF46FEF02630B781956C930C95926467526B6
      6D9CC6FDB123CB402A4634431147BA29D32C4B478EF9CC5AB622E3A071BBF765
      81DCF6AD5BC7ABC3A492D35D21014F6E49518C508A8FCFA7C48E494D4873AAB0
      4727676717EAFDD2F9557DE607BD60065A185B791F1675F7DA653C0E001D8826
      AC4BBA5398719054FF97BF7D9043793FCEA8C29D1CC5A3E41D62825965120693
      D85F0631918D0769925A1512F391EB515AA2EAAE860F4863403C93A5CAA4F81F
      6A22A4959C977617F0CE78904E59A1D6F1DCC5A7F4EEEE1C213D4CF5905D416C
      854EEA79991BFA89C209B3B8EADCD12ED4E97D90B7383F3F7C159D1CBF791B5D
      23775CD96B278C29FD149D1CBE3B7F90662C097CFFE2604F44AA71C1D5D1B7B3
      D72D6ED183B7F0EED303B520B7E3555183EA6F882DB8FFDFEDF7E47FF7B21AFF
      16BD0F7AFE2D046F212BE5EE37E0F33FEA067CF992756A9DEDF3F8E4F073D48F
      3E2AD8751ACF58CC3729A30BAC16D10EFDFEC72D1B232A8B5C8BB361967EC5A5
      670080D796C49E57D8FFCDE1D1960DFDC86B3D4B99EC4DE29F6069C649471D34
      C9C9A7D0C47CD897FFDCD20BDB056C16B3C229CBCB937ACE930C337B5D94D9B8
      4266AF26D11F9CECFB039E4890C48F424D1295E1BC5FF1DF1F9E3C0B26530B34
      A2EA154F3014A6110CC0B3D7A27D53E0F819F435B2AAB2623B4FFD4F3F104E3C
      3A7BF62ADACB475705A4E128E5F1FF45EFC1243D298A2FC5BCE647D0CCE65243
      B447982496AAA2C2377FDBDBDFB21BCFB1EC2C8790D796C7F82D5DD4CC1D4C98
      0FE43BCBDCADCFC769FE4F7AD0DB3AEC1C92779F9090A54B251AA3916991539D
      98107B52525E0785E12E93629AD4E5B62BE07B4097527CD7B7978DF2F99798EB
      52240E534A2CA779F46EFE25EE5F60B5A0CE7952475FE33CADB644B97F20C80D
      D1923A9D99F5304E2B61E6804F203581A5E6E2B66DC81A7BFECA1286CE869820
      1299AAA87B7074F6DA30440FA57F4DE308876D516E6B4EFFF0F209B616EF2339
      AECE6B25266626772D26FEB6CFFF5E811477293C13AF4013C8E92637E0715DE1
      DB46CC6022B370188E01ADF7A7D930D8017FCE8B3FEBF2DCB605AC06316E5424
      471992C51CEFE4FC7ADDEF6DFDD86DC370CFFD05F7393A07DB3ACEA46AF6125A
      1C573DBD6393F4DF36BAF563D437F44D169FBE663C2B209839BB52BD0C451A96
      3B1937F73065FFF423DD4CB7848CF02B2487520AA21572FFBC4BAECA748AB360
      DBA630CA1F602278E68291F970B44B695AAF07882AB10D4B7EDB76B16A0F3E34
      12917C3819D10C505C79CBCBBFF6C663A3151C3D7BFCEED3B6EDFEA8968CE490
      9FA43996CD87A29856D13E2923E15B9BD98AA1C702A4C3D6F80DA93AB4F8B75D
      708CEB0BA680989367F1516B2B4A51E27AEB873FC7C3DF24F5BBE4DAC5B1C07E
      97DAC3BB515C5EB2AABB7248ECED8FAF874C39118A4894E6B3F99600C28FCF7F
      54F0E2F967673D4A8D3EF27AE28ACC23A30F4AF8EDD3DFCEF7192EDE36048CAB
      8565A367F073C71A5494F23B882EAA9EA0BAABDBB68237FBDB3C4561CD795D44
      A2C9AC87C6A42847495FD208A2CE0751633E3B3ABF60F4B3B3659342C5387923
      51FFA39333E4E94F428A26EB9F09F881D79D217312948D6D1BC4654685673570
      9A52D665D25754D21B2A414D3EBC34A5D7BA92B5EC991C08786F89C2FDF812A7
      E3BBF7FBFF193D7A93B0AEE2C759F4F724067DE791B318C843856DF884B91DDB
      B6859564009FABB520D7DFDBF85FC8D7775B882C47858824BD8466F8B62D63AA
      E91E47694EC53E54E1E1721A27A32CB65479A9F3379F7127D1EC079F94FFB07C
      808785BB922AF3E289284923115E4198B0EA5D892B293E19B0845C92B0711005
      2FB5BA91DB9EA1B775554F9DC303088521D7E47C1F83E9FB23BF8B3A87960BF3
      9C6B45640F26AC23B3DBD110861E191DA6AA88360C06B9EAA0D1AD3DDEDBBA7E
      8898489C9D1F0A6B26ECF42C29C544967AB581AFC39C6090AA91CEE62AA0D86C
      0C8615D2DECA160BF241BB7D129EAE41FD79AAB688F29E7AEE0A144AAD22AAAC
      F3790FDA9B17CF239426B0941A87CF8B6AAC4A99FBA22E941516C2D2F37B3AF0
      B7F5489531A1EFAB79349014334058504854FAC3B962D2EAD94DF4DB3C9903C0
      8CBFBA8CCCB8E6337A01B1DAEA016545F5B0B3EAF6B359B9A067F30D90682C45
      6BA47EAFEA704DA8A96D8495DF83A5D795DDC9F0978A56A2A7EF0046D4859E43
      64D2E471C64E31908D5B0A05CA650594D51F08EDFEE987A740ECF64885393F3F
      64A758162B47C27062DE93D2DFB73DB6FFF4E32EFCDBCEC7FC0AFE729C6583C1
      A063515A4A6A90696CB5CDA6493EDFB621DCC32292413E220DD5E8F4EDC14520
      6E1E5A751099167BE91C17B3C9C35751173182FE311FF077801B7C880BC96F1E
      11D663D389FC6190D7488DA8065D83F070CB63BC0E238D9E953283B21354D857
      C4E444CAD90E76132B04C59E7A2B1699E933833ACE247FDA0DC2E63C630E311E
      BF32B1E3465AC5C4485FB58464FF37FC1C36F92B00A1D8E6D4A4751D51F55F77
      04455D1CE84C4374D5F4D4CC531A3B956D39CAB0C98CC8A21C162DC27AEE443B
      711AAFAED84B53CBE59FC01586DBED33851087EB45286B19BECD38BECE2FE7C8
      8282F7816CDC221F16259D91F595F73C3F44E77444796B3769B08BE991779175
      810A52D73B837B87139EFD51E1841774D33E50C77C16E77659836AB8E50349C3
      D55079CB647AE5A2B962A70A6911B2F598FFC75121402067155BEE7CFFECE45E
      A1DB3FBDA0AFC61A111A787419B555AF4D4FC12E15D9A73DA9708490B2C884F1
      CC64DE5A92CF650BE04A508570FFA34602EE965D7E812E53C12EAEA3DDDEAEE9
      7055B339D9805249484E953052A1F78881C65B72675FBCDC75F377104FE34B78
      80C02C1362960C4666F1907C3D871C6DDB94500CC46B3DBE3895180BCF4D13E2
      CDA3923E2ED175AE97668ABD246B6FDB3E4192AB02A2EBD1E1F97B31514F8BB1
      88286EFB54042FF648C5FD941652974835C8143B14394BAD9102B12A503CC337
      DDB2E51F9FE8D43D862A2EA82A3382865C4C92BF214A813CBE69BD314A9FC5F9
      B81AC533EAE6642C85A93858695086C2340E1CCD1F6D890BBD20BC5B417663CE
      3584A26792B3CA7F69BA852F6545A3B49A0FB5DC0AF2D458B479EB41224C7F33
      632205D0839F0EDEED9DFEB497A72A107071334B5E45AF631C43E908F1F6D731
      46A54E475B36F903615DAA55D457D13046FA2C56B065FF5306124B8F7A57A240
      5E9908B5B03B2916571451358DB36CDB3727F42AA0F68956DA2D2651E72041D6
      46954487BFCDD319F1B38E0D0E7CDC62AC018B6DDB85FDBB2F457484E46A5EA0
      D887FB19C03AD41FB8A950701DFFAA4BFE0B46D2DF390015AA326D0BD9BD64EA
      8A164F9B2E144F33F91FAD9DC64A14562BAED64294F36A4B28E9E513B4AD22C6
      5F830321C92958A82ADDC9B650D5CBA738B005E8F409B264C8614991330281E4
      8FE717DB368063857A5317EF4E7D509A1119CB7904AF3EAD6B54F4845934CFA5
      BC136557990E2CA7DEEE3D30B9974F71319E9C1DBCC16D1EE73C2BA4B9D0D394
      BBF96B12BDFB78C2028C28758BB4314268A8BD6B21E42DBBF18C3064721DEDFF
      8C9A2670CDF9541D0A9C14AAD329D33A66C8C1D72A5192980F5CDD032D7CF90C
      38A5CB41726A22297121909F7D02BE2534EB62D7AC246621A5F91797E45894E9
      253364B07A5CFC15A58B90974ADF61DBBEE2E497E2D254F890938DEE83849F1C
      A544B0C549319A530BC027F23A27625A6C6974BC7C466F7C3A4C2FE726BCC050
      E3A32AFADBC7F38B40E47DCB069EDFDEC0FBBDFD9F1FA0011C28FB36E77BC606
      6D3662985730CDFBF8E68CBCCC2D5BFE1E478D5B603A5D8F2AFC9761592AB6CA
      AC6D5D4842100204816D928EB5AC1574502480C6EC07E4A3E9A5943E2C1CE868
      14070DDF4F944151E0E4750172038A83C59797AC06B26578F3D61E1024035B63
      EFD3A9C573D318A5E4A2043AE9D0EED0AA770C8C5DCAA6EC1190A6D088540253
      256A75A1F93D570EF911A849C5178604341204A493F5E6D92E3814F457F03304
      332B50DFB2877D55803D042200F578A407863D8B8DC1C8CD8448C5288D55CC72
      C8D183F6E6AD031DBB0AF6FE25FA6177D7974D361A810083C8CE0C42D18D6A40
      7226F1667119F9161BF325811FB4F78DD2281A3A91801BA46B81194A4800AB26
      EA20E903AF735174A21964A445A0C6FF525692580A3E9DF1417B1CF8F5A0BBA0
      8F485053EA1EEFEAEA8B08233C68BB2123057F4A35B593B9725901D93313AC75
      2723975F9AF7A9A4AE32186A748B3682D6BD613DD02D0FEBDBFA9BE67E3788CB
      072953390E1B55E52CC7D3F469941CE08D075D09F35C48E7F72221DF767A85E6
      85B1092681DE9CEBAF4603833BC77F9D42B2FB10A62F61654CB454810F6BDC03
      4AB8ADE78A31FAC240D3B4A2EEB3AF84E72B151ACB5A4DFF078F486A12C7EBB3
      B39F21FC4D0DC8CBE8FCFDE189ABB927638840018CD7870C905C8C279AD13600
      D9E4A82CA6AE5EA8DB111A1655C7D38A68FA581D1FFD90BD92A0C02F60517C56
      1A8532549A325BE161DBD5D28BACEE96234132AF929D87EC95805F5E27362048
      09452727A2F2904D1A4775E15EC221C5FD3D63980F0A9214B8775559DA27D843
      F6AA28675731A0EE25FBB60AF02351CB5820AA1977DB8AA3F23E8ABF8ABAF462
      89B7DF370AF782767F008E5D5C1CBE0EB8D68B0E6DE775868AD7AE3AC196DC9D
      172F7F6C36FCE9F8FC9817D3FBFDD3D721A5F15E59D67F7AF9147E69359F4CD2
      6F826440E34630611809B0D1E54ADED6713274F133A28C326A4F9E1029E2D90E
      7E539FE9789D26A730A8C64239ABCE5B714889FA31560B19FE7DA4590296DA6E
      9C7D9E37BA10EDA25B386AB5EA76E79CC5FAEEFB6CBA0B9D0F52C85758F9EFCB
      021773197D3B3F8C0E5D71D193E2B2E36BF46ED5EC07398EC5A60AB4EADE9709
      0CBD7398A2BCB9A0DC2DD862400A412D514D53401072AB1E305C6B74F0AB5404
      6EA518828693A16FBDED65C9A74313907916446A20F3062180F950B8D1D1DEF6
      4216C19D2BF192C377FB6F712EFD9C17D7048370826EF76C89E6C715CB6FE969
      A760CF7DD80DE023E12065E51748A5C28C7229EC9AB32680BCF0CC5A4C164682
      A2EEEEEE93FED1D151B81A7ED8DDC5473B669B4F6778BE72230FCFB7BBCCDAF1
      3DD56892109FA5620ABB9F175594D15274EA84F9387A7B7C717AB8391DE31C35
      72125C49EF5D09B75521DC73A4F4F86A6F16C3D54228E249C75279874F45519B
      BCB8DE4E6C5262CEB8B13D0D22AEA2FE6FD57681833E5C845B9EF975EB872260
      0D7B8AA01F1E155F66F7785DA17EF23547F7780C7A153C2A1E6DBC24548E035B
      90E6248C499A92EBCA07237F558ACEB9EC86348F0E1A6C0106F5C7494D048BC1
      7D7CC7185A1686DC61A6323335638ABF3084D02810A6B50BD02F80C3CAB1360D
      5E574F3C1E5B213B8444A6A439343459796752DF4DF5A6DB273E60782B998E6B
      59788DBE9E310BF83A3EA6D0D128970F6EE07A3A8478A4B27174D4D4EEBB0D65
      234B44491B37AAF948A6C6CE063C1AD59B23F164D9D80663B830796BDFC55500
      72CC0E2810662E55FA6970726C7922BC2BB01C9125E792E4B4CEBDAC15DF7B4E
      AC38F796465717EDD5D8E0FC61FECE8B7916EDC76969D4DF7182D8DA90DAE6A0
      A26CD7ED23D0E81ABD56CF5EBAD6EEBBE96686ABBBEBD3DFC989BE81DE2D2F4A
      7E6DE7DE1499A79B53647E2EFA47E9CAE3C0F0D562A2BA9271057C454E075C0A
      50E251A298D6191047C9552B665D67E207EFE3BA4C44E5FE316411E29BF771B6
      01B189CA8D01B969757BD1B080EE16647691EF804D362DF21A6592C605A26D08
      2103F1E5CBF7E03C958097C7A9E29B221057C26B8CC83B95DE43D460960C46C5
      34EA16259F206FB0C3E49C8FFF7BCD19914883D17B30475823834933863DCB1F
      B5C8B62E62A8744858A859C77B0A5C18AECBE61438642C94EF8BA4AEA24FE938
      29561A077B5C541DF962C73AD5E4FA6DDBC725C70D2971C58C94A77F2FE617F3
      61822A8E37A43B714A35FBCCAAB4A14A6141A917FF5A7F94EAE88B40DBCF9CBD
      F749F985FA82372C2B133DF9FEE5B60F57112C41B74D5B49B39B656552EBE451
      45D1D315A14BFB91A4703116F2A0C09D4C8995E6036335BF8EA1099FDDEC1850
      E6D6808A3508AFD7336678BFC610FBCD50054805AE19CAD19B9905EB1EB4DFA4
      BCF9524F3891A1B34E8CB8BE46C591B02016BE2339BD2C8222D78C582E76B148
      5C8F84562615085B87CA27E0E75CCD6BE0520F0B9AD2E5FE98CF61EC68F40288
      4C31895E9F4A051B0633283A2EB5CEE2CA67CB542057771559D5FB6B9844CFC4
      24DA79D0AE06C54A8B892D57CC304E41B09C75354844E731E119FCC384EF1D6F
      16A688E862B9C0585A8EE653ABDBD110F0142D170BB93ADC8D53E3AC3B96B87D
      D097ED1CA0F0795B09B2E37164E61F85F66F508F56AD45442ACDFD34AE0DB702
      6505C45A762C471EC014917CF83D22B7DE71CE9184844850F1919B417395C29B
      199827AB8B22E3204B67827F1D91AE9027D78EA019D6AEC4F38C8EFFB0BB8408
      071556C1D9DABBF8802ECBAE79D8E1522B87F275A2639E42F5FED62B92B1D238
      1AA22421A96D5800F938EAD6573182CFD5553CDEBDAEAEE29BF133576F6C927E
      7B5030FF5CE263B49F8B52B2D8E4D832ABEDF0FC94C177D104383F1413083A24
      6742AD700E96F95674CF3CE9BDEB42144C963641289363471167070B9A1DED02
      7787E7A70FFABE7BE3B16A1676779C63137BA746D4F9B8D52CC620388D4689B7
      2F82715BE44950FFB0B424B0FF8022C6928294F26AD4DA9DCAC51AC47E0425BC
      5788F396888F870AFFCE33AB9844EF8B6B89F59CBF3DFBD8E26EB1C8D3F6D489
      5BC34E8A3213B532753137557519E7551693B2E1E62E608DA080C3EFD59FB28E
      8E4ECE2F6C18862C242ABCE07B2A11DED2F881C977B5624F6F3E7C7CEFC2A51A
      AF4441E7BC3F896B54B3D04C58B767E58E5C2CC9B902507275849DD4DF4A3762
      D9F7A53AB18F7F0529C46A5449A902A0319C4F4564A32770985C51A7D5CDBAC6
      AC82A7AF80EC276510ED39FCB8E5DA688DDAB2C858806573D7C2DE58D1793958
      5E8BECA0517E2064599420C00D6F4CE865BD33A659659D6D5BE8B4DFB1ABC320
      AA7BE53C598D3AA9D98C9A4A9A382725C2BF26BD4657E225BD80592A3D5C4C7E
      F24591378F79B2A08E44C5C3DA6E32DD6314C5A5BCDDAAD7B9FD19DD477B6462
      1F49BA0F0BF3EAB71EF5A247284B8B708688A6C9560F44551F899ADA239537E8
      1CB3E2068AB222B1916775C7ECBF4756D586E57160550CAB82CFBEBEADF2C7A3
      B6B8C223C9867665CB1D26282250D114F7C825EED95916FBC2582BA7FA14498B
      61B5D978086B6041D741EF5039A668EAA495815260018F8B91C80074C118B35C
      3486E41532EED160A4A395A054A99B869DCD57C32FE0D57D5E9A45D95B42A390
      F9E15B50C4016C3F44D5580F715D5D61A93FC721E74D4817981360753870054A
      1686C14612DB478919F18991E09836EB61AB1EA4C754574326F203B19FD8951E
      AA3EA9F43D9BA27E76C57CBFEDE0D95B13535F41030DAFBD9CCD68E99BA6D403
      D9127CB6552796B7AF89C22BDBFE9EDFB877D37EADBF82CE996BD60552ACC9A3
      33BEEDDFF6EEDBA23666C3C70F1B2DD9DB6FDF5073E9633ED9143EC6A7F8B0F5
      5A7B6F4E165A5BB337DC59A45442AE48495789F663B940743F9CC294953FF5A4
      5CDA1716574BE24AC0E504EB3936B4D7DD6296218CB222B9ED2EDB119B1F1F1C
      0EAA0CE1A45F3C2FD661BA3ECD75211F96E0465D5C268CEC48526C2BA457948D
      60E1862780A0E23505647C3249A1F8A8165813A7454034679B5A20428BAC8C8A
      E914C7212CAB952DF224B1C5C7E5D17E133F0E82412EC699D64DC2E1B7D5F9D9
      7497926B6909B521371AF1380860F86AC4B24ABB4C885E7647482E4D4FE52577
      44A5E1AB8B4036147F885D2AFB98EC7EA34591BB9E4273F02ED68DA6C36F9BA0
      FF7009F96BD3F15725E3B74D58C1C92D9AECD356B88E515077E2DE00A030CBF1
      D235D7ED9D1552458DB737573ED1BB48F220898BFBD9755F6677CFEB249E2271
      2E89A74BB33F90655D41A0CE995D12526317E441AE18BC090388193B17312B80
      5D5050D6377854493D1FFC68F3793F02BF735E472F5FAC1AC9039722439C04AC
      674075563FC197F9C39A4873495F1C370B29A779F404C2BC7C21FCEB7B747574
      759763D34AB29A30DE068533DFBBA0388659AA7EEA53FC9B8872B614F00ABE00
      67A3B1E92CF7D6BB731292CC322DCA2E35A8B05925303B88BA17FCC8E1151002
      47BE0555EC60B739841592D7F869319988B9880F14DE2A2693569121C1B42440
      6DA97EC22A904BB04D5637F22C5F30A89F4BFEC192D2E370407E1EECAC94AEF0
      10220A7ABF6A9682B4DA70427963F9D5AE236A487D695F5CCA55CE94809331FE
      8505C18AF462E74B8AFD97202DA451E141E7CF78F0E05FF84956B9A56132294A
      D424C6AABD4A137631AD7ACDDE07B0B772E0B0C4517282907EF052F2BCF64C60
      6F66AB6F37DC2C4472644A5A904035CB0076233FBCE3BED571FE335AB880FBCC
      95D239C2A41B611EDD6A7EF3082A26B473585FB2D478849B0EC7BC2025C5770A
      87A22AB16305FA65BFDA6BBF0D62A4ABE2B78E2F28CAC6461E570AEB7B3B3C5B
      EB412665FAD5F819C13468B9B76EABB6A6156595F5146795A341CB29BFFFB39D
      ED9E4CDE2A00AB424049639BEC849896AE90E18DF2FEB452ACA1BD9A54E71DB3
      50F3C78C22650C36689C66ACFAB1ACDC60AE9C00F8C101CBCEEF81254013AC57
      544D97055845DDA07E20EA9DF2A0F2CB3271278AFD40958592F1CEABA88FB583
      D9EC816B13FC071628E6494EB6FEBBC23ED8FCF007FAAF9566E035AF7A7F0914
      68A56240C32C81C81C9985BAB00CCAE97863B53C421ABC0C12990038DC17B276
      65513AB57132AADDFAD5B85AF07CD4D61359420D5108CB53E21C581B729AE322
      25913534B14CF46B51DBBCC8FBE38496F4E2F93D30A331C3017FD3361EBD1260
      99828FC6015BDAA995EB2C98128747788338345E41895EE805A56CA5ED504918
      9BD4AED59CE5FEDA7D12F1867939830D2CD7820D9924E779992D04900EE54A43
      5D38AD8DFD25481AA4FB80B6641260076AD2194F430D750CA2232DB5BE8851F1
      6A6AE352ED86D79D98B01B984003E3C92334ED214E27845DE23201F3E2B2D00B
      49B019A8239888C29DBB504030D0787E79BB618FF624298741411F114F3B3F3F
      F4DF6F98EF245C9885DB0F1EBAA90D1FC2D07B12AD63401D8FDA045E0E30E4B3
      050C3930ACB9136431F244538940D1C55C5880DD20FAAACFED795541C43FDA3F
      925618CB2419142DADB6AFD87113715C988E101537CFC0EE6A71581CC1C46825
      490DB356E2A16B2F707DB45BD625CCABC202F49C4D990EE43D70D8B690488316
      E6E3C1307E1ABD5D563371A9EBE8F8584824E641E19FE2964320C25B26047F83
      7ADCF2431810AFCFF7CAD1D57AAE986682C6E371D5389C2F0ECF9F89A0278064
      A9125645D7489D899BDF34E415983CB4AB50798FC7884A699F8963849424F705
      BE923D781D3623C7268F3816CED012DB5A1557C92BA23DCA734E6088E45B5DC6
      D1D782391FC20489C17015014EF15E1B977F5D44EF8B2CADAEECFDBFDF51BDCC
      662D5BA46F57E031173325C43465EEEE004D30094337D9FAEC02FD5E60F404DE
      3A0E134BEA002C29A61E3612A2175F53A194E8198BBC144616400F8CF6CA243A
      C0717B0777F5AA4C73D26ACE51D6EDB50809ADBC503577EBE3314ADF72B776D0
      516423931C298F6C3C6F634A64C70EC0165A136E779C8D58482E53CAFB8FA1CD
      2A4F5665243AB96490E01E6E9348A456AA9D1929B6259C3CDE9FABCF3F9522D4
      E051E3AC536520764C805DA5E2E393B749368B1E2BE1347A1CBD4BBECDABD362
      8C7FBF49EBB7F361F4D88834D163C70F7EAC64D8C74AB075AF776F6AF4933F4C
      3D90DA46CF06CF7896A0E95D51E581851056BDB61C01CB242752832A2EDD6199
      C4A8EA33AF8B7E99088AC96A3CD3A4C457B7140B7F41BD7F5FC6DD74C51A9ACE
      1F0EDF9F20E7F3F4ECE0F0243A3A3E398CDEED9D1E2A21F561A51C6AD8D3921F
      36F3A892ABAA27BC05C9A4F7075BE354C3105348E4413B065ED663D3209B16B0
      EB4C806C5CB882C6AE1EF583B67D925C82CFC9CACCB8F7194699CFE4E2DC1502
      A7902179C3380EC503E7E693E372B17FF4116F29809C0F25083EDB392AE8287D
      9C757E2F5D808ED44FC425507502BE48BBBAE4DFCFCEDE07CEF6C32E86B2F892
      E4817D632548A812A58E613BE3E832152BD498C21A8C7FD08E29D1E0F8E2B421
      95400A0324885BE9F30F4C77958A9617C52C1D7504FFA25831B32D3BD11B9F0E
      3F4C44D6A362D9F3027C84785BC5845B7AA3A5C0544F0EA8DC3949051F92116B
      87C80CDE6FBB2EA764192B96864C5A05EC16B3638C51E9944194E3A8C65C53FF
      770960F790BDA515E232EBE524F330C4281EC18271609D505515BB1096864BFF
      09C8CB0F2AF920360D45CE92F12DF8251C70A4B85106735E538F8646888496DC
      C8933719D2952BA6BB5B454B3EAD01863CE49B98B16FAA8E92934E28A99851C2
      512A0721C941F8D072CF79FDBE6395EB7178952B682152FE1B9B336A4989A5BA
      32967013CD8AD93C8B81F002D382C5DBB0C3DAAE3EABAA2405C83D5C37334601
      1CBC132380D7076A6DE9578D0A0D5932A6E153E466FF6D6ED67B7B12678F5A94
      7A49AFF5E7C58E57630CD6B619DABDD09A350B7B55539EEE304CA26181A48A7C
      2CF73322EBE3FBDBADBB9BDBAD9E80B51ACDE9F82F763C55CBBBED56DD4AE00B
      24F968D697DB6A0097D6021802B736E146583308EB02D0BF2CE3A938A4032C3D
      2BD0A2C219541613E387328B8AE077E47BC3E29BDFD9AC630483C81E3E99D375
      E7B32BFD3D69284B186A786D8B0E74AD44AF4252B1C9368D1758694F9FB767E1
      E90F320B17F4D820F1016F2D6F89B72D01792ECEF69724FFA12850CB890CBA4F
      F3B04B2F91D6FBB880B0BBA3DBF82F5EC4C39D3624CC512DCA488A222C7678E5
      ACAA56EEBEA88A817D8060BC368C5711888D47AD225E7AC729BEEF0EDFD5A4D3
      748C54CE897B2C96D218B6157BAB040F06E8D6C197286998445DBB168A129781
      C4ECAE97B422705D908F16A48673D8B556D7659CE69BAF0A314856EF4B654232
      FB749196DC9A58581DEB70DB938BE8BBE89C61E48B0F27D177D191EA8706BC4B
      B4B6F22947CF825245B8D2084180E0A2B7F4972499419C8A2019FC58C300EC42
      1ECDCB0A17458122790B877CB335594EAEC17048EED2A4B56516853E875DC7D0
      96095E05014116A5BF4480DBD072AB2AA307C86D8FD0DF6DBE04FEA32856E6DF
      EF45FF2AF01A653CFA023DEC87580268F3B6547E5D13BBBDE83BBE7C7FF3DBF7
      E3314EAE764DC7A54831A98082C1560D4AD6700E1332CDFDC30882DD58774DEB
      656CC18EFAAA2CE697821E77F80B6A2A091A66F0FA4D552349061F75918965A1
      DDD691BAD300E6447497836039D9D62931ECE5198A6AAE45ED57FC16F71E5298
      31148CFC234E36699E93CC255B7DB3E692E9CE538B2DF1852D881EB62F160D1F
      2924F90A3A491C561EC427B43ABB63298FCDC55DA8260DB8318E5D22E7E50124
      0EBAF657FBB6FE38FCB234B86EA4D027356F21D2F0059384A0816D5EE17E28E1
      A70191921D8AF1B2574B2B5C67080EDB769595A08F1713DBD5474DEE007DCB50
      C6D788F6B1D6136C774B74181559312F37D6ECE0536CC2DDF1C86750FE7F9AC0
      06613C4F8E9F7C0C084AD667A5DFA4F7C0138F6A47C8094A1B3AD0ECF10E821F
      BFD3ECBA9C83A67107CBC9E95FD8731ECBEF77E47926E8AF94257BA121A96A8E
      9A2A1F360489C23D841920A3205B523462F38955A46DC97CAE5648A85722FD21
      1AC029B776D4C453624B7179292ABA50FDABD2618AE228C28ED0EF4362CC0A1D
      C88FD4F080AE9925DE4AE11DA5A58809272FC2885997632EEF24B3E6FE8EC22C
      DD85995897086432D67EE8A60CDCCCC0986DA2D9A11F3F422C2EC82176DEBC9C
      4EAE441FBFD76DBCC3E3B0C794DB08DAF76520B4A5CD27FF6D7A79D53F787F2C
      5B72E30D1CA416369F101EBE8AC64961137A3DA39873B550FA51FE30894794D9
      AD2CB8F753F46477F7FFD8CBDAEEB7D0F1C0916AB3749A4A10C7B1697548CC85
      1DC656631060B1080DB90C6CA7A739B29DD4E8E0685ED56256D9DD71B721EEBC
      8DA7C3797989BCA7D37665B545A7D47D9B5FBE4D7AC432DF977B48C16DAEFC2F
      7D0A562805A9714FD2FAE93A26326FAB6842309B610729AEB45DFACC4981C1FC
      172765AB07582606C582C814CCB72C0E0B4EC0563FDC20CACB443131BC6A107B
      5D426E3383B9FB572EB071324B72E2E420334810937BD913B7C3D0A628A35F26
      B58F1A33F8181A7AE2E2DF21807D7E6266E86636AB90A59CE58A36AD34EB32D6
      5A37A01CE06FCDCAB016E39EBACB5A73DEABA4F5ECD52770501C36D06916DE89
      526BB59A5187D76F07A8BBDCBAFC9A29B5A7A5D5FB88A631D3FAF933BAB887DF
      BE7D13D1C4417488AAAAD98D942C5D60B771838994A83F21434D0836379FE19F
      4FBF7F167530A61DD7F1EEEE2E79B10772353DDFFDF185EBB6FBCED1E1AE7EED
      90528DFA96CA5526C9145A4F6B6D7237773E74C4F23D81E8BB9A2CAE6DF821FC
      ABB28BA928AA7F948B4BAAE08CD3CBB4B6047DE390622FBC3BBB20EC9F89F68A
      4A668D11A29A820F16341DE737D3A25C93881B10A554304D6924814E9AA01722
      2A9FF86AC20D0D7781FDA7B3B8E64475B53829B147179A26C0923BA54ABC301D
      4F46BD62FFDABA17E4B57BD14FD1FFE63CB925771D9774C27CA4CC5F334B96F3
      DAE56F7C9E5B9C5AB0686F53A86B3D4D6B6CE2A1ECA9E320DA02E09EE0AC6317
      2194801F9871E386D66EFEE6965FD9F2FB2A998F8BC596A542B49B9946476471
      6A4F30FB2EB4B4416F74B3226C5DC98F61F64ABE845672D0920F5F93C630EBF4
      86FB7E8BBC964D8EDEE0DB218F3548F770424B0641E358387BF962215D491336
      24656952BC7C71877CA54048918381219372542EFD66E0B3BE05C5D03C157D49
      83CE172A73CA95C2C93EE7F6BD394FBF5184C52916DF282C12146FB25966F867
      F5FE581C7074C1DBA112CAD3835EF4CAE4E2CE6F9069E523FC96DB048F4EC8A5
      ACA212D7CB3A8E16A7F3117154A9D730124A6023F42D312F099DAF7C89D77394
      42BACC412F8CF33A8AA7CC6A82D40C481782DC31CA3B51327049A12BCD421151
      B420578A73C15C7CCB8F8C73E4FE5C3BC5EE8E252EF83A59B7E6D1AD58EE6E51
      8C11CED8975A06ABDEB4F98390D2AC77A91CE98CCB8E35CD503EE222114044A2
      B6263AC6AC26973553260AB2C9D5B4FF61DF19CA92238A582E92A434694E5564
      564ECF876422CE80680D88785AA1DD48A1F3A5451C80A3954985726E6815D71B
      06388FBEDFDD6DA795D092A2A0F7A4B1A3EA987BCFFFF6A94AB2AD07E14CFE00
      2C05719CD93937E2ADE196817205E1254502555AF0794FAB787B12265E7BF539
      52AD9F5ED33D6A8028D21143A07FFD2F9CBCBFFE37379B29E4C2CE0C0D1081A9
      657D402A4DE29A383F6B89C24E50F026CDE7350C17544F22D35E778F62DE6646
      DAD6674E9AF10E6505365E21DF7826C215EA4A0579D378502613F90A869C10A5
      445D822CA5341729FD5F7FB501E1FE4A7EFDB523BB201EB112ADA00D7C9848BF
      5316472A1970D9DB599415971BF65B71C4DBCC0DA6EE6C6A701C1479CD7E477F
      0DC9D12A1BC4E2F06C75CDB9E19FC3ECF5BF6A19265E2CE1607B0752669D947D
      7CA877D2666D5052DFDAE023C236F454B23D5B2693957E637FFFD5AFFF85A9F9
      F5BFA3BFCA1CE9354318CE3F78734918A88BF471D44866A1F584C9ED6A731693
      DB37E3BA55A099672E62C1E7F98CA0DB37B99699D018923A47AE3655A88B229D
      979B4AA3A78085E84EFAC4641738D97FFF11B04712F0168264B7E0EAC4F90C8E
      325C307603AED8A2B3B42A3B3FB81C444D97D7C6FE87FD674FEF3288F203BD7B
      C21BC789707297AA570770C7EEA960C36EDC88FA88CE7AB6C7EB8C84BC3D9EF2
      B772AF361FA86312AC93B167EE93995A8C9319FE6303F357CB32A94367014867
      518AA9CE93511D78D342F3E6DDDEBBF3E3A80B4B0E6A9E586C54388E4735F077
      FDBE2E158D8BA8CD132627BB4E77010D08554DAA60BA87C952956EB029B19F76
      30D4C408518EA3A106CFFD63321E63210412BD64C5EC204383143EB9F383F110
      1725458565AF1B049784AFEC7AACD88B1ED9CDBFE982824040A6DFD8C0D90EC8
      25006F18E3B8BD1139668DE2C4AFBA441963356B00C9844CA5CC2F1358757ED6
      8BAD585949C953B408904B2785199ED95DA83D432935EC5FD8037CB34741C271
      9A0B404740C122E97C31BBFC960EE2D9F91DE80F7C397BDDF5597894F3F2E0E0
      C228B134787219C3866426AD74703BCCF68DEC20F76CEA3342D8A3B4952D0018
      0F2B6A45F63CD98F4A2A80D37B2CB0C7CA926D3D49A6EF1AFFC4DC2F329BB72B
      484FFDE75989E66B28CF635A6E66268F48AB1EBA6C7EBCDC2BD168674D515F1E
      55AE4A686A68005E6C30198B6671CD6053DA5AA7FC064A9412D1F17346B40B61
      04093A2C5DDD7704D571562C99A2C5AEBA129F03FB9BAA8F0AF94FDF0242ECF6
      E0EDFA7511AA4F6ED6B5D628EA22D1D560FB4BE43D89F700051729A40130B6E8
      6C98A55F99E868CEFE33D9DAF69F24862497B140948D7E88147815C68C7DCD44
      28655A074DE0BBED4B4B178255938380A2699024A3A5F9289B93DE9003E99058
      881F9DA8DB50F0349FA355C1F5CEB3E755C7DDDF2439004E012197A5D3DC3A79
      DAC740E0A2052386EBC79D874F9E7EFF34EAF2A8EC472728E71D1DEF34950782
      B475C9DAEC8F667DBDB35FFDC59EF493E608061F807A29C497793DF9819BDA37
      2CD62053DA6F5535690844B9A2D56B3500DB878B6836B48741A72CAEA28F1747
      3F0C1AC9D30A74379B24B2D6B667FC7395CA414AB4AE10421878BA3886B9154A
      718370DD4A79DC00215B3C49F87AA6DBD7E02138534E85F5087FCF60CDEB36C5
      B20CF5FD9AEB75F3CBF1441B5A792F063BAF8BC57D7E28207B918D650B8621CC
      46D7E51DB19B2F73BCFA7697645CC6C37414F5B1E65F6CF504F8B598E03E2775
      BB47FC2B195D491F76B77AC0388628973CE1E9564F48F2CBEC9E8F98A0D8EF3D
      1F019FF35E4FB84CCA29C4DBEEF1843249BEC8039E6DF580AB797E89C204F97D
      6634ADE32CBDDF8BFC339EC5F75D9979515E2797F7ECC84C92BAEF311A385DE7
      97737999ADFB51CEABCABDCA93AD1E51CDEEBDD3AAEB647CCF47D4F3F28B7BC4
      F3B5C7EBF9E11F7090AE384096F4C9CC3A552670019E3FA4A34BFBB8E2221389
      3A3289F48A66C6532066D090BF589F3CD228FD044B588523F86C3AB8928EE69A
      E85278A634DB43E2104E26CE7C5BD1141A165F931DA0CCE42C4AA190B642076B
      A50099AAA2CE47A90515FEF995ABF41A02552CFE02BC6DAD4297984C5E13312F
      C81F0B0011914583ABB5D837B330672CD32825F5C0A1D1B2EDB49AA25F463333
      C43E03B20F054584522535BF8569A9448F7435901D3E73D5F774A9FF1506ECAA
      EF7D01FDACC8FFFAE2C58B17EB503ECF0AA56B2E0273486E7146B2946EF03096
      706FF0EC2845A924A13230BB87B9BA64D1C640E3D72BAAF9D6BD154A22AC9049
      60A44AE16931E7038B3DAD9AB269B66437371355CEDDFD723D7A65093F6A6607
      62749D43999A4ED4ED1CE61D913FB1A386D461BF6B2774A642DBDF0DC2123159
      F372B2577FB147FC04FD1F02BDDCD4554D064BAB768CC8D55EA735D9B1A1F310
      58E2AE687D4335888E9A6809E0A774990340D3FDDAEDFFBFC0FBF86990E6A942
      19EE2FA9D9E22C7B336938DCC6ACA816BE436797A2A4746BEE60F9B7DD910DE9
      3F8BBCEBA508AEE49BB69A30F2887150FD44573AFEC2AF2AA5A073A03564FEBC
      1C2101616FEDB699C45906B2F1F21EE1E89A6B3D35EB0D617B5DB7E26176793D
      1F9D3DEF79911EFD0206808EA24E8694554CBE511B400FA1D532278CF785C326
      BEA8000F8B9E3C416FE6496AA41B23A102531AAF213C4DEFD01881A177E88FF4
      2010EA4F55C39007945F56BFEF3F75CF06DF93E0271B5618C0B85C71846943A9
      2BEC49D7AB71523197D8DE75359D64F9F2D1D25AC038828DC98B49CF417961CD
      858F4657503622818327710BD681A922AC0677A1FB4603BADDA298E3BD16E9AA
      0CCE25B0DECAC5B3F8FD6694220C502C19502C85E5C8832BE156371366A3AE42
      43CB8E34306F42BC6AE138DEE1CC0A02A3DC4659613DDF659A4888A5B5ECCA20
      AA45992D7C0F1D8431E50577597FD8CD883D224CE0BA759A34A2EC25DFBD0075
      96457FCE8BFACFA604D6B0065B4BA85118A88B11C6251620861B865B96989B8D
      47DB5AD6A5799915439EC9C161D1C55BCC5C4514A073CB2FB59D50D76D340BD1
      41A4E78D667D361D7EDEB879BD28FA7660627F346BD2D8F0B638B6A98363BC44
      66AAF47C7768A7935853AE2D961C0C2706CC2828CDC315B166062F15CD1DC615
      083A37E1811B9E956BCE5D794A4F4C5B5F0A58562C95EB9AB09D1CB941C1E6E0
      B85DCD1C246C0D4DC3EC4685041A37CA6DCB46D5031AD70BAD485B0BDC1B7F19
      CD5E7DFBF6EDDB4F4CE5508D6B392EE4A524E1A3BBC84DF7B98E1C894184C7B8
      9C705B0EF94DDB709665D193F1801F3808B63EC79B3A4CE4653D373A30CD711C
      7E592211F6DD4A9F8017D8FDF1D9EE4F77318F5C36C65A0BA39DBE11E5495CDE
      4227A093A699984BA54475B72F0DE6AF768DC449B41FBE322865FD4F342460F7
      87858B5F498C6121C8B0FE814BD65BF3A94FFC53F76FCA34CBD2D1068F657860
      E1712FBEDFDD7D12753F5E1CF57F58AFA7B9C40230DA9D1B7BA702D6E67065C5
      E56AE77477F7D5EEEEE750191D34A9A47C15FDA286944ECAE0FCE2C3F1BB37E7
      9FF5D5EE353A2A2CD230E268D9263489A056F1C8D301245253D46D6CA6FD2EFE
      1872D6DF2D9D8EBAB405ACF19DBBCE890BACE1B66ABE47507B3DE58B38854209
      11FAD0DD4673F37CF9DC04276E524D3FA30A974B6AE992DBF36AEFC7A31F9EBD
      3E3ADA79A8361E6C08EFD2E8392D38E595ADA1FA2D4E0D8ED17FFCE31FFFF8A9
      911E8BA337B806EE3D494F9E2E7F97FD9995B6BD48AA7A9054B35B0691B3F756
      72A30E7CC7568FE9AA645D9F2B73B5814A2DAE846CF1279EC15B265626202062
      B2E7D5A8443EAA644D5A6C15341B49859AA664B563201D81260CDB6BE906D3CE
      6E453C570B95048783D45B403528F8BC16E37FF7297CAB36A4C43B5FC04CF2FC
      D6240BA8742C94F6D4A37EEEFD0927C43FCBE697695E0DEA6FF5468F33BCCD17
      3E568F34CD45F039C86AE1B20D1A904CCCE00DA59449FB7762A24A16AB83D38A
      78CCDF6CD4D1E0957BADCAB45215177F6C66D03402E1AC692BE16F9573931C1C
      2D9A5B25B5A22CC21B479A9CD6850805E9EFB080DB80EC2A0CFFC980F07D481D
      DFF8B74FE5B7A6215E4DA1AE777EB8F1EF9FC9EFCF26937404DFFFE0641FAF7C
      159763D84FF63AFD7006367EF8F3E68BFDE7A70FD6435EEB9F3E346224CFA34F
      1F367EF4F7F2E87D7A18451EED6773C46975993E4CF75F481B0B42E61B3FE0A5
      3C6099B0F94AFBF87862D4D780101DEC4251F6953CC48042231EB5DEC0D889B2
      B159720DCE19434CAA4D2702FD6DFE8D6A0706B69DAC7EFFB380CB23CD20A141
      0934A43756CB5F57D9213344ABD839BAA82E8915DF1F66C5E8CB5D04E5AE8D83
      EB1CF2684C95CBB5CEC7C20FA484BBE5B03AE440BF070FB679A4C52E89031833
      ABBABBBFE9D441BB1CB458A984D08B3A23AD353F180CF8E2A2C259A5D314027E
      AE1459B5738B20BBDE7F1B48B8E1FA136422F63A8CB218748EA0D4ED0AF62D2C
      8B4DCA2E483D54D45D512D76DC65679296AB62AA8296A220B056673096B4177B
      0A8AD4ECF4DC4EEBF9ECC8AED533D7CDBBD313CB425B120A72383542B2D1A4DE
      F7C834FBB6F6DC36A66798480CF97E969575456810766275100211745437292B
      236B54EF2BBB55AC1438B97E7496F8E7FFF91F385A5F92BE226FFFF33FE2C9C6
      E05113484D201BB7F6BAF4EBD65E49B69F6D6C7D4E33253D4876E7DF690EB557
      86C557D9DD5F069F437DC85FFEF17975400E8AF0BC942D424CC152CDFB200634
      960418C9CE6EF5F24E2A77FB75997DA7DA6478397923B269252EABD23B7AA031
      F4BAA45420D11A51CEE51B9FFDBCBEF2B23B3D3AFBED1DDF63411A449E1CEA21
      9C70DB8F41554843FE7DBC41721F04A33F3C3F7DEC3689729E25B48E80FA5A6B
      65838E86A5AEFC79C94C8429242617C1C3556588E84CC459F448F5E98B9C7BD4
      CB4921ED100B962267E8D458667484197DB412C70B8BD76CF9FC05757F8DDD4A
      DA2A0A81AD113FA42DEAF5F6AD540A5BB388F755928DA331760FDA6FAC58D99E
      228EED1D3F393A7AF85F116816AFA28B0CCDAABEC9921D0D25B9770632760745
      A5236630BBF202C9381A5C5E15C8505C9FFFA2DFF48890D9D8A0B3DE08DED9D5
      909E1ED3C8F8939C48F23719B6369D034D1671F986FA789F10BFC6608A9550AB
      0D904A11745138F4B2ACC38F01F9505560F5A17A28EF61A275E8A41C0BF2C48F
      C7DE7DA258E7066FB0B2347D78ED17647C9F1663D5E8DE2C3749BF0CB32C9A24
      52CB4BD3A575A53BD55AA5E414B8B2D3A9863AF1B5CB820EB726FFD43506169F
      8477F72CAE56BB6F340DAD9E655DA050A70455AEE2792688FFC2BBF5BCF5A4A9
      DFFA0A8D4A3102080B7D49060C1381A48E4BADEACACC1D0D42F4787B5B0ED934
      CE6306BC5CDB6B2A2AD9F7644495315DA32732881C5BCB12EAC206BE066B34BF
      DC71F8142F35272BAE46868AE039255BAE2F122ECC2A71195961BD50DCCD8C58
      B8D4229AEE3B54E6BD522295A67454C133B8D77C9214D8D1E9289D515799713D
      D1EE82E6899C286236B604699D9A094E4635E750C647F0982BC1F5E7B34D8794
      41152999670C121D3C4F2B51D3B128D3CB1417893A3032986B1AAA1264522AC3
      87460DA2DC568C3C1010D0F29B4C65D63AAB729420FDBAF5AE3A71C39B60F94A
      32280E00188BD3597DB354125D33BF21FC2F463A4A5152C24FB57E5DDF3A83E0
      6EB16C3953CCA02084DB2A70F3B053A68550884092629E0FE10D2B48F16477F7
      11D7E114FAD85A16C6F8F8CE3CF263C345E96AE5593D2601D0E23A6CD0D5BD08
      8B93AC7A3151238ABFC0A7ADE5909142E2F43A0B550F6E214C3DA7762D5E172C
      469D28E6C04BF9D4E604CBAD39C1B28190137480AD8C1EFAEFA70F0A48C4CFB1
      7170F2B4E67CF340983AA7B2BCBD492277C65AC38C58A5077369B5133DB473CE
      2A1BDDDA840BC2E830FB4FA5B4833A9DEA7DEBA3E80A2C3C096387CB608ACBAC
      003C56B9D378AD67E5DB757C09EF92F6A2AA7005F2C6A96A0C49B90925A48CD3
      AFE91866436392D46D4DA903B95E011B6E07A3D7BA1603CF8DCAF7004692B882
      FE196B43C73E09D49A5D77C048DA2521032D671764B39B4B130AD76FBE940EA9
      A7F3F8403407F8E00F0937841B93F531FCC5D2A90D59474EB0952685E4953606
      668AD4CD766DF5C21B38F69513F1EE25FBC5D7CFC22953645ECC22B766DB20CC
      5D15BA05FB0BAFF0CD500B284E09285CD83110D84B323A1F8FD753E428E52144
      07EF6F3F75505B03AF5B9AADEE188A617DC0CE7EB34B83C1A0D3A84F59B72694
      2AC858627C04FDDED3408560C9F563DA9B2A3145F7581A6D9D2AA322AFF40AD1
      88897984A17AADC3C490DC348361E90C65F7249848C56A2127C1E5A050824195
      AA7A454139194D78774AADA2755683B250D5D133274E631653578D83EF301D66
      7C31CD6FF95E68160EFEBAB033E2D5B3D20B8C2406F07CC925D811EDA971A2AC
      CD2D1888A2CAC4B849E70C7199886961B0E7C2510D6E97ED3E07FCD02E45A679
      3A9CD78EB5E26B9AE91D60E2C6EC14852DB861EC7816FCC49352F4C15E81CAE7
      D901800C56D120DAA3B983EB38858EDE6503DE70ABA7B9F42CD334AC6DB16445
      B9EF09A77EF3C3A3F59C750BB3DDACAFC26DBCBBC6B0B002769078B8D135029B
      A185400ADF3F5C44C7398AC16D0438EA334492733EC33141F0A1BD26A3EFA27D
      11FCFF880A80FAEF03180FAB9AD9FFB0DFEA27752C8D031634727E954EEAEFA4
      E746638E0D2F17155D394A7894D1E8D32FA713895EC8283A7B964D133858FA98
      B5DE4013FB035AF861DF5E659CC0C06A0EFA013F5B8740847116F6705109D786
      2708AD041A5F3EADA4218822F811359783D1A8A4919EE4D85EA7EA3AFAD10842
      9E12D4BC8E914C610A43ABE18E7874D5A49778351B208E5B6AED3A14B0CFE462
      5BEC90DD0C749AC50E818BA7B899F6D8850FDC6614D48C2CB82DF5002472D38F
      8C24D1D43963D52A0E42C359DFAEADF3625E8E90E5B7D73E83DB8DC98DECD000
      0F1F3439931AE39041506F5454E683B10DC6555F56D8A70109984D6BEFAC27CB
      0FAC4D5FF5A82887D29F3E3646F86E2E7228C05988AAA4F93D6652A441A39333
      6912409CBE7AB0D7C2FD140AF0FA31D5A0AAA3492F8C47CB8E74493136CE0114
      2F0C7886C86ED92E2F9FE29D5E3E0DDF29C9C77175C577D2C2DDFD36B7A02909
      E880C729B0B91276519C6583AD5A4CF3E835A2B0A8F5893558E455329A37229F
      BA06619F20F44045F9587E3588F6F21B1751715132C675DB83AE347638D9B632
      D4EF5D7C12CD875B9F64327AB73C88D282CE147705B1E4514E3198F5976F647C
      D75BFE3801ED4890C200BC2F68BEA97D238C147783509E99D71B68D180FC555C
      9B5F75FB9AA54B578B6DEAB835C133487240E19034321B9FCB1484969871B5F6
      BA35DB92E61F458638A5F0829372BBC3FD7DC3CE7DA776AEB26D9C5DE02E5F81
      CA34F32B1465084FF7F6DFF4215D6823561E596F451D37ED313BEA2E7EE25C8C
      B2DDD8EED7E6A85734BB21F221D2126A3267E96C58B0DE87B3FF79D6D01CD6F3
      43BFFB8E54B375A59B965ACA8B262F0391BD658E801368F141DA0567E036E334
      A8D102517E49FD991663168DD40CD6C6611858FF1BE86BF2D50C1D091A85CFDB
      0634028FD7C95C36A2B375995E5E32366F8E419E5C03DCA3A5E51E4EDBA5A9D6
      29BA68CBC2E82BBC85D630AC041ADADFE578B7286B8D9C076F142E4931730FDB
      40668C9BDB12DB02CF0F7867689CBAE1D118F4DA034F481CC2BA1712A3256518
      8123673ECB5592AD7671CE00302F0C9057F1BD756CE43B92B8425BB029A2BFCE
      1F527087D6D1F2E6554E7B9848180CA6FA6DE6B8A6B06AA44F346C1A72ED4B0D
      9995109F06A63602B2F66041610F551E02C1ECFA59859B049C2EEA3032750B92
      D462E92F2B55BF5E6171817DA402B752F8E6767C5A8D320CAC15B7D37BC15B84
      76747241B40F417835A25DD808F23501FDBBA46A67C9EF3305E23B067DFADD67
      A18157F881B71DE480A4DCC8601EBD5C764A88314BB7784910FBF6212525D5BC
      F58719CD3CEA08D1955E739AFFB1A31A42720BCBBC7D0DAFBB78C398617D65B9
      7E79217840E988622134B7FF617F832B5605EA96AC00372CAE7B4154C53A784B
      C3E873B83AD6E3C19B183A5745C1C6C4D868C47844145BEB4D699F88AA3883C0
      812A46EF0A591277235BE0C5659C92F15AD5DAD6F79BAB0B572A02ECD70144E8
      B1137FA5B8D132C021AE169FDCFDB67307E9DF396422DACFE86CCE9CBAE50182
      D851FBB8EF4F0A9F49F8CBB7CFF612AB6954DF0FA27DC5D824BC44A7C912D179
      E58A4248055D3C59C979F4743D8FEDF6BEF1FA7069377E1E5A6AF64B6333128C
      59188DF090B9C526ED390A44E366B346E983E2CD2599318839C4C30D5E5668DC
      8ADD2FBE24457AB570A4A1AA4B5E83CAD3A499C08775D6B455D35C1625593A4A
      4CD21567FE2E85172C974748D1BF98B2F667EF83F801EBACDB91425F5CF64B3F
      5B5D17795D752934423F010F7B63F2B5A5079349614E25371014F117A7018553
      06280F5A26F5BC943430492F863D5CB924266707C555342EE34B97AB2F3BC665
      01350AF8A9FDA4228C4996B905CF4795A8C4172E3FBB06E5AE239342AB171A0F
      745616C30CE5C39C276303BC067367F50E4E9317515F355F6DF09C03A3E68A6A
      B2935EB262E6496A0B9891868C4A25BAAF49E628B8B620F4B6335E00BCF850FE
      9DD79FB1F4EFB2D8ED887362502637B55E3CC6C01D27A98002394227B08759D9
      2E0C50E33CE2D724A7CD0A11AE6AF0AD1264255A436C642FD3788DA31C29D74D
      CE0B983E16BAAF0868A5A264EDFAE6010276665D8D5CB5824671A5177FC8600A
      74B45CAE0B483212DC329696FBA208AA697D46218B989C9260B477B85949D116
      828A2218EBE278CB651E42AA999A2F34BB82E74B891663BE35585C226F16F0ED
      F58BAA23369D1525B4631DFFF53A16AF128A2BC65204220D623B0D27966712A7
      1B3FA2B49A32FBEC78410C02C1CD645A9437567A6E995A6A7308FA1CB203BE11
      CA5154ADB259A047169672D675FFFAAB0A29337ADF8BDCE7E36C54F5A2FDFD6A
      A7014323694C00D725FDBB53F75EC5484CEB0D9141D81B214B36E8B063C53550
      C10DBA20E03303C4A88FA852CBFEB5961BCAAB0A749E0371F8984B119FB7695E
      77A232A17E59E50FE90E0D39BC57476DBBB546C5B20763A9A855DD2AE7DB459D
      5257EB8539A056C559216660A8737D9A3154A97B2B16CB935DAB6E13C511E457
      0AD40D45752BB7B3C55199E7F29B246A161B85DD51F945AA2D29DC06BE5A71AD
      7C6660327ED3E93757C7B50D9D2733049DF2AC4ED912E0A39102DE66306DFEDC
      5FFE81CC19DF04D266AD569D32B29F7C6F057B7407A7A8A850617DA1462C2C50
      A4C9D09D43FFF2A2F857E27EEC46F88E17153C2831242DBCE3CBCF16F96289D2
      859BBED37A4CF775918D77ECB71D5D44EDD878571793D051CAF91A65BF5BF32D
      F448345EAB8617A6B7BF93263F2BCD95D118E3AA221886BEDFA166A9E27869DE
      B4A8364E5C5A668E895A1EDE2FC686115E645F440B5538126F740CDA3B52E29C
      A2BBC487777AD15156C4E009232F8E03405579F940EAECF2AE75CF122223D338
      54986D5DFE0B8E0F5BDACB3AA73AF6A241833074342E8B99D051B093C9489E15
      4C2D88330BA27613BA353466B4FA6960935FCD2F9120D17506258377C26D8E2F
      F3B49E8F931D3846B00FEE3087B2320C6744BBEBFC8F253F89BA2AF239BC593A
      C34DEA17EDC140F07F47E71C39275524596CD0F210520C6D8A6199C45F945969
      256F69B31D89391C97BE3A00DC9CBB9510A21551272B69517B9C015FB0086688
      31DA2D0F429E121AF3A3AB3459770277A40B2DEAB8AB2B7E525449597542EF4C
      5207015FACFC692529B72647D7C856F86554DBD7D04025AEA8FFE3312B128EE2
      ECA238A57DF2F734AFEC17BDC8FF1A9F87FF2D4F5B8BD83E6BF69D806650AF39
      748CEC36639808A727F7D5E203A2AE738B7CB9C19DC0C9A28152A92E46107DD1
      4403976BE17ED0338D46DAAD5250B0D9046FFF46E16F5BE41AF1576B13D3E32E
      7BD5AB0909A914A2F0AA71FA8B625E8F5017DD98407931BEA50A64BB7939EDE4
      A694C24096C322CF707A1C56E90245511E2112CAD3D4B3449A0EA5CF75B12F48
      36455052625CC6DE2773BB2578291596511D33299AE15343F44B0C7264498CAC
      0A9526C210354A46F057D27DA3BA230F445D02377308D7997CABF3CFF8EC35FB
      52B56DFCECE9BCF56E651AA755D4998022430DBF4ED455390EB77555D817794B
      41716AF38A746EEC187353693CDF028879DD0BE6DED145B53019A42683A18684
      B0EBB4458E7D86BC2D3C94C4942A2E75391FD573C87C9919DB25E2A539376101
      660298E247798AAFB66B35505B0B3D9649249B9EA66E551705EF0C265BCC71CE
      19B8165DF8B42B1004E6880F23C26476B361CE1445D3DDBC6C4E2035198BEA37
      2D28E96C635A694CAD5F0A7ADE042B745F5728BD87E41BB84318E92079403C0D
      3941390327493CA93A321B9DBFCD7147F22B767C0A4626E74A03DE301079EDC9
      DA797D13BD8EABE40327AAA35466BA65C3E29B5724E67166F1F200611514C6D5
      A61952E0D063B0DDBF8A82B40A7AEF1F9E9C600691E7673587E5AB3B9B6CAE56
      E73C29BC177DD78BFA324E7F869071D54ECA535426EA08BC08D8A2D373FFF5AE
      C8131BE6E3FC2B0C091719EAAC4FAE951C96A0A0AA1DFB564E5C1681B98816E5
      B53D66B925C14E354D5846822C6F44634AD4E3898D08A3E5192D0D5FA7CBB15C
      48CFE117D5097515D7C6AEDD165385C0918F304B8B77F194E2D19562C91B9654
      0C83876E108DCCB03A13B74A600018CC374C78030241B107C6D9869A20A184B7
      95AD5EF2262EC1546B183A45ACE18DF4730DD86BAC56B01FC9B84364A1E39AEA
      1026B4746D29A4D5F310638C5A29D59540410E67367036CC04941B3D046114D7
      AF0AB91C04F9AECB74F405D5DE2A119E707E062ECB82EA9CE2EED509AA255A9B
      102B5E9F5C7A26FB7BD928BA69B692C48BF5C5FDC9E91EF1789EFBC7D919E3DF
      4ED087455371231C7E5FF5C645BAD2123997F7DED59BC47A64C85A6A76CF252D
      77B2B27AB769C6C752021CAA645043A6958328890B834A7D7B8415E221CF56E4
      E58BE2CBDDDDEE8E5E2B90A2A958E8A113A8DAAD0C232D96BF24282B07EBA44C
      E0695AFA78D84A70FC593B83E8B5A6725B622EEFFF82C0C4E9DEF94554CD876E
      661DEA1B181F1AA7E473E9F64287D22AAE3906ABA892CB15CEC30D02AE12B750
      953B637CCC73A9D7059C05D3C335841B3411FB06F4DE348F72E674EE70FC6749
      21856E498D72C20C28CD91CCCC568973D3A612BF5FABC0614E5DDDCCB02AE806
      E53BFDE9EE6B499BD5034B56417833C6EAA2311B96E125AB5C73F4E331323A35
      230CFC172B5F90449DBDF1581F10C60AEFC81A59D628273C69B74BA26D254A0C
      569DD2A5E2ABE52195F89CEDE0F2B3EC4179F4DB3CA95C815FF72A34BD367B99
      D5161309153EDE61ABDEC8A2E1E267C2A6557620EDD82EE646BC8A68BBFC90BF
      934844EEB3C9EB22EA1FFF9C17D77FBF8AEBE3E94191E69783E83DA8405A01D3
      159C684866E394D25097AA1469E25ACEBC3567B28D8B08C50AA26B3C817F41B5
      52B672D782C1821ACAB2A22B5615BCB6E436320FCDD49256A31C7EF1F10817D5
      2E85F87C4A7640E0C1E9BC1A393947191AB708962224E157A22E5725328B162F
      D89D8E5BB3CCF9B615450602DE743553BEBD229776A6F11D98D21F74E3D023A2
      65AB7FBC676F906FF42C4051D420D4006F344531CD89F74AB0DEF819B92412DB
      D162AB52CF03699E7EEF66094E47C501D569C893447188A13F1CB194496C1A8B
      C6BD496F86D237294BCFE29A97E0BEDAB23BFA69A308A821DB5B2831892716CA
      BE021C5ECDB6D040FE2DBF3430BE4502DA40EE00D93FE6770A9A70787E4A1538
      D957BEEC8AE45E78D934419779900650C1BD4A83BFA745FA219944BFBC3FF9F7
      0FAF76F97F4F9E7FC6801BF4E033B7BC6CE7B795A111FFD8AE666ED98359869B
      88EF92C7E375C2265C0E44100816142D48F8530583380B94306531F985B8AE76
      5228CE111AAD7509DF09DDFA6097D418A2336D0782B3BAD4825E31F66FADBB83
      B1A05849651B669D9BBFECA741E44F771D617489C3369854EAA80A819BF2C1D3
      6142203130B9926F6B9240172CFC4655A4715CC776CD87D57393B07E401CFDFA
      5F6FE2698284915FFF7BE0DFCA5214F97AC36445A7568CEF453ADB7840F95D45
      94DAE54C960E6CCDC3194EB52915999D368DD1D96203EFD135EC0F575370B3CC
      081A99DCF3781ABE0C096161802C4EDEDDC7C83845FB2EBDA7C8979D282B3D2D
      492DBA9D39A7499E6CCACC33C658AD522DF8C5923C689F39C84551EF5612D26A
      CF4FE93CDFEDB71AF66518E47CD0B69EB17E085ADF7CDC7EF99494379FA32518
      5EB51DD1A9D93FCFA2592986DEFF0DED63D97A11A3BEA24C4162D5725DCC26C2
      E8E82A5267033A479A3842146D69A8C90B1C4115827C0898F3303EC9F3563EDF
      53A79DEAAB6619FE68880952A175CFAF7C61C46997BEB4C57288070B96B4F882
      61CD15B2901B32F581D6B7835A42726B23AB2F40E94CF82F9D8804625A89FA61
      834DB6D36B60F374FDA802E6B8160D3A9051BCECC86E553409A43E2CE54AD45B
      ADDF56BC8610ABA8C66944B1AAE37A5E6DBCD06585FF029ACD6781BCFFF0F54D
      47C3ADEB40A6D8AA88053A03A1C6E9829C6B58CA6369B06991E76CD5252C08B7
      A0A790430D9F5BE4632E720AFC2F533072668386633B6AF3775C88D5FBF51D4F
      E8444F2DA4705BDB83F5238777B1D15BB241E84BCB9EEE451F0F3EF4CC2339BE
      38ED4455F2DB9C883E4D9B99D85BCF44BBBF7D7A2815C579FA3255C0DA10D215
      F8ADA94CD6797D767EFEF8E4ECECC20552A20F09B0D7463C65E54BCADA14B74A
      02274D8EFABCCC71C94CA2CE39653F23898A541DBA8249EED009D234E0D13BD2
      BCB36B8E2F4EDB056B4575992A579DE308AE7C045F3E3A7E348DE8CE6B18078D
      189E63A493E83A2E2994B8065646380CA32E58B4C408E558B7C13A88AF51C6A7
      1C93CDC75C1B77A356C51CA20A699903A0CAC6CCC896B43FE7C56926B89D3C1A
      A6C306C8415F8BD2AA9ABBC2F226961E80F8CF064F074F34F1DB219A4BA8F10B
      88CB24FD665E50354F0C5151AF00DE9EA9FA04F70F228A61F688233969A0DDA8
      505E5E6AF1DC32A5A1A224D2C4D089A34699E76A1A6CB2A6C9C50E38A8124C07
      3D9E28916E21D45BD4A07A9349B0BE8C42330A1CF65C56B583086765319E8F08
      4AA6131E2992A9C4DBC023E698B8699CC39F9E26F55531C6E5E494AE5DA45D8F
      3E8C6CF0E7806BFEF140CA1528B4777C717A0766184ACA3CCA1F1D80F5C4BA8A
      45C3C9DB982D76BC84206691857684E756E3B2D13A80D630A140B5B028F3DD38
      BF00DAB03219D8036699D2D8CF1967D97C304EA172804BBEAC47B897A140FD6F
      F3E92CBA285C79E68D47C4148C44F87B197F4EDF48A7926A5EAE35CB8BBCAB9F
      FA2EFE8ADA6457D04E76B0E05D8BB7F4109A8A795D276357A30DFF04C70BEC2E
      756702A330F90D0BD9B28D4DEF32CC9475CFD4933B4CF970EE53AEFDF7554FE4
      34D6A6918AC478D038F9E6430F428FA49AA4EEB741D4FD6071A2850B45CE0FDC
      3808C44E26831DA47AA29DFD9F891171B9C5C394D1A5EA6A3E99B0E44F2CAA97
      726E047A27AD748D56675B5572CB84141E9CEE2A3C1DC40C1A3FB75AA5CA0DBA
      CC59D187D1A934079F4410F63CB809DFED7D3A955B908BC75B78229BDB8B2E01
      C510971ECF5D55406F6ECECB092E1F24040AED866AAC772EFED393128F658ADA
      0AC504B1AB3A1DE908E92AE0F545543EAC578A6F26DFA2515194E33427AF3438
      D3836F68A5C9553DFBB01803F4E8806E0F01E619318ACBB100798D183357BE2D
      CA3591A2E5F16CF1B8ED14B8686E020E0967AD3B2C6A1023751FB4364B435E3A
      D888C180CA56DD4193FFC429E202788E70A6DF0B22353D11352373886FAA6CD6
      3B609286BE5CCD6BB266D59FE08B947388C66F00B33A3DD640A8D49121259CE9
      5284F10BA48A7856067BD00B3E446C509E178AA5B5E8ED48B72AD3CB2BA01965
      0EABDA5DE0AEF30A64C8735D66B1B6D7C039554E46ABDE27D1D9CFB0DAEB36A9
      02228AEBC936B988374457E0D4E7AE708BE5DF68D03A18F5DE8A8E8A82959B8D
      253612AEE1349FDF29EAE45206EB0231A20D3221C3AFFB2809869B35D500C685
      4A4E6F8F2F4E0F2B83A4F543668F1F1F446F8F2FE1305FC0A0D2C0DFA11CC23B
      D13081DAD4BA8DEAE6DA8A46A86FC1303F1342BA3CB6E35159545022A896E8F9
      AC1E2011E61C27591D8B14B4D87EEB866B2FEA04BFA183E5C44614A39555A0C9
      3F0D42180F38DB39C3A4BE2697F1BAF0F40128BD8B5DB4896BCA23ADA7952783
      7AB4F0944A49C1EA9C26E0CD135E55DF78006A16C29912396A371FFAFD81ADEC
      5FBAB7A03DBBD886B153250BAC74666238DE8E4725A8A569FD37359B5A52E3F8
      CBD37CBCFCCBABA14C5F5438EC84304902616B79ADD68E3031D2906F060721E8
      861B372128D954AC5C687EA3C5D597A0104B52B65F90665830316D852B319A8C
      C61A34B6D14EE37C32468A40C3ECC6D1161A5D71F3C58084ECC35EB00C828C79
      0224525A6FCE3BD1291375FF1A1D72039F8FCA02A9C5A2CC41950EFF2DEE1614
      457C938CBE20F452CB4294FB3F783DE8F3AEF50B47C58CC093D48FB6F7F55270
      C12B7098C5DD8BAB25AB801C0B1A2E2EBFD2B48C9ACBA105A081A163A2808885
      DA379D5EAD74D1093B07FA8BAA2CDA68DC283AA983BEBAAD97280D973DBE38F5
      651976FCA98345735D344B3931E156845F9D0FBEE95AE24833A02D167A6393E1
      76B8CB9178B5782E6DB8CDC5CA4313D3A96439B09985B3A7524627465C0D7149
      70556CC84E8B3571A713679BB5EFD0F0B20A06574B206D747FB52983819E1D24
      C491B95BC73909DF7A74B75E5192021A5A58CDDB457E0A1448AE69670D69786E
      75F616089E95683D731A4F8BF11E07F4B418BF56E05DD449EAF7E8D2DEEB817C
      E7B2A85D0010DFC213AEF12624375E024B0422842840F86B2751B849EFF4DC6D
      8E49B8C0B061B93583ED280A3B7B7AC39589442D657D9834FF2BFDCA019E2B3D
      2355FD75AFF5AE9B39235A4120F4492E71CCB2905B63BFA479D8A64B4134FED7
      8AFDD5604EEB7965E3DF7A75436413EA8CF487377D1731E609272976A2A124E3
      2403D8FADCEE28FF796B1DFC1DBE3653D5358288A5D73E07DC826A8C350F51E5
      B8A8300C9028B8A978204FAE70A0E0E56D3C31ABEFEB50AADDF1E7E7259D02A6
      7F6B5A35E0132676C8B989BF74356DBE98D71C515D54EDD3666749E51C52DD5C
      6D7B078AE2B1EB8F6444007C3EE4BC4A26F38C357B626C7D8935BAB08868D906
      CF574CC4F43F4DC6A9F1AE6AFD7B3435500935E69C19455A9390BCBCE2322100
      08160867DE2EB0D6D339946E20B51651383E7ABE0B8CC5D41D7DB48F9735072D
      EA9EC68EFD27CE9915840D0C703D46C304751F260D4E922A09DEDD5595312E97
      9A66562268B079296C339E26ACB6E6E9F40137D69B4C2BA525F1204BF5718FC1
      931B8F088B99F68018A65FE38C119782C3B6491392CAD4B6E4DA45B3A13D8C65
      E00241560AC13187AA792A58A211B520ADFCA5B12D9BB504F038B7C8429166B5
      591998D978E85F131C20E8C7D2146F936CD68BDE25DFE6D569811CE83769FD76
      3EEC213889C39612BDEFE3BA4CE0FEC797AB7524ECE9B7E51EB6A00F77EB2372
      739DE66344B9A563DB49EEE26D205EEED53739CC4B58369B3ED18D8CAA4EFBFF
      C660F8A7A3EA14302D576838AE790948C01E913EAF37E2C8FE56142AAEB6EB9C
      CC55D4973BC795A660CD1E81156A442CC710F729664CC90E2E45EBB707F82496
      2831B72DBBA4CB46474BDED93EAB92F22B4EC50F499CF5799C8D98ED481B9A07
      937C5FD2FC703B6ACF41088E0E41EB40A805E65F9221E967BB2EDA6AEE4787D9
      94A854B9F7F151D558E5C1B241B5A4D24E17C999A98A6CCE628400D62443DFC7
      8A8BFC12F1DD68326789C170F06DD037DFAEAAEE4886C6C64293B22C36CC2D68
      86C38DFE6B79774B1DF77C83165CB66F18F1F0B756E7800C5FDF882E65B1DD8C
      38BB360BCFCCF94625A95E5B43A5A901ED2554B44DC54B4D83EA2E35CDF42CF8
      3D877AA346EE3ADAFE14FB4307DC37BB7ACC17DA756727B014B897D3342FFC30
      759928FE7CB03BF8D68B9E0F9EE27F0683012C4EADBE5439A291598402CDF114
      EA9AA07E6A86BA4AF8E8BB3A7E945BF9826DB3F07090782B0CF6D634B88413CD
      04BD03946B0752994C11782C1B83BC1ACA6D6B08B9C4D0ABF4F22AE3158C3E59
      0B321DEB66813C069938CA66A5D442D2F1644B8A34B88507294C114372C837DD
      5C25D1B2F0A0AC7B265DAFCF5C067D86565289D583FA3D79513A9E7D2BFFD78A
      B6B9EEA5013A3CCB10B7E204D928E07916BC1A178802F2CF7ED5C25A4FCA699C
      CBF5DD7EFECAEE6BF28E45AEED42F11A72C14531888EE4F29005481C430D4FA4
      8254AAF4037BD3F537992550AF91B526727E88B4E8B5E540AF692139784091E6
      795ADFDC85064C8AC3753A46DD76506ED74DD7E22FA2AE6C308E1BB43597E96A
      2E884E9A31694572D729EB679936AD96688CF3229DCEA7DA9562125DC599E2CF
      1A83D53F35C89EBA655737E664342DB55A490ADB59B0E7D61DA90864A458CB6A
      B36AE79BF4BA39FCAE30955AA94EFD83E88A24B38BB0AD2466D2C9F7DE9F402F
      5BBDD251CAD47B3509EB145593952ED30D69DD3B3ED9ABF97A16FA819BE06A87
      D0FD07F74336A256731B47F194D2D97EEC2C1D910D562924C116089C36284AFB
      505784702B7EB1FD7B5F606DCB8BBBA527D4074F765EDE15028622FAC10DE2BD
      0627F69147D5A84C92BCF1866C4616A103221B2D08E398318A85C8EB5D5EED7C
      0A04B10F046A08CA847A15EEADC9C990A91FFCEE03A0B713AB69FB86825540B5
      9744C9DDA32C95920941871A3AC7F9C24F3526BF6AF552CDBC2C78AA23A10CD0
      C65539CFBFA0AAAB5370B187E2DD824C9A555D7AB8F95D996984AEE48567E590
      F9C792CD6571BDF6ACEFACF97DFB929632AAE3C7CE786A0816AC1622DE80CAC0
      A8F17647F0316A174A7178D1B8F5F20D9257364E2B8A3480218E182E34789526
      E034B970E0098B1E6FF03AC9D3CBDCFFB540C015863EA6F13E35D458650FBBC6
      68EEB7F6D55075498D97AACEDAF99D5E304FEC92FC564BA8297163EB0E2EA8B8
      07998D1B8EDFA949DAC1C00ED7D8DA815C9FF9494B31C9624D4465E60FF3911A
      FBC8C52DEE98F7D4509447ED8BB09D4FAE9D6509513E87C4987AC31B5AD4D32A
      19756E5396D7B9FB7E773D80AEBC733913D91711FDA2614FE68F4821210D78C9
      4848A47EB1DFE28D0D6FA22B1550E69E96229A41D5CD2FC90D057639F64ECD43
      3C2EDDF4D22783F09D8D134F994B872FA50BD8672B92A74AD3D0682EA25D33D9
      E5959D2E04A126548D338E525397C094BBECBC756290B6DB646C1891E5D06C93
      7CBC97E18488F1FFA5AC7559C6378E7BBE79D582750F5A59910042A39B1EAE3D
      88C72AE08E262A9DF8FD221715836AC797A6406FD65AEDE9654E988C807E6D42
      02FF6BE58F0412F8168369DB73994D0C8C703C804DE82CF1880993A2504D9905
      02B4DADBCA34A3BD287A1D45AF57A2DF51B41F457B2B63B7ABFEA855486C186C
      984315107479D30EAFE9EABAB759FD1ED1EA57013B575605EDA9B414E64CD738
      90A119F5D74672A72E1AFA6D5D595F3B3833BABA867634A4A0A6BAAC6EAAF373
      299244BB6CB1ADD8849AB1886DCD13E7628373FD2C942D8D87BD4063AE6149A2
      FA95E5B20F638DDB9978E306EEE531326B9648240D6FA4825E9C8F1FA3DF081A
      AFAFD3182416D26CF802F19A4033D2C4DE34C741D205312E12ED6E040B645A71
      B3E30AA1990E235FE45EE8B015C5DAD466191ED859EE2E669F78655CA5D9B84C
      F25E849787808E44DFA5494800E9C7B809E425A8DC112469AC23645E14A6A949
      51390F5C7D496E24D3795E6D694522B7F81D96E3FFE500DA7CE91420CD6BBBC7
      D6D9779FEC899CF57B3FD2C9E982BEFDCAF5B4FF932DAEFE4FBEB1FE4F4DA9DE
      AD5A0C2A6ABF129BC31ABDE5BDD0BBDB9BDD40A5460B80C82C93F7AB04B7C653
      579FA704894FB1CB3FCE1EA3EF51171ECA0E4A84936B6F35C3F58FB6860826BB
      05461790D248F00FEBF8262C768A8EEA4DBD41B528E8E5B82E6881F0DB5B45F5
      0E916554984DCE516B6E790C210822987D71C44786D5255D829C8E6767997AB9
      D49DD5BC44B5EFD40077D47DE6588C43D391B9D262858A7F8877B697DD6088A8
      AABD6E20F0A5D9AD23BF1E11AD00CC52340C69ED593C4CA4B0CC8A15BB783607
      3FEDFAF884DD894B55B225A844BCA499CD625081F06D1C6E6229461C8BBBF26B
      CA244BBE82C906864D00F9B48D963C580FD281FA66A65451EC7001AAA99DEF68
      5444AA21E22851E0BBCF83EA2243BB9055BB713E22C74093169583EA24E624AD
      A1F3CB4192CC3E8BBC45A02DF018D634E815EB18F334868384C878E191DDC633
      55F5D43DDB17CF118E638B020B1BD8E1FB0D959438A8D9C3045835BD556C5561
      A538FAFB8793035A44D187C3A30FFE737C6BC79224BD6072600130B158336971
      472F8C2597E7E06E0A8216FED6008D00AD721E982A8C1C0CD5B21683CC5E99E5
      D5E961B85544C4D6B287B95DCCC333401DF13070245C0F0C5C34CA8AD4889752
      336E9341704B050376545E68599756A57CFAC40279D01A33C502399D69FB879E
      6B1F67697D1375453DD3E473E8554BC684854B31C76541AEDCFECF3BA4BF6179
      2E53546706233663F2FF9AFBD6E6B69164CBEF1BB1FFA186BBB1A6A629CAB2D5
      6EB7FACE4CE8E9D66DBD4694EDBEDBDD310192A0843109B001D0B22666FFFBC6
      3999592850D4C380E6C6F4870E4B228142A12A2B1F27CF196F3FBD05E528FD3B
      98F2D0425384437D6C433DF8C527289629460BBEE003C4571A610464EA4A3FA5
      1963C8152DE9E189D473E6570F4F2B0C355897DD3FF935141272201CF5AC8775
      162B81EDD30926F24FB576C115842E44D6607468F33C9E2477C40F974212CD25
      A04F73396A8006A3E9AF038523C7EF108F70B42F070ECC4DC575A7761A063F94
      C656090D33A1AA38B25A026CC591C2240B6EE499086FE3B2EACBAE66BDC6F128
      4414C4E055D64A0547CBF861A4E847A152D896F8A7A6A17D7A76698A4FA0A4A9
      3129693C3453B05A1515E9FB909F12A35A43CBE657B468E929315A3A785C57A0
      509FE35CE903AAB3E2C16D73F77B9DAABB374C7459F78B300DDF3B0E7F403D89
      44F734680B02D1586D92F1B26D6098E7AABB24CCCA78906B6D7AD5F83E0596B0
      720A3E47683D15C65712864B65E7EE186AB7D3461AE50E5FCDB9CD94F1885355
      E3FDAD58B56D249048E4DA335D3860ACAF12EB25195D6789343E77FE0BFC10D2
      03AC3430A799FFC553E6407D9FAA0270B7D5C6A660E543853091479E4E8F64BA
      37C674519B4126F3F56B7787C1840E3EFFF08B08C5F2181B3DC1E117B34CFCDD
      F221D263576ECD5DC3FAFFAA6DB84A35512948824E39C9532CA9484F42AFC114
      45E449F5B5545F50A23CDD34D3E9F244A9A85745A823D79141048C5077A7DEA6
      526AEA1FD423D8538F401C9CBA3F914D404F8059A4E71129055638B3BEA6375B
      0072FA15A937E92DD2231FEDB658F00783E3CED3C9E341B257DC39B8F90AFD01
      F767F7BF0F0F0FA56FA78432A044A6950B40912B12AD07C7E27FFC895F234337
      8DC22482EA58089B2F33CC417A5B13BED055FC849EAE7FCBD3E9C2F8B6FD3BC9
      B3D9E3CDD65A5052F1EB4AA4D19EAAB88EC08A814DE0BDCA20847CD8F7A33DBC
      6FADFC7B4EF1C374BB95845E24E216D8B9EC76F62E25B93748416E9A27A1F512
      BB2C6FEAABEAFCEFC8752FE4B181102726F3EC74E7C467C71E7A9AF5C3E4CB39
      6C475182FD6B63FD34ABFF06EF6B5DF2EAB8A87CC07E0A6F6B8C2EC2C04F0048
      E0E57BC600E63830E73369C3565C349BB16607839364F27540B6693417DFF8D4
      58722D93FFB0A71350EADA17944A8030B35FD67F73C5ED6C984D2B9D94009038
      921B8BC57944984086286CF9F197B952CBFB3ABFC438010DBE9CA79679A1A523
      2D9DB6CF4915951A55769ED3AE4187537C1244B9597E955186BA5694C67D91D7
      F720425D9F24F8CEB81A291F02DB9FF75D575C7DCDF318938E4AC2F19482991D
      7BB122A57CAEF242C609297FB06F1A0098A59F24505EF13C5F72C1E53EA41539
      1BCB2E5A202C0946025A3D61C73A093B2679A6956615D752C60B7B91F672A48D
      7CF97530F355F1C02C53CA984C5EF8B2700C4DA71573363F0A5E117F15B893B0
      4CA404B3B406729A1ADA8DEFBC3CEBE85A46F33D8555260C22BD261A9FCBE620
      E8ED96751A30A4F905C936A2FAF7E5C3E1D7FDACAEB800FB2AED0EBA2DF4F3B2
      2F78CD6E903AD697AB506E45150AB60033BCE21E7EB2792D41FF895CB230C2D7
      AE61CFF1F01CD639FDFD0AD3E4E72FEBBFF5B47215F65F5633EBF7BE64C5C722
      9CB87C99715C90C252F5CB35FBFB52C2FAB0D4CA5C95E4188A95B01C0DCD91CA
      56B89091FA119A19DEDFAD2AE506A24B5ABDC7B0EBEDB2422F96DD7C0510FE14
      491E71CB9C9CBD01D7FAA3C0B4FAB73B7EDBDD552AB1526D059A4AD021F7E571
      48848942A0A12A203795D5F317EEEA3A17664C83A6690E4B42D61E117F50C183
      6FDCE6D714B3ABC7D1638D06A14A8D1947E86333E74F380F3FF03CB4E15D8C61
      2C088982345C714719EB1EC990FBE8D5055C53431D55BAC6C443681F666D4C9A
      79B3102933DB44BAD16A789406A51CD8F215F0E7AF16C318BB491C8F79186A86
      8CBBCD67C81E4451EEAFFC069A4A12B168957E5AA88F14F2CCF7B4684AFD0D76
      C0301041CA0CD45DA15A987A2C1DD125FAC5DFF03715DA94AF78AC459A6971C6
      FEE28FDF69C6105345964DA1D9DAE46568356A2890E784DCF8BA2C14743D8A96
      34134292B42715AD88DA941E3C0DF08CA704767F797AE100055402991521756B
      22AE2B6E8B329E2155F9F405B18EFDCE742A3A2DB854D192EA3DDFC7F65EF5FD
      40E0C5126A7E1BDE1144B12C533A56863563ECF6F4DEC421237A15335F4B3607
      E4D6740E7920159FC03EAF77A36A61703FBA2E2B28B42B92702F75F815114A34
      8B8FC163B801523FD46EF0D3C3E0ACE08396A0C08A3CDC1A1C985537E5D2C773
      6960F7D7244751EBB726C7A0920D5A4B9A35966946A7EAD5D75FA003589069D5
      DF43D136EB8F5A72B64CE0BA9A8D8701D29DF3A8BCEE1063645A9F15B38215C0
      B0C31E576FB35B83D856EA92667756587353974B527DD27B1B1E83828B3F5902
      49E1A70ACCD5B33FB57E6A8142FBF8910B006F0CE50389E4D901A31DE962CF84
      6ED12A326CBB7A8476995B135F23D766B53D97819570A051C58C8B6037FBB69B
      A5AE873B6F3B492B5E7025AE568668B479C96BDD8D469F907DA4200CA5D6BE36
      0B7057B0AE46E0AA6CDC5F1E6EF5DA5109F38A0F74F535023B6BFA17413419F2
      651A1766C5E9C0D7F498AFCD4C9CD07F84AA975EDC4874BC822C15A4058DB15B
      F94BD50337844EF077149EA180943EB287762499918CDC2CC600926256AD8DA0
      A0AAB11EDC2A45296713AFF116FACBABA6083A5B9E82C29386DC7532852829F5
      51F47288A36B7505E0A3626122DEB9C27468BDD20F55032A61B85697F76555EA
      AB28EE48889328D54EF329F41B5826AF93C70097279FE3CE8A79D2472300131F
      2FDC87939D7DD087CE410E2BF4529C8CCE80DA7F1D38579D1DC24AB389B35F8A
      A62AB380C274151EA5EC637DD2757A94BACE5C940F9332471DD3785681610439
      2A3C40F8D0C8A03C52DB5CCDFB0A79BF2E1E720D4C74C95C7760F0C4A12BFDFE
      48196077A42F945078E1E6062CEAE18AF372F9E0289D643E868A4565A94E6BCB
      BAC835DB4C0A777B7B7BBB3E9BAD8FC7EE7D11E7DBEE8B3B02C1F2B6BBC5E441
      A0D77571024DA7EEE557848BEF7950E218CAF2A37D8266A7D195B2F40B29692A
      F58D47ECC932BFF0C6E1D9776FDCC1FED1A53D65506081DDA9A0607AE24755AB
      CA3C4FB25C0B2AA3B9172F7AF8A8F3891E4927D6199B7947D2FAF07085566B8D
      922DB45C917EB90F8E963BBC422A31663316288FD0187AB26D4B0241649B4CA8
      FEE924EE63CB54C717D22C0AB34F3D9CA9572EEC904E870A5E851F985786B1E9
      4ED260C26B4C4B7E6E966786710013EDD5DDA4354F0561962997F82D36848867
      53C9237074B58428838FA3CB93AFC29EF37827C7B6B8F051196FF0CE289A449F
      E3C770F64A18EDED72C8A274CF9593C2FD2DCDCABF059969D9C10100A48BD52F
      4136F2BA6B7541529B831AA0A42AFA3CFE544F9F22B54CA84302DD46C5D68B33
      D8B73223C44D5CF2CA4BED02EDD6733B7B3F5E4814DC73C73BA7FB3D77FEEE42
      3F4CEA6BD0A7E18AE843375B981156DB5DABE985166247D79E2044F0FEE83EF5
      01D8E5FA03E0D2A002F50F12B8F80AD1C0971E5528DDA949818732E0D233C5AA
      B75466D831870268C6C3E71BF7A5E76E1F6D1BA855CD2A706A114739B229ECA0
      AA5EBE3C24AAEAC26D54C795C8EE546D4DAE1364170CD623247DF4E325E950BF
      AABA3913BABCE2464BEF531A072CB14F3C3419DD2EBFA1950BC5F30EEA82A91F
      A08FD2D4E39A7206BFBBD8775DA6A0A8796174787C5E35ACF53ECE799C0B5AB3
      5759A57BA6BD56945906F404534CEE92C00B055B5A2677299ED0FBA56EC243DB
      4D6AE9D52A636135D17B607B78F2144CBF461DDE75E4FA80B481A6D9A392DF7B
      7A4C28B005CA881559100E4A2E910E51F802FD04CABE178EDCAF6468B27A8312
      1470915048DCE6484A32F60A1E9FE507A717E47B22DBAC5C3C6511DE5D11C17E
      6A957BB2175A013A44FE0FBC6AD86616AAB32A50B62A5D6BA7135A91B05795E4
      513E25EC6E7C5FF252F80E24FA0B17EB7041211E100F86A7B61F334FEE6A0555
      B3314E249547C919397AED4FB6765478BAFAB618246E329FAB36F459C0CD29EC
      2E3643D8474CE4E223B22621C12B2DA09E0654F7AEE1A4042DC00629AD9BF089
      F1059829FC050D54AC79979ED4BABE38BEC2D1DDB170AF6A294618B1A22797CA
      48483248214A64CE174800A84FF9D81970AF6223960B9C743CD004C6749A14EC
      D2AB85A2BA5229043E61BE1D4EEBDD6188E9F00CE95537A7114E8A701151E155
      F14F248AB430C875C416B15539FCBB94560160CE606D9150590330A916541060
      D5D084E38FDD0D2012E38EAB3CB0EA8ADA6852CB525945AFEAEC643E7731677D
      98422B7DD7DD15C407D5C06A28FD0046503DB8D849D9F98A15A903F76EC0B030
      7FB8362E1D4092A5ABE702D20C3A2A6A45971948A395AB107F9133BBB24CA159
      E380F1683886920C9D0D342C5AE8BD6B0D6A59C825CADFAA0DF39E025368DA74
      8E2D8BCEACA35D5AB8CA089FC60A10CB21F000F42506794AFBC613AA5B5FA3DE
      20E27A5EF549A59A56257C9F025861FDD32E197AB44FBCB65581AF89792771B4
      34A9E925E6600618C6A308A704C84DB3594CED3FFFC14A5E4BF7A4ACD165684F
      AD8C6D6D321A62275F1424501DE5CCB83C7D568FCFF6DF55D4DF0F6634A29C3D
      2B46BC753763A9D7424696480CA8E140A1274BFFF0E4F1500B7632CD64B3CC33
      709309DD25F48BA81B93A916CB8386F9446A718A26A3A89139FFFA824CDB0687
      A2C8B02CDD56F38C5D6F22E00F9E46A7B59DE593D6AAD8C28918A3DBAAD288B4
      BA6070635104783885F4C023DCD43469B211B27C5656ADCF14322AFA63D590F1
      84D66324EF3EA5544DBFFB32EEBE0A2F886094CBBBB084C538922C02ABD202F6
      9E00A668D9594808CAF72B9576B3445E100774C47024AE52028898EBA419F779
      54E48124C112A5B725BB9C5132C7678679F6496CA630ED4505594B656BE10161
      5AD1428123F12B84DF3F6622B44804C589C8D56C548D5DFA1BACAF8BF76945C4
      B8334D9866737F7D3FB85C7B2C3A5ACA2C2F55C2A88AE1714B4CB092D66E1806
      655C1B76F3E3C1A5FB53503B91D17C2EF0A7BD81FB13B1755ABE0CFF768CBF1D
      679AAFE05FD6EE09E58B9B649973BF1AA3D1C055B17C387D928AAD4FA07DE39E
      AE26FC4EE7F7AB3B2355935912C1ACEC1BD8FF89327D3BC68EC036ECA51C7CC5
      79208155485993CD86D930FB62829AC145B8D3A7C92C299715ECF42AF65DBEDA
      F47E6E02E1058BD25B5D3906C9051AF7F148B61678F8535C86C0C26798A8D091
      DDC11CF6EEE9A5A0EA8D5DA35E84827DA34087B450BAEEC036FF382946518E89
      B5AF54A5AA87ADE8B29C19E93941C5F9DFF120E12348D742A6D1A00FF7F4AEE1
      E3E84B50E930436888D4985769165CA77E9BB576CB4021E3A3BAB34F9201E6DD
      54C82CB22B7A900AE588C3880D54130CFF16DA1F62A935BA016A9A97BB5F5668
      B93EE404700C34E34FDC8B549E1A839568673C161CF4D1E424A1CA5C378A914A
      DE76473743FCE3071715F211FC841DB18D702B49AF7E70D120CB4BF963B1ED76
      B38C32B27F729768D4FF81D64E9B2A8C97239ABAA17EACAA77DF6DF2F7A21120
      0EA8C20283024231CBDA5FD8AC23C9A4AF7CE462C5A3FA87B91CF0198BB51FF0
      0509DC0D5E6FF7462552BFC07093572385A00D94F065714699B4905664875016
      DF08A6AFD641DD7FDA93ECC657492A00F66EA460443E8CFE7BED075328D32F1C
      A4E3873FBE0433373D690DE510BC591E5E2588878B21A953588D54CA9A8001E2
      7A710576F3628EA01B3BC0543C36645332B1CB9ABFB1FC3C96720D47F834FAA2
      CFD18318A9AA9CC9B9D8B3B6F51F1EFAD21033FFD0073636FAFD071F257C77D5
      10D61EBC6BF970C26F6343B2FC516A0F75EBCFC5320B1EF4A18BA862FA431FA9
      56D153071EA7E3567FAF56F0CD50DA660EE007EF814EFB381B7D5A5EE7773FF5
      3E9DF273F7103B6B2F8EE7E7160FD0949EC304784502E69334DA2EE955868005
      81928970F9E6020FBA49586514DC42280909771AED6015246BFEC8198DF4F247
      08AD0F405FDB732F905CF8E5FCB7173D31BCB8E7EACF6CF6BEAD3EB53415583A
      11CB56796C7A3D76ECAEDD5BF70904DFA5A081D4D647FFCB079F43CD0E8A81C2
      D38397A8BF3C8D508A955F4B8985E55A48110A1A6B1A81C52925A29EED9AE259
      301D5D4B92A118A0FD1C4F3E517717570DB04A227A0180FDE22A0CF89977B06E
      16E000718C2429C24274528AB6587ABBF26BE62158CE885EBC5D03492F050D2E
      E5E39ECA9FF4BFBEFD6ECBADC31B1A7D624E15780B559EE15C2B294BF94D958D
      6A7AA3376EDD148DF19618C4524C4072A515528AE1BAE955098C84B43A4D6FFC
      9D5B77FBD4635C71DBE7BED9F76EDD68D8751E590299E76843A64BE1E2749431
      C10C543D3044F30A511315EEFDE5E1FA5B1127581FCDB717E564FDAD0758351C
      D6DBD7102919275560A2A98028077121F2C22C85A89F2CF4DD9620A76FDEF4C6
      585EEC18569607B0ACD1736039289ECD8109006A11690D4FD357A5FF90FC2BC8
      2C624719393F8394C766D3A17D7BE75579295D955ACA52C0452C754EB9C28AF0
      090D3271CE48B248CAC50A58FE578C059BC353C555C16F82B599CDF9C8D8F245
      6D7736BD1936847FD74368D64DD09C669716312DB4F169EEB5E97DDEE2DDDBF0
      09DB53EAD591A702C966D9180C23D50E788E07C426ACCDDB8BC25D6779F20F1C
      D1536D0401C07984731D495A1E1EC3AC2CB3199523B1D86E1BDEFEFB976E9D36
      53A96A3187844C8661CE38967D48575A9B9E9209351D21C70D5C42D3DB63CB75
      907F426BAEE2CFC3A47DA169BE46D7EFFA538EA13DF598D6708468C463B111BC
      0BA981D8261925F9683143CD64C4B4BE813935A36CACEFE21A3DEBD8243ADCE0
      6AC63F568D95B2ACD26096E4A094719DCA8DE984CC74E2C2757D3A55C7AF4C34
      54FE6D761877058D42266355ABC2E88FA3F46A8184786016B4C1EE0679E06CE2
      FA72B2885A1DE3D2FEB08836FAC3E89503C4032C21CF39A4F797876FAB630CFE
      D85497DB580FB942B105919B44D86AA34F01003799F84F49D736AB07C998D77D
      CE71E6F1C4F9A627361E32CB3D8B6799D094DD07A568795F7546B5C45BBD37CA
      34619DCF639631913CB31E65E4A16875A4335904DE108F687D57C0AE525659A4
      FA97671D744A7C26DBEE83546A551EDF084AE3B773C5E086948DB27BACE0B7C4
      CD2065296FF4C851756395B486DEEB9B9730B517DCF5928F4B17D3A9E986CEE7
      9EA84C9CF467352A3EEB1B707E79D8B8D906568651FFD50F2DD232996ACECA72
      88441CD28D5F4E61B51DE22F87675BBFB943102524A97B777CB64BC9BB3C7BE6
      FB3C6431D95A7C17C0250016185E4E915955217154C5D7BB134C68630B0199FB
      1E80395D29B3EC3DCEE1D323A15299818AA353BD6B1F9BDECF99F3AC83169AA2
      60D404961013EA4B4CD29954B9A76BF5A23C5A16C1A49D53B815ED2E503F77C3
      69B4D425D776AC0CD751E8F51395A48E95A8673D97F6CC1FBFCEF272B4402990
      412C6117524CB6EE6C290068EFA281B96E2BA5D4E71CD645948EB399DBF950DF
      F93741DDE25967FBF26CAF3AF6EAEB334BDDC724FDEE596F27D39B80D157547A
      3A358919221C2A2C73BD27DB0799498ADCB04204BD788D6ADC3CEB707F3CBA3C
      39285C57CDCA390911DD8F476C43000EC3494A1E74D60838C999FBEEE2FDB9B1
      EAAABBA819F26C388D67CF3BC23B840AFE1D56528186A63490A232087FF433FE
      AC23DA5515C01F8169505283C2ED698735347771A8308CDC186553E89C72758B
      751A2D8A52085F664DFDD07BC665281B0ACD4AB2EACBFE6246085DEA5571E17D
      28F366C088EB9B3656D0A6B68F86D0F4117F41CB144C2BA3BA49A0A9C6434D81
      29F052501704A1823488331C1720F3B30EAB9EEDD09C2AC1B7885AA086781DE4
      E1C08E038C1B0549D4BD137C4A365DA6CB686BB843C69CB39FBC38648DBCA26A
      16E7E45514A0F21CE4A6D48C3C7B7158F5664D5398E99F73C037C3B3C9A4884B
      E415F7B269B1072119E5AF13105BCE9259A5946A7DF3A2DB803CC02D67FD3947
      B548051020AD3918D0E7685AD131CA264D52FF396A59A28D86CB8ED8EF4972B5
      30AD86CD57D77229DDF1CF39D420270879E9A274DD3FE1DF0AA6329688620D13
      27503FDF75358E7D97F32C1B2B6DE2F3FA56CC18F458A0E53FE055EDA16C8D21
      5BC9363C08B881825446D7643AB90042E204291C413E94108000AF6CF9082E91
      D7FDD7FD377FF8C31FD69ED9D325D2010487F012561C2CF4C70323205B30F81E
      2EAF012E2EC1CC683C015C0924E6554BB4612254335828EAD8E02A5190226F41
      301B8F3E01A55345BC2B6ECB3D0F3E05307F4433297C3CEBDC0C0607DE3EFACC
      8E8AA2CA0658DDA7BA59F3FAF9F23058FBECD6D6F32ECD0F065DACA0C3E6EC3D
      EB8DC43573235BF5D9C4ED4737C845E5E37E5CCC343B5CB82DC9AA78181D5C28
      39F87F5FA0AEC42B3CEBD056E8819912584D7AB44204E2A58CA0ADA11F5FCE56
      602B5729C91580D9D61E812186A4A3D164E8A4C8A1453EC330C931CD8CA4A4F4
      FAEC7344A684E658B27CC3F81A27B73E09ED4F9B83F99E7157DD28CC8B5BA67A
      69FA92DA494CAD5354BF9FD54528F3A9FB463C058C9141AC522CADD8B1A2B76A
      192C0A658690740DC408BF54CE1A7ED4A4A8D37F459A41DAC925330817E1E63A
      46AB73481F7B07B9A8331DA22F97DC1F76DA2AC310EBDD3500E2F39A042CDBF5
      8A5D7889A77645C742D0DF547D8D6862A5321632277F68F8D17B890D7B4C6BFC
      0996DDF31609044886790EA17DBD950BDD04FC0CC0513DDB5DA9638167FE6B8C
      492DF11F3265F8AE365FE72332827226CF3B9630A5D1F3AF32746B741AB44B44
      8AF0CCFC3105237E41E107DA3013BCB98934934A9A014881D7C2B3A01F177309
      C32A60A6F44D35BDD52B2DA6DB7E6439AF44147E30406BF19CC81FE5C022B333
      12BC79C264D3F326A1F3A8B8562AF1110A19B22C505D55EE15F1EB589991F7D0
      93F884063672A04A65B742845040D07EA2FB696058616E0282D737662816A1D2
      6EF072E2C93FBC0A4DD0352607AB221E2219F4B34EC31DB51C23C5F8273C4701
      9D40C9E0919A2492BCE40164F86EDE387306D63518D23E2DABBA04ED72848D79
      6EB8A6EB0C85DC734D30A90B938DE339DE4199476931BD7BF56288CB2EA19ADE
      68138638D3224AA44EC6EBFEABFEABBF341AA06000C7BEC602606C368647CC0C
      CC97C181A7816B717DDF0178B9BF53B50EB7B9206805A51BB0EA441682AFD73D
      7778FA418EAC60F88D6EA6DD5DAFFAAFFA2F1B5DE0CB1B80319741684FFDB6B4
      EAB945CAAD4EFD0AB6BBD158E3D2DA97D6E8E215E0BCCD55B035158BB4FAFBDF
      BDC2F7BF7B157E1F4A32C5B508188E0D290323C5FC052B205E78AADFE8B28770
      AA0F06E7DE7E6B776E3CBA4E8D7F4E90930CDF0F064B84024F7D7C29CEBD4371
      0E67D3D1E9E199B4FF36BA1A89AA824657D836CDA69B70A8DBDB2316A6D1F5F1
      DD8AD1455E7BA3E945460557B3D995D842D625D340FBC77B3D77C6BA154ED3E0
      2F07839366334DF6254EB7D9ACF3838B9F9ABEB5D71B87A71F7E133E8F8726E2
      912B1DA494858E0C6E2BA54F14AF70F8689D3C903D68B6C904445AC6798EE3EE
      06FC3BAE88AF242A86D5CBC6636D436C76837D45508F6FD368968CDC4813A193
      249E8EADFD554B5D06FE8F4401048CA4E5E8BAEF3EE268430EA35C27BDC02C43
      DA92E59FDAC59289FB479C674A8C4C3C475440BF518410847B5DD9620890F5F1
      BFA940C96D03D67A239680D78C331E715342A2C43867F11927AE6FE2451A4FC7
      44FD89783AD17C837E9ACA54E912ECF9A953B93BD8011DCBE797FD6F1B1BD475
      8A638454AF94168C24BB6E582049367E8A1DC41741E43246EBFCC82B56587189
      79746616E0B8C997FB82A5BD8ED0AB2CD58D683A12B9164DFB9CEC7F2B3EE9E5
      610688F43419A2FADF6FEDA96C36F3547E190C0E64FFEF71092281375D0CBD14
      5E1786460DD25A0FDB0210CFC0DE61A398C14A52F7C7FE6834E25435B5472483
      FBCD75843C5330E0C2D95D74CC759086A996564AAFB5534E816990DA538BE3EA
      F06C2B685B6FE63C7CBACD9399FB70215C78282C2ECA2DFCACAF63DB4BA914E4
      CDFB7081F7DF8FBFB099E2F06CABFA05C5003450110779BD8C8B6F3FE7F8FDFA
      24DBFA9C0712210D0DA8D2606FC3FCBC5D1F275760C9B98EBF4490B602B59616
      92B51180EA35D9E744A87E5D6717C7B0E2DE3D2F9EF58A74C4B42977AF5EC83A
      04AB5C38B1CE8D86CF8C4D0D4FECDD1A61C9268F62324BA651CE16D99E71CF30
      CF269DC35AB2646EA4223AA7CF9F2EB50A3D755C9D0B2A22186F0B1837976F6B
      8CA5FC3D1330F308BD9AD2AA32936EC5E06888D28643B172BB3993ABC7E2FBC0
      C76EF756C8EC25ABF539A0BF0D588D356E11FABFDB79B3CD827C85F0E7FD7330
      38583B89E62740ECE764D6E6BBABFEF8D7455C949700E6F18FC94428F5D0EC8E
      040481EB52BF55AA068928A536CFEE68E1B5C6ACC2F2CAA71A0D5BFB50C72B68
      541B5D0FF10B924A207B320AA831D7E54C330ECDAE4B4EF680DAB4F2BA76CE8F
      784A564D307F2FC08A9F2693A2879EA3384FA269D173D30C09BEE972AFD0D71F
      6ECD8FB6DFCCA60E846687668642596250DB5C7870D0D6DEEBC12176DE6DB51A
      D403EB4AC0A824F8B02EBE7FD7A5D672A56CF65FFFBBAD95677CC5D2EE649E19
      C5A634D5C530C3F2DD72D8FBF6A82748233CF938186833DC938FA47FA9896CB2
      3E1ADA92FF86DDC550DC7BA5E15BBE9A0A79FF2C465CD1D2EB3D64D4EB718632
      708184C5110FB8E3B3FD56B792E7C0FFF559A2CF59322E547D4E802D791C17BC
      11A96716E8FD87ABAF5E1E7A1394B21BDC47CC8DEBDED4D8D6D424092417A218
      80C8A457AA8266E0486FBD649A46567ECA7798153FDF3DD86953397D6EC781ED
      95807792797E362F6F9566A0594A56DF352E680B6977B0D3AEC5C62E1A3CBAA2
      1790508F51DE89509C90C2C5344AC7C5289AC758588DEE7778FAC1962CB9C85F
      CB4FAD57D0CB662B48A821DA9FAF92E8D2CE9E691C7D6A7399806704795906FD
      FB473BC72D2E495E30F3BCA9B4D1D48646E3CF28570582386E1253DDB359E638
      8FAEFE0F9A25451A550B074CDF2C17E33B358B1DE8DEB1A6DB6C72320A7B187D
      AB30435630D996AE56FBFC69752DD2D068B2010E139554C40D910F6C77CAB828
      FBF308F3A4E6DA9F3A4868B06888786DEB9F0CDA0ECF5EFFF3F0F4C39A726AC5
      5F9ABD40ED762A8A6C94304B6989498CED8F7D2444E651D1937F6EE93F27D9EB
      3949E6C7F821FD8C1FD09C43FDC96653C57CD949367667F95504B980DC753741
      D150BA576B38B584A33B24049604EB2AD7CDADCF32FDCAF67FE83F30877F6EB6
      CA04D0BF4E3C1A0007A62350D89B227708330A8D97C9FAD976307EA64904649E
      2DCA39483E08CEE2D6C11A50236C0E0320A33388C2C858250D89E64074D1B9CE
      FAD976BFFFEBAF27D9D8CFEEAFBFCEB271F1EBAF96431C23170F46D2E3B3FD4E
      CBD35CB65F3475D78951E65BAFFE589AF535F1D2F03EB887C04271AC9105238F
      2784685D5E1C1CA87F7F7CB6EF5DA3654107CBFFB74013DC71E27A64375E76FA
      D7FFACE5A8F53FABD851D9FCF4D57B7E8CA379966EECE4B32CDFD899CD162A99
      54CCE15714D7717C5F51F469D7DF3DDBBFDCD83DDB7F256D971E91447FC817EC
      25E1EC9593B103C9D2243C9FAAC7412E1B9ABC3603F2B286FB67BBFFB95A19FA
      2BAF78B1025524D2BF157AEF6EE2EDEB3D9B97FDD74DE32936A5BCF97EFB1E62
      E3A5EA5640692DA038B8F92E9AE153F878D869EB6BDC458B916D6E7DBF5DA990
      8F63243BA04A24C692D65A67975ADB685E6E75BB37AFB603CC729EF9C66091A1
      864C85E187BA8185B436D0AC4AB6C2F035C3C55F67E5A7F8B60813E155365B53
      E25D768B005D2534863DC469F368ECBE31894F6ABCACDB4F6996C63DF74734B1
      C679D9745CD3B11B5C271380D630F3D610ACEB10C7C9A7644E205946D4950E56
      6484BBD8B28B0265C9A25C806B9EAD50FC6AB628A1BA8325849485546BE3E213
      54FDA23C8E9E69C05E4BF8ECA70767974567E4F18164C63319AFD15D75D24ABE
      AD0D1227FE42B5C67BAF6F2365C538D48C6F552F93EF2AC7187B07E0F980E74E
      63806C627C4448ADA48B59A5D38A289FF067B609357B3F804B7FB3272C47AADC
      0ED179613A1505E939D9667AEEA01809C9A7B01C8AD02F5F5673288AA68DB4FC
      5F97EEA2A11B2F4660379E16065A41595A600246C24607A839125F2B1BE29C93
      25D50BDA8EE359E65E08A67AF5C7E0C6BF78CEE823A82F14DB38FF05E1C282A0
      45185DBEB48F6BBD8041CDEDE6D94D015F7A675A7E73F8BAD96AF04F17F0B80D
      B3EC13F89F74FB698CB72D2B67B3DFFFD67CD8C87FB4E73008FBDB554662D386
      852D9FE4401B9D0719B0C33FB152754422EF9E7B91A52F821DF14C29BBEE302E
      23F3867A24E3B003862756C323466F64315F041F0F254BD05050A1BD2B08D262
      0ACC896400D77A6E2EFD62BA636ED1426BA5298AEE009BF20CFED28ADDD9FD78
      09451878663DC29A7A4A4B16CD6FF345C177D373EFE2F200F060A23F3C8672AD
      5725AE4EA3CF274CA9422F9E74F665E6FE9EA537E3EF5ACDA4A41639A4AE8DC9
      84B4700B440C02DA3CFE70FCCE75AFA6D9309AF24FC71F8E4F49A44ED0DE0BCA
      B6823A5A6AF37B3F09EB3CD85524B1A14957ED59B8350F404277E32DB89370FD
      9AE7D9B2E7F9F9E2DD3EE8C7CD53CD9CC8F310082827430B741942398458613B
      C0F9F1FEABE08E49EACE77F67EA2484992222FB8D6229ADB3DBFDC0FC4592C51
      34CCC6B784A3576497BBE797A764D66E71B78B188443788D649DC4FBA2E59056
      D02581DB36409DC1D686A2073532E66D42A3757638B80C556FBB3CC45E0C487F
      6356F585F903306D93C95AFB98A461C23E2EE68AF15210AB8A522B763D2E666D
      3CFCD76FB601342D4AF03D014D3F01C78F72B39A5EFBD894FC8437EA7E55FBAF
      BDF977DB8ACD9744BF5FE92A94449145A16339BA3C61E3AEA9958785A23466FB
      8A763DB6C8F8AA3255EADE5239929BACF87D81687B9847A34F717977601A8D5D
      25D2BEE8C522AC2A4D1047D173493FEEBB5FFEF779520ECA6CFE5B730F717F38
      F51D75351C938482A6A9417F8A5CED41AF56482A42D0AA405E9AAD209A3D0FA2
      A9E8B39198F0CE40C0FAA8CCBDCD8E44146D6417E06DD816406310E4366640A5
      4A88555E9B7E3B0C96C40BB00772DC689B4DF5058613D6014567F7395DC81E74
      25555F73C99FDC290A2CA7599446579082D79F87E63BF25D37751EF51896BDF5
      F3DEFFBD705D70BF49F2E21F88E57C44F597B5FA018323ADFD3DCF4F8E066DAA
      8ADE231325A16C089D79210F88A7819DD8762767FBBB3D777236D8EFB9C377EF
      76F8FF01FE7F3968736BEB173CDEBB3CAD1D16AA9653EDF4F7839FCED51AB77A
      5B7ECF68829B411758A9D1069750D99C377747A22889F5DDEA8662F48252BB21
      B1E964B47F7B2FF6C5F97FA128F6EB9889DAC024BC587FB5B9F5DDD6DBD76FB6
      DEF65FE2BF1724BB643B9BEFDAA23CA56C6DB9103CC034733FEF1D7FACD6C273
      78FE1DF80ABFFE2AB85EA1F42C3C2FDAB2C3FFACBE7E08AFAF8942F05537EF2A
      5207D6567360B3C3454D41C72F2D8A827A1B5951E7EF2E2E02A312506C20CB14
      95D75739801702C664176AFB7BAE58C527EF0E0E397B3069B27C7E3E3EDB7B86
      15E3EFDA792FDD5A160BFF3C38D8EFB89B286FEC8854051DB98384B5F5073B3D
      DFFB5B6F4558D816ADFFB2FFBA212440A12479FC79038247A13894AC810588E3
      FA907AAFC97F0412BE1EA42CBA827324D37354479B75660C2AA1DC3CFE7D413D
      0F4D93B3688AF12EE63720C668F1C4912B6204D6F79544031966AB86BDA000AE
      E4EA191161629A7B833BC1C4215F072A0CC950493EB0D9A53BFF897E5000EA2C
      08B2FA0C6899A5C230CFE68BF90A81EAA77753C11BDC303D07145CC099510469
      DC66173E86EE1D0BD7D21F7C93276509F04CE95E9FEC366CFD234719109360A3
      8EBF8C6243D89346455B9C4D5A58E84DCF2D802A33137826774819CDE6EC649A
      F138144187C982B41225C20C6146618F36767FBF555911221AECFE3690B8D763
      52BD11BA1215D4B5EF9406091D457B3F31F1EC357E67FD678BCA1F486E55FA0C
      88FAE8B6C251BE55C0C9C3521BBED375BB6D8BAB3820FD9697A9A794BB15603F
      8FAF1668E188BF98D460B1D6FC66619CD1BD3C06ED613C865DEFB94B115D498A
      7237FBD2F01632AB3E0521CC05CAA6E12B7412B3B0C2F4CD21170E2C92987852
      D6511D59D71F12FA0D072380A7B12B6ED332FAE2AE93ABEB29B6128E1C82A0E4
      0E62071F5668875FD56CA180C750F0CD20AD11320911BF239F4DD3857316B0C9
      17CF77D9237123365F7DDB739BAFDEE07FDFE37F6F5D17FF03235807890166BF
      71EFCE23D29D49316A366F7B2869551427C42DCCE651990C136AB773450DB3F2
      DAEDC7D3F975E27E3EA089FAF9E0B5970A04A844257C4478B3C5118E66AF535C
      D01BC42203DB9E5874819E0A47A06A10FA0628F56A1ADE7DF7B68C777075378D
      D3ABF2DAD3A932E479B3E58649B92CADD5C0A37BF57D338F8E171A6569D51937
      BC75B32C9945E9E6CB97EEBA2CE7C5F6C686FF4D7F1C7F4EA21425F0FE289B6D
      4479B9711917DF6213AE1F81A67C7DEBCD77DFBFFAEEEDF76F5AC54914C64E81
      6C909424F5DAD0F23B765D39530AB77371B2D373A71F0647C80CECBFEAA1AA70
      D6D0DAE88D0F48F9A97A30D2F97D85840D8E6A7400C241574A7DB2B33007D5E6
      8687F7C5352CABD81925883C8F086D938D7DB9E5B6C1C783E233891C85170EF9
      6716BC8B9950555F5D6745B946CFC7FB334DED92DCDABD7DEBB6B1DF91E2A109
      F70C4E6C20540AB33229A75E22152056E9F0287C66D175C7A24F8C6667A9D0E4
      F13CCF58B91E2EAED654E70E2DE4CC838AAD13C42378DEBEB4798ACDCDEFDDB6
      2F5A8200E527B810ECCD9EC20FFCF9F8E2B8221D149429F02712088973831166
      452C9F25C8160CFFE318E66618A7C99580C003AA9EA3CB9376A37EE9B61D5D84
      A07CCF242ECBFA92415D924183CE2F04A061253ACBDFEDC040A392226BB4E139
      18F8D78AF434952396F944434CDF9CC48C54F843E0DD6E29BEAA5EE25E344FCA
      0AE2A41139D8F1D1CA89AA0013554135609C50C26F0CDBEDF603ED04458C196B
      BB2B80DB2593F95D55E667756843CF0D2EBDF2CBEB6F79DA02823AC67E994705
      18053AC0697640CD7803D285C63E6980A4308C4E0B6F3A5C53C5BFCAABB3C662
      D48E8DBBD66248A8DD55B2B6703CB0FC106823EE56F6C7403921E47C6CB5435F
      7D8B1DEA3990547F592877518D434E03F5B37637D9A419B823E070115FD1FF14
      F02ED116B4A5453FD0D9F6402D9EC6D3E856050A99EAA9E4833DD9863B25E093
      57AEF0853FEF1D5F9855AB3F9ED601DA3DE0CB8DCD4D9C33D5B06BBC8084C4F9
      B494E48AC26704CDD862EE0206357C58707298131340A398E494B1413BBBFC9D
      DB86AC218B9012D1BC37E4358E00A371F1232C80806A7547983E31BCAEA3D570
      71A93A6E164D6D3BB7B4B09B9B58693B1FC2FC6FADF2CB121E29FEBD03DE7703
      71ABF0E0DA3184DE552D4B63B1605D558D76FA96B05A6FDDFC3A2ADABD8B9758
      371FE800A23C6E648E5CDE30F6242C1F9C3081DE77BBD1E813600DE9B8020F53
      F35CCE08F60C80EADC6AD83A5866BFDA0D134B068C7AB2867F07BD806D28DDC0
      F11734E7B260AE8B6A924724179224B610E6698B0334301F9CF816F9291BF21B
      B7ED28FA5A4F096BAE16A57EA9E68AA6CB0DCABA9FA50DB4EF0E933C164D12C4
      00F092020F01075E3C99207EFE3CBDAD9606FC3EF11BA466D76EF830CD677A40
      087F32E6DCE6B4403F11591EDC8E96F090C73297B4CA23F6DDBE2C0238F93D9B
      69B8AA011BA47F04857E88F7810244BB678003F8214B46B1031745457902B77A
      3E8FA3BCE8BB13195121AB61C57B5F3A837F4AA92088CF6DB7B2DAAFDDB6B2F0
      DEF15195C714A025592E3D9B999A5013C002648321292152509380B54516821D
      037D02E18464AA8201732800E4AEB59B68DA576DE15033A73907C12A685D332A
      8AE40A8D1D8A3B1EB3EDC64623B4BD33AC7F0D322AED2A5353A85DD7D226BA91
      F85354AA1B9A996E99E497FE45491FB3FCD82D1D98C7C5DCAB1C7A2EF9281D5D
      6788736083A8EB4828589637CC3AB3BF1B54BE34AE40BB8CA2D135626ADB76AE
      8BFE40CCC3381E2EAEE0F9AC3D43CAE56DB3940B39D528156CED3EF26A123894
      E8121310781CA5ACF46413819C1A185E7643D56DC03E36D2C44553771A7F59D0
      180DCA389AD10616D79902CBFAAE2B9D5D51F1C9454320FE380C5D37932C5FCC
      5A010DCE1502DA95D4859DF56B1E7348C20E0626B3A418D991651C6E55CE7C3F
      8FAEB27498E5294807DB0CA9833AA56E4677B4DF599568518FA4D16D2E717963
      3AB2E2D9CAF84F957B058FD42C91A9A9D38A963CE897283373E6FFC3BD7DF9B2
      59DFDD5ED5E9EBBBCC201A04234C9140E23CEA1A522DBB31CC01F58DCC5A89D4
      4EB711C4D9D5242A1CFE78E7745FD0D01CD4E9CE87233FEF5D6929A9F792ACF5
      DD591A80D4B55C2B1D75DCCF3DED35106EFCB68FE43BEA5622C56047D8E5F03C
      9C332FFBAFBEFB4B9B1D62C49BE324029574B1188A8424117384A96CF69B497F
      9AD0EDC69898606ADE2ECAC95BA38AE9BBCB8A2B39CCEFF5A4D603A90014DCA5
      8A5F66CC6B0CCA5C7AA7724B71085D0E3DA732435DAC0D2B9BE20986B7BA9B36
      BC978486A8025DB7E338F51D7FED5FDE9BBFB4ED26C5CC4176949A2DAE5BE6D9
      62E8E58C6ABA206BEDF3D4DAF37BB1B377A0492529A00C9339F17BB4B3EAB61C
      F1E4AA8A40399A6696C33F4164EA4958F402D283BB97949C711532C821D8A662
      0D35218F6095F6F7309D25C4ED300941C1B170DDE53DDC1E35FEEADB56EBE068
      36073E96A11DF0EF47E7FB03C3E8CA1B6ADFE6B17F0038BD068F3BC77B3F4A6F
      63671F0CFA8B51C9798243378D8BCE5AEB551DA0550BA24694284F8BD16CA14E
      52AD01ED5C9C9C09060C0BD3EBDD90729AD2BE7B3FC18CD1CB8C5A7529052B86
      F528E5CE67F3811F00E6856B84EF83825E1CB48CA2FDABA06A73F09427822A3C
      A7B9EE1A9A364965696DAD31E260A7A1C5CD800D513BC824202212513FC8FAFD
      D80889F7B0E3C45820ABA6993630BC7B8B6483F303ABB534BAFE3953E1EB4316
      64ABF35AD5FEC8BB120ABC74A416D555ED30DF921A1A0380EE01DF2DB3669BA0
      A33511B957B34BECA4D1F4F61F31305272197838398806A0E4A21D55CD58C285
      08CBBABDA6D955A3CB9C0DA7C9671CFB17901C9BC532BDE7422782E6932BD69E
      B737366E6E6EFA29C21AB496B3E69CE97737F09B8DADCDB76F5E379AA51371D2
      B4B1908175E6B2093064447B62DE3C4175874C13E0D919CA12D8452E1C5EE646
      1E47A36B2C835EB511F3D175CF0DE2DF5968ED992B444FA7E7E272D46FB6360E
      21A22D222994D4D2B3552599C54BDA39BE6C7F1C6D3D8B4F1910351BB184D25E
      ABFC04E9500BE3FF02422D73BB6783014BFF34FCB6C59EA1C44E0915664A0248
      7492BABFBE1F5CB6B93C1BDD04B13E852E160A88CAD5318C51BEF4C15480F469
      7508F034D436DD697C158D6EDDC5E9CE893A48388B7ED039D5E29EFE4510C538
      2C7B6EE704FFFF78B073DEE369DE7327478356B1B6E1B556DFA512DFC648EA27
      16542F27ACC6519EC567CCCDA2B2D48F452AEB66AD45E3E569167288813AAC8D
      4AE532B1E15DC83D91C9D1D53883AABA08569017271E0B698E2AAA9B949F59A3
      FDE3BD6623A2D08E274E06B4D7738589CE6E164294036D3A8ACA8612BC0D59CB
      7CF48BBA5F51E6B7D5D6CF520A9CA8A669A3ABFF08728BBDCB8BE34A5150CCA1
      9614803AC3944F2A43D9DE18366575956DA14B5D62692B43628C729486277352
      4A83C87D55ED470ED563581FD98045CF1D61927BA0939D4E9B9DF5A7E77BDBF5
      CBF4A8EB87F3AD2C7AEE1062AFF766491EB9F845348AB7DD8F510296CD83DBB8
      DD50F71EA1DD796C30B164219A7D9BAA7F00DE36FBFA4F66A3B374DB9178AAA7
      34543DB7339B653DBC88E62B10F60978ECDFDC471EBD718E2808FBE5FDFE85CA
      D018B17D644D2D5E528C0CA9AC46073402FDE7700EEE1289369305DA3DDFBF24
      B2D55211504FB38493B4CFA9E165AE9B402BE1D9E0B37906AE69844C097A6ABB
      55D82C57A35979A00FEFF17DF4A2706562848AF5CBE3F7C2F2D4C86578E4DE70
      6E7C5F611D6D510D81776F7EF9A2E4B4DD7D34FEA1C5D58F1E24B0D84F3E8363
      29CBDBE5B5A2517CF8B39B5F67693CF322D0EA91CAE1ACB166905BE83F4B266D
      A9DF8BD78713CC49EDCA10A41316CB5BDA33E4E8C0477F90CF55E8087DC9D2B9
      BE906D4CDD2D101A4346A01D32960A2D4A7FB51EB3AB672C7570E0857E5F103D
      3338F8ABF8195DA4FEA825294D4BE6D8687337D211A3E5168FAF4F7AC9EAA8D3
      5F3715FD8217B7F7E38EA51338E796C590B2E2753405885B5423D491DDC77978
      92A5F12D7CB636F756A0CF589C5275527BF2EA23C1FF6A41BCB66AC2F6FC86B0
      BB2CE8CAE2B53B78799FB0976F5042C64F82BD49D2AB4EC32E36F5489907436B
      1E73AD48D807BD6774B95A35B449B246D546B1534C1A5ED22040A4B1C5292AD5
      C193A7166A29A44E31E93A0B786CF6EC80386DB8284B19A47E5686D963695D12
      DD52B3D5F23BA1D45FC00F27757A28A3F7A4927BE7667AF85214246F8C7FD387
      0EEA67766EB75A1D03C15854841359DDAD40BFD7D66F98CBBF4DB32B46F48B79
      460465434CB0D8C75902D0A5A7EAE0CB12A620F618690023B18BD51AF22AE8F0
      B3CB435F50CD1E352ED5715C1BAF8997661185B93C3649A763B91E6ED3732089
      C5672AB2D317A08ACE3C75AC1C1A15132AB9887935EB50EC5AC64BD4912E0F06
      1FE45F71397A0E304243264CD39C90946073D86ED02AC970EF5E8DC747AEE5E9
      6D91E206611075698B18BDB6252AC140AF64CB8A655FD151262DCB5E8D915C1D
      246A5455A019D5F85A98A0AA4E26D1A9C20669F7A467CE985D1A1E163BD3E96F
      EE637E1BA3A7E95ADA34105F2A3EA4FB47C82AF7B57BC3F33DDEA17B6C7AF7E3
      E3DFDCE1F1E092B514A1661411CB9A57D9E6EA07FB60BE20A4AFA87008DE0D6E
      E533848958ED1CECD90C4D83BF55356BF9A8C0126D71061ABFAD46B33EDDB6A8
      A3DE5A5E51838CD82662C885DA985AF4C405C52CD8F6845D173A0DE2A1D1B909
      D2B41BC8E532954B13AF6924E5F10A893ADBB84012F59E64E39F92D21D9D9CED
      9B2F16B2DB1BE35285256E73CB65EAB57029078534E83446574D7BB47D042E18
      51098B42F05F45C9D5B839E9173B602CC0C86E900EB926352D9F4D12F160D73B
      383E6E7D93419ADDDCBA1BA5CB0C339EC997304ADBC9CBEB5996E5CF70C86D7E
      FFFCF2396CDAC781454F9E8E3CA0121A86B71F72437C874A369D7EE060909105
      CBA702CB0D50914C2AF19AB131EC91826018ABF469C3C2BF80F245C35E5B1E33
      D1292D1D6AA58AB86E059DEB20EB8FB722B5ABA2E32148D7E433ABF6A1A093F9
      B871192553691914E4226CF85D09B446AFAA2104634CBC8DF2D2C3A5A898BB55
      DA5632691CB4B49F80A299506724B2FFBE98CDB5CC18D98C3ECF4BE3C4B24B35
      CE3FD92B43EC8ABB1DA47093CFB3246D8687105336A029230092C6597EFB8DFE
      FE1CF73D90FB12738E90125083C811E243020C1EAD40BA5A1AC957D5A9318646
      70AB6030DBD068B4089F6B2F09F91230FADF86F5113C85D0DAC5300D38E08464
      25BA8A1A76F95A33E1BAA83CEAF5D0EF6028FF116CBF744F658042A237962381
      37C0DD0C5953E9459CA231945C78C07208905899A385A61D3D3182966CB8F34F
      88AE921C2D4720BFB850A815769A64FAF44806E4ECA3E48CB70DB6177F99C779
      02805C34ED9979154DCB68993CED6B77EAABFEB74D55F6D82FA8BAD4ABB024A3
      3897CEFF7B1C8B26436D48068A7EB0C3E4CBB68813710B63A30A87429E148297
      A43404F2139DC9E21FFFB8ED68DB33B26E795CC05F34D1F2A5CB189124BB7FE5
      92B0ED0881E3DFD1718D5AB90329EC155718B4B9E40DAA4D639B93854CD168B4
      C85183CE26B6CFBA5B6E785BC66BCB37964E87BEDB95809A990F8000917F075E
      DAD2AFFC1A1BD34B3B0ED0BCA1A39321CB61C8DFB47F4F4B8458C5F0F5CB3B97
      782597E85C80131E51A47649D357EEF7FB9D879A2A50A0C23615DD5EF1B2A5AE
      400ACBCFC99538F5D0A6E349B1FE6777DF8D1EBACFCAEFC8442B681CA6D6FE58
      B18BBB618CD356795739F192C795661560F76FE9A5E6502CA8BADB5157F10447
      267E21DDD3768D35E4C8F813971213C8D6CC2DB4597066B8341E7C34EBE9571A
      25CDBAD142524C1930F259365E207CE1ED98C09B46E4BD53D221EB755880D943
      38A6A9327FA37D17D1F4064420CA86810651A9DE5AAB4637EE5FF5958DE1F0EC
      F5B9E011FA101E96761ED22F41C2E5739C4F239150B0D9D6A0A92A39E9689917
      E4B6A5F47BB1602E29629390D72494CBB3838F0A2512168797C7C18A5BE01A72
      DA48CF419CE3B53E38B51F772E4E8F4EDF6D572E03061AAC92B0255A462D6B8A
      03D6342A535F28B009CF0BDA6CD3B16637F338FA244B48DA3FE4127C4855544C
      0AFB2D5C5C6DCB5508B1D06AA5B72A23132D4F1D78193DFD96F0844FA7C61ECB
      12C8E1D96B11E39265C7065E4EBAEC09DF3D51D4D72A078F6B55AD633077590E
      F76D7AFBE09C0A7542ADD1076F88AE39E62841AEDF9FE19D699463738EC7CC38
      473711A4B7019C0C66317696A104147E01EA36B7F56E5749261682E81439C2C8
      BDD91A2665252934711F99F7697DA8BDEEBF74073F9F1F5C1C9D1C9C5EEE1C37
      3BE1E4712B0AB002CE8BEAFAB264B514A9F5F44853BCED0CAB812431726C0486
      4C5BDC00A718C76929D605C447F223980FCA4C575887934BA901343D5EA5C924
      1961795106C37359662817834F78591643CD49C08DC11E57A8C72B8ABC599C9D
      A999A27B9806EF305B9461F5DCDB9459569406245194B37A03B3384A037BC885
      54C4EA6316385D6FB092C2B8D27F789C8C9170E71F6E9910A77E5D1749529139
      ADB2DAC5ACE7F60655959259243DBBCDD5E62EA2F24A54C66B24C74B82066991
      6491258EA1DB1C6A2959505BB69345E02FCD046C873E6BA363B4EBD2B08717FF
      FBA2E0BE2E8C994A2AA7851C724589A9F914C773997B5CB758ABDD1BA58EE0E6
      D709D667787BDEFDB2367685AD4B38B1CE8F9FBFBBD89773398EF229E09BD6FF
      D038FFEE6F6718BA043E779426429FD4ECC2BB8B2B247318AC888FA611FAE81A
      6DC4EA5B487B7255F41743DAAC9BEE3A5E4D7EE01F4F97AF58F1738439B9DBD9
      FBF1C2FD425AE1979B5BBFE16508E924704A187565640771697F1B30EB5F66EE
      6CCEFDCC0A807C41ED6E11977DF72E1157580F0E4656B94F51A0A8CD24E862AE
      F350F53085CEAB0FF654F08167946740C2C179035D999E38DEC9A472BA035998
      A0DBCFB881AC0C2F250C46D67EAB817501319B3A63B13FA3FBFFCA77C34D87B8
      C23FB2A837E14F4C04D076D983F4644F4E934F523D3391D31747A1AD9610F485
      27A9F077444774F3A7A92A22BAAC316CE4DD6E8A5A52475ACC5D8C84891EE8F2
      A8A61DC7B0DBB3DA46A57D741C078CADCAB58599A3A493BA82BC31743E2496AA
      2ACDD711621E00B6E0102C5754BEFED87ED5346C7E07B76E60E5D4EEBB93C1E5
      9AF5D4DF48DDDA2F6ED298A33F05F5844CAAB6E89E132206B10C0D3BB53429A2
      6B59E96A02A80693BCCA0A02AF410EFDC81D52DE975F6E3F85CB61E28A00C50E
      6B8D85584F98457FD78E205BBA113A7935FE08BCA0212D2E2264CDC024C58A5E
      C876CFD158855E0006161C4C921CA729B5E27C849E666532920662514B6D79A3
      C8BD82A5ABDF84F9B2684A9707BD9E11B0B38D4FCEAAD1392AE32B905F747E94
      26CFE12D4573A9E4DC31ECB610A30A84836BBC190700397114873EBCADB838B2
      DC91A55266182ED4555C0687ABA9ED86ECFA5597453BC0F63CCA19D7F21C2CAF
      DD3BD0B737DCAC50D0CA26C8F1034694763C311A58EE71B82AE7852484499AAC
      B29A8DF58706CBE6BCCB2E1EA2C1319388204CD009CDBC3D38815A35E9B97E7F
      4D33D3A3305343D7A133F066BCD3F33F9D66692CF143E788FA92D5089A89FC2A
      E1179890259521F9562BEC58363C9B4C12743CB7925E14D76E3BD86A22227393
      67086C0DA3048E885AC76E054B95032B4193389D2C73B8239BE6AEB02D72F46B
      AA76CB70C21856237FB5468F4061461482CB1B88CAFB4828464C9F1433DDB192
      37098004A3297EE59DFFE6FBD7CB166ADF44186A747C7B98D28A055CA61DEACC
      15EEF705C9E6C000CB144BD5595A695ED3F6ADF5DD8E52ACE13CB02402A9B0A4
      2F86F534CF103676BBB79D5AF794B9174113605D411E9FF68315D4B34FD6B4AA
      B2C3829AF6574EC2FF29424C45394BAEC212EFA3241F2D6630E860396B5D8CD3
      9693C8E5198F3F9269325549D5559F69A52F83920FE0EF22856ABEFB8D846DB4
      07CC769B2B21B824A61D05B1012AA7BE1B643E9507CB164745C2A33BF28A40B0
      F0106D6CA8988A4405B2F057EEE8C56756C8AE3261BD279FCB0FED8A2B9B4DEB
      15751F112F5AAA3EE3201B9336542D3D346F9F1544D8917384DA4CBE78B644B9
      A931045B21ADA15BE04FFDC27569858D2C2742970034E01B1E50E64307C99BBB
      2791981521DE9514E686D4C999C88C5CBF8C8B2D2C5C0F7164A2DE07B9A4CD86
      FC8A570F82235C314349D765574F13C33E21489BA33646BF5DAB911E90D4EC81
      CFCD20E64CB24AD374507853C62E52F2DA1328C4B9F2F6AEB2F4E9B5FDFFCA16
      A424E3EAE64F3B79ECF6815B7EC871FFAF6C81DDC47DCAE6F8EB6C1ADB0E8193
      B89F8D1648BDF7DD3BE4B7FEE07ECCE628424CC1D37537C9760F74FA510E584D
      774B8544B6A454C7DDFA111E0B233A9AF171AA7457CF57D2580F54141E3BD011
      51F32A5AA1F5100BBCD7458AFC15263FBE315E134FC79B8EFDBEF396F8FFFDCF
      FFF1FF01844E7EFD}
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
