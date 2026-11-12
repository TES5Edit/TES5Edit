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
      326321D180E5DED3382692AA046A5454D2F52244EF73CE6FBFF1ACB5B2AA40B2
      2C1752F7D911BBC792A0322B5FD6EBB39EF5DFE3389D1E8D759404F41F6F393B
      3A7E733CF6CD747AF8DFE3A98DD27412FEF7787A389E26AB2049C6536FAEE3C4
      A4876A6866D6A84FDDF7FFEB7FFDDFFFD778A9637F9C4C5EFD78384EF4D14F87
      FF3D9EF0B75EFD38CEC274AE06E6F7CC24A99ADA58F5ACAF9A593AB771A2B224
      8866EAB6E307E9FFC253F267F153E819C7AF5577AAD63653C95CC706FF8AD5C2
      FA89B291BA30B7598247264A47BECA12C34F533A515A2DF4BF6DAC3CBB58DAC8
      44A90A22E59B1B13DAE5C244694D2D43A313A33C1B25816F62E5DB48A7989156
      C94287A18C6869F858B5E9CF36527D1B4469A2F6DAFD7D955AD509174194A426
      6E7EC28F49B65CDA3855E9DC281BCD2C1E581A168F4BE741A2526BC303359A1B
      151BCF2E1626F28D2F73B0910A12F5BF8F0EFF9F83871686DF35489417675EA0
      430C8F99D2BC7DAC928FD1F1F42C0AD2352D12BD8B67A3340E26190D55579155
      0B9DA626A65927C11F46D5F1DC20BAD161A627A1A1AFFAC62CC3B5D2CB656CBC
      40A7C6DF9ADE0367E0F35CA72F13756156D8079EF9EB83A38337F17F6E3FE3F0
      CE338EF919A3F3F7EDC1430BD29CD82C5547B5E33787F4D6419AA824883CC343
      FDCEEBDD33F1CCF8AAAF536F8EB78CCD240B423934E93C36A6BED26BB5C0C76A
      AA151B9D1AD53661AAE53B580B7A880AA2D4AA9EC6EEABC8AE546CB3C8AFA771
      B0ACA9958D435F254BEDE10C4D1393AA144B99289CAA551CA4A989708A137D63
      6AAA67E3D8AE82C857331D4489BA68F63A2A0CA26B3EDB033335B1893CE3AB93
      758D7E35CF223F36B80953E5C53A999BA4A67C9DEA7A6893442D753AE7EF2E74
      38B5F1C2F8751D7BF3E0C6A8A90EC22C96A94C835BE31FA84F916FE2C8E8745E
      A36360A25910199C8DD04633DC0FB334115F3CFC3D4B4C8C0530F1945E31C61F
      6C64D42CB4131DAA995E189E28EF3616D94FD42A48E758CDE53C5047AFB60FD0
      F1EBEDCD3FFE8937FFA359AB79309B87C16C9E261B5F9B06751CBC30C07FD3DB
      573F968EC4789285A149C7A99E6C6E7C5D19DC0159036C1E6DB85F3A019A7622
      55467B73B50CB35910BD4C945D456A415B5E5389555AFEA26C14AE956733C886
      D5DCC44641107969A643FC61AE233C3DB10B93CE836856E90D1E7D18EB4A2B9F
      3EB5A44F4D4CBA322652E9CAAA1B1327818DE8DC6848892C3435F7F613ED5DF3
      93B0C7D3204ED21AADCE2CB83109CB07E3D9C8AF34FFCFC59D48545DDDE830F0
      D5E5E970245783CF4BEB7CF84F1CA6531D86B8D0AFE9B7A1A625BFE7F2A8C95A
      F966AAB330AD762EF2AB57E76B17BBCBC687836E616DF30AE27A5FBBF9CE8D77
      4DDAAD13C7506CD7915D25C5635F262AF04D944204C71924C05E316490A8240D
      C250DD0466C58728C00523C1441A6ABFD24B0DF50D843F0E026E3B8E1E96AAB8
      CEA1D1D851AD7CBDD0D8FA6910D2358E8D86424DE80BD5F6B9155AD2ED581D4F
      479E09439E0C09163F486DAC9254AF31C6D4E0BA44A4E3BDD026B83735CC6319
      9B2451D7669DD4D46A8EC9E59787C47616454134E32DD0EA7310F958F5C42438
      DDCA44BE9A9839BD63185C1BA55564E3850E79904AAF75326CC6243AA65918AA
      7EA8D7C394D5F5D945EF5439E92A26404D9D98746E125FBF4C546A6ED32C36CA
      9B67D1354D1B4AD742FCDA18472AFF805DD08B0736AA6D4A6FF77C3E94B19966
      89F115D91EDACF954055D1D236D3200AF032B899EEEABDFD51654B1FAA1EC6C5
      874E7BA08E7FFC91E6756AE385BA6259A28E0F7FAEA961AAE3696070C3A10727
      3ABA56915E189C645C17E3BB378AD6A47512A5BD18BA0AD616F445F26875D072
      168C8D93874C8292755653B19D98389D5D1F1F1EBDADA97FC0D69AEB485D2669
      9C256AEFDF134BFFDAAF29E35D2726D6F31A44A0C9223F9BCC6B0A2AD66D0BBE
      790D334EB5EC6442B75F274990A438EE078FB6697A64A49E1A8DCD7FFCEB9755
      59A5ED6E160A0D7A708D1B05319FEA6B12ACE15A94583AD7A953714E8941B189
      6E84895568C4F72A98928EE12F24F20D561B7A01A3228DD76C5F903C27836115
      44D5147A97A4AAA743A57D5FCEEE42FBA410366601ADAC6CE4199EE0DCAC951F
      4CA7D027C554F205710FAB3EB1265D639D06932084D467250C4B1DBF86714E66
      10C626BD8BDB8B95E4554CC8B0C0CFB159D81B1DB219171B686EFC44EF536962
      9D92CDB3D4016632C14E6B7258D6F87DCD5D4ADE3B362F69013109674838E389
      8E073B4A1AB2BAD2AC2E9CF5951432E465A2229340F05CF45B6A69623184E1BA
      E82082ED999A05347059585DF45BD0B6D18D89528B9386AF5C4EC2E006FB8927
      D14AC2604D96260CAB6E6FD9B6F274A426B291FEFBC220C448EE7AB478DFD5C8
      2ACF2E699D5564536775D1692033D3A67313579A145C9B6BB35ED9D8576190A4
      AC35BDB98A706E64A49A5AE152D3B9DAD2ED0F4ADB3B7667ADFC4AF7DAA04FB0
      B28FB65A370D565ECE3B13AADDB1616B30B54C80255736F62BCEF91EA33C9845
      16EE55330CED4AF5F4B5517D1DA7810EF9441656589C4589D253C89FDC50B3B1
      4A4DBC0822D2BBBC20A1D5154DB1CD6DBA67B250CDB93CD7252DCE9A5FD6BAE2
      76164F2B6F2C498D95CD42BFAC217820184BEBA561CF9C6D1CDA4FAD162649F4
      CCA88999C2702A094C36D3ADF62BDAAB4D0AC2C4BEF2687970A0EE3850D830D2
      F7986AE94F2F1399B89AC676C1A72BD530FF68BD43A32339803066CD5264A67C
      C7090979918AB327D39DDF1FFEABCD66F30D91A323910213E8E1EFB9F99FBF16
      C5A838D392CB07AFA05E7E26B6DCB976B0A7306372B48A19B86849E1F1D5DCE9
      88CC4A5D2ED908F0E0914DECED7B7C2317FF85730541118A6DC35BCE62A13456
      A5F7BBBCD769A54793534BAF4CF1B5591CF8E5F7A597D88A837E8FE40FA2FAC2
      2C6CBC2E07990AD3DD924981795CC1CDC4B79239DC2552FD2B9D4FC4B95349AA
      B140B42D747C7289F5DD47A8F075F79ED8C7DD76D6D9DF63770FEE49B7CDBEFB
      3B1522026B58313ADB05A643FEE597899A201ACC72A0463B25CE0B5BFB8655B3
      1314C5A89566BE194B4863ED5D4BC8AF78B0DB8AC8A658F2358595F8F4D26B2C
      F41A9B1144302A43935614D191EA5E9C5E52B897CCE969C04621A4526A978147
      D3E85E347BD5F4CF76702436708E1178E0A57C99B880F5B581C1A626DAE7EBC1
      AF3F09AD770D912C21145E16BAE1C9C6BE26348AB7F670FC39B780B5825F2961
      BBD0DAEB6CC93198AA92567B10312FE9E492EFCF570DB72942D02436FC099AA5
      7C9A0E52C573822572F6FF46548A6C724405225F2D434D31048830BD2E04DCDC
      22E49ACECDE2D1B715F281C7C395B5AB8AE71B515AD50A03EF5AFD87E23C45B4
      297FE06DDAA5891291F3080B91B82173E19DA422A25968EA2102D17EA0433BA3
      3DA64F48285947907DB4001259629F6E918569C0DF948013BE89BFC4C845EDE5
      29103EEDE5D0403561D4F4715ABD30584EAC8629013B7F61A2CCD90CEECD5FC2
      810BB345A4E64623F1B4F7C3D1EB9FDFD4D4D694B6E213D566F521A01C9078F7
      4B13739C31D624CCE8F11CAFE76BF521F08DBA20536138B72B7C4FABC4A4C88B
      55D64D4E2BCB0EB2E2C18A78360CF53231CACA272805338B6DB63472C527F656
      A5B1319507CFCF5B6CA6B141040792CD845396A641AA66D62006ABE14F38734C
      76C6D96B649F92188108E183C76A2C4D94A79DD561439BC5954DD09B200970FE
      FF3093180A380E9664F1F83ABE5649BACEE3E374CDE972CA902E25932C29763B
      37264D54867C8ED2EAAA75CEDF7E024585339425CE874240E72A8891E150A3D8
      185A6A9D14978C729DC5B5247B388DC3BFB5703982DC150B8D8723CFEA207949
      862CFB63A2C513B547DF6B86E9DF5AF85210B36EAE181AC7C9E61417BC8F94F2
      B241612842239557D2AD79F9E3A49B161416092235BC5EC7C1E265A256462F61
      A4165F7F5FFCB1F4DBDC53973BA1974BA3E1C7C00D7BB4AC3E27294B2155E307
      D9C205BCAA3B8A5E9A2F392281741DAD0EDF294ABBC133E5912A9EA5285B4C70
      28615044FF365E4A1A4A697E7CBD787E7D1AEA599E9448391A86DF41F1C261AC
      18E34E31A6DBE7CEF0FCC00F431C597E3D09DCB8143E1486FB2C9F5EB296DB7A
      8DBBB934F16BFABA89D8E2DEC8585D0D1EBD8B1D4AB45616709E8DA661E0C18A
      0FAF6BA50BF732A16C30946C2C96CA5E0B4AA91BA5B696EF466DD347ADDD1738
      F92583226F668876D387E9CCD9D8EC7F2DA840F12585B51021B0952ECE233666
      B7B7BF93A59E930EF1B238C63585F1875305D56A6ED377626BE446BCF6442190
      7D489FF6F344481E6F34B7D51CB32167D8E23BBEB9E6649C3C9BC4B75DBA95A2
      59C89FC40788CB6F984A8C42273BDD77869E24368B3DB8781E9CC884B2F43421
      B72648876B9C7C5C441750AF1C8D622800D4C8BD70001C500756C12709091379
      61E61BBF9AACDFD64F35F58FD6794DDD78619D556A3D4B8330A9A97F24366AEB
      545F4E209758E8877FBCAEFB3C37E74ABB184F10AB6C99602B166A195BFACEA3
      933E27D98CD25F8F16119CCCADECB2DC97FE157C4C6D2BDD4B99D73C354CD277
      62E60162A5EC8EC9D370B455B38868215610CF0C303E93755AD9BD1209BC9A23
      0F4C33A629783A42B47C628A009D7324C503DAB639262485C8B4B391CBFAF013
      11ED58EA983E8A5C306563C91CA5EC7392DA65B5E97F3466298B86B49A8F2B24
      4626C757688AB02824DAC9BE7692EA8ABEFB254CD00D818F1B4B2FB9D09430C9
      551AF6F63DB63FF1E260992A734B2ACEB766A7778D8DB89E79F22C0D90E6BBD5
      5E1A8AABCEFB541C1D092B53CAABA21D01EDA2B43A48CCEF2E92E78453E98847
      C6F8D5DEEE34B8550B1D44CE26550ECF108672F9936CE2FE465B9CA436466C1A
      878B607301CB0B3F8BC9FF8246D1619090227E7CE8CCE9646794B1465AAEAB4A
      83DC9C2F340D479E3981ADE63AF63D0B5525F1330A844BAC1AB21A1A9D4EDC6D
      CA88C5EAD6586E0E26D7C132C95F91C36CD855AC2404ABC30D6837A93C67A0F9
      04532A6D1AA49B7228096D5ACA22545D2FA04A39BAEC6283B4522E17CE539228
      342B8F6E5B1D1E1E56B31870535CB660AE239F42B96E8F10E58215B10A3CCE1C
      E47F61811944BEB9855B8213974A1E45D2B8BBBDBE9C005A71440A37B2FE1521
      424647D952FC0088413A0585C020334E3EC4AFC73BAB740895B52E825BB231D5
      6EBAA5145DC9E5E48B90C72657418464B30B0C44B0D776796D18E00EFA534AA2
      C3D8543A8EF51AF9247D1B2CB2C586F8E408A74564868369DB81D5DD125FDA29
      068058661125BA244EC22A1E2F0F77A2FA5BA7560D9DAF4F5E0305C810A65B86
      46C51414B277C2012579CE2A943C07B741F9898404C823887BBA2CDA5E52A47F
      2B038F5FE2E814028FD5F6BECB9A7B949D348B65CA511EE7B063E62CA26847DE
      F3C58FAC3B9DA1990A960271AE226BF978A7DE6ABFC0CEC13FA97875C9C22EE7
      38C4CAE7AC576E5191796FE342902E38850D873B703131B22900FB49ED02809B
      70BD9B3C41740BE95419C1EDA6E0F5817F83EE84F74AB3A52CF9520BDEC85444
      9F0EAF83A53A9805F0EC431F12965437F69161FFA18598A161F9139586F914C5
      6606495D4AE9E7E6913BD5E4477C2DF1FB2014C359AC255C250173B4778DC829
      A21436BEAEEE5073B03C1068A6C305B06D1C732507004A731BA75EE6A263C182
      B3F07140A853F616A1354961E51108DA484064F871621C69F72E74798B0FEBE4
      3A7110E4548C2C92441545DD7D10D122184DE14C3AE72E26976C614625824973
      15AB6287D988BCE5E46ACA980159387660F2FDA4E00143452A0254743217C025
      A5C8C49A95C43950311185C891AD82618DCC151B39E56D2AE40849961D1C5220
      5E65CFD54AE31664511A849442C94DDEADA8D4866544936BB115283621E23E1C
      CF216586B3BB44A14EE58B401A04E9E30D0CD9CB44F5C36C365BF39F6203EC24
      E497165D840BCFCB0CAB892B8DF00068518759CE013F0EE0721792FCA008E0DC
      2795E404C932D4D58471CB050E639364619ABC53A797AF54439D5E5CA948DF2C
      4C3257691C68A4E094F16779DE91218CFC5AA18EFCC4D34B2337853F7362A260
      56C048393B313714645DE865916CF674F83459E512AEDD4248407C502E38F0E0
      EC2316E8CDE1D1D9986080A9592C01CEE0DF56761261B4791E70EA3781E57C30
      6C3380CB287A55D761400733B121575B61CE9470174D504D9371B8706AE8628A
      3F4CAF9CDBAD9C39561F289155F1FDC29407C0EE6D26820880704F2D416C5785
      0547F701B07E3F00E42D95BF48D9CC942C6F57A0269502F431642124A3B58AE1
      CBEC60DF37956F332A6063DB414C6BCA340411FD9355804E008107A2087FEB55
      3C13101C91BE09667C1490B92C2D13D52F04C0942C35D510624621CC1AAC1B12
      AD38381C4291056003147F06026D5555DDD0595583C09B5300B67399A597D381
      447F13657089F8A602FC1CCD20DD50A7B295926600FCFE77A0F47967290D4F25
      9A11EA0C397050559D35A3ADC7A8D0CE285AC9556D3490B9256FCD46F53F4C6C
      CB5512D86EB63A58CF579A435D67A925A71183D14F1891B19488B7B1725F58DF
      C0DC590409695C1BAB2C82AE204B473EC41A83FCD82C7A96D9B0DAFC4471B79A
      FC34300859F1625D467AC17FAD563FF58DC72726ED0C7B62E19041595375E8F3
      66E49396776A1D6803CF33CB52C4C7551E30C61A495F3A885480830A472C29D9
      3107B3B94DAADA62F5DE3BD55BAB33C27BD1636708D3520C25D60119D930C892
      5027F34787F98B921AC58BF3782BBF19863C9B6A1B72D63955E3B16A37474D55
      5797F14C47001D926117DCAA4F11E644E125BCD9D36361069DD30126F0EBA873
      5E53ADCEF939FDD43A1FD4D455AFD9C64F433AFDFD18F67EBAE6C899AA930D28
      26DD941450F21C589DF3735587017463E254B5490E64468D10DCC99785C20CA5
      6C20D2CFAE80E9DAA8DE657BA4BCA5983A4F3FC796B321125995411601602A79
      D3D6A8DD54098CE26BB37E86E12F9A575D5557FD388B107361DCEEC555AF9B47
      AD9EF1D80CDA4355571F82282DCC47063B0CB41F642429526BA54EFF19CE47EB
      C34035F2F9F4517B90A4EADC7AACD7794374248A93904ACF310DC4034B473011
      1369C539230AFFB2394360C04D98ABAB5D5D0452BD77FCE60DAC8A5167F84635
      D470D8A9A9D3CBD7F8CF5BAEE81B9E1E559AA694367045600E9E08A220997341
      CCD6257260568DA4D052BE8C1A4709353E7E211F12A1A797AF1AA71757D5CCA5
      8B2B144106B79C2601204DA2C3A9CDABA5D459A7F59183920EABCB1040408711
      02B2E408B08FC547843D44327C1335BFB81A769EE865B1A995518BC3D6E579BE
      6FAEB493D22CE467B22FFB290A7ECF8C6A7A04E52ABB502818237C65A8618651
      C042EE4909B2FAF4B7A3DF197C44C576B65003AAC55C640945349DD54788CA69
      40B5B39335D7693E872E697DA8A9616B705E53CD5EEF528403D45C8DC37CCF34
      F045F7949498034C0CE770F512D53F1900514DA7150920D2FA5260FA6477EB75
      0362A3B22F6259DD2FAC0FF4042C806003B42D0587641607B1FC88B833F1133C
      FD5A9E5E02B2A5EA6A58C27E6D03BD1824C699C967984251C558177B71B3C61A
      22FCF06786E9A2101B3FFFF8A3641EA9A63A32AB10FAC225340825BD3D5357DA
      CCC9A54ADB5F55510CF3B2F0DCC87295E1EFD4E755901875F68992CEBEB97581
      6D06EDD7F2AA5C1D96CACB6933F29A955580CC05730BA40E932F95358988F1ED
      E5D8AE027F78551E8DCCB868F64A29BB38F0B99096E16792B4CD6F6764299BBA
      4B44E8974FC3118EEF4A2FD5E9A7F3737AEE092A5AE80CB51C0B1262A78439FF
      0E39F0750F876DF8EA6084C48604E4604FF825E2C05CF68C50DA0D013FC52FA6
      B0297F4CE247E23D134021C9269CB0210309292697A1E60712C2FEC73B08FBA2
      B6BF3AE47F9A4554E3217AB248E2EA30984508505074090734CA7FA7FD8AD12C
      DF576726ED26221FC86A2B7E7668C159461865919AACC5259EC468191CBC9901
      E3134F2D29FD9BA24EA1A12780FEC9E47F7D06DDB99905D94CF496D3BC648214
      357B5B09DF6AC248A22FF9FE71305E69093AE2F6D69CA242468CC0155BA5A84F
      C5BEF1F173BB49ABFF71D8FD27878B817D8328A369D2FEAD62C0C47D978AAE18
      3DF37D9578DA79B8D8ED4F5D879A3B45951ED9AF00E1A11892EB2E6597BE213B
      BF436E5C744F4F7708FC9FE681FF770E1F014F3E80A1297546BDCB7E9F0A4C02
      529E740BC0E6C1267DCFDE188AC12D7492B8DD2C8CF8078D2AB9504F7F1B3E45
      01333CC04432F13B9A6D7E1CF59AE832D4647EDDCA73E43D93CC8773BD3480AE
      0A5C849201628C3FFC267E90C0E8583DCBD55E822B6E14EB28816B97F0DB9C0C
      47714013A60D33B7EC10FA04CCC73E3DC3AAB2A8FCA06FECB5EA463826FA1DE2
      8C241D5D51984B062C4D6452C93FFB6699CE9F659F936B44654D327FE7A44EB1
      30C88F6FA7943877FB343A9B498CAA99A888BA96AB23BE4681F41C078A725E48
      1D4BCAC8B124417671898D1A76E80AB4DBC39C8B49689592779C8CD46AA563A6
      8D62980F8522807522C606825631DD24A98288C80EED3206DBA1AB35E0CD58D8
      8A7C0C208002D1A0F03D49A5ED2258262F11B1D135B83D25E6A87C497D2B581C
      8472892C84C8A4F0F11C8F172C2B564431210C15DA72D108566B9BEC2527AD21
      AC44790F9CE1C07FC82606595E60902BE61E7BDF4D7A451026783EF837F8216E
      5882869C35486A02E9713F31EB11D692CD1E2622486AAEF48F99FC6A9BC45D49
      ED0E3E09DF3DFFE76B358D2B87EB9B62F0B0FD9845D887329800013FFA576DA3
      6E1349577692244B08CE34174D0B2AD7FB695F8566A6BD35DDA365706B3838A7
      05EB736AB3B8850A3EB8343A51BD007441760AF35D902A0BCD35013982D1B3B3
      08DE9D56ED5F8F0E370F889F1302F03D48BC53E8AE5DF0656ECFC8144F6AEA06
      E5B66C2D1FB5739180214F9AC774EC2B8359C21504086C062AF1B56482904E0B
      A6D89983C5F2159F42E253E552165E96DC1609124FA20AFC459075AC10BFAC51
      20129FA5A0ED330A57876598308A235CAB107046AE1BA8B311380D66B4A8845D
      9145639120F5FBB80F22A20C701EB75B970772F688F4C6AF28EB3D98E8E3A752
      6AB7ED6C5151F4B1EAC08B3A2A50E7862C826409C6635FDE9963512C1F5CCC81
      C40F7311AFD49599491D0D65288858B5E27680689551ACC46785F2E45024982B
      D9C17509A28009000298A40C278866195C935C1C3B460041F6DD29F9A844DBFB
      FB13D2F6B64BF4C8380D41943965F3BFBF42E5BB8438F74817D8A84432746092
      25BDA88B1E5186A821E5B11277C9F9191D47F4161B879E50D066AEB3106B3DCB
      421DD7CD6DAEEC382F4946843042E23CD773A943351AB96EAC87C124D64C6473
      ED8E0DDFAE52C84FFC5C73BB0419B78DFE5462DC62FDEA9B2B28B4015CE1EAAB
      3DDA139459C5013BCDFB35116AF8B4FB969D4ABD80501D412473A62EAFEF75B0
      D7F7F927C5B19E849959C648FCC966793A7A49517D294F23ACABFB5052FC7917
      02A5AFEF3FB83E8BDD4ED2C0BB5E3784BD01C95726200DD37A01FAA9718D7B53
      D04E751D0AB702FFCC5921D81615A77AE738EEF54D1C0ECCCCDCEE1793756E30
      5531315940CD5571E413E1791121047F3127534AD74B262EAF0A2EE48BD1688A
      195E6791EFAE487E0329E050D0383613B6C158A1D4496FB2F2612F3FE77B4521
      F14CDC343B556130F1CD14C9A846F8C7EBC6EDED074865C8E26C22076CF7983C
      DF59BEA88DBCFEABB8B26A0F6A7BD4E99FD6D468D0EC0B5CB8D71FB9C8EE7BD5
      89E89A826729362B1DFB12BCA6F0FD66E07E1FD897242F3C4518B741717FC784
      B7F3553F8D8D0935705E3C08731CBB436A193522675AEC3813A5F5F6792BAF1A
      71B49B3B44E09818184BB79AB8FA90530EEB8F86522640D566F4D2B50237021F
      7918CC22CE6C896405804D2F21386203F61DE17D99B2300144A8EE227E049EAD
      4CA04A212C9978B9C29E4E3480243C292EA617940B914EE52111D58DD8AE0E6C
      B45FDBBC207897839361B371000BB5505865F6DCB891AE8CBE0690F8DE6D780A
      FADC2A8CB9277632597B616636C9735B0681C5DA26236F124C82B820D6F57EAC
      01F6B4D03D93C636F0EFA5DA25F6081D2D759A56A6DDBDB702FBBB8CE57B50BF
      90B7ED6EF3BCD13E3F1934DAE7579FD524D69137AF73FF0B82A76BA184DD408E
      4408ACFC829C91200429FEEB2BFA5E358BBE13253848AD7910FA67C87C390F9A
      991918EBE9D85471077B3A8804344C45937719421F3BF46FA797AFBFA05FC6CB
      D485237FFDDCE96D126408173887546223AC322093CD25AB2454B01E10EDBE5A
      66F1B22A773736AD4D50E0930CC069E31749480CF4A9CBD9211B266A4F580340
      1A5091636680426FA5917F12B63060EC1D9389431A5F517E658F90B11CA60405
      10A644DF4BF6A5B898129B2E372E551A0B83E2D94A93EB822F8ECC6D7FFA4127
      FF34B11D09E1A88D379765B49AB0106E9B69E5751F74CE2ED4A0DD1C71E64968
      D800A5D1E1B5E27F32C69C403314CB0653F1BA60FBAD7610479DE1EB2F340500
      5029F359D5D3C7B35EF1B3CE4D9234CE888820AE933C6405803A8489E1AC3694
      34F388E2C508F09F170528143E3F3743F8576DFA6F78457F5282FC2B2EDBA6C3
      21E668D9E1784741157C45E80F8559453AFEE4A5ECEE8193AC5CEB483E44F9B3
      05A1D6C69270F6A4F43D43150918B79ACA20C779C32922A66D487BD4957DD53B
      12EA356ECBB0B014EFBB77B6B452B98B4EB1A6145635F012C0840489B870540E
      CEF8F765360909A39717CA4A002A513E963C63415377641139BF2DF1FDE0207F
      A452648AC5563C0672E8CAB4DF6467C745CD3BF9FE751113C76F8E09FC5D53AF
      0F7F7EC3901CDEC4E337AFB7960FB70FFCF29583A1D24C4558D81B548DBE095A
      D9D061BF6701C28A94668742771E2C2A8C18B4C0B515F941D521FF922337F200
      A8823AD72AE574F07C48518BB719A172DA5C2AF4F209EE718532B554602658A2
      2E9B5565D1694BA2101708CFDF38C9C4B97AD7737F5F76D37159E52EB9CD41B3
      2A9AE52E0E1A264614B57422A399CBF639FA88329B3595183A967B27EEBE83C7
      F66E94E0BBF2E1DF91A0E76A7471E425357FB7FE0A1DCC208FC3B45C729493EC
      358B6A7AE22DD9FBE1A7E39F6BEA879FDE1C55C41B9A958B79BC03CF25252930
      3166CEE6A008C6C485460706F064737DA2F129ED5293AF510DC8F6477165D6F5
      DF331D322D0E047BBDCC02F8BE34281CC46F0EF9E237C26C7CA1B15F6C0E9E93
      816A8A7D98CA0CAD1F4060870597DA5D1A44AA9A37583E53EBCC0296E0364EA9
      127A6E6EE2C27F1032C9525DB21FC4EC91572E4873CF24E0383DD725B7CCC1EC
      40BDD83C5A7BAF010F3F7DA78E0E01137FA78EF65FC05AB7A90E552367A9E490
      381F53D5C88BFE762364CC4B075DC70EFAED4BC7DDE0C2032FD5D22EB3659DD8
      553991B777F75C3F7C97BF1ED57D302541F7EB09EF791EBBDBC8AB4BE5CB5345
      081F8A0A0A951F4470BD885052E44D367762AB3ACAFC8A9BD144C7435E8A3A6E
      2834BD5C86C835C34C26B0241A40A5B1BDAECE11D801EB2095C948E904C8658A
      3521B3064115877A2BA072624D3E9E3DF9B272FB0EE0B2A4CCA6EE04124C8758
      7B98C5D711324F721821DB019BCFCBA29D86C78A919982E01F012AB678A3C841
      953428A84BA86CCD594E609130DF891BFB8EFA286904D34D0DEA4E160B4D2805
      DAE48C6926991D28176F52D8C0149110D4643C5025FF1EC9C2976F6EE9711748
      BCEDBF2F70B3A5E7835E9EB0CA419403E19FE715E17983650D5EB3E3102962A1
      7C7023B3E23879102DB314B7EB656FDDB33E7C95971BB4FD9E853558FC953FB1
      3D710ED33DA9989344661DD5B0A52C88D06C94B01C0EDD431A3E8F1449A387E7
      59E2734B6C25602C2DB512D9B2AB379B783CCB3CE4C26CC45E70210BFB958C79
      727F992D9B0D0A7219EEB81CF3C0C4400B08FBC296DF5138BD1D44A03DD30C43
      F772ADF36E0120060297607C64E71BFE70FE97682D8200DBFA2C8BF2C3CF3FFD
      541807B954447DF5EF19F66982C60954A92BD6D386C545EFCE7415ECB531F5CE
      334DF5CD21DB82C3790006284B8466BCCAED6E1B1E1DD84A96B15D2CA5AA5188
      FC208E22309332DB3D85011C2B56715B9E67D64787C7C7B913CE2B4815FB4C9C
      9F1F84331321C065869D5FDEB96D3840B1EC33CDEAF59B9F14C8BEC5622763A1
      2E640A3E21C3C95BE0DC9BAFFE8DC22F3AA3F833A8FFB2097DFA59A63760CE4B
      35EA9985E508D5286756A08388A12719C8FB7C0A44D5053FCD122F517B9CE754
      27A80DC07D4429173396BA0490106B327FCCC0CC3AB768C5733D0107397194A1
      8D17CF0055F36019E12ACFD1701DD1AF1FC3DDF0E880B1A45B4D29D35A033DAE
      34F8CDF3AD670105F09DF540117C49019720118DF93D50F9FF232BE95DE9BA54
      D2BBE8028507F7A4C2B4017056C359028DE1E9D18ED5CFFD414FD5B96B986FA6
      F0D62264B888769E5BF37160E7D926D0ECB74BE5F17DA6CF69221A88B767D659
      AB4EAC25BDB877670A55873FBBC0F0942890F7E7EE8C49AA8E995658AD269F22
      C07EF68EF79FFCFD29A8C084399807D570B97D98B6A45705736CF8D3CE2D61F9
      4E63BB38011DD6C04C9F7C4248266226DD8BCB5EA37B71D9BC673A951F5CCA52
      D601FB2C5293DA874085E891C2254A726F242C9FE80587AD0E6D397142D499E3
      AB3FA7AAB558CF68060EA84D7167576E0D311BEBC8B70B57CEF644135A4D4AB4
      0B58F9E4720517A38E4823C24A340FC0DE9D7D819FF9334B0D08B0B83D17A8C1
      DBDBA83F969C75C562673047C75C2CC76602E362026747670C7BAD667C768667
      85742399C351013433666CA7ABBD9534FC6251311E35BCFC74C1F41FED61CB1D
      E7818B7C0BA519C79AB18435A05D381EE89808E5206CEE7845B586B4DC78AC3A
      B8E9903C94B4FD60B3180987A149D534B4E0180E66DC0D4B1D3FD949EBB6CF3B
      B966198F15819EE926928D2B4237B5EA1CA494F796B23FC10A500D3D56603A25
      D6FB42D5FD429085614A556EF0978FEB90C08CBCC28D2BCBBAFDEA35ABE3B16A
      92F59294CA9ED10F7D8454B1F387DE13C49A4550110A714E123B443A5459340D
      42585D6C10F1313668065BA7B08F835410CE9C8ACDF39CD610FD62554F479ADE
      EE8976F943BB0F5D2646CB933DB6DF6CD1B6F587ED5189A82201FB21107E4830
      7320113823018CA9FFF8BB3A3A3E2E186CB891656E597DD5CCF8BEAABF87D9C0
      2A8A0D22DBA9AB57316AF3D0F78C84EC707076C23F577AE8E7D107B2775AA1CD
      0ACC96F03710D1803B2524EF13F5C3F1CFF51F5E1DA9BDDEE1E8D7C605FE7379
      38FA75FFB9FC0C01B09D0F5B83C6396414711F8B44E6D564695D4781000E155D
      C9BBA63F5056551562A7D4F58897C69F0E29397C0A6AD60B9B3AF15D7180731D
      F9E7BCC02860A71AFE26B20B144E844B638729E54F8851594E2D85840AF649E7
      3755667AC78B8D5693767073DA36680CA1936A2E83D832A830755B55D418E7CA
      F3C944018D737ED6EEC2202A112B1423D10979AE102C790832D08D8E036E8544
      0EBA7BE73D8EA671368B3C39235F5802C4E96771C5F69FC27B191B3F8B7C0DAE
      A849DF26039B3656136831FE21D705C8FAE91B1B23D2B89A5C19EF157FA0FAB2
      A32F75A9FE1FAA6435C9C155420169F1BBBCEF516AD524361A410D94E5D67DB3
      048F61E4ADB973E5A385292E7CB54D1B8EFE8BA4DE70D416DDC10DFA74086766
      57B3F94A0E0122E823DB25A18131CC2D88FDB0508D8278AE2CB5FE1C6627B130
      28C27CF9AA84C9CA51C1446DBA7D5DBC8AF655E7D73E98E638089EDB1C00D950
      9508B737A876F85BAD51C95C7357B1E49753646A4390CED1DD3123FF594D8817
      E3BBD6BD32C9D4C9E5E5C7927F41FCEA64EED2EC866892878F34CEBB671F0A09
      B6CBEA6CDBB5751899B38894D834B8AD161E686EACF8462C0887A65AFE01AF7C
      8F1B4034883827476FD4DE7910191DEF934577A7A07FA750CF67EA4FDD926E69
      5726B45E40544CDB67962923E19ABC67E37145E847D767ED2B71AA0D1D572D31
      49660FD37DE400A97A8E8B236240699830F462142B23969A5A757179D1716981
      D647C9E824FC3C00E36213AE0B25BCFF9436D3E74EB38F880195737006603131
      940BFFCCFD21994A12C16A0EA012AB1AA3816B6A199B9BC06649B87605B27265
      89C5E6E80E8B4D1930FF5D145ED5EEF2457B480796A36342C2EE0C32228C1155
      48F170EC0473F9EC71DD7C29E9E19891F6AB072DC66335E2890CE7D4B0230799
      D1C2B913F33DAB52FDAC7685D9B44DBC119753752AF85BBE4A1B645E1C47C385
      BE68F6DED021B868F6AA8DBB9A5C9E8C8603F3BB042DBA5C66DC70DCAAEC2261
      C50BBA52CAE95FF62EDBDF4FFA065BB5DA5DBE6CF564359012AB61B2CE776808
      241E8746EE01FBA99414A1C4540C1C1492F8C8B7333C358BABA142BA171724FE
      2EF48208D42959810010FE6152328F68CD244095AF1BC77ED14804665EE00534
      E1EF58C28A470B6B865570156679FB9BF5B2DA0A9C7FB398ED2BB471EF190E92
      DA8C5A6716697AC295DF714DF7DFDD3FBDB7C798DEDBE3F2F44CE4EB649EE351
      245FFB8E8AE98A5ABABD965E2CD5284843B3FF5E7A91490797FEF97F0DD49E44
      677354DBBE42E410E0360496A95ADA2664F435622B563A97DCBD6744E53D5C7A
      45BBB74AAF33E05A3FB5F76BBF356AB42EDB67FBB5A21650ED752ECE7B8DCEC5
      F908FF19EED7B8D5EAA72BB5D7FCF4E96ABFA6FAF3751278891AAE234FEDF53F
      0C47FB7C41DABDB311D1DD65C9AE936C16047B9310BD5190D84F6AEA9F2393A4
      A759E4897417F880430A4932EC9EAD7FAF9AAD93212285AFD5DFF8DA5EF45BFF
      E29EB1E757E75DB684A5F8B0F239F1E63A0C0D35845B2F313DE1C76A041EFC2F
      FE1DAD5567486B352BE28AD55460FFEAC479F879175B02B0E09F27D65F1325AE
      C8A8EA79C7ABEEB0CB6D8727CDC5243051DAB2218A4C4893BECF4B43298E1A44
      53FBD54BBB137312E9AD9C75D2559FBE97BB015E36B3E27E6659741DD9D57794
      2156D524A53255079B2C97ABBE2F97AA26D9A4EEA01F9A8CB03DF46140317718
      BA29EFBFDF54CF5287F2E6A76AF3BB53597B67674A45929B3596F701AFDE490A
      2EF756415DB034F1B5805FA9D10DC7BAE9E7DC97C5E1AFA993B3611345B1C18D
      19C5C16C66625458354ECE86BF006D9DAE3F2D67B1F63945CF2C913522F8C04D
      21D64CE2C1A102B1B0D4982827DE246FE21476182E746500A2DBA5B3CF9DB6DA
      3B8BF50DDC9CCF10CD2616578E8AC358828CDAF8D8081020D5D60B4CB6FC999C
      18554AE788141F60044322E1CE0054999B3F6A9F508106D5F11A65E9D63B2060
      60F534274B037777296257E7F03B50E8D17583A0EFE95AA581A3622C02258EF2
      0F65E3F5D88661038C1FF421F95A3DCB37314993670A493BB7BA3FF884E41D07
      F36058FE92E928CD16AA9324D421CA9DA8964D1E575196DF878A997296457427
      F285707A01DE2C575851C174B259FF51A31A3142CF95AAD026C87EF9A81E723E
      64B9E6690FBFF9C7F0F282D0C9AE3B0552744461FC4CAB3FEA0C7AAA19A70035
      2F50972536717E37EBA5A66141E41317D1DEC8C4B18E54335E685F3BC17674B4
      FF27C1DCA960D2F18153A60F40BEB04E95A01C4F20FD5574A6E50FD5854DBD47
      1E40292BCF3D4076D0AD655B1A0AE2C0240B2918126D8EDF568EE8B0B37766D0
      EB87F0C2B145101A882F474106B7AF5400499DB668027F12F12EA6B845B6200C
      25372646B374E15D68C83FCE11122D70C70B93CE2DACD9A6EFF735EAF7058B9D
      D428188330321EDA4093F091C53FC59BB3B1B97BEE4A2CBCFC312985DE9A213F
      086165DAA7D8A4592C850A4CD22AEF20F600B33D23C4F24CC90F778CBEC24791
      674378B25CC1AAE4637BFBCC6E4B68CB7A62001DA11EB8EEEB52E0B5D1839A68
      D29EE5553AB728AB57DDD5A4C3A98B03D9D0209A0DB389547891CE5D4D08BB78
      40FF458AFE64DD7107A3715ABD69A60355AE2617C44016FC615C7B2A6CB9C02C
      DDE86726A57FE04FD53432B0B9CC9AD795D6DC7F50C004BBD338853005CB629E
      DC79CF256679C24A051B591ED7B7186D3F8595068099BB276F57C6E93C27CCE9
      7EEED82B8427941C0E5CA6A99E2C8D174C034F28B0B93FF5DED13E3A25CEEB13
      C28BDECF87F2E4B3C655718164DF78214E7BBE6A4472EB80C64C992E2A97DF0F
      5F6AF6BBA5F6937B54E4DCEC770F96FAB92C9DDF04A22B80902FC5CA5B2C731E
      8B9113C9F9625E64A05116E28924EFF3CE916A62ED753D203BB580B508FD1CFA
      699C6ACF9C99481D44C1B4047281BA8E0D76131024F1BA1BADB98EF1E1A2E906
      57337A267F0E908CF4F7F73064888B8324E3A0D9EAA8033373AD0C40A046B378
      AFFA7AB98645C617AF548D50992BE5B74F916F42235CE5AE5C3757F6C91776A3
      33F9945F6E19925AF54FF577557F7578787898F30A320B1F3304B8D68EB22354
      F719ABBDFF71F47ABF202BB54B8AF798BA9DD6E5F377DC94E721AB76C9469B43
      708E0E7E3E38AE78F3C5C32DF7D3453D08B9B4DF641D22E17D1FF3D0FBBC9A5D
      289287064E12EC2E13073A24E41541F38A61EB9423E5FAB8F779B18CB31EC0C5
      E3EB10B6739918493205D42C880EF630B48E016C285FA582A7A4A6FA716063F8
      4276CA544596505D27A1F5C0C12A18B9AFFF45EC97EAD2AA5C8C59F03039024E
      E1EF7444966542D18D8DA87A633668C099738458BF85CC5C7AA5D1D57F4FADB4
      A9447008CEA058B50D11C4485C93DAFD66E0EF6F38169D82149D614D6E07094A
      C79B27DA5E0871D4DEE1C1C1ABA3FDA21C51323C0E74838E79C563C82832E9BF
      60F587424E01A46C1645C6F8E8080591DFF43C34EE816D4C0A1E149A41BEA3F1
      109DA62105765DC31173647DA16D7D31806FF4825EEE452FE33237F91D830801
      57C1CFB55219CE1A5A454B33046A44CD2E16171782D7A7A28ED926B3FF024B4C
      535B4B2199AF17BBD520467BDE16B781047EAEE5E542759C85A59AB1EFB1AEA9
      7F1D36FE7544FA6461E3E59C2AF042A8628A8AE020330B7BDD436051E97039D7
      8D0FED412DEFF836FCD06C7706FFBAB844A27AD4BD382BFE24AAB1F1C89DE44B
      43DD38633DF36D18E202A354F4563509D1BCF7EF0007150E74B5F5048E6501BB
      AD19052CDD922F7975132D83F48B4196908A860EAEABB11AFD761FABFC17F501
      0A138229E78806C93B737E17BC2F347C0A4C333901CC089E0BE79DE633285616
      966810A55F04DD83B13C01892014E2E59F20453B995FF7102E81562DBE5CD174
      DAA2FEFFC2E6365D179C920984752E2E26BA14E8427FD6EB20A26C4DC1885F55
      06E434FB5F5497F9DD777EE815772DA040BCEA638D8268C6C24523FDB53475D2
      40523C4E46CB75B0940BC632860520FA54E71236881C9A0D57B4A234B1CBB58B
      3BAC4523BADD271220A4DEF3D60F8EBB3CA7E43415777B602065D1B2B888CA27
      6E454E289104F85B94409F0B6EA3E2B9F27D75119C5FB62FAC6FBEA8D61CC8F8
      9CA4FE2218C0C038BF6CE7BD302E02C684C8EFAA8DEAAE786E317D111E0AA91D
      872504D95964CF3899582DC00AEBC883245F27A86ACF2F86A863C6D778EB3AA9
      558925C336E80DDB2C4768703E830F26D61E836FFC4C0C1149DD59AF8553925A
      D51B7E307AF967B49DC0BEDF471FFBCED12F33657EC234CCBC4F8551E632931E
      824FEFE52BFDD8721E9BBF28AB0BE198286A6D285F4E2D8FCC0FDD211E782FD1
      6D91A8D99BE2EF7E064C41CE5F54D17C2D7536E19C3CD1BE1484BAD25B0F7F22
      3A342E2422134D58DD25DA11E4D315767AE0BDAB855B44073BD678B21E8B2267
      E942EED9C58412F5E4BABDFCDB4BB55722977649FEBBE638D847E10ED23D916A
      D3053CA086431811F7F6149D6E769A7EB20C83341FC2BD0C81C5FE306AAF4E7F
      7F77A1CE4EF601E3B27E4674065106A6C6722F8BBC728CD8CD1094073C16C6F1
      4E478C554EA97A5FCAC76F8075A3AE1214864E3065921020CA73D1BB6A2B63D2
      B2B5C365C944E1E2413CB2A693BAF29C8E8642FF4BE127931EE924E85CBB7B92
      DD9703A9F7D9F032A02961C92595D960681D5ED6FF78C9AE09119C50D3712205
      D99EE65EFD8F777F84C1E47F867FBCC6FF4FF7DF2BBB080AF4217D4AD84B8519
      45C07095D325143BE7582A05EB84B887AB7196B1A973B8A6621881C2E63A6F92
      8A8B05DA7D9F0C775A71DE35ADA63A4C0C750191A6396A2F979ED5934161865C
      15E27878B26CAE93DAB986D9BD43C1F2093B148CE6605444A8CC389807B11426
      A98C189BD05091010219D2BAE0EDE1E1DFF2DE0524F18EE81705F3F29F4AF28F
      604211A4F1E28045FB24037AE787A3E3B73F82464E116F02DA4D98C824494DFD
      70F4EAEDCF84142C4560C1578C3FBD7EF556F9C6C08E5DA2850BE2121476D041
      58B9ACA30742E79B8DD23487A2105831FC973C7FEBAAD4C0CFDA2817143C5959
      B8C453C964CE39DAC18D5BAEB9AAABD3B3B361E3F4ECACD9383D1B0D49B0706F
      DB702DE2AD623390CBB73FBE132E2DC8278AA69E76871F1C08B058A85A8E09C2
      FC10EE4952964962C25513F22E55F90E65C8505911FA59C477403835A74DB877
      A1E351E5B49CC3A6D54A4C91E0F8930AEE9D1059D8E977F7F4BACBC5498DF1EA
      CAE1D5D170C4C32773E67B87770916CBD8DE506AA7A2B18070F13BA1ED750797
      AEFF3F8350DFA8BDA31FEB93C09516BBD7A65EECEA64E80048FFA18E5E1D16EB
      BAC9325FB1D85E3A49CA1BFA390D892B7A2D9A9E7C36DC670AB28DE8E86EAB5A
      A37D1393688F3CF34E0D97C6F819757143C2CFC639FC57E8879E9CBF7E836C7E
      136845BB7187D3BEA63E66B10DD2248B4C99D45E70AE2D9D78DA0FF406CB3D9D
      6F64DB7458E2AA6FC6E97C61D12C7DC824F79FA913084AB705F44F71D4BF82C0
      9EA57D1D179BDAA389D4674AC7DC6616DADB8A23406BA09ADDA90CB46AB34B04
      BDA4E137B5FC12BD4262CC319411193E59C83EF1B5D78905A8A2F0641D05A892
      D352A5C203E9AF4691B1A5E3CA72D3210E652834A6F1D611B3D5320B5BD545F9
      118B02FBEE640DA4C425441F7EECB6370C51C471C9991153BE5A8AF31BD8D991
      BE668A1E185EE616094626C716AE7A92596726DD9A68A5B1FAC88EBE3CEDA8C3
      C3A39774E81D4510DC53BCEB6FFCC72F14787F79F8137FEAE56F873F7D795969
      C84F403444E9C87E30B73873B318753264F4846B6EAD4B49FC9CD180D1CD9576
      B6BC3FFB79C1636A62848398810C8C50692AB61159F453E2100E9C96E2B55F58
      9FE82E9E6C1AE7E82CD88379EFC776E9039E4BF167710DCB9EB514EF38743C4E
      3DE61E20C156190E75DF9CD2F51248051082A61A7E1DE8F7B807EF938C418142
      10B050117F6A4B75E252C9BF971A6F1EC959A006BB0C0344ED15F1DEA4739B25
      F816756DA7EC0C665C22B7AC0A2C20AB11FF197C713639932AE36253103F4812
      7485202847A4434E57509FF382B15D1C8E1DE630F8A27EC902EF1AA5064C70C8
      9BC387831DDC4FEDC1CB8D94FC9DB4FBA524D7A14BD2CA816BD40C7CD9A602D8
      285D85474A5B5AC4F5BC1878CDB2AAA55B3D3721B1CD4ABBC2205536AB9AA0DB
      ACE5FE02B80784E081303E116752082426D128314E8A441A4AD13493A216D568
      245AE53B4F369FA26DCB01904CAE2EA158BCCEADF13217B4A55F177C3BC36C52
      177417419B08A2F3149D291EFD46C3D3A32F0254D848BA9F8499E93FA98FB071
      F1B8390DF159526B908941CB58D519F671D18A21770A17E6014EAA25EBEBB45A
      F89B230C75AA092A1418D0B1651E5EE2B415165166977494F8F01DEEA24BBF7B
      74DF576DE74E353E94794A391C7535E80CCF1DD568792BE9D791BF5130BDD354
      FA2CA4373B626CD00E479B94ADD576519C956F3B2A8F06A95B2FCB2FEF3B2865
      69CC342CAD16DD5932B7A81A51B54D2C608EFFF3D9122585093608E6E871F5FD
      9BE41B4393EE762388BE8EC8BBF85C021E67237499249266E20CAF512BE19D48
      04B687C9656AC3BD17B1D300BF776EA806BD318AC5BA5BCDC153C77D736147E7
      246D4C009B34DC9CABADF496AA14C051093F8C2EAFA4CAD9A520DD59AD30A779
      D56D5C34AF980AD147BC1E0D7DEFE78AAAE5F1B1091508717D105AA823DFCD45
      00D56282C3D1A8B141BC5080061A5CFCC131AF5DB8419AEDF645A37579EE183B
      8066F1BB68215134477A4AE2C33AA8E612736D0C0C16B4E744DCEC99B9825CAF
      C922D5581EF04E15A708928450C4D54A198BD20D36300B260EE27BFC880A1A62
      B6E80E8F1AADEEF0F8CF20145B4D4E117F93824AA7DE286FC34DD908194688C5
      020EB39B01B29A9CAC53B331A263DCA4545D9AB785DBC11365622359E99238AC
      F8B00B7D83EA941622268E9AA4A85C99C3E88836A00F55EBFFC8685D4D4EB338
      0A20C0A8FD1BEA0B78D4DD4827DDC3B5676648BC3EC5C3DA9727FF602066B2E1
      A8EC74265BE12225280DEF1F0AEBED14D5813323C950A0862A3E1C4180103896
      82BCE6C2AC8ADF16A168440A72B826E305A813B35080EE76964671A001F773C7
      89EAC2E924B1A57A179AFD2023D1AB4AB3F93C3AED7421814BB612C7EAFF0402
      AECEF9F978FC6B8BF48C53669BD980066F7919A3577277299E5C9D38B221AC91
      72067A364AE70407A06BC68C1BAD8FD5D4DAE5A78B6D63A95A4267D0E9C8835C
      E188F8A9448A54AA127B9A897F6E8E06325E49488B3C6633A677771ED58AAD4E
      871F9C29F320F9DAB70EDFA03AB300BFE96A32A408A88B5B149C34BF9E0FCE9F
      9F168CB8AFF27378377B577622BB006725460DB9F1C339F2E0793770AAE76FDB
      2845AF88DD0F03715C6E90CCDE9D1B6736E16876CECF89B8ACDA851911D7B9F4
      E1501F74821A99146486E797ED12785EFC6AFC9240DC157DDA5173341E0B7513
      FC97CD46B4362AD0D815C5EA874151177E89CE681BDCAAE8C106BFBCA24326B7
      947DFB6C59A32088A06D5C099E44B6104FAAB8FD44AE5B979E17A1F320E1DAD0
      5B815B970DD69C6E17C8805D867260729B953AC0B87A27F77EBB0CD097E4F608
      A095B491D7634B3FA45280D7B74FE23562DCF1B8FFB13D1A8F89FC32CE96694E
      6E77F7E411DB0132729FEEA310F9CE51F3224DF46F6E101AB88BE648B99D2F92
      0229185DAC8D23B4E1A6553B4CE0D7E27E0D010C4CAD3A22B5522DA872D686C0
      9632D5ADC2530E2EECE2F4421D156475A497E899C85357B401FABD7BBCF45D9F
      7AD1C6D577943417CD1E3322BB4024CB8233FC4A0E755E8ACD7AAD9AAD7F7935
      1A8F87FD4EBBD1E54D75132073CD0D5E0DD6F36970311EF7F8B164D550EC64F7
      A56A5D9EFC633C6EF18389479217A4C8C56F2D4D5583FED7610B27332FD8A64A
      77325C0F0F0ED106C766B3B93A3A3C38AC76993A838FE3F16AD237F175C1E349
      F55CF7C5102A8D01EA89F1B820A027D502202B52821BD441B4275B4416905AD2
      C376D7582351E8E4C7AB646356EF5BD3D87CE6BD549FEBEABA0B545EC5D373E9
      C9549605730DA1EC770F5D61B4F15864B513E4F7F503E0BE0576855DCC3FFE54
      B3D8680F92BF7B3F6FFC8180051F8B36916ED3B04F355A4BD85E1CD4A85C3475
      66D2561C2CCC193A90158D489EE9BDCF4CDA8DA67AB1BE873F39E17ED054BF8F
      94CC9DD9A24B5479B6CF3447E2731F801C2F1776657FA21086F96AEDBC5FA7C3
      D1B0ECCF50D8246934E31879E05CA83FD91BA361D2783C386B0F0B057E8C441B
      DB509C1214E14F1461C20BAF23753EEAFCFA6807EFF4F2D52EE6FA1D6B8F6F48
      93BA0C15167B216C770BB3C207198FEFF47480ABBDC1527BFF28CFC53B8E34D2
      78DCBD68B58A9B2C39F90BA0CAA56B75C593DFF543D38CF442D5D50BEA174318
      B317EC3F72190FF5D099AC0985583D05036AE3868410E4C449ED149AD338A2E2
      1D0AE03040EEA11E33836E526A7EA313C50DC0760ABD75E074B79EE8A18804BB
      804EC9DC4A1E32B29E8399B9E7E006CDD6874109702D8EABAFF6E67AB9349194
      1F252BBD24A00CA860F677895EE0A5A9EBC51EFC5594A583D24E5094680B1105
      61E89A8FEE4445B9D04B06D33806828BEC5AA33162E81369D7364E720BB5FBFD
      5CC7D54ED955DF05F7609D229E9BDBAB3BE460AF7A600C6CE9D4CCD0AA881B8A
      52CEA1BA9D0852C4F17878D16EBBB0ED1DC3FACFE3876E0E7A972461C6E376B3
      47CDEE24D742948C30AE4897166916787DA44538F5FBFAF98998EFE54415D0FE
      0E86ED2FE20606525A9E546776261154AA0EA162A4BC6EA45454F32C64B1731D
      FB9C8D6F5E754FCB6528AE88F86987CD855E5E69010C4DF7AAD3E88F86AA281F
      DDA04F2D37A779D2D9942FEAC55746E43065CEDE5D399B7675E14E4C46BD19A8
      06F56EA8E339E8775D6C67A293C0BB878CB75126E3ADE6FB97EA8C4ACF7740A9
      3A55A610D08C587C8951A2A2FAEE7CBB64C9615C0839B1F3DE9DB7464892F534
      B84A25DC0913644214F31CC8025539644CDE7FBE6240F422EF0F877850A37379
      3528E5798581238783B28B72D1EC391C8FC217C66352B004661A8F7F3BFEC253
      6434AE55088C8DC7CD7461932595FF5E31714C307B8290CC78DC3C6F39FC553F
      B6447C0440376817EC14967CE02CAEAA9835710425E64243195FFDDA3C3F2BE1
      63FF2466CE3BB4737541D9BADAAC4AA5109B092D14B06E97549F587BADDA4618
      F7ECD7E2EF8F18072979774FAB3F44E883D4D0D3A1E114C12ECFA496C5BE5533
      E474028FEA2142C7B1048DC135A444D083F005C0C10B80DDA8B457DA8B551A19
      572F66702025EFA8769D28F746CD51C5551EF49A8AA9A330F5CF06B950350C03
      60462BA7A57FDBACF9FB52F96D1D354E6442A934910A1FF23A88BA38618A80AF
      09ECDD0E08C9EE61BA0E8D909926BBB018B5B224B50BB9D544B40792852F5BD8
      04C71D460294BF286C0C104D9CA4DE5927FE461C2280A8F7A9062D91CEC81E55
      1B4C8C42653F15ABA516A06B3749E0DB4BED66CC4AB50CB849A5A8BFD25C5C72
      B4BEB51BE565CF578536A4D827670AED42554B6CDC065DE749DE507390F2AF5E
      1706D75FC4F3F8B67174F0131BDFC4BA9237AC51B16372DC010EFBB5E2E2DCE0
      ADD676E5C480806D23B2BC51ADCC4C26D5C4562F00295B5EB8EF5C36147EA191
      0CADD456FD73A57170C04BBC93C45E59E941CECACDEBE38AA7567A1EA3E37D65
      2789255FEC5BCFFBD62180EDC62C4C5C21152729AA1E19AB0BADBE14830907B0
      FA10C8A70B8930C067D9A4BE03CFF35DCEC34A6B99F324321E87132F0DC6173C
      94D3FCC663797227434E37364E860E67E488DA42449E6CE4F2833CF8D75DF547
      0E9773D2719904A354F7A48C6C02D6BAF63AD28BC0731FDCDF61B89C442BB460
      0232E4459994CA1FA1AEBF1E07FDC6E389E40FB9B030D4B7B2366C5D51318450
      4D82BD72BB68FFFB5E20A7AFA44C9790C91248F58908579FE44472B7BB220071
      B98AFED5590429FA3EDDF4F4F25F74B4FE75AABF46F7F7286922844927C35F1F
      88013E4ACEA99E65179B89E78838768B28B6B2B546411A2A5629CEC70EB7F434
      B805C127A520E0D4E434E2A593C1B0501B2921CBEDEB10BA8D1AE404159B4D9D
      06B7BCB97963BDFA575FAF2497482CEDF8BE1B2A993928FFD5045B6B09229897
      C301F6F42FACD093525CD6B72E38334ACB481BD79D8FE6A3ED2EC7AF3314EAE1
      9D6CE43227CF174951F9DBD43C647A94597DB6A38005074835497B6153F38ED8
      C61272CB724A7B3B9D06CC13626D983003C15A69F4129CAEB99318A91E6E6CA7
      BD34D3214F31492D53C81966AEC5DFB1CC14AB174E2A22F9A5963495668DF976
      CE7A8D0EB5944399174D02CD8F02B284D03CEA7B0A844B1DE598FDBB22731548
      6473CCF26815F87E683EB0DB8B6A6FB072E4983F02FF5E1BF5A90BA7CDA26401
      DD94964BA321D128F11A56CBB34AA533D56D8520560CA6E9063A973A7D501489
      BB8F20D70E2F5162D4D5064516891B3DAC888E53A11B70A36543E1F327D79ACC
      911DCA865C492DBB2A9AC44830552F1CA3B2FF8232CA8C53DB0120996BC917E2
      1FE32A7E8A2283DA73047BFBB0FFB9B07060A6C98B1D79A1CC6269631D0708FF
      48EF01084C9C626211638203244C1BCDD6A04371D8653E855D9CC161E7175E32
      21B6800440AD3E0EF3D314FF0BA13E55A9B6CF4F060D2A2A148601AE2BAB8E7C
      146655F4CD0EED4A1D4CB33F8A1E49D4EB2A277DDC4BE6C1B2FC0BF2474F4C3A
      3789AF2B2652BAA772E139C7F02931B1B886C7EAEFEAE8D5711EEED983D18AF6
      5D6B853C93D9EA81FCE8A8FC65BB41118002C1F3955E34951E7FA563F47416B3
      10A7DEB57966AAD2EAEE59D39104E1A1E91CD1118A6322B1A056F8573A376B52
      1CBEFD1EE9FD588E2D2247143E12317889CC55BE9D07C6DE559318058357A5EF
      9749BF2A3D4058DB161472E1132281976A076DBBFBDDDEBF277687463585A952
      E9EB2EDF594D376DC22BAA091AC7A3562DD9ED985FF60A12B58A581614D5EDFE
      18C0AB40DD93B385577B0CE304734038E88B2BB24113AEF1ABF3A9C4AC6AFFF3
      BB69EA5403F13F5452ED6007FE70F4FAF80D32622EE77FA7783339C8590E171A
      3D9C8DAB13DCE25A7DAC49BC411AD31A74004A11CF3B2F7004B764828C119BEB
      218F4B2D737CFC49799ABA420277C9D44E14EB6C13F9559F1B71EC303B4C0C80
      BCF158FD3A3A07F2C0793D3A51A339924FEADCDC9870B731084C8E319ACD33A8
      6632A89D35A0D5D927347477EC0F1AC57BDE9C54526457C5AE484CEBCCA40DC0
      42A9A295D19830BC9806088F1206BC8A532652A161467DD0E0A2F635C2DAD170
      A597A874FE579E55A7A8012699DF348294575EA84D92862FDCD9D26594357A7A
      23A6A297D2879CEBF3D12332B584A0ABC1099EA14E8EC31645B3A1FC67A9E1AA
      E6E1FDD63C3FFFB2C9C8001B4B16BEA06348AD63FA722D46735CD8C1530DFC99
      488A200EA8E4C531E107A93B24148C94CCCADCA89B00D5E1362653E30615924C
      4240408C9D6635E8341B54CD301E73C7F2DC02A47B53C45EB893238812A5DBDA
      6691B6325CC6492104C749D4687DDC6976F0FFBC58277309F290D74B8C982E2C
      8DE6F6B1F2E641E8C726AA36D627C80D6E9EE5ABCB1B13870CB393750050794E
      34822877E4F617AE7E708701F95E08A18CDC0BDAE6D4CED010286FC9C4281F1C
      080764AB1697710C52A7546D4BCE2EE37DB81D22705AF85DD1EA94E859C3B060
      AA4FEE70DC1FEC36133045821B3A4988768C5A24A2CD945567834F7D35371C57
      0BA29C3193EA2B34E3BD526BA5B5315BFF688D07E83F4246BB4F8C3ACAE8447D
      8E113F29E505096487BB617C85E6B089DADDAA881E6F55E42D150746D8CF24A9
      F8909BC287CD651F812122A6AD3B8FC295829C43380CFC818E98223F02052D2B
      A946CABD690F0E378BAAE00EAFFB9F671F1DFDC9F69184C4889E5CAE2BE5B038
      B8C3A457745A0C872E9CC04227CBDB8ABA244758359AFD2E8F4CC4214E833060
      CB35213E590B1E3F05FC272DF1FBBA4EA9BB18197CA83AA7831E69E9CEE5A02B
      A80CF8DB0888507816C8451A6B87A10AA3A5DD1C1D8FC7D4E0494918948B6918
      76C1FD1A3901424B1F2147565947DE3BB8BC0E25009498570AF615A7E42090C4
      167CB2519BE3B1534C6DC3C51528F143D7603A59C461F304833A2D38B0AB0461
      D66C819A3611C39C1673B3FAFA1600F172DA1F952B480FD4673A182B4815F0E8
      AC34414BD1173B48423D21690ACE5D001F217E02A022422AF9D6A8FBE39B7B50
      59361CFFF9BED3AB2F8255D97065AB3B225FA8480025881460671C5F81D24C76
      7972EBFC72F44C4F86E3381E23AAF94F947070E0963AF0A091160D453DD65DF2
      E26BCC15DFE30F32021D4C2E74C6C8372C20CDBBFB82F27CB883F4FC66EB62E7
      E7DFDBB9E379F6FCEB43359FE110BCF9C26D978B7A69F80B3D9DA0F9186A5AAA
      BEC4EB2FAADB3E7795FE7D80BCA9966491492CC2DC7A6146F0F672353B45200A
      764EAA5876FC39BB4CE5E2CCD128F547838BAFE1A7BFEFA172DAA80B5CFFF3E0
      891E7A1FEC5BAD26AE81261DE90FE7A3AA43E02CF5CFFFCB95C735B13127D818
      D2CBBB581CCF704059D95E9EFC0342AAD53DFDB81944EA461C1175E857C40856
      95979F062BB1AA8EFADD568D6BC529062459114264EFA2C73F0FCEDBF43E5C5A
      D5C13D40CB0724A70AD41339D59105AC011ABDA874902CE79399A8B3052355E1
      4EE016CEB895F76A822001F6F1FB2B0CBEDEAB66CBF5F98669BCA70D7E7CA7BA
      4C6FFE3F39F8F65EE9803FF0CEF54890BFECD3470BE671E5E90861402AFECDED
      EC850EA26F18DB773249E294CBF3883B800A972580CA7FCD1F865611DA35CB10
      4A5AC1C8301C82C215F80E6EDD37871647E16B83479B9D22CA833FF8E8FFB219
      3D7381A66AB0F610F27DF01B9D5B2042B6699B373F73A3E387FE4C3BAAF22D7D
      FFD06763E329A5B6F6F4C16F9C98ED1E28F70FFF77E97582B4E9DE4BE6093F30
      C9E2E5FE3727F4EEEF5F3BADF4EC9AFA1F87FC7FA74FF0AC97EE593B4DACFC82
      8F7FA689B6D7BA4AF464F1D7E5648E0E55DDA9BC4F5B559874E0518989AE3B53
      756A26EA581D1F1EBFC991F28707C707476F0FDF562409FAE1E8F521C62F8462
      B3DF7D2A995D146D9E99122DF09949A5C641E82C282E4C7D156393D810206FE9
      A54259108D127CD6A668E75855AD6D4F908019823CE2D895D87509045EBAD108
      54FA9AE460148465220B560826347A32355700B19ABE23CBEF4E1D77E616202A
      9F36F54127D94E2F208124B022235647AD7AF895FCAFB9F6DF3C26AF7EFE09C7
      344FCB8CC7BFB43FF52558424601F7A1393A387A7DF0F675E551D057EBEB9E6F
      F5D9BFFA96F3FED4DE3B651F3683BC73EDAB17B9E5FC42C5122AA1EDA3924C51
      9A1E99B9454081C2184F948D459F983C91749ADF5036265FE525599727C38ECA
      FFBCCB70600A91E4C46AE288C8E89531508882D738F87A4F97473AA2E4C7951C
      44780C3B3E10D5E8254B9E5256448E3555A851AF49F472E8B2900D61ABD87158
      E19C242AB56C49106834D3E073511DA6EEA0BDAFBFA8D3F34BCA45F74FBBC845
      BB421D26ADE446000B15ECE2AE6FE57165251FEA7FE0BAFF5655A3AF7E46784E
      FAE110F35D73D4BCB8DB04F5CF70139CB6DBD3A2E7C836947FEFBFCBDBD30176
      5FFACE8652BCF7BBEF954ED0F5C33DA278D63D1E04565468919CC53D85152EA9
      84038002A799CB7C05D12C5161700D8A0B39EF52E8C23A5712EEDFB0BC1F545F
      DB7ED27BA5AF2118DFA9D190DE023FBC577A827B245F7EA726D6125FEDDFD528
      CEF09DC9909459F92FA7E8B4BCBFBD08F7AA4A5255589A257A79FBE5A16BA238
      29EE231A13FA1434F28F53FC8F588D675F04ECD33D033FB40B097F043F41EFB8
      43B5CB2C28C93A3126426744862C63479816D77DDA5958D2C6B33C18773E91E7
      1FEC6EDF5FFF65F6FDAB9F5E8B49F3E60B93BAF8CF9E3AA0984DB9D5F2F01A16
      8427DC47959ED96D5D5E6C3CB30B522172502912AF213E801F2656EF6A017850
      95524E6C3C06456D190FE5CE0C46966093E3DDA8BA316FDF3E6C13EE60F751F0
      ACD0AC3943C8C891A36C12FAED32125386BB913628FA44689B62A9EEA02F0A79
      D8FA98EC14AC259D2B346E807B8737403103795339CC2C39858BCB51A7C42D9B
      2D4B37689744E5B0FF0F49F3BAAEDFDF64BE7FF483C7E353B098E5A6159C4DC0
      271CA9DD4EA15958EA079EE749B9C90EC41E45A8773CBE68F6DE6E3518C5EAEC
      B2109D53B0DF6C10E79682EDCEB2DE65E67CFA3F0FCF878DCFC3F3F6133C129C
      3FE33131FD14B63F001245FE67A7C0FD59F9B9DD6886B6242CCD767CB45C13F7
      68D4D0EDFED07F5E5E9668BB193198B70C9930DDC1135C99668F48DAD9A1BA4B
      DE54238D0EDF87D19C79D797623EBBECF8E0F21FF9E0D8E91D9C2C7E9BD353EC
      84ABB0C17505A50822483B3C15854AAEEF5551187863E681F7245240D8FFDB24
      C105384A0064000A0934FB1069D7A38618750644BA46D5460E6BA27A7AAD34C5
      05BE81D1785CA218655C39052A77081EAD97769710064815B1A184144C037F5D
      FF1A4DF9E3A6D8ED9D0D1BBDE60839BCC2EEC8F5D04E8FE6CC202962270A7694
      5C5CCBD68FAD6807AE63433D5E86DAB229B159484E10F8EFC8D82C09D7545E4B
      277F886686EA6F8447921A37A222D8DDACFFF75F67D6BF7D95B3F8944C4789DA
      EC6A3A42C8916EBBCF5740362871FCA5357219DCF541239FDDEE10CDE1F21401
      DED6F9F09FE3F1557788D88D13B93015993056B05DE331905E8EAE7BB31DA228
      08C2BD022A6C7555E07DAEED31AD3648A0EFD3F495CE50F0179D21290D203576
      9B2D49D64E627B6D38518AD6E5E45D093B1F669DB70EAC7C68BF8661BBAFD1ED
      774A1EF4F01E8F3B2C77F39EA25918AA4E942D9E2C9648ADC237BC010ECC529E
      FC71C1C46A11CC1EDAB8E22A746E11C520FC7E70BBABEB76E782ABBA1858DF77
      C12B1DFDF95F74F45D331E8726972C928DD5C2F841B6D8A9F1B4F4495444C0E9
      2007E07F9C22E1370D6EAB259158043DFDED019DE9787CDEEAB4BE11AC7EEC03
      61209E9914B8987EA8D7DC1F4FDC2F4EC282FF79D46E16F4BA15950502ACCDAB
      5E1FA065B830397C112334AF7AACC75C0914733A38D4A6731AF039100D27290A
      EDEC94D9399A57BD6A9B44F90DD7E9036DE546E3F1E733EA7D348464AADE955E
      E21C4F7F000ABF8373CCAD93B38B77AAA5637DA323868AECE03BF0D3D12C8973
      EFBDC1672C3F24E4EFD4EA2541C51C8C7110AD542B62201BBB9BF4057BD633A1
      31CD34D5DE35CDFB1E1AE7831DDEE5CCA4E73A9A657A666AAA9B5C98DBB41506
      CB739D007F99D6609E44DDE832BECCD2CB69DFAE4CDC8C1736FEA01301DEE16B
      B81A26EE462726494FB220F45B7AB1AC516B96A41B756E97A8AD0C4091DE4D64
      2F9A373A0811346327B49B7C423CBD19A6AD2CBE3123A9F7BBC358BDC3ABDE7D
      3B22605A733B926A8B787E04689EEBC4745453E7C7E55F1CD7D4F9ABF22F5E55
      632BB43E187988651B659B397F6668A2593AA7050CA62A805E620E2EFAA796F6
      04BB9C8F2EF8B7063A26020FC7F68FA1AF79F7935D1E2E6CB190014AE35449F1
      67BADEF9A178664D35170B8B8ED9D982E4768DAA09E74673B74EF7C340A7E6D3
      524A5B4BBF6BA3786D65F4D2466E6255D9BA786ADC0E0AE27CD0BBACF49C4EFF
      F4D865E6B4F27055544A7725609821820A3870D4136E87A93A89C9620D4FAD8C
      16F9F1ED33C8F9E132630E93AB51E757E10E17E84C893ED9B7288577865150B5
      5E988C952B890D110196845B76C07C734BF489B3B54995426337CF5B1FC6E376
      6738524B9BD0421DEC300C1AE5482681EA808A9EAB9454DCCA7054C61897BC6D
      FFA94230F4C87E968AE3DB20AC031804E8BCE79C7A548E2D8436348152EF268F
      1A73604A3B79F08E8D5A9E5AB22C4B7D4F1C2A38996BE4864A1F4A001D5BB829
      C301A1B597EFEE84886A5EB4370226AEB386444E1A0333D5E88157E3196C3A43
      EC24735481D795889AAADEF337408591FCD459C80E432CC3938D0A9E0A3FA35C
      19FC74E75158B74BB270B9AAAF58CB2DA19512789E7B9E557A9A78DE0D6E22EC
      2B44715851209253319FBCE96C97EF0B2155111D26BEB19AEA7D688F6A1440AA
      C9D01440DA76CCAB0B0876CAC94567CF9C1AC07C867C7078BA17C3EB207A5178
      199CDEDC29A84C2554D476ADF561C050CDAB200970AD8988C1759D4639FC4EE3
      E48FFF1574F7DF8ADC3E429501B6C9163A117D051181297BD64718510551B07B
      1861F6D7456189D086B5DD59FFF2AC71D6BF3C2D3582B5319148A0CC75EDE810
      2A0F45D05482E89588194926A4D6C5383BCBC0CBC9BC80D8668A275AB42B33D3
      0E622C5D1D25760E72E2AFB2B53C6266D8636A139DCFC8117F40C89BBC6F83C8
      2BA2102E49AD8D0CCCB743C8DF9ED02B40CA19609DC35D7D75B276EC14B07E50
      DDB29A2381FD7B1678D7805C11DF24F6CD95FC561EFF28DF2AD74D12F10EB283
      080E33B7ABCBE954DD1C1DFC541537FFEAD573C452A5ABE360744AD78D6F9B6F
      3D41A29BDBB4106B9EA4D453F4845020AA0B1674E81C11065C585BD19722E09C
      4A88AA447942648120056191ED243130E4910F5BC6661ADC36926C0A3620EDFB
      0DE98B83D69426A918F1EFC7F6060DCDCBC03BCA4612853EDED221FAC492DE51
      A37C715746088FF386BC2F9ABE6F23D58D7C73FB22E7617061AC8951C43DA217
      936096C1A0D3897A2100A5965D4C82883B1EF3F777B4BE1D529A7DA6C2C18351
      29773667CB42D82D23382F5D3A1B1143D20EDE04761709886E5B85D65E674BF1
      EA216F2ADFA1E770B41EB8F8FFE8F6D5F985BAB81A76A40B88BA79737450B155
      42AE0CB6466946731AE1E6E8E0D5C1D193BF839D47D1FA2C0B521DAB9B370787
      6F7718E1CCA4141C6B0E9A21E48B378F028F00B08CD504840CB119B390F2BE1A
      11DD5B340442A93D1CB008C87E2A881EF42E77F1571DF488735DA768C2D2709C
      15442C565977BF8142C811DDEF48AABA1BDE4C80CA2A90D8A0309C11C30AFF3D
      011DD51D2454254369FA7843C9190EAFD5C559257A1E1D7B7394AD6FB26F69A6
      D533B7690C4E0C8A3EDCBCA5DFDDFCA44E9AC79CDDFFCB18785E1DBE7E0E8930
      3CFD42D90055A700A374D875FD764BD90769285753D5C7B9EC5D02FB097149CB
      4C7008152111EACD35961DFA8BC175DC0ACE4419770CD8015F53E8B161FFACED
      FAE3C97BEA075EB5F246B94AAD375703BEBAFC6F75A2BD6B1C4210FB0CCF8575
      4C78C3190849B60938C270642929878213A283AB6CF21DBEDDBCE1ECF22C34FA
      073D1C897FC4B37FCECDC98B7E4BA1C75CFC70FEF7DBCF3CCA51E18DE1B0C35A
      E47292A4DA7334E1A955EDCBCB418D923735351A743A9507CBF78A0B80F29007
      515E1797ACF2F37F2A3D1F67F0EA92983461678BB741440194A99F4D72747289
      B8AEB2837BC49B43C3DEC5700BE3A107738C18C8F8F7D55D2D29D67DF5053559
      ECADC8E9DE5EBF4A1AC2FFEB5CE943729A20C11CC74AEF9C9237287A8B032F55
      9FC0C23142A425E7FB4B4D8C36A3A15A9828ABDE7417C31F6F0DEFB087A7BFF6
      DB39BE23F255EFD370D4E80D47A745BEB9F29888FF715C526AF952A317EAAA7D
      8A94B62BB945CC8404271A77D0E1E2BE8F98A0285CE3EF54BC76FCF3EB4DE935
      30D2AFC2F17984689CBA0459972F96FECE62ED986B6D1FF0923FF5D5FFEB7CE5
      CA83BCBA23E75CE864234CD326AEBBCCA8ABC0AC1E7D078AFDEAF37E3D642239
      3C2E13D6523B4F6CF0DCC863C260825E075236E1BA4E3E6EE3951F888623938A
      1E58E2207B685A644BA3B8B9D4497399C5DE9CEE583A8F6D3693373D00AA1BFC
      AE71EA655236C55F60048D24F6F97548DCA12447E621B4B03A0CCD0DFA913C34
      A785459DABC711062F67ED6441451180A90ED0854585481323B347C3514A9748
      9B39BBA54191E496B0864AF4806A10C5D77649304670CD8224DD2A4EBAC3F540
      DD879E00F9E43D5ECEC28829761B9E09D154A8ABC14353A5A8307BE26C1761EC
      9ACB79CA8A70AC5A9E4603C9197DA1861F871DB564173548E4BC020DC62FA141
      664C0A0E6D0A4A53FCCB2CF7E3B75B375D648AC0B1183C57CA1C34DCF5AF3C1E
      55AB5C5CBDBB5F7A4566853C3039E2BC8ED5DFECE77BDFEC723A456D551B2356
      7DF44F87F73EDA812FD479ABD36F345B9D7EF5118ECB23D4C8FE73A3E8C84F3C
      BD34D51FFE6A536F951889374DEFEA23903F18249E094371A5A4CB322CAFDD4E
      EC4F923CF8427606D18B1510361B096BE526BBC5CF076F8EAABFCC8FF23252CB
      F2895D30C9D925EFA950815C975D58E488E28C5C08F7FC9F55FD3FD4079DA8A1
      97854B3EB23B0C405E03378B7423BCA9158330B42AD7E835D5D748423491564D
      8A4230CF4426717472A7677D62DF53FFA9FADABBAE77A3EA6E3039C1ADD6A5FA
      95B0C8FFA15AD6C63E02B1E20F6036D250ACF5F165A26E82047DC242BD46C485
      EE4A4DB927D17651411C49CBCA5B0F69F55BF98EFFDA3A6F51AD6CE7FCBCB275
      B5253EB8D64E1203152FDD1EF7C562FBDE0F12DC867D555789C3AF20329860D5
      2C5B45C9EEEA78F21DEAD8050E846E6C4064A0855A26AA0C1D521FEE3B2ED9D7
      0DC2FB1FBB777878547F7B7A8A827634FBE45E657951F57D03E63CE31412D54E
      8838BE26B4043E787BF40D3235988D36BE4E94B9D56455E2AC3A8EBFFBA7BAD1
      17380F1ED224B6A6707470B86D251CBFDE5EEEE39F78B9BBE80086D4F6431366
      62FB5203F84D42A55257E7236786226995182A129E98CD4FC802D69405846515
      504726989F64784E8CC48225A410AFF3E0A6641A616602EF1D237F84F0F5066B
      A776CB46939D6AB4F2264C0796385FDAADEDFF7EABAAEA8D7EBD656B2CC09902
      8CF806EA82533FF0366CBC708BA7573AAEEA7E1FBF819E1DD0CDE7CEC2D2994F
      5D7C3A3F47B747E626CF3B313A6A2064105A71B0306736F4AF020BBE8646F977
      1B3F5CD80862A36A6FB81F8E8E7F84C4234AD34BD9628E23896F8CA43235F383
      BD006BFB579C86FFCA8169780377A7EAD1FFF7FAF0E71F2B33A71DFF08753E1C
      7670F37F7CCD92EC8E747C52194C5CB76E88A09CF423EE34E0E2E02F440E734F
      C798DBFECAA5B1917A753C09D2279D9667A36988085192EA344BB0C808FBE6A7
      143CEE29B97E39A1659EB77DD2899031D73F4705F740FB014F255F0E2A3A6554
      14D1B27269482924FE0004B5E2842E6182B82B03B0C30796C5688B10AEF43AC9
      09B708FFCC4DC809E35D6D1A532AB59CE0456F4C88E5CF97A5A8379346875BC8
      4026E5F2A8133413B5B375BD5178A68E0E7E3AF8E955C53BF395E98D5613383C
      A174AEFD40509AD89DA2947A30D5133D354F3928B5A12A814DD48290DD185176
      A6D43CE7CE01E71D8DF44D3063472D8D8D41A2FD29A7F862BBD9FB0B9C2EAD22
      207CB84D02CC12D7BA862349DC2899672D7FA8C93AE66572419A9870FA689DF6
      14E181238A36BA16B0E02331203D6285AB4E8FE9F051E6D5215708E820788BEA
      EA3477F1C829A590F6B7D8431EF154065CE54DE100687F9835E6B18A3FAFB5FE
      A2563AA6B5D0139872AE3F28112F133D53E591DEE46B52E211A0D2FC5D43326F
      7ECE65B0B1C8DF329A9D5A692215444C9AA213BCD8E076718141330CD0B5E1E9
      75015BEBFD417B88C189E9A124F11E7D031E650537A3B5EA0C7BDC21178D5DD1
      9D3AF00262E034B7FCEF7D47ABCCF737EFE7E20C56E2794DA5EF6E61BA22228D
      BB5ECA0790379268C44F276B71A616008F4D88A790FE405065360538ECE87E22
      BDB48A83343511BE9EF3868B31E91A68E4FD4861473BCFC61338F064AD7E69B6
      0ED4A90E42E91DED0338AE1646439D48F3540E0D1B342A131B3E9845AE3D766E
      A8D3A783421F52D405D37CBCEDDDE7DE2964E03BE7EEA10DDB2E43156EA9FC19
      49E1F5612B491219BF5A1F56C77943F54D647F6CCC16262CAF0AF730D9D23708
      FF52A2ED81E28A6F4C000CDD1B43BA5ED425E388D902797A5AA6CC9F83DE09C3
      FC2D68B3BE59A4526946306549918143DC50F39FDC7FE38E52744C405508CCA8
      9E16E7AEDA348626CD134177A743E755008D5881A245075A4380CD0E17CFC6DD
      76B5D17333E4C1E18B76F2A5F173EAAE79309B438ADE08229D9DEFEA9B5227E8
      6E4F5F1B37A1A58EF50267B026722B4F5A2530EBD7362BF54BC64F79BBE41ABF
      02E13E202D18BE1A5FABEE0880FDD271921AB1CD0B289D305DE204157DD02893
      22773431403CD2E2E4552AF7B5F27B28C8F19955EDC331190460A6265D137686
      44D4E65403689F29C520B84F97B94D734BD195FB944421F926DC992F8BE01340
      45D898AF38C177B83AC7A5BEB724069BAB85D327F2759209C35C16995BB45AA4
      259A6B48F7AD23512952A7BF1FA050D19A383C7E9BE7A7479D612B0C1630187A
      16AE4A43F5911F55E75C4ECABE0939955A6AEAB0EAA0922FBB7F956D33041D5A
      4E2613A085A30EB0AB63338D4D326772BDBC771BCDA54E447B95B12DC7AF91BB
      393B39ED955B7921DD54073E9ACA4ED5706E4CE568CAEB57CE5002C5D178FCF9
      AA39188F992500998AA8D1D38CC9FC539D85D2BC04D788AA04B2E0F39EAF951F
      FDDA3D5A787D7D6E2D74C71FDEFDAE3CFEAADC4FECB26D5F52325DAB858DA81C
      4087CA4CA7C4F03E253B4A81CB7F6EB39820AB0BA3F64ADDDFF76B4A87888C51
      1414B743DA744262DE69360F9CBD8921B128085B7CC2C6498D9A34E6315BC8FD
      DC4C2C9B52F94B4107A47372EAC8B9A3D6B85B80FD6D716B61FAC4A92CE74608
      22EF2459A34C0E5EA59E4C8F0A25057B9B6BC1E43DC944189E1EE15907E6D67C
      47F85B4CC4EDD6ADDB0FB8B3B3C7723806260CD0FC07760C23CE9383F4F641B3
      54265A2BB364D3020680632F97B1D5D21B5ACA2F4A1D7F44DD2636438756B6F9
      C5C8CDBBCE82069A7B213B83BE20452E664840E08347BF6717C62B39A72393A4
      08751D510382FCA743D561F4C643AFFEF52F63014497E627A19525A95D1C0451
      E09A1F707EC00F92D8CC740CC93159BBF564F1EC2C69EA2840A68C5B84D4BAB5
      825D49ABF5F87302F3A0BB58E03EB185904FF265C225687772AEDBBB9E9F6F89
      7B51215088D2CAF71C1C5C203E72630ED45970039704FDC0833F4C8D8D31ACCC
      8FAFEB1374042F724D7C7D605A49815AEE8FDD6D71FBD0F69E2230591FA1C068
      68D22D82B3AD37B98C360F1EEE31640655AC50E4DA4ED5049C1B1C7E73699BA0
      1450A1ADC4F9CF70D7CD021C0EB2FDAFB1536FD4D989208605DD8459F1D752B4
      0024797874A816419421EFCB45BB546A7CA09A2158BD677307A681719A409848
      47F6D8AE50D340D56924EBDCC40304D0676CD7B21F92A4483700D9ECDF04423C
      0E8B00E56D74ADE038435573AA5465510AE014C514A5F2D9956BB94128A66759
      A2FA8FDFA26136491056436E1D4B9E2D1FBC6A882A26C557429D45DE1C0284E6
      A63D1834F7EF8D64F0A8FF6F10F1390571075565DBA94A0C585092C75F9E8F04
      21E8B0017BE20CD8D3508332979B950222115060E261239DC1727130B3A4BC52
      C31DAD8807D98BB33488D66ACF61EA10EE5A2C03CED3ECBBB657AEACAE64AAD7
      94260B5EACFFDCC6F6796EDEDC0600C915A4E7818FAEB1D4FD8A7C9BC8204C7C
      038F55EA2CA5C1166DBCA7975CC84EA55C3C0B8C7EA0BAB8F75E9C518239B590
      0B1229C167A865C8C4C0B31299616EE73A4B30D27BC999C24A155F7981A39845
      1422BB3114694812E0B0B91AF36E1FAE87E401E7504FB9BEC0F5A7E9E9E512FF
      DBBAD38F6D739F50C786ED716C51287B70A130F768295DA0970DB577CD017783
      1B82C098B83BAEFC76A1A9347D91ABB220269D502FA8F484464F32BDB3D04E74
      58A3535C672A0B4DB597795E3D912AFF8DC0486EE061FB7359CAF1F483A24D07
      E1FBA2CD3381984E10A33E5D7A8DA3FA57AA21C411AE165AEA01F48103823243
      EE754B4EC2D0A46AAFDB6F0FF7DDF3ABC547C80E23B80EC034FC8F3D00D3F6C9
      2EE39F9153DA6D1C2167527B1F2F9A3D7E346545DCEFDDE1DAFB381CF6761BAA
      E9FF5B5349C030D24B75417DE9F72EF261F1CBBCFE137F557BC3D1457BC76594
      96CFDCF498081E6830F9B56B02BD87BEC74F33923C523AA4721EAFDC777A6F78
      3A1ADC3FD443575FF05989DAEB7FEC5EECAB6664173AFC866127C97A8E9A6C7C
      7F9CFD747C74FC9FE03E1380067A46E0104FD6A9A94F6D5CC73FA806593ECB41
      0F7AA12C5A8240DBE36C91043AEEC439BEFE3244E11A78C439CD71953DF8DBFB
      AA05E6FA87DFA93B65DFDC45B12494ED1381A73A0933B38C0334850D96493D37
      EF2826C1952FCB4042AD51110617F878F9C3844ED1845194DC01043F967262CB
      BE233F39F2BF3174E2C039ACEACB6D26D9EAC29B3B31E99BE43AB5CB03D5B24B
      06DACC4DE2F288E2383C385C62CCE2FF27EE6D9BDB46926CE1BF82CBB9F73135
      4DD1F24BDBDD8E99BE21EBC5D6B664792CD933BBDD8E0D9004298C41800D8096
      351BBBBFFDC639995955002992A2D4FDEC871D3745A20AF59A79F2E4C92A2CA1
      467B8A17CF1D6E9B329E50E805036B570FED1125F580000DBC74B206C5038C42
      0904ED50E83805E16E399CF17C5CC7BC475C652EBB1CFCC1AEC9F08AFF305062
      454CCAC4458340DCBA38556B350646A4D614429E28279303826798AF98A615D9
      545AAB13D7575597F32163A770DF80A8D28E20DB96FE4B1F991ACAACE278A061
      8B1FE037DA2B7D4F4286297D7B495DA0D8D8289981FF844A778EC5469F6A4800
      067E958819E94E9CE792FD9E65413AFED7443250E5162ECA74C20C2192D4EB85
      E4AB45C73FC9E2017050FACC54084BCA69D4095AEFBC423178F566E8FA890953
      B961A213F735CED211600FBD65EDBEEE45073F8B248E801B7551645A851026AD
      3A2B715515C354266990D4D7986AE502C04EA179EC8373F2B2658275D2F0AD65
      ECC85A8EA7C43DA27D29628B43ACD7E2A31530B69DD93D62CA848380E51B3829
      7027792E4D0E78625F84623DEC0B5B73364B624A19C14A149ADC59317AED3242
      D231E04CAC9A59019C419CDF0CC350177628B1246CE97A25104E9D96B0293DE2
      ED4EC1B1F36C1A7FA791B772EA4F48AE149A16974F8A034677BE824E3804D5EA
      865128B148986E5FE31C42965A3868845901A1573C12E9D0371C20844DF21B9D
      7379949C07065D79473C2880EBCF995DDBD0BAE0399D6AB49B000702ABF411F3
      8271915C9B73E9D9F62A72C8E074CDD511CB6EF82B6993137ECDF9817A9EEDF8
      01BC7D44EE6427F33211A725E309394CCBE15CBC9A5E5460023067AF139CDDA3
      98D70DFB31CF31225CF7800CD4D74DB36CD79C597F4E6D7E581FC4C411A3FD09
      76641D51257305B283195178ED543CE1558BE4639D66E9BF6C37DFFE544D158A
      D66146668BCFE6E5AC10CD1EF3C71BD39F560CB38933302CE6650C21B4E81058
      0042DE805894D21063628A3A1D4649FE352D8B9C8A2112BC1CB2F9E6A3E9A215
      31D0AA14F74718BA9155314C7A603022BA8709AE93324B18DF97729FE3712A6A
      424CDD97BD8DFED83E6E38AFE2F3F514B2A5153117DA53964E53A982D313B786
      9600BECBA41A1514E1A2F267273D1D5161038031C892E9A2E77FBB2D19E08D48
      6D7B2F10485BD67D3114B7DC4947E2DC204B118CE945A322713444E22A0D7013
      52A48D79AEE06D07D38CF30C809EE6D519D2DC09BB7C4424BBECE0110D781D20
      3D4E883C06C3308C962F76C39F37DDA43FE9F7A2B3F3A73B3D6B533AB72B09B7
      D362E456340182BBD9B9718614F3A4FCAA5894308B42CC83F733C575149A7031
      7EDFA80EF7CA939C039940C0075C4281C1E2ECE65FCE68A56D8955E5EC1AF762
      08CAA49246146E12144BC4830CB4C1A364951202C0102FC553AEB1EDC8EA133C
      7D64869736A78C3BEED1007B3180019277C05DAE837D156715957FD27C9C9414
      0034FC1CDA810E9F91DA896223E645F4DB3CE62E89AB6A5E322460E85430DE96
      30255F15F35ACF6DAE6F8B23DB8485515FB6AB57BEBE9C86A17DC89A2B486E94
      D0801543B8BA2AAEABBA98CDE45ACB6FA2E49B7A1A4B8736342F709E70BA01AA
      54753285A2991F18E9E7A32ACA92493C849D3B4A9845EE8094D29528432A2C6A
      E0C97928DC007D0F223DA9E044CDA10AE203045A105F2FC62EE6D4744A642C1A
      F67580991FFCFC747D7A863B5DC075924EBA0BF69AAC373068495690183FF440
      70BFDA315381527403F54DEC392E3FBF1F651FC69582CCA55253AF37C7544F71
      98EB3EEF9E78F6124DC0B4066D550E34458C8A7174E241CB3616AB202C20D96A
      678DF9AEA458D825C46F684B13EEC07CB4580A701F76EBAB38DF4D470973C2D9
      D0C8D0DE9E8BDE08BB3E9DE296AE5AF059E65FF6D51D2273638D88EDC2FB1F29
      685697493C5DE9F7374850865ADA61861F430030851A24B94BD68ABA4C310EB8
      4919CB0611C5A5DFE64934CFCB0480136728CD77790869669A7F48A54F19C639
      16DF2084111C85508F2A3F2ADC90D52DC75495343B0F73E406C59EB8ADC7CD5A
      4D9760D9C0CF68A2B50D535577327D3281ECE8186B47698F78B7400EF9CD2FB2
      8F391EEA939F04815E47CB0C3165C734E4EE9587D1A26E1EFC8E87666F0ADE75
      BE4B1D1F29A72BAC1D070CF86A0ADBC1B8306BF4CAD326E590821724EE080382
      C0FC17101DC4022577E03EDC2FA8F5CB5CB50028DD6F4103E2223786D50D98C4
      DF725379111F875510AB686FEF1BFF0F3C325C90788A7CE2BDDECABBB6E2B66A
      8257A35377B0319B78E3AAA57228C531C4975F0E2DCAF878A8AFB780879A23BC
      728B8AC25970B26DFE3E966CE780AFA28C4C256DB172DD2D997A42C810FCC700
      A3E039F07119530DDE4218C50FD46F2BF3FB3626F9F1AEAF71423C4B360B6C2C
      076ED1A7533A61490770CD4BB62F18E25DB9FE08AF1C81CE4460084444D7EC1D
      4C6F1C2AF6BE67D8C3AFC5D35DEFE5E81B7AEAC68839D5D1A0F8164E04FB3C2B
      8BAB14D17F856D43BAC7DD20629EF255E89DC2252338C4DF1AC95C7D56189D2C
      8BB720EBBCF1A8C495AF506B9FC13502A54A97CD5AAD0DB04E9D03EEB1723FBF
      C2439DD705C2D8AA71381A6D0F9F7398A20EB5B1ADD71D2F23280B89FC409287
      E5A675B9AD31CFD41B8D04885F8214864106E3A9286F361FCA73F3FF654C759B
      ED33CD261EED9EE72DE2636BF45E279239EAE3CA0E5030A6151EA886075855D9
      4D73D47AD179363A8BCB4AFE0360560DB906E246FC68DDB09A6DA472F9BBB847
      FAD1BF17733F8C00C0287D0A17E00BBBE5AAB05B54D70FF0DD983B077044240B
      7C98CD41B2C12B8AEB8BE389330F60694515B625DB9760840A79888FE79C5C3E
      51430C218B24C90D5B02323C835A604A22171004C1F76928E3AB923A459DFAAA
      F6E10CE78688D07AF4B6B806BC2737F6352E9F198F33A00BC5183D9979221852
      A729495DA7353E28018060877ABA4A759D420A03EC49F68E32D63860019F2D11
      775FC23B099981747680D9C2439F8B2DFC4F6C22C43AB45C353EA75FA27C4798
      1AB89CD455CA47B1A1E364C419062423AEC336B04137900C8081CF53094F899E
      430509E8B2B2A5B2AC3C820B780C655990190176895C6432A006F0DDE13CBC34
      E9D5E8DF40E0702B7B735BF2495FEAFB28AA75A1C8217BE7B8CBACCC4D7CF615
      976868F10AB9022E8341CF18CDA38B330F79EB3221F567908C41C885518CAC27
      87A2F134E6C8CB76A6163A0D8729351965D5575117BF42E7F4093BA454C9115E
      45F57501A4B54E7330AEA58C0FAE734B15C09140E71D6E5496B421749ACD15D6
      3DB6323D2131620DAB145D3B542977C936F8821083F87E21298439889B1BD54F
      652A30D8E46106CEF82B320B2CB9CB59BCA0E830ADBDC71200BD28A987FD1E47
      106E194BBB9BCF24207F6BF4021453FEE66E9A66C4B60136E3EC106E9DE47398
      4623C92EA5E39A8ABF3D8DBA01C8327F53A62361E0ED044106984730187883C0
      BFD353A6D4A190FE914D1C5775AFDD7B19799A13EC759808E7BD03B7F185FAAC
      A0217CEA5EF42549E872B2C35873F27E3AB386AF60D93FAAA2126C3CF0ACDA5B
      81C32186255218463D8800A67512C88F7B6E9C302BAB28B6FA602632D383A859
      5CE28F2E4454DDC017877B24EC530578E639F95770C1CA1B9B20DF046F410E25
      3AC72755AEE15E74251C3D3E2A9D0AD9902687EEE18624C9F2312D93D6AAF111
      7B6589113DD08E4618C86583B0F91E79267BE4C038CEC31B459A067386F15F45
      EFFCDA900E6A5EB6D99D5504A05208D29697E493B8D1795443484A7AEF449C46
      732E52C55DFBE24680F61901792923B8A953E829902D9A3390EDAD7E16F1BE38
      EB45739021938A443F191B2022C9342941477D2BF11A0F73070033C14E457D67
      4860912B5750D95B27476F30EAF19901818109C24B2BAF5CD1A1F7EC0DA97003
      2C36068C0540262B26BC7C84770AE8ED95AD9CAA1731AA2DB161B9E66FED6B2F
      B86EDDD11F57CD4B91DBCD5DC69687502087A962246069E66895E8116E39B63D
      0D15E0C584BBEB521B028C5D1F95961AB40E0F77663F4E6771CDB43916AB9424
      B4719990ABA98CC03B9070C58C7854C1C6C987ABA3247994494AACF4BAF29E80
      DC15BDFFDFAD9240ADF35DB15A3212A40653471A247932161E451AA42C88607C
      5A47495CA5E45D1851F6A6C13FD03822DC34CFCE27BEC810AADE8722D2A94B6C
      56029B51D2921EC472D183FA820ECC4A885E4A209EEE97685CDA59CA135689B2
      8C668861AC01FA8D1379AC96D3A1E938446752C062A5FF9A3CFA6ACAC482972F
      FCBC1FBD979A3204D7701C494110C759D9BC8B10588DDEA7728EF3C82DE3C9A3
      FCD16159CC3C44FCCE4B5B5C2E93B6585CCB5C99C56C374B482A2973B927F131
      9B64AE3EFFA89F4AA6DC0EB550A219CFE8BA46EEE37B133AE0F2914F2134AAB2
      16F6B480D903E71F0400569071661C39D2C9B8DEC5E5B4EC8DB8F5709571EC2D
      2624CF6FC2D4623EAD3C65E1ADE2F8A8996652C632B8238CEA42C6EEB2BE145A
      58CC8E23015777032CD8C43010749794793F187D3A56CAF484948DE0F23DC145
      2C68C9DE3874952DFAF08CB09829492FA61C6BD26AC11377B4E21180CCE5198F
      2A0381158526E8DB1705FFDD0608C58A32108570A3810C84141FABB06373D060
      C07BD95525D8201D86660EDE08BDDE7CDD9B28DACB179B680384DA70C12FBD20
      80E667E0E44142A2687161664800B3E034232BBC58782CE793689464752C7292
      9296824A0C5F42F6A1FFA1A0B4383A55B65CD19D900E6069A87EAC0637418FEF
      986517BCEAB234BB71F1F2C5BA3C3B48B1DF9268D71A6215CE43F80F5BBB888E
      865FAAA48C25B90D0B3FCDE7BC111AFB33E8634BBD08C67FC4027A6EB9AAA58F
      8B9505DA749C375F36974717CF5E45674559E2A819B985D1C5CE23B8161D5850
      FC66657421C80C95A464584F752B6912CD455DD7DC8EE64E86248D66E0DBB376
      58E8A7B1F2EE9CE7A80A4C6BD68CEA8F49684A147D7A9A40E457921F31B79082
      B8FB6E9D54CFB8317679F8B93505E201AE05485D0086EBB556D8702EF198BAE0
      506112EE96D1B93F645A87AE273DBC0EF5A01FAE069ADD3B51AA0BC8BC63E58E
      D2AF30FFAB169FD79DF82CC7020D671AB86099D1E36882753D8C439D82BC4789
      1CB041450448A08B4AE40DDDE9EE42CA433ADD7A545B8ECA23E337F631698332
      1D4D94E23789672624CDD2705C859DAF6959CFE3ACE362BA9662CA35A9A7764F
      D277A5EE01D039360896A0C1DE0E2290066E7752564CD227E94AF40635E3A523
      4762331E4A2ACE4A8A604E34450658C715FDE16B18E90FC02B381C206818BCF4
      2F7F37111B61C57AB82B85E58A2BB94136BBD3E22E89D789ED6AF8951F4D790A
      8C1515B72234E17675514EE25CF75DE4787F402E8A111242DC0A114476F331A4
      8C1AB3B18E4E4F1D69015BCED5E45B1D63CB3962600A8ED2AFE9488908E69476
      9742563B122F9A0E123A02BA1A62E9830C2EF39A6BFA8D6A7E38983BCDC35953
      F4970E780BAAD0EA08B039C2CED9DC91829922551C636FF626FAC0C91CC7434C
      20DC01D114A8CB18B8C1B828AF8124EB396AF3ABC592687C56C1CB857DCA47A2
      40A94899A66CF8451076477803D6A39E5CF0A304B97DAABCE3804F0A5D2EB53D
      57890998448242BF2CB0429352329D747BD272BC8C071B2F287B92BA0D47DF66
      B11413E563573A38FE50F0C63B5F9B5276CAF8932883EF2D8F15A42BF5BD6D5D
      4C2642FBAF60F5E037FE4EF9E5BBCFB0487ED9FD1C5537D30108D7529DC01546
      08BD0FB68C9B65E1C2F992DC0C0AAC035F68E13B3C78B741FE437E58819440F3
      CA29CFAB346281381C9B92AFEA2ADDA81C584C6A29BB216A9858588C0162FDCE
      92D24A420FE24ADC20C24CA2EE95683ABB2910624EAEE3E0BE316361F9E2B97D
      925FCFB32FD1B9CF57E63975509719F2F0D6C57506F8B14F76EE455745368A46
      24C063B9E3315F1200CD0CD36332D5D3284696C8EDEE112680CB90F911E37D24
      136F802A8D839B994B49A992F15C4252AEF499F837E63E0990927C8B11D0B254
      084E15882E0A6AC1A00FE6044D9BBC808ABA2C4C00322682A2DBCDD09BA4A8F3
      7BFC6705C0CB671585CFCF004CCC67248FD13CB705AE20F7E69379A8B5D255E2
      4A0E848FC03B8506BF81B977A0F8A965BD94A117DA74EE210462D5D979FCF915
      2F793F6C5A28B48CDE6A1A83FDC6516C0626716B2F7E2E957B43E362090820DC
      7ABB4ADD2ED2FEEEB26626F7D2E60378A426953B52D7A52EE557441DE795B311
      98752D19CECC445918460C9B5AD15EDD46F02ECD3B7619E061167EA0FEC59443
      F73C17C5B1A3C54D839C4A810883B84F0E17F6AD873A071493C29A1927C96800
      5FD593E4E1EDBB88876179DC711E3874EF1EBC1C0D2AE9F0E6932126CCEE29B0
      B1CD66A49551E4067F37E3335C87B4D6BC8B91E188B72901658BC63BD9F0FA03
      A3C850793A34D983D3C79E863C2539E54C7C98FE0C0F333A0E416E7913B16AC9
      CB06864307C5BB3B98D9F9F40E3A679F844E7A928F105E4608001D3D809ED51A
      7E0DA3F0F2FAAC44852B088B4D8ABBC5B5880391D862A4D58AE7AB5355E01779
      D1E12DBC6DC8335C1FCC55349D262342B5CEBEDADCF4392B4609DECF6F1396D6
      58C8295A31461F497800A9808A06E7879750D6589A24BDC8F8E0D7BD445F2327
      44EE8640BF0FD5B85D22139684F45AA2BE3C1516B8B7DCA4EE011E7A328E2A7C
      866CD788C4E171A1466C98ACD0CF53496E65D0DED229656AC5CD947CB0E029E6
      313598FF4364BB791A88C35C9C21A03733D816F2BEA05EA8640431335325E5F0
      11F9B286903ECCAD4B8D3FA3454BD44D1F2B61CF4192A5894A9E4A6D6A947B77
      B78155F4DA8D510CC1CCB4BBD084926F3C0E44C43BAE701EAC0C874C996F0912
      9FE19E7CB15991D204A9DB93A980224B8C49B64B9A09F271C52C2C1FFDD19E08
      3D6FCE7C387F7A7005D0CB918DA60DC1AD18D2A5B6C7AAD3C28266BA15E9EEF4
      4253437033601C445C5314B1961CE554FC002636282F8A8797C666A5F82C997D
      D750E28F618B2372D8F8B6166B02E148FD015636B7C436E0C941462DC6C165E1
      18E2061B538D2CA3BC7B7BDFA70EC97B72E531A7C5528B71B1515A0907FC1D50
      A40B87F20CE5F2B38A0D2B4D6470C743B0CF55C0E3C247CA940FB4DA9D1F3EDC
      CE00718FD3BC2E8BD17C685242DF242BA7218829930EB618DD15A5D56854A317
      4DE7FA67EC418B3CF41C45C78E005F15C9177ED414794B9C21AF832B87BC0E1A
      21E23EFB0BAEF5ACA99073440001771BCF39CA3E88C54E4290AAC579752616A3
      17C311CBC752B31B453E7CE026ECA3398B8833ECC6F96857C2219258A12BCB61
      11995F46655A7DA1F1A6A5D5ED18D2FCC870C43D6E4F14C2DE34BE51617924B7
      38E8476128AFD3B9988570EB78CBDCC47777F0F68D010BEA852B1D027F9E553F
      2839BFCECC9D5A0211B119CB2895E9C6C5A52C5BCDD3112685757AF18A0EB343
      56CCA6568AF4B3A933B6401AF02B4CA22F18F4901B1044830D0804CB3F9881C5
      81A67198A441C1807E743C2F71A50342D2977F5449998D5D8AF02FE6F389F8B5
      85BC5959DD090519D5D1F7DE6983F3352C6B25DCA9FE986C6CC58DCDA5236694
      E36C95625D60ACCDC0A38BBA27EF8ECF77A273D2244E24DCA8DFB92C66E930EA
      1E9EEC9FEEDC21BE20679599E206F07AD3EA5574F2EE5C286D27EFCEF7D7595A
      68DEB657E0410971304FAE7B91626FC11DAB0643A39D458D2D5AD9C2490D52A4
      829BDA226E30FC6D750497AB4BEA67AE14BF1CA4130462ED482CD08031611D61
      34CB3778DADDBD4A93986D983B99BAB58AC6461245DD1C12A8F85BF7A662E6A9
      3C31EE670E7B60B98767159CC6B14472584324759D3231F9E65119FE36A127A9
      27469534BB216DA5A5DAA694FAE7C2E4C9A14166B5B672A4896A9A44A9AB79F3
      713CF04211D49F12ECE5C3BA0484C34054923793A3178D63AD1FD8C298C5152F
      496D99C0C574519E8A82AEFCBD23A7842B4FEF7AE73F8EE51492CFE1D6193225
      CCA0865FABEEAC17290AD0F3809C855B5A5F5D04615836C8D9B14A1FDB3ECBCD
      9421C3B75C36E362BF6DDD0C93867D5637CB0B42385979F26CD09FB6BAA8B9CA
      83BE6CDD7A403313EE3FE75A343C0442BF5998E0D5691AEA03F116D0C30D961B
      3262053027E6399F92D38E2C090D9E9BE4A906FF4478467C2F1ADECBEFED40F5
      529CA7C01568AD53B47B53CCEF705CE1047647FFBA438ADF0E2E75B127A517B7
      2E2155CF1D89DDE014524DA5A85B26C379894C0FA7FBA8C956EE240CD37344F0
      C71F63E48E295BCC77C35920208BC6F3FA0AE98264435609731972978F6E7A05
      DA6223EB06DF29CA9E324F2B8A9F5F30B2F1E6E8F3C1CF771AE6FDCD8659255B
      05A200F6245E201FE0479EFA00AB875DD1C798C68F44C1B4A2145C45AF52A37E
      A26D0B77C2FB5DD353E9853098A1A977BE1C8B50FD17B67AABDF3AC0D7CA7973
      5A6BDDB49FF4E501CCB0E7AC0AA6E682E83B56828119D852E0A07D79CD9212B6
      A11871B91E6F3C87CDE624BCD37C59F94C930C826430BDE3FC187114D9973BD9
      03967924C0C1593162C1330DD3AF8DD6B187E6601A83AB6138F58255AE15071C
      BA8FB344F200E20AF0D422CBD388D3EEA06741F8E6B5AD833392A4DC80645039
      37C1DD49A042FD51451A7F78CA5256E7CFA34F67FB87EA59D8B52C15F9B4CC11
      FD710CC62C86BC92D7C5DAB2E117D0AEBF980F26653CBB12B78079ECD7411117
      A5C73EF617FD968DFD802257AA7623EF9817EEFCB459B61C9A20165E17D1555C
      8EC499BF8F8EE59F7EF89125BE9935B45F5518CF2277D586B8D7C42177848651
      F49AAC827FCEA73C3C70346DD7F68F7BCF5DDB5CABE6A0491D24796155124CF3
      E6D60824BB481460306C5A8035A469CACCE2C7A6D2A368DB3EFEB0B48F816E5B
      2CEB01E30576DFF9B3C7C7EF3E09196B948E80B0FA825CC055DE9D1CFF07DFE3
      E7E3E3FF8092F3E269B179F7585354BA7772B67F18CDB558B46497A739B970CF
      AEB67BFA933D96025D7C7B32FCF0EEAA3F9006EA9AFACE5AD9CFF9D9084D28C6
      428A00EC862D7BF5F46958BA82B9EDAA44A621513926F63F9D1DB6AA7652F714
      1585EE5198EE198B5BB0A476E7ECCDD171F4EBAFD1593C4987EAEA8BC6C9AFBF
      4687FB97FBD1AEFBCF7D681DC2154EA61DC5A32A2DA4EA537C10C8EB6FDD3314
      9D43E6FD1872D59A5C437652CCDADC74BDAD2467B0B52F921A198DF46695AC57
      20C1ED3434B04F0EEF5F39EED0578E9335F56F5F7961CE4AA97B94E6D18BE703
      2DCB20B84C8CAC225FBCC84FE5FE2735057C185B98D9BF433721CC0A03C2CAE1
      4A961E97BCCA10EE684E0E0337ACC324346AEF712233EF77E8DA653C304B3177
      A17404EE1FD3E3A0DC6EAAEBEC77681ED5A680D340506ADBA2865D57F824E193
      4DB95CF98012719768CD37D9E38CAA19F3E441DA94FD7C24D48251F4FAE2ECFD
      FD2A352E6F402AED9C7EBA781F75196347A5D8599265D58E052D1EAA35DE429F
      61A54A011E1707819179F6E6E28F2C36F4C3F7B0E6E4E55B09C220FA1858A776
      1DA38BF00484FFE70CD8A605028A70B15D29D83F3DD9FB11F7DAE5D1C5F357E8
      562360B47FF0E1E8D75FFF717A7EB8F5C3D5767D159D9DFFF9581024D6F6402E
      65913F06DF6E802C535ED20FBA2B658CA93EAAD490E708755E202059BF8A5E17
      05A5347C7A415DE037A60CA20788E983E88418C0BE554F2D5B0B9C4DD9BD2E52
      A4A7FA5431F6C3249B5DA5D19327FD675BB5046031C58E7A90A7B5B7948CAC0C
      AB0B9149C8537824CAA6CDC5CFDD1D66A9842718FA71C4F1AE00BD07593A2301
      72E78E696FD1C5979B329D461747285BA6C4F2E814974DC039EECFE2EDD6D5BB
      E21A3E6625B5DD874541C301685550C29B21482BF6EE4237DAF656CDBE2F1154
      9668B64949CA4A06B707EFC68380C59B4964DBAA15771656B3A42D0CB4BEF658
      DEAC3DB67797DA63F72DD3B7872275C70057A51404C59BA2EE455DCCB0BEA4C0
      EF11323D7E8AF8A17C0293206F2DB13BB4FAE4A9BBB80E4C782D7A93D427D5C9
      A1176784FD3543DA757494C32FA090C3B6E6225AC5E9F98B85E33FCBAB548FFF
      A655DE2FCEFEF62E30B6809761950C929C6562546762DBC669DC9F38B20CA462
      44331471A49B32CDB274E898CFAC652B320E1AB77B5F16C86DDFBA75BC3A4C2A
      39DD1512F0E49614C508A5F8F87C4AEC98D48434A70A7B747A7E7EA9DE2F9D5F
      D5677ED00BA6AF85B195F7615177AF5DC6E300D08168C2BAA43B8519FB49F57F
      F9DB0739940FE28C2ADCC9713C4CDE212698552661308EFD651013D9789026A9
      5521311FB91EA525AAEE6AF8803406C43359AA4C8AFFA126425AC979697701EF
      8C07E994156A1DCD5D7C4AEFEECE31D2C3540FD915C456E8A49E97B9A19F289C
      308BABCE1DED429DDE07798B8B8BA357D1E9C99BB7D13572C795BD76CA98D24F
      D1E9D1BB8B0769C692C00F2E0FF745A41A175C1D7D3B7FDDE2163D780BEF3E3D
      500B723B5E1535A8FE86D882FBFFDD414FFE773FABF16FD1FBA0E7DF42F016B2
      52EE7E033EFFA36EC0972F59A7D6D93E8F4F8F3E47BBD14705BBCEE2198BF926
      657489D522DAA1DFFFB865634465916B713EC8D2AFB8F40C00F0DA92D8F30AFB
      BF393ADEB2A11F79AD672993BD49FC132CCD38E9A8832639F9149A980F76E53F
      B7F4C2F6009BC5AC70CAF2F2A49EF324C3CC5E176536AA90D9AB49F487A707FE
      80271224F1A35093446538EF57FCF78727CF82C9D4028DA87AC5130C85690403
      F0ECB5E8C014387E067D8DACAAACD8CE53FFD30F84138FCF9FBD8AF6F3E15501
      69384A79FC7FD17B30494F8BE24B31AFF91134B3B9D410ED112689A5AAA8F0CD
      DFF60FB6ECC6732C3BCB21E4B5E5317E4B1735730713E603F9CE3277EBF3719A
      FF931EF4B60E3B87E4DD272464E952894668645AE4542726C49E9494D74161B8
      49524C93BADC76057C0FE8528AEFFAF6B2613EFF12735D8AC4614A89E5348FDE
      CDBFC4BB97582DA8739ED4D1D7384FAB2D51EE1F087243B4A44E67663D8CD24A
      9839E013484D60A9B9B86D1BB2C69EBFB284A1F301268844A62AEA1E1E9FBF36
      0CD143E95FD338C2615B94DB9AD33FBC7C82ADC5FB488EAB8B5A898999C95D8B
      89BFEDF3BF5720C55D0ACFC42BD00472BAC90D785C57F8B6113398C82C1C8663
      40EBFD69360C76C09FF3E2CFBA3CB76D01AB418C1B15C951866431C73B39BF5E
      F77B5B3F76DB30DC737FC17D8E2EC0B68E33A99ABD8416C7554FEFD824FDB78D
      6EFD18ED1AFA268B4F5F339E1510CC9C5DA95E86220DCB9D8C9B7B98B27FFA91
      6EA65B4246F81592432905D10AB97FDE2557653AC559B06D5318E50F30113C73
      C1C87C38DAA534ADD7034495D88625BF6DBB58B5871F1A89483E9C8C680628AE
      BCE5E55FFBA391D10A8E9F3D7EF769DB767F544B4672C84FD31CCBE643514CAB
      E8809491F0ADCD6CC5D06301D2616BFC86541D5AFCDB2E38C6F5055340CCC9B3
      F8A8B515A52871BDF5C39FE3E16F92FA5D72EDE25860BF4BEDE1BD282E27ACEA
      AE1C127BFB93EB01534E842212A5F96CBE2580F0E3F31F15BC78FED9598F52A3
      8FBC9EB822F3C8E883127EFBF4B78B03868BB70D01E36A61D9E819FCDC910615
      A5FC0EA28BAA27A8EEEAB6ADE0CDFE364F5158735E17916832EBA1312ECA61B2
      2B690451E783A8319F1F5F5C32FAD9D9B249A1629CBE91A8FFF1E939F2F4C721
      4593F5CF04FCC0EBCE903909CAC6B60DE232A3C2B31A384D29EB32D95554D21B
      2A414D3EBC34A5D7BA92B5EC991C08786F89C2FDF812A7E3BBF707FF193D7A93
      B0AEE2C759F4F724067DE791B318C843856DF884B91DDBB6859564009FABB520
      D7DFDBF85FC8D7775B882C47858824BD8466F8B62D63AAE91E47694EC53E54E1
      E1721A25C32CB65479A9F3379F7127D1EC079F94FFB07C808785BB922AF3E289
      284923115E4198B0EA5D892B293E19B0845C92B07110052FB5BA91DB9EA1B775
      554F9DA343088521D7E4E20083E9FB23BF8B3A47960BF39C6B45640FC6AC23B3
      D7D110861E191DA6AA88360C06B9EAA0D1AD3DDEDBBA7E8498489C5D1C096B26
      ECF42C29C544967AB581AFC39C6090AA91CEE62AA0D86CF40715D2DECA160BF2
      41BB7D1A9EAE41FD79AAB688F29E7AEE0A144AAD22AAACF3790FDA9B17CF2394
      26B0941A87CF8B6AAC4A99FBA22E941516C2D2F37B3AF0B7F5489531A1EFAB79
      349014334058504854FAC3B962D2EAD94DF4DB3C9903C08CBFBA8CCCB8E6337A
      01B1DAEA016545F5B0B3EAF6B359B9A067F30D90682C456BA47EAFEA708DA9A9
      6D8495DF83A5D795DDC9F0978A56A2A7EF0046D4859E4364D2E471C64E31908D
      5B0A05CA650594D51F08EDFEE987A740ECF64985B9B83862A758162B47C27062
      DE93D2DFB73DB6FFF4E31EFCDBCEC7FC0AFE729C65FD7EBF63515A4A6A90696C
      B5CDA6493EDFB621DCC32292413E220DD5E8ECEDE165206E1E5A751099167BE9
      0217B3C9C35751173182DD133EE0EF0037F8101792DF3C22ACC7A613F9C320AF
      911A510DBA06E1E196C7781D461A3D2B65066527A8B0AF88C98994B31DEC2656
      088A3DF5562C32B3CB0CEA3893FC6937089BF38C39C478FCCAC48E1B69151323
      7DD51292BBBFE1E7B0C95F0108C536A726ADEB88AAFFBA2328EAE240671AA2AB
      A6A7669ED2D8A96CCB51864D664416E5B06811D60B27DA89D37875C55E9A5A2E
      FF04AE30DC6E9F2984385C2F4259CBF06D46F1753E99230B0ADE07B2718B7C50
      947446D657DEF3FC109DD321E5ADDDA4C12EA647DE45D6052A485DEFF4EF1D4E
      78F64785135ED04DFB401DF3599CDB650DAAE1960F240D5743E52D93E9958BE6
      8A9D2AA445C8D663FE1F478500819C556CB98B83F3D37B856EFFF482BE1A6B44
      68E0D165D456BD363D05BB54649FF6A5C21142CA2213C63393796B493E972D80
      2B4115C2FD8F1A09B85B76F905BA4C05BBB88EF67A7BA6C355CDE664034A2521
      3955C24885DE23061A6FC99D7DF172CFCDDF613C8D27F000815926C42C198CCC
      E201F97A0E39DAB629A11888D77A72792631169E9B26C49B47257D5CA2EB5C2F
      CD147B49D6DEB67D8224570544D7A3A38BF762A29E15231151DCF6A9085EEC93
      8AFB292DA42E916A9029762872965A23056255A078866FBA65CB3F3ED1A97B0C
      555C505566040DB998247F439402797CD37A63943E8BF351358C67D4CDC9580A
      5371B0D2A00C85691C389A3FDA12177A4178B782ECC69C6B0845CF246795FFD2
      740B5FCA8A4669351F68B915E4A9B168F3D6834498FE66C6440AA0073F1DBEDB
      3FFB693F4F5520E0F26696BC8A5EC73886D221E2EDAF638C4A9D0EB76CF207C2
      BA54ABA8AFA2418CF459AC60CBFEA70C24961EF5AE4481BC32116A6177522CAE
      28A26A1A67D9B66F4EE85540ED53ADB45B8CA3CE6182AC8D2A898E7E9BA733E2
      671D1B1CF8B8C5480316DBB60BFBF7408AE808C9D5BC40B10F0F328075A83F70
      53A1E03AFE5597FC178CA4BF73002A5465DA16B27BC9D4152D9E365D289E66F2
      3F5A3B8D9528AC565CAD8528E7D59650D2CB27685B458CBF0607429253B05055
      BA936DA1AA974F71600BD0E91364C990C39222670402C91F2F2EB76D00C70AF5
      A62EDF9DF9A034233296F3085E7D5AD7A8E809B3689E4B7927CAAE321D584EBD
      BD7B60722F9FE2623C3D3F7C83DB3CCE79564873A1A72977F3D7247AF7F19405
      1851EA16696384D0507BD742C85B76E31961C8E43A3AF819354DE09AF3A93A14
      382954A753A675C49083AF55A224311FB8BA075AF8F219704A9783E4D44452E2
      42203FFB047C4B68D6C5AE5949CC424AF32F2EC9B128D3093364B07A5CFC15A5
      8B90974ADF61DBBEE2E497E2D254F890938DEE83849F1CA544B0C571319C530B
      C027F23A27625A6C6974BC7C466F7C3A482773135E60A8F15115FDEDE3C56520
      F2BE6503CF6F6FE0FDFEC1CF0FD0000E94039BF37D6383361B31CC2B98E6037C
      73465EE6962D7F8FA3C62D309DAE4715FECBB02C155B65D6B62E2421080182C0
      3649475AD60A3A28124063F603F2D1F4524A1F160E74348AC386EF27CAA02870
      F2BA00B901C5C1E2C984D540B60C6FDEDA038264606BEC7F3AB3786E1AA3945C
      9440271DDA1D5AF58E81B1896CCA1E01690A8D48253055A256179ADF73E5901F
      819A547C6148402341403A596F9EED8243417F053F4330B302F52D7BD85705D8
      432002508F477A60D8B3D8188CDC4C88548CD258C52C871C3D686FDE3AD0B1AB
      60EF5FA21FF6F67CD964A311083088ECCC2014DDA8062467126F1697916FB131
      5F12F8417BDF288DA2A11309B841BA1698A18404B06AA20E923EF03A9745279A
      41465A046AFC2F652589A5E0D3191FB4C7815F0FBA0BFA880435A5EEF1AEAEBE
      8830C283B61B3252F0A754533B992B9715903D33C15A773272F9A5F92E95D455
      06438D6ED146D0BA37AC07BAE5617D5B7FD3DCEF0671F920652AC761A3AA9CE5
      789A3E8D9203BCF1A02B619E0BE9FC5E24E4DB4EAFD0BC3036C138D09B73FDD5
      686070E7F8AF5348F600C2F425AC8CB1962AF0618D7B4009B7F55C31465F1868
      9A56D47DF695F07CA5426359ABE9FFE011494DE2787D7EFE3384BFA90139892E
      DE1F9DBA9A7B32860814C0787DC800C9E568AC196D7D904D8ECB62EAEA85BA1D
      A16151753CAD88A68FD5F1D10FD92B090AFC0216C567A5512843A529B3151EB6
      5D2DBDC8EA6E391224F32AD979C85E09F8E57562038294507472222A0FD9A471
      5417EE251C52DCDF3386F9A02049817B5795A57D823D64AF8A72761503EA5EB2
      6FAB003F12B58C05A29A71B7AD382AEFA3F8ABA84B2F9678FB7DA3702F68F707
      E0D8E5E5D1EB806BBDE8D0765E67A878EDAA136CC9DD79F1F2C766C39F4E2E4E
      7831BD3F387B1D521AEF9565FDA7974FE19756F3F138FD264806346E04138691
      001B5DAEE46D1D2743173F23CA28A3F6E40991229EEDE037ED321DAFD3E41406
      D5582867D5792B0E29513FC66A21C37F80344BC052DB8DB3CFF34617A23D740B
      47AD56DDEE5CB058DF7D9F4D77A1F3410AF90A2BFF7D59E0622EA36F1747D191
      2B2E7A5A4C3ABE46EF56CD7E90E3586CAA40ABEE7D99C0D0BB8029CA9B0BCADD
      822D06A410D412D534050421B7EA01C3B54607BF4A45E0568A21683819FAD6DB
      5E967C3A3401996741A406326F1002980F841B1DED6F2F6411DCB9122F397A77
      F016E7D2CF79714D300827E876CF96687E5CB1FC969E760AF6DC87DD003E120E
      52567E81542ACC2897C2AE396B02C80BCFACC564612428EAEEED3DD93D3E3E0E
      57C30F7B7BF868C76CF3E90CCF576EE4D1C57697593BBEA71A4D12E2B3544C61
      F7F3A28A325A8A4E9D301F456F4F2ECF8E36A7635CA0464E822BE9BD2BE1B62A
      847B81941E5FEDCD62B85A08453CE9582AEFF0A9286A9317D7DB894D4ACC1937
      B6A741C455B4FB5BB55DE060172EC22DCFFCBAF54311B0863D45D00F8F8A27D9
      3D5E57A89F7CCDE13D1E835E058F8A871B2F0995E3C016A439096392A6E4BAF2
      C1C85F95A2732EBB21CDA3C3065B8041FD515213C162701FDF31869685217798
      A9CC4CCD98E22F0C21340A8469ED02F40BE0B072AC4D83D7D5138F4756C80E21
      9129690E0D4D56DE99D47753BDE9F6890F18DE4AA6E35A165EA3AF67CC02BE8E
      8F297434CAE5831BB89E0E211EA96C1C1D35B5FB6E43D9C81251D2C68D6A3E92
      A9B1B3018F46F5E6483C5936B6C1182E4CDEDA777115801CB3030A84994B957E
      1A9C1C5B9E08EF0A2C4764C9B92439AD732F6BC5F79E132BCEBDA5D1D5457B35
      36387F98BF8B629E4507715A1AF5779420B636A0B639A828DB75FB1834BA46AF
      D5B397AEB5FB6EBA99E1EAEEFAF47772A26FA077CB8B925FDBB93745E6E9E614
      999F8BDDE374E57160F86A31565DC9B802BE22A7032E0528F128514CEB0C88A3
      E4AA15B3AE33F183F7715D26A272FF18B208F1CDFB38DB80D844E5C680DCB4BA
      BD685040770B32BBC877C0269B16798D3249A302D136849081F8F2E57B709E4A
      C0CBA354F14D11882BE13546E49D4AEF216A304BFAC3621A758B924F9037D861
      72CEC7FFBDE68C48A4C1E83D9823AC91C1A419C39EE58F5A645B1731543A242C
      D4ACE33D052E0CD765730A1C3216CAF7455257D1A77494142B8D837D2EAA8E7C
      B1639D6A72FDB6EDE392E38694B86246CAD3BF17F3CBF9204115C71BD29D38A5
      9A7D6655DA50A5B0A0D48B7FAD3F4A75F445A0ED67CEDEFBA4FC427DC11B9695
      899E7CFF72DB87AB0896A0DBA6ADA4D9CDB232A975F2A8A2E8E98AD0A5FD4852
      B8180B7950E04EA6C44AF381B19A5FC7D084CF6E760C28736B40C51A84D7EB19
      33BC5F6388FD66A802A402D70CE5E8CDCC82750FDA6F52DE7CA9279CC8D05927
      465C5FA3E24858100BDF919C5E1641916B462C17BB5824AE47422B930A84AD43
      E513F073AEE63570A987054DE9727FCCE73076347A0144A61847AFCFA4820D83
      19141D975A6771E5B3652A90ABBB8AACEAFD3548A2676212ED3C68578362A5C5
      D8962B6618A72058CEBA1A24A2F398F00CFE61C2F78E370B534474B15C602C2D
      87F3A9D5ED6808788A968B855C1DEEC6A971D61D4BDC3EE8CB760E51F8BCAD04
      D9F13832F38F42FB37A847ABD6222295E67E1AD7865B81B202622D3B96230F60
      8A483EFC1E915BEF24E748424224A8F8C8CDA0B94AE1CD0CCC93D545917190A5
      33C1BF8E4957C8936B47D00C6B57E27946C77FD85D4284830AABE06CED5F7E40
      9765D73CEC70A99543F93AD1314FA17A7FEB15C958691C0D509290D4362C807C
      1475EBAB18C1E7EA2A1EED5D5757F1CDE899AB37364EBF3D28987F21F131DACF
      4529596C726C99D5767471C6E0BB68025C1C8909041D9273A1563807CB7C2BBA
      679EF4DE75210A264B9B2094C9B1A388B38305CD8E7681BBA38BB3077DDFFDD1
      48350BBB3BCEB189BD5323EA7CDC6A1663109C46A3C4DB17C1B82DF224A87F58
      5A12D87F40116349414A79356AED4EE5620D623F8212DE2BC4794BC4C743857F
      E799558CA3F7C5B5C47A2EDE9E7F6C71B758E4697BEAC4AD61274599895A99BA
      989BAABA8CF32A8B49D9707317B04650C0E1F7EA4F5947C7A71797360C031612
      155EF03D95086F69FCD0E4BB5AB1A7371F3EBE77E1528D57A2A073BE3B8E6B54
      B3D04C58B767E58E5C2CC9B902507275849DD4DF4A3762D9F7A53AB18F7F0529
      C46A5449A902A0319C4F4564A32770985C51A7D5CDBAC6AC82A7AF80EC27A51F
      ED3BFCB8E5DA688DDAB2C858806573D7C2DE58D17939585E8BECA0517E206459
      9420C00D6E4CE865BD33A659659D6D5BE8B4DFB1ABC320AA7BE53C598D3AA9D9
      8C9A4A9A382725C2BF26BD4657E225BD80592A3D5C4C7EF24591378F79B2A08E
      44C5C3DA6E32DD2314C5A5BCDDAAD7B9FD19DD47FB64621F4BBA0F0BF3EAB71E
      F5A247284B8B708688A6C9560F44551F899ADA239537E89CB0E2068AB222B191
      6775C7ECBF4756D586E57160550CAA82CFBEBEADF2C7A3B6B8C223C9867665CB
      1D26282250D114F7C804F7EC2C8B7D61AC95537D86A4C5B0DA6C3C8035B0A0EB
      A077A81C533475D2CA4029B08047C5506400BA608C592E1A43F20A19F76830D2
      D14A50AAD44DC3CEE6ABE117F0EA3E2FCDA2EC2DA151C8FCF02D28E200B61FA2
      6AAC87B8AEAEB0D49FE390F326A40BCC09B03A1CB802250BC3602389EDA3C48C
      F8C448704C9BF5B0550FD263AAAB2113F981D84FEC4A0F559F54FA9E4D513FBB
      62BEDF76F0ECAD89A9AFA08186D75ECE66B4F44D53EA816C093EDBAA13CBDBD7
      44E1956D7FCF6FDCBB69BFD65F41E7CC35EB0229D6E4F139DFF66FFBF76D511B
      B3E1E3878D96ECEDB76FA8B9F4319F6C0A1FE3537CD87AADFD37A70BADADD91B
      EE2C522A2157A4A4AB4407B15C20BA1FCE60CACA9F7A522EED0B8BAB257125E0
      7282F51C1BDAEB6E31CB10465991DC7697ED88CD8F0F0E07558670D22F9E17EB
      305D9FE6BA900F4B70A32E2609233B9214DB0AE915652358B8E10920A8784D01
      199F4C52283EAA05D6C4691110CDD9A61688D0222BC3623AC57108CB6A658B3C
      496CF17179B4DFC48F8360908B71A6759370F46D757E36DDA5E45A5A426DC88D
      463C0E0218BE1AB1ACD22E13A297DD11924BD35379C91D5169F8EA22900DC51F
      6297CA3E26BBDF6851E4AEA7D01CBC8B75A3E9F0DB26E83F5C42FEDA74FC55C9
      F86D135670728B26FBB415AE6314D41DBB370028CC72BC74CD757B67855451E3
      EDCD954FF42E923C48E2E27E76DD97D9DD8B3A89A7489C4BE2E9D2EC0F645957
      10A873669784D4D80579902B066FC20062C6CE45CC0A60171494F50D1E5552CF
      073FDA7CDE8FC1EF9CD7D1CB17AB46F2D0A5C8102701EB19509DD54FF065FEB0
      26D25CD21747CD42CA691E3D81302F5F08FFFA1E5D1D5EDDE5D8B492AC268CB7
      41E1CCF72E288E6196AA9FFA14FF26A29C2D05BC822FC0D9686C3ACBBDF5EE9C
      8424B34C8BB24B0D2A6C5609CCF6A3EE253F72780584C0916F41153BD86D0E61
      85E4357E5A8CC7622EE20385B78AF1B8556448302D09505BAA9FB00AE4126C93
      D58D3CCB170CEAE7927FB0A4F4381C909FFB3B2BA52B3C848882DEAF9AA520AD
      369C50DE587EB5EB881A525FDA179772953325E0648C7F6141B022BDD8F99262
      FF25480B695478D0F9331E3CF8177E92556E69908C8B123589B16AAFD2845D4C
      AB5EB3F701ECAD1C382C71949C20A41FBC943CAF3D13D89BD9EADB0D370B911C
      9992162450CD3280DDC80FEFB86F759CFF8C162EE13E73A5748E31E9469847B7
      9ADF3C868A09ED1CD6972C351EE1A6C3312F4849F19DC2A1A84AEC58817ED9AF
      F6DA6F8318E9AAF8ADE30B8AB2B1A1C795C2FADE0ECFD67A9049997E357E4630
      0D5AEEADDBAAAD694559653DC559E568D072CA1FFC6C67BB2793B70AC0AA1050
      D2D8263B21A6A52B6470A3BC3FAD146B68AF26D579C72CD4FC31A34819830D1A
      A719AB7E2C2B37982B27007E70C0B2F37B6009D004EB1555D36501565137A81F
      887AA73CA8FCB24CDC89623F5065A164B4F32ADAC5DAC16CF6C0B509FE030B14
      F32427DBEEBBC23ED8FCF007FAAF9566E035AF7A7F091468A56240C32C81C81C
      9985BAB00CCAE97863B53C421ABC0C12990038DC17B27665513AB57132AADDFA
      D5B85AF07CD4D61359420D5108CB53E21C581B729AE32225913534B14CF46B51
      DBBCC87747092DE9C5F3BB6F46638603FEA66D3C7A25C032051F8D03B6B4532B
      D75930250E8FF0067168BC8212BDD00B4AD94ADBA1923036A95DAB39CBFDB5FB
      24E20DF372061B58AE051B3249CEF3325B08201DC99586BA705A1BFB4B903448
      F7016DC924C00ED4A4339E861AEAE847C75A6A7D11A3E2D5D4C6A5DA0DAF3B31
      6137308106C6934768DA439C8E09BBC46502E6C5A4D00B49B019A8239888C29D
      BB504030D0787E79BB618FF624298741411F114FBBB838F2DF6F98EF245C9885
      BB1B3C74531B3E84A1F7255AC7803A1EB509BC1C60C8E70B187260587327C862
      E489A61281A28BB9B000BB41F4559FDBF3AA82887FB47F24AD30964932285A5A
      6D5FB1E326E2B8301D212A6E9E81DDD5E2B0388289D14A921A66ADC443D75EE0
      FA68B7AC4B98578505E8399B321DC87BE0B06D2191062DCCC7FD41FC347ABBAC
      66E252D7D1F1B19048CC83C23FC52D874084B74C08FE06F5B8E58730205E5FEC
      97C3ABF55C31CD048D47A3AA71385F1E5D3C13414F00C95225AC8AAE913A1337
      BF69C82B30796857A1F21E8F1195D23E17C7082949EE0B7C257BF03A6C468E4D
      1E712C9CA125B6B52AAE9257447B94E79CC010C9B7BA8CA3AF05733E84091283
      E12A029CE2BD362EFFBA88DE17595A5DD9FB7FBFA37A99CD5AB648DFAEC0632E
      664A8869CADCDD019A6012866EB2F5D905FABDC0E809BC751C2696D40158524C
      3D6C24442FBEA64229D1331679298C2C801E18ED97497488E3F60EEEEA5599E6
      A4D55CA0ACDB6B11125A79A16AEED6C71394BEE56EEDA0A3C8462639521ED978
      DEC694C88E1D802DB426DCEE381BB1905CA694F71F439B559EACCA487472C920
      C13DDC269148AD543B33526C4B3879BC3F579F7F2A45A8C1A3C659A7CA40EC98
      00BB4AC5C7276F936C163D56C269F4387A977C9B5767C508FF7E93D66FE783E8
      B11169A2C78E1FFC58C9B08F9560EB5EEFDED4E8277F987A20B58D9EF59FF12C
      41D37BA2CA030B21AC7A6D390296494EA406555CBA83328951D5675E17BB6522
      2826ABF14C93125FDD522CFC05F5FE7D1977D3156B683A7F387A7F8A9CCFB3F3
      C3A3D3E8F8E4F4287AB77F76A484D4879572A8614F4B7ED8CCA34AAEAA9EF016
      2493DE1F6C8D530D434C219107ED1878598F4D836C5AC0AE3301B251E10A1ABB
      7AD40FDAF66932019F93959971EF338C329FC9C5B927044E2143F286711C8A07
      CECD27C7E5F2E0F823DE5200391F4A107CB6735CD051FA38EBFC5EBA001DA99F
      884BA0EA047C917675C9BF9F9FBF0F9CED875D0C65F125C903FBC64A9050254A
      1DC376C6D124152BD498C21A8C7FD08E29D1E0E4F2AC2195400A0324885BE9F3
      0F4C77958A9697C52C1D7604FFA25831B32D3BD11B9F0E3F4844D6A362D9F302
      7C84785BC5845B7AA3A5C0544F0EA8DC0549051F92216B87C80CDE6FBB2EA764
      192B96864C5A05EC16B3638C51E9944194E3A8C65C53FF770960F790BDA515E2
      32EBE524F330C4301EC28271609D505515BB1096864BFF09C8CB0F2AF920360D
      45CE92D12DF8251C70A4B85106735E538F8646888496DCC8933719D2952BA6BB
      5B454B3EAD01863CE49B98B16FAA8E92934E28A99851C2512A0721C941F8D072
      CF79FDBE1395EB7178952B682152FE1B9B336A4989A5BA32967013CD8AD93C8B
      81F002D382C5DBB0C3DAAE3EABAA2405C83D5C373346011CBC132380B70BD4DA
      D2AF1A151AB26444C3A7C8CDFEDBDCACF7F624CE1EB528F5925EEBCF8B1DAFC6
      18AC6D33B47BA1356B16F6AAA63CDD61904483024915F948EE6744D647F7B75B
      F736B75B3D016B359AD3F15FEC78AA9677DBADBA95C01748F2D1AC2FB7D5002E
      AD0530046E6DC28DB06610D605A03F29E3A938A47D2C3D2BD0A2C219541613E3
      87328B8AE077E47B83E29BDFD9AC630483C81E3E9ED375E7B32BFD3D69284B18
      6A786D8B0E74AD44AF4252B1C9368D1658694F9FB767E1E90F320B97F4D820F1
      016F2D6F89B72D01792ECF0F9624FFA12850CB890CBA4FF3B04B2F91D6FBA880
      B0BBA3DBF82F5EC6839D3624CC512DCA488A222C7678E5ACAA56EE81A88A817D
      8060BC368C5711888D47AD225E7AC729BEEF0EDFD5A4D3748454CEB17B2C96D2
      08B6157BAB040F06E8D6C197286998445DBB168A129781C4ECAE97B422705D90
      8F16A48673D8B556D7244EF3CD57851824ABF7A53221997DBA484B6E4D2CAC8E
      75B8EDE965F45D74C130F2E587D3E8BBE858F54303DE255A5BF994E36741A922
      5C6984204070D15BFA4B92CC204E45900C7EAC610076210FE765858BA24091BC
      8543BED99A2C27D76038247769D2DA328B429FC3AE6368CB04AF8280208BD24F
      10E036B4DCAACAE80172DB23F4779B2F81FF288A95F9F7FBD1BF0ABC46190FBF
      400FFB219600DABC2D955FD7C45E2FFA8E2FBFBBF9EDFBF1042757BBA6E352A4
      985440C160AB06256B30870999E6FE6104C16EACBBA6F532B260477D5516F389
      A0C71DFE829A4A828619BC7E53D54892C1475D64625968B775A4EE34803911DD
      E520584EB6754A0C7B7986A29A6B51FB15BFC5BD8714660C0523FF88938D9BE7
      2473C956DFACB964BAF3D4624B7C610BA287ED8B45C3470A49BE824E12879507
      F129ADCEEE48CA63737117AA49036E8C6397C87979088983AEFDD5BEAD3F0EBF
      2C0DAE1B29F449CD5B88347CC1242168609B57B81F4AF86940A4648762BCECD5
      D20AD71982C3B65D6525E8E3C5C476F551933B40DF3294F135A27DACF504DBDD
      121D864556CCCB8D353BF8149B70773CF21994FF9F26B04118CF93E3271F0182
      92F559E937E93DF0C4A3DA117282D2860E347BBC83E0C7EF34BB2EE7A069DCC1
      7272FA17F69CC7F2FB1D799E09FA2B65C95E6840AA9AA3A6CA870D41A2700F61
      06C828C896148DD87C6215695B329FAB1512EA95487F880670CAAD1D35F194D8
      524C26A2A20BD5BF2A1DA4288E22EC08FD3E24C6ACD081FC480D0FE89A59E2AD
      14DE515A8A9870F2228C987539E6F24E326BEEEF28CCD25D98897589402663ED
      876ECAC0CD0C8CD9269A1DFAF143C4E2821C62E7CDCBE9E44AF4F17BDDC63B3C
      0E7B4CB98DA07D5F06425BDA7CF2DFA693ABDDC3F727B22537DEC0416A61F309
      E1E1AB689C1436A1D7338C39570BA51FE50FE3784899DDCA827B3F454FF6F6FE
      8FBDACED7E0B1DF71DA9364BA7A904711C9B5687C45CD8416C350601168BD090
      CBC0767A9A43DB498D0E0EE7552D6695DD1D771BE2CEDB783A989713E43D9DB5
      2BAB2D3AA5EEDBFCF26DD22396F9BEDC430A6E73E57FE953B04229488D7B92D6
      4FD73191795B456382D90C3B4871A5EDD2674E0B0CE6BF38295B3DC032312816
      44A660BE6571587002B6FAE106515E268A89E15583D8EB12729B19CCDDBF7281
      8D92599213270799418298DCCB9EB81D863645197D92D43E6ACCE06368E8898B
      7F8700F6C5A999A19BD9AC429672962BDAB4D2ACCB586BDD807280BF352BC35A
      8C7BEA2E6BCD79AF92D6B3579FC04171D840A75978274AADD56A461D5EBF1DA0
      EE72EBF26BA6D49E9656EF239AC64CEBE7CFE8E21E7DFBF64D4413FBD111AAAA
      663752B27481DDC60D2652A2FE840C3521D8DC7C867F3EFDFE59D4C198765CC7
      BB7B7BE4C51ECAD5F47CEFC717AEDBEE3BC7477BFAB5234A35EA5B2A57992453
      683DADB5C9DDDCF9D011CBF704A2EF6AB2B8B6E187F0AFCA2EA6A2A8FE512E2E
      A982334A27696D09FAC621C55E78777E49D83F13ED1595CC1A214435051F2C68
      3ACE6FA645B9261137204AA9609AD248029D34412F44543EF1D5841B1AEE02FB
      4F6771CD89EA6A7152628F2E344D8025774A9578613A9E8C7AC5FEB5752FC86B
      F7A29FA2FFCD79724BEE3A2EE984F94899BF66962CE7B5CBDFF83CB738B560D1
      DEA650D77A9AD6D8C443D953C741B405C03DC159C72E4228013F30E3C60DADDD
      FCCD2DBFB2E5F755321F158B2D4B856837338D8EC8E2D49E60F65D686983DEE8
      6645D8BA921FC3EC957C09ADE4A0251FBE268D61D6E90DF7FD16792D9B1CBDC1
      B7431E6B90EEE184960C82C6B170FEF2C542BA92266C48CAD2B878F9E20EF94A
      81902207034326E5A85CFA4DDF677D0B8AA1792AFA92069D2F54E6942B85937D
      C1ED7B73917EA3088B532CBE51582428DE64B3CCF0CFEAFDB138E0E882B74325
      94A707BDE895C9C59DDF20D3CA47F82DB7091E9D904B594525AE97751C2D4EE7
      43E2A852AF612894C046E85B625E123A5FF912AFE7288534C9412F8CF33A8AA7
      CC6A82D40C481782DC31CA3B56327049A12BCD421151B420578A73C15C7CCB8F
      8C73E4FE5C3BC5EE8E252EF83A59B7E6D1AD58EE6E518C10CE38905A06ABDEB4
      F98390D2AC77A91CE98CCB8E34CD503EE222114044A2B6263AC6AC2697355326
      0AB2C9D574F0E1C019CA92238A582E92A434694E5564564ECF87642CCE80680D
      88785AA1DD48A1F3A5451C80A3954985726E6815D71B06388FBEDFDB6BA795D0
      92A2A0F7B8B1A3EA987BCFFFF6A94AB2AD07E14CFE002C05719CD93937E2ADE1
      96817205E1254502555AF0794FAB787B12265E7BF53952AD9F5ED33D6A8028D2
      1143A07FFD2F9CBCBFFE37379B29E4C2CE0C0D1081A9657D402A4DE29A383F6B
      89C28E51F026CDE7350C17544F22D35E778F62DE6646DAD6674E9AF10E650536
      5E21DF7826C215EA4A0579D3B85F2663F90A869C10A5445D822CA5341729FD5F
      7FB501E1FE4A7EFDB523BB201EB212ADA00D7C9848BF5316472A1970D9DB5994
      15930DFBAD38E26DE60653773635380E8BBC66BFA3BF86E468950D627178B6BA
      E6DCF0CF61F6FA5FB50C132F9670B0BD0329B34ECA3E3ED43B69B33628A96F6D
      F011611B7A2AD99E2D93F14ABF71F7E0D5AFFF85A9F9F5BFA3BFCA1CE9354318
      CE3F78734918A88BECE2A891CC42EB0993DBD5E62CC6B76FC675AB4033CF5CC4
      82CFF31941B76F722D33A13124758E5C6DAA5017453A2F3795464F010BD19DF4
      89C92E7072F0FE23608F24E02D04C96EC1D589F3191C65B860EC065CB1456769
      55767E7039889A2EAF8D830F07CF9EDE6510E5077AF784378E13E1E42E55AF0E
      E08EDD53C186DDB811F5119DF56C8FD71909797B3CE56FE55E6D3E5027245827
      23CFDC2733B5182533FCC706E6AF96655287CE0290CEA214539D27A33AF0A685
      E6CDBBFD7717275117961CD43CB1D8A8701C0F6BE0EFFA7D5D2A1A17519B274C
      4E769DEE021A10AA9A54C1740F93A52ADD6053623FED60A88911A21C47430D9E
      FBC7643C464208247AC98AD9418606297C72E707E3212E4A8A0ACB5E37082E09
      5FD9F558B1173DB29B7FD3050581804CBFB181B31D904B00DE30C6717B2372CC
      1AC5895F758932C66AD6009209994A995F26B0EAFCAC175BB1B29292A7681120
      974E0A333CB3BB507B86526AD8BFB007F8668F8284E33417808E808245D2F962
      76F92D1DC4F38B3BD01FF872F6BAEBB3F028E7E5C1C185516269F06412C38664
      26AD74703BCCF68DEC20F76CEA3342D8A3B4952D00180F2B6A45F63CD98F4A2A
      80D37B2CB0C7CA926D3D49A6EF1AFFC4DC2F329BB72B484FFDE75989E66B28CF
      635A6E66268F48AB1EBA6C7EBCDC2BD168674D515F1E55AE4A686A68005E6C30
      198B6671CD6053DA5AA7FC064A9412D1F17346B40B6104093A2C5DDD7704D571
      562C99A2C5AEBA129F7DFB9BAA8F0AF94FDF0242ECF6E0EDFA7519AA4F6ED6B5
      D628EA22D1D560FB4BE43D89F700051729A43E30B6E87C90A55F99E868CEFE33
      D9DAF69F248624935820CA463F440ABC0A63C6BE66229432AD8326F0DDF6A5A5
      0BC1AAC94140D1344892D1D27C98CD496FC88174482CC48F4ED46D28789ACFD1
      AAE07AE7D9F3AAE3EE6F921C00A78090CBD2696E9D3CED632070D18211C3F5E3
      CEC3274FBF7F1A757954EE46A728E71D9DEC34950782B475C9DADC1DCE76F5CE
      7EF5177BD24F9A23187C00EAA5105FE6F5F8076E6ADFB058834C69BF55D5A421
      10E58A56AFD5006C1F2EA2D9D01E069DB2B88A3E5E1EFFD06F244F2BD0DD6C92
      C85ADB9EF1CF552A0729D1BA420861E0E9E218E65628C50DC2752BE57103846C
      F124E1EB996E5F8387E04C3915D623FC3D8335AFDB14CB32D4F76BAED7CD2FC7
      536D68E5BD18ECBC2E16F7C59180EC4536922D1886301B5D9777C46E9EE478F5
      ED2EC9B88C07E930DAC59A7FB1D513E0D762827739A9DB3DE25FC9F04AFAB0B7
      D503463144B9E4094FB77A42924FB27B3E628C62BFF77C047CCE7B3D61929453
      88B7DDE30965927C91073CDBEA0157F37C82C204F97D6634ADE32CBDDF8BFC33
      9EC5F75D9979515E27937B76642649DDF7180D9CAEF3C95C5E66EB7E94F3AA72
      AFF264AB4754B37BEFB4EA3A19DDF311F5BCFCE21EF17CEDF17A71F4071CA42B
      0E90257D32B34E95095C80E70FE9E8D23EAEB8C844A28E4C22BDA299F1148819
      34E42FD6278F344A3FC11256E1083E9B0EAEA4A3B926BA149E29CDF690388493
      8933DF56348506C5D764072833398B5228A4ADD0C15A2940A6AAA8F3516A4185
      7F7EE52ABD8640158BBF006F5BABD0252693D744CC0BF2C702404464D1E06A2D
      F6CD2CCC19CB344A493D7068B46C3BADA6E897E1CC0CB1CF80EC434111A15449
      CD6F615A2AD1235D0D6487CF5CF53D5DEA7F8501BBEA7B5F403F2BF2BFBE78F1
      E2C53A94CFB342E99A8BC01C925B9C912CA51B3C8C25DC1B3C3B4A512A49A80C
      CCEE61AE2E59B431D0F8F58A6ABE756F8592082B641218A952785ACCF9C0624F
      ABA66C9A2DD9CDCD44957377BF5C8F5E59C28F9AD981185DE748A6A613753B47
      7947E44FECA82175D8EFDA319DA9D0F67783B0444CD6BC9CECD55FEC113F41FF
      87402F37755593C1D2AA1D2372B5D7694D766CE83C0496B82B5ADF500DA2A326
      5A02F8295DE600D074BF76FBFF2FF03E7EEAA779AA5086FB4B6AB638CBDE8C1B
      0EB7312BAA85EFD0D9A52829DD9A3B58FE6D776443FACF22EF7A29822BF9A6AD
      268C3C621C543FD1958EBFF0AB4A29E81C680D993F2F474840D85BBB6DC67196
      816CBCBC4738BAE65A4FCD7A43D85ED7AD78985D5ECFC7E7CF7B5EA447BF8001
      A0A3A893216515936FD406D04368B5CC09E37DE1B0892F2AC0C3A2274FD09B79
      921AE9C648A8C094C66B084FD33B344660E81DFA233D0884FA53D530E43EE597
      D5EFFB4FDDB3C1F724F8C9861506302E571C61DA50EA0A7BD2F56A9454CC25B6
      775D4D2759BE7CB4B416308E6063F262D273505E5873E1A3E115948D48E0E049
      DC827560AA08ABC15DE8BED1806EB728E678AF45BA2A837309ACB772F12C7EBF
      19A50803144B06144B6139F2E04AB8D5CD84D9A8ABD0D0B2230DCC9B10AF5A38
      8E7738B382C028B7515658CF7799261262692DBB32886A51660BDF4307614C79
      C15DD61F7633628F0813B86E9D268D287BC9772F409D65D19FF3A2FEB3298135
      ACC1D6126A1406EA628471890588E186E19625E666E3D1B69675694EB262C033
      39382CBA788B99AB8802746EF9A5B613EABA0D67213A88F4BCE16C974D879F37
      6E5E2F8ABE1D98B83B9C35696C785B1CDBD4C1315E2233557ABE3BB4D349AC29
      D7164B0E861303661494E6E18A583383978AE60EE20A049D9BF0C00DCFCA35E7
      AE3CA527A6AD2F052C2B96CA754DD84E8EDCA0607370DCAE660E12B686A66176
      A342028D1BE5B665A3EA018DEB8556A4AD05EE8DBF0C67AFBE7DFBF6ED27A672
      A8C6B51C17F25292F0D15DE4A6FB5C478E443FC2635C4EB82D87FCA66D38CBB2
      E8C978C00FEC075B9FE34D1D26F2B29E1B1D98E6380EBF2C9108FB5EA54FC00B
      ECFDF86CEFA7BB98472E1B63AD85D14EDF88F2242E6FA113D049D34CCCA552A2
      BADB9706F357BB46E224DA0F5F1994B2FE271A12B0FBC3C2C5AF24C6B0106458
      FFC025EBADF9D427FEA90737659A65E97083C7323CB0F0B817DFEFED3D89BA1F
      2F8F777F58AFA7B9C40230DA9D1B7BA702D6E67065C564B573BAB7F76A6FEF73
      A88C0E9A5452BE8A7E51434A27A57F71F9E1E4DD9B8BCFFA6AF71A1D15166918
      71B46C139A4450AB78E4E90012A929EA3636D37E177F0C39EBEF964E475DDA02
      D6F8CE5DE7C405D6705B35DF23A8BD9EF2459C42A184087DE86EA3B979BE7C6E
      821337A9A69F5185CB25B574C9ED79B5FFE3F10FCF5E1F1FEF3C541B0F368477
      69F482169CF2CAD650FD16A706C7E83FFEF18F7FFCD4488FC5D11B5C03F79EA4
      274F97BFCBC1CC4ADB5E2655DD4FAAD92D83C8D97B2BB95187BE63ABC77455B2
      AECF95B9DA40A5165742B6F813CFE02D132B13101031D9F36A58221F55B2262D
      B60A9A8DA4424D53B2DA31908E401386EDB574836967B7229EAB854A82C341EA
      2DA01A147C5E8BF1BFFB14BE551B52E29D2F6026797E6B9205543A164A7BEA51
      3FF7FE8413E29F65F3499A57FDFA5BBDD1E30C6FF3858FD5234D73117C0EB25A
      B86C830624133378432965D2FE9D98A892C5EAE0B4221EF1371B753478E55EAB
      32AD54C5C51F9B19348D40386BDA4AF85BE5DC2407478BE65649AD288BF0C691
      26A775214241FA3B2CE03620BB0AC37FD2277C1F52C737FEED53F9AD69885753
      A8EB5D1C6DFCFB67F2FBF3F1381DC2F73F3C3DC02B5FC5E508F693BDCE6E3803
      1B3FFC79F3C5FEF3D307EB21AFF54F1F1A3192E7D1A70F1B3FFA7B79F4013D8C
      228F0EB239E2B4BA4C1FA6FB2FA48D0521F38D1FF0521EB04CD87CA57D7C3236
      EA6B40880E76A128FB4A1E6240A1118F5A6F60EC44D9D82CB906E78C2126D5A6
      1381FE36FF46B50303DB4E56BFFF59C0E5916690D0A0041AD21BABE5AFABEC90
      19A255EC1C5D5497C48AEF0FB262F8E52E8272D7C6C1750E7934A2CAE55AE763
      E10752C2DD72581D72A0DF8307DB3CD26297C4018C9955DDDDDF74EAA05D0E5A
      AC5442E8459DA1D69AEFF7FB7C7151E1ACD2690A013F578AACDAB945905DEFBF
      0D24DC70FD0932117B1D46590C3A4750EA7605FB1696C5266517A41E2AEAAEA8
      163BEEB27349CB553155414B511058AB33184BDA8B3D05456A767A6EA7F57C76
      64D7EA99EBE6DDE98965A12D0905399C1A21D96852EF7B649A7D5B7B6E1BD333
      4C24867C3FCBCABA2234083BB13A0881083AAA9B94959135AAF795DD2A560A9C
      5C3F3A4BFCF3FFFC0F1CAD2FC9AE226FFFF33FE2C9C6E05113484D201BB7F6BA
      F4EBD65E49B69F6D6C7D4E33253D4876E7DF690EB55786C557D9DD5FFA9F437D
      C85FFEF17975400E8AF0BC942D424CC152CDFB200634920418C9CE6EF5F24E2A
      770775997DA7DA6478397923B269252EABD23B7AA031F4BAA45420D11A51CEE5
      1B9FFFBCBEF2B23B3D3A07ED1DDF63411A449E1CEA219C70DB8F41554843FE7D
      BC41721F04A33FBA387BEC3689729E25B48E80FA5A6B65838E86A5AEFC79C94C
      8429242617C1C3556588E84CC459F448F5E98B9C7BD4CB4921ED100B962267E8
      D448667488197DB412C70B8BD76CF9FC05757F8DDD4ADA2A0A81AD113FA42DEA
      F5F6AD540A5BB388F755928DA211760FDA6FAC58D99E228EED1D3F393A7AF85F
      116816AFA28B0CCDAABEC9921D0D25B9770632760745A5636630BBF202C928EA
      4FAE0A6428AECF7FD16F7A44C86C6CD0596F04EFEC6A484F8F6964FC494E24F9
      9B0C5B9BCE81268BB87C437DBC4F885F6330C54AA8D50648A508BA281C7A59D6
      E1C7807CA82AB0FA503D92F730D13A74528E0579E2C713EF3E51AC7383375859
      9A3EBCF60B32BECF8A916A746F969BA45F8659168D13A9E5A5E9D2BAD29D6AAD
      52720A5CD9E954439DF8DAA4A0C3ADC93F758D81C527E1DD3D8BABD5EE1B4D43
      AB67591728D4294195AB789E09E2BFF06E3D6F3D69EAB7BE42A3528C00C2425F
      9201C34420A963A2555D99B9A341881E6F6FCB219BC679CC80976B7B4D4525FB
      9E8CA832A66BF4440691636B59425DD8C0D7608DE6931D874FF15273B2E26A64
      A8089E53B2E5FA22E1C2AC12979115D60BC5DDCC88854B2DA2E9BE4365DE2B25
      52694A47153C837BCD2749811D9D0ED319759519D713ED2E689EC8892266634B
      90D6A999E06454730E657C048FB9125C7F3EDB74481954919279C620D1C1F3B4
      12351D8B329DA4B848D48191C15CD35095209352193E346A10E5B662E4818080
      96DF642AB3D65995A304E9D7AD77D5891BDC04CB5792417100C0589CCEEA9BA5
      92E89AF90DE17F31D2518A92127EAAF5EBFAD6E907778B65CB9962060521DC56
      819B879D322D8442049214F37C086F58418A277B7B8FB80EA7D0C7D6B230C6C7
      77E6911F1B2E4A572BCFEA31098016D76183AEEE45589C64D58B891A51FC053E
      6D2D878C1412A7D759A87A700B61EA39B56BF1BA6031EA4431075ECAA7362758
      6ECD31960D849CA0036C65F4D07F3F7D5040227E8E8D8393A735E79B07C2D439
      95E5ED4D12B933D61A66C42A3D984BAB9DE8A19D7356D9E8D6265C104687D97F
      2AA51DD4E954EF5B1F455760E149183B5C06535C6605E0B1CA9DC66B3D2BDFAE
      E34B7897B41755852B90374A556348CA4D282165947E4D47301B1A93A46E6B4A
      1DC8F50AD8703B18BDD6B518786E54BE073092C415F4CF581B3AF649A0D6ECBA
      0346D22E09196839BB209BDD5C9A50B87EF3A574443D9DC787A239C0077F48B8
      21DC98AC8FE12F964E6DC83A7282AD342924AFB4313053A46EB66BAB17DEC0B1
      AF9C88772FD92FBE7E164E9922F36216B935DB0661EEAAD02DD85F78856F865A
      40714A40E1C28E81C05E92D1F978B29E2247290F213A787FFBA983DA1A78DDD2
      6C75C7500CEB03760E9A5DEAF7FB9D467DCABA35A15441C612E323E8F79E052A
      044BAE1FD3DE548929BAC7D268EB54191679A55788464CCC230CD56B1D2686E4
      A6190C4B6728BB27C1442A560B39092E0785120CAA54D52B0ACAC968C2BB536A
      15ADB31A9485AA8E9E39711AB398BA6A1C7C87E930E38B697ECBF742B370F0D7
      859D11AF9E955E60243180E74B2EC18E684F8D13656D6EC140145526C64D3A67
      88CB444C0B833D178E6A70BB6CF739E087762932CDD3C1BC76AC155FD34CEF00
      133766A7286CC10D63C7B3E0279E94A20FF60A543ECF0E0064B08AFAD13ECD1D
      5CC72974F4260D78C3AD9EE6D2B34CD3B0B6C59215E5BE279CFACD0F8FD673D6
      2DCC76B3BE0AB7F1EE1AC3C20AD841E2E146D7086C861602297CFF70119DE428
      06B711E0A8CF1049CEF90CC704C187F69A8CBE8B0E44F0FF232A00EABF0F613C
      AC6AE6E0C341AB9FD4B1340E58D0C8C5553AAEBF939E1B8D3936BC5C5474E528
      E15146A34FBF9C8E257A21A3E8EC59364DE060E963D67A034DEC0F68E187037B
      95510203AB39E887FC6C1D0211C659D8C345255C1B9E20B412687CF9B4928620
      8AE047D45C0E46A392467A92637B9DAAEBE8472308794A50F33A463285290CAD
      863BE2E155935EE2D56C80386EA9B5EB50C05D2617DB6287EC66A0D32C76085C
      3CC5CDB4C72E7CE036A3A06664C16DA90720919BDDC848124D9D3356ADE22034
      9CF5EDDABA28E6E510597EFBED33B8DD98DCC80E0DF0F0419333A9310E1904F5
      4645653E18DB605CF565857D1A9080D9B4F6CE7AB2FCC0DAF4558F8B7220FDD9
      C5C608DFCD450E05380B519534BFC74C8A3468747A2E4D0288D3570FF65AB89F
      42015E3FA61A547534E985F168D9912E29C6C63980E28501CF10D92DDBE5E553
      BCD3CBA7E13B25F928AEAEF84E5AB87BB7CD2D684A023AE0710A6CAE845D1467
      597FAB16D33C7A8D282C6A7D620D1679950CE78DC8A7AE41D827083D50513E96
      5FF5A3FDFCC645545C948C71DDF6A02B8D1D4EB6AD0CF57B179F44F3E1D62799
      8CDE2D0FA2B4A033C55D412C7994530C66FDE51B19DFF5963F4E403B12A43000
      EF0B9A6F6ADF0823C5DD209467E6F5065A34207F15D7E657DDBE66E9D2D5629B
      3A6E4DF00C921C5038248DCCC6679282D01233AED65EB7665BD2FCA3C810A714
      5E70526E77B8BF6FD8B9EFD4CE55B68DB30BDCE52B5099667E85A20CE1E9DEFE
      9B3EA40B6DC4CA23EBADA8E3A63D6647DDC54F9C8B51B61BDBFDDA1CF58A6637
      443E445A424DE62C9D0D0AD6FB70F63FCF1A9AC37A7EE877DF916AB6AE74D352
      4B79D1E46520B2B7CC1170022D3E48BBE00CDC669C06355A20CA2FA93FD362C4
      A2919AC1DA380C03EB7F037D4DBE9AA12341A3F079DB8046E0F13A99CB4674B6
      2ED3C984B179730CF2E41AE01E2D2DF770DA2E4DB54ED1455B16465FE12DB486
      6125D0D0FE2EC7BB45596BE43C78A370498A997BD8063263DCDC96D816787EC0
      3B43E3D40D8FC6A0D71E7842E210D6BD90182D29C3081C39F359AE926CB58B73
      0E80796180BC8AEFAD6323DF91C415DA824D11FD75FE90823BB48E9637AF72DA
      8344C26030D56F33C7358555237DA261D3906B5F6AC8AC84F83430B51190B50F
      0B0A7BA8F2100866D7CF2ADC24E074518791A95B90A4164B7F59A9FAF50A8B0B
      EC2315B895C237B7E3D36A946160ADB89DDE0BDE22B4A3930BA27D08C2AB11ED
      C24690AF09E8DF25553B4B7E9F2910DF31E8D3EF3E0B0DBCC20FBCED200724E5
      4606F3E8E5B253428C59BAC54B82D8B70F2929A9E6AD3FCC68E6514788AEF49A
      D3FC8F1DD510925B58E6ED6B78DDC51BC60CEB2BCBF5CB0BC1034A47140BA1B9
      830F071B5CB12A50B76405B86171DD0BA22AD6C15B1A469FC3D5B11E0FDEC4D0
      B92A0A3626C64623C623A2D85A6F4AFB4454C519040E54317A57C892B81BD902
      2F2EE3948CD6AAD6B6BEDF5C5DB8521160BF0E20428F9DF82BC58D96010E71B5
      F8E4EEB79D3B48FFCE2113D17E466773E6D42D0F10C48EDAC7BBFEA4F09984BF
      7CFB6C2FB19A46F57D3F3A508C4DC24B749A2C119D57AE288454D0C593959C47
      4FD7F3D86EEF1BAF0F9776E3E7A1A566BF343623C19885D1080F995B6CD29EA3
      40346E366B943E28DE5C92198398433CD8E06585C6ADD8FDE24B52A4570B471A
      AABAE435A83C4D9A097C58674D5B35CD655192A5A3C4245D71E6EF5278C17279
      8414FD8B296B7FF63E881FB0CEBA1D29F4C565BFF4B3D57591D755974223F413
      F0B037265F5B7A309914E654720341117F711A5038A58FF2A06552CF4B490393
      F462D8C3954B627276505C45A3329EB85C7DD9312E0BA851C04FED2715614CB2
      CC2D783EAA4425BE70F9D93528771D99145ABDD078A0B3B21864281FE63C191B
      E035983BAB77709ABC88FAAAF96A83E71C18355754939DF49215334F525BC08C
      3464542AD17D4D3247C1B505A1B79DF102E0C587F2EFBCFE8CA57F97C56E479C
      138332B9A9F5E23106EE38490514C8113A813DCCCA7661801AE711BF26396D56
      887055836F95202BD11A6223FB99C66B1CE548B96E725EC0F4B1D07D45402B15
      256BD7370F10B033EB6AE4AA15348C2BBDF8430653A0A3E5725D409291E096B1
      B4DC1745504DEB330A59C4E49404A3BDC3CD4A8AB6105414C15817C75B2EF310
      52CDD47CA1D9153C5F4AB418F3ADC1E21279B3806FAF5F541DB1E9AC28A11DEB
      F8AFD7B17895505C319622106910DB6938B13C9338DDF811A5D594D967C70B62
      10086E26D3A2BCB1D273CBD4529B43B0CB213BE41BA11C45D52A9B057A646129
      675DF7AFBFAA9032A3F7BDC87D3ECA86552F3A38A8761A303492C604705DD2BF
      3B75EF558CC4B4DE001984BD21B264830E3B565C0315DCA00B023E33408CFA88
      2AB5EC5F6BB9A1BCAA40E70510878FB914F1799BE675272A13EA9755FE90EED0
      90C37B75D4B65B6B542C7B30968A5AD5AD72BE5DD42975B55E98036A559C1562
      06863AD7A7194395BAB762B13CD9B3EA36511C417EA540DD5054B7723B5B1C95
      792EBF49A266B151D81D955FA4DA92C26DE0AB15D7CA670626E3379D7E73755C
      DBD0793243D029CFEA942D013E1A29E06D06D3E6CFFDE51FC89CF14D206DD66A
      D52923FBC9F756B04777708A8A0A15D6176AC4C202459A0CDD39F42F2F8A7F25
      EEC76E84EF7851C1831243D2C23BBEFC6C912F96285DB8E93BADC7745F17D968
      C77EDBD145D48E8D777531091DA59CAF51F6BB35DF428F44E3B56A78617AFB3B
      69F2B3D25C198D31AE2A8261E8FB1D6A962A8E97E64D8B6AE3C4A565E698A8E5
      E1FD626C18E145EE8A68A10A47E28D4E407B474A9C537497F8F04E2F3ACE8A18
      3C61E4C57100A82A2F1F489D5DDEB5EE594264641A870AB3ADCB7FC1F1614B7B
      59E754C75E346810868E466531133A0A763219C9B382A905716641D46E42B786
      C68C563F0D6CF2ABF90409125D6750327827DCE67892A7F57C94ECC031827D70
      87399495613823DA5DE77F2CF949D45591CFC1CDD2196E52BF680F0682FF3B3A
      E7C839A922C962839687906268530CCA24FEA2CC4A2B794B9BED58CCE1B8F4D5
      01E0E6DCAD8410AD883A59498BDAE70CF8824530438CD16E7910F294D0981F5E
      A5C9BA13B8235D6851C75D5DF1D3A24ACAAA137A67923A08F862E54F2B49B935
      39BA46B6C22FC3DABE86062A7145FD1F4F589170186797C519ED93BFA77965BF
      E845FED7F83CFC6F79DA5AC4F659B3EF0434837ACDA16364B719C344383DB9AF
      161F10759D5BE4CB0DEE044E160D944A753182E88B261AB85C0BF7839E6934D2
      6E958282CD2678FB370A7FDB22D788BF5A9B981E77D9AB5E4D4848A51085578D
      D35F14F37A88BAE8C604CA8BD12D5520DBCDCB692737A51406B21C167986D3E3
      B04A17288AF20891509EA69E25D274287DAE8B7D41B229829212A332F63E99DB
      2DC14BA9B08CEA9849D10C9F1AA25F6290234B626455A8341186A8513282BF92
      EE1BD51D7920EA12B89943B8CEE45B9D7FC667AFD997AA6DE3674FE7AD772BD3
      38ADA2CE1814196AF875A2AECA71B8ADABC2BEC85B0A8A539B57A47363C7989B
      4AE3F91640CCEB5E30F78E2EAA85C92035190C3524845DA72D72EC33E46DE1A1
      24A65471A9CBF9B09E43E6CBCCD82E112FCDB9090B3013C0143FCA537CB55DAB
      81DA5AE8B14C22D9F43475ABBA28786730D9628E73CEC0B5E8D2A75D81203047
      7C181126B39B0D73A6289AEEE6657302A9C95854BF694149671BD34A636AFD52
      D0F32658A107BA42E93D24DFC01DC24807C903E269C809CA19384DE271D591D9
      E8FC6D8E3B925FB1E353303239571AF08681C86B4FD6CEEB9BE8755C251F3851
      1DA532D32D1B14DFBC22318F338B970708ABA030AE36CD8002871E83EDFE5514
      A455D0FBE0E8F41433883C3FAB392C5FDDD96473B53AE749E1BDE8BB5EB42BE3
      F467081957EDA43C4565A28EC08B802D3A3DF75FEF8A3CB1613EC9BFC2907091
      A1CEFAE45AC961090AAADAB16FE5C46511988B68515EDB63965B12EC54D38465
      24C8F24634A6443D9ED888305A9ED1D2F075BA1CCB85F41C7E519D5057716DE4
      DA6D3155081CF908B3B478174F291E5E2996BC6149C53078E806D1C80CAB3371
      AB040680C17C8384372010147B609C6DA809124A785BD9EA256FE2124CB586A1
      53C41ADC483FD780BDC66A05FB918C3B44163AAEA90E61424BD796425A3D0F31
      C6A895525D0914E470660367C34C40B9D143104671FDAA90CB4190EFBA4C875F
      50EDAD12E109E767E0B22CA8CE29EE5E9DA05AA2B509B1E2F5C9A5E7B2BF978D
      A29B662B49BC585FDC9F9CEE118FE7B97F9C9D31FEED047D58341537C2E10F54
      6F5CA42B2D917379EF5DBD49AC4786ACA566F75CD272C72BAB779B667C2C25C0
      A14A0635645A398892B830A8D4B74758211EF06C455EBE28BEDCDDEDEEE8B502
      299A8A851E3A81AADDCA30D262F94B82B272B08ECB049EA6A58F87AD04C79FB5
      D38F5E6B2AB725E6F2FE2F084C9CED5F5C46D57CE066D6A1BE81F1A1714A3E97
      6E2F7428ADE29A63B08A2AB95CE13CDC20E02A710B55B933C6C73C977A5DC059
      303D5C43B84113B16F40EF4DF328674EE70EC77F961452E896D42827CC80D21C
      C9CC6C9538376D2AF1FBB50A1CE6D4D5CD0CAB826E50BED39FEEBE96B4593DB0
      6415843763AC2E1AB361195EB2CA35473F1E21A35333C2C07FB1F20549D4D91F
      8DF40161ACF08EAC91658D72C29376BB24DA56A2C460D5295D2ABE5A1E5289CF
      D90E2E3FCB1E9447BFCD93CA15F875AF42D36BB397596D319150E1E31DB6EA8D
      2C1A2E7E266C5A6507D28EED626EC4AB88B6CB0FF93B8944E43E9BBC2EA2DD93
      9FF3E2FAEF57717D323D2CD27CD28FDE830AA415305DC1898664364E290D75A9
      4A9126AEE5CC5B7326DBA88850AC20BAC613F817542B652B772D182CA8A12C2B
      BA6255C16B4B6E23F3D04C2D6935CAE1171F8F7051ED5288CFA76407041E9CCE
      AB91930B94A1718B602942127E25EA725522B368F182DDE9B835CB9C6F5B5164
      20E04D5733E5DB2B7269671ADF8129FD41370E3D225AB6FAC77BF606F946CF02
      14450D420DF0465314D31C7BAF04EB8D9F914B22B11D2DB62AF53C90E6E9F76E
      96E074541C509D863C49148718F8C3114B99C4A69168DC9BF466287D93B2F42C
      AE7909EEAB2DBBA39F368A801AB2BD8512937862A1EC2BC0E1D56C0B0DE4DFF2
      4B03E35B24A00DE40E90FD637EA7A0094717675481937DE5CBAE48EE85974D13
      749907690015DCAB34F87B5AA41F9271F4CBFBD37FFFF06A8FFFF7E4F9670CB8
      410F3E73CBCB767E5B191AF18FED6AE6963D9865B889F82E793C5E276CC2E540
      04816041D182843F553088B340095316935F88EB6A2785E21CA1D15A97F09DD0
      AD0F76498D203AD3762038AB4B2DE81563FFD6BADB1F098A9554B661D6B9F9CB
      7E1A44FE74D7114697386C8349A58EAA10B8291F3C1D24041203932BF9B62609
      74C1C26F54451AC5756CD77C583D3709EB07C4D1AFFFF5269E264818F9F5BFFB
      FEAD2C4591AF374856746AC5F85EA6B38D0794DF5544A95DCE64E9C0D63C9CE1
      549B5291D969D3189D2D36F01E5DC3FE70350537CB8CA091C93D8FA7E1CB9010
      1606C8E2E4DD7D8C8C5374E0D27B8A7CD989B2D2D392D4A2DB99739AE4C9A6CC
      3C638CD52AD5825F2CC983F699835C14F56E2521ADF6FC94CEF3DD41AB615F86
      41CE076DEB19EB87A0F5CDC7ED974F4979F3395A82E155DB119D9AFDF32C9A95
      62E8BBBFA17D2C5B2F62B4AB28539058B55C17B389303ABA8AD4D980CE91268E
      10455B1A6AF202475085201F02E63C8C4FF2BC95CFF7D469A7FAAA59863F1A62
      825468DDF32B5F1871DAA52F6DB11CE2C182252DBE605873852CE4864C7DA0F5
      EDA09690DCDAC8EA0B503A13FE4BC722819856A27ED86093EDF41AD83C5D3FAA
      8039AE45830E64142F3BB25B154D02A90F4BB912F556EBB715AF21C42AAA711A
      51ACEAB89E571B2F7459E1BF8066F35920EF3F7C7DD3D170EB3A9029B62A6281
      CE40A871BA20E71A96F2581A6C5AE4395B75090BC22DE829E450C3E716F9988B
      9C02FFCB148C9CD9A0E1D88EDAFC1D1762F57E7DC7133AD1530B29DCD6767FFD
      C8E15D6CF4966C10FAD2B2A77BD1C7C30F3DF3484E2ECF3A5195FC3627A24FD3
      6626F6D633D1EE6F9F1E4A45719EBE4C15B0368474057E6B2A93755E9F5F5C3C
      3E3D3FBF748194E84302ECB5114F59F992B236C5AD92C04993A33E2F735C32E3
      A87341D9CF48A2225587AE60923B7482340D78F48E34EFEC9A93CBB376C15A51
      5DA6CA55E724822B1FC1978F4E1E4D23BAF31AC6412386E718E924BA8E4B0A25
      AE8195110EC3A80B162D314239D66DB00EE36B94F1294764F331D7C6DDA85531
      87A8425AE600A8B21133B225EDCF79719A096E278F86E9B00172D0D7A2B4AAE6
      AEB0BC89A50720FEB3FED3FE134DFC7688E6126AFC02E2324EBF991754CD1343
      54D42B80B767AA3EC1FD838862983DE2484E1A68372A9497975A3CB74C69A828
      89343174E2A851E6B99A069BAC6972B1030EAA04D3418F274AA45B08F51635A8
      DE6412AC2FA3D08C02873D9755ED20C259598CE6438292E998478A642AF136F0
      8839266E1AE7F0A7A7497D558C703939A56B1769D7A30F231BFC39E09A7F3C94
      72050AED9D5C9EDD81198692328FF24787603DB1AE62D170F236668B9D2C2188
      5964A11DE1B9D5B86CB40EA0354C28502D2CCA7C37CE2F8036AC4C06F68059A6
      34F673C659361F8C33A81CE0922FEB21EE652850FFDB7C3A8B2E0B579E79E311
      31052311FE5EC69FD337D2A9A49A976BCDF222EFEAA7BE8BBFA236D915B4931D
      2C78D7E22D3D84A6625ED7C9C8D568C33FC1F102BB4BDD99C0284C7EC342B66C
      63D3BB0C3365DD33F5E40E533E9CFB946BFF7DD513398DB569A422311E344ABE
      F9D083D023A926A9FBAD1F753F589C68E14291F303370E02B1E3717F07A99E68
      E7E06762445C6EF1206574A9BA9A8FC72CF9138BEAA59C1B81DE492B5DA3D5D9
      5695DC32218507A7BB0A4F073183C6CFAD56A9728326392BFA303A95E6E09308
      C29E0737E1BBFD4F67720B72F1780B4F64737BD104500C71E9D1DC5505F4E6E6
      BC1CE3F24142A0D06EA8C67AE7E23F3D29F158A6A8AD508C11BBAAD3A18E90AE
      025E5F44E5C37AA5F866F22D1A1645394A73F24A83333DF886569A5CD5B30F8B
      31408F0EE8F610609E11A3B81C0990D7883173E5DBA25C13295A1ECF168FDB4E
      81CBE626E09070D6BA83A2063152F7416BB334E4A5838D180CA86CD51D34F94F
      9C222E80E70867FABD2052D31351333287F8A6CA66BD032669E8CBD5BC266B56
      FD09BE48398768FC0630ABD3630D844A1D1952C2992E4518BF40AA886765B007
      BDE043C406E579A1585A8BDE8E74AB329D5C01CD287358D5EE02779D5720439E
      EB328BB5BD06CEA972325AF53E89CE7F86D55EB7491510515C4FB6C945BC21BA
      02A73E77855B2CFF4683D6C1A8F756745414ACDC6C2CB191700DA7F9FC4E5127
      9732581788116D9009197EDD474930DCACA906302E54727A7B727976541924AD
      1F327BFCE4307A7B3281C37C09834A037F477208EF4483046A53EB36AA9B6B2B
      1AA1BE05C3FC4C08E9F2D88E8765514189A05AA2E7B37A804498739464752C52
      D062FBAD1BAEFDA813FC860E96131B518C56568126FF3408613CE06CE70C92FA
      9A5CC6EBC2D307A0F42E76D126AE298FB49E569E0CEAD1C2532A2505AB739680
      374F78557DE33EA85908674AE4A8DD7CE8F707B6B27FE9DE82F6EC621BC64E95
      2CB0D29989E1783B1E95A096A6F5DFD46C6A498DE32F4FF3D1F22FAF86327D51
      E1B013C2240984ADE5B55A3BC2C44843BE191C84A01B6EDC84A06453B172A1F9
      8D16575F82422C49D97E419A61C1C4B415AEC468321A6BD0D8463B8DF3C91829
      020DB31B475B6874C5CD170312B20F7BC1320832E609904869BD39EF44A74CD4
      FD6B74C40D7C312C0BA4168B3207553AFCB7B85B5014F14D32FC82D04B2D0B51
      EEFFE0F5A0CFBBD62F1C1633024F523FDADED74BC105AFC06116772FAE96AC02
      722C68B8B8FC4AD3326A2E87168006868E890222166ADF747AB5D24527EC1CE8
      2FAAB268A371A3E8A40EFAEAB65EA2345CF6E4F2CC9765D8F1A70E16CD75D12C
      E5C4845B117E753EF8A66B8923CD80B658E88D4D86DBE12E47E2D5E2B9B4E136
      172B0F4D4CA792E5C06616CE9E4A199D187135C425C155B1213B2DD6C49D4E9D
      6DD6BE43C3CB2A185C2D81B4D1FDD5A60C067A76901047E66E1DE7247CEBD1DD
      7A45490A686861356F17F9295020B9A69D35A4E1B9D5D95B207856A2F5CC693C
      2B46FB1CD0B362F45A81775127A9DFA34BFBAFFBF29D4951BB0020BE85275CE3
      4D486E9C004B0422842840F86B2751B849EFF4DC6D8E49B8C0B061B93583ED28
      0A3BFB7AC39589442D657D9834FF2BFDCA219E2B3D2355FD75AFF5AE9B39235A
      4120F44926386659C8ADB15FD23C6CD3A5201AFF6BC5FE6A30A7F5BCB2F16FBD
      BA21B2097546760737BB2E62CC134E52EC444349C64906B0F5B9DD51FEF3D63A
      F83B7C6DA6AA6B04114BAF7D0EB805D5186B1EA2CA7151611820517053F1409E
      5CE140C1CBDB786256DFD7A154BBE3CFCF4B3A054CFFD6B46AC0274CEC907313
      7FE96ADA7C31AF39A2BAA8DAA7CDCE92CA39A4BAB9DAF60E14C563D71FC98800
      F87CC879958CE7196BF6C4D8FA126B746111D1B20D9EAF9888E97F9A8C53E35D
      D5FAF7686AA0126ACC39338AB426217979C524210008160867DE2EB0D6D33994
      6E20B51651383E7ABE0B8CC5D41D7DB48F9735072DEA9EC58EFD27CE9915840D
      0C703D46C304751F260D4E922A09DEDD5595312E979A665622A8BF79296C339E
      C6ACB6E6E9F40137D69B4C2BA525F1204BF5718FC1931B8F088B99F68018A65F
      E38C119782C3B6491392CAD4B6E4DA45B3A13D8C65E00241560AC13187AA792A
      58A211B520ADFCA5B12D9BB504F038B7C8429166B5591998D978E85F131C20E8
      C7D2146F936CD68BDE25DFE6D559811CE83769FD763EE8213889C39612BDEFE3
      BA4CE0FEC793D53A12F6F4DB720F5BD087BBF511B9B94EF311A2DCD2B1ED2477
      F136102FF7EA9B1CE6252C9B4D9FE8464655A7FD7F6330FCD351750A98962B34
      1CD7BC0424608F489FD71B71647F2B0A1557DB754EE62ADA953BC795A660CD1E
      81156A442C4710F729664CC90E2E45EBB707F824962831B72DBBA4CB46474BDE
      D93EAB92F22B4EC50F499CEDF2381B32DB9136340F26F9BEA4F9E176D49E8310
      1C1D81D681500BCCBF2443D2CF765DB4D5BC1B1D6553A252E5FEC74755639507
      CB06D5924A3B5D2467A62AB2398B110258930C7D1F2B2EF209E2BBD178CE1283
      E1E0DBA06FBE5D55DD910C8D8D852665596C985BD00C871BFDD7F2EE963AEEF9
      062DB86CDF30E2E16FADCE2119BEBE115DCA62BB1971766D169E99F38D4A52BD
      B6864A5303DA4BA8689B8A979A06D55D6A9AE959F07B0EF5468DDC75B4FD29F6
      870EB86F76F5982FB4EBCE4E6029702FA7695EF861EA3251FC797FAFFFAD173D
      EF3FC5FFF4FB7D589C5A7DA9724423B308059AE329D43541FDD40C7595F0D177
      75FC28B7F205DB66E1E120F15618ECAD697009279A097A0728D70EA4329922F0
      583606793594DBD6107289A157E9E42AE3158C3E590B321DEB66813C069938CA
      66A5D442D2F1644B8A34B88507294C114372C837DD5C25D1B2F0A0AC7B265DAF
      CF5C067D86565289D583FA3D79513A9E7D2BFFD78AB6B9EEA5013A3CCB10B7E2
      04D928E07916BC1A158802F2CF7ED5C25A4FCA699CCBF5DD7EFECAEE6BF28E45
      AEED42F11A72C145D18F8EE5F29005481C430D4FA48254AAF4037BD3F5379925
      50AF91B526727E88B4E8B5E540AF692139784091E6795ADFDC85064C8AC3753A
      42DD76506ED74DD7E22FA2AE6C308E1BB43597E96A2E884E9A31694572D729EB
      679936AD96688CF3229DCEA7DA95621C5DC599E2CF1A83D53F35C89EBA655737
      E664342DB55A490ADB59B017D61DA90864A458CB6AB36AE79BF4BA39FCAE3095
      5AA94EFD83E88A24B38BB0AD2466D2C9F7DE9F402F5BBDD271CAD47B3509EB14
      5593952ED30D69DD3B3ED9ABF97A16FA819BE06A87D0FD07F74336A256731B45
      F194D2D97EEC2C1D910D562924C116089C36284AFB505784702B7EB1FD7B5F62
      6DCB8BBBA527D4074F765EDE15028622FAC10DE2BD0627F69147D5B04C92BCF1
      866C4616A103221B2D08E398318A85C8EB5D5EED620A04711708D4009409F52A
      DC5B93932153DFFFDD07406F2756D3F60D05AB806A2F8992BB87592A2513820E
      35748EF3859F6A4C7ED5EAA59A7959F054474219A08DAB729E7F415557A7E062
      0FC5BB059934ABBAF470F3BB32D3085DC90BCFCA21F38F259BCBE27AED59DF59
      F3FBF6252D6554478F9DF1D4102C582D44BC01958151E3ED8EE013D42E94E2F0
      A271EBE51B24AF6C9456146900431C315C68F02A4DC06972E1C013163DDEE075
      92A793DCFFB540C015863EA6F13E35D458650FBBC668EEB7F6D55075498D97AA
      CEDAF99D5E304FEC92FC564BA8297163EB0E2EA8B807998D1B8EDF9949DAC1C0
      0ED7D8DA815C9FF9494B31C9624D4465E60FF3911AFBC8C52DEE98F7D4509447
      ED8BB09D4FAE9D6509513E87C4987A831B5AD4D32A19766E5396D7B9FB7E6F3D
      80AEBC733913D91711FDA2614FE68F4821210D78C94848A47EB1DFE28D0D6EA2
      2B1550E69E96229A41D5CD2FC90D057639F64ECD433C2EDDF4D22783F09D8D13
      4F994B872FA50BD8672B92A74AD3D0682EA23D33D9E5959D2E04A126548D338E
      525397C094BBECBC756290B6DB646C1891E5D06C937CBC9FE18488F1FFA5AC75
      59C6378E7BBE79D582750F5A59910042A39B1EAE3D88C72AE08E262A9DF88322
      1715836AC797A6406FD65AEDE924274C4640BF362181FFB5F24702097C8BC1B4
      EDB9CC260646381EC026749678C4844951A8A6CC02015AED6D659AD17E14BD8E
      A2D72BD1EF283A88A2FD95B1DB557FD42A24360C36CCA10A08BABC6987D77475
      DDDBAC7E8F68F5AB809D2BAB82F6545A0A73A66B1CC8D08CFA6B23B953170DFD
      B6AEACAF1D9C195D5D433B1A5250535D5637D5F9B91449A25DB6D8566C42CD58
      C4B6E68973B9C1B97E1ECA96C6835EA031D7B02451FDCA72D907B1C6ED4CBC71
      03F7F20499354B2492063752412FCE478FD16F048DD7D7690C120B69367C8178
      4DA01969626F9AE320E9821817897637820532ADB8D97185D04C87912F722F74
      D88A626D6AB30C0FEC2C7717B34FBC32AED26C5426792FC2CB434047A2EFD224
      2480F463DC04F21254EE089234D611322F0BD3D4A4A89C07AEBE243792E93CAF
      B6B422915BFC0ECBF1FF72006DBE740A90E6B5DD63EBECBB4FF644CEFABD1FE9
      E47441DF7EE57ABAFB932DAEDD9F7C63BB3F35A57AB76A31A8A8FD4A6C0E6BF4
      96F742EF6E6F7603951A2D0022B34CDEAF12DC1A4F5D7D9E12243EC32EFF387B
      8CBE475D78283B28114EAEBDD50CD73FDA1A2298EC16185D404A23C13FACE39B
      B0D8293AAA37F506D5A2A097E3BAA005C26F6F15D53B44965161363947ADB9E5
      3184208860F6C5311F1956977409723A9E9D65EAE5527756F312D5BE5303DC51
      F79963310A4D47E64A8B152AFE21DED95E768321A2AAF6BA81C09766B78EFC7A
      44B402304BD130A4B567F12091C2322B56ECE2D91CFCB4EBE31376272E55C996
      A012F19266368B4105C2B771B889A518712CEECAAF29932CF90A261B183601E4
      D3365AF2603D4807EA9B995245B1C305A8A676BEA35111A98688A34481EF3E0F
      AA8B0CED4256EDC6F9881C034D5A540EAA939893B486CE2F874932FB2CF21681
      B6C06358D3A057AC63CCD3180E1222E38547761BCF54D553F76C5F3C47388E2D
      0A2C6C6087EF375452E2A0660F1360D5F456B1558595E2E8EF1F4E0F6911451F
      8E8E3FF8CFF1AD1D4B92F482C98105C0C462CDA4C51DBD30965C9EFDBB29085A
      F85B033402B4CA7960AA30723054CB5A0C327B659657A787E15611115BCB1EE6
      76310FCF0075C4C3FE5F73DFDADC36926CF97D23F63FD47037D6D4344559B6DA
      ED56DF99093DDDBAADD788B2DD77BB3B2640129430260136005AD6C4EC7FDF38
      27330B058A7A18D0DC98FED061492450285465E5E3E43931F4156D04965C34C8
      8A68C48BD48CDF6420DC52C28035A5175A35A4875A3EABC602B9D0236E8A1572
      3AB3E52F5658FB689A94B7AE2BEC99469FC3A85A3A26AC5C8A779C67C4CAEDFD
      B446F81B96E72A467576306233C6E3EDA7B7A01CA57F07531E5A688A70A88F6D
      A807BFF804C532C568C1177C80F84A238C804C5DE9A734630CB9A2253D3C917A
      CEFCEAE16985A106EBB2FB27BF8642420E84A39EF5B0CE6225B07D3AC144FEA9
      D62EB882D085C81A8C0E6D9EC793E48EF8E15248A2B904F4692E470DD06034FD
      75A070E4F81DE2118EF6E5C081B9A9B8EED44EC3E087D2D82AA1612654154756
      4B80AD38529864C18D3C13E16D5C567DD9D5ACD7381E85888218BCCA5AA9E068
      193F8C14FD28540ADB12FFD434B44FCF2E4DF10994343526258D87660A56ABA2
      227D1FF25362546B68D9FC8A162D3D25464B078FEB0A14EA739C2B7D4075563C
      B86DEE7EAF5375F786892EEB7E11A6E17BC7E10FA82791E89E066D41201AAB4D
      325EB60D0CF35C75978459190F72AD4DAF1ADFA7C012564EC1E708ADA7C2F84A
      C270A9ECDC1D43ED76DA48A3DCE1AB39B799321E71AA6ABCBF15ABB68D041289
      5C7BA60B078CF55562BD24A3EB2C91C6E7CE7F811F427A809506E634F3BF78CA
      1CA8EF535500EEB6DAD814AC7CA81026F2C8D3E9914CF7C6982E6A33C864BE7E
      EDEE3098D0C1E71F7E11A1581E63A32738FC629689BF5B3E447AECCAADB96B58
      FF5FB50D57A9262A0549D02927798A2515E949E83598A2883CA9BE96EA0B4A94
      A79B663A5D9E2815F5AA0875E43A32888011EAEED4DB544A4DFD837A047BEA11
      888353F727B209E809308BF43C22A5C00A67D6D7F4660B404EBF22F526BD457A
      E4A3DD160BFE6070DC793A793C48F68A3B07375FA13FE0FEECFEF7E1E1A1F4ED
      94500694C8B47201287245A2F5E058FC8F3FF16B64E8A6519844501D0B61F365
      8639486F6BC217BA8A9FD0D3F56F793A5D18DFB67F2779367BBCD95A0B4A2A7E
      5D8934DA5315D7115831B009BC571984900FFB7EB487F7AD957FCF297E986EB7
      92D08B44DC023B97DDCEDEA524F70629C84DF324B45E6297E54D7D559DFF1DB9
      EE853C3610E2C4649E9DEE9CF8ECD8434FB37E987C3987ED284AB07F6DAC9F66
      F5DFE07DAD4B5E1D17950FD84FE16D8DD14518F8090009BC7CCF18C01C07E67C
      266DD88A8B6633D6EC6070924CBE0EC8368DE6E21B9F1A4BAE65F21FF674024A
      5DFB8252091066F6CBFA6FAEB89D0DB369A593120012477263B1388F0813C810
      852D3FFE32576A795FE7971827A0C197F3D4322FB474A4A5D3F639A9A252A3CA
      CE73DA35E8708A4F822837CBAF32CA50D78AD2B82FF2FA1E44A8EB9304DF1957
      23E54360FBF3BEEB8AABAF791E63D25149389E5230B3632F56A494CF555EC838
      21E50FF64D0300B3F49304CA2B9EE74B2EB8DC87B4226763D9450B8425C14840
      AB27EC582761C724CFB4D2ACE25ACA78612FD25E8EB4912FBF0E66BE2A1E9865
      4A1993C90B5F168EA1E9B462CEE647C12BE2AF0277129689946096D6404E5343
      BBF19D97671D5DCB68BEA7B0CA8441A4D744E373D91C04BDDDB24E038634BF20
      D94654FFBE7C38FCBA9FD51517605FA5DD41B7857E5EF605AFD90D52C7FA7215
      CAADA842C116608657DCC34F36AF25E83F914B1646F8DA35EC391E9EC33AA7BF
      5F619AFCFC65FDB79E56AEC2FECB6A66FDDE97ACF8588413972F338E0B5258AA
      7EB9667F5F4A581F965A99AB921C43B11296A3A13952D90A1732523F4233C3FB
      BB55A5DC407449ABF71876BD5D56E8C5B29BAF00C29F22C9236E9993B337E05A
      7F149856FF76C76FBBBB4A2556AAAD4053093AE4BE3C0E89305108345405E4A6
      B27AFEC25D5DE7C28C69D034CD6149C8DA23E20F2A78F08DDBFC9A6276F5387A
      ACD12054A931E3087D6CE6FC09E7E1079E8736BC8B318C05215190862BEE2863
      DD2319721FBDBA806B6AA8A34AD7987808EDC3AC8D49336F162265669B48375A
      0D8FD2A094035BBE02FEFCD56218633789E3310F43CD9071B7F90CD98328CAFD
      95DF4053492216ADD24F0BF591429EF99E164DA9BFC10E180622489981BA2B54
      0B538FA523BA44BFF81BFEA6429BF2158FB548332DCED85FFCF13BCD1862AAC8
      B229345B9BBC0CAD460D05F29C901B5F978582AE47D19266424892F6A4A21551
      9BD283A7019EF194C0EE2F4F2F1CA0804A20B322A46E4DC475C56D51C633A42A
      9FBE20D6B1DF994E45A705972A5A52BDE7FBD8DEABBE1F08BC5842CD6FC33B82
      2896654AC7CAB0668CDD9EDE9B386444AF62E66BC9E680DC9ACE210FA4E213D8
      E7F56E542D0CEE47D7650585764512EEA50EBF22428966F131780C3740EA87DA
      0D7E7A189C157CD012145891875B8303B3EAA65CFA782E0DECFE9AE4286AFDD6
      E41854B2416B49B3C632CDE854BDFAFA0B74000B32ADFA7B28DA66FD514BCE96
      095C57B3F13040BA731E95D71D628C4CEBB36256B0021876D8E3EA6D766B10DB
      4A5DD2ECCE0A6B6EEA7249AA4F7A6FC3635070F1274B2029FC5481B97AF6A7D6
      4F2D50681F3F7201E08DA17C20913C3B60B4235DEC99D02D5A45866D578FD02E
      736BE26BE4DAACB6E732B0120E34AA987111EC66DF76B3D4F570E76D2769C50B
      AEC4D5CA108D362F79ADBBD1E813B28F1484A1D4DAD76601EE0AD6D5085C958D
      FBCBC3AD5E3B2A615EF181AEBE4660674DFF22882643BE4CE3C2AC381DF89A1E
      F3B5998913FA8F50F5D28B1B898E5790A582B4A031762B7FA97AE086D009FE8E
      C2331490D247F6D08E243392919BC5184052CCAAB511145435D6835BA528E56C
      E235DE427F79D5144167CB535078D290BB4EA61025A53E8A5E0E7174ADAE007C
      542C4CC43B57980EAD57FAA16A40250CD7EAF2BEAC4A7D15C51D097112A5DA69
      3E857E03CBE475F218E0F2E473DC59314FFA680460E2E385FB70B2B30FFAD039
      C861855E8A93D11950FBAF03E7AAB34358693671F64BD15465165098AEC2A394
      7DAC4FBA4E8F52D7998BF26152E6A8631ACF2A308C20478507081F1A1994476A
      9BAB795F21EFD7C543AE81892E99EB0E0C9E3874A5DF1F2903EC8EF485120A2F
      DCDC80453D5C715E2E1F1CA593CCC750B1A82CD5696D5917B9669B49E16E6F6F
      6FD767B3F5F1D8BD2FE27CDB7D71472058DE76B7983C08F4BA2E4EA0E9D4BDFC
      8A70F13D0F4A1C43597EB44FD0EC34BA52967E21254DA5BEF1883D59E617DE38
      3CFBEE8D3BD83FBAB4A70C0A2CB03B15144C4FFCA86A5599E749966B416534F7
      E2450F1F753ED123E9C43A6333EF485A1F1EAED06AAD51B285962BD22FF7C1D1
      7287574825C66CC602E5111A434FB66D4920886C9309D53F9DC47D6C99EAF842
      9A4561F6A98733F5CA851DD2E950C1ABF003F3CA3036DD491A4C788D69C9CFCD
      F2CC300E60A2BDBA9BB4E6A920CC32E512BFC58610F16C2A79048EAE961065F0
      717479F255D8731EEFE4D816173E2AE30DDE194593E873FC18CE5E09A3BD5D0E
      5994EEB97252B8BFA559F9B720332D3B38008074B1FA25C8465E77AD2E486A73
      50039454459FC79FEAE953A496097548A0DBA8D87A7106FB566684B8894B5E79
      A95DA0DD7A6E67EFC70B89827BEE78E774BFE7CEDF5DE887497D0DFA345C117D
      E8660B33C26ABB6B35BDD042ECE8DA138408DE1FDDA73E00BB5C7F005C1A54A0
      FE4102175F211AF8D2A30AA53B3529F050065C7AA658F596CA0C3BE65000CD78
      F87CE3BEF4DCEDA36D03B5AA59054E2DE2284736851D54D5CB978744555DB88D
      EAB812D99DAAADC97582EC82C17A84A48F7EBC241DEA57553767429757DC68E9
      7D4AE38025F6898726A3DBE537B472A178DE415D30F503F4519A7A5C53CEE077
      17FBAECB1414352F8C0E8FCFAB86B5DEC7398F73416BF62AAB74CFB4D78A32CB
      809E608AC95D1278A1604BCBE42EC5137ABFD44D7868BB492DBD5A652CAC267A
      0F6C0F4F9E82E9D7A8C3BB8E5C1F9036D0347B54F27B4F8F0905B64019B1220B
      C241C925D2210A5FA09F40D9F7C291FB950C4D566F5082022E120A89DB1C4949
      C65EC1E3B3FCE0F4827C4F649B958BA72CC2BB2B22D84FAD724FF6422B4087C8
      FF81570DDBCC42755605CA56A56BED74422B12F6AA923CCAA784DD8DEF4B5E0A
      DF81447FE1621D2E28C403E2C1F0D4F663E6C95DADA06A36C689A4F228392347
      AFFDC9D68E0A4F57DF1683C44DE673D5863E0BB83985DDC56608FB88895C7C44
      D6242478A505D4D380EADE359C94A005D820A575133E31BE003385BFA0818A35
      EFD2935AD717C75738BA3B16EE552DC5082356F4E45219094906294489CCF902
      0900F5291F3B03EE556CC47281938E079AC0984E93825D7AB55054572A85C027
      CCB7C369BD3B0C311D9E21BDEAE634C249112E222ABC2AFE8944911606B98ED8
      22B62A877F97D22A00CC19AC2D122A6B0026D5820A02AC1A9A70FCB1BB014462
      DC719507565D511B4D6A592AABE8559D9DCCE72EE6AC0F5368A5EFBABB82F8A0
      1A580DA51FC008AA07173B293B5FB12275E0DE0D1816E60FD7C6A50348B274F5
      5C409A414745ADE8320369B47215E22F7266579629346B1C301E0DC75092A1B3
      8186450BBD77AD412D0BB944F95BB561DE53600A4D9BCEB165D19975B44B0B57
      19E1D358016239041E80BEC4204F69DF784275EB6BD41B445CCFAB3EA954D3AA
      84EF53002BAC7FDA25438FF689D7B62AF03531EF248E962635BDC41CCC00C378
      14E19400B969368BA9FDE73F58C96BE99E9435BA0CEDA995B1AD4D4643ECE48B
      8204AAA39C1997A7CFEAF1D9FEBB8AFAFBC18C4694B367C588B7EE662CF55AC8
      C8128901351C28F464E91F9E3C1E6AC14EA6996C9679066E32A1BB847E117563
      32D56279D0309F482D4ED164143532E75F5F9069DBE050141996A5DB6A9EB1EB
      4D04FCC1D3E8B4B6B37CD25A155B381163745B551A9156170C6E2C8A000FA790
      1E78849B9A264D364296CFCAAAF5994246457FAC1A329ED07A8CE4DDA794AAE9
      775FC6DD57E105118C72791796B01847924560555AC0DE13C0142D3B0B0941F9
      7EA5D26E96C80BE2808E188EC4554A0011739D34E33E8F8A3C902458A2F4B664
      97334AE6F8CC30CF3E89CD14A6BDA8206BA96C2D3C204C2B5A2870247E85F0FB
      C74C841689A03811B99A8DAAB14B7F83F575F13EAD881877A609D36CEEAFEF07
      976B8F45474B99E5A54A1855313C6E890956D2DA0DC3A08C6BC36E7E3CB8747F
      0A6A27329ACF05FEB437707F22B64ECB97E1DF8EF1B7E34CF315FCCBDA3DA17C
      71932C73EE5763341AB82A960FA74F52B1F509B46FDCD3D584DFE9FC7E7567A4
      6A324B2298957D03FB3F51A66FC7D811D886BD9483AF380F24B00A296BB2D930
      1B665F4C5033B80877FA349925E5B2829D5EC5BECB579BDECF4D20BC60517AAB
      2BC720B940E33E1EC9D6020F7F8ACB1058F80C13153AB23B98C3DE3DBD1454BD
      B16BD48B50B06F14E890164AD71DD8E61F27C528CA31B1F695AA54F5B0155D96
      33233D27A838FF3B1E247C04E95AC8341AF4E19EDE357C1C7D092A1D66080D91
      1AF32ACD82EBD46FB3D66E1928647C5477F64932C0BC9B0A994576450F52A11C
      7118B1816A82E1DF42FB432CB54637404DF372F7CB0A2DD7879C008E8166FC89
      7B91CA5363B012ED8CC782833E9A9C245499EB463152C9DBEEE866887FFCE0A2
      423E829FB023B6116E25E9D50F2E1A6479297F2CB6DD6E965146F64FEE128DFA
      3FD0DA695385F172445337D48F55F5EEBB4DFE5E3402C4015558605040286659
      FB0B9B752499F4958F5CAC7854FF3097033E63B1F603BE2081BBC1EBEDDEA844
      EA17186EF26AA410B48112BE2CCE289316D28AEC10CAE21BC1F4D53AA8FB4F7B
      92DDF82A4905C0DE8D148CC887D17FAFFD600A65FA858374FCF0C79760E6A627
      ADA11C8237CBC3AB04F1703124750AAB914A591330405C2FAEC06E5ECC117463
      07988AC7866C4A267659F337969FC752AEE1089F465FF4397A10235595333917
      7BD6B6FEC3435F1A62E61FFAC0C646BFFFE0A384EFAE1AC2DA83772D1F4EF86D
      6C48963F4AEDA16EFDB95866C1833E7411554C7FE823D52A7AEAC0E374DCEAEF
      D50ABE194ADBCC01FCE03DD0691F67A34FCBEBFCEEA7DEA7537EEE1E6267EDC5
      F1FCDCE2019AD2739800AF48C07C9246DB25BDCA10B0205032112EDF5CE04137
      09AB8C825B082521E14EA31DAC8264CD1F39A3915EFE08A1F501E86B7BEE0592
      0BBF9CFFF6A2278617F75CFD99CDDEB7D5A796A6024B2762D92A8F4DAFC78EDD
      B57BEB3E81E0BB143490DAFAE87FF9E073A8D9413150787AF012F597A7114AB1
      F26B29B1B05C0B294241634D23B038A544D4B35D533C0BA6A36B49321403B49F
      E3C927EAEEE2AA015649442F00B05F5C85013FF30ED6CD021C208E9124455888
      4E4AD1164B6F577ECD3C04CB19D18BB76B20E9A5A0C1A57CDC53F993FED7B7DF
      6DB9757843A34FCCA9026FA1CA339C6B256529BFA9B2514D6FF4C6AD9BA231DE
      1283588A0948AEB4424A315C37BD2A81919056A7E98DBF73EB6E9F7A8C2B6EFB
      DC37FBDEAD1B0DBBCE234B20F31C6DC874295C9C8E32269881AA0786685E216A
      A2C2BDBF3C5C7F2BE204EBA3F9F6A29CACBFF500AB86C37AFB1A2225E3A40A4C
      341510E5202E445E98A510F59385BEDB12E4F4CD9BDE18CB8B1DC3CAF2009635
      7A0E2C07C5B3393001402D22ADE169FAAAF41F927F059945EC2823E76790F2D8
      6C3AB46FEFBC2A2FA5AB524B590AB888A5CE295758113EA14126CE19491649B9
      5801CBFF8AB1607378AAB82AF84DB036B3391F195BBEA8EDCEA637C386F0EF7A
      08CDBA099AD3ECD222A685363ECDBD36BDCF5BBC7B1B3E617B4ABD3AF25420D9
      2C1B8361A4DA01CFF180D884B5797B51B8EB2C4FFE81237AAA8D2000388F70AE
      2349CBC36398956536A3722416DB6DC3DB7FFFD2ADD3662A552DE69090C930CC
      19C7B20FE94A6BD35332A1A623E4B8814B687A7B6CB90EF24F68CD55FC7998B4
      2F34CDD7E8FA5D7FCA31B4A71ED31A8E108D782C368277213510DB24A3241F2D
      66A8998C98D63730A766948DF55D5CA3671D9B44871B5CCDF8C7AAB15296551A
      CC921C9432AE53B9319D90994E5CB8AE4FA7EAF8958986CABFCD0EE3AEA051C8
      64AC6A5518FD71945E2D90100FCC8236D8DD200F9C4D5C5F4E1651AB635CDA1F
      16D1467F18BD7280788025E43987F4FEF2F06D758CC11F9BEA721BEB215728B6
      207293085B6DF42900E02613FF29E9DA66F52019F3BACF39CE3C9E38DFF4C4C6
      4366B967F12C139AB2FBA0142DEFABCEA89678ABF7469926ACF379CC32269267
      D6A38C3C14AD8E74268BC01BE211ADEF0AD855CA2A8B54FFF2AC834E89CF64DB
      7D904AADCAE31B4169FC76AE18DC90B251768F15FC96B819A42CE58D1E39AA6E
      AC92D6D07B7DF312A6F682BB5EF271E9623A35DDD0F9DC13958993FEAC46C567
      7D03CE2F0F1B37DBC0CA30EABFFAA1455A2653CD59590E918843BAF1CB29ACB6
      43FCE5F06CEB377708A2842475EF8ECF7629799767CF7C9F872C265B8BEF02B8
      04C002C3CB2932AB2A248EAAF87A7782096D6C212073DF0330A72B6596BDC739
      7C7A24542A33507174AA77ED63D3FB39739E75D04253148C9AC01262427D8949
      3A932AF774AD5E9447CB2298B4730AB7A2DD05EAE76E388D96BAE4DA8E95E13A
      0ABD7EA292D4B112F5ACE7D29EF9E3D7595E8E162805328825EC428AC9D69D2D
      0500ED5D3430D76DA594FA9CC3BA88D27136733B1FEA3BFF26A85B3CEB6C5F9E
      ED55C75E7D7D66A9FB98A4DF3DEBED647A1330FA8A4A4FA726314384438565AE
      F764FB203349911B5688A017AF518D9B671DEE8F4797270785EBAA59392721A2
      FBF1886D08C0613849C983CE1A01273973DF5DBC3F37565D751735439E0DA7F1
      EC7947788750C1BFC34A2AD0D09406525406E18F7EC69F7544BBAA02F823300D
      4A6A50B83DEDB086E62E0E1586911BA36C0A9D53AE6EB14EA345510AE1CBACA9
      1F7ACFB80C6543A15949567DD95FCC08A14BBD2A2EBC0F65DE0C18717DD3C60A
      DAD4F6D1109A3EE22F689982696554370934D578A82930055E0AEA8220549006
      7186E302647ED661D5B31D9A5325F816510BD410AF833C1CD8718071A32089BA
      77824FC9A6CB74196D0D77C89873F6931787AC915754CDE29CBC8A02549E83DC
      949A91672F0EABDEAC690A33FD730EF866783699147189BCE25E362DF62024A3
      FC750262CB5932AB9452AD6F5E741B9007B8E5AC3FE7A816A90002A4350703FA
      1C4D2B3A46D9A449EA3F472D4BB4D170D911FB3D49AE16A6D5B0F9EA5A2EA53B
      FE39871AE404212F5D94AEFB27FC5BC154C61251AC61E204EAE7BBAEC6B1EF72
      9E6563A54D7C5EDF8A19831E0BB4FC07BCAA3D94AD31642BD9860701375090CA
      E89A4C271740489C208523C887120210E0952D1FC125F2BAFFBAFFE60F7FF8C3
      DA337BBA443A80E0105EC28A8385FE786004640B06DFC3E535C0C52598198D27
      802B81C4BC6A89364C846A060B451D1B5C250A52E42D0866E3D127A074AA8877
      C56DB9E7C1A700E68F6826858F679D9BC1E0C0DB479FD9515154D900ABFB5437
      6B5E3F5F1E066B9FDDDA7ADEA5F9C1A08B1574D89CBD67BD91B8666E64AB3E9B
      B8FDE806B9A87CDC8F8B9966870BB72559150FA3830B2507FFEF0BD495788567
      1DDA0A3D305302AB498F568840BC9411B435F4E3CBD90A6CE52A25B90230DBDA
      2330C49074349A0C9D1439B4C867182639A6999194945E9F7D8EC894D01C4B96
      6F185FE3E4D627A1FD697330DF33EEAA1B857971CB542F4D5F523B89A9758AEA
      F7B3BA08653E75DF88A780313288558AA5153B56F4562D8345A1CC1092AE8118
      E197CA59C38F9A1475FAAF4833483BB96406E122DC5CC768750EE963EF201775
      A643F4E592FBC34E5B651862BDBB06407C5E938065BB5EB10B2FF1D4AEE85808
      FA9BAAAF114DAC54C642E6E40F0D3F7A2FB1618F698D3FC1B27BDE228100C930
      CF21B4AFB772A19B809F0138AA67BB2B752CF0CC7F8D31A925FE43A60CDFD5E6
      EB7C444650CEE479C712A6347AFE55866E8D4E83768948119E993FA660C42F28
      FC401B6682373791665249330029F05A7816F4E3622E615805CC94BEA9A6B77A
      A5C574DB8F2CE79588C20F06682D9E13F9A31C5864764682374F986C7ADE2474
      1E15D74A253E4221439605AAABCABD227E1D2B33F21E7A129FD0C0460E54A9EC
      5688100A08DA4F743F0D0C2BCC4D40F0FAC60CC52254DA0D5E4E3CF98757A109
      BAC6E46055C44324837ED669B8A39663A418FF84E728A01328193C5293449297
      3C800CDFCD1B67CEC0BA0643DAA7655597A05D8EB031CF0DD7749DA1907BAE09
      267561B2713CC73B28F3282DA677AF5E0C71D92554D31B6DC210675A4489D4C9
      78DD7FD57FF5974603140CE0D8D758008CCDC6F0889981F93238F034702DAEEF
      3B002FF777AAD6E1361704ADA07403569DC842F0F5BAE70E4F3FC891150CBFD1
      CDB4BBEB55FF55FF65A30B7C790330E63208EDA9DF96563DB748B9D5A95FC176
      371A6B5C5AFBD21A5DBC029CB7B90AB6A66291567FFFBB57F8FE77AFC2EF4349
      A6B81601C3B1216560A498BF6005C40B4FF51B5DF6104EF5C1E0DCDB6FEDCE8D
      47D7A9F1CF097292E1FBC1608950E0A98F2FC5B97728CEE16C3A3A3D3C93F6DF
      4657235155D0E80ADBA6D974130E757B7BC4C234BA3EBE5B31BAC86B6F34BDC8
      A8E06A36BB125BC8BA641A68FF78AFE7CE58B7C2691AFCE56070D26CA6C9BEC4
      E9369B757E70F153D3B7F67AE3F0F4C36FC2E7F1D0443C72A58394B2D091C16D
      A5F489E2150E1FAD9307B207CD36998048CB38CF71DCDD807FC715F19544C5B0
      7AD978AC6D88CD6EB0AF08EAF16D1ACD92911B69227492C4D3B1B5BF6AA9CBC0
      FF9128808091B41C5DF7DD471C6DC86194EBA4179865485BB2FC53BB583271FF
      88F34C899189E7880AE8378A108270AF2B5B0C01B23EFE371528B96DC05A6FC4
      12F09A71C6236E4A489418E72C3EE3C4F54DBC48E3E998A83F114F279A6FD04F
      53992A5D823D3F752A77073BA063F9FCB2FF6D6383BA4E718C90EA95D2829164
      D70D0B24C9C64FB183F822885CC6689D1F79C50A2B2E318FCECC021C37F9725F
      B0B4D7117A95A5BA114D4722D7A2699F93FD6FC527BD3CCC00919E264354FFFB
      AD3D95CD669ECA2F83C181ECFF3D2E4124F0A68BA197C2EBC2D0A8415AEB615B
      00E219D83B6C14335849EAFED81F8D469CAAA6F6886470BFB98E90670A065C38
      BB8B8EB90ED230D5D24AE9B576CA29300D527B6A715C1D9E6D056DEBCD9C874F
      B77932731F2E840B0F85C545B9859FF5756C7B299582BC791F2EF0FEFBF11736
      531C9E6D55BFA01880062AE220AF9771F1EDE71CBF5F9F645B9FF34022A4A101
      551AEC6D989FB7EBE3E40A2C39D7F19708D256A0D6D242B2360250BD26FB9C08
      D5AFEBECE21856DCBBE7C5B35E918E9836E5EED50B598760950B27D6B9D1F099
      B1A9E189BD5B232CD9E4514C66C934CAD922DB33EE19E6D9A473584B96CC8D54
      44E7F4F9D3A556A1A78EAB73414504E36D01E3E6F26D8DB194BF6702661EA157
      535A5566D2AD181C0D51DA7028566E376772F5587C1FF8D8EDDE0A99BD64B53E
      07F4B701ABB1C62D42FF773B6FB65990AF10FEBC7F0E06076B27D1FC0488FD9C
      CCDA7C77D51FFFBA888BF212C03CFE319908A51E9ADD918020705DEAB74AD520
      11A5D4E6D91D2DBCD69855585EF954A3616B1FEA78058D6AA3EB217E41520964
      4F460135E6BA9C69C6A1D975C9C91E509B565ED7CEF9114FC9AA09E6EF0558F1
      D36452F4D07314E749342D7A6E9A21C1375DEE15FAFAC3ADF9D1F69BD9D481D0
      ECD0CC50284B0C6A9B0B0F0EDADA7B3D38C4CEBBAD56837A605D091895041FD6
      C5F7EFBAD45AAE94CDFEEB7FB7B5F28CAF58DA9DCC33A3D894A6BA186658BE5B
      0E7BDF1EF5046984271F07036D867BF291F42F35914DD647435BF2DFB0BB188A
      7BAF347CCB575321EF9FC5882B5A7ABD878C7A3DCE50062E90B038E201777CB6
      DFEA56F21CF8BF3E4BF4394BC685AACF09B0258FE3823722F5CC02BDFF70F5D5
      CB436F82527683FB88B971DD9B1ADB9A9A2481E44214031099F44A55D00C1CE9
      AD974CD3C8CA4FF90EB3E2E7BB073B6D2AA7CFED38B0BD12F04E32CFCFE6E5AD
      D20C344BC9EABBC6056D21ED0E76DAB5D8D845834757F40212EA31CA3B118A13
      52B89846E9B81845F3180BABD1FD0E4F3FD8922517F96BF9A9F50A7AD96C0509
      3544FBF355125DDAD9338DA34F6D2E13F08C202FCBA07FFF68E7B8C525C90B66
      9E3795369ADAD068FC19E5AA4010C74D62AA7B36CB1CE7D1D5FF41B3A448A36A
      E180E99BE5627CA766B103DD3BD6749B4D4E46610FA36F1566C80A26DBD2D56A
      9F3FADAE451A1A4D36C061A2928AB821F281ED4E1917657F1E619ED45CFB5307
      090D160D11AF6DFD9341DBE1D9EB7F1E9E7E58534EADF84BB317A8DD4E45918D
      1266292D3189B1FDB18F84C83C2A7AF2CF2DFDE7247B3D27C9FC183FA49FF103
      9A73A83FD96CAA982F3BC9C6EE2CBF8A201790BBEE26281A4AF76A0DA7967074
      8784C092605DE5BAB9F559A65FD9FE0FFD07E6F0CFCD569900FAD7894703E0C0
      74040A7B53E40E6146A1F132593FDB0EC6CF348980CCB3453907C907C159DC3A
      58036A84CD6100647406511819ABA421D11C882E3AD7593FDBEEF77FFDF5241B
      FBD9FDF5D759362E7EFDD5728863E4E2C1487A7CB6DF69799ACBF68BA6EE3A31
      CA7CEBD51F4BB3BE265E1ADE07F71058288E35B260E4F18410ADCB8B8303F5EF
      8FCFF6BD6BB42CE860F9FF1668823B4E5C8FECC6CB4EFFFA9FB51CB5FE67153B
      2A9B9FBE7ACF8F7134CFD28D9D7C96E51B3BB3D94225938A39FC8AE23A8EEF2B
      8A3EEDFABB67FB971BBB67FBAFA4EDD22392E80FF982BD249CBD72327620599A
      84E753F538C8654393D766405ED670FF6CF73F572B437FE5152F56A08A44FAB7
      42EFDD4DBC7DBD67F3B2FFBA693CC5A69437DF6FDF436CBC54DD0A28AD051407
      37DF45337C0A1F0F3B6D7D8DBB6831B2CDADEFB72B15F2718C64075489C458D2
      5AEBEC526B1BCDCBAD6EF7E6D5768059CE33DF182C32D490A930FC5037B090D6
      069A55C95618BE66B8F8EBACFC14DF166122BCCA666B4ABCCB6E11A0AB84C6B0
      87386D1E8DDD3726F1498D9775FB29CDD2B8E7FE8826D6382F9B8E6B3A7683EB
      6402D01A66DE1A82751DE238F994CC0924CB88BAD2C18A8C70175B7651A02C59
      940B70CDB3158A5FCD16255477B08490B2906A6D5C7C82AA5F94C7D1330DD86B
      099FFDF4E0ECB2E88C3C3E90CC7826E335BAAB4E5AC9B7B541E2C45FA8D678EF
      F56DA4AC18879AF1ADEA65F25DE51863EF003C1FF0DC690C904D8C8F08A99574
      31AB745A11E513FECC36A166EF0770E96FF684E54895DB213A2F4CA7A2203D27
      DB4CCF1D142321F914964311FAE5CB6A0E45D1B49196FFEBD25D3474E3C508EC
      C6D3C2402B284B0B4CC048D8E8003547E26B65439C73B2A47A41DB713CCBDC0B
      C154AFFE18DCF817CF197D04F585621BE7BF205C5810B408A3CB97F671AD1730
      A8B9DD3CBB29E04BEF4CCB6F0E5F375B0DFEE9021EB761967D02FF936E3F8DF1
      B665E56CF6FBDF9A0F1BF98FF61C06617FBBCA486CDAB0B0E5931C68A3F32003
      76F82756AA8E48E4DD732FB2F445B0239E2965D71DC66564DE508F641C76C0F0
      C46A78C4E88D2CE68BE0E3A164091A0A2AB47705415A4C8139910CE05ACFCDA5
      5F4C77CC2D5A68AD3445D11D60539EC15F5AB13BBB1F2FA10803CFAC4758534F
      69C9A2F96DBE28F86E7AEE5D5C1E001E4CF487C750AEF5AAC4D569F4F9842955
      E8C593CEBECCDCDFB3F466FC5DAB9994D42287D4B5319990166E818841409BC7
      1F8EDFB9EED5341B4653FEE9F8C3F12989D409DA7B41D95650474B6D7EEF2761
      9D07BB8A243634E9AA3D0BB7E60148E86EBC057712AE5FF33C5BF63C3F5FBCDB
      07FDB879AA9913791E0201E56468812E432887102B6C07383FDE7F15DC3149DD
      F9CEDE4F14294952E405D75A4473BBE797FB81388B258A86D9F89670F48AEC72
      F7FCF294CCDA2DEE7611837008AF91AC93785FB41CD20ABA2470DB06A833D8DA
      50F4A046C6BC4D68B4CE0E0797A1EA6D9787D88B01E96FCCAABE307F00A66D32
      596B1F93344CD8C7C55C315E0A6255516AC5AEC7C5AC8D87FFFACD3680A64509
      BE27A0E927E0F8516E56D36B1F9B929FF046DDAF6AFFB537FF6E5BB1F992E8F7
      2B5D859228B228742C4797276CDC35B5F2B05094C66C5FD1AEC716195F55A64A
      DD5B2A47729315BF2F106D0FF368F4292EEF0E4CA3B1AB44DA17BD588455A509
      E2287A2EE9C77DF7CBFF3E4FCA4199CD7F6BEE21EE0FA7BEA3AE86639250D034
      35E84F91AB3DE8D50A4945085A15C84BB31544B3E74134157D361213DE190858
      1F95B9B7D99188A28DEC02BC0DDB02680C82DCC60CA85409B1CA6BD36F87C192
      7801F6408E1B6DB3A9BEC070C23AA0E8EC3EA70BD983AEA4EA6B2EF9933B4581
      E5348BD2E80A52F0FAF3D07C47BEEBA6CEA31EC3B2B77EDEFBBF17AE0BEE3749
      5EFC03B19C8FA8FEB2563F6070A4B5BFE7F9C9D1A04D55D17B64A224940DA133
      2FE401F134B013DBEEE46C7FB7E74ECE06FB3D77F8EEDD0EFF3FC0FF2F076D6E
      6DFD82C77B97A7B5C342D572AA9DFE7EF0D3B95AE3566FCBEF194D7033E8022B
      35DAE0122A9BF3E6EE481425B1BE5BDD508C5E506A3724369D8CF66FEFC5BE38
      FF2F14C57E1D33511B988417EBAF36B7BEDB7AFBFACDD6DBFE4BFCF78264976C
      67F35D5B94A794AD2D1782079866EEE7BDE38FD55A780ECFBF035FE1D75F05D7
      2B949E85E7455B76F89FD5D70FE1F5355108BEEAE65D45EAC0DA6A0E6C76B8A8
      29E8F8A54551506F232BEAFCDDC5456054028A0D6499A2F2FA2A07F042C098EC
      426D7FCF15ABF8E4DDC121670F264D96CFCFC7677BCFB062FC5D3BEFA55BCB62
      E19F0707FB1D7713E58D1D91AAA0237790B0B6FE60A7E77B7FEBAD080BDBA2F5
      5FF65F3784042894248F3F6F40F02814879235B000715C1F52EF35F98F40C2D7
      83944557708E647A8EEA68B3CE8C4125949BC7BF2FA8E7A16972164D31DEC5FC
      06C4182D9E3872458CC0FABE926820C36CD5B01714C0955C3D23224C4C736F70
      279838E4EB408521192AC90736BB74E73FD10F0A409D0541569F012DB35418E6
      D97C315F2150FDF46E2A78831BA6E780820B38338A208DDBECC2C7D0BD63E15A
      FA836FF2A42C019E29DDEB93DD86AD7FE4280362126CD4F197516C087BD2A868
      8BB3490B0BBDE9B90550656602CFE40E29A3D99C9D4C331E8722E830599056A2
      449821CC28ECD1C6EEEFB72A2B424483DDDF0612F77A4CAA374257A282BAF69D
      D220A1A368EF27269EBDC6EFACFF6C51F903C9AD4A9F01511FDD5638CAB70A38
      79586AC377BA6EB76D711507A4DFF232F59472B702ECE7F1D5022D1CF117931A
      2CD69ADF2C8C33BA97C7A03D8CC7B0EB3D7729A22B4951EE665F1ADE4266D5A7
      2084B940D9347C854E62165698BE39E4C2814512134FCA3AAA23EBFA4342BFE1
      6004F03476C56D5A465FDC7572753DC556C291431094DC41ECE0C30AEDF0AB9A
      2D14F0180ABE19A435422621E277E4B369BA70CE0236F9E2F92E7B246EC4E6AB
      6F7B6EF3D51BFCEF7BFCEFADEBE27F6004EB2031C0EC37EEDD7944BA332946CD
      E66D0F25AD8AE284B885D93C2A936142ED76AEA861565EBBFD783ABF4EDCCF07
      34513F1FBCF652810095A8848F086FB638C2D1EC758A0B7A83586460DB138B2E
      D053E108540D42DF00A55E4DC3BBEFDE96F10EAEEEA6717A555E7B3A55863C6F
      B6DC30298BF61EDDABEF9B7974BCD0284BABCEB8E1AD9B65C92C4A375FBE74D7
      65392FB63736FC6FFAE3F87312A52881F747D96C23CACB8DCBB8F8169B70FD08
      34E5EB5B6FBEFBFED5776FBF7FD32A4EA230760A6483A424A9D78696DFB1EBCA
      9952B89D8B939D9E3BFD3038426660FF550F5585B386D6466F7C40CA4FD58391
      CEEF2B246C7054A303100EBA52EA939D8539A836373CBC2FAE6159C5CE2841E4
      7944689B6CECCB2DB70D3E1E149F49E428BC70C83FB3E05DCC84AAFAEA3A2BCA
      357A3EDE9F696A97E4D6EEED5BB78DFD8E140F4DB867706203A15298954939F5
      12A900B14A8747E1338BAE3B167D62343B4B85268FE779C6CAF57071B5A63A77
      6821671E546C9D201EC1F3F6A5CD536C6E7EEFB67DD11204283FC185606FF614
      7EE0CFC717C715E9A0A04C813F9140489C1B8C302B62F92C41B660F81FC73037
      C3384DAE04041E50F51C5D9EB41BF54BB7EDE82204E57B267159D6970CEA920C
      1A747E21000D2BD159FE6E07061A951459A30DCFC1C0BF56A4A7A91CB1CC271A
      62FAE62466A4C21F02EF764BF155F512F7A279525610278DC8C18E8F564E5405
      98A80AAA01E384127E63D86EB71F68272862CC58DB5D01DC2E99CCEFAA323FAB
      431B7A6E70E9955F5E7FCBD31610D431F6CB3C2AC028D0014EB3036AC61B902E
      34F64903248561745A78D3E19A2AFE555E9D3516A3766CDCB5164342EDAE92B5
      85E381E587401B71B7B23F06CA0921E763AB1DFAEA5BEC50CF81A4FACB42B98B
      6A1C721AA89FB5BBC926CDC01D01878BF88AFEA7807789B6A02D2DFA81CEB607
      6AF1349E46B72A50C8544F251FECC936DC29019FBC72852FFC79EFF8C2AC5AFD
      F1B40ED0EE015F6E6C6EE29CA9865DE3052424CEA7A52457143E2368C6167317
      30A8E1C38293C39C98001AC524A78C0DDAD9E5EFDC36640D59849488E6BD21AF
      7104188D8B1F61010454AB3BC2F489E1751DAD868B4BD571B3686ADBB9A585DD
      DCC44ADBF910E67F6B955F96F048F1EF1DF0BE1B885B8507D78E21F4AE6A591A
      8B05EBAA6AB4D3B784D57AEBE6D751D1EE5DBCC4BAF9400710E5712373E4F286
      B12761F9E08409F4BEDB8D469F006B48C71578989AE77246B0670054E756C3D6
      C132FBD56E98583260D49335FC3BE8056C43E9068EBFA0399705735D54933C22
      B99024B185304F5B1CA081F9E0C4B7C84FD990DFB86D47D1D77A4A5873B528F5
      4B3557345D6E50D6FD2C6DA07D7798E4B168922006809714780838F0E2C904F1
      F3E7E96DB534E0F789DF2035BB76C387693ED30342F89331E736A705FA89C8F2
      E076B484873C96B9A4551EB1EFF66511C0C9EFD94CC3550DD820FD2328F443BC
      0F1420DA3D031CC00F59328A1DB8282ACA13B8D5F3791CE545DF9DC8880A590D
      2BDEFBD219FC534A05417C6EBB95D57EEDB69585F78E8FAA3CA6002DC972E9D9
      CCD4849A0016201B0C490991829A04AC2DB210EC18E81308272453150C984301
      2077ADDD44D3BE6A0B879A39CD39085641EB9A5151245768EC50DCF1986D3736
      1AA1ED9D61FD6B90516957999A42EDBA9636D18DC49FA252DDD0CC74CB24BFF4
      2F4AFA98E5C76EE9C03C2EE65EE5D073C947E9E83A439C031B445D4742C1B2BC
      61D699FDDDA0F2A57105DA65148DAE1153DBB6735DF407621EC6F1707105CF67
      ED19522E6F9BA55CC8A946A9606BF7915793C0A144979880C0E32865A5279B08
      E4D4C0F0B21BAA6E03F6B191262E9ABAD3F8CB82C66850C6D18C36B0B8CE1458
      D6775DE9EC8A8A4F2E1A02F1C761E8BA9964F962D60A6870AE10D0AEA42EECAC
      5FF39843127630309925C5C88E2CE370AB72E6FB797495A5C32C4F413AD86648
      1DD4297533BAA3FDCEAA448B7A248D6E7389CB1BD39115CF56C67FAADC2B78A4
      66894C4D9D56B4E441BF44999933FF1FEEEDCB97CDFAEEF6AA4E5FDF6506D120
      18618A0412E751D7906AD98D610EA86F64D64AA476BA8D20CEAE2651E1F0C73B
      A7FB8286E6A04E773E1CF979EF4A4B49BD9764ADEFCED200A4AEE55AE9A8E37E
      EE69AF8170E3B77D24DF51B71229063BC22E87E7E19C79D97FF5DD5FDAEC1023
      DE1C2711A8A48BC55024248998234C65B3DF4CFAD3846E37C6C40453F376514E
      DE1A554CDF5D565CC9617EAF27B51E4805A0E02E55FC32635E6350E6D23B955B
      8A43E872E8399519EA626D58D9144F30BCD5DDB4E1BD24344415E8BA1DC7A9EF
      F86BFFF2DEFCA56D3729660EB2A3D46C71DD32CF16432F6754D305596B9FA7D6
      9EDF8B9DBD034D2A49016598CC89DFA39D55B7E58827575504CAD134B31CFE09
      22534FC2A217901EDCBDA4E48CAB90410EC136156BA8097904ABB4BF87E92C21
      6E8749080A8E85EB2EEFE1F6A8F157DFB65A0747B339F0B10CED807F3F3ADF1F
      184657DE50FB368FFD03C0E93578DC39DEFB517A1B3BFB60D05F8C4ACE131CBA
      695C74D65AAFEA00AD5A1035A244795A8C660B75926A0D68E7E2E44C30605898
      5EEF8694D394F6DDFB09668C5E66D4AA4B295831AC4729773E9B0FFC00302F5C
      237C1F14F4E2A06514ED5F05559B83A73C1154E139CD75D7D0B4492A4B6B6B8D
      11073B0D2D6E066C88DA412601119188FA41D6EFC74648BC871D27C6025935CD
      B481E1DD5B241B9C1F58ADA5D1F5CF990A5F1FB2205B9DD7AAF647DE9550E0A5
      23B5A8AE6A87F996D4D01800740FF86E9935DB041DAD89C8BD9A5D62278DA6B7
      FF88819192CBC0C3C94134002517EDA86AC6122E4458D6ED35CDAE1A5DE66C38
      4D3EE3D8BF80E4D82C96E93D173A11349F5CB1F6BCBDB1717373D34F11D6A0B5
      9C35E74CBFBB81DF6C6C6DBE7DF3BAD12C9D8893A68D850CAC33974D802123DA
      13F3E609AA3B649A00CFCE5096C02E72E1F03237F2381A5D6319F4AA8D988FAE
      7B6E10FFCE426BCF5C217A3A3D1797A37EB3B57108116D1149A1A4969EAD2AC9
      2C5ED2CEF165FBE368EB597CCA80A8D9882594F65AE52748875A18FF17106A99
      DB3D1B0C58FAA7E1B72DF60C25764AA830531240A293D4FDF5FDE0B2CDE5D9E8
      2688F52974B1504054AE8E618CF2A50FA602A44FAB4380A7A1B6E94EE3AB6874
      EB2E4E774ED441C259F483CEA916F7F42F8228C661D9733B27F8FFC7839DF31E
      4FF39E3B391AB48AB50DAFB5FA2E95F83646523FB1A07A3961358EF22C3E636E
      1695A57E2C5259376B2D1A2F4FB390430CD4616D542A97890DEF42EE894C8EAE
      C61954D545B082BC38F15848735451DDA4FCCC1AED1FEF351B1185763C7132A0
      BD9E2B4C7476B310A21C68D351543694E06DC85AE6A35FD4FD8A32BFADB67E96
      52E044354D1B5DFD47905BEC5D5E1C578A82620EB5A400D419A67C5219CAF6C6
      B029ABAB6C0B5DEA124B5B19126394A3343C9993521A44EEAB6A3F72A81EC3FA
      C8062C7AEE0893DC039DEC74DAECAC3F3DDFDBAE5FA6475D3F9C6F65D1738710
      7BBD374BF2C8C52FA251BCED7E8C12B06C1EDCC6ED86BAF708EDCE638389250B
      D1ECDB54FD03F0B6D9D77F321B9DA5DB8EC4533DA5A1EAB99DD92CEBE145345F
      81B04FC063FFE63EF2E88D734441D82FEFF72F5486C688ED236B6AF192626448
      65353AA011E83F8773709748B4992CD0EEF9FE2591AD968A807A9A259CA47D4E
      0D2F73DD045A09CF069FCD33704D23644AD053DBADC266B91ACDCA037D788FEF
      A317852B132354AC5F1EBF1796A7462EC323F78673E3FB0AEB688B6A08BC7BF3
      CB1725A7EDEEA3F10F2DAE7EF42081C57EF2191C4B59DE2EAF158DE2C39FDDFC
      3A4BE3991781568F540E678D3583DC42FF5932694BFD5EBC3E9C604E6A578620
      9DB058DED29E2147073EFA837CAE4247E84B96CEF5856C63EA6E81D0183202ED
      90B1546851FAABF5985D3D63A983032FF4FB82E899C1C15FC5CFE822F5472D49
      695A32C7469BBB918E182DB7787C7DD24B56479DFEBAA9E817BCB8BD1F772C9D
      C039B72C869415AFA32940DCA21AA18EEC3ECEC3932C8D6FE1B3B5B9B7027DC6
      E294AA93DA93571F09FE570BE2B55513B6E73784DD65415716AFDDC1CBFB84BD
      7C8312327E12EC4D925E751A76B1A947CA3C185AF3986B45C23EE83DA3CBD5AA
      A14D9235AA368A9D62D2F0920601228D2D4E51A90E9E3CB5504B21758A49D759
      C063B36707C469C34559CA20F5B332CC1E4BEB92E8969AAD96DF09A5FE027E38
      A9D34319BD2795DC3B37D3C397A2207963FC9B3E74503FB373BBD5EA1808C6A2
      229CC8EA6E05FABDB67EC35CFE6D9A5D31A25FCC3322281B6282C53ECE12802E
      3D55075F963005B1C7480318895DACD6905741879F5D1EFA826AF6A871A98EE3
      DA784DBC348B28CCE5B1493A1DCBF5709B9E03492C3E53919DBE005574E6A963
      E5D0A89850C945CCAB598762D7325EA28E747930F820FF8ACBD17380111A3261
      9AE684A4049BC376835649867BF76A3C3E722D4F6F8B14370883A84B5BC4E8B5
      2D5109067A255B562CFB8A8E326959F66A8CE4EA2051A3AA02CDA8C6D7C20455
      7532894E153648BB273D73C6ECD2F0B0D8994E7F731FF3DB183D4DD7D2A681F8
      52F121DD3F4256B9AFDD1B9EEFF10EDD63D3BB1F1FFFE60E8F0797ACA50835A3
      8858D6BCCA36573FD807F305217D458543F06E702B9F214CC46AE760CF66681A
      FCADAA59CB470596688B33D0F86D359AF5E9B6451DF5D6F28A1A64C43611432E
      D4C6D4A2272E2866C1B627ECBAD069100F8DCE4D90A6DD402E97A95C9A784D23
      298F5748D4D9C60592A8F7241BFF9494EEE8E46CDF7CB190DDDE18972A2C719B
      5B2E53AF854B3928A441A731BA6ADAA3ED2370C1884A581482FF2A4AAEC6CD49
      BFD801630146768374C835A969F96C928807BBDEC1F171EB9B0CD2ECE6D6DD28
      5D6698F14CBE8451DA4E5E5ECFB22C7F86436EF3FBE797CF61D33E0E2C7AF274
      E40195D030BCFD901BE23B54B2E9F40307838C2C583E15586E808A645289D78C
      8D618F1404C358A54F1B16FE05942F1AF6DAF298894E69E9502B55C4752BE85C
      07597FBC15A95D151D0F41BA269F59B50F059DCCC78DCB28994ACBA0201761C3
      EF4AA0357A550D211863E26D94971E2E45C5DCADD2B69249E3A0A5FD0414CD84
      3A2391FDF7C56CAE65C6C866F4795E1A27965DAA71FEC95E196257DCED20859B
      7C9E2569333C8498B2014D19019034CEF2DB6FF4F7E7B8EF81DC979873849480
      1A448E101F1260F06805D2D5D248BEAA4E8D3134825B0583D98646A345F85C7B
      49C89780D1FF36AC8FE02984D62E8669C00127242BD155D4B0CBD79A09D745E5
      51AF877E0743F98F60FBA57B2A031412BDB11C09BC01EE66C89A4A2FE2148DA1
      E4C203964380C4CA1C2D34EDE88911B464C39D7F427495E4683902F9C58542AD
      B0D324D3A7473220671F2567BC6DB0BDF8CB3CCE1300E4A269CFCCAB685A46CB
      E4695FBB535FF5BF6DAAB2C77E41D5A55E852519C5B974FEDFE35834196A4332
      50F4831D265FB6459C885B181B553814F2A410BC24A521909FE84C16FFF8C76D
      47DB9E9175CBE302FEA289962F5DC68824D9FD2B97846D47081CFF8E8E6BD4CA
      1D4861AFB8C2A0CD256F506D1ADB9C2C648A46A3458E1A7436B17DD6DD72C3DB
      325E5BBEB1743AF4DDAE04D4CC7C000488FC3BF0D2967EE5D7D8985EDA7180E6
      0D1D9D0C590E43FEA6FD7B5A22C42A86AF5FDEB9C42BB944E7029CF08822B54B
      9ABE72BFDFEF3CD454810215B6A9E8F68A972D750552587E4EAEC4A987361D4F
      8AF53FBBFB6EF4D07D567E47265A41E330B5F6C78A5DDC0D639CB6CABBCA8997
      3CAE34AB00BB7F4B2F35876241D5DD8EBA8A273832F10BE99EB66BAC2147C69F
      B8949840B6666EA1CD8233C3A5F1E0A3594FBFD22869D68D169262CA8091CFB2
      F102E10B6FC704DE3422EF9D920E59AFC302CC1EC2314D95F91BEDBB88A63720
      0251360C34884AF5D65A35BA71FFAAAF6C0C8767AFCF058FD087F0B0B4F3907E
      09122E9FE37C1A898482CDB6064D55C94947CBBC20B72DA5DF8B057349119B84
      BC26A15C9E1D7C542891B038BC3C0E56DC02D790D3467A0EE21CAFF5C1A9FDB8
      73717A74FA6EBB721930D06095842DD1326A59531CB0A65199FA42814D785ED0
      669B8E35BB99C7D1275942D2FE2197E043AAA26252D86FE1E26A5BAE42888556
      2BBD5519996879EAC0CBE8E9B784277C3A35F65896400ECF5E8B18972C3B36F0
      72D2654FF8EE89A2BE5639785CAB6A1D83B9CB72B86FD3DB07E754A8136A8D3E
      784374CD31470972FDFE0CEF4CA31C9B733C66C639BA8920BD0DE064308BB1B3
      0C25A0F00B50B7B9AD77BB4A32B11044A7C81146EECDD630292B49A189FBC8BC
      4FEB43ED75FFA53BF8F9FCE0E2E8E4E0F472E7B8D909278F5B518015705E54D7
      9725ABA548ADA7479AE26D67580D24899163233064DAE20638C5384E4BB12E20
      3E921FC17C5066BAC23A9C5C4A0DA0E9F12A4D26C908CB8B32189ECB3243B918
      7CC2CBB2186A4E026E0CF6B8423D5E51E4CDE2EC4CCD14DDC3347887D9A20CAB
      E7DEA6CCB2A2342089A29CD51B98C5511AD8432EA422561FB3C0E97A839514C6
      95FEC3E3648C843BFF70CB8438F5EBBA48928ACC6995D52E663DB737A8AA94CC
      22E9D96DAE3677119557A2325E23395E1234488B248B2C710CDDE6504BC982DA
      B29D2C027F6926603BF4591B1DA35D97863DBCF8DF1705F77561CC5452392DE4
      902B4A4CCDA7389ECBDCE3BAC55AEDDE28750437BF4EB03EC3DBF3EE97B5B12B
      6C5DC289757EFCFCDDC5BE9CCB71944F01DFB4FE87C6F9777F3BC3D025F0B9A3
      3411FAA46617DE5D5C2199C360457C348DD047D7682356DF42DA93ABA2BF18D2
      66DD74D7F16AF203FF78BA7CC58A9F23CCC9DDCEDE8F17EE17D20ABFDCDCFA0D
      2F4348278153C2A82B233B884BFBDB8059FF32736773EE675600E40B6A778BB8
      ECBB7789B8C27A7030B2CA7D8A02456D264117739D87AA8729745E7DB0A7820F
      3CA33C03120ECE1BE8CAF4C4F14E2695D31DC8C204DD7EC60D646578296130B2
      F65B0DAC0B88D9D4198BFD19DDFF57BE1B6E3AC415FE9145BD097F622280B6CB
      1EA4277B729A7C92EA99899CBE380A6DB584A02F3C4985BF233AA29B3F4D5511
      D1658D6123EF7653D4923AD262EE62244CF440974735ED3886DD9ED5362AEDA3
      E338606C55AE2DCC1C259DD415E48DA1F321B1545569BE8E10F300B0058760B9
      A2F2F5C7F6ABA661F33BB875032BA776DF9D0C2ED7ACA7FE46EAD67E7193C61C
      FD29A8276452B545F79C1031886568D8A9A549115DCB4A5713403598E4555610
      780D72E847EE90F2BEFC72FB295C0E1357042876586B2CC47AC22CFABB7604D9
      D28DD0C9ABF147E0050D697111216B06262956F442B67B8EC62AF40230B0E060
      92E4384DA915E723F4342B939134108B5A6ACB1B45EE152C5DFD26CC974553BA
      3CE8F58C809D6D7C72568DCE51195F81FCA2F3A334790E6F299A4B25E78E61B7
      851855201C5CE3CD3800C889A338F4E16DC5C591E58E2C9532C370A1AEE23238
      5C4D6D3764D7AFBA2CDA01B6E751CEB896E76079EDDE81BEBDE1668582563641
      8E1F30A2B4E389D1C0728FC355392F24214CD26495D56CAC3F345836E75D76F1
      100D8E99440461824E68E6EDC109D4AA49CFF5FB6B9A991E85991ABA0E9D8137
      E39D9EFFE9344B63891F3A47D497AC46D04CE45709BFC0842CA90CC9B75A61C7
      B2E1D96492A0E3B995F4A2B876DBC1561311999B3C43606B18257044D43A762B
      58AA1C58099AC4E96499C31DD93477856D91A35F53B55B8613C6B01AF9AB357A
      040A33A2105CDE4054DE47423162FAA498E98E95BC490024184DF12BEFFC37DF
      BF5EB650FB26C250A3E3DBC394562CE032ED5067AE70BF2F4836070658A658AA
      CED24AF39AB66FADEF7694620DE78125114885257D31ACA77986B0B1DBBDEDD4
      BAA7CCBD089A00EB0AF2F8B41FACA09E7DB2A655951D16D4B4BF7212FE4F1162
      2ACA59721596781F25F96831834107CB59EB629CB69C442ECF78FC914C93A94A
      AAAEFA4C2B7D19947C007F172954F3DD6F246CA33D60B6DB5C09C12531ED2888
      0D5039F5DD20F3A93C58B6382A121EDD915704828587686343C554242A9085BF
      72472F3EB342769509EB3DF95C7E68575CD96C5AAFA8FB8878D152F51907D998
      B4A16AE9A179FBAC20C28E9C23D466F2C5B325CA4D8D21D80A690DDD027FEA17
      AE4B2B6C643911BA04A001DFF080321F3A48DEDC3D89C4AC08F1AEA43037A44E
      CE4466E4FA655C6C61E17A882313F53EC8256D36E457BC7A101CE18A194ABA2E
      BB7A9A18F60941DA1CB531FAED5A8DF480A4660F7C6E06316792559AA683C29B
      32769192D79E4021CE95B77795A54FAFEDFF57B620251957377FDAC963B70FDC
      F2438EFB7F650BEC26EE5336C75F67D3D876089CC4FD6CB440EABDEFDE21BFF5
      07F763364711620A9EAEBB49B67BA0D38F72C06ABA5B2A24B225A53AEED68FF0
      5818D1D18C8F53A5BB7ABE92C67AA0A2F0D8818E889A57D10AAD8758E0BD2E52
      E4AF30F9F18DF19A783ADE74ECF79DB7C4FFEF7FFE8FFF0FDC2CED81}
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
