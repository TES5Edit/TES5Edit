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
      789CD4BD6D731A49B62EFAFD46DCFF90D173EEB174078424DBED6E3BF6DE8100
      C99A16120D58EE3D836322A112A85151C9D48B10BDCF3EBFFDC6B3D6CAAA02C9
      B29C483DE7EE88DD63495099952FEBF559CFFAAF51924D8F463A4E43FACF6439
      3B3A7E7B3C0ACC747AF85FA3A98DB36C1CFDD7687A389AA6AB304D47D3C95C27
      A9C90ED5C0CCAC519FCE3FFCF77FFFDFFFD768A99360948E5FFF78384AF5D14F
      87FF351AF3B75EFF38CAA36CAEFAE69FB9493335B589EADA4035F36C6E9354E5
      6918CFD45D2708B3FFC6538A67F153E819C76FD4F954AD6DAED2B94E0CFE95A8
      850D5265637569EEF2148F4C958E0395A7869FA674AAB45AE87FD8444DEC6269
      6313672A8C55606E4D64970B136735B58C8C4E8D9AD8380D0393A8C0C63AC38C
      B44A173A8A64444BC327AA4D7FB6B1EAD930CE52B5D7EEEDABCCAA4EB408E334
      3349F3137E4CF3E5D22699CAE646D97866F1C0CAB0785C360F5395591B1DA8E1
      DCA8C44CEC6261E2C00432071BAB3055FFFBE8F0FF39786C61F85DC3544D927C
      12EA08C363A634EF00AB1460743C3D8FC36C4D8B44EF32B1719684E39C86AAAB
      D8AA85CE3293D0ACD3F077A3EA786E18DFEA28D7E3C8D057036396D15AE9E532
      3193506726D89ADE2367E0F35C67AF52756956D8079EF99B83A383B7C97F6C3F
      E3F0DE338EF919C38B0FEDFE630BD21CDB3C5347B5E3B787F4D66196AA348C27
      8687FA27AF77D7243313A89ECE2673BC6562C67918C9A1C9E68931F5955EAB05
      3E5653ADC4E8CCA8B689322DDFC15AD043541867567535765FC576A5129BC741
      3D4BC2654DAD6C12052A5DEA09CED0343599CAB094A9C2A95A2561969918A738
      D5B7A6A6BA3649EC2A8C0335D3619CAACB66B7A3A230BEE1B3DD375393987862
      0275B2AED1AFE6791C24063761AA26894EE726ADA94067BA1ED934554B9DCDF9
      BB0B1D4D6DB230415D279379786BD45487519EC854A6E19D090ED4A73830496C
      7436AFD13130F12C8C0DCE4664E319EE87599A982F1EFE9EA726C10298644AAF
      98E00F36366A16D9B18ED44C2F0C4F94771B8B1CA46A156673ACE6721EAAA3D7
      DB07E8F8CDF6E61FFFC49BFF8B59AB79389B47E16C9EA51B5F9B86751CBC28C4
      7FB3BBD73F568EC4689C4791C946991E6F6E7C5D19DC0159036C1E6D78503901
      9A762253464FE66A19E5B3307E952ABB8AD582B6BCA652ABB4FC45D9385AAB89
      CD211B56739318054134C9721DE10F731DE3E9A95D986C1EC633AF3778F261AC
      2BAD02FAD4923E3536D9CA9858652BAB6E4D928636A673A32125F2C8D4DCDB8F
      F5E4869F843D9E86499AD5687566E1AD49593E98898D03AFF97F2EEF44AAEAEA
      564761A0AE4E0743B91A7C5E5A1783BFE2309DEA28C2857E43BF8D342DF90397
      478DD72A30539D4799DFB928AE5E9DAF5DE22E1B1F0EBA85B5CD2B88EB7DE3E6
      3B37931BD26E9D248162BB89ED2A2D1FFB2A556160E20C2238C92101F6CA21C3
      54A5591845EA36342B3E44212E180926D250FB5E2F35D0B710FE3808B8ED387A
      58AAF23A47466347B50AF44263EBA76144D738311A0A35A52FF8ED732BB2A4DB
      B13A131D4F4C14F16448B00461661395667A8D31A606D725261D3F896C8A7B53
      C33C968949537563D6694DADE6985C7179486CE7711CC633DE02AD3E87718055
      4F4D8AD3AD4C1CA8B199D33B46E18D515AC53659E88807F17AAD93413321D131
      CDA348F522BD1E64ACAECF2EBBA7CA495731016AEAC464739306FA55AA327397
      E5895193791EDFD0B4A1742DC4AF4D70A48A0FD805BD7868E3DAA6F476CFE743
      9998699E9A4091EDA1834209F88A96B69986718897C1CD7457EFDD8F2A5F0650
      F5302E3E76DA7D75FCE38F34AF539B2CD435CB12757CF8734D0D329D4C43831B
      0E3D38D6F18D8AF5C2E024E3BA98C0BD51BC26AD932A3D49A0AB606D415FA44F
      56072D67C1D8247DCC24A858673595D8B149B2D9CDF1E1D1BB9AFA0B6CADB98E
      D5559A2579AAF6FE31B6F4AFFD9A32939BD4247A5E830834791CE4E3794D41C5
      BA6DC1376F60C6A9961D8FE9F6EB340DD30CC7FDE0C9364D978CD453A3B1F94F
      7FFDAA2AF3DAEE66A9D0A007D7B85110F399BE21C11AAD458965739D3915E794
      18149BE8469858A546FCA0C229E918FE422ADF60B5A117302AB264CDF605C973
      32185661ECA7D0CF49AA4E74A47410C8D95DE88014C2C62CA095958D27862738
      376B1584D329F44939956241DCC3FC27D6A46BACB3701C4690FAAC8461A9E3D7
      30CEC90CC2D8A477717BB192BC8A291916F839310B7BAB2336E31203CD8D9FE8
      7DBC26D6A9D83C4B1D622663ECB42687658DDFD7DCA5E4BD63F3921610937086
      84339EE878B0A3A421ABBD6675E9ACAFB49421AF52159B1482E7B2D7524B9388
      210CD74587316CCFCC2CA081ABC2EAB2D782B68D6F4D9C599C347CE56A1C85B7
      D84F3C895612066BBA3451E4BBBD55DB6AA26335968D0C3E9406214672D7A3C5
      FBAE86564DEC92D659C5367356179D0632336D363789D7A4E0DADC98F5CA2681
      8AC23463AD3999AB18E74646AAA9152E359DAB2DDDFEA8B4BD6777D6AAAFF4A0
      0DFA0C2BFB64AB75D360E5E5BC37A1DA3D1BB60653CB8458726593C073CE0F18
      E5E12CB670AF9A516457AAAB6F8CEAE9240B75C427B2B4C2923C4E959E42FE14
      869A4D546692451893DEE50589ACF634C536B7E981C9423517F25C57B4386B7E
      596BCFED2C9F56DD58921A2B9B47415543F0403096D64BC39E39DB38B49F5A2D
      4C9AEA9951633385E15411986CA65B1D78DAAB4D0AC224819AD0F2E040DD73A0
      B061A4EF31D5CA9F5EA53271354DEC824F57A661FED17A4746C7720061CC9AA5
      C84CF98E1312F2229EB327D39DDF1FFEABCD67F30D91A363910263E8E1EFB9F9
      9FBF16C5F09C69C5E5835750AF3E135BEE5C3BD8539831395AE50C5CB4A4F4F8
      6AEE74C466A5AE966C044CE0918DEDDD077CA310FFA573054111896DC35BCE62
      A13296D7FB5D3DE8B4D2A3C9A9A557A6F8DA2C0983EAFBD24B6CC541BF47F287
      717D6116365957834CA5E96EC9A4C03CAEE166E25BE91CEE12A9FE952E26E2DC
      A934D35820DA163A3E85C4FAEE2354FABA7BCFECE36E3BEBECEFB1BB07F7E4BC
      CDBEFB7B1521026B58313ADB05A643F1E557A91A231ACC72A0463B25CE0B5BFB
      8655B31314E5A85E33DF8C2564899EDC48C8AF7CB0DB8AD86658F2358595F8F4
      D26B2CF41A9B11C6302A2393798AE8589D5F9E5E51B897CCE969C84621A45266
      97E184A6717ED9ECFAE99FEDE04862E01C23F0C04BF92A7501EB1B03834D8D75
      C0D7835F7F1CD9C90D44B284507859E886A71BFB9AD22893F504C79F730B582B
      F89512B68BACBDC9971C83F195B47A0211F38A4E2EF9FE7CD5709B62044D12C3
      9FA059CAA7E920799E132C91B3FF37A2526493232A10076A19698A214084E975
      29E0E61621D76C6E164FBEAD900F3C1EAEAC5D799E6F4469552B0A2737EADF15
      E729E24DF9036FD32E4D9C8A9C475888C40D990BEF251511CF22538F10880E42
      1DD919ED317D4242C93A86ECA30590C812FB748B3CCA42FEA6049CF04DFC2541
      2E6AAF4881F069AF8606FC845133C0699D44E1726C354C09D8F90B13E7CE6670
      6FFE0A0E5C942F6235371A89A7BD3F1DBDF9F96D4D6D4D692B3EE137AB8F21E5
      80C4BB5F9A84E38C892661468FE7783D5FAB8F6160D425990A83B95DE17B5AA5
      26435ECC5B3739AD2C3BC88A072B32B151A497A951563E4129985962F3A5912B
      3EB6772A4B8CF11EBC386F89992606111C4836134D599A86999A598318AC863F
      E1CC31D91967AF917D4A620422840F1EABB12C5513EDAC0E1BD93CF136416FC3
      34C4F9FFDD8C1328E0245C92C513E8E446A5D9BA888FD335A7CB2943BA944CBA
      A4D8EDDC982C5539F2394AABEBD6057FFB191415CE509E3A1F0A019DEB304186
      430D136368A9755A5E32CA7596D792ECE12C89FEDCC2E5080B572C32131C7956
      07E92B3264D91F132D9EAA3DFA5E33CAFEDCC297C28475B367681C279B535CF0
      3E32CACB86A5A1088D545D49B7E6D58F936E5A5058248CD5E0669D848B57A95A
      19BD84915A7EFD43F9C7CA6F0B4F5DEE845E2E8D861F0337ECC9B2FA82A42C85
      544D10E60B17F0F277142759B1E48804D275B43A7AAF28ED06CF9447F23C4B71
      BE18E350C2A088FF6126196928A5F9F1F5F2F9F569A467455222E368187E07C5
      0B87D133C69D614CB7CF9DC1C541104538B2FC7A12B871297C280CF7593EBD64
      2DB7F51A7773699237F47513B3C5BD91B1BAEE3F79173B9468F51670131B4FA3
      70022B3EBAA9552EDCAB94B2C150B289582A7B2D28A5F338B3B562376A9B3E6A
      EDA1C0C9AF3914793347B49B3E4C67CE2666FF6B41058A2F29AC850881AD7471
      11B131BBBDFDBD2CF59C74C8244F125C53187F385550ADE62E7B2FB64661C4EB
      892804B20FE9D341910829E28DE6CECF311B70862DB9E79B6B4EC6C9B3497CDB
      A55B299A85FC497C80A4FA8699C42874BAD37D67E8496AF36402176F022732A5
      2C3D4DC8AD09D2E11A271F17D105D4BDA3510C05801A79100E8003EAC02AF824
      2161E249940726F093F5DBFAA9A6FED2BAA8A9DB495467955ACFB3304A6BEA2F
      A98DDB3AD35763C82516FAD1EF6FEA01CFCDB9D22EC613262A5FA6D88A855A26
      96BEF3E4A4CF493EA3F4D79345042773BD5D9687D2BF828FA96DA57B29F35AA4
      8649FA8ECD3C44AC94DD31791A8EB66A96112DC40A929901C667BCCEBCDD2B91
      C0AB39F2C034639AC244C788968F4D19A0738EA47840DB36C798A41099763676
      591F7E22A21D4B9DD047910BA66C2C99A3947D4E33BBF49BFE2FC62C65D19056
      0B7085C4C8E4F80A4D111685443BD9D74E33EDE9BB5FC104DD10F8B8B1F4920B
      4D099342A5616F3F60FBD349122E3365EE48C505D6ECF4AE8911D7B3489E6521
      D27C777A9245E2AAF33E954747C2CA94F2F2B423A05D945607A9F9A78BE439E1
      5439E2B13181DFDB9D86776AA1C3D8D9A4CAE119A2482E7F9A8FDDDF688BD3CC
      26884DE370116C2E647911E409F95FD0283A0A5352C44F0F9D399DEC8C32D648
      CBB5AF3428CCF952D370E49913D86AAE936062A1AA247E4681708955435643A3
      D389BBCB18B1E86F8D15E6607A132ED3E21539CC865DC54A42B03ADC8076932A
      72069A4F30A5D2A661B62987D2C866952C82EF7A0155CAD165171BA49572B970
      9E9244A159799CB7D5E1E1A19FC5809BE2B205731D0714CA757B842817AC8855
      38E1CC41F1171698611C983BB825387199E451248DBBDBEBCB09A01547A47023
      EBEF0911323ACE97E207400CD2292805069971F2217E3DDE59A523A8AC7519DC
      928DF1BBE99652741597932F42119B5C853192CD2E3010C35EDBE5B561803BE8
      4F25890E6353E924D16BE493F45DB8C8171BE293239C1691190EA66D0756774B
      7C69A718006299C594E8923809AB78BC3CDC09FFB7CEAC1A385F9FBC060A9021
      4CB78C8C4A282864EF85032AF29C5528790E6E838A130909504410F77455B4BD
      A248FF56061EBFC4D129051EABED7D97359F5076D22C961947799CC38E99B388
      A21DF9C0173FB6EE7446662A580AC4B9CAACA59FC39AD8E512FA03B03CBBAA8B
      E827D44CA17105F2794A12D3D2EAC4A51095501649ADC03D4EE34651A8B5F8C0
      C6376BDBAB5E11422EEACA4B83308C5B327AF5C2E4E0E41AADA2D86E0F24681F
      8D6E581D942042386A9E328C5C8D6AB247DC1D9E61615A929F8355721A65C1B9
      7C441E42171C24E30AF8A7CC2E803C8AD6BB095684F990579611DCB196C20500
      016144C08DA7D9125C60A90578653C61B8839B70A90E6621421C51005543360C
      0E349F8EC842DED2B0FC09AF613EC58999416555B00DC5A975D79B1CAAAF65C0
      1FC5A438D3BD02302584929EDC20848C708D4D6EFC230B9C350805A3EA0012EC
      24245CD202A4D6DC26D9247761C270C170842424F82DBBCD301F487317A118DA
      486085F87162256AF72E24C5CA0FEBF4267558EC4CAC4D12C99E32FF21AC6C19
      95A7B82E9D73179C4CB7C0B312CAA5B98A79B5C36C44F170963963F0842C1C7B
      72C57E920061CC8C275247A773419E52AE50CC7A4110001E1453AE00693B7818
      48E1B1B557DDA6528E9064D9C13307F457F65CAD346E411E676144B9A4C2F6DF
      0ACF6D988834B9169BC3621C2300C6812DD2EA38BB4B542C795F0452A5C8A36F
      80E95EA5AA17E5B3D99AFF9418804821BFB428655C785E66988F5C728507C09C
      70E0ED02F9E4903EF7B1D98F8A004E02536D52982E23ED278C5B2E829A98348F
      B2F4BD3ABD7AAD1AEAF4F25AC5FA7661D2B9CA92502317A94C302B12B08CE5E4
      D78A741CA413BD347253F83327260E67259E96D3347343D1E6855E9659F7898E
      9E27BD5E01F85B0809880F4A8A8713443D10149DCCE1DADA84F09099592C8152
      E1DF7A7BCBB05E271300F66F43CB897118A940D95118AFAEA3900E666A232E3B
      C39C0979209AC04F9371DC746AE8624A60805EB930E03985AE3E9295B3731AF1
      5EF29632BCE5A2D35CD28D996C58614FB394FC2B2F646049B66FC14C28EB5E20
      0FE993250E838195155C94C8E331AB429CF33447C1116B890D031B9A8C0D77EC
      2CDBE41CB6C5017C04CBE719D3E544E9675CA83641EE390B7669B387FF28CB11
      EBDB70C6671339E56A34944568D546FCFFCD72DCF3A4B75FCB6B8F1FF0983C85
      4394F1EDBC7F2009C6F44045526257A51F481345715010F2FDE0BF48F1DD94FC
      7757E62AF546F431E432252FBE4A1011D9214AD05481CDA90C960D6F71D0295F
      19C6F44FB69F748A421AE012F1B7AEA7401D3E7A56A90A2A04326DA9A9121933
      8AE01360DD70F2207539102B0BC0BE1AFE0C1CEBCAD7562341AFFAE1644E699C
      CE559E5D4DFB92434A958106623587128A7806D300D56E5BC0162EA3D9FF8E5A
      1FDE5902F350A1778C6A650E3FFADA82CD78EB312AB233CA79706D2C0D64EE28
      E663E3FAEF26B1D55A2B6C379BEC6C247BCDA1AEF3CC52E80983D14F189111D9
      88DAB365BCB081814859842999AB3651790C438BDC04F9109B5B140DCBE31799
      0DDB9C9F287A5F939FFA06816F5EACAB582FF8AF7E5598DF787C6AB2CEA02BEE
      01796335558731DC8C031281CE260666693231CB4ADCD8D52F71A50662167410
      A98C0F75D2585292C407B3B94D7D1D997AF7BDEAAED519A146E9B133247B2812
      9BE8903C54783369A4D3F993938565619EE2C579BA8BDC8C229E8DDF869C754E
      D568A4DACD6153D5D55532D331A0CBE4158577EA538C3951901A6FF6FC88BA7E
      E7B48F09FC36EC5CD454AB7371413FB52EFA3575DD6DB6F1D3804E7F2F81B39C
      AD39FEAEEAE440893F34250594BE04E2EFE242D5E13DDC9A24536D9203B95143
      84888B65A16065055300108B2B83BC31AA7BD51EAAC952FC84E79F63CB19E0A9
      AC4A3F8F015317F4456BD86EAA141EE58D59BFC0F097CDEB735557BD2487D9C3
      79317579DD3D2F62DF2F786CFAED81AAAB8F619C95BE1743A6FA3A0873921499
      B5C2F6F102E7A3F5B1AF1AC57C7AA8604A33756127ACD77943104A25C54978C7
      979806B20A9523988A89B4E2CC334576D99C2148F12658DE55C02F601DE2D41C
      BF7D0BAB62D819BC550D3518746AEAF4EA0DFEF38EEB8207A7475ED3940229AE
      2B2E2058611CA6732EABDBBA440E12AFC993922FA3525A12164F5FC8C744E8E9
      D5EBC6E9E5B59FB974798D52EAF08E3D04C05A25C794D9A2E6529D755ABF4890
      5DD4150389518080F8A9252F9A03147C4438BC42866FAAE697D783CE33BD2C36
      D51BFB3C685D5D14FBE60AC429594B411A0E047D8AC37FE64635270408ADC61F
      50764A28ED48C30CA3689FDC930AF0FDF96F47AFD3FF05BC0FF942F5A9A27B91
      A7E41039AB8F70D9D3902AF0C76BAEF67E095DD2FA58538356FFA2A69ADDEE95
      0807A8B91AC7C85F68E0CBF35352620E763598235091AADE491F7519745A9146
      26AD2F65EACF76B7DE342036BC7D11CBEA7E610360B06001841BA51F52B64C66
      7198C88F48DA10CBC9F3AFE5E915809FAAAE061504E9365C94A1A68C6F788129
      94B5D075B11737991A20C20F7F66B03FE81CF0F38F3F0A7E81981962B38AA02F
      5C5A946A2DB667EA08123845EDB5FDBE8A6250904B144696E39778AF3EAFC2D4
      A8B34F045D09CC9DCB0A71E94FADA8EDD75185A48236A3A87C5B8548FB314349
      E62A7BA43E2F1531BEBD1CDB5C128FAFCA93F15D97CD6E25F19F8414409A0A88
      55F2B1C5ED8C2D61327609A7FEFA6930C4F15DE9A53AFD747141CF3D415D1C9D
      A196E35243E2812A57BE430E7CDDC3611BDE1FD294DA88E060EC09BF421285C9
      131087BE25F8B8F8C59473E08F49FC48BC678239A5F998B39D6420213FEB702E
      FC40AAD3F9F15E9D4EC910E25F3834CD630A168A9E2CA1203A0A67310214145D
      C2018D8BDFE9C0339A1504EACC64E7A9C807B2DACA9F1DE6789653A583484DD6
      E2124FE208220EDECC80378EA79656FE4D51A7C8D0134022678ABFBE80EEDC4C
      216EC245AA60113241CAE8E7166CC44F1849F4A5D83F0EEC0261414147DCDE9A
      5354482713446BABA0FDB9387C7EF9DC6ED2EAFF3238FF2BE75A80A08528A369
      D2FEAD12149B040ED0E2193D0B02954EB4F370B1DB9FCE1DF6F614B5BE64BF02
      CA8B926AAEDE965DFA86ECFC0EB971797E7ABA43D6ECB4C89ABD77282B78F221
      0C4DC91874AF7A3D2A530B4979D22D0027109BF45D7B6B2806B7D069EA76B334
      E21F35AAE4423DFF6DF81487CC130313C924EF69B6C571D46B82FAA8F1FCA655
      004CBA269D0FE67A69008017D019A591C4187FFC4D823085D1B17A91ABBD04E3
      E430D1710AD72EE5B739190C9390264C1B66EED8210CA8BC07FBF402ABCAA2F2
      A3BEB537EA3CC631D1EF116724E9E84A4B5D326069629309782330CB6CFE22FB
      9CDE202A6BD2F97B2775CA85410E6A3B1FCBC087E7D1D94C85E667A222EA5AAD
      B1FA1A91DA4B1C284A180377212923C7B506D9C5857A6AD0A12BD06E0F0A4637
      21674BDF73265FAB954E987C8EF3B9148A006292785F08A0C9A4B5A40A62A24C
      B5CB049CA9AE62893763613D595D402307BA52618D937AFD45B84C5F2162A36B
      707B2AFC73C5920656806C08E512E51051D2E1E305AA375C7AD65532AD1495EB
      73E919566B9B32AAA0BE22A051750F9CE1C07FC8C706100954327826EEBBDF4D
      9D47F83F783EF83758666E5982469C35486B8287733F31771AD692CD1EA63349
      6B0E1DC07CA0B54DFABFB4760FDC87EF5EFCF58D9A26DEE1FAA6183C6C3FE631
      F6A18AC441C08FFE55DBA8FE46D2959D24C9128279D145D342EFAA611DA8C8CC
      F4644DF76819DE190ECE6901CA9DDA3C69A10E182E8D4E553704E9989DC27C17
      98D74273655181839ED8590CEF4EABF66F47879B0724286845F81EA49353E8AE
      5DC0996ECFC8144F6BEA16B80FB6968FDA8548C09027CD633AF6DE48B0680501
      029B8188022C9920A4D3C22976E660B17CCDA7905899B9208E97A5B045C27422
      5105FE22287F56885FD6281089CF52D0F60585AB03028D190215AD55045034C3
      59EA6C044EC3192D2A01BF64D15824080B08EE8388280390D4DDD6E5819C3D22
      BDF11BC8010EC6FAF8B994DA5D3B5F788A3E561D78514728ECDC9045982EC19B
      1EC83B732CCAE18138E640E28719CD57EADACCA41A8F321444CFECB91DA06B66
      2C3CB1E281E4201209E60AFF705DC238641A91102629C309E2590ED7A410C78E
      574460B1F70AC7BCC8BFFFF98CE4DFED0AC93A4E4318E74ED9FCEFAF10822F21
      CE27A40B6C5CA12A3B30E9925ED4458F2843D490227B89BB142CAF8E69FE3ED8
      0A419BB9CE23ACF52C8F7452377785B2E3BC241911C22B8BF35C2FA40E557A15
      BAB11E85E344331DD68D3B367CBB2A213FF173CDDD1294FE36FE43E9B5CBF5AB
      6FAEA0908F709D7CA0F6684F50AC9984EC34EFD744A8E1D3EE5B762A55474298
      0691CC99BA8225C061C63F149F14C77A1CE5669920F1279B35D1F1AB1259C7EB
      577C282DFFBC0B0DDBD7F71F8CC1E56EA75938B95937044688E42BD3184759BD
      04FDD49829A32968A7BA8E84A1A5C495B16DE139D57BC771AF6792A86F66E66E
      BF9CAC7383A9169229476AAE16AC9808CF8B6865F88B05255BB6A66A93C0F822
      73F962349A6286D759E4BB2B52DC400A389464B0CD946D30562875D29BAC7CD8
      CB2F58A34147301337CD4E55148E03334532AA11FDFEA67177F7115219B2381F
      CB01DB3D26CF77962F6AA3A8222DAFACDA83DA1E767AA73535EC377B82B5EFF6
      862EB2FB417562BAA6606B4BCC4A278104AF297CBF19B8DF07F6252DCAD711C6
      6D50DCDFF169EE7CD54F1363220D9C170FC24CE9EE905A468DC899163BCEC459
      BD7DD12A6ACF1C79EF0E1138A617C7D2ADC6AECA8C2AA26A6A38901A1BAA59A5
      97AE95B811F8C883701673664B242B006C7A09C191187078097BD49485092042
      7517F123E4B9370D3385B064E2559E0E3AD10092F0A4989243502E445D578444
      D479CC767568E3FDDAE605C1BB1C9C0C9A8D0358A8A5C2AA7270278D6C65F40D
      50F80F6EC3739070FBF06E9FD8F1783D8972B349C1DD32082CD63679BDD3701C
      26253DF7E4C71A604F0BDD355962C3E041C26EE2A0D1F15267993779F7833C0E
      DF652C3F009987BC6D9F372F1AED8B937EA37D71FD598D131D4FE675EEA243B5
      1D5A88A537902331022BBF22672408418AFF068ABEE767D177E21407A9350FA3
      E00C992FE74133BF0B633D1D2733EE605787B120EE09E57C9F67F8A943FFEDF4
      EACD1774DD7995B970E46F9F3BDD4D9A1DE928C02195C408371528A90BC92A09
      15AC07447BA09679B2F4ED00804D6B1314F82407D2DF04651212037D3AE7EC90
      8D52B527DC23A01EF164AAEA832E4269E49F847310052A8E0FC9218DAF29BFB2
      47C8580E5302028F29D1F7D27DA128A0C4A6CB8D4B89D3C2A004DF6B72E7609D
      24733B987ED4E95F4D6287425B6C93CD6519AEC62C84DB66EABDEEFDCED9A5EA
      B79B43CE3C099923A0343ABA51FC4FC69813688662D9E03B5F979CE17E0771D8
      19BCF94253000095329FBE9E3E9EF59A9F7561D2B471467426499DE4212B0014
      F18C0D67B5A1A4998D182F46D53245458D027DC24BF719F8AA4DFF0DAFE80F4A
      907FC565DB7438C41CAD3A1CEF29A882AF0889AAF03349DFB08210C33D709C57
      0B85C987A87EB6A4E5DB5812CE9E54BE67A82201E3FAA90C729C379C22E2EB87
      B44751E657BD232170E4E62E0B4BF1BE07674B2B55B8E8146BCA6055032F014C
      48988A0B4785258C7F5FE6E388307A45F98B04A0521560C973163475473953B0
      64136B180EF22F446840B158CF632087AEDA3C80ECECA464CE20DFBF2E62E2F8
      ED3181BF6BEACDE1CF6F1992C39B78FCF6CDD6F2E1F6A168C73B182AF5F9D2CB
      A1419C169BA0950D1DF6CF3C445891D2EC50E8CE8345791E8316B8B6A238A83A
      E25F72E4461E005550E742BFA2A9041F5214B26E46A89C3697F2D662827BCC22
      408D59984F9A081067BE5C5C6D4914E202E1F91B2799989BEF7BEE1FAA6E3A2E
      ABDC25B739687947B3DCC541C3C488E89A4E643C73D93E474253E5C4A7FA5CD7
      2BC389BBEF6035B81F25F8AE7CF87724E899D3421C7949CDDFAFBF421F44C8E3
      28AB961C15549DCD929383D88FF6FEF4D3F1CF35F5A79FDE1E79E20DCDCAC53C
      DE832D9792149818F3EF73500463E242A38F0BD8F6B9B817A56D4437C15FA31A
      90ED8FE2CAACEBFFCC75C4E45A10ECF52A97E887CAA07010BF39E40F7F23CCC6
      171AFB87CDC10B4A614DB10FE3CDF3FC1134985870297CA741841260A3DC34B3
      CE2C60096E938C6804E6E63629FD07A1A4AD14F50761C21EB977419A7B2601C7
      E9B92EB9650E6607EA87CDA3B5F706F0F0D3F7EAE81030F1F7EA68FF0758EB36
      D3916A145CB71C12E763AA1A45D1DF6EB4AE45E9A0EBFB43BF7DE5EA195D78E0
      955ADA65BEAC53052F27F2F6EE9FEBC7EFF2D7A3BA8FA624E87E3DE33D2F6277
      1B7975A97C79AE08E163514121048508AE97114A8ABCC9E68EADAFA3CCAFB819
      4D74DD0C2A51C70D85A697CB08B96698C90496441BB92CB137FE4CA31D709752
      998C944E80A2AA5C13326B105471A8B7122A27D6E4D339D8AFBC9B0001972565
      36752790603A247A82597C1D21F32C8711B21DB0F98253C06978AC18992908FE
      11A0628B7D8E1C54498382F787CAD69CE5040A16F39DB8B1EFA88F927652E799
      41DDC962A109A5409B9C33592D738C15E24D0A1B986816829A8C07A2C1D82359
      F8EAED1D3DEE1289B7FD0F256EB6F27C34A920AC72181740F897794578DEE06A
      84D7EC0878CA58281FDCD8AC384E1EC6CB3CC3ED7AD55D776D005FE5D546F38F
      89853558FE953FB13D710ED33DAB989344661DD5B0952C8870D454B01C0EDD43
      1ABE881449BB989759E20B4B543FE03DAE3424DAB2AB375B01BDC83CE4C26CC4
      5E70214BFB958C79727F99739F0D0A7219EEB91CF3D024400B0875C996DF513A
      BD1D44A027A61945EEE55A17E7258018085C82F1919D6FF8C3C55FE2B508026C
      EB8B2CCA9F7EFEE9A7D23828A422EAABFF99639FC668BF4295BA623D6D585CF4
      EECCF5C25E1BF356BDD054DF1EB22D389887E091B3448BC8ABDC3E6FD785A762
      99D8C552AA1A1D279C0639E10AC170E2A94118C071EB95B7E565667D74787C5C
      38E1BC8254B1CFED378A8370666204B8CCA0F3EB7BB70D0728967DA159BD79FB
      9342CB00B1D8C958A80B994240C870F21638F716A87FA0F08BCE28FE0C02D17C
      4C9F7E91E9F59939570DBB66613942352C9815E82062E8710E0AD080025175C1
      4FB3C44BD51EE739D5096A03701F51CAC5BCC72E0124F4BC4CBED437B3CE1D1A
      7ADD8CD1C980980ED10C906780AA7950F47095E770B08EE9D74FE16E7872C058
      D2ADA69269AD81645BDA8417F9D6B39002F8CE7AA008BEA4802B9088C6FC01A8
      FCFF9195F4AE745D2AE95D7481C2837B5261DA0038ABE12C81C6E0F468C7EAE7
      5EBFABEADC7B303053786B31325CD4BC821B7C7260E7C526D0ECB52BE5F13DE6
      9E6A221A88B767EE6AAB4EAC25BDB8776F0ABEC39F5D62784A14C8FB738FD734
      53C74C4EAE56E34F31603F7BC7FBCFFEFE145460B629CC836AB8DC3E4C5BD2F1
      8639368269E78EB07CA7895D9C804BAE6FA6CF3E2124133193F3CBAB6EE3FCF2
      AAF9C074BC1F5CC952D601FB2C53933A804085E891C2254A726F242C9FE90507
      AD0E6D397142D49920AF37A7AAB544CF68060EA84D7167576E0D319BE838B00B
      57CEF64C135A8D2BB40B58F9F46A0517A38E4823C24A340FC0DE9D7D819FF933
      4B0D08B0B83D97A8C1DBDBA83F969CB567B133F8E7132E966333817131A1B3A3
      7386BDFA199F9DC15929DD48E67054002DD119DBE96A6F250DBF5878C6A30657
      9F2E99FEA33D68B9E3DC77916FE103E4583396B006B40BC7031D8DA71C84CD1D
      F7546B48CB8D46AA839B0EC94349DB8F364F907018984C4D230BA6F270C63DF5
      D4F1B39DB4F3F645A7D02CA39122D033DD44B27145E866565D80D1F5C152F667
      5801AAA1C70A4CA7D43BA35475BF1264619051951BFCE5E33A243023AF70E3AA
      B26EDFBF667534524DB25ED24AD97318456A8854B1F3873E10C49A4550190A71
      4E123B443A52793C0D23585D6C10F1313668295DA7B08F835410CE9C8ACD8B9C
      D6005DA75557C79ADEEE9976F963BB075D2646CBB33DB6D76CD1B6F506ED6185
      A822057528107E48307320113823018CA97FFF3775747C5C32D8703BDCC2B2FA
      AA99F17D557F8FB381798A0D22DBA9ABD7096AF3D03D9184ECA07F76C23F7B3D
      F4F3F023D93BADC8E625664BF81B8868C09D1292F7A9FAD3F1CFF53FBD3E527B
      DDC3E16F8D4BFCE7EA70F8DBFE4BF9190260BB18B4FA8D0BC82862501789CCAB
      C9D2BA8E02011C2ABA92F74D7FA0AC7C1562A7D23B8D9726980E28397C0A5EE3
      4B9B39F1ED39C0858E830B5E6014B0530D7F13D9050A27C2A5B1838CF227C4CB
      2EA79642422575ABF39BBCFB45E0C586AB713BBC3D6D1BB497D1A99FCB20B60C
      2A4CDD569535C685F27C365140E35C9CB5CF6110558815CA91E884BC5408963C
      0419E856272137542307DDBDF39EE32B257C1CE48D912F2C01E20CF2C4B389B0
      30A62626C8E30064A1AB71CFA67D9B3556636831FEA1D005C8FAE95B0BA657B5
      1A5F9BC96BFE80FFB2A3BB7DA5FE1FAA64352EC055420169F1BBA27B5A66D538
      311A410D94E5D603B3048F613C5973FFDB270B535C78BF4D1B0CFF93A4DE60D8
      16DDC16D3E7504676657B3F95A0E0122E8437B4E420363983B10FB61A11A25F1
      5C556AFD31CC4E62615084F9EA75059355A08289DA74FBBA4C3CEDABCE6F3D30
      CD7110BCB03900B2A12A11E67FF53BFCADD6B062AEB9AB58F1CB2932B52148E7
      E8119B93FFACC6C48BF15DEBEE4D32757275F54BC5BFA0E60464EED2EC0668B5
      898F342ECECF3E96126C97D5D9B66BEB3032673129B16978E7171E686EACF846
      2C0887C62FFF80577EC00D201A449C93A3B76AEF228C8D4EF6C9A2BB57D0BF53
      A8E73375B96F49CFC56B13D94948544CDB67962923E19A7C60E37145E847D7AD
      F12B71AA0D1DE7979824B387E93E0A8054BDC0C51131A0741B194C12142B2396
      9A59757975D9716981D62F0567363D0FC0B8C444EB5209EF3FA7CDF4B9D3EC21
      6240E51C9C01588C0DE5C23F739759A69244B09A03A8C4AAC668E09A5A26E636
      B4791AAD5D81AC5C5962B139BAC7625305CC7F178597DF5DBE6C0FE8C072744C
      3A1838838C08634415523C1C3BC15C3E7B5C375F497A3866A47DFFA0C568A486
      3C91C1BC4AC32E0BE74ECCF7AC8AFF593D1766D336F1465C4DD5A9E06FF92A6D
      9079711C0D17FAB2D97DCB1CE8CDAEDFB8ABF1D5C970D037FF94A0C539971937
      1CB72ABB4858F192AE9472FA57DDABF6F793BEC156F5BBCB57ADAEAC06526235
      4CD6F90E0D81C4E3D0C83D603F95922294984A808342121FF97686A7E6891F2A
      E4FCF292C4DFA55E50F7014A562000847F988CCC235A33095015EBC6B15F74E1
      8199174E429AF0772CA1E7D1C29A110FBE5498154DB4D64BBF15B8F86631DB57
      68E33E301C24B33935E02DD3F4842BBFE79AEEBF7F787AEF8E31BD77C7D5E999
      38D0E9BCC0A348BEF63D15D395B5747B2DBD58AA61984566FF83743494F647BD
      8BFFECAB3D89CE16A8B67D85C821C06D082C53B5B44DC9E86B2456AC742EB9FB
      C088CA07B8F4CAA6915EAFD3E75A3FB5F75BAF356CB4AEDA67FBB5B21650ED75
      2E2FBA8DCEE5C510FF19ECD7B861F3A76BB5D7FCF4E97ABFA67AF3751A4E5235
      58C713B5D7FB3818EEF3056977CF86447797A7BB4EB25912EC8D23341642623F
      ADA9BF0E4D9A9DE6F144A4BBC0071C524892610F6CFD07D56C9D0C10297CA3FE
      CCD7F6B2D7FA3B779EBEB8BE38674B588A0FBDCFC964AEA3C8505BC9F512D313
      7EAC463881FFC5BFA3B5EA0C68AD66655CD14F05F6AE4F9C875FF4C226000BFE
      7962833551E28A8CF2CF3B5E9F0FCEB979F9B8B9188726CE5A3642910969D20F
      456928C551C3786ABF7A6977624E22BD55B04EBAEAD30F7237C0CB6656DC1531
      8F6F62BBFA8E32445F4D52295375B0C96AB9EA876AA96A9A8FEB0EFAA1C908DB
      431F06147347919BF2FE874DF52C75286F7FF29BDFBDCADA7B3B532992DCACB1
      7C0878F55E527085B70AEA82A5496E04FC4A5DA238D64D3F17BE2C0E7F4D9D9C
      0D9A288A0D6FCD3009673393A0C2AA717236F81568EB6CFD69394B74C0297A66
      89AC11C1076E0AB166120F0E15884595AE5E05F1267913A7B0C370A1BD01886E
      97CE3E77DA6AEF2CD1B770733E43349B445C392A0E6309326CE363434080545B
      2F30D9EA670A6254299D23527C80110C89847B0350656EF1A87D42051A54C76B
      94A5DBC9010103FDD39C2C0DDCDDA5885D9DC3EF40A1C7370D82BE676B95858E
      8AB10C9438CA3F948DD7131B450D307ED087E46BF5BCD8C4344B5F2824EDDCEA
      5EFF1392771CCC8361F96BAEE32C5FA84E9A520B1E77A25A367D5A4559711F3C
      33E52C8BE84E140BE1F402BC59AEB0A282E974B3FEA3463562849EAB54A18D91
      FD0AA8E54F7CBFE6690FBFF9CBE0EA92D0C9AE3B0552744461FC42AB3FECF4BB
      AA996400352F50972536717137EB958E7B611C1017D1DED024898E553359E840
      3BC17674B4FF07C1DCA960D2F18153A60F40BEA84E95A01C4F20FD55F6B7E60F
      D5854DBD4B1E40252BCF3D4076D0AD555B1A0AE2C0A40B2918126D8EDF7A4774
      D8D93B33E8F54378E1C422080DC497A32083DB572980A4367534813F88781753
      DC225B1086925B93E8A8E05D68C83F2E10122D71C70B93CD2DACD96610F434EA
      F7058B9DD628188330321EDA18E85B33B4F8A778733631F7CF5D8585973F26A5
      D05B33E40721AC4CFB94982C4FA45081495AE51DC41E60B66784585E28F9E18E
      D157F8288A6C084F962B58957C6C6F9FD96D096D594F0DA023D449DB7D5D0ABC
      363AD9134DDA8BBC4AE70E65F5EA7C35EE70EAE24036348C67837C2C155EA473
      5763C22E1ED07F91A23F5977DCC1689CFA779C75A0CAD5F89218C8C2DF8D6B4F
      852D1798A51BFDCC64F40FFCC94F23039BCBAC79E7487FD3800DD99DC6298429
      58168BE4CE072E312B12562ADCC8F2B8EEE7E8992BAC3400CCDC3F79BB324E17
      39614EF773DF6F213CA1E470E8324DF5746926E1349C08053677B9DF3BDA479B
      D1797D4C78D187F9509E7DD6B82A2E901C984984D35EAC1A91DC3AA03153A68B
      CAE5F7C3979ABDF34A7FBF3D2A726EF6CE0F96FAA52C9DBF09445700215FCA95
      A76EDB452C464E24E78B79918146598827927E28DAAEAAB1B537F590ECD412D6
      22F473E8A771AA27E6CCC4EA200EA715900BD47562B09B802089D7DD68CD7582
      0F974D37B89A71628AE700C9487FFF004386B8384832F69BAD8E3A3033D7CA00
      046A348B0FAAA7976B58647CF12AD508DE5C297FFB14072632C255EECA750B65
      9F7E61373A974F05D5962199557F55FFA6EAAF0F0F0F0F0B5E4166E1638600D7
      17557684EA3E13B5F73F8EDEEC9764A57649F11E53B7D3BA7CFE9E9BF23264D5
      2ED9680B08CED1C1CF07C79E375F3CDC6A336AD483904BFB4DD62112DE0F310F
      7D28AAD985227960E024C1EE3249A823425E1134AF1CB64E3952AE8FFB5014CB
      38EB015C3C818E603B578991245340CD82E8600F22EB18C006F2552A784A6BAA
      978436812F64A74C556409D57512D90938580523F7F5BF88FDE22FADAAC59825
      0F9323E014FE4E4764592514DDD808DF1BB34103CE9C23C4FA2D64E6D22B8DAE
      FE07EA434F258203700625AA6D882046E29AD42B3B077F7FC3B1E894A4E80C6B
      723B48503ADE3CD1F64288A3F60E0F0E5E1FED97E58892E171A01B74CC2B1F43
      4691C9FE0EAB3F12720A2065F338362640472888FCE66482C63DB08D49C18342
      332C763419A04D3BA4C0AE6B38648EAC2FB4AD3FF4E11BFD402FF74337E73237
      F91D83080157C1CFB54A19CE1A5A454B3304EAE2CE2E16171782D7C753C76C93
      D97F8125A6A9ADA590CCD7CBDD6A10A33D6F8BDB40023FD78A72A13ACEC252CD
      D8F758D7D4DF0F1B7F3F227DB2B0C9724E1578115431454570909985BD3E4160
      51E96839D78D8FED7EADE8F836F8D86C77FA7FBFBC42A27A787E7956FE495463
      E3893BC99786BA71267A16D828C20546A9E89D6A12A279EF1F210E2A1C68BFF5
      048E6501BBAD19872CDDD22F4575132D83F48B4196908A860E6EFC588DFEF610
      ABFC17F5110A1382A9E08806C93B737E97BC2F347C064C333901CC085E08E79D
      E6D32F5716966818675F04DD83B1260212412864527C8214ED787ED345B8045A
      B5FCB2A7E9B445FDFF85CD6DBA2E38256308EB425C8C7525D085FEAC37614CD9
      9A9211DF57061434FB5FD439F3BBEFFCD06BEE5A408178D5C31A85F18C858B46
      FA6B69EAA481A4789C8C969B7029178C650C0B4034792F246C183B341BAEA8A7
      34B1CBB58B3BAC4523BADD271220A4DE8BD60F8EBBBCA0E4349EBBDD3790B268
      595C46E553B72227944802FC2D4EA1CF05B7E179AE82405D861757ED4B1B982F
      AA350732BE20A9BF0CFB30302EAEDA452F8CCB903121F23BBF51DD152F2CA62F
      C24321B5E3B084203BCBEC192713FD02ACB08E2690E4EB1455EDC5C51075CCF8
      9AC9BA4E6A5562C9B00DBA8336CB111A9CCFE0A389B5A7E01B3F1343445A77D6
      6BE994645675071F8D5EFE116D27B0EF0FD1C7BE77F4CB4C999F320D33EF5369
      94B9CCE404C1A70FF2955E62398FCD5F94D585704C15B536942F679647E687EE
      100F7C90E8B64CD4EC4DF1F72007A6A0E02FF2345F2B9D4D38274FB42F25A1AE
      F4D6C39F880E8D0B89C844135677897684C574859D1E786FBF708BE860C71A4F
      D66359E42C5DC8277631A6443DB96EAFFEFC4AED55C8A55D92FFBE390EF651B8
      83744FA4DA74010FA8E11046C4BD3D45A79B9DA69F2EA3302B86702F4360B1DF
      8DDAABD3DFDF5FAAB3937DC0B86C90139D419C83A9B1DACBA2A81C23763304E5
      018F8571BCD311639553A9DE97F2F15B60DDA8AB0485A1534C99240488F25CF4
      CE6F654C56B576B82C99285C26108FACE9A4AEBCA0A3A1D0FF52F8C9A4473A09
      3AD7EE9E64F7555FEA7D36BC0C684A5872A9371B0CADC3ABFAEFAFD835218213
      6A3A4EA420DBD3DCABFFFEFEF7281CFFAFE8F737F8FFE9FE07651761893EA44F
      097BA930A30818CE3B5D42B1738EA552B04E887BB81A6799983A876B3CC30814
      36D74593545C2CD0EE0764B8D38AF3AE6935D5516AA80B8834CD517B85F4F44F
      064539725588E3E1C9B2B94E6A171A66F70E05CB67EC50309C835111A132E360
      1EC452986632626222434506086448EB827787877F2E7A1790C43BA25F94CCCB
      7F28C93F820965906692842CDAC739D03B7F3A3A7EF72368E414F126A0DD8489
      4D9AD6D49F8E5EBFFB99908295082CF88AF1A737AFDFA9C018D8B14BB470415C
      82C20E3A8CBCCB3ABA2074BEDD284D73280A8115C37F29F2B7AE4A0DFCAC8D6A
      41C1B395854B3C954CE682A31DDCB8D59AABBA3A3D3B1B344ECFCE9A8DD3B3E1
      80040BF7B68DD622DE3C9B815CBDFBF1BD7069413E5134F5F47CF0D18100CB85
      AA159820CC0FE19E34639924269C9F9077A9CAF7284386CA8AD1CF22B907C2A9
      396DC2BD0B1D8F2AA7E51C36AD56618A04C79F5470EF84C8C24EBF7FA0D75D21
      4E6A8C57570EAF8E8623137CB260BE77789770B14CEC2DA5763C8D05848BDF0B
      6DAF3BB874FDFF1A46FA56ED1DFD581F87AEB4D8BD36F5625727030740FA7775
      F4FAB05CD74D9679CF627BE924296F18143424AEE8B56C7AF2D9709F29C836A2
      A3BBF3B5467B2621D11E4FCC7B35581A13E4D4C50D093F9B14F05FA11F7A76FE
      FA0DB2F94DA015EDC63D4EFB9AFA254F6C98A5796CAAA4F682736DE974A28350
      6FB0DCD3F946B64D4715AEFA6692CD1716CDD2074C72FF993A81A0745B40FF14
      47FD5710D8B3B4AFE362537B3491FA4CE958D8CC427BEB3902B406AAD99DCA40
      AB36BB44D04B1A7E53CB2FD12B24C61C431991E193851C105F7B9D58803C8527
      EB2840959C96AA141E487F358A8C2D1D57969B0E712843A1318DB78E99AD9659
      D87C17E5472C0AECBB9335901257107DF8F1BCBD6188228E4BCE8C98F27E29CE
      6F606787FA86297A6078993B2418991C5BB8EA49669D996C6BA25E63F5901D7D
      75DA51878747AFE8D03B8A20B8A778D7BFF11FBF50E0FDD5E14FFCA9577F3BFC
      E9CB2BAF213F01D1106743FBD1DCE1CCCD12D4C990D113ADB9B52E25F10B4603
      46377BED6C757FF68B82C7CC24080731031918A1B24C6C23B2E8A7C4211C3A2D
      C56BBFB001D15D3CDB342ED059B00BF33E48EC32003C97E2CFE21A563D6B29DE
      71E8789C7ACC3D4482CD1B0EF5D09CB2F51248051082661A7E1DE8F7B807EFB3
      8C41814210B050117F662B75E252C9BF9799C93C96B3400D76190688DA2BE2BD
      C9E6364FF12DEADA4ED919CCB8426EE90B2C20AB11FFE97F713639932AE36253
      103F4C537485202847AC234E57509FF392B15D1C8E1DE6D0FFA27ECDC3C90D4A
      0D98E09037870F073BB89FDAFD571B29F97B69F72B49AE439764DE816BD40C7C
      D9A602D8285D85474A5B5AC6F52609F09A55554BB77A6E22629B95768561A66C
      EE9BA0DBACE5FE02B80784E081303E116752042426D128314E8A441A4AD13493
      A296D568245AE53BCF369FB26DCB01904CAE2EA15CBCCE9D99E42E684BBF2EF9
      7606F9B82EE82E82361144E7393A533CF98D06A7475F04A8B091743F8972D37B
      561F61E3E271731AE2B3A4D620638396B1AA33E8E1A29543EE142E2C029C544B
      D6D3995FF89B230C75AA092A1518D0B1551E5EE2B415165166977494F8F01DEE
      A34BBF7BF420506DE74E353E56794A391C75DDEF0C2E1CD568752BE9D771B051
      30BDD3547A2CA4373B626CD00EC79B94AD7EBB28CECAB71D952783D4ED242F2E
      EF7B286569CC34A8AC16DD5932B7A81A51B54D22608EFFF3D9122585093608E6
      E871F5FD9BE41B0393ED762388BE8EC8BBF85C021E67637499249266E20CAF51
      2BE19D4804B68729646AC3BD17B1D300BF7761A806BD314CC4BA5BCDC153C77D
      73614717246D4C009B36DC9CFD567A4B550AE0A8821F46975752E5EC5290EEF4
      2BCC695E9F372E9BD74C8518205E8F86BE0F7345D58AF8D8980A84B83E082DD4
      91EFE62200BF98E060386C6C102F94A08106177F70CC6B176E9066BB7DD9685D
      5D38C60EA0598273B490289B233D27F1611D5473A9B93106060BDA73226EF6C2
      5C41AED764996AAC0E78AF8A5304494A2862BF52C6B274830DCC928983F81E7F
      41050D315B9C0F8E1AADF3C1F11F4128B61A9F22FE2605954EBD51DE869BB211
      328C108B251C66370364353E5967666344C7B849A9BAAC680BB78327CAC446B2
      D21571E8F9B04B7D8BEA941622268E9AA4AC5C99C3E88837A00FBEF57F64B4AE
      C6A77912871060D4FE0DF5053CEA6EA493EEE17A626648BC3EC7C3DA57277F61
      2066BAE1A8EC74265BD12223280DEF1F0AEBED14D5813323C950A0863C1F8E20
      40041C4B495E736956E56FCB50342205055C93F102D489592840773B4BC324D4
      80FBB9E34475E17492D852BD0FCD7E9491E8B5D76C3E0F4F3BE790C0155B8963
      F57F000157E7E26234FAAD457AC629B3CD6C4083B7BC8AD1ABB8BB144FF6278E
      6C086BA49C81AE8DB339C101E89A31E346EB173FB576F5E972DB58F24BE8F43B
      1D79902B1C113F9548912A5562CF33F1CFCD615FC6AB086991C76CC674EFCFC3
      AFD8EA74F0D199328F92AF7DEBF0F5FD9905F84D57E30145405DDCA2E4A4F9ED
      A27FF1F2B460C47D559CC3FBD9BBAA13790E70566AD4801B3F5C200F5E7403A7
      7AFEB68D33F48AD8FD3010C7E506C9ECFDB97166138E66E7E28288CBFC2ECC90
      B8CEA50F87FAA853D4C8642033BCB86A57C0F3E257E39704E2F6F46987CDE168
      24D44DF05F361BD1DAB844637B8AD58FFDB22EFC0A9DD136B855D1830D7EB9A7
      4326B7947DFB7C59A32088A06D5C099E44B6104FF2DC7E22D7AD4BCF8BC87990
      706DE8ADC0ADCB066B41B70B64C02E433930B9CD2B1D605CBD937BBF5D06E849
      727B08D04AD628EAB1A51F5225C01BD867F11A31EE68D4FBA53D1C8D88FC32C9
      9759416E77FFE411DB0132729F1EA210F9CE518B224DF46F6E101AF81CCD910A
      3B5F24055230BA5C1B4768C34DAB7698C06FE5FD1A0018985975446AC52FA872
      D686C09632D5ADC2530E2EECE2F4421D956475A497E899C8537BDA00BDEE035E
      FAAE4FBD6CE3EA3B4A9ACB669719915D209265C1197E2587BA28C566BDE667EB
      5F5D0F47A341AFD36E9CF3A6BA0990B9E606F783F57CEA5F8E465D7E2C593514
      3BD97DA95A57277F198D5AFC60E291E4052973F15B4BE36BD0FF3668E1641605
      DB54E94E86EBE1C121DAE0D87C3657478707877E97A9D3FF65345A8D7B26B929
      793CA99EEBA11882D718A09E188D4A027A522D00B22225B8411D447BB2456401
      A9253D6C778D3512854E71BC2A36A67FDF9AC6E6331FA4FA5CFBEB2E5079954F
      2FA427535996CC3584B2DF3D7485D1462391D54E903FD40F80FB16D81576B1F8
      F873CD62A33D48F1EEBDA2F10702167C2CDA44BA4DC33ED7682D617B7150A36A
      D1D499C95A49B83067E84056362279A1F73E33D9793CD58BF503FCC929F783A6
      FA7DA464EECD165DA2AAB37DA139129F7B1FE47885B0ABFA13A5302C566BE7FD
      3A1D0C07557F86C22669A39924C8031742FDD9DE180D9346A3FE597B502AF063
      24DAD886E294A0087FA208135E781DAB8B61E7B7273B78A757AF7731D7EF597B
      7C439AD465A8B4D84B61BB5B98153EC86874AFA7035CED0D96DA87477929DE71
      A49146A3F3CB56ABBCC99293BF04AA5CBA567B9EFCF32032CD582F545DFD40FD
      620863F603FB8F5CC6433D74C66B4221FAA760406DDC9010829C38A99D42731A
      4754BC43011C06283CD46366D04D2BCD6F74AAB801D84EA1B70E9CEED6333D14
      916017D0A9985BE96346D64B3033771DDCA0D9FAD8AF00AEC5710DD4DE5C2F97
      2696F2A374A59704940115CCFE2ED10BBC3475BDD883BF8AB27450DA098A126D
      21E2308A5CF3D19DA828177AC9601AC7407099DF6834468C0222EDDAC6496EA1
      76BF9FEBD8EF945DF75C700FD629E2B985BDBA430EF6BA0BC6C096CECC0CAD8A
      B8A128E51CFCED4490228E4683CB76DB856DEF19D67F1C3F74B3DFBD2209331A
      B59B5D6A7627B916A264847145BAB44CB3C0EB232DC2A9DF372F4FC4FC2027AA
      80F677306C7F15373094D2F2D49FD9994450A53A848A918ABA914A51CD8B90C5
      CE75127036BE797D7E5A2D437145C4CF3B6C21F48A4A0B6068CEAF3B8DDE70A0
      CAF2D10DFAD46A739A679D4DF5A25E7E65440E5316ECDDDED9B4EB4B776272EA
      CD4035A8F7431D2F41BFEB623B639D869307C8781B55325E3FDFBF52675479BE
      034AD5A932858066C4E24B8C129EEABBF3ED9225877121E4C4CE7B77D11A2249
      D6D5E02A9570274C903151CC73200B54E5903145FF79CF80E865D11F0EF1A046
      E7EABA5FC9F30A034701076517E5B2D975381E852F8C46A46009CC341AFDEDF8
      0B4F91D1B8562130361A35B3854D9754FE7BCDC431E1EC194232A351F3A2E5F0
      57BDC412F11100DDA05DB05358F2A1B3B87C316BE2084ACC85863281FAAD7971
      56C1C7FE41CC9CF768E7EA82B275B5595EA5109B092D14B06E97549F587BA3DA
      4618F7ECD7E2EF4F18072979774FFD1F22F4416A30D191E114C12ECFA496C581
      5533E474C209D543448E63091A836B4889A007E10B80831700BB5169AFB417F3
      1A19572F61702025EFA8769D28F786CDA1E72AF7BB4DC5D45198FA67835CA81A
      442130A3DE69E9BF6DD6FC7DF17E5B478D139B482A4DA4C287BC0EA22E4E9922
      E06B027BB70342B27B90AD232364A6E92E2C46AD3CCDEC426E3511ED8164E1CB
      1636C171879100E52F0A1B03441327A977D6897F230E1140D47B5483964A67E4
      09551B8C8D42653F15AB6516A06B3749E0DB2BED66CC4AB50CB849A5A8DF6B2E
      2E395ADFDA8DEAB217AB421B52EE9333853CB53551D5121BB741D7799237D41C
      A4FAAB37A5C1F52FE2797CD7383AF8898D6F625D291AD6A8C43139EE0087FD5A
      717161F0FAB55D39312060DB882C6F542B3393899FD8EA8620652B0AF79DCB86
      C22F3492A195DAAA7FF61A0707BCC23B49EC955E0F72566E511F573ED5EB798C
      8E0F941DA7967CB16F3DEF5B8700B61BB3307185549266A87A64AC2EB4FA520C
      261C40FF21904F17126180CFF2717D079EE7FB9C875E6B59F024321E87132F0D
      C6173C96D3FCC663797227034E37364E060E67E488DA22449E6CECF2833CF8D7
      5DF5270E5770D2719904A354F7A48C6C0CD6BAF63AD68B70E23EB8BFC3700589
      5664C10464C88B3219953F425D7F3D0EFA8DC713C91F726151A4EF646DD8BAA2
      6208A19A047BE576D1FEF7BD40415F49992E21932590EA3311AE3ECB89E46E77
      6500E26A15FFBDB30833F47DBAEDEAE5DFE968FDFD547F8DEEEF49D24408934E
      06BF3D12037C929C535DCB2E3613CF1171EC1651ACB7B546411A2A5629CFC70E
      B7F434BC03C127A520E0D41434E29593C1B0501B2B21CBEDE908BA8D1AE4849E
      CDA64EC33BDEDCA2B15EFDABAF57914B2496767CDF0D95CC1C947F6F82ADB502
      112CCAE1007BFA3B56E859292EEB5B179C19A565A48DEBCE47F3C97697E3D719
      08F5F04E36729593E78BA4A8826D6A1E323DAAAC3EDB51C09203C44FD25EDACC
      BC27B6B194DCB282D2DE4EA721F384581BA5CC40B0561ABD04A76BEE2446AA87
      1BDBE94996EB88A798669629E40C33D7E2EF58668AD50B271591FC524B1AAF59
      63BE9DB36EA3432DE550E6459340F3A3902C21348FFA9E02E14A473966FFF664
      AE02896C81591EAEC22088CC47767B51ED0D568E02F347E0DF1BA33E9DC369B3
      28594037A5E5D26848344ABC467E7956A974A6BAAD08C48AE134DB40E752A70F
      8A2271F711E4DAE1254A8CDA6F506491B8D1C38AE83815BA01375A36123E7F72
      ADC91CD9A16CC895D4B2ABA2498C8453F58363540E7EA08C32E3D4760048165A
      F207F18F71153FC5B141ED3982BD3DD8FF5C58D837D3F4871D79A1CC6269139D
      8408FF48EF01084C9C626211638203244C1BCD56BF4371D86531855D9CC141E7
      575E3221B6800440AD3E0EF3F314FF0BA13E55A9B62F4EFA0D2A2A148601AE2B
      F3473E0AB32AFA664776A50EA6F9EF658F24EA7555903EEEA5F37059FD05F9A3
      27269B9B34D09E8994F353B9F09C63F8949A445CC363F56FEAE8F57111EED983
      D18AF65D6B853C93D9EA81FCE4A8FC55BB41118012C1F3955E345E8FBFD6097A
      3A8B598853EFDA3C3355A9BF7BD6742441786836477484E298482CA815FE95CD
      CD9A144760BF477A3F95638BC811858F440C5E2273956F1781B1F77E12A364F0
      F2FA7E95F4CBEB01C2DAB6A0900B9F1009BCF81DB4EDEE777BFF18DB1D1AD594
      A68AD7D75DBED34F376DC22BFC048DE351F34B763BE697BD9244CD13CB82A2BA
      DD1F037815A87B0AB670BFC7304EB0008483BED8930D9A708D5F9D8F17B3AAFD
      8FEFA6A9530DC4FF5049B5831DF8A7A337C76F91117339FF7BC59BE941C172B8
      D0E8E16C5C9DE016D7EA534DE20DD29856BF03508A78DE458123B82553648CD8
      5C8F785C6A9913E04F6AA2A92B2470974CED44B1CE36915FF5B811C70EB3C3C4
      00C81B8DD46FC30B200F9CD7A353359C23F9A42ECCAD89761B83C0E418A3D93C
      836A2683DA59035A9D7D424377C7FEA051BC3799934A8AEDAADC1589699D99AC
      01582855B4321A138617D300E151C280E7396522151AE4D4070D2E6A4F23AC1D
      0F567A894AE7BF1759758A1A6092C54D2348B9F7426D92347CE1CE962EA3ACD1
      D31B3115BD943EE45C9F8F1E919925045D0D4EF00C75721CB6289B0D153F4B0D
      979F87F7B7E6C5C5974D4606D858B2F0251D43661DD3976B315AE0C20E9E6BE0
      CF4452047140252F8E093FCCDC21A160A46456E646DD86A80EB709991AB7A890
      6412020262EC34AB7EA7D9A06A86D1883B96171620DD9B32F6C29D1C419428DD
      D6368BB495E1324E0A21384EA246EB979D6607FF6F92E8742E411EF27A8911D3
      85A5D1DC3E51937918058989FDC6FA04B9C1CDB30275756B92886176B20E002A
      CF894610E58EDCFEC2D50FEE3020DF0B2194917B41DB9CD9191A02152D9918E5
      8303E1806C7E7119C720754AD5B6E4EC32DE87DB2102A785DF95AD4E899E358A
      4AA6FAF41EC7FDC16E33015324B8A1D39468C7A84522DA4C5975D6FFD45373C3
      71B5302E1833A9BE4233DE2BB3565A1BB3F58FD67880FE2364B4FBC4A8A38C4E
      D5E704F1934A5E904076B81B2650680E9BAADDAD8AF8E95645D152B16F84FD4C
      928A8FB9297CD85CF611182262DABAF7285C29C83984C3C01FE888298A2350D2
      B2926AA4DC9B9EC0E1665115DEE375FFE3ECA3A33FD83E929018D193CB75A51C
      16077798F48A4E8BE1D0851358E86479E7A94B0A8455A3D93BE7918938C46910
      066CB926C4276BC1E36780FF64157E5FD729751723830F55E7B4DF252DDDB9EA
      9F0B2A03FE360222149E057291C6DA61A8D268693787C7A3113578521206E562
      1A865D70BF464E80D0D2C7C89179EBC8070797D7A1048012F34AC1BEE2941C04
      92D882CF366A7334728AA96DB8B802257EE81A4C278B386C9E6150A705FB7695
      22CC9A2F50D3266298D3626E565FDF02205E4E7BC36A05E981FA4C076305A902
      1E9D95266829FA628769A4C7244DC1B90BE023C44F0854444425DF1A757F7C73
      0FBC65C3F11FEF3BBDFE2258950D57D6DF11F94245022841A4003BE3F84A9466
      BACB935B1757C3177A321CC7D10851CDBFA2848303B7D481078DB46828EAB1EE
      92175F63AEF81E7F9011E86072A13346BE610969DEDD1794E7C31DA4E7375B97
      3B3FFFC1CE1D2FB3E75F1FAAF90287E0ED176EBB5CD64BC35FE8EA14CDC750D3
      E2FB126FBEA8F3F685ABF4EF01E44DB5248B5C6211E66E12E5046FAF56B35304
      A264E7A48A65C79FB3CB542ECF1C8D526FD8BFFC1A7EFAFB1E2AA78DBAC0F53E
      F79FE9A10FC1BED56AEC1A68D291FE7831F41D0267A977F19FAE3CAE898D39C1
      C6905EDEC5E2788103CACAF6EAE42F1052ADF3D35F368348E73147441DFA1531
      8295F7F2D3601556D561EFBC55E35A718A0149568410D9BBE8F1CFFD8B36BD0F
      975675700FD0F201C9A912F5444E756C016B80462F2B1D24CBF96C26EA6CC148
      55B813B885336EE5BD1A2348807DFCFE0A83AFF7AAD9727DBE611AEF69831FDF
      AB73A637FF5F1C7CFBA074C81F78EF7A24C85FF6E9A325F3B89AE81861402AFE
      2DECEC850EE36F18DBF73249E294CBF3883B800A972580CA7F2D1E865611DA35
      CB104A5AC1C8301C82C215F80E6EDD37871647E16B83C79B9D22AA833FFAE8FF
      B4393D7381A66AB0F610F27DF41B9D3B2042B6699B373F73AB93C7FE4C3BAA8A
      2DFDF0D8671333514A6DEDE9A3DF3831DB3D501E1EFEDFA4D709D2A67BAF9827
      FCC0A48B57FBDF9CD0FB7FFBDA69A567D7D4FF38E4FF3B7D8667BD72CFDA6962
      D5177CFA334DBCBDD63ED193C5BF2E277374A8EA4EE57DDAAAC2A4038F4A4C74
      DD99AA533356C7EAF8F0F86D81943F3C383E387A77F8CE9324E84F476F0E317E
      29149BBDF3E792D965D1E699A9D0029F994C6A1C84CE82E2C2D4573131A98D00
      F2965E2A9405D128C1676D8A768EBE6A6D7B8204CC10E411C7AEC4AE4B21F0B2
      8D46A0D2D7A400A3202C135BB04230A1D1B3A9B91288D50C1C59FEF9D471676E
      01A28A69531F7492EDF4021248022B326275D4AA875F29F89A6BFFCD63F2FAE7
      9F704C8BB4CC68F46BFB534F82256414701F9AA383A33707EFDE788F82BE5A5F
      F77CFD67FFFA5BCEFB737BEF947DD80CF2CE75A07E282CE71F5422A112DA3E2A
      C914A5392133B70C285018E399B2B1E8135324924E8B1BCAC6E4EBA224EBEA64
      D051C59F77190E4C21929C588D1D1119BD32068A50F09A845FEFE9F2444794FC
      B88A83088F61C707A21ABD62C953CA8AC8B1A60A35EA35895E0E5C16B2216C15
      3B0E2B9C9344A5962F09028D661A7C2EFC61EA0EDAFBE68B3ABDB8A25C74EFF4
      1CB96857A8C3A495DC0860A1C25DDCF5AD3CAEACE463FD0F5CF75F5F35FAFA67
      84E7A41F0E31DF3587CDCBFB4D50FF0837C169BB3D2D7A8E6C43F9F7FEFBA23D
      1D60F795EF6C28C507BFFB41E9145D3FDC23CA673DE04160458516C959DC5358
      E1924A380028709ABBCC5718CF52158537A0B890F32E852EAC7325E1FE0DCBFB
      51F5B5ED277D50FA0682F1BD1A0EE82DF0C307A5C7B847F2E5F76A6C2DF1D5FE
      9B1A2639BE331E9032ABFEE5149D96F7B717E1415549AA0A4BB3442FEFA03A74
      4D1427C57D4463429F8246FE698AFF09ABF1E28B807D7A60E0C77621E58FE027
      E81D77A87699052559C7C6C4E88CC89065EC08D3E2BA4F3B0B4BDA785607E3CE
      27F2FC83DDEDFB9B7F997DFFFAA73762D2BCFDC2A42EC18BA70E2866536DB53C
      B881053111EE23AF679EB7AE2E379E790E522172502912AF213E801F26566FBF
      003CA84A2927361A81A2B68A87726706234BB0C9F16EF86ECCBB778FDB843BD8
      7D143C2B356BC1103274E4289B847EBB8CC494E16EA40D8A3E11DAA65CAA7BE8
      8B521EB67E49770AD692CE151A37C0BDA35BA09881BCF10E334B4EE1F26AD8A9
      70CBE6CBCA0DDA255139E8FD45D2BCAEEBF73799EF9FFCE0D1E8142C66856905
      6713F009476AB753681696FAC164329172931D883DCA50EF6874D9ECBEDB6A30
      8AD5D965213AA760BFD920CEAD04DB9D65BDCBCCF9F47F1E5C0C1A9F0717ED67
      7824387F462362FA296D7F0024CAFCCF4E81FBB3EA73CFE319DA92B034DBF1D1
      724DDCA35143B7FB43FF7A7555A1ED66C460D13264CC7407CF70659A5D226967
      87EA3E79538D343A7C1F4673165D5FCAF9ECB2E3FDABBF148363A77770B2F86D
      4E4FB113AEC206D71594228820EDF054142AB9BE576561E0AD998793679102C2
      FEDF26092EC0510220035048A0D9C748BB9E34C4B0D327D235AA36725813D5D5
      6BA5292EF00D8CC6D312C528E32A2850B943F070BDB4BB843040AA880D25A460
      1606EBFAD768CA9F36C5F3EED9A0D16D0E91C32BED8E420FEDF468CE0C922276
      A26047C9C5B56CBDC48A76E03A36D4E3E5A82D9B129B85E40481FF8E8DCDD368
      4DE5B574F2076866A8FE4C7824A971232A82DDCDFA7FFCEBCCFA77AF0B169F8A
      E928519B5D4D470839D26D0FF90AC806A58EBFB4462E83BB3E68E4B3DB1DA239
      5C9D22C0DBBA18FC7534BA3E1F2076E3442E4C45268C156CD76804A497A3EBDE
      6C87280A8270AF800A5BED0BBC2FB43DA6D50609F4439ADEEB0C85FFA23324A5
      01A4C6EEF225C9DA71626F0C274AD1BA9CBC2B61E7C3AC8BD681DE87F66B18B6
      871ADD7EA7E4410FEFD1A8C372B7E8299A4791EAC4F9E2D96289D42A7CC31BE0
      C02CE5C99F164CF48B6076D1C61557A173872806E1F7C3BB5D5DB77B175CD5C5
      C0FABE0BEE75F4E7FFA2A3EF9AF13834B964916CA2162608F3C54E8DA7A54FA2
      22024E073900FFE31409BF6978E797446211F4FCB70774A6A3D145ABD3FA46B0
      FAA90F8481786632E0627A915E737F3C71BF38090BFEE761BB59D2EB7A2A0B04
      589BD7DD1E40CB70610AF82246685E77598FB91228E67470A84DE734E073201A
      4E3314DAD929B37334AFBB7E9B44F90DD7E9036DE586A3D1E733EA7D348064F2
      EF4A2F718EE73F00A5DFC139E6D6C9D9E57BD5D289BED531434576F01DF8E968
      96C4B9F76EFF33961F12F29FD4EA2545C51C8C7110ADF81531908D7D9EF6047B
      D6359131CD2CD3931B9AF70334CE073BBCCB99C92E743CCBF5CCD4D4797A69EE
      B256142E2F740AFC65568379129FC757C9559E5D4D7B76659266B2B0C9479D0A
      F00E5FC3D530C9797C62D2EC240FA3A0A517CB1AB56649CFE3CEDD12B5952128
      D2CF53D98BE6AD0E2304CDD8093D4F3F219EDE8CB2569EDC9AA1D4FBDD63ACDE
      E155EFBF1D1130ADB91D89DF225E1C019AE73A311DD5D4C571F517C73575F1BA
      FA8BD77E6C853600230FB16CA36CB3E0CF8C4C3CCBE6B480E15485D04BCCC145
      FFD4D29E6097F3710EFEADBE4E88C0C3B1FD63E81BDEFD7497870B5B2C6480D2
      385552FC99AD777E289E5953CDC5C2A26376BE20B95DA36AC2B9D1DCADD3FDD0
      D799F9B494D2D6CAEFDA285E5B19BDB4B19B982F5B174F8DDB41419CF7BB575E
      CFE9F44E8F5D664EAB09AE8ACAE8AE840C33445001078E7AC2ED3055273159AC
      E1A9DE68911FDFBD809C1F2C73E630B91E767E13EE7081CE54E893038B527867
      1885BEF5C264AC5C4B6C8808B024DCB203E69B5BA28F9DAD4DAA141ABB79D1FA
      381AB53B83A15ADA9416EA608761D028473209540754F65CA5A4E25686C31B63
      5CF1B683E70AC1D0237B79268E6F83B00E6010A0F35E70EA5139B610DAD0042A
      BD9B26D4980353DAC983776CD4F2D48A6559E97BE250C1E95C233754F9500AE8
      D8C24D190E08ADBD7C77274454F3B2BD1130719D352472D2E89BA9460FBC1ACF
      60D319622799A30ABCAE44D4E47BCFDF021546F253E7113B0C890C4F362A782A
      829C7265F0D39D4761DD2EC9C215AADEB3965B422B15F03CF73CF37A9A78DE0D
      6E221C28447158512092E3994FDE74B6ABF78590AA880E13DF584D753FB68735
      0A20D564680A206D3BE6FE02829D7272D1D933A706309F211F1C9EEE87C14D18
      FF507A199CDEDC29A84C2554D476ADF5B1CF50CDEB300D71AD8988C1759D4639
      FC4EE3148FFF0D74F7DF8ADC3E419501B6C9163A117D85318129BB3640185185
      71B87B1861F6AF8BC212A10D6BBBB3DED559E3AC77755A69046B1322914099EB
      DAD121780F45D05482E8558819492664D6C5383BCB7052907901B1CD144FB468
      D766A61DC458BA3A4AEC1CE4C45F656B79C2CCB0C7D426BA989123FE80903745
      DF06915744215C915A1B19986F8790BF3DA1D7809433C0BA80BB06EA64EDD829
      60FDA0BA65354702FB9F7938B901E48AF826B16FAEE4D77BFCA362AB5C3749C4
      3BC80E2238CCDCAEAEA653757B74F0932F6EFEF5EB9788A54A57C7FEF094AE1B
      DFB6C04E04896EEEB252AC4D24A59EA1278402515DB8A043E78830E0C25A4F5F
      8A80732A25AA123511220B0429088B6CC7A981218F7CD83231D3F0AE91E653B0
      01E92068485F1CB4A634A967C4BF97D85B3434AF02EF281B4914FA784B87E813
      4B7A478DF2C55D19213C2E1AF2FED00C021BABF33830773F143C0C2E8C35368A
      B847F4621CCE7218743A553F0840A96517E330E68EC7FCFD1DAD6F8794669FA9
      74F06054CA9D2DD8B21076CB09CE4B97CEC6C490B4833781DD4502E2BCAD226B
      6FF2A578F59037DE77E8251CAD472EFE5FCE7BEAE2525D5E0F3AD20544DDBE3D
      3AF06C95502883AD519AF19C46B83D3A787D70F4ECEF60E771BC3ECBC34C27EA
      F6EDC1E1BB1D4638331905C79AFD6604F93299C7E18400B08CD504840CB119B3
      90F2BE1A11DD5B340442A93D1CB018C87E2A88EE77AF76F1571DF488735DA768
      C2D2709C15442CE6ADBBDF42211488EEF72455DD0D6FA6406595486C5018CE88
      6185FF9E828EEA1E12CACB509A3EDD507286C31B7579E645CFA393C91C65EB9B
      EC5B9A69F5CC5D96801383A20FB7EFE877B73FA993E63167F7FF650C3CAF0FDF
      BC8444189C7EA16C80AA5380513AECBA7EBB95EC833494AB29FF71AEBA57C07E
      425CD232131C42C548844EE61ACB0EFDC5E03A6E0567E29C3B06EC80AF29F5D8
      A077D676FDF1E43DF523AFEABD51AE52EBED759FAF2EFF5B9DE8C90D0E21887D
      0617C23A26BCE10C8424DB041C6138B2949443C109D1C1799B7C87EF366F38BB
      3C0B8DFE418F47E29FF0EC9F0B73F2B2D752E831973C9EFFFDF6338F0A547863
      30E8B016B91AA7999E389AF0CCAAF6D555BF46C99B9A1AF63B1DEFC18ABDE202
      A022E44194D7E525F37EFE4F95E7E30C5E5F119326EC6CF13688288032F5B371
      814EAE10D7793BB847BC3934EC7D0CB7301E4E608E110319FFDEDFD59262DDD7
      5F5093C5DE8A9CEEEDF5F3D210C1BFCE953E24A70912CC71AC742F287983A2B7
      249C64EA1358388688B4147C7F9949D06634520B13E7FE4D7731FCF1D6F00E7B
      78FA5BAF5DE03BE240753F0D868DEE60785AE69BBDC744FC8FE39252CB9719BD
      50D7ED53A4B45DC92D62262438D1B8830E17F77DC40445E19A60A7E2B5E39FDF
      6C4AAFBE917E158ECF2342E3D425C8BA02B1F477166BC75C6BFB8897FCA9A7FE
      A7F395BD07797D4FCEB9D0C94698A64D5C77B951D7A1593DF90E94FBD5E3FD7A
      CC4472785C26ACA5769ED8E0B991C744E118BD0EA46CC2759D7CDAC6AB20140D
      4726153DB0C241F6D8B4C896467173A593E6324F2673BA63D93CB1F94CDEF400
      A86EF0BB26D92497B229FE02236824B1CFAF43E20E2539320FA185D551646ED1
      8FE4B1392D2CEA5C271C619814AC9D2CA8280230D521BAB0A808696264F66838
      4AE912693367B7342892DC12D650891E520DA2F8DA2E09C608AE5998665BC549
      F7B81EA8FBD033209F264F97B33062CADD8667423415EABAFFD854292ACC9E38
      DB4518BBE6729EB2221CAB96A7D14072467F50835F061DB56417354CE5BC020D
      C62FA141664C0A0E6D0A2A53FC9759EEC7EFB66EBAC81481633178AE923968B8
      EBEF3D1E55AB5C5EBF7F587AC566853C3039E2BC8EFE6FF6F3836F76359DA2B6
      AA8D117D1FFDD3E1838F76E00B75D1EAF41ACD56A7E73FC27175841AD97F6E14
      1D07E9442F8DFFC35F6FEAAD0A23F1A6E9ED3F02F983613A315124AE94745986
      E5B5DB89FD4992075FC8CE207AB112C2666361ADDC64B7F8F9E0ED91FFCBFC28
      2F23B52C9FD805939C5DFA810A15C875D985458E28CEC88570CFFF59D5FF5D7D
      D4A91A4CF268C947768701C86BE066916E84B7B572108656151ABDA67A1A4988
      26D2AA6959083631B1491D9DDCE9598FD8F7D47FA89E9EDCD4CF637F37989CE0
      56EB4AFD4658E47F572D6B93008158F107301B6928D6FAE555AA6EC3147DC222
      BD46C485EE4A4DB927D17651411C494BEFAD87B4FA5BF58EFFD6BA6851AD6CE7
      E2C2DBBADA121F5C6B278901CF4BB7C77DB1D8BE0FC214B7615FD555EAF02B88
      0CA65835CB5651BABB3A1E7F873A768103A11BEB131968A996892A4347D487FB
      9E4BF67583F0E1C7EE1D1E1ED5DF9D9EA2A01DCD3EB957595154FDD08005CF38
      8544B513228EAF092D810FDE1D7D834C0D66A34D6E5265EE34599538AB8EE3EF
      E1A96EF4052E82873489AD291C1D1C6E5B09C76FB697FBF8275EEE737400436A
      FBB10933B17DA501FC26A152A5ABF391334391B44A0D15098FCDE62764016BCA
      02C2B20AA92313CC4F323CC74662C1125248D6457053328D303381F74E903F42
      F87A83B553BB65A3C94E355A7913A6034B5C2CEDD6F67FBF55E57BA3DF6CD91A
      0B70A60023BE81BAE0D40FBC0D9B2CDCE2E9954E7CDDEFE3B7D0B37DBAF9DC59
      583AF3A9CB4F1717E8F6C8DCE4452746470D840C422B0917E6CC46C17568C1D7
      D0A8FE6EE3874B1B436CF8F686FBD3D1F18F907844697A255BCC7124F18D9154
      A6667EB017606DFF86D3F09F05300D6FE0EE543DFE7FDF1CFEFCA33773DAF18F
      50E783410737FFC7372CC9EE49C76795C1C475EB8608AB493FE24E032E0EFE42
      EC30F7748CB9EDAF5C1A1BABD7C7E3307BD6694D6C3C8D10214A339DE5291619
      61DFE29482C73D23D7AF20B42CF2B6CF3A1132E67A17A8E0EEEB20E4A914CB41
      45A78C8A225A562E0DA984C41F81A07A4EE80A2688BB32003B7C64598CB608D1
      4AAFD382708BF0CFDC849C30DE7ED39852A9E5182F7A6B222C7FB12C65BD9934
      3ADC42063229D7843A4133513B5BD71B8567EAE8E0A7839F5E7BDE99AF4C6FB8
      1AC3E189A473ED4782D224EE1465D483A99EEAA979CE41A90D55056CA21684EC
      C688B23395E639F70E38EF68AC6FC3193B6A59620C12EDCF39C51FB69BBDFF80
      D3A5550C840FB7498059E25AD77024891B25F3ACE50F3559C7A24C2ECC52134D
      9FACD39E233C7044D146D702167C2406A447AC70D5E9311D3ECABC3AE40A011D
      046FE1AF4E0B178F9C520A697F8B3DE4094F65C055D1140E80F6C759639EAAF8
      8B5AEB2F6AA5135A0B3D8629E7FA8312F132D133798FF4B658930A8F0095E6EF
      1A9279FB7321838D45FE96D1ECD44A13A92062D2149D30490C6E17171834A310
      5D1B9E5F17B0B5DEEBB707189C981E2A12EFC937E0495670335EABCEA0CB1D72
      D1D815DDA9C349480C9CE68EFFBDEF6895F9FE16FD5C9CC14A3CAF99F4DD2D4D
      5744A471D72BF900F246528DF8E9782DCED402E0B131F114D21F08AACCA60087
      1DDD4FA4975649986526C6D70BDE7031265D038DA21F29EC68E7D94C040E3C5E
      AB5F9BAD0375AAC3487A4707008EAB85D15027D23C9543C3068DCAC4860F67B1
      6B8F5D18EAF4E9B0D4871475C1349F6E7BF7B8770A19F8CEB97B6CC3B6CB5085
      5BAA78465A7A7DD84A924426F0EBC3EA386FA8BE89EC8F8DD9C284E555E11E26
      5BFA06E15F4AB43D525CF18D0980A17B6348D78BBA621C315B204F4FCB94F973
      D03B5154BC056DD6378B54BC66045396141938C40D35FF29FC37EE2845C70454
      85C08CEA6979EEFCA63130599108BA3F1D3AAF0268C40A942D3AD01A026C76B8
      7836396FFB8D5E98218F0E5FB693AF8C5F5077CDC3D91C52F45610E9EC7CFB6F
      4A9DA0BB5D7D63DC84963AD10B9CC19AC8AD226995C2AC5FDBBCD22F193F15ED
      926BFC0A84FB80B460F86A72A3CE8700EC578E93D4886D5E40E984E91227A8E8
      83461997B9A3B101E29116A7A85279A895DF63418ECFAC6A1F8FC920003335D9
      9AB03324A236A71A42FB4C2906C17DBACC5D56588AAEDCA7220AC937E1CE7C79
      0C9F002AC2267CC509BEC3D5392EF5BD2531D85C2D9D3E91AFE35C18E6F2D8DC
      A1D5222DD15C43BA6F1D09AF489DFE7E8082A7357178FCAEC84F0F3B8356142E
      6030742D5C9586EA213FAA2EB89C947D13722AB5D4D461D541255F75FFBC6D33
      041D5A4E2613A085A30EB0AB13334D4C3A6772BDA2771BCDA54E447BDED896E3
      37C8DD9C9D9C76ABADBC906EAA031F4D65A76A3037C63B9AF2E6B53394407134
      1A7DBE6EF64723660940A6226E74356332FF5067A1322FC135A22A812CF8A2E7
      ABF7A3DFB8470BAF6FC0AD85EEF9C3BBDF95A75F9587895DB6ED4B4AA66BB5B0
      319503E84899E99418DEA764472970F9CF6D9E10647561D45EA5FBFB7E4DE908
      91318A82E276489B4E48CC7BCDE681B3370924160561CB4FD824AD5193C62266
      0BB95F98895553AA7829E8806C4E4E1D3977D41A770BB0BF2D6E2D4C9F2493E5
      DC0841149D246B94C9C1ABD4D3E951A9A4606F732D98BC27990883D3233CEBC0
      DC99EF087F8B89B8DDBA75FB01F776F6580E47DF44219AFFC08E61C4797A90DD
      3D6A96CA446B55966C5AC01070ECE532B15A7A434BF945A5E38FA8DBD4E6E8D0
      CA36BF18B945D759D040732F6467D097A4C8E50C09087CF0E4F73C87F14ACEE9
      D0A419425D47D480A0F8E9507518BDF1D8AB7FFDCB5800D1A5C54968E5696617
      07611CBAE6079C1F08C23431339D40728CD76E3D593C3B4B9A3A0A9029E31621
      B36EAD6057D26A3DFD9CC03C385F2C709FD8422826F92AE512B47B39D7ED5D2F
      CEB7C4BDA810284269E5070E0E2E101FB93507EA2CBC854B827EE0E1EFA6C6C6
      1856E6C737F5313A8297B926BE3E30ADA440ADF0C7EEB7B87D6C7B4F1198AC0F
      51603430D916C1D9D69B5CC59B070FF71832832A5628726DA76A0CCE0D0EBFB9
      B44D5809A8D056E2FCE7B8EB66010E07D9FE37D8A9B7EAEC4410C3826EC2ACF8
      6B195A00923C3C3A548B30CE91F7E5A25D2A353E50CD08ACDEB3B903D3C0384D
      214CA4237B6257A869A0EA3492756EE22102E833B66BD90F4933A41B806C0E6E
      43211E874580F236BA56709CA1AA3955AAF23803708A628A52F9ECCAB5DC2014
      D3B32C5183A76FD1201FA708AB21B78E25CF978F5E354415D3F22B91CEE3C91C
      0284E6A62730681EDE1BC9E051FFDF30E6730AE20EAACAB653951AB0A0A44FBF
      3CBF1084A0C306EC8933604F230DCA5C6E560A8844488189C78D7406CB25E1CC
      92F2CA0C77B4221EE449926761BC567B0E538770D76219729E66DFB5BD726575
      1553BDA63459F062FD173676C0739BCC6D08905C497A1E06E81A4BDDAFC8B789
      0DC2C4B7F058A5CE521A6CD1C64FF4920BD9A9948B6781D10FD439EEFD24C929
      C19C59C8058994E033D432646CE05989CC3077739DA718E983E44C61A58AAFBC
      C051CC630A91DD1A8A34A42970D85C8D79BF0FD763F28073A8A75C5FE0FAD374
      F57289FF6DDDEBC7B6B94FA863C3F638B628943DB850987BB4942ED0CB467A72
      C30177831B82C098B83BAEFC76A1A9347D51A8B230219D502FA9F484464F32BD
      B3C88E7554A3535C672A0B4DB597455E3D952AFF8DC04861E061FB0B59CAF1F4
      83B24D07E1FBE2CD3381984E98A03E5D7A8DA3FA57AA21C411F60B2D7501FAC0
      01419921F7BA2527616032B577DE6B0FF6DDF3FDE2236487115C07601AFEC71E
      8069FB6497F1CFC829ED368E9033A9BD5F2E9B5D7E346545DCEFDDE1DAFB6530
      E8EE365433F887A6928041AC97EA92FAD2EF5D16C3E29745FD27FEAAF606C3CB
      F68ECB282D9FB9E931113CD060F26BD7047A0F7D8F9F672479A47448E53C5EB5
      EFF4DEE074D87F78A8C7AEBEE0B352B5D7FBE5FC725F3563BBD0D1370C3B49D6
      73D464E3FBA3FCA7E3A3E3FF00F7990034D033028778BCCE4C7D6A933AFE4135
      C8F2590E7AD00BE5F1FF47DCDB36B78D24D9C27F059773EF636A9AA4E597B6BB
      1D337D43D68BAD6DC9F258B26776BB1D1B20094A1883001B002D6B36767FFB8D
      7332B3AA00522445A9FBD90F3B6E8A4415EA35F3E4C9933308688F245AA440C7
      02CE71FBCB50C2351D51735A70952EFCED9D681FCAF5ABDFE97822BEB9A1580A
      658F29E019BDCEE6C9AC4C5114369D557D67DE119390CC9759AA506BEE6170A5
      8F875F263B25264751630738F83194C322F41DE5C9F9784DD3959173E4AA0FCB
      4C8AD58537B763729C545FEA623688F68B99106DAE92CAE288EA38AC6CAE4A92
      69159650A33DC58BE70EB74D195F52E805036B570FED1125F580000DBCF4720D
      8A0718851208DAA1D0710AC2DD7238E3F9B88E798FB8CA5C7639F8835D93E115
      FF61A0C48A9894898B0681B8757EA2D66A0C8C48AD29843C514E260704CF305F
      314D2BB2A9B45627AEAFAA2EE723C64EE1BE0151A51D41B62DFD970132359459
      C5F140C3163FC06FB457FA9E840C53FAF692BA40B1B1713203FF0995EE1C8B8D
      3ED588000CFC2A1133D29D38CF25FB3DCB8274FCAF8964A0CA2D5C94E9253384
      4852AF1792AF161DFF248B87C041E93353212C29A7512768BDF30AC5E0D59BA1
      EB27264CE586894EDCD7384BC7803DF496B5FBBA17EDFF2C9238026ED4459169
      154298B4EAACC455558C5299A461525F63AA950B003B85E6B10FCEC9CB9609D6
      49C3B796B1236B399E12F788F6A4882D0EB15E8B8F56C0D87666F79829130E02
      966FE0A4C09DE4B93439E0893D118AF5B02F6CCDD92C892965042B516872A7C5
      F8B5CB0849278033B16A66057006717E330C435DD8A1C492B0A5EB954038755A
      C2A6F488B73B0527CEB369FC9D46DECAA93F26B952685A5C3E290E18DDF90A3A
      E11054AB1B46A1C42261BA7D8D7308596AE1A0316605845EF148A443DF708010
      36C96F74CEE551721E1874E51DF1A000AE3F67FAB6A175C1733AD56837010E04
      56E923E605E322B936E7D2B3ED55E490C1E99AAB2396DDF057D22627FC9AF303
      F53CDBF14378FB88DCC94EE665224E4BC613729496A3B97835BDA8C00460CE5E
      2738BBC731AF1BF6639E6344B8EE0119A8AF9B6659DF9C597F4E6D7E58EFC7C4
      11A3BD4BECC83AA24AE60A640733A2F0DA8978C2AB16C9C73ACDD27FD96EBEFD
      A99A2A14ADC38CCC169FCDCB59219A3DE68F37A63FAD186613676054CCCB1842
      68D101B00084BC01B128A521C6C414753A8A92FC6B5A1639154324783962F3CD
      47D3452B62A05529EE8F307423AB6294F4C06044740F135C27659630BE2FE53E
      279354D48498BA2F7B1BFDB17DDC705EC5E7EB29644B2B622EB4A72C9DA65205
      A7276E0D2D017C9749352A28C245E5CF4E7A3AA2C20600639825D345CFFF765B
      32C01B91DAF65E2090B6ACFB62286EB9938EC4B961962218D38BC645E26888C4
      551AE026A4481BF35CC1DB0EA619E719003DCDAB33A4B91376F9904876D9C123
      1AF03A407A9C10790C8661182D5FEC863F6FBAC9E072D08B4ECF9EEEF4AC4DE9
      5C5F126EA7C5D8AD68020477B373E30C29E649F955B1286116859807EF678AEB
      2834E162FCBE511DEE952739073281800FB8840283C5D9CDBF9CD14ADB12ABCA
      D935EEC5109449258D28DC242896880719688347C92A250480215E8AA75C63DB
      91D52778FAD80C2F6D4E1977DCA301F662000324EF80BB5C07FB2ACE2A2AFFA4
      F92429290068F839B4031D3E23B513C546CC8BE8B779CC5D1257D5BC6448C0D0
      A960BC2D614ABE2AE6B59EDB5CDF1647B6090BA3BE6C57AF7C7D390D43FB9035
      5790DC28A1012B867075555C5775319BC9B596DF44C937F534960E6D685EE03C
      E1740354A9EA640A45333F30D2CF4755942597F10876EE386116B903524A57A2
      0CA9B0A88127E7A17003F43D88F4A4821335872A880F1068417CBD98B89853D3
      2991B168D8D70166BEFFF3D3F5E919EE7401D7493AE92ED86BB2DEC0A0255941
      62FCD003C1FD6AC74C054AD10DD437B1E7B8FCFC7E947D18570A32974A4DBDDE
      1C533DC161AEFBBC7BECD94B3401D31AB45539D014312A26D1B1072DDB58AC82
      B08064AB9D35E6BB9262619710BFA12D4DB803F3D16229C07DE8D75771DE4FC7
      0973C2D9D0D8D0DE9E8BDE08BB3E9DE296AE5AF059E65FF6D51D2273138D88F5
      E1FD8F1534ABCB249EAEF4FB1B2428432DED30C38F210098420D92DC256B455D
      A61807DC6519CB0611C5A5DFE64934CFCB0480136728CDFB3C843433CD3FA4D2
      A78CE21C8B6F18C2088E42A847951F156EC8EA9663AA4A9A9D87397283624FDC
      D69366ADA60BB06CE06734D1DA86A9AA3B993E994076748CB5A3B447BC5B2087
      FCE617D9C71C0FF5C94F8240AFA3658698B2631A72F7CAC36851370F7EC743B3
      3705EF3AEF53C747CAE90A6BC70103BE9AC276302ECC1ABDF2B44939A4E00589
      3BC2802030FF054407B140C91DB80FF70B6AFD32572D004AF75BD080B8C88D61
      750326F1B7DC545EC4C76115C42ADADDFDC6FF038F0C17249E229F78AFB7F2AE
      ADB8AD9AE0D5E8D41D6CCC26DEB86AA91C48710CF1E597438B323E1EEAEB2DE0
      A1E608AFDCA2A270169C6C9BBF8F25DB39E0AB282353495BAC5C774BA69E1032
      04FF31C028780E7C5CC65483B71046F103F5DBCAFCBE8D497EBCEB6B1C13CF92
      CD021BCB815BF4E9944E58D2015CF392ED0B867857AE3FC22B47A03311180211
      D1357B07D31B878ABDEF29F6F06BF174D77B39FA869EBA31664E75342CBE8513
      C13ECFCAE22A45F45F61DB90EE71378898A77C157AA770C9080EF1B74632579F
      154627CBE22DC83A6F3C2A71E52BD4DA67708D40A9D265B3566B03AC53E7807B
      ACDCCFAFF050E7758130B66A1C8EC7DBC3E71CA6A8436D6CEB75C7CB08CA4222
      3F90E461B9695D6E6BCC33F5462301E29720856198C1782ACA9BCD87F2CCFC7F
      1953DD667B4CB389C7FDB3BC457C6C8DDEEB4432477D5CD9010AC6B4C203D5F0
      00AB2ABB698E5A2F3ACBC6A77159C97F00CCAA21D740DC881FAD1B56B38D542E
      BF8F7B6410FD7B31F7C308008CD2A77001BEB05BAE0ABB4575FD00DF8DB9B30F
      4744B2C047D91C241BBCA2B8BE389E38F300965654615BB27D0946A89087F878
      CEC9E51335C410B24892DCB02520C333A805A624720141107C9F8632BE2AA953
      D4A9AF6A1FCE706E8808AD476F8B6BC07B72635FE3F299F13803BA504CD09399
      278221759A92D4755AE38312000876A8A7AB54D729A430C09E64EF28638D0316
      F0D91271F725BC939019486707982D3CF4B9D8C2FFC42642AC43CB55E373FA25
      CA7784A981CB495DA57C1C1B3A4E469C614032E23A6C431B7403C90018F83C95
      F094E8395490802E2B5B2ACBCA23B880C750960599116097C84526036A00DF1D
      CEC30B935E8DFE0D040EB7B237B7259F0CA4BE8FA25AE78A1CB2778EBBCCCADC
      C4675F71898616AF902BE03218F48CD13C3C3FF590B72E13527F86C904845C18
      C5C87A72281A4F638EBC6C676AA1D37098529351567D1575F12B744E9FB0434A
      951CE155545F17405AEB3407E35ACAF8E03AB754011C0974DEE14665491B42A7
      D95C61DD632BD3131223D6B04AD1B5439572976C832F083188EF1792429883B8
      B951FD54A602834D1E66E08CBF22B3C092BB9CC50B8A0ED3DA7B2C01D08B927A
      34E87104E196B1B4BBF94C02F2B7462F4031E56FEEA669466C1B6033CE0EE1D6
      493E87693492EC523AAEA9F8DBD3A81B802CF337653A1606DE4E106480790483
      813708FC3B3D654A1D0AE91FD9C47155F7DABD9791A739C15E878970DE3B701B
      5FA8CF0A1AC2A7EE455F92842E273B8C3527EFA7336BF80A96FDA32A2AC1C603
      CFAABD15381C6258228561DC8308605A2781FCB8E7C609B3B28A62AB0F662233
      3D889AC525FEE84244D50D7C71B847C23E5580679E937F0517ACBCB109F24DF0
      16E450A2737C52E51AEE4557C2D1E3A3D2A9900D6972E81E6E48922C1FD33269
      AD1A1FB1579618D103ED6884815C36089BEF9167B247F68DE33CBA51A4693867
      18FF55F4CEAF0DE9A0E6659BDD5945002A85206D79493E891B9D473584A4A4F7
      4EC4693CE72255DC75206E04689F11909732829B3A859E02D9A23903D9DEEA67
      11EFF3D35E34071932A948F493B10122924C931274D4B712AFF13077003013EC
      54D477860416B9720595BD7572F406A31E9F1910189820BCB4F2CA151D7ACFDE
      900A37C06263C0580064B2E292978FF04E01BDBDB29553F52246B525362CD7FC
      AD7DED05D7AD3BFAE3AA792972BBB9CBD8F2100AE430558C042CCD1CAD123DC2
      2DC7B6A7A102BC9870775D6A4380B1EBA3D25283D6E1E1CEECC7E92CAE9936C7
      6295928436291372359511780712AE98118F2AD838F9687594248F324989955E
      57DE1390BBA2F7FFBB5512A875BE2B564B4682D460EA48C3244F26C2A3488394
      05118C4FEB2889AB94BC0B23CADE34F8071A47849BE6D9F9C4171942D5FB5044
      3A7589CD4A60334A5AD283582E7A505FD0815909D14B09C4D3FD128D4B3B4B79
      C22A5196D10C318C3540BF71228FD5723A301D87E8540A58ACF45F93475F4D99
      58F0F2859F0FA2F7525386E01A8E232908E2382B9B771102ABD1FB54CE711EB9
      657CF9287F745016330F11BFF3D21617CBA42D16D732576631EB67094925652E
      F7243E6693CCD5E71FF553C994DBA1164A34E3195DD7C87D7C6F42075C3EF229
      844655D6C29E16307BE0FC8300C00A32CE8C23473A99D47D5C4ECBDE885B0F57
      19C7DE6242F2FC264C2DE6D3CA5316DE2A8E8F9A6926652C833BC6A82E64EC2E
      EB4BA185C5EC381270B51F60C1268681A0BBA4CCFBC118D0B152A627A46C0497
      EF092E62414BF6C6A1AB6CD1876784C54C497A31E55893560B9EB8A3158F0064
      2ECF78541908AC283441DF8128F8F71B20142BCA4014C28D063210527CACC28E
      CD418301EF655795608374189A397823F47AF3756FA2682F5F6CA20D106AC305
      BFF482009A9F8193070989A2C585992101CC82D38CACF062E1B19C5F46E324AB
      63919394B4145462F812B20FFD0F05A5C5D1A9B2E58AEE8474004B43F56335BC
      097A7CC72CBBE05597A5D94D8A972FD6E5D9418AFD9644BBD610AB701EC27FD8
      DA457438FA5225652CC96D58F8693EE78DD0D89F411F5BEA4530FE2316D073CB
      552D7D5CAC2CD0A6E3BCF9B2B9383C7FF62A3A2DCA1247CDD82D8C2E761EC1B5
      68DF82E2372BA30B4166A82425C37AAA5B4993682EEABAE67634773224693403
      DF9EB5C3423F8D9577E73C4755605AB366547F4C4253A2E8D3D30422BF92FC88
      B98514C4DDFB75523DE3C6E8F3F0736B0AC4035C0B90BA000CD76BADB0D15CE2
      3175C1A1C224DC2DA3736FC4B40E5D4F7A781DE8413F5A0D34BB77A254179079
      C7CA1DA75F61FE572D3EAF3BF1598E051ACE3470C132A3C7D104EB7A18873A05
      798F123960838A0890401795C81BBAD3DD85944774BAF5A8B61C9547C66F1C60
      D286653ABE548ADF653C3321699686E32AEC7C4DCB7A1E671D17D3B51453AE49
      3DB57B92BE2B750F80CEB141B0040DF67610813470BB93B262923E4957A237A8
      192F1D39149BF140527156520473A22932C03AAEE80F5FC3487F005EC1E10041
      C3E0A57FF9BB89D8082BD6C35D292C575CC90DB2D99D167749BC4E6C57C3AFFC
      68CA5360ACA8B815A109B7AB8BF232CE75DF458EF707E4A2182321C4AD104164
      371F43CAA8311BEBF0E4C49116B0E55C4DBED531B69C2306A6E038FD9A8E9588
      604E69772964B523F1A2E930A123A0AB21963EC8E032AFB9A6DFA8E68783B9D3
      3C9C35457FE980B7A00AAD8E009B23EC9CCD1D29982952C531F6666FA20F9CCC
      493CC204C21D104D81BA8C811B4C8AF21A48B29EA336BF5A2C89C66715BC5CD8
      A77C2C0A948A9469CA865F0461778437603DEAC9053F4E90DBA7CA3B0EF8A4D0
      E552DB73959880492428F4CB022B342925D349B7272DC78B78B8F182B227A9DB
      70F86D164B31513E76A583E30F056FBCF3B52965A78C3F8932F8DEF25841BAD2
      C0DBD6C5E5A5D0FE2B583DF88DBF537EF9EE332C925FFA9FA3EA663A04E15AAA
      13B8C208A1F7C19671B32C5C385F929B618175E00B2D7C8707F71BE43FE48715
      480934AF9CF2BC4A231688C3B129F9AAAED28DCA81C5A496B21BA2868985C518
      20D6EF2C29AD24F430AEC40D22CC24EA5E89A6B39B0221E6E43A0EEE1B331696
      2F9EDB27F9F53CFB129DF97C659E53FB7599210F6F5D5C67881FFB64E75E7455
      64E3684C023C963B1EF32501D0CC303D26533D8D626C89DCEE1E6102B80C991F
      31DE4732F106A8D238B899B994942A99CC2524E54A9F897F63EE930029C9B718
      012D4B85E05481E8A2A0160CFA604ED0B4C90BA8A8CBC20420632228BADD0CBD
      498A3ABFC77F5600BC7C5651F8FC0CC0C47C46F218CD735BE00A726F3E99075A
      2B5D25AEE440F808BC5368F01B987BFB8A9F5AD64B197AA14DE71E4220569D9D
      C79F5FF192F7C3A68542CBE8ADA631D86F1CC5666812B7F6E26752B937342E96
      8000C2ADB7ABD4ED22ED6F9F3533B997361FC04335A9DC91BA2E7529BF22EA38
      AF9C8DC0AC6BC9706626CAC23062D8D48AF6EA36827769DEB1CB000FB3F003F5
      2FA61CBAE7B9288E1D2D6E1AE4540A4418C47D72B8B06F3DD439A09814D6CC24
      49C643F8AA9E240F6FDF453C0CCBE38EF3C0A17BF7E0E568504987379F0C3161
      FA27C0C6369B915646911BFC7EC667B80E69AD791723C3116F5302CA168D77B2
      E1F5074691A1F27468B207A78F3D0D794A72CA99F830FD191E66741C82DCF226
      62D592970D0C870E8A777730B3F3E91D74CE3E099DF4381F23BC8C10003ABA0F
      3DAB35FC1A46E1E5F559890A5710169B14778B6B110722B1C548AB15CF57A7AA
      C02FF2A2C35B78DB9067B83E98AB683A4DC6846A9D7DB5B9E9735A8C13BC9FDF
      262CADB19053B4628C3E92F0005201150DCE0E2EA0ACB134497A91F1C1AF7B89
      BE464E88DC0D817E1FAA71BB44262C09E9B5447D792A2C706FB949DD033CF464
      1C55F80C59DF88C4E171A1466C98AC30C853496E65D0DED229656AC5CD947CB0
      E029E6313598FF2364BB791A88C35C9C21A03733D816F2BEA05EA86404313353
      25E5F011F9B286903ECCAD4B8D3FA3454BD44D1F2B61CF6192A5894A9E4A6D6A
      947B77B78155F4EAC728866066DA5D6842C9371E0722E21D57380F568643A6CC
      B70489CF704FBED8AC486982D4EDC954409125C624DB25CD04F9B86216968FFE
      684F849E37673E9C3F3DB802E8E5C846D386E0568CE852DB63D569614133DD8A
      74777AA1A921B819300E22AE298A584B8E722A7E00131B9417C5C34B63B3527C
      96CCBE6B28F1C7B0C511396C7C5B8B358170A4FE002B9B5B621BF0E420A316E3
      E0B2700C71838DA9469651DEBDBDEF5387E43DB9F298D362A9C5B8D828AD8403
      FE0E28D2B943794672F959C586952632B8E321D8E72AE071E12365CA075AEDCE
      0F1F6E6780B8C7695E97C5783E3229A16F9295D310C49449075B8CEE8AD26A34
      AAD18BA673FD33F6A0451E7A8EA2634780AF8AE40B3F6A8ABC25CE90D7C19543
      5E078D10719FFD05D77AD654C839228080BB8DE71C651FC462272148D5E2BC3A
      138BD18BE188E563A9D98D221F3E7013F6D19C45C419FA713EEE4B3844122B74
      65392C22F3CBA84CAB2F34DEB4B4BA1D439A1F198EB8C7ED8942D89BC6372A2C
      8FE41607FD280CE5753A17B3106E1D6F999BF8EE0EDE9E316041BD70A543E0CF
      B3EA0725E7D799B9534B2022366319A532DDB8B89465AB793AC2A4B04E2F5ED1
      6176C88AD9D44A917E3675C61648037E8549F405831E72038268B0018160F907
      33B038D0340E9334281830888EE625AE744048FAF28F2A29B3D1A708FF623E9F
      885F5BC89B95D59D5090511D7DEF9D36385FC3B256C29DEA8FC9C656DCD85C3A
      644639CE5629D605C6DA0C3CBAA87BFCEEE86C273A234DE258C28DFA9D8B6296
      8EA2EEC1F1DEC9CE1DE20B725699296E00AF37AD5E45C7EFCE84D276FCEE6C6F
      9DA585E66D7B051E941007F3E4BA1729F616DCB16A3034DA59D4D8A2952D9CD4
      20452AB8A92DE206C3DF564770B9BAA47EE64AF1CB413A4120D68EC4020D1813
      D61146B37C83A7DDDDAB3489D986B993A95BAB686C2451D4CD21818ABF756F2A
      669ECA13E37EE6B007967B7856C1699C482487354452D72913936F1E95E16F13
      7A927A625449B31BD2565AAA6D4AA97F2E4C9E1C1A64566B2B479AA8A64994BA
      9A371FC77D2F1441FD29C15E3EAC4B40380844257933397AD124D6FA812D8C59
      5CF192D4964BB8982ECA5351D095BF77E49470E5E95DEFFCC7899C42F239DC3A
      43A68419D4F06BD59DF52245017A1E90B3704BEBAB8B200CCB06393B56E963DB
      67B9993264F896CB665CECB7AD9B61D2B0CFEA66794108272B4F9E0DFAD35617
      355779D097AD5B0F6866C2FDE75C8B868740E8370B13BC3A4D437D20DE027AB8
      C1724346AC00E6C43CE75372DA9125A1C173933CD5E09F08CF88EF45C37BF9BD
      1DA85E8AF314B802AD758A766F8AF91D8E2B9CC0EEE85F7748F1DBC1A52EF6A4
      F4E2D625A4EAB963B11B9C42AAA91475CB64342F91E9E1741F35D9CA9D84617A
      8E08FEF8638CDC31658BF96E380B0464D1785E5F215D906CC82A612E43EEF2D1
      4DAF405B6C64DDE03B45D953E66945F1F3734636DE1C7EDEFFF94EC3BCB7D930
      AB64AB4014C09EC40BE403FCC8531F60F5B02BFA18D3F8912898569482ABE855
      6AD44FB46DE14E78BF6B7A2ABD10063334F5CE976311AAFFC2566FF55B07F85A
      396F4E6BAD9B0E92813C8019F69C55C1D45C107DC74A3030035B0A1CB42FAF59
      52C23614232ED7E38DE7B0D99C84779A2F2B9F699241900CA6779C1F238E22FB
      72277BC0328F0438382DC62C78A661FAB5D13AF6D01C4C6370350CA75EB0CAB5
      E28043F77196481E405C019E5A64791A71DA1DF42C08DFBCB67570C692941B90
      0C2AE726B83B0954A83FAA48E30F4F59CAEAEC79F4E974EF403D0BBB96A5229F
      9639A23F8EC198C59057F2BA585B36FC02DAF5E7F3E16519CFAEC42D601EFB75
      50C445E9B18FFD45BF65633FA0C895AADDC83BE6853B3F6D962D87268885D745
      7415976371E6EFA363F9A71F7E64896F660DED5515C6B3C85DB521EE3571C81D
      A1611CBD26ABE09FF3290F0F1C4DDBB5FDE3EE73D736D7AA39685207495E5895
      04D3BCB93502C92E1205180C9B16600D699A32B3F8B1A9F428DAB68F3F2CED63
      A0DB16CB7AC07881DD77F6ECF1D1BB4F42C61AA76320ACBE2017709577C747FF
      C1F7F8F9E8E83FA0E4BC785A6CDE3DD61495EE1D9FEE1D44732D162DD9E5694E
      2EDCB3ABED9EFE6497A54017DF9E0C3FBCBBEA0FA481BAA6BEB356F6737E3642
      138AB1902200BB61CB5E3D7D1A96AE606EBB2A916948548E89BD4FA707ADAA9D
      D43D4545A17B14A67BC6E2162CA9DD397D737814FDFA6B741A5FA62375F545E3
      E4D75FA383BD8BBDA8EFFE730F5A877085936947F1A84A0BA9FA141F04F2065B
      F70C45E790793F815CB526D7909D14B336375D6F2BC9196CEDF3A4464623BD59
      25EB1548703B090DECE383FB578E3BF095E3644DFDDB575E98B352EA1EA579F4
      E2F950CB32082E1323ABC8172FF253B9F7494D011FC61666F6EFD04D08B3C280
      B072B892A5C725AF32843B9A93C3C00DEB30098DDA7B9CC8CCFB1DBA76110FCD
      52CC5D281D81FBC7F43828B79BEA3AFB1D9A47B529E0341094DAB6A861D7153E
      49F864532E573EA044DC255AF34DF638A36AC63C799036653F1F0AB5601CBD3E
      3F7D7FBF4A8DCB1B904A3B279FCEDF475DC6D8512976966459B563418B876A8D
      B7D06758A95280C7C54160649EBE39FF238B0DFDF03DAC3979F9568230883E06
      D6A95DC7E8223C01E1FF3903B6698180225C6C570AF64F4F767FC4BD767178FE
      FC15BAD50818EDED7F38FCF5D77F9C9C1D6CFD70B55D5F45A7677F3E120489B5
      3D904B59E48FC1B71B22CB9497F483EE4A1963AA8F2A35E439429DE70848D6AF
      A2D74541290D9F5E5017F88D2983E80162FA203A2106B06FD553CBD602675376
      AF8B14E9A93E558CFD20C9665769F4E4C9E0D9562D01584CB1A31EE469ED2D25
      232BC3EA426412F2141E89B26973F173FBA32C95F004433F8E38DE15A0773F4B
      672440EEDC31ED2D3AFF7253A6D3E8FC1065CB94581E9DE0B20938C78359BCDD
      BA7A575CC3C7ACA4B6FBA828683800AD0A4A78330469C5DE5DE846DBDEAAD9F7
      2582CA12CD36294959C9E0F6E0DD7810B07833896C5BB5E2CEC26A96B48581D6
      D71ECB9BB5C776EF527BECBE65FA7651A4EE08E0AA9482A07853D43DAF8B19D6
      9714F83D44A6C74F113F944F6012E4AD257687569F3C7517D7BE09AF456F92FA
      B83A3EF0E28CB0BF6648BB8E0E73F8051472D8D65C44AB383D7FB170FC677995
      EAF1DFB4CAFBF9E9DFDE05C616F032AC926192B34C8CEA4C6CDB388DFB634796
      81548C6886228E7453A659968E1CF399B56C45C641E376EFCB02B9ED5BB78E57
      874925A7BB42029EDC92A218A1141F9F4F891D939A90E654618F4ECECE2ED4FB
      A5F3ABFACC0F7AC10CB430B6F23E2CEAEEB5CB781C003A104D589774A730E320
      A9FE2F7FFB2087F27E9C51853B398A47C93BC404B3CA240C26B1BF0C62221B0F
      D224B52A24E623D7A3B444D55D0D1F90C68078264B9549F13FD444482B392FED
      2EE09DF1209DB242ADE3B98B4FE9DDDD39427A98EA21BB82D80A9DD4F33237F4
      1385136671D5B9A35DA8D3FB206F717E7EF82A3A397EF336BA46EEB8B2D74E18
      53FA293A397C77FE20CD5812F8FEC5C19E8854E382ABA36F67AF5BDCA2076FE1
      DDA7076A416EC7ABA206D5DF105B70FFBFDBEFC9FFEE6535FE2D7A1FF4FC5B08
      DE4256CADD6FC0E77FD40DF8F225EBD43ADBE7F1C9E1E7A81F7D54B0EB349EB1
      986F524617582DA21DFAFD8F5B36465416B91667C32CFD8A4BCF0000AF2D893D
      AFB0FF9BC3A32D1BFA91D77A9632D99BC43FC1D28C938E3A6892934FA189F9B0
      2FFFB9A517B60BD82C668553969727F59C271966F6BA28B37185CC5E4DA23F38
      D9F7073C9120891F859A242AC379BFE2BF3F3C79164CA6166844D52B9E60284C
      23188067AF45FBA6C0F133E86B645565C5769EFA9F7E209C7874F6EC55B4978F
      AE0A48C351CAE3FF8BDE83497A52145F8A79CD8FA099CDA586688F30492C5545
      856FFEB6B7BF65379E63D9590E21AF2D8FF15BBAA8993B98301FC87796B95B9F
      8FD3FC9FF4A0B775D83924EF3E21214B974A344623D322A73A3121F6A4A4BC0E
      0AC35D26C534A9CB6D57C0F7802EA5F8AE6F2F1BE5F32F31D7A5481CA694584E
      F3E8DDFC4BDCBFC06A419DF3A48EBEC6795A6D8972FF40901BA225753A33EB61
      9C56C2CC019F406A024BCDC56DDB9035F6FC95250C9D0D314124325551F7E0E8
      ECB561881E4AFF9AC6110EDBA2DCD69CFEE1E5136C2DDE47725C9DD74A4CCC4C
      EE5A4CFC6D9FFFBD0229EE5278265E812690D34D6EC0E3BAC2B78D98C14466E1
      301C035AEF4FB361B003FE9C177FD6E5B96D0B580D62DCA8488E32248B39DEC9
      F9F5BADFDBFAB1DB86E19EFB0BEE73740EB6759C49D5EC25B438AE7A7AC726E9
      BF6D74EBC7A86FE89B2C3E7DCD785640307376A57A198A342C77326EEE61CAFE
      E947BA996E0919E157480EA514442BE4FE79975C95E91467C1B64D61943FC044
      F0CC0523F3E16897D2B45E0F1055621B96FCB6ED62D51E7C682422F97032A219
      A0B8F296977FED8DC7462B387AF6F8DDA76DDBFD512D19C9213F49732C9B0F45
      31ADA27D5246C2B736B315438F054887ADF11B527568F16FBBE018D7174C0131
      27CFE2A3D65694A2C4F5D60F7F8E87BF49EA77C9B58B6381FD2EB58777A3B8BC
      645577E590D8DB1F5F0F997222149128CD67F32D01841F9FFFA8E0C5F3CFCE7A
      941A7DE4F5C4159947461F94F0DBA7BF9DEF335CBC6D0818570BCB46CFE0E78E
      35A828E577105D543D417557B76D056FF6B7798AC29AF3BA884493590F8D4951
      8E92BEA411449D0FA2C67C76747EC1E86767CB26858A71F246A2FE472767C8D3
      9F84144DD63F13F003AF3B43E624281BDB3688CB8C0ACF6AE034A5ACCBA4AFA8
      A43754829A7C78694AAF75256BD9333910F0DE1285FBF1254EC777EFF7FF337A
      F426615DC58FB3E8EF490CFACE23673190870ADBF009733BB66D0B2BC9003E57
      6B41AEBFB7F1BF90AFEFB610598E0A11497A09CDF06D5BC654D33D8ED29C8A7D
      A8C2C3E5344E46596CA9F252E76F3EE34EA2D90F3E29FF61F9000F0B772555E6
      C51351924622BC823061D5BB1257527C326009B92461E3200A5E6A7523B73D43
      6FEBAA9E3A8707100A43AEC9F93E06D3F7477E17750E2D17E639D78AC81E4C58
      4766B7A3210C3D323A4C55116D180C72D541A35B7BBCB775FD103191383B3F14
      D64CD8E959528A892CF56A035F8739C12055239DCD5540B1D9180C2BA4BD952D
      16E48376FB243C5D83FAF3546D11E53DF5DC1528945A455459E7F31EB4372F9E
      47284D6029350E9F17D5589532F7455D282B2C84A5E7F774E06FEB912A6342DF
      57F36820296680B0A090A8F48773C5A4D5B39BE8B779320780197F75199971CD
      67F40262B5D503CA8AEA6167D5ED67B37241CFE61B20D1588AD648FD5ED5E19A
      5053DB082BBF074BAF2BBB93E12F15AD444FDF018CA80B3D87C8A4C9E38C9D62
      201BB7140A94CB0A28AB3F10DAFDD30F4F81D8ED910A737E7EC84EB12C568E84
      E1C4BC27A5BF6F7B6CFFE9C75DF8B79D8FF915FCE538CB068341C7A2B494D420
      D3D86A9B4D937CBE6D43B8874524837C441AAAD1E9DB838B40DC3CB4EA20322D
      F6D2392E669387AFA22E6204FD633EE0EF0037F8101792DF3C22ACC7A613F9C3
      20AF911A510DBA06E1E196C7781D461A3D2B65066527A8B0AF88C98994B31DEC
      2656088A3DF5562C32D36706759C49FEB41B84CD79C61C623C7E6562C78DB48A
      8991BE6A09C9FE6FF8396CF2570042B1CDA949EB3AA2EABFEE088ABA38D09986
      E8AAE9A999A734762ADB72946193199145392C5A84F5DC8976E2345E5DB197A6
      96CB3F812B0CB7DB670A210ED78B50D6327C9B717C9D5FCE910505EF03D9B845
      3E2C4A3A23EB2BEF797E88CEE988F2D66ED26017D323EF22EB0215A4AE7706F7
      0E273CFBA3C2092FE8A67DA08EF92CCEEDB206D570CB079286ABA1F296C9F4CA
      4573C54E15D22264EB31FF8FA3428040CE2AB6DCF9FED9C9BD42B77F7A415F8D
      352234F0E8326AAB5E9B9E825D2AB24F7B52E10821659109E399C9BCB5249FCB
      16C095A00AE1FE478D04DC2DBBFC025DA6825D5C47BBBD5DD3E1AA6673B201A5
      92909C2A61A442EF11038DB7E4CEBE78B9EBE6EF209EC697F000815926C42C19
      8CCCE221F97A0E39DAB629A11888D77A7C712A31169E9B26C49B47257D5CA2EB
      5C2FCD147B49D6DEB67D8224570544D7A3C3F3F762A29E16631151DCF6A9085E
      EC918AFB292DA42E916A9029762872965A23056255A078866FBA65CB3F3ED1A9
      7B0C555C505566040DB998247F439402797CD37A63943E8BF371358A67D4CDC9
      580A5371B0D2A00C85691C389A3FDA12177A4178B782ECC69C6B0845CF246795
      FFD2740B5FCA8A4669351F6AB915E4A9B168F3D6834498FE66C6440AA0073F1D
      BCDB3BFD692F4F5520E0E26696BC8A5EC73886D211E2EDAF638C4A9D8EB66CF2
      07C2BA54ABA8AFA2618CF459AC60CBFEA70C24961EF5AE4481BC32116A617752
      2CAE28A26A1A67D9B66F4EE85540ED13ADB45B4CA2CE4182AC8D2A890E7F9BA7
      33E2671D1B1CF8B8C5580316DBB60BFB775F8AE808C9D5BC40B10FF7338075A8
      3F7053A1E03AFE5597FC178CA4BF73002A5465DA16B27BC9D4152D9E365D289E
      66F23F5A3B8D9528AC565CAD8528E7D59650D2CB27685B458CBF0607429253B0
      5055BA936DA1AA974F71600BD0E91364C990C39222670402C91FCF2FB66D00C7
      0AF5A62EDE9DFAA034233296F3085E7D5AD7A8E809B3689E4B7927CAAE321D58
      4EBDDD7B60722F9FE2623C393B7883DB3CCE79564873A1A72977F3D7247AF7F1
      84051851EA16696384D0507BD742C85B76E31961C8E43ADAFF19354DE09AF3A9
      3A14382954A753A675CC9083AF55A224311FB8BA075AF8F219704A9783E4D444
      52E242203FFB047C4B68D6C5AE5949CC424AF32F2EC9B128D34B66C860F5B8F8
      2B4A17212F95BEC3B67DC5C92FC5A5A9F021271BDD07093F394A89608B936234
      A716804FE4754EC4B4D8D2E878F98CDEF874985ECE4D7881A1C64755F4B78FE7
      1781C8FB960D3CBFBD81F77BFB3F3F40033850F66DCEF78C0DDA6CC430AF609A
      F7F1CD1979995BB6FC3D8E1AB7C074BA1E55F82FC3B2546C9559DBBA90842004
      0802DB241D6B592BE8A048008DD90FC847D34B297D5838D0D1280E1ABE9F2883
      A2C0C9EB02E40614078B2F2F590D64CBF0E6AD3D204806B6C6DEA7538BE7A631
      4AC9450974D2A1DDA155EF1818BB944DD923204DA111A904A64AD4EA42F37BAE
      1CF22350938A2F0C096824084827EBCDB35D7028E8AFE067086656A0BE650FFB
      AA007B084400EAF1480F0C7B161B83919B09918A511AAB98E590A307EDCD5B07
      3A7615ECFD4BF4C3EEAE2F9B6C34020106919D1984A21BD580E44CE2CDE232F2
      2D36E64B023F68EF1BA551347422013748D70233949000564DD441D2075EE7A2
      E84433C8488B408DFFA5AC24B1147C3AE383F638F0EB4177411F91A0A6D43DDE
      D5D517114678D07643460AFE946A6A2773E5B202B2672658EB4E462EBF34EF53
      495D6530D4E8166D04AD7BC37AA05B1ED6B7F537CDFD6E10970F52A6721C36AA
      CA598EA7E9D32839C01B0FBA12E6B990CEEF4542BEEDF40ACD0B63134C02BD39
      D75F8D0606778EFF3A8564F7214C5FC2CA9868A9021FD6B80794705BCF1563F4
      8581A66945DD675F09CF572A3496B59AFE0F1E91D4248ED767673F43F89B1A90
      97D1F9FBC31357734FC610810218AF0F1920B9184F34A36D00B2C951594C5DBD
      50B723342CAA8EA715D1F4B13A3EFA217B2541815FC0A2F8AC340A65A83465B6
      C2C3B6ABA51759DD2D4782645E253B0FD92B01BFBC4E6C4090128A4E4E44E521
      9B348EEAC2BD84438AFB7BC6301F14242970EFAAB2B44FB087EC5551CEAE6240
      DD4BF66D15E047A296B1405433EEB61547E57D147F1575E9C5126FBF6F14EE05
      EDFE001CBBB8387C1D70AD171DDACEEB0C15AF5D75822DB93B2F5EFED86CF8D3
      F1F9312FA6F7FBA7AF434AE3BDB2ACFFF4F229FCD26A3E99A4DF04C980C68D60
      C2301260A3CB95BCADE364E8E267441965D49E3C2152C4B31DFCA63ED3F13A4D
      4E61508D8572569DB7E29012F563AC1632FCFB48B3042CB5DD38FB3C6F7421DA
      45B770D46AD5EDCE398BF5DDF7D974173A1FA490AFB0F2DF97052EE632FA767E
      181DBAE2A227C565C7D7E8DDAAD90F721C8B4D1568D5BD2F13187AE730457973
      41B95BB0C58014825AA29AA68020E4563D60B8D6E8E057A908DC4A31040D2743
      DF7ADBCB924F872620F32C88D440E60D4200F3A170A3A3BDED852C823B57E225
      87EFF6DFE25CFA392FAE0906E104DDEED912CD8F2B96DFD2D34EC19EFBB01BC0
      47C241CACA2F904A8519E552D835674D0079E199B5982C8C0445DDDDDD27FDA3
      A3A37035FCB0BB8B8F76CC369FCEF07CE5461E9E6F7799B5E37BAAD124213E4B
      C514763F2FAA28A3A5E8D409F371F4F6F8E2F470733AC6396AE424B892DEBB12
      6EAB42B8E748E9F1D5DE2C86AB8550C4938EA5F20E9F8AA2367971BD9DD8A4C4
      9C71637B1A445C45FDDFAAED02077DB808B73CF3EBD60F45C01AF614413F3C2A
      BECCEEF1BA42FDE46B8EEEF118F42A78543CDA7849A81C07B620CD4918933425
      D7950F46FEAA149D73D90D691E1D34D8020CEA8F939A081683FBF88E31B42C0C
      B9C34C65666AC6147F6108A151204C6B17A05F008795636D1ABCAE9E783CB642
      7608894C49736868B2F2CEA4BE9BEA4DB74F7CC0F056321DD7B2F01A7D3D6316
      F0757C4CA1A3512E1FDCC0F57408F14865E3E8A8A9DD771BCA46968892366E54
      F3914C8D9D0D7834AA3747E2C9B2B10DC67061F2D6BE8BAB00E4981D5020CC5C
      AAF4D3E0E4D8F24478576039224BCE25C9699D7B592BBEF79C5871EE2D8DAE2E
      DAABB1C1F9C3FC9D17F32CDA8FD3D2A8BFE304B1B521B5CD4145D9AEDB47A0D1
      357AAD9EBD74ADDD77D3CD0C5777D7A7BF93137D03BD5B5E94FCDACEBD29324F
      37A7C8FC5CF48FD295C781E1ABC5447525E30AF88A9C0EB814A0C4A34431AD33
      208E92AB56CCBACEC40FDEC7759988CAFD63C822C437EFE36C036213951B0372
      D3EAF6A26101DD2DC8EC22DF019B6C5AE435CA248D0B44DB104206E2CB97EFC1
      792A012F8F53C5374520AE84D71891772ABD87A8C12C198C8A69D42D4A3E41DE
      6087C9391FFFF79A33229106A3F7608EB0460693660C7B963F6A916D5DC450E9
      90B050B38EF714B8305C97CD2970C85828DF17495D459FD27152AC340EF6B8A8
      3AF2C58E75AAC9F5DBB68F4B8E1B52E28A19294FFF5ECC2FE6C304551C6F4877
      E2946AF69955694395C282522FFEB5FE28D5D11781B69F397BEF93F20BF5056F
      5856267AF2FDCB6D1FAE2258826E9BB6926637CBCAA4D6C9A38AA2A72B4297F6
      2349E1622CE441813B99122BCD07C66A7E1D43133EBBD931A0CCAD01156B105E
      AF67CCF07E8D21F69BA10A900A5C3394A337330BD63D68BF4979F3A59E702243
      679D18717D8D8A2361412C7C47727A590445AE19B15CEC6291B81E09AD4C2A10
      B60E954FC0CFB99AD7C0A51E1634A5CBFD319FC3D8D1E80510996212BD3E950A
      360C6650745C6A9DC595CF96A940AEEE2AB2AAF7D730899E8949B4F3A05D0D8A
      9516135BAE98619C826039EB6A9088CE63C233F88709DF3BDE2C4C11D1C57281
      B1B41CCDA756B7A321E0295A2E167275B81BA7C659772C71FBA02FDB3940E1F3
      B61264C7E3C8CC3F0AEDDFA01EAD5A8B88549AFB695C1B6E05CA0A88B5EC588E
      3C802922F9F07B446EBDE39C23090991A0E2233783E62A853733304F561745C6
      4196CE04FF3A225D214FAE1D4133AC5D89E7191DFF617709110E2AAC82B3B577
      F1015D965DF3B0C3A5560EE5EB44C73C85EAFDAD572463A5713444494252DBB0
      00F271D4ADAF62049FABAB78BC7B5D5DC537E367AEDED824FDF6A060FEB9C4C7
      683F17A564B1C9B16556DBE1F92983EFA209707E2826107448CE845AE11C2CF3
      ADE89E79D27BD78528982C6D825026C78E22CE0E16343BDA05EE0ECF4F1FF47D
      F7C663D52CECEE38C726F64E8DA8F371AB598C41701A8D126F5F04E3B6C893A0
      FE61694960FF01458C250529E5D5A8B53B958B3588FD084A78AF10E72D111F0F
      15FE9D67563189DE17D712EB397F7BF6B1C5DD6291A7EDA913B7869D1465266A
      65EA626EAAEA32CEAB2C2665C3CD5DC01A410187DFAB3F651D1D9D9C5FD8300C
      59485478C1F75422BCA5F10393EF6AC59EDE7CF8F8DE854B355E8982CE797F12
      D7A866A199B06ECFCA1DB958927305A0E4EA083BA9BF956EC4B2EF4B75621FFF
      0A5288D5A89252054063389F8AC8464FE030B9A24EAB9B758D59054F5F01D94F
      CA20DA73F871CBB5D11AB56591B100CBE6AE85BDB1A2F372B0BC16D941A3FC40
      C8B22841801BDE98D0CB7A674CB3CA3ADBB6D069BF6357874154F7CA79B21A75
      52B319359534714E4A847F4D7A8DAEC44B7A01B3547AB898FCE48B226F1EF364
      411D898A87B5DD64BAC7288A4B79BB55AF73FB33BA8FF6C8C43E92741F16E6D5
      6F3DEA458F509616E10C114D93AD1E88AA3E1235B5472A6FD03966C50D146545
      6223CFEA8ED97F8FACAA0DCBE3C0AA1856059F7D7D5BE58F476D718547920DED
      CA963B4C5044A0A229EE914BDCB3B32CF685B1564EF5299216C36AB3F110D6C0
      82AE83DEA1724CD1D4492B03A5C0021E17239101E8823166B9680CC92B64DCA3
      C148472B41A952370D3B9BAF865FC0ABFBBC348BB2B7844621F3C3B7A08803D8
      7E88AAB11EE2BABAC2527F8E43CE9B902E3027C0EA70E00A942C0C838D24B68F
      1233E21323C1316DD6C3563D488FA9AE864CE407623FB12B3D547D52E97B3645
      FDEC8AF97EDBC1B3B726A6BE82061A5E7B399BD1D2374DA907B225F86CAB4E2C
      6F5F138557B6FD3DBF71EFA6FD5A7F059D33D7AC0BA4589347677CDBBFEDDDB7
      456DCC868F1F365AB2B7DFBEA1E6D2C77CB2297C8C4FF161EBB5F6DE9C2CB4B6
      666FB8B348A9845C9192AE12EDC77281E87E3885292B7FEA49B9B42F2CAE96C4
      9580CB09D6736C68AFBBC52C4318654572DB5DB623363F3E381C5419C249BF78
      5EACC3747D9AEB423E2CC18DBAB84C18D991A4D85648AF281BC1C20D4F0041C5
      6B0AC8F8649242F1512DB0264E8B8068CE36B5408416591915D3298E4358562B
      5BE449628B8FCBA3FD267E1C04835C8C33AD9B84C36FABF3B3E92E25D7D2126A
      436E34E27110C0F0D5886595769910BDEC8E905C9A9ECA4BEE884AC35717816C
      28FE10BB54F631D9FD468B22773D85E6E05DAC1B4D87DF3641FFE112F2D7A6E3
      AF4AC66F9BB082935B34D9A7AD701DA3A0EEC4BD01406196E3A56BAEDB3B2BA4
      8A1A6F6FAE7CA27791E4411217F7B3EBBECCEE9ED7493C45E25C124F97667F20
      CBBA82409D33BB24A4C62EC8835C317813061033762E625600BBA0A0AC6FF0A8
      927A3EF8D1E6F37E047EE7BC8E5EBE583592072E4586380958CF80EAAC7E822F
      F3873591E692BE386E16524EF3E8098479F942F8D7F7E8EAE8EA2EC7A6956435
      61BC0D0A67BE7741710CB354FDD4A7F83711E56C29E0157C01CE4663D359EEAD
      77E7242499655A945D6A5061B34A607610752FF891C32B20048E7C0BAAD8C16E
      73082B24AFF1D362321173111F28BC554C26AD224382694980DA52FD84552097
      609BAC6EE459BE60503F97FC8325A5C7E180FC3CD859295DE1214414F47ED52C
      0569B5E184F2C6F2AB5D47D490FAD2BEB894AB9C29012763FC0B0B8215E9C5CE
      9714FB2F415A48A3C283CE9FF1E0C1BFF093AC724BC3645294A8498C557B9526
      EC625AF59ABD0F606FE5C06189A3E40421FDE0A5E479ED99C0DECC56DF6EB859
      88E4C894B420816A9601EC467E78C77DABE3FC67B47001F7992BA573844937C2
      3CBAD5FCE611544C68E7B0BE64A9F108371D8E79414A8AEF140E455562C70AF4
      CB7EB5D77E1BC44857C56F1D5F50948D8D3CAE14D6F77678B6D6834CCAF4ABF1
      338269D0726FDD566D4D2BCA2AEB29CE2A478396537EFF673BDB3D99BC550056
      858092C636D909312D5D21C31BE5FD69A558437B35A9CE3B66A1E68F1945CA18
      6CD038CD58F56359B9C15C3901F08303969DDF034B802658AFA89A2E0BB08ABA
      41FD40D43BE541E59765E24E14FB812A0B25E39D57511F6B07B3D903D726F80F
      2C50CC939C6CFD77857DB0F9E10FF45F2BCDC06B5EF5FE1228D04AC580865902
      9139320B75611994D3F1C66A798434781924320170B82F64EDCAA2746AE36454
      BBF5AB71B5E0F9A8AD27B2841AA21096A7C439B036E434C7454A226B686299E8
      D7A2B67991F7C7092DE9C5F37B6046638603FEA66D3C7A25C032051F8D03B6B4
      532BD75930250E8FF0067168BC8212BDD00B4AD94ADBA1923036A95DAB39CBFD
      B5FB24E20DF372061B58AE051B3249CEF3325B08201DCA9586BA705A1BFB4B90
      3448F7016DC924C00ED4A4339E861AEA1844475A6A7D11A3E2D5D4C6A5DA0DAF
      3B316137308106C6934768DA439C4E08BBC46502E6C565A11792603350473011
      853B77A18060A0F1FCF276C31EED49520E83823E229E767E7EE8BFDF30DF49B8
      300BB71F3C74531B3E84A1F7245AC7803A1EB509BC1C60C8670B187260587327
      C862E489A61281A28BB9B000BB41F4559FDBF3AA82887FB47F24AD3096493228
      5A5A6D5FB1E326E2B8301D212A6E9E81DDD5E2B0388289D14A921A66ADC443D7
      5EE0FA68B7AC4B98578505E8399B321DC87BE0B06D2191062DCCC78361FC347A
      BBAC66E252D7D1F1B19048CC83C23FC52D874084B74C08FE06F5B8E58730205E
      9FEF95A3ABF55C31CD048DC7E3AA71385F1C9E3F13414F00C95225AC8AAE913A
      1337BF69C82B30796857A1F21E8F1195D23E13C7082949EE0B7C257BF03A6C46
      8E4D1E712C9CA125B6B52AAE9257447B94E79CC010C9B7BA8CA3AF05733E8409
      1283E12A029CE2BD362EFFBA88DE17595A5DD9FB7FBFA37A99CD5AB648DFAEC0
      632E664A8869CADCDD019A6012866EB2F5D905FABDC0E809BC751C2696D40158
      524C3D6C24442FBEA64229D1331679298C2C801E18ED95497480E3F60EEEEA55
      99E6A4D59CA3ACDB6B11125A79A16AEED6C76394BEE56EEDA0A3C8462639521E
      D978DEC694C88E1D802DB426DCEE381BB1905CA694F71F439B559EACCA487472
      C920C13DDC269148AD543B33526C4B3879BC3F579F7F2A45A8C1A3C659A7CA40
      EC9800BB4AC5C7276F936C163D56C269F4387A977C9B57A7C518FF7E93D66FE7
      C3E8B11169A2C78E1FFC58C9B08F9560EB5EEFDED4E8277F987A20B58D9E0D9E
      F12C41D3BBA2CA030B21AC7A6D390296494EA406555CBAC3328951D5675E17FD
      32111493D578A64989AF6E2916FE827AFFBE8CBBE98A35349D3F1CBE3F41CEE7
      E9D9C1E14974747C7218BDDB3B3D5442EAC34A39D4B0A7253F6CE6512557554F
      780B9249EF0FB6C6A98621A690C883760CBCACC7A641362D60D79900D9B87005
      8D5D3DEA076DFB24B9049F93959971EF338C329FC9C5B92B044E2143F286711C
      8A07CECD27C7E562FFE823DE5200391F4A107CB67354D051FA38EBFC5EBA001D
      A99F884BA0EA047C917675C9BF9F9DBD0F9CED875D0C65F125C903FBC64A9050
      254A1DC376C6D1652A56A831853518FFA01D53A2C1F1C569432A8114064810B7
      D2E71F98EE2A152D2F8A593AEA08FE45B162665B76A2373E1D7E9888AC47C5B2
      E705F808F1B68A09B7F4464B81A99E1C50B973920A3E2423D60E9119BCDF765D
      4EC932562C0D99B40AD82D66C718A3D2298328C7518DB9A6FEEF12C0EE217B4B
      2BC465D6CB49E66188513C8205E3C03AA1AA2A76212C0D97FE1390971F54F241
      6C1A8A9C25E35BF04B38E04871A30CE6BCA61E0D8D10092DB991276F32A42B57
      4C77B78A967C5A030C79C8373163DF541D25279D505231A384A3540E429283F0
      A1E59EF3FA7DC72AD7E3F02A57D042A4FC373667D492124B75652CE1269A15B3
      791603E105A6058BB76187B55D7D5655490A907BB86E668C023878274600AF0F
      D4DAD2AF1A151AB2644CC3A7C8CDFEDBDCACF7F624CE1EB528F5925EEBCF8B1D
      AFC618AC6D33B47BA1356B16F6AAA63CDD619844C3024915F958EE6744D6C7F7
      B75B7737B75B3D016B359AD3F15FEC78AA9677DBADBA95C01748F2D1AC2FB7D5
      002EAD0530046E6DC28DB06610D605A07F59C653714807587A56A0458533A82C
      26C60F651615C1EFC8F786C537BFB359C70806913D7C32A7EBCE6757FA7BD250
      9630D4F0DA161DE85A895E85A462936D1A2FB0D29E3E6FCFC2D31F64162EE8B1
      41E203DE5ADE126F5B02F25C9CED2F49FE4351A0961319749FE661975E22ADF7
      7101617747B7F15FBC88873B6D4898A35A9491144558ECF0CA5955ADDC7D5115
      03FB00C1786D18AF22101B8F5A45BCF48E537CDF1DBEAB49A7E918A99C13F758
      2CA5316C2BF656091E0CD0AD832F51D23089BA762D14252E0389D95D2F6945E0
      BA201F2D480DE7B06BADAECB38CD375F156290ACDE97CA8464F6E9222DB935B1
      B03AD6E1B62717D177D139C3C8171F4EA2EFA223D50F0D7897686DE5538E9E05
      A58A70A5118200C1456FE92F49328338154132F8B18601D8853C9A97152E8A02
      45F2160EF9666BB29C5C83E190DCA5496BCB2C0A7D0EBB8EA12D13BC0A02822C
      4A7F8900B7A1E55655460F90DB1EA1BFDB7C09FC4751ACCCBFDF8BFE55E035CA
      78F4057AD80FB104D0E66DA9FCBA26767BD1777CF9FEE6B7EFC7639C5CED9A8E
      4B916252010583AD1A94ACE11C26649AFB871104BBB1EE9AD6CBD8821DF55559
      CC2F053DEEF017D4541234CCE0F59BAA46920C3EEA2213CB42BBAD2375A701CC
      89E82E07C172B2AD5362D8CB3314D55C8BDAAFF82DEE3DA430632818F9479C6C
      D23C27994BB6FA66CD25D39DA7165BE20B5B103D6C5F2C1A3E5248F215749238
      AC3C884F687576C7521E9B8BBB504D1A70631CBB44CECB03481C74EDAFF66DFD
      71F8656970DD48A14F6ADE42A4E10B26094103DBBCC2FD50C24F0322253B14E3
      65AF9656B8CE101CB6ED2A2B411F2F26B6AB8F9ADC01FA96A18CAF11ED63AD27
      D8EE96E8302AB2625E6EACD9C1A7D884BBE391CFA0FCFF34810DC2789E1C3FF9
      181094ACCF4ABF49EF81271ED58E9013943674A0D9E31D043F7EA7D97539074D
      E30E9693D3BFB0E73C96DFEFC8F34CD05F294BF6424352D51C35553E6C081285
      7B0833404641B6A468C4E613AB48DB92F95CAD9050AF44FA433480536EEDA889
      A7C496E2F2525474A1FA57A5C314C551841DA1DF87C498153A901FA9E1015D33
      4BBC95C23B4A4B11134E5E8411B32EC75CDE4966CDFD1D8559BA0B33B12E11C8
      64ACFDD04D19B8998131DB44B3433F7E84585C9043ECBC79399D5C893E7EAFDB
      7887C7618F29B711B4EFCB40684B9B4FFEDBF4F2AA7FF0FE58B6E4C61B38482D
      6C3E213C7C158D93C226F47A4631E76AA1F4A3FC61128F28B35B5970EFA7E8C9
      EEEEFFB197B5DD6FA1E38123D566E93495208E63D3EA90980B3B8CADC620C062
      111A7219D84E4F73643BA9D1C1D1BCAAC5ACB2BBE36E43DC791B4F87F3F21279
      4FA7EDCA6A8B4EA9FB36BF7C9BF48865BE2FF79082DB5CF95FFA14AC500A52E3
      9EA4F5D3754C64DE56D1846036C30E525C69BBF499930283F92F4ECA560FB04C
      0C8A059129986F591C169C80AD7EB841949789626278D520F6BA84DC660673F7
      AF5C60E36496E4C4C94166902026F7B2276E87A14D5146BF4C6A1F3566F03134
      F4C4C5BF4300FBFCC4CCD0CD6C56214B39CB156D5A69D665ACB56E4039C0DF9A
      95612DC63D7597B5E6BC5749EBD9AB4FE0A0386CA0D32CBC13A5D66A35A30EAF
      DF0E5077B975F935536A4F4BABF7114D63A6F5F36774710FBF7DFB26A28983E8
      105555B31B2959BAC06EE3061329517F42869A106C6E3EC33F9F7EFF2CEA604C
      3BAEE3DDDD5DF2620FE46A7ABEFBE30BD76DF79DA3C35DFDDA21A51AF52D95AB
      4C9229B49ED6DAE46EEE7CE888E57B02D17735595CDBF043F8576517535154FF
      28179754C119A797696D09FAC621C55E78777641D83F13ED1595CC1A23443505
      1F2C683ACE6FA645B9261137204AA9609AD248029D34412F44543EF1D5841B1A
      EE02FB4F6771CD89EA6A7152628F2E344D8025774A9578613A9E8C7AC5FEB575
      2FC86BF7A29FA2FFCD79724BEE3A2EE984F94899BF66962CE7B5CBDFF83CB738
      B560D1DEA650D77A9AD6D8C443D953C741B405C03DC159C72E4228013F30E3C6
      0DADDDFCCD2DBFB2E5F755321F178B2D4B856837338D8EC8E2D49E60F65D6869
      83DEE86645D8BA921FC3EC957C09ADE4A0251FBE268D61D6E90DF7FD16792D9B
      1CBDC1B7431E6B90EEE184960C82C6B170F6F2C542BA92266C48CAD2A478F9E2
      0EF94A81902207034326E5A85CFACDC0677D0B8AA1792AFA92069D2F54E6942B
      85937DCEED7B739E7EA3088B532CBE51582428DE64B3CCF0CFEAFDB138E0E882
      B7432594A707BDE895C9C59DDF20D3CA47F82DB7091E9D904B594525AE97751C
      2D4EE723E2A852AF612494C046E85B625E123A5FF912AFE728857499835E18E7
      75144F99D504A919902E04B9639477A264E09242579A8522A26841AE14E782B9
      F8961F19E7C8FDB9768ADD1D4B5CF075B26ECDA35BB1DCDDA218239CB12FB50C
      56BD69F30721A559EF5239D219971D6B9AA17CC445228088446D4D748C594D2E
      6BA64C146493AB69FFC3BE3394254714B15C244969D29CAAC8AC9C9E0FC9449C
      01D11A10F1B442BB9142E74B8B3800472B930AE5DCD02AAE370C701E7DBFBBDB
      4E2BA1254541EF496347D531F79EFFED5395645B0FC299FC01580AE238B3736E
      C45BC32D03E50AC24B8A04AAB4E0F39E56F1F6244CBCF6EA73A45A3FBDA67BD4
      0051A4238640FFFA5F38797FFD6F6E3653C8859D191A200253CBFA80549AC435
      717ED612859DA0E04D9ACF6B182EA89E44A6BDEE1EC5BCCD8CB4ADCF9C34E31D
      CA0A6CBC42BEF14C842BD4950AF2A6F1A04C26F2150C39214A89BA04594A692E
      52FABFFE6A03C2FD95FCFA6B4776413C62255A411BF830917EA72C8E5432E0B2
      B7B3282B2E37ECB7E288B7991B4CDDD9D4E03828F29AFD8EFE1A92A3553688C5
      E1D9EA9A73C33F87D9EB7FD5324CBC58C2C1F60EA4CC3A29FBF850EFA4CDDAA0
      A4BEB5C147846DE8A9647BB64C262BFDC6FEFEAB5FFF0B53F3EB7F477F9539D2
      6B86309C7FF0E692305017E9E3A891CC42EB0993DBD5E62C26B76FC675AB4033
      CF5CC482CFF31941B76F722D33A13124758E5C6DAA5017453A2F3795464F010B
      D19DF489C92E70B2FFFE23608F24E02D04C96EC1D589F3191C65B860EC065CB1
      45676955767E7039889A2EAF8DFD0FFBCF9EDE6510E5077AF784378E13E1E42E
      55AF0EE08EDD53C186DDB811F5119DF56C8FD71909797B3CE56FE55E6D3E50C7
      24582763CFDC2733B5182733FCC706E6AF96655287CE0290CEA214539D27A33A
      F0A685E6CDBBBD77E7C75117961CD43CB1D8A8701C8F6AE0EFFA7D5D2A1A1751
      9B274C4E769DEE021A10AA9A54C1740F93A52ADD6053623FED60A88911A21C47
      430D9EFBC7643CC64208247AC98AD9418606297C72E707E3212E4A8A0ACB5E37
      082E095FD9F558B1173DB29B7FD3050581804CBFB181B31D904B00DE30C6717B
      2372CC1AC5895F758932C66AD6009209994A995F26B0EAFCAC175BB1B29292A7
      681120974E0A333CB3BB507B86526AD8BFB007F8668F8284E33417808E808245
      D2F96276F92D1DC4B3F33BD01FF872F6BAEBB3F028E7E5C1C185516269F0E432
      860DC94C5AE9E07698ED1BD941EED9D46784B047692B5B00301E56D48AEC79B2
      1F955400A7F758608F9525DB7A924CDF35FE89B95F64366F57909EFACFB312CD
      D7509EC7B4DCCC4C1E91563D74D9FC78B957A2D1CE9AA2BE3CAA5C95D0D4D000
      BCD8603216CDE29AC1A6B4B54EF90D942825A2E3E78C6817C208127458BABAEF
      08AAE3AC5832458B5D75253E07F637551F15F29FBE0584D8EDC1DBF5EB22549F
      DCAC6BAD51D445A2ABC1F697C87B12EF010A2E524803606CD1D9304BBF32D1D1
      9CFD67B2B5ED3F490C492E6381281BFD1029F02A8C19FB9A8950CAB40E9AC077
      DB97962E04AB26070145D32049464BF3513627BD2107D221B1103F3A51B7A1E0
      693E47AB82EB9D67CFAB8EBBBF4972009C02422E4BA7B975F2B48F81C0450B46
      0CD78F3B0F9F3CFDFE69D4E551D98F4E50CE3B3ADE692A0F0469EB92B5D91FCD
      FA7A67BFFA8B3DE927CD110C3E00F552882FF37AF20337B56F58AC41A6B4DFAA
      6AD210887245ABD76A00B60F17D16C680F834E595C451F2F8E7E183492A715E8
      6E364964AD6DCFF8E72A958394685D218430F074710C732B94E206E1BA95F2B8
      0142B67892F0F54CB7AFC14370A69C0AEB11FE9EC19AD76D8A6519EAFB35D7EB
      E697E38936B4F25E0C765E178BFBFC5040F6221BCB160C43988DAECB3B62375F
      E678F5ED2EC9B88C87E928EA63CDBFD8EA09F06B31C17D4EEA768FF85732BA92
      3EEC6EF580710C512E79C2D3AD9E90E497D93D1F3141B1DF7B3E023EE7BD9E70
      99945388B7DDE30965927C91073CDBEA0157F3FC128509F2FBCC685AC7597ABF
      17F9673C8BEFBB32F3A2BC4E2EEFD991992475DF633470BACE2FE7F2325BF7A3
      9C57957B95275B3DA29ADD7BA755D7C9F89E8FA8E7E517F788E76B8FD7F3C33F
      E0205D71802CE9939975AA4CE0023C7F484797F671C5452612756412E915CD8C
      A740CCA0217FB13E79A451FA0996B00A47F0D97470251DCD35D1A5F04C69B687
      C4219C4C9CF9B6A229342CBE263B4099C9599442216D850ED64A013255459D8F
      520B2AFCF32B57E93504AA58FC0578DB5A852E3199BC26625E903F160022228B
      06576BB16F6661CE58A6514AEA8143A365DB693545BF8C6666887D06641F0A8A
      08A54A6A7E0BD352891EE96A203B7CE6AAEFE952FF2B0CD855DFFB02FA5991FF
      F5C58B172FD6A17C9E154AD75C04E690DCE28C6429DDE0612CE1DEE0D9518A52
      49426560760F7375C9A28D81C6AF5754F3AD7B2B9444582193C04895C2D362CE
      07167B5A3565D36CC96E6E26AA9CBBFBE57AF4CA127ED4CC0EC4E83A8732359D
      A8DB39CC3B227F62470DA9C37ED74EE84C85B6BF1B842562B2E6E564AFFE628F
      F809FA3F047AB9A9AB9A0C9656ED1891ABBD4E6BB26343E721B0C45DD1FA866A
      101D35D112C04FE9320780A6FBB5DBFF7F81F7F1D320CD538532DC5F52B3C559
      F666D270B88D59512D7C87CE2E4549E9D6DCC1F26FBB231BD27F1679D74B115C
      C9376D3561E411E3A0FA89AE74FC855F554A41E7406BC8FC79394202C2DEDA6D
      3389B30C64E3E53DC2D135D77A6AD61BC2F6BA6EC5C3ECF27A3E3A7BDEF3223D
      FA050C001D459D0C29AB987CA336801E42AB654E18EF0B874D7C51011E163D79
      82DECC93D44837464205A6345E43789ADEA1310243EFD01FE94120D49FAA8621
      0F28BFAC7EDF7FEA9E0DBE27C14F36AC308071B9E208D3865257D893AE57E3A4
      622EB1BDEB6A3AC9F2E5A3A5B58071041B9317939E83F2C29A0B1F8DAEA06C44
      02074FE216AC035345580DEE42F78D0674BB4531C77B2DD255199C4B60BD958B
      67F1FBCD284518A05832A0580ACB910757C2AD6E26CC465D8586961D6960DE84
      78D5C271BCC399150446B98DB2C27ABECB3491104B6BD99541548B325BF81E3A
      0863CA0BEEB2FEB09B117B4498C075EB346944D94BBE7B01EA2C8BFE9C17F59F
      4D09AC610DB69650A3305017238C4B2C400C370CB72C31371B8FB6B5AC4BF332
      2B863C9383C3A28BB798B98A2840E7965F6A3BA1AEDB6816A28348CF1BCDFA6C
      3AFCBC71F37A51F4EDC0C4FE68D6A4B1E16D716C5307C77889CC54E9F9EED04E
      27B1A65C5B2C39184E0C9851509A872B62CD0C5E2A9A3B8C2B10746EC203373C
      2BD79CBBF2949E98B6BE14B0AC582AD735613B39728382CDC171BB9A3948D81A
      9A86D98D0A09346E94DB968DAA0734AE175A91B616B837FE329ABDFAF6EDDBB7
      9F98CAA11AD7725CC84B49C24777919BEE731D391283088F7139E1B61CF29BB6
      E12CCBA227E3013F70106C7D8E377598C8CB7A6E74609AE338FCB24422ECBB95
      3E012FB0FBE3B3DD9FEE621EB96C8CB516463B7D23CA93B8BC854E40274D3331
      974A89EA6E5F1ACC5FED1A8993683F7C6550CAFA9F6848C0EE0F0B17BF9218C3
      429061FD0397ACB7E6539FF8A7EEDF946996A5A30D1ECBF0C0C2E35E7CBFBBFB
      24EA7EBC38EAFFB05E4F73890560B43B37F64E05ACCDE1CA8ACBD5CEE9EEEEAB
      DDDDCFA1323A685249F92AFA450D299D94C1F9C587E3776FCE3FEBABDD6B7454
      58A461C4D1B24D681241ADE291A70348A4A6A8DBD84CFB5DFC31E4ACBF5B3A1D
      75690B58E33B779D131758C36DD57C8FA0F67ACA17710A851222F4A1BB8DE6E6
      F9F2B9094EDCA49A7E46152E97D4D225B7E7D5DE8F473F3C7B7D74B4F3506D3C
      D810DEA5D1735A70CA2B5B43F55B9C1A1CA3FFF8C73FFEF153233D16476F700D
      DC7B929E3C5DFE2EFB332B6D7B9154F520A966B70C2267EFADE4461DF88EAD1E
      D355C9BA3E57E66A03955A5C09D9E24F3C83B74CAC4C4040C464CFAB51897C54
      C99AB4D82A6836920A354DC96AC7403A024D18B6D7D20DA69DDD8A78AE162A09
      0E07A9B7806A50F0792DC6FFEE53F8566D488977BE8099E4F9AD491650E95828
      EDA947FDDCFB134E887F96CD2FD3BC1AD4DFEA8D1E67789B2F7CAC1E699A8BE0
      7390D5C2651B34209998C11B4A2993F6EFC444952C5607A715F198BFD9A8A3C1
      2BF75A9569A52A2EFED8CCA06904C259D356C2DF2AE72639385A34B74A6A4559
      84378E3439AD0B110AD2DF6101B701D95518FE9301E1FB903ABEF16F9FCA6F4D
      43BC9A425DEFFC70E3DF3F93DF9F4D26E908BEFFC1C93E5EF92A2EC7B09FEC75
      FAE10C6CFCF0E7CD17FBCF4F1FAC87BCD63F7D68C4489E479F3E6CFCE8EFE5D1
      FBF4308A3CDACFE688D3EA327D98EEBF90361684CC377EC04B79C03261F395F6
      F1F1C4A8AF01213AD885A2EC2B79880185463C6ABD81B1136563B3E41A9C3386
      98549B4E04FADBFC1BD50E0C6C3B59FDFE670197479A4142831268486FAC96BF
      AEB243668856B17374515D122BBE3FCC8AD197BB08CA5D1B07D739E4D1982A97
      6B9D8F851F480977CB6175C8817E0F1E6CF3488B5D120730665675777FD3A983
      763968B15209A11775465A6B7E3018F0C54585B34AA72904FC5C29B26AE71641
      76BDFF369070C3F527C844EC75186531E81C41A9DB15EC5B58169B945D907AA8
      A8BBA25AECB8CBCE242D57C554052D454160ADCE602C692FF61414A9D9E9B99D
      D6F3D9915DAB67AE9B77A7279685B62414E4706A8464A349BDEF9169F66DEDB9
      6D4CCF309118F2FD2C2BEB8AD020ECC4EA200422E8A86E525646D6A8DE5776AB
      58297072FDE82CF1CFFFF33F70B4BE247D45DEFEE77FC4938DC1A326909A4036
      6EED75E9D7ADBD926C3FDBD8FA9C664A7A90ECCEBFD31C6AAF0C8BAFB2BBBF0C
      3E87FA90BFFCE3F3EA801C14E179295B849882A59AF7410C682C0930929DDDEA
      E59D54EEF6EB32FB4EB5C9F072F24664D34A5C56A577F44063E87549A940A235
      A29CCB373EFB797DE565777A74F6DB3BBEC78234883C39D44338E1B61F83AA90
      86FCFB7883E43E08467F787EFAD86D12E53C4B681D01F5B5D6CA061D0D4B5DF9
      F392990853484C2E8287ABCA10D19988B3E891EAD31739F7A8979342DA21162C
      45CED0A9B1CCE80833FA68258E1716AFD9F2F90BEAFE1ABB95B45514025B237E
      485BD4EBED5BA914B66611EFAB241B4763EC1EB4DF58B1B23D451CDB3B7E7274
      F4F0BF22D02C5E4517199A557D93253B1A4A72EF0C64EC0E8A4A47CC6076E505
      927134B8BC2A90A1B83EFF45BFE91121B3B14167BD11BCB3AB213D3DA691F127
      3991E46F326C6D3A079A2CE2F20DF5F13E217E8DC1142BA1561B209522E8A270
      E86559871F03F2A1AAC0EA43F550DEC344EBD0493916E4891F8FBDFB44B1CE0D
      DE606569FAF0DA2FC8F83E2DC6AAD1BD596E927E1966593449A49697A64BEB4A
      77AAB54AC9297065A7530D75E26B97051D6E4DFEA96B0C2C3E09EFEE595CAD76
      DF681A5A3DCBBA40A14E09AA5CC5F34C10FF8577EB79EB4953BFF5151A956204
      1016FA920C182602491D975AD595993B1A84E8F1F6B61CB2699CC70C78B9B6D7
      5454B2EFC9882A63BA464F641039B69625D4850D7C0DD6687EB9E3F0295E6A4E
      565C8D0C15C1734AB65C5F245C9855E232B2C27AA1B89B19B170A94534DD77A8
      CC7BA5442A4DE9A8826770AFF92429B0A3D3513AA3AE32E37AA2DD05CD133951
      C46C6C09D23A35139C8C6ACEA18C8FE0315782EBCF679B0E29832A5232CF1824
      3A789E56A2A66351A697292E1275606430D7345425C8A454860F8D1A44B9AD18
      792020A0E53799CAAC7556E52841FA75EB5D75E28637C1F29564501C003016A7
      B3FA66A924BA667E43F85F8C7494A2A4849F6AFDBABE7506C1DD62D972A69841
      4108B755E0E661A74C0BA1108124C53C1FC21B5690E2C9EEEE23AEC329F4B1B5
      2C8CF1F19D79E4C7868BD2D5CAB37A4C02A0C575D8A0AB7B11162759F562A246
      147F814F5BCB212385C4E97516AA1EDC42987A4EED5ABC2E588C3A51CC8197F2
      A9CD09965B738265032127E8005B193DF4DF4F1F1490889F63E3E0E469CDF9E6
      8130754E65797B9344EE8CB58619B14A0FE6D26A277A68E79C5536BAB5091784
      D161F69F4A6907753AD5FBD647D115587812C60E97C11497590178AC72A7F15A
      CFCAB7EBF812DE25ED4555E10AE48D53D5189272134A4819A75FD331CC86C624
      A9DB9A520772BD0236DC0E46AF752D069E1B95EF018C247105FD33D6868E7D12
      A835BBEE8091B44B42065ACE2EC86637972614AEDF7C291D524FE7F181680EF0
      C11F126E083726EB63F88BA5531BB28E9C602B4D0AC92B6D0CCC14A99BEDDAEA
      853770EC2B27E2DD4BF68BAF9F8553A6C8BC98456ECDB64198BB2A740BF6175E
      E19BA116509C1250B8B06320B09764743E1EAFA7C851CA43880EDEDF7EEAA0B6
      065EB7345BDD3114C3FA809DFD6697068341A7519FB26E4D285590B1C4F808FA
      BDA7810AC192EBC7B43755628AEEB134DA3A5546455EE915A21113F30843F55A
      878921B96906C3D219CAEE4930918AD5424E82CB41A104832A55F58A8272329A
      F0EE945A45EBAC0665A1AAA3674E9CC62CA6AE1A07DF613ACCF8629ADFF2BDD0
      2C1CFC756167C4AB67A51718490CE0F9924BB023DA53E344599B5B3010459589
      7193CE19E23211D3C260CF85A31ADC2EDB7D0EF8A15D8A4CF37438AF1D6BC5D7
      34D33BC0C48DD9290A5B70C3D8F12CF88927A5E883BD0295CFB3030019ACA241
      B4477307D7710A1DBDCB06BCE1564F73E959A66958DB62C98A72DF134EFDE687
      47EB39EB1666BB595F85DB78778D616105EC20F170A36B0436430B8114BE7FB8
      888E731483DB0870D4678824E77C866382E0437B4D46DF45FB22F8FF111500F5
      DF07301E5635B3FF61BFD54FEA581A072C68E4FC2A9DD4DF49CF8DC61C1B5E2E
      2ABA7294F028A3D1A75F4E2712BD905174F62C9B2670B0F4316BBD8126F607B4
      F0C3BEBDCA388181D51CF4037EB60E8108E32CECE1A212AE0D4F105A0934BE7C
      5A49431045F0236A2E07A35149233DC9B1BD4ED575F4A311843C25A8791D2399
      C2148656C31DF1E8AA492FF16A36401CB7D4DA7528609FC9C5B6D821BB19E834
      8B1D02174F7133EDB10B1FB8CD28A81959705BEA0148E4A61F1949A2A973C6AA
      551C8486B3BE5D5BE7C5BC1C21CB6FAF7D06B71B931BD9A1011E3E68722635C6
      2183A0DEA8A8CC07631B8CABBEACB04F0312309BD6DE594F961F589BBEEA5151
      0EA53F7D6C8CF0DD5CE45080B3105549F37BCCA44883462767D22480387DF560
      AF85FB2914E0F563AA415547935E188F961DE992626C9C03285E18F00C91DDB2
      5D5E3EC53BBD7C1ABE53928FE3EA8AEFA485BBFB6D6E415312D0018F53607325
      ECA238CB065BB598E6D16B446151EB136BB0C8AB64346F443E750DC23E41E881
      8AF2B1FC6A10EDE5372EA2E2A2648CEBB6075D69EC70B26D65A8DFBBF8249A0F
      B73EC964F46E7910A5059D29EE0A62C9A39C6230EB2FDFC8F8AEB7FC7102DA91
      208501785FD07C53FB461829EE06A13C33AF37D0A201F9ABB836BFEAF6354B97
      AE16DBD4716B826790E480C2216964363E9729082D31E36AED756BB625CD3F8A
      0C714AE10527E57687FBFB869DFB4EED5C65DB38BBC05DBE029569E65728CA10
      9EEEEDBFE943BAD046AC3CB2DE8A3A6EDA6376D45DFCC4B91865BBB1DDAFCD51
      AF687643E443A425D464CED2D9B060BD0F67FFF3ACA139ACE7877EF71DA966EB
      4A372DB594174D5E06227BCB1C0127D0E283B40BCEC06DC66950A305A2FC92FA
      332DC62C1AA919AC8DC330B0FE37D0D7E4AB193A12340A9FB70D68041EAF93B9
      6C4467EB32BDBC646CDE1C833CB906B8474BCB3D9CB64B53AD5374D19685D157
      780BAD61580934B4BFCBF16E51D61A390FDE285C9262E61EB681CC1837B725B6
      059E1FF0CED03875C3A331E8B5079E903884752F24464BCA300247CE7C96AB24
      5BEDE29C01605E1820AFE27BEBD8C877247185B66053447F9D3FA4E00EADA3E5
      CDAB9CF6309130184CF5DBCC714D61D5489F68D834E4DA971A322B213E0D4C6D
      0464EDC182C21EAA3C0482D9F5B30A3709385DD46164EA1624A9C5D25F56AA7E
      BDC2E202FB48056EA5F0CDEDF8B41A6518582B6EA7F782B708EDE8E482681F82
      F06A44BBB011E46B02FA7749D5CE92DF670AC4770CFAF4BBCF4203AFF0036F3B
      C80149B991C13C7AB9EC941063966EF19220F6ED434A4AAA79EB0F339A79D411
      A22BBDE634FF63473584E4169679FB1A5E77F18631C3FACA72FDF242F080D211
      C542686EFFC3FE0657AC0AD42D59016E585CF782A88A75F09686D1E77075ACC7
      83373174AE8A828D89B1D188F18828B6D69BD23E115571068103558CDE15B224
      EE46B6C08BCB3825E3B5AAB5ADEF375717AE5404D8AF0388D06327FE4A71A365
      80435C2D3EB9FB6DE70ED2BF73C844B49FD1D99C3975CB0304B1A3F671DF9F14
      3E93F0976F9FED2556D3A8BE1F44FB8AB14978894E9325A2F3CA1585900ABA78
      B292F3E8E97A1EDBED7DE3F5E1D26EFC3CB4D4EC97C6662418B3301AE121738B
      4DDA731488C6CD668DD207C59B4B3263107388871BBCACD0B815BB5F7C498AF4
      6AE148435597BC0695A74933810FEBAC69ABA6B92C4AB2749498A42BCEFC5D0A
      2F582E8F90A27F3165EDCFDE07F103D659B72385BEB8EC977EB6BA2EF2BAEA52
      68847E021EF6C6E46B4B0F2693C29C4A6E2028E22F4E030AA70C501EB44CEA79
      296960925E0C7BB872494CCE0E8AAB685CC6972E575F768CCB026A14F053FB49
      4518932C730B9E8F2A51892F5C7E760DCA5D472685562F341EE8AC2C8619CA87
      394FC606780DE6CEEA1D9C262FA2BE6ABEDAE0390746CD15D56427BD64C5CC93
      D41630230D19954A745F93CC51706D41E86D67BC0078F1A1FC3BAF3F63E9DF65
      B1DB11E7C4A04C6E6ABD788C813B4E52010572844E600FB3B25D18A0C679C4AF
      494E9B15225CD5E05B25C84AB486D8C85EA6F11A473952AE9B9C17307D2C745F
      11D04A45C9DAF5CD0304ECCCBA1AB96A058DE24A2FFE90C114E868B95C179064
      24B8652C2DF7451154D3FA8C4216313925C168EF70B392A22D04154530D6C5F1
      96CB3C845433355F687605CF97122DC67C6BB0B844DE2CE0DBEB1755476C3A2B
      4A68C73AFEEB752C5E2514578CA508441AC4761A4E2CCF244E377E44693565F6
      D9F1821804829BC9B4286FACF4DC32B5D4E610F43964077C2394A3A85A65B340
      8F2C2CE5ACEBFEF557155266F4BE17B9CFC7D9A8EA45FBFBD54E038646D29800
      AE4BFA77A7EEBD8A9198D61B2283B03742966CD061C78A6BA0821B7441C06706
      88511F51A596FD6B2D37945715E83C07E2F03197223E6FD3BCEE446542FDB2CA
      1FD21D1A7278AF8EDA766B8D8A650FC65251ABBA55CEB78B3AA5AED60B7340AD
      8AB342CCC050E7FA3463A852F7562C9627BB56DD268A23C8AF14A81B8AEA566E
      678BA332CFE53749D42C360ABBA3F28B545B52B80D7CB5E25AF9CCC064FCA6D3
      6FAE8E6B1B3A4F66083AE5599DB225C0472305BCCD60DAFCB9BFFC039933BE09
      A4CD5AAD3A65643FF9DE0AF6E80E4E5151A1C2FA428D5858A04893A13B87FEE5
      45F1AFC4FDD88DF01D2F2A785062485A78C7979F2DF2C512A50B377DA7F598EE
      EB221BEFD86F3BBA88DAB1F1AE2E26A1A394F335CA7EB7E65BE89168BC560D2F
      4C6F7F274D7E569A2BA331C65545300C7DBF43CD52C5F1D2BC69516D9CB8B4CC
      1C13B53CBC5F8C0D23BCC8BE8816AA7024DEE818B477A4C4394577890FEFF4A2
      A3AC88C113465E1C0780AAF2F281D4D9E55DEB9E254446A671A830DBBAFC171C
      1FB6B497754E75EC45830661E8685C1633A1A3602793913C2B985A10671644ED
      26746B68CC68F5D3C026BF9A5F2241A2EB0C4A06EF84DB1C5FE6693D1F273B70
      8C601FDC610E656518CE8876D7F91F4B7E127555E47378B374869BD42FDA8381
      E0FF8ECE39724EAA48B2D8A0E521A418DA14C33289BF28B3D24ADED2663B1273
      382E7D7500B839772B21442BA24E56D2A2F63803BE6011CC1063B45B1E843C25
      34E6475769B2EE04EE48175AD4715757FCA4A892B2EA84DE99A40E02BE58F9D3
      4A526E4D8EAE91ADF0CBA8B6AFA1814A5C51FFC76356241CC5D945714AFBE4EF
      695ED92F7A91FF353E0FFF5B9EB616B17DD6EC3B01CDA05E73E818D96DC63011
      4E4FEEABC507445DE716F972833B81934503A5525D8C20FAA289062ED7C2FDA0
      671A8DB45BA5A060B309DEFE8DC2DFB6C835E2AFD626A6C75DF6AA5713125229
      44E155E3F417C5BC1EA12EBA3181F2627C4B15C876F372DAC94D2985812C8745
      9EE1F438ACD2058AA23C422494A7A96789341D4A9FEB625F906C8AA0A4C4B88C
      BD4FE6764BF0522A2CA33A665234C3A786E89718E4C8921859152A4D84216A94
      8CE0AFA4FB4675471E88BA046EE610AE33F956E79FF1D96BF6A56ADBF8D9D379
      EBDDCA344EABA8330145861A7E9DA8AB721C6EEBAAB02FF29682E2D4E615E9DC
      D831E6A6D278BE0510F3BA17CCBDA38B6A6132484D06430D0961D7698B1CFB0C
      795B78288929555CEA723EAAE790F93233B64BC44B736EC202CC0430C58FF214
      5F6DD76AA0B6167A2C9348363D4DDDAA2E0ADE194CB698E39C33702DBAF06957
      2008CC111F4684C9EC66C39C298AA6BB79D99C406A3216D56F5A50D2D9C6B4D2
      985ABF14F4BC0956E8BEAE507A0FC937708730D241F280781A728272064E9278
      527564363A7F9BE38EE457ECF8148C4CCE9506BC6120F2DA93B5F3FA267A1D57
      C9074E5447A9CC74CB86C537AF48CCE3CCE2E501C22A288CAB4D33A4C0A1C760
      BB7F15056915F4DE3F3C39C10C22CFCF6A0ECB577736D95CADCE7952782FFAAE
      17F5659CFE0C21E3AA9D94A7A84CD4117811B045A7E7FEEB5D912736CCC7F957
      18122E32D4599F5C2B392C4141553BF6AD9CB82C0273112DCA6B7BCC724B829D
      6A9AB08C0459DE88C694A8C7131B1146CB335A1ABE4E9763B9909EC32FAA13EA
      2AAE8D5DBB2DA60A81231F619616EFE229C5A32BC592372CA918060FDD201A99
      6175266E95C00030986F98F0060482620F8CB30D354142096F2B5BBDE44D5C82
      A9D630748A58C31BE9E71AB0D758AD603F927187C842C735D5214C68E9DA5248
      ABE721C618B552AA2B81821CCE6CE06C980928377A08C228AE5F15723908F25D
      97E9E80BAABD55223CE1FC0C5C9605D539C5DDAB13544BB4362156BC3EB9F44C
      F6F7B25174D36C258917EB8BFB93D33DE2F13CF78FB333C6BF9DA00F8BA6E246
      38FCBEEA8D8B74A525722EEFBDAB3789F5C890B5D4EC9E4B5AEE6465F56ED38C
      8FA5043854C9A0864C2B075112170695FAF6082BC4439EADC8CB17C597BBBBDD
      1DBD56204553B1D0432750B55B19465A2C7F4950560ED64999C0D3B4F4F1B095
      E0F8B37606D16B4DE5B6C45CDEFF058189D3BDF38BA89A0FDDCC3AD437303E34
      4EC9E7D2ED850EA5555C730C565125972B9C871B045C256EA12A77C6F898E752
      AF0B380BA6876B08376822F60DE8BD691EE5CCE9DCE1F8CF92420ADD921AE584
      19509A239999AD12E7A64D257EBF5681C39CBABA996155D00DCA77FAD3DDD792
      36AB0796AC82F0668CD54563362CC34B56B9E6E8C76364746A4618F82F56BE20
      893A7BE3B13E208C15DE9135B2AC514E78D26E9744DB4A9418AC3AA54BC557CB
      432AF139DBC1E567D983F2E8B77952B902BFEE55687A6DF632AB2D26122A7CBC
      C356BD9145C3C5CF844DABEC40DAB15DCC8D7815D176F9217F279188DC6793D7
      45D43FFE392FAEFF7E15D7C7D38322CD2F07D17B5081B402A62B38D190CCC629
      A5A12E5529D2C4B59C796BCE641B17118A1544D77802FF826AA56CE5AE058305
      3594654557AC2A786DC96D641E9AA925AD4639FCE2E3112EAA5D0AF1F994EC80
      C083D3793572728E32346E112C4548C2AF445DAE4A64162D5EB03B1DB76699F3
      6D2B8A0C04BCE96AA67C7B452EED4CE33B30A53FE8C6A14744CB56FF78CFDE20
      DFE85980A2A841A801DE688A629A13EF9560BDF133724924B6A3C556A59E07D2
      3CFDDECD129C8E8A03AAD3902789E210437F38622993D834168D7B93DE0CA56F
      52969EC5352FC17DB56577F4D346115043B6B75062124F2C947D0538BC9A6DA1
      81FC5B7E69607C8B04B481DC01B27FCCEF1434E1F0FC942A70B2AF7CD915C9BD
      F0B269822EF3200DA0827B95067F4F8BF44332897E797FF2EF1F5EEDF2FF9E3C
      FF8C0137E8C1676E79D9CE6F2B4323FEB15DCDDCB207B30C3711DF258FC7EB84
      4DB81C8820102C285A90F0A70A0671162861CA62F20B715DEDA4509C23345AEB
      12BE13BAF5C12EA9314467DA0E046775A905BD62ECDF5A77076341B192CA36CC
      3A377FD94F83C89FEE3AC2E812876D30A9D451150237E583A7C3844062607225
      DFD624812E58F88DAA48E3B88EED9A0FABE72661FD8038FAF5BFDEC4D3040923
      BFFEF7C0BF95A528F2F586C98A4EAD18DF8B74B6F180F2BB8A28B5CB992C1DD8
      9A87339C6A532A323B6D1AA3B3C506DEA36BD81FAEA6E06699113432B9E7F134
      7C1912C2C200599CBCBB8F91718AF65D7A4F912F3B51567A5A925A743B734E93
      3CD99499678CB15AA55AF08B2579D03E73908BA2DEAD24A4D59E9FD279BEDB6F
      35ECCB30C8F9A06D3D63FD10B4BEF9B8FDF229296F3E474B30BC6A3BA253B37F
      9E45B3520CBDFF1BDAC7B2F522467D459982C4AAE5BA984D84D1D155A4CE0674
      8E34718428DAD250931738822A04F91030E7617C92E7AD7CBEA74E3BD557CD32
      FCD11013A442EB9E5FF9C288D32E7D698BE5100F162C69F105C39A2B64213764
      EA03AD6F07B584E4D646565F80D299F05F3A1109C4B412F5C3069B6CA7D7C0E6
      E9FA5105CC712D1A7420A378D991DDAA6812487D58CA95A8B75ABFAD780D2156
      518DD3886255C7F5BCDA78A1CB0AFF05349BCF0279FFE1EB9B8E865BD7814CB1
      55110B7406428DD30539D7B094C7D260D322CFD9AA4B58106E414F21871A3EB7
      C8C75CE414F85FA660E4CC060DC776D4E6EFB810ABF7EB3B9ED0899E5A48E1B6
      B607EB470EEF62A3B76483D097963DDD8B3E1E7CE89947727C71DA89AAE4B739
      117D9A3633B1B79E89767FFBF4502A8AF3F465AA80B521A42BF05B5399ACF3FA
      ECFCFCF1C9D9D9850BA4441F1260AF8D78CACA9794B5296E95044E9A1CF57999
      E39299449D73CA7E461215A93A740593DCA113A469C0A377A47967D71C5F9CB6
      0BD68AEA3255AE3AC7115CF908BE7C74FC681AD19DD7300E1A313CC74827D175
      5C5228710DAC8C7018465DB0688911CAB16E8375105FA38C4F39269B8FB936EE
      46AD8A394415D2320740958D99912D697FCE8BD34C703B79344C870D9083BE16
      A555357785E54D2C3D00F19F0D9E0E9E68E2B743349750E317109749FACDBCA0
      6A9E18A2A25E01BC3D53F509EE1F4414C3EC114772D240BB51A1BCBCD4E2B965
      4A434549A489A113478D32CFD534D8644D938B1D705025980E7A3C5122DD42A8
      B7A841F52693607D1985661438ECB9AC6A0711CECA623C1F11944C273C522453
      89B78147CC3171D338873F3D4DEAAB628CCBC9295DBB48BB1E7D18D9E0CF01D7
      FCE381942B5068EFF8E2F40ECC30949479943F3A00EB8975158B8693B7315BEC
      780941CC220BED08CFADC665A37500AD6142816A6151E6BB717E01B4616532B0
      07CC32A5B19F33CEB2F9609C42E500977C598F702F4381FADFE6D3597451B8F2
      CC1B8F88291889F0F732FE9CBE914E25D5BC5C6B961779573FF55DFC15B5C9AE
      A09DEC60C1BB166FE9213415F3BA4EC6AE461BFE098E17D85DEACE044661F21B
      16B2651B9BDE659829EB9EA9277798F2E1DCA75CFBEFAB9EC869AC4D231589F1
      A071F2CD871E841E493549DD6F83A8FBC1E2440B178A9C1FB87110889D4C063B
      48F5443BFB3F1323E2728B8729A34BD5D57C3261C99F58542FE5DC08F44E5AE9
      1AADCEB6AAE49609293C38DD55783A8819347E6EB54A951B7499B3A20FA35369
      0E3E8920EC797013BEDBFB742AB720178FB7F04436B7175D028A212E3D9EBBAA
      80DEDC9C97135C3E480814DA0DD558EF5CFCA727251ECB14B5158A096257753A
      D211D255C0EB8BA87C58AF14DF4CBE45A3A228C7694E5E6970A607DFD04A93AB
      7AF6613106E8D101DD1E02CC336214976301F21A3166AE7C5B946B2245CBE3D9
      E271DB2970D1DC041C12CE5A7758D42046EA3E686D9686BC74B011830195ADBA
      8326FF8953C405F01CE14CBF17446A7A226A46E610DF54D9AC77C0240D7DB99A
      D764CDAA3FC11729E7108DDF0066757AAC8150A923434A38D3A508E3174815F1
      AC0CF6A0177C88D8A03C2F144B6BD1DB916E55A697574033CA1C56B5BBC05DE7
      15C890E7BACC626DAF8173AA9C8C56BD4FA2B39F61B5D76D52054414D7936D72
      116F88AEC0A9CF5DE116CBBFD1A07530EABD151D15052B371B4B6C245CC3693E
      BF53D4C9A50CD60562441B6442865FF751120C376BAA018C0B959CDE1E5F9C1E
      560649EB87CC1E3F3E88DE1E5FC261BE8041A581BF43398477A26102B5A9751B
      D5CDB5158D50DF82617E268474796CC7A3B2A8A044502DD1F3593D4022CC394E
      B23A162968B1FDD60DD75ED4097E4307CB898D28462BAB40937F1A84301E70B6
      7386497D4D2EE375E1E903507A17BB6813D794475A4F2B4F06F568E129959282
      D5394DC09B27BCAABEF100D42C84332572D46E3EF4FB035BD9BF746F417B76B1
      0D63A74A1658E9CCC470BC1D8F4A504BD3FA6F6A36B5A4C6F197A7F978F99757
      4399BEA870D809619204C2D6F25AAD1D6162A421DF0C0E42D00D376E4250B2A9
      58B9D0FC468BAB2F412196A46CBF20CDB06062DA0A576234198D35686CA39DC6
      F9648C148186D98DA32D34BAE2E68B0109D987BD60190419F30448A4B4DE9C77
      A25326EAFE353AE4063E1F9505528B4599832A1DFE5BDC2D288AF826197D41E8
      A5968528F77FF07AD0E75DEB178E8A198127A91F6DEFEBA5E08257E0308BBB17
      574B56013916345C5C7EA569193597430B400343C74401110BB56F3ABD5AE9A2
      13760EF4175559B4D1B8517452077D755B2F511A2E7B7C71EACB32ECF853078B
      E6BA68967262C2AD08BF3A1F7CD3B5C49166405B2CF4C626C3ED709723F16AF1
      5CDA709B8B958726A653C97260330B674FA58C4E8CB81AE292E0AAD8909D166B
      E24E27CE366BDFA1E165150CAE9640DAE8FE6A5306033D3B48882373B78E7312
      BEF5E86EBDA2240534B4B09AB78BFC1428905CD3CE1AD2F0DCEAEC2D103C2BD1
      7AE6349E16E33D0EE869317EADC0BBA893D4EFD1A5BDD703F9CE6551BB0020BE
      85275CE34D486EBC04960844085180F0D74EA27093DEE9B9DB1C93708161C372
      6B06DB511476F6F4862B13895ACAFA3069FE57FA95033C577A46AAFAEB5EEB5D
      377346B48240E8935CE2986521B7C67E49F3B04D978268FCAF15FBABC19CD6F3
      CAC6BFF5EA86C826D419E90F6FFA2E62CC134E52EC444349C64906B0F5B9DD51
      FEF3D63AF83B7C6DA6AA6B04114BAF7D0EB805D5186B1EA2CA71516118205170
      53F1409E5CE140C1CBDB786256DFD7A154BBE3CFCF4B3A054CFFD6B46AC0274C
      EC9073137FE96ADA7C31AF39A2BAA8DAA7CDCE92CA39A4BAB9DAF60E14C563D7
      1FC98800F87CC879954CE6196BF6C4D8FA126B746111D1B20D9EAF9888E97F9A
      8C53E35DD5FAF7686AA0126ACC39338AB426217979C5654200102C10CEBC5D60
      ADA77328DD406A2DA2707CF47C17188BA93BFA681F2F6B0E5AD43D8D1DFB4F9C
      332B081B18E07A8C8609EA3E4C1A9C245512BCBBAB2A635C2E35CDAC44D060F3
      52D8663C4D586DCDD3E9036EAC3799564A4BE24196EAE31E8327371E111633ED
      01314CBFC619232E05876D93262495A96DC9B58B66437B18CBC00582AC148263
      0E55F354B044236A415AF94B635B366B09E0716E918522CD6AB33230B3F1D0BF
      263840D08FA529DE26D9AC17BD4BBECDABD30239D06FD2FAED7CD8437012872D
      257ADFC77599C0FD8F2F57EB48D8D36FCB3D6C411FEED647E4E63ACDC788724B
      C7B693DCC5DB40BCDCAB6F729897B06C367DA21B19559DF6FF8DC1F04F47D529
      605AAED0705CF31290803D227D5E6FC491FDAD28545C6DD73999ABA82F778E2B
      4DC19A3D022BD488588E21EE53CC98921D5C8AD66F0FF0492C51626E5B764997
      8D8E96BCB37D5625E5579C8A1F9238EBF3381B31DB9136340F26F9BEA4F9E176
      D49E83101C1D82D681500BCCBF2443D2CF765DB4D5DC8F0EB32951A972EFE3A3
      AAB1CA8365836A49A59D2E92335315D99CC50801AC4986BE8F1517F925E2BBD1
      64CE1283E1E0DBA06FBE5D55DD910C8D8D852665596C985BD00C871BFDD7F2EE
      963AEEF9062DB86CDF30E2E16FADCE0119BEBE115DCA62BB1971766D169E99F3
      8D4A52BDB6864A5303DA4BA8689B8A979A06D55D6A9AE959F07B0EF5468DDC75
      B4FD29F6870EB86F76F5982FB4EBCE4E6029702FA7695EF861EA3251FCF96077
      F0AD173D1F3CC5FF0C0603589C5A7DA9724423B308059AE329D43541FDD40C75
      95F0D17775FC28B7F205DB66E1E120F15618ECAD697009279A097A0728D70EA4
      329922F0583606793594DBD6107289A157E9E555C62B187DB216643AD6CD0279
      0C327194CD4AA985A4E3C9961469700B0F52982286E4906FBAB94AA265E14159
      F74CBA5E9FB90CFA0CADA412AB07F57BF2A2743CFB56FEAF156D73DD4B037478
      96216EC509B251C0F32C78352E1005E49FFDAA85B59E94D33897EBBBFDFC95DD
      D7E41D8B5CDB85E235E4828B62101DC9E5210B9038861A9E4805A954E907F6A6
      EB6F324BA05E236B4DE4FC1069D16BCB815ED34272F08022CDF3B4BEB90B0D98
      1487EB748CBAEDA0DCAE9BAEC55F445DD9601C37686B2ED3D55C109D3463D28A
      E4AE53D6CF326D5A2DD118E7453A9D4FB52BC524BA8A33C59F3506AB7F6A903D
      75CBAE6ECCC9685A6AB59214B6B360CFAD3B5211C848B196D566D5CE37E97573
      F85D612AB5529DFA07D115496617615B49CCA493EFBD3F815EB67AA5A394A9F7
      6A12D629AA262B5DA61BD2BA777CB257F3F52CF40337C1D50EA1FB0FEE876C44
      ADE6368EE229A5B3FDD8593A221BAC5248822D10386D5094F6A1AE08E156FC62
      FBF7BEC0DA9617774B4FA80F9EECBCBC2B040C45F4831BC47B0D4EEC238FAA51
      992479E30DD98C2C420744365A10C63163140B91D7BBBCDAF91408621F08D410
      9409F52ADC5B939321533FF8DD07406F2756D3F60D05AB806A2F8992BB47592A
      2513820E35748EF3859F6A4C7ED5EAA59A7959F054474219A08DAB729E7F4155
      57A7E0620FC5BB059934ABBAF470F3BB32D3085DC90BCFCA21F38F259BCBE27A
      ED59DF59F3FBF6252D6554C78F9DF1D4102C582D44BC01958151E3ED8EE063D4
      2E94E2F0A271EBE51B24AF6C9C56146900431C315C68F02A4DC06972E1C01316
      3DDEE07592A797B9FF6B81802B0C7D4CE37D6AA8B1CA1E768DD1DC6FEDABA1EA
      921A2F559DB5F33BBD609ED825F9AD965053E2C6D61D5C50710F321B371CBF53
      93B483811DAEB1B503B93EF393966292C59A88CACC1FE62335F6918B5BDC31EF
      A9A1288FDA17613B9F5C3BCB12A27C0E8931F58637B4A8A75532EADCA62CAF73
      F7FDEE7A005D79E77226B22F22FA45C39ECC1F9142421AF092919048FD62BFC5
      1B1BDE44572AA0CC3D2D453483AA9B5F921B0AEC72EC9D9A87785CBAE9A54F06
      E13B1B279E32970E5F4A17B0CF56244F95A6A1D15C44BB66B2CB2B3B5D08424D
      A81A671CA5A62E812977D979EBC4206DB7C9D83022CBA1D926F9782FC30911E3
      FF4B59EBB28C6F1CF77CF3AA05EB1EB4B222018446373D5C7B108F55C01D4D54
      3AF1FB452E2A06D58E2F4D81DEACB5DAD3CB9C301901FDDA8404FED7CA1F0924
      F02D06D3B6E7329B1818E178009BD059E211132645A19A320B0468B5B7956946
      7B51F43A8A5EAF44BFA3683F8AF656C66E57FD51AB90D830D830872A20E8F2A6
      1D5ED3D5756FB3FA3DA2D5AF0276AEAC0ADA536929CC99AE71204333EAAF8DE4
      4E5D34F4DBBAB2BE76706674750DED6848414D7559DD54E7E752248976D9625B
      B109356311DB9A27CEC506E7FA59285B1A0F7B81C65CC39244F52BCB651FC61A
      B733F1C60DDCCB6364D62C91481ADE4805BD381F3F46BF11345E5FA731482CA4
      D9F005E2358166A489BD698E83A40B625C24DADD0816C8B4E266C71542331D46
      BEC8BDD0612B8AB5A9CD323CB0B3DC5DCC3EF1CAB84AB37199E4BD082F0F011D
      89BE4B939000D28F7113C84B50B92348D25847C8BC284C5393A2721EB8FA92DC
      48A6F3BCDAD28A446EF13B2CC7FFCB01B4F9D229409AD7768FADB3EF3ED91339
      EBF77EA493D3057DFB95EB69FF275B5CFD9F7C63FD9F9A52BD5BB51854D47E25
      3687357ACB7BA177B737BB814A8D1600915926EF57096E8DA7AE3E4F09129F62
      977F9C3D46DFA32E3C941D940827D7DE6A86EB1F6D0D114C760B8C2E20A591E0
      1FD6F14D58EC141DD59B7A836A51D0CB715DD002E1B7B78AEA1D22CBA8309B9C
      A3D6DCF21842104430FBE2888F0CAB4BBA04391DCFCE32F572A93BAB79896ADF
      A901EEA8FBCCB11887A62373A5C50A15FF10EF6C2FBBC11051557BDD40E04BB3
      5B477E3D225A0198A56818D2DAB37898486199152B76F16C0E7EDAF5F109BB13
      97AA644B50897849339BC5A002E1DB38DCC4528C381677E5D79449967C05930D
      0C9B00F2691B2D79B01EA403F5CD4CA9A2D8E1FFAFB92F6D6EDCC8B6FC3E11F3
      1FB2391353549BA26A91CB65F97577682DEB595B8BAA2ABFB11D1D20094AE822
      011A004BA58E9EFF3E71CEBD3791A0A80D50BF687F70942412482472B979EF59
      C64C54533BDFC3A898A98688A354819FFE1E541719DA8574EDC6FA088E819216
      1583EA25E684D6D0F9652F8EE7BF89BC45A02DB081681AF08A8710F30C860342
      6474EB92DDDA3555F5D45FBB32CF118CE312041631B0CFEFD75452A2C0B38704
      580DBD556C55D34A91FB747EB4C788C89DEF1F9C57BFC7A7D68C245909260711
      0089C5CAA4C51E7DAB2F393CFB4F5310B4F2B7166824D12AEB81A9C2C8C250AC
      BA63C0EC95B77C3F3D0CBB8A88D81A7B98D3C54E789650473D0C1809DF024B2E
      1A64453CE2C56AC64F32086EA960C09ACA0BAD6AD27D94CF8A5820177A204CB1
      424E67B6FCC50A6B1F4D93F2C675453DD3E47378AA16C684954BF18EF38C58B9
      DD9FD6087FC3F05CA5A84E062326633CDE7A3C05E530FD3B94F240A129C2A63E
      34A1EEFDE2231CCB14A38558F01EE12B3D610462EA2A3FA51963D8152DF9E189
      D573E6470F772B34351897DD3FF931140A72E038EA550FEB2A5602DB67104CE4
      9F7AED422B082C44D660B469F33C9E24B7CC0F978E249A4B004F73F9D4000F46
      F35F070A47B6DF211EE1704F361C2C3795D69DAED358F0436B6CB5D0B025541D
      47565B80ADD8529864C18DBC12E14D5C56BCECAAD76B1A8F2244410C5EB55AA9
      E16819DF8F14FD24520A5B72FEA979689F9C5E98E31324696A4A4A7A1E9A2958
      AD3A15E9FB909F12935A0365F309142DDD25464B1B8FEB0A14EA4B9CAB7C40B5
      57DC3B6D6E7FAF53B17BC34497B15F4469F8CE76F80DEA5122BA27012D084263
      B54EC6CBB686A19F2B76499895F120D75AF7EAE2FB1858C2CA2EF812817A2A8A
      AF140C97CACEED36D46EA7441AD50E5FADB9CD94F1885D55D3FDAD54B5AD25B0
      48E4D8335F3860AC2F13E3928CAEB24488CF9DFF823E8470805506E624F3BF78
      4C1F68EC5355006E536DAC0B563E54081379E0E9744B6678634A17B51E64325F
      BF76BB194CE8E0F3F7BF88D02C8F67A34704FCB22C137FB7BC89F4C8CAAD856B
      18FF4F9A86AB5C1355822460CA499E62C9457A12460DE628224FAAAFA5FA820A
      E5E9A4994E973B4A4DBD2A411DB98E34225084BADDF5D6955253FFA811C1AE46
      0412E0D4E3896C027902F422238F4825B0C29EF535BDD90290D327A4DE845BA4
      5B3EE8B618F0FB83A3CEE3C5E321B257DCDAB8F90AFD06F767F7BF0F0E0E84B7
      53C219504EA6550840932B0AAD07DBE27FFC895FA3423717854904D7B110365F
      66E883F4A6667CA1A3F8119CAE7FCBDDE9DCF4B6FD3BC9B3D9C3646B2D28A9F9
      7565D2684F555C4550C5C024F051657084BC3FF6E37A78D758F9F7ECE2FBE576
      2B0BBD48CC2D3073C976F62125B53728416E9E27E1EA25EBB2BCA927D5F9DF53
      EB5EC46303234E74E6E9C9F6B1CF8EDDF734EB07C9D733AC1D4509F5AF8DF593
      ACFE1BBCAF75C9ABE3A2F201FB29BCAD29BA88023F01204194EF150398E3409F
      CF8486ADB86892B166FB83E364F23420DB349A4B6C7C622AB996C9BF3FD20924
      75ED0B2A254098D92FEBBFB9E26636CCA6954F4A00481CC98D65C579C098409A
      286AF9F1D7B94ACBFB3ABF9C7102197CD94F2DF3C2958EB2744A9F932A2A3DAA
      6C3FE7BA061F4E894970CACDF2CB8C36D4B5A234EE8BBCBE0711EAF8A4C077C6
      D148FB10ACFD79DF7525D4D73C8F29E9A8251C77292CB3636F56A492CF555EC8
      3421E50FF64D0300B3F49304CE2B5EE74B2EB8CC435A91B3B1ECA21D8425C148
      40AB17EC58A760C724CFB4D2ACE65AAA78612FD25E8ED0C8975F07335F950ECC
      B2A48CD9E4852F0BDBD0745A2967F3A3D015F1574138899589926096D6404E53
      8F76E35B2FCF185DCB68BEC7A8CA848748EF89C6E7B23E08B8DD324E0385343F
      204923AA7F5F3E1C7EDDF7EA8A0B90576977D069A19F9779C16B7683D4B1BE5C
      85722BAA50B005E8E115F7F09DCD6B09FA4FEC924511BE760D7B8EFBFBB0AEE9
      EF4798263F7F59FFADA795AB907F59F5AC9FFB92151F8B71E2F265C67141094B
      F52FD7ECEF4B39D687A556E6AA24C750AC84E5E8D11CA96C850B99A81FA199E1
      FDDDAA526E60BAA4D57B34BB4E971579B1ECFA0940F8132479242C73B2F7065A
      EB0F02D3EADFEEF86977DBA9C44AB515682A0143EEEBC39008338500A12A1037
      95D1F317CEEABA1666CC054DD31C9684AC3D22FEA08607DFB8574F2966578FA3
      DB1A17842A35661AA10FF59CDFE13CFCC0EBD086773185B1E04814A4E18A5BCE
      58775886DC25AF2EE09A1AEAA8F235261E427998B53669E6CD8E4899AD4D941B
      AD9A476B50DA812D5F017F7EB219C6D84DE278CCCD5033649C6D3E43762F8A72
      6FE537402A496445ABFCD3427FA45067BEA74553FA6F9001C38308526690EE0A
      DDC23462E9882FD12FFE86BFA9D1A67CC5632DD24C8B33F617BFFD4E331E31D5
      64D91C9A8D262F4DAB4943413C27D4C6D761A1A0EB51B4E499108AA43DAA6845
      D4A670F0F480673A2558F797BB170150202590591152A726CE75C54D51C633A4
      2A1F3F20D631DF994E05D382431594541FF93E34F7AAEF07062F9650F3D3F096
      218A6599D2B12AAC9962B797F7260E19A75759E66BC9E640DC9AC12137A4E233
      D4E7F56E742D0CEEC7D0658584762512EEAD0E9F70428966F111740C3720EA87
      DA0D7EBA1F9C157CD012141891079B837D5BD5CDB9F4E15C1AD4FD35C951D4F8
      D6D41854B141A3A419B14C333A15575F7F0106B020D3AABF87A66DC68F5A0AB6
      CCE0BAEA8DFB01D29DB3A8BCEA1063645E9F95B28215C030C31E766FB35B43D8
      56EA92B6EEAC58CDCD5D2E49F549EF243C060517BFB30496C28F3598AB677F6A
      7C6A8142FBF3230700DE18CA07729227034619E9B29E89DCA2556448BB7A4076
      9953135FA3D666353D97819508A051C58C8B60367BDACD12EBE1D6DB4ED24A17
      5C85AB55211A342F79AD3BD1E833B28F3484A1D5DA53B300B70DEB6A02AEAAC6
      FDF57EAAD7B65A98577AA0ABAF11ACB3E67F119C2643BD4CD3C2AC341DF89A1E
      8AB5998913F98FD0F5D29B1B898F5790A582B5A02976AB7EA946E086D009FE8E
      C2331C90D207E6D0B6243392919BC5684052CCAAB1111454F5AC87B04A51CAD9
      C47BBC85F1F2AA2E82CF9697A0F0A221B7834C114A4AFD297AF988A3637505E0
      A3526122DEB9C27468BDD237550F54A270AD21EFCBAAD45749DC51102751A99D
      E65DE827B0745E278F012E4FBEC49D15FDA48F4600263E5EB88FC7DB7B900F9D
      431C56E4A5D8199D01BDFF3A08AE3ADB8495661367BF144F55660145E92ADC4A
      C9637DD4757AB4BACE5C940F9332471DD37456816184382A2240C4D0C8A03C50
      DB5CADFB0A7BBF2E1E720D4A74C95C6760F0C46128FDE1501560B785174A28BC
      68730316757FC579B97C70984E327F868AC565A92E6BCBBAC815692685BBB9B9
      B9599FCDD6C763F7A188F32DF7D51D426079CBDDA0F360D0EBBAD881A653F7F2
      09C7C50FDC28B10D65F9E11E41B3D3E85255FA45943495FAC603EBC9B2BEF0C6
      C1E9776FDDFEDEE1853D655060C1BA5341C174C78F2AAACA3C4FB25C0B2AA3B9
      372FBA7FABF3891E4927D6159B7947CAFA707385576B4D922D5CB922FD721F1A
      2DB77485D462CC7A2C701EE162E8C5B62D0904936D2AA1FAA793731F29531D5F
      48B353987DEAFE4CBD6A6187723A74F02A7CC3BC338C757792061D5E535AF27D
      B3DC333C0730D15EDD4DA8796A08B32CB9C46F911022914D658FC0D6D512A23C
      7C1C5E1C3F097BCEED9D1ADB12C24765BCC13BA368127D891FC2D9AB60B45F97
      4315A53BAE9C14EE6F6956FE2DC84CCB0C0E00205D8C7E396423AFBB563724B5
      3EA8014AAAA2CFC34FF5F82ED295097548A0DBE8D87A7E8AF5ADCC08719390BC
      8A52BB40BBF5DCF6EE8FE7720AEEB9A3ED93BD9E3B7B7FAE1FA6F435E4D37045
      F0D06D2DCC08ABEDAED5FC420B5947D71E6144F0E1F02EF701ACCBF507C0A521
      05EA1F2408F115A2812F3DE850BA5DB3020F6DC08533C5AAB75466C898430134
      E3E6F38DFBDA73370FD2066A55B30A9C5AC4518E6C0A1954D5CB978744555DB4
      8DEAB812999DEAADC97182EC82C17A44A48F71BC241DEA57D53067C29057C268
      E13EA571A012FBC84D93A7DBE537B472A078DD411D30F50DF441997A5C53F6E0
      F7E77BAECB14143D2F4C0E8FCFAB0B6B9DC7398F73416BF6AA55E98E6EAF1565
      96013D411753BB248842A19696C95D8A4770BF344CB86FBA492DBD1A652CAC26
      7A0F4C0F2F9E82EED753870F1D393E606DA069F6A8E4F71E7F2614D8026DC48A
      2C380E4A2E910151F8027D07CABC178DDC272A3459BD41050A384868246E7D24
      25197B050FF7F2BDDD0BF13DB16D562D9EB208EFAE8860DFB5AA3DD90B570106
      44FE0FBC6A48330BDD5915285B95AE95E9042A12E6AA8A3CCAA744DD8DEF4B5E
      0ADF819CFEC2C13A5CD08807C283E1AEEDDBCC9DBB1A41556F8C1349E5D17246
      B65EFB938D1D359EAEBE2D0B122799CF551BFA2CD0E6147517EB21CC232672F1
      111993B0E0150AA89701D5B96B3829410B9020A575133E31BE80650A7F01818A
      35EFD28B5AD707C71302DD6D3BEE5594621C23567072E98C84248314A2C4E67C
      810480C6940FED01773A3662B82048C7034DB0984E93822CBDDA5154472A8DC0
      27CCB72368BDDD0C593ABC427AC5E634C149312E222ABC2AFE8945911606398E
      48115B95C3BF2D691500E60CD6168994350093BA820A02AC6A9A68FC91DD0021
      31CEB82A02ABAEA844935A96CA2A7A15B393F9DCC59CF5611AADF45D7747101F
      7403ABA1F4031841F5E0B24ECACC57AC481DB8770D8585F9FDB57161004996AE
      9E0B4833F8A8E82ABAAC401AAD1C85F88BECD9D5CA142E6B6C301E0DDB509281
      D9C085450BBDB757835A167249F2B7A261DE51600A9736ED63CBA233EB689716
      AD32C2A7310264E51078007889419ED2BEF188EAD653DC1BC45CCFBB3EA955D3
      AA84EF63002BAC7FDA25C388F691D7B62AF01531EF148E16929A5E620E658061
      3C8AB04B40DC349BC5F4FEF31FACECB5744ECA185D86F6D4CAD84693D12376F2
      554102D556CE8CCBE37BF5E874EF7D25FD7D6F4623CAC95931E1ADDB194BBD16
      32B24462C00D070E3D59FA8747B7875EB093692693659E419B4CE42EE15F44DF
      984CBD58EE5D988FA516A768329A1A59F0AF2FC8BC6DB0298A0DCBD26D35CFD8
      F54B04E2C193E8A436B37CD25A1D5BD81163B0AD2A8F48AB0B0637164780FB53
      48F73CC275CD93261B21CB6765D57A4F21A3A23F56848C47508F91BCFB9CD235
      FDF6CBB8FD2ABC2182492EEF60252CC6916411589516B0F7043045CBCEC24250
      BE5FB9B4DB4AE40D7120478C40E232258088B94E2EE33E8F8A3C902458A2F4A6
      24CB1925737C6698679F65CD14A5BDA8A06AA94C2D3C2096565028B0253EC1F8
      FD5326468B44501C8B5DCD4645ECD2DF607C9D7F482B21C6ED69C2349BFBEB87
      C1C5DA43A7A3A5CCF252258CAE181EB7C4042B65ED86E1A18C63C36E7E34B870
      7F0A6A27D29A2F05FEB43B707F22B64ECB97E1DF8EF0B7A34CF315FCCBDA1D47
      F9E23A59D6DCAFDA683270D5593EEC3E49C5D63BD0BE7107AB09BFD3FE7D3233
      523D992511CCCABE81FD1F69D3B76DEA08A4612FE5E02BCD033958859235D96C
      980DB3AF66A8195C84337D9ACC9272D9C14EAF62DFE5AB4DEFD626105DB028BD
      D19163905CA0711F3EC9D60E1E7E179726B0F019262AB465B73087BD3BB81474
      BDB16BD48B5058DF68D021144AD71DD8E41F27C528CAD1B1F695AA5475FF2ABA
      6C6746794E4871FE773C48F808C25AC8F434E88F7B7AD7F071F425A875982134
      C46ACCBB340BAE53BFCD5ABB65A090F151DFD947D900F36E6A6416D9153D4885
      76C4E1890D52133CFE2D941F62A9358601BA342FB35F5678B9DE1704B00D5CC6
      1F3917E93C35862AD1F6782C38E8C3C9714297B96E142395BCE50EAF87F8C70F
      2E2AE423F80933620BC7AD24BDFCC145832C2FE58FC596DBC932DAC8FEC95D80
      A8FF03573B2555982E47347543FD5855EFBE4DF2F7A611100EA88E0506058463
      96D15F48D69164D2131FB958F1A8FE612E067CC662ED077C410EEE06AFB77BA3
      12A95FE0719357A384A03594F065094699B4102AB2C35116DF08BAAFC6A0EE3F
      EE4976E2CB2415007B375230221F46FFBDF6833994E917F6D3F1FD1F5F82999B
      9FB41EE57078B33CBC5A100F17434AA7B01AA992358102C4D5E212EAE6C51C87
      6ECC0073F1D89049C9C42E6BFEA6F2F350CA356CE1E3E48BBE44F762A4AA7226
      FB62D768EB3FDCF7A5217AFEBE0F6C6CF4FBF73E4AF8EEAA26ACDD7BD7F2FE84
      DFC68664F9A3D41EEAC6EF8B65163CE87D1751C7F4FB3E528DA2C7363C4EC7AD
      FE5E8DE0EBA1D066F61107EF424EFB281B7D5E1EE7B73FF5219DF27377083B2B
      17C7EB734B04684ECF6102BC1201F3491AA54B7A97216041E064225ABEB9C083
      AE13561905B7105A42229C061DAC8264CD1FD8A3915EFE04A3F501E46B7BEE05
      920BBF9CFDF6A2270B2FEEB9FA33AF7ADF569F5AEA0A0C9D8865AB3C36BF1EDB
      76D7EEACFB0486EF52D0406AEB93FFE5BDCFA1CB0E8A81A2D38397A8BF3C8950
      8A955F4B8985E55A58110A1A6B1A41C52925A29E744D892C988EAE25C9500C50
      3EC7A377D49DC56503AC92985E0060BFB80C0FFCCC3B189B0538406C23498A63
      219894E22D96DEACFC9A4508963362146FD740D24B41834BF9B8C7EA27FDAF6F
      BFDB74EB8886469F995305DE429D67D8D72ACA527E5365A39ADEE8AD5B374763
      BC251E62692620B9D20A29C5E3BAF955098C84B23A4D6FFC9D5B777BF4635C71
      DBE7BED9F76EDD64D8B51F590299E7A02133A470713ACA986006AA1E18A27985
      A8890AF7E1E260FD9D9813AC8FE65B8B72B2FECE03AC1A36EBDD1B98948C93EA
      60A2A98028877021F2C22C85689C2CF2DD9620676CDEF4C6185E640CABCA0354
      D61839B01C14CFE6C00400B588B48697E9ABD27F48FE155416B1AD8C9A9F41CA
      E355D3A67D7BEB55792B5DB55ACA52C0452C754EBBC24AF009049938E749B248
      CAC50A58FE13DA82C9E1A5E2AAC36F82B199CDF9C898F2456D7636BD1926847F
      D74378D64D404EB34B8B9916687C9A7B6D7A9F7778F7D67CC2F6547A75E4A540
      B2593686C24835039EE30131096BFDF6A27057599EFC035BF454892000388FB0
      AF2349CBCD6398956536A3732406DB4DC3DB7FFFD2AD73CD54A95AF4212193E1
      31671CCB3C6428ADA4A764424F47D8710397D0F4F698721DE49F40CD55FC7998
      B42F34CDD7E8FA5DBFCBF1684F3FA6356C217AE2B1B311A20BA981D8241925F9
      683143CD64C4B4BE813935A36CAAEF121A3D6BDBE474B8C1D18C7FAC6A2B6D59
      856096E49094719D2A8CE984CA7412C2757D3A55DBAF4A3474FE6DB61977058D
      42256375AB42EB8FA2F472818478B02C28C1EE1A79E06CE2FAB2B3885B1DCFA5
      FD61116DF487D16B07880754429EB3491F2E0EDE55DB18E2B1A90EB7B16E7285
      620B22378930D5469F03006E32F19F12D636AB07C998D77DCE76E6F1C479D213
      8987CC72CFE2592632657741295ADE5783512DF156EF8D364D18E7F398654C24
      CF8CA38C3C14571D61268BC11BCE235ADF15B0AB945516A9FEE5591B9D129F49
      DA7D904AADCAE31B4169FC66AE18DC50B251668F15FC96B419A42CE5173D6A54
      5D5B25AD61F4FAF62596DA73CE7AC9C7A58BE9D47C43E7732F542641FAB32E2A
      3EEB1B687E79D8B8AD0DAC0CA3FEAB1F5AA46532D59C95E51089386418BF9CC2
      6ADBC45F0E4E377F7307104A4852F7FEE87487967779F6CCF7B96FC524B5F836
      804B002C5878D945B6AA8A88A33ABEDEEE60421B5B18C8DCF500CCE94A9965F7
      610D9F1E0595CA0C521C9DEA5DFBB3E9DD9A39CFDA6891290A5A4D600931A1BE
      C424CCA42A3C5DAB17E541598492764EE356D05DE07EEE86D3688925D7B6AD3C
      AEA3D0EB3B2A491D2B51CFBA2FED5A3C7E95E5E5688152200FB1845D4831D9D8
      D9520050EEA281B96E2AA7D4E76CD679948EB399DBFE589FF9D741DDE2597BFB
      E274B7DAF6EAE3334BDDA724FDEE596F27DD9B40D1575C7A3A358B19221C2A2C
      739D93ED0F99498ADCB04204BD798D7ADC3C6B737F3CBC38DE2F5C579795330A
      22BA1F0F4943000EC3494A1E72D638705233F7FDF9873353D5D5705133E4D970
      1ACF9EB785B70415FC3BACAC020D4D6920455510FEE47BFC595BB4A32E803F02
      D3A0A20685DB5586353C77B1A9F018B931CAA6F039E5E896D569B4284A117C99
      358D43EF6897A16C68342BC9AAAF7B8B192174A977C545F4A1CA9B8122AE276D
      AC904D6D7F1A02E923FE0ACA1496569EEA2681A71A373505A6204A415D10820A
      4210E7715C80CCCFDAAC7AB64373AA04DFE2D40237C4AB200F07751C60DC6848
      A2E19DE053B2E9B25C46DB853B54CC39FDC99B43D6C42B2AB2383BAF920095E7
      A036A566E4C9C561D59B354D51A67FCE065F0F4F2793222E9157DCCDA6C52E8C
      6454BF4E406C394B669553AAF1E6C5B70179801BF6FA73B66A910A2040A83968
      D097685AC931CA244D52FF397A598246C36147ECF724B95C9857C3ABD7577229
      9DF1CFD9D42027087BE9A274DD3FE1DF0AA6329588620D1D27503FCFBA1AC79E
      E53CCBC62A9BF8BCB11533063D1668F90F4455BB285BA3C956B20D37024EA020
      95D1359B4E0E805038410A47B00F250420C02B5B3E8243E44DFF4DFFED1FFEF0
      87B5678E74897480C021A284151B0BE3F160119029187C0F97D7032E2EC1CC68
      3C015C0922E61525DA3011EA192C127524B8CA294891B710988D479F81D2A94E
      BC2B6ECB390F3D05287F4433297C3C6BDF0C06FB7E7DF4991D35459509B09AA7
      FAAA16F5F3E5A1B1F6D9CDCDE71D9A1F0DBA5841872DD87BD61B4968E64636EA
      B389DB8BAE918BCAC7FDB8986976B8709B9255F1303A8450B2F1FFBE405D8957
      78D6A6ADF0033327B09AF5688508C44B19C15B433FBE9CADC054AE52922B00B3
      AD2302430C09A3D16CE8A4C8A1453EC330C936CD8CA4A4F4FAE4392253C2E558
      B27CC3F80A3BB73E09D79F361BF31DEDAED828CC8B5BA67AA9FB92DA4E4CAF53
      54BF9F354428F3A9FB462205B491875895585A3163C56FD5325834CA0C21E97A
      1023FC52356BF851B3A24EFF156906A1934B661021C2F5550CAA73281F7B0BB9
      A83D1DA22F97C21F326D556188F5EE1A00F17997040CDBF54A5D7849A7760563
      21E037555F239A58A58C45CCC96F1ABEF5DE62C31ED3883FC1B07BDE228100C9
      D0CF21B4AFB772A09B819F0138AA67BB6D752CF0CC7FCD62524BFC874A199ED5
      E6EB7C4446D0CEE479DB12A6347AFE5586618D7683B244A408CFCC1F53301217
      14BEA10D33C1AF5E21CDA496660052E0B5702FE8C7C55C8E6115305378534D6F
      F55A8BE9361F59CE2B710ADF1F805A3C27F24735B0A8EC8C046F9E30D9F4BC49
      E83C2AAE544A7C8442860C0B5457557B45E23A5666E43DF4E47CC2053672904A
      255B21C25140D07EE2FB696058516E0282D71333148B507937783BF1E41FDE85
      26608DC9C6AA8887481AFDACDD70CB2DC74431FE89C8514027703278A0268924
      2F7500797CB7689C3903630D86B24FCBAE2E015D8EB031AF0DD7749CA1907BA6
      09260D61B2713CC73B28F3282DA6B7AF5E0C71D92554D35B256148302DA6441A
      64BCE9BFEEBFFE4BA3060A0670EC6B2C00C6666344C4CCC07C1DEC7B19B816D7
      F70CC08BBDED8A3ADCE6829015143660C5441681AF373D7770F251B6ACA0F98D
      6EA6ECAED7FDD7FD978D2EF0F52DC098CB20B4C77E5BA87A6E9172AAD3BF8274
      372ED6B8B4F2D21A5DBC029CB7B90AA6A66291567FFFBBD7F8FE77AFC3EFC349
      A6B81203C3B12165B048317FC10A88379EEA37BAEC0182EAFDC1995FBF959D1B
      8FAE52D39F13E4248FEFFB83254181C73EBE14E7DEA33887BDE9F0E4E054E8BF
      8DAE46A1AA80E88AB54DB3E9661CEA7677898569747D7CB7527491D7DEA87B91
      51C1D5AC77E56C21E39269A0BDA3DD9E3B65DD0ABB69F097FDC171B39EA6FA12
      BBDBD6ACB3FDF39F9ABEB5371B07271F7F133D8FFB3AE2812BEDA7B4858E0C6E
      2BA54F14AFB0F9689D3CB03D6836C904445AC6798EEDEE1AFA3BAE882FE5548C
      552F1B8F9586D8EC067B8AA01EDFA4D12C19B991264227493C1D1BFD554B5D06
      FE8FC401048AA4E5E8AAEF3E616B430EA35CA7BCC02C43DA92E59FDAC59289FB
      479C672A8C4C3C4754C0BF518C10447B5DD5620890F5E77F738192DB06AAF526
      2C81A8197B3CCE4D098512E39CC567ECB89EC48B349EB689FE13F174A2F906FD
      349DA9D225D8F363BB7267B00D39962F2FFBDF365E50D7698E114ABDD25A3092
      ECBA618124D9F83976305F8490CB18D4F99177ACB0E212F3E8CC2C2070932FF7
      054B7B1581AB2CD58D683A12BB164DFB1CEF7D2B31E9C5410688F43419A2FADF
      6F1DA9BC6A16A9FC3218ECCBFCDFE51044026FBA187A2BBC2E161A5D90D67A98
      16807806EB1D268A2D5849EAFED81F8D46ECAAA6EB11C5E07E731D11CF140CB8
      6876171D0B1D8430D57295D26B6D9753601AA4F6D462BB3A38DD0C68EBCD8287
      CF377932731FCF450B0F85C545B9899FF5756C792B9582BA791FCFF1FEFBF157
      92290E4E37AB5FD00C400F2A1220AF9771F1ED971CBF5F9F649B5FF2C022A4E1
      02AA32D85B587EDEAD8F934BA8E45CC55F23585B415A4B0BC94A04A07B4DF625
      11A95FD7D9C136ACB877AF8B675C918E2C6DAADDAB17328660950B27D6B951F3
      99B1A9E1897D58232AD9D4514C66C934CA4991ED99F60CF36CC21CD692257323
      95D03963FE74892AF4D87675CEE98860BA2D50DC5CBEAD2996F2F74CC0CC2370
      3585AA3213B662B0354469C3A658B9DD82C9D56DF13CF0B1DBB911317BC96A7D
      09E46F0355633DB788FCDFCDBCD96441BE42F4F3FE3918ECAF1D47F36320F673
      2A6BF3DD557FFCEB222ECA0B00F3F8C76422927A20BB230141E0BAD46F55AA41
      4E94529B273B5A74ADD1AB5879E5538D9AAD3CD4F10A19D546D7C3F905492588
      3D9904D498E372A6198766D7A5267B206D5A455DDB6787DC252B12CCDF0BA8E2
      A7C9A4E8817314E749342D7A6E9A21C1375DE60A3D7D736BBEB5FD666BEA4064
      76B8CCD0284B16D436171EECB75DEF75E39075DE6DB66AD43DE34AC0A814F830
      16DFBFEB506B39525EF5DFFCBB8D95677CC54277B2C88C66539AEAE231C3F2DD
      B2D97B7AD423AC111EBD1D0C940CF7E82DE95FBA4436191F0DD792FF86D9C5A3
      B88F4AC3B77C3915F1FE598C7345CBA8F780A75E8F3394860B242C8EB8C11D9D
      EEB5BA953C07FEAFCF127DC99271A1EE73026CC9E3B8E08D283DB300F71FA1BE
      4679E026A86437B48F981BD7B9A9675B739324905C8462002213AE5405CDC096
      DE7AC8343D59F92EDF6656FC6C677FBB4DE5F4B90307D22B01EFA4F2FC6C5EDE
      A8CC40B394ACBE6B5CD006D2CE60BB1DC5C62E1A3CBAA21790508F51DE89509C
      90C2C5344AC7C5289AC718588DEE7770F2D1862CB5C8DFC84FAD47D0CB662348
      A421DAEFAF92E85266CF348E3EB7B94CA03382BC2C0FFD7B87DB472D2E495D30
      8BBCE9B4D1740D8DC65F50AE0A0C71DC24A6BB67B3CC711E5DFE1F9025C51A55
      0B074CDF2C17E33BB5153BF0BD634DB759E76434F630F9565186AC60B22D43AD
      F6F9D3EA5A94A1D1640302263AA94818221FD8EA947151F6E711FA49976BBFEB
      20A1C1A221CE6B9BFFE4A1EDE0F4CD3F0F4E3EAEA9A656FCB5D90B54B6535164
      A384594A4B4CA26D7FEC2321328F8A9EFC7353FF39C9DECC29323FC60FE917FC
      00720EFD279B7515F365C7D9D89DE69711EC0272D77D058986D2BD5EC3AE251A
      DDA120B0245857856E6E7D96E957B6FE43FF813EFC73B3512680FE75E2D10038
      301F81C2DE14B5439851683C4CD64FB782F6334D2220F36C51CE21F2417016A7
      0EC6802EC2163000323A83298CB455D29020078245E73AEBA75BFDFEAFBF1E67
      63DFBBBFFE3ACBC6C5AFBF5A0E718C5C3C14498F4EF73A2D7773997ED1D45D25
      26996F5CFDB190F535F1D2F03EB887C042B1AD5105238F2784685D9CEFEF6B7C
      7F74BAE743A3654307CBFFB74013DC0AE27A54375E0EFAD7FFACE5A8F53FABD9
      51D97CF7D57B7E8AA379966E6CE7B32CDFD89ECD166A9954CC11571457717C57
      51F471D7DF39DDBBD8D839DD7B2DB44B8F48623CE40BF69270F6CEC998815469
      129D4FF5E3A0960D97BC360DF2B6867BA73BFFB9DA19FA89573C5F812A12EBDF
      0ABD773BF1F6F4C8E665FF4DD3F31449296FBFDFBA43D878A9BA15485A0B280E
      61BE8B66F8143E1E326D7D8DBB68D1B2579BDF6F552EE4E318C90EB812C962C9
      D55A7B975EDB202FB7BADDDBD75B016639CF3C31586CA8615361F8A16EB0421A
      0D34AB92AD58F89AE1E2AFB2F2737C538489F02A9BAD29F12ED9224057898C61
      0FE7B4793476DF98C5273D5ED6EDA7344BE39EFB2348AC715E366DD774EC0657
      C904A035F4BC1182751C623BF99CCC0924CB88BAD2C68A8D7017537651A02C59
      940B68CD930AC5AF668B12AE3B1842485948B5362E3EC3D52FCAE3E8991AECBD
      844F7FBAB7775974461E1F48663C93E91ADD7627ADECDBDA2071E2AF746BBCF3
      FAD652568C43CFF856F532F9AE6A8C913B80C8073A777A06C826A64784D44ABA
      98553EAD38E513FE4C9A50B3F703B8F437BBA272A4CEED309D17A55371909E53
      6DA6E7F68B91887C8ACAA118FDF2653587A268DA48CBFF75EB2E2E74E3C508EA
      C6D3C2402B284B0B4CC044D818003547E26B65438273AAA47A43DB713CCBDC0B
      C154AFFE18C2F817CF79FA08EA0BC516F67F41B8B02068278C2E5FDAA7B55EA0
      A0E676F2ECBA402CBD3D2DBF3978D36C34F8A70B74DC8659F619FA4F3AFDF48C
      B72523E755BFFFADC5B091FF68CFA111F6B7CB8CC2A60D0B5B3EC9011A9D0719
      90E19F58A93AA29077CFBDC8D217C18C78A6945D7718979145433D8A71D806C3
      1DABE116A337B2335F84180F254BC850D0A1BD2B08D2620ACC896400D77A6E2E
      7C319D3137A0D05A698AA63BC0A63C43BCB46276763F5DC0110691598FB0A69E
      CA9245F39B7C51F0DDF4DCFBB8DC073C98E80F8FA15CEB5589AB93E8CB3153AA
      F08BA79C7D99B9BF67E9F5F8BB563D29A94536A96B6D32232DDC022706016D1E
      7D3C7AEFBA97D36C184DF9A7A38F472714522768EF056D5B211D2DB5F9DD9F44
      751EEA2A92D8D0A4AB72166E2C0290A3BBE916DC4AB83EE57936ED797E3E7FBF
      07F9718B543327F63C0402CACED0025D86A31C8E58211DE0EC68EF7570C72475
      67DBBB3FD1A4244991175C6B719ADB39BBD80BCC592C5134CCC63784A3576297
      3B67172754D66E71B7F3188243788D549DC4FBE2CA2154D02583DB36409DC1E6
      86A207F564CCDB848BD6E9C1E02274BDED72137B31A0FC8DADAA2F2C1EC0D236
      99ACB53F93344CD8C7C55C315E0A6255536AC5AEC7C5AC4D84FFE6ED1680A645
      09BD27A0E927D0F8516D56F36B1F9B939FE846DDED6AFFD49B7FB7A5D87C49F4
      FB91AE46493459143996C38B631277CDAD3C2C14A531E92BCA7A6C91F15567AA
      D4BDA373242759F1FB02A7ED611E8D3EC7E5ED86E969EC3211FAA2378BB0AA34
      411C45CF25FDB8EF7EF9DF67493928B3F96FCD23C4BDE1D433EA6A3826390A9A
      A706E3296AB5075CAD505484A05581BC341B415CF63C88A692CF4662C2070381
      EAA32AF736DB1251B4915980B7615300C420D86DCC804A9523567965FEED58B0
      E4BC80F540B61BA5D9545FE071C218500C769F3384ECC15752FD3597E2C9EDA2
      C0709A456974092B78FD7968B123DF75D3E051B761995B3FEFFEDF73D785F69B
      242FFE81B39C3F51FD65ADBEC1604B6B7FCFB3E3C3419BAAA28FC8C449281BC2
      675EC403E269B04E6CB9E3D3BD9D9E3B3E1DECF5DCC1FBF7DBFCFF00FFBF18B4
      B9B5F1058F762F4E6A9B85BAE55433FDC3E0A7335D8D5BBD2D3F6734C1CD4317
      54A941834BE86CCE9BBB437194C4F86E754359F48252BB21B11964B47F7B2FF6
      24F87FA128F6AB9889DA604978B1FEFAD5E6779BEFDEBCDD7CD77F89FF5E50EC
      927436CFDAA23DA54C6DB91022C034733FEF1E7DAAC6C27344FE1DC40ABFFE2A
      B85E91F42CBC2EDA72C0FFACB17E08AFAF9942F05537671569006BA33958B3C3
      414D43C7AF2D8A827A1B195167EFCFCF83452590D84096292AAF2E73002F048C
      49166AFB7BAE18C5C7EFF70FD87B58D264F8FC7C74BAFB0C23C6DFB5F341D85A
      7616FE79B0BFD771D751DE3810A90A3A720739D6D61FECE46CF76FBD15C7C2B6
      68FD97FD370D21010A25C9E32F1B303C0ACDA1640C2C201CD787D57BCDFE23B0
      F0F52065F1159C23999EA33ADA8C9931A88C72F3F8F705FD3C344DCEA229DABB
      985F4318A3C51347AE8871B0BEAB241AD8305B35EC050D702557CF13113AA679
      34B81D741CF27590C2900C95E4039B5DBAF39FE0830250678720ABCF4096592A
      0CF36CBE98AF30A87E3C9B0AD1E086F939A0E002CD8C2248E336BBF0117CEF58
      B8167EF0759E9425C033A57B73BCD390FA478D322026A1461D7F1DC586B0A78C
      8A529CCD5A58E44DCFEC00556666F04CED90329ACDC9649A713B144387C982B2
      12258E19A28C428E36667FBF555911261A647F1B48DCFB31A9DF0843890AEADA
      772A830446D1EE4F4C3C7B8FDF59FFD94EE5F724B72A7F069CFA18B62250BE51
      C0C9FD561B9EE9BAD596E22A0148BFE565EA29E56E05D8CFE3CB05281CF157B3
      1A2CD69ADF2C3C67742F8E207B188FB1AEF7DC8598AE2445B9937D6D780BE955
      9F8210E50255D3F0153A39B3B0C2F4CD01070E562459E229594777641D7F48E8
      376C8C009EC6AEB849CBE8ABBB4A2EAFA6984AD8720882923BC83A78BF433BE2
      AA6603053A86826F86688D884988F91DF56C9A0E9CD3404DBE78BECB1E4A18F1
      EAF5B73DF7EAF55BFCEF7BFCEF9DEBE27F5004EB2031C0EC37EEDD79C0BA3329
      46CDFA6D1725AD4AE284B885D93C2A936142EF768EA861565EB9BD783ABF4ADC
      CFFB5CA27EDE7FE3AD02012A510B1F31DE6CB18583EC75820BFA05B1C8A0B627
      2BBA404F4523503D083D014AA39A8677DFB929E36D5CDD4DE3F4B2BCF272AA3C
      F2BCDD74C3A42CDA4774AFBF6F16D1F142A32CAD9871C31B37CB925994BE7AF9
      D25D95E5BCD8DAD8F0BFE98FE32F4994A204DE1F65B38D282F372EE2E25B4CC2
      F543C894AF6FBEFDEEFBD7DFBDFBFE6DAB73128DB153201B242549BF36507EC7
      AE2B7B4AE1B6CF8FB77BEEE4E3E0109981BDD73D54154E1BAE367AE37D4A7EAA
      1F8C30BF2F91B0C1560D0620027495D4A73A0B73506D6E7870D7B9866515DBA3
      0491E711A16DB2B12F37DD16F478507CA690A3E8C221FFCC82773113A9EACBAB
      AC28D718F9F878A6E9BA24B776EFDEB92DCC77A478B8847B0527120855C2AC4C
      CAA9B748058855181E85CF2CBAEE58FC894176960A4D1ECFF38C95EBE1E2724D
      7DEE4021671E54D63A413C42E7ED6B9BA778F5EA7BB7E58B961040F9092104B9
      D953C4813F1F9D1F55A283823205FE440E4212DCA0855911CB6709B285C2FF38
      C672338CD3E45240E08154CFE1C571BB56BF745B8E214250BE671297657DC9A0
      2ED9A0C1E71706D058253ACBDFED6081462545C668C37D3088AF15E9692E472C
      F3898798BE393933D2E10F07EF7643F175F51277A379525610273D91431D1F54
      4E540598A80AAA01E384167E63ACDD6E2FF04E50C498A9B6BB02B85D2A99DF76
      657ED680368CDC10D2ABBEBCFE96BB2D20A863CC9779544051A0039C6607D28C
      D7105D681C9306480AC3E8B488A6C33155FCABA23A2316A3766CDAB5768684DB
      5D656B8BC003C30F076D9CBB55FD31704E08351F5BCDD0D7DF62867A0D24F55F
      16C95D54E390D340FDACDD4D5E7119B865E0701E5F32FE14F02ED1165C4B8B7E
      E0B3ED815ADC8DA7D18D1A1432D553D9077BB10D7742C027AF5CE10B7FDE3D3A
      B755ADFE785A0768F7802F375EBDC23E5335BBA60B48489C4F4B49AE287C46C8
      8C2DE62E5050C3870527873E3103349A494E793668B72E7FE7B6606BC822A49C
      683E18F21A5B80C9B8F816164040B5BA23963E59785D47ABE1125275DC2C9ADA
      746EB9C2BE7A8591B6FD31CCFFD62ABF2CE151E2DF07E07D3790B00A0FAE8C21
      7057B52C8DC182715511EDF42D61B4DEB8F95554B47B172F316E3E32004479DC
      C41C39BCB1D853B07C70CC047ADFED44A3CF8035A4E30A3C4CCF73D923C81980
      D4B9D5B0B5B1CC7EB56B26860C14F5640CFF0E79019B503A81E3AF20E7B260AE
      836A924714179224B608E629C5011E98F7767C8BFC9435F9ADDB72347DADA784
      35578B52BF5473C5D3E51A65DD2F4203EDBB83248FC59304670044494184800D
      2F9E4C707EFE32BDA98606E23E891BA466D7AEF9589A4F758310FD64F4B9F569
      013E11551EDCB696F090C7B290B4CA23F6DD9E0C0204F93DEB6984AA811AA47F
      04857E48F4810244BB674000F8314B46B1831645257982B07A3E8FA3BCE8BB63
      695121A361C57B5FDA837F4AE92088CF6DB55AB5DFB82D55E1BD15A3AA8E2940
      4B325C7AD63335A3268005A806435142A4A026816A8B0C04DB06FA04C289C854
      0503665300C85D6BD7D15C5F95C2A1CB9CE61C04ABA075CDA828924B103B1477
      3C26EDC65A23B2BD338C7F3D6454DE55E6A650BBAEA54D7422F1A7A8D4303433
      DF32C92FFD8B923EB6F263B674B03C2EE6DEE5D06BC947E9E82AC339076B107D
      1D0905CBF2865967F2BB21E5CBC51568975134BAC299DAA69DEB821F887E18C7
      C3C525229FB56748B9BC6B9672A1A61AAD828DEE23AF26414009969880C0E328
      65A5279B08E4D4C0F0321B2AB601796C94898BA6EE24FEBAE0623428E368C635
      B0B8CA1458D6775D617645C567170D81F8633374DC4CB27C316B053438530868
      575217B6D7AF79CC21053B78309925C5C8B62CD370AB72E67B797499A5C32C4F
      213AD8A6491DD4297532BAC3BDCEAA448B46248D6E7381CB9BD29115CF569EFF
      D4B957F048CD12999A3AAD64C903BE44995930FF1FEEDDCB97CD7877BB15D3D7
      B3CC601A8445982681C479D43DA45AB2312C00F54466AD442AD36D0473765D12
      150E7FB47DB227686836EA64FBE3A1EFF7AE504AEA5C92B5BE3B4D0390BA966B
      8551C7F9DC53AE8168E3B77D24CFA85B8914C33A4296C3F368CEBCECBFFEEE2F
      6D6688096F8E930852D2C56228169244CC11A6F2AADFCCFAD38C6E37C6C404D3
      F376514EDE99544CDF5D545AC9617EAF27B51E5805A0E02E55FC32635E6350E6
      C29DCA2DC52172398C9CCA0C75B136AA6C8A2718DEE86CDAF0511208510558B7
      E338F58CBFF62FEFED5FDAB249D173B01DA5678BEB9679B6187A3BA39A2FC85A
      FB3CB5727ECFB777F735A92405946132277E8FEBAC862D87DCB9AA22500ED2CC
      F2F14F1099BA1316BD40F4E0F62525675C1D1964136C53B1869B9047B00AFD3D
      4C6789703B9684A0E058B8EEF21C6E8F1A7FFD6DAB7170389B031FCBA31DF0EF
      87677B03C3E8CA1B6A4FF3D8DB079C5E0F8FDB47BB3F0AB7B1B30705FDC5A864
      3F21A09BC64567ADF5A80ED0AA0551232A94A7C56852A893546B40DBE7C7A782
      01C3C0F47E37949CA6B5EFEE4F58C6186546AD584AC188613D4AB5F3493EF00D
      40BF708CF07DD0D08B8D9656B47F15746D0E9EF2585085675CAEBB86A64D5219
      5A9B6B3C71906968E766C086E81D6416101185A8EF55FD7EA885C47BD876622A
      901569A60D0CEFCE22D9E06CDF6A2D8DAE7FC654F8FA9005D96ABF56B73FEAAE
      84062F1DA94575D53BCC5352C3C500A07BC077CBACD924E8684D44EED5EC12DB
      6934BDF9470C8C945C06114E0EA10138B928A3AA994AB8086119DB6B9A5D36BA
      CCE9709A7CC1B67F0ECBB1592CDD7B267222209F5CB2F6BCB5B1717D7DDD4F71
      AC01B59C35E74CBFBB81DF6C6CBE7AF7F64DA35E3A96204D89853C58672E9B00
      4346B427FACD0B5477A834019D9DA10C811DE4C211656EE47134BAC230E85513
      311F5DF5DC20FE9D85D69E85428C747A2E2E47FD6663E30026DA6292424B2DDD
      5BD59259A2A4EDA38BF6DBD1E6B3C4948150B3094BA8ECB5DA4F500EB530FD2F
      20D432B7733A18B0F4CF85DFA6D83394D869A1C24C4900894E52F7D70F838B36
      9727D14D10EB53F862A180A85A1DC318E54B7F980A903EAD3601EE864AD39DC6
      97D1E8C69D9F6C1F6B8084BDE807ED532DEEE95F04518CCDB2E7B68FF1FF4FFB
      DB673DEEE63D777C386875D636BCD6EABB54E6DB68497DC782EBE584D538DAB3
      F88CB9ADA82CF56390CAB8596B41BC3CC9420D314887B571A95C1636BC0DB927
      3239BA1C67705517C30AEAE2C46311CD514775B3F2B3D568EF68B7598B68B4E3
      859301EDF55A61E2B39B8510E5C09B8EA6B2A1056F43D5327FFA45DDAF28F39B
      6AEA67290D4ED4D3B4D1D57F84B8C5EEC5F951E52828CBA19614803A43974FAA
      85B2FD62D854D555A6850E75394B5B19126D94AD34DC99935208227755B51FD8
      548FB0FAC8042C7AEE109DDC839CEC74DA6CAF3F39DBDDAA5FA6475F3FEC6F65
      D17307307BBD334BF2C0C5CFA351BCE57E8C12A86CEEDFC4ED9ABAFB80ECCE43
      8D89250BD1ECDB74FD03F0B6D9D77FB2353A4BB71C85A77A2A43D573DBB359D6
      C38B683E02B13E018FFD9BFBC4AD37CE710AC27CF9B077AE3634266C1F19A9C5
      5B8A512195D5E84046A0FF1CC1C16D21D166B6403B677B1744B65A2A02EE6996
      7012FA9C2EBCCC751368253A1B7C36AFC0358D902901A7B65B1D9BE56A5C56EE
      E1E13D3C8F5E14AE4C4C50B17E79FC5E549E1A850C0FDC1BC18DE715D6D11655
      1378F7E6972F4A76DBED47E31F5A5CFDF05E018BBDE40B3496B2BC5D5E2B1AC5
      073FBBF95596C6336F02AD11A96CCE7AD60C720BFD67C9A42DF1BD787D04C1EC
      D4AE344198B018DE42CF90AD031FFD413E57A123F4250B737D21D398BE5B1034
      868D403B642C1D5A54FE6A3D26AB672C7570E0857E5F103D33D8FFABC4195DA4
      FEE82529A4250B6C94DC8D74C46899E2F1F4A4978C8EBAFC7553D32F4471BB3F
      6E5B3A817D6E590C292B5E455380B8C5354203D93DEC87C7591ADF20666B736F
      05FA8C2528D520B527AF3E12FCAF16C46BA326A4E73784DD65012B8BD7EEE0E5
      7DC65CBE4609193F09F626492F3B0D596C1A91320F066A1E73AD48D807DC3386
      5CAD086D92AC51B751CC14B3869734081069A43845A50678F2D4222D85D4293A
      5D7B018F4DCE0E84D3868BB29446EA67A5993D96D625D12D355B2DBF134AFD15
      FA7052A787337A4F2AB9B76EA69B2F4D41F2C6F8377DE8A07E66FB76ABD13110
      8C45253891D5C30AF0BD367F435FFE6D9A5DF244BF9867445036C404CBFA384B
      00BAF4521D7C59A214448E911E60E4EC62B586BC3A74F8DEE5A62FA8668F1A97
      EA38AE8DD7C44BB388C25C1E49D2E958AE87DBF41C4462F1994AECF405A4A233
      2F1D2B9B46A5844A2D625ECD188A5DCB78893BD2C5FEE0A3FC2B2E47CF014668
      A884699E1392126C0EDB0DA8923CEEDDE9F1F8C0B5BCBC2D52DC100CA22F6D11
      836B5BA2120CF44AB6EC58F60446995096BD1B23B53A28D4A8AE4033BAF1B558
      82AA3A999C4E1536C8754F3873A6ECD270B3D89E4E7F739FF29B189CA62BA169
      E07CA9F890EE1F61ABDC57F686D77BBC25F7D8F4EE4747BFB983A3C1056B2922
      CD282696B5A8B2CDD5F7F7A07C41485F51E1107C18DC2A660813B1CA1CEC590F
      4D83BF55356BF9A8C0126D70061EBFAD5AB33EDDB253479D5A5E49838C481331
      E442AD4D2D387141310B6B7B42D685768344680C6E8234ED0672B94CE57289D7
      3492EA7885429D6D422039F51E67E39F92D21D1E9FEE592C16AADB9BE2528525
      6E73CB65E9B57028078534F83446974D39DAFE042E1851391685E0BF4A92AB31
      39E917DB60EC80915D231D7245695A3E9B24E2A1AEB77F74D4FA268334BBBE71
      D72A9719663C93AFE1296D3B2FAF6659963FC326F7EAFBE7B7CF21691F1B1623
      7906F2804AE831BC7D931BE23BD4B2E9E4231B838C2C543E15586E808A645299
      D78C4D618F1204C358AD4F1B16FE05942F1EF64A79CCC4A7B474A8952AE2BA15
      74AE83AC3FDE8AD4AE8A8E87205D51CFAC9A87824EE6E3C665944C853228C845
      ACE1B72DD01ABDAA86108C31F136AA4B8F90A252EE566B5BC9A4B1D1423F8144
      33A1CE4864FF7D319B6B9931B21E7D9E97C68E254B35CE3FDB2BC3D91577DB4F
      11269F6549DA0C0F214BD9804B1901905C9CE5B7DFE8EFCF70DF7DB92F31E738
      52026A1039427C2880C1AD1548574B23F9AA3A3DC64004B70A06B30D8D5A8BE3
      73ED25215F0245FF9BB03E82A71059BB184B0336381159892EA3862C5F2313AE
      8BCBA35E0F7C0743F98FB0F60B7B2A031412DC58B604D10067336C4D858B3805
      31945A78C07208905895A345A61D9C18414B369CF9C74457498E962D905F9C2B
      D40A334D327DBA250372F64972C65B06DB8BBFCEE33C01402E9AF66C79154FCB
      68593CEDA933F575FFDBA62E7BE40BAA2FF52A2CC928CE85F97F4760D1A4A90D
      C540C1073B48BE6E893911A73026AA6828E4492178495A43203FD1992CFEF18F
      9B8ED29E9175CBE302F1A299962F5DC68424C9FE954B626DC71138FE1D8C6BD4
      CA1D44612F39C2E0CD256F50D734D29CECC8148D468B1C35E86C62F3ACBBE986
      3765BCB67C63613AF4DD8E1CA899F9000810F977E0A52DFDCAAF91985EDA7600
      F286B64E9A2C9B217FD3FE3D2D096215C3372F6F5DE2B55CA2730E4D789C2295
      25CD58B9DFEF77EE2355A04085692ABEBD12654B5D8112965F924B09EAE14DC7
      9D62FDCFEEAE1BDD779F95DF918E56D038965AFB63A52EEE8631765BD55D65C7
      4B1E57C82AC0EEDF304ACDE15850B1DB5157F10247667E21EC69BBC61A7264FC
      894389096423738B6C1682190E8D7B1FCD38FD2AA3A45937AE903453068C7C96
      8D1738BEF0764CE04D23EADEA9E890711D1650F6108D69BACC5F2BEF229A5E43
      0844D530401095EAAD5135BA71FFB2AF6A0C07A76FCE048FD087F1B0D07928BF
      040B972F713E8DC442C17A5B0F4D55C9495BCBBC20A72DADDF8B057349114942
      DE93502E4F061F1D4AE4581C5E1E1B2B6E816BC86E239C8338C76BBDB76B3F6D
      9F9F1C9EBCDFAA42063434182521255A5A2D638A0DD6342A535F28B089CE0B68
      B6E958B39B791C7D962124F40FB9041F521D1593C27E8B105769B90A211659AD
      F4466D64A2E5AE832EA397DF129DF0E9D4D463590239387D23665C32EC48E065
      A7CB9CF0EC89A23E56D9785CABA28E61B9CB72846FD39B7BFB54A4136A441FBC
      2186E6E8A304B97EBF8777A6518EC9391E33E31C5D47B0DE067032E8C5D85986
      1250F805A4DBDCE6FB1D15995808A253EC0823F77673989495A5D0C47D62DEA7
      F5A6F6A6FFD2EDFF7CB67F7E78BC7F72B17DD46C8793C7AD24C00A042FEAEBCB
      92D5D249ADA75B9AE26D67180D1489916D2358C894E20638C5384E4B595D207C
      243F42F9A0CC748475D8B9B41A00E9F1324D26C908C38B36185ECB3243B9187A
      C2CBB618BA9C04DA18E4B8C23D5E51E4CDCED9992E530C0FD3E01D668B32AC9E
      FB35659615A5014914E5ACD1C02C8ED2603DE4402A628D310BECAED71849E1B9
      D27F789C8C9170E71F6E9810A77F5D174952B139ADB2DAC5ACE7760755959259
      24DDBB2DD4E62CA2F34A54C66B14C74B0282B458B2C81047D3AD0FB5942CA82D
      9BC962F0976602B603CFDAE418EDBA5CD8C38BFF7D51705E17A64C2595D34236
      B9A244D77C8EE3B9F43DAE5BACD5EE8D524770F3AB04E333BC3DEF7E516BBBC2
      D6E538B1CE8F9FBD3FDF937D398EF229E09BC67F689C7FF7B7330C5D82983B4A
      13914F6A76E19DC52592393CAC488CA627F4D11568C41A5B083DB92AFACB42DA
      8C4D7715AF163FF08FA7C35756F1331C7372B7BDFBE3B9FB85B2C22F5F6DFE86
      9721A293C029A1D5D5223B884BFBDB8059FF3273A773CE675600E40BBAEE1671
      D977EF13098575E3E0C92AF7290A14B599045DCCB51F2A0E5318BCFAC39E1A3E
      708FF20A48D838AFE12BD393C03B99544177600B13B0FD4C1BC8CAF052C2E0C9
      DA4F35A82EE0CCA6C158ECF7E8FEBFF2DD70D2E15CE11F59DC9BF0272602B876
      D983F4644E4E93CF523D3393D31787E15A2D47D0175EA4C2DF118CE8E64F5355
      447458A3D9C8BB5D17B5A48E50CC5D8C84896EE8F2A8E61DC763B757B58D4AFB
      E8380E145B556B0B3D474B270D057963F87CC859AAAA345F4538F300B0858060
      B9A2F2F46DFB75D363F37B8475032BA776DF1F0F2ED68C537F2D756B3FB82963
      0E7E0AEA0999546DC19E13210659191A32B53429A26359E56A02A80693BCAA0A
      82A84136FDC81DD0DE975F6EDF85CBC7C4150714DBACF52CC47AC22CFABB3282
      6CE84660F2EAF9238882865C717142D60C4C52ACE042B67B8EC62EF40230B0C3
      C124C9B19BD22BCE9FD0D3AC4C46422016B7D496378ADC6BAC74F59B305F164D
      19F280EB19013BDB78E7AC88CE51195F42FCA2F3A3903C873734CDA59373C7B0
      DB228C2A100E8EF1661A00D4C4511CFAF0A6D2E2C87247954AE9618450977119
      6CAEE6B61BAAEB572C8B7680ED7994F35CCB7DB0BC72EF21DFDE70B2C2412B9B
      20C70F1851DAF1C26850B9C7E6AA9A179210A668B2DA6A36F61F1A2C2FE75DB2
      788806474FE20461864E20F3F610046AD5A4E7FAFD35CD4C8FC24C0D4387CEC0
      2FE39D9EFFE9244B63393F740EE92F59B5A099C9AF0A7E4109595219926FB5C2
      8E65C3B3C92401E3B995F5A284765BC154131399EB3CC3C1D6304AD088A83176
      2B58AA6C580948E20CB22CE08EAC9BBBA2B6C8D6AFA9DB2D8F13A6B01AF9AB35
      7A041A33A2105C5EC354DE9F84629CE99362A63356F22601906034C5AF7CF0DF
      7CFE7ADB42E54D84478D8EA787A9AC58A065DAA1CF5CE17E5F506C0E0AB04CB1
      54CCD2CAF39A6BDF5ADF6DABC41AF6034B22500A4B7831ACA77985B0B1DBB9E9
      D4D853165E0424C0BA833C3EED1B2BA8679FAC695565C70A6ADE5F3905FFA738
      622ACA59721596781F25F96831C3820E95B3D6C538A59C442ECFB8FD514C93A9
      4ABAAEFA4C2B6319947C007F172B548BDDAFE5D8C6F580D96E0B250497C4B4A3
      203620E5D47783CCA7F2B0B2C5519170EB8EBC23105678983636744C45A20259
      F84B77F8E20B2B649799A8DE53CFE58776C595574DEB15F518112F5AAA3EE320
      1B9336742D3DB0689F1544AC2367386A33F9E2D512E5A6A6106C85B4866181DF
      F50BD7E52A6C6239115802F0806FB841590C1D246F6EEF44B2AC88F0AEA43037
      A44ECE4466E4FA655C6C62E07A882313F5FE904BD96CD8AF78F72004C2953294
      B02EBBBA9B18F60987B4396A638CDBB51AE90149CD1EF8CC16C49C4956214D07
      853755ECA224AF3D81429CAB68EF324B1F5FDBFFAF6C4149328E6EFEB49DC76E
      0FB8E5FB02F7FFCA16984D9CA724C75F65D3D8660882C4BD6CB440EABDEFDE23
      BFF507F763364711620A9DAEDB49B63BA0D30F6AC06ABA5B2A243225A53AEED6
      0FF15868D1E18C8F53A5BB7ABE92C67AA0A2F0C840C7899A57D10AAD8758E0BD
      2E52E4AFD0F9F1B5E99A7839DE74ECE79D5F89FFDFFFFC1FFF1F2ACA6DAB}
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
