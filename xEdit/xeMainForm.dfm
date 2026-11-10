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
      C94C0B89062CF79EC63191542550A3A292AE8710BDCF397FFB8D6FAD9555057A
      582EA49EB323768F254165563ED6F35BDFFAEF719C4E8FC63A4A02FA8FB79C1D
      1DBF3B1EFB663A3DFCEFF1D446693A09FF7B3C3D1C4F93559024E3A937D77162
      D2433534336BD4E7EEC7FFF5BFFEEFFF6BBCD4B13F4E266F7E381C27FAE8C7C3
      FF1E4FF85B6F7E1867613A5703F37B6692544D6DAC7AD657CD2C9DDB38515912
      443375DBF183F47FE129F9B3F829F48CE3B7AA3B556B9BA964AE63837FC56A61
      FD44D9485D98DB2CC12313A5235F6589E1A7299D28AD16FA5F36569E5D2C6D64
      A2540591F2CD8D09ED7261A2B4A696A1D189519E8D92C037B1F26DA453CC48AB
      64A1C35046B4347CACDAF4671BA9BE0DA234517BEDFEBE4AADEA848B204A5213
      373FE3C7245B2E6D9CAA746E948D66160F2C0D8BC7A5F32051A9B5E1811ACD8D
      8A8D67170B13F9C69739D8480589FADF4787FFCFC1630BC3EF1A24CA8B332FD0
      2186C74C69DE3E56C9C7E8787A1605E99A1689DEC5B3511A07938C86AAABC8AA
      854E5313D3AC93E00FA3EA786E10DDE830D393D0D0577D6396E15AE9E532365E
      A053E36F4DEF9133F065AED3D789BA302BEC03CFFCEDC1D1C1BBF83FB79F7178
      E719C7FC8CD1F9C7F6E0B105694E6C96AAA3DAF1BB437AEB204D5412449EE1A1
      7EE7F5EE9978667CD5D7A937C75BC6669205A11C9A741E1B535FE9B55AE06335
      D58A8D4E8D6A9B30D5F21DAC053D4405516A554F63F75564572AB659E4D7D338
      58D6D4CAC6A1AF92A5F67086A68949558AA54C144ED52A0ED2D44438C589BE31
      35D5B3716C5741E4AB990EA2445D347B1D1506D1359FED81999AD8449EF1D5C9
      BA46BF9A67911F1BDC84A9F2629DCC4D5253BE4E753DB449A2963A9DF377173A
      9CDA7861FCBA8EBD797063D454076116CB54A6C1ADF10FD4E7C8377164743AAF
      D13130D12C880CCE4668A319EE87599A882F1EFE9E2526C60298784AAF18E30F
      36326A16DA890ED54C2F0C4F94771B8BEC276A15A473ACE6721EA8A337DB07E8
      F8EDF6E61FFFC89BFFB359AB79309B87C16C9E261B5F9B06751CBC30C07FD3DB
      373F948EC4789285A149C7A99E6C6E7C5D19DC0159036C1E6DB85F3A019A7622
      55467B73B50CB35910BD4E945D456A415B5E5389555AFEA26C14AE956733C886
      D5DCC44641107969A643FC61AE233C3DB10B93CE836856E90D9E7C18EB4A2B9F
      3EB5A44F4D4CBA322652E9CAAA1B1327818DE8DC6848892C3435F7F613ED5DF3
      93B0C7D3204ED21AADCE2CB83109CB07E3D9C8AF34FF2FC59D48545DDDE830F0
      D5E5E970245783CF4BEB7CF80F1CA6531D86B8D06FE9B7A1A625BFE7F2A8C95A
      F966AAB330AD762EF2AB57E76B17BBCBC687836E616DF30AE27A5FBBF9CE8D77
      4DDAAD13C7506CD7915D25C5635F272AF04D944204C71924C05E316490A8240D
      C250DD0466C58728C00523C1441A6ABFD24B0DF50D843F0E026E3B8E1E96AAB8
      CEA1D1D851AD7CBDD0D8FA6910D2358E8D86424DE80BD5F6B9155AD2ED581D4F
      479E09439E0C09163F486DAC9254AF31C6D4E0BA44A4E3BDD026B83735CC6319
      9B2451D7669DD4D46A8EC9E59787C47616454134E32DD0EA4B10F958F5C42438
      DDCA44BE9A9839BD63185C1BA55564E3850E79904AAF75326CC6243AA65918AA
      7EA8D7C394D5F5D945EF5439E92A26404D9D98746E125FBF4E546A6ED32C36CA
      9B67D1354D1B4AD742FCDA18472AFF805DD08B0736AA6D4A6FF77C3E94B19966
      89F115D91EDACF954055D1D236D3200AF032B899EEEABDFF41654B1FAA1EC6C5
      A74E7BA08E7FF881E6756AE385BA6259A28E0F7FAAA961AAE3696070C3A10727
      3ABA56915E189C645C17E3BB378AD6A47512A5BD18BA0AD616F445F26475D072
      168C8D93C74C8292755653B19D98389D5D1F1F1EBDAFA9BFC3D69AEB485D2669
      9C256AEF5F134BFFDAAF29E35D2726D6F31A44A0C9223F9BCC6B0A2AD66D0BBE
      790D334EB5EC6442B75F274990A438EE074FB6697A64A49E1A8DCD7FFAEB9755
      59A5ED6E160A0D7A708D1B05319FEA6B12ACE15A94583AD7A953714E8941B189
      6E84895568C48F2A98928EE12F24F20D561B7A01A3228DD76C5F903C27836115
      44D5147A97A4AAA743A57D5FCEEE42FBA410366601ADAC6CE4199EE0DCAC951F
      4CA7D027C554F205710FAB3EB1265D639D06932084D467250C4B1DBF86714E66
      10C626BD8BDB8B95E4554CC8B0C0CFB159D81B1DB219171B686EFC44EF536962
      9D92CDB3D4016632C14E6B7258D6F87DCD5D4ADE3B362F69013109674838E389
      8E073B4A1AB2BAD2AC2E9CF5951432E475A2229340F05CF45B6A69623184E1BA
      E82082ED999A05347059585DF45BD0B6D18D89528B9386AF5C4EC2E006FB8927
      D14AC2604D96260CAB6E6FD9B6F274A426B291FEC7C220C448EE7AB478DFD5C8
      2ACF2E699D5564536775D1692033D3A67313579A145C9B6BB35ED9D8576190A4
      AC35BDB98A706E64A49A5AE152D3B9DAD2ED8F4ADB3B7667ADFC4AF7DAA0CFB0
      B24FB65A370D565ECE3B13AADDB1616B30B54C80255736F62BCEF91EA33C9845
      16EE55330CED4AF5F4B5517D1DA7810EF9441656589C4589D253C89FDC50B3B1
      4A4DBC0822D2BBBC20A1D5154DB1CD6DBA67B250CDB93CD7252DCE9A5FD6BAE2
      76164F2B6F2C498D95CD42BFAC217820184BEBA561CF9C6D1CDA4FAD162649F4
      CCA88999C2702A094C36D3ADF62BDAAB4D0AC2C4BEF2687970A0EE3850D830D2
      F7986AE94FAF1399B89AC676C1A72BD530FF68BD43A32339803066CD5264A67C
      C7090979918AB327D39DDF1FFEABCD66F30D91A323910213E8E1EFB9F95F1E8A
      62549C69C9E58357502F3F135BEE5C3BD8539831395AC50C5CB4A4F0F86AEE74
      4466A52E976C0478F0C826F6F623BE918BFFC2B982A008C5B6E12D67B1501AAB
      D2FB5DDEEBB4D2A3C9A9A557A6F8DA2C0EFCF2FBD24B6CC541BF47F207517D61
      16365E97834C85E96EC9A4C03CAEE066E25BC91CEE12A9FE95CE27E2DCA924D5
      5820DA163A3EB9C4FAEE2354F8BA7BCFECE36E3BEBECEFB1BB07F7A4DB66DFFD
      830A118135AC189DED02D321FFF2EB444D100D663950A39D12E785AD7DC3AAD9
      098A62D44A33DF8C25A4B1F6AE25E4573CD86D4564532CF99AC24A7C7AE93516
      7A8DCD08221895A1492B8AE848752F4E2F29DC4BE6F43460A3105229B5CBC0A3
      69742F9ABD6AFA673B38121B38C7083CF052BE4E5CC0FADAC0605313EDF3F5E0
      D79F84D6BB864896100A2F0BDDF064635F131AC55B7B38FE9C5BC05AC1AF94B0
      5D68ED75B6E4184C5549AB3D8898D77472C9F7E7AB86DB142168121BFE04CD52
      3E4D07A9E239C11239FB7F232A453639A20291AF96A1A6180244985E17026E6E
      11724DE766F1E4DB0AF9C0E3E1CADA55C5F38D28AD6A858177ADFE43719E22DA
      943FF036EDD24489C879848548DC90B9F0415211D12C34F51081683FD0A19DD1
      1ED3272494AC23C83E5A00892CB14FB7C8C234E06F4AC009DFC45F62E4A2F6F2
      14089FF67268A09A306AFA38AD5E182C2756C394809DBF3051E66C06F7E6AFE1
      C085D9225273A39178DAFBCBD1DB9FDED5D4D694B6E213D566F529A01C9078F7
      4B13739C31D624CCE8F11CAFE76BF529F08DBA20536138B72B7C4FABC4A4C88B
      55D64D4E2BCB0EB2E2C18A78360CF53231CACA272805338B6DB63472C527F656
      A5B1319507CFCF5B6CA6B141040792CD845396A641AA66D62006ABE14F38734C
      76C6D96B649F92188108E183C76A2C4D94A79DD561439BC5954DD09B200970FE
      FF3093180A380E9664F1F83ABE5649BACEE3E374CDE972CA902E25932C29763B
      37264D54867C8ED2EAAA75CEDF7E064585339425CE874240E72A8891E150A3D8
      185A6A9D14978C729DC5B5247B388DC3BFB6703982DC150B8D8723CFEA20794D
      862CFB63A2C513B547DF6B86E95F5BF85210B36EAE181AC7C9E61417BC8F94F2
      B241612842239557D2AD79F9E3A49B161416092235BC5EC7C1E275A256462F61
      A4165FFF58FCB1F4DBDC53973BA1974BA3E1C7C00D7BB2AC3E27294B2155E307
      D9C205BCAA3B8A5E9A2F392281741DAD0E3F284ABBC133E5912A9EA5285B4C70
      28615044FF325E4A1A4A697E7CBD787E7D1AEA599E9448391A86DF41F1C261AC
      18E34E31A6DBE7CEF0FCC00F431C597E3D09DCB8143E1486FB2C9F5EB296DB7A
      8DBBB934F15BFABA89D8E2DEC8585D0D9EBC8B1D4AB45616709E8DA661E0C18A
      0FAF6BA50BF73AA16C30946C2C96CA5E0B4AA91BA5B696EF466DD347ADDD1738
      F92583226F668876D387E9CCD9D8EC3F1454A0F892C25A8810D84A17E7111BB3
      DBDBDFC952CF498778591CE39AC2F8C3A9826A35B7E907B13572235E7BA210C8
      3EA44FFB7922248F379ADB6A8ED990336CF11DDF5C73324E9E4DE2DB2EDD4AD1
      2CE44FE203C4E5374C2546A1939DEE3B434F129BC51E5C3C0F4E6442597A9A90
      5B13A4C3354E3E2EA20BA8578E463114006AE45E38000EA803ABE093848489BC
      30F38D5F4DD66FEBA79AFA7BEBBCA66EBCB0CE2AB59EA54198D4D4DF131BB575
      AA2F27904B2CF4C33FDED67D9E9B73A55D8C278855B64CB0150BB58C2D7DE7C9
      499F936C46E9AF278B084EE6567659EE4BFF0A3EA6B695EEA5CC6B9E1A26E93B
      31F300B15276C7E46938DAAA5944B4102B886706189FC93AADEC5E89045ECD91
      07A619D3143C1D215A3E314580CE3992E2016DDB1C13924264DAD9C8657DF889
      88762C754C1F452E98B2B1648E52F63949EDB2DAF47F3666298B86B49A8F2B24
      4626C757688AB02824DAC9BE7692EA8ABEFB254CD00D818F1B4B2FB9D09430C9
      551AF6F623B63FF1E260992A734B2ACEB766A7778D8DB89E79F22C0D90E6BBD5
      5E1A8AABCEFB541C1D092B53CAABA21D01EDA2B43A48CCEF2E92E78453E98847
      C6F8D5DEEE34B8550B1D44CE26550ECF108672F9936CE2FE465B9CA436466C1A
      878B607301CB0B3F8BC9FF8246D1619090227E7AE8CCE9646794B1465AAEAB4A
      83DC9C2F340D479E3981ADE63AF63D0B5525F1330A844BAC1AB21A1A9D4EDC6D
      CA88C5EAD6586E0E26D7C132C95F91C36CD855AC2404ABC30D6837A93C67A0F9
      04532A6D1AA49B7228096D5ACA22545D2FA04A39BAEC6283B4522E17CE539228
      342B8F6E5B1D1E1E56B31870535CB660AE239F42B96E8F10E58215B10A3CCE1C
      E47F61811944BEB9855B8213974A1E45D2B8BBBDBE9C005A71440A37B2FE1521
      424647D952FC0088413A0585C020334E3EC4AFC73BAB740895B52E825BB231D5
      6EBAA5145DC9E5E48B90C72657418464B30B0C44B0D776796D18E00EFA534AA2
      C3D8543A8EF51AF9247D1B2CB2C586F8E408A74564868369DB81D5A77B8D56FB
      05380B0670C5B341265C39882E6624A75572954DF6A38D8B9BBAE01C293CBAC0
      055D4869015792DA05101DE17AB7038BF009F2753282B3F805100E80158433DC
      239A2DA561975A002DA622BC71781D2CD5C12C80EB18FAB8C2A41BB0758C2B0F
      2DCE310DCB9FA834CCE7283633888252CE38D7BF4E2B91A1FA5066F1D15CBF33
      894AC03D427E68EF1AA139B8C136BEAEEEB171343610EC9F4B3CB3F11573A900
      1030731BA75EE6C22FC182D3BC7140B046764720964922E62E2E6D243018FC38
      D1BEDABD0BC5978B0FEBE43A7118D754B4F812D2ADA2F57A1F06B1887652BC8C
      CEB90BFA245BA0440991D15C456DED301BB1F4387B9772525A168E2DE47C3FC9
      3B652C424504844EE682E8A31C8C984B929905EC22A2182CD221B0DC901A612D
      5ADEA6428E9064D9C1E301A452F65CAD346E4116A5414831FADCA6DA0A7B6CA8
      5E9A5C8BCD0C313A1058E08001E547717697A804A97C11C8FA427E7203A4F43A
      51FD309BCDD6FCA7D8009C07F9A5097398D285E765865AE652163C009E9803C5
      E6881287A0B88B797D540470728D6A3E826419EA6AC2B8E52253B149B2304D3E
      A8D3CB37AAA14E2FAE54A46F162699AB340E34723CCAF8B33CB1C518397EAD50
      477EE2E9A5919BC29F393151302B708A1CFE9E1B8AE22DF4B2C8667A3A7C9EB4
      6509386D2124203E28D91878F026116CF2E670196C4C38B3D42C96C8FEF36F2B
      7B21B00A3C0F40E89BC072C211CA1FE8250A8FD47518D0C14C6CC8E53C983365
      74451354D3641C8F9A1ABA98E270D12BE78611A726D527CA94547CBF30E501B0
      7B9B9906CA70DF03568FEDAAC818D07D006EDC0F80A94AE52F52973125D3CE55
      4009149D3E8630B7A44C56318CE51D0CC8A6F26D4615526C3B88ED46A1EC20A2
      7FB20AD00930D680ACE06FBD5DCE841A04DE9C22699DCB2CBD9C0E248C972883
      C3CA370228D6680629828283ADDC222399F7BF036ECD2B48F954AAB58B5030C6
      1E6055B5D18CB61EA3423BA3B0139727D140E696CC6E1BD5FF30B12DC3DDB1AC
      ACDD599F569A435D67A925EB1F83D14F18914171089CB0125D58DFC0AC580409
      69361BAB2C824C268B423EC492991C92ACDAEEB2FAF94C01929AFC3430882DF0
      622426ED0C7BA2CAC972AAA93A145733F2499D39FD85BCADE79965C97776186E
      46AB227D4627814A19502B867722857D309BDBA4AAD151EF7D50BDB53A23E40C
      3D7686801779A3B10EC89A84E591843A993F39605A1427285E9CA79BB3CD30E4
      D954DB90B3CEA91A8F55BB396AAABABA8C673A027C8B2C98E0567D8E302772D4
      F166CF8F2A18744E0798C0AFA3CE794DB53AE7E7F453EB7C505357BD661B3F0D
      E9F8F56318B6E99A6310AA4EC68ED82E5392B4C94BA01ECECF551D9AFEC6C4A9
      6AD345CC8C1AC14DCE972585382EE55590C873A520D746F52EDB23E52D45A73F
      FF1C5B4E5926B22A832C02544F3250AD51BBA912587FD766FD02C35F34AFBAAA
      AEFA71162144C308C88BAB5E37F7FF5FF0D80CDA4355579F82282DEC244E1B0F
      B41F642429526BA5E2F905CE47EBD34035F2F9F481E24E52756E3DB665784374
      249A8B301F2F310D44564A4730115B60C5D1770AA4B1DE2658D52660D055012E
      02A9833A7EF70EF6C3A8337CA71A6A38ECD4D4E9E55BFCE73DD7460D4F8F2A4D
      5340E25C5B95A7A1832848E65C5AB075891C2C5023BCBE942FA35A4CF2324F5F
      C8C744E8E9E59BC6E9C555357BE5E20AE564C12D079C01ED91385B6AF3BA1375
      D669FDCC1912877A6430154098887558B278D999E023C2AE105978899A5F5C0D
      3BCFF4B2D8D4CAF8AF61EBF23CDF37572447016B72A8D869FB1C05BF6746353D
      02C5947D0594DE10522DD4B083C833977B5202FF3DFFEDE877063FA3F6355BA8
      0155B52DB2844277CEEC226CDA34A02AC4C99A2BDE5E4297B43ED5D4B03538AF
      A966AF7729C2016AAEC6F1AC171AF8A27B4A4ACCA59E8773F83489EA9F0C804D
      A5D38A503A697D29D57BB6BBF5B601B151D919B0ACEE17D6471E1A1640B0017F
      95D22DB24B83587E4480952ABD9F7F2D4F2F017E5175352CA168B621330CB7E1
      1CCF0B4CA1A807AB8BBDB859AD0A117EF813031E51D28A9F7FF8417238549D1A
      9955087DC1B930C19B6ECFD415897298BED2F6575514C3BCC03637B25C8DED07
      F5651524469D7DA6F49D6F6E5D0497E1CFB5BCBE5187A5425DDA8C1CFDBF0A10
      A2E72AEDD4A19BA546211131BEBD1CDBF5B48FAFCA9373DC17CD5E29F911073E
      9724329047D25FF9ED8C2CE5A576097DFCF27938C2F15DE9A53AFD7C7E4ECF3D
      416D009DA196E393419090D0BBDF21071EF670D886AF9ED64D6C48297176455F
      23E0C905A48819DD10844E1C538A0FF2C7245022EE2BA57A936CC29909329090
      4B71B93E7E2061957FB883552EAAA4AB83A7A759446879D193453A4C87C12C42
      8480C22838A051FE3BED570CDBF8BE3A33693711F940565BF1B3C35DCD32427B
      8AD4642D2E9123C61DE0E0CD0CB873786A49E9DF94270F0D3D01443A26FFEB0B
      E8CECD70BF8B9B31EA84FC2FC980B9142EE2600E725F4D0449D023DF358E352B
      2D3135DCD99A534F48F850727AAB94EFB9D80B7EFED26ED29AFF3CECFE83A3A1
      C00E4180D13469D7563160B6BEC3DE560C5AF9BE4A3CEDFC5AECF1E7AE431D9D
      A2CA89AC568098504CC6756BB237DF9098DF212D2EBAA7A73BC4B54FF3B8F607
      975F86FF1EC0BC943A8DDE65BF4F00FD8054269D7DB021B021DFB33786425F0B
      9D246E370BD3FD51534AAED1F3DF81CF51C015F2308C4CFC81669B1F47BD26BA
      0135995FB7F21470CF24F3E15C2F0DA07F926EA758B798E08FBF891F24303556
      2F72A197E0DA1AC53A4AE0D025FC3627C3511CD08469C3CC2DBB813E019BB14F
      2FB0AA2C203FE91B7BADBA118E89FE80E822C9445754E362DD4B139954D2ABBE
      59A6F317D9E7E43A8814F6EE83933AC5C220FDBB9D31E1D4E4F3686A2681A966
      9822D65A46973F4421F312078A523AC88C4A46C4B1CC40767189821A76E80AB4
      DBC39CCB466869920F9C6BD36AA563A6DD6172010A40009F4F15EF044D61BA3E
      52051191C5D9650CB63887D5E6CD58D88AF5EC20D001519BF0E548A5E2225826
      AF11A7D135383B25E69D7C497D2B50130470896C81C878F0F11CCF142C2B5694
      30A106152A32E81EABB54D9691937E1014A0BC07CE5CE03F6413832426309C15
      536BBDEF260D22840EFC1DFC1BF5F5372C4143CE15243541ACB89F9835066BC9
      C60E17722735573AC54C68B54DE2A3A476077E83EF9EFFE3AD9AC69583F44D31
      73D86ACC22EC4339578E301FFDABB651F7869C22BB46CA2C96E99A38A75C0C2D
      A85C2FA57D159A99F6D6748F96C1ADE1909C1628CBA9CDE2162AA0E0C8E844F5
      02D0ADD8298C7601622C3463AA7304986767117C3AADDABF1E1D6E1E103F2FA8
      E67B9078A7D05DBBC0A7DC9E91019ED4D40DCA15D9463E6AE72201439E348FE9
      D857C66A842B0810D80C542269C904219D164CB133078BE51B3E85C447C9A500
      BC2CB92D12249EC412F88B203B58216A59A3F0233E4BA1DA1714AE2E553F6190
      42B85621C08A8CBBAEB311380D66B4A804CD9045639120F5CFB80F22A20C600C
      B75B970772F688F4C6AF288B3C98E8E3E7526AB7ED6C5151F4B1EAC08B3A2A45
      E77C2C826409C6585FDE9923502C1F5CA481C40F73B9AED49599491D02E52588
      98B2E27680A852BBDA6F883BA4375882B992075C97200AB8803A80498ADF843A
      9A65704D7271EC2AAA05B87607325F89F6F4F767A43D6D97E865711A822873CA
      E67F3F4085BA8438F74817D8A844D272609225BDA88B19515EA821E585126DC9
      F9ED1CC7EE169B819E50A866AEB3106B3DCB421DD7CD6DAEEC381B49468430EA
      E13CD773A94318F75C37D6C360126B2602B976C7866F5729D027DEADB95D82CC
      D8467F2AB168B17EF5CD1594B26BAE10F4D51EED09CA54E2809DE6FD9A08357C
      DA7DCB4E056F2D543110C99C9FCBEB231DAAF363FE4971AC2761669631D27DB2
      599E8E5E532C5FCA7B08CAE93E94147FDE8580E6E1FD075762B1DB491A78D7EB
      8654BF23E5CA048E615A8FF44D302343B8C635C24D01F3D47528B5E9FC33E782
      605B549CEA9DE3B8D7377138303373BB5F4CD6B9C15405C2C5D6358782CF27C2
      F3A2827AFE624E4693AE974CFC5C153BC717A3D11433BCCE22DF5D91FC0652C0
      A1A0C16B266C83B142A993DE64E5C35E7ECE978942CC99B86976AAC260E29B29
      52508DF08FB78DDBDB4F90CA90C5D9440ED8EE9178BEB37C511B79FD4C7165D5
      1ED4F6A8D33FADA9D1A0D917346CAF3F72F1DC8FAA13D135054F4D6C563AF625
      644D41FBCD70FD3E102F495EB887E06D83A2FD8E496CE7AB7E1A1B136AC0AB78
      10E6887587D4325644CEB4D871264AEBEDF3961357396DE10E11382656C5D2AD
      264341C69D72307F3414143C55EBD04BD70AB4087CE461308B389F259215B831
      BD84E0880DD84B843763CAC204C0A0BA8BF81136B432012585B064E2E50A653A
      D1808FF0A4B81859B02D44DA938744543762BB3AB0D17E6DF382E05D0E4E86CD
      C6012CD4426195D947E346BA32FA1A38D97BB7E139E847AB308E9ED8C964ED85
      99D9241F6D1904166B9B8CA6493009E28298D4FBA106B0D342F74C1ADBC0BF97
      AA94AAEF75B4D4695A99B6F4DE0AD6EF3296EF01B542DEB6BBCDF346FBFC64D0
      689F5F7D51935847DEBCCEFD03087DAD855273032F1221B0F20B324502CCA3F8
      AFAFE87BD52CFA4E94E020B5E641E89F21DFE53C68AE6C6788A563A3C41DECE9
      20124C2C159DDD65587CEAD0BF9D5EBEFD8A7E03AF53178EFCF54BA7B7493020
      5CCA1C52898DB072808C3397AC9246C17A40B4FB6A99C5CBAADCC7D8B436215D
      4F32E0828D5FA41E31D0E72EE7846C98A83DA9BA46D175458E8E010A659546D6
      49D8960021774C100E487B4559953D02A4729812142A98127D2FD997E24C4A67
      BA8CB814212C0C8A0F2B4DAE0BBE2D32B7FDE9279DFCC3C47624848D36DE5C96
      D16AC242B86DA695D77DD039BB50837673C4F926A1B102804687D78AFFC9106A
      82CA502C1B4CAFEB822DB5DA411C75866FBFD214003BA57C67554F1FCF7AC3CF
      3A3749D238A342EEB84EF290150060F613C3B96C2869E661C48B119E3DC7BC2B
      148EBE34C3F28336FD37BCA23F292DFE80CBB6E97088395A76383E5050055F11
      FA3861A6908E297929B07BE0242B97F2910F51FE6C4148B4B1249C3D297DCF10
      E01EE3565319E4386F3845C4540C698FB2A907BD23A1AE625AFB85A578DFBDB3
      A595CA5D748A35A5B0AA819200122448C485A3725A869D2FB34948C83C19EFB5
      0B4025CAC792672C68EAAED83EE70725BE141CE49FA9949362B1158F811CBA32
      6D32D9D97151334CBE7F5DC4C4F1BB63827CD7D4DBC39FDE31108737F1F8DDDB
      ADE5C3ED033F77E560A834A31016EB0655F36E42553674D8EF5980B02225D7A1
      D09D078B021A862A7049437E5075C8BFE4C88D3C00AAA0CEA538399D361F5294
      9A6D46A89C369702B47C827B5C844E94F4CCA449D44FB3AA2C246D4914E202E1
      F91B2799382BEF7AEE1FCB6E3A2EABDC25B73968F643B3DCC541C3C488E2934E
      643473D93E577E5F6603A60A3AC712EEC4DD77F080DE8D127C573EFC3B12F4CC
      1B258EBCA4E6EF9617A10314E47198AA22FA50909435A99B133954C4FBB0F797
      1F8F7FAAA9BFFCF8EEA822CAD0AC5CCCE30378022949818931F330074530262E
      3418ECC133CCE577C6A7B44B4DBE46951FDB1FC59559D77FCF74C8B42210ECF5
      328BDAC7D2A07010BF39E4ABDF08B3F195C67EB539784EA6A829F6612A335C7E
      020118165C4A53691029DADD60494CAD330B5882DB38A542DFB9B9890BFF41C8
      F84A65B77E10B3475EB950D33D93E0E2F45C97DC3207B303F56AF368EDBD0528
      FCF4833A3A0438FC833ADA7F056BDDA63A548D9CE58F43E27C4C5523AF69DB8D
      D02EAF8C731D0FE8B7AF1D15B40B0FBC564BBBCC967562A7E444DEDEDD73FDF8
      5D7E38AAFB684A82EED733DEF33C76B79157977A97E78A103E1615142A3488E0
      7A11A1A4C89B6CEEC4567594F91537A3898EC7B91475DC50687AB90C916B8699
      4C104934D049637B5D9D63AD03D6362A8E9182099073146B42660D822A0EEB56
      00E4C49A7C3AFBEC65E5F607C06549714DDD0924980EB1F6308B871132CF7218
      21DB0196CFAB7E9D86C78A919982E01F012AB67877C8419534289839A858CD59
      4E204930DF891BFB8EAA2869A4D14D0DAA4D160B4D2805DAE48C69FA985D2517
      6F52CEC0147B10D4643C50A1FA1EC9C2D7EF6EE9711748BCED7F2CD0B2A5E783
      9E9B10CA4194C3DF5FE615E17983A50A5EB3A3C82862A17C7023B3E23879102D
      B314B7EB756FDDB33E7C95D71BB4E79E853558FC953FB13D710ED33DAB989344
      661D45A8A52C88B04894B01C0EDD431A3E8F140951FECB2CF1B925320E303E96
      5A316CD9D59B4D105E641E726136622FB89085FD4AC63CB9BFCC36CC0605B90C
      775C8E796062A005845C60CBEF289CDE0E22D09E6986A17BB9D679B7800D0377
      4B303EB2F30D7F38FF4BB41641806D7D9145F9CB4F3FFE581807B9544459F3EF
      19F66902E279AACF15EB69C3E2A277673606F6DA9859E685A6FAEE906DC1E13C
      98D20281108A57B9DD6DC3A30319C732B68BA5D4320A111AC451046647660BA7
      3000C8BF97E554DD0BCDFAE8F0F83877C27905A9509E89C7F38370662204B8CC
      B0F3CB07B70D0728917DA159BD7DF7A30259B258EC642CD441A3AD221CB6D4B2
      B7C0B9375FFD0BE55E7446F16750A76513FAF48B4C6FC09C816AD4330BCB11AA
      514E68400711434F32909FF91488AA0B7E9A255EA2F638CFA94E501180FB8802
      2E667C7409202126647A948199756ED1CAE47A020EE77D8017D1068967805A79
      9068706DE768B88EE8D74FA14C7872C058D2ADA69469AD815E541AA4E6F9D6B3
      8002F8CE7AA008BEA4804B9088C6FC1EA8FCFF91F5F3AE605DEAE75D7481C283
      7B5257DA0038ABE12C81C6F0F468C79AE7FEA0A7EADC75C93753786B11325C44
      DBCDADCD38B0F3621368F6DBA5A2F83EB3C334110DC4DB336BA75527D6925EDC
      BB3385AAC39F5D60784A14C8FB7377BB2455C74CCBAA5693CF11603F7BC7FBCF
      FEFE1454603E18CC832AB7DC3E4C5BC2F5CF441BFEB4734B58BED3D82E4EC0F6
      3430D3679F1092899849F7E2B2D7E85E5C36EF994EE50797B29475C03E8BD4A4
      F62150217AA45C8992DC1B09CB677AC161AB435B4E4C1075A6B0EACFA9562DD6
      339A81036A53DCD9155943CCC63AF2EDC215B13DD384569312D902563EB95CC1
      C5A823D288B012CD03B077675FE067FECC5203022C6ECF052AEFF636AA8E2567
      5DB1C419CCBB3197C8B199C0B818348577A4159579BE7B9DE15921DD48E67054
      00CD6019DBE92A6E250DBF58548C470D2F3F5F30E9477BD872C779E022DFC2D8
      C5B1662C610D68178E073AA23D39089B3B5E51AD212D371EAB0E6E3A240F256D
      3FD92C46C2616852350D2D385A8319771352C7CF76D2BAEDF34EAE59C66345A0
      67BA8964E38AD04DAD3A07E7E2BD05ECCFB00254398F15984E8935BC5075BF10
      64619852951BFCE5E33A243023AF70E3CAB26EBF7AA5EA78AC9A64BD24A56267
      F4931E2155ECFCA18F04B166115484429C93C40E910E55164D831056171B447C
      8C0D9A69D629ECE320158433A712F33CA73544BF4DD5D391A6B77BA65DFED4EE
      439789D1F26C8FED375BB46DFD617B54A2A74840EE07841F12CC1C4804CE4800
      63EA3FFEA68E8E8F0BDE1A6E04985B560F9A19DF57F5F738095745B141143B75
      F526466D1EFA4691901D0ECE4EF8E74A0FFD32FA44F64E2BB45981D912D606A2
      1770A784E47DA2FE72FC53FD2F6F8ED45EEF70F46BE302FFB93C1CFDBAFF527E
      8600D8CE87AD41E31C328ABA4E8844E6D564695D4781000E155DC9BBA63F5056
      551562A7D4358697C69F0E29397C0AE6D10B9B3AF15D7180731DF9E7BCC0285B
      A7CAFD26B20B144E844B638729E54F90BC70A796424205B9A2F39B2A3365E3C5
      46AB493BB8396D1B10EBEBA49ACB20B60C2A4CDD561535C6B9F27C365140E39C
      9FB5BB30884A740AC54874425E2A044B1E820C74A3E3805BC99083EEDE798FA3
      699CCD224FCEC817960071FA595CB17DA2D03AC6C6CF225F83216AD2B7C9C0A6
      8DD5045A8C7FC87501B27EFAC6C68834AE2657C67BC31FA8BEECE8EB5BAAFA87
      2A594D727015E76381729AC07F9680B45593D868043550965BF7CD12F48191B7
      E6CE7F4F16A6B8F0D5366D38FA2F927AC3515B74073738D3219C995DCDE62B39
      0488A08F6C978406C630B7A0F3C342350ABAB9B2D4FA73F89CC4C2A008F3E59B
      12262B47051373E7F675F12ADA579D5FFBE097E320786E7300644355224C0F5F
      EDF0B75AA392B9E6AE62C92FA7C8D486209DA33B5E46FEB39A101BC677AD7B65
      6AA993CBCB9F4BFE05D18793B94BB31BA2C9183ED238EF9E7D2A24D82EABB36D
      D7D66164CE225262D3E0B65A78A0B9B1E21BB1201C9A6AF907BCF23D6E00911F
      E29C1CBD537BE7416474BC4F16DD9D82FE9D423D5FA8BF6F4BBA4D5D99D07A01
      11306D9F59268A846BF2918DC715A11F5D9FAA07E2541B3AAE5A6292CC1EA6FB
      C80152F51C17477480D20F60E8C52856462C35B5EAE2F2A2E3D202AD9F25A393
      F0F3008C8B4DB82E94F0FE73DA4C5F3ACD3E220654CEC11980C5C4502EFC0BF7
      D763024904AB39804A5C6A8C06AEA9656C6E029B25E1DA15C8CA9525EE9AA33B
      DC3565C0FC77117755BBCB17ED211D588E8E09C7B833C88826465421C5C3B113
      CCE0B3C775F3A5A487E343DAAF1EB4188FD58827329C533BF61C64460BE74ECC
      F7AC4AF5B3DA153ED336F1465C4ED5A9E06FF92A6D5078711C0D17FAA2D97B47
      87E0A2D9AB36EE6A7279321A0ECCEF12B4E8729971C331AAB28B84152F484A29
      A77FD9BB6C7F3FD51B6CD56A77F9B2D593D5404AAC86C93ADFA12190781C1AB9
      07ECA7525284125331705048E223DFCEF0D42CAE860AE95E5C90F8BBD00BE207
      A764050240F88749C93CA235930055BE6E1CFB459F0C98798117D084BF63092B
      1E2DAC1956C15598E56C48EB65B51538FF6631DB0364711F190E92DA8C5A0F6E
      B68BBFEB9AEE7FB87F7AEF8F31BDF7C7E5E999C8D7C93CC7A348BEF60315D315
      B5747B2DBD58AA51908666FFA3F472920625FDF3FF1AA83D89CEE6A8B67D85C8
      21C06D082C53B5B44DC8E86BC456AC742EB9FBC888CA7B18F48A7659955E67C0
      B57E6AEFD77E6BD4685DB6CFF66B452DA0DAEB5C9CF71A9D8BF311FE33DCAF71
      ABCACF576AAFF9F9F3D57E4DF5E7EB24F012355C479EDAEB7F1A8EF6F982B47B
      672322B9CB925D27D92C68F526215A7F20B19FD4D43F4626494FB3C813E92EF0
      0187149264D83D5BFF51355B2743440ADFAABFF2B5BDE8B7FEC93D37CFAFCEBB
      6C094BF161E573E2CD75181A6AA8B55E627AC28FD5083CF85FFC3B5AABCE90D6
      6A56C415ABA9C0FED589F3F0F32EA00460C13F4FACBF26225C9151D5F38E57DD
      6197DBB64E9A8B4960A2B4654314999026FD989786521C3588A6F6C14BBB1373
      12E9AD9C6BD2559F7E94BB01BA7BB3E27E5059741DD9D577942156D524A53255
      079B2C97AB7E2C97AA26D9A4EEA01F9A8CB0BDC4A2934D8A28B34C79FFE3A67A
      963A94773F569BDF9DCADA3B3B532A92DCACB1BC0F78F5415270B9B70AEA82A5
      89AF05FC4A7D5C38D64D3FE7BE2C0E7F4D9D9C0D9B288A0D6ECC280E663313A3
      C2AA717236FC0568EB74FD79398BB5CF297AE686AC11C1076E0A7165120F0E15
      8885A5BE3B39DD267913A7B0C370A12B0310DD2E9D7DE9B4D5DE59AC6FE0E67C
      816836B1B872541CC61264D4C6C7468000A9B65E60B2E5CFE474A8523A4754F8
      00231812097706A0CADCFC51FB840A34A88ED7284BB7DE010103ABA739591AB8
      BB4B11BB3A87DF81428FAE1B047D4FD72A0D1C0163112871947F281BAFC7360C
      1B60FCA00FC9D7EA59BE89499ABC5048DAB9D5FDC16724EF389807C3F2974C47
      69B6509D24A10648EE44B56CF2B48AB2FC3E54CC94B32CA23B912F84D30BF066
      B9C28A0AA693CDFA8F1AD588117AAE54853641F6CB47F590F321CB354F7BF8CD
      DF879717844E763D2990A223E2E2175AFD5167D053CD3805A87981BA2CB189F3
      BB592FF5C40A229FB888F646268E75A49AF142FBDA09B6A3A3FD3F09E64E0593
      8E059C327D00F28575AA04E57802E9AFA2B3277FA82E1CEA3DF2004A5979EEFC
      B1836E2DDBD2501007265948C1906873FCB67244879DBD3363178659D3628B20
      34105F8E820C6E5FA900921A49D104FE24BA5D4C718B6C41184A6E4C8C66D3C2
      BBD0907F9C23245AE08E17269D5B58B34DDFEF6BD4EF0B163BA951300661643C
      B48126CB238B7FD64A1DD7F71EE6DEE58F4929F4D60CF941082BD33EC526CD62
      29546092567907B10798E3192196174A7EB863F4001F459E0DE1C97205AB928F
      EDED33A72DA12DEB890174847A88BAAF4B81D7460F5FA2497B9157E9DCA2AC5E
      7557930EA72E0E6443836836CC2652E1453A773521ECE201FD1729FA9375C71D
      8CC669F59E900E54B99A5C100359F087715DA1B0E502B374A39F9994FE813F55
      D3C8C0E6326B5E575A1BFF410113EC4EE314C2142C8B7972E7239798E5092B15
      6C64795CDF5774B514561A0066EE9EBC5D79A6F39C30A7FB0955EA084F28391C
      B84C533D591A2F98069E105F737FDFBDA37D34029CD7278417BD9F0FE5D9678D
      ABE202C9BEF1429CF67CD588E4D6018D99285D542EBF1FBED4EC774BDD15F7A8
      C8B9D9EF1E2CF54B593ABF09445700215F8B95B758E63C16232792F3C5BCC840
      A32CC413493EE68D11D5C4DAEB7A40766A016B11FA3974D138D59E3933913A88
      826909E402751D1BEC262048E275375A731DE3C345AB0DAE66F44CFE1C2019E9
      EF1F61C810170749C641B3D5510766E61A1880408D66F151F5F5720D8B8C2F5E
      A91AA13257CA6F9F23DF844618CA5DB96EAEEC93AFEC4667F229BFDC2824B5EA
      1FEA6FAAFEE6F0F0F030E71564163E6608709D0B6547A8EE33567BFFE3E8ED7E
      41566A9714EF31753BADCBE7EFB8292F4356ED928D3687E01C1DFC74705CF1E6
      8B875B6E178B7A107269BFC93A44C2FB3EE6A18F7935BB50240F0D9C24D85D26
      0E7448C82B82E615C3D62947CAF5711FF36219673D808BC7D7216CE732319264
      0AA845101DEC61681D03D850BE4A054F494DF5E3C0C6F085EC94A98A2CA1BA4E
      42EB81835530720FFF45EC97EAD2AA5C8C59F03039024EE1EF7444966542D18D
      8DA87A633668C099738458BF85CC5C3AA4D1D5FF489DA2A9447008CEA058B50D
      11C4485C93BAD96660ED6F38169D82149D614D6E07094AC79B27DA5E0871D4DE
      E1C1C19BA3FDA21C51323C0E74833E79C563C82832E93F61F587424E01A46C16
      45C6F8E8030591DFF43CB4EB816D4C0A1E149A41BEA3F1108D942105765DC311
      73647DA56D7D35806FF48A5EEE552FE33237F91D83080157C1CFB55219CE1A5A
      454B0B04EAB3CC2E16171782D7A7A28ED926B3FF0A4B4C5337492199AF17BBD5
      20467BDE16B781047EAEE5E542759C85A59AB1EFB1AEA97F1E36FE7944FA6461
      E3E59C2AF042A8628A8AE020330B7BDD436051E97039D78D4FED412DEFF336FC
      D46C7706FFBCB844A27AD4BD382BFE24AAB1F1C49DE44B434D30633DF36D18E2
      02A354F4563509D1BCF7AF0007150E74B5F5048E6501BBAD19052CDD92AF7975
      132D8374894196908A860EAEABB11AFD761FABFC57F5090A138229E78806C93B
      737E17BC2F347C0A4C333901CC089E0BE79DE633285616966810A55F05DD83B1
      3C01892014E2E59F20453B995FF7102E81562DBE5CD174DAA2FEFFCAE6365D17
      9C920984752E2E26BA14E8425BD4EB20A26C4DC1885F5506E434FB5F5597F9DD
      777EE815772DA040BCEA638D8268C6C24523FDB53475D240523C4E46CB75B094
      0BC632860520DA30E71236881C9A0D57B4A234B1CBB58B3BAC4523BADD271220
      A4DEF3D60F8EBB3CA7E43415777B60206583852945E513B72227944802FC2D4A
      A0CF05B751F15CF9BEBA08CE2FDB17D6375F556B0E647C4E527F110C60609C5F
      B6F35E1817016342E477D54675573CB798BE0A0F85D48EC31282EC2CB2679C4C
      AC16608575E44192AF1354B5E71743D431E36BBC759DD4AAC492611BF4866D96
      2334389FC147136B4FC1377E218688A4EEACD7C22949ADEA0D3F19BDFC33DA4E
      60DFEFA38FFDE0E89799323F611A66DEA7C2287399490FC1A78FF2957E6C398F
      CD5F94D585704C143534942FA79647E687EE100FBC97E8B648D4EC4DF1773F03
      A620E72FAA68BE963A9B704E9E685F0A425DE9A8873F111D1A1712918926ACEE
      12EDC83BD03B767AE0BDAB855B44073BD678B21E8B226769FEEDD9C58412F5E4
      BABDFEEB6BB55722977649FEBBE638D847E10ED23D916AD3053CA086431811F7
      F6149D6E769A7EB20C83341FC2BD0C81C5FE306AAF4E7FFF70A1CE4EF601E3B2
      7E4674065106A6C6722F8BBC728CD8CD1094073C16C6F14E478C554EA97A5FCA
      C76F8075A3AE1214864E3065921020CA73D1BB6A2B63D2B2B5C365C944E1E241
      3CB2A693BAF29C8E8642FF4BE12793D6E424E88C84E448765F0EA4DE67C3CB80
      A6842597546683A175785DFFE335BB26447042ADC68914647B9A7BF53F3EFC11
      0693FF19FEF116FF3FDDFFA8EC2228D087F429612F15661401C3554E9750EC9C
      63A914AC13E21EAEC659C6A6CEE19A8A61040A9BEBA2233DB58BA7EC192877B0
      E2BC6B68631F2686BA8048D31CB5974BCFEAC9A03043AE0A713C3C5936D749ED
      5CC3ECDEA160F98C1D0A4673302A2254661CCC83580A9354468C4D68A8C80081
      0C695DF0FEF0F0AF79EF02927847F48B8279F94F25F94730A108D27871C0A27D
      9201BDF397A3E3F73F80464E116F02DA4D98C824494DFDE5E8CDFB9F0829588A
      C082AF187F7AFBE6BDF28D811DBB440B17C42528ECA083B07259470F84CE371B
      A5690E4521B062F82F79FED655A9819FB5512E2878B6B27089A792C99C73B483
      1BB75C735557A76767C3C6E9D959B3717A361A9260E18EB6E15AC45BC5662097
      EF7FF8205C5A904F144D3DED0E3F391060B150B51C1384F921DC93A42C93C484
      AB26E45DAAF203CA90A1B222F4B388EF80706A4E9B70EF42C7A3CA6939874DAB
      959822C1F12715DC3B21B2B0D31FEEE975978B931AE3D595C3ABA3E188874FE6
      CCF70EEF122C96B1BDA1D44E456301E1E20F42DBEB0E2E5DFF7F04A1BE517B47
      3FD427812B2D76AF4D1DD8D5C9D00190FE431DBD392CD6759365BE62B1BD7492
      9437F4731A1257F45A343DF962B8CF14641BD1D1DD56B546FB2626D11E79E683
      1A2E8DF133EAE286849F8D73F8AFD00F3D3B7FFD06D9FC26D08A76E30EA77D4D
      FD9CC53648932C3265527BC1B9B674E2693FD01B2CF774BE916DD36189ABBE19
      A7F385458BF42193DC7FA14E2028DD16D03FC551FF1D04F62CEDEBB8D8D41E4D
      A43E533AE636B3D0DE561C015A03D5EC4E65A0559B5D22E8256DBEA9E597E815
      12638EA18CC8F0C942F689AFBD4E2C40158527EB2840959C962A151E487F358A
      8C2D1D57969B0E712843A1318DB78E98AD9659D8AA2ECA0F5814D877276B2025
      2E21FAF063B7BD6188228E4BCE8C98F2D5529CDFC0CE8EF43553F4C0F032B748
      303239B670D593CC3A33E9D6442B8DD54776F4F569471D1E1EBDA643EF2882E0
      9EE25D7FE33F7EA5C0FBEBC31FF953AF7F3BFCF1EBEB4A437E06A2214A47F693
      B9C5999BC5A89321A3275C736B5D4AE2E78C068C6EAEB4B3E5FDD9CF0B1E5313
      231CC40C6460844A53B18DC8A29F128770E0B414AFFDC2FA4477F16CD3384767
      C11ECC7B3FB64B1FF05C8A3F8B6B58F6ACA578C7A1E371EA31F70009B6CA70A8
      FBE694AE97402A801034D5F0EB40BFC73D789F650C0A148280858AF8535BAA13
      974AFEBDD478F348CE0235D86518206AAF88F7269DDB2CC1B7A8573B656730E3
      12B965556001598DF8CFE0ABB3C9995419179B82F84192A02B044139221D72BA
      82BA9B178CEDE270EC3087C157F54B1678D72835608243DE1C3E1CECE07E6E0F
      5E6FA4E4EFA4DD2F25B90E5D92560E5CA366E0EB3615C046E92A3C52DAD222AE
      E7C5C06B96552DDDEAB909896D56DA1506A9B259D504DD662DF757C03D20040F
      84F1893893422031894689715224D2508AA69914B5A84623D12ADF79B6F9146D
      5B0E8064727509C5E2756E8D97B9A02DFDBAE0DB196693BAA0BB08DA44109DE7
      E84CF1E4371A9E1E7D15A0C246D2FD24CC4CFF597D848D8BC7CD6988CF925A83
      4C0C5AC6AACEB08F8B560CB953B8300F70522D595FA7D5C2DF1C61A8534D50A1
      C0808E2DF3F012A7ADB08832BBA4A3C487EF70175DFADDA3FBBE6A3B77AAF1A9
      CC53CAE1A8AB416778EEA846CB5B49BF8EFC8D82E99DA6D26721BDD911638376
      38DAA46CADB68BE2AC7CDB51793248DD7A597E793F40294B63A66169B5E8CE92
      B945D588AA6D620173FC9FCF9628294CB04130478FABEFDF24DF189A74B71B41
      F47544DEC5E712F0381BA1CB2491341367788D5A09EF4422B03D4C2E531BEEBD
      889D06F8BD734335E88D512CD6DD6A0E9E3AEE9B0B3B3A27696302D8A4E1E65C
      6DA5B754A5008E4AF86174792555CE2E05E9CE6A8539CDAB6EE3A279C554883E
      E2F568E87B3F57542D8F8F4DA84088EB83D0421DF96E2E02A816131C8E468D0D
      E2850234D0E0E20F8E79EDC20DD26CB72F1AADCB73C7D801348BDF450B89A239
      D273121FD6413597986B6360B0A03D27E2662FCC15E47A4D16A9C6F28077AA38
      4590248422AE56CA58946EB08159307110DFE3CFA8A021668BEEF0A8D1EA0E8F
      FF0C42B1D5E414F13729A874EA8DF236DC948D906184582CE030BB1920ABC9C9
      3A351B233AC64D4AD5A5795BB81D3C51263692952E89C38A0FBBD037A84E6921
      62E2A8498ACA95398C8E6803FA50B5FE8F8CD6D5E4348BA300028CDABFA1BE80
      47DD8D74D23D5C7B6686C4EB733CAC7D79F2770662261B8ECA4E67B2152E5282
      D2F0FEA1B0DE4E511D3833920C056AA8E2C3110408816329C86B2ECCAAF86D11
      8A46A420876B325E803A310B05E86E676914071A703F779CA82E9C4E125BAA77
      A1D98F3212BDA9349B2FA3D34E1712B8642B71ACFE4F20E0EA9C9F8FC7BFB648
      CF3865B6990D68F09697317A257797E2C9D589231BC21A2967A067A3744E7000
      BA66CCB8D1FAB99A5ABBFC7CB16D2C554BE80C3A1D79902B1C113F9548914A55
      62CF33F12FCDD140C62B096991C76CC6F4EECEA35AB1D5E9F09333651E255FFB
      D6E11B546716E0375D4D86140175718B8293E6D7F3C1F9CBD38211F7557E0EEF
      66EFCA4E6417E0ACC4A821377E38471E3CEF064EF5FC6D1BA5E815B1FB61208E
      CB0D92D9BB73E3CC261CCDCEF939119755BB3023E23A973E1CEA934E50239382
      CCF0FCB25D02CF8B5F8D5F1288BBA24F3B6A8EC663A16E82FFB2D988D646051A
      BBA258FD3428EAC22FD1196D835B153DD8E0975774C8E496B26F9F2D6B140411
      B48D2BC193C816E24915B79FC875EBD2F322741E245C1B7A2B70EBB2C19AD3ED
      0219B0CB500E4C6EB352071857EFE4DE6F9701FA92DC1E01B49236F27A6CE987
      540AF0FAF659BC468C3B1EF77F6E8FC66322BF8CB3659A93DBDD3D79C476808C
      DCE7FB2844BE73D4BC4813FD9B1B8406EEA239526EE78BA4400A46176BE3086D
      B869D50E13F8B5B85F43000353AB8E48AD540BAA9CB521B0A54C75ABF094830B
      BB38BD504705591DE9257A26F2D4156D807EEF1E2F7DD7A75EB471F51D25CD45
      B3C78CC82E10C9B2E00CBF92439D9762B35EAB66EB5F5E8DC6E361BFD36E7479
      53DD04C85C73835783F57C1E5C8CC73D7E2C5935143BD97DA95A97277F1F8F5B
      FC60E291E4052972F15B4B53D5A0FF75D8C2C9CC0BB6A9D29D0CD7C38343B4C1
      B1D96CAE8E0E0F0EAB5DA6CEE0E7F17835E99BF8BAE0F1A47AAEFB620895C600
      F5C4785C10D0936A01901529C10DEA20DA932D220B482DE961BB6BAC912874F2
      E355B231ABF7AD696C3EF35EAACF7575DD052AAFE2E9B9F4642ACB82B98650F6
      BB87AE30DA782CB2DA09F2FBFA0170DF02BBC22EE61F7FAE596CB407C9DFBD9F
      37FE40C0828F459B48B769D8E71AAD256C2F0E6A542E9A3A33692B0E16E60C1D
      C88A46242FF4DE6726ED4653BD58DFC39F9C703F68AADF474AE6CE6CD125AA3C
      DB179A23F1B90F408E970BBBB23F5108C37CB576DEAFD3E16858F667286C9234
      9A718C3C702ED49FED8DD130693C1E9CB58785023F46A28D6D284E098AF0278A
      30E185D7913A1F757E7DB283777AF9661773FD8EB5C737A4495D860A8BBD10B6
      BB8559E1838CC7777A3AC0D5DE60A9BD7F9497E21D471A693CEE5EB45AC54D96
      9CFC0550E5D2B5BAE2C9EFFAA169467AA1EAEA15F58B218CD92BF61FB98C877A
      E84CD68442AC9E8201B57143420872E2A4760ACD691C51F10E05701820F7508F
      9941372935BFD189E206603B85DE3A70BA5BCFF45044825D40A7646E258F1959
      2FC1CCDC73708366EBD3A004B816C7D5577B73BD5C9A48CA8F92955E12500654
      30FBBB442FF0D2D4F5620FFE2ACAD2416927284AB48588823074CD4777A2A25C
      E82583691C03C14576ADD11831F489B46B1B27B985DAFD7EAEE36AA7ECAAEF82
      7BB04E11CFCDEDD51D72B0573D3006B6746A666855C40D4529E750DD4E0429E2
      783CBC68B75DD8F68E61FDE7F1433707BD4B9230E371BBD9A36677926B214A46
      1857A44B8B340BBC3ED2229CFA7DFBF244CCF772A20A687F07C3F61771030329
      2D4FAA333B93082A55875031525E37522AAA7911B2D8B98E7DCEC637AFBAA7E5
      32145744FCBCC3E6422FAFB40086A67BD569F4474355948F6ED0A7969BD33CEB
      6CCA17F5E28111394C99B37757CEA65D5DB81393516F06AA41BD1BEA7809FA5D
      17DB99E824F0EE21E36D94C978ABF9FEA53AA3D2F31D50AA4E9529043423165F
      6294A8A8BE3BDF2E59721817424EECBC77E7AD1192643D0DAE520977C2049910
      C53C07B240550E1993F79FAF1810BDC8FBC3211ED4E85C5E0D4A795E61E0C8E1
      A0ECA25C347B0EC7A3F085F198142C8199C6E3DF8EBFF214198D6B150263E371
      335DD86449E5BF574C1C13CC9E2124331E37CF5B0E7FD58F2D111F01D00DDA05
      3B85251F388BAB2A664D1C4189B9D050C657BF36CFCF4AF8D83F8999F30EED5C
      5D50B6AE36AB5229C466420B05ACDB25D527D65EABB611C63DFB50FCFD09E320
      25EFEE69F587087D901A7A3A349C22D8E599D4B2D8B76A869C4EE0513D44E838
      96A031B88694087A10BE00387801B01B95F64A7BB14A23E3EAC50C0EA4E41DD5
      AE13E5DEA839AAB8CA835E53317514A6FEC52017AA866100CC68E5B4F46F9B35
      7F5F2BBFADA3C6894C28952652E1435E075117274C11F090C0DEED8090EC1EA6
      EBD0089969B20B8B512B4B52BB905B4D447B2059F8BA854D70DC612440F98BC2
      C600D1C449EA9D75E26FC42102887A9F6AD012E98CEC51B5C1C42854F653B15A
      6A01BA769304BEBDD46EC6AC54CB809B548AFA2BCDC52547EB5BBB515EF67C55
      68438A7D72A6D02E54B5C4C66DD0759EE40D350729FFEA6D6170FD9B781EDF37
      8E0E7E64E39B5857F286352A764C8E3BC0611F2A2ECE0DDE6A6D574E0C08D836
      22CB1BD5CACC64524D6CF50290B2E585FBCE6543E1171AC9D04A6DD53F571A07
      07BCC43B49EC95951EE4ACDCBC3EAE786AA5E7313ADE57769258F2C5BEF5BC6F
      1D02D86ECCC2C415527192A2EA91B1BAD0EA4B31987000AB0F817CBA9008037C
      964DEA3BF03CDFE53CACB496394F22E37138F1D2607CC16339CD6F3C96277732
      E47463E364E870468EA82D44E4C9462E3FC8833FECAA3F71B89C938ECB2418A5
      BA27656413B0D6B5D7915E049EFBE0FE0EC3E5245AA1051390212FCAA454FE08
      75FD701CF41B8F27923FE4C2C250DFCADAB07545C510423509F6CAEDA2FDEF7B
      819CBE92325D42264B20D567225C7D9613C9DDEE8A00C4E52AFA676711A4E8FB
      74D3D3CB7FD2D1FAE7A97E88EEEF49D24408934E86BF3E12037C929C533DCB2E
      3613CF1171EC16516C656B8D823454AC529C8F1D6EE969700B824F4A41C0A9C9
      69C44B278361A136524296DBD721741B35C8092A369B3A0D6E7973F3C67AF507
      5FAF2497482CEDF8BE1B2A993928FFD9045B6B09229897C301F6F44FACD0B352
      5CD6B72E38334ACB481BD79D8FE693ED2EC7AF3314EAE19D6CE43227CF574951
      F9DBD43C647A94597DB6A38005074835497B6153F381D8C61272CB724A7B3B9D
      06CC13626D983003C15A69F4129CAEB99318A91E6E6CA7BD34D3214F31492D53
      C81966AEC5DFB1CC14AB174E2A22F9A5963495668DF976CE7A8D0EB594439917
      4D02CD8F02B284D03CEA7B0A844B1DE598FDBB227315486473CCF26815F87E68
      3EB1DB8B6A6FB072E4983F02FF5E1BF5B90BA7CDA26401DD94964BA321D128F1
      1A56CBB34AA533D56D8520560CA6E9063A973A7D501489BB8F20D70E2F5162D4
      D5064516891B3DAC888E53A11B70A36543E1F327D79ACC911DCA865C492DBB2A
      9AC4483055AF1CA3B2FF8A32CA8C53DB0120996BC957E21FE32A7E8E2283DA73
      047BFBB0FFB9B07060A6C9AB1D79A1CC6269631D0708FF48EF01084C9C626211
      638203244C1BCDD6A04371D8653E855D9CC161E7175E3221B6800440AD3E0EF3
      F314FF0BA13E55A9B6CF4F060D2A2A148601AE2BAB8E7C146655F4CD0EED4A1D
      4CB33F8A1E49D4EB2A277DDC4BE6C1B2FC0BF2474F4C3A3789AF2B2652BAA772
      E139C7F03931B1B886C7EA6FEAE8CD711EEED983D18AF65D6B853C93D9EA81FC
      E4A8FC65BB41118002C1F3402F9A4A8FBFD2317A3A8B598853EFDA3C33556975
      F7ACE94882F0D0748EE808C5319158502BFC2B9D9B35290EDF7E8FF47E2AC716
      91230A1F8918BC44E62ADFCE03631FAA498C82C1ABD2F7CBA45F951E20AC6D0B
      0AB9F00991C04BB583B6DDFD6EEF5F13BB43A39AC254A9F47597EFACA69B36E1
      15D5048DE351AB96EC76CC2F7B05895A452C0B8AEA767F0CE055A0EEC9D9C2AB
      3D86718239201CF4C515D9A009D7F8E07C2A31ABDAFFFC6E9A3AD540FC0F9554
      3BD8817F397A7BFC0E193197F3BF53BC991CE42C870B8D1ECEC6D5096E71AD3E
      D524DE208D690D3A00A588E79D1738825B3241C688CDF590C7A596393EFEA43C
      4D5D2181BB646A278A75B689FCAACF8D3876981D260640DE78AC7E1D9D0379E0
      BC1E9DA8D11CC927756E6E4CB8DB180426C718CDE619543319D4CE1AD0EAEC33
      1ABA3BF6078DE23D6F4E2A29B2AB625724A67566D20660A154D1CA684C185E4C
      03844709035EC52913A9D030A33E687051FB1A61ED68B8D24B543AFF33CFAA53
      D40093CC6F1A41CA2B2FD42649C357EE6CE932CA1A3DBD1153D14BE943CEF5F9
      E811995A42D0D5E004CF5027C7618BA2D950FEB3D47055F3F07E6B9E9F7FDD64
      64808D250B5FD031A4D6317DB916A3392EECE0B906FE422445100754F2E298F0
      83D41D120A464A66656ED44D80EA701B93A971830A4926212020C64EB31A749A
      0DAA66188FB963796E01D2BD29622FDCC9114489D26D6DB3485B192EE3A41082
      E3246AB47EDE6976F0FFBC58277309F290D74B8C982E2C8DE6F6B1F2E641E8C7
      26AA36D667C80D6E9EE5ABCB1B13870CB393750050794E34822877E4F617AE7E
      708701F95E08A18CDC0BDAE6D4CED010286FC9C4281F1C080764AB1697710C52
      A7546D4BCE2EE37DB81D22705AF85DD1EA94E859C3B060AA4FEE70DC1FEC3613
      3045821B3A4988768C5A24A2CD94556783CF7D35371C570BA29C3193EA2B34E3
      BD526BA5B5315BFF688D07E83F4246BB4F8C3ACAE8447D89113F29E505096487
      BB617C85E6B089DADDAA889E6E55E42D150746D8CF24A9F8989BC287CD651F81
      2122A6AD3B8FC295829C43380CFC818E98223F02052D2BA946CABD690F0E378B
      AAE00EAFFB9F671F1DFDC9F69184C4889E5CAE2BE5B038B8C3A457745A0C872E
      9CC04227CBDB8ABA244758359AFD2E8F4CC4214E833060CB35213E590B1E3F05
      FC272DF1FBBA4EA9BB18197CA83AA7831E69E9CEE5A02BA80CF8DB0888507816
      C8451A6B87A10AA3A5DD1C1D8FC7D4E0494918948B691876C1FD1A3901424B1F
      2147565947DE3BB8BC0E25009498570AF615A7E42090C4167CB6519BE3B1534C
      6DC3C51528F143D7603A59C461F30C833A2D38B0AB0461D66C819A3611C39C16
      73B37A780B807839ED8FCA15A407EA0B1D8C15A40A7874569AA0A5E88B1D24A1
      9E903405E72E808F103F01501121957C6BD4FDF1CD3DA82C1B8EFF7CDFE9CD57
      C1AA6CB8B2D51D91AF54248012440AB0338EAF406926BB3CB9757E397AA127C3
      711C8F11D5FC074A3838704B1D78D0488B86A21EEB2E79F11073C5F7F8838C40
      07930B9D31F20D0B48F3EEBEA03C1FEE203DBFD9BAD8F9F9F776EE78993D7F78
      A8E60B1C82775FB9ED72512F0D7FA1A713341F434D4BD59778FB5575DBE7AED2
      BF0F9037D5922C328945985B2FCC08DE5EAE66A70844C1CE4915CB8E3F6797A9
      5C9C391AA5FE6870F1107EFAFB1E2AA78DBAC0F5BF0C9EE9A1F7C1BED56AE21A
      68D291FE743EAA3A04CE52FFFCBF5C795C131B73828D21BDBC8BC5F102079495
      EDE5C9DF21A45ADDD39F378348DD8823A20EFD8A18C1AAF2F2D3602556D551BF
      DBAA71AD38C580242B4288EC5DF4F897C1799BDE874BAB3AB80768F980E45481
      7A22A73AB2803540A317950E92E57C361375B660A42ADC09DCC219B7F25E4D10
      24C03E7E7F85C1C3BD6AB65C9F6F98C67BDAE0C70FAACBF4E6FF93836F1F950E
      F8031F5C8F04F9CB3E7DB4601E579E8E1006A4E2DFDCCE5EE820FA86B17D2793
      244EB93C8FB803A8705902A8FCD7FC616815A15DB30CA1A4158C0CC321285C81
      EFE0D67D736871141E1A3CDAEC14511EFCD147FF97CDE8990B345583B58790EF
      A3DFE8DC0211B24DDBBCF9991B1D3FF667DA51956FE9C7C73E1B1B4F29B5B5A7
      8F7EE3C46CF740B97FF8BF49AF13A44DF75E334FF8814916AFF7BF39A10F7F7B
      E8B4D2B36BEA7F1CF2FF9D3EC3B35EBB67ED34B1F20B3EFD9926DA5EEB2AD193
      C5BF2F277374A8EA4EE57DDEAAC2A4038F4A4C74DD99AA533351C7EAF8F0F85D
      8E943F3C383E387A7FF8BE2249D05F8EDE1E62FC422836FBDDE792D945D1E699
      29D1029F99546A1C84CE82E2C2D4573136890D01F2965E2A9405D128C1676D8A
      768E55D5DAF604099821C8238E5D895D9740E0A51B8D40A5AF490E46415826B2
      60856042A36753730510ABE93BB2FCEED471676E01A2F269531F7492EDF40212
      48022B326275D4AA875FC97FC8B5FFE63179F3D38F38A6795A663CFEA5FDB92F
      C112320AB80FCDD1C1D1DB83F76F2B8F82BE5A0F7BBED567FFE65BCEFB737BEF
      947DD80CF2CEB5AF5EE596F32B154BA884B68F4A3245697A64E61601050A633C
      5336167D62F244D2697E43D9987C9397645D9E0C3B2AFFF32EC38129449213AB
      892322A357C640210A5EE3E0E19E2E4F7444C98F2B3988F018767C20AAD14B96
      3CA5AC881C6BAA50A35E93E8E5D065211BC256B1E3B0C23949546AD99220D068
      A6C1E7A23A4CDD417BDF7E55A7E797948BEE9F76918B76853A4C5AC98D00162A
      D8C55DDFCAE3CA4A3ED6FFC075FFADAA46DFFC84F09CF4C321E6BBE6A87971B7
      09EA9FE126386DB7A745CF916D28FFDEFF90B7A703ECBEF49D0DA578EF773F2A
      9DA0EB877B44F1AC7B3C08ACA8D022398B7B0A2B5C52090700054E3397F90AA2
      59A2C2E01A141772DEA5D08575AE24DCBF61793FAABEB6FDA48F4A5F43307E50
      A321BD057EF8A8F404F748BEFC414DAC25BEDABFA9519CE13B932129B3F25F4E
      D169797F7B11EE5595A4AAB0344BF4F2F6CB43D7447152DC473426F42968E49F
      A6F89FB01A2FBE08D8A77B067E6C1712FE087E82DE71876A9759509275624C84
      CE880C59C68E302DAEFBB4B3B0A48D677930EE7C22CF3FD8DDBEBFFEB7D9F76F
      7E7C2B26CDBBAF4CEAE2BF78EA806236E556CBC36B58109E701F557A66B77579
      B1F1CC2E4885C841A548BC86F8007E9858BDAB05E041554A39B1F11814B5653C
      943B331859824D8E77A3EAC6BC7FFFB84DB883DD47C1B342B3E60C2123478EB2
      49E8B7CB484C19EE46DAA0E813A16D8AA5BA83BE28E461EBE764A7602DE95CA1
      7103DC3BBC018A19C89BCA6166C9295C5C8E3A256ED96C59BA41BB242A87FDBF
      4B9AD775FDFE26F3FD931F3C1E9F82C52C37ADE06C023EE148ED760ACDC2523F
      F03C4FCA4D7620F62842BDE3F145B3F77EABC12856679785E89C82FD668338B7
      146C7796F52E33E7D3FF65783E6C7C199EB79FE191E0FC198F89E9A7B0FD0190
      28F23F3B05EECFCACFED4633B4256169B6E3A3E59AB847A3866EF787FEE3F2B2
      44DBCD88C1BC65C884E90E9EE1CA347B44D2CE0ED55DF2A61A6974F83E8CE6CC
      BBBE14F3D965C707977FCF07C74EEFE064F1DB9C9E62275C850DAE2B28451041
      DAE1A92854727DAF8AC2C01B330FBC679102C2FEDF26092EC0510220035048A0
      D9C748BB9E34C4A83320D235AA36725813D5D36BA5292EF00D8CC6D312C528E3
      CA2950B943F068BDB4BB843040AA880D25A4601AF8EBFA4334E54F9B62B77736
      6CF49A23E4F00ABB23D7433B3D9A3383A4889D28D85172712D5B3FB6A21DB88E
      0DF578196ACBA6C466213941E0BF2363B3245C53792D9DFC219A19AABF121E49
      6ADC888A6077B3FE5FFF3EB3FEFD9B9CC5A7643A4AD46657D311428E74DB7DBE
      02B24189E32FAD91CBE0AE0F1AF9EC7687680E97A708F0B6CE87FF188FAFBA43
      C46E9CC885A9C884B182ED1A8F81F47274DD9BED10454110EE155061ABAB02EF
      736D8F69B541027D9FA6AF7486827FD31992D2005263B7D99264ED24B6D78613
      A5685D4EDE95B0F361D679EBC0CA87F6210CDB7D8D6EBF53F2A087F778DC61B9
      9BF714CDC25075A26CF16CB1446A15BEE10D706096F2E44F0B26568B60F6D0C6
      1557A1738B2806E1F783DB5D5DB73B175CD5C5C0FABE0B5EE9E8CFFF4D47DF35
      E3716872C922D9582D8C1F648B9D1A4F4B9F4445049C0E7200FEC729127ED3E0
      B65A128945D0F3DF1ED0998EC7E7AD4EEB1BC1EAA73E1006E29949818BE9877A
      CDFDF1C4FDE2242CF89F47ED6641AF5B515920C0DABCEAF5015A860B93C31731
      42F3AAC77ACC954031A783436D3AA7019F03D17092A2D0CE4E999DA379D5ABB6
      4994DF709D3ED0566E341E7F39A3DE474348A6EA5DE925CEF1FC07A0F03B38C7
      DC3A39BBF8A05A3AD6373A62A8C80EBE033F1DCD9238F7DE1B7CC1F24342FE4E
      AD5E1254CCC11807D14AB52206B2B1BB495FB0673D131AD34C53ED5DD3BCEFA1
      713ED8E15DCE4C7AAEA359A667A6A6BAC985B94D5B61B03CD709F097690DE649
      D48D2EE3CB2CBD9CF6EDCAC4CD7861E34F3A11E01DBE86AB61E26E746292F424
      0B42BFA517CB1AB56649BA51E77689DACA0014E9DD44F6A279A3831041337642
      BBC967C4D39B61DACAE21B33927ABF3B8CD53BBCEADDB72302A635B723A9B688
      E74780E6B94E4C4735757E5CFEC5714D9DBF29FFE24D35B642EB83918758B651
      B699F36786269AA5735AC060AA02E825E6E0A27F6A694FB0CBF9E8827F6BA063
      22F0706CFF18FA9A773FD9E5E1C2160B19A0344E95147FA6EB9D1F8A67D65473
      B1B0E8989D2D486ED7A89A706E3477EB743F0C746A3E2FA5B4B5F4BB368AD756
      462F6DE4265695AD8BA7C6EDA020CE07BDCB4ACFE9F44F8F5D664E2B0F5745A5
      745702861922A88003473DE17698AA93982CD6F0D4CA68911FDEBF809C1F2E33
      E630B91A757E15EE7081CE94E8937D8B527867180555EB85C958B992D8101160
      49B86507CC37B7449F385B9B54293476F3BCF5693C6E778623B5B4092DD4C10E
      C3A0518E6412A80EA8E8B94A49C5AD0C47658C71C9DBF69F2B04438FEC67A938
      BE0DC23A804180CE7BCEA947E5D84268431328F56EF2A83107A6B49307EFD8A8
      E5A925CBB2D4F7C4A18293B9466EA8F4A104D0B1859B321C105A7BF9EE4E88A8
      E6457B2360E23A6B48E4A43130538D1E78359EC1A633C44E324715785D89A8A9
      EA3D7F075418C94F9D85EC30C4323CD9A8E0A9F033CA95C14F771E8575BB240B
      97ABFA8AB5DC125A2981E7B9E759A5A789E7DDE026C2BE4214871505223915F3
      C99BCE76F9BE105215D161E21BABA9DEA7F6A84601A49A0C4D01A46DC7BCBA80
      60A79C5C74F6CCA901CC17C80787A77B35BC0EA2578597C1E9CD9D82CA544245
      6DD75A9F060CD5BC0A9200D79A88185CD76994C3EF344EFEF85F4177FFADC8ED
      135419609B6CA113D157101198B2677D8411551005BB871166FFBE282C11DAB0
      B63BEB5F9E35CEFA97A7A546B03626120994B9AE1D1D42E5A1089A4A10BD1231
      23C984D4BA186767197839991710DB4CF1448B766566DA418CA5ABA3C4CE414E
      FC205BCB1366863DA636D1F98C1CF10784BCC9FB3688BC220AE192D4DAC8C07C
      3B84FCED09BD01A49C01D639DCD557276BC74E01EB07D52DAB3912D8BF678177
      0DC815F14D62DF5CC96FE5F18FF2AD72DD2411EF203B88E03073BBBA9C4ED5CD
      D1C18F5571F36FDEBC442C55BA3A0E46A774DDF8B6F9D61324BAB94D0BB1E649
      4A3D454F0805A2BA604187CE1161C085B5157D2902CEA984A84A942744160852
      1016D94E1203431EF9B0656CA6C16D23C9A66003D2BEDF90BE38684D69928A11
      FF7E6C6FD0D0BC0CBCA36C2451E8E32D1DA24F2CE91D35CA57776584F0386FC8
      FBAAE9FB3652DDC837B7AF721E0617C69A1845DC237A310966190C3A9DA85702
      506AD9C52488B8E3317F7F47EBDB21A5D9672A1C3C1895726773B62C84DD3282
      F3D2A5B3113124EDE04D60779180E8B65568ED75B614AF1EF2A6F21D7A0947EB
      918BFFF76E5F9D5FA88BAB6147BA80A89B774707155B25E4CA606B946634A711
      6E8E0EDE1C1C3DFB3BD87914ADCFB220D5B1BA797770F87E8711CE4C4AC1B1E6
      A01942BE78F328F00800CB584D40C8109B310B29EFAB11D1BD45432094DAC301
      8B80ECA782E841EF72177FD5418F38D7758A262C0DC75941C4629575F73B2884
      1CD1FD81A4AABBE1CD04A8AC02890D0AC31931ACF0DF13D051DD4142553294A6
      4F37949CE1F0565D9C55A2E7D1B13747D9FA26FB96665A3D739BC6E0C4A0E8C3
      CD7BFADDCD8FEAA479CCD9FD7F1B03CF9BC3B72F211186A75F291BA0EA146094
      0EBBAEDF6E29FB200DE56AAAFA3897BD4B603F212E6999090EA1222442BDB9C6
      B2437F31B88E5BC19928E38E013BE06B0A3D36EC9FB55D7F3C794FFDC8AB56DE
      2857A9F5EE6AC05797FFAD4EB4778D4308629FE1B9B08E096F380321C9360147
      188E2C25E55070427470954DBEC3F79B379C5D9E8546FFA0C723F14F78F64FB9
      3979D16F29F4988B1FCFFF7EFB9947392ABC311C76588B5C4E92547B8E263CB5
      AA7D7939A851F2A6A646834EA7F260F95E7101501EF220CAEBE292557EFE8FA5
      E7E30C5E5D129326EC6CF13688288032F5B3498E4E2E11D75576708F787368D8
      BB186E613CF4608E110319FFBEBAAB25C5BA6FBEA2268BBD1539DDDBEB574943
      F8FF3E57FA909C264830C7B1D23BA7E40D8ADEE2C04BD567B0708C1069C9F9FE
      5213A3CD68A81626CAAA37DDC5F0C75BC33BECE1E9AFFD768EEF887CD5FB3C1C
      357AC3D169916FAE3C26E27F1C97945ABED4E885BA6A9F22A5ED4A6E113321C1
      89C61D74B8B8EF2326280AD7F83B15AF1DFFF476537A0D8CF4AB707C1E211AA7
      2E41D6E58BA5BFB3583BE65ADB47BCE4CF7DF5FF3A5FB9F2206FEEC839173AD9
      08D3B489EB2E33EA2A30AB27DF8162BFFABC5F8F99480E8FCB84B5D4CE131B3C
      37F2983098A0D781944DB8AE934FDB78E507A2E1C8A4A2079638C81E9B16D9D2
      286E2E75D25C66B137A73B96CE639BCDE44D0F80EA06BF6B9C7A99944DF11718
      4123897D7E1D127728C99179082DAC0E4373837E248FCD696151E7EA7184C1CB
      593B5950510460AA0374615121D2C4C8ECD17094D225D266CE6E695024B925AC
      A1123DA01A44F1B55D128C115CB32049B78A93EE703D50F7A167403E794F97B3
      30628ADD8667423415EA6AF0D854292ACC9E38DB4518BBE6729EB2221CAB96A7
      D14072465FA9E1CFC38E5AB28B1A24725E8106E397D020332605873605A529FE
      DB2CF7E3F75B375D648AC0B1183C57CA1C34DCF5AF3C1E55AB5C5C7DB85F7A45
      66853C3039E2BC8ED5DFECA77BDFEC723A456D551B23567DF48F87F73EDA812F
      D479ABD36F345B9D7EF5118ECB23D4C8FE73A3E8C84F3CBD34D51FFE66536F95
      1889374DEFEA23903F18249E094371A5A4CB322CAFDD4EEC8F923CF84A7606D1
      8B1510361B096BE526BBC54F07EF8EAABFCC0FF23252CBF2995D30C9D9251FA9
      50815C975D58E488E28C5C08F7FC9F54FD3FD4279DA8A197854B3EB23B0C405E
      03378B7423BCAB158330B42AD7E835D5D748423491564D8A4230CF4426717472
      A7677D62DF53FFA9FADABBAE77A3EA6E3039C1ADD6A5FA95B0C8FFA15AD6C63E
      02B1E20F6036D250ACF5F3EB44DD0409FA84857A8D880BDD959A724FA2EDA282
      38929695B71ED2EAB7F21DFFB575DEA25AD9CEF97965EB6A4B7C70AD9D24062A
      5EBA3DEE8BC5F6BD1F24B80DFBAAAE12875F416430C1AA59B68A92DDD5F1E43B
      D4B10B1C08DDD880C8400BB54C54193AA43EDC775CB2870DC2FB1FBB77787854
      7F7F7A8A827634FBE45E657951F57D03E63CE31412D54E8838BE26B4043E787F
      F40D3235988D36BE4E94B9D56455E2AC3A8EBFFBA7BAD117380F1ED224B6A670
      7470B86D251CBFDD5EEEE31F79B9BBE80086D4F663136662FB5203F84D42A552
      57E7236786226995182A129E98CD4FC802D69405846515504726989F64784E8C
      C48225A410AFF3E0A6641A616602EF1D237F84F0F5066BA776CB46939D6AB4F2
      264C0796385FDAADEDFF7EABAAEA8D7EBB656B2CC099028CF806EA82533FF036
      6CBC708BA7573AAEEA7E1FBF839E1DD0CDE7CEC2D2994F5D7C3E3F47B747E626
      CF3B313A6A2064105A71B0306736F4AF020BBE8646F9771B3F5CD80862A36A6F
      B8BF1C1DFF00894794A697B2C51C4712DF1849656AE6077B01D6F6AF380DFF95
      03D3F006EE4ED5A3FFEFEDE14F3F54664E3BFE01EA7C38ECE0E6FFF09625D91D
      E9F8AC3298B86EDD104139E947DC69C0C5C15F881CE69E8E31B7FD954B6323F5
      E67812A4CF3A2DCF46D31011A224D56996609111F6CD4F2978DC5372FD7242CB
      3C6FFBAC132163AE7F8E0AEE81F6039E4ABE1C5474CAA828A265E5D2905248FC
      11086AC5095DC20471570660874F2C8BD116215CE97592136E11FE999B9013C6
      BBDA34A6546A39C18BDE9810CB9F2F4B516F268D0EB790814CCAE5512768266A
      67EB7AA3F04C1D1DFC78F0E39B8A77E681E98D5613383CA174AEFD44509AD89D
      A2947A30D5133D35CF3928B5A12A814DD48290DD185176A6D43CE7CE01E71D8D
      F44D3063472D8D8D41A2FD39A7F86ABBD9FB2B9C2EAD22207CB84D02CC12D7BA
      862349DC2899672D7FA8C93AE66572419A9870FA649DF61CE181238A36BA16B0
      E02331203D6285AB4E8FE9F051E6D5215708E820788BEAEA3477F1C829A590F6
      B7D8439EF054065CE54DE100687F9C35E6A98A3FAFB5FEAA563AA6B5D0139872
      AE3F28112F133D53E591DEE56B52E211A0D2FC5D4332EF7ECA65B0B1C8DF329A
      9D5A692215444C9AA213BCD8E076718141330CD0B5E1F975015BEBFD417B88C1
      89E9A124F19E7C039E640537A3B5EA0C7BDC21178D5DD19D3AF00262E034B7FC
      EF7D47ABCCF737EFE7E20C56E2794DA5EF6E61BA22228DBB5ECA0790379268C4
      4F276B71A616008F4D88A790FE405065360538ECE87E22BDB48A83343511BE9E
      F3868B31E91A68E4FD4861473BCFC61338F064AD7E69B60ED4A90E42E91DED03
      38AE1646439D48F3540E0D1B342A131B3E9845AE3D766EA8D3A783421F52D405
      D37CBAEDDDE7DE2964E03BE7EEB10DDB2E43156EA9FC1949E1F5612B491219BF
      5A1F56C77943F54D647F6CCC16262CAF0AF730D9D23708FF52A2ED91E28A6F4C
      000CDD1B43BA5ED425E388D902797A5AA6CC9F83DE09C3FC2D68B3BE59A45269
      46306549918143DC50F39FDC7FE38E52744C405508CCA89E16E7AEDA348626CD
      134177A743E755008D5881A245075A4380CD0E17CFC6DD76B5D17333E4D1E18B
      76F2A5F173EAAE79309B438ADE08229D9DEFEA9B5227E86E4F5F1B37A1A58EF5
      0267B026722B4F5A2530EBD7362BF54BC64F79BBE41ABF02E13E202D18BE1A5F
      ABEE0880FDD271921AB1CD0B289D305DE204157DD0289322773431403CD2E2E4
      552AF7B5F27B2CC8F18555EDE331190460A6265D13768644D4E65403689F29C5
      20B84F97B94D734BD195FB944421F926DC992F8BE0134045D898AF38C177B83A
      C7A5BEB724069BAB85D327F2759209C35C16995BB45AA4259A6B48F7AD235129
      52A7BF1FA050D19A383C7E9FE7A7479D612B0C1630187A16AE4A43F5911F55E7
      5C4ECABE0939955A6AEAB0EAA0922FBB7F956D33041D5A4E2613A085A30EB0AB
      63338D4D326772BDBC771BCDA54E447B95B12DC76F91BB393B39ED955B7921DD
      54073E9ACA4ED5706E4CE568CADB37CE5002C5D178FCE5AA39188F992500998A
      A8D1D38CC9FC539D85D2BC04D788AA04B2E0F39EAF951FFDD63D5A787D7D6E2D
      74C71FDEFDAE3CFDAADC4FECB26D5F52325DAB858DA81C4087CA4CA7C4F03E25
      3B4A81CB7F6EB39820AB0BA3F64ADDDFF76B4A87888C511414B743DA744262DE
      69360F9CBD8921B128085B7CC2C6498D9A34E6315BC8FDDC4C2C9B52F94B4107
      A47372EAC8B9A3D6B85B80FD6D716B61FAC4A92CE7460822EF2459A34C0E5EA5
      9E4C8F0A25057B9B6BC1E43DC944189E1EE15907E6D67C47F85B4CC4EDD6ADDB
      0FB8B3B3C7723806260CD0FC07760C23CE9383F4F651B354265A2BB364D30206
      80632F97B1D5D21B5ACA2F4A1D7F44DD2636438756B6F9C5C8CDBBCE82069A7B
      213B83BE20452E664840E08327BF6717C62B39A72393A408751D510382FCA743
      D561F4C663AFFEF097B100A24BF393D0CA92D42E0E822870CD0F383FE007496C
      663A86E498ACDD7AB27876963475142053C62D426ADD5AC1AEA4D57AFA398179
      D05D2C709FD842C827F93AE112B43B39D7ED5DCFCFB7C4BDA810284469E5470E
      0E2E101FB93107EA2CB8814B827EE0C11FA6C6C61856E687B7F5093A8217B926
      BE3E30ADA4402DF7C7EEB6B87D6C7B4F1198AC8F50603434E916C1D9D69B5C46
      9B070FF71832832A5628726DA76A02CE0D0EBFB9B44D500AA8D056E2FC67B8EB
      66010E07D9FEB7D8A977EAEC4410C3826EC2ACF86B295A00923C3C3A548B20CA
      90F7E5A25D2A353E50CD10ACDEB3B903D3C0384D204CA4237B6C57A869A0EA34
      92756EE20102E833B66BD90F4952A41B806CF66F02211E874580F236BA56709C
      A1AA3955AAB22805708A628A52F9ECCAB5DC2014D3B32C51FDA76FD1309B2408
      AB21B78E25CF968F5E35441593E22BA1CE226F0E014273D31E0C9AFBF7463278
      D4FF3788F89C82B883AAB2ED5425062C28C9D32FCFCF0421E8B0017BE20CD8D3
      508332979B950222115060E271239DC1727130B3A4BC52C31DAD8807D98BB334
      88D66ACF61EA10EE5A2C03CED3ECBBB657AEACAE64AAD794260B5EACFFDCC6F6
      796EDEDC0600C915A4E7818FAEB1D4FD8A7C9BC8204C7C038F55EA2CA5C1166D
      BCA7975CC84EA55C3C0B8C7EA0BAB8F75E9C518239B5900B1229C167A865C8C4
      C0B31299616EE73A4B30D247C999C24A155F7981A398451422BB3114694812E0
      B0B91AF36E1FAEC7E401E7504FB9BEC0F5A7E9E9E512FFDBBAD38F6D739F50C7
      86ED716C51287B70A130F768295DA0970DB577CD0177831B82C098B83BAEFC76
      A1A9347D91ABB220269D502FA8F484464F32BDB3D04E7458A3535C672A0B4DB5
      97795E3D912AFF8DC0486EE061FB7359CAF1F483A24D07E1FBA2CD3381984E10
      A33E5D7A8DA3FA57AA21C411AE165AEA01F48103823243EE754B4EC2D0A46AAF
      DB6F0FF7DDF3ABC547C80E23B80EC034FC8F3D00D3F6C92EE39F9153DA6D1C21
      67527B3F5F347BFC68CA8AB8DFBBC3B5F7F370D8DB6DA8A6FF2F4D2501C3482F
      D505F5A5DFBBC887C52FF3FA4FFC55ED0D4717ED1D97515A3E73D3632278A0C1
      E4D7AE09F41EFA1E3FCF48F248E990CA79BC72DFE9BDE1E96870FF508F5D7DC1
      67256AAFFF73F7625F3523BBD0E1370C3B49D673D464E3FBE3ECC7E3A3E3FF04
      F7990034D033028778B24E4D7D6AE33AFE4135C8F2590E7AD00B65D11204DA1E
      678B24D07127CEF1F0CB10856BE011E734C755F6E06FEFAB1698EB1F7FA7EE94
      7D7317C59250B64F049EEA24CCCC320ED014365826F5DCBCA3980457BE2C0309
      B54645185CE0E3E50F133A45134651720710FC58CA892DFB8EFCE4C8FFC6D089
      03E7B0AA2FB79964AB0B6FEEC4A46F92EBD42E0F54CB2E1968333789CB238AE3
      F0E87089318BA4DC428DEC29523CDFA16D623D23A2172CAC533D648F08A80700
      68C44B67DF88E2218C42140832A1B2E3544A77B370C6F3A18E498FE49DB99C72
      2804BB14C34BFC871225AE89496CF26C10805BC373B156356244624D21E58976
      321142F094E6B38B20213495F4EA84FA4AD238F328770AF70D1155B223086D4B
      FECB012A35045945EB81815DFE00DF9159C97B52C83020DF9E4B17886CCC37CB
      FF9FB8B76D6E1B49B285FF0A2EE7DEC7D43425CB2F6D773BA6FB86AC175BDB92
      E5B164CFEC763B364012943006010E005AD66CECFEF61BE764665501A4408A52
      F7B31F76DC14892AD46BE6C99327C17F42A53BC762A34F35220003BF4AC48C74
      27CE73C97ECFB2201DFF6B2219A8720B17657AC90C2192D4EB85E4AB45C73FC9
      E2217050FACC54084BCA69D40B5AEFBD423178F566E8FA890953B961A213F735
      CED231600FBD65EDBE1E44FBBF88248E801B7551645A851026AD3A2B715515A3
      54266998D4D7986AE502C04EA179EC8373F2B2658275D2F0AD65ECC85A8EA7C4
      3DA23D29628B436CD0E2A31530B69DD93D66CA848380E51B38297027792E4D0E
      78624F84623DEC0B5B73364B624A19C14A149ADC69317EED3242D209E04CAC9A
      59019C419CDF0CC350177628B1246CE97A25104E9D96B0293DE2ED4EC189F36C
      1A7FA791D739F5C724570A4D8BCB27C501A33B5F41271C826A75C3289458244C
      B7AF710E214B2D1C34C6AC80D02B1E8974E81B0E10C226F98DCEB93C4ACE0383
      AEBC231E14C0F5E7CCB66D685DF09C4E35DA4D80038155FA8879C1B848AECDB9
      F46C7B15396470BAE6EA886537FC95B4C909BFE6FC403DCF76FC10DE3E2277B2
      93799988D392F1841CA5E5682E5ECD202A300198B3D709CEEE71CCEB86FD98E7
      1811AE7B4006EAEBA659B66DCEAC3FA7D63FACF763E288D1DE2576641D5125B3
      03D9C18C28BC76229E70D722F958A759FA2FDBCDB73F555385A2559891D9E2B3
      79392B44B3C7FCF1C6F4A715C36CE20C8C8A791943082D3A00168090372016A5
      34C49898A24E4751927F4DCB22A76288042F476CBEF968BA68450CB42AC5FD11
      866E64558C9201188C88EE6182EBA4CC12C6F7A5DCE764928A9A1053F7656FA3
      3FB68F1BCEABF87C03856C6945CC85F694A5D354AAE00CC4ADA12580EF32A946
      0545B8A8FCD9494F4754D800600CB364BAE8F9DF6E4B06782352DBDE0B04D296
      755F0CC52D77D2913837CC52046306D1B8481C0D91B84A03DC841469639E2B78
      DBC134E33C03A0A779758634F7C22E1F12C92E7B7844035E07488F13228FC130
      0CA3E58BDDF0E74D3FD9B9DC1944A7674FB706D6A6746E5B126EA7C5D8AD6802
      0477B373E30C29E649F955B1286116859807EF678AEB2834E162FCBE511DEECE
      939C039940C0075C4281C1E2ECE65FCE68A56D8955E5EC1AF76208CAA4924614
      6E12144BC4830CB4C1A364951202C0102FC553AEB1EDC8EA133C7D6C869736A7
      8C3BEED1007B3180019277C05DAE837D156715957FD27C9294140034FC1CDA81
      0E9F91DA896223E645F4CF79CC5D1257D5BC6448C0D0A960BC2D614ABE2AE6B5
      9EDB5CDF1647B6090BA3BE6C57AF7C7D390D43FB90355790DC28A1012B867075
      555C5775319BC9B596DF44C937F534960E6D685EE03CE1740354A9EA640A4533
      3F30D2CF4755942597F10876EE386116B903524A57A20CA9B0A88127E7A17003
      F43D88F4A4821335872A880F1068417CBD98B89853D32991B168D8D70166BEFF
      CBD3D5E919EE7401D7493AE92ED86BB2DEC0A025594162FCD003C1FD6AC74C05
      4AD10DD437B1E7B8FCFC7E947D18570A32974A4DBD5E1F533DC161AEFBBC7FEC
      D94B3401D31AB45539D014312A26D1B1072DDB58AC82B08064ABAD15E6BB9262
      619710BFA12D4DB803F3D16229C07DD8AEAFE27C3B1D27CC09674363437B072E
      7A23ECFA748A5BBA6AC167997FD9577788CC4D3422B60DEF7FACA0595D26F1B4
      D3EF6F90A00CB5B4C30C3F8600600A35487297AC157599621C7097652C1B4414
      97FE394FA2795E26009C384369BECD434833D3FC432A7DCA28CEB1F886218CE0
      28847A54F951E186AC6E39A6AAA4D97998233728F6C46D3D69D66ABA00CB067E
      4613AD6D98AABA93E993096447C7583B4A7BC4BB0572C8AF7F917DCCF1509FFC
      2408F42A5A6688293BA62177AF3C8C1675F3E0773C347B53F0AEF36DEAF84839
      5D61ED3860C05753D80CC68559A3579E36298714BC207147181004E6BF80E820
      1628B903F7E17E41AD5FE6AA0540E97E0B1A1017B931AC6EC024FE969BCA8BF8
      38AC825845BBBBDFF87FE091E182C453E413EFF556DEB515B75513BC1A9DBA83
      8DD9C41BBB96CA8114C7105F7E39B428E3E3A1BEC1021E6A8E70E7161585B3E0
      645BFF7D2CD9CE015F4519994ADA62E5BA5B32F5849021F88F0146C173E0E332
      A61ABC85308A1FA8DF56E6F76D4CF2E35D5FE39878966C16D8580EDCA24FA774
      C2920EE08A976C5F30C4BB72FD115E39029D89C0108888AED93B98DE3854EC7D
      4FB1875F8BA7BBDACBD137F4D48D3173AAA361F12D9C08F67956165729A2FF0A
      DB86748FBB41C43CE5ABD03B854B467088BF3592B9FAAC303A59166F41D679ED
      51892B5FA1D63E836B044A952E9B955A1B609D3A07DC63E57E7E85873AAF0B84
      B155E3703CDE1C3EE730453D6A635BAF7B5E46501612F981240FCB4DEB725B63
      9EA9371A0910BF04290CC30CC65351DEAC3F9467E6FFCB98EA36DB639A4D3CDE
      3ECB5BC4C7D6E8BD4E2473D4C7951DA0604C2B3C500D0FB0AAB29BE6A80DA2B3
      6C7C1A9795FC07C0AC1A720DC48DF8D1AA6135DB48E5F2B7718FEC44FF5ECCFD
      300200A3F4295C802FEC96ABC26E515D3FC07763EEECC311912CF0513607C906
      AF28AE2F8E27CE3C80A58E2A6C4BB62FC10815F2101FCF39B97CA28618421649
      921BB604647806B5C094442E200882EFD350C65725758A3AF555EDC319CE0D11
      A1F5E86D710D784F6EEC6B5C3E331E6740178A097A32F34430A44E5392BA4E6B
      7C500200C10EF57495EA3A851406D893EC1D65AC71C0023E5B22EEBE84771232
      03E9EC00B385873E175BF81FD844887568B96A7C4EBF44F98E30357039A9AB94
      8F6343C7C988330C48465C876D68836E201900039FA7129E1203870A12D06565
      4B6559790417F018CAB2203302EC12B9C864400DE0BBC3797861D2ABD1BF81C0
      E156F6FAB6E4931DA9EFA3A8D6B92287EC9DE32EB33237F1D9575CA2A1C52BE4
      0AB80C063D63340FCF4F3DE4ADCB84D49F61320121174631B29E1C8AC6D39823
      2FDB995AE8341CA6D46494555F457DFC0A9DD3276C915225477815D5D70590D6
      3ACDC1B896323EB8CE2D550047029D77B85159D286D069365758F7D8CAF484C4
      8835AC5274ED50A5DC25DBE00B420CE2FB85A410E620AE6F543F95A9C0609387
      1938E3AFC82CB0E42E67F182A2C3B4F6014B000CA2A41EED0C388270CB58DADD
      7C2601F95BA317A098F23777D33423B60DB019678770EB249FC3341A4976291D
      D754FCED69D40F4096F99B321D0B036F2B0832C03C82C1C01B04FE9D9E32A50E
      85F48F6CE2B8AA07EDDECBC8D39C60AFC34438EF1DB88D2FD467050DE1530FA2
      2F494297931DC69A93F7D399357C05CBFE51159560E38167D5DE0A1C0E312C91
      C2301E400430AD93407EDC73E384595945B1D5073391990144CDE2127F7421A2
      EA06BE38DC23619F2AC033CFC9BF820B56DED804F926780B7228D1393EA9720D
      0FA22BE1E8F151E954C8863439740F372449968F6999B4568D8FD82B4B8CE881
      7634C2402E1B84F5F7C833D923FBC6711EDD28D2349C338CFF2A7AE7D7867450
      F3B2CDEEAC2200954290B6BC249FC48DCEA31A4252D27B27E2349E73912AEEBA
      236E04689F11909732829B3A859E02D9A23903D9DEEA6711EFF3D34134071932
      A948F493B10122924C931274D4B712AFF13077003013EC54D477860416B97205
      95BD7572F406A31E9F1910189820BCD479E58A0EBD676F48851B60B131602C00
      325971C9CB4778A780DE5ED9CAA90611A3DA121B966BFED6BE0E82EBD61DFD71
      D5BC14B9DDDC656C79080572982A460296668E56891EE196633BD050015E4CB8
      BB2EB521C0D8F55169A941EBF07067F6E37416D74C9B63B14A49429B9409B99A
      CA08BC030957CC8847156C9C7CD41D25C9A34C5262A5D795F704E4AE18FCFF6E
      95046A9DEF8A6EC948901A4C1D6998E4C94478146990B22082F1691D25719592
      776144D99B06FF40E38870D33C3B9FF82243A87A1F8A48A72EB159096C46494B
      7A10CB450FEA0B3A302B217A298178BA5FA2716967294F5825CA329A2186B106
      E8D74EE4B15A4E07A6E3109D4A018B4EFF3579F4D59489052F5FF8F94EF45E6A
      CA105CC3712405411C6765FD2E4260357A9FCA39CE23B78C2F1FE58F0ECA62E6
      21E2775EDAE26299B4C5E25AE6CA2C66DB5942524999CB3D898FD92473F5F947
      FD5432E5B6A88512CD7846D735721FDF9BD001978F7C0AA15195B5B0A705CC1E
      38FF2000B0828C33E3C8914E26F5362EA7656FC4AD87AB8C636F3121797E13A6
      16F3A9F39485B78AE3A3669A4919CBE08E31AA0B19BBCBFA526861313B8E045C
      DD0EB06013C340D05D52E6FD60ECD0B152A627A46C04971F082E62414BF6C6A1
      AB6CD1876784C54C497A31E55893560B9EB8A3158F00642ECF78541908AC2834
      41DF1D51F0DF6E8050AC28035108371AC84048F1B10A3B36070D06BC975D5582
      0DD26168E6E08DD0EBF5D7BD89A2BD7CB18E3640A80D17FCD20B02687E064E1E
      24248A1617668604300B4E33B2C28B85C7727E198D93AC8E454E52D2525089E1
      4BC83EF43F14941647A7CA962BBA13D2012C0DD58FD5F026E8F11DB3EC82575D
      966637295EBE5895670729F65B12ED5A43ACC27908FF616B17D1E1E84B9594B1
      24B761E1A7F99C3742637F067D6CA917C1F88F5840CF2D57B5F471B1B2409B8E
      F3FACBE6E2F0FCD9ABE8B4284B1C3563B730FAD87904D7A27D0B8ADF74461782
      CC50494A86F554B79226D15CD477CD6D69EE6448D26806BE3D6B87857E1A2BEF
      CE798EAAC0B462CDA8FE9884A644D167A009447E25F911730B2988BB6FD749F5
      8C1B639B879F5B53201EE05A80D40560B8416B858DE6128FA90B0E1526E16E19
      9D7B23A675E87AD2C3EB400FFA5137D0ECDE89525D40E61D2B779C7E85F95FB5
      F8BCEEC46739166838D3C005CB8C1E4713AC1B601CEA14E43D4AE4800D2A2240
      025D54226FE84E7717521ED1E9D6A3DA72541E19BF710793362CD3F1A552FC2E
      E3990949B3341C5761EF6B5AD6F338EBB998AEA598724DEAA93D90F45DA97B00
      748E0D822568B0B78308A481DB9D948E49FA245D89DEA066BC74E4506CC60349
      C5E9A408E644536480755CD11FBE8691FE00BC82C3018286C14BFFF27713B111
      56AC87BB5258AEB8921B64B33B2DEE92789DD8AE865FF9D194A7C05851712B42
      136E5717E5659CEBBE8B1CEF0FC845314642885B2182C8AE3F8694516336D6E1
      C989232D60CBB99A7CDD31B69C2306A6E038FD9A8E9588604E697F2964B525F1
      A2E930A123A0AB21963EC8E032AFB9A6DFA8E68783B9D33C9C35457FE980B7A0
      0AAD8E009B23EC9CCD1D29982952C531F6666FA20F9CCC493CC204C21D104D81
      BA8C811B4C8AF21A48B29EA336BF5A2C89C66715BC5CD8A77C2C0A948A9469CA
      865F0461778437603D1AC8053F4E90DBA7CA3B0EF8A4D0E552DBB34B4CC02412
      14FA6581159A9492E9A4DB9396E3453C5C7B41D993D46D38FC368BA598281FDB
      E9E0F843C11BEF7C6D4AD929E34FA20CBEB73C5690AEB4E36DEBE2F25268FF15
      AC1EFCC6DF29BF7EF71916C9AFDB9FA3EA663A04E15AAA13B8C208A1F7C19671
      B32C5C385F929B618175E00B2D7C87076F37C87FC80F2B9012685E39E5799546
      2C10876353F2555DA51B95038B492D6537440D130B8B3140ACDF59525A49E861
      5C891B449849D4BD124D67370542CCC9751CDC37662C2C5F3CB74FF2EB79F625
      3AF3F9CA3CA7F6EB32431EDEAAB8CE103FF6C9CE83E8AAC8C6D19804782C773C
      E64B02A099617A4CA67A1AC5D812B9DD3DC2047019323F62BC8F64E20D50A571
      70337329295532994B48CA953E13FFC6DC270152926F31025A960AC1A902D145
      412D18F4C19CA0699317505197850940C6445074BB197A9314757E8FFFAC0078
      F9ACA2F0F9198089F98CE4319AE7B6C015E45E7F320FB456BA4A5CC981F01178
      A7D0E0D730F7F6153FB5AC9732F4429BCE3D8440AC3A3B8F3FBFE225EF874D0B
      8596D15B4D63B0DF388ACDD0246EEDC5CFA4726F685C2C0101845B6F57A9DB45
      DADF6DD6CCE45E5A7F000FD5A47247EAAAD4A5FC8AA8E3BC723602B3AE25C399
      99280BC38861532BDAABDB08DEA579C72E033CCCC20FD4BF9872E89EE7A23876
      B4B869905329106110F7C9E1C2BEF550E780625258339324190FE1AB7A923CBC
      7D17F1302C8F3BCE0387EEDD8397A341251D5E7F32C484D93E0136B6DE8CB432
      8ADCE06F677C86EB90D69A7731321CF13625A06CD178271B5E7F6014192A4F87
      267B70FAD8D390A724A79C890FD39FE16146C721C82D6F22562D79D9C070E8A1
      78770F333B9FDE41E7EC93D0498FF331C2CB0801A0A3FBD0B35AC1AF61145E5E
      9F95A8700561B14971B7B8167120125B8CB45AF17C75AA0AFC222F3ABC85B70D
      7986EB83B98AA6D3644CA8D6D957EB9B3EA7C538C1FBF96DC2D21A0B39451D63
      F4918407900AA86870767001658DA549D28B8C0F7EDD4BF4357242E46E08F4FB
      508DDB2532614948AF25EACB5361817BCB4DEA1EE0A127E3A8C267C8B68D481C
      1E176AC486C90A3B792AC9AD0CDA5B3AA54CADB899920F163CC53CA606F37F84
      6C374F0371988B3304F46606DB42DE17D40B958C206666AAA41C3E225FD610D2
      87B975A9F167B46889BAE96325EC394CB23451C953A94D8D72EFEE36B08A5EDB
      318A21989976179A50F28DC7818878C715CE83CE70C894F99620F119EEC9179B
      15294D90BA3D990A28B2C49864BBA499201F57CCC2F2D11FED89D0F3E6CC87F3
      A7075700BD1CD968DA10DC8A115D6A7BAC3A2D2C68A65B91EECE203435043703
      C641C43545116BC9514EC50F606283F2A27878696C568ACF92D9770D25FE18B6
      3822878D6F6BB126108ED41F6065734B6C039E1C64D4621C5C168E216EB031D5
      C832CABBB7F77DEA90BC27571E735A2CB518171BA59570C0DF01453A7728CF48
      2E3FABD8D06922833B1E827DAE021E173E52A67CA0D5EEFCF0E17606887B9CE6
      75598CE7239312FA2659390D414C9974B0C5E8AE28AD46A31A83683AD73F630F
      5AE461E0283A7604F8AA48BEF0A3A6C85BE20C791D5C39E475D00811F7D95F70
      AD674D859C230208B8DB78CE51F6412C761282542DCEAB33B118BD188E583E96
      9ADD28F2E10337611FCD59449C613BCEC7DB120E91C40A5D590E8BC8FC322AD3
      EA0B8D372DAD6EC790E6478623EE717BA210F6A6F18D0ACB23B9C5413F0A4379
      9DCEC52C845BC75BE626BEBB83B7670C58502F5CE910F8F3ACFA41C9F95566EE
      D4128888CD5846A94C372E2E65D96A9E8E3029ACD38B5774981DD2319B5A29D2
      CFA6CED80269C0AF3089BE60D0436E40100D3620102CFF600616079AC6619206
      050376A2A379892B1D1092BEFCA34ACA6C6C53847F319F4FC4AF2DE4CDCAEA4E
      28C8A88EBEF74E1B9CAF61592BE14EF5C764632BAE6D2E1D32A31C67AB14EB02
      636D061E5DD43F7E7774B6159D9126712CE146FDCE45314B4751FFE078EF64EB
      0EF10539ABCC143780D79B56AFA2E3776742693B7E77B6B7CAD242F3B6BD020F
      4A888379723D88147B0BEE5835181AED2C6A6CD1CA164E6A902215DCD4167183
      E16FAB23B85C5D523F73A5F8E5209D20106B476281068C09EB08A359BEC1D3EE
      EE559AC46CC3DCC9D4AD5434369228EAE69040C5DFBA3715334FE589713F73D8
      03CB3D3CABE0344E2492C31A22A9EB9489C9378FCAF0B7093D493D31AAA4D90D
      692B2DD536A5D43F17264F0E0D32ABB595234D54D3244A5DCDEB8FE3BE178AA0
      FE94602F1F5625201C04A292BC991CBD68126BFDC016C62CAE78496ACB255C4C
      17E5A928E8CADF3B724AB8F2F4AE77FEE3444E21F91C6E9D2153C20C6AF8B5EA
      CE7A91A2003D0FC859B8A5F5D545108665839C1DABF4B1CDB3DC4C19327CCB65
      332EF6DBC6CD3069D86775B3BC2084939527CF06FD69AB8B9AAB3CE8CBC6AD07
      3433E1FE73AE45C34320F49B8509EE4ED3501F88B7801E6EB0DC90112B803931
      CFF9949C76644968F0DC244F35F827C233E27BD1F05E7E6F07AA97E23C05AE40
      6B9DA2DD9B627E87E30A27B03BFA571D52FC7670A98B3D29BDB87509A97AEE58
      EC06A7906A2A45FD3219CD4B647A38DD474DB6722761989E23823FFE1823774C
      D962BE1BCE020159349ED7574817241BB24A98CB90BB7C74D32BD0161B5937F8
      4E510E94795A51FCFC9C918D37879FF77FB9D330EFAD37CC2AD92A1005B027F1
      02F9003FF2D407E81E76451F631A3F1205D38A527015BD4A8DFA89B62DDC09EF
      77CD40A517C26086A6DEF9722C42F55FD8EAAD7EEB005F2BE7CD69ADF5D39D64
      471EC00C7BCEAA606A2E88BE65251898812D050EDA97D72C29611B8A1197EBF1
      C673D86C4EC23BCD9795CF34C9204806D33BCE8F1147917DB9933D609947021C
      9C1663163CD330FDCA681D7B680EA631B81A86D32058E55A71C0A1FB384B240F
      20AE004F2DB23C8D38ED0E7A16846F5EDB3A386349CA0D4806957313DC9D042A
      D41F55A4F187A72C6575F63CFA74BA77A09E855DCB52914FCB1CD11FC760CC62
      C82B795DAC0D1B7E01EDFAF3F9F0B28C6757E216308FFD3A28E2A2F4D8C7FEA2
      DFB0B11F50E44AD56EE41DF3C29D9F36CB964313C4C2EB22BA8ACBB138F3F7D1
      B1FCD30F3FB2C437B386F6AA0AE359E4AEDA10F79A38E48ED0308E5E9355F08F
      F99487078EA6CDDAFE71F7B96B9B6BD51C34A983242FAC4A8269DEDC1A816417
      89020C864D0BB086344D9959FCD8547A146DDAC71F96F631D06D8B653D60BCC0
      EE3B7BF6F8E8DD2721638DD33110565F900BB8CABBE3A3FFE07BFC7274F41F50
      725E3C2DD6EF1E6B8A4AF78E4FF70EA2B9168B96ECF2342717EED9D5664F7FB2
      CB52A08B6F4F861FDE5DF507D2405D53DF592BFB393F1BA109C558481180DDB0
      61AF9E3E0D4B5730B75D95C834242AC7C4DEA7D38356D54EEA9EA2A2D03D0AD3
      3D63710B96D4EE9DBE393C8A7EFB2D3A8D2FD391BAFAA271F2DB6FD1C1DEC55E
      B4EDFE730F5A87708593694FF1A84A0BA9FA141F04F27636EE198ACE21F37E02
      B96A4DAE213B29666D6EBADE569233D8DAE7498D8C467AB34AD62B90E076121A
      D8C707F7AF1C77E02BC7C99AFAB7AFBC3067A5D43D4AF3E8C5F3A19665105C26
      4656912F5EE4A772EF939A023E8C2DCCECDFA19B1066850161E570254B8F4B5E
      6508B7342787811BD661121AB5F7389199F73B74ED221E9AA598BB503A02F78F
      E971506E37D575F63B348F6A53C0692028B56951C3BE2B7C92F0C9A65CAE7C40
      89B84BB4E69BEC7146D58C79F2206DCA7E3E146AC1387A7D7EFAFE7E951A9737
      2095764E3E9DBF8FFA8CB1A352EC2CC9B26ACB82160FD51A6FA1CFB052A5008F
      8B83C0C83C7D73FE47161BFAE17B5873F2F2AD0461107D0CAC53BB8ED1457802
      C2FF73066CD3020145B8D8AC14EC9F9EECFE887BEDE2F0FCF92B74AB1130DADB
      FF70F8DB6F7F3F393BD8F8E16ABBBE8A4ECFFE7C2408126B7B2097B2C81F836F
      374496292FE907DD9532C6541F556AC873843ACF1190AC5F45AF8B82521A3EBD
      A02EF01B5306D103C4F44174420C60DFA8A796AD05CEA6EC5E1729D2537DAA18
      FB4192CDAED2E8C9939D671BB5046031C58E7A90A7B5B7948CAC0CAB0B9149C8
      537824CAA6CDC5CFDD1E65A9842718FA71C4F1BE00BDFB593A230172EB8E696F
      D1F9979B329D46E787285BA6C4F2E804974DC039DE99C59BADAB77C5357CCC4A
      6ABB8F8A828603D0AAA08437439056ECDD856EB4ED8D9A7D5F22A82CD16C9392
      94950C6E0FDE8D07018B3793C8B6512BEE2CAC66495B186875EDB1BC597B6CF7
      2EB5C7EE5BA66F1745EA8E00AE4A29088A3745FDF3BA98617D4981DF43647AFC
      1CF143F9042641DE5A627768F5C9537771ED9BF05AF426A98FABE3032FCE08FB
      6B86B4EBE830875F4021874DCD45B48AD3F3570BC77F9657A91EFF55ABBC9F9F
      FEF55D606C012FC32A192639CBC4A8CEC4A68DD3B83F76641948C5886628E248
      37659A65E9C8319F59CB56641C346EF7BE2C90DBBE71EB7875985472BA2B24E0
      C92D298A114AF1F1F994D831A909694E15F6E8E4ECEC42BD5F3ABFAACFFCA017
      CC8E16C656DE8745DDBD76198F034007A209EB92EE1466DC49AAFFCBDF3EC8A1
      BC1F6754E14E8EE251F20E31C1AC32098349EC2F8398C8C6833449AD0A89F9C8
      F5282D517557C307A431209EC9526552FC0F3511D24ACE4BBB0B78673C48A7AC
      50EB78EEE2537A77F78E901EA67AC8AE20B64227F5BCCC0DFD44E184595CF5EE
      6817EAF43EC85B9C9F1FBE8A4E8EDFBC8DAE913BAEECB513C6947E8E4E0EDF9D
      3F48339604BE7F71B02722D5B8E0EAE8DBD9EB16B7E8C15B78F7E9815A90DBF1
      AAA841F537C416DCFFEFF607F2BF7B598D7F8BDE073DFF1682B7909572F71BF0
      F91F7503BE7CC93AB5CEF6797C72F839DA8E3E2AD8751ACF58CC3729A30BAC16
      D10EFDFEC70D1B232A8B5C8BB361967EC5A5670080D796C49E57D8FFCDE1D186
      0DFDC86B3D4B99EC4DE29F6069C649471D34C9C9A7D0C47CB82DFFB9A117B60B
      D82C668553969727F59C271966F6BA28B37185CC5E4DA23F38D9F7073C912089
      1F859A242AC379BFE2BF3F3C79164CA6166844D52B9E60284C23188067AF45FB
      A6C0F10BE86B645565C5669EFA9F7E209C7874F6EC55B4978FAE0A48C351CAE3
      FF8BDE83497A52145F8A79CD8FA099CDA586688F30492C5545856FFEBAB7BF61
      379E63D9590E21AF2D8FF15BBAA8993B98301FC87796B95B9F8FD3FC1FF4A037
      75D83924EF3E21214B974A344623D322A73A3121F6A4A4BC0E0AC35D26C534A9
      CB4D57C0F7802EA5F8AE6F2F1BE5F32F31D7A5481CA694584EF3E8DDFC4BBC7D
      81D5823AE7491D7D8DF3B4DA10E5FE812037444BEA7466D6C338AD8499033E81
      D404969A8B9BB6216BECF92B4B183A1B62824864AAA2FEC1D1D96BC3103D94FE
      358D231CB645B9A939FDC3CB27D85ABC8FE4B83AAF95989899DCB598F89B3EFF
      7B0552DCA5F04CBC024D20A79BDC80C775856F1A318389CCC2613806B4DE9F66
      C36007FC392FFEACCB73D316B01AC4B851911C65481673BC93F3EB75BFB7F563
      370DC33DF717DCE7E81C6CEB3893AAD94B68715CF5F48E4DD27FD3E8D68FD1B6
      A16FB2F8F435E35901C1CCD995EA6528D2B0DCC9B8B98729FBA71FE966BA2564
      845F2139945210AD90FBE75D7255A6539C059B368551FE0013C133178CCC87A3
      5D4AD37A3D4054896D58F29BB68B557BF0A19188E4C3C9886680E2CA5B5EFEB5
      371E1BADE0E8D9E3779F366DF747B5642487FC24CDB16C3E14C5B48AF6491909
      DFDACC560C3D16201DB6C66F48D5A1C5BFE982635C5F3005C49C3C8B8F5A5B51
      8A12D71B3FFC391EFE26A9DF25D72E8E05F6BBD41EDE8DE2F29255DD9543626F
      7F7C3D64CA895044A2349FCD3704107E7CFEA38217CF3F3BEB516AF491D71357
      641E197D50C26F9FFE7ABECF70F1A621605C2D2C1B3D839F3BD6A0A294DF4174
      51F504D55DDDB415BCD95FE7290A6BCEEB22124D663D342645394AB6258D20EA
      7D1035E6B3A3F30B463F7B1B3629548C933712F53F3A39439EFE24A468B2FE99
      801F78DD19322741D9D8B4415C6654785603A729655D26DB8A4A7A4325A8C987
      97A6F45A5FB2963D930301EF0D51B81F5FE2747CF77EFF3FA3476F12D655FC38
      8BFE96C4A0EF3C72160379A8B00D9F30B763D3B6B0920CE073B516E4FA7B1BFF
      0BF9FA6E0B91E5A81091A497D00CDFB4654C35DDE328CDA9D8872A3C5C4EE364
      94C5962A2F75FEE633EE249AFDE093F21F960FF0B0705752655E3C11256924C2
      2B081356BD2B7125C5270396904B12360EA2E0A5563772D333F4B6AEEAA97378
      00A130E49A9CEF63307D7FE47751EFD072619E73AD88ECC1847564767B1AC2D0
      23A3C75415D186C120573D34BAB1C77B5BD70F111389B3F34361CD849D9E25A5
      98C852AF36F07598130C5235D2D95C05149B8D9D6185B4B7B2C5827CD06E9F84
      A76B507F9EAA2DA2BCA79EBB028552AB882AEB7CDE83F6E6C5F308A5092CA5C6
      E1F3A21AAB52E6BEA80B658585B0F4FC9E0EFC6D3D52654CE8FB6A1E0D24C50C
      1016141295FE70AE98B47A7613FD739ECC0160C65F5D46665CF3198380586DF5
      80B2A27AD85975FBD9AC5CD0B3F906483496A23552BF5775B826D4D436C2CAEF
      C1D2EBCBEE64F84B452BD1D3770023EA42CF213269F23863A718C8C62D8502E5
      B202CAEA0F8476FFF4C35320767BA4C29C9F1FB2532C8B9523613831EF49E9EF
      9B1EDB7FFA7117FE6DEF637E057F39CEB29D9D9D9E456929A941A6B1D5369B26
      F97CD386700F8B4806F9883454A3D3B7071781B87968D541645AECA5735CCC26
      0F5F457DC408B68FF980BF01DCE0435C487EFD88B01E9B4EE40F83BC426A4435
      E81A84875B1EE3751869F474CA0CCA4E50615F11931329673BD84DAC10147BEA
      AD5864669B19D47126F9D36E10D6E7197388F1F8CEC48E1B691513237DD51292
      DBFFC4CF6193BF02108A6D4E4D5AD71155FF754750D4C781CE3444574D4FCD3C
      A5B153D996A30C9BCC882CCA61D122ACE74EB413A77177C55E9A5A2EFF04AE30
      DC6E9F298438DC204259CBF06DC6F1757E39471614BC0F64E316F9B028E98CAC
      AEBCE7F9213AA723CA5BBB49835D4C8FBC8FAC0B5490BADEDAB97738E1D91F15
      4E784137ED0375CC67716E9735A8861B3E90345C0D95B74CA6572E9A2B76AA90
      16215B8FF97F1C1502047256B1E5CEF7CF4EEE15BAFDD30BFA6AAC11A1814797
      515B0DDAF414EC52917DDA930A4708298B4C18CF4CE6AD25F95CB600AE045508
      F73F6A24E06ED8E517E83215ECE23ADA1DEC9A0E57359B930D289584E4540923
      157A8F1868BC2177F6C5CB5D377F07F134BE840708CC322166C96064160FC9D7
      73C8D1A64D09C540BCD6E38B5389B1F0DC3421DE3C2AE9E3125DE77A69A6D84B
      B2F6A6ED1324B92A20BA1E1D9EBF1713F5B4188B88E2A64F45F0628F54DC4F69
      21758954834CB14391B3D41A2910AB02C5337CD30D5BFEF1894EDD63A8E282AA
      322368C8C524F91BA214C8E39BD61BA3F4599C8FAB513CA36E4EC652988A8395
      0665284CE3C0D1FCD186B8D00BC2BB156437E65C43287A2639ABFC97A65BF852
      56344AABF950CBAD204F8D459B371E24C2F437332652003DF8F9E0DDDEE9CF7B
      79AA02011737B3E455F43AC631948E106F7F1D6354EA74B461933F10D6A55A45
      7D150D63A4CF62055BF63F6520B1F4A877250AE49589500BBB936271451155D3
      38CB367D7342AF026A9F68A5DD6212F50E12646D544974F8CF793A237ED6B3C1
      818F5B8C3560B169BBB07FF7A5888E905CCD0B14FB703F035887FA0337150AAE
      E35F75C97FC148FA1B07A04255A64D21BB974C5DD1E269D385E26926FFA3B5D3
      5889C26AC5D55A88725E6D0825BD7C82B655C4F86B70202439050B55A53BD914
      AA7AF91407B6009D3E41960C392C2972462090FCF1FC62D30670AC506FEAE2DD
      A90F4A332263398FE0D5A7758D8A9E308BE6B99477A2EC2AD381E5D4DBBD0726
      F7F2292EC693B38337B8CDE39C678534177A9A72377F4DA2771F4F588011A56E
      913646080DB5772D84BC61379E11864CAEA3FD5F50D304AE399FAA4381934275
      3A655AC70C39F85A254A12F381AB7BA0852F9F01A77439484E4D24252E04F2B3
      4FC0B784665DEC9A95C42CA434FFE2921C8B32BD64860C568F8BBFA27411F252
      E93B6CDA579CFC525C9A0A1F72B2D17D90F093A39408B6382946736A01F8445E
      E7444C8B0D8D8E97CFE88D4F87E9E5DC8417186A7C54457FFD787E1188BC6FD8
      C0F3DB1B78BFB7FFCB0334800365DFE67CCFD8A0CD460CF30AA6791FDF9C9197
      B961CBDFE3A8710B4CA7EB5185FF322C4BC55699B5AD0B4908428020B04DD2B1
      96B5820E8A04D098FD807C34BD94D28785031D8DE2A0E1FB8932280A9CBC2E40
      6E4071B0F8F292D540360C6FDEDA038264606BEC7D3AB5786E1AA3945C944027
      1DDA1D5AF58E81B14BD9940302D2141A914A60AA44AD2E34BFE7CA213F0235A9
      F8C2908046828074B2DE3CDB058782FE0A7E86606605EA5BF6B0AF0AB0874004
      A01E8FF4C0B067B13118B99910A918A5B18A590E397AD0DEBC75A0635FC1DEBF
      443FECEEFAB2C94623106010D9994128BA510D48CE24DE2C2E23DF6263BE24F0
      83F6BE511A454327127083742D3043090960D5443D247DE0752E8A5E34838CB4
      08D4F85FCA4A124BC1A7333E688F03BF1E7417F411096A4ADDE35D5D7D116184
      076D3764A4E04FA9A67632572E2B207B6682B5EE64E4F24BF36D2AA9AB0C861A
      DDA28DA0756F580F74C3C3FAB6FEA6B9DF0DE2F241CA548EC3465539CBF1347D
      1A250778E34157C23C17D2F9BD48C8B79D5EA179616C8249A037E7FAABD1C0E0
      CEF15FA790EC3E84E94B5819132D55E0C31AF780126EEBB9628CBE30D034ADA8
      FBEC2BE1F94A85C6B256D3FFC123929AC4F1FAECEC17087F5303F2323A7F7F78
      E26AEEC918225000E3F521032417E38966B4ED806C72541653572FD4ED080D8B
      AAE36945347DAC8E8F7EC85E4950E057B0283E2B8D42192A4D99ADF0B0ED6BE9
      455677CB91209957C9D643F64AC02FAF131B10A484A293135179C8268DA3BA70
      2FE190E2FE9E31CC0705490ADCBBAA2CED13EC217B5594B3AB1850F7927D5B05
      F891A8652C10D58CBB6DC551791FC55F455D7AB1C4DBEF1B857B41BB3F00C72E
      2E0E5F075CEB4587B6F73A43C56B579D6043EECE8B973F361BFE747C7ECC8BE9
      FDFEE9EB90D278AF2CEB3FBD7C0ABFB49A4F26E9374132A0712398308C04D8E8
      72256FEA3819BAF819514619B5274F8814F16C07BF699BE978BD26A730A8C642
      39ABDE5B714889FA31560B19FE7DA4590296DA6C9C7D9E37BA10EDA25B386AB5
      EA76EF9CC5FAEEFB6CBA0BBD0F52C85758F9EFCB021773197D3B3F8C0E5D71D1
      93E2B2E76BF46ED4EC07398EC5A60AB4EADE97090CBD7398A2BCB9A0DC2DD862
      400A412D514D53401072A31E305C6B74F0AB54046EA518828693A16FBDE965C9
      A74313907916446A20F3062180F950B8D1D1DEE64216C19D2BF192C377FB6F71
      2EFD9217D7048370826EF66C89E6C715CB6FE969A760CF7DD80DE023E12065E5
      1748A5C28C7229EC9AB32680BCF0CC5A4C164682A2FEEEEE93EDA3A3A37035FC
      B0BB8B8FB6CC369FCEF07CE5461E9E6F7699B5E37BAAD124213E4BC514763F2F
      AA28A3A5E8D409F371F4F6F8E2F4707D3AC6396AE424B892DEBB126E5D21DC73
      A4F4F86A6F16C3D54228E249C75279874F45519BBCB8DE4C6C5262CEB8B13D0D
      22AEA2ED7F569B050EB6E122DCF2CCAF1B3F14016BD85304FDF0A8F832BBC7EB
      0AF593AF39BAC763D0ABE051F168ED25A1721CD8823427614CD2945C553E18F9
      AB5274CE6537A47974D0600B30A83F4E6A22580CEEE33BC6D0B230E416339599
      A91953FC852184468130AD5D807E011C568EB569F0BA7AE2F1D80AD921243225
      CDA1A1C9CA3B93FA6EAA37DD3EF101C35BC9745CCBC26BF4F58C59C0D7F13185
      8E46B97C700357D321C423958DA3A3A676DF6D281B59224ADAB851CD473235B6
      D6E0D1A8DE1C8927CBC63618C385C95BF92EAE0290637640813073A9D24F8393
      63C313E15D81E5882C399724A775EE65ADF8DE7362C5B9B734BABA68AFC606E7
      0FF3775ECCB3683F4E4BA3FE8E13C4D686D436071565B36E1F8146D7E8B57AF6
      D2B576DF4D37335CDD7D9FFE4E4EF40DF46E7951F26B5BF7A6C83C5D9F22F34B
      B17D94761E0786AF1613D5958C2BE02B723AE05280128F12C5B4CE80384AAE5A
      31EB3A133F781FD765222AF78F218B10DFBC8FB335884D546E0CC84DDDED45C3
      02BA5B90D945BE0336D9B4C86B94491A1788B621840CC4972F3F80F354025E1E
      A78A6F8A405C09AF3122EF547A0F518359B2332AA651BF28F90479832D26E77C
      FCDF2BCE88441A8CDE8339C21A194C9A31EC59FEA845B6751143A543C242CD3A
      DE53E0C2705DD6A7C02163A17C5F2475157D4AC749D1691CEC7151F5E48B3DEB
      5493EBB7691F971C37A4C41533529EFEBD985FCC8709AA38DE90EEC429D5EC33
      ABD2862A8505A55EFC6BFD51AAA32F026D3F73F6DE27E517EA0BDEB0AC4CF4E4
      FB979B3E5C45B004DD366D25CD6E969549AD934715454F3B4297F62349E1622C
      E441813B99122BCD07C66A7E1D43133EBBD932A0CCAD01156B105EAF67CCF07E
      8D21F69BA10A900A5C3394A337330BD63D68BF4979F3A59E702243679D18717D
      8D8A2361412C7C47727A590445AE19B15CEC6291B81E09AD4C2A10B60E954FC0
      CFB99AD7C0A51E1634A5CBFD319FC3D8D1E80510996212BD3E950A360C665074
      5C6A9DC595CF96A940AEEE2BB2AAF7D730899E8949B4F5A05D0D8A9516135BAE
      98619C826039EB6A9088CE63C233F88709DF3BDE2C4C11D1C57281B1B41CCDA7
      56B7A321E0295A2E167275B81BA7C659772C71FBA02FDB3B40E1F3B61264CFE3
      C8CC3F0AEDDFA01EAD5A8B88549AFB695C1B6E05CA0A88B5EC588E3C802922F9
      F07B446EBDE39C23090991A0E2233783E62A853733304F561745C64196CE04FF
      3A225D214FAE1D4133AC5D89E7191DFF617709110E2AAC82B3B577F1015D965D
      F3B0C3A5560EE5EB44C73C85EAFDAD572463A5713444494252DBB000F271D4AF
      AF62049FABAB78BC7B5D5DC537E367AEDED824FDF6A060FEB9C4C7683F17A564
      B1C9B16556DBE1F92983EFA209707E2826107448CE845AE11C2CF3ADE89E79D2
      7BDF8528982C6D825026C78E22CE0E16343BDA05EE0ECF4F1FF47DF7C663D52C
      EC6F39C726F64E8DA8F371AB598C41701A8D126F5E04E3B6C893A0FE61694960
      FF01458C250529E5D5A8B53B958B3588FD084A78AF10E72D111F0F15FE8D6756
      3189DE17D712EB397F7BF6B1C5DD6291A7CDA913B7869D1465266A65EA626EAA
      EA32CEAB2C2665C3CD5DC01A410187DFAB3F651D1D9D9C5FD8300C59485478C1
      F75422BCA5F10393EF6AC59EDE7CF8F8DE854B355E8982CEF9F624AE51CD4233
      61DD9E953B72B1246707A0E4EA083BA9BF4E3762D9F7A53AB18F7F0529C46A54
      49A902A0319C4F4564A32770985C51A7EE665D6356C1D35740F693B213ED39FC
      B8E5DA688DDAB2C85880657DD7C2DE58D17939585E8BECA0517E2064599420C0
      0D6F4CE865B533A65965BD4D5BE8B5DFB1AFC320AA7BE53CE9469DD46C464D25
      4D9C9312E15F9341A32BF1925EC02C951E2E263FF9A2C8EBC73C595047A2E261
      6D3799EE318AE252DEAEEB756E7F46FFD11E99D84792EEC3C2BCFAAD4783E811
      CAD2229C21A269B2D50351D547A2A6F648E50D7AC7ACB881A2AC486CE459DD33
      FBEF9155B561791C5815C3AAE0B3AF6FABFCF1A82DAEF048B2A15DD97287098A
      085434C53D72897B7696C5BE3056E7549F226931AC361B0F610D2CE83AE81D2A
      C7144D9DB432500A2CE071311219803E1863968BC690BC42C6031A8C74B41294
      2A75D3B0B5FE6AF815BCBACF4BB328074B6814323F7C0B8A3880ED87A81AEB21
      AEAA2B2CF5E738E4BC09E9027302AC0E07AE40C9C230D84862FB2831233E3112
      1CD3663D6CD583F4986A3764223F10FB895D19A0EA934ADFB329EA6757CCF7DB
      0C9EBD3531F51534D0F0DACBD98C96BE694A3D902DC1671B756279FB9A28DCD9
      F6F7FCC6BD9BF66BFD1574CE5CB32E90624D1E9DF16DFFBA77DF16B5311B3E7E
      D868C9DE7EF3869A4B1FF3C9A6F0313EC587ADD7DA7B73B2D0DA8ABDE1CE22A5
      1272454ABA4AB41FCB05A2FBE114A6ACFC6920E5D2BEB0B85A1257022E2758CF
      B1A1BDEE16B30C619415C96D77D98E58FFF8E07050650827FDE279B10AD3F569
      AE0BF9B00437EAE23261644792625B21BDA26C040BD73C010415AF2920E39349
      0AC547B5C09A382D02A239DBD402115A6465544CA7380E615975B6C893C4161F
      9747FB4DFC380806B918675A350987DFBAF3B3E92E25D7D2126A43AE35E27110
      C0F0D5886595F69910BDEC8E905C9A81CA4B6E894AC35717816C28FE10BB54F6
      31D9FD468B22773D85E6E05DAC1B4D87DF3441FFE112F257A6E37725E3B74D58
      C1C92D9AECD356B88E515077E2DE00A030CBF1D235D7ED9D1552458DB737573E
      D1BB48F220898BFBD9755F6677CFEB249E22712E89A74BB33F90655D41A0CE99
      5D12526317E441AE18BC090388193B17312B805D5050D6377854493D1FFC68FD
      793F02BF735E472F5F748DE4814B91214E02D633A03AAB9FE0CBFC614DA4B9A4
      2F8E9B8594D33C7A02615EBE10FEF53DBA3ABABACBB16925594D186F8DC299EF
      5D501CC32C553FF529FE4D44395B0A78055F80B3D1D874967BEBDD3909496699
      1665971A54D8AC1298DD89FA17FCC8E115100247BE0555EC60B739841592D7F8
      69319988B9880F14DE2A2693569121C1B424406DA97EC22A904BB04D5637F22C
      5F30A89F4BFEC192D2E370407ED9D9EA94AEF010220A7ABF6A9682B4DA704279
      63F9D5BE236A487D695F5CCA55CE94809331FE8505C18AF462E74B8AFD97202D
      A451E141E7CF78F0E05FF84956B9A56132294AD424C6AABD4A137631AD06CDDE
      07B0B772E0B0C4517282907EF052F2BCF64C606F66DDB71B6E16223932252D48
      A09A6500BB911FDE73DFEA39FF192D5CC07DE64AE91D61D28D308F6E35BF7904
      1513DA39AC2F596A3CC24D87635E9092E23B85435195D8B102FDB2EFF6DA6F83
      18E9AAF8ADE30B8AB2B191C795C2FADE0ECFD67A9049997E357E46300D5AEEAD
      DFAAAD694559653DC559E568D072CAEFFF6267BB2793B70AC0AA1050D2D8265B
      21A6A52B6478A3BC3FAD146B68AF26D579C72CD4FC31A34819830D1AA719AB7E
      2C2B37989D13003F3860D9F93DB0046882F58AAAE9B200ABA81FD40F44BD531E
      547E5926EE44B11FA8B25032DE7A156D63ED603607E0DA04FF81058A7992936D
      FB5D611FAC7FF803FDD74A33F09ABBDE5F02055AA918D0304B20324766A12E2C
      83723ADE582D8F90062F834426000EF785AC5D59944E6D9C8C6AB77E35AE163C
      1FB5F54496504314C2F2943807D6869CE6B84849640D4D2C13FD5AD4362FF2ED
      71424B7AF1FCDE31A331C3017FD3361EBD126099828FC6015BDAA9CE75164C89
      C323BC411C1AAFA0442FF48252B6D276A8248C4D6AD76ACE727FED3E8978C3BC
      9CC106966BC1864C92F3BCCC1602488772A5A12E9CD6C6FE12240DD27D405B32
      09B00335E98CA7A1863A76A2232DB5BE8851F16A6AE352ED86579D98B01B9840
      03E3C92334ED214E27845DE23201F3E2B2D00B49B019A8239888C29DBB504030
      D0787E79BB618FF624298741411F114F3B3F3FF4DF6F98EF245C9885BB1D3C74
      5D1B3E84A1F7245AC7803A1EB50EBC1C60C8670B187260587327C862E489A612
      81A28BB9B000FB41F4559F3BF0AA82887FB47F24AD30964932285AEAB6AFD871
      13715C988E101537CFC0EE6A71581CC1C46825490DB356E2A12B2F707DB45BD6
      25CCABC202F49C4D990EE43D70D83690488316E6E39D61FC347ABBAC66E252D7
      D1F1B19048CC83C23FC52D874084B74C08FE06F5B8E58730205E9FEF95A3ABD5
      5C31CD048DC7E3AA71385F1C9E3F13414F00C95225AC8AAE913A1337BF69C82B
      30796857A1F21E8F1195D23E13C7082949EE0B7C257BF02A6C468E4D1E712C9C
      A125B6B52AAE9257447B94E79CC010C9B7BA8CA3AF05733E84091283E12A029C
      E2BD362EFFBA88DE17595A5DD9FB7FBFA57A99CD5AB648DFAEC0632E664A8869
      CADCDD019A6012866EB2D5D905FABDC0E809BC751C2696D40158524C3D6C2444
      2FBEA64229D1331679298C2C801E18ED95497480E3F60EEEEA5599E6A4D59CA3
      ACDB6B1112EABC503577EBE3314ADF72B7F6D0516423931C298F6C3C6F6D4A64
      CF0EC0165A136E779C8D58482E53CAFB8FA1CD2A4F5665243AB96490E01E6E93
      48A456AA9D1929B6259C3CDE9FDDE79F4A116AF0A871D6A932103B26C0AE52F1
      F1C9DB249B458F95701A3D8EDE25DFE6D56931C6BFDFA4F5DBF9307A6C449AE8
      B1E3073F5632EC6325D8BAD7BB3735FAC91FA61E486DA3673BCF7896A0E95D51
      E581851056BDB61C01CB242752832A2EFD6199C4A8EA33AF8BED32111493D578
      A64989AF6E2816FE827AFFBE8CBBE98A35349D3F1CBE3F41CEE7E9D9C1E14974
      747C7218BDDB3B3D5442EAC34A39D4B0A7253F6CE6512557554F780B9249EF0F
      B6C6A98621A690C883760CBCACC7A641362D60D79900D9B870058D5D3DEA076D
      FB24B9049F93959971EF338C329FC9C5B92B044E2143F286711C8A07CECD27C7
      E562FFE823DE5200391F4A107CB67754D051FA38EBFD5EBA003DA99F884BA0EA
      057C917675C9BF9D9DBD0F9CED875D0C65F125C903FBC64A9050254A1DC376C6
      D1652A56A831853518FFA01D53A2C1F1C569432A8114064810B7D2E71F98EE2A
      152D2F8A593AEA09FE45B162665BF6A2373E1D7E9888AC47C5B2E705F808F1A6
      8A09B7F4464B81A99E1C50B973920A3E2423D60E9119BCDF765D4EC932562C0D
      99B40AD82D66C718A3D2298328C7518DB9A6FEEF12C0EE217B4B2BC465D6CB49
      E66188513C8205E3C03AA1AA2A76212C0D97FE1390971F54F2416C1A8A9C25E3
      5BF04B38E04871A30CE6BCA61E0D8D10092DB991276F32A42B574C77B78A967C
      5A030C79C8373163DF541D25279D505231A384A3540E429283F0A1E59EF3FA7D
      C72AD7E3F02A57D042A4FCD73667D492124BB533967013CD8AD93C8B81F002D3
      82C5DBB0C3DAAE3EABAA2405C83D5C373346011CBC132380B70DD4DAD2AF1A15
      1AB2644CC3A7C8CDFE5BDFACF7F624CE1EB528F5925EE9CF8B1DAFC618AC6D33
      B407A1356B167657539EEE304CA26181A48A7C2CF73322EBE3FBDBADBBEBDBAD
      9E80D58DE6F4FC177B9EAAE5DD76AB6E25F005927C34EBCB6D35804B2B010C81
      5B9B7023AC19847501E85F96F1541CD21D2C3D2BD0A2C219541613E387328B8A
      E0F7E47BC3E29BDFD9AC630483C81E3E99D375E7B32BFD3D69284B186A786D8B
      0EF4AD44AF4252B1C9368D1758694F9FB767E1E90F320B17F4D820F1016F2D6F
      89B72D01792ECEF69724FFA12850CB890CBA4FF3B04F2F91D6FBB880B0BBA3DB
      F82F5EC4C3AD3624CC512DCA488A222C76B87356552B775F54C5C03E40305E1B
      C6AB08C4C6A356112FBDE314DF77876F37E9341D239573E21E8BA534866DC5DE
      2AC18301BA55F0254A1A2651DFAE85A2C4652031BBEB25AD085C17E4A305A9E1
      1C76ADD57519A7F9FAAB420C92EE7DA94C48669F2ED2925B130BAB63156E7B72
      117D179D338C7CF1E124FA2E3A52FDD0807789D63A9F72F42C2855842B8D1004
      082E7A4B7F499219C4A90892C18F350CC02EE4D1BCAC7051142892B770C8375B
      93E5E41A0C87E42E4D5A5B6651E873D8750C6D99E05510106451FA4B04B80D2D
      B7AA327A80DCF608FDDDFA4BE03F8AA233FF7E2FFA5781D728E3D117E8613FC4
      12409BB7A5F2EB9AD81D44DFF1E5B7D7BF7D3F1EE3E46AD7745C8A14930A2818
      6CD5A0640DE73021D3DC3F8C20D88D75D7B45EC616ECA8AFCA627E29E8718FBF
      A0A692A06106AFDF54359264F0511F995816DA6D1DA95B0D604E447739089693
      6D9D12C35E9EA1A8E64AD4BEE3B7B8F790C28CA160E41F71B249F39C642E59F7
      CD9A4BA63B4F2DB6C417B6207AD8BE58347CA490E42BE824715879109FD0EAEC
      8FA53C361777A19A34E0C63876899C97079038E8DB5FEDDBFAE3F0CBD2E0AA91
      429FD4BC8548C3174C128206B67985FBA1849F06444A7628C6CB5E2DAD709D21
      386CDB5556823E5E4C6C571F35B903F42D43195F23DAC75A4FB0DD2DD1615464
      C5BC5C5BB3834FB10977C7239F41F9FF69021B84F13C397EF2312028599F957E
      93DE034F3CAA1D2127286DE840B3C75B087EFC4EB3EB720E9AC61D2C27A77F61
      CF792CBFDF92E799A0BF5296EC8586A4AA396AAA7CD810240AF71066808C826C
      49D188F5275691B625F3D9AD90507722FD211AC029B776D4C453624B7179292A
      BA50FDABD2618AE228C28ED0EF4362CC0A1DC88FD4F080AE9925DE4AE11DA5A5
      8809272FC288599F632EEF24B3E6FE8EC22CFD85995895086432D67EE8A60CDC
      CCC0986DA2D9A11F3F422C2EC82176DEBC9C4EAE441FBFD76FBCC3E3B0C794DB
      08DAF76520B4A5F527FF6D7A79B57DF0FE58B6E4DA1B38482D6C3E213C7C158D
      93C226F47A4631E76AA1F4A3FC61128F28B35B5970EFE7E8C9EEEEFFB197B5DD
      6FA1E31D47AACDD2692A411CC7A6D521311776185B8D4180C52234E432B09D9E
      E6C87652A383A379558B596577C7DD86B8F7369E0EE7E525F29E4EDB95D5169D
      52F76D7EF936E911CB7C5FEE2105B7B9F2BFF42958A114A4C63D49EBA7EF98C8
      BCADA209C16C861DA4B8D266E933270506F35F9C948D1E609918140B225330DF
      B0382C38011BFD708D282F13C5C4F0AA41EC7509B9CD0CE6FE4F5C60E36496E4
      C4C94166902026F7B2276E87A14D5146BF4C6A1F3566F03134F4C4C5BF4300FB
      FCC4CCD0F56C56214B39CB156D5A69D665ACB57E4039C0DF9A95612DC63D7597
      B5E6BC5749EBD9DD2770501C36D06916DE89526BB59A518FD76F0FA8BBDCBAFC
      9A29B5A7A5D5FB88A631D3FAF933BAB887DFBE7D13D1C49DE8105555B31B2959
      BAC06EE3061329517F42869A106C6E3EC33F9F7EFF2CEA614C7BAEE3FDDD5DF2
      620FE46A7ABEFBE30BD76DF79DA3C35DFDDA21A51AF52D95AB4C9229B49E56DA
      E46EEE7CE888E57B02D17735595CDBF043F8576517535154FF28179754C119A7
      97696D09FAC621C55E78777641D83F13ED1595CC1A234435051F2C683ACE6FA6
      45B9221137204AA9609AD248029D34412F44543EF1D5841B1AEE02FB4F6771CD
      89EA6B7152628F2E344D8025774A9578613A9E8C7AC5FEB5752FC86B0FA29FA3
      FFCD79724BEE3A2EE984F94899BF66962CE795CBDFF83CB738B560D1DEA650D7
      7A9AD6D8C443D953C741B405C03DC159C72E4228013F30E3C60DADDDFCCD2DDF
      D9F2FB2A998F8BC596A542B49B99464764716A4F30FB2EB4B4466F74B3226C5D
      C98F61F64ABE845672D0920F5F93C630EBF486FB7E83BC96758EDEE0DB218F35
      48F770424B0641E358387BF962215D49133624656952BC7C71877CA540489183
      81219372542EFD66C7677D0B8AA1792AFA92069D2F54E6942B85937DCEED7B73
      9E7EA3088B532CBE51582428DE64B3CCF04FF7FE581C7074C1DBA112CAD3835E
      F4CAE4E2CE6F9069E523FC96DB048F4EC8A5ACA212D7CB3A8E16A7F3117154A9
      D730124A6023F42D312F099D77BEC4EB394A215DE6A017C6791DC5536635416A
      06A40B41EE18E59D2819B8A4D09566A188285A902BC5B9602EBEE547C639727F
      AE9D6277CF12177C9DAC5BF3E83A96BB5B14638433F6A59641D79B367F10529A
      F52E95239D71D9B1A619CA475C24028848D4D644C798D5E4B266CA444136B99A
      F63FEC3B4359724411CB45929426CDA98A4CE7F47C4826E20C88D68088A715DA
      8D143A5F5AC401385A995428E7865671BD6180F3E8FBDDDD765A092D290A7A4F
      1A3BAA8EB9F7FC6F9FAA24DB6A10CEE40FC05210C7999D7323DE1A6E19285710
      5E522450A5059F0FB48AB72761E2B5BBCF916AF5F49AEE510344918E1802FDDB
      7FE1E4FDEDBFB9D94C211776666880084C2DEB03526912D7C4F9594B14768282
      37693EAF61B8A07A1299F6BA7B14F33633D2B63E73D28C77282BB0F10AF9DA33
      11AE50572AC89BC63B653291AF60C809514AD425C8524A7391D2FFED371B10EE
      AFE4B7DF7AB20BE2112BD10ADAC08789F43B6571A4920197BD9D455971B966BF
      1547BCCDDC60EACEBA06C74191D7EC77F453488E56D920168767AB2BCE0DFF1C
      66AFFFA4659878B18483ED1D48997552F6F1A1DE49EBB541497D6B838F08DBD0
      53C9F66C994C3AFDC6EDFD57BFFD17A6E6B7FF8E7E9239D26B86309C7FF0FA92
      305017D9C651239985D61326B7ABCD594C6EDF8CAB5681669EB988059FE73382
      6EDFE45A66426348EA1CB9DA54A12E8A745E6E2A8D9E0216A23BE913935DE064
      FFFD47C01E49C05B0892DD82AB13E73338CA70C1D80DB8628BCE5257767E7039
      889A2EAF8DFD0FFBCF9EDE6510E5077AF784378E13E1E42E55AF0EE08EDD53C1
      865DBB11F5119DF56C8FD71909797B3CE56FE55EAD3F50C724582763CFDC2733
      B5182733FCC71AE6AF96655287CE0290CEA214539D27A33AF0A685E6CDBBBD77
      E7C7511F961CD43CB1D8A8701C8F6AE0EFFA7D5D2A1A17519B274C4E769DEE03
      1A10AA9A54C1740F93A52ADD6053623F6D61A88911A21C47430D9EFBC7643CC6
      4208247AC98AD9418606297C72E707E3212E4A8A0ACB5E37082E095FD9F558B1
      173DB29B7FD3050581804CBFB186B31D904B00DE30C6717B2372CC1AC5895F75
      8932C66AD6009209994A995F26B0EAFCAC165BB1B29292A7681120974E0A333C
      B3BB507B86526AD8BFB007F8668F8284E33417808E808245D2F96276F92D1DC4
      B3F33BD01FF872F6BAABB3F028E7E5C1C185516269F0E432860DC94C5AE9E066
      98ED1BD941EED9D46784B047692B5B00301E56D48A1C78B21F955400A70F5860
      8F9525DB7A924CDF35FE89B95F64366F56909EFACFB312CDD7509EC7B4DCCC4C
      1E91563D74D9FC78B957A2D1CE9AA2BE3CAA5C95D0D4D000BCD8603216CDE29A
      C1A6B4B54EF90D942825A2E3E78C6817C208127458BABAEF08AAE3AC5832458B
      5D75253E77EC6FAA3E2AE43F7D0B08B1DB8337EBD745A83EB95ED75AA3A88B44
      5783ED2F91F724DE03145CA4907680B14567C32CFDCA444773F69FC9D6B6FF24
      3124B98C05A26CF443A4C0AB3066EC6B264229D33A6802DF6D5F5ABA10AC9A1C
      04144D8324192DCD47D99CF4861C4887C442FCE844FD8682A7F91CAD0AAE779E
      3DAF3AEEFE26C901700A08B92C9DE6D6C9D33E0602172D18315C3FEE3C7CF2F4
      FBA7519F47E576748272DED1F156537920485B97ACCDEDD16C5BEFEC577FB127
      FDAC3982C107A05E0AF1655E4F7EE0A6F60D8B35C894F65B554D1A0251AE68F5
      4A0DC0F6E1229A0DED61D0298BABE8E3C5D10F3B8DE46905BA9B4D12596BDB33
      FEB94AE520255A5708210C3C5D1CC3DC0AA5B841B86EA53CAE81902D9E247C3D
      D3ED6BF0109C29A7C27A84BF67B0E6759B625986FA7ECDF5BAFEE578A20D75DE
      8BC1CEEB63719F1F0AC85E6463D9826108B3D1757947ECE6CB1CAFBED9251997
      F1301D45DB58F32F367A02FC5A4CF0362775B347FC2B195D491F76377AC03886
      28973CE1E9464F48F2CBEC9E8F98A0D8EF3D1F019FF35E4FB84CCA29C4DBEEF1
      843249BEC8039E6DF480AB797E89C204F97D6634ADE32CBDDF8BFC239EC5F75D
      9979515E2797F7ECC84C92BAEF311A385DE7977379998DFB51CEABCABDCA938D
      1E51CDEEBDD3AAEB647CCF47D4F3F28B7BC4F395C7EBF9E11F7090761C204BFA
      64669D2A13B800CF1FD2D1A57DECB8C844A28E4C22BDA299F114881934E42F56
      278F344A3FC11256E1083E9B0EAEA4A3B926FA149E29CDF6903884938933DF56
      348586C5D7640B2833398B5228A4ADD0C15A2940A6AAA8F7516A41857F7EE52A
      BD8640158BBF006F5BA9D0252693D744CC0BF2C702404464D1E06A2DF6CD2CCC
      19CB344A493D7068B46C3BADA6E8D7D1CC0CB1CF80EC434111A15449CD6F615A
      2AD123ED06B2C367767D4F97FA4F3060BBBEF705F4B322FFE9C58B172F56A17C
      9E154AD75C04E690DCE28C6429DDE0612CE1DEE0D9518A5249426560760F7375
      C9A28D81C6AF5654F3AD7B2B9444582193C04895C2D362CE07167B5A3565D36C
      C9AE6F26AA9CBBFBE56AF4CA127ED4CC0EC4E87A873235BDA8DF3BCC7B227F62
      470DA9C37ED74EE84C85B6BF1B842562B2E6E564AFFE628FF819FA3F047AB9A9
      AB9A0C9656ED1891ABBD4E6BB26343E721B0C45DD1FA866A101D35D112C04FE9
      320780A6FBB5DBFF7F81F7F1F34E9AA70A65B8BFA4668BB3ECCDA4E1701BB3A2
      5AF80E9D5D8A92D2ADB983E5DF7647D6A4FF2CF2AE9722B8926FDA6AC2C823C6
      41F5135DE9F80BBFAA9482CE81D690F9F372840484BD95DB66126719C8C6CB7B
      84A36BAEF5D4AC3784ED75DD8A87D9E7F57C74F67CE0457AF40B18003A8A3A19
      525631F9466D003D84BA654E18EF0B874D7C51011E163D7982DECC93D4483746
      4205A6345E43789ADEA1310243EFD01FE94120D49FAA8621EF507E59FDBEFFD4
      3D1B7C4F829F6C586100E372C511A60DA5AEB0275DAFC649C55C627BD76E3AC9
      F2E5A3A5B58071041B9317939E83F2C29A0B1F8DAEA06C4402074FE216AC0353
      45580DEE42F78D0674BB4531C77B2DD2AE0CCE25B05EE7E259FC7E334A110628
      960C2896C272E4C19570AB9B09B3515FA1A165471A9837215EB5701C6F716605
      81516EA3ACB081EF324D24C4D25A766510D5A2CC16BE870EC298F282BBAC3FEC
      66C41E112670DD3A4D1A51F692EF5E803ACBA23FE745FD6753026B5883AD25D4
      280CD4C708E3120B10C335C32D4BCCCDC6A36D2DEBD2BCCC8A21CFE4E0B0E8E3
      2D66AE220AD0B9E597DA56A8EB369A85E820D2F346B36D361D7EDEB879BD28FA
      6660E2F668D6A4B1E16D716C5307C77889CC5419F8EED04E27B1A65C592C3918
      4E0C9851509A872B62CD0C5E2A9A3B8C2B10746EC203373C2B579CBBF2948198
      B6BE14B0AC582AD735613B39728382CDC171DBCD1C246C0D4DC3EC4685041A37
      CA6DCB46D5031AD70BAD485B0BDC1B7F19CD5E7DFBF6EDDBCF4CE5508D6B392E
      E4A524E1A3BFC84DF7B98E1C899D088F7139E1B61CF29BB6E12CCB6220E3013F
      7027D8FA1C6FEA309197F5DCE8C034C771F8658944D8772B7D025E60F7C767BB
      3FDFC53C72D9182B2D8C76FA46942771790B9D804E9A66622E9512D5DDBE3498
      DFED1A8993683F7C6550CAEA9F6848C0EE0F0B17BF9218C3429061F50397ACB7
      E6539FF8A7EEDF946996A5A3351ECBF0C0C2E35E7CBFBBFB24EA7FBC38DAFE61
      B59EE6120BC068776EEC9D0A589BC3951597DDCEE9EEEEABDDDDCFA1323A6852
      49F92AFA550D299D949DF38B0FC7EFDE9C7FD657BBD7E8A8B048C388A3659BD0
      24825AC5234F0790484D51B7B199F6BBF863C8597FB7743AEAD316B0C6B7EE3A
      272EB086DBAAF91E41EDF5942FE2140A2544E843776BCDCDF3E573139CB84935
      FD8C2A5C2EA9A54F6ECFABBD1F8F7E78F6FAE868EBA1DA78B021BC4BA3E7B4E0
      9457B682EAB738353846FFFEF7BFFFFDE7467A2C8EDEE01AB8F7243D79BAFC5D
      F66756DAF622A9EA9DA49ADD32889CBDB7921B75E03BD63DA65DC9BA3E57E66A
      0D955A5C09D9E24F3C83B74CAC4C4040C464CFAB51897C54C99AB4D82A683692
      0A354DC96AC7403A024D18B6D7D20DA69DDD8A78760B95048783D45B403528F8
      BC16E37FF7297CAB36A4C43B5FC04CF2FC56240BA8742C94F6D4A37EEEFD0927
      C43FCBE697695EEDD4DFEAB51E67789B2F7CAC1E699A8BE07390D5C2651B3420
      9998C11B4A2993F6EFC444952C5607A715F198BF59ABA3C12B0F5A9569A52A2E
      FED8CCA06904C259D356C2DF2AE72639385A34B74A6A455984378E3439AD0B11
      0AD2DF6101B701D92E0CFFC90EE1FB903ABEF66F9FCA6F4D43BC9A425DEFFC70
      EDDF3F93DF9F4D26E908BEFFC1C93E5EF92A2EC7B09FEC75B6C31958FBE1CF9B
      2FF69F9F3E580F79AD7FFAD088913C8F3E7D58FBD1DFCBA3F7E9611479B49FCD
      11A7D565FA30DD7F216D2C0899AFFD8097F28065C2E69DF6F1F1C4A8AF01213A
      D885A2EC2B79880185463C6ABD81B1136563B3E41A9C338698549B4E04FADBFC
      1BD50E0C6C3B59FDFE670197479A4142831268486FAC96BFAEB243668856B173
      74515D122BBE3FCC8AD197BB08CA5D1B07D739E4D1982A972B9D8F851F480977
      CB6175C8817E0F1E6CF3488B5D120730665675777FD3A983763968B152096110
      F5465A6B7E6767872F2E2A9C553A4D21E0E74A91555BB708B2EBFDB786841BAE
      3F412662AFC3288B41E7084ADDAE60DFC2B258A7EC82D44345DD15D562C75D76
      2669B92AA62A68290A026B750663497BB1A7A048CDD6C0EDB481CF8EEC5B3D73
      DDBC5B03B12CB425A120875323241B4DEA7D8F4CB36F2BCF6D637A8689C490EF
      6759595784066127560721104147759DB232B246F5BEB25BC54A8193EB476789
      7FFE9FFF81A3F525D956E4ED7FFE473CD9183C6A02A90964E3565E977EDDDA2B
      C9F6B38DADCF69A6A407C9EEFC3BCDA1F6CAB0F82ABBFBEBCEE7501FF2D7BF7F
      EE0EC841119E97B245882958AA791FC480C6920023D9D9AD5EDE49E56EBF2EB3
      EF549B0C2F276F4436ADC465557A470F34865E97940A245A23CAB97CE3B35F56
      575E76A7476FBFBDE3072C4883C893433D84136EFB31A80A69C8BF8F3748EE83
      60F487E7A78FDD2651CEB384D611505F69ADACD1D1B0D4953F2F99893085C4E4
      2278D8558688CE449C458F549FBEC8B947BD9C14D20EB1602972864E8D654647
      98D1479D385E58BC66C3E72FA8FB6BEC56D25651086C85F8216D51AFB76FA552
      D89A45BCAF926C1C8DB17BD07E63C5CAF614716CEFF8C9D131C0FF8A40B37815
      7D646856F54D966C6928C9BD3390B13B282A1D3183D9951748C6D1CEE555810C
      C5D5F92FFA4D8F08998D0D3AEB8DE09D7D0DE9E9318D8C3FC989247F93616BD3
      39D06411976FA88FF709F12B0CA65809B5DA00A914411785432FCB3AFC18900F
      5505BA0FD543790F13AD4327E55890277E3CF6EE13C53AD77883CED2F4E1B55F
      90F17D5A8C55A37BBDDC24FD32CCB26892482D2F4D97D695EE546B959253E0CA
      4EA71AEAC4D72E0B3ADC9AFC53D718587C12DEDDB3B8EA76DF681A5A3DCBBA40
      A14E09AA5CC5F34C10FF85771B78EB4953BFF5151A9562041016FA920C182602
      491D975AD595993B1A8418F0F6B61CB2699CC70C78B9B6575454B2EFC9882A63
      BA464F641039B69625D4870D7C0DD6687EB9E5F0295E6A4E565C8D0C15C1734A
      B65C5F245C9855E232B2C27AA1B89B19B170A94534DDB7A8CC7BA5442A4DE9A8
      826770AFF92429B0A3D3513AA3AE32E37AA2DD05CD133951C46C6C09D23A3513
      9C8C6ACEA18C8FE0315782EBCF67EB0E29832A5232CF18243A789E56A2A66351
      A697292E127560643057345425C8A454860F8D1A44B9AD18792020A0E53799CA
      AC7556E52841FA75EB5D75E28637C1F29564501C003016A7B3FA66A924BA667E
      43F85F8C7494A2A4849F6AFDBABEF57682BBC5B2E54C318382106EABC0CDC34E
      9916422102498A793E8437AC20C593DDDD475C8753E8636B5918E3E33BF3C88F
      0D17A5AB9567F59804408BEBB04157F7222C4ED2F562A246147F814F5BCB2123
      85C4E97516AA1EDC4298064EED5ABC2E588C3A51CC8197F2A9CD09965B738265
      032127E8005B193DF4DF4F1F1490889F63E3E0E469CDF9FA8130754E65797B93
      44EE8C958619B14A0FE6D26A277A68E79C5536BAB5091784D161F69F4A690775
      3AD5FBD647D115587812C60E97C11497590178AC72A7F14ACFCAB7EBF812DE25
      1D4455E10AE48D53D5189272134A4819A75FD331CC86C624A9DB9A520772B502
      36DC0E46AF752D069E1B95EF018C247105FD33D6868E7D12A835BBEA8091B44B
      42065ACE2EC86637972614AE5F7F291D524FE7F181680EF0C11F126E083726AB
      63F88BA5531BB28E9C602B4D0AC92B6D0CCC14A99BEDDA1A843770EC2B27E2DD
      4BF68BAF9F8553A6C8BC98456ECDB64198BB2A740BF6175EE1EBA116509C1250
      B8B06320B09764743E1EAFA6C851CA43880EDEDF7EEAA0B6065EB7345BDD3114
      C3FA80BDFD66977676767A8DFA94756B42A9828C25C647D0EF3D0D5408965C3F
      A6BDA91253748FA5D1D6A9322AF24AAF108D98984718AAD73A4C0CC94D331896
      CE50764F828954740B39092E0785120CAA54D52B0ACAC968C2BB536A15ADB31A
      9485AA8E9E39711AB398FA6A1C7C87E930E38B697ECBF742B370F0D7859D1177
      CFCA20309218C0F325976047B4A7C689B236B760208A2A13E3269D33C46522A6
      85C19E0B4735B85DB6FB1CF043BB1499E6E9705E3BD68AAF69A67780891BB353
      14B6E086B1E359F0134F4AD1077B052A9F6707003258453BD11ECD1D5CC72974
      F42E1BF0865B3DCDA56799A6616D8B252BCA7D4F38F5EB1F1EADE7AC5A98ED66
      7D156EE3DD35868515B083C4C3B5AE11D80C2D0452F8FEE1223ACE510C6E2DC0
      519F21929CF3198E09820FED35197D17ED8BE0FF475400D47F1FC078E86A66FF
      C37EAB9FD4B1340E58D0C8F9553AA9BF939E1B8D3936BC5C5474E528E15146A3
      4FBF9C4E247A21A3E8EC59364DE060E963567A034DEC0F68E1877D7B95710203
      AB39E807FC6C150211C659D8C345255C1B9E20B412687CF9B49286208AE047D4
      5C0E46A392460692637B9DAAEBE8472308794A50F33A463285290C75C31DF1E8
      AA492FF16A36401C37D4DA7528E036938B6DB1437633D069163B042E9EE266DA
      63173E709B515033B2E036D40390C8CD76642489A6CE19AB5671101ACEFA666D
      9D17F372842CBFBDF619DC6E4C6E64870678F8A0C999D418870C827AA3A2321F
      8C6D30AEFAB2C23E0D48C06C5A7B673D597E60ADFBAA47453994FE6C636384EF
      E62287029C85A84A9ADF6326451A343A39932601C4E9AB077B2DDC4FA100AF1F
      530DAA3A9AF4C278B4EC48971463E31C40F1C2806788EC96EDF2F229DEE9E5D3
      F09D927C1C57577C272DDCBDDDE6163425011DF038053657C22E8AB36C67A316
      D33C7A8D282C6A7D620D1679958CE68DC8A7AE41D827083D50513E965FED447B
      F98D8BA8B82819E3BAED41571A3B9C6C5B19EAF72E3E89E6C3AD4F3219BD5B1E
      446941678ABB8258F228A718CCFACB3732BEAB2D7F9C807624486100DE1734DF
      D4BE11468ABB4128CFCCEB0DB46840FE2AAECDAFBA7DCDD2A5DD629B3A6E4DF0
      0C921C5038248DCCC6E73205A125665CADBD6ECDB6A4F94791214E29BCE0A4DC
      EC707FDFB073DFA99DAB6C1B6717B8CB57A032CDFC0A4519C2D3BDFD377D481F
      DA889547D65B51C7757BCC8EBA8B9F3817A36C37B6FBB539EA15CD6E887C88B4
      849ACC593A1B16ACF7E1EC7F9E353487F5FCD0EFBE23D56C55E9A6A596F2A2C9
      CB40E4609923E0045A7C9076C119B8CD380D6AB440945F527FA6C59845233583
      B5711806D6FF1AFA9A7C3543478246E1F3B6018DC0E37532978DE86C5DA69797
      8CCD9B639027D700F76869B987D37669AA758A2EDAB2307A87B7D01A864EA0A1
      FD5D8E778BB2D6C879F046E1921433F7B03564C6B8B92DB12DF0FC807786C6A9
      1B1E8D41AF3CF084C421AC7B21315A5286113872E6B35C2559B78B7306807961
      80BC8AEFAD6323DF91C415DA824D11FD55FE90823BB48E9637AF72DAC344C260
      30D56F33C7358555237DA261D3906B5F6AC874427C1A985A0BC8DA8305853D54
      790804B3EB67156E1270BAA8C7C8D42D48528BA5BFAC54FD6A85C505F6910ADC
      4AE19BDBF16935CA30B056DC4EEF056F11DAD1C905D13E04E1D588766123C8D7
      04F4EF92AA9D25BFCF1488EF18F4E9779F85065EE107DE7690039272238379F4
      72D92921C62CDDE22541ECDB87949454F3D61F6634F3A82744577ACD69FEC78E
      6A08C92D2CF3F635BCEAE20D6386F595E5FAE585E001A5238A85D0DCFE87FD35
      AE5815A85BB202DCB0B8EE055115EBE02D0DA3CFE1EA588D07AF63E85C15051B
      1363A311E311516CAD37A57D22AAE20C0207AA18BD2B6449DC8D6C811797714A
      C62B556B5BDF6FAE2E5CA908B05F0710A1C74EFC95E246CB0087B85A7C72FFDB
      D61DA47FE79089683FA3B73E73EA9607086247EDE36D7F52F84CC25FBF7DB697
      E8A6517DBF13ED2BC626E1253A4D9688CE2B5714422AE8E2C94ACEA3A7AB796C
      B7F78DD7874BBBF1F3D052B35F1A9B9160CCC2688487CC2D36E9C051201A379B
      354A1F146F2EC98C41CC211EAEF1B242E356EC7EF12529D2AB85230D555DF21A
      549E26CD043EACB3A6AD9AE6B228C9D2516292AE38F37729BC60B93C428AFED5
      94B53F7B1FC40F586FD58E14FAE2B25FFAD9EABBC86BD7A5D008FD043CECB5C9
      D7961E4C26853995DC4050C45F9C06144ED94179D032A9E7A5A481497A31ECE1
      CA2531393B28AEA271195FBA5C7DD9312E0BA851C04FED2715614CB2CC2D783E
      AA4425BE70F9D93528771D99145ABDD078A0B3B21866281FE63C191BE015983B
      AB77709ABC887AD77CB5C1730E8C9A2BAAC94E7A49C7CC93D41630230D19954A
      745F93CC51706D41E86D67BC0078F1A1FC3BAF3F63E9DF65B1DB11E7C4A04C6E
      6AB5788C813B4E52010572844E600FB3B25D18A0C679C4AF494E9B1522EC6AF0
      AD1264255A436C642FD3788DA31C29D74DCE0B983E16BAAF0868A5A264EDFAE6
      01027666558D5CB5824671A5177FC8600A74B45CAE0B483212DC329696FBA208
      AA697D46218B989C9260B477B85949D116828A2218ABE278CB651E42AA999A2F
      34BB82E74B891663BE35585C226F16F0EDF58BAA23369D1525B4631DFFF53A16
      AF128A2BC65204220D623B0D27966712A71B3FA2B49A32FBEC78410C02C1CD64
      5A9437567A6E995A6A7308B63964077C2394A3A85A65B3408F2C2CE5ACEFFEF5
      930A29337A3F88DCE7E36C540DA2FDFD6AAB014323694C00D725FDBB53F75EC5
      484C1B0C91413818214B36E8B063C53550C135BA20E03303C4A88FA852CBFEB5
      961BCA5D053ACF81387CCCA588CFDB34AF7B519950BFACF287748F861CDEABA7
      B6DD4AA362D983B154D4AA6E95F3EDA34EA9ABF5C21C50ABE2AC103330D4B93E
      CD18AAD4BD158BE5C9AE55B789E208F22B05EA86A2BA95DBD9E2A8CC73F94D12
      358B8DC2EEA8FC22D596146E035FADB8563E333019BFE9F49BDD716D43E7C90C
      41A73CAB53B604F868A480B7194CEB3FF7D7BF2373C63781B459AB55A78CEC27
      DF5BC11EDDC1292A2A54585FA8110B0B14693274E7D0BFBC28FE95B81FBB11BE
      E345050F4A0C490BEFF8F2B345BE58A274E1A6EFB51ED37F5D64E32DFB6D4F17
      513B36DED7C524749472BE42D9EFD67C0B3D128DD7AAE185E9EDEFA4C9CF4A73
      6534C6B8AA0886A1EF77A859AA385E9A372DAAB51397969963A29687F78BB161
      8417B92DA2852A1C89373A06ED1D29714ED15DE2C35B83E8282B62F0849117C7
      01A0AABC7C20757679D7BA67099191691C2ACCB62AFF05C7872DED659D531D7B
      D1A041183A1A97C54CE828D8C96424CF0AA616C4990551FB09DD1A1A335AFD34
      B0C9AFE6974890E83B8392C13BE136C797795ACFC7C9161C23D8077798435919
      8633A2DD55FEC7929F447D15F91CDE2C9DE126F58BF66020F8BFA5738E9C932A
      922C36687908298636C5B04CE22FCAACB492B7B4D98EC41C8E4B5F1D006ECEDD
      4A08D18AA8934E5AD41E67C0172C8219628C76CB8390A784C6FCE82A4D569DC0
      3DE9428B3AEEEA8A9F14555256BDD03B93D441C0179D3FAD24E5D6E4E81AD90A
      BF8E6AFB1A1AA8C415F57F3C6645C2519C5D14A7B44FFE96E695FD6210F95FE3
      F3F0BFE5692B11DB67CDBE13D00CEA35878E91DD660C13E1F4E4BE5A7C40D477
      6E912F37B815385934502AD5C508A22F9A68E0722DDC0F06A6D148BB550A0A36
      9BE0EDDF28FC6D8B5C23FE6A6D627ADC65AF7A3521219542145E354E7F51CCEB
      11EAA21B13282FC6B754816C372FA79DDC945218C87258E4194E8FC32A5DA028
      CA234442799A7A9648D3A1F4B92EF605C9A6084A4A8CCBD8FB646EB7042FA5C2
      32AA632645337C6A887E89418E2C899155A1D24418A246C908FE4ABA6F5477E4
      81A84BE0660EE13A936F75FE199FBD625FAAB68D9F3D9DB7C1AD4CE3B48A7A13
      5064A8E1D78BFA2AC7E1B6AE0AFB226F29284E6D5E91CE8D1D636E2A8DE75B00
      31AF07C1DC3BBAA8162683D46430D49010769DB6C8B1CF90B78587929852C5A5
      2EE7A37A0E992F3363FB44BC34E7262CC04C0053FC284FF1D576AD066A6BA1C7
      328964D3D3D4ADEAA2E09DC1648B39CE3903D7A20B9F760582C01CF1614498CC
      6E36CC99A268BA9B97CD09A4266351FDA605259D6D4C2B8DA9D54B41CF9B6085
      EEEB0AA5F7907C037708231D240F88A721272867E0248927554F66A3F7D739EE
      487EC58E4FC1C8E45C69C01B0622AF3C597BAF6FA2D771957CE044F594CA4CB7
      6C587CF38AC43CCE2C5E1E20AC82C2B8DA34430A1C7A0CB6FF932848ABA0F7FE
      E1C9096610797E567358BEBAB5CEE66A75CE93C207D17783685BC6E9CF1032AE
      DA49798ACA443D8117015BF406EEBFDE157962C37C9C7F8521E12243BDD5C9B5
      92C3121454B563DFCA89CB223017D1A2BCB6C72CB724D8A9A609CB4890E58D68
      4C897A3CB11161B43CA3A5E1EB7439960BE939FCA23AA1AEE2DAD8B5DB62AA10
      38F2116669F12E9E523CBA522C79CD928A61F0D00DA29119BA3371AB040680C1
      7CC384372010147B609CADA909124A785BD9EA256FE2124CB586A153C41ADE48
      3F5780BDC66A05FB918C3B44167AAEA91E61424BD796425A030F31C6A895525D
      0914E470660367C34C40B9D143104671FDAA90CB4190EFBA4C475F50EDAD12E1
      09E767E0B22CA8CE29EE5E9DA05AA2B509B1E2D5C9A567B2BF978DA29B662B49
      BC585FDC9F9CEE118FE7B97F9C9D31FEED047D583415D7C2E1F7556F5CA42B2D
      917379EF5DBD49AC4786ACA566F75CD272279DD5BB4D333E9612E05025831A32
      AD1C44495C1854EADB23AC100F79B6222F5F145FEEEE76F7F45A81144DC5420F
      BD40D5AE338CB458FE92A0AC1CAC933281A769E9E3612BC1F167EDEC44AF3595
      DB127379FF1704264EF7CE2FA26A3E7433EB50DFC0F8D038259F4BB7173A9456
      71CD315845955CAE701E6E107095B885AADC19E3639E4BBD2EE02C981EAE21DC
      A089D837A0F7A6799433A7738BE33F4B0A29744B6A94136640698E6466B64A9C
      9B3695F8FD5A050E73EAEA66865541D728DFE94F775F4BDAAC1E58B20AC29B31
      56178DD9B00C2F59E59AA31F8F91D1A91961E0BF58F98224EAED8DC7FA803056
      7847D6C8B24639E149BB5D126D2B5162B0EA942E155F2D0FA9C4E76C07979F65
      0FCAA37FCE93CA15F875AF42D36BBD97E9B69848A8F0F10E5BF546160D173F13
      36ADB20369C7763137E25544DBE587FC9D4422729F4D5E17D1F6F12F7971FDB7
      ABB83E9E1E14697EB913BD0715482B60BA82130DC96C9C521AEA5295224D5CCB
      99B7E64CB67111A15841748D27F02FA856CA56EE5A30585043595674C5AA82D7
      96DC46E6A1995A5237CAE1171F8F7051ED5288CFA76407041E9CCEDDC8C939CA
      D0B845B0142109BF12F5B92A9159B478C16EF5DC9A65CEB7AD283210F0A6DD4C
      F9F68A5CDA99C677604A7FD08D438F8896ADFEF19EBD41BED1B3004551835003
      BCD114C53427DE2BC17AE367E492486C478BAD4A3D0FA479FABD9B25381D1507
      54A7214F12C52186FE70C45226B1692C1AF726BD194ADFA42C3D8B6B5E82FB6A
      CB6EE9A78D22A0866C6FA0C4249E5828FB0A70B89B6DA181FC5B7E69607C8B04
      B486DC01B27FCCEF1434E1F0FC942A70B2AF7CD915C9BDF0B269822EF3200DA0
      827B95067F4F8BF44332897E7D7FF2EF1F5EEDF2FF9E3CFF8C0137E8C1676E79
      D9CE6F9DA111FFD8BE666ED98359869B88EF92C7E375C2265C0E44100816142D
      48F8530583380B94306531F985B8AA765228CE111AAD7509DF09DDFA6097D418
      A2336D0782B3BAD482EE18FBB7D6DD9DB1A05849651B66959BBFECA741E44F77
      1D617489C3369854EAA80A819BF2C1D36142203130B9926F2B9240172CFC4655
      A4715CC776CD87D57393B07E401CFDF65F6FE269828491DFFE7BC7BF95A528F2
      F5864947A73AC6F7229DAD3DA0FCAE224AED72264B07B6E6E10CA7DA948ACC4E
      9BC6E86CB186F7E81AF687AB29B85966048D4CEE793C0D5F8684B030401627EF
      EE63649CA27D97DE53E4CB4E944E4F4B528B6E67CE6992279B32F38C3156AB54
      0B7EB1240FDA670E7251D4BB9584D4EDF9299DE7BBFD56C3BE0C839C0FDAD633
      D60F41EBEB8FDBAF9F92F2E673B404C3AB36233A35FBE759349D62E8DBFF44FB
      58B65EC4685B51A620B16AB92E661361747415A9B3019D234D1C218AB634D4E4
      058EA00A413E04CC79189FE4792B9FEFA9D34EF555B30C7F34C404A9D0BAE73B
      5F1871DAA52F6DB11CE2C182252DBE605873852CE4864C7DA0F5EDA09690DCDA
      C8EA0B503A13FE4B2722819856A27ED860936D0D1AD83C5D3FAA8039AE45830E
      64142F3BB25B154D02A90F4BB912F556EBB715AF21C42AAA711A51ACEAB89E57
      6B2F7459E1BF8266F35920EF3F7C7DD3D170EB3A9029B62A6281CE40A871BA20
      E71A96F2581A6C5AE4395B75090BC22DE829E450C3E716F9988B9C02FFCB148C
      9CD9A0E1D89EDAFC3D1762F57E7DCF133AD1530B29DCD6F6CEEA91C3BBD8E82D
      D920F4A5654F0FA28F071F06E6911C5F9CF6A22AF9E79C883E4D9B99D85BCF44
      BBBF7D7A2815C579FA3255C0DA10D215F8ADA94CD67B7D767EFEF8E4ECECC205
      52A20F09B0D7463CA5F325656D8A5B25819326477D5EE6B8642651EF9CB29F91
      4445AA1E5DC12477E804691AF0E81D69DED935C717A7ED82B5A2BA4C95ABDE71
      04573E822F1F1D3F9A4674E7358C83460CCF31D249741D97144A5C012B231C86
      51172C5A628472ACDB601DC4D728E3538EC9E663AE8DBB51AB620E5185B4CC01
      50656366644BDA9FF3E23413DC4E1E0DD36103E4A0AF456955CD5D6179134B0F
      40FC673B4F779E68E2B743349750E317109749FACDBCA06A9E18A2A25E01BC3D
      53F509EE1F4414C3EC114772D240BB51A1BCBCD4E2B9654A434549A489A11347
      8D32CFD534D8644D938B1D705025980E7A3C5122DD42A8B7A841F52693607519
      85661438ECB9AC6A0711CECA623C1F11944C273C52245389B78147CC3171D338
      873F3D4DEAAB628CCBC9295DBB48BB1E7D18D9E0CF01D7FCE381942B5068EFF8
      E2F40ECC30949479943F3A00EB8975158B8693B7365BEC780941CC220BED08CF
      ADC665A37500AD6142816A6151E6BB717E01B4616532B007CC32A5B19F33CEB2
      FE609C42E500977C598F702F4381FADFE6D3597451B8F2CC6B8F88291889F0F7
      32FE9CBE914E25D5BC5C6B961779573FF55DFC15B5C9AEA09DEC60C1BB166F19
      203415F3BA4EC6AE461BFE098E17D85DEACE044661F24F2C64CB3636BDCB3053
      D63D534FEE30E5C3B94FB9F6DF573D91D3589B462A12E341E3E49B0F3D083D92
      6A92BADF76A2FE078B132D5C28727EE0C641207632D9D942AA27DAD9FF851811
      975B3C4C195DAAAEE693094BFEC4A27A29E746A077D24AD76875B65525B74C48
      E1C1E9AEC2D341CCA0F173AB55AADCA0CB9C157D189D4A73F0490461CF839BF0
      DDDEA753B905B978BC8527B2B983E812500C71E9F1DC5505F4E6E6BC9CE0F241
      42A0D06EA8C67AE7E23F0329F158A6A8AD504C10BBAAD3918E90AE025E5F44E5
      C37AA5F866F22D1A1545394E73F24A83333DF886569AECEAD987C518A0470774
      7B0830CF88515C8E05C86BC498B9F26D51AE88142D8F678BC76DA7C045731370
      48386BFD61518318A9FBA0B5591AF2D2C1460C0654B6EA169AFC074E1117C073
      8433FD5E10A91988A81999437C5365B3DE019334F4E56A5E9335ABFE045FA49C
      43347E0D98D5E9B10642A58E0C29E14C97228C5F2055C4B332D88341F0216283
      F2BC502CAD456F47BA55995E5E01CD287358D5EE02779D5720439EEB328BB5BD
      06CEA972325AF53E89CE7E81D55EB7491510515C4DB6C945BC21BA02A73E7785
      5B2CFF4683D6C1A80F3A3A2A0A566E3696D848B886D37C7EA7A8934B19AC0BC4
      88D6C8840CBFEEA324186ED6540318172A39BD3DBE383DAC0C92D60F993D7E7C
      10BD3DBE84C37C01834A037F8772086F45C3046A53AB36AA9B6B2B1AA1BE05C3
      FC4C08E9F3D88E4765514189A05AA2E7D33D4022CC394EB23A162968B1FD560D
      D75ED40B7E4307CB898D28462BAB40937F1A84301E70B67386497D4D2EE375E1
      E903507A17BB681DD79447DA402B4F06F568E129959282D53B4DC09B27BCAABE
      F10EA85908674AE4A8DD7CE8F707B6B27FE9C182F6EC621BC64E952CB0D29989
      E1783B1E95A096A6F5DFD46C6A498DE32F4FF3F1F22F774399BEA870D8096192
      04C2D6F25AAD1D6162A421DF0C0E42D00D376E4250B2A9E85C687EA3C5D597A0
      104B52B65F90665830316D852B319A8CC61A34B6D64EE37C32468A40C3ECC6D1
      161A5D71F3C58084ECC341B00C828C790224525A6FCE3BD12913F57F8A0EB981
      CF476581D46251E6A04A87FF16770B8A22BE49465F107AA96521CAFD1FBC1EF4
      7957FA85A36246E049EA47DBFB7A29B8E01538CCE2EEC5D59255408E050D1797
      5F695A46CDE5D002D0C0D0315140C442ED9B4EAF56BAE8849D03FD4555166D34
      6E149DD4415FFDD64B9486CB1E5F9CFAB20C5BFED4C1A2B92E9AA59C98702BC2
      AFCE075F772D71A419D0160BBDB1C9703BDCE548BC5A3C97D6DCE662E5A189E9
      54B21CD8CCC2D95329A31323AE86B824B82A3664A7C58AB8D389B3CDDA776878
      590583AB2590D6BABFDA94C140CF0E12E2C8DCADE39C846F3DBA5BAF2849010D
      2DACE6ED223F050A24D7B4B386343CD79DBD058267255ACF9CC6D362BCC7013D
      2DC6AF1578177592FA3DBAB4F77A47BE7359D42E00886FE109D77813921B2F81
      250211421420FCB593285CA7777AEE36C7245C60D8B0DC9AC17614859D3DBDE1
      CA44A296B23E4C9AFF957EE500CF959E91AAFE7AD07AD7F59C11AD2010FA2497
      386659C8ADB15FD23C6CD3A5201AFFAB637F3598D37A5ED9F8B75EDD10D9843A
      23DBC39B6D1731E609272976A2A124E32403D8FADCEE28FF796B1DFC0DBE3653
      D5358288A5D73E07DC826A8C350F51E5B8A8300C9028B8A978204FAE70A0E0E5
      AD3D31DDF77528D5EEF8F3F3924E01D3BF35AD1AF009133BE4DCC45FFA9A365F
      CC6B8EA82EAAF669B3B5A4720EA96EAEB6BD0345F1D8D5473222003E1F725E25
      9379C69A3D31B6BEC41A5D5844B46C83E72B2662FA9F26E3D47857B5FE3D9A1A
      A8841A73CE8C22AD49485E5E71991000040B84336F1758EBE91C4A37905A8B28
      1C1F3DDF05C662EA8E3EDAC7CB9A8316F54F63C7FE13E7CC0AC20606B81EA361
      82BA0F930627499504EFEEAACA18974B4D332B11B4B37E296C339E26ACB6E6E9
      F40137D69B4C9DD2927890A5FAB8C7E0C98D4784C54C07400CD3AF71C6884BC1
      615BA70949656A5B72EDA2D9D01EC6327081202B85E09843D53C152CD1885A90
      56FED2D896CD5A02789C5B64A148B3DAAC0CCCAC3DF4AF090E10F463698AB749
      361B44EF926FF3EAB4400EF49BB47E3B1F0E109CC4614B89DEF7715D2670FFE3
      CB6E1D097BFA6DB9872DE8C3DDFA88DC5CA7F918516EE9D86692BB781B88977B
      F54D0EF31296CDBA4F7423A3AAD3FEBF3118FEE9A83A054CCB151A8E6B5E0212
      B047A4CFEB8D38B2BF15858AABCD3A2773156DCB9DE34A53B0668FC00A352296
      6388FB1433A6640797A2F5DB037C124B9498DB865DD265A3A325EF6C9F5549F9
      15A7E28724CEB6799C8D98ED481B9A07937C5FD2FC703B6ACF41088E0E41EB40
      A805E65F9221E967B32EDA6ADE8E0EB32951A972EFE3A3AAB1CA8365836A49A5
      9D2E92335315D99CC50801AC4986BE8F1517F925E2BBD164CE1283E1E0DBA0AF
      BF5D55DD910C8DB585266559AC995BD00C871BFDD7F2EE963AEEF91A2DB86CDF
      30E2E16FADDE0119BEBE115DCA62BB19717665169E99F38D4A5283B6864A5303
      DA4BA8689B8A979A06D55D6A9AE959F07B0EF55A8DDC75B4FD29F6870EB86FB6
      7BCC17DA756727B014B897D3342FFC30F59928FE7C6777E7DB207ABEF314FFB3
      B3B3038B53AB2F558E686416A140733C85FA26A89F9AA1AE123EFAAE8E1FE556
      BE60DB2C3C1C24DE0A83BD350D2EE1443341EF00E5DA81542653041ECBC62077
      43B96D0D2197187A955E5E65BC82D1276B41A663D52C90C7201347D9AC945A48
      3A9E6C499106B7F020852962480EF9A69BAB245A161E9475CFA4EBD599CBA0CF
      D04A2AB17A50BF272F4AC7B36FE5FF5AD136D7BD3440876719E2569C201B053C
      CF8257E3025140FED9AF5A58EB49398D73B9BEDBCFEFECBE26EF58E4DA2E14AF
      21175C143BD1915C1EB2008963A8E18954904A957E606FBAFE26B304EA35B2D6
      44CE0F9116BDB61CE8352D24070F28D23C4FEB9BBBD0804971B84EC7A8DB0ECA
      EDAAE95AFC45D4970DC67183B6E6325DCD05D1493326AD48EE2A65FD2CD3A6D5
      128D715EA4D3F954BB524CA2AB3853FC5963B0FAA706D953B76C77634E46D352
      AB95A4B099057B6EDD918A40468AB5AC36AB76BE4EAF9BC3EF0A53A995EAD43F
      88AE4832BB08DB4A62269D7CEFFD09F4B2D12B1DA54CBD5793B04E513559E932
      FD90D6BDE593BD9AAF67A11FB809AE7608DD7F703F64236A35B771144F299DED
      C7CED211D9609542126C81C06983A2B40F754508B7E2179BBFF705D6B6BCB85B
      7A427DF064E7E55D216028A21FDC20DE6B70621F79548DCA24C91B6FC8666411
      3A20B2D182308E19A35888BCDEE5D5CEA74010B781400D419950AFC2BD353919
      32F53BBFFB00E8EDC46ADABEA1601550ED255172F7284BA56442D0A186CE71BE
      F0538DC977AD5EAA9997054F75249401DAB82AE7F9175475750A2EF650BC5B90
      49D3D5A5879BDFCE4C2374252F3C2B87CC3F966C2E8BEB95677D6FC5EFDB97B4
      94511D3F76C65343B0A05B88780D2A03A3C69B1DC1C7A85D28C5E145E3D6CB37
      485ED938AD28D200863862B8D0E0559A80D3E4C281272C7ABCC1EB244F2F73FF
      D702015718FA98C6FBD45063953DEC1AA3B9DFDA5743D525355EAA3A6BE7B706
      C13CB14BF25B2DA1A6C48D8D3BB8A0E21E6436AE397EA7266907033B5C632B07
      7275E6272DC5248B351195993FCC476AEC2317B7B863DE5343511EB52FC2763E
      B976962544F91C1263EA0D6F68514FAB64D4BB4D595EE7EEFBDDD500BAF2CEE5
      4C645F44F48B863D993F22858434E025232191FAC57E8B3736BC89AE5440997B
      5A8A68065537BF243714D8E5D83B350FF1B874D34B9F0CC277364E3C652E1DBE
      942E609FAD489E2A4D43A3B98876CD64975776BA10849A5035CE384A4D5D0253
      EEB2F3D68941DA6E93B161449643B349F2F15E861322C6FF97B2D66519DF38EE
      F9FA550B563DA8B322018446D73D5C07108F55C01D4D543AF1FB452E2A06D596
      2F4D81DEACB4DAD3CB9C301901FDDA8404FE57E78F0412F81683693B70994D0C
      8C703C804DE82CF1880993A2504D990502B4DA5B679AD15E14BD8EA2D79DE877
      14ED47D15E67ECB6EB8F5A85C486C1863954014197D7EDF08AAEAE7A9BEEF788
      BA5F05EC5C5915B4A7D25298337DE3408666D44F8DE44E5D34F4DBFAB2BEB670
      66F4750D6D6948414D7559DD54E7E752248976D962EBD8849AB1886DCD13E762
      8D73FD2C942D8D87834063AE6149A2FA95E5B20F638DDB9978E31AEEE531326B
      9648240D6FA4825E9C8F1FA3DF081AAFAED3182416D26CF802F19A4033D2C4DE
      34C741D205312E12ED6E040B645A71B3E30AA1990E235FE45EE8B015C5CAD466
      191ED859EE2E669F78655CA5D9B84CF241849787808E44DFA5494800E9C7B809
      E425A8DC112469AC22645E14A6A94951390F5C7D496E24D3795E6D684522B7F8
      1D96E3FFE500DA7CE91420CD6BB3C7D6D9779FEC899CF57B3FD2C9E982BEFDCA
      F574FB675B5CDB3FFBC6B67F6E4AF56ED4625051FB95D81CD6E82DEF85DEDDDE
      EC1A2A355A00446699BC5F25B8359EDA7D9E12243EC52EFF387B8CBE477D7828
      5B28114EAEBDD50CD73FDA1A2298EC16185D404A23C13FACE39BB0D8293AAA37
      F51AD5A2A097E3BAA005C26F6F15D53B44965161363947ADB9E53184208860F6
      C5111F1956977409723A9EBD65EAE5527756F312D5BE5303DC51F79963310E4D
      47E64A8B152AFE21DED95E768D21A2AAF6AA81C09766B78EFC6A44B402304BD1
      30A4B567F13091C2321D2B76F16C0E7EDAF7F109BB1397AA644B50897849339B
      C5A002E1DB38DCC4528C381677E5D79449967C05930D0C9B00F2691B2D79B01E
      A403F5CD4CA9A2D8E10254533BDFD1A8885443C451A2C0779F07D545867621AB
      76E37C448E81262D2A07D549CC495A43EFD78324997D16798B405BE031AC69D0
      2B5631E6690C070991F1C223FB8D67AAEAA97BB62F9E231CC716051636B0C3F7
      1B2A297150B38709B06A7AABD8AAC24A71F4B70F2707B488A20F87471FFCE7F8
      D69625497AC1E4C0026062B166D2E28E5E184B2ECF9DBB29085AF85B033402B4
      CA7960AA30723054CB5A0C327B6596BBD3C370AB8888AD650F73BB988767803A
      E261E048B81E18B8689415A9112FA566DC2683E0960A066CA9BCD0B22E75A57C
      FAC40279D00A33C50239BD69FB879E6B1F67697D13F5453DD3E473E8554BC684
      854B31C76541AEDCFE2F5BA4BF61792E53546706233663327EB57E0ACA71FE0F
      28E52185A60ABBBA6A4375FE708D8A65CAD1822DD8217CA51E4620A6AEF2538A
      18A35C51AB1E9E947A2EDCEAE16D85AE06EBB2FF935B43A12007DC51A77AD854
      B112DA3E8DE0FFD7DCB736B78D245B7EDF88FD0F35DC8D35354D5196AD76BBD5
      7766424FB76EEB35A26CF7DDEE8E099004258C49800D80963531FBDF37CEC9CC
      4281A21E063437A63F74581209140A5559F938794E09E49F6AED822B085D88AC
      C1E8D0E6793C49EE881F2E85249A4B409FE672D4000D46D35F070A478EDF211E
      E1685F0E1C989B8AEB4EED340C7E288DAD121A6642557164B504D88A23854916
      DCC83311DEC665D5975DCD7A8DE351882888C1ABAC950A8E96F1C348D18F42A5
      B02DF14F4D43FBF4ECD2149F4049536352D27868A660B52A2AD2F7213F2546B5
      8696CDAF68D1D25362B474F0B8AE40A13EC7B9D2075467C583DBE6EEF73A5577
      6F98E8B2EE17611ABE771CFE807A1289EE69D01604A2B1DA24E365DBC030CF55
      77499895F120D7DAF4AAF17D0A2C61E5147C8ED07A2A8CAF240C97CACEDD31D4
      6EA78D34CA1DBE9A739B29E311A7AAC6FB5BB16ADB482091C8B567BA70C0585F
      25D64B32BACE12697CEEFC17F821A4075869604E33FF8BA7CC81FA3E5505E06E
      AB8D4DC1CA870A61228F3C9D1EC9746F8CE9A236834CE6EBD7EE0E83091D7CFE
      E117118AE531367A82C32F6699F8BBE543A4C7AEDC9ABB86F5FF55DB70956AA2
      5290049D7292A75852919E845E83298AC893EA6BA9BEA04479BA69A6D3E58952
      51AF8A5047AE23830818A1EE4EBD4DA5D4D43FA847B0A71E813838757F229B80
      9E00B348CF23520AAC70667D4D6FB600E4F42B526FD25BA4473EDA6DB1E00F06
      C79DA793C78364AFB87370F315FA03EECFEE7F1F1E1E4ADF4E096540894C2B17
      802257245A0F8EC5FFF813BF46866E1A854904D5B110365F669883F4B6267CA1
      ABF8093D5DFF96A7D385F16DFB779267B3C79BADB5A0A4E2D79548A33D55711D
      8115039BC07B954108F9B0EF477B78DF5AF9F79CE287E9762B09BD48C42DB073
      D9EDEC5D4A726F9082DC344F42EB257659DED457D5F9DF91EB5EC86303214E4C
      E6D9E9CE89CF8E3DF434EB87C99773D88EA204FBD7C6FA6956FF0DDED7BAE4D5
      7151F980FD14DED6185D84819F0090C0CBF78C01CC7160CE67D286ADB8683663
      CD0E0627C9E4EB806CD3682EBEF1A9B1E45A26FF614F27A0D4B52F2895006166
      BFACFFE68ADBD9309B563A290120712437168BF38830810C51D8F2E32F73A596
      F7757E8971021A7C394F2DF3424B475A3A6D9F932A2A35AAEC3CA75D830EA7F8
      248872B3FC2AA30C75AD288DFB22AFEF4184BA3E49F09D7135523E04B63FEFBB
      AEB8FA9AE731261D9584E32905333BF662454AF95CE5858C1352FE60DF340030
      4B3F49A0BCE279BEE482CB7D482B7236965DB44058128C04B47AC28E7512764C
      F24C2BCD2AAEA58C17F622EDE5481BF9F2EB60E6ABE28159A6943199BCF065E1
      189A4E2BE66C7E14BC22FE2A70276199480966690DE43435B41BDF7979D6D1B5
      8CE67B0AAB4C18447A4D343E97CD41D0DB2DEB346048F30B926D44F5EFCB87C3
      AFFB595D7101F655DA1D745BE8E7655FF09ADD2075AC2F57A1DC8A2A146C0166
      78C53DFC64F35A82FE13B9646184AF5DC39EE3E139AC73FAFB15A6C9CF5FD67F
      EB69E52AECBFAC66D6EF7DC98A8F453871F932E3B82085A5EA976BF6F7A584F5
      61A995B92AC931142B61391A9A2395AD702123F5233433BCBF5B55CA0D4497B4
      7A8F61D7DB65855E2CBBF90A20FC29923CE29639397B03AEF5478169F56F77FC
      B6BBAB5462A5DA0A3495A043EECBE390081385404355406E2AABE72FDCD5752E
      CC98064DD31C9684AC3D22FEA08207DFB8CDAF2966578FA3C71A0D42951A338E
      D0C766CE9F701E7EE07968C3BB18C35810120569B8E28E32D63D9221F7D1AB0B
      B8A6863AAA748D8987D03ECCDA9834F366215266B68974A3D5F0280D4A39B0E5
      2BE0CF5F2D86317693381EF330D40C19779BCF903D88A2DC5FF90D34952462D1
      2AFDB4501F29E499EF69D194FA1BEC806120829419A8BB42B530F5583AA24BF4
      8BBFE16F2AB4295FF1588B34D3E28CFDC51FBFD38C21A68A2C9B42B3B5C9CBD0
      6AD45020CF09B9F1755928E87A142D69268424694F2A5A11B5293D781AE0194F
      09ECFEF2F4C2010AA804322B42EAD6445C57DC16653C43AAF2E90B621DFB9DE9
      54745A70A9A225D57BBE8FEDBDEAFB81C08B25D4FC36BC23886259A674AC0C6B
      C6D8EDE9BD894346F42A66BE966C0EC8ADE91CF2402A3E817D5EEF46D5C2E07E
      745D5650685724E15EEAF02B229468161F83C77003A47EA8DDE0A787C159C107
      2D41811579B8353830AB6ECAA58FE7D2C0EEAF498EA2D66F4D8E41251BB49634
      6B2CD38C4ED5ABAFBF4007B020D3AABF87A26DD61FB5E46C99C075351B0F03A4
      3BE75179DD21C6C8B43E2B66052B8061873DAEDE66B706B1ADD425CDEEACB0E6
      A62E97A4FAA4F7363C0605177FB20492C24F1598AB677F6AFDD40285F6F12317
      00DE18CA0712C9B303463BD2C59E09DDA25564D876F508ED32B726BE46AECD6A
      7B2E032BE140A38A1917C16EF66D374B5D0F77DE769256BCE04A5CAD0CD168F3
      92D7BA1B8D3E21FB4841184AAD7D6D16E0AE605D8DC055D9B8BF3CDCEAB5A312
      E6151FE8EA6B0476D6F42F826832E4CB342ECC8AD381AFE9315F9B9938A1FF08
      552FBDB891E87805592A480B1A63B7F297AA076E089DE0EF283C4301297D640F
      ED48322319B9598C0124C5AC5A1B414155633DB8558A52CE265EE32DF497574D
      1174B63C0585270DB9EB640A5152EAA3E8E51047D7EA0AC047C5C244BC7385E9
      D07AA51FAA0654C270AD2EEFCBAAD45751DC91102751AA9DE653E837B04C5E27
      8F012E4F3EC79D15F3A48F4600263E5EB80F273BFBA00F9D831C56E8A538199D
      01B5FF3A70AE3A3B8495661367BF144D55660185E92A3C4AD9C7FAA4EBF42875
      9DB9281F26658E3AA6F1AC02C30872547880F0A1914179A4B6B99AF715F27E5D
      3CE41A98E892B9EEC0E0894357FAFD9132C0EE485F28A1F0C2CD0D58D4C315E7
      E5F2C1513AC97C0C158BCA529DD69675916BB69914EEF6F6F6767D365B1F8FDD
      FB22CEB7DD17770482E56D778BC98340AFEBE2049A4EDDCBAF0817DFF3A0C431
      94E547FB04CD4EA32B65E91752D254EA1B8FD893657EE18DC3B3EFDEB883FDA3
      4B7BCAA0C002BB5341C1F4C48FAA5695799E64B9165446732F5EF4F051E7133D
      924EAC3336F38EA4F5E1E10AADD61A255B68B922FD721F1C2D7778855462CC66
      2C501EA131F464DB960482C8369950FDD349DCC796A98E2FA45914669F7A3853
      AF5CD8219D0E15BC0A3F30AF0C63D39DA4C184D79896FCDC2CCF0CE30026DAAB
      BB496B9E0AC22C532EF15B6C0811CFA69247E0E86A0951061F4797275F853DE7
      F14E8E6D71E1A332DEE09D5134893EC78FE1EC9530DADBE59045E99E2B2785FB
      5B9A957F0B32D3B28303004817AB5F826CE475D7EA82A4360735404955F479FC
      A99E3E456A99508704BA8D8AAD1767B06F6546889BB8E49597DA05DAADE776F6
      7EBC9028B8E78E774EF77BEEFCDD857E98D4D7A04FC315D1876EB63023ACB6BB
      56D30B2DC48EAE3D4188E0FDD17DEA03B0CBF507C0A54105EA1F2470F115A281
      2F3DAA50BA5393020F65C0A5678A556FA9CCB0630E05D08C87CF37EE4BCFDD3E
      DA3650AB9A55E0D4228E726453D84155BD7C794854D585DBA88E2B91DDA9DA9A
      5C27C82E18AC4748FAE8C74BD2A17E557573267479C58D96DEA7340E58629F78
      6832BA5D7E432B178AE71DD405533F401FA5A9C735E50C7E77B1EFBA4C4151F3
      C2E8F0F8BC6A58EB7D9CF33817B466AFB24AF74C7BAD28B30CE809A698DC2581
      170AB6B44CEE523CA1F74BDD8487B69BD4D2AB55C6C26AA2F7C0F6F0E429987E
      8D3ABCEBC8F50169034DB34725BFF7F49850600B94112BB2201C945C221DA2F0
      05FA09947D2F1CB95FC9D064F5062528E022A190B8CD919464EC153C3ECB0F4E
      2FC8F744B659B978CA22BCBB2282FDD42AF7642FB4027488FC1F78D5B0CD2C54
      6755A06C55BAD64E27B42261AF2AC9A37C4AD8DDF8BEE4A5F01D48F4172ED6E1
      82423C201E0C4F6D3F669EDCD50AAA66639C482A8F923372F4DA9F6CEDA8F074
      F56D3148DC643E576DE8B3809B53D85D6C86B08F98C8C547644D4282575A403D
      0DA8EE5DC349095A800D525A37E113E30B3053F80B1AA858F32E3DA9757D717C
      85A3BB63E15ED5528C3062454F2E95919064904294C89C2F9000509FF2B133E0
      5EC5462C1738E978A0098CE93429D8A5570B4575A552087CC27C3B9CD6BBC310
      D3E119D2AB6E4E239C14E122A2C2ABE29F4814696190EB882D62AB72F87729AD
      02C09CC1DA22A1B20660522DA820C0AAA109C71FBB1B4024C61D577960D515B5
      D1A496A5B28A5ED5D9C97CEE62CEFA308556FAAEBB2B880FAA81D550FA018CA0
      7A70B193B2F3152B5207EEDD806161FE706D5C3A80244B57CF05A4197454D48A
      2E3390462B5721FE226776659942B3C601E3D1700C25193A1B6858B4D07BD71A
      D4B2904B94BF551BE63D05A6D0B4E91C5B169D5947BBB47095113E8D15209643
      E001E84B0CF294F68D2754B7BE46BD41C4F5BCEA934A35AD4AF83E05B0C2FAA7
      5D32F4689F786DAB025F13F34EE2686952D34BCCC10C308C47114E09909B66B3
      98DA7FFE8395BC96EE4959A3CBD09E5A19DBDA6434C44EBE2848A03ACA997179
      FAAC1E9FEDBFABA8BF1FCC6844397B568C78EB6EC652AF858C2C911850C38142
      4F96FEE1C9E3A116EC649AC9669967E02613BA4BE817513726532D96070DF389
      D4E2144D46512373FEF50599B60D0E45916159BAADE619BBDE44C01F3C8D4E6B
      3BCB27AD55B185133146B755A5116975C1E0C6A208F0700AE98147B8A969D264
      2364F9ACAC5A9F296454F4C7AA21E309ADC748DE7D4AA99A7EF765DC7D155E10
      C128977761098B7124590456A505EC3D014CD1B2B3901094EF572AED6689BC20
      0EE888E1485CA5041031D74933EEF3A8C8034982254A6F4B7639A3648ECF0CF3
      EC93D84C61DA8B0AB296CAD6C203C2B4A2850247E25708BF7FCC446891088A13
      91ABD9A81ABBF437585F17EFD38A8871679A30CDE6FEFA7E70B9F65874B49459
      5EAA845115C3E396986025ADDD300CCAB836ECE6C7834BF7A7A07622A3F95CE0
      4F7B03F72762EBB47C19FEED187F3BCE345FC1BFACDD13CA1737C932E77E3546
      A381AB62F970FA24155B9F40FBC63D5D4DF89DCEEF577746AA26B3248259D937
      B0FF1365FA768C1D816DD84B39F88AF34002AB90B2269B0DB361F6C50435838B
      70A74F9359522E2BD8E955ECBB7CB5E9FDDC04C20B16A5B7BA720C920B34EEE3
      916C2DF0F0A7B80C8185CF3051A123BB8339ECDDD34B41D51BBB46BD0805FB46
      810E69A174DD816DFE71528CA21C136B5FA94A550F5BD1653933D273828AF3BF
      E341C24790AE854CA3411FEEE95DC3C7D197A0D26186D010A931AFD22CB84EFD
      366BED968142C64775679F2403CCBBA990596457F42015CA1187111BA82618FE
      2DB43FC4526B7403D4342F77BFACD0727DC809E01868C69FB817A93C35062BD1
      CE782C38E8A3C9494295B96E142395BCED8E6E86F8C70F2E2AE423F8093B621B
      E156925EFDE0A2419697F2C762DBED66196564FFE42ED1A8FF03AD9D3655182F
      47347543FD5855EFBEDBE4EF4523401C5085050605846296B5BFB0594792495F
      F9C8C58A47F50F7339E033166B3FE00B12B81BBCDEEE8D4AA47E81E126AF460A
      411B28E1CBE28C326921ADC80EA12CBE114C5FAD83BAFFB427D98DAF925400EC
      DD48C1887C18FDF7DA0FA650A65F3848C70F7F7C09666E7AD21ACA2178B33CBC
      4A100F174352A7B01AA994350103C4F5E20AECE6C51C41377680A9786CC8A664
      6297357F63F9792CE51A8EF069F4459FA307315255399373B1676DEB3F3CF4A5
      2166FEA10F6C6CF4FB0F3E4AF8EEAA21AC3D78D7F2E184DFC68664F9A3D41EEA
      D69F8B65163CE8431751C5F4873E52ADA2A70E3C4EC7ADFE5EADE09BA1B4CD1C
      C00FDE039DF67136FAB4BCCEEF7EEA7D3AE5E7EE2176D65E1CCFCF2D1EA0293D
      8709F08A04CC2769B45DD2AB0C010B022513E1F2CD051E7493B0CA28B8855012
      12EE34DAC12A48D6FC91331AE9E58F105A1F80BEB6E75E20B9F0CBF96F2F7A62
      7871CFD59FD9EC7D5B7D6A692AB0742296ADF2D8F47AECD85DBBB7EE1308BE4B
      4103A9AD8FFE970F3E879A1D140385A7072F517F791AA1142BBF96120BCBB590
      221434D634028B534A443DDB35C5B3603ABA9624433140FB399E7CA2EE2EAE1A
      609544F40200FBC55518F033EF60DD2CC001E21849528485E8A4146DB1F476E5
      D7CC43B09C11BD78BB06925E0A1A5CCAC73D953FE97F7DFBDD965B873734FAC4
      9C2AF016AA3CC3B9565296F29B2A1BD5F4466FDCBA291AE32D3188A59880E44A
      2BA414C375D3AB12180969759ADEF83BB7EEF6A9C7B8E2B6CF7DB3EFDDBAD1B0
      EB3CB20432CFD1864C97C2C5E928638219A87A6088E615A2262ADCFBCBC3F5B7
      224EB03E9A6F2FCAC9FA5B0FB06A38ACB7AF2152324EAAC0445301510EE242E4
      85590A513F59E8BB2D414EDFBCE98DB1BCD831AC2C0F6059A3E7C072503C9B03
      1300D422D21A9EA6AF4AFF21F9579059C48E32727E06298FCDA643FBF6CEABF2
      52BA2AB594A5808B58EA9C728515E1131A64E29C916491948B15B0FCAF180B36
      87A78AAB82DF046B339BF391B1E58BDAEE6C7A336C08FFAE87D0AC9BA039CD2E
      2D625A68E3D3DC6BD3FBBCC5BBB7E113B6A7D4AB234F0592CDB2311846AA1DF0
      1C0F884D589BB71785BBCEF2E41F38A2A7DA080280F308E73A92B43C3C865959
      66332A4762B1DD36BCFDF72FDD3A6DA652D5620E09990CC39C712CFB90AEB436
      3D25136A3A428E1BB884A6B7C796EB20FF84D65CC59F8749FB42D37C8DAEDFF5
      A71C437BEA31ADE108D188C7622378175203B14D324AF2D162869AC988697D03
      736A46D958DFC5357AD6B14974B8C1D58C7FAC1A2B6559A5C12CC94129E33A95
      1BD30999E9C485EBFA74AA8E5F9968A8FCDBEC30EE0A1A854CC6AA5685D11F47
      E9D50209F1C02C6883DD0DF2C0D9C4F5E56411B53AC6A5FD61116DF487D12B07
      880758429E7348EF2F0FDF56C718FCB1A92EB7B11E7285620B223789B0D5469F
      02006E32F19F92AE6D560F9231AFFB9CE3CCE389F34D4F6C3C64967B16CF32A1
      29BB0F4AD1F2BEEA8C6A89B77A6F9469C23A9FC72C632279663DCAC843D1EA48
      67B208BC211ED1FAAE805DA5ACB248F52FCF3AE894F84CB6DD07A9D4AA3CBE11
      94C66FE78AC10D291B65F758C16F899B41CA52DEE891A3EAC62A690DBDD7372F
      616A2FB8EB251F972EA653D30D9DCF3D519938E9CF6A547CD637E0FCF2B071B3
      0DAC0CA3FEAB1F5AA46532D59C95E5108938A41BBF9CC26A3BC45F0ECFB67E73
      87204A4852F7EEF86C97927779F6CCF779C862B2B5F82E804B002C30BC9C22B3
      AA42E2A88AAF772798D0C6160232F73D0073BA5266D97B9CC3A74742A5320315
      47A77AD73E36BD9F33E759072D3445C1A8092C2126D49798A433A9724FD7EA45
      79B42C82493BA7702BDA5DA07EEE86D368A94BAEED5819AEA3D0EB272A491D2B
      51CF7A2EED993F7E9DE5E5688152208358C22EA4986CDDD95200D0DE450373DD
      564AA9CF39AC8B281D6733B7F3A1BEF36F82BAC5B3CEF6E5D95E75ECD5D76796
      BA8F49FADDB3DE4EA63701A3AFA8F4746A123344385458E67A4FB60F329314B9
      6185087AF11AD5B879D6E1FE7874797250B8AE9A95731222BA1F8FD886001C86
      93943CE8AC11709233F7DDC5FB7363D555775133E4D9701ACF9E7784770815FC
      3BACA4020D4D6920456510FEE867FC5947B4AB2A803F02D3A0A40685DBD30E6B
      68EEE2506118B931CAA6D039E5EA16EB345A14A510BECC9AFAA1F78CCB503614
      9A9564D597FDC58C10BAD4ABE2C2FB50E6CD8011D7376DACA04D6D1F0DA1E923
      FE829629985646759340538D879A0253E0A5A02E084205691067382E40E6671D
      563DDBA13955826F11B5400DF13AC8C3811D0718370A92A87B27F8946CBA4C97
      D1D670878C39673F7971C81A7945D52CCEC9AB2840E539C84DA91979F6E2B0EA
      CD9AA630D33FE7806F866793491197C82BEE65D3620F4232CA5F2720B69C25B3
      4A29D5FAE645B70179805BCEFA738E6A910A20405A7330A0CFD1B4A263944D9A
      A4FE73D4B2441B0D971DB1DF93E46A615A0D9BAFAEE552BAE39F73A8414E10F2
      D245E9BA7FC2BF154C652C11C51A264EA07EBEEB6A1CFB2EE7593656DAC4E7F5
      AD9831E8B140CB7FC0ABDA43D91A43B6926D7810700305A98CAEC974720184C4
      095238827C282100015ED9F2115C22AFFBAFFB6FFEF0873FAC3DB3A74BA40308
      0EE125AC3858E88F074640B660F03D5C5E035C5C8299D17802B81248CCAB9668
      C344A866B050D4B1C155A22045DE8260361E7D024AA78A7857DC967B1E7C0A60
      FE886652F878D6B9190C0EBC7DF4991D1545950DB0BA4F75B3E6F5F3E561B0F6
      D9ADADE75D9A1F0CBA584187CDD97BD61B896BE646B6EAB389DB8F6E908BCAC7
      FDB8986976B8705B9255F1303AB85072F0FFBE405D895778D6A1ADD0033325B0
      9AF4688508C44B19415B433FBE9CADC056AE52922B00B3AD3D02430C4947A3C9
      D04991438B7C866192639A194949E9F5D9E7884C09CDB164F986F1354E6E7D12
      DA9F3607F33DE3AEBA519817B74CF5D2F425B593985AA7A87E3FAB8B50E653F7
      8D780A18238358A5585AB163456FD5325814CA0C21E91A88117EA99C35FCA849
      51A7FF8A3483B4934B66102EC2CD758C56E7903EF60E7251673A445F2EB93FEC
      B4558621D6BB6B00C4E7350958B6EB15BBF0124FED8A8E85A0BFA9FA1AD1C44A
      652C644EFED0F0A3F7121BF698D6F8132CBBE72D1208900CF31C42FB7A2B17BA
      09F81980A37AB6BB52C702CFFCD718935AE23F64CAF05D6DBECE476404E54C9E
      772C614AA3E75F65E8D6E83468978814E199F9630A46FC82C20FB46126787313
      69269534039002AF8567413F2EE6128655C04CE99B6A7AAB575A4CB7FDC8725E
      8928FC6080D6E239913FCA814566672478F384C9A6E74D42E75171AD54E22314
      326459A0BAAADC2BE2D7B13223EFA127F1090D6CE44095CA6E8508A180A0FD44
      F7D3C0B0C2DC0404AF6FCC502C42A5DDE0E5C4937F78159AA06B4C0E56453C44
      32E8679D863B6A39468AF14F788E023A8192C12335492479C903C8F0DDBC71E6
      0CAC6B30A47D5A567509DAE5081BF3DC704DD7190AB9E79A605217261BC773BC
      83328FD2627AF7EAC510975D4235BDD1260C71A64594489D8CD7FD57FD577F69
      3440C1008E7D8D05C0D86C0C8F9819982F83034F03D7E2FABE03F0727FA76A1D
      6E7341D00A4A3760D5892C045FAF7BEEF0F4831C59C1F01BDD4CBBBB5EF55FF5
      5F36BAC0973700632E83D09EFA6D69D5738B945B9DFA156C77A3B1C6A5B52FAD
      D1C52BC0799BAB606B2A1669F5F7BF7B85EF7FF72AFC3E94648A6B11301C1B52
      06468AF90B5640BCF054BFD1650FE1541F0CCEBDFDD6EEDC78749D1AFF9C2027
      19BE1F0C9608059EFAF8529C7B87E21CCEA6A3D3C33369FF6D74351255058DAE
      B06D9A4D37E150B7B7472C4CA3EBE3BB15A38BBCF646D38B8C0AAE66B32BB185
      AC4BA681F68FF77AEE8C752B9CA6C15F0E0627CD669AEC4B9C6EB359E707173F
      357D6BAF370E4F3FFC267C1E0F4DC423573A48290B1D19DC564A9F285EE1F0D1
      3A79207BD06C930988B48CF31CC7DD0DF8775C115F49540CAB978DC7DA86D8EC
      06FB8AA01EDFA6D12C19B991264227493C1D5BFBAB96BA0CFC1F8902081849CB
      D175DF7DC4D1861C46B94E7A815986B425CB3FB58B2513F78F38CF941899788E
      A8807EA3082108F7BAB2C51020EBE37F538192DB06ACF5462C01AF19673CE2A6
      84448971CEE2334E5CDFC48B349E8E89FA13F174A2F906FD3495A9D225D8F353
      A77277B0033A96CF2FFBDF3636A8EB14C708A95E292D184976DDB040926CFC14
      3B882F82C8658CD6F99157ACB0E212F3E8CC2CC071932FF7054B7B1DA15759AA
      1BD17424722D9AF639D9FF567CD2CBC30C10E9693244F5BFDFDA53D96CE6A9FC
      32181CC8FEDFE31244026FBA187A29BC2E0C8D1AA4B51EB605209E81BDC34631
      8395A4EE8FFDD168C4A96A6A8F4806F79BEB0879A660C085B3BBE898EB200D53
      2DAD945E6BA79C02D320B5A716C7D5E1D956D0B6DECC79F8749B2733F7E142B8
      F050585C945BF8595FC7B6975229C89BF7E102EFBF1F7F6133C5E1D956F50B8A
      0168A0220EF27A1917DF7ECEF1FBF549B6F5390F24421A1A50A5C1DE86F979BB
      3E4EAEC092731D7F89206D056A2D2D246B2300D56BB2CF8950FDBACE2E8E61C5
      BD7B5E3CEB15E9886953EE5EBD90750856B970629D1B0D9F199B1A9ED8BB35C2
      924D1EC564964CA39C2DB23DE39E619E4D3A87B564C9DC4845744E9F3F5D6A15
      7AEAB83A17544430DE16306E2EDFD6184BF97B2660E6117A35A5556526DD8AC1
      D110A50D8762E5767326578FC5F7818FDDEEAD90D94B56EB73407F1BB01A6BDC
      22F47FB7F3669B05F90AE1CFFBE76070B07612CD4F80D8CFC9ACCD7757FDF1AF
      8BB8282F01CCE31F938950EAA1D91D090802D7A57EAB540D12514A6D9EDDD1C2
      6B8D5985E5954F351AB6F6A18E57D0A836BA1EE217249540F664145063AECB99
      661C9A5D979CEC01B569E575ED9C1FF194AC9A60FE5E80153F4D26450F3D4771
      9E44D3A2E7A619127CD3E55EA1AF3FDC9A1F6DBF994D1D08CD0ECD0C85B2C4A0
      B6B9F0E0A0ADBDD78343ECBCDB6A35A807D695805149F0615D7CFFAE4BADE54A
      D9ECBFFE775B2BCFF88AA5DDC93C338A4D69AA8B6186E5BBE5B0F7ED514F9046
      78F27130D066B8271F49FF5213D9647D34B425FF0DBB8BA1B8F74AC3B77C3515
      F2FE598CB8A2A5D77BC8A8D7E30C65E002098B231E70C767FBAD6E25CF81FFEB
      B3449FB3645CA8FA9C005BF2382E782352CF2CD0FB0F575FBD3CF426286537B8
      8F981BD7BDA9B1ADA94912482E4431009149AF5405CDC091DE7AC9348DACFC94
      EF302B7EBE7BB0D3A672FADC8E03DB2B01EF24F3FC6C5EDE2ACD40B394ACBE6B
      5CD016D2EE60A75D8B8D5D347874452F20A11EA3BC13A13821858B69948E8B51
      348FB1B01ADDEFF0F4832D597291BF969F5AAFA097CD56905043B43F5F25D1A5
      9D3DD338FAD4E63201CF08F2B20CFAF78F768E5B5C92BC60E6795369A3A90D8D
      C69F51AE0A0471DC24A6BA67B3CC711E5DFD1F344B8A34AA160E98BE592EC677
      6A163BD0BD634DB7D9E46414F630FA566186AC60B22D5DADF6F9D3EA5AA4A1D1
      64031C262AA9881B221FD8EE947151F6E711E649CDB53F7590D060D110F1DAD6
      3F19B41D9EBDFEE7E1E98735E5D48ABF347B81DAED5414D9286196D2129318DB
      1FFB4888CCA3A227FFDCD27F4EB2D77392CC8FF143FA193FA03987FA93CDA68A
      F9B2936CECCEF2AB087201B9EB6E82A2A174AFD6706A09477748082C09D655AE
      9B5B9F65FA95EDFFD07F600EFFDC6C9509A07F9D7834000E4C47A0B03745EE10
      66141A2F93F5B3ED60FC4C9308C83C5B9473907C109CC5AD8335A046D81C0640
      4667108591B14A1A12CD81E8A2739DF5B3ED7EFFD75F4FB2B19FDD5F7F9D65E3
      E2D75F2D8738462E1E8CA4C767FB9D96A7B96CBF68EAAE13A3CCB75EFDB134EB
      6BE2A5E17D700F8185E258230B461E4F08D1BABC383850FFFEF86CDFBB46CB82
      0E96FF6F8126B8E3C4F5C86EBCECF4AFFF59CB51EB7F56B1A3B2F9E9ABF7FC18
      47F32CDDD8C96759BEB1339B2D5432A998C3AF28AEE3F8BEA2E8D3AEBF7BB67F
      B9B17BB6FF4ADA2E3D2289FE902FD84BC2D92B27630792A549783E558F835C36
      34796D06E4650DF7CF76FF73B532F4575EF16205AA48A47F2BF4DEDDC4DBD77B
      362FFBAF9BC6536C4A79F3FDF63DC4C64BD5AD80D25A407170F35D34C3A7F0F1
      B0D3D6D7B88B1623DBDCFA7EBB52211FC748764095488C25ADB5CE2EB5B6D1BC
      DCEA766F5E6D0798E53CF38DC122430D990AC30F75030B696DA059956C85E16B
      868BBFCECA4FF16D1126C2AB6CB6A6C4BBEC1601BA4A680C7B88D3E6D1D87D63
      129FD47859B79FD22C8D7BEE8F68628DF3B2E9B8A66337B84E2600AD61E6AD21
      58D7218E934FC99C40B28CA82B1DACC80877B1651705CA9245B900D73C5BA1F8
      D56C514275074B08290BA9D6C6C527A8FA45791C3DD380BD96F0D94F0FCE2E8B
      CEC8E303C98C67325EA3BBEAA4957C5B1B244EFC856A8DF75EDF46CA8A71A819
      DFAA5E26DF558E31F60EC0F301CF9DC600D9C4F888905A4917B34AA715513EE1
      CF6C136AF67E0097FE664F588E54B91DA2F3C2742A0AD273B2CDF4DC41311292
      4F613914A15FBEACE650144D1B69F9BF2EDD4543375E8CC06E3C2D0CB482B2B4
      C0048C848D0E507324BE5636C439274BAA17B41DC7B3CCBD104CF5EA8FC18D7F
      F19CD147505F28B671FE0BC28505418B30BA7C691FD77A01839ADBCDB39B02BE
      F4CEB4FCE6F075B3D5E09F2EE0711B66D927F03FE9F6D3186F5B56CE66BFFFAD
      F9B091FF68CF6110F6B7AB8CC4A60D0B5B3EC981363A0F3260877F62A5EA8844
      DE3DF7224B5F043BE2995276DD615C46E60DF548C661070C4FAC86478CDEC862
      BE083E1E4A96A0A1A0427B5710A4C5149813C900AEF5DC5CFAC574C7DCA285D6
      4A5314DD0136E519FCA515BBB3FBF1128A30F0CC7A8435F594962C9ADFE68B82
      EFA6E7DEC5E501E0C1447F780CE55AAF4A5C9D469F4F9852855E3CE9ECCBCCFD
      3D4B6FC6DFB59A49492D72485D1B930969E116881804B479FCE1F89DEB5E4DB3
      6134E59F8E3F1C9F92489DA0BD17946D0575B4D4E6F77E12D679B0AB48624393
      AEDAB3706B1E8084EEC65B7027E1FA35CFB365CFF3F3C5BB7DD08F9BA79A3991
      E72110504E8616E832847208B1C27680F3E3FD57C11D93D49DEFECFD44919224
      455E70AD4534B77B7EB91F88B358A268988D6F0947AFC82E77CF2F4FC9ACDDE2
      6E17310887F01AC93A89F745CB21ADA04B02B76D803A83AD0D450F6A64CCDB84
      46EBEC707019AADE767988BD1890FEC6ACEA0BF30760DA2693B5F63149C3847D
      5CCC15E3A5205615A556EC7A5CCCDA78F8AFDF6C03685A94E07B029A7E028E1F
      E56635BDF6B129F9096FD4FDAAF65F7BF3EFB6159B2F897EBFD2552889228B42
      C7727479C2C65D532B0F0B4569CCF615ED7A6C91F15565AAD4BDA572243759F1
      FB02D1F6308F469FE2F2EEC0341ABB4AA47DD18B4558559A208EA2E7927EDC77
      BFFCEFF3A41C94D9FCB7E61EE2FE70EA3BEA6A382609054D5383FE14B9DA835E
      AD905484A05581BC345B41347B1E4453D1672331E19D8180F551997B9B1D8928
      DAC82EC0DBB02D80C620C86DCC804A9510ABBC36FD76182C8917600FE4B8D136
      9BEA0B0C27AC038ACEEE73BA903DE84AAABEE6923FB95314584EB3288DAE2005
      AF3F0FCD77E4BB6EEA3CEA312C7BEBE7BDFF7BE1BAE07E93E4C53F10CBF988EA
      2F6BF50306475AFB7B9E9F1C0DDA5415BD47264A42D9103AF3421E104F033BB1
      ED4ECEF6777BEEE46CB0DF7387EFDEEDF0FF03FCFF72D0E6D6D62F78BC77795A
      3B2C542DA7DAE9EF073F9DAB356EF5B6FC9ED10437832EB052A30D2EA1B2396F
      EE8E445112EBBBD50DC5E805A5764362D3C968FFF65EEC8BF3FF4251ECD73113
      B5814978B1FE6A73EBBBADB7AFDF6CBDEDBFC47F2F4876C97636DFB545794AD9
      DA7221788069E67EDE3BFE58AD85E7F0FC3BF0157EFD5570BD42E959785EB465
      87FF597DFD105E5F1385E0AB6EDE55A40EACADE6C066878B9A828E5F5A1405F5
      36B2A2CEDF5D5C044625A0D84096292AAFAF72002F048CC92ED4F6F75CB18A4F
      DE1D1C72F660D264F9FC7C7CB6F70C2BC6DFB5F35EBAB52C16FE7970B0DF7137
      51DED811A90A3A7207096BEB0F767ABEF7B7DE8AB0B02D5AFF65FF7543488042
      49F2F8F306048F42712859030B10C7F521F55E93FF08247C3D48597405E748A6
      E7A88E36EBCC185442B979FCFB827A1E9A2667D114E35DCC6F408CD1E2892357
      C408ACEF2B890632CC560D7B41015CC9D53322C2C434F70677828943BE0E5418
      92A1927C60B34B77FE13FDA000D4591064F519D0324B85619ECD17F31502D54F
      EFA68237B8617A0E28B88033A308D2B8CD2E7C0CDD3B16AEA53FF8264FCA12E0
      99D2BD3ED96DD8FA478E322026C1461D7F19C586B0278D8AB6389BB4B0D09B9E
      5B00556626F04CEE90329ACDD9C934E37128820E930569254A8419C28CC21E6D
      ECFE7EABB2224434D8FD6D2071AFC7A47A2374252AA86BDF290D123A8AF67E62
      E2D96BFCCEFACF16953F90DCAAF41910F5D16D85A37CAB809387A5367CA7EB76
      DB16577140FA2D2F534F29772BC07E1E5F2DD0C2117F31A9C162ADF9CDC238A3
      7B790CDAC3780CBBDE739722BA9214E56EF6A5E12D64567D0A42980B944DC357
      E824666185E99B432E1C582431F1A4ACA33AB2AE3F24F41B0E46004F6357DCA6
      65F4C55D2757D7536C251C390441C91DC40E3EACD00EBFAAD942018FA1E09B41
      5A236412227E473E9BA60BE72C60932F9EEFB247E2466CBEFAB6E7365FBDC1FF
      BEC7FFDEBA2EFE0746B00E1203CC7EE3DE9D47A43B9362D46CDEF650D2AA284E
      885B98CDA3321926D46EE78A1A66E5B5DB8FA7F3EBC4FD7C4013F5F3C16B2F15
      0850894AF888F0668B231CCD5EA7B8A037884506B63DB1E8023D158E40D520F4
      0D50EAD534BCFBEE6D19EFE0EA6E1AA757E5B5A75365C8F366CB0D93B268EFD1
      BDFABE9947C70B8DB2B4EA8C1BDEBA5996CCA274F3E54B775D96F3627B63C3FF
      A63F8E3F27518A12787F94CD36A2BCDCB88C8B6FB109D78F4053BEBEF5E6BBEF
      5F7DF7F6FB37ADE2240A63A74036484A927A6D68F91DBBAE9C2985DBB938D9E9
      B9D30F83236406F65FF55055386B686DF4C607A4FC543D18E9FCBE42C2064735
      3A00E1A02BA53ED95998836A73C3C3FBE21A9655EC8C12449E4784B6C9C6BEDC
      72DBE0E341F199448EC20B87FC330BDEC54CA8AAAFAEB3A25CA3E7E3FD99A676
      496EEDDEBE75DBD8EF48F1D0847B062736102A85599994532F910A10AB747814
      3EB3E8BA63D12746B3B35468F2789E67AC5C0F17576BAA73871672E641C5D609
      E2113C6F5FDA3CC5E6E6F76EDB172D4180F2135C08F6664FE107FE7C7C715C91
      0E0ACA14F8130984C4B9C108B32296CF12640B86FF710C73338CD3E44A40E001
      55CFD1E549BB51BF74DB8E2E4250BE671297657DC9A02EC9A041E71702D0B012
      9DE5EF7660A051499135DAF01C0CFC6B457A9ACA11CB7CA221A66F4E62462AFC
      21F06EB7145F552F712F9A27650571D2881CECF868E544558089AAA01A304E28
      E13786ED76FB81768222C68CB5DD15C0ED92C9FCAE2AF3B33AB4A1E706975EF9
      E5F5B73C6D01411D63BFCCA3028C021DE0343BA066BC01E942639F3440521846
      A785371DAEA9E25FE5D55963316AC7C65D6B3124D4EE2A595B381E587E08B411
      772BFB63A09C10723EB6DAA1AFBEC50EF51C48AABF2C94BBA8C621A781FA59BB
      9B6CD20CDC1170B888AFE87F0A7897680BDAD2A21FE86C7BA0164FE36974AB02
      854CF554F2C19E6CC39D12F0C92B57F8C29FF78E2FCCAAD51F4FEB00ED1EF0E5
      C6E626CE996AD8355E4042E27C5A4A7245E13382666C317701831A3E2C3839CC
      8909A0514C72CAD8A09D5DFECE6D43D69045488968DE1BF21A4780D1B8F81116
      4040B5BA234C9F185ED7D16AB8B8541D378BA6B69D5B5AD8CD4DACB49D0F61FE
      B756F965098F14FFDE01EFBB81B8557870ED1842EFAA96A5B158B0AEAA463B7D
      4B58ADB76E7E1D15EDDEC54BAC9B0F7400511E3732472E6F187B12960F4E9840
      EFBBDD68F409B086745C8187A9792E67047B0640756E356C1D2CB35FED868925
      03463D59C3BF835EC036946EE0F80B9A735930D74535C923920B49125B08F3B4
      C5011A980F4E7C8BFC940DF98DDB76147DADA78435578B52BF547345D3E50665
      DDCFD206DA7787491E8B260962007849818780032F9E4C103F7F9EDE564B037E
      9FF80D52B36B377C98E6333D20843F19736E735AA09F882C0F6E474B78C86399
      4B5AE511FB6E5F16019CFC9ECD345CD5800DD23F82423FC4FB4001A2DD33C001
      FC9025A3D8818BA2A23C815B3D9FC7515EF4DD898CA890D5B0E2BD2F9DC13FA5
      5410C4E7B65B59EDD76E5B5978EFF8A8CA630AD0922C979ECD4C4DA8096001B2
      C190941029A849C0DA220BC18E813E8170423255C18039140072D7DA4D34EDAB
      B670A899D39C836015B4AE1915457285C60EC51D8FD97663A311DADE19D6BF06
      19957695A929D4AE6B6913DD48FC292AD50DCD4CB74CF24BFFA2A48F597EEC96
      0ECCE362EE550E3D977C948EAE33C439B041D47524142CCB1B669DD9DF0D2A5F
      1A57A05D46D1E81A31B56D3BD7457F20E6611C0F1757F07CD69E21E5F2B659CA
      859C6A940AB6761F7935091C4A748909083C8E52567AB289404E0D0C2FBBA1EA
      36601F1B69E2A2A93B8DBF2C688C06651CCD68038BEB4C81657DD795CEAEA8F8
      E4A221107F1C86AE9B49962F66AD8006E70A01ED4AEAC2CEFA358F3924610703
      9359528CECC8320EB72A67BE9F4757593ACCF214A4836D86D4419D5237A33BDA
      EFAC4AB4A847D2E83697B8BC311D59F16C65FCA7CABD82476A96C8D4D469454B
      1EF44B949939F3FFE1DEBE7CD9ACEF6EAFEAF4F55D66100D8211A64820711E75
      0DA996DD18E680FA4666AD446AA7DB08E2EC6A12150E7FBC73BA2F68680EEA74
      E7C3919FF7AEB494D47B49D6FAEE2C0D40EA5AAE958E3AEEE79EF61A08377EDB
      47F21D752B9162B023EC72781ECE9997FD57DFFDA5CD0E31E2CD7112814ABA58
      0C4542928839C25436FBCDA43F4DE876634C4C30356F17E5E4AD51C5F4DD65C5
      951CE6F77A52EB8154000AEE52C52F33E63506652EBD53B9A538842E879E5399
      A12ED686954DF104C35BDD4D1BDE4B42435481AEDB719CFA8EBFF62FEFCD5FDA
      769362E6203B4ACD16D72DF36C31F47246355D90B5F6796AEDF9BDD8D93BD0A4
      92145086C99CF83DDA59755B8E78725545A01C4D33CBE19F2032F5242C7A01E9
      C1DD4B4ACEB80A19E4106C53B1869A9047B04AFB7B98CE12E2769884A0E058B8
      EEF21E6E8F1A7FF56DAB7570349B031FCBD00EF8F7A3F3FD816174E50DB56FF3
      D83F009C5E83C79DE3BD1FA5B7B1B30F06FDC5A8E43CC1A19BC64567ADF5AA0E
      D0AA0551234A94A7C568B65027A9D680762E4ECE04038685E9F56E48394D69DF
      BD9F60C6E86546ADBA948215C37A9472E7B3F9C00F00F3C235C2F741412F0E5A
      46D1FE5550B53978CA1341159ED35C770D4D9BA4B2B4B6D61871B0D3D0E266C0
      86A81D6412101189A81F64FD7E6C84C47BD871622C9055D34C1B18DEBD45B2C1
      F981D55A1A5DFF9CA9F0F5210BB2D579AD6A7FE45D09055E3A528BEAAA76986F
      490D8D0140F780EF9659B34DD0D19A88DCABD92576D2687AFB8F181829B90C3C
      9C1C44035072D18EAA662CE1428465DD5ED3ECAAD165CE86D3E4338EFD0B488E
      CD6299DE73A11341F3C9156BCFDB1B1B373737FD14610D5ACB5973CEF4BB1BF8
      CDC6D6E6DB37AF1BCDD2893869DA58C8C03A73D9041832A23D316F9EA0BA43A6
      09F0EC0C6509EC22170E2F73238FA3D1359641AFDA88F9E8BAE706F1EF2CB4F6
      CC15A2A7D3737139EA375B1B8710D11691144A6AE9D9AA92CCE225ED1C5FB63F
      8EB69EC5A70C889A8D584269AF557E8274A885F17F01A196B9DDB3C180A57F1A
      7EDB62CF5062A7840A332501243A49DD5FDF0F2EDB5C9E8D6E82589F42170B05
      44E5EA18C6285FFA602A40FAB43A04781A6A9BEE34BE8A46B7EEE274E7441D24
      9C453FE89C6A714FFF2288621C963DB77382FF7F3CD839EFF134EFB993A341AB
      58DBF05AABEF52896F6324F5130BAA971356E328CFE233E6665159EAC7229575
      B3D6A2F1F2340B39C4401DD646A57299D8F02EE49EC8E4E86A9C41555D042BC8
      8B138F85344715D54DCACFACD1FEF15EB3115168C7132703DAEBB9C24467370B
      21CA81361D45654309DE86AC653EFA45DDAF28F3DB6AEB6729054E54D3B4D1D5
      7F04B9C5DEE5C571A52828E6504B0A409D61CA2795A16C6F0C9BB2BACAB6D0A5
      2EB1B495213146394AC3933929A541E4BEAAF62387EA31AC8F6CC0A2E78E30C9
      3DD0C94EA7CDCEFAD3F3BDEDFA657AD4F5C3F956163D7708B1D77BB3248F5CFC
      221AC5DBEEC72801CBE6C16DDC6EA87B8FD0EE3C369858B210CDBE4DD53F006F
      9B7DFD27B3D159BAED483CD5531AAA9EDB99CDB21E5E44F31508FB043CF66FEE
      238FDE38471484FDF27EFF4265688CD83EB2A6162F2946865456A3031A81FE73
      38077789449BC902ED9EEF5F12D96AA908A8A759C249DAE7D4F032D74DA095F0
      6CF0D93C03D73442A6043DB5DD2A6C96ABD1AC3CD087F7F83E7A51B8323142C5
      FAE5F17B61796AE4323C726F3837BEAFB08EB6A886C0BB37BF7C5172DAEE3E1A
      FFD0E2EA470F1258EC279FC1B194E5EDF25AD1283EFCD9CDAFB3349E791168F5
      48E570D65833C82DF49F2593B6D4EFC5EBC309E6A4766508D2098BE52DED1972
      74E0A33FC8E72A7484BE64E95C5FC836A6EE16088D2123D00E194B8516A5BF5A
      8FD9D533963A38F042BF2F889E191CFC55FC8C2E527FD49294A625736CB4B91B
      E988D1728BC7D727BD6475D4E9AF9B8A7EC18BDBFB71C7D2099C73CB624859F1
      3A9A02C42DAA11EAC8EEE33C3CC9D2F8163E5B9B7B2BD0672C4EA93AA93D79F5
      91E07FB5205E5B35617B7E43D85D167465F1DA1DBCBC4FD8CB372821E327C1DE
      24E955A761179B7AA4CC83A1358FB95624EC83DE33BA5CAD1ADA2459A36AA3D8
      29260D2F691020D2D8E21495EAE0C9530BB51452A798749D053C367B76409C36
      5C94A50C523F2BC3ECB1B42E896EA9D96AF99D50EA2FE087933A3D94D17B52C9
      BD73333D7C290A9237C6BFE94307F5333BB75BAD8E81602C2AC289ACEE56A0DF
      6BEB37CCE5DFA6D91523FAC53C2382B2212658ECE32C01E8D25375F065095310
      7B8C348091D8C56A0D791574F8D9E5A12FA8668F1A97EA38AE8DD7C44BB388C2
      5C1E9BA4D3B15C0FB7E93990C4E23315D9E90B5045679E3A560E8D8A09955CC4
      BC9A7528762DE325EA489707830FF2AFB81C3D0718A12113A6694E484AB0396C
      37689564B877AFC6E323D7F2F4B64871833088BAB4458C5EDB129560A057B265
      C5B2AFE828939665AFC648AE0E1235AA2AD08C6A7C2D4C50552793E8546183B4
      7BD23367CC2E0D0F8B9DE9F437F731BF8DD1D3742D6D1A882F151FD2FD236495
      FBDABDE1F91EEFD03D36BDFBF1F16FEEF07870C95A8A50338A8865CDAB6C73F5
      837D305F10D257543804EF06B7F219C244AC760EF66C86A6C1DFAA9AB57C5460
      89B638038DDF56A3599F6E5BD4516F2DAFA841466C1331E4426D4C2D7AE28262
      166C7BC2AE0B9D06F1D0E8DC0469DA0DE47299CAA589D73492F27885449D6D5C
      20897A4FB2F14F49E98E4ECEF6CD170BD9ED8D71A9C212B7B9E532F55AB89483
      421A741AA3ABA63DDA3E02178CA8844521F8AFA2E46ADC9CF48B1D3016606437
      48875C939A96CF268978B0EB1D1C1FB7BEC920CD6E6EDD8DD2658619CFE44B18
      A5EDE4E5F52CCBF26738E436BF7F7EF91C36EDE3C0A2274F471E50090DC3DB0F
      B921BE43259B4E3F7030C8C882E55381E506A848269578CDD818F64841308C55
      FAB461E15F40F9A261AF2D8F99E894960EB552455CB782CE7590F5C75B91DA55
      D1F110A46BF29955FB50D0C97CDCB88C92A9B40C0A721136FCAE045AA357D510
      823126DE4679E9E15254CCDD2A6D2B99340E5ADA4F40D14CA83312D97F5FCCE6
      5A668C6C469FE7A57162D9A51AE79FEC952176C5DD0E52B8C9E7599236C34388
      291BD094110049E32CBFFD467F7F8EFB1EC87D8939474809A841E408F1210106
      8F56205D2D8DE4ABEAD4184323B85530986D68345A84CFB597847C0918FD6FC3
      FA089E4268ED6298061C7042B2125D450DBB7CAD99705D541EF57AE8773094FF
      08B65FBAA7324021D11BCB91C01BE06E86ACA9F4224ED1184A2E3C60390448AC
      CCD142D38E9E18414B36DCF9274457498E9623905F5C28D40A3B4D327D7A2403
      72F65172C6DB06DB8BBFCCE33C01402E9AF6CCBC8AA665B44C9EF6B53BF555FF
      DBA62A7BEC17545DEA555892519C4BE7FF3D8E4593A1362403453FD861F2655B
      C489B885B1518543214F0AC14B521A02F989CE64F18F7FDC76B4ED1959B73C2E
      E02F9A68F9D2658C4892DDBF7249D87684C0F1EFE8B846ADDC8114F68A2B0CDA
      5CF206D5A6B1CDC942A668345AE4A8416713DB67DD2D37BC2DE3B5E51B4BA743
      DFED4A40CDCC074080C8BF032F6DE9577E8D8DE9A51D0768DED0D1C990E530E4
      6FDABFA72542AC62F8FAE59D4BBC924B742EC0098F2852BBA4E92BF7FBFDCE43
      4D152850619B8A6EAF78D952572085E5E7E44A9C7A68D3F1A458FFB3BBEF460F
      DD67E57764A215340E536B7FACD8C5DD30C669ABBCAB9C78C9E34AB30AB0FBB7
      F45273281654DDEDA8AB78822313BF90EE69BBC61A7264FC894B8909646BE616
      DA2C38335C1A0F3E9AF5F42B8D9266DD682129A60C18F92C1B2F10BEF0764CE0
      4D23F2DE29E990F53A2CC0EC211CD35499BFD1BE8B687A03221065C34083A854
      6FAD55A31BF7AFFACAC67078F6FA5CF0087D080F4B3B0FE99720E1F239CEA791
      4828D86C6BD054959C74B4CC0B72DB52FABD58309714B149C86B12CAE5D9C147
      8512098BC3CBE360C52D700D396DA4E720CEF15A1F9CDA8F3B17A747A7EFB62B
      9701030D5649D8122DA39635C5016B1A95A92F14D884E7056DB6E958B39B791C
      7D922524ED1F72093EA42A2A2685FD162EAEB6E52A845868B5D25B95918996A7
      0EBC8C9E7E4B78C2A753638F6509E4F0ECB58871C9B263032F275DF684EF9E28
      EA6B9583C7B5AAD63198BB2C87FB36BD7D704E853AA1D6E8833744D71C739420
      D7EFCFF0CE34CAB139C763669CA39B08D2DB004E06B3183BCB50020ABF00759B
      DB7AB7AB24130B41748A1C61E4DE6C0D93B292149AB88FCCFBB43ED45EF75FBA
      839FCF0F2E8E4E0E4E2F778E9B9D70F2B815055801E745757D59B25A8AD47A7A
      A429DE7686D540921839360243A62D6E80538CE3B414EB02E223F911CC0765A6
      2BACC3C9A5D4009A1EAFD264928CB0BC2883E1B92C33948BC127BC2C8BA1E624
      E0C6608F2BD4E31545DE2CCECED44CD13D4C8377982DCAB07AEE6DCA2C2B4A03
      9228CA59BD81591CA5813DE4422A62F5310B9CAE375849615CE93F3C4EC648B8
      F30FB74C8853BFAE8B24A9C89C5659ED62D6737B83AA4AC92C929EDDE66A7317
      5179252AE33592E3254183B448B2C812C7D06D0EB5942CA82DDBC922F0976602
      B6439FB5D131DA7569D8C38BFF7D51705F17C64C2595D3420EB9A2C4D47C8AE3
      B9CC3DAE5BACD5EE8D524770F3EB04EB33BC3DEF7E591BBBC2D6259C58E7C7CF
      DF5DECCBB91C47F914F04DEB7F689C7FF7B7330C5D029F3B4A13A14F6A76E1DD
      C51592390C56C447D3087D748D3662F52DA43DB92AFA8B216DD64D771DAF263F
      F08FA7CB57ACF839C29CDCEDECFD78E17E21ADF0CBCDADDFF03284741238258C
      BA32B283B8B4BF0D98F52F337736E77E660540BEA076B788CBBE7B97882BAC07
      0723ABDCA72850D466127431D779A87A9842E7D5077B2AF8C033CA3320E1E0BC
      81AE4C4F1CEF645239DD812C4CD0ED67DC405686971206236BBFD5C0BA80984D
      9DB1D89FD1FD7FE5BBE1A6435CE11F59D49BF027260268BBEC417AB227A7C927
      A99E99C8E98BA3D0564B08FAC29354F83BA223BAF9D35415115DD61836F26E37
      452DA9232DE62E46C2440F747954D38E63D8ED596DA3D23E3A8E03C656E5DAC2
      CC51D2495D41DE183A1F124B5595E6EB08310F005B7008962B2A5F7F6CBF6A1A
      36BF835B37B0726AF7DDC9E072CD7AEA6FA46EED173769CCD19F827A4226555B
      74CF0911835886869D5A9A14D1B5AC7435015483495E650581D720877EE40E29
      EFCB2FB79FC2E5307145806287B5C642AC27CCA2BF6B47902DDD089DBC1A7F04
      5ED090161711B266609262452F64BBE768AC422F00030B0E26498ED3945A713E
      424FB332194903B1A8A5B6BC51E45EC1D2D56FC27C5934A5CB835ECF08D8D9C6
      2767D5E81C95F115C82F3A3F4A93E7F096A2B95472EE18765B885105C2C135DE
      8C03809C388A431FDE565C1C59EEC85229330C17EA2A2E83C3D5D4764376FDAA
      CBA21D607B1EE58C6B790E96D7EE1DE8DB1B6E5628686513E4F801234A3B9E18
      0D2CF7385C95F34212C2244D5659CDC6FA43836573DE65170FD1E09849441026
      E88466DE1E9C40AD9AF45CBFBFA699E95198A9A1EBD0197833DEE9F99F4EB334
      96F8A173447DC96A04CD447E95F00B4CC892CA907CAB15762C1B9E4D26093A9E
      5B492F8A6BB71D6C351191B9C93304B68651024744AD63B782A5CA8195A0499C
      4E9639DC914D7357D81639FA3555BB6538610CAB91BF5AA347A030230AC1E50D
      44E57D241423A64F8A99EE58C99B044082D114BFF2CE7FF3FDEB650BB56F220C
      353ABE3D4C69C5022ED30E75E60AF7FB8264736080658AA5EA2CAD34AF69FBD6
      FA6E4729D6701E5812815458D217C37A9A67081BBBDDDB4EAD7BCADC8BA009B0
      AE208F4FFBC10AEAD9276B5A55D961414DFB2B27E1FF1421A6A29C25576189F7
      51928F16331874B09CB52EC669CB49E4F28CC71FC93499AAA4EAAACFB4D29741
      C907F077914235DFFD46C236DA0366BBCD95105C12D38E82D8009553DF0D329F
      CA83658BA322E1D11D7945205878883636544C45A20259F82B77F4E2332B6457
      99B0DE93CFE58776C595CDA6F58ABA8F88172D559F71908D491BAA961E9AB7CF
      0A22ECC839426D265F3C5BA2DCD41882AD90D6D02DF0A77EE1BAB4C2469613A1
      4B001AF00D0F28F3A183E4CDDD9348CC8A10EF4A0A7343EAE44C6446AE5FC6C5
      1616AE87383251EF835CD266437EC5AB07C111AE98A1A4EBB2ABA789619F10A4
      CD511BA3DFAED5480F486AF6C0E76610732659A5693A28BC2963172979ED0914
      E25C797B5759FAF4DAFE7F650B52927175F3A79D3C76FBC02D3FE4B8FF57B6C0
      6EE23E6573FC75368D6D87C049DCCF460BA4DEFBEE1DF25B7F703F66731421A6
      E0E9BA9B64BB073AFD2807ACA6BBA542225B52AAE36EFD088F85111DCDF83855
      BAABE72B69AC072A0A8F1DE888A87915ADD07A8805DEEB2245FE0A931FDF18AF
      89A7E34DC77EDF794BFCFFFEE7FFF8FF0223F4D3}
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
