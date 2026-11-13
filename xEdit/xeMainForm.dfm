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
      AC9C9DD3887792B794E12D179DE6926ECC64C30A7B9CA5E45E7921034BB27D0B
      664259F70279489F2C71180CACACE0A2441E4F5815E29CA7390A8E584B6C18D8
      D0646CB86367D926E7B02D0EE003583EC7F31666BCE177DF919031F714B924F1
      AA742D6882A837F1035E72FE8BD4734DC925B4959352C2421F437A4C52ADAB04
      4EF60E8E6753F9714E95956CCB89CF4729B020A27FB24AD6296A330075C3DF7A
      8E77146738D237C18CAF2652EA9565A2C29A0060A7A5A6E256CC2884998975C3
      DEE222736C4F1680CD7FFC19D0C895ABFA27D9A1068137A7CC40E732CF2EA703
      494BA4CA40A8B1E4042A3F9A41DBA0806A0B2BC19519FBDF513EC23B4BF810AA
      1D8E5000CB112D57F3A2196D3D4685F18CC2E85C6E4903995B0A23C451FD0F93
      C4D5F21D6C375B816C7739CDA1AEF32CA6680606A39F3022837C110866636B11
      FB06977611A46401C589CA23E86EB23CE543ACC129C09247CF321B36633E5140
      B8263F0D0C62A9BC5897915EF05FDD0AFBBEF1F8D4649D614F2C4E32F06BAA0E
      FBAA19F9647559330B3018CF33CB4A28D296C430F81F6E301D44AA0C43E92D96
      9464DDC16C1EA7AEB671BDF74EF5D6EA8C8088F4D819F20714DC4B74404E0F0C
      E434D4E9FCD1F9A7B2D64BF1E23CDEEB6A8621CFC66D43CE3AA76A3C56EDE6A8
      A9EAEA3299E908685832B4835BF529C29C28EE89377B7A90D6A0733AC0047E1D
      75CE6BAAD5393FA79F5AE7839ABAEA35DBF86948A7BF9FC0FFCAD61CD25575B2
      C9C5C49E92024A9F0344767EAEEA30486F4C92A936C981DCA811A28EC5B250FC
      AB92A6062EC256D65D1BD5BB6C8F94B714D3F3E9E7D8B2365D2AAB32C823209F
      25A1DF1AB59B2A8593726DD6CF30FC45F3AAABEAAA9FE4302C38D5A22EAE7ADD
      229CFA8CC766D01EAABAFA10445969CE330A67A0FD20274991C5B110483CC3F9
      687D18A846319F3E8A62D24C9DC71EEB75DE1044E748711284EE39A6814075E5
      08A66222AD389949C142366708A5BA89BFB645D50B18953835C76FDEC0AA1875
      866F54430D879D9A3ABD7C8DFFBCE552D3E1E991D334A5E6864B550B544F1005
      E99C2BB5B62E9145596B32CEE5CB28BE9518F8E317F221117A7AF9AA717A71E5
      662E5D5CA13A37B8651B1C4849495B647151C6A7CE3AAD8F12B71575C5D85460
      DA11928BC931639F978F087BEC64F8A66A7E7135EC3CD1CB62539DE1B4C3D6E5
      79B16FB6E698F27FE4F7736CE15314FC9E1BD5F4086358756951C948C0DF50C3
      0CA30092DC930A96FAE96F47BF33F8082A817CA1065424BCC853F2A3ACD54750
      DF694045DD933517103F872E697DA8A9616B705E53CD5EEF528403D45C8DC3AE
      CF34F045F794949845F20CE7F07D53D53F1900EA4FA7159949D2FA52F9FC6477
      EB750362C3D9178959DD2F621FB01E5800C146358154C292591C24F223F20044
      9CF1F46B797A092CA1AAAB610594B88D4064F422A7CC9F610A65796D5DECC5CD
      E27F88F0C39F193F0E8600FCFCE38F9212A762FFC8AC42E80B9B6923F8FEF64C
      6DCD3D673D9DB6DF55510C0BBE82C2C8B29405EFD4E755901A75F689D010BEB9
      B58906AE26A915E5E23AACF01ED06614C554AB00992426BDC86CB188947CA522
      C6B797639B9EE0E155793464E8A2D9ABE4929380423453C1454A8AAFB89D514C
      69FE5D2274BF7C1A8E707C577AA94E3F9D9FD3734F506A4567A865E9B910CBA6
      6288EF90035FF770D8867747C9A471480823F6845F222ECFF5F8086DDE102259
      FC620A63F3C7247E24DE332167D27CC20934329090F2B3D0097E20957EFC78A7
      F4A3249D70AF4599E61185E3444F96E8021D06B308010A8A2EE18046C5EFB4EF
      18CDF27D7566B26E2AF281ACB6F2670B639DE5049E17A9C95A5CE2491C78C4C1
      9B195091F1D4D2CABF29EA141A7A0278C94CF1D767D09D9B59A94D0442157F40
      26481934DD4222B8092389BE14FBC7A15324ED29E888DB5BB38A0A194A42FD6C
      D5483F152DCCC7CFED26ADFEC761F79F1CBE072813A28CA649FBB74A50BFE05B
      8C8463F4CCF755EA69EBE162B73F752D9CF314E5A364BF021D8A2A5D2E08965D
      FA86ECFC0EB971D13D3DDD2111735A2462DE59E00E3CF90086A6C4E47B97FD3E
      553E05A43CE9168066864DFA5E7C632806B7D0696A77B334E21F34AAE4423DFD
      6DF814054C3D0213C924EF68B6C571D46B428FA8C9FCBA5560167A269D0FE77A
      6980A9161C136526C4187FF84DFC2085D1B17A96ABBD0489E128D1510AD72EE5
      B739198E9280264C1B666ED921F4A96204FBF40CABCAA2F283BE89AF5537C231
      D1EF106724E968AB156D3260692293091EC037CB6CFE2CFB9C5E232A6BD2F93B
      2B75CA854196673BC5C7B9F4A7D1D9CCAEE566A222EA5A2DDBF91A37D7731C28
      CA4122952F29234BDF05D9C5B55F6AD8A12BD06E0F0B9230E1FB4ADF717258AB
      954E98CF8C5384148A00088FA84408F3C73CA8A40A2262E18C970968386D110C
      6FC62276240A013319183085884C4AC017C1327D89888DAEC1EDA9509A154BEA
      C7828D422897586C88E50C1F2F80A2C1D2B1548F998AA8029CAB99B05ADB2C44
      059B126157AA7B600D07FE433E31C8BA031CEF980BEE7D371B1B41CAE0F9E0DF
      202EB961091A72D620AD09C4CAFEC4745C584B367B982123ADD98433534CD636
      19E5D2DA1DBC18BE7BFECFD76A9A3887EB9B62F0B0FD9847D8872AB803013FFA
      576DA3A01849577692244B08323F1B4D0B9C0B51B5AF4233D3DE9AEED132B835
      1C9CD382BD3A8DF3A485D252B8343A55BD003C56F114E6BB2087169A8B550A68
      AD17CF2278775AB57F3D3ADC3C207EC154C1F720F54EA1BB76C1FBD93D23533C
      ADA91B4009D85A3E6A172201439E348FE9D83B838BC21504086C06AA3D8FC904
      219D164CB133078BE52B3E8544F4CB3556BC2C852D12A49E4415F88B60915921
      7E59A340243E4B41DB6714AE165B3261544DB8562170B68C90A8B311380D66B4
      A884259245639120C412B80F22A20C7037B75B970772F688F4C6AFA8373F98E8
      E3A7526AB7ED7CE128FA5875E0452D47AD75431641BA0415B72FEFCCB1280B31
      E19803891F26C95EA92B3393022FCA5010E3AFE376800198E1D544B486BAF950
      2498AD25C37509A28099290298A40C278866395C93421C5BAA0A415ADEA94572
      E293FEFD09F9A4DB15DE6E9C8620CAADB2F9DF5FE1985E429C7BA40BE2A8C27E
      7560D225BDA88D1E5186A82175DB12772988432D79F95DFC0E8236739D8758EB
      591EEAA46E6E0B65C77949322284AA14E7B95E481D2A1E2A74633D0C26896686
      A56B7B6CF87655427EE2E79ADB2558E2E3E84F656C2ED7AFBEB982C267C1A5D7
      BEDAA33D41FD5F12B0D3BC5F13A1864FDB6FC5532964110E2E8864CED41585E7
      1686FCBEF8A438D6933037CB04893FD92C4F472F4BB016AF5FF1A1B4FCF32ECC
      5E5FDF7F90D096BB9D668177BD6E08320DC95766C60DB37A09FAA931F94253D0
      4E751D0AE94789DC62DBC271AA778EE35EDF24E1C0CCCCED7E3959EB0653791D
      B358D46C795131119E173195F0170B96AF6C4D050CBE71057BF2C56834C50CAF
      B3C8B757A4B881147028F9459B29DB60AC50EAA43759F9B0975F1011A3C27D26
      6E5A3C556130F1CD14C9A846F8C7EBC6EDED074865C8E27C22076CF7983CDF59
      BEA88DA230B1BCB26A0F6A7BD4E99FD6D468D0EC0B7CBBD71FD9C8EE7BD589E8
      9A82002C312B9DF812BCA6F0FD66E07E1FD897B4A8884618B741717F4BD1B8F3
      553F4D8C0935705E3C08936FDB431A336A44CEB4D87126CAEAEDF35651CE64F9
      607788C0316335966E35B1854B54645353A3A1946D501924BD74ADC48DC0471E
      06B388335B22590160D34B088EC480164A0889A62C4C0011AADB881F81999D99
      7D29842513AF523FD08906908427C52C0F82722136B42224A2BA11DBD5411CED
      D7362F08DEE5E064D86C1CC0422D155695D63969642BA3AF01ECBE771B9E82D7
      D985CAF9249E4CD65E989B4D56E7964160B1B649159D06932029199FBD1F6B80
      3D2D74CF64491CF8F7724013AD898E963ACB9CF9A0EFA506F82E63F91E1436E4
      6DBBDB3C6FB4CF4F068DF6F9D567354974E4CDEBDC9885CA05B470156F204722
      04567E41CE48108214FFF5157DCFCDA2EF44290E526B1E84FE19325FD68366CA
      10C67A5A9A5FDCC19E0E220171138EF82E75ED6387FEEDF4F2F51734727999D9
      70E4AF9F3BBD4DE61621A9E7904A6284EE082CC7856495840AD603A2DD57CB3C
      59BA92CA63D3DA04053EC9011E377E9984C4409FBA9C1D8AC354ED099D05D82C
      1CC98F066020501AF927A1B143CD83A5D8B148E32BCAAFEC113296C394E0A6C2
      94E87BE9BE54BD5362D3E6C6A56A666150D5ED34B92E880CC9DCF6A71F74FA4F
      93C42361C28D93CD6519AD262C84DB66EABCEE83CED9851AB49B23CE3C093F20
      A0343ABC56FC4FC69813688662D9A0D05E9734D46E0771D419BEFE4253000095
      329FAE9E3E9EF58A9F756ED2B471460C19499DE4212B00D4854C0C67B5A1A499
      E0162F4605184591864245FE7353D77FD5A6FF8657F42725C8BFE2B26D3A1C62
      8E561D8E771454C157849753287FA41555C1B1601F38C9ABB5A7E443543F5B32
      BD6D2C09674F2ADF3354918071DD540639CE1B4E1151C043DAA3CEEFABDE9170
      0272BF90454CF1BE7B674B2B55B8E8146BCA6055032F014C48908A0B473C058C
      7F5FE69390307A45818904A052E563C973163475CB6252102F1311150EF247AA
      91A758ACE331904357E5A3273B3B29C918C8F7AF8B98387E734CE0EF9A7A7DF8
      F31B86E4F0261EBF79BDB57CB87D288B710E864AC9B7B40768104DC226686543
      87FD9E07082B529A1D0ADD7AB0A8F862D002D75614075587FC4B8EDCC803A00A
      EA5C3B56F429E0438ADAC8CD0895D5E65231594C708F0BD3A9D707531413A7DE
      CC95DEA92D89425C203C7FE3241319F05DCFFD7DD54DC76595BB6437075DD468
      96BB386898187127D3898C6636DB67794DAA34EB54F269DB2F5871F71D85F277
      A304DF950FFF8E043DD32488232FA9F9BBF55768AD07791C66D592A382FDB159
      D23C10A1CEDE0F3F1DFF5C533FFCF4E6C8116F685636E6F10E04AC94A4C0C498
      D29D83221813171AAD4140E0CEF5A2C6170603FE1AD5806C7F1457665DFF3DD7
      21F33541B0D7ABF494EF2B83C241FCE6902F7E23CCC6171AFBC5E6E0054BADA6
      D88771A60EFE0066452CB8D452D3205265BE51C198C5D62C60091E271955A6CF
      CD4D52FA0FC2725AA913F783843D72E78234FB4C028ED3736D72CB1CCC0ED48B
      CDA3B5F71AF0F0D377EAE81030F177EA68FF05ACF538D3A16A14F4A91C12E763
      AA1A45D1DF6E4CA145E9A06D2543BF7D6949456C78E0A55AC6CB7C59A7A2504E
      E4EDDD3DD70FDFE5AF47751F4C49D0FD7AC27B5EC4EE36F2EA52F9F25411C287
      A282C23109115C2F2394147993CD9DC4AE8E32BFE26634D112E457A28E1B0A4D
      2F972172CD3093092C89CE6459125FBB9357764087496532523A01D6A3724DC8
      AC4150C5A2DE4AA89C58938FA7F5BE74EE2B035C9694D9D4AD4082E990680FB3
      F83A42E6490E23643B60F34599BAD5F05831325310FC2340C516A11939A89206
      05950C95AD59CB09AC1EE63B7163DF511F251D8ABA9941DDC962A109A5409B9C
      33FF29D35615E24D0A1B98BB14829A8C076256D82359F8F2CD2D3DEE0289B7FD
      F7256EB6F27CF43D20AC72101540F8E7794578DEA0FF83D76C395DCA58281FDC
      C8AC384E1E44CB3CC3ED7AD95BF7621FBECACB8D7E125E0C6BB0FC2B7F627BE2
      1CA67B52312789CC3AAA612B5910A13DA960392CBA87347C1129920E24CFB3C4
      E731B1C7804AB7D2E366CBAEDEEC2EF32CF3900BB3117BC1852CED5732E6C9FD
      651A773628C865B8E372CC0393002D206C185B7E47E9F4761081F64C330CEDCB
      B5CEBB258018085C82F1919D6FF8C3C55FA2B508026CEBB32CCA0F3FFFF45369
      1C145211F5D5BFE7D8A7093A7A50A5AE584F1B1617BD3BD387B0D7C65448CF34
      D537876C0B0EE701A8C96262DAE3556E77DBF0E8C01EB34CE2C552AA1A2DCD98
      06DFDD0AC170A23E4118C0D2B595B7E579667D74787C5C38E1BC8254B1CF1D1D
      8A8370662204B8CCB0F3CB3BBB0D0728967DA659BD7EF393020BBD58EC642CD4
      854CC1276438790B9C7BF3D5BF51F84567147F0627653EA14F3FCBF4064CC6AA
      463DB3883942352A9815E82062E8490E56499F025175C14FB3C44BD51EE739D5
      096A03701F51CAC554BA3601248CAFCCE73330B3CE2D7A445D4F408E4FE479E8
      2FC73340D53C585FB8CA73345C47F4EBC770373C3A602CE95653C9B4D6C0DB2C
      9DA78B7CEB5940017C6B3D50045F52C0154844637E0F54FEFFC84A7A5BBA2E95
      F436BA40E1C13DA9306D009CD5B0964063787AB463F5737FD053756E67E79B29
      BCB508192EEA87C03D2339B0F36C1368F6DB95F2F83ED31935110DC4DB331D72
      AC4EE298F4E2DE9D29B80E7F7681E1295120EFCF6D43D34C1D33DFB55A4D3E45
      80FDEC1DEF3FF9FB535081098C300FAAE1B2FB306D491315E6D8F0A79D5BC2F2
      9D26F1E204F46403337DF20921998899742F2E7B8DEEC565F39EE9383FB892A5
      AC03F659A626B50F810AD123854B94E4DE48583ED10B0E5B1DDA72E284A833E7
      5A7F4E556B899ED10C2C509BE2CEB6DC1A6236D1911F2F6C39DB134D6835A9D0
      2E60E5D3CB155C8C3A228D082BD13C007BB7F6057EE6CF2C3520C0E2F65CA006
      6F6FA3FE5872D68EC5CEA0344FB8588ECD04C6C504D68ECE19F6EA667C768667
      A5742399C3510174D9666CA7ADBD9534FC62E1188F1A5E7EBA60FA8FF6B0658F
      F3C046BE85628E63CD58C21AD02E1C0FB4CC9072103677DC51AD212D371EAB0E
      6E3A240F256D3FC4798284C3D0646A1AC620BF0E66DCA64D1D3FD949EBB6CF3B
      8566198F15819EE926928D2B42378BD5394842EF2D657F8215A01A7AACC0744A
      ED184A55F70B4116861955B9C15F3EAE430233F20A37AE2AEBF6DD6B56C763D5
      24EB25AD943D0761A84648155B7FE83D41AC590495A110EB24B143A4439547D3
      2084D5C506111F63832EC5750AFB584805E1CCA9D8BCC8690DD1C858F574A4E9
      ED9E68973FB4FBD06562B43CD963FBCD166D5B7FD81E55882A52B05102E18704
      330712813312C098FA8FBFABA3E3E392C1863BAC1696D557CD8CEFABFA7B980D
      CC516C10D94E5DBD4A509B87867C24648783B313FED9E9A19F471FC8DE698571
      5E62B684BF818806EC2921799FAA1F8E7FAEFFF0EA48EDF50E47BF362EF09FCB
      C3D1AFFBCFE5670880ED7CD81A34CE21A388945B2432AF264BEB3A0A0470A8E8
      4ADE35FD81B27255889D4A3B2E5E1A7F3AA4E4F029A8722FE2CC8A6FC701CE75
      E49FF302A3809D6AF89BC82E5038112E4D3CCC287F4254DF726A292454B2815A
      BFC9B905015E6CB49AB4839BD3B641C7129DBAB90C62CBA0C2D46E5559635C28
      CF27130534CEF959BB0B83A842AC508E4427E4B942B0E421C840373A09B84717
      39E8F69DF72C0526E1E3206F8C7C610910A79F278E7D69858433317E1EF91A5C
      51937E9C0EE2ACB19A408BF10F852E40D64FDFC4200F55ABC995F15EF107DC97
      1D0DD32BF5FF5025AB4901AE120AC818BF2B1A7265B19A244623A881B2DCBA6F
      96E0318CBC35B7547DB430C58577DBB4E1E8BF48EA0D476DD11DDC3952877066
      76359BAFE41020823E8ABB24343086B905B11F16AA5112CF55A5D69FC3EC2416
      0645982F5F553059052A98A84DB7AF8BE7685F757EED83698E83E085CD01900D
      558970DF0DB7C3DF6A8D2AE69ABD8A15BF9C22531B82748EB6A339F9CF6A42BC
      18DFB5EECE24532797971F2BFE05F1DD93B94BB31BA27B233ED238EF9E7D2825
      D82EABB36DD7D66164CE225262D3E0D62D3CD0DC58F18D58100E8D5BFE01AF7C
      8F1B4034883827476FD4DE7910199DEC934577A7A07FA750CF676A9CDE92367E
      57268CBD80A898B6CF2C5346C23579CFC6E38AD08FB601E057E2541B3ACE2D31
      49660FD37D1400A97A818B236240696031F412142B23969AC5EAE2F2A263D302
      AD8F050D333D0FC0B8C484EB5209EF3FA5CDF4B9D3EC236240E51C9C01584C0C
      E5C23F73E352A69244B09A03A8C4AAC668E09A5A26E62688F3345CDB0259B9B2
      C462737487C5A60A98FF2E0A2FB7BB7CD11ED281E5E89890E25B838C08634415
      523C1C3BC15C3E7B5C375F497A5866A47DF7A0C578AC463C91E1BCCAEC2D0B67
      4FCCF7AC8AFB59ED0AB3699B78232EA7EA54F0B77C9536C8BC388E860B7DD1EC
      BDA14370D1ECB98DBB9A5C9E8C8603F3BB042DBA5C66DCB0DCAAEC2261C54BBA
      52CAE95FF62EDBDF4FFA065BD5ED2E5FB67AB21A4889D53059EB3B3404128F43
      23F780FD544A8A50622A010E0A497CE4DB199E9A276EA890EEC50589BF0BBD20
      427B4A562000847F988CCC235A33095015EBC6B15F347681991778014DF83B96
      D0F16861CDB00AB6C2ACE8CBB45EBAADC0F9378BD9BE421BF79EE120599C534F
      D7324D4FB8F23BAEE9FEBBFBA7F7F618D37B7B5C9D9E897C9DCE0B3C8AE46BDF
      51315D594BB7D7D28BA51A055968F6DF4B933CE9A8D33FFFAF81DA93E86C816A
      DB57881C02DC86C032554BC729197D8D24162B9D4BEEDE33A2F21E2EBDB20FA1
      D3EB0CB8D64FEDFDDA6F8D1AADCBF6D97EADAC05547B9D8BF35EA373713EC27F
      86FB35EE01FCE94AED353F7DBADAAFA9FE7C9D065EAA86EBC8537BFD0FC3D13E
      5F9076EF6C44747779BAEB249B25C1DE2444AF1A24F6D39AFAE7C8A4D9691E79
      22DD053E609142920CBB67EBDFAB66EB648848E16BF537BEB617FDD6BFB899F1
      F9D579972D61293E743E27DE5C87A1A14E85EB25A627FC588DC083FFC5BFA3B5
      EA0C69AD66655CD14D05F6AF4EAC875FB45726000BFE7912FB6BA2C41519E59E
      77BCEA0EBBDC0F7BD25C4C021365AD3844910969D2F7456928C55183681A7FF5
      D2EEC49C447AAB609DB4D5A7EFE56E8097CDACB8D15E1E5D47F1EA3BCA105D35
      49A54CD5C226ABE5AAEFABA5AA693EA95BE88726236C0F7D1850CC1D8676CAFB
      EF37D5B3D4A1BCF9C96D7E772A6BEFEC4CA54872B3C6F23EE0D53B49C115DE2A
      A80B9626B916F02B351EE25837FD5CF8B238FC357572366CA22836B831A32498
      CD4C820AABC6C9D9F017A0ADB3F5A7E52CD13EA7E89925B246041FB829C49A49
      3C38542016561A4515C49BE44D9CC20EC385760620DA5D3AFBDC69ABBDB344DF
      C0CDF90CD16C1271E5A8388C25C8A88D8F8D0001526DBDC064AB9F298851A574
      8E48F10146302412EE0C4095B9C5A3F6091568501DAF51961E7B07040C744F73
      B234B077972276750EBF03851E5D3708FA9EAD5516582AC632506229FF50365E
      4FE2306C80F1833E245FABE7C526A659FA4C2169EB56F7079F90BCE3601E0CCB
      5F721D65F94275D2943A76D913D58AD3C7559415F7C13153CEB288EE44B11056
      2FC09BE50A2B2A984E37EB3F6A542346E8B94A15DA04D92F9F9AEA44776B9EF6
      F09B7F0C2F2F089D6CBB5320454714C6CFB4FAA3CEA0A79A490650F302755962
      131777B35E69E216443E7111ED8D4C92E848359385F6B5156C4747FB7F12CC9D
      0A262D1F3865FA00E40BEB5409CAF104D25F65CB64FE505DD8D47BE40154B2F2
      DC036407DD5AB5A5A1200E4CBA908221D1E6F8AD7344879DBD33835E3F84174E
      6204A181F8B2146470FB2A0590D4F98C26F02711EF628A5B640BC2507263121D
      16BC0B0DF9C73942A225EE7861B2790C6BB6E9FB7D8DFA7DC162A7350AC6208C
      8C8736D0BD7E14E39FE2CDC589B97BEE2A2CBCFC312985DE9A213F086165DAA7
      C4647922850A4CD22AEF20F600B33D23C4F24CC90F7B8CBEC24751644378B25C
      C1AAE4637BFBCC6E4B68CB7A6A001DA1E6CCF6EB52E0B5D11C9D68D29EE5553A
      B728AB57DDD5A4C3A98B03D9D0209A0DF389547891CE5D4D08BB7840FF458AFE
      64DDB107A371EADEC4D4822A57930B62200BFE30B63D15B65C609676F43393D1
      3FF027378D0C6C2EB3E675A567FC1F1430C1EE344E214CC1B2582477DE738959
      91B052C14696C736D4461B5661A50160E6EEC9DB9571BAC80973BA9F5B490BE1
      092587039B69AAA74BE305D3C0130A6C6E9CBE77B48FCE95F3FA84F0A2F7F3A1
      3CF9AC71556C20D9375E88D35EAC1A91DC5AA03153A68BCAE5F7C3979AFD6EA5
      1DE81E153937FBDD83A57E2E4BE73781E80A20E44BB9F2D4C0B988C5C889E47C
      312F32D0280BF144D2F745274F3589E3EB7A40766A096B11FA39F4D338D59E39
      33913A88826905E402759D18EC262048E275375A739DE0C365D30DAE66F44CF1
      1C2019E9EFEF61C810170749C641B3D5510766665B1980408D66F15EF5F5720D
      8B8C2F5EA51AC1992BE5B74F916F42235CE5B65CB750F6E91776A373F9945F6D
      1992C5EA9FEAEFAAFEEAF0F0F0B0E01564163E6608B0AD366547A8EE33517BFF
      E3E8F57E49561A2F29DE63EAF1B42E9FBFE3A63C0F59B54D36C60504E7E8E0E7
      8363C79B2F1E6EB5BF31EA41C8A5FD26EB1009EFFB9887DE17D5EC42913C3470
      9260779924D02121AF089A570E5BA71C29D7C7BD2F8A65ACF5002E1E5F87B09D
      ABC4489229A0664174B087616C19C086F2552A784A6BAA9F0471025F289E3255
      514CA8AE9330F6C0C12A18B9AFFF45EC177769552DC62C79982C01A7F0775A22
      CB2AA1E8C646B8DE980D1A70E61C21D66F2133975E6974F5DF536B732A111C82
      3328516D43043112D7A4F6CB39F8FB1B9645A72445675893DD4182D2F1E689B6
      17421CB5777870F0EA68BF2C47940C8F05DDA0635EF918328A4CF62F58FDA190
      5300299B4791313E3A4241E4373D0F8D7B601B938207856650EC683244E76F48
      815DD770C41C595F685B5F0CE01BBDA0977BD1CBB9CC4D7EC72042C055F073AD
      5286B38656D1D20C811A83B38BC5C585E0F571D431DB64F65F6089696A6B2924
      F3F572B71AC468CFDB623790C0CFB5A25CA88EB3B05433F63DD635F5AFC3C6BF
      8E489F2CE26439A70ABC10AA98A22238C8CCC25EF71058543A5CCE75E3437B50
      2B3ABE0D3F34DB9DC1BF2E2E91A81E752FCECA3F896A6C3C7227F9D25037CE44
      CFFC380C7181512A7AAB9A8468DEFB7780830A07DA6D3D816359C06E6B46014B
      B7F44B51DD44CB20FD629025A4A2A1836B3756A3DFEE6395FFA23E4061423015
      1CD1207967CEEF92F78586CF806926278019C10BE1BCD37C06E5CAC2120DA2EC
      8BA07B30962720118442BCE213A46827F3EB1EC225D0AAE5971D4DA72DEAFF2F
      6C6ED375C12999405817E262A22B812EF467BD0E22CAD6948CF8AE32A0A0D9FF
      A2BACCEFBEF343AFB86B0105E2551F6B144433162E1AE9AFA5A9930692E27132
      5AAE83A55C3096312C00D137BC90B04164D16CB8A28ED2245EAE6DDC612D1AD1
      EE3E910021F55EB47EB0DCE50525A771DCED81819445CBE2322A9FDA1539A144
      12E06F510A7D2EB80DC773E5FBEA2238BF6C5FC4BEF9A25A7320E30B92FA8B60
      0003E3FCB25DF4C2B808181322BF731BD55EF1C262FA223C14523B0E4B08B2B3
      CC9E7132D12DC00AEBC883245FA7A86A2F2E86A863C6D778EB3AA9558925C336
      E80DDB2C4768703E830F26D61E836FFC4C0C1169DD5AAFA55392C5AA37FC60F4
      F2CF683B817DBF8F3EF69DA55F66CAFC946998799F4AA3CC66263D049FDECB57
      FA49CC796CFEA2AC2E8463AAA8B5A17C398B79647EE80EF1C07B896ECB44CDDE
      147FF773600A0AFE2247F3B5D2D98473F244FB5212EA4A6F3DFC89E8D0B89088
      4C346175976847504C57D8E981F7760BB7880EB6ACF1643D9645CED285DC8B17
      134AD493EBF6F26F2FD55E855CDA26F9EF9AE3601F853B48F744AA4D17F0801A
      166144DCDB5374BAD969FAE9320CB26208FB320416FBC3A8BD3AFDFDDD853A3B
      D9078C2BF673A23388723035567B59149563C46E86A03CE0B1308E773A62AC72
      2AD5FB523E7E03AC1B7595A030748A29938400519E8DDEB9AD8CC9AAD60E9725
      13858B07F1C89A4EEACA0B3A1A0AFD2F859F4C7AA493A0B3EDEE49765F0EA4DE
      67C3CB80A68425973AB3C1D03ABCACFFF1925D132238A1A6E3440AB23DCDBDFA
      1FEFFE0883C9FF0CFF788DFF9FEEBF57F12228D187F429612F15661401C339A7
      4B2876CEB1540AD609710F57E32C1353E7708D631881C2E6BA68928A8B05DA7D
      9F0C775A71DE35ADA63A4C0D750191A6396AAF909EEEC9A03047AE0A713C3C59
      36D74AED42C3ECDEA160F9841D0A4673302A2254662CCC83580AD34C464C4C68
      A8C800810C695DF0F6F0F06F45EF02927847F48B9279F94F25F94730A10CD278
      49C0A27D9203BDF3C3D1F1DB1F4123A7883701ED264C64D2B4A67E387AF5F667
      420A5622B0E02BC69F5EBF7AAB7C6360C72ED1C20571090A3BE820742EEBE881
      D0F966A334CDA22804560CFFA5C8DFDA2A35F0B336AA05054F56162EF1543299
      0B8E7670E3566BAEEAEAF4EC6CD8383D3B6B364ECF4643122CDCDB365C8B7873
      6C0672F9F6C777C2A505F944D1D4D3EEF0830501960B552B3041981FC23D69C6
      32494C3837216F5395EF50860C9515A19F4572078453B3DA847B175A1E554ECB
      596C5AADC214098E3FA9E0DE0991859D7E774FAFBB429CD418AFAE2C5E1D0D47
      3C7CB260BEB7789760B14CE21B4AED381A0B0817BF13DA5E7B70E9FAFF3308F5
      8DDA3BFAB13E096C69B17D6DEAC5AE4E861680F41FEAE8D561B9AE9B2CF38EC5
      F6D24952DED02F68486CD16BD9F4E4B3E13E53906D444777EB6A8DF64D42A23D
      F2CC3B355C1AE3E7D4C50D09BF3829E0BF423FF4E4FCF51B64F39B402BDA8D3B
      9CF635F5314FE2204BF3C85449ED05E7DAD2A9A7FD406FB0DCD3F946B64D8715
      AEFA6692CD17319AA50F99E4FE33750241E9B680FE298EFA5710D8B3B4AFE362
      537B3491FA4CE958D8CC427BEB3802B406AAD9ADCA40ABB67889A09734FCA696
      5FA257488C59863222C3270BD927BEF63AB100390A4FD651802A592D55293C90
      FE6A14195B5AAE2C3B1DE2508642631A6F1D315B2DB3B0B92ECA8F5814D87727
      6B20252E21FAF063B7BD6188228E4BCE8C98F26E29CE6F606747FA9A297A6078
      995B2418991C5BB8EA49669D996C6BA24E63F5911D7D79DA518787472FE9D05B
      8A20B8A778D7DFF88F5F28F0FEF2F027FED4CBDF0E7FFAF2D269C84F403444D9
      28FE606E71E66609EA64C8E809D7DC5A9792F805A301A39B9D76B6BA3FFB45C1
      636612848398810C8C505926B61159F453E2100EAC96E2B55FC43ED15D3CD934
      CED159B007F3DE4FE2A50F782EC59FC535AC7AD652BC63D1F138F5987B80049B
      331CEABE3965EB25900A2004CD34FC3AD0EF710FDE27198302852060A122FE2C
      AED4894B25FF5E66BC792467811AEC320C10B557C47B93CDE33CC5B7A86B3B65
      6730E30AB9A52BB080AC46FC67F0C5DAE44CAA8C8B4D41FC204DD11582A01C91
      0E395D417DCE4BC67671387698C3E08BFA250FBC6B941A30C1216F0E1F0E7670
      3FB5072F3752F277D2EE97925C872EC99C03D7A819F8B24D05B051BA0A8F94B6
      B48CEB7909F09A55554BB77A6E42629B95768541A6E2DC3541B759CBFD05700F
      08C103617C22CEA410484CA251629C14893494A26926452DABD148B4CA779E6C
      3E65DB960320996C5D42B9789D5BE3E536684BBF2EF97686F9A42EE82E823611
      44E7293A533CFA8D86A7475F04A8B091743F0973D37F521F61E3E271731AE2B3
      A4D620138396B1AA33ECE3A29543EE142E2C029C544BD6D7995BF89B230C75AA
      092A1518D0B1551E5EE2B41516516697B494F8F01DEEA24BBF7B74DF576DEB4E
      353E54794A391C7535E80CCF2DD568752BE9D791BF5130BDD354FA2CA4373B62
      6CD00E479B94AD6EBB28CECAB71D954783D4632F2F2EEF3B286569CC34ACAC16
      DD5932B7A81A51B54D22608EFFF3D9122585093608E6E8B1F5FD9BE41B4393ED
      762388BE8EC8BBF85C021E1747E8324924CDC4195EA356C23B91086C0F53C8D4
      867D2F62A7017EEFDC500D7A63948875B79A83A78EFBE6C28E2E48DA9800366D
      D839BBADF496AA14C051053F8C2EAFA4CAD9A520DDE95698D3BCEA362E9A574C
      85E8235E8F86BEF77345D58AF8D8840A84B83E082DD491EFE62200B798E07034
      6A6C102F94A08106177F70CC6B176E9066BB7DD1685D9E5BC60EA059FC2E5A48
      94CD919E92F8B00EAAB9D45C1B038305ED3911377B66AE20DB6BB24C355607BC
      53C52982242514B15B296359BAC10666C9C4417C8F1F514143CC16DDE151A3D5
      1D1EFF198462ABC929E26F525069D51BE56DB8291B21C308B158C26176334056
      939375663646B48C9B94AACB8AB6703B78A24C6C242B5D11878E0FBBD037A84E
      69216262A949CACA95398C8E6803FAE05AFF4746EB6A729A2751000146EDDF50
      5FC0A3EE463A691FAE3D3343E2F5291ED6BE3CF9070331D30D4765A733D90A17
      19416978FF50581F4F511D3833920C056AC8F1E1080284C0B194E435176655FE
      B60C45235250C035192F409D98850274B7B3344A020DB89F3D4E54174E27892D
      D5BBD0EC0719895E39CDE6F3E8B4D38504AED84A1CABFF1308B83AE7E7E3F1AF
      2DD23356996D66031ABCE5558C5EC5DDA578B23B7164435823E50CF4E2289B13
      1C80AE19336EB43EBAA9B5CB4F17DBC6925B4267D0E9C8836CE188F8A9448A54
      A9127B9A897F6E8E06325E45488B3C6633A677771E6EC556A7C30FD69479907C
      ED5B876FE0CE2CC06FBA9A0C29026AE3162527CDAFE783F3E7A70523EEABE21C
      DECDDE559DC82EC059A951436EFC708E3C78D10D9CEAF9DB7194A157C4EE8781
      382E374866EFCE8D339B70343BE7E7445CE6766146C4752E7D38D4079DA24626
      0399E1F965BB029E17BF1ABF2410B7A34F3B6A8EC663A16E82FFB2D988368E4A
      34B6A358FD3028EBC22FD1196D835B153DD8E0973B3A64724BD9B7CF97350A82
      08DAC696E049640BF124C7ED2772DDBAF4BC08AD0709D786DE0ADCBA6CB01674
      BB4006EC32940593C779A5038CAD77B2EFB7CB007D496E8F005AC91A453DB6F4
      43AA0478FDF849BC468C3B1EF73FB647E331915F26F9322BC8EDEE9E3C623B40
      46EED37D1422DF396A51A489FECD0D420377D11CA9B0F345522005A3CBB5B184
      36DCB46A8709FC5ADEAF21808159AC8E48ADB80555CEDA10D852A6BA5578CAC1
      855D9C5EA8A392AC8EF4123D13796A471BA0DFBBC74BDFF5A9176D5C7D4B4973
      D1EC3123B20D44B22C38C3AFE45017A5D8ACD7DC6CFDCBABD1783CEC77DA8D2E
      6FAA9D00996B76703758CFA7C1C578DCE3C7925543B193DD97AA7579F28FF1B8
      C50F261E495E903217BFB534AE06FDAFC3164E6651B04D95EE64B81E1E1CA20D
      4E9CCFE6EAE8F0E0D0ED3275061FC7E3D5A46F92EB92C793EAB9EE8B21388D01
      EA89F1B824A027D502202B52821BD441B4275B4416905AD2C376D7582351E814
      C7AB6263BAF7AD696C3EF35EAACFB5BBEE029557F9F4427A329565C95C4328FB
      DD4357186D3C16596D05F97DFD00B86F41BCC22E161F7FAA596CB40729DEBD5F
      34FE40C0828F459B48B769D8A71AAD256C2F166A542D9A3A33592B0916E60C1D
      C8CA4624CFF4DE6726EB4653BD58DFC39F9C723F68AADF474AE6CE6CD125AA3A
      DB679A23F1B90F408E5708BBAA3F510AC362B576DEAFD3E16858F567286C9236
      9A49823C7021D49FEC8DD130693C1E9CB587A5023F46A28D6D284E098AF0278A
      30E185D7913A1F757E7DB483777AF96A1773FD8EB5C737A4495D864A8BBD14B6
      BB8559E1838CC7777A3AC0D5DE60A9BD7F94E7E21D471A693CEE5EB45AE54D96
      9CFC0550E5D2B5DAF1E477FDD03423BD5075F582FAC510C6EC05FB8F5CC6433D
      74266B4221BAA760406DDC9010829C38A99D42731A4B54BC43011C06283CD463
      66D04D2BCD6F74AAB801D84EA1B70E9CEED6133D1491601BD0A9985BE94346D6
      733033F72CDCA0D9FA30A800AEC571F5D5DE5C2F972692F2A374A59704940115
      CCFE2ED10BBC3475BDD883BF8AB27450DA098A126D21A2200C6DF3D19DA82817
      7AC9601ACB4070915F6B34460C7D22EDDAC6496EA176BF9FEBD8ED945DF56D70
      0FD629E2B985BDBA430EF6AA07C6C096CECC0CAD8AB8A128E51CDCED4490228E
      C7C38B76DB866DEF18D67F1E3F7473D0BB2409331EB79B3D6A7627B916A26484
      7145BAB44CB3C0EB232DC2A9DFD7CF4FC47C2F27AA80F677306C7F11373090D2
      F2D49DD9994450A53A848A918ABA914A51CDB390C5CE75E27336BE79D53DAD96
      A1D822E2A71DB6107A45A5053034DDAB4EA33F1AAAB27C74833EB5DA9CE64967
      53BDA8175F1991C394057BB77336EDEAC29E989C7A33500DEADD50C773D0EFDA
      D8CE44A781770F196FA34AC6EBE6FB57EA8C2ACFB740A93A55A610D08C587C89
      51C2517D77BE5DB264312E849CD879EFCE5B2324C97A1A5CA512EE840932218A
      790E6481AA1C32A6E83FEF1810BD28FAC3211ED4E85C5E0D2A795E61E028E0A0
      ECA25C347B16C7A3F085F198142C8199C6E3DF8EBFF014198D1B2B04C6C6E366
      B688D32595FF5E31714C307B8290CC78DC3C6F59FC553F8989F808806ED02EC4
      5358F281B5B85C316BE2084ACC858632BEFAB5797E56C1C7FE49CC9C7768E7EA
      82B2B5B5594EA5109B092D14B06E97549FC4F1B56A1B61DC8BBF167F7FC43848
      C9DB7BEAFE10A10F52434F87865304BB3C935A16FBB19A21A71378540F115A8E
      25680CAE2125821E842F000E5E00EC46A5BDD25ECC69645CBD84C18194BCA3DA
      75A2DC1B35478EAB3CE83515534761EA9F0D72A16A1806C08C3AA7A57FDBACF9
      FBE2FCB6961A2732A1549A48850F791D445D9C3245C0D704F66E078464F7305B
      8746C84CD35D588C5A799AC50BB9D544B40792852F5BD804CB1D460294BF286C
      0C104D9CA4DE5927FE461C2280A8F7A9062D95CEC81E551B4C8C42653F15AB65
      3140D77692C0B757DACD98956A1970934A51BFD35C6C72B4BEB51BD5652F5685
      36A4DC276B0AED42554B6CDC065DE749DE507390EAAF5E9706D75FC4F3F8B671
      74F0131BDFC4BA5234AC51896572DC010EFBB5E2E2C2E0756BBB726240C0B611
      59DEA85666261337B1D50B40CA5614EE5B970D855F6824432BB555FFEC340E0E
      78857792D82B9D1E64ADDCA23EAE7CAAD3F3181DEFAB7892C6E48B7DEB79DF3A
      04B0DD9885892BA4923443D5236375A1D5976230E100BA0F817CBA9008037C96
      4FEA3BF03CDFE53C745ACB822791F1389C786930BEE0A19CE6371ECB933B1972
      BAB17132B438234BD41622F21447363FC8837FDD557FE47005271D9749304A75
      4FCAC82660AD6BAF23BD083CFBC1FD1D862B48B4C2184C4086BC289351F923D4
      F5D7E3A0DF783C91FC21171686FA56D686AD2B2A8610AA49B0576E17ED7FDF0B
      14F49594E912325902A93E11E1EA939C48EE765706202E57D1BF3A8B2043DFA7
      9B9E5EFE8B8ED6BF4EF5D7E8FE1E254D8430E964F8EB0331C047C939D58BD9C5
      66E239228EDD228A75B6D6284843C52AE5F9D8E1969E06B720F8A414049C9A82
      46BC723218161A474AC872FB3A846EA306398163B3A9D3E09637B768AC57FFEA
      EB55E41289A51DDF7743253307E5BF9A606BAD40048B7238C09EFE85157A528A
      CBFAD6056746691969E3BAF3D17CB4DD65F97586423DBC938D5CE5E4F922292A
      7F9B9A874C8F2AABCF7614B0E4007193B4177166DE11DB584A6E5941691F4FA7
      01F384C471983203C15A69F4129CAEB99318A91E6E6CA7BD2CD7214F31CD62A6
      9033CC5C8BBF639929562F9C5444F24B2D699C668DF976CE7A8D0EB594439917
      4D02CD8F02B284D03CEA7B0A842B1DE598FDDB91B90A24B2056679B40A7C3F34
      1FD8ED45B53758390ACC1F817FAF8DFAD485D316A36401DD94964BA321D128F1
      1ABAE559A5D299EAB642102B06D36C039D4B9D3E288AC4DD47906B879728316A
      B7419145E2460F2BA2E354E806DC68C5A1F0F9936B4DE6C80E6543B6A4965D15
      4D622498AA179651D97F411965C6A9ED00902CB4E40BF18F71153F459141ED39
      82BD7DD8FF5C583830D3F4C58EBC5066B18C139D0408FF48EF01084C9C626211
      638203244C1BCDD6A04371D86531855D9CC161E7175E3221B6800440AD3E0EF3
      D314FF0BA13E55A9B6CF4F060D2A2A148601AE2B73473E0AB32AFA6687F14A1D
      4CF33FCA1E49D4EBAA207DDC4BE7C1B2FA0BF2474F4C3637A9AF1D1329DD53B9
      F09C63F8949A445CC363F57775F4EAB808F7ECC16845FBAEB5429EC96CF5407E
      7454FEB2DDA0084089E0F94A2F1AA7C75FE9043D9DC52CC4A9B76D9E99AAD4DD
      3D6B5A92203C349B233A42714C2416D40AFFCAE6664D8AC38FBF477A3F96638B
      C811858F440C5E2273956F1781B1776E12A364F072FA7E95F4CBE901C2DAB6A0
      900B9F1009BCB81DB4EDEE777BFF9EC43B34AA294D15A7AFDB7CA79B6EDA8457
      B8091ACBA3E696ECB6CC2F7B25899A2396054575BB3F06F02A50F7146CE16E8F
      619C600108077DB1231B34E11ABF3A1F2766D5F83FBF9BA64E3510FF4325D50E
      76E00F47AF8FDF20236673FE778A37D38382E570A1D1C3D9D83AC12DAED5C79A
      C41BA431AD4107A014F1BC8B0247704BA6C818B1B91EF2B8D432C7C79F94A7A9
      2B2470974CED44B1CE36915FF5B911C70EB3C3C400C81B8FD5AFA373200FACD7
      A353359A23F9A4CECD8D09771B83C0E418A3D93C836A2683DA5A035A9D7D4243
      77CBFEA051BCE7CD492545F1AADC1589699D99AC01582855B4321A138617D300
      E151C280E7386522151AE6D4070D2E6A5F23AC1D0D577A894AE77F1559758A1A
      6092C54D2348B9F3426D92347CE1CE9636A3ACD1D31B3115BD943EE45C9F8F1E
      91594C08BA1A9CE019EAE4386C51361B2A7E961A2E370FEFB7E6F9F9974D4606
      D858B2F0251D43165BA62FDB62B4C0851D3CD5C09F89A408E2804A5E2C137E90
      D94342C148C9ACCC8DBA09501D1E27646ADCA0429249080888B1D3AC069D6683
      AA19C663EE585E5880746FCAD80B77720451A2745BDB2CD25686CB3829846039
      891AAD8F3BCD0EFE9F97E8742E411EF27A8911D386A5D1DC3E51DE3C08FDC444
      6E637D82DCE0E659BEBABC3149C8303B59070095E744238872476E7F61EB0777
      1890EF8510CAC8BDA06DCEE2191A02152D9918E5830361816C6E7119CB20754A
      D5B6E4EC32DE87DB2102A785DF95AD4E899E350C4BA6FAF40EC7FDC16E330153
      24B8A1D39468C7A84522DA4CC5EA6CF0A9AFE686E36A41543066527D8566BC57
      16C7D2DA98AD7FB4C603F41F21A3DD27461D6574AA3E27889F54F28204B2C3DD
      30BE4273D854ED6E55448FB72A8A968A0323EC6792547CC84DE1C366B38FC010
      11D3D69D47E14A41CE211C06FE404B4C511C819296955423E5DEB407879B4555
      7087D7FDCFB38F8EFE64FB484262444F2ED79572581CDC61D22B3A2D86431756
      60A193E5ADA32E2910568D66BFCB23137188D5200CD8B24D884FD682C7CF00FF
      C92AFCBEB653EA2E46061FAACEE9A0475ABA7339E80A2A03FE360222149E0572
      91C6DA61A8D268693747C7E3313578521206E5621A865D70BF464E80D0D247C8
      9139EBC87B0797D7A1048012F34AC1BEE2941C0492D8824F366A733CB68AA96D
      B8B802257EE81A4C278B386C9E6050AB0507F12A4598355FA0A64DC430A7C5EC
      ACBEBE0540BC9CF647D50AD203F5990EC60A52053C3A2B4DD052F4C50ED2504F
      489A827317C047889F00A888904ABE35EAFEF8E61E38CB86E33FDF777AF545B0
      2A1BAEACBB23F2858A045082480176C6F19528CD749727B7CE2F47CFF464388E
      E331A29AFF440907076EA9030F1A69D150D463DD262FBEC65CF13DFE2023D0C1
      E442678C7CC312D2BCBB2F28CF873B48CF6FB62E767EFEBD9D3B9E67CFBF3E54
      F3190EC19B2FDC76B9AC9786BFD0D3299A8FA1A6C5F5255E7F51DDF6B9ADF4EF
      03E44DB5248B5C6211E6D60B7382B757ABD9290251B27352C5B2E5CFD9652A17
      679646A93F1A5C7C0D3FFD7D0F95D3465DE0FA9F074FF4D0FB60DF6A35B10D34
      E9487F381FB90E81B3D43FFF2F5B1ED7C4C69C6063482FEF62713CC30165657B
      79F20F08A956F7F4E36610A91B7144D4A25F112358392F3F0D5661551DF5BBAD
      1AD78A530C48B22284C8DE458F7F1E9CB7E97DB8B4AA837B80960F484E95A827
      72AAA318B00668F4B2D241B29C4F66A2CE168C54853B815B38E356DEAB098204
      D8C7EFAF30F87AAF9A2DD7E71BA6F19E36F8F19DEA32BDF9FFE4E0DB7BA503FE
      C03BDB2341FEB24F1F2D99C795A7238401A9F8B7B0B3173A88BE616CDFC92489
      532ECF23EE002A5C96002AFFB578185A4568DB2C4328690523C370080A57E03B
      B875DF1C5A1C85AF0D1E6D768AA80EFEE0A3FF2BCEE9990B345583B58790EF83
      DFE8DC0211B24DDBBCF9991B9D3CF467DA51556CE9FB873E9B184F29B5B5A70F
      7EE3C46CF740B97FF8BF4BAF13A44DF75E324FF88149172FF7BF39A1777FFFDA
      69A567D7D4FF38E4FF3B7D8267BDB4CFDA6962D5177CFC334DB4BDD62ED193C5
      5F9793393A5475ABF23E6D5561D281472526BAEE4CD5A999A863757C78FCA640
      CA1F1E1C1F1CBD3D7CEB4812F4C3D1EB438C5F0AC566BFFB5432BB2CDA3C3315
      5AE03393498D83D059505C98FA2A26268D4380BCA5970A6541344AF0599BA29D
      A3AB5ADB9E2001330479C4B12BB1EB5208BC6CA311A8F43529C02808CB443158
      2198D0E8C9D45C09C46AFA962CBF3BB5DC995B80A862DAD4079D643BBD800492
      C08A8C581DB5EAE157F2BFE6DA7FF398BCFAF9271CD3222D331EFFD2FED49760
      091905DC87E6E8E0E8F5C1DBD7CEA3A0AFD6D73D5FF7D9BFFA96F3FED4DE3B65
      1F3683BC73EDAB1785E5FC4225122AA1EDA3924C519A1E99B9654081C2184F94
      8D459F982291745ADC5036265F1525599727C38E2AFEBCCB70600A91E4C46A62
      89C8E89531508882D724F87A4F97473AA2E4C7551C44780C3B3E10D5E8154B9E
      5256448E3555A851AF49F47268B3900D61ABD87158E19C242AB57C49106834D3
      E073E10E53B7D0DED75FD4E9F925E5A2FBA75DE4A26DA10E9356722380850A76
      71D7B7F2B8B2920FF53FB0DD7F5DD5E8AB9F119E937E38C47CD71C352FEE3641
      FD33DC04ABEDF6B4E839B20DE5DFFBEF8AF67480DD57BEB3A114EFFDEE7BA553
      74FDB08F289F758F078115155A246B714F61854B2AE100A0C0696E335F41344B
      55185C83E242CEBB14BAB0CE9584FB372CEF07D5D7B69FF45EE96B08C6776A34
      A4B7C00FEF959EE01EC997DFA9491C135FEDDFD528C9F19DC9909459F52FA7E8
      B4BCBFBD08F7AA4A5255589A257A79FBD5A16BA23829EE231A13FA1434F28F53
      FC8F588D675F04ECD33D033FB40B297F043F41EFD843B5CB2C28C93A31264267
      44862C63479816D77EDA5A58D2C6B33A18773E91E71FEC6EDF5FFF65F6FDAB9F
      5E8B49F3E60B93BAF8CF9E3AA0984DB5D5F2F01A168427DC474ECFECB62E2F36
      9ED905A91039A81489D7101FC00F13ABB75B001E54A594131B8F41515BC543D9
      33839125D86479375C37E6EDDB876DC21DEC3E0A9E959AB56008195972944D42
      BF5D4662CA703BD206459F086D532ED51DF445290F5B1FD39D82B5A47385C60D
      70EFF0062866206F9CC3CC9253B8B81C752ADCB2F9B272837649540EFBFF9034
      AFEDFAFD4DE6FB473F783C3E058B59615AC1D9047CC292DAED149A85A57EE079
      9E949BEC40EC51867AC7E38B66EFED568351ACCE2E0BD13905FBCD06716E25D8
      6E2DEB5D66CEA7FFF3F07CD8F83C3C6F3FC123C1F9331E13D34F69FB032051E6
      7F760ADC9F559FDB8D66684BC2D26CC747CB35B18F460DDDEE0FFDE7E56585B6
      9B118345CB9009D31D3CC19569F688A49D1DAABBE44D35D2E8F07D18CD59747D
      29E7B3CB8E0F2EFF510C8E9DDEC1C9E2B7393DC54ED80A1B5C57508A2082B4C3
      5351A864FB5E95858137661E784F220584FDBF4D125C80A3044006A09040B30F
      91763D6A88516740A46B546D64B126AAA7D74A535CE01B188DC7258A51C65550
      A07287E0D17A19EF12C200A9223694908259E0AFEB5FA3297FDC14BBBDB361A3
      D71C218757DA1D851EDAE9D19C1924456C45C18E928B6BD9FA492CDA81EBD850
      8F97A3B66C4A6C16921304FE3B32719E866B2AAFA5933F443343F537C223498D
      1B5111EC6ED6FFFBAF33EBDFBE2A587C2AA6A3446D76351D21E448B7DDE72B20
      1B945AFED21AB90CF6FAA091CF6E7788E670798A006FEB7CF8CFF1F8AA3B44EC
      C68A5C988A4C182BD8AEF118482F4BD7BDD90E511404E15E01158EB52BF0BED0
      F698561B24D0F7697AA73314FC4567484A03488DDDE64B92B59324BE369C2845
      EB72F2AE849D0FB32E5A073A1FDAAF61D8EE6B74FB9D92073DBCC7E30ECBDDA2
      A7681E86AA13E58B278B2552ABF00D6F8003B394277F5C30D12D82D9431B575C
      85CE2DA21884DF0F6E7775DDEE5C70551703EBFB2EB8D3D19FFF4547DF36E3B1
      6872C922C5895A183FC8173B359E963E898A08382DE400FC8F5324FCA6C1AD5B
      128945D0D3DF1ED0998EC7E7AD4EEB1BC1EAC73E1006E299C9808BE9877ACDFD
      F1C4FDE2242CF89F47ED6649AFEBA82C10606D5EF5FA002DC38529E08B18A179
      D5633D664BA098D3C1A236ADD380CF816838CD5068174F999DA379D573DB24CA
      6FD84E1F682B371A8F3F9F51EFA32124937B577A89733CFD0128FD0ECE31B74E
      CE2EDEA9964EF48D8E182AB283EFC04F47B324CEBDF7069FB1FC9090BF53AB97
      14157330C641B4E256C440367637ED0BF6AC6742639A59A6BD6B9AF73D34CE07
      3BBCCB99C9CE7534CBF5CCD45437BD30B7592B0C96E73A05FE32ABC13C89BAD1
      6572996797D37EBC32493359C4C9079D0AF00E5FC3D53049373A3169769207A1
      DFD28B658D5AB3A4DDA873BB446D65008AF46E2A7BD1BCD14188A0193BA1DDF4
      13E2E9CD306BE5C98D1949BDDF1DC6EA1D5EF5EEDB1101D39ADB91B82DE2F911
      A079B613D3514D9D1F577F715C53E7AFAABF78E5C65618FB60E421966D946D16
      FC99A18966D99C163098AA007A8939B8E89F5ADA13EC723EBAE0DF1AE884083C
      2CDB3F86BEE6DD4F7779B8B0C54206288D5325C59FD97AE787E29935D55C2C62
      74CCCE1724B76B544D38379ABB75DA1F063A339F9652DA5AF95D1BC56B2BA397
      716427E6CAD6C553E3765010E783DEA5D3733AFDD3639B99D3CAC3555119DD95
      806186082AE0C0514FB81DA66A25268B353CD5192DF2E3DB6790F3C365CE1C26
      57A3CEAFC21D2ED0990A7DB21FA314DE1A46816BBD30192B57121B22022C09B7
      EC80F9E696E8136B6B932A85C66E9EB73E8CC7EDCE70A496714A0B75B0C33068
      94239904AA032A7BAE5252712BC3E18C31AE78DBFE538560E891FD3C13C7B741
      58073008D0792F38F5A81C5B086D680295DE4D1E35E6C09476F2E02D1BB53CB5
      625956FA9E5854703AD7C80D553E94023AB6B0538603426B2FDFDD0911D5BC68
      6F044C6C670D899C340666AAD103AFC633D87486D849E6A802AF2B1135B9DEF3
      37408591FCD479C80E4322C3938D0A9E0A3FA75C19FC74EB51C4769764E10A55
      EF58CB2DA1950A789E7B9E393D4D3CEF063711F615A238AC2810C971CC276F3A
      DBD5FB4248554487896FACA67A1FDAA31A05906A32340590B61D737701C14E39
      B9E8EC99530398CF900F164FF762781D442F4A2F83D39B3B0595A9848ADAAEB5
      3E0C18AA7915A401AE351131D8AED32887DF699CE2F1BF82EEFE5B91DB47A832
      C036D94227A2AF202230652FF61146544114EC1E4698FD75515822B4616D77D6
      BF3C6B9CF52F4F2B8D60E384482450E6BAB67408CE43113495207A1562469209
      596C639C9D65E015645E406C33C5132DDA9599690B3196AE8E123B0739F157D9
      5A1E3133EC31B5892E6664893F20E44DD1B741E415510857A4D64606E6DB21E4
      6F4FE81520E50CB02EE0AEBE3A595B760A583FA86E59CD91C0FE3D0FBC6B40AE
      886F12FB664B7E9DC73F2AB6CA769344BC83EC2082C3CCE3D5E574AA6E8E0E7E
      72C5CDBF7AF51CB154E9EA38189DD275E3DBE6C79E20D1CD6D568A354F52EA19
      7A422810D5050B3A749608032E6CECE84B11704EA54455A23C21B2409082B0C8
      F1243530E4910F5B26661ADC36D27C0A3620EDFB0DE98B83D69426758CF8F793
      F8060DCDABC03BCA4612853EDED222FAC492DE51A37CB15746088F8B86BC2F9A
      BE1F47AA1BF9E6F645C1C360C35813A3887B442F26C12C8741A753F542004AAD
      78310922EE78CCDFDFD1FAB64869F6994A070F46A5DCD9822D0B61B79CE0BC74
      E9E288189276F026B0BB484074DB2A8CE3EB7C295E3DE48DF31D7A0E47EB818B
      FF8F6E5F9D5FA88BAB6147BA80A89B3747078EAD120A65B0354A339AD3083747
      07AF0E8E9EFC1DE27914ADCFF220D389BA797370F8768711CE4C46C1B1E6A019
      42BE78F328F00800CB584D40C8109B310B29EFAB11D17D8C864028B587031601
      D94F05D183DEE52EFEAA851E71AEEB144D581A96B38288C59C75F71B288402D1
      FD8EA4AABDE1CD14A8AC12890D0AC31931ACF0DF53D051DD414239194AD3C71B
      4AD67078AD2ECE9CE87974E2CD51B6BEC9BEA59956CFDC6609383128FA70F396
      7E77F3933A691E7376FF2F63E07975F8FA3924C2F0F40B6503549D028CD261D7
      F6DBAD641FA4A15C4DB98F73D9BB04F613E2929699E0102A4222D49B6B2C3BF4
      1783EBB8159C8972EE18B003BEA6D463C3FE59DBF6C793F7D40FBCAAF346D94A
      AD375703BEBAFC6F75A2BD6B1C4210FB0CCF85754C78C3190849B60938C27064
      2929878213A2837336F90EDF6EDE707679161AFD831E8EC43FE2D93F17E6E445
      BFA5D0632E7938FFFBED671E15A8F0C670D8612D72394933ED599AF02C56EDCB
      CB418D923735351A743ACE83157BC5054045C88328AFCB4BE6FCFC9F2ACFC719
      BCBA24264DD8D9E26D10510065EA6793029D5C21AE7376708F787368D8BB186E
      613CF4608E110319FFDEDDD59262DD575F5093C5DE8A9CEEEDF573D210FE5FE7
      4A1F92D304096639567AE794BC41D15B127899FA04168E11222D05DF5F6612B4
      190DD5C244B97BD35D0C7FBC35BCC51E9EFEDA6F17F88EC857BD4FC351A3371C
      9D96F966E73111FFE3B8A4D4F265462FD455FB14296D5B728B9809094E34EEA0
      C3C57D1F314151B8C6DFA978EDF8E7D79BD26B60A45F85E5F308D1387509B22E
      5F2CFD9DC5DA31D7DA3EE0257FEAABFFD7FACACE83BCBA23E76CE864234CD326
      AEBBDCA8ABC0AC1E7D07CAFDEAF37E3D6422593C2E13D6523B4F6CF0DCC863C2
      60825E07523661BB4E3E6EE3951F888623938A1E58E1207B685A644BA3B8B9D2
      49739927DE9CEE58364FE27C266F7A005437F85D93CCCBA56C8ABFC0081A49EC
      F3EB90B843498ECC43686175189A1BF42379684E8B1875AE1E4718BC82B59305
      154500A63A40171615224D8CCC1E0D47295D226DE6EC960645925DC21A2AD103
      AA41145FDB26C118C1350BD26CAB38E90ED703751F7A02E493F778390B23A6DC
      6D78264453A1AE060F4D95A2C2EC89B35D84B16B36E7292BC2B16A791A0D2467
      F4851A7E1C76D4925DD42095F30A3418BF840699312938B429A84CF12FB3DC8F
      DF6EDD74912902C762F05C2573D0B0D7DF793CAA56B9B87A77BFF48ACC0A7960
      72C4791DDDDFECE77BDFEC723A456D551B23BA3EFAA7C37B1F6DC117EABCD5E9
      379AAD4EDF7D84E3EA0835B2FFEC283AF2534F2F8DFBC35F6DEAAD0A23F1A6E9
      ED3E02F98341EA993014574ABA2CC3F2DAEDC4FE24C9832F646710BD5809618B
      2361ADDC64B7F8F9E0CD91FBCBFC282F23B52C9FD805939C5DFA9E0A15C875D9
      85458E28CEC885B0CFFF59D5FF437DD0A91A7A79B8E423BBC300E43570B3483B
      C29B5A390843AB0A8D5E537D8D24441369D5B42C04F34C64524B27777AD627F6
      3DF59FAAAFBDEB7A37727783C9096EB52ED5AF8445FE0FD58AE3C4472056FC01
      CC461A8AB53EBE4CD54D90A24F58A8D788B8D05DA929FB24DA2E2A882369E9BC
      F59056BF55EFF8AFADF316D5CA76CECF9DADAB2DF1C1B576921870BC747BDC17
      8BED7B3F48711BF6555DA516BF82C8608A558BD92A4A7757C793EF50C7367020
      74630322032DD5325165E890FA70DF71C9BE6E10DEFFD8BDC3C3A3FADBD35314
      B4A3D927F72A2B8AAAEF1BB0E019A790A8B642C4F235A125F0C1DBA36F90A9C1
      6C8C93EB54995B4D5625CEAAE5F8BB7FAA1B7D818BE0214D626B0A470787DB56
      C2F1EBEDE53EFE8997BB8B0E60486D3F346126B6AF3480DF2454AA74753EB266
      289256A9A122E189D9FC842C604DC580B0AC02EAC804F3930CCF899158B08414
      927511DC944C23CC4CE0BD13E48F10BEDE60EDD476D968B2538D56DE84E9C012
      174BBBB5FDDF6F55B9DEE8D75BB6C6029C29C0886FA02E38F5036F234E1676F1
      F44A27AEEEF7F11BE8D901DD7CEE2C2C9DF9D4C5A7F373747B646EF2A213A3A5
      064206A195040B731687FE551083AFA151FDDDC60F177104B1E1DA1BEE87A3E3
      1F21F188D2F452B698E348E21B23A94CCDFC602FC0DAFE15A7E1BF0A601ADEC0
      DEA97AF4FFBD3EFCF94767E6B4E31FA1CE87C30E6EFE8FAF5992DD918E4F2A83
      89EBD60E1154937EC49D065C1CFC85C862EEE91873DB5FB93471A45E1D4F82EC
      49A7E5C5D134448428CD7496A75864847D8B530A1EF78C5CBF82D0B2C8DB3EE9
      44C898EB9FA3827BA0FD80A7522C07159D322A8A6859B934A412127F0082EA38
      A14B9820F6CA00ECF0816531DA22842BBD4E0BC22DC23F731372C278BB4D634A
      A59613BCE88D09B1FCC5B294F566D2E8700B19C8A45C1E758266A276B6AE370A
      CFD4D1C14F073FBD72BC335F99DE683581C3134AE7DA0F04A549EC29CAA80753
      3DD553F39483521BAA0AD8442D08D98D1165672ACD73EE1C70DED148DF043376
      D4B2C41824DA9F728A2FB69BBDBFC0E9D22A02C287DB24C02CB1AD6B3892C48D
      9279D6F2879AAC6351261764A909A78FD6694F111E38A268A36D010B3E1203D2
      2356B8EAF4980E1F655E2D7285800E82B77057A7858B474E2985B4BFC51EF288
      A732E0AA680A0740FBC3AC318F55FC45ADF517B5D209AD859EC094B3FD418978
      99E8999C477A53AC498547804AF3770DC9BCF9B990C12646FE96D1ECD44A13A9
      2062D2149DE02506B78B0B0C9A6180AE0D4FAF0BD85AEF0FDA430C4E4C0F1589
      F7E81BF0282BB819AD5567D8E30EB968EC8AEED481171003A7B9E57FEF5B5A65
      BEBF453F176BB012CF6B267D774BD3151169DCF54A3E80BC9154237E3A598B33
      B500786C423C85F407822AB329C06147FB13E9A55512649989F0F582375C8C49
      DB40A3E8470A3BDA7A369EC081276BF54BB375A04E75104AEF681FC071B5301A
      EA449AA77268D8A05199D8F0C12CB2EDB10B439D3E1D94FA90A22E98E6E36DEF
      3EF74E2103DF3A770F6DD87619AA704B15CF484BAF0F5B4992C8F86E7D582DE7
      0DD53791FDB1315B98B0BC2ADCC3644BDF20FC4B89B6078A2BBE310130746F0C
      697B51578C23660BE4E96999327F0E7A270C8BB7A0CDFA66918AD38C60CA9222
      0387B8A1E63F85FFC61DA5E89880AA1098513D2DCF9DDB3486262B124177A743
      E755008D5881B245075A4380CD0E172F4EBA6DB7D10B33E4C1E1CB76F295F10B
      EAAE79309B438ADE08229D9D6FF74DA91374B7A7AF8D9DD052277A81335813B9
      5524AD5298F5EB38AFF44BC64F45BBE41ABF02E13E202D18BE9A5CABEE0880FD
      CA71921AB1CD0B289D306DE204157DD0289332773431403CD2E214552AF7B5F2
      7B28C8F19955EDC331190460A6265B13768644D4E65403689F29C520B84F97B9
      CD0A4BD196FB544421F926DC992F8FE0134045C4095F7182EF70758E4D7D6F49
      0C36574BA74FE4EB241786B93C32B768B5484B34D790EE5B47C22952A7BF1FA0
      E0684D1C1EBF2DF2D3A3CEB015060B180CBD18AE4A43F5911F55E75C4ECABE09
      39955A6AEAB0EAA092AFBA7FCEB619820E2D2B9309D0C25107D8D5899926269D
      33B95ED1BB8DE65227A23D676CCBF16BE46ECE4E4E7BD5565E4837D5818FA6B2
      53359C1BE31C4D79FDCA1A4AA0381A8F3F5F3507E331B304205311357A9A3199
      7FAAB3509997E01A519540167CD1F3D5F9D1AFEDA385D7D7E7D64277FCE1DDEF
      CAE3AFCAFDC42EDBF62525D3B55AC4119503E85099E99418DEA764472970F9CF
      E33C21C8EAC2A8BD4AF7F7FD9AD22122631405C5ED90369D9098779ACD03676F
      12482C0AC2969F8893B4464D1A8B982DE47E6126564DA9E2A5A003B2393975E4
      DC516BDC2DC0FEB6B88D61FA24992CE74608A2E82459A34C0E5EA59E4E8F4A25
      057B9B6BC1E43DC944189E1EE15907E6D67C47F85B4CC4EDD6ADDB0FB8B3B3C7
      723806260CD0FC07760C23CED383ECF641B354265AABB264D3020680632F9749
      ACA537B4945F543AFE88BA4DE31C1D5AD9E61723B7E83A0B1A68EE856C0DFA92
      14B99C2101810F1EFD9E5D18AFE49C8E4C9A21D475440D088A9F0E5587D11B0F
      BDFAD7BF8C05105D5A9C84569E66F1E2208802DBFC80F3037E902666A613488E
      C9DAAE278B676B495347013265EC2264B15D2BD895B45A8F3F27300FBA8B05EE
      135B08C5245FA65C827627E7BABDEBC5F996B81715028528AD7CCFC1C105E223
      37E6409D05377049D00F3CF8C3D4D818C3CAFCF8BA3E4147F032D7C4D707A695
      14A815FED8DD16B70F6DEF290293F5110A8C8626DB2238DB7A93CB68F3E0E11E
      436650C50A45AEE3A99A807383C36F366D1354022AB49538FF39EEBA5980C341
      B6FF3576EA8D3A3B11C4B0A09B302BFE5A861680240F8F0ED5228872E47DB968
      974A8D0F543304ABF76C6EC134304E530813E9C89EC42BD43450751AC93A3BF1
      0001F419DBB5EC87A419D20D4036FB3781108FC32240791B5D2B38CE50D59C2A
      5579940138453145A97CB6E55A76108AE9C52C51FDC76FD1309FA408AB21B78E
      25CF970F5E354415D3F22BA1CE236F0E014273D31E0C9AFBF7463278D4FF3788
      F89C82B883AAB2E3A94A0D5850D2C75F9E8F0421E8B0017B620DD8D350833297
      9B950222115060E261239DC17249308B497965863B5A110FB297E45910ADD59E
      C5D421DCB558069CA7D9B76DAF6C595DC554AF294D16BC58FF858DEDF3DCBC79
      1C002457929E073EBAC652F72BF26D228330F10D3C56A9B394065BB4F19E5E72
      213B9572F12C30FA81EAE2DE7B494E09E62C865C9048093E432D4326069E95C8
      0C733BD7798A91DE4BCE1456AAF8CA0B1CC53CA210D98DA148439A0287CDD598
      77FB703D240F38877ACAF505B63F4D4F2F97F8DFD69D7E6C9BFB843A366C8F65
      8B42D9830D85D9474BE902BD6CA8BD6B0EB81BDC1004C6C4DDB1E5B70B4DA5E9
      8B42950509E9847A49A527347A92E99D85F14487353AC575A6B2D0547B59E4D5
      53A9F2DF088C14061EB6BF90A51C4F3F28DB7410BE2FDA3C1388E90409EAD3A5
      D738AA7FA51A421C61B7D0520FA00F1C10941972AF5B72128626537BDD7E7BB8
      6F9FEF161F213B8CE03A00D3F03FF6004CDB27BB8C7F464E69B771849C49ED7D
      BC68F6F8D19415B1BFB7876BEFE370D8DB6DA8A6FF6F4D2501C3482FD505F5A5
      DFBB2886C52F8BFA4FFC55ED0D4717ED1D97515A3E73D3632278A0C1E4D7B609
      F41EFA1E3FCD48F248E990CA79BC6ADFE9BDE1E96870FF500F5D7DC167A56AAF
      FFB17BB1AF9A51BCD0E1370C3B49D673D464E3FBE3FCA7E3A3E3FF04F7990034
      D033028778B2CE4C7D1A2775FC836A90E5B31CF4A017CAA32508B43DCE1649A0
      E34E9CE3EB2F4314AE81479CD31C57D983BFBDAF5A60AE7FF89DBA53F6CDFF7F
      E2DEB6B96D24C916FE2BB89C7B1F53D3242DBFB4DDED98E91BB25E6C6D4B96C7
      923DB3DBEDD8004950C21804D8006859B3B1FBDB6F9C939955059022294ADDCF
      7ED8715324AA50AF99274F9E34144BA1EC31053CA3D7D93C9995298AC2A6B3AA
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
      143B5C806A6AE73B1A15916A88384A14F8EEF3A0BAC8D02E64D56E9C8FC831D0
      A445E5A03A8939496BE8FC729024B3FFD7DC9736376E645B7E9F88F90FD99C89
      29AA4D51B5C8E5B2FCBA3BB496F5ACAD455595DFD88E0E9004257491000D80A5
      5247CF7F9F38E7DE9B4850D406A85FB43F384A12092412B9DCBCF72CBF89BC45
      A02DB081681AF08A8710F30C8603426474EB92DDDA3555F5D45FBB32CF118CE3
      12041631B0CFEFD75452A2C0B38704580DBD556C55D34A91FB747EB4C788C89D
      EF1F9C57BFC7A7D68C2459092607110089C5CAA4C51E7DAB2F393CFB4F5310B4
      F2B7166824D12AEB81A9C2C8C250ACBA63C0EC95B77C3F3D0CBB8A88D81A7B98
      D3C54E789650473D0C1809DF024B2E1A64453CE2C56AC64F32086EA960C09ACA
      0BAD6AD27D94CF8A5820177A204CB1424E67B6FCC50A6B1F4D93F2C675453DD3
      E47378AA16C684954BF18EF38C58B9DD9FD6087FC3F05CA5A84E062326633CDE
      7A3C05E530FD3B94F240A129C2A63E34A1EEFDE2231CCB14A38558F01EE12B3D
      610462EA2A3FA51963D8152DF9E189D573E6470F772B34351897DD3FF931140A
      72E038EA550FEB2A5602DB67104CE49F7AED422B082C44D660B469F33C9E24B7
      CC0F978E249A4B004F73F9D4000F46F35F070A47B6DF211EE1704F361C2C3795
      D69DAED358F0436B6CB5D0B025541D47565B80ADD8529864C18DBC12E14D5C56
      BCECAAD76B1A8F2244410C5EB55AA9E16819DF8F14FD24520A5B72FEA979689F
      9C5E98E31324696A4A4A7A1E9A2958AD3A15E9FB909F12935A0365F309142DDD
      25464B1B8FEB0A14EA4B9CAB7C40B557DC3B6D6E7FAF53B17BC34497B15F4469
      F8CE76F80DEA5122BA27012D084263B54EC6CBB686A19F2B76499895F120D75A
      F7EAE2FB1858C2CA2EF812817A2A8AAF140C97CACEED36D46EA7441AD50E5FAD
      B9CD94F1885D55D3FDAD54B5AD25B048E4D8335F3860AC2F13E3928CAEB24488
      CF9DFF823E8470805506E624F3BF784C1F68EC5355006E536DAC0B563E540813
      79E0E9744B6678634A17B51E64325FBF76BB194CE8E0F3F7BF88D02C8F67A347
      04FCB22C137FB7BC89F4C8CAAD856B18FF4F9A86AB5C1355822460CA499E62C9
      457A12460DE628224FAAAFA5FA820AE5E9A4994E973B4A4DBD2A411DB98E3422
      5084BADDF5D6955253FFA811C1AE460412E0D4E3896C027902F422238F4825B0
      C29EF535BDD90290D327A4DE845BA45B3EE8B618F0FB83A3CEE3C5E321B257DC
      DAB8F90AFD06F767F7BF0F0E0E84B753C219504EA6550840932B0AAD07DBE27F
      FC895FA3423717854904D7B110365F66E883F4A6667CA1A3F8119CAE7FCBDDE9
      DCF4B6FD3BC9B3D9C3646B2D28A9F97565D2684F555C4550C5C024F051657084
      BC3FF6E37A78D758F9F7ECE2FBE5762B0BBD48CC2D3073C976F62125B5372841
      6E9E27E1EA25EBB2BCA927D5F9DF53EB5EC46303234E74E6E9C9F6B1CF8EDDF7
      34EB07C9D733AC1D4509F5AF8DF593ACFE1BBCAF75C9ABE3A2F201FB29BCAD29
      BA88023F01204194EF150398E3409FCF8486ADB86892B166FB83E364F23420DB
      349A4B6C7C622AB996C9BF3FD2092475ED0B2A254098D92FEBBFB9E26636CCA6
      954F4A00481CC98D65C579C098409A286AF9F1D7B94ACBFB3ABF9C7102197CD9
      4F2DF3C2958EB2744A9F932A2A3DAA6C3FE7BA061F4E894970CACDF2CB8C36D4
      B5A234EE8BBCBE0711EAF8A4C077C6D148FB10ACFD79DF7525D4D73C8F29E9A8
      251C77292CB3636F56A492CF555EC83421E50FF64D0300B3F49304CE2B5EE74B
      2EB8CC435A91B3B1ECA21D8425C14840AB17EC58A760C724CFB4D2ACE65AAA78
      612FD25E8ED0C8975F07335F950ECCB2A48CD9E4852F0BDBD0745A2967F3A3D0
      15F1574138899589926096D6404E538F76E35B2FCF185DCB68BEC7A8CA848748
      EF89C6E7B23E08B8DD324E0385343F204923AA7F5F3E1C7EDDF7EA8A0B905769
      77D069A19F9779C16B7683D4B1BE5C85722BAA50B005E8E115F7F09DCD6B09FA
      4FEC924511BE760D7B8EFBFBB0AEE9EF4798263F7F59FFADA795AB907F59F5AC
      9FFB92151F8B71E2F265C67141094BF52FD7ECEF4B39D687A556E6AA24C750AC
      84E5E8D11CA96C850B99A81FA199E1FDDDAA526E60BAA4D57B34BB4E971579B1
      ECFA0940F8132479242C73B2F7065AEB0F02D3EADFEEF86977DBA9C44AB51568
      2A0143EEEBC39008338500A12A103795D1F317CEEABA1666CC054DD31C9684AC
      3D22FEA08607DFB8574F2966578FA3DB1A17842A35661AA10FF59CDFE13CFCC0
      EBD086773185B1E04814A4E18A5BCE58775886DC25AF2EE09A1AEAA8F235261E
      427998B53669E6CD8E4899AD4D941BAD9A476B50DA812D5F017F7EB219C6D84D
      E278CCCD5033649C6D3E43762F8A726FE537402A496445ABFCD3427FA45067BE
      A74553FA6F9001C38308526690EE0ADDC23462E9882FD12FFE86BFA9D1A67CC5
      632DD24C8B33F617BFFD4E331E31D564D91C9A8D262F4DAB4943413C27D4C6D7
      61A1A0EB51B4E499108AA43DAA6845D4A670F0F480673A2558F797BB17015020
      2590591152A726CE75C54D51C633A42A1F3F20D631DF994E05D382431594541F
      F93E34F7AAEF07062F9650F3D3F096218A6599D2B12AAC9962B797F7260E19A7
      5759E66BC9E640DC9AC12137A4E233D4E7F56E742D0CEEC7D0658584762512EE
      AD0E9F70428966F111740C3720EA87DA0D7EBA1F9C157CD012141891079B837D
      5BD5CDB9F4E15C1AD4FD35C951D4F8D6D41854B141A3A419B14C333A15575F7F
      0106B020D3AABF87A66DC68F5A0AB6CCE0BAEA8DFB01D29DB3A8BCEA1063645E
      9F95B28215C030C31E766FB35B43D856EA92B6EEAC58CDCD5D2E49F549EF243C
      060517BFB30496C28F3598AB677F6A7C6A8142FBF3230700DE18CA0772922703
      4619E9B29E89DCA2556448BB7A40769953135FA3D666353D97819508A051C58C
      8B60367BDACD12EBE1D6DB4ED24A175C85AB55211A342F79AD3BD1E833B28F34
      84A1D5DA53B300B70DEB6A02AEAAC6FDF57EAAD7B65A98577AA0ABAF11ACB3E6
      7F119C2643BD4CD3C2AC341DF89A1E8AB5998913F98FD0F5D29B1B898F5790A5
      82B5A02976AB7EA946E086D009FE8EC2331C90D207E6D0B6243392919BC56840
      52CCAAB1111454F5AC87B04A51CAD9C47BBC85F1F2AA2E82CF9697A0F0A221B7
      834C114A4AFD297AF988A3637505E0A3526122DEB9C27468BDD237550F54A270
      AD21EFCBAAD45749DC51102751A99DE65DE827B0745E278F012E4FBEC49D15FD
      A48F4600263E5EB88FC7DB7B900F9D431C56E4A5D8199D01BDFF3A08AE3ADB84
      95661367BF144F55660145E92ADC4AC9637DD4757AB4BACE5C940F9332471DD3
      7456816184382A2240C4D0C8A03C50DB5CADFB0A7BBF2E1E720D4A74C95C6760
      F0C46128FDE1501560B785174A28BC68730316757FC579B97C70984E327F868A
      C565A92E6BCBBAC815692685BBB9B9B9599FCDD6C763F7A188F32DF7D51D4260
      79CBDDA0F360D0EBBAD881A653F7F209C7C50FDC28B10D65F9E11E41B3D3E852
      55FA45943495FAC603EBC9B2BEF0C6C1E9776FDDFEDEE1853D655060C1BA5341
      C174C78F2AAACA3C4FB25C0B2AA3B9372FBA7FABF3891E4927D6159B7947CAFA
      707385576B4D922D5CB922FD721F1A2DB77485D462CC7A2C701EE162E8C5B62D
      0904936D2AA1FAA793731F29531D5F48B353987DEAFE4CBD6A6187723A74F02A
      7CC3BC338C757792061D5E535AF27DB3DC333C0730D15EDD4DA8796A08B32CB9
      C46F911022914D658FC0D6D512A23C7C1C5E1C3F097BCEED9D1ADB12C24765BC
      C13BA368127D891FC2D9AB60B45F974315A53BAE9C14EE6F6956FE2DC84CCB0C
      0E00205D8C7E396423AFBB563724B53EA8014AAAA2CFC34FF5F82ED295097548
      A0DBE8D87A7E8AF5ADCC08719390BC8A52BB40BBF5DCF6EE8FE7720AEEB9A3ED
      93BD9E3B7B7FAE1FA6F435E4D37045F0D06D2DCC08ABEDAED5FC420B5947D71E
      6144F0E1F02EF701ACCBF507C0A52105EA1F2408F115A2812F3DE850BA5DB302
      0F6DC08533C5AAB75466C898430134E3E6F38DFBDA73370FD2066A55B30A9C5A
      C4518E6C0A1954D5CB978744555DB48DEAB812999DEAADC97182EC82C17A44A4
      8F71BC241DEA57D53067C29057C268E13EA571A012FBC84D93A7DBE537B472A0
      78DD411D30F50DF441997A5C53F6E0F7E77BAECB14143D2F4C0E8FCFAB0B6B9D
      C7398F73416BF6AA55E98E6EAF156596013D411753BB248842A19696C95D8A47
      70BF344CB86FBA492DBD1A652CAC267A0F4C0F2F9E82EED753870F1D393E606D
      A069F6A8E4F71E7F2614D8026DC48A2C380E4A2E910151F8027D07CABC178DDC
      272A3459BD41050A384868246E7D2425197B050FF7F2BDDD0BF13DB16D562D9E
      B208EFAE8860DFB5AA3DD90B57010644FE0FBC6A48330BDD5915285B95AE95E9
      042A12E6AA8A3CCAA744DD8DEF4B5E0ADF819CFEC2C13A5CD08807C283E1AEED
      DBCC9DBB1A41556F8C1349E5D17246B65EFB938D1D359EAEBE2D0B122799CF55
      1BFA2CD0E6147517EB21CC232672F1111993B0E0150AA89701D5B96B3829410B
      9020A575133E31BE80650A7F01818A35EFD28B5AD707C71302DD6D3BEE559462
      1C23567072E98C84248314A2C4E67C810480C6940FED01773A3662B82048C703
      4DB0984E93822CBDDA5154472A8DC027CCB72368BDDD0C593ABC427AC5E634C1
      49312E222ABC2AFE8945911606398E48115B95C3BF2D691500E60CD616899435
      0093BA820A02AC6A9A68FC91DD002131CEB82A02ABAEA844935A96CA2A7A15B3
      93F9DCC59CF5611AADF45D7747101F7403ABA1F4031841F5E0B24ECACC57AC48
      1DB8770D8585F9FDB57161004996AE9E0B4833F8A8E82ABAAC401AAD1C85F88B
      ECD9D5CA142E6B6C301E0DDB509281D9C085450BBDB757835A167249F2B7A261
      DE51600A9736ED63CBA233EB689716AD32C2A7310264E51078007889419ED2BE
      F188EAD653DC1BC45CCFBB3EA955D3AA84EF63002BAC7FDA25C388F691D7B62A
      F01531EF148E16929A5E620E6580613C8AB04B40DC349BC5F4FEF31FACECB574
      4ECA185D86F6D4CAD84693D12376F2554102D556CE8CCBE37BF5E874EF7D25FD
      7D6F4623CAC95931E1ADDB194BBD1632B24462C00D070E3D59FA8747B7875EB0
      93692693659E419B4CE42EE15F44DF984CBD58EE5D988FA516A768329A1A59F0
      AF2FC8BC6DB0298A0DCBD26D35CFD8F54B04E2C193E8A436B37CD25A1D5BD811
      63B0AD2A8F48AB0B0637164780FB5348F73CC275CD93261B21CB6765D57A4F21
      A3A23F56848C47508F91BCFB9CD235FDF6CBB8FD2ABC2182492EEF60252CC691
      6411589516B0F7043045CBCEC24250BE5FB9B4DB4AE40D7120478C40E2322580
      88B94E2EE33E8F8A3C902458A2F4A624CB1925737C6698679F65CD14A5BDA8A0
      6AA94C2D3C2096565028B0253EC1F8FD5326468B44501C8B5DCD4645ECD2DF60
      7C9D7F482B21C6ED69C2349BFBEB87C1C5DA43A7A3A5CCF252258CAE181EB7C4
      042B65ED86E1A18C63C36E7E34B8707F0A6A27D29A2F05FEB43B707F22B64ECB
      97E1DF8EF0B7A34CF315FCCBDA1D47F9E23A59D6DCAFDA683270D5593EEC3E49
      C5D63BD0BE7107AB09BFD3FE7D3233523D992511CCCABE81FD1F69D3B76DEA08
      A4612FE5E02BCD033958859235D96C980DB3AF66A8195C84337D9ACC9272D9C1
      4EAF62DFE5AB4DEFD626105DB028BDD19163905CA0711F3EC9D60E1E7E179726
      B0F019262AB465B73087BD3BB81474BDB16BD48B5058DF68D021144AD71DD8E4
      1F27C528CAD1B1F695AA5475FF2ABA6C6746794E4871FE773C48F808C25AC8F4
      34E88F7B7AD7F071F425A875982134C46ACCBB340BAE53BFCD5ABB65A090F151
      DFD947D900F36E6A6416D9153D488576C4E1890D52133CFE2D941F62A9358601
      BA342FB35F5678B9DE1704B00D5CC61F3917E93C35862AD1F6782C38E8C3C971
      4297B96E142395BCE50EAF87F8C70F2E2AE423F80933620BC7AD24BDFCC14583
      2C2FE58FC596DBC932DAC8FEC95D80A8FF03573B2555982E47347543FD5855EF
      BE4DF2F7A611100EA88E050605846396D15F48D69164D2131FB958F1A8FE612E
      067CC662ED077C410EEE06AFB77BA312A95FE0719357A384A03594F065094699
      B4102AB2C35116DF08BAAFC6A0EE3FEE4976E2CB2415007B375230221F46FFBD
      F6833994E917F6D3F1FD1F5F82999B9FB41EE57078B33CBC5A100F17434AA7B0
      1AA992358102C4D5E212EAE6C51C876ECC0073F1D89049C9C42E6BFEA6F2F350
      CA356CE1E3E48BBE44F762A4AA7226FB62D768EB3FDCF7A5217AFEBE0F6C6CF4
      FBF73E4AF8EEAA26ACDD7BD7F2FE84DFC68664F9A3D41EEAC6EF8B65163CE87D
      1751C7F4FB3E528DA2C7363C4EC7ADFE5E8DE0EBA1D066F61107EF424EFB281B
      7D5E1EE7B73FF5219DF27377083B2B17C7EB734B04684ECF6102BC1201F3491A
      A54B7A97216041E064225ABEB9C083AE13561905B7105A42229C061DAC8264CD
      1FD8A3915EFE04A3F501E46B7BEE05920BBF9CFDF6A2270B2FEEB9FA33AF7ADF
      569F5AEA0A0C9D8865AB3C36BF1EDB76D7EEACFB0486EF52D0406AEB93FFE5BD
      CFA1CB0E8A81A2D38397A8BF3C89508A955F4B8985E55A58110A1A6B1A41C529
      25A29E744D892C988EAE25C9500C503EC7A377D49DC56503AC92985E0060BFB8
      0C0FFCCC3B189B0538406C23498A63219894E22D96DEACFC9A4508963362146F
      D740D24B41834BF9B8C7EA27FDAF6FBFDB74EB8886469F995305DE429D67D8D7
      2ACA527E5365A39ADEE8AD5B374763BC251E62692620B9D20A29C5E3BAF95509
      8C84B23A4D6FFC9D5B777BF4635C71DBE7BED9F76EDD64D8B51F590299E7A021
      33A470713ACA986006AA1E18A27985A8890AF7E1E260FD9D9813AC8FE65B8B72
      B2FECE03AC1A36EBDD1B98948C93EA60A2A98028877021F2C22C85689C2CF2DD
      9620676CDEF4C6185E640CABCA0354D61839B01C14CFE6C00400B588B48697E9
      ABD27F48FE155416B1AD8C9A9F41CAE355D3A67D7BEB55792B5DB55ACA52C045
      2C754EBBC24AF009049938E749B248CAC50A58FE13DA82C9E1A5E2AAC36F82B1
      99CDF9C898F2456D7636BD1926847FD74378D64D404EB34B8B9916687C9A7B6D
      7A9F7778F7D67CC2F6547A75E4A540B2593686C24835039EE30131096BFDF6A2
      7057599EFC035BF454892000388FB0AF2349CBCD6398956536A3732406DB4DC3
      DB7FFFD2AD73CD54A95AF4212193E131671CCB3C6428ADA4A764424F47D87103
      97D0F4F698721DE49F40CD55FC7998B42F34CDD7E8FA5DBFCBF1684F3FA6356C
      217AE2B1B311A20BA981D8241925F9683143CD64C4B4BE813935A36CAAEF121A
      3D6BDBE474B8C1D18C7FAC6A2B6D59856096E49094719D2A8CE984CA7412C275
      7D3A55DBAF4A3474FE6DB61977058D42256375AB42EB8FA2F472818478B02C28
      C1EE1A79E06CE2FAB2B3885B1DCFA5FD61116DF487D16B07880754429EB3491F
      2E0EDE55DB18E2B1A90EB7B16E7285620B22378930D5469F03006E32F19F12D6
      36AB07C998D77DCE76E6F1C479D2138987CC72CFE2592632657741295ADE5783
      512DF156EF8D364D18E7F398654C24CF8CA38C3C14571D61268BC11BCE235ADF
      15B0AB945516A9FEE5591B9D129F49DA7D904AADCAE31B4169FC66AE18DC50B2
      51668F15FC96B419A42CE5173D6A545D5B25AD61F4FAF62596DA73CE7AC9C7A5
      8BE9D47C43E7732F542641FAB32E2A3EEB1B687E79D8B8AD0DAC0CA3FEAB1F5A
      A46532D59C95E51089386418BF9CC26ADBC45F0E4E377F7307104A4852F7FEE8
      7487967779F6CCF7B96FC524B5F836804B002C5878D945B6AA8A88A33ABEDEEE
      60421B5B18C8DCF500CCE94A9965F7610D9F1E0595CA0C521C9DEA5DFBB3E9DD
      9A39CFDA6891290A5A4D600931A1BEC424CCA42A3C5DAB17E541598492764EE3
      56D05DE07EEE86D3688925D7B6AD3CAEA3D0EB3B2A491D2B51CFBA2FED5A3C7E
      95E5E5688152200FB1845D4831D9D8D9520050EEA281B96E2AA7D4E76CD67994
      8EB399DBFE589FF9D741DDE2597BFBE274B7DAF6EAE3334BDDA724FDEE596F27
      DD9B40D1575C7A3A358B19221C2A2C739D93ED0F99498ADCB04204BD798D7ADC
      3C6B737F3CBC38DE2F5C579795330A22BA1F0F4943000EC3494A1E72D6387052
      33F7FDF9873353D5D5705133E4D9701ACF9EB785B70415FC3BACAC020D4D6920
      455510FEE47BFC595BB4A32E803F02D3A0A20685DB5586353C77B1A9F018B931
      CAA6F039E5E896D569B4284A117C99358D43EF6897A16C68342BC9AAAF7B8B19
      2174A977C545F4A1CA9B8122AE276DAC904D6D7F1A02E923FE0ACA1496569EEA
      2681A71A373505A6204A415D10820A4210E7715C80CCCFDAAC7AB64373AA04DF
      E2D40237C4AB200F07751C60DC6848A2E19DE053B2E9B25C46DB853B54CC39FD
      C99B43D6C42B2AB2383BAF920095E7A036A566E4C9C561D59B354D51A67FCE06
      5F0F4F2793222E9157DCCDA6C52E8C6454BF4E406C394B669553AAF1E6C5B701
      79801BF6FA73B66A910A2040A83968D097685AC931CA244D52FF397A598246C3
      6147ECF724B95C9857C3ABD75772299DF1CFD9D42027087BE9A274DD3FE1DF0A
      A6329588620D1D27503FCFBA1AC79EE53CCBC62A9BF8BCB11533063D1668F90F
      4455BB285BA3C956B20D37024EA02095D1359B4E0E805038410A47B00F250420
      C02B5B3E8243E44DFF4DFFED1FFEF087B5678E74897480C021A284151B0BE3F1
      60119029187C0F97D7032E2EC1CC683C015C0922E61525DA3011EA192C127524
      B8CA294891B710988D479F81D2A94EBC2B6ECB390F3D05287F4433297C3C6BDF
      0C06FB7E7DF4991D35459509B09AA7FAAA16F5F3E5A1B1F6D9CDCDE71D9A1F0D
      BA5841872DD87BD61B4968E64636EAB389DB8BAE918BCAC7FDB8986976B8709B
      9255F1303A8450B2F1FFBE405D895778D6A6ADF0033327B09AF5688508C44B19
      C15B433FBE9CADC054AE52922B00B3AD2302430C09A3D16CE8A4C8A1453EC330
      C936CD8CA4A4F4FAE4392253C2E558B27CC3F80A3BB73E09D79F361BF31DEDAE
      D828CC8B5BA67AA9FB92DA4E4CAF5354BF9F354428F3A9FB462205B491875895
      585A3163C56FD5325834CA0C21E97A1023FC52356BF851B3A24EFF156906A193
      4B661021C2F5550CAA73281F7B0BB9A83D1DA22F97C21F326D556188F5EE1A00
      F17997040CDBF54A5D7849A776056321E037555F239A58A58C45CCC96F1ABEF5
      DE62C31ED3883FC1B07BDE228100C9D0CF21B4AFB772A09B819F0138AA67BB6D
      752CF0CC7FCD62524BFC874A199ED5E6EB7C4446D0CEE479DB12A6347AFE5586
      618D7683B244A408CFCC1F5330121714BEA10D33C1AF5E21CDA496660052E0B5
      702FE8C7C55C8E6115305378534D6FF55A8BE9361F59CE2B710ADF1F805A3C27
      F24735B0A8EC8C046F9E30D9F4BC49E83C2AAE544A7C8442860C0B5457557B45
      E23A5666E43DF4E47CC2053672904A255B21C25140D07EE2FB696058516E0282
      D71333148B507937783BF1E41FDE8526608DC9C6AA8887481AFDACDD70CB2DC7
      4431FE89C8514027703278A02689242F7500797CB7689C3903630D86B24FCBAE
      2E015D8EB031AF0DD7749CA1907BA609260D61B2713CC73B28F3282DA6B7AF5E
      0C71D92554D35B256148302DA6441A64BCE9BFEEBFFE4BA3060A0670EC6B2C00
      C6666344C4CCC07C1DEC7B19B816D7F70CC08BBDED8A3ADCE6829015143660C5
      441681AF373D7770F251B6ACA0F98D6EA6ECAED7FDD7FD978D2EF0F52DC098CB
      20B4C77E5BA87A6E9172AAD3BF8274372ED6B8B4F2D21A5DBC029CB7B90AA6A6
      6291567FFFBBD7F8FE77AFC3EFC349A6B81203C3B12165B048317FC10A88379E
      EA37BAEC0182EAFDC1995FBF959D1B8FAE52D39F13E4248FEFFB83254181C73E
      BE14E7DEA33887BDE9F0E4E054E8BF8DAE46A1AA80E88AB54DB3E9661CEA7677
      898569747D7CB7527491D7DEA87B9151C1D5AC77E56C21E39269A0BDA3DD9E3B
      65DD0ABB69F097FDC171B39EA6FA12BBDBD6ACB3FDF39F9ABEB5371B07271F7F
      133D8FFB3AE2812BEDA7B4858E0C6E2BA54F14AFB0F9689D3CB03D6836C90444
      5AC6798EEDEE1AFA3BAE882FE5548C552F1B8F9586D8EC067B8AA01EDFA4D12C
      19B991264227493C1D1BFD554B5D06FE8FC401048AA4E5E8AAEF3E616B430EA3
      5CA7BCC02C43DA92E59FDAC59289FB479C672A8C4C3C4754C0BF518C10447B5D
      D5620890F5E77F738192DB06AAF5262C81A8197B3CCE4D098512E39CC567ECB8
      9EC48B349EB689FE13F174A2F906FD349DA9D225D8F363BB7267B00D39962F2F
      FBDF365E50D7698E114ABDD25A3092ECBA618124D9F83976305F8490CB18D4F9
      9177ACB0E212F3E8CC2C2070932FF7054B7B1581AB2CD58D683A12BB164DFB1C
      EF7D2B31E9C5410688F43419A2FADF6F1DA9BC6A16A9FC3218ECCBFCDFE51044
      026FBA187A2BBC2E161A5D90D67A9816807806EB1D268A2D5849EAFED81F8D46
      ECAAA6EB11C5E07E731D11CF140CB86876171D0B1D8430D57295D26B6D975360
      1AA4F6D462BB3A38DD0C68EBCD8287CF377932731FCF450B0F85C545B9899FF5
      756C792B9582BA791FCFF1FEFBF15792290E4E37AB5FD00C400F2A1220AF9771
      F1ED971CBF5F9F649B5FF2C022A4E102AA32D85B587EDEAD8F934BA8E45CC55F
      23585B415A4B0BC94A04A07B4DF62511A95FD7D9C136ACB877AF8B675C918E2C
      6DAADDAB17328660950B27D6B951F399B1A9E1897D58232AD9D4514C66C934CA
      4991ED99F60CF36CC21CD69225732395D03963FE74892AF4D87675CEE98860BA
      2D50DC5CBEAD2996F2F74CC0CC23703585AA3213B662B0354469C3A658B9DD82
      C9D56DF13CF0B1DBB911317BC96A7D09E46F0355633DB788FCDFCDBCD96441BE
      42F4F3FE3918ECAF1D47F36320F6732A6BF3DD557FFCEB222ECA0B00F3F8C764
      22927A20BB230141E0BAD46F55AA414E94529B273B5A74ADD1AB5879E5538D9A
      AD3CD4F10A19D546D7C3F9054925883D9904D498E372A6198766D7A5267B206D
      5A455DDB6787DC252B12CCDF0BA8E2A7C9A4E8817314E749342D7A6E9A21C137
      5DE60A3D7D736BBEB5FD666BEA406476B8CCD0284B16D436171EECB75DEF75E3
      9075DE6DB66AD43DE34AC0A814F83016DFBFEB506B39525EF5DFFCBB8D95677C
      C54277B2C88C66539AEAE231C3F2DDB2D97B7AD423AC111EBD1D0C940CF7E82D
      E95FBA4436191F0DD792FF86D9C5A3B88F4AC3B77C3915F1FE598C7345CBA8F7
      80A75E8F3394860B242C8EB8C11D9DEEB5BA953C07FEAFCF127DC99271A1EE73
      026CC9E3B8E08D283DB300F71FA1BE4679E026A86437B48F981BD7B9A9675B73
      9324905C8462002213AE5405CDC096DE7AC8343D59F92EDF6656FC6C677FBB4D
      E5F4B90307D22B01EFA4F2FC6C5EDEA8CC40B394ACBE6B5CD006D2CE60BB1DC5
      C62E1A3CBAA21790508F51DE89509C90C2C5344AC7C5289AC718588DEE7770F2
      D1862CB5C8DFC84FAD47D0CB662348A421DAEFAF92E85266CF348E3EB7B94CA0
      3382BC2C0FFD7B87DB472D2E495D308BBCE9B4D1740D8DC65F50AE0A0C71DC24
      A6BB67B3CC711E5DFE1F9025C51A550B074CDF2C17E33BB5153BF0BD634DB759
      E76434F630F9565186AC60B22D43ADF6F9D3EA5A94A1D1640302263AA9481822
      1FD8EA947151F6E711FA49976BBFEB20A1C1A221CE6B9BFFE4A1EDE0F4CD3F0F
      4E3EAEA9A656FCB5D90B54B6535164A384594A4B4CA26D7FEC2321328F8A9EFC
      7353FF39C9DECC29323FC60FE917FC00720EFD279B7515F365C7D9D89DE69711
      EC0272D77D058986D2BD5EC3AE251ADDA120B0245857856E6E7D96E957B6FE43
      FF813EFC73B3512680FE75E2D10038301F81C2DE14B5439851683C4CD64FB782
      F6334D2220F36C51CE21F2417016A70EC6802EC2163000323A83298CB455D290
      20078245E73AEBA75BFDFEAFBF1E6763DFBBBFFE3ACBC6C5AFBF5A0E718C5C3C
      14498F4EF73A2D7773997ED1D45D2526996F5CFDB190F535F1D2F03EB887C042
      B1AD5105238F2784685D9CEFEF6B7C7F74BAE743A3654307CBFFB74013DC0AE2
      7A54375E0EFAD7FFACE5A8F53FABD951D97CF7D57B7E8AA379966E6CE7B32CDF
      D89ECD166A9954CC11571457717C5751F471D7DF39DDBBD8D839DD7B2DB44B8F
      48623CE40BF69270F6CEC998815469129D4FF5E3A0960D97BC360DF2B6867BA7
      3BFFB9DA19FA89573C5F812A12EBDF0ABD773BF1F6F4C8E665FF4DD3F3144929
      6FBFDFBA43D878A9BA15485A0B280E61BE8B66F8143E1E326D7D8DBB68D1B257
      9BDF6F552EE4E318C90EB812C962C9D55A7B975EDB202FB7BADDDBD75B016639
      CF3C31586CA8615361F8A16EB0421A0D34AB92AD58F89AE1E2AFB2F2737C5384
      89F02A9BAD29F12ED9224057898C610FE7B4793476DF98C5273D5ED6EDA7344B
      E39EFB2348AC715E366DD774EC0657C904A035F4BC1182751C623BF99CCC0924
      CB88BAD2C68A8D7017537651A02C59940B68CD930AC5AF668B12AE3B18424859
      48B5362E3EC3D52FCAE3E8991AECBD844F7FBAB7775974461E1F48663C93E91A
      DD7627ADECDBDA2071E2AF746BBCF3FAD652568C43CFF856F532F9AE6A8C913B
      80C8073A777A06C826A64784D44ABA98553EAD38E513FE4C9A50B3F703B8F437
      BBA272A4CEED309D17A55371909E536DA6E7F68B91887C8ACAA118FDF2653587
      A268DA48CBFF75EB2E2E74E3C508EAC6D3C2402B284B0B4CC044D818003547E2
      6B65438273AAA47A43DB713CCBDC0BC154AFFE18C2F817CF79FA08EA0BC516F6
      7F41B8B02068278C2E5FDAA7B55EA0A0E676F2ECBA402CBD3D2DBF3978D36C34
      F8A70B74DC8659F619FA4F3AFDF48CB72523E755BFFFADC5B091FF68CFA111F6
      B7CB8CC2A60D0B5B3EC9011A9D071990E19F58A93AA29077CFBDC8D217C18C78
      A6945D7718979145433D8A71D806C31DABE116A337B2335F84180F254BC850D0
      A1BD2B08D2620ACC896400D77A6E2E7C319D3137A0D05A698AA63BC0A63C43BC
      B46276763F5DC0110691598FB0A69ECA9245F39B7C51F0DDF4DCFBB8DC073C98
      E80F8FA15CEB5589AB93E8CB3153AAF08BA79C7D99B9BF67E9F5F8BB563D29A9
      4536A96B6D32232DDC022706016D1E7D3C7AEFBA97D36C184DF9A7A38F472714
      522768EF056D5B211D2DB5F9DD9F44751EEA2A92D8D0A4AB72166E2C0290A3BB
      E916DC4AB83EE57936ED797E3E7FBF07F9718B543327F63C0402CACED0025D86
      A31C8E58211DE0EC68EF7570C7247567DBBB3FD1A4244991175C6B719ADB39BB
      D80BCC592C5134CCC63784A35762973B67172754D66E71B7F3188243788D549D
      C4FBE2CA2154D02583DB36409DC1E686A207F564CCDB848BD6E9C1E02274BDED
      72137B31A0FC8DADAA2F2C1EC0D23699ACB53F93344CD8C7C55C315E0A625553
      6AC5AEC7C5AC4D84FFE6ED1680A64509BD27A0E927D0F8516D56F36B1F9B939F
      E846DDED6AFFD49B7FB7A5D87C49F4FB91AE46493459143996C38B631277CDAD
      3C2C14A531E92BCA7A6C91F15567AAD4BDA373242759F1FB02A7ED611E8D3EC7
      E5ED86E969EC3211FAA2378BB0AA34411C45CF25FDB8EF7EF9DF67493928B3F9
      6FCD23C4BDE1D433EA6A3826390A9AA706E3296AB5075CAD505484A05581BC34
      1B415CF63C88A692CF4662C2070381EAA32AF736DB1251B4915980B7615300C4
      20D86DCC804A9523567965FEED58B0E4BC80F540B61BA5D9545FE071C218500C
      769F3384ECC15752FD3597E2C9EDA2C0709A456974092B78FD7968B123DF75D3
      E051B761995B3FEFFEDF73D785F69B242FFE81B39C3F51FD65ADBEC1604B6B7F
      CFB3E3C3419BAAA28FC8C449281BC2675EC403E269B04E6CB9E3D3BD9D9E3B3E
      1DECF5DCC1FBF7DBFCFF00FFBF18B4B9B5F1058F762F4E6A9B85BAE55433FDC3
      E0A7335D8D5BBD2D3F6734C1CD431754A941834BE86CCE9BBB437194C4F86E75
      4359F48252BB21B11964B47F7B2FF624F87FA128F6AB9889DA604978B1FEFAD5
      E6779BEFDEBCDD7CD77F89FF5E50EC927436CFDAA23DA54C6DB91022C034733F
      EF1E7DAAC6C27344FE1DC40ABFFE2AB85E91F42CBC2EDA72C0FFACB17E08AFAF
      9942F05537671569006BA33958B3C3414D43C7AF2D8A827A1B195167EFCFCF83
      452590D84096292AAF2E73002F048C49166AFB7BAE18C5C7EFF70FD87B58D264
      F8FC7C74BAFB0C23C6DFB5F341D85A7616FE79B0BFD771D751DE3810A90A3A72
      0739D6D61FECE46CF76FBD15C7C2B668FD97FD370D21010A25C9E32F1B303C0A
      CDA1640C2C201CD787D57BCDFE23B0F0F52065F1159C23999EA33ADA8C9931A8
      8C72F3F8F705FD3C344DCEA229DABB985F4318A3C51347AE8871B0BEAB241AD8
      305B35EC050D702557CF13113AA67934B81D741CF27590C2900C95E4039B5DBA
      F39FE0830250678720ABCF4096592A0CF36CBE98AF30A87E3C9B0AD1E086F939
      A0E002CD8C2248E336BBF0117CEF58B8167EF0759E9425C033A57B73BCD390FA
      478D322026A1461D7F1DC586B0A78C8A529CCD5A58E44DCFEC00556666F04CED
      90329ACDC9649A713B144387C982B212258E19A28C428E36667FBF555911261A
      647F1B48DCFB31A9DF0843890AEADA772A830446D1EE4F4C3C7B8FDF59FFD94E
      E5F724B72A7F069CFA18B62250BE51C0C9FD561B9EE9BAD596E22A0148BFE565
      EA29E56E05D8CFE3CB05281CF157B31A2CD69ADF2C3C67742F8E207B188FB1AE
      F7DC8598AE2445B9937D6D780BE9559F8210E50255D3F0153A39B3B0C2F4CD01
      070E562459E229594777641D7F48E8376C8C009EC6AEB849CBE8ABBB4A2EAFA6
      984AD8720882923BC83A78BF433BE2AA6603053A86826F86688D884988F91DF5
      6C9A0E9CD3404DBE78BECB1E4A18F1EAF5B73DF7EAF55BFCEF7BFCEF9DEBE27F
      5004EB2031C0EC37EEDD79C0BA332946CDFA6D1725AD4AE284B885D93C2A9361
      42EF768EA861565EB9BD783ABF4ADCCFFB5CA27EDE7FE3AD02012A510B1F31DE
      6CB18583EC75820BFA05B1C8A0B6272BBA404F4523503D083D014AA39A8677DF
      B929E36D5CDD4DE3F4B2BCF272AA3CF2BCDD74C3A42CDA4774AFBF6F16D1F142
      A32CAD9871C31B37CB925994BE7AF9D25D95E5BCD8DAD8F0BFE98FE32F4994A2
      04DE1F65B38D282F372EE2E25B4CC2F543C894AF6FBEFDEEFBD7DFBDFBFE6DAB
      73128DB153201B242549BF36507EC7AE2B7B4AE1B6CF8FB77BEEE4E3E0109981
      BDD73D54154E1BAE367AE37D4A7EAA1F8C30BF2F91B0C1560D0620027495D4A7
      3A0B73506D6E7870D7B9866515DBA30491E711A16DB2B12F37DD16F478507CA6
      90A3E8C221FFCC82773113A9EACBABAC28D718F9F878A6E9BA24B776EFDEB92D
      CC77A478B8847B0527120855C2AC4CCAA9B748058855181E85CF2CBAEE58FC89
      4176960A4D1ECFF38C95EBE1E2724D7DEE4021671E54D63A413C42E7ED6B9BA7
      78F5EA7BB7E58B961040F9092104B9D953C4813F1F9D1F55A283823205FE440E
      4212DCA0855911CB6709B285C2FF38C672338CD3E45240E08154CFE1C571BB56
      BF745B8E214250BE671297657DC9A02ED9A0C1E71706D058253ACBDFED608146
      2545C668C37D3088AF15E9692E472CF3898798BE393933D2E10F07EF7643F175
      F51277A379525610273D91431D1F544E540598A80AAA01E384167E63ACDD6E2F
      F04E50C498A9B6BB02B85D2A99DF76657ED680368CDC10D2ABBEBCFE96BB2D20
      A863CC9779544051A0039C6607D28CD7105D681C9306480AC3E8B488A6C33155
      FCABA23A2316A3766CDAB5768684DB5D656B8BC003C30F076D9CBB55FD31704E
      08351F5BCDD0D7DF62867A0D24F55F16C95D54E390D340FDACDD4D5E7119B865
      E0701E5F32FE14F02ED1165C4B8B7EE0B3ED815ADC8DA7D18D1A1432D553D907
      7BB10D7742C027AF5CE10B7FDE3D3AB755ADFE785A0768F7802F375EBDC23E53
      35BBA60B48489C4F4B49AE287C46C88C2DE62E5050C3870527873E3103349A49
      4E793668B72E7FE7B6606BC822A49C683E18F21A5B80C9B8F816164040B5BA23
      963E59785D47ABE1125275DC2C9ADA746EB9C2BE7A8591B6FD31CCFFD62ABF2C
      E151E2DF07E07D3790B00A0FAE8C217057B52C8DC182715511EDF42D61B4DEB8
      F95554B47B172F316E3E32004479DCC41C39BCB1D853B07C70CC047ADFED44A3
      CF8035A4E30A3C4CCF73D923C81980D4B9D5B0B5B1CC7EB56B26860C14F5640C
      FF0E79019B503A81E3AF20E7B260AE836A924714179224B608E629C5011E98F7
      767C8BFC9435F9ADDB72347DADA78435578B52BF5473C5D3E51A65DD2F4203ED
      BB83248FC59304670044494184800D2F9E4C707EFE32BDA98606E23E891BA466
      D7AEF9589A4F758310FD64F4B9F569013E11551EDCB696F090C7B290B4CA23F6
      DD9E0C0204F93DEB6984AA811AA47F04857E48F4810244BB674000F8314B46B1
      831645257982B07A3E8FA3BCE8BB63695121A361C57B5FDA837F4AE92088CF6D
      B55AB5DFB82D55E1BD15A3AA8E29404B325C7AD63335A3268005A806435142A4
      A026816A8B0C04DB06FA04C289C8540503665300C85D6BD7D15C5F95C2A1CB9C
      E61C04ABA075CDA828924B103B14773C26EDC65A23B2BD338C7F3D6454DE55E6
      A650BBAEA54D7422F1A7A8D4303433DF32C92FFD8B923EB6F263B674B03C2EE6
      DEE5D06BC947E9E82AC339076B107D1D0905CBF2865967F2BB21E5CBC5156897
      5134BAC299DAA69DEB821F887E18C7C3C525229FB56748B9BC6B9672A1A61AAD
      828DEE23AF26414009969880C0E32865A5279B08E4D4C0F0321B2AB601796C94
      898BA6EE24FEBAE0623428E368C635B0B8CA1458D6775D617645C567170D81F8
      633374DC4CB27C316B053438530868575217B6D7AF79CC21053B78309925C5C8
      B62CD370AB72E67B797499A5C32C4F213AD8A6491DD4297532BAC3BDCEAA448B
      46248D6E7381CB9BD29115CF569EFFD4B957F048CD12999A3AAD64C903BE4499
      5930FF1FEEDDCB97CD7877BB15D3D7B3CC601A8445982681C479D43DA45AB231
      2C00F54466AD442AD36D0473765D12150E7FB47DB227686836EA64FBE3A1EFF7
      AE504AEA5C92B5BE3B4D0390BA966B8551C7F9DC53AE8168E3B77D24CFA85B89
      14C33A4296C3F368CEBCECBFFEEE2F6D6688096F8E930852D2C56228169244CC
      11A6F2AADFCCFAD38C6E37C6C404D3F376514EDE99544CDF5D545AC9617EAF27
      B51E5805A0E02E55FC32635E6350E6C29DCA2DC52172398C9CCA0C75B136AA6C
      8A2718DEE86CDAF0511208510558B7E338F58CBFF62FEFED5FDAB249D173B01D
      A5678BEB9679B6187A3BA39A2FC85AFB3CB5727ECFB777F735A9240594613227
      7E8FEBAC862D87DCB9AA22500ED2CCF2F14F1099BA1316BD40F4E0F62525675C
      1D1964136C53B1869B9047B00AFD3D4C6789703B9684A0E058B8EEF21C6E8F1A
      7FFD6DAB7170389B031FCBA31DF0EF87677B03C3E8CA1B6A4FF3D8DB079C5E0F
      8FDB47BB3F0AB7B1B30705FDC5A8643F21A09BC64567ADF5A80ED0AA0551232A
      94A7C56852A893546B40DBE7C7A78201C3C0F47E37949CA6B5EFEE4F58C61865
      46AD584AC188613D4AB5F3493EF00D40BF708CF07DD0D08B8D9656B47F15746D
      0E9EF2585085675CAEBB86A64D52195A9B6B3C71906968E766C086E81D641610
      1185A8EF55FD7EA885C47BD876622A901569A60D0CEFCE22D9E06CDF6A2D8DAE
      7FC654F8FA9005D96ABF56B73FEAAE84062F1DA94575D53BCC5352C3C500A07B
      C077CBACD924E8684D44EED5EC12DB6934BDF9470C8C945C06114E0EA10138B9
      28A3AA994AB8086119DB6B9A5D36BACCE9709A7CC1B67F0ECBB1592CDD7B2672
      22209F5CB2F6BCB5B1717D7DDD4F71AC01B59C35E74CBFBB81DF6C6CBE7AF7F6
      4DA35E3A96204D89853C58672E9B004346B427FACD0B5477A834019D9DA10C81
      1DE4C211656EE47134BAC230E85513311F5DF5DC20FE9D85D69E85428C747A2E
      2E47FD6663E30026DA6292424B2DDD5BD59259A2A4EDA38BF6DBD1E6B3C49481
      50B3094BA8ECB5DA4F500EB530FD2F20D432B7733A18B0F4CF85DFA6D83394D8
      69A1C24C4900894E52F7D70F838B369727D14D10EB53F862A180A85A1DC318E5
      4B7F980A903EAD3601EE864AD39DC697D1E8C69D9F6C1F6B8084BDE807ED532D
      EEE95F04518CCDB2E7B68FF1FF4FFBDB673DEEE63D777C386875D636BCD6EABB
      54E6DB68497DC782EBE584D538DAB3F88CB9ADA82CF56390CAB8596B41BC3CC9
      420D314887B571A95C1636BC0DB9273239BA1C67705517C30AEAE2C46311CD51
      4775B3F2B3D568EF68B7598B68B4E3859301EDF55A61E2B39B8510E5C09B8EA6
      B2A1056F43D5327FFA45DDAF28F39B6AEA67290D4ED4D3B4D1D57F84B8C5EEC5
      F951E52828CBA19614803A43974FAA85B2FD62D854D555A6850E75394B5B1912
      6D94AD34DC99935208227755B51FD8548FB0FAC8042C7AEE109DDC839CEC74DA
      6CAF3F39DBDDAA5FA6475F3FEC6F65D17307307BBD334BF2C0C5CFA351BCE57E
      8C12A86CEEDFC4ED9ABAFB80ECCE438D89250BD1ECDB74FD03F0B6D9D77FB235
      3A4BB71C85A77A2A43D573DBB359D6C38B683E02B13E018FFD9BFBC4AD37CE71
      0AC27CF9B077AE3634266C1F19A9C55B8A512195D5E84046A0FF1CC1C16D21D1
      66B6403B677B1744B65A2A02EE69967012FA9C2EBCCC751368253A1B7C36AFC0
      358D902901A7B65B1D9BE56A5C56EEE1E13D3C8F5E14AE4C4C50B17E79FC5E54
      9E1A850C0FDC1BC18DE715D6D116551378F7E6972F4A76DBED47E31F5A5CFDF0
      5E018BBDE40B3496B2BC5D5E2B1AC5073FBBF95596C6336F02AD11A96CCE7AD6
      0C720BFD67C9A42DF1BD787D04C1ECD4AE344198B018DE42CF90AD031FFD413E
      57A123F4250B737D21D398BE5B1034868D403B642C1D5A54FE6A3D26AB672C75
      70E0857E5F103D33D8FFABC4195DA4FEE82529A4250B6C94DC8D74C46899E2F1
      F4A4978C8EBAFC7553D32F4471BB3F6E5B3A817D6E590C292B5E455380B8C535
      4203D93DEC87C7591ADF20666B736F05FA8C2528D520B527AF3E12FCAF16C46B
      A326A4E73784DD65012B8BD7EEE0E57DC65CBE4609193F09F626492F3B0D596C
      1A91320F066A1E73AD48D807DC33865CAD086D92AC51B751CC14B38697340810
      69A43845A50678F2D4222D85D4293A5D7B018F4DCE0E84D3868BB29446EA67A5
      993D96D625D12D355B2DBF134AFD15FA7052A787337A4F2AB9B76EA69B2F4D41
      F2C6F8377DE8A07E66FB76ABD131108C45253891D5C30AF0BD367F435FFE6D9A
      5DF244BF9867445036C404CBFA384B00BAF4521D7C59A214448E911E60E4EC62
      B586BC3A74F8DEE5A62FA8668F1A97EA38AE8DD7C44BB388C25C1E49D2E958AE
      87DBF41C4462F1994AECF405A4A2332F1D2B9B46A5844A2D625ECD188A5DCB78
      893BD2C5FEE0A3FC2B2E47CF014668A884699E1392126C0EDB0DA8923CEEDDE9
      F1F8C0B5BCBC2D52DC100CA22F6D11836B5BA2120CF44AB6EC58F60446995096
      BD1B23B53A28D4A8AE4033BAF1B55882AA3A999C4E1536C8754F3873A6ECD270
      B3D89E4E7F739FF29B189CA62BA169E07CA9F890EE1F61ABDC57F686D77BBC25
      F7D8F4EE4747BFB983A3C1056B2922CD282696B5A8B2CDD5F7F7A07C41485F51
      E1107C18DC2A660813B1CA1CEC590F4D83BF55356BF9A8C0126D70061EBFAD5A
      B33EDDB253479D5A5E49838C481331E442AD4D2D387141310B6B7B42D6857683
      44680C6E8234ED0672B94CE57289D73492EA7885429D6D422039F51E67E39F92
      D21D1E9FEE592C16AADB9BE25285256E73CB65E9B57028078534F83446974D39
      DAFE042E1851391685E0BF4A92AB3139E917DB60EC80915D231D7245695A3E9B
      24E2A1AEB77F74D4FA268334BBBE71D72A9719663C93AFE1296D3B2FAF665996
      3FC326F7EAFBE7B7CF21691F1B16237906F2804AE831BC7D931BE23BD4B2E9E4
      231B838C2C543E15586E808A645299D78C4D618F1204C358AD4F1B16FE05942F
      1EF64A79CCC4A7B474A8952AE2BA1574AE83AC3FDE8AD4AE8A8E87205D51CFAC
      9A87824EE6E3C665944C853228C845ACE1B72DD01ABDAA86108C31F136AA4B8F
      90A252EE566B5BC9A4B1D1423F814433A1CE4864FF7D319B6B9931B21E7D9E97
      C68E254B35CE3FDB2BC3D91577DB4F11269F6549DA0C0F214BD9804B1901905C
      9CE5B7DFE8EFCF70DF7DB92F31E73852026A1039427C2880C1AD1548574B23F9
      AA3A3DC64004B70A06B30D8D5A8BE373ED25215F0245FF9BB03E82A71059BB18
      4B0336381159892EA3862C5F2313AE8BCBA35E0F7C0743F98FB0F60B7B2A0314
      12DC58B604D10067336C4D858B380531945A78C07208905895A345A61D9C1841
      4B369CF9C74457498E962D905F9C2BD40A334D327DBA250372F64972C65B06DB
      8BBFCEE33C01402E9AF66C79154FCB68593CEDA933F575FFDBA62E7BE40BAA2F
      F52A2CC928CE85F97F4760D1A4A90DC540C1073B48BE6E893911A73026AA6828
      E4492178495A43203FD1992CFEF18F9B8ED29E9175CBE302F1A299962F5DC684
      24C9FE954B626DC71138FE1D8C6BD4CA1D44612F39C2E0CD256F50D734D29CEC
      C8148D468B1C35E86C62F3ACBBE9863765BCB67C63613AF4DD8E1CA899F90008
      10F977E0A52DFDCAAF91985EDA7600F286B64E9A2C9B217FD3FE3D2D096215C3
      372F6F5DE2B55CA2730E4D789C229525CD58B9DFEF77EE2355A04085692ABEBD
      12654B5D8112965F924B09EAE14DC79D62FDCFEEAE1BDD779F95DF918E56D038
      965AFB63A52EEE8631765BD55D65C74B1E57C82AC0EEDF304ACDE15850B1DB51
      57F10247667E21EC69BBC61A7264FC894389096423738B6C1682190E8D7B1FCD
      38FD2AA3A45937AE903453068C7C968D1738BEF0764CE04D23EADEA9E890711D
      1650F6108D69BACC5F2BEF229A5E430844D530401095EAAD5135BA71FFB2AF6A
      0C07A76FCE048FD087F1B0D07928BF040B972F713E8DC442C17A5B0F4D55C949
      5BCBBC20A72DADDF8B057349114942DE93502E4F061F1D4AE4581C5E1E1B2B6E
      816BC86E239C8338C76BBDB76B3F6D9F9F1C9EBCDFAA42063434182521255A5A
      2D638A0DD6342A535F28B089CE0B68B6E958B39B791C7D962124F40FB9041F52
      1D1593C27E8B105769B90A211659ADF4466D64A2E5AE832EA397DF129DF0E9D4
      D463590239387D23665C32EC48E065A7CB9CF0EC89A23E56D9785CABA28E61B9
      CB72846FD39B7BFB54A4136A441FBC2186E6E8A304B97EBF8777A6518EC9391E
      33E31C5D47B0DE067032E8C5D859861250F805A4DBDCE6FB1D15995808A253EC
      0823F77673989495A5D0C47D62DEA7F5A6F6A6FFD2EDFF7CB67F7E78BC7F72B1
      7DD46C8793C7AD24C00A042FEAEBCB92D5D249ADA75B9AE26D67180D1489916D
      2358C894E20638C5384E4B595D207C243F42F9A0CC748475D8B9B41A00E9F132
      4D26C908C38B36185ECB3243B9187AC2CBB618BA9C04DA18E4B8C23D5E51E4CD
      CED9992E530C0FD3E01D668B32AC9EFB35659615A5014914E5ACD1C02C8ED260
      3DE4402A628D310BECAED71849E1B9D27F789C8C9170E71F6E9810A77F5D1749
      52B139ADB2DAC5ACE776075595925924DDBB2DD4E62CA2F34A54C66B14C74B02
      82B458B2C81047D3AD0FB5942CA82D9BC962F0976602B603CFDAE418EDBA5CD8
      C38BFF7D51705E17A64C2595D34236B9A244D77C8EE3B9F43DAE5BACD5EE8D52
      4770F3AB04E333BC3DEF7E516BBBC2D6E538B1CE8F9FBD3FDF937D398EF229E0
      9BC67F689C7FF7B7330C5D82983B4A13914F6A76E19DC52592393CAC488CA627
      F4D11568C41A5B083DB92AFACB42DA8C4D7715AF163FF08FA7C35756F1331C73
      72B7BDFBE3B9FB85B2C22F5F6DFE869721A293C029A1D5D5223B884BFBDB8059
      FF3273A773CE675600E40BBAEE1671D977EF13098575E3E0C92AF7290A14B599
      045DCCB51F2A0E5318BCFAC39E1A3E708FF20A48D838AFE12BD393C03B995441
      77600B13B0FD4C1BC8CAF052C2E0C9DA4F35A82EE0CCA6C158ECF7E8FEBFF2DD
      70D2E15CE11F59DC9BF0272602B876D983F4644E4E93CF523D3393D31787E15A
      2D47D0175EA4C2DF118CE8E64F5355447458A3D9C8BB5D17B5A48E50CC5D8C84
      896EE8F2A8E61DC763B757B58D4AFBE8380E145B556B0B3D474B270D057963F8
      7CC859AAAA345F4538F300B0858060B9A2F2F46DFB75D363F37B8475032BA776
      DF1F0F2ED68C537F2D756B3FB829630E7E0AEA0999546DC19E13210659191A32
      B53429A26359E56A02A80693BCAA0A82A84136FDC81DD0DE975F6EDF85CBC7C4
      150714DBACF52CC47AC22CFABB32826CE84660F2EAF9238882865C717142D60C
      4C52ACE042B67B8EC62EF40230B0C3C124C9B19BD22BCE9FD0D3AC4C46422016
      B7D496378ADC6BAC74F59B305F164D19F280EB19013BDB78E7AC88CE51195F42
      FCA2F3A3903C873734CDA59373C7B0DB228C2A100E8EF1661A00D4C4511CFAF0
      A6D2E2C87247954AE96184509771196CAEE6B61BAAEB572C8B7680ED7994F35C
      CB7DB0BC72EF21DFDE70B2C2412B9B20C70F1851DAF1C26850B9C7E6AA9A1792
      10A668B2DA6A36F61F1A2C2FE75DB2788806474FE20461864E20F3F610046AD5
      A4E7FAFD35CD4C8FC24C0D4387CEC02FE39D9EFFE9244B63393F740EE92F59B5
      A099C9AF0A7E4109595219926FB5C28E65C3B3C92401E3B995F5A284765BC154
      131399EB3CC3C1D6304AD088A831762B58AA6C580948E20CB22CE08EAC9BBBA2
      B6C8D6AFA9DB2D8F13A6B01AF9AB357A041A33A2105C5EC354DE9F84629CE993
      62A63356F22601906034C5AF7CF0DF7CFE7ADB42E54D84478D8EA787A9AC58A0
      65DAA1CF5CE17E5F506C0E0AB04CB154CCD2CAF39A6BDF5ADF6DABC41AF6034B
      22500A4B7831ACA77985B0B1DBB9E9D4D853165E0424C0BA833C3EED1B2BA867
      9FAC695565C70A6ADE5F3905FFA738622ACA59721596781F25F96831C3820E95
      B3D6C538A59C442ECFB8FD514C93A94ABAAEFA4C2B6319947C007F172B548BDD
      AFE5D8C6F580D96E0B250497C4B4A3203620E5D47783CCA7F2B0B2C5519170EB
      8EBC23105678983636744C45A20259F84B77F8E20B2B649799A8DE53CFE58776
      C595574DEB15F518112F5AAA3EE3201B9336742D3DB0689F1544AC2367386A33
      F9E2D512E5A6A6106C85B4866181DFF50BD7E52A6C6239115802F0806FB84159
      0C1D246F6EEF44B2AC88F0AEA43037A44ECE4466E4FA655C6C62E07A882313F5
      FE904BD96CD8AF78F72004C2953294B02EBBBA9B18F60987B4396A638CDBB51A
      E90149CD1EF8CC16C49C4956214D07853755ECA224AF3D81429CAB68EF324B1F
      5FDBFFAF6C4149328E6EFEB49DC76E0FB8E5FB02F7FFCA16984D9CA724C75F65
      D3D8660882C4BD6CB440EABDEFDE23BFF507F763364711620A9DAEDB49B63BA0
      D30F6AC06ABA5B2A243225A53AEED60FF15868D1E18C8F53A5BB7ABE92C67AA0
      A2F0C840C7899A57D10AAD8758E0BD2E52E4AFD0F9F1B5E99A7839DE74ECE79D
      5F89FFDFFFFC1FFF1F5ADFD7CC}
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
